"use strict";

/* The online version checks the player's code on the Lean Playground, https://live.lean-lang.org/.
   This file is that backend. It mirrors web/server.py (assemble, locate, interpret, run_level), but
   instead of one Lean process per test it opens one Lean language-server session over a
   websocket, sends ONE file (the player's code, the referee, then every test) and reads the
   verdicts from the diagnostics as Lean publishes them.

   `LiveRunner.run(job, emit, signal)` emits the events the page already understands:
   tests, compile, start, result, skipped, done, fatal. */

const LiveRunner = (() => {
  const PROJECT = "MathlibDemo";                      // the Playground's project with Mathlib
  const SOCKET = `wss://live.lean-lang.org/websocket/${PROJECT}`;
  const ROOT = `file:///${PROJECT}`;                  // the server wants a document inside the project
  const URI = `${ROOT}/LeanCraftGame.lean`;
  const ICONS = { "✅": "pass", "❌": "fail", "❓": "unknown" };
  const SEVERITY = { 1: "error", 2: "warning", 3: "information", 4: "information" };
  const CONNECT_TIMEOUT = 45000;      // ms to get the first answer (the server may be starting Lean)

  /* The file for one submission, and the line range of each segment (1-based, inclusive). */
  function assemble(level, prelude, code, tests) {
    const lines = code.replace(/\n+$/, "").split("\n");
    const imports = lines.filter((l) => /^import\s/.test(l)).map((l) => l.trim());
    const body = lines.map((l) => (/^import\s/.test(l) ? "" : l)).join("\n");
    const head = [...new Set(["import Mathlib.Tactic", ...level.imports, ...imports])].join("\n");
    const segs = [
      ["head", head, null], ["player", body, null], ["prelude", prelude, null],
      ["preamble", level.preamble.join("\n"), null],
      ...level.gates.map((g) => ["gate", g, null]),
      ...level.checks.map((c) => ["check", c.lean, c.message]),
      ...tests.map((t) => ["test", t.src, t.id]),
    ];
    const ranges = [];
    let cur = 1;
    for (const [kind, text, info] of segs) {
      const n = text.split("\n").length;
      ranges.push({ kind, lo: cur, hi: cur + n - 1, info });
      cur += n;
    }
    return { text: segs.map((s) => s[1]).join("\n") + "\n", ranges };
  }

  const locate = (ranges, line) =>   // `line` is 1-based
    ranges.find((r) => r.lo <= line && line <= r.hi) || { kind: "unknown", lo: 1, hi: 1, info: null };

  /* A language-server diagnostic as the page shows it. Columns are in code points, as the
     editor wants them; LSP counts UTF-16 units. */
  function convert(d, range, textLines) {
    const col = (line, ch) => Array.from((textLines[line] || "").slice(0, ch)).length;
    const [a, b] = [d.range.start, d.range.end];
    return {
      severity: SEVERITY[d.severity] || "error", data: d.message, line1: a.line + 1,
      shown: {
        severity: SEVERITY[d.severity] || "error", text: d.message,
        line: a.line + 1 - range.lo + 1, col: col(a.line, a.character),
        endLine: b.line + 1 - range.lo + 1, endCol: col(b.line, b.character),
      },
    };
  }

  /* The compile report: the player's diagnostics, or the problems with the setup. */
  function compileReport(ranges, diags, textLines) {
    const shown = [], problems = [];
    for (const d of diags) {
      const r = locate(ranges, d.range.start.line + 1);
      const m = convert(d, r, textLines);
      if (r.kind === "player") shown.push(m.shown);
      else if (m.severity === "error" && r.kind !== "test")
        problems.push(r.kind === "check" ? `${r.info}\n\nLean says: ${m.data}`
          : r.kind === "gate" ? m.data
          : r.kind === "head" ? `Your imports could not be loaded:\n${m.data}`
          : `The level could not be set up with your code:\n${m.data}`);
    }
    const playerErrors = shown.some((d) => d.severity === "error");
    return { ok: !playerErrors && !problems.length, diagnostics: shown, problems: playerErrors ? [] : problems };
  }

  /* The verdict of one test from the diagnostics in its lines, or null if there is none yet. */
  function verdict(ranges, diags, range) {
    const mine = diags.filter((d) => {
      const l = d.range.start.line + 1;
      return range.lo <= l && l <= range.hi;
    });
    for (const d of mine) {
      if (ICONS[d.message[0]]) {
        const [, ...rest] = d.message.split("\n");
        return { status: ICONS[d.message[0]], detail: rest.map((l) => l.trim()).join("\n") };
      }
    }
    const errors = mine.filter((d) => d.severity === 1).map((d) => d.message);
    return errors.length ? { status: "error", detail: errors.join("\n") } : null;
  }

  /* One Lean session on `file`. Calls `onUpdate({diags, upTo, done})` whenever Lean publishes
     something: `upTo` is the number of lines Lean has completely processed. Resolves with
     why it ended: "closed", "aborted" or the reason given by `onUpdate`'s return value (true
     stops the session). */
  function session(file, onUpdate, signal) {
    return new Promise((resolve, reject) => {
      let ws, diags = [], upTo = 0, done = false, opened = false, finished = false;
      const end = (how, err) => {
        if (finished) return;
        finished = true;
        clearTimeout(watchdog);
        signal.removeEventListener("abort", onAbort);
        try { ws.close(); } catch { /* already closed */ }
        err ? reject(err) : resolve(how);
      };
      const onAbort = () => end("aborted");
      const watchdog = setTimeout(() => end("", new Error(
        "The Lean Playground did not answer. It may be busy or blocking this page; try again in a minute.")),
        CONNECT_TIMEOUT);
      signal.addEventListener("abort", onAbort);
      const send = (m) => ws.send(JSON.stringify({ jsonrpc: "2.0", ...m }));
      try { ws = new WebSocket(SOCKET); } catch (e) { return end("", e); }
      ws.onerror = () => end("", new Error("Could not connect to the Lean Playground (live.lean-lang.org)."));
      ws.onclose = () => end(opened ? "closed" : "", opened ? null : new Error(
        "The Lean Playground closed the connection. It may be busy or blocking this page."));
      ws.onopen = () => send({ id: 0, method: "initialize", params: {
        processId: null, clientInfo: { name: "Lean Craft Game" }, rootPath: `/${PROJECT}`, rootUri: ROOT, capabilities: { textDocument: { publishDiagnostics: {} } } } });
      ws.onmessage = (ev) => {
        let msg;
        try { msg = JSON.parse(ev.data); } catch { return; }
        if (msg.id === 0 && !opened) {
          opened = true;
          clearTimeout(watchdog);
          send({ method: "initialized", params: {} });
          send({ method: "textDocument/didOpen", params: { textDocument: { uri: URI, languageId: "lean4", version: 1, text: file } } });
          return;
        }
        if (msg.method === "textDocument/publishDiagnostics" && msg.params.uri === URI) diags = msg.params.diagnostics;
        else if (msg.method === "$/lean/fileProgress" && msg.params.textDocument.uri === URI) {
          const p = msg.params.processing;
          done = p.length === 0;
          upTo = done ? Infinity : Math.min(...p.map((x) => x.range.start.line));
        } else return;
        if (onUpdate({ diags, upTo, done })) end("stopped");
      };
    });
  }

  /* Run `job = { level, prelude, code, ids, stopOnFail, timeout }`. */
  async function run(job, emit, signal) {
    const { level, prelude, code, stopOnFail, timeout = 60 } = job;
    const chosen = level.tests.map((t, id) => ({ ...t, id })).filter((t) => !job.ids || job.ids.includes(t.id));
    emit("tests", chosen.map((t) => ({ id: t.id, name: t.name, kind: t.kind })));
    let remaining = chosen, compiled = false, compileOk = true, stopped = false;
    const summary = { passed: 0, failed: 0, unknown: 0, errors: 0 };
    const finish = (t, res) => {
      summary[{ pass: "passed", fail: "failed", unknown: "unknown", error: "errors" }[res.status]]++;
      emit("result", { id: t.id, ...res });
    };

    while (remaining.length && !stopped) {
      const { text, ranges } = assemble(level, prelude, code, remaining);
      const lines = text.split("\n");
      const testRange = new Map(ranges.filter((r) => r.kind === "test").map((r) => [r.info, r]));
      const setupEnd = Math.max(...ranges.filter((r) => r.kind !== "test").map((r) => r.hi));
      const settled = new Set();
      let current = null, since = 0, timer = null, timedOut = null, compileAt = null;
      const inner = new AbortController();      // ends this session: the player's Stop, or a test's timeout
      const stop = () => inner.abort();
      signal.addEventListener("abort", stop);

      const startNext = () => {
        const t = remaining.find((x) => !settled.has(x.id));
        if (!t || current === t) return;
        current = t;
        since = Date.now();
        emit("start", { id: t.id });
        clearTimeout(timer);
        timer = setTimeout(() => { timedOut = t; stop(); }, timeout * 1000);
      };

      await session(text, ({ diags, upTo, done }) => {
        if (!compiled) {
          // the setup is complete once Lean is past it and has had a moment to publish
          if (upTo >= setupEnd) {
            compileAt ??= Date.now();
            if (!done && Date.now() - compileAt < 300) return false;
            compiled = true;
            const report = compileReport(ranges.filter((r) => r.kind !== "test"), diags, lines);
            emit("compile", report);
            if (!report.ok) { compileOk = false; return true; }
          } else return false;
        }
        startNext();
        for (const t of remaining) {
          if (settled.has(t.id)) continue;
          const range = testRange.get(t.id);
          const v = verdict(ranges, diags, range);
          if (v) {
            settled.add(t.id);
            finish(t, { ...v, seconds: Math.round((Date.now() - since) / 100) / 10, cached: false });
            if (stopOnFail && (v.status === "fail" || v.status === "error")) {
              stopped = true;
              for (const o of remaining) if (!settled.has(o.id)) emit("skipped", { id: o.id });
              return true;
            }
            current = null;
            startNext();
          } else if (done) {
            settled.add(t.id);
            finish(t, { status: "error", detail: "The referee produced no verdict.", seconds: 0, cached: false });
          }
        }
        return done;
      }, inner.signal).finally(() => { clearTimeout(timer); signal.removeEventListener("abort", stop); });
      if (signal.aborted) return;
      if (!compileOk) return;
      // Lean cannot interrupt one command, so after a timeout the session is dropped and the
      // run goes on without that test. The Playground may also end a session itself (a
      // limit on time or memory): the test that was running then gets the blame.
      const lost = timedOut || (remaining.some((x) => !settled.has(x.id)) && !stopped ? current : null);
      if (lost) {
        settled.add(lost.id);
        const secs = Math.round((Date.now() - since) / 100) / 10;
        const why = timedOut ? `within ${timeout} s` : "in the time the Lean Playground allows";
        finish(lost, lost.kind === "expect_open"
          ? { status: "pass", seconds: secs, cached: false, detail: `(the referee could not settle it ${why}, as expected)` }
          : { status: "unknown", seconds: secs, cached: false,
              detail: timedOut ? `The referee ran out of time (${timeout} s).`
                : "The Lean Playground ended the session while the referee was working on this test (a limit on time or memory)." });
        remaining = remaining.filter((x) => !settled.has(x.id));
        continue;
      }
      if (remaining.some((x) => !settled.has(x.id)) && !stopped)
        throw new Error("The Lean Playground closed the connection before the tests started.");
      break;
    }
    emit("done", { total: chosen.length, ...summary, stopped });
  }

  return { run, assemble, compileReport, verdict, locate };
})();

if (typeof module !== "undefined") module.exports = LiveRunner;

"use strict";

/* ------------------------------------------------------------ helpers */

const $ = (id) => document.getElementById(id);
const esc = (s) => s.replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]);

const store = {
  get(key, fallback) {
    try { const v = localStorage.getItem("defgame." + key); return v === null ? fallback : JSON.parse(v); }
    catch { return fallback; }
  },
  set(key, value) {
    try { localStorage.setItem("defgame." + key, JSON.stringify(value)); } catch { /* private mode */ }
  },
};

/* A small Markdown subset for the level text: headings, lists, quotes, `code`, **bold**, *italic*. */
function inline(s) {
  return s.split("`").map((part, i) => i % 2
    ? `<code>${esc(part)}</code>`
    : esc(part).replace(/\*\*(.+?)\*\*/g, "<b>$1</b>").replace(/\*(\S.*?)\*/g, "<i>$1</i>")).join("");
}
function markdown(text) {
  const out = [];
  let para = [], list = [], quote = [], code = null;
  const flush = () => {
    if (para.length) out.push(`<p>${inline(para.join(" "))}</p>`);
    if (list.length) out.push(`<ul>${list.map((l) => `<li>${inline(l)}</li>`).join("")}</ul>`);
    if (quote.length) out.push(`<blockquote>${inline(quote.join(" "))}</blockquote>`);
    para = []; list = []; quote = [];
  };
  for (const line of text.split("\n")) {
    let m;
    if (line.startsWith("```")) {
      if (code) { out.push(`<pre class="hl">${highlight(code.join("\n"))}</pre>`); code = null; }
      else { flush(); code = []; }
    } else if (code) code.push(line);
    else if (!line.trim()) flush();
    else if ((m = /^(#{1,3})\s+(.*)/.exec(line))) { flush(); out.push(`<h${m[1].length}>${inline(m[2])}</h${m[1].length}>`); }
    else if ((m = /^[*-]\s+(.*)/.exec(line))) { if (para.length || quote.length) flush(); list.push(m[1]); }
    else if (list.length && /^\s+/.test(line)) list[list.length - 1] += " " + line.trim();
    else if (/^\s{2,}/.test(line)) { if (para.length) flush(); quote.push(line.trim()); }
    else { if (list.length) flush(); para.push(line.trim()); }
  }
  flush();
  return out.join("\n");
}

/* ------------------------------------------------------------ math in test names */

/* Test names quote Lean functions such as `(fun n => n % 2)`. Show them in the usual
   notation, n ↦ n mod 2, typeset by MathJax; until MathJax has loaded (or if it cannot
   load), a plain-text version is shown. */

const BLACKBOARD = { "ℕ": "\\mathbb{N}", "ℤ": "\\mathbb{Z}", "ℚ": "\\mathbb{Q}", "ℝ": "\\mathbb{R}" };

/* A Lean arithmetic expression as { tex, plain }. */
function exprToMath(e) {
  e = e.trim();
  for (let prev = null; prev !== e; ) {              // drop casts and type ascriptions
    prev = e;
    e = e.replace(/\(([^():]+?)\s*:\s*[^():]+\)/g, "($1)").replace(/\((\w+)\)/g, "$1");
  }
  const m = /^if (.+?) then (.+?) else (.+)$/.exec(e);
  if (m) {
    const [c, a, b] = [exprToMath(m[1]), exprToMath(m[2]), exprToMath(m[3])];
    return { tex: `\\begin{cases} ${a.tex} & \\text{if } ${c.tex} \\\\ ${b.tex} & \\text{otherwise} \\end{cases}`,
             plain: `(${a.plain} if ${c.plain}, else ${b.plain})` };
  }
  const product = (s, op) => s.replace(/(\d+) \* (\w)/g, "$1$2").replace(/ \* /g, op);
  let tex = product(e, " \\cdot ").replace(/ % /g, " \\bmod ")
    .replace(/≤/g, "\\le").replace(/≥/g, "\\ge").replace(/≠/g, "\\ne")
    .replace(/[ℕℤℚℝ]/g, (c) => BLACKBOARD[c]);
  const plain = product(e, " · ").replace(/ % /g, " mod ");
  return { tex, plain };
}

/* `fun x => body` (or `fun x : T => body`) as { tex, plain }, or null. */
function funToMath(s) {
  const m = /^fun\s+(\w+|_)\s*(?::[^=]*)?=>\s*([\s\S]+)$/.exec(s.trim());
  if (!m) return null;
  const v = m[1] === "_" ? "n" : m[1], body = exprToMath(m[2]);
  return { tex: `${v} \\mapsto ${body.tex}`, plain: `${v} ↦ ${body.plain}` };
}

const mathCache = {};
function texToHtml(tex, plain) {
  if (!window.MathJax?.tex2chtml) return `<span class="math-plain">${esc(plain)}</span>`;
  if (!(tex in mathCache)) {
    try {
      mathCache[tex] = MathJax.tex2chtml(tex, { display: false }).outerHTML;
      const sheet = MathJax.chtmlStylesheet();
      if (!sheet.isConnected) document.head.appendChild(sheet);
    } catch {
      mathCache[tex] = `<span class="math-plain">${esc(plain)}</span>`;
    }
  }
  return mathCache[tex];
}

/* A test name as HTML, with every `(fun …)` shown as mathematics. */
function nameToHtml(name) {
  let out = "", i = 0;
  while (i < name.length) {
    if (name.startsWith("(fun ", i)) {
      let depth = 0, j = i;
      for (; j < name.length; j++) {
        if (name[j] === "(") depth++;
        else if (name[j] === ")" && --depth === 0) break;
      }
      const f = funToMath(name.slice(i + 1, j));
      if (f && j < name.length) {
        out += texToHtml(`\\left(${f.tex}\\right)`, `(${f.plain})`);
        i = j + 1;
        continue;
      }
    }
    out += esc(name[i++]);
  }
  return out;
}

/* ------------------------------------------------------------ editor */

/* Lean's backslash abbreviations (a subset of the VS Code extension's table). */
const ABBREV = {
  "to": "→", "->": "→", "r": "→", "imp": "→", "l": "←", "<-": "←", "iff": "↔", "<->": "↔", "=>": "⇒",
  "forall": "∀", "all": "∀", "exists": "∃", "ex": "∃", "and": "∧", "or": "∨", "not": "¬", "neg": "¬",
  "ne": "≠", "neq": "≠", "le": "≤", "<=": "≤", "leq": "≤", "ge": "≥", ">=": "≥", "geq": "≥",
  "N": "ℕ", "nat": "ℕ", "Z": "ℤ", "Q": "ℚ", "R": "ℝ", "C": "ℂ",
  "fun": "λ", "lam": "λ", "x": "×", "times": "×", "circ": "∘", "comp": "∘", "o": "∘",
  "in": "∈", "notin": "∉", "sub": "⊆", "subset": "⊂", "cap": "∩", "cup": "∪", "empty": "∅",
  "inv": "⁻¹", "-1": "⁻¹", "<": "⟨", ">": "⟩", ".": "·", "cdot": "·", "|": "∣", "mid": "∣",
  "mapsto": "↦", "|->": "↦", "top": "⊤", "bot": "⊥", "sum": "∑", "prod": "∏", "infty": "∞",
  "a": "α", "alpha": "α", "b": "β", "beta": "β", "g": "γ", "gamma": "γ", "d": "δ", "delta": "δ",
  "e": "ε", "epsilon": "ε", "mu": "μ", "pi": "π", "sigma": "σ", "phi": "φ", "G": "Γ",
  "^2": "²", "^3": "³", "u": "↑",
};
for (let i = 0; i <= 9; i++) ABBREV["_" + i] = "₀₁₂₃₄₅₆₇₈₉"[i];
const NAMES = Object.keys(ABBREV);

const src = $("src"), hl = $("hl"), gutter = $("gutter"), marks = $("marks");
let expanding = false;
let diagnostics = [];

const TOKEN = /(\/-[\s\S]*?(?:-\/|$)|--[^\n]*)|("(?:[^"\\\n]|\\.)*"?)|\b(sorry)\b|\b(def|structure|namespace|end|where|fun|theorem|lemma|abbrev|open|by|if|then|else|let|match|with|instance|class|example|deriving|import|variable|section|noncomputable)\b|\b(Prop|Type|Nat|Int|Bool|Fin|True|False)\b|([∀∃λ→↔∧∨¬≤≥≠⟨⟩×∣∘∈∉⊆∅↑ℕℤℚℝ])|(\b\d+\b)/g;
const CLASSES = [null, "com", "str", "sorry", "kw", "ty", "sym", "num"];

function highlight(text) {
  let html = "", last = 0;
  for (const m of text.matchAll(TOKEN)) {
    html += esc(text.slice(last, m.index));
    const k = m.findIndex((g, i) => i > 0 && g !== undefined);
    html += `<span class="${CLASSES[k]}">${esc(m[0])}</span>`;
    last = m.index + m[0].length;
  }
  return html + esc(text.slice(last)) + "\n";
}

function render() {
  const text = src.value;
  hl.innerHTML = highlight(text);
  const n = text.split("\n").length;
  const sev = {};
  for (const d of diagnostics)
    for (let l = d.line; l <= Math.max(d.line, d.endLine); l++)
      if (sev[l] !== "err") sev[l] = d.severity === "error" ? "err" : "warn";
  gutter.innerHTML = Array.from({ length: n }, (_, i) =>
    sev[i + 1] ? `<span class="${sev[i + 1]}">${i + 1}</span>` : String(i + 1)).join("\n");
  marks.innerHTML = Object.entries(sev).filter(([l]) => l <= n).map(([l, s]) =>
    `<div class="${s}" style="top: calc(var(--pad) + ${l - 1} * var(--lh))"></div>`).join("");
}

/* Replace el.value[start, end) with `s`, keeping the browser's undo history when possible. */
function replaceRange(el, start, end, s, caret) {
  expanding = true;
  el.focus();
  el.setSelectionRange(start, end);
  if (!document.execCommand("insertText", false, s)) el.setRangeText(s, start, end, "end");
  expanding = false;
  if (caret !== undefined) el.setSelectionRange(caret, caret);
}

/* The `\name` being typed just before position `pos`, if any. */
function pending(el, pos) {
  const m = /\\([^\s\\]*)$/.exec(el.value.slice(Math.max(0, pos - 12), pos));
  return m ? { start: pos - m[0].length, name: m[1] } : null;
}
function expandAt(el, pos) {
  const p = pending(el, pos);
  if (!p || !ABBREV[p.name]) return false;
  replaceRange(el, p.start, pos, ABBREV[p.name]);
  return true;
}

/* Turn `\name` into symbols while typing in `el`. `onChange` runs after every edit.
   Only a textarea gets Tab-indentation, auto-indent and Ctrl+Enter (`onRun`). */
function attachAbbrev(el, onChange, onRun) {
  const multiline = el.tagName === "TEXTAREA";
  el.addEventListener("input", (e) => {
    if (!expanding && e.inputType === "insertText" && e.data) {
      const pos = el.selectionStart;
      const ch = e.data[e.data.length - 1];
      if (/\s/.test(ch)) {
        const p = pending(el, pos - 1);
        if (p && ABBREV[p.name]) {
          const sym = ABBREV[p.name];
          replaceRange(el, p.start, pos - 1, sym, p.start + sym.length + 1);
        }
      } else {
        const p = pending(el, pos);
        if (p && p.name) {
          const longer = NAMES.some((n) => n !== p.name && n.startsWith(p.name));
          if (ABBREV[p.name] && !longer) replaceRange(el, p.start, pos, ABBREV[p.name]);
          else if (!NAMES.some((n) => n.startsWith(p.name))) {
            const sym = ABBREV[p.name.slice(0, -1)];
            if (sym) replaceRange(el, p.start, pos - 1, sym, p.start + sym.length + 1);
          }
        }
      }
    }
    onChange();
  });

  el.addEventListener("keydown", (e) => {
    if (e.key === "Enter" && (e.ctrlKey || e.metaKey) && onRun) {
      e.preventDefault();
      onRun();
    } else if (e.key === "Tab" && !e.shiftKey && !e.ctrlKey && !e.altKey) {
      if (expandAt(el, el.selectionStart)) e.preventDefault();
      else if (multiline) { e.preventDefault(); replaceRange(el, el.selectionStart, el.selectionEnd, "  "); }
    } else if (e.key === "Enter" && !e.shiftKey && !e.altKey) {
      // finish a pending abbreviation; in the editor also keep the current line's indentation
      if (multiline) e.preventDefault();
      const done = expandAt(el, el.selectionStart);
      if (multiline) {
        const pos = el.selectionStart;
        const lineStart = el.value.lastIndexOf("\n", pos - 1) + 1;
        const indent = /^[ \t]*/.exec(el.value.slice(lineStart, pos))[0];
        replaceRange(el, pos, el.selectionEnd, "\n" + indent);
        onChange();
      } else if (done) onChange();
    }
  });
}

attachAbbrev(src, () => {
  diagnostics = [];
  render();
  store.set(`draft.${level.id}`, src.value);
  renderTests();
  updateSummary();
}, () => runTests());

/* Select a (1-based line, 0-based codepoint column) range from a Lean message. */
function jumpTo(d) {
  const lines = src.value.split("\n");
  const offset = (line, col) => {
    let o = 0;
    for (let i = 0; i < Math.min(line - 1, lines.length); i++) o += lines[i].length + 1;
    return o + Array.from(lines[line - 1] || "").slice(0, col).join("").length;
  };
  src.focus();
  src.setSelectionRange(offset(d.line, d.col), offset(d.endLine, d.endCol));
}

/* ------------------------------------------------------------ levels */

let levels = [], level = null;

async function loadLevels() {
  levels = await (await fetch("/api/levels")).json();
  const want = Number(new URLSearchParams(location.search).get("level")) || store.get("level", 1);
  await openLevel(levels.some((l) => l.id === want) ? want : levels[0].id);
}

function renderTabs() {
  const cleared = store.get("cleared", []);
  let html = "", world = null;
  for (const l of levels) {
    if (l.world !== world) { world = l.world; html += `<span class="world-label">${esc(world)}</span>`; }
    html += `<button class="level-tab${l.id === level.id ? " active" : ""}" data-id="${l.id}"
      title="Level ${l.num} · ${esc(l.title)} (${esc(l.skill)})"><span class="num">${l.num}</span>
      <span class="ttl">${esc(l.title)}</span>${cleared.includes(l.id) ? '<span class="done" title="cleared">✓</span>' : ""}</button>`;
  }
  $("levels").innerHTML = html;
  for (const b of $("levels").querySelectorAll("button"))
    b.onclick = () => openLevel(Number(b.dataset.id));
}

async function openLevel(id) {
  stopRun();
  level = await (await fetch(`/api/levels/${id}`)).json();
  store.set("level", id);
  history.replaceState(null, "", `?level=${id}`);
  document.title = `DefGame · ${level.title}`;
  renderTabs();
  $("intro").innerHTML = markdown(level.intro);
  src.value = store.get(`draft.${id}`, level.template);
  diagnostics = [];
  render();
  $("diagnostics").innerHTML = "";
  resetReport();
}

$("reset").onclick = () => {
  if (src.value !== level.template && !confirm("Discard your changes and restore the original file?")) return;
  src.value = level.template;
  store.set(`draft.${level.id}`, src.value);
  diagnostics = [];
  render();
  renderTests();
  updateSummary();
};

/* ------------------------------------------------------------ report */

/* Each test remembers the code its result was computed for (`t.code`). A result only
   counts while the editor holds exactly that code; after an edit it is shown as
   undefined. A level is cleared when every test has passed on the same code. */

const KIND = {
  expect_true: "should hold", expect_false: "should fail", expect_open: "should stay open",
  expect_model: "should be a model", expect_not_model: "should not be a model",
};
const ICON = { pass: "✅", fail: "❌", unknown: "❓", error: "⚠️" };
let tests = [], ticker = null, controller = null;
let setupReady = true;     // false while the app is still installing Lean and Mathlib

/* The state to show: a finished result for other code is undefined ("waiting"). */
function view(t) {
  if (t.state === "running" || t.state === "queued") return t.state;
  return t.code === src.value ? t.state : "waiting";
}

function saveResults() {
  const keep = {};
  for (const t of tests)
    if (ICON[t.state]) keep[t.name] = { state: t.state, detail: t.detail, seconds: t.seconds, cached: t.cached, code: t.code };
  store.set(`results.${level.id}`, keep);
}

function resetReport() {
  const saved = store.get(`results.${level.id}`, {});
  tests = level.tests.map((t) => ({ ...t, state: "waiting", ...(saved[t.name] || {}) }));
  renderTests();
  updateSummary();
}

function setSummary(cls, html) {
  $("summary").className = "summary " + cls;
  $("summary").innerHTML = html;
}

function hintFor(name) {
  const h = level.hints.find((h) => name.includes(h.match));
  return h ? h.hint : null;
}

function renderTests() {
  const busy = controller !== null || !setupReady;
  $("tests").innerHTML = tests.map((t) => {
    const v = view(t);
    let icon = "○", time = "", title = "not run on the current code";
    if (v === "running") { icon = '<span class="spin"></span>'; time = ((Date.now() - t.started) / 1000).toFixed(0) + " s"; title = "running"; }
    else if (v === "queued") { icon = '<span class="spin idle"></span>'; title = "waiting for a free slot"; }
    else if (ICON[v]) { icon = ICON[v]; time = t.cached ? "cached" : t.seconds + " s"; title = ""; }
    else if (v === "skipped") { icon = "–"; title = "not run: the run stopped at the first failure"; }
    const shown = ICON[v] || v === "skipped";
    const hint = (v === "fail" || v === "unknown") && hintFor(t.name);
    return `<li class="test ${v}">
      <div class="row"><span class="icon" title="${title}">${icon}</span><span class="name">${nameToHtml(t.name)}</span>
        <span class="kind">${KIND[t.kind] || ""}</span><span class="time">${time}</span>
        <button class="run1" data-id="${t.id}" title="Run only this test on the current code"${busy ? " disabled" : ""}>▶</button></div>
      ${shown && t.detail ? `<div class="detail">${esc(t.detail)}</div>` : ""}
      ${hint ? `<details><summary>Hint</summary>${inline(hint)}</details>` : ""}
    </li>`;
  }).join("");
  for (const b of $("tests").querySelectorAll("button.run1"))
    b.onclick = () => runTests([Number(b.dataset.id)]);
}

/* The summary box, from the results that hold for the current code. */
function updateSummary(note = "") {
  if (controller) return;
  const vs = tests.map(view), total = tests.length;
  const n = (s) => vs.filter((v) => v === s).length;
  const passed = n("pass"), failed = n("fail") + n("error");
  const stale = tests.some((t) => ICON[t.state] && t.code !== src.value);
  const line = `<div class="score">${passed}/${total} passed on this code</div>`;
  const pre = note ? note + "<br>" : "";
  if (passed === total) {
    const cleared = store.get("cleared", []);
    if (!cleared.includes(level.id)) { store.set("cleared", [...cleared, level.id]); renderTabs(); }
    const next = levels[levels.findIndex((l) => l.id === level.id) + 1];
    setSummary("cleared", `🏆 <b>Level cleared!</b> Every test passed on this code.${line}` +
      (next ? `<button class="primary" id="next">Next: ${esc(next.title)} →</button>` : "You have cleared the last level."));
    if (next) $("next").onclick = () => openLevel(next.id);
  } else if (failed) {
    setSummary("failed", `${pre}🔁 <b>Not yet.</b> Read the ❌ test below: it tells you what your
      definition gets wrong.${line}`);
  } else if (passed || n("unknown")) {
    setSummary("", `${pre}${line}${n("unknown") ? `${n("unknown")} could not be settled. ` : ""}
      Press <b>Run tests</b> to run the rest, or ▶ to run a single test.`);
  } else {
    setSummary("muted", pre + (stale
      ? "Your code changed since the last run, so the earlier results no longer apply. Press <b>Run tests</b>."
      : "Write your definition, then press <b>Run tests</b>."));
  }
}

function progress(ids) {
  const done = ids.filter((i) => ICON[tests[i].state] || tests[i].state === "skipped").length;
  const what = ids.length === 1 ? "1 test" : `${ids.length} tests`;
  setSummary("", `Running ${what}… ${done}/${ids.length} done
    <div class="progress"><div style="width:${(100 * done) / ids.length}%"></div></div>`);
}

function showCompile(c) {
  diagnostics = c.diagnostics;
  render();
  $("diagnostics").innerHTML = c.diagnostics.map((d, i) =>
    `<button class="diag ${d.severity}" data-i="${i}"><span class="where">${d.severity === "error" ? "Error" : "Warning"} on line ${d.line}</span>${esc(d.text)}</button>`).join("") +
    c.problems.map((p) => `<div class="diag error">${inline(p)}</div>`).join("");
  for (const b of $("diagnostics").querySelectorAll("button.diag"))
    b.onclick = () => jumpTo(c.diagnostics[Number(b.dataset.i)]);
}

/* Run the tests `ids` (all of them when null) on the current code. A full run stops at
   the first failure; a single test always runs to the end. */
async function runTests(ids = null) {
  if (!setupReady) return;
  stopRun();
  const code = src.value, ctl = (controller = new AbortController());
  let run = [], outcome = null;
  $("run").hidden = true;
  $("stop").hidden = false;
  $("diagnostics").innerHTML = "";
  ticker = setInterval(() => tests.some((t) => t.state === "running") && renderTests(), 1000);
  const handle = (event, data) => {
    if (event === "tests") {
      run = data.map((t) => t.id);
      for (const i of run) Object.assign(tests[i], { state: "queued", code, detail: "", cached: false });
      setSummary("", '<span class="spin"></span> Compiling your code…');
    } else if (event === "compile") {
      showCompile(data);
      if (!data.ok) {
        for (const i of run) Object.assign(tests[i], { state: "waiting", code: undefined });
        outcome = "Your code does not compile yet, or does not fit the level. Fix the problems shown below the editor.";
      } else progress(run);
    } else if (event === "start") {
      Object.assign(tests[data.id], { state: "running", started: Date.now() });
    } else if (event === "result") {
      Object.assign(tests[data.id], { state: data.status, detail: data.detail, seconds: data.seconds, cached: data.cached, code });
      progress(run);
    } else if (event === "skipped") {
      Object.assign(tests[data.id], { state: "skipped", detail: "", code });
    } else if (event === "done") {
      outcome = data.stopped ? "Stopped at the first failure: the remaining tests were not run." : "";
    } else if (event === "fatal") {
      outcome = `The server hit an error: ${esc(data.message)}`;
    }
    renderTests();
  };
  try {
    const res = await fetch(`/api/levels/${level.id}/run`, {
      method: "POST", signal: ctl.signal,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ code, tests: ids, stopOnFail: ids === null }),
    });
    const reader = res.body.pipeThrough(new TextDecoderStream()).getReader();
    let buf = "";
    for (;;) {
      const { value, done } = await reader.read();
      if (done) break;
      buf += value;
      let i;
      while ((i = buf.indexOf("\n\n")) >= 0) {
        const chunk = buf.slice(0, i);
        buf = buf.slice(i + 2);
        const ev = /^event: (.*)$/m.exec(chunk), data = /^data: (.*)$/m.exec(chunk);
        if (ev && data) handle(ev[1], JSON.parse(data[1]));
      }
    }
  } catch (err) {
    if (err.name !== "AbortError") outcome = `Lost contact with the server (${esc(String(err))}). Is <code>web/server.py</code> still running?`;
  }
  if (controller !== ctl) return;           // superseded or stopped
  if (outcome === null) outcome = "The run ended unexpectedly. Check the server's terminal.";
  endRun();
  saveResults();
  renderTests();
  updateSummary(outcome);
}

function endRun() {
  clearInterval(ticker);
  controller = null;
  $("run").hidden = false;
  $("stop").hidden = true;
}

function stopRun() {
  if (!controller) return;
  controller.abort();
  endRun();
  tests.forEach((t) => { if (t.state === "running" || t.state === "queued") Object.assign(t, { state: "waiting", code: undefined }); });
  if (level) {
    renderTests();
    updateSummary("Stopped.");
  }
}


/* ------------------------------------------------------------ symbols drawer */

/* symbol, keys to type (the first one is the usual), meaning, ASCII alternative */
const SYMBOLS = [
  ["∀", ["\\forall", "\\all"], "for all", "forall"],
  ["∃", ["\\exists", "\\ex"], "there exists", "exists"],
  ["→", ["\\to", "\\r"], "implies, or function arrow", "->"],
  ["↔", ["\\iff"], "if and only if", "<->"],
  ["∧", ["\\and"], "and", "/\\"],
  ["∨", ["\\or"], "or", "\\/"],
  ["¬", ["\\not", "\\neg"], "not", "Not p"],
  ["≤", ["\\le", "\\leq"], "less than or equal", "<="],
  ["≥", ["\\ge", "\\geq"], "greater than or equal", ">="],
  ["≠", ["\\ne", "\\neq"], "not equal", "¬ a = b"],
  ["ℕ", ["\\N", "\\nat"], "natural numbers", "Nat"],
  ["ℤ", ["\\Z"], "integers", "Int"],
  ["ℚ", ["\\Q"], "rational numbers", "Rat"],
  ["ℝ", ["\\R"], "real numbers", "Real"],
  ["↑", ["\\u"], "cast (Lean shows it; you write (n : ℤ))", ""],
  ["∈", ["\\in"], "is an element of", ""],
  ["∉", ["\\notin"], "is not an element of", "¬ x ∈ s"],
  ["⊆", ["\\sub"], "is a subset of", ""],
  ["∅", ["\\empty"], "the empty set", ""],
  ["∣", ["\\|", "\\mid"], "divides (not the keyboard bar)", ""],
  ["α", ["\\a", "\\alpha"], "a type variable", ""],
  ["ε", ["\\e", "\\epsilon"], "epsilon", ""],
  ["₀ ₁ ₂", ["\\_0", "\\_1", "\\_2"], "subscripts, as in Group₂", ""],
];
const PRIMARY = {};
for (const [sym, keys] of SYMBOLS) if (sym.length === 1) PRIMARY[sym] = keys[0];
for (let i = 0; i <= 9; i++) PRIMARY["₀₁₂₃₄₅₆₇₈₉"[i]] = "\\_" + i;

const DRILL = ["→", "∀", "∃", "∧", "∨", "¬", "≤", "≥", "≠", "ℕ", "x₁",
  "∀ n, n ≤ 5", "∃ n, n ≠ 0 ∧ n ≥ 1", "¬ (p ∨ q)", "Nat → Nat",
  "∀ n, 5 ≤ n → 3 ≤ u n", "∀ M, ∃ N, ∀ n ≥ N, M ≤ u n",
  "ℤ", "x ∈ s", "3 ∣ 12", "{α : Type*}", "∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε"];
let drillAt = 0;

function drillHelp(goal) {
  const keys = [...new Set([...goal].filter((c) => PRIMARY[c]))].map((c) => `<code>${esc(PRIMARY[c])}</code> → ${c}`);
  return keys.length ? keys.join(" · ") + " (then press space)" : "";
}

function renderDrill() {
  const done = store.get("symbolsDone", []);
  if (drillAt >= DRILL.length) {
    $("drill").innerHTML = `<p class="drill-ok">🎉 You can type every symbol of the game.</p>
      <button id="drill-restart">Practise again</button>`;
    $("drill-restart").onclick = () => { drillAt = 0; renderDrill(); };
    return;
  }
  const goal = DRILL[drillAt];
  $("drill").innerHTML = `
    <div class="drill-count">Exercise ${drillAt + 1} of ${DRILL.length}</div>
    <div class="drill-goal">${esc(goal)}</div>
    <div class="drill-help">${drillHelp(goal)}</div>
    <input id="drill-input" spellcheck="false" autocomplete="off" autocapitalize="off" placeholder="Type it here">
    <div class="drill-row"><span id="drill-status" class="muted"></span>
      <button id="drill-skip" class="quiet">Skip</button></div>`;
  const input = $("drill-input");
  let solved = false;
  attachAbbrev(input, () => {
    if (!solved && input.value.trim() === goal) {
      solved = true;
      $("drill-status").textContent = "✅ Correct!";
      store.set("symbolsDone", [...new Set([...done, goal])]);
      setTimeout(() => { drillAt++; renderDrill(); }, 500);
    } else $("drill-status").textContent = "";
  });
  $("drill-skip").onclick = () => { drillAt++; renderDrill(); };
  if (!$("symbols").hidden) input.focus();
}

function buildSymbols() {
  $("symtable").innerHTML = SYMBOLS.map(([sym, keys, meaning, ascii], i) => `
    <button class="sym-row" data-i="${i}" title="Insert into the editor">
      <span class="sym-char">${esc(sym)}</span>
      <span class="sym-keys">${keys.map((k) => `<code>${esc(k)}</code>`).join(" ")}</span>
      <span class="sym-meaning">${esc(meaning)}${ascii ? ` · or <code>${esc(ascii)}</code>` : ""}</span>
    </button>`).join("");
  for (const b of $("symtable").querySelectorAll("button")) {
    b.onclick = () => {
      const sym = SYMBOLS[Number(b.dataset.i)][0].split(" ")[0];
      replaceRange(src, src.selectionStart, src.selectionEnd, sym);
      diagnostics = [];
      render();
      store.set(`draft.${level.id}`, src.value);
      renderTests();
      updateSummary();
    };
  }
  renderDrill();
}

function toggleSymbols(show) {
  $("symbols").hidden = !(show ?? $("symbols").hidden);
  $("symbols-btn").setAttribute("aria-expanded", String(!$("symbols").hidden));
  if (!$("symbols").hidden && $("drill-input")) $("drill-input").focus();
}
$("symbols-btn").onclick = () => toggleSymbols();
$("symbols-close").onclick = () => toggleSymbols(false);
document.addEventListener("keydown", (e) => { if (e.key === "Escape") toggleSymbols(false); });
buildSymbols();

$("run").onclick = () => runTests();

/* ------------------------------------------------------------ app: first-launch setup, quit */

function renderSetup(s) {
  $("setup").hidden = s.ready;
  $("run").disabled = !s.ready;
  $("run").title = s.ready ? "Ctrl+Enter" : "Available once Lean and Mathlib are installed";
  if (s.ready) return;
  $("setup-steps").innerHTML = s.steps.map((name, i) => {
    const icon = i < s.step ? "✅" : i === s.step ? (s.error ? "❌" : '<span class="spin"></span>') : "○";
    return `<li class="${i < s.step ? "done" : i === s.step ? "now" : ""}">${icon} ${esc(name)}</li>`;
  }).join("");
  $("setup-message").textContent = s.message || "";
  const p = s.progress;
  $("setup-bar").parentElement.hidden = !(p && p[1]);
  if (p && p[1]) $("setup-bar").style.width = `${Math.min(100, (100 * p[0]) / p[1]).toFixed(1)}%`;
  $("setup-error").hidden = !s.error;
  $("setup-error").textContent = s.error || "";
  $("setup-retry").hidden = !s.error;
}

async function watchSetup() {
  for (;;) {
    let s = null;
    try { s = await (await fetch("/api/setup")).json(); } catch { /* server restarting */ }
    if (s) {
      $("quit").hidden = !s.app;
      const was = setupReady;
      setupReady = s.ready;
      renderSetup(s);
      if (setupReady !== was && level) renderTests();
      if (s.ready) return;
    }
    await new Promise((r) => setTimeout(r, 700));
  }
}

$("setup-retry").onclick = () => fetch("/api/setup/retry", { method: "POST" });
$("quit").onclick = async () => {
  if (!confirm("Quit DefGame? Your code and progress are kept.")) return;
  stopRun();
  try { await fetch("/api/quit", { method: "POST" }); } catch { /* already gone */ }
  document.body.innerHTML = '<p class="bye">DefGame has stopped. You can close this tab.</p>';
};
setupReady = false;
watchSetup();
$("stop").onclick = stopRun;
loadLevels();

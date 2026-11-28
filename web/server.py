#!/usr/bin/env python3
"""Lean Craft Game in the browser: a local web server that runs the referee on the player's code.

    python3 web/server.py                    serve the game on http://localhost:8000
    python3 web/server.py --run 1 FILE       run level 1 on FILE and print the report

Only the Python standard library is needed. Each test in LeanCraftGame/L<n>/Tests.lean
runs as its own Lean process, with the player's code pasted in, so tests run in
parallel and their verdicts stream to the browser as they arrive.

Run from a checkout, the server uses `lake` to build the referee and find Lean. The
desktop app (app/launcher.py) instead sets LEANCRAFT_ROOT (the game files),
LEANCRAFT_WORK (a writable folder), LEAN_ENV and SETUP itself.
"""
import argparse
import hashlib
import json
import os
import queue
import re
import shutil
import subprocess
import sys
import threading
import time
import uuid
import webbrowser
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

ROOT = Path(os.environ.get("LEANCRAFT_ROOT") or Path(__file__).resolve().parent.parent)
STATIC = (ROOT / "web" / "static").resolve()   # resolved: f.resolve() below must compare equal (macOS /var -> /private/var)
WORK = Path(os.environ.get("LEANCRAFT_WORK") or ROOT / ".lake" / "leancraftgame-web")
RUNS = WORK / "runs"
CACHE_FILE = WORK / "cache.json"
# Levels in the order they are played. The number of a level is the name of its directory
# (LeanCraftGame/L<n>, variants/L<n>), and also the number shown to the player. A world is a
# run of consecutive levels (see "world" in level.json).
LEVELS = sorted(int(d.name[1:]) for d in (ROOT / "LeanCraftGame").glob("L[0-9]*") if d.is_dir())
LEAN_ENV = {}       # environment for running Lean (LEAN, LEAN_PATH, …), see prepare_lean()
# The app's first-launch setup (an object with status() and retry()), or None when the
# server runs from a checkout and Lean is ready from the start.
SETUP = None
UTF8 = {"encoding": "utf-8", "errors": "replace"}
BASE_TIMEOUT = 60   # seconds per test, unless a level asks for more (level.json "timeout")

ICONS = {"✅": "pass", "❌": "fail", "❓": "unknown"}


# ---------------------------------------------------------------- levels

def split_intro(player):
    """Split Player.lean into its opening comment (shown as the level text) and the rest."""
    m = re.match(r"\s*/-(?![-!])(.*?)-/[ \t]*\n?", player, re.S)
    if not m:
        return "", player
    return m.group(1).strip("\n"), player[m.end():].lstrip("\n")


def split_tests(src):
    """Cut Tests.lean into commands: a command starts at column 0, indented lines continue it."""
    src = re.sub(r"/-.*?-/", "", src, flags=re.S)
    cmds = []
    for line in src.splitlines():
        if not line.strip() or re.match(r"\s*--", line):
            continue
        if line[0].isspace() and cmds:
            cmds[-1] += "\n" + line
        else:
            cmds.append(line)
    out = {"imports": [], "preamble": [], "gates": [], "tests": []}
    for c in cmds:
        if c.startswith("import "):
            if not re.match(r"import LeanCraftGame\.L\d+\.Player\s*$", c):
                out["imports"].append(c)
        elif c.startswith("#no_sorry"):
            out["gates"].append(c)
        elif c.startswith(("#level_start", "#level_report")):
            pass
        elif c.startswith("#expect_"):
            m = re.match(r'#(expect_\w+)\s+"((?:[^"\\]|\\.)*)"', c)
            out["tests"].append({"kind": m.group(1), "name": json.loads('"' + m.group(2) + '"'), "src": c})
        else:
            out["preamble"].append(c)
    return out


def strip_namespace(code, ns):
    """The player's code without the `namespace <ns>` … `end <ns>` lines around it.

    Player.lean files keep these lines so that they compile as modules, but the player never
    sees them: the template shown in the editor is the inside, and `assemble` puts them back."""
    lines = code.strip("\n").split("\n")
    if lines and lines[0].strip() == f"namespace {ns}":
        lines = lines[1:]
    if lines and lines[-1].strip() == f"end {ns}":
        lines = lines[:-1]
    return "\n".join(lines).strip("\n") + "\n"


def has_namespace(code, ns):
    """Does the code open the level's namespace itself (a draft saved before the lines were hidden)?"""
    return re.search(rf"^\s*namespace\s+{re.escape(ns)}\s*$", code, re.M) is not None


REF = re.compile(r"\{\{level:([\w-]+)\}\}")


def level_numbers():
    """{slug: number shown to the player}, from the "slug" of every level.json."""
    out = {}
    for n in LEVELS:
        slug = json.loads((ROOT / "LeanCraftGame" / f"L{n}" / "level.json").read_text(encoding="utf-8")).get("slug")
        if slug:
            out[slug] = LEVELS.index(n) + 1
    return out


def resolve_refs(text, numbers):
    """Lessons and hints name other levels as {{level:slug}}; the player sees the number."""
    return REF.sub(lambda m: str(numbers.get(m.group(1), m.group(0))), text)


def load_level(n, numbers=None):
    d = ROOT / "LeanCraftGame" / f"L{n}"
    numbers = numbers if numbers is not None else level_numbers()
    meta = json.loads(resolve_refs((d / "level.json").read_text(encoding="utf-8"), numbers))
    intro, template = split_intro((d / "Player.lean").read_text(encoding="utf-8"))
    intro = resolve_refs(intro, numbers)
    ns = f"L{n}"
    # The imports of Player.lean (the shared library LeanCraftGame.Lib.*, the parts of Mathlib a
    # level needs) are the level's: the player never sees them, and every test file gets them.
    own = [l.strip() for l in re.findall(r"^import \S+[ \t]*$", template, flags=re.M)]
    template = re.sub(r"^import \S+[ \t]*\n", "", template, flags=re.M).lstrip("\n")
    tests = split_tests((d / "Tests.lean").read_text(encoding="utf-8"))
    tests["imports"] = list(dict.fromkeys(tests["imports"] + own))
    # A reading question (`#expect_choice "…" : q1 = 2` on an answer line of `questions`) is
    # graded without Lean: by the browser, and by grade_answer below. The browser gets the
    # key as a hash (answer_hash), so that the level's data does not show the answers.
    asked = {q["answer"]: q for q in meta.get("questions", [])}
    questions = []
    for t in tests["tests"]:
        m = re.search(rf"\s:\s*(?:{ns}\.)?(\w+)\s*=\s*(\d+|true|false)\s*$", t["src"])
        if t["kind"] == "expect_choice" and m and m.group(1) in asked:
            t["answer"], t["key"] = m.group(1), m.group(2)
    keys = {t["answer"]: t for t in tests["tests"] if "answer" in t}
    for q in meta.get("questions", []):
        t = keys.get(q["answer"])
        questions.append(q | ({"test": t["name"], "key": answer_hash(ns, q["answer"], t["key"])} if t else {}))
    if questions:
        meta = meta | {"questions": questions}
    return {**meta, "id": n, "num": LEVELS.index(n) + 1, "intro": intro, "namespace": ns,
            "template": strip_namespace(template, ns), **tests}


def answer_hash(ns, answer, value):
    """FNV-1a (32 bits) of `L3.q1=2`, in hex: the same function as answerHash in app.js."""
    h = 0x811C9DC5
    for b in f"{ns}.{answer}={value}".encode():
        h = ((h ^ b) * 0x01000193) & 0xFFFFFFFF
    return f"{h:08x}"


def answer_of(code, name):
    """The player's answer to a question: the value on the line `def <name> : T := v`, as
    text (`2`, `true`), "sorry" when not answered yet, or None when the line is missing."""
    m = re.search(rf"^def {re.escape(name)} : [^:=\n]+ :=[ \t]*(.*)$", code, re.M)
    return None if m is None else re.sub(r"--.*$", "", m.group(1)).strip()


def grade_answer(lv, t, code):
    """Grade a reading question without Lean: a result, or a problem (str) if unanswered."""
    v = answer_of(code, t["answer"])
    if v is None:
        return f"The line `def {t['answer']} …` is missing. Press Reset to get it back."
    if not re.fullmatch(r"\d+|true|false", v):
        return f"Question `{t['answer']}` has no answer yet."
    if v == t["key"]:
        return {"status": "pass", "detail": "", "seconds": 0}
    return {"status": "fail", "seconds": 0,
            "detail": "Not the right answer. Read the question and the lesson again."}


# What the browser needs to know about a level, besides its tests. `predict`, `public` and
# `hintsAfter` drive the predictions, the hidden tests and the hint gates (see
# validate_level and web/static/app.js).
PUBLIC_KEYS = ("id", "num", "world", "title", "skill", "exercise", "intro", "template", "hints",
               "predict", "public", "hintsAfter", "namespace", "questions", "timeout")

# The kinds of exercise a level can be (level.json "exercise"), shown as a tag above the lesson.
EXERCISES = ("Write", "Read", "Construct", "Refute", "Repair", "Audit")


def tidy(text):
    """A Lean message as the player should read it: without the hidden `L<n>.` namespace."""
    return re.sub(r"(?<![\w.])L\d+\.", "", text)


def public_level(lv):
    return {k: lv[k] for k in PUBLIC_KEYS if k in lv} | {
        "tests": [{"id": i, "name": t["name"], "kind": t["kind"]} for i, t in enumerate(lv["tests"])]}


def validate_level(lv):
    """Problems with a level's metadata (level.json against Tests.lean), as strings.

    * `predict`: [{"test": name, "statement": text}], tests the player must predict before
      the first run. They must be true/false or model tests, not open ones.
    * `public`: "all", or a list of test names shown from the start. Every other test is
      hidden until it fails, or until the level is cleared.
    * `hintsAfter`: failed runs before the first hint unlocks (default 2).
    * hints: {"match", "hint", "steps"?}. The steps come first, one more after each
      failed run, and the `hint` itself last."""
    names = {t["name"]: t["kind"] for t in lv["tests"]}
    out = [f"unknown level reference {r}" for r in REF.findall(json.dumps(lv, ensure_ascii=False))]
    if "exercise" in lv and lv["exercise"] not in EXERCISES:
        out.append(f"exercise must be one of {', '.join(EXERCISES)}")
    for p in lv.get("predict", []):
        if set(p) != {"test", "statement"}:
            out.append(f"predict entry {p} needs exactly the keys `test` and `statement`")
        elif p["test"] not in names:
            out.append(f"predict: no test is called {p['test']!r}")
        elif names[p["test"]] not in ("expect_true", "expect_false", "expect_model", "expect_not_model"):
            out.append(f"predict: {p['test']!r} is an {names[p['test']]} test, which cannot be predicted")
    public = lv.get("public", [])
    if public != "all":
        if not isinstance(public, list):
            out.append('public must be "all" or a list of test names')
        else:
            out += [f"public: no test is called {n!r}" for n in public if n not in names]
    # questions: the answers of a reading level, rendered as buttons that edit the code.
    # {"answer": name of a `def` in the template, "text": the question, "choices": [...]}
    # (with `choices`, the answer is a `Fin k`, the index of the choice; without, a `Bool`)
    for q in lv.get("questions", []):
        if not {"answer", "text"} <= set(q) or set(q) - {"answer", "text", "choices", "test", "key"}:
            out.append(f"question {q} needs `answer` and `text`, and optionally `choices`")
            continue
        ty = f"Fin {len(q['choices'])}" if "choices" in q else "Bool"
        if not re.search(rf"^def {re.escape(q['answer'])} : {ty} :=", lv["template"], re.M):
            out.append(f"question {q['answer']!r}: the template has no line `def {q['answer']} : {ty} := …`")
    if not isinstance(lv.get("timeout", 60), int) or not 60 <= lv.get("timeout", 60) <= 300:
        out.append("timeout must be a number of seconds between 60 and 300")
    if not isinstance(lv.get("hintsAfter", 0), int) or lv.get("hintsAfter", 0) < 0:
        out.append("hintsAfter must be a natural number")
    for h in lv.get("hints", []):
        if "hint" not in h or "match" not in h:
            out.append(f"hint {h} needs `match` and `hint`")
        if not isinstance(h.get("steps", []), list):
            out.append(f"hint {h.get('match')!r}: steps must be a list")
    return out


def assemble(lv, code, extra):
    """Build a Lean file from segments; return its text and the line range of each segment.

    The player's `import` lines move to the head of the file (Lean wants them first);
    they are blanked in place so that line numbers in the player's code stay the same.
    The level's namespace wraps the player's code in segments of their own, unless the
    code already opens it (an old draft that still has the lines)."""
    lines = code.rstrip("\n").split("\n")
    imports = [l.strip() for l in lines if re.match(r"import\s", l)]
    code = "\n".join("" if re.match(r"import\s", l) else l for l in lines)
    ns = lv["namespace"]
    wrap = not has_namespace(code, ns)
    segs = [("head", "\n".join(["import LeanCraftGame.Referee"] + lv["imports"] + imports), None)]
    # `noncomputable section`: a definition over ℝ (with `/`, `Real.sqrt`, …) is accepted
    # as it is; the player is writing specifications, not programs
    segs += [("namespace", f"namespace {ns} noncomputable section", None)] if wrap else []
    segs += [("player", code, None)]
    segs += [("namespace", f"end\nend {ns}", None)] if wrap else []
    segs += [("preamble", "\n".join(lv["preamble"]), None)] + extra
    lines, ranges, cur = [], [], 1
    for kind, text, info in segs:
        n = text.count("\n") + 1
        lines.append(text)
        ranges.append((kind, cur, cur + n - 1, info))
        cur += n
    return "\n".join(lines) + "\n", ranges


def locate(msg, ranges):
    line = (msg.get("pos") or {}).get("line", 0)
    for kind, lo, hi, info in ranges:
        if lo <= line <= hi:
            return kind, lo, info
    return "unknown", 1, None


# ---------------------------------------------------------------- running Lean

class Run:
    """One submission. Cancelling it kills every Lean process it started and ends the
    run; stopping the tests (after a failure) kills them too, but the run still reports."""

    def __init__(self):
        self.id = uuid.uuid4().hex[:12]
        self.dir = RUNS / self.id
        self.cancelled = False
        self.stopped = False
        self.procs = set()
        self.killed = set()
        self.lock = threading.Lock()

    def _kill_all(self):
        for p in self.procs:
            self.killed.add(p)
            try:
                p.kill()
            except OSError:
                pass

    def cancel(self):
        with self.lock:
            self.cancelled = True
            self._kill_all()

    def stop_tests(self):
        with self.lock:
            self.stopped = True
            self._kill_all()

    def lean(self, name, text, timeout):
        """Run `lean --json` on `text`. Returns the messages, or None on timeout or cancel."""
        path = self.dir / f"{name}.lean"
        path.write_text(text, encoding="utf-8")
        with self.lock:
            if self.cancelled or self.stopped:
                return None
            p = subprocess.Popen([LEAN_ENV["LEAN"], "--json", str(path)], cwd=WORK, env=LEAN_ENV,
                                 stdout=subprocess.PIPE, stderr=subprocess.STDOUT, **UTF8,
                                 creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0))
            self.procs.add(p)
        try:
            out, _ = p.communicate(timeout=timeout)
        except subprocess.TimeoutExpired:
            p.kill()
            p.communicate()
            return None
        finally:
            with self.lock:
                self.procs.discard(p)
        if self.cancelled or p in self.killed:
            return None
        msgs = []
        for line in out.splitlines():
            try:
                msgs.append(json.loads(line))
            except ValueError:
                if line.strip():
                    msgs.append({"severity": "error", "data": line, "pos": None})
        return msgs


class Cache:
    """Verdicts keyed by the exact Lean file and the referee version, kept on disk."""

    def __init__(self):
        self.lock = threading.Lock()
        try:
            self.data = json.loads(CACHE_FILE.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            self.data = {}

    @staticmethod
    def key(text):
        h = hashlib.sha256()
        for f in ("lean-toolchain", "lake-manifest.json", "LeanCraftGame/Referee.lean"):
            h.update((ROOT / f).read_bytes())
        h.update(text.encode())
        return h.hexdigest()

    def get(self, key):
        with self.lock:
            return self.data.get(key)

    def put(self, key, value):
        with self.lock:
            self.data[key] = value
            WORK.mkdir(parents=True, exist_ok=True)
            CACHE_FILE.write_text(json.dumps(self.data), encoding="utf-8")


# A declaration of the player's, for "What Lean read": the name after the keyword.
DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+|private\s+|protected\s+)*"
                  r"(?:def|abbrev|statement|theorem|lemma|structure|inductive|class)\s+([^\s:({\[⦃]+)", re.M)


def compile_check(run, lv, code, timeout):
    """Elaborate the player's code with the level's gates and signature checks, and print
    back each of the player's declarations as Lean read it (brackets and numeral types shown)."""
    extra = [("gate", g, None) for g in lv["gates"]]
    extra += [("check", c["lean"], c["message"]) for c in lv.get("checks", [])]
    for name in dict.fromkeys(DECL.findall(code)):
        extra.append(("read", "set_option pp.parens true in\nset_option pp.numericTypes true in\n"
                      f"#print {lv['namespace']}.{name}", name))
    text, ranges = assemble(lv, code, extra)
    msgs = run.lean("check", text, timeout)
    if msgs is None:
        return None
    diags, problems, read = [], [], []
    for m in msgs:
        kind, lo, info = locate(m, ranges)
        sev = m.get("severity", "error")
        if kind == "read":
            if sev == "information":
                read.append({"name": info, "text": tidy(m["data"])[:2000]})
            continue
        if kind == "player":
            pos, end = m.get("pos") or {}, m.get("endPos") or m.get("pos") or {}
            diags.append({"severity": sev, "text": tidy(m["data"]),
                          "line": pos.get("line", lo) - lo + 1, "col": pos.get("column", 0),
                          "endLine": end.get("line", lo) - lo + 1, "endCol": end.get("column", 0)})
        elif sev == "error":
            m = {**m, "data": tidy(m["data"])}
            problems.append(f"{info}\n\nLean says: {m['data']}" if kind == "check" else
                            m["data"] if kind == "gate" else
                            f"Your imports could not be loaded:\n{m['data']}" if kind == "head" else
                            f"The level could not be set up with your code:\n{m['data']}")
    player_errors = any(d["severity"] == "error" for d in diags)
    return {"ok": not player_errors and not problems, "diagnostics": diags,
            "problems": [] if player_errors else problems, "read": read}


def interpret(msgs, ranges):
    """Turn the messages of one test file into a verdict."""
    errors = []
    for m in msgs:
        kind, _, _ = locate(m, ranges)
        data = m.get("data", "")
        if kind == "test" and data[:1] in ICONS:
            first, _, rest = data.partition("\n")
            return {"status": ICONS[data[0]], "detail": tidy("\n".join(l.strip() for l in rest.splitlines()))}
        if m.get("severity") == "error" and kind != "player":
            errors.append(data)
    return {"status": "error", "detail": tidy("\n".join(errors)) or "The referee produced no verdict."}


def run_level(run, n, code, events, jobs, timeout, cache, only=None, stop_on_fail=False):
    """Check and test the player's code, putting (event, data) pairs on `events`.

    `only` restricts the run to these test ids. With `stop_on_fail`, the first test that
    fails (❌, or ⚠ when it cannot even be stated) stops the others; they are reported
    with a `skipped` event."""
    try:
        lv = load_level(n)
        # a level whose tests need longer searches says so (level.json "timeout", in seconds)
        timeout = max(timeout, lv.get("timeout", 0))
        run.dir.mkdir(parents=True, exist_ok=True)
        chosen = [i for i in range(len(lv["tests"])) if only is None or i in only]
        events.put(("tests", [{"id": i, "name": lv["tests"][i]["name"], "kind": lv["tests"][i]["kind"]}
                              for i in chosen]))
        # reading questions first, without Lean
        results = {}
        graded = {i: grade_answer(lv, lv["tests"][i], code) for i in chosen if "answer" in lv["tests"][i]}
        missing = [g for g in graded.values() if isinstance(g, str)]
        if missing:
            events.put(("compile", {"ok": False, "diagnostics": [], "problems": missing}))
            return
        if graded and not [i for i in chosen if i not in graded]:
            events.put(("compile", {"ok": True, "diagnostics": [], "problems": []}))
        for i, res in graded.items():
            results[i] = res
            events.put(("result", {"id": i, **res}))
        rest = [i for i in chosen if i not in graded]
        if not rest or (stop_on_fail and any(r["status"] == "fail" for r in graded.values())):
            for i in rest:
                events.put(("skipped", {"id": i}))
            count = lambda s: sum(r["status"] == s for r in results.values())
            events.put(("done", {"total": len(chosen), "passed": count("pass"), "failed": count("fail"),
                                 "unknown": 0, "errors": 0, "stopped": bool(rest)}))
            return
        chosen = rest
        check = compile_check(run, lv, code, timeout)
        if check is None:
            events.put(("compile", {"ok": False, "diagnostics": [],
                                    "problems": [f"Compiling your code took more than {timeout} s."]}))
            return
        events.put(("compile", check))
        if not check["ok"]:
            return

        slots = threading.Semaphore(jobs)

        def one(i, t):
            text, ranges = assemble(lv, code, [("test", t["src"], None)])
            key = Cache.key(text)
            hit = cache.get(key)
            if hit:
                res = hit | {"cached": True}
            else:
                with slots:
                    if run.cancelled:
                        return
                    if run.stopped:
                        events.put(("skipped", {"id": i}))
                        return
                    events.put(("start", {"id": i}))
                    t0 = time.time()
                    # an open problem passes when time runs out: a level's longer `timeout` is
                    # for its slow searches, and need not make every open test wait for it
                    limit = min(timeout, BASE_TIMEOUT) if t["kind"] == "expect_open" else timeout
                    msgs = run.lean(f"T{i}", text, limit)
                    secs = round(time.time() - t0, 1)
                if run.cancelled:
                    return
                if msgs is None and run.stopped:
                    events.put(("skipped", {"id": i}))
                    return
                if msgs is None and t["kind"] == "expect_open":
                    # an open statement should not be settled, and the referee did not settle it
                    res = {"status": "pass", "seconds": secs,
                           "detail": f"(undecided after {limit} s, as it should be)"}
                elif msgs is None:
                    res = {"status": "unknown", "seconds": secs,
                           "detail": f"The referee ran out of time ({timeout} s)."}
                else:
                    res = interpret(msgs, ranges) | {"seconds": secs}
                    if res["status"] != "error":
                        cache.put(key, res)
            results[i] = res
            events.put(("result", {"id": i, **res}))
            if stop_on_fail and res["status"] in ("fail", "error"):
                run.stop_tests()

        threads = [threading.Thread(target=one, args=(i, lv["tests"][i]), daemon=True) for i in chosen]
        for th in threads:
            th.start()
        for th in threads:
            th.join()
        if run.cancelled:
            return
        count = lambda s: sum(r["status"] == s for r in results.values())
        events.put(("done", {"total": len(chosen) + len(graded), "passed": count("pass"), "failed": count("fail"),
                             "unknown": count("unknown"), "errors": count("error"),
                             "stopped": run.stopped}))
    except Exception as e:  # report instead of leaving the browser waiting
        events.put(("fatal", {"message": f"{type(e).__name__}: {e}"}))
    finally:
        events.put(None)
        shutil.rmtree(run.dir, ignore_errors=True)


# ---------------------------------------------------------------- HTTP

class Handler(BaseHTTPRequestHandler):
    current = None              # the Run in progress; a new submission cancels it
    current_lock = threading.Lock()
    opts = None
    cache = None

    def log_message(self, fmt, *args):
        pass

    def send(self, status, body, ctype="application/json; charset=utf-8"):
        if not isinstance(body, bytes):
            body = json.dumps(body).encode()
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        path = self.path.split("?")[0]
        if path == "/api/setup":
            return self.send(200, SETUP.status() if SETUP else {"ready": True, "app": False})
        if path == "/api/intro":
            return self.send(200, {"markdown": (ROOT / "LeanCraftGame" / "Intro.md").read_text(encoding="utf-8")})
        if path == "/api/levels":
            out, numbers = [], level_numbers()
            for n in LEVELS:
                lv = load_level(n, numbers)
                out.append({k: lv[k] for k in ("id", "num", "world", "title", "skill")})
            return self.send(200, out)
        m = re.fullmatch(r"/api/levels/(\d+)", path)
        if m and int(m.group(1)) in LEVELS:
            return self.send(200, public_level(load_level(int(m.group(1)))))
        name = "index.html" if path == "/" else path.lstrip("/")
        f = (STATIC / name).resolve()
        if STATIC in f.parents and f.is_file():
            types = {".html": "text/html", ".js": "text/javascript", ".css": "text/css", ".svg": "image/svg+xml",
                     ".woff": "font/woff", ".woff2": "font/woff2", ".md": "text/plain"}
            ctype = types.get(f.suffix, "application/octet-stream")
            if ctype.startswith("text/"):
                ctype += "; charset=utf-8"
            return self.send(200, f.read_bytes(), ctype)
        self.send(404, {"error": "not found"})

    def do_POST(self):
        if self.path == "/api/setup/retry" and SETUP:
            SETUP.retry()
            return self.send(200, {"ok": True})
        if self.path == "/api/quit" and SETUP:          # only the app can be quit from the page
            self.send(200, {"ok": True})
            threading.Thread(target=self.server.shutdown, daemon=True).start()
            return
        m = re.fullmatch(r"/api/levels/(\d+)/run", self.path)
        if not m or int(m.group(1)) not in LEVELS:
            return self.send(404, {"error": "not found"})
        if SETUP and not SETUP.status()["ready"]:
            return self.send(503, {"error": "Lean and Mathlib are still being set up."})
        body = json.loads(self.rfile.read(int(self.headers.get("Content-Length", 0))) or b"{}")
        run, events = Run(), queue.Queue()
        with Handler.current_lock:
            if Handler.current:
                Handler.current.cancel()
            Handler.current = run
        threading.Thread(target=run_level, daemon=True,
                         args=(run, int(m.group(1)), body.get("code", ""), events,
                               self.opts.jobs, self.opts.timeout, self.cache,
                               body.get("tests"), bool(body.get("stopOnFail")))).start()
        self.send_response(200)
        self.send_header("Content-Type", "text/event-stream; charset=utf-8")
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        try:
            while True:
                try:
                    ev = events.get(timeout=1)
                except queue.Empty:
                    self.wfile.write(b": ping\n\n")   # also notices a closed tab
                    self.wfile.flush()
                    continue
                if ev is None:
                    break
                self.wfile.write(f"event: {ev[0]}\ndata: {json.dumps(ev[1])}\n\n".encode())
                self.wfile.flush()
        except (BrokenPipeError, ConnectionResetError):
            run.cancel()


# ---------------------------------------------------------------- main

def prepare_lean(build=True):
    """From a checkout: build the referee with lake and ask lake for Lean's environment."""
    if build:
        print("Building the referee and the shared library (lake build LeanCraftGame)…", flush=True)
        r = subprocess.run(["lake", "build", "LeanCraftGame"], cwd=ROOT, capture_output=True, **UTF8)
        if r.returncode != 0:
            sys.exit(f"`lake build LeanCraftGame` failed:\n{r.stdout}{r.stderr}")
    # Ask lake once for LEAN, LEAN_PATH, …: running `lake env` for every test would be
    # slower, and parallel calls can contend for lake's lock.
    r = subprocess.run(["lake", "env"], cwd=ROOT, capture_output=True, check=True, **UTF8)
    LEAN_ENV.update(os.environ)
    LEAN_ENV.update(l.split("=", 1) for l in r.stdout.splitlines() if re.match(r"(LEAN|LAKE|ELAN)\w*=", l))


def clean_old_runs():
    # Each run deletes its own folder when it ends; only clear leftovers from crashed
    # servers here, so that several servers (or --run) can work side by side.
    for d in RUNS.glob("*"):
        if time.time() - d.stat().st_mtime > 3600:
            shutil.rmtree(d, ignore_errors=True)


def serve(port, jobs, timeout, open_browser=False):
    """Serve the game on localhost until Ctrl+C or, in the app, the Quit button."""
    WORK.mkdir(parents=True, exist_ok=True)
    clean_old_runs()
    Handler.opts, Handler.cache = argparse.Namespace(jobs=jobs, timeout=timeout), Cache()
    server = ThreadingHTTPServer(("127.0.0.1", port), Handler)
    server.daemon_threads = True
    url = f"http://localhost:{port}/"
    print(f"Lean Craft Game is running at {url}  (Ctrl+C to stop)", flush=True)
    if open_browser:
        webbrowser.open(url)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()
        if Handler.current:
            Handler.current.cancel()


def cli_run(opts):
    """Run one level on a file and print the report."""
    code = Path(opts.run[1]).read_text(encoding="utf-8")
    events, lv = queue.Queue(), load_level(int(opts.run[0]))
    threading.Thread(target=run_level, daemon=True,
                     args=(Run(), int(opts.run[0]), code, events, opts.jobs, opts.timeout, Cache())).start()
    names = [t["name"] for t in lv["tests"]]
    icon = {"pass": "✅", "fail": "❌", "unknown": "❓", "error": "⚠️"}
    while (ev := events.get()) is not None:
        kind, data = ev
        if kind == "compile":
            for d in data["diagnostics"]:
                print(f"{d['severity']} at line {d['line']}:{d['col']}: {d['text']}")
            for p in data["problems"]:
                print(p)
        elif kind == "result":
            extra = "cached" if data.get("cached") else f"{data['seconds']} s"
            print(f"{icon[data['status']]} {names[data['id']]}   [{extra}]")
            if data["detail"]:
                print("   " + data["detail"].replace("\n", "\n   "))
        elif kind == "done":
            print(f"Score: {data['passed']}/{data['total']} passed · {data['failed']} failed · "
                  f"{data['unknown']} unsettled · {data['errors']} errors")
        elif kind == "fatal":
            print("Error:", data["message"])


def main():
    ap = argparse.ArgumentParser(description="Lean Craft Game web server")
    ap.add_argument("--port", type=int, default=8000)
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4, help="Lean processes run in parallel")
    ap.add_argument("--timeout", type=int, default=60, help="seconds allowed per test")
    ap.add_argument("--open", action="store_true", help="open the game in a web browser")
    ap.add_argument("--run", nargs=2, metavar=("LEVEL", "FILE"), help="run a level on a file and exit")
    opts = ap.parse_args()
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")       # ✅ and ❌ on a Windows console
    if shutil.which("lake") is None:
        sys.exit("`lake` was not found on your PATH. See INSTALL.md.")
    WORK.mkdir(parents=True, exist_ok=True)
    clean_old_runs()
    prepare_lean()
    if opts.run:
        return cli_run(opts)
    try:
        serve(opts.port, opts.jobs, opts.timeout, opts.open)
    except OSError as e:
        sys.exit(f"Could not listen on port {opts.port} ({e.strerror}). Try --port 8001.")


if __name__ == "__main__":
    main()

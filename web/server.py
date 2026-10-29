#!/usr/bin/env python3
"""DefGame in the browser: a local web server that runs the referee on the player's code.

    python3 web/server.py                    serve the game on http://localhost:8000
    python3 web/server.py --run 1 FILE       run level 1 on FILE and print the report

Only the Python standard library is needed. Each test in DefGame/L<n>/Tests.lean
runs as its own Lean process, with the player's code pasted in, so tests run in
parallel and their verdicts stream to the browser as they arrive.
"""
import argparse
import hashlib
import json
import os
import queue
import re
import shutil
import signal
import subprocess
import sys
import threading
import time
import uuid
import webbrowser
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
STATIC = ROOT / "web" / "static"
WORK = ROOT / ".lake" / "defgame-web"
RUNS = WORK / "runs"
CACHE_FILE = WORK / "cache.json"
# Levels in the order they are played. The numbers are directory names (DefGame/L<n>);
# the number shown to the player is the position in this list.
LEVELS = [4, 5, 6, 15, 7, 8, 9, 16, 17, 10, 11, 12, 13, 18, 1, 19, 20, 21, 22, 14, 2, 3]
LEAN_ENV = {}       # the environment of `lake env`, filled in by build_referee()

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
            if not re.match(r"import DefGame\.L\d+\.Player\s*$", c):
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


def load_level(n):
    d = ROOT / "DefGame" / f"L{n}"
    meta = json.loads((d / "level.json").read_text())
    intro, template = split_intro((d / "Player.lean").read_text())
    return {**meta, "id": n, "num": LEVELS.index(n) + 1, "intro": intro, "template": template,
            **split_tests((d / "Tests.lean").read_text())}


def public_level(lv):
    return {k: lv[k] for k in ("id", "num", "world", "title", "skill", "intro", "template", "hints")} | {
        "tests": [{"id": i, "name": t["name"], "kind": t["kind"]} for i, t in enumerate(lv["tests"])]}


def assemble(lv, code, extra):
    """Build a Lean file from segments; return its text and the line range of each segment.

    The player's `import` lines move to the head of the file (Lean wants them first);
    they are blanked in place so that line numbers in the player's code stay the same."""
    lines = code.rstrip("\n").split("\n")
    imports = [l.strip() for l in lines if re.match(r"import\s", l)]
    code = "\n".join("" if re.match(r"import\s", l) else l for l in lines)
    segs = [("head", "\n".join(["import DefGame.Referee"] + lv["imports"] + imports), None),
            ("player", code, None),
            ("preamble", "\n".join(lv["preamble"]), None)] + extra
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
    """One submission. Cancelling it kills every Lean process it started."""

    def __init__(self):
        self.id = uuid.uuid4().hex[:12]
        self.dir = RUNS / self.id
        self.cancelled = False
        self.procs = set()
        self.lock = threading.Lock()

    def cancel(self):
        with self.lock:
            self.cancelled = True
            for p in self.procs:
                try:
                    os.killpg(p.pid, signal.SIGKILL)
                except (ProcessLookupError, PermissionError):
                    pass

    def lean(self, name, text, timeout):
        """Run `lean --json` on `text`. Returns the messages, or None on timeout or cancel."""
        path = self.dir / f"{name}.lean"
        path.write_text(text)
        with self.lock:
            if self.cancelled:
                return None
            p = subprocess.Popen([LEAN_ENV["LEAN"], "--json", str(path)], cwd=ROOT, env=LEAN_ENV,
                                 stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                 text=True, start_new_session=True)
            self.procs.add(p)
        try:
            out, _ = p.communicate(timeout=timeout)
        except subprocess.TimeoutExpired:
            os.killpg(p.pid, signal.SIGKILL)
            p.communicate()
            return None
        finally:
            with self.lock:
                self.procs.discard(p)
        if self.cancelled:
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
            self.data = json.loads(CACHE_FILE.read_text())
        except (OSError, ValueError):
            self.data = {}

    @staticmethod
    def key(text):
        h = hashlib.sha256()
        for f in ("lean-toolchain", "lake-manifest.json", "DefGame/Referee.lean"):
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
            CACHE_FILE.write_text(json.dumps(self.data))


def compile_check(run, lv, code, timeout):
    """Elaborate the player's code with the level's gates and signature checks."""
    extra = [("gate", g, None) for g in lv["gates"]]
    extra += [("check", c["lean"], c["message"]) for c in lv.get("checks", [])]
    text, ranges = assemble(lv, code, extra)
    msgs = run.lean("check", text, timeout)
    if msgs is None:
        return None
    diags, problems = [], []
    for m in msgs:
        kind, lo, info = locate(m, ranges)
        sev = m.get("severity", "error")
        if kind == "player":
            pos, end = m.get("pos") or {}, m.get("endPos") or m.get("pos") or {}
            diags.append({"severity": sev, "text": m["data"],
                          "line": pos.get("line", lo) - lo + 1, "col": pos.get("column", 0),
                          "endLine": end.get("line", lo) - lo + 1, "endCol": end.get("column", 0)})
        elif sev == "error":
            problems.append(f"{info}\n\nLean says: {m['data']}" if kind == "check" else
                            m["data"] if kind == "gate" else
                            f"Your imports could not be loaded:\n{m['data']}" if kind == "head" else
                            f"The level could not be set up with your code:\n{m['data']}")
    player_errors = any(d["severity"] == "error" for d in diags)
    return {"ok": not player_errors and not problems, "diagnostics": diags,
            "problems": [] if player_errors else problems}


def interpret(msgs, ranges):
    """Turn the messages of one test file into a verdict."""
    errors = []
    for m in msgs:
        kind, _, _ = locate(m, ranges)
        data = m.get("data", "")
        if kind == "test" and data[:1] in ICONS:
            first, _, rest = data.partition("\n")
            return {"status": ICONS[data[0]], "detail": "\n".join(l.strip() for l in rest.splitlines())}
        if m.get("severity") == "error" and kind != "player":
            errors.append(data)
    return {"status": "error", "detail": "\n".join(errors) or "The referee produced no verdict."}


def run_level(run, n, code, events, jobs, timeout, cache):
    """Check and test the player's code, putting (event, data) pairs on `events`."""
    try:
        lv = load_level(n)
        run.dir.mkdir(parents=True, exist_ok=True)
        events.put(("tests", [{"id": i, "name": t["name"], "kind": t["kind"]} for i, t in enumerate(lv["tests"])]))
        check = compile_check(run, lv, code, timeout)
        if check is None:
            events.put(("compile", {"ok": False, "diagnostics": [],
                                    "problems": [f"Compiling your code took more than {timeout} s."]}))
            return
        events.put(("compile", check))
        if not check["ok"]:
            return

        results = [None] * len(lv["tests"])
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
                    events.put(("start", {"id": i}))
                    t0 = time.time()
                    msgs = run.lean(f"T{i}", text, timeout)
                    secs = round(time.time() - t0, 1)
                if run.cancelled:
                    return
                if msgs is None and t["kind"] == "expect_open":
                    # an open statement should not be settled, and the referee did not settle it
                    res = {"status": "pass", "seconds": secs,
                           "detail": f"(the referee could not settle it within {timeout} s, as expected)"}
                elif msgs is None:
                    res = {"status": "unknown", "seconds": secs,
                           "detail": f"The referee ran out of time ({timeout} s)."}
                else:
                    res = interpret(msgs, ranges) | {"seconds": secs}
                    if res["status"] != "error":
                        cache.put(key, res)
            results[i] = res
            events.put(("result", {"id": i, **res}))

        threads = [threading.Thread(target=one, args=(i, t), daemon=True) for i, t in enumerate(lv["tests"])]
        for th in threads:
            th.start()
        for th in threads:
            th.join()
        if run.cancelled:
            return
        count = lambda s: sum(r is not None and r["status"] == s for r in results)
        events.put(("done", {"total": len(results), "passed": count("pass"), "failed": count("fail"),
                             "unknown": count("unknown"), "errors": count("error")}))
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
        if path == "/api/levels":
            out = []
            for n in LEVELS:
                lv = load_level(n)
                out.append({k: lv[k] for k in ("id", "num", "world", "title", "skill")})
            return self.send(200, out)
        m = re.fullmatch(r"/api/levels/(\d+)", path)
        if m and int(m.group(1)) in LEVELS:
            return self.send(200, public_level(load_level(int(m.group(1)))))
        name = "index.html" if path == "/" else path.lstrip("/")
        f = (STATIC / name).resolve()
        if STATIC in f.parents and f.is_file():
            types = {".html": "text/html", ".js": "text/javascript", ".css": "text/css", ".svg": "image/svg+xml"}
            return self.send(200, f.read_bytes(), types.get(f.suffix, "application/octet-stream") + "; charset=utf-8")
        self.send(404, {"error": "not found"})

    def do_POST(self):
        m = re.fullmatch(r"/api/levels/(\d+)/run", self.path)
        if not m or int(m.group(1)) not in LEVELS:
            return self.send(404, {"error": "not found"})
        body = json.loads(self.rfile.read(int(self.headers.get("Content-Length", 0))) or b"{}")
        run, events = Run(), queue.Queue()
        with Handler.current_lock:
            if Handler.current:
                Handler.current.cancel()
            Handler.current = run
        threading.Thread(target=run_level, daemon=True,
                         args=(run, int(m.group(1)), body.get("code", ""), events,
                               self.opts.jobs, self.opts.timeout, self.cache)).start()
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

def build_referee():
    print("Building the referee (lake build DefGame.Referee)…", flush=True)
    r = subprocess.run(["lake", "build", "DefGame.Referee"], cwd=ROOT, capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit(f"`lake build DefGame.Referee` failed:\n{r.stdout}{r.stderr}")
    # Ask lake once for the environment (LEAN, LEAN_PATH, …): running `lake env` for
    # every test would be slower, and parallel calls can contend for lake's lock.
    r = subprocess.run(["lake", "env", "env", "-0"], cwd=ROOT, capture_output=True, text=True, check=True)
    LEAN_ENV.update(kv.split("=", 1) for kv in r.stdout.split("\0") if "=" in kv)


def cli_run(opts):
    """Run one level on a file and print the report."""
    code = Path(opts.run[1]).read_text()
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
    ap = argparse.ArgumentParser(description="DefGame web server")
    ap.add_argument("--port", type=int, default=8000)
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4, help="Lean processes run in parallel")
    ap.add_argument("--timeout", type=int, default=60, help="seconds allowed per test")
    ap.add_argument("--open", action="store_true", help="open the game in a web browser")
    ap.add_argument("--run", nargs=2, metavar=("LEVEL", "FILE"), help="run a level on a file and exit")
    opts = ap.parse_args()
    if shutil.which("lake") is None:
        sys.exit("`lake` was not found on your PATH. See INSTALL.md.")
    # Each run deletes its own folder when it ends; only clear leftovers from crashed
    # servers here, so that several servers (or --run) can work side by side.
    for d in RUNS.glob("*"):
        if time.time() - d.stat().st_mtime > 3600:
            shutil.rmtree(d, ignore_errors=True)
    build_referee()
    if opts.run:
        return cli_run(opts)
    Handler.opts, Handler.cache = opts, Cache()
    try:
        server = ThreadingHTTPServer(("127.0.0.1", opts.port), Handler)
    except OSError as e:
        sys.exit(f"Could not listen on port {opts.port} ({e.strerror}). Try --port 8001.")
    server.daemon_threads = True
    url = f"http://localhost:{opts.port}/"
    print(f"DefGame is running at {url}  (Ctrl+C to stop)", flush=True)
    if opts.open:
        webbrowser.open(url)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        if Handler.current:
            Handler.current.cancel()


if __name__ == "__main__":
    main()

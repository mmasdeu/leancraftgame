#!/usr/bin/env python3
"""Lean Craft Game as a desktop app: sets up Lean and Mathlib on first launch, then serves the game.

    LeanCraftGame                  start the game (first launch: install Lean and Mathlib)
    LeanCraftGame --self-test      set up, then check two levels; exit status 0 if all is well

The app carries the game files, the compiled referee and `deps.json`, which names the
Lean toolchain and the Mathlib pack (the part of Mathlib the game loads, built by
app/make_pack.py). Everything it downloads goes into one data folder (see data_dir()):

    elan/          a private elan and Lean toolchain, if the user has none
    deps/<id>/     the unpacked Mathlib pack
    work/          the server's temporary files and verdict cache
    leancraftgame.log    the log

Environment variables, mainly for testing: LEANCRAFT_DATA (the data folder),
LEANCRAFT_DEPS (a deps.json other than the bundled one), LEANCRAFT_PACK_FILE (use this
local pack instead of downloading it), LEANCRAFT_IGNORE_SYSTEM_ELAN=1 (always install a
private elan). Run from a checkout, the referee comes from .lake/build after
`lake build LeanCraftGame.Referee`.
"""
import argparse
import hashlib
import json
import os
import platform
import queue
import shutil
import ssl
import subprocess
import sys
import tarfile
import tempfile
import threading
import time
import urllib.request
import zipfile
from pathlib import Path

BUNDLE = Path(getattr(sys, "_MEIPASS", Path(__file__).resolve().parent.parent))
ELAN_VERSION = "v4.2.4"
PORT = 8642        # fixed, because the browser keeps the player's progress per address
EXE = ".exe" if os.name == "nt" else ""
NO_WINDOW = getattr(subprocess, "CREATE_NO_WINDOW", 0)


def data_dir():
    if os.environ.get("LEANCRAFT_DATA"):
        return Path(os.environ["LEANCRAFT_DATA"])
    if os.name == "nt":
        return Path(os.environ.get("LOCALAPPDATA", Path.home() / "AppData" / "Local")) / "LeanCraftGame"
    if sys.platform == "darwin":
        return Path.home() / "Library" / "Application Support" / "LeanCraftGame"
    return Path(os.environ.get("XDG_DATA_HOME", Path.home() / ".local" / "share")) / "leancraftgame"


DATA = data_dir()
DATA.mkdir(parents=True, exist_ok=True)
os.environ.setdefault("LEANCRAFT_ROOT", str(BUNDLE))
os.environ.setdefault("LEANCRAFT_WORK", str(DATA / "work"))
sys.path.insert(0, str(BUNDLE / "web"))
import server  # noqa: E402  (needs LEANCRAFT_ROOT and LEANCRAFT_WORK)

DEPS = json.loads(Path(os.environ.get("LEANCRAFT_DEPS") or BUNDLE / "deps.json").read_text(encoding="utf-8"))
# the compiled referee: bundled in the app, or built by lake in a checkout
OLEAN = BUNDLE / "olean" if (BUNDLE / "olean").is_dir() else BUNDLE / ".lake" / "build" / "lib" / "lean"
TOOLCHAIN_DIR = DEPS["toolchain"].replace("/", "--").replace(":", "---")


def log(*args):
    print(time.strftime("%H:%M:%S"), *args, flush=True)


def elan_target():
    machine = platform.machine().lower()
    arm = machine in ("arm64", "aarch64")
    if os.name == "nt":
        return "x86_64-pc-windows-msvc"          # also runs on Windows on ARM, emulated
    if sys.platform == "darwin":
        return "aarch64-apple-darwin" if arm else "x86_64-apple-darwin"
    return "aarch64-unknown-linux-gnu" if arm else "x86_64-unknown-linux-gnu"


def ssl_context():
    try:
        import certifi                           # bundled in the app: frozen Pythons may lack CA files
        return ssl.create_default_context(cafile=certifi.where())
    except ImportError:
        return ssl.create_default_context()


def download(url, dest, progress):
    """Download `url` to `dest`, calling progress(done, total) along the way."""
    req = urllib.request.Request(url, headers={"User-Agent": "LeanCraftGame"})
    with urllib.request.urlopen(req, context=ssl_context(), timeout=60) as r, open(dest, "wb") as f:
        total, done = int(r.headers.get("Content-Length") or 0), 0
        while chunk := r.read(1 << 20):
            f.write(chunk)
            done += len(chunk)
            progress(done, total)


class Setup:
    """Installs what the game needs, in a background thread, and reports its progress."""

    STEPS = ["Lean", "Mathlib", "Check"]

    def __init__(self):
        self.lock = threading.Lock()
        self.thread = None
        self.state = {"ready": False, "app": True, "steps": self.STEPS, "step": 0,
                      "message": "Starting…", "progress": None, "error": None}

    def status(self):
        with self.lock:
            return dict(self.state)

    def _set(self, quiet=False, **kw):
        """Update the status shown in the page; log new messages unless `quiet`."""
        with self.lock:
            changed = kw.get("message") and kw["message"] != self.state["message"]
            self.state.update(kw)
        if changed and not quiet:
            log(kw["message"])

    def start(self):
        self.thread = threading.Thread(target=self.run, daemon=True)
        self.thread.start()

    def retry(self):
        if self.state["error"] and not (self.thread and self.thread.is_alive()):
            self._set(error=None, message="Retrying…")
            self.start()

    def run(self):
        try:
            self._set(step=0, progress=None)
            lean = self.toolchain()
            self._set(step=1, progress=None)
            deps = self.pack()
            self._set(step=2, progress=None, message="Checking that Lean can load Mathlib and the referee…")
            env = dict(os.environ, LEAN=str(lean),
                       LEAN_PATH=os.pathsep.join([str(OLEAN), str(deps)]))
            self.check(env)
            server.LEAN_ENV.clear()
            server.LEAN_ENV.update(env)
            self._set(ready=True, step=3, progress=None, message="Ready.")
        except Exception as e:
            log("Setup failed:", repr(e))
            self._set(error=f"{type(e).__name__}: {e}")

    # -------------------------------------------------------------- Lean

    def toolchain(self):
        homes = [DATA / "elan"]
        if not os.environ.get("LEANCRAFT_IGNORE_SYSTEM_ELAN"):
            homes.insert(0, Path(os.environ.get("ELAN_HOME") or Path.home() / ".elan"))
        for home in homes:
            lean = home / "toolchains" / TOOLCHAIN_DIR / "bin" / f"lean{EXE}"
            if lean.is_file():
                self._set(message=f"Using Lean from {lean.parent.parent}.")
                return lean
        home = DATA / "elan"
        elan = home / "bin" / f"elan{EXE}"
        env = dict(os.environ, ELAN_HOME=str(home))
        if not elan.is_file():
            self.install_elan(env)
        self._set(message=f"Downloading Lean ({DEPS['toolchain']}), about 300 MB…")
        p = subprocess.Popen([str(elan), "toolchain", "install", DEPS["toolchain"]], env=env,
                             stdout=subprocess.PIPE, stderr=subprocess.STDOUT, creationflags=NO_WINDOW,
                             encoding="utf-8", errors="replace")
        buf = ""
        while ch := p.stdout.read(1):              # elan redraws its progress bar with \r
            if ch in "\r\n":
                if buf.strip():                    # progress-bar redraws go to the page only
                    self._set(message=f"Lean: {buf.strip()}", quiet="%" in buf)
                buf = ""
            else:
                buf += ch
        if p.wait() != 0:
            raise RuntimeError(f"elan could not install {DEPS['toolchain']}")
        lean = home / "toolchains" / TOOLCHAIN_DIR / "bin" / f"lean{EXE}"
        if not lean.is_file():
            raise RuntimeError(f"Lean was installed, but {lean} is missing")
        return lean

    def install_elan(self, env):
        target = elan_target()
        ext = "zip" if os.name == "nt" else "tar.gz"
        url = f"https://github.com/leanprover/elan/releases/download/{ELAN_VERSION}/elan-{target}.{ext}"
        self._set(message="Downloading elan, Lean's installer…")
        with tempfile.TemporaryDirectory() as tmp:
            archive = Path(tmp) / f"elan.{ext}"
            download(url, archive, lambda d, t: self._set(progress=[d, t]))
            if ext == "zip":
                zipfile.ZipFile(archive).extractall(tmp)
            else:
                with tarfile.open(archive) as t:
                    t.extractall(tmp, filter="data")
            init = Path(tmp) / f"elan-init{EXE}"
            init.chmod(0o755)
            self._set(message="Installing elan…", progress=None)
            subprocess.run([str(init), "-y", "--default-toolchain", "none", "--no-modify-path"],
                           env=env, check=True, capture_output=True, creationflags=NO_WINDOW)

    # -------------------------------------------------------------- Mathlib

    def pack(self):
        target = DATA / "deps" / DEPS["id"]
        if (target / ".complete").exists():
            self._set(message="Mathlib is already installed.")
            return target
        target.parent.mkdir(parents=True, exist_ok=True)
        local = os.environ.get("LEANCRAFT_PACK_FILE")
        archive = Path(local) if local else target.parent / f"{DEPS['id']}.tar.xz"
        if not local:
            mb = DEPS["size"] / 1e6
            self._set(message=f"Downloading the Mathlib files the game needs ({mb:.0f} MB)…")
            part = archive.with_suffix(".part")
            download(DEPS["url"], part, lambda d, t: self._set(progress=[d, t or DEPS["size"]]))
            part.replace(archive)
        self._set(message="Verifying the download…", progress=None)
        h, done, total = hashlib.sha256(), 0, archive.stat().st_size
        with open(archive, "rb") as f:
            while chunk := f.read(1 << 22):
                h.update(chunk)
                done += len(chunk)
                self._set(progress=[done, total])
        if h.hexdigest() != DEPS["sha256"]:
            if not local:
                archive.unlink()
            raise RuntimeError("the Mathlib download is corrupt (checksum mismatch); press Retry")
        tmp = target.with_name(target.name + ".tmp")
        shutil.rmtree(tmp, ignore_errors=True)
        with tarfile.open(archive, "r:xz") as t:
            members = t.getmembers()
            for i, m in enumerate(members):
                t.extract(m, tmp, filter="data")
                if i % 200 == 0:
                    self._set(message="Unpacking Mathlib…", progress=[i, len(members)])
        shutil.rmtree(target, ignore_errors=True)
        tmp.replace(target)
        (target / ".complete").write_text(DEPS["id"], encoding="utf-8")
        if not local:
            archive.unlink()
        for old in (DATA / "deps").iterdir():      # packs of earlier versions of the game
            if old.is_dir() and old.name != DEPS["id"]:
                shutil.rmtree(old, ignore_errors=True)
        return target

    def check(self, env):
        with tempfile.TemporaryDirectory() as tmp:
            f = Path(tmp) / "Check.lean"
            f.write_text('import LeanCraftGame.Referee\n#eval "referee loaded"\n', encoding="utf-8")
            r = subprocess.run([env["LEAN"], str(f)], env=env, capture_output=True, timeout=600,
                               creationflags=NO_WINDOW, encoding="utf-8", errors="replace")
        if r.returncode != 0 or "referee loaded" not in r.stdout:
            raise RuntimeError(f"Lean could not load the referee:\n{r.stdout}{r.stderr}"[:2000])


# ------------------------------------------------------------------ self-test

def self_test(setup):
    """Set up, then play two levels (one needs Mathlib's ℚ) with a correct and a buggy answer."""
    setup.run()
    if setup.status()["error"]:
        return 1
    failures = 0
    cases = [(4, "correct", True), (4, "bug_text", False), (17, "correct", True), (17, "bug_divide", False)]
    for n, name, should_clear in cases:
        code = (BUNDLE / "variants" / f"L{n}" / f"{name}.lean").read_text(encoding="utf-8")
        events, t0 = queue.Queue(), time.time()
        threading.Thread(target=server.run_level, daemon=True,
                         args=(server.Run(), n, code, events, os.cpu_count() or 2, 600, server.Cache())).start()
        done, problems = None, []
        while (ev := events.get()) is not None:
            if ev[0] == "done":
                done = ev[1]
            elif ev[0] == "compile" and not ev[1]["ok"]:
                problems = ev[1]["problems"] + [d["text"] for d in ev[1]["diagnostics"]]
            elif ev[0] == "fatal":
                problems = [ev[1]["message"]]
            elif ev[0] == "result" and ev[1]["status"] == "error":
                problems.append(ev[1]["detail"])
        cleared = bool(done) and done["passed"] == done["total"]
        ok = cleared if should_clear else bool(done) and done["failed"] > 0
        failures += not ok
        log(f"{'ok  ' if ok else 'FAIL'} level {n} {name}: {done} ({time.time() - t0:.0f} s)")
        for p in problems[:3]:
            log("     ", p[:500])
    log("Self-test passed." if not failures else f"Self-test: {failures} failure(s).")
    return 1 if failures else 0


# ------------------------------------------------------------------ main

def already_running(port):
    try:
        with urllib.request.urlopen(f"http://127.0.0.1:{port}/api/setup", timeout=2) as r:
            return "ready" in json.loads(r.read())
    except Exception:
        return False


def main():
    ap = argparse.ArgumentParser(description="Lean Craft Game, a Lean game about definitions")
    ap.add_argument("--port", type=int, default=PORT)
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4, help="Lean processes run in parallel")
    ap.add_argument("--timeout", type=int, default=60, help="seconds allowed per test")
    ap.add_argument("--no-browser", action="store_true", help="do not open a web browser")
    ap.add_argument("--self-test", action="store_true", help="set up, check two levels, and exit")
    opts = ap.parse_args()

    logfile = open(DATA / "leancraftgame.log", "a", encoding="utf-8", buffering=1)
    if sys.stdout is None or (not opts.self_test and not sys.stdout.isatty()):
        sys.stdout = sys.stderr = logfile         # no console (macOS app, desktop launcher)
    elif hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
    log(f"Lean Craft Game starting; data folder {DATA}")

    setup = Setup()
    if opts.self_test:
        sys.exit(self_test(setup))

    if already_running(opts.port):
        log("Lean Craft Game is already running; opening it in the browser.")
        if not opts.no_browser:
            import webbrowser
            webbrowser.open(f"http://localhost:{opts.port}/")
        return
    server.SETUP = setup
    setup.start()
    try:
        server.serve(opts.port, opts.jobs, opts.timeout, open_browser=not opts.no_browser)
    except OSError as e:
        log(f"Could not listen on port {opts.port}: {e}")
        sys.exit(1)
    log("Lean Craft Game stopped.")


if __name__ == "__main__":
    main()

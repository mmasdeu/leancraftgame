#!/usr/bin/env python3
"""Build the online version of Lean Craft Game: a folder of static files.

    python3 online/build.py                 writes dist/online/
    python3 online/build.py --out DIR
    python3 online/build.py --out DIR --live-server ws://127.0.0.1:8090    a development build

The folder can be served by any static web server. The browser checks the player's
code on https://live.lean-lang.org/ (see web/static/live.js), so the host needs no Lean.
It contains the game's web page (web/static), plus

    config.js           turns the online mode on
    data/levels.json    every level: text, template, hints and the hidden tests
    data/intro.md       the Welcome page
    data/prelude.lean   the referee and the shared library (LeanCraftGame/Lib) as one
                        self-contained piece of Lean, pasted into every submission before
                        the player's code (the live editor cannot import LeanCraftGame.*)
"""
import argparse
import json
import re
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "web"))
import server  # noqa: E402  (its level loading is reused as it is)

INITIALIZE = re.compile(r"^initialize (\w+) : (.+?) ← (.+)$", re.M)

# What the Welcome page says about saving and privacy, locally and online.
LOCAL_NOTE = re.compile(r"Your code never leaves your computer,.*?which you send yourself\.", re.S)
# Checking code online is paused: the online version does not contact the Lean Playground.
LIVE_PAUSED = True
PAUSED_NOTE = ("Checking code in the browser is paused for now, while we work out how to use the Lean Playground (the Lean community's public server) fairly. You can still read every lesson here. To play, download the app from the Lean Craft Game website: it checks your code on your own computer."
               " The **Report a problem** button at the top only opens a prefilled page on GitHub, "
               "which you send yourself.")
ONLINE_NOTE = ("When you run the tests, your code is sent to the Lean Playground (live.lean-lang.org), "
               "a public server of the Lean community, which checks it: do not put anything private in it. "
               "The **Report a problem** button at the top only opens a prefilled page on GitHub, "
               "which you send yourself.")


def prelude():
    """The referee as a block that can sit in the middle of a file.

    * `initialize` declarations cannot be used in the module that declares them, so each
      becomes a global reference created on first use (it is one value, shared by every call).
    * The `open`s of the file must not reach the player's code or the tests: everything
      goes in a section."""
    src = (ROOT / "LeanCraftGame" / "Referee.lean").read_text(encoding="utf-8")
    src, n = re.subn(r"^import Mathlib\.Tactic\s*$", "", src, flags=re.M)
    assert n == 1, "Referee.lean should import Mathlib.Tactic once"

    def ref(m):
        name, ty, init = m.groups()
        return (f"unsafe def {name}Unsafe : IO.Ref ({ty.removeprefix('IO.Ref ').strip()}) "
                f":= unsafeBaseIO ({init})\n"
                f"@[implemented_by {name}Unsafe] opaque {name} : {ty}")

    src, n = INITIALIZE.subn(ref, src)
    assert n == 4, f"expected 4 `initialize` lines in Referee.lean, found {n}"
    return "section\n" + src.strip() + "\nend\n" + "\n".join(library())


def library():
    """The shared library (LeanCraftGame/Lib/*.lean), each module as a section, in an order
    where every module comes after the modules it imports."""
    mods = {f.stem: f.read_text(encoding="utf-8") for f in sorted((ROOT / "LeanCraftGame" / "Lib").glob("*.lean"))}
    done, out = set(), []

    def visit(name):
        if name in done:
            return
        done.add(name)
        src = mods[name]
        for dep in re.findall(r"^import LeanCraftGame\.Lib\.(\w+)\s*$", src, re.M):
            visit(dep)
        body = re.sub(r"^import .*$", "", src, flags=re.M).strip()
        out.append(f"section -- LeanCraftGame.Lib.{name}\n{body}\nend")

    for name in mods:
        visit(name)
    return out


def intro(paused=LIVE_PAUSED, server=None):
    text = (ROOT / "LeanCraftGame" / "Intro.md").read_text(encoding="utf-8")
    note = (PAUSED_NOTE if paused else
            ONLINE_NOTE if server is None else
            f"When you run the tests, your code is sent to the Lean server at {server} (a development build).")
    text, n = LOCAL_NOTE.subn(note, text)
    assert n == 1, "Intro.md no longer has the sentence about nothing being sent"
    return text


def levels():
    out = []
    for n in server.LEVELS:
        lv = server.load_level(n)
        # the referee is pasted into the file (prelude.lean), not imported
        imports = [i for i in lv["imports"] if not i.strip().startswith("import LeanCraftGame.")]
        # reading questions are graded in the browser from a hashed key: leave their answers out
        tests = [{"kind": t["kind"], "name": t["name"], "answer": t["answer"]} if "answer" in t else t
                 for t in lv["tests"]]
        out.append({k: lv[k] for k in server.PUBLIC_KEYS + ("preamble", "gates") if k in lv}
                   | {"tests": tests, "imports": imports} | {"checks": lv.get("checks", [])})
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--out", type=Path, default=ROOT / "dist" / "online")
    ap.add_argument("--live-server", metavar="URL",
                    help="a development build that checks code on this lean4web server instead of the "
                         "Lean Playground, such as ws://127.0.0.1:8090 (see DEVELOPMENT.md); it is not "
                         "paused and does not count usage")
    ap.add_argument("--live-project", metavar="NAME", default="LeanCraftGame",
                    help="the lean4web project to use with --live-server (default: LeanCraftGame)")
    opts = ap.parse_args()
    out = opts.out
    shutil.rmtree(out, ignore_errors=True)
    shutil.copytree(ROOT / "web" / "static", out)
    (out / "data").mkdir()
    if opts.live_server:
        # a development build: your own server, no pause, no usage counting
        paused = False
        config = {"online": True, "liveServer": opts.live_server, "liveProject": opts.live_project}
    else:
        # `livePaused`: the online version does not contact the Lean Playground at all (live.js
        # refuses to run, and the Welcome page says why). Set LIVE_PAUSED to False to re-enable it.
        paused = LIVE_PAUSED
        config = {"online": True, "goatcounter": "mmasdeu"} | ({"livePaused": True} if paused else {})
    (out / "config.js").write_text(f"window.LEANCRAFT = {json.dumps(config)};\n", encoding="utf-8")
    (out / "data" / "levels.json").write_text(json.dumps(levels(), ensure_ascii=False), encoding="utf-8")
    (out / "data" / "intro.md").write_text(intro(paused, opts.live_server), encoding="utf-8")
    (out / "data" / "prelude.lean").write_text(prelude() + "\n", encoding="utf-8")
    print(f"Wrote {out}")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Build the online version of Lean Craft Game: a folder of static files.

    python3 online/build.py                 writes dist/online/
    python3 online/build.py --out DIR

The folder can be served by any static web server. The browser checks the player's
code on https://live.lean-lang.org/ (see web/static/live.js), so the host needs no Lean.
It contains the game's web page (web/static), plus

    config.js           turns the online mode on
    data/levels.json    every level: text, template, hints and the hidden tests
    data/intro.md       the Welcome page
    data/prelude.lean   the referee as one self-contained piece of Lean, pasted into every
                        submission (the live editor cannot import LeanCraftGame.Referee)
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
LOCAL_NOTE = re.compile(r"Nothing is sent anywhere,.*?which you send yourself\.", re.S)
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
    return "section\n" + src.strip() + "\nend"


def intro():
    text = (ROOT / "LeanCraftGame" / "Intro.md").read_text(encoding="utf-8")
    text, n = LOCAL_NOTE.subn(ONLINE_NOTE, text)
    assert n == 1, "Intro.md no longer has the sentence about nothing being sent"
    return text


def levels():
    out = []
    for n in server.LEVELS:
        lv = server.load_level(n)
        # the referee is pasted into the file (prelude.lean), not imported
        imports = [i for i in lv["imports"] if i.strip() != "import LeanCraftGame.Referee"]
        out.append({k: lv[k] for k in ("id", "num", "world", "title", "skill", "intro", "template", "hints",
                                       "preamble", "gates", "tests")} | {"imports": imports}
                   | {"checks": lv.get("checks", [])})
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--out", type=Path, default=ROOT / "dist" / "online")
    opts = ap.parse_args()
    out = opts.out
    shutil.rmtree(out, ignore_errors=True)
    shutil.copytree(ROOT / "web" / "static", out)
    (out / "data").mkdir()
    (out / "config.js").write_text('window.LEANCRAFT = { online: true };\n', encoding="utf-8")
    (out / "data" / "levels.json").write_text(json.dumps(levels(), ensure_ascii=False), encoding="utf-8")
    (out / "data" / "intro.md").write_text(intro(), encoding="utf-8")
    (out / "data" / "prelude.lean").write_text(prelude() + "\n", encoding="utf-8")
    print(f"Wrote {out}")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Check every level against its sample answers in variants/L<n>/.

    python3 check_levels.py            all levels, in the order they are played
    python3 check_levels.py 1 4        only the levels in LeanCraftGame/L1 and LeanCraftGame/L4

* An answer named `correct*.lean` or `fix*.lean` must pass every test.
* An answer named `bug*.lean` must fail at least one test (❌), or be rejected
  before the tests run (for example by a check in level.json).
* The starting code (`Player.lean` as the player sees it) must not clear the level.
* Every level's metadata (predictions, public tests, hints) must match its tests.

    python3 check_levels.py --static   only check the metadata (no Lean needed)

Prints one line per answer and exits with status 1 if anything is unexpected.
"""
import argparse
import queue
import sys
import threading
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "web"))
import server  # noqa: E402

ICON = {"pass": "✅", "fail": "❌", "unknown": "❓", "error": "⚠️"}


def run(n, code, jobs, timeout, cache):
    """Run level `n` on `code`; return (compile result, results by test id, summary)."""
    events = queue.Queue()
    threading.Thread(target=server.run_level, daemon=True,
                     args=(server.Run(), n, code, events, jobs, timeout, cache)).start()
    compiled, results, done = None, {}, None
    while (ev := events.get()) is not None:
        kind, data = ev
        if kind == "compile":
            compiled = data
        elif kind == "result":
            results[data["id"]] = data
        elif kind == "done":
            done = data
        elif kind == "fatal":
            raise RuntimeError(data["message"])
    return compiled, results, done


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("levels", nargs="*", type=int, help="level directories to check (default: all)")
    ap.add_argument("--jobs", type=int, default=8, help="Lean processes run in parallel")
    ap.add_argument("--timeout", type=int, default=60, help="seconds allowed per test")
    ap.add_argument("--static", action="store_true", help="only check the levels' metadata")
    opts = ap.parse_args()
    problems = 0
    for n in opts.levels or server.LEVELS:
        lv = server.load_level(n)
        for p in server.validate_level(lv):
            print(f"!! L{n:<3}{p}")
            problems += 1
        if not (ROOT / f"variants/L{n}").is_dir():
            print(f"!! L{n:<3}has no sample answers in variants/L{n}")
            problems += 1
    if opts.static:
        print("All level metadata is consistent." if not problems else f"{problems} problem(s).")
        sys.exit(1 if problems else 0)
    if problems:
        sys.exit(f"{problems} problem(s) with the level metadata: fix them first.")
    server.prepare_lean()
    cache = server.Cache()
    unexpected = 0
    for n in opts.levels or server.LEVELS:
        lv = server.load_level(n)
        names = [t["name"] for t in lv["tests"]]
        answers = [None] + sorted((ROOT / f"variants/L{n}").glob("*.lean"))
        for f in answers:
            label = "(start)" if f is None else f.stem
            code = lv["template"] if f is None else f.read_text()
            t0 = time.time()
            compiled, results, done = run(n, code, opts.jobs, opts.timeout, cache)
            if not compiled["ok"]:
                why = (compiled["problems"] or [d["text"] for d in compiled["diagnostics"]])[0]
                line = "rejected: " + why.replace("\n", " ")[:80]
                cleared, failed = False, None
            else:
                marks = "".join(ICON[results[i]["status"]] for i in sorted(results))
                line = f"{marks}  {done['passed']}/{done['total']}"
                cleared, failed = done["passed"] == done["total"], done["failed"]
            if label.startswith(("correct", "fix")):
                ok = cleared
            elif label.startswith("bug"):
                ok = not cleared and (failed is None or failed > 0)
            else:
                ok = not cleared
            print(f"{'  ' if ok else '!!'} L{n:<3}{label:22s}{line}  ({time.time() - t0:.0f} s)", flush=True)
            if not ok:
                unexpected += 1
                for i in sorted(results):
                    if results[i]["status"] != "pass":
                        print(f"        {ICON[results[i]['status']]} {names[i]}")
    print("All answers behave as expected." if not unexpected else f"{unexpected} unexpected result(s).")
    sys.exit(1 if unexpected else 0)


if __name__ == "__main__":
    main()

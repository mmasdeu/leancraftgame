"""Browser test of the reading levels (level.json "questions").

    python3 tests/browser_questions.py [LEVEL ...]      default: every level with questions

For each reading level it opens the page, answers every question by clicking the buttons
(the right answers come from variants/L<n>/correct.lean), checks that the clicks wrote the
answer lines into the code, that editing a line by hand moves the highlighted button, and
that the level is cleared through the UI. Needs Playwright with Chromium.
"""
import argparse
import re
import sys
import threading
import time
from http.server import ThreadingHTTPServer
from pathlib import Path

from playwright.sync_api import sync_playwright

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "web"))
import server  # noqa: E402


def answers(level):
    """The right answers of a reading level, from its correct variant: {name: value text}."""
    code = (ROOT / "variants" / f"L{level}" / "correct.lean").read_text(encoding="utf-8")
    return dict(re.findall(r"^def (\w+) : [^:=\n]+ := (\S+)", code, re.M))


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("levels", nargs="*", type=int)
    opts = ap.parse_args()
    levels = opts.levels or [n for n in server.LEVELS if server.load_level(n).get("questions")]
    server.prepare_lean()
    server.Handler.opts = argparse.Namespace(jobs=4, timeout=60)
    server.Handler.cache = server.Cache()
    httpd = ThreadingHTTPServer(("127.0.0.1", 0), server.Handler)
    threading.Thread(target=httpd.serve_forever, daemon=True).start()
    base = f"http://127.0.0.1:{httpd.server_address[1]}"
    try:
        with sync_playwright() as p:
            browser = p.chromium.launch(headless=True, args=["--disable-dev-shm-usage"])
            page = browser.new_page()
            errors = []
            page.on("pageerror", lambda e: errors.append(str(e)))
            for n in levels:
                t0 = time.time()
                lv = server.load_level(n)
                right = answers(n)
                page.on("dialog", lambda d: d.accept())
                page.goto(f"{base}/?level={n}", wait_until="networkidle")
                page.wait_for_selector("#questions .q-opt")
                page.click("#reset")
                # the rest of the level (definitions to write) from the correct answer, with
                # every answer line reset to `sorry`; the buttons then fill in the answers
                code = (ROOT / "variants" / f"L{n}" / "correct.lean").read_text(encoding="utf-8")
                for q in lv["questions"]:
                    code = re.sub(rf"^(def {re.escape(q['answer'])} : [^:=\n]+ :=).*$", r"\1 sorry", code, flags=re.M)
                page.evaluate("""c => { const el = document.querySelector('#src'); el.value = c;
                    el.dispatchEvent(new Event('input', {bubbles: true})); }""", code)
                for i, q in enumerate(lv["questions"]):
                    value = right[q["answer"]]
                    page.click(f'#questions li[data-q="{i}"] .q-opt[data-v="{value}"]')
                code = page.input_value("#src")
                for q in lv["questions"]:
                    line = f"def {q['answer']} : "
                    assert re.search(rf"^{re.escape(line)}[^\n]*:= {re.escape(right[q['answer']])}$", code, re.M), \
                        (n, q["answer"], code)
                picked = page.locator("#questions .q-opt.picked").count()
                assert picked == len(lv["questions"]), (n, picked)
                # editing an answer line by hand moves the button
                q0 = lv["questions"][0]
                other = "0" if right[q0["answer"]] != "0" else "1"
                if "choices" not in q0:
                    other = "true" if right[q0["answer"]] == "false" else "false"
                page.evaluate("""([name, v]) => {
                    const el = document.querySelector('#src');
                    el.value = el.value.replace(new RegExp(`^(def ${name} : [^:=\\n]+ :=).*$`, 'm'), `$1 ${v}`);
                    el.dispatchEvent(new Event('input', {bubbles: true}));
                }""", [q0["answer"], other])
                assert page.locator(f'#questions li[data-q="0"] .q-opt[data-v="{other}"]').get_attribute("class").count("picked")
                page.click(f'#questions li[data-q="0"] .q-opt[data-v="{right[q0["answer"]]}"]')
                if page.locator("#predict-skip").count():
                    page.click("#predict-skip")
                page.click("#run")
                page.wait_for_function("document.querySelector('#summary').textContent.includes('Level cleared')",
                                       timeout=180000)
                assert not errors, (n, errors)
                print(f"L{n}: {len(lv['questions'])} questions answered by clicking; level cleared "
                      f"({time.time() - t0:.0f} s)", flush=True)
            browser.close()
    finally:
        httpd.shutdown()
        httpd.server_close()
    print("All reading levels work through the browser UI.")


if __name__ == "__main__":
    main()

"""The online version against a real Lean server: a local lean4web (see DEVELOPMENT.md).

    dev/lean4web.sh start                                   in another terminal
    python3 tests/browser_live.py [LEVEL ...] [--server ws://127.0.0.1:8090]

Builds a development version of the online game pointed at the server, serves it locally, and
plays each level (default: a sample from every world) in a headless browser with its correct
answer from variants/: the level must be cleared. Only this machine is contacted. Needs
Playwright with Chromium.
"""
import argparse
import functools
import subprocess
import sys
import threading
import time
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

from playwright.sync_api import sync_playwright

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / ".lake" / "leancraftgame-web" / "online-live-test"
SAMPLE = [1, 5, 8, 12, 15, 21, 24, 30, 36, 42, 45, 48, 50]


class Quiet(SimpleHTTPRequestHandler):
    def log_message(self, *args):
        pass


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("levels", nargs="*", type=int)
    ap.add_argument("--server", default="ws://127.0.0.1:8090")
    ap.add_argument("--project", default="LeanCraftGame")
    ap.add_argument("--timeout", type=int, default=600, help="seconds allowed per level")
    opts = ap.parse_args()
    subprocess.run([sys.executable, str(ROOT / "online" / "build.py"), "--out", str(OUT),
                    "--live-server", opts.server, "--live-project", opts.project],
                   check=True, stdout=subprocess.DEVNULL)
    httpd = ThreadingHTTPServer(("127.0.0.1", 0), functools.partial(Quiet, directory=str(OUT)))
    threading.Thread(target=httpd.serve_forever, daemon=True).start()
    base = f"http://127.0.0.1:{httpd.server_address[1]}"
    server_http = opts.server.replace("ws", "http", 1)
    failures = 0
    try:
        with sync_playwright() as p:
            browser = p.chromium.launch(headless=True)
            for n in opts.levels or SAMPLE:
                t0 = time.time()
                page = browser.new_page()
                page.set_default_timeout(60000)
                outside, errors = [], []
                page.on("pageerror", lambda e: errors.append(str(e)))

                def guard(route, request):
                    if request.url.startswith((base, server_http)):
                        return route.continue_()
                    outside.append(request.url)
                    return route.abort()
                page.route("**/*", guard)
                page.goto(f"{base}/?level={n}", wait_until="networkidle")
                page.wait_for_selector("#run")
                code = (ROOT / "variants" / f"L{n}" / "correct.lean").read_text(encoding="utf-8")
                page.evaluate("""c => { const el = document.querySelector('#src'); el.value = c;
                    el.dispatchEvent(new Event('input', {bubbles: true})); }""", code)
                if page.locator("#predict-skip").count():
                    page.click("#predict-skip")
                page.click("#run")
                # the run is over when the Stop button is hidden again
                page.wait_for_function("() => !document.querySelector('#stop').hidden", timeout=30000)
                page.wait_for_function("() => document.querySelector('#stop').hidden", timeout=opts.timeout * 1000)
                summary = " ".join(page.locator("#summary").inner_text().split())
                ok = "Level cleared" in summary and not errors and not outside
                failures += not ok
                print(f"{'ok  ' if ok else 'FAIL'} L{n}: {summary[:110]} ({time.time() - t0:.0f} s)", flush=True)
                if not ok and (errors or outside):
                    print("     errors:", errors, "outside:", outside)
                page.close()
            browser.close()
    finally:
        httpd.shutdown()
    print("Every level was cleared on the Lean server." if not failures else f"{failures} level(s) not cleared.")
    sys.exit(1 if failures else 0)


if __name__ == "__main__":
    main()

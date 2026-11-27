"""Browser test of the online version's connection diagnostics (web/static/live.js).

    python3 tests/browser_connection.py

Builds the online version, serves it locally, and plays the Lean Playground's part with
Playwright: no request leaves the machine. For each failure (the WebSocket refused while the
host is reachable, the host unreachable, the socket closed before Lean starts, Lean silent)
it runs level 1 and checks the diagnosis shown to the player, the connection details, and
that "Report a problem" carries the timeline. Needs Playwright with Chromium.
"""
import functools
import subprocess
import sys
import threading
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

from playwright.sync_api import sync_playwright

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / ".lake" / "leancraftgame-web" / "online-test"

CASES = [
    # (name, what the socket does, is the host reachable, words the diagnosis must contain)
    ("refused, host up", "refuse", True, "refused the connection from this page"),
    ("host unreachable", "refuse", False, "cannot be reached from here"),
    ("closed before Lean started", "close", True, "closed the connection before Lean started"),
]


def main():
    subprocess.run([sys.executable, str(ROOT / "online" / "build.py"), "--out", str(OUT)], check=True,
                   stdout=subprocess.DEVNULL)
    # the diagnostics are about a live connection: test them as if the online version were not paused
    cfg = OUT / "config.js"
    cfg.write_text(cfg.read_text(encoding="utf-8").replace(', "livePaused": true', ""), encoding="utf-8")
    assert "livePaused" not in cfg.read_text(encoding="utf-8"), "config.js changed: cannot un-pause it"
    class Quiet(SimpleHTTPRequestHandler):
        def log_message(self, *args):
            pass
    handler = functools.partial(Quiet, directory=str(OUT))
    httpd = ThreadingHTTPServer(("127.0.0.1", 0), handler)
    threading.Thread(target=httpd.serve_forever, daemon=True).start()
    base = f"http://127.0.0.1:{httpd.server_address[1]}"
    failures = 0
    try:
        with sync_playwright() as p:
            browser = p.chromium.launch(headless=True)
            for name, socket, reachable, expected in CASES:
                page = browser.new_page()
                page.set_default_timeout(30000)
                errors = []
                page.on("pageerror", lambda e: errors.append(str(e)))
                # nothing leaves the machine: every request that is not to this local server is
                # intercepted; the probe of the Playground's home page is answered here, and
                # anything else is dropped and reported
                outside = []

                def make_guard(ok):
                    return lambda route, request: guard(route, ok)

                def guard(route, ok):
                    url = route.request.url
                    if url.startswith(base):
                        return route.continue_()
                    if url.rstrip("/") == "https://live.lean-lang.org":
                        return route.fulfill(status=200, body="ok") if ok else route.abort("connectionrefused")
                    if "goatcounter" not in url and "gc.zgo.at" not in url:
                        outside.append(url)
                    return route.abort()
                page.route("**/*", make_guard(reachable))
                # the socket: "refuse" points it at a closed local port (the browser then sees a real
                # refused connection: an error event and close code 1006); "close" is a stand-in
                # that opens, and closes with "busy" when asked to start Lean
                page.add_init_script("const mode = " + repr(socket).replace("'", '"') + ";" + """ {
                    const Real = window.WebSocket;
                    window.WebSocket = function (url, protocols) {
                        if (mode === "refuse") return new Real("ws://127.0.0.1:9/refused", protocols);
                        const ws = { readyState: 0, close() {}, send() {
                            setTimeout(() => ws.onclose && ws.onclose({ code: 1013, reason: "busy", wasClean: true }), 50); } };
                        setTimeout(() => { ws.readyState = 1; ws.onopen && ws.onopen(); }, 50);
                        return ws;
                    };
                }""")
                page.goto(f"{base}/?level=1", wait_until="networkidle")
                page.wait_for_selector("#questions .q-opt")
                code = (ROOT / "variants" / "L1" / "correct.lean").read_text(encoding="utf-8")
                page.evaluate("""c => { const el = document.querySelector('#src'); el.value = c;
                    el.dispatchEvent(new Event('input', {bubbles: true})); }""", code)
                page.click("#run")
                page.wait_for_function("document.querySelector('#summary').textContent.includes('Could not check')",
                                       timeout=60000)
                summary = page.locator("#summary").inner_text()
                details = page.locator(".conn-details pre").text_content() if page.locator(".conn-details").count() else ""
                report = page.evaluate("LiveRunner.lastDiagnostic && LiveRunner.lastDiagnostic.lines.join('\\n')")
                # "Report a problem" opens a prefilled GitHub issue: catch the URL instead
                issue = page.evaluate("""() => { let u = ""; window.open = (x) => { u = x; };
                    reportProblem(); return decodeURIComponent(new URL(u).searchParams.get("body") || ""); }""")
                ok = (expected in summary and "probe" in details and details == report and not errors
                      and not outside and "Last connection to the Lean Playground" in issue and report.splitlines()[-1] in issue)
                failures += not ok
                print(f"{'ok  ' if ok else 'FAIL'} {name}: {summary.splitlines()[0][:110]}")
                if not ok:
                    print("     details:", details.replace("\n", " | "), "| errors:", errors, "| outside:", outside)
                page.close()
            browser.close()
    finally:
        httpd.shutdown()
    print("All connection diagnostics behave as expected." if not failures else f"{failures} failure(s).")
    sys.exit(1 if failures else 0)


if __name__ == "__main__":
    main()

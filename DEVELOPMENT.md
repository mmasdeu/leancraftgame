# Developing the online version

The online version of the game (`online/build.py`, `web/static/live.js`) checks the player's
code on a [lean4web](https://github.com/leanprover-community/lean4web) server over a WebSocket.
The public one, the Lean Playground at live.lean-lang.org, belongs to the Lean community: **do
not develop or test against it.** Checking code there is paused in the published builds
(`LIVE_PAUSED` in `online/build.py`) until its use has been agreed with the server's owners.
For development, run a lean4web server on your own machine.

## A local lean4web server

Requirements: Linux, Node.js 20 or later, git and [bubblewrap](https://github.com/containers/bubblewrap)
(`sudo apt-get install bubblewrap`), and Mathlib built in this repository (`lake exe cache get`).

```bash
dev/lean4web.sh setup      # once: clones lean4web into .lean4web/ and prepares the project
dev/lean4web.sh start      # runs it on http://127.0.0.1:8090 (Ctrl+C to stop)
dev/lean4web.sh status     # in another terminal: is it up?
```

What `setup` does:

* clones lean4web at the commit this setup was tested with into `.lean4web/` (ignored by git),
  and installs its server only (not its editor, nor its test tools);
* patches the server to listen on `127.0.0.1` only: by default lean4web listens on every
  network interface, and anyone on your network could then run Lean on your machine;
* makes the project it serves, `.lean4web/ProjectsLCG/LeanCraftGame`, with this repository's
  Lean toolchain and Mathlib version (the public Playground follows Mathlib master). Its
  packages are hard links to `.lake/packages`, so they take no extra disk space. Re-run `setup`
  after updating Mathlib.

The server runs in lean4web's production mode, which starts each Lean server inside a
bubblewrap sandbox, as the public Playground does: development sees the same behaviour as
production, including the sandbox's limits.

`LEAN4WEB_PORT` and `LEAN4WEB_HOST` change the port and the address (not `PORT`/`HOST`: many
shells already set `HOST`).

## The game against the local server

```bash
python3 online/build.py --out dist/online-dev --live-server ws://127.0.0.1:8090
python3 -m http.server -d dist/online-dev 8001      # then open http://localhost:8001/
```

A build made with `--live-server` checks code on that server (`--live-project` names the
lean4web project, default `LeanCraftGame`), is never paused, does not count usage, and its
Welcome page says where the code goes. A build without it is the published one.

## Tests

| Command | Needs | Checks |
|---|---|---|
| `python3 tests/browser_live.py [LEVEL …]` | the local server running | the online game clears levels (default: a sample from every world) with their correct answers, checked on the server |
| `python3 tests/browser_connection.py` | nothing | the diagnoses of failed connections, with the server played by the test |
| `python3 tests/browser_questions.py` | Lean (the local `web/server.py` is started by the test) | the reading levels' question buttons |

All three run a headless Chromium through [Playwright](https://playwright.dev/python/), and
contact nothing but this machine.

## Production

Before the published builds use any public server again, talk to its owners about the expected
traffic and whether this is intended use, or host a lean4web instance for the game (the same
setup, with a domain, TLS and the sandbox). The Lean community also suggested
[lean4game](https://github.com/leanprover-community/lean4game)'s open API as an option, again
after asking its maintainers.

# Installing and running DefGame

DefGame runs on your own machine: a small local server runs Lean, and you play
in your web browser. One player at a time; no accounts.

## The easy way: download the app

The [DefGame website](https://mmasdeu.github.io/DefGame/) links to a ready-made app
for Windows, macOS (Apple Silicon) and Linux, which you can also find on the
[Releases page](https://github.com/mmasdeu/DefGame/releases). Nothing else needs to be
installed first.

* **Windows:** unzip `DefGame-windows-x64.zip` and run `DefGame.exe` in the `DefGame`
  folder. Windows may warn about an unrecognized app: choose *More info → Run anyway*.
  A console window shows what the game is doing; closing it stops the game.
* **macOS:** open `DefGame-macos-arm64.dmg` and drag DefGame to Applications. The
  first time, right-click it and choose *Open*, because the app is not notarized.
* **Linux:** unpack `DefGame-linux-x64.tar.gz` and run `DefGame/DefGame`. It needs
  glibc 2.35 or newer (Ubuntu 22.04, Debian 12, Fedora 36 or later).

The game opens in your web browser. On the first launch it downloads Lean (about
300 MB) and the parts of Mathlib the game uses (about 450 MB), which take about 6 GB
on disk. You can read the first levels while this happens. After that, the game
works offline. **Quit** in the top right corner stops it.

Everything the app downloads goes into one folder, so deleting that folder
uninstalls it completely:

| System | Folder |
|---|---|
| Windows | `%LOCALAPPDATA%\DefGame` |
| macOS | `~/Library/Application Support/DefGame` |
| Linux | `~/.local/share/defgame` |

If you already have Lean installed with elan and the right toolchain, the app uses it
instead of downloading its own. The folder also holds `defgame.log`, which is the place
to look if something goes wrong.

The rest of this file is about running the game from a copy of this repository,
which is what you need to change levels or the referee.

## Requirements

* **Lean 4** installed through [elan](https://github.com/leanprover/elan), so
  that `lake` is on your `PATH`. The project pins Lean `v4.35.0` in
  `lean-toolchain`, and elan downloads it on first use.
* **Mathlib** (tag `v4.35.0`), which `lake` fetches for you (see below). The
  prebuilt Mathlib files take about 6 GB of disk space.
* **Python 3.9 or newer.** Only the standard library is used: nothing to `pip install`.
* A recent web browser (Firefox, Chrome, Safari, Edge).
* Linux or macOS. On Windows, use WSL.
* Memory: each test runs in its own Lean process that loads Mathlib's tactics.
  Most of that memory is shared between processes; each one adds about
  250 MB. 8 GB of RAM is enough for the default settings.

## First time: download Mathlib

From the project directory:

```bash
lake exe cache get
```

This downloads Mathlib's source and its prebuilt `.olean` files (a few minutes
on a good connection). It is the only step that needs the network: after it,
the game runs fully offline. (MathJax, which typesets the formulas in the
referee's report, is bundled in `web/static/vendor/mathjax/`.) Do not skip it: without the prebuilt files, the next
step would compile Mathlib from source, which takes hours.

## Start the game

```bash
python3 web/server.py --open
```

This builds the referee (`lake build DefGame.Referee`, a few seconds),
starts the server on <http://localhost:8000/> and opens it in your browser.
Leave the terminal open while you play and press `Ctrl+C` to stop.

Options:

| Option | Default | Meaning |
|---|---|---|
| `--port N` | `8000` | port to listen on (use another one if 8000 is taken) |
| `--jobs N` | number of CPU cores | how many tests run in parallel |
| `--timeout S` | `60` | seconds a single test may run before it counts as ❓ (an open-problem test that runs out of time counts as ✅: nothing settled it) |
| `--open` | off | open the game in your default browser |

## Playing

* Pick a level at the top. The level text is on the left, above the editor.
* Edit the code and press **Run tests** (or `Ctrl+Enter`).
* Type Lean symbols with a backslash, as in VS Code: `\forall` gives ∀,
  `\exists` ∃, `\to` →, `\and` ∧, `\or` ∨, `\le` ≤, `\ge` ≥, `\ne` ≠, `\N` ℕ,
  `\_2` ₂. A symbol appears once the abbreviation is complete; press space or
  `Tab` to finish an ambiguous one such as `\to`. The **∀ Symbols** button at
  the top right opens a table of all symbols (click one to insert it, and see
  the plain-keyboard spelling Lean also accepts, like `->` or `<=`) and a short
  typing drill.
* Your code is checked first. Errors are shown under the editor; click one to
  jump to it.
* Then each hidden test runs in its own Lean process, and its result appears
  as soon as it is known: ✅ as expected, ❌ the referee proved the opposite,
  ❓ the referee could not settle it. Failed tests have a **Hint**.
* **Run tests** stops at the first ❌: the tests still running are cancelled
  and shown as `–` (not run). The ▶ button next to a test runs only that test.
* Every result belongs to the exact code it was computed for. As soon as you
  edit the code, the earlier results turn grey (undefined); undoing the edit
  brings them back. A level is cleared when **every test has passed on the same
  code**.
* Tests that end up ❓ are the slow ones: the referee tries every move it
  knows, until the time limit (60 s by default) stops it. A timer shows which
  tests are still running. **Stop** cancels the run. Some tests that should pass
  need up to about 40 s on an 8-core machine. On a slower machine, or with
  fewer cores, such a test can hit the limit and show ❓: raise it with
  `--timeout 120`.

Your code for each level and the levels you cleared are saved in the
browser (`localStorage`), so you can close the tab and come back. **Reset**
restores a level's original file.

Verdicts are cached in `.lake/defgame-web/cache.json`, keyed by the exact
file sent to Lean and the referee's source, so running the same code again is
instant. Delete that file to clear the cache.

## Command line

The web server can also run a level without a browser, which is handy for
checking answers. The number is the level's directory (`DefGame/L<n>`):

```bash
python3 web/server.py --run 1 variants/L1/correct_a.lean
```

To check every level against all its sample answers (after changing the
referee or a level), run `python3 check_levels.py`. The first run takes about
25 minutes on 8 cores; verdicts are cached, so later runs only redo what changed. The web version never modifies the `Player.lean` files.

## Security note

The server runs whatever Lean code you submit, and Lean code can run programs
on your machine (for example with `#eval`). The server therefore listens only
on `localhost`. Do not expose it to a network or let other people submit code
to it.

## Troubleshooting

* **"`lake` was not found on your PATH"**: install elan, then open a new
  terminal (or run `source ~/.elan/env`).
* **Starting the server seems to hang on "Building the referee"**, or lake
  prints thousands of `Mathlib` build jobs: the prebuilt Mathlib files are
  missing. Stop it and run `lake exe cache get`.
* **"Could not listen on port 8000"**: another program uses that port; run
  with `--port 8001`.
* **"The level could not be set up with your code"**: your code compiles, but
  something the tests rely on is missing, for example you renamed
  `TendsToInfinity` or deleted `IsPrime`. Press **Reset** to see the original.
* **A ⚠️ on a test**: Lean could not even state the test with your definition.
  The message shows Lean's error.

## Making a release

`.github/workflows/release.yml` builds the app on GitHub's Windows, macOS and Linux
machines. Pushing a tag starting with `v` publishes a release:

```bash
git tag v0.1.0
git push origin v0.1.0
```

The workflow builds the referee and the Mathlib pack (`app/make_pack.py`), builds
the app for each system (`app/build_app.py`), and runs each app's self-test on a
fresh machine: install Lean and Mathlib, then play two levels with a correct and a
buggy answer. Only if all three pass does it publish the apps and the pack as a
GitHub Release. Running the workflow by hand (Actions → Release → Run workflow)
builds and tests without publishing.

### The website

The landing page is `site/index.html`, a single static file with no external resources.
Its download buttons point to the latest release, and it uses the GitHub API to show
the version and the file sizes (without it, the plain links still work). The buttons
rely on the files of a release having these exact names, which `app/build_app.py` gives them:
`DefGame-windows-x64.zip`, `DefGame-macos-arm64.dmg`, `DefGame-linux-x64.tar.gz`.

`.github/workflows/pages.yml` copies `site/` to the `gh-pages` branch whenever it changes
on `main`. One-time setup, after the workflow has run once and created the branch:
*Settings → Pages → Build and deployment → Source: Deploy from a branch → `gh-pages`, `/ (root)`*.
The site is then at <https://mmasdeu.github.io/DefGame/>. To preview it locally:
`python3 -m http.server --directory site`.

### Trying the app without a release

To try the app from a checkout without freezing it:

```bash
lake exe cache get && lake build DefGame.Referee
python3 app/make_pack.py --out dist --url-base file:///unused
DEFGAME_DEPS=dist/deps.json DEFGAME_PACK_FILE=$(ls dist/mathlib-*.tar.xz) python3 app/launcher.py
```

## Adding or changing a level

A level is a directory `DefGame/L<n>/` with three files:

* `Player.lean`: the starting code. Its first `/- … -/` comment is shown as
  the level text (Markdown); the rest goes into the editor. Right after that
  comment come the level's imports. The referee always loads
  `Mathlib.Tactic`; a level that needs more of Mathlib (say, real numbers)
  imports it here. Every test pays for what is imported: `Mathlib.Tactic`
  takes about 3 s to load, the whole of `Mathlib` about 7 s.
* `Tests.lean`: the hidden test battery, written with the referee's
  `#expect_*` commands. The server runs each `#expect_*` command separately, with
  the other commands of the file (such as `open` and helper `def`s) in front of it.
* `level.json`: the title, world and skill shown in the menu, plus:
  * `checks`: Lean snippets that must compile against the player's code, each
    with the message to show if it does not (used to check names and types);
  * `hints`: `{ "match": …, "hint": … }` pairs; a failed test shows the hint
    of the first `match` that occurs in its name.

Add the level number to `LEVELS` in `web/server.py`. The list is the order in
which levels are played; the number shown to the player is the position in the
list, whatever the directory is called. The server reads the level files on
every request, so edits show up after a page reload, without a restart.

Things to know when writing a level:

* The lesson text supports headings (`#`), lists, `**bold**`, `*italic*`,
  `` `code` `` and fenced code blocks. Do not put bold text around inline code.
* Start with a worked example that is already filled in (and tested), then ask
  for similar definitions: beginners learn from reading.
* Every test is its own Lean process, so keep tests quick; prefer values that
  `decide` or `omega` settle.
* A bare `sorry` is a syntax error inside a `structure`. For structure levels,
  leave the structure compiling without its axioms (the junk tests then fail
  with a hint) and mark where the axiom goes with a comment.
* Give each hint a distinctive `match`, plus a final `{ "match": "", … }`
  entry as the fallback: the first match wins and `""` matches every test.
* Put a correct answer and some typical wrong answers in `variants/L<n>/`.
  Check each wrong answer fails the test designed for it:
  `python3 web/server.py --run <n> variants/L<n>/<file>.lean`.

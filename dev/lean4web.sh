#!/usr/bin/env bash
# A local lean4web server for developing the online version of the game, so that development
# never uses the public Lean Playground (live.lean-lang.org). See DEVELOPMENT.md.
#
#   dev/lean4web.sh setup     once: clone lean4web into .lean4web/, install the server, and make
#                             the project it serves (this repository's Lean and Mathlib)
#   dev/lean4web.sh start     run the server on http://127.0.0.1:8090 (Ctrl+C to stop)
#   dev/lean4web.sh status    is it running, and which projects does it serve?
#
# Environment: LEAN4WEB_PORT (default 8090), LEAN4WEB_HOST (default 127.0.0.1: only this
# machine can connect).
#
# The server runs in lean4web's production mode, which starts each Lean server inside a
# bubblewrap sandbox (as on the public Playground), so `bwrap` must be installed. The project
# it serves, .lean4web/ProjectsLCG/LeanCraftGame, pins the same Lean and Mathlib as this
# repository; its packages are hard links to .lake/packages, so it takes no extra disk space
# (run `lake exe cache get` here first). Re-run `setup` after updating Mathlib.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIR="$ROOT/.lean4web"
REPO="https://github.com/leanprover-community/lean4web"
REV="c2868962fc70d1e6bef6c425432de8617da47d4b"      # the version this setup was tested with
PROJECTS="ProjectsLCG"
PROJECT="$DIR/$PROJECTS/LeanCraftGame"
# not HOST and PORT: a shell often has HOST set already (conda sets it to the platform name)
PORT="${LEAN4WEB_PORT:-8090}"
HOST="${LEAN4WEB_HOST:-127.0.0.1}"

need() { command -v "$1" >/dev/null || { echo "$1 is needed: $2" >&2; exit 1; }; }

setup() {
  need git "install git"
  need npm "install Node.js 20 or later (https://nodejs.org)"
  need bwrap "install bubblewrap (sudo apt-get install bubblewrap)"
  [ -d "$ROOT/.lake/packages/mathlib/.lake/build" ] ||
    { echo "Mathlib is not built here: run 'lake exe cache get' in $ROOT first." >&2; exit 1; }

  if [ ! -d "$DIR/.git" ]; then
    git clone -q "$REPO" "$DIR"
  fi
  git -C "$DIR" fetch -q origin "$REV" 2>/dev/null || true
  git -C "$DIR" checkout -q "$REV"

  # Listen on HOST only (lean4web listens on every interface). The patch is checked, so a
  # newer lean4web that moved this line fails here instead of silently listening everywhere.
  local idx="$DIR/server/index.mjs"
  if ! grep -q "process.env.HOST" "$idx"; then
    local old='  server = app.listen(PORT, () => console.log(`HTTP on port ${PORT}`))'
    grep -qF "$old" "$idx" || { echo "lean4web changed: cannot restrict it to HOST, see $idx" >&2; exit 1; }
    python3 - "$idx" <<'EOF'
import sys
from pathlib import Path
p = Path(sys.argv[1]); s = p.read_text()
old = "  server = app.listen(PORT, () => console.log(`HTTP on port ${PORT}`))"
new = ("  // patched by leancraftgame's dev/lean4web.sh: HOST (default all interfaces) to listen on localhost only\n"
       "  server = app.listen(PORT, process.env.HOST || undefined, () => console.log(`HTTP on ${process.env.HOST || '*'}:${PORT}`))")
p.write_text(s.replace(old, new))
EOF
  fi

  # The server only (not the editor client, nor Cypress). It also imports vscode-ws-jsonrpc,
  # which lean4web declares for the client only.
  (cd "$DIR" && npm install --workspace @leanweb/server --include-workspace-root=false --no-audit --no-fund >/dev/null)
  local v
  v="$(cd "$DIR" && node -e 'console.log(require("./package-lock.json").packages["node_modules/vscode-ws-jsonrpc"].version)')"
  (cd "$DIR" && npm install --no-save --workspace @leanweb/server --include-workspace-root=false \
      --no-audit --no-fund "vscode-ws-jsonrpc@$v" >/dev/null)

  # The project: this repository's toolchain and Mathlib, packages as hard links.
  mkdir -p "$PROJECT/.lake"
  cp "$ROOT/lean-toolchain" "$ROOT/lake-manifest.json" "$PROJECT/"
  cat > "$PROJECT/lakefile.toml" <<EOF
name = "LeanCraftGame"
defaultTargets = ["LeanCraftGame"]

[[require]]
name = "mathlib"
scope = "leanprover-community"
rev = "$(sed -n 's/^rev = "\(.*\)"$/\1/p' "$ROOT/lakefile.toml")"

[[lean_lib]]
name = "LeanCraftGame"
EOF
  echo 'import Mathlib.Tactic' > "$PROJECT/LeanCraftGame.lean"
  cat > "$PROJECT/leanweb-config.json" <<'EOF'
{ "name": "Lean Craft Game (_LeanVers_, pinned Mathlib)", "default": true, "hidden": false, "sortOrder": 0, "examples": [] }
EOF
  rm -rf "$PROJECT/.lake/packages"
  cp -al "$ROOT/.lake/packages" "$PROJECT/.lake/packages"
  # Loading a module the first time may write a small trace file (`.hash`) next to it, which the
  # read-only sandbox forbids ("read-only file system"): write them all now, outside it. Nothing
  # is compiled, and the new files go into the project's own folders, not this repository's.
  (cd "$PROJECT" && lake build Mathlib >/dev/null)
  echo "Set up: $DIR (lean4web ${REV:0:9}), serving $PROJECT"
  echo "Start it with: dev/lean4web.sh start"
}

start() {
  [ -d "$PROJECT/.lake/packages" ] || { echo "Run 'dev/lean4web.sh setup' first." >&2; exit 1; }
  need bwrap "install bubblewrap (sudo apt-get install bubblewrap)"
  echo "lean4web on http://$HOST:$PORT, project LeanCraftGame: build the game for it with"
  echo "  python3 online/build.py --out dist/online-dev --live-server ws://$HOST:$PORT"
  cd "$DIR/server"         # lean4web starts ./bubblewrap.sh from here
  exec env PROJECTS_BASE_PATH="$PROJECTS" PORT="$PORT" HOST="$HOST" NODE_ENV=production node index.mjs
}

status() {
  if curl -fsS "http://$HOST:$PORT/health" >/dev/null 2>&1; then
    echo "running on http://$HOST:$PORT, projects:"
    curl -fsS "http://$HOST:$PORT/api/projects"; echo
  else
    echo "not running on http://$HOST:$PORT"; exit 1
  fi
}

case "${1:-}" in
  setup) setup ;;
  start) start ;;
  status) status ;;
  *) sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'; exit 2 ;;
esac

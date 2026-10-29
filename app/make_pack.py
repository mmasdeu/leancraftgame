#!/usr/bin/env python3
"""Build the Mathlib pack for the app: the compiled Lean files the game loads, outside Lean's core.

Run in a checkout, after `lake exe cache get` and `lake build DefGame.Referee`:

    python3 app/make_pack.py --out dist --url-base https://github.com/OWNER/REPO/releases/download/TAG

Writes to the output folder:

    mathlib-<id>.tar.xz           the pack: every module of Mathlib and its dependencies
                                  that the referee or a level imports, directly or not
    deps.json                     what the app needs: the toolchain, and the pack's id, URL,
                                  sha256 and size
    olean/DefGame/Referee.olean   the compiled referee, which goes inside the app

The id names the Mathlib revision, the toolchain and a hash of the module list, so the app
downloads a new pack only when its content changes.
"""
import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
# What Lean reads when importing a module: its data (.olean, and the .private and .server
# parts of modules using the module system) and its compiled code (.ir, which the
# interpreter runs for `initialize` declarations).
KEEP = [".olean", ".olean.private", ".olean.server", ".ir", ".ir.sig"]

CLOSURE = """{imports}
#eval show Lean.CoreM Unit from do
  let sp ← Lean.searchPathRef.get
  for m in (← Lean.getEnv).header.moduleNames do
    if let some f ← sp.findWithExt "olean" m then IO.println ("OLEAN " ++ f.toString)
"""


def game_imports():
    """`import DefGame.Referee` and the imports of every level's Player.lean."""
    imports = {"import DefGame.Referee"}
    for player in sorted(ROOT.glob("DefGame/L*/Player.lean")):
        imports |= {l.strip() for l in player.read_text(encoding="utf-8").splitlines() if re.match(r"import\s", l)}
    return sorted(imports)


def closure():
    """The .olean files of every module the game loads."""
    with tempfile.TemporaryDirectory(dir=ROOT / ".lake") as tmp:
        f = Path(tmp) / "Closure.lean"
        f.write_text(CLOSURE.format(imports="\n".join(game_imports())), encoding="utf-8")
        r = subprocess.run(["lake", "env", "lean", str(f)], cwd=ROOT, capture_output=True,
                           encoding="utf-8", check=True)
    return [Path(l[6:]) for l in r.stdout.splitlines() if l.startswith("OLEAN ")]


def relative_to_lib(path):
    """Mathlib/Tactic.olean for …/.lake/build/lib/lean/Mathlib/Tactic.olean."""
    parts = path.parts
    for i in range(len(parts) - 2, 0, -1):
        if parts[i - 1] == "lib" and parts[i] == "lean":
            return Path(*parts[i + 1:])
    raise ValueError(f"not in a lib/lean folder: {path}")


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--out", type=Path, default=ROOT / "dist")
    ap.add_argument("--url-base", required=True, help="where the pack will be downloadable from")
    opts = ap.parse_args()
    out = opts.out.resolve()
    out.mkdir(parents=True, exist_ok=True)

    toolchain = (ROOT / "lean-toolchain").read_text(encoding="utf-8").strip()
    manifest = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
    mathlib_rev = next(p["rev"] for p in manifest["packages"] if p["name"] == "mathlib")
    own = (ROOT / ".lake" / "build").resolve()

    files = []
    for olean in closure():
        olean = olean.resolve()
        if own in olean.parents:
            continue                  # DefGame's own modules: only the referee is needed, shipped in the app
        if "toolchains" in olean.parts:
            continue                  # Lean's core library comes with the toolchain
        for suffix in KEEP:
            f = olean.with_name(olean.stem + suffix)
            if f.exists():
                files.append((f, relative_to_lib(f)))
    names = sorted(str(rel.as_posix()) for _, rel in files)
    tag = hashlib.sha256("\n".join(names).encode()).hexdigest()[:8]
    pack_id = f"{mathlib_rev[:12]}-{toolchain.split(':')[-1]}-{tag}"
    name = f"mathlib-{pack_id}.tar.xz"
    print(f"{len(files)} files, {sum(f.stat().st_size for f, _ in files) / 1e9:.2f} GB -> {name}")

    with tempfile.TemporaryDirectory(dir=out) as stage:
        for f, rel in files:
            dest = Path(stage) / rel
            dest.parent.mkdir(parents=True, exist_ok=True)
            try:
                os.link(f, dest)
            except OSError:
                shutil.copy2(f, dest)
        tar = subprocess.Popen(["tar", "--sort=name", "--mtime=@0", "--owner=0", "--group=0",
                                "--numeric-owner", "-C", stage, "-cf", "-", "."], stdout=subprocess.PIPE)
        with open(out / name, "wb") as dst:
            subprocess.run(["xz", "-T0", "-6"], stdin=tar.stdout, stdout=dst, check=True)
        if tar.wait() != 0:
            raise SystemExit("tar failed")

    h = hashlib.sha256()
    with open(out / name, "rb") as f:
        while chunk := f.read(1 << 20):
            h.update(chunk)
    deps = {"toolchain": toolchain, "id": pack_id, "file": name,
            "url": f"{opts.url_base.rstrip('/')}/{name}",
            "sha256": h.hexdigest(), "size": (out / name).stat().st_size}
    (out / "deps.json").write_text(json.dumps(deps, indent=2) + "\n", encoding="utf-8")
    referee = out / "olean" / "DefGame" / "Referee.olean"
    referee.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(own / "lib" / "lean" / "DefGame" / "Referee.olean", referee)
    print(json.dumps(deps, indent=2))


if __name__ == "__main__":
    main()

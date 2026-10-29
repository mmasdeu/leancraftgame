#!/usr/bin/env python3
"""Build the DefGame app for the current OS with PyInstaller, and package it.

    pip install pyinstaller certifi
    python3 app/build_app.py --deps dist/deps.json --olean dist/olean --out dist

(deps.json and the olean folder come from app/make_pack.py.) Produces, in the output folder:

    Windows   DefGame-windows-x64.zip       a folder with DefGame.exe
    macOS     DefGame-macos-<arch>.dmg      DefGame.app
    Linux     DefGame-linux-<arch>.tar.gz   a folder with the DefGame executable

and prints the path of the executable, for smoke tests.
"""
import argparse
import os
import platform
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--deps", type=Path, required=True)
    ap.add_argument("--olean", type=Path, required=True, help="folder holding DefGame/Referee.olean")
    ap.add_argument("--out", type=Path, default=ROOT / "dist")
    opts = ap.parse_args()
    out = opts.out.resolve()
    build = ROOT / "build"
    shutil.rmtree(build, ignore_errors=True)

    data = [(ROOT / "web" / "static", "web/static"), (ROOT / "DefGame", "DefGame"),
            (ROOT / "lean-toolchain", "."), (ROOT / "lake-manifest.json", "."),
            (opts.deps.resolve(), "."), (opts.olean.resolve(), "olean"),
            (ROOT / "variants" / "L4", "variants/L4"), (ROOT / "variants" / "L17", "variants/L17")]
    args = [str(ROOT / "app" / "launcher.py"), "--name", "DefGame", "--noconfirm", "--clean", "--onedir",
            "--paths", str(ROOT / "web"), "--hidden-import", "server", "--hidden-import", "certifi",
            "--distpath", str(build / "dist"), "--workpath", str(build / "work"), "--specpath", str(build)]
    for src, dest in data:
        args += ["--add-data", f"{src}{os.pathsep}{dest}"]
    if sys.platform == "darwin":
        args += ["--windowed", "--osx-bundle-identifier", "io.github.mmasdeu.defgame"]

    import PyInstaller.__main__
    PyInstaller.__main__.run(args)

    arch = {"amd64": "x64", "x86_64": "x64", "arm64": "arm64", "aarch64": "arm64"}.get(
        platform.machine().lower(), platform.machine().lower())
    out.mkdir(parents=True, exist_ok=True)
    dist = build / "dist"
    if os.name == "nt":
        package = out / f"DefGame-windows-{arch}.zip"
        shutil.make_archive(str(package.with_suffix("")), "zip", dist, "DefGame")
        exe = dist / "DefGame" / "DefGame.exe"
    elif sys.platform == "darwin":
        package = out / f"DefGame-macos-{arch}.dmg"
        package.unlink(missing_ok=True)
        subprocess.run(["hdiutil", "create", "-volname", "DefGame", "-srcfolder", str(dist / "DefGame.app"),
                        "-ov", "-format", "UDZO", str(package)], check=True)
        exe = dist / "DefGame.app" / "Contents" / "MacOS" / "DefGame"
    else:
        package = out / f"DefGame-linux-{arch}.tar.gz"
        shutil.make_archive(str(package).removesuffix(".tar.gz"), "gztar", dist, "DefGame")
        exe = dist / "DefGame" / "DefGame"
    print(f"package: {package} ({package.stat().st_size / 1e6:.1f} MB)")
    print(f"executable: {exe}")
    if os.environ.get("GITHUB_OUTPUT"):
        with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as f:
            f.write(f"package={package}\nexecutable={exe}\n")


if __name__ == "__main__":
    main()

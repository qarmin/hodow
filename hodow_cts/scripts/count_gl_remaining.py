#!/usr/bin/env python3
"""Count how many OpenGL entry points and test cases upstream's CTS exercises that hodow_cts does not.

Two figures per API family (desktop GL core, GLES 2.0-3.2):

  entry points   the Khronos registry (gl.xml) lists the universe per profile; upstream's test
                 sources are scanned for the calls they make (`gl.bindBuffer(` and `glBindBuffer(`
                 spellings); hodow_cts/src is scanned for `gl.bind_buffer(`. "Remaining" is
                 upstream-called minus hodow-called, restricted to the universe.
  test cases     the mustpass lists shipped with openglcts (one case name per line) against the
                 number of cases `hodow_cts --list` registers for the matching root.

Neither figure is a conformance measure. A call counted as "covered" only means some hodow test
makes it, not that the call is checked as thoroughly as upstream checks it. Names are matched
with underscores stripped and case folded, so `glGetIntegerv`, `gl.getIntegerv` and
`gl.get_integerv` meet. Calls made through other receivers (a local alias of the function table)
are missed on both sides.

Upstream checkout: the vendored copy under hodow_cts/upstream has only the ES modules, so the
desktop sources and mustpass lists come from a sparse clone, by default in tmp/cts-openglcts/src:

    git clone --depth 1 --filter=blob:none --sparse https://github.com/KhronosGroup/VK-GL-CTS.git tmp/cts-openglcts/src
    git -C tmp/cts-openglcts/src sparse-checkout set external/openglcts/modules external/openglcts/data/gl_cts/data/mustpass

Usage:
    python3 hodow_cts/scripts/count_gl_remaining.py [--cts-dir DIR] [--registry gl.xml] [--hodow-bin PATH] [--list-missing]
"""

from __future__ import annotations

import argparse
import glob
import re
import subprocess
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
DEFAULT_CTS_DIR = REPO_DIR / "tmp" / "cts-openglcts" / "src"

UPSTREAM_CALL = re.compile(r"\bgl\.([a-z][A-Za-z0-9]*)\(|\bgl([A-Z][A-Za-z0-9]*)\(")
HODOW_CALL = re.compile(r"\bgl(?:\(\))?\.([a-z][a-z0-9_]*)\(")
SOURCE_SUFFIXES = {".cpp", ".hpp", ".inl", ".h", ".c"}


def norm(name: str) -> str:
    if name.startswith("gl") and name[2:3].isupper():
        name = name[2:]
    return name.replace("_", "").lower()


def find_registry(explicit: Path | None) -> Path:
    paths = [explicit] if explicit else []
    paths += [Path(p) for p in sorted(glob.glob(str(Path.home() / ".cargo/registry/src/*/khronos_api-*/api/xml/gl.xml")))]
    for path in paths:
        if path and path.is_file():
            return path
    raise SystemExit("error: no gl.xml found; pass --registry (the khronos_api crate ships one)")


def universes(registry: Path) -> dict[str, set[str]]:
    """Normalised command names: `gl_core` (1.0-4.6 core profile) and `gles` (ES 2.0-3.2)."""
    root = ET.parse(registry).getroot()
    gl_core: set[str] = set()
    gles: set[str] = set()
    for feature in root.findall("feature"):
        api = feature.get("api")
        for child in feature:
            names = {norm(c.get("name")) for c in child.findall("command")}
            if api == "gl":
                if child.tag == "require" and child.get("profile") in (None, "core"):
                    gl_core |= names
                elif child.tag == "remove" and child.get("profile") == "core":
                    gl_core -= names
            elif api == "gles2" and child.tag == "require":
                gles |= names
    return {"gl_core": gl_core, "gles": gles}


def scan(roots: list[Path], pattern: re.Pattern[str], suffixes: set[str]) -> set[str]:
    found: set[str] = set()
    for root in roots:
        if not root.exists():
            continue
        for path in root.rglob("*"):
            if path.suffix not in suffixes or not path.is_file():
                continue
            text = path.read_text(errors="replace")
            for match in pattern.finditer(text):
                found.add(norm(next(g for g in match.groups() if g)))
    return found


def mustpass_cases(cts: Path) -> dict[str, int]:
    base = cts / "external/openglcts/data/gl_cts/data/mustpass"
    wanted = {
        "GL 4.6 khronos main": base / "gl/khronos_mustpass/main/gl46-main.txt",
        "GL 4.6 khronos gtf": base / "gl/khronos_mustpass/main/gl46-gtf-main.txt",
        "GL 4.5 aosp main": base / "gl/aosp_mustpass/main/gl45-main.txt",
        "GLES2 aosp main": base / "gles/aosp_mustpass/main/gles2-main.txt",
        "GLES3 aosp main": base / "gles/aosp_mustpass/main/gles3-main.txt",
        "GLES31 aosp main": base / "gles/aosp_mustpass/main/gles31-main.txt",
        "GLES2 khr main": base / "gles/khronos_mustpass/main/gles2-khr-main.txt",
        "GLES3 khr main": base / "gles/khronos_mustpass/main/gles3-khr-main.txt",
        "GLES31 khr main": base / "gles/khronos_mustpass/main/gles31-khr-main.txt",
        "GLES32 khr main": base / "gles/khronos_mustpass/main/gles32-khr-main.txt",
    }
    return {k: sum(1 for line in p.read_text().splitlines() if line.strip()) for k, p in wanted.items() if p.is_file()}


def hodow_cases(binary: Path | None) -> dict[str, int] | None:
    if binary is None or not binary.is_file():
        return None
    out: dict[str, int] = {}
    for prefix in ("dEQP-GLES2.", "dEQP-GLES3.", "dEQP-GLES31."):
        res = subprocess.run([str(binary), "--list", "-c", prefix + "*"], capture_output=True, text=True)
        out[prefix.rstrip(".")] = sum(1 for line in res.stdout.splitlines() if line.startswith(prefix))
    return out


def row(title: str, universe: set[str], upstream: set[str], hodow: set[str], list_missing: bool) -> None:
    called = upstream & universe
    covered = called & hodow
    remaining = called - hodow
    outside = upstream - universe
    print(f"{title}")
    print(f"  entry points in the registry:                {len(universe)}")
    print(f"  called by upstream test sources:             {len(called)}")
    print(f"  of those called by a hodow_cts test:         {len(covered)}")
    print(f"  REMAINING (upstream calls, hodow does not):  {len(remaining)}")
    print(f"  hodow calls beyond upstream's set:           {len((hodow & universe) - upstream)}")
    print(f"  upstream calls outside this universe (extensions, compat, shader-side names): {len(outside)}")
    if list_missing:
        print("  remaining: " + " ".join(sorted(remaining)))


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cts-dir", type=Path, default=DEFAULT_CTS_DIR)
    ap.add_argument("--registry", type=Path)
    ap.add_argument("--hodow-bin", type=Path, default=REPO_DIR / "target/debug/hodow_cts")
    ap.add_argument("--list-missing", action="store_true")
    args = ap.parse_args()

    cts_modules = args.cts_dir / "external/openglcts/modules"
    if not cts_modules.is_dir():
        print(f"error: {cts_modules} missing; see the docstring for the sparse clone command", file=sys.stderr)
        return 3

    uni = universes(find_registry(args.registry))
    src = CRATE_DIR / "src"
    upstream_desktop = scan([cts_modules / "gl", cts_modules / "common"], UPSTREAM_CALL, SOURCE_SUFFIXES)
    upstream_es_deqp = scan(
        [CRATE_DIR / "upstream/modules", CRATE_DIR / "upstream/framework/opengl"], UPSTREAM_CALL, SOURCE_SUFFIXES
    )
    upstream_es_glcts = scan(
        [cts_modules / d for d in ("gles2", "gles3", "gles31", "gles32", "glesext", "common")],
        UPSTREAM_CALL,
        SOURCE_SUFFIXES,
    )
    hodow_desktop = scan([src / "gl"], HODOW_CALL, {".rs"})
    hodow_all = scan([src], HODOW_CALL, {".rs"}) - set()

    print(f"upstream checkout: {args.cts_dir}\n")
    row("Desktop GL core 1.0-4.6 vs glcts modules/gl+common, hodow src/gl only", uni["gl_core"], upstream_desktop, hodow_desktop, args.list_missing)
    print()
    row("Desktop GL core 1.0-4.6 vs glcts modules/gl+common, hodow whole crate", uni["gl_core"], upstream_desktop, hodow_all, args.list_missing)
    print()
    row("GLES 2.0-3.2 vs deqp gles2/3/31 modules + framework/opengl (vendored), hodow whole crate", uni["gles"], upstream_es_deqp, hodow_all, args.list_missing)
    print()
    row("GLES 2.0-3.2 vs glcts gles2/3/31/32/glesext+common, hodow whole crate", uni["gles"], upstream_es_glcts, hodow_all, args.list_missing)
    print()
    print("Test cases in upstream mustpass lists:")
    for name, count in mustpass_cases(args.cts_dir).items():
        print(f"  {name:24} {count}")
    ours = hodow_cases(args.hodow_bin)
    print("\nCases registered by hodow_cts --list:")
    if ours is None:
        print(f"  (no binary at {args.hodow_bin}; build hodow_cts with --features gl and pass --hodow-bin)")
    else:
        for name, count in ours.items():
            print(f"  {name:24} {count}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

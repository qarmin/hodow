#!/usr/bin/env python3
"""
validate_gl_versions.py
-----------------------
Validates that every OpenGL function used in a test file is available in the
OpenGL core version declared by that test (via `fn gl_version()`).

Usage:
    python scripts/validate_gl_versions.py [--strict] [--csv PATH]

Exit codes:
    0 - all tests pass validation
    1 - one or more violations found

How it works:
1. Reads gl_functions.csv to build a mapping  function_name -> min_core_version.
2. Scans every *.rs file under hodow_core/src/opengl/tests/ (except mod.rs).
3. Extracts the declared GL version from `GLVersion::new(major, minor)`.
4. Extracts every `gl::FunctionName` call.
5. For each call, checks that the function's core_version <= declared_version.
   Functions that only appear in extensions (no core_version) are flagged in
   --strict mode; otherwise they are reported as warnings.
"""

from __future__ import annotations

import argparse
import csv
import re
import sys
from pathlib import Path
from typing import Optional

# ── Paths ────────────────────────────────────────────────────────────────────

ROOT = Path.cwd()
DEFAULT_CSV = ROOT / "data" / "gpu" / "gl_functions.csv"
TESTS_DIR = ROOT / "hodow_core" / "src" / "opengl" / "tests"

# ── Regex patterns ───────────────────────────────────────────────────────────

# Matches:  GLVersion::new(4, 3)
VERSION_RE = re.compile(r"GLVersion::new\(\s*(\d+)\s*,\s*(\d+)\s*\)")

# Matches:  gl::FunctionName  (CamelCase after gl::)
GL_CALL_RE = re.compile(r"\bgl::([A-Z][A-Za-z0-9_]*)\b")

# ── Helpers ───────────────────────────────────────────────────────────────────


def parse_version(v: str) -> Optional[tuple[int, int]]:
    """Parse '4.3' -> (4, 3); returns None for empty/invalid."""
    if not v:
        return None
    parts = v.strip().split(".")
    if len(parts) != 2:
        return None
    try:
        return (int(parts[0]), int(parts[1]))
    except ValueError:
        return None


def load_gl_csv(csv_path: Path) -> dict[str, Optional[tuple[int, int]]]:
    """Returns {gl_function_name: min_core_version_tuple_or_None}."""
    mapping: dict[str, Optional[tuple[int, int]]] = {}
    with csv_path.open(newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            sig = (row.get("signature") or "").strip()
            core = (row.get("core_version") or "").strip()
            name = sig.split("(", 1)[0].strip().strip('"')
            if not name.startswith("gl"):
                continue
            # Convert C-style glFooBar -> FooBar  (the gl:: crate uses CamelCase)
            # We keep both forms: original camelCase and PascalCase strip of 'gl' prefix
            # The `gl` crate exposes them as `gl::FooBar` (strips 'gl' prefix)
            short = name[2:]  # strip leading 'gl'
            ver = parse_version(core)
            # If already seen, keep the minimum version (earliest introduction)
            if short not in mapping:
                mapping[short] = ver
            elif ver is not None and (mapping[short] is None or ver < mapping[short]):
                mapping[short] = ver
    return mapping


def scan_test_file(path: Path) -> tuple[Optional[tuple[int, int]], list[str]]:
    """
    Returns (declared_version, [function_names_called]).
    declared_version is None if not found.
    """
    src = path.read_text(encoding="utf-8")
    m = VERSION_RE.search(src)
    declared: Optional[tuple[int, int]] = None
    if m:
        declared = (int(m.group(1)), int(m.group(2)))
    calls = GL_CALL_RE.findall(src)
    return declared, calls


# ── Constants and GL enum names we don't need to look up ─────────────────────

# These are constants/enum values exposed by the gl crate, not functions.
# They follow ALL_CAPS or mixed patterns; functions are CamelCase (first char uppercase,
# second char lowercase). We filter them out by checking the second character.
def is_function_name(name: str) -> bool:
    """Heuristic: function names start with an uppercase then lowercase (e.g. Clear),
    while constants are ALL_CAPS (e.g. COLOR_BUFFER_BIT) or fully uppercase."""
    if len(name) < 2:
        return False
    return name[1].islower()


# ── Main ─────────────────────────────────────────────────────────────────────


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument(
        "--strict",
        action="store_true",
        help="Treat extension-only functions (no core version) as errors instead of warnings",
    )
    parser.add_argument(
        "--csv",
        default=str(DEFAULT_CSV),
        metavar="PATH",
        help=f"Path to gl_functions.csv (default: {DEFAULT_CSV})",
    )
    parser.add_argument(
        "--tests-dir",
        default=str(TESTS_DIR),
        metavar="DIR",
        help=f"Directory containing GL test *.rs files (default: {TESTS_DIR})",
    )
    args = parser.parse_args()

    csv_path = Path(args.csv)
    tests_dir = Path(args.tests_dir)

    if not csv_path.exists():
        print(f"ERROR: CSV not found: {csv_path}", file=sys.stderr)
        return 2

    print(f"Loading GL function database from: {csv_path}")
    gl_db = load_gl_csv(csv_path)
    print(f"  Loaded {len(gl_db)} function entries.\n")

    test_files = sorted(p for p in tests_dir.glob("*.rs") if p.stem != "mod")
    if not test_files:
        print(f"WARNING: No test files found in {tests_dir}")
        return 0

    total_violations = 0
    total_warnings = 0

    for test_file in test_files:
        declared_ver, calls = scan_test_file(test_file)

        if declared_ver is None:
            print(f"[SKIP]  {test_file.name} — no GLVersion::new(...) found")
            continue

        # De-duplicate calls
        unique_calls = sorted(set(c for c in calls if is_function_name(c)))

        violations: list[str] = []
        warnings: list[str] = []
        ok_calls: list[str] = []

        for func in unique_calls:
            if func not in gl_db:
                warnings.append(f"  [?] gl::{func} — not found in CSV (possibly a constant or missing entry)")
                continue
            min_ver = gl_db[func]
            if min_ver is None:
                msg = f"  [W] gl::{func} — extension-only, no core version"
                if args.strict:
                    violations.append(msg.replace("[W]", "[E]"))
                else:
                    warnings.append(msg)
            elif min_ver > declared_ver:
                violations.append(
                    f"  [E] gl::{func} — requires GL {min_ver[0]}.{min_ver[1]}, "
                    f"but test declares GL {declared_ver[0]}.{declared_ver[1]}"
                )
            else:
                ok_calls.append(func)

        status = "FAIL" if violations else ("WARN" if warnings else "OK  ")
        ver_str = f"GL {declared_ver[0]}.{declared_ver[1]}"
        print(f"[{status}] {test_file.name} ({ver_str}) — {len(unique_calls)} functions checked")

        for v in violations:
            print(v)
        for w in warnings:
            print(w)

        if violations:
            total_violations += len(violations)
        if warnings:
            total_warnings += len(warnings)

    print()
    print("=" * 70)
    if total_violations == 0:
        print(f"✓ Validation passed — 0 violations, {total_warnings} warning(s)")
        return 0
    else:
        print(f"✗ Validation FAILED — {total_violations} violation(s), {total_warnings} warning(s)")
        return 1


if __name__ == "__main__":
    sys.exit(main())


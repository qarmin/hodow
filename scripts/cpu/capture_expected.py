#!/usr/bin/env python3
"""
Run 'just cpu' and capture test failures to populate data/cpu/expected/<arch>/<ext>.txt.

For each failing test the script extracts the actual 'Got' value and writes
it as the new expected value, so subsequent runs will verify against the
real CPU output instead of zeros.

Usage:
    python3 scripts/capture_expected.py [-- just-run-args...]
"""

import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import generate_tests as gt  # noqa: E402  - single source of truth for where values live

# Matches:  test_mm_foo(x86_64::AVX512BW) failed: Got VALUE, expected OLD
FAIL_RE = re.compile(r'(test_\w+)\([^)]+\) failed: Got (.+), expected ')


def to_rust_value(val: str) -> str:
    """Replace Rust Debug special float tokens with valid Rust literals."""
    val = re.sub(r'\bNaN\b',   'f32::NAN',          val)
    val = re.sub(r'\binf\b',   'f32::INFINITY',      val)
    val = re.sub(r'\b-inf\b',  'f32::NEG_INFINITY',  val)
    return val


def merge_and_write(captured: dict[str, str]) -> list[Path]:
    """Merge newly captured values into the per-extension files, touching only the extensions
    that actually produced a value. A recapture on one architecture used to rewrite the single
    4 MB file and show up as a diff against every other architecture's values."""
    existing = gt.load_expected_values()
    groups_map = gt.test_group_map()
    touched: dict[tuple[str, str], dict[str, str]] = {}
    unknown = []
    for name in captured:
        key = groups_map.get(name)
        if key is None:
            unknown.append(name)
            continue
        touched.setdefault(key, {})
    for name, value in {**existing, **captured}.items():
        key = groups_map.get(name)
        if key in touched:
            touched[key][name] = value
    if unknown:
        print(f"warning: {len(unknown)} captured value(s) match no known test, skipped: {unknown[:3]}")
    return gt.write_expected_values(touched)


def load_ev(path: Path) -> tuple[list[str], dict[str, str]]:
    """Load a single `name - value` file → (header_lines, {name: value})."""
    if not path.exists():
        return [], {}
    header: list[str] = []
    entries: dict[str, str] = {}
    in_header = True
    for line in path.read_text().splitlines():
        stripped = line.strip()
        if in_header and (not stripped or stripped.startswith("#")):
            header.append(line)
        else:
            in_header = False
            if " - " in stripped and not stripped.startswith("#"):
                name, _, value = stripped.partition(" - ")
                entries[name.strip()] = value.strip()
    return header, entries


def main() -> None:
    # Use current working directory as the repository root so scripts are
    # invoked as: python3 scripts/cpu/xxx.py from the repo root.
    base = Path.cwd()

    # Extra args forwarded to 'just cpu'
    extra = sys.argv[1:]

    print("Building and running tests…")
    result = subprocess.run(
        ["just", "cpu", *extra],
        cwd=base,
        capture_output=True,
        text=True,
    )
    output = result.stdout + result.stderr

    print(output)
    # Parse failures
    captured: dict[str, str] = {}
    for line in output.splitlines():
        m = FAIL_RE.search(line)
        if not m:
            continue
        test_name = m.group(1)
        got_val = to_rust_value(m.group(2).strip())
        captured[test_name] = got_val

    if not captured:
        print("No test failures found — no expected-value file modified.")
        print("(If tests passed, the existing expected values are already correct.)")
        return

    written = merge_and_write(captured)
    print(f"Captured {len(captured)} value(s) → {len(written)} file(s):")
    for path in written:
        print(f"  {path}")
    print()
    for name, val in sorted(captured.items()):
        print(f"  {name} - {val}")


if __name__ == "__main__":
    main()

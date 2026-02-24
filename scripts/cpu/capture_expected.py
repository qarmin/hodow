#!/usr/bin/env python3
"""
Run 'just cpu' and capture test failures to populate expected_cpu_values.txt.

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

# Matches:  test_mm_foo(SSE2) failed: Got VALUE, expected OLD
FAIL_RE = re.compile(r'(test_\w+)\(\w+\) failed: Got (.+), expected ')


def to_rust_value(val: str) -> str:
    """Replace Rust Debug special float tokens with valid Rust literals."""
    val = re.sub(r'\bNaN\b',   'f32::NAN',          val)
    val = re.sub(r'\binf\b',   'f32::INFINITY',      val)
    val = re.sub(r'\b-inf\b',  'f32::NEG_INFINITY',  val)
    return val


def load_ev(path: Path) -> tuple[list[str], dict[str, str]]:
    """Load expected_cpu_values.txt → (header_lines, {name: value})."""
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
    ev_path = base / "expected_cpu_values.txt"

    # Extra args forwarded to 'just cpu'
    extra = sys.argv[1:]

    print("Building and running tests…")
    result = subprocess.run(
        ["just", "run", *extra],
        cwd=base,
        capture_output=True,
        text=True,
    )
    output = result.stdout + result.stderr

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
        print("No test failures found — expected_cpu_values.txt not modified.")
        print("(If tests passed, the existing expected values are already correct.)")
        return

    header, existing = load_ev(ev_path)
    merged = {**existing, **captured}  # new values override old

    lines: list[str] = list(header)
    if lines and lines[-1].strip():
        lines.append("")
    for name in sorted(merged):
        lines.append(f"{name} - {merged[name]}")

    ev_path.write_text("\n".join(lines) + "\n")
    print(f"Captured {len(captured)} value(s) → {ev_path}  (total: {len(merged)} entries)")
    print()
    for name, val in sorted(captured.items()):
        print(f"  {name} - {val}")


if __name__ == "__main__":
    main()

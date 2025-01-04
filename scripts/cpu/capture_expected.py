#!/usr/bin/env python3
"""
Run 'just cpu' and capture test failures to populate data/cpu/expected/<arch>/<ext>.txt.

For each failing test the script extracts the actual 'Got' value and writes
it as the new expected value, so subsequent runs will verify against the
real CPU output instead of zeros.

Usage:
    python3 scripts/capture_expected.py [-- just-run-args...]
    python3 scripts/capture_expected.py --from-log <file>
    python3 scripts/capture_expected.py --from-report <file.json|file.csv>
"""

import csv
import json
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import generate_tests as gt  # noqa: E402  - single source of truth for where values live

# Matches:  test_mm_foo(x86_64::AVX512BW) failed: Got VALUE, expected OLD
FAIL_RE = re.compile(r'(test_\w+)\([^)]+\) failed: Got (.+), expected ')
# The same value in `--isolate`'s "Problematic tests" summary, which names the test in a
# fixed-width column instead: `  test_x86_tbm_blci_u32   FAIL: Got -3, expected 0 | call: ...`.
ISOLATE_FAIL_RE = re.compile(r'\b(test_\w+)\s+FAIL: Got (.+), expected ')
# A test that has no expected value yet reports one anyway rather than asserting against a zero
# placeholder (`Verdict::Unverified`), which is the only way a correct result of *zero* ever
# reaches this file - a mismatch line can never carry one.
UNVERIFIED_RE = re.compile(r'(test_\w+)\([^)]+\) unverified: nothing to compare against, got (.+)$')


def to_rust_value(val: str) -> str:
    """Replace Rust Debug special float tokens with valid Rust literals.

    Always f32 here: the generator's `_adjust_expected_for_ret` retypes them to f64 when the
    return's lane type calls for it, so the width does not have to be known at capture time."""
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


def parse_output(output: str) -> dict[str, str]:
    """{test_name: observed value} for every mismatch and every unverified test in the run."""
    captured: dict[str, str] = {}
    for line in output.splitlines():
        m = FAIL_RE.search(line) or ISOLATE_FAIL_RE.search(line) or UNVERIFIED_RE.search(line)
        if m:
            captured[m.group(1)] = to_rust_value(m.group(2).strip())
    return captured


def parse_report(path: Path) -> dict[str, str]:
    """{test_name: observed value} out of a `--report` file.

    `--isolate` prints counts, not values: an unverified test is not a "problematic" one, so
    it never reaches the summary the log carries. The report is the only place its observed
    value survives, which is what makes a remote board's values reachable at all."""
    text = path.read_text()
    records = list(csv.DictReader(text.splitlines())) if path.suffix.lower() == ".csv" else json.loads(text)
    captured: dict[str, str] = {}
    for r in records:
        got = r.get("got")
        if not got:
            continue
        if r.get("verdict") in ("unverified", "fail"):
            captured[r["name"]] = to_rust_value(got.strip())
    return captured


def main() -> None:
    # Use current working directory as the repository root so scripts are
    # invoked as: python3 scripts/cpu/xxx.py from the repo root.
    base = Path.cwd()

    # Extra args forwarded to 'just cpu'
    extra = sys.argv[1:]

    # A run on a machine this one cannot reach (`just cpu-remote`, a board someone else owns)
    # only ever comes back as a saved log or report, so allow ingesting one of those instead
    # of running locally.
    if extra[:1] == ["--from-report"]:
        if len(extra) != 2:
            sys.exit("usage: capture_expected.py --from-report <file.json|file.csv>")
        captured = parse_report(Path(extra[1]))
        finish(captured)
        return
    if extra[:1] == ["--from-log"]:
        if len(extra) != 2:
            sys.exit("usage: capture_expected.py --from-log <file>")
        output = Path(extra[1]).read_text()
    else:
        print("Building and running tests…")
        result = subprocess.run(
            ["just", "cpu", *extra],
            cwd=base,
            capture_output=True,
            text=True,
        )
        output = result.stdout + result.stderr
        print(output)

    finish(parse_output(output))


def finish(captured: dict[str, str]) -> None:
    if not captured:
        print("Nothing to capture — no expected-value file modified.")
        print("(Every test either matched its captured value or had no observable result.)")
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

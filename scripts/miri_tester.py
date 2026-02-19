#!/usr/bin/env python3
"""
Run 'just miri' in a loop and collect all failing tests, then re-run each individually
to gather comprehensive error information into miri_errors.txt.

Exits 0 if no errors found, 1 otherwise.

Output format in miri_errors.txt (one line per error):
    test_mm_load_ps -> Undefined Behavior: memory access failed: ...
"""

import re
import subprocess
import sys
from pathlib import Path

# Pattern to match Miri error lines (both UB and unsupported operations)
ERROR_RE = re.compile(r'^error: ((?:Undefined Behavior|unsupported operation):.+?)(?:\s*-->|$)')

# Test function path in backtrace - now more flexible with whitespace
TEST_FN_RE = re.compile(r'^\s*\d+:\s+cpu::auto_generated::[\w:]+::(test_\w+)')

# Debug mode flag
DEBUG = False


def parse_failing_tests(output: str) -> set[str]:
    """Extract names of failing tests from Miri backtrace."""
    failing = set()
    lines = output.splitlines()

    for i, line in enumerate(lines):
        # Look for error lines (both UB and unsupported operations)
        if line.startswith("error: Undefined Behavior:") or line.startswith("error: unsupported operation:"):
            if DEBUG:
                print(f"    [DEBUG] Found error at line {i}: {line[:80]}...")
            # Search forward in the backtrace for test function names
            for j in range(i, min(i + 50, len(lines))):
                if DEBUG and j < i + 10:
                    print(f"    [DEBUG]   Checking line {j}: {lines[j][:100] if len(lines[j]) > 0 else '(empty)'}")
                m = TEST_FN_RE.match(lines[j])
                if m:
                    if DEBUG:
                        print(f"    [DEBUG]   -> Matched test: {m.group(1)}")
                    failing.add(m.group(1))
                    break

    return failing


def parse_errors(output: str) -> list[tuple[str, str]]:
    """Return list of (test_fn_name, error_message) from Miri output."""
    results: list[tuple[str, str]] = []
    lines = output.splitlines()

    for i, line in enumerate(lines):
        m = ERROR_RE.match(line)
        if m:
            error_msg = m.group(1)
            # Search forward in the backtrace for test function name
            test_name = "unknown"
            for j in range(i, min(i + 50, len(lines))):
                tm = TEST_FN_RE.match(lines[j])
                if tm:
                    test_name = tm.group(1)
                    break
            results.append((test_name, error_msg))

    return results


def run_miri(base: Path, skip_tests: list[str] = None) -> tuple[int, str]:
    """Run 'just miri' with optional skip list. Returns (returncode, output)."""
    cmd = ["just", "miri"]
    if skip_tests:
        cmd.append("--")
        for test in skip_tests:
            cmd.extend(["--skip", test])

    if DEBUG:
        print(f"    [DEBUG] Command: {' '.join(cmd)}")

    proc = subprocess.run(
        cmd,
        cwd=base,
        capture_output=True,
        text=True,
    )
    return proc.returncode, proc.stdout + proc.stderr


def main() -> int:
    global DEBUG

    base = Path(__file__).parent.parent
    out_path = base / "miri_errors.txt"

    # Parse command-line arguments
    args = sys.argv[1:]
    if "-d" in args or "--debug" in args:
        DEBUG = True
        if "-d" in args:
            args.remove("-d")
        if "--debug" in args:
            args.remove("--debug")
        print("[DEBUG MODE ENABLED]")

    # Phase 1: Find all failing tests by running in a loop
    print("Phase 1: Finding all failing tests with Miri...")
    all_failing_tests = set()
    skip_list = []
    iteration = 0
    max_iterations = 1000  # Safety limit

    while iteration < max_iterations:
        iteration += 1
        print(f"  Iteration {iteration}: Running Miri (skipping {len(skip_list)} known failures)...")

        returncode, output = run_miri(base, skip_list)

        if returncode == 0:
            print(f"  ✓ All remaining tests passed!")
            break

        # Find new failing tests
        failing = parse_failing_tests(output)
        if not failing:
            # No test pattern found, might be a different error
            print("  ! No test failure pattern found, stopping iteration.")
            break

        new_failures = failing - all_failing_tests
        if not new_failures:
            # No new failures found, we're done
            print(f"  ✓ No new failures found, stopping iteration.")
            break

        all_failing_tests.update(new_failures)
        skip_list.extend(new_failures)
        print(f"  Found {len(new_failures)} new failing test(s): {', '.join(sorted(new_failures))}")

    if not all_failing_tests:
        print("No failing tests found.")
        if out_path.exists():
            out_path.unlink()
        return 0

    print(f"\nPhase 2: Re-running {len(all_failing_tests)} failing test(s) individually to collect errors...")

    # Phase 2: Re-run each failing test individually to collect all errors
    all_errors: dict[str, list[str]] = {}

    for test_name in sorted(all_failing_tests):
        print(f"  Running {test_name}...")
        # Run with all other tests skipped
        other_tests = [t for t in all_failing_tests if t != test_name]
        returncode, output = run_miri(base, other_tests)

        errors = parse_errors(output)
        if errors:
            for fn, msg in errors:
                if fn not in all_errors:
                    all_errors[fn] = []
                all_errors[fn].append(msg)
        else:
            # No error pattern found, but test failed - record generic message
            if test_name not in all_errors:
                all_errors[test_name] = []
            all_errors[test_name].append("Test failed (no specific error pattern found)")

    # Write results
    lines = []
    for fn in sorted(all_errors.keys()):
        for msg in all_errors[fn]:
            lines.append(f"{fn} -> {msg}")

    out_path.write_text("\n".join(lines) + "\n")

    total_errors = sum(len(msgs) for msgs in all_errors.values())
    print(f"\nFound {total_errors} error(s) in {len(all_errors)} test(s)  →  {out_path}")

    for fn in sorted(all_errors.keys()):
        for msg in all_errors[fn]:
            print(f"  {fn}:  {msg}")

    return 1


if __name__ == "__main__":
    sys.exit(main())

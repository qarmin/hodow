#!/usr/bin/env python3
"""
Run 'just miri' for batches of test functions and collect errors.

Tests functions in batches to avoid slow individual test execution.
When a batch fails, records the error and re-runs the batch with that test skipped.

Exits 0 if no errors found, 1 otherwise.

Output format in miri_errors.txt (one line per error):
    test_mm_load_ps -> Undefined Behavior: memory access failed: ...
"""

import re
import subprocess
import sys
import threading
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed

# Pattern to match Miri error lines (both UB and unsupported operations)
ERROR_RE = re.compile(r'^error: ((?:Undefined Behavior|unsupported operation):.+?)(?:\s*-->|$)')

# Test function path in backtrace
TEST_FN_RE = re.compile(r'^\s*\d+:\s+cpu::auto_generated::[\w:]+::(test_\w+)')

# Debug mode flag
DEBUG = False

# Lock for synchronized file writing
file_lock = threading.Lock()

BATCH_SIZE = 10
THREADS_NUMBER = 24


def get_all_test_functions(base: Path) -> list[str]:
    """Get list of all test functions by running the binary with --list-functions."""
    cmd = ["just", "run", "--", "--list-functions"]

    if DEBUG:
        print(f"[DEBUG] Getting test list: {' '.join(cmd)}")

    try:
        proc = subprocess.run(
            cmd,
            cwd=base,
            capture_output=True,
            text=True,
            timeout=60,
        )

        # Parse output - looking for lines that start with spaces (test names)
        tests = []
        output = proc.stdout + proc.stderr
        for line in output.splitlines():
            line = line.strip()
            if line.startswith("test_"):
                tests.append(line)

        if DEBUG:
            print(f"[DEBUG] Found {len(tests)} test functions")

        return tests
    except Exception as e:
        print(f"Error getting test list: {e}")
        return []


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


def test_batch(base: Path, batch_tests: list[str], skip_tests: list[str], out_path: Path, batch_num: int, total_batches: int) -> tuple[int, int, dict[str, str]]:
    """
    Test a batch of functions, iteratively removing failing ones from the batch.

    Returns: (passed, failed, errors_dict)
    """
    remaining_tests = [t for t in batch_tests if t not in skip_tests]
    batch_errors: dict[str, str] = {}
    iteration = 0
    max_iterations = len(batch_tests) + 10  # Safety limit

    print(f"\n[Batch {batch_num}/{total_batches}] Testing {len(remaining_tests)} functions...")

    while iteration < max_iterations and remaining_tests:
        iteration += 1

        # Test only the remaining tests in this batch using -t
        cmd = ["just", "miri", "--", "-t"] + remaining_tests

        if DEBUG:
            print(f"  [Iteration {iteration}] Testing {len(remaining_tests)} functions")
            print(f"  [DEBUG] Command: {' '.join(cmd[:10])}... (+ {len(remaining_tests)} test names)")

        try:
            proc = subprocess.run(
                cmd,
                cwd=base,
                capture_output=True,
                text=True,
                timeout=300,  # 5 minutes per batch
            )

            output = proc.stdout + proc.stderr

            if proc.returncode == 0:
                # All remaining tests in batch passed
                if DEBUG:
                    print(f"  [Iteration {iteration}] ✓ Batch completed successfully")
                break

            # Parse errors from output
            errors = parse_errors(output)

            if not errors:
                # Test failed but no error pattern found
                if DEBUG:
                    print(f"  [Iteration {iteration}] ✗ Test failed but no error pattern found")
                    print(output[:500])
                break

            # Process new errors and remove from remaining tests
            new_failures = 0
            for test_name, error_msg in errors:
                if test_name not in batch_errors:
                    batch_errors[test_name] = error_msg
                    new_failures += 1

                    # Remove from remaining tests
                    if test_name in remaining_tests:
                        remaining_tests.remove(test_name)

                    # Write to file immediately with lock
                    with file_lock:
                        with open(out_path, 'a') as f:
                            f.write(f"{test_name} -> {error_msg}\n")
                            f.flush()

                    print(f"    ✗ {test_name}: {error_msg[:60]}...")

            if new_failures == 0:
                # No new failures found, exit loop
                if DEBUG:
                    print(f"  [Iteration {iteration}] No new failures, stopping")
                break

        except subprocess.TimeoutExpired:
            print(f"  ✗ Batch timed out (>5 minutes)")
            break
        except Exception as e:
            print(f"  ✗ Exception during batch test: {e}")
            break

    passed = len(batch_tests) - len(batch_errors)
    failed = len(batch_errors)

    print(f"[Batch {batch_num}/{total_batches}] Results: {passed} passed, {failed} failed")

    return passed, failed, batch_errors


def main() -> int:
    global DEBUG, BATCH_SIZE

    # Use current working directory (repo root) so script is invoked as
    # `python3 scripts/cpu/miri_tester.py` from repository root.
    base = Path.cwd()
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


    if "--batch-size" in args:
        idx = args.index("--batch-size")
        if idx + 1 < len(args):
            try:
                BATCH_SIZE = int(args[idx + 1])
                args.pop(idx)
                args.pop(idx)
            except ValueError:
                print("Warning: Invalid --batch-size value, using default (50)")

    print(f"Using batch size: {BATCH_SIZE}")
    if THREADS_NUMBER > 1:
        print(f"Using {THREADS_NUMBER} parallel batches")

    # Clear output file
    out_path.write_text("")

    # Get all test functions
    print("Getting list of all test functions...")
    test_functions = get_all_test_functions(base)

    if not test_functions:
        print("No test functions found!")
        return 0

    print(f"Found {len(test_functions)} test functions to check")

    # Split into batches
    batches = [test_functions[i:i + BATCH_SIZE] for i in range(0, len(test_functions), BATCH_SIZE)]
    total_batches = len(batches)

    print(f"Split into {total_batches} batches")

    # Process batches
    total_passed = 0
    total_failed = 0
    all_errors: dict[str, str] = {}
    global_skip: list[str] = []  # Tests to skip in ALL batches

    if THREADS_NUMBER > 1:
        # Parallel batch processing
        with ThreadPoolExecutor(max_workers=THREADS_NUMBER) as executor:
            futures = {
                executor.submit(test_batch, base, batch, global_skip, out_path, idx + 1, total_batches): idx
                for idx, batch in enumerate(batches)
            }

            for future in as_completed(futures):
                batch_idx = futures[future]
                try:
                    passed, failed, errors = future.result()
                    total_passed += passed
                    total_failed += failed
                    all_errors.update(errors)
                except Exception as e:
                    print(f"  ✗ Batch {batch_idx + 1} exception: {e}")
    else:
        # Sequential batch processing
        for idx, batch in enumerate(batches):
            passed, failed, errors = test_batch(base, batch, global_skip, out_path, idx + 1, total_batches)
            total_passed += passed
            total_failed += failed
            all_errors.update(errors)
            # Add failed tests to global skip list for subsequent batches
            global_skip.extend(errors.keys())

    # Summary
    print(f"\n{'='*80}")
    print(f"Final Results: {total_passed} passed, {total_failed} failed out of {len(test_functions)} tests")

    if total_failed > 0:
        print(f"\nErrors written to: {out_path}")
        print(f"\nFailed tests ({total_failed}):")
        for name, msg in sorted(all_errors.items()):
            print(f"  {name}: {msg[:100]}")
        return 1
    else:
        print("\n✓ All tests passed!")
        if out_path.exists():
            out_path.unlink()
        return 0


if __name__ == "__main__":
    sys.exit(main())


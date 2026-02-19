#!/usr/bin/env python3
"""
Run 'cargo miri' for each test function in parallel and collect errors.

Uses a thread pool to test multiple functions concurrently, with synchronized
file writing to avoid conflicts.

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


def test_single_function(base: Path, test_name: str, out_path: Path) -> tuple[str, bool, str | None]:
    """
    Test a single function with Miri.

    Returns: (test_name, success, error_message)
    """
    cmd = [
        "just", "miri", "--", "--test-function", test_name
    ]

    if DEBUG:
        print(f"[DEBUG] Testing {test_name}: {' '.join(cmd)}")

    try:
        proc = subprocess.run(
            cmd,
            cwd=base,
            capture_output=True,
            text=True,
            timeout=120,  # 2 minutes per test
        )

        output = proc.stdout + proc.stderr

        if proc.returncode == 0:
            return (test_name, True, None)

        # Parse errors from output
        errors = parse_errors(output)
        if errors:
            error_msg = errors[0][1]  # Take first error

            # Write to file immediately with lock
            with file_lock:
                with open(out_path, 'a') as f:
                    f.write(f"{test_name} -> {error_msg}\n")
                    f.flush()

            return (test_name, False, error_msg)
        else:
            print(output)
            # Test failed but no error pattern found
            error_msg = "Test failed (no specific error pattern found)"

            with file_lock:
                with open(out_path, 'a') as f:
                    f.write(f"{test_name} -> {error_msg}\n")
                    f.flush()

            return (test_name, False, error_msg)

    except subprocess.TimeoutExpired:
        error_msg = "Test timed out (>120s)"

        with file_lock:
            with open(out_path, 'a') as f:
                f.write(f"{test_name} -> {error_msg}\n")
                f.flush()

        return (test_name, False, error_msg)
    except Exception as e:
        error_msg = f"Exception during test: {e}"

        with file_lock:
            with open(out_path, 'a') as f:
                f.write(f"{test_name} -> {error_msg}\n")
                f.flush()

        return (test_name, False, error_msg)


def main() -> int:
    global DEBUG

    base = Path(__file__).parent.parent
    out_path = base / "miri_errors.txt"

    # Parse command-line arguments
    args = sys.argv[1:]
    num_threads = 1  # TODO - this is broken - do not use numbers other than 1

    if "-d" in args or "--debug" in args:
        DEBUG = True
        if "-d" in args:
            args.remove("-d")
        if "--debug" in args:
            args.remove("--debug")
        print("[DEBUG MODE ENABLED]")

    if "-j" in args:
        idx = args.index("-j")
        if idx + 1 < len(args):
            try:
                num_threads = int(args[idx + 1])
                args.pop(idx)  # Remove -j
                args.pop(idx)  # Remove the number
            except ValueError:
                print("Warning: Invalid -j value, using default (12)")

    print(f"Using {num_threads} parallel threads")

    # Clear output file
    out_path.write_text("")

    # Get all test functions
    print("Getting list of all test functions...")
    test_functions = get_all_test_functions(base)

    if not test_functions:
        print("No test functions found!")
        return 0

    print(f"Found {len(test_functions)} test functions to check")

    # Test all functions in parallel
    passed = 0
    failed = 0
    errors_dict: dict[str, str] = {}

    with ThreadPoolExecutor(max_workers=num_threads) as executor:
        # Submit all tasks
        futures = {
            executor.submit(test_single_function, base, test_name, out_path): test_name
            for test_name in test_functions
        }

        # Process results as they complete
        for future in as_completed(futures):
            test_name = futures[future]
            try:
                name, success, error_msg = future.result()

                if success:
                    passed += 1
                    print(f"  ✓ {name} ({passed + failed}/{len(test_functions)})")
                else:
                    failed += 1
                    errors_dict[name] = error_msg
                    print(f"  ✗ {name}: {error_msg[:80]}... ({passed + failed}/{len(test_functions)})")
            except Exception as e:
                failed += 1
                print(f"  ✗ {test_name}: Exception: {e}")

    # Summary
    print(f"\n{'='*80}")
    print(f"Results: {passed} passed, {failed} failed out of {len(test_functions)} tests")

    if failed > 0:
        print(f"\nErrors written to: {out_path}")
        print(f"\nFailed tests ({failed}):")
        for name, msg in sorted(errors_dict.items()):
            print(f"  {name}: {msg[:100]}")
        return 1
    else:
        print("\n✓ All tests passed!")
        if out_path.exists():
            out_path.unlink()
        return 0


if __name__ == "__main__":
    sys.exit(main())


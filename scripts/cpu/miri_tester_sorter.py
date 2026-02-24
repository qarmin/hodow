#!/usr/bin/env python3
from pathlib import Path
import re
import sys

# keep the regex for exact matches as a fallback, but we'll also match more loosely
ALIGNMENT_RE = re.compile(r"undefined behavior: accessing memory with alignment \d+, but alignment \d+ is required", re.IGNORECASE)


def canonical_message(msg: str) -> str:
    s = msg.lower()
    # alignment-related messages: group them into a single category
    # match loosely: any message mentioning 'accessing memory' and 'alignment'
    if ("accessing memory" in s and "alignment" in s) or ALIGNMENT_RE.search(s):
        return "Undefined Behavior: accessing memory with alignment"
    if "can't call foreign function" in s or "unsupported operation: can't call foreign function" in s:
        return "unsupported operation: can't call foreign function"
    if "requires unavailable target features" in s or "calling a function that requires unavailable target features" in s:
        return "Undefined Behavior: calling a function that requires unavailable target features"
    if "memory access failed" in s or "attempting to access" in s:
        return "Undefined Behavior: memory access failed"
    if "inline assembly" in s:
        return "inline assembly is not supported"
    return msg.strip()


def parse_errors(path: Path):
    entries = []
    pattern = re.compile(r"^\s*(?P<test>[^\s]+)\s*->\s*(?P<msg>.+)$")
    with path.open("r", encoding="utf-8", errors="replace") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            m = pattern.match(line)
            if m:
                test = m.group("test").strip()
                msg = m.group("msg").strip()
                entries.append((test, msg))
            else:
                parts = line.split("->", 1)
                if len(parts) == 2:
                    test = parts[0].strip()
                    msg = parts[1].strip()
                    entries.append((test, msg))
    return entries


def color_header(s: str) -> str:
    # Use bold yellow for headers when output is a terminal; otherwise leave plain
    if sys.stdout.isatty():
        return f"\033[1;33m{s}\033[0m"
    return s


def print_group(key: str, tests: list, first: bool):
    """Print a group with the header on its own line and function names below.

    If not the first printed group, print a blank line before the header to separate groups.
    """
    # Remove duplicates and sort
    tests_unique = sorted(set(tests))

    # Convert test_* to _* format (remove 'test' prefix)
    functions = []
    for test in tests_unique:
        if test.startswith('test_'):
            functions.append('_' + test[5:])  # Remove 'test_' and add '_'
        else:
            functions.append(test)

    if not first:
        print("")
    print(color_header("#" + key))
    for func in functions:
        print(func)


def main():
    input_path = Path("miri_errors.txt")
    if not input_path.exists():
        print("Input file not found: miri_errors.txt")
        return
    entries = parse_errors(input_path)
    groups = {}
    for test, msg in entries:
        key = canonical_message(msg)
        groups.setdefault(key, []).append(test)

    # Print all groups consistently (no special canonical ordering).
    first_printed = False
    for key in sorted(groups.keys()):
        print_group(key, groups[key], first_printed)
        first_printed = True


if __name__ == "__main__":
    main()

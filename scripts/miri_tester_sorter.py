#!/usr/bin/env python3
from pathlib import Path
import re

CANONICAL_ORDER = [
    "unsupported operation: can't call foreign function",
    "Undefined Behavior: calling a function that requires unavailable target features",
    "Undefined Behavior: memory access failed",
    "inline assembly is not supported",
]


def canonical_message(msg: str) -> str:
    s = msg.lower()
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

    # print canonical categories first in specified order
    printed = set()
    for can in CANONICAL_ORDER:
        if can in groups:
            tests_sorted = sorted(groups[can])
            quoted = ", ".join(f'"{t}"' for t in tests_sorted)
            print(f"{can} {quoted}")
            printed.add(can)
    # print remaining categories (sorted by key)
    for key in sorted(k for k in groups.keys() if k not in printed):
        tests_sorted = sorted(groups[key])
        quoted = ", ".join(f'"{t}"' for t in tests_sorted)
        print(f"{key} {quoted}")


if __name__ == "__main__":
    main()

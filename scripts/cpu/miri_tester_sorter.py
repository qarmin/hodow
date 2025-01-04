#!/usr/bin/env python3
from pathlib import Path
import re
import sys

sys.path.insert(0, str(Path(__file__).parent))
import generate_tests as gen  # noqa: E402

# keep the regex for exact matches as a fallback, but we'll also match more loosely
ALIGNMENT_RE = re.compile(r"undefined behavior: accessing memory with alignment \d+, but alignment \d+ is required", re.IGNORECASE)


def build_test_to_func_map() -> dict[str, str]:
    """Maps every generated test name (base *and* scenario-suffixed, exactly as
    generate_tests.py would emit them) back to the bare intrinsic name (with its leading
    underscore(s)) it was generated from - needed because a real test name is
    `test_<arch>_<ext>_<func>`, and <arch>/<ext> can themselves contain underscores
    (e.g. "riscv_shared"), so it can't be reconstructed by just stripping "test_"."""
    mapping: dict[str, str] = {}
    sigs_file = Path.cwd() / gen.SIGNATURES_FILE
    if not sigs_file.exists():
        return mapping
    all_sigs = gen.parse_signatures(sigs_file)
    for (arch, ext), funcs in all_sigs.items():
        for sig in funcs:
            if gen.in_pilot_scope(arch, ext, sig["name"]):
                for tname in gen.list_scenario_names(sig, arch, ext):
                    mapping[tname] = sig["name"]
            else:
                mapping[gen.test_name(sig["name"], arch, ext)] = sig["name"]
    return mapping


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


def print_group(key: str, tests: list, first: bool, test_to_func: dict[str, str]):
    """Print a group with the header on its own line and function names below.

    If not the first printed group, print a blank line before the header to separate groups.
    """
    # Remove duplicates and sort
    tests_unique = sorted(set(tests))

    functions = []
    for test in tests_unique:
        func = test_to_func.get(test)
        if func is not None:
            functions.append(func)
        elif test.startswith('test_'):
            # Unknown test name (e.g. signatures.txt changed since); fall back to the old
            # naive strip so the tool still produces *something* usable, flagged for review.
            functions.append('_' + test[5:] + "  # UNRECOGNIZED - verify manually")
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

    test_to_func = build_test_to_func_map()

    # Print all groups consistently (no special canonical ordering).
    first_printed = False
    for key in sorted(groups.keys()):
        print_group(key, groups[key], first_printed, test_to_func)
        first_printed = True


if __name__ == "__main__":
    main()

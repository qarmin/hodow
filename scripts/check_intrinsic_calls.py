"""
Check that each test_* function actually calls the corresponding intrinsic.

Rule: test_mm_foo_bar must contain a call to _mm_foo_bar somewhere in its body.
Delegating to another test function does NOT count.

Usage:
  python3 scripts/check_intrinsic_calls.py [--repo ROOT]
"""

import argparse
import os
import re
import sys

RS_EXT = '.rs'
FN_DEF_RE = re.compile(r"pub\s*\([^)]*\)\s*fn\s+(test_[A-Za-z0-9_]+)\s*\(")


def discover_files(root: str):
    for dirpath, _, filenames in os.walk(root):
        if 'target' in dirpath.split(os.sep):
            continue
        for fn in filenames:
            if fn.endswith(RS_EXT):
                yield os.path.join(dirpath, fn)


def extract_body(src: str, fn_match_end: int) -> str:
    brace = src.find('{', fn_match_end)
    if brace == -1:
        return ''
    idx = brace + 1
    depth = 1
    while idx < len(src) and depth > 0:
        if src[idx] == '{':
            depth += 1
        elif src[idx] == '}':
            depth -= 1
        idx += 1
    return src[brace:idx]


def check_file(path: str):
    with open(path, 'r', encoding='utf-8') as f:
        src = f.read()

    violations = []
    for m in FN_DEF_RE.finditer(src):
        fname = m.group(1)
        # expected intrinsic: strip "test_" prefix, prepend "_"
        intrinsic = '_' + fname[len('test_'):]
        body = extract_body(src, m.end())
        if not body:
            continue
        if intrinsic not in body:
            violations.append(fname)
    return violations


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument('--repo', default='.', help='Repository root (default: .)')
    args = ap.parse_args(argv)

    bad = []  # list of (file, function_name)

    for path in discover_files(args.repo):
        try:
            violations = check_file(path)
        except Exception as e:
            print(f'ERROR reading {path}: {e}', file=sys.stderr)
            continue
        for fname in violations:
            bad.append((path, fname))

    if not bad:
        print('All test functions call their corresponding intrinsic.')
        sys.exit(0)

    print(f'Functions that do NOT call their intrinsic ({len(bad)} total):\n')
    by_file = {}
    for path, fname in bad:
        by_file.setdefault(path, []).append(fname)

    for path, fnames in sorted(by_file.items()):
        print(f'FILE: {path}')
        for fn in fnames:
            intrinsic = '_' + fn[len('test_'):]
            print(f'  {fn}  (expected call to {intrinsic})')

    sys.exit(1)


if __name__ == '__main__':
    main(sys.argv[1:])

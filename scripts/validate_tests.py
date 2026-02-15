"""
Validate Rust test functions against project rules (detection-only).
Usage:
  python3 scripts/validate_tests.py [--files file1.rs,file2.rs] [--repo ROOT]

This script discovers Rust files that contain tests and checks each test function for:
- presence of get_fuzzing() call
- usage of literal expected values in check_array_equality (detects &expected usage)
- ignored result bindings like `let _ =` or `let _result =`
- presence of comments inside test functions
- multiple unsafe blocks in a function

It reports findings but does not modify files.
"""

import argparse
import os
import re
import sys
from typing import List, Tuple

RS_EXT = '.rs'

TEST_ATTR_RE = re.compile(r"#\[test\]")
# match fn definitions either annotated tests or free functions starting with test_
FN_DEF_RE = re.compile(r"fn\s+(test_[A-Za-z0-9_]+)\s*\([^\)]*\)\s*\{")
GET_FUZZ_RE = re.compile(r"\bget_fuzzing\s*\(")
CHECK_ARRAY_VAR_RE = re.compile(r"check_array_equality\s*\(\s*&[^,]+,\s*&\s*([A-Za-z0-9_]+)\s*\)")
LET_UNDERSCORE_RE = re.compile(r"\blet\s+_[_A-Za-z0-9]*\s*=")
UNSAFE_BLOCK_RE = re.compile(r"unsafe\s*\{")
LINE_COMMENT_RE = re.compile(r"//")
BLOCK_COMMENT_RE = re.compile(r"/\*")


def discover_test_files(root: str) -> List[str]:
    candidates = []
    for dirpath, dirnames, filenames in os.walk(root):
        # skip target dir
        if 'target' in dirpath.split(os.sep):
            continue
        for fn in filenames:
            if not fn.endswith(RS_EXT):
                continue
            path = os.path.join(dirpath, fn)
            try:
                with open(path, 'r', encoding='utf-8') as f:
                    head = f.read(4096)
            except Exception:
                continue
            # include files that either have #[test], mod tests, or contain free functions named test_*
            if TEST_ATTR_RE.search(head) or 'mod tests' in head or re.search(r"\bfn\s+test_", head):
                candidates.append(path)
    return candidates


def find_test_functions(src: str) -> List[Tuple[int, int, str]]:
    # Return list of (start_idx, end_idx, function_text) for functions annotated with #[test]
    results = []
    # First find annotated tests
    for m in TEST_ATTR_RE.finditer(src):
        attr_end = m.end()
        fn_match = FN_DEF_RE.search(src, attr_end)
        if not fn_match:
            continue
        fn_start = fn_match.start()
        # find matching brace for the function body
        brace_open = src.find('{', fn_match.end()-1)
        if brace_open == -1:
            continue
        idx = brace_open + 1
        depth = 1
        while idx < len(src) and depth > 0:
            if src[idx] == '{':
                depth += 1
            elif src[idx] == '}':
                depth -= 1
            idx += 1
        if depth == 0:
            fn_end = idx
            fn_text = src[fn_start:fn_end]
            results.append((fn_start, fn_end, fn_text))
    # Also find free functions starting with test_
    for m in FN_DEF_RE.finditer(src):
        # ensure this wasn't already captured as annotated (simple dedupe by start index)
        fn_start = m.start()
        if any(fn_start == r[0] for r in results):
            continue
        brace_open = src.find('{', m.end()-1)
        if brace_open == -1:
            continue
        idx = brace_open + 1
        depth = 1
        while idx < len(src) and depth > 0:
            if src[idx] == '{':
                depth += 1
            elif src[idx] == '}':
                depth -= 1
            idx += 1
        if depth == 0:
            fn_end = idx
            fn_text = src[fn_start:fn_end]
            results.append((fn_start, fn_end, fn_text))
    return results


def analyze_function(fn_text: str) -> List[str]:
    issues = []
    body_start = fn_text.find('{')
    if body_start == -1:
        return ["could not parse function body"]
    body = fn_text[body_start:]
    if not GET_FUZZ_RE.search(body):
        issues.append('missing_get_fuzzing')
    if CHECK_ARRAY_VAR_RE.search(body):
        issues.append('expected_variable_used_in_check_array_equality')
    if LET_UNDERSCORE_RE.search(body):
        issues.append('ignored_result_let_underscore')
    if LINE_COMMENT_RE.search(body) or BLOCK_COMMENT_RE.search(body):
        issues.append('contains_comments')
    unsafe_count = len(UNSAFE_BLOCK_RE.findall(body))
    if unsafe_count > 1:
        issues.append('multiple_unsafe_blocks')
    return issues


def analyze_file(path: str) -> Tuple[str, List[Tuple[str, List[str]]]]:
    try:
        with open(path, 'r', encoding='utf-8') as f:
            src = f.read()
    except Exception as e:
        return (path, [('__file_read_error__', [str(e)])])
    funcs = find_test_functions(src)
    findings = []
    for start, end, text in funcs:
        # extract function name
        name_m = FN_DEF_RE.search(text)
        fname = name_m.group(1) if name_m else '<unknown>'
        issues = analyze_function(text)
        if issues:
            findings.append((fname, issues))
    return (path, findings)


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument('--files', help='Comma-separated list of files to check')
    ap.add_argument('--repo', default='.', help='Repository root (default .)')
    args = ap.parse_args(argv)

    if args.files:
        files = [f for f in args.files.split(',') if f]
    else:
        files = discover_test_files(args.repo)

    any_issues = False
    for path in files:
        path, findings = analyze_file(path)
        if findings:
            any_issues = True
            print(f'FILE: {path}')
            for fname, issues in findings:
                print(f'  test: {fname}')
                for it in issues:
                    print(f'    - {it}')
    if any_issues:
        print('\nValidation completed: issues found')
        sys.exit(1)
    else:
        print('Validation completed: no issues found')
        sys.exit(0)


if __name__ == '__main__':
    main(sys.argv[1:])

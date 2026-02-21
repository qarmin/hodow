#!/usr/bin/env python3
"""
Generate OpenGL functions coverage tables per core version using gl_functions.csv as source.
- For each core_version (or 'extension-only') create a table listing functions in that group.
- Columns: Function name + one column per test found in work_tester_core/src/opengl/tests (test title + GL version)
- Mark 'x' where a function appears in a test.
- After each version table, print summary line: "Used at least 1 - {used}/{total}"
- At the end print global summary: "All functions used at least 1 time - {used}/{total_all}"

Output file: work_tester_core/src/opengl/FUNCTIONS_TABLE.md (overwritten)
"""

from __future__ import annotations

import csv
import re
import sys
from collections import defaultdict
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CSV_PATH = ROOT / 'gl_functions.csv'
OUT_MD = ROOT / 'work_tester_core' / 'src' / 'opengl' / 'FUNCTIONS_TABLE.md'
TESTS_DIR = ROOT / 'work_tester_core' / 'src' / 'opengl' / 'tests'

FUNC_PATTERN = re.compile(r'gl::([A-Z][a-z][a-zA-Z0-9_]*)')

EXCLUDE_DIRS = {'target', '.git', '__pycache__'}
TEXT_EXTS = {'.rs', '.py', '.md', '.txt', '.toml', '.csv', '.c', '.h', '.cpp', '.hpp', '.java', '.js', '.html', '.css', '.yml', '.yaml', '.xml', '.sh', '.json'}
WORD_RE = re.compile(r"\b[A-Za-z_]\w*\b")


def read_gl_functions(csv_path: Path):
    groups = defaultdict(list)
    functions = []
    if not csv_path.exists():
        print(f"ERROR: {csv_path} not found", file=sys.stderr)
        sys.exit(2)
    with csv_path.open(newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            sig = (row.get('signature') or '').strip()
            core = (row.get('core_version') or '').strip()
            exts = (row.get('extensions') or '').strip()
            name = sig.split('(', 1)[0].strip() if sig else ''
            if name.startswith('"') and name.endswith('"'):
                name = name[1:-1]
            if not name:
                continue
            key = core if core else 'extension-only'
            groups[key].append((name, sig, exts))
            functions.append((name, sig, key, exts))
    return groups, functions


def extract_gl_functions_from_text(text: str) -> set[str]:
    found = set()
    for m in FUNC_PATTERN.finditer(text):
        fn = m.group(1)
        found.add(f"gl{fn}")
    return found


def discover_tests(tests_dir: Path):
    tests = []  # list of (test_id, display, version, functions_set)
    if not tests_dir.exists():
        return tests
    for path in sorted(tests_dir.glob('gl*.rs')):
        if path.name == 'mod.rs':
            continue
        try:
            content = path.read_text(encoding='utf-8')
        except Exception:
            continue
        version_match = re.search(r'//!\s*GL_VERSION:\s*([\d.]+)', content)
        gl_version = version_match.group(1) if version_match else ''
        name_match = re.search(r'pub struct (\w+);', content)
        test_name = name_match.group(1) if name_match else path.stem
        readable = re.sub(r'GL\d+(\w+)Test', r'\1', test_name)
        functions = extract_gl_functions_from_text(content)
        tests.append((path.stem, readable, gl_version, functions))
    return tests


def ver_key(v: str):
    if v == 'extension-only':
        return (9999, 9999)
    try:
        major, minor = v.split('.')
        return (int(major), int(minor))
    except Exception:
        return (9998, 0)


def format_percent(n, total):
    return f"{(n/total*100):.1f}%" if total else '0.0%'


def generate_markdown(groups: dict[str, list], functions: list[tuple], tests: list[tuple]) -> str:
    lines: list[str] = []
    total_all = sum(len(v) for v in groups.values())

    # prepare union of all test functions for global stats
    union_funcs = set()
    for _tid, _display, _ver, funcs in tests:
        union_funcs.update(funcs)

    # global used count (functions used in any test)
    used_all = 0
    for version in groups:
        entries = groups[version]
        used_in_version = sum(1 for name, _sig, _exts in entries if name in union_funcs)
        used_all += used_in_version

    # Print global stats at the top
    lines.append(f'# OpenGL functions coverage summary')
    lines.append('')
    lines.append(f'Total functions in registry: **{total_all}**')
    lines.append(f'All functions used at least 1 time - **{used_all}/{total_all}** ({format_percent(used_all, total_all)})')
    lines.append('')

    # prepare test columns
    test_cols = [(tid, f"{display} <br/> GL {ver}" if ver else display, funcs) for tid, display, ver, funcs in tests]

    # For each version, render a table with fixed column widths based on headers
    for version in sorted(groups.keys(), key=ver_key):
        entries = groups[version]
        total = len(entries)

        # compute used in this version (based on union of all tests)
        used_in_version = sum(1 for name, _sig, _exts in entries if name in union_funcs)

        lines.append(f'## Version {version} — Used at least once: **{used_in_version}/{total}** ({format_percent(used_in_version, total)})')
        lines.append('')

        col_names = ['Function name'] + [tc[1] for tc in test_cols]
        # compute widths: at least header width, but expand if any cell longer
        widths = [len(c) for c in col_names]
        # name column width from function names
        for name, sig, exts in entries:
            widths[0] = max(widths[0], len(name))
        # test columns: header length usually dominates; keep safe check
        for idx, (_tid, hdr, funcs) in enumerate(test_cols, start=1):
            widths[idx] = max(widths[idx], len(hdr))
            # no need to scan cells, they are short ('x' or '')

        # build header line with padding to widths
        header_cells = [col_names[i].ljust(widths[i]) for i in range(len(col_names))]
        header = '| ' + ' | '.join(header_cells) + ' |'
        sep_cells = ['-' * widths[i] for i in range(len(col_names))]
        sep = '| ' + ' | '.join(sep_cells) + ' |'
        lines.append(header)
        lines.append(sep)

        # rows
        for name, sig, exts in sorted(entries, key=lambda x: x[0].lower()):
            row_cells = [name.ljust(widths[0])]
            for col_idx, (_tid, _hdr, funcs) in enumerate(test_cols, start=1):
                cell = 'x' if name in funcs else ''
                row_cells.append(cell.ljust(widths[col_idx]))
            lines.append('| ' + ' | '.join(row_cells) + ' |')

        lines.append('')

    return '\n'.join(lines)


def main():
    groups, functions = read_gl_functions(CSV_PATH)
    print(f'Read {sum(len(v) for v in groups.values())} functions from {CSV_PATH}')
    tests = discover_tests(TESTS_DIR)
    print(f'Discovered {len(tests)} tests in {TESTS_DIR}')
    md = generate_markdown(groups, functions, tests)
    OUT_MD.parent.mkdir(parents=True, exist_ok=True)
    OUT_MD.write_text(md, encoding='utf-8')
    print(f'Wrote {OUT_MD}')


if __name__ == '__main__':
    main()

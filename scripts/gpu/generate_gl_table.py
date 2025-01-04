#!/usr/bin/env python3
"""
Generate OpenGL functions coverage tables per core version using gl_functions.csv as source.
- For each core_version (or 'extension-only') create a table listing functions in that group.
- Columns: Function name + one column per test found in hodow_gpu/src/opengl/tests (test title + GL version)
- Mark 'x' where a function appears in a test.
- After each version table, print summary line: "Used at least 1 - {used}/{total}"
- At the end print global summary: "All functions used at least 1 time - {used}/{total_all}"

Output file: hodow_gpu/src/opengl/FUNCTIONS_TABLE.md (overwritten)
"""

from __future__ import annotations

import csv
import re
import sys
from collections import defaultdict
from datetime import datetime
from pathlib import Path

# Use current working directory as repo root when script is invoked from repo root
ROOT = Path.cwd()
CSV_PATH = ROOT / 'data' / 'gpu' / 'gl_functions.csv'
SUPPORTED_CSV_PATH = ROOT / 'data' / 'gpu' / 'gl_glutin_supported_functions.csv'
OUT_MD = ROOT / 'hodow_gpu' / 'src' / 'opengl' / 'FUNCTIONS_TABLE.md'
OUT_UNIMPLEMENTED = ROOT / 'hodow_gpu' / 'src' / 'opengl' / 'unimplemented.txt'
TESTS_DIR = ROOT / 'hodow_gpu' / 'src' / 'opengl' / 'tests'
OUT_REQUIREMENTS = ROOT / 'hodow_gpu' / 'src' / 'opengl' / 'generated_requirements.rs'

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


def read_supported_functions(csv_path: Path) -> set[str]:
    """Read function names from gl_glutin_supported_functions.csv"""
    supported = set()
    if not csv_path.exists():
        print(f"WARNING: {csv_path} not found, treating all functions as unsupported", file=sys.stderr)
        return supported
    with csv_path.open(newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            sig = (row.get('signature') or '').strip()
            name = sig.split('(', 1)[0].strip() if sig else ''
            if name:
                supported.add(name)
    return supported


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


def extract_suffix(func_name: str) -> str:
    """Extract vendor suffix from function name (e.g., glFunctionNV -> NV)"""
    # Common vendor suffixes
    suffixes = [
        'ARB', 'EXT', 'NV', 'AMD', 'INTEL', 'ATI', 'APPLE', 'SGI', 'SGIS', 'SGIX',
        'IBM', 'HP', 'SUN', 'MESA', 'OES', 'KHR', 'ANDROID', 'ANGLE',
        'IMG', 'QCOM', 'VIV', 'NVX', 'OVR', 'REND', 'PGI', 'GREMEDY',
        '3DFX', 'INGR', 'WIN', 'EGL', 'DMP', 'FJ', 'OML'
    ]

    for suffix in suffixes:
        if func_name.endswith(suffix):
            return suffix

    return 'core'  # No vendor suffix, it's a core function


def generate_markdown(groups: dict[str, list], functions: list[tuple], tests: list[tuple], supported_funcs: set[str]) -> str:
    lines: list[str] = []
    total_all = sum(len(v) for v in groups.values())

    # prepare union of all test functions for global stats
    union_funcs = set()
    for _tid, _display, _ver, funcs in tests:
        union_funcs.update(funcs)

    # Split functions into supported and unsupported
    supported_groups = defaultdict(list)
    unsupported_groups = defaultdict(list)

    for version, entries in groups.items():
        for name, sig, exts in entries:
            if name in supported_funcs:
                supported_groups[version].append((name, sig, exts))
            else:
                unsupported_groups[version].append((name, sig, exts))

    # Count supported/unsupported
    total_supported = sum(len(v) for v in supported_groups.values())
    total_unsupported = sum(len(v) for v in unsupported_groups.values())

    # global used count (functions used in any test) - only for supported
    used_all = 0
    for version in supported_groups:
        entries = supported_groups[version]
        used_in_version = sum(1 for name, _sig, _exts in entries if name in union_funcs)
        used_all += used_in_version

    # Print global stats at the top
    lines.append(f'# OpenGL functions coverage summary')
    lines.append('')
    lines.append(f'Total functions in registry: **{total_all}**')
    lines.append(f'- Supported (can be tested): **{total_supported}** ({format_percent(total_supported, total_all)})')
    lines.append(f'- Unsupported (not in bindings): **{total_unsupported}** ({format_percent(total_unsupported, total_all)})')
    lines.append('')
    lines.append(f'Supported functions used at least once: **{used_all}/{total_supported}** ({format_percent(used_all, total_supported)})')
    lines.append('')

    # ============================================================
    # SECTION 1: SUPPORTED FUNCTIONS
    # ============================================================
    lines.append('# Supported functions')
    lines.append('')
    lines.append('Functions that are available in the OpenGL bindings and can be tested.')
    lines.append('')

    # prepare test columns
    test_cols = [(tid, f"{display} <br/> GL {ver}" if ver else display, funcs) for tid, display, ver, funcs in tests]

    # For each version, render a table with fixed column widths based on headers
    for version in sorted(supported_groups.keys(), key=ver_key):
        entries = supported_groups[version]
        total = len(entries)
        unsupported_count = len(unsupported_groups.get(version, []))

        # compute used in this version (based on union of all tests)
        used_in_version = sum(1 for name, _sig, _exts in entries if name in union_funcs)

        lines.append(f'## Version {version}')
        lines.append('')
        lines.append(f'- Supported: **{total}**')
        lines.append(f'- Unsupported: **{unsupported_count}**')
        lines.append(f'- Used at least once: **{used_in_version}/{total}** ({format_percent(used_in_version, total)})')
        lines.append('')

        if total == 0:
            lines.append('*No supported functions in this version.*')
            lines.append('')
            continue

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

    # ============================================================
    # SECTION 2: UNSUPPORTED FUNCTIONS
    # ============================================================
    lines.append('# Unsupported functions')
    lines.append('')
    lines.append('Functions that are NOT available in the OpenGL bindings and cannot be tested.')
    lines.append('Grouped by vendor suffix.')
    lines.append('')

    # Group unsupported functions by suffix across all versions
    suffix_groups = defaultdict(lambda: defaultdict(list))  # suffix -> version -> functions

    for version in sorted(unsupported_groups.keys(), key=ver_key):
        entries = unsupported_groups[version]
        for name, sig, exts in entries:
            suffix = extract_suffix(name)
            suffix_groups[suffix][version].append(name)

    # Sort suffixes: 'core' first, then alphabetically
    sorted_suffixes = sorted(suffix_groups.keys(), key=lambda s: (s != 'core', s))

    for suffix in sorted_suffixes:
        versions_dict = suffix_groups[suffix]
        total_in_suffix = sum(len(funcs) for funcs in versions_dict.values())

        lines.append(f'## {suffix} ({total_in_suffix} functions)')
        lines.append('')

        for version in sorted(versions_dict.keys(), key=ver_key):
            funcs = sorted(versions_dict[version], key=str.lower)
            lines.append(f'### Version {version} ({len(funcs)} functions)')
            lines.append('')
            for func in funcs:
                lines.append(f'- `{func}`')
            lines.append('')

    return '\n'.join(lines)


def generate_unimplemented(groups: dict[str, list], tests: list[tuple]) -> str:
    union_funcs: set[str] = set()
    for _tid, _display, _ver, funcs in tests:
        union_funcs.update(funcs)

    lines: list[str] = []
    for version in sorted(groups.keys(), key=ver_key):
        missing = sorted(
            (name for name, _sig, _exts in groups[version] if name not in union_funcs),
            key=str.lower,
        )
        if not missing:
            continue
        lines.append(version)
        lines.extend(missing)
        lines.append('')

    return '\n'.join(lines)


def _test_chunks(tests_dir: Path):
    """(test name, source relevant to it) for every test, one entry per `impl GLTest for X`.

    Several files hold more than one test (validation.rs has four, es3_validation.rs five), so a
    per-file view attributes everything to whichever came first - the old table simply omitted
    the rest. Each chunk gets the file preamble too: shared shader constants and helper functions
    live there and are genuinely part of what the test needs.
    """
    for path in sorted(tests_dir.glob("*.rs")):
        if path.name == "mod.rs":
            continue
        content = path.read_text(encoding="utf-8")
        starts = [m.start() for m in re.finditer(r"^impl GLTest for ", content, re.M)]
        if not starts:
            continue
        preamble = content[: starts[0]]
        bounds = starts + [len(content)]
        for i, begin in enumerate(starts):
            block = content[begin : bounds[i + 1]]
            m = re.search(r'fn name\(&self\) -> &\'static str \{\s*"([^"]+)"', block)
            if m:
                yield m.group(1), preamble + block


def generate_requirements(tests_dir: Path) -> str:
    """Emit, per test, what it needs from the driver: the GL entry points its body calls and the
    shading language its shaders are written in.

    All of it is read off the source, never hand-written, so it cannot drift from what the test
    actually does. The harness checks it before running the test and reports "not supported"
    instead of running it into a panic, a bogus GL error or a shader compile failure - the same
    shape as the CPU side, where a missing feature means the group is never entered.
    """
    chunks = list(_test_chunks(tests_dir))

    lines = [
        "// @generated by scripts/gpu/generate_gl_table.py - do not edit.",
        "//",
        "// What each GL test needs from the driver, so the harness can skip one the driver cannot",
        "// run instead of reporting it as a defect. See generate_requirements.",
        "",
        "/// `(function name, is it loaded)` for one GL entry point a test calls.",
        "pub type FunctionCheck = (&'static str, fn() -> bool);",
        "",
        "/// Every GL function the named test calls, paired with a live check for it.",
        "pub fn required_functions(test: &str) -> &'static [FunctionCheck] {",
        "    match test {",
    ]
    for name, src in chunks:
        fns = sorted(f[2:] for f in extract_gl_functions_from_text(src))
        entries = ", ".join(f'("gl{f}", || gl::{f}::is_loaded())' for f in fns)
        lines.append(f'        "{name}" => &[{entries}],')
    lines += ["        _ => &[],", "    }", "}", ""]

    lines += [
        "/// The highest desktop GLSL `#version` the test's shaders declare, if it compiles any.",
        "///",
        "/// A desktop `#version` cannot be compiled by an OpenGL ES context at all, so on a GLES",
        "/// driver every desktop-shader test is untestable no matter which entry points exist.",
        "/// Saying so up front was the difference between 11 reported errors and the 1 that was",
        "/// actually about the driver, on an i.MX/Vivante GC2000+.",
        "pub fn required_glsl_version(test: &str) -> Option<u32> {",
        "    match test {",
    ]
    for name, src in chunks:
        versions = re.findall(r"#version\s+(\d+)(\s+es)?", src)
        desktop = [int(v) for v, es in versions if not es]
        # A shader with no `#version` at all is GLSL 110 by definition - still desktop, and still
        # rejected by an ES context. Mesa segfaulted on one rather than just erroring, so the test
        # must not be handed to the driver in the first place.
        compiles_shaders = "gl::CompileShader(" in src or "gl::ShaderSource(" in src
        if desktop:
            lines.append(f'        "{name}" => Some({max(desktop)}),')
        elif compiles_shaders and not versions:
            lines.append(f'        "{name}" => Some(110), // no #version directive -> GLSL 110')
    lines += ["        _ => None,", "    }", "}", ""]

    lines += [
        "/// The highest `#version NNN es` the test's shaders declare, if they are GLES shaders.",
        "///",
        "/// The mirror of the above: an ES shader needs an ES context, or a desktop one new enough",
        "/// to accept one (`ARB_ES3_compatibility` is core in 4.3, `ARB_ES3_1_compatibility` in 4.5).",
        "pub fn required_es_glsl_version(test: &str) -> Option<u32> {",
        "    match test {",
    ]
    for name, src in chunks:
        es = [int(v) for v, suffix in re.findall(r"#version\s+(\d+)(\s+es)?", src) if suffix]
        if es:
            lines.append(f'        "{name}" => Some({max(es)}),')
    lines += ["        _ => None,", "    }", "}", ""]
    return "\n".join(lines)


def main():
    groups, functions = read_gl_functions(CSV_PATH)
    print(f'Read {sum(len(v) for v in groups.values())} functions from {CSV_PATH}')

    supported_funcs = read_supported_functions(SUPPORTED_CSV_PATH)
    print(f'Read {len(supported_funcs)} supported functions from {SUPPORTED_CSV_PATH}')

    tests = discover_tests(TESTS_DIR)
    print(f'Discovered {len(tests)} tests in {TESTS_DIR}')

    md = generate_markdown(groups, functions, tests, supported_funcs)
    OUT_MD.parent.mkdir(parents=True, exist_ok=True)
    OUT_MD.write_text(md, encoding='utf-8')
    print(f'Wrote {OUT_MD}')

    unimplemented = generate_unimplemented(groups, tests)
    OUT_UNIMPLEMENTED.write_text(unimplemented, encoding='utf-8')
    print(f'Wrote {OUT_UNIMPLEMENTED}')

    requirements = generate_requirements(TESTS_DIR)
    OUT_REQUIREMENTS.write_text(requirements, encoding='utf-8')
    print(f'Wrote {OUT_REQUIREMENTS}')


if __name__ == '__main__':
    main()

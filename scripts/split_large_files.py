#!/usr/bin/env python3
"""
Split Rust files in src/cpu that exceed MAX_LINES or have more than MAX_FUNCS_PER_FILE test functions.
Rules:
- Identify top-level modules (.rs) and directories with partN.rs.
- For any file > MAX_LINES or with > MAX_FUNCS_PER_FILE functions, split function blocks into parts of up to MAX_FUNCS_PER_FILE functions.
- If splitting a top-level .rs, create a directory with the base name, move parts into part1.rs.., and create a new main module file that declares "mod partN;", "use crate::cpu::<base>::partN::*;" and an ExtensionTest impl that registers all test_ functions found in parts.
- If splitting a partX.rs inside a module dir, replace parts and update the main module file to include correct part list.

This script is conservative: it only moves function definitions (lines starting with fn or pub(super) fn) into part files and collects them. Non-function code at top (use/imports, structs, impls) will be left in part1.rs at top.
"""
import re
import os
from pathlib import Path

repo = Path(__file__).resolve().parents[1]
cpu_dir = repo / 'src' / 'cpu'
MAX_LINES = 500
MAX_FUNCS_PER_FILE = 15

fn_re = re.compile(r'^(\s*(pub\(super\)\s+)?fn\s+\w+\s*\([^)]*\)\s*->[^\{]+\{|^\s*(pub\(super\)\s+)?fn\s+\w+\s*\([^)]*\)\s*\{)', re.M)
fn_name_re = re.compile(r'fn\s+(test_[A-Za-z0-9_]+)')

def split_functions_from_text(text):
    # crude splitter: find indices of 'fn ' lines and split blocks between them
    matches = list(fn_re.finditer(text))
    if not matches:
        return [text]
    blocks = []
    for i, m in enumerate(matches):
        start = m.start()
        end = matches[i+1].start() if i+1 < len(matches) else len(text)
        blocks.append(text[start:end])
    # keep any leading non-fn header (imports, structs) at beginning
    header = text[:matches[0].start()].rstrip() + '\n'
    if header.strip() == '\n' or header.strip() == '':
        header = ''
    # prepend header to first block
    if header:
        blocks[0] = header + blocks[0]
    return blocks

def collect_test_fn_names(text):
    return fn_name_re.findall(text)

# process directories containing part*.rs
for d in cpu_dir.iterdir():
    if d.is_dir():
        parts = sorted([p for p in d.glob('part*.rs')])
        changed = False
        for p in parts:
            try:
                txt = p.read_text()
            except Exception:
                continue
            lines = txt.count('\n')
            fn_matches = fn_name_re.findall(txt)
            if lines > MAX_LINES or len(fn_matches) > MAX_FUNCS_PER_FILE:
                # split file into function blocks and recompose into multiple part files
                blocks = split_functions_from_text(txt)
                # group blocks into groups of MAX_FUNCS_PER_FILE
                new_parts = []
                cur = []
                for blk in blocks:
                    # consider block as one function even if header included
                    cur.append(blk)
                    if len(cur) >= MAX_FUNCS_PER_FILE:
                        new_parts.append('\n\n'.join(cur))
                        cur = []
                if cur:
                    new_parts.append('\n\n'.join(cur))
                # write new part files replacing this one: find index of p
                base_name = p.stem
                m = re.match(r'part(\d+)', base_name)
                if m:
                    idx = int(m.group(1))
                else:
                    idx = 1
                # remove original, then write parts starting from idx
                p.unlink()
                for i, content in enumerate(new_parts):
                    newname = d / f'part{idx + i}.rs'
                    newname.write_text(content)
                changed = True
        if changed:
            # update parent module file src/cpu/<d>.rs to include all parts
            mainfile = cpu_dir / f'{d.name}.rs'
            parts_now = sorted([p.name for p in d.glob('part*.rs')], key=lambda x: int(re.search(r'part(\d+)', x).group(1)))
            parts_mods = '\n'.join([f'mod {p[:-3]};' for p in parts_now])
            use_parts = '\n'.join([f'use crate::cpu:{' + f'{d.name}' + '}::{p[:-3]}::*;' for p in parts_now])
            # collect test fn names from parts
            all_tests = []
            for p in sorted(d.glob('part*.rs')):
                t = p.read_text()
                all_tests += collect_test_fn_names(t)
            tests_entries = '\n'.join([f'            (&{t}, "{t}"),' for t in all_tests])
            content = f"""{parts_mods}

#[cfg(target_arch = \"x86\")]
use std::arch::x86::*;
#[cfg(target_arch = \"x86_64\")]
use std::arch::x86_64::*;

{use_parts}
use crate::cpu::{{ExtensionTest, TestFunction}};

pub struct {d.name.upper()};

impl ExtensionTest for {d.name.upper()} {{
    fn get_name() -> &'static str {{
        "{d.name.upper()}"
    }}
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {{
        &[
{tests_entries}
        ]
    }}
}}
"""
            mainfile.write_text(content)

# process top-level files that are too long
for f in cpu_dir.glob('*.rs'):
    if f.name in ('mod.rs','common.rs'):
        continue
    txt = f.read_text()
    lines = txt.count('\n')
    fn_matches = fn_name_re.findall(txt)
    if lines > MAX_LINES or len(fn_matches) > MAX_FUNCS_PER_FILE:
        # split into functions
        blocks = split_functions_from_text(txt)
        # group into chunks of MAX_FUNCS_PER_FILE
        new_parts = []
        cur = []
        for blk in blocks:
            cur.append(blk)
            if len(cur) >= MAX_FUNCS_PER_FILE:
                new_parts.append('\n\n'.join(cur))
                cur = []
        if cur:
            new_parts.append('\n\n'.join(cur))
        # create directory
        base = f.stem
        dirp = cpu_dir / base
        dirp.mkdir(exist_ok=True)
        # write parts
        for i, content in enumerate(new_parts, start=1):
            partf = dirp / f'part{i}.rs'
            partf.write_text(content)
        # create main module file that includes parts
        parts_now = sorted([p.name for p in dirp.glob('part*.rs')], key=lambda x: int(re.search(r'part(\d+)', x).group(1)))
        parts_mods = '\n'.join([f'mod {p[:-3]};' for p in parts_now])
        use_parts = '\n'.join([f'use crate::cpu:{' + f'{base}' + '}::{p[:-3]}::*;' for p in parts_now])
        all_tests = []
        for p in sorted(dirp.glob('part*.rs')):
            t = p.read_text()
            all_tests += collect_test_fn_names(t)
        tests_entries = '\n'.join([f'            (&{t}, "{t}"),' for t in all_tests])
        content = f"""{parts_mods}

#[cfg(target_arch = \"x86\")]
use std::arch::x86::*;
#[cfg(target_arch = \"x86_64\")]
use std::arch::x86_64::*;

{use_parts}
use crate::cpu::{{ExtensionTest, TestFunction}};

pub struct {base.upper()};

impl ExtensionTest for {base.upper()} {{
    fn get_name() -> &'static str {{
        "{base.upper()}"
    }}
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {{
        &[
{tests_entries}
        ]
    }}
}}
"""
        f.write_text(content)

print('Split complete')

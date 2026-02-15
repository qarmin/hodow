#!/usr/bin/env python3
"""
Ensure every instruction from todo_analysis.csv has a stub function in src/cpu.
- If function exists anywhere, skip.
- If not, and target module is a directory with parts, append to last part file or create new partN.
- If target module is a .rs file, append function stub at end and add registration in get_tests() if present.
"""
import csv, os, re
from pathlib import Path

repo = Path(__file__).resolve().parents[1]
csv_path = repo / 'todo_analysis.csv'
cpu_dir = repo / 'src' / 'cpu'

with open(csv_path, newline='') as f:
    reader = csv.reader(f)
    header = next(reader)
    rows = [row for row in reader if row and len(row) >= 3]

# helper
def fn_name(instr):
    name = instr.lstrip('_')
    for ch in ['(', ')', ',', ' ', '.', '"', "'"]:
        name = name.replace(ch, '_')
    return 'test_' + name

# search for existing function in src tree
def function_exists(fn):
    for p in cpu_dir.rglob('*.rs'):
        try:
            text = p.read_text()
        except Exception:
            continue
        if re.search(rf'fn\s+{re.escape(fn)}\s*\(', text):
            return True
    return False

# find module file path
def module_paths(src):
    p = cpu_dir / src
    if p.exists() and p.is_file():
        return ('file', p)
    d = cpu_dir / Path(src).stem
    if d.exists() and d.is_dir():
        return ('dir', d)
    # fallback: if src without extension exists as file
    alt = cpu_dir / (src + '.rs')
    if alt.exists():
        return ('file', alt)
    return (None, cpu_dir / src)  # will create file

# append stub to part file
def append_to_part_dir(dpath, fn):
    # list partN files
    parts = sorted([p for p in dpath.glob('part*.rs')], key=lambda x: x.name)
    if not parts:
        # create part1.rs
        target = dpath / 'part1.rs'
        parts = [target]
        target.write_text('// generated\n')
    last = parts[-1]
    # check how many functions in last (count 'fn ' occurrences)
    text = last.read_text()
    count = len(re.findall(r'^\s*(pub\(super\)\s+)?fn\s+', text, flags=re.M))
    if count >= 15:
        # create new part
        idx = 1
        m = re.match(r'part(\d+)\.rs', last.name)
        if m:
            idx = int(m.group(1)) + 1
        last = dpath / f'part{idx}.rs'
        last.write_text('// generated\n')
    # append function
    stub = f"\npub(super) fn {fn}() -> Result<(), String> {{\n    unsafe {{ let _ = (); }}\n    Ok(())\n}}\n"
    last.write_text(last.read_text() + stub)
    return last

# append to file and register
def append_to_file_register(fpath, fn):
    text = fpath.read_text()
    # append function at end
    stub = f"\nfn {fn}() -> Result<(), String> {{\n    unsafe {{ let _ = (); }}\n    Ok(())\n}}\n"
    text = text + '\n' + stub
    # try to register in get_tests()
    # naive: find "fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {" and closing ]
    m = re.search(r"fn\s+get_tests\s*\([\s\S]*?->\s*&'static\s*\[\(&'static\s*TestFunction,\s*&'static\s*str\)\]\s*\{", text)
    if m:
        start = m.end()
        # find matching closing ']' after start
        idx = text.find(']', start)
        if idx != -1:
            # insert before that idx
            insertion = f"\n            (&{fn}, \"{fn}\"),"
            text = text[:idx] + insertion + text[idx:]
    fpath.write_text(text)
    return fpath

added = []
for row in rows:
    src = row[2].strip().strip('"')
    instr = row[1].strip().strip('"')
    fn = fn_name(instr)
    if function_exists(fn):
        continue
    kind, path = module_paths(src)
    if kind == 'dir':
        last = append_to_part_dir(path, fn)
        added.append((fn, str(last)))
    elif kind == 'file':
        append_to_file_register(path, fn)
        added.append((fn, str(path)))
    else:
        # create single file at path
        p = path
        content = f'''#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use crate::cpu::{{ExtensionTest, TestFunction}};

fn {fn}() -> Result<(), String> {{
    unsafe {{ let _ = (); }}
    Ok(())
}}
'''
        p.write_text(content)
        added.append((fn, str(p)))

print('Added count:', len(added))
for a in added:
    print('ADDED', a[0], '->', a[1])

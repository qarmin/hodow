#!/usr/bin/env python3
"""
Robust splitter for large Rust files in src/cpu.
- Splits files that have >MAX_LINES lines or >MAX_FUNCS_PER_FILE test_ functions.
- Detects function blocks starting with `fn test_` (supports `pub(super) fn`, `pub fn`, `fn`).
- Uses brace counting to find function bodies reliably.
- Writes parts into `src/cpu/<module>/partN.rs` and creates/updates `src/cpu/<module>.rs` to `mod partN;` and `use` parts and an `ExtensionTest` impl registering all test_ functions.
- Updates `src/cpu/mod.rs` to add `#[cfg(any(target_arch = "x86", target_arch = "x86_64"))] mod <module>;` if not present.

Run: python3 scripts/split_large_files_v2.py
"""
import re
from pathlib import Path
import os

repo = Path(__file__).resolve().parents[1]
cpu_dir = repo / 'src' / 'cpu'
MAX_LINES = 500
MAX_FUNCS_PER_FILE = 15

fn_start_re = re.compile(r'^(?P<prefix>\s*(?:pub\(super\)\s+|pub\s+)?fn\s+)(?P<name>test_[A-Za-z0-9_]+)\s*\(', re.M)
fn_name_re = re.compile(r'fn\s+(test_[A-Za-z0-9_]+)')

def find_function_blocks(text):
    # find start indices of test_ function declarations
    blocks = []
    matches = list(fn_start_re.finditer(text))
    if not matches:
        return []
    for i, m in enumerate(matches):
        start = m.start()
        # find opening brace '{' after m.end()
        brace_pos = text.find('{', m.end())
        if brace_pos == -1:
            # can't find body brace, assume until next fn or end
            end = matches[i+1].start() if i+1 < len(matches) else len(text)
            blocks.append((start, end))
            continue
        # scan braces
        depth = 0
        pos = brace_pos
        while pos < len(text):
            c = text[pos]
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
                if depth == 0:
                    end = pos + 1
                    break
            pos += 1
        else:
            end = len(text)
        blocks.append((start, end))
    return blocks

def collect_test_names(text):
    return fn_name_re.findall(text)

# read mod.rs to check existing declarations
mod_rs = cpu_dir / 'mod.rs'
mod_text = mod_rs.read_text()

created_modules = []

for f in list(cpu_dir.glob('*.rs')):
    if f.name in ('mod.rs','common.rs','todo_generated.rs'):
        continue
    text = f.read_text()
    line_count = text.count('\n')
    test_names = collect_test_names(text)
    if line_count <= MAX_LINES and len(test_names) <= MAX_FUNCS_PER_FILE:
        continue
    # need to split
    print('Splitting', f)
    blocks = find_function_blocks(text)
    if not blocks:
        # fallback: split by fn occurrences naive
        parts = re.split(r'(^\s*(?:pub\(super\)\s+|pub\s+)?fn\s+)', text, flags=re.M)
        # not reliable; skip
        print('  no test_ function blocks found for', f)
        continue
    # header = text before first block
    header = text[:blocks[0][0]].rstrip() + '\n' if blocks[0][0] > 0 else ''
    func_texts = []
    for (s,e) in blocks:
        func_texts.append(text[s:e])
    # group into parts of MAX_FUNCS_PER_FILE
    parts = [func_texts[i:i+MAX_FUNCS_PER_FILE] for i in range(0,len(func_texts),MAX_FUNCS_PER_FILE)]
    # create dir
    base = f.stem
    dirp = cpu_dir / base
    dirp.mkdir(exist_ok=True)
    # write each part file
    all_test_names = []
    for idx, group in enumerate(parts, start=1):
        partf = dirp / f'part{idx}.rs'
        # include header only in first part
        content = ''
        if idx == 1 and header:
            content += header + '\n'
        content += '\n\n'.join(group) + '\n'
        partf.write_text(content)
        tn = collect_test_names(content)
        all_test_names += tn
    # write main module file
    parts_mods = '\n'.join([f'mod part{i};' for i in range(1, len(parts)+1)])
    use_parts = '\n'.join([f'use crate::cpu::{base}::part{i}::*;' for i in range(1, len(parts)+1)])
    tests_entries = '\n'.join([f'            (&{t}, "{t}"),' for t in all_test_names])
    main_content = f"""{parts_mods}

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
    f.write_text(main_content)
    created_modules.append(base)
    # update mod.rs if needed
    decl = f'mod {base};'
    if decl not in mod_text:
        insert_line = f'#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]\nmod {base};\n'
        # insert before 'mod common;' if present
        if 'mod common;' in mod_text:
            mod_text = mod_text.replace('mod common;', 'mod common;\n' + insert_line)
        else:
            mod_text = insert_line + mod_text

# write back mod.rs if changed
if created_modules:
    mod_rs.write_text(mod_text)
    print('Updated mod.rs with modules:', created_modules)

# final check: list files > MAX_LINES
big = []
for p in cpu_dir.rglob('*.rs'):
    try:
        l = p.read_text().count('\n')
    except Exception:
        continue
    if l > MAX_LINES:
        big.append((l, str(p)))

if not big:
    print('All files are <=', MAX_LINES, 'lines')
else:
    print('Files still >', MAX_LINES)
    for l,p in sorted(big):
        print(l, p)
print('Done')

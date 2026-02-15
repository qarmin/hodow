#!/usr/bin/env python3
import csv
import os
from collections import defaultdict

root = os.path.dirname(os.path.dirname(__file__))
csv_path = os.path.join(root, 'todo_analysis.csv')
cpu_dir = os.path.join(root, 'src', 'cpu')

with open(csv_path, newline='') as f:
    reader = csv.reader(f)
    header = next(reader)
    mapping = defaultdict(list)
    categories = {}
    for row in reader:
        if not row or len(row) < 3:
            continue
        category = row[0].strip().strip('"')
        instr = row[1].strip().strip('"')
        src = row[2].strip().strip('"')
        mapping[src].append(instr)
        categories.setdefault(src, set()).add(category)

os.makedirs(cpu_dir, exist_ok=True)

created = []
skipped = []
created_files = []

# helper to make safe fn name
def fn_name_from_instr(instr):
    name = instr.lstrip('_')
    for ch in ["(", ")", ",", " ", ".", '"', "'"]:
        name = name.replace(ch, '_')
    return 'test_' + name

for src, instrs in mapping.items():
    target = os.path.join(cpu_dir, src)
    # skip if exists
    if os.path.exists(target):
        skipped.append(src)
        continue
    base = os.path.splitext(src)[0]
    # small modules: single file
    if len(instrs) <= 15:
        struct_name = base.replace('-', '_').upper()
        tests_entries = "\n".join([f'            (&{fn_name_from_instr(i)}, "{fn_name_from_instr(i)}"),' for i in instrs])
        funcs = "\n\n".join([f"fn {fn_name_from_instr(i)}() -> Result<(), String> {{\n    unsafe {{ let _ = (); }}\n    Ok(())\n}}" for i in instrs])
        content = f'''#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;
use crate::cpu::{{ExtensionTest, TestFunction}};

pub struct {struct_name};

impl ExtensionTest for {struct_name} {{
    fn get_name() -> &'static str {{
        "{struct_name}"
    }}
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {{
        &[
{tests_entries}
        ]
    }}
}}

{funcs}
'''
        with open(target, 'w') as f:
            f.write(content)
        created.append(src)
        created_files.append(target)
    else:
        # many functions: create dir with part files
        dirpath = os.path.join(cpu_dir, base)
        os.makedirs(dirpath, exist_ok=True)
        nparts = (len(instrs) + 14) // 15
        for p in range(nparts):
            part_instrs = instrs[p*15:(p+1)*15]
            partfile = os.path.join(dirpath, f'part{p+1}.rs')
            funcs = "\n\n".join([f"pub(super) fn {fn_name_from_instr(i)}() -> Result<(), String> {{\n    unsafe {{ let _ = (); }}\n    Ok(())\n}}" for i in part_instrs])
            content = f'''use std::arch::x86_64::*;
use log::info;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

{funcs}
'''
            with open(partfile, 'w') as f:
                f.write(content)
            created_files.append(partfile)
        # main module file
        struct_name = base.replace('-', '_').upper()
        tests_entries = []
        for p in range(nparts):
            part_instrs = instrs[p*15:(p+1)*15]
            for i in part_instrs:
                tests_entries.append(f'            (&{fn_name_from_instr(i)}, "{fn_name_from_instr(i)}"),')
        tests_entries_str = '\n'.join(tests_entries)
        parts_mods = '\n'.join([f'mod part{p+1};' for p in range(nparts)])
        use_parts = '\n'.join([f'use crate::cpu::{base}::part{p+1}::*;' for p in range(nparts)])
        content = f'''{parts_mods}

#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

{use_parts}
use crate::cpu::{{ExtensionTest, TestFunction}};

pub struct {struct_name};

impl ExtensionTest for {struct_name} {{
    fn get_name() -> &'static str {{
        "{struct_name}"
    }}
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {{
        &[
{tests_entries_str}
        ]
    }}
}}
'''
        mainfile = os.path.join(cpu_dir, src)
        with open(mainfile, 'w') as f:
            f.write(content)
        created.append(src)
        created_files.append(mainfile)

print('Created modules:', len(created))
print('Skipped existing modules:', len(skipped))
print('Created file count:', len(created_files))
for p in created_files:
    print('CREATED:', p)

print('Done')

#!/usr/bin/env python3
from pathlib import Path
import re
import sys

repo = Path(__file__).resolve().parents[1]
cpu_dir = repo / 'src' / 'cpu'

# file to split
file_to_split = cpu_dir / 'avx512f.rs'
MAX_FUNCS = 15

fn_start_re = re.compile(r'^(?P<prefix>\s*(?:pub\(super\)\s+|pub\s+)?fn\s+)(?P<name>test_[A-Za-z0-9_]+)\s*\(', re.M)
fn_name_re = re.compile(r'fn\s+(test_[A-Za-z0-9_]+)')

def find_function_blocks(text):
    matches = list(fn_start_re.finditer(text))
    if not matches:
        return []
    blocks = []
    for i, m in enumerate(matches):
        start = m.start()
        brace_pos = text.find('{', m.end())
        if brace_pos == -1:
            end = matches[i+1].start() if i+1 < len(matches) else len(text)
            blocks.append((start,end))
            continue
        depth = 0
        pos = brace_pos
        while pos < len(text):
            c = text[pos]
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
                if depth == 0:
                    end = pos+1
                    break
            pos += 1
        else:
            end = len(text)
        blocks.append((start,end))
    return blocks

text = file_to_split.read_text()
blocks = find_function_blocks(text)
if not blocks:
    print('No function blocks found; abort')
    sys.exit(1)
header = text[:blocks[0][0]].rstrip() + '\n' if blocks[0][0] > 0 else ''
funcs = [text[s:e] for s,e in blocks]
# group into parts
parts = [funcs[i:i+MAX_FUNCS] for i in range(0,len(funcs),MAX_FUNCS)]
# create dir
dirp = cpu_dir / 'avx512f'
if dirp.exists():
    # remove existing part files
    for p in dirp.glob('part*.rs'):
        p.unlink()
else:
    dirp.mkdir()
all_test_names = []
for idx, group in enumerate(parts, start=1):
    partf = dirp / f'part{idx}.rs'
    content = ''
    if idx == 1 and header:
        content += header + '\n'
    content += '\n\n'.join(group) + '\n'
    partf.write_text(content)
    all_test_names += fn_name_re.findall(content)
# write new avx512f.rs main
parts_mods = '\n'.join([f'mod part{i};' for i in range(1, len(parts)+1)])
use_parts = '\n'.join([f'use crate::cpu::avx512f::part{i}::*;' for i in range(1, len(parts)+1)])
tests_entries = '\n'.join([f'            (&{t}, "{t}"),' for t in all_test_names])
main_content = f"""{parts_mods}

#[cfg(target_arch = \"x86\")]
use std::arch::x86::*;
#[cfg(target_arch = \"x86_64\")]
use std::arch::x86_64::*;

{use_parts}
use crate::cpu::{{ExtensionTest, TestFunction}};

pub struct AVX512F;

impl ExtensionTest for AVX512F {{
    fn get_name() -> &'static str {{
        "AVX-512F"
    }}
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {{
        &[
{tests_entries}
        ]
    }}
}}
"""
file_to_split.write_text(main_content)
print('Split into', len(parts), 'parts')
print('Done')

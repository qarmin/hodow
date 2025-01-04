#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Prints the rows of the limit tables of src/khr_gl/limits_tests.rs, read from gl4cLimitsTests.cpp of the pinned upstream checkout.

Every token must exist in src/generated/glw.rs; the ones that do not are listed on stderr. `--names` also writes the case names, one per line, for comparing with the mustpass list.

Usage: gen_khr_limits_table.py [--src tmp/glcts-src] [--names names.txt] > rows.rs.txt
"""
import argparse
import re
import sys
from pathlib import Path

REPO_DIR = Path(__file__).resolve().parents[2]
parser = argparse.ArgumentParser()
parser.add_argument("--src", type=Path, default=REPO_DIR / "tmp" / "glcts-src")
parser.add_argument("--names", type=Path, default=None)
args = parser.parse_args()
cpp = (args.src / "external/openglcts/modules/gl/gl4cLimitsTests.cpp").read_text()
glw = (REPO_DIR / "hodow_cts/src/generated/glw.rs").read_text()
cvuc = (14 * 16384) // 4 + 1024
consts = {'cvuc': cvuc, 'cguc': cvuc, 'ctcuc': cvuc, 'cteuc': cvuc, 'cfuc': cvuc}

def section(name):
    m = re.search(r'static const Limit<[^>]*> ' + name + r'\[\] = \{(.*?)\};\n\n', cpp, re.S)
    return m.group(1)

row = re.compile(r'\{"(\w+)",\s*(\w+),\s*(tcu::IVec3\([^)]*\)|[-\w.]+),\s*(\d),\s*"(\w*)"\}')
out = []
missing = []
names = []
for kind, sect in [('int', 'intLimits'), ('int64', 'int64Limits'), ('uint64', 'uint64Limits'), ('float', 'floatLimits'), ('ivec3', 'ivec3Limits')]:
    for m in row.finditer(section(sect)):
        name, token, bound, is_max, builtin = m.groups()
        names.append(name)
        if token == 'GL_NONE':
            tok = '0'
        else:
            tok = 'glw::' + token
            if f'pub const {token}:' not in glw:
                missing.append(token)
        if kind == 'ivec3':
            bound = '[' + bound[len('tcu::IVec3('):-1] + ']'
        elif bound in consts:
            bound = str(consts[bound])
        elif kind == 'int64' or kind == 'uint64':
            bound = bound.rstrip('LU')
        elif kind == 'float':
            bound = bound if '.' in bound else bound + '.0'
        out.append(f'        limit("{name}", {tok}, LimitValue::{ {"int":"Int","int64":"Int64","uint64":"Uint64","float":"Float","ivec3":"IVec3"}[kind] }({bound}), {str(is_max == "1").lower()}, "{builtin}"),\n')
sys.stderr.write(f'{len(out)} rows; missing tokens: {missing}\n')
sys.stdout.write(''.join(out))
if args.names:
    args.names.write_text('\n'.join(names))

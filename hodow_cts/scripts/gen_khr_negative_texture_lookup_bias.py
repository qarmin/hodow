#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Prints the shader constants and the `OPS` table of src/khr_gl/negative_texture_lookup_functions_bias_tests.rs.

Both are extracted from glcNegativeTextureLookupFunctionsBiasTests.cpp of the pinned upstream checkout (`--src`, default tmp/glcts-src): every `const std::string` shader literal, and the sequence of `addTest`/`addChild` calls and GLSL version assignments of `init`. Only the desktop branch is kept, so the ES version assignments do not matter.

Usage: gen_khr_negative_texture_lookup_bias.py [--src tmp/glcts-src] > ops.rs.txt
"""
import argparse
import re
import sys
from pathlib import Path

REPO_DIR = Path(__file__).resolve().parents[2]
parser = argparse.ArgumentParser()
parser.add_argument("--src", type=Path, default=REPO_DIR / "tmp" / "glcts-src")
args = parser.parse_args()
cpp = (args.src / "external/openglcts/modules/common/glcNegativeTextureLookupFunctionsBiasTests.cpp").read_text()

consts = {}
for m in re.finditer(r'const std::string (\w+)\s*=\s*((?:"(?:[^"\\]|\\.)*"\s*)+);', cpp):
    consts[m.group(1)] = ''.join(re.findall(r'"((?:[^"\\]|\\.)*)"', m.group(2)))

body = cpp[cpp.index('void NegativeTextureLookupFunctionsBiasTests::init'):]
ops = []
tok = re.compile(r'(addTest|addChild\(new NegativeTextureLookupFunctionsBiasTest)\(\s*(?:m_context,\s*)?"([^"]+)",\s*"[^"]*",\s*(\w+)((?:,\s*(?:true|false))*)\s*\)|GL_GLSL_VER = "([^"]+)"|GLES_GLSL_VER')
for m in tok.finditer(body):
    if m.group(5):
        ops.append(('ver', m.group(5)))
    elif m.group(1):
        flags = [f.strip() == 'true' for f in re.findall(r'true|false', m.group(4))]
        flags += [False] * (3 - len(flags))
        ops.append(('add' if m.group(1) == 'addTest' else 'direct', m.group(2), m.group(3), flags))

# desktop-only: the C++ `if (!is_gles)` block runs, ES version assignments do not matter
used = []
for op in ops:
    if op[0] in ('add', 'direct') and op[2] not in used:
        used.append(op[2])

def rs_name(n):
    return re.sub(r'(?<=[a-z0-9])(?=[A-Z])', '_', n).upper()

out = []
for n in used:
    out.append(f'const {rs_name(n)}: &str = "{consts[n]}";\n')
out.append('\n')
out.append('const OPS: &[Op] = &[\n')
for op in ops:
    if op[0] == 'ver':
        out.append(f'    Op::GlVersion("{op[1]}"),\n')
    else:
        kind = 'AddGeneric' if op[0] == 'add' else 'AddDirect'
        f = op[3]
        out.append(f'    Op::{kind} {{ name: "{op[1]}", source: {rs_name(op[2])}, shadow_lod: {str(f[0]).lower()}, cube_map_array: {str(f[1]).lower()}, sparse_texture2: {str(f[2]).lower()} }},\n')
out.append('];\n')
sys.stdout.write(''.join(out))

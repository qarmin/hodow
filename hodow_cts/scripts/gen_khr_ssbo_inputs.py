#!/usr/bin/env python3
"""Translates the `GetInput*` data builders of gl4cShaderStorageBufferObjectTests.cpp (desktop SSBO tests) into Rust.

Handles exactly the statement shapes those functions use (resize, `fp[n] = v`, `ip[n] = v`, double stores through `reinterpret_cast`, `in[n]`/`expected[n]`, the one `for` loop and `static_cast<float>`); any other statement is an error.

Usage: gen_khr_ssbo_inputs.py <gl4cShaderStorageBufferObjectTests.cpp> <output.rs>
"""
import re
import sys

# (C++ function, Rust function, kind)
FUNCS = [
    ("GetInputC1", "get_input_c1", "A"), ("GetInputC2", "get_input_c2", "A"),
    ("GetInputC3", "get_input_c3", "A"), ("GetInputC4", "get_input_c4", "A"),
    ("GetInputOp1", "get_input_op1", "B"), ("GetInputOp2", "get_input_op2", "B"),
    ("GetInputUBO1", "get_input_ubo1", "C"), ("GetInputUBO2", "get_input_ubo2", "C"),
] + [(f"GetInputM{i}", f"get_input_m{i}", "D") for i in range(1, 8)]

SIGS = {
    "A": "([Vec<u8>; 4], &'static str)",
    "B": "(Vec<u8>, Vec<u8>, &'static str)",
    "C": "([Vec<u8>; 2], &'static str)",
    "D": "(Vec<f32>, Vec<f32>, &'static str)",
}


def literal_tokens(text):
    i, n = 0, len(text)
    out = []
    while i < n:
        c = text[i]
        if c.isspace():
            i += 1
        elif text.startswith("//", i):
            while i < n and text[i] != "\n":
                i += 1
        elif text.startswith("/*", i):
            i = text.index("*/", i) + 2
        elif c == '"':
            j = i + 1
            while text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            out.append(text[i + 1 : j])
            i = j + 1
        elif text.startswith("NL", i):
            out.append("\\n")
            i += 2
        elif c == ";":
            i += 1
        else:
            raise SystemExit(f"unexpected text in return literal: {text[i:i+40]!r}")
    return '"' + "".join(out) + '"'


def num(v, ctype):
    v = v.strip()
    m = re.fullmatch(r"(-?\d+(?:\.\d+)?(?:e-?\d+)?)f?", v)
    if ctype == "f32":
        if m:
            s = m.group(1)
            return s + "f32" if ("." in s or "e" in s) else s + ".0f32"
    if ctype == "f64":
        if m:
            s = m.group(1)
            return s + "f64" if ("." in s or "e" in s) else s + ".0f64"
    if ctype == "i32" and re.fullmatch(r"-?\d+", v):
        return v
    m2 = re.fullmatch(r"static_cast<float>\((.+?)\)\s*\*\s*(\S+)", v)
    if m2:
        return f"(({m2.group(1)}) as f32) * {num(m2.group(2), 'f32')}"
    m3 = re.fullmatch(r"static_cast<float>\((.+)\)", v)
    if m3:
        return f"(({m3.group(1)}) as f32)"
    raise SystemExit(f"cannot translate value {v!r} as {ctype}")


def find_body(lines, name):
    start = next(i for i, l in enumerate(lines) if re.match(rf"const char \*{name}\(", l))
    depth, i = 0, start + 1
    assert lines[i].strip() == "{"
    body = []
    while True:
        l = lines[i]
        depth += l.count("{") - l.count("}")
        if depth == 0:
            break
        body.append(l)
        i += 1
    return body[1:]


def translate(lines, cname, rname, kind):
    body = find_body(lines, cname)
    out = []
    ptr = {"fp": None, "ip": None}
    i = 0
    ind = "    "

    def lval(expr):
        expr = expr.strip()
        if kind in "AC":
            return re.sub(r"^in_data", "data", expr)
        if kind == "B":
            return expr
        return {"in": "input", "expected": "expected"}[expr]

    while i < len(body):
        s = body[i].strip()
        i += 1
        if not s or s.startswith("//") or (s.startswith("/*") and s.endswith("*/")):
            continue
        if s.startswith("return"):
            j = i - 1
            text = "\n".join(body[j:])
            text = text[len("return") + text.index("return") - text.index("return") :] if False else text.strip()[len("return"):]
            lit = literal_tokens(text)
            if kind == "A" or kind == "C":
                out.append(f"{ind}(data, {lit})")
            elif kind == "B":
                out.append(f"{ind}(in_data, out_data, {lit})")
            else:
                out.append(f"{ind}(input, expected, {lit})")
            break
        if s == "{" or s == "}":
            out.append(ind + s)
            continue
        m = re.fullmatch(r"for \(int i = (\d+); i < (\d+); \+\+i\)", s)
        if m:
            out.append(f"{ind}for i in {m.group(1)}..{m.group(2)}usize")
            continue
        m = re.fullmatch(r"([\w\[\]]+)\.resize\((.+)\);", s)
        if m:
            target = lval(m.group(1))
            size = re.sub(r"\s+", " ", m.group(2))
            if kind == "D":
                out.append(f"{ind}{target} = vec![0.0f32; {size}];")
            else:
                out.append(f"{ind}{target} = vec![0u8; {size}];")
            continue
        m = re.fullmatch(r"(float|int) \*(fp|ip)\s*=\s*reinterpret_cast<(?:float|int) \*>\(&([\w\[\]]+?)(?:\[0\])?\);", s)
        if m:
            ptr[m.group(2)] = lval(m.group(3))
            continue
        m = re.fullmatch(r"\*reinterpret_cast<double \*>\(fp \+ (\d+)\)\s*=\s*(.+);", s)
        if m:
            out.append(f"{ind}put_f64(&mut {ptr['fp']}, {m.group(1)}, {num(m.group(2), 'f64')});")
            continue
        m = re.fullmatch(r"(fp|ip)\[(.+?)\]\s*=\s*(.+);", s)
        if m:
            idx = m.group(2).strip()
            if m.group(1) == "fp":
                out.append(f"{ind}put_f32(&mut {ptr['fp']}, {idx}, {num(m.group(3), 'f32')});")
            else:
                out.append(f"{ind}put_i32(&mut {ptr['ip']}, {idx}, {num(m.group(3), 'i32')});")
            continue
        m = re.fullmatch(r"(in|expected)\[(\d+)\]\s*=\s*(.+);", s)
        if m:
            out.append(f"{ind}{lval(m.group(1))}[{m.group(2)}] = {num(m.group(3), 'f32')};")
            continue
        raise SystemExit(f"{cname}: cannot translate statement {s!r}")

    head = {
        "A": "let mut data: [Vec<u8>; 4] = Default::default();",
        "C": "let mut data: [Vec<u8>; 2] = Default::default();",
        "B": "let mut in_data = Vec::new();\n    let mut out_data = Vec::new();",
        "D": "let mut input = Vec::new();\n    let mut expected = Vec::new();",
    }[kind]
    text = f"pub(super) fn {rname}() -> {SIGS[kind]} {{\n    {head}\n" + "\n".join(out) + "\n}\n"
    return text


def main():
    cxx, output = sys.argv[1:3]
    lines = open(cxx, encoding="utf-8").read().split("\n")
    parts = [
        "// SPDX-License-Identifier: Apache-2.0\n//\n// Derived from VK-GL-CTS:\n//   external/openglcts/modules/gl/gl4cShaderStorageBufferObjectTests.cpp\n// Upstream revision: see hodow_cts/upstream/COMMIT\n//\n// Copyright (c) 2014-2016 The Khronos Group Inc.\n// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).\n//\n// Generated by hodow_cts/scripts/gen_khr_ssbo_inputs.py from the `GetInputC*`/`GetInputOp*`/`GetInputUBO*`/`GetInputM*` functions; do not edit.\n",
        "#![allow(unused_mut, unused_assignments, clippy::identity_op)]\n\nuse super::base::*;\n",
    ]
    for cname, rname, kind in FUNCS:
        parts.append(translate(lines, cname, rname, kind))
    open(output, "w", encoding="utf-8").write("\n".join(parts))


main()

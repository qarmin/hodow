#!/usr/bin/env python3
"""Generates hodow_cts/src/khr_gl/texture_view/tables.rs from the switch statements of `TextureViewUtilities` in gl4cTextureViewTests.cpp.

The C++ is a set of `switch (internalformat) { case A: case B: { result = X; break; } ... }` lookups. Each one becomes a Rust `match` with one arm per group of case labels; `default: TCU_FAIL(..)` becomes an `Err`. Output is not rustfmt'ed (the repo never runs cargo fmt on generated files); regeneration is idempotent.

Usage:
    python3 hodow_cts/scripts/gen_khr_texture_view_tables.py [--cpp PATH] [--out PATH] [--check]
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
DEFAULT_CPP = REPO_DIR / "tmp" / "glcts-src" / "external" / "openglcts" / "modules" / "gl" / "gl4cTextureViewTests.cpp"
DEFAULT_OUT = CRATE_DIR / "src" / "khr_gl" / "texture_view" / "tables.rs"


def camel(name: str, prefix: str) -> str:
    return "".join(part.capitalize() for part in name[len(prefix):].lower().split("_"))


def function_body(src: str, name: str) -> str:
    start = src.index("TextureViewUtilities::" + name + "(")
    end = src.index("\n}\n", start)
    return src[start:end]


def switch_groups(body: str) -> tuple[list[tuple[list[str], list[str]]], bool]:
    """Returns ([(labels, statements)], has_default_fail) for the outermost switch of a function."""
    groups: list[tuple[list[str], list[str]]] = []
    labels: list[str] = []
    stmts: list[str] = []
    has_default_fail = False
    in_default = False
    started = False
    for raw in body.split("\n"):
        line = re.sub(r"/\*.*?\*/", "", raw).strip()
        if not started:
            if line.startswith("switch"):
                started = True
            continue
        if line.startswith("case "):
            labels.append(line[len("case "):].rstrip(":").strip())
        elif line.startswith("default:"):
            in_default = True
        elif "TCU_FAIL" in line and in_default:
            has_default_fail = True
        elif line.startswith("break;"):
            if labels:
                groups.append((labels, stmts))
            labels, stmts = [], []
        elif re.match(r"(result|out_rgba_size\[\d\])\s*=", line):
            stmts.append(line.rstrip(";"))
    return groups, has_default_fail


def pattern(labels: list[str]) -> str:
    return "\n        | ".join(f"glw::{label}" for label in labels)


def gen_u32_lookup(src: str, cpp_name: str, rust_name: str, param: str) -> str:
    groups, _ = switch_groups(function_body(src, cpp_name))
    out = [f"/// `TextureViewUtilities::{cpp_name}`\npub(super) fn {rust_name}({param}: GLenum) -> Result<u32, TestError> {{\n    Ok(match {param} {{\n"]
    for labels, stmts in groups:
        value = stmts[0].split("=")[1].strip()
        out.append(f"        {pattern(labels)} => {value},\n")
    out.append(f'        _ => return Err(TestError::Fail("Unrecognized internalformat".to_string())),\n    }})\n}}\n\n')
    return "".join(out)


def gen_rgba_sizes(src: str, cpp_name: str, rust_name: str, param: str, what: str) -> str:
    groups, _ = switch_groups(function_body(src, cpp_name))
    out = [f"/// `TextureViewUtilities::{cpp_name}`: bits of R, G, B and A.\npub(super) fn {rust_name}({param}: GLenum) -> Result<[u32; 4], TestError> {{\n    Ok(match {param} {{\n"]
    for labels, stmts in groups:
        values = [0, 0, 0, 0]
        for stmt in stmts:
            m = re.match(r"out_rgba_size\[(\d)\]\s*=\s*(\d+)", stmt)
            values[int(m.group(1))] = int(m.group(2))
        out.append(f"        {pattern(labels)} => [{values[0]}, {values[1]}, {values[2]}, {values[3]}],\n")
    out.append(f'        _ => return Err(TestError::Fail("Unrecognized {what}".to_string())),\n    }})\n}}\n\n')
    return "".join(out)


def gen_enum_lookup(src: str, cpp_name: str, rust_name: str, param: str, enum_name: str, prefix: str) -> str:
    groups, _ = switch_groups(function_body(src, cpp_name))
    out = [f"/// `TextureViewUtilities::{cpp_name}`\npub(super) fn {rust_name}({param}: GLenum) -> Result<{enum_name}, TestError> {{\n    Ok(match {param} {{\n"]
    for labels, stmts in groups:
        value = stmts[0].split("=")[1].strip()
        out.append(f"        {pattern(labels)} => {enum_name}::{camel(value, prefix)},\n")
    out.append(f'        _ => return Err(TestError::Fail("Unrecognized internalformat".to_string())),\n    }})\n}}\n\n')
    return "".join(out)


def gen_glenum_lookup(src: str, cpp_name: str, rust_name: str, param: str) -> str:
    groups, _ = switch_groups(function_body(src, cpp_name))
    out = [f"/// `TextureViewUtilities::{cpp_name}`\npub(super) fn {rust_name}({param}: GLenum) -> Result<GLenum, TestError> {{\n    Ok(match {param} {{\n"]
    for labels, stmts in groups:
        value = stmts[0].split("=")[1].strip()
        out.append(f"        {pattern(labels)} => glw::{value},\n")
    out.append(f'        _ => return Err(TestError::Fail("Unrecognized internalformat".to_string())),\n    }})\n}}\n\n')
    return "".join(out)


def gen_string_lookup(src: str, cpp_name: str, rust_name: str, param: str, fallible: bool) -> str:
    groups, _ = switch_groups(function_body(src, cpp_name))
    ret = "Result<&'static str, TestError>" if fallible else "&'static str"
    wrap = ("Ok(match", ")") if fallible else ("match", "")
    out = [f"/// `TextureViewUtilities::{cpp_name}`\npub(super) fn {rust_name}({param}: GLenum) -> {ret} {{\n    {wrap[0]} {param} {{\n"]
    for labels, stmts in groups:
        value = stmts[0].split("=")[1].strip()
        out.append(f"        {pattern(labels)} => {value},\n")
    if fallible:
        out.append('        _ => return Err(TestError::Fail("Unrecognized internalformat".to_string())),\n')
    else:
        out.append('        _ => "[?]",\n')
    out.append(f"    }}{wrap[1]}\n}}\n\n")
    return "".join(out)


def gen_bool_lookup(src: str, cpp_name: str, rust_name: str, param: str) -> str:
    groups, _ = switch_groups(function_body(src, cpp_name))
    labels = [label for group_labels, _ in groups for label in group_labels]
    return f"/// `TextureViewUtilities::{cpp_name}`\npub(super) fn {rust_name}({param}: GLenum) -> bool {{\n    matches!(\n        {param},\n        {pattern(labels)}\n    )\n}}\n\n"


HEADER = """// SPDX-License-Identifier: Apache-2.0
//
// GENERATED by hodow_cts/scripts/gen_khr_texture_view_tables.py - do not edit by hand.
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureViewTests.cpp  (TextureViewUtilities lookups)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).

use crate::glw::{self, GLenum};
use crate::tcu::TestError;

/// `TextureView::_format`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum Format {
    Float,
    Rgbe,
    SignedInteger,
    Snorm,
    Unorm,
    UnsignedInteger,
}

/// `TextureView::_sampler_type`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum SamplerType {
    Float,
    SignedInteger,
    UnsignedInteger,
}

"""


def generate(src: str) -> str:
    out = [HEADER]
    out.append(gen_u32_lookup(src, "getAmountOfComponentsForInternalformat", "amount_of_components_for_internalformat", "internalformat"))
    out.append(gen_rgba_sizes(src, "getComponentSizeForInternalformat", "component_size_for_internalformat", "internalformat", "internalformat"))
    out.append(gen_rgba_sizes(src, "getComponentSizeForType", "component_size_for_type", "type_", "type"))
    out.append(gen_enum_lookup(src, "getFormatOfInternalformat", "format_of_internalformat", "internalformat", "Format", "FORMAT_"))
    out.append(gen_glenum_lookup(src, "getGLFormatOfInternalformat", "gl_format_of_internalformat", "internalformat"))
    out.append(gen_string_lookup(src, "getInternalformatString", "internalformat_string", "internalformat", True))
    out.append(gen_enum_lookup(src, "getSamplerTypeForInternalformat", "sampler_type_for_internalformat", "internalformat", "SamplerType", "SAMPLER_TYPE_"))
    out.append(gen_string_lookup(src, "getTextureTargetString", "texture_target_string", "texture_target", False))
    out.append(gen_glenum_lookup(src, "getTypeCompatibleWithInternalformat", "type_compatible_with_internalformat", "internalformat"))
    out.append(gen_bool_lookup(src, "isInternalformatCompressed", "is_internalformat_compressed", "internalformat"))
    return "".join(out).rstrip("\n") + "\n"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cpp", type=Path, default=DEFAULT_CPP)
    ap.add_argument("--out", type=Path, default=DEFAULT_OUT)
    ap.add_argument("--check", action="store_true", help="fail if the output file is stale instead of writing it")
    args = ap.parse_args()

    if not args.cpp.is_file():
        print(f"error: {args.cpp} not found; run `just glcts-build` first or pass --cpp", file=sys.stderr)
        return 2

    text = generate(args.cpp.read_text())
    if args.check:
        if not args.out.is_file() or args.out.read_text() != text:
            print(f"{args.out} is stale", file=sys.stderr)
            return 1
        return 0

    args.out.write_text(text)
    print(f"wrote {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

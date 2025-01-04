#!/usr/bin/env python3
"""Generate the shader_object.rendering programs: one fragment shader per distinct (outputs, attachments, format class) combination.

`ShaderObjectRenderingCase::initPrograms` writes one `fragMulti` per test case; the cases differ in how many outputs it has, where the
extra attachments and outputs sit between them, whether an output is a vec4, uvec4 or ivec4 and whether it writes gl_FragDepth. The
combinations repeat across the ~110 colour formats, so the distinct ones become manifest cases and the test picks one by key.

Writes shaders/src/shader_object/rendering/*, shaders/manifest/shader_object_rendering.toml and
src/vkt/tests/shader_object/rendering_programs.rs (the key table and the format lists, taken from upstream's own source).

Usage:
    python3 hodow_cts/scripts/gen_shader_object_rendering.py [--cts-dir tmp/VK-GL-CTS]
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "shader_object" / "rendering"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "shader_object_rendering.toml"
RUST_OUT = CRATE_DIR / "src" / "vkt" / "tests" / "shader_object" / "rendering_programs.rs"

UPSTREAM = "external/vulkancts/modules/vulkan/shader_object/vktShaderObjectRenderingTests.cpp"
NONE, BEFORE, BETWEEN, AFTER = 0, 1, 2, 3

EXTRA_ATTACHMENTS = [(0, NONE), (1, BEFORE), (1, BETWEEN), (1, AFTER), (2, BEFORE), (2, BETWEEN), (2, AFTER)]
EXTRA_OUTPUTS = EXTRA_ATTACHMENTS
COLOR_ATTACHMENT_COUNTS = [0, 1, 4, 8]


def key(cc, ea, eak, eo, eok, cls, rnd, dw, arr):
    return f"c{cc}a{ea}{eak}o{eo}{eok}t{cls}r{int(rnd)}d{int(dw)}y{int(arr)}"


def fragment_source(cc, ea, eak, eo, eok, cls, rnd, dw, arr):
    out = "#version 450\n"
    output_count = cc + eo

    def location(i):
        j = i
        if eak == BEFORE or (eak == BETWEEN and i > output_count // 2):
            j += ea
        return j

    def first_written(i):
        return (i == eo) if eok == BEFORE else (i == 0)

    def kind(i):
        special = first_written(i) or not rnd
        if cls == 1 and special:
            return "uvec4", "uvec4(255)"
        if cls == 2 and special:
            return "ivec4", "ivec4(255)"
        return "vec4", "vec4(1.0f)"

    if arr:
        total = cc + eo + ea
        out += f"layout(location = 0) out vec4 outColor[{total}];\n"
    else:
        for i in range(output_count):
            j = location(i)
            out += f"layout (location = {j}) out {kind(i)[0]} outColor{j};\n"
    out += "void main() {\n"
    for i in range(output_count):
        j = location(i)
        out += f"    outColor[{j}]" if arr else f"    outColor{j}"
        out += f" = {kind(i)[1]};\n"
    if dw:
        out += "    gl_FragDepth = 0.5f;\n"
    out += "}\n"
    return out


def distinct_keys():
    keys = {}
    for cc in COLOR_ATTACHMENT_COUNTS:
        for ea, eak in EXTRA_ATTACHMENTS:
            for eo, eok in EXTRA_OUTPUTS:
                if eak != NONE and eo != 0:
                    continue
                for dummy in range(3):
                    for rnd in (True, False):
                        if rnd and cc < 2:
                            continue
                        for before in (True, False):
                            for dw in (True, False):
                                if ea > cc:
                                    continue
                                if not before and dummy != 0:
                                    continue
                                for cls in range(3):
                                    args = (cc, ea, eak, eo, eok, cls, rnd, dw, False)
                                    keys[key(*args)] = args
    # `output_array`: four colour attachments with two extra ones between, one array output, no format class (the test never assigns the
    # format it loops over to its parameters)
    args = (4, 2, BETWEEN, 0, NONE, 0, False, False, True)
    keys[key(*args)] = args
    return keys


def format_list(text, name):
    m = re.search(r"(?:const vk::VkFormat|const VkFormat) " + name + r"\[\] = \{(.*?)\n\};", text, re.S)
    return re.findall(r"VK_FORMAT_(\w+)", m.group(1))


def rust_format_name(name):
    return name  # vulkanalia spells the constants like the upper-case C names without the prefix, with NxM as NXM


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cts-dir", default=str(REPO_DIR / "tmp" / "VK-GL-CTS"))
    cts = Path(parser.parse_args().cts_dir)
    text = (cts / UPSTREAM).read_text()

    SRC_DIR.mkdir(parents=True, exist_ok=True)
    (SRC_DIR / "vert_depth.vert").write_text(
        "#version 450\nvoid main() {\n    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));\n"
        "    gl_Position = vec4(pos - 0.5f, 0.5f, 1.0f);\n}\n"
    )

    keys = distinct_keys()
    manifest = [
        "# Shader manifest for dEQP-VK.shader_object.rendering.*",
        "#",
        "# Generated by scripts/gen_shader_object_rendering.py; do not hand-edit. One fragment shader per distinct combination of output",
        "# layout and format class (see the script), all drawn by the same `vertDepth`.",
        "",
        f'upstream_source = "{UPSTREAM}"',
        'rust_module = "shader_object/rendering_tests"',
        "",
    ]
    arms = []
    for k, args in sorted(keys.items()):
        (SRC_DIR / f"frag_{k}.frag").write_text(fragment_source(*args))
        const = f"RENDERING_{k.upper()}"
        manifest += [
            "[[case]]",
            f'name = "{k}"',
            f'rust_const = "{const}"',
            'rust_type = "SharedProgram"',
            "programs = [",
            '    { name = "vertDepth", template = "shader_object/rendering/vert_depth.vert", stage = "vert" },',
            f'    {{ name = "fragMulti", template = "shader_object/rendering/frag_{k}.frag", stage = "frag" }},',
            "]",
            "",
        ]
        arms.append((k, const))
    MANIFEST.write_text("\n".join(manifest))

    color_formats = format_list(text, "colorFormats")
    random_formats = format_list(text, "randomColorFormats")
    depth_formats = ["D16_UNORM", "X8_D24_UNORM_PACK32", "D32_SFLOAT", "D16_UNORM_S8_UINT", "D24_UNORM_S8_UINT", "D32_SFLOAT_S8_UINT"]

    def vk_name(n):
        return re.sub(r"(\d)x(\d)", r"\1X\2", n)

    rust = [
        "// SPDX-License-Identifier: Apache-2.0",
        "//",
        "// Derived from VK-GL-CTS:",
        f"//   {UPSTREAM}",
        "// Upstream revision: see hodow_cts/upstream/COMMIT",
        "//",
        "// Copyright (c) 2023 The Khronos Group Inc.",
        "// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).",
        "//",
        "// Generated by scripts/gen_shader_object_rendering.py; do not hand-edit.",
        "",
        "use vulkanalia::prelude::v1_0::*;",
        "",
        "use crate::generated::shaders::shader_object_rendering::*;",
        "use crate::vk::programs::BinaryCollection;",
        "",
        "/// `colorFormats`, with the case name `getFormatCaseName` gives each.",
        "pub const COLOR_FORMATS: &[(vk::Format, &str)] = &[",
    ]
    rust += [f'    (vk::Format::{vk_name(n)}, "{n.lower()}"),' for n in color_formats]
    rust += ["];", "", "/// `randomColorFormats`", "pub const RANDOM_COLOR_FORMATS: &[vk::Format] = &["]
    rust += [f"    vk::Format::{vk_name(n)}," for n in random_formats]
    rust += ["];", "", "/// `formats::depthFormats`", "pub const DEPTH_FORMATS: &[(vk::Format, &str)] = &["]
    rust += [f'    (vk::Format::{vk_name(n)}, "{n.lower()}"),' for n in depth_formats]
    rust += [
        "];",
        "",
        "/// The key `scripts/gen_shader_object_rendering.py` names a fragment shader by.",
        "pub fn program_key(color_count: u32, extra_attachments: u32, extra_attachment_kind: u32, extra_outputs: u32, extra_output_kind: u32, class: u32, random: bool, frag_depth: bool, array: bool) -> String {",
        '    format!("c{color_count}a{extra_attachments}{extra_attachment_kind}o{extra_outputs}{extra_output_kind}t{class}r{}d{}y{}", u32::from(random), u32::from(frag_depth), u32::from(array))',
        "}",
        "",
        "pub fn rendering_programs(key: &str) -> Option<BinaryCollection> {",
        "    Some(match key {",
    ]
    rust += [f'        "{k}" => {c}.programs,' for k, c in arms]
    rust += ["        _ => return None,", "    })", "}", ""]
    RUST_OUT.write_text("\n".join(rust))
    print(f"{len(keys)} programs, {len(color_formats)} colour formats, {len(random_formats)} random formats")


if __name__ == "__main__":
    main()

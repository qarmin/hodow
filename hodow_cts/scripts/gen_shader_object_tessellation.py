#!/usr/bin/env python3
"""Generate the SPIR-V assembly sources, the manifest and the key table of dEQP-VK.shader_object.tessellation.{glsl,hlsl}.*

`ShaderObjectTessellationCase::initPrograms` splices execution modes into hand-written tessellation control and evaluation shaders:
the `glsl` cases keep the primitive, spacing, orientation and point mode in the evaluation shader (the control shader only has the output
vertex count), the `hlsl` ones in the control shader, and a `_rebind` case also gets the opposite shaders to bind in between. The text of
the shaders and the 17x17 reference tables are taken out of the vendored upstream file rather than copied, so they cannot drift from it.

Usage:
    python3 hodow_cts/scripts/gen_shader_object_tessellation.py
"""

from __future__ import annotations

import hashlib
import re
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
UPSTREAM = CRATE_DIR / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "shader_object" / "vktShaderObjectTessellationTests.cpp"
SRC_REL = "shader_object/tessellation"
SRC_DIR = CRATE_DIR / "shaders" / "src" / SRC_REL
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "shader_object_tessellation.toml"
RUST_OUT = CRATE_DIR / "src" / "vkt" / "tests" / "shader_object" / "tessellation_programs.rs"

LITERAL = re.compile(r'"((?:[^"\\]|\\.)*)"')


def cpp_string(text: str, name: str) -> str:
    """The concatenated string literals assigned to `std::string <name>`."""
    match = re.search(r"std::string\s+" + re.escape(name) + r"\s*=", text)
    if not match:
        raise SystemExit(f"{name} not found in {UPSTREAM}")
    pos = match.end()
    out = []
    while True:
        while text[pos] in " \t\r\n":
            pos += 1
        if text.startswith("//", pos):
            pos = text.index("\n", pos)
            continue
        if text[pos] == ";":
            break
        literal = LITERAL.match(text, pos)
        if not literal:
            raise SystemExit(f"unexpected text after {name} at offset {pos}")
        out.append(literal.group(1).encode().decode("unicode_escape"))
        pos = literal.end()
    return "".join(out)


def cpp_table(text: str, name: str) -> list[list[int]]:
    match = re.search(r"const bool " + re.escape(name) + r"\[testSize\]\[testSize\]\s*=\s*\{(.*?)\};", text, re.S)
    if not match:
        raise SystemExit(f"table {name} not found")
    rows = re.findall(r"\{([^{}]*)\}", match.group(1))
    table = [[int(v) for v in row.split(",")] for row in rows]
    assert len(table) == 17 and all(len(row) == 17 for row in table), name
    return table


TEST_TYPES = [
    "orientation_ccw",
    "orientation_cw",
    "spacing_equal",
    "spacing_fractional_odd",
    "patch_vertices_4",
    "patch_vertices_5",
    "primitive_quads",
    "primitive_triangles",
    "point_mode",
]


def modes(test: str) -> tuple[dict[str, str], dict[str, str]]:
    """The (modes, rebind modes) of `initPrograms`, as OpExecutionMode lines."""

    def mode(name: str) -> str:
        return f"               OpExecutionMode %main {name}\n"

    modes = {}
    rebind = {}
    modes["vertices"], rebind["vertices"] = (mode("OutputVertices 5"), mode("OutputVertices 4")) if test == "patch_vertices_5" else (mode("OutputVertices 4"), mode("OutputVertices 4"))
    modes["primitive"], rebind["primitive"] = (mode("Triangles"), mode("Quads")) if test == "primitive_triangles" else (mode("Quads"), mode("Triangles"))
    modes["spacing"], rebind["spacing"] = (mode("SpacingFractionalOdd"), mode("SpacingEqual")) if test == "spacing_fractional_odd" else (mode("SpacingEqual"), mode("SpacingFractionalOdd"))
    modes["orientation"], rebind["orientation"] = (mode("VertexOrderCw"), mode("VertexOrderCcw")) if test == "orientation_cw" else (mode("VertexOrderCcw"), mode("VertexOrderCw"))
    modes["point"], rebind["point"] = (mode("PointMode"), "") if test == "point_mode" else ("", mode("PointMode"))
    return modes, rebind


def main() -> int:
    text = UPSTREAM.read_text()
    vert, frag = cpp_string(text, "vert"), cpp_string(text, "frag")
    tesc1, tesc2 = cpp_string(text, "tesc1"), cpp_string(text, "tesc2")
    tese1, tese2 = cpp_string(text, "tese1"), cpp_string(text, "tese2")

    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for stale in SRC_DIR.glob("*"):
        stale.unlink()

    files: dict[str, str] = {}

    def write(source: str) -> str:
        digest = hashlib.sha1(source.encode()).hexdigest()[:12]
        template = f"{SRC_REL}/{digest}.asm"
        if digest not in files:
            (SRC_DIR / f"{digest}.asm").write_text(source)
            files[digest] = template
        return template

    cases = []
    for source in ("glsl", "hlsl"):
        for test in TEST_TYPES:
            for rebind in (False, True):
                m, r = modes(test)
                if source == "glsl":
                    tesc_modes = m["vertices"]
                    tesc_rebind = r["vertices"] + r["primitive"] + r["spacing"] + r["orientation"] + r["point"]
                    tese_modes = m["primitive"] + m["spacing"] + m["orientation"] + m["point"]
                    tese_rebind = r["primitive"]
                else:
                    tesc_modes = m["vertices"] + m["primitive"] + m["spacing"] + m["orientation"] + m["point"]
                    tesc_rebind = r["vertices"]
                    tese_modes = m["primitive"]
                    tese_rebind = r["primitive"] + r["spacing"] + r["orientation"] + r["point"]
                programs = {"vert": vert, "tesc": tesc1 + tesc_modes + tesc2, "tese": tese1 + tese_modes + tese2, "frag": frag}
                if rebind:
                    programs["tesc_rebind"] = tesc1 + tesc_rebind + tesc2
                    programs["tese_rebind"] = tese1 + tese_rebind + tese2
                key = f"{source}_{test}" + ("_rebind" if rebind else "")
                cases.append((key, {name: write(src) for name, src in programs.items()}))

    lines = [
        "# Shader manifest for dEQP-VK.shader_object.tessellation.*",
        "#",
        "# Generated by scripts/gen_shader_object_tessellation.py together with the sources it names; do not hand-edit either.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shader_object/vktShaderObjectTessellationTests.cpp"',
        'rust_module = "shader_object/tessellation_tests"',
        "",
    ]
    for key, programs in cases:
        lines += [
            "[[case]]",
            f'name = "{key}"',
            f'rust_const = "TESS_{key.upper()}"',
            'rust_type = "SharedProgram"',
            "programs = [ " + ", ".join(f'{{ name = "{name}", template = "{template}", stage = "asm" }}' for name, template in programs.items()) + " ]",
            "",
        ]
    MANIFEST.write_text("\n".join(lines))

    rust = [
        "// SPDX-License-Identifier: Apache-2.0",
        "//",
        "// Derived from VK-GL-CTS:",
        "//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectTessellationTests.cpp",
        "// Upstream revision: see hodow_cts/upstream/COMMIT",
        "//",
        "// Copyright (c) 2023 The Khronos Group Inc.",
        "// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).",
        "//",
        "// Generated by scripts/gen_shader_object_tessellation.py; do not hand-edit.",
        "",
        "use crate::generated::shaders::shader_object_tessellation::*;",
        "use crate::vk::programs::BinaryCollection;",
        "",
        "pub const TEST_SIZE: usize = 17;",
        "",
    ]
    for upstream_name, rust_name in (("basic", "BASIC"), ("fractionalOdd", "FRACTIONAL_ODD"), ("triangles", "TRIANGLES"), ("pointMode", "POINT_MODE")):
        table = cpp_table(text, upstream_name)
        rust.append(f"pub const {rust_name}: [[u8; TEST_SIZE]; TEST_SIZE] = [")
        for row in table:
            rust.append("    [" + ", ".join(str(v) for v in row) + "],")
        rust += ["];", ""]
    rust += ["/// The programs of `<source>_<test>[_rebind]`, the key the case registration builds.", "pub fn tessellation_programs(key: &str) -> Option<BinaryCollection> {", "    Some(match key {"]
    for key, _ in cases:
        rust.append(f'        "{key}" => TESS_{key.upper()}.programs,')
    rust += ["        _ => return None,", "    })", "}", ""]
    RUST_OUT.write_text("\n".join(rust))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)}, {RUST_OUT.relative_to(REPO_DIR)} and {len(files)} sources in {SRC_DIR.relative_to(REPO_DIR)} for {len(cases)} cases")
    return 0


if __name__ == "__main__":
    sys.exit(main())

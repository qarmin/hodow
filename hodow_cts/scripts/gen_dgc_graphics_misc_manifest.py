#!/usr/bin/env python3
"""Writes the shaders and the manifest of the small dEQP-VK.dgc.ext.graphics.misc cases in `graphics_misc_tests.rs`
(early_fragment_tests, indexed_draws_with_draw_index_base_instance of vktDGCGraphicsMiscTestsExt.cpp). A pure text generator."""

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "shaders" / "manifest" / "dgc_graphics_misc.toml"
SRC_DIR = ROOT / "shaders" / "src" / "dgc"

EF_VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "void main(void) {\n"
    "    gl_Position = inPos;\n"
    "    gl_PointSize = 1.0f;\n"
    "}\n"
)


def ef_frag(depth, color):
    return (
        "#version 460\n"
        "layout (early_fragment_tests) in;\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main(void) {\n"
        f"    gl_FragDepth = {depth};\n"
        f"    outColor = vec4({color});\n"
        "}\n"
    )


DI_VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main (void) {\n"
    "    gl_Position = inPos;\n"
    "    outColor = vec4(1.0, float(gl_DrawID), float(gl_BaseInstance), 1.0);\n"
    "}\n"
)

DI_FRAG = (
    "#version 460\n"
    "layout (location=0) in vec4 inColor;\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main (void) {\n"
    "    outColor = inColor;\n"
    "}\n"
)

VBO_VERT = (
    "#version 460\n"
    "\n"
    "layout(location=0) in vec4 inPos;\n"
    "layout(location=1) in float inRed;\n"
    "layout(location=2) in float inGreen;\n"
    "layout(location=3) in float inBlue;\n"
    "\n"
    "layout(location=0) out float outRed;\n"
    "layout(location=1) out float outGreen;\n"
    "layout(location=2) out float outBlue;\n"
    "\n"
    "void main(void) {\n"
    "    gl_Position = inPos;\n"
    "    outRed = inRed;\n"
    "    outGreen = inGreen;\n"
    "    outBlue = inBlue;\n"
    "}\n"
)

VBO_FRAG = (
    "#version 460\n"
    "\n"
    "layout(location=0) in float inRed;\n"
    "layout(location=1) in float inGreen;\n"
    "layout(location=2) in float inBlue;\n"
    "\n"
    "layout(location=0) out vec4 outColor;\n"
    "\n"
    "void main(void) {\n"
    "    outColor = vec4(inRed, inGreen, inBlue, 1.0);\n"
    "}\n"
)

SEQ_VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "void main(void) {\n"
    "    gl_Position = inPos;\n"
    "    gl_PointSize = 1.0f;\n"
    "}\n"
)

SEQ_FRAG = (
    "#version 460\n"
    "layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;\n"
    "layout (location=0) out uvec4 outColor;\n"
    "void main(void) {\n"
    "    outColor = uvec4(pc.seqIndex, 0u, 255u, 255u);\n"
    "}\n"
)

REUSE_VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "layout (push_constant, std430) uniform PCBlock { vec4 offset; } pc;\n"
    "void main (void)\n"
    "{\n"
    "    gl_Position = inPos + pc.offset;\n"
    "}\n"
)

REUSE_COLORS = {
    "es": ["1.0, 0.0, 0.0, 1.0", "1.0, 1.0, 0.0, 1.0", "1.0, 1.0, 1.0, 1.0"],
    "noes": ["1.0, 0.0, 1.0, 1.0"],
}


def reuse_frag(color):
    return (
        "#version 460\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main (void)\n"
        "{\n"
        f"    outColor = vec4({color});\n"
        "}\n"
    )


REBIND_VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "void main (void)\n"
    "{\n"
    "    gl_Position = inPos;\n"
    "}\n"
)

REBIND_FRAG_NORMAL = (
    "#version 460\n"
    "layout (location=0) out vec4 outColor;\n"
    "layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;\n"
    "void main (void) {\n"
    "    outColor = vec4(1.0, 1.0, float(pc.seqIndex), 1.0);\n"
    "}\n"
)


def rebind_frag_dgc(red):
    return (
        "#version 460\n"
        "layout (location=0) out vec4 outColor;\n"
        "layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;\n"
        "void main (void) {\n"
        f"    outColor = vec4({red}, 0.0, float(pc.seqIndex), 1.0);\n"
        "}\n"
    )


MIX_VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "void main (void) {\n"
    "    gl_Position = inPos;\n"
    "    gl_PointSize = 1.0;\n"
    "}\n"
)

MIX_FRAG = (
    "#version 460\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main (void) {\n"
    "    outColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
    "}\n"
)

DYN_VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "layout (location=1) in vec4 inColor;\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main (void) {\n"
    "    gl_Position = inPos;\n"
    "    gl_PointSize = 1.0f;\n"
    "    outColor = inColor;\n"
    "}\n"
)


def dyn_frag(swizzle):
    return (
        "#version 460\n"
        "layout (location=0) in vec4 inColor;\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main (void) {\n"
        f"    outColor = inColor.{swizzle};\n"
        "}\n"
    )


FILES = {
    "misc_dyn_vtx_vert.vert": DYN_VERT,
    "misc_dyn_vtx_frag0.frag": dyn_frag("rgba"),
    "misc_dyn_vtx_frag1.frag": dyn_frag("abgr"),
    "misc_mix_vert.vert": MIX_VERT,
    "misc_mix_frag.frag": MIX_FRAG,
    "misc_rebind_vert.vert": REBIND_VERT,
    "misc_rebind_frag_normal.frag": REBIND_FRAG_NORMAL,
    "misc_rebind_frag_dgc0.frag": rebind_frag_dgc("1.0"),
    "misc_rebind_frag_dgc1.frag": rebind_frag_dgc("0.0"),
    "misc_reuse_vert.vert": REUSE_VERT,
    "misc_sequence_index_vert.vert": SEQ_VERT,
    "misc_sequence_index_frag.frag": SEQ_FRAG,
    "misc_vbo_update_vert.vert": VBO_VERT,
    "misc_vbo_update_frag.frag": VBO_FRAG,
    "misc_early_frag_vert.vert": EF_VERT,
    "misc_early_frag0.frag": ef_frag("0.25", "0.0, 0.0, 1.0, 1.0"),
    "misc_early_frag1.frag": ef_frag("0.125", "1.0, 0.0, 1.0, 1.0"),
    "misc_draw_index_vert.vert": DI_VERT,
    "misc_draw_index_frag.frag": DI_FRAG,
}
for _key, _colors in REUSE_COLORS.items():
    for _i, _color in enumerate(_colors):
        FILES[f"misc_reuse_{_key}_frag{_i}.frag"] = reuse_frag(_color)


MIX_CASE = (
    '\n[[case]]\nname = "mix_normal_dgc"\nrust_const = "MIX_NORMAL_DGC"\nrust_type = "SharedProgram"\n'
    'programs = [ { name = "vert", template = "dgc/misc_mix_vert.vert", stage = "vert" }, '
    '{ name = "frag", template = "dgc/misc_mix_frag.frag", stage = "frag" } ]\n'
)


DYN_CASE = (
    '\n[[case]]\nname = "dyn_vtx_input"\nrust_const = "DYN_VTX_INPUT"\nrust_type = "SharedProgram"\n'
    'programs = [ { name = "vert", template = "dgc/misc_dyn_vtx_vert.vert", stage = "vert" }, '
    '{ name = "frag0", template = "dgc/misc_dyn_vtx_frag0.frag", stage = "frag" }, '
    '{ name = "frag1", template = "dgc/misc_dyn_vtx_frag1.frag", stage = "frag" } ]\n'
)


def rebind_case(key, count):
    frags = ", ".join(
        f'{{ name = "fragDGC{i}", template = "dgc/misc_rebind_frag_dgc{i}.frag", stage = "frag" }}' for i in range(count)
    )
    return (
        f'\n[[case]]\nname = "rebind_{key}"\nrust_const = "REBIND_{key.upper()}"\nrust_type = "SharedProgram"\n'
        f'programs = [ {{ name = "vert", template = "dgc/misc_rebind_vert.vert", stage = "vert" }}, '
        f'{{ name = "fragNormal", template = "dgc/misc_rebind_frag_normal.frag", stage = "frag" }}, {frags} ]\n'
    )


def reuse_case(key):
    frags = ", ".join(
        f'{{ name = "frag{i}", template = "dgc/misc_reuse_{key}_frag{i}.frag", stage = "frag" }}'
        for i in range(len(REUSE_COLORS[key]))
    )
    return (
        f'\n[[case]]\nname = "reuse_{key}"\nrust_const = "REUSE_{key.upper()}"\nrust_type = "SharedProgram"\n'
        f'programs = [ {{ name = "vert", template = "dgc/misc_reuse_vert.vert", stage = "vert" }}, {frags} ]\n'
    )


MANIFEST_TEXT = """# Shader manifest for the small dEQP-VK.dgc.ext.graphics.misc cases (early_fragment_tests, indexed_draws_with_draw_index_base_instance, vbo_update)
#
# @generated by hodow_cts/scripts/gen_dgc_graphics_misc_manifest.py - do not hand-edit.

upstream_source = "external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp"
rust_module = "dgc/graphics_misc_tests"

[[case]]
name = "early_fragment_tests"
rust_const = "EARLY_FRAGMENT_TESTS"
rust_type = "SharedProgram"
programs = [ { name = "vert", template = "dgc/misc_early_frag_vert.vert", stage = "vert" }, { name = "frag0", template = "dgc/misc_early_frag0.frag", stage = "frag" }, { name = "frag1", template = "dgc/misc_early_frag1.frag", stage = "frag" } ]

[[case]]
name = "draw_index_base_instance"
rust_const = "DRAW_INDEX_BASE_INSTANCE"
rust_type = "SharedProgram"
programs = [ { name = "vert", template = "dgc/misc_draw_index_vert.vert", stage = "vert", spirv_version = "spirv1.3" }, { name = "frag", template = "dgc/misc_draw_index_frag.frag", stage = "frag" } ]

[[case]]
name = "vbo_update"
rust_const = "VBO_UPDATE"
rust_type = "SharedProgram"
programs = [ { name = "vert", template = "dgc/misc_vbo_update_vert.vert", stage = "vert" }, { name = "frag", template = "dgc/misc_vbo_update_frag.frag", stage = "frag" } ]

[[case]]
name = "sequence_index_token"
rust_const = "SEQUENCE_INDEX_TOKEN"
rust_type = "SharedProgram"
programs = [ { name = "vert", template = "dgc/misc_sequence_index_vert.vert", stage = "vert" }, { name = "frag", template = "dgc/misc_sequence_index_frag.frag", stage = "frag" } ]
"""


def main():
    global MANIFEST_TEXT
    MANIFEST_TEXT += MIX_CASE + DYN_CASE + reuse_case("es") + reuse_case("noes") + rebind_case("es", 2) + rebind_case("noes", 1)
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for name, text in FILES.items():
        (SRC_DIR / name).write_text(text)
    MANIFEST.write_text(MANIFEST_TEXT)
    print(f"wrote {MANIFEST}")


if __name__ == "__main__":
    main()

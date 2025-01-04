#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.dgc.ext.graphics.tess_state (`TessStateCase::initPrograms`), one program set per pair of
layer parameters (primitive type, spacing, patch size). A pure text generator: no glslang and no cargo."""

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "shaders" / "manifest" / "dgc_graphics_tess_state.toml"
SRC_DIR = ROOT / "shaders" / "src" / "dgc"

PRIMS = ["triangles", "isolines", "quads"]
SPACINGS = [("equal", "equal_spacing"), ("odd", "fractional_odd_spacing"), ("even", "fractional_even_spacing")]
SIZES = [3, 4]

# std::to_string((2.0f / 32.0f) * 0.25f)
DELTA = "0.015625"

POSITIONS = (
    "const vec2 positions[4] = vec2[](\n"
    f"    vec2(-1.0 + {DELTA}, -1.0 + {DELTA}),\n"
    f"    vec2(-1.0 + {DELTA},  1.0 - {DELTA}),\n"
    f"    vec2( 1.0 - {DELTA}, -1.0 + {DELTA}),\n"
    f"    vec2( 1.0 - {DELTA},  1.0 - {DELTA})\n"
    ");\n"
)

VERT = (
    "#version 460\n"
    + POSITIONS
    + "void main() {\n"
    "    gl_Position  = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);\n"
    "    gl_PointSize = 1.0;\n"
    "}\n"
)

FRAG = (
    "#version 460\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main() {\n"
    "    outColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
    "}\n"
)


def tesc(patch_size):
    return (
        "#version 460\n"
        + POSITIONS
        + f"layout (vertices={patch_size}) out;\n"
        "void main() {\n"
        "    if (gl_InvocationID >= gl_PatchVerticesIn) {\n"
        "        gl_out[gl_InvocationID].gl_Position  = vec4(positions[3], 0.0, 1.0);\n"
        "        gl_out[gl_InvocationID].gl_PointSize = 1.0;\n"
        "    }\n"
        "    else {\n"
        "        gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position;\n"
        "        gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;\n"
        "    }\n"
        "    if (gl_InvocationID == 0) {\n"
        "        gl_TessLevelOuter[0] = 3.25;\n"
        "        gl_TessLevelOuter[1] = 5.25;\n"
        "        gl_TessLevelOuter[2] = 7.25;\n"
        "        gl_TessLevelOuter[3] = 9.25;\n"
        "        gl_TessLevelInner[0] = 3.25;\n"
        "        gl_TessLevelInner[1] = 5.25;\n"
        "    }\n"
        "}\n"
    )


LINE_QUAD_3 = (
    "    const float xCoord = gl_TessCoord.x;\n"
    "    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;\n"
    "    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;\n"
    "    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;\n"
    "    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;\n"
    "    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;\n"
    "    gl_Position = vec4(xPos, yPos, 0.0, 1.0);\n"
)
LINE_QUAD_4 = (
    "    const float xCoord = gl_TessCoord.x;\n"
    "    const float yCoord = gl_TessCoord.y;\n"
    "    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;\n"
    "    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;\n"
    "    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;\n"
    "    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;\n"
    "    gl_Position = vec4(xPos, yPos, 0.0, 1.0);\n"
)
TRIANGLES_3 = (
    "    const float u = gl_TessCoord.x;\n"
    "    const float v = gl_TessCoord.y;\n"
    "    const float w = gl_TessCoord.z;\n"
    "    gl_Position = (u * gl_in[0].gl_Position) + (v * gl_in[1].gl_Position) + (w * gl_in[2].gl_Position);\n"
)
TRIANGLES_4 = (
    "    const float u = gl_TessCoord.x;\n"
    "    const float v = gl_TessCoord.y;\n"
    "    const float w = gl_TessCoord.z;\n"
    "    const vec4 p1 = gl_in[0].gl_Position;\n"
    "    const vec4 p2 = gl_in[1].gl_Position;\n"
    "    const vec4 p3 = gl_in[2].gl_Position * 0.5 + gl_in[3].gl_Position * 0.5;\n"
    "    gl_Position = (u * p1) + (v * p2) + (w * p3);\n"
)


def position_calc(prim, size):
    if prim == "triangles":
        return TRIANGLES_3 if size == 3 else TRIANGLES_4
    return LINE_QUAD_3 if size == 3 else LINE_QUAD_4


def tese(prim, spacing_name, size, layer):
    return (
        "#version 460\n"
        "#extension GL_ARB_shader_viewport_layer_array : enable\n"
        f"layout({prim}, {spacing_name}, point_mode) in;\n"
        "void main()\n"
        "{\n"
        + position_calc(prim, size)
        + "    gl_PointSize = 1.0;\n"
        f"    gl_Layer = {layer};\n"
        "}\n"
    )


def layer_key(prim, spacing, size):
    return f"{prim}_{spacing}_{size}"


PCP_COLORS = ["0.0, 1.0, 1.0, 1.0", "1.0, 0.0, 1.0, 1.0", "1.0, 1.0, 0.0, 1.0", "1.0, 1.0, 1.0, 1.0"]
PCP_ACTUAL = 4


def pcp_vert():
    return (
        "#version 460\n"
        "layout (location=0) in vec4 inPos;\n"
        "layout (push_constant) uniform PCBlock { vec4 offset; } pc;\n"
        "void main (void) {\n"
        "    gl_Position = inPos + pc.offset;\n"
        "    gl_PointSize = 1.0;\n"
        "}\n"
    )


def pcp_frag():
    return (
        "#version 460\n"
        "layout (location=0) in vec4 inColor;\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main (void) {\n"
        "    outColor = inColor;\n"
        "}\n"
    )


def pcp_tesc(i):
    return (
        "#version 460\n"
        f"layout (vertices={PCP_ACTUAL}) out;\n"
        "void main (void) {\n"
        f"    const bool goodPVI = (gl_PatchVerticesIn == {PCP_ACTUAL});\n"
        "    const float posOffset = (goodPVI ? 0.0 : 10.0);\n"
        "\n"
        "    gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position + posOffset;\n"
        "    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;\n"
        "\n"
        f"    const float extraLevels = {i}.0;\n"
        "    if (gl_InvocationID == 0) {\n"
        "        gl_TessLevelOuter[0] = 3.0 + extraLevels;\n"
        "        gl_TessLevelOuter[1] = 5.0 + extraLevels;\n"
        "        gl_TessLevelOuter[2] = 7.0 + extraLevels;\n"
        "        gl_TessLevelOuter[3] = 9.0 + extraLevels;\n"
        "        gl_TessLevelInner[0] = 3.0 + extraLevels;\n"
        "        gl_TessLevelInner[1] = 5.0 + extraLevels;\n"
        "    }\n"
        "}\n"
    )


def pcp_tese(i):
    return (
        "#version 460\n"
        "layout (quads, point_mode) in;\n"
        "layout (location=0) out vec4 vertColor;\n"
        "void main (void) {\n"
        f"    const bool goodPVI = (gl_PatchVerticesIn == {PCP_ACTUAL});\n"
        "    const float posOffset = (goodPVI ? 0.0 : 10.0);\n"
        "\n"
        "    const float u = gl_TessCoord.x;\n"
        "    const float v = gl_TessCoord.y;\n"
        "    const vec4 p0 = gl_in[0].gl_Position;\n"
        "    const vec4 p1 = gl_in[1].gl_Position;\n"
        "    const vec4 p2 = gl_in[2].gl_Position;\n"
        "    const vec4 p3 = gl_in[3].gl_Position;\n"
        "    gl_Position = ((1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3) + posOffset;\n"
        "    gl_PointSize = 1.0;\n"
        f"    vertColor = vec4({PCP_COLORS[i]});\n"
        "}\n"
    )


HEADER = """# Shader manifest for dEQP-VK.dgc.ext.graphics.tess_state
#
# @generated by hodow_cts/scripts/gen_dgc_tess_state_manifest.py - do not hand-edit.

upstream_source = "external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsTessStateTestsExt.cpp"
rust_module = "dgc/graphics_tess_state_tests"
"""


def main():
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    (SRC_DIR / "tess_state_vert.vert").write_text(VERT)
    (SRC_DIR / "tess_state_frag.frag").write_text(FRAG)
    for size in SIZES:
        (SRC_DIR / f"tess_state_tesc_{size}.tesc").write_text(tesc(size))

    layers = []
    for prim in PRIMS:
        for spacing, spacing_name in SPACINGS:
            for size in SIZES:
                layers.append((prim, spacing, spacing_name, size))
                for layer in (0, 1):
                    (SRC_DIR / f"tess_state_tese_{layer_key(prim, spacing, size)}_l{layer}.tese").write_text(
                        tese(prim, spacing_name, size, layer)
                    )

    out = [HEADER]
    count = 0
    for first in layers:
        for second in layers:
            if first == second:
                continue
            fk = layer_key(first[0], first[1], first[3])
            sk = layer_key(second[0], second[1], second[3])
            key = f"tess_state_{fk}__{sk}"
            progs = [
                ("vert", "dgc/tess_state_vert.vert", "vert", None),
                ("frag", "dgc/tess_state_frag.frag", "frag", None),
                ("tesc1", f"dgc/tess_state_tesc_{first[3]}.tesc", "tesc", None),
                ("tesc2", f"dgc/tess_state_tesc_{second[3]}.tesc", "tesc", None),
                ("tese1-spv10", f"dgc/tess_state_tese_{fk}_l0.tese", "tese", None),
                ("tese1-spv15", f"dgc/tess_state_tese_{fk}_l0.tese", "tese", "spirv1.5"),
                ("tese2-spv10", f"dgc/tess_state_tese_{sk}_l1.tese", "tese", None),
                ("tese2-spv15", f"dgc/tess_state_tese_{sk}_l1.tese", "tese", "spirv1.5"),
            ]
            entries = ", ".join(
                f'{{ name = "{name}", template = "{template}", stage = "{stage}"'
                + (f', spirv_version = "{spirv}"' if spirv else "")
                + " }"
                for name, template, stage, spirv in progs
            )
            out.append(
                f"""
[[case]]
name = "{key}"
rust_const = "{key.upper()}"
rust_type = "SharedProgram"
programs = [ {entries} ]
"""
            )
            count += 1
    (SRC_DIR / "tess_state_pcp_vert.vert").write_text(pcp_vert())
    (SRC_DIR / "tess_state_pcp_frag.frag").write_text(pcp_frag())
    for i in range(len(PCP_COLORS)):
        (SRC_DIR / f"tess_state_pcp_tesc{i}.tesc").write_text(pcp_tesc(i))
        (SRC_DIR / f"tess_state_pcp_tese{i}.tese").write_text(pcp_tese(i))
    for use_ies, color_count in ((False, 1), (True, len(PCP_COLORS))):
        key = f"tess_state_pcp_{'ies' if use_ies else 'noies'}"
        progs = [
            ("vert", "dgc/tess_state_pcp_vert.vert", "vert"),
            ("frag", "dgc/tess_state_pcp_frag.frag", "frag"),
        ]
        for i in range(color_count):
            progs.append((f"tesc{i}", f"dgc/tess_state_pcp_tesc{i}.tesc", "tesc"))
            progs.append((f"tese{i}", f"dgc/tess_state_pcp_tese{i}.tese", "tese"))
        entries = ", ".join(f'{{ name = "{n}", template = "{t}", stage = "{st}" }}' for n, t, st in progs)
        out.append(
            f"""
[[case]]
name = "{key}"
rust_const = "{key.upper()}"
rust_type = "SharedProgram"
programs = [ {entries} ]
"""
        )
        count += 1
    MANIFEST.write_text("".join(out))
    print(f"wrote {MANIFEST} ({count} cases)")


if __name__ == "__main__":
    main()

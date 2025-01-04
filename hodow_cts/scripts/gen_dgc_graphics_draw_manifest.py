#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.dgc.ext.graphics.draw (`DGCDrawCase::initPrograms` and `basicGraphicsPrograms` of
vktDGCGraphicsDrawTestsExt.cpp). A pure text generator: no glslang and no cargo.

A shader set depends on: extra stages (none / tess / geom), checkDrawParams, useExecutionSet and, only with an execution set, on how many
triangles the flipping vertex shader flips (1 for TestType::DRAW, 2 for the others)."""

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "shaders" / "manifest" / "dgc_graphics_draw.toml"
SRC_DIR = ROOT / "shaders" / "src" / "dgc"

PER_TRIANGLE_VERTICES = 3
NORMAL_RED_OFFSET = "0.125"
FLIP_RED_OFFSET = "0.25"


def vert_normal(check):
    return (
        "#version 460\n"
        "out gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        "};\n"
        "layout (location=0) in vec4 inPos;\n"
        "layout (location=0) out flat int instanceIndex;\n"
        "layout (location=1) out flat float redOffset;\n"
        + ("layout (location=3) out flat int drawIndex;\n" if check else "")
        + ("layout (location=4) out flat int baseVertex;\n" if check else "")
        + ("layout (location=5) out flat int baseInstance;\n" if check else "")
        + "void main (void) {\n"
        "    gl_Position = inPos;\n"
        "    instanceIndex = gl_InstanceIndex;\n"
        f"    redOffset = {NORMAL_RED_OFFSET};\n"
        + ("    drawIndex = gl_DrawID;\n" if check else "")
        + ("    baseVertex = gl_BaseVertex;\n" if check else "")
        + ("    baseInstance = gl_BaseInstance;\n" if check else "")
        + "}\n"
    )


def vert_flip(check, pass_flip_factor_down, flipped_triangles):
    flipped_vertex_indices = flipped_triangles * PER_TRIANGLE_VERTICES
    return (
        "#version 460\n"
        "out gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        "};\n"
        "layout (location=0) in vec4 inPos;\n"
        "layout (location=0) out flat int instanceIndex;\n"
        "layout (location=1) out flat float redOffset;\n"
        + ("layout (location=2) out flat float xCoordFactor;\n" if pass_flip_factor_down else "")
        + ("layout (location=3) out flat int drawIndex;\n" if check else "")
        + ("layout (location=4) out flat int baseVertex;\n" if check else "")
        + ("layout (location=5) out flat int baseInstance;\n" if check else "")
        + "void main (void) {\n"
        f"    const bool passFlipFactorDown = {'true' if pass_flip_factor_down else 'false'};\n"
        f"    const bool flippedTriangle = (gl_VertexIndex < {flipped_vertex_indices});\n"
        + ("    xCoordFactor = (flippedTriangle ? -1.0 : 1.0);\n" if pass_flip_factor_down else "")
        + ("    drawIndex = gl_DrawID;\n" if check else "")
        + ("    baseVertex = gl_BaseVertex;\n" if check else "")
        + ("    baseInstance = gl_BaseInstance;\n" if check else "")
        + "    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);\n"
        "    gl_Position = vec4(xCoord, inPos.yzw);\n"
        "    instanceIndex = gl_InstanceIndex;\n"
        f"    redOffset = {FLIP_RED_OFFSET};\n"
        "}\n"
    )


def frag(check, blue):
    return (
        "#version 460\n"
        "layout (push_constant, std430) uniform PushConstantBlock {\n"
        "    float redValue;\n"
        + ("    int drawIndex;\n" if check else "")
        + ("    int baseVertex;\n" if check else "")
        + ("    int baseInstance;\n" if check else "")
        + "} pc;\n"
        "layout (location=0) in flat int instanceIndex;\n"
        "layout (location=1) in flat float redOffset;\n"
        + ("layout (location=3) in flat int drawIndex;\n" if check else "")
        + ("layout (location=4) in flat int baseVertex;\n" if check else "")
        + ("layout (location=5) in flat int baseInstance;\n" if check else "")
        + "layout (location=0) out vec4 outColor;\n"
        "void main (void) {\n"
        "    bool drawParamsOK = true;\n"
        + ("    drawParamsOK = (drawParamsOK && (drawIndex == pc.drawIndex));\n" if check else "")
        + ("    drawParamsOK = (drawParamsOK && (baseVertex == pc.baseVertex));\n" if check else "")
        + ("    drawParamsOK = (drawParamsOK && (baseInstance == pc.baseInstance));\n" if check else "")
        + "    const float alphaValue = (drawParamsOK ? 1.0 : 0.0);\n"
        f"    outColor = vec4(pc.redValue + redOffset, float(instanceIndex), {blue}, alphaValue);\n"
        "}\n"
    )


def geom(check, flip):
    return (
        "#version 460\n"
        "layout (triangles) in;\n"
        "layout (triangle_strip, max_vertices=3) out;\n"
        "in gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        "} gl_in[3];\n"
        "out gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        "};\n"
        "layout (location=0) in int inInstanceIndex[3];\n"
        "layout (location=1) in float inRedOffset[3];\n"
        + ("layout (location=3) in int inDrawIndex[3];\n" if check else "")
        + ("layout (location=4) in int inBaseVertex[3];\n" if check else "")
        + ("layout (location=5) in int inBaseInstance[3];\n" if check else "")
        + "layout (location=0) out flat int outInstanceIndex;\n"
        "layout (location=1) out flat float outRedOffset;\n"
        + ("layout (location=3) out flat int outDrawIndex;\n" if check else "")
        + ("layout (location=4) out flat int outBaseVertex;\n" if check else "")
        + ("layout (location=5) out flat int outBaseInstance;\n" if check else "")
        + ("layout (location=2) in float inXCoordFactor[3];\n" if flip else "")
        + "void main() {\n"
        "    for (int i = 0; i < 3; ++i) {\n"
        f"        const float xCoordFactor = {'inXCoordFactor[i]' if flip else '1.0'};\n"
        "        gl_Position = vec4(gl_in[i].gl_Position.x * xCoordFactor, gl_in[i].gl_Position.yzw);\n"
        "        outInstanceIndex = inInstanceIndex[i];\n"
        "        outRedOffset = inRedOffset[i];\n"
        + ("        outDrawIndex = inDrawIndex[i];\n" if check else "")
        + ("        outBaseVertex = inBaseVertex[i];\n" if check else "")
        + ("        outBaseInstance = inBaseInstance[i];\n" if check else "")
        + "        EmitVertex();\n"
        "    }\n"
        "}\n"
    )


def tesc(check, flip):
    return (
        "#version 460\n"
        "layout (vertices=3) out;\n"
        "in gl_PerVertex\n"
        "{\n"
        "    vec4  gl_Position;\n"
        "} gl_in[gl_MaxPatchVertices];\n"
        "out gl_PerVertex\n"
        "{\n"
        "    vec4  gl_Position;\n"
        "} gl_out[];\n"
        "layout (location=0) in int inInstanceIndex[gl_MaxPatchVertices];\n"
        "layout (location=1) in float inRedOffset[gl_MaxPatchVertices];\n"
        + ("layout (location=3) in int inDrawIndex[gl_MaxPatchVertices];\n" if check else "")
        + ("layout (location=4) in int inBaseVertex[gl_MaxPatchVertices];\n" if check else "")
        + ("layout (location=5) in int inBaseInstance[gl_MaxPatchVertices];\n" if check else "")
        + "layout (location=0) out int outInstanceIndex[];\n"
        "layout (location=1) out float outRedOffset[];\n"
        + ("layout (location=3) out int outDrawIndex[];\n" if check else "")
        + ("layout (location=4) out int outBaseVertex[];\n" if check else "")
        + ("layout (location=5) out int outBaseInstance[];\n" if check else "")
        + ("layout (location=2) in float inXCoordFactor[gl_MaxPatchVertices];\n" if flip else "")
        + "void main (void)\n"
        "{\n"
        f"    const float xCoordFactor = {'inXCoordFactor[gl_InvocationID]' if flip else '1.0'};\n"
        "    gl_TessLevelInner[0] = 1.0;\n"
        "    gl_TessLevelInner[1] = 1.0;\n"
        "    gl_TessLevelOuter[0] = 1.0;\n"
        "    gl_TessLevelOuter[1] = 1.0;\n"
        "    gl_TessLevelOuter[2] = 1.0;\n"
        "    gl_TessLevelOuter[3] = 1.0;\n"
        "    gl_out[gl_InvocationID].gl_Position = vec4(gl_in[gl_InvocationID].gl_Position.x * xCoordFactor, gl_in[gl_InvocationID].gl_Position.yzw);\n"
        "    outInstanceIndex[gl_InvocationID] = inInstanceIndex[gl_InvocationID];\n"
        "    outRedOffset[gl_InvocationID] = inRedOffset[gl_InvocationID];\n"
        + ("    outDrawIndex[gl_InvocationID] = inDrawIndex[gl_InvocationID];\n" if check else "")
        + ("    outBaseVertex[gl_InvocationID] = inBaseVertex[gl_InvocationID];\n" if check else "")
        + ("    outBaseInstance[gl_InvocationID] = inBaseInstance[gl_InvocationID];\n" if check else "")
        + "}\n"
    )


def tese(check):
    return (
        "#version 460\n"
        "layout (triangles, fractional_odd_spacing, cw) in;\n"
        "in gl_PerVertex\n"
        "{\n"
        "  vec4 gl_Position;\n"
        "} gl_in[gl_MaxPatchVertices];\n"
        "out gl_PerVertex\n"
        "{\n"
        "  vec4 gl_Position;\n"
        "};\n"
        "layout (location=0) in int inInstanceIndex[];\n"
        "layout (location=1) in float inRedOffset[];\n"
        + ("layout (location=3) in int inDrawIndex[];\n" if check else "")
        + ("layout (location=4) in int inBaseVertex[];\n" if check else "")
        + ("layout (location=5) in int inBaseInstance[];\n" if check else "")
        + "layout (location=0) out flat int outInstanceIndex;\n"
        "layout (location=1) out flat float outRedOffset;\n"
        + ("layout (location=3) out flat int outDrawIndex;\n" if check else "")
        + ("layout (location=4) out flat int outBaseVertex;\n" if check else "")
        + ("layout (location=5) out flat int outBaseInstance;\n" if check else "")
        + "void main (void)\n"
        "{\n"
        "    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +\n"
        "                  (gl_TessCoord.y * gl_in[1].gl_Position) +\n"
        "                  (gl_TessCoord.z * gl_in[2].gl_Position);\n"
        "    outInstanceIndex = inInstanceIndex[0];\n"
        "    outRedOffset = inRedOffset[0];\n"
        + ("    outDrawIndex = inDrawIndex[0];\n" if check else "")
        + ("    outBaseVertex = inBaseVertex[0];\n" if check else "")
        + ("    outBaseInstance = inBaseInstance[0];\n" if check else "")
        + "}\n"
    )


def basic_vert(pc_token):
    return (
        "#version 460\n"
        "layout (location=0) in vec4 inPos;\n"
        + ("layout (push_constant, std430) uniform PCBlock { layout(offset=16) float ptSize; } pc;\n" if pc_token else "")
        + "void main (void) {\n"
        "    gl_Position = inPos;\n"
        f"    const float pointSize = {'pc.ptSize' if pc_token else '1.0'};\n"
        "    gl_PointSize = pointSize;\n"
        "}\n"
    )


BASIC_FRAG = (
    "#version 460\n"
    "layout (push_constant, std430) uniform PCBlock { vec4 color; } pc;\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main (void) {\n"
    "    outColor = pc.color;\n"
    "}\n"
)

EXTRA = ["none", "tess", "geom"]


def key_of(extra, check, exec_set, flipped):
    return f"draw_{extra}_{'dp' if check else 'nodp'}_{'es' + str(flipped) if exec_set else 'noes'}"


def programs_of(extra, check, exec_set, flipped):
    progs = [("vert_normal", "vert", vert_normal(check))]
    pass_down = exec_set and extra != "none"
    if exec_set:
        progs.append(("vert_flip", "vert", vert_flip(check, pass_down, flipped)))
    progs.append(("frag_normal", "frag", frag(check, "0")))
    if exec_set:
        progs.append(("frag_alt", "frag", frag(check, "1")))
    if extra == "geom":
        progs.append(("geom_normal", "geom", geom(check, False)))
        if exec_set:
            progs.append(("geom_flip", "geom", geom(check, True)))
    if extra == "tess":
        progs.append(("tesc_normal", "tesc", tesc(check, False)))
        if exec_set:
            progs.append(("tesc_flip", "tesc", tesc(check, True)))
        progs.append(("tese", "tese", tese(check)))
    return progs


HEADER = """# Shader manifest for dEQP-VK.dgc.ext.graphics.draw
#
# @generated by hodow_cts/scripts/gen_dgc_graphics_draw_manifest.py - do not hand-edit.

upstream_source = "external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsDrawTestsExt.cpp"
rust_module = "dgc/graphics_draw_tests"
"""


def case(key, files):
    progs = ", ".join(
        f'{{ name = "{name}", template = "dgc/{key}_{name}.{stage}", stage = "{stage}" }}' for name, stage, _ in files
    )
    return f"""
[[case]]
name = "{key}"
rust_const = "{key.upper()}"
rust_type = "SharedProgram"
programs = [ {progs} ]
"""


def main():
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    out = [HEADER]
    seen = set()
    for extra in EXTRA:
        for check in (False, True):
            for exec_set, flipped in ((False, 0), (True, 1), (True, 2)):
                key = key_of(extra, check, exec_set, flipped)
                if key in seen:
                    continue
                seen.add(key)
                files = programs_of(extra, check, exec_set, flipped)
                for name, stage, text in files:
                    (SRC_DIR / f"{key}_{name}.{stage}").write_text(text)
                out.append(case(key, files))
    for pc_token in (False, True):
        key = f"draw_basic_{'pc' if pc_token else 'nopc'}"
        files = [("vert", "vert", basic_vert(pc_token)), ("frag", "frag", BASIC_FRAG)]
        for name, stage, text in files:
            (SRC_DIR / f"{key}_{name}.{stage}").write_text(text)
        out.append(case(key, files))
    MANIFEST.write_text("".join(out))
    print(f"wrote {MANIFEST} ({len(seen) + 2} cases)")


if __name__ == "__main__":
    main()

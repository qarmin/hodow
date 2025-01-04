#!/usr/bin/env python3
"""Writes the GLSL variants of dEQP-VK.geometry.* and their manifests.

`vktGeometryInstancedRenderingTests.cpp` bakes the number of geometry shader invocations into the geometry shader text,
so each of the six invocation counts is its own program set. The vertex and fragment shaders are shared.

The `GeometryExpanderRenderTestInstance` groups (`input`, `varying`, `emit`, `basic`) build their geometry shaders from
the test specification with string concatenation: `geometry_expander.toml` lists one program set per test, named
`<group>__<subgroup>__<case>` (`input__basic_primitive__points`) and found in `ALL_SHARED_PROGRAM` by that name. This
also copies the reference PNGs those tests compare against from the upstream checkout into `data/geometry/` and writes
`src/vkt/tests/geometry/reference_images.rs`, the table that embeds them.

Run from hodow_cts/:  python3 scripts/gen_geometry_programs.py   (then `just cts-shaders`)
"""
from pathlib import Path

import shutil

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "geometry"
MANIFEST = ROOT / "shaders" / "manifest" / "geometry_instanced.toml"
EXPANDER_MANIFEST = ROOT / "shaders" / "manifest" / "geometry_expander.toml"
UPSTREAM_IMAGES = ROOT.parent / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "data" / "vulkan" / "data" / "geometry"
IMAGES = ROOT / "data" / "geometry"
IMAGES_RS = ROOT / "src" / "vkt" / "tests" / "geometry" / "reference_images.rs"

INVOCATIONS = [1, 2, 8, 32, 64, 127]

VERT = """#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
"""

FRAG = """#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = in_color;
}
"""


def geom(n):
    modifier = f"float(gl_InvocationID) / float({n - 1})" if n > 1 else "0.0"
    return (
        "#version 450\n\n"
        f"layout(points, invocations = {n}) in;\n"
        "layout(triangle_strip, max_vertices = 4) out;\n\n"
        "layout(location = 0) out vec4 out_color;\n\n"
        "in gl_PerVertex {\n    vec4 gl_Position;\n} gl_in[];\n\n"
        "out gl_PerVertex {\n    vec4 gl_Position;\n};\n\n"
        "void main(void)\n{\n"
        "    const vec4  pos       = gl_in[0].gl_Position;\n"
        f"    const float modifier  = {modifier};\n"
        "    const vec4  color     = vec4(abs(pos.x), abs(pos.y), 0.2 + 0.8 * modifier, 1.0);\n"
        "    const float size      = 0.05 + 0.03 * modifier;\n"
        f"    const float dx        = (sign(-pos.x) - pos.x) / float({n});\n"
        "    const vec4  offsetPos = pos + vec4(float(gl_InvocationID) * dx,\n"
        "                                       0.3 * sin(12.0 * modifier),\n"
        "                                       0.0,\n"
        "                                       0.0);\n\n"
        "    gl_Position = offsetPos + vec4(-size, -size, 0.0, 0.0);\n"
        "    out_color   = color;\n"
        "    EmitVertex();\n\n"
        "    gl_Position = offsetPos + vec4(-size,  size, 0.0, 0.0);\n"
        "    out_color   = color;\n"
        "    EmitVertex();\n\n"
        "    gl_Position = offsetPos + vec4( size, -size, 0.0, 0.0);\n"
        "    out_color   = color;\n"
        "    EmitVertex();\n\n"
        "    gl_Position = offsetPos + vec4( size,  size, 0.0, 0.0);\n"
        "    out_color   = color;\n"
        "    EmitVertex();\n"
        "}\n"
    )


# --- the GeometryExpanderRenderTestInstance groups -------------------------------------------------------------------

EXPANDER_VERT = """#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
layout(location = 0) out highp vec4 v_geom_FragColor;
void main (void)
{
    gl_Position = a_position;
    v_geom_FragColor = a_color;
}
"""

INPUT_FRAG = """#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) in highp vec4 v_frag_FragColor;
void main (void)
{
    fragColor = v_frag_FragColor;
}
"""

MEDIUMP_FRAG = """#version 310 es
layout(location = 0) out mediump vec4 fragColor;
layout(location = 0) in highp vec4 v_frag_FragColor;
void main (void)
{
    fragColor = v_frag_FragColor;
}
"""

# input type -> (GL layout name, vertices a geometry shader of it can emit: calcOutputVertices)
INPUT_TYPES = {
    "POINT_LIST": ("points", 1 * 3),
    "LINE_LIST": ("lines", 2 * 3),
    "LINE_STRIP": ("lines", 2 * 3),
    "LINE_LIST_WITH_ADJACENCY": ("lines_adjacency", 4 * 3),
    "LINE_STRIP_WITH_ADJACENCY": ("lines_adjacency", 4 * 3),
    "TRIANGLE_LIST": ("triangles", 3 * 3),
    "TRIANGLE_STRIP": ("triangles", 3 * 3),
    "TRIANGLE_FAN": ("triangles", 3 * 3),
    "TRIANGLE_LIST_WITH_ADJACENCY": ("triangles_adjacency", 6 * 3),
    "TRIANGLE_STRIP_WITH_ADJACENCY": ("triangles_adjacency", 6 * 3),
}
OUTPUT_TYPES = {
    "POINT_LIST": "points",
    "LINE_STRIP": "line_strip",
    "LINE_LIST": "line_strip",
    "TRIANGLE_STRIP": "triangle_strip",
    "TRIANGLE_LIST": "triangle_strip",
}


def input_geometry(input_type, output_type, point_size):
    in_gl, max_vertices = INPUT_TYPES[input_type]
    s = "#version 310 es\n#extension GL_EXT_geometry_shader : require\n"
    if point_size:
        s += "#extension GL_EXT_geometry_point_size : require\n"
    s += (
        f"layout({in_gl}) in;\n"
        f"layout({OUTPUT_TYPES[output_type]}, max_vertices = {max_vertices}) out;\n"
        "layout(location = 0) in highp vec4 v_geom_FragColor[];\n"
        "layout(location = 0) out highp vec4 v_frag_FragColor;\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);\n"
        "    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);\n"
        "    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);\n"
        "    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);\n"
        "\n"
        "    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)\n"
        "    {\n"
    )
    for i in range(3):
        if point_size:
            s += "        gl_PointSize = 1.0;\n"
        s += f"        gl_Position = gl_in[ndx].gl_Position + offset{i} + yoffset;\n"
        s += "        v_frag_FragColor = v_geom_FragColor[ndx];\n"
        s += "        EmitVertex();\n"
        if i < 2:
            s += "\n"
        else:
            s += "        EndPrimitive();\n"
    s += "    }\n}\n"
    return s


def emit_geometry(topology, emit_a, end_a, emit_b, end_b, point_size):
    s = "#version 310 es\n#extension GL_EXT_geometry_shader : require\n"
    if point_size:
        s += "#extension GL_EXT_geometry_point_size : require\n"
    s += (
        "layout(points) in;\n"
        f"layout({OUTPUT_TYPES[topology]}, max_vertices = {emit_a + emit_b + 1}) out;\n"
        "layout(location = 0) in highp vec4 v_geom_FragColor[];\n"
        "layout(location = 0) out highp vec4 v_frag_FragColor;\n"
        "void main (void)\n"
        "{\n"
        "    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);\n"
        "    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);\n"
        "    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);\n"
        "    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);\n"
        "    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);\n"
        "    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);\n"
    )
    for i in range(emit_a):
        if point_size:
            s += "    gl_PointSize = 1.0;\n"
        s += f"    gl_Position = gl_in[0].gl_Position + position{i};\ngl_PrimitiveID = gl_PrimitiveIDIn;\n".replace("\ngl_", "\n    gl_")
        s += "    v_frag_FragColor = v_geom_FragColor[0];\n    EmitVertex();\n\n"
    for _ in range(end_a):
        s += "    EndPrimitive();\n"
    for i in range(emit_b):
        if point_size:
            s += "    gl_PointSize = 1.0;\n"
        s += f"    gl_Position = gl_in[0].gl_Position + position{emit_a + i};\n    gl_PrimitiveID = gl_PrimitiveIDIn;\n"
        s += "    v_frag_FragColor = v_geom_FragColor[0];\n    EmitVertex();\n\n"
    for _ in range(end_b):
        s += "    EndPrimitive();\n"
    s += "}\n"
    return s


def varying_vertex(vertex_outputs):
    s = "#version 310 es\nlayout(location = 0) in highp vec4 a_position;\nlayout(location = 1) in highp vec4 a_color;\n"
    if vertex_outputs == -1:
        s += "void main (void)\n{\n}\n"
    elif vertex_outputs == 0:
        s += "void main (void)\n{\n    gl_Position = a_position;\n}\n"
    else:
        s += (
            "layout(location = 0) out highp vec4 v_geom_0;\n"
            "void main (void)\n{\n    gl_Position = a_position;\n    v_geom_0 = a_color;\n}\n"
        )
    return s


def varying_geometry(vertex_outputs, geometry_outputs):
    s = (
        "#version 310 es\n#extension GL_EXT_geometry_shader : require\n"
        "layout(triangles) in;\nlayout(triangle_strip, max_vertices = 3) out;\n"
    )
    if vertex_outputs == 1:
        s += "layout(location = 0) in highp vec4 v_geom_0[];\n"
    if geometry_outputs >= 1:
        s += "layout(location = 0) out highp vec4 v_frag_0;\n"
    if geometry_outputs == 2:
        s += "layout(location = 1) out highp vec4 v_frag_1;\n"
    s += "void main (void)\n{\n    highp vec4 offset = vec4(-0.2, -0.2, 0.0, 0.0);\n    highp vec4 inputColor;\n\n"
    no_op_positions = ["vec4(0.0, 0.0, 0.0, 1.0)", "vec4(1.0, 0.0, 0.0, 1.0)", "vec4(1.0, 1.0, 0.0, 1.0)"]
    for i in range(3):
        if vertex_outputs == 1:
            s += f"    inputColor = v_geom_0[{i}];\n"
        else:
            s += "    inputColor = vec4(1.0, 0.0, 0.0, 1.0);\n"
        if vertex_outputs == -1:
            s += f"    gl_Position = {no_op_positions[i]} + offset;\n"
        if vertex_outputs >= 0:
            s += f"    gl_Position = gl_in[{i}].gl_Position + offset;\n"
        if geometry_outputs == 1:
            s += "    v_frag_0 = inputColor;\n"
        if geometry_outputs == 2:
            s += "    v_frag_0 = inputColor * 0.5;\n    v_frag_1 = inputColor.yxzw * 0.5;\n"
        s += "    EmitVertex();\n\n"
    s += "    EndPrimitive();\n}\n"
    return s


def varying_fragment(geometry_outputs):
    s = "#version 310 es\nlayout(location = 0) out highp vec4 fragColor;\n"
    if geometry_outputs >= 1:
        s += "layout(location = 0) in highp vec4 v_frag_0;\n"
    if geometry_outputs == 2:
        s += "layout(location = 1) in highp vec4 v_frag_1;\n"
    s += "void main (void)\n{\n"
    if geometry_outputs == 0:
        s += "fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n"
    if geometry_outputs == 1:
        s += "    fragColor = v_frag_0;\n"
    if geometry_outputs == 2:
        s += "    fragColor = v_frag_0 + v_frag_1.yxzw;\n"
    s += "}\n"
    return s


def output_count_geometry(pattern):
    max_vertices = max(pattern[0], pattern[1]) if len(pattern) == 2 else pattern[0]
    s = (
        "#version 310 es\n"
        "#extension GL_EXT_geometry_shader : require\n"
        "#extension GL_OES_texture_storage_multisample_2d_array : require\n"
        "layout(points) in;\n"
        f"layout(triangle_strip, max_vertices = {max_vertices}) out;\n"
        "layout(location = 0) in highp vec4 v_geom_FragColor[];\n"
        "layout(location = 0) out highp vec4 v_frag_FragColor;\n"
        "out gl_PerVertex\n{\n    vec4 gl_Position;\n};\n"
        "void main (void)\n{\n"
        f"    const highp float rowHeight = 2.0 / float({len(pattern)});\n"
        f"    const highp float colWidth = 2.0 / float({max_vertices});\n"
    )
    if len(pattern) == 2:
        s += f"    highp int emitCount = (gl_PrimitiveIDIn == 0) ? ({pattern[0]}) : ({pattern[1]});\n"
    else:
        s += f"    highp int emitCount = {pattern[0]};\n"
    s += (
        "    for (highp int ndx = 0; ndx < emitCount / 2; ndx++)\n"
        "    {\n"
        "        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, 0.0, 0.0, 0.0);\n"
        "        v_frag_FragColor = v_geom_FragColor[0];\n"
        "        EmitVertex();\n"
        "        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, rowHeight, 0.0, 0.0);\n"
        "        v_frag_FragColor = v_geom_FragColor[0];\n"
        "        EmitVertex();\n"
        "    }\n"
        "}\n"
    )
    return s


def vary_vertex(test):
    if test == "attribute" or test == "texture":
        return (
            "#version 310 es\n"
            "layout(location = 0) in highp vec4 a_position;\n"
            "layout(location = 1) in highp vec4 a_emitCount;\n"
            "layout(location = 0) out highp vec4 v_geom_emitCount;\n"
            "void main (void)\n{\n    gl_Position = a_position;\n    v_geom_emitCount = a_emitCount;\n}\n"
        )
    return (
        "#version 310 es\n"
        "layout(location = 0) in highp vec4 a_position;\n"
        "layout(location = 1) in highp vec4 a_vertexNdx;\n"
        "layout(location = 0) out highp vec4 v_geom_vertexNdx;\n"
        "void main (void)\n{\n    gl_Position = a_position;\n    v_geom_vertexNdx = a_vertexNdx;\n}\n"
    )


def vary_geometry(test, instanced):
    s = (
        "#version 310 es\n#extension GL_EXT_geometry_shader : require\n"
        "#extension GL_OES_texture_storage_multisample_2d_array : require\n"
    )
    s += "layout(points, invocations=4) in;\n" if instanced else "layout(points) in;\n"
    base_pos = (
        "gl_in[0].gl_Position + 0.5 * vec4(cos(float(gl_InvocationID)), sin(float(gl_InvocationID)), 0.0, 0.0)"
        if instanced
        else "gl_in[0].gl_Position"
    )
    loop = (
        "    for (mediump int i = 0; i < emitCount / 2; i++)\n"
        "    {\n"
        "        highp float angle = (float(i) + 0.5) / float(emitCount / 2) * 3.142;\n"
        "        gl_Position = basePos + vec4(cos(angle),  sin(angle), 0.0, 0.0) * 0.15;\n"
        "        v_frag_FragColor = color;\n"
        "        EmitVertex();\n"
        "        gl_Position = basePos + vec4(cos(angle), -sin(angle), 0.0, 0.0) * 0.15;\n"
        "        v_frag_FragColor = color;\n"
        "        EmitVertex();\n"
        "    }\n"
        "}\n"
    )
    colors = (
        "    const highp vec4 red = vec4(1.0, 0.0, 0.0, 1.0);\n"
        "    const highp vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n"
        "    const highp vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "    const highp vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n"
        "    const highp vec4 colors[4] = vec4[4](red, green, blue, yellow);\n"
    )
    per_vertex = "out gl_PerVertex\n{\n    vec4 gl_Position;\n};\n"
    if test == "attribute":
        s += (
            "layout(triangle_strip, max_vertices = 128) out;\n"
            "layout(location = 0) in highp vec4 v_geom_emitCount[];\n"
            "layout(location = 0) out highp vec4 v_frag_FragColor;\n"
            + per_vertex
            + "void main (void)\n{\n"
            "    highp vec4 attrEmitCounts = v_geom_emitCount[0];\n"
            f"    mediump int emitCount = int(attrEmitCounts[{'gl_InvocationID' if instanced else '0'}]);\n"
            "    highp vec4 color = vec4((emitCount < 10) ? (0.0) : (1.0), (emitCount > 10) ? (0.0) : (1.0), 1.0, 1.0);\n"
            f"    highp vec4 basePos = {base_pos};\n"
            + loop
        )
    elif test == "uniform":
        s += (
            "layout(triangle_strip, max_vertices = 128) out;\n"
            "layout(location = 0) in highp vec4 v_geom_vertexNdx[];\n"
            "layout(binding = 0) readonly uniform Input {\n"
            "    ivec4 u_emitCount;\n"
            "} emit;\n"
            "layout(location = 0) out highp vec4 v_frag_FragColor;\n"
            + per_vertex
            + "void main (void)\n{\n"
            f"    mediump int primitiveNdx = {'gl_InvocationID' if instanced else 'int(v_geom_vertexNdx[0].x)'};\n"
            "    mediump int emitCount = emit.u_emitCount[primitiveNdx];\n"
            "\n"
            + colors
            + "    highp vec4 color = colors[int(primitiveNdx)];\n"
            "\n"
            f"    highp vec4 basePos = {base_pos};\n"
            + loop
        )
    else:
        s += (
            "layout(triangle_strip, max_vertices = 128) out;\n"
            "layout(location = 0) in highp vec4 v_geom_vertexNdx[];\n"
            "layout(binding = 0) uniform highp sampler2D u_sampler;\n"
            "layout(location = 0) out highp vec4 v_frag_FragColor;\n"
            + per_vertex
            + "void main (void)\n{\n"
            f"    highp float primitiveNdx = {'float(gl_InvocationID)' if instanced else 'v_geom_vertexNdx[0].x'};\n"
            "    highp vec2 texCoord = vec2(1.0 / 8.0 + primitiveNdx / 4.0, 0.5);\n"
            "    highp vec4 texColor = texture(u_sampler, texCoord);\n"
            "    mediump int emitCount = 0;\n"
            "    if (texColor.x > 0.0)\n"
            "        emitCount += 6;\n"
            "    if (texColor.y > 0.0)\n"
            "        emitCount += 0;\n"
            "    if (texColor.z > 0.0)\n"
            "        emitCount += 128;\n"
            "    if (texColor.w > 0.0)\n"
            "        emitCount += 10;\n"
            + colors
            + "    highp vec4 color = colors[int(primitiveNdx)];\n"
            f"    highp vec4 basePos = {base_pos};\n"
            + loop
        )
    return s


SIDE_VERT = (
    "#version 460\n"
    "out gl_PerVertex {\n    vec4 gl_Position;\n};\n"
    "layout (location=0) in vec4 inPos;\n"
    "void main(void) {\n    gl_Position = inPos;\n}\n"
)
SIDE_FRAG = (
    "#version 460\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main(void) {\n    outColor = vec4(0.0, 0.0, 1.0, 1.0);\n}\n"
)


def side_effect_geometry(case):
    s = (
        "#version 460\n"
        "layout (triangles) in;\n"
        "layout (triangle_strip, max_vertices=3) out;\n"
        "in gl_PerVertex {\n    vec4 gl_Position;\n} gl_in[3];\n"
        "out gl_PerVertex {\n    vec4 gl_Position;\n};\n"
        "layout (set=0, binding=0, std430) buffer SSBO_Block {\n    uint condition;\n    uint value;\n} ssbo;\n"
        "void main() {\n"
    )
    if case == "condition":
        s += (
            "    ssbo.value = 777u;\n"
            "    if (ssbo.condition != 0u) {\n"
            "        for (uint i = 0; i < 3; ++i) {\n"
            "            gl_Position = gl_in[i].gl_Position;\n"
            "            EmitVertex();\n"
            "        }\n"
            "        EndPrimitive();\n"
            "    }\n"
        )
    else:
        s += (
            "    ssbo.value = 777u;\n"
            "    gl_Position = gl_in[0].gl_Position;\n"
            "    EmitVertex();\n"
            "    gl_Position = gl_in[1].gl_Position;\n"
            "    EmitVertex();\n"
            "    EndPrimitive();\n"
        )
    return s + "}\n"


BUILTIN_VERT_HEAD = (
    "#version 450\n"
    "out gl_PerVertex\n"
    " {\n"
    "    vec4 gl_Position;\n"
    "    float gl_PointSize;\n"
    "};\n"
    "layout(location = 0) in vec4 a_position;\n"
)
BUILTIN_GEOM_HEAD = (
    "#version 450\n"
    "in gl_PerVertex\n"
    "{\n"
    "    vec4 gl_Position;\n"
    "    float gl_PointSize;\n"
    "} gl_in[];\n"
    "out gl_PerVertex\n"
    "{\n"
    "    vec4 gl_Position;\n"
    "    float gl_PointSize;\n"
    "};\n"
)
BUILTIN_COLORS = (
    "    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);\n"
    "    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n"
    "    const vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);\n"
    "    const vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n"
)


def add_builtin_variable(add):
    passthrough_frag = (
        "#version 450\n"
        "layout(location = 0) out vec4 fragColor;\n"
        "layout(location = 0) in vec4 v_frag_FragColor;\n"
        "void main (void)\n"
        "{\n"
        "    fragColor = v_frag_FragColor;\n"
        "}\n"
    )
    add(
        "builtin_variable__point_size",
        [
            (
                "vertex",
                "builtin_point_size.vert",
                BUILTIN_VERT_HEAD
                + "layout(location = 1) in vec4 a_pointSize;\n"
                "layout(location = 0) out vec4 v_geom_pointSize;\n"
                "void main (void)\n{\n    gl_Position = a_position;\n    gl_PointSize = 1.0;\n    v_geom_pointSize = a_pointSize;\n}\n",
                "vert",
            ),
            (
                "geometry",
                "builtin_point_size.geom",
                BUILTIN_GEOM_HEAD
                + "#extension GL_EXT_geometry_point_size : require\n"
                "layout(points) in;\n"
                "layout(points, max_vertices = 1) out;\n"
                "layout(location = 0) in vec4 v_geom_pointSize[];\n"
                "layout(location = 0) out vec4 v_frag_FragColor;\n"
                "void main (void)\n"
                "{\n"
                "    gl_Position = gl_in[0].gl_Position;\n"
                "    gl_PointSize = v_geom_pointSize[0].x + 1.0;\n"
                "    v_frag_FragColor = vec4(1.0, 1.0, 1.0, 1.0);\n"
                "    EmitVertex();\n"
                "}\n",
                "geom",
            ),
            ("fragment", "builtin_passthrough.frag", passthrough_frag, "frag"),
        ],
    )
    primitive_id_in = [
        (
            "vertex",
            "builtin_primitive_id_in.vert",
            BUILTIN_VERT_HEAD + "void main (void)\n{\n    gl_Position = a_position;\n}\n",
            "vert",
        ),
        (
            "geometry",
            "builtin_primitive_id_in.geom",
            BUILTIN_GEOM_HEAD
            + "layout(lines) in;\n"
            "layout(triangle_strip, max_vertices = 10) out;\n"
            "layout(location = 0) out vec4 v_frag_FragColor;\n"
            "void main (void)\n"
            "{\n"
            + BUILTIN_COLORS
            + "    const vec4 colors[4] = vec4[4](red, green, blue, yellow);\n"
            "    for (int counter = 0; counter < 3; ++counter)\n"
            "    {\n"
            "        float percent = 0.1 * counter;\n"
            "        gl_Position = gl_in[0].gl_Position * vec4(1.0 + percent, 1.0 + percent, 1.0, 1.0);\n"
            "        v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];\n"
            "        EmitVertex();\n"
            "        gl_Position = gl_in[1].gl_Position * vec4(1.0 + percent, 1.0 + percent, 1.0, 1.0);\n"
            "        v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];\n"
            "        EmitVertex();\n"
            "    }\n"
            "}\n",
            "geom",
        ),
        ("fragment", "builtin_passthrough.frag", passthrough_frag, "frag"),
    ]
    add("builtin_variable__primitive_id_in", primitive_id_in)
    add("builtin_variable__primitive_id_in_restarted", primitive_id_in)
    add(
        "builtin_variable__primitive_id",
        [
            (
                "vertex",
                "builtin_primitive_id.vert",
                BUILTIN_VERT_HEAD
                + "layout(location = 1) in vec4 a_primitiveID;\n"
                "layout(location = 0) out vec4 v_geom_primitiveID;\n"
                "void main (void)\n{\n    gl_Position = a_position;\n    v_geom_primitiveID = a_primitiveID;\n}\n",
                "vert",
            ),
            (
                "geometry",
                "builtin_primitive_id.geom",
                BUILTIN_GEOM_HEAD
                + "layout(points, invocations=1) in;\n"
                "layout(triangle_strip, max_vertices = 3) out;\n"
                "layout(location = 0) in vec4 v_geom_primitiveID[];\n"
                "void main (void)\n"
                "{\n"
                "    gl_Position = gl_in[0].gl_Position + vec4(0.05, 0.0, 0.0, 0.0);\n"
                "    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;\n"
                "    EmitVertex();\n"
                "    gl_Position = gl_in[0].gl_Position - vec4(0.05, 0.0, 0.0, 0.0);\n"
                "    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;\n"
                "    EmitVertex();\n"
                "    gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.05, 0.0, 0.0);\n"
                "    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;\n"
                "    EmitVertex();\n"
                "}\n",
                "geom",
            ),
            (
                "fragment",
                "builtin_primitive_id.frag",
                "#version 450\n"
                "layout(location = 0) out vec4 fragColor;\n"
                "void main (void)\n"
                "{\n"
                + BUILTIN_COLORS
                + "    const vec4 colors[4] = vec4[4](yellow, red, green, blue);\n"
                "    fragColor = colors[gl_PrimitiveID % 4];\n"
                "}\n",
                "frag",
            ),
        ],
    )

    # outside_block.position: a vertex shader writing the position twice and an HLSL geometry shader (compiled by glslang -D, stage "hlsl_geom")
    add(
        "builtin_variable__position",
        [
            (
                "vertex",
                "builtin_position.vert",
                BUILTIN_VERT_HEAD
                + "layout(location = 0) out vec4 v_position;\n"
                "void main (void)\n{\n    v_position = a_position;\n    gl_Position = a_position;\n}\n",
                "vert",
            ),
            (
                "geometry",
                "builtin_position.hlsl",
                "struct VSOut\n{\n    float4 Position : SV_POSITION;\n};\n[maxvertexcount(10)]\n"
                "void main(triangle VSOut input[3], inout TriangleStream<VSOut> TriStream)\n{\n    VSOut output;\n"
                "    output.Position = input[0].Position;\n    TriStream.Append(output);\n"
                "    output.Position = input[1].Position;\n    TriStream.Append(output);\n"
                "    output.Position = input[2].Position;\n    TriStream.Append(output);\n}\n",
                "hlsl_geom",
            ),
            (
                "fragment",
                "builtin_position.frag",
                "#version 450\nlayout(location = 0) out vec4 fragColor;\nvoid main (void)\n{\n    fragColor = vec4(1.0, 1.0, 0.0, 1.0);;\n}\n",
                "frag",
            ),
        ],
    )

def write_expander():
    cases = []  # (const, name, [(program name, file, stage)])
    count = [0]

    def add(name, programs):
        const = f"EXPANDER_{count[0]:03d}"
        count[0] += 1
        entries = []
        for pname, fname, text, stage in programs:
            (SRC / fname).write_text(text)
            entries.append((pname, fname, stage))
        cases.append((const, name, entries))

    vert = ("vertex", "expander.vert", EXPANDER_VERT, "vert")
    input_frag = ("fragment", "expander_input.frag", INPUT_FRAG, "frag")
    mediump_frag = ("fragment", "expander_mediump.frag", MEDIUMP_FRAG, "frag")

    # input
    basic_primitives = [
        ("POINT_LIST", "points", "POINT_LIST"),
        ("LINE_LIST", "lines", "LINE_STRIP"),
        ("LINE_STRIP", "line_strip", "LINE_STRIP"),
        ("TRIANGLE_LIST", "triangles", "TRIANGLE_STRIP"),
        ("TRIANGLE_STRIP", "triangle_strip", "TRIANGLE_STRIP"),
        ("TRIANGLE_FAN", "triangle_fan", "TRIANGLE_STRIP"),
        ("LINE_LIST_WITH_ADJACENCY", "lines_adjacency", "LINE_STRIP"),
        ("LINE_STRIP_WITH_ADJACENCY", "line_strip_adjacency", "LINE_STRIP"),
        ("TRIANGLE_LIST_WITH_ADJACENCY", "triangles_adjacency", "TRIANGLE_STRIP"),
    ]
    conversions = [
        ("TRIANGLE_LIST", "triangles_to_points", "POINT_LIST"),
        ("LINE_LIST", "lines_to_points", "POINT_LIST"),
        ("POINT_LIST", "points_to_lines", "LINE_STRIP"),
        ("TRIANGLE_LIST", "triangles_to_lines", "LINE_STRIP"),
        ("POINT_LIST", "points_to_triangles", "TRIANGLE_STRIP"),
        ("LINE_LIST", "lines_to_triangles", "TRIANGLE_STRIP"),
    ]

    def input_programs(tag, input_type, output_type):
        programs = [vert, ("geometry", f"input_{tag}.geom", input_geometry(input_type, output_type, False), "geom")]
        if output_type == "POINT_LIST":
            programs.append(("geometry_pointsize", f"input_{tag}_pointsize.geom", input_geometry(input_type, output_type, True), "geom"))
        programs.append(input_frag)
        return programs

    for input_type, name, output_type in basic_primitives:
        add(f"input__basic_primitive__{name}", input_programs(name, input_type, output_type))
    for vertex_count in range(13):
        add(f"input__triangle_strip_adjacency__vertex_count_{vertex_count}", input_programs("vertex_count", "TRIANGLE_STRIP_WITH_ADJACENCY", "TRIANGLE_STRIP"))
    for input_type, name, output_type in conversions:
        add(f"input__conversion__{name}", input_programs(name, input_type, output_type))

    # varying
    for vertex_outputs, geometry_outputs, name in [
        (-1, 1, "vertex_no_op_geometry_out_1"),
        (0, 1, "vertex_out_0_geometry_out_1"),
        (0, 2, "vertex_out_0_geometry_out_2"),
        (1, 0, "vertex_out_1_geometry_out_0"),
        (1, 2, "vertex_out_1_geometry_out_2"),
    ]:
        add(
            f"varying__{name}",
            [
                ("vertex", f"varying_{name}.vert", varying_vertex(vertex_outputs), "vert"),
                ("geometry", f"varying_{name}.geom", varying_geometry(vertex_outputs, geometry_outputs), "geom"),
                ("fragment", f"varying_{name}.frag", varying_fragment(geometry_outputs), "frag"),
            ],
        )

    # emit
    emit_tests = [
        ("POINT_LIST", 0, 0, 0, 0, "points"),
        ("POINT_LIST", 0, 1, 0, 0, "points"),
        ("POINT_LIST", 1, 1, 0, 0, "points"),
        ("POINT_LIST", 0, 2, 0, 0, "points"),
        ("POINT_LIST", 1, 2, 0, 0, "points"),
        ("LINE_STRIP", 0, 0, 0, 0, "line_strip"),
        ("LINE_STRIP", 0, 1, 0, 0, "line_strip"),
        ("LINE_STRIP", 1, 1, 0, 0, "line_strip"),
        ("LINE_STRIP", 2, 1, 0, 0, "line_strip"),
        ("LINE_STRIP", 0, 2, 0, 0, "line_strip"),
        ("LINE_STRIP", 1, 2, 0, 0, "line_strip"),
        ("LINE_STRIP", 2, 2, 0, 0, "line_strip"),
        ("LINE_STRIP", 2, 2, 2, 0, "line_strip"),
        ("TRIANGLE_STRIP", 0, 0, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 0, 1, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 1, 1, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 2, 1, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 3, 1, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 0, 2, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 1, 2, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 2, 2, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 3, 2, 0, 0, "triangle_strip"),
        ("TRIANGLE_STRIP", 3, 2, 3, 0, "triangle_strip"),
    ]
    for topology, emit_a, end_a, emit_b, end_b, base in emit_tests:
        name = f"{base}_emit_{emit_a}_end_{end_a}"
        if emit_b:
            name += f"_emit_{emit_b}_end_{end_b}"
        programs = [vert, ("geometry", f"emit_{name}.geom", emit_geometry(topology, emit_a, end_a, emit_b, end_b, False), "geom")]
        if topology == "POINT_LIST":
            programs.append(("geometry_pointsize", f"emit_{name}_pointsize.geom", emit_geometry(topology, emit_a, end_a, emit_b, end_b, True), "geom"))
        programs.append(mediump_frag)
        add(f"emit__{name}", programs)

    # basic
    for name, pattern in [
        ("output_10", [10]),
        ("output_128", [128]),
        ("output_10_and_100", [10, 100]),
        ("output_100_and_10", [100, 10]),
        ("output_0_and_128", [0, 128]),
        ("output_128_and_0", [128, 0]),
    ]:
        add(f"basic__{name}", [vert, ("geometry", f"basic_{name}.geom", output_count_geometry(pattern), "geom"), mediump_frag])
    for test in ("attribute", "uniform", "texture"):
        for instanced in (False, True):
            name = f"output_vary_by_{test}" + ("_instancing" if instanced else "")
            add(
                f"basic__{name}",
                [
                    ("vertex", f"basic_vary_{test}.vert", vary_vertex(test), "vert"),
                    ("geometry", f"basic_{name}.geom", vary_geometry(test, instanced), "geom"),
                    mediump_frag,
                ],
            )
    for case in ("condition", "degenerate"):
        add(
            f"basic__side_effect_with_{case}",
            [
                ("vert", "side_effect.vert", SIDE_VERT, "vert"),
                ("geom", f"side_effect_{case}.geom", side_effect_geometry(case), "geom"),
                ("frag", "side_effect.frag", SIDE_FRAG, "frag"),
            ],
        )

    # builtin_variable.in_block and outside_block.position (the HLSL geometry shader)
    add_builtin_variable(add)

    lines = [
        "# Shader manifest for dEQP-VK.geometry.{input,varying,emit,basic,builtin_variable}.*",
        "#",
        "# Generated by `scripts/gen_geometry_programs.py`: one program set per test of the groups built on",
        "# `GeometryExpanderRenderTestInstance`, named `<group>__<subgroup>__<case>` and found in ALL_SHARED_PROGRAM by that name.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/geometry/vktGeometryBasicGeometryShaderTests.cpp"',
        'rust_module = "geometry/expander"',
        "",
    ]
    for const, name, progs in cases:
        lines += ["[[case]]", f'name = "{name}"', f'rust_const = "{const}"', 'rust_type = "SharedProgram"', "programs = ["]
        for pname, fname, stage in progs:
            lines.append(f'    {{ name = "{pname}", template = "geometry/{fname}", stage = "{stage}" }},')
        lines += ["]", ""]
    EXPANDER_MANIFEST.write_text("\n".join(lines))
    print(f"wrote {len(cases)} expander cases")


def write_images():
    names = []
    if UPSTREAM_IMAGES.is_dir():
        IMAGES.mkdir(parents=True, exist_ok=True)
        for png in sorted(UPSTREAM_IMAGES.glob("*.png")):
            shutil.copyfile(png, IMAGES / png.name)
    for png in sorted(IMAGES.glob("*.png")):
        names.append(png.stem)
    lines = [
        "// SPDX-License-Identifier: Apache-2.0",
        "//",
        "// Generated by `scripts/gen_geometry_programs.py` - do not edit.",
        "//",
        "// The reference images of `dEQP-VK.geometry.*` (upstream: external/vulkancts/data/vulkan/data/geometry/*.png),",
        "// embedded in the binary the way `data/brick.png` is.",
        "",
        "/// The PNG of the reference image of a test, by the name `compareWithFileImage` is given.",
        "pub fn reference_png(name: &str) -> Option<&'static [u8]> {",
        "    match name {",
    ]
    for name in names:
        lines.append(f'        "{name}" => Some(include_bytes!("../../../../data/geometry/{name}.png")),')
    lines += ["        _ => None,", "    }", "}", ""]
    IMAGES_RS.write_text("\n".join(lines))
    print(f"embedded {len(names)} reference images")


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    write_expander()
    write_images()
    (SRC / "instanced.vert").write_text(VERT)
    (SRC / "instanced.frag").write_text(FRAG)
    lines = [
        "# Shader manifest for dEQP-VK.geometry.instanced.*",
        "#",
        "# Generated by `scripts/gen_geometry_programs.py`: one geometry shader per number of invocations, which upstream",
        "# bakes into the shader text.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/geometry/vktGeometryInstancedRenderingTests.cpp"',
        'rust_module = "geometry/instanced_tests"',
        "",
    ]
    for n in INVOCATIONS:
        (SRC / f"instanced_{n}.geom").write_text(geom(n))
        lines += [
            "[[case]]",
            f'name = "invocations_{n}"',
            f'rust_const = "INSTANCED_{n}"',
            'rust_type = "SharedProgram"',
            "programs = [",
            '    { name = "vert", template = "geometry/instanced.vert", stage = "vert" },',
            f'    {{ name = "geom", template = "geometry/instanced_{n}.geom", stage = "geom" }},',
            '    { name = "frag", template = "geometry/instanced.frag", stage = "frag" },',
            "]",
            "",
        ]
    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {len(INVOCATIONS)} cases")


if __name__ == "__main__":
    main()

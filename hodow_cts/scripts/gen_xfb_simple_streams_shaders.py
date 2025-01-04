#!/usr/bin/env python3
"""Generate the shaders of dEQP-VK.transform_feedback.simple.{multiquery,multiquery_omit_write,lines_or_triangles}_* and their manifest.

Upstream builds them in `TransformFeedbackTestCase::initPrograms`, in the `TEST_TYPE_MULTIQUERY` and `TEST_TYPE_LINES_TRIANGLES`
branches. Only the stream, the point size and (multiquery) `omitShaderWrite` reach the sources.

Usage:
    python3 hodow_cts/scripts/gen_xfb_simple_streams_shaders.py
"""

from __future__ import annotations

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_REL = "transform_feedback/simple_streams"
SRC_DIR = CRATE_DIR / "shaders" / "src" / SRC_REL
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "transform_feedback_simple_streams.toml"

STREAMS = (1, 3, 6, 14)
INVOCATION_COUNT = 8
LINES_LIST = (2, 6, 3)
TRIANGLES_LIST = (3, 8, 6, 5, 4)


def multiquery_vertex() -> str:
    return (
        "#version 450\n"
        "\n"
        "layout(location = 0) out ivec4 out0;\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    out0 = ivec4(gl_VertexIndex);\n"
        "}\n"
    )


def multiquery_geometry(stream: int, point_size: bool, omit_write: bool) -> str:
    s = stream
    ps = "        gl_PointSize = 1.0;\n" if point_size else ""
    src = (
        "#version 450\n"
        "\n"
        "layout(points) in;\n"
        "\n"
        "layout(points, max_vertices = 4) out;\n"
        "\n"
        "layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;\n"
        f"layout(stream = {s}, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;\n"
        "\n"
        + ("out gl_PerVertex { float gl_PointSize; };\n\n" if point_size else "")
        + "void main(void)\n"
        "{\n"
        "    const int   n0 = 3;\n"
        "    const int   n1 = 1;\n"
        "    const float c0 = 0.5f;\n"
        f"    const float c1 = 0.5f + float({s});\n"
        "\n"
        "    for (int j = 0; j < n0; j++)\n"
        "    {\n"
    )
    if not omit_write:
        src += "        out0 = vec4(c0);\n"
    src += (
        ps
        + "        EmitStreamVertex(0);\n"
        "        EndStreamPrimitive(0);\n"
        "    }\n"
        "\n"
        "    for (int j = 0; j < n1; j++)\n"
        "    {\n"
        "        out1 = vec4(c1);\n"
        + ps
        + f"        EmitStreamVertex({s});\n"
        f"        EndStreamPrimitive({s});\n"
        "    }\n"
        "}\n"
    )
    return src


def lines_triangles_vertex() -> str:
    return "#version 450\n\nvoid main(void)\n{\n}\n"


def lines_triangles_geometry(line: bool, stream: int, point_size: bool) -> str:
    s = stream
    prim = "line_strip" if line else "triangle_strip"
    vertex_count = ", ".join(str(v) for v in (LINES_LIST if line else TRIANGLES_LIST))
    ps = "            gl_PointSize = 1.0;\n" if point_size else ""
    return (
        "#version 450\n"
        "\n"
        "layout(points) in;\n"
        "\n"
        f"layout({prim}, max_vertices = 256) out;\n"
        "layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;\n"
        f"layout(stream = {s}, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;\n"
        "\n"
        f"const int vertices_in_primitive[] = int[]({vertex_count});\n"
        "\n"
        "int num_vertices_in_primitives()\n"
        "{\n"
        "    int c = 0;\n"
        "\n"
        "    for (int i = 0; i < vertices_in_primitive.length(); i++)\n"
        "        c = c + vertices_in_primitive[i];\n"
        "\n"
        "    return c;\n"
        "}\n"
        "\n"
        + ("out gl_PerVertex { float gl_PointSize; };\n\n" if point_size else "")
        + "void main(void)\n"
        "{\n"
        "    int vc = num_vertices_in_primitives();\n"
        "    int c0 = vc * gl_PrimitiveIDIn;\n"
        f"    int c1 = vc * ({INVOCATION_COUNT} + gl_PrimitiveIDIn);\n"
        "\n"
        "    for (int i = 0; i < vertices_in_primitive.length(); i++)\n"
        "    {\n"
        "        const int n = vertices_in_primitive[i];\n"
        "\n"
        "        for (int j = 0; j < n; j++)\n"
        "        {\n"
        "            out0 = vec4(ivec4(c0, gl_PrimitiveIDIn, i, j));\n"
        "            c0 = c0 + 1;\n"
        + ps
        + "            EmitStreamVertex(0);\n"
        "\n"
        "            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));\n"
        "            c1 = c1 + 1;\n"
        + ps
        + f"            EmitStreamVertex({s});\n"
        "        }\n"
        "\n"
        "        EndStreamPrimitive(0);\n"
        f"        EndStreamPrimitive({s});\n"
        "    }\n"
        "}\n"
    )


def winding_vertex(point_size: bool) -> str:
    return (
        "#version 450\n"
        "\n"
        "layout(push_constant) uniform pushConstants\n"
        "{\n"
        "    uint start;\n"
        "} uInput;\n"
        "\n"
        "layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    idx_out = uInput.start + gl_VertexIndex;\n"
        + ("    gl_PointSize = 1.0;\n" if point_size else "")
        + "}\n"
    )


def patch_vertex() -> str:
    return (
        "#version 450\n"
        "layout(push_constant) uniform pushConstants\n"
        "{\n"
        "    uint start;\n"
        "} uInput;\n"
        "void main(void)\n"
        "{\n"
        "}\n"
    )


def patch_tesc() -> str:
    return (
        "#version 450\n"
        "layout(vertices = 3) out;\n"
        "void main (void)\n"
        "{\n"
        "    gl_TessLevelInner[0] = 2.0;\n"
        "    gl_TessLevelOuter[0] = 1.0;\n"
        "    gl_TessLevelOuter[1] = 1.0;\n"
        "    gl_TessLevelOuter[2] = 1.0;\n"
        "}\n"
    )


def patch_tese(point_size: bool) -> str:
    return (
        "#version 450\n"
        "layout(triangles, ccw) in;\n"
        "layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;\n"
        + ("out gl_PerVertex { float gl_PointSize; };\n" if point_size else "")
        + "\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "    idx_out = gl_PrimitiveID;\n"
        + ("    gl_PointSize = 1.0;\n" if point_size else "")
        + "}\n"
    )


def multistreams_vertex() -> str:
    return "#version 450\n\nvoid main(void)\n{\n}\n"


def multistreams_geometry(stream: int, point_size: bool) -> str:
    s = stream
    ps = "            gl_PointSize = 1.0;\n" if point_size else ""
    return (
        "#version 450\n"
        "\n"
        "layout(points) in;\n"
        "\n"
        "layout(points, max_vertices = 32) out;\n"
        "layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;\n"
        f"layout(stream = {s}, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;\n"
        "\n"
        "const int counts[] = int[](1, 1, 2, 4, 8);\n"
        "\n"
        + ("out gl_PerVertex { float gl_PointSize; };\n\n" if point_size else "")
        + "void main(void)\n"
        "{\n"
        "    int c0 = 0;\n"
        "    int c1 = 0;\n"
        "\n"
        "    // Start 1st buffer from point where 0th buffer ended\n"
        "    for (int i = 0; i < counts.length(); i++)\n"
        "        c1 = c1 + 4 * counts[i];\n"
        "\n"
        "    for (int i = 0; i < counts.length(); i++)\n"
        "    {\n"
        "        const int n0 = counts[i];\n"
        "        const int n1 = counts[counts.length() - 1 - i];\n"
        "\n"
        "        for (int j = 0; j < n0; j++)\n"
        "        {\n"
        "            out0 = vec4(ivec4(c0, c0 + 1, c0 + 2, c0 + 3));\n"
        "            c0 = c0 + 4;\n"
        + ps
        + "            EmitStreamVertex(0);\n"
        "            EndStreamPrimitive(0);\n"
        "        }\n"
        "\n"
        "        for (int j = 0; j < n1; j++)\n"
        "        {\n"
        "            out1 = vec4(ivec4(c1, c1 + 1, c1 + 2, c1 + 3));\n"
        "            c1 = c1 + 4;\n"
        + ps
        + f"            EmitStreamVertex({s});\n"
        f"            EndStreamPrimitive({s});\n"
        "        }\n"
        "    }\n"
        "}\n"
    )


def same_location_vertex() -> str:
    return (
        "#version 450\n"
        "\n"
        "layout(location=0) out uint id;"
        "void main(void)\n"
        "{\n"
        "  id = gl_VertexIndex;"
        "}\n"
    )


def same_location_geometry(stream: int, point_size: bool) -> str:
    s = stream
    ps = "    gl_PointSize = 1.0;\n" if point_size else ""
    return (
        "#version 450\n"
        "\n"
        "layout(points) in;\n"
        "\n"
        "layout(points, max_vertices = 2) out;\n"
        "\n"
        "layout(location=0) in uint id[1];"
        "layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;\n"
        f"layout(stream = {s}, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;\n"
        "\n"
        + ("out gl_PerVertex { float gl_PointSize; };\n\n" if point_size else "")
        + "void main(void)\n"
        "{\n"
        "    out0 = id[0] * 2 + 0;\n"
        + ps
        + "    EmitStreamVertex(0);\n"
        "    EndStreamPrimitive(0);\n"
        "\n"
        "    out1 = id[0] * 2 + 1;\n"
        + ps
        + f"    EmitStreamVertex({s});\n"
        f"    EndStreamPrimitive({s});\n"
        "}\n"
    )


STREAMS_FRAGMENT = (
    "#version 450\n"
    "\n"
    "layout(location = 0) in  vec4 i_color;\n"
    "layout(location = 0) out vec4 o_color;\n"
    "\n"
    "void main(void)\n"
    "{\n"
    "    o_color = i_color;\n"
    "}\n"
)

STREAMS_CONSTANTS = (
    "    // Color constants\n"
    "    vec4 g = vec4(0.0, 1.0, 0.0, 1.0);\n"
    "    vec4 m = vec4(1.0, 0.0, 1.0, 1.0);\n"
    "    // Coordinate constants: leftmost column\n"
    "    vec4 a = vec4(-1.0,-1.0, 0.0, 1.0);\n"
    "    vec4 b = vec4(-1.0, 0.0, 0.0, 1.0);\n"
    "    vec4 c = vec4(-1.0, 1.0, 0.0, 1.0);\n"
    "    // Coordinate constants: middle column\n"
    "    vec4 i = vec4( 0.0,-1.0, 0.0, 1.0);\n"
    "    vec4 j = vec4( 0.0, 0.0, 0.0, 1.0);\n"
    "    vec4 k = vec4( 0.0, 1.0, 0.0, 1.0);\n"
    "    // Coordinate constants: rightmost column\n"
    "    vec4 x = vec4( 1.0,-1.0, 0.0, 1.0);\n"
    "    vec4 y = vec4( 1.0, 0.0, 0.0, 1.0);\n"
    "    vec4 z = vec4( 1.0, 1.0, 0.0, 1.0);\n"
    "\n"
)


def streams_geometry(kind: str, stream: int, point_size: int) -> str:
    """kind: streams, pointsize, clip, cull. `point_size` is the TestParameters value (0, 1 or 2)."""
    s = stream
    wanted = point_size > 0
    point_size_decl = "    float gl_PointSize;\n"
    extra_decl = point_size_decl if wanted else ""
    extra_stmt = f"gl_PointSize = {point_size}.0; " if wanted else ""
    output_primitive = "points" if kind == "pointsize" else "triangle_strip"
    output_builtin = {
        "pointsize": point_size_decl,
        "clip": "    float gl_ClipDistance[];\n" + extra_decl,
        "cull": "    float gl_CullDistance[];\n" + extra_decl,
        "streams": extra_decl,
    }[kind]

    src = (
        "#version 450\n"
        "\n"
        "layout(points) in;\n"
        f"layout({output_primitive}, max_vertices = 16) out;\n"
        f"layout(stream = {s}) out;\n"
        "layout(location = 0) out vec4 color;\n"
        "\n"
        f"layout(stream = {s}) out gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        + output_builtin
        + "};\n"
        "\n"
        "void main(void)\n"
        "{\n"
        + STREAMS_CONSTANTS
    )
    end = f"        EndStreamPrimitive({s});\n"

    def m(position: str, distance: str = "") -> str:
        return f"        color = m; gl_Position = {position}; {distance}{extra_stmt}EmitStreamVertex({s});\n"

    if kind == "streams":
        src += (
            "    if (gl_PrimitiveIDIn == 0)\n    {\n"
            + m("b") + m("y") + m("c") + end
            + "    }\n    else\n    {\n"
            + m("y") + m("c") + m("z") + end
            + "    }\n"
        )
    elif kind == "pointsize":
        pointsize = f"gl_PointSize = {point_size}.0f"
        src += (
            "    if (gl_PrimitiveIDIn == 0)\n    {\n"
            "        color = g; gl_Position = (a + j) / 2.0f; gl_PointSize = 1.0f; EmitStreamVertex(0);\n"
            "        EndStreamPrimitive(0);\n"
            f"        color = m; gl_Position = (b + k) / 2.0f; gl_PointSize = 1.0f; EmitStreamVertex({s});\n"
            f"        EndStreamPrimitive({s});\n"
            "    }\n    else\n    {\n"
            f"        color = g; gl_Position = (j + x) / 2.0f; {pointsize}; EmitStreamVertex(0);\n"
            "        EndStreamPrimitive(0);\n"
            f"        color = m; gl_Position = (k + y) / 2.0f; {pointsize}; EmitStreamVertex({s});\n"
            f"        EndStreamPrimitive({s});\n"
            "    }\n"
        )
    elif kind == "clip":
        d = "gl_ClipDistance[0] = {}; "
        n, p = d.format("-1.0"), d.format(" 1.0")
        src += (
            "    if (gl_PrimitiveIDIn == 0)\n    {\n"
            + m("b", n) + m("c", n) + m("y", p) + end
            + "    }\n    else\n    {\n"
            + m("y", p) + m("c", n) + m("z", p) + end
            + "    }\n"
        )
    else:
        d = "gl_CullDistance[0] = {}; "
        n, p = d.format("-1.0"), d.format(" 1.0")
        src += (
            "    if (gl_PrimitiveIDIn == 0)\n    {\n"
            + m("b", n) + m("c", n) + m("j", n) + end
            + m("j", n) + m("c", n) + m("k", n) + end
            + "    }\n    else\n    {\n"
            + m("j", p) + m("k", p) + m("y", p) + end
            + m("y", p) + m("k", p) + m("z", p) + end
            + "    }\n"
        )
    src += "}\n"
    return src


def indirect_vertex(point_size: bool) -> str:
    return (
        "#version 450\n"
        "\n"
        "layout(location = 0) in vec4 in_position;\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    gl_Position = in_position;\n"
        + ("    gl_PointSize = 1.0;\n" if point_size else "")
        + "}\n"
    )


INDIRECT_FRAGMENT = (
    "#version 450\n"
    "\n"
    "layout(location = 0) out vec4 o_color;\n"
    "\n"
    "void main(void)\n"
    "{\n"
    "    o_color = vec4(1.0, 1.0, 1.0, 1.0);\n"
    "}\n"
)


BACKWARD_VERTEX = (
    "#version 450\n"
    "\n"
    "layout(push_constant, std430) uniform PushConstantBlock\n"
    "{\n"
    "    uint  start;\n"
    "    float width;\n"
    "    float posY;\n"
    "} pc;\n"
    "\n"
    "layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;\n"
    "\n"
    "void main(void)\n"
    "{\n"
    "    idx_out           = pc.start + gl_VertexIndex;\n"
    "    const float posX  = ((float(gl_VertexIndex) + 0.5) / pc.width) * 2.0 - 1.0;\n"
    "    gl_Position       = vec4(posX, pc.posY, 0.0, 1.0);\n"
    "    gl_PointSize      = 1.0;\n"
    "}\n"
)

BACKWARD_FRAGMENT = (
    "#version 450\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main (void) { outColor = vec4(0.0, 0.0, 1.0, 1.0); }\n"
)


BASIC_TRIANGLES_ASM = """
               OpCapability Shader
               OpCapability TransformFeedback
               OpMemoryModel Logical GLSL450
               OpEntryPoint Vertex %main "main" %_
               OpExecutionMode %main Xfb
               OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
               OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
               OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
               OpMemberDecorate %gl_PerVertex 3 BuiltIn CullDistance
               OpDecorate %gl_PerVertex Block
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
       %uint = OpTypeInt 32 0
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
          %_ = OpVariable %_ptr_Output_gl_PerVertex Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
    %float_1 = OpConstant %float 1
         %17 = OpConstantComposite %v4float %float_1 %float_1 %float_1 %float_1
%_ptr_Output_v4float = OpTypePointer Output %v4float
       %main = OpFunction %void None %3
          %5 = OpLabel
         %19 = OpAccessChain %_ptr_Output_v4float %_ %int_0
               OpStore %19 %17
               OpReturn
               OpFunctionEnd
        """


def depth_clip_vertex_vertex(point_size: bool) -> str:
    return (
        "#version 450\n"
        "\n"
        "layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        + ("    float gl_PointSize;\n" if point_size else "")
        + "};\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    gl_Position = vec4(1.0, 1.0, float(gl_VertexIndex) / 3.0 - 1.0, 1.0);\n"
        + ("    gl_PointSize = 1.0;\n" if point_size else "")
        + "}\n"
    )


def depth_clip_plain_vertex() -> str:
    return (
        "#version 450\n"
        "\n"
        "out gl_PerVertex\n"
        "{\n"
        "    vec4  gl_Position;\n"
        "};\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    gl_Position = vec4(1.0, 1.0, float(gl_VertexIndex) / 3.0 - 1.0, 1.0);\n"
        "}\n"
    )


def depth_clip_geometry(point_size: bool) -> str:
    return (
        "#version 450\n"
        "\n"
        "layout(points) in;\n"
        "layout(points, max_vertices = 1) out;\n"
        "layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        + ("    float gl_PointSize;\n" if point_size else "")
        + "};\n"
        "\n"
        "in gl_PerVertex\n"
        "{\n"
        "    vec4  gl_Position;\n"
        "} gl_in[];\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    gl_Position = gl_in[0].gl_Position;\n"
        + ("    gl_PointSize = 1.0;\n" if point_size else "")
        + "    EmitVertex();\n"
        "    EndPrimitive();\n"
        "}\n"
    )


DEPTH_CLIP_TESC = (
    "#version 450\n"
    "layout(vertices = 3) out;\n"
    "in gl_PerVertex\n"
    "{\n"
    "    vec4 gl_Position;\n"
    "} gl_in[gl_MaxPatchVertices];\n"
    "out gl_PerVertex\n"
    "{\n"
    "    vec4 gl_Position;\n"
    "} gl_out[];\n"
    "void main (void)\n"
    "{\n"
    "    gl_TessLevelInner[0] = 0.0;\n"
    "    gl_TessLevelOuter[0] = 1.0;\n"
    "    gl_TessLevelOuter[1] = 1.0;\n"
    "    gl_TessLevelOuter[2] = 1.0;\n"
    "    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
    "}\n"
)


def depth_clip_tese(point_size: bool) -> str:
    return (
        "#version 450\n"
        "layout(triangles, ccw) in;\n"
        "in gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        "} gl_in[gl_MaxPatchVertices];\n"
        "layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        + ("    float gl_PointSize;\n" if point_size else "")
        + "};\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;\n"
        "    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;\n"
        "    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;\n"
        "    gl_Position = p0 + p1 + p2;\n"
        + ("    gl_PointSize = 1.0;\n" if point_size else "")
        + "}\n"
    )


SINGLE_RASTER_VERTEX = (
    "#version 460\n"
    "out gl_PerVertex {\n"
    "    vec4 gl_Position;\n"
    "    float gl_PointSize;\n"
    "};\n"
    "layout (location=0) in vec4 inPos;\n"
    "void main(void) {\n"
    "    gl_Position = inPos;\n"
    "}\n"
)


def single_raster_geometry(non_zero_stream: bool) -> str:
    return (
        "#version 460\n"
        "layout (points) in;\n"
        "layout (points, max_vertices=2) out;\n"
        "in gl_PerVertex {\n"
        "    vec4 gl_Position;\n"
        "    float gl_PointSize;\n"
        "} gl_in[1];\n"
        + ("layout (stream=1) " if non_zero_stream else "")
        + "out gl_PerVertex {\n"
        "    vec4 gl_Position;\n"
        "    float gl_PointSize;\n"
        "};\n"
        "layout (location=0, stream=0, xfb_buffer=0, xfb_offset=0, xfb_stride=16) out vec4 pos0;\n"
        "layout (location=1, stream=1, xfb_buffer=1, xfb_offset=0, xfb_stride=16) out vec4 pos1;\n"
        "void main() {\n"
        "    vec4 inPos0;\n"
        "    vec4 inPos1;\n"
        "\n"
        "    inPos0 = gl_in[0].gl_Position;\n"
        "    inPos1 = vec4(inPos0.x, -inPos0.y, inPos0.z, inPos0.w);\n"
        "    gl_Position = inPos0;\n"
        "    gl_PointSize = 1.0;\n"
        "    pos0 = inPos0;\n"
        "    EmitStreamVertex(0);\n"
        "\n"
        "    inPos0 = gl_in[0].gl_Position;\n"
        "    inPos1 = vec4(inPos0.x, -inPos0.y, inPos0.z, inPos0.w);\n"
        "    gl_Position = inPos1;\n"
        "    gl_PointSize = 1.0;\n"
        "    pos1 = inPos1;\n"
        "    EmitStreamVertex(1);\n"
        "}\n"
    )


def single_raster_fragment(non_zero_stream: bool) -> str:
    return (
        "#version 460\n"
        f"layout (location={1 if non_zero_stream else 0}) in vec4 inPos;\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main(void) {\n"
        "    const vec4 offset = vec4(-100.0);\n"
        "    const vec4 finalColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "    outColor = max(inPos + offset, finalColor);\n"
        "}\n"
    )


def rebind_vertex(buffer_index: int) -> str:
    return (
        "#version 450\n"
        "\n"
        "layout(push_constant) uniform pushConstants\n"
        "{\n"
        "    uint start;\n"
        "} uInput;\n"
        "\n"
        f"layout(xfb_buffer = {buffer_index}, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    idx_out = uInput.start + gl_VertexIndex;\n"
        "}\n"
    )


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for stale in SRC_DIR.glob("*"):
        stale.unlink()

    programs: list[tuple[str, str, str]] = []

    def emit(name: str, stage: str, source: str) -> None:
        (SRC_DIR / f"{name}.{stage}").write_text(source)
        programs.append((name, f"{SRC_REL}/{name}.{stage}", stage))

    emit("multiquery_vert", "vert", multiquery_vertex())
    emit("lines_triangles_vert", "vert", lines_triangles_vertex())
    emit("multistreams_vert", "vert", multistreams_vertex())
    emit("same_location_vert", "vert", same_location_vertex())
    emit("streams_vert", "vert", multistreams_vertex())
    emit("streams_frag", "frag", STREAMS_FRAGMENT)
    for stream in STREAMS:
        for ps in (0, 1):
            emit(f"multistreams_geom_s{stream}_ps{ps}", "geom", multistreams_geometry(stream, bool(ps)))
            emit(f"same_location_geom_s{stream}_ps{ps}", "geom", same_location_geometry(stream, bool(ps)))
            for kind in ("streams", "clip", "cull"):
                emit(f"streams_geom_{kind}_s{stream}_ps{ps}", "geom", streams_geometry(kind, stream, ps))
        emit(f"streams_geom_pointsize_s{stream}_ps2", "geom", streams_geometry("pointsize", stream, 2))
    emit("indirect_frag", "frag", INDIRECT_FRAGMENT)
    for ps in (0, 1):
        emit(f"indirect_vert_ps{ps}", "vert", indirect_vertex(bool(ps)))
    emit("backward_vert", "vert", BACKWARD_VERTEX)
    emit("backward_frag", "frag", BACKWARD_FRAGMENT)
    emit("basic_triangles_vert", "asm", BASIC_TRIANGLES_ASM)
    emit("depth_clip_vertex_vert_ps1", "vert", depth_clip_vertex_vertex(True))
    emit("depth_clip_plain_vert", "vert", depth_clip_plain_vertex())
    emit("depth_clip_tesc", "tesc", DEPTH_CLIP_TESC)
    for ps in (0, 1):
        emit(f"depth_clip_geom_ps{ps}", "geom", depth_clip_geometry(bool(ps)))
        emit(f"depth_clip_tese_ps{ps}", "tese", depth_clip_tese(bool(ps)))
    emit("single_raster_vert", "vert", SINGLE_RASTER_VERTEX)
    for non_zero in (0, 1):
        emit(f"single_raster_geom_s{non_zero}", "geom", single_raster_geometry(bool(non_zero)))
        emit(f"single_raster_frag_s{non_zero}", "frag", single_raster_fragment(bool(non_zero)))
    for buffer_index in range(4):
        emit(f"rebind_vert{buffer_index}", "vert", rebind_vertex(buffer_index))
    emit("winding_patch_vert", "vert", patch_vertex())
    emit("winding_patch_tesc", "tesc", patch_tesc())
    for ps in (0, 1):
        emit(f"winding_vert_ps{ps}", "vert", winding_vertex(bool(ps)))
        emit(f"winding_patch_tese_ps{ps}", "tese", patch_tese(bool(ps)))
    for stream in STREAMS:
        for ps in (0, 1):
            for omit in (False, True):
                emit(f"multiquery_geom_s{stream}_ps{ps}" + ("_omit" if omit else ""), "geom", multiquery_geometry(stream, bool(ps), omit))
            for line in (True, False):
                emit(f"lines_triangles_geom_{'line' if line else 'tri'}_s{stream}_ps{ps}", "geom", lines_triangles_geometry(line, stream, bool(ps)))

    lines = [
        "# Shader manifest for the multiquery, multiquery_omit_write, lines_or_triangles, winding, multistreams, multistreams_same_location, streams*, draw_indirect*, backward_dependency*, basic_triangles, depth_clip_control_*, multi_stream_single_raster* and shader_object_rebind cases of dEQP-VK.transform_feedback.simple.*",
        "#",
        "# Generated by scripts/gen_xfb_simple_streams_shaders.py together with the sources it names; do not hand-edit either.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackSimpleTests.cpp"',
        'rust_module = "transform_feedback/simple_stream_tests"',
        "",
        "[[case]]",
        'name = "streams"',
        'rust_const = "XFB_STREAM_PROGRAMS"',
        'rust_type = "XfbStreamPrograms"',
        "programs = [",
    ]
    for name, template, stage in programs:
        lines.append(f'    {{ name = "{name}", template = "{template}", stage = "{stage}" }},')
    lines += ["]", ""]
    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {len(programs)} shaders in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

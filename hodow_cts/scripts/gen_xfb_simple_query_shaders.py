#!/usr/bin/env python3
"""Generate the shaders of dEQP-VK.transform_feedback.simple.{query,query_omit_write,query_copy,query_copy_stride_zero,host_query_reset}_*
and their manifest.

Upstream builds each shader in `TransformFeedbackTestCase::initPrograms` from the test parameters, in the
`TEST_TYPE_QUERY_GET/COPY/COPY_STRIDE_ZERO/RESET` branch. Only the topology, the stream, the point size and
`omitShaderWrite` reach the sources, so the ~7000 cases collapse to:

  vert      - with or without gl_PointSize
  geom      - stream 0: plain GLSL (omit write or not); stream != 0: GLSL, except `query` (TEST_TYPE_QUERY_GET)
              which upstream spells as hand-tuned SPIR-V assembly so the Stream/XfbBuffer/XfbStride decorations
              sit on the struct member

Usage:
    python3 hodow_cts/scripts/gen_xfb_simple_query_shaders.py
"""

from __future__ import annotations

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_REL = "transform_feedback/simple_query"
SRC_DIR = CRATE_DIR / "shaders" / "src" / SRC_REL
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "transform_feedback_simple_query.toml"

# name: (primSize, glslIn, glslOut, spirvIn, spirvOut) - `topologyData` and `primitiveNames` of initPrograms
TOPOLOGIES = {
    "point_list": (1, "points", "points", "InputPoints", "OutputPoints"),
    "line_list": (2, "lines", "line_strip", "InputLines", "OutputLineStrip"),
    "line_strip": (2, "lines", "line_strip", "InputLines", "OutputLineStrip"),
    "triangle_list": (3, "triangles", "triangle_strip", "Triangles", "OutputTriangleStrip"),
    "triangle_strip": (3, "triangles", "triangle_strip", "Triangles", "OutputTriangleStrip"),
    "triangle_fan": (3, "triangles", "triangle_strip", "Triangles", "OutputTriangleStrip"),
    "line_list_with_adjacency": (2, "lines_adjacency", "line_strip", "InputLinesAdjacency", "OutputLineStrip"),
    "line_strip_with_adjacency": (2, "lines_adjacency", "line_strip", "InputLinesAdjacency", "OutputLineStrip"),
    "triangle_list_with_adjacency": (3, "triangles_adjacency", "triangle_strip", "InputTrianglesAdjacency", "OutputTriangleStrip"),
    "triangle_strip_with_adjacency": (3, "triangles_adjacency", "triangle_strip", "InputTrianglesAdjacency", "OutputTriangleStrip"),
}

STREAMS = (0, 1, 3, 6, 14)


def vertex_shader(point_size: bool) -> str:
    return (
        "#version 450\n"
        "\n"
        "layout(location = 0) out vec4 out0;\n"
        "\n"
        "out gl_PerVertex\n"
        "{\n"
        "    vec4  gl_Position;\n"
        + ("    float gl_PointSize;\n" if point_size else "")
        + "};\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    gl_Position  = vec4(0.0, 0.0, 0.0, 1.0);\n"
        + ("    gl_PointSize = 1.0;\n" if point_size else "")
        + "    float n = 4.0 * float(gl_VertexIndex);\n"
        "    out0 = vec4(n + 0.0, n + 1.0, n + 2.0, n + 3.0);\n"
        "}\n"
    )


def per_vertex_blocks(point_size: bool) -> str:
    ps = "    float gl_PointSize;\n" if point_size else ""
    return (
        "in gl_PerVertex\n{\n    vec4  gl_Position;\n" + ps + "} gl_in[];\n"
        "out gl_PerVertex\n{\n    vec4  gl_Position;\n" + ps + "};\n"
        "\n"
    )


def geometry_shader_stream0(topology: str, point_size: bool, omit_write: bool) -> str:
    prim_size, glsl_in, glsl_out, _, _ = TOPOLOGIES[topology]
    src = (
        "#version 450\n"
        "\n"
        f"layout({glsl_in}) in;\n"
        "layout(location = 0) in vec4 in0[];\n"
        "\n"
        f"layout({glsl_out}, max_vertices = {prim_size}) out;\n"
        "layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;\n"
        "\n"
        + per_vertex_blocks(point_size)
        + "void main(void)\n"
        "{\n"
        "    gl_Position  = gl_in[0].gl_Position;\n"
        + ("    gl_PointSize = gl_in[0].gl_PointSize;\n" if point_size else "")
    )
    for i in range(prim_size):
        if not omit_write:
            src += f"    out0 = in0[{i}];\n"
        src += "    EmitVertex();\n"
    src += "    EndPrimitive();\n}\n"
    return src


def geometry_shader_stream(topology: str, stream: int, point_size: bool) -> str:
    prim_size, glsl_in, glsl_out, _, _ = TOPOLOGIES[topology]
    src = (
        "#version 450\n"
        "\n"
        f"layout({glsl_in}) in;\n"
        "layout(location = 0) in vec4 in0[];\n"
        "\n"
        f"layout({glsl_out}, max_vertices = {prim_size}) out;\n"
        f"layout(stream = {stream}, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;\n"
        "\n"
        + per_vertex_blocks(point_size)
        + "void main(void)\n"
        "{\n"
        "    gl_Position  = gl_in[0].gl_Position;\n"
        + ("    gl_PointSize = gl_in[0].gl_PointSize;\n" if point_size else "")
    )
    for i in range(prim_size):
        src += f"    out0 = in0[{i}];\n    EmitStreamVertex({stream});\n"
    src += f"    EndStreamPrimitive({stream});\n}}\n"
    return src


def geometry_shader_asm(topology: str, stream: int, point_size: bool) -> str:
    prim_size, _, _, spirv_in, spirv_out = TOPOLOGIES[topology]
    s = stream
    out = [
        "; SPIR-V\n",
        "; Version: 1.0\n",
        "; Generator: Khronos Glslang Reference Front End; 10\n",
        "; Bound: 64\n",
        "; Schema: 0\n",
        "               OpCapability Geometry\n",
        "               OpCapability TransformFeedback\n",
        "               OpCapability GeometryStreams\n",
        '          %1 = OpExtInstImport "GLSL.std.450"\n',
        "               OpMemoryModel Logical GLSL450\n",
        '               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar\n',
        "               OpExecutionMode %main Xfb\n",
        f"               OpExecutionMode %main {spirv_in}\n",
        "               OpExecutionMode %main Invocations 1\n",
        f"               OpExecutionMode %main {spirv_out}\n",
        f"               OpExecutionMode %main OutputVertices {prim_size}\n",
        "               OpSource GLSL 450\n",
        '               OpSourceExtension "GL_ARB_enhanced_layouts"\n',
        '               OpName %main "main"\n',
        '               OpName %OutBlock "OutBlock"\n',
        '               OpMemberName %OutBlock 0 "out0"\n',
        '               OpName %outBlock "outBlock"\n',
        '               OpName %in0 "in0"\n',
        "               OpMemberDecorate %OutBlock 0 Location 0\n",
        "               OpMemberDecorate %OutBlock 0 Offset 0\n",
        f"               OpMemberDecorate %OutBlock 0 Stream {s}\n",
        "               OpMemberDecorate %OutBlock 0 XfbBuffer 0\n",
        "               OpMemberDecorate %OutBlock 0 XfbStride 16\n",
        "               OpDecorate %OutBlock Block\n",
        "               OpMemberDecorate %BuiltIns 0 BuiltIn Position\n",
    ]
    if point_size:
        out.append("               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize\n")
    out += [
        "               OpDecorate %BuiltIns Block\n",
        "               OpDecorate %in0 Location 0\n",
        "       %void = OpTypeVoid\n",
        "          %3 = OpTypeFunction %void\n",
        "      %float = OpTypeFloat 32\n",
        "    %v4float = OpTypeVector %float 4\n",
        "   %OutBlock = OpTypeStruct %v4float\n",
        "%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock\n",
        "   %outBlock = OpVariable %_ptr_Output_OutBlock Output\n",
        "        %int = OpTypeInt 32 1\n",
        "      %int_0 = OpConstant %int 0\n",
    ]
    for i in range(1, prim_size + 1):
        out.append(f"%int_{i} = OpConstant %int {i}\n")
    out += [
        "       %uint = OpTypeInt 32 0\n",
        f"     %uint_0 = OpConstant %uint {prim_size}\n",
        "%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0\n",
        "%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0\n",
        "        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input\n",
        "%_ptr_Input_v4float = OpTypePointer Input %v4float\n",
        "%_ptr_Input_float = OpTypePointer Input %float\n",
        "%_ptr_Output_v4float = OpTypePointer Output %v4float\n",
        "%_ptr_Output_float = OpTypePointer Output %float\n",
        f"  %streamNum = OpConstant %int {s}\n",
        "%BuiltIns = OpTypeStruct %v4float" + (" %float" if point_size else "") + "\n",
        "%InputBuiltInArray = OpTypeArray %BuiltIns %int_1\n",
        "%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray\n",
        "%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input\n",
        "%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns\n",
        "%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output\n",
        "       %main = OpFunction %void None %3\n",
        "          %5 = OpLabel\n",
        "%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0\n",
        "%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr\n",
        "%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0\n",
    ]
    if point_size:
        out += [
            "%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1\n",
            "%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr\n",
            "%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1\n",
        ]
    for i in range(1, prim_size + 1):
        out += [
            f"%{i}1 = OpAccessChain %_ptr_Input_v4float %in0 %int_{i}\n",
            f"          %{i}2 = OpLoad %v4float %{i}1\n",
            f"          %{i}3 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0\n",
            f"               OpStore %{i}3 %{i}2\n",
            "               OpStore %out_gl_Position_Ptr %in_gl_Position\n",
        ]
        if point_size:
            out.append("               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize\n")
        out.append("               OpEmitStreamVertex %streamNum\n")
    out += [
        "               OpEndStreamPrimitive %streamNum\n",
        "               OpReturn\n",
        "               OpFunctionEnd\n",
    ]
    return "".join(out)


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for stale in SRC_DIR.glob("*"):
        stale.unlink()

    programs: list[tuple[str, str, str]] = []

    def emit(name: str, stage: str, ext: str, source: str) -> None:
        (SRC_DIR / f"{name}.{ext}").write_text(source)
        programs.append((name, f"{SRC_REL}/{name}.{ext}", stage))

    for ps in (0, 1):
        emit(f"vert_ps{ps}", "vert", "vert", vertex_shader(bool(ps)))

    for topology in TOPOLOGIES:
        for ps in (0, 1):
            for omit in (False, True):
                emit(f"geom_s0_{topology}_ps{ps}" + ("_omit" if omit else ""), "geom", "geom", geometry_shader_stream0(topology, bool(ps), omit))
            for stream in STREAMS[1:]:
                emit(f"geom_s{stream}_{topology}_ps{ps}", "geom", "geom", geometry_shader_stream(topology, stream, bool(ps)))
                emit(f"geom_asm_s{stream}_{topology}_ps{ps}", "asm", "asm", geometry_shader_asm(topology, stream, bool(ps)))

    lines = [
        "# Shader manifest for the query, query_omit_write, query_copy, query_copy_stride_zero and host_query_reset cases of",
        "# dEQP-VK.transform_feedback.simple.*",
        "#",
        "# Generated by scripts/gen_xfb_simple_query_shaders.py together with the sources it names; do not hand-edit either.",
        "# One case holding every program: a test case picks its shaders by several independent parameters.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackSimpleTests.cpp"',
        'rust_module = "transform_feedback/simple_query_tests"',
        "",
        "[[case]]",
        'name = "query"',
        'rust_const = "XFB_QUERY_PROGRAMS"',
        'rust_type = "XfbQueryPrograms"',
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

#!/usr/bin/env python3
"""Generate the transform_feedback.primitives_generated_query shaders and their manifest.

Upstream builds each shader from the test parameters in initPrograms. Only a few of
those parameters actually reach the GLSL, so the 107466 cases collapse to a small set:

  vert  - transform feedback on/off, and gl_PointSize only for a point list drawn
          straight from the vertex stage
  tesc  - one, constant
  tese  - transform feedback on/off
  geom  - the input topology, whether the output degenerates to points, the two stream
          indices and whether transform feedback is on
  frag  - the colour-writing one and the empty one

Usage:
    python3 hodow_cts/scripts/gen_pgq_shaders.py
"""

from __future__ import annotations

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "transform_feedback" / "generated"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "transform_feedback_pgq.toml"

# `topologyData`, restricted to what the shaders need. The patch list never reaches a
# geometry shader, so its layout qualifiers are upstream's "ERROR" placeholder and are
# never emitted.
TOPOLOGIES = {
    "point_list": (1, "points", "points"),
    "line_list": (2, "lines", "line_strip"),
    "line_strip": (2, "lines", "line_strip"),
    "triangle_list": (3, "triangles", "triangle_strip"),
    "triangle_strip": (3, "triangles", "triangle_strip"),
    "triangle_fan": (3, "triangles", "triangle_strip"),
    "line_list_with_adjacency": (2, "lines_adjacency", "line_strip"),
    "line_strip_with_adjacency": (2, "lines_adjacency", "line_strip"),
    "triangle_list_with_adjacency": (3, "triangles_adjacency", "triangle_strip"),
    "triangle_strip_with_adjacency": (3, "triangles_adjacency", "triangle_strip"),
    "patch_list": (3, "ERROR", "ERROR"),
}

# `topologyData.at(VK_PRIMITIVE_TOPOLOGY_PATCH_LIST).primitiveSize`
PATCH_LIST_PRIMITIVE_SIZE = 3


def vertex_shader(xfb: bool, point_size: bool) -> str:
    src = ["#version 450\n", "layout(location=0) in vec2 inPosition;\n"]
    if xfb:
        src.append("layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;\n")
    src.append("void main (void)\n{\n")
    if point_size:
        src.append("    gl_PointSize = 1.0;\n")
    src.append("     gl_Position = vec4(inPosition, 0, 1);\n")
    if xfb:
        src.append("    out0 = vec4(42);\n")
    src.append("}\n")
    return "".join(src)


def tess_control_shader() -> str:
    return (
        "#version 450\n"
        "#extension GL_EXT_tessellation_shader : require\n"
        f"layout(vertices = {PATCH_LIST_PRIMITIVE_SIZE}) out;\n"
        "void main (void)\n"
        "{\n"
        "    gl_TessLevelInner[0] = 1.0;\n"
        "    gl_TessLevelInner[1] = 1.0;\n"
        "    gl_TessLevelOuter[0] = 1.0;\n"
        "    gl_TessLevelOuter[1] = 1.0;\n"
        "    gl_TessLevelOuter[2] = 1.0;\n"
        "    gl_TessLevelOuter[3] = 1.0;\n"
        "    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
        "}\n"
    )


def tess_eval_shader(xfb: bool) -> str:
    src = [
        "#version 450\n",
        "#extension GL_EXT_tessellation_shader : require\n",
        "layout(triangles) in;\n",
    ]
    if xfb:
        src.append("layout(xfb_buffer = 0, xfb_offset = 0, location = 0) out vec4 out0;\n")
    src.append("void main (void)\n{\n")
    if xfb:
        src.append("    out0 = vec4(42);\n")
    src.append(
        "    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;\n"
        "    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;\n"
        "    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;\n"
        "    gl_Position = p0 + p1 + p2;\n"
        "}\n"
    )
    return "".join(src)


def geometry_shader(topology: str, pgq_stream: int, xfb_stream: int, xfb: bool) -> str:
    primitive_size, input_topology, topology_output = TOPOLOGIES[topology]
    non_zero_streams = pgq_stream != 0 or xfb_stream != 0
    multiple_streams = pgq_stream != xfb_stream
    output_points = non_zero_streams or topology == "point_list"
    output_topology = "points" if output_points else topology_output
    output_prim_size = 1 if output_points else primitive_size
    max_vertices = output_prim_size * 2 if multiple_streams else output_prim_size

    pgq_emit = f"EmitStreamVertex({pgq_stream})" if non_zero_streams else "EmitVertex()"
    xfb_emit = f"EmitStreamVertex({xfb_stream})" if non_zero_streams else "EmitVertex()"
    pgq_end = f"EndStreamPrimitive({pgq_stream})" if non_zero_streams else "EndPrimitive()"
    xfb_end = f"EndStreamPrimitive({xfb_stream})" if non_zero_streams else "EndPrimitive()"

    src = [
        "#version 450\n",
        f"layout({input_topology}) in;\n",
        f"layout({output_topology}, max_vertices = {max_vertices}) out;\n",
    ]
    if xfb:
        src.append(
            "layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = "
            f"{xfb_stream}) out vec4 xfb;\n"
        )
    src.append("void main (void)\n{\n")
    if output_points:
        src.append("    gl_PointSize = 1.0;\n")
    if xfb:
        src.append("    xfb = vec4(42);\n")
    for _ in range(output_prim_size):
        src.append(f"    {pgq_emit};\n")
    src.append(f"    {pgq_end};\n")
    if xfb and multiple_streams:
        for _ in range(output_prim_size):
            src.append(f"    {xfb_emit};\n")
        src.append(f"    {xfb_end};\n")
    src.append("}\n")
    return "".join(src)


def fragment_shader(empty: bool) -> str:
    if empty:
        return "#version 450\nvoid main (void) {}\n"
    return (
        "#version 450\n"
        "layout(location = 0) out vec4 out0;\n"
        "void main (void)\n"
        "{\n"
        "    out0 = vec4(0.0, 1.0, 0.0, 1.0);\n"
        "}\n"
    )


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for stale in SRC_DIR.glob("*"):
        stale.unlink()

    # Every shader lives in one manifest case, because a test case's set is picked by
    # several independent parameters and enumerating the sets would multiply out to
    # far more entries than there are distinct shaders.
    programs: list[tuple[str, str, str]] = []

    def emit(name: str, stage: str, source: str) -> None:
        path = SRC_DIR / f"{name}.{stage}"
        path.write_text(source)
        programs.append((name, f"transform_feedback/generated/{name}.{stage}", stage))

    for xfb in (False, True):
        for point_size in (False, True):
            name = "vert" + ("_xfb" if xfb else "") + ("_ps" if point_size else "")
            emit(name, "vert", vertex_shader(xfb, point_size))

    emit("tesc", "tesc", tess_control_shader())
    for xfb in (False, True):
        emit("tese_xfb" if xfb else "tese", "tese", tess_eval_shader(xfb))

    for topology in TOPOLOGIES:
        if topology == "patch_list":
            continue
        for xfb in (False, True):
            for pgq_stream in (0, 1):
                # With transform feedback off the registration only ever asks for the
                # default XFB stream, which indexes as 0.
                for xfb_stream in ((0, 1) if xfb else (0,)):
                    name = f"geom_{topology}_pgq{pgq_stream}_xfb{xfb_stream}" + ("_xfb" if xfb else "")
                    emit(name, "geom", geometry_shader(topology, pgq_stream, xfb_stream, xfb))

    emit("frag", "frag", fragment_shader(empty=False))
    emit("frag_empty", "frag", fragment_shader(empty=True))

    lines = [
        "# Shader manifest for dEQP-VK.transform_feedback.primitives_generated_query.*",
        "#",
        "# Generated by scripts/gen_pgq_shaders.py together with the GLSL it names; do not",
        "# hand-edit either. One case holding every program: a test case picks its shaders",
        "# by several independent parameters, so enumerating the sets would multiply out to",
        "# far more entries than there are distinct shaders.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/transform_feedback/vktPrimitivesGeneratedQueryTests.cpp"',
        'rust_module = "transform_feedback/primitives_generated_query_tests"',
        "",
        "[[case]]",
        'name = "pgq"',
        'rust_const = "PGQ_PROGRAMS"',
        'rust_type = "PgqPrograms"',
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

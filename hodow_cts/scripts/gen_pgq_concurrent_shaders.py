#!/usr/bin/env python3
"""Generate the shaders of dEQP-VK.transform_feedback.primitives_generated_query.concurrent.* and their manifest.

`ConcurrentPrimitivesGeneratedQueryTestCase::initPrograms` builds a vertex, a geometry and a fragment shader from the parameters. Every case
of the group uses the geometry stage, the default stream for the query and either no transform feedback or stream 1, so only the topology
and whether transform feedback is on reach the sources: 10 topologies x 2.

The stream arithmetic is upstream's, quirks included: `VERTEX_STREAM_NONE` is 2, so a case without transform feedback has `xfbStreamIndex() == 2`,
which makes `nonZeroStreams()` and `multipleStreams()` true and the geometry shader emits points through `EmitStreamVertex(0)`.

Usage:
    python3 hodow_cts/scripts/gen_pgq_concurrent_shaders.py
"""

from __future__ import annotations

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_REL = "transform_feedback/pgq_concurrent"
SRC_DIR = CRATE_DIR / "shaders" / "src" / SRC_REL
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "transform_feedback_pgq_concurrent.toml"

# name: (primitive size, geometry input, geometry output)
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
}

VERTEX_STREAM_NONE = 2
PGQ_STREAM = 0


def vertex_shader() -> str:
    return "#version 450\nlayout(location=0) in vec2 inPosition;\nvoid main (void)\n{\n    gl_Position = vec4(inPosition, 0, 1);\n}\n"


def geometry_shader(topology: str, transform_feedback: bool) -> str:
    primitive_size, input_topology, output_topology_default = TOPOLOGIES[topology]
    xfb_stream = 1 if transform_feedback else VERTEX_STREAM_NONE
    non_zero_streams = PGQ_STREAM != 0 or xfb_stream != 0
    multiple_streams = PGQ_STREAM != xfb_stream
    output_points = non_zero_streams or topology == "point_list"
    output_topology = "points" if output_points else output_topology_default
    output_prim_size = 1 if output_points else primitive_size
    max_vertices = output_prim_size * 2 if (transform_feedback and multiple_streams) else output_prim_size
    output_zero = PGQ_STREAM != 0 and (not transform_feedback or (transform_feedback and xfb_stream != 0))
    if output_zero:
        max_vertices *= 2

    pgq_emit = f"EmitStreamVertex({PGQ_STREAM})" if non_zero_streams else "EmitVertex()"
    xfb_emit = f"EmitStreamVertex({xfb_stream})" if non_zero_streams else "EmitVertex()"
    pgq_end = f"EndStreamPrimitive({PGQ_STREAM})" if non_zero_streams else "EndPrimitive()"
    xfb_end = f"EndStreamPrimitive({xfb_stream})" if non_zero_streams else "EndPrimitive()"

    if topology == "triangle_strip_with_adjacency":
        # Each point will be in the middle X and Y coordinates of each triangle.
        output = (
            "    const vec3 xCoords = vec3(gl_in[0].gl_Position.x, gl_in[2].gl_Position.x, gl_in[4].gl_Position.x);\n"
            "    const vec3 yCoords = vec3(gl_in[0].gl_Position.y, gl_in[2].gl_Position.y, gl_in[4].gl_Position.y);\n"
            "    const float maxX = max(max(xCoords.x, xCoords.y), xCoords.z);\n"
            "    const float minX = min(min(xCoords.x, xCoords.y), xCoords.z);\n"
            "    const float maxY = max(max(yCoords.x, yCoords.y), yCoords.z);\n"
            "    const float minY = min(min(yCoords.x, yCoords.y), yCoords.z);\n"
            "    gl_Position = vec4((maxX + minX) / 2.0, (maxY + minY) / 2.0, gl_in[0].gl_Position.z, gl_in[0].gl_Position.w);\n"
        )
    elif topology != "triangle_fan":
        output = "    gl_Position = gl_in[0].gl_Position;\n"
    else:
        output = "    gl_Position = abs(gl_in[0].gl_Position.y) < abs(gl_in[1].gl_Position.y) ? gl_in[0].gl_Position : gl_in[1].gl_Position;\n"
    if output_points:
        output += "    gl_PointSize = 1.0;\n"

    src = f"#version 450\nlayout({input_topology}) in;\nlayout({output_topology}, max_vertices = {max_vertices}) out;\n"
    if transform_feedback:
        src += f"layout(xfb_buffer = {xfb_stream}, xfb_offset = 0, xfb_stride = 16, location = 0, stream = {xfb_stream}) out vec4 xfb;\n"
    src += "void main (void)\n{\n"
    if output_zero:
        src += output + "    EmitVertex();\n    EndPrimitive();\n"
    if transform_feedback:
        src += "    xfb = vec4(42);\n"
    for _ in range(output_prim_size):
        if PGQ_STREAM == 0:
            src += output
        src += f"    {pgq_emit};\n"
    src += f"    {pgq_end};\n"
    if transform_feedback and multiple_streams:
        for _ in range(output_prim_size):
            if xfb_stream == 0:
                src += output
            src += f"    {xfb_emit};\n"
        src += f"    {xfb_end};\n"
    src += "}\n"
    return src


def fragment_shader() -> str:
    return "#version 450\nlayout(location = 0) out vec4 out0;\nvoid main (void)\n{\n    out0 = vec4(0.0, 1.0, 0.0, 1.0);\n}\n"


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for stale in SRC_DIR.glob("*"):
        stale.unlink()
    (SRC_DIR / "vert.vert").write_text(vertex_shader())
    (SRC_DIR / "frag.frag").write_text(fragment_shader())

    lines = [
        "# Shader manifest for dEQP-VK.transform_feedback.primitives_generated_query.concurrent.*",
        "#",
        "# Generated by scripts/gen_pgq_concurrent_shaders.py together with the GLSL it names; do not hand-edit either. One case per topology",
        "# and per whether transform feedback is on (`xfb_<topology>` and `plain_<topology>`), looked up by name.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/transform_feedback/vktPrimitivesGeneratedQueryTests.cpp"',
        'rust_module = "transform_feedback/primitives_generated_query_concurrent_tests"',
        "",
    ]
    for topology in TOPOLOGIES:
        for transform_feedback in (False, True):
            name = ("xfb_" if transform_feedback else "plain_") + topology
            geom = f"geom_{name}.geom"
            (SRC_DIR / geom).write_text(geometry_shader(topology, transform_feedback))
            lines += [
                "[[case]]",
                f'name = "{name}"',
                f'rust_const = "PGQ_CONCURRENT_{name.upper()}"',
                'rust_type = "PgqConcurrentPrograms"',
                "programs = [",
                f'    {{ name = "vert", template = "{SRC_REL}/vert.vert", stage = "vert" }},',
                f'    {{ name = "geom", template = "{SRC_REL}/{geom}", stage = "geom" }},',
                f'    {{ name = "frag", template = "{SRC_REL}/frag.frag", stage = "frag" }},',
                "]",
                "",
            ]
    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {len(list(SRC_DIR.glob('*')))} sources in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

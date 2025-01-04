#!/usr/bin/env python3
"""Generate the shaders of dEQP-VK.query_pool.statistics_query.*, their manifest and the GLSL they name.

`QueryPoolGraphicStatisticsTest::initPrograms` builds up to six shaders from the test's parameters: a vertex shader (the
plain one, the one with a push constant vertical offset, or the one of the tessellation tests), a tessellation control and
evaluation pair, a geometry shader per primitive topology (with and without `gl_PointSize` for points) and a fragment shader
with or without a depth write. `QueryPoolComputeStatsTest::initPrograms` adds three compute shaders that differ in their local
size. This script enumerates every combination the registration can reach and emits each distinct program set once; the test
finds its set by the key `statistics_tests::program_key` computes, which has to match `program_key` below:

    <vertex>|<tessellation>|<geometry>|<fragment>

  vertex        `v` plain, `vo` with the vertical offset push constant, `t3` / `t4` the quad vertex shader of the tessellation
                tests with `gl_VertexIndex % 3` or `% 4`
  tessellation  `-` or `<mode>.<patch>.<point>` where the patch size is only kept when it is smaller than the vertices the
                mode needs, since that is the only case the shader text depends on it
  geometry      `-` or the topology name
  fragment      `-` (a vertex only pipeline), `c` (colour attachment), `d` (no colour attachment, writes gl_FragDepth)

Usage:
    python3 hodow_cts/scripts/gen_query_pool_statistics_shaders.py
"""

from __future__ import annotations

import hashlib
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "query_pool" / "statistics"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "query_pool_statistics.toml"

TOPOLOGIES = [
    "point_list",
    "line_list",
    "line_strip",
    "triangle_list",
    "triangle_strip",
    "triangle_fan",
    "line_list_with_adjacency",
    "line_strip_with_adjacency",
    "triangle_list_with_adjacency",
    "triangle_strip_with_adjacency",
    "patch_list",
]
MODES = ["triangles", "isolines", "quads"]
VERTICES_NEEDED = {"triangles": 3, "isolines": 2, "quads": 4}
MAX_TESS_PATCH_SIZE = 32


def input_type(topology: str) -> str:
    """`inputTypeToGLString`"""
    if topology == "point_list":
        return "points"
    if topology in ("line_list", "line_strip"):
        return "lines"
    if topology in ("line_list_with_adjacency", "line_strip_with_adjacency"):
        return "lines_adjacency"
    if topology in ("triangle_list_with_adjacency", "triangle_strip_with_adjacency"):
        return "triangles_adjacency"
    return "triangles"


def output_type(topology: str) -> str:
    """`outputTypeToGLString`"""
    if topology == "point_list":
        return "points"
    if topology in ("line_strip", "line_list", "line_list_with_adjacency", "line_strip_with_adjacency"):
        return "line_strip"
    return "triangle_strip"


def vertex_shader(kind: str) -> str:
    if kind in ("t3", "t4"):
        modulo = 3 if kind == "t3" else 4
        return (
            "#version 450\n"
            "vec4 positions[4] = vec4[](\n"
            "    vec4(-1.0f, -1.0f, 0.0f, 1.0f),\n"
            "    vec4( 1.0f, -1.0f, 0.0f, 1.0f),\n"
            "    vec4(-1.0f,  1.0f, 0.0f, 1.0f),\n"
            "    vec4( 1.0f,  1.0f, 0.0f, 1.0f)\n"
            ");\n"
            "\n"
            "layout(location = 0) out vec4 out_color;\n"
            "\n"
            "void main() {\n"
            f"    gl_Position = positions[gl_VertexIndex % {modulo}];\n"
            "    gl_PointSize = 1.0f;\n"
            "    out_color = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue\n"
            "}\n"
        )

    vertical_offset = kind == "vo"
    return (
        "#version 450\n"
        "layout(location = 0) in highp vec4 in_position;\n"
        "layout(location = 1) in vec4 in_color;\n"
        "layout(location = 0) out vec4 out_color;\n"
        + ("layout(push_constant, std430) uniform PCBlock { float verticalOffset; } pc;\n" if vertical_offset else "")
        + "void main (void)\n"
        "{\n"
        "    gl_PointSize = 1.0;\n"
        f"    const float yOffset = {'pc.verticalOffset' if vertical_offset else '0.0'};\n"
        "    gl_Position = vec4(in_position.x, in_position.y + yOffset, in_position.z, in_position.w);\n"
        "    out_color = in_color;\n"
        "}\n"
    )


def tess_shaders(mode: str, patch: int, point: bool) -> tuple[str, str]:
    tc = "#version 450\n#extension GL_EXT_tessellation_shader : require\n"
    tc += f"layout(vertices = {VERTICES_NEEDED[mode]}) out;\n"
    if mode == "triangles":
        tc += "vec4 positions[3] = vec4[](\n    vec4(-0.5f, -0.5f, 0.0f, 1.0f),\n    vec4( 0.5f, -0.5f, 0.0f, 1.0f),\n    vec4( 0.0f,  0.5f, 0.0f, 1.0f)\n);\n"
    elif mode == "isolines":
        tc += "vec4 positions[2] = vec4[](\n    vec4(-0.5f,  0.0f, 0.0f, 1.0f),\n    vec4( 0.5f,  0.0f, 0.0f, 1.0f)\n);\n"
    else:
        tc += "vec4 positions[4] = vec4[](\n    vec4(-1.0f, -1.0f, 0.0f, 1.0f),\n    vec4( 1.0f, -1.0f, 0.0f, 1.0f),\n    vec4(-1.0f,  1.0f, 0.0f, 1.0f),\n    vec4( 1.0f,  1.0f, 0.0f, 1.0f)\n);\n"
    tc += "layout(location = 0) in vec4 in_color[];\nlayout(location = 0) out vec4 out_color[];\n\nvoid main (void)\n{\n    if( gl_InvocationID == 0 )\n    {\n"
    if mode == "triangles":
        tc += "        gl_TessLevelInner[0] = 4.0f;\n        gl_TessLevelOuter[0] = 4.0f;\n        gl_TessLevelOuter[1] = 4.0f;\n        gl_TessLevelOuter[2] = 4.0f;\n"
    elif mode == "isolines":
        tc += "        gl_TessLevelOuter[0] = 4.0f; // Number of lines\n        gl_TessLevelOuter[1] = 4.0f; // Number of segments per line\n"
    else:
        tc += (
            "        gl_TessLevelInner[0] = 4.0f;\n        gl_TessLevelInner[1] = 4.0f;\n"
            "        gl_TessLevelOuter[0] = 4.0f;\n        gl_TessLevelOuter[1] = 4.0f;\n"
            "        gl_TessLevelOuter[2] = 4.0f;\n        gl_TessLevelOuter[3] = 4.0f;\n"
        )
    tc += "    }\n"
    partial = 0 < patch < VERTICES_NEEDED[mode]
    if partial:
        tc += f"\n    if (gl_InvocationID < {patch})\n    {{\n"
    tc += "        out_color[gl_InvocationID] = in_color[gl_InvocationID];\n        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
    if partial:
        tc += (
            "    }\n    else\n    {\n"
            "        out_color[gl_InvocationID] = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue\n"
            "        gl_out[gl_InvocationID].gl_Position = positions[gl_InvocationID];\n"
            "    }\n"
        )
    tc += "}\n"

    te = "#version 450\n#extension GL_EXT_tessellation_shader : require\n"
    if mode == "triangles":
        te += "layout(triangles, equal_spacing, ccw) in;\n"
    elif mode == "isolines":
        te += "layout(isolines, equal_spacing) in;\n"
    else:
        te += "layout(quads, equal_spacing, ccw) in;\n"
    if point:
        te += "layout(point_mode) in;\n"
    te += "layout(location = 0) in vec4 in_color[];\nlayout(location = 0) out vec4 out_color;\nvoid main (void)\n{\n"
    if mode == "triangles":
        te += (
            "    const float u = gl_TessCoord.x;\n    const float v = gl_TessCoord.y;\n    const float w = gl_TessCoord.z;\n"
            "    gl_Position = u * gl_in[0].gl_Position + v * gl_in[1].gl_Position + w * gl_in[2].gl_Position;\n"
        )
    elif mode == "isolines":
        te += (
            "    const float u = gl_TessCoord.x; // Position along the line\n    const float v = gl_TessCoord.y; // Which line\n"
            "    gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, u);\n"
        )
    else:
        te += (
            "    const float u = gl_TessCoord.x;\n    const float v = gl_TessCoord.y;\n"
            "    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position + (1 - u) * v * gl_in[1].gl_Position + u * (1 - v) * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position;\n"
        )
    if point:
        te += "    gl_PointSize = 1.0;\n"
    te += "    out_color = in_color[0];\n}\n"
    return tc, te


def geometry_shader(topology: str, point_size: bool) -> str:
    is_point = topology == "point_list"
    ps = "    gl_PointSize = gl_in[0].gl_PointSize;\n" if (is_point and point_size) else ""
    src = (
        "#version 450\n"
        f"layout({input_type(topology)}) in;\n"
        f"layout({output_type(topology)}, max_vertices = 16) out;\n"
        "layout(location = 0) in vec4 in_color[];\n"
        "layout(location = 0) out vec4 out_color;\n"
        "void main (void)\n{\n"
        "    out_color = in_color[0];\n"
        + ps
        + "    gl_Position = gl_in[0].gl_Position;\n    EmitVertex();\n    EndPrimitive();\n\n"
        "    out_color = in_color[0];\n"
        + ps
        + "    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);\n    EmitVertex();\n"
        "    out_color = in_color[0];\n"
        + ps
        + "    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);\n    EmitVertex();\n    EndPrimitive();\n\n"
    )
    if topology in ("triangle_strip", "triangle_list"):
        src += (
            "\n    out_color = in_color[0];\n    gl_Position = gl_in[0].gl_Position;\n    EmitVertex();\n"
            "    out_color = in_color[0];\n    gl_Position = gl_in[1].gl_Position;\n    EmitVertex();\n"
            "    out_color = in_color[0];\n    gl_Position = gl_in[2].gl_Position;\n    EmitVertex();\n"
            "    out_color = in_color[0];\n    gl_Position = vec4(gl_in[2].gl_Position.x, gl_in[1].gl_Position.y, 1.0, 1.0);\n    EmitVertex();\n"
            "    EndPrimitive();\n"
        )
    else:
        for x, y in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
            src += f"    out_color = in_color[0];\n" + ps + f"    gl_Position = vec4({x}.0, {y}.0, 1.0, 1.0);\n    EmitVertex();\n"
        src += "    EndPrimitive();\n"
    src += "}\n"
    return src


def fragment_shader(depth: bool) -> str:
    return (
        "#version 450\n"
        "layout(location = 0) in vec4 in_color;\n"
        "layout(location = 0) out vec4 out_color;\n"
        + ("layout (set=0, binding=0, std430) readonly buffer DepthsBlock { float depths[5]; } depthsBuffer;\n" if depth else "")
        + "void main()\n{\n    out_color = in_color;\n"
        + ("    gl_FragDepth = depthsBuffer.depths[((int(gl_FragCoord.x) + int(gl_FragCoord.y)) % 5)];\n" if depth else "")
        + "}\n"
    )


def compute_shader(local_size: tuple[int, int, int]) -> str:
    return (
        "#version 450\n"
        f"layout (local_size_x = {local_size[0]}, local_size_y = {local_size[1]}, local_size_z = {local_size[2]}) in;\n"
        "layout(binding = 0) writeonly buffer Output {\n    uint values[];\n} sb_out;\n\n"
        "void main (void) {\n"
        "    uvec3 indexUvec3 = uvec3 (gl_GlobalInvocationID.x,\n"
        "                              gl_GlobalInvocationID.y * gl_NumWorkGroups.x * gl_WorkGroupSize.x,\n"
        "                              gl_GlobalInvocationID.z * gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupSize.x * gl_WorkGroupSize.y);\n"
        "    uint index = indexUvec3.x + indexUvec3.y + indexUvec3.z;\n"
        "    sb_out.values[index] += index;\n"
        "}\n"
    )


def multiple_queries_vertex_shader() -> str:
    return (
        "#version 450\n"
        "layout(location = 0) in highp vec4 in_position;\n"
        "layout(location = 1) in vec4 in_color;\n"
        "layout(location = 0) out vec4 out_color;\n"
        "void main (void)\n"
        "{\n"
        "    gl_PointSize = 1.0;\n"
        "    gl_Position = in_position;\n"
        "    out_color = in_color;\n"
        "}\n"
    )


def multiple_geom_stats_shaders() -> list[tuple[str, str, str]]:
    """`MultipleGeomStatsTestCase::initPrograms`"""
    vert = (
        "#version 460\n"
        "layout (location=0) in vec4 inPos;\n"
        "out gl_PerVertex\n"
        "{\n"
        "    vec4 gl_Position;\n"
        "};\n"
        "void main (void) {\n"
        "    gl_Position = inPos;\n"
        "}\n"
    )
    geom = (
        "#version 450\n"
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
        "void main() {\n"
        + "".join(f"    gl_Position = gl_in[{i}].gl_Position;\n    EmitVertex();\n" for i in range(3))
        + "}\n"
    )
    frag = (
        "#version 460\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main (void) {\n"
        "    outColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "}\n"
    )
    return [("vert", write(vert, "vert"), "vert"), ("geom", write(geom, "geom"), "geom"), ("frag", write(frag, "frag"), "frag")]


def program_key(vertex: str, tess: str, geometry: str, fragment: str) -> str:
    return f"{vertex}|{tess}|{geometry}|{fragment}"


def write(text: str, ext: str) -> str:
    digest = hashlib.sha1(text.encode()).hexdigest()[:12]
    name = f"stat_{digest}.{ext}"
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    (SRC_DIR / name).write_text(text)
    return f"query_pool/statistics/{name}"


def graphic_sets() -> dict[str, list[tuple[str, str, str]]]:
    """key -> [(program name, template, stage)]"""
    sets: dict[str, list[tuple[str, str, str]]] = {}

    def add(vertex_kind: str, tess: tuple[str, int, bool] | None, geometry: str | None, fragment: str | None) -> None:
        tess_key = "-"
        programs = [("vertex", write(vertex_shader(vertex_kind), "vert"), "vert")]
        if tess is not None:
            mode, patch, point = tess
            kept = patch if 0 < patch < VERTICES_NEEDED[mode] else 0
            tess_key = f"{mode}.{kept}.{int(point)}"
            tc, te = tess_shaders(mode, kept, point)
            programs.append(("tessellation_control", write(tc, "tesc"), "tesc"))
            programs.append(("tessellation_evaluation", write(te, "tese"), "tese"))
        if geometry is not None:
            programs.append(("geometry", write(geometry_shader(geometry, False), "geom"), "geom"))
            if geometry == "point_list":
                programs.append(("geometry_point_size", write(geometry_shader(geometry, True), "geom"), "geom"))
        if fragment is not None:
            programs.append(("fragment", write(fragment_shader(fragment == "d"), "frag"), "frag"))
        key = program_key(vertex_kind, tess_key, geometry or "-", fragment or "-")
        sets.setdefault(key, programs)

    fragments = [None, "c", "d"]
    # Without tessellation: a plain or offset vertex shader, a geometry shader for the topologies the tests with a geometry
    # statistic reach.
    for vertex_kind in ("v", "vo"):
        for geometry in [None] + TOPOLOGIES[:-1]:
            for fragment in fragments:
                add(vertex_kind, None, geometry, fragment)

    # With tessellation: the vertex shader is the quad one when the test sets a patch size, with or without a geometry stage.
    for mode in MODES:
        for patch in range(0, MAX_TESS_PATCH_SIZE + 1):
            for point in (False, True):
                vertex_kind = "v" if patch == 0 else ("t3" if mode == "triangles" else "t4")
                for geometry in (None, "patch_list"):
                    for fragment in ("c", "d"):
                        add(vertex_kind, (mode, patch, point), geometry, fragment)
    return sets


def main() -> int:
    for existing in SRC_DIR.glob("stat_*"):
        existing.unlink()

    sets = graphic_sets()
    lines = [
        "# Shader manifest for dEQP-VK.query_pool.statistics_query.*",
        "#",
        "# Generated by scripts/gen_query_pool_statistics_shaders.py together with the GLSL it names; do not hand-edit either.",
        "# `compute` is the three compute shaders of QueryPoolComputeStatsTest, the other entries are the program sets of",
        "# QueryPoolGraphicStatisticsTest::initPrograms keyed by what they were built for (see the script).",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/query_pool/vktQueryPoolStatisticsTests.cpp"',
        'rust_module = "query_pool/statistics_tests"',
        "",
    ]

    compute_programs = []
    for ndx, local_size in enumerate([(2, 2, 2), (1, 1, 1), (64 // (7 * 3), 7, 3)]):
        compute_programs.append((f"compute_{ndx}", write(compute_shader(local_size), "comp"), "comp"))
    entries = [("compute", compute_programs)] + sorted(sets.items())

    # The `multiple_queries` and `multiple_geom_stats` groups, found by their own name instead of a computed key.
    multiple_vertex = ("vertex", write(multiple_queries_vertex_shader(), "vert"), "vert")
    multiple_fragment = ("fragment", write(fragment_shader(False), "frag"), "frag")
    named = [
        ("multiple_queries", [multiple_vertex, multiple_fragment]),
        ("multiple_queries_vertex_only", [multiple_vertex]),
        ("multiple_geom_stats", multiple_geom_stats_shaders()),
    ]
    named_keys = {key for key, _ in named}
    entries += named

    for ndx, (key, programs) in enumerate(entries):
        name = key if key == "compute" or key in named_keys else f"set_{ndx:03d}"
        lines += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "STATISTICS_{name.upper()}"',
            'rust_type = "StatisticsProgram"',
            "programs = [",
            *[f'    {{ name = "{pname}", template = "{template}", stage = "{stage}" }},' for pname, template, stage in programs],
            "]",
            "[case.params]",
            f'key = {{ type = "str", value = "{key}" }}',
            "",
        ]

    MANIFEST.write_text("\n".join(lines))
    print(f"{len(entries)} program sets, {len(list(SRC_DIR.glob('stat_*')))} shaders -> {MANIFEST.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""Writes shaders/manifest/rasterization_polygon_points.toml and the GLSL under shaders/src/rasterization/polygon_points/.

`PolygonModeLargePointsCase::initPrograms`: the vertex (or mesh) shader, the tessellation and the geometry shaders pass the point size
along unless the case uses the default size (`defaultSize`, the point size of 1.0 is then never written). Five stage combinations (mesh,
vert, vert_tess, vert_geom, vert_tess_geom) times {sized (2.0), default}.
"""
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
SRC = CRATE / "shaders" / "src" / "rasterization" / "polygon_points"
MANIFEST = CRATE / "shaders" / "manifest" / "rasterization_polygon_points.toml"

POINT_SIZE = "2.000000"
NUM_TRIANGLES = 2
NUM_POINTS = NUM_TRIANGLES * 3


def vert(default_size: bool) -> str:
    text = (
        "#version 460\n"
        "layout (location=0) in vec4 inPosition;\n"
        "out gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "};\n"
        "void main (void) {\n"
        "    gl_Position  = inPosition;\n"
    )
    if not default_size:
        text += f"    gl_PointSize = {POINT_SIZE};\n"
    return text + "}\n"


def mesh(default_size: bool) -> str:
    text = (
        "#version 450\n"
        "#extension GL_EXT_mesh_shader : enable\n"
        "\n"
        f"layout (local_size_x={NUM_POINTS}, local_size_y=1, local_size_z=1) in;\n"
        "layout (triangles) out;\n"
        f"layout (max_vertices={NUM_POINTS}, max_primitives={NUM_TRIANGLES}) out;\n"
        "\n"
        "out gl_MeshPerVertexEXT {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "} gl_MeshVerticesEXT[];\n"
        "\n"
        "layout (set=0, binding=0, std430) readonly buffer VertexData {\n"
        "    vec4 vertices[];\n"
        "} vertexBuffer;\n"
        "\n"
        "void main (void) {\n"
        f"    SetMeshOutputsEXT({NUM_POINTS}, {NUM_TRIANGLES});\n"
        "    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vertexBuffer.vertices[gl_LocalInvocationIndex];\n"
    )
    if not default_size:
        text += f"    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = {POINT_SIZE};\n"
    text += (
        f"    if (gl_LocalInvocationIndex < {NUM_TRIANGLES}) {{\n"
        "        const uint baseIndex = gl_LocalInvocationIndex * 3u;\n"
        "        gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(baseIndex, baseIndex + 1u, baseIndex + 2u);\n"
        "    }\n"
        "}\n"
    )
    return text


FRAG = (
    "#version 460\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main (void) {\n"
    "    outColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
    "}\n"
)


def tesc(default_size: bool) -> str:
    text = (
        "#version 460\n"
        "layout (vertices=3) out;\n"
        "in gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "} gl_in[gl_MaxPatchVertices];\n"
        "out gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "} gl_out[];\n"
        "void main (void) {\n"
        "  gl_TessLevelInner[0] = 1.0;\n"
        "  gl_TessLevelInner[1] = 1.0;\n"
        "  gl_TessLevelOuter[0] = 1.0;\n"
        "  gl_TessLevelOuter[1] = 1.0;\n"
        "  gl_TessLevelOuter[2] = 1.0;\n"
        "  gl_TessLevelOuter[3] = 1.0;\n"
        "  gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position;\n"
    )
    if not default_size:
        text += "  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;\n"
    return text + "}\n"


def tese(default_size: bool) -> str:
    text = (
        "#version 460\n"
        "layout (triangles, fractional_odd_spacing, cw) in;\n"
        "in gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "} gl_in[gl_MaxPatchVertices];\n"
        "out gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "};\n"
        "void main (void) {\n"
        "    gl_Position  = (gl_TessCoord.x * gl_in[0].gl_Position) +\n"
        "                   (gl_TessCoord.y * gl_in[1].gl_Position) +\n"
        "                   (gl_TessCoord.z * gl_in[2].gl_Position);\n"
    )
    if not default_size:
        text += "    gl_PointSize = gl_in[0].gl_PointSize;\n"
    return text + "}\n"


def geom(default_size: bool) -> str:
    text = (
        "#version 460\n"
        "layout (triangles) in;\n"
        "layout (triangle_strip, max_vertices=3) out;\n"
        "in gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "} gl_in[3];\n"
        "out gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "};\n"
        "void main (void) {\n"
        "    for (uint i = 0u; i < 3u; ++i) {\n"
        "        gl_Position  = gl_in[i].gl_Position;\n"
    )
    if not default_size:
        text += "        gl_PointSize = gl_in[i].gl_PointSize;\n"
    return text + "        EmitVertex();\n    }\n}\n"


def main() -> None:
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for dEQP-VK.rasterization.polygon_as_large_points.* and primitive_size.default_size.polygon_as_points.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_polygon_points_manifest.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/rasterization/vktRasterizationTests.cpp"',
        'rust_module = "rasterization/polygon_large_points_tests"',
        "",
    ]
    (SRC / "frag.frag").write_text(FRAG)
    for default_size in (False, True):
        size_key = "default" if default_size else "sized"
        (SRC / f"vert_{size_key}.vert").write_text(vert(default_size))
        (SRC / f"mesh_{size_key}.mesh").write_text(mesh(default_size))
        (SRC / f"tesc_{size_key}.tesc").write_text(tesc(default_size))
        (SRC / f"tese_{size_key}.tese").write_text(tese(default_size))
        (SRC / f"geom_{size_key}.geom").write_text(geom(default_size))
        for stages in ("mesh", "vert", "vert_tess", "vert_geom", "vert_tess_geom"):
            key = f"{stages}_{size_key}"
            programs = []
            if stages == "mesh":
                programs.append(
                    f'    {{ name = "mesh", template = "rasterization/polygon_points/mesh_{size_key}.mesh", stage = "mesh", spirv_version = "spirv1.4" }},'
                )
            else:
                programs.append(
                    f'    {{ name = "vert", template = "rasterization/polygon_points/vert_{size_key}.vert", stage = "vert" }},'
                )
            programs.append('    { name = "frag", template = "rasterization/polygon_points/frag.frag", stage = "frag" },')
            if "tess" in stages:
                programs.append(
                    f'    {{ name = "tesc", template = "rasterization/polygon_points/tesc_{size_key}.tesc", stage = "tesc" }},'
                )
                programs.append(
                    f'    {{ name = "tese", template = "rasterization/polygon_points/tese_{size_key}.tese", stage = "tese" }},'
                )
            if "geom" in stages:
                programs.append(
                    f'    {{ name = "geom", template = "rasterization/polygon_points/geom_{size_key}.geom", stage = "geom" }},'
                )
            out += [
                "[[case]]",
                f'name = "{key}"',
                f'rust_const = "POLYGON_POINTS_{key.upper()}"',
                'rust_type = "SharedProgram"',
                "programs = [",
                *programs,
                "]",
                "",
            ]
    MANIFEST.write_text("\n".join(out))


if __name__ == "__main__":
    main()

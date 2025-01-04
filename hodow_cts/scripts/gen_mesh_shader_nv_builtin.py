#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.mesh_shader.nv.builtin.* (vktMeshShaderBuiltinTests.cpp).

Each case class of upstream formats its task, mesh and fragment shader text from a few parameters (task needed, vertices shared,
shading rate masks); this does the same formatting once per case and writes the result. The two cases built from SPIR-V
assembly (primitive_id_spirv, and the mesh shader of primitive_shading_rate_*) use upstream's assembly kept in
shaders/src/mesh_shader/nv_builtin_*.asm, the shading rate masks substituted.

Usage: python3 hodow_cts/scripts/gen_mesh_shader_nv_builtin.py [--check]
"""

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "mesh_shader" / "nv_builtin"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "mesh_shader_nv_builtin.toml"

DEFAULT_EXTENT = (8, 8)
LINEAR_EXTENT = (8, 1)
LARGE_JOB_SIZE = (8, 8)  # numTasks, localSize
K_NUM_LAYERS = 4
K_QUADRANTS = 4
POINT_SIZE = 4.0

HEADER = "#version 460\n#extension GL_NV_mesh_shader : enable\n\n"


def g(value):
    """C++ ostream formatting of a float: six significant digits, no trailing zeros."""
    return "%g" % value


BASIC_FRAG = HEADER + "layout (location=0) out vec4 outColor;\n\nvoid main ()\n{\n    outColor = vec4(0.0, 0.0, 1.0, 1.0);\n}\n"


def triangle_for_pixel(pixel, length, base_index):
    return (
        f"    const float imgWidth = float({length});\n"
        "    const float pixWidth = (2.0 / imgWidth);\n"
        "    const float halfPix  = (pixWidth / 2.0);\n"
        f"    const float xCenter  = (((float({pixel}) + 0.5) / imgWidth) * 2.0 - 1.0);\n"
        "    const float xLeft    = (xCenter - halfPix);\n"
        "    const float xRight   = (xCenter + halfPix);\n"
        f"    const uvec3 indices  = uvec3({base_index} + 0, {base_index} + 1, {base_index} + 2);\n"
        "\n"
        "    gl_PrimitiveIndicesNV[indices.x] = indices.x;\n"
        "    gl_PrimitiveIndicesNV[indices.y] = indices.y;\n"
        "    gl_PrimitiveIndicesNV[indices.z] = indices.z;\n"
        "\n"
        "    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);\n"
    )


def position_case():
    fw, fh = DEFAULT_EXTENT
    px_w, px_h = 2.0 / fw, 2.0 / fh
    half_x, half_y = px_w / 2.0, px_h / 2.0
    x, y = -1.0 + half_x, -1.0 + half_y
    mesh = (
        HEADER
        + "layout (local_size_x=1) in;\nlayout (triangles) out;\nlayout (max_vertices=3, max_primitives=1) out;\n\n"
        "void main ()\n{\n    gl_PrimitiveCountNV = 1u;\n\n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n    gl_PrimitiveIndicesNV[1] = 1;\n    gl_PrimitiveIndicesNV[2] = 2;\n\n"
        f"    gl_MeshVerticesNV[0].gl_Position = vec4({g(x - half_x)}, {g(y + half_y)}, 0.0, 1.0);\n"
        f"    gl_MeshVerticesNV[1].gl_Position = vec4({g(x + half_x)}, {g(y + half_y)}, 0.0, 1.0);\n"
        f"    gl_MeshVerticesNV[2].gl_Position = vec4({g(x)}, {g(y - half_y)}, 0.0, 1.0);\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": BASIC_FRAG}


def point_size_case():
    mesh = (
        HEADER
        + "layout (local_size_x=1) in;\nlayout (points) out;\nlayout (max_vertices=1, max_primitives=1) out;\n\n"
        "void main ()\n{\n    gl_PrimitiveCountNV = 1u;\n    gl_PrimitiveIndicesNV[0] = 0;\n"
        "    gl_MeshVerticesNV[0].gl_Position = vec4(-0.5, -0.5, 0.0, 1.0);\n"
        f"    gl_MeshVerticesNV[0].gl_PointSize = {g(POINT_SIZE)};\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": BASIC_FRAG}


def clip_distance_case():
    mesh = (
        HEADER
        + "layout (local_size_x=1) in;\nlayout (triangles) out;\nlayout (max_vertices=4, max_primitives=2) out;\n\n"
        "out gl_MeshPerVertexNV {\n    vec4  gl_Position;\n    float gl_ClipDistance[2];\n} gl_MeshVerticesNV[];\n\n"
        "void main ()\n{\n    gl_PrimitiveCountNV = 2u;\n\n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n    gl_PrimitiveIndicesNV[1] = 1;\n    gl_PrimitiveIndicesNV[2] = 2;\n"
        "    gl_PrimitiveIndicesNV[3] = 1;\n    gl_PrimitiveIndicesNV[4] = 3;\n    gl_PrimitiveIndicesNV[5] = 2;\n\n"
        "    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[2].gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[3].gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);\n\n"
        "    gl_MeshVerticesNV[0].gl_ClipDistance[0] =  1.0;\n"
        "    gl_MeshVerticesNV[1].gl_ClipDistance[0] =  1.0;\n"
        "    gl_MeshVerticesNV[2].gl_ClipDistance[0] = -1.0;\n"
        "    gl_MeshVerticesNV[3].gl_ClipDistance[0] = -1.0;\n\n"
        "    gl_MeshVerticesNV[0].gl_ClipDistance[1] =  1.0;\n"
        "    gl_MeshVerticesNV[1].gl_ClipDistance[1] = -1.0;\n"
        "    gl_MeshVerticesNV[2].gl_ClipDistance[1] =  1.0;\n"
        "    gl_MeshVerticesNV[3].gl_ClipDistance[1] = -1.0;\n"
        "}\n"
    )
    frag = (
        HEADER
        + "layout (location=0) out vec4 outColor;\n\nvoid main ()\n{\n"
        "    outColor = ((gl_ClipDistance[0] >= 0.0 && gl_ClipDistance[1] >= 0.0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0));\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": frag}


def cull_distance_case():
    mesh = (
        HEADER
        + "layout (local_size_x=1) in;\nlayout (triangles) out;\nlayout (max_vertices=6, max_primitives=4) out;\n\n"
        "out gl_MeshPerVertexNV {\n    vec4  gl_Position;\n    float gl_CullDistance[2];\n} gl_MeshVerticesNV[];\n\n"
        "void main ()\n{\n    gl_PrimitiveCountNV = 4u;\n\n"
        "    gl_PrimitiveIndicesNV[0]  = 0;\n    gl_PrimitiveIndicesNV[1]  = 1;\n    gl_PrimitiveIndicesNV[2]  = 3;\n"
        "    gl_PrimitiveIndicesNV[3]  = 1;\n    gl_PrimitiveIndicesNV[4]  = 4;\n    gl_PrimitiveIndicesNV[5]  = 3;\n"
        "    gl_PrimitiveIndicesNV[6]  = 1;\n    gl_PrimitiveIndicesNV[7]  = 2;\n    gl_PrimitiveIndicesNV[8]  = 4;\n"
        "    gl_PrimitiveIndicesNV[9]  = 2;\n    gl_PrimitiveIndicesNV[10] = 5;\n    gl_PrimitiveIndicesNV[11] = 4;\n\n"
        "    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  0.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[2].gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[3].gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[4].gl_Position = vec4( 1.0,  0.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[5].gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);\n\n"
        "    gl_MeshVerticesNV[0].gl_CullDistance[0] =  1.0;\n"
        "    gl_MeshVerticesNV[1].gl_CullDistance[0] = -1.0;\n"
        "    gl_MeshVerticesNV[2].gl_CullDistance[0] = -2.0;\n"
        "    gl_MeshVerticesNV[3].gl_CullDistance[0] =  1.0;\n"
        "    gl_MeshVerticesNV[4].gl_CullDistance[0] = -1.0;\n"
        "    gl_MeshVerticesNV[5].gl_CullDistance[0] = -2.0;\n\n"
        "    gl_MeshVerticesNV[0].gl_CullDistance[1] =  1.0;\n"
        "    gl_MeshVerticesNV[1].gl_CullDistance[1] =  1.0;\n"
        "    gl_MeshVerticesNV[2].gl_CullDistance[1] =  1.0;\n"
        "    gl_MeshVerticesNV[3].gl_CullDistance[1] = -1.0;\n"
        "    gl_MeshVerticesNV[4].gl_CullDistance[1] = -1.0;\n"
        "    gl_MeshVerticesNV[5].gl_CullDistance[1] = -1.0;\n"
        "}\n"
    )
    frag = (
        HEADER
        + "layout (location=0) out vec4 outColor;\n\nvoid main ()\n{\n"
        "    outColor = ((gl_CullDistance[1] >= 0.0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0));\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": frag}


def primitive_id_mesh():
    return (
        HEADER
        + "layout (local_size_x=1) in;\nlayout (triangles) out;\nlayout (max_vertices=3, max_primitives=1) out;\n\n"
        "perprimitiveNV out gl_MeshPerPrimitiveNV {\n   int gl_PrimitiveID;\n} gl_MeshPrimitivesNV[];\n\n"
        "void main ()\n{\n    gl_PrimitiveCountNV = 1u;\n\n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n    gl_PrimitiveIndicesNV[1] = 1;\n    gl_PrimitiveIndicesNV[2] = 2;\n\n"
        "    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);\n\n"
        "    gl_MeshPrimitivesNV[0].gl_PrimitiveID = 1629198956;\n"
        "}\n"
    )


def primitive_id_glsl_case():
    frag = (
        HEADER
        + "layout (location=0) out vec4 outColor;\n\nvoid main ()\n{\n"
        "    outColor = ((gl_PrimitiveID == 1629198956) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));\n"
        "}\n"
    )
    return {"mesh": primitive_id_mesh(), "frag": frag}


def layer_or_viewport_case(builtin, count, share_vertices, per_prim_member, frag_index):
    local_size = count if share_vertices else 1
    num_primitives = count if share_vertices else 1
    number = "gl_LocalInvocationIndex" if share_vertices else "gl_WorkGroupID.x"
    mesh = (
        HEADER
        + f"layout (local_size_x={local_size}) in;\nlayout (triangles) out;\nlayout (max_vertices=3, max_primitives={num_primitives}) out;\n\n"
        f"perprimitiveNV out gl_MeshPerPrimitiveNV {{\n   int {per_prim_member};\n}} gl_MeshPrimitivesNV[];\n\n"
        f"void main ()\n{{\n    gl_PrimitiveCountNV = {num_primitives};\n\n"
        "    if (gl_LocalInvocationIndex == 0u)\n    {\n"
        "        gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n"
        "        gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);\n"
        "        gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);\n"
        "    }\n\n"
        "    const uint baseIndex = gl_LocalInvocationIndex * 3u;\n"
        "    gl_PrimitiveIndicesNV[baseIndex + 0] = 0;\n"
        "    gl_PrimitiveIndicesNV[baseIndex + 1] = 1;\n"
        "    gl_PrimitiveIndicesNV[baseIndex + 2] = 2;\n\n"
        f"    gl_MeshPrimitivesNV[gl_LocalInvocationIndex].{per_prim_member} = int({number});\n"
        "}\n"
    )
    frag = (
        HEADER
        + f"layout (location=0) out vec4 outColor;\n\nvec4 colors[{count}] = vec4[](\n"
        "    vec4(0.0, 0.0, 1.0, 1.0),\n    vec4(1.0, 0.0, 1.0, 1.0),\n    vec4(0.0, 1.0, 1.0, 1.0),\n    vec4(1.0, 1.0, 0.0, 1.0)\n);\n\n"
        f"void main ()\n{{\n    outColor = colors[{frag_index}];\n}}\n"
    )
    return {"mesh": mesh, "frag": frag}


def work_group_id_case(task_needed):
    task_data_decl = "taskNV TaskData {\n    uint id;\n    uint size;\n} td;\n"
    pixel = "td.id" if task_needed else "gl_WorkGroupID.x"
    length = "td.size" if task_needed else str(LINEAR_EXTENT[0])
    mesh = (
        HEADER
        + "layout (local_size_x=1) in;\nlayout (triangles) out;\nlayout (max_vertices=3, max_primitives=1) out;\n\n"
        + (("in " + task_data_decl) if task_needed else "")
        + "\nvoid main ()\n{\n    gl_PrimitiveCountNV = 1u;\n\n"
        + triangle_for_pixel(pixel, length, "0")
        + "}\n"
    )
    out = {"mesh": mesh}
    if task_needed:
        out["task"] = (
            HEADER
            + "layout (local_size_x=1) in;\n\n"
            + "out " + task_data_decl
            + "\nvoid main ()\n{\n    gl_TaskCountNV = 1u;\n    td.id          = gl_WorkGroupID.x;\n"
            f"    td.size        = {LINEAR_EXTENT[0]};\n"
            "}\n"
        )
    out["frag"] = BASIC_FRAG
    return out


def local_invocation_case(task_needed, variable_id):
    width = LINEAR_EXTENT[0]
    local_index = "gl_LocalInvocationID.x" if variable_id else "gl_LocalInvocationIndex"
    task_data_decl = f"taskNV TaskData {{\n    uint indexNumber[{width}];\n    uint size;\n}} td;\n"
    pixel = "td.indexNumber[gl_WorkGroupID.x]" if task_needed else local_index
    length = "td.size" if task_needed else "gl_WorkGroupSize.x"
    local_size = 1 if task_needed else width
    max_vert = local_size * 3
    base_index = "0" if task_needed else f"({local_index} * 3u)"
    mesh = (
        HEADER
        + f"layout (local_size_x={local_size}) in;\nlayout (triangles) out;\nlayout (max_vertices={max_vert}, max_primitives={local_size}) out;\n\n"
        + (("in " + task_data_decl) if task_needed else "")
        + f"\nvoid main ()\n{{\n    gl_PrimitiveCountNV = {local_size};\n\n"
        + triangle_for_pixel(pixel, length, base_index)
        + "}\n"
    )
    out = {"mesh": mesh}
    if task_needed:
        out["task"] = (
            HEADER
            + f"layout (local_size_x={width}) in;\n\n"
            + "out " + task_data_decl
            + f"\nvoid main ()\n{{\n    gl_TaskCountNV = {width};\n"
            f"    td.indexNumber[{local_index}] = {local_index};\n"
            "    td.size = gl_WorkGroupSize.x;\n"
            "}\n"
        )
    out["frag"] = BASIC_FRAG
    return out


def global_invocation_case(task_needed):
    num_tasks, local_size = LARGE_JOB_SIZE
    width = num_tasks * local_size
    task_data_decl = f"taskNV TaskData {{\n    uint pixelId[{local_size}];\n    uint size;\n}} td;\n"
    pixel = "td.pixelId[gl_LocalInvocationIndex]" if task_needed else "gl_GlobalInvocationID.x"
    length = "td.size" if task_needed else str(width)
    base_index = "(gl_LocalInvocationIndex * 3u)"
    max_vert = local_size * 3
    mesh = (
        HEADER
        + f"layout (local_size_x={local_size}) in;\nlayout (triangles) out;\nlayout (max_vertices={max_vert}, max_primitives={local_size}) out;\n\n"
        + (("in " + task_data_decl) if task_needed else "")
        + f"\nvoid main ()\n{{\n    gl_PrimitiveCountNV = {local_size};\n\n"
        + triangle_for_pixel(pixel, length, base_index)
        + "}\n"
    )
    out = {"mesh": mesh}
    if task_needed:
        out["task"] = (
            HEADER
            + f"layout (local_size_x={local_size}) in;\n\n"
            + "out " + task_data_decl
            + "\nvoid main ()\n{\n    gl_TaskCountNV = 1;\n"
            "    td.pixelId[gl_LocalInvocationIndex] = gl_GlobalInvocationID.x;\n"
            f"    td.size = {width};\n"
            "}\n"
        )
    out["frag"] = BASIC_FRAG
    return out


def draw_index_case(task_needed):
    task_data_decl = "taskNV TaskData {\n    uint id;\n    uint size;\n} td;\n"
    draw_index = "uint(gl_DrawID)"
    pixel = "td.id" if task_needed else draw_index
    length = "td.size" if task_needed else str(LINEAR_EXTENT[0])
    mesh = (
        HEADER
        + "layout (local_size_x=1) in;\nlayout (triangles) out;\nlayout (max_vertices=3, max_primitives=1) out;\n\n"
        + (("in " + task_data_decl) if task_needed else "")
        + "\nvoid main ()\n{\n    gl_PrimitiveCountNV = 1u;\n\n"
        + triangle_for_pixel(pixel, length, "0")
        + "}\n"
    )
    out = {"mesh": mesh}
    if task_needed:
        out["task"] = (
            HEADER
            + "layout (local_size_x=1) in;\n\n"
            + "out " + task_data_decl
            + "\nvoid main ()\n{\n    gl_TaskCountNV = 1u;\n"
            f"    td.id          = {draw_index};\n"
            f"    td.size        = {LINEAR_EXTENT[0]};\n"
            "}\n"
        )
    out["frag"] = BASIC_FRAG
    return out


# FragmentSize order of upstream: SIZE_2X2, SIZE_2X1, SIZE_1X1
FRAGMENT_SIZES = [
    ("2x2", "(gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT)", 5),
    ("2x1", "gl_ShadingRateFlag2HorizontalPixelsEXT", 4),
    ("1x1", "0", 0),
]


def shading_rate_frag(top_mask, bottom_mask):
    half_height = DEFAULT_EXTENT[1] / 2.0
    return (
        HEADER
        + "#extension GL_EXT_fragment_shading_rate : enable\n\n"
        "layout (location=0) out vec4 outColor;\n\nvoid main ()\n{\n"
        f"    const int expectedRate = ((gl_FragCoord.y < {g(half_height)})? {top_mask} : {bottom_mask});\n"
        "    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));\n"
        "}\n"
    )


# (case name, rust const, {stage: source or ("asm", template, derived)})
def build_cases():
    cases = [
        ("position", "NV_BUILTIN_POSITION", position_case()),
        ("point_size", "NV_BUILTIN_POINT_SIZE", point_size_case()),
        ("clip_distance", "NV_BUILTIN_CLIP_DISTANCE", clip_distance_case()),
        ("cull_distance", "NV_BUILTIN_CULL_DISTANCE", cull_distance_case()),
        ("primitive_id_glsl", "NV_BUILTIN_PRIMITIVE_ID_GLSL", primitive_id_glsl_case()),
        ("primitive_id_spirv", "NV_BUILTIN_PRIMITIVE_ID_SPIRV", {"mesh": primitive_id_mesh(), "frag": ("asm", "mesh_shader/nv_builtin_primitive_id_frag.asm", {})}),
        ("layer", "NV_BUILTIN_LAYER", layer_or_viewport_case("layer", K_NUM_LAYERS, False, "gl_Layer", "gl_Layer")),
        ("layer_shared", "NV_BUILTIN_LAYER_SHARED", layer_or_viewport_case("layer", K_NUM_LAYERS, True, "gl_Layer", "gl_Layer")),
        ("viewport_index", "NV_BUILTIN_VIEWPORT_INDEX", layer_or_viewport_case("viewport", K_QUADRANTS, False, "gl_ViewportIndex", "gl_ViewportIndex")),
        ("viewport_index_shared", "NV_BUILTIN_VIEWPORT_INDEX_SHARED", layer_or_viewport_case("viewport", K_QUADRANTS, True, "gl_ViewportIndex", "gl_ViewportIndex")),
        ("work_group_id_in_mesh", "NV_BUILTIN_WORK_GROUP_ID_MESH", work_group_id_case(False)),
        ("work_group_id_in_task", "NV_BUILTIN_WORK_GROUP_ID_TASK", work_group_id_case(True)),
        ("local_invocation_id_in_mesh", "NV_BUILTIN_LOCAL_INVOCATION_ID_MESH", local_invocation_case(False, True)),
        ("local_invocation_id_in_task", "NV_BUILTIN_LOCAL_INVOCATION_ID_TASK", local_invocation_case(True, True)),
        ("local_invocation_index_in_mesh", "NV_BUILTIN_LOCAL_INVOCATION_INDEX_MESH", local_invocation_case(False, False)),
        ("local_invocation_index_in_task", "NV_BUILTIN_LOCAL_INVOCATION_INDEX_TASK", local_invocation_case(True, False)),
        ("global_invocation_id_in_mesh", "NV_BUILTIN_GLOBAL_INVOCATION_ID_MESH", global_invocation_case(False)),
        ("global_invocation_id_in_task", "NV_BUILTIN_GLOBAL_INVOCATION_ID_TASK", global_invocation_case(True)),
        ("draw_index_in_mesh", "NV_BUILTIN_DRAW_INDEX_MESH", draw_index_case(False)),
        ("draw_index_in_task", "NV_BUILTIN_DRAW_INDEX_TASK", draw_index_case(True)),
    ]
    for top_name, top_mask, top_val in FRAGMENT_SIZES:
        for bottom_name, bottom_mask, bottom_val in FRAGMENT_SIZES:
            name = f"primitive_shading_rate_{top_name}_{bottom_name}"
            cases.append(
                (
                    name,
                    "NV_BUILTIN_" + name.upper(),
                    {
                        "mesh": ("asm", "mesh_shader/nv_builtin_shading_rate_mesh.asm", {"TOP": str(top_val), "BOTTOM": str(bottom_val)}),
                        "frag": shading_rate_frag(top_mask, bottom_mask),
                    },
                )
            )
    return cases


def render():
    files = {}
    manifest = [
        "# Shader manifest for dEQP-VK.mesh_shader.nv.builtin.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_mesh_shader_nv_builtin.py - do not hand-edit. The initPrograms of each case class of\n"
        "# vktMeshShaderBuiltinTests.cpp, formatted per case; primitive_id_spirv and the mesh shaders of primitive_shading_rate_* are upstream's assembly.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderBuiltinTests.cpp"\n'
        'rust_module = "mesh_shader/builtin_nv_tests"\n'
    ]
    for name, const, stages in build_cases():
        programs = []
        derived = {}
        for stage, source in stages.items():
            if isinstance(source, tuple):
                _, template, values = source
                programs.append(f'{{ name = "{stage}", template = "{template}", stage = "asm" }}')
                derived.update(values)
            else:
                files[SRC_DIR / f"{name}.{stage}"] = source
                programs.append(f'{{ name = "{stage}", template = "mesh_shader/nv_builtin/{name}.{stage}", stage = "{stage}" }}')
        entry = f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "SharedProgram"\nprograms = [ {", ".join(programs)} ]\n'
        if derived:
            entry += "derived = { " + ", ".join(f'{k} = "{v}"' for k, v in derived.items()) + " }\n"
        manifest.append(entry)
    return files, "".join(manifest)


def main():
    files, manifest = render()
    if "--check" in sys.argv:
        stale = [p for p, text in files.items() if not p.exists() or p.read_text() != text]
        if stale or not MANIFEST.exists() or MANIFEST.read_text() != manifest:
            print("stale:", *stale, MANIFEST)
            return 1
        return 0
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for path, text in files.items():
        path.write_text(text)
    MANIFEST.write_text(manifest)
    print(f"wrote {len(files)} shaders")
    return 0


if __name__ == "__main__":
    sys.exit(main())

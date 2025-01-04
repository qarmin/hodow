#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.mesh_shader.nv.misc.* (vktMeshShaderMiscTests.cpp).

Each case class of upstream builds a task and mesh shader from its parameters; this does the same once per case. The generic
fragment shader is shared. The families written so far: complex_task_data, single_point/line/triangle, max_points/lines/triangles,
many_*_work_groups, no_*, barrier_in_*, the memory barrier cases, custom_attributes, push_constant and maximize_*.

Usage: python3 hodow_cts/scripts/gen_mesh_shader_nv_misc.py [--check]
"""

import hashlib
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "mesh_shader" / "nv_misc"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "mesh_shader_nv_misc.toml"

HEADER = "#version 450\n#extension GL_NV_mesh_shader : enable\n\n"


def g(value):
    """C++ ostream formatting of a float: six significant digits, no trailing zeros."""
    return "%g" % value


FRAG = (
    HEADER
    + "layout (location=0) in perprimitiveNV vec4 primitiveColor;\n"
    "layout (location=0) out vec4 outColor;\n"
    "\n"
    "void main ()\n"
    "{\n"
    "    outColor = primitiveColor;\n"
    "}\n"
)


def complex_task_data():
    decl = (
        "struct RowId {\n    uint id;\n};\n\n"
        "struct WorkGroupData {\n"
        "    float WorkGroupIdPlusOnex1000Iota[10];\n"
        "    RowId rowId;\n"
        "    uvec3 WorkGroupIdPlusOnex2000Iota;\n"
        "    vec2  WorkGroupIdPlusOnex3000Iota;\n"
        "};\n\n"
        "struct ExternalData {\n"
        "    float OneMillion;\n"
        "    uint  TwoMillion;\n"
        "    WorkGroupData workGroupData;\n"
        "};\n\n"
        "${INOUT} taskNV TaskData {\n"
        "    uint yes;\n"
        "    ExternalData externalData;\n"
        "} td;\n"
    )
    task = (
        HEADER
        + "layout (local_size_x=1) in;\n\n"
        + decl.replace("${INOUT}", "out")
        + "\n"
        "void main ()\n{\n"
        "    gl_TaskCountNV = 2u;\n"
        "    td.yes = 1u;\n"
        "    td.externalData.OneMillion = 1000000.0;\n"
        "    td.externalData.TwoMillion = 2000000u;\n"
        "    for (uint i = 0; i < 10; i++) {\n"
        "        td.externalData.workGroupData.WorkGroupIdPlusOnex1000Iota[i] = float((gl_WorkGroupID.x + 1u) * 1000 + i);\n"
        "    }\n"
        "    {\n"
        "        uint baseVal = (gl_WorkGroupID.x + 1u) * 2000;\n"
        "        td.externalData.workGroupData.WorkGroupIdPlusOnex2000Iota = uvec3(baseVal, baseVal + 1, baseVal + 2);\n"
        "    }\n"
        "    {\n"
        "        uint baseVal = (gl_WorkGroupID.x + 1u) * 3000;\n"
        "        td.externalData.workGroupData.WorkGroupIdPlusOnex3000Iota = vec2(baseVal, baseVal + 1);\n"
        "    }\n"
        "    td.externalData.workGroupData.rowId.id = gl_WorkGroupID.x;\n"
        "}\n"
    )
    mesh = (
        HEADER
        + "layout(local_size_x=2) in;\n"
        "layout(triangles) out;\n"
        "layout(max_vertices=4, max_primitives=2) out;\n"
        "\n"
        "layout (location=0) out perprimitiveNV vec4 triangleColor[];\n"
        "\n"
        + decl.replace("${INOUT}", "in")
        + "\n"
        "void main ()\n{\n"
        "    bool dataOK = true;\n"
        "    dataOK = (dataOK && (td.yes == 1u));\n"
        "    dataOK = (dataOK && (td.externalData.OneMillion == 1000000.0 && td.externalData.TwoMillion == 2000000u));\n"
        "    uint rowId = td.externalData.workGroupData.rowId.id;\n"
        "    dataOK = (dataOK && (rowId == 0u || rowId == 1u));\n"
        "\n"
        "    {\n"
        "        uint baseVal = (rowId + 1u) * 1000u;\n"
        "        for (uint i = 0; i < 10; i++) {\n"
        "            if (td.externalData.workGroupData.WorkGroupIdPlusOnex1000Iota[i] != float(baseVal + i)) {\n"
        "                dataOK = false;\n"
        "                break;\n"
        "            }\n"
        "        }\n"
        "    }\n"
        "\n"
        "    {\n"
        "        uint baseVal = (rowId + 1u) * 2000;\n"
        "        uvec3 expected = uvec3(baseVal, baseVal + 1, baseVal + 2);\n"
        "        if (td.externalData.workGroupData.WorkGroupIdPlusOnex2000Iota != expected) {\n"
        "            dataOK = false;\n"
        "        }\n"
        "    }\n"
        "\n"
        "    {\n"
        "        uint baseVal = (rowId + 1u) * 3000;\n"
        "        vec2 expected = vec2(baseVal, baseVal + 1);\n"
        "        if (td.externalData.workGroupData.WorkGroupIdPlusOnex3000Iota != expected) {\n"
        "            dataOK = false;\n"
        "        }\n"
        "    }\n"
        "\n"
        "    uint columnId = gl_WorkGroupID.x;\n"
        "\n"
        "    if (dataOK) {\n"
        "        gl_PrimitiveCountNV = 2u;\n"
        "    }\n"
        "    else {\n"
        "        gl_PrimitiveCountNV = 0u;\n"
        "        return;\n"
        "    }\n"
        "\n"
        "    const vec4 outColor = vec4(rowId, columnId, 1.0f, 1.0f);\n"
        "    triangleColor[0] = outColor;\n"
        "    triangleColor[1] = outColor;\n"
        "\n"
        "    // Each local invocation will generate two points and one triangle from the quad.\n"
        "    // The first local invocation will generate the top quad vertices.\n"
        "    // The second invocation will generate the two bottom vertices.\n"
        "    vec4 left  = vec4(0.0, 0.0, 0.0, 1.0);\n"
        "    vec4 right = vec4(1.0, 0.0, 0.0, 1.0);\n"
        "\n"
        "    float localInvocationOffsetY = float(gl_LocalInvocationID.x);\n"
        "    left.y  += localInvocationOffsetY;\n"
        "    right.y += localInvocationOffsetY;\n"
        "\n"
        "    // The code above creates a quad from (0, 0) to (1, 1) but we need to offset it\n"
        "    // in X and/or Y depending on the row and column, to place it in other quadrants.\n"
        "    float quadrantOffsetX = float(int(columnId) - 1);\n"
        "    float quadrantOffsetY = float(int(rowId) - 1);\n"
        "\n"
        "    left.x  += quadrantOffsetX;\n"
        "    right.x += quadrantOffsetX;\n"
        "\n"
        "    left.y  += quadrantOffsetY;\n"
        "    right.y += quadrantOffsetY;\n"
        "\n"
        "    uint baseVertexId = 2*gl_LocalInvocationID.x;\n"
        "    gl_MeshVerticesNV[baseVertexId + 0].gl_Position = left;\n"
        "    gl_MeshVerticesNV[baseVertexId + 1].gl_Position = right;\n"
        "\n"
        "    uint baseIndexId = 3*gl_LocalInvocationID.x;\n"
        "    // 0,1,2 or 1,2,3 (note: triangles alternate front face this way)\n"
        "    gl_PrimitiveIndicesNV[baseIndexId + 0] = 0 + gl_LocalInvocationID.x;\n"
        "    gl_PrimitiveIndicesNV[baseIndexId + 1] = 1 + gl_LocalInvocationID.x;\n"
        "    gl_PrimitiveIndicesNV[baseIndexId + 2] = 2 + gl_LocalInvocationID.x;\n"
        "}\n"
    )
    return {"task": task, "mesh": mesh, "frag": FRAG}


def single_point():
    mesh = (
        HEADER
        + "layout(local_size_x=1) in;\nlayout(points) out;\nlayout(max_vertices=256, max_primitives=256) out;\n\n"
        "layout (location=0) out perprimitiveNV vec4 pointColor[];\n\n"
        "void main ()\n{\n"
        "    gl_PrimitiveCountNV = 1u;\n"
        "    pointColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);\n"
        "    gl_MeshVerticesNV[0].gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);\n"
        "    gl_MeshVerticesNV[0].gl_PointSize = 1.0f;\n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


def single_line():
    mesh = (
        HEADER
        + "layout(local_size_x=1) in;\nlayout(lines) out;\nlayout(max_vertices=256, max_primitives=256) out;\n\n"
        "layout (location=0) out perprimitiveNV vec4 lineColor[];\n\n"
        "void main ()\n{\n"
        "    gl_PrimitiveCountNV = 1u;\n"
        "    lineColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);\n"
        "    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0f, 0.0f, 0.0f, 1.0f);\n"
        "    gl_MeshVerticesNV[1].gl_Position = vec4( 1.0f, 0.0f, 0.0f, 1.0f);\n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n"
        "    gl_PrimitiveIndicesNV[1] = 1;\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


def single_triangle(width, height):
    half_pixel_x = 2.0 / width
    half_pixel_y = 2.0 / height
    mesh = (
        HEADER
        + "layout(local_size_x=1) in;\nlayout(triangles) out;\nlayout(max_vertices=256, max_primitives=256) out;\n\n"
        "layout (location=0) out perprimitiveNV vec4 triangleColor[];\n\n"
        "void main ()\n{\n"
        "    gl_PrimitiveCountNV = 1u;\n"
        "    triangleColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);\n"
        f"    gl_MeshVerticesNV[0].gl_Position = vec4({g(half_pixel_y)}, {g(-half_pixel_x)}, 0.0f, 1.0f);\n"
        f"    gl_MeshVerticesNV[1].gl_Position = vec4({g(half_pixel_y)}, {g(half_pixel_x)}, 0.0f, 1.0f);\n"
        f"    gl_MeshVerticesNV[2].gl_Position = vec4({g(-half_pixel_y)}, 0.0f, 0.0f, 1.0f);\n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n"
        "    gl_PrimitiveIndicesNV[1] = 1;\n"
        "    gl_PrimitiveIndicesNV[2] = 2;\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


def max_points():
    mesh = (
        HEADER
        + "layout(local_size_x=32) in;\nlayout(points) out;\nlayout(max_vertices=256, max_primitives=256) out;\n\n"
        "layout (location=0) out perprimitiveNV vec4 pointColor[];\n\n"
        "void main ()\n{\n"
        "    gl_PrimitiveCountNV = 256u;\n"
        "    uint firstPixel = 8u * gl_LocalInvocationID.x;\n"
        "    uint row = firstPixel / 16u;\n"
        "    uint col = firstPixel % 16u;\n"
        "    float pixSize = 2.0f / 16.0f;\n"
        "    float yCoord = pixSize * (float(row) + 0.5f) - 1.0f;\n"
        "    float baseXCoord = pixSize * (float(col) + 0.5f) - 1.0f;\n"
        "    for (uint i = 0; i < 8u; i++) {\n"
        "        float xCoord = baseXCoord + pixSize * float(i);\n"
        "        uint pixId = firstPixel + i;\n"
        "        gl_MeshVerticesNV[pixId].gl_Position = vec4(xCoord, yCoord, 0.0f, 1.0f);\n"
        "        gl_MeshVerticesNV[pixId].gl_PointSize = 1.0f;\n"
        "        gl_PrimitiveIndicesNV[pixId] = pixId;\n"
        "        pointColor[pixId] = vec4(((xCoord + 1.0f) / 2.0f), ((yCoord + 1.0f) / 2.0f), 0.0f, 1.0f);\n"
        "    }\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


def max_lines():
    mesh = (
        HEADER
        + "layout(local_size_x=32) in;\nlayout(lines) out;\nlayout(max_vertices=256, max_primitives=255) out;\n\n"
        "layout (location=0) out perprimitiveNV vec4 lineColor[];\n\n"
        "void main ()\n{\n"
        "    gl_PrimitiveCountNV = 255u;\n"
        "    uint firstLine = 8u * gl_LocalInvocationID.x;\n"
        "    for (uint i = 0u; i < 8u; i++) {\n"
        "        uint lineId = firstLine + i;\n"
        "        uint topPixel = 4u * lineId;\n"
        "        uint bottomPixel = 3u + topPixel;\n"
        "        if (bottomPixel < 1020u) {\n"
        "            float bottomCoord = ((float(bottomPixel) + 1.0f) / 1020.0) * 2.0 - 1.0;\n"
        "            gl_MeshVerticesNV[lineId + 1u].gl_Position = vec4(0.0, bottomCoord, 0.0f, 1.0f);\n"
        "            gl_PrimitiveIndicesNV[lineId * 2u] = lineId;\n"
        "            gl_PrimitiveIndicesNV[lineId * 2u + 1u] = lineId + 1u;\n"
        "            lineColor[lineId] = vec4(0.0f, 1.0f, float(lineId) / 255.0f, 1.0f);\n"
        "        } else {\n"
        "            // The last iteration of the last invocation emits the first point\n"
        "            gl_MeshVerticesNV[0].gl_Position = vec4(0.0, -1.0, 0.0f, 1.0f);\n"
        "        }\n"
        "    }\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


def max_triangles():
    mesh = (
        HEADER
        + "layout(local_size_x=32) in;\nlayout(triangles) out;\nlayout(max_vertices=256, max_primitives=254) out;\n\n"
        "layout (location=0) out perprimitiveNV vec4 triangleColor[];\n\n"
        "const float PI_2 = 1.57079632679489661923;\n"
        "const float RADIUS = 4.5;\n"
        "\n"
        "void main ()\n{\n"
        "    gl_PrimitiveCountNV = 254u;\n"
        "    uint firstTriangle = 8u * gl_LocalInvocationID.x;\n"
        "    for (uint i = 0u; i < 8u; i++) {\n"
        "        uint triangleId = firstTriangle + i;\n"
        "        if (triangleId < 254u) {\n"
        "            uint vertexId = triangleId + 2u;\n"
        "            float angleProportion = float(vertexId - 1u) / 254.0f;\n"
        "            float angle = PI_2 * angleProportion;\n"
        "            float xCoord = cos(angle) * RADIUS - 1.0;\n"
        "            float yCoord = sin(angle) * RADIUS - 1.0;\n"
        "            gl_MeshVerticesNV[vertexId].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);\n"
        "            gl_PrimitiveIndicesNV[triangleId * 3u + 0u] = 0u;\n"
        "            gl_PrimitiveIndicesNV[triangleId * 3u + 1u] = triangleId + 1u;\n"
        "            gl_PrimitiveIndicesNV[triangleId * 3u + 2u] = triangleId + 2u;\n"
        "            triangleColor[triangleId] = vec4(0.0f, 0.0f, 1.0f, 1.0f);\n"
        "        } else {\n"
        "            // The last iterations of the last invocation emit the first two vertices\n"
        "            uint vertexId = triangleId - 254u;\n"
        "            if (vertexId == 0u) {\n"
        "                gl_MeshVerticesNV[0u].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n"
        "            } else {\n"
        "                gl_MeshVerticesNV[1u].gl_Position = vec4(RADIUS, -1.0, 0.0, 1.0);\n"
        "            }\n"
        "        }\n"
        "    }\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


LOCAL_INVOCATIONS = 32


def large_work_group(task_count, mesh_count, width, height):
    use_task = task_count is not None
    task_data = f"taskNV TaskData {{\n    uint parentTask[{LOCAL_INVOCATIONS}];\n}} td;\n"
    out = {}
    if use_task:
        out["task"] = (
            HEADER
            + f"layout (local_size_x={LOCAL_INVOCATIONS}) in;\n\n"
            + "out " + task_data + "\n"
            "void main () {\n"
            f"    gl_TaskCountNV = {mesh_count};\n"
            "    td.parentTask[gl_LocalInvocationID.x] = gl_WorkGroupID.x;\n"
            "}\n"
        )
    mesh = (
        HEADER
        + f"layout (local_size_x={LOCAL_INVOCATIONS}) in;\n"
        "layout (points) out;\n"
        f"layout (max_vertices={LOCAL_INVOCATIONS}, max_primitives={LOCAL_INVOCATIONS}) out;\n"
        "\n"
        + (("in " + task_data) if use_task else "")
        + "\n"
        "layout (location=0) out perprimitiveNV vec4 pointColor[];\n"
        "\n"
        "void main () {\n"
    )
    if use_task:
        mesh += "    uint parentTask = td.parentTask[0];\n    if (td.parentTask[gl_LocalInvocationID.x] != parentTask) {\n        return;\n    }\n"
    else:
        mesh += "    uint parentTask = 0;\n"
    mesh += (
        f"    gl_PrimitiveCountNV = {LOCAL_INVOCATIONS};\n"
        f"    uint jobId = ((parentTask * {mesh_count}) + gl_WorkGroupID.x) * {LOCAL_INVOCATIONS} + gl_LocalInvocationID.x;\n"
        f"    uint row = jobId / {width};\n"
        f"    uint col = jobId % {width};\n"
        f"    float yCoord = (float(row + 0.5) / {height}.0) * 2.0 - 1.0;\n"
        f"    float xCoord = (float(col + 0.5) / {width}.0) * 2.0 - 1.0;\n"
        "    gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_PointSize = 1.0;\n"
        "    gl_PrimitiveIndicesNV[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;\n"
        "    pointColor[gl_LocalInvocationID.x] = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "}\n"
    )
    out["mesh"] = mesh
    out["frag"] = FRAG
    return out


def no_primitives(primitive_name):
    mesh = (
        HEADER
        + "layout (local_size_x=32) in;\n"
        f"layout ({primitive_name}) out;\n"
        "layout (max_vertices=256, max_primitives=256) out;\n"
        "\n"
        "layout (location=0) out perprimitiveNV vec4 primitiveColor[];\n"
        "\n"
        "void main () {\n"
        "    gl_PrimitiveCountNV = 0u;\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


def no_primitives_extra_writes(primitive_name):
    task_data = f"taskNV TaskData {{\n    uint localInvocations[{LOCAL_INVOCATIONS}];\n}} td;\n"
    task = (
        HEADER
        + f"layout (local_size_x={LOCAL_INVOCATIONS}) in;\n\n"
        + "out " + task_data + "\n"
        "void main () {\n"
        "    gl_TaskCountNV = 1;\n"
        "    td.localInvocations[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;\n"
        "}\n"
    )
    max_primitives = {"points": LOCAL_INVOCATIONS, "lines": LOCAL_INVOCATIONS - 1, "triangles": LOCAL_INVOCATIONS - 2}[primitive_name]
    point_size_decl = "        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_PointSize = 1.0;\n" if primitive_name == "points" else ""
    mesh = (
        HEADER
        + f"layout (local_size_x={LOCAL_INVOCATIONS}) in;\n"
        f"layout ({primitive_name}) out;\n"
        f"layout (max_vertices={LOCAL_INVOCATIONS}, max_primitives={max_primitives}) out;\n"
        "\n"
        + "in " + task_data + "\n"
        "layout (location=0) out perprimitiveNV vec4 primitiveColor[];\n"
        "\n"
        "shared uint sumOfIds;\n"
        "\n"
        "const float PI_2 = 1.57079632679489661923;\n"
        "const float RADIUS = 1.0f;\n"
        "\n"
        "void main ()\n"
        "{\n"
        "    sumOfIds = 0u;\n"
        "    memoryBarrierShared();\n"
        "    barrier();\n"
        "    atomicAdd(sumOfIds, td.localInvocations[gl_LocalInvocationID.x]);\n"
        "    memoryBarrierShared();\n"
        "    barrier();\n"
        "    // This should dynamically give 0\n"
        f"    gl_PrimitiveCountNV = sumOfIds - ({LOCAL_INVOCATIONS * (LOCAL_INVOCATIONS - 1) // 2});\n"
        "\n"
        "    // Emit points and primitives to the arrays in any case\n"
        "    if (gl_LocalInvocationID.x > 0u) {\n"
        f"        float proportion = (float(gl_LocalInvocationID.x - 1u) + 0.5f) / float({LOCAL_INVOCATIONS} - 1u);\n"
        "        float angle = PI_2 * proportion;\n"
        "        float xCoord = cos(angle) * RADIUS - 1.0;\n"
        "        float yCoord = sin(angle) * RADIUS - 1.0;\n"
        "        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);\n"
        + point_size_decl
        + "    } else {\n"
        "        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n"
        + point_size_decl
        + "    }\n"
        f"    uint primitiveId = max(gl_LocalInvocationID.x, {max_primitives - 1});\n"
        "    primitiveColor[primitiveId] = vec4(0.0, 0.0, 1.0, 1.0);\n"
    )
    if primitive_name == "points":
        mesh += "    gl_PrimitiveIndicesNV[primitiveId] = primitiveId;\n"
    elif primitive_name == "lines":
        mesh += "    gl_PrimitiveIndicesNV[primitiveId * 2u + 0u] = primitiveId + 0u;\n    gl_PrimitiveIndicesNV[primitiveId * 2u + 1u] = primitiveId + 1u;\n"
    else:
        mesh += "    gl_PrimitiveIndicesNV[primitiveId * 3u + 0u] = 0u;\n    gl_PrimitiveIndicesNV[primitiveId * 3u + 1u] = primitiveId + 1u;\n    gl_PrimitiveIndicesNV[primitiveId * 3u + 2u] = primitiveId + 3u;\n"
    mesh += "}\n"
    return {"task": task, "mesh": mesh, "frag": FRAG}


def mesh_template(local_size, globals_, body):
    return (
        HEADER
        + f"layout (local_size_x={local_size}) in;\n"
        "layout (points) out;\n"
        "layout (max_vertices=1, max_primitives=1) out;\n"
        "\n"
        "layout (location=0) out perprimitiveNV vec4 primitiveColor[];\n"
        "\n"
        + globals_
        + "void main ()\n"
        "{\n"
        + body
        + "}\n"
    )


def simple_barrier(use_task):
    mesh_prim = (
        "gl_PrimitiveCountNV = 1u;\n"
        "gl_MeshVerticesNV[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n"
        "gl_MeshVerticesNV[0].gl_PointSize = 1.0;\n"
        "primitiveColor[0] = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "gl_PrimitiveIndicesNV[0] = 0;\n"
    )
    task_ok, task_fail = "gl_TaskCountNV = 1u;\n", "gl_TaskCountNV = 0u;\n"
    mesh_ok, mesh_fail = mesh_prim, "gl_PrimitiveCountNV = 0u;\n"
    ok = task_ok if use_task else mesh_ok
    fail = task_fail if use_task else mesh_fail
    shared_decl = "shared uint counter;\n\n"
    verification = (
        "counter = 0;\n"
        "memoryBarrierShared();\n"
        "barrier();\n"
        "atomicAdd(counter, 1u);\n"
        "memoryBarrierShared();\n"
        "barrier();\n"
        "if (gl_LocalInvocationID.x == 0u) {\n"
        f"    if (counter == {LOCAL_INVOCATIONS}) {{\n"
        "\n"
        + ok
        + "\n"
        "    } else {\n"
        "\n"
        + fail
        + "\n"
        "    }\n"
        "}\n"
    )
    if use_task:
        task = HEADER + f"layout (local_size_x={LOCAL_INVOCATIONS}) in;\n\n" + shared_decl + "void main ()\n{\n" + verification + "}\n"
        return {"task": task, "mesh": mesh_template(1, "", mesh_prim), "frag": FRAG}
    return {"mesh": mesh_template(LOCAL_INVOCATIONS, shared_decl, verification), "frag": FRAG}


def memory_barrier(use_task, func):
    task_data_decl = "taskNV TaskData { float blue; } td;\n\n"
    mesh_prim = (
        "gl_PrimitiveCountNV = 1u;\n"
        "gl_MeshVerticesNV[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n"
        "gl_MeshVerticesNV[0].gl_PointSize = 1.0;\n"
        f"primitiveColor[0] = vec4(0.0, 0.0, {'td.blue' if use_task else 'float(iterations % 2u)'}, 1.0);\n"
        "gl_PrimitiveIndicesNV[0] = 0;\n"
    )
    task_action = "gl_TaskCountNV = 1u;\ntd.blue = float(iterations % 2u);\n"
    action = task_action if use_task else mesh_prim
    shared_decl = "shared uint flags[2];\n\n"
    verification = (
        "flags[gl_LocalInvocationID.x] = 0u;\n"
        "barrier();\n"
        "flags[gl_LocalInvocationID.x] = 1u;\n"
        f"{func}();\n"
        "uint otherInvocation = 1u - gl_LocalInvocationID.x;\n"
        "uint iterations = 0u;\n"
        "while (flags[otherInvocation] != 1u) {\n"
        "    iterations++;\n"
        "}\n"
        "if (gl_LocalInvocationID.x == 0u) {\n"
        "\n"
        + action
        + "\n"
        "}\n"
    )
    local = 2
    if use_task:
        task = HEADER + f"layout (local_size_x={local}) in;\n\n" + shared_decl + "out " + task_data_decl + "void main ()\n{\n" + verification + "}\n"
        return {"task": task, "mesh": mesh_template(1, "in " + task_data_decl, mesh_prim), "frag": FRAG}
    return {"mesh": mesh_template(local, shared_decl, verification), "frag": FRAG}


def push_constant(use_task):
    num_floats = 2 if use_task else 4
    pc_decl = (
        "layout (push_constant, std430) uniform PushConstantBlock {\n"
        f"    layout (offset=${{PCOFFSET}}) float values[{num_floats}];\n"
        "} pc;\n"
        "\n"
    )
    task_data = "taskNV TaskData {\n    float values[2];\n} td;\n\n"
    out = {}
    if use_task:
        out["task"] = (
            HEADER
            + "layout(local_size_x=1) in;\n\n"
            + "out " + task_data + pc_decl.replace("${PCOFFSET}", str(2 * 4))
            + "void main ()\n{\n"
            "    gl_TaskCountNV = 1;\n"
            "\n"
            "    td.values[0] = pc.values[0];\n"
            "    td.values[1] = pc.values[1];\n"
            "}\n"
        )
    blue = "td.values[0] + pc.values[0]" if use_task else "pc.values[0] + pc.values[2]"
    alpha = "td.values[1] + pc.values[1]" if use_task else "pc.values[1] + pc.values[3]"
    out["mesh"] = (
        HEADER
        + "layout(local_size_x=1) in;\n"
        "layout(triangles) out;\n"
        "layout(max_vertices=3, max_primitives=1) out;\n"
        "\n"
        "layout (location=0) out perprimitiveNV vec4 triangleColor[];\n"
        "\n"
        + pc_decl.replace("${PCOFFSET}", "0")
        + (("in " + task_data) if use_task else "")
        + "void main ()\n{\n"
        "    gl_PrimitiveCountNV = 1;\n"
        "\n"
        "    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[1].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[2].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);\n"
        "\n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n"
        "    gl_PrimitiveIndicesNV[1] = 1;\n"
        "    gl_PrimitiveIndicesNV[2] = 2;\n"
        "\n"
        f"    triangleColor[0] = vec4(0.0, 0.0, {blue}, {alpha});\n"
        "}\n"
    )
    out["frag"] = FRAG
    return out


def custom_attributes(use_task):
    frag = (
        HEADER
        + "layout (location=0) in vec4 customAttribute1;\n"
        "layout (location=1) in flat float customAttribute2;\n"
        "layout (location=2) in flat int customAttribute3;\n"
        "\n"
        "layout (location=3) in perprimitiveNV flat uvec4 customAttribute4;\n"
        "layout (location=4) in perprimitiveNV float customAttribute5;\n"
        "\n"
        "layout (location=0) out vec4 outColor;\n"
        "\n"
        "void main ()\n"
        "{\n"
        "    bool goodPrimitiveID = (gl_PrimitiveID == 1000 || gl_PrimitiveID == 1001);\n"
        "    bool goodViewportIndex = (gl_ViewportIndex == 1);\n"
        "    bool goodCustom1 = (customAttribute1.x >= 0.25 && customAttribute1.x <= 0.5 &&\n"
        "                        customAttribute1.y >= 0.5  && customAttribute1.y <= 1.0 &&\n"
        "                        customAttribute1.z >= 10.0 && customAttribute1.z <= 20.0 &&\n"
        "                        customAttribute1.w == 3.0);\n"
        "    bool goodCustom2 = (customAttribute2 == 1.0 || customAttribute2 == 2.0);\n"
        "    bool goodCustom3 = (customAttribute3 == 3 || customAttribute3 == 4);\n"
        "    bool goodCustom4 = ((gl_PrimitiveID == 1000 && customAttribute4 == uvec4(100, 101, 102, 103)) ||\n"
        "                        (gl_PrimitiveID == 1001 && customAttribute4 == uvec4(200, 201, 202, 203)));\n"
        "    bool goodCustom5 = ((gl_PrimitiveID == 1000 && customAttribute5 == 6.0) ||\n"
        "                        (gl_PrimitiveID == 1001 && customAttribute5 == 7.0));\n"
        "    \n"
        "    if (goodPrimitiveID && goodViewportIndex && goodCustom1 && goodCustom2 && goodCustom3 && goodCustom4 && goodCustom5) {\n"
        "        outColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "    } else {\n"
        "        outColor = vec4(0.0, 0.0, 0.0, 1.0);\n"
        "    }\n"
        "}\n"
    )
    pvd_decl = (
        "    vec4 positions[4];\n"
        "    float pointSizes[4];\n"
        "    float clipDistances[4];\n"
        "    vec4 custom1[4];\n"
        "    float custom2[4];\n"
        "    int custom3[4];\n"
    )
    ppd_decl = (
        "    int primitiveIds[2];\n"
        "    int viewportIndices[2];\n"
        "    uvec4 custom4[2];\n"
        "    float custom5[2];\n"
    )
    bindings_decl = (
        "layout (set=0, binding=0, std430) buffer PerVertexData {\n"
        + pvd_decl
        + "} pvd;\n"
        "layout (set=0, binding=1) uniform PerPrimitiveData {\n"
        + ppd_decl
        + "} ppd;\n"
        "\n"
    )
    task_data_decl = "taskNV TaskData {\n" + pvd_decl + ppd_decl + "} td;\n\n"
    pvd = "td" if use_task else "pvd"
    ppd = "td" if use_task else "ppd"
    mesh = (
        HEADER
        + "layout (local_size_x=1) in;\n"
        "layout (max_primitives=2, max_vertices=4) out;\n"
        "layout (triangles) out;\n"
        "\n"
        "out gl_MeshPerVertexNV {\n"
        "    vec4  gl_Position;\n"
        "    float gl_PointSize;\n"
        "    float gl_ClipDistance[1];\n"
        "} gl_MeshVerticesNV[];\n"
        "\n"
        "layout (location=0) out vec4 customAttribute1[];\n"
        "layout (location=1) out flat float customAttribute2[];\n"
        "layout (location=2) out int customAttribute3[];\n"
        "\n"
        "layout (location=3) out perprimitiveNV uvec4 customAttribute4[];\n"
        "layout (location=4) out perprimitiveNV float customAttribute5[];\n"
        "\n"
        "out perprimitiveNV gl_MeshPerPrimitiveNV {\n"
        "  int gl_PrimitiveID;\n"
        "  int gl_ViewportIndex;\n"
        "} gl_MeshPrimitivesNV[];\n"
        "\n"
        + (("in " + task_data_decl) if use_task else bindings_decl)
        + "void main ()\n"
        "{\n"
        "    gl_PrimitiveCountNV = 2u;\n"
        "\n"
        f"    gl_MeshVerticesNV[0].gl_Position = {pvd}.positions[0]; //vec4(-1.0, -1.0, 0.0, 1.0)\n"
        f"    gl_MeshVerticesNV[1].gl_Position = {pvd}.positions[1]; //vec4( 1.0, -1.0, 0.0, 1.0)\n"
        f"    gl_MeshVerticesNV[2].gl_Position = {pvd}.positions[2]; //vec4(-1.0,  1.0, 0.0, 1.0)\n"
        f"    gl_MeshVerticesNV[3].gl_Position = {pvd}.positions[3]; //vec4( 1.0,  1.0, 0.0, 1.0)\n"
        "\n"
        f"    gl_MeshVerticesNV[0].gl_PointSize = {pvd}.pointSizes[0]; //1.0\n"
        f"    gl_MeshVerticesNV[1].gl_PointSize = {pvd}.pointSizes[1]; //1.0\n"
        f"    gl_MeshVerticesNV[2].gl_PointSize = {pvd}.pointSizes[2]; //1.0\n"
        f"    gl_MeshVerticesNV[3].gl_PointSize = {pvd}.pointSizes[3]; //1.0\n"
        "\n"
        "    // Remove geometry on the right side.\n"
        f"    gl_MeshVerticesNV[0].gl_ClipDistance[0] = {pvd}.clipDistances[0]; // 1.0\n"
        f"    gl_MeshVerticesNV[1].gl_ClipDistance[0] = {pvd}.clipDistances[1]; //-1.0\n"
        f"    gl_MeshVerticesNV[2].gl_ClipDistance[0] = {pvd}.clipDistances[2]; // 1.0\n"
        f"    gl_MeshVerticesNV[3].gl_ClipDistance[0] = {pvd}.clipDistances[3]; //-1.0\n"
        "    \n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n"
        "    gl_PrimitiveIndicesNV[1] = 2;\n"
        "    gl_PrimitiveIndicesNV[2] = 1;\n"
        "\n"
        "    gl_PrimitiveIndicesNV[3] = 2;\n"
        "    gl_PrimitiveIndicesNV[4] = 3;\n"
        "    gl_PrimitiveIndicesNV[5] = 1;\n"
        "\n"
        f"    gl_MeshPrimitivesNV[0].gl_PrimitiveID = {ppd}.primitiveIds[0]; //1000\n"
        f"    gl_MeshPrimitivesNV[1].gl_PrimitiveID = {ppd}.primitiveIds[1]; //1001\n"
        "\n"
        f"    gl_MeshPrimitivesNV[0].gl_ViewportIndex = {ppd}.viewportIndices[0]; //1\n"
        f"    gl_MeshPrimitivesNV[1].gl_ViewportIndex = {ppd}.viewportIndices[1]; //1\n"
        "\n"
        "    // Custom per-vertex attributes\n"
        f"    customAttribute1[0] = {pvd}.custom1[0]; //vec4(0.25, 0.5, 10.0, 3.0)\n"
        f"    customAttribute1[1] = {pvd}.custom1[1]; //vec4(0.25, 1.0, 20.0, 3.0)\n"
        f"    customAttribute1[2] = {pvd}.custom1[2]; //vec4( 0.5, 0.5, 20.0, 3.0)\n"
        f"    customAttribute1[3] = {pvd}.custom1[3]; //vec4( 0.5, 1.0, 10.0, 3.0)\n"
        "\n"
        f"    customAttribute2[0] = {pvd}.custom2[0]; //1.0f\n"
        f"    customAttribute2[1] = {pvd}.custom2[1]; //1.0f\n"
        f"    customAttribute2[2] = {pvd}.custom2[2]; //2.0f\n"
        f"    customAttribute2[3] = {pvd}.custom2[3]; //2.0f\n"
        "\n"
        f"    customAttribute3[0] = {pvd}.custom3[0]; //3\n"
        f"    customAttribute3[1] = {pvd}.custom3[1]; //3\n"
        f"    customAttribute3[2] = {pvd}.custom3[2]; //4\n"
        f"    customAttribute3[3] = {pvd}.custom3[3]; //4\n"
        "\n"
        "    // Custom per-primitive attributes.\n"
        f"    customAttribute4[0] = {ppd}.custom4[0]; //uvec4(100, 101, 102, 103)\n"
        f"    customAttribute4[1] = {ppd}.custom4[1]; //uvec4(200, 201, 202, 203)\n"
        "\n"
        f"    customAttribute5[0] = {ppd}.custom5[0]; //6.0\n"
        f"    customAttribute5[1] = {ppd}.custom5[1]; //7.0\n"
        "}\n"
    )
    out = {}
    if use_task:
        copies = ""
        for name, count in (("positions", 4), ("pointSizes", 4), ("clipDistances", 4), ("custom1", 4), ("custom2", 4), ("custom3", 4)):
            copies += "".join(f"    td.{name}[{i}] = pvd.{name}[{i}];\n" for i in range(count)) + "\n"
        for name, count in (("primitiveIds", 2), ("viewportIndices", 2), ("custom4", 2), ("custom5", 2)):
            copies += "".join(f"    td.{name}[{i}] = ppd.{name}[{i}];\n" for i in range(count)) + "\n"
        out["task"] = (
            HEADER
            + "out " + task_data_decl + bindings_decl
            + "void main ()\n{\n"
            "    gl_TaskCountNV = 1;\n"
            "\n"
            + copies.rstrip("\n")
            + "\n}\n"
        )
    out["mesh"] = mesh
    out["frag"] = frag
    return out


def maximize_primitives(local_size, num_vertices, num_primitives, width):
    vertices_per_invocation = num_vertices // local_size
    primitives_per_vertex = num_primitives // num_vertices
    mesh = (
        HEADER
        + f"layout(local_size_x={local_size}) in;\n"
        "layout(points) out;\n"
        f"layout(max_vertices={num_vertices}, max_primitives={num_primitives}) out;\n"
        "\n"
        "layout (location=0) out perprimitiveNV vec4 pointColor[];\n"
        "\n"
        f"const uint verticesPerInvocation = {vertices_per_invocation};\n"
        f"const uint primitivesPerVertex   = {primitives_per_vertex};\n"
        "\n"
        "vec4 colors[primitivesPerVertex] = vec4[](\n"
        "    vec4(0.0, 0.0, 1.0, 1.0),\n"
        "    vec4(1.0, 0.0, 0.0, 1.0)\n"
        ");\n"
        "void main ()\n"
        "{\n"
        f"    gl_PrimitiveCountNV = {num_primitives};\n"
        "    const uint firstVertex = gl_LocalInvocationIndex * verticesPerInvocation;\n"
        "    for (uint i = 0u; i < verticesPerInvocation; ++i)\n"
        "    {\n"
        "        const uint vertexNumber = firstVertex + i;\n"
        f"        const float xCoord = ((float(vertexNumber) + 0.5) / {width}.0) * 2.0 - 1.0;\n"
        "        const float yCoord = 0.0;\n"
        "        gl_MeshVerticesNV[vertexNumber].gl_Position = vec4(xCoord, yCoord, 0.0f, 1.0f);\n"
        "        gl_MeshVerticesNV[vertexNumber].gl_PointSize = 1.0f;\n"
        "        for (uint j = 0u; j < primitivesPerVertex; ++j)\n"
        "        {\n"
        "            const uint primitiveNumber = vertexNumber * primitivesPerVertex + j;\n"
        "            gl_PrimitiveIndicesNV[primitiveNumber] = vertexNumber;\n"
        "            pointColor[primitiveNumber] = colors[j];\n"
        "        }\n"
        "    }\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


def maximize_vertices(local_size, num_vertices, num_primitives, width):
    pixels_per_invocation = width // local_size
    vertices_per_pixel = 4
    primitives_per_pixel = 2
    vertices_per_invocation = pixels_per_invocation * vertices_per_pixel
    primitives_per_invocation = pixels_per_invocation * primitives_per_pixel
    mesh = (
        HEADER
        + f"layout(local_size_x={local_size}) in;\n"
        "layout(triangles) out;\n"
        f"layout(max_vertices={num_vertices}, max_primitives={num_primitives}) out;\n"
        "\n"
        "layout (location=0) out perprimitiveNV vec4 triangleColor[];\n"
        "\n"
        f"const uint pixelsPerInvocation     = {pixels_per_invocation};\n"
        f"const uint verticesPerInvocation   = {vertices_per_invocation};\n"
        f"const uint primitivesPerInvocation = {primitives_per_invocation};\n"
        "const uint indicesPerInvocation    = primitivesPerInvocation * 3u;\n"
        f"const uint verticesPerPixel        = {vertices_per_pixel};\n"
        f"const uint primitivesPerPixel      = {primitives_per_pixel};\n"
        "const uint indicesPerPixel         = primitivesPerPixel * 3u;\n"
        "\n"
        "void main ()\n"
        "{\n"
        f"    gl_PrimitiveCountNV = {num_primitives};\n"
        "\n"
        "    const uint firstPixel    = gl_LocalInvocationIndex * pixelsPerInvocation;\n"
        f"    const float pixelWidth   = 2.0 / float({width});\n"
        "    const float quarterWidth = pixelWidth / 4.0;\n"
        "\n"
        "    for (uint pixelIdx = 0u; pixelIdx < pixelsPerInvocation; ++pixelIdx)\n"
        "    {\n"
        "        const uint pixelId      = firstPixel + pixelIdx;\n"
        f"        const float pixelCenter = (float(pixelId) + 0.5) / float({width}) * 2.0 - 1.0;\n"
        "        const float left        = pixelCenter - quarterWidth;\n"
        "        const float right       = pixelCenter + quarterWidth;\n"
        "\n"
        "        const uint firstVertex = gl_LocalInvocationIndex * verticesPerInvocation + pixelIdx * verticesPerPixel;\n"
        "        gl_MeshVerticesNV[firstVertex + 0].gl_Position = vec4(left,  -1.0, 0.0f, 1.0f);\n"
        "        gl_MeshVerticesNV[firstVertex + 1].gl_Position = vec4(left,   1.0, 0.0f, 1.0f);\n"
        "        gl_MeshVerticesNV[firstVertex + 2].gl_Position = vec4(right, -1.0, 0.0f, 1.0f);\n"
        "        gl_MeshVerticesNV[firstVertex + 3].gl_Position = vec4(right,  1.0, 0.0f, 1.0f);\n"
        "\n"
        "        const uint firstPrimitive = gl_LocalInvocationIndex * primitivesPerInvocation + pixelIdx * primitivesPerPixel;\n"
        "        triangleColor[firstPrimitive + 0] = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "        triangleColor[firstPrimitive + 1] = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "\n"
        "        const uint firstIndex = gl_LocalInvocationIndex * indicesPerInvocation + pixelIdx * indicesPerPixel;\n"
        "        gl_PrimitiveIndicesNV[firstIndex + 0] = firstVertex + 0;\n"
        "        gl_PrimitiveIndicesNV[firstIndex + 1] = firstVertex + 1;\n"
        "        gl_PrimitiveIndicesNV[firstIndex + 2] = firstVertex + 2;\n"
        "        gl_PrimitiveIndicesNV[firstIndex + 3] = firstVertex + 1;\n"
        "        gl_PrimitiveIndicesNV[firstIndex + 4] = firstVertex + 3;\n"
        "        gl_PrimitiveIndicesNV[firstIndex + 5] = firstVertex + 2;\n"
        "    }\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}


def maximize_invocations(local_size, num_vertices, num_primitives, width):
    mesh = (
        HEADER
        + f"layout(local_size_x={local_size}) in;\n"
        "layout(points) out;\n"
        f"layout(max_vertices={num_vertices}, max_primitives={num_primitives}) out;\n"
        "\n"
        "layout (location=0) out perprimitiveNV vec4 pointColor[];\n"
        "\n"
        "void main ()\n"
        "{\n"
        f"    gl_PrimitiveCountNV = {num_primitives};\n"
        "    const uint pixelId = gl_LocalInvocationIndex / 2u;\n"
        "    if (gl_LocalInvocationIndex % 2u == 0u)\n"
        "    {\n"
        f"        const float xCoord = (float(pixelId) + 0.5) / float({width}) * 2.0 - 1.0;\n"
        "        gl_MeshVerticesNV[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);\n"
        "        gl_MeshVerticesNV[pixelId].gl_PointSize = 1.0f;\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "        gl_PrimitiveIndicesNV[pixelId] = pixelId;\n"
        "        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "    }\n"
        "}\n"
    )
    return {"mesh": mesh, "frag": FRAG}



CASES = [
    ("complex_task_data", complex_task_data()),
    ("single_point", single_point()),
    ("single_line", single_line()),
    ("single_triangle", single_triangle(5, 7)),
    ("max_points", max_points()),
    ("max_lines", max_lines()),
    ("max_triangles", max_triangles()),
    ("many_task_work_groups", large_work_group(65535, 1, 1360, 1542)),
    ("many_mesh_work_groups", large_work_group(None, 65535, 1360, 1542)),
    ("many_task_mesh_work_groups", large_work_group(512, 512, 4096, 2048)),
]
for _extra in (False, True):
    for _prim in ("points", "lines", "triangles"):
        CASES.append((f"no_{_prim}" + ("_extra_writes" if _extra else ""), no_primitives_extra_writes(_prim) if _extra else no_primitives(_prim)))
for _task in (True, False):
    CASES.append(("barrier_in_" + ("task" if _task else "mesh"), simple_barrier(_task)))
for _case_name, _func in (("memory_barrier_shared", "memoryBarrierShared"), ("group_memory_barrier", "groupMemoryBarrier")):
    for _task in (True, False):
        CASES.append((f"{_case_name}_in_" + ("task" if _task else "mesh"), memory_barrier(_task, _func)))
for _task in (False, True):
    CASES.append(("custom_attributes" + ("_and_task_shader" if _task else ""), custom_attributes(_task)))
for _task in (False, True):
    CASES.append(("push_constant" + ("_and_task_shader" if _task else ""), push_constant(_task)))
CASES.append(("maximize_primitives", maximize_primitives(32, 128, 256, 128)))
CASES.append(("maximize_vertices", maximize_vertices(32, 256, 128, 64)))
for _invocations in (32, 64, 128, 256):
    CASES.append((f"maximize_invocations_{_invocations}", maximize_invocations(_invocations, _invocations // 2, _invocations // 2, _invocations // 2)))


def render():
    files = {}
    manifest = [
        "# Shader manifest for dEQP-VK.mesh_shader.nv.misc.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_mesh_shader_nv_misc.py - do not hand-edit. The initPrograms of the case classes of\n"
        "# vktMeshShaderMiscTests.cpp, formatted per case.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderMiscTests.cpp"\n'
        'rust_module = "mesh_shader/misc_nv_tests"\n'
    ]
    for name, stages in CASES:
        programs = []
        for stage, source in stages.items():
            if stage == "frag":
                digest = hashlib.sha1(source.encode()).hexdigest()[:8]
                files[SRC_DIR / f"frag_{digest}.frag"] = source
                programs.append(f'{{ name = "frag", template = "mesh_shader/nv_misc/frag_{digest}.frag", stage = "frag" }}')
            else:
                files[SRC_DIR / f"{name}.{stage}"] = source
                programs.append(f'{{ name = "{stage}", template = "mesh_shader/nv_misc/{name}.{stage}", stage = "{stage}" }}')
        manifest.append(f'\n[[case]]\nname = "{name}"\nrust_const = "NV_MISC_{name.upper()}"\nrust_type = "SharedProgram"\nprograms = [ {", ".join(programs)} ]\n')
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
    print(f"wrote {len(CASES)} cases, {len(files)} shaders")
    return 0


if __name__ == "__main__":
    sys.exit(main())

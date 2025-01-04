#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.dgc.ext.graphics.mesh.token_draw[_count] (`DGCMeshDrawCase::initPrograms` of
vktDGCGraphicsMeshTestsExt.cpp): one shared program set per (indirect, task shader, execution set) combination. A pure text generator: no
glslang, no cargo."""

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "shaders" / "manifest" / "dgc_mesh_draw.toml"
SRC_DIR = ROOT / "shaders" / "src" / "dgc"

WIDTH = 32
HEIGHT = 32
PER_TRIANGLE_VERTICES = 3
SPV = ', spirv_version = "spirv1.4"'

WG_INDEX_FUNC = (
    "uint getWorkGroupIndex (void) {\n"
    "    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +\n"
    "                                gl_NumWorkGroups.x * gl_WorkGroupID.y +\n"
    "                                gl_WorkGroupID.x;\n"
    "    return workGroupIndex;\n"
    "}\n"
)

PC_DECL = (
    "layout (push_constant, std430) uniform PushConstantBlock {\n"
    "    uint width;\n"
    "    uint height;\n"
    "    uint baseDrawIndex;\n"
    "} pc;\n"
)

TASK_DATA_DECL = (
    "struct TaskData {\n"
    "    uint rowIndex;          // Set by first task invocation.\n"
    f"    uint columnIndices[{WIDTH}]; // 2 of these items per task invocation.\n"
    "};\n"
    "taskPayloadSharedEXT TaskData td;\n"
)

DIRECT_DRAW_DATA_DECL = (
    "layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {\n"
    "    uint baseRow[];\n"
    "} directDrawData;\n"
)


def frag(blue):
    return (
        "#version 460\n"
        "#extension GL_EXT_mesh_shader : enable\n"
        "\n"
        "layout (location=0) in perprimitiveEXT float redColor;\n"
        "layout (location=1) in flat float greenColor;\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main(void) {\n"
        f"    const float blueColor = {blue};\n"
        "    outColor = vec4(redColor, greenColor, blueColor, 1.0);\n"
        "}\n"
    )


def mesh(task_shader, indirect, red, green):
    max_vertices = PER_TRIANGLE_VERTICES if task_shader else PER_TRIANGLE_VERTICES * WIDTH
    max_primitives = 1 if task_shader else WIDTH
    local_size = 1 if task_shader else 32
    draw_id = " + uint(gl_DrawID)" if indirect else ""
    row_index = "td.rowIndex" if task_shader else f"directDrawData.baseRow[pc.baseDrawIndex{draw_id}] + wgIndex"
    src_prim = "td.columnIndices[wgIndex]" if task_shader else "gl_LocalInvocationIndex"
    return (
        "#version 460\n"
        "#extension GL_EXT_mesh_shader : enable\n"
        "\n"
        "struct VertexData {\n"
        "    vec4 position;\n"
        "    vec4 extraData;\n"
        "};\n"
        "\n"
        "layout(set=0, binding=0, std430) readonly buffer VertexDataBlock {\n"
        "    VertexData vertexData[];\n"
        "} vtxData;\n"
        + DIRECT_DRAW_DATA_DECL
        + "\n"
        + (TASK_DATA_DECL if task_shader else "")
        + PC_DECL
        + "\n"
        f"layout(local_size_x={local_size}) in;\n"
        "layout(triangles) out;\n"
        f"layout(max_vertices={max_vertices}, max_primitives={max_primitives}) out;\n"
        "\n"
        "layout (location=0) out perprimitiveEXT float redColor[];\n"
        "layout (location=1) out flat float greenColor[];\n"
        "\n"
        + WG_INDEX_FUNC
        + "\n"
        "void main() {\n"
        f"    const uint triangleVertices = {PER_TRIANGLE_VERTICES};\n"
        "    const uint wgIndex = getWorkGroupIndex();\n"
        f"    const uint rowIndex = {row_index};\n"
        "    const uint srcBasePrim = rowIndex * pc.width;\n"
        f"    const uint srcPrim = srcBasePrim + {src_prim};\n"
        "    const uint srcBaseVertex = srcPrim * triangleVertices;\n"
        "    const uint dstPrim = gl_LocalInvocationIndex;\n"
        "    const uint dstBaseVertex = dstPrim * triangleVertices;\n"
        f"    SetMeshOutputsEXT({max_vertices}, {max_primitives});\n"
        "    for (uint i = 0u; i < triangleVertices; ++i) {\n"
        "        const uint dstIdx = dstBaseVertex + i;\n"
        "        const uint srcIdx = srcBaseVertex + i;\n"
        "        gl_MeshVerticesEXT[dstIdx].gl_Position = vtxData.vertexData[srcIdx].position;\n"
        "        gl_MeshVerticesEXT[dstIdx].gl_PointSize = 1.0;\n"
        "        gl_MeshVerticesEXT[dstIdx].gl_ClipDistance[0] = vtxData.vertexData[srcIdx].extraData.x;\n"
        "        gl_MeshVerticesEXT[dstIdx].gl_CullDistance[0] = vtxData.vertexData[srcIdx].extraData.y;\n"
        f"        greenColor[dstIdx] = {green};\n"
        "    }\n"
        "    gl_PrimitiveTriangleIndicesEXT[dstPrim] = uvec3(dstBaseVertex + 0, dstBaseVertex + 1, dstBaseVertex + 2);\n"
        f"    redColor[dstPrim] = {red};\n"
        "}\n"
    )


def task(indirect, index):
    local_size = WIDTH // 2
    value_offset = 0 if index == 0 else WIDTH - 1
    value_factor = 1 if index == 0 else -1
    draw_id = " + uint(gl_DrawID)" if indirect else ""
    return (
        "#version 460\n"
        "#extension GL_EXT_mesh_shader : enable\n"
        "\n"
        + DIRECT_DRAW_DATA_DECL
        + f"layout (set=0, binding=2, std430) readonly buffer CoverageBlock {{ uint colsPerRow[{HEIGHT}]; }} cb;\n"
        "\n"
        + TASK_DATA_DECL
        + "\n"
        + PC_DECL
        + "\n"
        f"layout(local_size_x={local_size}) in;\n"
        "\n"
        + WG_INDEX_FUNC
        + "\n"
        "void main() {\n"
        "    const uint wgIndex = getWorkGroupIndex();\n"
        f"    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex{draw_id}] + wgIndex;\n"
        "    td.rowIndex = rowIndex;\n"
        "    const uint baseEntryIdx = gl_LocalInvocationIndex * 2u;\n"
        "    for (uint i = 0u; i < 2u; ++i) {\n"
        "        const uint idx = baseEntryIdx + i;\n"
        f"        const uint value = uint({value_offset} + (({value_factor}) * int(idx)));\n"
        "        td.columnIndices[idx] = value;\n"
        "    }\n"
        "    EmitMeshTasksEXT(cb.colsPerRow[rowIndex], 1, 1);\n"
        "}\n"
    )


def entry(name, file, stage):
    spv = SPV if stage in ("task", "mesh", "frag") else ""
    return f'{{ name = "{name}", template = "dgc/{file}", stage = "{stage}"{spv} }}'


def fmt(value):
    return ("%g" % value)


def main():
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    manifest = (
        "# Shader manifest for dEQP-VK.dgc.ext.graphics.mesh.token_draw and token_draw_count\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_dgc_mesh_draw_manifest.py - do not hand-edit.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMeshTestsExt.cpp"\n'
        'rust_module = "dgc/graphics_mesh_draw_tests"\n'
    )
    for indirect in (False, True):
        for task_shader in (False, True):
            for ies in (False, True):
                suffix = ("_ind" if indirect else "") + ("_task" if task_shader else "") + ("_ies" if ies else "")
                blue = [1.0] + ([0.5] if ies else [])
                green = [0.0] + ([1.0] if ies else [])
                red = [0.25] + ([0.75] if ies else [])
                programs = []
                for i, value in enumerate(blue):
                    file = f"mesh_draw{suffix}_frag{i}.frag"
                    (SRC_DIR / file).write_text(frag(fmt(value)))
                    programs.append(entry(f"frag{i}", file, "frag"))
                for i in range(len(red)):
                    file = f"mesh_draw{suffix}_mesh{i}.mesh"
                    (SRC_DIR / file).write_text(mesh(task_shader, indirect, fmt(red[i]), fmt(green[i])))
                    programs.append(entry(f"mesh{i}", file, "mesh"))
                if task_shader:
                    for i in range(2 if ies else 1):
                        file = f"mesh_draw{suffix}_task{i}.task"
                        (SRC_DIR / file).write_text(task(indirect, i))
                        programs.append(entry(f"task{i}", file, "task"))
                name = f"mesh_draw{suffix}"
                manifest += (
                    f'\n[[case]]\nname = "{name}"\nrust_const = "{name.upper()}"\nrust_type = "SharedProgram"\n'
                    f"programs = [ {', '.join(programs)} ]\n"
                )
    MANIFEST.write_text(manifest)
    print(f"wrote {MANIFEST}")


if __name__ == "__main__":
    main()

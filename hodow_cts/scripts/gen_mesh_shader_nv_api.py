#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.mesh_shader.nv.api.* (MeshApiCase::initPrograms of vktMeshShaderApiTests.cpp).

The shaders depend only on whether the case has a task shader (the first task comes in through a push constant), so there are
two program sets.

Usage: python3 hodow_cts/scripts/gen_mesh_shader_nv_api.py [--check]
"""

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "mesh_shader" / "nv_api"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "mesh_shader_nv_api.toml"

TASK_DATA_DECL = "taskNV TaskData {\n    uint blockNumber;\n    uint blockRow;\n} td;\n"


def task_shader():
    return (
        "#version 460\n"
        "#extension GL_NV_mesh_shader : enable\n"
        "\n"
        "layout (local_size_x=1) in;\n"
        "\n"
        "layout (push_constant, std430) uniform TaskPushConstantBlock {\n"
        "    layout (offset=12) uint one;\n"
        "    layout (offset=16) uint firstTask;\n"
        "} pc;\n"
        "\n"
        f"out {TASK_DATA_DECL}"
        "\n"
        "void main ()\n"
        "{\n"
        "    gl_TaskCountNV  = pc.one;\n"
        "    td.blockNumber  = uint(gl_DrawID);\n"
        "    td.blockRow     = gl_WorkGroupID.x - pc.firstTask;\n"
        "}\n"
    )


def mesh_shader(use_task):
    task_in = ("in " + TASK_DATA_DECL) if use_task else ""
    block_number = "td.blockNumber" if use_task else "uint(gl_DrawID)"
    block_row = "td.blockRow" if use_task else "(gl_WorkGroupID.x - pc.firstTask)"
    return (
        "#version 460\n"
        "#extension GL_NV_mesh_shader : enable\n"
        "\n"
        "layout (local_size_x=32) in;\n"
        "layout (triangles) out;\n"
        "layout (max_vertices=96, max_primitives=32) out;\n"
        "\n"
        "layout (push_constant, std430) uniform MeshPushConstantBlock {\n"
        "    uint width;\n"
        "    uint height;\n"
        "    uint firstTask;\n"
        "} pc;\n"
        "\n"
        "layout (location=0) perprimitiveNV out vec4 primitiveColor[];\n"
        "\n"
        f"{task_in}"
        "\n"
        "layout (set=0, binding=0, std430) readonly buffer BlockSizes {\n"
        "    uint blockSize[];\n"
        "} bsz;\n"
        "\n"
        "uint startOfBlock (uint blockNumber)\n"
        "{\n"
        "    uint start = 0;\n"
        "    for (uint i = 0; i < blockNumber; i++)\n"
        "        start += bsz.blockSize[i];\n"
        "    return start;\n"
        "}\n"
        "\n"
        "void main ()\n"
        "{\n"
        f"    const uint blockNumber = {block_number};\n"
        f"    const uint blockRow = {block_row};\n"
        "\n"
        "    // Each workgroup will fill one row, and each invocation will generate a\n"
        "    // triangle around the pixel center in each column.\n"
        "    const uint row = startOfBlock(blockNumber) + blockRow;\n"
        "    const uint col = gl_LocalInvocationID.x;\n"
        "\n"
        "    const float fHeight = float(pc.height);\n"
        "    const float fWidth = float(pc.width);\n"
        "\n"
        "    // Pixel coordinates, normalized.\n"
        "    const float rowNorm = (float(row) + 0.5) / fHeight;\n"
        "    const float colNorm = (float(col) + 0.5) / fWidth;\n"
        "\n"
        "    // Framebuffer coordinates.\n"
        "    const float coordX = (colNorm * 2.0) - 1.0;\n"
        "    const float coordY = (rowNorm * 2.0) - 1.0;\n"
        "\n"
        "    const float pixelWidth = 2.0 / fWidth;\n"
        "    const float pixelHeight = 2.0 / fHeight;\n"
        "\n"
        "    const float offsetX = pixelWidth / 2.0;\n"
        "    const float offsetY = pixelHeight / 2.0;\n"
        "\n"
        "    const uint baseIndex = col*3;\n"
        "    const uvec3 indices = uvec3(baseIndex, baseIndex + 1, baseIndex + 2);\n"
        "\n"
        "    gl_PrimitiveCountNV = 32u;\n"
        "    primitiveColor[col] = vec4(rowNorm, colNorm, 0.0, 1.0);\n"
        "\n"
        "    gl_PrimitiveIndicesNV[indices.x] = indices.x;\n"
        "    gl_PrimitiveIndicesNV[indices.y] = indices.y;\n"
        "    gl_PrimitiveIndicesNV[indices.z] = indices.z;\n"
        "\n"
        "    gl_MeshVerticesNV[indices.x].gl_Position = vec4(coordX - offsetX, coordY + offsetY, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[indices.y].gl_Position = vec4(coordX + offsetX, coordY + offsetY, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[indices.z].gl_Position = vec4(coordX, coordY - offsetY, 0.0, 1.0);\n"
        "}\n"
    )


FRAG_SHADER = (
    "#version 460\n"
    "#extension GL_NV_mesh_shader : enable\n"
    "\n"
    "layout (location=0) perprimitiveNV in vec4 primitiveColor;\n"
    "layout (location=0) out vec4 outColor;\n"
    "\n"
    "void main ()\n"
    "{\n"
    "    outColor = primitiveColor;\n"
    "}\n"
)

CASES = [("no_task", "NV_API_NO_TASK", False), ("with_task", "NV_API_WITH_TASK", True)]


def render():
    files = {}
    manifest = [
        "# Shader manifest for dEQP-VK.mesh_shader.nv.api.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_mesh_shader_nv_api.py - do not hand-edit. The program sets of MeshApiCase: with and without a task shader.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderApiTests.cpp"\n'
        'rust_module = "mesh_shader/api_nv_tests"\n'
    ]
    for name, const, use_task in CASES:
        stages = {"mesh": mesh_shader(use_task), "frag": FRAG_SHADER}
        if use_task:
            stages = {"task": task_shader(), **stages}
        programs = []
        for stage, source in stages.items():
            files[SRC_DIR / f"{name}.{stage}"] = source
            programs.append(f'{{ name = "{stage}", template = "mesh_shader/nv_api/{name}.{stage}", stage = "{stage}" }}')
        manifest.append(f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "SharedProgram"\nprograms = [ {", ".join(programs)} ]\n')
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

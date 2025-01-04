#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.mesh_shader.nv.property.* (vktMeshShaderPropertyTests.cpp).

Upstream fills a task and a mesh `tcu::StringTemplate` per case. The text of each case does not depend on the device, so the
specialization is done here and the files land in shaders/src/mesh_shader/nv_property/, one task and one mesh shader per case
where the case has one. Cases that upstream gives the same `initPrograms` (the work group size variants) share a program set.

Usage: python3 hodow_cts/scripts/gen_mesh_shader_nv_property.py [--check]
"""

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "mesh_shader" / "nv_property"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "mesh_shader_nv_property.toml"

MIN_LIMIT_TOTAL_MEMORY = 16384
LOCAL_SIZE = 32


def task_shader(local_size_x=None, global_decl="", mesh_interface_out="", task_count=None, body=""):
    return (
        "#version 460\n"
        "#extension GL_NV_mesh_shader : enable\n"
        "\n"
        f"layout (local_size_x={1 if local_size_x is None else local_size_x}) in;\n"
        "\n"
        f"{global_decl}"
        "\n"
        f"{mesh_interface_out}"
        "\n"
        "void main ()\n"
        "{\n"
        f"    gl_TaskCountNV = {0 if task_count is None else task_count};\n"
        f"{body}"
        "}\n"
    )


def mesh_shader(local_size_x=None, global_decl="", interface_in="", body=""):
    return (
        "#version 460\n"
        "#extension GL_NV_mesh_shader : enable\n"
        "\n"
        f"layout (local_size_x={1 if local_size_x is None else local_size_x}) in;\n"
        "layout (triangles) out;\n"
        "layout (max_vertices=3, max_primitives=1) out;\n"
        "\n"
        f"{global_decl}"
        "\n"
        f"{interface_in}"
        "\n"
        "void main ()\n"
        "{\n"
        "    gl_PrimitiveCountNV = 0u;\n"
        f"{body}"
        "}\n"
    )


def common_storage_buffer_decl():
    return "layout (set=0, binding=0) buffer OutputBlock { uint values[]; } ov;\n"


def shared_array_decl(num_elements):
    return f"const uint arrayElements = {num_elements};\nshared uint sharedArray[arrayElements];\n"


def shared_memory_body(local_size):
    return (
        "\n"
        "    if (gl_LocalInvocationID.x == 0u)\n"
        "    {\n"
        "        for (uint i = 0; i < arrayElements; ++i)\n"
        "            sharedArray[i] = 0u;\n"
        "    }\n"
        "\n"
        "    memoryBarrierShared();\n"
        "    barrier();\n"
        "\n"
        "    for (uint i = 0; i < arrayElements; ++i)\n"
        "        atomicAdd(sharedArray[i], 1u);\n"
        "\n"
        "    memoryBarrierShared();\n"
        "    barrier();\n"
        "\n"
        "    uint allGood = 1u;\n"
        "    for (uint i = 0; i < arrayElements; ++i)\n"
        "    {\n"
        f"        if (sharedArray[i] != {local_size})\n"
        "        {\n"
        "            allGood = 0u;\n"
        "            break;\n"
        "        }\n"
        "    }\n"
        "\n"
        "    ov.values[gl_LocalInvocationID.x] = ((allGood == 1u) ? gl_LocalInvocationID.x : gl_WorkGroupSize.x);\n"
    )


WORK_GROUP_ID_BODY = "    ov.values[gl_WorkGroupID.x] = gl_WorkGroupID.x;\n"
LOCAL_INVOCATION_BODY = "    ov.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;\n"

# (case name, rust const, {stage: source})
CASES = [
    (
        "max_draw_mesh_tasks_count_with_task",
        "NV_PROPERTY_MAX_DRAW_MESH_TASKS_COUNT_WITH_TASK",
        {"task": task_shader(global_decl=common_storage_buffer_decl(), body=WORK_GROUP_ID_BODY), "mesh": mesh_shader()},
    ),
    (
        "max_draw_mesh_tasks_count_with_mesh",
        "NV_PROPERTY_MAX_DRAW_MESH_TASKS_COUNT_WITH_MESH",
        {"mesh": mesh_shader(global_decl=common_storage_buffer_decl(), body=WORK_GROUP_ID_BODY)},
    ),
    (
        "max_task_work_group_invocations",
        "NV_PROPERTY_MAX_TASK_WORK_GROUP_INVOCATIONS",
        {
            "mesh": mesh_shader(),
            "task": task_shader(local_size_x=LOCAL_SIZE, global_decl=common_storage_buffer_decl(), body=LOCAL_INVOCATION_BODY),
        },
    ),
    (
        "max_task_output_count",
        "NV_PROPERTY_MAX_TASK_OUTPUT_COUNT",
        {
            "task": task_shader(task_count=65535),
            "mesh": mesh_shader(global_decl=common_storage_buffer_decl(), body=WORK_GROUP_ID_BODY),
        },
    ),
    (
        "max_mesh_work_group_invocations",
        "NV_PROPERTY_MAX_MESH_WORK_GROUP_INVOCATIONS",
        {"mesh": mesh_shader(local_size_x=LOCAL_SIZE, global_decl=common_storage_buffer_decl(), body=LOCAL_INVOCATION_BODY)},
    ),
    (
        "max_task_total_memory_size",
        "NV_PROPERTY_MAX_TASK_TOTAL_MEMORY_SIZE",
        {
            "mesh": mesh_shader(),
            "task": task_shader(
                local_size_x=LOCAL_SIZE,
                global_decl=common_storage_buffer_decl() + shared_array_decl(MIN_LIMIT_TOTAL_MEMORY // 4),
                body=shared_memory_body(LOCAL_SIZE),
            ),
        },
    ),
    (
        "max_mesh_total_memory_size",
        "NV_PROPERTY_MAX_MESH_TOTAL_MEMORY_SIZE",
        {
            "mesh": mesh_shader(
                local_size_x=LOCAL_SIZE,
                global_decl=common_storage_buffer_decl() + shared_array_decl(MIN_LIMIT_TOTAL_MEMORY // 4),
                body=shared_memory_body(LOCAL_SIZE),
            ),
        },
    ),
]


def render():
    files = {}
    manifest = [
        "# Shader manifest for dEQP-VK.mesh_shader.nv.property.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_mesh_shader_nv_property.py - do not hand-edit. The templates of\n"
        "# vktMeshShaderPropertyTests.cpp specialized per case; the work group size cases reuse the programs of the invocation ones.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderPropertyTests.cpp"\n'
        'rust_module = "mesh_shader/property_nv_tests"\n'
    ]
    for name, const, stages in CASES:
        programs = []
        for stage, source in stages.items():
            rel = f"mesh_shader/nv_property/{name}.{stage}"
            files[SRC_DIR / f"{name}.{stage}"] = source
            programs.append(f'{{ name = "{stage}", template = "{rel}", stage = "{stage}" }}')
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

#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.mesh_shader.nv.synchronization.* (vktMeshShaderSyncTests.cpp).

`MeshShaderSyncCase::initPrograms` builds a task, a mesh and a fragment shader from the stages the resource is written and read
in. This replays upstream's case loops (which decide the combinations and number the cases with a running test value) and writes
the shaders of each case; identical sources share one file. A case is looked up by its test value, unique per case.

Usage: python3 hodow_cts/scripts/gen_mesh_shader_nv_sync.py [--check]
"""

import hashlib
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "mesh_shader" / "nv_sync"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "mesh_shader_nv_sync.toml"

HOST, TRANSFER, TASK, MESH, FRAG = "host", "transfer", "task", "mesh", "frag"
UNIFORM_BUFFER, STORAGE_BUFFER, STORAGE_IMAGE, SAMPLED_IMAGE = "uniform_buffer", "storage_buffer", "storage_image", "sampled_image"
GENERAL, SPECIFIC = "memory_barrier", "specific_barrier"
HOST_WRITE, TRANSFER_WRITE, SHADER_WRITE = "host_write", "transfer_write", "shader_write"
HOST_READ, TRANSFER_READ, SHADER_READ, UNIFORM_READ = "host_read", "transfer_read", "shader_read", "uniform_read"

SHADER_STAGES = (TASK, MESH, FRAG)


def can_write_from_stage_as_access(stage, access):
    if stage == HOST:
        return access == HOST_WRITE
    if stage == TRANSFER:
        return access == TRANSFER_WRITE
    return access == SHADER_WRITE


def can_read_from_stage_as_access(stage, access):
    if stage == HOST:
        return access == HOST_READ
    if stage == TRANSFER:
        return access == TRANSFER_READ
    return access in (SHADER_READ, UNIFORM_READ)


def can_read_resource_as_access(res_type, access):
    if access == UNIFORM_READ:
        return res_type == UNIFORM_BUFFER
    return True


def can_write_resource_as_access(res_type, access):
    if res_type == UNIFORM_BUFFER:
        return access != SHADER_WRITE
    return True


def can_write_to(stage, res_type):
    if stage == HOST:
        return res_type in (UNIFORM_BUFFER, STORAGE_BUFFER)
    if stage == TRANSFER:
        return True
    return res_type in (STORAGE_BUFFER, STORAGE_IMAGE)


def can_read_from(stage, res_type):
    if stage == HOST:
        return res_type in (UNIFORM_BUFFER, STORAGE_BUFFER)
    return True


def read_and_write_from_shaders(from_stage, to_stage):
    return from_stage in SHADER_STAGES and to_stage in SHADER_STAGES


class Params:
    def __init__(self, from_stage, to_stage, resource_type, write_access):
        self.from_stage = from_stage
        self.to_stage = to_stage
        self.resource_type = resource_type
        self.write_access = write_access

    def reads_or_writes_in(self, stage):
        return self.from_stage == stage or self.to_stage == stage

    def needs_task(self):
        return self.reads_or_writes_in(TASK)

    def resource_decl(self):
        img_format = ", r32ui" if self.resource_type == STORAGE_IMAGE else ""
        storage_prefix = "" if self.write_access == SHADER_WRITE else "readonly "
        decl = f"layout (set=0, binding=0{img_format}) "
        if self.resource_type == UNIFORM_BUFFER:
            decl += "uniform UniformBuffer { uint value; } ub;"
        elif self.resource_type == STORAGE_BUFFER:
            decl += storage_prefix + "buffer StorageBuffer { uint value; } sb;"
        elif self.resource_type == STORAGE_IMAGE:
            decl += storage_prefix + "uniform uimage2D si;"
        else:
            decl += "uniform usampler2D sampled;"
        return decl + "\n"

    @staticmethod
    def push_constant_decl():
        return "layout (push_constant, std430) uniform PushConstantBlock {\n    uint writeVal;\n    uint readVal;\n} pc;\n"

    def read_statement(self, out_name):
        expr = {
            UNIFORM_BUFFER: "ub.value",
            STORAGE_BUFFER: "sb.value",
            STORAGE_IMAGE: "imageLoad(si, ivec2(0, 0)).x",
            SAMPLED_IMAGE: "texture(sampled, vec2(0.5, 0.5)).x",
        }[self.resource_type]
        return f"    if (pc.readVal > 0u) {{ {out_name} = {expr}; }}\n"

    def write_statement(self, value_name):
        if self.resource_type == STORAGE_BUFFER:
            body = f"sb.value = {value_name}"
        elif self.resource_type == STORAGE_IMAGE:
            body = f"imageStore(si, ivec2(0, 0), uvec4({value_name}, 0, 0, 0))"
        else:
            raise AssertionError("not writable")
        return f"    if (pc.writeVal > 0u) {{ {body}; }}\n"


def task_shader(p, value_str):
    return (
        "#version 450\n"
        "#extension GL_NV_mesh_shader : enable\n"
        "\n"
        "layout(local_size_x=1) in;\n"
        "\n"
        "out taskNV TaskData { uint value; } td;\n"
        "\n"
        f"{p.resource_decl()}{p.push_constant_decl()}\n"
        "void main ()\n"
        "{\n"
        "    gl_TaskCountNV = 1u;\n"
        "    td.value = 0u;\n"
        + (p.write_statement(value_str) if p.from_stage == TASK else "")
        + (p.read_statement("td.value") if p.to_stage == TASK else "")
        + "}\n"
    )


def mesh_shader(p, value_str):
    needs_task = p.needs_task()
    rw_in_mesh = p.reads_or_writes_in(MESH)
    return (
        "#version 450\n"
        "#extension GL_NV_mesh_shader : enable\n"
        "\n"
        "layout(local_size_x=1) in;\n"
        "layout(triangles) out;\n"
        "layout(max_vertices=3, max_primitives=1) out;\n"
        "\n"
        + ("in taskNV TaskData { uint value; } td;\n" if needs_task else "")
        + "layout (location=0) out perprimitiveNV uint primitiveValue[];\n"
        "\n"
        + (p.resource_decl() if rw_in_mesh else "")
        + (p.push_constant_decl() if rw_in_mesh else "")
        + "\n"
        "void main ()\n"
        "{\n"
        "    gl_PrimitiveCountNV = 1u;\n"
        + ("    primitiveValue[0] = td.value;\n" if needs_task else "")
        + (p.write_statement(value_str) if p.from_stage == MESH else "")
        + (p.read_statement("primitiveValue[0]") if p.to_stage == MESH else "")
        + "\n"
        "    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);\n"
        "    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);\n"
        "    gl_PrimitiveIndicesNV[0] = 0;\n"
        "    gl_PrimitiveIndicesNV[1] = 1;\n"
        "    gl_PrimitiveIndicesNV[2] = 2;\n"
        "}\n"
    )


def frag_shader(p):
    read_from_frag = p.to_stage == FRAG
    return (
        "#version 450\n"
        "#extension GL_NV_mesh_shader : enable\n"
        "\n"
        "layout (location=0) in perprimitiveNV flat uint primitiveValue;\n"
        "layout (location=0) out uvec4 outColor;\n"
        "\n"
        + (p.resource_decl() if read_from_frag else "")
        + (p.push_constant_decl() if read_from_frag else "")
        + "\n"
        "void main ()\n"
        "{\n"
        "    outColor = uvec4(primitiveValue, 0, 0, 0);\n"
        "    uint readVal = 0u;\n"
        + (p.read_statement("readVal") if read_from_frag else "")
        + ("    outColor = uvec4(readVal, 0, 0, 0);\n" if read_from_frag else "")
        + "}\n"
    )


STAGE_COMBINATIONS = [
    (HOST, TASK), (HOST, MESH), (TRANSFER, TASK), (TRANSFER, MESH), (TASK, MESH), (TASK, FRAG),
    (TASK, TRANSFER), (TASK, HOST), (MESH, FRAG), (MESH, TRANSFER), (MESH, HOST),
]
RESOURCE_TYPES = [UNIFORM_BUFFER, STORAGE_BUFFER, STORAGE_IMAGE, SAMPLED_IMAGE]
BARRIER_TYPES = [GENERAL, SPECIFIC]
WRITE_ACCESSES = [HOST_WRITE, TRANSFER_WRITE, SHADER_WRITE]
READ_ACCESSES = [HOST_READ, TRANSFER_READ, SHADER_READ, UNIFORM_READ]


def cases():
    out = []
    test_value = 1628510124
    for from_stage, to_stage in STAGE_COMBINATIONS:
        for resource_type in RESOURCE_TYPES:
            if not can_write_to(from_stage, resource_type) or not can_read_from(to_stage, resource_type):
                continue
            for barrier_type in BARRIER_TYPES:
                if read_and_write_from_shaders(from_stage, to_stage) and barrier_type == SPECIFIC:
                    continue
                for write_access in WRITE_ACCESSES:
                    for read_access in READ_ACCESSES:
                        if not can_read_resource_as_access(resource_type, read_access):
                            continue
                        if not can_write_resource_as_access(resource_type, write_access):
                            continue
                        if not can_read_from_stage_as_access(to_stage, read_access):
                            continue
                        if not can_write_from_stage_as_access(from_stage, write_access):
                            continue
                        out.append((test_value, Params(from_stage, to_stage, resource_type, write_access)))
                        test_value += 1
    return out


def render():
    files = {}
    manifest = [
        "# Shader manifest for dEQP-VK.mesh_shader.nv.synchronization.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_mesh_shader_nv_sync.py - do not hand-edit. One entry per case, named after its test value;\n"
        "# the shaders depend on the stages and the resource type, so identical ones share a file.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderSyncTests.cpp"\n'
        'rust_module = "mesh_shader/sync_nv_tests"\n'
    ]
    for test_value, p in cases():
        value_str = str(test_value)
        sources = {}
        if p.needs_task():
            sources["task"] = task_shader(p, value_str)
        sources["mesh"] = mesh_shader(p, value_str)
        sources["frag"] = frag_shader(p)
        programs = []
        for stage, source in sources.items():
            digest = hashlib.sha1(source.encode()).hexdigest()[:10]
            name = f"{stage}_{digest}.{stage}"
            files[SRC_DIR / name] = source
            programs.append(f'{{ name = "{stage}", template = "mesh_shader/nv_sync/{name}", stage = "{stage}" }}')
        manifest.append(
            f'\n[[case]]\nname = "v{test_value}"\nrust_const = "NV_SYNC_V{test_value}"\nrust_type = "NvSyncPrograms"\n'
            f'programs = [ {", ".join(programs)} ]\n'
            f'params = {{ test_value = {{ type = "u32", value = {test_value} }} }}\n'
        )
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
    print(f"wrote {len(cases())} cases, {len(files)} shader files")
    return 0


if __name__ == "__main__":
    sys.exit(main())

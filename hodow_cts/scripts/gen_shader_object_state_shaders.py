#!/usr/bin/env python3
"""Generate the shaders of dEQP-VK.shader_object.misc.state.* and their manifest.

Upstream builds them in `ShaderObjectStateCase::initPrograms` from `lines`, `geometryStreams`, `depthClip` and `meshShader` of the test
parameters, so the ~580 cases share these programs:

  vert  - `vert_clip{0,1}`
  tesc  - `tesc`
  tese  - `tese_lines{0,1}`
  geom  - `geom_lines{0,1}_streams{0,1}`
  frag  - `frag`
  mesh  - `mesh_lines{0,1}_clip{0,1}`

Usage:
    python3 hodow_cts/scripts/gen_shader_object_state_shaders.py
"""

from __future__ import annotations

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_REL = "shader_object/misc_state"
SRC_DIR = CRATE_DIR / "shaders" / "src" / SRC_REL
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "shader_object_misc_state.toml"

OUTPUT_BLOCK = "layout(binding = 0) buffer Output {\n    uint values[8];\n} buffer_out;\n\n"


def vertex(depth_clip: bool) -> str:
    return (
        "#version 450\n"
        + OUTPUT_BLOCK
        + "void main() {\n"
        "    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1)) - vec2(0.0001f);\n"
        + ("    float z = 0.9f;\n" if depth_clip else "    float z = 0.7f;\n")
        + "    if ((gl_VertexIndex & 1) > 0)\n"
        "        z += 0.2f;\n"
        "    if ((gl_InstanceIndex & 1) > 0)\n"
        "        z -= 0.3f;\n"
        "    gl_Position = vec4(pos - 0.5f, z, 1.0f);\n"
        "    if (gl_VertexIndex == 0)\n"
        "        buffer_out.values[0] = 1u;\n"
        "}\n"
    )


TESC = (
    "#version 450\n"
    "layout(vertices = 4) out;\n"
    + OUTPUT_BLOCK
    + "void main (void)\n"
    "{\n"
    "    if (gl_InvocationID == 0) {\n"
    "        gl_TessLevelInner[0] = 1.0;\n"
    "        gl_TessLevelInner[1] = 1.0;\n"
    "        gl_TessLevelOuter[0] = 1.0;\n"
    "        gl_TessLevelOuter[1] = 1.0;\n"
    "        gl_TessLevelOuter[2] = 1.0;\n"
    "        gl_TessLevelOuter[3] = 1.0;\n"
    "        buffer_out.values[1] = 2u;\n"
    "    }\n"
    "    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
    "}\n"
)


def tese(lines: bool) -> str:
    return (
        "#version 450\n"
        + ("layout(isolines, equal_spacing) in;\n" if lines else "layout(quads, equal_spacing) in;\n")
        + OUTPUT_BLOCK
        + "void main (void)\n"
        "{\n"
        "    float u = gl_TessCoord.x;\n"
        "    float v = gl_TessCoord.y;\n"
        "    float omu = 1.0f - u;\n"
        "    float omv = 1.0f - v;\n"
        "    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;\n"
        "    gl_Position.x *= 1.5f;\n"
        "    if (gl_PrimitiveID == 0u)\n"
        "        buffer_out.values[2] = 3u;\n"
        "}\n"
    )


def geometry(lines: bool, streams: bool) -> str:
    src = "#version 450\n" + ("layout(lines) in;\n" if lines else "layout(triangles) in;\n")
    src += "layout(line_strip, max_vertices = 4) out;\n" if lines else "layout(triangle_strip, max_vertices = 4) out;\n"
    if streams:
        src += "layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;\n"
    src += OUTPUT_BLOCK + "void main(void)\n{\n    gl_Position = gl_in[0].gl_Position;\n    gl_Position.y *= 1.5f;\n"
    src += "    out0 = vec4(1.0f);\n    EmitStreamVertex(0);\n" if streams else "    EmitVertex();\n"
    src += "    gl_Position = gl_in[1].gl_Position;\n    gl_Position.y *= 1.5f;\n"
    src += "    out0 = vec4(2.0f);\n    EmitStreamVertex(0);\n" if streams else "    EmitVertex();\n"
    if not lines:
        src += "    gl_Position = gl_in[2].gl_Position;\n    gl_Position.y *= 1.5f;\n"
        src += "    out0 = vec4(3.0f);\n    EmitStreamVertex(0);\n" if streams else "    EmitVertex();\n"
    src += "    EndStreamPrimitive(0);\n" if streams else "    EndPrimitive();\n"
    src += "    buffer_out.values[3] = 4u;\n}\n"
    return src


FRAG = (
    "#version 450\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main() {\n"
    "    outColor = vec4(0.75f);\n"
    "}\n"
)


def mesh(lines: bool, depth_clip: bool) -> str:
    src = (
        "#version 460\n"
        "#extension GL_EXT_mesh_shader : require\n"
        "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
        "layout(max_vertices = 4) out;\n"
        "layout(max_primitives = 2) out;\n"
        + ("layout(lines) out;\n" if lines else "layout(triangles) out;\n")
        + OUTPUT_BLOCK
        + "void main() {\n"
        "    SetMeshOutputsEXT(4u, 2u);\n"
        + ("    float z = 0.9f;\n" if depth_clip else "    float z = 0.7f;\n")
        + "    if (gl_GlobalInvocationID.x == 1) z -= 0.3f;\n"
        "    gl_MeshVerticesEXT[0].gl_Position = vec4(-0.5f, -0.5f, z, 1.0f);\n"
        "    gl_MeshVerticesEXT[1].gl_Position = vec4(-0.5f, 0.5f, z, 1.0f);\n"
        "    gl_MeshVerticesEXT[2].gl_Position = vec4(0.5f, -0.5f, z + 0.2f, 1.0f);\n"
        "    gl_MeshVerticesEXT[3].gl_Position = vec4(0.5f, 0.5f, z + 0.2f, 1.0f);\n"
    )
    if lines:
        src += "    gl_PrimitiveLineIndicesEXT[0] = uvec2(0u, 2u);\n    gl_PrimitiveLineIndicesEXT[1] = uvec2(1u, 3u);\n"
    else:
        src += "    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);\n    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 3u, 2u);\n"
    src += "    buffer_out.values[4] = 5u;\n}\n"
    return src


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for stale in SRC_DIR.glob("*"):
        stale.unlink()

    programs: list[tuple[str, str, str, str]] = []

    def emit(name: str, stage: str, source: str, spirv_version: str = "") -> None:
        (SRC_DIR / f"{name}.{stage}").write_text(source)
        programs.append((name, f"{SRC_REL}/{name}.{stage}", stage, spirv_version))

    for clip in (0, 1):
        emit(f"vert_clip{clip}", "vert", vertex(bool(clip)))
    emit("tesc", "tesc", TESC)
    for lines in (0, 1):
        emit(f"tese_lines{lines}", "tese", tese(bool(lines)))
        for streams in (0, 1):
            emit(f"geom_lines{lines}_streams{streams}", "geom", geometry(bool(lines), bool(streams)))
        for clip in (0, 1):
            emit(f"mesh_lines{lines}_clip{clip}", "mesh", mesh(bool(lines), bool(clip)), "spirv1.4")
    emit("frag", "frag", FRAG)

    lines = [
        "# Shader manifest for dEQP-VK.shader_object.misc.state.*",
        "#",
        "# Generated by scripts/gen_shader_object_state_shaders.py together with the sources it names; do not hand-edit either.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shader_object/vktShaderObjectMiscTests.cpp"',
        'rust_module = "shader_object/misc_state_tests"',
        "",
        "[[case]]",
        'name = "state"',
        'rust_const = "MISC_STATE"',
        'rust_type = "SharedProgram"',
        "programs = [",
    ]
    for name, template, stage, spirv_version in programs:
        extra = f', spirv_version = "{spirv_version}"' if spirv_version else ""
        lines.append(f'    {{ name = "{name}", template = "{template}", stage = "{stage}"{extra} }},')
    lines += ["]", ""]
    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {len(programs)} shaders in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

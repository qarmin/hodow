#!/usr/bin/env python3
"""Generate the synchronization.op buffer-access shaders and their manifest.

Every shader-based synchronization operation is the same passthrough: read the whole
resource and write it into a host-visible buffer, or the other way round. `initPrograms`
builds it out of a declaration block and a copy loop that depend only on the buffer type
and on how many `uvec4` the resource holds - so the two buffer sizes in `s_resources`
give a handful of shaders rather than one per case.

Usage:
    python3 hodow_cts/scripts/gen_synchronization_shaders.py
"""

from __future__ import annotations

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "synchronization" / "generated"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "synchronization_buffer.toml"

# `s_resources`' two buffer sizes, and `MAX_UBO_RANGE`.
BUFFER_SIZES = [0x4000, 0x40000]
MAX_UBO_RANGE = 0x4000


def declarations(buffer_type: str, mode: str, num_vec_elements: int) -> str:
    """`BufferSupport::initPrograms`' declSrc.

    std140 must be aligned to a multiple of 16, which is why the payload is uvec4.
    """
    output_buff = (
        "layout(set = 0, binding = 1, std140) writeonly buffer Output {\n"
        f"    uvec4 data[{num_vec_elements}];\n"
        "} b_out;\n"
    )

    if buffer_type == "ubo_texel":
        return f"layout(set = 0, binding = 0) uniform utextureBuffer Input;\n\n{output_buff}"

    # A write operation has the roles the other way round - the host buffer is the
    # input and the resource is the output - but upstream expresses that by binding
    # them the other way round, not by changing the shader.
    storage = "uniform" if buffer_type == "ubo" else "buffer"
    _ = mode
    return (
        f"layout(set = 0, binding = 0, std140) readonly {storage} Input {{\n"
        f"    uvec4 data[{num_vec_elements}];\n"
        "} b_in;\n"
        "\n" + output_buff
    )


def copy_source(buffer_type: str, num_vec_elements: int) -> str:
    """`BufferSupport::initPrograms`' copySrc"""
    fetch = "texelFetch(Input, i)" if buffer_type == "ubo_texel" else "b_in.data[i]"
    return f"    for (int i = 0; i < {num_vec_elements}; ++i) {{\n        b_out.data[i] = {fetch};\n    }}\n"


def compute_shader(buffer_type: str, mode: str, size: int) -> str:
    """`initPassthroughPrograms`, compute stage."""
    num_vec_elements = size // 16
    return (
        "#version 440\n"
        "\n"
        "layout(local_size_x = 1) in;\n"
        "\n"
        + declarations(buffer_type, mode, num_vec_elements)
        + "\n"
        "void main (void)\n"
        "{\n"
        + copy_source(buffer_type, num_vec_elements)
        + "}\n"
    )


# `s_resources`' single-sampled colour images: the format qualifier and image type the
# shader declares, and the extent its loop walks.
IMAGE_RESOURCES = [
    ("image_128_r32_uint", "r32ui", "uimage1D", (128, 0, 0)),
    ("image_128x128_r8_unorm", "r8", "image2D", (128, 128, 0)),
    ("image_128x128_r16_uint", "r16ui", "uimage2D", (128, 128, 0)),
    ("image_128x128_r8g8b8a8_unorm", "rgba8", "image2D", (128, 128, 0)),
    ("image_128x128_r16g16b16a16_uint", "rgba16ui", "uimage2D", (128, 128, 0)),
    ("image_128x128_r32g32b32a32_sfloat", "rgba32f", "image2D", (128, 128, 0)),
    ("image_64x64x8_r32_sfloat", "r32f", "image3D", (64, 64, 8)),
]


def image_declarations(image_format: str, image_type: str) -> str:
    """`ImageSupport::initPrograms`' declSrc.

    Read and write use the same GLSL - which of the two images is the resource and
    which is the staging copy is decided by how they are bound, not by the shader.
    """
    return (
        f"layout(set = 0, binding = 0, {image_format}) readonly  uniform {image_type} srcImg;\n"
        f"layout(set = 0, binding = 1, {image_format}) writeonly uniform {image_type} dstImg;\n"
    )


def image_copy_source(image_type: str, size: tuple[int, int, int]) -> str:
    """`ImageSupport::initPrograms`' mainSrc - the loop over the whole extent."""
    x, y, z = size
    if image_type.endswith("1D"):
        return f"    for (int x = 0; x < {x}; ++x)\n        imageStore(dstImg, x, imageLoad(srcImg, x));\n"
    if image_type.endswith("3D"):
        return (
            f"    for (int z = 0; z < {z}; ++z)\n"
            f"    for (int y = 0; y < {y}; ++y)\n"
            f"    for (int x = 0; x < {x}; ++x)\n"
            "        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));\n"
        )
    return (
        f"    for (int y = 0; y < {y}; ++y)\n"
        f"    for (int x = 0; x < {x}; ++x)\n"
        "        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));\n"
    )


def image_compute_shader(image_format: str, image_type: str, size: tuple[int, int, int]) -> str:
    """`ImageSupport::initPrograms` through `initPassthroughPrograms`, compute stage."""
    return (
        "#version 440\n"
        "\n"
        "layout(local_size_x = 1) in;\n"
        "\n"
        + image_declarations(image_format, image_type)
        + "\n"
        "void main (void)\n"
        "{\n"
        + image_copy_source(image_type, size)
        + "}\n"
    )


# `s_perVertexBlock` - the block body only; upstream prefixes `in` or `out` at each
# use site, and so does every use below.
PER_VERTEX_BLOCK = "gl_PerVertex {\n    vec4 gl_Position;\n}"


# `getRequiredStages`: naming a tessellation stage pulls in both of them, and every
# graphics stage needs a vertex and a fragment shader to have a pipeline at all.
def required_stages(stage: str) -> list[str]:
    stages = ["vert"]
    if stage in ("tess_control", "tess_eval"):
        stages += ["tesc", "tese"]
    if stage == "geometry":
        stages.append("geom")
    stages.append("frag")
    return stages


def graphics_shaders(decl: str, copy: str, stage: str) -> dict[str, str]:
    """`initPassthroughPrograms` for a graphics stage.

    Every stage the pipeline needs gets a shader; the one the operation names also
    gets the declarations and the copy loop. The others are pure passthrough, which is
    why a tessellation-evaluation operation still has to carry a control shader.
    """
    out: dict[str, str] = {}
    for name in required_stages(stage):
        if name == "vert":
            out[name] = (
                "#version 440\n"
                "\n"
                "layout(location = 0) in vec4 v_in_position;\n"
                "\n"
                f"out {PER_VERTEX_BLOCK};\n"
                "\n"
                + (decl + "\n" if stage == "vertex" else "")
                + "void main (void)\n"
                "{\n"
                "    gl_Position = v_in_position;\n"
                + (copy if stage == "vertex" else "")
                + "}\n"
            )
        elif name == "tesc":
            out[name] = (
                "#version 440\n"
                "\n"
                "layout(vertices = 3) out;\n"
                "\n"
                f"in {PER_VERTEX_BLOCK} gl_in[gl_MaxPatchVertices];\n"
                "\n"
                f"out {PER_VERTEX_BLOCK} gl_out[];\n"
                "\n"
                + (decl + "\n" if stage == "tess_control" else "")
                + "void main (void)\n"
                "{\n"
                "    gl_TessLevelInner[0] = 1.0;\n"
                "    gl_TessLevelInner[1] = 1.0;\n"
                "\n"
                "    gl_TessLevelOuter[0] = 1.0;\n"
                "    gl_TessLevelOuter[1] = 1.0;\n"
                "    gl_TessLevelOuter[2] = 1.0;\n"
                "    gl_TessLevelOuter[3] = 1.0;\n"
                "\n"
                "    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
                + ("\n" + copy if stage == "tess_control" else "")
                + "}\n"
            )
        elif name == "tese":
            out[name] = (
                "#version 440\n"
                "\n"
                "layout(triangles, equal_spacing, ccw) in;\n"
                "\n"
                f"in {PER_VERTEX_BLOCK} gl_in[gl_MaxPatchVertices];\n"
                "\n"
                f"out {PER_VERTEX_BLOCK};\n"
                "\n"
                + (decl + "\n" if stage == "tess_eval" else "")
                + "void main (void)\n"
                "{\n"
                "    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;\n"
                "    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;\n"
                "    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;\n"
                "    gl_Position = vec4(px + py + pz, 1.0);\n"
                + (copy if stage == "tess_eval" else "")
                + "}\n"
            )
        elif name == "geom":
            out[name] = (
                "#version 440\n"
                "\n"
                "layout(triangles) in;\n"
                "layout(triangle_strip, max_vertices = 3) out;\n"
                "\n"
                f"in {PER_VERTEX_BLOCK} gl_in[];\n"
                "\n"
                f"out {PER_VERTEX_BLOCK};\n"
                "\n"
                + (decl + "\n" if stage == "geometry" else "")
                + "void main (void)\n"
                "{\n"
                "    gl_Position = gl_in[0].gl_Position;\n"
                "    EmitVertex();\n"
                "\n"
                "    gl_Position = gl_in[1].gl_Position;\n"
                "    EmitVertex();\n"
                "\n"
                "    gl_Position = gl_in[2].gl_Position;\n"
                "    EmitVertex();\n"
                + ("\n" + copy if stage == "geometry" else "")
                + "}\n"
            )
        else:
            out[name] = (
                "#version 440\n"
                "\n"
                "layout(location = 0) out vec4 o_color;\n"
                "\n"
                + (decl + "\n" if stage == "fragment" else "")
                + "void main (void)\n"
                "{\n"
                "    o_color = vec4(1.0);\n"
                + ("\n" + copy if stage == "fragment" else "")
                + "}\n"
            )
    return out


# The extension every generated shader file uses for a stage, and the stage name
# `compile_shaders.py` passes to glslang.
STAGE_EXT = {"vert": "vert", "tesc": "tesc", "tese": "tese", "geom": "geom", "frag": "frag"}

GRAPHICS_STAGES = ("vertex", "fragment", "tess_control", "tess_eval", "geometry")


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for pattern in ("*.comp", "*.vert", "*.frag", "*.tesc", "*.tese", "*.geom"):
        for existing in SRC_DIR.glob(pattern):
            existing.unlink()

    lines = [
        "# Shader manifest for dEQP-VK.synchronization{,2}.op.*.{read,write}_{ssbo,ubo,ubo_texel}_compute*",
        "#",
        "# Generated by scripts/gen_synchronization_shaders.py together with the GLSL it names;",
        "# do not hand-edit either. The shader depends only on the buffer type and on how many",
        "# uvec4 the resource holds, so the two buffer sizes in s_resources cover every case.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/synchronization/vktSynchronizationOperation.cpp"',
        'rust_module = "synchronization/operation"',
        "",
    ]

    count = 0
    # `write` is storage-buffer only; both uniform kinds are capped by MAX_UBO_RANGE,
    # which `isResourceSupported` applies to the texel variant as well.
    variants = [("ssbo", "write"), ("ssbo", "read"), ("ubo", "read"), ("ubo_texel", "read")]
    for buffer_type, mode in variants:
        for size in BUFFER_SIZES:
            if buffer_type.startswith("ubo") and size > MAX_UBO_RANGE:
                continue
            name = f"{mode}_{buffer_type}_buffer_{size}"
            (SRC_DIR / f"{name}.comp").write_text(compute_shader(buffer_type, mode, size))
            lines += [
                "[[case]]",
                f'name = "{name}"',
                f'rust_const = "{name.upper()}"',
                'rust_type = "BufferAccessShader"',
                f'programs = [{{ name = "comp", template = "synchronization/generated/{name}.comp", stage = "comp" }}]',
                "[case.params]",
                f'buffer_type = {{ type = "str", value = "{buffer_type}" }}',
                f'mode = {{ type = "str", value = "{mode}" }}',
                f'buffer_size = {{ type = "u32", value = {size} }}',
                "",
            ]
            count += 1

    # The graphics stages SwiftShader can actually run. Tessellation and geometry are
    # left out deliberately: both sides report NotSupported for them here, so a
    # differential run would say nothing about whether they were ported correctly.
    for stage in GRAPHICS_STAGES:
        for buffer_type, mode in variants:
            for size in BUFFER_SIZES:
                if buffer_type.startswith("ubo") and size > MAX_UBO_RANGE:
                    continue
                num = size // 16
                decl = declarations(buffer_type, mode, num)
                copy = copy_source(buffer_type, num)
                shaders = graphics_shaders(decl, copy, stage)
                name = f"{mode}_{buffer_type}_{stage}_buffer_{size}"
                programs = []
                for shader_stage, source in shaders.items():
                    (SRC_DIR / f"{name}.{shader_stage}").write_text(source)
                    programs.append(
                        f'    {{ name = "{shader_stage}", template = "synchronization/generated/{name}.{shader_stage}", stage = "{shader_stage}" }},'
                    )
                lines += [
                    "[[case]]",
                    f'name = "{name}"',
                    f'rust_const = "{name.upper()}"',
                    'rust_type = "BufferGraphicsShader"',
                    "programs = [",
                    *programs,
                    "]",
                    "[case.params]",
                    f'buffer_type = {{ type = "str", value = "{buffer_type}" }}',
                    f'mode = {{ type = "str", value = "{mode}" }}',
                    f'stage = {{ type = "str", value = "{stage}" }}',
                    f'buffer_size = {{ type = "u32", value = {size} }}',
                    "",
                ]
                count += 1

    for resource_name, image_format, image_type, size in IMAGE_RESOURCES:
        name = f"image_{resource_name}"
        (SRC_DIR / f"{name}.comp").write_text(image_compute_shader(image_format, image_type, size))
        lines += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "{name.upper()}"',
            'rust_type = "ImageAccessShader"',
            f'programs = [{{ name = "comp", template = "synchronization/generated/{name}.comp", stage = "comp" }}]',
            "[case.params]",
            f'resource_name = {{ type = "str", value = "{resource_name}" }}',
            "",
        ]
        count += 1

    # The same image copy driven from a graphics stage instead. As with the buffer
    # graphics shaders, tessellation and geometry are left out: both sides report
    # NotSupported for them here, so a differential run says nothing about them.
    for resource_name, image_format, image_type, size in IMAGE_RESOURCES:
        decl = image_declarations(image_format, image_type)
        copy = image_copy_source(image_type, size)
        for stage in GRAPHICS_STAGES:
            shaders = graphics_shaders(decl, copy, stage)
            name = f"image_{resource_name}_{stage}"
            programs = []
            for shader_stage, source in shaders.items():
                (SRC_DIR / f"{name}.{shader_stage}").write_text(source)
                programs.append(
                    f'    {{ name = "{shader_stage}", template = "synchronization/generated/{name}.{shader_stage}", stage = "{shader_stage}" }},'
                )
            lines += [
                "[[case]]",
                f'name = "{name}"',
                f'rust_const = "{name.upper()}"',
                'rust_type = "ImageGraphicsShader"',
                "programs = [",
                *programs,
                "]",
                "[case.params]",
                f'resource_name = {{ type = "str", value = "{resource_name}" }}',
                f'stage = {{ type = "str", value = "{stage}" }}',
                "",
            ]
            count += 1

    # `Draw::Support::initPrograms` - a passthrough vertex shader and a fragment
    # shader that writes `makeClearValue`'s colour. The value depends only on whether
    # the format is integral, so two fragment shaders cover every resource.
    draw_vert = (
        "#version 440\n"
        "\n"
        "layout(location = 0) in vec4 v_in_position;\n"
        "\n"
        f"out {PER_VERTEX_BLOCK};\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "    gl_Position = v_in_position;\n"
        "}\n"
    )
    (SRC_DIR / "draw.vert").write_text(draw_vert)

    for kind, color_type, value in (("float", "vec4", "0.25, 0.49, 0.75, 1"), ("integer", "uvec4", "8, 16, 24, 32")):
        frag = (
            "#version 440\n"
            "\n"
            f"layout(location = 0) out {color_type} o_color;\n"
            "\n"
            "void main (void)\n"
            "{\n"
            f"    o_color = {color_type}({value});\n"
            "}\n"
        )
        name = f"draw_{kind}"
        (SRC_DIR / f"{name}.frag").write_text(frag)
        lines += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "{name.upper()}"',
            'rust_type = "DrawShader"',
            "programs = [",
            '    { name = "draw_vert", template = "synchronization/generated/draw.vert", stage = "vert" },',
            f'    {{ name = "draw_frag", template = "synchronization/generated/{name}.frag", stage = "frag" }},',
            "]",
            "[case.params]",
            f'integer = {{ type = "bool", value = {"true" if kind == "integer" else "false"} }}',
            "",
        ]
        count += 1

    # `VertexInput::Support::initPrograms`, the DRAW_MODE_VERTEX half. The resource is
    # bound as the vertex buffer and the vertex shader copies each attribute into an
    # SSBO the host reads back, so the shader depends only on how many uvec4 the
    # resource holds.
    input_frag = (
        "#version 440\n"
        "\n"
        "layout(location = 0) out vec4 o_color;\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "    o_color = vec4(1.0);\n"
        "}\n"
    )
    (SRC_DIR / "input.frag").write_text(input_frag)

    for size in BUFFER_SIZES:
        num_vec_elements = size // 16
        vert = (
            "#version 440\n"
            "layout(location = 0) in uvec4 v_in_data;\n"
            "layout(set = 0, binding = 0, std140) writeonly buffer Output {\n"
            f"    uvec4 data[{num_vec_elements}];\n"
            "} b_out;\n"
            "\n"
            "void main (void)\n"
            "{\n"
            "    b_out.data[gl_VertexIndex] = v_in_data;\n"
            "    gl_PointSize = 1.0f;\n"
            "}\n"
        )
        name = f"vertex_input_{size}"
        (SRC_DIR / f"{name}.vert").write_text(vert)
        lines += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "{name.upper()}"',
            'rust_type = "VertexInputShader"',
            "programs = [",
            f'    {{ name = "input_vert", template = "synchronization/generated/{name}.vert", stage = "vert" }},',
            '    { name = "input_frag", template = "synchronization/generated/input.frag", stage = "frag" },',
            "]",
            "[case.params]",
            f'buffer_size = {{ type = "u32", value = {size} }}',
            "",
        ]
        count += 1

    # `IndirectBuffer::ReadSupport::initPrograms`. The read runs an indirect draw or
    # dispatch whose command was written by the write operation, and each invocation
    # bumps a counter the host compares against what the command asked for.
    ib_decl = "layout(set = 0, binding = 0, std140) coherent buffer Data {\n    uint value;\n} sb_out;\n"
    ib_main = "    atomicAdd(sb_out.value, 1u);\n"

    (SRC_DIR / "read_ib.vert").write_text(
        "#version 440\n"
        "\n"
        "layout(location = 0) in vec4 v_in_position;\n"
        "\n"
        f"out {PER_VERTEX_BLOCK};\n"
        "\n"
        + ib_decl
        + "\n"
        "void main (void)\n"
        "{\n"
        "    gl_Position = v_in_position;\n"
        + ib_main
        + "}\n"
    )
    (SRC_DIR / "read_ib.frag").write_text(
        "#version 440\n"
        "\n"
        "layout(location = 0) out vec4 o_color;\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "    o_color = vec4(1.0);\n"
        "}\n"
    )
    (SRC_DIR / "read_ib.comp").write_text(
        "#version 440\n"
        "\n"
        "layout(local_size_x = 1) in;\n"
        "\n"
        + ib_decl
        + "\n"
        "void main (void)\n"
        "{\n"
        + ib_main
        + "}\n"
    )
    lines += [
        "[[case]]",
        'name = "read_indirect_buffer"',
        'rust_const = "READ_INDIRECT_BUFFER"',
        'rust_type = "IndirectBufferShader"',
        "programs = [",
        '    { name = "read_ib_vert", template = "synchronization/generated/read_ib.vert", stage = "vert" },',
        '    { name = "read_ib_frag", template = "synchronization/generated/read_ib.frag", stage = "frag" },',
        '    { name = "read_ib_comp", template = "synchronization/generated/read_ib.comp", stage = "comp" },',
        "]",
        "",
    ]
    count += 1

    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {count} shaders in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

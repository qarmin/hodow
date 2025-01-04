#!/usr/bin/env python3
"""Generate the renderpasses multisample_resolve shaders and their manifest.

`Programs::init` in vktRenderPassMultisampleResolveTests.cpp builds its GLSL from
three things: the layer count (which decides whether there is a geometry shader and
how many layers it fans out to), the format's channel class (which picks the vec4
prefix and the value written), and the attachment count (which decides how many
outputs the fragment shader declares). The MAX_ATTACHMENTS test type has a second
subpass whose shader reads the first one's outputs back as input attachments.

Enumerating those gives 27 shaders in total, all in one case - which of them a test
uses is decided at pipeline-creation time, exactly as upstream decides it at
initPrograms time.

Usage:
    python3 hodow_cts/scripts/gen_ms_resolve_shaders.py
"""

from __future__ import annotations

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "renderpass" / "generated"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "renderpass_ms_resolve.toml"

# `layerCounts` minus the single-layer case, which needs no geometry shader.
LAYER_COUNTS = (3, 6)
# `attachmentCount` for RESOLVE (4) and for COMPATIBILITY (1).
RESOLVE_ATTACHMENT_COUNTS = (1, 4)
# `1 << power` for power in 2..5 - the MAX_ATTACHMENTS counts.
MAX_ATTACHMENT_COUNTS = (4, 8, 16)

# (suffix, TYPE_PREFIX, RESOLVE COLOR_VAL, MAX_ATTACHMENTS COLOR_VAL)
CHANNEL_CLASSES = (
    ("f", "", "1.0", "0.0, 0.4, 0.8, 1.0"),
    ("u", "u", "255", "0, 64, 192, 252"),
    ("i", "i", "127", "0, 32, 100, 124"),
)

VERT = (
    "#version 450\n"
    "out gl_PerVertex {\n"
    "\tvec4 gl_Position;\n"
    "};\n"
    "highp float;\n"
    "void main (void) {\n"
    "\tgl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,\n"
    "\t                   ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);\n"
    "}\n"
)


def geom(layer_count: int) -> str:
    return (
        "#version 450\n"
        "highp float;\n"
        "\n"
        "layout(triangles) in;\n"
        f"layout(triangle_strip, max_vertices = {3 * 2 * layer_count}) out;\n"
        "\n"
        "in gl_PerVertex {\n"
        "    vec4 gl_Position;\n"
        "} gl_in[];\n"
        "\n"
        "out gl_PerVertex {\n"
        "    vec4 gl_Position;\n"
        "};\n"
        "\n"
        "void main (void) {\n"
        f"    for (int layerNdx = 0; layerNdx < {layer_count}; ++layerNdx) {{\n"
        "        for(int vertexNdx = 0; vertexNdx < gl_in.length(); vertexNdx++) {\n"
        "            gl_Position = gl_in[vertexNdx].gl_Position;\n"
        "            gl_Layer    = layerNdx;\n"
        "            EmitVertex();\n"
        "        };\n"
        "        EndPrimitive();\n"
        "    };\n"
        "}\n"
    )


def generic_layout(index: int, type_prefix: str) -> str:
    return f"layout(location = {index}) out {type_prefix}vec4 o_color{index};\n"


def generic_body(index: int, type_prefix: str, color_val: str) -> str:
    return f"\to_color{index} = {type_prefix}vec4({color_val});\n"


def resolve_frag(type_prefix: str, color_val: str, attachment_count: int) -> str:
    layout = "".join(generic_layout(i, type_prefix) for i in range(attachment_count))
    body = "\tgl_SampleMask[0] = int(pushConstants.sampleMask);\n"
    body += "".join(generic_body(i, type_prefix, color_val) for i in range(attachment_count))
    return (
        "#version 450\n"
        "layout(push_constant) uniform PushConstant {\n"
        "\thighp uint sampleMask;\n"
        "} pushConstants;\n"
        f"{layout}"
        "void main (void)\n"
        "{\n"
        f"{body}"
        "}\n"
    )


def max_attachments_frag(type_prefix: str, color_val: str, attachment_count: int, subpass: int) -> str:
    if subpass == 0:
        layout = "".join(generic_layout(i, type_prefix) for i in range(attachment_count))
        body = "".join(generic_body(i, type_prefix, color_val) for i in range(attachment_count))
    else:
        half = attachment_count // 2
        # Integer formats cannot scale by 0.5, so they halve and quarter with integer division.
        select_int_body = type_prefix in ("u", "i")
        layout = "".join(
            f"layout (input_attachment_index = {i}, set = 0, binding = {i}) uniform {type_prefix}subpassInput i_color{i};\n"
            for i in range(attachment_count)
        )
        layout += "".join(generic_layout(i, type_prefix) for i in range(half))
        if select_int_body:
            body = "".join(f"\to_color{i} = subpassLoad(i_color{i}) / 2 + subpassLoad(i_color{half + i}) / 4;\n" for i in range(half))
        else:
            body = "".join(f"\to_color{i} = subpassLoad(i_color{i})*0.5 + subpassLoad(i_color{half + i})*0.25;\n" for i in range(half))
    return "#version 450\n" + layout + "void main (void)\n{\n" + body + "}\n"


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)

    programs: list[tuple[str, str, str]] = [("quad_vert", "vert", VERT)]
    for layer_count in LAYER_COUNTS:
        programs.append((f"geom_{layer_count}", "geom", geom(layer_count)))
    for suffix, type_prefix, resolve_color, max_color in CHANNEL_CLASSES:
        for attachment_count in RESOLVE_ATTACHMENT_COUNTS:
            programs.append((f"quad_frag_{suffix}_{attachment_count}", "frag", resolve_frag(type_prefix, resolve_color, attachment_count)))
        for attachment_count in MAX_ATTACHMENT_COUNTS:
            for subpass in (0, 1):
                programs.append(
                    (
                        f"quad_frag_sp{subpass}_{suffix}_{attachment_count}",
                        "frag",
                        max_attachments_frag(type_prefix, max_color, attachment_count, subpass),
                    )
                )

    lines = [
        "# Shader manifest for dEQP-VK.renderpasses.renderpass{1,2}.suballocation.multisample_resolve.*",
        "#",
        "# Generated by scripts/gen_ms_resolve_shaders.py together with the GLSL it names;",
        "# do not hand-edit either. One case holding all of them: which shader a test uses",
        "# follows from its layer count, channel class and attachment count, so enumerating",
        "# the sets would be far more entries than there are shaders.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/renderpass/vktRenderPassMultisampleResolveTests.cpp"',
        'rust_module = "renderpass/multisample_resolve_tests"',
        "",
        "[[case]]",
        'name = "ms_resolve"',
        'rust_const = "MS_RESOLVE_PROGRAMS"',
        'rust_type = "MsResolvePrograms"',
        "programs = [",
    ]
    for name, stage, source in programs:
        (SRC_DIR / f"ms_resolve_{name}.{stage}").write_text(source)
        lines.append(f'    {{ name = "{name}", template = "renderpass/generated/ms_resolve_{name}.{stage}", stage = "{stage}" }},')
    lines += ["]", ""]

    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {len(programs)} shaders in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

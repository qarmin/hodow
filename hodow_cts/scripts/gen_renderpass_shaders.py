#!/usr/bin/env python3
"""Generate the renderpass input-attachment shaders and their manifest.

`SubpassRenderer::createSubpassShaders` builds its fragment shader by string
concatenation from the render pass description, so upstream emits one per test case.
hodow_cts commits SPIR-V ahead of time, so the same construction has to happen here
instead - at generation time, over the set of descriptions the ported group actually
uses, deduplicated.

For `addFormatTests`'s `input` branch the description is fixed except for the format of
the attachment being read back: subpass 0 writes attachment 0, subpass 1 reads it as an
input attachment and writes attachment 1, which is always R8G8B8A8_UNORM. That leaves
two degrees of freedom - the input attachment's channel class, which picks the
`subpassInput` flavour, and its channel count, which sets how many `inputs[]` there
are. Ten combinations cover every core colour format.

Usage:
    python3 hodow_cts/scripts/gen_renderpass_shaders.py
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "renderpass" / "generated"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "renderpass_render_pass_input.toml"
FORMAT_LIST = CRATE_DIR / "src" / "vkt" / "tests" / "renderpass" / "render_pass_tests.rs"

# `boolOpToString(boolOpFromIndex(index))`.
BOOL_OPS = ["||", "&&", "==", "!="]

COMPONENTS = ["x", "y", "z", "w"]


def bool_op(index: int) -> str:
    return BOOL_OPS[index % 4]


def input_attachment_type(channel_class: str) -> str:
    """`getInputAttachmentType`, single-sampled."""
    return {"sint": "isubpassInput", "uint": "usubpassInput"}.get(channel_class, "subpassInput")


def fragment_shader(channel_class: str, input_component_count: int) -> str:
    """`createSubpassShaders` for subpass 1 of the `input` branch.

    subpassNdx is 1 and the colour attachment is index 1, so `index` is 2 for every
    component - upstream computes it as `subpassNdx + attachmentIndex + outputValueNdx`
    and only advances outputValueNdx once per attachment, not per component.
    """
    output_component_count = 4  # R8G8B8A8_UNORM
    # `inputsPerOutput`, which is 1 for every colour case here: no format in the list
    # has more channels than the destination.
    inputs_per_output = (
        (input_component_count // output_component_count) + (1 if input_component_count % output_component_count else 0)
        if input_component_count >= output_component_count
        else 1
    )

    out = ["#version 450"]
    out.append(f"layout(input_attachment_index = 0, set=0, binding=0) uniform highp {input_attachment_type(channel_class)} i_color0;")
    out.append("layout(location = 0) out highp vec4 o_color0;")
    out.append("void main (void) {")
    out.append(f"\tbool inputs[{input_component_count}];")
    out.append(f"\tbool outputs[{output_component_count}];")

    for comp_ndx in range(input_component_count):
        out.append(f"\tinputs[{comp_ndx}] = 1.0 == float(subpassLoad(i_color0).{COMPONENTS[comp_ndx]});")

    index = 1 + 1 + 0  # subpassNdx + attachmentIndex + outputValueNdx
    for comp_ndx in range(output_component_count):
        out.append(f"\toutputs[{comp_ndx}] = (int(gl_FragCoord.x) % 2 == {index % 2}) {bool_op(index)} (int(gl_FragCoord.y) % 2 == {(index // 2) % 2});")
        for i in range(inputs_per_output):
            src = (comp_ndx * inputs_per_output + i) % input_component_count
            out.append(f"\toutputs[{comp_ndx}] = outputs[{comp_ndx}] == inputs[{src}];")

    out.append("\to_color0 = vec4(" + ", ".join(f"outputs[{i}]" for i in range(output_component_count)) + ");")
    out.append("}")
    return "\n".join(out) + "\n"


def read_core_color_formats() -> list[str]:
    """The `CORE_COLOR_FORMATS` case names, so the variant set is driven by the same
    list the Rust side registers from."""
    text = FORMAT_LIST.read_text()
    i = text.index("pub static CORE_COLOR_FORMATS")
    j = text.index("];", i)
    return re.findall(r'"([a-z0-9_]+)"', text[i:j])


def classify(name: str) -> tuple[str, int]:
    """The channel class and shader channel count a format name implies.

    Derived from the name rather than a table: these are all plain colour formats whose
    name spells out both, and a table would be a second thing to keep in step.
    """
    if name.endswith("_sint") or "_sint_" in name:
        channel_class = "sint"
    elif name.endswith("_uint") or "_uint_" in name:
        channel_class = "uint"
    else:
        channel_class = "float"

    # The channel letters before the type suffix, e.g. "r8g8b8a8" or "a2b10g10r10".
    head = name.split("_")[0]
    letters = re.findall(r"[rgba](?=\d)", head)
    if letters == ["a"]:
        # `getShaderNumChannels` returns 4 for an alpha-only order.
        return channel_class, 4
    return channel_class, len(letters)


def main() -> int:
    formats = read_core_color_formats()
    if not formats:
        print("error: no formats found in CORE_COLOR_FORMATS", file=sys.stderr)
        return 2

    variants = sorted({classify(f) for f in formats})
    print(f"{len(formats)} formats -> {len(variants)} shader variants: {variants}")

    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for existing in SRC_DIR.glob("*.frag"):
        existing.unlink()

    lines = [
        "# Shader manifest for the input-attachment half of",
        "# dEQP-VK.renderpasses.renderpass{1,2}.*.formats.*.input.*",
        "#",
        "# Generated by scripts/gen_renderpass_shaders.py together with the GLSL it names;",
        "# do not hand-edit either. See that script for why these are generated rather than",
        "# written out: upstream builds the fragment shader from the render pass",
        "# description, so the port has to build the same set ahead of time.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp"',
        'rust_module = "renderpass/render_pass_tests"',
        "",
    ]

    for channel_class, count in variants:
        name = f"input_{channel_class}{count}"
        frag = SRC_DIR / f"{name}.frag"
        frag.write_text(fragment_shader(channel_class, count))

        lines += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "RENDER_PASS_{name.upper()}"',
            'rust_type = "InputProgram"',
            "programs = [",
            '    { name = "0-vert", template = "renderpass/render_pass.vert", stage = "vert" },',
            '    { name = "0-frag", template = "renderpass/render_pass_grid.frag", stage = "frag" },',
            '    { name = "1-vert", template = "renderpass/render_pass.vert", stage = "vert" },',
            f'    {{ name = "1-frag", template = "renderpass/generated/{name}.frag", stage = "frag" }},',
            "]",
            "[case.params]",
            f'attachment_type = {{ type = "str", value = "{grid_type(channel_class)}" }}',
            f'input_channel_class = {{ type = "str", value = "{channel_class}" }}',
            f'input_component_count = {{ type = "u32", value = {count} }}',
            "",
        ]

    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {len(variants)} shaders in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


def grid_type(channel_class: str) -> str:
    """`getAttachmentType` for the subpass-0 shader, `useFormatCompCount` false."""
    return {"sint": "ivec4", "uint": "uvec4"}.get(channel_class, "vec4")


if __name__ == "__main__":
    sys.exit(main())

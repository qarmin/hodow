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


def input_attachment_type(channel_class: str, multisample: bool) -> str:
    """`getInputAttachmentType`"""
    base = {"sint": "isubpassInput", "uint": "usubpassInput"}.get(channel_class, "subpassInput")
    return base + "MS" if multisample else base


def fragment_shader(channel_class: str, input_component_count: int, output_component_count: int, output_type: str, attachment_index: int, multisample: bool) -> str:
    """`createSubpassShaders` for the input-reading subpass, which is always subpass 1.

    `index` is `subpassNdx + attachmentIndex + outputValueNdx` and outputValueNdx only
    advances once per attachment, so every component of one attachment shares it - that
    is not the same rule the no-input branch uses, which adds compNdx as well.
    """
    # `inputsPerOutput`
    inputs_per_output = (
        (input_component_count // output_component_count) + (1 if input_component_count % output_component_count else 0)
        if input_component_count >= output_component_count
        else 1
    )

    input_type = input_attachment_type(channel_class, multisample)
    load = "subpassLoad(i_color0, gl_SampleID)" if multisample else "subpassLoad(i_color0)"

    out = ["#version 450"]
    out.append(f"layout(input_attachment_index = 0, set=0, binding=0) uniform highp {input_type} i_color0;")
    out.append(f"layout(location = 0) out highp {output_type} o_color0;")
    out.append("void main (void) {")
    out.append(f"\tbool inputs[{input_component_count}];")
    out.append(f"\tbool outputs[{output_component_count}];")

    for comp_ndx in range(input_component_count):
        out.append(f"\tinputs[{comp_ndx}] = 1.0 == float({load}.{COMPONENTS[comp_ndx]});")

    index = 1 + attachment_index  # subpassNdx + attachmentIndex + outputValueNdx(0)
    for comp_ndx in range(output_component_count):
        out.append(f"\toutputs[{comp_ndx}] = (int(gl_FragCoord.x) % 2 == {index % 2}) {bool_op(index)} (int(gl_FragCoord.y) % 2 == {(index // 2) % 2});")
        for i in range(inputs_per_output):
            src = (comp_ndx * inputs_per_output + i) % input_component_count
            out.append(f"\toutputs[{comp_ndx}] = outputs[{comp_ndx}] == inputs[{src}];")

    # `useFormatCompCount` is false, so the write is always four components wide and
    # the ones the attachment does not have are written as 0.
    values = [f"outputs[{i}]" if i < output_component_count else "0" for i in range(4)]
    out.append(f"\to_color0 = {output_type}(" + ", ".join(values) + ");")
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

    combos = sorted({classify(f) for f in formats})

    # Two families. The `input` cases read attachment 0 and write attachment 1, which
    # is always R8G8B8A8_UNORM; the `self_dep` cases read and write attachment 0
    # itself, so the output type and channel count follow the source format, and they
    # come in a multisampled flavour as well.
    variants = []
    for channel_class, count in combos:
        variants.append(
            {
                "name": f"input_{channel_class}{count}",
                "channel_class": channel_class,
                "input_count": count,
                "output_count": 4,
                "output_type": "vec4",
                "attachment_index": 1,
                "multisample": False,
            }
        )
    for channel_class, count in combos:
        for multisample in (False, True):
            variants.append(
                {
                    "name": f"self_dep_{channel_class}{count}" + ("_ms" if multisample else ""),
                    "channel_class": channel_class,
                    "input_count": count,
                    "output_count": count,
                    "output_type": grid_type(channel_class),
                    "attachment_index": 0,
                    "multisample": multisample,
                }
            )

    print(f"{len(formats)} formats -> {len(combos)} class/count combos -> {len(variants)} shader variants")

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

    for v in variants:
        frag = SRC_DIR / f"{v['name']}.frag"
        frag.write_text(fragment_shader(v["channel_class"], v["input_count"], v["output_count"], v["output_type"], v["attachment_index"], v["multisample"]))

        lines += [
            "[[case]]",
            f'name = "{v["name"]}"',
            f'rust_const = "RENDER_PASS_{v["name"].upper()}"',
            'rust_type = "InputProgram"',
            "programs = [",
            '    { name = "0-vert", template = "renderpass/render_pass.vert", stage = "vert" },',
            '    { name = "0-frag", template = "renderpass/render_pass_grid.frag", stage = "frag" },',
            '    { name = "1-vert", template = "renderpass/render_pass.vert", stage = "vert" },',
            f'    {{ name = "1-frag", template = "renderpass/generated/{v["name"]}.frag", stage = "frag" }},',
            "]",
            "[case.params]",
            f'attachment_type = {{ type = "str", value = "{grid_type(v["channel_class"])}" }}',
            f'input_channel_class = {{ type = "str", value = "{v["channel_class"]}" }}',
            f'input_component_count = {{ type = "u32", value = {v["input_count"]} }}',
            f'output_component_count = {{ type = "u32", value = {v["output_count"]} }}',
            f'output_attachment_index = {{ type = "u32", value = {v["attachment_index"]} }}',
            f'multisample = {{ type = "bool", value = {"true" if v["multisample"] else "false"} }}',
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

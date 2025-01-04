#!/usr/bin/env python3
"""Generate the fragment shaders of the `attachment` and `simple` renderpass groups, their manifest and the Rust lookup table.

`RenderPassTestCase::initPrograms` builds one fragment shader per subpass from the render pass description, so upstream
emits one per case. For the groups ported in `render_pass_tests/attachment_tests.rs` that description is either fixed
(`simple`) or drawn from `de::Random(1433774382)` (`attachment`: 700 cases), so this script replays the same draws, keeps the
parts that reach a shader - which colour attachments each subpass writes, as which GLSL type, and whether it writes depth -
and emits each distinct combination once.

The key a case is looked up by is `render_pass_tests::attachment_signature`; the two have to produce the same string:
one entry per subpass joined by `|`, each a comma separated list of colour attachments (`f0`, `i1`, `u2`; `xf` for a
reference to VK_ATTACHMENT_UNUSED, whose type comes from the attachment at the same position) followed by `+d<true>_<false>` when
the subpass writes gl_FragDepth with those two depth values. The `attachment_write_mask` cases (`useFormatCompCount` true) give
each colour token a `c<components>` suffix and start the whole signature with `w<drawStartNdx>/`; their shaders declare and
write only the outputs from `drawStartNdx` on, typed by the format's own component count.

The `attachment_allocation` cases (`allocation_cases`) are keyed `alloc/<group>/<case>` instead: the render passes of the
`input_output` group have inputs, depth/stencil attachments and shapes that depend on a long chain of draws (`de::Random(3700649827)`),
so the host replays the same chain and looks the case up by its place in it. `alloc_fragment_shader` is the general form of
`RenderPassTestCase::initPrograms` that those subpasses need.

Usage:
    python3 hodow_cts/scripts/gen_renderpass_attachment_shaders.py
"""

from __future__ import annotations

import hashlib
import re
import struct
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from de_random import DeRandom, MASK, to_f32  # noqa: E402

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "renderpass" / "generated"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "renderpass_render_pass_attachment.toml"
RUST_TABLE = CRATE_DIR / "src" / "vkt" / "tests" / "renderpass" / "render_pass_tests" / "attachment_programs.rs"
FORMAT_LIST = CRATE_DIR / "src" / "vkt" / "tests" / "renderpass" / "render_pass_tests.rs"

BOOL_OPS = ["||", "&&", "==", "!="]
DEPTH_VALUES = [0, 255, 1]
NUM_CORE_COLOR_FORMATS = 48
NUM_DEPTH_STENCIL_FORMATS = 5


def bool_op(index: int) -> str:
    return BOOL_OPS[index % 4]


def get_bool(rng: DeRandom) -> bool:
    return (rng.get_uint32() & 0xFFFFFF) < 0x800000


def choose(rng: DeRandom, count: int) -> int:
    """`de::Random::choose` over `count` items, which draws once per item past the first."""
    chosen = 0
    for ndx in range(1, count):
        if rng.get_int(0, ndx) < 1:
            chosen = ndx
    return chosen


def depth_values_for(seed: int) -> tuple[int, int]:
    """`TestConfig`'s constructor: the first two of `DEPTH_VALUES` after a shuffle seeded with `seed + 1`."""
    rng = DeRandom((seed + 1) & MASK)
    values = list(DEPTH_VALUES)
    for i in range(len(values) - 1, 0, -1):
        j = rng.get_int(0, i)
        values[i], values[j] = values[j], values[i]
    return values[0], values[1]


def read_core_color_formats() -> list[str]:
    text = FORMAT_LIST.read_text()
    i = text.index("pub static CORE_COLOR_FORMATS")
    j = text.index("];", i)
    names = re.findall(r'"([a-z0-9_]+)"', text[i:j])
    # The last entry is `VK_FORMAT_A8_UNORM_KHR`, appended to upstream's own list by the `formats` group.
    assert names[-1] == "a8_unorm", names[-1]
    names = names[:-1]
    assert len(names) == NUM_CORE_COLOR_FORMATS, len(names)
    return names


def channel_class(name: str) -> str:
    if name.endswith("_sint") or "_sint_" in name:
        return "i"
    if name.endswith("_uint") or "_uint_" in name:
        return "u"
    return "f"


GLSL_TYPE = {"f": "vec4", "i": "ivec4", "u": "uvec4"}


def subpass_signature(colors: list[tuple], depth: tuple[int, int] | None) -> str:
    tokens = []
    for color in colors:
        ty, ndx = color[0], color[1]
        token = f"x{ty}" if ndx is None else f"{ty}{ndx}"
        if len(color) > 2:
            token += f"c{color[2]}"
        tokens.append(token)
    sig = ",".join(tokens)
    if depth is not None:
        sig += f"+d{depth[0]}_{depth[1]}"
    return sig


def glsl_type(ty: str, comp_count: int | None) -> str:
    """`getAttachmentType`"""
    if comp_count is None:
        return GLSL_TYPE[ty]
    scalar = {"f": "float", "i": "int", "u": "uint"}[ty]
    vector = {"f": "vec", "i": "ivec", "u": "uvec"}[ty]
    return scalar if comp_count == 1 else f"{vector}{comp_count}"


def fragment_shader(subpass_ndx: int, colors: list[tuple], depth: tuple[int, int] | None, draw_start: int = 0) -> str:
    """`RenderPassTestCase::initPrograms`, the branch for a subpass without input attachments."""
    out = ["#version 450"]
    for color_ndx, color in enumerate(colors):
        if color_ndx < draw_start:
            continue
        comp_count = color[2] if len(color) > 2 else None
        out.append(f"layout(location = {color_ndx}) out highp {glsl_type(color[0], comp_count)} o_color{color_ndx};")
    out.append("void main (void) {")
    for color_ndx, color in enumerate(colors):
        if color_ndx < draw_start:
            continue
        ty, attachment_ndx = color[0], color[1]
        comp_count = color[2] if len(color) > 2 else None
        if attachment_ndx is None:
            continue
        glsl = glsl_type(ty, comp_count)
        comps = []
        for comp in range(comp_count if comp_count is not None else 4):
            index = subpass_ndx + attachment_ndx + comp
            comps.append(
                f"((int(gl_FragCoord.x) % 2 == {index % 2}) {bool_op(index)} (int(gl_FragCoord.y) % 2 == {(index // 2) % 2}) ? 1.0 : 0.0)"
            )
        out.append(f"\to_color{color_ndx} = {glsl}({glsl}(" + ",\n\t\t".join(comps) + "));")
    if depth is not None:
        index = subpass_ndx + 1
        out.append(
            f"\tgl_FragDepth = ((int(gl_FragCoord.x) % 2 == {index % 2}) {bool_op(index)} "
            f"(int(gl_FragCoord.y) % 2 == {(index // 2) % 2}) ? {depth[1]}.0f/255.0f : {depth[0]}.0f/255.0f);"
        )
    out.append("}")
    return "\n".join(out) + "\n"


def attachment_cases(formats: list[str]) -> list[list[tuple[list[tuple[str, int | None]], bool]]]:
    """The `addAttachmentTests` draws: per case, the subpass colour list and whether the case draws.

    Only what reaches a shader is kept, but every draw has to be made because each one moves the stream.
    """
    attachment_counts = [1, 3, 4, 8]
    rng = DeRandom(1433774382)
    cases = []
    for attachment_count in attachment_counts:
        test_case_count = 100 if attachment_count == 1 else 200
        for _ in range(test_case_count):
            use_depth_stencil = get_bool(rng)
            image_memory = choose(rng, 3)  # strict, lazy, strict | lazy
            strict = image_memory == 0
            colors = []
            for attachment_ndx in range(attachment_count):
                format_ndx = choose(rng, NUM_CORE_COLOR_FORMATS)
                choose(rng, 3)  # loadOp
                choose(rng, 2)  # storeOp
                choose(rng, 5 if strict else 3)  # initialLayout
                choose(rng, 5 if strict else 3)  # finalizeLayout
                choose(rng, 2)  # subpassLayout
                choose(rng, 3)  # stencilLoadOp
                choose(rng, 2)  # stencilStoreOp
                colors.append((channel_class(formats[format_ndx]), attachment_ndx))
            if use_depth_stencil:
                choose(rng, NUM_DEPTH_STENCIL_FORMATS)
                choose(rng, 3)  # loadOp
                choose(rng, 2)  # storeOp
                choose(rng, 6 if strict else 4)  # initialLayout
                choose(rng, 6 if strict else 4)  # finalizeLayout
                choose(rng, 3)  # stencilLoadOp
                choose(rng, 2)  # stencilStoreOp
                choose(rng, 2)  # depthStencilLayout
            render = choose(rng, 4)  # none, clear, draw, clear | draw
            choose(rng, 3)  # commandBuffer
            choose(rng, 2)  # targetSize
            choose(rng, 2)  # renderPos
            choose(rng, 2)  # renderSize
            draws = render in (2, 3)
            cases.append(([(colors, use_depth_stencil)], draws))
    return cases


ALLOC_TYPES = ["grow", "shrink", "roll", "grow_shrink", "input_output_chain", "input_output"]
ALLOC_SEED = 3700649827
ALLOC_CASES_PER_TYPE = 100

# `s_coreDepthStencilFormats`: (has depth, has stencil, shader channels, unorm bits of `requiredDepthEpsilon`).
DS_FORMATS = [
    (True, False, 1, 16),
    (True, False, 1, 24),
    (True, False, 1, 0),
    (True, True, 2, 24),
    (True, True, 2, 0),
]


def color_components(name: str) -> int:
    """`getShaderNumChannels` of a core colour format, from the channel letters of its name."""
    head = name.split("_")[0]
    return len(re.findall(r"[rgba](?=\d)", head))


def choose_n(rng: DeRandom, items: list, count: int) -> list:
    """`de::Random::choose(first, last, out, count)`: the reservoir, which draws once per item past the first `count`."""
    result: list = []
    for ndx, item in enumerate(items):
        if ndx < count:
            result.append(item)
        else:
            r = rng.get_int(0, ndx)
            if r < count:
                result[r] = item
    return result


def depth_epsilon(unorm_bits: int) -> str:
    """`requiredDepthEpsilon` as `std::fixed << std::setprecision(12)` prints the float."""
    if unorm_bits == 0:
        return "0.000000000000"
    value = struct.unpack("<f", struct.pack("<f", 1.0 / ((1 << unorm_bits) - 1)))[0]
    return f"{value:.12f}"


def allocation_cases(formats: list[str]) -> list[dict]:
    """The `addAttachmentAllocationTests` draws for the render pass entry points (dynamic rendering skips the two input/output groups).

    Each case keeps what reaches a shader: per attachment its kind, per subpass the input, colour and depth/stencil attachments.
    Every draw has to be made, because each one moves the stream.
    """
    rng = DeRandom(ALLOC_SEED)
    cases = []

    for type_name in ALLOC_TYPES:
        for case_ndx in range(ALLOC_CASES_PER_TYPE):
            strict = choose(rng, 3) == 0
            attachments: list[tuple] = []  # ("c", format name) or ("d", ds format index)
            subpasses: list[tuple[list[int], list[int], int | None]] = []

            if type_name == "input_output":
                attachment_count = 4 + rng.get_uint32() % 31
                subpass_count = 4 + rng.get_uint32() % 31
                defined: set[int] = set()
                color_set: set[int] = set()
                ds_set: set[int] = set()

                for attachment_ndx in range(attachment_count):
                    is_ds = rng.get_float() < to_f32(0.01)
                    load_op = choose(rng, 3)
                    choose(rng, 2)  # storeOp
                    layout_count = 6 if is_ds else (5 if strict else 3)
                    choose(rng, layout_count)  # initialLayout
                    choose(rng, layout_count)  # finalizeLayout
                    stencil_load_op = choose(rng, 3)
                    choose(rng, 2)  # stencilStoreOp
                    if is_ds:
                        attachments.append(("d", choose(rng, NUM_DEPTH_STENCIL_FORMATS)))
                        if load_op < 2 or stencil_load_op < 2:
                            defined.add(attachment_ndx)
                        ds_set.add(attachment_ndx)
                    else:
                        attachments.append(("c", choose(rng, NUM_CORE_COLOR_FORMATS)))
                        if load_op < 2:
                            defined.add(attachment_ndx)
                        color_set.add(attachment_ndx)

                last_use: list[int | None] = [None] * len(attachments)

                for subpass_ndx in range(subpass_count):
                    if not ds_set:
                        color_count = 1 + rng.get_uint32() % min(4, len(color_set))
                    else:
                        color_count = rng.get_uint32() % (min(4, len(color_set)) + 1)
                    input_count = rng.get_uint32() % (min(4, len(defined)) + 1)
                    use_ds = bool(ds_set) and (color_count == 0 or get_bool(rng))
                    ds_attachment = None
                    if use_ds:
                        ordered = sorted(ds_set)
                        ds_attachment = ordered[rng.get_uint32() % len(ordered)]
                    subpass_colors = choose_n(rng, sorted(color_set), color_count)
                    subpass_inputs = choose_n(rng, sorted(defined), input_count)

                    defined.update(subpass_colors)
                    if ds_attachment is not None:
                        defined.add(ds_attachment)

                    input_refs: list[int] = []
                    for color in subpass_colors:
                        if last_use[color] is not None:
                            get_bool(rng)  # dependencyFlags
                        last_use[color] = subpass_ndx

                    for input_ndx in subpass_inputs:
                        if last_use[input_ndx] is not None:
                            if last_use[input_ndx] != subpass_ndx:
                                get_bool(rng)  # dependencyFlags, unless the attachment is written by this subpass already
                            last_use[input_ndx] = subpass_ndx
                            input_refs.append(input_ndx)

                    if ds_attachment is not None:
                        if last_use[ds_attachment] is not None and last_use[ds_attachment] != subpass_ndx:
                            get_bool(rng)  # dependencyFlags
                        last_use[ds_attachment] = subpass_ndx

                    for color in subpass_colors:
                        if color not in input_refs:
                            choose(rng, 2)  # a colour layout
                    for input_ndx in input_refs:
                        if input_ndx not in subpass_colors and input_ndx != ds_attachment:
                            choose(rng, 2)  # an input layout
                    if ds_attachment not in input_refs:
                        choose(rng, 2)  # the depth/stencil layout, drawn even for an unused reference

                    subpasses.append((input_refs, subpass_colors, ds_attachment))
            else:
                attachment_count = [4, 8][choose(rng, 2)]
                for _ in range(attachment_count):
                    attachments.append(("c", choose(rng, NUM_CORE_COLOR_FORMATS)))
                    choose(rng, 3)  # loadOp
                    choose(rng, 2)  # storeOp
                    layout_count = 5 if strict else 3
                    choose(rng, layout_count)  # initialLayout
                    choose(rng, layout_count)  # finalizeLayout
                    choose(rng, 3)  # stencilLoadOp
                    choose(rng, 2)  # stencilStoreOp

                def color_subpass(indices: list[int]) -> None:
                    for _ in indices:
                        choose(rng, 2)  # subpassLayout
                    subpasses.append(([], list(indices), None))

                if type_name == "grow":
                    for subpass_ndx in range(attachment_count):
                        color_subpass(list(range(subpass_ndx + 1)))
                elif type_name == "shrink":
                    for subpass_ndx in range(attachment_count):
                        color_subpass(list(range(attachment_count - subpass_ndx)))
                elif type_name == "roll":
                    for subpass_ndx in range(attachment_count // 2):
                        color_subpass([subpass_ndx + attachment_ndx for attachment_ndx in range(attachment_count // 2)])
                elif type_name == "grow_shrink":
                    for subpass_ndx in range(attachment_count):
                        color_subpass(list(range(subpass_ndx + 1)))
                    for subpass_ndx in range(attachment_count):
                        color_subpass(list(range(attachment_count - subpass_ndx)))
                else:
                    choose(rng, 2)
                    subpasses.append(([], [0], None))
                    for subpass_ndx in range(1, attachment_count):
                        choose(rng, 2)
                        subpasses.append(([subpass_ndx - 1], [subpass_ndx], None))

            choose(rng, 4)  # render types
            choose(rng, 3)  # command buffer types
            choose(rng, 2)  # target size
            choose(rng, 2)  # render position
            choose(rng, 2)  # render size

            if type_name != "input_output":
                for _ in range(len(subpasses) - 1):
                    get_bool(rng)  # byRegion

            cases.append({"type": type_name, "ndx": case_ndx, "attachments": attachments, "subpasses": subpasses})

    return cases


def alloc_fragment_shader(subpass_ndx: int, subpass: tuple, attachments: list[tuple], formats: list[str], depth: tuple[int, int]) -> str:
    """`RenderPassTestCase::initPrograms`, the general form of one subpass of an `attachment_allocation` case."""
    inputs, colors, ds = subpass

    def color_class(attachment_ndx: int) -> str:
        return channel_class(formats[attachments[attachment_ndx][1]])

    def components(attachment_ndx: int) -> int:
        kind, fmt = attachments[attachment_ndx]
        return DS_FORMATS[fmt][2] if kind == "d" else color_components(formats[fmt])

    if not inputs:
        return fragment_shader(subpass_ndx, [(color_class(c), c) for c in colors], depth if ds is not None else None)

    input_types = {"f": "subpassInput", "i": "isubpassInput", "u": "usubpassInput"}
    out = ["#version 450"]
    binding = 0
    has_depth_input = False

    for input_ndx, attachment_ndx in enumerate(inputs):
        kind, fmt = attachments[attachment_ndx]
        if kind == "d":
            if DS_FORMATS[fmt][0]:
                has_depth_input = True
                out.append(f"layout(input_attachment_index = {input_ndx}, set=0, binding={binding}) uniform highp subpassInput i_depth{input_ndx};")
                binding += 1
            if DS_FORMATS[fmt][1]:
                out.append(f"layout(input_attachment_index = {input_ndx}, set=0, binding={binding}) uniform highp usubpassInput i_stencil{input_ndx};")
                binding += 1
        else:
            out.append(
                f"layout(input_attachment_index = {input_ndx}, set=0, binding={binding}) uniform highp {input_types[color_class(attachment_ndx)]} i_color{input_ndx};"
            )
            binding += 1

    for color_ndx, attachment_ndx in enumerate(colors):
        out.append(f"layout(location = {color_ndx}) out highp {GLSL_TYPE[color_class(attachment_ndx)]} o_color{color_ndx};")

    if has_depth_input:
        out.append("\nbool depthsEqual(float a, float b, float epsilon) {\n\treturn abs(a - b) <= epsilon;\n}\n")

    out.append("void main (void) {")

    input_components = sum(components(a) for a in inputs)
    output_components = sum(components(a) for a in colors) + (1 if ds is not None else 0)

    if output_components > 0:
        inputs_per_output = (input_components // output_components) + (1 if input_components % output_components else 0) if input_components >= output_components else 1
        out.append(f"\tbool inputs[{input_components}];")
        out.append(f"\tbool outputs[{output_components}];")

        input_value_ndx = 0
        for input_ndx, attachment_ndx in enumerate(inputs):
            kind, fmt = attachments[attachment_ndx]
            if kind == "d":
                if DS_FORMATS[fmt][0]:
                    out.append(
                        f"\tinputs[{input_value_ndx}] = depthsEqual({depth[1]}.0f/255.0f, float(subpassLoad(i_depth{input_ndx}).x), {depth_epsilon(DS_FORMATS[fmt][3])});"
                    )
                    input_value_ndx += 1
                if DS_FORMATS[fmt][1]:
                    out.append(f"\tinputs[{input_value_ndx}] = 255u == subpassLoad(i_stencil{input_ndx}).x;")
                    input_value_ndx += 1
            else:
                for comp in range(components(attachment_ndx)):
                    out.append(f"\tinputs[{input_value_ndx}] = 1.0 == float(subpassLoad(i_color{input_ndx}).{'xyzw'[comp]});")
                    input_value_ndx += 1

        output_value_ndx = 0
        for color_ndx, attachment_ndx in enumerate(colors):
            comp_count = components(attachment_ndx)
            index = subpass_ndx + attachment_ndx + output_value_ndx
            for comp in range(comp_count):
                o = output_value_ndx + comp
                out.append(f"\toutputs[{o}] = (int(gl_FragCoord.x) % 2 == {index % 2}) {bool_op(index)} (int(gl_FragCoord.y) % 2 == {(index // 2) % 2});")
                for i in range(inputs_per_output):
                    out.append(f"\toutputs[{o}] = outputs[{o}] == inputs[{(o * inputs_per_output + i) % input_components}];")
            values = [f"outputs[{output_value_ndx + comp}]" if comp < comp_count else "0" for comp in range(4)]
            out.append(f"\to_color{color_ndx} = {GLSL_TYPE[color_class(attachment_ndx)]}({', '.join(values)});")
            output_value_ndx += comp_count

        if ds is not None:
            index = subpass_ndx + ds
            out.append(f"\toutputs[{output_value_ndx}] = (int(gl_FragCoord.x) % 2 == {index % 2}) {bool_op(index)} (int(gl_FragCoord.y) % 2 == {(index // 2) % 2});")
            for i in range(inputs_per_output):
                out.append(f"\toutputs[{output_value_ndx}] = outputs[{output_value_ndx}] == inputs[{(output_value_ndx * inputs_per_output + i) % input_components}];")
            out.append(f"\tgl_FragDepth = outputs[{output_value_ndx}] ? {depth[1]}.0f/255.0f : {depth[0]}.0f/255.0f;")

    out.append("}")
    return "\n".join(out) + "\n"


def main() -> int:
    formats = read_core_color_formats()
    pair_attachment = depth_values_for(1293809)
    pair_simple = depth_values_for(90239)

    # signature -> (drawStartNdx, [(subpass_ndx, colors, depth)])
    variants: dict[str, tuple[int, list]] = {}

    def add(subpasses: list, draw_start: int | None = None) -> None:
        sig = "|".join(subpass_signature(c, d) for c, d in subpasses)
        if draw_start is not None:
            sig = f"w{draw_start}/" + sig
        variants.setdefault(sig, (draw_start or 0, [(i, c, d) for i, (c, d) in enumerate(subpasses)]))

    n_attachment_cases = 0
    for subpasses, draws in attachment_cases(formats):
        n_attachment_cases += 1
        if not draws:
            continue
        for colors, use_depth_stencil in subpasses:
            add([(colors, pair_attachment if use_depth_stencil else None)])

    # `addSimpleTests`: the cases whose shaders the older families do not cover.
    add([([("f", 0)], pair_simple)])  # color_depth, color_stencil, color_depth_stencil
    add([([], None)])  # no_attachments
    add([([("f", 0)], None), ([("f", None)], None)])  # color_unused_omit_blend_state

    # `addAttachmentWriteMaskTests`: formats cycle through four, every start index of every count.
    write_mask_formats = [("u", 4), ("f", 4), ("f", 3), ("f", 2)]
    for attachment_count in (1, 2, 3, 4, 8):
        colors = [(write_mask_formats[ndx % 4][0], ndx, write_mask_formats[ndx % 4][1]) for ndx in range(attachment_count)]
        for draw_start in range(attachment_count):
            add([(colors, None)], draw_start)

    # A single colour attachment with nothing else is the grid shader `render_pass_tests::programs_for_config` owns, and a
    # subpass with no colour output and a depth attachment is `depth_programs_for`'s; neither needs an entry here.
    for sig in [s for s in variants if s in {"f0", "i0", "u0"}]:
        del variants[sig]

    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for existing in SRC_DIR.glob("att_*.frag"):
        existing.unlink()

    lines = [
        "# Shader manifest for dEQP-VK.renderpasses.renderpass{1,2}.*.{simple,attachment,attachment_write_mask}.*",
        "#",
        "# Generated by scripts/gen_renderpass_attachment_shaders.py together with the GLSL it names;",
        "# do not hand-edit either. See that script for how the entries are keyed.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp"',
        'rust_module = "renderpass/render_pass_tests"',
        "",
    ]
    table = []

    for ndx, (sig, (draw_start, subpasses)) in enumerate(sorted(variants.items())):
        name = f"att_{ndx:04d}"
        programs = []
        for subpass_ndx, colors, depth in subpasses:
            text = fragment_shader(subpass_ndx, colors, depth, draw_start)
            digest = hashlib.sha1(text.encode()).hexdigest()[:12]
            frag_name = f"att_{digest}"
            (SRC_DIR / f"{frag_name}.frag").write_text(text)
            programs.append(f'    {{ name = "{subpass_ndx}-vert", template = "renderpass/render_pass.vert", stage = "vert" }},')
            programs.append(f'    {{ name = "{subpass_ndx}-frag", template = "renderpass/generated/{frag_name}.frag", stage = "frag" }},')
        const = f"RENDER_PASS_{name.upper()}"
        lines += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "{const}"',
            'rust_type = "AttachmentProgram"',
            "programs = [",
            *programs,
            "]",
            "[case.params]",
            f'signature = {{ type = "str", value = "{sig}" }}',
            "",
        ]
        table.append(const)

    # `addAttachmentAllocationTests`: one entry per case, found by `alloc/<group>/<case>` rather than by what the render pass says,
    # because the shaders of the input/output groups depend on random draws that the host replays in the same order.
    alloc_depth = depth_values_for(80329)
    alloc_cases = allocation_cases(formats)
    for case in alloc_cases:
        name = f"alloc_{case['type']}_{case['ndx']:03d}"
        programs = []
        for subpass_ndx, subpass in enumerate(case["subpasses"]):
            text = alloc_fragment_shader(subpass_ndx, subpass, case["attachments"], formats, alloc_depth)
            digest = hashlib.sha1(text.encode()).hexdigest()[:12]
            frag_name = f"att_{digest}"
            (SRC_DIR / f"{frag_name}.frag").write_text(text)
            programs.append(f'    {{ name = "{subpass_ndx}-vert", template = "renderpass/render_pass.vert", stage = "vert" }},')
            programs.append(f'    {{ name = "{subpass_ndx}-frag", template = "renderpass/generated/{frag_name}.frag", stage = "frag" }},')
        const = f"RENDER_PASS_{name.upper()}"
        lines += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "{const}"',
            'rust_type = "AttachmentProgram"',
            "programs = [",
            *programs,
            "]",
            "[case.params]",
            f'signature = {{ type = "str", value = "alloc/{case["type"]}/{case["ndx"]}" }}',
            "",
        ]
        table.append(const)

    MANIFEST.write_text("\n".join(lines))

    rust = [
        "// @generated by hodow_cts/scripts/gen_renderpass_attachment_shaders.py - do not hand-edit.",
        "",
        "use super::AttachmentProgram;",
        "use crate::generated::shaders::renderpass_render_pass_attachment::*;",
        "",
        "/// Every entry the generator emitted, so the lookup is a search over what exists.",
        "pub(super) static ALL_ATTACHMENT_PROGRAMS: &[&AttachmentProgram] = &[",
        *[f"    &{const}," for const in table],
        "];",
        "",
    ]
    RUST_TABLE.write_text("\n".join(rust))

    print(f"{len(alloc_cases)} attachment_allocation cases")
    print(f"{n_attachment_cases} attachment cases -> {len(variants)} distinct shader sets (attachment depth values {pair_attachment}, simple {pair_simple})")
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)}, {RUST_TABLE.relative_to(REPO_DIR)} and {len(list(SRC_DIR.glob('att_*.frag')))} shaders")
    return 0


if __name__ == "__main__":
    sys.exit(main())

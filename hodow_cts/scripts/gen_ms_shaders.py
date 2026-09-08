#!/usr/bin/env python3
"""Generate the renderpasses multisample shaders and their manifest.

`Programs::init` in vktRenderPassMultisampleTests.cpp builds its GLSL from the
source format alone:

  * a depth format gets one fixed fragment shader that writes `gl_FragDepth`,
  * a stencil-only format gets one that only sets `gl_SampleMask`,
  * a colour format gets a shader whose body spreads ten bits of `gl_FragCoord`
    across the channels, and the constants in it come from that format's channel
    class, bit depth and value range - so every colour format gets its own.

The split (second-subpass) shader depends only on which aspects are tested (or the
channel class, for colour) and on `min(4, sampleCount)` outputs.

Rather than re-deriving tcu's format tables here, this script reads them out of the
port's own `src/tcu/{texture,pixel}.rs`, which `gen_texture_formats.py` already
extracts from upstream. The format list itself is read out of the `FORMATS` table in
`src/vkt/tests/renderpass/multisample_tests.rs`, so the shader set and the case tree
cannot drift apart.

Usage:
    python3 hodow_cts/scripts/gen_ms_shaders.py
"""

from __future__ import annotations

import re
import struct
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "renderpass" / "generated"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "renderpass_ms.toml"
TEXTURE_RS = CRATE_DIR / "src" / "tcu" / "texture.rs"
PIXEL_RS = CRATE_DIR / "src" / "tcu" / "pixel.rs"
TESTS_RS = CRATE_DIR / "src" / "vkt" / "tests" / "renderpass" / "multisample_tests.rs"

MAX_COLOR_ATTACHMENT_COUNT = 4
SAMPLE_COUNTS = (2, 4, 8, 16, 32)


# ---------------------------------------------------------------------------------
# tcu tables, read back out of the port's own generated Rust
# ---------------------------------------------------------------------------------


def fn_body(text: str, signature: str) -> str:
    start = text.index(signature)
    end = text.index("\n}\n", start)
    return text[start:end]


def load_tables() -> dict:
    texture = TEXTURE_RS.read_text()
    pixel = PIXEL_RS.read_text()

    map_vk = {}
    for m in re.finditer(r"vk::Format::(\w+) => Some\(TextureFormat::new\(ChannelOrder::(\w+), ChannelType::(\w+)\)\)", texture):
        map_vk[m.group(1)] = (m.group(2), m.group(3))

    body = fn_body(texture, "pub fn num_used_channels")
    num_used_channels = {m.group(1): int(m.group(2)) for m in re.finditer(r"Self::(\w+) => (\d+),", body)}

    body = fn_body(texture, "pub fn channel_class")
    channel_class = {m.group(1): m.group(2) for m in re.finditer(r"(\w+) => TextureChannelClass::(\w+),", body)}

    body = fn_body(pixel, "fn get_channel_read_swizzle")
    read_swizzle = {m.group(1): list(m.groups()[1:]) for m in re.finditer(r"(\w+) => \[(\w+), (\w+), (\w+), (\w+)\],", body)}

    body = fn_body(pixel, "pub fn get_channel_bit_depth")
    bit_depth = {m.group(1): [int(v) for v in m.groups()[1:]] for m in re.finditer(r"(\w+) => \[(-?\d+), (-?\d+), (-?\d+), (-?\d+)\],", body)}

    body = fn_body(pixel, "fn get_channel_mantissa_bit_depth")
    mantissa = dict(bit_depth)
    for m in re.finditer(r"(\w+) => \[(-?\d+); 4\],", body):
        mantissa[m.group(1)] = [int(m.group(2))] * 4
    for m in re.finditer(r"(\w+) => \[(-?\d+), (-?\d+), (-?\d+), (-?\d+)\],", body):
        mantissa[m.group(1)] = [int(v) for v in m.groups()[1:]]

    body = fn_body(pixel, "pub fn get_float_channel_value_range")
    value_range = {m.group(1): (float(m.group(2)), float(m.group(3))) for m in re.finditer(r"(\w+) => \((-?[\d.e+-]+), (-?[\d.e+-]+)\),", body)}

    formats = [(m.group(1), m.group(2)) for m in re.finditer(r"\(vk::Format::(\w+), \"([\w\d_]+)\"\),", TESTS_RS.read_text())]
    if len(formats) != 57:
        raise SystemExit(f"expected 57 formats in {TESTS_RS.name}, found {len(formats)}")

    return {
        "map_vk": map_vk,
        "num_used_channels": num_used_channels,
        "channel_class": channel_class,
        "read_swizzle": read_swizzle,
        "bit_depth": bit_depth,
        "mantissa": mantissa,
        "value_range": value_range,
        "formats": formats,
    }


T = load_tables()


def swizzled(chn: list[int], order: str) -> list[int]:
    out = [0, 0, 0, 0]
    for c, comp in enumerate(T["read_swizzle"][order]):
        if comp in ("C0", "C1", "C2", "C3"):
            out[c] = chn[int(comp[1])]
    return out


def channel_mask(order: str) -> list[bool]:
    return [comp in ("C0", "C1", "C2", "C3") for comp in T["read_swizzle"][order]]


def texture_format_bit_depth(order: str, type_: str) -> list[int]:
    return swizzled(T["bit_depth"][type_], order)


def texture_format_mantissa_bit_depth(order: str, type_: str) -> list[int]:
    return swizzled(T["mantissa"][type_], order)


def texture_format_info(order: str, type_: str) -> tuple[list[float], list[float]]:
    """`tcu::getTextureFormatInfo`, reduced to the (valueMin, valueMax) this test uses."""
    if type_ == "UNSIGNED_INT_1010102_REV":
        return [0.0] * 4, [1023.0, 1023.0, 1023.0, 3.0]
    if type_ == "SIGNED_INT_1010102_REV":
        return [-512.0, -512.0, -512.0, -2.0], [511.0, 511.0, 511.0, 1.0]
    if order in ("D", "DS"):
        return [0.0] * 4, [1.0, 1.0, 1.0, 255.0]
    if order == "RGBA" and type_ == "UNORM_SHORT_5551":
        return [0.0, 0.0, 0.0, 0.5], [1.0, 1.0, 1.0, 1.5]
    if type_ == "UNSIGNED_SHORT_5551":
        return [0.0] * 4, [31.0, 31.0, 31.0, 1.0]
    if type_ == "UNSIGNED_SHORT_565":
        return [0.0] * 4, [31.0, 63.0, 31.0, 0.0]

    c_min, c_max = T["value_range"][type_]
    mask = channel_mask(order)
    return [c_min if m else 0.0 for m in mask], [c_max if m else 0.0 for m in mask]


def f32(v: float) -> float:
    return struct.unpack("f", struct.pack("f", v))[0]


def fstr(v: float) -> str:
    """`std::ostream << float` - %g with the default precision of 6."""
    return f"{f32(v):g}"


def to_i32(v: int) -> int:
    v &= 0xFFFFFFFF
    return v - (1 << 32) if v >= (1 << 31) else v


# ---------------------------------------------------------------------------------
# `Programs::init`
# ---------------------------------------------------------------------------------

VERT = (
    "#version 450\n"
    "out gl_PerVertex {\n"
    "\tvec4 gl_Position;\n"
    "};\n"
    "highp float;\n"
    "void main (void) {\n"
    "\tgl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -3.0 : 1.0,\n"
    "\t                   ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 3.0, 0.0, 1.0);\n"
    "}\n"
)

FRAG_PROLOGUE = (
    "#version 450\n"
    "layout(push_constant) uniform PushConstant {\n"
    "\thighp uint sampleIndex;\n"
    "} pushConstants;\n"
    "void main (void)\n"
    "{\n"
    "\thighp uint sampleIndex = pushConstants.sampleIndex;\n"
)


def depth_frag() -> str:
    out = (
        "#version 450\n"
        "layout(push_constant) uniform PushConstant {\n"
        "\thighp uint sampleIndex;\n"
        "} pushConstants;\n"
        "void main (void)\n"
        "{\n"
        "\thighp uint sampleIndex = pushConstants.sampleIndex;\n"
        "\tgl_SampleMask[0] = int((~0x0u) << sampleIndex);\n"
        "\thighp float depth;\n"
        "\thighp uint x = sampleIndex ^ uint(gl_FragCoord.x);\n"
        "\thighp uint y = sampleIndex ^ uint(gl_FragCoord.y);\n"
    )
    out += f"\tdepth = {fstr(0.0)};\n"
    divider = 2
    for bit_ndx in range(10):
        out += f"\tdepth += {fstr(1.0 / divider)} * float(bitfieldExtract({'x' if bit_ndx % 2 == 0 else 'y'}, {bit_ndx // 2}, 1));\n"
        divider *= 2
    out += "\tgl_FragDepth = depth;\n}\n"
    return out


STENCIL_FRAG = (
    "#version 450\n"
    "layout(push_constant) uniform PushConstant {\n"
    "\thighp uint sampleIndex;\n"
    "} pushConstants;\n"
    "void main (void)\n"
    "{\n"
    "\thighp uint sampleIndex = pushConstants.sampleIndex;\n"
    "\tgl_SampleMask[0] = int((~0x0u) << sampleIndex);\n"
    "}\n"
)


def spread_bits(bits: list[int], component_count: int, emit) -> None:
    """The `while (nextSrcBit < min(bitSize, 10))` loop shared by all three classes."""
    bit_size = sum(bits)
    dst_bits_used = [0, 0, 0, 0]
    next_src_bit = 0
    divider = 2

    while next_src_bit < min(bit_size, 10):
        for comp_ndx in range(component_count):
            # upstream's `>` rather than `>=`; keep it, it decides the bit layout
            if dst_bits_used[comp_ndx] > bits[comp_ndx]:
                continue
            emit(comp_ndx, divider, "x" if next_src_bit % 2 == 0 else "y", next_src_bit // 2)
            next_src_bit += 1
            dst_bits_used[comp_ndx] += 1
        divider *= 2


def color_frag(order: str, type_: str, is_alpha_only: bool) -> str:
    cls = T["channel_class"][type_]
    body = []

    if cls == "UnsignedInteger":
        bits = texture_format_bit_depth(order, type_)
        min_value = [0] * 4
        rng = [1 << min(b, 31) for b in bits]
        out = (
            "#version 450\n"
            "layout(location = 0) out highp uvec4 o_color;\n"
            "layout(push_constant) uniform PushConstant {\n"
            "\thighp uint sampleIndex;\n"
            "} pushConstants;\n"
            "void main (void)\n"
            "{\n"
            "\thighp uint sampleIndex = pushConstants.sampleIndex;\n"
            "\tgl_SampleMask[0] = int(0x1u << sampleIndex);\n"
            "\thighp uint color[4];\n"
            "\thighp uint x = sampleIndex ^ uint(gl_FragCoord.x);\n"
            "\thighp uint y = sampleIndex ^ uint(gl_FragCoord.y);\n"
        )
        for ndx in range(4):
            out += f"\tcolor[{ndx}] = {min_value[ndx]};\n"
        spread_bits(
            bits,
            T["num_used_channels"][order],
            lambda c, divider, var, bit: body.append(f"\tcolor[{c}] += {rng[c] // divider} * bitfieldExtract({var}, {bit}, 1);\n"),
        )
        out += "".join(body)
        out += "\to_color = uvec4(color[0], color[1], color[2], color[3]);\n}\n"
        return out

    if cls == "SignedInteger":
        bits = texture_format_bit_depth(order, type_)
        min_value = [0] * 4
        rng = [to_i32(1 << min(b, 30)) for b in bits]
        max_v = [to_i32(1 << ((b - 1) & 31)) for b in bits]
        clamp_max = [to_i32(v - 1) for v in max_v]
        clamp_min = [to_i32(-v) for v in max_v]
        out = (
            "#version 450\n"
            "layout(location = 0) out highp ivec4 o_color;\n"
            "layout(push_constant) uniform PushConstant {\n"
            "\thighp uint sampleIndex;\n"
            "} pushConstants;\n"
            "void main (void)\n"
            "{\n"
            "\thighp uint sampleIndex = pushConstants.sampleIndex;\n"
            "\tgl_SampleMask[0] = int(0x1u << sampleIndex);\n"
            "\thighp int color[4];\n"
            "\thighp uint x = sampleIndex ^ uint(gl_FragCoord.x);\n"
            "\thighp uint y = sampleIndex ^ uint(gl_FragCoord.y);\n"
        )
        for ndx in range(4):
            out += f"\tcolor[{ndx}] = {min_value[ndx]};\n"
        spread_bits(
            bits,
            T["num_used_channels"][order],
            lambda c, divider, var, bit: body.append(f"\tcolor[{c}] += {int(rng[c] / divider)} * int(bitfieldExtract({var}, {bit}, 1));\n"),
        )
        out += "".join(body)
        out += (
            "\to_color = clamp(ivec4(color[0], color[1], color[2], color[3]), "
            f"ivec4({', '.join(str(v) for v in clamp_min)}), ivec4({', '.join(str(v) for v in clamp_max)}));\n"
            "}\n"
        )
        return out

    bits = texture_format_mantissa_bit_depth(order, type_)
    value_min, value_max = texture_format_info(order, type_)
    min_value = [f32(max(v, -65536.0)) for v in value_min]
    rng = [f32(min(value_max[i], 65536.0) - min_value[i]) for i in range(4)]
    out = (
        "#version 450\n"
        "layout(location = 0) out highp vec4 o_color;\n"
        "layout(push_constant) uniform PushConstant {\n"
        "\thighp uint sampleIndex;\n"
        "} pushConstants;\n"
        "void main (void)\n"
        "{\n"
        "\thighp uint sampleIndex = pushConstants.sampleIndex;\n"
        "\tgl_SampleMask[0] = int(0x1u << sampleIndex);\n"
        "\thighp float color[4];\n"
        "\thighp uint x = sampleIndex ^ uint(gl_FragCoord.x);\n"
        "\thighp uint y = sampleIndex ^ uint(gl_FragCoord.y);\n"
    )
    for ndx in range(4):
        out += f"\tcolor[{ndx}] = {fstr(min_value[ndx])};\n"
    spread_bits(
        bits,
        4 if is_alpha_only else T["num_used_channels"][order],
        lambda c, divider, var, bit: body.append(f"\tcolor[{c}] += {fstr(rng[c] / divider)} * float(bitfieldExtract({var}, {bit}, 1));\n"),
    )
    out += "".join(body)
    out += "\to_color = vec4(color[0], color[1], color[2], color[3]);\n}\n"
    return out


def ds_split_frag(test_depth: bool, test_stencil: bool, attachment_count: int) -> str:
    out = "#version 450\n"
    if test_depth and test_stencil:
        out += (
            "layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_depth;\n"
            "layout(input_attachment_index = 0, set = 0, binding = 1) uniform highp usubpassInputMS i_stencil;\n"
        )
    elif test_depth:
        out += "layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_depth;\n"
    elif test_stencil:
        out += "layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_stencil;\n"

    out += "layout(push_constant) uniform PushConstant {\n\thighp uint splitSubpassIndex;\n} pushConstants;\n"

    for ndx in range(attachment_count):
        kind = "vec2" if (test_depth and test_stencil) else "float"
        out += f"layout(location = {ndx}) out highp {kind} o_color{ndx};\n"

    out += "void main (void)\n{\n"
    for ndx in range(attachment_count):
        load = f"int({MAX_COLOR_ATTACHMENT_COUNT} * pushConstants.splitSubpassIndex + {ndx}u)"
        if test_depth:
            out += f"\thighp float depth{ndx} = subpassLoad(i_depth, {load}).x;\n"
        if test_stencil:
            out += f"\thighp uint stencil{ndx} = subpassLoad(i_stencil, {load}).x;\n"
        if test_depth and test_stencil:
            out += f"\to_color{ndx} = vec2(depth{ndx}, float(stencil{ndx}));\n"
        elif test_depth:
            out += f"\to_color{ndx} = float(depth{ndx});\n"
        elif test_stencil:
            out += f"\to_color{ndx} = float(stencil{ndx});\n"
    out += "}\n"
    return out


def color_split_frag(cls: str, attachment_count: int) -> str:
    subpass_type, output_type = {
        "u": ("usubpassInputMS", "uvec4"),
        "i": ("isubpassInputMS", "ivec4"),
        "f": ("subpassInputMS", "vec4"),
    }[cls]

    out = (
        "#version 450\n"
        f"layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp {subpass_type} i_color;\n"
        "layout(push_constant) uniform PushConstant {\n"
        "\thighp uint splitSubpassIndex;\n"
        "} pushConstants;\n"
    )
    for ndx in range(attachment_count):
        out += f"layout(location = {ndx}) out highp {output_type} o_color{ndx};\n"
    out += "void main (void)\n{\n"
    for ndx in range(attachment_count):
        out += f"\to_color{ndx} = subpassLoad(i_color, int({MAX_COLOR_ATTACHMENT_COUNT} * pushConstants.splitSubpassIndex + {ndx}u));\n"
    out += "}\n"
    return out


CLASS_SUFFIX = {
    "UnsignedInteger": "u",
    "SignedInteger": "i",
    "FloatingPoint": "f",
    "UnsignedFixedPoint": "f",
    "SignedFixedPoint": "f",
}


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)

    programs: list[tuple[str, str, str]] = [("quad_vert", "vert", VERT)]
    programs.append(("quad_frag_depth", "frag", depth_frag()))
    programs.append(("quad_frag_stencil", "frag", STENCIL_FRAG))

    for vk_format, format_name in T["formats"]:
        order, type_ = T["map_vk"][vk_format]
        if order in ("D", "S", "DS"):
            continue
        programs.append((f"quad_frag_{format_name}", "frag", color_frag(order, type_, order == "A")))

    attachment_counts = sorted({min(MAX_COLOR_ATTACHMENT_COUNT, s) for s in SAMPLE_COUNTS})
    for count in attachment_counts:
        for name, (d, s) in (("depth", (True, False)), ("stencil", (False, True)), ("depth_stencil", (True, True))):
            programs.append((f"quad_split_frag_{name}_{count}", "frag", ds_split_frag(d, s, count)))
        for cls in ("f", "u", "i"):
            programs.append((f"quad_split_frag_{cls}_{count}", "frag", color_split_frag(cls, count)))

    lines = [
        "# Shader manifest for dEQP-VK.renderpasses.renderpass{1,2}.suballocation.multisample.*",
        "#",
        "# Generated by scripts/gen_ms_shaders.py together with the GLSL it names; do not",
        "# hand-edit either. One case holding all of them: which shader a test uses follows",
        "# from its format and sample count, exactly as upstream's initPrograms decides it.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/renderpass/vktRenderPassMultisampleTests.cpp"',
        'rust_module = "renderpass/multisample_tests"',
        "",
        "[[case]]",
        'name = "ms"',
        'rust_const = "MS_PROGRAMS"',
        'rust_type = "MsPrograms"',
        "programs = [",
    ]
    for name, stage, source in programs:
        (SRC_DIR / f"ms_{name}.{stage}").write_text(source)
        lines.append(f'    {{ name = "{name}", template = "renderpass/generated/ms_{name}.{stage}", stage = "{stage}" }},')
    lines += ["]", ""]

    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {len(programs)} shaders in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

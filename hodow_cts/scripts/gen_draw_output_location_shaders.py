#!/usr/bin/env python3
"""Generate the shaders of dEQP-VK.draw.renderpass.output_location.array.* and their manifest.

The 28 Amber scripts under data/vulkan/amber/draw/output_location/array differ only in the colour type the vertex data has, the
type the fragment shader writes (`output-<type>` writes fewer components than the attachment holds) and the precision qualifier
of that output. Each one has three pairs of shaders: the array one that writes three attachments, the plain one that writes the
same colour to one attachment to make a reference, and the one that samples a framebuffer and its reference and writes green
when they agree (exactly for `highp`, within a distance for `mediump`).

Usage:
    python3 hodow_cts/scripts/gen_draw_output_location_shaders.py
"""

from __future__ import annotations

import hashlib
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "draw" / "output_location"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "draw_output_location.toml"

# prefix -> (type the shaders read the colour as, components of it); the order is upstream's.
FAMILIES = [
    ("b10g11r11-ufloat-pack32", "vec3", 3, ["", "float", "vec2"]),
    ("b8g8r8a8-unorm", "vec4", 4, ["", "vec2", "vec3"]),
    ("r16g16-sfloat", "vec2", 2, ["", "float"]),
    ("r32g32b32a32-sfloat", "vec4", 4, ["", "vec2", "vec3"]),
    ("r32-sfloat", "float", 1, [""]),
    ("r8g8-uint", "uvec2", 2, ["", "uint"]),
]
SWIZZLE = {1: ".x", 2: ".xy", 3: ".xyz", 4: ""}
OUT_COMPONENTS = {"float": 1, "uint": 1, "vec2": 2, "vec3": 3, "vec4": 4, "uvec2": 2}


def write(text: str, ext: str) -> str:
    digest = hashlib.sha1(text.encode()).hexdigest()[:12]
    name = f"ol_{digest}.{ext}"
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    (SRC_DIR / name).write_text(text)
    return f"draw/output_location/{name}"


def shaders(color: str, out: str, precision: str) -> list[tuple[str, str, str]]:
    integer = color.startswith("u")
    interp = "flat" if integer else "smooth"
    out_type = out or color
    out_swizzle = SWIZZLE[OUT_COMPONENTS[out]] if out else ""
    verify_swizzle = SWIZZLE[OUT_COMPONENTS[out_type]] if OUT_COMPONENTS[out_type] != 4 else ""
    sampler = "usampler2D" if integer else "sampler2D"
    threshold = "5" if integer else "0.1"

    vert = (
        "#version 430\n"
        "layout(location = 0) in vec2 position_in;\n"
        f"layout(location = 1) in {color} color_in[3];\n"
        f"layout(location = 0) {interp} out {color} color_out[3];\n"
        "\n"
        "void main()\n"
        "{\n"
        "    gl_Position = vec4(position_in, 0, 1);\n"
        "    for (int i = 0; i < 3; i++)\n"
        "        color_out[i] = color_in[i];\n"
        "}\n"
    )
    frag = (
        "#version 430\n"
        f"layout(location = 0) {interp} in {color} color_in[3];\n"
        f"layout(location = 0) out {precision} {out_type} frag_out[3];\n"
        "void main()\n"
        "{\n"
        "    for (int i = 0; i < 3; i++)\n"
        f"        frag_out[i] = color_in[i]{out_swizzle};\n"
        "}\n"
    )
    vert_ref = (
        "#version 430\n"
        "layout(location = 0) in vec2 position_in;\n"
        f"layout(location = 1) in {color} color_in;\n"
        f"layout(location = 0) {interp} out {color} color_out;\n"
        "\n"
        "void main()\n"
        "{\n"
        "\tgl_Position = vec4(position_in, 0, 1);\n"
        "    color_out = color_in;\n"
        "}\n"
    )
    frag_ref = (
        "#version 430\n"
        f"layout(location = 0) {interp} in {color} color_in;\n"
        f"layout(location = 0) out {precision} {out_type} frag_out;\n"
        "void main()\n"
        "{\n"
        f"    frag_out = color_in{out_swizzle};\n"
        "}\n"
    )
    vert_verify = (
        "#version 430\n"
        "layout(location = 0) in vec2 position_in;\n"
        "layout(location = 1) in vec2 texcoord_in;\n"
        "layout(location = 0) out vec2 texcoord_out;\n"
        "\n"
        "void main()\n"
        "{\n"
        "    gl_Position = vec4(position_in, 0, 1);\n"
        "    texcoord_out = texcoord_in;\n"
        "}\n"
    )
    compare = "result != ref" if precision == "highp" else f"distance(result, ref) > {threshold}"
    frag_verify = (
        "#version 430\n"
        "layout(location = 0) in vec2 texcoord_in;\n"
        "layout(location = 0) out vec4 frag_out;\n"
        f"uniform layout(set=0, binding=0) {sampler} result_sampler;\n"
        f"uniform layout(set=0, binding=1) {sampler} ref_sampler;\n"
        "void main()\n"
        "{\n"
        f"    {out_type} result = texture(result_sampler, texcoord_in){verify_swizzle};\n"
        f"    {out_type} ref = texture(ref_sampler, texcoord_in){verify_swizzle};\n"
        f"    if ({compare})\n"
        "        frag_out = vec4(1, 0, 0, 1);\n"
        "    else\n"
        "        frag_out = vec4(0, 1, 0, 1);\n"
        "}\n"
    )
    return [
        ("vert_shader", write(vert, "vert"), "vert"),
        ("frag_shader", write(frag, "frag"), "frag"),
        ("vert_shader_ref", write(vert_ref, "vert"), "vert"),
        ("frag_shader_ref", write(frag_ref, "frag"), "frag"),
        ("vert_shader_verify", write(vert_verify, "vert"), "vert"),
        ("frag_shader_verify", write(frag_verify, "frag"), "frag"),
    ]


PASSTHROUGH_VERT = (
    "#version 430\n"
    "layout(location = 0) in vec2 position_in;\n"
    "void main()\n"
    "{\n"
    "    gl_Position = vec4(position_in, 0, 1);\n"
    "}\n"
)


def shuffle_shaders() -> dict[str, list[tuple[str, str, str]]]:
    """The two Amber scripts of output_location/shuffle: outputs written at other locations than the inputs arrive at."""
    checker = "((int(gl_FragCoord.x) / 5) % 2) == ((int(gl_FragCoord.y) / 5) % 2)"
    plain_vert = (
        "#version 430\n"
        "layout(location = 0) in vec2 position_in;\n"
        "layout(location = 1) in vec4 color_in0;\n"
        "layout(location = 2) in vec4 color_in1;\n"
        "layout(location = 0) out vec4 color_out0;\n"
        "layout(location = 1) out vec4 color_out1;\n"
        "\n"
        "void main()\n"
        "{\n"
        "    gl_Position = vec4(position_in, 0, 1);\n"
        "    color_out0 = color_in0;\n"
        "    color_out1 = color_in1;\n"
        "}\n"
    )
    plain_frag = (
        "#version 430\n"
        "layout(location = 0) in vec4 color_in0;\n"
        "layout(location = 1) in vec4 color_in1;\n"
        "layout(location = 0) out vec4 frag_out0;\n"
        "layout(location = 1) out vec4 frag_out1;\n"
        "void main()\n"
        "{\n"
        f"    if ({checker})\n"
        "    {\n"
        "        frag_out0 = color_in0;\n"
        "        frag_out1 = color_in1;\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "        frag_out0 = color_in1;\n"
        "        frag_out1 = color_in0;\n"
        "    }\n"
        "}\n"
    )

    def ref_frag(first: str, second: str) -> str:
        return (
            "#version 430\n"
            "layout(location = 0) out vec4 frag_out;\n"
            "void main()\n"
            "{\n"
            f"    if ({checker})\n"
            f"        frag_out = vec4({first});\n"
            "    else\n"
            f"        frag_out = vec4({second});\n"
            "}\n"
        )

    first = [
        ("vert_shader", write(plain_vert, "vert"), "vert"),
        ("frag_shader", write(plain_frag, "frag"), "frag"),
        ("vert_shader_ref", write(PASSTHROUGH_VERT, "vert"), "vert"),
        ("frag_shader_ref0", write(ref_frag("1, 0, 0, 1", "0, 1, 0, 1"), "frag"), "frag"),
        ("frag_shader_ref1", write(ref_frag("0, 1, 0, 1", "1, 0, 0, 1"), "frag"), "frag"),
    ]

    mod_vert = (
        "#version 430\n"
        "layout(location = 0) in vec2 position_in;\n"
        "layout(location = 1) in vec4 color_in0;\n"
        "layout(location = 2) in uvec2 color_in1;\n"
        "layout(location = 3) in float color_in2;\n"
        "layout(location = 0) smooth out vec4 color_out0;\n"
        "layout(location = 1) flat out uvec2 color_out1;\n"
        "layout(location = 2) smooth out float color_out2;\n"
        "\n"
        "void main()\n"
        "{\n"
        "    gl_Position = vec4(position_in, 0, 1);\n"
        "    color_out0 = color_in0;\n"
        "    color_out1 = color_in1;\n"
        "    color_out2 = color_in2;\n"
        "}\n"
    )
    mod_frag = (
        "#version 430\n"
        "layout(location = 0) smooth in vec4 color_in0;\n"
        "layout(location = 1) flat in uvec2 color_in1;\n"
        "layout(location = 2) smooth in float color_in2;\n"
        "layout(location = 0) out mediump float frag_out0;\n"
        "layout(location = 1) out lowp uvec2 frag_out1;\n"
        "layout(location = 2) out highp vec4 frag_out2;\n"
        "void main()\n"
        "{\n"
        "    frag_out0 = color_in2;\n"
        "    frag_out1 = color_in1;\n"
        "    frag_out2 = color_in0;\n"
        "}\n"
    )

    def ref_pair(color: str, interp: str, precision: str) -> tuple[str, str]:
        vert = (
            "#version 430\n"
            "layout(location = 0) in vec2 position_in;\n"
            f"layout(location = 1) in {color} color_in;\n"
            f"layout(location = 0) {interp} out {color} color_out;\n"
            "\n"
            "void main()\n"
            "{\n"
            "    gl_Position = vec4(position_in, 0, 1);\n"
            "    color_out = color_in;\n"
            "}\n"
        )
        frag = (
            "#version 430\n"
            f"layout(location = 0) {interp} in {color} color_in;\n"
            f"layout(location = 0) out {precision} {color} frag_out;\n"
            "void main()\n"
            "{\n"
            "    frag_out = color_in;\n"
            "}\n"
        )
        return write(vert, "vert"), write(frag, "frag")

    ref0 = ref_pair("vec3", "smooth", "mediump")
    ref1 = ref_pair("uvec2", "flat", "lowp")
    ref2 = ref_pair("vec4", "smooth", "highp")

    def verify_frag(sampler: str, color: str, swizzle: str, compare: str) -> str:
        return (
            "#version 430\n"
            "layout(location = 0) in vec2 texcoord_in;\n"
            "layout(location = 0) out vec4 frag_out;\n"
            f"uniform layout(set=0, binding=0) {sampler} result_sampler;\n"
            f"uniform layout(set=0, binding=1) {sampler} ref_sampler;\n"
            "void main()\n"
            "{\n"
            f"    {color} result = texture(result_sampler, texcoord_in){swizzle};\n"
            f"    {color} ref = texture(ref_sampler, texcoord_in){swizzle};\n"
            f"    if ({compare})\n"
            "        frag_out = vec4(1, 0, 0, 1);\n"
            "    else\n"
            "        frag_out = vec4(0, 1, 0, 1);\n"
            "}\n"
        )

    verify_vert = (
        "#version 430\n"
        "layout(location = 0) in vec2 position_in;\n"
        "layout(location = 1) in vec2 texcoord_in;\n"
        "layout(location = 0) out vec2 texcoord_out;\n"
        "\n"
        "void main()\n"
        "{\n"
        "    gl_Position = vec4(position_in, 0, 1);\n"
        "    texcoord_out = texcoord_in;\n"
        "}\n"
    )
    second = [
        ("vert_shader", write(mod_vert, "vert"), "vert"),
        ("frag_shader", write(mod_frag, "frag"), "frag"),
        ("vert_shader_ref0", ref0[0], "vert"),
        ("frag_shader_ref0", ref0[1], "frag"),
        ("vert_shader_ref1", ref1[0], "vert"),
        ("frag_shader_ref1", ref1[1], "frag"),
        ("vert_shader_ref2", ref2[0], "vert"),
        ("frag_shader_ref2", ref2[1], "frag"),
        ("vert_shader_verify", write(verify_vert, "vert"), "vert"),
        ("frag_shader_verify_vec4", write(verify_frag("sampler2D", "vec4", "", "result != ref"), "frag"), "frag"),
        ("frag_shader_verify_float", write(verify_frag("sampler2D", "float", ".x", "distance(result, ref) > 0.1"), "frag"), "frag"),
        ("frag_shader_verify_uvec2", write(verify_frag("usampler2D", "uvec2", ".xy", "distance(result, ref) > 5"), "frag"), "frag"),
    ]
    return {"inputs-outputs": first, "inputs-outputs-mod": second}


def main() -> int:
    for existing in SRC_DIR.glob("ol_*"):
        existing.unlink()

    lines = [
        "# Shader manifest for dEQP-VK.draw.renderpass.output_location.{array,shuffle}.*",
        "#",
        "# Generated by scripts/gen_draw_output_location_shaders.py together with the GLSL it names; do not hand-edit either.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/draw/vktDrawOutputLocationTests.cpp"',
        'rust_module = "draw/output_location_tests"',
        "",
    ]
    count = 0
    for prefix, color, _comps, outs in FAMILIES:
        for precision in ("highp", "mediump"):
            for out in outs:
                name = f"{prefix}-{precision}" + (f"-output-{out}" if out else "")
                const = "OUTPUT_LOCATION_ARRAY_" + name.upper().replace("-", "_")
                programs = shaders(color, out, precision)
                lines += [
                    "[[case]]",
                    f'name = "{name}"',
                    f'rust_const = "{const}"',
                    'rust_type = "SharedProgram"',
                    "programs = [",
                    *[f'    {{ name = "{pname}", template = "{template}", stage = "{stage}" }},' for pname, template, stage in programs],
                    "]",
                    "",
                ]
                count += 1

    for name, programs in shuffle_shaders().items():
        lines += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "OUTPUT_LOCATION_SHUFFLE_{name.upper().replace("-", "_")}"',
            'rust_type = "SharedProgram"',
            "programs = [",
            *[f'    {{ name = "{pname}", template = "{template}", stage = "{stage}" }},' for pname, template, stage in programs],
            "]",
            "",
        ]
        count += 1

    MANIFEST.write_text("\n".join(lines))
    print(f"{count} cases, {len(list(SRC_DIR.glob('ol_*')))} shaders -> {MANIFEST.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

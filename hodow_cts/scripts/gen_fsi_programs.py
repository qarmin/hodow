#!/usr/bin/env python3
"""Writes the GLSL variants of dEQP-VK.fragment_shader_interlock.basic and their manifest.

`FSITestCase::initPrograms` builds the fragment shader from the CaseDef with string concatenation, so every
(kill, resource, interlock, samples, sample shading, dim) combination is its own program. This reproduces that
concatenation line for line and lists every variant in one manifest case; the Rust side asks for a program by
the name `frag_<res>_<interlock>_<samples>_<ss>_<kill>_<dim>`.

Run from hodow_cts/:  python3 scripts/gen_fsi_programs.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "fragment_shader_interlock"
MANIFEST = ROOT / "shaders" / "manifest" / "fragment_shader_interlock_basic.toml"

DIMS = [8, 16, 32, 64, 128, 256, 512, 1024]
RESOURCES = ["image", "ssbo"]
INTERLOCKS = ["pixel_ordered", "pixel_unordered", "sample_ordered", "sample_unordered", "shading_rate_ordered", "shading_rate_unordered"]
SAMPLES = [1, 4]
SHADING = [0, 1]
KILL = [0, 1]

VERT = """#version 450 core
layout(location = 0) out int primID;
void main()
{
  primID = gl_InstanceIndex;
  gl_Position = vec4( 2.0*float(gl_VertexIndex&2) - 1.0, 4.0*(gl_VertexIndex&1)-1.0, 1.0 - 2.0 * float(gl_VertexIndex&1), 1);
}
"""


def frag(dim, res, interlock, samples, sample_shading, kill_odd):
    sample_interlock = bool(sample_shading) or interlock in ("sample_ordered", "sample_unordered")
    ordered = interlock in ("pixel_ordered", "sample_ordered", "shading_rate_ordered")
    shading_rate = interlock in ("shading_rate_ordered", "shading_rate_unordered")

    bpq = samples
    if sample_interlock:
        bpq = 1
    elif shading_rate:
        bpq *= 4

    s = (
        "#version 450 core\n"
        "#extension GL_ARB_fragment_shader_interlock : enable\n"
        "#extension GL_NV_shading_rate_image : enable\n"
        "layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;\n"
        "layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;\n"
        "layout(location = 0) flat in int primID;\n"
    )
    s += f"layout({interlock}_interlock) in;\n".replace("pixel_ordered_interlock", "pixel_interlock_ordered").replace(
        "pixel_unordered_interlock", "pixel_interlock_unordered"
    ).replace("sample_ordered_interlock", "sample_interlock_ordered").replace("sample_unordered_interlock", "sample_interlock_unordered").replace(
        "shading_rate_ordered_interlock", "shading_rate_interlock_ordered"
    ).replace("shading_rate_unordered_interlock", "shading_rate_interlock_unordered")

    s += "void main()\n{\n  ivec2 coordxy = ivec2(gl_FragCoord.xy);\n"
    s += f"  uint stride = {dim};\n  uint bitsPerQuad = {bpq};\n"

    if sample_interlock:
        s += f"  coordxy.x = coordxy.x * {samples} + gl_SampleID;\n"
        s += f"  stride *= {samples};\n"
    elif shading_rate:
        s += "  coordxy /= 2;\n"
        s += "  stride /= 2;\n"

    if sample_interlock:
        s += "  uint mask = 1 << primID;\n"
        s += "  uint previousMask = (1 << primID)-1;\n"
    else:
        s += "  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);\n"
        s += "  uint previousMask = (1 << (primID * bitsPerQuad))-1;\n"

    if kill_odd:
        s += f"  if (coordxy.y < {dim // 4} && (coordxy.x & 1) != 0) discard;\n"

    s += "  beginInvocationInterlockARB();\n"

    if kill_odd:
        s += "  if ((coordxy.x & 1) != 0) discard;\n"

    if res == "image":
        s += "  uint temp = imageLoad(image0, coordxy).x;\n"
    else:
        s += "  uint coord = coordxy.y * stride + coordxy.x;\n"
        s += "  uint temp = buf1.x[coord];\n"

    if ordered:
        s += "  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;\n"
    else:
        s += "  temp |= mask;\n"

    if res == "image":
        s += "  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));\n"
    else:
        s += "  buf1.x[coord] = temp;\n"

    s += "  endInvocationInterlockARB();\n"

    if kill_odd:
        s += "  discard;\n"

    s += "}\n"
    return s


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    (SRC / "basic.vert").write_text(VERT)

    programs = ['    { name = "vert", template = "fragment_shader_interlock/basic.vert", stage = "vert" },']
    for kill in KILL:
        for res in RESOURCES:
            for interlock in INTERLOCKS:
                for samples in SAMPLES:
                    for ss in SHADING:
                        if ss and samples == 1:
                            continue
                        for dim in DIMS:
                            name = f"frag_{res}_{interlock}_{samples}_{ss}_{kill}_{dim}"
                            (SRC / f"{name}.frag").write_text(frag(dim, res, interlock, samples, ss, kill))
                            programs.append(f'    {{ name = "{name}", template = "fragment_shader_interlock/{name}.frag", stage = "frag" }},')

    header = (
        "# Shader manifest for dEQP-VK.fragment_shader_interlock.basic.*\n"
        "#\n"
        "# One vertex shader and one fragment shader per (discard, resource, interlock, samples, sample shading, dimension)\n"
        "# combination: `FSITestCase::initPrograms` bakes all of them into the GLSL text. Generated by\n"
        "# `scripts/gen_fsi_programs.py`, which also writes the sources next to the other shader templates.\n"
        "\n"
        'upstream_source = "external/vulkancts/modules/vulkan/fragment_shader_interlock/vktFragmentShaderInterlockBasic.cpp"\n'
        'rust_module = "fragment_shader_interlock/basic_tests"\n'
        "\n"
        "[[case]]\n"
        'name = "basic"\n'
        'rust_const = "FSI_BASIC"\n'
        'rust_type = "SharedProgram"\n'
        "programs = [\n"
    )
    MANIFEST.write_text(header + "\n".join(programs) + "\n]\n")
    print(f"wrote {len(programs) - 1} fragment shaders")


if __name__ == "__main__":
    main()

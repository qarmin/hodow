#!/usr/bin/env python3
"""Writes shaders/manifest/renderpass_local_read_m10.toml, its GLSL sources and the program lookup of the Rust port.

`DRLRFeedbackLoopCase::initPrograms` (vktDynamicRenderingLocalReadMaint10Tests.cpp) builds five shaders from the test parameters. The
shaders do not depend on the image format beyond which aspects it has, nor on the layout, so a manifest case is one combination of
(aspects, attachment count, multisample, sample id, feedback pattern).
"""
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
SRC = CRATE / "shaders" / "src" / "renderpass" / "local_read_m10"
MANIFEST = CRATE / "shaders" / "manifest" / "renderpass_local_read_m10.toml"
LOOKUP = CRATE / "src" / "vkt" / "tests" / "renderpass" / "local_read_m10_programs.rs"

PC_DECL = (
    "layout (push_constant, std430) uniform PushConstantBlock {\n"
    "    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count\n"
    "} pc;\n"
)

VERT = (
    "#version 460\n"
    "vec2 positions[3] = vec2[](\n"
    "        vec2(-1.0, -1.0),"
    "        vec2(3.0, -1.0),"
    "        vec2(-1.0, 3.0)"
    ");\n"
    "void main() {\n"
    "        gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);\n"
    "}"
)


def out_att(feedback, i):
    return i if feedback[i] else i + len(feedback)


def frag_load(color, depth, stencil, att_count, ms):
    f = "#version 460\n"
    if stencil:
        f += "#extension GL_ARB_shader_stencil_export : enable\n"
    if color:
        for i in range(att_count):
            f += f"layout (location={i}) out vec4 outColor{i};\n"
    for i in range(att_count):
        f += f"layout (set=0, binding={i}, std430) readonly buffer ColorBlock{i} {{\n    vec4 values[];\n}} inputBuffer{i};\n"
    f += "// For the push constants below: .x=width, .y=height, .w=samples\n"
    f += PC_DECL + "void main(void) {\n"
    f += "    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);\n"
    f += "    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;\n"
    f += f"    int bufferIndex = pixelIndex * pc.imageSize.w + {'gl_SampleID' if ms else '0'};\n"
    if color:
        for i in range(att_count):
            f += f"    outColor{i} = inputBuffer{i}.values[bufferIndex];\n"
    if depth:
        f += "    gl_FragDepth = inputBuffer0.values[bufferIndex].x;\n"
    if stencil:
        f += "    gl_FragStencilRefARB = int(inputBuffer0.values[bufferIndex].y);\n"
    return f + "}\n"


def frag_copy(color, depth, stencil, att_count):
    f = "#version 460\n"
    if stencil:
        f += "#extension GL_ARB_shader_stencil_export : enable\n"
    if color:
        for i in range(att_count):
            f += f"layout (location={i}) out vec4 outColor{i};\n"
        for i in range(att_count):
            f += f"layout (set=0, binding={i}) uniform sampler2DMS srcColor{i};\n"
    else:
        nb = 0
        if depth:
            f += f"layout (set=0, binding={nb}) uniform sampler2DMS srcDepth;\n"
            nb += 1
        if stencil:
            f += f"layout (set=0, binding={nb}) uniform usampler2DMS srcStencil;\n"
            nb += 1
    f += "// For the push constants below: .x=width, .y=height, .w=samples\n"
    f += PC_DECL + "void main(void) {\n"
    f += "    ivec2 expandedPixelCoord = ivec2(gl_FragCoord.xy);\n"
    f += "    int sampleID = expandedPixelCoord.x % pc.imageSize.w;\n"
    f += "    int xCoordMS = expandedPixelCoord.x / pc.imageSize.w;\n"
    f += "    int yCoordMS = expandedPixelCoord.y;\n"
    if color:
        for i in range(att_count):
            f += f"    outColor{i} = texelFetch(srcColor{i}, ivec2(xCoordMS, yCoordMS), sampleID);\n"
    else:
        if depth:
            f += "    gl_FragDepth = texelFetch(srcDepth, ivec2(xCoordMS, yCoordMS), sampleID).x;\n"
        if stencil:
            f += "    gl_FragStencilRefARB = int(texelFetch(srcStencil, ivec2(xCoordMS, yCoordMS), sampleID).x);\n"
    return f + "}\n"


def frag_modify(color, depth, stencil, att_count, ms, sample_id, feedback):
    sample_index = ("gl_SampleID" if sample_id is None else str(sample_id)) if ms else "0"
    f = "#version 460\n"
    if stencil:
        f += "#extension GL_ARB_shader_stencil_export : enable\n"
    if color:
        for i in range(att_count):
            f += f"layout (location={out_att(feedback, i)}) out vec4 outColor{i};\n"
    f += "layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;\n"
    sub = "subpassInputMS" if ms else "subpassInput"
    usub = "usubpassInputMS" if ms else "usubpassInput"
    if color:
        for i in range(att_count):
            f += f"layout (set=0, binding={i + 1}, input_attachment_index={i}) uniform {sub} srcImage{i};\n"
    else:
        nb, na = 1, 0
        if depth:
            f += f"layout (set=0, binding={nb}, input_attachment_index={na}) uniform {sub} srcDepth;\n"
            nb += 1
            na += 1
        if stencil:
            f += f"layout (set=0, binding={nb}, input_attachment_index={na}) uniform {usub} srcStencil;\n"
    f += "void main(void) {\n"
    arg = f", {sample_index}" if ms else ""
    if color:
        for i in range(att_count):
            f += f"    vec4 color{i} = subpassLoad(srcImage{i}{arg}) * modifiers.ones + modifiers.zeros;\n"
        for i in range(att_count):
            f += f"    outColor{i} = color{i}.gbra;\n"
    else:
        if depth:
            f += f"    vec4 depth = subpassLoad(srcDepth{arg}) * modifiers.ones + modifiers.zeros;\n"
            f += "    gl_FragDepth = 1.0 - depth.x;\n"
        if stencil:
            f += f"    vec4 stencil = vec4(subpassLoad(srcStencil{arg})) * modifiers.ones + modifiers.zeros;\n"
            f += "    gl_FragStencilRefARB = 255 - int(stencil.x);\n"
    return f + "}\n"


def frag_grad(color, depth, stencil, att_count, feedback):
    f = "#version 460\n"
    if stencil:
        f += "#extension GL_ARB_shader_stencil_export : enable\n"
    if color:
        for i in range(att_count):
            f += f"layout (location={out_att(feedback, i)}) out vec4 outColor{i};\n"
    f += PC_DECL + "void main(void) {\n"
    f += "    vec4 imageSizeFloat = vec4(pc.imageSize);\n"
    f += "    // All samples in a pixel will share color so as not to depend on standard sample locations\n"
    f += "    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;\n"
    f += "    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;\n"
    if color:
        for i in range(att_count):
            f += f"    vec4 gradient{i} = vec4(0.0, 0.0, 0.0, 1.0);\n"
            f += f"    gradient{i}[{i}] = gradientValue;\n"
            f += f"    outColor{i} = gradient{i};\n"
    else:
        if depth:
            f += "    gl_FragDepth = gradientValue;\n"
        if stencil:
            f += "    gl_FragStencilRefARB = int(gradientValue * 255.0);\n"
    return f + "}\n"


FEEDBACKS = [[False], [True], [False, False], [False, True], [True, False], [True, True]]
KINDS = {"color": (True, False, False), "d": (False, True, False), "s": (False, False, True), "ds": (False, True, True)}


def feedback_name(feedback):
    return "loop_" + "".join("NY"[int(x)] for x in feedback)


def program_key(kind, samples, feedback, sample_id):
    return f"{kind}_samples_{samples}_{feedback_name(feedback)}" + ("" if sample_id is None else f"_sample_{sample_id}")


def keys():
    for kind in KINDS:
        for samples in (1, 4):
            for feedback in FEEDBACKS:
                if kind != "color" and (len(feedback) != 1 or not feedback[0]):
                    continue
                for sample_id in (None, 0, 1, 2, 3):
                    if (samples == 1) != (sample_id is None) and not (samples == 4 and sample_id is None):
                        continue
                    if samples == 1 and sample_id is not None:
                        continue
                    yield kind, samples, feedback, sample_id


def main() -> None:
    SRC.mkdir(parents=True, exist_ok=True)
    (SRC / "vert.vert").write_text(VERT)
    out = [
        "# Shader manifest for dEQP-VK.renderpasses.dynamic_rendering.primary_cmd_buff.m10_feedback_loop.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_local_read_m10_manifest.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingLocalReadMaint10Tests.cpp"',
        'rust_module = "renderpass/dynamic_rendering_local_read_maint10_tests"',
        "",
    ]
    table = []
    for kind, samples, feedback, sample_id in keys():
        color, depth, stencil = KINDS[kind]
        att = len(feedback)
        ms = samples != 1
        key = program_key(kind, samples, feedback, sample_id)
        stages = {
            "frag-load": frag_load(color, depth, stencil, att, ms),
            "frag-modify": frag_modify(color, depth, stencil, att, ms, sample_id, feedback),
            "frag-grad": frag_grad(color, depth, stencil, att, feedback),
        }
        if ms:
            stages["frag-copy"] = frag_copy(color, depth, stencil, att)
        programs = ['    { name = "vert", template = "renderpass/local_read_m10/vert.vert", stage = "vert" },']
        for name, text in stages.items():
            path = f"{key}_{name}.frag"
            (SRC / path).write_text(text)
            programs.append(f'    {{ name = "{name}", template = "renderpass/local_read_m10/{path}", stage = "frag" }},')
        const = "LRM10_" + key.upper()
        out += ["[[case]]", f'name = "{key}"', f'rust_const = "{const}"', 'rust_type = "SharedProgram"', "programs = ["] + programs + ["]", ""]
        table.append((key, const))
    MANIFEST.write_text("\n".join(out))

    lines = [
        "// @generated by hodow_cts/scripts/gen_local_read_m10_manifest.py - do not hand-edit.",
        "",
        "use crate::generated::shaders::renderpass_local_read_m10::*;",
        "use crate::vk::programs::BinaryCollection;",
        "",
        "/// The programs of the manifest case for `key` (see `program_key` in the generator)",
        "pub fn programs_for(key: &str) -> Option<BinaryCollection> {",
        "    match key {",
    ]
    for key, const in table:
        lines.append(f'        "{key}" => Some({const}.programs),')
    lines += ["        _ => None,", "    }", "}", ""]
    LOOKUP.write_text("\n".join(lines))


if __name__ == "__main__":
    main()

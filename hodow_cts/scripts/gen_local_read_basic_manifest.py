#!/usr/bin/env python3
"""Writes shaders/manifest/renderpass_local_read_basic.toml and its GLSL/assembly sources.

`LocalReadTestCase::initPrograms` (vktDynamicRenderingLocalReadTests.cpp) for the test types BasicLocalReadTestInstance runs. The write and read fragment
shaders come from `generateWriteFragSource` / `generateReadFragSource`, replayed here; the SPIR-V assembly ones (glslang cannot declare a subpass input without
an input_attachment_index) are cut out of the upstream file so they stay byte for byte.
"""
import re
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
UPSTREAM = CRATE / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "renderpass" / "vktDynamicRenderingLocalReadTests.cpp"
SRC = CRATE / "shaders" / "src" / "renderpass" / "local_read_basic"
MANIFEST = CRATE / "shaders" / "manifest" / "renderpass_local_read_basic.toml"

INPUT_ATTACHMENTS_POSSIBLE_VALUES = [4, 5, 6, 7, 8, 9, 10, 16, 17, 18]

VERT = (
    "#version 450\n"
    "void main (void)\n"
    "{\n"
    "  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));\n"
    "  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));\n"
    "  gl_Position = vec4(x, y, 0.6, 1.0);\n"
    "}\n"
)

LITERAL = re.compile(r'"((?:[^"\\]|\\.)*)"')


def unescape(text: str) -> str:
    return text.replace('\\n', '\n').replace('\\"', '"').replace('\\\\', '\\')


def cxx_literals(lines: list[str], skip_first_prefix: bool = False) -> str:
    """Concatenates the string literals of upstream lines, dropping commented-out lines."""
    out = []
    for index, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith("//"):
            continue
        if index == 0 and skip_first_prefix:
            line = line.split("<<", 1)[1]
        out.append("".join(unescape(m.group(1)) for m in LITERAL.finditer(line)))
    return "".join(out)


BLEND_FRAG = (
    "#version 450\n"
    "layout(location = 0) out vec4 outColor0;\n"
    "layout(location = 1) out vec4 outColor1;\n"
    "layout(location = 2) out vec4 outColor2;\n"
    "layout(location = 3) out vec4 outColor3;\n"
    "void main()\n{\n"
    "  if (gl_FragCoord.x > 8.0)\n"
    "    discard;\n"
    "  outColor0 = vec4(0.6, 0.8, 0.9, 0.2);\n"
    "  outColor1 = vec4(0.6, 0.4, 0.2, 0.6);\n"
    "  outColor2 = vec4(0.1, 0.3, 0.6, 0.2);\n"
    "  outColor3 = vec4(0.0, 0.6, 0.4, 0.8);\n"
    "}\n"
)

FRAG_ONLY_COLOR_0 = (
    "#version 450\n"
    "layout(location = 0) out uint outColor0;\n"
    "layout(location = 1) out uint outColor1;\n"
    "layout(location = 2) out uint outColor2;\n"
    "void main()\n{\n"
    "  outColor0 = 1u;\n"
    "  outColor1 = 10u;\n"
    "  outColor2 = 100u;\n"
    "}\n"
)

FRAG_ONLY_COLOR_1 = (
    "#version 450\n"
    "layout(input_attachment_index = 0, binding = 0) uniform usubpassInput inColor0;\n"
    "layout(input_attachment_index = 1, binding = 1) uniform usubpassInput inColor1;\n"
    "layout(input_attachment_index = 2, binding = 2) uniform usubpassInput inColor2;\n"
    "layout(location = 0) out uint outColor;\n"
    "void main()\n{\n"
    "  outColor = 1u * subpassLoad(inColor0).x +\n"
    "             2u * subpassLoad(inColor1).x +\n"
    "             3u * subpassLoad(inColor2).x;\n"
    "}\n"
)

FEEDBACK_FRAG = (
    "#version 450\n"
    "layout(input_attachment_index = 0, binding = 0) uniform subpassInput inColor;\n"
    "layout(location = 0) out vec4 outColor;\n"
    "void main()\n{\n"
    "  vec2 uvNormalized = gl_FragCoord.xy / vec2(1024);\n"
    "  vec4 color = subpassLoad(inColor);\n"
    "  vec4 select = step(vec4(0.5), color);\n"
    "  color += mix(vec4(0.2), vec4(-0.2), select);\n"
    "  outColor = color;\n"
    "}\n"
)

FEEDBACK_MSAA_FRAG = (
    "#version 450\n"
    "layout(input_attachment_index = 0, binding = 0) uniform subpassInputMS inColor;\n"
    "layout(location = 0) out vec4 outColor;\n"
    "void main()\n{\n"
    "  vec2 uvNormalized = gl_FragCoord.xy / vec2(1024);\n"
    "  vec4 color = subpassLoad(inColor, gl_SampleID);\n"
    "  vec4 select = step(vec4(0.5), color);\n"
    "  color += mix(vec4(0.2), vec4(-0.2), select);\n"
    "  outColor = color;\n"
    "}\n"
)

FEEDBACK_MSAA_INIT = (
    "#version 450\n"
    "layout(set=0, binding=0, std430) readonly buffer Input\n{\n"
    "  uint v[];\n"
    "} inBuffer;\n"
    "layout(location = 0) out vec4 outColor;\n"
    "void main()\n{\n"
    "  uint index = uint(gl_FragCoord.y) * 1024 + uint(gl_FragCoord.x);\n"
    "  outColor = unpackUnorm4x8(inBuffer.v[index]);\n"
    "}\n"
)


def write_frag(color_count: int) -> str:
    out = "#version 450\nlayout(push_constant) uniform InputDraw {\n  uint count;\n} inputDraw;\n"
    for i in range(color_count):
        out += f"layout(location={i}) out uint outColor{i};\n"
    out += "void main()\n{\n"
    for i in range(color_count):
        out += f"  outColor{i} = 2u * inputDraw.count + {i + 1};\n"
        out += f"  outColor{i} *= outColor{i};\n"
    return out + "}\n"


def read_frag(input_count: int, use_depth: bool = True, use_stencil: bool = True) -> str:
    color_count = input_count - int(use_depth) - int(use_stencil)
    out = "#version 450\n"
    for i in range(color_count):
        out += f"layout(input_attachment_index={i}, binding={i}) uniform usubpassInput inColor{i};\n"
    if use_depth:
        out += f"layout(input_attachment_index = {color_count}, binding = {color_count}) uniform subpassInput inDepth;\n"
    if use_stencil:
        out += f"layout(input_attachment_index = {color_count + 1}, binding = {color_count + 1}) uniform usubpassInput inStencil;\n"
    out += "layout(set=1, binding=0, std430) writeonly buffer Output\n{\n  uint v[];\n} outBuffer;\nvoid main()\n{\n  uint result = 0;\n"
    for i in range(color_count):
        out += f"  result = result + {i + 1} * subpassLoad(inColor{i}).x; \n"
    if use_depth:
        out += "  result = result + uint(subpassLoad(inDepth).x * 1000);\n"
    if use_stencil:
        out += "  result = result + uint(subpassLoad(inStencil).x * 1000);\n"
    out += "  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));\n  outBuffer.v[i.x+i.y*16] = result;\n}\n"
    return out


def same_index_frag(large: bool) -> str:
    depth_index = "20" if large else "2"
    stencil_index = "21" if large else "2"
    return (
        "#version 450\n"
        "layout(input_attachment_index = 0, binding = 0) uniform usubpassInput inColor0;\n"
        "layout(input_attachment_index = 1, binding = 1) uniform usubpassInput inColor1;\n"
        f"layout(input_attachment_index = {depth_index}, binding = 2) uniform  subpassInput inDepth;\n"
        f"layout(input_attachment_index = {stencil_index}, binding = 3) uniform usubpassInput inStencil;\n"
        "layout(set=1, binding=0, std430) writeonly buffer Output\n{\n"
        "  uint v[];\n"
        "} outBuffer;\n"
        "void main()\n{\n"
        "  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));\n"
        "  outBuffer.v[i.x+i.y*16] = uint(subpassLoad(inDepth).x * 1000) + subpassLoad(inStencil).x;\n"
        "}\n"
    )


def upstream_block(lines: list[str], first: int, last: int) -> list[str]:
    return lines[first - 1:last]


def main() -> None:
    lines = UPSTREAM.read_text().splitlines()
    SRC.mkdir(parents=True, exist_ok=True)

    no_index_asm = cxx_literals(upstream_block(lines, 3012, 3113), skip_first_prefix=True)

    ds_head = cxx_literals(upstream_block(lines, 3157, 3178), skip_first_prefix=True)
    ds_mid = cxx_literals(upstream_block(lines, 3180, 3206))
    ds_tail = cxx_literals(upstream_block(lines, 3208, 3223))
    depth_type = "%10 = OpTypeImage %9 SubpassData 0 0 0 2 Unknown\n"
    depth_save = (
        "%19 = OpImageRead %18 %13 %17\n%21 = OpCompositeExtract %9 %19 0\n%23 = OpFMul %9 %21 %22\n"
        "%24 = OpConvertFToU %6 %23\nOpStore %8 %24\n"
    )
    stencil_type = "%10 = OpTypeImage %6 SubpassData 0 0 0 2 Unknown\n"
    stencil_save = "%19 = OpImageRead %50 %13 %17\n%21 = OpCompositeExtract %6 %19 0\nOpStore %8 %21\n"
    ds_depth_asm = ds_head + depth_type + ds_mid + depth_save + ds_tail
    ds_stencil_asm = ds_head + stencil_type + ds_mid + stencil_save + ds_tail

    first_line = lines[3259].split('R"(', 1)[1]
    template = (first_line + "\n" + "\n".join(lines[3260:3349])).rstrip()
    assert template.endswith(')");'), template[-20:]
    template = template[:-4] + "\n"
    decorations = "OpDecorate %62 DescriptorSet 0\nOpDecorate %62 Binding 3\n"
    declarations = (
        "%60 = OpTypeImage %10 SubpassData 0 0 0 2 Unknown\n%61 = OpTypePointer UniformConstant %60\n"
        "%62 = OpVariable %61 UniformConstant\n%66 = OpConstant %10 1000\n"
    )
    operations = (
        "%63 = OpLoad %60 %62\n%64 = OpImageRead %11 %63 %28\n%65 = OpCompositeExtract %10 %64 0\n"
        "%67 = OpFMul %10 %65 %66\n%68 = OpConvertFToU %6 %67\n%69 = OpIAdd %6 %59 %68\n"
    )

    def specialize(with_depth: bool) -> str:
        text = template
        text = text.replace("${DECORATIONS:default=}", decorations if with_depth else "")
        text = text.replace("${DECLARATIONS:default=}", declarations if with_depth else "")
        text = text.replace("${OPERATIONS:default=}", operations if with_depth else "")
        text = text.replace("${RESULT_ID:default=%59}", "%69" if with_depth else "%59")
        text = text.replace("${RESULT_ID:default=%59}", "%59")
        return text

    (SRC / "vert.vert").write_text(VERT)

    cases = {}  # name -> list of (program name, file name, stage)

    def add(case: str, program: str, text: str, stage: str = "frag") -> None:
        extension = "spvasm" if stage == "asm" else "frag"
        file = f"{case}_{program}.{extension}"
        (SRC / file).write_text(text)
        cases.setdefault(case, []).append((program, file, stage))

    for value in INPUT_ATTACHMENTS_POSSIBLE_VALUES:
        add("max_input", f"frag0_{value - 2}", write_frag(value - 2))
    for case in ("max_input", "max_remapped"):
        if case == "max_remapped":
            add(case, "frag0", write_frag(2))
        for value in INPUT_ATTACHMENTS_POSSIBLE_VALUES:
            add(case, f"frag1_{value}", read_frag(value))
            add(case, f"frag1_{value}_no_ds", read_frag(value, False, False))

    add("unused_written", "frag0", write_frag(4))
    add("unused_written", "frag1", read_frag(6))
    add("unused_written", "frag1_no_ds", read_frag(4, False, False))

    add("ds_no_index", "frag0", write_frag(2))
    add("ds_no_index", "frag1", no_index_asm, "asm")

    add("ds_depth_clear", "frag0", write_frag(0))
    add("ds_depth_clear", "frag1", ds_depth_asm, "asm")
    add("ds_stencil_clear", "frag0", write_frag(0))
    add("ds_stencil_clear", "frag1", ds_stencil_asm, "asm")

    add("depth_not_stencil", "frag0", write_frag(4))
    add("depth_not_stencil", "frag1", read_frag(5, True, False))

    add("color_write", "frag0", write_frag(4))
    add("color_write", "frag1", read_frag(5, True, False))
    add("color_write", "frag1_no_ds", read_frag(4, False, False))

    add("without_mapping", "frag0", write_frag(3))
    add("without_mapping", "frag1", specialize(True), "asm")
    add("without_mapping", "frag1_no_ds", specialize(False), "asm")

    add("same_index", "frag0", write_frag(2))
    add("same_index", "frag1", same_index_frag(False))
    add("large_index", "frag0", write_frag(2))
    add("large_index", "frag1", same_index_frag(True))

    add("blend", "frag", BLEND_FRAG)
    add("frag_only_color", "frag0", FRAG_ONLY_COLOR_0)
    add("frag_only_color", "frag1", FRAG_ONLY_COLOR_1)
    add("feedback_loop", "frag", FEEDBACK_FRAG)
    add("feedback_loop_msaa", "frag", FEEDBACK_MSAA_FRAG)
    add("feedback_loop_msaa", "frag_init", FEEDBACK_MSAA_INIT)

    out = [
        "# Shader manifest for dEQP-VK.renderpasses.dynamic_rendering.*.local_read.* (the instances that use LocalReadTestCase::initPrograms)",
        "#",
        "# @generated by hodow_cts/scripts/gen_local_read_basic_manifest.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingLocalReadTests.cpp"',
        'rust_module = "renderpass/dynamic_rendering_local_read_basic_tests"',
        "",
    ]
    for case, programs in cases.items():
        out += ["[[case]]", f'name = "{case}"', f'rust_const = "LRB_{case.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
        out.append('    { name = "vert", template = "renderpass/local_read_basic/vert.vert", stage = "vert" },')
        for program, file, stage in programs:
            out.append(f'    {{ name = "{program}", template = "renderpass/local_read_basic/{file}", stage = "{stage}" }},')
        out += ["]", ""]
    MANIFEST.write_text("\n".join(out))
    for case, programs in cases.items():
        print(case, len(programs))


if __name__ == "__main__":
    main()

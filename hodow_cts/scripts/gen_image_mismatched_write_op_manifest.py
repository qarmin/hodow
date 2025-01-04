#!/usr/bin/env python3
"""Writes shaders/manifest/image_mismatched_write_op.toml: the SPIR-V assembly programs of dEQP-VK.image.mismatched_write_op.*

Upstream's `MismatchedWriteOpTest::getProgramCodeAndVariables` specializes one assembly template per case, from the image
format's SPIR-V format, the channel class of the buffer that feeds it and the width of the vector written. This script
runs the same specialization and the manifest carries the result through a `derived` expression, the way
gen_spirv_assembly_manifest.py does, so spirv-as is the only tool compile_shaders.py needs for them.

A case is keyed by (kind, spirv_format, variant): `vector_sizes` by the width of the vector, `signedness` by the position
of the written-to format in the list of formats of its channel class (which decides the image height).

Usage: python3 hodow_cts/scripts/gen_image_mismatched_write_op_manifest.py [--check]
"""

import json
import re
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
OUT = CRATE_DIR / "shaders" / "manifest" / "image_mismatched_write_op.toml"
TEMPLATE = "image/mismatched_write_op.asm"

# (VkFormat name, getSpirvFormat, channel class, getNumUsedChannels, is64BitIntegerFormat), in upstream's `allFormats` order
ALL_FORMATS = [
    ("R32G32B32A32_SFLOAT", "Rgba32f", "float", 4, False),
    ("R32G32_SFLOAT", "Rg32f", "float", 2, False),
    ("R32_SFLOAT", "R32f", "float", 1, False),
    ("R16G16B16A16_SFLOAT", "Rgba16f", "float", 4, False),
    ("R16G16_SFLOAT", "Rg16f", "float", 2, False),
    ("R16_SFLOAT", "R16f", "float", 1, False),
    ("R16G16B16A16_UNORM", "Rgba16", "unorm", 4, False),
    ("R16G16_UNORM", "Rg16", "unorm", 2, False),
    ("R16_UNORM", "R16", "unorm", 1, False),
    ("R16G16B16A16_SNORM", "Rgba16Snorm", "snorm", 4, False),
    ("R16G16_SNORM", "Rg16Snorm", "snorm", 2, False),
    ("R16_SNORM", "R16Snorm", "snorm", 1, False),
    ("A2B10G10R10_UNORM_PACK32", "Rgb10A2", "unorm", 4, False),
    ("B10G11R11_UFLOAT_PACK32", "R11fG11fB10f", "float", 3, False),
    ("R8G8B8A8_UNORM", "Rgba8", "unorm", 4, False),
    ("R8G8_UNORM", "Rg8", "unorm", 2, False),
    ("R8_UNORM", "R8", "unorm", 1, False),
    ("R8G8B8A8_SNORM", "Rgba8Snorm", "snorm", 4, False),
    ("R8G8_SNORM", "Rg8Snorm", "snorm", 2, False),
    ("R8_SNORM", "R8Snorm", "snorm", 1, False),
    ("R32G32B32A32_SINT", "Rgba32i", "sint", 4, False),
    ("R32G32_SINT", "Rg32i", "sint", 2, False),
    ("R32_SINT", "R32i", "sint", 1, False),
    ("R16G16B16A16_SINT", "Rgba16i", "sint", 4, False),
    ("R16G16_SINT", "Rg16i", "sint", 2, False),
    ("R16_SINT", "R16i", "sint", 1, False),
    ("R8G8B8A8_SINT", "Rgba8i", "sint", 4, False),
    ("R8G8_SINT", "Rg8i", "sint", 2, False),
    ("R8_SINT", "R8i", "sint", 1, False),
    ("R32G32B32A32_UINT", "Rgba32ui", "uint", 4, False),
    ("R32G32_UINT", "Rg32ui", "uint", 2, False),
    ("R32_UINT", "R32ui", "uint", 1, False),
    ("R16G16B16A16_UINT", "Rgba16ui", "uint", 4, False),
    ("R16G16_UINT", "Rg16ui", "uint", 2, False),
    ("R16_UINT", "R16ui", "uint", 1, False),
    ("A2B10G10R10_UINT_PACK32", "Rgb10a2ui", "uint", 4, False),
    ("R8G8B8A8_UINT", "Rgba8ui", "uint", 4, False),
    ("R8G8_UINT", "Rg8ui", "uint", 2, False),
    ("R8_UINT", "R8ui", "uint", 1, False),
    ("R64_SINT", "R64i", "sint", 1, True),
    ("R64_UINT", "R64ui", "uint", 1, True),
]

# `TextureChannelClass` equivalences of `findFormatsByChannelClass`
SIGNED_CLASSES = {"sint"}
UNSIGNED_CLASSES = {"uint"}

MAIN_TEMPLATE = r"""

                              OpCapability Shader
                              OpCapability StorageImageExtendedFormats

                              ${CAPABILITY_INT64}
                              ${CAPABILITY_VEC5}
                              OpExtension      "SPV_KHR_variable_pointers"
                              OpExtension      "SPV_KHR_storage_buffer_storage_class"
                              ${EXTENSIONS}

                    %std450 = OpExtInstImport  "GLSL.std.450"
                              OpMemoryModel    Logical GLSL450

                              OpEntryPoint     GLCompute %main "main" %gid %image %buffer
                              OpExecutionMode  %main LocalSize 1 1 1

                              OpDecorate       %gid BuiltIn GlobalInvocationId

                              OpDecorate       %image DescriptorSet 0
                              OpDecorate       %image Binding 0

                              OpDecorate       %rta    ArrayStride ${ARRAY_STRIDE}
                              OpMemberDecorate %struct 0 Offset 0
                              OpDecorate       %struct Block
                              OpDecorate       %buffer DescriptorSet 0
                              OpDecorate       %buffer Binding 1

                      %void = OpTypeVoid
                   %fn_void = OpTypeFunction %void

                    ${TYPES_INT64}

                     %float = OpTypeFloat 32
                      %sint = OpTypeInt 32 1
                      %uint = OpTypeInt 32 0

                    ${TYPES_VEC5}

                   %v4float = OpTypeVector %float 4
                   %v3float = OpTypeVector %float 3
                   %v2float = OpTypeVector %float 2

                    %v4sint = OpTypeVector %sint 4
                    %v3sint = OpTypeVector %sint 3
                    %v2sint = OpTypeVector %sint 2

                    %v4uint = OpTypeVector %uint 4
                    %v3uint = OpTypeVector %uint 3
                    %v2uint = OpTypeVector %uint 2

             %v3uint_in_ptr = OpTypePointer Input %v3uint
                       %gid = OpVariable %v3uint_in_ptr Input

                %image_type = OpTypeImage %${SAMPLED_TYPE} 2D 0 0 0 2 ${SPIRV_IMAGE_FORMAT}
                 %image_ptr = OpTypePointer UniformConstant %image_type
                     %image = OpVariable %image_ptr UniformConstant

               %image_width = OpConstant %sint ${IMAGE_WIDTH}
              %image_height = OpConstant %sint ${IMAGE_HEIGHT}

                %rta_offset = OpConstant %uint 0
                       %rta = OpTypeRuntimeArray %v4${SAMPLED_TYPE}
                    %struct = OpTypeStruct %rta
                  %ssbo_ptr = OpTypePointer StorageBuffer %struct
                    %buffer = OpVariable %ssbo_ptr StorageBuffer

                %red_offset = OpConstant %uint 0
              %green_offset = OpConstant %uint 1
               %blue_offset = OpConstant %uint 2
              %alpha_offset = OpConstant %uint 3

       %${SAMPLED_TYPE}_PTR = OpTypePointer StorageBuffer %${SAMPLED_TYPE}
              %var_sint_ptr = OpTypePointer Function %sint

                ; Entry main procedure
                      %main = OpFunction %void None %fn_void
                     %entry = OpLabel

                     %index = OpVariable %var_sint_ptr Function

                ; Transform gl_GlobalInvocationID.xyz to ivec2(gl_GlobalInvocationID.xy)
                        %id = OpLoad %v3uint %gid

                    %u_id_x = OpCompositeExtract %uint %id 0
                    %s_id_x = OpBitcast %sint %u_id_x

                    %u_id_y = OpCompositeExtract %uint %id 1
                    %s_id_y = OpBitcast %sint %u_id_y

                     %id_xy = OpCompositeConstruct %v2sint %s_id_x %s_id_y

                ; Calculate index in buffer
                       %mul = OpIMul %sint %s_id_y %image_width
                       %add = OpIAdd %sint %mul %s_id_x
                              OpStore %index %add

                ; Final image variable used to read from or write to
                       %img = OpLoad %image_type %image

                ; Accessors to buffer components
                       %idx = OpLoad %sint %index
              %alpha_access = OpAccessChain %${SAMPLED_TYPE}_PTR %buffer %rta_offset %idx %alpha_offset
               %blue_access = OpAccessChain %${SAMPLED_TYPE}_PTR %buffer %rta_offset %idx %blue_offset
              %green_access = OpAccessChain %${SAMPLED_TYPE}_PTR %buffer %rta_offset %idx %green_offset
                %red_access = OpAccessChain %${SAMPLED_TYPE}_PTR %buffer %rta_offset %idx %red_offset

                       %red = OpLoad %${SAMPLED_TYPE} %red_access
                     %green = OpLoad %${SAMPLED_TYPE} %green_access
                      %blue = OpLoad %${SAMPLED_TYPE} %blue_access
                     %alpha = OpLoad %${SAMPLED_TYPE} %alpha_access

                              ${WRITE_TO_IMAGE}

                              OpReturn
                              OpFunctionEnd
"""

TYPES_INT64 = """
                     %slong = OpTypeInt 64 1
                     %ulong = OpTypeInt 64 0

                   %v4slong = OpTypeVector %slong 4
                   %v3slong = OpTypeVector %slong 3
                   %v2slong = OpTypeVector %slong 2

                   %v4ulong = OpTypeVector %ulong 4
                   %v3ulong = OpTypeVector %ulong 3
                   %v2ulong = OpTypeVector %ulong 2
"""

TYPES_VEC5 = """
                   %v5float = OpTypeVector %float 5
                    %v5sint = OpTypeVector %sint 5
                    %v5uint = OpTypeVector %uint 5
"""

TYPES_VEC5_64 = """
                   %v5slong = OpTypeVector %slong 5
                   %v5ulong = OpTypeVector %ulong 5
"""

WRITE_FROM = {
    1: """
                     OpImageWrite %img %id_xy %red
""",
    2: """
               %rg = OpCompositeConstruct %v2${SAMPLED_TYPE} %red %green
                     OpImageWrite %img %id_xy %rg
""",
    3: """
              %rgb = OpCompositeConstruct %v3${SAMPLED_TYPE} %red %green %blue
                     OpImageWrite %img %id_xy %rgb
""",
    4: """
             %rgba = OpCompositeConstruct %v4${SAMPLED_TYPE} %red %green %blue %alpha
                     OpImageWrite %img %id_xy %rgba
""",
    5: """
             %rgbaa = OpCompositeConstruct %v5${SAMPLED_TYPE} %red %green %blue %alpha %alpha
                      OpImageWrite %img %id_xy %rgbaa
""",
}

WRITE_TO_IMAGE = """
            %color = OpCompositeConstruct %v4${SAMPLED_TYPE} %red %green %blue %alpha
                     OpImageWrite %img %id_xy %color
"""

LARGEST_WIDTH = 5


def specialize(template, variables):
    return re.sub(r"\$\{(\w+)\}", lambda m: variables[m.group(1)], template)


def buffer_sampled_type(cls, is64):
    """`getChannelStr(makeBufferFormat(class, doubled).type)`"""
    if cls in SIGNED_CLASSES:
        return "slong" if is64 else "sint"
    if cls in UNSIGNED_CLASSES:
        return "ulong" if is64 else "uint"
    return "float"


def assembly(fmt, source_width, width, height, write_to_image):
    _, spirv, cls, _, is64 = fmt
    sampled = buffer_sampled_type(cls, is64)
    # sizeof the buffer's channel type times the four channels of its RGBA order
    stride = (8 if is64 else 4) * 4
    v = {
        "SPIRV_IMAGE_FORMAT": spirv,
        "CAPABILITY_INT64": "",
        "CAPABILITY_VEC5": "",
        "EXTENSIONS": "",
        "TYPES_INT64": "",
        "TYPES_VEC5": "",
    }
    if is64:
        v["EXTENSIONS"] = 'OpExtension       "SPV_EXT_shader_image_int64"\n'
        v["CAPABILITY_INT64"] = "OpCapability Int64ImageEXT\nOpCapability Int64"
        v["TYPES_INT64"] = TYPES_INT64
    if source_width == 5:
        v["EXTENSIONS"] += 'OpExtension       "SPV_EXT_shader_image_int64"\n'
        v["EXTENSIONS"] += 'OpExtension       "SPV_EXT_long_vector"'
        v["CAPABILITY_VEC5"] = "OpCapability LongVectorEXT\n"
        v["TYPES_VEC5"] = TYPES_VEC5
        if is64:
            v["TYPES_VEC5"] += TYPES_VEC5_64
    v["SAMPLED_TYPE"] = sampled
    v["IMAGE_WIDTH"] = str(width)
    v["IMAGE_HEIGHT"] = str(height)
    v["ARRAY_STRIDE"] = str(stride)
    v["WRITE_TO_IMAGE"] = specialize(write_to_image, v)
    return specialize(MAIN_TEMPLATE, v)


def toml_string(text):
    return json.dumps(text, ensure_ascii=False)


def cases():
    out = []
    for fmt in ALL_FORMATS:
        name, spirv, cls, channels, is64 = fmt
        compatible = [f for f in ALL_FORMATS if f[2] == cls]
        for index, other in enumerate(compatible):
            if other[4] or is64:
                continue
            out.append(("signedness", spirv, index, assembly(fmt, 4, 12, 8 * (index + 1), WRITE_TO_IMAGE)))
        for source_width in range(LARGEST_WIDTH, 0, -1):
            if source_width >= channels:
                out.append(("vector_sizes", spirv, source_width, assembly(fmt, source_width, 12 * source_width, 8 * (6 - source_width + 1), WRITE_FROM[source_width])))
    return out


def render():
    out = [
        "# Shader manifest for dEQP-VK.image.mismatched_write_op.* (vktImageMismatchedWriteOpTests.cpp)\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_image_mismatched_write_op_manifest.py - do not hand-edit.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/image/vktImageMismatchedWriteOpTests.cpp"\n'
        'rust_module = "image/mismatched_write_op_tests"\n'
    ]
    for kind, spirv, variant, source in cases():
        name = f"{kind}_{spirv}_{variant}"
        const = name.upper()
        out.append(
            f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "MismatchedWriteOpPrograms"\n'
            f'programs = [ {{ name = "comp", template = "{TEMPLATE}", stage = "asm", spirv_version = "spirv1.4" }} ]\n'
            f'params = {{ kind = {{ type = "str", value = "{kind}" }}, spirv_format = {{ type = "str", value = "{spirv}" }}, variant = {{ type = "u32", value = {variant} }} }}\n'
            f"derived = {{ source = {toml_string(repr(source))} }}\n"
        )
    return "".join(out)


def main():
    text = render()
    if "--check" in sys.argv:
        if not OUT.exists() or OUT.read_text(encoding="utf-8") != text:
            print(f"{OUT} is stale")
            return 1
        return 0
    OUT.write_text(text, encoding="utf-8")
    print(f"wrote {len(cases())} cases")
    return 0


if __name__ == "__main__":
    sys.exit(main())

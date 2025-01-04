#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_image_input.toml: the compute cases of dEQP-VK.spirv_assembly.instruction.compute whose input is an image or a sampler -
`non_semantic_info` (vktSpvAsmNonSemanticInfoTests.cpp, 8 cases) and `image_sampler` (`addComputeImageSamplerTest` of vktSpvAsmImageSamplerTests.cpp, 816 cases).

Both fill their assembly from the pieces upstream concatenates (`getFunctionDstVariableStr`, `getImageSamplerTypeStr`, ...), which this replays with the same
loops, in the same order and with the same names. The host side needs what upstream builds next to the shader: for the image sampler group the 64 random
vec4 of the group (drawn once, then inverted by every case that uses two combined image samplers, so a case carries how many inversions came before it as
`flips`), which read operation, which descriptor type, which test type and, for `optypeimage_mismatch`, which format; src/vkt/tests/spirv_assembly/image_input_tests.rs
reads that back.

Not here: the graphics half of vktSpvAsmImageSamplerTests.cpp and the depth (`dref`) read operations, which only the graphics half uses.

    python3 hodow_cts/scripts/gen_spirv_assembly_image_input_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
import re
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_image_input.toml"
TEMPLATE = "spirv_assembly/source.asm"
NUM_DATA_POINTS = 64

COMMON_TYPES = (
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%f32       = OpTypeFloat 32\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%fvec3     = OpTypeVector %f32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%i32ptr    = OpTypePointer Uniform %i32\n"
    "%f32ptr    = OpTypePointer Uniform %f32\n"
    "%i32arr    = OpTypeRuntimeArray %i32\n"
    "%f32arr    = OpTypeRuntimeArray %f32\n"
)
INPUT_OUTPUT_BUFFER = (
    "%buf     = OpTypeStruct %f32arr\n"
    "%bufptr  = OpTypePointer Uniform %buf\n"
    "%indata    = OpVariable %bufptr Uniform\n"
    "%outdata   = OpVariable %bufptr Uniform\n"
)


def preamble(capabilities="", extensions=""):
    return (
        "OpCapability Shader\n" + capabilities + extensions + "OpMemoryModel Logical GLSL450\n"
        'OpEntryPoint GLCompute %main "main" %id \n' + "OpExecutionMode %main LocalSize 1 1 1\n"
    )


# ---- non_semantic_info ----


def non_semantic_source(test):
    extended_instructions = '%extInstSet = OpExtInstImport "NonSemantic.KHR.DebugInfo"\n'
    additional_decorations = ""
    additional_preamble = ""
    additional_types_and_const = ""
    beginning_of_main = ""
    middle_of_main = ""

    if test == "basic":
        additional_preamble += '%fileStr = OpString "path\\to\\source.file"\nOpSource GLSL 430 %fileStr\n'
        middle_of_main += "%tmp = OpExtInst %void %extInstSet 1 %main %fileStr\n"
    elif test == "dummy_instruction_set":
        extended_instructions = '%extInstSet = OpExtInstImport "NonSemantic.P.B.NonexistingSet"\n'
        additional_preamble += '%testStrA = OpString "this.is.test"\n%testStrB = OpString "yet another test"\n'
        middle_of_main += (
            "%tmpA = OpExtInst %void %extInstSet 55 %id %testStrA %testStrB\n"
            "OpLine %testStrA 1 1\n"
            "%tmpB = OpExtInst %void %extInstSet 99 %testStrA %main %testStrA\n"
            "OpLine %testStrB 2 2\n"
            "OpNoLine\n"
        )
    elif test == "large_instruction_number":
        inst_nr = 2**32 - 2
        middle_of_main += f"%tmpA = OpExtInst %void %extInstSet {inst_nr} %main\n" + "%tmpB = OpExtInst %void %extInstSet 4294967290 %main\n"
    elif test == "many_parameters":
        middle_of_main += "%tmp = OpExtInst %void %extInstSet 1234"
        for index in range(100):
            name = f"%testStr{index}"
            additional_preamble += f'{name} = OpString "{index}"\n'
            middle_of_main += " " + name
        middle_of_main += "\n"
    elif test in ("any_constant_type", "any_constant_type_used"):
        additional_decorations = "OpMemberDecorate %struct 0 Offset 0\nOpMemberDecorate %struct 1 Offset 4\nOpMemberDecorate %struct 2 Offset 16\n"
        types = (
            "%struct             = OpTypeStruct %f32 %fvec3 %i32\n"
            "%c_array_size       = OpConstant %u32 4\n"
            "%array4             = OpTypeArray %f32 %c_array_size\n"
            "%matrix3x3          = OpTypeMatrix %fvec3 3\n"
        )
        constants = (
            "%undef      = OpUndef %i32\n"
            "%c_i32      = OpConstant %i32 -45\n"
            "%c_u32      = OpConstant %u32 99\n"
            "%c_f32      = OpConstant %f32 0.0\n"
            "%c_fvec3    = OpConstantComposite %fvec3 %c_f32 %c_f32 %c_f32\n"
            "%c_struct   = OpConstantComposite %struct %c_f32 %c_fvec3 %undef\n"
            "%c_array    = OpConstantComposite %array4 %c_f32 %c_f32 %c_f32 %c_f32\n"
            "%c_matrix   = OpConstantComposite %matrix3x3 %c_fvec3 %c_fvec3 %c_fvec3\n"
        )
        additional_preamble += '%testStr = OpString ""\n'
        additional_types_and_const = types + constants
        middle_of_main += "%tmp = OpExtInst %void %extInstSet 999 %main %undef %c_i32 %c_u32 %c_f32 %c_struct %c_fvec3 %c_array %testStr %c_matrix\n"
        if test == "any_constant_type_used":
            middle_of_main += (
                "%tmp01      = OpCompositeExtract %f32 %c_fvec3 2\n"
                "%tmp02      = OpFAdd %f32 %tmp01 %c_f32\n"
                "%tmp03      = OpCompositeExtract %f32 %c_struct 0\n"
                "%tmp04      = OpFAdd %f32 %tmp02 %tmp03\n"
                "%tmp05      = OpCompositeExtract %f32 %c_array 1\n"
                "%tmp06      = OpFAdd %f32 %tmp04 %tmp05\n"
                "%tmp07      = OpCompositeExtract %fvec3 %c_matrix 1\n"
                "%tmp08      = OpCompositeExtract %f32 %tmp07 1\n"
                "%tmp09      = OpFMul %f32 %tmp06 %tmp08\n"
                "%tmp10      = OpConvertSToF %f32 %c_i32\n"
                "%tmp11      = OpFMul %f32 %tmp09 %tmp10\n"
                "              OpStore %outloc %tmp11\n"
            )
    elif test == "any_non_constant_type":
        additional_decorations = "OpMemberDecorate %struct 0 Offset 0\nOpMemberDecorate %struct 1 Offset 4\nOpMemberDecorate %struct 2 Offset 16\n"
        extended_instructions += '%std450 = OpExtInstImport "GLSL.std.450"\n'
        additional_types_and_const = (
            "%struct             = OpTypeStruct %f32 %fvec3 %f32\n"
            "%struct_ptr         = OpTypePointer Function %struct\n"
            "%c_array_size       = OpConstant %u32 4\n"
            "%array4             = OpTypeArray %f32 %c_array_size\n"
            "%array4_ptr         = OpTypePointer Function %array4\n"
            "%matrix3x3          = OpTypeMatrix %fvec3 3\n"
            "%matrix3x3_ptr      = OpTypePointer Function %matrix3x3\n"
            "%ivec2              = OpTypeVector %i32 2\n"
            "%fvec4              = OpTypeVector %f32 4\n"
            "%uv                 = OpConstantComposite %ivec2 %zero %zero\n"
        )
        beginning_of_main = (
            "%struct_var = OpVariable %struct_ptr Function\n"
            "%array_var  = OpVariable %array4_ptr Function\n"
            "%matrix_var = OpVariable %matrix3x3_ptr Function\n"
        )
        middle_of_main = (
            "%tmp01      = OpExtInst %void %extInstSet 486 %main %id %x %idval %struct_var %array_var %matrix_var %uvec3ptr %indata\n"
            "%arithmRes  = OpIAdd %u32 %x %x\n"
            "%extInstRes = OpExtInst %f32 %std450 FAbs %inval\n"
            "%logicRes   = OpIsNan %bool %inval\n"
            "%imgLoadRes = OpLoad %image_type %image\n"
            "%tmp02      = OpExtInst %void %extInstSet 963 %tmp01 %arithmRes %inloc %outloc %inval %extInstRes %logicRes %imgLoadRes %std450\n"
        )
    elif test == "placement":
        additional_types_and_const = (
            "%extInstA   = OpExtInst %void %extInstSet 1 %id\n"
            "%floatf     = OpTypeFunction %f32 %f32\n"
            "%funDefA    = OpFunction %f32 None %floatf\n"
            "%funApa     = OpFunctionParameter %f32\n"
            "%funA       = OpLabel\n"
            "              OpReturnValue %funApa\n"
            "              OpFunctionEnd\n"
            "%extInstB  = OpExtInst %void %extInstSet 3 %id\n"
        )
        middle_of_main += (
            "%aRes       = OpFunctionCall %f32 %funDefA %inval\n"
            "%extInstC   = OpExtInst %void %extInstSet 4 %aRes\n"
            "              OpStore %outloc %aRes\n"
        )
    else:
        raise ValueError(test)

    return (
        preamble("", 'OpExtension "SPV_KHR_non_semantic_info"\n' + extended_instructions)
        + additional_preamble
        + "OpDecorate %id BuiltIn GlobalInvocationId\n"
        "OpDecorate %buf BufferBlock\n"
        "OpDecorate %indata DescriptorSet 0\n"
        "OpDecorate %indata Binding 0\n"
        "OpDecorate %image DescriptorSet 0\n"
        "OpDecorate %image Binding 1\n"
        "OpDecorate %image NonWritable\n"
        "OpDecorate %outdata DescriptorSet 0\n"
        "OpDecorate %outdata Binding 2\n"
        "OpDecorate %f32arr ArrayStride 4\n"
        "OpMemberDecorate %buf 0 Offset 0\n"
        + additional_decorations
        + COMMON_TYPES
        + INPUT_OUTPUT_BUFFER
        + "%id         = OpVariable %uvec3ptr Input\n"
        "%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8\n"
        "%image_ptr  = OpTypePointer UniformConstant %image_type\n"
        "%image      = OpVariable %image_ptr UniformConstant\n"
        "%zero       = OpConstant %i32 0\n"
        + additional_types_and_const
        + "%main       = OpFunction %void None %voidf\n"
        "%label      = OpLabel\n"
        + beginning_of_main
        + "%idval      = OpLoad %uvec3 %id\n"
        "%x          = OpCompositeExtract %u32 %idval 0\n"
        "%inloc      = OpAccessChain %f32ptr %indata %zero %x\n"
        "%outloc     = OpAccessChain %f32ptr %outdata %zero %x\n"
        "%inval      = OpLoad %f32 %inloc\n"
        + middle_of_main
        + "             OpStore %outloc %inval\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n"
    )


NON_SEMANTIC_TESTS = [
    "basic", "dummy_instruction_set", "large_instruction_number", "many_parameters",
    "any_constant_type", "any_constant_type_used", "any_non_constant_type", "placement",
]

# ---- image_sampler ----

(TT_LOCAL, TT_IMAGE, TT_SAMPLER, TT_IMAGE_AND_SAMPLER, TT_MISMATCH) = range(5)
(OP_IMAGEREAD, OP_IMAGEFETCH, OP_IMAGESAMPLE) = range(3)
(DT_STORAGE, DT_SAMPLED, DT_COMBINED, DT_COMBINED_SEPARATE_VARIABLES, DT_COMBINED_SEPARATE_DESCRIPTORS) = range(5)

TEST_NAMES = ["all_local_variables", "pass_image_to_function", "pass_sampler_to_function", "pass_image_and_sampler_to_function", "optypeimage_mismatch"]
OP_NAMES = ["imageread", "imagefetch", "imagesample"]
DESC_NAMES = ["storage_image", "sampled_image", "combined_image_sampler", "combined_image_sampler_separate_variables", "combined_image_sampler_separate_descriptors"]
DEPTH_NAMES = ["non_depth", "depth", "unknown"]

FORMATS = [  # (VkFormat name, name, mismatch image format, spirv type, spirv vector type)
    ("R8G8B8A8_UNORM", "rgba8", "Rgba16f", "%f32", "%v4f32"),
    ("R8G8B8A8_SNORM", "rgba8snorm", "Rgba16f", "%f32", "%v4f32"),
    ("R8G8B8A8_UINT", "rgba8ui", "Rgba16ui", "%u32", "%v4u32"),
    ("R8G8B8A8_SINT", "rgba8i", "Rgba16i", "%i32", "%v4i32"),
    ("R16G16B16A16_UINT", "rgba16ui", "Rgba32ui", "%u32", "%v4u32"),
    ("R16G16B16A16_SINT", "rgba16i", "Rgba32i", "%i32", "%v4i32"),
    ("R16G16B16A16_SFLOAT", "rgba16f", "Rgba32f", "%f32", "%v4f32"),
    ("R32_UINT", "r32ui", "Rgba32ui", "%u32", "%v4u32"),
    ("R32_SINT", "r32i", "Rgba32i", "%i32", "%v4i32"),
    ("R32G32B32A32_UINT", "rgba32ui", "Rgba8ui", "%u32", "%v4u32"),
    ("R32G32B32A32_SINT", "rgba32i", "Rgba8i", "%i32", "%v4i32"),
    ("R32G32B32A32_SFLOAT", "rgba32f", "Rgba8", "%f32", "%v4f32"),
]


def is_valid_test_case(test, desc, op):
    if test == TT_IMAGE:
        if desc not in (DT_STORAGE, DT_SAMPLED, DT_COMBINED_SEPARATE_VARIABLES, DT_COMBINED_SEPARATE_DESCRIPTORS):
            return False
    elif test in (TT_SAMPLER, TT_IMAGE_AND_SAMPLER):
        if desc not in (DT_SAMPLED, DT_COMBINED_SEPARATE_VARIABLES, DT_COMBINED_SEPARATE_DESCRIPTORS):
            return False
    if op == OP_IMAGEREAD:
        if desc != DT_STORAGE:
            return False
    else:
        if desc == DT_STORAGE:
            return False
    return True


def function_dst_variable_str(op, desc, test):
    pass_ndx = test in (TT_LOCAL, TT_MISMATCH)
    pass_img = test in (TT_IMAGE, TT_IMAGE_AND_SAMPLER)
    pass_smp = test in (TT_SAMPLER, TT_IMAGE_AND_SAMPLER)

    if desc == DT_STORAGE:
        if op == OP_IMAGEREAD and pass_ndx:
            return "           %func_img = OpLoad %Image %InputData\n"
        return ""
    if desc in (DT_SAMPLED, DT_COMBINED_SEPARATE_VARIABLES):
        if op == OP_IMAGEFETCH:
            if pass_ndx:
                return "           %func_img = OpLoad %Image %InputData\n"
            if pass_smp and not pass_img:
                return (
                    "           %func_tmp = OpLoad %Image %InputData\n"
                    "           %func_smi = OpSampledImage %SampledImage %func_tmp %func_smp\n"
                    "           %func_img = OpImage %Image %func_smi\n"
                )
            if pass_smp and pass_img:
                return "           %func_smi = OpSampledImage %SampledImage %func_tmp %func_smp\n           %func_img = OpImage %Image %func_smi\n"
        else:
            if pass_ndx:
                return (
                    "           %func_img = OpLoad %Image %InputData\n"
                    "           %func_smp = OpLoad %Sampler %SamplerData\n"
                    "           %func_smi = OpSampledImage %SampledImage %func_img %func_smp\n"
                )
            if pass_img and not pass_smp:
                return "           %func_smp = OpLoad %Sampler %SamplerData\n           %func_smi = OpSampledImage %SampledImage %func_img %func_smp\n"
            if pass_smp and not pass_img:
                return "           %func_img = OpLoad %Image %InputData\n           %func_smi = OpSampledImage %SampledImage %func_img %func_smp\n"
            if pass_smp and pass_img:
                return "           %func_smi = OpSampledImage %SampledImage %func_img %func_smp\n"
        return ""
    if desc == DT_COMBINED:
        if pass_ndx:
            if op == OP_IMAGEFETCH:
                return "           %func_smi = OpLoad %SampledImage %InputData\n           %func_img = OpImage %Image %func_smi\n"
            return "           %func_smi = OpLoad %SampledImage %InputData\n"
        return ""
    if desc == DT_COMBINED_SEPARATE_DESCRIPTORS:
        if op == OP_IMAGEFETCH:
            if pass_ndx:
                return "           %func_img = OpLoad %Image %InputData2\n"
            if pass_smp and not pass_img:
                return (
                    "           %func_tmp = OpLoad %Image %InputData2\n"
                    "           %func_smi = OpSampledImage %SampledImage %func_tmp %func_smp\n"
                    "           %func_img = OpImage %Image %func_smi\n"
                )
            if pass_smp and pass_img:
                return "           %func_smi = OpSampledImage %SampledImage %func_tmp %func_smp\n           %func_img = OpImage %Image %func_smi\n"
        else:
            if pass_ndx:
                return (
                    "           %func_img = OpLoad %Image %InputData2\n"
                    "           %func_smp = OpLoad %Sampler %SamplerData\n"
                    "           %func_smi = OpSampledImage %SampledImage %func_img %func_smp\n"
                )
            if pass_img and not pass_smp:
                return "           %func_smp = OpLoad %Sampler %SamplerData\n           %func_smi = OpSampledImage %SampledImage %func_img %func_smp\n"
            if pass_smp and not pass_img:
                return "           %func_img = OpLoad %Image %InputData2\n           %func_smi = OpSampledImage %SampledImage %func_img %func_smp\n"
            if pass_smp and pass_img:
                return "           %func_smi = OpSampledImage %SampledImage %func_img %func_smp\n"
        return ""
    raise ValueError(desc)


def function_src_variable_str(op, desc, test):
    pass_img = test in (TT_IMAGE, TT_IMAGE_AND_SAMPLER)
    pass_smp = test in (TT_SAMPLER, TT_IMAGE_AND_SAMPLER)
    result = ""
    if desc == DT_STORAGE:
        if pass_img:
            result += "           %call_img = OpLoad %Image %InputData\n"
    elif desc in (DT_SAMPLED, DT_COMBINED_SEPARATE_VARIABLES):
        if pass_img:
            result += "           %call_img = OpLoad %Image %InputData\n"
        if pass_smp:
            result += "           %call_smp = OpLoad %Sampler %SamplerData\n"
    elif desc == DT_COMBINED_SEPARATE_DESCRIPTORS:
        if pass_img:
            result += "           %call_img = OpLoad %Image %InputData2\n"
        if pass_smp:
            result += "           %call_smp = OpLoad %Sampler %SamplerData\n"
    return result


def function_param_type_str(test):
    result = ""
    if test in (TT_IMAGE, TT_IMAGE_AND_SAMPLER):
        result += " %Image"
    if test in (TT_SAMPLER, TT_IMAGE_AND_SAMPLER):
        result += " %Sampler"
    return result


def function_src_param_str(test):
    result = ""
    if test in (TT_IMAGE, TT_IMAGE_AND_SAMPLER):
        result += " %call_img"
    if test in (TT_SAMPLER, TT_IMAGE_AND_SAMPLER):
        result += " %call_smp"
    return result


def function_dst_param_str(op, test):
    pass_img = test in (TT_IMAGE, TT_IMAGE_AND_SAMPLER)
    pass_smp = test in (TT_SAMPLER, TT_IMAGE_AND_SAMPLER)
    result = ""
    if op == OP_IMAGESAMPLE:
        if pass_img:
            result += "           %func_img = OpFunctionParameter %Image\n"
        if pass_smp:
            result += "           %func_smp = OpFunctionParameter %Sampler\n"
    else:
        if pass_img and not pass_smp:
            result += "           %func_img = OpFunctionParameter %Image\n"
        if pass_smp and not pass_img:
            result += "           %func_smp = OpFunctionParameter %Sampler\n"
        if pass_img and pass_smp:
            result += "           %func_tmp = OpFunctionParameter %Image\n           %func_smp = OpFunctionParameter %Sampler\n"
    return result


def image_read_op_str(op, format_data, use_nontemporal):
    image_operand = " Nontemporal" if use_nontemporal else ""
    vector_type = format_data[4]
    if op == OP_IMAGEREAD:
        return "OpImageRead " + vector_type + " %func_img %coord" + image_operand
    if op == OP_IMAGEFETCH:
        return "OpImageFetch " + vector_type + " %func_img %coord" + image_operand
    if use_nontemporal:
        return "OpImageSampleExplicitLod " + vector_type + " %func_smi %normalcoordf Lod|Nontemporal %c_f32_0"
    return "OpImageSampleExplicitLod " + vector_type + " %func_smi %normalcoordf Lod %c_f32_0"


def image_sampler_type_str(desc, depth_property, test, format_data):
    image_format = format_data[2] if test == TT_MISMATCH else "Rgba32f"
    scalar = format_data[3]
    image = "              %Image = OpTypeImage " + scalar + " 2D " + str(depth_property) + " 0 0 "
    sampler = (
        "            %Sampler = OpTypeSampler\n"
        "         %SamplerPtr = OpTypePointer UniformConstant %Sampler\n"
        "        %SamplerData = OpVariable %SamplerPtr UniformConstant\n"
    )
    if desc == DT_STORAGE:
        return image + "2 " + image_format + "\n           %ImagePtr = OpTypePointer UniformConstant %Image\n          %InputData = OpVariable %ImagePtr UniformConstant\n"
    if desc == DT_SAMPLED or desc == DT_COMBINED_SEPARATE_VARIABLES:
        return (
            image + "1 " + image_format + "\n"
            "           %ImagePtr = OpTypePointer UniformConstant %Image\n"
            "          %InputData = OpVariable %ImagePtr UniformConstant\n"
            + sampler
            + "       %SampledImage = OpTypeSampledImage %Image\n"
        )
    if desc == DT_COMBINED:
        return (
            image + "1 " + image_format + "\n"
            "       %SampledImage = OpTypeSampledImage %Image\n"
            "         %SamplerPtr = OpTypePointer UniformConstant %SampledImage\n"
            "          %InputData = OpVariable %SamplerPtr UniformConstant\n"
        )
    return (
        image + "1 " + image_format + "\n"
        "           %ImagePtr = OpTypePointer UniformConstant %Image\n"
        "          %InputData = OpVariable %ImagePtr UniformConstant\n"
        "         %InputData2 = OpVariable %ImagePtr UniformConstant\n"
        "            %Sampler = OpTypeSampler\n"
        "         %SamplerPtr = OpTypePointer UniformConstant %Sampler\n"
        "        %SamplerData = OpVariable %SamplerPtr UniformConstant\n"
        "       %SamplerData2 = OpVariable %SamplerPtr UniformConstant\n"
        "       %SampledImage = OpTypeSampledImage %Image\n"
    )


def interface_list(desc):
    result = " %InputData %OutputData"
    if desc in (DT_SAMPLED, DT_COMBINED_SEPARATE_VARIABLES):
        result += " %SamplerData"
    elif desc == DT_COMBINED_SEPARATE_DESCRIPTORS:
        result += " %SamplerData %InputData2 %SamplerData2"
    return result


def sampler_decoration(desc):
    if desc == DT_SAMPLED:
        return "                       OpDecorate %SamplerData DescriptorSet 0\n                       OpDecorate %SamplerData Binding 1\n"
    if desc == DT_COMBINED_SEPARATE_VARIABLES:
        return "                       OpDecorate %SamplerData DescriptorSet 0\n                       OpDecorate %SamplerData Binding 0\n"
    if desc == DT_COMBINED_SEPARATE_DESCRIPTORS:
        return (
            "                       OpDecorate %SamplerData DescriptorSet 0\n"
            "                       OpDecorate %SamplerData Binding 0\n"
            "                       OpDecorate %InputData2 DescriptorSet 0\n"
            "                       OpDecorate %InputData2 Binding 1\n"
            "                       OpDecorate %SamplerData2 DescriptorSet 0\n"
            "                       OpDecorate %SamplerData2 Binding 1\n"
        )
    return ""


def image_sampler_source(op, desc, test, depth_property, format_data, use_spirv16, num_inputs):
    image_read_op = image_read_op_str(op, format_data, use_spirv16)
    interface = ""
    output_decoration = "BufferBlock"
    output_type = "Uniform"
    if use_spirv16:
        interface = interface_list(desc)
        output_decoration = "Block"
        output_type = "StorageBuffer"
    vector_type = format_data[4]

    return (
        "                       OpCapability Shader\n"
        '                  %1 = OpExtInstImport "GLSL.std.450"\n'
        "                       OpMemoryModel Logical GLSL450\n"
        '                       OpEntryPoint GLCompute %main "main" %id' + interface + "\n"
        "                       OpExecutionMode %main LocalSize 1 1 1\n"
        "                       OpSource GLSL 430\n"
        "                       OpDecorate %id BuiltIn GlobalInvocationId\n"
        "                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16\n"
        "                       OpMemberDecorate %Output 0 Offset 0\n"
        "                       OpDecorate %Output " + output_decoration + "\n"
        "                       OpDecorate %InputData DescriptorSet 0\n"
        "                       OpDecorate %InputData Binding 0\n"
        + sampler_decoration(desc)
        + "                       OpDecorate %OutputData DescriptorSet 0\n"
        "                       OpDecorate %OutputData Binding " + str(num_inputs) + "\n"
        "               %void = OpTypeVoid\n"
        "                  %3 = OpTypeFunction %void\n"
        "                %u32 = OpTypeInt 32 0\n"
        "                %i32 = OpTypeInt 32 1\n"
        "                %f32 = OpTypeFloat 32\n"
        " %_ptr_Function_uint = OpTypePointer Function %u32\n"
        "              %v3u32 = OpTypeVector %u32 3\n"
        "   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32\n"
        "                 %id = OpVariable %_ptr_Input_v3u32 Input\n"
        "            %c_f32_0 = OpConstant %f32 0.0\n"
        "            %c_u32_0 = OpConstant %u32 0\n"
        "            %c_i32_0 = OpConstant %i32 0\n"
        "    %_ptr_Input_uint = OpTypePointer Input %u32\n"
        "              %v2u32 = OpTypeVector %u32 2\n"
        "              %v2f32 = OpTypeVector %f32 2\n"
        "              %v4f32 = OpTypeVector %f32 4\n"
        "              %v4u32 = OpTypeVector %u32 4\n"
        "              %v4i32 = OpTypeVector %i32 4\n"
        "           %uint_128 = OpConstant %u32 128\n"
        "           %c_u32_64 = OpConstant %u32 64\n"
        "            %c_u32_8 = OpConstant %u32 8\n"
        "            %c_f32_8 = OpConstant %f32 8.0\n"
        "        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8\n"
        " %_arr_v4type_u32_64 = OpTypeArray " + vector_type + " %c_u32_64\n"
        "%_ptr_Uniform_v4type = OpTypePointer " + output_type + " " + vector_type + "\n"
        "             %Output = OpTypeStruct %_arr_v4type_u32_64\n"
        "%_ptr_Uniform_Output = OpTypePointer " + output_type + " %Output\n"
        "         %OutputData = OpVariable %_ptr_Uniform_Output " + output_type + "\n"
        + image_sampler_type_str(desc, depth_property, test, format_data)
        + "     %read_func_type = OpTypeFunction %void %u32" + function_param_type_str(test) + "\n"
        "          %read_func = OpFunction %void None %read_func_type\n"
        "           %func_ndx = OpFunctionParameter %u32\n"
        + function_dst_param_str(op, test)
        + "          %funcentry = OpLabel\n"
        "                %row = OpUMod %u32 %func_ndx %c_u32_8\n"
        "                %col = OpUDiv %u32 %func_ndx %c_u32_8\n"
        "              %coord = OpCompositeConstruct %v2u32 %row %col\n"
        "             %coordf = OpConvertUToF %v2f32 %coord\n"
        "       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8\n"
        + function_dst_variable_str(op, desc, test)
        + "              %color = " + image_read_op + "\n"
        "                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx\n"
        "                       OpStore %36 %color\n"
        "                       OpReturn\n"
        "                       OpFunctionEnd\n"
        "               %main = OpFunction %void None %3\n"
        "                  %5 = OpLabel\n"
        "                  %i = OpVariable %_ptr_Function_uint Function\n"
        "                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0\n"
        "                 %15 = OpLoad %u32 %14\n"
        "                       OpStore %i %15\n"
        "              %index = OpLoad %u32 %14\n"
        + function_src_variable_str(op, desc, test)
        + "                %res = OpFunctionCall %void %read_func %index" + function_src_param_str(test) + "\n"
        "                       OpReturn\n"
        "                       OpFunctionEnd\n"
    )


def main():
    out = [
        "# Shader manifest for the compute cases of dEQP-VK.spirv_assembly.instruction.compute with an image or sampler input: non_semantic_info and image_sampler\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_image_input_manifest.py - do not hand-edit; `spec` says how the host builds the inputs of a case.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmImageSamplerTests.cpp"\n'
        'rust_module = "spirv_assembly/image_input_tests"\n'
    ]
    count = 0

    def emit(path, assembly, spec, spirv_version=None):
        nonlocal count
        name = "/".join(path)
        const = "IMG_" + re.sub(r"[^A-Za-z0-9]", "_", name).upper()
        version = f', spirv_version = "{spirv_version}"' if spirv_version else ""
        out.append(
            f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "ImageInputCase"\n'
            f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm"{version} }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
            f"derived = {{ source = {json.dumps(repr(assembly))} }}\n"
        )
        count += 1

    for test in NON_SEMANTIC_TESTS:
        emit(["non_semantic_info", test], non_semantic_source(test), "group=nonsemantic")

    flips = 0
    for op in range(OP_IMAGESAMPLE + 1):
        for desc in range(5):
            for test in range(5):
                if not is_valid_test_case(test, desc, op):
                    continue
                num_formats = len(FORMATS) if test == TT_MISMATCH else 1
                for format_index in range(num_formats):
                    format_data = FORMATS[format_index]
                    num_inputs = 1 + (1 if desc in (DT_SAMPLED, DT_COMBINED_SEPARATE_DESCRIPTORS) else 0)
                    for use_spirv16 in (False, True):
                        test_name = TEST_NAMES[test]
                        if test == TT_MISMATCH:
                            test_name += "_" + format_data[1]
                        if use_spirv16:
                            test_name += "_nontemporal"
                        for depth_property in range(3):
                            source = image_sampler_source(op, desc, test, depth_property, format_data, use_spirv16, num_inputs)
                            spec = (
                                f"group=imagesampler;op={op};desc={desc};flips={flips};"
                                f"mismatch={format_index if test == TT_MISMATCH else -1};v16={int(use_spirv16)}"
                            )
                            emit(
                                ["image_sampler", OP_NAMES[op], DESC_NAMES[desc], test_name, "depth_property", DEPTH_NAMES[depth_property]],
                                source,
                                spec,
                                "spirv1.6" if use_spirv16 else "spirv1.0",
                            )
                    if desc == DT_COMBINED_SEPARATE_DESCRIPTORS:
                        flips += 1

    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()

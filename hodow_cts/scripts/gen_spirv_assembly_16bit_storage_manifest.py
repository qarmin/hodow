#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_16bit_storage.toml: the compute cases of dEQP-VK.spirv_assembly.instruction.compute.16bit_storage that this port has so far -
`uniform_16_to_32_chainaccess` (432 cases) of `addCompute16bitStorageUniform16To32ChainAccessGroup` `uniform_16_to_32` (26 cases) of `addCompute16bitStorageUniform16To32Group` and
`uniform_32_to_16` (26 cases) of `addCompute16bitStorageUniform32To16Group` in vktSpvAsm16bitStorageTests.cpp.

Each case loads one 16 bit value (float, int or uint) out of an array of structs in a uniform or storage buffer through an OpAccessChain with constant indices, converts it to
32 bits and stores it. The assembly is the template of the C++ filled with the indices, the capability and the type; what the host needs to draw the data and pick the expected
value rides along as `spec` for src/vkt/tests/spirv_assembly/storage16_tests.rs.

    python3 hodow_cts/scripts/gen_spirv_assembly_16bit_storage_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_16bit_storage.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsm16bitStorageTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"

CAPABILITIES = [("uniform_buffer_block", "StorageUniformBufferBlock16", "BufferBlock"), ("uniform", "StorageUniform16", "Block")]

CHAIN_ACCESS_TEMPLATE = (
    "                              OpCapability Shader\n"
    "                              OpCapability ${capability}\n"
    '                              OpExtension "SPV_KHR_16bit_storage"\n'
    '                         %1 = OpExtInstImport "GLSL.std.450"\n'
    "                              OpMemoryModel Logical GLSL450\n"
    '                              OpEntryPoint GLCompute %main "main"\n'
    "                              OpExecutionMode %main LocalSize 1 1 1\n"
    "                              OpSource GLSL 430\n"
    "                              OpDecorate %Output BufferBlock\n"
    "                              OpDecorate %dataOutput DescriptorSet 0\n"
    "                              OpDecorate %dataOutput Binding 1\n"
    "                              OpDecorate %scalarArray ArrayStride 16\n"
    "                              OpDecorate %scalarArray2D ArrayStride 48\n"
    "                              OpMemberDecorate %S 0 Offset 0\n"
    "                              OpMemberDecorate %S 1 Offset 48\n"
    "                              ${decoration}\n"
    "                              OpMemberDecorate %S 2 Offset 240\n"
    "                              OpDecorate %_arr_S_uint_4 ArrayStride 256\n"
    "                              OpMemberDecorate %Input 0 Offset 0\n"
    "                              OpMemberDecorate %Output 0 Offset 0\n"
    "                              OpDecorate %Input ${storage}\n"
    "                              OpDecorate %dataInput DescriptorSet 0\n"
    "                              OpDecorate %dataInput Binding 0\n"
    "                       %f16 = OpTypeFloat 16\n"
    "                       %f32 = OpTypeFloat 32\n"
    "                       %i16 = OpTypeInt 16 1\n"
    "                       %i32 = OpTypeInt 32 1\n"
    "                       %u16 = OpTypeInt 16 0\n"
    "                       %u32 = OpTypeInt 32 0\n"
    "                      %void = OpTypeVoid\n"
    "                  %voidFunc = OpTypeFunction %void\n"
    "        %_ptr_Function_uint = OpTypePointer Function %u32\n"
    "                     %v3u32 = OpTypeVector %u32 3\n"
    "          %_ptr_Input_v3u32 = OpTypePointer Input %v3u32\n"
    "                     %int_0 = OpConstant %i32 0\n"
    "                    %uint_3 = OpConstant %u32 3\n"
    "                    %uint_4 = OpConstant %u32 4\n"
    "                        %s0 = OpConstant %u32 ${s0}\n"
    "                        %s1 = OpConstant %u32 ${s1}\n"
    "                        %s2 = OpConstant %u32 ${s2}\n"
    "                        %s3 = OpConstant %u32 ${s3}\n"
    "                    %Output = OpTypeStruct %${type}32\n"
    "       %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
    "                %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
    "               %scalarArray = OpTypeArray %${type}16 %uint_3\n"
    "                     %v3f16 = OpTypeVector %f16 3\n"
    "                     %v3i16 = OpTypeVector %i16 3\n"
    "                     %v3u16 = OpTypeVector %u16 3\n"
    "                    %matrix = OpTypeMatrix %v3f16 4\n"
    "             %scalarArray2D = OpTypeArray %scalarArray %uint_4\n"
    "                         %S = OpTypeStruct %scalarArray %${type2D} %v3${type}16\n"
    "             %_arr_S_uint_4 = OpTypeArray %S %uint_4\n"
    "                     %Input = OpTypeStruct %_arr_S_uint_4\n"
    "        %_ptr_Uniform_Input = OpTypePointer Uniform %Input\n"
    "                 %dataInput = OpVariable %_ptr_Uniform_Input Uniform\n"
    "   %_ptr_Uniform_16bit_data = OpTypePointer Uniform %${type}16\n"
    "   %_ptr_Uniform_32bit_data = OpTypePointer Uniform %${type}32\n"
    "                      %main = OpFunction %void None %voidFunc\n"
    "                     %entry = OpLabel\n"
    "                   %dataPtr = ${accessChain}\n"
    "                      %data = OpLoad %${type}16 %dataPtr\n"
    "                 %converted = ${convert}\n"
    "                    %outPtr = OpAccessChain %_ptr_Uniform_32bit_data %dataOutput %int_0\n"
    "                              OpStore %outPtr %converted\n"
    "                              OpReturn\n"
    "                              OpFunctionEnd\n"
)

DATA_TYPES = [
    ("float", "f", "OpFConvert %f32 %data", "matrix"),
    ("int", "i", "OpSConvert %i32 %data", "scalarArray2D"),
    ("uint", "u", "OpUConvert %u32 %data", "scalarArray2D"),
]


def specialize(template, values):
    for key, value in values.items():
        template = template.replace("${" + key + "}", value)
    assert "${" not in template, template
    return template


def chain_access_cases():
    indices = []
    for idx0 in range(4):
        for idx1 in range(3):
            for idx2 in range(4 if idx1 == 1 else 3):
                for idx3 in range(3 if idx1 == 1 else 1):
                    indices.append((idx0, idx1, idx2, idx3))
    for index in indices:
        for cap_index, (cap_name, capability, decor) in enumerate(CAPABILITIES):
            index_string = f"{index[0]}_{index[1]}_{index[2]}"
            if index[1] == 1:
                index_string += f"_{index[3]}"
            for type_index, (type_name, type_letter, convert, type_2d) in enumerate(DATA_TYPES):
                access = "OpAccessChain %_ptr_Uniform_16bit_data %dataInput %int_0 %s0 %s1 %s2"
                if index[1] == 1:
                    access += " %s3"
                values = {
                    "capability": capability,
                    "storage": decor,
                    "s0": str(index[0]),
                    "s1": str(index[1]),
                    "s2": str(index[2]),
                    "s3": str(index[3]),
                    "type": type_letter,
                    "convert": convert,
                    "type2D": type_2d,
                    "accessChain": access,
                    "decoration": "OpMemberDecorate %S 1 ColMajor\nOpMemberDecorate %S 1 MatrixStride 48\n" if type_index == 0 else "",
                }
                name = f"16bit_storage/uniform_16_to_32_chainaccess/{cap_name}_{index_string}_{type_name}"
                spec = f"group=chain;cap={cap_index};type={type_index};idx={index[0]}.{index[1]}.{index[2]}.{index[3]}"
                yield name, spec, specialize(CHAIN_ACCESS_TEMPLATE, values)

UNIFORM_16_TO_32_TEMPLATE = (
    "OpCapability Shader\n"
    "OpCapability ${capability}\n"
    'OpExtension "SPV_KHR_16bit_storage"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "${stride}\n"
    "OpMemberDecorate %SSBO32 0 Offset 0\n"
    "OpMemberDecorate %SSBO16 0 Offset 0\n"
    "OpDecorate %SSBO32 BufferBlock\n"
    "OpDecorate %SSBO16 ${storage}\n"
    "OpDecorate %ssbo32 DescriptorSet 0\n"
    "OpDecorate %ssbo16 DescriptorSet 0\n"
    "OpDecorate %ssbo32 Binding 1\n"
    "OpDecorate %ssbo16 Binding 0\n"
    "${matrix_decor}\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%f32       = OpTypeFloat 32\n"
    "%v3u32     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %v3u32\n"
    "%i32ptr    = OpTypePointer Uniform %i32\n"
    "%f32ptr    = OpTypePointer Uniform %f32\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_2   = OpConstant %i32 2\n"
    "%c_i32_3   = OpConstant %i32 3\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%c_i32_128 = OpConstant %i32 128\n"
    "%c_i32_ci  = OpConstant %i32 ${constarrayidx}\n"
    "%i32arr    = OpTypeArray %i32 %c_i32_128\n"
    "%f32arr    = OpTypeArray %f32 %c_i32_128\n"
    "${types}\n"
    "${matrix_types}\n"
    "%SSBO32    = OpTypeStruct %${matrix_prefix}${base32}arr\n"
    "%SSBO16    = OpTypeStruct %${matrix_prefix}${base16}arr\n"
    "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
    "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
    "%ssbo32    = OpVariable %up_SSBO32 Uniform\n"
    "%ssbo16    = OpVariable %up_SSBO16 Uniform\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %v3u32 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base16}ptr %ssbo16 %zero %${arrayindex} ${index0}\n"
    "%val16     = OpLoad %${base16} %inloc\n"
    "%val32     = ${convert} %${base32} %val16\n"
    "%outloc    = OpAccessChain %${base32}ptr %ssbo32 %zero %x ${index0}\n"
    "             OpStore %outloc %val32\n"
    "${matrix_store}\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

FLOAT_TYPES_16_TO_32 = (
    "%f16       = OpTypeFloat 16\n"
    "%f16ptr    = OpTypePointer Uniform %f16\n"
    "%f16arr    = OpTypeArray %f16 %c_i32_128\n"
    "%v2f16     = OpTypeVector %f16 2\n"
    "%v2f32     = OpTypeVector %f32 2\n"
    "%v2f16ptr  = OpTypePointer Uniform %v2f16\n"
    "%v2f32ptr  = OpTypePointer Uniform %v2f32\n"
    "%v2f16arr  = OpTypeArray %v2f16 %c_i32_64\n"
    "%v2f32arr  = OpTypeArray %v2f32 %c_i32_64\n"
)
SINT_TYPES_16_TO_32 = (
    "%i16       = OpTypeInt 16 1\n"
    "%i16ptr    = OpTypePointer Uniform %i16\n"
    "%i16arr    = OpTypeArray %i16 %c_i32_128\n"
    "%v4i16     = OpTypeVector %i16 4\n"
    "%v4i32     = OpTypeVector %i32 4\n"
    "%v4i16ptr  = OpTypePointer Uniform %v4i16\n"
    "%v4i32ptr  = OpTypePointer Uniform %v4i32\n"
    "%v4i16arr  = OpTypeArray %v4i16 %c_i32_32\n"
    "%v4i32arr  = OpTypeArray %v4i32 %c_i32_32\n"
)
UINT_TYPES_16_TO_32 = (
    "%u16       = OpTypeInt 16 0\n"
    "%u16ptr    = OpTypePointer Uniform %u16\n"
    "%u32ptr    = OpTypePointer Uniform %u32\n"
    "%u16arr    = OpTypeArray %u16 %c_i32_128\n"
    "%u32arr    = OpTypeArray %u32 %c_i32_128\n"
    "%v4u16     = OpTypeVector %u16 4\n"
    "%v4u32     = OpTypeVector %u32 4\n"
    "%v4u16ptr  = OpTypePointer Uniform %v4u16\n"
    "%v4u32ptr  = OpTypePointer Uniform %v4u32\n"
    "%v4u16arr  = OpTypeArray %v4u16 %c_i32_32\n"
    "%v4u32arr  = OpTypeArray %v4u32 %c_i32_32\n"
)

MATRIX_TYPES = (
    "%m4v2f16 = OpTypeMatrix %v2f16 4\n"
    "%m4v2f32 = OpTypeMatrix %v2f32 4\n"
    "%m4v2f16arr = OpTypeArray %m4v2f16 %c_i32_16\n"
    "%m4v2f32arr = OpTypeArray %m4v2f32 %c_i32_16\n"
)
MATRIX_DECOR = (
    "OpMemberDecorate %SSBO32 0 ColMajor\n"
    "OpMemberDecorate %SSBO32 0 MatrixStride 8\n"
    "OpMemberDecorate %SSBO16 0 ColMajor\n"
    "OpMemberDecorate %SSBO16 0 MatrixStride 16\n"
)
MATRIX_STORE = "".join(
    f"%inloc_{i}  = OpAccessChain %v2f16ptr %ssbo16 %zero %x %c_i32_{i}\n"
    f"%val16_{i}  = OpLoad %v2f16 %inloc_{i}\n"
    f"%val32_{i}  = OpFConvert %v2f32 %val16_{i}\n"
    f"%outloc_{i} = OpAccessChain %v2f32ptr %ssbo32 %zero %x %c_i32_{i}\n"
    f"            OpStore %outloc_{i} %val32_{i}\n"
    for i in (1, 2, 3)
)

# (name, base32, base16, stride, constant index or None, count, input stride) of the float cases, per capability.
NUM_ELEMENTS = 128
FLOAT_COMPOSITES = [
    [
        ("scalar", "f32", "f16", "OpDecorate %f32arr ArrayStride 4\nOpDecorate %f16arr ArrayStride 2\n", None, NUM_ELEMENTS, 1),
        ("scalar_const_idx_5", "f32", "f16", "OpDecorate %f32arr ArrayStride 4\nOpDecorate %f16arr ArrayStride 2\n", 5, NUM_ELEMENTS, 1),
        ("scalar_const_idx_8", "f32", "f16", "OpDecorate %f32arr ArrayStride 4\nOpDecorate %f16arr ArrayStride 2\n", 8, NUM_ELEMENTS, 1),
        ("vector", "v2f32", "v2f16", "OpDecorate %v2f32arr ArrayStride 8\nOpDecorate %v2f16arr ArrayStride 4\n", None, NUM_ELEMENTS // 2, 2),
        ("matrix", "v2f32", "v2f16", "OpDecorate %m4v2f32arr ArrayStride 32\nOpDecorate %m4v2f16arr ArrayStride 64\n", None, NUM_ELEMENTS // 8, 8),
    ],
    [
        ("scalar", "f32", "f16", "OpDecorate %f32arr ArrayStride 4\nOpDecorate %f16arr ArrayStride 16\n", None, NUM_ELEMENTS, 8),
        ("scalar_const_idx_5", "f32", "f16", "OpDecorate %f32arr ArrayStride 4\nOpDecorate %f16arr ArrayStride 16\n", 5, NUM_ELEMENTS, 8),
        ("scalar_const_idx_8", "f32", "f16", "OpDecorate %f32arr ArrayStride 4\nOpDecorate %f16arr ArrayStride 16\n", 8, NUM_ELEMENTS, 8),
        ("vector", "v2f32", "v2f16", "OpDecorate %v2f32arr ArrayStride 8\nOpDecorate %v2f16arr ArrayStride 16\n", None, NUM_ELEMENTS // 2, 8),
        ("matrix", "v2f32", "v2f16", "OpDecorate %m4v2f32arr ArrayStride 32\nOpDecorate %m4v2f16arr ArrayStride 64\n", None, NUM_ELEMENTS // 8, 8),
    ],
]


def int_composites(input_stride_scalar, input_stride_vector):
    s16 = f"OpDecorate %i32arr ArrayStride 4\nOpDecorate %i16arr ArrayStride {2 if input_stride_scalar == 1 else 16}\n"
    u16 = f"OpDecorate %u32arr ArrayStride 4\nOpDecorate %u16arr ArrayStride {2 if input_stride_scalar == 1 else 16}\n"
    v4i = f"OpDecorate %v4i32arr ArrayStride 16\nOpDecorate %v4i16arr ArrayStride {8 if input_stride_scalar == 1 else 16}\n"
    v4u = f"OpDecorate %v4u32arr ArrayStride 16\nOpDecorate %v4u16arr ArrayStride {8 if input_stride_scalar == 1 else 16}\n"
    return [
        ("scalar_sint", True, SINT_TYPES_16_TO_32, "i32", "i16", "OpSConvert", s16, None, NUM_ELEMENTS, input_stride_scalar),
        ("scalar_sint_const_idx_5", True, SINT_TYPES_16_TO_32, "i32", "i16", "OpSConvert", s16, 5, NUM_ELEMENTS, input_stride_scalar),
        ("scalar_sint_const_idx_8", True, SINT_TYPES_16_TO_32, "i32", "i16", "OpSConvert", s16, 8, NUM_ELEMENTS, input_stride_scalar),
        ("scalar_uint", False, UINT_TYPES_16_TO_32, "u32", "u16", "OpUConvert", u16, None, NUM_ELEMENTS, input_stride_scalar),
        ("scalar_uint_const_idx_5", False, UINT_TYPES_16_TO_32, "u32", "u16", "OpUConvert", u16, 5, NUM_ELEMENTS, input_stride_scalar),
        ("scalar_uint_const_idx_8", False, UINT_TYPES_16_TO_32, "u32", "u16", "OpUConvert", u16, 8, NUM_ELEMENTS, input_stride_scalar),
        ("vector_sint", True, SINT_TYPES_16_TO_32, "v4i32", "v4i16", "OpSConvert", v4i, None, NUM_ELEMENTS // 4, input_stride_vector),
        ("vector_uint", False, UINT_TYPES_16_TO_32, "v4u32", "v4u16", "OpUConvert", v4u, None, NUM_ELEMENTS // 4, input_stride_vector),
    ]


INT_COMPOSITES = [int_composites(1, 4), int_composites(8, 8)]


def uniform_16_to_32_cases():
    order = 0
    skip = 0
    for cap_index, (cap_name, capability, decor) in enumerate(CAPABILITIES):
        for name, base32, base16, stride, const_idx, count, input_stride in FLOAT_COMPOSITES[cap_index]:
            values = {
                "capability": capability, "storage": decor, "stride": stride, "base32": base32, "base16": base16, "types": FLOAT_TYPES_16_TO_32, "convert": "OpFConvert",
                "constarrayidx": str(const_idx or 0), "arrayindex": "c_i32_ci" if const_idx is not None else "x",
                "index0": "", "matrix_prefix": "", "matrix_types": "", "matrix_decor": "", "matrix_store": "",
            }
            if name == "matrix":
                values.update({"index0": "%zero", "matrix_prefix": "m4", "matrix_types": MATRIX_TYPES, "matrix_decor": MATRIX_DECOR, "matrix_store": MATRIX_STORE})
            spec = f"group=u16to32;skip={skip};cap={cap_index};kind=float;count={count};stride={input_stride};const={-1 if const_idx is None else const_idx};matrix={int(name == 'matrix')};signed=0"
            yield f"16bit_storage/uniform_16_to_32/{cap_name}_{name}_float", spec, specialize(UNIFORM_16_TO_32_TEMPLATE, values)
            skip += NUM_ELEMENTS * input_stride - 14
    for cap_index, (cap_name, capability, decor) in enumerate(CAPABILITIES):
        for name, is_signed, types, base32, base16, opcode, stride, const_idx, count, input_stride in INT_COMPOSITES[cap_index]:
            values = {
                "capability": capability, "storage": decor, "stride": stride, "base32": base32, "base16": base16, "types": types, "convert": opcode,
                "constarrayidx": str(const_idx or 0), "arrayindex": "c_i32_ci" if const_idx is not None else "x",
                "index0": "", "matrix_prefix": "", "matrix_types": "", "matrix_decor": "", "matrix_store": "",
            }
            spec = f"group=u16to32;skip={skip};cap={cap_index};kind=int;count={count};stride={input_stride};const={-1 if const_idx is None else const_idx};matrix=0;signed={int(is_signed)}"
            yield f"16bit_storage/uniform_16_to_32/{cap_name}_{name}", spec, specialize(UNIFORM_16_TO_32_TEMPLATE, values)
            skip += NUM_ELEMENTS * input_stride - 8


UNIFORM_32_TO_16_TEMPLATE = (
    "OpCapability Shader\n"
    "OpCapability ${capability}\n"
    'OpExtension "SPV_KHR_16bit_storage"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "${stride}"
    "OpMemberDecorate %SSBO32 0 Offset 0\n"
    "OpMemberDecorate %SSBO16 0 Offset 0\n"
    "OpDecorate %SSBO32 ${storage}\n"
    "OpDecorate %SSBO16 BufferBlock\n"
    "OpDecorate %ssbo32 DescriptorSet 0\n"
    "OpDecorate %ssbo16 DescriptorSet 0\n"
    "OpDecorate %ssbo32 Binding 0\n"
    "OpDecorate %ssbo16 Binding 1\n"
    "${matrix_decor}\n"
    "${rounding}\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%f32       = OpTypeFloat 32\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%i32ptr    = OpTypePointer Uniform %i32\n"
    "%f32ptr    = OpTypePointer Uniform %f32\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%c_i32_128 = OpConstant %i32 128\n"
    "%i32arr    = OpTypeArray %i32 %c_i32_128\n"
    "%f32arr    = OpTypeArray %f32 %c_i32_128\n"
    "${types}\n"
    "${matrix_types}\n"
    "%SSBO32    = OpTypeStruct %${matrix_prefix}${base32}arr\n"
    "%SSBO16    = OpTypeStruct %${matrix_prefix}${base16}arr\n"
    "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
    "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
    "%ssbo32    = OpVariable %up_SSBO32 Uniform\n"
    "%ssbo16    = OpVariable %up_SSBO16 Uniform\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base32}ptr %ssbo32 %zero %x ${index0}\n"
    "%val32     = OpLoad %${base32} %inloc\n"
    "%val16     = ${convert} %${base16} %val32\n"
    "%outloc    = OpAccessChain %${base16}ptr %ssbo16 %zero %x ${index0}\n"
    "             OpStore %outloc %val16\n"
    "${matrix_store}\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

FLOAT_TYPES_32_TO_16 = (
    "%f16       = OpTypeFloat 16\n"
    "%f16ptr    = OpTypePointer Uniform %f16\n"
    "%f16arr    = OpTypeArray %f16 %c_i32_128\n"
    "%v4f16     = OpTypeVector %f16 4\n"
    "%v4f32     = OpTypeVector %f32 4\n"
    "%v4f16ptr  = OpTypePointer Uniform %v4f16\n"
    "%v4f32ptr  = OpTypePointer Uniform %v4f32\n"
    "%v4f16arr  = OpTypeArray %v4f16 %c_i32_32\n"
    "%v4f32arr  = OpTypeArray %v4f32 %c_i32_32\n"
)
SINT_TYPES_32_TO_16 = (
    "%i16       = OpTypeInt 16 1\n"
    "%i16ptr    = OpTypePointer Uniform %i16\n"
    "%i16arr    = OpTypeArray %i16 %c_i32_128\n"
    "%v2i16     = OpTypeVector %i16 2\n"
    "%v2i32     = OpTypeVector %i32 2\n"
    "%v2i16ptr  = OpTypePointer Uniform %v2i16\n"
    "%v2i32ptr  = OpTypePointer Uniform %v2i32\n"
    "%v2i16arr  = OpTypeArray %v2i16 %c_i32_64\n"
    "%v2i32arr  = OpTypeArray %v2i32 %c_i32_64\n"
)
UINT_TYPES_32_TO_16 = (
    "%u16       = OpTypeInt 16 0\n"
    "%u16ptr    = OpTypePointer Uniform %u16\n"
    "%u32ptr    = OpTypePointer Uniform %u32\n"
    "%u16arr    = OpTypeArray %u16 %c_i32_128\n"
    "%u32arr    = OpTypeArray %u32 %c_i32_128\n"
    "%v2u16     = OpTypeVector %u16 2\n"
    "%v2u32     = OpTypeVector %u32 2\n"
    "%v2u16ptr  = OpTypePointer Uniform %v2u16\n"
    "%v2u32ptr  = OpTypePointer Uniform %v2u32\n"
    "%v2u16arr  = OpTypeArray %v2u16 %c_i32_64\n"
    "%v2u32arr  = OpTypeArray %v2u32 %c_i32_64\n"
)

# (name, decoration, flags): the flags are the rounding modes the check accepts, RTE = 1 and RTZ = 2.
ROUNDING_MODES = [("rtz", "OpDecorate %val16  FPRoundingMode RTZ", 2), ("rte", "OpDecorate %val16  FPRoundingMode RTE", 1), ("unspecified_rnd_mode", "", 3)]

FLOAT_COMPOSITES_32_TO_16 = [
    [
        ("scalar", "f32", "f16", "OpDecorate %f32arr ArrayStride 4\nOpDecorate %f16arr ArrayStride 2\n", NUM_ELEMENTS, 1),
        ("vector", "v4f32", "v4f16", "OpDecorate %v4f32arr ArrayStride 16\nOpDecorate %v4f16arr ArrayStride 8\n", NUM_ELEMENTS // 4, 1),
        ("matrix", "v4f32", "v4f16", "OpDecorate %m2v4f32arr ArrayStride 32\nOpDecorate %m2v4f16arr ArrayStride 16\n", NUM_ELEMENTS // 8, 1),
    ],
    [
        ("scalar", "f32", "f16", "OpDecorate %f32arr ArrayStride 16\nOpDecorate %f16arr ArrayStride 2\n", NUM_ELEMENTS, 4),
        ("vector", "v4f32", "v4f16", "OpDecorate %v4f32arr ArrayStride 16\nOpDecorate %v4f16arr ArrayStride 8\n", NUM_ELEMENTS // 4, 1),
        ("matrix", "v4f32", "v4f16", "OpDecorate %m2v4f32arr ArrayStride 32\nOpDecorate %m2v4f16arr ArrayStride 16\n", NUM_ELEMENTS // 8, 1),
    ],
]


def int_composites_32_to_16(scalar_stride, vector_stride):
    sc = (4, 2) if scalar_stride == 1 else (16, 2)
    ve = (8, 4) if vector_stride == 2 else (16, 4)
    return [
        ("scalar_sint", SINT_TYPES_32_TO_16, "i32", "i16", "OpSConvert", f"OpDecorate %i32arr ArrayStride {sc[0]}\nOpDecorate %i16arr ArrayStride {sc[1]}\n", NUM_ELEMENTS, scalar_stride),
        ("scalar_uint", UINT_TYPES_32_TO_16, "u32", "u16", "OpUConvert", f"OpDecorate %u32arr ArrayStride {sc[0]}\nOpDecorate %u16arr ArrayStride {sc[1]}\n", NUM_ELEMENTS, scalar_stride),
        ("vector_sint", SINT_TYPES_32_TO_16, "v2i32", "v2i16", "OpSConvert", f"OpDecorate %v2i32arr ArrayStride {ve[0]}\nOpDecorate %v2i16arr ArrayStride {ve[1]}\n", NUM_ELEMENTS // 2, vector_stride),
        ("vector_uint", UINT_TYPES_32_TO_16, "v2u32", "v2u16", "OpUConvert", f"OpDecorate %v2u32arr ArrayStride {ve[0]}\nOpDecorate %v2u16arr ArrayStride {ve[1]}\n", NUM_ELEMENTS // 2, vector_stride),
    ]


INT_COMPOSITES_32_TO_16 = [int_composites_32_to_16(1, 2), int_composites_32_to_16(4, 4)]


def uniform_32_to_16_cases():
    skip = 0
    for cap_index, (cap_name, capability, decor) in enumerate(CAPABILITIES):
        for name, base32, base16, stride, count, input_stride in FLOAT_COMPOSITES_32_TO_16[cap_index]:
            for mode_name, mode_decor, flags in ROUNDING_MODES:
                values = {
                    "capability": capability, "storage": decor, "stride": stride, "base32": base32, "base16": base16, "rounding": mode_decor, "types": FLOAT_TYPES_32_TO_16,
                    "convert": "OpFConvert", "index0": "", "matrix_prefix": "", "matrix_types": "", "matrix_decor": "", "matrix_store": "",
                }
                if name == "matrix":
                    if mode_name == "rtz":
                        values["rounding"] += "\nOpDecorate %val16_1  FPRoundingMode RTZ\n"
                    elif mode_name == "rte":
                        values["rounding"] += "\nOpDecorate %val16_1  FPRoundingMode RTE\n"
                    values.update({
                        "index0": "%zero", "matrix_prefix": "m2",
                        "matrix_types": "%m2v4f16 = OpTypeMatrix %v4f16 2\n%m2v4f32 = OpTypeMatrix %v4f32 2\n%m2v4f16arr = OpTypeArray %m2v4f16 %c_i32_16\n%m2v4f32arr = OpTypeArray %m2v4f32 %c_i32_16\n",
                        "matrix_decor": "OpMemberDecorate %SSBO32 0 ColMajor\nOpMemberDecorate %SSBO32 0 MatrixStride 16\nOpMemberDecorate %SSBO16 0 ColMajor\nOpMemberDecorate %SSBO16 0 MatrixStride 8\n",
                        "matrix_store": "%inloc_1  = OpAccessChain %v4f32ptr %ssbo32 %zero %x %c_i32_1\n%val32_1  = OpLoad %v4f32 %inloc_1\n%val16_1  = OpFConvert %v4f16 %val32_1\n"
                        "%outloc_1 = OpAccessChain %v4f16ptr %ssbo16 %zero %x %c_i32_1\n            OpStore %outloc_1 %val16_1\n",
                    })
                spec = f"group=u32to16;skip={skip};cap={cap_index};kind=float;count={count};stride={input_stride};mode={flags}"
                yield f"16bit_storage/uniform_32_to_16/{cap_name}_{name}_float_{mode_name}", spec, specialize(UNIFORM_32_TO_16_TEMPLATE, values)
                skip += NUM_ELEMENTS * input_stride - 24
    for cap_index, (cap_name, capability, decor) in enumerate(CAPABILITIES):
        for name, types, base32, base16, opcode, stride, count, input_stride in INT_COMPOSITES_32_TO_16[cap_index]:
            values = {
                "capability": capability, "storage": decor, "stride": stride, "base32": base32, "base16": base16, "rounding": "", "types": types, "convert": opcode,
                "index0": "", "matrix_prefix": "", "matrix_types": "", "matrix_decor": "", "matrix_store": "",
            }
            spec = f"group=u32to16;skip={skip};cap={cap_index};kind=int;count={count};stride={input_stride};mode=0"
            yield f"16bit_storage/uniform_32_to_16/{cap_name}_{name}", spec, specialize(UNIFORM_32_TO_16_TEMPLATE, values)
            skip += NUM_ELEMENTS * input_stride - 16



UNIFORM_64_TO_16_TEMPLATE = (
    "OpCapability Shader\n"
    "OpCapability ${capability}\n"
    "OpCapability Float64\n"
    'OpExtension "SPV_KHR_16bit_storage"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "${stride}"
    "OpMemberDecorate %SSBO64 0 Offset 0\n"
    "OpMemberDecorate %SSBO16 0 Offset 0\n"
    "OpDecorate %SSBO64 ${storage}\n"
    "OpDecorate %SSBO16 BufferBlock\n"
    "OpDecorate %ssbo64 DescriptorSet 0\n"
    "OpDecorate %ssbo16 DescriptorSet 0\n"
    "OpDecorate %ssbo64 Binding 0\n"
    "OpDecorate %ssbo16 Binding 1\n"
    "${matrix_decor}\n"
    "${rounding}\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%f32       = OpTypeFloat 32\n"
    "%f64       = OpTypeFloat 64\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%i32ptr    = OpTypePointer Uniform %i32\n"
    "%f64ptr    = OpTypePointer Uniform %f64\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%c_i32_128 = OpConstant %i32 128\n"
    "%i32arr    = OpTypeArray %i32 %c_i32_128\n"
    "%f64arr    = OpTypeArray %f64 %c_i32_128\n"
    "${types}\n"
    "${matrix_types}\n"
    "%SSBO64    = OpTypeStruct %${matrix_prefix}${base64}arr\n"
    "%SSBO16    = OpTypeStruct %${matrix_prefix}${base16}arr\n"
    "%up_SSBO64 = OpTypePointer Uniform %SSBO64\n"
    "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
    "%ssbo64    = OpVariable %up_SSBO64 Uniform\n"
    "%ssbo16    = OpVariable %up_SSBO16 Uniform\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base64}ptr %ssbo64 %zero %x ${index0}\n"
    "%val64     = OpLoad %${base64} %inloc\n"
    "%val16     = ${convert} %${base16} %val64\n"
    "%outloc    = OpAccessChain %${base16}ptr %ssbo16 %zero %x ${index0}\n"
    "             OpStore %outloc %val16\n"
    "${matrix_store}\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

FLOAT_TYPES_64_TO_16 = FLOAT_TYPES_32_TO_16.replace("v4f32", "v4f64")

# (name, base64, base16, stride string, count, UBO stride, UBO padding, SSBO stride)
FLOAT_COMPOSITES_64_TO_16 = [
    ("scalar", "f64", "f16", "OpDecorate %f16arr ArrayStride 2\nOpDecorate %f64arr ArrayStride ", NUM_ELEMENTS, "16", 8, "8"),
    ("vector", "v4f64", "v4f16", "OpDecorate %v4f16arr ArrayStride 8\nOpDecorate %v4f64arr ArrayStride ", NUM_ELEMENTS // 4, "32", 0, "32"),
    ("matrix", "v4f64", "v4f16", "OpDecorate %m2v4f16arr ArrayStride 16\nOpDecorate %m2v4f64arr ArrayStride ", NUM_ELEMENTS // 8, "64", 0, "64"),
]


def uniform_64_to_16_cases():
    for cap_index, (cap_name, capability, decor) in enumerate(CAPABILITIES):
        for name, base64, base16, stride, count, ubo_stride, ubo_padding, ssbo_stride in FLOAT_COMPOSITES_64_TO_16:
            for mode_name, mode_decor, flags in ROUNDING_MODES:
                is_ubo = cap_index == 1
                values = {
                    "capability": capability, "storage": decor, "stride": stride + (ubo_stride if is_ubo else ssbo_stride) + "\n", "base64": base64, "base16": base16,
                    "rounding": mode_decor, "types": FLOAT_TYPES_64_TO_16, "convert": "OpFConvert", "index0": "", "matrix_prefix": "", "matrix_types": "",
                    "matrix_decor": "", "matrix_store": "",
                }
                if name == "matrix":
                    if mode_name == "rtz":
                        values["rounding"] += "\nOpDecorate %val16_1  FPRoundingMode RTZ\n"
                    elif mode_name == "rte":
                        values["rounding"] += "\nOpDecorate %val16_1  FPRoundingMode RTE\n"
                    values.update({
                        "index0": "%zero", "matrix_prefix": "m2",
                        "matrix_types": "%m2v4f16 = OpTypeMatrix %v4f16 2\n%m2v4f64 = OpTypeMatrix %v4f64 2\n%m2v4f16arr = OpTypeArray %m2v4f16 %c_i32_16\n%m2v4f64arr = OpTypeArray %m2v4f64 %c_i32_16\n",
                        "matrix_decor": "OpMemberDecorate %SSBO64 0 ColMajor\nOpMemberDecorate %SSBO64 0 MatrixStride 32\nOpMemberDecorate %SSBO16 0 ColMajor\nOpMemberDecorate %SSBO16 0 MatrixStride 8\n",
                        "matrix_store": "%inloc_1  = OpAccessChain %v4f64ptr %ssbo64 %zero %x %c_i32_1\n%val64_1  = OpLoad %v4f64 %inloc_1\n%val16_1  = OpFConvert %v4f16 %val64_1\n"
                        "%outloc_1 = OpAccessChain %v4f16ptr %ssbo16 %zero %x %c_i32_1\n            OpStore %outloc_1 %val16_1\n",
                    })
                padding = ubo_padding if is_ubo else 0
                spec = f"group=u64to16;cap={cap_index};count={count};padding={padding};mode={flags}"
                yield f"16bit_storage/uniform_64_to_16/{cap_name}_{name}_float_{mode_name}", spec, specialize(UNIFORM_64_TO_16_TEMPLATE, values)


UNIFORM_16_TO_64_TEMPLATE = (
    "OpCapability Shader\n"
    "OpCapability Float64\n"
    "OpCapability ${capability}\n"
    'OpExtension "SPV_KHR_16bit_storage"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "${stride}\n"
    "OpMemberDecorate %SSBO64 0 Offset 0\n"
    "OpMemberDecorate %SSBO16 0 Offset 0\n"
    "OpDecorate %SSBO64 BufferBlock\n"
    "OpDecorate %SSBO16 ${storage}\n"
    "OpDecorate %ssbo64 DescriptorSet 0\n"
    "OpDecorate %ssbo16 DescriptorSet 0\n"
    "OpDecorate %ssbo64 Binding 1\n"
    "OpDecorate %ssbo16 Binding 0\n"
    "${matrix_decor}\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%f64       = OpTypeFloat 64\n"
    "%v3u32     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %v3u32\n"
    "%i32ptr    = OpTypePointer Uniform %i32\n"
    "%f64ptr    = OpTypePointer Uniform %f64\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_2   = OpConstant %i32 2\n"
    "%c_i32_3   = OpConstant %i32 3\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%c_i32_128 = OpConstant %i32 128\n"
    "%c_i32_ci  = OpConstant %i32 ${constarrayidx}\n"
    "%i32arr    = OpTypeArray %i32 %c_i32_128\n"
    "%f64arr    = OpTypeArray %f64 %c_i32_128\n"
    "${types}\n"
    "${matrix_types}\n"
    "%SSBO64    = OpTypeStruct %${matrix_prefix}${base64}arr\n"
    "%SSBO16    = OpTypeStruct %${matrix_prefix}${base16}arr\n"
    "%up_SSBO64 = OpTypePointer Uniform %SSBO64\n"
    "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
    "%ssbo64    = OpVariable %up_SSBO64 Uniform\n"
    "%ssbo16    = OpVariable %up_SSBO16 Uniform\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %v3u32 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base16}ptr %ssbo16 %zero %${arrayindex} ${index0}\n"
    "%val16     = OpLoad %${base16} %inloc\n"
    "%val64     = ${convert} %${base64} %val16\n"
    "%outloc    = OpAccessChain %${base64}ptr %ssbo64 %zero %x ${index0}\n"
    "             OpStore %outloc %val64\n"
    "${matrix_store}\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

FLOAT_TYPES_16_TO_64 = (
    "%f16       = OpTypeFloat 16\n"
    "%f16ptr    = OpTypePointer Uniform %f16\n"
    "%f16arr    = OpTypeArray %f16 %c_i32_128\n"
    "%v2f16     = OpTypeVector %f16 2\n"
    "%v2f64     = OpTypeVector %f64 2\n"
    "%v2f16ptr  = OpTypePointer Uniform %v2f16\n"
    "%v2f64ptr  = OpTypePointer Uniform %v2f64\n"
    "%v2f16arr  = OpTypeArray %v2f16 %c_i32_64\n"
    "%v2f64arr  = OpTypeArray %v2f64 %c_i32_64\n"
)

MATRIX_STORE_16_TO_64 = "".join(
    f"%inloc_{i}  = OpAccessChain %v2f16ptr %ssbo16 %zero %x %c_i32_{i}\n%val16_{i}  = OpLoad %v2f16 %inloc_{i}\n%val64_{i}  = OpFConvert %v2f64 %val16_{i}\n"
    f"%outloc_{i} = OpAccessChain %v2f64ptr %ssbo64 %zero %x %c_i32_{i}\n            OpStore %outloc_{i} %val64_{i}\n"
    for i in (1, 2, 3)
)

# (name, base64, base16, stride string, UBO stride, UBO padding, SSBO stride, constant index, count, data kind)
FLOAT_COMPOSITES_16_TO_64 = [
    ("scalar", "f64", "f16", "OpDecorate %f64arr ArrayStride 8\nOpDecorate %f16arr ArrayStride ", "16", 14, "2", -1, NUM_ELEMENTS, "scalar"),
    ("scalar_const_idx_5", "f64", "f16", "OpDecorate %f64arr ArrayStride 8\nOpDecorate %f16arr ArrayStride ", "16", 14, "2", 5, NUM_ELEMENTS, "scalar"),
    ("scalar_const_idx_8", "f64", "f16", "OpDecorate %f64arr ArrayStride 8\nOpDecorate %f16arr ArrayStride ", "16", 14, "2", 8, NUM_ELEMENTS, "scalar"),
    ("vector", "v2f64", "v2f16", "OpDecorate %v2f64arr ArrayStride 16\nOpDecorate %v2f16arr ArrayStride ", "16", 12, "4", -1, NUM_ELEMENTS // 2, "vec2"),
    ("matrix", "v2f64", "v2f16", "OpDecorate %m4v2f64arr ArrayStride 64\nOpDecorate %m4v2f16arr ArrayStride ", "64", 0, "64", -1, NUM_ELEMENTS // 8, "mat"),
]


def uniform_16_to_64_cases():
    for cap_index, (cap_name, capability, decor) in enumerate(CAPABILITIES):
        for name, base64, base16, stride, ubo_stride, ubo_padding, ssbo_stride, constant, count, kind in FLOAT_COMPOSITES_16_TO_64:
            is_ubo = cap_index == 1
            values = {
                "capability": capability, "storage": decor, "stride": stride + (ubo_stride if is_ubo else ssbo_stride), "base64": base64, "base16": base16,
                "types": FLOAT_TYPES_16_TO_64, "convert": "OpFConvert", "constarrayidx": str(max(constant, 0)), "arrayindex": "c_i32_ci" if constant >= 0 else "x",
                "index0": "", "matrix_prefix": "", "matrix_types": "", "matrix_decor": "", "matrix_store": "",
            }
            if kind == "mat":
                values.update({
                    "index0": "%zero", "matrix_prefix": "m4",
                    "matrix_types": "%m4v2f16 = OpTypeMatrix %v2f16 4\n%m4v2f64 = OpTypeMatrix %v2f64 4\n%m4v2f16arr = OpTypeArray %m4v2f16 %c_i32_16\n%m4v2f64arr = OpTypeArray %m4v2f64 %c_i32_16\n",
                    "matrix_decor": "OpMemberDecorate %SSBO64 0 ColMajor\nOpMemberDecorate %SSBO64 0 MatrixStride 16\nOpMemberDecorate %SSBO16 0 ColMajor\nOpMemberDecorate %SSBO16 0 MatrixStride 16\n",
                    "matrix_store": MATRIX_STORE_16_TO_64,
                })
            padding = ubo_padding if is_ubo else 0
            spec = f"group=u16to64;cap={cap_index};count={count};padding={padding};const={constant};kind={kind}"
            yield f"16bit_storage/uniform_16_to_64/{cap_name}_{name}_float", spec, specialize(UNIFORM_16_TO_64_TEMPLATE, values)


PUSH_CONSTANT_TEMPLATE = (
    "OpCapability Shader\n"
    "OpCapability StoragePushConstant16\n"
    "${float64_capability}"
    'OpExtension "SPV_KHR_16bit_storage"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "${stride}"
    "OpDecorate %PC16 Block\n"
    "OpMemberDecorate %PC16 0 Offset 0\n"
    "OpMemberDecorate %SSBO${wide} 0 Offset 0\n"
    "OpDecorate %SSBO${wide} BufferBlock\n"
    "OpDecorate %ssbo${wide} DescriptorSet 0\n"
    "OpDecorate %ssbo${wide} Binding 0\n"
    "${matrix_decor}\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%f32       = OpTypeFloat 32\n"
    "%v3u32     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %v3u32\n"
    "%i32ptr    = OpTypePointer Uniform %i32\n"
    "%f32ptr    = OpTypePointer Uniform %f32\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_8   = OpConstant %i32 8\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "${constant_index}"
    "%i32arr    = OpTypeArray %i32 %c_i32_64\n"
    "%f32arr    = OpTypeArray %f32 %c_i32_64\n"
    "${types}\n"
    "${matrix_types}\n"
    "%PC16      = OpTypeStruct %${matrix_prefix}${base16}arr\n"
    "%pp_PC16   = OpTypePointer PushConstant %PC16\n"
    "%pc16      = OpVariable %pp_PC16 PushConstant\n"
    "%SSBO${wide}    = OpTypeStruct %${matrix_prefix}${basewide}arr\n"
    "%up_SSBO${wide} = OpTypePointer Uniform %SSBO${wide}\n"
    "%ssbo${wide}    = OpVariable %up_SSBO${wide} Uniform\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %v3u32 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base16}ptr %pc16 %zero %${arrayindex} ${index0}\n"
    "%val16     = OpLoad %${base16} %inloc\n"
    "%valwide   = ${convert} %${basewide} %val16\n"
    "%outloc    = OpAccessChain %${basewide}ptr %ssbo${wide} %zero %x ${index0}\n"
    "             OpStore %outloc %valwide\n"
    "${matrix_store}\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

PUSH_FLOAT_TYPES_32 = (
    "%f16       = OpTypeFloat 16\n"
    "%f16ptr    = OpTypePointer PushConstant %f16\n"
    "%f16arr    = OpTypeArray %f16 %c_i32_64\n"
    "%v4f16     = OpTypeVector %f16 4\n"
    "%v4f32     = OpTypeVector %f32 4\n"
    "%v4f16ptr  = OpTypePointer PushConstant %v4f16\n"
    "%v4f32ptr  = OpTypePointer Uniform %v4f32\n"
    "%v4f16arr  = OpTypeArray %v4f16 %c_i32_16\n"
    "%v4f32arr  = OpTypeArray %v4f32 %c_i32_16\n"
)
PUSH_FLOAT_TYPES_64 = (
    "%f16       = OpTypeFloat 16\n"
    "%f16ptr    = OpTypePointer PushConstant %f16\n"
    "%f16arr    = OpTypeArray %f16 %c_i32_64\n"
    "%f64       = OpTypeFloat 64\n"
    "%f64ptr    = OpTypePointer Uniform %f64\n"
    "%f64arr    = OpTypeArray %f64 %c_i32_64\n"
    "%v4f16     = OpTypeVector %f16 4\n"
    "%v4f32     = OpTypeVector %f32 4\n"
    "%v4f64     = OpTypeVector %f64 4\n"
    "%v4f16ptr  = OpTypePointer PushConstant %v4f16\n"
    "%v4f32ptr  = OpTypePointer Uniform %v4f32\n"
    "%v4f64ptr  = OpTypePointer Uniform %v4f64\n"
    "%v4f16arr  = OpTypeArray %v4f16 %c_i32_16\n"
    "%v4f32arr  = OpTypeArray %v4f32 %c_i32_16\n"
    "%v4f64arr  = OpTypeArray %v4f64 %c_i32_16\n"
)
PUSH_SINT_TYPES = (
    "%i16       = OpTypeInt 16 1\n"
    "%i16ptr    = OpTypePointer PushConstant %i16\n"
    "%i16arr    = OpTypeArray %i16 %c_i32_64\n"
    "%v2i16     = OpTypeVector %i16 2\n"
    "%v2i32     = OpTypeVector %i32 2\n"
    "%v2i16ptr  = OpTypePointer PushConstant %v2i16\n"
    "%v2i32ptr  = OpTypePointer Uniform %v2i32\n"
    "%v2i16arr  = OpTypeArray %v2i16 %c_i32_32\n"
    "%v2i32arr  = OpTypeArray %v2i32 %c_i32_32\n"
)
PUSH_UINT_TYPES = (
    "%u16       = OpTypeInt 16 0\n"
    "%u16ptr    = OpTypePointer PushConstant %u16\n"
    "%u32ptr    = OpTypePointer Uniform %u32\n"
    "%u16arr    = OpTypeArray %u16 %c_i32_64\n"
    "%u32arr    = OpTypeArray %u32 %c_i32_64\n"
    "%v2u16     = OpTypeVector %u16 2\n"
    "%v2u32     = OpTypeVector %u32 2\n"
    "%v2u16ptr  = OpTypePointer PushConstant %v2u16\n"
    "%v2u32ptr  = OpTypePointer Uniform %v2u32\n"
    "%v2u16arr  = OpTypeArray %v2u16 %c_i32_32\n"
    "%v2u32arr  = OpTypeArray %v2u32 %c_i32_32\n"
)

PUSH_MATRIX_32 = {
    "matrix_prefix": "m2",
    "index0": "%zero",
    "matrix_types": "%m2v4f16 = OpTypeMatrix %v4f16 2\n%m2v4f32 = OpTypeMatrix %v4f32 2\n%m2v4f16arr = OpTypeArray %m2v4f16 %c_i32_8\n%m2v4f32arr = OpTypeArray %m2v4f32 %c_i32_8\n",
    "matrix_decor": "OpMemberDecorate %SSBO32 0 ColMajor\nOpMemberDecorate %SSBO32 0 MatrixStride 16\nOpMemberDecorate %PC16 0 ColMajor\nOpMemberDecorate %PC16 0 MatrixStride 8\n",
    "matrix_store": "%inloc_1  = OpAccessChain %v4f16ptr %pc16 %zero %x %c_i32_1\n%val16_1  = OpLoad %v4f16 %inloc_1\n%val32_1  = OpFConvert %v4f32 %val16_1\n"
    "%outloc_1 = OpAccessChain %v4f32ptr %ssbo32 %zero %x %c_i32_1\n            OpStore %outloc_1 %val32_1\n",
}
PUSH_MATRIX_64 = {
    "matrix_prefix": "m2",
    "index0": "%zero",
    "matrix_types": "%m2v4f16 = OpTypeMatrix %v4f16 2\n%m2v4f64 = OpTypeMatrix %v4f64 2\n%m2v4f16arr = OpTypeArray %m2v4f16 %c_i32_8\n%m2v4f64arr = OpTypeArray %m2v4f64 %c_i32_8\n",
    "matrix_decor": "OpMemberDecorate %SSBO64 0 ColMajor\nOpMemberDecorate %SSBO64 0 MatrixStride 32\nOpMemberDecorate %PC16 0 ColMajor\nOpMemberDecorate %PC16 0 MatrixStride 8\n",
    "matrix_store": "%inloc_1  = OpAccessChain %v4f16ptr %pc16 %zero %x %c_i32_1\n%val16_1  = OpLoad %v4f16 %inloc_1\n%val64_1  = OpFConvert %v4f64 %val16_1\n"
    "%outloc_1 = OpAccessChain %v4f64ptr %ssbo64 %zero %x %c_i32_1\n            OpStore %outloc_1 %val64_1\n",
}


def push_constant_values(wide, basewide, base16, stride, types, convert, constant, arrayindex_default="x"):
    return {
        "float64_capability": "OpCapability Float64\n" if wide == "64" else "", "wide": wide, "basewide": basewide, "base16": base16, "stride": stride, "types": types,
        "convert": convert, "constant_index": f"%c_i32_ci  = OpConstant %i32 {constant}\n" if constant >= 0 else "", "arrayindex": "c_i32_ci" if constant >= 0 else "x",
        "index0": "", "matrix_prefix": "", "matrix_types": "", "matrix_decor": "", "matrix_store": "",
    }


def push_constant_cases():
    # (name, kind, base32, base16, opcode, types, stride, constant index, count)
    f32_scalar = "OpDecorate %f32arr ArrayStride 4\nOpDecorate %f16arr ArrayStride 2\n"
    float_cases = [
        ("scalar_float", "f32", "f16", f32_scalar, -1, 64, False),
        ("scalar_const_idx_5_float", "f32", "f16", f32_scalar, 5, 64, False),
        ("scalar_const_idx_8_float", "f32", "f16", f32_scalar, 8, 64, False),
        ("vector_float", "v4f32", "v4f16", "OpDecorate %v4f32arr ArrayStride 16\nOpDecorate %v4f16arr ArrayStride 8\n", -1, 16, False),
        ("matrix_float", "v4f32", "v4f16", "OpDecorate %m2v4f32arr ArrayStride 32\nOpDecorate %m2v4f16arr ArrayStride 16\n", -1, 8, True),
    ]
    for name, base32, base16, stride, constant, count, matrix in float_cases:
        values = push_constant_values("32", base32, base16, stride, PUSH_FLOAT_TYPES_32, "OpFConvert", constant)
        if matrix:
            values.update(PUSH_MATRIX_32)
        spec = f"group=push16to32;kind=float;count={count};const={constant};signed=0"
        yield f"16bit_storage/push_constant_16_to_32/{name}", spec, specialize(PUSH_CONSTANT_TEMPLATE, values)
    int_cases = [
        ("scalar_sint", True, PUSH_SINT_TYPES, "i32", "i16", "OpSConvert", "OpDecorate %i32arr ArrayStride 4\nOpDecorate %i16arr ArrayStride 2\n", -1, 64),
        ("scalar_sint_const_idx_5", True, PUSH_SINT_TYPES, "i32", "i16", "OpSConvert", "OpDecorate %i32arr ArrayStride 4\nOpDecorate %i16arr ArrayStride 2\n", 5, 64),
        ("scalar_sint_const_idx_8", True, PUSH_SINT_TYPES, "i32", "i16", "OpSConvert", "OpDecorate %i32arr ArrayStride 4\nOpDecorate %i16arr ArrayStride 2\n", 8, 64),
        ("scalar_uint", False, PUSH_UINT_TYPES, "u32", "u16", "OpUConvert", "OpDecorate %u32arr ArrayStride 4\nOpDecorate %u16arr ArrayStride 2\n", -1, 64),
        ("scalar_uint_const_idx_5", False, PUSH_UINT_TYPES, "u32", "u16", "OpUConvert", "OpDecorate %u32arr ArrayStride 4\nOpDecorate %u16arr ArrayStride 2\n", 5, 64),
        ("scalar_uint_const_idx_8", False, PUSH_UINT_TYPES, "u32", "u16", "OpUConvert", "OpDecorate %u32arr ArrayStride 4\nOpDecorate %u16arr ArrayStride 2\n", 8, 64),
        ("vector_sint", True, PUSH_SINT_TYPES, "v2i32", "v2i16", "OpSConvert", "OpDecorate %v2i32arr ArrayStride 8\nOpDecorate %v2i16arr ArrayStride 4\n", -1, 32),
        ("vector_uint", False, PUSH_UINT_TYPES, "v2u32", "v2u16", "OpUConvert", "OpDecorate %v2u32arr ArrayStride 8\nOpDecorate %v2u16arr ArrayStride 4\n", -1, 32),
    ]
    for name, is_signed, types, base32, base16, opcode, stride, constant, count in int_cases:
        values = push_constant_values("32", base32, base16, stride, types, opcode, constant)
        spec = f"group=push16to32;kind=int;count={count};const={constant};signed={int(is_signed)}"
        yield f"16bit_storage/push_constant_16_to_32/{name}", spec, specialize(PUSH_CONSTANT_TEMPLATE, values)
    float64_cases = [
        ("scalar_float", "f64", "f16", "OpDecorate %f64arr ArrayStride 8\nOpDecorate %f16arr ArrayStride 2\n", 64, False),
        ("vector_float", "v4f64", "v4f16", "OpDecorate %v4f64arr ArrayStride 32\nOpDecorate %v4f16arr ArrayStride 8\n", 16, False),
        ("matrix_float", "v4f64", "v4f16", "OpDecorate %m2v4f64arr ArrayStride 64\nOpDecorate %m2v4f16arr ArrayStride 16\n", 8, True),
    ]
    for name, base64, base16, stride, count, matrix in float64_cases:
        values = push_constant_values("64", base64, base16, stride, PUSH_FLOAT_TYPES_64, "OpFConvert", -1)
        if matrix:
            values.update(PUSH_MATRIX_64)
        spec = f"group=push16to64;kind=float;count={count};const=-1;signed=0"
        yield f"16bit_storage/push_constant_16_to_64/{name}", spec, specialize(PUSH_CONSTANT_TEMPLATE, values)




STRESS_16_TO_16 = (
    "OpCapability Shader\n"
    "OpCapability StorageUniformBufferBlock16\n"
    'OpExtension "SPV_KHR_16bit_storage"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "OpDecorate %f16arr ArrayStride 2\n"
    "OpMemberDecorate %SSBO_IN 0 Coherent\n"
    "OpMemberDecorate %SSBO_OUT 0 Coherent\n"
    "OpMemberDecorate %SSBO_IN 0 Offset 0\n"
    "OpMemberDecorate %SSBO_OUT 0 Offset 0\n"
    "OpDecorate %SSBO_IN BufferBlock\n"
    "OpDecorate %SSBO_OUT BufferBlock\n"
    "OpDecorate %ssboIN DescriptorSet 0\n"
    "OpDecorate %ssboOUT DescriptorSet 0\n"
    "OpDecorate %ssboIN Binding 0\n"
    "OpDecorate %ssboOUT Binding 1\n"
    "\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%f16       = OpTypeFloat 16\n"
    "%f16ptr    = OpTypePointer Uniform %f16\n"
    "\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_size    = OpConstant %i32 128\n"
    "\n"
    "%f16arr    = OpTypeArray %f16 %c_size\n"
    "%SSBO_IN   = OpTypeStruct %f16arr\n"
    "%SSBO_OUT  = OpTypeStruct %f16arr\n"
    "%up_SSBOIN = OpTypePointer Uniform %SSBO_IN\n"
    "%up_SSBOOUT = OpTypePointer Uniform %SSBO_OUT\n"
    "%ssboIN    = OpVariable %up_SSBOIN Uniform\n"
    "%ssboOUT   = OpVariable %up_SSBOOUT Uniform\n"
    "\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%y         = OpCompositeExtract %u32 %idval 1\n"
    "\n"
    "%inlocx     = OpAccessChain %f16ptr %ssboIN %zero %x \n"
    "%valx       = OpLoad %f16 %inlocx\n"
    "%outlocx    = OpAccessChain %f16ptr %ssboOUT %zero %x \n"
    "             OpStore %outlocx %valx\n"
    "%inlocy    = OpAccessChain %f16ptr %ssboIN %zero %y \n"
    "%valy      = OpLoad %f16 %inlocy\n"
    "%outlocy   = OpAccessChain %f16ptr %ssboOUT %zero %y \n"
    "             OpStore %outlocy %valy\n"
    "\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)


def stress_cases():
    yield "16bit_storage/uniform_16_to_16/stress_test", "group=stress16", STRESS_16_TO_16


def main():
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.16bit_storage.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_16bit_storage_manifest.py - do not hand-edit; `spec` says which value of which data the host expects.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/storage16_tests"\n'
    ]
    count = 0
    for name, spec, assembly in list(uniform_16_to_32_cases()) + list(uniform_32_to_16_cases()) + list(uniform_64_to_16_cases()) + list(uniform_16_to_64_cases()) + list(push_constant_cases()) + list(stress_cases()) + list(chain_access_cases()):
        const = "S16_" + "".join(c if c.isalnum() else "_" for c in name).upper()
        out.append(
            f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "Storage16Case"\n'
            f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
            f"derived = {{ source = {json.dumps(repr(assembly))} }}\n"
        )
        count += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()

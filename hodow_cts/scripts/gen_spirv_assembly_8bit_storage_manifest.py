#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_8bit_storage.toml: the compute cases of dEQP-VK.spirv_assembly.instruction.compute.8bit_storage that are one template over four
composite types - `storagebuffer_32_to_8`, `uniform_8_to_32`, `push_constant_8_to_32`, `storagebuffer_16_to_8`, `uniform_8_to_16` and `push_constant_8_to_16` (24 cases) - and the
`uniform_8_to_8` stress test of vktSpvAsm8bitStorageTests.cpp.

The assembly is the template of the C++ filled with the types; what the host needs to draw the data and pick the expected value rides along as `spec` for
src/vkt/tests/spirv_assembly/storage8_tests.rs.

    python3 hodow_cts/scripts/gen_spirv_assembly_8bit_storage_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_8bit_storage.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsm8bitStorageTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"
NUM_ELEMENTS = 128


def specialize(template, values):
    for key, value in values.items():
        template = template.replace("${" + key + "}", value)
    assert "${" not in template, template
    return template


HEAD = (
    "OpCapability Shader\n"
    "OpCapability ${capability}\n"
    "${capability16}"
    'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
    'OpExtension "SPV_KHR_8bit_storage"\n'
    "${extension16}"
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "${stride}"
)

STORAGE_32_TO_8 = HEAD + (
    "OpDecorate %SSBO32 Block\n"
    "OpDecorate %SSBO8 Block\n"
    "OpMemberDecorate %SSBO32 0 Offset 0\n"
    "OpMemberDecorate %SSBO8 0 Offset 0\n"
    "OpDecorate %ssbo32 DescriptorSet 0\n"
    "OpDecorate %ssbo8 DescriptorSet 0\n"
    "OpDecorate %ssbo32 Binding 0\n"
    "OpDecorate %ssbo8 Binding 1\n"
    "\n\n\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%f32       = OpTypeFloat 32\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%fvec3     = OpTypeVector %f32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%i32ptr    = OpTypePointer StorageBuffer %i32\n"
    "%f32ptr    = OpTypePointer StorageBuffer %f32\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%c_i32_128 = OpConstant %i32 128\n"
    "%i32arr    = OpTypeArray %i32 %c_i32_128\n"
    "%f32arr    = OpTypeArray %f32 %c_i32_128\n"
    "${types}\n"
    "\n"
    "%SSBO32    = OpTypeStruct %${base32}arr\n"
    "%SSBO8    = OpTypeStruct %${base8}arr\n"
    "%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32\n"
    "%up_SSBO8 = OpTypePointer StorageBuffer %SSBO8\n"
    "%ssbo32    = OpVariable %up_SSBO32 StorageBuffer\n"
    "%ssbo8    = OpVariable %up_SSBO8 StorageBuffer\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base32}ptr %ssbo32 %zero %x \n"
    "%val32     = OpLoad %${base32} %inloc\n"
    "%val8     = ${convert} %${base8} %val32\n"
    "%outloc    = OpAccessChain %${base8}ptr %ssbo8 %zero %x \n"
    "             OpStore %outloc %val8\n"
    "\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

UNIFORM_8_TO_32 = HEAD + (
    "OpDecorate %SSBO32 Block\n"
    "OpDecorate %SSBO8 Block\n"
    "OpMemberDecorate %SSBO32 0 Offset 0\n"
    "OpMemberDecorate %SSBO8 0 Offset 0\n"
    "OpDecorate %ssbo32 DescriptorSet 0\n"
    "OpDecorate %ssbo8 DescriptorSet 0\n"
    "OpDecorate %ssbo32 Binding 1\n"
    "OpDecorate %ssbo8 Binding 0\n"
    "\n\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%i32ptr    = OpTypePointer StorageBuffer %i32\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_2   = OpConstant %i32 2\n"
    "%c_i32_3   = OpConstant %i32 3\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%c_i32_128 = OpConstant %i32 128\n"
    "%i32arr    = OpTypeArray %i32 %c_i32_128\n"
    "${types}\n"
    "\n"
    "%SSBO32    = OpTypeStruct %${base32}arr\n"
    "%SSBO8    = OpTypeStruct %${base8}arr\n"
    "%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32\n"
    "%up_SSBO8 = OpTypePointer Uniform %SSBO8\n"
    "%ssbo32    = OpVariable %up_SSBO32 StorageBuffer\n"
    "%ssbo8    = OpVariable %up_SSBO8 Uniform\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base8}ptr %ssbo8 %zero %x \n"
    "%val8     = OpLoad %${base8} %inloc\n"
    "%val32     = ${convert} %${base32} %val8\n"
    "%outloc    = OpAccessChain %${base32}ptr %ssbo32 %zero %x \n"
    "             OpStore %outloc %val32\n"
    "\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

PUSH_8_TO_32 = HEAD + (
    "OpDecorate %PC8 Block\n"
    "OpDecorate %SSBO32 Block\n"
    "OpMemberDecorate %PC8 0 Offset 0\n"
    "OpMemberDecorate %SSBO32 0 Offset 0\n"
    "OpDecorate %ssbo32 DescriptorSet 0\n"
    "OpDecorate %ssbo32 Binding 0\n"
    "\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%u32       = OpTypeInt 32 0\n"
    "%i32       = OpTypeInt 32 1\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%i32ptr    = OpTypePointer StorageBuffer %i32\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_8   = OpConstant %i32 8\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%i32arr    = OpTypeArray %i32 %c_i32_64\n"
    "${types}\n"
    "\n"
    "%PC8      = OpTypeStruct %${base8}arr\n"
    "%pp_PC8   = OpTypePointer PushConstant %PC8\n"
    "%pc8      = OpVariable %pp_PC8 PushConstant\n"
    "%SSBO32    = OpTypeStruct %${base32}arr\n"
    "%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32\n"
    "%ssbo32    = OpVariable %up_SSBO32 StorageBuffer\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base8}ptr %pc8 %zero %x \n"
    "%val8     = OpLoad %${base8} %inloc\n"
    "%val32     = ${convert} %${base32} %val8\n"
    "%outloc    = OpAccessChain %${base32}ptr %ssbo32 %zero %x \n"
    "             OpStore %outloc %val32\n"
    "\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

STORAGE_16_TO_8 = HEAD + (
    "OpDecorate %SSBO16 Block\n"
    "OpDecorate %SSBO8 Block\n"
    "OpMemberDecorate %SSBO16 0 Offset 0\n"
    "OpMemberDecorate %SSBO8 0 Offset 0\n"
    "OpDecorate %ssbo16 DescriptorSet 0\n"
    "OpDecorate %ssbo8 DescriptorSet 0\n"
    "OpDecorate %ssbo16 Binding 0\n"
    "OpDecorate %ssbo8 Binding 1\n"
    "\n\n\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%i32       = OpTypeInt 32 1\n"
    "%u32       = OpTypeInt 32 0\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%c_i32_128 = OpConstant %i32 128\n"
    "${types}\n"
    "\n"
    "%SSBO16    = OpTypeStruct %${base16}arr\n"
    "%SSBO8     = OpTypeStruct %${base8}arr\n"
    "%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16\n"
    "%up_SSBO8  = OpTypePointer StorageBuffer %SSBO8\n"
    "%ssbo16    = OpVariable %up_SSBO16 StorageBuffer\n"
    "%ssbo8     = OpVariable %up_SSBO8 StorageBuffer\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base16}ptr %ssbo16 %zero %x \n"
    "%val16     = OpLoad %${base16} %inloc\n"
    "%val8      = ${convert} %${base8} %val16\n"
    "%outloc    = OpAccessChain %${base8}ptr %ssbo8 %zero %x \n"
    "             OpStore %outloc %val8\n"
    "\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

UNIFORM_8_TO_16 = HEAD + (
    "OpDecorate %SSBO16 Block\n"
    "OpDecorate %SSBO8 Block\n"
    "OpMemberDecorate %SSBO16 0 Offset 0\n"
    "OpMemberDecorate %SSBO8 0 Offset 0\n"
    "OpDecorate %ssbo16 DescriptorSet 0\n"
    "OpDecorate %ssbo8 DescriptorSet 0\n"
    "OpDecorate %ssbo16 Binding 1\n"
    "OpDecorate %ssbo8 Binding 0\n"
    "\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%i32       = OpTypeInt 32 1\n"
    "%u32       = OpTypeInt 32 0\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_2   = OpConstant %i32 2\n"
    "%c_i32_3   = OpConstant %i32 3\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "%c_i32_128 = OpConstant %i32 128\n"
    "${types}\n"
    "\n"
    "%SSBO16    = OpTypeStruct %${base16}arr\n"
    "%SSBO8    = OpTypeStruct %${base8}arr\n"
    "%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16\n"
    "%up_SSBO8 = OpTypePointer Uniform %SSBO8\n"
    "%ssbo16    = OpVariable %up_SSBO16 StorageBuffer\n"
    "%ssbo8    = OpVariable %up_SSBO8 Uniform\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base8}ptr %ssbo8 %zero %x \n"
    "%val8     = OpLoad %${base8} %inloc\n"
    "%val16     = ${convert} %${base16} %val8\n"
    "%outloc    = OpAccessChain %${base16}ptr %ssbo16 %zero %x \n"
    "             OpStore %outloc %val16\n"
    "\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

PUSH_8_TO_16 = (
    "OpCapability Shader\n"
    "OpCapability StorageUniform16\n"
    "OpCapability StoragePushConstant8\n"
    'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
    'OpExtension "SPV_KHR_8bit_storage"\n'
    'OpExtension "SPV_KHR_16bit_storage"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "${stride}"
    "OpDecorate %PC8 Block\n"
    "OpDecorate %SSBO16 Block\n"
    "OpMemberDecorate %PC8 0 Offset 0\n"
    "OpMemberDecorate %SSBO16 0 Offset 0\n"
    "OpDecorate %ssbo16 DescriptorSet 0\n"
    "OpDecorate %ssbo16 Binding 0\n"
    "\n"
    "%bool      = OpTypeBool\n"
    "%void      = OpTypeVoid\n"
    "%voidf     = OpTypeFunction %void\n"
    "%i32       = OpTypeInt 32 1\n"
    "%u32       = OpTypeInt 32 0\n"
    "%uvec3     = OpTypeVector %u32 3\n"
    "%uvec3ptr  = OpTypePointer Input %uvec3\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_i32_1   = OpConstant %i32 1\n"
    "%c_i32_8   = OpConstant %i32 8\n"
    "%c_i32_16  = OpConstant %i32 16\n"
    "%c_i32_32  = OpConstant %i32 32\n"
    "%c_i32_64  = OpConstant %i32 64\n"
    "${types}\n"
    "\n"
    "%PC8       = OpTypeStruct %${base8}arr\n"
    "%pp_PC8    = OpTypePointer PushConstant %PC8\n"
    "%pc8       = OpVariable %pp_PC8 PushConstant\n"
    "%SSBO16    = OpTypeStruct %${base16}arr\n"
    "%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16\n"
    "%ssbo16    = OpVariable %up_SSBO16 StorageBuffer\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %${base8}ptr %pc8 %zero %x \n"
    "%val8      = OpLoad %${base8} %inloc\n"
    "%val16     = ${convert} %${base16} %val8\n"
    "%outloc    = OpAccessChain %${base16}ptr %ssbo16 %zero %x \n"
    "             OpStore %outloc %val16\n"
    "\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

STRESS_8_TO_8 = (
    "OpCapability Shader\n"
    "OpCapability StorageBuffer8BitAccess \n"
    'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
    'OpExtension "SPV_KHR_8bit_storage"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "OpDecorate %i8arr ArrayStride 1\n"
    "OpDecorate %SSBO_IN Block\n"
    "OpDecorate %SSBO_OUT Block\n"
    "OpMemberDecorate %SSBO_IN 0 Coherent\n"
    "OpMemberDecorate %SSBO_OUT 0 Coherent\n"
    "OpMemberDecorate %SSBO_IN 0 Offset 0\n"
    "OpMemberDecorate %SSBO_OUT 0 Offset 0\n"
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
    "%i8        = OpTypeInt 8 1\n"
    "%i8ptr     = OpTypePointer StorageBuffer %i8\n"
    "\n"
    "%zero      = OpConstant %i32 0\n"
    "%c_size    = OpConstant %i32 128\n"
    "\n"
    "%i8arr     = OpTypeArray %i8 %c_size\n"
    "%SSBO_IN   = OpTypeStruct %i8arr\n"
    "%SSBO_OUT  = OpTypeStruct %i8arr\n"
    "%up_SSBOIN = OpTypePointer StorageBuffer %SSBO_IN\n"
    "%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT\n"
    "%ssboIN    = OpVariable %up_SSBOIN StorageBuffer\n"
    "%ssboOUT   = OpVariable %up_SSBOOUT StorageBuffer\n"
    "\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%y         = OpCompositeExtract %u32 %idval 1\n"
    "\n"
    "%inlocx     = OpAccessChain %i8ptr %ssboIN %zero %x \n"
    "%valx       = OpLoad %i8 %inlocx\n"
    "%outlocx    = OpAccessChain %i8ptr %ssboOUT %zero %x \n"
    "             OpStore %outlocx %valx\n"
    "%inlocy    = OpAccessChain %i8ptr %ssboIN %zero %y \n"
    "%valy      = OpLoad %i8 %inlocy\n"
    "%outlocy   = OpAccessChain %i8ptr %ssboOUT %zero %y \n"
    "             OpStore %outlocy %valy\n"
    "\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)


# The `sintTypes`/`uintTypes` literals of each template, as upstream writes them (the names of the pointers and arrays are what the template refers to).
def types_32_to_8(signed):
    k = "i" if signed else "u"
    s = 1 if signed else 0
    out = f"%{k}8       = OpTypeInt 8 {s}\n%{k}8ptr    = OpTypePointer StorageBuffer %{k}8\n"
    if not signed:
        out += "%u32ptr   = OpTypePointer StorageBuffer %u32\n"
    out += f"%{k}8arr    = OpTypeArray %{k}8 %c_i32_128\n"
    if not signed:
        out += "%u32arr   = OpTypeArray %u32 %c_i32_128\n"
    out += f"%v2{k}8     = OpTypeVector %{k}8 2\n"
    if not signed:
        out += "%v2u32    = OpTypeVector %u32 2\n%v4u32    = OpTypeVector %u32 4\n"
    else:
        out += "%v4i8     = OpTypeVector %i8 4\n%v2i32    = OpTypeVector %i32 2\n%v4i32    = OpTypeVector %i32 4\n"
    out += f"%v2{k}8ptr  = OpTypePointer StorageBuffer %v2{k}8\n%v2{k}32ptr = OpTypePointer StorageBuffer %v2{k}32\n"
    out += f"%v2{k}8arr  = OpTypeArray %v2{k}8 %c_i32_64\n%v2{k}32arr = OpTypeArray %v2{k}32 %c_i32_64\n"
    return out


def types_8_to_wide(signed, wide, cls8, clsw, vec_count, push=False):
    """Types of the 8 -> 32/16 templates, `cls8` is the storage class of the 8 bit pointers and `clsw` of the wide ones."""
    k = "i" if signed else "u"
    s = 1 if signed else 0
    arr_wide = 128 if not push else 64
    out = f"%{k}8       = OpTypeInt 8 {s}\n"
    if wide == 16:
        out += f"%{k}16      = OpTypeInt 16 {s}\n"
    out += f"%{k}8ptr    = OpTypePointer {cls8} %{k}8\n"
    out += f"%{k}8arr    = OpTypeArray %{k}8 %c_i32_{arr_wide}\n"
    # the templates of the 32 bit groups declare the signed scalar pointer and array themselves
    if wide != 32 or not signed:
        out += f"%{k}{wide}ptr   = OpTypePointer {clsw} %{k}{wide}\n"
        out += f"%{k}{wide}arr   = OpTypeArray %{k}{wide} %c_i32_{arr_wide}\n"
    out += f"%v{vec_count}{k}8     = OpTypeVector %{k}8 {vec_count}\n"
    out += f"%v{vec_count}{k}{wide}    = OpTypeVector %{k}{wide} {vec_count}\n"
    out += f"%v{vec_count}{k}8ptr  = OpTypePointer {cls8} %v{vec_count}{k}8\n"
    out += f"%v{vec_count}{k}{wide}ptr = OpTypePointer {clsw} %v{vec_count}{k}{wide}\n"
    vec_arr = arr_wide // vec_count
    out += f"%v{vec_count}{k}8arr  = OpTypeArray %v{vec_count}{k}8 %c_i32_{vec_arr}\n"
    out += f"%v{vec_count}{k}{wide}arr = OpTypeArray %v{vec_count}{k}{wide} %c_i32_{vec_arr}\n"
    return out


def types_16_to_8(signed):
    k = "i" if signed else "u"
    s = 1 if signed else 0
    out = f"%{k}8       = OpTypeInt 8 {s}\n%{k}16      = OpTypeInt 16 {s}\n"
    out += f"%{k}8ptr    = OpTypePointer StorageBuffer %{k}8\n%{k}16ptr   = OpTypePointer StorageBuffer %{k}16\n"
    out += f"%{k}8arr    = OpTypeArray %{k}8 %c_i32_128\n%{k}16arr   = OpTypeArray %{k}16 %c_i32_128\n"
    out += f"%v2{k}8     = OpTypeVector %{k}8 2\n%v2{k}16    = OpTypeVector %{k}16 2\n"
    out += f"%v2{k}8ptr  = OpTypePointer StorageBuffer %v2{k}8\n%v2{k}16ptr = OpTypePointer StorageBuffer %v2{k}16\n"
    out += f"%v2{k}8arr  = OpTypeArray %v2{k}8 %c_i32_64\n%v2{k}16arr = OpTypeArray %v2{k}16 %c_i32_64\n"
    return out


def composites(narrow, wide, narrow_stride, wide_stride, vec, vec_narrow_stride, vec_wide_stride, count_vec):
    """(name, signed, base wide, base narrow, opcode, stride text, workgroup count) of the four composite types."""
    rows = []
    for signed in (True, False):
        k = "i" if signed else "u"
        op = "OpSConvert" if signed else "OpUConvert"
        sname = "sint" if signed else "uint"
        rows.append((f"scalar_{sname}", signed, f"{k}{wide}", f"{k}{narrow}", op,
                     f"OpDecorate %{k}{wide}arr ArrayStride {wide_stride}\nOpDecorate %{k}{narrow}arr ArrayStride {narrow_stride}\n", None))
    for signed in (True, False):
        k = "i" if signed else "u"
        op = "OpSConvert" if signed else "OpUConvert"
        sname = "sint" if signed else "uint"
        rows.append((f"vector_{sname}", signed, f"v{vec}{k}{wide}", f"v{vec}{k}{narrow}", op,
                     f"OpDecorate %v{vec}{k}{wide}arr ArrayStride {vec_wide_stride}\nOpDecorate %v{vec}{k}{narrow}arr ArrayStride {vec_narrow_stride}\n", count_vec))
    return rows


def cases():
    # storagebuffer_32_to_8: scalar and vector of two, three-way strides 4/1 and 8/2.
    for name, signed, base_w, base_n, op, stride, vec in composites(8, 32, 1, 4, 2, 2, 8, True):
        count = 128 if not vec else 64
        values = {"capability": "StorageBuffer8BitAccess", "capability16": "", "extension16": "", "stride": stride, "base32": base_w, "base8": base_n,
                  "types": types_32_to_8(signed), "convert": op}
        spec = f"group=s32to8;count={count};signed={int(signed)}"
        yield f"8bit_storage/storagebuffer_32_to_8/storage_buffer_{name}", spec, specialize(STORAGE_32_TO_8, values)
    # uniform_8_to_32: the narrow side is a uniform with an array stride of 16, four to a vector.
    for idx, (name, signed, base_w, base_n, op, stride, vec) in enumerate(composites(8, 32, 16, 4, 4, 16, 16, True)):
        comp = 4 if vec else 1
        values = {"capability": "UniformAndStorageBuffer8BitAccess", "capability16": "", "extension16": "", "stride": stride, "base32": base_w, "base8": base_n,
                  "types": types_8_to_wide(signed, 32, "Uniform", "StorageBuffer", 4), "convert": op}
        spec = f"group=u8to32;idx={idx};comp={comp};signed={int(signed)}"
        yield f"8bit_storage/uniform_8_to_32/uniform_{name}", spec, specialize(UNIFORM_8_TO_32, values)
    # push_constant_8_to_32
    for name, signed, base_w, base_n, op, stride, vec in composites(8, 32, 1, 4, 2, 2, 8, True):
        count = 64 if not vec else 32
        values = {"capability": "StoragePushConstant8", "capability16": "", "extension16": "", "stride": stride, "base32": base_w, "base8": base_n,
                  "types": types_8_to_wide(signed, 32, "PushConstant", "StorageBuffer", 2, push=True), "convert": op}
        spec = f"group=p8to32;count={count};signed={int(signed)}"
        yield f"8bit_storage/push_constant_8_to_32/{name}", spec, specialize(PUSH_8_TO_32, values)
    # storagebuffer_16_to_8
    for name, signed, base_w, base_n, op, stride, vec in composites(8, 16, 1, 2, 2, 2, 4, True):
        count = 128 if not vec else 64
        values = {"capability": "StorageBuffer8BitAccess", "capability16": "OpCapability StorageUniform16\n", "extension16": 'OpExtension "SPV_KHR_16bit_storage"\n', "stride": stride,
                  "base16": base_w, "base8": base_n, "types": types_16_to_8(signed), "convert": op}
        spec = f"group=s16to8;count={count};signed={int(signed)}"
        yield f"8bit_storage/storagebuffer_16_to_8/storage_buffer_{name}", spec, specialize(STORAGE_16_TO_8, values)
    # uniform_8_to_16
    for idx, (name, signed, base_w, base_n, op, stride, vec) in enumerate(composites(8, 16, 16, 2, 4, 16, 8, True)):
        comp = 4 if vec else 1
        values = {"capability": "UniformAndStorageBuffer8BitAccess", "capability16": "OpCapability StorageUniform16\n", "extension16": 'OpExtension "SPV_KHR_16bit_storage"\n',
                  "stride": stride, "base16": base_w, "base8": base_n, "types": types_8_to_wide(signed, 16, "Uniform", "StorageBuffer", 4), "convert": op}
        spec = f"group=u8to16;idx={idx};comp={comp};signed={int(signed)}"
        yield f"8bit_storage/uniform_8_to_16/uniform_{name}", spec, specialize(UNIFORM_8_TO_16, values)
    # push_constant_8_to_16
    for name, signed, base_w, base_n, op, stride, vec in composites(8, 16, 1, 2, 2, 2, 4, True):
        count = 64 if not vec else 32
        values = {"stride": stride, "base16": base_w, "base8": base_n, "types": types_8_to_wide(signed, 16, "PushConstant", "StorageBuffer", 2, push=True), "convert": op}
        spec = f"group=p8to16;count={count};signed={int(signed)}"
        yield f"8bit_storage/push_constant_8_to_16/{name}", spec, specialize(PUSH_8_TO_16, values)
    yield "8bit_storage/uniform_8_to_8/stress_test", "group=stress8", STRESS_8_TO_8


def main():
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.8bit_storage.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_8bit_storage_manifest.py - do not hand-edit; `spec` says which value of which data the host expects.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/storage8_tests"\n'
    ]
    count = 0
    for name, spec, assembly in cases():
        const = "S8_" + "".join(c if c.isalnum() else "_" for c in name).upper()
        out.append(
            f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "Storage8Case"\n'
            f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
            f"derived = {{ source = {json.dumps(repr(assembly))} }}\n"
        )
        count += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_compute.toml: the SPIR-V assembly of the `dEQP-VK.spirv_assembly.instruction.compute.*` groups
that `vktSpvAsmInstructionTests.cpp` builds from one compute shader that negates (or otherwise transforms) a buffer of floats.

The assembly of each case is built here the way upstream concatenates it (`getComputeAsmShaderPreamble`, `getComputeAsmCommonTypes`, ...),
and compile_shaders.py assembles it with spirv-as (`stage = "asm"`). What the host needs to build the input and the expected output - the
seed group name, the range, the element count, which transformation - rides along as the parameters of `SpvAsmCase`, which
src/vkt/tests/spirv_assembly/instruction_tests.rs reads. A case name is its path below `compute`, with the groups joined by `/`.

Not here: the cases whose names contain bytes that are not valid UTF-8 (a manifest is UTF-8 text), the image input case of `opline`,
the Amber cases and everything that is not a plain float buffer in and out.

A pure text generator: no spirv-as and no cargo.
"""

import json
import struct
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from de_random import DeRandom, de_string_hash  # noqa: E402

SPIRV_SOURCES = Path(__file__).resolve().parent.parent / "shaders" / "src" / "spirv_assembly"
OUT = Path(__file__).resolve().parent.parent / "shaders" / "manifest" / "spirv_assembly_compute.toml"
TEMPLATE = "spirv_assembly/source.asm"


def preamble(capabilities="", extensions="", exe_modes="", extra_entry_points="", extra_entry_point_arguments=""):
    return (
        "OpCapability Shader\n"
        + capabilities
        + extensions
        + "OpMemoryModel Logical GLSL450\n"
        + 'OpEntryPoint GLCompute %main "main" %id '
        + extra_entry_point_arguments
        + "\n"
        + extra_entry_points
        + "OpExecutionMode %main LocalSize 1 1 1\n"
        + exe_modes
    )


def common_types(block_storage_class="Uniform"):
    return (
        "%bool      = OpTypeBool\n"
        "%void      = OpTypeVoid\n"
        "%voidf     = OpTypeFunction %void\n"
        "%u32       = OpTypeInt 32 0\n"
        "%i32       = OpTypeInt 32 1\n"
        "%f32       = OpTypeFloat 32\n"
        "%uvec3     = OpTypeVector %u32 3\n"
        "%fvec3     = OpTypeVector %f32 3\n"
        "%uvec3ptr  = OpTypePointer Input %uvec3\n"
        "%i32ptr    = OpTypePointer " + block_storage_class + " %i32\n"
        "%f32ptr    = OpTypePointer " + block_storage_class + " %f32\n"
        "%i32arr    = OpTypeRuntimeArray %i32\n"
        "%f32arr    = OpTypeRuntimeArray %f32\n"
    )


def input_output_buffer(block_storage_class="Uniform"):
    return (
        "%buf     = OpTypeStruct %f32arr\n"
        "%bufptr  = OpTypePointer " + block_storage_class + " %buf\n"
        "%indata    = OpVariable %bufptr " + block_storage_class + "\n"
        "%outdata   = OpVariable %bufptr " + block_storage_class + "\n"
    )


def input_output_buffer_traits(block_storage_class="BufferBlock"):
    return (
        "OpDecorate %buf " + block_storage_class + "\n"
        "OpDecorate %indata DescriptorSet 0\n"
        "OpDecorate %indata Binding 0\n"
        "OpDecorate %outdata DescriptorSet 0\n"
        "OpDecorate %outdata Binding 1\n"
        "OpDecorate %f32arr ArrayStride 4\n"
        "OpMemberDecorate %buf 0 Offset 0\n"
    )


BODY = (
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

NAMES = 'OpName %main           "main"\nOpName %id             "gl_GlobalInvocationID"\n'
DECORATE_ID = "OpDecorate %id BuiltIn GlobalInvocationId\n"
ID_AND_ZERO = "%id        = OpVariable %uvec3ptr Input\n%zero      = OpConstant %i32 0\n"


def make_long_utf8_string(count):
    return "\U0001F30D" * count


CASES = []


def add(path, assembly, seed, lo=1, hi=100, elements=100, kind="negate", entry="main", spirv13=False, extensions="", skip=0, workgroups=None, spirv=None, spec_constants=""):
    CASES.append(
        dict(
            name="/".join(path),
            assembly=assembly,
            seed=seed,
            lo=lo,
            hi=hi,
            elements=elements,
            kind=kind,
            entry=entry,
            spirv13=spirv13,
            extensions=extensions,
            skip=skip,
            spirv=spirv,
            spec_constants=spec_constants,
            workgroups=elements if workgroups is None else workgroups,
        )
    )


# unused_variables
UNUSED_TYPES = (
    "%c_f32_101 = OpConstant %f32 101\n"
    "%c_i32_201 = OpConstant %i32 201\n"
    "%UnusedBufferType = OpTypeStruct %f32 %i32\n"
    "%unused_ptr_Uniform_UnusedBufferType = OpTypePointer Uniform %UnusedBufferType\n"
    "%unused_ptr_Uniform_float = OpTypePointer Uniform %f32\n"
    "%unused_ptr_Uniform_int = OpTypePointer Uniform %i32\n"
)
UNUSED_BUFFER = "%unused_buffer = OpVariable %unused_ptr_Uniform_UnusedBufferType Uniform\n"
UNUSED_FUNCTION = (
    "%unused_func = OpFunction %void None %voidf\n"
    "%unused_func_label = OpLabel\n"
    "%unused_out_float_ptr = OpAccessChain %unused_ptr_Uniform_float %unused_buffer %c_i32_0\n"
    "OpStore %unused_out_float_ptr %c_f32_101\n"
    "%unused_out_int_ptr = OpAccessChain %unused_ptr_Uniform_int %unused_buffer %c_i32_1\n"
    "OpStore %unused_out_int_ptr %c_i32_201\n"
    "OpReturn\n"
    "OpFunctionEnd\n"
)
NEGATE_MAIN = (
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)


def unused_decorations(set_index, binding):
    return (
        "OpMemberDecorate %UnusedBufferType 0 Offset 0\n"
        "OpMemberDecorate %UnusedBufferType 1 Offset 4\n"
        "OpDecorate %UnusedBufferType BufferBlock\n"
        f"OpDecorate %unused_buffer DescriptorSet {set_index}\n"
        f"OpDecorate %unused_buffer Binding {binding}\n"
    )


for unused_set, unused_binding in ((0, 5), (5, 5)):
    location = f"set_{unused_set}_binding_{unused_binding}"
    add(
        ("unused_variables", "variable_" + location),
        preamble()
        + DECORATE_ID
        + unused_decorations(unused_set, unused_binding)
        + input_output_buffer_traits()
        + common_types()
        + UNUSED_TYPES
        + input_output_buffer()
        + UNUSED_BUFFER
        + ID_AND_ZERO
        + NEGATE_MAIN,
        "unused_variables",
    )
    add(
        ("unused_variables", "function_" + location),
        preamble(extra_entry_points='OpEntryPoint Vertex %unused_func "unused_func"\n')
        + DECORATE_ID
        + unused_decorations(unused_set, unused_binding)
        + input_output_buffer_traits()
        + common_types()
        + UNUSED_TYPES
        + "%c_i32_0 = OpConstant %i32 0\n"
        "%c_i32_1 = OpConstant %i32 1\n"
        + input_output_buffer()
        + UNUSED_BUFFER
        + ID_AND_ZERO
        + NEGATE_MAIN
        + UNUSED_FUNCTION,
        "unused_variables",
    )

# opnop
add(
    ("opnop", "all"),
    preamble()
    + "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + ID_AND_ZERO
    + "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "             OpNop\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n",
    "opnop",
)

# opline
add(
    ("opline", "all"),
    preamble()
    + '%fname1 = OpString "negateInputs.comp"\n'
    '%fname2 = OpString "negateInputs"\n'
    "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + "OpLine %fname1 0 0\n"
    + common_types()
    + input_output_buffer()
    + "OpLine %fname1 0 1\n"
    "OpLine %fname2 1 0\n"
    "OpLine %fname1 1000 100000\n"
    + ID_AND_ZERO
    + "OpLine %fname1 1 1\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "OpLine %fname1 1 1\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n",
    "opline",
)

# opmoduleprocessed
add(
    ("opmoduleprocessed", "all"),
    preamble()
    + '%fname = OpString "negateInputs.comp"\n'
    "OpSource GLSL 430\n"
    + NAMES
    + 'OpModuleProcessed "VULKAN CTS"\n'
    'OpModuleProcessed "Negative values"\n'
    'OpModuleProcessed "Date: 2017/09/21"\n'
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "OpLine %fname 0 1\n"
    "OpLine %fname 1000 1\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %i32 0\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n",
    "opmoduleprocessed",
    elements=10,
    kind="negate_verify_binary",
    spirv13=True,
)

# opnoline
add(
    ("opnoline", "all"),
    preamble()
    + '%fname = OpString "negateInputs.comp"\n'
    "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + "OpNoLine\n"
    + common_types()
    + input_output_buffer()
    + "OpLine %fname 0 1\n"
    "OpNoLine\n"
    "OpLine %fname 1000 1\n"
    + ID_AND_ZERO
    + "OpNoLine\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "OpNoLine\n"
    "OpNoLine\n"
    "OpNoLine\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n",
    "opnoline",
)

# opsource
SOURCE_TEMPLATE = (
    "OpCapability Shader\n"
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "{SOURCE}\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + ID_AND_ZERO
    + BODY
)
source_cases = [
    ("unknown_source", "OpSource Unknown 0"),
    ("wrong_source", "OpSource OpenCL_C 210"),
    ("normal_filename", '%fname = OpString "filename"\nOpSource GLSL 430 %fname'),
    ("empty_filename", '%fname = OpString ""\nOpSource GLSL 430 %fname'),
    ("normal_source_code", '%fname = OpString "filename"\nOpSource GLSL 430 %fname "#version 430\nvoid main() {}"'),
    ("empty_source_code", '%fname = OpString "filename"\nOpSource GLSL 430 %fname ""'),
    ("long_source_code", '%fname = OpString "filename"\nOpSource GLSL 430 %fname "' + make_long_utf8_string(65530) + 'ccc"'),
    ("utf8_source_code", '%fname = OpString "filename"\nOpSource GLSL 430 %fname "☂★"'),
    ("normal_sourcecontinued", '%fname = OpString "filename"\nOpSource GLSL 430 %fname "#version 430\nvo"\nOpSourceContinued "id main() {}"'),
    ("empty_sourcecontinued", '%fname = OpString "filename"\nOpSource GLSL 430 %fname "#version 430\nvoid main() {}"\nOpSourceContinued ""'),
    ("long_sourcecontinued", '%fname = OpString "filename"\nOpSource GLSL 430 %fname "#version 430\nvoid main() {}"\nOpSourceContinued "' + make_long_utf8_string(65533) + 'ccc"'),
    ("utf8_sourcecontinued", '%fname = OpString "filename"\nOpSource GLSL 430 %fname "#version 430\nvoid main() {}"\nOpSourceContinued "☎⚑"'),
    ("multi_sourcecontinued", '%fname = OpString "filename"\nOpSource GLSL 430 %fname "#version 430\n"\nOpSourceContinued "void"\nOpSourceContinued "main()"\nOpSourceContinued "{}"'),
    ("empty_source_before_sourcecontinued", '%fname = OpString "filename"\nOpSource GLSL 430 %fname ""\nOpSourceContinued "#version 430\nvoid main() {}"'),
]
for name, param in source_cases:
    add(("opsource", name), SOURCE_TEMPLATE.replace("{SOURCE}", param), "opsource")

# opsourceextension
EXTENSION_TEMPLATE = preamble() + 'OpSourceExtension "{EXTENSION}"\n' + NAMES + DECORATE_ID + input_output_buffer_traits() + common_types() + input_output_buffer() + ID_AND_ZERO + BODY
for name, param in [
    ("empty_extension", ""),
    ("real_extension", "GL_ARB_texture_rectangle"),
    ("fake_extension", "GL_ARB_im_the_ultimate_extension"),
    ("utf8_extension", "GL_ARB_☂★"),
    ("long_extension", make_long_utf8_string(65533) + "ccc"),
]:
    add(("opsourceextension", name), EXTENSION_TEMPLATE.replace("{EXTENSION}", param), "opsourceextension", lo=-200, hi=200)

# opconstantnull
NULL_TEMPLATE = (
    preamble()
    + "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + "%uvec2     = OpTypeVector %u32 2\n"
    "%bvec3     = OpTypeVector %bool 3\n"
    "%fvec4     = OpTypeVector %f32 4\n"
    "%fmat33    = OpTypeMatrix %fvec3 3\n"
    "%const100  = OpConstant %u32 100\n"
    "%uarr100   = OpTypeArray %i32 %const100\n"
    "%struct    = OpTypeStruct %f32 %i32 %u32\n"
    + input_output_buffer()
    + "%null      = OpConstantNull {TYPE}\n"
    + ID_AND_ZERO
    + BODY
)
for name, param in [
    ("bool", "%bool"),
    ("sint32", "%i32"),
    ("uint32", "%u32"),
    ("float32", "%f32"),
    ("vec4float32", "%fvec4"),
    ("vec3bool", "%bvec3"),
    ("vec2uint32", "%uvec2"),
    ("matrix", "%fmat33"),
    ("array", "%uarr100"),
    ("struct", "%struct"),
]:
    add(("opconstantnull", name), NULL_TEMPLATE.replace("{TYPE}", param), "opconstantnull")

# opconstantcomposite
COMPOSITE_TEMPLATE = (
    preamble()
    + "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + ID_AND_ZERO
    + "{CONSTANT}\n"
    + BODY
)
for name, param in [
    ("vector", "%five = OpConstant %i32 5\n%ivec3 = OpTypeVector %i32 3\n%const = OpConstantComposite %ivec3 %five %zero %five"),
    (
        "matrix",
        "%m3fvec3 = OpTypeMatrix %fvec3 3\n%ten = OpConstant %f32 10.\n%fzero = OpConstant %f32 0.\n%vec = OpConstantComposite %fvec3 %ten %fzero %ten\n%mat = OpConstantComposite %m3fvec3 %vec %vec %vec",
    ),
    (
        "struct",
        "%m2vec3 = OpTypeMatrix %fvec3 2\n%struct = OpTypeStruct %i32 %f32 %fvec3 %m2vec3\n%fzero = OpConstant %f32 0.\n%one = OpConstant %f32 1.\n%point5 = OpConstant %f32 0.5\n"
        "%vec = OpConstantComposite %fvec3 %one %one %fzero\n%mat = OpConstantComposite %m2vec3 %vec %vec\n%const = OpConstantComposite %struct %zero %point5 %vec %mat",
    ),
    (
        "nested_struct",
        "%st1 = OpTypeStruct %u32 %f32\n%st2 = OpTypeStruct %i32 %i32\n%struct = OpTypeStruct %st1 %st2\n%point5 = OpConstant %f32 0.5\n%one = OpConstant %u32 1\n%ten = OpConstant %i32 10\n"
        "%st1val = OpConstantComposite %st1 %one %point5\n%st2val = OpConstantComposite %st2 %ten %ten\n%const = OpConstantComposite %struct %st1val %st2val",
    ),
]:
    add(("opconstantcomposite", name), COMPOSITE_TEMPLATE.replace("{CONSTANT}", param), "opconstantcomposite")

# opconstantnullcomposite (createOpConstantUsageGroup)
add(
    ("opconstantnullcomposite", "spotcheck"),
    "OpCapability Shader\n"
    '%std450 = OpExtInstImport "GLSL.std.450"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + "%fmat      = OpTypeMatrix %fvec3 3\n"
    "%ten       = OpConstant %u32 10\n"
    "%f32arr10  = OpTypeArray %f32 %ten\n"
    "%fst       = OpTypeStruct %f32 %f32\n"
    + input_output_buffer()
    + ID_AND_ZERO
    + "%unull     = OpConstantNull %u32\n"
    "%fnull     = OpConstantNull %f32\n"
    "%vnull     = OpConstantNull %fvec3\n"
    "%mnull     = OpConstantNull %fmat\n"
    "%anull     = OpConstantNull %f32arr10\n"
    "%snull     = OpConstantComposite %fst %fnull %fnull\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%unull_cov = OpConvertUToF %f32 %unull\n"
    "%unull_abs = OpExtInst %f32 %std450 FAbs %unull_cov\n"
    "%fnull_abs = OpExtInst %f32 %std450 FAbs %fnull\n"
    "%vnull_0   = OpCompositeExtract %f32 %vnull 0\n"
    "%vnull_abs = OpExtInst %f32 %std450 FAbs %vnull_0\n"
    "%mnull_12  = OpCompositeExtract %f32 %mnull 1 2\n"
    "%mnull_abs = OpExtInst %f32 %std450 FAbs %mnull_12\n"
    "%anull_3   = OpCompositeExtract %f32 %anull 3\n"
    "%anull_abs = OpExtInst %f32 %std450 FAbs %anull_3\n"
    "%snull_1   = OpCompositeExtract %f32 %snull 1\n"
    "%snull_abs = OpExtInst %f32 %std450 FAbs %snull_1\n"
    "%add1      = OpFAdd %f32 %neg  %unull_abs\n"
    "%add2      = OpFAdd %f32 %add1 %fnull_abs\n"
    "%add3      = OpFAdd %f32 %add2 %vnull_abs\n"
    "%add4      = OpFAdd %f32 %add3 %mnull_abs\n"
    "%add5      = OpFAdd %f32 %add4 %anull_abs\n"
    "%final     = OpFAdd %f32 %add5 %snull_abs\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %final\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n",
    "opconstantnullcomposite",
)

# opundef
UNDEF_TEMPLATE = (
    "{PREAMBLE}"
    + "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + "%uvec2     = OpTypeVector %u32 2\n"
    "%fvec4     = OpTypeVector %f32 4\n"
    "%fmat33    = OpTypeMatrix %fvec3 3\n"
    "%image     = OpTypeImage %f32 2D 0 0 0 1 Unknown\n"
    "%sampler   = OpTypeSampler\n"
    "%simage    = OpTypeSampledImage %image\n"
    "%const100  = OpConstant %u32 100\n"
    "%uarr100   = OpTypeArray %i32 %const100\n"
    "%struct    = OpTypeStruct %f32 %i32 %u32\n"
    "%pointer   = OpTypePointer Function %i32\n"
    + input_output_buffer()
    + ID_AND_ZERO
    + "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%undef     = OpUndef {TYPE}\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)
for name, param in [
    ("bool", "%bool"),
    ("sint32", "%i32"),
    ("uint32", "%u32"),
    ("float32", "%f32"),
    ("vec4float32", "%fvec4"),
    ("vec2uint32", "%uvec2"),
    ("matrix", "%fmat33"),
    ("image", "%image"),
    ("sampler", "%sampler"),
    ("sampledimage", "%simage"),
    ("array", "%uarr100"),
    ("runtimearray", "%f32arr"),
    ("struct", "%struct"),
    ("pointer", "%pointer"),
]:
    if name == "pointer":
        pre = preamble("OpCapability VariablePointers\n", 'OpExtension "SPV_KHR_variable_pointers"\n')
        add(("opundef", name), UNDEF_TEMPLATE.replace("{PREAMBLE}", pre).replace("{TYPE}", param), "opundef", extensions="VK_KHR_variable_pointers")
    else:
        add(("opundef", name), UNDEF_TEMPLATE.replace("{PREAMBLE}", preamble()).replace("{TYPE}", param), "opundef")

# opunreachable
add(
    ("opunreachable", "all"),
    preamble()
    + "OpSource GLSL 430\n"
    'OpName %main            "main"\n'
    'OpName %func_not_called_func "not_called_func("\n'
    'OpName %func_modulo4         "modulo4(u1;"\n'
    'OpName %func_const5          "const5("\n'
    'OpName %id                   "gl_GlobalInvocationID"\n'
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + "%u32ptr    = OpTypePointer Function %u32\n"
    "%uintfuint = OpTypeFunction %u32 %u32ptr\n"
    "%unitf     = OpTypeFunction %u32\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %u32 0\n"
    "%one       = OpConstant %u32 1\n"
    "%two       = OpConstant %u32 2\n"
    "%three     = OpConstant %u32 3\n"
    "%four      = OpConstant %u32 4\n"
    "%five      = OpConstant %u32 5\n"
    "%hundred   = OpConstant %u32 100\n"
    "%thousand  = OpConstant %u32 1000\n"
    + input_output_buffer()
    + "%main   = OpFunction %void None %voidf\n"
    "%main_entry  = OpLabel\n"
    "%v_thousand  = OpVariable %u32ptr Function %thousand\n"
    "%idval       = OpLoad %uvec3 %id\n"
    "%x           = OpCompositeExtract %u32 %idval 0\n"
    "%inloc       = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval       = OpLoad %f32 %inloc\n"
    "%outloc      = OpAccessChain %f32ptr %outdata %zero %x\n"
    "%ret_const5  = OpFunctionCall %u32 %func_const5\n"
    "%ret_modulo4 = OpFunctionCall %u32 %func_modulo4 %v_thousand\n"
    "%cmp_gt      = OpUGreaterThan %bool %ret_const5 %ret_modulo4\n"
    "               OpSelectionMerge %if_end None\n"
    "               OpBranchConditional %cmp_gt %if_true %if_false\n"
    "%if_true     = OpLabel\n"
    "%negate      = OpFNegate %f32 %inval\n"
    "               OpStore %outloc %negate\n"
    "               OpBranch %if_end\n"
    "%if_false    = OpLabel\n"
    "               OpUnreachable\n"
    "%if_end      = OpLabel\n"
    "               OpReturn\n"
    "               OpFunctionEnd\n"
    "%func_not_called_func  = OpFunction %void None %voidf\n"
    "%not_called_func_entry = OpLabel\n"
    "                         OpUnreachable\n"
    "                         OpFunctionEnd\n"
    "%func_modulo4  = OpFunction %u32 None %uintfuint\n"
    "%valptr        = OpFunctionParameter %u32ptr\n"
    "%modulo4_entry = OpLabel\n"
    "%val           = OpLoad %u32 %valptr\n"
    "%modulo        = OpUMod %u32 %val %four\n"
    "                 OpSelectionMerge %switch_merge None\n"
    "                 OpSwitch %modulo %default 0 %case0 1 %case1 2 %case2 3 %case3\n"
    "%case0         = OpLabel\n"
    "                 OpReturnValue %three\n"
    "%case1         = OpLabel\n"
    "                 OpReturnValue %two\n"
    "%case2         = OpLabel\n"
    "                 OpReturnValue %one\n"
    "%case3         = OpLabel\n"
    "                 OpReturnValue %zero\n"
    "%default       = OpLabel\n"
    "                 OpUnreachable\n"
    "%switch_merge  = OpLabel\n"
    "                 OpUnreachable\n"
    "                 OpFunctionEnd\n"
    "%func_const5  = OpFunction %u32 None %unitf\n"
    "%const5_entry = OpLabel\n"
    "                OpReturnValue %five\n"
    "%unreachable  = OpLabel\n"
    "                OpUnreachable\n"
    "                OpFunctionEnd\n",
    "opunreachable",
)

# block_order
add(
    ("block_order", "all"),
    preamble()
    + "OpSource GLSL 430\n"
    'OpName %main "main"\n'
    'OpName %id "gl_GlobalInvocationID"\n'
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + "%u32ptr       = OpTypePointer Function %u32\n"
    "%u32ptr_input = OpTypePointer Input %u32\n"
    + input_output_buffer()
    + "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %i32 0\n"
    "%const3    = OpConstant %u32 3\n"
    "%const50   = OpConstant %u32 50\n"
    "%constf1p5 = OpConstant %f32 1.5\n"
    "%constf27  = OpConstant %f32 27.0\n"
    "%constf42  = OpConstant %f32 42.0\n"
    "%main = OpFunction %void None %voidf\n"
    "%entry    = OpLabel\n"
    "%xvar     = OpVariable %u32ptr Function\n"
    "%xptr     = OpAccessChain %u32ptr_input %id %zero\n"
    "%x        = OpLoad %u32 %xptr\n"
    "            OpStore %xvar %x\n"
    "%cmp      = OpUGreaterThan %bool %x %const50\n"
    "            OpSelectionMerge %if_merge None\n"
    "            OpBranchConditional %cmp %if_true %if_false\n"
    "%if_false = OpLabel\n"
    "%x_f      = OpLoad %u32 %xvar\n"
    "%inloc_f  = OpAccessChain %f32ptr %indata %zero %x_f\n"
    "%inval_f  = OpLoad %f32 %inloc_f\n"
    "%negate   = OpFNegate %f32 %inval_f\n"
    "%outloc_f = OpAccessChain %f32ptr %outdata %zero %x_f\n"
    "            OpStore %outloc_f %negate\n"
    "            OpBranch %if_merge\n"
    "%if_merge = OpLabel\n"
    "            OpReturn\n"
    "%if_true  = OpLabel\n"
    "%xval_t   = OpLoad %u32 %xvar\n"
    "%mod      = OpUMod %u32 %xval_t %const3\n"
    "            OpSelectionMerge %switch_merge None\n"
    "            OpSwitch %mod %default 0 %case0 1 %case1 2 %case2\n"
    "%switch_merge = OpLabel\n"
    "                OpBranch %if_merge\n"
    "%case1    = OpLabel\n"
    "%x_1      = OpLoad %u32 %xvar\n"
    "%inloc_1  = OpAccessChain %f32ptr %indata %zero %x_1\n"
    "%inval_1  = OpLoad %f32 %inloc_1\n"
    "%addf42   = OpFAdd %f32 %inval_1 %constf42\n"
    "%outloc_1 = OpAccessChain %f32ptr %outdata %zero %x_1\n"
    "            OpStore %outloc_1 %addf42\n"
    "            OpBranch %switch_merge\n"
    "%case2    = OpLabel\n"
    "%x_2      = OpLoad %u32 %xvar\n"
    "%inloc_2  = OpAccessChain %f32ptr %indata %zero %x_2\n"
    "%inval_2  = OpLoad %f32 %inloc_2\n"
    "%subf27   = OpFSub %f32 %inval_2 %constf27\n"
    "%outloc_2 = OpAccessChain %f32ptr %outdata %zero %x_2\n"
    "            OpStore %outloc_2 %subf27\n"
    "            OpBranch %switch_merge\n"
    "%default = OpLabel\n"
    "           OpBranch %switch_merge\n"
    "%case0    = OpLabel\n"
    "%x_0      = OpLoad %u32 %xvar\n"
    "%inloc_0  = OpAccessChain %f32ptr %indata %zero %x_0\n"
    "%inval_0  = OpLoad %f32 %inloc_0\n"
    "%addf1p5  = OpFAdd %f32 %inval_0 %constf1p5\n"
    "%outloc_0 = OpAccessChain %f32ptr %outdata %zero %x_0\n"
    "            OpStore %outloc_0 %addf1p5\n"
    "            OpBranch %switch_merge\n"
    "            OpFunctionEnd\n",
    "block_order",
    lo=-100,
    hi=100,
    kind="block_order",
)

# multiple_shaders
MULTIPLE_SHADERS = (
    "OpCapability Shader\n"
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %comp_main1 "entrypoint1" %id\n'
    'OpEntryPoint GLCompute %comp_main2 "entrypoint2" %id\n'
    'OpEntryPoint Vertex    %vert_main  "entrypoint2" %vert_builtins %vertexIndex %instanceIndex\n'
    "OpExecutionMode %comp_main1 LocalSize 1 1 1\n"
    "OpExecutionMode %comp_main2 LocalSize 1 1 1\n"
    'OpName %comp_main1              "entrypoint1"\n'
    'OpName %comp_main2              "entrypoint2"\n'
    'OpName %vert_main               "entrypoint2"\n'
    'OpName %id                      "gl_GlobalInvocationID"\n'
    'OpName %vert_builtin_st         "gl_PerVertex"\n'
    'OpName %vertexIndex             "gl_VertexIndex"\n'
    'OpName %instanceIndex           "gl_InstanceIndex"\n'
    'OpMemberName %vert_builtin_st 0 "gl_Position"\n'
    'OpMemberName %vert_builtin_st 1 "gl_PointSize"\n'
    'OpMemberName %vert_builtin_st 2 "gl_ClipDistance"\n'
    "OpDecorate %id                      BuiltIn GlobalInvocationId\n"
    "OpDecorate %vertexIndex             BuiltIn VertexIndex\n"
    "OpDecorate %instanceIndex           BuiltIn InstanceIndex\n"
    "OpDecorate %vert_builtin_st         Block\n"
    "OpMemberDecorate %vert_builtin_st 0 BuiltIn Position\n"
    "OpMemberDecorate %vert_builtin_st 1 BuiltIn PointSize\n"
    "OpMemberDecorate %vert_builtin_st 2 BuiltIn ClipDistance\n"
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%zero       = OpConstant %i32 0\n"
    "%one        = OpConstant %u32 1\n"
    "%c_f32_1    = OpConstant %f32 1\n"
    "%i32inputptr         = OpTypePointer Input %i32\n"
    "%vec4                = OpTypeVector %f32 4\n"
    "%vec4ptr             = OpTypePointer Output %vec4\n"
    "%f32arr1             = OpTypeArray %f32 %one\n"
    "%vert_builtin_st     = OpTypeStruct %vec4 %f32 %f32arr1\n"
    "%vert_builtin_st_ptr = OpTypePointer Output %vert_builtin_st\n"
    "%vert_builtins       = OpVariable %vert_builtin_st_ptr Output\n"
    "%id         = OpVariable %uvec3ptr Input\n"
    "%vertexIndex = OpVariable %i32inputptr Input\n"
    "%instanceIndex = OpVariable %i32inputptr Input\n"
    "%c_vec4_1   = OpConstantComposite %vec4 %c_f32_1 %c_f32_1 %c_f32_1 %c_f32_1\n"
    "%vert_main  = OpFunction %void None %voidf\n"
    "%vert_entry = OpLabel\n"
    "%position   = OpAccessChain %vec4ptr %vert_builtins %zero\n"
    "              OpStore %position %c_vec4_1\n"
    "              OpReturn\n"
    "              OpFunctionEnd\n"
    "%comp_main1  = OpFunction %void None %voidf\n"
    "%comp1_entry = OpLabel\n"
    "%idval1      = OpLoad %uvec3 %id\n"
    "%x1          = OpCompositeExtract %u32 %idval1 0\n"
    "%inloc1      = OpAccessChain %f32ptr %indata %zero %x1\n"
    "%inval1      = OpLoad %f32 %inloc1\n"
    "%add         = OpFAdd %f32 %inval1 %inval1\n"
    "%outloc1     = OpAccessChain %f32ptr %outdata %zero %x1\n"
    "               OpStore %outloc1 %add\n"
    "               OpReturn\n"
    "               OpFunctionEnd\n"
    "%comp_main2  = OpFunction %void None %voidf\n"
    "%comp2_entry = OpLabel\n"
    "%idval2      = OpLoad %uvec3 %id\n"
    "%x2          = OpCompositeExtract %u32 %idval2 0\n"
    "%inloc2      = OpAccessChain %f32ptr %indata %zero %x2\n"
    "%inval2      = OpLoad %f32 %inloc2\n"
    "%neg         = OpFNegate %f32 %inval2\n"
    "%outloc2     = OpAccessChain %f32ptr %outdata %zero %x2\n"
    "               OpStore %outloc2 %neg\n"
    "               OpReturn\n"
    "               OpFunctionEnd\n"
)
add(("multiple_shaders", "shader1"), MULTIPLE_SHADERS, "multiple_shaders", lo=-500, hi=500, kind="double", entry="entrypoint1")
add(("multiple_shaders", "shader2"), MULTIPLE_SHADERS, "multiple_shaders", lo=-500, hi=500, kind="negate", entry="entrypoint2")

# opname / opmembername
LONG_NAME = "k" * 65535
ABUSE_CASES = [
    ("_has_very_long_name", LONG_NAME),
    ("_is_gl_Position", "gl_Position"),
    ("_is_gl_InstanceID", "gl_InstanceID"),
    ("_is_gl_PrimitiveID", "gl_PrimitiveID"),
    ("_is_gl_TessCoord", "gl_TessCoord"),
    ("_is_gl_PerVertex", "gl_PerVertex"),
    ("_is_gl_InvocationID", "gl_InvocationID"),
    ("_is_gl_PointSize", "gl_PointSize"),
    ("_is_gl_PointCoord", "gl_PointCoord"),
    ("_is_gl_Layer", "gl_Layer"),
    ("_is_gl_FragDepth", "gl_FragDepth"),
    ("_is_gl_NumWorkGroups", "gl_NumWorkGroups"),
    ("_is_gl_WorkGroupID", "gl_WorkGroupID"),
    ("_is_gl_LocalInvocationID", "gl_LocalInvocationID"),
    ("_is_gl_GlobalInvocationID", "gl_GlobalInvocationID"),
    ("_is_gl_MaxVertexAttribs", "gl_MaxVertexAttribs"),
    ("_is_gl_MaxViewports", "gl_MaxViewports"),
    ("_is_gl_MaxComputeWorkGroupCount", "gl_MaxComputeWorkGroupCount"),
    ("_is_mat3", "mat3"),
    ("_is_volatile", "volatile"),
    ("_is_inout", "inout"),
    ("_is_isampler3d", "isampler3d"),
]

NAME_HEADER = 'OpCapability Shader\nOpMemoryModel Logical GLSL450\nOpEntryPoint GLCompute %main "main" %id\nOpExecutionMode %main LocalSize 1 1 1\n'
NAME_FOOTER = (
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %i32 0\n"
    "%func      = OpFunction %void None %voidf\n"
    "%5         = OpLabel\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
    "%main      = OpFunction %void None %voidf\n"
    "%entry     = OpLabel\n"
    "%7         = OpFunctionCall %void %func\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)


def name_template(entry, ident, name):
    return f'OpCapability Shader\nOpMemoryModel Logical GLSL450\nOpEntryPoint GLCompute %main "{entry}" %id\nOpExecutionMode %main LocalSize 1 1 1\nOpName %{ident} "{name}"\n' + NAME_FOOTER


NAME_KW = dict(lo=-100, hi=100, elements=128)

add(
    ("opname", "abuse", "main_has_multiple_names"),
    NAME_HEADER + 'OpName %main "to_be"\nOpName %id   "or_not"\nOpName %main "to_be"\nOpName %main "makes_no"\nOpName %func "difference"\nOpName %5    "to_me"\n' + NAME_FOOTER,
    "opname",
    **NAME_KW,
)
everything = ["main", "id", "zero", "entry", "func", "5", "7", "idval", "inloc", "inval", "neg", "outloc"]
add(
    ("opname", "abuse", "everything_named"),
    NAME_HEADER + "".join(f'OpName %{ident:<6} "name{ndx + 1}"\n' for ndx, ident in enumerate(everything)) + NAME_FOOTER,
    "opname",
    **NAME_KW,
)
add(("opname", "abuse", "everything_named_the_same"), NAME_HEADER + "".join(f'OpName %{ident:<6} "the_same"\n' for ident in everything) + NAME_FOOTER, "opname", **NAME_KW)
for case_name, param in ABUSE_CASES:
    add(("opname", "abuse", "main" + case_name), name_template("main", "main", param), "opname", **NAME_KW)
for case_name, param in ABUSE_CASES:
    add(("opname", "abuse", "x" + case_name), name_template("main", "x", param), "opname", **NAME_KW)
cases = [("_is_main", "main"), ("_is_not_main", "not_main")]
for func in ("main", "func"):
    for case_name, param in cases:
        add(("opname", "entry_main", func + case_name), name_template("main", func, param), "opname", **NAME_KW)
cases.append(("_is_entry", "rdc"))
for func in ("main", "func"):
    for case_name, param in cases:
        add(("opname", "entry_rdc", func + case_name), name_template("rdc", func, param), "opname", entry="rdc", **NAME_KW)

MEMBER_FOOTER = (
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%u3str     = OpTypeStruct %u32 %u32 %u32\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %i32 0\n"
    "%main      = OpFunction %void None %voidf\n"
    "%entry     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x0        = OpCompositeExtract %u32 %idval 0\n"
    "%idstr     = OpCompositeConstruct %u3str %x0 %x0 %x0\n"
    "%x         = OpCompositeExtract %u32 %idstr 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval     = OpLoad %f32 %inloc\n"
    "%neg       = OpFNegate %f32 %inval\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)
add(
    ("opmembername", "abuse", "u3str_x_has_multiple_names"),
    NAME_HEADER + 'OpMemberName %u3str 0 "to_be"\nOpMemberName %u3str 1 "or_not"\nOpMemberName %u3str 0 "to_be"\nOpMemberName %u3str 2 "makes_no"\nOpMemberName %u3str 0 "difference"\nOpMemberName %u3str 0 "to_me"\n' + MEMBER_FOOTER,
    "opmembername",
    **NAME_KW,
)
add(
    ("opmembername", "abuse", "everything_named_the_same"),
    NAME_HEADER + 'OpMemberName %u3str 0 "the_same"\nOpMemberName %u3str 1 "the_same"\nOpMemberName %u3str 2 "the_same"\n' + MEMBER_FOOTER,
    "opmembername",
    **NAME_KW,
)
for case_name, param in ABUSE_CASES:
    add(("opmembername", "abuse", "u3str_x" + case_name), NAME_HEADER + f'OpMemberName %u3str 0 "{param}"\n' + MEMBER_FOOTER, "opmembername", **NAME_KW)

# loop_control
LOOP_TEMPLATE = (
    preamble()
    + "OpSource GLSL 430\n"
    'OpName %main "main"\n'
    'OpName %id "gl_GlobalInvocationID"\n'
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%u32ptr      = OpTypePointer Function %u32\n"
    "%id          = OpVariable %uvec3ptr Input\n"
    "%zero        = OpConstant %i32 0\n"
    "%uzero       = OpConstant %u32 0\n"
    "%one         = OpConstant %i32 1\n"
    "%constf1     = OpConstant %f32 1.0\n"
    "%four        = OpConstant %u32 4\n"
    "%main        = OpFunction %void None %voidf\n"
    "%entry       = OpLabel\n"
    "%i           = OpVariable %u32ptr Function\n"
    "               OpStore %i %uzero\n"
    "%idval       = OpLoad %uvec3 %id\n"
    "%x           = OpCompositeExtract %u32 %idval 0\n"
    "%inloc       = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval       = OpLoad %f32 %inloc\n"
    "%outloc      = OpAccessChain %f32ptr %outdata %zero %x\n"
    "               OpStore %outloc %inval\n"
    "               OpBranch %loop_entry\n"
    "%loop_entry  = OpLabel\n"
    "%i_val       = OpLoad %u32 %i\n"
    "%cmp_lt      = OpULessThan %bool %i_val %four\n"
    "               OpLoopMerge %loop_merge %loop_body {CONTROL}\n"
    "               OpBranchConditional %cmp_lt %loop_body %loop_merge\n"
    "%loop_body   = OpLabel\n"
    "%outval      = OpLoad %f32 %outloc\n"
    "%addf1       = OpFAdd %f32 %outval %constf1\n"
    "               OpStore %outloc %addf1\n"
    "%new_i       = OpIAdd %u32 %i_val %one\n"
    "               OpStore %i %new_i\n"
    "               OpBranch %loop_entry\n"
    "%loop_merge  = OpLabel\n"
    "               OpReturn\n"
    "               OpFunctionEnd\n"
)
for name, param in [("none", "None"), ("unroll", "Unroll"), ("dont_unroll", "DontUnroll")]:
    add(("loop_control", name), LOOP_TEMPLATE.replace("{CONTROL}", param), "loop_control", lo=-100, hi=100, kind="add_4")

# selection_control
SELECTION_TEMPLATE = (
    preamble()
    + "OpSource GLSL 430\n"
    'OpName %main "main"\n'
    'OpName %id "gl_GlobalInvocationID"\n'
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%id       = OpVariable %uvec3ptr Input\n"
    "%zero     = OpConstant %i32 0\n"
    "%constf1  = OpConstant %f32 1.0\n"
    "%constf10 = OpConstant %f32 10.0\n"
    "%main     = OpFunction %void None %voidf\n"
    "%entry    = OpLabel\n"
    "%idval    = OpLoad %uvec3 %id\n"
    "%x        = OpCompositeExtract %u32 %idval 0\n"
    "%inloc    = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval    = OpLoad %f32 %inloc\n"
    "%outloc   = OpAccessChain %f32ptr %outdata %zero %x\n"
    "%cmp_gt   = OpFOrdGreaterThan %bool %inval %constf10\n"
    "            OpSelectionMerge %if_end {CONTROL}\n"
    "            OpBranchConditional %cmp_gt %if_true %if_false\n"
    "%if_true  = OpLabel\n"
    "%addf1    = OpFAdd %f32 %inval %constf1\n"
    "            OpStore %outloc %addf1\n"
    "            OpBranch %if_end\n"
    "%if_false = OpLabel\n"
    "%subf1    = OpFSub %f32 %inval %constf1\n"
    "            OpStore %outloc %subf1\n"
    "            OpBranch %if_end\n"
    "%if_end   = OpLabel\n"
    "            OpReturn\n"
    "            OpFunctionEnd\n"
)
for name, param in [("none", "None"), ("flatten", "Flatten"), ("dont_flatten", "DontFlatten"), ("flatten_dont_flatten", "DontFlatten|Flatten")]:
    add(("selection_control", name), SELECTION_TEMPLATE.replace("{CONTROL}", param), "selection_control", lo=-100, hi=100, kind="selection")

# function_control
FUNCTION_TEMPLATE = (
    preamble()
    + "OpSource GLSL 430\n"
    'OpName %main "main"\n'
    'OpName %func_const10 "const10("\n'
    'OpName %id "gl_GlobalInvocationID"\n'
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%f32f = OpTypeFunction %f32\n"
    "%id = OpVariable %uvec3ptr Input\n"
    "%zero = OpConstant %i32 0\n"
    "%constf10 = OpConstant %f32 10.0\n"
    "%main         = OpFunction %void None %voidf\n"
    "%entry        = OpLabel\n"
    "%idval        = OpLoad %uvec3 %id\n"
    "%x            = OpCompositeExtract %u32 %idval 0\n"
    "%inloc        = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval        = OpLoad %f32 %inloc\n"
    "%ret_10       = OpFunctionCall %f32 %func_const10\n"
    "%fadd         = OpFAdd %f32 %inval %ret_10\n"
    "%outloc       = OpAccessChain %f32ptr %outdata %zero %x\n"
    "                OpStore %outloc %fadd\n"
    "                OpReturn\n"
    "                OpFunctionEnd\n"
    "%func_const10 = OpFunction %f32 {CONTROL} %f32f\n"
    "%label        = OpLabel\n"
    "                OpReturnValue %constf10\n"
    "                OpFunctionEnd\n"
)
for name, param in [
    ("none", "None"),
    ("inline", "Inline"),
    ("dont_inline", "DontInline"),
    ("pure", "Pure"),
    ("const", "Const"),
    ("inline_pure", "Inline|Pure"),
    ("const_dont_inline", "Const|DontInline"),
    ("inline_dont_inline", "Inline|DontInline"),
    ("pure_inline_dont_inline", "Pure|Inline|DontInline"),
]:
    add(("function_control", name), FUNCTION_TEMPLATE.replace("{CONTROL}", param), "function_control", lo=-100, hi=100, kind="add_10")

# memory_access
ACCESS_TEMPLATE = (
    preamble()
    + "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%f32ptr_f  = OpTypePointer Function %f32\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %i32 0\n"
    "%four      = OpConstant %i32 4\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%copy      = OpVariable %f32ptr_f Function\n"
    "%idval     = OpLoad %uvec3 %id {ACCESS}\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata  %zero %x\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpCopyMemory %copy %inloc {ACCESS}\n"
    "%val1      = OpLoad %f32 %copy\n"
    "%val2      = OpLoad %f32 %inloc\n"
    "%add       = OpFAdd %f32 %val1 %val2\n"
    "             OpStore %outloc %add {ACCESS}\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)
for name, param in [
    ("null", ""),
    ("none", "None"),
    ("volatile", "Volatile"),
    ("aligned", "Aligned 4"),
    ("nontemporal", "Nontemporal"),
    ("aligned_nontemporal", "Aligned|Nontemporal 4"),
    ("aligned_volatile", "Volatile|Aligned 4"),
]:
    add(("memory_access", name), ACCESS_TEMPLATE.replace("{ACCESS}", param), "memory_access", lo=-100, hi=100, kind="double")

# opcopymemory (the four cases draw from one generator, one after the other)
add(
    ("opcopymemory", "vector"),
    preamble()
    + NAMES
    + "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "OpDecorate %vec4arr ArrayStride 16\n"
    + input_output_buffer_traits()
    + common_types()
    + "%vec4       = OpTypeVector %f32 4\n"
    "%vec4ptr_u  = OpTypePointer Uniform %vec4\n"
    "%vec4ptr_f  = OpTypePointer Function %vec4\n"
    "%vec4arr    = OpTypeRuntimeArray %vec4\n"
    "%buf        = OpTypeStruct %vec4arr\n"
    "%bufptr     = OpTypePointer Uniform %buf\n"
    "%indata     = OpVariable %bufptr Uniform\n"
    "%outdata    = OpVariable %bufptr Uniform\n"
    "%id         = OpVariable %uvec3ptr Input\n"
    "%zero       = OpConstant %i32 0\n"
    "%c_f_0      = OpConstant %f32 0.\n"
    "%c_f_0_5    = OpConstant %f32 0.5\n"
    "%c_f_1_5    = OpConstant %f32 1.5\n"
    "%c_f_2_5    = OpConstant %f32 2.5\n"
    "%c_vec4     = OpConstantComposite %vec4 %c_f_0 %c_f_0_5 %c_f_1_5 %c_f_2_5\n"
    "%main       = OpFunction %void None %voidf\n"
    "%label      = OpLabel\n"
    "%v_vec4     = OpVariable %vec4ptr_f Function\n"
    "%idval      = OpLoad %uvec3 %id\n"
    "%x          = OpCompositeExtract %u32 %idval 0\n"
    "%inloc      = OpAccessChain %vec4ptr_u %indata %zero %x\n"
    "%outloc     = OpAccessChain %vec4ptr_u %outdata %zero %x\n"
    "              OpCopyMemory %v_vec4 %inloc\n"
    "%v_vec4_val = OpLoad %vec4 %v_vec4\n"
    "%add        = OpFAdd %vec4 %v_vec4_val %c_vec4\n"
    "              OpStore %outloc %add\n"
    "              OpReturn\n"
    "              OpFunctionEnd\n",
    "opcopymemory",
    lo=-200,
    hi=200,
    elements=400,
    workgroups=100,
    kind="copy_vector",
)
add(
    ("opcopymemory", "array"),
    preamble()
    + NAMES
    + "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "OpDecorate %f32arr100 ArrayStride 4\n"
    + input_output_buffer_traits()
    + common_types()
    + "%hundred        = OpConstant %u32 100\n"
    "%f32arr100      = OpTypeArray %f32 %hundred\n"
    "%f32arr100ptr_f = OpTypePointer Function %f32arr100\n"
    "%f32arr100ptr_u = OpTypePointer Uniform %f32arr100\n"
    "%buf            = OpTypeStruct %f32arr100\n"
    "%bufptr         = OpTypePointer Uniform %buf\n"
    "%indata         = OpVariable %bufptr Uniform\n"
    "%outdata        = OpVariable %bufptr Uniform\n"
    "%id             = OpVariable %uvec3ptr Input\n"
    "%zero           = OpConstant %i32 0\n"
    "%main           = OpFunction %void None %voidf\n"
    "%label          = OpLabel\n"
    "%var            = OpVariable %f32arr100ptr_f Function\n"
    "%inarr          = OpAccessChain %f32arr100ptr_u %indata %zero\n"
    "%outarr         = OpAccessChain %f32arr100ptr_u %outdata %zero\n"
    "                  OpCopyMemory %var %inarr\n"
    "                  OpCopyMemory %outarr %var\n"
    "                  OpReturn\n"
    "                  OpFunctionEnd\n",
    "opcopymemory",
    lo=-200,
    hi=200,
    elements=100,
    skip=400,
    workgroups=1,
    kind="identity",
)
add(
    ("opcopymemory", "struct"),
    preamble()
    + NAMES
    + "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "OpMemberDecorate %buf 1 Offset 16\n"
    "OpMemberDecorate %buf 2 Offset 32\n"
    "OpMemberDecorate %buf 3 Offset 48\n"
    + input_output_buffer_traits()
    + common_types()
    + "%vec4      = OpTypeVector %f32 4\n"
    "%buf       = OpTypeStruct %vec4 %vec4 %vec4 %vec4\n"
    "%bufptr    = OpTypePointer Uniform %buf\n"
    "%indata    = OpVariable %bufptr Uniform\n"
    "%outdata   = OpVariable %bufptr Uniform\n"
    "%vec4stptr = OpTypePointer Function %buf\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %i32 0\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%var       = OpVariable %vec4stptr Function\n"
    "             OpCopyMemory %var %indata\n"
    "             OpCopyMemory %outdata %var\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n",
    "opcopymemory",
    lo=-200,
    hi=200,
    elements=16,
    skip=500,
    workgroups=1,
    kind="identity",
)
add(
    ("opcopymemory", "float"),
    preamble()
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%f32ptr_f  = OpTypePointer Function %f32\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %i32 0\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%var       = OpVariable %f32ptr_f Function\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "             OpCopyMemory %var %inloc\n"
    "%val       = OpLoad %f32 %var\n"
    "%neg       = OpFNegate %f32 %val\n"
    "             OpStore %outloc %neg\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n",
    "opcopymemory",
    lo=-200,
    hi=200,
    elements=100,
    skip=516,
    kind="negate",
)

# opcopyobject.descriptor_array: an array of four uniform buffers bound at binding 0 and one output at binding 1 that the shader never writes
add(
    ("opcopyobject", "descriptor_array"),
    "OpCapability Shader\n"
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main"\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %struct BufferBlock\n"
    "OpMemberDecorate %struct 0 Offset 0\n"
    "OpDecorate %buf_array DescriptorSet 0\n"
    "OpDecorate %buf_array Binding 0\n"
    "%void = OpTypeVoid\n"
    "%func_type = OpTypeFunction %void\n"
    "%int = OpTypeInt 32 1\n"
    "%int_0 = OpConstant %int 0\n"
    "%uint = OpTypeInt 32 0\n"
    "%uint_4 = OpConstant %uint 4\n"
    "%struct = OpTypeStruct %int\n"
    "%struct_array = OpTypeArray %struct %uint_4\n"
    "%ptr_struct_array = OpTypePointer Uniform %struct_array\n"
    "%ptr_struct = OpTypePointer Uniform %struct\n"
    "%ptr_int = OpTypePointer Uniform %int\n"
    "%buf_array = OpVariable %ptr_struct_array Uniform\n"
    "%main = OpFunction %void None %func_type\n"
    "%entry = OpLabel\n"
    "%var_copy = OpCopyObject %ptr_struct_array %buf_array\n"
    "%buf_ptr = OpAccessChain %ptr_struct %var_copy %int_0\n"
    "%int_ptr = OpAccessChain %ptr_int %buf_ptr %int_0\n"
    "%val = OpLoad %int %int_ptr\n"
    "OpReturn\n"
    "OpFunctionEnd\n",
    "opcopyobject",
    elements=1,
    kind="descriptor_array",
)

# opcopyobject (the descriptor_array case needs an array of descriptors and is not here)
add(
    ("opcopyobject", "spotcheck"),
    preamble()
    + NAMES
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + "%fmat     = OpTypeMatrix %fvec3 3\n"
    "%three    = OpConstant %u32 3\n"
    "%farr     = OpTypeArray %f32 %three\n"
    "%fst      = OpTypeStruct %f32 %f32\n"
    + input_output_buffer()
    + "%id            = OpVariable %uvec3ptr Input\n"
    "%zero          = OpConstant %i32 0\n"
    "%c_f           = OpConstant %f32 1.5\n"
    "%c_fvec3       = OpConstantComposite %fvec3 %c_f %c_f %c_f\n"
    "%c_fmat        = OpConstantComposite %fmat %c_fvec3 %c_fvec3 %c_fvec3\n"
    "%c_farr        = OpConstantComposite %farr %c_f %c_f %c_f\n"
    "%c_fst         = OpConstantComposite %fst %c_f %c_f\n"
    "%main          = OpFunction %void None %voidf\n"
    "%label         = OpLabel\n"
    "%c_f_copy      = OpCopyObject %f32   %c_f\n"
    "%c_fvec3_copy  = OpCopyObject %fvec3 %c_fvec3\n"
    "%c_fmat_copy   = OpCopyObject %fmat  %c_fmat\n"
    "%c_farr_copy   = OpCopyObject %farr  %c_farr\n"
    "%c_fst_copy    = OpCopyObject %fst   %c_fst\n"
    "%fvec3_elem    = OpCompositeExtract %f32 %c_fvec3_copy 0\n"
    "%fmat_elem     = OpCompositeExtract %f32 %c_fmat_copy 1 2\n"
    "%farr_elem     = OpCompositeExtract %f32 %c_farr_copy 2\n"
    "%fst_elem      = OpCompositeExtract %f32 %c_fst_copy 1\n"
    "%add1          = OpFAdd %f32 %c_f_copy %fvec3_elem\n"
    "%add2          = OpFAdd %f32 %add1     %fmat_elem\n"
    "%add3          = OpFAdd %f32 %add2     %farr_elem\n"
    "%add4          = OpFAdd %f32 %add3     %fst_elem\n"
    "%idval         = OpLoad %uvec3 %id\n"
    "%x             = OpCompositeExtract %u32 %idval 0\n"
    "%inloc         = OpAccessChain %f32ptr %indata %zero %x\n"
    "%outloc        = OpAccessChain %f32ptr %outdata %zero %x\n"
    "%inval         = OpLoad %f32 %inloc\n"
    "%add           = OpFAdd %f32 %add4 %inval\n"
    "                 OpStore %outloc %add\n"
    "                 OpReturn\n"
    "                 OpFunctionEnd\n",
    "opcopyobject",
    lo=-200,
    hi=200,
    kind="add_7_5",
)

# opfrem, opnmin, opnmax, opnclamp: two or three float inputs and a custom comparison
def multi_input_assembly(header, inputs, op_line, out_elem="f32"):
    decorations = "".join(f"OpDecorate %indata{ndx + 1} DescriptorSet 0\nOpDecorate %indata{ndx + 1} Binding {ndx}\n" for ndx in range(inputs))
    decorations += f"OpDecorate %outdata DescriptorSet 0\nOpDecorate %outdata Binding {inputs}\n"
    variables = "".join(f"%indata{ndx + 1}    = OpVariable %bufptr Uniform\n" for ndx in range(inputs)) + "%outdata    = OpVariable %bufptr Uniform\n"
    loads = ""
    for ndx in range(inputs):
        loads += f"%inloc{ndx + 1}    = OpAccessChain %f32ptr %indata{ndx + 1} %zero %x\n%inval{ndx + 1}    = OpLoad %f32 %inloc{ndx + 1}\n"
    return (
        header
        + 'OpName %main           "main"\nOpName %id             "gl_GlobalInvocationID"\n'
        + DECORATE_ID
        + "OpDecorate %buf BufferBlock\n"
        + decorations
        + "OpDecorate %f32arr ArrayStride 4\nOpMemberDecorate %buf 0 Offset 0\n"
        + common_types()
        + "%buf        = OpTypeStruct %f32arr\n%bufptr     = OpTypePointer Uniform %buf\n"
        + variables
        + "%id        = OpVariable %uvec3ptr Input\n%zero      = OpConstant %i32 0\n"
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        + loads
        + op_line
        + "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
        "             OpStore %outloc %rem\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n"
    )


STD450_HEADER = (
    "OpCapability Shader\n"
    '%std450 = OpExtInstImport "GLSL.std.450"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
)
add(("opfrem", "all"), multi_input_assembly(preamble(), 2, "%rem       = OpFRem %f32 %inval1 %inval2\n"), "opfrem", elements=200, kind="frem")
add(("opnmin", "all"), multi_input_assembly(STD450_HEADER, 2, "%rem       = OpExtInst %f32 %std450 NMin %inval1 %inval2\n"), "opnmin", elements=200, kind="nmin")
add(("opnmax", "all"), multi_input_assembly(STD450_HEADER, 2, "%rem       = OpExtInst %f32 %std450 NMax %inval1 %inval2\n"), "opnmax", elements=200, kind="nmax")
add(("opnclamp", "all"), multi_input_assembly(STD450_HEADER, 3, "%rem       = OpExtInst %f32 %std450 NClamp %inval1 %inval2 %inval3\n"), "opnclamp", elements=200, kind="nclamp")

# nocontraction: the multiplication and the addition that a fused multiply-add would round differently
NO_CONTRACTION_TEMPLATE = (
    preamble()
    + NAMES.replace("%main           ", "%main           ")
    + DECORATE_ID
    + "{DECORATION}\n"
    "OpDecorate %buf BufferBlock\n"
    "OpDecorate %indata1 DescriptorSet 0\n"
    "OpDecorate %indata1 Binding 0\n"
    "OpDecorate %indata2 DescriptorSet 0\n"
    "OpDecorate %indata2 Binding 1\n"
    "OpDecorate %outdata DescriptorSet 0\n"
    "OpDecorate %outdata Binding 2\n"
    "OpDecorate %f32arr ArrayStride 4\n"
    "OpMemberDecorate %buf 0 Offset 0\n"
    + common_types()
    + "%buf        = OpTypeStruct %f32arr\n"
    "%bufptr     = OpTypePointer Uniform %buf\n"
    "%indata1    = OpVariable %bufptr Uniform\n"
    "%indata2    = OpVariable %bufptr Uniform\n"
    "%outdata    = OpVariable %bufptr Uniform\n"
    "%id         = OpVariable %uvec3ptr Input\n"
    "%zero       = OpConstant %i32 0\n"
    "%c_f_m1     = OpConstant %f32 -1.\n"
    "%main       = OpFunction %void None %voidf\n"
    "%label      = OpLabel\n"
    "%idval      = OpLoad %uvec3 %id\n"
    "%x          = OpCompositeExtract %u32 %idval 0\n"
    "%inloc1     = OpAccessChain %f32ptr %indata1 %zero %x\n"
    "%inval1     = OpLoad %f32 %inloc1\n"
    "%inloc2     = OpAccessChain %f32ptr %indata2 %zero %x\n"
    "%inval2     = OpLoad %f32 %inloc2\n"
    "%mul        = OpFMul %f32 %inval1 %inval2\n"
    "%add        = OpFAdd %f32 %mul %c_f_m1\n"
    "%outloc     = OpAccessChain %f32ptr %outdata %zero %x\n"
    "              OpStore %outloc %add\n"
    "              OpReturn\n"
    "              OpFunctionEnd\n"
)
for name, param in [
    ("multiplication", "OpDecorate %mul NoContraction"),
    ("addition", "OpDecorate %add NoContraction"),
    ("both", "OpDecorate %mul NoContraction\nOpDecorate %add NoContraction"),
]:
    add(("nocontraction", name), NO_CONTRACTION_TEMPLATE.replace("{DECORATION}", param), "nocontraction", kind="nocontraction")


# opfunord, opfunord_nan: float comparison that is true when either operand is NaN, written to an i32 buffer
FUNORD_TEMPLATE = (
    "{PREAMBLE}"
    "OpSource GLSL 430\n"
    + NAMES
    + DECORATE_ID
    + "OpDecorate %buf BufferBlock\n"
    "OpDecorate %buf2 BufferBlock\n"
    "OpDecorate %indata1 DescriptorSet 0\n"
    "OpDecorate %indata1 Binding 0\n"
    "OpDecorate %indata2 DescriptorSet 0\n"
    "OpDecorate %indata2 Binding 1\n"
    "OpDecorate %outdata DescriptorSet 0\n"
    "OpDecorate %outdata Binding 2\n"
    "OpDecorate %f32arr ArrayStride 4\n"
    "OpDecorate %i32arr ArrayStride 4\n"
    "OpMemberDecorate %buf 0 Offset 0\n"
    "OpMemberDecorate %buf2 0 Offset 0\n"
    + common_types()
    + "%buf        = OpTypeStruct %f32arr\n"
    "%bufptr     = OpTypePointer Uniform %buf\n"
    "%indata1    = OpVariable %bufptr Uniform\n"
    "%indata2    = OpVariable %bufptr Uniform\n"
    "%buf2       = OpTypeStruct %i32arr\n"
    "%buf2ptr    = OpTypePointer Uniform %buf2\n"
    "%outdata    = OpVariable %buf2ptr Uniform\n"
    "%id        = OpVariable %uvec3ptr Input\n"
    "%zero      = OpConstant %i32 0\n"
    "%consti1   = OpConstant %i32 1\n"
    "%constf1   = OpConstant %f32 1.0\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc1    = OpAccessChain %f32ptr %indata1 %zero %x\n"
    "%inval1    = OpLoad %f32 %inloc1\n"
    "%inloc2    = OpAccessChain %f32ptr %indata2 %zero %x\n"
    "%inval2    = OpLoad %f32 %inloc2\n"
    "%outloc    = OpAccessChain %i32ptr %outdata %zero %x\n"
    "%result    = {OPCODE} %bool %inval1 %inval2\n"
    "%int_res   = OpSelect %i32 %result %consti1 %zero\n"
    "             OpStore %outloc %int_res\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)
FUNORD_CASES = [
    ("equal", "OpFUnordEqual"),
    ("less", "OpFUnordLessThan"),
    ("lessequal", "OpFUnordLessThanEqual"),
    ("greater", "OpFUnordGreaterThan"),
    ("greaterequal", "OpFUnordGreaterThanEqual"),
    ("notequal", "OpFUnordNotEqual"),
]
for with_nan in (False, True):
    group = "opfunord_nan" if with_nan else "opfunord"
    header = (
        preamble(
            "OpCapability SignedZeroInfNanPreserve\n" if with_nan else "",
            'OpExtension "SPV_KHR_float_controls"\n' if with_nan else "",
            "OpExecutionMode %main SignedZeroInfNanPreserve 32\n" if with_nan else "",
        )
    )
    for index, (name, opcode) in enumerate(FUNORD_CASES):
        add(
            (group, name),
            FUNORD_TEMPLATE.replace("{PREAMBLE}", header).replace("{OPCODE}", opcode),
            group,
            lo=1,
            hi=100,
            elements=100,
            kind="funord_nan" if with_nan else "funord",
            extensions="VK_KHR_shader_float_controls" if with_nan else "",
            skip=index * 100,
        )

# opsrem, opsmod (32 and 64 bit): the integer remainders; skip is the index of the case in its group, which draws from one generator
def int_remainder_assembly(opcode, wide):
    elem = "i64" if wide else "i32"
    stride = 8 if wide else 4
    return (
        ("OpCapability Int64\n" if wide else "")
        + preamble()
        + NAMES
        + DECORATE_ID
        + "OpDecorate %buf BufferBlock\n"
        "OpDecorate %indata1 DescriptorSet 0\n"
        "OpDecorate %indata1 Binding 0\n"
        "OpDecorate %indata2 DescriptorSet 0\n"
        "OpDecorate %indata2 Binding 1\n"
        "OpDecorate %outdata DescriptorSet 0\n"
        "OpDecorate %outdata Binding 2\n"
        f"OpDecorate %{elem}arr ArrayStride {stride}\n"
        "OpMemberDecorate %buf 0 Offset 0\n"
        + common_types()
        + ("%i64       = OpTypeInt 64 1\n%i64ptr    = OpTypePointer Uniform %i64\n%i64arr    = OpTypeRuntimeArray %i64\n" if wide else "")
        + f"%buf        = OpTypeStruct %{elem}arr\n"
        "%bufptr     = OpTypePointer Uniform %buf\n"
        "%indata1    = OpVariable %bufptr Uniform\n"
        "%indata2    = OpVariable %bufptr Uniform\n"
        "%outdata    = OpVariable %bufptr Uniform\n"
        "%id        = OpVariable %uvec3ptr Input\n"
        f"%zero      = OpConstant %{elem} 0\n"
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        f"%inloc1    = OpAccessChain %{elem}ptr %indata1 %zero %x\n"
        f"%inval1    = OpLoad %{elem} %inloc1\n"
        f"%inloc2    = OpAccessChain %{elem}ptr %indata2 %zero %x\n"
        f"%inval2    = OpLoad %{elem} %inloc2\n"
        f"%rem       = {opcode} %{elem} %inval1 %inval2\n"
        f"%outloc    = OpAccessChain %{elem}ptr %outdata %zero %x\n"
        "             OpStore %outloc %rem\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n"
    )


for prefix in ((), ("android",), ("maintenance8",)):
    for op, opcode in (("srem", "OpSRem"), ("smod", "OpSMod")):
        for wide in (False,) if prefix == ("android",) else (False, True):
            group = "op" + op + ("64" if wide else "")
            for index, leaf in enumerate(("positive", "all")):
                add(
                    prefix + (group, leaf),
                    int_remainder_assembly(opcode, wide),
                    group,
                    elements=200,
                    kind=op + ("64" if wide else ""),
                    skip=index,
                )


# expression_rearrangement: the denorm execution modes apply after a rearrangement, which NoContraction prevents
REARRANGEMENT_TEMPLATE = (
    "{PREAMBLE}"
    + NAMES
    + DECORATE_ID
    + "{DECORATION}\n"
    "OpDecorate %buf BufferBlock\n"
    "OpDecorate %indata1 DescriptorSet 0\n"
    "OpDecorate %indata1 Binding 0\n"
    "OpDecorate %indata2 DescriptorSet 0\n"
    "OpDecorate %indata2 Binding 1\n"
    "OpDecorate %outdata DescriptorSet 0\n"
    "OpDecorate %outdata Binding 2\n"
    "OpDecorate %f32arr ArrayStride 4\n"
    "OpMemberDecorate %buf 0 Offset 0\n"
    + common_types()
    + "%buf        = OpTypeStruct %f32arr\n"
    "%bufptr     = OpTypePointer Uniform %buf\n"
    "%indata1    = OpVariable %bufptr Uniform\n"
    "%indata2    = OpVariable %bufptr Uniform\n"
    "%outdata    = OpVariable %bufptr Uniform\n"
    "%id         = OpVariable %uvec3ptr Input\n"
    "%zero       = OpConstant %i32 0\n"
    "%c_f_m1     = OpConstant %f32 -1.\n"
    "%main       = OpFunction %void None %voidf\n"
    "%label      = OpLabel\n"
    "%idval      = OpLoad %uvec3 %id\n"
    "%x          = OpCompositeExtract %u32 %idval 0\n"
    "%inloc1     = OpAccessChain %f32ptr %indata1 %zero %x\n"
    "%inval1     = OpLoad %f32 %inloc1\n"
    "%inloc2     = OpAccessChain %f32ptr %indata2 %zero %x\n"
    "%inval2     = OpLoad %f32 %inloc2\n"
    "{OPERATION}"
    "%outloc     = OpAccessChain %f32ptr %outdata %zero %x\n"
    "              OpStore %outloc %outval\n"
    "              OpReturn\n"
    "              OpFunctionEnd\n"
)
REARRANGEMENT_ADD = "%tmpval     = OpFAdd %f32 %inval1 %inval2\n%outval     = OpFSub %f32 %tmpval %inval1\n"
REARRANGEMENT_MUL_ADD = "%tmpval     = OpFMul %f32 %inval1 %inval1\n%outval     = OpFAdd %f32 %tmpval %inval2\n"
REARRANGEMENT_NO_CONTRACTION = "OpDecorate %tmpval NoContraction\nOpDecorate %outval NoContraction"
for name, kind, operation, mode, decoration in [
    ("preserve_add", "rearrangement_add", REARRANGEMENT_ADD, "DenormPreserve", ""),
    ("preserve_add_no_contraction", "rearrangement_add", REARRANGEMENT_ADD, "DenormPreserve", REARRANGEMENT_NO_CONTRACTION),
    ("ftz_mul_add", "rearrangement_mul_add", REARRANGEMENT_MUL_ADD, "DenormFlushToZero", ""),
    ("ftz_mul_add_no_contraction", "rearrangement_mul_add", REARRANGEMENT_MUL_ADD, "DenormFlushToZero", REARRANGEMENT_NO_CONTRACTION),
]:
    add(
        ("expression_rearrangement", name),
        REARRANGEMENT_TEMPLATE.replace("{PREAMBLE}", preamble(f"OpCapability {mode}\n", 'OpExtension "SPV_KHR_float_controls"\n', f"OpExecutionMode %main {mode} 32\n"))
        .replace("{DECORATION}", decoration)
        .replace("{OPERATION}", operation),
        "expression_rearrangement",
        elements=100,
        kind=kind,
        extensions="VK_KHR_shader_float_controls",
    )


# opphi: block, induction, swap, wide, nested (the vartype cases are not here)
OPHI_WIDTH = 512
OPHI_HEADER = (
    preamble()
    + "OpSource GLSL 430\n"
    + NAMES.replace("%main           ", "%main ").replace("%id             ", "%id ")
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
)
OPHI_STD450_HEADER = (
    "OpCapability Shader\n"
    '%ext = OpExtInstImport "GLSL.std.450"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
)


def expand_opphi_case5(text, acc, add, threshold):
    result = []
    for ch in text:
        result.append(ch)
        acc += add
        if acc > threshold:
            acc -= threshold
            result.append("ABC")
    return "".join(result), acc


def generate_opphi_case5(code):
    id_stack = [-1]
    value = ["%f32_0"]
    value_label = ["%f32_0 %entry"]
    merge_left = []
    merge_right = []
    res = []
    depth = -1
    curr_id = 0
    for it, ch in enumerate(code):
        if ch == "A":
            depth += 1
            curr_id = it
            id_stack.append(curr_id)
            res.append(f"\tOpSelectionMerge %m{curr_id} None\n")
            res.append(f"\tOpBranchConditional %b{depth} %t{curr_id} %f{curr_id}\n")
            res.append(f"%t{curr_id} = OpLabel\n")
            res.append(f"%rt{curr_id} = OpFAdd %f32 {value[-1]} %f32_1\n")
            value.append(f"%rt{curr_id}")
            value_label.append(f"%rt{curr_id} %t{curr_id}")
        if ch == "B":
            merge_left.append(value_label[-1])
            value.pop()
            value_label.pop()
            res.append(f"\tOpBranch %m{curr_id}\n")
            res.append(f"%f{curr_id} = OpLabel\n")
            value_label[-1] = f"{value[-1]} %f{curr_id}"
        if ch == "C":
            merge_right.append(value_label[-1])
            res.append(f"\tOpBranch %m{curr_id}\n")
            res.append(f"%m{curr_id} = OpLabel\n")
            res.append("%res" if it + 1 == len(code) else f"%rm{curr_id}")
            res.append(f" = OpPhi %f32  {merge_left[-1]}  {merge_right[-1]}\n")
            value.pop()
            value.append(f"%rm{curr_id}")
            value_label[-1] = f"%rm{curr_id} %m{curr_id}"
            merge_left.pop()
            merge_right.pop()
            depth -= 1
            id_stack.pop()
            curr_id = id_stack[-1]
    return "".join(res)


OPHI_CODE = "ABC"
OPHI_ACC = 0
for _ in range(9):
    OPHI_CODE, OPHI_ACC = expand_opphi_case5(OPHI_CODE, OPHI_ACC, 7, 24)

add(
    ("opphi", "block"),
    OPHI_HEADER
    + "%id = OpVariable %uvec3ptr Input\n"
    "%zero       = OpConstant %i32 0\n"
    "%three      = OpConstant %u32 3\n"
    "%constf5p5  = OpConstant %f32 5.5\n"
    "%constf20p5 = OpConstant %f32 20.5\n"
    "%constf1p75 = OpConstant %f32 1.75\n"
    "%constf8p5  = OpConstant %f32 8.5\n"
    "%constf6p5  = OpConstant %f32 6.5\n"
    "%main     = OpFunction %void None %voidf\n"
    "%entry    = OpLabel\n"
    "%idval    = OpLoad %uvec3 %id\n"
    "%x        = OpCompositeExtract %u32 %idval 0\n"
    "%selector = OpUMod %u32 %x %three\n"
    "            OpSelectionMerge %phi None\n"
    "            OpSwitch %selector %default 0 %case0 1 %case1 2 %case2\n"
    "%case1    = OpLabel\n"
    "            OpBranch %phi\n"
    "%default  = OpLabel\n"
    "            OpUnreachable\n"
    "%phi      = OpLabel\n"
    "%operand  = OpPhi %f32   %constf1p75 %case2   %constf20p5 %case1   %constf5p5 %case0\n"
    "%inloc    = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval    = OpLoad %f32 %inloc\n"
    "%add      = OpFAdd %f32 %inval %operand\n"
    "%outloc   = OpAccessChain %f32ptr %outdata %zero %x\n"
    "            OpStore %outloc %add\n"
    "            OpReturn\n"
    "%case0    = OpLabel\n"
    "            OpBranch %phi\n"
    "%case2    = OpLabel\n"
    "            OpBranch %phi\n"
    "            OpFunctionEnd\n",
    "opphi",
    lo=-300,
    hi=300,
    kind="opphi_block",
)
add(
    ("opphi", "induction"),
    OPHI_HEADER
    + "%id         = OpVariable %uvec3ptr Input\n"
    "%zero       = OpConstant %i32 0\n"
    "%one        = OpConstant %i32 1\n"
    "%three      = OpConstant %i32 3\n"
    "%constf6p5  = OpConstant %f32 6.5\n"
    "%main       = OpFunction %void None %voidf\n"
    "%entry      = OpLabel\n"
    "%idval      = OpLoad %uvec3 %id\n"
    "%x          = OpCompositeExtract %u32 %idval 0\n"
    "%inloc      = OpAccessChain %f32ptr %indata %zero %x\n"
    "%outloc     = OpAccessChain %f32ptr %outdata %zero %x\n"
    "%inval      = OpLoad %f32 %inloc\n"
    "              OpBranch %phi\n"
    "%phi        = OpLabel\n"
    "%step       = OpPhi %i32 %zero  %entry %step_next  %phi\n"
    "%accum      = OpPhi %f32 %inval %entry %accum_next %phi\n"
    "%step_next  = OpIAdd %i32 %step %one\n"
    "%accum_next = OpFAdd %f32 %accum %constf6p5\n"
    "%still_loop = OpSLessThan %bool %step %three\n"
    "              OpLoopMerge %exit %phi None\n"
    "              OpBranchConditional %still_loop %phi %exit\n"
    "%exit       = OpLabel\n"
    "              OpStore %outloc %accum\n"
    "              OpReturn\n"
    "              OpFunctionEnd\n",
    "opphi",
    lo=-300,
    hi=300,
    kind="opphi_induction",
)
add(
    ("opphi", "swap"),
    OPHI_HEADER
    + "%f32ptr_f   = OpTypePointer Function %f32\n"
    "%id         = OpVariable %uvec3ptr Input\n"
    "%true       = OpConstantTrue %bool\n"
    "%false      = OpConstantFalse %bool\n"
    "%zero       = OpConstant %i32 0\n"
    "%constf8p5  = OpConstant %f32 8.5\n"
    "%main       = OpFunction %void None %voidf\n"
    "%entry      = OpLabel\n"
    "%b          = OpVariable %f32ptr_f Function %constf8p5\n"
    "%idval      = OpLoad %uvec3 %id\n"
    "%x          = OpCompositeExtract %u32 %idval 0\n"
    "%inloc      = OpAccessChain %f32ptr %indata %zero %x\n"
    "%outloc     = OpAccessChain %f32ptr %outdata %zero %x\n"
    "%a_init     = OpLoad %f32 %inloc\n"
    "%b_init     = OpLoad %f32 %b\n"
    "              OpBranch %phi\n"
    "%phi        = OpLabel\n"
    "%still_loop = OpPhi %bool %true   %entry %false  %phi\n"
    "%a_next     = OpPhi %f32  %a_init %entry %b_next %phi\n"
    "%b_next     = OpPhi %f32  %b_init %entry %a_next %phi\n"
    "              OpLoopMerge %exit %phi None\n"
    "              OpBranchConditional %still_loop %phi %exit\n"
    "%exit       = OpLabel\n"
    "%sub        = OpFSub %f32 %a_next %b_next\n"
    "              OpStore %outloc %sub\n"
    "              OpReturn\n"
    "              OpFunctionEnd\n",
    "opphi",
    lo=-300,
    hi=300,
    kind="opphi_swap",
)
add(
    ("opphi", "wide"),
    OPHI_STD450_HEADER
    + "OpSource GLSL 430\n"
    + NAMES.replace("%main           ", "%main ").replace("%id             ", "%id ")
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%id       = OpVariable %uvec3ptr Input\n"
    "%zero     = OpConstant %i32 0\n"
    f"%cimod    = OpConstant %u32 {OPHI_WIDTH}\n"
    + "".join(f"%cf{i * 10 + 5} = OpConstant %f32 {i * 10 + 5}.0\n" for i in range(OPHI_WIDTH))
    + "\n"
    "%main     = OpFunction %void None %voidf\n"
    "%entry    = OpLabel\n"
    "%idval    = OpLoad %uvec3 %id\n"
    "%x        = OpCompositeExtract %u32 %idval 0\n"
    "%inloc    = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval    = OpLoad %f32 %inloc\n"
    "%xf       = OpConvertUToF %f32 %x\n"
    "%xm       = OpFMul %f32 %xf %inval\n"
    "%xa       = OpExtInst %f32 %ext FAbs %xm\n"
    "%xi       = OpConvertFToU %u32 %xa\n"
    "%selector = OpUMod %u32 %xi %cimod\n"
    "            OpSelectionMerge %phi None\n"
    "            OpSwitch %selector %default "
    + "".join(f" {i} %case{i}" for i in range(OPHI_WIDTH))
    + "\n"
    "%default  = OpLabel\n"
    "            OpUnreachable\n"
    + "".join(f"%case{i} = OpLabel\n            OpBranch %phi\n" for i in range(OPHI_WIDTH))
    + "\n"
    "%phi      = OpLabel\n"
    "%result   = OpPhi %f32"
    + "".join(f" %cf{i * 10 + 5} %case{i}" for i in range(OPHI_WIDTH))
    + "\n"
    "%outloc   = OpAccessChain %f32ptr %outdata %zero %x\n"
    "            OpStore %outloc %result\n"
    "            OpReturn\n"
    "            OpFunctionEnd\n",
    "opphi",
    lo=-300,
    hi=300,
    kind="opphi_wide",
)
add(
    ("opphi", "nested"),
    OPHI_STD450_HEADER
    + f'%code     = OpString "{OPHI_CODE}"\n'
    "OpSource GLSL 430\n"
    + NAMES.replace("%main           ", "%main ").replace("%id             ", "%id ")
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%id       = OpVariable %uvec3ptr Input\n"
    "%zero     = OpConstant %i32 0\n"
    "%f32_0    = OpConstant %f32 0.0\n"
    "%f32_0_5  = OpConstant %f32 0.5\n"
    "%f32_1    = OpConstant %f32 1.0\n"
    "%f32_1_5  = OpConstant %f32 1.5\n"
    "%f32_2    = OpConstant %f32 2.0\n"
    "%f32_3_5  = OpConstant %f32 3.5\n"
    "%f32_4    = OpConstant %f32 4.0\n"
    "%f32_7_5  = OpConstant %f32 7.5\n"
    "%f32_8    = OpConstant %f32 8.0\n"
    "%f32_15_5 = OpConstant %f32 15.5\n"
    "%f32_16   = OpConstant %f32 16.0\n"
    "%f32_31_5 = OpConstant %f32 31.5\n"
    "%f32_32   = OpConstant %f32 32.0\n"
    "%f32_63_5 = OpConstant %f32 63.5\n"
    "%f32_64   = OpConstant %f32 64.0\n"
    "%f32_127_5 = OpConstant %f32 127.5\n"
    "%f32_128  = OpConstant %f32 128.0\n"
    "%f32_256  = OpConstant %f32 256.0\n"
    "%main     = OpFunction %void None %voidf\n"
    "%entry    = OpLabel\n"
    "%idval    = OpLoad %uvec3 %id\n"
    "%x        = OpCompositeExtract %u32 %idval 0\n"
    "%inloc    = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval    = OpLoad %f32 %inloc\n"
    "%xabs     = OpExtInst %f32 %ext FAbs %inval\n"
    "%x8       = OpFMod %f32 %xabs %f32_256\n"
    "%x7       = OpFMod %f32 %xabs %f32_128\n"
    "%x6       = OpFMod %f32 %xabs %f32_64\n"
    "%x5       = OpFMod %f32 %xabs %f32_32\n"
    "%x4       = OpFMod %f32 %xabs %f32_16\n"
    "%x3       = OpFMod %f32 %xabs %f32_8\n"
    "%x2       = OpFMod %f32 %xabs %f32_4\n"
    "%x1       = OpFMod %f32 %xabs %f32_2\n"
    "%b7       = OpFOrdGreaterThanEqual %bool %x8 %f32_127_5\n"
    "%b6       = OpFOrdGreaterThanEqual %bool %x7 %f32_63_5\n"
    "%b5       = OpFOrdGreaterThanEqual %bool %x6 %f32_31_5\n"
    "%b4       = OpFOrdGreaterThanEqual %bool %x5 %f32_15_5\n"
    "%b3       = OpFOrdGreaterThanEqual %bool %x4 %f32_7_5\n"
    "%b2       = OpFOrdGreaterThanEqual %bool %x3 %f32_3_5\n"
    "%b1       = OpFOrdGreaterThanEqual %bool %x2 %f32_1_5\n"
    "%b0       = OpFOrdGreaterThanEqual %bool %x1 %f32_0_5\n"
    + generate_opphi_case5(OPHI_CODE)
    + "%outloc   = OpAccessChain %f32ptr %outdata %zero %x\n"
    "            OpStore %outloc %res\n"
    "            OpReturn\n"
    "            OpFunctionEnd\n",
    "opphi",
    lo=-300,
    hi=300,
    kind="opphi_nested",
)


# localsize, localsize_id: the local size from an execution mode, the WorkgroupSize builtin, or both (spec constants keep their defaults)
def local_size_assembly(use_id, exec_type, wg_type, work_group_size, ndx):
    out = "OpCapability Shader\nOpMemoryModel Logical GLSL450\n"
    out += 'OpEntryPoint GLCompute %main "main" %id %indata %outdata\n' if use_id else 'OpEntryPoint GLCompute %main "main" %id\n'
    exec_value = (9, 13, 106) if wg_type != "none" else work_group_size
    if exec_type != "none":
        if use_id:
            out += "OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2\n"
        else:
            out += f"OpExecutionMode %main LocalSize {exec_value[0]} {exec_value[1]} {exec_value[2]}\n"
    out += 'OpSource GLSL 430\nOpName %main           "main"\nOpName %id             "gl_GlobalInvocationID"\nOpDecorate %id BuiltIn GlobalInvocationId\n'
    if exec_type == "specid":
        out += "OpDecorate %emv_0 SpecId 100\nOpDecorate %emv_1 SpecId 101\nOpDecorate %emv_2 SpecId 102\n"
    if wg_type == "specid":
        out += "OpDecorate %wgs_0 SpecId 200\nOpDecorate %wgs_1 SpecId 201\nOpDecorate %wgs_2 SpecId 202\n"
    if wg_type != "none":
        out += "OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize\n"
    block_dec = "Block" if use_id else "BufferBlock"
    block_sc = "StorageBuffer" if use_id else "Uniform"
    out += input_output_buffer_traits(block_dec) + common_types(block_sc) + input_output_buffer(block_sc)
    if use_id and exec_type != "none":
        op = "OpConstant" if exec_type == "literal" else "OpSpecConstant"
        out += "".join(f"%emv_{axis}  = {op} %u32 {exec_value[axis]}\n" for axis in range(3))
    out += "%id        = OpVariable %uvec3ptr Input\n%zero      = OpConstant %i32 0 \n"
    if wg_type != "none":
        op = "OpConstant" if wg_type == "literal" else "OpSpecConstant"
        composite = "OpConstantComposite" if wg_type == "literal" else "OpSpecConstantComposite"
        out += "".join(f"%wgs_{axis}  = {op} %u32 {work_group_size[axis]}\n" for axis in range(3))
        out += f"%gl_WorkGroupSize = {composite} %uvec3 %wgs_0 %wgs_1 %wgs_2\n"
    out += (
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        f"%ndx       = OpCompositeExtract %u32 %idval {ndx}\n"
        "%inloc     = OpAccessChain %f32ptr %indata %zero %ndx\n"
        "%inval     = OpLoad %f32 %inloc\n"
        "%neg       = OpFNegate %f32 %inval\n"
        "%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx\n"
        "             OpStore %outloc %neg\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n"
    )
    return out


LOCAL_SIZE_ELEMENTS = 64
for use_id in (False, True):
    group = "localsize_id" if use_id else "localsize"
    for suffix, groups, local_size, ndx in [
        ("", LOCAL_SIZE_ELEMENTS, (1, 1, 1), 0),
        ("_x", 1, (LOCAL_SIZE_ELEMENTS, 1, 1), 0),
        ("_y", 1, (1, LOCAL_SIZE_ELEMENTS, 1), 1),
        ("_z", 1, (1, 1, LOCAL_SIZE_ELEMENTS), 2),
    ]:
        for exec_type in ("none", "literal", "specid"):
            for wg_type in ("none", "literal", "specid"):
                if exec_type == "none" and wg_type == "none":
                    continue
                if exec_type == "specid" and not use_id:
                    continue
                add(
                    (group, f"{exec_type}_wgsize_{wg_type}{suffix}"),
                    local_size_assembly(use_id, exec_type, wg_type, local_size, ndx),
                    group,
                    elements=LOCAL_SIZE_ELEMENTS,
                    workgroups=groups,
                    extensions="VK_KHR_maintenance4" if use_id else "",
                    spirv="spirv1.5" if use_id else None,
                    kind="negate_spirv15" if use_id else "negate",
                )


# opatomic, opatomic_storage_buffer, opatomic_return_values, opatomic_storage_buffer_volatile
ATOMIC_CASES = [
    ("iadd", "%retv      = OpAtomicIAdd %i32 %outloc {SCOPE} {SEMANTICS} %inval\n", "             OpStore %retloc %retv\n", 1, False),
    ("isub", "%retv      = OpAtomicISub %i32 %outloc {SCOPE} {SEMANTICS} %inval\n", "             OpStore %retloc %retv\n", 1, False),
    ("iinc", "%retv      = OpAtomicIIncrement %i32 %outloc {SCOPE} {SEMANTICS}\n", "             OpStore %retloc %retv\n", 1, False),
    ("idec", "%retv      = OpAtomicIDecrement %i32 %outloc {SCOPE} {SEMANTICS}\n", "             OpStore %retloc %retv\n", 1, False),
    (
        "load",
        "%inval2    = OpAtomicLoad %i32 %inloc {SCOPE} {SEMANTICS}\n             OpStore %outloc %inval2\n",
        "",
        0,
        True,
    ),
    ("store", "             OpAtomicStore %outloc {SCOPE} {SEMANTICS} %inval\n", "", 0, True),
    (
        "compex",
        "%even      = OpSMod %i32 %inval %two\n"
        "             OpStore %outloc %even\n"
        "%retv      = OpAtomicCompareExchange %i32 %outloc {SCOPE} {SEMANTICS} {SEMANTICS} %minusone %zero\n",
        "              OpStore %retloc %retv\n",
        0,
        False,
    ),
]


def atomic_assembly(use_storage_buffer, volatile, verify_return_values, instruction, retval_assembly, single_output):
    block_decoration = "Block" if use_storage_buffer else "BufferBlock"
    block_pointer = "StorageBuffer" if use_storage_buffer else "Uniform"
    scope, semantics = ("%five", "%volbit") if volatile else ("%one", "%zero")
    instruction = instruction.replace("{SCOPE}", scope).replace("{SEMANTICS}", semantics)
    ret_decorate = ret_decl = ret_assembly = ""
    if verify_return_values:
        ret_decorate = f"\nOpDecorate %retbuf {block_decoration}\nOpDecorate %ret DescriptorSet 0\nOpDecorate %ret Binding 2\nOpMemberDecorate %retbuf 0 Offset 0\n\n"
        ret_decl = f"\n%retbuf    = OpTypeStruct %i32arr\n%retbufptr = OpTypePointer {block_pointer} %retbuf\n%ret       = OpVariable %retbufptr {block_pointer}\n\n"
        ret_assembly = "%retloc    = OpAccessChain %i32ptr %ret %zero %x\n" + retval_assembly
    return (
        "OpCapability Shader\n"
        + ("OpCapability VulkanMemoryModelKHR\n" if volatile else "")
        + ('OpExtension "SPV_KHR_storage_buffer_storage_class"\n' if use_storage_buffer else "")
        + ('OpExtension "SPV_KHR_vulkan_memory_model"\n' if volatile else "")
        + ("OpMemoryModel Logical VulkanKHR\n" if volatile else "OpMemoryModel Logical GLSL450\n")
        + 'OpEntryPoint GLCompute %main "main" %id\n'
        "OpExecutionMode %main LocalSize 1 1 1\n"
        "OpSource GLSL 430\n"
        + NAMES
        + DECORATE_ID
        + f"OpDecorate %buf {block_decoration}\n"
        "OpDecorate %indata DescriptorSet 0\n"
        "OpDecorate %indata Binding 0\n"
        "OpDecorate %i32arr ArrayStride 4\n"
        "OpMemberDecorate %buf 0 Offset 0\n"
        f"OpDecorate %sumbuf {block_decoration}\n"
        "OpDecorate %sum DescriptorSet 0\n"
        "OpDecorate %sum Binding 1\n"
        "OpMemberDecorate %sumbuf 0 Offset 0\n"
        + ret_decorate
        + common_types(block_pointer)
        + "%buf       = OpTypeStruct %i32arr\n"
        f"%bufptr    = OpTypePointer {block_pointer} %buf\n"
        f"%indata    = OpVariable %bufptr {block_pointer}\n"
        "%sumbuf    = OpTypeStruct %i32arr\n"
        f"%sumbufptr = OpTypePointer {block_pointer} %sumbuf\n"
        f"%sum       = OpVariable %sumbufptr {block_pointer}\n"
        + ret_decl
        + "%id        = OpVariable %uvec3ptr Input\n"
        "%minusone  = OpConstant %i32 -1\n"
        "%zero      = OpConstant %i32 0\n"
        "%one       = OpConstant %u32 1\n"
        "%two       = OpConstant %i32 2\n"
        "%five      = OpConstant %i32 5\n"
        "%volbit    = OpConstant %i32 32768\n"
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        "%inloc     = OpAccessChain %i32ptr %indata %zero %x\n"
        "%inval     = OpLoad %i32 %inloc\n"
        f"%outloc    = OpAccessChain %i32ptr %sum %zero {'%zero' if single_output else '%x'}\n"
        + instruction
        + ret_assembly
        + "             OpReturn\n"
        "             OpFunctionEnd\n"
    )


for group, use_sb, elements, ret, volatile in [
    ("opatomic", False, 65535, False, False),
    ("opatomic_storage_buffer", True, 65535, False, False),
    ("opatomic_return_values", False, 1024, True, False),
    ("opatomic_storage_buffer_volatile", True, 65535, False, True),
]:
    for index, (name, instruction, retval, single, skipped_with_ret) in enumerate(ATOMIC_CASES):
        if ret and skipped_with_ret:
            continue
        # the single-output cases above write element 0; load, store and compex write one element per invocation
        single_output = name in ("iadd", "isub", "iinc", "idec")
        kind_prefix = "atomic_vol_" if volatile else "atomic_ret_" if ret else "atomic_"
        add(
            (group, name),
            atomic_assembly(use_sb, volatile, ret, instruction, retval, single_output),
            str(index),
            lo=1,
            hi=100,
            elements=elements,
            kind=kind_prefix + name,
            spirv13=volatile,
            extensions=",".join(
                ext for ext in ("VK_KHR_storage_buffer_storage_class" if use_sb else "", "VK_KHR_vulkan_memory_model" if volatile else "") if ext
            ),
        )


# decoration_group: five inputs summed, with the decorations of the buffers coming through decoration groups
add(
    ("decoration_group", "all"),
    preamble()
    + "OpSource GLSL 430\n"
    'OpName %main "main"\n'
    'OpName %id "gl_GlobalInvocationID"\n'
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "OpDecorate %f32arr ArrayStride 4\n"
    "OpDecorate %groups BufferBlock\n"
    "OpDecorate %groupm Offset 0\n"
    "%groups = OpDecorationGroup\n"
    "%groupm = OpDecorationGroup\n"
    "OpGroupDecorate %groups %outbuf %inbuf0 %inbuf1 %inbuf2 %inbuf3 %inbuf4\n"
    "OpGroupMemberDecorate %groupm %outbuf 0 %inbuf0 0 %inbuf1 0 %inbuf2 0 %inbuf3 0 %inbuf4 0\n"
    "OpDecorate %group1 DescriptorSet 0\n"
    "OpDecorate %group3 DescriptorSet 0\n"
    "OpDecorate %group3 NonWritable\n"
    "OpDecorate %group3 Restrict\n"
    "%group0 = OpDecorationGroup\n"
    "%group1 = OpDecorationGroup\n"
    "%group3 = OpDecorationGroup\n"
    "OpGroupDecorate %group1 %outdata\n"
    "OpGroupDecorate %group1 %outdata\n"
    "OpGroupDecorate %group1 %outdata\n"
    "OpDecorate %outdata DescriptorSet 0\n"
    "OpDecorate %outdata Binding 5\n"
    "OpGroupDecorate %group0 %indata0\n"
    "OpDecorate %indata0 DescriptorSet 0\n"
    "OpDecorate %indata0 Binding 0\n"
    "OpGroupDecorate %group1 %indata1\n"
    "OpDecorate %indata1 Binding 1\n"
    "OpGroupDecorate %group3 %indata2 %indata3\n"
    "OpDecorate %indata2 Binding 2\n"
    "OpDecorate %indata3 Binding 3\n"
    "OpGroupDecorate %group0 %indata4\n"
    "OpGroupDecorate %group1 %indata4\n"
    "OpGroupDecorate %group3 %indata4\n"
    "OpDecorate %indata4 Binding 4\n"
    + common_types()
    + "%id   = OpVariable %uvec3ptr Input\n"
    "%zero = OpConstant %i32 0\n"
    "%outbuf    = OpTypeStruct %f32arr\n"
    "%outbufptr = OpTypePointer Uniform %outbuf\n"
    "%outdata   = OpVariable %outbufptr Uniform\n"
    + "".join(
        f"%inbuf{n}    = OpTypeStruct %f32arr\n"
        f"%inbuf{'' if n == 4 else n}ptr = OpTypePointer Uniform %inbuf{n}\n"
        f"%indata{n}   = OpVariable %inbuf{'' if n == 4 else n}ptr Uniform\n"
        for n in range(5)
    )
    + "%main   = OpFunction %void None %voidf\n"
    "%label  = OpLabel\n"
    "%idval  = OpLoad %uvec3 %id\n"
    "%x      = OpCompositeExtract %u32 %idval 0\n"
    + "".join(f"%inloc{n} = OpAccessChain %f32ptr %indata{n} %zero %x\n" for n in range(5))
    + "%outloc = OpAccessChain %f32ptr %outdata %zero %x\n"
    + "".join(f"%inval{n} = OpLoad %f32 %inloc{n}\n" for n in range(5))
    + "%add0   = OpFAdd %f32 %inval0 %inval1\n"
    "%add1   = OpFAdd %f32 %add0 %inval2\n"
    "%add2   = OpFAdd %f32 %add1 %inval3\n"
    "%add    = OpFAdd %f32 %add2 %inval4\n"
    "          OpStore %outloc %add\n"
    "          OpReturn\n"
    "          OpFunctionEnd\n",
    "decoration_group",
    lo=-300,
    hi=300,
    kind="decoration_group",
)


# opquantize, opquantize_vec4: OpQuantizeToF16 over a float or a vec4 per invocation
def quantize_assembly(vec4):
    if vec4:
        return (
            preamble()
            + "OpSource GLSL 430\n"
            + NAMES
            + DECORATE_ID
            + "OpDecorate %fvec4_array ArrayStride 16\n"
            + input_output_buffer_traits()
            + common_types()
            + "%fvec4       = OpTypeVector %f32 4\n"
            "%fvec4_array = OpTypeRuntimeArray %fvec4\n"
            "%fvec4ptr    = OpTypePointer Uniform %fvec4\n"
            "%buf         = OpTypeStruct %fvec4_array\n"
            "%bufptr      = OpTypePointer Uniform %buf\n"
            "%indata      = OpVariable %bufptr Uniform\n"
            "%outdata     = OpVariable %bufptr Uniform\n"
            "%id          = OpVariable %uvec3ptr Input\n"
            "%zero        = OpConstant %i32 0\n"
            "%main        = OpFunction %void None %voidf\n"
            "%label       = OpLabel\n"
            "%idval       = OpLoad %uvec3 %id\n"
            "%x           = OpCompositeExtract %u32 %idval 0\n"
            "%inloc       = OpAccessChain %fvec4ptr %indata %zero %x\n"
            "%inval       = OpLoad %fvec4 %inloc\n"
            "%quant       = OpQuantizeToF16 %fvec4 %inval\n"
            "%outloc      = OpAccessChain %fvec4ptr %outdata %zero %x\n"
            "               OpStore %outloc %quant\n"
            "               OpReturn\n"
            "               OpFunctionEnd\n"
        )
    return (
        preamble()
        + "OpSource GLSL 430\n"
        + NAMES
        + DECORATE_ID
        + input_output_buffer_traits()
        + common_types()
        + input_output_buffer()
        + ID_AND_ZERO
        + "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
        "%inval     = OpLoad %f32 %inloc\n"
        "%quant     = OpQuantizeToF16 %f32 %inval\n"
        "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
        "             OpStore %outloc %quant\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n"
    )


for vec4 in (False, True):
    group = "opquantize_vec4" if vec4 else "opquantize"
    assembly = quantize_assembly(vec4)
    for name, kind, elements in [
        ("infinities", "quantize_infinities", 100),
        ("propagated_nans", "quantize_nans", 100),
        ("flush_to_zero", "quantize_ftz", 100),
        ("exact", "quantize_exact", 200),
        ("rounded", "quantize_rounded", 4),
    ]:
        add((group, name), assembly, group, elements=elements, kind=kind, workgroups=(1 if vec4 else 4) if name == "rounded" else elements // 4 if vec4 else elements)


# conditional_branch: a branch whose two labels are the same, writing only an output buffer
CONDITIONAL_BRANCH_TEMPLATE = (
    "                         OpCapability Shader\n"
    '                    %1 = OpExtInstImport "GLSL.std.450"\n'
    "                         OpMemoryModel Logical GLSL450\n"
    '                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID\n'
    "                         OpExecutionMode %main LocalSize 1 1 1\n"
    "                         OpSource GLSL 430\n"
    "                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId\n"
    "                         OpDecorate %_arr_uint_uint_128 ArrayStride 4\n"
    "                         OpMemberDecorate %Output 0 Offset 0\n"
    "                         OpDecorate %Output BufferBlock\n"
    "                         OpDecorate %dataOutput DescriptorSet 0\n"
    "                         OpDecorate %dataOutput Binding 0\n"
    "                 %void = OpTypeVoid\n"
    "                    %3 = OpTypeFunction %void\n"
    "                 %uint = OpTypeInt 32 0\n"
    "   %_ptr_Function_uint = OpTypePointer Function %uint\n"
    "               %v3uint = OpTypeVector %uint 3\n"
    "    %_ptr_Input_v3uint = OpTypePointer Input %v3uint\n"
    "%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input\n"
    "               %uint_0 = OpConstant %uint 0\n"
    "      %_ptr_Input_uint = OpTypePointer Input %uint\n"
    "                 %bool = OpTypeBool\n"
    "                 %true = OpConstantTrue %bool\n"
    "                %false = OpConstantFalse %bool\n"
    "             %uint_128 = OpConstant %uint 128\n"
    "   %_arr_uint_uint_128 = OpTypeArray %uint %uint_128\n"
    "               %Output = OpTypeStruct %_arr_uint_uint_128\n"
    "  %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
    "           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
    "    %_ptr_Uniform_uint = OpTypePointer Uniform %uint\n"
    "          %uint_unused = OpConstant %uint 2863311530\n"
    "                 %main = OpFunction %void None %3\n"
    "                    %5 = OpLabel\n"
    "                    %i = OpVariable %_ptr_Function_uint Function\n"
    "                   %14 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0\n"
    "                   %15 = OpLoad %uint %14\n"
    "                         OpStore %i %15\n"
    "               %uint_i = OpLoad %uint %i\n"
    "                         OpSelectionMerge %merge None\n"
    "                         OpBranchConditional %{CONDITION} %live %live\n"
    "                 %live = OpLabel\n"
    "                   %31 = OpAccessChain %_ptr_Uniform_uint %dataOutput %uint_0 %uint_i\n"
    "                         OpStore %31 %uint_i\n"
    "                         OpBranch %merge\n"
    "                 %dead = OpLabel\n"
    "                   %35 = OpAccessChain %_ptr_Uniform_uint %dataOutput %uint_0 %uint_i\n"
    "                         OpStore %35 %uint_unused\n"
    "                         OpBranch %merge\n"
    "                %merge = OpLabel\n"
    "                         OpReturn\n"
    "                         OpFunctionEnd\n"
)
for condition in ("true", "false"):
    add(
        ("conditional_branch", f"same_labels_{condition}"),
        CONDITIONAL_BRANCH_TEMPLATE.replace("{CONDITION}", condition),
        "conditional_branch",
        elements=128,
        kind="conditional_branch",
    )


# loop_control dependency_length and dependency_infinite: loop-carried dependencies through a function-local array
LOOP_DEPENDENCY_HEAD = (
    preamble()
    + "OpSource GLSL 430\n"
    'OpName %main "main"\n'
    'OpName %id "gl_GlobalInvocationID"\n'
    + DECORATE_ID
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + "%u32ptr        = OpTypePointer Function %u32\n"
    "%id            = OpVariable %uvec3ptr Input\n"
    "%zero          = OpConstant %i32 0\n"
    "%uzero         = OpConstant %u32 0\n"
    "%fzero         = OpConstant %f32 0\n"
    "%one           = OpConstant %i32 1\n"
    "%four          = OpConstant %u32 4\n"
    "%five          = OpConstant %u32 5\n"
    "%six           = OpConstant %u32 6\n"
    "%elleven       = OpConstant %u32 11\n"
    "%twelve        = OpConstant %u32 12\n"
    "%f32arr12_t    = OpTypeArray %f32 %twelve\n"
    "%f32arr12ptr_t = OpTypePointer Function %f32arr12_t\n"
    "%f32funcptr    = OpTypePointer Function %f32\n"
    "%main          = OpFunction %void None %voidf\n"
    "%entry         = OpLabel\n"
    "%f32arr12      = OpVariable %f32arr12ptr_t Function\n"
    "%i1            = OpVariable %u32ptr Function\n"
    "%i2            = OpVariable %u32ptr Function\n"
    "                 OpStore %i1 %uzero\n"
    "{I2_INIT}"
    "%idval         = OpLoad %uvec3 %id\n"
    "%x             = OpCompositeExtract %u32 %idval 0\n"
    "%inloc         = OpAccessChain %f32ptr %indata %zero %x\n"
    "%inval         = OpLoad %f32 %inloc\n"
    "                 OpBranch %loop1_entry\n"
    "%loop1_entry   = OpLabel\n"
    "%i1_val        = OpLoad %u32 %i1\n"
    "%cmp1_lt       = OpULessThan %bool %i1_val {LOOP1_BOUND}\n"
    "                 OpLoopMerge %loop1_merge %loop1_body {LOOP1_CONTROL}\n"
    "                 OpBranchConditional %cmp1_lt %loop1_body %loop1_merge\n"
    "%loop1_body    = OpLabel\n"
    "%i1_valf32     = OpConvertUToF %f32 %i1_val\n"
    "%mulf1         = OpFMul %f32 %i1_valf32 %inval\n"
    "%outloc1       = OpAccessChain %f32funcptr %f32arr12 %i1_val\n"
    "                 OpStore %outloc1 %mulf1\n"
    "%new1_i        = OpIAdd %u32 %i1_val %one\n"
    "                 OpStore %i1 %new1_i\n"
    "                 OpBranch %loop1_entry\n"
    "%loop1_merge   = OpLabel\n"
)
LOOP_DEPENDENCY_INFINITE = (
    LOOP_DEPENDENCY_HEAD.replace("{I2_INIT}", "                 OpStore %i2 %uzero\n").replace("{LOOP1_BOUND}", "%twelve").replace("{LOOP1_CONTROL}", "DependencyInfinite")
    + "%outloc        = OpAccessChain %f32ptr %outdata %zero %x\n"
    "                 OpStore %outloc %fzero\n"
    "                 OpBranch %loop2_entry\n"
    "%loop2_entry   = OpLabel\n"
    "%i2_val        = OpLoad %u32 %i2\n"
    "%cmp2_lt       = OpULessThan %bool %i2_val %twelve\n"
    "                 OpLoopMerge %loop2_merge %loop2_body None\n"
    "                 OpBranchConditional %cmp2_lt %loop2_body %loop2_merge\n"
    "%loop2_body    = OpLabel\n"
    "%arr1_i2loc    = OpAccessChain %f32funcptr %f32arr12 %i2_val\n"
    "%arr1_i2val    = OpLoad %f32 %arr1_i2loc\n"
    "%outval        = OpLoad %f32 %outloc\n"
    "%addf1         = OpFAdd %f32 %outval %arr1_i2val\n"
    "                 OpStore %outloc %addf1\n"
    "%new_i2        = OpIAdd %u32 %i2_val %one\n"
    "                 OpStore %i2 %new_i2\n"
    "                 OpBranch %loop2_entry\n"
    "%loop2_merge   = OpLabel\n"
    "                 OpReturn\n"
    "                 OpFunctionEnd\n"
)
LOOP_DEPENDENCY_LENGTH = (
    LOOP_DEPENDENCY_HEAD.replace("{I2_INIT}", "                 OpStore %i2 %six\n").replace("{LOOP1_BOUND}", "%six").replace("{LOOP1_CONTROL}", "None")
    + "                 OpBranch %loop2_entry\n"
    "%loop2_entry   = OpLabel\n"
    "%i2_val        = OpLoad %u32 %i2\n"
    "%cmp2_lt       = OpULessThan %bool %i2_val %twelve\n"
    "                 OpLoopMerge %loop2_merge %loop2_body DependencyLength 3\n"
    "                 OpBranchConditional %cmp2_lt %loop2_body %loop2_merge\n"
    "%loop2_body    = OpLabel\n"
    "%i2_m4         = OpISub %u32 %i2_val %four\n"
    "%arr1_i2m4loc  = OpAccessChain %f32funcptr %f32arr12 %i2_m4\n"
    "%arr1_i2m4val  = OpLoad %f32 %arr1_i2m4loc\n"
    "%i2_m5         = OpISub %u32 %i2_val %five\n"
    "%arr1_i2m5loc  = OpAccessChain %f32funcptr %f32arr12 %i2_m5\n"
    "%arr1_i2m5val  = OpLoad %f32 %arr1_i2m5loc\n"
    "%f32add1       = OpFAdd %f32 %arr1_i2m4val %arr1_i2m5val\n"
    "%i2_m6         = OpISub %u32 %i2_val %six\n"
    "%arr1_i2m6loc  = OpAccessChain %f32funcptr %f32arr12 %i2_m6\n"
    "%arr1_i2m6val  = OpLoad %f32 %arr1_i2m6loc\n"
    "%f32add2       = OpFAdd %f32 %f32add1 %arr1_i2m6val\n"
    "%outloc2       = OpAccessChain %f32funcptr %f32arr12 %i2_val\n"
    "                 OpStore %outloc2 %f32add2\n"
    "%new_i2        = OpIAdd %u32 %i2_val %one\n"
    "                 OpStore %i2 %new_i2\n"
    "                 OpBranch %loop2_entry\n"
    "%loop2_merge   = OpLabel\n"
    "%arr1locq      = OpAccessChain %f32funcptr %f32arr12 %elleven\n"
    "%arr1valq      = OpLoad %f32 %arr1locq\n"
    "%outlocq       = OpAccessChain %f32ptr %outdata %zero %x\n"
    "                 OpStore %outlocq %arr1valq\n"
    "                 OpReturn\n"
    "                 OpFunctionEnd\n"
)
add(("loop_control", "dependency_length"), LOOP_DEPENDENCY_LENGTH, "loop_control", kind="loop_dependency_length", spirv13=True)
add(("loop_control", "dependency_infinite"), LOOP_DEPENDENCY_INFINITE, "loop_control", kind="loop_dependency_infinite", spirv13=True)


# composite_insert: vectors, matrices and a nested struct built with OpCompositeInsert, from an undefined or a loaded value
def insert_matrix_declarations(cols, rows):
    col = f"%v{rows}f32"
    mat = f"%mat{cols}v{rows}f"
    return f"                {col} = OpTypeVector %f32 {rows}\n              {mat} = OpTypeMatrix {col} {cols}\n               %Output = OpTypeStruct {mat}\n"


def insert_identity_vectors(cols, rows):
    return "".join(
        f"            %identity{c} = OpConstantComposite %v{rows}f32 " + "".join("%c_f32_" + ("1" if c == r else "0") + " " for r in range(rows)) + "\n"
        for c in range(cols)
    )


def insert_header():
    return (
        "                         OpCapability Shader\n"
        '                    %1 = OpExtInstImport "GLSL.std.450"\n'
        "                         OpMemoryModel Logical GLSL450\n"
        '                         OpEntryPoint GLCompute %main "main"\n'
        "                         OpExecutionMode %main LocalSize 1 1 1\n"
        "                         OpSource GLSL 430\n"
    )


for use_undef in (True, False):
    for elements in (2, 3, 4):
        vec = f"%v{elements}f32"
        inserts = ("                 %tmp0 = OpUndef " + vec + "\n") if use_undef else ("                 %tmp0 = OpLoad " + vec + " %vec\n")
        for e in range(elements):
            inserts += f"                 %tmp{e + 1} = OpCompositeInsert {vec} %c_f32_{e} %tmp{e} {e}\n"
        assembly = (
            insert_header()
            + "                         OpMemberDecorate %Output 0 Offset 0\n"
            "                         OpDecorate %Output BufferBlock\n"
            "                         OpDecorate %dataOutput DescriptorSet 0\n"
            "                         OpDecorate %dataOutput Binding 0\n"
            "                  %f32 = OpTypeFloat 32\n"
            "                %v2f32 = OpTypeVector %f32 2\n"
            "                %v3f32 = OpTypeVector %f32 3\n"
            "                %v4f32 = OpTypeVector %f32 4\n"
            f"               %Output = OpTypeStruct {vec}\n"
            "  %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
            "           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
            f"    %_ptr_Function_vec = OpTypePointer Function {vec}\n"
            f"     %_ptr_Uniform_vec = OpTypePointer Uniform {vec}\n"
            "              %c_f32_0 = OpConstant %f32 0\n"
            "              %c_f32_1 = OpConstant %f32 1\n"
            "              %c_f32_2 = OpConstant %f32 2\n"
            "              %c_f32_3 = OpConstant %f32 3\n"
            "                  %i32 = OpTypeInt 32 1\n"
            "              %c_i32_0 = OpConstant %i32 0\n"
            "                 %void = OpTypeVoid\n"
            "                    %3 = OpTypeFunction %void\n"
            "                 %main = OpFunction %void None %3\n"
            "                %entry = OpLabel\n"
            "                  %vec = OpVariable %_ptr_Function_vec Function\n"
            + inserts
            + "            %vecOutPtr = OpAccessChain %_ptr_Uniform_vec %dataOutput %c_i32_0\n"
            f"                         OpStore %vecOutPtr %tmp{elements}\n"
            "                         OpReturn\n"
            "                         OpFunctionEnd\n"
        )
        add(("composite_insert", ("undef_" if use_undef else "") + f"vec{elements}"), assembly, "composite_insert", elements=elements, workgroups=1, kind="composite_insert_vec")

for use_undef in (True, False):
    for rows in (2, 3, 4):
        matrix_stride = 16 if rows == 3 else rows * 4
        for cols in (2, 3, 4):
            mat = f"%mat{cols}v{rows}f"
            inserts = ("                 %tmp0 = OpUndef " + mat + "\n") if use_undef else ("                 %tmp0 = OpLoad " + mat + " %mat\n")
            for c in range(cols):
                inserts += f"                 %tmp{c + 1} = OpCompositeInsert {mat} %identity{c} %tmp{c} {c}\n"
            assembly = (
                insert_header()
                + "                         OpMemberDecorate %Output 0 Offset 0\n"
                "                         OpMemberDecorate %Output 0 ColMajor\n"
                f"                         OpMemberDecorate %Output 0 MatrixStride {matrix_stride}\n"
                "                         OpDecorate %Output BufferBlock\n"
                "                         OpDecorate %dataOutput DescriptorSet 0\n"
                "                         OpDecorate %dataOutput Binding 0\n"
                "                  %f32 = OpTypeFloat 32\n"
                + insert_matrix_declarations(cols, rows)
                + "  %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
                "           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
                f"    %_ptr_Function_mat = OpTypePointer Function {mat}\n"
                f"     %_ptr_Uniform_mat = OpTypePointer Uniform {mat}\n"
                "              %c_f32_0 = OpConstant %f32 0\n"
                "              %c_f32_1 = OpConstant %f32 1\n"
                "                  %i32 = OpTypeInt 32 1\n"
                "              %c_i32_0 = OpConstant %i32 0\n"
                + insert_identity_vectors(cols, rows)
                + "                 %void = OpTypeVoid\n"
                "                    %3 = OpTypeFunction %void\n"
                "                 %main = OpFunction %void None %3\n"
                "                %entry = OpLabel\n"
                "                  %mat = OpVariable %_ptr_Function_mat Function\n"
                + inserts
                + "            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0\n"
                f"                         OpStore %matOutPtr %tmp{cols}\n"
                "                         OpReturn\n"
                "                         OpFunctionEnd\n"
            )
            add(
                ("composite_insert", ("undef_" if use_undef else "") + f"mat{cols}x{rows}"),
                assembly,
                "composite_insert",
                elements=cols,
                workgroups=1,
                kind=f"composite_insert_mat_{cols}x{rows}",
            )

for use_undef in (True, False):
    array_size = 8
    inserts = "                 %tmp0 = OpUndef %Output\n" if use_undef else "                 %tmp0 = OpLoad %Output %nestedstruct\n"
    for array_idx in range(array_size):
        for vector_idx in range(4):
            inserts += f"%tmp{array_idx * 4 + vector_idx + 1} = OpCompositeInsert %Output %identity{vector_idx} %tmp{array_idx * 4 + vector_idx} 0 0 {array_idx} {vector_idx}\n"
    assembly = (
        insert_header()
        + "                         OpDecorate %_arr_mat4v4f32_uint_8 ArrayStride 64\n"
        "                         OpMemberDecorate %S 0 ColMajor\n"
        "                         OpMemberDecorate %S 0 Offset 0\n"
        "                         OpMemberDecorate %S 0 MatrixStride 16\n"
        "                         OpMemberDecorate %Output 0 Offset 0\n"
        "                         OpDecorate %Output BufferBlock\n"
        "                         OpDecorate %dataOutput DescriptorSet 0\n"
        "                         OpDecorate %dataOutput Binding 0\n"
        "                  %f32 = OpTypeFloat 32\n"
        "                %v4f32 = OpTypeVector %f32 4\n"
        "            %mat4v4f32 = OpTypeMatrix %v4f32 4\n"
        "                 %uint = OpTypeInt 32 0\n"
        "               %uint_8 = OpConstant %uint 8\n"
        "%_arr_mat4v4f32_uint_8 = OpTypeArray %mat4v4f32 %uint_8\n"
        "                    %S = OpTypeStruct %_arr_mat4v4f32_uint_8\n"
        "               %Output = OpTypeStruct %S\n"
        "  %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
        " %_ptr_Function_Output = OpTypePointer Function %Output\n"
        "           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
        "              %c_f32_0 = OpConstant %f32 0\n"
        "              %c_f32_1 = OpConstant %f32 1\n"
        "                  %i32 = OpTypeInt 32 1\n"
        "              %c_i32_0 = OpConstant %i32 0\n"
        + insert_identity_vectors(4, 4)
        + "                 %void = OpTypeVoid\n"
        "                    %3 = OpTypeFunction %void\n"
        "                 %main = OpFunction %void None %3\n"
        "                %entry = OpLabel\n"
        "         %nestedstruct = OpVariable %_ptr_Function_Output Function\n"
        + inserts
        + f"                         OpStore %dataOutput %tmp{array_size * 4}\n"
        "                         OpReturn\n"
        "                         OpFunctionEnd\n"
    )
    add(("composite_insert", ("undef_" if use_undef else "") + "nested_struct"), assembly, "composite_insert", elements=array_size, workgroups=1, kind="composite_insert_nested")


# ubo_padding: an array of mat2x2 read from a uniform buffer, whose columns are padded to 16 bytes
add(
    ("ubo_padding", "mat2x2"),
    "                       OpCapability Shader\n"
    '                  %1 = OpExtInstImport "GLSL.std.450"\n'
    "                       OpMemoryModel Logical GLSL450\n"
    '                       OpEntryPoint GLCompute %main "main" %id\n'
    "                       OpExecutionMode %main LocalSize 1 1 1\n"
    "                       OpSource GLSL 430\n"
    "                       OpDecorate %id BuiltIn GlobalInvocationId\n"
    "                       OpDecorate %_arr_v4 ArrayStride 16\n"
    "                       OpMemberDecorate %Output 0 Offset 0\n"
    "                       OpDecorate %Output BufferBlock\n"
    "                       OpDecorate %dataOutput DescriptorSet 0\n"
    "                       OpDecorate %dataOutput Binding 1\n"
    "                       OpDecorate %_arr_mat2v2 ArrayStride 32\n"
    "                       OpMemberDecorate %Input 0 ColMajor\n"
    "                       OpMemberDecorate %Input 0 Offset 0\n"
    "                       OpMemberDecorate %Input 0 MatrixStride 16\n"
    "                       OpDecorate %Input Block\n"
    "                       OpDecorate %dataInput DescriptorSet 0\n"
    "                       OpDecorate %dataInput Binding 0\n"
    "               %void = OpTypeVoid\n"
    "                  %3 = OpTypeFunction %void\n"
    "                %u32 = OpTypeInt 32 0\n"
    " %_ptr_Function_uint = OpTypePointer Function %u32\n"
    "             %v3uint = OpTypeVector %u32 3\n"
    "  %_ptr_Input_v3uint = OpTypePointer Input %v3uint\n"
    "                 %id = OpVariable %_ptr_Input_v3uint Input\n"
    "                %i32 = OpTypeInt 32 1\n"
    "              %int_0 = OpConstant %i32 0\n"
    "              %int_1 = OpConstant %i32 1\n"
    "             %uint_0 = OpConstant %u32 0\n"
    "             %uint_1 = OpConstant %u32 1\n"
    "             %uint_2 = OpConstant %u32 2\n"
    "             %uint_3 = OpConstant %u32 3\n"
    "    %_ptr_Input_uint = OpTypePointer Input %u32\n"
    "                %f32 = OpTypeFloat 32\n"
    "            %v4float = OpTypeVector %f32 4\n"
    "           %uint_128 = OpConstant %u32 128\n"
    "            %_arr_v4 = OpTypeArray %v4float %uint_128\n"
    "             %Output = OpTypeStruct %_arr_v4\n"
    "%_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
    "         %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
    "            %v2float = OpTypeVector %f32 2\n"
    "        %mat2v2float = OpTypeMatrix %v2float 2\n"
    "        %_arr_mat2v2 = OpTypeArray %mat2v2float %uint_128\n"
    "              %Input = OpTypeStruct %_arr_mat2v2\n"
    " %_ptr_Uniform_Input = OpTypePointer Uniform %Input\n"
    "          %dataInput = OpVariable %_ptr_Uniform_Input Uniform\n"
    " %_ptr_Uniform_float = OpTypePointer Uniform %f32\n"
    "               %main = OpFunction %void None %3\n"
    "                  %5 = OpLabel\n"
    "                  %i = OpVariable %_ptr_Function_uint Function\n"
    "                 %14 = OpAccessChain %_ptr_Input_uint %id %uint_0\n"
    "                 %15 = OpLoad %u32 %14\n"
    "                       OpStore %i %15\n"
    "                %idx = OpLoad %u32 %i\n"
    "                 %34 = OpAccessChain %_ptr_Uniform_float %dataInput %int_0 %idx %int_0 %uint_0\n"
    "                 %35 = OpLoad %f32 %34\n"
    "                 %36 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %idx %uint_0\n"
    "                       OpStore %36 %35\n"
    "                 %40 = OpAccessChain %_ptr_Uniform_float %dataInput %int_0 %idx %int_0 %uint_1\n"
    "                 %41 = OpLoad %f32 %40\n"
    "                 %42 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %idx %uint_1\n"
    "                       OpStore %42 %41\n"
    "                 %46 = OpAccessChain %_ptr_Uniform_float %dataInput %int_0 %idx %int_1 %uint_0\n"
    "                 %47 = OpLoad %f32 %46\n"
    "                 %49 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %idx %uint_2\n"
    "                       OpStore %49 %47\n"
    "                 %52 = OpAccessChain %_ptr_Uniform_float %dataInput %int_0 %idx %int_1 %uint_1\n"
    "                 %53 = OpLoad %f32 %52\n"
    "                 %55 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %idx %uint_3\n"
    "                       OpStore %55 %53\n"
    "                       OpReturn\n"
    "                       OpFunctionEnd\n",
    "ubo_padding",
    elements=128,
    kind="ubo_padding",
)


# empty_struct: copying a struct that holds empty structs, comparing pointers to them and passing them to functions
EMPTY_STRUCT_COPY_TEMPLATE = (
    "OpCapability Shader\n"
    'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %var_id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %var_id BuiltIn GlobalInvocationId\n"
    "OpDecorate %var_input Binding 0\n"
    "OpDecorate %var_input DescriptorSet 0\n"
    "OpDecorate %var_outdata Binding 1\n"
    "OpDecorate %var_outdata DescriptorSet 0\n"
    "OpMemberDecorate %type_container_struct 0 Offset 0\n"
    "OpMemberDecorate %type_container_struct 1 Offset {OFFSET_1}\n"
    "OpMemberDecorate %type_container_struct 2 Offset {OFFSET_2}\n"
    "OpMemberDecorate %type_container_struct 3 Offset {OFFSET_3}\n"
    "OpDecorate %type_container_struct Block\n"
    + common_types()
    + "%type_empty_struct = OpTypeStruct\n"
    "%type_container_struct = OpTypeStruct %i32 %type_empty_struct %type_empty_struct %i32\n"
    "%type_container_struct_ubo_ptr = OpTypePointer Uniform %type_container_struct\n"
    "%type_container_struct_ssbo_ptr = OpTypePointer StorageBuffer %type_container_struct\n"
    "%var_id = OpVariable %uvec3ptr Input\n"
    "{VARIABLES}\n"
    "%main = OpFunction %void None %voidf\n"
    "%label = OpLabel\n"
    "{COPYING_METHOD}"
    "OpReturn\n"
    "OpFunctionEnd\n"
)
EMPTY_STRUCT_BUFFER_TYPES = [
    (
        "ubo",
        (0, 16, 32, 48),
        "%var_input = OpVariable %type_container_struct_ubo_ptr Uniform\n%var_outdata = OpVariable %type_container_struct_ssbo_ptr StorageBuffer\n",
        "%input_copy = OpCopyObject %type_container_struct_ubo_ptr %var_input\n",
    ),
    (
        "ssbo",
        (0, 4, 8, 12),
        "%var_input = OpVariable %type_container_struct_ssbo_ptr StorageBuffer\n%var_outdata = OpVariable %type_container_struct_ssbo_ptr StorageBuffer\n",
        "%input_copy = OpCopyObject %type_container_struct_ssbo_ptr %var_input\n",
    ),
]
EMPTY_STRUCT_COPYING_METHODS = [
    ("copy_object", "%result = OpLoad %type_container_struct %input_copy\nOpStore %var_outdata %result\n"),
    ("copy_memory", "OpCopyMemory %var_outdata %var_input\n"),
]
for buffer_name, offsets, variables, copy_object in EMPTY_STRUCT_BUFFER_TYPES:
    for method_name, copy_code in EMPTY_STRUCT_COPYING_METHODS:
        add(
            ("empty_struct", "copying", f"{method_name}_{buffer_name}"),
            EMPTY_STRUCT_COPY_TEMPLATE.replace("{OFFSET_1}", str(offsets[1]))
            .replace("{OFFSET_2}", str(offsets[2]))
            .replace("{OFFSET_3}", str(offsets[3]))
            .replace("{VARIABLES}", variables)
            .replace("{COPYING_METHOD}", copy_object + copy_code),
            "empty_struct",
            elements=1,
            workgroups=1,
            kind=f"empty_struct_copy_{buffer_name}",
        )

add(
    ("empty_struct", "pointer_comparison", "ssbo"),
    "OpCapability Shader\n"
    "OpCapability VariablePointersStorageBuffer\n"
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %var_id %var_input %var_outdata\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %var_id BuiltIn GlobalInvocationId\n"
    "OpDecorate %var_input Binding 0\n"
    "OpDecorate %var_input DescriptorSet 0\n"
    "OpDecorate %var_outdata Binding 1\n"
    "OpDecorate %var_outdata DescriptorSet 0\n"
    "OpMemberDecorate %type_container_struct 0 Offset 0\n"
    "OpMemberDecorate %type_container_struct 1 Offset 4\n"
    "OpMemberDecorate %type_container_struct 2 Offset 8\n"
    "OpMemberDecorate %type_container_struct 3 Offset 12\n"
    "OpDecorate %type_container_struct Block\n"
    "OpMemberDecorate %type_i32_struct 0 Offset 0\n"
    "OpDecorate %type_i32_struct Block\n"
    + common_types("StorageBuffer")
    + "%type_empty_struct = OpTypeStruct\n"
    "%type_container_struct = OpTypeStruct %i32 %type_empty_struct %type_empty_struct %i32\n"
    "%type_i32_struct = OpTypeStruct %i32\n"
    "%c_i32_0 = OpConstant %i32 0\n"
    "%c_i32_1 = OpConstant %i32 1\n"
    "%c_i32_2 = OpConstant %i32 2\n"
    "%type_container_struct_in_ptr = OpTypePointer StorageBuffer %type_container_struct\n"
    "%type_i32_struct_out_ptr = OpTypePointer StorageBuffer %type_i32_struct\n"
    "%type_func_struct_ptr_ptr = OpTypePointer StorageBuffer %type_empty_struct\n"
    "%var_id = OpVariable %uvec3ptr Input\n"
    "%var_input = OpVariable %type_container_struct_in_ptr StorageBuffer\n"
    "%var_outdata = OpVariable %type_i32_struct_out_ptr StorageBuffer\n"
    "%main = OpFunction %void None %voidf\n"
    "%label = OpLabel\n"
    "%ptr_to_first = OpAccessChain %type_func_struct_ptr_ptr %var_input %c_i32_1\n"
    "%ptr_to_second = OpAccessChain %type_func_struct_ptr_ptr %var_input %c_i32_2\n"
    "%pointers_not_equal = OpPtrNotEqual %bool %ptr_to_first %ptr_to_second\n"
    "%result = OpSelect %i32 %pointers_not_equal %c_i32_1 %c_i32_0\n"
    "%outloc = OpAccessChain %i32ptr %var_outdata %c_i32_0\n"
    "OpStore %outloc %result\n"
    "OpReturn\n"
    "OpFunctionEnd\n",
    "empty_struct",
    elements=1,
    workgroups=1,
    kind="empty_struct_pointer_comparison",
    spirv="spirv1.4",
    extensions="VK_KHR_spirv_1_4",
)

EMPTY_STRUCT_FUNCTION_TEMPLATE = (
    "      OpCapability Shader\n"
    ' %1 = OpExtInstImport "GLSL.std.450"\n'
    "      OpMemoryModel Logical GLSL450\n"
    '      OpEntryPoint GLCompute %4 "main" %29 %42 %51 {GLOBAL_VARIABLE} %79\n'
    "      OpExecutionMode %4 LocalSize 2 1 1\n"
    "      OpSource GLSL 460\n"
    "      OpDecorate %29 BuiltIn LocalInvocationId\n"
    "      OpMemberDecorate %40 0 Offset 0\n"
    "      OpMemberDecorate %40 1 Offset 4\n"
    "      OpMemberDecorate %40 2 Offset 8\n"
    "      OpDecorate %40 Block\n"
    "      OpDecorate %42 DescriptorSet 0\n"
    "      OpDecorate %42 Binding 1\n"
    "      OpMemberDecorate %49 0 Offset 0\n"
    "      OpDecorate %49 Block\n"
    "      OpDecorate %51 DescriptorSet 0\n"
    "      OpDecorate %51 Binding 0\n"
    "      OpMemberDecorate %77 0 Offset 0\n"
    "      OpMemberDecorate %77 1 Offset 4\n"
    "      OpMemberDecorate %77 2 Offset 8\n"
    "      OpDecorate %77 Block\n"
    "      OpDecorate %79 DescriptorSet 0\n"
    "      OpDecorate %79 Binding 2\n"
    "      OpDecorate %96 BuiltIn WorkgroupSize\n"
    " %2 = OpTypeVoid\n"
    " %3 = OpTypeFunction %2\n"
    " %7 = OpTypeStruct\n"
    " %8 = OpTypePointer Function %7\n"
    " %9 = OpTypeBool\n"
    "%10 = OpTypePointer Function %9\n"
    "%11 = OpTypeFunction %7 %8 %8 %10\n"
    "%26 = OpTypeInt 32 0\n"
    "%27 = OpTypeVector %26 3\n"
    "%28 = OpTypePointer Input %27\n"
    "%29 = OpVariable %28 Input\n"
    "%30 = OpConstant %26 0\n"
    "%31 = OpTypePointer Input %26\n"
    "%34 = OpConstant %26 2\n"
    "%39 = OpTypeStruct\n"
    "%40 = OpTypeStruct %26 %39 %26\n"
    "%41 = OpTypePointer StorageBuffer %40\n"
    "%42 = OpVariable %41 StorageBuffer\n"
    "%43 = OpTypeInt 32 1\n"
    "%44 = OpConstant %43 0\n"
    "%45 = OpConstant %26 1\n"
    "%46 = OpTypePointer StorageBuffer %26\n"
    "%48 = OpConstant %43 1\n"
    "%49 = OpTypeStruct %39\n"
    "%50 = OpTypePointer StorageBuffer %49\n"
    "%51 = OpVariable %50 StorageBuffer\n"
    "{VARIABLE_DEFINITION}\n"
    "%59 = OpTypePointer StorageBuffer %39\n"
    "%69 = OpConstant %43 2\n"
    "%77 = OpTypeStruct %26 %39 %26\n"
    "%78 = OpTypePointer StorageBuffer %77\n"
    "%79 = OpVariable %78 StorageBuffer\n"
    "%96 = OpConstantComposite %27 %34 %45 %45\n"
    " %4 = OpFunction %2 None %3\n"
    " %5 = OpLabel\n"
    "{VARIABLE_FUNCTION_DEFINITION}\n"
    "%58 = OpVariable %8 Function\n"
    "%63 = OpVariable %8 Function\n"
    "%65 = OpVariable %10 Function\n"
    "%85 = OpVariable %8 Function\n"
    "%89 = OpVariable %8 Function\n"
    "%91 = OpVariable %10 Function\n"
    "%32 = OpAccessChain %31 %29 %30\n"
    "%33 = OpLoad %26 %32\n"
    "%35 = OpUMod %26 %33 %34\n"
    "%36 = OpIEqual %9 %35 %30\n"
    "      OpSelectionMerge %38 None\n"
    "      OpBranchConditional %36 %37 %38\n"
    "%37 = OpLabel\n"
    "%47 = OpAccessChain %46 %42 %44\n"
    "      OpStore %47 %45\n"
    "%54 = OpAccessChain %31 %29 %30\n"
    "%55 = OpLoad %26 %54\n"
    "%56 = OpUMod %26 %55 %34\n"
    "%57 = OpIEqual %9 %56 %30\n"
    "%60 = OpAccessChain %59 %51 %44\n"
    "%61 = OpLoad %39 %60\n"
    "%62 = OpCopyLogical %7 %61\n"
    "      OpStore %58 %62\n"
    "%64 = OpLoad %7 %53\n"
    "      OpStore %63 %64\n"
    "      OpStore %65 %57\n"
    "%66 = OpFunctionCall %7 %15 %58 %63 %65\n"
    "%67 = OpAccessChain %59 %42 %48\n"
    "%68 = OpCopyLogical %39 %66\n"
    "      OpStore %67 %68\n"
    "%70 = OpAccessChain %46 %42 %69\n"
    "      OpStore %70 %45\n"
    "      OpBranch %38\n"
    "%38 = OpLabel\n"
    "%71 = OpAccessChain %31 %29 %30\n"
    "%72 = OpLoad %26 %71\n"
    "%73 = OpUMod %26 %72 %34\n"
    "%74 = OpIEqual %9 %73 %45\n"
    "      OpSelectionMerge %76 None\n"
    "      OpBranchConditional %74 %75 %76\n"
    "%75 = OpLabel\n"
    "%80 = OpAccessChain %46 %79 %44\n"
    "      OpStore %80 %45\n"
    "%81 = OpAccessChain %31 %29 %30\n"
    "%82 = OpLoad %26 %81\n"
    "%83 = OpUMod %26 %82 %34\n"
    "%84 = OpIEqual %9 %83 %45\n"
    "%86 = OpAccessChain %59 %51 %44\n"
    "%87 = OpLoad %39 %86\n"
    "%88 = OpCopyLogical %7 %87\n"
    "      OpStore %85 %88\n"
    "%90 = OpLoad %7 %53\n"
    "      OpStore %89 %90\n"
    "      OpStore %91 %84\n"
    "%92 = OpFunctionCall %7 %15 %85 %89 %91\n"
    "%93 = OpAccessChain %59 %79 %48\n"
    "%94 = OpCopyLogical %39 %92\n"
    "      OpStore %93 %94\n"
    "%95 = OpAccessChain %46 %79 %69\n"
    "      OpStore %95 %45\n"
    "      OpBranch %76\n"
    "%76 = OpLabel\n"
    "      OpReturn\n"
    "      OpFunctionEnd\n"
    "%15 = OpFunction %7 None %11\n"
    "%12 = OpFunctionParameter %8\n"
    "%13 = OpFunctionParameter %8\n"
    "%14 = OpFunctionParameter %10\n"
    "%16 = OpLabel\n"
    "%17 = OpLoad %9 %14\n"
    "      OpSelectionMerge %19 None\n"
    "      OpBranchConditional %17 %18 %22\n"
    "%18 = OpLabel\n"
    "%20 = OpLoad %7 %12\n"
    "      OpReturnValue %20\n"
    "%22 = OpLabel\n"
    "%23 = OpLoad %7 %13\n"
    "      OpReturnValue %23\n"
    "%19 = OpLabel\n"
    "      OpUnreachable\n"
    "      OpFunctionEnd\n"
)
for name, global_variable, definition, function_definition in [
    ("global_variable_private", "%53", "%52 = OpTypePointer Private %7\n%53 = OpVariable %52 Private\n", ""),
    ("global_variable_shared", "%53", "%52 = OpTypePointer Workgroup %7\n%53 = OpVariable %52 Workgroup\n", ""),
    ("local_variable", "", "", "%53 = OpVariable %8 Function\n"),
]:
    add(
        ("empty_struct", "function", name),
        EMPTY_STRUCT_FUNCTION_TEMPLATE.replace("{GLOBAL_VARIABLE}", global_variable)
        .replace("{VARIABLE_DEFINITION}", definition)
        .replace("{VARIABLE_FUNCTION_DEFINITION}", function_definition),
        "empty_struct",
        elements=1,
        workgroups=2,
        kind="empty_struct_function",
        spirv="spirv1.4",
        extensions="VK_KHR_spirv_1_4",
    )


# variable_init.private: a Private variable initialised from a constant or from a Workgroup variable
VARIABLE_INIT_COMMON = (
    "                      %f32_1 = OpConstant %f32 1\n"
    "                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1\n"
    "                     %matrix = OpTypeMatrix %v4f32 2\n"
    "                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1\n"
    "                    %c_u32_8 = OpConstant %u32 8\n"
    "                 %floatArray = OpTypeArray %f32 %c_u32_8\n"
    "               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1\n"
    "                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32\n"
    "                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1\n"
    "                %numElements = OpConstant %u32 {COUNT}\n"
    "                %outputArray = OpTypeArray %{TYPE} %numElements\n"
    "                     %Output = OpTypeStruct %outputArray\n"
    "                %_ptr_Output = OpTypePointer StorageBuffer %Output\n"
    "                      %sbPtr = OpTypePointer StorageBuffer %{TYPE}\n"
    "                 %dataOutput = OpVariable %_ptr_Output StorageBuffer\n"
)
VARIABLE_INIT_GLOBALS = "        %_ptr_{TYPE}_global = OpTypePointer Workgroup %{TYPE}\n{WORKGROUP_VAR_DECL}"
VARIABLE_INIT_PARAMS = [
    ("float", "f32", 1, False),
    ("vec4", "v4f32", 4, False),
    ("matrix", "matrix", 8, False),
    ("floatarray", "floatArray", 8, False),
    ("struct", "struct", 16, False),
    ("float_from_workgroup", "f32", 1, True),
    ("vec4_from_workgroup", "v4f32", 4, True),
    ("floatarray_from_workgroup", "floatArray", 8, True),
    ("struct_from_workgroup", "struct", 16, True),
]
for name, vtype, components, from_global in VARIABLE_INIT_PARAMS:
    count = 128 // components
    capabilities = extensions = entry_points = extra_decorations = workgroup_var_decl = ""
    explicit_layout = name in ("struct_from_workgroup", "floatarray_from_workgroup")
    if not from_global:
        variable_init = f"             %f1 = OpVariable %dataPtr Private %{vtype}_1\n"
        data_load = f"     %outputData = OpLoad %{vtype} %f1\n"
    else:
        capabilities = "                   OpCapability VariablePointers\n"
        extensions = '                   OpExtension "SPV_KHR_variable_pointers"\n'
        workgroup_var_decl = f"           %{vtype}_global_1 = OpVariable %_ptr_{vtype}_global Workgroup\n"
        variable_init = f"     %dataPtrPtr = OpTypePointer Private %_ptr_{vtype}_global\n             %f1 = OpVariable %dataPtrPtr Private %{vtype}_global_1\n"
        data_load = (
            f"  %outputDataPtr = OpLoad %_ptr_{vtype}_global %f1\n"
            f"                   OpStore %{vtype}_global_1 %{vtype}_1\n"
            f"     %outputData = OpLoad %{vtype} %outputDataPtr\n"
        )
    if vtype == "matrix":
        extra_decorations += "                         OpMemberDecorate %Output 0 ColMajor\n                         OpMemberDecorate %Output 0 MatrixStride 16\n"
    if explicit_layout:
        entry_points += f" %dataOutput %f1 %{vtype}_global_1"
        extensions += '                   OpExtension "SPV_KHR_workgroup_memory_explicit_layout"\n'
        capabilities += "                   OpCapability WorkgroupMemoryExplicitLayoutKHR\n"
        extra_decorations += f"                         OpMemberDecorate %_wg_block_{vtype} 0 Offset 0\n                         OpDecorate %_wg_block_{vtype} Block\n"
        workgroup_var_decl = (
            f"  %_wg_block_{vtype} = OpTypeStruct %{vtype}\n"
            f"%_ptr_wg_block_{vtype} = OpTypePointer Workgroup %_wg_block_{vtype}\n"
            f"           %{vtype}_global_1 = OpVariable %_ptr_wg_block_{vtype} Workgroup\n"
        )
        variable_init = f"     %dataPtrPtr = OpTypePointer Private %_ptr_{vtype}_global\n             %f1 = OpVariable %dataPtrPtr Private\n"
        data_load = (
            f"   %wgMemberPtr = OpAccessChain %_ptr_{vtype}_global %{vtype}_global_1 %int_0\n"
            "                   OpStore %f1 %wgMemberPtr\n"
            f"  %outputDataPtr = OpLoad %_ptr_{vtype}_global %f1\n"
            f"                   OpStore %wgMemberPtr %{vtype}_1\n"
            f"     %outputData = OpLoad %{vtype} %outputDataPtr\n"
        )
    assembly = (
        "                         OpCapability Shader\n"
        + capabilities
        + '                         OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
        + extensions
        + '                    %1 = OpExtInstImport "GLSL.std.450"\n'
        "                         OpMemoryModel Logical GLSL450\n"
        '                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID' + entry_points + "\n"
        "                         OpExecutionMode %main LocalSize 1 1 1\n"
        "                         OpSource GLSL 430\n"
        "                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId\n"
        f"OpDecorate %outputArray ArrayStride {components * 4}\n"
        "                               OpMemberDecorate %Output 0 Offset 0\n"
        "                               OpDecorate %Output Block\n"
        "                               OpDecorate %dataOutput DescriptorSet 0\n"
        "                               OpDecorate %dataOutput Binding 0\n"
        + extra_decorations
        + "                               OpDecorate %floatArray ArrayStride 4\n"
        "                               OpMemberDecorate %struct 0 Offset 0\n"
        "                               OpMemberDecorate %struct 1 Offset 32\n"
        "                               OpMemberDecorate %struct 2 Offset 48\n"
        "                               OpMemberDecorate %struct 3 Offset 52\n"
        "                               OpMemberDecorate %struct 4 Offset 56\n"
        "                               OpMemberDecorate %struct 5 Offset 60\n"
        "                 %void = OpTypeVoid\n"
        "             %voidFunc = OpTypeFunction %void\n"
        "                  %f32 = OpTypeFloat 32\n"
        "                  %u32 = OpTypeInt 32 0\n"
        "              %c_u32_0 = OpConstant %u32 0\n"
        "                %v4f32 = OpTypeVector %f32 4\n"
        + VARIABLE_INIT_COMMON.replace("{COUNT}", str(count)).replace("{TYPE}", vtype)
        + (VARIABLE_INIT_GLOBALS.replace("{TYPE}", vtype).replace("{WORKGROUP_VAR_DECL}", workgroup_var_decl) if from_global else "")
        + f"              %dataPtr = OpTypePointer Private %{vtype}\n"
        "   %_ptr_Function_uint = OpTypePointer Function %u32\n"
        "               %v3uint = OpTypeVector %u32 3\n"
        "    %_ptr_Input_v3uint = OpTypePointer Input %v3uint\n"
        "%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input\n"
        "      %_ptr_Input_uint = OpTypePointer Input %u32\n"
        "                  %int = OpTypeInt 32 1\n"
        "                %int_0 = OpConstant %int 0\n"
        + variable_init
        + "                 %main = OpFunction %void None %voidFunc\n"
        "                %entry = OpLabel\n"
        "        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0\n"
        "           %invocation = OpLoad %u32 %invocationPtr\n"
        + data_load
        + f"            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation\n"
        "                         OpStore %outputPtr %outputData\n"
        "                         OpReturn\n"
        "                         OpFunctionEnd\n"
    )
    extensions_list = ["VK_KHR_storage_buffer_storage_class"]
    if from_global:
        extensions_list.insert(0, "VK_KHR_variable_pointers")
    if explicit_layout:
        extensions_list.insert(1, "VK_KHR_workgroup_memory_explicit_layout")
    add(
        ("variable_init", "private", name),
        assembly,
        "variable_init",
        elements=count,
        kind="variable_init",
        extensions=",".join(extensions_list),
        spirv="spirv1.4" if explicit_layout else None,
    )


# spirv_version: the same negation shader assembled for each SPIR-V version, whose binary header the case checks
for minor in range(7):
    wide = minor > 3
    storage = "StorageBuffer" if wide else "Uniform"
    add(
        ("spirv_version", f"1_{minor}_compute"),
        (preamble(extra_entry_point_arguments="%indata %outdata") if wide else preamble())
        + "OpSource GLSL 430\n"
        + NAMES.replace("%main           ", "%main ").replace("%id             ", "%id ")
        + DECORATE_ID
        + input_output_buffer_traits("Block" if wide else "BufferBlock")
        + common_types(storage)
        + input_output_buffer(storage)
        + ID_AND_ZERO
        + "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        "             OpNop\n"
        "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
        "%inval     = OpLoad %f32 %inloc\n"
        "%neg       = OpFNegate %f32 %inval\n"
        "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
        "             OpStore %outloc %neg\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n",
        str(minor),
        elements=100,
        kind=f"spirv_version_{minor}",
        spirv=f"spirv1.{minor}",
    )


# workgroup_memory: one element type at a time is copied through Workgroup memory and read back in reverse order
WORKGROUP_MEMORY_TEMPLATE = (
    "                                     OpCapability Shader\n"
    "{CAPABILITIES}"
    "{EXTENSIONS}"
    '                                %1 = OpExtInstImport "GLSL.std.450"\n'
    "                                     OpMemoryModel Logical GLSL450\n"
    '                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID\n'
    "                                     OpExecutionMode %main LocalSize 16 4 2\n"
    "                                     OpSource GLSL 430\n"
    "                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId\n"
    "                                     OpDecorate %_arr_uint_128_0 ArrayStride {SIZE_BYTES}\n"
    "                                     OpMemberDecorate %Input 0 Offset 0\n"
    "                                     OpDecorate %Input BufferBlock\n"
    "                                     OpDecorate %dataInput DescriptorSet 0\n"
    "                                     OpDecorate %dataInput Binding 0\n"
    "                                     OpDecorate %_arr_uint_128_1 ArrayStride {SIZE_BYTES}\n"
    "                                     OpMemberDecorate %Output 0 Offset 0\n"
    "                                     OpDecorate %Output BufferBlock\n"
    "                                     OpDecorate %dataOutput DescriptorSet 0\n"
    "                                     OpDecorate %dataOutput Binding 1\n"
    "                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize\n"
    "                             %void = OpTypeVoid\n"
    "                                %3 = OpTypeFunction %void\n"
    "                              %u32 = OpTypeInt 32 0\n"
    "               %_ptr_Function_uint = OpTypePointer Function %u32\n"
    "                           %v3uint = OpTypeVector %u32 3\n"
    "                %_ptr_Input_v3uint = OpTypePointer Input %v3uint\n"
    "             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input\n"
    "                           %uint_2 = OpConstant %u32 2\n"
    "                  %_ptr_Input_uint = OpTypePointer Input %u32\n"
    "                          %uint_64 = OpConstant %u32 64\n"
    "                           %uint_1 = OpConstant %u32 1\n"
    "                          %uint_16 = OpConstant %u32 16\n"
    "                           %uint_0 = OpConstant %u32 0\n"
    "                         %uint_127 = OpConstant %u32 127\n"
    "                           %uint_4 = OpConstant %u32 4\n"
    "                              %i32 = OpTypeInt 32 1\n"
    "{DATA_TYPE_DECL}\n"
    "                         %uint_128 = OpConstant %u32 128\n"
    "                    %_arr_uint_128 = OpTypeArray %{DATA_TYPE} %uint_128\n"
    "     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128\n"
    "                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup\n"
    "                  %_arr_uint_128_0 = OpTypeArray %{DATA_TYPE} %uint_128\n"
    "                            %Input = OpTypeStruct %_arr_uint_128_0\n"
    "               %_ptr_Uniform_Input = OpTypePointer Uniform %Input\n"
    "                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform\n"
    "                            %int_0 = OpConstant %i32 0\n"
    "                     %_ptr_Uniform = OpTypePointer Uniform %{DATA_TYPE}\n"
    "                   %_ptr_Workgroup = OpTypePointer Workgroup %{DATA_TYPE}\n"
    "                         %uint_264 = OpConstant %u32 264\n"
    "                  %_arr_uint_128_1 = OpTypeArray %{DATA_TYPE} %uint_128\n"
    "                           %Output = OpTypeStruct %_arr_uint_128_1\n"
    "              %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
    "                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
    "                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2\n"
    "                             %main = OpFunction %void None %3\n"
    "                                %5 = OpLabel\n"
    "                              %idx = OpVariable %_ptr_Function_uint Function\n"
    "                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2\n"
    "                               %15 = OpLoad %u32 %14\n"
    "                               %17 = OpIMul %u32 %15 %uint_64\n"
    "                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1\n"
    "                               %20 = OpLoad %u32 %19\n"
    "                               %22 = OpIMul %u32 %20 %uint_16\n"
    "                               %23 = OpIAdd %u32 %17 %22\n"
    "                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0\n"
    "                               %26 = OpLoad %u32 %25\n"
    "                               %27 = OpIAdd %u32 %23 %26\n"
    "                                     OpStore %idx %27\n"
    "                               %33 = OpLoad %u32 %idx\n"
    "                               %39 = OpLoad %u32 %idx\n"
    "                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39\n"
    "                               %42 = OpLoad %{DATA_TYPE} %41\n"
    "                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33\n"
    "                                     OpStore %44 %42\n"
    "                                     OpMemoryBarrier %uint_1 %uint_264\n"
    "                                     OpControlBarrier %uint_2 %uint_2 %uint_264\n"
    "                               %50 = OpLoad %u32 %idx\n"
    "                               %52 = OpLoad %u32 %idx\n"
    "                               %53 = OpISub %u32 %uint_127 %52\n"
    "                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53\n"
    "                               %55 = OpLoad %{DATA_TYPE} %54\n"
    "                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50\n"
    "                                     OpStore %56 %55\n"
    "                                     OpReturn\n"
    "                                     OpFunctionEnd\n"
)
CAPS16 = "OpCapability StorageUniformBufferBlock16\n"
EXT16 = 'OpExtension "SPV_KHR_16bit_storage"\n'
EXT8 = 'OpExtension "SPV_KHR_8bit_storage"\n'
CAPS8 = "OpCapability UniformAndStorageBuffer8BitAccess\nOpCapability Int8\n"
for name, size, decl, dtype, capabilities, extension_ops, extensions in [
    ("float64", 8, "%f64 = OpTypeFloat 64", "f64", "OpCapability Float64\n", "", ""),
    ("float32", 4, "%f32 = OpTypeFloat 32", "f32", "", "", ""),
    ("float16", 2, "%f16 = OpTypeFloat 16", "f16", CAPS16 + "OpCapability Float16\n", EXT16, "VK_KHR_16bit_storage,VK_KHR_shader_float16_int8"),
    ("int64", 8, "%i64 = OpTypeInt 64 1", "i64", "OpCapability Int64\n", "", ""),
    ("int32", 4, "", "i32", "", "", ""),
    ("int16", 2, "%i16 = OpTypeInt 16 1", "i16", "OpCapability Int16\n", EXT16, "VK_KHR_16bit_storage"),
    ("int8", 1, "%i8 = OpTypeInt 8 1", "i8", CAPS8, EXT8, "VK_KHR_8bit_storage,VK_KHR_shader_float16_int8"),
    ("uint64", 8, "%u64 = OpTypeInt 64 0", "u64", "OpCapability Int64\n", "", ""),
    ("uint32", 4, "", "u32", "", "", ""),
    ("uint16", 2, "%u16 = OpTypeInt 16 0", "u16", "OpCapability Int16\n", EXT16, "VK_KHR_16bit_storage"),
    ("uint8", 1, "%u8 = OpTypeInt 8 0", "u8", CAPS8, EXT8, "VK_KHR_8bit_storage,VK_KHR_shader_float16_int8"),
]:
    add(
        ("workgroup_memory", name),
        WORKGROUP_MEMORY_TEMPLATE.replace("{CAPABILITIES}", capabilities)
        .replace("{EXTENSIONS}", extension_ops)
        .replace("{SIZE_BYTES}", str(size))
        .replace("{DATA_TYPE_DECL}", decl)
        .replace("{DATA_TYPE}", dtype),
        "workgroup_memory",
        elements=128,
        workgroups=1,
        kind="workgroup_memory",
        extensions=extensions,
        skip=[n for n in ("float64", "float32", "float16", "int64", "int32", "int16", "int8", "uint64", "uint32", "uint16", "uint8")].index(name),
    )


# relaxed_with_forward_reference: DXC output using SPV_KHR_relaxed_extended_instruction, kept verbatim from upstream
add(
    ("relaxed_with_forward_reference", "static_method_shader"),
    (Path(__file__).resolve().parent.parent / "shaders" / "src" / "spirv_assembly" / "relaxed_static_method.spvasm").read_text(encoding="utf-8"),
    "relaxed_with_forward_reference",
    elements=10,
    workgroups=1,
    kind="relaxed_forward_reference",
    spirv="spirv1.6",
    extensions="VK_KHR_shader_non_semantic_info,VK_KHR_shader_relaxed_extended_instruction",
)


# indexing.input.struct: a 32x32 array of mat4 per struct indexed through four selectors of 16, 32 or 64 bits, signed or unsigned
INDEXING_STRUCT_TEMPLATE = (
    "                             OpCapability Shader\n"
    "                             {INTCAPS}\n"
    "                             {VARIABLEPOINTERCAPS}\n"
    "                             {EXTENSIONS}\n"
    '                        %1 = OpExtInstImport "GLSL.std.450"\n'
    "                             OpMemoryModel Logical GLSL450\n"
    '                             OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID\n'
    "                             OpExecutionMode %main LocalSize 1 1 1\n"
    "                             OpSource GLSL 430\n"
    "                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId\n"
    "                             OpDecorate %_arr_float_uint_128 ArrayStride 4\n"
    "                             OpMemberDecorate %Output 0 Offset 0\n"
    "                             OpDecorate %Output BufferBlock\n"
    "                             OpDecorate %dataOutput DescriptorSet 0\n"
    "                             OpDecorate %dataOutput Binding 2\n"
    "                             OpDecorate %_arr_v4float_uint_4 ArrayStride 16\n"
    "                             OpDecorate %_arr_mat4v4float_uint_32 ArrayStride 64\n"
    "                             OpDecorate %_arr__arr_mat4v4float_uint_32_uint_32 ArrayStride 2048\n"
    "                             OpMemberDecorate %InputStruct 0 Offset 0\n"
    "                             OpDecorate %InputStructArr ArrayStride 65536\n"
    "                             OpDecorate %Input {INPUTDECORATION}\n"
    "                             OpMemberDecorate %Input 0 Offset 0\n"
    "                             OpDecorate %dataInput DescriptorSet 0\n"
    "                             OpDecorate %dataInput Binding 0\n"
    "                             OpDecorate %_ptr_buffer_InputStruct ArrayStride 65536\n"
    "                             OpDecorate %_arr_v4uint_uint_128 ArrayStride 16\n"
    "                             OpMemberDecorate %DataSelector 0 Offset 0\n"
    "                             OpDecorate %DataSelector BufferBlock\n"
    "                             OpDecorate %selector DescriptorSet 0\n"
    "                             OpDecorate %selector Binding 1\n"
    "                     %void = OpTypeVoid\n"
    "                        %3 = OpTypeFunction %void\n"
    "                      %u32 = OpTypeInt 32 0\n"
    "                      %i32 = OpTypeInt 32 1\n"
    "{INTDECL}"
    "                    %idx_0 = OpConstant {IDX_INT} 0\n"
    "                    %idx_1 = OpConstant {IDX_INT} 1\n"
    "                    %idx_2 = OpConstant {IDX_INT} 2\n"
    "                    %idx_3 = OpConstant {IDX_INT} 3\n"
    "     %_ptr_Function_uint32 = OpTypePointer Function %u32\n"
    "                 %v3uint32 = OpTypeVector %u32 3\n"
    "      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32\n"
    "    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input\n"
    "        %_ptr_Input_uint32 = OpTypePointer Input %u32\n"
    "                    %float = OpTypeFloat 32\n"
    "                 %uint_128 = OpConstant %u32 128\n"
    "                  %uint_32 = OpConstant %u32 32\n"
    "                   %uint_2 = OpConstant %u32 2\n"
    "                   %uint_4 = OpConstant %u32 4\n"
    "      %_arr_float_uint_128 = OpTypeArray %float %uint_128\n"
    "                   %Output = OpTypeStruct %_arr_float_uint_128\n"
    "      %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
    "               %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
    "                  %v4float = OpTypeVector %float 4\n"
    "      %_arr_v4float_uint_4 = OpTypeArray %v4float %uint_4\n"
    " %_arr_mat4v4float_uint_32 = OpTypeArray %_arr_v4float_uint_4 %uint_32\n"
    " %_arr__arr_mat4v4float_uint_32_uint_32 = OpTypeArray %_arr_mat4v4float_uint_32 %uint_32\n"
    "              %InputStruct = OpTypeStruct %_arr__arr_mat4v4float_uint_32_uint_32\n"
    "           %InputStructArr = OpTypeArray %InputStruct %uint_2\n"
    "                    %Input = OpTypeStruct %InputStructArr\n"
    "        %_ptr_buffer_Input = OpTypePointer {INPUTSTORAGECLASS} %Input\n"
    "                %dataInput = OpVariable %_ptr_buffer_Input {INPUTSTORAGECLASS}\n"
    "  %_ptr_buffer_InputStruct = OpTypePointer {INPUTSTORAGECLASS} %InputStruct\n"
    "                 %v4uint32 = OpTypeVector %u32 4\n"
    "     %_arr_v4uint_uint_128 = OpTypeArray %v4uint32 %uint_128\n"
    "             %DataSelector = OpTypeStruct %_arr_v4uint_uint_128\n"
    "%_ptr_Uniform_DataSelector = OpTypePointer Uniform %DataSelector\n"
    "                 %selector = OpVariable %_ptr_Uniform_DataSelector Uniform\n"
    "      %_ptr_Uniform_uint32 = OpTypePointer Uniform %u32\n"
    "       %_ptr_Uniform_float = OpTypePointer Uniform %float\n"
    "       {PTR_BUFFER_FLOAT}\n"
    "                     %main = OpFunction %void None %3\n"
    "                        %5 = OpLabel\n"
    "                        %i = OpVariable %_ptr_Function_uint32 Function\n"
    "                       %14 = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %idx_0\n"
    "                       %15 = OpLoad %u32 %14\n"
    "                             OpStore %i %15\n"
    "                   %uint_i = OpLoad %u32 %i\n"
    "                       %39 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_0\n"
    "                       %40 = OpLoad %u32 %39\n"
    "                       %43 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_1\n"
    "                       %44 = OpLoad %u32 %43\n"
    "                       %47 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_2\n"
    "                       %48 = OpLoad %u32 %47\n"
    "                       %51 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_3\n"
    "                       %52 = OpLoad %u32 %51\n"
    "                       %i0 = {CONVERT} {IDX_INT} %40\n"
    "                       %i1 = {CONVERT} {IDX_INT} %44\n"
    "                       %i2 = {CONVERT} {IDX_INT} %48\n"
    "                       %i3 = {CONVERT} {IDX_INT} %52\n"
    "        %inputFirstElement = OpAccessChain %_ptr_buffer_InputStruct %dataInput %idx_0 %idx_0\n"
    "                       %54 = {ACCESSCHAIN}\n"
    "                       %55 = OpLoad %float %54\n"
    "                       %56 = OpAccessChain %_ptr_Uniform_float %dataOutput %idx_0 %uint_i\n"
    "                             OpStore %56 %55\n"
    "                             OpReturn\n"
    "                             OpFunctionEnd\n"
)
INDEXING_CHAIN_OPS = [
    ("opaccesschain", "OpAccessChain %_ptr_Uniform_float %inputFirstElement %idx_0 %i0 %i1 %i2 %i3\n", "BufferBlock", "Uniform", False),
    ("opinboundsaccesschain", "OpInBoundsAccessChain %_ptr_Uniform_float %inputFirstElement %idx_0 %i0 %i1 %i2 %i3\n", "BufferBlock", "Uniform", False),
    ("opptraccesschain", "OpPtrAccessChain %_ptr_StorageBuffer_float %inputFirstElement %idx_1 %idx_0 %i0 %i1 %i2 %i3\n", "Block", "StorageBuffer", True),
]
VARIABLE_POINTER_EXTENSIONS = 'OpExtension "SPV_KHR_variable_pointers"\n                             OpExtension "SPV_KHR_storage_buffer_storage_class"'
for chain_name, access_chain, decoration, storage_class, pointers in INDEXING_CHAIN_OPS:
    for idx_size in (16, 32, 64):
        for sign in (0, 1):
            int_caps, convert, int_decl = "", "OpBitcast", ""
            if idx_size == 16:
                int_caps, convert = "OpCapability Int16", "OpSConvert"
                int_decl = "                      %u16 = OpTypeInt 16 0\n                      %i16 = OpTypeInt 16 1\n"
            elif idx_size == 64:
                int_caps, convert = "OpCapability Int64", "OpSConvert"
                int_decl = "                      %u64 = OpTypeInt 64 0\n                      %i64 = OpTypeInt 64 1\n"
            assembly = (
                INDEXING_STRUCT_TEMPLATE.replace("{INTCAPS}", int_caps)
                .replace("{VARIABLEPOINTERCAPS}", "OpCapability VariablePointersStorageBuffer" if pointers else "")
                .replace("{EXTENSIONS}", VARIABLE_POINTER_EXTENSIONS if pointers else "")
                .replace("{INPUTDECORATION}", decoration)
                .replace("{INTDECL}", int_decl)
                .replace("{IDX_INT}", ("%i" if sign else "%u") + str(idx_size))
                .replace("{INPUTSTORAGECLASS}", storage_class)
                .replace("{PTR_BUFFER_FLOAT}", "%_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float" if pointers else "")
                .replace("{CONVERT}", convert)
                .replace("{ACCESSCHAIN}", access_chain)
            )
            for suffix in ("", "_64bit_indexing"):
                add(
                    ("indexing", "input", "struct", f"{chain_name}{'_s' if sign else '_u'}{idx_size}{suffix}"),
                    assembly,
                    "input",
                    elements=128,
                    kind="indexing_struct",
                    extensions="VK_KHR_variable_pointers" if pointers else "",
                )

# indexing.input.non16basealignment: sums of 18 floats per struct, whose 72 byte stride is not a multiple of 16
NON16_FLOAT_ARRAY_SIZE = 18
NON16_FLOAT_ARRAYS = 32
for chain_name, chain_op in [("opaccesschain", "OpAccessChain %_ptr_float_sb %dataInput %uint_0"), ("opptraccesschain", "OpPtrAccessChain %_ptr_float_sb %base")]:
    assembly = (
        "                             OpCapability Shader\n"
        "                             OpCapability VariablePointersStorageBuffer\n"
        f"                             {VARIABLE_POINTER_EXTENSIONS}\n"
        '                        %1 = OpExtInstImport "GLSL.std.450"\n'
        "                             OpMemoryModel Logical GLSL450\n"
        '                             OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID\n'
        "                             OpExecutionMode %main LocalSize 1 1 1\n"
        "                             OpSource GLSL 430\n"
        "                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId\n"
        "                             OpDecorate %input_array ArrayStride 4\n"
        "                             OpDecorate %output_array ArrayStride 4\n"
        f"                             OpDecorate %runtimearr_struct1 ArrayStride {NON16_FLOAT_ARRAY_SIZE * 4}\n"
        f"                             OpDecorate %_ptr_struct1_sb ArrayStride {NON16_FLOAT_ARRAY_SIZE * 4}\n"
        "                             OpMemberDecorate %Output 0 Offset 0\n"
        "                             OpDecorate %Output Block\n"
        "                             OpDecorate %dataOutput DescriptorSet 0\n"
        "                             OpDecorate %dataOutput Binding 1\n"
        "                             OpMemberDecorate %struct0 0 Offset 0\n"
        "                             OpMemberDecorate %struct1 0 Offset 0\n"
        "                             OpDecorate %struct0 Block\n"
        "                             OpDecorate %dataInput DescriptorSet 0\n"
        "                             OpDecorate %dataInput Binding 0\n"
        "                     %void = OpTypeVoid\n"
        "                        %3 = OpTypeFunction %void\n"
        "                      %u32 = OpTypeInt 32 0\n"
        "                      %i32 = OpTypeInt 32 1\n"
        "     %_ptr_Function_uint32 = OpTypePointer Function %u32\n"
        "                 %v3uint32 = OpTypeVector %u32 3\n"
        "      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32\n"
        "    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input\n"
        "        %_ptr_Input_uint32 = OpTypePointer Input %u32\n"
        "                    %float = OpTypeFloat 32\n"
        + "".join(f"%uint_{i} = OpConstant %u32 {i}\n" for i in range(NON16_FLOAT_ARRAY_SIZE + 1))
        + f"                  %uint_{NON16_FLOAT_ARRAYS} = OpConstant %u32 {NON16_FLOAT_ARRAYS}\n"
        f"              %input_array = OpTypeArray %float %uint_{NON16_FLOAT_ARRAY_SIZE}\n"
        f"             %output_array = OpTypeArray %float %uint_{NON16_FLOAT_ARRAYS}\n"
        "                   %Output = OpTypeStruct %output_array\n"
        "           %_ptr_sb_Output = OpTypePointer StorageBuffer %Output\n"
        "               %dataOutput = OpVariable %_ptr_sb_Output StorageBuffer\n"
        "                  %struct1 = OpTypeStruct %input_array\n"
        "       %runtimearr_struct1 = OpTypeRuntimeArray %struct1\n"
        "                  %struct0 = OpTypeStruct %runtimearr_struct1\n"
        "          %_ptr_struct0_sb = OpTypePointer StorageBuffer %struct0\n"
        "          %_ptr_struct1_sb = OpTypePointer StorageBuffer %struct1\n"
        "            %_ptr_float_sb = OpTypePointer StorageBuffer %float\n"
        "                %dataInput = OpVariable %_ptr_struct0_sb StorageBuffer\n"
        "                     %main = OpFunction %void None %3\n"
        "                    %entry = OpLabel\n"
        "                     %base = OpAccessChain %_ptr_struct1_sb %dataInput %uint_0 %uint_0\n"
        "                %invid_ptr = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %uint_0\n"
        "                    %invid = OpLoad %u32 %invid_ptr\n"
        + "".join(
            f"%dataPtr{i} = {chain_op} %invid %uint_0 %uint_{i}\n"
            + ("%acc0 = OpLoad %float %dataPtr0\n" if i == 0 else f"%tmp{i} = OpLoad %float %dataPtr{i}\n%acc{i} = OpFAdd %float %tmp{i} %acc{i - 1}\n")
            for i in range(NON16_FLOAT_ARRAY_SIZE)
        )
        + "                   %outPtr = OpAccessChain %_ptr_float_sb %dataOutput %uint_0 %invid\n"
        f"                             OpStore %outPtr %acc{NON16_FLOAT_ARRAY_SIZE - 1}\n"
        "                             OpReturn\n"
        "                             OpFunctionEnd\n"
    )
    add(
        ("indexing", "input", "non16basealignment", chain_name),
        assembly,
        "input",
        elements=NON16_FLOAT_ARRAYS,
        kind="indexing_non16",
        extensions="VK_KHR_variable_pointers",
    )


# float_controls_extensionless: a float controls execution mode, without the extension, in SPIR-V 1.4 or Vulkan 1.2
for version_group, spirv14 in (("spirv1p4", True), ("vulkan1_2", False)):
    for width in (16, 32, 64):
        for test_name, feature in [
            ("denorm_preserve", "DenormPreserve"),
            ("denorm_flush_to_zero", "DenormFlushToZero"),
            ("signed_zero_inf_nan_preserve", "SignedZeroInfNanPreserve"),
            ("rounding_mode_rte", "RoundingModeRTE"),
            ("rounding_mode_rtz", "RoundingModeRTZ"),
        ]:
            full_name = f"fp{width}_{test_name}"
            add(
                ("float_controls_extensionless", version_group, full_name),
                preamble(f"OpCapability {feature}\n", "", f"OpExecutionMode %main {feature} {width}\n", "", "%indata %outdata")
                + "OpSource GLSL 430\n"
                + NAMES.replace("%main           ", "%main ").replace("%id             ", "%id ")
                + DECORATE_ID
                + input_output_buffer_traits("Block")
                + common_types("StorageBuffer")
                + input_output_buffer("StorageBuffer")
                + ID_AND_ZERO
                + "%main      = OpFunction %void None %voidf\n"
                "%label     = OpLabel\n"
                "%idval     = OpLoad %uvec3 %id\n"
                "%x         = OpCompositeExtract %u32 %idval 0\n"
                "             OpNop\n"
                "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
                "%inval     = OpLoad %f32 %inloc\n"
                "%neg       = OpFNegate %f32 %inval\n"
                "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
                "             OpStore %outloc %neg\n"
                "             OpReturn\n"
                "             OpFunctionEnd\n",
                full_name,
                elements=64,
                kind=f"float_controls_extensionless_{width}_{feature}_{'spirv14' if spirv14 else 'vulkan12'}",
                spirv="spirv1.4",
                extensions=",".join(ext for ext in ("VK_KHR_spirv_1_4" if spirv14 else "", "VK_KHR_shader_float16_int8" if width == 16 else "") if ext),
            )


# 64bit_compare: 64-bit float and integer comparisons over single values or vec4s, from a loop in the shader (compute stage only)
COMPARE64_TEMPLATES = {
    "single": (SPIRV_SOURCES / "compare64_comp_single.spvasm").read_text(encoding="utf-8"),
    "vector": (SPIRV_SOURCES / "compare64_comp_vector.spvasm").read_text(encoding="utf-8"),
}
COMPARE64_OPERANDS = {"double": 20, "int64": 16, "uint64": 12}


def compare64_assembly(data_type, op_name, optype, opcapability, nan_preserve, iterations):
    return (
        COMPARE64_TEMPLATES[data_type]
        .replace("${ITERS}", str(iterations))
        .replace("${OPNAME}", op_name)
        .replace("${OPCAPABILITY}", opcapability)
        .replace("${OPTYPE}", optype)
        .replace("${NANCAP}", "OpCapability SignedZeroInfNanPreserve" if nan_preserve else "")
        .replace("${NANEXT}", 'OpExtension "SPV_KHR_float_controls"' if nan_preserve else "")
        .replace("${NANMODE}", "OpExecutionMode %main SignedZeroInfNanPreserve 64" if nan_preserve else "")
    )


FLOAT_COMPARES = ["Equal", "NotEqual", "LessThan", "LessThanEqual", "GreaterThan", "GreaterThanEqual"]
INT_COMPARES = ["IEqual", "INotEqual", "{S}LessThan", "{S}LessThanEqual", "{S}GreaterThan", "{S}GreaterThanEqual"]
for group, optype, opcapability in [("double", "OpTypeFloat 64", "OpCapability Float64"), ("int64", "OpTypeInt 64 1", "OpCapability Int64"), ("uint64", "OpTypeInt 64 0", "OpCapability Int64")]:
    if group == "double":
        op_names = [f"OpF{kind}{name}" for kind in ("Ord", "Unord") for name in FLOAT_COMPARES]
    else:
        sign = "S" if group == "int64" else "U"
        op_names = ["Op" + name.replace("{S}", sign) for name in INT_COMPARES]
    for data_type in ("single", "vector"):
        for nan_preserve in (False, True) if group == "double" else (False,):
            for op_name in op_names:
                operands = COMPARE64_OPERANDS[group]
                nan_part = ("withnan_" if nan_preserve else "nonan_") if group == "double" else ""
                add(
                    ("64bit_compare", group, f"comp_{op_name.lower()}_{nan_part}{data_type}"),
                    compare64_assembly(data_type, op_name, optype, opcapability, nan_preserve, operands if data_type == "single" else operands // 4),
                    "64bit_compare",
                    elements=operands,
                    workgroups=1,
                    kind=f"compare64_{group}",
                )


# opcompositeinsert, opinboundsaccesschain, shader_default_output: composites of random shape, replaying the group's random draws
NUMBER_TYPES = [("int", "%i32"), ("uint", "%u32"), ("float", "%f32")]


def draw_int(rnd):
    return rnd.get_int(-(2**31), 2**31 - 1)


def draw_number(rnd, number_type):
    if number_type == "int":
        return draw_int(rnd)
    if number_type == "uint":
        return rnd.get_uint32()
    return rnd.get_float()


def number_to_string(value, number_type):
    return "%g" % value if number_type == "float" else str(value)


def number_param(value, number_type):
    return "0x%08x" % struct.unpack("<I", struct.pack("<f", value))[0] if number_type == "float" else str(value)


def repeat(text, times):
    return text * times


def composite_cases(rnd, number_type, custom):
    cases = []
    for width in range(2, 5):
        draw_int(rnd)
        composite_type = f"{custom}vec{width}"
        index = rnd.get_int(0, width - 1)
        filler = f"%filler    = OpConstant {custom} {number_to_string(draw_number(rnd, number_type), number_type)}\n"
        cases.append(
            dict(
                type="vec",
                name=f"vec_{width}",
                compositeDecl=f"{composite_type} = OpTypeVector {custom} {width}\n",
                compositeType=composite_type,
                filler=filler,
                compositeConstruct=f"%instance  = OpCompositeConstruct {composite_type}" + repeat(" %filler", width) + "\n",
                indexes=str(index),
            )
        )
    for width in range(2, 11):
        draw_int(rnd)
        index = rnd.get_int(0, width - 1)
        filler = f"%filler    = OpConstant {custom} {number_to_string(draw_number(rnd, number_type), number_type)}\n"
        cases.append(
            dict(
                type="array",
                name=f"array_{width}",
                compositeDecl=f"%arraywidth = OpConstant %u32 {width}\n%composite = OpTypeArray {custom} %arraywidth\n",
                compositeType="%composite",
                filler=filler,
                compositeConstruct="%instance  = OpCompositeConstruct %composite" + repeat(" %filler", width) + "\n",
                indexes=str(index),
            )
        )
    for width in range(2, 11):
        draw_int(rnd)
        index = rnd.get_int(0, width - 1)
        filler = f"%filler    = OpConstant {custom} {number_to_string(draw_number(rnd, number_type), number_type)}\n"
        cases.append(
            dict(
                type="struct",
                name=f"struct_{width}",
                compositeDecl="%composite = OpTypeStruct" + repeat(f" {custom}", width) + "\n",
                compositeType="%composite",
                filler=filler,
                compositeConstruct="%instance  = OpCompositeConstruct %composite" + repeat(" %filler", width) + "\n",
                indexes=str(index),
            )
        )
    if number_type == "float":
        for width in range(2, 5):
            for column in range(2, 5):
                index_0 = rnd.get_int(0, column - 1)
                index_1 = rnd.get_int(0, width - 1)
                filler = (
                    f"%filler    = OpConstant {custom} {number_to_string(draw_number(rnd, number_type), number_type)}\n"
                    + "%fillerVec = OpConstantComposite %vectype"
                    + repeat(" %filler", width)
                    + "\n"
                )
                cases.append(
                    dict(
                        type="matrix",
                        name=f"matrix_{width}x{column}",
                        compositeDecl=f"%vectype   = OpTypeVector {custom} {width}\n%composite = OpTypeMatrix %vectype {column}\n",
                        compositeType="%composite",
                        filler=filler,
                        compositeConstruct="%instance  = OpCompositeConstruct %composite" + repeat(" %fillerVec", column) + "\n",
                        indexes=f"{index_0} {index_1}",
                    )
                )
    return cases


def composite_shader(custom, case, inbounds_struct=None):
    u32vec3_decl = "" if case["compositeType"] == "%u32vec3" else "%u32vec3   = OpTypeVector %u32 3\n"
    decorator = "OpDecorate %composite ArrayStride 4\n" if case["type"] == "array" else ""
    head = (
        "OpCapability Shader\n"
        "OpCapability Matrix\n"
        "OpMemoryModel Logical GLSL450\n"
        'OpEntryPoint GLCompute %main "main" %id\n'
        "OpExecutionMode %main LocalSize 1 1 1\n"
        "OpSource GLSL 430\n"
        'OpName %main           "main"\n'
        'OpName %id             "gl_GlobalInvocationID"\n'
        "OpDecorate %id BuiltIn GlobalInvocationId\n"
        "OpDecorate %buf BufferBlock\n"
        "OpDecorate %indata DescriptorSet 0\n"
        "OpDecorate %indata Binding 0\n"
        "OpDecorate %outdata DescriptorSet 0\n"
        "OpDecorate %outdata Binding 1\n"
        "OpDecorate %customarr ArrayStride 4\n"
        + decorator
        + "OpMemberDecorate %buf 0 Offset 0\n"
    )
    if inbounds_struct is None:
        return (
            head
            + "%void      = OpTypeVoid\n"
            "%voidf     = OpTypeFunction %void\n"
            "%u32       = OpTypeInt 32 0\n"
            "%i32       = OpTypeInt 32 1\n"
            "%f32       = OpTypeFloat 32\n"
            + case["compositeDecl"]
            + case["filler"]
            + u32vec3_decl
            + "%uvec3ptr  = OpTypePointer Input %u32vec3\n"
            f"%customptr = OpTypePointer Uniform {custom}\n"
            f"%customarr = OpTypeRuntimeArray {custom}\n"
            "%buf       = OpTypeStruct %customarr\n"
            "%bufptr    = OpTypePointer Uniform %buf\n"
            "%indata    = OpVariable %bufptr Uniform\n"
            "%outdata   = OpVariable %bufptr Uniform\n"
            "%id        = OpVariable %uvec3ptr Input\n"
            "%zero      = OpConstant %i32 0\n"
            "%main      = OpFunction %void None %voidf\n"
            "%label     = OpLabel\n"
            "%idval     = OpLoad %u32vec3 %id\n"
            "%x         = OpCompositeExtract %u32 %idval 0\n"
            "%inloc     = OpAccessChain %customptr %indata %zero %x\n"
            "%outloc    = OpAccessChain %customptr %outdata %zero %x\n"
            f"%inval     = OpLoad {custom} %inloc\n"
            + case["compositeConstruct"]
            + f"%instance2 = OpCompositeInsert {case['compositeType']} %inval %instance {case['indexes']}\n"
            f"%out_val   = OpCompositeExtract {custom} %instance2 {case['indexes']}\n"
            "             OpStore %outloc %out_val\n"
            "             OpReturn\n"
            "             OpFunctionEnd\n"
        )
    components, struct_index = inbounds_struct
    full_index = f"{struct_index} {case['indexes']}"
    indexes = full_index.split(" ")
    extract_count = 2 if case["type"] == "matrix" else 1
    extract_indexes = "".join(" " + index for index in indexes[-extract_count:])
    access_indexes = indexes[:-extract_count]
    access_decl = "".join(f"%index_{n}   = OpConstant %u32 {index}\n" for n, index in enumerate(access_indexes))
    access_chain = "".join(f" %index_{n}" for n in range(len(access_indexes)))
    return (
        head
        + "%void      = OpTypeVoid\n"
        "%voidf     = OpTypeFunction %void\n"
        "%i32       = OpTypeInt 32 1\n"
        "%u32       = OpTypeInt 32 0\n"
        "%f32       = OpTypeFloat 32\n"
        + case["compositeDecl"]
        + u32vec3_decl
        + "%uvec3ptr  = OpTypePointer Input %u32vec3\n"
        f"%composite_p = OpTypePointer Function {case['compositeType']}\n"
        "%struct_t  = OpTypeStruct" + repeat(" " + case["compositeType"], components) + "\n"
        "%struct_p  = OpTypePointer Function %struct_t\n"
        + case["filler"]
        + access_decl
        + f"%customptr = OpTypePointer Uniform {custom}\n"
        f"%customarr = OpTypeRuntimeArray {custom}\n"
        "%buf       = OpTypeStruct %customarr\n"
        "%bufptr    = OpTypePointer Uniform %buf\n"
        "%indata    = OpVariable %bufptr Uniform\n"
        "%outdata   = OpVariable %bufptr Uniform\n"
        "%id        = OpVariable %uvec3ptr Input\n"
        "%zero      = OpConstant %u32 0\n"
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%struct_v  = OpVariable %struct_p Function\n"
        "%idval     = OpLoad %u32vec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        "%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x\n"
        "%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x\n"
        f"%inval     = OpLoad {custom} %inloc\n"
        + case["compositeConstruct"]
        + "%struct    = OpCompositeConstruct %struct_t" + repeat(" %instance", components) + "\n"
        f"%comp_obj  = OpCompositeInsert %struct_t %inval %struct {full_index}\n"
        "             OpStore %struct_v %comp_obj\n"
        f"%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v{access_chain}\n"
        f"%read_obj  = OpLoad {case['compositeType']} %inner_ptr\n"
        f"%read_val  = OpCompositeExtract {custom} %read_obj{extract_indexes}\n"
        "             OpStore %outloc %read_val\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n"
    )


def composite_group(group, with_struct):
    rnd = DeRandom(de_string_hash(group))
    for number_type, custom in NUMBER_TYPES:
        for case in composite_cases(rnd, number_type, custom):
            struct_info = None
            if with_struct:
                components = rnd.get_int(2, 8)
                struct_info = (components, rnd.get_int(0, components - 1))
            number = draw_number(rnd, number_type)
            add(
                (group, number_type, case["name"]),
                composite_shader(custom, case, struct_info),
                number_param(number, number_type),
                elements=1,
                workgroups=1,
                kind=f"composite_number_{number_type}",
            )


composite_group("opcompositeinsert", False)
composite_group("opinboundsaccesschain", True)


def default_output_shader(custom, const_value):
    return (
        "OpCapability Shader\n"
        "OpMemoryModel Logical GLSL450\n"
        'OpEntryPoint GLCompute %main "main" %id\n'
        "OpExecutionMode %main LocalSize 1 1 1\n"
        "OpSource GLSL 430\n"
        'OpName %main           "main"\n'
        'OpName %id             "gl_GlobalInvocationID"\n'
        "OpDecorate %id BuiltIn GlobalInvocationId\n"
        "OpDecorate %indata DescriptorSet 0\n"
        "OpDecorate %indata Binding 0\n"
        "OpDecorate %outdata DescriptorSet 0\n"
        "OpDecorate %outdata Binding 1\n"
        "OpDecorate %in_arr ArrayStride 4\n"
        "OpDecorate %in_buf BufferBlock\n"
        "OpMemberDecorate %in_buf 0 Offset 0\n"
        "%void       = OpTypeVoid\n"
        "%voidf      = OpTypeFunction %void\n"
        "%u32        = OpTypeInt 32 0\n"
        "%i32        = OpTypeInt 32 1\n"
        "%f32        = OpTypeFloat 32\n"
        "%uvec3      = OpTypeVector %u32 3\n"
        "%uvec3ptr   = OpTypePointer Input %uvec3\n"
        + (f"%const      = OpConstant {custom} {const_value}\n" if const_value is not None else f";%const      = OpConstant {custom} \n")
        + f"%in_ptr     = OpTypePointer Uniform {custom}\n"
        f"%in_arr     = OpTypeRuntimeArray {custom}\n"
        "%in_buf     = OpTypeStruct %in_arr\n"
        "%in_bufptr  = OpTypePointer Uniform %in_buf\n"
        "%indata     = OpVariable %in_bufptr Uniform\n"
        "%outdata    = OpVariable %in_bufptr Uniform\n"
        "%id         = OpVariable %uvec3ptr Input\n"
        f"%var_ptr    = OpTypePointer Function {custom}\n"
        "%zero       = OpConstant %i32 0\n"
        "%main       = OpFunction %void None %voidf\n"
        "%label      = OpLabel\n"
        "%out_var    = OpVariable %var_ptr Function" + (" %const" if const_value is not None else "") + "\n"
        "%idval      = OpLoad %uvec3 %id\n"
        "%x          = OpCompositeExtract %u32 %idval 0\n"
        f"%inloc      = OpAccessChain %in_ptr %indata %zero %x\n"
        f"%outloc     = OpAccessChain %in_ptr %outdata %zero %x\n"
        f"%outval     = OpLoad {custom} %out_var\n"
        "              OpStore %outloc %outval\n"
        "              OpReturn\n"
        "              OpFunctionEnd\n"
    )


rnd = DeRandom(de_string_hash("shader_default_output"))
for number_type, custom in NUMBER_TYPES:
    for sub_case in (0, 1):
        number = draw_number(rnd, number_type)
        if sub_case == 0:
            add(
                ("shader_default_output", number_type, "initialized"),
                default_output_shader(custom, number_to_string(number, number_type)),
                number_param(number, number_type),
                elements=1,
                workgroups=1,
                kind=f"default_output_{number_type}",
            )
        else:
            add(
                ("shader_default_output", number_type, "uninitialized"),
                default_output_shader(custom, None),
                number_param(number, number_type),
                elements=1,
                workgroups=1,
                kind=f"default_output_uninitialized_{number_type}",
            )


# bool.mixed_bitsize: four booleans, each produced by a comparison of a different native bit size
for widths in [(w0, w1, w2, w3) for w0 in (32, 16, 8) for w1 in (32, 16, 8) for w2 in (32, 16, 8) for w3 in (32, 16, 8)]:
    if len(set(widths)) == 1:
        continue
    has_float32, has_float16, has_int8 = 32 in widths, 16 in widths, 8 in widths
    caps = "OpCapability Shader\n" + ("OpCapability Float16\n" if has_float16 else "") + ("OpCapability Int8\n" if has_int8 else "")
    consts = "%c0i32     = OpConstant %i32 0\n%c1f32     = OpConstant %f32 1.0\n%c0f32     = OpConstant %f32 0.0\n"
    if has_float32:
        consts += "%c10f32    = OpConstant %f32 10.0\n%c25f32    = OpConstant %f32 25.0\n%c50f32    = OpConstant %f32 50.0\n%c90f32    = OpConstant %f32 90.0\n"
    if has_float16:
        consts += "%f16       = OpTypeFloat 16\n%c10f16    = OpConstant %f16 10.0\n%c25f16    = OpConstant %f16 25.0\n%c50f16    = OpConstant %f16 50.0\n%c90f16    = OpConstant %f16 90.0\n"
    if has_int8:
        consts += "%i8        = OpTypeInt 8 1\n%c10i8     = OpConstant %i8 10\n%c25i8     = OpConstant %i8 25\n%c50i8     = OpConstant %i8 50\n%c90i8     = OpConstant %i8 90\n"
    test = "%inval32   = OpLoad %f32 %inloc\n"
    if has_float16:
        test += "%inval16   = OpFConvert %f16 %inval32\n"
    if has_int8:
        test += "%inval8    = OpConvertFToS %i8 %inval32\n"
    for number, (width, float_op, int_op, constant) in enumerate(
        [(widths[0], "OpFOrdGreaterThanEqual", "OpSGreaterThanEqual", "25"), (widths[1], "OpFOrdLessThan", "OpSLessThan", "50"), (widths[2], "OpFOrdLessThan", "OpSLessThan", "10"), (widths[3], "OpFOrdGreaterThanEqual", "OpSGreaterThanEqual", "90")],
        start=1,
    ):
        if width == 32:
            test += f"%cmp{number}      = {float_op} %bool %inval32 %c{constant}f32\n"
        elif width == 16:
            test += f"%cmp{number}      = {float_op} %bool %inval16 %c{constant}f16\n"
        else:
            test += f"%cmp{number}      = {int_op} %bool %inval8 %c{constant}i8\n"
    test += "%and1      = OpLogicalAnd %bool %cmp1 %cmp2\n%or1       = OpLogicalOr %bool %cmp3 %cmp4\n%or2       = OpLogicalOr %bool %and1 %or1\n%not1      = OpLogicalNot %bool %or2\n%res       = OpSelect %f32 %not1 %c1f32 %c0f32\n"
    assembly = (
        caps
        + "\n"
        "OpMemoryModel Logical GLSL450\n"
        'OpEntryPoint GLCompute %main "main" %id\n'
        "OpExecutionMode %main LocalSize 1 1 1\n"
        "OpSource GLSL 430\n"
        'OpName %main           "main"\n'
        'OpName %id             "gl_GlobalInvocationID"\n'
        "OpDecorate %id BuiltIn GlobalInvocationId\n"
        + input_output_buffer_traits()
        + common_types()
        + input_output_buffer()
        + "%id        = OpVariable %uvec3ptr Input\n"
        + consts
        + "\n"
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        "%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x\n"
        + test
        + "\n"
        "%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x\n"
        "             OpStore %outloc %res\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n"
    )
    add(
        ("bool", "mixed_bitsize", "b" + "b".join(str(width) for width in widths)),
        assembly,
        "mixed_bitsize",
        lo=0,
        hi=100,
        elements=100,
        kind="bool_mixed_bitsize",
        extensions="VK_KHR_shader_float16_int8",
    )


# float16.opconstantcomposite: Float16 composite constants that the shader never uses
FLOAT16_COMPOSITE_CONSTANTS = [
    ("vector", "%const = OpConstantComposite %v3f16 %c_f16_0 %c_f16_0_5 %c_f16_1\n"),
    (
        "matrix",
        "%m3v3f16 = OpTypeMatrix %v3f16 3\n"
        "%vec = OpConstantComposite %v3f16 %c_f16_0 %c_f16_0_5 %c_f16_1\n"
        "%mat = OpConstantComposite %m3v3f16 %vec %vec %vec",
    ),
    (
        "struct",
        "%m2v3f16 = OpTypeMatrix %v3f16 2\n"
        "%struct = OpTypeStruct %i32 %f16 %v3f16 %m2v3f16\n"
        "%vec = OpConstantComposite %v3f16 %c_f16_0 %c_f16_0_5 %c_f16_1\n"
        "%mat = OpConstantComposite %m2v3f16 %vec %vec\n"
        "%const = OpConstantComposite %struct %zero %c_f16_0_5 %vec %mat\n",
    ),
    (
        "nested_struct",
        "%st1 = OpTypeStruct %i32 %f16\n"
        "%st2 = OpTypeStruct %i32 %i32\n"
        "%struct = OpTypeStruct %st1 %st2\n"
        "%st1val = OpConstantComposite %st1 %zero %c_f16_0_5\n"
        "%st2val = OpConstantComposite %st2 %zero %zero\n"
        "%const = OpConstantComposite %struct %st1val %st2val",
    ),
]
for name, constant in FLOAT16_COMPOSITE_CONSTANTS:
    add(
        ("float16", "opconstantcomposite", name),
        "OpCapability Shader\n"
        "OpCapability Float16\n"
        "OpMemoryModel Logical GLSL450\n"
        'OpEntryPoint GLCompute %main "main" %id\n'
        "OpExecutionMode %main LocalSize 1 1 1\n"
        "OpSource GLSL 430\n"
        + NAMES
        + DECORATE_ID
        + input_output_buffer_traits()
        + common_types()
        + input_output_buffer()
        + ID_AND_ZERO
        + "%f16       = OpTypeFloat 16\n"
        "%c_f16_0   = OpConstant %f16 0.0\n"
        "%c_f16_0_5 = OpConstant %f16 0.5\n"
        "%c_f16_1   = OpConstant %f16 1.0\n"
        "%v2f16     = OpTypeVector %f16 2\n"
        "%v3f16     = OpTypeVector %f16 3\n"
        "%v4f16     = OpTypeVector %f16 4\n"
        + constant
        + "\n"
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        "%inloc     = OpAccessChain %f32ptr %indata %zero %x\n"
        "%inval     = OpLoad %f32 %inloc\n"
        "%neg       = OpFNegate %f32 %inval\n"
        "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
        "             OpStore %outloc %neg\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n",
        "opconstantcomposite",
        elements=100,
        kind="float16_negate",
        extensions="VK_KHR_shader_float16_int8",
    )


# opphi vartype_*: the same positive-or-not OpPhi over an int, a float, a half, a vec3, a mat4, an array and a struct (the long vector one is left out)
for key in ("int", "float", "float16", "vec3", "mat4", "array", "struct"):
    add(
        ("opphi", f"vartype_{key}"),
        (SPIRV_SOURCES / f"opphi_vartype_{key}.spvasm").read_text(encoding="utf-8"),
        "opphi",
        lo=-300,
        hi=300,
        kind="opphi_vartype_f16" if key == "float16" else "opphi_vartype",
        extensions="VK_KHR_shader_float16_int8" if key == "float16" else "",
    )


# opspecconstantop: OpSpecConstantOp over two specialization constants whose values the case passes as the specialization data
SPEC_CONSTANT_OP_CASES = [
    ('iadd', ' %i32 0', ' %i32 0', '%i32', 'IAdd                 %sc_0 %sc_1', ('i32', 62), ('i32', -20), 'addScToInput', 1, ()),
    ('isub', ' %i32 0', ' %i32 0', '%i32', 'ISub                 %sc_0 %sc_1', ('i32', 100), ('i32', 58), 'addScToInput', 1, ()),
    ('imul', ' %i32 0', ' %i32 0', '%i32', 'IMul                 %sc_0 %sc_1', ('i32', -2), ('i32', -21), 'addScToInput', 1, ()),
    ('sdiv', ' %i32 0', ' %i32 0', '%i32', 'SDiv                 %sc_0 %sc_1', ('i32', -126), ('i32', -3), 'addScToInput', 1, ()),
    ('udiv', ' %u32 0', ' %u32 0', '%u32', 'UDiv                 %sc_0 %sc_1', ('i32', 126), ('i32', 3), 'addScToInput', 1, ()),
    ('srem', ' %i32 0', ' %i32 0', '%i32', 'SRem                 %sc_0 %sc_1', ('i32', 7), ('i32', 3), 'addScToInput', 4, ()),
    ('smod', ' %i32 0', ' %i32 0', '%i32', 'SMod                 %sc_0 %sc_1', ('i32', 7), ('i32', 3), 'addScToInput', 4, ()),
    ('umod', ' %u32 0', ' %u32 0', '%u32', 'UMod                 %sc_0 %sc_1', ('i32', 342), ('i32', 50), 'addScToInput', 1, ()),
    ('bitwiseand', ' %i32 0', ' %i32 0', '%i32', 'BitwiseAnd           %sc_0 %sc_1', ('i32', 42), ('i32', 63), 'addScToInput', 1, ()),
    ('bitwiseor', ' %i32 0', ' %i32 0', '%i32', 'BitwiseOr            %sc_0 %sc_1', ('i32', 34), ('i32', 8), 'addScToInput', 1, ()),
    ('bitwisexor', ' %i32 0', ' %i32 0', '%i32', 'BitwiseXor           %sc_0 %sc_1', ('i32', 18), ('i32', 56), 'addScToInput', 1, ()),
    ('shiftrightlogical', ' %i32 0', ' %i32 0', '%i32', 'ShiftRightLogical    %sc_0 %sc_1', ('i32', 168), ('i32', 2), 'addScToInput', 1, ()),
    ('shiftrightarithmetic', ' %i32 0', ' %i32 0', '%i32', 'ShiftRightArithmetic %sc_0 %sc_1', ('i32', -168), ('i32', 2), 'addScToInput', 5, ()),
    ('shiftleftlogical', ' %i32 0', ' %i32 0', '%i32', 'ShiftLeftLogical     %sc_0 %sc_1', ('i32', 21), ('i32', 1), 'addScToInput', 1, ()),
    ('shiftrightlogical_i64', ' %i64 0', ' %i64 0', '%i64', 'ShiftRightLogical    %sc_0 %sc_1', ('i64', 168), ('i64', 2), 'addSc32ToInput', 1, ('CONVERT', 'I64')),
    ('shiftrightarithmetic_i64', ' %i64 0', ' %i64 0', '%i64', 'ShiftRightArithmetic %sc_0 %sc_1', ('i64', -168), ('i64', 2), 'addSc32ToInput', 5, ('CONVERT', 'I64')),
    ('shiftleftlogical_i64', ' %i64 0', ' %i64 0', '%i64', 'ShiftLeftLogical     %sc_0 %sc_1', ('i64', 21), ('i64', 1), 'addSc32ToInput', 1, ('CONVERT', 'I64')),
    ('shiftrightlogical_i16', ' %i16 0', ' %i16 0', '%i16', 'ShiftRightLogical    %sc_0 %sc_1', ('i16', 168), ('i16', 2), 'addSc32ToInput', 1, ('CONVERT', 'I16')),
    ('shiftrightarithmetic_i16', ' %i16 0', ' %i16 0', '%i16', 'ShiftRightArithmetic %sc_0 %sc_1', ('i16', -168), ('i16', 2), 'addSc32ToInput', 5, ('CONVERT', 'I16')),
    ('shiftleftlogical_i16', ' %i16 0', ' %i16 0', '%i16', 'ShiftLeftLogical     %sc_0 %sc_1', ('i16', 21), ('i16', 1), 'addSc32ToInput', 1, ('CONVERT', 'I16')),
    ('shiftrightlogical_i8', ' %i8 0', ' %i8 0', '%i8', 'ShiftRightLogical    %sc_0 %sc_1', ('i8', 84), ('i8', 1), 'addSc32ToInput', 1, ('CONVERT', 'I8')),
    ('shiftrightarithmetic_i8', ' %i8 0', ' %i8 0', '%i8', 'ShiftRightArithmetic %sc_0 %sc_1', ('i8', -84), ('i8', 1), 'addSc32ToInput', 5, ('CONVERT', 'I8')),
    ('shiftleftlogical_i8', ' %i8 0', ' %i8 0', '%i8', 'ShiftLeftLogical     %sc_0 %sc_1', ('i8', 21), ('i8', 1), 'addSc32ToInput', 1, ('CONVERT', 'I8')),
    ('shiftrightlogical_s_i64', ' %i32 0', ' %i64 0', '%i32', 'ShiftRightLogical    %sc_0 %sc_1', ('i32', 168), ('i64', 2), 'addScToInput', 1, ('I64',)),
    ('shiftrightarithmetic_s_i64', ' %i32 0', ' %i64 0', '%i32', 'ShiftRightArithmetic %sc_0 %sc_1', ('i32', -168), ('i64', 2), 'addScToInput', 5, ('I64',)),
    ('shiftleftlogical_s_i64', ' %i32 0', ' %i64 0', '%i32', 'ShiftLeftLogical     %sc_0 %sc_1', ('i32', 21), ('i64', 1), 'addScToInput', 1, ('I64',)),
    ('shiftrightlogical_s_i16', ' %i32 0', ' %i16 0', '%i32', 'ShiftRightLogical    %sc_0 %sc_1', ('i32', 168), ('i16', 2), 'addScToInput', 1, ('I16',)),
    ('shiftrightarithmetic_s_i16', ' %i32 0', ' %i16 0', '%i32', 'ShiftRightArithmetic %sc_0 %sc_1', ('i32', -168), ('i16', 2), 'addScToInput', 5, ('I16',)),
    ('shiftleftlogical_s_i16', ' %i32 0', ' %i16 0', '%i32', 'ShiftLeftLogical     %sc_0 %sc_1', ('i32', 21), ('i16', 1), 'addScToInput', 1, ('I16',)),
    ('shiftrightlogical_s_i8', ' %i32 0', ' %i8 0', '%i32', 'ShiftRightLogical    %sc_0 %sc_1', ('i32', 84), ('i8', 1), 'addScToInput', 1, ('I8',)),
    ('shiftrightarithmetic_s_i8', ' %i32 0', ' %i8 0', '%i32', 'ShiftRightArithmetic %sc_0 %sc_1', ('i32', -84), ('i8', 1), 'addScToInput', 5, ('I8',)),
    ('shiftleftlogical_s_i8', ' %i32 0', ' %i8 0', '%i32', 'ShiftLeftLogical     %sc_0 %sc_1', ('i32', 21), ('i8', 1), 'addScToInput', 1, ('I8',)),
    ('slessthan', ' %i32 0', ' %i32 0', '%bool', 'SLessThan            %sc_0 %sc_1', ('i32', -20), ('i32', -10), 'selectTrueUsingSc', 2, ()),
    ('ulessthan', ' %i32 0', ' %i32 0', '%bool', 'ULessThan            %sc_0 %sc_1', ('i32', 10), ('i32', 20), 'selectTrueUsingSc', 2, ()),
    ('sgreaterthan', ' %i32 0', ' %i32 0', '%bool', 'SGreaterThan         %sc_0 %sc_1', ('i32', -1000), ('i32', 50), 'selectFalseUsingSc', 2, ()),
    ('ugreaterthan', ' %i32 0', ' %i32 0', '%bool', 'UGreaterThan         %sc_0 %sc_1', ('i32', 10), ('i32', 5), 'selectTrueUsingSc', 2, ()),
    ('slessthanequal', ' %i32 0', ' %i32 0', '%bool', 'SLessThanEqual       %sc_0 %sc_1', ('i32', -10), ('i32', -10), 'selectTrueUsingSc', 2, ()),
    ('ulessthanequal', ' %i32 0', ' %i32 0', '%bool', 'ULessThanEqual       %sc_0 %sc_1', ('i32', 50), ('i32', 100), 'selectTrueUsingSc', 2, ()),
    ('sgreaterthanequal', ' %i32 0', ' %i32 0', '%bool', 'SGreaterThanEqual    %sc_0 %sc_1', ('i32', -1000), ('i32', 50), 'selectFalseUsingSc', 2, ()),
    ('ugreaterthanequal', ' %i32 0', ' %i32 0', '%bool', 'UGreaterThanEqual    %sc_0 %sc_1', ('i32', 10), ('i32', 10), 'selectTrueUsingSc', 2, ()),
    ('iequal', ' %i32 0', ' %i32 0', '%bool', 'IEqual               %sc_0 %sc_1', ('i32', 42), ('i32', 24), 'selectFalseUsingSc', 2, ()),
    ('inotequal', ' %i32 0', ' %i32 0', '%bool', 'INotEqual            %sc_0 %sc_1', ('i32', 42), ('i32', 24), 'selectTrueUsingSc', 2, ()),
    ('logicaland', 'True %bool', 'True %bool', '%bool', 'LogicalAnd           %sc_0 %sc_1', ('i32', 0), ('i32', 1), 'selectFalseUsingSc', 2, ()),
    ('logicalor', 'False %bool', 'False %bool', '%bool', 'LogicalOr            %sc_0 %sc_1', ('i32', 1), ('i32', 0), 'selectTrueUsingSc', 2, ()),
    ('logicalequal', 'True %bool', 'True %bool', '%bool', 'LogicalEqual         %sc_0 %sc_1', ('i32', 0), ('i32', 1), 'selectFalseUsingSc', 2, ()),
    ('logicalnotequal', 'False %bool', 'False %bool', '%bool', 'LogicalNotEqual      %sc_0 %sc_1', ('i32', 1), ('i32', 0), 'selectTrueUsingSc', 2, ()),
    ('snegate', ' %i32 0', ' %i32 0', '%i32', 'SNegate              %sc_0', ('i32', -42), ('i32', 0), 'addScToInput', 1, ()),
    ('not', ' %i32 0', ' %i32 0', '%i32', 'Not                  %sc_0', ('i32', -43), ('i32', 0), 'addScToInput', 1, ()),
    ('logicalnot', 'False %bool', 'False %bool', '%bool', 'LogicalNot           %sc_0', ('i32', 1), ('i32', 0), 'selectFalseUsingSc', 2, ()),
    ('select', 'False %bool', ' %i32 0', '%i32', 'Select               %sc_0 %sc_1 %zero', ('i32', 1), ('i32', 42), 'addScToInput', 1, ()),
    ('sconvert', ' %i32 0', ' %i32 0', '%i16', 'SConvert             %sc_0', ('i32', -11200), ('i32', 0), 'addSc32ToInput', 3, ('CONVERT', 'I16')),
    ('fconvert', ' %f32 0', ' %f32 0', '%f64', 'FConvert             %sc_0', ('f32', -11200.0), ('f32', 0.0), 'addSc32ToInput', 3, ('CONVERT', 'F64')),
    ('fconvert16', ' %f16 0', ' %f16 0', '%f32', 'FConvert             %sc_0', ('f16', 1.0), ('f16', 0.0), 'addSc32ToInput', 4, ('CONVERT', 'F16')),
]
SPEC_CONSTANT_ADD_TO_INPUT = "OpIAdd %i32 %inval %sc_final"
SPEC_CONSTANT_RESULTS = {
    "addScToInput": SPEC_CONSTANT_ADD_TO_INPUT,
    "addSc32ToInput": "OpIAdd %i32 %inval %sc_final32",
    "selectTrueUsingSc": "OpSelect %i32 %sc_final %inval %zero",
    "selectFalseUsingSc": "OpSelect %i32 %sc_final %zero %inval",
}
SPEC_CONSTANT_FLAG_CODE = {
    "I16": ("OpCapability Int16\n", "%i16 = OpTypeInt 16 1\n", "%sc_final32 = OpSConvert %i32 %sc_final\n"),
    "I64": ("OpCapability Int64\n", "%i64 = OpTypeInt 64 1\n", "%sc_final32 = OpSConvert %i32 %sc_final\n"),
    "F64": ("OpCapability Float64\n", "%f64 = OpTypeFloat 64\n", "%sc_final32 = OpConvertFToS %i32 %sc_final\n"),
    "F16": ("OpCapability Float16\n", "%f16 = OpTypeFloat 16\n", "%sc_final32 = OpConvertFToS %i32 %sc_final\n"),
    "I8": ("OpCapability Int8\n", "%i8 = OpTypeInt 8 1\n", "%sc_final32 = OpSConvert %i32 %sc_final\n"),
}


def spec_constant_bytes(value):
    kind, number = value
    if kind == "f16":
        return {1.0: b"\x00\x3c", 0.0: b"\x00\x00"}[number].hex()
    packing = {"i8": "<b", "i16": "<h", "i32": "<i", "i64": "<q", "f32": "<f"}[kind]
    return struct.pack(packing, number).hex()


def spec_constant_op_assembly(definition0, definition1, result_type, operation, result_operation, flags):
    capabilities = type_definitions = type_convert = ""
    for flag in ("I16", "I64", "F64", "F16", "I8"):
        if flag in flags:
            capabilities += SPEC_CONSTANT_FLAG_CODE[flag][0]
            type_definitions += SPEC_CONSTANT_FLAG_CODE[flag][1]
            if "CONVERT" in flags:
                type_convert += SPEC_CONSTANT_FLAG_CODE[flag][2]
    return (
        capabilities
        + preamble()
        + NAMES
        + DECORATE_ID
        + "OpDecorate %sc_0  SpecId 0\n"
        "OpDecorate %sc_1  SpecId 1\n"
        "OpDecorate %i32arr ArrayStride 4\n"
        + input_output_buffer_traits()
        + common_types()
        + type_definitions
        + "%buf     = OpTypeStruct %i32arr\n"
        "%bufptr  = OpTypePointer Uniform %buf\n"
        "%indata    = OpVariable %bufptr Uniform\n"
        "%outdata   = OpVariable %bufptr Uniform\n"
        "%id        = OpVariable %uvec3ptr Input\n"
        "%zero      = OpConstant %i32 0\n"
        f"%sc_0      = OpSpecConstant{definition0}\n"
        f"%sc_1      = OpSpecConstant{definition1}\n"
        f"%sc_final  = OpSpecConstantOp {result_type} {operation}\n"
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        + type_convert
        + "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        "%inloc     = OpAccessChain %i32ptr %indata %zero %x\n"
        "%inval     = OpLoad %i32 %inloc\n"
        f"%final     = {result_operation}\n"
        "%outloc    = OpAccessChain %i32ptr %outdata %zero %x\n"
        "             OpStore %outloc %final\n"
        "             OpReturn\n"
        "             OpFunctionEnd\n"
    )


for name, definition0, definition1, result_type, operation, value0, value1, result_key, output_key, flags in SPEC_CONSTANT_OP_CASES:
    extensions = "VK_KHR_shader_float16_int8" if ("F16" in flags or "I8" in flags) else ""
    add(
        ("opspecconstantop", name),
        spec_constant_op_assembly(definition0, definition1, result_type, operation, SPEC_CONSTANT_RESULTS[result_key], flags),
        "opspecconstantop",
        lo=-65536,
        hi=65536,
        elements=100,
        kind=f"spec_constant_{output_key}",
        extensions=extensions,
        spec_constants=spec_constant_bytes(value0) + ";" + spec_constant_bytes(value1),
    )
SPEC_CONSTANT_STRUCT_BLOCK = (
    "%iarr3_a     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_0        %iarr3_0     0\n"
    "%iarr3_b     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_1        %iarr3_a     1\n"
    "%iarr3_c     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_2        %iarr3_b     2\n"
    "%iarr3_d     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_1        %iarr3_0     0\n"
    "%iarr3_e     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_2        %iarr3_d     1\n"
    "%iarr3_f     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_0        %iarr3_e     2\n"
    "%iarr3_g     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_2        %iarr3_0     0\n"
    "%iarr3_h     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_0        %iarr3_g     1\n"
    "%iarr3_i     = OpSpecConstantOp %iarr3  CompositeInsert  %sc_1        %iarr3_h     2\n"
    "%imat3_a     = OpSpecConstantOp %imat3  CompositeInsert  %iarr3_c     %imat3_0     0\n"
    "%imat3_b     = OpSpecConstantOp %imat3  CompositeInsert  %iarr3_f     %imat3_a     1\n"
    "%imat3_c     = OpSpecConstantOp %imat3  CompositeInsert  %iarr3_i     %imat3_b     2\n"
    "%struct_a    = OpSpecConstantOp %struct CompositeInsert  %imat3_c     %struct_0    0\n"
    "%comp_0_0    = OpSpecConstantOp %i32    CompositeExtract %struct_a    0 0 0\n"
    "%comp_1_0    = OpSpecConstantOp %i32    CompositeExtract %struct_a    0 1 0\n"
    "%comp_0_1    = OpSpecConstantOp %i32    CompositeExtract %struct_a    0 0 1\n"
    "%comp_2_2    = OpSpecConstantOp %i32    CompositeExtract %struct_a    0 2 2\n"
    "%comp_2_0    = OpSpecConstantOp %i32    CompositeExtract %struct_a    0 2 0\n"
    "%comp_1_1    = OpSpecConstantOp %i32    CompositeExtract %struct_a    0 1 1\n"
    "%cmpres_0    = OpSpecConstantOp %bool   IEqual %comp_0_0 %comp_1_0\n"
    "%cmpres_1    = OpSpecConstantOp %bool   IEqual %comp_0_1 %comp_2_2\n"
    "%cmpres_2    = OpSpecConstantOp %bool   IEqual %comp_2_0 %comp_1_1\n"
    "%mustbe_0    = OpSpecConstantOp %i32    Select %cmpres_0 %one %zero\n"
    "%mustbe_1    = OpSpecConstantOp %i32    Select %cmpres_1 %one %zero\n"
    "%mustbe_2    = OpSpecConstantOp %i32    Select %cmpres_2 %two %one\n"
)
add(
    ("opspecconstantop", "vector_related"),
    preamble()
    + NAMES
    + DECORATE_ID
    + "OpDecorate %sc_0  SpecId 0\n"
    "OpDecorate %sc_1  SpecId 1\n"
    "OpDecorate %sc_2  SpecId 2\n"
    "OpDecorate %i32arr ArrayStride 4\n"
    + input_output_buffer_traits()
    + common_types()
    + "%ivec3       = OpTypeVector %i32 3\n"
    "%zero        = OpConstant %i32 0\n"
    "%one         = OpConstant %i32 1\n"
    "%two         = OpConstant %i32 2\n"
    "%three       = OpConstant %i32 3\n"
    "%iarr3       = OpTypeArray %i32 %three\n"
    "%imat3       = OpTypeArray %iarr3 %three\n"
    "%struct      = OpTypeStruct %imat3\n"
    "%buf         = OpTypeStruct %i32arr\n"
    "%bufptr      = OpTypePointer Uniform %buf\n"
    "%indata      = OpVariable %bufptr Uniform\n"
    "%outdata     = OpVariable %bufptr Uniform\n"
    "%id          = OpVariable %uvec3ptr Input\n"
    "%ivec3_0     = OpConstantComposite %ivec3 %zero %zero %zero\n"
    "%vec3_undef  = OpUndef %ivec3\n"
    "%iarr3_0     = OpConstantComposite %iarr3 %zero %zero %zero\n"
    "%imat3_0     = OpConstantComposite %imat3 %iarr3_0 %iarr3_0 %iarr3_0\n"
    "%struct_0    = OpConstantComposite %struct %imat3_0\n"
    "%sc_0        = OpSpecConstant %i32 0\n"
    "%sc_1        = OpSpecConstant %i32 0\n"
    "%sc_2        = OpSpecConstant %i32 0\n"
    + SPEC_CONSTANT_STRUCT_BLOCK
    + "%sc_vec3_0   = OpSpecConstantOp %ivec3 CompositeInsert  %sc_0        %ivec3_0     0\n"
    "%sc_vec3_1   = OpSpecConstantOp %ivec3 CompositeInsert  %sc_1        %ivec3_0     1\n"
    "%sc_vec3_2   = OpSpecConstantOp %ivec3 CompositeInsert  %sc_2        %ivec3_0     2\n"
    "%sc_vec3_0_s = OpSpecConstantOp %ivec3 VectorShuffle    %sc_vec3_0   %vec3_undef  0          0xFFFFFFFF 2\n"
    "%sc_vec3_1_s = OpSpecConstantOp %ivec3 VectorShuffle    %sc_vec3_1   %vec3_undef  0xFFFFFFFF 1          0\n"
    "%sc_vec3_2_s = OpSpecConstantOp %ivec3 VectorShuffle    %vec3_undef  %sc_vec3_2   5          0xFFFFFFFF 5\n"
    "%sc_vec3_01  = OpSpecConstantOp %ivec3 VectorShuffle    %sc_vec3_0_s %sc_vec3_1_s 1 0 4\n"
    "%sc_vec3_012 = OpSpecConstantOp %ivec3 VectorShuffle    %sc_vec3_01  %sc_vec3_2_s 5 1 2\n"
    "%sc_ext_0    = OpSpecConstantOp %i32   CompositeExtract %sc_vec3_012              0\n"
    "%sc_ext_1    = OpSpecConstantOp %i32   CompositeExtract %sc_vec3_012              1\n"
    "%sc_ext_2    = OpSpecConstantOp %i32   CompositeExtract %sc_vec3_012              2\n"
    "%sc_sub      = OpSpecConstantOp %i32   ISub             %sc_ext_0    %sc_ext_1\n"
    "%sc_factor   = OpSpecConstantOp %i32   IMul             %sc_sub      %sc_ext_2\n"
    "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%subf_a      = OpISub %i32 %one %mustbe_0\n"
    "%subf_b      = OpIMul %i32 %subf_a %mustbe_1\n"
    "%subf_c      = OpISub %i32 %mustbe_2 %one\n"
    "%factor      = OpIMul %i32 %subf_b %subf_c\n"
    "%sc_final    = OpIMul %i32 %factor %sc_factor\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%inloc     = OpAccessChain %i32ptr %indata %zero %x\n"
    "%inval     = OpLoad %i32 %inloc\n"
    "%final     = OpIAdd %i32 %inval %sc_final\n"
    "%outloc    = OpAccessChain %i32ptr %outdata %zero %x\n"
    "             OpStore %outloc %final\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n",
    "opspecconstantop",
    lo=-65536,
    hi=65536,
    elements=100,
    kind="spec_constant_3",
    spec_constants=";".join(struct.pack("<i", value).hex() for value in (123, 56, -77)),
)


# opspecconstantop_opquantize: OpQuantizeToF16 applied to float specialization constants, one selected per invocation
def construct_normalized_float(exponent, significand):
    value = 1.0
    for idx in range(23):
        if significand & 0x800000:
            value += 2.0 ** -(idx + 1)
        significand = (significand << 1) & 0xFFFFFFFF
    return value * 2.0**exponent


def f32_bits_hex(bits):
    return struct.pack("<I", bits).hex()


def f32_hex(value):
    return struct.pack("<f", value).hex()


SPEC_QUANTIZE_ASSEMBLY = (
    preamble()
    + NAMES
    + DECORATE_ID
    + "".join(f"OpDecorate %sc_{i}  SpecId {i}\n" for i in range(6))
    + input_output_buffer_traits()
    + common_types()
    + input_output_buffer()
    + ID_AND_ZERO
    + "%c_u32_6   = OpConstant %u32 6\n"
    + "".join(f"%sc_{i}      = OpSpecConstant %f32 0.\n" for i in range(6))
    + "".join(f"%sc_{i}_quant = OpSpecConstantOp %f32 QuantizeToF16 %sc_{i}\n" for i in range(6))
    + "%main      = OpFunction %void None %voidf\n"
    "%label     = OpLabel\n"
    "%idval     = OpLoad %uvec3 %id\n"
    "%x         = OpCompositeExtract %u32 %idval 0\n"
    "%outloc    = OpAccessChain %f32ptr %outdata %zero %x\n"
    "%selector  = OpUMod %u32 %x %c_u32_6\n"
    "            OpSelectionMerge %exit None\n"
    "            OpSwitch %selector %exit 0 %case0 1 %case1 2 %case2 3 %case3 4 %case4 5 %case5\n"
    + "".join(
        f"%case{i}     = OpLabel\n             OpStore %outloc %sc_{i}_quant\n             OpBranch %exit\n" for i in range(6)
    )
    + "%exit      = OpLabel\n"
    "             OpReturn\n"
    "             OpFunctionEnd\n"
)

SPEC_QUANTIZE_CASES = [
    ("infinities", "specquant_infinities", 4, [f32_bits_hex(0x7F800000), f32_bits_hex(0xFF800000), f32_hex(2.0**16), f32_hex(-(2.0**32))]),
    ("propagated_nans", "specquant_nans", 2, [f32_bits_hex(0x7FC00000), f32_bits_hex(0xFFC00000)]),
    (
        "flush_to_zero",
        "specquant_ftz",
        6,
        [f32_bits_hex(0), f32_bits_hex(0x80000000), f32_hex(2.0**-16), f32_hex(-(2.0**-32)), f32_hex(2.0**-127), f32_hex(-(2.0**-128))],
    ),
    ("exact", "specquant_exact", 6, [f32_hex((idx * 10 - 30) / 4.0) for idx in range(6)]),
    (
        "rounded",
        "specquant_rounded",
        4,
        [
            f32_hex(construct_normalized_float(8, 0x300300)),
            f32_hex(-construct_normalized_float(-7, 0x600800)),
            f32_hex(construct_normalized_float(2, 0x01E000)),
            f32_hex(construct_normalized_float(1, 0xFFE000)),
        ],
    ),
]

for name, kind, count, constants in SPEC_QUANTIZE_CASES:
    add(("opspecconstantop_opquantize", name), SPEC_QUANTIZE_ASSEMBLY, "opspecconstantop_opquantize", elements=count, kind=kind, spec_constants=";".join(constants))


def toml_string(text):
    return json.dumps(text, ensure_ascii=False)


def main():
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.* (the float buffer groups of vktSpvAsmInstructionTests.cpp)\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_manifest.py - do not hand-edit; see the script for what each case is.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp"\n'
        'rust_module = "spirv_assembly/instruction_tests"\n'
    ]
    used = set()
    for case in CASES:
        const = "SPVASM_" + "".join(c if c.isalnum() else "_" for c in case["name"]).upper()
        unique = const
        counter = 2
        while unique in used:
            unique = f"{const}_{counter}"
            counter += 1
        used.add(unique)
        spirv = f', spirv_version = "{case["spirv"]}"' if case["spirv"] else ', spirv_version = "spirv1.3"' if case["spirv13"] else ""
        params = (
            f'seed = {{ type = "str", value = {toml_string(case["seed"])} }}, min = {{ type = "i32", value = {case["lo"]} }}, max = {{ type = "i32", value = {case["hi"]} }}, '
            f'elements = {{ type = "u32", value = {case["elements"]} }}, kind = {{ type = "str", value = {toml_string(case["kind"])} }}, '
            f'entry = {{ type = "str", value = {toml_string(case["entry"])} }}, extensions = {{ type = "str", value = {toml_string(case["extensions"])} }}, '
            f'spirv13 = {{ type = "bool", value = {"true" if case["spirv13"] else "false"} }}, '
            f'skip = {{ type = "u32", value = {case["skip"]} }}, workgroups = {{ type = "u32", value = {case["workgroups"]} }}, '
            f'spec_constants = {{ type = "str", value = {toml_string(case["spec_constants"])} }}'
        )
        out.append(
            f'\n[[case]]\nname = {toml_string(case["name"])}\nrust_const = "{unique}"\nrust_type = "SpvAsmCase"\n'
            f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm"{spirv} }} ]\n'
            f"params = {{ {params} }}\n"
            f"derived = {{ source = {json.dumps(repr(case['assembly']), ensure_ascii=False)} }}\n"
        )
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {len(CASES)} cases")


if __name__ == "__main__":
    main()

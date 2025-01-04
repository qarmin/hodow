#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_pointers.toml: the compute groups of dEQP-VK.spirv_assembly.instruction.compute.{variable_pointers,physical_pointers}
(vktSpvAsmVariablePointersTests.cpp) - `compute` (reads through OpSelect, OpFunctionCall, OpPhi, OpCopyObject and OpPtrAccessChain, stores through Private and
Function pointer variables, writes, workgroup pointers), `complex_types_compute` (a variable pointer to every level of a nested struct, 140 cases per
variant) and `nullptr_compute` - each also under `64b_indexing`, which only changes the pipeline flag.

`addPhysicalOrVariablePointersComputeGroup` and `addComplexTypesPhysicalOrVariablePointersComputeGroup` fill one assembly template per case; the template
is filled here the same way and the case name is the path below `compute`. What the host needs to build the data and the expected output rides along as
`spec` (`group=`, `single=` for one input buffer, `sel=` for the first input, `offset=` the float the complex type case must read, which of the
variable pointers features the case asks for), which src/vkt/tests/spirv_assembly/pointers_tests.rs reads.

Not here: `addOpSelectDifferentStridesTest` (vktSpvAsmOpSelectDifferentStridesTests.cpp), which upstream adds to `variable_pointers.compute`.

    python3 hodow_cts/scripts/gen_spirv_assembly_pointers_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_pointers.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmVariablePointersTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"

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

PHYS_STRUCT_DECORATIONS = (
    "OpDecorate %physPtrsStruct Block\n"
    "OpMemberDecorate %physPtrsStruct 0 Offset 0\n"
    "OpMemberDecorate %physPtrsStruct 1 Offset 8\n"
    "OpMemberDecorate %physPtrsStruct 2 Offset 16\n"
    "OpMemberDecorate %physPtrsStruct 3 Offset 24\n"
    "OpDecorate %indata_all DescriptorSet 0\n"
    "OpDecorate %indata_all Binding 0\n"
)


def specialize(template, values):
    for key, value in values.items():
        template = template.replace("${" + key + "}", value)
    assert "${" not in template, template
    return template


def mux_template(phys):
    text = "OpCapability Shader\n${ExtraCapability}\n"
    text += 'OpExtension "SPV_KHR_physical_storage_buffer"\n' if phys else 'OpExtension "SPV_KHR_variable_pointers"\n'
    text += (
        'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
        "OpMemoryModel " + ("PhysicalStorageBuffer64EXT" if phys else "Logical") + " GLSL450\n"
        'OpEntryPoint GLCompute %main "main" %id\n'
        "OpExecutionMode %main LocalSize 1 1 1\n"
        "OpSource GLSL 430\n"
        'OpName %main           "main"\n'
        'OpName %id             "gl_GlobalInvocationID"\n'
        "OpDecorate %id BuiltIn GlobalInvocationId\n"
        "OpDecorate %f32arr ArrayStride 4\n"
        "OpDecorate %sb_f32ptr ArrayStride 4\n"
        "OpDecorate %buf Block\n"
        "OpMemberDecorate %buf 0 Offset 0\n"
        "${ExtraDecorations}"
    )
    if phys:
        text += PHYS_STRUCT_DECORATIONS + "OpDecorate %first_ptr_param Restrict\nOpDecorate %second_ptr_param Restrict\n"
    else:
        text += (
            "OpDecorate %indata_a DescriptorSet 0\nOpDecorate %indata_a Binding 0\n"
            "OpDecorate %indata_b DescriptorSet 0\nOpDecorate %indata_b Binding 1\n"
            "OpDecorate %indata_s DescriptorSet 0\nOpDecorate %indata_s Binding 2\n"
            "OpDecorate %outdata DescriptorSet 0\nOpDecorate %outdata Binding 3\n"
        )
    text += COMMON_TYPES
    if phys:
        text += (
            "%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32\n"
            "%buf = OpTypeStruct %f32arr\n"
            "%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf\n"
            "%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys\n"
            "%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct\n"
            "%indata_all = OpVariable %physPtrsStructPtr StorageBuffer\n"
            "%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys\n"
        )
    else:
        text += (
            "%sb_f32ptr = OpTypePointer StorageBuffer %f32\n"
            "%buf = OpTypeStruct %f32arr\n"
            "%bufptr = OpTypePointer StorageBuffer %buf\n"
            "%indata_a = OpVariable %bufptr StorageBuffer\n"
            "%indata_b = OpVariable %bufptr StorageBuffer\n"
            "%indata_s = OpVariable %bufptr StorageBuffer\n"
            "%outdata = OpVariable %bufptr StorageBuffer\n"
        )
    text += (
        "%id = OpVariable %uvec3ptr Input\n"
        "%zero                    = OpConstant %i32 0\n"
        "%one = OpConstant %i32 1\n"
        "%two = OpConstant %i32 2\n"
        "%three = OpConstant %i32 3\n"
        "%fzero = OpConstant %f32 0\n"
        "%fone = OpConstant %f32 1\n"
        "${ExtraTypes}"
        "${ExtraGlobalScopeVars}"
        "%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr\n"
        "%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type\n"
        "%is_neg_param = OpFunctionParameter %bool\n"
        "%first_ptr_param = OpFunctionParameter %sb_f32ptr\n"
        "%second_ptr_param = OpFunctionParameter %sb_f32ptr\n"
        "%selector_func_begin = OpLabel\n"
        "%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param\n"
        "OpReturnValue %result_ptr\n"
        "OpFunctionEnd\n"
        "%main = OpFunction %void None %voidf\n"
        "%label = OpLabel\n"
        "${ExtraFunctionScopeVars}"
    )
    if phys:
        text += (
            "%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero\n"
            "%indata_a = OpLoad %bufptrphys %indata_a_ptr\n"
            "%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one\n"
            "%indata_b = OpLoad %bufptrphys %indata_b_ptr\n"
            "%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two\n"
            "%indata_s = OpLoad %bufptrphys %indata_s_ptr\n"
            "%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three\n"
            "%outdata = OpLoad %bufptrphys %outdata_ptr\n"
        )
    text += (
        "%idval = OpLoad %uvec3 %id\n"
        "%i = OpCompositeExtract %u32 %idval 0\n"
        "%two_i = OpIAdd %u32 %i %i\n"
        "%two_i_plus_1 = OpIAdd %u32 %two_i %one\n"
        "%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i\n"
        "%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i\n"
        "%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i\n"
        "%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i\n"
        "%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i\n"
        "%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1\n"
        "%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4\n"
        "%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero\n"
        "${ExtraSetupComputations}"
        "${ResultStrategy}"
        "%mux_output = OpLoad %f32 ${VarPtrName} Aligned 4\n"
        "                          OpStore %outloc_i %mux_output Aligned 4\n"
        "                          OpReturn\n"
        "                          OpFunctionEnd\n"
    )
    return text


def mux_cases(phys):
    """`addPhysicalOrVariablePointersComputeGroup`: (name, assembly, single, features)."""
    template = mux_template(phys)
    input_array_size = "200"
    cases = []
    vp = False
    vpsb = False
    for is_single in (True, False):
        extra_cap = (
            "OpCapability PhysicalStorageBufferAddressesEXT\n"
            if phys
            else ("OpCapability VariablePointersStorageBuffer\n" if is_single else "OpCapability VariablePointers\n")
        )
        buffer_type = "single_buffer" if is_single else "two_buffers"
        mux_input1 = " %inloc_a_2i " if is_single else " %inloc_a_i "
        mux_input2 = " %inloc_a_2i_plus_1 " if is_single else " %inloc_b_i "
        if not phys:
            if is_single:
                vpsb = True
            else:
                vp = True

        def add(name, specs):
            values = {
                "ExtraCapability": extra_cap,
                "ExtraTypes": "",
                "ExtraGlobalScopeVars": "",
                "ExtraFunctionScopeVars": "",
                "ExtraSetupComputations": "",
                "ExtraDecorations": "",
                "VarPtrName": "%mux_output_var_ptr",
            }
            values.update(specs)
            cases.append((name, specialize(template, values), is_single, vp, vpsb, name.startswith("writes_")))

        add("reads_opselect_" + buffer_type, {"ResultStrategy": "%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg" + mux_input1 + mux_input2 + "\n"})
        add(
            "reads_opfunctioncall_" + buffer_type,
            {"ResultStrategy": "%mux_output_var_ptr = OpFunctionCall %sb_f32ptr %choose_input_func %is_neg" + mux_input1 + mux_input2 + "\n"},
        )
        add(
            "reads_opphi_" + buffer_type,
            {
                "ResultStrategy": "                              OpSelectionMerge %end_label None\n"
                "                              OpBranchConditional %is_neg %take_mux_input_1 %take_mux_input_2\n"
                "%take_mux_input_1 = OpLabel\n"
                "                              OpBranch %end_label\n"
                "%take_mux_input_2 = OpLabel\n"
                "                              OpBranch %end_label\n"
                "%end_label = OpLabel\n"
                "%mux_output_var_ptr = OpPhi %sb_f32ptr" + mux_input1 + "%take_mux_input_1" + mux_input2 + "%take_mux_input_2\n"
            },
        )
        add(
            "reads_opcopyobject_" + buffer_type,
            {
                "ResultStrategy": "%mux_input_1_copy = OpCopyObject %sb_f32ptr" + mux_input1 + "\n"
                "%mux_input_2_copy = OpCopyObject %sb_f32ptr" + mux_input2 + "\n"
                "%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg %mux_input_1_copy %mux_input_2_copy\n"
            },
        )
        for class_id, storage_class in enumerate(("Private", "Function")):
            extra_variable = "%mux_output_copy = OpVariable %sb_f32ptrptr " + storage_class + "\n"
            add(
                "stores_" + storage_class.lower() + "_" + buffer_type,
                {
                    "ExtraTypes": "%sb_f32ptrptr = OpTypePointer " + storage_class + " %sb_f32ptr\n",
                    "ExtraGlobalScopeVars": extra_variable if class_id == 0 else "",
                    "ExtraFunctionScopeVars": extra_variable if class_id == 1 else "",
                    "ExtraDecorations": "OpDecorate %mux_output_copy AliasedPointerEXT\n" if phys else "",
                    "ResultStrategy": "%opselect_result = OpSelect %sb_f32ptr %is_neg" + mux_input1 + mux_input2 + "\n"
                    "                              OpStore %mux_output_copy %opselect_result\n"
                    "%mux_output_var_ptr = OpLoad %sb_f32ptr %mux_output_copy Aligned 4\n",
                },
            )
        in_1 = " %a_2i_ptr " if is_single else " %a_i_ptr "
        in_2 = " %a_2i_plus_1_ptr " if is_single else " %b_i_ptr "
        add(
            "reads_opptraccesschain_" + buffer_type,
            {
                "ResultStrategy": "%a_ptr = OpAccessChain %sb_f32ptr %indata_a %zero %zero\n"
                "%b_ptr = OpAccessChain %sb_f32ptr %indata_b %zero %zero\n"
                "%s_ptr = OpAccessChain %sb_f32ptr %indata_s %zero %zero\n"
                "%out_ptr               = OpAccessChain %sb_f32ptr %outdata  %zero %zero\n"
                "%a_i_ptr               = OpPtrAccessChain %sb_f32ptr %a_ptr %i\n"
                "%b_i_ptr               = OpPtrAccessChain %sb_f32ptr %b_ptr %i\n"
                "%s_i_ptr               = OpPtrAccessChain %sb_f32ptr %s_ptr %i\n"
                "%a_2i_ptr              = OpPtrAccessChain %sb_f32ptr %a_ptr %two_i\n"
                "%a_2i_plus_1_ptr       = OpPtrAccessChain %sb_f32ptr %a_ptr %two_i_plus_1\n"
                "%mux_output_var_ptr    = OpSelect %sb_f32ptr %is_neg" + in_1 + in_2 + "\n"
            },
        )
        add(
            "writes_" + buffer_type,
            {
                "ResultStrategy": "%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg" + mux_input1 + mux_input2 + "\n"
                "               %val = OpLoad %f32 %mux_output_var_ptr Aligned 4\n"
                "        %val_plus_1 = OpFAdd %f32 %val %fone\n"
                "                         OpStore %mux_output_var_ptr %val_plus_1 Aligned 4\n"
            },
        )
        if not phys and not is_single:
            add(
                "workgroup_" + buffer_type,
                {
                    "ExtraTypes": "%c_i32_N = OpConstant %i32 " + input_array_size + " \n"
                    "%f32arr_N = OpTypeArray %f32 %c_i32_N\n"
                    "%f32arr_wrkgrp_ptr = OpTypePointer Workgroup %f32arr_N\n"
                    "%f32_wrkgrp_ptr = OpTypePointer Workgroup %f32\n",
                    "ExtraGlobalScopeVars": "%AW = OpVariable %f32arr_wrkgrp_ptr Workgroup\n%BW = OpVariable %f32arr_wrkgrp_ptr Workgroup\n",
                    "ExtraSetupComputations": "%loc_AW_i = OpAccessChain %f32_wrkgrp_ptr %AW %i\n"
                    "%loc_BW_i = OpAccessChain %f32_wrkgrp_ptr %BW %i\n"
                    "%inval_a_i = OpLoad %f32 %inloc_a_i\n"
                    "%inval_b_i = OpLoad %f32 %inloc_b_i\n"
                    "%inval_a_2i = OpLoad %f32 %inloc_a_2i\n"
                    "%inval_a_2i_plus_1 = OpLoad %f32 %inloc_a_2i_plus_1\n",
                    "VarPtrName": "%output_var_ptr",
                    "ResultStrategy": "                          OpStore %loc_AW_i %inval_a_i\n"
                    "                          OpStore %loc_BW_i %inval_b_i\n"
                    "%output_var_ptr = OpSelect %f32_wrkgrp_ptr %is_neg %loc_AW_i %loc_BW_i\n",
                },
            )
    return cases


def complex_template(phys):
    common_decorations = (
        (PHYS_STRUCT_DECORATIONS + "OpDecorate %first_param Restrict\nOpDecorate %second_param Restrict\n")
        if phys
        else "OpDecorate %outdata DescriptorSet 0            \nOpDecorate %outdata Binding 3                    \n"
    )
    common_decorations += (
        "OpDecorate %id BuiltIn GlobalInvocationId        \n"
        "OpDecorate %output_buffer    Block                \n"
        "OpMemberDecorate %output_buffer 0 Offset 0        \n"
        "OpMemberDecorate %input_buffer  0 Offset 0        \n"
        "OpMemberDecorate %input_buffer  1 Offset 256    \n"
        "OpMemberDecorate %outer_struct  0 Offset 0        \n"
        "OpMemberDecorate %inner_struct  0 Offset 0        \n"
        "OpMemberDecorate %inner_struct  1 Offset 32    \n"
        "OpDecorate %arr2_v4float        ArrayStride 16        \n"
        "OpDecorate %arr2_inner_struct   ArrayStride 64        \n"
        "OpDecorate %mat2x2_inner_struct ArrayStride 128    \n"
        "OpDecorate %outer_struct_ptr    ArrayStride 256    \n"
        "OpDecorate %v4f32_ptr           ArrayStride 16        \n"
    )
    types = (
        "%c_bool_true = OpConstantTrue    %bool                            \n"
        "%c_bool_false = OpConstantFalse    %bool                            \n"
        "%c_i32_0 = OpConstant        %i32        0                    \n"
        "%c_i32_1 = OpConstant        %i32        1                    \n"
        "%c_i32_2 = OpConstant        %i32        2                    \n"
        "%c_i32_3 = OpConstant        %i32        3                    \n"
        "%c_u32_2 = OpConstant        %u32        2                    \n"
        "%v4f32                 = OpTypeVector %f32 4                               \n"
        "%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        \n"
        "%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            \n"
        "%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                \n"
        "%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            \n"
        "%outer_struct = OpTypeStruct %mat2x2_inner_struct                    \n"
        "%input_buffer = OpTypeStruct %outer_struct %outer_struct            \n"
        "%output_buffer = OpTypeStruct %f32                                    \n"
    )
    if phys:
        types += (
            "%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        \n"
            "%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            \n"
            "%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            \n"
            "%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    \n"
            "%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    \n"
            "%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            \n"
            "%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            \n"
            "%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                \n"
            "%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    \n"
            "%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr\n"
            "%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct\n"
            "%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr\n"
            "%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr\n"
            "%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr\n"
        )
    else:
        types += (
            "%output_buffer_ptr = OpTypePointer StorageBuffer %output_buffer        \n"
            "%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            \n"
            "%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            \n"
            "%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    \n"
            "%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    \n"
            "%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            \n"
            "%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            \n"
            "%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                \n"
            "%sb_f32ptr = OpTypePointer StorageBuffer %f32                    \n"
        )
    types += "${extra_types}\n"
    types += (
        "%id = OpVariable %uvec3ptr            Input                \n%indata_all = OpVariable %physPtrsStructPtr StorageBuffer\n"
        if phys
        else "%id = OpVariable %uvec3ptr            Input                \n%outdata = OpVariable %output_buffer_ptr    StorageBuffer        \n"
    )

    text = "OpCapability Shader\n${extra_capability}\n"
    text += 'OpExtension "SPV_KHR_physical_storage_buffer"\n' if phys else 'OpExtension "SPV_KHR_variable_pointers"\n'
    text += (
        'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
        "OpMemoryModel " + ("PhysicalStorageBuffer64EXT" if phys else "Logical") + " GLSL450\n"
        'OpEntryPoint GLCompute %main "main" %id\n'
        "OpExecutionMode %main LocalSize 1 1 1\n"
        "OpSource GLSL 430\n"
        'OpName %main           "main"\n'
        'OpName %id             "gl_GlobalInvocationID"\n'
        + common_decorations
        + "${input_decorations}\n"
        + COMMON_TYPES
        + types
        + "${input_variables}\n"
        "%selector_func_type = OpTypeFunction ${selected_type} %bool ${selected_type} ${selected_type}\n"
        "%choose_input_func = OpFunction ${selected_type} None %selector_func_type\n"
        "%choose_first_param = OpFunctionParameter %bool\n"
        "%first_param = OpFunctionParameter ${selected_type}\n"
        "%second_param = OpFunctionParameter ${selected_type}\n"
        "%selector_func_begin = OpLabel\n"
        "%result_ptr = OpSelect ${selected_type} %choose_first_param %first_param %second_param\n"
        "OpReturnValue %result_ptr\n"
        "OpFunctionEnd\n"
        "%main = OpFunction %void None %voidf\n"
        "%label = OpLabel\n"
    )
    if phys:
        text += (
            "%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0\n"
            "%inputA = OpLoad %outer_struct_ptr %inputA_ptr\n"
            "%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1\n"
            "%inputB = OpLoad %outer_struct_ptr %inputB_ptr\n"
            "%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2\n"
            "%inputC = OpLoad %input_buffer_ptr %inputC_ptr\n"
            "%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3\n"
            "%outdata = OpLoad %output_buffer_ptr %outdata_ptr\n"
        )
    text += (
        "${input_intermediates}\n"
        "${a_loc} \n"
        "${b_loc} \n"
        "${selection_strategy} \n"
        "%result_loc = OpAccessChain %sb_f32ptr %var_ptr  ${remaining_indexes} \n"
        "%result_val = OpLoad %f32 %result_loc Aligned 4\n"
        "%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0\n"
        "                          OpStore %outdata_loc %result_val Aligned 4\n"
        "                          OpReturn\n"
        "                          OpFunctionEnd\n"
    )
    return text


def base_offset(row, col, inner, vec4_array, vec4):
    return row * 32 + col * 16 + inner * 8 + vec4_array * 4 + vec4


def base_offset_single(outer, row, col, inner, vec4_array, vec4):
    offset = base_offset(row, col, inner, vec4_array, vec4)
    return offset + 64 if outer == 1 else offset


def complex_cases(phys):
    """`addComplexTypesPhysicalOrVariablePointersComputeGroup`: (name, assembly, single, select_a, offset, features)."""
    template = complex_template(phys)
    ab_decorations = "" if phys else "OpDecorate %inputA DescriptorSet 0                \nOpDecorate %inputB DescriptorSet 0                \nOpDecorate %inputA Binding 0                    \nOpDecorate %inputB Binding 1                    \n"
    ab_decorations += "OpDecorate %outer_struct    Block                \n"
    c_decorations = "" if phys else "OpDecorate %inputC DescriptorSet 0                \nOpDecorate %inputC Binding 2                    \n"
    c_decorations += "" if phys else "OpDecorate %input_buffer    Block                \n"
    ab_variables = "" if phys else "%inputA = OpVariable %outer_struct_ptr    StorageBuffer        \n%inputB = OpVariable %outer_struct_ptr    StorageBuffer        \n"
    c_variables = "" if phys else "%inputC = OpVariable %input_buffer_ptr    StorageBuffer        \n"
    c_intermediates = "%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0\n%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1\n"

    cases = []
    vp = False
    vpsb = False
    for is_single in (0, 1):
        if not phys:
            if is_single:
                vpsb = True
            else:
                vp = True
        for select_a in (0, 1):
            extra_cap = (
                "OpCapability PhysicalStorageBufferAddressesEXT\n"
                if phys
                else ("OpCapability VariablePointersStorageBuffer\n" if is_single else "OpCapability VariablePointers\n")
            )
            input_decorations = c_decorations if is_single else ab_decorations
            input_variables = c_variables if is_single else ab_variables
            input_intermediates = c_intermediates if is_single else ""
            buffer_type = "single_buffer_" if is_single else "two_buffers_"
            base_a = "%inputC_a" if is_single else "%inputA"
            base_b = "%inputC_b" if is_single else "%inputB"
            selected_input = "first_input" if select_a else "second_input"
            spirv_select_a = "%c_bool_true" if select_a else "%c_bool_false"
            outer = (0 if select_a else 1) if is_single else 0

            indexes = [
                (outer, 0, 0, 0, 0, 1), (outer, 1, 0, 1, 0, 2), (outer, 0, 1, 0, 1, 3), (outer, 1, 1, 1, 0, 0),
                (outer, 0, 0, 1, 1, 1), (outer, 1, 0, 0, 0, 2), (outer, 1, 1, 1, 1, 3),
            ]
            level_names = ["_outer_struct_", "_matrices_", "_arrays_", "_inner_structs_", "_vec4arr_", "_vec4_", "_float_"]

            def locations(base, tag, chain_op):
                if chain_op == "OpAccessChain":
                    return [
                        "",
                        f"%{tag}_loc = OpAccessChain %mat2x2_ptr       " + base + " %c_i32_0",
                        f"%{tag}_loc = OpAccessChain %arr2_ptr         " + base + " %c_i32_0 %c_i32_0",
                        f"%{tag}_loc = OpAccessChain %inner_struct_ptr " + base + " %c_i32_0 %c_i32_1 %c_i32_1",
                        f"%{tag}_loc = OpAccessChain %arr_v4f32_ptr    " + base + " %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1",
                        f"%{tag}_loc = OpAccessChain %v4f32_ptr        " + base + " %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0",
                        f"%{tag}_loc = OpAccessChain %sb_f32ptr        " + base + " %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3",
                    ]
                return [
                    "",
                    f"%{tag}_loc = OpPtrAccessChain %mat2x2_ptr       " + base + " %c_i32_0 %c_i32_0",
                    f"%{tag}_loc = OpPtrAccessChain %arr2_ptr         " + base + " %c_i32_0 %c_i32_0 %c_i32_0",
                    f"%{tag}_loc = OpPtrAccessChain %inner_struct_ptr " + base + " %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1",
                    f"%{tag}_loc = OpPtrAccessChain %arr_v4f32_ptr    " + base + " %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1",
                    f"%{tag}_loc = OpPtrAccessChain %v4f32_ptr        " + base + " %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0",
                    f"%{tag}_loc_arr = OpPtrAccessChain %arr_v4f32_ptr " + base + " %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 "
                    f"%{tag}_loc_first_elem = OpAccessChain %v4f32_ptr %{tag}_loc_arr %c_i32_0 "
                    f"%{tag}_loc = OpPtrAccessChain %sb_f32ptr %{tag}_loc_first_elem %c_i32_1 %c_i32_3",
                ]

            a_locations = locations(base_a, "a", "OpAccessChain")
            b_locations = locations(base_b, "b", "OpAccessChain")
            a_ptr_chain = locations(base_a, "a", "OpPtrAccessChain")
            b_ptr_chain = locations(base_b, "b", "OpPtrAccessChain")
            remaining = [
                "%c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1",
                "%c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2",
                "%c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3",
                "%c_i32_1 %c_i32_0 %c_i32_0",
                "%c_i32_1 %c_i32_1",
                "%c_i32_2",
                "",
            ]
            pointer_types = ["%outer_struct_ptr", "%mat2x2_ptr", "%arr2_ptr", "%inner_struct_ptr", "%arr_v4f32_ptr", "%v4f32_ptr", "%sb_f32ptr"]
            base_a_names = [base_a] + ["%a_loc"] * 6
            base_b_names = [base_b] + ["%b_loc"] * 6

            for level in range(7):
                offset = base_offset_single(*indexes[level])
                pointer_type = pointer_types[level]
                strategies = {
                    "opselect": "%var_ptr = OpSelect " + pointer_type + " " + spirv_select_a + " " + base_a_names[level] + " " + base_b_names[level] + "\n",
                    "opfunctioncall": "%var_ptr = OpFunctionCall " + pointer_type + " %choose_input_func " + spirv_select_a + " " + base_a_names[level] + " " + base_b_names[level] + "\n",
                    "opphi": "                  OpSelectionMerge %end_label None\n"
                    "                  OpBranchConditional " + spirv_select_a + " %take_input_a %take_input_b\n"
                    "%take_input_a = OpLabel\n"
                    "                  OpBranch %end_label\n"
                    "%take_input_b = OpLabel\n"
                    "                  OpBranch %end_label\n"
                    "%end_label = OpLabel\n"
                    "%var_ptr = OpPhi " + pointer_type + " " + base_a_names[level] + " %take_input_a " + base_b_names[level] + " %take_input_b\n",
                    "opcopyobject": "%in_a_copy = OpCopyObject " + pointer_type + " " + base_a_names[level] + "\n"
                    "%in_b_copy = OpCopyObject " + pointer_type + " " + base_b_names[level] + "\n"
                    "%var_ptr = OpSelect " + pointer_type + " " + spirv_select_a + " %in_a_copy %in_b_copy\n",
                    "opptraccesschain": "%var_ptr = OpSelect " + pointer_type + " " + spirv_select_a + " " + base_a_names[level] + " " + base_b_names[level] + "\n",
                }
                for op in ("opselect", "opfunctioncall", "opphi", "opcopyobject", "opptraccesschain"):
                    ptr_chain = op == "opptraccesschain"
                    values = {
                        "extra_types": "",
                        "extra_capability": extra_cap,
                        "input_decorations": input_decorations,
                        "input_variables": input_variables,
                        "input_intermediates": input_intermediates,
                        "selected_type": pointer_type,
                        "a_loc": (a_ptr_chain if ptr_chain else a_locations)[level],
                        "b_loc": (b_ptr_chain if ptr_chain else b_locations)[level],
                        "remaining_indexes": remaining[level],
                        "selection_strategy": strategies[op],
                    }
                    name = op + level_names[level] + buffer_type + selected_input
                    cases.append((name, specialize(template, values), bool(is_single), bool(select_a), offset, vp, vpsb))
    return cases


NULLPTR_TEMPLATE = (
    "OpCapability Shader\n"
    "OpCapability VariablePointers\n"
    'OpExtension "SPV_KHR_variable_pointers"\n'
    'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpSource GLSL 430\n"
    'OpName %main           "main"\n'
    'OpName %id             "gl_GlobalInvocationID"\n'
    "OpDecorate %id BuiltIn GlobalInvocationId        \n"
    "OpDecorate %input DescriptorSet 0                \n"
    "OpDecorate %outdata DescriptorSet 0            \n"
    "OpDecorate %input Binding 0                    \n"
    "OpDecorate %outdata Binding 1                    \n"
    "OpDecorate %float_struct    Block                \n"
    "OpMemberDecorate %float_struct 0 Offset 0        \n"
    + COMMON_TYPES
    + "%float_struct = OpTypeStruct %f32                                            \n"
    "%float_struct_ptr = OpTypePointer StorageBuffer %float_struct                    \n"
    "%sb_f32ptr = OpTypePointer StorageBuffer %f32                            \n"
    "%func_f32ptrptr = OpTypePointer Function %sb_f32ptr                            \n"
    "%c_bool_true = OpConstantTrue    %bool                                    \n"
    "%c_i32_0 = OpConstant        %i32        0                            \n"
    "%c_null_ptr = OpConstantNull    %sb_f32ptr                                \n"
    "%id = OpVariable %uvec3ptr            Input                        \n"
    "%input = OpVariable %float_struct_ptr    StorageBuffer                \n"
    "%outdata = OpVariable %float_struct_ptr    StorageBuffer                \n"
    "%main = OpFunction %void None %voidf\n"
    "%label = OpLabel\n"
    "%f32_ptr_var            = OpVariable %func_f32ptrptr Function %c_null_ptr\n"
    "%input_loc = OpAccessChain %sb_f32ptr %input %c_i32_0\n"
    "%output_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0\n"
    "${NullptrTestingStrategy}\n"
    "                          OpReturn\n"
    "                          OpFunctionEnd\n"
)

NULLPTR_STRATEGIES = [
    (
        "opvariable_initialized_null",
        "                  OpStore %f32_ptr_var %input_loc       \n"
        "%loaded_f32_ptr = OpLoad  %sb_f32ptr   %f32_ptr_var    \n"
        "%loaded_f32     = OpLoad  %f32         %loaded_f32_ptr \n"
        "                  OpStore %output_loc  %loaded_f32     \n",
    ),
    (
        "opselect_null_or_valid_ptr",
        "%selected_ptr = OpSelect %sb_f32ptr %c_bool_true %input_loc %c_null_ptr\n%loaded_var = OpLoad %f32 %selected_ptr\nOpStore %output_loc %loaded_var\n",
    ),
]


def main():
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.{variable_pointers,physical_pointers}\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_pointers_manifest.py - do not hand-edit; `spec` says how the host builds the data of a case.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/pointers_tests"\n'
    ]
    count = 0

    def emit(path, assembly, spec):
        nonlocal count
        name = "/".join(path)
        const = "PTR_" + name.replace("/", "_").upper()
        out.append(
            f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "PointersCase"\n'
            f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
            f"derived = {{ source = {json.dumps(repr(assembly))} }}\n"
        )
        count += 1

    for kind, phys in (("variable_pointers", False), ("physical_pointers", True)):
        for b64 in (False, True):
            prefix = [kind] + (["64b_indexing"] if b64 else [])
            flags = f"phys={int(phys)};b64={int(b64)}"
            for name, assembly, single, vp, vpsb, is_write in mux_cases(phys):
                emit(prefix + ["compute", name], assembly, f"group=mux;single={int(single)};write={int(is_write)};vp={int(vp)};vpsb={int(vpsb)};{flags}")
            for name, assembly, single, select_a, offset, vp, vpsb in complex_cases(phys):
                emit(prefix + ["complex_types_compute", name], assembly, f"group=complex;single={int(single)};sel={int(select_a)};offset={offset};vp={int(vp)};vpsb={int(vpsb)};{flags}")
            if not phys:
                for name, strategy in NULLPTR_STRATEGIES:
                    emit(prefix + ["nullptr_compute", name], specialize(NULLPTR_TEMPLATE, {"NullptrTestingStrategy": strategy}), f"group=nullptr;single=0;vp=1;vpsb=0;{flags}")

    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()

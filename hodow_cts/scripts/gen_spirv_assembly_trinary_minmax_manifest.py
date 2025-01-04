#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_trinary_minmax.toml: dEQP-VK.spirv_assembly.instruction.amd_trinary_minmax.{min3,max3,mid3}.<type>.<aggregation>
(vktSpvAsmTrinaryMinMaxTests.cpp, 132 cases of VK_AMD_shader_trinary_minmax on 8 to 64 bit integers and 16 to 64 bit floats, as scalars and vec2 to vec4).

`TrinaryMinMaxCase::getSpirVReplacements` and `initPrograms` fill one assembly template per case; this fills it the same way and replays the loops of `createTrinaryMinMaxGroup`
for the names and for the random seed of each case (`0xFEE768FC` counting up in creation order), which rides along as `spec` for src/vkt/tests/spirv_assembly/trinary_minmax_tests.rs.

    python3 hodow_cts/scripts/gen_spirv_assembly_trinary_minmax_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_trinary_minmax.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmTrinaryMinMaxTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"
ARRAY_SIZE = 100

SHADER = (
    "; SPIR-V\n"
    "; Version: 1.5\n"
    "                            OpCapability Shader\n"
    "${CAPABILITIES}"
    '                            OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
    '                            OpExtension "SPV_AMD_shader_trinary_minmax"\n'
    "${EXTENSIONS}"
    '                  %std450 = OpExtInstImport "GLSL.std.450"\n'
    '                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"\n'
    "                            OpMemoryModel Logical GLSL450\n"
    '                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer\n'
    "                            OpExecutionMode %main LocalSize 1 1 1\n"
    "                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId\n"
    "                            OpDecorate %results_array_t ArrayStride ${OPERAND_SIZE}\n"
    "                            OpMemberDecorate %OutputBlock 0 Offset 0\n"
    "                            OpDecorate %OutputBlock Block\n"
    "                            OpDecorate %output_buffer DescriptorSet 0\n"
    "                            OpDecorate %output_buffer Binding 1\n"
    "                            OpMemberDecorate %Operands 0 Offset 0\n"
    "                            OpMemberDecorate %Operands 1 Offset ${OPERAND_SIZE}\n"
    "                            OpMemberDecorate %Operands 2 Offset ${OPERAND_SIZE_2TIMES}\n"
    "                            OpDecorate %_arr_Operands_arraysize ArrayStride ${OPERAND_SIZE_3TIMES}\n"
    "                            OpMemberDecorate %InputBlock 0 Offset 0\n"
    "                            OpDecorate %InputBlock Block\n"
    "                            OpDecorate %input_buffer DescriptorSet 0\n"
    "                            OpDecorate %input_buffer Binding 0\n"
    "                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize\n"
    "                    %void = OpTypeVoid\n"
    "                %voidfunc = OpTypeFunction %void\n"
    "                     %int = OpTypeInt 32 1\n"
    "                    %uint = OpTypeInt 32 0\n"
    "                  %v3uint = OpTypeVector %uint 3\n"
    "${TYPES}"
    "                   %int_0 = OpConstant %int 0\n"
    "                   %int_1 = OpConstant %int 1\n"
    "                   %int_2 = OpConstant %int 2\n"
    "                  %uint_1 = OpConstant %uint 1\n"
    "                  %uint_0 = OpConstant %uint 0\n"
    "               %arraysize = OpConstant %uint ${ARRAY_SIZE}\n"
    "      %_ptr_Function_uint = OpTypePointer Function %uint\n"
    "       %_ptr_Input_v3uint = OpTypePointer Input %v3uint\n"
    "   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input\n"
    "         %_ptr_Input_uint = OpTypePointer Input %uint\n"
    "         %results_array_t = OpTypeArray ${OPERAND_TYPE} %arraysize\n"
    "                %Operands = OpTypeStruct ${OPERAND_TYPE} ${OPERAND_TYPE} ${OPERAND_TYPE}\n"
    " %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize\n"
    "             %OutputBlock = OpTypeStruct %results_array_t\n"
    "              %InputBlock = OpTypeStruct %_arr_Operands_arraysize\n"
    "%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock\n"
    " %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock\n"
    "           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer\n"
    "            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer\n"
    "              %optype_ptr = OpTypePointer StorageBuffer ${OPERAND_TYPE}\n"
    "        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1\n"
    "                    %main = OpFunction %void None %voidfunc\n"
    "               %mainlabel = OpLabel\n"
    "                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0\n"
    "                     %idx = OpLoad %uint %gidxptr\n"
    "                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0\n"
    "                     %op1 = OpLoad ${OPERAND_TYPE} %op1ptr\n"
    "                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1\n"
    "                     %op2 = OpLoad ${OPERAND_TYPE} %op2ptr\n"
    "                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2\n"
    "                     %op3 = OpLoad ${OPERAND_TYPE} %op3ptr\n"
    "                  %result = OpExtInst ${OPERAND_TYPE} %trinary ${OPERATION_NAME} %op1 %op2 %op3\n"
    "               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx\n"
    "                            OpStore %resultptr %result\n"
    "                            OpReturn\n"
    "                            OpFunctionEnd\n"
)


def assembly(operation, base, size, components):
    byte_size = size // 8
    effective = 4 if components == 3 else components
    operand_size = effective * byte_size
    capabilities = ""
    extensions = ""
    types = ""
    if base in ("i", "u"):
        if size == 8:
            capabilities += "OpCapability Int8\n"
        elif size == 16:
            capabilities += "OpCapability Int16\n"
        elif size == 64:
            capabilities += "OpCapability Int64\n"
    else:
        if size == 16:
            capabilities += "OpCapability Float16\n"
        elif size == 64:
            capabilities += "OpCapability Float64\n"
    if size == 8:
        capabilities += "OpCapability StorageBuffer8BitAccess\n"
        extensions += 'OpExtension "SPV_KHR_8bit_storage"\n'
    elif size == 16:
        capabilities += "OpCapability StorageBuffer16BitAccess\n"
        extensions += 'OpExtension "SPV_KHR_16bit_storage"\n'

    if base in ("i", "u"):
        sign_bit = "1" if base == "i" else "0"
        prefix = "u" if base == "u" else ""
        if size != 32:
            base_name = f"{prefix}int{size}_t"
            types += f"%{base_name} = OpTypeInt {size} {sign_bit}\n"
        else:
            base_name = f"{prefix}int"
        if components == 1:
            operand_type = "%" + base_name
        else:
            type_name = f"%v{components}{base_name}"
            if not (base == "u" and size == 32 and components == 3):
                types += f"{type_name} = OpTypeVector %{base_name} {components}\n"
            operand_type = type_name
    else:
        base_name = f"float{size}_t"
        types += f"%{base_name} = OpTypeFloat {size}\n"
        if components == 1:
            operand_type = "%" + base_name
        else:
            type_name = f"%v{components}{base_name}"
            types += f"{type_name} = OpTypeVector %{base_name} {components}\n"
            operand_type = type_name

    op_name = {"i": "S", "u": "U", "f": "F"}[base] + {"min": "Min", "max": "Max", "mid": "Mid"}[operation] + "3AMD"
    values = {
        "CAPABILITIES": capabilities,
        "EXTENSIONS": extensions,
        "OPERAND_SIZE": str(operand_size),
        "OPERAND_SIZE_2TIMES": str(operand_size * 2),
        "OPERAND_SIZE_3TIMES": str(operand_size * 3),
        "ARRAY_SIZE": str(ARRAY_SIZE),
        "TYPES": types,
        "OPERAND_TYPE": operand_type,
        "OPERATION_NAME": op_name,
    }
    text = SHADER
    for key, value in values.items():
        text = text.replace("${" + key + "}", value)
    assert "${" not in text
    return text


def main():
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.amd_trinary_minmax.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_trinary_minmax_manifest.py - do not hand-edit; `spec` is the operation, the type and the random seed of a case.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/trinary_minmax_tests"\n'
    ]
    seed = 0xFEE768FC
    count = 0
    for operation, op_name in (("min", "min3"), ("max", "max3"), ("mid", "mid3")):
        for base in ("i", "u", "f"):
            for size in (8, 16, 32, 64):
                if base == "f" and size == 8:
                    continue
                for components, agg_name in ((1, "scalar"), (2, "vec2"), (3, "vec3"), (4, "vec4")):
                    name = f"amd_trinary_minmax/{op_name}/{base}{size}/{agg_name}"
                    const = "TMM_" + "".join(c if c.isalnum() else "_" for c in name).upper()
                    spec = f"op={operation};base={base};size={size};components={components};seed={seed}"
                    out.append(
                        f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "TrinaryMinMaxCase"\n'
                        f'programs = [ {{ name = "comp", template = "{TEMPLATE}", stage = "asm", spirv_version = "spirv1.5" }} ]\n'
                        f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
                        f"derived = {{ source = {json.dumps(repr(assembly(operation, base, size, components)))} }}\n"
                    )
                    seed += 1
                    count += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_raw_access_chain_{load,store}.toml: the 6160 cases of dEQP-VK.spirv_assembly.instruction.compute.raw_access_chain.

`addTests` of vktSpvAsmRawAccessChainTests.cpp walks a dozen nested loops (load or store, variable pointers, descriptor indexing, physical buffers, 64 bit
indexing, the bounds check mode, the load and store qualifiers, stride or not, the element size and component count, the alignment divisor) and `addTest`
builds one SPIR-V assembly module per combination with its `CodeGen`. This replays both, in the same order and with the same names, and writes the
module as the case's `compute` program; the `Parameters` that the host needs to draw the data and to bind the buffers ride along as the `spec` string,
which src/vkt/tests/spirv_assembly/raw_access_chain_tests.rs reads. The load and the store half are two manifests to keep each of them under the size
a git host warns about.

    python3 hodow_cts/scripts/gen_spirv_assembly_raw_access_chain_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
MANIFESTS = CRATE / "shaders" / "manifest"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmRawAccessChainTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"

NO_BOUNDS_CHECK, BOUNDS_CHECK_PER_COMPONENT, BOUNDS_CHECK_PER_ELEMENT = 0, 1, 2
QUALIFIER_NONE = 0
QUALIFIER_LOAD_NON_WRITABLE = 1 << 0
QUALIFIER_LOAD_VOLATILE = 1 << 1
QUALIFIER_LOAD_COHERENT = 1 << 2
QUALIFIER_STORE_NON_READABLE = 1 << 3
QUALIFIER_STORE_VOLATILE = 1 << 4
QUALIFIER_STORE_COHERENT = 1 << 5
WHOLE_SIZE = -1
LOCAL_SIZE = 32


def is_pow2(value):
    return value > 0 and value & (value - 1) == 0


class CodeGen:
    def __init__(self):
        self.capabilities = ""
        self.extensions = ""
        self.header = ""
        self.decorations = ""
        self.declarations = ""
        self.body = ""
        self.defined = set()

    def uint32(self, value):
        definition = f"%uint_{value}"
        if value not in self.defined:
            self.defined.add(value)
            self.declarations += f"{definition} = OpConstant %uint {value}\n"
        return definition

    def result(self):
        return self.capabilities + self.extensions + self.header + self.decorations + self.declarations + self.body


def robustness_operand(bounds_check):
    return {NO_BOUNDS_CHECK: "", BOUNDS_CHECK_PER_COMPONENT: " RobustnessPerComponentNV", BOUNDS_CHECK_PER_ELEMENT: " RobustnessPerElementNV"}[bounds_check]


def load_decorations(p, gen, ptr):
    if p["qualifiers"] & QUALIFIER_LOAD_NON_WRITABLE:
        gen.decorations += f"OpDecorate {ptr} NonWritable\n"
    if p["qualifiers"] & QUALIFIER_LOAD_VOLATILE:
        gen.decorations += f"OpDecorate {ptr} Volatile\n"
    if p["qualifiers"] & QUALIFIER_LOAD_COHERENT:
        gen.decorations += f"OpDecorate {ptr} Coherent\n"


def store_decorations(p, gen, ptr):
    if p["qualifiers"] & QUALIFIER_STORE_NON_READABLE:
        gen.decorations += f"OpDecorate {ptr} NonReadable\n"
    if p["qualifiers"] & QUALIFIER_STORE_VOLATILE:
        gen.decorations += f"OpDecorate {ptr} Volatile\n"
    if p["qualifiers"] & QUALIFIER_STORE_COHERENT:
        gen.decorations += f"OpDecorate {ptr} Coherent\n"


def assembly(p):
    input_stride = p["input_components"] * p["input_size"] + p["input_pre"] + p["input_post"]
    output_stride = p["output_components"] * p["output_size"] + p["output_pre"] + p["output_post"]

    gen = CodeGen()
    gen.capabilities += "OpCapability Shader\nOpCapability RawAccessChainsNV\n"
    gen.extensions += 'OpExtension "SPV_NV_raw_access_chains"\n'
    gen.header += '%glslExt = OpExtInstImport "GLSL.std.450"\n'

    if p["physical_buffers"]:
        gen.capabilities += "OpCapability PhysicalStorageBufferAddresses\n"
        gen.extensions += 'OpExtension "SPV_KHR_physical_storage_buffer"\n'
        gen.header += "OpMemoryModel PhysicalStorageBuffer64 GLSL450\n"
    else:
        gen.header += "OpMemoryModel Logical GLSL450\n"

    if p["physical_buffers"]:
        gen.header += 'OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants\n'
    elif p["descriptor_indexing"]:
        gen.header += 'OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffers %outputBuffers\n'
    else:
        gen.header += 'OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer\n'

    gen.header += f"OpExecutionMode %main LocalSize {LOCAL_SIZE} 1 1\n"
    gen.decorations += "OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId\n"

    size = p["input_size"]
    if size == 8:
        gen.capabilities += "OpCapability Int64\n"
        gen.declarations += "%type = OpTypeInt 64 1\n"
    elif size == 4:
        gen.declarations += "%type = OpTypeInt 32 1\n"
    elif size == 2:
        gen.capabilities += "OpCapability Int16\n"
        gen.declarations += "%type = OpTypeInt 16 1\n"
    elif size == 1:
        gen.capabilities += "OpCapability Int8\n"
        gen.declarations += "%type = OpTypeInt 8 1\n"

    if p["variable_pointers"]:
        gen.capabilities += "OpCapability VariablePointers\n"

    gen.declarations += (
        "%void = OpTypeVoid\n"
        "%v2type = OpTypeVector %type 2\n"
        "%v3type = OpTypeVector %type 3\n"
        "%v4type = OpTypeVector %type 4\n"
        "%uint = OpTypeInt 32 0\n"
        "%v2uint = OpTypeVector %uint 2\n"
        "%v3uint = OpTypeVector %uint 3\n"
        "%v4uint = OpTypeVector %uint 4\n"
        "%TypeFunctionMain = OpTypeFunction %void\n"
        "%_ptr_Input_v3uint = OpTypePointer Input %v3uint\n"
        "%_ptr_Input_uint = OpTypePointer Input %uint\n"
        "%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input\n"
    )
    if p["physical_buffers"]:
        gen.declarations += (
            "%TypeStructBDAs = OpTypeStruct %v2uint %v2uint\n"
            "%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type\n"
            "%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type\n"
            "%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type\n"
            "%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type\n"
            "%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint\n"
            "%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs\n"
            "%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant\n"
        )
        gen.decorations += "OpDecorate %TypeStructBDAs Block\nOpMemberDecorate %TypeStructBDAs 0 Offset 0\nOpMemberDecorate %TypeStructBDAs 1 Offset 8\n"
    else:
        gen.declarations += (
            "%TypeStructUint = OpTypeStruct %uint\n"
            "%TypeStructPushConstant = OpTypeStruct %uint\n"
            "%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint\n"
            "%_ptr_Storage_type = OpTypePointer StorageBuffer %type\n"
            "%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type\n"
            "%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type\n"
            "%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type\n"
            "%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint\n"
            "%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant\n"
            "%pushConstants = OpVariable %_ptr_PushConstant PushConstant\n"
        )
        gen.decorations += (
            "OpDecorate %TypeStructUint Block\nOpMemberDecorate %TypeStructUint 0 Offset 0\n"
            "OpDecorate %TypeStructPushConstant Block\nOpMemberDecorate %TypeStructPushConstant 0 Offset 0\n"
        )
        if p["descriptor_indexing"]:
            gen.capabilities += "OpCapability RuntimeDescriptorArray\n"
            gen.decorations += "OpDecorate %outputBuffers DescriptorSet 1\nOpDecorate %outputBuffers Binding 0\nOpDecorate %inputBuffers DescriptorSet 0\nOpDecorate %inputBuffers Binding 0\n"
            gen.declarations += (
                "%TypeRuntimeArrayStructUint = OpTypeRuntimeArray %TypeStructUint\n"
                "%TypePointerBufferArray = OpTypePointer StorageBuffer %TypeRuntimeArrayStructUint\n"
                "%outputBuffers = OpVariable %TypePointerBufferArray StorageBuffer\n"
                "%inputBuffers = OpVariable %TypePointerBufferArray StorageBuffer\n"
            )
        else:
            gen.decorations += "OpDecorate %outputBuffer DescriptorSet 1\nOpDecorate %outputBuffer Binding 0\nOpDecorate %inputBuffer DescriptorSet 0\nOpDecorate %inputBuffer Binding 0\n"
            gen.declarations += "%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer\n%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer\n"

    scalar_output_type = "uint"
    if p["output_size"] != 4:
        bits = str(p["output_size"] * 8)
        scalar_output_type += bits
        gen.capabilities += "OpCapability Int" + bits + "\n"
        gen.declarations += "%" + scalar_output_type + " = OpTypeInt " + bits + " 0\n"

    output_type = scalar_output_type
    if p["output_components"] != 1:
        output_type = "v" + str(p["output_components"]) + scalar_output_type
        if p["output_size"] != 4:
            gen.declarations += "%" + output_type + " = OpTypeVector %" + scalar_output_type + " " + str(p["output_components"]) + "\n"
    if p["physical_buffers"]:
        gen.declarations += "%_ptr_Storage_" + output_type + " = OpTypePointer PhysicalStorageBuffer %" + output_type + "\n"
    else:
        gen.declarations += "%_ptr_Storage_" + output_type + " = OpTypePointer StorageBuffer %" + output_type + "\n"

    input_alignment = p["input_alignment"] or p["input_size"]
    output_alignment = p["output_alignment"] or p["output_size"]

    input_stride_text = gen.uint32(input_stride)
    output_stride_text = gen.uint32(output_stride)
    input_alignment_text = " Aligned " + str(input_alignment)
    output_alignment_text = " Aligned " + str(output_alignment)

    input_robustness = robustness_operand(p["input_bounds_check"])
    output_robustness = robustness_operand(p["output_bounds_check"])

    zero = gen.uint32(0)
    gen.body += (
        "%main = OpFunction %void None %TypeFunctionMain\n"
        "%mainLabel = OpLabel\n"
        "%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID " + zero + "\n"
        "%localInvocation = OpLoad %uint %localInvocationPtr\n"
    )

    result = "%value" if p["input_components"] > 1 else "%result"
    type_name = ("v" + str(p["input_components"]) + "type") if p["input_components"] > 1 else "type"
    load_decorations(p, gen, "%pointer")

    if p["stride_load"]:
        stride = input_stride_text
        element_index = "%localInvocation"
        offset = gen.uint32(p["input_pre"])
    else:
        stride = element_index = gen.uint32(0)
        offset = "%loadOffset"
        gen.body += "%elementOffset = OpIMul %uint %localInvocation " + input_stride_text + "\n%loadOffset = OpIAdd %uint %elementOffset " + gen.uint32(p["input_pre"]) + "\n"

    if p["physical_buffers"]:
        first = gen.uint32(0)
        gen.body += (
            "%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants " + first + "\n"
            "%inputBufferAddress = OpLoad %v2uint %inputBufferPointer\n"
            "%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress\n"
            "%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants " + gen.uint32(1) + "\n"
            "%outputBufferAddress = OpLoad %v2uint %outputBufferPointer\n"
            "%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress\n"
        )
    if p["descriptor_indexing"]:
        gen.body += (
            "%descriptorIndexPointer = OpAccessChain %_ptr_PushConstant_uint %pushConstants " + gen.uint32(0) + "\n"
            "%descriptorIndex = OpLoad %uint %descriptorIndexPointer\n"
            "%inputBuffer = OpAccessChain %TypePointerBuffer %inputBuffers %descriptorIndex\n"
            "%outputBuffer = OpAccessChain %TypePointerBuffer %outputBuffers %descriptorIndex\n"
        )

    gen.body += (
        "%pointer = OpRawAccessChainNV %_ptr_Storage_" + type_name + " %inputBuffer " + stride + " " + element_index + " " + offset + input_robustness + "\n"
        + result + " = OpLoad %" + type_name + " %pointer" + input_alignment_text + "\n"
    )

    for i in range(p["input_components"]):
        component_result = ("%value" + chr(ord("1") + i)) if p["input_components"] > 1 else "%result"
        if p["input_components"] > 1:
            gen.body += component_result + " = OpCompositeExtract %type %value " + str(i) + "\n"
    comps = p["input_components"]
    if comps == 2:
        gen.body += "%result = OpIAdd %type %value1 %value2\n"
    elif comps == 3:
        gen.body += "%value12 = OpIAdd %type %value1 %value2\n%result = OpIAdd %type %value12 %value3\n"
    elif comps == 4:
        gen.body += "%value12 = OpIAdd %type %value1 %value2\n%value34 = OpIAdd %type %value3 %value4\n%result = OpIAdd %type %value12 %value34\n"
    if p["input_size"] == p["output_size"]:
        gen.body += "%storeValue = OpBitcast %uint %result\n"
    else:
        gen.body += "%storeValue = OpUConvert %" + scalar_output_type + " %result\n"

    store_decorations(p, gen, "%storePointer")

    if p["stride_store"]:
        gen.body += "%storePointer = OpRawAccessChainNV %_ptr_Storage_" + output_type + " %outputBuffer " + output_stride_text + " %localInvocation " + gen.uint32(p["output_pre"]) + output_robustness + "\n"
    else:
        gen.body += "%storeElementOffset = OpIMul %uint %localInvocation " + output_stride_text + "\n%storeOffset = OpIAdd %uint %storeElementOffset " + gen.uint32(p["output_pre"]) + "\n"
        gen.body += "%storePointer = OpRawAccessChainNV %_ptr_Storage_" + output_type + " %outputBuffer " + gen.uint32(0) + " " + gen.uint32(0) + " %storeOffset" + output_robustness + "\n"

    if p["output_components"] == 1:
        gen.body += "OpStore %storePointer %storeValue" + output_alignment_text + "\n"
    else:
        composites = "%storeValue"
        for i in range(1, p["output_components"]):
            delta = "%delta" + str(i)
            scalar = "%storeValue" + str(i)
            gen.declarations += delta + " = OpConstant %" + scalar_output_type + " " + str(i) + "\n"
            gen.body += scalar + " = OpIAdd %" + scalar_output_type + " %storeValue " + delta + "\n"
            composites += " " + scalar
        gen.body += "%storeVector = OpCompositeConstruct %" + output_type + " " + composites + "\nOpStore %storePointer %storeVector" + output_alignment_text + "\n"
    gen.body += "OpReturn\nOpFunctionEnd\n"
    return gen.result()


def spec_string(p):
    keys = [
        ("is", p["input_size"]), ("ic", p["input_components"]), ("ipre", p["input_pre"]), ("ipost", p["input_post"]),
        ("os", p["output_size"]), ("oc", p["output_components"]), ("opre", p["output_pre"]), ("opost", p["output_post"]),
        ("vp", int(p["variable_pointers"])), ("di", int(p["descriptor_indexing"])), ("pb", int(p["physical_buffers"])), ("b64", int(p["uses_64bit_indexing"])),
        ("ibc", p["input_bounds_check"]), ("obc", p["output_bounds_check"]), ("ir", p["input_range"]), ("or", p["output_range"]),
    ]
    return ";".join(f"{key}={value}" for key, value in keys)


def cases():
    qualifier_combinations = [
        QUALIFIER_NONE,
        QUALIFIER_LOAD_NON_WRITABLE,
        QUALIFIER_LOAD_VOLATILE,
        QUALIFIER_LOAD_COHERENT,
        QUALIFIER_LOAD_VOLATILE | QUALIFIER_LOAD_COHERENT,
        QUALIFIER_STORE_NON_READABLE,
        QUALIFIER_STORE_VOLATILE,
        QUALIFIER_STORE_COHERENT,
    ]
    for testing_store in (False, True):
        for variable_pointers in (False, True):
            for descriptor_indexing in (False, True):
                for physical_buffers in (False, True):
                    for uses_64bit_indexing in (False, True):
                        for bounds_check in (NO_BOUNDS_CHECK, BOUNDS_CHECK_PER_COMPONENT, BOUNDS_CHECK_PER_ELEMENT):
                            for qualifiers in qualifier_combinations:
                                for stride in (True, False):
                                    for size in (4, 8, 2, 1):
                                        for components in (1, 2, 3, 4):
                                            for alignment_div in (1, 4, 2, 3):
                                                if not stride and bounds_check == BOUNDS_CHECK_PER_ELEMENT:
                                                    continue
                                                if components < alignment_div:
                                                    continue
                                                if components % alignment_div != 0:
                                                    continue
                                                if physical_buffers:
                                                    if variable_pointers or descriptor_indexing or bounds_check != NO_BOUNDS_CHECK:
                                                        continue
                                                if qualifiers not in (QUALIFIER_NONE, QUALIFIER_LOAD_NON_WRITABLE):
                                                    if size != 4 or components != 4 or alignment_div != 1:
                                                        continue

                                                pre_padding = components * size
                                                while not is_pow2(pre_padding):
                                                    pre_padding += size

                                                alignment = 0
                                                if alignment_div > 1:
                                                    alignment = (components * size) // alignment_div
                                                    pre_padding += alignment

                                                name = "store_" if testing_store else "load_"
                                                if physical_buffers:
                                                    name += "physical_buffers_"
                                                if variable_pointers:
                                                    name += "variable_pointers_"
                                                if descriptor_indexing:
                                                    name += "descriptor_indexing_"
                                                if components > 1:
                                                    name += "v" + str(components)
                                                name += "int" + str(size * 8)
                                                if alignment != 0:
                                                    name += "_align_" + str(alignment)
                                                name += "_stride" if stride else "_no_stride"
                                                name += {NO_BOUNDS_CHECK: "_no_bounds", BOUNDS_CHECK_PER_COMPONENT: "_per_component", BOUNDS_CHECK_PER_ELEMENT: "_per_element"}[bounds_check]
                                                if qualifiers & QUALIFIER_LOAD_NON_WRITABLE:
                                                    name += "_load_non_writable"
                                                if qualifiers & QUALIFIER_LOAD_VOLATILE:
                                                    name += "_load_volatile"
                                                if qualifiers & QUALIFIER_LOAD_COHERENT:
                                                    name += "_load_coherent"
                                                if qualifiers & QUALIFIER_STORE_NON_READABLE:
                                                    name += "_store_non_readable"
                                                if qualifiers & QUALIFIER_STORE_VOLATILE:
                                                    name += "_store_volatile"
                                                if qualifiers & QUALIFIER_STORE_COHERENT:
                                                    name += "_store_coherent"
                                                if uses_64bit_indexing:
                                                    name += "_64b_indexing"

                                                input_alignment = 0 if testing_store else alignment
                                                output_alignment = alignment if testing_store else 0
                                                input_pre = 0 if testing_store else pre_padding
                                                output_pre = pre_padding if testing_store else 0
                                                input_components = 4 if testing_store else components
                                                output_components = components if testing_store else 4
                                                input_size = 4 if testing_store else size
                                                output_size = size if testing_store else 4
                                                load_bounds = NO_BOUNDS_CHECK if testing_store else bounds_check
                                                store_bounds = bounds_check if testing_store else NO_BOUNDS_CHECK
                                                stride_load = stride or testing_store
                                                stride_store = stride or not testing_store

                                                input_post = 0
                                                while not is_pow2(input_components * input_size + input_pre + input_post):
                                                    input_post += input_size
                                                output_post = 0
                                                while not is_pow2(output_components * output_size + output_pre + output_post):
                                                    output_post += output_size

                                                descriptor_range = WHOLE_SIZE
                                                if bounds_check != NO_BOUNDS_CHECK:
                                                    post_padding = output_post if testing_store else input_post
                                                    descriptor_range = 11 * (components * size + pre_padding + post_padding)
                                                if bounds_check == BOUNDS_CHECK_PER_COMPONENT:
                                                    if components > 1:
                                                        descriptor_range -= size

                                                yield testing_store, {
                                                    "name": name,
                                                    "input_size": input_size, "input_components": input_components, "input_pre": input_pre,
                                                    "input_post": input_post, "input_alignment": input_alignment,
                                                    "output_size": output_size, "output_components": output_components, "output_pre": output_pre,
                                                    "output_post": output_post, "output_alignment": output_alignment,
                                                    "stride_load": stride_load, "stride_store": stride_store,
                                                    "variable_pointers": variable_pointers, "descriptor_indexing": descriptor_indexing,
                                                    "physical_buffers": physical_buffers, "uses_64bit_indexing": uses_64bit_indexing,
                                                    "input_bounds_check": load_bounds, "output_bounds_check": store_bounds, "qualifiers": qualifiers,
                                                    "input_range": WHOLE_SIZE if testing_store else descriptor_range,
                                                    "output_range": descriptor_range if testing_store else WHOLE_SIZE,
                                                }


def main():
    outputs = {False: [], True: []}
    for testing_store, p in cases():
        const = "RAC_" + p["name"].upper()
        outputs[testing_store].append(
            f'\n[[case]]\nname = "{p["name"]}"\nrust_const = "{const}"\nrust_type = "RawAccessChainCase"\n'
            f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm", spirv_version = "spirv1.6" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec_string(p)}" }} }}\n'
            f"derived = {{ source = {json.dumps(repr(assembly(p)))} }}\n"
        )
    for testing_store, kind in ((False, "load"), (True, "store")):
        text = (
            f"# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.raw_access_chain.{kind}_*\n#\n"
            "# @generated by hodow_cts/scripts/gen_spirv_assembly_raw_access_chain_manifest.py - do not hand-edit; `spec` carries upstream's `Parameters`.\n\n"
            f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/raw_access_chain_tests"\n'
        )
        (MANIFESTS / f"spirv_assembly_raw_access_chain_{kind}.toml").write_text(text + "".join(outputs[testing_store]), encoding="utf-8")
        print(f"wrote {len(outputs[testing_store])} {kind} cases")


if __name__ == "__main__":
    main()

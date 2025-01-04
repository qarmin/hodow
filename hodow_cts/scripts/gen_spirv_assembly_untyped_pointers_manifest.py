#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_untyped_pointers.toml: dEQP-VK.spirv_assembly.instruction.compute.untyped_pointers.{vulkan,glsl}_memory_model.workgroup_memory_explicit_layout.{aliased,not_aliased}.<type>
(vktSpvAsmUntypedPointersTests.cpp, `addWorkgroupMemoryExplicitLayoutInteractionTests`, 44 cases).

The four template functions (`createShaderAnnotations`, `createShaderVariables`, `createShaderMain` for WORKGROUP_TEST_CASE and `createShaderHeader`) are read out of the C++: every string literal of the
function body in order, but for the ones of `DE_FATAL`, which is what the function appends for the case. The `adjustSpecFor*` extension and capability lists are replayed here in the order the C++ pushes them.

    python3 hodow_cts/scripts/gen_spirv_assembly_untyped_pointers_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
import re
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_untyped_pointers.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmUntypedPointersTests.cpp"
CPP = CRATE / "upstream" / SOURCE
TEMPLATE = "spirv_assembly/source.asm"

LITERAL = re.compile(r'"((?:[^"\\]|\\.)*)"')
ESCAPES = {"n": "\n", "t": "\t", '"': '"', "\\": "\\", "'": "'"}

TYPES = [  # name, declaration, capability, size in bytes
    ("uint8", "OpTypeInt    8 0", "OpCapability Int8\n", 1),
    ("int8", "OpTypeInt    8 1", "OpCapability Int8\n", 1),
    ("uint16", "OpTypeInt   16 0", "OpCapability Int16\n", 2),
    ("int16", "OpTypeInt   16 1", "OpCapability Int16\n", 2),
    ("float16", "OpTypeFloat 16", "OpCapability Float16\n", 2),
    ("uint32", "OpTypeInt   32 0", None, 4),
    ("int32", "OpTypeInt   32 1", None, 4),
    ("float32", "OpTypeFloat 32", None, 4),
    ("uint64", "OpTypeInt   64 0", "OpCapability Int64\n", 8),
    ("int64", "OpTypeInt   64 1", "OpCapability Int64\n", 8),
    ("float64", "OpTypeFloat 64", "OpCapability Float64\n", 8),
]


def decode(text):
    return re.sub(r"\\(.)", lambda m: ESCAPES.get(m.group(1), m.group(1)), text)


def function_text(source, signature, label=None):
    """The string literals of the function that starts at `signature`: the statements (`x = std::string(`, `x += std::string(`, and the same with the call on the next line) before and
    after its `switch`, and those of the `case` whose label contains `label`; the ones of `DE_FATAL` calls are left out. The literals of a statement are joined, the statements in order."""
    start = source.index(signature)
    end = source.index("\n}\n", start)
    body = re.sub(r"//[^\n]*", "", source[start:end])
    body = re.sub(r"/\*.*?\*/", "", body, flags=re.S)
    lines = body.split("\n")
    depth = 0
    switch_depth = None
    labels = []
    fresh = True
    statements = []  # (labels or None, text)
    for line in lines:
        bare = LITERAL.sub('""', line)
        if "DE_FATAL" in bare or "DE_ASSERT" in bare:
            depth += bare.count("{") - bare.count("}")
            continue
        if "specMap[" in bare:
            starts_statement = re.search(r"(\+=|=)\s*std::string\(", bare) or re.search(r"(\+=|=)\s*$", bare)
            line = re.sub(r'specMap\["\w+"\]', "specMap[]", line)
            if not starts_statement:
                depth += bare.count("{") - bare.count("}")
                continue
        if re.search(r"\bswitch\s*\(", bare):
            switch_depth = depth
            labels = []
            fresh = True
        case = re.match(r"\s*case\s+([\w:]+)\s*:", bare)
        if case:
            if fresh:
                labels = []
                fresh = False
            labels.append(case.group(1))
        elif re.match(r"\s*default\s*:", bare):
            if fresh:
                labels = []
                fresh = False
            labels.append("default")
        if "break;" in bare:
            fresh = True
        if re.search(r"(\+=|=)\s*std::string\(", bare) or re.search(r"(\+=|=)\s*$", bare):
            in_switch = switch_depth is not None and depth > switch_depth
            statements.append((list(labels) if in_switch else None, ""))
        if statements:
            statements[-1] = (statements[-1][0], statements[-1][1] + "".join(decode(m.group(1)) for m in LITERAL.finditer(line)))
        depth += bare.count("{") - bare.count("}")
        if switch_depth is not None and depth <= switch_depth and "}" in bare:
            switch_depth = None
            labels = []
    out = ""
    for statement_labels, text in statements:
        if statement_labels is None or (label is not None and any(label in entry for entry in statement_labels)):
            out += text
    return out


def keep_branch(source, signature, branch):
    """The source with every `if (read) {..} else {..}` of the function at `signature` reduced to one side ("read" keeps the first block, "write" the second; the C++ makes the same choice by the argument)."""
    start = source.index(signature)
    end = source.index("\n}\n", start)
    body = source[start:end]

    def block(text, open_at):
        depth = 0
        for index in range(open_at, len(text)):
            if text[index] == "{":
                depth += 1
            elif text[index] == "}":
                depth -= 1
                if depth == 0:
                    return index + 1
        raise ValueError("unbalanced braces")

    while True:
        if_start = re.search(r"if \(read\)", body)
        if not if_start:
            break
        read_open = body.index("{", if_start.end())
        read_end = block(body, read_open)
        else_match = re.compile(r"\s*else\s*").match(body, read_end)
        if else_match:
            write_open = body.index("{", else_match.end())
            write_end = block(body, write_open)
            chosen = body[read_open:read_end] if branch == "read" else body[write_open:write_end]
            body = body[: if_start.start()] + chosen + body[write_end:]
        else:
            chosen = body[read_open:read_end] if branch == "read" else "{}"
            body = body[: if_start.start()] + chosen + body[read_end:]
    return source[:start] + body + source[end:]


def specialize(template, values):
    """`tcu::StringTemplate::specialize`: `${key}` is replaced, `${key:opt}` too or by nothing when there is no such key; the result is specialized again for values that hold placeholders."""
    pattern = re.compile(r"\$\{(\w+)(:opt)?\}")

    def replace(match):
        if match.group(1) in values:
            return values[match.group(1)]
        return "" if match.group(2) else match.group(0)

    for _ in range(3):
        before = template
        template = pattern.sub(replace, template)
        if template == before:
            break
    assert "${" not in template, template[:200]
    return template


COPY_OPERATIONS = [  # group name, `COPY_OPERATION_CASES` text
    ("op_copy_object", "%object_loc         = OpLoad       %${copyType} %input_data_var_loc\n%coppied_object_loc = OpCopyObject %${copyType} %object_loc\n                      OpStore %output_data_var_loc %coppied_object_loc\n"),
    ("op_copy_memory", "OpCopyMemory          %output_data_var_loc %input_data_var_loc"),
    ("op_copy_memory_sized", "OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size"),
]

CONTAINERS = {  # name -> (storage class, small type extension suffix for 8 and 16 bit access)
    "storage": ("StorageBuffer", "StorageBuffer"),
    "uniform": ("Uniform", "UniformAndStorageBuffer"),
    "push_constant": ("PushConstant", "StoragePushConstant"),
}

HEADER = (
    "OpCapability Shader\n${capabilities}\n${extensions}\n${memModelOp}\n"
    'OpEntryPoint GLCompute %main "main" %id  \nOpExecutionMode %main LocalSize 1 1 1\n'
)
WORKGROUP_INTERFACES = "%input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var"


def small_container(container, name):
    """adjustSpecForSmallContainerType: the extensions and capabilities."""
    extensions, capabilities = [], []
    prefix = CONTAINERS[container][1]
    if name in ("uint8", "int8"):
        extensions.append('OpExtension "SPV_KHR_8bit_storage"\n')
        capabilities.append("OpCapability " + ("StoragePushConstant8" if container == "push_constant" else prefix + "8BitAccess") + "\n")
    elif name in ("uint16", "int16", "float16"):
        extensions.append('OpExtension "SPV_KHR_16bit_storage"\n')
        capabilities.append("OpCapability " + ("StoragePushConstant16" if container == "push_constant" else prefix + "16BitAccess") + "\n")
    return extensions, capabilities


def common_lists(model, name):
    """adjustSpecForUntypedPointers, adjustSpecForMemoryModel and adjustSpecForDataTypes: the extensions, the capabilities and the memory model operation."""
    extensions = ['OpExtension "SPV_KHR_storage_buffer_storage_class"\n', 'OpExtension "SPV_KHR_untyped_pointers"\n']
    capabilities = ["OpCapability UntypedPointersKHR\n"]
    if model == "vulkan":
        capabilities += ["OpCapability VulkanMemoryModel\n", "OpCapability VulkanMemoryModelDeviceScopeKHR\n"]
        extensions.append('OpExtension "SPV_KHR_vulkan_memory_model"\n')
        memory_model_op = "OpMemoryModel Logical Vulkan"
    else:
        memory_model_op = "OpMemoryModel Logical GLSL450"
    for type_name, _, capability, _ in TYPES:
        if type_name == name and capability:
            capabilities.append(capability)
    return extensions, capabilities, memory_model_op


def type_values(name):
    for type_name, declaration, _, size in TYPES:
        if type_name == name:
            return {"baseDecl": declaration, "baseType": name}, size
    raise KeyError(name)


def finish(source, kind, values, extensions, capabilities, memory_model_op, header, annotations, variables, main):
    values = dict(values, memModelOp=memory_model_op, extensions="".join(extensions), capabilities="".join(capabilities))
    return "".join(specialize(text, values) for text in (header, annotations, variables, main))


def base_text(source, signature, label):
    return function_text(source, signature, "BaseTestCases::" + label)


def workgroup_assembly(source, model, kind, name):
    values, size = type_values(name)
    values["vecOffset"] = str(4 * size)
    extensions, capabilities, memory_model_op = common_lists(model, name)
    if name in ("uint8", "int8"):
        capabilities.append("OpCapability WorkgroupMemoryExplicitLayout8BitAccessKHR\n")
    elif name in ("uint16", "int16", "float16"):
        capabilities.append("OpCapability WorkgroupMemoryExplicitLayout16BitAccessKHR\n")
    capabilities.append("OpCapability WorkgroupMemoryExplicitLayoutKHR\n")
    extensions.append('OpExtension "SPV_KHR_workgroup_memory_explicit_layout"\n')
    label = "WorkgroupTestCases::" + kind.upper()
    annotations = function_text(source, "std::string createShaderAnnotations(WORKGROUP_TEST_CASE testCase)", label)
    variables = function_text(source, "std::string createShaderVariables(WORKGROUP_TEST_CASE testCase)", label)
    if name != "uint32":
        variables = "%uint32     = OpTypeInt  32      0\n" + variables
    main = function_text(source, "std::string createShaderMain(WORKGROUP_TEST_CASE testCase)", label)
    header = HEADER.replace("%id  \n", "%id " + WORKGROUP_INTERFACES + " \n")
    return finish(source, kind, values, extensions, capabilities, memory_model_op, header, annotations, variables, main)


def resource_decorations(container, name, thread_count, size):
    stride = 16 if container == "uniform" else size
    text = f"OpDecorate %array_{name}_{thread_count} ArrayStride {stride}\n"
    if container == "push_constant":
        text += "OpDecorate %output_data_var DescriptorSet 0\nOpDecorate %output_data_var Binding       0\n"
    else:
        text += (
            "OpDecorate %input_data_untyped_var DescriptorSet 0\nOpDecorate %input_data_untyped_var Binding       0\n"
            "OpDecorate %output_data_var        DescriptorSet 0\nOpDecorate %output_data_var        Binding       1\n"
        )
    return text


def base_assembly(source, model, family, container, name):
    """`addLoadTests`, `addStoreTests`, `addOpArrayLengthTests` and `addDescriptorArrayTests`."""
    values, size = type_values(name)
    extensions, capabilities, memory_model_op = common_lists(model, name)
    label = {"load": "LOAD", "store": "STORE", "array_length": "ARRAY_LENGTH", "descriptor_array": "DESCRIPTOR_ARRAY", "copy_from": "COPY_FROM", "copy_to": "COPY_TO"}[family]
    annotations = base_text(source, "std::string createShaderAnnotations(BASE_TEST_CASE testCase)", label)
    variables = base_text(source, "std::string createShaderVariables(BASE_TEST_CASE testCase)", label)
    main = base_text(source, "std::string createShaderMain(BASE_TEST_CASE testCase)", label)
    if family == "load":
        thread_count = 4 if container == "push_constant" else 64
        values.update(
            alignment=str(16 if container == "uniform" else size), threadCount=str(thread_count), args="", loadOp="OpLoad",
            storageClass=CONTAINERS[container][0], storageDecorations=resource_decorations(container, name, thread_count, size),
        )
        small_extensions, small_capabilities = small_container(container, name)
        extensions += small_extensions
        capabilities += small_capabilities
        if name != "uint32":
            variables = "%uint32     = OpTypeInt  32      0\n%c_uint32_1 = OpConstant %uint32 1\n" + variables
    elif family == "store":
        values.update(alignment=str(size), args="", storeOp="OpStore", threadCount="64")
        small_extensions, small_capabilities = small_container("storage", name)
        extensions += small_extensions
        capabilities += small_capabilities
        if name != "uint32":
            variables = "%uint32     = OpTypeInt  32      0\n%c_uint32_1 = OpConstant %uint32 1\n" + variables
    elif family in ("copy_from", "copy_to"):
        values.update(alignment=str(size), threadCount="64", size=str(size), copyType=name, copyOp=container)
        small_extensions, small_capabilities = small_container("storage", name)
        extensions += small_extensions
        capabilities += small_capabilities
        if name != "uint32":
            variables = "%uint32     = OpTypeInt 32 0\n%c_uint32_1 = OpConstant %uint32 1\n" + variables
    elif family == "array_length":
        values.update(alignment=str(size))
        if name != "uint32":
            variables = (
                "%uint32                    = OpTypeInt     32            0\n"
                "%c_uint32_1                = OpConstant    %uint32       1\n"
                "%uint32_storage_buffer_ptr = OpTypePointer StorageBuffer %uint32\n" + variables
            )
    else:
        values.update(
            stride=str(size * 4), offset0=str(size * 0), offset1=str(size * 1), offset2=str(size * 2), offset3=str(size * 3),
        )
        capabilities += ["OpCapability VariablePointersStorageBuffer\n", "OpCapability VariablePointers\n"]
        extensions.append('OpExtension "SPV_KHR_variable_pointers"\n')
        if name != "uint32":
            variables = "%uint32                    = OpTypeInt     32            0\n" + variables
    return finish(source, family, values, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


PHYSICAL_OPERATIONS = [  # group, `PointerTestCases` label, header interfaces, sub groups (None: the cases are directly below the group)
    ("op_bitcast/from_untyped", "OP_BITCAST_FROM_UNTYPED_PHYSICAL_STORAGE", "", None),
    ("op_bitcast/to_untyped", "OP_BITCAST_TO_UNTYPED_PHYSICAL_STORAGE", "", None),
    ("op_select", "OP_SELECT_PHYSICAL_STORAGE", "%push_constant_var %all_data_var", ("first", "second")),
    ("op_phi", "OP_PHI_PHYSICAL_STORAGE", "%push_constant_var %all_data_var", ("first", "second")),
    ("op_function_call", "OP_FUNCTION_CALL_PHYSICAL_STORAGE", "", None),
    ("op_ptr_access_chain", "OP_PTR_ACCESS_CHAIN_PHYSICAL_STORAGE", "", None),
]

SIMPLE_FUNCTION_PHYSICAL = (
    "%simple_function_type  = OpTypeFunction %untyped_phys_ptr %untyped_phys_ptr\n"
    "%simple_function       = OpFunction     %untyped_phys_ptr None %simple_function_type\n"
    "%return_ptr            = OpFunctionParameter %untyped_phys_ptr\n"
    "%label_simple_function = OpLabel\n"
    "                         OpReturnValue       %return_ptr\n"
    "                         OpFunctionEnd\n"
)


def physical_assembly(source, model, label, interfaces, name):
    """`addPhysicalStorageOpBitcastTests` and the op_select, op_phi, op_function_call and op_ptr_access_chain tests of the physical storage buffer group."""
    values, size = type_values(name)
    values.update(alignment=str(size), threadCount="64")
    extensions, capabilities, memory_model_op = common_lists(model, name)
    capabilities.append("OpCapability PhysicalStorageBufferAddresses\n")
    extensions.append('OpExtension "SPV_KHR_physical_storage_buffer"\n')
    memory_model_op = "OpMemoryModel PhysicalStorageBuffer64 " + ("Vulkan" if model == "vulkan" else "GLSL450")
    full_label = "PointerTestCases::" + label
    annotations = function_text(source, "std::string createShaderAnnotations(POINTER_TEST_CASE testCase)", full_label)
    variables = function_text(source, "std::string createShaderVariables(POINTER_TEST_CASE testCase)", full_label)
    main = function_text(source, "std::string createShaderMain(POINTER_TEST_CASE testCase)", full_label)
    if label == "OP_FUNCTION_CALL_PHYSICAL_STORAGE":
        main = SIMPLE_FUNCTION_PHYSICAL + main
    if name != "uint32":
        variables = "%uint32     = OpTypeInt  32      0\n" + variables
    header = HEADER.replace("%id  \n", "%id " + interfaces + " \n") if interfaces else HEADER
    return finish(source, label, values, extensions, capabilities, memory_model_op, header, annotations, variables, main)


VARIABLE_POINTER_INTERFACES = "%push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var"
VARIABLE_POINTER_OPERATIONS = [  # group, `PointerTestCases` label, header interfaces, sub groups
    ("op_select", "OP_SELECT_VARIABLE_PTR", VARIABLE_POINTER_INTERFACES, ("first", "second")),
    ("op_phi", "OP_PHI_VARIABLE_PTR", VARIABLE_POINTER_INTERFACES, ("first", "second")),
    ("op_function_call", "OP_FUNCTION_CALL_VARIABLE_PTR", "", None),
    ("op_ptr_access_chain", "OP_PTR_ACCESS_CHAIN_VARIABLE_PTR", "", None),
    ("function_variable", "FUNCTION_VARIABLE_VARIABLE_PTR", "", None),
    ("private_variable", "PRIVATE_VARIABLE_VARIABLE_PTR", "", None),
    ("multiple_access_chains", "MULTIPLE_ACCESS_CHAINS_VARIABLE_PTR", "", None),
    ("workgroup_memory", "WORKGROUP_MEMORY_VARIABLE_PTR", "%input_data_var %output_data_var %workgroup_untyped_var", None),
]

SIMPLE_FUNCTION_VARIABLE_POINTER = (
    "%simple_function_type  = OpTypeFunction      %storage_buffer_untyped_ptr %storage_buffer_untyped_ptr\n"
    "%simple_function       = OpFunction          %storage_buffer_untyped_ptr None %simple_function_type\n"
    "%input_ptr             = OpFunctionParameter %storage_buffer_untyped_ptr\n"
    "%label_simple_function = OpLabel\n"
    "%offseted_ptr          = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr   %array_32    "
    "                                                 %input_ptr                    %c_uint32_4\n"
    "                         OpReturnValue           %offseted_ptr\n"
    "                         OpFunctionEnd\n"
)

# base type -> (second type declaration, second type, second array definition, second alignment, same byte index)
SECOND_TYPES = {
    "uint8": ("int16", 2, "%c_uint32_2"), "int8": ("int16", 2, "%c_uint32_2"),
    "uint16": ("int32", 4, "%c_uint32_2"), "int16": ("int32", 4, "%c_uint32_2"), "float16": ("int32", 4, "%c_uint32_2"),
    "uint32": ("int16", 2, "%c_uint32_8"), "int32": ("int16", 2, "%c_uint32_8"), "float32": ("int16", 2, "%c_uint32_8"),
    "uint64": ("int32", 4, "%c_uint32_8"), "int64": ("int32", 4, "%c_uint32_8"), "float64": ("int32", 4, "%c_uint32_8"),
}


def variable_pointer_assembly(source, model, group, label, interfaces, name):
    """`addVariablePtrOpSelectTests` and its siblings of the variable_pointers group (the ones with one case per type)."""
    values, size = type_values(name)
    values.update(alignment=str(size), threadCount="64")
    extensions, capabilities, memory_model_op = common_lists(model, name)
    if group == "multiple_access_chains":
        second_type, second_size, same_byte_index = SECOND_TYPES[name]
        bits = 16 * (second_size // 2)
        values.update(
            secondType=f"%{second_type} = OpTypeInt {bits} 1", otherType=second_type,
            secondArray=f"%array_second_32 = OpTypeArray %{second_type} %c_uint32_32", alignment0=str(size), alignment1=str(second_size),
            elemNdx=same_byte_index + "\n",
        )
        capabilities.append("OpCapability Int16\n")
    capabilities += ["OpCapability VariablePointersStorageBuffer\n", "OpCapability VariablePointers\n"]
    extensions.append('OpExtension "SPV_KHR_variable_pointers"\n')
    if group == "workgroup_memory":
        if name in ("uint8", "int8"):
            capabilities.append("OpCapability WorkgroupMemoryExplicitLayout8BitAccessKHR\n")
        elif name in ("uint16", "int16", "float16"):
            capabilities.append("OpCapability WorkgroupMemoryExplicitLayout16BitAccessKHR\n")
        capabilities.append("OpCapability WorkgroupMemoryExplicitLayoutKHR\n")
        extensions.append('OpExtension "SPV_KHR_workgroup_memory_explicit_layout"\n')
    full_label = "PointerTestCases::" + label
    annotations = function_text(source, "std::string createShaderAnnotations(POINTER_TEST_CASE testCase)", full_label)
    variables = function_text(source, "std::string createShaderVariables(POINTER_TEST_CASE testCase)", full_label)
    main = function_text(source, "std::string createShaderMain(POINTER_TEST_CASE testCase)", full_label)
    if group == "op_function_call":
        main = SIMPLE_FUNCTION_VARIABLE_POINTER + main
    if name != "uint32":
        variables = "%uint32     = OpTypeInt  32      0\n" + variables
    header = HEADER.replace("%id  \n", "%id " + interfaces + " \n") if interfaces else HEADER
    return finish(source, label, values, extensions, capabilities, memory_model_op, header, annotations, variables, main)


PTR_COMPARE_BLOCKS = [  # block, group below op_ptr_*, name suffix
    (1, "equal", ""),
    (2, "equal", "_to_int16/_to_int32"),
    (3, "equal", "_typed_and_untyped"),
    (4, "not_equal", ""),
    (5, "not_equal", "_typed_and_untyped"),
    (6, "not_equal", "_null_ptr"),
]


def ptr_compare_main_logic(block, operation, name):
    """The `mainLogic` strings of `addVariablePtrOpPtrEqualTests` and `addVariablePtrOpPtrNotEqualTests`, block by block."""
    untyped = "OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 "
    compare = f"%are_equal        = {operation}              %bool                           %input_loc_first   "
    if block == 1:
        return f"%input_loc_first  = {untyped}%c_uint32_2\n%input_loc_second = {untyped}%c_uint32_2\n{compare}%input_loc_second\n"
    if block == 2:
        return (
            f"%input_array_loc = {untyped[:-len('%c_uint32_0 ')]}%c_uint32_0\n"
            "%input_loc_first = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_first_32 %input_array_loc %c_uint32_4\n"
            "%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_second_32 %input_array_loc " + SECOND_TYPES[name][2] + "\n"
            f"{compare}%input_loc_second\n"
        )
    if block in (3, 5):
        index = "%c_uint32_2" if block == 3 else "%c_uint32_4"
        return (
            f"%input_loc_first  = {untyped}%c_uint32_2\n"
            f"%input_loc_second = OpAccessChain           %{name}_storage_buffer_ptr                    %input_data_var %c_uint32_0 {index}\n"
            f"{compare}%input_loc_second\n"
        )
    if block == 4:
        return f"%input_loc_first  = {untyped}%c_uint32_2\n%input_loc_second = {untyped}%c_uint32_4\n{compare}%input_loc_second\n"
    return f"%input_loc_first  = {untyped}%c_uint32_2\n{compare}%c_null_untyped_ptr\n"


def ptr_compare_assembly(source, model, label, operation, block, name):
    values, size = type_values(name)
    values.update(alignment=str(size), mainLogic=ptr_compare_main_logic(block, operation, name))
    extensions, capabilities, memory_model_op = common_lists(model, name)
    if block == 2:
        second_type, second_size, _ = SECOND_TYPES[name]
        values.update(
            secondType=f"%{second_type} = OpTypeInt {16 * (second_size // 2)} 1", secondArray=f"%array_second_32 = OpTypeArray %{second_type} %c_uint32_32",
            secondArrayDecoration=f"OpDecorate       %array_second_32   ArrayStride   {second_size}\n",
        )
        capabilities.append("OpCapability Int16\n")
    capabilities += ["OpCapability VariablePointersStorageBuffer\n", "OpCapability VariablePointers\n"]
    extensions.append('OpExtension "SPV_KHR_variable_pointers"\n')
    full_label = "PointerTestCases::" + label
    annotations = function_text(source, "std::string createShaderAnnotations(POINTER_TEST_CASE testCase)", full_label)
    variables = function_text(source, "std::string createShaderVariables(POINTER_TEST_CASE testCase)", full_label)
    main = function_text(source, "std::string createShaderMain(POINTER_TEST_CASE testCase)", full_label)
    if name != "uint32":
        variables = "%uint32     = OpTypeInt  32      0\n" + variables
    header = HEADER.replace("%id  \n", "%id %input_data_var %output_data_var \n")
    return finish(source, label, values, extensions, capabilities, memory_model_op, header, annotations, variables, main)


def ptr_diff_assembly(source, model, block, name):
    """`addVariablePtrOpPtrDiffTests`: block 1 subtracts two pointers into one array, block 2 two pointers into arrays of different element types at the same byte offset."""
    values, size = type_values(name)
    values.update(alignment=str(size), threadCount="64")
    extensions, capabilities, memory_model_op = common_lists(model, name)
    if block == 1:
        values["mainLogic"] = (
            "%input_loc_first_ptr  = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr     %input_buffer                                 %input_data_var            %c_uint32_0 %c_uint32_4\n"
            "%input_loc_second_ptr = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr     %input_buffer                                 %input_data_var            %c_uint32_0 %c_uint32_16\n"
        )
    else:
        second_type, second_size, same_byte_index = SECOND_TYPES[name]
        values.update(
            secondType=f"%{second_type} = OpTypeInt {16 * (second_size // 2)} 1", secondArray=f"%array_second_32 = OpTypeArray %{second_type} %c_uint32_32",
            secondArrayDecoration=f"OpDecorate       %array_second_32   ArrayStride   {second_size}\n",
            mainLogic=(
                "%input_array_loc      = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer                         %input_data_var %c_uint32_0\n"
                "%input_loc_first_ptr  = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr %array_first_32                          %input_array_loc           %c_uint32_4\n"
                "%input_loc_second_ptr = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr %array_second_32                         %input_array_loc " + same_byte_index + "\n"
            ),
        )
        capabilities.append("OpCapability Int16\n")
    capabilities += ["OpCapability VariablePointersStorageBuffer\n", "OpCapability VariablePointers\n"]
    extensions.append('OpExtension "SPV_KHR_variable_pointers"\n')
    full_label = "PointerTestCases::OP_PTR_DIFF_VARIABLE_PTR"
    annotations = function_text(source, "std::string createShaderAnnotations(POINTER_TEST_CASE testCase)", full_label)
    variables = function_text(source, "std::string createShaderVariables(POINTER_TEST_CASE testCase)", full_label)
    main = function_text(source, "std::string createShaderMain(POINTER_TEST_CASE testCase)", full_label)
    if name != "uint32":
        variables = "%uint32     = OpTypeInt  32      0\n" + variables
    header = HEADER.replace("%id  \n", "%id %input_data_var %output_data_var \n")
    return finish(source, "OP_PTR_DIFF_VARIABLE_PTR", values, extensions, capabilities, memory_model_op, header, annotations, variables, main)


ATOMIC_TYPES = ("float16", "uint32", "int32", "float32", "uint64", "int64", "float64")


def atomic_assembly(source, model, family, name):
    """`addLoadAtomicTests` and `addStoreAtomicTests`."""
    values, size = type_values(name)
    label = "AtomicTestCases::" + ("OP_ATOMIC_LOAD" if family == "load" else "OP_ATOMIC_STORE")
    values.update(alignment=str(size), threadCount="64", args="%c_uint32_1 %c_uint32_0", loadOp="OpAtomicLoad", storeOp="OpAtomicStore")
    extensions, capabilities, memory_model_op = common_lists(model, name)
    if name in ("uint64", "int64"):
        capabilities.append("OpCapability Int64Atomics\n")
    annotations = function_text(source, "std::string createShaderAnnotations(ATOMIC_TEST_CASE testCase)", label)
    variables = function_text(source, "std::string createShaderVariables(ATOMIC_TEST_CASE testCase)", label)
    main = function_text(source, "std::string createShaderMain(ATOMIC_TEST_CASE testCase)", label)
    if name != "uint32":
        variables = "%uint32     = OpTypeInt  32      0\n" + variables
    return finish(source, family, values, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)

ATOMIC_INT_TYPES = ("uint32", "int32", "uint64", "int64")
ATOMIC_OPERATIONS = [  # group, label, op names by type kind (float, signed, unsigned or None for no float), op value, types, variables prefix kind
    ("add", "OP_ATOMIC_ADD", ("OpAtomicFAddEXT", "OpAtomicIAdd", "OpAtomicIAdd"), "16", ATOMIC_TYPES, "full"),
    ("subtract", "OP_ATOMIC_SUB", (None, "OpAtomicISub", "OpAtomicISub"), "16", ATOMIC_INT_TYPES, "full"),
    ("increment", "OP_ATOMIC_INCREMENT", (None, "OpAtomicIIncrement", "OpAtomicIIncrement"), "", ATOMIC_INT_TYPES, "uint"),
    ("decrement", "OP_ATOMIC_DECREMENT", (None, "OpAtomicIDecrement", "OpAtomicIDecrement"), "", ATOMIC_INT_TYPES, "uint"),
    ("min", "OP_ATOMIC_MIN", ("OpAtomicFMinEXT", "OpAtomicSMin", "OpAtomicUMin"), "minmax", ATOMIC_TYPES, "full"),
    ("max", "OP_ATOMIC_MAX", ("OpAtomicFMaxEXT", "OpAtomicSMax", "OpAtomicUMax"), "minmax", ATOMIC_TYPES, "full"),
    ("and", "OP_ATOMIC_AND", (None, "OpAtomicAnd", "OpAtomicAnd"), "1", ATOMIC_INT_TYPES, "full"),
    ("or", "OP_ATOMIC_OR", (None, "OpAtomicOr", "OpAtomicOr"), "1", ATOMIC_INT_TYPES, "full"),
    ("xor", "OP_ATOMIC_XOR", (None, "OpAtomicXor", "OpAtomicXor"), "1", ATOMIC_INT_TYPES, "full"),
    ("exchange", "OP_ATOMIC_EXCHANGE", ("OpAtomicExchange", "OpAtomicExchange", "OpAtomicExchange"), "1", ATOMIC_TYPES, "full"),
    ("compare_exchange", "OP_ATOMIC_COMPARE_EXCHANGE", (None, "OpAtomicCompareExchange", "OpAtomicCompareExchange"), "16", ATOMIC_INT_TYPES, "compex"),
]


def atomic_op_assembly(source, model, group, label, op_names, op_value, name, comp, prefix_kind):
    """`addAtomicAddTests`, `addAtomicSubtractTests`, `addAtomicIncrementDecrementTests`, `addAtomicMinMaxTests`, `addAtomicBooleanTests`, `addAtomicExchangeTests` and `addAtomicCompareExchangeTests`."""
    values, _ = type_values(name)
    kind = 0 if name.startswith("float") else (1 if name.startswith("int") else 2)
    if op_value == "minmax":
        op_value = "-1" if name in ("int8", "int16", "int32", "float32", "int64") else "1"
    values.update(opType=op_names[kind], opValue=op_value, compValue=comp)
    extensions, capabilities, memory_model_op = common_lists(model, name)
    if name in ("uint64", "int64"):
        capabilities.append("OpCapability Int64Atomics\n")
    if group == "add" and name.startswith("float"):
        bits = name[5:]
        extensions.append(f'OpExtension "SPV_EXT_shader_atomic_float{"16" if bits == "16" else ""}{"_" if bits == "16" else "_"}add"\n')
        capabilities.append(f"OpCapability AtomicFloat{bits}AddEXT\n")
    if group in ("min", "max") and name.startswith("float"):
        extensions.append('OpExtension "SPV_EXT_shader_atomic_float_min_max"\n')
        capabilities.append(f"OpCapability AtomicFloat{name[5:]}MinMaxEXT\n")
    full_label = "AtomicTestCases::" + label
    annotations = function_text(source, "std::string createShaderAnnotations(ATOMIC_TEST_CASE testCase)", full_label)
    variables = function_text(source, "std::string createShaderVariables(ATOMIC_TEST_CASE testCase)", full_label)
    main = function_text(source, "std::string createShaderMain(ATOMIC_TEST_CASE testCase)", full_label)
    if name != "uint32":
        if prefix_kind == "full":
            variables = "%uint32     = OpTypeInt  32      0\n%c_uint32_1 = OpConstant %uint32 1\n" + variables
        elif prefix_kind == "uint":
            variables = "%uint32     = OpTypeInt  32      0\n" + variables
        else:
            variables = "%uint32 = OpTypeInt 32 0\n" + variables + f"%c_{name}_1 = OpConstant %{name} 1\n"
    return finish(source, group, values, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


TYPE_NAMES = [t[0] for t in TYPES]
SAME_SIZE_BASE = {
    "uint8": ["int8"], "int8": ["uint8"], "uint16": ["int16", "float16"], "int16": ["uint16", "float16"], "float16": ["uint16", "int16"],
    "uint32": ["int32", "float32"], "int32": ["uint32", "float32"], "float32": ["uint32", "int32"],
    "uint64": ["int64", "float64"], "int64": ["uint64", "float64"], "float64": ["uint64", "int64"],
}
SAME_SIZE_COMPOSITE = {  # `getSameSizeCompositeType`
    "uint16": ["vec2_uint8", "vec2_int8"], "int16": ["vec2_uint8", "vec2_int8"], "float16": ["vec2_uint8", "vec2_int8"],
    "uint32": ["vec4_uint8", "vec4_int8", "vec2_uint16", "vec2_int16", "vec2_float16"],
    "int32": ["vec4_uint8", "vec4_int8", "vec2_uint16", "vec2_int16", "vec2_float16"],
    "float32": ["vec4_uint8", "vec4_int8", "vec2_uint16", "vec2_int16", "vec2_float16"],
    "uint64": ["vec4_uint16", "vec4_int16", "vec4_float16", "vec2_uint32", "vec2_int32", "vec2_float32"],
    "int64": ["vec4_uint16", "vec4_int16", "vec4_float16", "vec2_uint32", "vec2_int32", "vec2_float32"],
    "float64": ["vec4_uint16", "vec4_int16", "vec4_float16", "vec2_uint32", "vec2_int32", "vec2_float32"],
}
COMPOSITES = [f"vec{n}_{t}" for t in TYPE_NAMES for n in (2, 3, 4)]
COMPOSITE_SAME_SIZE_BASE = {  # `getSameSizeBaseDataType(COMPOSITE_DATA_TYPE)`
    "vec2_uint8": ["uint16", "int16", "float16"], "vec4_uint8": ["uint32", "int32", "float32"],
    "vec2_int8": ["uint16", "int16", "float16"], "vec4_int8": ["uint32", "int32", "float32"],
    "vec2_uint16": ["uint32", "int32", "float32"], "vec4_uint16": ["uint64", "int64", "float64"],
    "vec2_int16": ["uint32", "int32", "float32"], "vec4_int16": ["uint64", "int64", "float64"],
    "vec2_float16": ["uint32", "int32", "float32"], "vec4_float16": ["uint64", "int64", "float64"],
    "vec2_uint32": ["uint64", "int64", "float64"], "vec2_int32": ["uint64", "int64", "float64"], "vec2_float32": ["uint64", "int64", "float64"],
}


def composite_parts(name):
    """`vec2_uint8` -> (2, `uint8`)"""
    head, base = name.split("_", 1)
    return int(head[3:]), base


def type_capability(name):
    for type_name, _, capability, _ in TYPES:
        if type_name == name:
            return capability.strip() if capability else ""
    raise KeyError(name)


def small_container_lists(container, name):
    extensions, capabilities = small_container(container, name)
    return extensions, capabilities


def punning_load_assembly(source, model, section, container, base, other, composite):
    """`addLoadMixedTypeTests`: section 1 loads a scalar as another scalar of the size, 2 a scalar as a vector, 3 a vector as a scalar."""
    label = "TypePunningTestCases::" + {1: "LOAD_SAME_SIZE_TYPES", 2: "LOAD_SCALAR_VECTOR", 3: "LOAD_VECTOR_SCALAR"}[section]
    base_decl, base_size = type_values(base)[0]["baseDecl"], type_values(base)[1]
    other_decl = type_values(other)[0]["baseDecl"]
    thread_count = 4 if container == "push_constant" else 64
    storage_class = CONTAINERS[container][0]
    extensions, capabilities, memory_model_op = common_lists(model, base)

    def datatype(name):
        capability = [t[2] for t in TYPES if t[0] == name][0]
        if capability:
            capabilities.append(capability)

    def small(where, name):
        small_extensions, small_capabilities = small_container(where, name)
        extensions.extend(small_extensions)
        capabilities.extend(small_capabilities)

    values = {"args": "", "loadOp": "OpLoad", "storageClass": storage_class}
    scalar_vector_decorations = (
        "OpDecorate %output_data_var DescriptorSet 0\nOpDecorate %output_data_var Binding       0\n"
        if container == "push_constant"
        else "OpDecorate %input_data_untyped_var DescriptorSet 0\nOpDecorate %input_data_untyped_var Binding       0\nOpDecorate %output_data_var        DescriptorSet 0\nOpDecorate %output_data_var        Binding       1\n"
    )
    if section == 1:
        decorations = f"OpDecorate %array_{base}_{thread_count} ArrayStride {16 if container == 'uniform' else base_size}\n" + f"OpDecorate %array_{other}_{thread_count} ArrayStride {16 if container == 'uniform' else base_size}\n" + scalar_vector_decorations
        values.update(
            alignment=str(16 if container == "uniform" else base_size), threadCount=str(thread_count), baseType=base, baseDecl=base_decl,
            sameSizeType=other, sameSizeDecl=other_decl, otherCap=type_capability(other), storageDecorations=decorations,
        )
        datatype(other)
        small(container, base)
        if container != "storage":
            small("storage", base)
        prefix = base != "uint32" and other != "uint32"
        prefix_text = "%uint32     = OpTypeInt 32 0\n%c_uint32_1 = OpConstant %uint32 1\n"
    else:
        count, comp_base = composite_parts(composite)
        comp_decl = f"OpTypeVector %{comp_base} {count}"
        if section == 2:
            scalar, vector_base = base, comp_base
            values.update(
                alignment=str(16 if container == "uniform" else base_size), baseType=base, otherType=comp_base, baseDecl=base_decl,
                otherTypeDecl=type_values(comp_base)[0]["baseDecl"], otherCap=type_capability(comp_base), otherVec=composite, otherVecDecl=comp_decl,
                storageDecorations=scalar_vector_decorations,
            )
            if base != comp_base:
                datatype(comp_base)
                small(container, comp_base)
            if base_size != type_values(comp_base)[1] or container != "storage":
                small("storage", comp_base)
            prefix = base != "uint32" and comp_base != "uint32"
        else:
            comp_size = count * type_values(comp_base)[1]
            values.update(
                alignment=str(16 if container == "uniform" else comp_size), baseType=comp_base, otherType=other, baseDecl=type_values(comp_base)[0]["baseDecl"],
                otherTypeDecl=other_decl, otherCap=type_capability(other), baseVec=composite, baseVecDecl=comp_decl, storageDecorations=scalar_vector_decorations,
            )
            capabilities.clear()
            capabilities.extend(common_lists(model, comp_base)[1])
            if comp_base != other:
                datatype(other)
            small(container, comp_base)
            if type_values(comp_base)[1] != type_values(other)[1] or container != "storage":
                small("storage", other)
            prefix = comp_base != "uint32" and other != "uint32"
        if composite != "vec3_uint32":
            values["inputVec"] = "%vec3_uint32 = OpTypeVector %uint32 3"
        prefix_text = "%uint32      = OpTypeInt 32 0\n%c_uint32_1  = OpConstant %uint32 1\n"
        if section == 2 and not prefix:
            prefix = False
    annotations = function_text(source, "std::string createShaderAnnotations(TYPE_PUNNING_TEST_CASE testCase)", label)
    variables = function_text(source, "std::string createShaderVariables(TYPE_PUNNING_TEST_CASE testCase)", label)
    main = function_text(source, "std::string createShaderMain(TYPE_PUNNING_TEST_CASE testCase)", label)
    if prefix:
        variables = prefix_text + variables
    return finish(source, label, values, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


def punning_store_assembly(source, model, section, base, other, composite):
    """`addStoreMixedTypeTests`: section 1 stores a scalar through a pointer to another scalar of the size, 2 a scalar through a vector pointer, 3 a vector through a scalar pointer."""
    label = "TypePunningTestCases::" + {1: "STORE_SAME_SIZE_TYPES", 2: "STORE_SCALAR_VECTOR", 3: "STORE_VECTOR_SCALAR"}[section]
    base_decl, base_size = type_values(base)[0]["baseDecl"], type_values(base)[1]
    other_decl, other_size = type_values(other)[0]["baseDecl"], type_values(other)[1]
    extensions, capabilities, memory_model_op = common_lists(model, base)

    def datatype(name):
        capability = [t[2] for t in TYPES if t[0] == name][0]
        if capability:
            capabilities.append(capability)

    def small(name):
        small_extensions, small_capabilities = small_container("storage", name)
        extensions.extend(small_extensions)
        capabilities.extend(small_capabilities)

    values = {"args": "", "storeOp": "OpStore"}
    prefix_text = "%uint32      = OpTypeInt 32 0\n%c_uint32_1  = OpConstant %uint32 1\n"
    if section == 1:
        values.update(
            alignment=str(base_size), baseType=base, baseDecl=base_decl, sameSizeType=other, sameSizeDecl=other_decl, threadCount="64", otherCap=type_capability(other),
        )
        if base != other:
            datatype(other)
        small(base)
        if base_size != other_size:
            small(other)
        prefix = base != "uint32" and other != "uint32"
    else:
        count, comp_base = composite_parts(composite)
        comp_decl = f"OpTypeVector %{comp_base} {count}"
        if section == 2:
            values.update(
                alignment=str(base_size), baseType=base, otherType=comp_base, baseDecl=base_decl, otherTypeDecl=type_values(comp_base)[0]["baseDecl"], otherVec=composite,
                otherVecDecl=comp_decl, otherCap=type_capability(comp_base),
            )
            if base != comp_base:
                datatype(comp_base)
            small(base)
            if base_size != type_values(comp_base)[1]:
                small(comp_base)
            prefix = base != "uint32" and comp_base != "uint32"
        else:
            values.update(
                baseType=comp_base, otherType=other, baseDecl=type_values(comp_base)[0]["baseDecl"], otherTypeDecl=other_decl, otherCap=type_capability(other),
                baseVec=composite, baseVecDecl=comp_decl,
            )
            if comp_base != other:
                datatype(other)
            small(comp_base)
            if type_values(comp_base)[1] != other_size:
                small(other)
            prefix = comp_base != "uint32" and other != "uint32"
        if composite != "vec3_uint32":
            values["inputVec"] = "%vec3_uint32 = OpTypeVector %uint32 3"
    if section == 1:
        prefix_text = "%uint32     = OpTypeInt 32 0\n%c_uint32_1 = OpConstant %uint32 1\n"
    annotations = function_text(source, "std::string createShaderAnnotations(TYPE_PUNNING_TEST_CASE testCase)", label)
    variables = function_text(source, "std::string createShaderVariables(TYPE_PUNNING_TEST_CASE testCase)", label)
    main = function_text(source, "std::string createShaderMain(TYPE_PUNNING_TEST_CASE testCase)", label)
    if prefix:
        variables = prefix_text + variables
    return finish(source, label, values, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


def punning_copy_assembly(source, model, direction, section, op_text, base, other, composite):
    """`addCopyFromUntypedMixedTypeTests` and `addCopyToUntypedMixedTypeTests`: the sections are as in the store and load tests, with `OpCopyMemory` and `OpCopyMemorySized` in place of the load and the store."""
    suffix = {1: "SAME_SIZE_TYPES", 2: "SCALAR_VECTOR", 3: "VECTOR_SCALAR"}[section]
    label = "TypePunningTestCases::" + ("COPY_FROM_" if direction == "from_untyped" else "COPY_TO_") + suffix
    base_decl, base_size = type_values(base)[0]["baseDecl"], type_values(base)[1]
    other_decl = type_values(other)[0]["baseDecl"]
    extensions, capabilities, memory_model_op = common_lists(model, base)
    if base != other:
        capability = [t[2] for t in TYPES if t[0] == other][0]
        if capability:
            capabilities.append(capability)
    small_extensions, small_capabilities = small_container("storage", base)
    extensions.extend(small_extensions)
    capabilities.extend(small_capabilities)

    values = {"copyOp": op_text}
    prefix_text = "%uint32      = OpTypeInt 32 0\n%c_uint32_1  = OpConstant %uint32 1\n"
    if section == 1:
        values.update(
            alignment=str(base_size), baseDecl=base_decl, sameSizeDecl=other_decl, baseType=base, sameSizeType=other, threadCount="64", size=str(base_size),
            otherCap=type_capability(other), copyType=base,
        )
        prefix = base != "uint32" and other != "uint32"
    else:
        count, comp_base = composite_parts(composite)
        comp_decl = f"OpTypeVector %{comp_base} {count}"
        if section == 2:
            values.update(
                baseType=base, baseDecl=base_decl, sameSizeDecl=type_values(comp_base)[0]["baseDecl"], otherType=comp_base, sameSizeType=comp_base,
                otherTypeDecl=type_values(comp_base)[0]["baseDecl"], otherVec=composite, otherVecDecl=comp_decl, size=str(base_size),
                otherCap=type_capability(comp_base), copyType=base, alignment=str(base_size),
            )
            prefix = base != "uint32" and comp_base != "uint32"
        else:
            comp_size = count * type_values(comp_base)[1]
            values.update(
                baseType=comp_base, baseDecl=type_values(comp_base)[0]["baseDecl"], otherType=other, otherTypeDecl=other_decl, baseVec=composite, baseVecDecl=comp_decl,
                size=str(comp_size), otherCap=type_capability(other), copyType=composite, alignment=str(comp_size),
            )
            prefix = comp_base != "uint32" and other != "uint32"
        if composite != "vec3_uint32":
            values["inputVec"] = "%vec3_uint32 = OpTypeVector %uint32 3"
    if section == 1:
        prefix_text = "%uint32     = OpTypeInt 32 0\n%c_uint32_1 = OpConstant %uint32 1\n"
    annotations = function_text(source, "std::string createShaderAnnotations(BASE_TEST_CASE testCase)" if False else "std::string createShaderAnnotations(TYPE_PUNNING_TEST_CASE testCase)", label)
    variables = function_text(source, "std::string createShaderVariables(TYPE_PUNNING_TEST_CASE testCase)", label)
    main = function_text(source, "std::string createShaderMain(TYPE_PUNNING_TEST_CASE testCase)", label)
    if prefix:
        variables = prefix_text + variables
    return finish(source, label, values, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


def punning_multiple_access_chains_assembly(source, model, name):
    """`addMultipleAccessChainTests` (type_punning.reinterpret.multiple_access_chains)."""
    label = "TypePunningTestCases::MULTIPLE_ACCESS_CHAINS"
    values, size = type_values(name)
    values["size"] = str(size)
    extensions, capabilities, memory_model_op = common_lists(model, name)
    small_extensions, small_capabilities = small_container("storage", name)
    extensions.extend(small_extensions)
    capabilities.extend(small_capabilities)
    annotations = function_text(source, "std::string createShaderAnnotations(TYPE_PUNNING_TEST_CASE testCase)", label)
    variables = function_text(source, "std::string createShaderVariables(TYPE_PUNNING_TEST_CASE testCase)", label)
    main = function_text(source, "std::string createShaderMain(TYPE_PUNNING_TEST_CASE testCase)", label)
    if name != "uint32":
        variables = "%uint32     = OpTypeInt  32      0\n%c_uint32_1 = OpConstant %uint32 1\n" + variables
    return finish(source, label, values, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


MEMORY_INTERPRETATION_CASES = [
    "large_array_stride", "non_zero_offset", "mixed_offsets", "multiple_access_chains", "short2_no_storage_cap", "char4_no_storage_cap",
    "char2_16bit_storage_cap", "untyped_from_typed_var", "untyped_from_typed_access_chain",
]


def memory_interpretation_assembly(source, model, read, case):
    """`addMemoryReinterpretationTests` (type_punning.reinterpret.memory_interpretation.{read,write})."""
    label = "MemoryInterpretationTestCases::" + case.upper()
    extensions, capabilities, memory_model_op = common_lists(model, "uint32")
    if case == "short2_no_storage_cap":
        capabilities.append("OpCapability Int16\n")
    elif case == "char4_no_storage_cap":
        capabilities.append("OpCapability Int8\n")
    elif case == "char2_16bit_storage_cap":
        capabilities += ["OpCapability Int8\n", "OpCapability Int16\n"]
    branch = "read" if read else "write"
    annotations = function_text(source, "std::string createShaderAnnotations(MEMORY_INTERPRETATION_TEST_CASE testCase, bool /* read */)", label)
    variables = function_text(keep_branch(source, "std::string createShaderVariables(MEMORY_INTERPRETATION_TEST_CASE testCase, bool read)", branch), "std::string createShaderVariables(MEMORY_INTERPRETATION_TEST_CASE testCase, bool read)", label)
    main = function_text(keep_branch(source, "std::string createShaderMain(MEMORY_INTERPRETATION_TEST_CASE testCase, bool read)", branch), "std::string createShaderMain(MEMORY_INTERPRETATION_TEST_CASE testCase, bool read)", label)
    return finish(source, label, {}, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


STRUCT_AS_TYPE_CASES = [
    # name, specMap values, data types whose capability is requested, small container types
    ("vec2_uint32_vec2_float32_to_vec4_int32", {
        "inputOffsets": "OpMemberDecorate %input_buffer 1 Offset 8\n",
        "baseTypes": "%int32         = OpTypeInt   32 1\n%float32       = OpTypeFloat 32\n%vec2_uint32   = OpTypeVector %uint32  2\n%vec2_float32  = OpTypeVector %float32 2\n%vec4_int32    = OpTypeVector %int32   4\n",
        "inputLayout": "%vec2_uint32 %vec2_float32", "outputLayout": "%vec4_int32"}, [], []),
    ("uint32_to_uint8_uint8_uint8_uint8", {
        "outputOffsets": "OpMemberDecorate %output_buffer 1 Offset 1\nOpMemberDecorate %output_buffer 2 Offset 2\nOpMemberDecorate %output_buffer 3 Offset 3\n",
        "baseTypes": "%uint8         = OpTypeInt   8 0\n", "inputLayout": "%uint32", "outputLayout": "%uint8 %uint8 %uint8 %uint8"}, ["uint8"], ["uint8"]),
    ("vec4_float16_vec2_int32_to_float16_vec2_float16_float16_int32_int32", {
        "inputOffsets": "OpMemberDecorate %input_buffer 1 Offset 16\n",
        "outputOffsets": "OpMemberDecorate %output_buffer 1 Offset 2\nOpMemberDecorate %output_buffer 2 Offset 6\nOpMemberDecorate %output_buffer 3 Offset 8\nOpMemberDecorate %output_buffer 4 Offset 12\n",
        "baseTypes": "%int32         = OpTypeInt   32 1\n%float16       = OpTypeFloat 16\n%vec2_float16  = OpTypeVector %float16 2\n%vec4_float16  = OpTypeVector %float16 4\n%vec2_int32    = OpTypeVector %int32   2\n",
        "inputLayout": "%vec4_float16 %vec2_int32", "outputLayout": "%float16 %vec2_float16 %float16 %int32 %int32"}, ["float16"], ["float16"]),
    ("nested_struct_int32_int32_int32_int32_to_vec2_int32_vec2_int32", {
        "inputOffsets": "OpMemberDecorate %int32_struct 0 Offset 0\nOpMemberDecorate %int32_struct 1 Offset 4\nOpMemberDecorate %int32_struct 2 Offset 8\nOpMemberDecorate %int32_struct 3 Offset 16\n",
        "outputOffsets": "OpMemberDecorate %output_buffer 1 Offset 8\n",
        "baseTypes": "%int32         = OpTypeInt   32 1\n%vec2_int32    = OpTypeVector %int32   2\n%int32_struct  = OpTypeStruct %int32 %int32 %int32 %int32",
        "inputLayout": "%int32_struct", "outputLayout": "%vec2_int32 %vec2_int32"}, [], []),
    ("int64_uint64_vec2_float64_to_nested_struct_vec4_int64", {
        "inputOffsets": "OpMemberDecorate %input_buffer 1 Offset 8\nOpMemberDecorate %input_buffer 2 Offset 16\n",
        "outputOffsets": "OpMemberDecorate %vec4_int64_struct 0 Offset 0\n",
        "baseTypes": "%int64             = OpTypeInt    64 1\n%uint64            = OpTypeInt   64 0\n%float64           = OpTypeFloat 64\n%vec2_float64      = OpTypeVector %float64 2\n%vec4_int64        = OpTypeVector %int64   4\n%vec4_int64_struct = OpTypeStruct %vec4_int64",
        "inputLayout": "%int64 %uint64 %vec2_float64", "outputLayout": "%vec4_int64_struct"}, ["int64", "float64"], []),
    ("uint64_to_nested_struct_uint16_uint16_uint16_uint16", {
        "outputOffsets": "OpMemberDecorate %uint16_struct 0 Offset 0\nOpMemberDecorate %uint16_struct 1 Offset 2\nOpMemberDecorate %uint16_struct 2 Offset 4\nOpMemberDecorate %uint16_struct 3 Offset 6\n",
        "baseTypes": "%uint16        = OpTypeInt   16 0\n%uint64        = OpTypeInt   64 0\n%uint16_struct = OpTypeStruct %uint16 %uint16 %uint16 %uint16",
        "inputLayout": "%uint64", "outputLayout": "%uint16_struct"}, ["int64", "int16"], ["uint16"]),
]


def struct_as_type_assembly(source, model, case):
    """`addStructAsTypeTests`."""
    name, values, datatypes, small_types = case
    label = "TypePunningTestCases::CUSTOM_STRUCT_TYPE"
    extensions, capabilities, memory_model_op = common_lists(model, "uint32")
    for datatype_name in datatypes:
        capability = [t[2] for t in TYPES if t[0] == datatype_name][0]
        if capability:
            capabilities.append(capability)
    for small_name in small_types:
        small_extensions, small_capabilities = small_container("storage", small_name)
        extensions.extend(small_extensions)
        capabilities.extend(small_capabilities)
    annotations = function_text(source, "std::string createShaderAnnotations(TYPE_PUNNING_TEST_CASE testCase)", label)
    variables = function_text(source, "std::string createShaderVariables(TYPE_PUNNING_TEST_CASE testCase)", label)
    main = function_text(source, "std::string createShaderMain(TYPE_PUNNING_TEST_CASE testCase)", label)
    return finish(source, label, dict(values), extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


BLOCK_ARRAY_CASES = [
    "basic", "reinterpret_block_normal_access_chain", "reinterpret_block_normal_ptr_access_chain", "reinterpret_block_untyped_access_chain",
    "reinterpret_block_untyped_ptr_access_chain", "select_block_normal_access_chain", "select_block_normal_ptr_access_chain",
    "select_block_untyped_access_chain", "select_block_untyped_ptr_access_chain",
]
BLOCK_ARRAY_VARIABLE_POINTER_CASES = {
    "reinterpret_block_normal_ptr_access_chain", "reinterpret_block_untyped_ptr_access_chain", "select_block_normal_access_chain",
    "select_block_normal_ptr_access_chain", "select_block_untyped_access_chain", "select_block_untyped_ptr_access_chain",
}


def block_array_assembly(source, model, case):
    """`addBlockArrayTests`: `createShaderMain(testCase, specMap)` fills the `specMap` per case; the template follows the switch."""
    label = case.upper()
    signature = "std::string createShaderMain(BLOCK_ARRAY_TEST_CASE testCase, std::map<std::string, std::string> &specMap)"
    start = source.index(signature)
    body = source[start : source.index("\n}\n", start)]
    block = re.search(r"case BlockArrayTestCases::" + label + r":\s*\{(.*?)break;", body, re.S).group(1)
    values = {}
    for match in re.finditer(r'specMap\["(\w+)"\]\s*=\s*((?:std::string\(\s*)?(?:"(?:[^"\\]|\\.)*"\s*)+\)?)\s*;', block):
        values[match.group(1)] = "".join(decode(m.group(1)) for m in LITERAL.finditer(match.group(2)))
    assert len(values) == 8, (case, sorted(values))
    values.update(threads="4", threads_const="%c_uint32_4")
    extensions, capabilities, memory_model_op = common_lists(model, "uint32")
    extensions.append('OpExtension "SPV_EXT_descriptor_indexing"\n')
    capabilities.append("OpCapability StorageBufferArrayDynamicIndexing\n")
    if case in BLOCK_ARRAY_VARIABLE_POINTER_CASES:
        extensions.append('OpExtension "SPV_KHR_variable_pointers"\n')
        capabilities.append("OpCapability VariablePointersStorageBuffer\n")
    annotations = function_text(source, "std::string createShaderAnnotations(BLOCK_ARRAY_TEST_CASE /* testCase */)")
    variables = function_text(source, "std::string createShaderVariables(BLOCK_ARRAY_TEST_CASE /* testCase */)")
    main = function_text(source, signature)
    return finish(source, label, values, extensions, capabilities, memory_model_op, HEADER, annotations, variables, main)


def main():
    source = CPP.read_text(encoding="utf-8")
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.untyped_pointers.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_untyped_pointers_manifest.py - do not hand-edit; `spec` is the memory model, the group, the kind and the type of a case.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/untyped_pointers_tests"\n'
    ]
    entries = []
    for model in ("vulkan", "glsl"):
        base = f"untyped_pointers/{model}_memory_model"
        base_path = base
        for container in ("uniform", "storage", "push_constant"):
            for name, _, _, _ in TYPES:
                entries.append((f"{base}/basic_usecase/load/{container}/{name}", f"model={model};group=load;container={container};type={name}",
                                base_assembly(source, model, "load", container, name), None))
        for name, _, _, _ in TYPES:
            entries.append((f"{base}/basic_usecase/store/{name}", f"model={model};group=store;container=storage;type={name}",
                            base_assembly(source, model, "store", "storage", name), None))
        for name, _, _, _ in TYPES:
            entries.append((f"{base}/basic_usecase/array_length/{name}", f"model={model};group=array_length;container=storage;type={name}",
                            base_assembly(source, model, "array_length", "storage", name), None))
        for name, _, _, _ in TYPES:
            entries.append((f"{base}/basic_usecase/descriptor_array/{name}", f"model={model};group=descriptor_array;container=storage;type={name}",
                            base_assembly(source, model, "descriptor_array", "storage", name), None))
        for group, label, interfaces, sub_groups in PHYSICAL_OPERATIONS:
            for sub in sub_groups or (None,):
                for name, _, _, _ in TYPES:
                    path = f"{base}/physical_storage/{group}" + (f"/{sub}" if sub else "") + f"/{name}"
                    spec = f"model={model};group=physical;op={group.split('/')[-1] if sub is None and 'bitcast' not in group else group.replace('/', '_')};sub={sub or ''};type={name}"
                    entries.append((path, spec, physical_assembly(source, model, label, interfaces, name), "spirv1.4" if sub else None))
        for group, label, interfaces, sub_groups in VARIABLE_POINTER_OPERATIONS:
            for sub in sub_groups or (None,):
                for name, _, _, _ in TYPES:
                    path = f"{base}/variable_pointers/{group}" + (f"/{sub}" if sub else "") + f"/{name}"
                    spec = f"model={model};group=varptr;op={group};sub={sub or ''};type={name}"
                    version = "spirv1.4" if sub or group == "workgroup_memory" else None
                    entries.append((path, spec, variable_pointer_assembly(source, model, group, label, interfaces, name), version))
        for op_group, label, operation in (("op_ptr_equal", "OP_PTR_EQUAL_VARIABLE_PTR", "OpPtrEqual"), ("op_ptr_not_equal", "OP_PTR_NOT_EQUAL_VARIABLE_PTR", "OpPtrNotEqual")):
            for block, group, suffix in PTR_COMPARE_BLOCKS:
                for name, _, _, _ in TYPES:
                    leaf = name + (suffix.split("/")[0] if block != 2 else "_to_" + SECOND_TYPES[name][0])
                    entries.append((f"{base}/variable_pointers/{op_group}/{group}/{leaf}", f"model={model};group=ptrcmp;op={op_group};block={block};type={name}",
                                    ptr_compare_assembly(source, model, label, operation, block, name), "spirv1.4"))
        for block in (1, 2):
            for name, _, _, _ in TYPES:
                leaf = name if block == 1 else name + "_to_" + SECOND_TYPES[name][0]
                entries.append((f"{base}/variable_pointers/op_ptr_diff/{leaf}", f"model={model};group=ptrdiff;block={block};type={name}",
                                ptr_diff_assembly(source, model, block, name), "spirv1.4"))
        for container in ("uniform", "storage", "push_constant"):
            for scalar in TYPE_NAMES:
                for other in SAME_SIZE_BASE[scalar]:
                    entries.append((f"{base_path}/type_punning/load/{container}/{scalar}_to_{other}", f"model={model};group=punload;section=1;container={container};base={scalar};other={other};comp=",
                                    punning_load_assembly(source, model, 1, container, scalar, other, None), None))
            for scalar in TYPE_NAMES:
                for composite in SAME_SIZE_COMPOSITE.get(scalar, []):
                    entries.append((f"{base_path}/type_punning/load/{container}/{scalar}_to_{composite}", f"model={model};group=punload;section=2;container={container};base={scalar};other={composite_parts(composite)[1]};comp={composite}",
                                    punning_load_assembly(source, model, 2, container, scalar, composite_parts(composite)[1], composite), None))
            for composite in COMPOSITES:
                for other in COMPOSITE_SAME_SIZE_BASE.get(composite, []):
                    entries.append((f"{base_path}/type_punning/load/{container}/{composite}_to_{other}", f"model={model};group=punload;section=3;container={container};base={composite_parts(composite)[1]};other={other};comp={composite}",
                                    punning_load_assembly(source, model, 3, container, composite_parts(composite)[1], other, composite), None))
        for scalar in TYPE_NAMES:
            for other in SAME_SIZE_BASE[scalar]:
                entries.append((f"{base_path}/type_punning/store/{scalar}_to_{other}", f"model={model};group=punstore;section=1;base={scalar};other={other};comp=",
                                punning_store_assembly(source, model, 1, scalar, other, None), None))
        for scalar in TYPE_NAMES:
            for composite in SAME_SIZE_COMPOSITE.get(scalar, []):
                entries.append((f"{base_path}/type_punning/store/{scalar}_to_{composite}", f"model={model};group=punstore;section=2;base={scalar};other={composite_parts(composite)[1]};comp={composite}",
                                punning_store_assembly(source, model, 2, scalar, composite_parts(composite)[1], composite), None))
        for composite in COMPOSITES:
            for other in COMPOSITE_SAME_SIZE_BASE.get(composite, []):
                entries.append((f"{base_path}/type_punning/store/{composite}_to_{other}", f"model={model};group=punstore;section=3;base={composite_parts(composite)[1]};other={other};comp={composite}",
                                punning_store_assembly(source, model, 3, composite_parts(composite)[1], other, composite), None))
        for block_case in BLOCK_ARRAY_CASES:
            entries.append((f"{base_path}/block_array/block_array/{block_case}", f"model={model};group=blockarray;case={block_case}",
                            block_array_assembly(source, model, block_case), None))
        for struct_case in STRUCT_AS_TYPE_CASES:
            entries.append((f"{base_path}/type_punning/reinterpret/struct_as_type/{struct_case[0]}", f"model={model};group=pustruct;case={struct_case[0]}",
                            struct_as_type_assembly(source, model, struct_case), None))
        for read in (True, False):
            for case in MEMORY_INTERPRETATION_CASES:
                entries.append((f"{base_path}/type_punning/reinterpret/memory_interpretation/{'read' if read else 'write'}/{case}",
                                f"model={model};group=pumi;kind={'read' if read else 'write'};case={case}",
                                memory_interpretation_assembly(source, model, read, case), None))
        for name in TYPE_NAMES:
            entries.append((f"{base_path}/type_punning/reinterpret/multiple_access_chains/{name}", f"model={model};group=pumac;type={name}",
                            punning_multiple_access_chains_assembly(source, model, name), None))
        for direction in ("from_untyped", "to_untyped"):
            for op_group, op_text in COPY_OPERATIONS[1:]:
                for scalar in TYPE_NAMES:
                    for other in SAME_SIZE_BASE[scalar]:
                        entries.append((f"{base_path}/type_punning/copy/{direction}/{op_group}/{scalar}_to_{other}", f"model={model};group=puncopy;kind={direction};section=1;base={scalar};other={other};comp=",
                                        punning_copy_assembly(source, model, direction, 1, op_text, scalar, other, None), None))
                for scalar in TYPE_NAMES:
                    for composite in SAME_SIZE_COMPOSITE.get(scalar, []):
                        entries.append((f"{base_path}/type_punning/copy/{direction}/{op_group}/{scalar}_to_{composite}", f"model={model};group=puncopy;kind={direction};section=2;base={scalar};other={composite_parts(composite)[1]};comp={composite}",
                                        punning_copy_assembly(source, model, direction, 2, op_text, scalar, composite_parts(composite)[1], composite), None))
                for composite in COMPOSITES:
                    for other in COMPOSITE_SAME_SIZE_BASE.get(composite, []):
                        entries.append((f"{base_path}/type_punning/copy/{direction}/{op_group}/{composite}_to_{other}", f"model={model};group=puncopy;kind={direction};section=3;base={composite_parts(composite)[1]};other={other};comp={composite}",
                                        punning_copy_assembly(source, model, direction, 3, op_text, composite_parts(composite)[1], other, composite), None))
        for family in ("load", "store"):
            for name in ATOMIC_TYPES:
                entries.append((f"{base}/basic_usecase/atomics/{family}/{name}", f"model={model};group=atomic;kind={family};type={name}",
                                atomic_assembly(source, model, family, name), None))
        for group, label, op_names, op_value, types, prefix_kind in ATOMIC_OPERATIONS:
            for name in types:
                for comp in (("1", "0") if group == "compare_exchange" else ("",)):
                    sub = ("exchanged/" if comp == "1" else "not_exchanged/") if comp else ""
                    entries.append((f"{base}/basic_usecase/atomics/{group}/{sub}{name}", f"model={model};group=atomicop;kind={group};comp={comp};type={name}",
                                    atomic_op_assembly(source, model, group, label, op_names, op_value, name, comp or "0", prefix_kind), "spirv1.4"))
        for direction in ("from_untyped", "to_untyped"):
            for op_group, op_text in COPY_OPERATIONS:
                for name, _, _, _ in TYPES:
                    entries.append((f"{base}/basic_usecase/copy/{direction}/{op_group}/{name}", f"model={model};group=copy;kind={direction};type={name};op={op_group}",
                                    base_assembly(source, model, "copy_from" if direction == "from_untyped" else "copy_to", op_text, name), None))
        for kind in ("aliased", "not_aliased"):
            for name, _, _, _ in TYPES:
                entries.append((f"{base}/workgroup_memory_explicit_layout/{kind}/{name}", f"model={model};group=workgroup;kind={kind};type={name}",
                                workgroup_assembly(source, model, kind, name), "spirv1.4"))
    for path, spec, asm, version in entries:
        const = "UNTYPED_" + "".join(c if c.isalnum() else "_" for c in path).upper()
        version_text = f', spirv_version = "{version}"' if version else ""
        out.append(
            f'\n[[case]]\nname = "{path}"\nrust_const = "{const}"\nrust_type = "UntypedPointersCase"\n'
            f'programs = [ {{ name = "comp", template = "{TEMPLATE}", stage = "asm"{version_text} }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
            f"derived = {{ source = {json.dumps(repr(asm))} }}\n"
        )
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {len(entries)} cases")


if __name__ == "__main__":
    main()

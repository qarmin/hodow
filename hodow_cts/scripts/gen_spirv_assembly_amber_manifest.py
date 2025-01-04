#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_amber.toml: the compute Amber scripts of `spirv_assembly/instruction/compute` that this port can run.

Amber is a script language of its own, and hodow_cts has no interpreter for it. What it needs from the scripts that are plain compute is small -
one SPIR-V assembly shader, storage buffers with initial contents, one dispatch and an expected buffer - so this reads exactly that subset and
turns each script into a manifest case that src/vkt/tests/spirv_assembly/amber_tests.rs runs through the compute case of the assembly groups.
A script using anything else (GLSL shaders, a second pipeline, push constants, an expectation on part of a buffer, the VkScript format) is
skipped and listed on stderr, so a missing script never reads as a passing one.

    python3 hodow_cts/scripts/gen_spirv_assembly_amber_manifest.py [--cts-dir ../tmp/VK-GL-CTS]

A pure text generator: no spirv-as and no cargo.
"""

import argparse
import json
import re
import struct
import sys
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_amber.toml"
TEMPLATE = "spirv_assembly/source.asm"
AMBER_DIR = "external/vulkancts/data/vulkan/amber"
# compute_basic and permuted_index are not part of instruction.compute: basic_compute_shader_tests.rs registers the first under
# compute.pipeline.basic and message_passing_tests.rs the second under memory_model.message_passing.
GROUPS = {
    "signed_op": "spirv_assembly/instruction/compute/signed_op",
    "mul_extended": "spirv_assembly/instruction/compute/mul_extended",
    "undef": "spirv_assembly/instruction/compute/undef",
    "graphics/switch_block_order": "spirv_assembly/instruction/compute/switch",
    "oparraylength": "spirv_assembly/instruction/compute/arraylength",
    "opunreachable": "spirv_assembly/instruction/compute/unreachable",
    "signed_int_compare": "spirv_assembly/instruction/compute/signed_int_compare",
    "vector_shuffle": "spirv_assembly/instruction/compute/vector_shuffle",
    "ptr_access_chain": "spirv_assembly/instruction/compute/ptr_access_chain",
    "ldexp": "ldexp",
    "float32": "spirv_assembly/instruction/float32/comparison",
    "compute_basic": "compute",
    "permuted_index": "memory_model/message_passing/permuted_index",
}

VP_SSBO = ["VariablePointerFeatures.variablePointersStorageBuffer"]
VP_FULL = VP_SSBO + ["VariablePointerFeatures.variablePointers"]
VP_FULL_LAYOUT = VP_FULL + ["VK_KHR_workgroup_memory_explicit_layout"]
INT16 = ["Features.shaderInt16"]
INT16_STORAGE = INT16 + ["VK_KHR_16bit_storage", "Storage16BitFeatures.storageBuffer16BitAccess"]
INT64 = ["Features.shaderInt64"]
SPIRV1P4_DIR = "spirv_assembly/instruction/spirv1p4/"
# createSpirvVersion1p4Group of vktSpvAsmSpirvVersion1p4Tests.cpp: the cases of each group in upstream's order, with the requirements it adds.
# Every one of them also requires VK_KHR_spirv_1_4 and is assembled as SPIR-V 1.4.
SPIRV1P4_GROUPS = {
    "opcopylogical": [(name, []) for name in (
        "different_matrix_layout", "different_matrix_strides", "nested_arrays_different_inner_stride", "nested_arrays_different_outer_stride",
        "nested_arrays_different_strides", "same_array_two_ids", "same_struct_two_ids", "ssbo_to_ubo", "two_arrays_different_stride_1",
        "two_arrays_different_stride_2", "ubo_to_ssbo")],
    "opptrdiff": [
        ("ssbo_comparisons_diff", VP_SSBO), ("variable_pointers_vars_ssbo_2_diff", VP_SSBO), ("variable_pointers_vars_ssbo_diff", VP_SSBO),
        ("variable_pointers_vars_wg_diff", VP_FULL), ("wg_comparisons_diff", VP_FULL)],
    "opptrequal": [
        ("different_ssbos_equal", VP_FULL), ("different_wgs_equal", VP_FULL), ("null_comparisons_ssbo_equal", VP_SSBO),
        ("null_comparisons_wg_equal", VP_FULL), ("ssbo_comparisons_equal", VP_SSBO), ("variable_pointers_ssbo_2_equal", VP_FULL),
        ("variable_pointers_ssbo_equal", VP_SSBO), ("variable_pointers_vars_ssbo_equal", VP_SSBO), ("simple_variable_pointers_ptr_equal", VP_SSBO),
        ("variable_pointers_vars_wg_equal", VP_FULL), ("variable_pointers_wg_equal", VP_FULL), ("wg_comparisons_equal", VP_FULL)],
    "opptrnotequal": [
        ("different_ssbos_not_equal", VP_FULL), ("different_wgs_not_equal", VP_FULL), ("null_comparisons_ssbo_not_equal", VP_SSBO),
        ("null_comparisons_wg_not_equal", VP_FULL), ("ssbo_comparisons_not_equal", VP_SSBO), ("variable_pointers_ssbo_2_not_equal", VP_FULL),
        ("variable_pointers_ssbo_not_equal", VP_SSBO), ("simple_variable_pointers_ptr_not_equal", VP_SSBO),
        ("variable_pointers_vars_ssbo_not_equal", VP_SSBO), ("variable_pointers_vars_wg_not_equal", VP_FULL),
        ("variable_pointers_wg_not_equal", VP_FULL), ("wg_comparisons_not_equal", VP_FULL)],
    "opcopymemory": [(name, []) for name in ("different_alignments", "no_source_access_operands", "no_target_access_operands")],
    "uniformid": [(name, []) for name in (
        "partially_active_uniform_id", "subgroup_cfg_uniform_id", "subgroup_uniform", "workgroup_cfg_uniform_id", "workgroup_uniform")],
    "nonwritable": [(name, []) for name in (
        "function_2_nonwritable", "function_nonwritable", "non_main_function_nonwritable", "private_2_nonwritable", "private_nonwritable")],
    "entrypoint": [
        ("comp_pc_entry_point", []), ("comp_ssbo_entry_point", []), ("comp_ubo_entry_point", []), ("comp_workgroup_entry_point", [])],
    "hlsl_functionality1": [("counter_buffer", []), ("decorate_string", []), ("member_decorate_string", [])],
    "loop_control": [(name, []) for name in ("iteration_multiple", "max_iterations", "min_iterations", "partial_count", "peel_count")],
    "opselect": [
        ("array_select", []), ("array_stride_select", []), ("nested_array_select", []), ("nested_struct_select", []), ("scalar_select", []),
        ("ssbo_pointers_2_select", VP_FULL), ("ssbo_pointers_select", VP_SSBO), ("struct_select", []), ("vector_element_select", []),
        ("vector_select", []), ("wg_pointers_2_select", VP_FULL_LAYOUT), ("wg_pointers_select", VP_FULL_LAYOUT)],
    "uconvert": [
        ("spec_const_opt_extend_16_64_bit", INT64), ("spec_const_opt_extend_16", INT16), ("spec_const_opt_extend_251658240_64_bits", INT64),
        ("spec_const_opt_extend_61440", INT16), ("spec_const_opt_truncate_16_64_bit", INT64), ("spec_const_opt_truncate_16", INT16_STORAGE),
        ("spec_const_opt_truncate_983040", INT16_STORAGE), ("spec_const_opt_zero_extend_n4096", INT16)],
    "wrap": [("no_signed_wrap", []), ("no_unsigned_wrap", [])],
}
# The groups whose upstream case names are the script names as they are (`switch-case-to-merge-block`); the others spell them with underscores.
KEEP_DASHES = {"graphics/switch_block_order", "oparraylength", "opunreachable"}

# Scripts registered under a name of their own: (directory below the Amber data, script, case name, extra requirements, SPIR-V target env).
# They only exist for the monolithic pipeline type: the shader object subtrees of upstream's compute group leave them out.
WMEL_DIR = "compute/workgroup_memory_explicit_layout"
WMEL_REQUIREMENTS = ["VK_KHR_workgroup_memory_explicit_layout", "VK_KHR_spirv_1_4"]
EXPLICIT_SCRIPTS = [
    (WMEL_DIR, "copy_memory_basic", "workgroup_memory_explicit_layout/copy_memory/basic", WMEL_REQUIREMENTS, "spv1.4"),
    (WMEL_DIR, "copy_memory_two_invocations", "workgroup_memory_explicit_layout/copy_memory/two_invocations", WMEL_REQUIREMENTS, "spv1.4"),
    (WMEL_DIR, "copy_memory_variable_pointers", "workgroup_memory_explicit_layout/copy_memory/variable_pointers",
     WMEL_REQUIREMENTS + ["VariablePointerFeatures.variablePointers", "VK_EXT_descriptor_indexing"], "spv1.4"),
    (WMEL_DIR, "zero_ext_block", "workgroup_memory_explicit_layout/zero_ext/block", WMEL_REQUIREMENTS + ["VK_KHR_zero_initialize_workgroup_memory"], "spv1.4"),
    (WMEL_DIR, "zero_ext_other_block", "workgroup_memory_explicit_layout/zero_ext/other_block", WMEL_REQUIREMENTS + ["VK_KHR_zero_initialize_workgroup_memory"], "spv1.4"),
    (WMEL_DIR, "zero_ext_block_with_offset", "workgroup_memory_explicit_layout/zero_ext/block_with_offset", WMEL_REQUIREMENTS + ["VK_KHR_zero_initialize_workgroup_memory"], "spv1.4"),
    ("graphicsfuzz", "barrier-in-loop-with-break", "graphicsfuzz/barrier-in-loop-with-break", [], None),
    ("graphicsfuzz", "dead-barriers-in-loops", "graphicsfuzz/dead-barriers-in-loops", [], None),
    ("graphicsfuzz", "early-return-and-barrier", "graphicsfuzz/early-return-and-barrier", [], None),
    ("graphicsfuzz", "unreachable-barrier-in-loops", "graphicsfuzz/unreachable-barrier-in-loops", [], None),
    ("graphicsfuzz", "loops-breaks-returns", "graphicsfuzz/loops-breaks-returns", [], None),
    ("graphicsfuzz", "two-for-loops-with-barrier-function", "graphicsfuzz/two-for-loops-with-barrier-function", [], None),
    ("graphicsfuzz", "two-nested-for-loops-with-returns", "graphicsfuzz/two-nested-for-loops-with-returns", [], None),
    ("crash_test", "divbyzero_comp", "crash_test/divbyzero_comp", [], None),
    ("misc", "fma_test_hang", "robustness/misc/fma_test_hang", ["robustBufferAccess"], None),
] + [
    ("compute/zero_initialize_workgroup_memory", f"workgroup_size_{size}", f"zero_initialize_workgroup_memory/shared_memory_blocks/workgroup_size_{size}",
     ["VK_KHR_zero_initialize_workgroup_memory"], None)
    for size in ("128", "8x8x2", "8x2x8", "2x8x8", "8x4x4", "4x8x4", "4x4x8")
]
GROUP_TARGET_ENV = {"ptr_access_chain": "spv1.4"}
GROUP_EXTENSIONS = {"ptr_access_chain": ["VK_KHR_spirv_1_4"]}
VKSCRIPT_FEATURES = {
    "VariablePointerFeatures.variablePointers",
    "VariablePointerFeatures.variablePointersStorageBuffer",
    "ShaderLongVectorFeaturesEXT.longVector",
    "Storage16BitFeatures.storageBuffer16BitAccess",
    "shaderInt16",
    "shaderInt64",
}
VKSCRIPT_TYPES = {
    "int": "int32",
    "uint": "uint32",
    "float": "float",
    "double": "double",
    "int8_t": "int8",
    "int16_t": "int16",
    "int32_t": "int32",
    "int64_t": "int64",
    "uint8_t": "uint8",
    "uint16_t": "uint16",
    "uint32_t": "uint32",
    "uint64_t": "uint64",
}


def vkscript_scalar(name):
    """The scalar of a VkScript data type: `ivec2` and `vec4` hold the elements of their scalar one after the other."""
    match = re.fullmatch(r"([iud]?)vec\d", name)
    if match:
        return {"i": "int32", "u": "uint32", "d": "double", "": "float"}[match.group(1)]
    if name not in VKSCRIPT_TYPES:
        raise Skip("data type " + name)
    return VKSCRIPT_TYPES[name]

SCALARS = {
    "int8": ("b", 1, int),
    "int16": ("h", 2, int),
    "int32": ("i", 4, int),
    "int64": ("q", 8, int),
    "uint8": ("B", 1, int),
    "uint16": ("H", 2, int),
    "uint32": ("I", 4, int),
    "uint64": ("Q", 8, int),
    "float16": ("e", 2, float),
    "float": ("f", 4, float),
    "double": ("d", 8, float),
}


NO_EXPECTATION_OK = True


class Skip(Exception):
    pass


def full_mask(data):
    return (b"\xff" * len(data)).hex()


def parse_type(text):
    match = re.fullmatch(r"vec(\d)<(\w+)>", text)
    components, scalar = (int(match.group(1)), match.group(2)) if match else (1, text)
    if scalar not in SCALARS:
        raise Skip(f"data type {text}")
    return components, scalar


def pack(values, scalar):
    try:
        return pack_values(values, scalar)
    except (ValueError, struct.error) as error:
        raise Skip(f"data {error}")


def pack_values(values, scalar):
    code, _, kind = SCALARS[scalar]
    out = b""
    for value in values:
        is_hex = value.lower().lstrip("-").startswith("0x")
        number = int(value, 0) if kind is int and (is_hex or not re.search(r"[.eE]", value)) else kind(float(value))
        if kind is int:
            number = int(number)
            number &= (1 << (8 * SCALARS[scalar][1])) - 1
            if code.islower():
                code_use = code.upper()
            else:
                code_use = code
            out += struct.pack("<" + code_use, number)
        else:
            out += struct.pack("<" + code, number)
    return out


def parse_buffer(tokens, base=None):
    """tokens: everything after `BUFFER name`, already joined across lines; `base` is the directory the `FILE` buffers are read from."""
    if tokens[0] == "FORMAT":
        raise Skip("image buffer")
    if tokens[0] != "DATA_TYPE":
        raise Skip("buffer without DATA_TYPE")
    components, scalar = parse_type(tokens[1])
    rest = tokens[2:]
    if rest[0] == "DATA":
        values = rest[1:]
        assert values[-1] == "END"
        return components, scalar, pack(values[:-1], scalar)
    if rest[0] == "SIZE":
        size = int(rest[1])
        if rest[2] == "FILL":
            return components, scalar, pack([rest[3]] * (size * components), scalar)
        if rest[2] == "FILE" and rest[3] == "TEXT" and base is not None:
            words = []
            for line in (base / rest[4]).read_text(encoding="utf-8").splitlines():
                words += line.split("#")[0].split()
            # The comparison scripts name a file of several times SIZE values: the first SIZE of them are the buffer.
            if len(words) < size * components:
                raise Skip("file buffer of another size")
            return components, scalar, pack(words[: size * components], scalar)
        if rest[2] == "SERIES_FROM":
            start, step = rest[3], rest[5]
            values = [str(int(start) + int(step) * index) for index in range(size * components)]
            return components, scalar, pack(values, scalar)
    raise Skip("buffer initialiser " + " ".join(rest[:3]))


def split_binding(text):
    """`S:B`, or `B` alone for descriptor set 0."""
    return text.split(":") if ":" in text else ["0", text]


def convert_vkscript(path):
    sections, current = {}, None
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        text = line.strip()
        if re.fullmatch(r"\[[^\]]+\]", text):
            current = text
            sections[current] = []
        elif current is not None and text and not text.startswith("#"):
            sections[current].append(line if current == "[compute shader spirv]" else text)
    unknown = set(sections) - {"[require]", "[compute shader spirv]", "[test]"}
    if unknown or "[compute shader spirv]" not in sections:
        raise Skip("vkscript sections " + ",".join(sorted(unknown)))

    features = []
    for requirement in sections.get("[require]", []):
        if requirement in VKSCRIPT_FEATURES or requirement.startswith("VK_"):
            features.append(requirement)
        else:
            raise Skip("requirement " + requirement)

    buffers, probes, ubos, push, dispatch = {}, {}, {}, {}, None

    def write(target, binding, offset, data):
        buffer = target.setdefault(binding, bytearray())
        if len(buffer) < offset + len(data):
            buffer.extend(bytes(offset + len(data) - len(buffer)))
        buffer[offset : offset + len(data)] = data

    for line in sections["[test]"]:
        words = line.split()
        if words[0] == "ssbo" and len(words) == 3 and words[2].isdigit():
            ssbo_set, binding = split_binding(words[1])
            if ssbo_set != "0":
                raise Skip("descriptor set " + ssbo_set)
            write(buffers, int(binding), int(words[2]), b"")
        elif words[0] == "ssbo" and words[2] == "subdata":
            ssbo_set, binding = split_binding(words[1])
            if ssbo_set != "0":
                raise Skip("descriptor set " + ssbo_set)
            write(buffers, int(binding), int(words[4]), pack(words[5:], vkscript_scalar(words[3])))
        elif words[0] == "uniform" and words[1] == "ubo":
            ubo_set, binding = words[2].split(":")
            if ubo_set != "0":
                raise Skip("descriptor set " + ubo_set)
            write(ubos, int(binding), int(words[4]), pack(words[5:], vkscript_scalar(words[3])))
        elif words[0] == "uniform" and words[1] in VKSCRIPT_TYPES:
            write(push, 0, int(words[2]), pack(words[3:], vkscript_scalar(words[1])))
        elif words[0] == "compute" and words[1:] == ["entrypoint", "main"]:
            continue
        elif words[0] == "compute" and len(words) == 4 and dispatch is None:
            dispatch = [int(value) for value in words[1:]]
        elif words[0] == "probe" and words[1] == "ssbo" and words[5] == "==":
            ssbo_set, binding = split_binding(words[3])
            if ssbo_set != "0":
                raise Skip("descriptor set " + ssbo_set)
            data = pack(words[6:], vkscript_scalar(words[2]))
            offset = int(words[4])
            write(probes, int(binding), offset, data)
            write(probes, -1 - int(binding), offset, b"\xff" * len(data))
        else:
            raise Skip("test statement " + " ".join(words[:3]))
    if dispatch is None or not any(binding >= 0 for binding in probes):
        raise Skip("not a single-dispatch compute script")
    expected, masks = {}, {}
    for binding, data in probes.items():
        if binding < 0:
            continue
        if binding not in buffers or len(buffers[binding]) < len(data):
            raise Skip("expectation outside of the buffer")
        covered = probes[-1 - binding]
        merged = bytearray(buffers[binding])
        mask = bytearray(len(merged))
        for index, flag in enumerate(covered):
            if flag:
                merged[index] = data[index]
                mask[index] = 0xFF
        expected[binding], masks[binding] = bytes(merged), bytes(mask)
    if ubos:
        if set(ubos) & set(buffers) or any(binding in expected for binding in ubos):
            raise Skip("a binding that is both a uniform and a storage buffer")
        if any(binding not in expected for binding in buffers):
            raise Skip("uniform and storage buffer inputs together")
        features.append("UBO_INPUTS")
    buffers = {binding: bytes(data) for binding, data in {**ubos, **buffers}.items()}
    bound = sorted(buffers)
    if bound != list(range(bound[0], bound[0] + len(bound))):
        raise Skip("bindings are not consecutive")
    started = False
    for binding in bound:
        if binding in expected:
            started = True
        elif started:
            raise Skip("an input bound after an output")

    return dict(
        shader="\n".join(sections["[compute shader spirv]"]) + "\n",
        language="SPIRV-ASM",
        target_env=None,
        features=features,
        dispatch=dispatch,
        buffers=";".join(f"{binding}:{buffers[binding].hex()}" for binding in bound),
        checks=";".join(f"{binding}:{expected[binding].hex()}:{masks[binding].hex()}" for binding in bound if binding in expected),
        tolerance_width=0,
        push_constants=bytes(push.get(0, b"")).hex(),
        spec_constants="",
    )


def convert(path):
    if "[compute shader spirv]" in path.read_text(encoding="utf-8", errors="replace"):
        return convert_vkscript(path)

    lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    features, shader, target_env, shader_language = [], None, None, None
    buffers, pipelines, runs, expects, push_buffer, spec_constants = {}, {}, [], [], [], {}
    array_names = []
    index = 0
    while index < len(lines):
        raw = lines[index].rstrip()
        text = raw.strip()
        index += 1
        if not text or text.startswith("#") or text == "#!amber":
            continue
        words = text.split()
        if words[0] == "DEVICE_FEATURE":
            features.append(words[1])
        elif words[0] == "DEVICE_EXTENSION":
            continue
        elif words[0] == "SHADER":
            if words[1] != "compute" or words[3] not in ("SPIRV-ASM", "GLSL") or shader is not None:
                raise Skip("shader " + " ".join(words[1:4]))
            shader_language = words[3]
            if "TARGET_ENV" in words:
                target_env = words[words.index("TARGET_ENV") + 1]
            body = []
            while lines[index].strip() != "END":
                body.append(lines[index])
                index += 1
            index += 1
            shader = "\n".join(body) + "\n"
        elif words[0] == "BUFFER":
            name, tokens = words[1], text.split("#")[0].split()[2:]
            if "DATA" in tokens and tokens[-1] != "END":
                while True:
                    line = lines[index].split("#")[0].strip()
                    index += 1
                    tokens += line.split()
                    if line.endswith("END") or line == "END":
                        break
            buffers[name] = parse_buffer(tokens, path.parent)
        elif words[0] == "PIPELINE":
            if words[1] != "compute" or pipelines:
                raise Skip("pipeline " + " ".join(words[1:3]))
            bindings = []
            while lines[index].strip() != "END":
                step = lines[index].split()
                index += 1
                if not step:
                    continue
                if step[0] == "BIND" and step[1] == "BUFFER_ARRAY" and "AS" in step:
                    as_index = step.index("AS")
                    if step[as_index + 1 :] != ["storage", "DESCRIPTOR_SET", "0", "BINDING", "0"] or array_names:
                        raise Skip("buffer array " + " ".join(step[as_index:]))
                    array_names = step[2:as_index]
                    continue
                if step[0] == "ATTACH" and len(step) == 2:
                    continue
                if step[0] == "ATTACH" and len(step) == 7 and step[2] == "SPECIALIZE" and step[4] == "AS" and step[5] in SCALARS:
                    spec_constants[int(step[3])] = pack([step[6]], step[5]).hex()
                    continue
                if step[0] == "BIND" and step[1] == "BUFFER" and step[3:5] == ["AS", "storage"] and step[5] == "DESCRIPTOR_SET" and step[6] == "0" and step[7] == "BINDING":
                    bindings.append((int(step[8]), step[2]))
                    continue
                if step[0] == "BIND" and step[1] == "BUFFER" and step[3:] == ["AS", "push_constant"]:
                    push_buffer.append(step[2])
                    continue
                raise Skip("pipeline statement " + " ".join(step[:3]))
            index += 1
            pipelines[words[2]] = bindings
        elif words[0] == "RUN":
            runs.append(words[1:])
        elif words[0] == "EXPECT":
            expects.append(words[1:])
        else:
            raise Skip("statement " + words[0])

    if shader is None or len(pipelines) != 1 or len(runs) != 1:
        raise Skip("not a single-dispatch compute script")
    if not expects and not NO_EXPECTATION_OK:
        raise Skip("not a single-dispatch compute script")
    (bindings,) = pipelines.values()
    run = runs[0]
    if len(run) != 4 or run[0] not in pipelines:
        raise Skip("run form")
    dispatch = [int(value) for value in run[1:]]

    checks, tolerance_width = {}, 0
    partial = {}
    eq_outputs = None
    for expect in expects:
        name = expect[0]
        if len(expect) == 3 and expect[1] == "EQ_BUFFER" and expect[2] in {bound_name for _, bound_name in bindings}:
            # Both buffers are written by the shader: they have to end up equal to each other.
            if eq_outputs is not None:
                raise Skip("several buffer to buffer expectations")
            eq_outputs = (name, expect[2])
            for each in eq_outputs:
                checks[each] = (buffers[each][2], b"\xff" * len(buffers[each][2]))
        elif len(expect) == 3 and expect[1] == "EQ_BUFFER":
            reference = buffers[expect[2]]
            if len(reference[2]) != len(buffers[name][2]):
                raise Skip("expected buffer of another size")
            checks[name] = (reference[2], b"\xff" * len(reference[2]))
        elif len(expect) >= 5 and expect[1] == "IDX" and "EQ" in expect:
            components, scalar, data = buffers[name]
            equal = expect.index("EQ")
            tolerance = expect[equal - 1] if expect[equal - 2] == "TOLERANCE" else None
            if tolerance is not None:
                if tolerance != ".0001" or SCALARS[scalar][2] is not float:
                    raise Skip("tolerance " + tolerance)
                tolerance_width = SCALARS[scalar][1]
            expected = pack(expect[equal + 1 :], scalar)
            offset = int(expect[2])
            entry = partial.setdefault(name, [bytearray(data), bytearray(len(data))])
            if offset + len(expected) > len(data):
                raise Skip("expectation outside of the buffer")
            entry[0][offset : offset + len(expected)] = expected
            entry[1][offset : offset + len(expected)] = b"\x01" * len(expected)
        else:
            raise Skip("expectation " + " ".join(expect[:3]))
    for name, (expected, covered) in partial.items():
        checks[name] = (bytes(expected), bytes(0xFF if flag else 0 for flag in covered))
    no_expectation = not expects
    if no_expectation:
        # The script only has to run: the last bound buffer stands in for an output of which no byte is compared.
        (last_binding, last_name) = sorted(bindings)[-1]
        checks[last_name] = (buffers[last_name][2], b"\x00" * len(buffers[last_name][2]))
    if len(push_buffer) > 1:
        raise Skip("several push constant buffers")
    push_constants = buffers[push_buffer[0]][2] if push_buffer else b""

    bound = sorted(bindings)
    if array_names:
        # The elements of the array are the first buffers, the others follow at binding 1 up; the manifest numbers them 0.. in that order.
        if [binding for binding, _ in bound] != list(range(1, 1 + len(bound))):
            raise Skip("bindings next to an array are not 1..n")
        bound = [(number, name) for number, name in enumerate(array_names + [name for _, name in bound])]
        features = features + [f"ARRAY:{len(array_names)}"]
    elif [binding for binding, _ in bound] != list(range(bound[0][0], bound[0][0] + len(bound))):
        raise Skip("bindings are not consecutive")
    outputs_started = False
    for _, name in bound:
        if name in checks:
            outputs_started = True
        elif outputs_started:
            raise Skip("an input bound after an output")
    if not any(name in checks for _, name in bound) or any(name not in {n for _, n in bound} for name in checks):
        raise Skip("expectation on an unbound buffer")

    if eq_outputs is not None:
        if len(checks) != 2 or set(checks) != set(eq_outputs):
            raise Skip("a buffer to buffer expectation next to others")
        features = features + ["EQ_OUTPUTS"]

    return dict(
        shader=shader,
        language=shader_language,
        target_env=target_env,
        features=features,
        dispatch=dispatch,
        buffers=";".join(f"{binding}:{buffers[name][2].hex()}" for binding, name in bound),
        checks=";".join(f"{binding}:{checks[name][0].hex()}:{checks[name][1].hex()}" for binding, name in bound if name in checks),
        tolerance_width=tolerance_width,
        push_constants=push_constants.hex(),
        spec_constants=";".join(spec_constants[index] for index in range(len(spec_constants))) if sorted(spec_constants) == list(range(len(spec_constants))) else None,
    )


def toml_string(text):
    return json.dumps(text, ensure_ascii=False)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cts-dir", default=str(CRATE.parent / "tmp" / "VK-GL-CTS"))
    args = parser.parse_args()

    out = [
        "# Shader manifest for the compute Amber scripts of dEQP-VK.spirv_assembly.instruction.compute.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_amber_manifest.py - do not hand-edit; see the script for the subset of Amber it reads.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmSignedOpTests.cpp"\n'
        'rust_module = "spirv_assembly/amber_tests"\n'
    ]
    written = 0
    scripts = []
    for group, directory in GROUPS.items():
        for path in sorted((Path(args.cts_dir) / AMBER_DIR / directory).glob("*.amber")):
            if group == "float32":
                # createFloat32ComparisonComputeSet: `<name>_<n>_comp.amber` is `comparison_<n>.<name>`; the other stages are graphics.
                match = re.fullmatch(r"(\w+?)_(\d)_comp", path.stem)
                if match:
                    scripts.append((group, path, [], f"float32/comparison_{match.group(2)}/{match.group(1)}", None))
            elif path.stem != "template":
                scripts.append((group, path, [], None, None))
    for directory, stem, name, requirements, env in EXPLICIT_SCRIPTS:
        scripts.append(("explicit", Path(args.cts_dir) / AMBER_DIR / directory / f"{stem}.amber", requirements, name, env))
    for sub_group, cases in SPIRV1P4_GROUPS.items():
        for basename, requirements in cases:
            scripts.append((f"spirv1p4/{sub_group}", Path(args.cts_dir) / AMBER_DIR / SPIRV1P4_DIR / sub_group / f"{basename}.amber", requirements, None, None))
    if True:
        for group, path, requirements, explicit_name, explicit_env in scripts:
            name = explicit_name or f"{group}/{path.stem if group in KEEP_DASHES else path.stem.replace('-', '_')}"
            try:
                case = convert(path)
            except Skip as reason:
                print(f"skipped {name}: {reason}", file=sys.stderr)
                continue
            if case["spec_constants"] is None:
                print(f"skipped {name}: specialization ids are not 0..n", file=sys.stderr)
                continue
            const = "AMBER_" + "".join(c if c.isalnum() else "_" for c in name).upper()
            spirv1p4 = group.startswith("spirv1p4/")
            extra = GROUP_EXTENSIONS.get(group, []) + (["VK_KHR_spirv_1_4"] if spirv1p4 else []) + requirements
            case["features"] = case["features"] + [feature for feature in dict.fromkeys(extra) if feature not in case["features"]]
            case["target_env"] = case["target_env"] or explicit_env or GROUP_TARGET_ENV.get(group) or ("spv1.4" if spirv1p4 else None)
            version = f', spirv_version = "spirv{case["target_env"].removeprefix("spv")}"' if case["target_env"] else ""
            if case["language"] == "GLSL":
                program = f'{{ name = "compute", template = "glsl/source.comp", stage = "comp"{version} }}'
                derived = f"source_comp = {json.dumps(repr(case['shader']), ensure_ascii=False)}"
            else:
                program = f'{{ name = "compute", template = "{TEMPLATE}", stage = "asm"{version} }}'
                derived = f"source = {json.dumps(repr(case['shader']), ensure_ascii=False)}"
            params = (
                f'dispatch_x = {{ type = "u32", value = {case["dispatch"][0]} }}, dispatch_y = {{ type = "u32", value = {case["dispatch"][1]} }}, '
                f'dispatch_z = {{ type = "u32", value = {case["dispatch"][2]} }}, buffers = {{ type = "str", value = {toml_string(case["buffers"])} }}, '
                f'checks = {{ type = "str", value = {toml_string(case["checks"])} }}, tolerance_width = {{ type = "u32", value = {case["tolerance_width"]} }}, '
                f'push_constants = {{ type = "str", value = {toml_string(case["push_constants"])} }}, spec_constants = {{ type = "str", value = {toml_string(case["spec_constants"])} }}, features = {{ type = "str", value = {toml_string(",".join(case["features"]))} }}'
            )
            out.append(
                f'\n[[case]]\nname = {toml_string(name)}\nrust_const = "{const}"\nrust_type = "AmberCase"\n'
                f"programs = [ {program} ]\n"
                f"params = {{ {params} }}\n"
                f"derived = {{ {derived} }}\n"
            )
            written += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {written} cases")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_constant_data.toml: dEQP-VK.spirv_assembly.constant_data.{basic,specialization.{count_only,data_only,count_and_data}}
(vktSpvAsmConstantDataTests.cpp, 1600 cases of VK_KHR_shader_constant_data, compute and fragment).

`initPrograms` writes one assembly module per case around the bytes of the constant data, which are a 26 letter pattern repeated to the length of the array and
padded with zero bytes to a whole number of words. Read as little endian words the pattern repeats every 13 of them, so the manifest does not spell the data
out: it carries the 13 words (`block`), how many whole words there are (`full`) and the last partial one (`tail`), and shaders/src/spirv_assembly/constant_data.asm
repeats the block when compile_shaders.py fills the template. What the host needs rides along as `spec`.

The cases whose declared array is `kMaxDataBytes` (262128 bytes) long are written with no program at all and run as stubs: each is 65532 words of assembly,
and together they would add a hundred megabytes of generated shaders. They are listed by name so that the case list is upstream's.

    python3 hodow_cts/scripts/gen_spirv_assembly_constant_data_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_constant_data.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmConstantDataTests.cpp"
K_MAX = 262128
ALIGNMENT = 4
BASE = "abcdefghijklmnopqrstuvwxyz"


def padding(byte_count):
    return (ALIGNMENT - byte_count % ALIGNMENT) % ALIGNMENT


def data_values(length, alt):
    base = BASE.upper() if alt else BASE
    return (base * (length // len(base) + 1))[:length]


def words_of(values):
    data = values.encode("ascii") + bytes(padding(len(values)))
    return [int.from_bytes(data[i : i + 4], "little") for i in range(0, len(data), 4)]


def hex_words(words):
    return " ".join(f"0x{word:08x}" for word in words)


def word_count(item_size, item_count):
    array_bytes = item_count * item_size
    return (array_bytes + padding(array_bytes)) // ALIGNMENT


def shader_parts(stage, size, item_count, specialize_count, specialize_data_decl, encode, specialize_data):
    bit_width = size * 8
    item_type = f"%int{bit_width}_t"
    is_comp = stage == "comp"
    ep_type = "GLCompute" if is_comp else "Fragment"
    exe_mode = "LocalSize 1 1 1" if is_comp else "OriginUpperLeft"

    words = words_of(data_values(item_count * size, specialize_data))
    full = len(words) if (item_count * size) % 4 == 0 else len(words) - 1
    block = hex_words(words_of(data_values(52, specialize_data))[:13]) if words else ""
    # The block is the first 13 words of the unpadded pattern, which is what every run of whole words repeats.
    if full:
        assert words[:full] == (words_of(data_values(52, specialize_data))[:13] * (full // 13 + 1))[:full]
    tail = (" " if full else "") + f"0x{words[-1]:08x}" if full != len(words) else ""

    head = (
        "               OpCapability Shader\n"
        "               OpCapability ConstantDataKHR\n"
        + ("OpCapability Int8\nOpCapability StorageBuffer8BitAccess\n" if size == 1 else "")
        + ("OpCapability Int16\nOpCapability StorageBuffer16BitAccess\n" if size == 2 else "")
        + ("OpCapability Int64\n" if size == 8 else "")
        + '               OpExtension "SPV_KHR_constant_data"\n'
        + ('OpExtension "SPV_KHR_8bit_storage"\n' if size == 1 else "")
        + ('OpExtension "SPV_KHR_16bit_storage"\n' if size == 2 else "")
        + '          %1 = OpExtInstImport "GLSL.std.450"\n'
        "               OpMemoryModel Logical GLSL450\n"
        f'               OpEntryPoint {ep_type} %main "main" %ssbo\n'
        f"               OpExecutionMode %main {exe_mode}\n"
        f"               OpDecorate %strided_array_type ArrayStride {size}\n"
        "               OpDecorate %SSBO_Block Block\n"
        "               OpMemberDecorate %SSBO_Block 0 Offset 0\n"
        "               OpDecorate %ssbo Binding 0\n"
        "               OpDecorate %ssbo DescriptorSet 0\n"
        + ("OpDecorate %data_array_type UTFEncodedKHR\n" if encode else "")
        + ("OpDecorate %item_count SpecId 0\n" if specialize_count else "")
        + ("OpDecorate %data SpecId 1\n" if specialize_data_decl else "")
        + "       %void = OpTypeVoid\n"
        "       %uint = OpTypeInt 32 0\n"
        f"{item_type} = OpTypeInt {bit_width} 1\n"
        "  %void_func = OpTypeFunction %void\n"
        f" %item_count = {'OpSpecConstant' if specialize_count else 'OpConstant'} %uint {item_count}\n"
        "     %uint_0 = OpConstant %uint 0\n"
        f"%data_array_type = OpTypeArray {item_type} %item_count\n"
        f"%strided_array_type = OpTypeArray {item_type} %item_count\n"
        f"       %data = {'OpSpecConstantDataKHR' if specialize_data_decl else 'OpConstantDataKHR'} %data_array_type "
    )
    rest = (
        "\n"
        "%SSBO_Block = OpTypeStruct %strided_array_type\n"
        "%ssbo_ptr_type = OpTypePointer StorageBuffer %SSBO_Block\n"
        "%ssbo_array_ptr_type = OpTypePointer StorageBuffer %strided_array_type\n"
        "       %ssbo = OpVariable %ssbo_ptr_type StorageBuffer\n"
        "       %main = OpFunction %void None %void_func\n"
        " %main_label = OpLabel\n"
        "%strided_data = OpCopyLogical %strided_array_type %data\n"
        "%ssbo_array_ptr = OpAccessChain %ssbo_array_ptr_type %ssbo %uint_0\n"
        "               OpStore %ssbo_array_ptr %strided_data\n"
        "               OpReturn\n"
        "               OpFunctionEnd\n"
    )
    return head, block, full, tail, rest


def main():
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.constant_data.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_constant_data_manifest.py - do not hand-edit; the cases with no program are the stubs of the 262128 byte arrays.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/constant_data_tests"\n'
    ]
    count = 0

    def emit(path, stage, size, item_count, specialized_count, specialize_data, encode, force_count, force_data):
        nonlocal count
        name = "/".join(path)
        const = "CD_" + "".join(c if c.isalnum() else "_" for c in name).upper()
        specialize_count = specialized_count is not None or force_count
        specialize_data_decl = specialize_data or force_data
        stub = item_count * size >= K_MAX
        spec = (
            f"stage={stage};size={size};count={item_count};actual={-1 if specialized_count is None else specialized_count};"
            f"data={int(specialize_data)};stub={int(stub)}"
        )
        if stub:
            programs = "[]"
            params = f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
        else:
            head, block, full, tail, rest = shader_parts(stage, size, item_count, specialize_count, specialize_data_decl, encode, specialize_data)
            programs = f'[ {{ name = "{stage}", template = "spirv_assembly/constant_data.asm", stage = "asm", spirv_version = "spirv1.5" }}'
            if stage == "frag":
                programs += ', { name = "vert", template = "spirv_assembly/constant_data.vert", stage = "vert" }'
            programs += " ]"
            params = (
                f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
                f"derived = {{ head = {json.dumps(repr(head))}, block = {json.dumps(repr(block))}, full = \"{full}\", tail = {json.dumps(repr(tail))}, rest = {json.dumps(repr(rest))} }}\n"
            )
        out.append(f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "ConstantDataCase"\nprograms = {programs}\n{params}')
        count += 1

    def sized(size, maybe_count):
        return K_MAX // size if maybe_count is None else maybe_count

    counts = (1, 2, 32, 33, 64, 65, 127, 128, 129, 130, None)
    for size in (4, 2, 8, 1):
        for maybe in counts:
            item_count = sized(size, maybe)
            for encode in (False, True):
                if encode and size != 1:
                    continue
                for force_count in (False, True):
                    for force_data in (False, True):
                        for stage in ("comp", "frag"):
                            name = (
                                f"width_{size}_count_{item_count}" + ("_encode_decoration" if encode else "") + ("_force_spec_count" if force_count else "")
                                + ("_force_spec_data" if force_data else "") + f"_{stage}"
                            )
                            emit(["constant_data", "basic", name], stage, size, item_count, None, False, encode, force_count, force_data)

    for size in (4, 2, 8, 1):
        for decl in (1, 2, 31, 32, 33, 63, 64, 65, 66):
            decl_words = word_count(size, decl)
            item_count = decl
            while True:
                data_words = word_count(size, item_count)
                if data_words == 0 or data_words != decl_words:
                    break
                for stage in ("comp", "frag"):
                    name = f"width_{size}_decl_{decl}_actual_{item_count}_{stage}"
                    emit(["constant_data", "specialization", "count_only", name], stage, size, decl, item_count, False, False, False, False)
                item_count -= 1

    for size in (4, 2, 8, 1):
        for maybe in counts:
            item_count = sized(size, maybe)
            for stage in ("comp", "frag"):
                emit(["constant_data", "specialization", "data_only", f"width_{size}_count_{item_count}_{stage}"], stage, size, item_count, None, True, False, False, False)

    for size in (4, 2, 8, 1):
        for maybe_decl in counts:
            for maybe_actual in counts:
                decl = sized(size, maybe_decl)
                actual = sized(size, maybe_actual)
                for stage in ("comp", "frag"):
                    emit(["constant_data", "specialization", "count_and_data", f"width_{size}_decl_{decl}_actual_{actual}_{stage}"], stage, size, decl, actual, True, False, False, False)

    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()

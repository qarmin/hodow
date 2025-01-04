#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_maint9_vectorization.toml: dEQP-VK.spirv_assembly.instruction.maint9_vectorization.{bit_count,bit_reverse,bit_field_insert,
bit_field_s_extract,bit_field_u_extract} (vktSpvAsmMaint9VectorizationTests.cpp, 3152 cases of VK_KHR_maintenance9 bitwise operations on 8, 16, 32 and 64 bit scalars and vec4).

`M9V_Case::initPrograms` writes one assembly module per operand list; the operand names, types and bit sizes are what changes. This replays it, and the nested loops of
`createMaint9VectorizationTests` for the case names. What the host needs - the operation and the (vector, signed, bits) of each operand - rides along as `spec`, which
src/vkt/tests/spirv_assembly/maint9_vectorization_tests.rs reads.

    python3 hodow_cts/scripts/gen_spirv_assembly_maint9_vectorization_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_maint9_vectorization.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmMaint9VectorizationTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"
PAD = " " * 34
OPS = {"count": "OpBitCount", "reverse": "OpBitReverse", "insert": "OpBitFieldInsert", "s_extract": "OpBitFieldSExtract", "u_extract": "OpBitFieldUExtract"}
OP_CODES = {"count": 0, "reverse": 1, "insert": 2, "s_extract": 3, "u_extract": 4}
WG_SIZE = 64


class Operand:
    def __init__(self, vector, signed, bits, name):
        self.vector, self.signed, self.bits, self.name = vector, signed, bits, name

    def prefix(self):
        return "%" + ("i" if self.signed else "u") + str(self.bits) + ("vec4" if self.vector else "scalar")

    def data_size(self):
        return self.bits // 8 * (4 if self.vector else 1)

    def alignment(self):
        return min(self.data_size(), 16)

    def test_name(self):
        return self.name + "_" + ("v" if self.vector else "s") + str(self.bits) + ("i" if self.signed else "u")


def assembly(op, operands):
    use = {bits: any(o.bits == bits for o in operands) for bits in (8, 16, 32, 64)}

    def iff(bits, text):
        return text if use[bits] else ""

    c = []
    c.append(PAD + "OpCapability Shader\n\n")
    c.append(iff(64, PAD + "OpCapability Int64\n") + "\n")
    c.append(iff(16, PAD + "OpCapability Int16\n") + iff(16, PAD + "OpCapability StorageBuffer16BitAccess\n") + "\n")
    c.append(iff(8, PAD + "OpCapability Int8\n") + iff(8, PAD + "OpCapability StorageBuffer8BitAccess\n") + "\n")
    c.append(PAD + "; Allows using buffer device addresses\n" + PAD + "OpCapability PhysicalStorageBufferAddresses\n\n")
    c.append(iff(16, PAD + 'OpExtension "SPV_KHR_16bit_storage"\n') + "\n")
    c.append(iff(8, PAD + 'OpExtension "SPV_KHR_8bit_storage"\n') + "\n")
    c.append(PAD + 'OpExtension "SPV_KHR_physical_storage_buffer"\n' + PAD + 'OpExtension "SPV_KHR_storage_buffer_storage_class"\n\n')
    c.append('                   %std450insts = OpExtInstImport "GLSL.std.450"\n')
    c.append(PAD + "OpMemoryModel PhysicalStorageBuffer64 GLSL450\n")
    c.append(PAD + 'OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references\n')
    c.append(PAD + f"OpExecutionMode %main LocalSize {WG_SIZE} 1 1\n")
    c.append(PAD + "OpSource GLSL 460\n")
    c.append(PAD + "OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex\n")
    c.append(PAD + "OpDecorate %ReferencesBlock Block\n\n")
    for i in range(len(operands)):
        c.append(PAD + f"OpMemberDecorate %ReferencesBlock {i} Offset {i * 8}\n")
    c.append("\n")

    def decor(kind, stride_of):
        for bits in (8, 16, 32, 64):
            for sign in ("u", "i"):
                name = f"%{sign}{bits}{kind}"
                stride = stride_of(bits)
                c.append(iff(bits, PAD + f"OpDecorate {name}_array ArrayStride {stride}\n"))
                c.append(iff(bits, PAD + f"OpDecorate {name}_array_struct Block\n"))
                c.append(iff(bits, PAD + f"OpMemberDecorate {name}_array_struct 0 Offset 0\n"))
            c.append("")

    # The upstream order: scalar u8, u16, ... groups of "u then i" per width for scalars, then per width for vectors.
    for bits in (8, 16, 32, 64):
        for sign in ("u", "i"):
            name = f"%{sign}{bits}scalar"
            c.append(iff(bits, PAD + f"OpDecorate {name}_array ArrayStride {bits // 8}\n"))
            c.append(iff(bits, PAD + f"OpDecorate {name}_array_struct Block\n"))
            c.append(iff(bits, PAD + f"OpMemberDecorate {name}_array_struct 0 Offset 0\n"))
        c.append("\n")
    for bits in (8, 16, 32, 64):
        for sign in ("u", "i"):
            name = f"%{sign}{bits}vec4"
            c.append(iff(bits, PAD + f"OpDecorate {name}_array ArrayStride {bits // 2}\n"))
            c.append(iff(bits, PAD + f"OpDecorate {name}_array_struct Block\n"))
            c.append(iff(bits, PAD + f"OpMemberDecorate {name}_array_struct 0 Offset 0\n"))
        c.append("\n")
    c.append(PAD + "OpDecorate %references Binding 0\n" + PAD + "OpDecorate %references DescriptorSet 0\n\n")
    c.append("                          %void = OpTypeVoid\n                     %void_func = OpTypeFunction %void\n\n")
    c.append(PAD + "; Scalar types\n")
    for bits in (8, 16):
        c.append(iff(bits, f"{'%u' + str(bits) + 'scalar':>24} = OpTypeInt {bits} 0\n"))
        c.append(iff(bits, f"{'%i' + str(bits) + 'scalar':>24} = OpTypeInt {bits} 1\n"))
    c.append(f"{'%u32scalar':>25} = OpTypeInt 32 0\n{'%i32scalar':>25} = OpTypeInt 32 1\n")
    c.append(iff(64, f"{'%u64scalar':>25} = OpTypeInt 64 0\n") + "\n")
    c.append(iff(64, f"{'%i64scalar':>25} = OpTypeInt 64 1\n") + "\n")
    c.append(PAD + "; Vector types\n")
    for sign in ("u", "i"):
        for bits in (8, 16, 32, 64):
            c.append(iff(bits, f"%{sign}{bits}vec4 = OpTypeVector %{sign}{bits}scalar 4\n"))
        c.append("\n")
    c.append(PAD + "; Scalar array types\n")
    for sign in ("u", "i"):
        for bits in (8, 16, 32, 64):
            c.append(iff(bits, f"%{sign}{bits}scalar_array = OpTypeRuntimeArray %{sign}{bits}scalar\n"))
        c.append("\n")
    c.append(PAD + "; Vector array types\n")
    for sign in ("u", "i"):
        for bits in (8, 16, 32, 64):
            c.append(iff(bits, f"%{sign}{bits}vec4_array = OpTypeRuntimeArray %{sign}{bits}vec4\n"))
        c.append("\n")
    c.append(PAD + "; Structures containing arrays of scalars\n")
    for sign in ("u", "i"):
        for bits in (8, 16, 32, 64):
            c.append(iff(bits, f"%{sign}{bits}scalar_array_struct = OpTypeStruct %{sign}{bits}scalar_array\n"))
        c.append("\n")
    c.append(PAD + "; Structures containing arrays of vectors\n")
    for sign in ("u", "i"):
        for bits in (8, 16, 32, 64):
            c.append(iff(bits, f"%{sign}{bits}vec4_array_struct = OpTypeStruct %{sign}{bits}vec4_array\n"))
        c.append("\n")
    c.append(PAD + "; Pointers to all those structures, as stored in the references buffer\n")
    for kind in ("scalar", "vec4"):
        for sign in ("u", "i"):
            for bits in (8, 16, 32, 64):
                c.append(iff(bits, PAD + f"OpTypeForwardPointer %{sign}{bits}{kind}_array_struct_ptr PhysicalStorageBuffer\n"))
    c.append("\n")
    for kind in ("scalar", "vec4"):
        for sign in ("u", "i"):
            for bits in (8, 16, 32, 64):
                c.append(iff(bits, f"%{sign}{bits}{kind}_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %{sign}{bits}{kind}_array_struct\n"))
    c.append("\n")
    c.append(PAD + "; Pointers to types in the physical storage buffers\n")
    c.append(PAD + "; These are used to load and store values from and to the physical storage buffers\n")
    for kind in ("scalar", "vec4"):
        for sign in ("u", "i"):
            for bits in (8, 16, 32, 64):
                c.append(iff(bits, f"%{sign}{bits}{kind}_ptr = OpTypePointer PhysicalStorageBuffer %{sign}{bits}{kind}\n"))
            c.append("\n")
    c.append(
        "            %u32scalar_func_ptr = OpTypePointer Function %u32scalar\n"
        "           %u32scalar_input_ptr = OpTypePointer Input %u32scalar\n"
        "            %i32scalar_func_ptr = OpTypePointer Function %i32scalar\n"
        "           %i32scalar_input_ptr = OpTypePointer Input %i32scalar\n\n"
        "       %gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input\n\n"
    )
    c.append("               %ReferencesBlock = OpTypeStruct" + "".join(" " + o.prefix() + "_array_struct_ptr" for o in operands))
    c.append("\n          %references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock\n")
    c.append("                    %references = OpVariable %references_block_ptr StorageBuffer\n\n")
    c.append(PAD + "; Pointers to the array struct pointers (i.e. the pointers in the storage buffer that point to the other buffers)\n")
    for kind in ("scalar", "vec4"):
        for sign in ("u", "i"):
            for bits in (8, 16, 32, 64):
                c.append(iff(bits, f"%{sign}{bits}{kind}_array_struct_ptr_ptr = OpTypePointer StorageBuffer %{sign}{bits}{kind}_array_struct_ptr\n"))
            c.append("\n")
    c.append(PAD + "; Integer constants\n")
    for i in range(len(operands)):
        c.append(f"%int_{i} = OpConstant %i32scalar {i}\n")
    c.append("\n%main = OpFunction %void None %void_func\n%main_label = OpLabel\n%idx = OpLoad %u32scalar %gl_LocalInvocationIndex\n\n")
    for i, o in enumerate(operands):
        p = o.prefix()
        c.append(
            f"%{o.name}_buffer_ref_ptr = OpAccessChain {p}_array_struct_ptr_ptr %references %int_{i}\n"
            f"%{o.name}_buffer_ptr = OpLoad {p}_array_struct_ptr %{o.name}_buffer_ref_ptr\n"
            f"                    %{o.name}_ptr = OpAccessChain {p}_ptr %{o.name}_buffer_ptr %int_0 %idx\n\n"
        )
    for o in operands[1:]:
        c.append(f"%{o.name} = OpLoad {o.prefix()} %{o.name}_ptr Aligned {o.alignment()}\n")
    c.append("\n")
    result = operands[0]
    arg_list = "".join(" %" + o.name for o in operands[1:])
    c.append(f"%{result.name} = {OPS[op]} {result.prefix()}{arg_list}\n" + PAD + f"OpStore %{result.name}_ptr %{result.name} Aligned {result.alignment()}\n")
    c.append("\n" + PAD + "OpReturn\n" + PAD + "OpFunctionEnd\n")
    # Upstream's indentation, blank lines and comments carry no information for the assembler; dropping them keeps the same binary at a third of the size.
    lines = [" ".join(line.split()) for line in "".join(c).split("\n")]
    return "\n".join(line for line in lines if line and not line.startswith(";")) + "\n"


def cases():
    bits4 = (8, 16, 32, 64)
    for vector in (False, True):
        for base in bits4:
            for result in bits4:
                for signed in (False, True):
                    yield "bit_count", "count", [Operand(vector, signed, result, "result"), Operand(vector, signed, base, "base")]
    for vector in (False, True):
        for base in bits4:
            for signed in (False, True):
                yield "bit_reverse", "reverse", [Operand(vector, signed, base, "result"), Operand(vector, signed, base, "base")]
    for group, op in (("bit_field_insert", "insert"), ("bit_field_s_extract", "s_extract"), ("bit_field_u_extract", "u_extract")):
        for vector in (False, True):
            for base in bits4:
                for offset in bits4:
                    for count in bits4:
                        for signed_base in (False, True):
                            for signed_offset in (False, True):
                                for signed_count in (False, True):
                                    operands = [Operand(vector, signed_base, base, "result"), Operand(vector, signed_base, base, "base")]
                                    if op == "insert":
                                        operands.append(Operand(vector, signed_base, base, "insert"))
                                    operands += [Operand(False, signed_offset, offset, "offset"), Operand(False, signed_count, count, "count")]
                                    yield group, op, operands


def main():
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.maint9_vectorization.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_maint9_vectorization_manifest.py - do not hand-edit; `spec` is the operation and the (vector, signed, bits) of its operands.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/maint9_vectorization_tests"\n'
    ]
    count = 0
    for group, op, operands in cases():
        name = group + "/" + "-".join(o.test_name() for o in operands)
        const = "M9V_" + "".join(ch if ch.isalnum() else "_" for ch in name).upper()
        spec = f"op={OP_CODES[op]};operands=" + ",".join(f"{int(o.vector)}.{int(o.signed)}.{o.bits}" for o in operands)
        out.append(
            f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "Maint9VectorizationCase"\n'
            f'programs = [ {{ name = "comp", template = "{TEMPLATE}", stage = "asm", spirv_version = "spirv1.6" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
            f"derived = {{ source = {json.dumps(repr(assembly(op, operands)))} }}\n"
        )
        count += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()

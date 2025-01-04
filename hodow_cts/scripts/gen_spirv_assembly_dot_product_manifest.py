#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_dot_product.toml: the compute groups of dEQP-VK.spirv_assembly.instruction.compute.{opsdotkhr,opudotkhr,
opsudotkhr,opsdotaccsatkhr,opudotaccsatkhr,opsudotaccsatkhr} (vktSpvAsmIntegerDotProductTests.cpp, 1428 cases plus the saturating ones, 1800 in all).

The assembly of a case does not depend on the data, so it is written here the way `generateIntegerDotProductCode` does. The data does: upstream draws
every case's operands from one `de::Random` per group, in the order the group function creates its cases, so a case can only be rebuilt by knowing
how many draws came before it. Every draw is one `getUint32`, which is what makes that a count: this replays the control flow of the group
functions without drawing anything and records the stream position of each case's operands (`skip`) and, for the saturating groups, of its addends
(`askip`). src/vkt/tests/spirv_assembly/dot_product_tests.rs draws from there, computes what the instruction must return and compares it.

    python3 hodow_cts/scripts/gen_spirv_assembly_dot_product_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from de_random import de_string_hash  # noqa: E402,F401

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_dot_product.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmIntegerDotProductTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"
NUM_ELEMENTS = 200

PACKING = [  # (packed, signedLHS, signedRHS)
    (False, False, False), (False, False, True), (False, True, False), (False, True, True),
    (True, True, True), (True, True, False), (True, False, True), (True, False, False),
]
VECTORS = {8: [(8, 2), (8, 3), (8, 4)], 16: [(16, 2), (16, 3), (16, 4)], 32: [(32, 2), (32, 3), (32, 4)]}


def preamble(capabilities, extensions):
    return (
        "OpCapability Shader\n" + capabilities + extensions + "OpMemoryModel Logical GLSL450\n" + 'OpEntryPoint GLCompute %main "main" %id \n' + "OpExecutionMode %main LocalSize 1 1 1\n"
    )


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


def type_decls_and_strides(packing, vector, out_size, signed_lhs_and_result, signed_rhs):
    packed, packing_signed_lhs, packing_signed_rhs = packing
    elem, length = vector
    signed_arrays = 0
    unsigned_arrays = 0
    signed_vector = False
    unsigned_vector = False

    if signed_lhs_and_result:
        signed_arrays |= out_size
    else:
        unsigned_arrays |= out_size

    if packed:
        if packing_signed_lhs or packing_signed_rhs:
            signed_arrays |= elem * length
        if not packing_signed_lhs or not packing_signed_rhs:
            unsigned_arrays |= elem * length
    else:
        if signed_lhs_and_result:
            signed_vector = True
            signed_arrays |= elem
        if not signed_rhs:
            unsigned_vector = True
            unsigned_arrays |= elem

    decls = ""
    strides = ""
    for size in (8, 16, 32, 64):
        if size != 32:
            if signed_arrays & size:
                decls += f"%i{size} = OpTypeInt {size} 1\n"
            if unsigned_arrays & size:
                decls += f"%u{size} = OpTypeInt {size} 0\n"

    for size in (8, 16, 32, 64):
        if signed_arrays & size:
            if size != 32:
                decls += f"%i{size}ptr = OpTypePointer Uniform %i{size}\n%i{size}arr = OpTypeRuntimeArray %i{size}\n"
            strides += f"OpDecorate %i{size}arr ArrayStride {size // 8}\n"
        if unsigned_arrays & size:
            decls += f"%u{size}ptr = OpTypePointer Uniform %u{size}\n%u{size}arr = OpTypeRuntimeArray %u{size}\n"
            strides += f"OpDecorate %u{size}arr ArrayStride {size // 8}\n"

    vector_stride = (4 if length == 3 else length) * (elem // 8)
    if signed_vector:
        vec_type = f"%i{elem}vec{length}"
        decls += f"{vec_type} = OpTypeVector %i{elem} {length}\n{vec_type}ptr = OpTypePointer Uniform {vec_type}\n{vec_type}arr = OpTypeRuntimeArray {vec_type}\n"
        strides += f"OpDecorate {vec_type}arr ArrayStride {vector_stride}\n"

    if unsigned_vector:
        vec_type = f"%u{elem}vec{length}"
        change_type_name = elem == 32 and length == 3
        if not change_type_name:
            decls += f"{vec_type} = OpTypeVector %u{elem} {length}\n"
        target = "%uvec3" if change_type_name else vec_type
        decls += f"{vec_type}ptr = OpTypePointer Uniform {target}\n{vec_type}arr = OpTypeRuntimeArray {target}\n"
        strides += f"OpDecorate {vec_type}arr ArrayStride {vector_stride}\n"

    return decls, strides


def dot_product_code(packing, vector, out_size, signed_lhs_and_result, signed_rhs, acc):
    assert signed_lhs_and_result or not signed_rhs
    packed, packing_signed_lhs, packing_signed_rhs = packing
    elem, length = vector

    insn_signedness = ("S" if signed_rhs else "SU") if signed_lhs_and_result else "U"
    insn_name = "Op" + insn_signedness + "Dot" + ("AccSat" if acc else "") + "KHR"

    output_capability = f"OpCapability Int{out_size}\n" if out_size != 32 else ""
    element_capability = f"OpCapability Int{elem}\n" if (not packed and out_size != elem and elem != 32) else ""

    using_4_wide_8_byte_vector = length == 4 and elem == 8
    if not using_4_wide_8_byte_vector:
        input_capability = "DotProductInputAllKHR"
    elif packed:
        input_capability = "DotProductInput4x8BitPackedKHR"
    else:
        input_capability = "DotProductInput4x8BitKHR"

    capabilities = output_capability + element_capability + "OpCapability " + input_capability + "\nOpCapability DotProductKHR\n"
    extensions = 'OpExtension "SPV_KHR_integer_dot_product"\n'

    out_type = ("i" if signed_lhs_and_result else "u") + str(out_size)
    type_decls, stride_decors = type_decls_and_strides(packing, vector, out_size, signed_lhs_and_result, signed_rhs)

    def vec_type(signed_operand, packed_signed, drop_elem_for_uvec3):
        if packed:
            return ("i" if packed_signed else "u") + str(elem * length)
        drop = drop_elem_for_uvec3 and not signed_operand and elem == 32 and length == 3
        return ("i" if signed_operand else "u") + ("" if drop else str(elem)) + "vec" + str(length)

    lhs_vec_type = vec_type(signed_lhs_and_result, packing_signed_lhs, True)
    rhs_vec_type = vec_type(signed_rhs, packing_signed_rhs, True)
    lhs_vec_type_base = vec_type(signed_lhs_and_result, packing_signed_lhs, False)
    rhs_vec_type_base = vec_type(signed_rhs, packing_signed_rhs, False)

    opt_format_param = " PackedVectorFormat4x8BitKHR" if packed else ""
    signedness_matches = (packing_signed_lhs == packing_signed_rhs) if packed else (signed_lhs_and_result == signed_rhs)

    text = preamble(capabilities, extensions)
    text += 'OpName %main           "main"\n'
    text += 'OpName %id             "gl_GlobalInvocationID"\n'
    text += "OpDecorate %id BuiltIn GlobalInvocationId\n"
    text += "OpDecorate %bufin BufferBlock\n" if signedness_matches else "OpDecorate %buflhs BufferBlock\nOpDecorate %bufrhs BufferBlock\n"
    text += "OpDecorate %bufout BufferBlock\n"
    text += "OpDecorate %indatalhs DescriptorSet 0\n"
    text += "OpDecorate %indatalhs Binding 0\n"
    text += "OpDecorate %indatarhs DescriptorSet 0\n"
    text += "OpDecorate %indatarhs Binding 1\n"
    if acc:
        text += "OpDecorate %indataacc DescriptorSet 0\nOpDecorate %indataacc Binding 2\n"
    text += "OpDecorate %outdata DescriptorSet 0\n"
    text += "OpDecorate %outdata Binding " + ("3" if acc else "2") + "\n" + stride_decors
    text += "OpMemberDecorate %bufin 0 Offset 0\n" if signedness_matches else "OpMemberDecorate %buflhs 0 Offset 0\nOpMemberDecorate %bufrhs 0 Offset 0\n"
    text += "OpMemberDecorate %bufout 0 Offset 0\n"
    text += COMMON_TYPES + type_decls

    if signedness_matches:
        text += f"%bufin     = OpTypeStruct %{lhs_vec_type_base}arr\n%bufinptr  = OpTypePointer Uniform %bufin\n"
    else:
        text += (
            f"%buflhs    = OpTypeStruct %{lhs_vec_type_base}arr\n%buflhsptr = OpTypePointer Uniform %buflhs\n"
            f"%bufrhs    = OpTypeStruct %{rhs_vec_type_base}arr\n%bufrhsptr = OpTypePointer Uniform %bufrhs\n"
        )
    text += f"%bufout    = OpTypeStruct %{out_type}arr\n%bufoutptr = OpTypePointer Uniform %bufout\n"
    text += "%indatalhs = OpVariable " + ("%bufinptr" if signedness_matches else "%buflhsptr") + " Uniform\n"
    text += "%indatarhs = OpVariable " + ("%bufinptr" if signedness_matches else "%bufrhsptr") + " Uniform\n"
    if acc:
        text += "%indataacc = OpVariable %bufoutptr Uniform\n"
    text += "%outdata   = OpVariable %bufoutptr Uniform\n"
    text += "%id        = OpVariable %uvec3ptr Input\n%zero      = OpConstant %i32 0\n"
    text += "%main      = OpFunction %void None %voidf\n%label     = OpLabel\n%idval     = OpLoad %uvec3 %id\n%x         = OpCompositeExtract %u32 %idval 0\n"
    text += f"%inloclhs  = OpAccessChain %{lhs_vec_type_base}ptr %indatalhs %zero %x\n"
    text += f"%invallhs  = OpLoad %{lhs_vec_type} %inloclhs\n"
    text += f"%inlocrhs  = OpAccessChain %{rhs_vec_type_base}ptr %indatarhs %zero %x\n"
    text += f"%invalrhs  = OpLoad %{rhs_vec_type} %inlocrhs\n"
    if acc:
        text += f"%inlocacc  = OpAccessChain %{out_type}ptr %indataacc %zero %x\n%invalacc  = OpLoad %{out_type} %inlocacc\n"
    text += f"%res       = {insn_name} %{out_type} %invallhs %invalrhs" + (" %invalacc" if acc else "") + opt_format_param + "\n"
    text += f"%outloc    = OpAccessChain %{out_type}ptr %outdata %zero %x\n"
    text += "             OpStore %outloc %res\n             OpReturn\n             OpFunctionEnd\n"
    return text


CASES = []


def type_range(bits, signed):
    return (-(1 << (bits - 1)), (1 << (bits - 1)) - 1) if signed else (0, (1 << bits) - 1)


class Group:
    def __init__(self, name, op, signed_lhs_and_result, signed_rhs, acc):
        self.name = name
        self.op = op
        self.signed_lhs_and_result = signed_lhs_and_result
        self.signed_rhs = signed_rhs
        self.acc = acc
        self.position = 0  # draws consumed from the group's de::Random so far

    def add(self, bits, case_name, lhs_range, rhs_range=None, use_max_addend=True):
        """One `addNbitOp...Tests` call: every vector of `bits`, every packing, every output size that fits."""
        rhs_range = rhs_range or lhs_range
        for vector in VECTORS[bits]:
            elem, length = vector
            aligned = 4 if length == 3 else length
            count = NUM_ELEMENTS * aligned
            skip = self.position
            self.position += 2 * count

            for packing in PACKING:
                packed, packing_signed_lhs, packing_signed_rhs = packing
                if packed and (elem != 8 or length != 4):
                    continue
                for out_size in (32, 16, 8):
                    if elem > out_size:
                        continue
                    askip = -1
                    if self.acc:
                        askip = self.position
                        self.position += NUM_ELEMENTS
                    test_name = (
                        case_name + ("_packed_" if packed else "_") + ("s" if packing_signed_lhs else "u") + ("s" if packing_signed_rhs else "u") + f"_v{length}i{elem}_out{out_size}"
                    )
                    spec = (
                        f"seed={self.name};op={self.op};bits={elem};ls={int(self.signed_lhs_and_result)};rs={int(self.signed_rhs)};len={length};out={out_size};"
                        f"lmin={lhs_range[0]};lmax={lhs_range[1]};rmin={rhs_range[0]};rmax={rhs_range[1]};skip={skip};askip={askip};maxadd={int(use_max_addend)};packed={int(packed)}"
                    )
                    assembly = dot_product_code(packing, vector, out_size, self.signed_lhs_and_result, self.signed_rhs, self.acc)
                    CASES.append((f"{self.name}/{test_name}", spec, assembly))


def sdot(group, bits, name, lo, hi):
    group.add(bits, name, (lo, hi))


def build():
    r = type_range
    g = Group("opsdotkhr", "sdot", True, True, False)
    g.add(8, "all", r(8, True))
    g.add(8, "small", (-20, 20))
    g.add(16, "all", r(16, True))
    g.add(32, "all", r(32, True))

    g = Group("opudotkhr", "udot", False, False, False)
    g.add(8, "all", r(8, False))
    g.add(8, "small", (0, 20))
    g.add(16, "all", r(16, False))
    g.add(32, "all", r(32, False))

    g = Group("opsudotkhr", "sudot", True, False, False)
    g.add(8, "all", r(8, True), r(8, False))
    g.add(8, "small", (-20, 20), (0, 20))
    g.add(16, "all", r(16, True), r(16, False))
    g.add(32, "all", r(32, True), r(32, False))

    g = Group("opsdotaccsatkhr", "sdotacc", True, True, True)
    g.add(8, "all", r(8, True))
    g.add(8, "limits", (12, 20))
    g.add(8, "limits-neg", (-20, -12), use_max_addend=False)
    g.add(8, "small", (-4, 4))
    g.add(8, "small-neg", (-4, 4), use_max_addend=False)
    g.add(16, "all", r(16, True))
    g.add(16, "limits", (-20, 20))
    g.add(16, "limits-neg", (-20, 20), use_max_addend=False)
    g.add(32, "all", r(32, True))
    g.add(32, "limits", r(8, True))
    g.add(32, "limits-neg", r(8, True), use_max_addend=False)

    g = Group("opudotaccsatkhr", "udotacc", False, False, True)
    g.add(8, "all", r(8, False))
    g.add(8, "limits", (12, 20))
    g.add(8, "small", (1, 8))
    g.add(8, "small-nosat", (1, 8), use_max_addend=False)
    g.add(16, "all", r(16, False))
    g.add(16, "limits", (12, 20))
    g.add(16, "nosat", (12, 20), use_max_addend=False)
    g.add(32, "all", r(32, False))
    g.add(32, "limits", (255 - 40, 255 - 20))
    g.add(32, "nosat", (255 - 40, 255 - 20), use_max_addend=False)

    g = Group("opsudotaccsatkhr", "sudotacc", True, False, True)
    g.add(8, "all", r(8, True), r(8, False))
    g.add(8, "limits", (12, 20), (12, 20))
    g.add(8, "limits-neg", (-20, -12), (12, 20), use_max_addend=False)
    g.add(8, "small", (-4, 4), (1, 8))
    g.add(8, "small-neg", (-4, 4), (1, 8), use_max_addend=False)
    g.add(16, "all", r(16, True), r(16, False))
    g.add(16, "limits", (-20, 20), (12, 20))
    g.add(16, "limits-neg", (-20, 20), (12, 20), use_max_addend=False)
    g.add(32, "all", r(32, True), r(32, False))
    g.add(32, "limits", r(8, True), r(8, False))
    g.add(32, "limits-neg", r(8, True), (255, 255), use_max_addend=False)


def toml_string(text):
    return json.dumps(text, ensure_ascii=False)


def main():
    build()
    out = [
        "# Shader manifest for the integer dot product compute groups of dEQP-VK.spirv_assembly.instruction.compute.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_dot_product_manifest.py - do not hand-edit; `spec` says where in the group's random stream a case's data is.\n\n"
        f'upstream_source = "{SOURCE}"\n'
        'rust_module = "spirv_assembly/dot_product_tests"\n'
    ]
    seen = set()
    for name, spec, assembly in CASES:
        assert name not in seen, name
        seen.add(name)
        const = "DOT_" + "".join(c if c.isalnum() else "_" for c in name).upper()
        out.append(
            f'\n[[case]]\nname = {toml_string(name)}\nrust_const = "{const}"\nrust_type = "DotProductCase"\n'
            f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = {toml_string(spec)} }} }}\n'
            f"derived = {{ source = {json.dumps(repr(assembly), ensure_ascii=False)} }}\n"
        )
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {len(CASES)} cases", file=sys.stderr)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_type.toml: the compute (`_comp`) cases of dEQP-VK.spirv_assembly.instruction.type.*

Replays `populateSingleVecSizeTests` of vktSpvAsmTypeTests.cpp for every vector size: the per type `de::Random` (seeded with deStringHash of the type name, so the stream
depends on the order of the createTests calls), `getDataset`, the element counts `combine` produces (needed for the `%c_u32_N` declarations) and the assembly
`createStageTests` composes for the compute template. The case `spec` carries what the Rust side needs to redo the data: vector size, type, operation key, widths,
the number of draws of the type's random stream that precede the case, and the element count (checked against Rust's own `combine`)."""
import json
import re
import sys
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_type.toml"
TEMPLATE = CRATE / "shaders" / "src" / "spirv_assembly" / "type_comp.asm"
CASES = CRATE / "src" / "vkt" / "tests" / "spirv_assembly" / "type_cases" / "cases.txt"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmTypeTests.cpp"

M32 = 0xFFFFFFFF

VEC_SIZES = [("scalar", 1, False), ("vec2", 2, True), ("vec3", 3, True), ("vec4", 4, True), ("vec8", 8, True), ("vec12", 12, True), ("vec1", 1, True)]

# name: (bits, signed, device feature, capability, OpTypeInt, switch cases)
TYPES = {
    "i8": (8, True, None, "Int8", "OpTypeInt 8 1", (-42, 73, 121)),
    "i16": (16, True, "shaderInt16", "Int16", "OpTypeInt 16 1", (-3221, 3210, 19597)),
    "i32": (32, True, None, None, "OpTypeInt 32 1", (-3221, 3210, 268438669)),
    "i64": (64, True, "shaderInt64", "Int64", "OpTypeInt 64 1", (3210, -268438669, 26843866939192872)),
    "u8": (8, False, None, "Int8", "OpTypeInt 8 0", (0, 73, 193)),
    "u16": (16, False, "shaderInt16", "Int16", "OpTypeInt 16 0", (0, 3210, 19597)),
    "u32": (32, False, None, None, "OpTypeInt 32 0", (0, 3210, 268438669)),
    "u64": (64, False, "shaderInt64", "Int64", "OpTypeInt 64 0", (3210, 268438669, 26843866939192872)),
}
TYPE_ORDER = ["i8", "i16", "i32", "i64", "u8", "u16", "u32", "u64"]

WIDTH_POSTFIX_SHIFT = ["_shift8", "_shift16", "_shift32", "_shift64"]
WIDTH_POSTFIX_FIELD = [f"_offset{o}_count{c}" for o in (8, 16, 32, 64) for c in (8, 16, 32, 64)]
SHIFT_WIDTHS = [(8, 0), (16, 0), (32, 0), (64, 0)]
FIELD_WIDTHS = [(o, c) for o in (8, 16, 32, 64) for c in (8, 16, 32, 64)]

# (sign, variant, name, key, spv op name or ext op, filter, range, ext)
OPLINES = []


def line(sign, variant, name, key, op, filt="none", rng="full", ext=None):
    OPLINES.append((sign, variant, name, key, op, filt, rng, ext))


def build_oplines(vec_idx, is_scalar):
    OPLINES.clear()
    line("I", "8136", "negate", "negate", "OpSNegate")
    line("I", "8136", "add", "add", "OpIAdd")
    line("I", "8136", "sub", "sub", "OpISub")
    line("I", "8136", "mul", "mul", "OpIMul")
    line("I", "8136", "div", "sdiv", "OpSDiv", "signed_div")
    line("U", "8136", "div", "udiv", "OpUDiv", "zero")
    line("I", "8136", "rem", "srem", "OpSRem", "negz")
    line("I", "8136", "mod", "smod", "OpSMod", "negz")
    line("U", "8136", "mod", "umod", "OpUMod", "zero")
    line("I", "8136", "abs", "abs", "SAbs", ext="GLSL.std.450")
    line("I", "8136", "sign", "sign", "SSign", ext="GLSL.std.450")
    line("I", "8136", "min", "min", "SMin", ext="GLSL.std.450")
    line("U", "8136", "min", "min", "UMin", ext="GLSL.std.450")
    line("I", "8136", "max", "max", "SMax", ext="GLSL.std.450")
    line("U", "8136", "max", "max", "UMax", ext="GLSL.std.450")
    line("I", "8136", "clamp", "clamp", "SClamp", "min_gt_max", ext="GLSL.std.450")
    line("U", "8136", "clamp", "clamp", "UClamp", "min_gt_max", ext="GLSL.std.450")
    line("I", "3", "find_lsb", "lsb", "FindILsb", ext="GLSL.std.450")
    line("I", "3", "find_msb", "msb", "FindSMsb", ext="GLSL.std.450")
    line("U", "3", "find_msb", "msb", "FindUMsb", ext="GLSL.std.450")
    line("I", "1", "mul_sdiv", "mul_div", None, "zero")
    line("U", "1", "mul_udiv", "mul_div", None, "zero")
    line("U", "W", "shift_right_logical", "lsr", "OpShiftRightLogical", rng="bit_width")
    line("I", "W", "shift_right_logical", "lsr", "OpShiftRightLogical", rng="bit_width")
    line("U", "W", "shift_right_arithmetic", "asr", "OpShiftRightArithmetic", rng="bit_width")
    line("I", "W", "shift_right_arithmetic", "asr", "OpShiftRightArithmetic", rng="bit_width")
    line("U", "W", "shift_left_logical", "lsl", "OpShiftLeftLogical", rng="bit_width")
    line("I", "W", "shift_left_logical", "lsl", "OpShiftLeftLogical", rng="bit_width")
    for sign in "UI":
        line(sign, "8136", "bitwise_or", "or", "OpBitwiseOr")
        line(sign, "8136", "bitwise_xor", "xor", "OpBitwiseXor")
        line(sign, "8136", "bitwise_and", "and", "OpBitwiseAnd")
        line(sign, "8136", "not", "not", "OpNot")
    for name, key, op in (
        ("iequal", "iequal", "OpIEqual"),
        ("inotequal", "inotequal", "OpINotEqual"),
        ("ugreaterthan", "ugreaterthan", "OpUGreaterThan"),
        ("sgreaterthan", "sgreaterthan", "OpSGreaterThan"),
        ("ugreaterthanequal", "ugreaterthanequal", "OpUGreaterThanEqual"),
        ("sgreaterthanequal", "sgreaterthanequal", "OpSGreaterThanEqual"),
        ("ulessthan", "ulessthan", "OpULessThan"),
        ("slessthan", "slessthan", "OpSLessThan"),
        ("ulessthanequal", "ulessthanequal", "OpULessThanEqual"),
        ("slessthanequal", "slessthanequal", "OpSLessThanEqual"),
    ):
        line("U", "8136N", name, key, op)
        line("I", "8136N", name, key, op)
    if vec_idx < 4:
        for name, key, op in (
            ("bit_field_insert", "bfi", "OpBitFieldInsert"),
            ("bit_field_s_extract", "bfse", "OpBitFieldSExtract"),
            ("bit_field_u_extract", "bfue", "OpBitFieldUExtract"),
        ):
            line("U", "WN", name, key, op, rng="bit_width_sum")
            line("I", "WN", name, key, op, rng="bit_width_sum")
    line("U", "8136N", "bit_reverse", "bitrev", "OpBitReverse")
    line("I", "8136N", "bit_reverse", "bitrev", "OpBitReverse")
    line("U", "8136N", "bit_count", "bitcnt", "OpBitCount")
    line("I", "8136N", "bit_count", "bitcnt", "OpBitCount")
    if is_scalar:
        line("U", "8136", "constant", "const", "OpConstant")
        line("I", "8136", "constant", "const", "OpConstant")
    else:
        line("U", "163264", "constant_composite", "const", "OpConstantComposite")
        line("I", "8136", "constant_composite", "const", "OpConstantComposite")
        line("U", "163264", "constant_null", "const", "OpConstantNull")
        line("I", "8136", "constant_null", "const", "OpConstantNull")
    line("U", "8136", "variable_initializer", "const", "OpVariable")
    line("I", "8136", "variable_initializer", "const", "OpVariable")
    if is_scalar:
        line("U", "8136", "spec_constant_initializer", "const", "OpSpecConstant")
        line("I", "8136", "spec_constant_initializer", "const", "OpSpecConstant")
    else:
        line("U", "163264", "spec_constant_composite_initializer", "const", "OpSpecConstantComposite")
        line("I", "8136", "spec_constant_composite_initializer", "const", "OpSpecConstantComposite")


CONST_OPS = {"OpConstant", "OpConstantComposite", "OpConstantNull", "OpVariable", "OpSpecConstant", "OpSpecConstantComposite"}
BOOL_OPS = {"OpIEqual", "OpINotEqual", "OpUGreaterThan", "OpSGreaterThan", "OpUGreaterThanEqual", "OpSGreaterThanEqual", "OpULessThan", "OpSLessThan", "OpULessThanEqual", "OpSLessThanEqual"}
BIT_MANIP_OPS = {"OpBitCount", "OpBitReverse", "OpBitFieldInsert", "OpBitFieldSExtract", "OpBitFieldUExtract"}
KEY_ARITY = {"negate": 1, "abs": 1, "sign": 1, "not": 1, "lsb": 1, "msb": 1, "bitrev": 1, "bitcnt": 1, "const": 1, "clamp": 3, "bfse": 3, "bfue": 3, "bfi": 4}


def arity(key):
    return KEY_ARITY.get(key, 2)


def de_string_hash(s):
    h = 5381
    for c in s.encode():
        h = ((h << 5) + h + c) & M32
    return h


class Rnd:
    def __init__(self, seed):
        self.x = ((-seed) & M32) ^ 123456789
        self.y = (362436069 * seed) & M32
        self.z = 521288629 ^ (seed >> 7)
        self.w = 88675123 ^ ((seed << 3) & M32)
        self.draws = 0

    def u32(self):
        self.draws += 1
        w = self.w
        t = (self.x ^ (self.x << 11)) & M32
        self.x, self.y, self.z = self.y, self.z, w
        self.w = ((w ^ (w >> 19)) ^ (t ^ (t >> 8))) & M32
        return self.w

    def u64(self):
        hi = self.u32()
        return (hi << 32) | self.u32()


def wrap(bits, signed, v):
    v &= (1 << bits) - 1
    if signed and v >> (bits - 1):
        v -= 1 << bits
    return v


def get_dataset(ty, rnd, n):
    bits, signed, _, _, _, cases = TYPES[ty]
    data = [0]
    if signed:
        if bits == 32:
            data += [-(1 << 31) + 1, (1 << 31) - 1]
        elif bits == 64:
            data += [wrap(64, True, 0xFFFF859A3BF78592), 0x7FFF859A3BF78592]
        else:
            data += [-(1 << (bits - 1)), (1 << (bits - 1)) - 1]
    else:
        data += [(1 << bits) - 1]
    data += list(cases)
    n -= len(data)
    for _ in range(n):
        raw = rnd.u64() if bits == 64 else rnd.u32() & ((1 << bits) - 1)
        data.append(wrap(bits, signed, raw))
    return data


def passes(filt, bits, signed, *a):
    if filt == "none":
        return True
    if filt == "zero":
        return a[1] != 0
    if filt == "negz":
        return not (a[0] < 0 or a[1] <= 0)
    if filt == "signed_div":
        return not (a[1] == 0 or (a[1] == -1 and a[0] == -(1 << (bits - 1))))
    if filt == "min_gt_max":
        return not (a[1] > a[2])
    raise AssertionError(filt)


def count_elements(ty, vec, filt, key, rng, data, rnd):
    """The number of vectors `combine` leaves (and the draws it makes from `rnd`)."""
    bits, signed = TYPES[ty][0], TYPES[ty][1]
    ds = len(data)
    n = arity(key)
    if n == 1:
        passed = ds
    elif n == 2:
        passed = sum(1 for a in data for b in data if passes(filt, bits, signed, a, b))
    elif n == 3:
        if rng == "bit_width_sum":
            ds2 = 4 * vec
            passed = ds * ds2 * ds2
            for _ in range(ds * ds2 * (ds2 // vec) * 2):
                rnd.u32()
        else:
            pairs = sum(1 for a in data for b in data if passes(filt, bits, signed, None, a, b))
            passed = ds * pairs
    else:
        ds2 = 2 * vec
        passed = ds * ds2 * ds2 * ds2
        for _ in range(ds * ds2 * ds2 * (ds2 // vec) * 2):
            rnd.u32()
    return passed // vec


def tostr(v):
    return str(v)


def spec_text(template, specs):
    return re.sub(r"\$\{(\w+)\}", lambda m: specs[m.group(1)], template)


def has_width(widths, w):
    return w in [x for x in widths if x]


def other_size_types(ty, vec_size_n, is_vector, widths):
    bits, signed = TYPES[ty][0], TYPES[ty][1]
    if not widths:
        return ""
    sign = "i" if signed else "u"
    bit = "1" if signed else "0"
    out = ""
    for w in (8, 16, 64):
        if has_width(widths, w) and bits != w:
            out += f"%{sign}{w} = OpTypeInt {w} {bit}\n"
            if vec_size_n == 12:
                out += f"%v{vec_size_n}{sign}{w} = OpTypeVectorIdEXT %{sign}{w} %vectorSizeConst\n"
            elif is_vector:
                out += f"%v{vec_size_n}{sign}{w} = OpTypeVector %{sign}{w} {vec_size_n}\n"
    return out


def capability_str(cap, widths, vec_size_n, is_vector):
    out = ""
    h8, h16, h64 = (has_width(widths, w) for w in (8, 16, 64))
    if cap:
        if h8 or cap == "Int8":
            out += "OpCapability Int8\n"
        if h16 or cap == "Int16":
            out += "OpCapability Int16\n"
        if h64 or cap == "Int64":
            out += "OpCapability Int64\n"
        if cap == "Int8":
            out += "OpCapability UniformAndStorageBuffer8BitAccess\n"
        if cap == "Int16":
            out += "OpCapability UniformAndStorageBuffer16BitAccess\n"
    else:
        if h8:
            out += "OpCapability Int8\n"
        if h16:
            out += "OpCapability Int16\n"
        if h64:
            out += "OpCapability Int64\n"
    if is_vector and (vec_size_n == 1 or vec_size_n > 4):
        out += "OpCapability LongVectorEXT\n"
    return out


def binary_width_operation(result, op, ty, test_type, vec_n, widths, is_vector):
    bits, signed = TYPES[ty][0], TYPES[ty][1]
    sign = "i" if signed else "u"
    w1 = widths[0]
    prefix = f"%v{vec_n}" if is_vector else "%"
    out = ""
    if w1 != bits:
        out += f"%input1_val_{w1} = OpSConvert {prefix}{sign}{w1} %input1_val\n"
    in1 = "%input1_val" + (f"_{w1}" if w1 != bits else "")
    out += f"{result} = {op} %{test_type} %input0_val {in1}\n"
    return out


def different_width_operation(result, op, ty, test_type, vec_n, widths, quaternary):
    bits, signed = TYPES[ty][0], TYPES[ty][1]
    sign = "i" if signed else "u"
    ow, cw = widths
    matching = ("scalartype" if bits != 32 else f"{sign}{bits}") if vec_n > 1 else "testtype"
    off_type = matching if ow == bits else f"{sign}{ow}"
    cnt_type = matching if cw == bits else f"{sign}{cw}"
    off_ndx, cnt_ndx = ("2", "3") if quaternary else ("1", "2")
    out = ""
    if ow != bits:
        out += f"%input{off_ndx}_val_{ow} = OpSConvert %{off_type} %input{off_ndx}_val\n"
    if cw != bits:
        out += f"%input{cnt_ndx}_val_{cw} = OpSConvert %{cnt_type} %input{cnt_ndx}_val\n"
    off_s = f"%input{off_ndx}_val" + (f"_{ow}" if ow != bits else "")
    cnt_s = f"%input{cnt_ndx}_val" + (f"_{cw}" if cw != bits else "")
    if quaternary:
        out += f"{result} = {op} %{test_type} %input0_val %input1_val {off_s} {cnt_s}\n"
    else:
        out += f"{result} = {op} %{test_type} %input0_val {off_s} {cnt_s}\n"
    return out


def constituent_index(ndx, vs):
    return (ndx // vs) // (1 + (ndx % vs))


COMPUTE_HEAD = """OpCapability Shader
${capability}${extension}OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %BP_main "main"
OpExecutionMode %BP_main LocalSize 1 1 1
${decoration}
"""

ASM_TYPES = """%void = OpTypeVoid
%bool = OpTypeBool
%i32 = OpTypeInt 32 1
%u32 = OpTypeInt 32 0
%f32 = OpTypeFloat 32
%v2i32 = OpTypeVector %i32 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%v3i32 = OpTypeVector %i32 3
%v3u32 = OpTypeVector %u32 3
%v3f32 = OpTypeVector %f32 3
%v4i32 = OpTypeVector %i32 4
%v4u32 = OpTypeVector %u32 4
%v4f32 = OpTypeVector %f32 4
%v4bool = OpTypeVector %bool 4
%v4f32_v4f32_function = OpTypeFunction %v4f32 %v4f32
%bool_function = OpTypeFunction %bool
%voidf = OpTypeFunction %void
%ip_f32 = OpTypePointer Input %f32
%ip_i32 = OpTypePointer Input %i32
%ip_u32 = OpTypePointer Input %u32
%ip_v2f32 = OpTypePointer Input %v2f32
%ip_v2i32 = OpTypePointer Input %v2i32
%ip_v2u32 = OpTypePointer Input %v2u32
%ip_v3f32 = OpTypePointer Input %v3f32
%ip_v4f32 = OpTypePointer Input %v4f32
%ip_v4i32 = OpTypePointer Input %v4i32
%ip_v4u32 = OpTypePointer Input %v4u32
%op_f32 = OpTypePointer Output %f32
%op_i32 = OpTypePointer Output %i32
%op_u32 = OpTypePointer Output %u32
%op_v2f32 = OpTypePointer Output %v2f32
%op_v2i32 = OpTypePointer Output %v2i32
%op_v2u32 = OpTypePointer Output %v2u32
%op_v4f32 = OpTypePointer Output %v4f32
%op_v4i32 = OpTypePointer Output %v4i32
%op_v4u32 = OpTypePointer Output %v4u32
%fp_f32   = OpTypePointer Function %f32
%fp_i32   = OpTypePointer Function %i32
%fp_v4f32 = OpTypePointer Function %v4f32
"""

ASM_CONSTANTS = """%c_f32_1 = OpConstant %f32 1.0
%c_f32_0 = OpConstant %f32 0.0
%c_f32_0_5 = OpConstant %f32 0.5
%c_f32_n1  = OpConstant %f32 -1.
%c_f32_7 = OpConstant %f32 7.0
%c_f32_8 = OpConstant %f32 8.0
%c_i32_0 = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%c_i32_3 = OpConstant %i32 3
%c_i32_4 = OpConstant %i32 4
%c_u32_0 = OpConstant %u32 0
%c_u32_1 = OpConstant %u32 1
%c_u32_2 = OpConstant %u32 2
%c_u32_3 = OpConstant %u32 3
%c_u32_32 = OpConstant %u32 32
%c_u32_4 = OpConstant %u32 4
%c_u32_31_bits = OpConstant %u32 0x7FFFFFFF
%c_v4f32_1_1_1_1 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_1 %c_f32_1 %c_f32_1
%c_v4f32_1_0_0_1 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_1
%c_v4f32_0_5_0_5_0_5_0_5 = OpConstantComposite %v4f32 %c_f32_0_5 %c_f32_0_5 %c_f32_0_5 %c_f32_0_5
"""

ASM_ARRAYS = """%a1f32 = OpTypeArray %f32 %c_u32_1
%a2f32 = OpTypeArray %f32 %c_u32_2
%a3v4f32 = OpTypeArray %v4f32 %c_u32_3
%a4f32 = OpTypeArray %f32 %c_u32_4
%a32v4f32 = OpTypeArray %v4f32 %c_u32_32
%ip_a3v4f32 = OpTypePointer Input %a3v4f32
%ip_a32v4f32 = OpTypePointer Input %a32v4f32
%op_a2f32 = OpTypePointer Output %a2f32
%op_a3v4f32 = OpTypePointer Output %a3v4f32
%op_a4f32 = OpTypePointer Output %a4f32
"""

COMPUTE_MAIN_PREFIX = "%BP_color = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_0 %c_f32_1\n"

COMPUTE_MAIN = """%BP_main = OpFunction %void None %voidf
%BP_label_main = OpLabel
%BP_in_color = OpVariable %fp_v4f32 Function
%BP_out_color = OpVariable %fp_v4f32 Function
OpStore %BP_in_color %BP_color
%BP_tmp1 = OpLoad %v4f32 %BP_in_color
%BP_tmp2 = OpFunctionCall %v4f32 %test_code %BP_tmp1
OpStore %BP_out_color %BP_tmp2
"""

COMPUTE_MAIN_END = """OpReturn
OpFunctionEnd
"""

COMPUTE_MAIN_SWITCH_END = """%BP_tmp3 = OpLoad %v4f32 %BP_in_color
%BP_tmp4 = OpLoad %v4f32 %BP_out_color
%BP_tmp5 = OpFOrdEqual %v4bool %BP_tmp3 %BP_tmp4
%BP_tmp6 = OpAll %bool %BP_tmp5
%BP_tmp7 = OpSelect %i32 %BP_tmp6 %c_i32_1 %c_i32_0
%BP_tmp8 = OpAccessChain %up_i32 %block %c_i32_0 %c_i32_0
OpStore %BP_tmp8 %BP_tmp7
OpReturn
OpFunctionEnd
"""

SWITCH_HEAD_DECOR = """OpDecorate %rta_i32 ArrayStride 4
OpMemberDecorate %BlockType 0 Offset 0
OpDecorate %BlockType BufferBlock
OpDecorate %block DescriptorSet 0
OpDecorate %block Binding 2
"""

SWITCH_BLOCK = """%rta_i32 = OpTypeRuntimeArray %i32
%BlockType = OpTypeStruct %rta_i32
%up_BlockType = OpTypePointer Uniform %BlockType
%block = OpVariable %up_BlockType Uniform
"""


class Case:
    pass


def make_spec(c):
    return (
        f"vec={c.vec};ty={c.ty};op={c.key};seed={c.seed};skip={c.skip};w1={c.widths[0] if c.widths else 0};w2={c.widths[1] if len(c.widths) > 1 else 0};"
        f"vg={int(c.is_vector)};hp={int(c.high)};rng={c.rng};filt={c.filt};n={c.num_elements};bool={int(c.spv_op in BOOL_OPS)};spv={c.spv_op or ''}"
    )


def type_test_type(ty, vec, is_vector):
    if ty in ("i32", "u32"):
        return f"v{vec}{ty}" if is_vector else ty
    return "testtype"


def compose(c):
    ty, vec, is_vector = c.ty, c.vec, c.is_vector
    bits, signed, feature, cap, spv_type, cases = TYPES[ty]
    op = c.spv_op
    widths = list(c.widths)
    test_type = type_test_type(ty, vec, is_vector)
    vec_s = str(vec)
    num = c.num_elements
    is_const = op in CONST_OPS
    n_in = 1 if is_const else arity(c.key)
    spirv_ext = c.ext
    ext_text = ""
    if ty in ("i8", "u8"):
        ext_text += 'OpExtension "SPV_KHR_8bit_storage"\n'
    if ty in ("i16", "u16"):
        ext_text += 'OpExtension "SPV_KHR_16bit_storage"\n'
    long_vec = is_vector and (vec == 1 or vec > 4)

    specs = {}
    specs["testtype"] = test_type
    specs["scalartype"] = spv_type
    specs["typesize"] = str((4 if vec == 3 else vec) * bits // 8)
    specs["vector_size"] = vec_s
    specs["num_elements"] = str(num)
    specs["output_binding"] = str(n_in)
    specs["shift_initializers"] = " %c_shift1" * vec
    specs["longvec"] = ""
    specs["vectortype"] = f"%testtype = OpTypeVector %scalartype {vec_s}"
    if long_vec:
        if vec == 12:
            specs["vectortype"] = "%testtype = OpTypeVectorIdEXT %scalartype %vectorSizeConst\n"
            specs["longvec"] = (
                f"%vectorSizeConst = OpConstant %u32 {vec_s}\n"
                f"%v{vec_s}i32 = OpTypeVectorIdEXT %i32 %vectorSizeConst\n"
                f"%v{vec_s}u32 = OpTypeVectorIdEXT %u32 %vectorSizeConst\n"
                f"%v{vec_s}f32 = OpTypeVectorIdEXT %f32 %vectorSizeConst\n"
                f"%v{vec_s}bool = OpTypeVectorIdEXT %bool %vectorSizeConst\n"
            )
        else:
            specs["longvec"] = (
                f"%v{vec_s}i32 = OpTypeVector %i32 {vec_s}\n%v{vec_s}u32 = OpTypeVector %u32 {vec_s}\n%v{vec_s}f32 = OpTypeVector %f32 {vec_s}\n"
            )
        ext_text += 'OpExtension "SPV_EXT_long_vector"\n'
    specs["bvec"] = "" if (not is_vector or vec == 4 or vec == 12) else f"%v{vec_s}bool = OpTypeVector %bool {vec_s}"
    if not is_vector:
        specs["constant_zero"] = "%c_zero = OpConstant %u32 0\n"
        specs["constant_one"] = "%c_one = OpConstant %u32 1\n"
    else:
        specs["constant_zero"] = f"%c_zero = OpConstantComposite %v{vec_s}u32" + " %c_u32_0" * vec
        specs["constant_one"] = f"%c_one = OpConstantComposite %v{vec_s}u32" + " %c_u32_1" * vec
    specs["other_size_types"] = other_size_types(ty, vec, is_vector, widths)
    specs["u32_function_pointer"] = "" if test_type == "i32" else f"%fp_{test_type} = OpTypePointer Function %{test_type}\n"
    is32 = bits == 32
    name32 = ("i32" if signed else "u32") if is32 else ""
    has_scalar_inputs = c.key in ("bfi", "bfse", "bfue")
    specs["scalar_type_name"] = (name32 if is32 else ("scalartype" if is_vector else "testtype")) if has_scalar_inputs else "u32"

    decorations = []
    pre_mains = []
    testfuns = []
    fun_variables = ""
    operation = ""
    result = "%op_result_pre" if (c.high or op in BOOL_OPS) else "%op_result"

    def is_scalar_input(n):
        if c.key == "bfi":
            return n > 1
        if c.key in ("bfse", "bfue"):
            return n > 0
        return False

    def input_decoration(n):
        return f"OpDecorate %input{n} DescriptorSet 0\nOpDecorate %input{n} Binding {n}\n"

    def input_pre_main(n):
        scalar_input = vec != 1 and is_scalar_input(n)
        return f"%input{n} = OpVariable {'%scalarbufptr' if scalar_input else '%bufptr'} Uniform\n"

    def input_testfun(n):
        scalar_input = vec != 1 and is_scalar_input(n)
        ptr = "%up_scalartype" if scalar_input else "%up_testtype"
        sc_name = name32 if is32 else ("testtype" if vec == 1 else "scalartype")
        val = f"%{sc_name}" if scalar_input else f"%{test_type}"
        return f"%input{n}_loc = OpAccessChain {ptr} %input{n} %c_i32_0 %counter_val\n%input{n}_val = OpLoad {val} %input{n}_loc\n"

    if is_const:
        dataset = c.const_input
        pre_mains.append(create_constant_declaration(c, dataset, test_type))
        is_variable = op == "OpVariable"
        fun_variables = ""
        if is_variable:
            for i in range(len(dataset)):
                fun_variables += f"%testvariable_{i} = OpVariable %fp_{test_type} Function %c_testtype_{i}\n"
        operation = "OpBranch %switchStart\n%switchStart = OpLabel\nOpSelectionMerge %switchEnd None\nOpSwitch %counter_val %caseDefault"
        for i in range(len(dataset)):
            operation += f" {i} %case{i}"
        operation += "\n"
        for i in range(len(dataset)):
            if is_variable:
                operation += f"%case{i} = OpLabel\n%temp_{i} = OpLoad %{test_type} %testvariable_{i}\nOpStore %op_constant %temp_{i}\nOpBranch %switchEnd\n"
            else:
                operation += f"%case{i} = OpLabel\nOpStore %op_constant %c_testtype_{i}\nOpBranch %switchEnd\n"
        operation += f"%caseDefault = OpLabel\nOpBranch %switchEnd\n%switchEnd = OpLabel\n{result} = OpLoad %{test_type} %op_constant\n"
    else:
        for n in range(n_in):
            decorations.append(input_decoration(n))
            pre_mains.append(input_pre_main(n))
            testfuns.append(input_testfun(n))
        is_bool = op in BOOL_OPS
        result_type = (f"v{vec}bool" if is_vector else "bool") if is_bool else test_type
        if n_in == 1:
            if spirv_ext:
                operation = f"{result} = OpExtInst %{test_type} %ext1 {op} %input0_val\n"
            else:
                operation = f"{result} = {op} %{test_type} %input0_val\n"
        elif n_in == 2:
            if op is not None:
                if not widths:
                    if spirv_ext:
                        operation = f"{result} = OpExtInst %{result_type} %ext1 {op} %input0_val %input1_val\n"
                    else:
                        operation = f"{result} = {op} %{result_type} %input0_val %input1_val\n"
                else:
                    operation = binary_width_operation(result, op, ty, test_type, vec, widths, is_vector)
            else:
                conv = "OpSDiv" if c.base_name.startswith("mul_sdiv") else "OpUDiv"
                operation = f"%op_result2 = OpIMul %{test_type} %input0_val %input1_val\n{result} = {conv} %{test_type} %op_result2 %input1_val\n"
        elif n_in == 3:
            if not widths:
                if spirv_ext:
                    operation = f"{result} = OpExtInst %{test_type} %ext1 {op} %input0_val %input1_val %input2_val\n"
                else:
                    operation = f"{result} = {op} %{test_type} %input0_val %input1_val %input2_val\n"
            else:
                operation = different_width_operation(result, op, ty, test_type, vec, widths, False)
        else:
            if not widths:
                operation = f"{result} = {op} %{test_type} %input0_val %input1_val %input2_val %input3_val\n"
            else:
                operation = different_width_operation(result, op, ty, test_type, vec, widths, True)
    operation = finalize_full_operation(c, operation, result, test_type, op in BOOL_OPS)

    # createStageTests
    decoration_tpl = (
        "OpDecorate %output DescriptorSet 0\nOpDecorate %output Binding ${output_binding}\nOpDecorate %a${num_elements}testtype ArrayStride ${typesize}\n"
        "OpDecorate %buf BufferBlock\nOpMemberDecorate %buf 0 Offset 0\n"
    )
    vec_decoration_tpl = "OpDecorate %a${num_elements}scalartype ArrayStride ${typesize}\nOpDecorate %scalarbuf BufferBlock\nOpMemberDecorate %scalarbuf 0 Offset 0\n"
    pre_pre_main = "%c_u32_${num_elements} = OpConstant %u32 ${num_elements}\n%c_i32_${num_elements} = OpConstant %i32 ${num_elements}\n"
    scalar_pre_main = "%testtype = ${scalartype}\n"
    vector_pre_main = "%scalartype = ${scalartype}\n${vectortype}\n"
    pre_main_consts = "%c_shift  = OpConstant %u32 16\n${constant_zero}\n${constant_one}\n"
    pre_main_constv = (
        "%c_shift1 = OpConstant %u32 16\n%c_shift  = OpConstantComposite %v${vector_size}u32 ${shift_initializers}\n${bvec}\n${constant_zero}\n${constant_one}\n"
        "%a${num_elements}scalartype = OpTypeArray %${scalar_type_name} %c_u32_${num_elements}\n%up_scalartype = OpTypePointer Uniform %${scalar_type_name}\n"
        "%scalarbuf = OpTypeStruct %a${num_elements}scalartype\n%scalarbufptr = OpTypePointer Uniform %scalarbuf\n"
    )
    post_pre_main = (
        "%a${num_elements}testtype = OpTypeArray %${testtype} %c_u32_${num_elements}\n%up_testtype = OpTypePointer Uniform %${testtype}\n"
        "%buf = OpTypeStruct %a${num_elements}testtype\n%bufptr = OpTypePointer Uniform %buf\n%output = OpVariable %bufptr Uniform\n"
        "${other_size_types}\n${u32_function_pointer}\n"
    )
    pre_testfun = (
        "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n%param = OpFunctionParameter %v4f32\n%entry = OpLabel\n"
        "%op_constant = OpVariable %fp_${testtype} Function\n" + fun_variables + "%counter = OpVariable %fp_i32 Function\nOpStore %counter %c_i32_0\nOpBranch %loop\n"
        "%loop = OpLabel\n%counter_val = OpLoad %i32 %counter\n%lt = OpSLessThan %bool %counter_val %c_i32_${num_elements}\nOpLoopMerge %exit %inc None\n"
        "OpBranchConditional %lt %write %exit\n%write = OpLabel\n%output_loc = OpAccessChain %up_testtype %output %c_i32_0 %counter_val\n"
    )
    post_testfun = (
        "OpStore %output_loc %op_result\nOpBranch %inc\n%inc = OpLabel\n%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1\n"
        "OpStore %counter %counter_val_next\nOpBranch %loop\n%exit = OpLabel\nOpReturnValue %param\nOpFunctionEnd\n"
    )

    if spirv_ext:
        ext_text += f'%ext1 = OpExtInstImport "{spirv_ext}"'
    decoration = "".join(decorations) + spec_text(decoration_tpl, specs)
    if is_vector:
        decoration += spec_text(vec_decoration_tpl, specs)
    pre_main = spec_text(pre_pre_main, specs) + spec_text("${longvec}\n", specs)
    if test_type == "testtype":
        pre_main += spec_text(vector_pre_main if is_vector else scalar_pre_main, specs)
    pre_main += spec_text(pre_main_constv if is_vector else pre_main_consts, specs)
    pre_main += spec_text(post_pre_main, specs)
    pre_main += "".join(pre_mains)
    testfun = spec_text(pre_testfun, specs) + "".join(testfuns) + operation + spec_text(post_testfun, specs)
    capability = capability_str(cap, widths, vec, is_vector)

    c.frags = {"capability": capability, "extension": ext_text, "decoration": decoration, "pre_main": pre_main, "testfun": testfun}
    text = "OpCapability Shader\n" + capability + ext_text + "\n"
    text += 'OpMemoryModel Logical GLSL450\nOpEntryPoint GLCompute %BP_main "main"\nOpExecutionMode %BP_main LocalSize 1 1 1\n'
    text += decoration + ASM_TYPES + ASM_CONSTANTS + ASM_ARRAYS + COMPUTE_MAIN_PREFIX + pre_main + COMPUTE_MAIN + COMPUTE_MAIN_END + "\n" + testfun
    return text


def finalize_full_operation(c, operation, result, test_type, is_bool):
    ty, vec, is_vector = c.ty, c.vec, c.is_vector
    bits, signed = TYPES[ty][0], TYPES[ty][1]
    if c.high:
        convert_op = "OpSConvert" if signed else "OpUConvert"
        convert_type = (f"v{vec}" if is_vector else "") + "u32"
        operation += f"%op_result_a = OpUConvert %{convert_type} {result}\n"
        operation += f"%op_result_b = OpShiftRightLogical %{convert_type} %op_result_a %c_shift\n"
        operation += f"%op_result   = {convert_op} %{test_type} %op_result_b\n"
    elif is_bool:
        select_type = f"v{vec}u32" if is_vector else "u32"
        if ty == "u32":
            operation += f"%op_result     = OpSelect %{select_type} %op_result_pre %c_one %c_zero\n"
        else:
            operation += f"%op_result_u32 = OpSelect %{select_type} %op_result_pre %c_one %c_zero\n"
            if bits == 32:
                operation += f"%op_result     = OpBitcast %{test_type} %op_result_u32\n"
            else:
                operation += f"%op_result     = OpSConvert %{test_type} %op_result_u32\n"
    return operation


def create_constant_declaration(c, dataset, test_type):
    op = c.spv_op
    vec, is_vector = c.vec, c.is_vector
    is_variable = op == "OpVariable"
    is_null = op == "OpConstantNull" or is_variable
    is_comp = op == "OpConstantComposite" or (is_null and is_vector)
    is_const = op == "OpConstant" or is_comp or is_null
    is_spec = op == "OpSpecConstant"
    is_spec_comp = op == "OpSpecConstantComposite"
    test_scalar = "i32" if c.ty == "i32" else ("u32" if c.ty == "u32" else "scalartype")
    const_type = test_scalar if is_vector else test_type
    const_name = "%c_constituent_" if is_vector else "%c_testtype_"
    out = ""
    if is_spec:
        for i, v in enumerate(dataset):
            out += f"{const_name}{i} = OpSpecConstant %{const_type} {tostr(v)}\n"
    if is_spec_comp:
        for i, v in enumerate(dataset):
            if i == 0:
                out += f"{const_name}{i} = OpConstantNull %{const_type}\n"
            else:
                out += f"{const_name}{i} = {['OpConstant', 'OpSpecConstant'][i % 2]} %{const_type} {tostr(v)}\n"
        for i in range(len(dataset)):
            out += f"%c_testtype_{i} = OpSpecConstantComposite %{test_type}"
            for k in range(vec):
                out += f" %c_constituent_{constituent_index(i * vec + k, vec)}"
            out += "\n"
    if is_const or is_variable:
        for i, v in enumerate(dataset):
            if is_null and i == 0:
                out += f"{const_name}{i} = OpConstantNull %{const_type}\n"
            else:
                out += f"{const_name}{i} = OpConstant %{const_type} {tostr(v)}\n"
    if is_comp:
        for i in range(len(dataset)):
            if is_null and i == 0:
                out += f"%c_testtype_{i} = OpConstantNull %{test_type}"
            else:
                out += f"%c_testtype_{i} = OpConstantComposite %{test_type}"
                for k in range(vec):
                    out += f" %c_constituent_{constituent_index(i * vec + k, vec)}"
            out += "\n"
    return out


def compose_switch(c):
    ty = c.ty
    bits, signed, feature, cap, spv_type, cases = TYPES[ty]
    test_type = type_test_type(ty, 1, False)
    specs = {
        "testtype": test_type,
        "scalartype": spv_type,
        "typesize": str(bits // 8),
        "num_elements": str(c.num_elements),
        "case0": str(cases[0]),
        "case1": str(cases[1]),
        "case2": str(cases[2]),
    }
    decoration = (
        "OpDecorate %input DescriptorSet 0\nOpDecorate %input Binding 0\nOpDecorate %input NonWritable\nOpDecorate %expectedOutput DescriptorSet 0\n"
        "OpDecorate %expectedOutput Binding 1\nOpDecorate %expectedOutput NonWritable\nOpDecorate %a${num_elements}testtype ArrayStride ${typesize}\n"
        "OpDecorate %buf BufferBlock\nOpMemberDecorate %buf 0 Offset 0\n"
    )
    pre_pre_main = "%fp_bool = OpTypePointer Function %bool\n%c_u32_${num_elements} = OpConstant %u32 ${num_elements}\n%c_i32_${num_elements} = OpConstant %i32 ${num_elements}\n"
    post_pre_main = (
        "%c_casedefault = OpConstant %${testtype} 10\n%c_case0 = OpConstant %${testtype} 100\n%c_case1 = OpConstant %${testtype} 110\n%c_case2 = OpConstant %${testtype} 120\n"
        "%fail_color = OpConstantComposite %v4f32 %c_f32_0_5 %c_f32_0_5 %c_f32_0_5 %c_f32_1\n"
        "%a${num_elements}testtype = OpTypeArray %${testtype} %c_u32_${num_elements}\n%up_testtype = OpTypePointer Uniform %${testtype}\n"
        "%buf = OpTypeStruct %a${num_elements}testtype\n%bufptr = OpTypePointer Uniform %buf\n%input = OpVariable %bufptr Uniform\n%expectedOutput = OpVariable %bufptr Uniform\n"
    )
    testfun = (
        "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n%param = OpFunctionParameter %v4f32\n%entry = OpLabel\n"
        "%counter = OpVariable %fp_i32 Function\n%return = OpVariable %fp_v4f32 Function\n%works = OpVariable %fp_bool Function\n"
        "OpStore %counter %c_i32_0\nOpStore %return %param\nOpBranch %loop\n"
        "%loop = OpLabel\n%counter_val = OpLoad %i32 %counter\n%lt = OpSLessThan %bool %counter_val %c_i32_${num_elements}\nOpLoopMerge %loop_exit %inc None\n"
        "OpBranchConditional %lt %load %loop_exit\n"
        "%load = OpLabel\n%input_loc = OpAccessChain %up_testtype %input %c_i32_0 %counter_val\n%input_val = OpLoad %${testtype} %input_loc\n"
        "%expectedOutput_loc = OpAccessChain %up_testtype %expectedOutput %c_i32_0 %counter_val\n%expectedOutput_val = OpLoad %${testtype} %expectedOutput_loc\n"
        "OpSelectionMerge %switch_exit None\nOpSwitch %input_val %default ${case0} %case0 ${case1} %case1 ${case2} %case2\n"
        "%default = OpLabel\n%is_default = OpIEqual %bool %expectedOutput_val %c_casedefault\nOpBranch %switch_exit\n"
        "%case0 = OpLabel\n%is_case0 = OpIEqual %bool %expectedOutput_val %c_case0\nOpBranch %switch_exit\n"
        "%case1 = OpLabel\n%is_case1 = OpIEqual %bool %expectedOutput_val %c_case1\nOpBranch %switch_exit\n"
        "%case2 = OpLabel\n%is_case2 = OpIEqual %bool %expectedOutput_val %c_case2\nOpBranch %switch_exit\n"
        "%switch_exit = OpLabel\n%case_result = OpPhi %bool %is_default %default %is_case0 %case0 %is_case1 %case1 %is_case2 %case2\n"
        "OpSelectionMerge %result_end None\nOpBranchConditional %case_result %result_correct %result_incorrect\n"
        "%result_correct = OpLabel\nOpBranch %result_end\n"
        "%result_incorrect = OpLabel\n%counter_val_end = OpIAdd %i32 %counter_val %c_i32_${num_elements}\nOpStore %counter %counter_val_end\n"
        "OpStore %return %fail_color\nOpBranch %result_end\n"
        "%result_end = OpLabel\nOpBranch %inc\n"
        "%inc = OpLabel\n%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1\nOpStore %counter %counter_val_next\nOpBranch %loop\n"
        "%loop_exit = OpLabel\n%return_val = OpLoad %v4f32 %return\nOpReturnValue %return_val\nOpFunctionEnd\n"
    )
    ext_text = ""
    if ty in ("i8", "u8"):
        ext_text += 'OpExtension "SPV_KHR_8bit_storage"\n'
    if ty in ("i16", "u16"):
        ext_text += 'OpExtension "SPV_KHR_16bit_storage"\n'
    pre_main = spec_text(pre_pre_main, specs)
    if test_type == "testtype":
        pre_main += spec_text("%testtype = ${scalartype}\n", specs)
    pre_main += spec_text(post_pre_main, specs)
    c.frags = {
        "capability": capability_str(cap, [], 1, False),
        "extension": ext_text,
        "decoration": spec_text(decoration, specs),
        "pre_main": pre_main,
        "testfun": spec_text(testfun, specs),
    }
    text = "OpCapability Shader\n" + capability_str(cap, [], 1, False) + ext_text + "\n"
    text += 'OpMemoryModel Logical GLSL450\nOpEntryPoint GLCompute %BP_main "main"\nOpExecutionMode %BP_main LocalSize 1 1 1\n'
    text += SWITCH_HEAD_DECOR + spec_text(decoration, specs) + ASM_TYPES + ASM_CONSTANTS + ASM_ARRAYS + SWITCH_BLOCK + COMPUTE_MAIN_PREFIX + pre_main
    text += "%up_i32 = OpTypePointer Uniform %i32\n" + COMPUTE_MAIN + COMPUTE_MAIN_SWITCH_END + "\n" + spec_text(testfun, specs)
    return text


def types_for(variant, sign):
    allw = {"I": ["i8", "i16", "i32", "i64"], "U": ["u8", "u16", "u32", "u64"]}[sign]
    if variant in ("8136", "8136N", "W", "WN"):
        return allw
    if variant == "1":
        return [allw[1]]
    if variant == "3":
        return [allw[2]]
    if variant == "163264":
        return allw[1:]
    raise AssertionError(variant)


def build_cases():
    cases = []
    for vec_idx, (group, vec, is_vector) in enumerate(VEC_SIZES):
        build_oplines(vec_idx, not is_vector)
        rnds = {ty: Rnd(de_string_hash(ty)) for ty in TYPE_ORDER}
        for ty in TYPE_ORDER:
            pass
        for sign, variant, name, key, op, filt, rng, ext in OPLINES:
            for ty in types_for(variant, sign):
                variants = []
                if variant == "W":
                    variants = [(name + WIDTH_POSTFIX_SHIFT[i], (SHIFT_WIDTHS[i][0],)) for i in range(4)]
                elif variant == "WN":
                    variants = [(name + WIDTH_POSTFIX_FIELD[i], FIELD_WIDTHS[i]) for i in range(16)]
                else:
                    variants = [(name, ())]
                for base, widths in variants:
                    highs = [False]
                    if ty in ("i16", "u16") and variant in ("8136", "W", "1", "163264"):
                        highs = [False, True]
                    for high in highs:
                        add_case(cases, group, vec, is_vector, ty, rnds[ty], base + ("_test_high_part_zero" if high else ""), base, key, op, filt, rng, ext, widths, high)
        if not is_vector:
            for ty in TYPE_ORDER:
                add_switch(cases, group, ty, rnds[ty])
    return cases


def add_case(cases, group, vec, is_vector, ty, rnd, name, base, key, op, filt, rng, ext, widths, high):
    c = Case()
    c.group, c.vec, c.is_vector, c.ty = group, vec, is_vector, ty
    c.name, c.base_name, c.key, c.spv_op, c.filt, c.rng, c.ext, c.widths, c.high = name, base, key, op, filt, rng, ext, widths, high
    c.seed = de_string_hash(ty)
    c.skip = rnd.draws
    ds_size = 10 * vec if vec <= 4 else 60
    if op in CONST_OPS:
        c.const_input = get_dataset(ty, rnd, 10)
        out_len = 10 if (op in ("OpConstant", "OpSpecConstant")) else 10 * vec
        c.num_elements = out_len // vec
    else:
        data = get_dataset(ty, rnd, ds_size)
        c.num_elements = count_elements(ty, vec, filt, key, rng, data, rnd)
    cases.append(c)


def add_switch(cases, group, ty, rnd):
    c = Case()
    c.group, c.vec, c.is_vector, c.ty = group, 1, False, ty
    c.name, c.base_name, c.key, c.spv_op, c.filt, c.rng, c.ext, c.widths, c.high = "switch", "switch", "switch", None, "none", "full", None, (), False
    c.seed = de_string_hash(ty)
    c.skip = rnd.draws
    data = get_dataset(ty, rnd, 10)
    c.num_elements = len(data)
    c.switch = True
    cases.append(c)


GRAPHICS_CPP = CRATE / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "spirv_assembly" / "vktSpvAsmGraphicsShaderTestUtil.cpp"
GRAPHICS_OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_type_graphics.toml"
TEMPLATE_DIR = CRATE / "shaders" / "src" / "spirv_assembly"
FRAGMENT_KEYS = ("capability", "extension", "decoration", "pre_main", "testfun")
PASSTHRU_TESTFUN = (
    "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n%param1 = OpFunctionParameter %v4f32\n%label_testfun = OpLabel\nOpReturnValue %param1\nOpFunctionEnd\n"
)
MACROS = {"SPIRV_ASSEMBLY_TYPES": ASM_TYPES, "SPIRV_ASSEMBLY_CONSTANTS": ASM_CONSTANTS, "SPIRV_ASSEMBLY_ARRAYS": ASM_ARRAYS}
GRAPHICS_STAGES = (
    ("vert", "vertexShaderBoilerplate"),
    ("tessc", "tessControlShaderBoilerplate"),
    ("tesse", "tessEvalBoilerplate"),
    ("geom", "geometryShaderBoilerplate"),
    ("frag", "fragmentShaderBoilerplate"),
)
# getVertFragPipelineStages, getTessPipelineStages, getGeomPipelineStages
PIPELINES = {
    "vert": ("vert", "frag"),
    "frag": ("vert", "frag"),
    "tessc": ("vert", "tessc", "tesse", "frag"),
    "tesse": ("vert", "tessc", "tesse", "frag"),
    "geom": ("vert", "geom", "frag"),
}
# One manifest per group of stages keeps each below about 30 MB.
MANIFEST_GROUPS = (("graphics", ("vert", "frag")), ("geom", ("geom",)), ("tessc", ("tessc",)), ("tesse", ("tesse",)))


def boilerplate(variable):
    """The stage template of GraphicsShaderTestUtil as a manifest template: the fragments of a case stay `${key}`, every other placeholder is empty."""
    src = GRAPHICS_CPP.read_text()
    start = src.index(f"static const char {variable}[] =")
    end = src.index(";\n    return", start)
    body = src[src.index("=", start) + 1 : end]
    pieces = []
    for m in re.finditer(r'"((?:[^"\\]|\\.)*)"|(SPIRV_ASSEMBLY_\w+)', body):
        pieces.append(MACROS[m.group(2)] if m.group(2) else m.group(1).encode().decode("unicode_escape"))
    text = "".join(pieces)
    return re.sub(r"\$\{(\w+):opt\}", lambda m: "${" + m.group(1) + "}" if m.group(1) in FRAGMENT_KEYS else "", text)


def passthrough(variable):
    text = boilerplate(variable)
    for key in FRAGMENT_KEYS:
        text = text.replace("${" + key + "}", PASSTHRU_TESTFUN if key == "testfun" else "")
    return text


def write_graphics(cases):
    templates = {name: boilerplate(var) for name, var in GRAPHICS_STAGES}
    passthru = {name: passthrough(var) for name, var in GRAPHICS_STAGES}
    for name in templates:
        (TEMPLATE_DIR / f"type_{name}.asm").write_text(templates[name])
        (TEMPLATE_DIR / f"type_{name}_passthru.asm").write_text(passthru[name])
    all_names = set()
    for group, stages in MANIFEST_GROUPS:
        header = (
            f"# Shader manifest for dEQP-VK.spirv_assembly.instruction.type.*.*_{{{','.join(stages)}}}\n#\n"
            "# @generated by hodow_cts/scripts/gen_spirv_assembly_type_manifest.py - do not hand-edit; `spec` says what the Rust side redoes (data, expected values).\n\n"
            f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/type_tests"\n'
        )
        entries = []
        for c in cases:
            for stage in stages:
                path = f"{c.group}/{c.ty}/{c.name}_{stage}"
                all_names.add(path.replace("/", "."))
                programs = ", ".join(
                    f'{{ name = "{p}", template = "spirv_assembly/type_{p}{"" if p == stage else "_passthru"}.asm", stage = "asm", spirv_version = "spirv1.0" }}'
                    for p in PIPELINES[stage]
                )
                derived = ", ".join(f"{key} = {py(c.frags[key])}" for key in FRAGMENT_KEYS)
                entries.append(
                    f'\n[[case]]\nname = "{path}"\nrust_const = "{const_name(path)}"\nrust_type = "TypeGraphicsCase"\n'
                    f'programs = [ {programs} ]\nparams = {{ spec = {{ type = "str", value = "{c.spec}" }} }}\nderived = {{ {derived} }}\n'
                )
        if "--check-names" not in sys.argv:
            out = CRATE / "shaders" / "manifest" / f"spirv_assembly_type_{group}.toml"
            out.write_text(header + "".join(entries))
            print(f"{len(entries)} cases -> {out}", file=sys.stderr)
    want = {line.strip() for line in CASES.read_text().splitlines() if line.strip().endswith(("_vert", "_frag", "_geom", "_tessc", "_tesse"))}
    print(f"graphics: {len(all_names)} generated, {len(want)} in the mustpass, missing {len(want - all_names)}, extra {len(all_names - want)}", file=sys.stderr)


def py(value):
    return json.dumps(repr(value))


def const_name(name):
    return "TYPE_" + re.sub(r"[^A-Za-z0-9]", "_", name).upper()


def main():
    cases = build_cases()
    for c in cases:
        c.text = compose_switch(c) if getattr(c, "switch", False) else compose(c)
        c.spec = ("switch" if getattr(c, "switch", False) else make_spec(c))
        if getattr(c, "switch", False):
            c.spec = f"switch=1;vg=0;vec=1;ty={c.ty};seed={c.seed};skip={c.skip};n={c.num_elements}"
    want = {line.strip() for line in CASES.read_text().splitlines() if line.strip().endswith("_comp")}
    got = {f"{c.group}.{c.ty}.{c.name}_comp" for c in cases}
    names = [f"{c.group}.{c.ty}.{c.name}_comp" for c in cases]
    assert len(names) == len(got), "duplicate case names"
    print(f"{len(got)} generated, {len(want)} in the mustpass, missing {len(want - got)}, extra {len(got - want)}", file=sys.stderr)
    for name in sorted(want - got)[:10]:
        print("  missing", name, file=sys.stderr)
    for name in sorted(got - want)[:10]:
        print("  extra", name, file=sys.stderr)
    write_graphics(cases)
    if "--check-names" in sys.argv:
        return
    header = (
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.type.*.*_comp\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_type_manifest.py - do not hand-edit; `spec` says what the Rust side redoes (data, expected values).\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/type_tests"\n'
    )
    entries = []
    for c, name in zip(cases, names):
        path = name.replace(".", "/")
        entries.append(
            f'\n[[case]]\nname = "{path}"\nrust_const = "{const_name(path)}"\nrust_type = "TypeCompCase"\n'
            f'programs = [ {{ name = "compute", template = "spirv_assembly/type_comp.asm", stage = "asm", spirv_version = "spirv1.0" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{c.spec}" }} }}\nderived = {{ source = {py(c.text)} }}\n'
        )
    OUT.write_text(header + "".join(entries))
    TEMPLATE.write_text("${source}")
    print(f"{len(cases)} cases -> {OUT}", file=sys.stderr)


if __name__ == "__main__":
    main()

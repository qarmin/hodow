#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_float_controls2.toml: the compute cases of dEQP-VK.spirv_assembly.instruction.compute.float_controls2
(vktSpvAsmFloatControls2Tests.cpp, ComputeTestGroupBuilder with argumentsFromInput = true, 1977 cases).

The tables of the C++ (operations, per-type test inputs, the standard cases) are read straight out of the vendored source, so they cannot drift
from it; the shader assembly is then composed the way `ComputeTestGroupBuilder::fillShaderSpec` and `TestGroupBuilderBase::specializeOperation` do.
What a case expects is the ValueId (carried in the manifest as `r=`); src/vkt/tests/spirv_assembly/float_controls2_tests.rs resolves it to values.

    python3 hodow_cts/scripts/gen_spirv_assembly_float_controls2_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
import re
import sys
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
CPP = CRATE / "upstream/external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmFloatControls2Tests.cpp"
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_float_controls2.toml"
OUT_GFX = CRATE / "shaders" / "manifest" / "spirv_assembly_float_controls2_graphics.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmFloatControls2Tests.cpp"
TEMPLATE = "spirv_assembly/source.asm"

FP = {"MaskNone": 0, "NotNaN": 0x1, "NotInf": 0x2, "NSZ": 0x4, "AllowRecip": 0x8, "AllowContract": 0x10000, "AllowReassoc": 0x20000, "AllowTransform": 0x40000}
BEHAVIOR_ORDER = ["NotNaN", "NotInf", "NSZ", "AllowRecip", "AllowContract", "AllowReassoc", "AllowTransform"]
ALL_BITS = sum(FP[n] for n in BEHAVIOR_ORDER)
ALL_BITS_EXCEPT_TRANSFORM = ALL_BITS & ~FP["AllowTransform"]


def strip_comments(text):
    out = []
    i = 0
    in_string = False
    while i < len(text):
        c = text[i]
        if in_string:
            out.append(c)
            if c == "\\":
                out.append(text[i + 1])
                i += 1
            elif c == '"':
                in_string = False
        elif c == '"':
            in_string = True
            out.append(c)
        elif text.startswith("//", i):
            while i < len(text) and text[i] != "\n":
                i += 1
            continue
        else:
            out.append(c)
        i += 1
    return "".join(out)


def split_top(s, sep=","):
    parts = []
    depth = 0
    cur = []
    in_string = False
    i = 0
    while i < len(s):
        c = s[i]
        if in_string:
            cur.append(c)
            if c == "\\":
                cur.append(s[i + 1])
                i += 1
            elif c == '"':
                in_string = False
        elif c == '"':
            in_string = True
            cur.append(c)
        elif c in "({[":
            depth += 1
            cur.append(c)
        elif c in ")}]":
            depth -= 1
            cur.append(c)
        elif c == sep and depth == 0:
            parts.append("".join(cur).strip())
            cur = []
        else:
            cur.append(c)
        i += 1
    tail = "".join(cur).strip()
    if tail:
        parts.append(tail)
    return parts


def matching(s, open_index):
    open_c = s[open_index]
    close_c = {"(": ")", "{": "}", "[": "]"}[open_c]
    depth = 0
    in_string = False
    i = open_index
    while i < len(s):
        c = s[i]
        if in_string:
            if c == "\\":
                i += 1
            elif c == '"':
                in_string = False
        elif c == '"':
            in_string = True
        elif c == open_c:
            depth += 1
        elif c == close_c:
            depth -= 1
            if depth == 0:
                return i
        i += 1
    raise ValueError("unbalanced")


def unescape(body):
    return body.replace("\\n", "\n").replace("\\t", "\t").replace('\\"', '"').replace("\\\\", "\\")


def literal(raw, consts):
    raw = raw.strip()
    if raw in consts:
        return consts[raw]
    parts = re.findall(r'"((?:[^"\\]|\\.)*)"', raw)
    if not parts and raw != '""':
        return None
    return "".join(unescape(p) for p in parts)


def read_source():
    return strip_comments(CPP.read_text())


def enum_values(src, name):
    m = re.search(r"enum\s+" + name + r"\s*\{(.*?)\};", src, re.S)
    names = []
    for entry in split_top(m.group(1)):
        names.append(entry.split("=")[0].strip())
    return names


def value_names(src):
    return dict(re.findall(r'case (V_[A-Z0-9_]+):\s*return "([^"]*)";', src))


def usage_bits(src):
    m = re.search(r"enum FloatStatementUsageBits\s*\{(.*?)\};", src, re.S)
    bits = {}
    for name, shift in re.findall(r"(B_STATEMENT_USAGE_[A-Z0-9_]+)\s*=\s*\(1 << (\d+)\)", m.group(1)):
        bits[name] = 1 << int(shift)
    return bits


def eval_flags(expr, usage):
    total = 0
    for token in expr.split("|"):
        token = token.strip()
        if token in ("", "0"):
            continue
        total |= usage[token]
    return total


def eval_fp(expr):
    total = 0
    for token in expr.split("|"):
        token = token.strip()
        total |= FP[token.replace("FP::", "")]
    return total


class Op:
    pass


def parse_operations(src, usage):
    start = src.index("void TestCasesBuilder::init()")
    end = src.index("void TestCasesBuilder::build(")
    region = src[start:end]
    consts = {}
    for name, body in re.findall(r"const char \*(\w+)\s*=\s*((?:\"(?:[^\"\\]|\\.)*\"\s*)+);", region):
        consts[name] = literal(body, {})
    ops = {}
    for m in re.finditer(r"mo\[(OID_[A-Z0-9_]+)\]\s*=\s*Op\(", region):
        open_index = m.end() - 1
        close_index = matching(region, open_index)
        args = split_top(region[open_index + 1 : close_index])
        op = Op()
        op.name = literal(args[0], consts)
        op.float_usage = args[1]
        op.annotations = op.types = op.constants = op.variables = op.functions = op.commands = ""
        op.ids = ["result"]
        op.restricted = False
        op.restricted_type = None
        op.spec_constant = False
        flags = "0"
        rest_ids = None

        def ids_of(raw):
            return [literal(x, consts) for x in split_top(raw.strip()[1:-1])]

        if args[2] in ("true", "false"):
            op.spec_constant = args[2] == "true"
            op.restricted = True
            op.restricted_type = int(args[3][2:])
            op.constants = literal(args[4], consts)
            op.commands = literal(args[5], consts)
            tail = args[6:]
        elif re.fullmatch(r"FP(16|32|64)", args[2]):
            op.restricted = True
            op.restricted_type = int(args[2][2:])
            op.annotations = literal(args[3], consts)
            op.types = literal(args[4], consts)
            op.constants = literal(args[5], consts)
            op.commands = literal(args[6], consts)
            tail = args[7:]
        elif len(args) >= 8 and literal(args[3], consts) is not None and not args[3].startswith("B_"):
            op.annotations = literal(args[2], consts)
            op.types = literal(args[3], consts)
            op.constants = literal(args[4], consts)
            op.variables = literal(args[5], consts)
            op.functions = literal(args[6], consts)
            op.commands = literal(args[7], consts)
            tail = args[8:]
        else:
            op.commands = literal(args[2], consts)
            tail = args[3:]
        if tail:
            flags = tail[0]
        if len(tail) > 1:
            rest_ids = tail[1]
        op.flags = eval_flags(flags, usage)
        if rest_ids is not None:
            op.ids = ids_of(rest_ids)
        ops[m.group(1)] = op
    return ops


def parse_array(src, declaration):
    start = src.index(declaration)
    open_index = src.index("{", start + len(declaration) - 1)
    close_index = matching(src, open_index)
    entries = []
    for entry in split_top(src[open_index + 1 : close_index]):
        entry = entry.strip()
        if not entry:
            continue
        assert entry.startswith("{"), entry
        entries.append(split_top(entry[1:-1]))
    return entries


class Inputs:
    def __init__(self, op, first, second, result, flags, rte=False):
        self.op, self.first, self.second, self.result, self.flags, self.rte = op, first, second, result, flags, rte


def parse_inputs(entries):
    result = []
    for e in entries:
        result.append(Inputs(e[0], e[1], e[2], e[3], eval_fp(e[4]), len(e) > 5 and e[5] == "true"))
    return result


def standard_cases(entries):
    result = []
    for op, sz, inf, nan in entries:
        result.append(Inputs(op, "V_MINUS_ZERO", "V_ONE", sz, FP["NSZ"]))
        result.append(Inputs(op, "V_INF", "V_ONE", inf, FP["NotInf"]))
        result.append(Inputs(op, "V_NAN", "V_ONE", nan, FP["NotNaN"]))
    return result


def behaviour_name(flags, separator):
    if flags == 0:
        return "None"
    return separator.join(n for n in BEHAVIOR_ORDER if flags & FP[n])


def invert(bfb):
    if bfb & (FP["AllowReassoc"] | FP["AllowContract"]):
        return ~bfb & ALL_BITS_EXCEPT_TRANSFORM
    return ~bfb & ALL_BITS


# ----------------------------------------------------------------------------------------------------------------------
# TypeSnippets
# ----------------------------------------------------------------------------------------------------------------------

def replace_all(s, a, b):
    return s.replace(a, b)


class Snippets:
    pass


def make_snippets(bits):
    s = Snippets()
    s.bit_width = str(bits)
    s.epsilon = {16: "6.104e-5", 32: "1.175494351e-38", 64: "2.2250738585072014e-308"}[bits]
    s.capabilities = {16: "OpCapability StorageUniform16\n", 32: "", 64: "OpCapability Float64\n"}[bits]
    s.extensions = {16: 'OpExtension "SPV_KHR_16bit_storage"\n', 32: "", 64: ""}[bits]
    s.caps_fp16_without = "OpCapability Float16\n" if bits == 16 else ""
    s.exts_fp16_without = ""
    s.array_stride = str(bits // 8)
    s.load_store_requires_shader_float16 = bits == 16

    type_annotations = f"OpDecorate %type_float_arr_1 ArrayStride {s.array_stride}\nOpDecorate %type_float_arr_2 ArrayStride {s.array_stride}\n"
    type_definitions = (
        f"%type_float             = OpTypeFloat {s.bit_width}\n"
        "%type_float_uptr        = OpTypePointer Uniform %type_float\n"
        "%type_float_fptr        = OpTypePointer Function %type_float\n"
        "%type_float_vec2        = OpTypeVector %type_float 2\n"
        "%type_float_vec3        = OpTypeVector %type_float 3\n"
        "%type_float_vec4        = OpTypeVector %type_float 4\n"
        "%type_float_vec4_iptr   = OpTypePointer Input %type_float_vec4\n"
        "%type_float_vec4_optr   = OpTypePointer Output %type_float_vec4\n"
        "%type_float_mat2x2      = OpTypeMatrix %type_float_vec2 2\n"
        "%type_float_arr_1       = OpTypeArray %type_float %c_i32_1\n"
        "%type_float_arr_2       = OpTypeArray %type_float %c_i32_2\n"
    )
    constants = (
        "%c_float_n1             = OpConstant %type_float -1\n"
        "%c_float_n2pt58         = OpConstant %type_float -2.58\n"
        "%c_float_0              = OpConstant %type_float 0.0\n"
        "%c_float_0_5            = OpConstant %type_float 0.5\n"
        "%c_float_1              = OpConstant %type_float 1\n"
        "%c_float_2              = OpConstant %type_float 2\n"
        "%c_float_3              = OpConstant %type_float 3\n"
        "%c_float_4              = OpConstant %type_float 4\n"
        "%c_float_5              = OpConstant %type_float 5\n"
        "%c_float_6              = OpConstant %type_float 6\n"
        f"%c_float_eps            = OpConstant %type_float {s.epsilon}\n"
    )
    arguments_from_input = (
        "%arg1loc                = OpAccessChain %type_float_uptr %ssbo_in %c_i32_0 %c_i32_0\n"
        "%arg1                   = OpLoad %type_float %arg1loc\n"
        "%arg2loc                = OpAccessChain %type_float_uptr %ssbo_in %c_i32_0 %c_i32_1\n"
        "%arg2                   = OpLoad %type_float %arg2loc\n"
    )
    s.input_annotations = (
        "OpMemberDecorate %SSBO_in 0 Offset 0\n"
        "OpDecorate %SSBO_in BufferBlock\n"
        "OpDecorate %ssbo_in DescriptorSet 0\n"
        "OpDecorate %ssbo_in Binding 0\n"
        "OpDecorate %ssbo_in NonWritable\n"
    )
    input_definitions = (
        "%SSBO_in              = OpTypeStruct %type_float_arr_2\n"
        "%up_SSBO_in           = OpTypePointer Uniform %SSBO_in\n"
        "%ssbo_in              = OpVariable %up_SSBO_in Uniform\n"
    )
    s.output_annotations = (
        "OpMemberDecorate %SSBO_out 0 Offset 0\n"
        "OpDecorate %SSBO_out BufferBlock\n"
        "OpDecorate %ssbo_out DescriptorSet 0\n"
        "OpDecorate %ssbo_out Binding 1\n"
    )
    output_definitions = (
        "%SSBO_out             = OpTypeStruct %type_float_arr_1\n"
        "%up_SSBO_out          = OpTypePointer Uniform %SSBO_out\n"
        "%ssbo_out             = OpVariable %up_SSBO_out Uniform\n"
    )
    store_results = "%outloc               = OpAccessChain %type_float_uptr %ssbo_out %c_i32_0 %c_i32_0\nOpStore %outloc %result\n"

    token, name = "_float", f"_f{s.bit_width}"
    s.type_annotations = replace_all(type_annotations, token, name)
    s.type_definitions = replace_all(type_definitions, token, name)
    s.constants = replace_all(constants, token, name)
    s.arguments_from_input = replace_all(arguments_from_input, token, name)
    s.input_definitions = replace_all(input_definitions, token, name)
    s.output_definitions = replace_all(output_definitions, token, name)
    s.store_results = replace_all(store_results, token, name)

    if bits == 64:
        s.varyings_types = "%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2\n%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2\n"
        s.input_varyings = "%BP_vertex_result     = OpVariable %type_u32_vec2_iptr Input\n"
        s.output_varyings = "%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output\n"
        s.store_vertex_result = "%packed_result        = OpBitcast %type_u32_vec2 %result\nOpStore %BP_vertex_result %packed_result\n"
        s.load_vertex_result = "%packed_result        = OpLoad %type_u32_vec2 %BP_vertex_result\n%result               = OpBitcast %type_f64 %packed_result\n"
    else:
        s.varyings_types = "%type_u32_iptr        = OpTypePointer Input %type_u32\n%type_u32_optr        = OpTypePointer Output %type_u32\n"
        s.input_varyings = "%BP_vertex_result    = OpVariable %type_u32_iptr Input\n"
        s.output_varyings = "%BP_vertex_result    = OpVariable %type_u32_optr Output\n"
        if bits == 16:
            s.store_vertex_result = (
                "%tmp_vec2            = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0\n"
                "%packed_result       = OpBitcast %type_u32 %tmp_vec2\n"
                "OpStore %BP_vertex_result %packed_result\n"
            )
            s.load_vertex_result = (
                "%packed_result       = OpLoad %type_u32 %BP_vertex_result\n"
                "%tmp_vec2            = OpBitcast %type_f16_vec2 %packed_result\n"
                "%result              = OpCompositeExtract %type_f16 %tmp_vec2 0\n"
            )
        else:
            s.store_vertex_result = "%packed_result       = OpBitcast %type_u32 %result\nOpStore %BP_vertex_result %packed_result\n"
            s.load_vertex_result = "%packed_result       = OpLoad %type_u32 %BP_vertex_result\n%result              = OpBitcast %type_f32 %packed_result\n"

    s.type_definitions_fp16 = ""
    s.type_annotations_fp16 = ""
    s.arguments_from_input_fp16 = ""
    s.store_results_fp16 = ""
    s.input_definitions_fp16 = ""
    s.output_definitions_fp16 = ""
    if bits == 16:
        s.type_definitions_fp16 = "%type_u32_uptr       = OpTypePointer Uniform %type_u32\n%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1\n"
        s.type_annotations_fp16 = "OpDecorate %type_u32_arr_1 ArrayStride 4\n"
        s.input_definitions_fp16 = replace_all(s.input_definitions, "_f16_arr_2", "_u32_arr_1")
        s.arguments_from_input_fp16 = (
            "%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0\n"
            "%inval             = OpLoad %type_u32 %argloc\n"
            "%arg               = OpBitcast %type_f16_vec2 %inval\n"
            "%arg1              = OpCompositeExtract %type_f16 %arg 0\n"
            "%arg2              = OpCompositeExtract %type_f16 %arg 1\n"
        )
        s.output_definitions_fp16 = replace_all(s.output_definitions, "_f16_arr_1", "_u32_arr_1")
        s.store_results_fp16 = (
            "%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0\n"
            "%result_u32 = OpBitcast %type_u32 %result_f16_vec2\n"
            "%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0\n"
            "OpStore %outloc %result_u32\n"
        )
    return s


SHADER_TEMPLATE = (
    "OpCapability Shader\n"
    "${capabilities}"
    'OpExtension "SPV_KHR_float_controls2"\n'
    "${extensions}"
    '%std450            = OpExtInstImport "GLSL.std.450"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint GLCompute %main "main" %id\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "${execution_mode}"
    "OpDecorate %id BuiltIn GlobalInvocationId\n"
    "${decorations}"
    "${annotations}"
    "%type_void            = OpTypeVoid\n"
    "%type_voidf           = OpTypeFunction %type_void\n"
    "%type_bool            = OpTypeBool\n"
    "%type_u32             = OpTypeInt 32 0\n"
    "%type_i32             = OpTypeInt 32 1\n"
    "%type_i32_fptr        = OpTypePointer Function %type_i32\n"
    "%type_u32_vec2        = OpTypeVector %type_u32 2\n"
    "%type_u32_vec3        = OpTypeVector %type_u32 3\n"
    "%type_u32_vec3_ptr    = OpTypePointer Input %type_u32_vec3\n"
    "%c_i32_0              = OpConstant %type_i32 0\n"
    "%c_i32_1              = OpConstant %type_i32 1\n"
    "%c_i32_2              = OpConstant %type_i32 2\n"
    "${types}"
    "${io_definitions}"
    "%id                   = OpVariable %type_u32_vec3_ptr Input\n"
    "${constants}"
    "${behaviorConstants}"
    "${functions}"
    "%main                 = OpFunction %type_void None %type_voidf\n"
    "%label                = OpLabel\n"
    "${variables}"
    "${arguments}"
    "${commands}"
    "${save_result}"
    "OpReturn\n"
    "OpFunctionEnd\n"
)


def specialize(template, values):
    return re.sub(r"\$\{(\w+)\}", lambda m: values[m.group(1)], template)


class Case:
    pass


def build_cases(inputs, is_fp16):
    cases = []
    for it in inputs:
        base = f"op_testedWithout_{behaviour_name(it.flags, '_OR_')}_arg1_{VALUE_NAMES[it.first]}_arg2_{VALUE_NAMES[it.second]}_res_{VALUE_NAMES[it.result]}"
        for suffix, deco in (("_exec", False), ("_deco", True)):
            cases.append(make_case(base + suffix, invert(it.flags), deco, it.op, it.first, it.second, it.result, is_fp16, it.rte))
    cases.append(make_case("op_None_exec_grammar_test", 0, False, "OID_ADD", "V_MAX", "V_HUGE", "V_INF", is_fp16, True))
    cases.append(
        make_case(
            "op_AllowTransform_OR_AllowReassoc_OR_AllowContract_exec_grammar_test",
            FP["AllowTransform"] | FP["AllowReassoc"] | FP["AllowContract"],
            False, "OID_ADD", "V_MAX", "V_HUGE", "V_INF", is_fp16, True,
        )
    )
    cases.append(make_case("op_AllowRecip_exec_grammar_test", FP["AllowRecip"], False, "OID_DIV", "V_ONE", "V_TWO", "V_HALF", is_fp16, False))
    return cases


def make_case(base_name, flags, use_decoration, op, first, second, result, fp16_without_storage, require_rte):
    c = Case()
    c.base_name = base_name
    c.use_decoration = use_decoration
    if use_decoration:
        c.exec_mode, c.decoration = ALL_BITS, flags
    else:
        c.exec_mode, c.decoration = flags, 0
    c.op, c.first, c.second, c.result = op, first, second, result
    c.fp16_without_storage = fp16_without_storage
    c.require_rte = require_rte
    return c


def fill_shader(out_bits, op, case, snippets):
    """`ComputeTestGroupBuilder::fillShaderSpec` for arguments read from the input buffer; returns (assembly, feature flags)."""
    out_snippets = snippets[out_bits]
    in_bits = op.restricted_type if op.restricted else out_bits
    in_snippets = snippets[in_bits]

    constants = replace_all(op.constants, "_float", f"_f{in_snippets.bit_width}")
    annotations = replace_all(op.annotations, "${float_width}", str(out_bits // 8))
    types = replace_all(op.types, "_float", f"_f{out_snippets.bit_width}")
    variables = replace_all(op.variables, "_float", f"_f{out_snippets.bit_width}")
    functions = replace_all(op.functions, "_float", f"_f{out_snippets.bit_width}")
    commands = replace_all(op.commands, "_float", f"_f{out_snippets.bit_width}")

    out_without = out_bits == 16 and case.fp16_without_storage
    in_without = in_bits == 16 and case.fp16_without_storage
    arguments = in_snippets.arguments_from_input_fp16 if in_without else in_snippets.arguments_from_input

    behaviour_capability = "OpCapability FloatControls2\n"
    behaviour_constants = f"%bc_u32_fp_exec_mode = OpConstant %type_u32 {case.exec_mode}\n"
    behaviour_exec_mode = f"OpExecutionModeId %main FPFastMathDefault %type_f{in_snippets.bit_width} %bc_u32_fp_exec_mode\n"
    behaviour_decorations = ""
    if case.use_decoration:
        for ident in op.ids:
            behaviour_decorations += f"OpDecorate %{ident} FPFastMathMode {behaviour_name(case.decoration, '|')}\n"

    capabilities = behaviour_capability + out_snippets.capabilities
    extensions = out_snippets.extensions
    all_annotations = in_snippets.input_annotations + out_snippets.output_annotations + out_snippets.type_annotations
    all_types = out_snippets.type_definitions
    all_constants = out_snippets.constants

    io_definitions = in_snippets.input_definitions_fp16 if in_without else in_snippets.input_definitions
    if out_without:
        extensions = out_snippets.exts_fp16_without
        capabilities = behaviour_capability + out_snippets.caps_fp16_without
        all_types += out_snippets.type_definitions_fp16
        all_annotations += out_snippets.type_annotations_fp16
        io_definitions += out_snippets.output_definitions_fp16
    else:
        io_definitions += out_snippets.output_definitions

    out_fp16_type_usage = out_snippets.load_store_requires_shader_float16
    in_fp16_type_usage = False

    if op.restricted:
        all_annotations += in_snippets.type_annotations
        all_types += in_snippets.type_definitions
        all_constants += in_snippets.constants
        if in_without:
            all_annotations += in_snippets.type_annotations_fp16
            all_types += in_snippets.type_definitions_fp16
            capabilities += in_snippets.caps_fp16_without
            extensions += in_snippets.exts_fp16_without
        else:
            capabilities += in_snippets.capabilities
            extensions += in_snippets.extensions
        in_fp16_type_usage = in_snippets.load_store_requires_shader_float16

    commands_any_const = USAGE["B_STATEMENT_USAGE_COMMANDS_CONST_FLOAT"] | USAGE["B_STATEMENT_USAGE_COMMANDS_CONST_FP16"] | USAGE["B_STATEMENT_USAGE_COMMANDS_CONST_FP32"] | USAGE["B_STATEMENT_USAGE_COMMANDS_CONST_FP64"]
    need_constants = (op.flags & commands_any_const) != 0
    consts_fp16_mask = USAGE["B_STATEMENT_USAGE_CONSTS_TYPE_FLOAT"] | USAGE["B_STATEMENT_USAGE_CONSTS_TYPE_FP16"]
    consts_uses_fp16_type = (op.flags & consts_fp16_mask) != 0
    load_store_requires_shader_float16 = in_fp16_type_usage or out_fp16_type_usage
    uses_fp16_constants = consts_uses_fp16_type or (need_constants and load_store_requires_shader_float16)

    final_constants = all_constants if (need_constants or out_without) else ""
    final_constants += constants

    float16_feature_required = out_bits == 16 or in_bits == 16
    float64_feature_required = out_bits == 64 or in_bits == 64
    float16_capability_already_added = in_without or out_without
    arithmetic = op.float_usage == "FLOAT_ARITHMETIC"
    if (arithmetic and float16_feature_required and not float16_capability_already_added) or uses_fp16_constants:
        capabilities += "OpCapability Float16\n"

    if case.require_rte:
        extensions += 'OpExtension "SPV_KHR_float_controls"\n'
        capabilities += "OpCapability RoundingModeRTE\n"
        behaviour_exec_mode += f"OpExecutionMode %main RoundingModeRTE {in_snippets.bit_width}\n"

    assembly = specialize(
        SHADER_TEMPLATE,
        {
            "capabilities": capabilities,
            "extensions": extensions,
            "execution_mode": behaviour_exec_mode,
            "decorations": behaviour_decorations,
            "annotations": all_annotations + annotations,
            "types": all_types + types,
            "io_definitions": io_definitions,
            "constants": final_constants,
            "behaviorConstants": behaviour_constants,
            "functions": functions,
            "variables": variables,
            "arguments": arguments,
            "commands": commands,
            "save_result": out_snippets.store_results_fp16 if out_without else out_snippets.store_results,
        },
    )

    sz_mask = FP["NSZ"] | FP["NotInf"] | FP["NotNaN"]
    requires_sz = (case.exec_mode & sz_mask) != sz_mask or (case.decoration & sz_mask) != sz_mask
    spec = {
        "w": in_bits,
        "ow": out_bits,
        "a": VALUE_INDEX[case.first],
        "b": VALUE_INDEX[case.second],
        "r": VALUE_INDEX[case.result],
        "sz": int(requires_sz),
        "rte": int(case.require_rte),
        "f64": int(float64_feature_required),
        "st16": int(float16_feature_required and not case.fp16_without_storage),
        "sf16": int(float16_capability_already_added or uses_fp16_constants or (float16_feature_required and not case.fp16_without_storage and arithmetic)),
    }
    return assembly, ";".join(f"{k}={v}" for k, v in spec.items())


VERTEX_TEMPLATE = (
    "OpCapability Shader\n"
    "${vert_capabilities}"
    'OpExtension "SPV_KHR_float_controls2"\n'
    "${vert_extensions}"
    '%std450            = OpExtInstImport "GLSL.std.450"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result \n'
    "${vert_execution_mode}"
    "OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position\n"
    "OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize\n"
    "OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance\n"
    "OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance\n"
    "OpDecorate %BP_gl_PerVertex Block\n"
    "OpDecorate %BP_position Location 0\n"
    "OpDecorate %BP_color Location 1\n"
    "OpDecorate %BP_vertex_color Location 1\n"
    "OpDecorate %BP_vertex_result Location 2\n"
    "OpDecorate %BP_vertex_result Flat\n"
    "OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex\n"
    "OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex\n"
    "${vert_decorations}"
    "${vert_annotations}"
    "%type_void            = OpTypeVoid\n"
    "%type_voidf           = OpTypeFunction %type_void\n"
    "%type_bool            = OpTypeBool\n"
    "%type_i32             = OpTypeInt 32 1\n"
    "%type_u32             = OpTypeInt 32 0\n"
    "%type_u32_vec2        = OpTypeVector %type_u32 2\n"
    "%type_i32_iptr        = OpTypePointer Input %type_i32\n"
    "%type_i32_optr        = OpTypePointer Output %type_i32\n"
    "%type_i32_fptr        = OpTypePointer Function %type_i32\n"
    "%c_i32_0              = OpConstant %type_i32 0\n"
    "%c_i32_1              = OpConstant %type_i32 1\n"
    "%c_i32_2              = OpConstant %type_i32 2\n"
    "%c_u32_1              = OpConstant %type_u32 1\n"
    "${vert_types}"
    "${vert_io_definitions}"
    "%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1\n"
    "%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex\n"
    "%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output\n"
    "%BP_position          = OpVariable %type_f32_vec4_iptr Input\n"
    "%BP_color             = OpVariable %type_f32_vec4_iptr Input\n"
    "%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input\n"
    "%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input\n"
    "%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output\n"
    "${vert_constants}"
    "${behaviorConstants}"
    "${vert_functions}"
    "%main                 = OpFunction %type_void None %type_voidf\n"
    "%label                = OpLabel\n"
    "${vert_variables}"
    "%position             = OpLoad %type_f32_vec4 %BP_position\n"
    "%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0\n"
    "OpStore %gl_pos %position\n"
    "%color                = OpLoad %type_f32_vec4 %BP_color\n"
    "OpStore %BP_vertex_color %color\n"
    "${vert_arguments}"
    "${vert_commands}"
    "${vert_process_result}"
    "OpReturn\n"
    "OpFunctionEnd\n"
)

FRAGMENT_TEMPLATE = (
    "OpCapability Shader\n"
    "${frag_capabilities}"
    'OpExtension "SPV_KHR_float_controls2"\n'
    "${frag_extensions}"
    '%std450            = OpExtInstImport "GLSL.std.450"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord \n'
    "OpExecutionMode %main OriginUpperLeft\n"
    "${frag_execution_mode}"
    "OpDecorate %BP_fragColor Location 0\n"
    "OpDecorate %BP_vertex_color Location 1\n"
    "OpDecorate %BP_vertex_result Location 2\n"
    "OpDecorate %BP_vertex_result Flat\n"
    "OpDecorate %BP_gl_FragCoord BuiltIn FragCoord\n"
    "${frag_decorations}"
    "${frag_annotations}"
    "%type_void            = OpTypeVoid\n"
    "%type_voidf           = OpTypeFunction %type_void\n"
    "%type_bool            = OpTypeBool\n"
    "%type_i32             = OpTypeInt 32 1\n"
    "%type_u32             = OpTypeInt 32 0\n"
    "%type_u32_vec2        = OpTypeVector %type_u32 2\n"
    "%type_i32_iptr        = OpTypePointer Input %type_i32\n"
    "%type_i32_optr        = OpTypePointer Output %type_i32\n"
    "%type_i32_fptr        = OpTypePointer Function %type_i32\n"
    "%c_i32_0              = OpConstant %type_i32 0\n"
    "%c_i32_1              = OpConstant %type_i32 1\n"
    "%c_i32_2              = OpConstant %type_i32 2\n"
    "%c_u32_1              = OpConstant %type_u32 1\n"
    "${frag_types}"
    "%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input\n"
    "%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input\n"
    "%BP_fragColor         = OpVariable %type_f32_vec4_optr Output\n"
    "${frag_io_definitions}"
    "${frag_constants}"
    "${behaviorConstants}"
    "${frag_functions}"
    "%main                 = OpFunction %type_void None %type_voidf\n"
    "%label                = OpLabel\n"
    "${frag_variables}"
    "%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color\n"
    "OpStore %BP_fragColor %vertex_color\n"
    "${frag_arguments}"
    "${frag_commands}"
    "${frag_process_result}"
    "OpReturn\n"
    "OpFunctionEnd\n"
)

F32_TYPE_MINIMAL = (
    "%type_f32             = OpTypeFloat 32\n"
    "%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1\n"
    "%type_f32_iptr        = OpTypePointer Input %type_f32\n"
    "%type_f32_optr        = OpTypePointer Output %type_f32\n"
    "%type_f32_vec4        = OpTypeVector %type_f32 4\n"
    "%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4\n"
    "%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4\n"
)


def fill_graphics(out_bits, op, case, snippets, tested_stage, arguments_from_input=True):
    """`GraphicsTestGroupBuilder::createInstanceContext` + `getGraphicsShaderCode` for arguments read from the input buffer."""
    out_snippets = snippets[out_bits]
    in_bits = op.restricted_type if op.restricted else out_bits
    in_snippets = snippets[in_bits]

    functions = replace_all(op.functions, "_float", f"_f{out_snippets.bit_width}")
    constants = replace_all(op.constants, "_float", f"_f{in_snippets.bit_width}")
    annotations = replace_all(op.annotations, "${float_width}", str(out_bits // 8))
    types = replace_all(op.types, "_float", f"_f{out_snippets.bit_width}")
    variables = replace_all(op.variables, "_float", f"_f{out_snippets.bit_width}")
    commands = replace_all(op.commands, "_float", f"_f{out_snippets.bit_width}")
    in_without = in_bits == 16 and case.fp16_without_storage
    out_without = out_bits == 16 and case.fp16_without_storage
    arguments = in_snippets.arguments_from_input_fp16 if in_without else in_snippets.arguments_from_input

    needs_shader_float16 = in_without or out_without
    needs_special_constants = False

    behaviour_capability = "OpCapability FloatControls2\n"
    behaviour_constants = f"%bc_u32_fp_exec_mode = OpConstant %type_u32 {case.exec_mode}\n"
    behaviour_exec_mode = f"OpExecutionModeId %main FPFastMathDefault %type_f{in_snippets.bit_width} %bc_u32_fp_exec_mode\n"
    behaviour_decorations = ""
    if case.use_decoration:
        for ident in op.ids:
            behaviour_decorations += f"OpDecorate %{ident} FPFastMathMode {behaviour_name(case.decoration, '|')}\n"

    float16_feature_required = in_bits == 16 or out_bits == 16
    float64_feature_required = in_bits == 64 or out_bits == 64

    if tested_stage == "vert":
        vert_annotations = in_snippets.input_annotations + in_snippets.type_annotations
        frag_annotations = out_snippets.output_annotations + out_snippets.type_annotations
        vert_functions = functions
        frag_functions = ""
        if op.restricted:
            vert_caps = in_snippets.capabilities + out_snippets.capabilities
            frag_caps = out_snippets.capabilities
            vert_exts = in_snippets.extensions + out_snippets.extensions
            frag_exts = out_snippets.extensions
            vert_types = in_snippets.type_definitions + out_snippets.type_definitions + out_snippets.varyings_types
            if in_without:
                vert_types += in_snippets.type_definitions_fp16
            frag_types = out_snippets.type_definitions + out_snippets.varyings_types
            vert_constants = in_snippets.constants + out_snippets.constants
            frag_constants = out_snippets.constants
        else:
            vert_caps = out_snippets.capabilities
            frag_caps = vert_caps
            vert_exts = out_snippets.extensions
            frag_exts = vert_exts
            vert_types = out_snippets.type_definitions + out_snippets.varyings_types
            frag_types = vert_types
            vert_constants = out_snippets.constants
            frag_constants = out_snippets.constants
        if out_bits != 32:
            frag_types += F32_TYPE_MINIMAL
            if in_bits != 32:
                vert_types += F32_TYPE_MINIMAL
        vert_annotations += annotations
        vert_types += types
        vert_constants += constants

        vert_exec = behaviour_exec_mode
        frag_exec = ""
        vert_io = in_snippets.input_definitions + out_snippets.output_varyings
        frag_io = out_snippets.input_varyings + out_snippets.output_definitions
        vert_arguments, frag_arguments = arguments, ""
        vert_variables, frag_variables = variables, ""
        vert_commands, frag_commands = commands, ""
        vert_process = out_snippets.store_vertex_result
        frag_process = out_snippets.load_vertex_result + out_snippets.store_results

        if in_without:
            vert_annotations += in_snippets.type_annotations_fp16
            vert_io = in_snippets.input_definitions_fp16 + out_snippets.output_varyings
        if out_without:
            vert_types += out_snippets.type_definitions_fp16
            frag_types += out_snippets.type_definitions_fp16
            frag_annotations += out_snippets.type_annotations_fp16
            frag_io = out_snippets.input_varyings + out_snippets.output_definitions_fp16
            frag_process = out_snippets.load_vertex_result + out_snippets.store_results_fp16
        needs_shader_float16 |= out_snippets.load_store_requires_shader_float16
    else:
        frag_functions = functions
        vert_functions = ""
        if op.restricted:
            frag_annotations = in_snippets.input_annotations + in_snippets.type_annotations + out_snippets.output_annotations + out_snippets.type_annotations
            frag_caps = (in_snippets.caps_fp16_without if in_without else in_snippets.capabilities) + (out_snippets.caps_fp16_without if out_without else out_snippets.capabilities)
            frag_exts = (in_snippets.exts_fp16_without if in_without else in_snippets.extensions) + (out_snippets.exts_fp16_without if out_without else out_snippets.extensions)
            frag_types = in_snippets.type_definitions + out_snippets.type_definitions
            frag_constants = in_snippets.constants + out_snippets.constants
        else:
            frag_annotations = in_snippets.input_annotations + in_snippets.type_annotations + out_snippets.output_annotations
            frag_caps = out_snippets.caps_fp16_without if out_without else out_snippets.capabilities
            frag_exts = out_snippets.exts_fp16_without if out_without else out_snippets.extensions
            frag_types = out_snippets.type_definitions
            frag_constants = out_snippets.constants

        unused_vert_varying = "%BP_vertex_result     = OpVariable %type_i32_optr Output\n"
        unused_frag_varying = "%BP_vertex_result     = OpVariable %type_i32_iptr Input\n"
        vert_caps = ""
        vert_exts = ""
        vert_annotations = "OpDecorate %type_f32_arr_1 ArrayStride 4\n"
        vert_types = F32_TYPE_MINIMAL
        vert_constants = ""
        if out_bits != 32 and in_bits != 32:
            frag_types += F32_TYPE_MINIMAL
        frag_annotations += annotations
        frag_types += types
        frag_constants += constants

        vert_exec = ""
        frag_exec = behaviour_exec_mode
        vert_io = unused_vert_varying
        frag_io = unused_frag_varying
        vert_arguments, frag_arguments = "", arguments
        vert_variables, frag_variables = "", variables
        vert_commands, frag_commands = "", commands
        vert_process = ""
        frag_process = out_snippets.store_results

        if in_without:
            frag_annotations += in_snippets.type_annotations_fp16
            if op.restricted:
                frag_types += in_snippets.type_definitions_fp16
            frag_io += in_snippets.input_definitions_fp16
        else:
            frag_io += in_snippets.input_definitions
        if out_without:
            if op.restricted:
                frag_annotations += out_snippets.type_annotations_fp16
            frag_types += out_snippets.type_definitions_fp16
            frag_io += out_snippets.output_definitions_fp16
            frag_process = out_snippets.store_results_fp16
        else:
            frag_io += out_snippets.output_definitions
        if not arguments_from_input and case.op in ("OID_CONV_FROM_FP32", "OID_CONV_FROM_FP64"):
            needs_special_constants = True

    arithmetic = op.float_usage == "FLOAT_ARITHMETIC"
    needs_shader_float16 |= float16_feature_required and arithmetic

    needs_fp16_constants = needs_shader_float16 or needs_special_constants or out_without
    if not needs_fp16_constants and float16_feature_required:
        commands_const_mask = USAGE["B_STATEMENT_USAGE_COMMANDS_CONST_FLOAT"] | USAGE["B_STATEMENT_USAGE_COMMANDS_CONST_FP16"]
        needs_fp16_constants |= (op.flags & commands_const_mask) != 0
        if not needs_fp16_constants:
            vert_constants = ""
            frag_constants = ""
    needs_shader_float16 |= needs_fp16_constants

    if needs_shader_float16:
        vert_caps += "OpCapability Float16\n"
        frag_caps += "OpCapability Float16\n"

    if case.require_rte:
        vert_exts += 'OpExtension "SPV_KHR_float_controls"\n'
        vert_caps += "OpCapability RoundingModeRTE\n"
        vert_exec += f"OpExecutionMode %main RoundingModeRTE {in_snippets.bit_width}\n"
        frag_exts += 'OpExtension "SPV_KHR_float_controls"\n'
        frag_caps += "OpCapability RoundingModeRTE\n"
        frag_exec += f"OpExecutionMode %main RoundingModeRTE {in_snippets.bit_width}\n"

    if tested_stage == "vert":
        vert_caps += behaviour_capability
        vert_decorations, frag_decorations = behaviour_decorations, ""
    else:
        frag_caps += behaviour_capability
        vert_decorations, frag_decorations = "", behaviour_decorations

    values = {
        "vert_decorations": vert_decorations, "frag_decorations": frag_decorations, "behaviorConstants": behaviour_constants,
        "vert_capabilities": vert_caps, "vert_extensions": vert_exts, "vert_execution_mode": vert_exec, "vert_annotations": vert_annotations,
        "vert_types": vert_types, "vert_constants": vert_constants, "vert_io_definitions": vert_io, "vert_arguments": vert_arguments,
        "vert_variables": vert_variables, "vert_functions": vert_functions, "vert_commands": vert_commands, "vert_process_result": vert_process,
        "frag_capabilities": frag_caps, "frag_extensions": frag_exts, "frag_execution_mode": frag_exec, "frag_annotations": frag_annotations,
        "frag_types": frag_types, "frag_constants": frag_constants, "frag_functions": frag_functions, "frag_io_definitions": frag_io,
        "frag_arguments": frag_arguments, "frag_variables": frag_variables, "frag_commands": frag_commands, "frag_process_result": frag_process,
    }
    vert = specialize(VERTEX_TEMPLATE, values)
    frag = specialize(FRAGMENT_TEMPLATE, values)

    sz_mask = FP["NSZ"] | FP["NotInf"] | FP["NotNaN"]
    requires_sz = (case.exec_mode & sz_mask) != sz_mask or (case.decoration & sz_mask) != sz_mask
    spec = {
        "w": in_bits,
        "ow": out_bits,
        "a": VALUE_INDEX[case.first],
        "b": VALUE_INDEX[case.second],
        "r": VALUE_INDEX[case.result],
        "sz": int(requires_sz),
        "rte": int(case.require_rte),
        "f64": int(float64_feature_required),
        "st16": int(float16_feature_required and (not case.fp16_without_storage or tested_stage == "vert")),
        "sf16": int(needs_shader_float16),
    }
    return vert, frag, ";".join(f"{k}={v}" for k, v in spec.items())


def py(value):
    return json.dumps(repr(value))


def main():
    global VALUE_NAMES, VALUE_INDEX, USAGE
    src = read_source()
    value_ids = enum_values(src, "ValueId")
    VALUE_INDEX = {name: index for index, name in enumerate(value_ids)}
    VALUE_NAMES = value_names(src)
    USAGE = usage_bits(src)
    ops = parse_operations(src, USAGE)

    special = parse_inputs(parse_array(src, "const OperationTestCaseInputs testCaseInputsArr[] = {"))
    std_cases = standard_cases(parse_array(src, "const standardOperationTestCase stcArr[] = {"))
    non_stc = parse_inputs(parse_array(src, "const OperationTestCaseInputs nonStc16and32Only[] = {"))
    stc_16_32 = standard_cases(parse_array(src, "const standardOperationTestCase stc16and32only[] = {"))
    conv = {
        16: standard_cases(parse_array(src, "const standardOperationTestCase stcConvTo16[] = {")),
        32: standard_cases(parse_array(src, "const standardOperationTestCase stcConvTo32[] = {")),
        64: standard_cases(parse_array(src, "const standardOperationTestCase stcConvTo64[] = {")),
    }
    per_type = {}
    for bits in (16, 32, 64):
        inputs = special + std_cases
        if bits in (16, 32):
            inputs = inputs + non_stc + conv[bits] + stc_16_32
        else:
            inputs = inputs + conv[bits]
        per_type[bits] = inputs

    snippets = {bits: make_snippets(bits) for bits in (16, 32, 64)}

    entries = []
    counts = {}
    for bits in (16, 32, 64):
        cases = build_cases(per_type[bits], bits == 16)
        total = 0
        for case in cases:
            if VALUE_INDEX[case.result] == 0:
                continue
            op = ops[case.op]
            name = case.base_name.replace("op", op.name)
            assembly, spec = fill_shader(bits, op, case, snippets)
            const = f"FC2_FP{bits}_{re.sub(r'[^A-Za-z0-9]', '_', name).upper()}"
            entries.append(
                f'\n[[case]]\nname = "fp{bits}/input_args/{name}"\nrust_const = "{const}"\nrust_type = "FloatControls2Case"\n'
                f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm", spirv_version = "spirv1.2" }} ]\n'
                f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
                f"derived = {{ source = {py(assembly)} }}\n"
            )
            total += 1
        counts[bits] = total

    gfx_entries = []
    gfx_total = 0
    for bits in (16, 32, 64):
        for case in build_cases(per_type[bits], bits == 16):
            if VALUE_INDEX[case.result] == 0:
                continue
            op = ops[case.op]
            name = case.base_name.replace("op", op.name)
            for stage in ("vert", "frag"):
                vert, frag, spec = fill_graphics(bits, op, case, snippets, stage)
                full_name = f"{name}_{stage}"
                const = f"FC2G_FP{bits}_{re.sub(r'[^A-Za-z0-9]', '_', full_name).upper()}"
                gfx_entries.append(
                    f'\n[[case]]\nname = "fp{bits}/input_args/{full_name}"\nrust_const = "{const}"\nrust_type = "FloatControls2GraphicsCase"\n'
                    f'programs = [ {{ name = "vert", template = "spirv_assembly/fc2_vert.asm", stage = "asm", spirv_version = "spirv1.2" }}, '
                    f'{{ name = "frag", template = "spirv_assembly/fc2_frag.asm", stage = "asm", spirv_version = "spirv1.2" }} ]\n'
                    f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
                    f"derived = {{ fc2_vert = {py(vert)}, fc2_frag = {py(frag)} }}\n"
                )
                gfx_total += 1
    GFX_HEADER = (
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.graphics.float_controls2.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_float_controls2_manifest.py - do not hand-edit; `spec` says which ValueIds a case reads and expects.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/float_controls2_tests"\n'
    )
    OUT_GFX.write_text(GFX_HEADER + "".join(gfx_entries))
    for name in ("fc2_vert", "fc2_frag"):
        (CRATE / "shaders" / "src" / "spirv_assembly" / f"{name}.asm").write_text("${" + name + "}")
    print(f"graphics cases {gfx_total} -> {OUT_GFX}", file=sys.stderr)

    header = (
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.float_controls2.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_float_controls2_manifest.py - do not hand-edit; `spec` says which ValueIds a case reads and expects.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/float_controls2_tests"\n'
    )
    OUT.write_text(header + "".join(entries))
    print(f"cases per type {counts}, total {sum(counts.values())} -> {OUT}", file=sys.stderr)


if __name__ == "__main__":
    main()

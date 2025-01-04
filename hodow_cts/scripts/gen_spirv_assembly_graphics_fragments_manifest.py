#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_graphics_fragments.toml: the cases of dEQP-VK.spirv_assembly.instruction.graphics.* that are only fragments
(`createTestsForAllStages(name, inputColors, outputColors, fragments, group)` with no resources): opname_abuse and opmembername_abuse.

Each case becomes five (vert, tessc, tesse, geom, frag) cases through the stage templates gfx_*.asm that this script reads out of
vktSpvAsmGraphicsShaderTestUtil.cpp. The strings with arbitrary bytes upstream abuses as names are read out of the C++ and carried as the characters of the
same byte values (latin-1), because a manifest is UTF-8 text.

A pure text generator: no spirv-as and no cargo."""
import json
import re
import struct
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
SRC_DIR = HERE.parent / "shaders" / "src" / "spirv_assembly"
sys.path.insert(0, str(HERE))
import gen_spirv_assembly_type_manifest as stages  # noqa: E402

CRATE = HERE.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_graphics_fragments.toml"
CPP = CRATE / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "spirv_assembly" / "vktSpvAsmInstructionTests.cpp"
KEYS = stages.FRAGMENT_KEYS + ("debug", "execution_mode", "moduleprocessed", "GL_entrypoint")
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp"
ALL_STAGES = ("vert", "tessc", "tesse", "geom", "frag")


def boilerplate(variable):
    src = stages.GRAPHICS_CPP.read_text()
    start = src.index(f"static const char {variable}[] =")
    end = src.index(";\n    return", start)
    body = src[src.index("=", start) + 1 : end]
    pieces = []
    for m in re.finditer(r'"((?:[^"\\]|\\.)*)"|(SPIRV_ASSEMBLY_\w+)', body):
        pieces.append(stages.MACROS[m.group(2)] if m.group(2) else m.group(1).encode().decode("unicode_escape"))
    text = "".join(pieces)
    return re.sub(r"\$\{(\w+):opt\}", lambda m: "${" + m.group(1) + "}" if m.group(1) in KEYS else "", text)


def write_templates():
    for stage, variable in stages.GRAPHICS_STAGES:
        text = boilerplate(variable)
        (stages.TEMPLATE_DIR / f"gfx_{stage}.asm").write_text(text)
        passthru = text
        for key in KEYS:
            passthru = passthru.replace("${" + key + "}", stages.PASSTHRU_TESTFUN if key == "testfun" else "")
        (stages.TEMPLATE_DIR / f"gfx_{stage}_passthru.asm").write_text(passthru)


COMPUTE_CPP = CPP.parent / "vktSpvAsmComputeShaderTestUtil.cpp"
COMPUTE_OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_compute_fragments.toml"


def write_compute_template():
    """makeComputeShaderAssembly's boilerplate as the manifest template gfx_comp.asm."""
    src = COMPUTE_CPP.read_text()
    start = src.index("static const char computeShaderBoilerplate[] =")
    body = src[src.index("=", start) + 1 : src.index(";\n\n    return", start)]
    pieces = []
    for m in re.finditer(r'"((?:[^"\\]|\\.)*)"|(SPIRV_ASSEMBLY_\w+)', body):
        pieces.append(stages.MACROS[m.group(2)] if m.group(2) else m.group(1).encode().decode("unicode_escape"))
    text = re.sub(r"\$\{(\w+):opt\}", lambda m: "${" + m.group(1) + "}" if m.group(1) in KEYS else "", "".join(pieces))
    (stages.TEMPLATE_DIR / "gfx_comp.asm").write_text(text)


def cpp_string(name):
    """The bytes of `std::string <name> = "..." "...";` in the instruction tests."""
    src = CPP.read_text()
    start = src.index(f"std::string {name} =")
    body = src[src.index("=", start) + 1 : src.index(";", start)]
    out = bytearray()
    for m in re.finditer(r'"((?:[^"\\]|\\.)*)"', body):
        text = m.group(1)
        i = 0
        while i < len(text):
            if text[i] == "\\":
                if text[i + 1] == "x":
                    j = i + 2
                    while j < len(text) and text[j] in "0123456789abcdefABCDEF":
                        j += 1
                    out.append(int(text[i + 2 : j], 16))
                    i = j
                    continue
                out += {"n": b"\n", "t": b"\t", '"': b'"', "\\": b"\\"}[text[i + 1]]
                i += 2
            else:
                out += text[i].encode()
                i += 1
    return bytes(out)


def name_abuse_cases():
    cases = [
        ("_has_very_long_name", b"k" * 65535),
        ("_utf8_illegal", cpp_string("utf8illegal")),
        ("_utf8_nul", cpp_string("utf8nul")),
        ("_utf8_overlong", cpp_string("utf8overlong")),
        ("_utf8_zalgo", cpp_string("utf8zalgo")),
    ]
    for word in (
        "gl_Position gl_InstanceID gl_PrimitiveID gl_TessCoord gl_PerVertex gl_InvocationID gl_PointSize gl_PointCoord gl_Layer gl_FragDepth "
        "gl_NumWorkGroups gl_WorkGroupID gl_LocalInvocationID gl_GlobalInvocationID gl_MaxVertexAttribs gl_MaxViewports gl_MaxComputeWorkGroupCount"
    ).split():
        cases.append((f"_is_{word}", word.encode()))
    for word in ("mat3", "volatile", "inout", "isampler3d"):
        cases.append((f"_is_{word}", word.encode()))
    return [(suffix, value.decode("latin-1")) for suffix, value in cases]


OPNAME_TESTFUN = (
    "%test_code  = OpFunction %v4f32 None %v4f32_v4f32_function\n%param1     = OpFunctionParameter %v4f32\n%label_func = OpLabel\n"
    "%a          = OpVectorExtractDynamic %f32 %param1 %c_i32_0\n%b          = OpFAdd %f32 %a %a\n%c          = OpFSub %f32 %b %a\n"
    "%ret        = OpVectorInsertDynamic %v4f32 %param1 %c %c_i32_0\nOpReturnValue %ret\nOpFunctionEnd\n"
)
OPMEMBERNAME_PRE_MAIN = "%f3str = OpTypeStruct %f32 %f32 %f32\n"
OPMEMBERNAME_TESTFUN = (
    "%test_code  = OpFunction %v4f32 None %v4f32_v4f32_function\n%param1     = OpFunctionParameter %v4f32\n%label_func = OpLabel\n"
    "%a          = OpVectorExtractDynamic %f32 %param1 %c_i32_0\n%b          = OpFAdd %f32 %a %a\n%c          = OpFSub %f32 %b %a\n"
    "%cstr       = OpCompositeConstruct %f3str %c %c %c\n%d          = OpCompositeExtract %f32 %cstr 0\n"
    "%ret        = OpVectorInsertDynamic %v4f32 %param1 %d %c_i32_0\nOpReturnValue %ret\nOpFunctionEnd\n"
)


DEFAULT_COLORS = ((255, 255, 255, 255), (255, 0, 0, 255), (0, 255, 0, 255), (0, 0, 255, 255))
HALF_COLORS = ((127, 127, 127, 255), (127, 0, 0, 255), (0, 127, 0, 255), (0, 0, 127, 255))
COMPOSITE_OUT_COLORS = ((255, 255, 255, 255), (255, 127, 127, 255), (127, 255, 127, 255), (127, 127, 255, 255))
INVERTED_COLORS = ((0, 0, 0, 255), (0, 255, 255, 255), (255, 0, 255, 255), (255, 255, 0, 255))
LONG_UTF8 = "\U0001F30D"
FUNCTION_START = "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n%param1 = OpFunctionParameter %v4f32\n%lbl    = OpLabel\n"
FUNCTION_END = "OpReturnValue %transformed_param\nOpFunctionEnd\n"


def long_utf8(count):
    return LONG_UTF8 * count


# A reader for the straight-line C++ of the groups whose fragments are string literals: `const char NAME[] = "..."`, `fragments["k"] = ...;`,
# `StringTemplate NAME("...")`, `NAME.specialize(MAP)`, `MAP["k"] = ...;` and `createTestsForAllStages("name", ...)`.
class CppGroup:
    def __init__(self, function):
        src = CPP.read_text()
        start = src.index(f"TestCaseGroup *{function}(")
        start = src.index("{", start)
        depth, i = 0, start
        while True:
            if src[i] == '"':
                i += 1
                while src[i] != '"':
                    i += 2 if src[i] == "\\" else 1
            elif src[i : i + 2] == "//":
                i = src.index("\n", i)
            elif src[i] == "{":
                depth += 1
            elif src[i] == "}":
                depth -= 1
                if depth == 0:
                    break
            i += 1
        self.body = src[start + 1 : i]

    def statements(self):
        text, out, i, begin = self.body, [], 0, 0
        depth = 0
        while i < len(text):
            c = text[i]
            if c == '"':
                i += 1
                while text[i] != '"':
                    i += 2 if text[i] == "\\" else 1
            elif text[i : i + 2] == "//":
                end = text.index("\n", i)
                if not text[begin:i].strip():
                    begin = end
                i = end
                continue
            elif c in "({[":
                depth += 1
            elif c in ")}]":
                depth -= 1
            elif c == ";" and depth == 0:
                out.append(text[begin:i])
                begin = i + 1
            elif c == "}" and depth == 0:
                begin = i + 1
            i += 1
        return out


def decode_literals(text):
    """The concatenated string literals of `text` (C comments and adjacent literals folded), decoded; None if there are no literals."""
    pieces = re.findall(r'"((?:[^"\\]|\\.)*)"', re.sub(r"//[^\n]*", "", text))
    if not pieces:
        return None
    return "".join(piece.encode().decode("unicode_escape") for piece in pieces)


def split_top(text):
    parts, depth, current = [], 0, ""
    for c in text:
        if c in "({[":
            depth += 1
        elif c in ")}]":
            depth -= 1
        if c == "," and depth == 0:
            parts.append(current.strip())
            current = ""
        else:
            current += c
    parts.append(current.strip())
    return parts


def run_group(function, group, colors=None, only=None, want_consts=False):
    """(group, name, fragments, options) for each createTestsForAllStages with a literal name in the function. The fragments are the map and the colours the
    arrays named in the call (`colors`, when given, overrides them)."""
    reader = CppGroup(function)
    consts, templates, maps, color_sets = {}, {}, {"fragments": {}}, {}
    cases = []

    def evaluate(expr):
        expr = expr.strip()
        m = re.fullmatch(r"(\w+)\.specialize\((\w+)\)", expr)
        if m:
            return re.sub(r"\$\{(\w+)\}", lambda k: maps[m.group(2)][k.group(1)], templates[m.group(1)])
        value = ""
        for ident in re.finditer(r'"(?:[^"\\]|\\.)*"|\bstring\((\w+)\)|(?<![\w"])([A-Za-z_]\w*)(?![\w"(])', re.sub(r"//[^\n]*", "", expr)):
            token = ident.group(0)
            if token.startswith('"'):
                value += token[1:-1].encode().decode("unicode_escape")
            elif ident.group(1):
                value += consts[ident.group(1)]
            elif ident.group(2) and ident.group(2) in consts:
                value += consts[ident.group(2)]
        return value

    for statement in reader.statements():
        statement = statement.strip()
        if re.fullmatch(r"\w+\.clear\(\)", statement):
            maps[statement.split(".")[0]].clear()
            continue
        m = re.fullmatch(r"get(Default|HalfFullAlpha|InvertedDefault|HalfColorsFullAlpha|InvertedDefaultColors)(?:Colors)?\((\w+)\)", statement)
        if m:
            color_sets[m.group(2)] = list({"Default": DEFAULT_COLORS, "HalfFullAlpha": HALF_COLORS, "HalfColorsFullAlpha": HALF_COLORS, "InvertedDefault": INVERTED_COLORS, "InvertedDefaultColors": INVERTED_COLORS}[m.group(1)])
            continue
        m = re.fullmatch(r"(\w+)\[(\d)\]\s*=\s*RGBA\(([^)]*)\)", statement)
        if m:
            color_sets.setdefault(m.group(1), [(0, 0, 0, 0)] * 4)[int(m.group(2))] = tuple(int(v) for v in m.group(3).split(","))
            continue
        m = re.fullmatch(r"(\w+)\[(\d)\]\.set(Red|Green|Blue|Alpha)\((\d+)\)", statement)
        if m:
            index = "RGBA".index({"Red": "R", "Green": "G", "Blue": "B", "Alpha": "A"}[m.group(3)])
            color = list(color_sets[m.group(1)][int(m.group(2))])
            color[index] = int(m.group(4))
            color_sets[m.group(1)][int(m.group(2))] = tuple(color)
            continue
        m = re.match(r'(?:const char|const std::string|std::string)\s+(\w+)(?:\[\])?\s*=\s*(.*)', statement, re.S)
        if m:
            consts[m.group(1)] = evaluate(m.group(2))
            continue
        m = re.match(r"(?:const\s+)?StringTemplate\s+(\w+)\((.*)\)$", statement, re.S)
        if m:
            templates[m.group(1)] = decode_literals(m.group(2))
            continue
        m = re.match(r'(\w+)\["(\w+)"\]\s*(\+?=)\s*(.*)', statement, re.S)
        if m:
            target = maps.setdefault(m.group(1), {})
            value = evaluate(m.group(4))
            target[m.group(2)] = (target.get(m.group(2), "") + value) if m.group(3) == "+=" else value
            continue
        m = re.match(r'createTestsForAllStages\((.*)\)$', statement, re.S)
        if m:
            args = split_top(m.group(1))
            literal = re.fullmatch(r'"(\w+)"', args[0])
            if literal and (only is None or literal.group(1) in only) and args[3] in maps:
                in_colors, out_colors = colors if colors else (tuple(color_sets[args[1]]), tuple(color_sets[args[2]]))
                cases.append((group, literal.group(1), dict(maps[args[3]]), {"inc": in_colors, "outc": out_colors, "spv13": False}))
    return (cases, consts) if want_consts else cases

def build_cases():
    """(group, name, fragments, options) in the order of the upstream calls."""
    cases = []
    build_abuse_cases(cases)
    build_debug_cases(cases)
    build_composite_insert_cases(cases)
    build_conditional_branch_cases(cases)
    build_spirv_version_cases(cases)
    build_variable_init_cases(cases)
    build_indexing_cases(cases)
    build_storage16_int_cases(cases)
    build_storage16_float_cases(cases)
    build_storage8_uniform_cases(cases)
    build_storage16_push_constant_float_cases(cases)
    build_storage16_push_constant_int_cases(cases)
    build_storage8_push_constant_cases(cases)
    build_storage16_float32_to_16_cases(cases)
    build_variable_pointer_single_cases(cases)
    build_storage16_float16_to_64_cases(cases)
    build_storage16_float64_to_16_cases(cases)
    build_storage16_push_constant_float64_cases(cases)
    build_storage16_struct_cases(cases)
    build_variable_pointer_nullptr_cases(cases)
    build_variable_pointer_mux_cases(cases)
    build_varying_name_cases(cases)
    build_variable_init_output_cases(cases)
    build_float16_cases(cases)
    build_float16_opconstant_cases(cases)
    build_float16_composite_construct_cases(cases)
    build_float16_composite_insert_extract_cases(cases)
    build_float16_logical_cases(cases)
    build_storage16_mixed_cases(cases)
    build_storage8_struct_cases(cases)
    build_storage8_mixed_cases(cases)
    build_opphi_swap16_cases(cases)
    cases += run_group("createLoopTests", "loop")
    cases += run_group("createSelectionBlockOrderTests", "selection_block_order")
    cases += run_group("createSwitchBlockOrderTests", "switch_block_order")
    cases += run_group("createOpNameTests", "opname")
    cases += run_group("createOpNopTests", "opnop")
    cases += run_group("createFRemTests", "frem")
    cases += run_group("createOpPhiTests", "opphi", only=("out_of_order", "induction", "swap"))
    cases += run_group("createOpUndefTests", "opundef")
    table = CppGroup("createOpUndefTests").body
    table = table[table.index("const NameCodePair tests[] = {") :]
    table = table[: table.index("};")]
    undef_testfun = (
        "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n%param1 = OpFunctionParameter %v4f32\n%label_testfun = OpLabel\n"
        "%undef = OpUndef ${undef_type}\nOpReturnValue %param1\nOpFunctionEnd\n"
    )
    for name, decl, type_ in re.findall(r'\{"(\w+)",\s*((?:"(?:[^"\\]|\\.)*"\s*)+),\s*"([^"]*)"\}', table):
        cases.append(
            (
                "opundef",
                name,
                {"pre_main": decode_literals(decl), "testfun": undef_testfun.replace("${undef_type}", type_)},
                {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False},
            )
        )
    no_contraction = CppGroup("createNoContractionTests").body
    table = no_contraction[no_contraction.index("CaseNameDecoration tests[] = {") :]
    table = table[: table.index("};")]
    _, nc_consts = run_group("createNoContractionTests", "nocontraction", (DEFAULT_COLORS, DEFAULT_COLORS), want_consts=True)
    no_red = tuple((0, g, b, a) for _, g, b, a in HALF_COLORS)
    for name, decoration in re.findall(r'\{"(\w+)",\s*((?:"(?:[^"\\]|\\.)*"\s*)+)\}', table):
        cases.append(
            (
                "nocontraction",
                name,
                {"decoration": decode_literals(decoration), "pre_main": nc_consts["constantsAndTypes"], "testfun": nc_consts["function"]},
                {"inc": no_red, "outc": ((0, 0, 0, 255),) * 4, "spv13": False},
            )
        )
    _, consts = run_group("createDecorationGroupTests", "decoration_group", (HALF_COLORS, HALF_COLORS), want_consts=True)
    table = CppGroup("createDecorationGroupTests").body
    table = table[table.index("CaseNameDecoration tests[] = {") :]
    table = table[: table.index("};")]
    for name, decoration in re.findall(r'\{"(\w+)",\s*((?:"(?:[^"\\]|\\.)*"\s*)+)\}', table):
        decoration = decode_literals(decoration)
        cases.append(
            (
                "decoration_group",
                name,
                {"decoration": consts["decorations"] + decoration, "pre_main": consts["typesAndConstants"], "testfun": consts["function"]},
                {"inc": HALF_COLORS, "outc": HALF_COLORS, "spv13": False},
            )
        )
    return cases


def specialize(template, values):
    def replace(m):
        if m.group(1) in values:
            return values[m.group(1)]
        if m.group(2):
            return ""
        raise KeyError(m.group(1))

    return re.sub(r"\$\{(\w+)(:opt)?\}", replace, template)


def build_conditional_branch_cases(cases):
    """addGraphicsSameLabelsTest of vktSpvAsmConditionalBranchTests.cpp: 128 uints counting up, written through an OpBranchConditional whose two labels are the same."""
    data = struct.pack("<128I", *range(128))
    pre_main = (
        "          %c_u32_128 = OpConstant %u32 128\n"
        "               %true = OpConstantTrue %bool\n"
        "              %false = OpConstantFalse %bool\n"
        " %_arr_uint_uint_128 = OpTypeArray %u32 %c_u32_128\n"
        "             %Output = OpTypeStruct %_arr_uint_uint_128\n"
        "%_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
        "         %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
        "  %_ptr_Uniform_uint = OpTypePointer Uniform %u32\n"
        "             %fp_u32 = OpTypePointer Function %u32\n"
        "        %uint_unused = OpConstant %u32 2863311530\n"
    )
    decoration = (
        "                       OpDecorate %_arr_uint_uint_128 ArrayStride 4\n"
        "                       OpMemberDecorate %Output 0 Offset 0\n"
        "                       OpDecorate %Output BufferBlock\n"
        "                       OpDecorate %dataOutput DescriptorSet 0\n"
        "                       OpDecorate %dataOutput Binding 0\n"
    )
    test_fun = (
        "          %test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
        "              %param = OpFunctionParameter %v4f32\n"
        "              %entry = OpLabel\n"
        "                  %i = OpVariable %fp_u32 Function\n"
        "                       OpStore %i %c_u32_0\n"
        "                       OpBranch %loop\n"
        "               %loop = OpLabel\n"
        "                 %15 = OpLoad %u32 %i\n"
        "                 %lt = OpSLessThan %bool %15 %c_u32_128\n"
        "                       OpLoopMerge %merge %inc None\n"
        "                       OpBranchConditional %lt %write %merge\n"
        "              %write = OpLabel\n"
        "             %uint_i = OpLoad %u32 %i\n"
        "                       OpSelectionMerge %condmerge None\n"
        "                       OpBranchConditional %${condition} %live %live\n"
        "               %live = OpLabel\n"
        "                 %31 = OpAccessChain %_ptr_Uniform_uint %dataOutput %c_u32_0 %uint_i\n"
        "                       OpStore %31 %uint_i\n"
        "                       OpBranch %condmerge\n"
        "               %dead = OpLabel\n"
        "                 %35 = OpAccessChain %_ptr_Uniform_uint %dataOutput %c_u32_0 %uint_i\n"
        "                       OpStore %35 %uint_unused\n"
        "                       OpBranch %condmerge\n"
        "          %condmerge = OpLabel\n"
        "                       OpBranch %inc\n"
        "                %inc = OpLabel\n"
        "                 %37 = OpLoad %u32 %i\n"
        "                 %39 = OpIAdd %u32 %37 %c_u32_1\n"
        "                       OpStore %i %39\n"
        "                       OpBranch %loop\n"
        "              %merge = OpLabel\n"
        "                       OpReturnValue %param\n"
        "                       OpFunctionEnd\n"
    )
    for condition in ("true", "false"):
        frags = {"pre_main": pre_main, "decoration": decoration, "testfun": specialize(test_fun, {"condition": condition})}
        cases.append(("conditional_branch", f"same_labels_{condition}", frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "out": [data]}))


def build_spirv_version_cases(cases):
    """createSpivVersionCheckTests(testCtx, false) of vktSpvAsmSpirvVersionTests.cpp: the simple test function in one stage, every module assembled for the SPIR-V version."""
    test_fun = (
        "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
        "%param1 = OpFunctionParameter %v4f32\n"
        "%label_testfun = OpLabel\n"
        "%a = OpVectorExtractDynamic %f32 %param1 %c_i32_0\n"
        "%b = OpFAdd %f32 %a %a\n"
        "%c = OpFSub %f32 %b %a\n"
        "%ret = OpVectorInsertDynamic %v4f32 %param1 %c %c_i32_0\n"
        "OpReturnValue %ret\n"
        "OpFunctionEnd\n"
    )
    for minor in range(0, 7):
        for operation, stage in (("vertex", "vert"), ("tesselation_evaluation", "tesse"), ("tesselation_control", "tessc"), ("geometry", "geom"), ("fragment", "frag")):
            frags = {"testfun": test_fun}
            if minor > 3:
                frags["GL_entrypoint"] = "%BP_vertexIdInCurrentPatch"
            cases.append(("spirv_version", f"1_{minor}_{operation}", frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "minor": minor, "stages": (stage,), "exact": True}))


VARIABLE_INIT_COMMON = (
    "                      %f32_1 = OpConstant %f32 1\n"
    "                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1\n"
    "                     %matrix = OpTypeMatrix %v4f32 2\n"
    "                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1\n"
    "                    %c_u32_8 = OpConstant %u32 8\n"
    "                 %floatArray = OpTypeArray %f32 %c_u32_8\n"
    "               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1\n"
    "                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32\n"
    "                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1\n"
    "                %numElements = OpConstant %u32 ${count}\n"
    "                %outputArray = OpTypeArray %${type} %numElements\n"
    "                     %Output = OpTypeStruct %outputArray\n"
    "                %_ptr_Output = OpTypePointer StorageBuffer %Output\n"
    "                      %sbPtr = OpTypePointer StorageBuffer %${type}\n"
    "                 %dataOutput = OpVariable %_ptr_Output StorageBuffer\n"
)
VARIABLE_INIT_DECORATIONS = (
    "${arrayStrideDecoration}"
    "                               OpMemberDecorate %Output 0 Offset 0\n"
    "                               OpDecorate %Output Block\n"
    "                               OpDecorate %dataOutput DescriptorSet 0\n"
    "                               OpDecorate %dataOutput Binding 0\n"
    "${extraDecorations:opt}"
    "                               OpDecorate %floatArray ArrayStride 4\n"
    "                               OpMemberDecorate %struct 0 Offset 0\n"
    "                               OpMemberDecorate %struct 1 Offset 32\n"
    "                               OpMemberDecorate %struct 2 Offset 48\n"
    "                               OpMemberDecorate %struct 3 Offset 52\n"
    "                               OpMemberDecorate %struct 4 Offset 56\n"
    "                               OpMemberDecorate %struct 5 Offset 60\n"
)
VARIABLE_INIT_TEST_FUN = (
    "            %test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
    "                %param = OpFunctionParameter %v4f32\n"
    "                %entry = OpLabel\n"
    "                    %i = OpVariable %fp_i32 Function\n"
    "${dataLoad}"
    "                         OpStore %i %c_i32_0\n"
    "                         OpBranch %loop\n"
    "                 %loop = OpLabel\n"
    "                   %15 = OpLoad %i32 %i\n"
    "                   %lt = OpSLessThan %bool %15 %numElements\n"
    "                         OpLoopMerge %merge %inc None\n"
    "                         OpBranchConditional %lt %write %merge\n"
    "                %write = OpLabel\n"
    "                   %30 = OpLoad %i32 %i\n"
    "            %outputPtr = OpAccessChain %sbPtr %dataOutput %c_i32_0 %30\n"
    "                         OpStore %outputPtr %outputData\n"
    "                         OpBranch %inc\n"
    "                  %inc = OpLabel\n"
    "                   %37 = OpLoad %i32 %i\n"
    "                   %39 = OpIAdd %i32 %37 %c_i32_1\n"
    "                         OpStore %i %39\n"
    "                         OpBranch %loop\n"
    "                %merge = OpLabel\n"
    "                         OpReturnValue %param\n"
    "                         OpFunctionEnd\n"
)


def build_variable_init_cases(cases):
    """addGraphicsVariableInitPrivateTest of vktSpvAsmVariableInitTests.cpp: the five private variables initialised from a constant (the `extension` fragment keeps
    growing by one line per case, as upstream's shared `fragments` map does). The output group needs a runner of its own and is not here."""
    extension = ""
    for name, type_name, components in (("float", "f32", 1), ("vec4", "v4f32", 4), ("matrix", "matrix", 8), ("floatarray", "floatArray", 8), ("struct", "struct", 16)):
        num_floats = 128
        values = {
            "type": type_name,
            "arrayStrideDecoration": f"OpDecorate %outputArray ArrayStride {components * 4}\n",
            "count": str(num_floats // components),
            "constData": f"{type_name}_1",
            "variableInit": f"             %f1 = OpVariable %dataPtr Private %{type_name}_1\n",
            "dataLoad": f"     %outputData = OpLoad %{type_name} %f1\n",
        }
        if type_name == "matrix":
            values["extraDecorations"] = "                         OpMemberDecorate %Output 0 ColMajor\n                         OpMemberDecorate %Output 0 MatrixStride 16\n"
        extension += 'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
        frags = {
            "extension": extension,
            "pre_main": specialize(VARIABLE_INIT_COMMON + "              %dataPtr = OpTypePointer Private %${type}\n${variableInit}", values),
            "decoration": specialize(VARIABLE_INIT_DECORATIONS, values),
            "testfun": specialize(VARIABLE_INIT_TEST_FUN, values),
        }
        cases.append(("variable_init/private", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "out": [f32_bytes([1.0] * num_floats)], "ext": ["VK_KHR_storage_buffer_storage_class"]}))


INDEXING_PRE_MAIN = (
    "${intdecl:opt}"
    "                %c_i32_128 = OpConstant %i32 128\n"
    "                   %uint_0 = OpConstant ${idx_uint} 0\n"
    "                 %uint_128 = OpConstant %u32 128\n"
    "                  %uint_32 = OpConstant %u32 32\n"
    "                   %uint_1 = OpConstant ${idx_uint} 1\n"
    "                   %uint_2 = OpConstant ${idx_uint} 2\n"
    "                   %uint_3 = OpConstant ${idx_uint} 3\n"
    "                   %uint_4 = OpConstant ${idx_uint} 4\n"
    "      %_arr_float_uint_128 = OpTypeArray %f32 %uint_128\n"
    "                   %Output = OpTypeStruct %_arr_float_uint_128\n"
    "      %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
    "               %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
    "                    %int_0 = OpConstant ${idx_int} 0\n"
    "      %_arr_v4float_uint_4 = OpTypeArray %v4f32 %uint_4\n"
    " %_arr_mat4v4float_uint_32 = OpTypeArray %_arr_v4float_uint_4 %uint_32\n"
    " %_arr__arr_mat4v4float_uint_32_uint_32 = OpTypeArray %_arr_mat4v4float_uint_32 %uint_32\n"
    "              %InputStruct = OpTypeStruct %_arr__arr_mat4v4float_uint_32_uint_32\n"
    "           %InputStructArr = OpTypeArray %InputStruct %uint_2\n"
    "                    %Input = OpTypeStruct %InputStructArr\n"
    "        %_ptr_buffer_Input = OpTypePointer ${inputstorageclass} %Input\n"
    "                %dataInput = OpVariable %_ptr_buffer_Input ${inputstorageclass}\n"
    "  %_ptr_buffer_InputStruct = OpTypePointer ${inputstorageclass} %InputStruct\n"
    "     %_arr_v4uint_uint_128 = OpTypeArray %v4u32 %uint_128\n"
    "             %DataSelector = OpTypeStruct %_arr_v4uint_uint_128\n"
    "%_ptr_Uniform_DataSelector = OpTypePointer Uniform %DataSelector\n"
    "                 %selector = OpVariable %_ptr_Uniform_DataSelector Uniform\n"
    "      %_ptr_Uniform_uint32 = OpTypePointer Uniform %u32\n"
    "       %_ptr_Uniform_float = OpTypePointer Uniform %f32\n"
    "       ${ptr_buffer_float:opt}\n"
)
INDEXING_DECORATION = (
    "OpDecorate %_arr_float_uint_128 ArrayStride 4\n"
    "OpMemberDecorate %Output 0 Offset 0\n"
    "OpDecorate %Output BufferBlock\n"
    "OpDecorate %dataOutput DescriptorSet 0\n"
    "OpDecorate %dataOutput Binding 2\n"
    "OpDecorate %_arr_v4float_uint_4 ArrayStride 16\n"
    "OpDecorate %_arr_mat4v4float_uint_32 ArrayStride 64\n"
    "OpDecorate %_arr__arr_mat4v4float_uint_32_uint_32 ArrayStride 2048\n"
    "OpMemberDecorate %InputStruct 0 Offset 0\n"
    "OpDecorate %InputStructArr ArrayStride 65536\n"
    "OpDecorate %Input ${inputdecoration}\n"
    "OpMemberDecorate %Input 0 Offset 0\n"
    "OpDecorate %dataInput DescriptorSet 0\n"
    "OpDecorate %dataInput Binding 0\n"
    "OpDecorate %_ptr_buffer_InputStruct ArrayStride 65536\n"
    "OpDecorate %_arr_v4uint_uint_128 ArrayStride 16\n"
    "OpMemberDecorate %DataSelector 0 Offset 0\n"
    "OpDecorate %DataSelector BufferBlock\n"
    "OpDecorate %selector DescriptorSet 0\n"
    "OpDecorate %selector Binding 1\n"
)
INDEXING_TEST_FUN = (
    "        %test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
    "            %param = OpFunctionParameter %v4f32\n"
    "            %entry = OpLabel\n"
    "                %i = OpVariable %fp_i32 Function\n"
    "                     OpStore %i %c_i32_0\n"
    "                     OpBranch %loop\n"
    "             %loop = OpLabel\n"
    "               %15 = OpLoad %i32 %i\n"
    "               %lt = OpSLessThan %bool %15 %c_i32_128\n"
    "                     OpLoopMerge %merge %inc None\n"
    "                     OpBranchConditional %lt %write %merge\n"
    "            %write = OpLabel\n"
    "            %int_i = OpLoad %i32 %i\n"
    "               %39 = OpAccessChain %_ptr_Uniform_uint32 %selector %int_0 %int_i %uint_0\n"
    "               %40 = OpLoad %u32 %39\n"
    "               %43 = OpAccessChain %_ptr_Uniform_uint32 %selector %int_0 %int_i %uint_1\n"
    "               %44 = OpLoad %u32 %43\n"
    "               %47 = OpAccessChain %_ptr_Uniform_uint32 %selector %int_0 %int_i %uint_2\n"
    "               %48 = OpLoad %u32 %47\n"
    "               %51 = OpAccessChain %_ptr_Uniform_uint32 %selector %int_0 %int_i %uint_3\n"
    "               %52 = OpLoad %u32 %51\n"
    "               %i0 = ${convert} ${idx_uint} %40\n"
    "               %i1 = ${convert} ${idx_uint} %44\n"
    "               %i2 = ${convert} ${idx_uint} %48\n"
    "               %i3 = ${convert} ${idx_uint} %52\n"
    "%inputFirstElement = OpAccessChain %_ptr_buffer_InputStruct %dataInput %uint_0 %uint_0\n"
    "               %54 = ${accesschain}\n"
    "               %55 = OpLoad %f32 %54\n"
    "               %56 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %int_i\n"
    "                     OpStore %56 %55\n"
    "                     OpBranch %inc\n"
    "              %inc = OpLabel\n"
    "               %67 = OpLoad %i32 %i\n"
    "               %69 = OpIAdd %i32 %67 %c_i32_1\n"
    "                     OpStore %i %69\n"
    "                     OpBranch %loop\n"
    "            %merge = OpLabel\n"
    "                     OpReturnValue %param\n"
    "                     OpFunctionEnd\n"
)


def build_indexing_cases(cases):
    """addGraphicsIndexingStructTests of vktSpvAsmIndexingTests.cpp (indexing.input.struct): the data of a case is drawn in Rust from the stream seeded with the hash of
    "input", as the compute twin does. Each case also runs with 64 bit indexing. indexing.output.component needs the interface machinery and is not here."""
    for chain, access_chain, decoration, storage_class in (
        ("opaccesschain", "OpAccessChain %_ptr_Uniform_float %inputFirstElement %int_0 %i0 %i1 %i2 %i3\n", "BufferBlock", "Uniform"),
        ("opinboundsaccesschain", "OpInBoundsAccessChain %_ptr_Uniform_float %inputFirstElement %int_0 %i0 %i1 %i2 %i3\n", "BufferBlock", "Uniform"),
        ("opptraccesschain", "OpPtrAccessChain %_ptr_StorageBuffer_float %inputFirstElement %uint_1 %int_0 %i0 %i1 %i2 %i3\n", "Block", "StorageBuffer"),
    ):
        for idx_size in (16, 32, 64):
            for sign in (0, 1):
                values = {"convert": "OpCopyObject", "idx_uint": f"%u{idx_size}", "idx_int": ("%i" if sign else "%u") + str(idx_size), "accesschain": access_chain, "inputdecoration": decoration, "inputstorageclass": storage_class}
                frags, flags, extensions = {}, [], []
                if idx_size == 16:
                    frags["capability"] = "OpCapability Int16\n"
                    values["convert"] = "OpUConvert"
                    values["intdecl"] = "                      %u16 = OpTypeInt 16 0\n                      %i16 = OpTypeInt 16 1\n"
                    flags.append("int16=1")
                elif idx_size == 64:
                    frags["capability"] = "OpCapability Int64\n"
                    values["convert"] = "OpUConvert"
                    values["intdecl"] = "                      %u64 = OpTypeInt 64 0\n                      %i64 = OpTypeInt 64 1\n"
                    flags.append("int64=1")
                element = 0
                if chain == "opptraccesschain":
                    values["ptr_buffer_float"] = "%_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %f32"
                    frags["capability"] = frags.get("capability", "") + "OpCapability VariablePointersStorageBuffer"
                    frags["extension"] = 'OpExtension "SPV_KHR_variable_pointers"\nOpExtension "SPV_KHR_storage_buffer_storage_class"'
                    extensions.append("VK_KHR_variable_pointers")
                    flags.append("varptr=1")
                    element = 1
                frags["pre_main"] = specialize(INDEXING_PRE_MAIN, values)
                frags["decoration"] = specialize(INDEXING_DECORATION, values)
                frags["testfun"] = specialize(INDEXING_TEST_FUN, values)
                name = f"{chain}_{'s' if sign else 'u'}{idx_size}"
                for suffix, indexing_flag in (("", ()), ("_64bit_indexing", ("i64idx=1",))):
                    gen = ";".join(("gen=indexing", f"elem={element}", *flags, *indexing_flag))
                    cases.append(("indexing/input/struct", name + suffix, dict(frags), {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": extensions, "gen": gen}))


STORAGE16_CAPABILITIES = (("uniform_buffer_block", "StorageUniformBufferBlock16", "BufferBlock", "sb16=1"), ("uniform", "StorageUniform16", "Block", "ub16=1;uin=1"))
STORAGE16_INT_FACTS = (("sint", "%i32", "%i16", "OpSConvert", "1"), ("uint", "%u32", "%u16", "OpUConvert", "0"))


def storage16_loop(count_const, access_src, load, convert, store_access, store_type_comment=""):
    return (
        "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
        "    %param = OpFunctionParameter %v4f32\n"
        "%entry = OpLabel\n"
        "    %i = OpVariable %fp_i32 Function\n"
        "         OpStore %i %c_i32_0\n"
        "         OpBranch %loop\n"
        " %loop = OpLabel\n"
        "   %15 = OpLoad %i32 %i\n"
        f"   %lt = OpSLessThan %bool %15 {count_const}\n"
        "         OpLoopMerge %merge %inc None\n"
        "         OpBranchConditional %lt %write %merge\n"
        "%write = OpLabel\n"
        "   %30 = OpLoad %i32 %i\n"
        + access_src + load + convert + store_access +
        "         OpBranch %inc\n"
        "  %inc = OpLabel\n"
        "   %37 = OpLoad %i32 %i\n"
        "   %39 = OpIAdd %i32 %37 %c_i32_1\n"
        "         OpStore %i %39\n"
        "         OpBranch %loop\n"
        "%merge = OpLabel\n"
        "         OpReturnValue %param\n"
        "OpFunctionEnd\n"
    )


def build_storage16_int_cases(cases):
    """addGraphics16BitStorageUniformInt16To32Group (uniform_int_16_to_32) and addGraphics16BitStorageUniformInt32To16Group (uniform_int_32_to_16) of
    vktSpvAsm16bitStorageTests.cpp: the data and expected outputs are made in Rust (graphics_storage_data.rs) from the group name's seed."""
    extension = 'OpExtension "SPV_KHR_16bit_storage"'
    colors = {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"]}

    scalar_pre = (
        "${itype16} = OpTypeInt 16 ${signed}\n"
        "%c_i32_256 = OpConstant %i32 256\n"
        "%c_i32_ci  = OpConstant %i32 ${constarrayidx}\n"
        "   %up_i32 = OpTypePointer Uniform ${itype32}\n"
        "   %up_i16 = OpTypePointer Uniform ${itype16}\n"
        "   %ra_i32 = OpTypeArray ${itype32} %c_i32_256\n"
        "   %ra_i16 = OpTypeArray ${itype16} %c_i32_256\n"
        "   %SSBO32 = OpTypeStruct %ra_i32\n"
        "   %SSBO16 = OpTypeStruct %ra_i16\n"
        "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
        "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
        "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
        "   %ssbo16 = OpVariable %up_SSBO16 Uniform\n"
    )
    scalar_decoration = (
        "OpDecorate %ra_i32 ArrayStride 4\n"
        "OpDecorate %ra_i16 ArrayStride ${arraystride}\n"
        "OpMemberDecorate %SSBO32 0 Offset 0\n"
        "OpMemberDecorate %SSBO16 0 Offset 0\n"
        "OpDecorate %SSBO32 BufferBlock\n"
        "OpDecorate %SSBO16 ${indecor}\n"
        "OpDecorate %ssbo32 DescriptorSet 0\n"
        "OpDecorate %ssbo16 DescriptorSet 0\n"
        "OpDecorate %ssbo32 Binding 1\n"
        "OpDecorate %ssbo16 Binding 0\n"
    )
    scalar_fun = storage16_loop(
        "%c_i32_256",
        "  %src = OpAccessChain %up_i16 %ssbo16 %c_i32_0 %${arrayindex}\n",
        "%val16 = OpLoad ${itype16} %src\n",
        "%val32 = ${convert} ${itype32} %val16\n",
        "  %dst = OpAccessChain %up_i32 %ssbo32 %c_i32_0 %30\n         OpStore %dst %val32\n",
    )
    vec_pre = (
        "${itype16} = OpTypeInt 16 ${signed}\n"
        "%c_i32_128 = OpConstant %i32 128\n"
        "%c_i32_ci  = OpConstant %i32 ${constarrayidx}\n"
        "%v2itype16 = OpTypeVector ${itype16} 2\n"
        " %up_v2i32 = OpTypePointer Uniform ${v2itype32}\n"
        " %up_v2i16 = OpTypePointer Uniform %v2itype16\n"
        " %ra_v2i32 = OpTypeArray ${v2itype32} %c_i32_128\n"
        " %ra_v2i16 = OpTypeArray %v2itype16 %c_i32_128\n"
        "   %SSBO32 = OpTypeStruct %ra_v2i32\n"
        "   %SSBO16 = OpTypeStruct %ra_v2i16\n"
        "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
        "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
        "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
        "   %ssbo16 = OpVariable %up_SSBO16 Uniform\n"
    )
    vec_decoration = (
        "OpDecorate %ra_v2i32 ArrayStride 8\n"
        "OpDecorate %ra_v2i16 ArrayStride ${arraystride}\n"
        "OpMemberDecorate %SSBO32 0 Offset 0\n"
        "OpMemberDecorate %SSBO16 0 Offset 0\n"
        "OpDecorate %SSBO32 BufferBlock\n"
        "OpDecorate %SSBO16 ${indecor}\n"
        "OpDecorate %ssbo32 DescriptorSet 0\n"
        "OpDecorate %ssbo16 DescriptorSet 0\n"
        "OpDecorate %ssbo32 Binding 1\n"
        "OpDecorate %ssbo16 Binding 0\n"
    )
    vec_fun = storage16_loop(
        "%c_i32_128",
        "  %src = OpAccessChain %up_v2i16 %ssbo16 %c_i32_0 %${arrayindex}\n",
        "%val16 = OpLoad %v2itype16 %src\n",
        "%val32 = ${convert} ${v2itype32} %val16\n",
        "  %dst = OpAccessChain %up_v2i32 %ssbo32 %c_i32_0 %30\n         OpStore %dst %val32\n",
    )
    categories = (("scalar", scalar_pre, scalar_decoration, scalar_fun, 1), ("vector", vec_pre, vec_decoration, vec_fun, 2))
    min_array_stride = (2, 16)
    for cat_name, pre, decoration, fun, num_elements in categories:
        for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
            for fact_name, type32, type16, opcode, signed in STORAGE16_INT_FACTS:
                for use_const, const_idx in ((False, 0), (True, 4), (True, 5), (True, 6)):
                    array_stride = max(num_elements * 2, min_array_stride[cap_idx])
                    values = {
                        "cap": cap, "indecor": decor, "arraystride": str(array_stride), "itype32": type32, "v2itype32": "%v2" + type32[1:],
                        "itype16": type16, "signed": signed, "convert": opcode, "constarrayidx": str(const_idx),
                        "arrayindex": "c_i32_ci" if use_const else "30",
                    }
                    name = f"{cap_name}_{cat_name}_{fact_name}" + (f"_const_idx_{const_idx}" if use_const else "")
                    frags = {
                        "extension": extension, "pre_main": specialize(pre, values), "testfun": specialize(fun, values),
                        "capability": f"OpCapability {cap}\n", "decoration": specialize(decoration, values),
                    }
                    gen = f"gen=s16i_16to32;seed=uniform_int_16_to_32;vec={num_elements - 1};cap={cap_idx};signed={signed};cidx={const_idx if use_const else -1};{cap_flags}"
                    cases.append(("16bit_storage/uniform_int_16_to_32", name, frags, {**colors, "gen": gen}))

    pre32 = (
        "${itype16} = OpTypeInt 16 ${signed}\n"
        "%c_i32_256 = OpConstant %i32 256\n"
        "   %up_i32 = OpTypePointer Uniform ${itype32}\n"
        "   %up_i16 = OpTypePointer Uniform ${itype16}\n"
        "   %ra_i32 = OpTypeArray ${itype32} %c_i32_256\n"
        "   %ra_i16 = OpTypeArray ${itype16} %c_i32_256\n"
        "   %SSBO32 = OpTypeStruct %ra_i32\n"
        "   %SSBO16 = OpTypeStruct %ra_i16\n"
        "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
        "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
        "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
        "   %ssbo16 = OpVariable %up_SSBO16 Uniform\n"
    )
    decoration32 = (
        "OpDecorate %ra_i32 ArrayStride ${arraystride}\n"
        "OpDecorate %ra_i16 ArrayStride 2\n"
        "OpMemberDecorate %SSBO32 0 Offset 0\n"
        "OpMemberDecorate %SSBO16 0 Offset 0\n"
        "OpDecorate %SSBO32 ${indecor}\n"
        "OpDecorate %SSBO16 BufferBlock\n"
        "OpDecorate %ssbo32 DescriptorSet 0\n"
        "OpDecorate %ssbo16 DescriptorSet 0\n"
        "OpDecorate %ssbo32 Binding 0\n"
        "OpDecorate %ssbo16 Binding 1\n"
    )
    fun32 = storage16_loop(
        "%c_i32_256",
        "  %src = OpAccessChain %up_i32 %ssbo32 %c_i32_0 %30\n",
        "%val32 = OpLoad ${itype32} %src\n",
        "%val16 = ${convert} ${itype16} %val32\n",
        "  %dst = OpAccessChain %up_i16 %ssbo16 %c_i32_0 %30\n         OpStore %dst %val16\n",
    )
    vec_pre32 = (
        "${itype16} = OpTypeInt 16 ${signed}\n"
        " %c_i32_64 = OpConstant %i32 64\n"
        "%v4itype16 = OpTypeVector ${itype16} 4\n"
        " %up_v4i32 = OpTypePointer Uniform ${v4itype32}\n"
        " %up_v4i16 = OpTypePointer Uniform %v4itype16\n"
        " %ra_v4i32 = OpTypeArray ${v4itype32} %c_i32_64\n"
        " %ra_v4i16 = OpTypeArray %v4itype16 %c_i32_64\n"
        "   %SSBO32 = OpTypeStruct %ra_v4i32\n"
        "   %SSBO16 = OpTypeStruct %ra_v4i16\n"
        "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
        "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
        "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
        "   %ssbo16 = OpVariable %up_SSBO16 Uniform\n"
    )
    vec_decoration32 = (
        "OpDecorate %ra_v4i32 ArrayStride 16\n"
        "OpDecorate %ra_v4i16 ArrayStride 8\n"
        "OpMemberDecorate %SSBO32 0 Offset 0\n"
        "OpMemberDecorate %SSBO16 0 Offset 0\n"
        "OpDecorate %SSBO32 ${indecor}\n"
        "OpDecorate %SSBO16 BufferBlock\n"
        "OpDecorate %ssbo32 DescriptorSet 0\n"
        "OpDecorate %ssbo16 DescriptorSet 0\n"
        "OpDecorate %ssbo32 Binding 0\n"
        "OpDecorate %ssbo16 Binding 1\n"
    )
    vec_fun32 = storage16_loop(
        "%c_i32_64",
        "  %src = OpAccessChain %up_v4i32 %ssbo32 %c_i32_0 %30\n",
        "%val32 = OpLoad ${v4itype32} %src\n",
        "%val16 = ${convert} %v4itype16 %val32\n",
        "  %dst = OpAccessChain %up_v4i16 %ssbo16 %c_i32_0 %30\n         OpStore %dst %val16\n",
    )
    for cat_name, pre, decoration, fun in (("scalar", pre32, decoration32, fun32), ("vector", vec_pre32, vec_decoration32, vec_fun32)):
        for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
            for fact_name, type32, type16, opcode, signed in STORAGE16_INT_FACTS:
                values = {
                    "cap": cap, "indecor": decor, "itype32": type32, "v4itype32": "%v4" + type32[1:], "itype16": type16, "signed": signed,
                    "convert": opcode, "arraystride": str((4, 16)[cap_idx]),
                }
                frags = {
                    "extension": extension, "pre_main": specialize(pre, values), "testfun": specialize(fun, values),
                    "capability": f"OpCapability {cap}\n", "decoration": specialize(decoration, values),
                }
                gen = f"gen=s16i_32to16;seed=uniform_int_32_to_16;vec={int(cat_name == 'vector')};cap={cap_idx};{cap_flags}"
                cases.append(("16bit_storage/uniform_int_32_to_16", f"{cap_name}_{cat_name}_{fact_name}", frags, {**colors, "gen": gen}))


def build_storage16_float_cases(cases):
    """addGraphics16BitStorageUniformFloat16To32Group (uniform_float_16_to_32): scalar, vec2 and 4x2 matrix of binary16 widened to binary32, compared with check32BitFloats."""
    extension = 'OpExtension "SPV_KHR_16bit_storage"'
    colors = {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"]}

    def storage_decoration(ra32, ra16, stride32, stride16_template, extra=""):
        return (
            f"OpDecorate {ra32} ArrayStride {stride32}\n"
            f"OpDecorate {ra16} ArrayStride {stride16_template}\n"
            + extra +
            "OpMemberDecorate %SSBO32 0 Offset 0\n"
            "OpMemberDecorate %SSBO16 0 Offset 0\n"
            "OpDecorate %SSBO32 BufferBlock\n"
            "OpDecorate %SSBO16 ${indecor}\n"
            "OpDecorate %ssbo32 DescriptorSet 0\n"
            "OpDecorate %ssbo16 DescriptorSet 0\n"
            "OpDecorate %ssbo32 Binding 1\n"
            "OpDecorate %ssbo16 Binding 0\n"
        )

    scalar_pre = (
        "      %f16 = OpTypeFloat 16\n"
        "%c_i32_256 = OpConstant %i32 256\n"
        " %c_i32_ci = OpConstant %i32 ${constarrayidx}\n"
        "   %up_f32 = OpTypePointer Uniform %f32\n"
        "   %up_f16 = OpTypePointer Uniform %f16\n"
        "   %ra_f32 = OpTypeArray %f32 %c_i32_256\n"
        "   %ra_f16 = OpTypeArray %f16 %c_i32_256\n"
        "   %SSBO32 = OpTypeStruct %ra_f32\n"
        "   %SSBO16 = OpTypeStruct %ra_f16\n"
        "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
        "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
        "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
        "   %ssbo16 = OpVariable %up_SSBO16 Uniform\n"
    )
    scalar_decoration = storage_decoration("%ra_f32", "%ra_f16", 4, "${arraystride}")
    scalar_fun = storage16_loop(
        "%c_i32_256",
        "  %src = OpAccessChain %up_f16 %ssbo16 %c_i32_0 %${arrayindex}\n",
        "%val16 = OpLoad %f16 %src\n",
        "%val32 = OpFConvert %f32 %val16\n",
        "  %dst = OpAccessChain %up_f32 %ssbo32 %c_i32_0 %30\n         OpStore %dst %val32\n",
    )
    vec_pre = (
        "      %f16 = OpTypeFloat 16\n"
        "%c_i32_128 = OpConstant %i32 128\n"
        "%c_i32_ci  = OpConstant %i32 ${constarrayidx}\n"
        "     %v2f16 = OpTypeVector %f16 2\n"
        " %up_v2f32 = OpTypePointer Uniform %v2f32\n"
        " %up_v2f16 = OpTypePointer Uniform %v2f16\n"
        " %ra_v2f32 = OpTypeArray %v2f32 %c_i32_128\n"
        " %ra_v2f16 = OpTypeArray %v2f16 %c_i32_128\n"
        "   %SSBO32 = OpTypeStruct %ra_v2f32\n"
        "   %SSBO16 = OpTypeStruct %ra_v2f16\n"
        "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
        "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
        "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
        "   %ssbo16 = OpVariable %up_SSBO16 Uniform\n"
    )
    vec_decoration = storage_decoration("%ra_v2f32", "%ra_v2f16", 8, "${arraystride}")
    vec_fun = storage16_loop(
        "%c_i32_128",
        "  %src = OpAccessChain %up_v2f16 %ssbo16 %c_i32_0 %${arrayindex}\n",
        "%val16 = OpLoad %v2f16 %src\n",
        "%val32 = OpFConvert %v2f32 %val16\n",
        "  %dst = OpAccessChain %up_v2f32 %ssbo32 %c_i32_0 %30\n         OpStore %dst %val32\n",
    )
    for kind, pre, decoration, fun, strides in (("scalar", scalar_pre, scalar_decoration, scalar_fun, (2, 16)), ("vector", vec_pre, vec_decoration, vec_fun, (4, 16))):
        for use_const, const_idx in ((False, 0), (True, 4), (True, 5), (True, 6)):
            for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
                values = {"cap": cap, "indecor": decor, "arraystride": str(strides[cap_idx]), "constarrayidx": str(const_idx), "arrayindex": "c_i32_ci" if use_const else "30"}
                frags = {
                    "extension": extension, "capability": f"OpCapability {cap}\n", "decoration": specialize(decoration, values),
                    "pre_main": specialize(pre, values), "testfun": specialize(fun, values),
                }
                name = f"{cap_name}_{kind}_float" + (f"_const_idx_{const_idx}" if use_const else "")
                gen = f"gen=s16f_16to32;seed=uniform_float_16_to_32;kind={kind};cap={cap_idx};cidx={const_idx if use_const else -1};vf32=1;{cap_flags}"
                cases.append(("16bit_storage/uniform_float_16_to_32", name, frags, {**colors, "gen": gen}))

    matrix_pre = (
        " %c_i32_32 = OpConstant %i32 32\n"
        "      %f16 = OpTypeFloat 16\n"
        "    %v2f16 = OpTypeVector %f16 2\n"
        "  %m4x2f32 = OpTypeMatrix %v2f32 4\n"
        "  %m4x2f16 = OpTypeMatrix %v2f16 4\n"
        " %up_v2f32 = OpTypePointer Uniform %v2f32\n"
        " %up_v2f16 = OpTypePointer Uniform %v2f16\n"
        "%a8m4x2f32 = OpTypeArray %m4x2f32 %c_i32_32\n"
        "%a8m4x2f16 = OpTypeArray %m4x2f16 %c_i32_32\n"
        "   %SSBO32 = OpTypeStruct %a8m4x2f32\n"
        "   %SSBO16 = OpTypeStruct %a8m4x2f16\n"
        "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
        "%up_SSBO16 = OpTypePointer Uniform %SSBO16\n"
        "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
        "   %ssbo16 = OpVariable %up_SSBO16 Uniform\n"
    )
    matrix_decoration = (
        "OpDecorate %a8m4x2f32 ArrayStride 32\n"
        "OpDecorate %a8m4x2f16 ArrayStride 64\n"
        "OpMemberDecorate %SSBO32 0 Offset 0\n"
        "OpMemberDecorate %SSBO32 0 ColMajor\n"
        "OpMemberDecorate %SSBO32 0 MatrixStride 8\n"
        "OpMemberDecorate %SSBO16 0 Offset 0\n"
        "OpMemberDecorate %SSBO16 0 ColMajor\n"
        "OpMemberDecorate %SSBO16 0 MatrixStride 16\n"
        "OpDecorate %SSBO32 BufferBlock\n"
        "OpDecorate %SSBO16 ${indecor}\n"
        "OpDecorate %ssbo32 DescriptorSet 0\n"
        "OpDecorate %ssbo16 DescriptorSet 0\n"
        "OpDecorate %ssbo32 Binding 1\n"
        "OpDecorate %ssbo16 Binding 0\n"
    )
    columns = range(4)
    matrix_access = (
        "  %write = OpLabel\n"
        "     %30 = OpLoad %i32 %i\n"
        + "".join(f"  %src_{c} = OpAccessChain %up_v2f16 %ssbo16 %c_i32_0 %30 %c_i32_{c}\n" for c in columns)
        + "".join(f"%val16_{c} = OpLoad %v2f16 %src_{c}\n" for c in columns)
        + "".join(f"%val32_{c} = OpFConvert %v2f32 %val16_{c}\n" for c in columns)
        + "".join(f"  %dst_{c} = OpAccessChain %up_v2f32 %ssbo32 %c_i32_0 %30 %c_i32_{c}\n" for c in columns)
        + "".join(f"           OpStore %dst_{c} %val32_{c}\n" for c in columns)
        + "           OpBranch %inc\n"
    )
    matrix_fun = (
        "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
        "    %param = OpFunctionParameter %v4f32\n"
        "%entry = OpLabel\n"
        "    %i = OpVariable %fp_i32 Function\n"
        "         OpStore %i %c_i32_0\n"
        "         OpBranch %loop\n"
        " %loop = OpLabel\n"
        "   %15 = OpLoad %i32 %i\n"
        "   %lt = OpSLessThan %bool %15 %c_i32_32\n"
        "         OpLoopMerge %merge %inc None\n"
        "         OpBranchConditional %lt %write %merge\n"
        + matrix_access +
        "  %inc = OpLabel\n"
        "   %37 = OpLoad %i32 %i\n"
        "   %39 = OpIAdd %i32 %37 %c_i32_1\n"
        "         OpStore %i %39\n"
        "         OpBranch %loop\n"
        "%merge = OpLabel\n"
        "         OpReturnValue %param\n"
        "OpFunctionEnd\n"
    )
    for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
        values = {"indecor": decor}
        frags = {
            "extension": extension, "capability": f"OpCapability {cap}\n", "decoration": specialize(matrix_decoration, values),
            "pre_main": matrix_pre, "testfun": matrix_fun,
        }
        gen = f"gen=s16f_16to32;seed=uniform_float_16_to_32;kind=matrix;cap={cap_idx};cidx=-1;vf32=1;{cap_flags}"
        cases.append(("16bit_storage/uniform_float_16_to_32", f"{cap_name}_matrix_float", frags, {**colors, "gen": gen}))


STORAGE8_CPP = CPP.with_name("vktSpvAsm8bitStorageTests.cpp")


def cpp_function_body(text, name):
    start = text.index(f"void {name}(")
    return text[start : text.index("\n}\n", start)]


def cpp_string_templates(body):
    """The `const StringTemplate X("...")` literals of a function, by name."""
    return {
        m.group(1): decode_literals(m.group(2))
        for m in re.finditer(r'const StringTemplate (\w+)\(((?:\s*"(?:[^"\\]|\\.)*"\s*)+)\);', body)
    }


def build_storage8_uniform_cases(cases):
    """addGraphics8BitStorageUniformInt32To8Group, ...Int8To32Group, ...Int16To8Group and ...Int8To16Group of vktSpvAsm8bitStorageTests.cpp: the templates are read out of the C++,
    the inputs are drawn in Rust per case and the expected bytes are the low byte of each result element that the C++ `checkUniformsArray` looks at, selected with a mask."""
    text = STORAGE8_CPP.read_text(encoding="utf-8")
    constant_indices = ((False, 0), (True, 4), (True, 5), (True, 6))
    for function, group, wide, narrow_to_wide, extension_lines, ext in (
        ("addGraphics8BitStorageUniformInt32To8Group", "storagebuffer_int_32_to_8", 32, False, 'OpExtension "SPV_KHR_storage_buffer_storage_class"\nOpExtension "SPV_KHR_8bit_storage"', ["VK_KHR_8bit_storage"]),
        ("addGraphics8BitStorageUniformInt8To32Group", "uniform_int_8_to_32", 32, True, 'OpExtension "SPV_KHR_storage_buffer_storage_class"\nOpExtension "SPV_KHR_8bit_storage"', ["VK_KHR_8bit_storage"]),
        ("addGraphics8BitStorageUniformInt16To8Group", "storagebuffer_int_16_to_8", 16, False, 'OpCapability StorageUniform16\nOpExtension "SPV_KHR_storage_buffer_storage_class"\nOpExtension "SPV_KHR_8bit_storage"\nOpExtension "SPV_KHR_16bit_storage"\n', ["VK_KHR_8bit_storage", "VK_KHR_16bit_storage"]),
        ("addGraphics8BitStorageUniformInt8To16Group", "uniform_int_8_to_16", 16, True, 'OpCapability StorageUniform16\nOpExtension "SPV_KHR_storage_buffer_storage_class"\nOpExtension "SPV_KHR_8bit_storage"\nOpExtension "SPV_KHR_16bit_storage"\n', ["VK_KHR_8bit_storage", "VK_KHR_16bit_storage"]),
    ):
        templates = cpp_string_templates(cpp_function_body(text, function))
        categories = (("scalar", "scalar", 1), ("vector", "vec", 4 if not narrow_to_wide else 2))
        comps = ",".join(str(c[2]) for c in categories)
        flags = "ub8=1;uin=1" + (";ub16=1" if wide == 16 else "")
        for cat_idx, (cat_name, prefix, num_elements) in enumerate(categories):
            for fact_name, signed, convert in (("sint", "1", "OpSConvert"), ("uint", "0", "OpUConvert")):
                for use_const, const_idx in constant_indices if narrow_to_wide else ((False, 0),):
                    values = {
                        "cap": "UniformAndStorageBuffer8BitAccess",
                        f"itype{wide}": ("%i" if signed == "1" else "%u") + str(wide),
                        f"v{num_elements}itype{wide}": f"%v{num_elements}" + ("i" if signed == "1" else "u") + str(wide),
                        "itype8": "%i8" if signed == "1" else "%u8",
                        "signed": signed,
                        "convert": convert,
                        "constarrayidx": str(const_idx),
                        "arrayindex": "c_i32_ci" if use_const else "30",
                    }
                    frags = {
                        "extension": extension_lines,
                        "pre_main": specialize(templates[f"{prefix}PreMain"], values),
                        "testfun": specialize(templates[f"{prefix}TestFunc"], values),
                        "capability": "OpCapability UniformAndStorageBuffer8BitAccess\n",
                        "decoration": specialize(templates[f"{prefix}Decoration"], values),
                    }
                    name = f"uniform_{cat_name}_{fact_name}" + (f"_const_idx_{const_idx}" if use_const else "")
                    exact = int(not narrow_to_wide and wide == 32 and cat_name == "vector")
                    narrow, res = (8, wide // 8) if narrow_to_wide else (wide, 1)
                    gen = f"gen=s8u;seed={group};orig={narrow // 8};res={res};comps={comps};cat={cat_idx};cidx={const_idx if use_const else -1};exact={exact};{flags}"
                    cases.append((f"8bit_storage/{group}", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ext, "gen": gen}))


STORAGE16_CPP = CPP.with_name("vktSpvAsm16bitStorageTests.cpp")


def build_storage16_push_constant_float_cases(cases):
    """addGraphics16BitStoragePushConstantFloat16To32Group (push_constant_float_16_to_32): 64 binary16 push constants widened and stored. The test function is read out of the C++."""
    text = STORAGE16_CPP.read_text(encoding="utf-8")
    test_fun = cpp_string_templates(cpp_function_body(text, "addGraphics16BitStoragePushConstantFloat16To32Group"))["testFun"]
    common_decoration = (
        "OpDecorate %SSBO32 BufferBlock\n"
        "OpMemberDecorate %SSBO32 0 Offset 0\n"
        "OpDecorate %PC16 Block\n"
        "OpMemberDecorate %PC16 0 Offset 0\n"
        "OpDecorate %ssbo32 DescriptorSet 0\n"
        "OpDecorate %ssbo32 Binding 0\n"
    )
    kinds = {
        "scalar": (
            "      %f16 = OpTypeFloat 16\n"
            " %c_i32_64 = OpConstant %i32 64\n"
            " %c_i32_ci = OpConstant %i32 ${constarrayidx}\n"
            "  %a64f16 = OpTypeArray %f16 %c_i32_64\n"
            "  %a64f32 = OpTypeArray %f32 %c_i32_64\n"
            "   %pp_f16 = OpTypePointer PushConstant %f16\n"
            "   %up_f32 = OpTypePointer Uniform %f32\n"
            "   %SSBO32 = OpTypeStruct %a64f32\n"
            "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
            "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
            "     %PC16 = OpTypeStruct %a64f16\n"
            "  %pp_PC16 = OpTypePointer PushConstant %PC16\n"
            "     %pc16 = OpVariable %pp_PC16 PushConstant\n",
            "OpDecorate %a64f16 ArrayStride 2\nOpDecorate %a64f32 ArrayStride 4\n" + common_decoration,
            {"count": "%c_i32_64", "pp_type16": "%pp_f16", "f_type16": "%f16", "f_type32": "%f32", "up_type32": "%up_f32"},
        ),
        "vector": (
            "      %f16 = OpTypeFloat 16\n"
            "    %v4f16 = OpTypeVector %f16 4\n"
            " %c_i32_16 = OpConstant %i32 16\n"
            " %c_i32_ci = OpConstant %i32 ${constarrayidx}\n"
            " %a16v4f16 = OpTypeArray %v4f16 %c_i32_16\n"
            " %a16v4f32 = OpTypeArray %v4f32 %c_i32_16\n"
            " %pp_v4f16 = OpTypePointer PushConstant %v4f16\n"
            " %up_v4f32 = OpTypePointer Uniform %v4f32\n"
            "   %SSBO32 = OpTypeStruct %a16v4f32\n"
            "%up_SSBO32 = OpTypePointer Uniform %SSBO32\n"
            "   %ssbo32 = OpVariable %up_SSBO32 Uniform\n"
            "     %PC16 = OpTypeStruct %a16v4f16\n"
            "  %pp_PC16 = OpTypePointer PushConstant %PC16\n"
            "     %pc16 = OpVariable %pp_PC16 PushConstant\n",
            "OpDecorate %a16v4f16 ArrayStride 8\nOpDecorate %a16v4f32 ArrayStride 16\n" + common_decoration,
            {"count": "%c_i32_16", "pp_type16": "%pp_v4f16", "f_type16": "%v4f16", "f_type32": "%v4f32", "up_type32": "%up_v4f32"},
        ),
        "matrix": (
            "   %c_i32_8 = OpConstant %i32 8\n"
            "  %c_i32_ci = OpConstant %i32 ${constarrayidx}\n"
            "      %f16  = OpTypeFloat 16\n"
            "    %v4f16  = OpTypeVector %f16 4\n"
            "  %m2v4f16  = OpTypeMatrix %v4f16 2\n"
            "  %m2v4f32  = OpTypeMatrix %v4f32 2\n"
            " %a8m2v4f16 = OpTypeArray %m2v4f16 %c_i32_8\n"
            " %a8m2v4f32 = OpTypeArray %m2v4f32 %c_i32_8\n"
            " %pp_v4f16  = OpTypePointer PushConstant %v4f16\n"
            " %up_v4f32  = OpTypePointer Uniform %v4f32\n"
            "   %SSBO32  = OpTypeStruct %a8m2v4f32\n"
            "%up_SSBO32  = OpTypePointer Uniform %SSBO32\n"
            "   %ssbo32  = OpVariable %up_SSBO32 Uniform\n"
            "     %PC16  = OpTypeStruct %a8m2v4f16\n"
            "  %pp_PC16  = OpTypePointer PushConstant %PC16\n"
            "     %pc16  = OpVariable %pp_PC16 PushConstant\n",
            "OpDecorate %a8m2v4f16 ArrayStride 16\n"
            "OpDecorate %a8m2v4f32 ArrayStride 32\n"
            "OpDecorate %SSBO32 BufferBlock\n"
            "OpMemberDecorate %SSBO32 0 Offset 0\n"
            "OpMemberDecorate %SSBO32 0 ColMajor\n"
            "OpMemberDecorate %SSBO32 0 MatrixStride 16\n"
            "OpDecorate %PC16 Block\n"
            "OpMemberDecorate %PC16 0 Offset 0\n"
            "OpMemberDecorate %PC16 0 ColMajor\n"
            "OpMemberDecorate %PC16 0 MatrixStride 8\n"
            "OpDecorate %ssbo32 DescriptorSet 0\n"
            "OpDecorate %ssbo32 Binding 0\n",
            {"count": "%c_i32_8", "pp_type16": "%pp_v4f16", "up_type32": "%up_v4f32", "f_type16": "%v4f16", "f_type32": "%v4f32", "index0": "%c_i32_0"},
        ),
    }
    store = (
        "  %src_1 = OpAccessChain %pp_v4f16 %pc16 %c_i32_0 %${arrayindex} %c_i32_1\n"
        "%val16_1 = OpLoad %v4f16 %src_1\n"
        "%val32_1 = OpFConvert %v4f32 %val16_1\n"
        "  %dst_1 = OpAccessChain %up_v4f32 %ssbo32 %c_i32_0 %30 %c_i32_1\n"
        "           OpStore %dst_1 %val32_1\n"
    )
    for kind, (pre, decoration, base_values) in kinds.items():
        for use_const, const_idx in ((False, 0), (True, 4), (True, 5), (True, 6)):
            values = dict(base_values, constarrayidx=str(const_idx), arrayindex="c_i32_ci" if use_const else "30")
            if kind == "matrix":
                values["store"] = specialize(store, values)
            frags = {
                "capability": "OpCapability StoragePushConstant16\n",
                "extension": 'OpExtension "SPV_KHR_16bit_storage"',
                "decoration": decoration,
                "pre_main": specialize(pre, values),
                "testfun": specialize(test_fun, values),
            }
            gen = f"gen=s16pf;seed=push_constant_float_16_to_32;kind={kind};cidx={const_idx if use_const else -1};vf32=1;pc16=1"
            name = kind + (f"_const_idx_{const_idx}" if use_const else "")
            cases.append(("16bit_storage/push_constant_float_16_to_32", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"], "gen": gen}))


def build_storage16_push_constant_int_cases(cases):
    """addGraphics16BitStoragePushConstantInt16To32Group (push_constant_int_16_to_32): 64 int16 push constants widened, as scalars or vec2s, signed and unsigned. The templates are
    read out of the C++."""
    body = cpp_function_body(STORAGE16_CPP.read_text(encoding="utf-8"), "addGraphics16BitStoragePushConstantInt16To32Group")
    found = [(m.group(1), decode_literals(m.group(2))) for m in re.finditer(r'const StringTemplate (\w+)\(((?:\s*(?://[^\n]*\n)?\s*"(?:[^"\\]|\\.)*"\s*)+)\);', body)]
    test_fun = next(text for name, text in found if name == "testFun")
    pre = [text for name, text in found if name == "preMain"]
    decoration = [text for name, text in found if name == "decoration"]
    for kind_index, kind in enumerate(("scalar", "vector")):
        for sign_name, signed, convert, letter in (("sint", "1", "OpSConvert", "i"), ("uint", "0", "OpUConvert", "u")):
            for use_const, const_idx in ((False, 0), (True, 4), (True, 5), (True, 6)):
                values = {
                    "signed": signed, "convert": convert, "constarrayidx": str(const_idx), "arrayindex": "c_i32_ci" if use_const else "30",
                    "count": "64" if kind == "scalar" else "32",
                }
                if kind == "scalar":
                    values.update(type16=f"{letter}16", type32=f"{letter}32")
                else:
                    values.update(base_type16=f"{letter}16", type16=f"v2{letter}16", type32=f"v2{letter}32")
                frags = {
                    "capability": "OpCapability StoragePushConstant16\n",
                    "extension": 'OpExtension "SPV_KHR_16bit_storage"',
                    "testfun": specialize(test_fun, values),
                    "pre_main": specialize(pre[kind_index], values),
                    "decoration": specialize(decoration[kind_index], values),
                }
                name = f"{sign_name}_{kind}" + (f"_const_idx_{const_idx}" if use_const else "")
                gen = f"gen=s16pi;seed=push_constant_int_16_to_32;kind={kind};signed={signed};cidx={const_idx if use_const else -1};pc16=1"
                cases.append(("16bit_storage/push_constant_int_16_to_32", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"], "gen": gen}))


def build_storage8_push_constant_cases(cases):
    """addGraphics8BitStoragePushConstantInt8To32Group (push_constant_int_8_to_32) and ...Int8To16Group (push_constant_int_8_to_16): 64 int8 push constants widened, as scalars or
    vec2s, signed and unsigned. The templates are read out of the C++."""
    text = STORAGE8_CPP.read_text(encoding="utf-8")
    for function, group, wide, capability, extension, ext, flags in (
        (
            "addGraphics8BitStoragePushConstantInt8To32Group", "push_constant_int_8_to_32", 32,
            "OpCapability StoragePushConstant8\n",
            'OpExtension "SPV_KHR_storage_buffer_storage_class"\nOpExtension "SPV_KHR_8bit_storage"',
            ["VK_KHR_8bit_storage"], "pc8=1",
        ),
        (
            "addGraphics8BitStoragePushConstantInt8To16Group", "push_constant_int_8_to_16", 16,
            "OpCapability StoragePushConstant8\nOpCapability StorageUniform16\n",
            'OpExtension "SPV_KHR_storage_buffer_storage_class"\nOpExtension "SPV_KHR_8bit_storage"\nOpExtension "SPV_KHR_16bit_storage"\n',
            ["VK_KHR_8bit_storage", "VK_KHR_16bit_storage"], "pc8=1;ub16=1",
        ),
    ):
        body = cpp_function_body(text, function)
        found = [(m.group(1), decode_literals(m.group(2))) for m in re.finditer(r'const StringTemplate (\w+)\(((?:\s*(?://[^\n]*\n)?\s*"(?:[^"\\]|\\.)*"\s*)+)\);', body)]
        test_fun = next(t for n, t in found if n == "testFun")
        pre = [t for n, t in found if n == "preMain"]
        decoration = [t for n, t in found if n == "decoration"]
        for kind_index, kind in enumerate(("scalar", "vector")):
            for sign_name, signed, convert, letter in (("sint", "1", "OpSConvert", "i"), ("uint", "0", "OpUConvert", "u")):
                for use_const, const_idx in ((False, 0), (True, 4), (True, 5), (True, 6)):
                    values = {
                        "signed": signed, "convert": convert, "constarrayidx": str(const_idx), "arrayindex": "c_i32_ci" if use_const else "30",
                        "count": "64" if kind == "scalar" else "32",
                    }
                    if kind == "scalar":
                        values.update(type8=f"{letter}8", **{f"type{wide}": f"{letter}{wide}"})
                    else:
                        values.update(base_type8=f"{letter}8", type8=f"v2{letter}8", **{f"type{wide}": f"v2{letter}{wide}", f"base_type{wide}": f"{letter}{wide}"})
                    frags = {
                        "capability": capability,
                        "extension": extension,
                        "testfun": specialize(test_fun, values),
                        "pre_main": specialize(pre[kind_index], values),
                        "decoration": specialize(decoration[kind_index], values),
                    }
                    name = f"{sign_name}_{kind}" + (f"_const_idx_{const_idx}" if use_const else "")
                    gen = f"gen=s8pi;seed={group};kind={kind};signed={signed};res={wide // 8};cidx={const_idx if use_const else -1};{flags}"
                    cases.append((f"8bit_storage/{group}", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ext, "gen": gen}))


def build_storage16_float32_to_16_cases(cases):
    """addGraphics16BitStorageUniformFloat32To16Group (uniform_float_32_to_16): scalar, vec4 and 4x4 matrix of binary32 narrowed under each rounding mode decoration; the result is
    checked against the inputs by graphicsCheck16BitFloats. The templates are read out of the C++."""
    body = cpp_function_body(STORAGE16_CPP.read_text(encoding="utf-8"), "addGraphics16BitStorageUniformFloat32To16Group")
    literal = r'((?:\s*(?://[^\n]*\n)?\s*"(?:[^"\\]|\\.)*"\s*)+)'
    pre = [decode_literals(m.group(1)) for m in re.finditer(r'fragments\["pre_main"\]\s*=' + literal + ";", body)]
    fun = [decode_literals(m.group(1)) for m in re.finditer(r'fragments\["testfun"\]\s*=' + literal + ";", body)]
    decoration = [decode_literals(m.group(2)) for m in re.finditer(r'const StringTemplate (decoration)\(' + literal + r"\);", body)]
    assert len(pre) == len(fun) == len(decoration) == 3
    rounding = (("rtz", "OpDecorate %val16  FPRoundingMode RTZ", "2"), ("rte", "OpDecorate %val16  FPRoundingMode RTE", "1"), ("unspecified_rnd_mode", "", "3"))
    for index, kind in enumerate(("scalar", "vector", "matrix")):
        for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
            for round_name, round_decor, round_flag in rounding:
                values = {"cap": cap, "indecor": decor, "arraystride": str((4, 16)[cap_idx]), "rounddecor": round_decor}
                frags = {
                    "extension": 'OpExtension "SPV_KHR_16bit_storage"', "capability": f"OpCapability {cap}\n",
                    "pre_main": pre[index], "testfun": fun[index], "decoration": specialize(decoration[index], values),
                }
                gen = f"gen=s16f_32to16;seed=uniform_float_32_to_16;kind={kind};cap={cap_idx};vf16={round_flag};{cap_flags}"
                cases.append(("16bit_storage/uniform_float_32_to_16", f"{cap_name}_{kind}_float_{round_name}", frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"], "gen": gen}))


VP_CPP = CPP.with_name("vktSpvAsmVariablePointersTests.cpp")
CPP_LITERALS = r'((?:(?:\s*//[^\n]*\n)*\s*"(?:[^"\\]|\\.)*"\s*)+)'


def cpp_templates_by_name(body):
    return {m.group(1): decode_literals(m.group(2)) for m in re.finditer(r"const (?:tcu::)?StringTemplate (\w+)\(" + CPP_LITERALS + r"\);", body)}


def cpp_string_array(body, name):
    """`const string name[] = {...};` as a list of decoded strings (adjacent literals folded)."""
    m = re.search(r"const string " + name + r"\[\]\s*=\s*\{(.*?)\};", body, re.S)
    text = re.sub(r"//[^\n]*", "", m.group(1))
    return [decode_literals(element) or "" for element in split_top(text) if element.strip()]


def build_variable_pointer_single_cases(cases):
    build_variable_pointer_cases(cases, "addSingleInputBufferReadOnlyVariablePointersGraphicsGroup", "single_buffer_read_only_graphics", "vp1", "OpCapability VariablePointersStorageBuffer                \n", "varptr=1")
    build_variable_pointer_cases(cases, "addTwoInputBufferReadOnlyVariablePointersGraphicsGroup", "multi_buffer_read_only_graphics", "vp2", "OpCapability VariablePointers                            \n", "varptrfull=1")


def build_variable_pointer_cases(cases, function, group, family, capability, flag):
    """addSingleInputBufferReadOnlyVariablePointersGraphicsGroup of vktSpvAsmVariablePointersTests.cpp (variable_pointers.single_buffer_read_only_graphics): variable pointers
    into one buffer at seven levels of a nested structure chosen by five instructions. The templates and index tables are read out of the C++; the input data and the expected
    colours are made in Rust from the level and the chosen input."""
    body = cpp_function_body(VP_CPP.read_text(encoding="utf-8"), function)
    templates = cpp_templates_by_name(body)
    arrays = {name: cpp_string_array(body, name) for name in (
        "indexLevelNames", "inputALocations", "inputBLocations", "inputAPtrAccessChain", "inputBPtrAccessChain", "remainingIndexesAtLevel", "pointerTypeAtLevel", "baseANameAtLevel", "baseBNameAtLevel",
    )}
    assert all(len(v) == 7 for v in arrays.values()), {k: len(v) for k, v in arrays.items()}
    frags_fixed = {
        "capability": capability,
        "extension": 'OpExtension "SPV_KHR_variable_pointers"                \nOpExtension "SPV_KHR_storage_buffer_storage_class"    \n',
    }
    for select_a in (1, 0):
        selected = "first_input" if select_a else "second_input"
        spirv_select = "%c_bool_true" if select_a else "%c_bool_false"
        outer = 0 if select_a else 1
        for level in range(7):
            ptr_type, base_a, base_b = arrays["pointerTypeAtLevel"][level], arrays["baseANameAtLevel"][level], arrays["baseBNameAtLevel"][level]
            variants = {
                "opselect": ("", arrays["inputALocations"][level], arrays["inputBLocations"][level], f"%var_ptr = OpSelect {ptr_type} {spirv_select} {base_a} {base_b}\n"),
                "opcopyobject": (
                    "", arrays["inputALocations"][level], arrays["inputBLocations"][level],
                    f"%in_a_copy = OpCopyObject {ptr_type} {base_a}\n%in_b_copy = OpCopyObject {ptr_type} {base_b}\n%var_ptr = OpSelect {ptr_type} {spirv_select} %in_a_copy %in_b_copy\n",
                ),
                "opphi": (
                    "", arrays["inputALocations"][level], arrays["inputBLocations"][level],
                    "                  OpSelectionMerge %end_label None\n                  OpBranchConditional " + spirv_select + " %take_input_a %take_input_b\n"
                    "%take_input_a = OpLabel\n                  OpBranch %end_label\n%take_input_b = OpLabel\n                  OpBranch %end_label\n"
                    f"%end_label = OpLabel\n%var_ptr = OpPhi {ptr_type} {base_a} %take_input_a {base_b} %take_input_b\n",
                ),
                "opfunctioncall": (
                    specialize(templates["selectorFunctions"], {"selected_type": ptr_type}), arrays["inputALocations"][level], arrays["inputBLocations"][level],
                    f"%var_ptr = OpFunctionCall {ptr_type} %choose_input_func {spirv_select} {base_a} {base_b}\n",
                ),
                "opptraccesschain": ("", arrays["inputAPtrAccessChain"][level], arrays["inputBPtrAccessChain"][level], f"%var_ptr = OpSelect {ptr_type} {spirv_select} {base_a} {base_b}\n"),
            }
            for op_name, (helpers, a_loc, b_loc, strategy) in variants.items():
                values = {
                    "select_inputA": spirv_select, "helper_functions": helpers, "a_loc": a_loc, "b_loc": b_loc,
                    "remaining_indexes": arrays["remainingIndexesAtLevel"][level], "selection_strategy": strategy,
                }
                frags = dict(frags_fixed, decoration=specialize(templates["decoration"], values), pre_main=specialize(templates["preMain"], values), testfun=specialize(templates["testFunction"], values))
                gen = f"gen={family};level={level};outer={outer};{flag}"
                cases.append((f"variable_pointers/{group}", f"{op_name}{arrays['indexLevelNames'][level]}{selected}", frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_variable_pointers"], "gen": gen}))


def build_storage16_float16_to_64_cases(cases):
    """addGraphics16BitStorageUniformFloat16To64Group (uniform_float_16_to_64): scalar, vec2 and 4x2 matrix of binary16 widened to binary64, compared with check64BitFloats.
    The templates are read out of the C++."""
    body = cpp_function_body(STORAGE16_CPP.read_text(encoding="utf-8"), "addGraphics16BitStorageUniformFloat16To64Group")
    found = sorted(
        [(m.start(), m.group(1), decode_literals(m.group(2))) for m in re.finditer(r"const StringTemplate (\w+)\(" + CPP_LITERALS + r"\);", body)]
        + [(m.start(), "fragments:" + m.group(1), decode_literals(m.group(2))) for m in re.finditer(r'fragments\["(\w+)"\]\s*=' + CPP_LITERALS + ";", body)]
    )
    named = lambda name: [text for _, n, text in found if n == name]
    capabilities = named("capabilities")[0]
    sections = {
        "scalar": (named("preMain")[0], named("decoration")[0], named("testFun")[0], (2, 16)),
        "vector": (named("preMain")[1], named("decoration")[1], named("testFun")[1], (4, 16)),
        "matrix": (named("fragments:pre_main")[0], named("decoration")[2], named("fragments:testfun")[0], None),
    }
    for kind, (pre, decoration, fun, strides) in sections.items():
        for use_const, const_idx in ((False, 0), (True, 4), (True, 5), (True, 6)) if kind != "matrix" else ((False, 0),):
            for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
                values = {"cap": cap, "indecor": decor, "constarrayidx": str(const_idx), "arrayindex": "c_i32_ci" if use_const else "30"}
                if strides:
                    values["stride16"] = str(strides[cap_idx])
                frags = {
                    "extension": 'OpExtension "SPV_KHR_16bit_storage"', "capability": specialize(capabilities, values), "decoration": specialize(decoration, values),
                    "pre_main": specialize(pre, values), "testfun": specialize(fun, values),
                }
                name = f"{cap_name}_{kind}_float" + (f"_const_idx_{const_idx}" if use_const else "")
                gen = f"gen=s16f_16to64;seed=uniform_float_16_to_64;kind={kind};cap={cap_idx};cidx={const_idx if use_const else -1};vf64=1;f64=1;{cap_flags}"
                cases.append(("16bit_storage/uniform_float_16_to_64", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"], "gen": gen}))


def build_storage16_float64_to_16_cases(cases):
    """addGraphics16BitStorageUniformFloat64To16Group (uniform_float_64_to_16): scalar, vec2 and 2x4 matrix of binary64 narrowed under each rounding mode decoration, checked against the
    inputs. The templates and the rounding mode tables are read out of the C++."""
    body = cpp_function_body(STORAGE16_CPP.read_text(encoding="utf-8"), "addGraphics16BitStorageUniformFloat64To16Group")
    found = sorted(
        [(m.start(), m.group(1), decode_literals(m.group(2))) for m in re.finditer(r"const StringTemplate (\w+)\(" + CPP_LITERALS + r"\);", body)]
        + [(m.start(), "fragments:" + m.group(1), decode_literals(m.group(2))) for m in re.finditer(r'fragments\["(\w+)"\]\s*=' + CPP_LITERALS + ";", body)]
    )
    named = lambda name: [text for _, n, text in found if n == name]
    capabilities = named("capabilities")[0]
    modes = []
    for m in re.finditer(r"const RndMode rndModes\[\] = \{(.*?)\n\s*\};", body, re.S):
        entries = []
        for entry in split_top(m.group(1).strip().rstrip(",")):
            parts = split_top(entry.strip()[1:-1])
            check = parts[2]
            flags = 3 if "RTE" in check and "RTZ" in check else (2 if "RTZ" in check else 1)
            entries.append((decode_literals(parts[0]), decode_literals(parts[1]) or "", str(flags)))
        modes.append(entries)
    assert len(modes) == 3
    sections = (("scalar", named("fragments:pre_main")[0], named("decoration")[0], named("fragments:testfun")[0]),
                ("vector", named("fragments:pre_main")[1], named("decoration")[1], named("fragments:testfun")[1]),
                ("matrix", named("fragments:pre_main")[2], named("decoration")[2], named("fragments:testfun")[2]))
    for index, (kind, pre, decoration, fun) in enumerate(sections):
        for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
            for round_name, round_decor, round_flag in modes[index]:
                values = {"cap": cap, "indecor": decor, "rounddecor": round_decor, "stride64": str((8, 16)[cap_idx])}
                frags = {
                    "extension": 'OpExtension "SPV_KHR_16bit_storage"', "capability": specialize(capabilities, values), "decoration": specialize(decoration, values),
                    "pre_main": pre, "testfun": fun,
                }
                gen = f"gen=s16f_64to16;seed=uniform_float_64_to_16;kind={kind};cap={cap_idx};vf16d={round_flag};f64=1;{cap_flags}"
                cases.append(("16bit_storage/uniform_float_64_to_16", f"{cap_name}_{kind}_float_{round_name}", frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"], "gen": gen}))


def build_storage16_push_constant_float64_cases(cases):
    """addGraphics16BitStoragePushConstantFloat16To64Group (push_constant_float_16_to_64): scalar, vector and matrix cases of 64 binary16 push constants widened to binary64. The templates are
    read out of the C++."""
    body = cpp_function_body(STORAGE16_CPP.read_text(encoding="utf-8"), "addGraphics16BitStoragePushConstantFloat16To64Group")
    test_fun = cpp_templates_by_name(body)["testFun"]
    pre = [decode_literals(m.group(1)) for m in re.finditer(r'fragments\["pre_main"\]\s*=' + CPP_LITERALS + ";", body)]
    decoration = [decode_literals(m.group(1)) for m in re.finditer(r'fragments\["decoration"\]\s*=' + CPP_LITERALS + ";", body)]
    matrix_store = (
        "  %src_1 = OpAccessChain %pp_v4f16 %pc16 %c_i32_0 %30 %c_i32_1\n"
        "%val16_1 = OpLoad %v4f16 %src_1\n"
        "%val64_1 = OpFConvert %v4f64 %val16_1\n"
        "  %dst_1 = OpAccessChain %up_v4f64 %ssbo64 %c_i32_0 %30 %c_i32_1\n"
        "           OpStore %dst_1 %val64_1\n"
    )
    specs = (
        ("scalar", {"count": "%c_i32_64", "pp_type16": "%pp_f16", "f_type16": "%f16", "f_type64": "%f64", "up_type64": "%up_f64"}),
        ("vector", {"count": "%c_i32_16", "pp_type16": "%pp_v4f16", "f_type16": "%v4f16", "f_type64": "%v4f64", "up_type64": "%up_v4f64"}),
        ("matrix", {"count": "%c_i32_8", "pp_type16": "%pp_v4f16", "up_type64": "%up_v4f64", "f_type16": "%v4f16", "f_type64": "%v4f64", "index0": "%c_i32_0", "store": matrix_store}),
    )
    assert len(pre) == len(decoration) == 3
    for index, (kind, values) in enumerate(specs):
        frags = {
            "capability": "OpCapability StoragePushConstant16\nOpCapability Float64\n", "extension": 'OpExtension "SPV_KHR_16bit_storage"',
            "pre_main": pre[index], "decoration": decoration[index], "testfun": specialize(test_fun, values),
        }
        gen = "gen=s16pf64;seed=push_constant_float_16_to_64;vf64=1;f64=1;pc16=1"
        cases.append(("16bit_storage/push_constant_float_16_to_64", kind, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"], "gen": gen}))


def build_storage16_struct_cases(cases):
    """addGraphics16BitStorageUniformStructFloat16To32Group (uniform_16struct_to_32struct) and ...Float32To16Group (uniform_32struct_to_16struct): arrays of structs of
    16 and 32 bit floats, the layouts of getStructShaderComponet. The data, checks and requirements are those of the compute twin (struct16_tests.rs)."""
    import gen_spirv_assembly_16bit_struct_manifest as structs

    source = STORAGE16_CPP.read_text(encoding="utf-8")
    types = structs.component(source, "TYPES")
    for function, group, narrow_first in (
        ("addGraphics16BitStorageUniformStructFloat16To32Group", "uniform_16struct_to_32struct", True),
        ("addGraphics16BitStorageUniformStructFloat32To16Group", "uniform_32struct_to_16struct", False),
    ):
        body = cpp_function_body(source, function)
        templates = cpp_templates_by_name(body)
        test_fun = decode_literals(re.search(r'fragments\["testfun"\]\s*=' + CPP_LITERALS + ";", body).group(1))
        for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
            std430 = cap_idx == 0
            if narrow_first:
                values = {"cap": cap, "strideF16": structs.component(source, "STRIDE16BIT_STD430" if std430 else "STRIDE16BIT_STD140"), "strideF32": structs.component(source, "STRIDE32BIT_STD430")}
            else:
                values = {"cap": "StorageUniformBufferBlock16", "strideF16": structs.component(source, "STRIDE16BIT_STD430"), "strideF32": structs.component(source, "STRIDE32BIT_STD430" if std430 else "STRIDE32BIT_STD140")}
            values.update({"indecor": decor, "types": types})
            frags = {
                "extension": 'OpExtension "SPV_KHR_16bit_storage"', "capability": specialize(templates["capabilities"], values),
                "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values), "testfun": test_fun,
            }
            gen = f"gen=s16st;group={'16to32' if narrow_first else '32to16'};cap={cap_idx}"
            cases.append((f"16bit_storage/{group}", cap_name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"], "gen": gen}))


def build_variable_pointer_nullptr_cases(cases):
    """addNullptrVariablePointersGraphicsGroup (variable_pointers.nullptr_graphics): a pointer variable initialised to null and then set, and an OpSelect between null and a valid pointer.
    The templates are read out of the C++; the one input float and the expected colours are made in Rust."""
    body = cpp_function_body(VP_CPP.read_text(encoding="utf-8"), "addNullptrVariablePointersGraphicsGroup")
    templates = cpp_templates_by_name(body)
    strategies = {
        "opvariable_initialized_null": "                  OpStore %f32_ptr_var %input_loc      \n%loaded_f32_ptr = OpLoad  %sb_f32ptr   %f32_ptr_var    \n%result_val     = OpLoad  %f32         %loaded_f32_ptr \n",
        "opselect_null_or_valid_ptr": "%selected_ptr  = OpSelect %sb_f32ptr %c_bool_true %input_loc %c_null_ptr\n%result_val    = OpLoad %f32 %selected_ptr\n",
    }
    for name, strategy in strategies.items():
        values = {"NullptrTestingStrategy": strategy}
        frags = {
            "capability": "OpCapability VariablePointers                            \n",
            "extension": 'OpExtension "SPV_KHR_variable_pointers"                \nOpExtension "SPV_KHR_storage_buffer_storage_class"    \n',
            "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values), "testfun": specialize(templates["testFunction"], values),
        }
        cases.append(("variable_pointers/nullptr_graphics", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_variable_pointers"], "gen": "gen=vpn;varptrfull=1"}))


def build_variable_pointer_mux_cases(cases):
    """addVariablePointersGraphicsGroup of vktSpvAsmVariablePointersTests.cpp (variable_pointers.graphics): 100 muxes choosing between inputs through a variable pointer, by OpSelect,
    OpFunctionCall, OpPhi, OpCopyObject, stores to Private and Function pointer variables, OpPtrAccessChain, and a write through the pointer. The templates are read out of the C++, the data and
    expected output are made in Rust (pointers_tests.rs::mux_io)."""
    body = cpp_function_body(VP_CPP.read_text(encoding="utf-8"), "addVariablePointersGraphicsGroup")
    templates = cpp_templates_by_name(body)
    selector_function = decode_literals(re.search(r"const std::string selectorFunction\(" + CPP_LITERALS + r"\);", body).group(1))
    pre_main = (
        "%c_i32_limit = OpConstant %i32 100\n"
        "     %sb_f32 = OpTypePointer StorageBuffer %f32\n"
        "     %ra_f32 = OpTypeRuntimeArray %f32\n"
        "        %buf = OpTypeStruct %ra_f32\n"
        "     %sb_buf = OpTypePointer StorageBuffer %buf\n"
        " ${ExtraTypes}"
        " ${ExtraGlobalScopeVars}"
        "   %indata_a = OpVariable %sb_buf StorageBuffer\n"
        "   %indata_b = OpVariable %sb_buf StorageBuffer\n"
        "   %indata_s = OpVariable %sb_buf StorageBuffer\n"
        "    %outdata = OpVariable %sb_buf StorageBuffer\n"
        " ${ExtraFunctions} "
    )
    for single in (True, False):
        cap = "OpCapability VariablePointersStorageBuffer\n" if single else "OpCapability VariablePointers\n"
        buffer_type = "single_buffer" if single else "two_buffers"
        mux1 = " %loc_a_2i " if single else " %loc_a_i "
        mux2 = " %loc_a_2i_plus_1 " if single else " %loc_b_i "
        base = {"ExtraTypes": "", "ExtraGlobalScopeVars": "", "ExtraFunctionScopeVars": "", "ExtraFunctions": "", "VarPtrName": "%mux_output_var_ptr"}
        variants = [
            (f"reads_opselect_{buffer_type}", dict(base, ResultStrategy="%mux_output_var_ptr = OpSelect %sb_f32 %is_neg" + mux1 + mux2 + "\n"), False),
            (f"reads_opfunctioncall_{buffer_type}", dict(base, ExtraFunctions=selector_function, ResultStrategy="%mux_output_var_ptr = OpFunctionCall %sb_f32 %choose_input_func %is_neg" + mux1 + mux2 + "\n"), False),
            (
                f"reads_opphi_{buffer_type}",
                dict(
                    base,
                    ResultStrategy="                              OpSelectionMerge %end_label None\n"
                    "                              OpBranchConditional %is_neg %take_mux_input_1 %take_mux_input_2\n"
                    "%take_mux_input_1 = OpLabel\n                              OpBranch %end_label\n"
                    "%take_mux_input_2 = OpLabel\n                              OpBranch %end_label\n"
                    "%end_label = OpLabel\n%mux_output_var_ptr = OpPhi %sb_f32" + mux1 + "%take_mux_input_1" + mux2 + "%take_mux_input_2\n",
                ),
                False,
            ),
            (
                f"reads_opcopyobject_{buffer_type}",
                dict(base, ResultStrategy="%mux_input_1_copy = OpCopyObject %sb_f32" + mux1 + "\n%mux_input_2_copy = OpCopyObject %sb_f32" + mux2 + "\n%mux_output_var_ptr = OpSelect %sb_f32 %is_neg %mux_input_1_copy %mux_input_2_copy\n"),
                False,
            ),
        ]
        for class_id, storage_class in enumerate(("Private", "Function")):
            extra_variable = f"%mux_output_copy = OpVariable %sb_f32ptrptr {storage_class}\n"
            variants.append(
                (
                    f"stores_{storage_class.lower()}_{buffer_type}",
                    dict(
                        base,
                        ExtraTypes=f"%sb_f32ptrptr = OpTypePointer {storage_class} %sb_f32\n",
                        ExtraGlobalScopeVars=extra_variable if class_id == 0 else "",
                        ExtraFunctionScopeVars=extra_variable if class_id == 1 else "",
                        ResultStrategy="%opselect_result = OpSelect %sb_f32 %is_neg" + mux1 + mux2 + "\n                              OpStore %mux_output_copy %opselect_result\n%mux_output_var_ptr = OpLoad %sb_f32 %mux_output_copy\n",
                    ),
                    False,
                )
            )
        in_1 = " %a_2i_ptr " if single else " %a_i_ptr "
        in_2 = " %a_2i_plus_1_ptr " if single else " %b_i_ptr "
        variants.append(
            (
                f"reads_opptraccesschain_{buffer_type}",
                dict(
                    base,
                    ResultStrategy="%a_ptr = OpAccessChain %sb_f32 %indata_a %c_i32_0 %c_i32_0\n"
                    "%b_ptr = OpAccessChain %sb_f32 %indata_b %c_i32_0 %c_i32_0\n"
                    "%s_ptr = OpAccessChain %sb_f32 %indata_s %c_i32_0 %c_i32_0\n"
                    "%out_ptr               = OpAccessChain %sb_f32 %outdata  %c_i32_0 %c_i32_0\n"
                    "%a_i_ptr               = OpPtrAccessChain %sb_f32 %a_ptr %30\n"
                    "%b_i_ptr               = OpPtrAccessChain %sb_f32 %b_ptr %30\n"
                    "%s_i_ptr               = OpPtrAccessChain %sb_f32 %s_ptr %30\n"
                    "%a_2i_ptr              = OpPtrAccessChain %sb_f32 %a_ptr %two_i\n"
                    "%a_2i_plus_1_ptr       = OpPtrAccessChain %sb_f32 %a_ptr %two_i_plus_1\n"
                    "%mux_output_var_ptr    = OpSelect %sb_f32 %is_neg " + in_1 + in_2 + "\n",
                ),
                False,
            )
        )
        variants.append(
            (
                f"writes_{buffer_type}",
                dict(
                    base,
                    ResultStrategy="%mux_output_var_ptr = OpSelect %sb_f32 %is_neg" + mux1 + mux2 + "\n"
                    "               %val = OpLoad %f32 %mux_output_var_ptr Aligned 4\n"
                    "        %val_plus_1 = OpFAdd %f32 %val %c_f32_1\n"
                    "                      OpStore %mux_output_var_ptr %val_plus_1\n",
                ),
                True,
            )
        )
        for name, values, write in variants:
            frags = {
                "capability": cap, "extension": 'OpExtension "SPV_KHR_variable_pointers"\nOpExtension "SPV_KHR_storage_buffer_storage_class"\n',
                "decoration": specialize(templates["decoration"], values), "pre_main": specialize(pre_main, values), "testfun": specialize(templates["testFunction"], values),
            }
            gen = f"gen=vpg;single={int(single)};write={int(write)};{'varptr=1' if single else 'varptrfull=1'}"
            cases.append(("variable_pointers/graphics", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_variable_pointers"], "gen": gen}))


def build_varying_name_cases(cases):
    """vktSpvAsmVaryingNameTests.cpp (varying_name.{names_match,names_differ,no_names}): a vertex shader passing a float and a fragment shader writing it to an output buffer, with the
    OpName of the varying the same, different or absent in the two. The templates are the two shaders of `createShaders` with the OpName lines as `${OPNAME_VERT}`/`${OPNAME_FRAG}`."""
    text = (CRATE / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "spirv_assembly" / "vktSpvAsmVaryingNameTests.cpp").read_text(encoding="utf-8")
    body = cpp_function_body(text, "createShaders")
    pieces = {}
    for variable, key in (("vertexShader", "OPNAME_VERT"), ("fragmentShader", "OPNAME_FRAG")):
        start = body.index(f"const string {variable} =")
        end = body.index(";\n", start)
        out = ""
        for token in re.findall(r'"(?:[^"\\]|\\.)*"|opNameVert|opNameFrag', body[start:end]):
            out += "${OPNAME_VERT}" if token == "opNameVert" else "${OPNAME_FRAG}" if token == "opNameFrag" else token[1:-1].encode().decode("unicode_escape")
        pieces[variable] = out
    (SRC_DIR / "varying_name_vert.asm").write_text(pieces["vertexShader"], encoding="utf-8")
    (SRC_DIR / "varying_name_frag.asm").write_text(pieces["fragmentShader"], encoding="utf-8")
    for name, vert_name, frag_name in (("names_match", "data", "data"), ("names_differ", "dataOut", "dataIn"), ("no_names", "", "")):
        values = {
            "OPNAME_VERT": f'                             OpName %dataOut "{vert_name}"\n' if vert_name else "",
            "OPNAME_FRAG": f'                        OpName %dataIn "{frag_name}"\n' if frag_name else "",
        }
        cases.append((
            "varying_name", name, values,
            {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "out": [f32_bytes([1.0])], "ext": ["VK_KHR_storage_buffer_storage_class"], "stages": ("vert",), "exact": True,
             "custom": (("vert", "spirv_assembly/varying_name_vert.asm"), ("frag", "spirv_assembly/varying_name_frag.asm"))},
        ))


def build_variable_init_output_cases(cases):
    """addGraphicsVariableInitOutputTest (variable_init.output) of vktSpvAsmVariableInitTests.cpp: a vertex shader initialising an Output variable of each type with ones and a fragment shader
    copying the input into the output buffer. The shader templates are read out of `addShaderCodeOutput` (the struct has shaders of its own); the spec keys become manifest keys."""
    text = (CRATE / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "spirv_assembly" / "vktSpvAsmVariableInitTests.cpp").read_text(encoding="utf-8")
    body = cpp_function_body(text, "addShaderCodeOutput")
    struct_part, other_part = body.split("\n    else\n    {", 1)

    def fold(match_text):
        return re.sub(r"\$\{(\w+):opt\}", lambda m: "${" + m.group(1) + "}", match_text)

    struct_vert = fold(decode_literals(re.search(r"const StringTemplate vertexShader\(" + CPP_LITERALS + r"\);", struct_part).group(1)))
    struct_frag = fold(decode_literals(re.search(r"const string fragmentShader =" + CPP_LITERALS + ";", struct_part).group(1)))
    types = decode_literals(re.search(r"const string types =" + CPP_LITERALS + ";", other_part).group(1))

    def folded_expression(name):
        expression = re.search(r"const StringTemplate " + name + r"\((.*?)\);\n", other_part, re.S).group(1)
        out = ""
        for token in re.findall(r'"(?:[^"\\]|\\.)*"|\btypes\b', re.sub(r"//[^\n]*", "", expression)):
            out += types if token == "types" else token[1:-1].encode().decode("unicode_escape")
        return fold(out)

    (SRC_DIR / "variable_init_output_struct_vert.asm").write_text(struct_vert, encoding="utf-8")
    (SRC_DIR / "variable_init_output_struct_frag.asm").write_text(struct_frag, encoding="utf-8")
    (SRC_DIR / "variable_init_output_vert.asm").write_text(folded_expression("vertexShader"), encoding="utf-8")
    (SRC_DIR / "variable_init_output_frag.asm").write_text(folded_expression("fragmentShader"), encoding="utf-8")
    for name, type_name, components in (("float", "f32", 1), ("vec4", "v4f32", 4), ("matrix", "matrix", 8), ("floatarray", "floatArray", 8), ("struct", "struct", 16)):
        values = {"type": type_name, "initSource": type_name + "_1", "extraDecorations": ""}
        if type_name == "v4f32":
            values.update(vec4ptrDeclOutput="", vec4ptrOutput="outputPtr", vec4ptrDeclInput="", vec4ptrInput="inputPtr")
        else:
            values.update(
                vec4ptrDeclOutput="     %_ptr_Output_v4f32 = OpTypePointer Output %v4f32\n", vec4ptrOutput="_ptr_Output_v4f32",
                vec4ptrDeclInput="     %_ptr_Input_v4f32 = OpTypePointer Input %v4f32\n", vec4ptrInput="_ptr_Input_v4f32",
            )
        if type_name == "matrix":
            values["extraDecorations"] = "                       OpMemberDecorate %Output 0 ColMajor\n"
        suffix = "_struct" if type_name == "struct" else ""
        cases.append((
            "variable_init/output", name, values,
            {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "out": [f32_bytes([1.0] * components)], "ext": ["VK_KHR_storage_buffer_storage_class"], "stages": ("vert",), "exact": True,
             "custom": (("vert", f"spirv_assembly/variable_init_output{suffix}_vert.asm"), ("frag", f"spirv_assembly/variable_init_output{suffix}_frag.asm"))},
        ))


def build_float16_cases(cases):
    """createFloat16FuncSet (float16.function) and createFloat16VectorExtractSet (float16.opvectorextractdynamic) of vktSpvAsmInstructionTests.cpp, graphics half: binary16 data copied
    or extracted through helper functions that load and store them packed in 32 bit words. The templates and helper functions are read out of the C++; the data is drawn in Rust."""
    text = CPP.read_text(encoding="utf-8")
    helpers = {m.group(1): decode_literals(m.group(2)) for m in re.finditer(r"const string (\w+) =" + CPP_LITERALS + ";", text) if m.group(1).startswith(("load", "store"))}

    def template_body(name):
        start = text.index(f"{name}(tcu::TestContext &testCtx")
        return text[start : text.index("\n}\n", start)]

    def uniform_decls(*strings):
        return "".join(strings)

    func_types = (
        ("f16", 1, "      %v2f16 = OpTypeVector %f16 2\n%f16_i32_fn = OpTypeFunction %f16 %i32\n%void_f16_i32_fn = OpTypeFunction %void %f16 %i32\n%c_u32_high_ones = OpConstant %u32 0xffff0000\n %c_u32_low_ones = OpConstant %u32 0x0000ffff\n", "u32_hndp", "loadScalarF16FromUint", "storeScalarF16AsUint"),
        ("v2f16", 2, "      %v2f16 = OpTypeVector %f16 2\n  %c_v2f16_0 = OpConstantComposite %v2f16 %c_f16_0 %c_f16_0\n%v2f16_i32_fn = OpTypeFunction %v2f16 %i32\n%void_v2f16_i32_fn = OpTypeFunction %void %v2f16 %i32\n", "u32_ndp", "loadV2F16FromUint", "storeV2F16AsUint"),
        ("v4f16", 4, "      %v2f16 = OpTypeVector %f16 2\n      %v4f16 = OpTypeVector %f16 4\n  %c_v4f16_0 = OpConstantComposite %v4f16 %c_f16_0 %c_f16_0 %c_f16_0 %c_f16_0\n%v4f16_i32_fn = OpTypeFunction %v4f16 %i32\n%void_v4f16_i32_fn = OpTypeFunction %void %v4f16 %i32\n", "ra_u32_2", "loadV4F16FromUints", "storeV4F16AsUints"),
    )
    extract_types = (
        ("v2f16", 2, 4, "      %v2f16 = OpTypeVector %f16 2\n%v2f16_i32_fn = OpTypeFunction %v2f16 %i32\n%void_f16_i32_fn = OpTypeFunction %void %f16 %i32\n%c_u32_high_ones = OpConstant %u32 0xffff0000\n %c_u32_low_ones = OpConstant %u32 0x0000ffff\n", "u32", "loadV2F16FromUint"),
        ("v3f16", 3, 8, "      %v2f16 = OpTypeVector %f16 2\n      %v3f16 = OpTypeVector %f16 3\n%v3f16_i32_fn = OpTypeFunction %v3f16 %i32\n%void_f16_i32_fn = OpTypeFunction %void %f16 %i32\n%c_u32_high_ones = OpConstant %u32 0xffff0000\n %c_u32_low_ones = OpConstant %u32 0x0000ffff\n", "ra_u32_2", "loadV3F16FromUints"),
        ("v4f16", 4, 8, "      %v2f16 = OpTypeVector %f16 2\n      %v4f16 = OpTypeVector %f16 4\n%v4f16_i32_fn = OpTypeFunction %v4f16 %i32\n%void_f16_i32_fn = OpTypeFunction %void %f16 %i32\n%c_u32_high_ones = OpConstant %u32 0xffff0000\n %c_u32_low_ones = OpConstant %u32 0x0000ffff\n", "ra_u32_2", "loadV4F16FromUints"),
    )
    colors = {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_shader_float16_int8"]}

    templates = cpp_templates_by_name(template_body("createFloat16FuncSet"))
    for name, components, decls, storage, load, store in func_types:
        values = {"num_data_points": str(256 // components), "tt": name, "ts": storage, "tt_stride": str(components * 2), "type_decls": decls}
        frags = {
            "capability": "OpCapability Float16\n", "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values),
            "testfun": specialize(templates["testFun"], values) + specialize(helpers[load], {"var": "ssbo_src"}) + specialize(helpers[store], {"var": "ssbo_dst"}),
        }
        cases.append(("float16/function", name, frags, dict(colors, gen=f"gen=f16fn;seed=function;f16=1")))

    templates = cpp_templates_by_name(template_body("createFloat16VectorExtractSet"))
    for index, (name, components, stride, decls, storage, load) in enumerate(extract_types):
        items_per_type = stride // 2
        values = {"num_data_points": str(256 // items_per_type), "tt": name, "ts": storage, "tt_stride": str(stride), "type_decl": decls}
        frags = {
            "capability": "OpCapability Float16\n", "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values),
            "testfun": specialize(templates["testFun"], values) + specialize(helpers[load], {"var": "ssbo_src"}) + specialize(helpers["storeScalarF16AsUint"], {"var": "ssbo_dst"}),
        }
        cases.append(("float16/opvectorextractdynamic", name, frags, dict(colors, gen=f"gen=f16vx;seed=opvectorextractdynamic;typeidx={index};f16=1")))

    templates = cpp_templates_by_name(template_body("createFloat16VectorInsertSet"))
    insert_types = (
        ("v2f16", 2, 4, "      %v2f16 = OpTypeVector %f16 2\n%v2f16_i32_fn = OpTypeFunction %v2f16 %i32\n%void_v2f16_i32_fn = OpTypeFunction %void %v2f16 %i32\n", "u32", "loadV2F16FromUint", "storeV2F16AsUint"),
        ("v3f16", 3, 8, "      %v2f16 = OpTypeVector %f16 2\n      %v3f16 = OpTypeVector %f16 3\n%v3f16_i32_fn = OpTypeFunction %v3f16 %i32\n%void_v3f16_i32_fn = OpTypeFunction %void %v3f16 %i32\n", "ra_u32_2", "loadV3F16FromUints", "storeV3F16AsUints"),
        ("v4f16", 4, 8, "      %v2f16 = OpTypeVector %f16 2\n      %v4f16 = OpTypeVector %f16 4\n%v4f16_i32_fn = OpTypeFunction %v4f16 %i32\n%void_v4f16_i32_fn = OpTypeFunction %void %v4f16 %i32\n", "ra_u32_2", "loadV4F16FromUints", "storeV4F16AsUints"),
    )
    for index, (name, components, stride, decls, storage, load, store) in enumerate(insert_types):
        values = {"num_data_points": str(256 // (stride // 2)), "tt": name, "ts": storage, "tt_stride": str(stride), "type_decl": decls, "replacement": "42"}
        frags = {
            "capability": "OpCapability Float16\n", "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values),
            "testfun": specialize(templates["testFun"], values) + specialize(helpers[load], {"var": "ssbo_src"}) + specialize(helpers[store], {"var": "ssbo_dst"}),
        }
        cases.append(("float16/opvectorinsertdynamic", name, frags, dict(colors, gen=f"gen=f16vi;seed=opvectorinsertdynamic;typeidx={index};comps={components};f16=1")))

    templates = cpp_templates_by_name(template_body("createFloat16VectorShuffleSet"))
    shuffle_types = (("v2f16", 2, "loadV2F16FromUint", "storeV2F16AsUint"), ("v3f16", 3, "loadV3F16FromUints", "storeV3F16AsUints"), ("v4f16", 4, "loadV4F16FromUints", "storeV4F16AsUints"))
    for dst_name, dst_components, _, dst_store in shuffle_types:
        for src0_name, src0_components, src0_load, _ in shuffle_types:
            for src1_name, src1_components, src1_load, _ in shuffle_types:
                component_list = [str(n) for n in range(src0_components + src1_components)] + ["0xFFFFFFFF"]
                case_bodies, case_list, case_count = "", "", 0
                for first in component_list:
                    for second in component_list:
                        shuffle = first + " " + second + "".join(f" {n - 2}" for n in range(2, dst_components))
                        case_bodies += specialize(templates["testCaseBody"], {"case_ndx": str(case_count), "shuffle": shuffle, "tt_dst": dst_name})
                        case_list += f"{case_count} %case_{case_count} "
                        case_count += 1
                values = {"num_data_points": "128", "tt_dst": dst_name, "tt_src0": src0_name, "tt_src1": src1_name, "case_bodies": case_bodies, "case_list": case_list, "case_count": str(case_count)}
                frags = {
                    "capability": "OpCapability Float16\n", "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values),
                    "testfun": specialize(templates["testFun"], values) + specialize(helpers[src0_load], {"var": "ssbo_src0"}) + specialize(helpers[src1_load], {"var": "ssbo_src1"}) + specialize(helpers[dst_store], {"var": "ssbo_dst"}),
                }
                code = f"{dst_components}{src0_components}{src1_components}"
                cases.append(("float16/opvectorshuffle", code, frags, dict(colors, gen=f"gen=f16vs;seed=opvectorshuffle;shuf={code};f16=1")))


def build_float16_composite_construct_cases(cases):
    """createFloat16CompositeConstructSet (float16.opcompositeconstruct.struct), graphics half: a struct of binary16 scalars, vectors, arrays and nested structs built with
    OpCompositeConstruct and stored element by element. The templates are read out of the C++ (comments between the literals dropped); the expected halves are made in Rust."""
    text = CPP.read_text(encoding="utf-8")
    start = text.index("createFloat16CompositeConstructSet(tcu::TestContext &testCtx")
    body = text[start : text.index("\n}\n", start)]
    body = re.sub(r"^[ \t]*//[^\n]*\n", "", body, flags=re.M)
    templates = cpp_templates_by_name(body)
    num_elements, item_count, modifier = 8, 88, 2
    consts = "".join(f"     %c_f16_{i} = OpConstant %f16 {i}\n" for i in range(item_count))
    values = {"num_elements": str(num_elements), "struct_item_size": str(item_count * 2), "field_modifier": str(modifier), "consts": consts}
    frags = {
        "capability": "OpCapability Float16\n", "decoration": specialize(templates["decoration"], values),
        "pre_main": specialize(templates["preMain"], values), "testfun": specialize(templates["testFun"], values),
    }
    colors = {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_shader_float16_int8"]}
    cases.append(("float16/opcompositeconstruct", "struct", frags, dict(colors, gen="gen=f16cc;seed=opcompositeconstruct;f16=1")))


def strip_cpp_line_comments(text):
    """Drops the `//` comments that are outside string literals."""
    result = []
    for line in text.split("\n"):
        in_string, index = False, 0
        while index < len(line):
            char = line[index]
            if in_string and char == "\\":
                index += 2
                continue
            if char == '"':
                in_string = not in_string
            elif not in_string and line.startswith("//", index):
                line = line[:index].rstrip()
                break
            index += 1
        result.append(line)
    return "\n".join(result)


def build_float16_composite_insert_extract_cases(cases):
    """createFloat16CompositeInsertExtractSet (float16.opcompositeinsert and opcompositeextract), graphics half: one case per composite type, each OpSwitch case inserting or
    extracting the f16 at one access path. The templates, the load and store functions and the access paths are read out of the C++; the data is made in Rust from the null paths."""
    text = CPP.read_text(encoding="utf-8")
    start = text.index("createFloat16CompositeInsertExtractSet(tcu::TestContext &testCtx")
    body = strip_cpp_line_comments(text[start : text.index("\n}\n", start)])
    templates = cpp_templates_by_name(body)
    file_helpers = {m.group(1): decode_literals(m.group(2)) for m in re.finditer(r"const string (\w+) =" + CPP_LITERALS + ";", text) if m.group(1).startswith(("load", "store"))}
    functions = {}
    for m in re.finditer(r"const string ((?:load|store)\w+)\(((?:\s*\"(?:[^\"\\]|\\.)*\"\s*)+)(?:\+\s*(\w+))?\);", body):
        functions[m.group(1)] = decode_literals(m.group(2)) + (file_helpers[m.group(3)] if m.group(3) else "")

    def access_path(name):
        m = re.search(r"const char \*accessPath" + name + r"\[\] = \{(.*?)\};", body, re.S)
        return [None if element.strip() == "nullptr" else element.strip().strip('"') for element in split_top(m.group(1)) if element.strip()]

    op_parts = {
        "OpCompositeInsert": (
            "       %fun_t = OpTypeFunction %st_test %f16 %st_test %i32\n    %SSBO_src = OpTypeStruct %ra_f16\n    %SSBO_dst = OpTypeStruct %ra_st\n",
            "   %val_new = OpFunctionCall %f16 %ld_arg_ssbo_src %ndx\n   %val_old = OpFunctionCall %st_test %ld_ssbo_dst %c_i32_0\n   %val_dst = OpFunctionCall %st_test %sw_fun %val_new %val_old %ndx\n",
            "   %sw_fun = OpFunction %st_test None %fun_t\n%sw_paramv = OpFunctionParameter %f16\n",
            "%sw_param",
            "%st_test %sw_paramv %sw_param",
        ),
        "OpCompositeExtract": (
            "       %fun_t = OpTypeFunction %f16 %st_test %i32\n    %SSBO_src = OpTypeStruct %ra_st\n    %SSBO_dst = OpTypeStruct %ra_f16\n",
            "   %val_src = OpFunctionCall %st_test %ld_ssbo_src %c_i32_0\n   %val_dst = OpFunctionCall %f16 %sw_fun %val_src %ndx\n",
            "   %sw_fun = OpFunction %f16 None %fun_t\n",
            "%c_f16_na",
            "%f16 %sw_param",
        ),
    }
    types = (
        ("f16", "F16", "F16"), ("v2f16", "V2F16", "V2F16"), ("v3f16", "V3F16", "V3F16"), ("v4f16", "V4F16", "V4F16"), ("f16arr3", "F16Arr3", "F16Arr3"),
        ("v2f16arr5", "V2F16Arr5", "V2F16Arr5"), ("v3f16arr5", "V3F16Arr5", "V3F16Arr5"), ("v4f16arr3", "V4F16Arr3", "V4F16Arr3"), ("struct16arr3", "Struct16Arr3", "Struct16Arr3"),
    )
    colors = {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_shader_float16_int8"]}
    for op_name, group in (("OpCompositeInsert", "opcompositeinsert"), ("OpCompositeExtract", "opcompositeextract")):
        insert = op_name == "OpCompositeInsert"
        premain_decls, sw_call, sw_header, default_value, args = op_parts[op_name]
        for name, load_suffix, store_suffix in types:
            paths = access_path(load_suffix)
            case_bodies, case_list = "", ""
            for index, path in enumerate(paths):
                if path is not None:
                    case_bodies += specialize(templates["testCaseBody"], {"case_ndx": str(index), "access_path": path, "op_args_part": args, "op_name": op_name})
                    case_list += f"{index} %case_{index} "
            count = len(paths)
            values = {
                "num_elements": str(count), "field_type": name, "struct_item_size": str(count * 2), "struct_u32s": str(count // 2), "op_premain_decls": premain_decls,
                "op_sw_fun_call": sw_call, "op_sw_fun_header": sw_header, "op_case_default_value": default_value, "case_bodies": case_bodies, "case_list": case_list,
                "st_call": "st_ssbo_dst" if insert else "st_fn_ssbo_dst", "st_ndx": "c_i32_0" if insert else "ndx",
            }
            testfun = specialize(templates["testFun"], values)
            if insert:
                testfun += specialize(file_helpers["loadScalarF16FromUint"], {"var": "ssbo_src"}) + specialize(functions["load" + load_suffix], {"var": "ssbo_dst"}) + specialize(functions["store" + store_suffix], {"var": "ssbo_dst"})
            else:
                testfun += specialize(functions["load" + load_suffix], {"var": "ssbo_src"}) + specialize(file_helpers["storeScalarF16AsUint"], {"var": "ssbo_dst"})
            frags = {"capability": "OpCapability Float16\n", "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values), "testfun": testfun}
            nulls = ",".join(str(index) for index, path in enumerate(paths) if path is None)
            cases.append((f"float16/{group}", name, frags, dict(colors, gen=f"gen=f16ci;seed={group};n={count};nulls={nulls};f16=1")))


def build_float16_logical_cases(cases):
    """createFloat16LogicalSet (float16.logical and logical_nan), graphics half, the scalar cases: a comparison of every pair of 16 binary16 values, the result selected as 1.0 or 0.0.
    The vector cases of the C++ (38416 pairs) run with `split=1`, the splitRenderArea of graphics_shader_case.rs, and as compute cases too. The templates are read out of the C++."""
    text = CPP.read_text(encoding="utf-8")
    start = text.index("createFloat16LogicalSet(tcu::TestContext &testCtx")
    body = strip_cpp_line_comments(text[start : text.index("\n}\n", start)])
    first = body.index("const StringTemplate preMain(")
    scalar = body[first : body.index("const StringTemplate preMain(", first + 10)]
    templates = cpp_templates_by_name(scalar)
    arg1_calc = templates["arg1Calc"] if "arg1Calc" in templates else decode_literals(re.search(r"const StringTemplate arg1Calc\(" + CPP_LITERALS + r"\);", scalar).group(1))
    file_helpers = {m.group(1): decode_literals(m.group(2)) for m in re.finditer(r"const string (\w+) =" + CPP_LITERALS + ";", text) if m.group(1).startswith(("load", "store"))}
    ops = ("OpIsNan", "OpIsInf", "OpFOrdEqual", "OpFUnordEqual", "OpFOrdNotEqual", "OpFUnordNotEqual", "OpFOrdLessThan", "OpFUnordLessThan", "OpFOrdGreaterThan", "OpFUnordGreaterThan",
           "OpFOrdLessThanEqual", "OpFUnordLessThanEqual", "OpFOrdGreaterThanEqual", "OpFUnordGreaterThanEqual")
    for nan in (False, True):
        group = "logical_nan" if nan else "logical"
        for index, op in enumerate(ops):
            argc = 1 if index < 2 else 2
            values = {"num_data_points": "256", "op_code": op, "op_arg1": "" if argc == 1 else "%val_src1", "op_arg1_calc": "" if argc == 1 else arg1_calc}
            testfun = specialize(templates["testFun"], values) + specialize(file_helpers["loadScalarF16FromUint"], {"var": "ssbo_src0"})
            if argc > 1:
                testfun += specialize(file_helpers["loadScalarF16FromUint"], {"var": "ssbo_src1"})
            testfun += specialize(file_helpers["storeScalarF16AsUint"], {"var": "ssbo_dst"})
            frags = {
                "capability": "OpCapability Float16\n" + ("OpCapability SignedZeroInfNanPreserve\n" if nan else ""),
                "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values), "testfun": testfun,
            }
            if nan:
                frags["extension"] = 'OpExtension "SPV_KHR_float_controls"\n'
                frags["execution_mode"] = "OpExecutionMode %BP_main SignedZeroInfNanPreserve 16\n"
            extensions = ["VK_KHR_shader_float16_int8"] + (["VK_KHR_shader_float_controls"] if nan else [])
            colors = {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": extensions}
            cases.append((f"float16/{group}", op.lower() + "_scalar", frags, dict(colors, gen=f"gen=f16lg;seed={group};op={index};nan={int(nan)};f16=1;fc16={int(nan)}")))

    vector = body[body.index("const StringTemplate preMain(", first + 10) :]
    vector_templates = cpp_templates_by_name(vector)
    vector_arg1 = decode_literals(re.search(r"const StringTemplate arg1Calc\(" + CPP_LITERALS + r"\);", vector).group(1))
    for nan in (False, True):
        group = "logical_nan" if nan else "logical"
        for index, op in enumerate(ops):
            argc = 1 if index < 2 else 2
            values = {"num_data_points": "38416", "op_code": op, "op_arg1": "" if argc == 1 else "%val_src1", "op_arg1_calc": "" if argc == 1 else vector_arg1}
            testfun = specialize(vector_templates["testFun"], values) + specialize(file_helpers["loadV2F16FromUint"], {"var": "ssbo_src0"})
            if argc > 1:
                testfun += specialize(file_helpers["loadV2F16FromUint"], {"var": "ssbo_src1"})
            testfun += specialize(file_helpers["storeV2F16AsUint"], {"var": "ssbo_dst"})
            frags = {
                "capability": "OpCapability Float16\n" + ("OpCapability SignedZeroInfNanPreserve\n" if nan else ""),
                "decoration": specialize(vector_templates["decoration"], values), "pre_main": specialize(vector_templates["preMain"], values), "testfun": testfun,
            }
            if nan:
                frags["extension"] = 'OpExtension "SPV_KHR_float_controls"\n'
                frags["execution_mode"] = "OpExecutionMode %BP_main SignedZeroInfNanPreserve 16\n"
            extensions = ["VK_KHR_shader_float16_int8"] + (["VK_KHR_shader_float_controls"] if nan else [])
            colors = {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": extensions}
            cases.append((f"float16/{group}", op.lower() + "_vector", frags, dict(colors, gen=f"gen=f16lg;seed={group};op={index};nan={int(nan)};vec=1;f16=1;fc16={int(nan)};split=1")))


def build_float16_opconstant_cases(cases):
    """createOpConstantFloat16Tests (float16.opconstant): constants of binary16 vector, struct, matrix, array and array of struct of array types, read from the C++ table."""
    text = CPP.read_text(encoding="utf-8")
    start = text.index("tcu::TestCaseGroup *createOpConstantFloat16Tests(")
    body = text[start : text.index("\n}\n", start)]
    function_start = decode_literals(re.search(r"const char functionStart\[\] =" + CPP_LITERALS + ";", body).group(1))
    function_end = decode_literals(re.search(r"const char functionEnd\[\] =" + CPP_LITERALS + ";", body).group(1))
    macro_start = body.index("#define FLOAT_16_COMMON_TYPES_AND_CONSTS")
    macro = decode_literals(body[macro_start : body.index("NameConstantsCode tests[]", macro_start)].replace("\\\n", "\n"))
    table = body[body.index("NameConstantsCode tests[] = {") : body.index("getHalfColorsFullAlpha(inputColors);")]
    table = re.sub(r"//[^\n]*", "", table).replace("FLOAT_16_COMMON_TYPES_AND_CONSTS", '"@@MACRO@@"')
    entries = re.findall(r'\{\s*\{?\s*("(?:\w+)")\s*,((?:\s*"(?:[^"\\]|\\.)*"\s*)+),((?:\s*"(?:[^"\\]|\\.)*"\s*)+)\}', table)
    assert len(entries) == 5, len(entries)
    output_colors = ((255, 255, 255, 255), (255, 127, 127, 255), (127, 255, 127, 255), (127, 127, 255, 255))
    for name_literal, constants, code in entries:
        name = name_literal.strip('"')
        constants_text = decode_literals(constants).replace("@@MACRO@@", macro)
        frags = {"capability": "OpCapability Float16\n", "pre_main": constants_text, "testfun": function_start + decode_literals(code) + function_end}
        cases.append(("float16/opconstant", name, frags, {"inc": HALF_COLORS, "outc": output_colors, "spv13": False, "ext": ["VK_KHR_shader_float16_int8"], "gen": "f16=1"}))


def build_storage16_mixed_cases(cases):
    """addGraphics16bitStructMixedTypesGroup (16bit_storage.struct_mixed_types): a struct array of mixed 16 and 32 bit members copied from the input to the output, one case per
    capability. The templates and the layouts (getStructShaderComponet) are read out of the C++, beginLoop and endLoop are the C++ ones."""
    import gen_spirv_assembly_16bit_struct_manifest as structs

    source = STORAGE16_CPP.read_text(encoding="utf-8")
    body = cpp_function_body(source, "addGraphics16bitStructMixedTypesGroup")
    templates = cpp_templates_by_name(body)
    begin_loop = cpp_templates_by_name(source[source.index("std::string beginLoop(") : source.index("std::string endLoop(")])["loopBegin"]
    end_loop = cpp_templates_by_name(source[source.index("std::string endLoop(") : source.index("std::string endLoop(") + 800])["loopEnd"]

    def loops(name, count):
        values = {"exeCount": count, "loopName": name}
        return specialize(begin_loop, values), specialize(end_loop, values)

    def mix_component(label):
        start = source.index(f"case SHADERTEMPLATE_{label}:", source.index("string getStructShaderComponet("))
        ends = [source.index(marker, start + 10) for marker in ("    case SHADERTEMPLATE_", "    default:") if marker in source[start + 10 :]]
        return structs.literals(source[start : min(ends)])

    x_begin, x_end = loops("x", "c_i32_7")
    y_begin, y_end = loops("y", "c_i32_11")
    z_begin, z_end = loops("z", "c_i32_11")
    for cap_idx, (cap_name, cap, decor, cap_flags) in enumerate(STORAGE16_CAPABILITIES):
        uniform = cap_idx == 1
        in_offsets = specialize(mix_component("STRIDEMIX_STD140" if uniform else "STRIDEMIX_STD430"), {"InOut": "In"})
        out_offsets = specialize(mix_component("STRIDEMIX_STD430"), {"InOut": "Out"})
        values = {
            "xBeginLoop": x_begin, "xEndLoop": x_end, "yBeginLoop": y_begin, "yEndLoop": y_end, "zBeginLoop": z_begin, "zEndLoop": z_end,
            "storage": "Block" if uniform else "BufferBlock", "cap": f"OpCapability {cap}" if uniform else "", "inPtr": "outPtr", "InOffsets": in_offsets, "OutOffsets": out_offsets,
        }
        frags = {
            "extension": 'OpExtension "SPV_KHR_16bit_storage"\n', "capability": specialize(templates["capabilities"], values), "decoration": specialize(templates["decoration"], values),
            "pre_main": specialize(templates["preMain"], values), "testfun": specialize(templates["testFun"], values),
        }
        gen = f"gen=s16mix;seed=struct_mixed_types;cap={cap_idx};{cap_flags}"
        cases.append(("16bit_storage/struct_mixed_types", cap_name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_16bit_storage"], "gen": gen}))


def build_storage8_struct_cases(cases):
    """addGraphics8BitStorageUniformStruct8To32Group (8struct_to_32struct) and ...Struct32To8Group (32struct_to_8struct): arrays of structs of 8 and 32 bit integers copied with a
    conversion, with the layouts of getStructShaderComponet. The templates and layouts are read out of the C++."""
    source = STORAGE8_CPP.read_text(encoding="utf-8")

    def component(label):
        start = source.index(f"case SHADERTEMPLATE_{label}:", source.index("string getStructShaderComponet("))
        ends = [source.index(marker, start + 10) for marker in ("    case SHADERTEMPLATE_", "    default:") if marker in source[start + 10 :]]
        return decode_literals(source[start : min(ends)]) or ""

    facts = (("sint", "1", "OpSConvert", "i32"), ("uint", "0", "OpUConvert", "u32"))
    capabilities = (("storage_buffer", "StorageBuffer8BitAccess"), ("uniform", "UniformAndStorageBuffer8BitAccess"))
    for function, group, to_wide in (("addGraphics8BitStorageUniformStruct8To32Group", "8struct_to_32struct", True), ("addGraphics8BitStorageUniformStruct32To8Group", "32struct_to_8struct", False)):
        body = cpp_function_body(source, function)
        templates = cpp_templates_by_name(body)
        extension = decode_literals(re.search(r'fragments\["extension"\]\s*=' + CPP_LITERALS + ";", body).group(1))
        for cap_idx, (cap_name, cap) in enumerate(capabilities):
            uniform = cap_idx == 1
            for fact_idx, (fact_name, signed, convert, type32) in enumerate(facts):
                if to_wide:
                    values = {
                        "cap": cap, "stridei8": component("STRIDE8BIT_STD140" if uniform else "STRIDE8BIT_STD430"), "stridei32": component("STRIDE32BIT_STD430"),
                        "32Storage": "StorageBuffer", "8Storage": "Uniform" if uniform else "StorageBuffer", "signed": signed, "convert": convert, "32type": type32,
                    }
                    origin, result, flags = (1 if uniform else 0), 2, ("ub8=1;uin=1" if uniform else "sb8=1")
                else:
                    values = {
                        "cap": "StorageBuffer8BitAccess", "stridei8": component("STRIDE8BIT_STD430"), "stridei32": component("STRIDE32BIT_STD140" if uniform else "STRIDE32BIT_STD430"),
                        "8Storage": "StorageBuffer", "32Storage": "Uniform" if uniform else "StorageBuffer", "signed": signed, "convert": convert, "32type": type32,
                    }
                    origin, result, flags = (3 if uniform else 2), 0, ("sb8=1;uin=1" if uniform else "sb8=1")
                frags = {
                    "extension": extension, "capability": specialize(templates["capabilities"], values), "decoration": specialize(templates["decoration"], values),
                    "pre_main": specialize(templates["preMain"], values), "testfun": specialize(templates["testFun"], values),
                }
                gen = f"gen=s8st;seed={group};dir={'8to32' if to_wide else '32to8'};draw={cap_idx * 2 + fact_idx};from={origin};to={result};{flags}"
                cases.append((f"8bit_storage/{group}", f"{cap_name}_{fact_name}", frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_8bit_storage"], "gen": gen}))


def build_storage8_mixed_cases(cases):
    """addGraphics8bitStorage8bitStructMixedTypesGroup (8bit_storage.struct_mixed_types): a struct array of mixed 8 and 32 bit members copied from the input to the output, one case per
    capability. The templates, layouts and loops are read out of the C++."""
    source = STORAGE8_CPP.read_text(encoding="utf-8")
    templates = cpp_templates_by_name(cpp_function_body(source, "addGraphics8bitStorage8bitStructMixedTypesGroup"))
    begin_loop = cpp_templates_by_name(source[source.index("std::string beginLoop(") : source.index("std::string endLoop(")])["loopBegin"]
    end_loop = cpp_templates_by_name(source[source.index("std::string endLoop(") : source.index("std::string endLoop(") + 800])["loopEnd"]

    def component(label):
        start = source.index(f"case SHADERTEMPLATE_{label}:", source.index("string getStructShaderComponet("))
        ends = [source.index(marker, start + 10) for marker in ("    case SHADERTEMPLATE_", "    default:") if marker in source[start + 10 :]]
        return decode_literals(source[start : min(ends)]) or ""

    def loops(name, count):
        values = {"exeCount": count, "loopName": name}
        return specialize(begin_loop, values), specialize(end_loop, values)

    x_begin, x_end = loops("x", "c_i32_7")
    y_begin, y_end = loops("y", "c_i32_11")
    z_begin, z_end = loops("z", "c_i32_11")
    uniform_ptr = (
        "%i8inPtr     = OpTypePointer Uniform %i8\n%v2i8inPtr   = OpTypePointer Uniform %v2i8\n%v3i8inPtr   = OpTypePointer Uniform %v3i8\n%v4i8inPtr   = OpTypePointer Uniform %v4i8\n"
        "%i32inPtr    = OpTypePointer Uniform %i32\n%v2i32inPtr  = OpTypePointer Uniform %v2i32\n%v3i32inPtr  = OpTypePointer Uniform %v3i32\n%v4i32inPtr  = OpTypePointer Uniform %v4i32\n"
    )
    for cap_idx, (cap_name, cap) in enumerate((("storage_buffer", "StorageBuffer8BitAccess"), ("uniform", "UniformAndStorageBuffer8BitAccess"))):
        uniform = cap_idx == 1
        values = {
            "xBeginLoop": x_begin, "xEndLoop": x_end, "yBeginLoop": y_begin, "yEndLoop": y_end, "zBeginLoop": z_begin, "zEndLoop": z_end,
            "inStorage": "Uniform" if uniform else "StorageBuffer", "cap": f"OpCapability {cap}" if uniform else "", "uniformPtr": uniform_ptr if uniform else "",
            "inPtr": "inPtr" if uniform else "outPtr",
            "InOffsets": specialize(component("STRIDEMIX_STD140" if uniform else "STRIDEMIX_STD430"), {"InOut": "In"}),
            "OutOffsets": specialize(component("STRIDEMIX_STD430"), {"InOut": "Out"}),
        }
        frags = {
            "extension": 'OpExtension "SPV_KHR_8bit_storage"\nOpExtension "SPV_KHR_storage_buffer_storage_class"\n', "capability": specialize(templates["capabilities"], values),
            "decoration": specialize(templates["decoration"], values), "pre_main": specialize(templates["preMain"], values), "testfun": specialize(templates["testFun"], values),
        }
        gen = f"gen=s8mix;seed=struct_mixed_types;cap={cap_idx};{'ub8=1;uin=1' if uniform else 'sb8=1'}"
        cases.append(("8bit_storage/struct_mixed_types", cap_name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "ext": ["VK_KHR_8bit_storage"], "gen": gen}))


def build_opphi_swap16_cases(cases):
    """The `swap16` case of createOpPhiTests (opphi.swap16): the swap of two components through OpPhi on binary16 values."""
    text = CPP.read_text(encoding="utf-8")
    start = text.index("tcu::TestCaseGroup *createOpPhiTests(")
    body = text[start : text.index("\n}\n", start)]
    constants = decode_literals(re.search(r"const char typesAndConstants4\[\] =" + CPP_LITERALS + ";", body).group(1))
    function = decode_literals(re.search(r"const char function4\[\] =" + CPP_LITERALS + ";", body).group(1))
    output_colors = ((127, 127, 127, 255), (127, 0, 0, 255), (0, 0, 127, 255), (0, 127, 0, 255))
    frags = {"capability": "OpCapability Float16\n", "pre_main": constants, "testfun": function}
    cases.append(("opphi", "swap16", frags, {"inc": HALF_COLORS, "outc": output_colors, "spv13": False, "ext": ["VK_KHR_shader_float16_int8"], "gen": "f16=1"}))


def f32_bytes(values):
    return struct.pack(f"<{len(values)}f", *values)


def composite_insert_matrix_declarations(cols, rows, skip_col_decl=False):
    col_type = f"%v{rows}f32"
    col_decl = "" if skip_col_decl else f"                {col_type} = OpTypeVector %f32 {rows}\n"
    mat_type = f"%mat{cols}v{rows}f"
    return col_decl + f"              {mat_type} = OpTypeMatrix {col_type} {cols}\n" + f"               %Output = OpTypeStruct {mat_type}\n"


def composite_insert_identity_vectors(cols, rows):
    text = ""
    for c in range(cols):
        text += f"            %identity{c} = OpConstantComposite %v{rows}f32 " + "".join(f"%c_f32_{'1' if c == r else '0'} " for r in range(rows)) + "\n"
    return text


def composite_insert_vector_inserts(elements, use_undef):
    text = f"                 %tmp0 = OpUndef %v{elements}f32\n" if use_undef else f"                 %tmp0 = OpLoad %v{elements}f32 %vec\n"
    for e in range(elements):
        text += f"                 %tmp{e + 1} = OpCompositeInsert %v{elements}f32 %c_f32_{e} %tmp{e} {e}\n"
    return text


def composite_insert_matrix_inserts(cols, rows, use_undef):
    mat_type = f"%mat{cols}v{rows}f"
    text = f"                 %tmp0 = OpUndef {mat_type}\n" if use_undef else f"                 %tmp0 = OpLoad {mat_type} %mat\n"
    for c in range(cols):
        text += f"                 %tmp{c + 1} = OpCompositeInsert {mat_type} %identity{c} %tmp{c} {c}\n"
    return text


def composite_insert_nested_inserts(array_size, use_undef):
    text = "                 %tmp0 = OpUndef %Output\n" if use_undef else "                 %tmp0 = OpLoad %Output %nestedstruct\n"
    for array_idx in range(array_size):
        for vector_idx in range(4):
            n = array_idx * 4 + vector_idx
            text += f"%tmp{n + 1} = OpCompositeInsert %Output %identity{vector_idx} %tmp{n} 0 0 {array_idx} {vector_idx}\n"
    return text


def build_composite_insert_cases(cases):
    """addGraphicsVectorCompositeInsertTests, addGraphicsMatrixCompositeInsertTests and addGraphicsNestedStructCompositeInsertTests of vktSpvAsmCompositeInsertTests.cpp:
    one float output buffer, compared where the expected value is not -1.0 (the padding of a three row matrix)."""

    def add(name, frags, data):
        mask = b"".join(b"\x00" * 4 if value == -1.0 else b"\xff" * 4 for value in data)
        cases.append(("composite_insert", name, frags, {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False, "out": [f32_bytes(data)], "mask": [mask]}))

    def decoration(extra=""):
        return extra + "                         OpDecorate %Output BufferBlock\n                         OpDecorate %dataOutput DescriptorSet 0\n                         OpDecorate %dataOutput Binding 0\n"

    for use_undef in (True, False):
        prefix = "undef_" if use_undef else ""
        for elements in range(2, 5):
            vec_type = f"%v{elements}f32"
            frags = {
                "pre_main": f"               %Output = OpTypeStruct {vec_type}\n"
                "  %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
                "           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
                "             %fp_v2f32 = OpTypePointer Function %v2f32\n"
                "             %fp_v3f32 = OpTypePointer Function %v3f32\n"
                f"     %_ptr_Uniform_vec = OpTypePointer Uniform {vec_type}\n"
                "              %c_f32_2 = OpConstant %f32 2\n"
                "              %c_f32_3 = OpConstant %f32 3\n",
                "decoration": decoration("                         OpMemberDecorate %Output 0 Offset 0\n"),
                "testfun": "            %test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
                "                %param = OpFunctionParameter %v4f32\n"
                "                %entry = OpLabel\n"
                f"                  %vec = OpVariable %fp_v{elements}f32 Function\n"
                + composite_insert_vector_inserts(elements, use_undef)
                + "            %vecOutPtr = OpAccessChain %_ptr_Uniform_vec %dataOutput %c_i32_0\n"
                f"                         OpStore %vecOutPtr %tmp{elements}\n"
                "                         OpReturnValue %param\n"
                "                         OpFunctionEnd\n",
            }
            add(f"{prefix}vec{elements}", frags, [float(e) for e in range(elements)])

    for use_undef in (True, False):
        prefix = "undef_" if use_undef else ""
        for rows in range(2, 5):
            matrix_stride = 16 if rows == 3 else rows * 4
            for cols in range(2, 5):
                mat_type = f"%mat{cols}v{rows}f"
                data = []
                for c in range(cols):
                    data += [1.0 if c == r else 0.0 for r in range(rows)]
                    if rows == 3:
                        data.append(-1.0)
                frags = {
                    "pre_main": composite_insert_matrix_declarations(cols, rows, True)
                    + "  %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
                    "           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n"
                    f"    %_ptr_Function_mat = OpTypePointer Function {mat_type}\n"
                    f"     %_ptr_Uniform_mat = OpTypePointer Uniform {mat_type}\n"
                    + composite_insert_identity_vectors(cols, rows),
                    "decoration": decoration(
                        "                         OpMemberDecorate %Output 0 Offset 0\n"
                        "                         OpMemberDecorate %Output 0 ColMajor\n"
                        f"                         OpMemberDecorate %Output 0 MatrixStride {matrix_stride}\n"
                    ),
                    "testfun": "            %test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
                    "                %param = OpFunctionParameter %v4f32\n"
                    "                %entry = OpLabel\n"
                    "                  %mat = OpVariable %_ptr_Function_mat Function\n"
                    + composite_insert_matrix_inserts(cols, rows, use_undef)
                    + "            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0\n"
                    f"                         OpStore %matOutPtr %tmp{cols}\n"
                    "                         OpReturnValue %param\n"
                    "                         OpFunctionEnd\n",
                }
                add(f"{prefix}mat{cols}x{rows}", frags, data)

    for use_undef in (True, False):
        array_size = 8
        data = [1.0 if c == r else 0.0 for _ in range(array_size) for c in range(4) for r in range(4)]
        frags = {
            "pre_main": "               %uint_8 = OpConstant %u32 8\n"
            "            %mat4v4f32 = OpTypeMatrix %v4f32 4\n"
            "%_arr_mat4v4f32_uint_8 = OpTypeArray %mat4v4f32 %uint_8\n"
            "                    %S = OpTypeStruct %_arr_mat4v4f32_uint_8\n"
            "               %Output = OpTypeStruct %S\n"
            "  %_ptr_Uniform_Output = OpTypePointer Uniform %Output\n"
            " %_ptr_Function_Output = OpTypePointer Function %Output\n"
            "           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform\n" + composite_insert_identity_vectors(4, 4),
            "decoration": "                         OpDecorate %_arr_mat4v4f32_uint_8 ArrayStride 64\n"
            "                         OpMemberDecorate %S 0 ColMajor\n"
            "                         OpMemberDecorate %S 0 Offset 0\n"
            "                         OpMemberDecorate %S 0 MatrixStride 16\n"
            "                         OpMemberDecorate %Output 0 Offset 0\n"
            + decoration(),
            "testfun": "            %test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n"
            "                %param = OpFunctionParameter %v4f32\n"
            "                %entry = OpLabel\n"
            "         %nestedstruct = OpVariable %_ptr_Function_Output Function\n"
            + composite_insert_nested_inserts(array_size, use_undef)
            + f"                         OpStore %dataOutput %tmp{array_size * 4}\n"
            "                         OpReturnValue %param\n"
            "                         OpFunctionEnd\n",
        }
        add(("undef_" if use_undef else "") + "nested_struct", frags, data)


def build_debug_cases(cases):
    def add(group, name, frags, in_colors=DEFAULT_COLORS, out_colors=DEFAULT_COLORS, spirv13=False):
        cases.append((group, name, frags, {"inc": in_colors, "outc": out_colors, "spv13": spirv13}))

    passthru = {"testfun": stages.PASSTHRU_TESTFUN}
    opsource_file = '%opsrcfile = OpString "foo.vert"\nOpSource GLSL 450 %opsrcfile '
    for name, code in (
        ("unknown", "OpSource Unknown 321"),
        ("essl", "OpSource ESSL 310"),
        ("glsl", "OpSource GLSL 450"),
        ("opencl_cpp", "OpSource OpenCL_CPP 120"),
        ("opencl_c", "OpSource OpenCL_C 120"),
        ("multiple", "OpSource GLSL 450\nOpSource GLSL 450"),
        ("file", opsource_file),
        ("source", opsource_file + '"void main(){}"'),
        ("longsource", opsource_file + '"' + long_utf8(65530) + 'ccc"'),
    ):
        add("opsource", name, {**passthru, "debug": code})

    opsource = '%opsrcfile = OpString "foo.vert"\nOpSource GLSL 450 %opsrcfile "void main(){}"\n'
    for name, code in (
        ("empty", opsource + 'OpSourceContinued ""'),
        ("short", opsource + 'OpSourceContinued "abcde"'),
        ("multiple", opsource + 'OpSourceContinued "abcde"\nOpSourceContinued "fghij"'),
        ("long", opsource + 'OpSourceContinued "' + long_utf8(65533) + 'ccc"'),
    ):
        add("opsourcecontinued", name, {**passthru, "debug": code})

    add(
        "opnoline",
        "opnoline",
        {
            "debug": '%name = OpString "name"\n',
            "pre_main": "OpNoLine\nOpNoLine\nOpLine %name 1 1\nOpNoLine\nOpLine %name 1 1\nOpLine %name 1 1\n"
            "%second_function = OpFunction %v4f32 None %v4f32_v4f32_function\nOpNoLine\nOpLine %name 1 1\nOpNoLine\nOpLine %name 1 1\nOpLine %name 1 1\n"
            "%second_param1 = OpFunctionParameter %v4f32\nOpNoLine\nOpNoLine\n%label_secondfunction = OpLabel\nOpNoLine\nOpReturnValue %second_param1\n"
            "OpFunctionEnd\nOpNoLine\nOpNoLine\n",
            "testfun": "OpNoLine\nOpNoLine\nOpLine %name 1 1\n%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\nOpNoLine\n%param1 = OpFunctionParameter %v4f32\n"
            "OpNoLine\nOpNoLine\n%label_testfun = OpLabel\nOpNoLine\n%val1 = OpFunctionCall %v4f32 %second_function %param1\nOpReturnValue %val1\nOpFunctionEnd\n"
            "OpLine %name 1 1\nOpNoLine\n",
        },
    )

    add(
        "opmoduleprocessed",
        "opmoduleprocessed",
        {
            "moduleprocessed": 'OpModuleProcessed "VULKAN CTS"\nOpModuleProcessed "Negative values"\nOpModuleProcessed "Date: 2017/09/21"\n',
            "pre_main": "%second_function = OpFunction %v4f32 None %v4f32_v4f32_function\n%second_param1 = OpFunctionParameter %v4f32\n%label_secondfunction = OpLabel\n"
            "OpReturnValue %second_param1\nOpFunctionEnd\n",
            "testfun": "%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\n%param1 = OpFunctionParameter %v4f32\n%label_testfun = OpLabel\n"
            "%val1 = OpFunctionCall %v4f32 %second_function %param1\nOpReturnValue %val1\nOpFunctionEnd\n",
        },
        spirv13=True,
    )

    opline_pre_main = (
        "OpLine %file_name 32 0\nOpLine %file_name 32 32\nOpLine %file_name 32 40\nOpLine %other_name 32 40\nOpLine %other_name 0 100\n"
        "OpLine %other_name 0 4294967295\nOpLine %other_name 4294967295 0\nOpLine %other_name 32 40\nOpLine %file_name 0 0\n"
        "%second_function = OpFunction %v4f32 None %v4f32_v4f32_function\nOpLine %file_name 1 0\n%second_param1 = OpFunctionParameter %v4f32\n"
        "OpLine %file_name 1 3\nOpLine %file_name 1 2\n%label_secondfunction = OpLabel\nOpLine %file_name 0 2\nOpReturnValue %second_param1\n"
        "OpFunctionEnd\nOpLine %file_name 0 2\nOpLine %file_name 0 2\n"
    )
    opline_testfun = (
        "OpLine %file_name 1 0\n%test_code = OpFunction %v4f32 None %v4f32_v4f32_function\nOpLine %file_name 16 330\n%param1 = OpFunctionParameter %v4f32\n"
        "OpLine %file_name 14 442\n%label_testfun = OpLabel\nOpLine %file_name 11 1024\n%val1 = OpFunctionCall %v4f32 %second_function %param1\n"
        "OpLine %file_name 2 97\nOpReturnValue %val1\nOpFunctionEnd\nOpLine %file_name 5 32\n"
    )
    for name, text in (("empty_name", ""), ("short_name", "short_name"), ("long_name", long_utf8(65530) + "ccc")):
        add(
            "opline",
            f"opline_{name}",
            {"debug": '%other_name = OpString "other_name"\n' + f'%file_name = OpString "{text}"\n', "pre_main": opline_pre_main, "testfun": opline_testfun},
        )

    null_tests = [
        ("vec4", "%cnull = OpConstantNull %v4f32\n", "%transformed_param = OpFAdd %v4f32 %param1 %cnull\n"),
        (
            "float",
            "%cnull = OpConstantNull %f32\n",
            "%vp = OpVariable %fp_v4f32 Function\n%v  = OpLoad %v4f32 %vp\n%v0 = OpVectorInsertDynamic %v4f32 %v %cnull %c_i32_0\n"
            "%v1 = OpVectorInsertDynamic %v4f32 %v0 %cnull %c_i32_1\n%v2 = OpVectorInsertDynamic %v4f32 %v1 %cnull %c_i32_2\n"
            "%v3 = OpVectorInsertDynamic %v4f32 %v2 %cnull %c_i32_3\n%transformed_param = OpFAdd %v4f32 %param1 %v3\n",
        ),
        (
            "bool",
            "%cnull             = OpConstantNull %bool\n",
            "%v                 = OpVariable %fp_v4f32 Function\n                     OpStore %v %param1\n                     OpSelectionMerge %false_label None\n"
            "                     OpBranchConditional %cnull %true_label %false_label\n%true_label        = OpLabel\n"
            "                     OpStore %v %c_v4f32_0_5_0_5_0_5_0_5\n                     OpBranch %false_label\n%false_label       = OpLabel\n"
            "%transformed_param = OpLoad %v4f32 %v\n",
        ),
        (
            "i32",
            "%cnull             = OpConstantNull %i32\n",
            "%v                 = OpVariable %fp_v4f32 Function %c_v4f32_0_5_0_5_0_5_0_5\n%b                 = OpIEqual %bool %cnull %c_i32_0\n"
            "                     OpSelectionMerge %false_label None\n                     OpBranchConditional %b %true_label %false_label\n"
            "%true_label        = OpLabel\n                     OpStore %v %param1\n                     OpBranch %false_label\n"
            "%false_label       = OpLabel\n%transformed_param = OpLoad %v4f32 %v\n",
        ),
        (
            "struct",
            "%stype             = OpTypeStruct %f32 %v4f32\n%fp_stype          = OpTypePointer Function %stype\n%cnull             = OpConstantNull %stype\n",
            "%v                 = OpVariable %fp_stype Function %cnull\n%f                 = OpAccessChain %fp_v4f32 %v %c_i32_1\n"
            "%f_val             = OpLoad %v4f32 %f\n%transformed_param = OpFAdd %v4f32 %param1 %f_val\n",
        ),
        (
            "array",
            "%a4_v4f32          = OpTypeArray %v4f32 %c_u32_4\n%fp_a4_v4f32       = OpTypePointer Function %a4_v4f32\n%cnull             = OpConstantNull %a4_v4f32\n",
            "%v                 = OpVariable %fp_a4_v4f32 Function %cnull\n%f                 = OpAccessChain %fp_v4f32 %v %c_u32_0\n"
            "%f1                = OpAccessChain %fp_v4f32 %v %c_u32_1\n%f2                = OpAccessChain %fp_v4f32 %v %c_u32_2\n"
            "%f3                = OpAccessChain %fp_v4f32 %v %c_u32_3\n%f_val             = OpLoad %v4f32 %f\n%f1_val            = OpLoad %v4f32 %f1\n"
            "%f2_val            = OpLoad %v4f32 %f2\n%f3_val            = OpLoad %v4f32 %f3\n%t0                = OpFAdd %v4f32 %param1 %f_val\n"
            "%t1                = OpFAdd %v4f32 %t0 %f1_val\n%t2                = OpFAdd %v4f32 %t1 %f2_val\n%transformed_param = OpFAdd %v4f32 %t2 %f3_val\n",
        ),
        (
            "matrix",
            "%mat4x4_f32        = OpTypeMatrix %v4f32 4\n%cnull             = OpConstantNull %mat4x4_f32\n",
            "%v                 = OpVectorTimesMatrix %v4f32 %param1 %cnull\n%transformed_param = OpFAdd %v4f32 %param1 %v\n",
        ),
    ]
    for name, constants, code in null_tests:
        add("opconstantnull", name, {"pre_main": constants, "testfun": FUNCTION_START + code + FUNCTION_END}, HALF_COLORS, HALF_COLORS)

    composite_tests = [
        ("vec4", "%cval              = OpConstantComposite %v4f32 %c_f32_0_5 %c_f32_0_5 %c_f32_0_5 %c_f32_0\n", "%transformed_param = OpFAdd %v4f32 %param1 %cval\n"),
        (
            "struct",
            "%stype             = OpTypeStruct %v4f32 %f32\n%fp_stype          = OpTypePointer Function %stype\n%f32_n_1           = OpConstant %f32 -1.0\n"
            "%f32_1_5           = OpConstant %f32 !0x3fc00000\n%cvec              = OpConstantComposite %v4f32 %f32_1_5 %f32_1_5 %f32_1_5 %c_f32_1\n"
            "%cval              = OpConstantComposite %stype %cvec %f32_n_1\n",
            "%v                 = OpVariable %fp_stype Function %cval\n%vec_ptr           = OpAccessChain %fp_v4f32 %v %c_u32_0\n"
            "%f32_ptr           = OpAccessChain %fp_f32 %v %c_u32_1\n%vec_val           = OpLoad %v4f32 %vec_ptr\n%f32_val           = OpLoad %f32 %f32_ptr\n"
            "%tmp1              = OpVectorTimesScalar %v4f32 %c_v4f32_1_1_1_1 %f32_val\n%tmp2              = OpFAdd %v4f32 %tmp1 %param1\n"
            "%transformed_param = OpFAdd %v4f32 %tmp2 %vec_val\n",
        ),
        (
            "matrix",
            "%mat4x4_f32          = OpTypeMatrix %v4f32 4\n%v4f32_1_0_0_0       = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0\n"
            "%v4f32_0_1_0_0       = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0\n"
            "%v4f32_0_0_1_0       = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_1 %c_f32_0\n"
            "%v4f32_0_5_0_5_0_5_1 = OpConstantComposite %v4f32 %c_f32_0_5 %c_f32_0_5 %c_f32_0_5 %c_f32_1\n"
            "%cval                = OpConstantComposite %mat4x4_f32 %v4f32_1_0_0_0 %v4f32_0_1_0_0 %v4f32_0_0_1_0 %v4f32_0_5_0_5_0_5_1\n",
            "%transformed_param   = OpMatrixTimesVector %v4f32 %cval %param1\n",
        ),
        (
            "array",
            "%c_v4f32_1_1_1_0     = OpConstantComposite %v4f32 %c_f32_1 %c_f32_1 %c_f32_1 %c_f32_0\n%fp_a4f32            = OpTypePointer Function %a4f32\n"
            "%f32_n_1             = OpConstant %f32 -1.0\n%f32_1_5             = OpConstant %f32 !0x3fc00000\n"
            "%carr                = OpConstantComposite %a4f32 %c_f32_0 %f32_n_1 %f32_1_5 %c_f32_0\n",
            "%v                   = OpVariable %fp_a4f32 Function %carr\n%f                   = OpAccessChain %fp_f32 %v %c_u32_0\n"
            "%f1                  = OpAccessChain %fp_f32 %v %c_u32_1\n%f2                  = OpAccessChain %fp_f32 %v %c_u32_2\n"
            "%f3                  = OpAccessChain %fp_f32 %v %c_u32_3\n%f_val               = OpLoad %f32 %f\n%f1_val              = OpLoad %f32 %f1\n"
            "%f2_val              = OpLoad %f32 %f2\n%f3_val              = OpLoad %f32 %f3\n%ftot1               = OpFAdd %f32 %f_val %f1_val\n"
            "%ftot2               = OpFAdd %f32 %ftot1 %f2_val\n%ftot3               = OpFAdd %f32 %ftot2 %f3_val\n"
            "%add_vec             = OpVectorTimesScalar %v4f32 %c_v4f32_1_1_1_0 %ftot3\n%transformed_param   = OpFAdd %v4f32 %param1 %add_vec\n",
        ),
        (
            "array_of_struct_of_array",
            "%c_v4f32_1_1_1_0     = OpConstantComposite %v4f32 %c_f32_1 %c_f32_1 %c_f32_1 %c_f32_0\n%fp_a4f32            = OpTypePointer Function %a4f32\n"
            "%stype               = OpTypeStruct %f32 %a4f32\n%a3stype             = OpTypeArray %stype %c_u32_3\n%fp_a3stype          = OpTypePointer Function %a3stype\n"
            "%ca4f32_0            = OpConstantComposite %a4f32 %c_f32_0 %c_f32_0_5 %c_f32_0 %c_f32_0\n"
            "%ca4f32_1            = OpConstantComposite %a4f32 %c_f32_1 %c_f32_1 %c_f32_1 %c_f32_1\n"
            "%cstype1             = OpConstantComposite %stype %c_f32_0 %ca4f32_1\n%cstype2             = OpConstantComposite %stype %c_f32_1 %ca4f32_0\n"
            "%carr                = OpConstantComposite %a3stype %cstype1 %cstype2 %cstype1\n",
            "%v                   = OpVariable %fp_a3stype Function %carr\n%f                   = OpAccessChain %fp_f32 %v %c_u32_1 %c_u32_1 %c_u32_1\n"
            "%f_l                 = OpLoad %f32 %f\n%add_vec             = OpVectorTimesScalar %v4f32 %c_v4f32_1_1_1_0 %f_l\n"
            "%transformed_param   = OpFAdd %v4f32 %param1 %add_vec\n",
        ),
    ]
    for name, constants, code in composite_tests:
        add("opconstantcomposite", name, {"pre_main": constants, "testfun": FUNCTION_START + code + FUNCTION_END}, HALF_COLORS, COMPOSITE_OUT_COLORS)

    memory_pre_main = (
        "%c_a2f32_1         = OpConstantComposite %a2f32 %c_f32_1 %c_f32_1\n%fp_a2f32          = OpTypePointer Function %a2f32\n"
        "%stype             = OpTypeStruct  %v4f32 %a2f32 %f32\n%fp_stype          = OpTypePointer Function %stype\n"
    )
    memory_function = (
        "%test_code         = OpFunction %v4f32 None %v4f32_v4f32_function\n%param1            = OpFunctionParameter %v4f32\n%lbl               = OpLabel\n"
        "%v1                = OpVariable %fp_v4f32 Function\n%v2                = OpVariable %fp_a2f32 Function\n%v3                = OpVariable %fp_f32 Function\n"
        "%v                 = OpVariable %fp_stype Function\n%vv                = OpVariable %fp_stype Function\n%vvv               = OpVariable %fp_f32 Function\n"
        "                     OpStore %v1 %c_v4f32_1_1_1_1\n                     OpStore %v2 %c_a2f32_1\n                     OpStore %v3 %c_f32_1\n"
        "%p_v4f32          = OpAccessChain %fp_v4f32 %v %c_u32_0\n%p_a2f32          = OpAccessChain %fp_a2f32 %v %c_u32_1\n"
        "%p_f32            = OpAccessChain %fp_f32 %v %c_u32_2\n%v1_v             = OpLoad %v4f32 %v1 ${access_type}\n"
        "%v2_v             = OpLoad %a2f32 %v2 ${access_type}\n%v3_v             = OpLoad %f32 %v3 ${access_type}\n"
        "                    OpStore %p_v4f32 %v1_v ${access_type}\n                    OpStore %p_a2f32 %v2_v ${access_type}\n"
        "                    OpStore %p_f32 %v3_v ${access_type}\n                    OpCopyMemory %vv %v ${access_type}\n"
        "                    OpCopyMemory %vvv %p_f32 ${access_type}\n%p_f32_2          = OpAccessChain %fp_f32 %vv %c_u32_2\n"
        "%v_f32_2          = OpLoad %f32 %p_f32_2\n%v_f32_3          = OpLoad %f32 %vvv\n%ret1             = OpVectorTimesScalar %v4f32 %param1 %v_f32_2\n"
        "%ret2             = OpVectorTimesScalar %v4f32 %ret1 %v_f32_3\n                    OpReturnValue %ret2\n                    OpFunctionEnd\n"
    )
    for name, access in (
        ("none", ""),
        ("volatile", "Volatile"),
        ("aligned", "Aligned 1"),
        ("volatile_aligned", "Volatile|Aligned 1"),
        ("nontemporal_aligned", "Nontemporal|Aligned 1"),
        ("volatile_nontemporal", "Volatile|Nontemporal"),
        ("volatile_nontermporal_aligned", "Volatile|Nontemporal|Aligned 1"),
    ):
        add("opmemoryaccess", name, {"pre_main": memory_pre_main, "testfun": memory_function.replace("${access_type}", access)}, HALF_COLORS, HALF_COLORS)


def build_abuse_cases(cases):
    abuse = name_abuse_cases()
    plain = {"inc": DEFAULT_COLORS, "outc": DEFAULT_COLORS, "spv13": False}

    def opname(name, debug):
        cases.append(("opname_abuse", name, {"testfun": OPNAME_TESTFUN, "debug": debug}, plain))

    for suffix, param in abuse:
        opname("main" + suffix, f'OpName %BP_main "{param}"')
    for suffix, param in abuse:
        opname("b" + suffix, f'OpName %b "{param}"')
    opname("everything_named", 'OpName %test_code "name1"\nOpName %param1    "name2"\nOpName %a         "name3"\nOpName %b         "name4"\nOpName %c         "name5"\nOpName %ret       "name6"\n')
    opname("everything_named_the_same", "".join(f'OpName %{n} "the_same"\n' for n in ("test_code", "param1   ", "a        ", "b        ", "c        ", "ret      ")))
    opname("main_has_multiple_names", 'OpName %BP_main "to_be"\nOpName %BP_main "or_not"\nOpName %BP_main "to_be"\n')
    opname("b_has_multiple_names", 'OpName %b "to_be"\nOpName %b "or_not"\nOpName %b "to_be"\n')

    def opmember(name, debug):
        cases.append(("opmembername_abuse", name, {"pre_main": OPMEMBERNAME_PRE_MAIN, "testfun": OPMEMBERNAME_TESTFUN, "debug": debug}, plain))

    for suffix, param in abuse:
        opmember("f3str_x" + suffix, f'OpMemberName %f3str 0 "{param}"')
    opmember("everything_named", 'OpMemberName %f3str 0 "name1"\nOpMemberName %f3str 1 "name2"\nOpMemberName %f3str 2 "name3"\n')
    opmember("everything_named_the_same", 'OpMemberName %f3str 0 "the_same"\nOpMemberName %f3str 1 "the_same"\nOpMemberName %f3str 2 "the_same"\n')
    opmember(
        "f3str_x_has_multiple_names",
        'OpMemberName %f3str 0 "to_be"\nOpMemberName %f3str 1 "or_not"\nOpMemberName %f3str 0 "to_be"\nOpMemberName %f3str 2 "makes_no"\n'
        'OpMemberName %f3str 0 "difference"\nOpMemberName %f3str 0 "to_me"\n',
    )


def main():
    write_templates()
    write_compute_template()
    cases = build_cases()
    header = (
        "# Shader manifest for the fragment-only graphics groups of dEQP-VK.spirv_assembly.instruction.graphics.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_graphics_fragments_manifest.py - do not hand-edit.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/graphics_fragments_tests"\n'
    )
    entries = []
    names = set()
    compute_entries = []
    for group, name, frags, options in cases:
        spec = ";".join(
            (
                "inc=" + bytes(c for color in options["inc"] for c in color).hex(),
                "outc=" + bytes(c for color in options["outc"] for c in color).hex(),
                f"spv13={int(options['spv13'])}",
                "out=" + ",".join(buffer.hex() for buffer in options.get("out", ())),
                "ext=" + ",".join(options.get("ext", ())),
                *((f"minor={options['minor']}",) if "minor" in options else ()),
                *((options["gen"],) if "gen" in options else ()),
                "mask=" + ",".join(buffer.hex() for buffer in options.get("mask", ())),
            )
        )
        version = f"spirv1.{options['minor']}" if "minor" in options else ("spirv1.3" if options["spv13"] else "spirv1.0")
        if group.startswith("float16/") and group != "float16/opconstant":
            derived = ", ".join(f"{key} = {json.dumps(repr(frags.get(key, '')), ensure_ascii=False)}" for key in KEYS)
            path = f"{group}/{name}"
            compute_entries.append(
                f'\n[[case]]\nname = "{path}"\nrust_const = "CMP_{re.sub("[^A-Za-z0-9]", "_", path).upper()}"\nrust_type = "ComputeFragmentsCase"\n'
                f'programs = [ {{ name = "compute", template = "spirv_assembly/gfx_comp.asm", stage = "asm", spirv_version = "{version}" }} ]\n'
                f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\nderived = {{ {derived} }}\n'
            )
        if options.get("compute_only"):
            continue
        for stage in options.get("stages", ALL_STAGES):
            path = f"{group}/{name}" if options.get("exact") else f"{group}/{name}_{stage}"
            names.add(path)
            programs = ", ".join(
                f'{{ name = "{p}", template = "spirv_assembly/gfx_{p}{"" if p == stage else "_passthru"}.asm", stage = "asm", spirv_version = "{version}" }}'
                for p in stages.PIPELINES[stage]
            )
            derived = ", ".join(f"{key} = {json.dumps(repr(frags.get(key, '')), ensure_ascii=False)}" for key in KEYS)
            if "custom" in options:
                programs = ", ".join(f'{{ name = "{p}", template = "{template}", stage = "asm", spirv_version = "{version}" }}' for p, template in options["custom"])
                derived = ", ".join(f"{key} = {json.dumps(repr(value))}" for key, value in frags.items())
            entries.append(
                f'\n[[case]]\nname = "{path}"\nrust_const = "GFX_{re.sub("[^A-Za-z0-9]", "_", path).upper()}"\nrust_type = "GraphicsFragmentsCase"\n'
                f'programs = [ {programs} ]\nparams = {{ spec = {{ type = "str", value = "{spec}" }} }}\nderived = {{ {derived} }}\n'
            )
    OUT.write_text(header + "".join(entries), encoding="utf-8")
    compute_header = (
        "# Shader manifest for the fragment-only compute groups of dEQP-VK.spirv_assembly.instruction.compute.float16.* (the same fragments as the graphics ones, in makeComputeShaderAssembly)\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_graphics_fragments_manifest.py - do not hand-edit.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/graphics_fragments_tests"\n'
    )
    COMPUTE_OUT.write_text(compute_header + "".join(compute_entries), encoding="utf-8")
    print(f"{len(compute_entries)} compute cases -> {COMPUTE_OUT}", file=sys.stderr)
    missing = Path(HERE.parent.parent / "tmp" / "missing" / "spirv_assembly.txt").read_text().splitlines()
    want = {line.split("instruction.graphics.", 1)[1].replace(".", "/") for line in missing if re.search(r"instruction\.graphics\.(" + "|".join(sorted({c[0] for c in cases})) + r")\.", line)}
    want |= {w for w in want if False}
    print(f"{len(entries)} cases -> {OUT}; mustpass {len(want)}, missing {len(want - names)}, extra {len(names - want)}", file=sys.stderr)


if __name__ == "__main__":
    main()

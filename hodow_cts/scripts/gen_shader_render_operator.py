#!/usr/bin/env python3
"""Writes the GLSL of the table-driven cases of dEQP-VK.glsl.operator (shaderrender/vktShaderRenderOperatorTests.cpp), their manifest and the case table of the Rust side.

The `BuiltinOperInfo(..)` / `BuiltinFuncInfo(..)` entries with literal names are read from the vendored C++ (unary operators, the comparison, equality and logical operators of
the binary group, the common functions, the float, int and bool comparison groups) and expanded the way `ShaderOperatorTests::init` and `ShaderOperatorCase::setupShaderData`
do. The binary operators of the `isNormalOp` loop are expanded from the loop body (three variants, the shift loops unrolled); the selection and the sequence cases are not read.

  * shaders/manifest/shader_render_operator.toml and shaders/src/shader_render_operator/,
  * src/vkt/tests/glsl/shader_render_operator_cases.rs (the case table).

Run from hodow_cts/:  python3 scripts/gen_shader_render_operator.py   (then `just cts-shaders`)
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CPP = ROOT / "upstream/external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderOperatorTests.cpp"
SRC = ROOT / "shaders" / "src" / "shader_render_operator"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render_operator.toml"
TABLE = ROOT / "src" / "vkt" / "tests" / "glsl" / "shader_render_operator_cases.rs"

IN_SWIZZLES = [["z", "wy", "zxy", "yzwx"], ["x", "yx", "yzx", "wzyx"], ["y", "zy", "wyz", "xwzy"]]
OUT_SWIZZLES = ["x", "yz", "xyz", "xyzw"]
OUT_MASKS = [(1, 0, 0, 0), (0, 1, 1, 0), (1, 1, 1, 0), (1, 1, 1, 1)]
SCALAR = {"F", "B", "I", "U"}
KIND_OF = {"F": "f", "FV": "f", "GT": "f", "V3": "f", "B": "b", "BV": "b", "BGT": "b", "I": "i", "IV": "i", "IGT": "i", "U": "u", "UV": "u", "UGT": "u"}
GLSL_TYPE = {"f": ["float", "vec2", "vec3", "vec4"], "i": ["int", "ivec2", "ivec3", "ivec4"], "u": ["uint", "uvec2", "uvec3", "uvec4"], "b": ["bool", "bvec2", "bvec3", "bvec4"]}
FUNC_SIZES = {"BOOL_FUNCS": (1,), "FLOAT_VEC_FUNCS": (2, 3, 4), "INT_VEC_FUNCS": (2, 3, 4), "UINT_VEC_FUNCS": (2, 3, 4), "BOOL_VEC_FUNCS": (2, 3, 4),
              "FLOAT_GENTYPE_FUNCS": (1, 2, 3, 4), "INT_GENTYPE_FUNCS": (1, 2, 3, 4), "UINT_GENTYPE_FUNCS": (1, 2, 3, 4), "BOOL_GENTYPE_FUNCS": (1, 2, 3, 4)}
PRECISIONS = {1: "mediump", 2: "highp"}


def split_args(text, start):
    args, depth, current, ndx = [], 0, [], start
    while True:
        ch = text[ndx]
        if ch == '"':
            end = ndx + 1
            while text[end] != '"':
                end += 2 if text[end] == "\\" else 1
            current.append(text[ndx : end + 1])
            ndx = end + 1
            continue
        if ch in "({[":
            depth += 1
        elif ch in ")}]":
            if depth == 0:
                args.append("".join(current).strip())
                return args, ndx
            depth -= 1
        elif ch == "," and depth == 0:
            args.append("".join(current).strip())
            current = []
            ndx += 1
            continue
        current.append(ch)
        ndx += 1


def number(text):
    return float(text.strip().rstrip("f"))


def value(text):
    match = re.fullmatch(r"Value\((\w+),\s*([^,]+),\s*([^)]+)\)", text.strip())
    return (match.group(1), number(match.group(2)), number(match.group(3)))


def fmt(x):
    return "%g" % x


def two_valued(first, second, mask):
    return "vec4(" + ", ".join(first if m else second for m in mask) + ")"


def parse_entries(text):
    start = text.index("void ShaderOperatorTests::init")
    text = text[start:]
    events = []
    for m in re.finditer(r'BuiltinFuncGroup\(\s*"(\w+)"|BuiltinFuncGroup binaryOpGroup\(\s*"(\w+)"|binaryOpGroup\s*(?=<<)', text):
        events.append((m.start(), "group", m.group(1) or m.group(2) or "binary_operator"))
    for m in re.finditer(r'<<\s*(Builtin(?:Post)?(?:SideEff)?(?:Oper|Func)Info)\(\s*"', text):
        events.append((m.start(), "info", m.group(1)))
    events.sort()
    entries, current = [], None
    for pos, kind, payload in events:
        if kind == "group":
            current = payload
            continue
        paren = text.index("(", pos + 2)
        args, _ = split_args(text, paren + 1)
        entries.append((current, payload, args))
    return entries


def expand_binary_loop(text):
    """The `operInfoFunc(..)` entries of the three `binaryOperatorType` variants (normal, assignment effect, assignment result) of upstream's loop."""
    init = text[text.index("void ShaderOperatorTests::init") :]
    header_start = init.index("const bool isAssignRes")
    start = init.index("DE_ASSERT(operInfoFunc != nullptr);")
    end = init.index("// Rest of binary operators.")
    header = init[header_start:start]
    body = init[start:end]
    three_way = {m.group(1): (m.group(2), m.group(3), m.group(4)) for m in re.finditer(r'const char \*(\w+)\s*=\s*isNormalOp\s*\?\s*"([^"]*)"\s*:\s*isAssignEff\s*\?\s*"([^"]*)"\s*:\s*"([^"]*)";', header)}
    two_way = {m.group(1): (m.group(2), m.group(3)) for m in re.finditer(r'const char \*(\w+)\s*=\s*isNormalOp\s*\?\s*"([^"]*)"\s*:\s*"([^"]*)";', header)}

    def unroll(match):
        block = re.sub(r"\s*ValueType (?:g|s)Type = [^;]*;", "", match.group(1))
        return "".join(re.sub(r"\bgType\b", g, re.sub(r"\bsType\b", sc, block)) for g, sc in (("UGT", "U"), ("IGT", "I")))

    body = re.sub(r"for \(int isSignedAmount[^)]*\)\s*\{(.*?)\n        \}\n", lambda m: unroll(m) + "\n", body, flags=re.S)
    entries = []
    for variant in range(3):
        text_v = body
        for name, values in three_way.items():
            text_v = re.sub(rf"\b{name}\b", '"' + values[variant] + '"', text_v)
        for name, values in two_way.items():
            text_v = re.sub(rf"\b{name}\b", '"' + values[0 if variant == 0 else 1] + '"', text_v)
        info = "BuiltinSideEffOperInfo" if variant == 1 else "BuiltinOperInfo"
        for m in re.finditer(r"<<\s*operInfoFunc\(", text_v):
            before = text_v[: m.start()]
            group_pos = before.rfind("binaryOpGroup")
            if "if (isNormalOp)" in text_v[max(0, group_pos - 30) : group_pos] and variant != 0:
                continue
            args, _ = split_args(text_v, m.end())
            entries.append(("binary_operator", info, args))
    return entries


def build_cases(entries):
    cases = []
    inner_seen = {}
    for group, info_kind, args in entries:
        case_name, func_name, out_value = args[0].strip('"'), args[1].strip('"'), args[2]
        inputs = [value(a) if a.startswith("Value(") else None for a in args[3:6]]
        inputs = [i for i in inputs]
        scale, bias = number(args[6]), number(args[7])
        rest = args[8:]
        if len(rest) in (2, 4) and "FUNCS" not in rest[1] and not rest[1].startswith("eval_") and "PRECMASK" not in rest[1]:
            pass
        ref_scale, ref_bias = scale, bias
        # [refScale, refBias,] precMask, funcs [, type, isUnaryPrefix]
        ndx = 0
        if not rest[0].startswith("PRECMASK"):
            ref_scale, ref_bias = number(rest[0]), number(rest[1])
            ndx = 2
        prec_mask = rest[ndx]
        funcs = rest[ndx + 1]
        func_match = re.fullmatch(r"(\w+_FUNCS)\((\w+)\)", funcs)
        scalar_match = re.fullmatch(r"eval_(\w+?)_(?:float|int|uint|bool)", funcs)
        if func_match:
            sizes = FUNC_SIZES[func_match.group(1)]
            eval_name = func_match.group(2)
            extra = rest[ndx + 2 :]
        elif scalar_match and rest[ndx + 2 : ndx + 5] == ["nullptr"] * 3:
            # a scalar-only entry spells out its four evaluation functions
            sizes = (1,)
            eval_name = scalar_match.group(1)
            extra = rest[ndx + 5 :]
        else:
            continue
        op_type = {"BuiltinOperInfo": "operator", "BuiltinPostOperInfo": "operator", "BuiltinSideEffOperInfo": "side_effect", "BuiltinPostSideEffOperInfo": "side_effect", "BuiltinFuncInfo": "function"}[info_kind]
        if info_kind == "BuiltinFuncInfo" and extra:
            op_type = "side_effect" if "SIDE_EFFECT" in extra[0] else ("operator" if "OPERATOR" in extra[0] else "function")
        unary_prefix = not (info_kind in ("BuiltinPostOperInfo", "BuiltinPostSideEffOperInfo") or (len(extra) > 1 and extra[1] == "false"))
        is_bool_case = prec_mask == "PRECMASK_NA"
        mask_bits = {"PRECMASK_NA": 0, "PRECMASK_MEDIUMP": 1 << 1, "PRECMASK_HIGHP": 1 << 2, "PRECMASK_ALL": (1 << 1) | (1 << 2)}[prec_mask]
        out_kind = KIND_OF[out_value]
        key = (group, case_name)
        for in_size in (1, 2, 3, 4):
            if in_size not in sizes:
                continue
            out_size = 1 if out_value in ("F", "B") else in_size
            for precision in (1, 2):
                if not ((mask_bits & (1 << precision)) or (mask_bits == 0 and precision == 1)):
                    continue
                precision_prefix = "" if is_bool_case else PRECISION_NAME(precision) + "_"
                for shader_name, is_vertex in (("vertex", True), ("fragment", False)):
                    is_unary = inputs[1] is None
                    name = precision_prefix
                    shader_op = "res = "
                    spec_inputs = []
                    if op_type == "operator":
                        if is_unary and unary_prefix:
                            shader_op += func_name
                    elif op_type == "function":
                        shader_op += func_name + "("
                    else:
                        shader_op += "in0;\n\t"
                    for input_ndx in range(3):
                        prev = inputs[0] if input_ndx == 1 else (inputs[1] if input_ndx == 2 else inputs[2])
                        cur = inputs[input_ndx]
                        if cur is None:
                            continue
                        prev_size = 1 if (prev is not None and prev[0] in SCALAR) else in_size
                        prev_type = GLSL_TYPE[KIND_OF[prev[0]]][prev_size - 1] if prev is not None else None
                        cur_size = 1 if cur[0] in SCALAR else in_size
                        cur_type = GLSL_TYPE[KIND_OF[cur[0]]][cur_size - 1]
                        if input_ndx == 0 or prev_type != cur_type:
                            name += cur_type + "_"
                        if op_type in ("operator", "function"):
                            if input_ndx != 0:
                                shader_op += (" " + func_name + " ") if (op_type == "operator" and not is_unary) else ", "
                            shader_op += f"in{input_ndx}"
                            if op_type == "operator" and is_unary and not unary_prefix:
                                shader_op += func_name
                        else:
                            if input_ndx != 0 or (is_unary and unary_prefix):
                                shader_op += ("" if is_unary else " ") + func_name + ("" if is_unary else " ")
                            shader_op += "res" if input_ndx == 0 else f"in{input_ndx}"
                            if is_unary and not unary_prefix:
                                shader_op += func_name
                        spec_inputs.append((KIND_OF[cur[0]], cur_size, cur[1], cur[2]))
                    if op_type == "function":
                        shader_op += ")"
                    shader_op += ";"
                    name += shader_name
                    out_type = GLSL_TYPE[out_kind][out_size - 1]
                    glsl = shader_source(is_vertex, None if is_bool_case else PRECISIONS[precision], spec_inputs, out_type, out_kind, out_size, scale, bias, shader_op)
                    cases.append(dict(group=group, inner=case_name, name=name, is_vertex=is_vertex, eval=eval_name, inputs=spec_inputs, out_kind=out_kind, out_size=out_size,
                                      scale=scale, bias=bias, ref_scale=ref_scale, ref_bias=ref_bias, vtx=glsl[0], frag=glsl[1]))
    return cases


def PRECISION_NAME(precision):
    return PRECISIONS[precision]


def shader_source(is_vertex, precision, inputs, out_type, out_kind, out_size, scale, bias, shader_op):
    vtx = "#version 310 es\n"
    frag = "#version 310 es\n"
    input_precision = []
    for kind, _, _, _ in inputs:
        input_precision.append("mediump" if kind == "b" else ("highp" if kind in "iu" else (precision or "mediump")))
    vtx += "layout(location = 0) in highp vec4 a_position;\n"
    for ndx, prec in enumerate(input_precision):
        vtx += f"layout(location = {4 + ndx}) in {prec} vec4 a_in{ndx};\n"
    frag += "layout(location = 0) out mediump vec4 o_color;\n"
    if is_vertex:
        vtx += "layout(location = 0) out mediump vec4 v_color;\n"
        frag += "layout(location = 0) in mediump vec4 v_color;\n"
    else:
        for ndx, prec in enumerate(input_precision):
            vtx += f"layout(location = {ndx + 1}) out {prec} vec4 v_in{ndx};\n"
            frag += f"layout(location = {ndx + 1}) in {prec} vec4 v_in{ndx};\n"
    vtx += "\nvoid main()\n{\n    gl_Position = a_position;\n"
    frag += "\nvoid main()\n{\n"
    op = ""
    prefix = "a_" if is_vertex else "v_"
    for ndx, (kind, size, _, _) in enumerate(inputs):
        type_name = GLSL_TYPE[kind][size - 1]
        swizzle = IN_SWIZZLES[ndx][size - 1]
        op += "\t"
        if precision and kind != "b":
            op += precision + " "
        op += f"{type_name} in{ndx} = "
        if kind == "b":
            op += "(" if size == 1 else "greaterThan("
        elif kind in "iu":
            op += type_name + "("
        op += f"{prefix}in{ndx}.{swizzle}"
        if kind == "b":
            op += " > 0.0)" if size == 1 else f", vec{size}(0.0))"
        elif kind in "iu":
            op += ")"
        op += ";\n"
    op += "\t"
    if precision and out_kind != "b":
        op += precision + " "
    op += f"{out_type} res = {out_type}(0.0);\n\n"
    op += "\t" + shader_op + "\n\n"
    op += "\thighp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);\n"
    op += f"\tcolor.{OUT_SWIZZLES[out_size - 1]} = "
    if out_kind != "f" and out_size == 1:
        op += "float(res)"
    elif out_kind != "f":
        op += f"vec{out_size}(res)"
    else:
        op += "res"
    op += ";\n"
    if scale != 1.0 or bias != 0.0:
        op += "\tcolor = color"
        if scale != 1.0:
            op += " * " + two_valued(fmt(scale), "1.0", OUT_MASKS[out_size - 1])
        if bias != 0.0:
            op += " + " + two_valued("%.2f" % bias, "0.0", OUT_MASKS[out_size - 1])
        op += ";\n"
    if is_vertex:
        vtx += op + "    v_color = color;\n"
        frag += "    o_color = v_color;\n"
    else:
        vtx += "".join(f"    v_in{ndx} = a_in{ndx};\n" for ndx in range(len(inputs)))
        frag += op + "    o_color = color;\n"
    return vtx + "}\n", frag + "}\n"


def selection_cases():
    """The `?:` cases of `ShaderOperatorTests::init`: `res = in0 ? in1 : in2;` over every type, directly in the group `selection`."""
    cases = []
    for kind in ("f", "i", "u", "b"):
        for size in (1, 2, 3, 4):
            if kind == "b":
                scale, bias, lo, hi = 1.0, 0.0, -1.0, 1.0
            elif kind == "f":
                scale, bias, lo, hi = 0.5, 0.5, -1.0, 1.0
            elif kind == "u":
                scale, bias, lo, hi = 0.5, 0.0, 0.0, 2.0
            else:
                scale, bias, lo, hi = 0.1, 0.5, -5.0, 5.0
            for precision in (1, 2):
                if kind == "b" and precision != 1:
                    continue
                prefix = "" if kind == "b" else PRECISIONS[precision] + "_"
                for shader_name, is_vertex in (("vertex", True), ("fragment", False)):
                    inputs = [("b", 1, -1.0, 1.0), (kind, size, lo, hi), (kind, size, lo, hi)]
                    out_type = GLSL_TYPE[kind][size - 1]
                    glsl = shader_source(is_vertex, None if kind == "b" else PRECISIONS[precision], inputs, out_type, kind, size, scale, bias, "res = in0 ? in1 : in2;")
                    cases.append(dict(group="selection", inner="", name=f"{prefix}{out_type}_{shader_name}", is_vertex=is_vertex, eval="selection", inputs=inputs, out_kind=kind, out_size=size,
                                      scale=scale, bias=bias, ref_scale=scale, ref_bias=bias, vtx=glsl[0], frag=glsl[1]))
    return cases


def sequence_cases():
    """The comma operator cases of `ShaderOperatorTests::init`; their evaluation functions are the `seq_*` ones of the Rust side."""
    table = [
        (False, "vec4", "in0, in2 + in1, in1 + in0", ["f4", "f4", "f4"], "f4", "seq_nse0"),
        (False, "float_uint", "in0 + in2, in1 + in1", ["f1", "u1", "f1"], "u1", "seq_nse1"),
        (False, "bool_vec2", "in0 && in1, in0, ivec2(vec2(in0) + in2)", ["b1", "b1", "f2"], "i2", "seq_nse2"),
        (False, "vec4_ivec4_bvec4", "in0 + vec4(in1), in2, in1", ["f4", "i4", "b4"], "i4", "seq_nse3"),
        (True, "vec4", "in0++, in1 = in0 + in2, in2 = in1", ["f4", "f4", "f4"], "f4", "seq_se0"),
        (True, "float_uint", "in1++, in0 = float(in1), in1 = uint(in0 + in2)", ["f1", "u1", "f1"], "u1", "seq_se1"),
        (True, "bool_vec2", "in1 = in0, in2++, in2 = in2 + vec2(in1), ivec2(in2)", ["b1", "b1", "f2"], "i2", "seq_se2"),
        (True, "vec4_ivec4_bvec4", "in0 = in0 + vec4(in2), in1 = in1 + ivec4(in0), in1++", ["f4", "i4", "b4"], "i4", "seq_se3"),
    ]
    ranges = {"f": (-0.5, 0.5), "i": (-2.0, 2.0), "u": (0.0, 2.0), "b": (-1.0, 1.0)}
    cases = []
    for side_effects, case_name, expression, input_types, result, eval_name in table:
        for precision in (1, 2):
            for shader_name, is_vertex in (("vertex", True), ("fragment", False)):
                inputs = [(t[0], int(t[1]), ranges[t[0]][0], ranges[t[0]][1]) for t in input_types]
                out_kind, out_size = result[0], int(result[1])
                glsl = shader_source(is_vertex, PRECISIONS[precision], inputs, GLSL_TYPE[out_kind][out_size - 1], out_kind, out_size, 0.5, 0.0, f"res = ({expression});")
                cases.append(dict(group="sequence", inner="side_effects" if side_effects else "no_side_effects", name=f"{PRECISIONS[precision]}_{case_name}_{shader_name}", is_vertex=is_vertex,
                                  eval=eval_name, inputs=inputs, out_kind=out_kind, out_size=out_size, scale=0.5, bias=0.0, ref_scale=0.5, ref_bias=0.0, vtx=glsl[0], frag=glsl[1]))
    return cases


def main():
    text = CPP.read_text()
    cases = build_cases(parse_entries(text) + expand_binary_loop(text)) + selection_cases() + sequence_cases()
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for dEQP-VK.glsl.operator (the table-driven cases).",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_operator.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderOperatorTests.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    table = [
        "// @generated by hodow_cts/scripts/gen_shader_render_operator.py - do not hand-edit.",
        "//",
        "// The table-driven cases of dEQP-VK.glsl.operator: tree path, shader type, evaluation function name, inputs (kind, size, range) and output.",
        "",
        "use super::shader_render_operator_tests::{OperatorCaseData, OperatorInput};",
        "",
        f"pub static OPERATOR_CASES: [OperatorCaseData; {len(cases)}] = [",
    ]
    seen = set()
    for c in cases:
        key = f"sr_operator_{c['group']}_{c['inner']}_{c['name']}".replace("__", "_")
        if key in seen:
            raise SystemExit("duplicate case " + key)
        seen.add(key)
        out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
        for program_name, stage, source in (("vert", "vert", c["vtx"]), ("frag", "frag", c["frag"])):
            (SRC / f"{key}_{program_name}.{stage}").write_text(source)
            out.append(f'    {{ name = "{program_name}", template = "shader_render_operator/{key}_{program_name}.{stage}", stage = "{stage}" }},')
        out += ["]", ""]
        ins = ", ".join(f"OperatorInput {{ kind: '{k}', size: {s}, min: {lo!r}_f32, max: {hi!r}_f32 }}" for k, s, lo, hi in c["inputs"])
        table.append(
            f'    OperatorCaseData {{ group: "{c["group"]}", inner: "{c["inner"]}", name: "{c["name"]}", is_vertex: {str(c["is_vertex"]).lower()}, eval: "{c["eval"]}", inputs: &[{ins}], '
            f"out_kind: '{c['out_kind']}', out_size: {c['out_size']}, ref_scale: {c['ref_scale']!r}_f32, ref_bias: {c['ref_bias']!r}_f32 }},"
        )
    table.append("];")
    MANIFEST.write_text("\n".join(out))
    TABLE.write_text("\n".join(table) + "\n")
    print(len(cases), "cases")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Writes the GLSL of dEQP-VK.glsl.matrix (shaderrender/vktShaderRenderMatrixTests.cpp), its manifest and the case table of the Rust side.

`ShaderMatrixCase::setupShader` and the loops of `ShaderMatrixTests::init` are reproduced here; the constant inputs (`s_constIn*`) are read from the vendored C++ and the inputs
of the constant and uniform cases are written into the table, so the Rust side only needs the matrix arithmetic of the reference.

  * shaders/manifest/shader_render_matrix.toml and shaders/src/shader_render_matrix/,
  * src/vkt/tests/glsl/shader_render_matrix_cases.rs (the case table).

Run from hodow_cts/:  python3 scripts/gen_shader_render_matrix.py   (then `just cts-shaders`)
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CPP = ROOT / "upstream/external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderMatrixTests.cpp"
SRC = ROOT / "shaders" / "src" / "shader_render_matrix"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render_matrix.toml"
TABLE = ROOT / "src" / "vkt" / "tests" / "glsl" / "shader_render_matrix_cases.rs"

OPS = [
    ("add", "OP_ADD", True, True), ("sub", "OP_SUB", True, True), ("mul", "OP_MUL", True, True), ("div", "OP_DIV", True, True),
    ("matrixcompmult", "OP_COMP_MUL", False, True), ("outerproduct", "OP_OUTER_PRODUCT", False, True), ("transpose", "OP_TRANSPOSE", False, True),
    ("determinant", "OP_DETERMINANT", False, True), ("inverse", "OP_INVERSE", False, True), ("unary_addition", "OP_UNARY_PLUS", False, False),
    ("negation", "OP_NEGATION", False, False), ("pre_increment", "OP_PRE_INCREMENT", False, False), ("pre_decrement", "OP_PRE_DECREMENT", False, False),
    ("post_increment", "OP_POST_INCREMENT", False, False), ("post_decrement", "OP_POST_DECREMENT", False, False), ("add_assign", "OP_ADD_INTO", False, False),
    ("sub_assign", "OP_SUBTRACT_FROM", False, False), ("mul_assign", "OP_MULTIPLY_INTO", False, False), ("div_assign", "OP_DIVIDE_INTO", False, False),
]
OP_NAME = {"OP_ADD": "+", "OP_SUB": "-", "OP_MUL": "*", "OP_DIV": "/", "OP_COMP_MUL": "matrixCompMult", "OP_OUTER_PRODUCT": "outerProduct", "OP_TRANSPOSE": "transpose",
           "OP_INVERSE": "inverse", "OP_DETERMINANT": "determinant", "OP_UNARY_PLUS": "+", "OP_NEGATION": "-", "OP_PRE_INCREMENT": "++", "OP_PRE_DECREMENT": "--",
           "OP_POST_INCREMENT": "++", "OP_POST_DECREMENT": "--", "OP_ADD_INTO": "+=", "OP_SUBTRACT_FROM": "-=", "OP_MULTIPLY_INTO": "*=", "OP_DIVIDE_INTO": "/="}
OP_TYPE = {"OP_ADD": "bop", "OP_SUB": "bop", "OP_MUL": "bop", "OP_DIV": "bop", "OP_COMP_MUL": "bfn", "OP_OUTER_PRODUCT": "bfn", "OP_TRANSPOSE": "ufn", "OP_INVERSE": "ufn",
           "OP_DETERMINANT": "ufn", "OP_UNARY_PLUS": "pre", "OP_NEGATION": "pre", "OP_PRE_INCREMENT": "pre", "OP_PRE_DECREMENT": "pre", "OP_POST_INCREMENT": "post",
           "OP_POST_DECREMENT": "post", "OP_ADD_INTO": "assign", "OP_SUBTRACT_FROM": "assign", "OP_MULTIPLY_INTO": "assign", "OP_DIVIDE_INTO": "assign"}
TEST_MATRIX_TYPE = {"OP_UNARY_PLUS": "dec", "OP_NEGATION": "neginc", "OP_PRE_INCREMENT": "neg", "OP_PRE_DECREMENT": "inc", "OP_POST_INCREMENT": "neg", "OP_SUBTRACT_FROM": "incless",
                    "OP_MULTIPLY_INTO": "neg", "OP_DIVIDE_INTO": "dec"}
MATRIX_TYPES = [(2, 2), (2, 3), (2, 4), (3, 2), (3, 3), (3, 4), (4, 2), (4, 3), (4, 4)]
PRECISIONS = ["mediump", "highp"]


def type_name(cols, rows, kind):
    if kind == "s":
        return "float"
    if kind == "v":
        return f"vec{rows}"
    return f"mat{cols}" if cols == rows else f"mat{cols}x{rows}"


def parse_consts():
    text = CPP.read_text()
    consts = {}
    consts["float"] = [float(v) for v in re.search(r"s_constInFloat\[2\]\s*=\s*\{([^}]*)\}", text).group(1).replace("f", "").split(",")]
    for size in (2, 3, 4):
        body = re.search(rf"s_constInVec{size}\[2\]\s*=\s*\{{(.*?)\}};", text, re.S).group(1)
        values = [float(v) for v in re.findall(r"-?\d+\.\d+f?", body.replace("f", ""))]
        consts[f"vec{size}"] = [values[:size], values[size : 2 * size]]
    for cols, rows in MATRIX_TYPES:
        name = f"s_constInMat{cols}x{rows}"
        body = re.search(rf"{name}\[2\]\[\d+\]\s*=\s*\{{(.*?)\n\}};", text, re.S).group(1)
        halves = re.findall(r"\{(.*?)\}", body, re.S)
        mats = []
        for half in halves:
            values = [float(v) for v in re.findall(r"-?\d+\.\d+f?", half.replace("f", ""))]
            assert len(values) == cols * rows, (name, len(values))
            # tcu::Matrix(const T*) reads row-major: m(row, col) = src[row * cols + col]; stored column-major
            mats.append([values[row * cols + col] for col in range(cols) for row in range(rows)])
        consts[type_name(cols, rows, "m")] = mats
    return consts


def float1(x):
    return "%.1f" % x


def const_literal(cols, rows, kind, values):
    if kind == "s":
        return float1(values)
    if kind == "v":
        return f"vec{rows}(" + ", ".join(float1(v) for v in values) + ")"
    return type_name(cols, rows, "m") + "(" + ", ".join(float1(v) for v in values) + ")"


def reduction(cols, rows, kind, var):
    if kind == "s":
        return f"{var}, {var}, {var}"
    if kind == "v":
        return {2: f"{var}.x, {var}.y, {var}.x", 3: var, 4: f"{var}.x, {var}.y, {var}.z+{var}.w"}[rows]
    return {
        (2, 2): f"{var}[0][0], {var}[1][0], {var}[0][1]+{var}[1][1]",
        (2, 3): f"{var}[0] + {var}[1]",
        (2, 4): f"{var}[0].xyz + {var}[1].yzw",
        (3, 2): f"{var}[0][0]+{var}[0][1], {var}[1][0]+{var}[1][1], {var}[2][0]+{var}[2][1]",
        (3, 3): f"{var}[0] + {var}[1] + {var}[2]",
        (3, 4): f"{var}[0].xyz + {var}[1].yzw + {var}[2].zwx",
        (4, 2): f"{var}[0][0]+{var}[0][1]+{var}[3][0], {var}[1][0]+{var}[1][1]+{var}[3][1], {var}[2][0]+{var}[2][1]",
        (4, 3): f"{var}[0] + {var}[1] + {var}[2] + {var}[3]",
        (4, 4): f"{var}[0].xyz+{var}[1].yzw+{var}[2].zwx+{var}[3].wxy",
    }[(cols, rows)]


def result_shape(op, in0, in1):
    c0, r0, k0 = in0
    if in1 is not None:
        c1, r1, k1 = in1
    if op == "OP_MUL" and k0 == "m" and k1 == "m":
        return (c1, r0, "m")
    if op == "OP_OUTER_PRODUCT":
        return (r1, r0, "m")
    if op == "OP_TRANSPOSE":
        return (r0, c0, "m")
    if op == "OP_INVERSE":
        return in0
    if op == "OP_DETERMINANT":
        return (1, 1, "s")
    if OP_TYPE[op] in ("pre", "post"):
        return in0
    if k0 == "m" and k1 == "m":
        return in0
    mat, other, mat_ndx = (in0, in1, 0) if k0 == "m" else (in1, in0, 1)
    if other[2] == "s":
        return mat
    size = mat[1] if mat_ndx == 0 else mat[0]
    return (1, size, "v")


def setup_shader(is_vertex, op, in0, in1, consts):
    """in0/in1: (input type, cols, rows, kind, precision) or None. Returns the sources and the uniforms."""
    vtx = "#version 310 es\n"
    frag = "#version 310 es\n"
    vtx += "layout(location = 0) in highp vec4 a_position;\n"
    frag += "layout(location = 0) out mediump vec4 dEQP_FragColor;\n"
    if is_vertex:
        vtx += "layout(location = 0) out mediump vec4 v_color;\n"
        frag += "layout(location = 0) in mediump vec4 v_color;\n"
    binary = in1 is not None
    inputs = [in0] + ([in1] if binary else [])
    res_prec = in0[4]
    res_cols, res_rows, res_kind = result_shape(op, in0[1:4], in1[1:4] if binary else None)
    res_type = type_name(res_cols, res_rows, res_kind)
    op_text = ""
    pass_vars = []
    values = []
    uniforms = []
    uniform_binding = 0
    padding = 0
    for ndx, (input_type, cols, rows, kind, prec) in enumerate(inputs):
        tname = type_name(cols, rows, kind)
        if input_type == "dynamic":
            if kind == "m":
                vtx += f"layout(location = {4 + ndx + padding}) in {prec} {tname} a_{tname};\n"
                if not is_vertex:
                    vtx += f"layout(location = {1 + ndx + padding}) out {prec} {tname} v_{tname};\n"
                    frag += f"layout(location = {1 + ndx + padding}) in {prec} {tname} v_{tname};\n"
                    pass_vars.append(tname)
                values.append(("a_" if is_vertex else "v_") + tname)
                padding += cols
            else:
                vtx += f"layout(location = 1) in {prec} {tname} a_coords;\n"
                if not is_vertex:
                    vtx += f"layout(location = {1 + padding}) out {prec} {tname} v_coords;\n"
                    frag += f"layout(location = {1 + padding}) in {prec} {tname} v_coords;\n"
                    pass_vars.append("coords")
                values.append("a_coords" if is_vertex else "v_coords")
        elif input_type == "uniform":
            op_text += f"layout(std140, set = 0, binding = {uniform_binding}) uniform buffer{ndx} {{ {prec} {tname} u_in{ndx}; }};\n"
            values.append(f"u_in{ndx}")
            data = consts[tname if kind != "s" else "float"]
            if kind == "s":
                uniforms.append((uniform_binding, "Float", data[ndx]))
            else:
                flat = data[ndx] if kind == "m" else None
                columns = [[0.0] * 4 for _ in range(4)]
                if kind == "v":
                    columns[0][: rows] = data[ndx]
                else:
                    for col in range(cols):
                        columns[col][:rows] = flat[col * rows : (col + 1) * rows]
                uniforms.append((uniform_binding, "Vec4s", columns))
            uniform_binding += 1
        else:
            data = consts[tname if kind != "s" else "float"][ndx]
            op_text += f"const {prec} {tname} in{ndx} = {const_literal(cols, rows, kind, data if kind != 'm' else [data[i] for i in range(cols * rows)])};\n"
            values.append(f"in{ndx}")
    vtx += "\nvoid main (void)\n{\n    gl_Position = a_position;\n"
    frag += "\nvoid main (void)\n{\n"
    if is_vertex:
        frag += "    dEQP_FragColor = v_color;\n"
    else:
        vtx += "".join(f"    v_{v} = a_{v};\n" for v in pass_vars)
    typ = OP_TYPE[op]
    mutating = op in ("OP_PRE_INCREMENT", "OP_PRE_DECREMENT", "OP_POST_INCREMENT", "OP_POST_DECREMENT")
    value0, value1 = values[0], values[1] if binary else ""
    rtype = f"{res_prec} {res_type}"
    if mutating:
        op_text += f"    {rtype} tmpValue = {values[0]};\n"
        value0 = "tmpValue"
    name = OP_NAME[op]
    if typ == "bop":
        op_text += f"    {rtype} res = {value0} {name} {value1};\n"
    elif typ == "pre":
        op_text += f"    {rtype} res = {name}{value0};\n"
    elif typ == "post":
        op_text += f"    {rtype} res = {value0}{name};\n"
    elif typ == "bfn":
        op_text += f"    {rtype} res = {name}({value0}, {value1});\n"
    elif typ == "ufn":
        op_text += f"    {rtype} res = {name}({value0});\n"
    else:
        op_text += f"    {rtype} res = {value0};\n    res {name} {value1};\n"
    op_text += "    " + ("v_color" if is_vertex else "dEQP_FragColor") + " = "
    if mutating:
        op_text += f"vec4({reduction(res_cols, res_rows, res_kind, 'res')}, 1.0) + vec4({reduction(res_cols, res_rows, res_kind, 'tmpValue')}, 0.0);\n"
    else:
        op_text += f"vec4({reduction(res_cols, res_rows, res_kind, 'res')}, 1.0);\n"
    if is_vertex:
        vtx += op_text + "}\n"
        frag += "}\n"
    else:
        # the declarations of the uniforms and constants go before main in the stage that runs the operation
        decl, body = split_declarations(op_text)
        vtx += "}\n"
        frag = frag.replace("\nvoid main (void)\n{\n", decl + "\nvoid main (void)\n{\n", 1) + body + "}\n"
    if is_vertex:
        decl, body = split_declarations(op_text)
        vtx = vtx.replace(op_text, body)
        vtx = vtx.replace("\nvoid main (void)\n{\n", decl + "\nvoid main (void)\n{\n", 1)
    return vtx, frag, uniforms


def split_declarations(text):
    decl, body = "", ""
    for line in text.splitlines(keepends=True):
        (decl if line.startswith(("layout(std140", "const ")) else body).__class__
        if line.startswith(("layout(std140", "const ")):
            decl += line
        else:
            body += line
    return decl, body


def attrib_transforms(op, count=4):
    transforms = []
    inverse = op == "OP_INVERSE"
    for a in range(count):
        t = [[0.0] * 4 for _ in range(4)]
        t[0][3] = -0.5 if inverse else 0.2
        t[1][3] = -1.3 if inverse else 0.1
        t[2][3] = 0.4 + 0.15 * a
        t[3][3] = -3.0 if inverse else 0.7
        t[(0 + a) % 4][0] = 1.0
        t[(1 + a) % 4][1] = 1.0
        t[(2 + a) % 4][2] = 1.0
        t[(3 + a) % 4][3] = 1.0
        transforms.append(t)
    return transforms


def build_cases(consts):
    cases = []
    for group, op, extended, input_group in OPS:
        in_types = ["const", "uniform", "dynamic"] if extended else ["dynamic"]
        for in_type in in_types:
            for cols, rows in MATRIX_TYPES:
                mat_name = type_name(cols, rows, "m")
                for prec in PRECISIONS:
                    base = f"{prec}_{mat_name}_"
                    path = [group, in_type] if input_group else [group]
                    mat_in = (in_type, cols, rows, "m", prec)

                    def add(name, in0, in1):
                        for shader, is_vertex in (("vertex", True), ("fragment", False)):
                            vtx, frag, uniforms = setup_shader(is_vertex, op, in0, in1, consts)
                            cases.append(dict(path=path, name=f"{name}_{shader}", is_vertex=is_vertex, op=op, in0=in0, in1=in1, uniforms=uniforms, vtx=vtx, frag=frag))

                    if op in ("OP_ADD", "OP_SUB", "OP_MUL", "OP_DIV"):
                        add(base + "float", mat_in, ("uniform" if op == "OP_DIV" else "dynamic", 1, 1, "s", prec))
                    if op == "OP_MUL":
                        other = "uniform" if op == "OP_DIV" else "dynamic"
                        add(base + f"vec{cols}", mat_in, (other, 1, cols, "v", prec))
                        add(f"{prec}_vec{rows}_{mat_name}", (other, 1, rows, "v", prec), mat_in)
                        for other_cols in (2, 3, 4):
                            other_in = ("uniform" if in_type == "dynamic" else in_type, other_cols, cols, "m", prec)
                            add(base + type_name(other_cols, cols, "m"), mat_in, other_in)
                    elif op in ("OP_ADD", "OP_SUB", "OP_DIV", "OP_COMP_MUL"):
                        add(base + mat_name, mat_in, ("uniform" if in_type == "dynamic" else in_type, cols, rows, "m", prec))
                    if op == "OP_OUTER_PRODUCT":
                        add(base + "float", (in_type, 1, rows, "v", prec), ("uniform" if in_type == "dynamic" else in_type, 1, cols, "v", prec))
                    if op in ("OP_TRANSPOSE", "OP_UNARY_PLUS", "OP_NEGATION", "OP_PRE_INCREMENT", "OP_PRE_DECREMENT", "OP_POST_INCREMENT", "OP_POST_DECREMENT") or (
                        op in ("OP_INVERSE", "OP_DETERMINANT") and cols == rows
                    ):
                        add(base + "float", mat_in, None)
                    if op in ("OP_ADD_INTO", "OP_SUBTRACT_FROM", "OP_DIVIDE_INTO") or (op == "OP_MULTIPLY_INTO" and cols == rows):
                        add(base + "float", mat_in, ("uniform" if in_type == "dynamic" else in_type, cols, rows, "m", prec))
    return cases


def rust_input(inp, consts, ndx):
    if inp is None:
        return "None"
    input_type, cols, rows, kind, prec = inp
    values = []
    if input_type != "dynamic":
        data = consts[type_name(cols, rows, kind) if kind != "s" else "float"][ndx]
        values = [data] if kind == "s" else data
    first = ""
    return f"Some(MatrixInput {{ dynamic: {str(input_type == 'dynamic').lower()}, cols: {cols}, rows: {rows}, kind: '{kind}', values: &[{', '.join(repr(v) + '_f32' for v in values)}] }})"


def main():
    consts = parse_consts()
    cases = build_cases(consts)
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for dEQP-VK.glsl.matrix.",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_matrix.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderMatrixTests.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    table = [
        "// @generated by hodow_cts/scripts/gen_shader_render_matrix.py - do not hand-edit.",
        "",
        "use super::shader_render::UniformValue;",
        "use super::shader_render_matrix_tests::{MatrixCaseData, MatrixInput};",
        "",
        f"pub static MATRIX_CASES: [MatrixCaseData; {len(cases)}] = [",
    ]
    seen = set()
    for c in cases:
        key = "sr_matrix_" + "_".join(c["path"]) + "_" + c["name"]
        if key in seen:
            raise SystemExit("duplicate " + key)
        seen.add(key)
        out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
        for program_name, stage, source in (("vert", "vert", c["vtx"]), ("frag", "frag", c["frag"])):
            (SRC / f"{key}_{program_name}.{stage}").write_text(source)
            out.append(f'    {{ name = "{program_name}", template = "shader_render_matrix/{key}_{program_name}.{stage}", stage = "{stage}" }},')
        out += ["]", ""]
        uniforms = []
        for binding, kind, value in c["uniforms"]:
            if kind == "Float":
                uniforms.append(f"({binding}, UniformValue::Float({value!r}_f32))")
            else:
                uniforms.append(f"({binding}, UniformValue::Vec4s([" + ", ".join("[" + ", ".join(repr(v) + "_f32" for v in col) + "]" for col in value) + "]))")
        path = ", ".join(f'"{p}"' for p in c["path"])
        table.append(
            f'    MatrixCaseData {{ path: &[{path}], name: "{c["name"]}", is_vertex: {str(c["is_vertex"]).lower()}, op: "{c["op"]}", in0: {rust_input(c["in0"], consts, 0)}, '
            f'in1: {rust_input(c["in1"], consts, 1)}, uniforms: &[{", ".join(uniforms)}] }},'
        )
    table.append("];")
    MANIFEST.write_text("\n".join(out))
    TABLE.write_text("\n".join(table) + "\n")
    print(len(cases), "cases")


if __name__ == "__main__":
    main()

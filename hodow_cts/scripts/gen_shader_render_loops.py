#!/usr/bin/env python3
"""Writes the GLSL of dEQP-VK.glsl.loops (shaderrender/vktShaderRenderLoopTests.cpp), their manifest and the case table of the Rust side.

`createGenericLoopCase` is reproduced here; `createSpecialLoopCase` is not retyped: its per-(loop type, loop case) `switch` blocks are read from the vendored
C++ (the `numIters`/`iterCount` assignments and the `op << "..."` strings), so the shaders are the upstream strings. Written:

  * shaders/manifest/shader_render_loops.toml and shaders/src/shader_render_loops/ (one `sr_loops_<group>_<case>` per case with `vert` and `frag`),
  * src/vkt/tests/glsl/shader_render_loop_cases.rs (the case table: tree path, name, vertex or fragment case, evaluation function and uniforms).

Run from hodow_cts/:  python3 scripts/gen_shader_render_loops.py   (then `just cts-shaders`)
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CPP = ROOT / "upstream/external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderLoopTests.cpp"
SRC = ROOT / "shaders" / "src" / "shader_render_loops"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render_loops.toml"
TABLE = ROOT / "src" / "vkt" / "tests" / "glsl" / "shader_render_loop_cases.rs"

LOOP_TYPES = ["for", "while", "do_while"]
COUNT_TYPES = ["constant", "uniform", "dynamic"]
LOOP_CASES = [
    "empty_body", "infinite_with_unconditional_break_first", "infinite_with_unconditional_break_last", "infinite_with_conditional_break", "single_statement",
    "compound_statement", "sequence_statement", "no_iterations", "single_iteration", "select_iteration_count", "conditional_continue", "unconditional_continue",
    "only_continue", "double_continue", "conditional_break", "unconditional_break", "pre_increment", "post_increment", "mixed_break_continue", "vector_counter",
    "101_iterations", "sequence", "nested", "nested_sequence", "nested_tricky_dataflow_1", "nested_tricky_dataflow_2", "pre_fallthrough", "post_fallthrough",
    "dowhile_trap", "ifblock", "elseblock",
]
INT_UNIFORM_NAMES = {0: "ui_zero", 1: "ui_one", 2: "ui_two", 3: "ui_three", 4: "ui_four", 5: "ui_five", 6: "ui_six", 7: "ui_seven", 8: "ui_eight", 101: "ui_oneHundredOne"}
FLOAT_FRACTION_NAMES = {1: "uf_one", 2: "uf_half", 3: "uf_third", 4: "uf_fourth", 5: "uf_fifth", 6: "uf_sixth", 7: "uf_seventh", 8: "uf_eight"}


def int_uniform(number):
    return ("Int", number)


def float_fraction_uniform(number):
    return ("Float", 1.0 / number)


def specialize(template, params):
    for key, value in params.items():
        template = template.replace("${" + key + "}", value)
    return template


def decode_cpp_string(literal):
    return literal.replace("\\n", "\n").replace("\\t", "\t").replace('\\"', '"').replace("\\\\", "\\")


def parse_special_blocks():
    """{loop type: {case name: (ops, numIters assignments as code lines)}} from the C++ switch blocks."""
    text = CPP.read_text()
    start = text.index("createSpecialLoopCase(tcu::TestContext")
    body = text[start:]
    sections = {}
    for loop_type, marker in (("for", "if (loopType == LOOPTYPE_FOR)"), ("while", "else if (loopType == LOOPTYPE_WHILE)"), ("do_while", "DE_ASSERT(loopType == LOOPTYPE_DO_WHILE);")):
        sections[loop_type] = body.index(marker)
    order = sorted(sections.items(), key=lambda item: item[1])
    ends = {}
    for ndx, (loop_type, begin) in enumerate(order):
        ends[loop_type] = order[ndx + 1][1] if ndx + 1 < len(order) else body.index("// Shader footers.")
    result = {}
    for loop_type, begin in sections.items():
        chunk = body[begin : ends[loop_type]]
        cases = {}
        for match in re.finditer(r"case LOOPCASE_([A-Z0-9_]+):\n(.*?)\n\s*break;\n", chunk, re.S):
            name = match.group(1).lower()
            block = match.group(2)
            statements = [s for s in re.split(r";\s*\n", block + ";\n") if s.strip()]
            cases[name] = statements
        result[loop_type] = cases
    return result


def run_special_block(statements):
    state = {"numIters": 3, "iterCount": 3}
    ops = []
    for statement in statements:
        statement = statement.strip()
        if statement.startswith("op <<"):
            literals = re.findall(r'"((?:[^"\\]|\\.)*)"', statement)
            ops.append("".join(decode_cpp_string(lit) for lit in literals))
        elif statement.startswith(("numIters", "iterCount")):
            parts = [p.strip() for p in statement.split("=")]
            value = eval(parts[-1], {}, dict(state))
            for target in parts[:-1]:
                state[target] = value
        elif statement.startswith("DE_ASSERT"):
            pass
        else:
            raise RuntimeError("unhandled statement: " + statement)
    return "".join(ops), state["numIters"], state["iterCount"]


def shader_headers(is_vertex, count_type):
    vtx = "#version 310 es\n"
    frag = "#version 310 es\n"
    vtx += "layout(location=0) in highp vec4 a_position;\nlayout(location=1) in highp vec4 a_coords;\n"
    frag += "layout(location=0) out mediump vec4 o_color;\n"
    if count_type == "dynamic":
        vtx += "layout(location=3) in mediump float a_one;\n"
    if is_vertex:
        vtx += "layout(location=0) out mediump vec3 v_color;\n"
        frag += "layout(location=0) in mediump vec3 v_color;\n"
    else:
        vtx += "layout(location=0) out mediump vec4 v_coords;\n"
        frag += "layout(location=0) in mediump vec4 v_coords;\n"
        if count_type == "dynamic":
            vtx += "layout(location=1) out mediump float v_one;\n"
            frag += "layout(location=1) in mediump float v_one;\n"
    return vtx, frag


def uniform_block(counter, declaration):
    return f"layout(std140, set=0, binding={counter}) uniform buff{counter} {{\n{declaration}}};\n"


def generic_case(is_vertex, loop_type, count_type, precision, data_type):
    vtx, frag = shader_headers(is_vertex, count_type)
    uniforms = []
    num_loop_iters = 3
    is_int = data_type == "int"
    counter = 0
    op = ""
    if is_int:
        if count_type in ("uniform", "dynamic"):
            op += uniform_block(counter, f" ${{COUNTER_PRECISION}} int {INT_UNIFORM_NAMES[num_loop_iters]};\n")
            uniforms.append(int_uniform(num_loop_iters))
            counter += 1
    else:
        if count_type in ("uniform", "dynamic"):
            op += uniform_block(counter, f"    ${{COUNTER_PRECISION}} float {FLOAT_FRACTION_NAMES[num_loop_iters]};\n")
            uniforms.append(float_fraction_uniform(num_loop_iters))
            counter += 1
        if num_loop_iters != 1:
            op += uniform_block(counter, "    ${COUNTER_PRECISION} float uf_one;\n")
            uniforms.append(float_fraction_uniform(1))
            counter += 1

    vtx_main = "\nvoid main()\n{\n    gl_Position = a_position;\n"
    frag_main = "\nvoid main()\n{\n"
    body = ""
    body += "    ${PRECISION} vec4 coords = " + ("a_coords" if is_vertex else "v_coords") + ";\n"
    if count_type == "dynamic":
        if is_int:
            body += "    ${COUNTER_PRECISION} int one = int(" + ("a_one" if is_vertex else "v_one") + " + 0.5);\n"
        else:
            body += "    ${COUNTER_PRECISION} float one = " + ("a_one" if is_vertex else "v_one") + ";\n"
    body += "    ${PRECISION} vec4 res = coords;\n"

    if is_int:
        iter_max = {"constant": str(num_loop_iters), "uniform": INT_UNIFORM_NAMES[num_loop_iters], "dynamic": INT_UNIFORM_NAMES[num_loop_iters] + "*one"}[count_type]
    else:
        iter_max = {"constant": "1.0", "uniform": "uf_one", "dynamic": "uf_one*one"}[count_type]
    init_value = "0" if is_int else "0.05"
    decl = "${COUNTER_PRECISION} ${LOOP_VAR_TYPE} ndx = " + init_value
    cmp_str = "ndx < " + iter_max
    if is_int:
        increment = "ndx++"
    else:
        increment = {
            "constant": "ndx += " + ("%g" % (1.0 / num_loop_iters)),
            "uniform": "ndx += " + FLOAT_FRACTION_NAMES[num_loop_iters],
            "dynamic": "ndx += " + FLOAT_FRACTION_NAMES[num_loop_iters] + "*one",
        }[count_type]
    loop_body = "        res = res.yzwx + vec4(1.0);\n"
    if loop_type == "for":
        body += f"    for ({decl}; {cmp_str}; {increment})\n    {{\n{loop_body}    }}\n"
    elif loop_type == "while":
        body += f"\t{decl};\n    while ({cmp_str})\n    {{\n{loop_body}\t\t{increment};\n    }}\n"
    else:
        body += f"\t{decl};\n    do\n    {{\n{loop_body}\t\t{increment};\n    }} while ({cmp_str});\n"
    body += f"    res -= vec4({num_loop_iters});\n"

    if is_vertex:
        vtx += op + vtx_main + body + "    v_color = res.rgb;\n"
        frag += frag_main + "    o_color = vec4(v_color.rgb, 1.0);\n"
    else:
        vtx += vtx_main + "    v_coords = a_coords;\n" + ("    v_one = a_one;\n" if count_type == "dynamic" else "")
        frag += op + frag_main + body + "    o_color = vec4(res.rgb, 1.0);\n"
    params = {"LOOP_VAR_TYPE": data_type, "PRECISION": "mediump", "COUNTER_PRECISION": precision}
    return specialize(vtx + "}\n", params), specialize(frag + "}\n", params), num_loop_iters, uniforms


def special_case(is_vertex, loop_case, loop_type, count_type, blocks):
    vtx, frag = shader_headers(is_vertex, count_type)
    uniforms = []
    counter = 0
    op = ""
    if loop_case == "select_iteration_count":
        op += uniform_block(counter, "  bool ub_true;\n")
        uniforms.append(("Int", 1))
        counter += 1
    for ndx, name in enumerate(["ui_zero", "ui_one", "ui_two", "ui_three", "ui_four", "ui_five", "ui_six"]):
        op += uniform_block(counter, f"  ${{COUNTER_PRECISION}} int {name};\n")
        uniforms.append(int_uniform(ndx))
        counter += 1
    if loop_case == "101_iterations":
        op += uniform_block(counter, "  ${COUNTER_PRECISION} int ui_oneHundredOne;\n")
        uniforms.append(int_uniform(101))
        counter += 1

    body_ops, num_iters, iter_count = run_special_block(blocks[loop_type][loop_case])
    vtx_main = "\nvoid main()\n{\n    gl_Position = a_position;\n"
    frag_main = "\nvoid main()\n{\n"
    body = ""
    if count_type == "dynamic":
        body += "    ${COUNTER_PRECISION} int one = int(" + ("a_one" if is_vertex else "v_one") + " + 0.5);\n"
    body += "    ${PRECISION} vec4 coords = " + ("a_coords" if is_vertex else "v_coords") + ";\n"
    body += "    ${PRECISION} vec4 res = coords;\n"
    body += body_ops
    body += "    res -= vec4(${NUM_ITERS});\n"

    counter_precision = "mediump"
    count_expr = {"constant": str(iter_count), "uniform": INT_UNIFORM_NAMES[iter_count] if iter_count in INT_UNIFORM_NAMES else "???", "dynamic": "one*" + INT_UNIFORM_NAMES.get(iter_count, "???")}[count_type]
    for_loop = f"for ({counter_precision} int i = 0; i < {count_expr}; i++)"
    while_loop = f"\t{counter_precision} int i = 0;\n    while(i++ < {count_expr})"
    post_count = {"constant": str(iter_count), "uniform": INT_UNIFORM_NAMES.get(iter_count, "???"), "dynamic": "one*" + INT_UNIFORM_NAMES.get(iter_count, "???")}[count_type]
    do_while_pre = f"\t{counter_precision} int i = 0;\n\tdo "
    do_while_post = f" while (++i < {post_count});\n"
    if count_type == "constant":
        one, two, three, iter_str = "1", "2", "3", str(iter_count)
    elif count_type == "uniform":
        one, two, three, iter_str = "ui_one", "ui_two", "ui_three", INT_UNIFORM_NAMES.get(iter_count, "???")
    else:
        one, two, three, iter_str = "one*ui_one", "one*ui_two", "one*ui_three", "one*" + INT_UNIFORM_NAMES.get(iter_count, "???")

    if is_vertex:
        vtx += op + vtx_main + body + "    v_color = res.rgb;\n"
        frag += frag_main + "    o_color = vec4(v_color.rgb, 1.0);\n"
    else:
        vtx += vtx_main + "    v_coords = a_coords;\n" + ("    v_one = a_one;\n" if count_type == "dynamic" else "")
        frag += op + frag_main + body + "    o_color = vec4(res.rgb, 1.0);\n"

    params = {
        "PRECISION": "mediump", "ITER_COUNT": iter_str, "NUM_ITERS": str(num_iters), "COUNTER_PRECISION": counter_precision, "FOR_LOOP": for_loop,
        "WHILE_LOOP": while_loop, "DO_WHILE_PRE": do_while_pre, "DO_WHILE_POST": do_while_post, "ONE": one, "TWO": two, "THREE": three,
    }
    return specialize(vtx + "}\n", params), specialize(frag + "}\n", params), num_iters, uniforms


def uniform_literal(uniforms):
    items = []
    for binding, (kind, value) in enumerate(uniforms):
        items.append(f"(%d, UniformValue::Int(%d))" % (binding, value) if kind == "Int" else f"({binding}, UniformValue::Float({value!r}_f32))")
    return "&[" + ", ".join(items) + "]"


def main():
    blocks = parse_special_blocks()
    SRC.mkdir(parents=True, exist_ok=True)
    cases = []
    for loop_type in LOOP_TYPES:
        for count_type in COUNT_TYPES:
            group_name = f"{loop_type}_{count_type}_iterations"
            for precision in ("mediump", "highp"):
                for data_type in ("int", "float"):
                    for shader in ("vertex", "fragment"):
                        vtx, frag, iters, uniforms = generic_case(shader == "vertex", loop_type, count_type, precision, data_type)
                        cases.append(("generic", group_name, f"basic_{precision}_{data_type}_{shader}", shader == "vertex", vtx, frag, iters, uniforms))
            for loop_case in LOOP_CASES:
                if loop_case == "no_iterations" and loop_type == "do_while":
                    continue
                for shader in ("vertex", "fragment"):
                    vtx, frag, iters, uniforms = special_case(shader == "vertex", loop_case, loop_type, count_type, blocks)
                    cases.append(("special", group_name, f"{loop_case}_{shader}", shader == "vertex", vtx, frag, iters, uniforms))

    out = [
        "# Shader manifest for dEQP-VK.glsl.loops.",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_loops.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderLoopTests.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    table = [
        "// @generated by hodow_cts/scripts/gen_shader_render_loops.py - do not hand-edit.",
        "//",
        "// The cases of dEQP-VK.glsl.loops: tree path, name, vertex case or fragment case, the number of iterations the evaluation function is chosen by and the uniforms.",
        "",
        "use super::shader_render::UniformValue;",
        "use super::shader_render_loop_tests::LoopCaseData;",
        "",
        f"pub static LOOP_CASES: [LoopCaseData; {len(cases)}] = [",
    ]
    for kind, group_name, name, is_vertex, vtx, frag, iters, uniforms in cases:
        key = f"sr_loops_{kind}_{group_name}_{name}"
        out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
        for program_name, stage, source in (("vert", "vert", vtx), ("frag", "frag", frag)):
            (SRC / f"{key}_{program_name}.{stage}").write_text(source)
            out.append(f'    {{ name = "{program_name}", template = "shader_render_loops/{key}_{program_name}.{stage}", stage = "{stage}" }},')
        out += ["]", ""]
        table.append(f'    LoopCaseData {{ path: ["{kind}", "{group_name}"], name: "{name}", is_vertex: {str(is_vertex).lower()}, iterations: {iters}, uniforms: {uniform_literal(uniforms)} }},')
    table.append("];")
    MANIFEST.write_text("\n".join(out))
    TABLE.write_text("\n".join(table) + "\n")
    print(len(cases), "cases")


if __name__ == "__main__":
    main()

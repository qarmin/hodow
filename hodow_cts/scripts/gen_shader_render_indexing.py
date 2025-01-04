#!/usr/bin/env python3
"""Writes the GLSL of dEQP-VK.glsl.indexing (shaderrender/vktShaderRenderIndexingTests.cpp), their manifest and the case table of the Rust side.

The create*Case functions of upstream are reproduced statement by statement (`vtx << ...` is `vtx += ...`). Written:

  * shaders/manifest/shader_render_indexing.toml and shaders/src/shader_render_indexing/ (one `sr_indexing_<group>_<case>` per case with `vert` and `frag`),
  * src/vkt/tests/glsl/shader_render_indexing_cases.rs (the case table: group, name, vertex case or fragment case, evaluation function and the uniform array).

Run from hodow_cts/:  python3 scripts/gen_shader_render_indexing.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "shader_render_indexing"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render_indexing.toml"
TABLE = ROOT / "src" / "vkt" / "tests" / "glsl" / "shader_render_indexing_cases.rs"

STATIC, DYNAMIC, STATIC_LOOP, DYNAMIC_LOOP, CONST = range(5)
INDEX_ACCESS_NAMES = ["static", "dynamic", "static_loop", "dynamic_loop", "const"]
DIRECT, COMPONENT, SUBSCRIPT_STATIC, SUBSCRIPT_DYNAMIC, SUBSCRIPT_STATIC_LOOP, SUBSCRIPT_DYNAMIC_LOOP = range(6)
VECTOR_ACCESS_NAMES = ["direct", "component", "static_subscript", "dynamic_subscript", "static_loop_subscript", "dynamic_loop_subscript"]
INT_UNIFORM_NAMES = {0: "ui_zero", 1: "ui_one", 2: "ui_two", 3: "ui_three", 4: "ui_four"}
FLOAT_VEC = {1: "float", 2: "vec2", 3: "vec3", 4: "vec4"}
CONST_COORDS = [0.125, 0.25, 0.5, 1.0]


def specialize(template, params):
    for key, value in params.items():
        template = template.replace("${" + key + "}", value)
    return template


def padding_for(var_type):
    return {"float": ", 0.0, 0.0, 1.0", "vec2": ", 0.0, 1.0", "vec3": ", 1.0"}.get(var_type, "")


def dynamic_uniforms(use_dynamic, use_loop, loop_decl, count=4):
    s = ""
    if use_dynamic:
        for ndx, name in enumerate(["ui_zero", "ui_one", "ui_two", "ui_three"][:count]):
            s += f"layout(std140, binding = {ndx}) uniform something{ndx} {{ mediump int {name}; }};\n"
    if use_loop:
        s += loop_decl
    return s


def read_loop(array, acc, indent="    "):
    if acc == STATIC:
        return "".join(f"    res += {array}[{i}];\n" for i in range(4))
    if acc == DYNAMIC:
        return "".join(f"    res += {array}[{n}];\n" for n in ["ui_zero", "ui_one", "ui_two", "ui_three"])
    if acc == STATIC_LOOP:
        return f"    for (int i = 0; i < 4; i++)\n        res += {array}[i];\n"
    return f"    for (int i = 0; i < ui_four; i++)\n        res += {array}[i];\n"


def varying_array_case(var_type, vert_access, frag_access):
    vtx = "#version 310 es\nlayout(location = 0) in highp vec4 a_position;\nlayout(location = 1) in highp vec4 a_coords;\n"
    if vert_access == DYNAMIC:
        vtx += dynamic_uniforms(True, False, "")
    elif vert_access == DYNAMIC_LOOP:
        vtx += "layout(std140, binding = 4) uniform something { mediump int ui_four; };\n"
    vtx += "layout(location = 0) out ${PRECISION} ${VAR_TYPE} var[${ARRAY_LEN}];\n\nvoid main()\n{\n    gl_Position = a_position;\n"
    if vert_access == STATIC:
        vtx += "    var[0] = ${VAR_TYPE}(a_coords);\n    var[1] = ${VAR_TYPE}(a_coords) * 0.5;\n    var[2] = ${VAR_TYPE}(a_coords) * 0.25;\n    var[3] = ${VAR_TYPE}(a_coords) * 0.125;\n"
    elif vert_access == DYNAMIC:
        vtx += (
            "    var[ui_zero]  = ${VAR_TYPE}(a_coords);\n    var[ui_one]   = ${VAR_TYPE}(a_coords) * 0.5;\n"
            "    var[ui_two]   = ${VAR_TYPE}(a_coords) * 0.25;\n    var[ui_three] = ${VAR_TYPE}(a_coords) * 0.125;\n"
        )
    elif vert_access == STATIC_LOOP:
        vtx += "    ${PRECISION} ${VAR_TYPE} coords = ${VAR_TYPE}(a_coords);\n    for (int i = 0; i < 4; i++)\n    {\n        var[i] = ${VAR_TYPE}(coords);\n        coords = coords * 0.5;\n    }\n"
    else:
        vtx += "    ${PRECISION} ${VAR_TYPE} coords = ${VAR_TYPE}(a_coords);\n    for (int i = 0; i < ui_four; i++)\n    {\n        var[i] = ${VAR_TYPE}(coords);\n        coords = coords * 0.5;\n    }\n"
    vtx += "}\n"

    frag = "#version 310 es\nprecision mediump int;\nlayout(location = 0) out mediump vec4 o_color;\n"
    if frag_access == DYNAMIC:
        frag += dynamic_uniforms(True, False, "")
    elif frag_access == DYNAMIC_LOOP:
        frag += "layout(std140, binding = 4) uniform something4 { mediump int ui_four; };\n"
    frag += "layout(location = 0) in ${PRECISION} ${VAR_TYPE} var[${ARRAY_LEN}];\n\nvoid main()\n{\n    ${PRECISION} ${VAR_TYPE} res = ${VAR_TYPE}(0.0);\n"
    frag += read_loop("var", frag_access)
    frag += "    o_color = vec4(res${PADDING});\n}\n"
    params = {"VAR_TYPE": var_type, "ARRAY_LEN": "4", "PRECISION": "mediump", "PADDING": padding_for(var_type)}
    return specialize(vtx, params), specialize(frag, params)


def stage_headers(is_vertex, color_type="vec4"):
    vtx = "#version 310 es\nlayout(location = 0) in highp vec4 a_position;\nlayout(location = 1) in highp vec4 a_coords;\n"
    frag = "#version 310 es\nlayout(location = 0) out mediump vec4 o_color;\n"
    if is_vertex:
        vtx += f"layout(location = 0) out mediump {color_type} v_color;\n"
        frag += f"layout(location = 0) in mediump {color_type} v_color;\n"
    else:
        vtx += "layout(location = 0) out mediump vec4 v_coords;\n"
        frag += "layout(location = 0) in mediump vec4 v_coords;\n"
    return vtx, frag


def finish(is_vertex, vtx_head, frag_head, uniform_decls, vtx_main, frag_main, body, vtx_tail_vertex, frag_tail_vertex, vtx_tail_frag, frag_tail_frag):
    """vtx/frag text: header, the uniform declarations into the stage that runs the body, main, the body and the tails."""
    if is_vertex:
        vtx = vtx_head + uniform_decls + vtx_main + body + vtx_tail_vertex + "}\n"
        frag = frag_head + frag_main + frag_tail_vertex + "}\n"
    else:
        vtx = vtx_head + vtx_main + vtx_tail_frag + "}\n"
        frag = frag_head + uniform_decls + frag_main + body + frag_tail_frag + "}\n"
    return vtx, frag


VTX_MAIN = "\nvoid main()\n{\n    gl_Position = a_position;\n"
FRAG_MAIN = "\nvoid main()\n{\n"


def uniform_array_case(is_vertex, var_type, read_access):
    vtx, frag = stage_headers(is_vertex)
    decls = dynamic_uniforms(read_access == DYNAMIC, read_access == DYNAMIC_LOOP, "layout(std140, binding = 4) uniform something4 { mediump int ui_four; };\n")
    decls += "layout(std140, binding = 5) uniform something5 { ${PRECISION} ${VAR_TYPE} u_arr[${ARRAY_LEN}]; };\n"
    body = "    ${PRECISION} ${VAR_TYPE} res = ${VAR_TYPE}(0.0);\n" + read_loop("u_arr", read_access)
    vtx, frag = finish(
        is_vertex, vtx, frag, decls, VTX_MAIN, FRAG_MAIN, body,
        "    v_color = vec4(res${PADDING});\n", "    o_color = v_color;\n", "    v_coords = a_coords;\n", "    o_color = vec4(res${PADDING});\n",
    )
    params = {"VAR_TYPE": var_type, "ARRAY_LEN": "4", "PRECISION": "mediump", "PADDING": padding_for(var_type)}
    return specialize(vtx, params), specialize(frag, params)


def tmp_array_case(is_vertex, var_type, write_access, read_access):
    vtx, frag = stage_headers(is_vertex)
    decls = ""
    if write_access == DYNAMIC or read_access == DYNAMIC:
        decls += dynamic_uniforms(True, False, "")
    if write_access == DYNAMIC_LOOP or read_access == DYNAMIC_LOOP:
        decls += "layout(std140, binding = 4) uniform something4 { mediump int ui_four; };\n"
    body = ""
    if is_vertex:
        body += "    ${PRECISION} ${VAR_TYPE} coords = ${VAR_TYPE}(a_coords);\n"
    elif write_access != CONST:
        body += "    ${PRECISION} ${VAR_TYPE} coords = ${VAR_TYPE}(v_coords);\n"
    body += "    ${PRECISION} ${VAR_TYPE} arr[${ARRAY_LEN}];\n"
    if write_access == STATIC:
        body += "    arr[0] = ${VAR_TYPE}(coords);\n    arr[1] = ${VAR_TYPE}(coords) * 0.5;\n    arr[2] = ${VAR_TYPE}(coords) * 0.25;\n    arr[3] = ${VAR_TYPE}(coords) * 0.125;\n"
    elif write_access == CONST:
        constructors = ["0.125", "0.125, 0.25", "0.125, 0.25, 0.5", "0.125, 0.25, 0.5, 1.0"]
        args = constructors[{"float": 1, "vec2": 2, "vec3": 3, "vec4": 4}[var_type] - 1]
        body += f"    arr[0] = ${{VAR_TYPE}}({args});\n    arr[1] = ${{VAR_TYPE}}({args}) * 0.5;\n    arr[2] = ${{VAR_TYPE}}({args}) * 0.25;\n    arr[3] = ${{VAR_TYPE}}({args}) * 0.125;\n"
        body += "    int i = 4;\n"
        for i in range(4, 40):
            body += f"    arr[i++] = ${{VAR_TYPE}}({i}.0);\n"
    elif write_access == DYNAMIC:
        body += "    arr[ui_zero]  = ${VAR_TYPE}(coords);\n    arr[ui_one]   = ${VAR_TYPE}(coords) * 0.5;\n    arr[ui_two]   = ${VAR_TYPE}(coords) * 0.25;\n    arr[ui_three] = ${VAR_TYPE}(coords) * 0.125;\n"
    elif write_access == STATIC_LOOP:
        body += "    for (int i = 0; i < 4; i++)\n    {\n        arr[i] = ${VAR_TYPE}(coords);\n        coords = coords * 0.5;\n    }\n"
    else:
        body += "    for (int i = 0; i < ui_four; i++)\n    {\n        arr[i] = ${VAR_TYPE}(coords);\n        coords = coords * 0.5;\n    }\n"
    body += "    ${PRECISION} ${VAR_TYPE} res = ${VAR_TYPE}(0.0);\n" + read_loop("arr", read_access)
    vtx_tail_frag = "" if write_access == CONST else "    v_coords = a_coords;\n"
    vtx, frag = finish(
        is_vertex, vtx, frag, decls, VTX_MAIN, FRAG_MAIN, body,
        "    v_color = vec4(res${PADDING});\n", "    o_color = v_color;\n", vtx_tail_frag, "    o_color = vec4(res${PADDING});\n",
    )
    params = {"VAR_TYPE": var_type, "ARRAY_LEN": "40" if write_access == CONST else "4", "PRECISION": "mediump", "PADDING": padding_for(var_type)}
    return specialize(vtx, params), specialize(frag, params)


def vector_subscript_case(is_vertex, var_type, write_access, read_access):
    vec_len = {"vec2": 2, "vec3": 3, "vec4": 4}[var_type]
    vec_len_name = INT_UNIFORM_NAMES[vec_len]
    vtx, frag = stage_headers(is_vertex, "vec3")
    decls = ""
    if write_access == SUBSCRIPT_DYNAMIC or read_access == SUBSCRIPT_DYNAMIC:
        decls += "layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };\n"
        if vec_len >= 2:
            decls += "layout(std140, binding = 1) uniform something1 { mediump int ui_one; };\n"
        if vec_len >= 3:
            decls += "layout(std140, binding = 2) uniform something2 { mediump int ui_two; };\n"
        if vec_len >= 4:
            decls += "layout(std140, binding = 3) uniform something3 { mediump int ui_three; };\n"
    if write_access == SUBSCRIPT_DYNAMIC_LOOP or read_access == SUBSCRIPT_DYNAMIC_LOOP:
        decls += f"layout(std140, binding = {vec_len}) uniform something{vec_len} {{ mediump int {vec_len_name}; }};\n"

    body = "    ${PRECISION} ${VAR_TYPE} coords = ${VAR_TYPE}(" + ("a_coords" if is_vertex else "v_coords") + ");\n"
    body += "    ${PRECISION} ${VAR_TYPE} tmp;\n"
    comps = ["x", "y", "z", "w"]
    scales = ["", " * 0.5", " * 0.25", " * 0.125"]
    names = ["ui_zero ", "ui_one  ", "ui_two  ", "ui_three"]
    if write_access == DIRECT:
        body += "    tmp = coords.${SWIZZLE} * vec4(1.0, 0.5, 0.25, 0.125).${SWIZZLE};\n"
    elif write_access == COMPONENT:
        body += "    tmp.x = coords.x;\n"
        for k in range(1, vec_len):
            body += f"    tmp.{comps[k]} = coords.{comps[k]}{scales[k]};\n"
    elif write_access == SUBSCRIPT_STATIC:
        body += "    tmp[0] = coords.x;\n"
        for k in range(1, vec_len):
            body += f"    tmp[{k}] = coords.{comps[k]}{scales[k]};\n"
    elif write_access == SUBSCRIPT_DYNAMIC:
        body += "    tmp[ui_zero]  = coords.x;\n"
        for k, pad in zip(range(1, vec_len), ["   ", "   ", ""]):
            body += f"    tmp[{names[k].strip()}]{pad} = coords.{comps[k]}{scales[k]};\n"
    elif write_access == SUBSCRIPT_STATIC_LOOP:
        body += f"    for (int i = 0; i < {vec_len}; i++)\n    {{\n        tmp[i] = coords.x;\n        coords = coords.${{ROT_SWIZZLE}} * 0.5;\n    }}\n"
    else:
        body += f"    for (int i = 0; i < {vec_len_name}; i++)\n    {{\n        tmp[i] = coords.x;\n        coords = coords.${{ROT_SWIZZLE}} * 0.5;\n    }}\n"

    body += "    ${PRECISION} float res = 0.0;\n"
    if read_access == DIRECT:
        body += "    res = dot(tmp, ${VAR_TYPE}(1.0));\n"
    elif read_access == COMPONENT:
        body += "    res += tmp.x;\n"
        for k in range(1, vec_len):
            body += f"    res += tmp.{comps[k]};\n"
    elif read_access == SUBSCRIPT_STATIC:
        body += "    res += tmp[0];\n"
        for k in range(1, vec_len):
            body += f"    res += tmp[{k}];\n"
    elif read_access == SUBSCRIPT_DYNAMIC:
        body += "    res += tmp[ui_zero];\n"
        for k in range(1, vec_len):
            body += f"    res += tmp[{names[k].strip()}];\n"
    elif read_access == SUBSCRIPT_STATIC_LOOP:
        body += f"    for (int i = 0; i < {vec_len}; i++)\n        res += tmp[i];\n"
    else:
        body += f"    for (int i = 0; i < {vec_len_name}; i++)\n        res += tmp[i];\n"

    vtx, frag = finish(
        is_vertex, vtx, frag, decls, VTX_MAIN, FRAG_MAIN, body,
        "    v_color = vec3(res);\n", "    o_color = vec4(v_color.rgb, 1.0);\n", "    v_coords = a_coords;\n", "    o_color = vec4(vec3(res), 1.0);\n",
    )
    swizzles = ["", "x", "xy", "xyz", "xyzw"]
    rot_swizzles = ["", "x", "yx", "yzx", "yzwx"]
    params = {"VAR_TYPE": var_type, "PRECISION": "mediump", "SWIZZLE": swizzles[vec_len], "ROT_SWIZZLE": rot_swizzles[vec_len]}
    return specialize(vtx, params), specialize(frag, params)


def matrix_subscript_case(is_vertex, mat_type, write_access, read_access):
    num_cols, num_rows = MATRIX_SIZES[mat_type]
    mat_size_name = INT_UNIFORM_NAMES[num_cols]
    vec_type = FLOAT_VEC[num_rows] if num_rows > 1 else "float"
    vtx, frag = stage_headers(is_vertex)
    decls = ""
    if write_access == DYNAMIC or read_access == DYNAMIC:
        decls += "layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };\n"
        if num_cols >= 2:
            decls += "layout(std140, binding = 1) uniform something1 { mediump int ui_one; };\n"
        if num_cols >= 3:
            decls += "layout(std140, binding = 2) uniform something2 { mediump int ui_two; };\n"
        if num_cols >= 4:
            decls += "layout(std140, binding = 3) uniform something3 { mediump int ui_three; };\n"
    if write_access == DYNAMIC_LOOP or read_access == DYNAMIC_LOOP:
        decls += f"layout(std140, binding = {num_cols}) uniform something{num_cols} {{ mediump int {mat_size_name}; }};\n"

    body = "    ${PRECISION} vec4 coords = " + ("a_coords" if is_vertex else "v_coords") + ";\n"
    body += "    ${PRECISION} ${MAT_TYPE} tmp;\n"
    col_swizzles = ["coords", "coords.yzwx", "coords.zwxy", "coords.wxyz"]
    scales = ["", " * 0.5", " * 0.25", " * 0.125"]
    names = ["ui_zero ", "ui_one  ", "ui_two  ", "ui_three"]
    if write_access == STATIC:
        body += "    tmp[0] = ${VEC_TYPE}(coords);\n"
        for k in range(1, num_cols):
            body += f"    tmp[{k}] = ${{VEC_TYPE}}({col_swizzles[k]}){scales[k]};\n"
    elif write_access == DYNAMIC:
        body += "    tmp[ui_zero]  = ${VEC_TYPE}(coords);\n"
        for k, pad in zip(range(1, num_cols), ["   ", "   ", ""]):
            body += f"    tmp[{names[k].strip()}]{pad} = ${{VEC_TYPE}}({col_swizzles[k]}){scales[k]};\n"
    elif write_access == STATIC_LOOP:
        body += f"    for (int i = 0; i < {num_cols}; i++)\n    {{\n        tmp[i] = ${{VEC_TYPE}}(coords);\n        coords = coords.yzwx * 0.5;\n    }}\n"
    else:
        body += f"    for (int i = 0; i < {mat_size_name}; i++)\n    {{\n        tmp[i] = ${{VEC_TYPE}}(coords);\n        coords = coords.yzwx * 0.5;\n    }}\n"

    body += "    ${PRECISION} ${VEC_TYPE} res = ${VEC_TYPE}(0.0);\n"
    if read_access == STATIC:
        body += "    res += tmp[0];\n"
        for k in range(1, num_cols):
            body += f"    res += tmp[{k}];\n"
    elif read_access == DYNAMIC:
        body += "    res += tmp[ui_zero];\n"
        for k in range(1, num_cols):
            body += f"    res += tmp[{names[k].strip()}];\n"
    elif read_access == STATIC_LOOP:
        body += f"    for (int i = 0; i < {num_cols}; i++)\n        res += tmp[i];\n"
    else:
        body += f"    for (int i = 0; i < {mat_size_name}; i++)\n        res += tmp[i];\n"

    vtx, frag = finish(
        is_vertex, vtx, frag, decls, VTX_MAIN, FRAG_MAIN, body,
        "    v_color = vec4(res${PADDING});\n", "    o_color = v_color;\n", "    v_coords = a_coords;\n", "    o_color = vec4(res${PADDING});\n",
    )
    padding = {2: ", 0.0, 1.0", 3: ", 1.0"}.get(num_rows, "")
    params = {"MAT_TYPE": mat_type, "VEC_TYPE": vec_type, "PRECISION": "mediump", "PADDING": padding}
    return specialize(vtx, params), specialize(frag, params)


MATRIX_SIZES = {"mat2": (2, 2), "mat2x3": (2, 3), "mat2x4": (2, 4), "mat3x2": (3, 2), "mat3": (3, 3), "mat3x4": (3, 4), "mat4x2": (4, 2), "mat4x3": (4, 3), "mat4": (4, 4)}


def array_uniform_data(var_type):
    n = {"float": 1, "vec2": 2, "vec3": 3, "vec4": 4}[var_type]
    rows = []
    for scale in (1.0, 0.5, 0.25, 0.125):
        rows.append([CONST_COORDS[i] * scale if i < n else 0.0 for i in range(4)])
    return rows


def eval_for(group, var_type):
    n = {"float": 1, "vec2": 2, "vec3": 3, "vec4": 4}.get(var_type)
    if group == "varying_array":
        return f"IndexEval::ArrayCoords({n})"
    if group in ("uniform_array",):
        return f"IndexEval::ArrayUniform({n})"
    if group == "vector_subscript":
        return f"IndexEval::VectorSubscript({n})"
    cols, rows = MATRIX_SIZES[var_type]
    return f"IndexEval::MatrixSubscript({cols}, {rows})"


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    cases = []  # (group, name, is_vertex, vtx, frag, eval, array)
    float_and_vec = ["float", "vec2", "vec3", "vec4"]
    shaders = [("vertex", True), ("fragment", False)]

    for var_type in float_and_vec:
        for vert_access in range(CONST):
            for frag_access in range(CONST):
                name = f"{var_type}_{INDEX_ACCESS_NAMES[vert_access]}_write_{INDEX_ACCESS_NAMES[frag_access]}_read"
                vtx, frag = varying_array_case(var_type, vert_access, frag_access)
                cases.append(("varying_array", name, True, vtx, frag, eval_for("varying_array", var_type), None))
    for var_type in float_and_vec:
        for read_access in range(CONST):
            for shader_name, is_vertex in shaders:
                name = f"{var_type}_{INDEX_ACCESS_NAMES[read_access]}_read_{shader_name}"
                vtx, frag = uniform_array_case(is_vertex, var_type, read_access)
                cases.append(("uniform_array", name, is_vertex, vtx, frag, eval_for("uniform_array", var_type), array_uniform_data(var_type)))
    for var_type in float_and_vec:
        for write_access in range(5):
            for read_access in range(CONST):
                for shader_name, is_vertex in shaders:
                    name = f"{var_type}_{INDEX_ACCESS_NAMES[write_access]}_write_{INDEX_ACCESS_NAMES[read_access]}_read_{shader_name}"
                    vtx, frag = tmp_array_case(is_vertex, var_type, write_access, read_access)
                    # a const write makes the result a function of the constant coordinates
                    group_eval = eval_for("uniform_array" if write_access == CONST else "varying_array", var_type)
                    cases.append(("tmp_array", name, is_vertex, vtx, frag, group_eval, None))
    for var_type in ["vec2", "vec3", "vec4"]:
        for write_access in range(6):
            for read_access in range(6):
                for shader_name, is_vertex in shaders:
                    name = f"{var_type}_{VECTOR_ACCESS_NAMES[write_access]}_write_{VECTOR_ACCESS_NAMES[read_access]}_read_{shader_name}"
                    vtx, frag = vector_subscript_case(is_vertex, var_type, write_access, read_access)
                    cases.append(("vector_subscript", name, is_vertex, vtx, frag, eval_for("vector_subscript", var_type), None))
    for mat_type in MATRIX_SIZES:
        for write_access in range(CONST):
            for read_access in range(CONST):
                for shader_name, is_vertex in shaders:
                    name = f"{mat_type}_{INDEX_ACCESS_NAMES[write_access]}_write_{INDEX_ACCESS_NAMES[read_access]}_read_{shader_name}"
                    vtx, frag = matrix_subscript_case(is_vertex, mat_type, write_access, read_access)
                    cases.append(("matrix_subscript", name, is_vertex, vtx, frag, eval_for("matrix_subscript", mat_type), None))

    out = [
        "# Shader manifest for dEQP-VK.glsl.indexing.",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_indexing.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderIndexingTests.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    table = [
        "// @generated by hodow_cts/scripts/gen_shader_render_indexing.py - do not hand-edit.",
        "//",
        "// The cases of dEQP-VK.glsl.indexing: group, name, vertex case or fragment case, evaluation function and the contents of the uniform array (binding 5).",
        "",
        "use super::shader_render_indexing_tests::{IndexCaseData, IndexEval};",
        "",
        f"pub static INDEX_CASES: [IndexCaseData; {len(cases)}] = [",
    ]
    for group, name, is_vertex, vtx, frag, evaluator, array in cases:
        key = f"sr_indexing_{group}_{name}"
        out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
        for program_name, stage, source in (("vert", "vert", vtx), ("frag", "frag", frag)):
            (SRC / f"{key}_{program_name}.{stage}").write_text(source)
            out.append(f'    {{ name = "{program_name}", template = "shader_render_indexing/{key}_{program_name}.{stage}", stage = "{stage}" }},')
        out += ["]", ""]
        array_literal = "None" if array is None else "Some([" + ", ".join("[" + ", ".join(f"{v!r}_f32" for v in row) + "]" for row in array) + "])"
        table.append(f'    IndexCaseData {{ group: "{group}", name: "{name}", is_vertex: {str(is_vertex).lower()}, eval: {evaluator}, array: {array_literal} }},')
    table.append("];")
    MANIFEST.write_text("\n".join(out))
    TABLE.write_text("\n".join(table) + "\n")
    print(len(cases), "cases")


if __name__ == "__main__":
    main()

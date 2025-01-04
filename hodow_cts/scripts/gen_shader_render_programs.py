#!/usr/bin/env python3
"""Writes the GLSL of the ShaderRenderCase based cases of dEQP-VK.glsl (shaderrender/vktShaderRender*Tests.cpp) and their manifest.

Upstream builds the vertex and fragment source of each case in the test constructors; this reproduces those string templates for every case of
the ported groups (return, switch) and lists each as one manifest case `sr_<group>_<case>` with the programs `vert` and `frag`, which the Rust
side finds in `ALL_SHARED_PROGRAM` by that name (src/vkt/tests/glsl/shader_render.rs).

Run from hodow_cts/:  python3 scripts/gen_shader_render_programs.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "shader_render"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render.toml"

RETURN_MODES = ["always", "never", "dynamic"]

RETURN_FRAGMENT_PASSTHROUGH = (
    "#version 310 es\nlayout(location = 0) in mediump vec4 v_color;\nlayout(location = 0) out mediump vec4 o_color;\n\n"
    "void main (void)\n{\n    o_color = v_color;\n}\n"
)
RETURN_VERTEX_PASSTHROUGH = (
    "#version 310 es\nlayout(location = 0) in  highp   vec4 a_position;\nlayout(location = 1) in  highp   vec4 a_coords;\n"
    "layout(location = 0) out mediump vec4 v_coords;\n\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_coords = a_coords;\n}\n"
)


def return_case(source, is_vertex):
    return (source, RETURN_FRAGMENT_PASSTHROUGH) if is_vertex else (RETURN_VERTEX_PASSTHROUGH, source)


def return_params(is_vertex, mode):
    coords = "a_coords" if is_vertex else "v_coords"
    cond = {"always": "true", "never": "false", "dynamic": f"{coords}.x+{coords}.y >= 0.0"}[mode]
    return {
        "COORDLOC": "1" if is_vertex else "0",
        "COORDPREC": "highp" if is_vertex else "mediump",
        "OUTPUT": "v_color" if is_vertex else "o_color",
        "COORDS": coords,
        "EXTRADECL": "layout(location = 0) in highp vec4 a_position;\nlayout(location = 0) out mediump vec4 v_color;\n" if is_vertex else "layout(location = 0) out mediump vec4 o_color;\n",
        "POSITIONWRITE": "    gl_Position = a_position;\n" if is_vertex else "",
        "RETURNCOND": cond,
    }


def specialize(template, params):
    for key, value in params.items():
        template = template.replace("${" + key + "}", value)
    return template


def return_cases():
    cases = []

    def fixed(name, vertex, fragment_src_vertex_stage, fragment_src_frag_stage):
        pass

    vertex_head = "#version 310 es\nlayout(location = 0) in highp vec4 a_position;\nlayout(location = 1) in highp vec4 a_coords;\nlayout(location = 0) out mediump vec4 v_color;\n"
    frag_head = "#version 310 es\nlayout(location = 0) in mediump vec4 v_coords;\nlayout(location = 0) out mediump vec4 o_color;\n"

    def both(name, vertex_body, fragment_body, vertex_extra="", fragment_extra=""):
        cases.append((f"{name}_vertex", *return_case(vertex_head + vertex_extra + vertex_body, True)))
        cases.append((f"{name}_fragment", *return_case(frag_head + fragment_extra + fragment_body, False)))

    both(
        "single_return",
        "\nvec4 getColor (void)\n{\n    return vec4(a_coords.xyz, 1.0);\n}\n\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_color = getColor();\n}\n",
        "mediump vec4 getColor (void)\n{\n    return vec4(v_coords.xyz, 1.0);\n}\n\nvoid main (void)\n{\n    o_color = getColor();\n}\n",
    )

    t = (
        "#version 310 es\nlayout(location = ${COORDLOC}) in ${COORDPREC} vec4 ${COORDS};\n${EXTRADECL}\n${COORDPREC} vec4 getColor (void)\n{\n"
        "    if (${RETURNCOND})\n        return vec4(${COORDS}.xyz, 1.0);\n    return vec4(${COORDS}.wzy, 1.0);\n}\n\nvoid main (void)\n{\n${POSITIONWRITE}    ${OUTPUT} = getColor();\n}\n"
    )
    for mode in RETURN_MODES:
        for is_fragment in range(2):
            is_vertex = is_fragment == 0
            name = f"conditional_return_{mode}" + ("_fragment" if is_fragment else "_vertex")
            cases.append((name, *return_case(specialize(t, return_params(is_vertex, mode)), is_vertex)))

    both(
        "double_return",
        "\nvec4 getColor (void)\n{\n    return vec4(a_coords.xyz, 1.0);\n    return vec4(a_coords.wzy, 1.0);\n}\n\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_color = getColor();\n}\n",
        "\nmediump vec4 getColor (void)\n{\n    return vec4(v_coords.xyz, 1.0);\n    return vec4(v_coords.wzy, 1.0);\n}\n\nvoid main (void)\n{\n    o_color = getColor();\n}\n",
    )
    both(
        "last_statement_in_main",
        "\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_color = vec4(a_coords.xyz, 1.0);\n    return;\n}\n",
        "\nvoid main (void)\n{\n    o_color = vec4(v_coords.xyz, 1.0);\n    return;\n}\n",
    )

    in_func = (
        "#version 310 es\nlayout(location = ${COORDLOC}) in ${COORDPREC} vec4 ${COORDS};\n${EXTRADECL}\nvoid myfunc (void)\n{\n"
        "    ${OUTPUT} = vec4(${COORDS}.xyz, 1.0);\n    if (${RETURNCOND})\n        return;\n    ${OUTPUT} = vec4(${COORDS}.wzy, 1.0);\n}\n\n"
        "void main (void)\n{\n${POSITIONWRITE}    myfunc();\n}\n"
    )
    in_main = (
        "#version 310 es\nlayout(location = ${COORDLOC}) in ${COORDPREC} vec4 ${COORDS};\n${EXTRADECL}\nvoid main ()\n{\n${POSITIONWRITE}"
        "    ${OUTPUT} = vec4(${COORDS}.xyz, 1.0);\n    if (${RETURNCOND})\n        return;\n    ${OUTPUT} = vec4(${COORDS}.wzy, 1.0);\n}\n"
    )
    for func in range(2):
        for mode in RETURN_MODES:
            for is_fragment in range(2):
                is_vertex = is_fragment == 0
                name = "output_write_" + ("in_func_" if func else "") + mode + ("_fragment" if is_fragment else "_vertex")
                cases.append((name, *return_case(specialize(in_func if func else in_main, return_params(is_vertex, mode)), is_vertex)))

    loop = (
        "#version 310 es\nlayout(location = ${COORDLOC}) in ${COORDPREC} vec4 ${COORDS};\nlayout(binding = 0, std140) uniform something { mediump int ui_one; };\n"
        "${EXTRADECL}\n${COORDPREC} vec4 getCoords (void)\n{\n    ${COORDPREC} vec4 coords = ${COORDS};\n    for (int i = 0; i < ${ITERLIMIT}; i++)\n    {\n"
        "        if (${RETURNCOND})\n            return coords;\n        coords = coords.wzyx;\n    }\n    return coords;\n}\n\n"
        "void main (void)\n{\n${POSITIONWRITE}    ${OUTPUT} = vec4(getCoords().xyz, 1.0);\n}\n"
    )
    for dynamic in range(2):
        for mode in RETURN_MODES:
            for is_fragment in range(2):
                is_vertex = is_fragment == 0
                params = return_params(is_vertex, mode)
                params["ITERLIMIT"] = "ui_one" if dynamic else "1"
                name = "return_in_" + ("dynamic" if dynamic else "static") + "_loop_" + mode + ("_fragment" if is_fragment else "_vertex")
                cases.append((name, *return_case(specialize(loop, params), is_vertex)))

    infinite_vertex = (
        vertex_head + "layout(binding = 0, std140) uniform something { int ui_zero; };\nhighp vec4 getCoords (void)\n{\n    for (int i = 1; i < 10; i += ui_zero)\n"
        "        return a_coords;\n    return a_coords.wzyx;\n}\n\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_color = vec4(getCoords().xyz, 1.0);\n    return;\n}\n"
    )
    infinite_fragment = (
        frag_head + "layout(binding = 0, std140) uniform something { int ui_zero; };\n\nmediump vec4 getCoords (void)\n{\n    for (int i = 1; i < 10; i += ui_zero)\n"
        "        return v_coords;\n    return v_coords.wzyx;\n}\n\nvoid main (void)\n{\n    o_color = vec4(getCoords().xyz, 1.0);\n    return;\n}\n"
    )
    cases.append(("return_in_infinite_loop_vertex", *return_case(infinite_vertex, True)))
    cases.append(("return_in_infinite_loop_fragment", *return_case(infinite_fragment, False)))
    return cases


SWITCH_BODIES = [
    ("basic", False, ["switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    case 2: res = coords.yzw;    break;", "    case 3: res = coords.zyx;    break;", "}"]),
    (
        "const_expr_in_label",
        False,
        ["const int t = 2;", "switch (${CONDITION})", "{", "    case int(0.0): res = coords.xyz;    break;", "    case 2-1: res = coords.wzy;    break;", "    case 3&(1<<1): res = coords.yzw;    break;", "    case t+1: res = coords.zyx;    break;", "}"],
    ),
    ("default_label", False, ["switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    case 3: res = coords.zyx;    break;", "    default: res = coords.yzw;", "}"]),
    ("default_not_last", False, ["switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    default: res = coords.yzw;    break;", "    case 1: res = coords.wzy;    break;", "    case 3: res = coords.zyx;    break;", "}"]),
    ("no_default_label", False, ["res = coords.yzw;\n", "switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    case 3: res = coords.zyx;    break;", "}"]),
    ("default_only", True, ["switch (${CONDITION})", "{", "    default:", "        res = coords.yzw;", "}"]),
    ("empty_case_default", True, ["switch (${CONDITION})", "{", "    case 2:", "    default:", "        res = coords.yzw;", "}"]),
    (
        "fall_through",
        False,
        ["switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    case 2: coords = coords.yzwx;", "    case 4: res = vec3(coords);    break;", "    case 3: res = coords.zyx;    break;", "}"],
    ),
    (
        "fall_through_default",
        False,
        ["switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    case 3: res = coords.zyx;    break;", "    case 2: coords = coords.yzwx;", "    default: res = vec3(coords);", "}"],
    ),
    (
        "conditional_fall_through",
        False,
        [
            "highp vec4 tmp = coords;", "switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    case 2:", "        tmp = coords.yzwx;",
            "    case 3:", "        res = vec3(tmp);", "        if (${CONDITION} != 3)", "            break;", "    default: res = tmp.zyx;        break;", "}",
        ],
    ),
    (
        "conditional_fall_through_2",
        False,
        [
            "highp vec4 tmp = coords;", "mediump int c = ${CONDITION};", "switch (c)", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    case 2:",
            "        c += ${CONDITION};", "        tmp = coords.yzwx;", "    case 3:", "        res = vec3(tmp);", "        if (c == 4)", "            break;", "    default: res = tmp.zyx;        break;", "}",
        ],
    ),
    (
        "scope",
        False,
        ["switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    case 2:", "    {", "        mediump vec3 t = coords.yzw;", "        res = t;", "        break;", "    }", "    case 3: res = coords.zyx;    break;", "}"],
    ),
    (
        "switch_in_if",
        False,
        [
            "if (${CONDITION} >= 0)", "{", "    switch (${CONDITION})", "    {", "        case 0: res = coords.xyz;    break;", "        case 1: res = coords.wzy;    break;", "        case 2: res = coords.yzw;    break;",
            "        case 3: res = coords.zyx;    break;", "    }", "}",
        ],
    ),
    (
        "switch_in_for_loop",
        False,
        [
            "for (int i = 0; i <= ${CONDITION}; i++)", "{", "    switch (i)", "    {", "        case 0: res = coords.xyz;    break;", "        case 1: res = coords.wzy;    break;", "        case 2: res = coords.yzw;    break;",
            "        case 3: res = coords.zyx;    break;", "    }", "}",
        ],
    ),
    (
        "switch_in_while_loop",
        False,
        [
            "int i = 0;", "while (i <= ${CONDITION})", "{", "    switch (i)", "    {", "        case 0: res = coords.xyz;    break;", "        case 1: res = coords.wzy;    break;",
            "        case 2: res = coords.yzw;    break;", "        case 3: res = coords.zyx;    break;", "    }", "    i += 1;", "}",
        ],
    ),
    (
        "switch_in_do_while_loop",
        False,
        [
            "int i = 0;", "do", "{", "    switch (i)", "    {", "        case 0: res = coords.xyz;    break;", "        case 1: res = coords.wzy;    break;", "        case 2: res = coords.yzw;    break;",
            "        case 3: res = coords.zyx;    break;", "    }", "    i += 1;", "} while (i <= ${CONDITION});",
        ],
    ),
    (
        "if_in_switch",
        False,
        [
            "switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1: res = coords.wzy;    break;", "    default:", "        if (${CONDITION} == 2)", "            res = coords.yzw;",
            "        else", "            res = coords.zyx;", "        break;", "}",
        ],
    ),
    (
        "for_loop_in_switch",
        False,
        [
            "switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1:", "    case 2:", "    {", "        highp vec3 t = coords.yzw;", "        for (int i = 0; i < ${CONDITION}; i++)",
            "            t = t.zyx;", "        res = t;", "        break;", "    }", "    default: res = coords.zyx;    break;", "}",
        ],
    ),
    (
        "while_loop_in_switch",
        False,
        [
            "switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1:", "    case 2:", "    {", "        highp vec3 t = coords.yzw;", "        int i = 0;",
            "        while (i < ${CONDITION})", "        {", "            t = t.zyx;", "            i += 1;", "        }", "        res = t;", "        break;", "    }", "    default: res = coords.zyx;    break;", "}",
        ],
    ),
    (
        "do_while_loop_in_switch",
        False,
        [
            "switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1:", "    case 2:", "    {", "        highp vec3 t = coords.yzw;", "        int i = 0;", "        do",
            "        {", "            t = t.zyx;", "            i += 1;", "        } while (i < ${CONDITION});", "        res = t;", "        break;", "    }", "    default: res = coords.zyx;    break;", "}",
        ],
    ),
    (
        "switch_in_switch",
        False,
        [
            "switch (${CONDITION})", "{", "    case 0: res = coords.xyz;    break;", "    case 1:", "    case 2:", "        switch (${CONDITION} - 1)", "        {", "            case 0: res = coords.wzy;    break;",
            "            case 1: res = coords.yzw;    break;", "        }", "        break;", "    default: res = coords.zyx;    break;", "}",
        ],
    ),
]
SWITCH_TYPES = ["static", "uniform", "dynamic"]


def switch_case(switch_type, is_vertex, body):
    vtx = "#version 310 es\nlayout(location = 0) in highp vec4 a_position;\nlayout(location = 1) in highp vec4 a_coords;\n\n"
    frag = "#version 310 es\nlayout(location = 0) out mediump vec4 o_color;\n"
    if is_vertex:
        vtx += "layout(location = 0) out mediump vec4 v_color;\n"
        frag += "layout(location = 0) in mediump vec4 v_color;\n"
    else:
        vtx += "layout(location = 0) out highp vec4 v_coords;\n"
        frag += "layout(location = 0) in highp vec4 v_coords;\n"
    op = ""
    if switch_type == "uniform":
        declaration = "layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };\n"
        if is_vertex:
            vtx += declaration
        else:
            frag += declaration
    vtx += "\nvoid main (void)\n{\n    gl_Position = a_position;\n"
    frag += "\nvoid main (void)\n{\n"
    op += "    highp vec4 coords = " + ("a_coords" if is_vertex else "v_coords") + ";\n"
    op += "    mediump vec3 res = vec3(0.0);\n\n"
    condition = {"static": "2", "uniform": "ui_two", "dynamic": "int(floor(coords.z*1.5 + 2.0))"}[switch_type]
    op += specialize("".join("    " + line + "\n" for line in body), {"CONDITION": condition})
    op += "\n"
    if is_vertex:
        vtx += op + "    v_color = vec4(res, 1.0);\n"
        frag += "    o_color = v_color;\n"
    else:
        vtx += "    v_coords = a_coords;\n"
        frag += op + "    o_color = vec4(res, 1.0);\n"
    return vtx + "}\n", frag + "}\n"


def switch_cases():
    cases = []
    for name, skip_dynamic, body in SWITCH_BODIES:
        for switch_type in SWITCH_TYPES:
            if skip_dynamic and switch_type == "dynamic":
                continue
            cases.append((f"{name}_{switch_type}_vertex", *switch_case(switch_type, True, body)))
            cases.append((f"{name}_{switch_type}_fragment", *switch_case(switch_type, False, body)))
    return cases


DISCARD_HEADER = (
    "#version 310 es\n#extension GL_EXT_demote_to_helper_invocation : enable\nlayout(location = 0) in mediump vec4 v_color;\n"
    "layout(location = 1) in mediump vec4 v_coords;\nlayout(location = 2) in mediump vec4 a_one;\nlayout(location = 0) out mediump vec4 o_color;\n"
    "layout(set = 0, binding = 2) uniform sampler2D    ut_brick;\nlayout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };\n\n"
)
DISCARD_VERTEX = (
    "#version 310 es\nlayout(location=0) in  highp   vec4 a_position;\nlayout(location=1) in  highp   vec4 a_coords;\nlayout(location=2) in  highp   vec4 a_one;\n"
    "layout(location=0) out mediump vec4 v_color;\nlayout(location=1) out mediump vec4 v_coords;\n\nlayout(location=2) out mediump vec4 v_one;\n"
    "void main (void)\n{\n    gl_Position = a_position;\n    v_color = vec4(a_coords.xyz, 1.0);\n    v_coords = a_coords;\n    v_one = a_one;\n}\n"
)
DISCARD_TEMPLATES = [
    ("basic", DISCARD_HEADER + "void main (void)\n{\n    o_color = v_color;\n    ${DISCARD};\n}\n"),
    ("function", DISCARD_HEADER + "void myfunc (void)\n{\n    ${DISCARD};\n}\n\nvoid main (void)\n{\n    o_color = v_color;\n    myfunc();\n}\n"),
    (
        "static_loop",
        DISCARD_HEADER + "void main (void)\n{\n    o_color = v_color;\n    for (int i = 0; i < 2; i++)\n    {\n        if (i > 0) {\n            ${DISCARD};\n        }\n    }\n}\n",
    ),
    (
        "dynamic_loop",
        DISCARD_HEADER
        + "layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };\n\n"
        + "void main (void)\n{\n    o_color = v_color;\n    for (int i = 0; i < ui_two; i++)\n    {\n        if (i > 0) {\n            ${DISCARD};\n        }\n    }\n}\n",
    ),
    (
        "function_static_loop",
        DISCARD_HEADER
        + "void myfunc (void)\n{\n    for (int i = 0; i < 2; i++)\n    {\n        if (i > 0) {\n            ${DISCARD};\n        }\n    }\n}\n\n"
        + "void main (void)\n{\n    o_color = v_color;\n    myfunc();\n}\n",
    ),
]
DISCARD_MODES = ["always", "never", "uniform", "dynamic", "texture", "deriv"]
DEMOTE_DERIV = (
    "  ivec2 f = ivec2(gl_FragCoord.xy);\n  int lsb = (f.x | f.y)&1;\n  if (lsb != 0) demote;\n  bool isHelper = helperInvocationEXT();\n"
    "  highp vec2 dx = dFdx(a_one.xy + gl_FragCoord.xy);\n  highp vec2 dy = dFdy(a_one.xy + gl_FragCoord.xy);\n  highp float dh = dFdx(float(isHelper));\n"
    "  bool valid = abs(dx.x-1.0) < 0.01 && dx.y == 0.0 && dy.x == 0.0 && abs(dy.y-1.0) < 0.01 && abs(dh-1.0) < 0.1 && !isHelper;\n"
    "  if (valid) demote;\n  o_color = vec4(1,0,0,1);\n"
)


def discard_cases(group):
    """`makeDiscardCase` for the `discard` and `demote` groups; the texture mode samples the brick texture of the Rust side."""
    cases = []
    for template_name, template in DISCARD_TEMPLATES:
        for mode in DISCARD_MODES:
            if mode == "deriv" and group == "discard":
                continue
            discard = {
                "always": group,
                "never": "if (false) " + group,
                "uniform": "if (ui_one > 0) " + group,
                "dynamic": "if (v_coords.x+v_coords.y > 0.0) " + group,
                "texture": "if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) " + group,
                "deriv": DEMOTE_DERIV,
            }[mode]
            cases.append((f"{template_name}_{mode}", DISCARD_VERTEX, specialize(template, {"DISCARD": discard})))
    return cases


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for the ShaderRenderCase based groups of dEQP-VK.glsl (return, switch, discard, demote).",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_programs.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRender.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    for group, cases in (("return", return_cases()), ("switch", switch_cases()), ("discard", discard_cases("discard")), ("demote", discard_cases("demote"))):
        for name, vertex, fragment in cases:
            key = f"sr_{group}_{name}"
            out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
            for program_name, stage, source in (("vert", "vert", vertex), ("frag", "frag", fragment)):
                (SRC / f"{key}_{program_name}.{stage}").write_text(source)
                out.append(f'    {{ name = "{program_name}", template = "shader_render/{key}_{program_name}.{stage}", stage = "{stage}" }},')
            out += ["]", ""]
    MANIFEST.write_text("\n".join(out))


if __name__ == "__main__":
    main()

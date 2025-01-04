#!/usr/bin/env python3
"""Writes the shaders and the manifest of the `constant` cases of dEQP-VK.glsl.derivate (shaderrender/vktShaderRenderDerivateTests.cpp): a derivative of a constant is zero.

`ConstantDerivateCase::initPrograms` and `genVertexSource` are reproduced; the case tree and the verification are in src/vkt/tests/glsl/shader_render_derivate_tests.rs.
Written: shaders/manifest/shader_render_derivate.toml and shaders/src/shader_render_derivate/.

Run from hodow_cts/:  python3 scripts/gen_shader_render_derivate.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "shader_render_derivate"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render_derivate.toml"

FUNCS = [
    ("dfdx", "dFdx"), ("dfdxfine", "dFdxFine"), ("dfdxcoarse", "dFdxCoarse"), ("dfdy", "dFdy"), ("dfdyfine", "dFdyFine"), ("dfdycoarse", "dFdyCoarse"),
    ("fwidth", "fwidth"), ("fwidthfine", "fwidthFine"), ("fwidthcoarse", "fwidthCoarse"),
]
TYPES = [("float", "7.7", "vec4(res, 0.0, 0.0, 1.0)"), ("vec2", "vec2(-0.0, 2.7)", "vec4(res, 0.0, 1.0)"), ("vec3", "vec3(1e2, 8.0, 0.01)", "vec4(res, 1.0)"),
         ("vec4", "vec4(1.0, 7.2, -1e5, 0.0)", "res")]

VERTEX = "#version 450\nlayout(location = 0) in highp vec4 a_position;\nout gl_PerVertex {\n    vec4 gl_Position;\n};\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n"
FRAGMENT = (
    "#version 450\nlayout(location = 0) out mediump vec4 o_color;\nlayout(binding = 0, std140) uniform Scale { highp ${DATATYPE} u_scale; };\n"
    "layout(binding = 1, std140) uniform Bias { highp ${DATATYPE} u_bias; }; \nvoid main (void)\n{\n    highp ${DATATYPE} res = ${FUNC}(${VALUE}) * u_scale + u_bias;\n"
    "    o_color = ${CAST_TO_OUTPUT};\n}\n"
)


LINEAR_VERTEX = (
    "#version 450\nlayout(location = 0) in highp vec4 a_position;\nlayout(location = 1) in ${PRECISION} ${DATATYPE} a_coord;\n"
    "layout(location = 0) out ${PRECISION} ${DATATYPE} v_coord;\nout gl_PerVertex {\n    vec4 gl_Position;\n};\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_coord = a_coord;\n}\n"
)
LINEAR_HEAD = (
    "#version 450\nlayout(location = 0) in ${PRECISION} ${DATATYPE} v_coord;\nlayout(location = 0) out ${PRECISION} vec4 o_color;\n"
    "layout(binding = 0, std140) uniform Scale { ${PRECISION} ${DATATYPE} u_scale; };\nlayout(binding = 1, std140) uniform Bias { ${PRECISION} ${DATATYPE} u_bias; };\n"
)
LINEAR_CASES = [
    ("linear", LINEAR_HEAD + "void main (void)\n{\n    ${PRECISION} ${DATATYPE} res = ${FUNC}(v_coord) * u_scale + u_bias;\n    o_color = ${CAST_TO_OUTPUT};\n}\n"),
    ("in_function", LINEAR_HEAD + "\n${PRECISION} ${DATATYPE} computeRes (${PRECISION} ${DATATYPE} value)\n{\n    return ${FUNC}(v_coord) * u_scale + u_bias;\n}\n\n"
     "void main (void)\n{\n    ${PRECISION} ${DATATYPE} res = computeRes(v_coord);\n    o_color = ${CAST_TO_OUTPUT};\n}\n"),
]


def _main_body(binding2, body):
    return LINEAR_HEAD + binding2 + "void main (void)\n{\n" + body + "    o_color = ${CAST_TO_OUTPUT};\n}\n"


UI_TRUE = 'layout(binding = 2, std140) uniform Ui_true { bool ub_true; };\n'
UI_TWO = 'layout(binding = 2, std140) uniform Ui_two { int ui_two; };\n'
UI_ONE = 'layout(binding = 2, std140) uniform Ui_one { int ui_one; };\n'
RES = "    ${PRECISION} ${DATATYPE} res"
DYNAMIC_PRELUDE = (
    "    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;\n    uvec4 quad_ballot = uvec4(0);\n"
    "    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);\n"
    "    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;\n"
)
BALLOT = "#extension GL_KHR_shader_subgroup_ballot : require\n"
LOOP_STATIC = RES + " = ${DATATYPE}(0.0);\n    for (int i = 0; i < %s; i++)\n        res += ${FUNC}(v_coord * float(i));\n    res = res * u_scale + u_bias;\n"
SWITCH = RES + ";\n    switch (%s)\n    {\n        case 0: res = ${FUNC}(%s) * u_scale + u_bias;    break;\n        case 1: res = ${FUNC}(%s) * u_scale + u_bias;    break;\n    }\n"
LINEAR_CASES += [
    ("static_if", _main_body("", RES + ";\n    if (false)\n        res = ${FUNC}(-v_coord) * u_scale + u_bias;\n    else\n        res = ${FUNC}(v_coord) * u_scale + u_bias;\n"), None),
    ("static_loop", _main_body("", LOOP_STATIC % "2"), None),
    ("static_switch", _main_body("", SWITCH % ("1", "-v_coord", "v_coord")), None),
    ("uniform_if", _main_body(UI_TRUE, RES + ";\n    if (ub_true)        res = ${FUNC}(v_coord) * u_scale + u_bias;\n    else\n        res = ${FUNC}(-v_coord) * u_scale + u_bias;\n"), None),
    ("uniform_loop", _main_body(UI_TWO, LOOP_STATIC % "ui_two"), None),
    ("uniform_switch", _main_body(UI_ONE, SWITCH % ("ui_one", "-v_coord", "v_coord")), None),
    ("dynamic_if", _main_body(UI_ONE, RES + ";\n" + DYNAMIC_PRELUDE + "    if (quad_uniform)\n        res = ${FUNC}(v_coord) * u_scale + u_bias;\n    else\n        res = ${FUNC}(v_coord * float(ui_one)) * u_scale + u_bias;\n").replace("#version 450\n", "#version 450\n" + BALLOT, 1), "spirv1.3"),
    ("dynamic_loop", _main_body(UI_ONE, RES + " = ${DATATYPE}(0.0);\n" + DYNAMIC_PRELUDE + "    for (int i = 0; i < ui_one + int(quad_uniform); i++)\n        res = ${FUNC}(v_coord * float(i - int(quad_uniform) + 1));\n    res = res * u_scale + u_bias;\n").replace("#version 450\n", "#version 450\n" + BALLOT, 1), "spirv1.3"),
    ("dynamic_switch", _main_body(UI_ONE, RES + ";\n" + DYNAMIC_PRELUDE + "    switch (int(quad_uniform))\n    {\n        case 0: res = ${FUNC}(v_coord) * u_scale + u_bias;    break;\n        case 1: res = ${FUNC}(v_coord * float(ui_one)) * u_scale + u_bias;    break;\n    }\n").replace("#version 450\n", "#version 450\n" + BALLOT, 1), "spirv1.3"),
]
LINEAR_CASES.append((
    "output_store",
    LINEAR_HEAD.replace("layout(location = 0) out ${PRECISION} vec4 o_color;\n", "layout(location = 0) out ${PRECISION} vec4 o_color;\nlayout(location = 1) out ${PRECISION} ${DATATYPE} intermediateStore;\n", 1)
    + "void main (void)\n{\n    intermediateStore = v_coord;\n    ${PRECISION} ${DATATYPE} res = ${FUNC}(intermediateStore) * u_scale + u_bias;\n    o_color = ${CAST_TO_OUTPUT};\n}\n",
    None,
))
LINEAR_CASES.append((
    "private_store",
    LINEAR_HEAD.replace("#version 450\n", "#version 450\n#extension GL_EXT_demote_to_helper_invocation : enable\n", 1)
    + "${PRECISION} ${DATATYPE} intermediateStore;\nvoid main (void)\n{\n    intermediateStore = v_coord;\n    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;\n"
    + "    ${PRECISION} ${DATATYPE} res = ${FUNC}(intermediateStore) * u_scale + u_bias;\n    o_color = ${CAST_TO_OUTPUT};\n}\n",
    None,
))

SUBGROUP_FUNCS = [("dfdxsubgroup", "dFdxSubgroup"), ("dfdysubgroup", "dFdySubgroup")]
SUBGROUP_MAIN = (
    "\nvoid main (void)\n{\n    uvec4 quad_ballot = uvec4(0);\n    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);\n"
    "    ${PRECISION} ${DATATYPE} res = ${FUNC}(v_coord) * u_scale + u_bias;\n    o_color = ${CAST_TO_OUTPUT};\n}\n"
)
SUBGROUP_TEMPLATES = {
    "dfdxsubgroup": LINEAR_HEAD.replace("#version 450\n", "#version 450\n#extension GL_KHR_shader_subgroup_ballot : require\n#extension GL_KHR_shader_subgroup_quad : require\n", 1)
    + "${DATATYPE} dFdxSubgroup(${DATATYPE} f)\n{\n    ${DATATYPE} left, right;\n    if ((gl_SubgroupInvocationID & 2) == 0) {\n        left = subgroupQuadBroadcast(f, 0);\n"
    "        right = subgroupQuadBroadcast(f, 1);\n    } else {\n        left = subgroupQuadBroadcast(f, 2);\n        right = subgroupQuadBroadcast(f, 3);\n    }\n    return right - left;\n}\n" + SUBGROUP_MAIN,
    "dfdysubgroup": LINEAR_HEAD.replace("#version 450\n", "#version 450\n#extension GL_KHR_shader_subgroup_quad : require\n#extension GL_KHR_shader_subgroup_ballot : require\n", 1)
    + "${DATATYPE} dFdySubgroup(${DATATYPE} f)\n{\n    ${DATATYPE} top, bottom;\n    if ((gl_SubgroupInvocationID & 1) == 0) {\n        top = subgroupQuadBroadcast(f, 0);\n"
    "        bottom = subgroupQuadBroadcast(f, 2);\n    } else {\n        top = subgroupQuadBroadcast(f, 1);\n        bottom = subgroupQuadBroadcast(f, 3);\n    }\n    return bottom - top;\n}\n" + SUBGROUP_MAIN,
}


TEXTURE_FRAGMENT = (
    "#version 450\nlayout(location = 0) in highp vec2 v_coord;\nlayout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n"
    "layout(binding = 0, std140) uniform Scale { ${PRECISION} ${DATATYPE} u_scale; };\nlayout(binding = 1, std140) uniform Bias { ${PRECISION} ${DATATYPE} u_bias; };\n"
    "layout(binding = 2) uniform ${PRECISION} sampler2D u_sampler;\nvoid main (void)\n{\n    ${PRECISION} vec4 tex = texture(u_sampler, v_coord);\n"
    "    ${PRECISION} ${DATATYPE} res = ${FUNC}(tex${SWIZZLE}) * u_scale + u_bias;\n    o_color = ${CAST_TO_OUTPUT};\n}\n"
)
FLOAT_CASTS = {"float": "floatBitsToUint(vec4(res, 0.0, 0.0, 1.0))", "vec2": "floatBitsToUint(vec4(res, 0.0, 1.0))", "vec3": "floatBitsToUint(vec4(res, 1.0))", "vec4": "floatBitsToUint(res)"}


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for dEQP-VK.glsl.derivate (the constant and the basic linear cases).",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_derivate.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderDerivateTests.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    for case_name, func in FUNCS:
        for type_name, value, cast in TYPES:
            key = f"sr_derivate_{case_name}_constant_{type_name}"
            frag = FRAGMENT.replace("${DATATYPE}", type_name).replace("${FUNC}", func).replace("${VALUE}", value).replace("${CAST_TO_OUTPUT}", cast)
            out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
            for program_name, stage, source in (("vert", "vert", VERTEX), ("frag", "frag", frag)):
                (SRC / f"{key}_{program_name}.{stage}").write_text(source)
                out.append(f'    {{ name = "{program_name}", template = "shader_render_derivate/{key}_{program_name}.{stage}", stage = "{stage}" }},')
            out += ["]", ""]
    for case_name, func in FUNCS:
        for linear_name, template, *spirv in [(e + (None,))[:3] if len(e) == 2 else e for e in LINEAR_CASES]:
            for type_name, _value, cast in TYPES:
                for precision in ("lowp", "mediump", "highp"):
                    if linear_name != "linear" and precision == "lowp":
                        continue
                    key = f"sr_derivate_{case_name}_{linear_name}_{type_name}_{precision}"
                    subst = lambda t: t.replace("${PRECISION}", precision).replace("${DATATYPE}", type_name).replace("${FUNC}", func).replace("${CAST_TO_OUTPUT}", cast)
                    out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
                    for program_name, stage, source in (("vert", "vert", subst(LINEAR_VERTEX)), ("frag", "frag", subst(template))):
                        (SRC / f"{key}_{program_name}.{stage}").write_text(source)
                        version = f', spirv_version = "{spirv[0]}"' if spirv[0] and program_name == "frag" else ""
                        out.append(f'    {{ name = "{program_name}", template = "shader_render_derivate/{key}_{program_name}.{stage}", stage = "{stage}"{version} }},')
                    out += ["]", ""]
    for case_name, func in FUNCS + SUBGROUP_FUNCS:
        template = SUBGROUP_TEMPLATES.get(case_name, LINEAR_CASES[0][1])
        spirv = "spirv1.3" if case_name in SUBGROUP_TEMPLATES else None
        for type_name, _value, cast in TYPES:
            for precision in ("mediump", "highp"):
                key = f"sr_derivate_{case_name}_fbo_{type_name}_{precision}"
                subst = lambda t: t.replace("${PRECISION}", precision).replace("${DATATYPE}", type_name).replace("${FUNC}", func).replace("${CAST_TO_OUTPUT}", cast)
                out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
                for program_name, stage, source in (("vert", "vert", subst(LINEAR_VERTEX)), ("frag", "frag", subst(template))):
                    (SRC / f"{key}_{program_name}.{stage}").write_text(source)
                    version = f', spirv_version = "{spirv}"' if spirv and program_name == "frag" else ""
                    out.append(f'    {{ name = "{program_name}", template = "shader_render_derivate/{key}_{program_name}.{stage}", stage = "{stage}"{version} }},')
                out += ["]", ""]
    # fbo_float: the same sources into an RGBA32UI target, the colour packed with floatBitsToUint (LinearDerivateCase::initPrograms, packToInt)
    for case_name, func in FUNCS + SUBGROUP_FUNCS:
        template = SUBGROUP_TEMPLATES.get(case_name, LINEAR_CASES[0][1]).replace("out ${PRECISION} vec4 o_color;", "out highp uvec4 o_color;", 1)
        spirv = "spirv1.3" if case_name in SUBGROUP_TEMPLATES else None
        for type_name, _value, _cast in TYPES:
            for precision in ("lowp", "mediump", "highp"):
                key = f"sr_derivate_{case_name}_fbofloat_{type_name}_{precision}"
                subst = lambda t: t.replace("${PRECISION}", precision).replace("${DATATYPE}", type_name).replace("${FUNC}", func).replace("${CAST_TO_OUTPUT}", FLOAT_CASTS[type_name])
                out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
                for program_name, stage, source in (("vert", "vert", subst(LINEAR_VERTEX)), ("frag", "frag", subst(template))):
                    (SRC / f"{key}_{program_name}.{stage}").write_text(source)
                    version = f', spirv_version = "{spirv}"' if spirv and program_name == "frag" else ""
                    out.append(f'    {{ name = "{program_name}", template = "shader_render_derivate/{key}_{program_name}.{stage}", stage = "{stage}"{version} }},')
                out += ["]", ""]
    # texture: TextureDerivateCase::initPrograms, the sampled value fed to the derivative (a vec2 coordinate at highp)
    swizzles = {"float": ".x", "vec2": ".xy", "vec3": ".xyz", "vec4": ""}
    for case_name, func in FUNCS:
        for kind, precisions in (("texture", ("mediump", "highp")), ("texturefloat", ("lowp", "mediump", "highp"))):
            for type_name, _value, cast in TYPES:
                for precision in precisions:
                    key = f"sr_derivate_{case_name}_{kind}_{type_name}_{precision}"
                    packed = kind == "texturefloat"
                    subst = lambda t: (t.replace("${OUTPUT_TYPE}", "uvec4" if packed else "vec4").replace("${OUTPUT_PREC}", "highp" if packed else precision)
                                        .replace("${PRECISION}", precision).replace("${DATATYPE}", type_name).replace("${FUNC}", func).replace("${SWIZZLE}", swizzles[type_name])
                                        .replace("${CAST_TO_OUTPUT}", FLOAT_CASTS[type_name] if packed else cast))
                    vertex = LINEAR_VERTEX.replace("${PRECISION}", "highp").replace("${DATATYPE}", "vec2")
                    out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
                    for program_name, stage, source in (("vert", "vert", vertex), ("frag", "frag", subst(TEXTURE_FRAGMENT))):
                        (SRC / f"{key}_{program_name}.{stage}").write_text(source)
                        out.append(f'    {{ name = "{program_name}", template = "shader_render_derivate/{key}_{program_name}.{stage}", stage = "{stage}" }},')
                    out += ["]", ""]
    MANIFEST.write_text("\n".join(out))


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Writes the shaders and the manifest of the vertex and fragment cases of dEQP-VK.glsl.shader_expect_assume (94 of vktShaderExpectAssumeTests.cpp).

`addVertexTestShaders` and `addFragmentTestShaders` are reproduced here (the compute ones are in gen_shader_expect_assume_manifest.py, whose case list and
parameter helpers are reused). The vertex cases pass the result through a flat varying that the fixed fragment shader writes next to gl_FragCoord.x into an
R32G32_UINT attachment; the fragment cases write both values themselves. Written:

  * shaders/manifest/shader_expect_assume_gfx.toml and shaders/src/shader_expect_assume_gfx/ (one `sea_<stage>_<op>_<name>` per case with `vert` and `frag`),
  * src/vkt/tests/glsl/shader_expect_assume_gfx_cases.rs (the case table: stage, operation, name, the data parameters the host needs, manifest key).

Run from hodow_cts/:  python3 scripts/gen_shader_expect_assume_gfx_manifest.py   (then `just cts-shaders`)
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import gen_shader_expect_assume_manifest as base  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "shader_expect_assume_gfx"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_expect_assume_gfx.toml"
TABLE = ROOT / "src" / "vkt" / "tests" / "glsl" / "shader_expect_assume_gfx_cases.rs"

INDEX = {"vertex": "gl_VertexIndex", "fragment": "uint(gl_FragCoord.x)"}


def operands(op, data_class, data_type, channels, stage):
    datatype = base.SCALAR[data_type] if channels == 1 else f"{base.VECTOR[data_type]}{channels}"
    index = INDEX[stage]
    expected = wrong = ""
    if data_class == "constant":
        varname = "kThisIsTrue"
    elif data_class == "specialization":
        varname = "scThisIsTrue"
    elif data_class == "push":
        varname = "pcThisIsTrue"
    else:
        varname = f"inputBuffer[{index}]"
    if op == "expect":
        if data_class != "storage":
            expected, wrong = "true", "false"
        elif data_type == "bool":
            expected, wrong = f"{datatype}(true)", f"{datatype}(false)"
        else:
            expected = f"{datatype}({index}" + "".join(f", {index} + {channel}" for channel in range(1, channels)) + ")"
            wrong = f"{datatype}({index}*2 + 3" + "".join(f", {index}*2 + 3 + {channel}" for channel in range(1, channels)) + ")"
    return datatype, varname, expected, wrong


def declarations(data_class, datatype, data_type, binding):
    lines = [
        "#extension GL_EXT_spirv_intrinsics: enable",
        base.EXTENSIONS.get(data_type, ""),
        'spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)',
        "void assumeTrueKHR(bool);",
        'spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)',
        f"{datatype} expectKHR({datatype}, {datatype});",
        "precision highp float;",
        "precision highp int;",
    ]
    return lines


def input_declaration(data_class, datatype):
    if data_class == "constant":
        return "bool kThisIsTrue = true;"
    if data_class == "specialization":
        return "layout (constant_id = 0) const bool scThisIsTrue = false;"
    if data_class == "push":
        return "layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };"
    return f"layout(set = 0, binding = 0, std430) buffer Block1 {{ {datatype} inputBuffer[]; }};"


def body(op, datatype, varname, expected, wrong_value):
    operator = "expectKHR" if op == "expect" else "assumeTrueKHR"
    operand_list = f"({varname})" if not expected else f"({varname}, {expected})"
    if op == "assume":
        return [f"    {operator} {operand_list};"]
    return [
        f"    {datatype} control = {wrong_value};",
        f"    if ( {operator}({varname}, {expected}) == {expected} ) {{",
        f"        control = {expected};",
        "    } else {",
        "        // set wrong value",
        f"        control = {wrong_value};",
        "    }",
    ]


def result_expression(op, varname, expected, wrong_value, wrong):
    if not expected:
        return f"uint({varname})"
    if op == "assume":
        return f"uint({varname} == {expected})"
    return f"uint(control == {wrong_value if wrong else expected})"


def vertex_case(op, data_class, data_type, channels, wrong):
    datatype, varname, expected, wrong_value = operands(op, data_class, data_type, channels, "vertex")
    lines = ["#version 460"] + declarations(data_class, datatype, data_type, 0) + [
        "layout(location = 0) in vec4 in_position;",
        "layout(location = 0) out flat uint value;",
        input_declaration(data_class, datatype),
        "void main() {",
    ] + body(op, datatype, varname, expected, wrong_value) + [
        "    gl_Position  = in_position;",
        f"    value = {result_expression(op, varname, expected, wrong_value, wrong)};",
        "}",
    ]
    vert = "\n".join(lines) + "\n"
    frag = (
        "#version 460\nprecision highp float;\nprecision highp int;\nlayout(location = 0) in flat uint value;\nlayout(location = 0) out uvec2 out_color;\n"
        "void main()\n{\n    out_color.r = uint(gl_FragCoord.x);\n    out_color.g = value;\n}\n"
    )
    return vert, frag


def fragment_case(op, data_class, data_type, channels, wrong):
    datatype, varname, expected, wrong_value = operands(op, data_class, data_type, channels, "fragment")
    vert = "#version 460\nprecision highp float;\nprecision highp int;\nlayout(location = 0) in vec4 in_position;\nvoid main() {\n    gl_Position  = in_position;\n}\n"
    lines = ["#version 460"] + declarations(data_class, datatype, data_type, 0) + [
        "layout(location = 0) out uvec2 out_color;",
        input_declaration(data_class, datatype),
        "void main()",
        "{",
    ] + body(op, datatype, varname, expected, wrong_value) + [
        "    out_color.r = int(gl_FragCoord.x);",
        f"    out_color.g = {result_expression(op, varname, expected, wrong_value, wrong)};",
        "}",
    ]
    return vert, "\n".join(lines) + "\n"


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for dEQP-VK.glsl.shader_expect_assume.{vertex,fragment}.",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_expect_assume_gfx_manifest.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderexecutor/vktShaderExpectAssumeTests.cpp"',
        'rust_module = "glsl/shader_expect_assume_gfx_tests"',
        "",
    ]
    table = []
    for stage, make in (("vertex", vertex_case), ("fragment", fragment_case)):
        for op, data_class, data_type, channels, wrong, name in base.cases():
            key = f"sea_{stage}_{op}_{name}"
            vert, frag = make(op, data_class, data_type, channels, wrong)
            out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
            for program_name, ext, text in (("vert", "vert", vert), ("frag", "frag", frag)):
                (SRC / f"{key}_{program_name}.{ext}").write_text(text)
                out.append(f'    {{ name = "{program_name}", template = "shader_expect_assume_gfx/{key}_{program_name}.{ext}", stage = "{ext}" }},')
            out += ["]", ""]
            spec = f"class={data_class};type={data_type};chan={channels};wrong={int(wrong)}"
            table.append((stage, op, name, spec, key))
    MANIFEST.write_text("\n".join(out))
    rows = [f'    ("{stage}", "{op}", "{name}", "{spec}", "{key}"),' for stage, op, name, spec, key in table]
    TABLE.write_text(
        "// @generated by hodow_cts/scripts/gen_shader_expect_assume_gfx_manifest.py - do not hand-edit.\n\n"
        "/// (stage, operation, case name, data parameters, manifest key of the shaders)\n"
        f"pub static GFX_CASES: [(&str, &str, &str, &str, &str); {len(table)}] = [\n" + "\n".join(rows) + "\n];\n"
    )
    print(f"{len(table)} cases")


if __name__ == "__main__":
    main()

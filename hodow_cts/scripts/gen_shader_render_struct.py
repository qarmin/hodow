#!/usr/bin/env python3
"""Writes the GLSL of dEQP-VK.glsl.struct.local (shaderrender/vktShaderRenderStructTests.cpp), their manifest and the case table of the Rust side.

The LOCAL_STRUCT_CASE invocations are read from the vendored C++: the `LineStream` of each case is the shader (filled in by `createStructCase`), the
`useUniform` calls are its uniforms and the eval body is one of the `swizzle`, blend and equality forms the Rust side knows by name. The
UNIFORM_STRUCT_CASE cases (a struct written into a uniform buffer from the constant coordinates) have no shaders here: they are listed for the Rust side as stubs.

  * shaders/manifest/shader_render_struct.toml and shaders/src/shader_render_struct/,
  * src/vkt/tests/glsl/shader_render_struct_cases.rs (the case table).

Run from hodow_cts/:  python3 scripts/gen_shader_render_struct.py   (then `just cts-shaders`)
"""
import re
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CPP = ROOT / "upstream/external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderStructTests.cpp"
SRC = ROOT / "shaders" / "src" / "shader_render_struct"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render_struct.toml"
TABLE = ROOT / "src" / "vkt" / "tests" / "glsl" / "shader_render_struct_cases.rs"

UNIFORM_VALUES = {"UI_ZERO": ("Int", 0), "UI_ONE": ("Int", 1), "UI_TWO": ("Int", 2), "UI_THREE": ("Int", 3), "UI_FOUR": ("Int", 4), "UI_FIVE": ("Int", 5), "UI_SIX": ("Int", 6),
                  "UF_ZERO": ("Float", 0.0), "UF_ONE": ("Float", 1.0), "UF_TWO": ("Float", 2.0), "UF_THREE": ("Float", 3.0), "UF_FOUR": ("Float", 4.0), "UF_FIVE": ("Float", 5.0),
                  "UF_SIX": ("Float", 6.0), "UF_HALF": ("Float", 1.0 / 2.0), "UF_THIRD": ("Float", 1.0 / 3.0), "UF_FOURTH": ("Float", 1.0 / 4.0), "UF_FIFTH": ("Float", 1.0 / 5.0),
                  "UF_SIXTH": ("Float", 1.0 / 6.0)}

DEFAULT_VERT = (
    "#version 310 es\nlayout(location = 0) in highp vec4 a_position;\nlayout(location = 1) in highp vec4 a_coords;\nlayout(location = 0) out mediump vec4 v_coords;\n\n"
    "void main (void)\n{\n    v_coords = a_coords;\n    gl_Position = a_position;\n}\n"
)
DEFAULT_FRAG = "#version 310 es\nlayout(location = 0) in mediump vec4 v_color;\nlayout(location = 0) out mediump vec4 o_color;\n\nvoid main (void)\n{\n    o_color = v_color;\n}\n"
VERTEX_PARAMS = {
    "HEADER": "#version 310 es\nlayout(location = 0) in highp vec4 a_position;\nlayout(location = 1) in highp vec4 a_coords;\nlayout(location = 0) out mediump vec4 v_color;",
    "COORDS": "a_coords", "DST": "v_color", "ASSIGN_POS": "gl_Position = a_position;",
}
FRAGMENT_PARAMS = {"HEADER": "#version 310 es\nlayout(location = 0) in mediump vec4 v_coords;\nlayout(location = 0) out mediump vec4 o_color;", "COORDS": "v_coords", "DST": "o_color", "ASSIGN_POS": ""}


CONST_COORDS = [0.125, 0.25, 0.5, 1.0]  # DEFAULT_CONST_COORDS of ShaderRenderCaseInstance


def f32(*values):
    return struct.pack(f"<{len(values)}f", *values)


def i32(*values):
    return struct.pack(f"<{len(values)}i", *values)


def cc(*indices):
    return [CONST_COORDS[i] for i in indices]


def vec4(*values):
    return f32(*(list(values) + [0.0] * (4 - len(values))))


def nested_struct_pair(variant):
    """`S s[2]` of the nested struct array cases: float a; T b[3] {float a; vec4 b[2]}; int c, every member at the std140 offset the C++ padding gives it."""
    if variant == 0:
        rows = [[(0.5, cc(0, 1), cc(2, 3)), (1.0 / 3.0, cc(2, 3), cc(0, 1)), (1.0 / 4.0, cc(0, 2), cc(1, 3))],
                [(2.0, cc(0, 0), cc(1, 1)), (3.0, cc(2, 2), cc(3, 3)), (4.0, cc(1, 0), cc(3, 2))]]
    else:
        rows = [[(0.5, cc(1, 0), cc(2, 0)), (1.0 / 3.0, cc(1, 1), cc(3, 1)), (1.0 / 4.0, cc(2, 1), cc(2, 1))],
                [(2.0, cc(2, 0), cc(2, 1)), (3.0, cc(2, 2), cc(3, 3)), (4.0, cc(1, 0), cc(3, 2))]]
    data = b""
    for ndx, row in enumerate(rows):
        data += f32(CONST_COORDS[0] if ndx == 0 else CONST_COORDS[3], 0, 0, 0)
        for a, b0, b1 in row:
            data += f32(a, 0, 0, 0) + vec4(*b0) + vec4(*b1)
        data += i32(ndx, 0, 0, 0)
    return data


def struct_array_bytes(b_values):
    return b"".join(f32(CONST_COORDS[i]) + i32(b_values[i]) + f32(0, 0) for i in range(3))


def padded_floats_struct():
    return f32(CONST_COORDS[3], 0, 0, 0) + f32(CONST_COORDS[2], 0, 0, 0) + f32(CONST_COORDS[1], 0, 0, 0) + f32(CONST_COORDS[0], 0, 0, 0) + i32(1)


def equal_struct(b1):
    return f32(1.0, 0, 0, 0) + f32(0.0, b1, 2.0) + i32(2)


# The bytes of every addUniform call, in call order, per UNIFORM_STRUCT_CASE
UNIFORM_STRUCT_BYTES = {
    "basic": [f32(CONST_COORDS[0], 0, 0, 0) + f32(*cc(1, 2, 3)) + i32(1)],
    "nested": [f32(CONST_COORDS[0], 0, 0, 0) + i32(0) + f32(0) + f32(*cc(1, 2)) + i32(1, 0, 0, 0)],
    "array_member": [padded_floats_struct()],
    "array_member_dynamic_index": [padded_floats_struct()],
    "struct_array": [struct_array_bytes([0, 1, 2])],
    "struct_array_dynamic_index": [struct_array_bytes([0, 1, 2])],
    "nested_struct_array": [nested_struct_pair(0)],
    "nested_struct_array_dynamic_index": [nested_struct_pair(0)],
    "loop_struct_array": [struct_array_bytes([0, -1, 2])],
    "loop_nested_struct_array": [nested_struct_pair(1)],
    "dynamic_loop_struct_array": [struct_array_bytes([0, -1, 2])],
    "dynamic_loop_nested_struct_array": [nested_struct_pair(1)],
    "equal": [equal_struct(1.0), equal_struct(1.0), equal_struct(1.1)],
    "not_equal": [equal_struct(1.0), equal_struct(1.0), equal_struct(1.1)],
}


def split_macro_args(text, start):
    """The top-level arguments of the macro call whose '(' is at text[start - 1]."""
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
                args.append("".join(current))
                return args, ndx
            depth -= 1
        elif ch == "," and depth == 0:
            args.append("".join(current))
            current = []
            ndx += 1
            continue
        current.append(ch)
        ndx += 1


def decode(literal):
    return literal.replace("\\n", "\n").replace("\\t", "\t").replace('\\"', '"').replace("\\\\", "\\")


def specialize(template, params):
    for key, value in params.items():
        template = template.replace("${" + key + "}", value)
    return template


def classify_eval(body):
    body = body.strip().strip("{}").strip()
    match = re.fullmatch(r"c\.color\.xyz\(\) = c\.coords\.swizzle\((\d), (\d), (\d)\);", body)
    if match:
        return f"StructEval::Swizzle({match.group(1)}, {match.group(2)}, {match.group(3)})"
    if re.fullmatch(r"c\.color\.xyz\(\) = \(c\.coords\.swizzle\(0, 1, 2\) \+ c\.coords\.swizzle\(1, 2, 3\)\) \* 0\.5f;", body):
        return "StructEval::Blend"
    if re.fullmatch(r"c\.color\.xyz\(\) = \(c\.constCoords\.swizzle\(0, 1, 2\) \+ c\.constCoords\.swizzle\(1, 2, 3\)\) \* 0\.5f;", body):
        return "StructEval::ConstBlend"
    match = re.fullmatch(r"c\.color\.xyz\(\) = c\.constCoords\.swizzle\((\d), (\d), (\d)\);", body)
    if match:
        return f"StructEval::ConstSwizzle({match.group(1)}, {match.group(2)}, {match.group(3)})"
    return None


def main():
    text = CPP.read_text()
    split_at = text.index("class UniformStructTests")
    cases = []  # (group, name, vertex shader, fragment shader, uniforms, eval, is_vertex)
    for group, region in (("local", text[:split_at]), ("uniform", text[split_at:])):
        macro = "LOCAL_STRUCT_CASE(" if group == "local" else "UNIFORM_STRUCT_CASE("
        pos = 0
        while True:
            pos = region.find("\n    " + macro, pos)
            if pos < 0:
                break
            start = pos + len("\n    " + macro)
            args, end = split_macro_args(region, start)
            pos = end
            name = args[0].strip()
            runs = re.findall(r'(?:"(?:[^"\\]|\\.)*"\s*)+', args[1])
            literals = ["".join(re.findall(r'"((?:[^"\\]|\\.)*)"', run)) for run in runs]
            shader = "".join(decode(lit) + "\n" for lit in literals)
            uniforms = [(int(b), UNIFORM_VALUES[t]) for b, t in re.findall(r"instance\.useUniform\((\d+)u, (\w+)\)", args[2])]
            has_custom_data = "addUniform" in args[2] and group == "local"
            raw = []
            if group == "uniform":
                bindings = [int(b) for b in re.findall(r"instance\.addUniform\((\d+)u, ", args[2])]
                assert len(bindings) == len(UNIFORM_STRUCT_BYTES[name]), name
                raw = list(zip(bindings, UNIFORM_STRUCT_BYTES[name]))
            evaluator = classify_eval(args[3])
            cases.append((group, name, shader, uniforms, evaluator, has_custom_data, raw))

    out = [
        "# Shader manifest for dEQP-VK.glsl.struct.local.",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_struct.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderStructTests.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    table = [
        "// @generated by hodow_cts/scripts/gen_shader_render_struct.py - do not hand-edit.",
        "//",
        "// The cases of dEQP-VK.glsl.struct: group, name, evaluation function and uniforms; `StructEval::Custom` is an equality evaluation named after the case.",
        "",
        "use super::shader_render::UniformValue;",
        "use super::shader_render_struct_tests::{StructCaseData, StructEval};",
        "",
        "pub static STRUCT_CASES: &[StructCaseData] = &[",
    ]
    count = 0
    for group, name, shader, uniforms, evaluator, has_custom_data, raw in cases:
        stub = has_custom_data
        if evaluator is None:
            evaluator = f'StructEval::Custom("{name}")'
        uniform_literal = "&[" + ", ".join(f"({binding}, UniformValue::{kind}({value!r}{'_f32' if kind == 'Float' else ''}))" for binding, (kind, value) in uniforms)
        for binding, data in raw:
            uniform_literal += f", ({binding}, UniformValue::Raw(&[{', '.join(str(byte) for byte in data)}]))"
        uniform_literal = "&[" + uniform_literal.removeprefix("&[").lstrip(", ") + "]"
        table.append(f'    StructCaseData {{ group: "{group}", name: "{name}", eval: {evaluator}, uniforms: {uniform_literal}, stub: {str(stub).lower()} }},')
        if stub:
            continue
        for suffix, is_vertex in (("vertex", True), ("fragment", False)):
            vtx, frag = (specialize(shader, VERTEX_PARAMS), DEFAULT_FRAG) if is_vertex else (DEFAULT_VERT, specialize(shader, FRAGMENT_PARAMS))
            key = f"sr_struct_{group}_{name}_{suffix}"
            out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
            for program_name, stage, source in (("vert", "vert", vtx), ("frag", "frag", frag)):
                (SRC / f"{key}_{program_name}.{stage}").write_text(source)
                out.append(f'    {{ name = "{program_name}", template = "shader_render_struct/{key}_{program_name}.{stage}", stage = "{stage}" }},')
            out += ["]", ""]
            count += 1
    table.append("];")
    SRC.mkdir(parents=True, exist_ok=True)
    MANIFEST.write_text("\n".join(out))
    TABLE.write_text("\n".join(table) + "\n")
    print(len(cases), "macro cases,", count, "shader cases")


if __name__ == "__main__":
    main()

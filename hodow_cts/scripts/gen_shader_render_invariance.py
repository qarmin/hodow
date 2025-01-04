#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.glsl.invariance and dEQP-VK.glsl.precise (shaderrender/vktShaderRenderInvarianceTests.cpp).

The three shader templates of every `new InvarianceTest(...)` are read from the vendored C++ (string literals of the `formatGLSL(...)` calls, the
`FormatArgumentList` extras and the case names are evaluated here), so the shaders are upstream's strings; only the three nested loops of `addBasicTests`
and `addExtendedInstructionsTests` are replayed by hand. Written:

  * shaders/manifest/shader_render_invariance.toml and shaders/src/shader_render_invariance/ (one `sr_inv_<kind>_<path>` per case with `vertex1`, `vertex2`
    and `fragment`),
  * src/vkt/tests/glsl/shader_render_invariance_cases.rs (the case table: tree path, name and the manifest key).

Run from hodow_cts/:  python3 scripts/gen_shader_render_invariance.py   (then `just cts-shaders`)
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CPP = ROOT / "upstream/external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderInvarianceTests.cpp"
SRC = ROOT / "shaders" / "src" / "shader_render_invariance"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render_invariance.toml"
TABLE = ROOT / "src" / "vkt" / "tests" / "glsl" / "shader_render_invariance_cases.rs"

PRECISIONS = [
    # name, high, high_inv, medium, low, low_inv, loop iterations, partial, norm exponent, norm literal, multiplier, sum norm literal
    ("highp", "1.0e20", "1.0e-20", "1.0e14", "1.0e9", "1.0e-9", 14, 11, 2, "1.0e4", "1.9", "1.0e3"),
    ("mediump", "1.0e4", "1.0e-4", "1.0e2", "1.0e1", "1.0e-1", 13, 11, 2, "1.0e4", "1.9", "1.0e3"),
    ("lowp", "0.9", "1.1", "1.1", "1.15", "0.87", 6, 2, 0, "2.0", "1.1", "1.0"),
]
PRECISION_NAMES = ["lowp", "mediump", "highp"]  # glu::Precision order


def tokens(text):
    """Yields ('str', decoded literal) and ('code', other text) pieces of a C++ fragment, skipping comments."""
    i, n = 0, len(text)
    code = []
    while i < n:
        c = text[i]
        if text.startswith("//", i):
            while i < n and text[i] != "\n":
                i += 1
        elif text.startswith("/*", i):
            i = text.index("*/", i) + 2
        elif c == '"':
            j = i + 1
            while text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            if code:
                yield ("code", "".join(code))
                code = []
            yield ("str", decode(text[i + 1 : j]))
            i = j + 1
        else:
            code.append(c)
            i += 1
    if code:
        yield ("code", "".join(code))


def decode(s):
    return s.replace("\\n", "\n").replace('\\"', '"').replace("\\\\", "\\")


def match_paren(text, start):
    """Index of the ')' that closes the '(' at `start`, skipping string literals and comments."""
    depth, i = 0, start
    while True:
        c = text[i]
        if c == '"':
            i += 1
            while text[i] != '"':
                i += 2 if text[i] == "\\" else 1
        elif text.startswith("//", i):
            while text[i] != "\n":
                i += 1
        elif c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
            if depth == 0:
                return i
        i += 1


def split_top(text):
    """Splits at commas that are outside parentheses, brackets and strings."""
    parts, depth, cur, i = [], 0, [], 0
    while i < len(text):
        c = text[i]
        if c == '"':
            j = i + 1
            while text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            cur.append(text[i : j + 1])
            i = j + 1
            continue
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
        if c == "," and depth == 0:
            parts.append("".join(cur))
            cur = []
        else:
            cur.append(c)
        i += 1
    parts.append("".join(cur))
    return parts


def literals(text):
    return "".join(value for kind, value in tokens(text) if kind == "str")


def specialize(template, params):
    def repl(match):
        return params[match.group(1)]

    return re.sub(r"\$\{([A-Za-z_0-9]+)\}", repl, template)


def function_body(source, name):
    start = source.index(f"void {name}(")
    brace = source.index("{", start)
    depth, i = 0, brace
    while True:
        if source[i] == "{":
            depth += 1
        elif source[i] == "}":
            depth -= 1
            if depth == 0:
                return source[brace : i + 1]
        i += 1


def find_cases(body):
    """Each InvarianceTest construction in source order: (name expression, [vertex1, vertex2, fragment] argument texts)."""
    cases = []
    for match in re.finditer(r"new InvarianceTest\(", body):
        open_paren = match.end() - 1
        close = match_paren(body, open_paren)
        args = split_top(body[open_paren + 1 : close])
        cases.append((args[1].strip(), [a.strip() for a in args[2:5]]))
    return cases


def evaluate_shader(arg, scope, base_args, fragment_templates):
    """`formatGLSL(<literals>, <args>)`, `formatGLSL(basicFragmentShader, <args>)` or the bare `basicFragmentShader`."""
    arg = arg.strip()
    if arg == "basicFragmentShader":
        return fragment_templates["basicFragmentShader"]
    assert arg.startswith("formatGLSL("), arg[:60]
    inner = arg[len("formatGLSL(") : match_paren(arg, len("formatGLSL(") - 1)]
    parts = split_top(inner)
    template_text, args_text = parts[0], ",".join(parts[1:])
    if template_text.strip() == "basicFragmentShader":
        template = fragment_templates["basicFragmentShader"]
    else:
        # the literal list may itself contain commas only inside strings, so the first top-level part is all of it
        template = literals(template_text)
    params = dict(base_args)
    for key, expr in re.findall(r'FormatArgument\("([A-Z_0-9]+)",\s*([A-Za-z_0-9]+)\)', args_text):
        params[key] = scope[expr]
    return specialize(template, params)


def evaluate_name(expr, scope):
    py = expr.replace("std::string(", "str(").replace(".c_str()", "")
    py = re.sub(r"\bde::toString\(", "str(", py)
    return eval(py, {"str": str}, scope)


def fragment_template(body):
    match = re.search(r"static const char \*basicFragmentShader\s*=", body)
    i = match.end()
    while body[i] != ";":
        if body[i] == '"':
            i += 1
            while body[i] != '"':
                i += 2 if body[i] == "\\" else 1
        i += 1
    return literals(body[match.end() : i])


def main():
    source = CPP.read_text()
    basic_body = function_body(source, "addBasicTests")
    ext_body = function_body(source, "addExtendedInstructionsTests")
    basic_cases = find_cases(basic_body)
    ext_cases = find_cases(ext_body)
    assert len(basic_cases) == 10 and len(ext_cases) == 5, (len(basic_cases), len(ext_cases))  # 4 subexpression + 1 precision + 5 loops; 5 extended
    basic_fragment = {"basicFragmentShader": fragment_template(basic_body)}
    ext_fragment = {"basicFragmentShader": fragment_template(ext_body)}

    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for dEQP-VK.glsl.invariance and dEQP-VK.glsl.precise.",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_invariance.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderInvarianceTests.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    table = []

    def emit(key, path, name, shaders):
        out.extend(["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["])
        for program_name, stage, source_text in (("vertex1", "vert", shaders[0]), ("vertex2", "vert", shaders[1]), ("fragment", "frag", shaders[2])):
            (SRC / f"{key}_{program_name}.{stage}").write_text(source_text)
            out.append(f'    {{ name = "{program_name}", template = "shader_render_invariance/{key}_{program_name}.{stage}", stage = "{stage}" }},')
        out.extend(["]", ""])
        table.append((path, name, key))

    for kind, decoration in (("invariance", "invariant"), ("precise", "precise")):
        vert_declaration = [decoration + " gl_Position;", decoration + " gl_Position;\nlayout(location = 1) " + decoration + " highp out vec4 v_value;"]
        assignment0 = ["gl_Position", "v_value"]
        assignment1 = ["", "gl_Position = v_value;"]
        frag_declaration = ["", "layout(location = 1) highp in vec4 v_value;"]
        var_groups = ["gl_position", "user_defined"]
        for (precision_name, high, high_inv, medium, low, low_inv, iters, partial, norm_exp, norm_lit, multiplier, sum_norm) in PRECISIONS:
            args = []
            for group_ndx in range(2):
                args.append({
                    "VERSION": "#version 450\n", "IN": "layout(location = 0) in", "OUT": "layout(location = 0) out", "IN_PREC": precision_name,
                    "VERT_DECLARATION": vert_declaration[group_ndx], "ASSIGN_0": assignment0[group_ndx], "ASSIGN_1": assignment1[group_ndx],
                    "FRAG_DECLARATION": frag_declaration[group_ndx], "HIGH_VALUE": high, "HIGH_VALUE_INV": high_inv, "MEDIUM_VALUE": medium,
                    "LOW_VALUE": low, "LOW_VALUE_INV": low_inv, "LOOP_ITERS": str(iters), "LOOP_ITERS_PARTIAL": str(partial),
                    "LOOP_NORM_FRACT_EXP": str(norm_exp), "LOOP_NORM_LITERAL": norm_lit, "LOOP_MULTIPLIER": multiplier,
                    "SUM_LOOP_NORM_LITERAL": sum_norm,
                })
            precision_index = PRECISION_NAMES.index(precision_name)

            def build(case, group_ndx, scope):
                name = evaluate_name(case[0], scope)
                shaders = [evaluate_shader(a, scope, args[group_ndx], basic_fragment) for a in case[1]]
                return name, shaders

            # subexpression cases (first four), then the precision case, then the loops; the C++ runs one loop per section over both groups
            order = []
            for case in basic_cases[0:4]:
                for group_ndx in range(2):
                    order.append((case, group_ndx, {}))
            precision_case = basic_cases[4]
            for group_ndx in range(2):
                for other in range(3):
                    unrelated = PRECISION_NAMES[other]
                    min_precision = min(other, precision_index)
                    low_min = min_precision == 0
                    scope = {
                        "unrelatedPrec": unrelated,
                        "multiplierStr": "0.8, 0.4, -0.2, 0.3" if low_min else "1.0e1, 5.0e2, 2.0e2, 1.0",
                        "normalizationStrUsed": "vec4(fract(used2).xyz, 0.0)" if low_min else "vec4(fract(used2 / 1.0e2).xyz - fract(used2 / 1.0e3).xyz, 0.0)",
                        "normalizationStrUnrelated": "vec4(fract(unrelated2).xyz, 0.0)" if low_min else "vec4(fract(unrelated2 / 1.0e2).xyz - fract(unrelated2 / 1.0e3).xyz, 0.0)",
                        "precisionName": precision_name,
                    }
                    order.append((precision_case, group_ndx, scope))
            for case in basic_cases[5:]:
                for group_ndx in range(2):
                    order.append((case, group_ndx, {}))
            for case, group_ndx, scope in order:
                name, shaders = build(case, group_ndx, scope)
                path = [kind, precision_name, var_groups[group_ndx]]
                emit(f"sr_inv_{kind}_{precision_name}_{var_groups[group_ndx]}_{name}", path, name, shaders)
        if kind == "precise":
            for (precision_name, high, high_inv, medium, low, low_inv, *_rest) in PRECISIONS:
                for other in range(3):
                    unrelated = PRECISION_NAMES[other]
                    base = {
                        "IN_PREC": precision_name, "UNRELATED_PREC": unrelated, "VERT_DECLARATION": decoration + " gl_Position;", "DECORATION": decoration,
                        "HIGH_VALUE": high, "HIGH_VALUE_INV": high_inv, "MEDIUM_VALUE": medium, "LOW_VALUE": low, "LOW_VALUE_INV": low_inv,
                    }
                    scope = {"precisionName": precision_name, "unrelatedPrec": unrelated}
                    for case in ext_cases:
                        name = evaluate_name(case[0], scope)
                        shaders = [evaluate_shader(a, scope, base, ext_fragment) for a in case[1]]
                        emit(f"sr_inv_{kind}_extended_{name}", [kind, "extended_instructions"], name, shaders)

    MANIFEST.write_text("\n".join(out))
    rows = [f'    ("{"/".join(path)}", "{name}", "{key}"),' for path, name, key in table]
    TABLE.write_text(
        "// @generated by hodow_cts/scripts/gen_shader_render_invariance.py - do not hand-edit.\n\n"
        f"/// (tree path under `glsl`, case name, manifest key of the shaders)\npub static INVARIANCE_CASES: [(&str, &str, &str); {len(table)}] = [\n" + "\n".join(rows) + "\n];\n"
    )
    print(f"{len(table)} cases")


if __name__ == "__main__":
    main()

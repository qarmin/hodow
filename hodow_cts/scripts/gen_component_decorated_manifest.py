#!/usr/bin/env python3
"""Writes shaders/manifest/pipeline_component_decorated.toml.

A port of the `ShaderGen<...>::genCode` family of vktPipelineShaderComponentDecoratedLayoutMatchingTests.cpp. Each case's full shader text is
a `derived` string; the one-line stage templates under shaders/src/pipeline/component_decorated/ only substitute it. Case names are the
test path with the group names joined by `__`, which is how the Rust side looks a case up.
"""

import json
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "shaders" / "manifest" / "pipeline_component_decorated.toml"

SCALAR, VEC2, VEC3, NONE = "scalar", "vec2", "vec3", None

TYPE_NAMES = {
    SCALAR: {16: "float16_t", 32: "float", 64: "float64_t"},
    VEC2: {16: "f16vec2", 32: "vec2", 64: "f64vec2"},
    VEC3: {16: "f16vec3", 32: "vec3", 64: "..."},
}
CONSUME = {SCALAR: 1, VEC2: 2, VEC3: 3}


def g(value):
    """C++ ostream formatting of a float: %g with six significant digits."""
    return "%g" % value


class Layout:
    def __init__(self, components, location, loccount, mode, width):
        self.components = components
        self.location = location
        self.loccount = loccount
        self.mode = mode
        self.width = width

    def type_name(self, ty, other_width=0):
        return TYPE_NAMES[ty][other_width or self.width]

    def components_present(self):
        return [(i, c) for i, c in enumerate(self.components) if c is not NONE]


def gen_exts(layout):
    if layout.width == 16:
        return "#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require\n"
    if layout.width == 64:
        return "#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require\n"
    return ""


def arr_subscript(index):
    """genArrSubscript: None is nothing (`[]`), negative is gl_MaxPatchVertices."""
    if index is None:
        return "[]"
    if index < 0:
        return "[gl_MaxPatchVertices]"
    return "[%d]" % index


def loc_subscript(layout):
    return "" if layout.loccount == 0 else "[%d]" % (layout.loccount - 1)


def gen_layout(layout, in_or_out, in_var="i", out_var="o", between=False):
    """genLayout; `between` is False for no extent (Maybe nothing), 0 for `[]`, positive for `[n]`, negative for gl_MaxPatchVertices."""
    direction = "in" if in_or_out else "out"
    var_name = in_var if in_or_out else out_var
    if between is False:
        bs_extent = ""
    elif between == 0:
        bs_extent = "[]"
    elif between > 0:
        bs_extent = "[%d]" % between
    else:
        bs_extent = "[gl_MaxPatchVertices]"
    loc_extent = "" if layout.loccount == 0 else "[%d]" % layout.loccount

    out = ""
    indent = ""
    if layout.mode != "loose":
        indent = "    "
        out += "layout(location = %d) %s %s\n" % (layout.location, direction, "In" if in_or_out else "Out")
        out += "{\n"
    for i, component in layout.components_present():
        out += "%slayout(location = %d, component = %d) %s flat %s %s%d" % (indent, layout.location, i, direction if layout.mode == "loose" else "", layout.type_name(component), var_name, i)
        if layout.mode == "loose":
            out += bs_extent
        out += loc_extent + ";\n"
    if layout.mode != "loose":
        out += "}\n"
        out += ("var_in" if in_or_out else "var_out") + bs_extent + ";\n"
    return out


def gen_vert(layout, flow):
    var = "o"
    output_var = var if layout.mode == "loose" else "var_out." + var
    value = [1.0 / 8.0]
    if "tesc" in flow:
        value[0] /= 2.0
    if "geom" in flow:
        value[0] /= 2.0

    out = "#version 450\n" + gen_exts(layout) + "layout(location = 0) in vec4 pos;\n"
    out += gen_layout(layout, False, "", var)
    out += "void main()\n{\n    gl_Position = vec4(pos.xy, 0.0, 1.0);\n"

    def write_values(width):
        text = "("
        for k in range(width):
            if k:
                text += ", "
            text += g(value[0])
            value[0] *= 2.0
        return text + ")"

    for i, component in layout.components_present():
        cast = layout.type_name(component)
        out += "    %s%d%s = " % (output_var, i, loc_subscript(layout))
        out += cast + write_values({VEC3: 3, VEC2: 2, SCALAR: 1}[component])
        out += ";\n"
    out += "}\n"
    return out


def gen_tesc(layout):
    input_var, output_var = "i", "o"
    out = "#version 450\n" + gen_exts(layout) + "#extension GL_EXT_tessellation_shader : require\nlayout(vertices = 3) out;\n"
    out += gen_layout(layout, True, input_var, output_var, -1)
    out += gen_layout(layout, False, input_var, output_var, 3)
    out += "void main()\n{\n"
    out += "    gl_TessLevelOuter[0] = 2.0;\n    gl_TessLevelOuter[1] = 4.0;\n    gl_TessLevelOuter[2] = 6.0;\n    gl_TessLevelOuter[3] = 8.0;\n"
    out += "    gl_TessLevelInner[0] = 8.0;\n    gl_TessLevelInner[1] = 8.0;\n"
    out += "    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\n"
    for i, _ in layout.components_present():
        out += "    "
        if layout.mode == "loose":
            out += "%s%d[gl_InvocationID]" % (output_var, i)
        else:
            out += "var_out[gl_InvocationID].%s%d" % (output_var, i)
        out += loc_subscript(layout) + " = "
        if layout.mode == "loose":
            out += "%s%d[gl_InvocationID]" % (input_var, i)
        else:
            out += "var_in[gl_InvocationID].%s%d" % (input_var, i)
        out += loc_subscript(layout) + ";\n"
    out += "}\n"
    return out


def gen_tese(layout):
    input_var, output_var = "i", "o"
    out = "#version 450\n" + gen_exts(layout) + "#extension GL_EXT_tessellation_shader : require\nlayout(triangles, cw) in;\n"
    out += gen_layout(layout, True, input_var, output_var, -1)
    out += gen_layout(layout, False, input_var, output_var)
    out += "void main()\n{\n"
    out += "    float u = gl_TessCoord.x;\n    float v = gl_TessCoord.y;\n    float w = gl_TessCoord.z;\n"
    out += "    vec4 pos0 = gl_in[0].gl_Position;\n    vec4 pos1 = gl_in[1].gl_Position;\n    vec4 pos2 = gl_in[2].gl_Position;\n"
    out += "    gl_Position = u * pos0 + v * pos1 + w * pos2;\n\n"
    loc = loc_subscript(layout)
    for i, _ in layout.components_present():
        out += "    "
        if layout.mode == "loose":
            out += "%s%d%s" % (output_var, i, loc)
        else:
            out += "var_out.%s%d%s" % (output_var, i, loc)
        out += " = ("
        if layout.mode == "loose":
            out += " + ".join("%s%d%s%s" % (input_var, i, arr_subscript(k), loc) for k in (0, 1, 2, 2))
        else:
            out += "  +  ".join("var_in%s.%s%d%s" % (arr_subscript(k), input_var, i, loc) for k in (0, 1, 2, 2))
        out += ") / %s(2);\n" % layout.type_name(SCALAR)
    out += "}\n"
    return out


def gen_geom(layout):
    in_var, out_var = "i", "o"
    out = "#version 450\n\n" + gen_exts(layout) + "#extension GL_EXT_geometry_shader : require\n\n"
    out += gen_layout(layout, True, in_var, "", 3)
    out += "layout(triangles) in;\n\n"
    out += gen_layout(layout, False, "", out_var)
    out += "layout(triangle_strip, max_vertices = 3) out;\n\n"
    out += "void main()\n{\n    for (uint i = 0; i < 3; ++i)\n    {\n        gl_Position = gl_in[i].gl_Position;\n"
    for i, _ in layout.components_present():
        out += "        "
        if layout.mode != "loose":
            out += "var_out."
        out += "%s%d%s" % (out_var, i, loc_subscript(layout))
        out += " = "
        if layout.mode == "loose":
            out += "%s%d[i]" % (in_var, i)
        else:
            out += "var_in[i].%s%d" % (in_var, i)
        out += loc_subscript(layout) + " * " + layout.type_name(SCALAR) + "(2.0);\n"
    out += "        EmitVertex();\n    }\n    EndPrimitive();\n}\n"
    return out


def gen_frag(layout):
    value = 0.125
    consumed = 0
    variable_name = "i"
    out = "#version 450\n" + gen_exts(layout) + "layout(location = 0) out vec4 dEQP_color;\n"
    out += gen_layout(layout, True, variable_name)
    out += "void main()\n{\n    dEQP_color = vec4("
    for idx, component in layout.components_present():
        consumed += CONSUME[component]
        if idx > 0:
            out += ", "
        out += layout.type_name(component, 32) + "("
        if layout.mode != "loose":
            out += "var_in."
        out += "%s%d%s" % (variable_name, idx, loc_subscript(layout))
        out += ")"
    value = value * (2.0**consumed)
    while consumed < 4:
        consumed += 1
        out += ", " + g(value)
        value *= 2.0
    out += ");\n}\n"
    return out


def toml_str(s):
    return json.dumps(s)


FLOWS = [("vert_frag", ("vert", "frag")), ("vert_geom_frag", ("vert", "geom", "frag")), ("vert_tesc_tese_frag", ("vert", "tesc", "tese", "frag")), ("vert_tesc_tese_geom_frag", ("vert", "tesc", "tese", "geom", "frag"))]
MODES = [("loose", "loose_var"), ("block", "in_block")]
WIDTHS = [(64, "float64"), (32, "float32"), (16, "float16")]
LOCATION_COUNTS = [(0, "single_location"), (3, "multiple_locations")]
COMPONENT_SERIES = [
    ((SCALAR, SCALAR, SCALAR, SCALAR), (16, 32)),
    ((SCALAR, SCALAR, VEC2, NONE), (16, 32)),
    ((SCALAR, VEC2, NONE, SCALAR), (16, 32)),
    ((VEC2, NONE, SCALAR, SCALAR), (16, 32)),
    ((SCALAR, VEC3, NONE, NONE), (16, 32)),
    ((VEC3, NONE, NONE, SCALAR), (16, 32)),
    ((VEC2, NONE, VEC2, NONE), (16, 32)),
    ((SCALAR, NONE, SCALAR, NONE), (64,)),
    ((VEC2, NONE, NONE, NONE), (64,)),
]


def test_name(components):
    return "_".join(c for c in components if c is not NONE)


def main():
    lines = [
        "# Shader manifest for dEQP-VK.pipeline.monolithic.interface_matching.shader_layout_component_matching.*",
        "#",
        "# Written by scripts/gen_component_decorated_manifest.py. Each case's shaders are `derived` strings (the whole source of each stage); the",
        "# one-line templates under shaders/src/pipeline/component_decorated/ only substitute them. A case is named by its test path with `__`.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/pipeline/vktPipelineShaderComponentDecoratedLayoutMatchingTests.cpp"',
        'rust_module = "pipeline/component_decorated_tests"',
    ]
    start_location = 0
    count = 0
    for flow_name, flow in FLOWS:
        for mode, mode_name in MODES:
            for width, width_name in WIDTHS:
                for loc_count, loc_name in LOCATION_COUNTS:
                    for components, widths in COMPONENT_SERIES:
                        if width not in widths:
                            continue
                        layout = Layout(components, (start_location % 4) + 1, loc_count, mode, width)
                        start_location += 1
                        name = "__".join([flow_name, mode_name, width_name, loc_name, test_name(components)])
                        sources = {"vert": gen_vert(layout, flow), "frag": gen_frag(layout)}
                        if "tesc" in flow:
                            sources["tesc"] = gen_tesc(layout)
                            sources["tese"] = gen_tese(layout)
                        if "geom" in flow:
                            sources["geom"] = gen_geom(layout)
                        lines += ["", "[[case]]", 'name = "%s"' % name, 'rust_const = "COMPONENT_DECORATED_%s"' % name.upper(), 'rust_type = "SharedProgram"', "programs = ["]
                        for stage in ("vert", "tesc", "tese", "geom", "frag"):
                            if stage in sources:
                                lines.append('    { name = "%s", template = "pipeline/component_decorated/component_decorated.%s", stage = "%s" },' % (stage, stage, stage))
                        lines.append("]")
                        lines.append("[case.derived]")
                        for stage in ("vert", "tesc", "tese", "geom", "frag"):
                            if stage in sources:
                                lines.append("%s_source = %s" % (stage, toml_str(repr(sources[stage]))))
                        count += 1
    OUT.write_text("\n".join(lines) + "\n")
    print(count, "cases")


main()

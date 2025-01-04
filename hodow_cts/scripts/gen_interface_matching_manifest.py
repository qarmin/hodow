#!/usr/bin/env python3
"""Writes shaders/manifest/pipeline_interface_matching.toml.

A port of `InterfaceMatchingTestCase::initPrograms` (vktPipelineInterfaceMatchingTests.cpp): per case it builds the declarations and
operations of each stage and writes them as `derived` strings, so the five stage templates under shaders/src/pipeline/interface_matching/
only hold what upstream's StringTemplates hold. Case names are the upstream test names, which is how the Rust side looks a case up.
"""

import json
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "shaders" / "manifest" / "pipeline_interface_matching.toml"

VEC = {
    "vec2": ("vec2", "float", 2, ["-2.0", "3.0", "", ""]),
    "vec3": ("vec3", "float", 3, ["-3.0", "2.0", "5.0", ""]),
    "vec4": ("vec4", "float", 4, ["-4.0", "-9.0", "3.0", "7.0"]),
    "ivec2": ("ivec2", "int", 2, ["-4", "8", "", ""]),
    "ivec3": ("ivec3", "int", 3, ["-5", "10", "15", ""]),
    "ivec4": ("ivec4", "int", 4, ["-16", "12", "20", "80"]),
    "uvec2": ("uvec2", "uint", 2, ["2", "8", "", ""]),
    "uvec3": ("uvec3", "uint", 3, ["3", "9", "27", ""]),
    "uvec4": ("uvec4", "uint", 4, ["4", "16", "64", "256"]),
}
VEC_ORDER = ["vec2", "vec3", "vec4", "ivec2", "ivec3", "ivec4", "uvec2", "uvec3", "uvec4"]

# name part, glsl decoration, glsl component
DECORATION = {
    "none": ("none", "", ""),
    "flat": ("flat", "flat ", ""),
    "noperspective": ("noperspective", "noperspective ", ""),
    "component0": ("component0", "", ", component = 0 "),
}

# (out array, in flat decoration, in array)
PIPELINE_DATA = {
    "vert_out_frag_in": (0, 1, 0),
    "vert_out_tesc_in_tese_frag": (0, 0, 1),
    "vert_tesc_tese_out_frag_in": (0, 1, 0),
    "vert_tesc_out_tese_in_frag": (1, 0, 1),
    "vert_out_geom_in_frag": (0, 0, 1),
    "vert_geom_out_frag_in": (0, 1, 0),
    "vert_out_tesc_in_tese_geom_frag": (0, 0, 1),
    "vert_tesc_tese_out_geom_in_frag": (0, 0, 1),
    "vert_tesc_tese_geom_out_frag_in": (0, 1, 0),
}
PIPELINES = list(PIPELINE_DATA)

DEFINITIONS = [
    "loose_variable",
    "member_of_block",
    "member_of_structure",
    "member_of_array_of_structures",
    "member_of_structure_in_block",
    "member_of_array_of_structures_in_block",
]


def gen_out_assignment(variable_name, out_vec):
    glsl_type, _, count, components = VEC[out_vec]
    return "  " + variable_name + " = " + glsl_type + "(" + ", ".join(components[:count]) + ");\n"


def gen_in_verification(variable_name, out_vec, in_vec):
    _, out_type, _, out_components = VEC[out_vec]
    _, in_type, in_count, _ = VEC[in_vec]
    names = ["x", "y", "z", "w"]
    terms = []
    for i in range(in_count):
        if in_type == "float":
            terms.append("float(abs(%s.%s - %s) < 0.001)" % (variable_name, names[i], out_components[i]))
        else:
            terms.append("float(%s.%s == %s)" % (variable_name, names[i], out_components[i]))
    return "  result = " + " *\n\t\t   ".join(terms) + ";\n"


def declarations(definition, pipeline, out_vec, in_vec, out_dec, in_dec, decoration_test):
    out_arr_flag, in_flat, in_arr_flag = PIPELINE_DATA[pipeline]
    out_decl_array = "[]" if out_arr_flag else ""
    in_decl_array = "[]" if in_arr_flag else ""
    assign_array = "[gl_InvocationID]" if out_arr_flag else ""
    verify_array = "[0]" if in_arr_flag else ""

    out_decoration = ""
    in_decoration = "flat " if in_flat else ""
    out_component = DECORATION[out_dec][2]
    in_component = DECORATION[in_dec][2]
    if decoration_test:
        out_decoration = DECORATION[out_dec][1]
        in_decoration = DECORATION[in_dec][1]

    out_type = VEC[out_vec][0]
    in_type = VEC[in_vec][0]

    if definition == "loose_variable":
        out_declaration = "layout(location = 0%s) out %s%s looseVariable%s;\n" % (out_component, out_decoration, out_type, out_decl_array)
        in_declaration = "layout(location = 0%s) in %s%s looseVariable%s;\n" % (in_component, in_decoration, in_type, in_decl_array)
        assign_name = "looseVariable" + assign_array
        verify_name = "looseVariable" + verify_array
    elif definition == "member_of_block":
        out_declaration = "layout(location = 0) out block {\n  vec2 dummy;\nlayout(location = 1%s) %s%s variableInBlock;\n} testBlock%s;\n" % (out_component, out_decoration, out_type, out_decl_array)
        in_declaration = "in block {\nlayout(location = 0) vec2 dummy;\nlayout(location = 1%s) %s%s variableInBlock;\n} testBlock%s;\n" % (in_component, in_decoration, in_type, in_decl_array)
        assign_name = "testBlock" + assign_array + ".variableInBlock"
        verify_name = "testBlock" + verify_array + ".variableInBlock"
    elif definition == "member_of_structure":
        out_declaration = "layout(location = 0) out %sstruct {\n  vec2 dummy;\n  %s variableInStruct;\n} testStruct%s;\n" % (out_decoration, out_type, out_decl_array)
        in_declaration = "layout(location = 0) in %sstruct {\n  vec2 dummy;\n  %s variableInStruct;\n} testStruct%s;\n" % (in_decoration, in_type, in_decl_array)
        assign_name = "testStruct" + assign_array + ".variableInStruct"
        verify_name = "testStruct" + verify_array + ".variableInStruct"
    elif definition == "member_of_array_of_structures":
        out_declaration = "layout(location = 0) out %sstruct {\n  float dummy;\n  %s variableInStruct;\n} testStructArray%s[3];\n" % (out_decoration, out_type, out_decl_array)
        in_declaration = "layout(location = 0) in %sstruct {\n  float dummy;\n  %s variableInStruct;\n} testStructArray%s[3];\n" % (in_decoration, in_type, in_decl_array)
        assign_name = "testStructArray" + assign_array + "[2].variableInStruct"
        verify_name = "testStructArray" + verify_array + "[2].variableInStruct"
    elif definition == "member_of_structure_in_block":
        out_declaration = "struct TestStruct {\n  vec2 dummy;\n  %s variableInStruct;\n};\nlayout(location = 0) out block {\n  vec2 dummy;\n  %sTestStruct structInBlock;\n} testBlock%s;\n" % (out_type, out_decoration, out_decl_array)
        in_declaration = "struct TestStruct {\n  vec2 dummy;\n  %s variableInStruct;\n};\nlayout(location = 0) in block {\n  vec2 dummy;\n  %sTestStruct structInBlock;\n} testBlock%s;\n" % (in_type, in_decoration, in_decl_array)
        assign_name = "testBlock" + assign_array + ".structInBlock.variableInStruct"
        verify_name = "testBlock" + verify_array + ".structInBlock.variableInStruct"
    else:
        # the input declaration upstream writes has no newline between the struct and the block
        out_declaration = "struct TestStruct {\n  vec4 dummy;\n  %s variableInStruct;\n};\nlayout(location = 0) out block {\n  %sTestStruct structArrayInBlock[3];\n} testBlock%s;\n" % (out_type, out_decoration, out_decl_array)
        in_declaration = "struct TestStruct {\n  vec4 dummy;\n  %s variableInStruct;\n};layout(location = 0) in block {\n  %sTestStruct structArrayInBlock[3];\n} testBlock%s;\n" % (in_type, in_decoration, in_decl_array)
        assign_name = "testBlock" + assign_array + ".structArrayInBlock[1].variableInStruct"
        verify_name = "testBlock" + verify_array + ".structArrayInBlock[1].variableInStruct"

    return out_declaration, in_declaration, gen_out_assignment(assign_name, out_vec), gen_in_verification(verify_name, out_vec, in_vec)


def stage_sources(pipeline, out_declaration, in_declaration, out_assignment, in_verification):
    """The declarations and operations of every stage the pipeline has, as upstream's switches pick them."""
    stages = {}

    vert_has_out = pipeline in ("vert_out_frag_in", "vert_out_tesc_in_tese_frag", "vert_out_geom_in_frag", "vert_out_tesc_in_tese_geom_frag")
    stages["vert"] = (out_declaration, out_assignment) if vert_has_out else ("", "")

    tesc = None
    if pipeline == "vert_tesc_out_tese_in_frag":
        tesc = (out_declaration, out_assignment)
    elif pipeline in ("vert_out_tesc_in_tese_frag", "vert_out_tesc_in_tese_geom_frag"):
        tesc = (in_declaration + "layout(location = 0) out float outResult[];\n", "  float result;\n" + in_verification + "  outResult[gl_InvocationID] = result;\n")
    elif pipeline in ("vert_tesc_tese_out_frag_in", "vert_tesc_tese_out_geom_in_frag", "vert_tesc_tese_geom_out_frag_in"):
        tesc = ("", "")

    tese = None
    if pipeline in ("vert_tesc_tese_out_frag_in", "vert_tesc_tese_out_geom_in_frag"):
        tese = (out_declaration, out_assignment)
    elif pipeline == "vert_tesc_out_tese_in_frag":
        tese = (in_declaration + "layout(location = 0) out float outResult;\n", "  float result;\n" + in_verification + "  outResult = result;\n")
    elif pipeline in ("vert_out_tesc_in_tese_frag", "vert_out_tesc_in_tese_geom_frag"):
        tese = ("layout(location = 0) in float inResult[];\nlayout(location = 0) out float outResult;\n", "  outResult = inResult[0];\n")
    elif pipeline == "vert_tesc_tese_geom_out_frag_in":
        tese = ("", "")

    geom = None
    if pipeline in ("vert_geom_out_frag_in", "vert_tesc_tese_geom_out_frag_in"):
        geom = (out_declaration, out_assignment)
    elif pipeline in ("vert_out_geom_in_frag", "vert_tesc_tese_out_geom_in_frag"):
        geom = (in_declaration + "layout(location = 0) out float result;\n", in_verification)
    elif pipeline == "vert_out_tesc_in_tese_geom_frag":
        geom = ("layout(location = 0) in float inResult[];\nlayout(location = 0) out float outResult;\n", "  outResult = inResult[0];\n")

    if pipeline in ("vert_out_frag_in", "vert_tesc_tese_out_frag_in", "vert_geom_out_frag_in", "vert_tesc_tese_geom_out_frag_in"):
        frag = (in_declaration, "  float result = 0.0;\n" + in_verification)
    else:
        frag = ("layout(location = 0) in flat float result;\n", "")

    stages["frag"] = frag
    if tesc is not None:
        stages["tesc"] = tesc
        stages["tese"] = tese
    if geom is not None:
        stages["geom"] = geom
    return stages


def toml_str(s):
    return json.dumps(s)


def emit_case(lines, name, pipeline, *decl_args):
    stages = stage_sources(pipeline, *declarations(decl_args[0], pipeline, *decl_args[1:]))
    const = "INTERFACE_MATCHING_" + name.upper()
    lines.append("")
    lines.append("[[case]]")
    lines.append('name = "%s"' % name)
    lines.append('rust_const = "%s"' % const)
    lines.append('rust_type = "SharedProgram"')
    lines.append("programs = [")
    order = ["vert", "tesc", "tese", "geom", "frag"]
    for stage in order:
        if stage in stages:
            lines.append('    { name = "%s", template = "pipeline/interface_matching/interface_matching.%s", stage = "%s" },' % (stage, stage, stage))
    lines.append("]")
    lines.append("[case.derived]")
    for stage in order:
        if stage in stages:
            decl, ops = stages[stage]
            lines.append("%s_declarations = %s" % (stage, toml_str(repr(decl))))
            lines.append("%s_operations = %s" % (stage, toml_str(repr(ops))))


def main():
    lines = [
        "# Shader manifest for dEQP-VK.pipeline.monolithic.interface_matching.{vector_length,decoration_mismatch,misc}",
        "#",
        "# Written by scripts/gen_interface_matching_manifest.py: each case's per-stage declarations and operations are `derived` strings, and the",
        "# five templates under shaders/src/pipeline/interface_matching/ hold what upstream's StringTemplates hold. Case names are the test names.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/pipeline/vktPipelineInterfaceMatchingTests.cpp"',
        'rust_module = "pipeline/interface_matching_tests"',
    ]

    families = [["vec4", "vec3", "vec2"], ["ivec4", "ivec3", "ivec2"], ["uvec4", "uvec3", "uvec2"]]
    for pipeline in PIPELINES:
        for definition in DEFINITIONS:
            for family in families:
                for out_vec in family:
                    for in_vec in family:
                        if VEC_ORDER.index(out_vec) < VEC_ORDER.index(in_vec):
                            continue
                        name = "out_%s_in_%s_%s_%s" % (out_vec, in_vec, definition, pipeline)
                        emit_case(lines, name, pipeline, definition, out_vec, in_vec, "none", "none", False)

    pairs = [("none", "noperspective"), ("none", "flat"), ("flat", "noperspective"), ("flat", "none"), ("noperspective", "flat"), ("noperspective", "none"), ("component0", "none"), ("none", "component0")]
    for pipeline in PIPELINES:
        for definition in DEFINITIONS:
            for out_dec, in_dec in pairs:
                if "component0" in (out_dec, in_dec) and definition not in ("loose_variable", "member_of_block"):
                    continue
                name = "out_%s_in_%s_%s_%s" % (DECORATION[out_dec][0], DECORATION[in_dec][0], definition, pipeline)
                emit_case(lines, name, pipeline, definition, "vec4", "vec4", out_dec, in_dec, True)

    lines += [
        "",
        "[[case]]",
        'name = "skip_output_variable"',
        'rust_const = "INTERFACE_MATCHING_SKIP_OUTPUT_VARIABLE"',
        'rust_type = "SharedProgram"',
        "programs = [",
        '    { name = "vert", template = "pipeline/interface_matching/skip_output_variable.vert", stage = "vert" },',
        '    { name = "frag", template = "pipeline/interface_matching/skip_output_variable.frag", stage = "frag" },',
        "]",
    ]
    OUT.write_text("\n".join(lines) + "\n")
    print(sum(1 for line in lines if line == "[[case]]"), "cases")


main()

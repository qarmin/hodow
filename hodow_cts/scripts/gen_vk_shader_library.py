#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Ahead-of-time version of the Vulkan shader library (`dEQP-VK.glsl.es310.*` and `dEQP-VK.glsl.440.*`).

Upstream's `vkt::ShaderLibraryGroup` parses `data/vulkan/glsl/*/*.test` at run time and `ShaderCase::initPrograms` builds the
GLSL of each case then (`genVertexShader`, `specializeFragmentShader`, `genCompareFunctions`, ...). Both halves happen here:
the `.test` files are parsed with the parser of gen_shader_library.py (in its Vulkan mode: `_compute` cases, `output_color`,
`440 core`), the GLSL is expanded the way vktShaderLibrary.cpp does it and written to

  * shaders/manifest/glsl_<dir>_<file>.toml - one case per test case, whose programs are the expanded sources (the template of
    each program is the one line `${source_<stage>}`; compile_shaders.py compiles them to SPIR-V), and
  * src/generated/vk_shader_library/<dir>_<file>.rs and src/generated/vk_shader_library.rs - the case tree and its value
    blocks, in the types of src/vkt/tests/glsl/shader_library.rs, each case pointing at its manifest constant.

A pure text generator: no glslang and no cargo.

Usage:
    python3 hodow_cts/scripts/gen_vk_shader_library.py [--cts-dir ../tmp/VK-GL-CTS] [--check]
"""

from __future__ import annotations

import argparse
import importlib.util
import json
import re
import struct
import sys
from pathlib import Path

SCRIPTS = Path(__file__).resolve().parent
CRATE = SCRIPTS.parent
REPO_ROOT = CRATE.parent

_spec = importlib.util.spec_from_file_location("gen_shader_library", SCRIPTS / "gen_shader_library.py")
gsl = importlib.util.module_from_spec(_spec)
sys.modules["gen_shader_library"] = gsl
_spec.loader.exec_module(gsl)

MANIFEST_DIR = CRATE / "shaders" / "manifest"
OUT_DIR = CRATE / "src" / "generated" / "vk_shader_library"
INDEX_PATH = CRATE / "src" / "generated" / "vk_shader_library.rs"

REFERENCE_UNIFORM_BINDING = 0
USER_UNIFORM_BINDING = 1
INPUT_STORAGE_BINDING = 2
RESULT_STORAGE_BINDING = 3

VERSION_DECLARATIONS = {"Es100": "#version 100", "Es300": "#version 300 es", "Es310": "#version 310 es", "Es320": "#version 320 es", "Glsl440": "#version 440"}

STAGE_NAME = {"Vertex": "vertex", "Fragment": "fragment", "Geometry": "geometry", "TessControl": "tess_control", "TessEvaluation": "tess_eval"}
STAGE_GLSLANG = {"Vertex": "vert", "Fragment": "frag", "Geometry": "geom", "TessControl": "tesc", "TessEvaluation": "tese"}
STAGE_BIT = {"Vertex": 1, "Fragment": 2, "Geometry": 4, "TessControl": 8, "TessEvaluation": 16}

# `glu::DataType` variant -> (GLSL name, scalar kind, columns, rows)
TYPE_INFO: dict = {}


def _register_types() -> None:
    for token, (variant, scalar, size) in gsl.DATA_TYPES.items():
        kind = {"float": "Float", "int": "Int", "bool": "Bool"}[scalar]
        if variant.startswith("Uint"):
            kind = "Uint"
        match = re.match(r"(Float|Int|Uint|Bool)(?:Vec(\d)|Mat(\d)(?:x(\d))?)?$", variant)
        base, vec, cols, rows = match.groups()
        glsl_prefix = {"Float": "", "Int": "i", "Uint": "u", "Bool": "b"}[base]
        if vec:
            name = f"{glsl_prefix}vec{vec}"
            columns, nrows = 1, int(vec)
        elif cols:
            nrows = int(rows) if rows else int(cols)
            columns = int(cols)
            name = f"mat{cols}" if not rows else f"mat{cols}x{rows}"
        else:
            name = {"Float": "float", "Int": "int", "Uint": "uint", "Bool": "bool"}[base]
            columns, nrows = 1, 1
        TYPE_INFO[variant] = (name, kind, columns, nrows)
        assert columns * nrows == size, variant


_register_types()


def glsl_name(variant: str) -> str:
    return TYPE_INFO[variant][0]


def kind_of(variant: str) -> str:
    return TYPE_INFO[variant][1]


def is_matrix(variant: str) -> bool:
    return TYPE_INFO[variant][2] > 1


def scalar_size(variant: str) -> int:
    return TYPE_INFO[variant][2] * TYPE_INFO[variant][3]


def transport_type(variant: str) -> str:
    """`getTransportType` - a bool travels as the unsigned integer of the same size."""
    if kind_of(variant) == "Bool":
        size = scalar_size(variant)
        return "uint" if size == 1 else f"uvec{size}"
    return glsl_name(variant)


def num_transport_locations(variant: str) -> int:
    return TYPE_INFO[variant][2] if is_matrix(variant) else 1


def declare(value) -> str:
    return f"{glsl_name(value.data_type)} {value.name}"


# ---------------------------------------------------------------------------
# tcu::StringTemplate::specialize
# ---------------------------------------------------------------------------


def specialize(template: str, params: dict) -> str:
    out = []
    cur = 0
    while True:
        start = template.find("${", cur)
        if start < 0:
            out.append(template[cur:])
            return "".join(out)
        out.append(template[cur:start])
        end = template.find("}", start)
        if end < 0:
            raise SystemExit("No '}' found in template parameter")
        param = template[start + 2 : end]
        single_line = optional = False
        default = None
        name = param
        if ":" in param:
            name, flags = param.split(":", 1)
            if flags == "single-line":
                single_line = True
            elif flags == "opt":
                optional = True
            elif flags.startswith("default="):
                default = flags[len("default=") :]
            else:
                raise SystemExit(f"Unrecognized flag {param}")
        if name in params:
            value = params[name]
            out.append(value.replace("\n", " ") if single_line else value)
        elif default is not None:
            out.append(default)
        elif not optional:
            raise SystemExit(f"Value for parameter '{name}' not found in map")
        cur = end + 1


def inject_extension_requirements(base: str, extensions: list, stage: str) -> str:
    statements = "".join(f"#extension {alternatives[0]} : require\n" for alternatives, stages in extensions if stages & STAGE_BIT[stage])
    if not statements:
        return base

    result = []
    first_non_preprocessor = True
    for line in base.split("\n")[: -1 if base.endswith("\n") else None]:
        stripped = line.lstrip("\t ")
        is_directive = bool(stripped) and stripped[0] == "#"
        if not is_directive and first_non_preprocessor:
            first_non_preprocessor = False
            result.append(statements)
        result.append(line + "\n")
    return "".join(result)


# ---------------------------------------------------------------------------
# glu::sl::genCompareFunctions
# ---------------------------------------------------------------------------

COMPARE_FUNCTIONS = [
    ("Bool", "bool isOk (bool a, bool b)   { return (a == b); }\n"),
    ("BoolVec2", "bool isOk (bvec2 a, bvec2 b) { return (a == b); }\n"),
    ("BoolVec3", "bool isOk (bvec3 a, bvec3 b) { return (a == b); }\n"),
    ("BoolVec4", "bool isOk (bvec4 a, bvec4 b) { return (a == b); }\n"),
    ("Int", "bool isOk (int a, int b)     { return (a == b); }\n"),
    ("IntVec2", "bool isOk (ivec2 a, ivec2 b) { return (a == b); }\n"),
    ("IntVec3", "bool isOk (ivec3 a, ivec3 b) { return (a == b); }\n"),
    ("IntVec4", "bool isOk (ivec4 a, ivec4 b) { return (a == b); }\n"),
    ("Uint", "bool isOk (uint a, uint b)   { return (a == b); }\n"),
    ("UintVec2", "bool isOk (uvec2 a, uvec2 b) { return (a == b); }\n"),
    ("UintVec3", "bool isOk (uvec3 a, uvec3 b) { return (a == b); }\n"),
    ("UintVec4", "bool isOk (uvec4 a, uvec4 b) { return (a == b); }\n"),
    ("Float", "bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }\n"),
    ("FloatVec2", "bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n"),
    ("FloatVec3", "bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n"),
    ("FloatVec4", "bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n"),
    ("FloatMat2", "bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }\n"),
    ("FloatMat2x3", "bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }\n"),
    ("FloatMat2x4", "bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }\n"),
    ("FloatMat3x2", "bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }\n"),
    ("FloatMat3", "bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }\n"),
    ("FloatMat3x4", "bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }\n"),
    ("FloatMat4x2", "bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }\n"),
    ("FloatMat4x3", "bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }\n"),
    ("FloatMat4", "bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }\n"),
]


def gen_compare_functions(values: dict) -> str:
    found = {value.data_type for value in values["outputs"]}
    return "".join(text for variant, text in COMPARE_FUNCTIONS if variant in found)


# ---------------------------------------------------------------------------
# vktShaderLibrary.cpp - the GLSL of a case
# ---------------------------------------------------------------------------


def gen_uniform_block(block_name: str, instance_name: str, set_ndx: int, binding: int, uniforms: list) -> str:
    out = "layout("
    if set_ndx != 0:
        out += f"set = {set_ndx}, "
    out += f"binding = {binding}, std140) uniform {block_name}\n{{\n"
    for value in uniforms:
        out += f"\t{declare(value)};\n"
    out += "}"
    if instance_name:
        out += " " + instance_name
    return out + ";\n"


def declare_reference_block(values: dict) -> str:
    if values["outputs"]:
        return gen_uniform_block("Reference", "ref", 0, REFERENCE_UNIFORM_BINDING, values["outputs"])
    return ""


def declare_uniforms(values: dict) -> str:
    if values["uniforms"]:
        return gen_uniform_block("Uniforms", "", 0, USER_UNIFORM_BINDING, values["uniforms"])
    return ""


def gen_compare_op(dst_vec4_var: str, values: dict) -> str:
    out = ""
    first = True
    for value in values["outputs"]:
        out += "bool RES = " if first else "RES = RES && "
        first = False
        if kind_of(value.data_type) == "Float":
            out += f"isOk({value.name}, ref.{value.name}, 0.05);\n"
        else:
            out += f"isOk({value.name}, ref.{value.name});\n"
    if first:
        out += f"{dst_vec4_var} = vec4(1.0);\n"
    else:
        out += f"{dst_vec4_var} = vec4(RES, RES, RES, 1.0);\n"
    return out


def gen_vertex_shader(spec) -> str:
    res = VERSION_DECLARATIONS[spec.target_version] + "\n"
    res += "precision highp float;\nprecision highp int;\n\n"
    res += "layout(location = 0) in highp vec4 dEQP_Position;\n"
    cur_input_loc = 1
    cur_output_loc = 0
    for value in spec.values["inputs"]:
        transport = transport_type(value.data_type)
        num_locs = num_transport_locations(value.data_type)
        prefix = "v_" if transport != glsl_name(value.data_type) else ""
        res += f"layout(location = {cur_input_loc}) in {transport} a_{value.name};\n"
        res += f"layout(location = {cur_output_loc}) flat out {transport} {prefix}{value.name};\n"
        cur_input_loc += num_locs
        cur_output_loc += num_locs
    res += "\n"
    res += "void main()\n{\n"
    res += "    gl_Position = dEQP_Position;\n"
    for value in spec.values["inputs"]:
        prefix = "v_" if transport_type(value.data_type) != glsl_name(value.data_type) else ""
        res += f"    {prefix}{value.name} = a_{value.name};\n"
    res += "}\n"
    return res


def gen_fragment_shader(spec) -> str:
    shader = VERSION_DECLARATIONS[spec.target_version] + "\n"
    setup = ""
    cur_in_loc = 0
    shader += "precision highp float;\nprecision highp int;\n\n"
    shader += "layout(location = 0) out mediump vec4 dEQP_FragColor;\n\n"
    shader += gen_compare_functions(spec.values)
    shader += "\n"
    for value in spec.values["outputs"]:
        value_type = glsl_name(value.data_type)
        transport = transport_type(value.data_type)
        num_locs = num_transport_locations(value.data_type)
        shader += f"layout(location = {cur_in_loc}) flat in {transport} {'v_' if value_type != transport else ''}{value.name};\n"
        if value_type != transport:
            setup += f"    {value_type} {value.name} = {value_type}(v_{value.name});\n"
        cur_in_loc += num_locs
    shader += declare_reference_block(spec.values)
    shader += "\n"
    shader += "void main()\n{\n"
    shader += setup
    shader += "    " + gen_compare_op("dEQP_FragColor", spec.values)
    shader += "}\n"
    return shader


def specialize_vertex_shader(spec, src: str) -> str:
    assert spec.case_type == "VertexOnly"
    decl = setup = ""
    output = "gl_Position = dEQP_Position;\n"
    cur_input_loc = 1
    cur_output_loc = 0
    decl += "layout(location = 0) in highp vec4 dEQP_Position;\n"
    for value in spec.values["inputs"]:
        value_type = glsl_name(value.data_type)
        transport = transport_type(value.data_type)
        num_locs = num_transport_locations(value.data_type)
        decl += f"layout(location = {cur_input_loc}) in "
        cur_input_loc += num_locs
        if value_type == transport:
            decl += f"{transport} {value.name};\n"
        else:
            decl += f"{transport} a_{value.name};\n"
            setup += f"{value_type} {value.name} = {value_type}(a_{value.name});\n"
    decl += declare_uniforms(spec.values)
    for value in spec.values["outputs"]:
        value_type = glsl_name(value.data_type)
        transport = transport_type(value.data_type)
        num_locs = num_transport_locations(value.data_type)
        decl += f"layout(location = {cur_output_loc}) flat out "
        cur_output_loc += num_locs
        if value_type == transport:
            decl += f"{transport} {value.name};\n"
        else:
            decl += f"{transport} v_{value.name};\n"
            decl += f"{value_type} {value.name};\n"
            output += f"v_{value.name} = {transport}({value.name});\n"
    params = {"DECLARATIONS": decl, "SETUP": setup, "OUTPUT": output, "POSITION_FRAG_COLOR": "gl_Position"}
    return inject_extension_requirements(specialize(src, params), spec.programs[0].required_extensions, "Vertex")


def specialize_fragment_shader(spec, src: str) -> str:
    assert spec.case_type == "FragmentOnly"
    decl = setup = ""
    cur_input_loc = 0
    decl += gen_compare_functions(spec.values)
    output = gen_compare_op("dEQP_FragColor", spec.values)
    decl += "layout(location = 0) out mediump vec4 dEQP_FragColor;\n"
    for value in spec.values["inputs"]:
        value_type = glsl_name(value.data_type)
        transport = transport_type(value.data_type)
        num_locs = num_transport_locations(value.data_type)
        decl += f"layout(location = {cur_input_loc}) flat in "
        cur_input_loc += num_locs
        if value_type == transport:
            decl += f"{transport} {value.name};\n"
        else:
            decl += f"{transport} v_{value.name};\n"
            setup += f"{value_type} {value.name} = {value_type}(v_{value.name});\n"
    decl += declare_uniforms(spec.values)
    decl += declare_reference_block(spec.values)
    for value in spec.values["outputs"]:
        decl += f"{glsl_name(value.data_type)} {value.name};\n"
    params = {"DECLARATIONS": decl, "SETUP": setup, "OUTPUT": output, "POSITION_FRAG_COLOR": "dEQP_FragColor"}
    return inject_extension_requirements(specialize(src, params), spec.programs[0].required_extensions, "Fragment")


def specialize_compute_shader(spec, src: str) -> str:
    assert spec.case_type == "ComputeOnly"
    decl = "layout(local_size_x = 1) in;\n\n"
    setup = ""
    if spec.values["inputs"]:
        decl += f"layout(set = 0, binding = {INPUT_STORAGE_BINDING}, std430) readonly buffer InputBlock\n{{\n"
        for value in spec.values["inputs"]:
            decl += f"\t{glsl_name(value.data_type)} {value.name};\n"
        decl += "};\n\n"
    decl += declare_reference_block(spec.values)
    decl += declare_uniforms(spec.values)
    decl += f"layout(set = 0, binding = {RESULT_STORAGE_BINDING}, std430) writeonly buffer ResultBlock\n{{\n\tuint result;\n}} res;\n\n"
    decl += gen_compare_functions(spec.values)
    for value in spec.values["outputs"]:
        decl += f"{glsl_name(value.data_type)} {value.name};\n"
    decl += "highp vec4 dEQP_Position;\n"

    output = ""
    first = True
    for value in spec.values["outputs"]:
        output += "bool RES = " if first else "RES = RES && "
        first = False
        if kind_of(value.data_type) == "Float":
            output += f"isOk({value.name}, ref.{value.name}, 0.05);\n"
        else:
            output += f"isOk({value.name}, ref.{value.name});\n"
    output += "res.result = 1u;\n" if first else "res.result = RES ? 1u : 0u;\n"

    params = {"DECLARATIONS": decl, "SETUP": setup, "OUTPUT": output, "POSITION_FRAG_COLOR": "dEQP_Position"}
    return inject_extension_requirements(specialize(src, params), spec.programs[0].required_extensions, "Vertex")


def vertex_specialization(spec) -> dict:
    decl = "layout(location = 0) in highp vec4 dEQP_Position;\n"
    setup = ""
    cur_input_loc = 1
    for value in spec.values["inputs"]:
        value_type = glsl_name(value.data_type)
        transport = transport_type(value.data_type)
        num_locs = num_transport_locations(value.data_type)
        decl += f"layout(location = {cur_input_loc}) in "
        cur_input_loc += num_locs
        if value_type == transport:
            decl += f"{transport} {value.name};\n"
        else:
            decl += f"{transport} a_{value.name};\n"
            setup += f"{value_type} {value.name} = {value_type}(a_{value.name});\n"
    decl += declare_uniforms(spec.values)
    return {"VERTEX_DECLARATIONS": decl, "VERTEX_SETUP": setup, "VERTEX_OUTPUT": "gl_Position = dEQP_Position;\n"}


def fragment_specialization(spec) -> dict:
    decl = gen_compare_functions(spec.values)
    output = gen_compare_op("dEQP_FragColor", spec.values)
    decl += "layout(location = 0) out mediump vec4 dEQP_FragColor;\n"
    for value in spec.values["outputs"]:
        decl += f"{glsl_name(value.data_type)} {value.name};\n"
    decl += declare_reference_block(spec.values)
    decl += declare_uniforms(spec.values)
    return {"FRAGMENT_DECLARATIONS": decl, "FRAGMENT_OUTPUT": output, "FRAG_COLOR": "dEQP_FragColor"}


def geometry_specialization(spec) -> dict:
    decl = "layout (triangles) in;\nlayout (triangle_strip, max_vertices=3) out;\n\n"
    decl += declare_uniforms(spec.values)
    return {"GEOMETRY_DECLARATIONS": decl}


MAX_PATCH_VERTICES = 4


def tess_control_specialization(spec) -> dict:
    decl = "layout (vertices=3) out;\n\n"
    decl += declare_uniforms(spec.values)
    output = (
        "gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
        "gl_TessLevelInner[0] = 2.0;\n"
        "gl_TessLevelInner[1] = 2.0;\n"
        "gl_TessLevelOuter[0] = 2.0;\n"
        "gl_TessLevelOuter[1] = 2.0;\n"
        "gl_TessLevelOuter[2] = 2.0;\n"
        "gl_TessLevelOuter[3] = 2.0;"
    )
    return {"TESSELLATION_CONTROL_DECLARATIONS": decl, "TESSELLATION_CONTROL_OUTPUT": output, "GL_MAX_PATCH_VERTICES": str(MAX_PATCH_VERTICES)}


def tess_eval_specialization(spec) -> dict:
    decl = "layout (triangles) in;\n\n"
    decl += declare_uniforms(spec.values)
    output = "gl_Position = gl_TessCoord[0] * gl_in[0].gl_Position + gl_TessCoord[1] * gl_in[1].gl_Position + gl_TessCoord[2] * gl_in[2].gl_Position;\n"
    return {"TESSELLATION_EVALUATION_DECLARATIONS": decl, "TESSELLATION_EVALUATION_OUTPUT": output, "GL_MAX_PATCH_VERTICES": str(MAX_PATCH_VERTICES)}


SPECIALIZERS = {
    "Vertex": vertex_specialization,
    "Fragment": fragment_specialization,
    "Geometry": geometry_specialization,
    "TessControl": tess_control_specialization,
    "TessEvaluation": tess_eval_specialization,
}


def case_programs(spec) -> list:
    """The `(program name, glslang stage, GLSL)` list `ShaderCase::initPrograms` adds, in its order."""
    if spec.expect_result != "Pass":
        raise SystemExit("Only EXPECT_PASS is supported")

    if spec.case_type == "ComputeOnly":
        assert len(spec.programs) == 1 and len(spec.programs[0].sources) == 1
        return [("compute_0", "comp", specialize_compute_shader(spec, spec.programs[0].sources[0][1]))]
    if spec.case_type == "VertexOnly":
        source = spec.programs[0].sources[0][1]
        return [("vertex", "vert", specialize_vertex_shader(spec, source)), ("fragment", "frag", gen_fragment_shader(spec))]
    if spec.case_type == "FragmentOnly":
        source = spec.programs[0].sources[0][1]
        return [("vertex", "vert", gen_vertex_shader(spec)), ("fragment", "frag", specialize_fragment_shader(spec, source))]

    assert spec.case_type == "Complete" and len(spec.programs) == 1, "framework lacks SPIR-V linking: a single program only"
    program = spec.programs[0]
    result = []
    seen = set()
    for stage in ("Vertex", "Fragment", "Geometry", "TessControl", "TessEvaluation"):
        for source_stage, source in program.sources:
            if source_stage != stage:
                continue
            assert stage not in seen, "several sources of one stage"
            seen.add(stage)
            base = specialize(source, SPECIALIZERS[stage](spec))
            result.append((STAGE_NAME[stage], STAGE_GLSLANG[stage], inject_extension_requirements(base, program.required_extensions, stage)))
    return result


def case_stages(spec) -> int:
    if spec.case_type == "Complete":
        mask = 0
        for stage, _ in spec.programs[0].sources:
            mask |= STAGE_BIT[stage]
        return mask
    return STAGE_BIT["Vertex"] | STAGE_BIT["Fragment"]


# ---------------------------------------------------------------------------
# Emission
# ---------------------------------------------------------------------------


def words_of(value) -> list:
    kind = kind_of(value.data_type)
    words = []
    for element in value.elements:
        if kind == "Float":
            words.append(struct.unpack("<I", struct.pack("<f", element))[0])
        elif kind == "Bool":
            words.append(1 if element else 0)
        else:
            words.append(element & 0xFFFFFFFF)
    return words


def ty_literal(variant: str) -> str:
    _, kind, columns, rows = TYPE_INFO[variant]
    return f"Ty::new(Kind::{kind}, {columns}, {rows})"


def value_literal(value) -> str:
    words = ", ".join(f"0x{word:08x}" for word in words_of(value))
    return f'Value {{ ty: {ty_literal(value.data_type)}, name: "{value.name}", words: &[{words}] }}'


def rust_str(text: str) -> str:
    return json.dumps(text)


def flatten(nodes: list, path: tuple = ()):
    for node in nodes:
        if isinstance(node, gsl.Group):
            yield from flatten(node.children, path + (node.name,))
        else:
            yield path, node


def const_name(prefix: str, path: tuple, name: str, used: set) -> str:
    text = "_".join(re.sub(r"[^A-Za-z0-9]", "_", part) for part in (*path, name)).upper()
    const = f"{prefix}_{text}"
    unique = const
    counter = 2
    while unique in used:
        unique = f"{const}_{counter}"
        counter += 1
    used.add(unique)
    return unique


def manifest_case(const: str, name: str, programs: list) -> str:
    entries = ", ".join(f'{{ name = "{pname}", template = "glsl/source.{stage}", stage = "{stage}" }}' for pname, stage, _ in programs)
    derived = ", ".join(f"source_{stage} = {json.dumps(repr(source))}" for _, stage, source in programs)
    return f'\n[[case]]\nname = {json.dumps(name)}\nrust_const = "{const}"\nrust_type = "SharedProgram"\nprograms = [ {entries} ]\nderived = {{ {derived} }}\n'


def generate(cts_dir: Path):
    root = cts_dir / "external" / "vulkancts" / "data" / "vulkan" / "glsl"
    files = []
    for directory, group in (("es310", ()), ("440", ("440",))):
        for path in sorted((root / directory).glob("*.test")):
            files.append((f"glsl_{directory}_{path.stem}", directory, group, path))

    outputs: dict = {}
    index = []
    total = 0

    for module, directory, group, path in files:
        nodes = gsl.Parser(path, vulkan=True).parse()
        used: set = set()
        manifest = [
            f"# Shader manifest for dEQP-VK.glsl.{'440.' if directory == '440' else ''}{path.stem}.*\n#\n"
            "# @generated by hodow_cts/scripts/gen_vk_shader_library.py - do not hand-edit. One case per case of the `.test` file, its programs the\n"
            "# GLSL vktShaderLibrary.cpp builds for it (each program's template is the one line `${source_<stage>}`, of which the case's `derived` has the text).\n\n"
            f'upstream_source = "external/vulkancts/modules/vulkan/vktShaderLibrary.cpp"\nrust_module = "glsl/shader_library"\n'
        ]
        rust_cases = []
        count = 0
        for case_path, case in flatten(nodes):
            spec = case.spec
            const = const_name("GLSL", (directory, path.stem, *case_path), case.name, used)
            programs = case_programs(spec)
            manifest.append(manifest_case(const, ".".join((*case_path, case.name)), programs))

            inputs = ", ".join(value_literal(v) for v in spec.values["inputs"])
            outs = ", ".join(value_literal(v) for v in spec.values["outputs"])
            uniforms = ", ".join(value_literal(v) for v in spec.values["uniforms"])
            output_color = f"Some({ty_literal(gsl.DATA_TYPES[spec.output_format][0])})" if spec.output_type == "Color" else "None"
            path_literal = ", ".join(rust_str(part) for part in case_path)
            rust_cases.append(
                f"    CaseData {{ path: &[{path_literal}], name: {rust_str(case.name)}, kind: CaseKind::{spec.case_type}, output_color: {output_color}, "
                f"stages: {case_stages(spec)}, inputs: &[{inputs}], outputs: &[{outs}], uniforms: &[{uniforms}], "
                f"programs: &crate::generated::shaders::{module}::{const} }},"
            )
            count += 1

        total += count
        outputs[MANIFEST_DIR / f"{module}.toml"] = "".join(manifest)
        outputs[OUT_DIR / f"{module}.rs"] = (
            "// @generated by hodow_cts/scripts/gen_vk_shader_library.py - do not hand-edit.\n\n"
            "use crate::vkt::tests::glsl::shader_library::{CaseData, CaseKind, Kind, Ty, Value};\n\n"
            f"pub static CASES: [CaseData; {count}] = [\n" + "\n".join(rust_cases) + "\n];\n"
        )
        index.append((module, group, path.stem, count, path.relative_to(cts_dir).as_posix()))

    lines = [
        "// @generated by hodow_cts/scripts/gen_vk_shader_library.py - do not hand-edit.",
        "//",
        "// One module per `data/vulkan/glsl/*/*.test` file; `FILES` lists them with the group each one is registered under.",
        "",
        "use crate::vkt::tests::glsl::shader_library::FileData;",
        "",
    ]
    for module, _, _, count, relative in index:
        lines += [f"/// `{relative}` - {count} cases.", f'#[path = "vk_shader_library/{module}.rs"]', f"pub mod {module};", ""]
    lines.append(f"pub static FILES: [FileData; {len(index)}] = [")
    for module, group, stem, _, _ in index:
        group_literal = ", ".join(rust_str(part) for part in group)
        lines.append(f'    FileData {{ group: &[{group_literal}], name: "{stem}", cases: &{module}::CASES }},')
    lines += ["];", ""]
    outputs[INDEX_PATH] = "\n".join(lines)
    return outputs, total, len(files)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cts-dir", default=str(REPO_ROOT / "tmp" / "VK-GL-CTS"))
    ap.add_argument("--check", action="store_true", help="fail if the committed output is stale")
    args = ap.parse_args()

    outputs, total, nfiles = generate(Path(args.cts_dir))

    if args.check:
        stale = [p for p, text in outputs.items() if not p.exists() or p.read_text() != text]
        for path in stale:
            print(f"stale: {path}", file=sys.stderr)
        if stale:
            return 1
        print(f"vk shader library up to date ({total} cases in {nfiles} files)")
        return 0

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for path in OUT_DIR.glob("*.rs"):
        if path not in outputs:
            path.unlink()
    for path, text in outputs.items():
        path.write_text(text)
    print(f"wrote {nfiles} files, {total} cases")
    return 0


if __name__ == "__main__":
    sys.exit(main())

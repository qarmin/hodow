#!/usr/bin/env python3
"""Writes shaders/manifest/shader_expect_assume.toml: the compute cases of dEQP-VK.glsl.shader_expect_assume (47) of vktShaderExpectAssumeTests.cpp.

Each is one GLSL compute shader that calls `expectKHR`/`assumeTrueKHR` (SPV_KHR_expect_assume through GL_EXT_spirv_intrinsics) on a constant, a specialization
constant, a push constant or a value read from a storage buffer, and writes (invocation, 1) when the call returned what it was given. The text is what
`addComputeTestShader` writes with `initPrograms`' parameters filled in; what the host needs rides along as `spec` for
src/vkt/tests/glsl/shader_expect_assume_tests.rs. The vertex and fragment cases need a dynamic rendering pipeline of their own and are not here.

    python3 hodow_cts/scripts/gen_shader_expect_assume_manifest.py

A pure text generator: no glslang and no cargo.
"""

import json
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "shader_expect_assume.toml"
ELEMENTS = 32

# (op, class, data type, name) in the order of upstream's testParams
PARAMS = [
    ("expect", "constant", "bool", "constant"),
    ("expect", "specialization", "bool", "specializationconstant"),
    ("expect", "push", "bool", "pushconstant"),
    ("expect", "storage", "bool", "storagebuffer_bool"),
    ("expect", "storage", "int8", "storagebuffer_int8"),
    ("expect", "storage", "int16", "storagebuffer_int16"),
    ("expect", "storage", "int32", "storagebuffer_int32"),
    ("expect", "storage", "int64", "storagebuffer_int64"),
    ("assume", "constant", "bool", "constant"),
    ("assume", "specialization", "bool", "specializationconstant"),
    ("assume", "push", "bool", "pushconstant"),
    ("assume", "storage", "bool", "storagebuffer"),
]
EXTENSIONS = {
    "int8": "#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable",
    "int16": "#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable",
    "int32": "#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable",
    "int64": "#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable",
}
SCALAR = {"bool": "bool", "int8": "int8_t", "int16": "int16_t", "int32": "int32_t", "int64": "int64_t"}
VECTOR = {"bool": "bvec", "int8": "i8vec", "int16": "i16vec", "int32": "i32vec", "int64": "i64vec"}


def shader(op, data_class, data_type, channels, wrong):
    datatype = SCALAR[data_type] if channels == 1 else f"{VECTOR[data_type]}{channels}"
    expected = wrong_value = ""
    index = "gl_GlobalInvocationID.x"
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
            expected, wrong_value = "true", "false"
        elif data_type == "bool":
            expected, wrong_value = f"{datatype}(true)", f"{datatype}(false)"
        else:
            expected = f"{datatype}({index}" + "".join(f", {index} + {channel}" for channel in range(1, channels)) + ")"
            wrong_value = f"{datatype}({index}*2 + 3" + "".join(f", {index}*2 + 3 + {channel}" for channel in range(1, channels)) + ")"
    operator = "expectKHR" if op == "expect" else "assumeTrueKHR"
    operands = f"({varname})" if not expected else f"({varname}, {expected})"

    lines = [
        "#version 460 core",
        "#extension GL_EXT_spirv_intrinsics: enable",
        EXTENSIONS.get(data_type, ""),
        'spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)',
        "void assumeTrueKHR(bool);",
        'spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)',
        f"{datatype} expectKHR({datatype}, {datatype});",
        "precision highp float;",
        "precision highp int;",
        "layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };",
    ]
    if data_class == "constant":
        lines.append("bool kThisIsTrue = true;")
    elif data_class == "specialization":
        lines.append("layout (constant_id = 0) const bool scThisIsTrue = false;")
    elif data_class == "push":
        lines.append("layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };")
    else:
        lines.append(f"layout(set = 0, binding = 1, std430) buffer Block1 {{ {datatype} inputBuffer[]; }};")
    lines += [f"layout(local_size_x = {ELEMENTS}, local_size_y = 1, local_size_z = 1) in;", "void main()", "{"]
    if op == "assume":
        lines.append(f"    {operator} {operands};")
    else:
        lines += [
            f"    {datatype} control = {wrong_value};",
            f"    if ( {operator}({varname}, {expected}) == {expected} ) {{",
            f"        control = {expected};",
            "    } else {",
            "        // set wrong value",
            f"        control = {wrong_value};",
            "    }",
        ]
    lines.append(f"    outputBuffer[{index}].x = {index};")
    if not expected:
        lines.append(f"    outputBuffer[{index}].y = uint({varname});")
    elif op == "assume":
        lines.append(f"    outputBuffer[{index}].y = uint({varname} == {expected});")
    else:
        lines.append(f"    outputBuffer[{index}].y = uint(control == {wrong_value if wrong else expected});")
    lines.append("}")
    return "\n".join(lines) + "\n"


def cases():
    for wrong in (False, True):
        for channels in range(1, 5):
            for op, data_class, data_type, name in PARAMS:
                if channels > 1 or wrong:
                    if op != "expect" or data_class != "storage":
                        continue
                    if channels > 1:
                        name += f"_vec{channels}"
                    if wrong:
                        name += "_wrong_expected"
                yield op, data_class, data_type, channels, wrong, name


def main():
    out = [
        "# Shader manifest for dEQP-VK.glsl.shader_expect_assume.compute.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_shader_expect_assume_manifest.py - do not hand-edit.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/shaderexecutor/vktShaderExpectAssumeTests.cpp"\nrust_module = "glsl/shader_expect_assume_tests"\n'
    ]
    count = 0
    for op, data_class, data_type, channels, wrong, name in cases():
        case = f"{op}/{name}"
        const = "SEA_" + "".join(c if c.isalnum() else "_" for c in case).upper()
        spec = f"class={data_class};type={data_type};chan={channels};wrong={int(wrong)}"
        out.append(
            f'\n[[case]]\nname = "compute/{case}"\nrust_const = "{const}"\nrust_type = "ExpectAssumeCase"\n'
            f'programs = [ {{ name = "compute", template = "glsl/source.comp", stage = "comp" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
            f"derived = {{ source_comp = {json.dumps(repr(shader(op, data_class, data_type, channels, wrong)))} }}\n"
        )
        count += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Writes the shaders of dEQP-VK.glsl.builtin.precision_fconvert.* (vktShaderFConvertTests.cpp, `FConvertTestCase::initPrograms`) and their manifest.

One shader per case. The case tree is the one `createPrecisionFconvertGroup` builds. The number of values of each input type (the size of the SSBO arrays) is
what `getInputValues` yields: its sample, random and exhaustive counts padded to a multiple of 3 * 16; glsl/fconvert_tests.rs asserts the same table.
The bodies that unpack the sub-byte types are read from the vendored C++, not retyped.

A pure text generator: no glslang and no cargo.   Run from hodow_cts/:  python3 scripts/gen_fconvert_manifest.py   (then `just cts-shaders`)
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "fconvert"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_fconvert.toml"
CPP = ROOT / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "shaderexecutor" / "vktShaderFConvertTests.cpp"

NAMES = {
    "f16": "float16_t",
    "f32": "float",
    "f64": "double",
    "bf16": "bfloat16_t",
    "fe5m2": "floate5m2_t",
    "fe4m3": "floate4m3_t",
    "fe2m1": "floate2m1_t",
    "fe3m2": "floate3m2_t",
    "fe2m3": "floate2m3_t",
    "fue8m0": "floatue8m0_t",
    "fmxint8": "floatmxint8_t",
    "i32": "int",
    "u32": "uint",
}
VEC_PREFIX = {
    "f16": "f16vec",
    "f32": "vec",
    "f64": "dvec",
    "bf16": "bf16vec",
    "fe5m2": "fe5m2vec",
    "fe4m3": "fe4m3vec",
    "fe2m1": "fe2m1vec",
    "fe3m2": "fe3m2vec",
    "fe2m3": "fe2m3vec",
    "fue8m0": "fue8m0vec",
    "fmxint8": "fmxint8vec",
    "i32": "ivec",
    "u32": "uvec",
}
# getInputValues: interesting + 240 random normals + other normals + exhaustive, padded to a multiple of 48.
INTERESTING = {"fue8m0": 3}
EXHAUSTIVE = {"f16": 65536, "bf16": 65536, "fe5m2": 256, "fe4m3": 256, "fe2m1": 256, "fe3m2": 256, "fe2m3": 256, "fue8m0": 256, "fmxint8": 256}
OTHER = {"f16": 480, "bf16": 480, "f32": 960, "f64": 1200}


def num_values(t):
    n = INTERESTING.get(t, 6) + 240 + OTHER.get(t, 0) + EXHAUSTIVE.get(t, 0)
    return n + (-n) % 48


def glsl_type(t, k):
    if k == 1:
        return NAMES[t]
    if k <= 4:
        return f"{VEC_PREFIX[t]}{k}"
    return f"vector<{NAMES[t]}, {k}>"


def u8_type(k):
    return glsl_type("u8", k) if False else ("uint8_t" if k == 1 else f"u8vec{k}" if k <= 4 else f"vector<uint8_t, {k}>")


def unpack_bodies():
    """(type, vector length) -> (declaration line, bitcastExtract line, plain line) read from the `switch (m_params.from)` of initPrograms."""
    lines = CPP.read_text().splitlines()
    start = next(i for i, l in enumerate(lines) if "switch (m_params.from)" in l and i > 1100)
    end = next(i for i, l in enumerate(lines) if i > start and l.startswith("    default:") and "s(" in lines[i + 1])
    table = {}
    ty = vlen = None
    calls = []
    current = None
    literal = re.compile(r'"((?:[^"\\]|\\.)*)"')
    for line in lines[start:end]:
        st = line.strip()
        m = re.match(r"case FLOAT_TYPE_(E2M1|E3M2|E2M3):", st)
        if m:
            ty = "f" + m.group(1).lower()
            continue
        m = re.match(r"case (\d+):$", st)
        if m and ty:
            vlen = int(m.group(1))
            calls = []
            continue
        if st.startswith("s(") or current is not None:
            current = (current or "") + " " + st
            if st.endswith(");"):
                text = "".join(literal.findall(current))
                calls.append(text)
                current = None
                if len(calls) == 3:
                    table[(ty, vlen)] = tuple(calls)
                    calls = []
    return table


def shader(frm, to, k, sat, bitcast, bodies):
    in_t = glsl_type(frm, k)
    out_t = glsl_type(to, k)
    n = num_values(frm)
    arr = n // k
    f16_like = frm in ("f16", "bf16") or to in ("f16", "bf16")
    fp8 = {frm, to} & {"fe5m2", "fe4m3"}
    out = ["#version 450 core"]
    if f16_like:
        out.append("#extension GL_EXT_shader_16bit_storage: require")
        out.append("#extension GL_EXT_shader_explicit_arithmetic_types: require")
    if frm == "bf16" or to == "bf16":
        out.append("#extension GL_EXT_bfloat16: require")
    if fp8:
        out.append("#extension GL_EXT_float_e4m3 : enable")
        out.append("#extension GL_EXT_float_e5m2 : enable")
    ext = {"fe2m1": "e2m1", "fe3m2": "e3m2", "fe2m3": "e2m3", "fue8m0": "ue8m0", "fmxint8": "mxint8"}
    if frm in ext:
        out.append(f"#extension GL_EXT_float_{ext[frm]} : enable")
        out.append("#extension GL_EXT_shader_explicit_arithmetic_types: require")
    if k > 4:
        out.append("#extension GL_EXT_long_vector: require")
    ssbo_t = u8_type(k) if frm in ("fe2m1", "fe3m2", "fe2m3") else in_t
    out.append("layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;")
    out.append(f"layout(set = 0, binding = 0, std140) buffer issbodef {{ {ssbo_t} val[{arr}]; }} issbo;")
    out.append(f"layout(set = 0, binding = 1, std140) buffer ossbodef {{ {out_t} val[{arr}]; }} ossbo;")
    out.append("void main()")
    out.append("{")
    if frm in ("fe2m1", "fe3m2", "fe2m3"):
        decl, bc, plain = bodies[(frm, k)]
        out.append(decl)
        out.append(bc if bitcast else plain)
    else:
        out.append(f"    {in_t} f = issbo.val[gl_WorkGroupID.x];")
    if sat:
        out.append("    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);")
    else:
        out.append(f"    ossbo.val[gl_WorkGroupID.x] = {out_t}(f);")
    out.append("}")
    return "\n".join(out) + "\n"


def cases():
    float_types = ["fe5m2", "fe4m3", "fe2m1", "fe3m2", "fe2m3", "fue8m0", "fmxint8", "bf16", "f16", "f32", "f64"]
    sizes = [k for k in range(1, 17) if k < 5 or k in (8, 16)]
    result = []
    for frm in float_types:
        for to in float_types:
            for k in sizes:
                for sat in (False, True):
                    for bitcast in (False, True):
                        if frm == to:
                            continue
                        if bitcast and frm not in ("fe2m1", "fe3m2", "fe2m3"):
                            continue
                        if sat and (to not in ("fe5m2", "fe4m3") or frm in ("fe5m2", "fe4m3")):
                            continue
                        if to in ("fe2m1", "fe3m2", "fe2m3", "fue8m0", "fmxint8"):
                            continue
                        name = f"{frm}_to_{to}_size_{k}" + ("_sat" if sat else "") + ("_bitcastextract" if bitcast else "")
                        result.append((name, frm, to, k, sat, bitcast))
    for f in float_types:
        if f in ("fe2m1", "fe3m2", "fe2m3", "fue8m0", "fmxint8"):
            continue
        for i in ("i32", "u32"):
            for k in sizes:
                result.append((f"{f}_to_{i}_size_{k}", f, i, k, False, False))
                result.append((f"{i}_to_{f}_size_{k}", i, f, k, False, False))
    return result


# The glslang that `just cts-shaders` uses has no GL_EXT_float_e2m1/e2m3/e3m2/ue8m0/mxint8; those cases get no program and report NotSupported.
GLSLANG_LACKS = {"fe2m1", "fe3m2", "fe2m3", "fue8m0", "fmxint8"}


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    bodies = unpack_bodies()
    assert len(bodies) == 18, len(bodies)
    manifest = [
        "# Shader manifest for dEQP-VK.glsl.builtin.precision_fconvert.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_fconvert_manifest.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderexecutor/vktShaderFConvertTests.cpp"',
        'rust_module = "glsl/fconvert_tests"',
        "",
    ]
    all_cases = cases()
    for name, frm, to, k, sat, bitcast in all_cases:
        if frm in GLSLANG_LACKS or to in GLSLANG_LACKS:
            (SRC / f"{name}.comp").unlink(missing_ok=True)
            continue
        (SRC / f"{name}.comp").write_text(shader(frm, to, k, sat, bitcast, bodies))
        manifest += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "{name.upper()}"',
            'rust_type = "SharedProgram"',
            f'programs = [{{ name = "compute", template = "fconvert/{name}.comp", stage = "comp" }}]',
            "",
        ]
    MANIFEST.write_text("\n".join(manifest))
    print(len(all_cases), "cases")


main()

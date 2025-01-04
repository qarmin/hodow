#!/usr/bin/env python3
"""Generate the compute-stage shaders and the manifest of dEQP-VK.subgroups.<family>.compute.*

Upstream writes each shader in `initPrograms` from a `CaseDefinition` (operator, scan type, format, ...) around
`subgroups::initStdPrograms`, which puts the family's `testSrc` into a skeleton that every invocation runs and that stores one
`uint` verdict per invocation. The host only checks that every verdict has the expected bits, so the whole test is the GLSL: this
script writes it ahead of time, one source per distinct shader, and one manifest case per upstream case. The case's `spec` string
carries what the Rust side (`src/vkt/tests/subgroups/compute_tests.rs`) needs to run it and to skip it faithfully:

    feature=<name>;type=<token>;comps=<n>;rss=<0|1>;check=<hex>;inputs=<init>:<layout>:<type>:<comps>:<count>[|...]

The families are the functions `family_*` below, added one per upstream file as they are ported. With `--check` nothing is written;
the names are compared with tmp/missing_vk.txt (written by `missing_cases.py`, when present) so a naming slip shows up here and not in a run.

Usage:
    python3 hodow_cts/scripts/gen_subgroups_compute_manifest.py [--check]
"""

from __future__ import annotations

import argparse
import hashlib
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_REL = "subgroups/generated"
SRC_DIR = CRATE_DIR / "shaders" / "src" / SRC_REL
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "subgroups_compute.toml"
MISSING = REPO_DIR / "tmp" / "missing_vk.txt"

MAX_SUBGROUP_SIZE = 128

# `glu::DataType` scalar name, spec token
SCALARS = {
    "int8_t": "i8",
    "uint8_t": "u8",
    "int16_t": "i16",
    "uint16_t": "u16",
    "int": "i32",
    "uint": "u32",
    "int64_t": "i64",
    "uint64_t": "u64",
    "float16_t": "f16",
    "float": "f32",
    "double": "f64",
    "bool": "b32",
}

# `getDataTypeName(getDataTypeVector(type, n))` prefixes
VECTOR_PREFIX = {
    "int8_t": "i8vec",
    "uint8_t": "u8vec",
    "int16_t": "i16vec",
    "uint16_t": "u16vec",
    "int": "ivec",
    "uint": "uvec",
    "int64_t": "i64vec",
    "uint64_t": "u64vec",
    "float16_t": "f16vec",
    "float": "vec",
    "double": "dvec",
    "bool": "bvec",
}

SIGNED = {"int8_t", "int16_t", "int", "int64_t"}
UNSIGNED = {"uint8_t", "uint16_t", "uint", "uint64_t"}
FLOAT = {"float16_t", "float", "double"}


class VecType:
    def __init__(self, scalar: str, components: int):
        self.scalar = scalar
        self.components = components

    @property
    def glsl(self) -> str:
        """getFormatNameForGLSL"""
        if self.components > 4:
            return f"vector<{self.scalar}, {self.components}>"
        if self.components == 1:
            return self.scalar
        return f"{VECTOR_PREFIX[self.scalar]}{self.components}"

    @property
    def test_name(self) -> str:
        """getFormatNameForTest"""
        if self.components > 4:
            return f"vec{self.components}_{self.scalar}"
        return self.glsl

    @property
    def extension(self) -> str:
        """getAdditionalExtensionForFormat"""
        out = ""
        if self.components > 4:
            out += "#extension GL_EXT_long_vector : enable\n"
        if self.scalar in ("int8_t", "uint8_t"):
            out += "#extension GL_EXT_shader_subgroup_extended_types_int8 : enable\n"
        elif self.scalar in ("int16_t", "uint16_t"):
            out += "#extension GL_EXT_shader_subgroup_extended_types_int16 : enable\n"
        elif self.scalar in ("int64_t", "uint64_t"):
            out += "#extension GL_EXT_shader_subgroup_extended_types_int64 : enable\n"
        elif self.scalar == "float16_t":
            out += "#extension GL_EXT_shader_subgroup_extended_types_float16 : enable\n"
        return out

    @property
    def is_float(self) -> bool:
        return self.scalar in FLOAT

    @property
    def is_signed(self) -> bool:
        return self.scalar in SIGNED

    @property
    def is_unsigned(self) -> bool:
        return self.scalar in UNSIGNED

    @property
    def is_bool(self) -> bool:
        return self.scalar == "bool"

    @property
    def token(self) -> str:
        return SCALARS[self.scalar]


def all_formats() -> list[VecType]:
    """getAllFormats"""
    formats = []
    for scalar in ("int8_t", "uint8_t", "int16_t", "uint16_t", "int", "uint", "int64_t", "uint64_t", "float16_t", "float", "double", "bool"):
        for components in (1, 2, 3, 4, 8):
            formats.append(VecType(scalar, components))
    return formats


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsScanHelpers.cpp
# ---------------------------------------------------------------------------------------------------------------------------

OPERATORS = ("ADD", "MUL", "MIN", "MAX", "AND", "OR", "XOR")
SCANS = ("REDUCE", "INCLUSIVE", "EXCLUSIVE")


def scan_op_name(prefix: str, suffix: str, op: str, scan: str) -> str:
    n = {"REDUCE": "", "INCLUSIVE": "Inclusive", "EXCLUSIVE": "Exclusive"}[scan]
    n += op.capitalize()
    return prefix + n + suffix


def op_operation(op: str, vt: VecType, lhs: str, rhs: str) -> str:
    if op == "ADD":
        return f"{lhs} + {rhs}"
    if op == "MUL":
        return f"{lhs} * {rhs}"
    if op in ("MIN", "MAX"):
        fn = op.lower()
        if not vt.is_float:
            return f"{fn}({lhs}, {rhs})"
        if vt.components == 1:
            return f"(isnan({lhs}) ? {rhs} : (isnan({rhs}) ? {lhs} : {fn}({lhs}, {rhs})))"
        return f"mix(mix({fn}({lhs}, {rhs}), {lhs}, isnan({rhs})), {rhs}, isnan({lhs}))"
    sym = {"AND": ("&", "&&"), "OR": ("|", "||"), "XOR": ("^", "^^")}[op]
    if not vt.is_bool:
        return f"{lhs} {sym[0]} {rhs}"
    if vt.components == 1:
        return f"{lhs} {sym[1]} {rhs}"
    if vt.components in (2, 3, 4):
        comps = "xyzw"[: vt.components]
        terms = ", ".join(f"{lhs}.{c} {sym[1]} {rhs}.{c}" for c in comps)
        return f"bvec{vt.components}({terms})"
    terms = ", ".join(f"{lhs}[{i}] {sym[1]} {rhs}[{i}]" for i in range(vt.components))
    return f"vector<bool, {vt.components}>({terms})"


def identity(op: str, vt: VecType) -> str:
    name = vt.glsl
    if op == "ADD":
        return f"{name}(0)"
    if op == "MUL":
        return f"{name}(1)"
    if op == "MIN":
        if vt.is_float:
            return f"{name}(intBitsToFloat(0x7f800000))"
        if vt.is_signed:
            literal = {"int8_t": "0x7f", "int16_t": "0x7fff", "int64_t": "0x7fffffffffffffffUL"}.get(vt.scalar, "0x7fffffff")
            return f"{name}({literal})"
        if vt.is_unsigned:
            return f"{name}(-1)"
        raise ValueError("unhandled identity")
    if op == "MAX":
        if vt.is_float:
            return f"{name}(intBitsToFloat(0xff800000))"
        if vt.is_signed:
            literal = {"int8_t": "0x80", "int16_t": "0x8000", "int64_t": "0x8000000000000000UL"}.get(vt.scalar, "0x80000000")
            return f"{name}({literal})"
        if vt.is_unsigned:
            return f"{name}(0)"
        raise ValueError("unhandled identity")
    if op == "AND":
        return f"{name}(~0)"
    return f"{name}(0)"


def compare(op: str, vt: VecType, lhs: str, rhs: str) -> str:
    name = vt.glsl
    min_max = op in ("MIN", "MAX")
    if vt.components == 1:
        if vt.scalar == "float16_t":
            if min_max:
                return f"({lhs} == {rhs})"
            return f"(abs({lhs} - {rhs}) < {name}(gl_SubgroupSize==128 ? 0.2: 0.1))"
        if vt.scalar in ("float", "double"):
            if min_max:
                return f"({lhs} == {rhs})"
            return f"(abs({lhs} - {rhs}) < (gl_SubgroupSize==128 ? 0.000025:0.00001))"
        return f"({lhs} == {rhs})"
    if vt.scalar == "float16_t":
        if min_max:
            return f"all(equal({lhs}, {rhs}))"
        return f"all(lessThan(abs({lhs} - {rhs}), {name}(gl_SubgroupSize==128 ? 0.2: 0.1)))"
    if vt.scalar in ("float", "double"):
        if min_max:
            return f"all(equal({lhs}, {rhs}))"
        return f"all(lessThan(abs({lhs} - {rhs}), {name}(gl_SubgroupSize==128 ? 0.000025: 0.00001)))"
    return f"all(equal({lhs}, {rhs}))"


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsTestsUtils.cpp
# ---------------------------------------------------------------------------------------------------------------------------


def compute_shader(ext_header: str, vt: VecType, test_src: str, helper: str = "", temp_res: str = "  uint tempRes;\n", declarations: str | None = None) -> str:
    """initStdPrograms, the compute branch, with the buffer declarations `getBufferDeclarations` makes for stage 0 (one stage) unless
    the family passes its own (`declarations`, upstream's `declarations[0]`)."""
    if declarations is None:
        declarations = (
            "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"
            + f"layout(set = 0, binding = 1, std430) buffer Buffer2\n{{\n  {vt.glsl} data[];\n}};\n"
        )
    return (
        "#version 450\n"
        + ext_header
        + "layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;\n"
        + declarations
        + "\n"
        + helper
        + "void main (void)\n{\n"
        + "  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;\n"
        + "  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;\n"
        + temp_res
        + test_src
        + "  result[offset] = tempRes;\n}\n"
    )


class Case:
    def __init__(self, path: str, shader: str, feature: str, vt: VecType, rss: bool | int, check: int, inputs: str, req: str = "", spirv: str | None = None, check_input: int | None = None):
        """`rss` is False for no required subgroup size, True to run every size the device offers in turn, or an int for that one size."""
        self.path = path
        self.shader = shader
        self.spirv = spirv
        rss_token = f"f{rss}" if isinstance(rss, int) and not isinstance(rss, bool) else str(int(rss))
        self.spec = f"feature={feature};type={vt.token};comps={vt.components};rss={rss_token};check={check:#x};req={req};inputs={inputs}" + (f";checkin={check_input}" if check_input is not None else "")


class GraphicsCase:
    """One `ALL_GRAPHICS` case: the shaders of every stage, and the spec the runner needs."""

    def __init__(self, path: str, programs: dict[str, tuple[str, str]], feature: str, vt: VecType, check: int, inputs: str, req: str, spirv: str | None = None):
        self.path = path
        self.programs = programs
        self.spirv = spirv
        self.spec = f"feature={feature};type={vt.token};comps={vt.components};rss=0;check={check:#x};req={req};inputs={inputs}"


GRAPHICS: list[GraphicsCase] = []

GRAPHICS_STAGE_COUNT = 4


def std_declarations(vt: VecType, stage: int) -> str:
    """getBufferDeclarations without custom declarations, for the graphics stage `stage` (4 is the fragment shader)."""
    fragment = stage == GRAPHICS_STAGE_COUNT
    buffer1 = (
        "layout(location = 0) out uint result;\n"
        if fragment
        else f"layout(set = 0, binding = {stage}, std430) buffer Buffer1\n{{\n  uint result[];\n}};\n"
    )
    buffer2 = f"layout(set = 0, binding = {GRAPHICS_STAGE_COUNT}, std430) readonly buffer Buffer{'1' if fragment else '2'}\n{{\n  {vt.glsl} data[];\n}};\n"
    return buffer1 + buffer2


def graphics_programs(ext: str, vt: VecType, test_src: str, helper: str = "", decl=None, avoid_helper: bool = False) -> dict[str, tuple[str, str]]:
    """initStdPrograms, the graphics branch. The geometry point size is a device feature upstream reads in `supportedCheck`, so every
    stage that depends on it is written both ways (`_ps` is with gl_PointSize) and the runner picks."""
    decl = decl or (lambda stage: std_declarations(vt, stage))
    temp = "  uint tempRes;\n"
    programs: dict[str, tuple[str, str]] = {}

    programs["vert"] = (
        "vert",
        "#version 450\n" + ext + decl(0) + "\n" + helper + "void main (void)\n{\n  uint tempRes;\n" + test_src
        + "  result[gl_VertexIndex] = tempRes;\n"
        "  float pixelSize = 2.0f/1024.0f;\n"
        "  float pixelPosition = pixelSize/2.0f - 1.0f;\n"
        "  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);\n"
        "  gl_PointSize = 1.0f;\n}\n",
    )
    for point_size in (False, True):
        suffix = "_ps" if point_size else ""
        programs["tesc" + suffix] = (
            "tesc",
            "#version 450\n" + ext + "layout(vertices=1) out;\n" + decl(1) + "\n" + helper + "void main (void)\n{\n" + temp + test_src
            + "  result[gl_PrimitiveID] = tempRes;\n"
            "  if (gl_InvocationID == 0)\n  {\n    gl_TessLevelOuter[0] = 1.0f;\n    gl_TessLevelOuter[1] = 1.0f;\n  }\n"
            "  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
            + ("  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;\n" if point_size else "")
            + "}\n",
        )
        programs["tese" + suffix] = (
            "tese",
            "#version 450\n" + ext + "layout(isolines) in;\n" + decl(2) + "\n" + helper + "void main (void)\n{\n" + temp + test_src
            + "  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;\n"
            "  float pixelSize = 2.0f/1024.0f;\n"
            "  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;\n"
            + ("  gl_PointSize = gl_in[0].gl_PointSize;\n" if point_size else "")
            + "}\n",
        )
        for topology in ("lines", "points"):
            programs[f"geometry_{topology}" + suffix] = (
                "geom",
                "#version 450\n" + ext + f"layout({topology}) in;\nlayout(points, max_vertices = 1) out;\n" + decl(3) + "\n" + helper
                + "void main (void)\n{\n" + temp + test_src
                + "  result[gl_PrimitiveIDIn] = tempRes;\n"
                "  gl_Position = gl_in[0].gl_Position;\n"
                + ("  gl_PointSize = gl_in[0].gl_PointSize;\n" if point_size else "")
                + "  EmitVertex();\n  EndPrimitive();\n}\n",
            )
    programs["fragment"] = (
        "frag",
        "#version 450\n" + ext + decl(4) + helper + "void main (void)\n{\n"
        + ("  if (gl_HelperInvocation) return;\n" if avoid_helper else "")
        + temp + test_src + "  result = tempRes;\n}\n",
    )
    return programs


def add_graphics(path, ext, vt, test_src, feature, check, inputs, req="", helper="", decl=None, spirv=None) -> None:
    GRAPHICS.append(GraphicsCase(path, graphics_programs(ext, vt, test_src, helper, decl), feature, vt, check, inputs, req, spirv))


class FramebufferCase:
    """One framebuffer case: the test source in one of the four stages of the vertex pipeline, whose verdict goes out as a float."""

    def __init__(self, path: str, stage: str, programs: dict[str, tuple[str, str]], feature: str, vt: VecType, check: int, inputs: str, req: str, spirv: str | None):
        self.path = path
        self.programs = programs
        self.spirv = spirv
        self.spec = f"feature={feature};type={vt.token};comps={vt.components};rss=0;check={check:#x};req={req};stage={stage};inputs={inputs}"


FRAMEBUFFER: list[FramebufferCase] = []

# fbStages: the stage's name in a case name and the stage token of the spec
FB_STAGES = [("vertex", "vert"), ("tess_eval", "tese"), ("tess_control", "tesc"), ("geometry", "geom")]


def fb_std_declarations(vt: VecType, stage_index: int) -> str:
    """getFramebufferBufferDeclarations without custom declarations."""
    name = "result" if stage_index == 0 else "out_color"
    suffix = "[]" if stage_index == 2 else ""
    return (
        f"layout(location = 0) out float {name}{suffix};\n"
        "layout(set = 0, binding = 0) uniform Buffer1\n"
        "{\n"
        f"  {vt.glsl} data[{MAX_SUBGROUP_SIZE}];\n"
        "};\n"
    )


def fb_stage_program(stage: str, ext: str, vt: VecType, test_src: str, helper: str, decl, point_size: bool) -> tuple[str, str]:
    """initStdFrameBufferPrograms, the branch of one stage."""
    ps = point_size
    if stage == "vert":
        return (
            "vert",
            "#version 450\n" + ext + "layout(location = 0) in highp vec4 in_position;\n" + decl(0) + "\n" + helper + "void main (void)\n{\n"
            "  uint tempRes;\n" + test_src + "  result = float(tempRes);\n  gl_Position = in_position;\n  gl_PointSize = 1.0f;\n}\n",
        )
    if stage == "geom":
        return (
            "geom",
            "#version 450\n" + ext + "layout(points) in;\nlayout(points, max_vertices = 1) out;\n" + decl(1) + "\n" + helper + "void main (void)\n{\n"
            "  uint tempRes;\n" + test_src + "  out_color = float(tempRes);\n  gl_Position = gl_in[0].gl_Position;\n"
            + ("  gl_PointSize = gl_in[0].gl_PointSize;\n" if ps else "") + "  EmitVertex();\n  EndPrimitive();\n}\n",
        )
    if stage == "tesc":
        return (
            "tesc",
            "#version 450\n" + ext + "layout(vertices = 2) out;\n" + decl(2) + "\n" + helper + "void main (void)\n{\n"
            "  if (gl_InvocationID == 0)\n  {\n    gl_TessLevelOuter[0] = 1.0f;\n    gl_TessLevelOuter[1] = 1.0f;\n  }\n"
            "  uint tempRes;\n" + test_src + "  out_color[gl_InvocationID] = float(tempRes);\n"
            "  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
            + ("  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;\n" if ps else "") + "}\n",
        )
    return (
        "tese",
        "#version 450\n" + ext + "layout(isolines, equal_spacing, ccw ) in;\n" + decl(3) + "\n" + helper + "void main (void)\n{\n"
        "  uint tempRes;\n" + test_src + "  out_color = float(tempRes);\n"
        "  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);\n"
        + ("  gl_PointSize = gl_in[0].gl_PointSize;\n" if ps else "") + "}\n",
    )


def add_framebuffer(prefix: str, name: str, ext: str, vt: VecType, test_src: str, feature: str, check: int, req: str = "", helper: str = "", decl=None, spirv: str | None = None, inputs: str | None = None, joiner: str = "_") -> None:
    decl = decl or (lambda stage_index: fb_std_declarations(vt, stage_index))
    inputs = inputs if inputs is not None else f"nonzero:std140:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}:ubo"
    for stage_name, stage in FB_STAGES:
        programs = {}
        for point_size in ((False, True) if stage != "vert" else (False,)):
            program, source = fb_stage_program(stage, ext, vt, test_src, helper, decl, point_size)
            programs[f"test_{stage}" + ("_ps" if point_size else "")] = (program, source)
        FRAMEBUFFER.append(FramebufferCase(f"{prefix}{name}{joiner}{stage_name}", stage, programs, feature, vt, check, inputs, req, spirv))


class MeshCase:
    """A case that runs the test source in the mesh or in the task stage of a mesh pipeline."""

    def __init__(self, path: str, stage: str, programs: dict[str, tuple[str, str]], feature: str, vt: VecType, rss: bool | int, check: int, inputs: str, req: str, spirv: str, check_input: int | None = None):
        self.path = path
        self.programs = programs
        self.spirv = spirv
        rss_token = f"f{rss}" if isinstance(rss, int) and not isinstance(rss, bool) else str(int(rss))
        self.spec = f"feature={feature};type={vt.token};comps={vt.components};rss={rss_token};check={check:#x};req={req};stage={stage};inputs={inputs}" + (f";checkin={check_input}" if check_input is not None else "")


MESH: list[MeshCase] = []

MESH_STAGES = ["mesh", "task"]

MESH_NO_SUBGROUPS = (
    "#version 450\n"
    "#extension GL_EXT_mesh_shader : enable\n"
    "\n"
    "layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
    "layout (points) out;\n"
    "layout (max_vertices = 1, max_primitives = 1) out;\n"
    "\n"
    "void main (void)\n"
    "{\n"
    "  SetMeshOutputsEXT(0u, 0u);\n"
    "}\n"
)


def compute_declarations(vt: VecType) -> str:
    return (
        "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"
        + f"layout(set = 0, binding = 1, std430) buffer Buffer2\n{{\n  {vt.glsl} data[];\n}};\n"
    )


def mesh_programs(stage: str, ext: str, vt: VecType, test_src: str, helper: str, declarations: str | None, temp_res: str = "  uint tempRes;\n") -> dict[str, tuple[str, str]]:
    """initStdPrograms, the mesh shading branch."""
    declarations = declarations if declarations is not None else compute_declarations(vt)
    body = (
        "layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;\n"
        + ("layout (points) out;\nlayout (max_vertices = 1, max_primitives = 1) out;\n" if stage == "mesh" else "")
        + declarations
        + "\n"
        + helper
        + "void main (void)\n{\n"
        "  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;\n"
        "  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;\n"
        + temp_res
        + test_src
        + "  result[offset] = tempRes;\n"
        + ("  SetMeshOutputsEXT(0u, 0u);\n" if stage == "mesh" else "  EmitMeshTasksEXT(0, 0, 0);\n")
        + "}\n"
    )
    source = "#version 450\n#extension GL_EXT_mesh_shader : enable\n" + ext + body
    if stage == "mesh":
        return {"mesh": ("mesh", source)}
    return {"task": ("task", source), "mesh": ("mesh", MESH_NO_SUBGROUPS)}


def add_mesh(prefix, name, ext, vt, test_src, feature, check, inputs, req="", spirv=None, helper="", declarations=None, rss_variants=None, stage_first=False) -> None:
    """The mesh and task cases of a family: `rss_variants` is what a compute case has, as (required size, name suffix) pairs."""
    rss_variants = rss_variants or [(False, ""), (True, "_requiredsubgroupsize")]
    for stage in MESH_STAGES:
        programs = mesh_programs(stage, ext, vt, test_src, helper, declarations)
        for rss, suffix in rss_variants:
            case_name = f"{name}_{stage}{suffix}" if stage_first else f"{name}{suffix}_{stage}"
            MESH.append(MeshCase(prefix + case_name, stage, programs, feature, vt, rss, check, inputs, req, spirv or "spirv1.4"))


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsArithmeticTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------

ARITHMETIC_OPTYPES = [(op, scan) for scan in SCANS for op in OPERATORS]


def arithmetic_test_src(op: str, scan: str, vt: VecType) -> str:
    index_vars = {
        "REDUCE": "  uint start = 0, end = gl_SubgroupSize;\n",
        "INCLUSIVE": "  uint start = 0, end = gl_SubgroupInvocationID + 1;\n",
        "EXCLUSIVE": "  uint start = 0, end = gl_SubgroupInvocationID;\n",
    }[scan]
    op_name = scan_op_name("subgroup", "", op, scan)
    cmp_ = compare(op, vt, "ref", f"{op_name}(data[gl_SubgroupInvocationID])")
    cmp2 = compare(op, vt, "ref", f"{op_name}(data[gl_SubgroupInvocationID])")
    shader = (
        "  uvec4 mask = subgroupBallot(true);\n"
        + index_vars
        + "  "
        + vt.glsl
        + " ref = "
        + identity(op, vt)
        + ";\n"
        "  tempRes = 0;\n"
        "  uint identityOnly = 0x3;\n"
        "  for (uint index = start; index < end; index++)\n"
        "  {\n"
        "    if (subgroupBallotBitExtract(mask, index))\n"
        "    {\n"
        "      ref = " + op_operation(op, vt, "ref", "data[index]") + ";\n"
        "      identityOnly &= ~0x1;\n"
        "    }\n"
        "  }\n"
        "  tempRes = " + cmp_ + " ? 0x1 : 0;\n"
        "  if (1 == (gl_SubgroupInvocationID % 2))\n"
        "  {\n"
        "    mask = subgroupBallot(true);\n"
        "    ref = " + identity(op, vt) + ";\n"
        "    for (uint index = start; index < end; index++)\n"
        "    {\n"
        "      if (subgroupBallotBitExtract(mask, index))\n"
        "      {\n"
        "        ref = " + op_operation(op, vt, "ref", "data[index]") + ";\n"
        "        identityOnly &= ~0x2;\n"
        "      }\n"
        "    }\n"
        "    tempRes |= " + cmp2 + " ? 0x2 : 0;\n"
        "  }\n"
        "  else\n"
        "  {\n"
        "    tempRes |= 0x2;\n"
        "  }\n"
    )
    # Can't test max or min identity as they are +/-inf, which the SPIR-V compiler is allowed to assume don't occur in the program
    if op in ("MIN", "MAX") and vt.is_float:
        shader += "  tempRes |= identityOnly;\n"
    return shader


def family_arithmetic() -> list[Case]:
    cases = []
    for vt in all_formats():
        for op, scan in ARITHMETIC_OPTYPES:
            bitwise = op in ("AND", "OR", "XOR")
            if vt.is_float and bitwise:
                continue
            if vt.is_bool and not bitwise:
                continue
            name = scan_op_name("subgroup", "", op, scan).lower() + "_" + vt.test_name
            ext = (
                "#extension GL_KHR_shader_subgroup_arithmetic: enable\n"
                "#extension GL_KHR_shader_subgroup_ballot: enable\n" + vt.extension
            )
            shader = compute_shader(ext, vt, arithmetic_test_src(op, scan, vt))
            inputs = f"nonzero:std430:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}"
            add_graphics(f"subgroups/arithmetic/graphics/{name}", ext, vt, arithmetic_test_src(op, scan, vt), "arithmetic", 0x3, inputs)
            add_framebuffer("subgroups/arithmetic/framebuffer/", name, ext, vt, arithmetic_test_src(op, scan, vt), "arithmetic", 0x3)
            add_mesh("subgroups/arithmetic/mesh/", name, ext, vt, arithmetic_test_src(op, scan, vt), "arithmetic", 0x3, inputs, stage_first=True)
            for rss in (False, True):
                cases.append(Case(f"subgroups/arithmetic/compute/{name}" + ("_requiredsubgroupsize" if rss else ""), shader, "arithmetic", vt, rss, 0x3, inputs))
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsPartitionedTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------


def partitioned_test_src(op: str, scan: str, vt: VecType) -> str:
    fmt = vt.glsl
    part = scan_op_name("subgroupPartitioned", "NV", op, scan)
    plain = scan_op_name("subgroup", "", op, scan)

    # NOTE: tempResult can't have anything in bits 31:24 to avoid int->float conversion overflow in framebuffer tests.
    bdy = "  uvec4 mask = subgroupBallot(true);\n  uint tempResult = 0;\n  uint id = gl_SubgroupInvocationID;\n"

    # Test the case where the partition has a single subset with all invocations in it. This should generate the same result as the
    # non-partitioned function.
    bdy += (
        "  uvec4 allBallot = mask;\n"
        f"  {fmt} allResult = {part}(data[gl_SubgroupInvocationID], allBallot);\n"
        f"  {fmt} refResult = {plain}(data[gl_SubgroupInvocationID]);\n"
        f"  if ({compare(op, vt, 'allResult', 'refResult')}) {{\n"
        "      tempResult |= 0x1;\n"
        "  }\n"
    )

    # The definition of a partition doesn't forbid bits corresponding to inactive invocations being in the subset with active
    # invocations. In other words, test that bits corresponding to inactive invocations are ignored.
    bdy += (
        "  if (0 == (gl_SubgroupInvocationID % 2)) {\n"
        f"    {fmt} allResult = {part}(data[gl_SubgroupInvocationID], allBallot);\n"
        f"    {fmt} refResult = {plain}(data[gl_SubgroupInvocationID]);\n"
        f"    if ({compare(op, vt, 'allResult', 'refResult')}) {{\n"
        "        tempResult |= 0x2;\n"
        "    }\n"
        "  } else {\n"
        "    tempResult |= 0x2;\n"
        "  }\n"
    )

    # Test the case where the partition has each invocation in a unique subset. For exclusive ops, the result is identity. For
    # reduce/inclusive, it's the original value.
    expected_self = identity(op, vt) if scan == "EXCLUSIVE" else "data[gl_SubgroupInvocationID]"
    bdy += (
        "  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);\n"
        f"  {fmt} selfResult = {part}(data[gl_SubgroupInvocationID], selfBallot);\n"
        f"  if ({compare(op, vt, 'selfResult', expected_self)}) {{\n"
        "      tempResult |= 0x4;\n"
        "  }\n"
    )

    # Test "random" partitions based on a hash of the invocation id. This "hash" function produces interesting/randomish partitions.
    idhash = "((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2)"
    bdy += (
        "  for (uint N = 1; N < 16; ++N) {\n"
        f"    {fmt} idhashFmt = {fmt}({idhash});\n"
        "    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;\n"
        f"    {fmt} partitionedResult = {part}(data[gl_SubgroupInvocationID], partitionBallot);\n"
        "      for (uint i = 0; i < N; ++i) {\n"
        f"        {fmt} iFmt = {fmt}(i);\n"
        f"        if ({compare(op, vt, 'idhashFmt', 'iFmt')}) {{\n"
        f"          {fmt} subsetResult = {plain}(data[gl_SubgroupInvocationID]);\n"
        f"          tempResult |= {compare(op, vt, 'partitionedResult', 'subsetResult')} ? (0x4 << N) : 0;\n"
        "        }\n"
        "      }\n"
        "  }\n"
        # tests in flow control:
        "  if (1 == (gl_SubgroupInvocationID % 2)) {\n"
        "    for (uint N = 1; N < 7; ++N) {\n"
        f"      {fmt} idhashFmt = {fmt}({idhash});\n"
        "      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;\n"
        f"      {fmt} partitionedResult = {part}(data[gl_SubgroupInvocationID], partitionBallot);\n"
        "        for (uint i = 0; i < N; ++i) {\n"
        f"          {fmt} iFmt = {fmt}(i);\n"
        f"          if ({compare(op, vt, 'idhashFmt', 'iFmt')}) {{\n"
        f"            {fmt} subsetResult = {plain}(data[gl_SubgroupInvocationID]);\n"
        f"            tempResult |= {compare(op, vt, 'partitionedResult', 'subsetResult')} ? (0x20000 << N) : 0;\n"
        "          }\n"
        "        }\n"
        "    }\n"
        "  } else {\n"
        "    tempResult |= 0xFC0000;\n"
        "  }\n"
        "  tempRes = tempResult;\n"
    )
    return bdy


def scan_family(group: str, feature: str, ext_header, test_src, check: int) -> list[Case]:
    """The shape shared by the arithmetic and the partitioned files: every operator over every format, plain and required subgroup size."""
    cases = []
    for vt in all_formats():
        for op, scan in ARITHMETIC_OPTYPES:
            bitwise = op in ("AND", "OR", "XOR")
            if vt.is_float and bitwise:
                continue
            if vt.is_bool and not bitwise:
                continue
            name = scan_op_name("subgroup", "", op, scan).lower() + "_" + vt.test_name
            shader = compute_shader(ext_header(vt), vt, test_src(op, scan, vt))
            inputs = f"nonzero:std430:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}"
            add_graphics(f"subgroups/{group}/graphics/{name}", ext_header(vt), vt, test_src(op, scan, vt), feature, check, inputs)
            add_framebuffer(f"subgroups/{group}/framebuffer/", name, ext_header(vt), vt, test_src(op, scan, vt), feature, check)
            add_mesh(f"subgroups/{group}/mesh/", name, ext_header(vt), vt, test_src(op, scan, vt), feature, check, inputs)
            for rss in (False, True):
                cases.append(Case(f"subgroups/{group}/compute/{name}" + ("_requiredsubgroupsize" if rss else ""), shader, feature, vt, rss, check, inputs))
    return cases


def family_partitioned() -> list[Case]:
    def ext_header(vt: VecType) -> str:
        return (
            "#extension GL_NV_shader_subgroup_partitioned: enable\n"
            "#extension GL_KHR_shader_subgroup_arithmetic: enable\n"
            "#extension GL_KHR_shader_subgroup_ballot: enable\n" + vt.extension
        )

    return scan_family("partitioned", "partitioned", ext_header, partitioned_test_src, 0xFFFFFF)


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsClusteredTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------


def clustered_test_src(op: str, vt: VecType) -> str:
    fmt = vt.glsl
    op_name = scan_op_name("subgroupClustered", "", op, "REDUCE")
    ident = identity(op, vt)
    operation = op_operation(op, vt, "ref", "data[index]")
    cmp_ = compare(op, vt, "ref", "op")
    bdy = "  bool tempResult = true;\n  uvec4 mask = subgroupBallot(true);\n"
    i = 1
    while i <= MAX_SUBGROUP_SIZE:
        bdy += (
            "  {\n"
            f"    const uint clusterSize = {i};\n"
            "    if (clusterSize <= gl_SubgroupSize)\n"
            "    {\n"
            f"      {fmt} op = {op_name}(data[gl_SubgroupInvocationID], clusterSize);\n"
            "      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)\n"
            "      {\n"
            f"        {fmt} ref = {ident};\n"
            "        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)\n"
            "        {\n"
            "          if (subgroupBallotBitExtract(mask, index))\n"
            "          {\n"
            f"            ref = {operation};\n"
            "          }\n"
            "        }\n"
            "        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))\n"
            "        {\n"
            f"          if (!{cmp_})\n"
            "          {\n"
            "            tempResult = false;\n"
            "          }\n"
            "        }\n"
            "      }\n"
            "    }\n"
            "  }\n"
        )
        i *= 2
    bdy += "  tempRes = tempResult ? 1 : 0;\n"
    return bdy


def family_clustered() -> list[Case]:
    cases = []
    for vt in all_formats():
        for op in OPERATORS:
            bitwise = op in ("AND", "OR", "XOR")
            if vt.is_float and bitwise:
                continue
            if vt.is_bool and not bitwise:
                continue
            name = scan_op_name("subgroupClustered", "", op, "REDUCE").lower() + "_" + vt.test_name
            ext = "#extension GL_KHR_shader_subgroup_clustered: enable\n#extension GL_KHR_shader_subgroup_ballot: enable\n" + vt.extension
            shader = compute_shader(ext, vt, clustered_test_src(op, vt))
            inputs = f"nonzero:std430:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}"
            add_graphics(f"subgroups/clustered/graphics/{name}", ext, vt, clustered_test_src(op, vt), "clustered", 1, inputs)
            add_framebuffer("subgroups/clustered/framebuffer/", name, ext, vt, clustered_test_src(op, vt), "clustered", 1)
            add_mesh("subgroups/clustered/mesh/", name, ext, vt, clustered_test_src(op, vt), "clustered", 1, inputs)
            for rss in (False, True):
                cases.append(Case(f"subgroups/clustered/compute/{name}" + ("_requiredsubgroupsize" if rss else ""), shader, "clustered", vt, rss, 1, inputs))
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsQuadTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------

QUAD_OPS = [
    ("subgroupQuadBroadcast", "subgroupquadbroadcast"),
    ("subgroupQuadBroadcast", "subgroupquadbroadcast_nonconst"),
    ("subgroupQuadSwapHorizontal", "subgroupquadswaphorizontal"),
    ("subgroupQuadSwapVertical", "subgroupquadswapvertical"),
    ("subgroupQuadSwapDiagonal", "subgroupquadswapdiagonal"),
]


def quad_test_src(op_index: int, vt: VecType) -> str:
    swap_table = [
        "",
        "",
        "  const uint swapTable[4] = {1, 0, 3, 2};\n",
        "  const uint swapTable[4] = {2, 3, 0, 1};\n",
        "  const uint swapTable[4] = {3, 2, 1, 0};\n",
    ]
    validate = "  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])\n    tempRes = 0;\n"
    fmt = vt.glsl
    op = QUAD_OPS[op_index][0]
    src = "  uvec4 mask = subgroupBallot(true);\n" + swap_table[op_index] + "  tempRes = 1;\n"
    if op_index == 0:
        for i in range(4):
            src += (
                "  {\n"
                f"  {fmt} op = {op}(data[gl_SubgroupInvocationID], {i});\n"
                f"  uint otherID = (gl_SubgroupInvocationID & ~0x3) + {i};\n" + validate + "  }\n"
            )
    elif op_index == 1:
        src += (
            "  for (int i=0; i<4; i++)"
            "  {\n"
            f"  {fmt} op = {op}(data[gl_SubgroupInvocationID], i);\n"
            "  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;\n" + validate + "  }\n"
            "  uint quadID = gl_SubgroupInvocationID >> 2;\n"
            "  uint quadInvocation = gl_SubgroupInvocationID & 0x3;\n"
            "  // Test lane ID that is only uniform in active lanes\n"
            "  if (quadInvocation >= 2)\n"
            "  {\n"
            "    uint id = quadInvocation & ~1;\n"
            f"    {fmt} op = {op}(data[gl_SubgroupInvocationID], id);\n"
            "    uint otherID = 4*quadID + id;\n" + validate + "  }\n"
            "  // Test lane ID that is only quad uniform, not subgroup uniform\n"
            "  {\n"
            "    uint id = quadID & 0x3;\n"
            f"    {fmt} op = {op}(data[gl_SubgroupInvocationID], id);\n"
            "    uint otherID = 4*quadID + id;\n" + validate + "  }\n"
        )
    else:
        src += (
            f"  {fmt} op = {op}(data[gl_SubgroupInvocationID]);\n"
            "  uint otherID = (gl_SubgroupInvocationID & ~0x3) + swapTable[gl_SubgroupInvocationID & 0x3];\n" + validate
        )
    return src


def family_quad() -> list[Case]:
    cases = []
    for vt in all_formats():
        for op_index, (_, case_name) in enumerate(QUAD_OPS):
            name = f"{case_name}_{vt.test_name}"
            ext = "#extension GL_KHR_shader_subgroup_quad: enable\n#extension GL_KHR_shader_subgroup_ballot: enable\n" + vt.extension
            nonconst = op_index == 1
            shader = compute_shader(ext, vt, quad_test_src(op_index, vt))
            inputs = f"nonzero:std430:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}"
            add_graphics(f"subgroups/quad/graphics/{name}", ext, vt, quad_test_src(op_index, vt), "quad", 1, inputs, req="dynid" if nonconst else "", spirv="spirv1.5" if nonconst else None)
            add_framebuffer("subgroups/quad/framebuffer/", name, ext, vt, quad_test_src(op_index, vt), "quad", 1, req="dynid" if nonconst else "", spirv="spirv1.5" if nonconst else None)
            add_mesh("subgroups/quad/mesh/", name, ext, vt, quad_test_src(op_index, vt), "quad", 1, inputs, req="dynid" if nonconst else "", spirv="spirv1.5" if nonconst else None)
            for rss in (False, True):
                cases.append(
                    Case(
                        f"subgroups/quad/compute/{name}" + ("_requiredsubgroupsize" if rss else ""),
                        shader,
                        "quad",
                        vt,
                        rss,
                        1,
                        inputs,
                        req="dynid" if nonconst else "",
                        spirv="spirv1.5" if nonconst else None,
                    )
                )
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsShuffleTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------

SHUFFLE_OPS = ["subgroupShuffle", "subgroupShuffleXor", "subgroupShuffleUp", "subgroupShuffleDown", "subgroupRotate", "subgroupClusteredRotate"]
SHUFFLE_EXT = [
    "GL_KHR_shader_subgroup_shuffle",
    "GL_KHR_shader_subgroup_shuffle",
    "GL_KHR_shader_subgroup_shuffle_relative",
    "GL_KHR_shader_subgroup_shuffle_relative",
    "GL_KHR_shader_subgroup_rotate",
    "GL_KHR_shader_subgroup_rotate",
]
SHUFFLE_ARGS = [("DYNAMIC", ""), ("DYNAMICALLY_UNIFORM", "_dynamically_uniform"), ("CONSTANT", "_constant")]


def shuffle_declarations(vt: VecType, arg: str) -> str:
    """getPerStageHeadDeclarations, the entry of the only stage of a compute shader."""
    b2_layout = "std430" if arg == "DYNAMIC" else "std140"
    b2_type = "readonly buffer" if arg == "DYNAMIC" else "uniform"
    return (
        "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"
        "layout(set = 0, binding = 1, std430) readonly buffer Buffer2\n{\n  " + vt.glsl + " data1[];\n};\n"
        f"layout(set = 0, binding = 2, {b2_layout}) {b2_type} Buffer3\n{{\n  uint data2[];\n}};\n"
    )


def shuffle_graphics_declarations(vt: VecType, arg: str, stage: int) -> str:
    """getPerStageHeadDeclarations, the entry of stage `stage` of the graphics pipeline (4 is the fragment shader)."""
    b2_layout = "std430" if arg == "DYNAMIC" else "std140"
    b2_type = "readonly buffer" if arg == "DYNAMIC" else "uniform"
    buffer1 = (
        "layout(location = 0) out uint result;\n"
        if stage == GRAPHICS_STAGE_COUNT
        else f"layout(set = 0, binding = {stage}, std430) buffer Buffer1\n{{\n  uint result[];\n}};\n"
    )
    return (
        buffer1
        + f"layout(set = 0, binding = {GRAPHICS_STAGE_COUNT}, std430) readonly buffer Buffer2\n{{\n  {vt.glsl} data1[];\n}};\n"
        + f"layout(set = 0, binding = {GRAPHICS_STAGE_COUNT + 1}, {b2_layout}) {b2_type} Buffer3\n{{\n  uint data2[];\n}};\n"
    )


def shuffle_framebuffer_declarations(vt: VecType, arg: str, stage_index: int) -> str:
    """getFramebufferPerStageHeadDeclarations"""
    b2_len = MAX_SUBGROUP_SIZE if arg == "DYNAMIC" else 1
    buffer2 = (
        "layout(set = 0, binding = 0) uniform Buffer1\n"
        "{\n"
        f"  {vt.glsl} data1[{MAX_SUBGROUP_SIZE}];\n"
        "};\n"
        "layout(set = 0, binding = 1) uniform Buffer2\n"
        "{\n"
        f"  uint data2[{b2_len}];\n"
        "};\n"
    )
    first = {0: "layout(location = 0) out float result;\n", 1: "layout(location = 0) out float out_color;\n", 2: "layout(location = 0) out float out_color[];\n", 3: "layout(location = 0) out float out_color;\n"}[stage_index]
    return first + buffer2


def shuffle_non_clustered_src(op_index: int, vt: VecType, arg: str) -> str:
    ident = {
        0: "id_in",
        1: "gl_SubgroupInvocationID ^ id_in",
        2: "gl_SubgroupInvocationID - id_in",
        3: "gl_SubgroupInvocationID + id_in",
        4: "(gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1)",
    }[op_index]
    if arg == "DYNAMIC":
        id_in_source = "data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1)"
    elif arg == "DYNAMICALLY_UNIFORM":
        id_in_source = "data2[0] & (gl_SubgroupSize * 2 - 1)" if op_index == 4 else "data2[0] % 32"
    else:
        id_in_source = "5"
    return (
        "  uint temp_res;\n"
        "  uvec4 mask = subgroupBallot(true);\n"
        "  uint id_in = " + id_in_source + ";\n"
        "  " + vt.glsl + " op = " + SHUFFLE_OPS[op_index] + "(data1[gl_SubgroupInvocationID], id_in);\n"
        "  uint id = " + ident + ";\n"
        "  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))\n"
        "  {\n"
        "    temp_res = (op == data1[id]) ? 1 : 0;\n"
        "  }\n"
        "  else\n"
        "  {\n"
        "    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!\n"
        "  }\n"
        "  tempRes = temp_res;\n"
    )


def shuffle_clustered_src(vt: VecType, arg: str) -> str:
    id_in_source = "data2[0] & (gl_SubgroupSize * 2 - 1)" if arg == "DYNAMICALLY_UNIFORM" else "5" if arg == "CONSTANT" else ""
    name = SHUFFLE_OPS[5]
    cases = "".join(f"      case {n}: op = {name}(data1_val, id_in, {n}u); break;\n" for n in (1, 2, 4, 8, 16, 32, 64, 128))
    return (
        "  uint temp_res = 1;\n"
        "  uvec4 mask = subgroupBallot(true);\n"
        "  uint cluster_size;\n"
        "  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)\n"
        "  {\n"
        "    uint id_in = " + id_in_source + ";\n"
        "    uint cluster_res;\n"
        "    " + vt.glsl + " data1_val = data1[gl_SubgroupInvocationID];\n"
        "    " + vt.glsl + " op;\n"
        "    switch (cluster_size)\n"
        "    {\n"
        + cases
        + "    }\n"
        "    uint id = ((gl_SubgroupInvocationID + id_in) & (cluster_size - 1)) | (gl_SubgroupInvocationID & ~(cluster_size - 1));\n"
        "    if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))\n"
        "    {\n"
        "      cluster_res = (op == data1[id]) ? 1 : 0;\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "      cluster_res = 1; // Invocation we read from was inactive, so we can't verify results!\n"
        "    }\n"
        "    temp_res = (temp_res & cluster_res);\n"
        "  }\n"
        "  tempRes = temp_res;\n"
    )


def family_shuffle() -> list[Case]:
    cases = []
    for vt in all_formats():
        for op_index, op_name in enumerate(SHUFFLE_OPS):
            for arg, suffix in SHUFFLE_ARGS:
                if op_index == 0 and arg != "DYNAMIC":
                    continue
                if op_index in (4, 5) and arg == "DYNAMIC":
                    continue
                name = op_name.lower() + "_" + vt.test_name + suffix
                ext = f"#extension {SHUFFLE_EXT[op_index]}: enable\n#extension GL_KHR_shader_subgroup_ballot: enable\n" + vt.extension
                src = shuffle_clustered_src(vt, arg) if op_index == 5 else shuffle_non_clustered_src(op_index, vt, arg)
                shader = compute_shader(ext, vt, src, declarations=shuffle_declarations(vt, arg))
                second = (
                    f"nonzero:std430:u32:1:{MAX_SUBGROUP_SIZE}:ssbo" if arg == "DYNAMIC" else "nonzero:std140:u32:1:1:ubo"
                )
                inputs = f"nonzero:std430:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}|{second}"
                feature = {0: "shuffle", 1: "shuffle", 2: "shuffle_relative", 3: "shuffle_relative"}.get(op_index, "none")
                req = {4: "rotate", 5: "rotate_clustered"}.get(op_index, "")
                fb_second = f"nonzero:std140:u32:1:{MAX_SUBGROUP_SIZE if arg == 'DYNAMIC' else 1}:ubo"
                add_framebuffer(
                    "subgroups/shuffle/framebuffer/",
                    name,
                    ext,
                    vt,
                    src,
                    feature,
                    1,
                    req=req,
                    decl=lambda stage_index, vt=vt, arg=arg: shuffle_framebuffer_declarations(vt, arg, stage_index),
                    inputs=f"nonzero:std140:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}:ubo|{fb_second}",
                )
                add_mesh("subgroups/shuffle/mesh/", name, ext, vt, src, feature, 1, inputs, req=req, declarations=shuffle_declarations(vt, arg))
                add_graphics(f"subgroups/shuffle/graphics/{name}", ext, vt, src, feature, 1, inputs, req=req, decl=lambda stage, vt=vt, arg=arg: shuffle_graphics_declarations(vt, arg, stage))
                for rss in (False, True):
                    cases.append(Case(f"subgroups/shuffle/compute/{name}" + ("_requiredsubgroupsize" if rss else ""), shader, feature, vt, rss, 1, inputs, req=req))
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsBallotBroadcastTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------

BROADCAST_OPS = ["subgroupbroadcast", "subgroupbroadcast_nonconst", "subgroupbroadcastfirst"]


def ballot_broadcast_src(op_index: int, vt: VecType, ext_arb: bool, size_control: bool, required_size: int) -> str:
    fmt = vt.glsl
    if ext_arb:
        broadcast, broadcast_first = "readInvocationARB", "readFirstInvocationARB"
        mask = "mask = ballotARB(true);\n"
        max_ = 64
        bdy = "  uint64_t mask;\n" + mask + "  uint sgSize = gl_SubGroupSizeARB;\n  uint sgInvocation = gl_SubGroupInvocationARB;\n"
    else:
        broadcast, broadcast_first = "subgroupBroadcast", "subgroupBroadcastFirst"
        mask = "mask = subgroupBallot(true);\n"
        max_ = required_size if size_control else MAX_SUBGROUP_SIZE
        bdy = "  uvec4 mask = subgroupBallot(true);\n  uint sgSize = gl_SubgroupSize;\n  uint sgInvocation = gl_SubgroupInvocationID;\n"

    if op_index == 0:
        bdy += f"  tempRes = 0x3;\n  {fmt} ops[{max_}];\n  {fmt} d = data[sgInvocation];\n"
        for i in range(max_):
            bdy += f"  ops[{i}] = {broadcast}(d, {i}u);\n"
        bdy += (
            "  for(int id = 0; id < sgSize; id++)\n"
            "  {\n"
            "    if (subgroupBallotBitExtract(mask, id) && ops[id] != data[id])\n"
            "    {\n"
            "      tempRes = 0;\n"
            "    }\n"
            "  };\n"
        )
    elif op_index == 1:
        validate = "    if (subgroupBallotBitExtract(mask, id) && op != data[id])\n        tempRes = 0;\n"
        bdy += (
            "  tempRes= 0x3;\n"
            "  for (uint id = 0; id < sgSize; id++)\n"
            "  {\n"
            f"    {fmt} op = {broadcast}(data[sgInvocation], id);\n" + validate + "  }\n"
            "  // Test lane id that is only uniform across active lanes\n"
            "  if (sgInvocation >= sgSize / 2)\n"
            "  {\n"
            "    uint id = sgInvocation & ~((sgSize / 2) - 1);\n"
            f"    {fmt} op = {broadcast}(data[sgInvocation], id);\n" + validate + "  }\n"
        )
    else:
        bdy += (
            "  tempRes = 0;\n"
            "  uint firstActive = 0;\n"
            "  for (uint i = 0; i < sgSize; i++)\n"
            "  {\n"
            "    if (subgroupBallotBitExtract(mask, i))\n"
            "    {\n"
            "      firstActive = i;\n"
            "      break;\n"
            "    }\n"
            "  }\n"
            f"  tempRes |= ({broadcast_first}(data[sgInvocation]) == data[firstActive]) ? 0x1 : 0;\n"
            "  // make the firstActive invocation inactive now\n"
            "  if (firstActive != sgInvocation)\n"
            "  {\n"
            + mask
            + "    for (uint i = 0; i < sgSize; i++)\n"
            "    {\n"
            "      if (subgroupBallotBitExtract(mask, i))\n"
            "      {\n"
            "        firstActive = i;\n"
            "        break;\n"
            "      }\n"
            "    }\n"
            f"    tempRes |= ({broadcast_first}(data[sgInvocation]) == data[firstActive]) ? 0x2 : 0;\n"
            "  }\n"
            "  else\n"
            "  {\n"
            "    // the firstActive invocation didn't partake in the second result so set it to true\n"
            "    tempRes |= 0x2;\n"
            "  }\n"
        )
    return bdy


ARB_HELPER = (
    "bool subgroupBallotBitExtract(uint64_t value, uint index)\n"
    "{\n"
    "    if (index > 63)\n"
    "        return false;\n"
    "    uint64_t mask = 1ul << index;\n"
    "    if (bool((value & mask)) == true)\n"
    "        return true;\n"
    "    return false;\n"
    "}\n"
)


def family_ballot_broadcast() -> list[Case]:
    cases = []
    for vt in all_formats():
        # Vector, boolean and double types are not supported by functions defined in VK_EXT_shader_subgroup_ballot.
        supported_arb = vt.components == 1 and vt.scalar in ("int", "uint", "float")
        for op_index, op_name in enumerate(BROADCAST_OPS):
            name = f"{op_name}_{vt.test_name}"
            for ext_arb in (False, True):
                if ext_arb and not supported_arb:
                    continue
                if ext_arb:
                    ext = (
                        "#extension GL_ARB_shader_ballot: enable\n"
                        "#extension GL_KHR_shader_subgroup_basic: enable\n"
                        "#extension GL_ARB_gpu_shader_int64: enable\n" + vt.extension
                    )
                else:
                    ext = "#extension GL_KHR_shader_subgroup_ballot: enable\n" + vt.extension
                helper = ARB_HELPER if ext_arb else ""
                num_elements = 64 if ext_arb else MAX_SUBGROUP_SIZE
                inputs = f"nonzero:std430:{vt.token}:{vt.components}:{num_elements}"
                req = ",".join(r for r in ("dynid" if op_index == 1 else "", "arb" if ext_arb else "") if r)
                prefix = "subgroups/ballot_broadcast/" + ("ext_shader_subgroup_ballot/" if ext_arb else "") + "compute/"
                spirv = "spirv1.5" if op_index == 1 else None
                shader = compute_shader(ext, vt, ballot_broadcast_src(op_index, vt, ext_arb, False, 0), helper=helper)
                cases.append(Case(prefix + name, shader, "ballot", vt, False, 3, inputs, req=req, spirv=spirv))
                add_graphics(prefix.replace("compute/", "graphics/") + name, ext, vt, ballot_broadcast_src(op_index, vt, ext_arb, False, 0), "ballot", 3, inputs, req=req, helper=helper, spirv=spirv)
                add_mesh(
                    prefix.replace("compute/", "mesh/"),
                    name,
                    ext,
                    vt,
                    ballot_broadcast_src(op_index, vt, ext_arb, False, 0),
                    "ballot",
                    3,
                    inputs,
                    req=req,
                    spirv=spirv,
                    helper=helper,
                    rss_variants=[(False, "")] + [(size, f"_requiredsubgroupsize{size}") for size in (1, 2, 4, 8, 16, 32, 64, 128)],
                )
                add_framebuffer(
                    prefix.replace("compute/", "framebuffer/"),
                    name,
                    ext,
                    vt,
                    ballot_broadcast_src(op_index, vt, ext_arb, False, 0),
                    "ballot",
                    3,
                    req=req,
                    helper=helper,
                    spirv=spirv,
                    inputs=f"nonzero:std140:{vt.token}:{vt.components}:{num_elements}:ubo",
                    joiner="",
                )
                size = 1
                while size <= MAX_SUBGROUP_SIZE:
                    shader = compute_shader(ext, vt, ballot_broadcast_src(op_index, vt, ext_arb, True, size), helper=helper)
                    cases.append(Case(prefix + f"{name}_requiredsubgroupsize{size}", shader, "ballot", vt, size, 3, inputs, req=req, spirv=spirv))
                    size *= 2
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsVoteTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------

# OpType order of the file: all, any, allEqual, (the end of the non-ARB ones), then the ARB spellings
VOTE_OPS = ["subgroupAll", "subgroupAny", "subgroupAllEqual", None, "allInvocationsARB", "anyInvocationARB", "allInvocationsEqualARB"]


def vote_stage_src(op_type: int, vt: VecType, compute: bool = False) -> str:
    op = VOTE_OPS[op_type]
    fmt = vt.glsl
    compute_part = f"{op}(data[gl_SubgroupInvocationID] > 0) ? 0x4 : 0x0" if compute else "0x4"
    if op_type in (0, 4):
        return f"  tempRes = {op}(true) ? 0x1 : 0;\n  tempRes |= {op}(false) ? 0 : 0x1A;\n  tempRes |= {compute_part};\n"
    if op_type in (1, 5):
        return f"  tempRes = {op}(true) ? 0x1 : 0;\n  tempRes |= {op}(false) ? 0 : 0x1A;\n  tempRes |= {compute_part};\n"
    return (
        f"  {fmt} valueEqual = {fmt}(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);\n"
        f"  {fmt} valueNoEqual = {fmt}" + ("(subgroupElect());\n" if vt.is_bool else "(gl_SubgroupInvocationID);\n")
        + f"  tempRes = {op}({fmt}(1)) ? 0x1 : 0;\n"
        "  tempRes |= " + ("0x2" if vt.is_bool else f"{op}({fmt}(gl_SubgroupInvocationID)) ? 0 : 0x2") + ";\n"
        f"  tempRes |= {op}(data[0]) ? 0x4 : 0;\n"
        f"  tempRes |= {op}(valueEqual) ? 0x8 : 0x0;\n"
        f"  tempRes |= {op}(valueNoEqual) ? 0x0 : 0x10;\n"
        "  if (subgroupElect()) tempRes |= 0x2 | 0x10;\n"
    )


FRAG_HELPER_VERTEX = (
    "#version 450\n"
    "void main (void)\n"
    "{\n"
    "  vec2 uv = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));\n"
    "  gl_Position = vec4(uv * 4.0f -2.0f, 0.0f, 1.0f);\n"
    "  gl_PointSize = 1.0f;\n"
    "}\n"
)


def vote_frag_helper_src(op_type: int, vt: VecType) -> str:
    """getStageTestSourceFrag"""
    op = VOTE_OPS[op_type]
    fmt = vt.glsl
    if op_type in (0, 4):
        return f"  tempRes |= {op}(!gl_HelperInvocation) ? 0x0 : 0x1;\n  tempRes |= {op}(false) ? 0 : 0x1A;\n  tempRes |= 0x4;\n"
    if op_type in (1, 5):
        return f"  tempRes |= {op}(gl_HelperInvocation) ? 0x1 : 0x0;\n  tempRes |= {op}(false) ? 0 : 0x1A;\n  tempRes |= 0x4;\n"
    return (
        f"  {fmt} valueEqual = {fmt}(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);\n"
        f"  {fmt} valueNoEqual = {fmt}" + ("(subgroupElect());\n" if vt.is_bool else "(gl_SubgroupInvocationID);\n")
        + f"  tempRes |= {op}({fmt}(1)) ? 0x10 : 0;\n"
        "  tempRes |= " + ("0x2" if vt.is_bool else f"{op}({fmt}(gl_SubgroupInvocationID)) ? 0 : 0x2") + ";\n"
        f"  tempRes |= {op}(data[0]) ? 0x4 : 0;\n"
        f"  tempRes |= {op}(valueEqual) ? 0x8 : 0x0;\n"
        f"  tempRes |= {op}(gl_HelperInvocation) ? 0x0 : 0x1;\n"
        "  if (subgroupElect()) tempRes |= 0x2 | 0x10;\n"
    )


def add_vote_frag_helper(path: str, ext: str, vt: VecType, op_type: int, init: str, req: str) -> None:
    """initFrameBufferProgramsFrag: a fragment shader that also reports whether a helper invocation was in its subgroup (0x40)."""
    arb = op_type > 3
    source = (
        "#version 450\n"
        + ext
        + "layout(location = 0) out uint out_color;\n"
        "layout(set = 0, binding = 0) uniform Buffer1\n"
        "{\n"
        f"  {vt.glsl} data[{MAX_SUBGROUP_SIZE}];\n"
        "};\n"
        "void main()\n"
        "{\n"
        "  uint tempRes = 0u;\n"
        "  if (dFdx(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) - dFdy(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) > 0.0f)\n"
        "  {\n"
        "    tempRes |= 0x20;\n"
        "  }\n"
        + ("  bool helper = anyInvocationARB(gl_HelperInvocation);\n" if arb else "  bool helper = subgroupAny(gl_HelperInvocation);\n")
        + "  if (helper)\n"
        "  {\n"
        "    tempRes |= 0x40;\n"
        "  }\n"
        + vote_frag_helper_src(op_type, vt)
        + "  out_color = tempRes;\n"
        "}\n"
    )
    programs = {"vert": ("vert", FRAG_HELPER_VERTEX), "fragment": ("frag", source)}
    FRAMEBUFFER.append(FramebufferCase(path, "frag", programs, "vote", vt, 0, f"{init}:std140:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}:ubo", req, None))


def family_vote() -> list[Case]:
    cases = []
    for vt in all_formats():
        for op_type in range(len(VOTE_OPS)):
            if op_type == 3:
                continue
            arb = op_type > 3
            # Skip the non-nonvector tests because VK_EXT_shader_subgroup_vote functions only supports boolean scalar arguments.
            if arb and vt.components != 1:
                continue
            # Skip non-boolean formats when testing allInvocationsEqualARB(bool value).
            if op_type == 6 and not (vt.is_bool and vt.components == 1):
                continue
            # Skip the typed tests for all but subgroupAllEqual() and allInvocationsEqualARB()
            if not (vt.scalar == "uint" and vt.components == 1) and op_type not in (2, 6):
                continue
            name = VOTE_OPS[op_type].lower() + "_" + vt.test_name
            ext = ("#extension GL_ARB_shader_group_vote: enable\n#extension GL_KHR_shader_subgroup_basic: enable\n" if arb else "#extension GL_KHR_shader_subgroup_vote: enable\n") + vt.extension
            shader = compute_shader(ext, vt, vote_stage_src(op_type, vt, compute=True))
            init = "zero" if op_type in (2, 6) else "nonzero"
            inputs = f"{init}:std430:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}"
            prefix = "subgroups/vote/" + ("ext_shader_subgroup_vote/" if arb else "") + "compute/"
            add_graphics(prefix.replace("compute/", "graphics/") + name, ext, vt, vote_stage_src(op_type, vt), "vote", 0x1F, inputs, req="arbvote" if arb else "")
            add_mesh(prefix.replace("compute/", "mesh/"), name, ext, vt, vote_stage_src(op_type, vt), "vote", 0x1F, inputs, req="arbvote" if arb else "")
            add_framebuffer(prefix.replace("compute/", "framebuffer/"), name, ext, vt, vote_stage_src(op_type, vt), "vote", 0x1F, req="arbvote" if arb else "", inputs=f"{init}:std140:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}:ubo")
            add_vote_frag_helper(prefix.replace("compute/", "frag_helper/") + name + "_fragment", ext, vt, op_type, init, "arbvote" if arb else "")
            for rss in (False, True):
                cases.append(Case(prefix + name + ("_requiredsubgroupsize" if rss else ""), shader, "vote", vt, rss, 0x1F, inputs, req="arbvote" if arb else ""))
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsBallotOtherTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------

BALLOT_OTHER_OPS = [
    "subgroupInverseBallot",
    "subgroupBallotBitExtract",
    "subgroupBallotBitCount",
    "subgroupBallotInclusiveBitCount",
    "subgroupBallotExclusiveBitCount",
    "subgroupBallotFindLSB",
    "subgroupBallotFindMSB",
]


def ballot_other_src(op_index: int) -> str:
    bdy = (
        "  uvec4 allOnes = uvec4(0xFFFFFFFF);\n"
        "  uvec4 allZeros = uvec4(0);\n"
        "  uint tempResult = 0;\n"
        "#define MAKE_HIGH_BALLOT_RESULT(i) uvec4("
        "i >= 32 ? 0 : (0xFFFFFFFF << i), "
        "i >= 64 ? 0 : (0xFFFFFFFF << ((i < 32) ? 0 : (i - 32))), "
        "i >= 96 ? 0 : (0xFFFFFFFF << ((i < 64) ? 0 : (i - 64))), "
        "i >= 128 ? 0 : (0xFFFFFFFF << ((i < 96) ? 0 : (i - 96))))\n"
        "#define MAKE_SINGLE_BIT_BALLOT_RESULT(i) uvec4("
        "i >= 32 ? 0 : 0x1 << i, "
        "i < 32 || i >= 64 ? 0 : 0x1 << (i - 32), "
        "i < 64 || i >= 96 ? 0 : 0x1 << (i - 64), "
        "i < 96 || i >= 128 ? 0 : 0x1 << (i - 96))\n"
    )
    if op_index == 0:
        bdy += (
            "  tempResult |= subgroupInverseBallot(allOnes) ? 0x1 : 0;\n"
            "  tempResult |= subgroupInverseBallot(allZeros) ? 0 : 0x2;\n"
            "  tempResult |= subgroupInverseBallot(subgroupBallot(true)) ? 0x4 : 0;\n"
            "  tempResult |= 0x8;\n"
        )
    elif op_index == 1:
        bdy += (
            "  tempResult |= subgroupBallotBitExtract(allOnes, gl_SubgroupInvocationID) ? 0x1 : 0;\n"
            "  tempResult |= subgroupBallotBitExtract(allZeros, gl_SubgroupInvocationID) ? 0 : 0x2;\n"
            "  tempResult |= subgroupBallotBitExtract(subgroupBallot(true), gl_SubgroupInvocationID) ? 0x4 : 0;\n"
            "  tempResult |= 0x8;\n"
            "  for (uint i = 0; i < gl_SubgroupSize; i++)\n"
            "  {\n"
            "    if (!subgroupBallotBitExtract(allOnes, gl_SubgroupInvocationID))\n"
            "    {\n"
            "      tempResult &= ~0x8;\n"
            "    }\n"
            "  }\n"
        )
    elif op_index == 2:
        bdy += (
            "  /* To ensure a 32-bit computation, use a variable with default highp precision. */\n"
            "  uint SubgroupSize = gl_SubgroupSize;\n"
            "  tempResult |= SubgroupSize == subgroupBallotBitCount(allOnes) ? 0x1 : 0;\n"
            "  tempResult |= 0 == subgroupBallotBitCount(allZeros) ? 0x2 : 0;\n"
            "  tempResult |= 0 < subgroupBallotBitCount(subgroupBallot(true)) ? 0x4 : 0;\n"
            "  tempResult |= 0 == subgroupBallotBitCount(MAKE_HIGH_BALLOT_RESULT(SubgroupSize)) ? 0x8 : 0;\n"
        )
    elif op_index == 3:
        bdy += (
            "  uint inclusiveOffset = gl_SubgroupInvocationID + 1;\n"
            "  tempResult |= inclusiveOffset == subgroupBallotInclusiveBitCount(allOnes) ? 0x1 : 0;\n"
            "  tempResult |= 0 == subgroupBallotInclusiveBitCount(allZeros) ? 0x2 : 0;\n"
            "  tempResult |= 0 < subgroupBallotInclusiveBitCount(subgroupBallot(true)) ? 0x4 : 0;\n"
            "  tempResult |= 0x8;\n"
            "  for (uint i = 0; i < 128; i++)\n"
            "  {\n"
            "    uint ref = inclusiveOffset - min(inclusiveOffset, i);\n"
            "    uvec4 b = MAKE_HIGH_BALLOT_RESULT(i);\n"
            "    uint inclusiveBitCount = subgroupBallotInclusiveBitCount(b);\n"
            "    if (inclusiveBitCount != ref)\n"
            "    {\n"
            "      tempResult &= ~0x8;\n"
            "    }\n"
            "  }\n"
        )
    elif op_index == 4:
        bdy += (
            "  uint exclusiveOffset = gl_SubgroupInvocationID;\n"
            "  tempResult |= exclusiveOffset == subgroupBallotExclusiveBitCount(allOnes) ? 0x1 : 0;\n"
            "  tempResult |= 0 == subgroupBallotExclusiveBitCount(allZeros) ? 0x2 : 0;\n"
            "  tempResult |= 0x4;\n"
            "  tempResult |= 0x8;\n"
            "  for (uint i = 0; i < 128; i++)\n"
            "  {\n"
            "    uint ref = exclusiveOffset - min(exclusiveOffset, i);\n"
            "    uvec4 b = MAKE_HIGH_BALLOT_RESULT(i);\n"
            "    uint exclusiveBitCount = subgroupBallotExclusiveBitCount(b);\n"
            "    if (exclusiveBitCount != ref)\n"
            "    {\n"
            "      tempResult &= ~0x8;\n"
            "    }\n"
            "  }\n"
        )
    elif op_index == 5:
        bdy += (
            "  tempResult |= 0 == subgroupBallotFindLSB(allOnes) ? 0x1 : 0;\n"
            "  if (subgroupElect())\n"
            "  {\n"
            "    tempResult |= 0x2;\n"
            "  }\n"
            "  else\n"
            "  {\n"
            "    tempResult |= 0 < subgroupBallotFindLSB(subgroupBallot(true)) ? 0x2 : 0;\n"
            "  }\n"
            "  tempResult |= gl_SubgroupSize > subgroupBallotFindLSB(subgroupBallot(true)) ? 0x4 : 0;\n"
            "  tempResult |= 0x8;\n"
            "  for (uint i = 0; i < gl_SubgroupSize; i++)\n"
            "  {\n"
            "    if (i != subgroupBallotFindLSB(MAKE_HIGH_BALLOT_RESULT(i)))\n"
            "    {\n"
            "      tempResult &= ~0x8;\n"
            "    }\n"
            "  }\n"
        )
    else:
        bdy += (
            "  tempResult |= (gl_SubgroupSize - 1) == subgroupBallotFindMSB(allOnes) ? 0x1 : 0;\n"
            "  if (subgroupElect())\n"
            "  {\n"
            "    tempResult |= 0x2;\n"
            "  }\n"
            "  else\n"
            "  {\n"
            "    tempResult |= 0 < subgroupBallotFindMSB(subgroupBallot(true)) ? 0x2 : 0;\n"
            "  }\n"
            "  tempResult |= gl_SubgroupSize > subgroupBallotFindMSB(subgroupBallot(true)) ? 0x4 : 0;\n"
            "  tempResult |= 0x8;\n"
            "  for (uint i = 0; i < gl_SubgroupSize; i++)\n"
            "  {\n"
            "    if (i != subgroupBallotFindMSB(MAKE_SINGLE_BIT_BALLOT_RESULT(i)))\n"
            "    {\n"
            "      tempResult &= ~0x8;\n"
            "    }\n"
            "  }\n"
        )
    return bdy + "  tempRes = tempResult;\n"


def ballot_other_graphics_declarations(stage: int) -> str:
    if stage == GRAPHICS_STAGE_COUNT:
        return "layout(location = 0) out uint result;\nprecision highp int;\n"
    return f"layout(set = 0, binding = {stage}, std430) buffer Buffer1\n{{\n  uint result[];\n}};\n"


def ballot_other_framebuffer_declarations(stage_index: int) -> str:
    return ["layout(location = 0) out float result;\n", "layout(location = 0) out float out_color;\n", "layout(location = 0) out float out_color[];\n", "layout(location = 0) out float out_color;\n"][stage_index]


def family_ballot_other() -> list[Case]:
    cases = []
    vt = VecType("uint", 1)
    ext = "#extension GL_KHR_shader_subgroup_ballot: enable\n"
    result_only = "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"
    for op_index, op_name in enumerate(BALLOT_OTHER_OPS):
        name = op_name.lower()
        src = ballot_other_src(op_index)
        shader = compute_shader(ext, vt, src, declarations=result_only)
        for rss in (False, True):
            cases.append(Case(f"subgroups/ballot_other/compute/{name}" + ("_requiredsubgroupsize" if rss else ""), shader, "ballot", vt, rss, 0xF, ""))
        add_graphics(f"subgroups/ballot_other/graphics/{name}", ext, vt, src, "ballot", 0xF, "", decl=ballot_other_graphics_declarations)
        add_framebuffer("subgroups/ballot_other/framebuffer/", name, ext, vt, src, "ballot", 0xF, decl=ballot_other_framebuffer_declarations, inputs="")
        add_mesh("subgroups/ballot_other/mesh/", name, ext, vt, src, "ballot", 0xF, "", declarations=result_only)
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsShapeTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------


def shape_test_src(clustered: bool) -> str:
    src = "  uint tempResult = 0x1;\n  uvec4 mask = subgroupBallot(true);\n"
    if clustered:
        size = 1
        while size <= MAX_SUBGROUP_SIZE:
            src += (
                f"  if (gl_SubgroupSize >= {size})\n"
                "  {\n"
                "    uvec4 contribution = uvec4(0);\n"
                "    const uint modID = gl_SubgroupInvocationID % 32;\n"
                "    switch (gl_SubgroupInvocationID / 32)\n"
                "    {\n"
                "    case 0: contribution.x = 1 << modID; break;\n"
                "    case 1: contribution.y = 1 << modID; break;\n"
                "    case 2: contribution.z = 1 << modID; break;\n"
                "    case 3: contribution.w = 1 << modID; break;\n"
                "    }\n"
                f"    uvec4 result = subgroupClusteredOr(contribution, {size});\n"
                f"    uint rootID = gl_SubgroupInvocationID & ~({size - 1});\n"
                f"    for (uint i = 0; i < {size}; i++)\n"
                "    {\n"
                "      uint nextID = rootID + i;\n"
                "      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))\n"
                "      {\n"
                "        tempResult = 0;\n"
                "      }\n"
                "    }\n"
                "  }\n"
            )
            size *= 2
    else:
        src += (
            "  uint cluster[4] =\n"
            "  {\n"
            "    subgroupQuadBroadcast(gl_SubgroupInvocationID, 0),\n"
            "    subgroupQuadBroadcast(gl_SubgroupInvocationID, 1),\n"
            "    subgroupQuadBroadcast(gl_SubgroupInvocationID, 2),\n"
            "    subgroupQuadBroadcast(gl_SubgroupInvocationID, 3)\n"
            "  };\n"
            "  uint rootID = gl_SubgroupInvocationID & ~0x3;\n"
            "  for (uint i = 0; i < 4; i++)\n"
            "  {\n"
            "    uint nextID = rootID + i;\n"
            "    if (subgroupBallotBitExtract(mask, nextID) && (cluster[i] != nextID))\n"
            "    {\n"
            "      tempResult = mask.x;\n"
            "    }\n"
            "  }\n"
        )
    return src + "  tempRes = tempResult;\n"


def family_shape() -> list[Case]:
    cases = []
    vt = VecType("uint", 1)
    result_only = "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"
    for clustered in (True, False):
        name = "clustered" if clustered else "quad"
        ext = ("#extension GL_KHR_shader_subgroup_clustered: enable\n" if clustered else "#extension GL_KHR_shader_subgroup_quad: enable\n") + "#extension GL_KHR_shader_subgroup_ballot: enable\n"
        src = shape_test_src(clustered)
        shader = compute_shader(ext, vt, src, declarations=result_only)
        for rss in (False, True):
            cases.append(Case(f"subgroups/shape/compute/{name}" + ("_requiredsubgroupsize" if rss else ""), shader, name, vt, rss, 1, ""))
        add_graphics(f"subgroups/shape/graphics/{name}", ext, vt, src, name, 1, "", decl=ballot_other_graphics_declarations)
        add_framebuffer("subgroups/shape/framebuffer/", name, ext, vt, src, name, 1, decl=ballot_other_framebuffer_declarations, inputs="")
        add_mesh("subgroups/shape/mesh/", name, ext, vt, src, name, 1, "", declarations=result_only)
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsBuiltinMaskVarTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------

# (SPIR-V builtin name, GLSL comparison) of TestTypeSpirvBuiltins and TestTypeMathOps
BUILTIN_MASKS = [("SubgroupEqMask", "=="), ("SubgroupGeMask", ">="), ("SubgroupGtMask", ">"), ("SubgroupLeMask", "<="), ("SubgroupLtMask", "<")]


def builtin_mask_src(builtin: str, comp: str) -> str:
    return (
        "  uint tempResult = 0x1;\n"
        "  uvec4 mask = subgroupBallot(true);\n"
        f"  const uvec4 var = gl_{builtin};\n"
        "  for (uint i = 0; i < gl_SubgroupSize; i++)\n"
        "  {\n"
        f"    if ((i {comp} gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))\n"
        "    {\n"
        "      tempResult = 0;\n"
        "    }\n"
        "  }\n"
        "  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);\n"
        "  if (subgroupBallotBitCount(var) != c)\n"
        "  {\n"
        "    tempResult = 0;\n"
        "  }\n"
        "  tempRes = tempResult;\n"
    )


def builtin_mask_graphics_declarations(stage: int) -> str:
    if stage == GRAPHICS_STAGE_COUNT:
        return "layout(location = 0) out uint result;\n"
    return f"layout(set = 0, binding = {stage}, std430) buffer Output\n{{\n  uint result[];\n}};\n"


def family_builtin_mask_var() -> list[Case]:
    cases = []
    vt = VecType("uint", 1)
    ext = "#extension GL_KHR_shader_subgroup_ballot: enable\n"
    result_only = "layout(set = 0, binding = 0, std430) buffer Output\n{\n  uint result[];\n};\n"
    for builtin, comp in BUILTIN_MASKS:
        name = builtin.lower()
        src = builtin_mask_src(builtin, comp)
        shader = compute_shader(ext, vt, src, declarations=result_only)
        for rss in (False, True):
            cases.append(Case(f"subgroups/builtin_mask_var/compute/{name}" + ("_requiredsubgroupsize" if rss else ""), shader, "ballot", vt, rss, 1, ""))
        add_graphics(f"subgroups/builtin_mask_var/graphics/{name}", ext, vt, src, "ballot", 1, "", decl=builtin_mask_graphics_declarations)
        add_framebuffer("subgroups/builtin_mask_var/framebuffer/", name, ext, vt, src, "ballot", 1, decl=ballot_other_framebuffer_declarations, inputs="")
        add_mesh("subgroups/builtin_mask_var/mesh/", name, ext, vt, src, "ballot", 1, "", declarations=result_only)
    return cases


def ballot_mask_arb_src(index: int) -> str:
    name = BUILTIN_MASKS[index][0].replace("Subgroup", "gl_SubGroup") + "ARB"
    loop = lambda a, b: (
        "  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {\n"
        "    uint64_t mask = uint64_t(1) << i;\n"
        f"    if (i {a} gl_SubGroupInvocationARB && (value & mask) == 0)\n"
        "       temp = false;\n"
        f"    if (i {b} gl_SubGroupInvocationARB && (value & mask) != 0)\n"
        "       temp = false;\n"
        "  };\n"
    )
    body = f"  uint64_t value = {name};\n  bool temp = true;\n"
    body += [
        "  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;\n  temp = (value & mask) != 0;\n",
        loop(">=", "<"),
        loop(">", "<="),
        loop("<=", ">"),
        loop("<", ">="),
    ][index]
    return body + "  uint tempResult = temp ? 0xf : 0x2;\n  tempRes = tempResult;\n"


def family_ballot_mask_arb() -> list[Case]:
    cases = []
    vt = VecType("uint", 1)
    ext = "#extension GL_ARB_shader_ballot: enable\n#extension GL_ARB_gpu_shader_int64: enable\n"
    result_only = "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"
    prefix = "subgroups/ballot_mask/ext_shader_subgroup_ballot/"
    for index, (builtin, _) in enumerate(BUILTIN_MASKS):
        name = (builtin + "ARB").replace("Subgroup", "gl_subgroup").lower()
        src = ballot_mask_arb_src(index)
        shader = compute_shader(ext, vt, src, declarations=result_only)
        for rss in (False, True):
            cases.append(Case(prefix + f"compute/{name}" + ("_requiredsubgroupsize" if rss else ""), shader, "ballot", vt, rss, 0xF, "", req="arb"))
        add_graphics(prefix + f"graphics/{name}", ext, vt, src, "ballot", 0xF, "", req="arb", decl=ballot_other_graphics_declarations)
        add_framebuffer(prefix + "framebuffer/", name, ext, vt, src, "ballot", 0xF, req="arb", decl=ballot_other_framebuffer_declarations, inputs="")
        add_mesh(prefix + "mesh/", name, ext, vt, src, "ballot", 0xF, "", req="arb", declarations=result_only)
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsBallotTests.cpp
# ---------------------------------------------------------------------------------------------------------------------------


def shared_memory_ballot_helper(arb: bool) -> str:
    """getSharedMemoryBallotHelper / getSharedMemoryBallotHelperARB."""
    return (
        "shared uvec4 superSecretComputeShaderHelper[gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z];\n"
        + ("uint64_t" if arb else "uvec4")
        + " sharedMemoryBallot(bool vote)\n"
        "{\n"
        "  uint groupOffset = gl_SubgroupID;\n"
        "  // One invocation in the group 0's the whole group's data\n"
        "  if (subgroupElect())\n"
        "  {\n"
        "    superSecretComputeShaderHelper[groupOffset] = uvec4(0);\n"
        "  }\n"
        "  subgroupMemoryBarrierShared();\n"
        "  if (vote)\n"
        "  {\n"
        "    const highp uint invocationId = gl_SubgroupInvocationID % 32;\n"
        "    const highp uint bitToSet = 1u << invocationId;\n"
        "    switch (gl_SubgroupInvocationID / 32)\n"
        "    {\n"
        "    case 0: atomicOr(superSecretComputeShaderHelper[groupOffset].x, bitToSet); break;\n"
        "    case 1: atomicOr(superSecretComputeShaderHelper[groupOffset].y, bitToSet); break;\n"
        "    case 2: atomicOr(superSecretComputeShaderHelper[groupOffset].z, bitToSet); break;\n"
        "    case 3: atomicOr(superSecretComputeShaderHelper[groupOffset].w, bitToSet); break;\n"
        "    }\n"
        "  }\n"
        "  subgroupMemoryBarrierShared();\n"
        + ("  return packUint2x32(superSecretComputeShaderHelper[groupOffset].xy);\n" if arb else "  return superSecretComputeShaderHelper[groupOffset];\n")
        + "}\n"
    )


def ballot_src(arb: bool, compute: bool) -> str:
    """getBodySource"""
    cmp_str = "uint64_t(0) == ballotARB" if arb else "uvec4(0) == subgroupBallot"
    if compute:
        cmp_b = "ballotARB" if arb else "subgroupBallot"
        return (
            "  uint tempResult = 0;\n"
            f"  tempResult |= sharedMemoryBallot(true) == {cmp_b}(true) ? 0x1 : 0;\n"
            "  bool bData = data[gl_SubgroupInvocationID] != 0;\n"
            f"  tempResult |= sharedMemoryBallot(bData) == {cmp_b}(bData) ? 0x2 : 0;\n"
            f"  tempResult |= {cmp_str}(false) ? 0x4 : 0;\n"
            "  tempRes = tempResult;\n"
        )
    return (
        "  uint tempResult = 0;\n"
        f"  tempResult |= !bool({cmp_str}(true)) ? 0x1 : 0;\n"
        "  bool bData = data[gl_SubgroupInvocationID] != 0;\n"
        f"  tempResult |= !bool({cmp_str}(bData)) ? 0x2 : 0;\n"
        f"  tempResult |= {cmp_str}(false) ? 0x4 : 0;\n"
        "  tempRes = tempResult;\n"
    )


def family_ballot() -> list[Case]:
    cases = []
    vt = VecType("uint", 1)
    inputs = f"nonzero:std430:{vt.token}:{vt.components}:{MAX_SUBGROUP_SIZE}"
    for arb in (False, True):
        ext = (
            "#extension GL_ARB_shader_ballot: enable\n#extension GL_ARB_gpu_shader_int64: enable\n#extension GL_KHR_shader_subgroup_basic: enable\n"
            if arb
            else "#extension GL_KHR_shader_subgroup_ballot: enable\n"
        )
        req = "arb" if arb else ""
        prefix = "subgroups/ballot/" + ("ext_shader_subgroup_ballot/" if arb else "")
        compute_src = ballot_src(arb, True)
        stage_src = ballot_src(arb, False)
        shader = compute_shader(ext, vt, compute_src, helper=shared_memory_ballot_helper(arb))
        for rss in (False, True):
            cases.append(Case(prefix + "compute/compute" + ("_requiredsubgroupsize" if rss else ""), shader, "ballot", vt, rss, 0x7, inputs, req=req))
        for stage in MESH_STAGES:
            programs = mesh_programs(stage, ext, vt, stage_src, "", None)
            for rss, suffix in ((False, ""), (True, "_requiredsubgroupsize")):
                MESH.append(MeshCase(prefix + f"mesh/{stage}{suffix}_{stage}", stage, programs, "ballot", vt, rss, 0x7, inputs, req, "spirv1.4"))
        add_graphics(prefix + "graphics/graphic", ext, vt, stage_src, "ballot", 0x7, inputs, req=req)
        add_framebuffer(prefix + "framebuffer/", "", ext, vt, stage_src, "ballot", 0x7, req=req, joiner="")
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsBasicTests.cpp: only subgroupElect in compute and mesh/task, the one operation that needs no extra buffers or image
# ---------------------------------------------------------------------------------------------------------------------------

BASIC_ELECTED_VALUE = 42
BASIC_UNELECTED_VALUE = 13


def family_basic_elect() -> list[Case]:
    cases = []
    vt = VecType("uint", 1)
    ext = "#extension GL_KHR_shader_subgroup_basic: enable\n"
    result_only = "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"
    src = (
        f"  uint value = {BASIC_UNELECTED_VALUE};\n"
        "  if (subgroupElect())\n"
        "  {\n"
        f"    value = {BASIC_ELECTED_VALUE};\n"
        "  }\n"
        f"  uvec4 bits = bitCount(sharedMemoryBallot(value == {BASIC_ELECTED_VALUE}));\n"
        "  tempRes = bits.x + bits.y + bits.z + bits.w;\n"
    )
    helper = shared_memory_ballot_helper(False)
    shader = compute_shader(ext, vt, src, helper=helper, declarations=result_only)
    for rss in (False, True):
        cases.append(Case("subgroups/basic/compute/subgroupelect" + ("_requiredsubgroupsize" if rss else ""), shader, "basic", vt, rss, 1, ""))
    add_mesh("subgroups/basic/mesh/", "subgroupelect", ext, vt, src, "basic", 1, "", helper=helper, declarations=result_only)
    return cases


BASIC_BARRIER_OPS = [
    "subgroupBarrier",
    "subgroupMemoryBarrier",
    "subgroupMemoryBarrierBuffer",
    "subgroupMemoryBarrierShared",
    "subgroupMemoryBarrierImage",
]
BASIC_BARRIER_INPUTS = "none:std430:uint:1:4096|nonzero:std430:uint:1:1|none:packed:uint:1:4096:image"
BASIC_BARRIER_HEADER = "#extension GL_KHR_shader_subgroup_basic: enable\n"


def basic_barrier_test_src(op: str) -> str:
    """The `body` of `getTestString` for the barrier operations, compute and mesh flavour."""
    if op == "subgroupMemoryBarrierShared":
        return (
            "  if (subgroupElect())\n"
            "  {\n"
            "    tempShared[localId] = value;\n"
            "  }\n"
            "  subgroupMemoryBarrierShared();\n"
            "  tempResult = tempShared[localId];\n"
        )
    if op == "subgroupMemoryBarrierImage":
        return (
            "  if (subgroupElect())\n"
            "  {\n"
            "    imageStore(tempImage, ivec2(id, 0), ivec4(value));\n"
            "  }\n"
            "  subgroupMemoryBarrierImage();\n"
            "  tempResult = imageLoad(tempImage, ivec2(id, 0)).x;\n"
        )
    return (
        "  if (subgroupElect())\n"
        "  {\n"
        "    tempBuffer[id] = value;\n"
        "  }\n"
        f"  {op}();\n"
        "  tempResult = tempBuffer[id];\n"
    )


def basic_barrier_shader(op: str, extensions: str = "", layouts: str = "", body: str = "") -> str:
    """`nonElectTemplate` of initComputeOrMeshPrograms, specialized."""
    return (
        "#version 450\n"
        + BASIC_BARRIER_HEADER
        + extensions
        + "layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;\n"
        + layouts
        + "layout (set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"
        + "layout (set = 0, binding = 1, std430) buffer Buffer2\n{\n  uint tempBuffer[];\n};\n"
        + "layout (set = 0, binding = 2, std430) buffer Buffer3\n{\n  uint value;\n};\n"
        + "layout (set = 0, binding = 3, r32ui) uniform uimage2D tempImage;\n"
        + "shared uint tempShared[gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z];\n"
        + "\n"
        + "void main (void)\n{\n"
        + "  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;\n"
        + "  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;\n"
        + "  uint localId = gl_SubgroupID;\n"
        + "  uint id = globalSize.x * ((globalSize.y * gl_WorkGroupID.z) + gl_WorkGroupID.y) + gl_WorkGroupID.x + localId;\n"
        + "  uint tempResult = 0;\n"
        + basic_barrier_test_src(op)
        + "  result[offset] = tempResult;\n"
        + body
        + "}\n"
    )


def family_basic_barriers() -> list[Case]:
    """subgroupBarrier and the memory barriers, compute and mesh/task (the framebuffer, graphics and ray tracing flavours need more host plumbing)."""
    cases = []
    vt = VecType("uint", 1)
    for op in BASIC_BARRIER_OPS:
        name = op.lower()
        shader = basic_barrier_shader(op)
        for rss in (False, True):
            cases.append(Case("subgroups/basic/compute/" + name + ("_requiredsubgroupsize" if rss else ""), shader, "basic", vt, rss, 0, BASIC_BARRIER_INPUTS, check_input=1))
        for stage in MESH_STAGES:
            ext = "#extension GL_EXT_mesh_shader : enable\n"
            if stage == "mesh":
                programs = {
                    "mesh": ("mesh", basic_barrier_shader(op, ext, "layout (points) out;\nlayout (max_vertices=1, max_primitives=1) out;\n", "  SetMeshOutputsEXT(0u, 0u);\n"))
                }
            else:
                programs = {
                    "task": ("task", basic_barrier_shader(op, ext, "", "  EmitMeshTasksEXT(0, 0, 0);\n")),
                    "mesh": ("mesh", MESH_NO_SUBGROUPS),
                }
            for rss in (False, True):
                suffix = "_requiredsubgroupsize" if rss else ""
                MESH.append(MeshCase(f"subgroups/basic/mesh/{name}{suffix}_{stage}", stage, programs, "basic", vt, rss, 0, BASIC_BARRIER_INPUTS, "", "spirv1.4", check_input=1))
    return cases


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsBuiltinVarTests.cpp: compute and mesh/task (the result is a uvec4 per invocation, checked by the builtin variable)
# ---------------------------------------------------------------------------------------------------------------------------

BUILTIN_VAR_TESTS = [("SubgroupSize", "size", True), ("SubgroupInvocationID", "invocation", True), ("NumSubgroups", "num", False), ("SubgroupID", "id", False)]
BUILTIN_VAR_VALUE = "uvec4(gl_SubgroupSize, gl_SubgroupInvocationID, gl_NumSubgroups, gl_SubgroupID)"


def family_builtin_var() -> list[Case]:
    cases = []
    vt = VecType("uint", 1)
    compute_src = (
        "#version 450\n"
        "#extension GL_KHR_shader_subgroup_basic: enable\n"
        "layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;\n"
        "layout(set = 0, binding = 0, std430) buffer Output\n{\n  uvec4 result[];\n};\n"
        "\n"
        "void main (void)\n{\n"
        "  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;\n"
        "  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;\n"
        f"  result[offset] = {BUILTIN_VAR_VALUE};\n"
        "}\n"
    )
    mesh_ext = "#extension GL_KHR_shader_subgroup_basic : require\n"
    declarations = "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uvec4 result[];\n};\n"
    for upstream_name, token, all_stages in BUILTIN_VAR_TESTS:
        lower = upstream_name.lower()
        spec_extra = f"rescomps=4;builtin={token}"
        for rss in (False, True):
            suffix = "_requiredsubgroupsize" if rss else ""
            name = f"{lower}_compute{suffix}" if all_stages else f"{lower}{suffix}"
            case = Case(f"subgroups/builtin_var/compute/{name}", compute_src, "none", vt, rss, 0, "", spirv="spirv1.3")
            case.spec += f";{spec_extra}"
            cases.append(case)
        for rss in (False, True):
            suffix = "_requiredsubgroupsize" if rss else ""
            for stage in MESH_STAGES:
                programs = mesh_programs(stage, mesh_ext, vt, f"  tempRes = {BUILTIN_VAR_VALUE};\n", "", declarations, "  uvec4 tempRes;\n")
                name = f"{lower}_{stage}{suffix}" if all_stages else f"{lower}{suffix}_{stage}"
                mesh_case = MeshCase(f"subgroups/builtin_var/mesh/{name}", stage, programs, "none", vt, rss, 0, "", "", "spirv1.4")
                mesh_case.spec += f";{spec_extra}"
                MESH.append(mesh_case)
    return cases


BUILTIN_VAR_FB_VALUE = "vec4(gl_SubgroupSize, gl_SubgroupInvocationID + 1024, 0.0f, 0.0f)"
BUILTIN_VAR_FB_FRAGMENT = (
    "#version 450\n"
    "layout(location = 0) in vec4 in_color;\n"
    "layout(location = 0) out uvec4 out_color;\n"
    "void main()\n"
    "{\n"
    "    out_color = uvec4(in_color);\n"
    "}\n"
)
BUILTIN_VAR_FB_VERTEX_PASS = (
    "#version 450\n"
    "layout(location = 0) in highp vec4 in_position;\n"
    "void main (void)\n"
    "{\n"
    "  gl_Position = in_position;\n"
    "  gl_PointSize = 1.0f;\n"
    "}\n"
)


def builtin_var_fb_programs(stage: str) -> dict[str, tuple[str, str]]:
    """initFrameBufferPrograms of vktSubgroupsBuiltinVarTests.cpp: the whole pipeline is the case's own, the result is a vec4 per pixel (written as uvec4)."""
    basic = "#extension GL_KHR_shader_subgroup_basic: enable\n"
    tess = "#extension GL_EXT_tessellation_shader : require\n"
    programs = {"fragment": ("frag", BUILTIN_VAR_FB_FRAGMENT)}
    if stage == "vert":
        programs["vert"] = (
            "vert",
            "#version 450\n" + basic + "layout(location = 0) out vec4 out_color;\nlayout(location = 0) in highp vec4 in_position;\n\n"
            "void main (void)\n{\n"
            f"  out_color = vec4(gl_SubgroupSize, gl_SubgroupInvocationID + 1024, 1.0f, 1.0f);\n"
            "  gl_Position = in_position;\n  gl_PointSize = 1.0f;\n}\n",
        )
        return programs
    programs["vert"] = ("vert", BUILTIN_VAR_FB_VERTEX_PASS)
    if stage == "tese":
        programs["tesc"] = (
            "tesc",
            "#version 450\n" + tess + "layout(vertices = 2) out;\nlayout(location = 0) out vec4 out_color[];\n"
            "void main (void)\n{\n  if (gl_InvocationID == 0)\n  {\n    gl_TessLevelOuter[0] = 1.0f;\n    gl_TessLevelOuter[1] = 1.0f;\n  }\n"
            "  out_color[gl_InvocationID] = vec4(0.0f);\n  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n}\n",
        )
        programs["tese"] = (
            "tese",
            "#version 450\n" + basic + tess + "layout(isolines, equal_spacing, ccw ) in;\nlayout(location = 0) in vec4 in_color[];\nlayout(location = 0) out vec4 out_color;\n\n"
            "void main (void)\n{\n  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);\n"
            f"  out_color = {BUILTIN_VAR_FB_VALUE};\n}}\n",
        )
    elif stage == "tesc":
        programs["tesc"] = (
            "tesc",
            "#version 450\n" + tess + basic + "layout(vertices = 2) out;\nlayout(location = 0) out vec4 out_color[];\n"
            "void main (void)\n{\n  if (gl_InvocationID == 0)\n  {\n    gl_TessLevelOuter[0] = 1.0f;\n    gl_TessLevelOuter[1] = 1.0f;\n  }\n"
            f"  out_color[gl_InvocationID] = {BUILTIN_VAR_FB_VALUE};\n  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n}}\n",
        )
        programs["tese"] = (
            "tese",
            "#version 450\n" + basic + tess + "layout(isolines, equal_spacing, ccw ) in;\nlayout(location = 0) in vec4 in_color[];\nlayout(location = 0) out vec4 out_color;\n\n"
            "void main (void)\n{\n  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);\n  out_color = in_color[0];\n}\n",
        )
    else:
        programs["geom"] = (
            "geom",
            "#version 450\n" + basic + "layout(points) in;\nlayout(points, max_vertices = 1) out;\nlayout(location = 0) out vec4 out_color;\n"
            f"void main (void)\n{{\n  out_color = {BUILTIN_VAR_FB_VALUE};\n  gl_Position = gl_in[0].gl_Position;\n  gl_PointSize = gl_in[0].gl_PointSize;\n"
            "  EmitVertex();\n  EndPrimitive();\n}\n",
        )
    return programs


def family_builtin_var_framebuffer() -> list[Case]:
    vt = VecType("uint", 1)
    for upstream_name, token in (("SubgroupSize", "size"), ("SubgroupInvocationID", "invocation")):
        for stage_name, stage in FB_STAGES:
            case = FramebufferCase(f"subgroups/builtin_var/framebuffer/{upstream_name.lower()}_{stage_name}", stage, builtin_var_fb_programs(stage), "none", vt, 0, "", "", None)
            case.spec += f";own=1;rescomps=4;builtin={token}"
            FRAMEBUFFER.append(case)
    return []


# ---------------------------------------------------------------------------------------------------------------------------
# vktSubgroupsSizeControlTests.cpp: the compute cases
# ---------------------------------------------------------------------------------------------------------------------------

SIZE_CONTROL_REQUIRE_FULL_SHADER = (
    "#version 450\n"
    "#extension GL_KHR_shader_subgroup_basic: enable\n"
    "#extension GL_KHR_shader_subgroup_ballot: enable\n"
    "layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;\n"
    "layout(set = 0, binding = 0, std430) buffer Buffer1\n"
    "{\n"
    "  uvec4 result[];\n"
    "};\n"
    "\n"
    "void main (void)\n"
    "{\n"
    "  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;\n"
    "  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;\n"
    "   result[offset].x = gl_SubgroupSize;\n"
    "   uint numActive = subgroupBallotBitCount(subgroupBallot(true));\n"
    "   result[offset].y = numActive;\n"
    "   result[offset].z = gl_NumSubgroups;\n"
    "}\n"
)


def family_size_control() -> list[Case]:
    cases = []
    vt = VecType("uint", 1)
    plain_shader = compute_shader(
        "#extension GL_KHR_shader_subgroup_basic: enable\n",
        vt,
        "  uint tempResult = gl_SubgroupSize;\n  tempRes = tempResult;\n",
        declarations="layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n",
    )
    vary, full = 1, 2

    def add(name, flags, mode, kind, ballot, spirv16):
        case = Case("subgroups/size_control/compute/" + name, plain_shader if kind == "plain" else SIZE_CONTROL_REQUIRE_FULL_SHADER, "none", vt, False, 0, "", spirv="spirv1.6" if spirv16 else "spirv1.3")
        case.spec += f";sc={flags}:{mode}:{kind}:{int(ballot)}:{int(spirv16)}" + (";rescomps=4" if kind == "full" else "")
        cases.append(case)

    for postfix, flags_enabled, spirv16 in (("", True, False), ("_spirv16", False, True), ("_flags_spirv16", True, True)):
        add("allow_varying_subgroup_size" + postfix, vary if flags_enabled else 0, "none", "plain", False, spirv16)
        add("require_full_subgroups_allow_varying_subgroup_size" + postfix, (full | vary) if flags_enabled else 0, "none", "full", True, spirv16)
        add("require_full_subgroups" + postfix, full if flags_enabled else 0, "none", "full", True, spirv16)
        add("required_subgroup_size_max_require_full_subgroups" + postfix, full if flags_enabled else 0, "max", "full", True, spirv16)
        add("required_subgroup_size_min_require_full_subgroups" + postfix, full if flags_enabled else 0, "min", "full", True, spirv16)
    add("required_subgroup_size_max", 0, "max", "plain", False, False)
    add("required_subgroup_size_min", 0, "min", "plain", False, False)

    # the mesh and task stages
    ext = "#extension GL_KHR_shader_subgroup_basic: enable\n"
    test_src = "  uint tempResult = gl_SubgroupSize;\n  tempRes = tempResult;\n"
    declarations = "layout(set = 0, binding = 0, std430) buffer Buffer1\n{\n  uint result[];\n};\n"

    def add_mesh_case(name, stage, flags, mode, spirv16):
        programs = mesh_programs(stage, ext, vt, test_src, "", declarations)
        mesh_case = MeshCase("subgroups/size_control/mesh/" + name, stage, programs, "none", vt, False, 0, "", "", "spirv1.6" if spirv16 else "spirv1.4")
        mesh_case.spec += f";sc={flags}:{mode}:plain:0:{int(spirv16)}"
        MESH.append(mesh_case)

    for postfix, flags_enabled, spirv16 in (("", True, False), ("_spirv16", False, True), ("_flags_spirv16", True, True)):
        for stage in MESH_STAGES:
            add_mesh_case(f"{stage}_allow_varying_subgroup_size{postfix}", stage, vary if flags_enabled else 0, "none", spirv16)
    for mode in ("max", "min"):
        for stage in MESH_STAGES:
            add_mesh_case(f"required_subgroup_size_{mode}_{stage}", stage, 0, mode, False)

    # the stages of the vertex pipeline and the fragment stage, as framebuffer cases
    def size_decl(stage_index):
        name = "result" if stage_index == 0 else "out_color"
        return f"layout(location = 0) out float {name}{'[]' if stage_index == 2 else ''};\n"

    fragment_source = (
        "#version 450\n"
        "precision highp int;\n"
        "#extension GL_KHR_shader_subgroup_basic: enable\n"
        "layout(location = 0) out uint out_color;\n"
        "void main()\n"
        "{\n"
        "uint tempResult = gl_SubgroupSize;\n"
        "     out_color = tempResult;\n"
        "}\n"
    )

    def add_framebuffer_case(name, stage_name, stage, flags, mode, spirv16):
        spirv = "spirv1.6" if spirv16 else "spirv1.3"
        if stage == "frag":
            programs = {"vert": ("vert", FRAG_HELPER_VERTEX), "fragment": ("frag", fragment_source)}
        else:
            programs = {}
            for point_size in ((False, True) if stage != "vert" else (False,)):
                program, source = fb_stage_program(stage, ext, vt, "  tempRes = gl_SubgroupSize;\n", "", size_decl, point_size)
                programs[f"test_{stage}" + ("_ps" if point_size else "")] = (program, source)
        fb_case = FramebufferCase(f"subgroups/size_control/framebuffer/{name}", stage, programs, "none", vt, 0, "", "", spirv)
        fb_case.spec += f";sc={flags}:{mode}:plain:0:{int(spirv16)}"
        FRAMEBUFFER.append(fb_case)

    # all the graphics stages together
    def graphics_decl(stage):
        return "layout(location = 0) out uint result;\n" if stage == GRAPHICS_STAGE_COUNT else f"layout(set = 0, binding = {stage}, std430) buffer Buffer1\n{{\n  uint result[];\n}};\n"

    def add_graphics_case(name, flags, mode, spirv16):
        add_graphics("subgroups/size_control/graphics/" + name, ext, vt, "  uint tempResult = gl_SubgroupSize;\n  tempRes = tempResult;\n", "none", 0, "", decl=graphics_decl, spirv="spirv1.6" if spirv16 else "spirv1.3")
        GRAPHICS[-1].spec += f";sc={flags}:{mode}:plain:0:{int(spirv16)}"

    for postfix, flags_enabled, spirv16 in (("", True, False), ("_spirv16", False, True), ("_flags_spirv16", True, True)):
        add_graphics_case("allow_varying_subgroup_size" + postfix, vary if flags_enabled else 0, "none", spirv16)
    add_graphics_case("required_subgroup_size_max", 0, "max", False)
    add_graphics_case("required_subgroup_size_min", 0, "min", False)

    fb_stages = FB_STAGES + [("fragment", "frag")]
    for postfix, flags_enabled, spirv16 in (("", True, False), ("_spirv16", False, True), ("_flags_spirv16", True, True)):
        for stage_name, stage in fb_stages:
            add_framebuffer_case(f"{stage_name}_allow_varying_subgroup_size{postfix}", stage_name, stage, vary if flags_enabled else 0, "none", spirv16)
    for stage_name, stage in fb_stages:
        for mode in ("max", "min"):
            add_framebuffer_case(f"{stage_name}_required_subgroup_size_{mode}", stage_name, stage, 0, mode, False)
    return cases


FAMILIES = [family_arithmetic, family_partitioned, family_clustered, family_quad, family_shuffle, family_ballot_broadcast, family_vote, family_ballot_other, family_shape, family_builtin_mask_var, family_ballot_mask_arb, family_ballot, family_basic_elect, family_basic_barriers, family_builtin_var, family_builtin_var_framebuffer, family_size_control]


GRAPHICS_MANIFEST = CRATE_DIR / "shaders" / "manifest" / "subgroups_graphics.toml"
COMMON_MANIFEST = CRATE_DIR / "shaders" / "manifest" / "subgroups_common.toml"

# addNoSubgroupShader: upstream assembles these three by hand so that the stages that carry no subgroup operation do not use the
# subgroup capabilities; they are written here as the GLSL its comments give, which does not use them either.
NO_SUBGROUP_SHADERS = {
    "vert_noSubgroup": (
        "vert",
        "#version 450\n"
        "void main (void)\n"
        "{\n"
        "  float pixelSize = 2.0f/1024.0f;\n"
        "  float pixelPosition = pixelSize/2.0f - 1.0f;\n"
        "  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);\n"
        "  gl_PointSize = 1.0f;\n"
        "}\n",
    ),
    "tesc_noSubgroup": (
        "tesc",
        "#version 450\n"
        "layout(vertices=1) out;\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "  if (gl_InvocationID == 0)\n"
        "  {\n"
        "    gl_TessLevelOuter[0] = 1.0f;\n"
        "    gl_TessLevelOuter[1] = 1.0f;\n"
        "  }\n"
        "  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
        "}\n",
    ),
    "tese_noSubgroup": (
        "tese",
        "#version 450\n"
        "layout(isolines) in;\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "  float pixelSize = 2.0f/1024.0f;\n"
        "  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;\n"
        "}\n",
    ),
}


def write_shader(source: str, stage: str, spirv: str | None, files: dict[str, str]) -> str:
    """Writes one source (once per distinct text) and returns its path below shaders/src."""
    digest = hashlib.sha1((source + str(spirv) + stage).encode()).hexdigest()[:16]
    file_name = files.setdefault(digest, f"{digest}.{stage}")
    path = SRC_DIR / file_name
    if not path.exists():
        path.write_text(source)
    return f"{SRC_REL}/{file_name}"


MESH_MANIFEST = CRATE_DIR / "shaders" / "manifest" / "subgroups_mesh.toml"
FRAMEBUFFER_MANIFEST = CRATE_DIR / "shaders" / "manifest" / "subgroups_framebuffer.toml"
FRAMEBUFFER_COMMON_MANIFEST = CRATE_DIR / "shaders" / "manifest" / "subgroups_framebuffer_common.toml"

# setVertexShaderFrameBuffer, setFragmentShaderFrameBuffer, setTesCtrlShaderFrameBuffer and setTesEvalShaderFrameBuffer: the stages
# around the tested one. Upstream assembles them by hand; these are the GLSL their comments give.
FRAMEBUFFER_COMMON_SHADERS = {
    "vert": (
        "vert",
        "#version 450\n"
        "layout(location = 0) in highp vec4 in_position;\n"
        "void main (void)\n"
        "{\n"
        "  gl_Position = in_position;\n"
        "  gl_PointSize = 1.0f;\n"
        "}\n",
    ),
    "fragment": (
        "frag",
        "#version 450\n"
        "layout(location = 0) in float in_color;\n"
        "layout(location = 0) out uint out_color;\n"
        "void main()\n"
        "{\n"
        "    out_color = uint(in_color);\n"
        "}\n",
    ),
    "tesc": (
        "tesc",
        "#version 450\n"
        "#extension GL_KHR_shader_subgroup_basic: enable\n"
        "#extension GL_EXT_tessellation_shader : require\n"
        "layout(vertices = 2) out;\n"
        "void main (void)\n"
        "{\n"
        "  if (gl_InvocationID == 0)\n"
        "  {\n"
        "    gl_TessLevelOuter[0] = 1.0f;\n"
        "    gl_TessLevelOuter[1] = 1.0f;\n"
        "  }\n"
        "  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
        "}\n",
    ),
    "tese": (
        "tese",
        "#version 450\n"
        "#extension GL_KHR_shader_subgroup_ballot: enable\n"
        "#extension GL_EXT_tessellation_shader : require\n"
        "layout(isolines, equal_spacing, ccw ) in;\n"
        "layout(location = 0) in float in_color[];\n"
        "layout(location = 0) out float out_color;\n"
        "\n"
        "void main (void)\n"
        "{\n"
        "  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);\n"
        "  out_color = in_color[0];\n"
        "}\n",
    ),
}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="compare the case names with tmp/missing_vk.txt and write nothing")
    args = parser.parse_args()

    cases: list[Case] = []
    for family in FAMILIES:
        cases += family()

    if args.check or MISSING.exists():
        known = {line.strip().removeprefix("dEQP-VK.").replace(".", "/") for line in MISSING.read_text().splitlines()} if MISSING.exists() else set()
        unknown = [c.path for c in cases + GRAPHICS + FRAMEBUFFER + MESH if known and c.path not in known]
        print(f"{len(cases)} compute, {len(GRAPHICS)} graphics, {len(FRAMEBUFFER)} framebuffer and {len(MESH)} mesh cases, {len(unknown)} not in the missing list")
        for path in unknown[:20]:
            print("  ", path)
    if args.check:
        return 0

    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for stale in list(SRC_DIR.glob("*.comp")) + list(SRC_DIR.glob("*.vert")) + list(SRC_DIR.glob("*.tesc")) + list(SRC_DIR.glob("*.tese")) + list(SRC_DIR.glob("*.geom")) + list(SRC_DIR.glob("*.frag")) + list(SRC_DIR.glob("*.mesh")) + list(SRC_DIR.glob("*.task")):
        stale.unlink()

    shader_files: dict[str, str] = {}
    lines = [
        "# Shader manifest for dEQP-VK.subgroups.*.compute.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_subgroups_compute_manifest.py - do not hand-edit, nor the sources it names.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp"',
        'rust_module = "subgroups/compute_tests"',
        "",
    ]
    for case in cases:
        template = write_shader(case.shader, "comp", case.spirv, shader_files)
        const = "SG_" + case.path.removeprefix("subgroups/").replace("/", "_").upper()
        lines += [
            "[[case]]",
            f'name = "{case.path}"',
            f'rust_const = "{const}"',
            'rust_type = "SubgroupCase"',
            f'programs = [ {{ name = "comp", template = "{template}", stage = "comp"' + (f', spirv_version = "{case.spirv}"' if case.spirv else "") + " } ]",
            f'params = {{ spec = {{ type = "str", value = "{case.spec}" }} }}',
            "",
        ]
    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)}: {len(cases)} cases")

    lines = [
        "# Shader manifest for dEQP-VK.subgroups.*.graphics.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_subgroups_compute_manifest.py - do not hand-edit, nor the sources it names.",
        "# Every case holds the programs of all graphics stages; the ones that depend on shaderTessellationAndGeometryPointSize are",
        "# there twice, `_ps` being the one that writes gl_PointSize.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp"',
        'rust_module = "subgroups/graphics_tests"',
        "",
    ]
    for case in GRAPHICS:
        entries = []
        for program, (stage, source) in case.programs.items():
            template = write_shader(source, stage, case.spirv, shader_files)
            entries.append(f'{{ name = "{program}", template = "{template}", stage = "{stage}"' + (f', spirv_version = "{case.spirv}"' if case.spirv else "") + " }")
        const = "SG_" + case.path.removeprefix("subgroups/").replace("/", "_").upper()
        lines += [
            "[[case]]",
            f'name = "{case.path}"',
            f'rust_const = "{const}"',
            'rust_type = "SubgroupGraphicsCase"',
            "programs = [ " + ", ".join(entries) + " ]",
            f'params = {{ spec = {{ type = "str", value = "{case.spec}" }} }}',
            "",
        ]
    GRAPHICS_MANIFEST.write_text("\n".join(lines))
    print(f"wrote {GRAPHICS_MANIFEST.relative_to(REPO_DIR)}: {len(GRAPHICS)} cases")

    lines = [
        "# Shader manifest for dEQP-VK.subgroups.*.framebuffer.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_subgroups_compute_manifest.py - do not hand-edit, nor the sources it names.",
        "# Every case holds the test source in one stage, as `test_<stage>`; the ones that depend on shaderTessellationAndGeometryPointSize",
        "# are there twice, `_ps` being the one that writes gl_PointSize.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp"',
        'rust_module = "subgroups/framebuffer_tests"',
        "",
    ]
    for case in FRAMEBUFFER:
        entries = []
        for program, (stage, source) in case.programs.items():
            template = write_shader(source, stage, case.spirv, shader_files)
            entries.append(f'{{ name = "{program}", template = "{template}", stage = "{stage}"' + (f', spirv_version = "{case.spirv}"' if case.spirv else "") + " }")
        const = "SG_" + case.path.removeprefix("subgroups/").replace("/", "_").upper()
        lines += [
            "[[case]]",
            f'name = "{case.path}"',
            f'rust_const = "{const}"',
            'rust_type = "SubgroupFramebufferCase"',
            "programs = [ " + ", ".join(entries) + " ]",
            f'params = {{ spec = {{ type = "str", value = "{case.spec}" }} }}',
            "",
        ]
    FRAMEBUFFER_MANIFEST.write_text("\n".join(lines))
    print(f"wrote {FRAMEBUFFER_MANIFEST.relative_to(REPO_DIR)}: {len(FRAMEBUFFER)} cases")

    lines = [
        "# Shader manifest for dEQP-VK.subgroups.*.mesh.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_subgroups_compute_manifest.py - do not hand-edit, nor the sources it names.",
        "# The task cases hold a task shader with the test source and the mesh shader upstream pairs it with.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp"',
        'rust_module = "subgroups/mesh_tests"',
        "",
    ]
    for case in MESH:
        entries = []
        for program, (stage, source) in case.programs.items():
            template = write_shader(source, stage, case.spirv, shader_files)
            entries.append(f'{{ name = "{program}", template = "{template}", stage = "{stage}", spirv_version = "{case.spirv}" }}')
        const = "SG_" + case.path.removeprefix("subgroups/").replace("/", "_").upper()
        lines += [
            "[[case]]",
            f'name = "{case.path}"',
            f'rust_const = "{const}"',
            'rust_type = "SubgroupMeshCase"',
            "programs = [ " + ", ".join(entries) + " ]",
            f'params = {{ spec = {{ type = "str", value = "{case.spec}" }} }}',
            "",
        ]
    MESH_MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MESH_MANIFEST.relative_to(REPO_DIR)}: {len(MESH)} cases")

    entries = []
    for program, (stage, source) in FRAMEBUFFER_COMMON_SHADERS.items():
        template = write_shader(source, stage, None, shader_files)
        entries.append(f'{{ name = "{program}", template = "{template}", stage = "{stage}" }}')
    FRAMEBUFFER_COMMON_MANIFEST.write_text(
        "\n".join(
            [
                "# Shader manifest for the stages around the tested one in the subgroup framebuffer cases.",
                "#",
                "# @generated by hodow_cts/scripts/gen_subgroups_compute_manifest.py - do not hand-edit.",
                "",
                'upstream_source = "external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp"',
                'rust_module = "subgroups/framebuffer_tests"',
                "",
                "[[case]]",
                'name = "framebuffer_common"',
                'rust_const = "SG_FRAMEBUFFER_COMMON_PROGRAMS"',
                'rust_type = "SubgroupFramebufferCommon"',
                "programs = [ " + ", ".join(entries) + " ]",
                "",
            ]
        )
    )

    entries = []
    for program, (stage, source) in NO_SUBGROUP_SHADERS.items():
        template = write_shader(source, stage, None, shader_files)
        entries.append(f'{{ name = "{program}", template = "{template}", stage = "{stage}" }}')
    COMMON_MANIFEST.write_text(
        "\n".join(
            [
                "# Shader manifest for the stages of the subgroup graphics cases that carry no subgroup operation (addNoSubgroupShader).",
                "#",
                "# @generated by hodow_cts/scripts/gen_subgroups_compute_manifest.py - do not hand-edit.",
                "",
                'upstream_source = "external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp"',
                'rust_module = "subgroups/graphics_tests"',
                "",
                "[[case]]",
                'name = "no_subgroup"',
                'rust_const = "SG_NO_SUBGROUP_PROGRAMS"',
                'rust_type = "SubgroupCommonPrograms"',
                "programs = [ " + ", ".join(entries) + " ]",
                "",
            ]
        )
    )
    print(f"wrote {COMMON_MANIFEST.relative_to(REPO_DIR)}; {len(shader_files)} distinct sources in all")
    return 0


if __name__ == "__main__":
    sys.exit(main())

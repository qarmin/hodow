#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.tessellation.tess_io.max_in_out (560 cases).

`MaxIOTest::initPrograms` builds the shaders from the interface variable list cut to the usable locations of the default limits (128 / 120 /
128 components); the instance rebuilds them from the limits of the device. The shaders written here are the default-limits ones: the Rust side
recomputes the usable list from the real limits and reports NotPorted when it differs from the one the shaders were written for.

The variable lists are made exactly as `createTessIOTests` does (one de::Random(1636723398) shared by all groups, Fisher-Yates shuffles of
the vertex list then the patch list per permutation).

A pure text generator: no glslang and no cargo.
"""

from pathlib import Path

from de_random import DeRandom

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "shaders" / "manifest" / "tessellation_max_io.toml"
SRC_DIR = ROOT / "shaders" / "src" / "tessellation" / "max_io"

NUM_VERTICES = 4
NUM_PATCHES = 2
VARS_PER_TYPE = 10
SLOT_SIZE = 4
DEFAULT_LIMITS = (128, 120, 128)

VERTEX, PATCH = 0, 1
INTEGER, FLOAT = 0, 1
NORMAL, FLAT = 0, 1

REQUIRED_FEATURES = [
    (False, False, False, False, "32_bits_only"),
    (True, False, False, False, "with_i64"),
    (False, True, False, False, "with_f64"),
    (True, True, False, False, "all_but_16_bits"),
    (False, False, True, False, "with_i16"),
    (False, False, False, True, "with_f16"),
    (True, True, True, True, "all_types"),
]

TESS_TYPES = [
    (False, True, VERTEX, "tcs_vert_writes_tes_reads"),
    (True, True, VERTEX, "tcs_vert_writes_reads_tes_reads"),
    (False, False, VERTEX, "tcs_vert_writes_tes_na"),
    (True, False, VERTEX, "tcs_vert_writes_reads_tes_na"),
    (False, True, PATCH, "tcs_patch_writes_tes_reads"),
    (True, True, PATCH, "tcs_patch_writes_reads_tes_reads"),
    (False, False, PATCH, "tcs_patch_writes_tes_na"),
    (True, False, PATCH, "tcs_patch_writes_reads_tes_na"),
]


class Var:
    def __init__(self, owner, dtype, bits, dim, interp, index):
        self.owner, self.dtype, self.bits, self.dim, self.interp, self.index = owner, dtype, bits, dim, interp, index

    def name(self):
        return (
            f"{'vert' if self.owner == VERTEX else 'patch'}_{'i' if self.dtype == INTEGER else 'f'}{self.bits}d{self.dim}_"
            f"{'inter' if self.interp == NORMAL else 'flat'}_{self.index}"
        )

    def location_size(self):
        return 2 if self.bits == 64 and self.dim >= 3 else 1

    def glsl_type(self):
        if self.dim == 1:
            return ("int" if self.dtype == INTEGER else "float") + f"{self.bits}_t"
        return ("i" if self.dtype == INTEGER else "f") + f"{self.bits}vec{self.dim}"

    def type_and_name(self):
        return f"{self.glsl_type()} {self.name()}"

    def location_decl(self, location, direction_in):
        return (
            f"layout (location={location}) {'in' if direction_in else 'out'} {'patch ' if self.owner == PATCH else ''}"
            f"{'flat ' if self.interp == FLAT else ''}{self.type_and_name()}{'[]' if self.owner == VERTEX else ''};\n"
        )

    def source_name(self):
        return ("ppd" if self.owner == PATCH else "pvd") + "." + self.name()

    def check_name(self):
        return "good_" + self.name()

    def check_statement(self, tcs_reads=False):
        out = ""
        source = self.source_name()
        glsl_type = self.glsl_type()
        name = self.name()
        temp = name if tcs_reads else "temp_" + name
        if self.owner == VERTEX:
            if tcs_reads:
                temp += "[gl_InvocationID]"
            else:
                out += f"{glsl_type} {temp};\n"
                out += f"INTERP_QUAD_VAR({glsl_type}, var_{name} ,{name}[i], {temp});\n"
        out += f"    bool {self.check_name()} = "
        if self.owner == VERTEX:
            max_elem = f"{glsl_type}(max(max(max({source}[0], {source}[1]), {source}[2]), {source}[3]))"
            min_elem = f"{glsl_type}(min(min(min({source}[0], {source}[1]), {source}[2]), {source}[3]))"
            if self.dim == 1:
                out += f"({temp} <= {max_elem}) && ({temp} >= {min_elem})"
            else:
                out += f"all(lessThanEqual({temp}, {max_elem})) && all(greaterThanEqual({temp}, {min_elem}))"
        else:
            out += (
                f"((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && {name} == {source}[0]) || "
                f"(gl_PrimitiveID == 1 && {name} == {source}[1])))"
            )
        return out + ";\n"

    def assignment(self, left, right):
        vertex = self.owner == VERTEX
        return (
            f"    {left}{'.' if left else ''}{self.name()}{'[gl_InvocationID]' if vertex else ''} = {self.glsl_type()}("
            f"{right}{'.' if right else ''}{self.name()}[{'gl_InvocationID' if vertex else 'gl_PrimitiveID'}]);\n"
        )

    def binding_type(self):
        if self.dim == 1:
            return "int" if self.dtype == INTEGER else "float"
        return ("i" if self.dtype == INTEGER else "") + f"vec{self.dim}"

    def binding(self, owner_type):
        if self.owner != owner_type:
            return ""
        return f"{self.binding_type()} {self.name()}[{NUM_VERTICES if self.owner == VERTEX else NUM_PATCHES}];\n"


def max_locations(limits, tcs_reads, tes_reads, owner):
    per_vertex = (limits[2] if tes_reads else limits[0]) // SLOT_SIZE - (2 + (1 if tcs_reads else 0))
    per_patch = limits[1] // SLOT_SIZE - 3
    return per_vertex if owner == VERTEX else per_patch


def usable_len(limits, tcs_reads, tes_reads, variables):
    """`getUsableLocations`: the length the vector is resized to (the index of the last variable that fit, as upstream)."""
    avail_vertex = max_locations(limits, tcs_reads, tes_reads, VERTEX)
    avail_patch = max_locations(limits, tcs_reads, tes_reads, PATCH)
    vec_end = 0
    for i, var in enumerate(variables):
        size = var.location_size()
        if var.owner == VERTEX:
            if avail_vertex <= 0 or avail_vertex - size < 0:
                break
            avail_vertex -= size
        else:
            if avail_patch <= 0 or avail_patch - size < 0:
                break
            avail_patch -= size
        vec_end = i
    return vec_end


INTERP_MACRO = (
    "#define INTERP_QUAD_VAR(TYPE, VAR, INi, OUT) do { \\\n"
    "    TYPE VAR[4]; \\\n"
    "    for (int i = 0; i < 4; i++) VAR[i] = INi; \\\n"
    "    { \\\n"
    "        TYPE temp1 = TYPE(VAR[0] * TYPE(1 - gl_TessCoord[0]) + VAR[1] * TYPE(gl_TessCoord[0])); \\\n"
    "        TYPE temp2 = TYPE(VAR[2] * TYPE(1 - gl_TessCoord[0]) + VAR[3] * TYPE(gl_TessCoord[0])); \\\n"
    "        OUT = TYPE(temp1 * TYPE(1 - gl_TessCoord[1]) + temp2 * TYPE(gl_TessCoord[1])); \\\n"
    "    } \\\n"
    "} while(false)\n\n"
)

VERT = """#version 450
vec4 positions[8] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4( 1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  1.0, 0.0, 1.0),
    vec4( 1.0,  1.0, 0.0, 1.0),
    vec4(-0.5, -0.5, 0.0, 1.0),
    vec4( 0.5, -0.5, 0.0, 1.0),
    vec4(-0.5,  0.5, 0.0, 1.0),
    vec4( 0.5,  0.5, 0.0, 1.0)
);
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = positions[gl_VertexIndex];
}
"""

FRAG = """#version 450
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main()
{
    outColor = inColor;
}
"""


def bindings_decl(var_type, variables):
    out = ""
    if var_type == VERTEX:
        out += "layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {\n"
        for var in variables:
            out += "    " + var.binding(VERTEX)
        out += " } pvd;\n\n"
    else:
        out += "layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {\n"
        for var in variables:
            out += "    " + var.binding(PATCH)
        out += " } ppd;\n\n"
    return out


def make_tese(tcs_reads, tes_reads, var_type, variables):
    t = "#version 450\n#extension GL_EXT_shader_explicit_arithmetic_types : enable\nlayout(quads, equal_spacing) in;\n\n"
    t += bindings_decl(var_type, variables)
    if tcs_reads:
        t += "layout (location=0) in vec4 inColor[];\n\n"
    if tes_reads:
        used = 1 if tcs_reads else 0
        for var in variables:
            t += var.location_decl(used, True)
            used += var.location_size()
    t += "\nlayout (location=0) out vec4 outColor;\n\n"
    t += "in gl_PerVertex {\n    vec4  gl_Position;\n} gl_in[];\n\nout gl_PerVertex {\n    vec4 gl_Position;\n};\n"
    t += INTERP_MACRO
    t += "void main ()\n{\n"
    if tes_reads:
        conditions = []
        for var in variables:
            t += var.check_statement()
            conditions.append(var.check_name())
        t += f"    if ({' && '.join(conditions)}) {{\n"
        if tcs_reads:
            t += "        INTERP_QUAD_VAR(vec4, var_color, inColor[i], outColor);\n"
        else:
            t += "        outColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);\n"
        t += "    } else {\n        outColor = vec4(0.0, 0.0, 0.0, 1.0);\n    }\n"
    elif tcs_reads:
        t += "    INTERP_QUAD_VAR(vec4, var_color, inColor[i], outColor);\n"
    else:
        t += "    outColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);\n"
    t += "    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);\n"
    t += "}\n"
    return t


def make_tesc(tcs_reads, tes_reads, var_type, variables):
    t = (
        "#version 450\n#extension GL_EXT_tessellation_shader : require\n"
        "#extension GL_EXT_shader_explicit_arithmetic_types : enable\n\n"
        f"layout (vertices = {NUM_VERTICES}) out;\n\n"
    )
    if tcs_reads:
        t += "\nlayout (location=0) out vec4 outColor[];\n\n"
    used = 1 if tcs_reads else 0
    for var in variables:
        t += var.location_decl(used, False)
        used += var.location_size()
    t += "\n"
    t += bindings_decl(var_type, variables)
    t += "in gl_PerVertex {\n    vec4  gl_Position;\n} gl_in[];\n\nout gl_PerVertex {\n    vec4  gl_Position;\n} gl_out[];\n\n"
    t += "void main ()\n{\n"
    for var in variables:
        t += var.assignment("", "pvd" if var.owner == VERTEX else "ppd")
    if tcs_reads:
        conditions = []
        for var in variables:
            t += var.check_statement(True)
            conditions.append(var.check_name())
        t += (
            f"    if ({' && '.join(conditions)}) {{\n"
            "        outColor[gl_InvocationID] = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);\n"
            "    } else {\n        outColor[gl_InvocationID] = vec4(0.0, 0.0, 0.0, 1.0);\n    }\n"
        )
    t += (
        "   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
        "   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);\n"
        "   gl_TessLevelInner = float[2](1.0, 1.0);\n"
    )
    t += "\n}\n"
    return t


def build_var_lists(i64, f64, i16, f16):
    vert, patch = [], []
    for owner in (VERTEX, PATCH):
        for dtype in (FLOAT, INTEGER):
            for bits in (64, 32, 16):
                for dim in (1, 2, 3, 4):
                    for interp in (NORMAL, FLAT):
                        if dtype == FLOAT:
                            if bits == 64 and not f64:
                                continue
                            if bits == 16 and not f16:
                                continue
                        else:
                            if bits == 64 and not i64:
                                continue
                            if bits == 16 and not i16:
                                continue
                        if dtype == INTEGER and interp == NORMAL:
                            continue
                        if owner == PATCH and interp == FLAT:
                            continue
                        if dtype == FLOAT and bits == 64 and interp == NORMAL:
                            continue
                        for idx in range(VARS_PER_TYPE):
                            (vert if owner == VERTEX else patch).append(Var(owner, dtype, bits, dim, interp, idx))
    return vert, patch


def shuffle(rnd, items):
    for i in range(len(items) - 1, 0, -1):
        j = rnd.get_int(0, i)
        items[i], items[j] = items[j], items[i]


HEADER = """# Shader manifest for dEQP-VK.tessellation.tess_io.max_in_out
#
# @generated by hodow_cts/scripts/gen_tess_max_io_manifest.py - do not hand-edit.
#
# One entry per case of `MaxIOTest`: the control and evaluation shaders written for the default limits (128 / 120 / 128 components); the
# vertex and fragment shaders are the common ones.

upstream_source = "external/vulkancts/modules/vulkan/tessellation/vktTessellationMaxIOTests.cpp"
rust_module = "tessellation/max_io_tests"
"""


def main():
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    (SRC_DIR / "vert.vert").write_text(VERT)
    (SRC_DIR / "frag.frag").write_text(FRAG)
    rnd = DeRandom(1636723398)
    out = [HEADER]
    count = 0
    for i64, f64, i16, f16, reqs_name in REQUIRED_FEATURES:
        vert_vars, patch_vars = build_var_lists(i64, f64, i16, f16)
        for comb in range(10):
            permut_vert = list(vert_vars)
            shuffle(rnd, permut_vert)
            permut_patch = list(patch_vars)
            shuffle(rnd, permut_patch)
            for tcs_reads, tes_reads, var_type, type_name in TESS_TYPES:
                full = permut_vert if var_type == VERTEX else permut_patch
                n = usable_len(DEFAULT_LIMITS, tcs_reads, tes_reads, full)
                variables = full[:n]
                case = f"{reqs_name}_p{comb}_{type_name}"
                (SRC_DIR / f"{case}.tesc").write_text(make_tesc(tcs_reads, tes_reads, var_type, variables))
                (SRC_DIR / f"{case}.tese").write_text(make_tese(tcs_reads, tes_reads, var_type, variables))
                t = "tessellation/max_io"
                out.append(
                    f"""
[[case]]
name = "{case}"
rust_const = "MAX_IO_{case.upper()}"
rust_type = "SharedProgram"
programs = [
    {{ name = "vert", template = "{t}/vert.vert", stage = "vert" }},
    {{ name = "tesc", template = "{t}/{case}.tesc", stage = "tesc" }},
    {{ name = "tese", template = "{t}/{case}.tese", stage = "tese" }},
    {{ name = "frag", template = "{t}/frag.frag", stage = "frag" }},
]
"""
                )
                count += 1
    MANIFEST.write_text("".join(out))
    print(f"wrote {MANIFEST} with {count} entries")


if __name__ == "__main__":
    main()

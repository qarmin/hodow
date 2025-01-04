#!/usr/bin/env python3
"""Writes the GLSL of the ShaderExecutor specs (vktShaderExecutor.cpp) and their manifest.

Upstream's `ShaderExecutor` builds the shaders of one `ShaderSpec` at run time, per shader type: `VertexShaderExecutor::generateSources`,
`GeometryShaderExecutor`, `FragmentShaderExecutor`, `TessControlExecutor`, `TessEvaluationExecutor` and `ComputeShaderExecutor`. This
reproduces those string concatenations (`generateVertexShader`, `generatePassthroughVertexShader`, `generateGeometryShader`, ...) for every
spec of SPECS and lists each (spec, shader type) pair as one manifest case named `se_<spec>__<shader type>`, which the Rust side finds in
`ALL_SHARED_PROGRAM` by that name (src/vkt/tests/shaderexecutor/mod.rs). Mesh and task executors, 16 and 64 bit types, matrices and
`packFloat16Bit` are not reproduced: no spec here needs them.

Run from hodow_cts/:  python3 scripts/gen_shader_executor_programs.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "shader_executor"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_executor.toml"

# glu::DataType -> GLSL name, by (kind, size)
GLSL_TYPES = {
    ("float", 1): "float", ("float", 2): "vec2", ("float", 3): "vec3", ("float", 4): "vec4",
    ("int", 1): "int", ("int", 2): "ivec2", ("int", 3): "ivec3", ("int", 4): "ivec4",
    ("uint", 1): "uint", ("uint", 2): "uvec2", ("uint", 3): "uvec3", ("uint", 4): "uvec4",
    ("bool", 1): "bool", ("bool", 2): "bvec2", ("bool", 3): "bvec3", ("bool", 4): "bvec4",
    ("double", 1): "double", ("double", 2): "dvec2", ("double", 3): "dvec3", ("double", 4): "dvec4",
    ("float", 5): "vector<float, 5>", ("int", 5): "vector<int, 5>", ("uint", 5): "vector<uint, 5>",
    ("bool", 5): "vector<bool, 5>", ("double", 5): "vector<double, 5>",
}


class Symbol:
    def __init__(self, name, kind, size=1, precision="highp"):
        self.name = name
        self.kind = kind
        self.size = size
        self.precision = precision

    @property
    def glsl(self):
        return GLSL_TYPES[(self.kind, self.size)]

    def declare(self, name):
        return f"{self.precision} {self.glsl} {name}" if self.precision else f"{self.glsl} {name}"


class Spec:
    def __init__(self, key, inputs, outputs, global_declarations, source, version="450", stages=None, spirv_version=None, local_size_x=1, mesh_task=False):
        self.mesh_task = mesh_task
        self.local_size_x = local_size_x
        self.spirv_version = spirv_version
        self.stages = stages
        self.key = key
        self.inputs = inputs
        self.outputs = outputs
        self.global_declarations = global_declarations
        self.source = source
        self.version = version

    def version_line(self):
        long_vector = any(symbol.size == 5 for symbol in self.inputs + self.outputs)
        return f"#version {self.version}\n" + ("#extension GL_EXT_long_vector : enable\n" if long_vector else "")


def op_source(src):
    return "".join(f"\t{line}\n" for line in src.splitlines())


def output_locations(spec):
    return {output.name: ndx for ndx, output in enumerate(spec.outputs)}


def passthrough_vertex(spec, input_prefix, output_prefix):
    s = spec.version_line()
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    s += "layout(location = 0) in highp vec4 a_position;\n"
    location = 0
    for symbol in spec.inputs:
        location += 1
        s += f"layout(location = {location}) in {symbol.declare(input_prefix + symbol.name)};\n"
        s += f"layout(location = {location - 1}) flat out {symbol.declare(output_prefix + symbol.name)};\n"
    s += "\nvoid main (void)\n{\n    gl_Position = a_position;\n    gl_PointSize = 1.0;\n"
    for symbol in spec.inputs:
        s += f"\t{output_prefix}{symbol.name} = {input_prefix}{symbol.name};\n"
    s += "}\n"
    return s


def vertex_shader(spec, input_prefix, output_prefix):
    s = spec.version_line()
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    s += "layout(location = 0) in highp vec4 a_position;\n"
    for ndx, symbol in enumerate(spec.inputs, 1):
        s += f"layout(location = {ndx}) in {symbol.declare(input_prefix + symbol.name)};\n"
    for ndx, symbol in enumerate(spec.outputs):
        s += f"layout(location = {ndx}) flat out {symbol.declare(output_prefix + symbol.name)};\n"
    s += "\nvoid main (void)\n{\n    gl_Position = a_position;\n    gl_PointSize = 1.0;\n"
    for symbol in spec.inputs:
        s += f"\t{symbol.declare(symbol.name)} = {input_prefix}{symbol.name};\n"
    for symbol in spec.outputs:
        s += f"\t{symbol.declare(symbol.name)};\n"
    s += op_source(spec.source)
    for symbol in spec.outputs:
        s += f"\t{output_prefix}{symbol.name} = {symbol.name};\n"
    s += "}\n"
    return s


def frag_output_decl(spec, output_prefix):
    locations = output_locations(spec)
    s = ""
    for symbol in spec.outputs:
        s += f"layout(location = {locations[symbol.name]}) out {symbol.declare(output_prefix + symbol.name)};\n"
    return s


def frag_out_assign(spec, value_prefix, output_prefix):
    return "".join(f"\t{output_prefix}{symbol.name} = {value_prefix}{symbol.name};\n" for symbol in spec.outputs)


def passthrough_fragment(spec, input_prefix, output_prefix):
    s = "#version 450\n"
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    for ndx, symbol in enumerate(spec.outputs):
        s += f"layout(location = {ndx}) flat in {symbol.declare(input_prefix + symbol.name)};\n"
    s += frag_output_decl(spec, output_prefix)
    s += "\nvoid main (void)\n{\n"
    s += frag_out_assign(spec, input_prefix, output_prefix)
    s += "}\n"
    return s


def geometry_shader(spec, input_prefix, output_prefix, point_size_supported):
    s = spec.version_line()
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    s += "layout(points) in;\nlayout(points, max_vertices = 1) out;\n"
    for ndx, symbol in enumerate(spec.inputs):
        s += f"layout(location = {ndx}) flat in {symbol.declare(input_prefix + symbol.name)}[];\n"
    for ndx, symbol in enumerate(spec.outputs):
        s += f"layout(location = {ndx}) flat out {symbol.declare(output_prefix + symbol.name)};\n"
    s += "\nvoid main (void)\n{\n    gl_Position = gl_in[0].gl_Position;\n"
    if point_size_supported:
        s += "    gl_PointSize = gl_in[0].gl_PointSize;\n\n"
    for symbol in spec.inputs:
        s += f"\t{symbol.declare(symbol.name)} = {input_prefix}{symbol.name}[0];\n"
    for symbol in spec.outputs:
        s += f"\t{symbol.declare(symbol.name)};\n"
    s += "\n"
    s += op_source(spec.source)
    for symbol in spec.outputs:
        s += f"\t{output_prefix}{symbol.name} = {symbol.name};\n"
    s += "    EmitVertex();\n    EndPrimitive();\n}\n"
    return s


def fragment_shader(spec, input_prefix, output_prefix):
    s = spec.version_line()
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    for ndx, symbol in enumerate(spec.inputs):
        s += f"layout(location = {ndx}) flat in {symbol.declare(input_prefix + symbol.name)};\n"
    s += frag_output_decl(spec, output_prefix)
    s += "\nvoid main (void)\n{\n"
    for symbol in spec.inputs:
        s += f"\t{symbol.declare(symbol.name)} = {input_prefix}{symbol.name};\n"
    for symbol in spec.outputs:
        s += f"\t{symbol.declare(symbol.name)};\n"
    s += op_source(spec.source)
    s += frag_out_assign(spec, "", output_prefix)
    s += "}\n"
    return s


def declare_buffer_blocks(spec):
    s = ""
    if spec.inputs:
        s += "struct Inputs\n{\n" + "".join(f"\t{symbol.declare(symbol.name)};\n" for symbol in spec.inputs) + "};\n"
    s += "struct Outputs\n{\n" + "".join(f"\t{symbol.declare(symbol.name)};\n" for symbol in spec.outputs) + "};\n"
    s += "\n"
    if spec.inputs:
        s += "layout(set = 0, binding = 0, std430) buffer InBuffer\n{\n    Inputs inputs[];\n};\n"
    s += "layout(set = 0, binding = 1, std430) buffer OutBuffer\n{\n    Outputs outputs[];\n};\n\n"
    return s


def exec_buffer_io(spec, invocation_ndx_name):
    s = ""
    for symbol in spec.inputs:
        s += f"\t{symbol.glsl} {symbol.name} = {symbol.glsl}(inputs[{invocation_ndx_name}].{symbol.name});\n"
    for symbol in spec.outputs:
        s += f"\t{symbol.glsl} {symbol.name};\n"
    s += "\n"
    s += op_source(spec.source)
    s += "\n"
    for symbol in spec.outputs:
        s += f"\toutputs[{invocation_ndx_name}].{symbol.name} = {symbol.name};\n"
    return s


def compute_shader(spec):
    s = spec.version_line()
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    s += f"layout(local_size_x = {spec.local_size_x}) in;\n\n"
    s += declare_buffer_blocks(spec)
    s += "void main (void)\n{\n"
    s += "    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z\n"
    s += "                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n"
    s += exec_buffer_io(spec, "invocationNdx")
    s += "}\n"
    return s


def mesh_shader(spec, use_task):
    """`MeshTaskShaderExecutor::generateMeshShader`"""
    s = spec.version_line() + "#extension GL_EXT_mesh_shader : enable\n"
    if use_task:
        s += "layout(local_size_x=1, local_size_y=1, local_size_z=1) in;\nlayout(points) out;\nlayout(max_vertices=1, max_primitives=1) out;\n\n"
        s += "void main (void)\n{\n    SetMeshOutputsEXT(0u, 0u);\n}\n"
        return s
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    s += f"layout(local_size_x = {spec.local_size_x}) in;\nlayout(points) out;\nlayout(max_vertices=1, max_primitives=1) out;\n\n"
    s += declare_buffer_blocks(spec)
    s += "void main (void)\n{\n"
    s += "    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z\n"
    s += "                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n"
    s += exec_buffer_io(spec, "invocationNdx")
    s += "    SetMeshOutputsEXT(0u, 0u);\n}\n"
    return s


def task_shader(spec):
    """`MeshTaskShaderExecutor::generateTaskShader`"""
    s = spec.version_line() + "#extension GL_EXT_mesh_shader : enable\n"
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    s += f"layout(local_size_x = {spec.local_size_x}) in;\n\n"
    s += declare_buffer_blocks(spec)
    s += "void main (void)\n{\n"
    s += "    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z\n"
    s += "                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n"
    s += exec_buffer_io(spec, "invocationNdx")
    s += "    EmitMeshTasksEXT(0u, 0u, 0u);\n}\n"
    return s


def vertex_for_tess():
    return "#version 450\nvoid main (void)\n{\n    gl_Position = vec4(gl_VertexIndex/2, gl_VertexIndex%2, 0.0, 1.0);\n}\n"


def empty_fragment():
    return "#version 450\nlayout(location=0) out highp vec4 o_color;\nvoid main (void)\n{\n    o_color = vec4(0.0);\n}\n"


def tess_levels():
    s = ""
    for ndx in range(2):
        s += f"\tgl_TessLevelInner[{ndx}] = 1.0;\n"
    for ndx in range(4):
        s += f"\tgl_TessLevelOuter[{ndx}] = 1.0;\n"
    return s


def tess_control_shader(spec):
    s = spec.version_line()
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    s += "\nlayout(vertices = 1) out;\n\n"
    s += declare_buffer_blocks(spec)
    s += "void main (void)\n{\n"
    s += tess_levels()
    s += "\n\thighp uint invocationId = uint(gl_PrimitiveID);\n"
    s += exec_buffer_io(spec, "invocationId")
    s += "}\n"
    return s


def empty_tess_eval():
    return (
        "#version 450\n#extension GL_EXT_tessellation_shader : require\n\n"
        "layout(triangles, ccw) in;\n"
        "\nvoid main (void)\n{\n\tgl_Position = vec4(gl_TessCoord.xy, 0.0, 1.0);\n}\n"
    )


def passthrough_tess_control():
    return (
        "#version 450\n#extension GL_EXT_tessellation_shader : require\n\n"
        "layout(vertices = 1) out;\n\n"
        "void main (void)\n{\n" + tess_levels() + "}\n"
    )


def tess_eval_shader(spec):
    s = spec.version_line()
    if spec.global_declarations:
        s += spec.global_declarations + "\n"
    s += "\n"
    s += "layout(isolines, equal_spacing) in;\n\n"
    s += declare_buffer_blocks(spec)
    s += "void main (void)\n{\n"
    s += "\tgl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);\n"
    s += "\thighp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);\n"
    s += exec_buffer_io(spec, "invocationId")
    s += "}\n"
    return s


def program_sets(spec):
    """(shader type name, [(program name, glslang stage, source)]) in the order of upstream's generateSources."""
    return [
        ("vertex", [("vert", "vert", vertex_shader(spec, "a_", "vtx_out_")), ("frag", "frag", passthrough_fragment(spec, "vtx_out_", "o_"))]),
        (
            "geometry",
            [
                ("vert", "vert", passthrough_vertex(spec, "a_", "vtx_out_")),
                ("geom", "geom", geometry_shader(spec, "vtx_out_", "geom_out_", False)),
                ("geom_point_size", "geom", geometry_shader(spec, "vtx_out_", "geom_out_", True)),
                ("frag", "frag", passthrough_fragment(spec, "geom_out_", "o_")),
            ],
        ),
        ("fragment", [("vert", "vert", passthrough_vertex(spec, "a_", "vtx_out_")), ("frag", "frag", fragment_shader(spec, "vtx_out_", "o_"))]),
        (
            "tessellation_control",
            [
                ("vert", "vert", vertex_for_tess()),
                ("tess_control", "tesc", tess_control_shader(spec)),
                ("tess_eval", "tese", empty_tess_eval()),
                ("frag", "frag", empty_fragment()),
            ],
        ),
        (
            "tessellation_evaluation",
            [
                ("vert", "vert", vertex_for_tess()),
                ("tess_control", "tesc", passthrough_tess_control()),
                ("tess_eval", "tese", tess_eval_shader(spec)),
                ("frag", "frag", empty_fragment()),
            ],
        ),
        ("compute", [("compute", "comp", compute_shader(spec))]),
        *(
            [
                ("mesh", [("mesh", "mesh", mesh_shader(spec, False))]),
                ("task", [("mesh", "mesh", mesh_shader(spec, True)), ("task", "task", task_shader(spec))]),
            ]
            if spec.mesh_task
            else []
        ),
    ]


def sampler_spec(key, sampler_decl):
    return Spec(
        key,
        [Symbol("texCoord", "float", 2)],
        [Symbol("result", "float", 4)],
        f"layout(binding = 0, set = 1) uniform highp {sampler_decl} u_image;\n",
        "result = texture(u_image, texCoord);\n" if sampler_decl == "sampler2D" else "result = texture(u_image, vec3(texCoord, 1u));\n",
    )


def integer_function_specs():
    """The specs of vktShaderIntegerFunctionTests.cpp: every function over int/uint scalars and vec2-5 (vec5 is VK_EXT_shader_long_vector, compute only)."""
    specs = []

    def add(func, name, make, int_types, uint_types, all_prec):
        for base in ("int", "uint"):
            if (base == "int" and not int_types) or (base == "uint" and not uint_types):
                continue
            for size in range(1, 6):
                for prec in ("mediump", "highp"):
                    if prec != "highp" and not all_prec:
                        continue
                    inputs, outputs, source = make(base, size, prec)
                    stages = ("compute",) if size == 5 else None
                    specs.append(Spec(f"integer_{name}_{base}{size}_{prec}", inputs, outputs, "", source, stages=stages))

    def uaddcarry(base, size, prec):
        return ([Symbol("x", base, size, prec), Symbol("y", base, size, prec)], [Symbol("sum", base, size, prec), Symbol("carry", base, size, "lowp")], "sum = uaddCarry(x, y, carry);")

    def usubborrow(base, size, prec):
        return ([Symbol("x", base, size, prec), Symbol("y", base, size, prec)], [Symbol("diff", base, size, prec), Symbol("carry", base, size, "lowp")], "diff = usubBorrow(x, y, carry);")

    def umulextended(base, size, prec):
        return ([Symbol("x", base, size, prec), Symbol("y", base, size, prec)], [Symbol("msb", base, size, prec), Symbol("lsb", base, size, prec)], "umulExtended(x, y, msb, lsb);")

    def imulextended(base, size, prec):
        return ([Symbol("x", base, size, prec), Symbol("y", base, size, prec)], [Symbol("msb", base, size, prec), Symbol("lsb", base, size, prec)], "imulExtended(x, y, msb, lsb);")

    def bitfieldextract(base, size, prec):
        return (
            [Symbol("value", base, size, prec), Symbol("offset", "int", 1, prec), Symbol("bits", "int", 1, prec)],
            [Symbol("extracted", base, size, prec)],
            "extracted = bitfieldExtract(value, offset, bits);",
        )

    def bitfieldinsert(base, size, prec):
        return (
            [Symbol("base", base, size, prec), Symbol("insert", base, size, prec), Symbol("offset", "int", 1, prec), Symbol("bits", "int", 1, prec)],
            [Symbol("result", base, size, prec)],
            "result = bitfieldInsert(base, insert, offset, bits);",
        )

    def bitfieldreverse(base, size, prec):
        return ([Symbol("value", base, size, prec)], [Symbol("result", base, size, "highp")], "result = bitfieldReverse(value);")

    def bitcount(base, size, prec):
        return ([Symbol("value", base, size, prec)], [Symbol("count", "int", size, "mediump")], "count = bitCount(value);")

    def findlsb(base, size, prec):
        return ([Symbol("value", base, size, prec)], [Symbol("lsb", "int", size, "lowp")], "lsb = findLSB(value);")

    def findmsb(base, size, prec):
        return ([Symbol("value", base, size, prec)], [Symbol("msb", "int", size, "lowp")], "msb = findMSB(value);")

    add("uaddcarry", "uaddcarry", uaddcarry, False, True, True)
    add("usubborrow", "usubborrow", usubborrow, False, True, True)
    add("umulextended", "umulextended", umulextended, False, True, False)
    add("imulextended", "imulextended", imulextended, True, False, False)
    add("bitfieldextract", "bitfieldextract", bitfieldextract, True, True, True)
    add("bitfieldinsert", "bitfieldinsert", bitfieldinsert, True, True, True)
    add("bitfieldreverse", "bitfieldreverse", bitfieldreverse, True, True, True)
    add("bitcount", "bitcount", bitcount, True, True, True)
    add("findlsb", "findlsb", findlsb, True, True, True)
    add("findmsb", "findMSB", findmsb, True, True, True)

    specs.append(
        Spec(
            "integer_bitwise_vector_modulo",
            [Symbol("input1", "int")],
            [Symbol("outVal", "uint")],
            "",
            "// a.y evaluates to (2u | 1u) = 3u. On a buggy driver, the compiler\n"
            "// misoptimizes the negation and modulo operations\n"
            "uvec2 a = uvec2(input1, 2u) | 1u;\n"
            "uint b = ~a.y;\n"
            "outVal = b % 2u;\n",
            stages=("compute",),
        )
    )

    shift_outputs = [
        ("signExtendEqualShift", "int(highBitMaskPattern << 22u) >> 22"),
        ("signExtendCompoundShift", "int(highBitMaskPattern << 12u) >> 22"),
        ("zeroExtendCompoundShift", "int(highBitMaskPattern << 2u) >> 22"),
        ("signExtendReducedShift", "int(highBitMaskPattern << 22u) >> 10"),
        ("logicalShiftCast", "int(highBitMaskPattern >> 30u)"),
        ("logicalShiftCompound", "int((highBitMaskPattern << 22u) >> 22u)"),
        ("posIntLeftRightMask", "(mixedBitsPattern << 24) >> 14"),
        ("posIntRightLeftMask", "(mixedBitsPattern >> 24) << 14"),
        ("shiftLeftClearAll", "(lowBitsPattern << 30) >> 10"),
        ("shiftRightClearAll", "lowBitsPattern >> 10"),
        ("negIntSignFlip", "(negativeValue << 22) >> 14"),
        ("negIntSignExtend", "(negativeValue >> 22) << 14"),
        ("maxArithmeticShiftRight", "negativeValue >> 31"),
        ("maxShiftLeftOdd", "mixedBitsPattern << 31"),
        ("consecutiveRightShiftPos", "(mixedBitsPattern >> 8) >> 8"),
        ("consecutiveRightShiftNeg", "(negativeValue >> 10) >> 10"),
        ("identityRightShift", "(negativeValue << 10) >> 0"),
        ("identityLeftShift", "(mixedBitsPattern >> 0) << 14"),
    ]
    groups = {
        "signExtendEqualShift": "// Group 1: Unsigned-to-Signed Compound Shifts",
        "logicalShiftCompound": "// Group 2: Arithmetic vs. Logical Right Shift Distinction",
        "posIntLeftRightMask": "// Group 3: Positive Integer Bitfield Extraction & Masking",
        "negIntSignFlip": "// Group 4: Negative Integer Compound Shifts & Sign Flipping",
        "maxArithmeticShiftRight": "// Group 5: Maximum Legal 32-bit Shift Boundary",
        "consecutiveRightShiftPos": "// Group 6: Consecutive Shift Folding & Identity Shifts",
    }
    source = ""
    for ndx, (name, expr) in enumerate(shift_outputs):
        if name in groups:
            source += ("\n" if ndx else "") + groups[name] + "\n"
        source += f"{name.ljust(24)} = {expr};\n"
    specs.append(
        Spec(
            "integer_bitwise_nested_literal_shifts",
            [Symbol("highBitMaskPattern", "uint"), Symbol("lowBitsPattern", "int"), Symbol("mixedBitsPattern", "int"), Symbol("negativeValue", "int")],
            [Symbol(name, "int") for name, _ in shift_outputs],
            "",
            source,
            stages=("compute",),
        )
    )
    return specs


class DeRandom:
    """`de::Random`, the xorshift128 stream of deRandom.c."""

    M = 0xFFFFFFFF

    def __init__(self, seed):
        self.x = ((-seed) & self.M) ^ 123456789
        self.y = (362436069 * seed) & self.M
        self.z = 521288629 ^ (seed >> 7)
        self.w = 88675123 ^ ((seed << 3) & self.M)

    def get_uint32(self):
        w = self.w
        t = self.x ^ ((self.x << 11) & self.M)
        self.x = self.y
        self.y = self.z
        self.z = w
        w = (w ^ (w >> 19)) ^ (t ^ (t >> 8))
        self.w = w & self.M
        return self.w

    def get_int(self, lo, hi):
        return lo + self.get_uint32() % (hi - lo + 1)


def de_int32_hash(a):
    key = a & 0xFFFFFFFF
    key = (key ^ 61) ^ (key >> 16)
    key = (key + ((key << 3) & 0xFFFFFFFF)) & 0xFFFFFFFF
    key ^= key >> 4
    key = (key * 0x27D4EB2D) & 0xFFFFFFFF
    key ^= key >> 15
    return key


INDEX_EXPR_TYPES = ["const_literal", "const_expression", "uniform", "dynamically_uniform"]
OPAQUE_SHADER_TYPES = ["vertex", "fragment", "geometry", "tess_ctrl", "tess_eval", "compute"]
OPAQUE_STAGE_NAMES = {"vertex": "vertex", "fragment": "fragment", "geometry": "geometry", "tess_ctrl": "tessellation_control", "tess_eval": "tessellation_evaluation", "compute": "compute"}


def opaque_type_indexing_specs():
    """The block array and atomic counter cases of vktOpaqueTypeIndexingTests.cpp: one spec per case, the read indices coming from the case's `de::Random`."""
    specs = []
    num_instances, num_reads, num_counters, num_ops = 4, 4, 4, 4

    def uniform_index_vars(binding, prefix, count):
        return f"layout(set = 1, binding = {binding}, std140) uniform Indices\n{{\n" + "".join(f"\thighp int {prefix}{ndx};\n" for ndx in range(count)) + "};\n"

    def index_expr(kind, indices, ndx, prefix):
        if kind == 0:
            return str(indices[ndx])
        if kind == 1:
            return f"indexBase + {indices[ndx] - 1}"
        return f"{prefix}{ndx}"

    for group, block_type, spirv in (("ubo", 0, None), ("ssbo", 1, "spirv1.0"), ("ssbo_storage_buffer_decoration", 1, "spirv1.3")):
        for kind, kind_name in enumerate(INDEX_EXPR_TYPES):
            for shader_ndx, shader_name in enumerate(OPAQUE_SHADER_TYPES):
                rnd = DeRandom(de_int32_hash(shader_ndx) ^ de_int32_hash(block_type) ^ de_int32_hash(kind))
                read_indices = [rnd.get_int(0, num_instances - 1) for _ in range(num_reads)]
                interface = "uniform" if block_type == 0 else "readonly buffer"
                glob = ""
                if kind != 0:
                    glob += "#extension GL_EXT_gpu_shader5 : require\n"
                if kind == 1:
                    glob += "const highp int indexBase = 1;\n"
                glob += f"layout(set = 1, binding = 0) {interface} Block\n{{\n    highp uint value;\n}} block[{num_instances}];\n"
                inputs = []
                if kind == 3:
                    inputs = [Symbol(f"index{ndx}", "int") for ndx in range(num_reads)]
                elif kind == 2:
                    glob += uniform_index_vars(num_instances, "index", num_reads)
                outputs = [Symbol(f"result{ndx}", "uint") for ndx in range(num_reads)]
                source = "".join(f"result{ndx} = block[{index_expr(kind, read_indices, ndx, 'index')}].value;\n" for ndx in range(num_reads))
                specs.append(Spec(f"opaque_{group}_{kind_name}_{shader_name}", inputs, outputs, glob, source, stages=(OPAQUE_STAGE_NAMES[shader_name],), spirv_version=spirv))

    for kind, kind_name in enumerate(INDEX_EXPR_TYPES):
        for shader_ndx, shader_name in enumerate(OPAQUE_SHADER_TYPES):
            rnd = DeRandom(de_int32_hash(shader_ndx) ^ de_int32_hash(kind))
            op_indices = [rnd.get_int(0, num_ops - 1) for _ in range(num_ops)]
            glob = ""
            if kind != 0:
                glob += "#extension GL_EXT_gpu_shader5 : require\n"
            if kind == 1:
                glob += "const highp int indexBase = 1;\n"
            glob += f"layout(set = 1, binding = 0, std430) buffer AtomicBuffer {{ highp uint counter[{num_counters}]; }};\n"
            inputs = []
            if kind == 3:
                inputs = [Symbol(f"index{ndx}", "int") for ndx in range(num_ops)]
            elif kind == 2:
                glob += uniform_index_vars(1, "index", num_ops)
            outputs = [Symbol(f"result{ndx}", "uint") for ndx in range(num_ops)]
            source = "".join(f"result{ndx} = atomicAdd(counter[{index_expr(kind, op_indices, ndx, 'index')}], uint(1));\n" for ndx in range(num_ops))
            specs.append(Spec(f"opaque_atomic_counter_{kind_name}_{shader_name}", inputs, outputs, glob, source, stages=(OPAQUE_STAGE_NAMES[shader_name],)))
    return specs


# The sampler types of OpaqueTypeIndexingTests::init in its order: (GLSL name, index in glu::DataType, texture type, kind of the lookup result).
SAMPLER_TYPES = [
    ("sampler1D", 44, "1d", "float"),
    ("sampler1DArray", 47, "1d_array", "float"),
    ("sampler1DArrayShadow", 54, "1d_array", "shadow"),
    ("sampler2D", 45, "2d", "float"),
    ("samplerCube", 46, "cube", "float"),
    ("sampler2DArray", 48, "2d_array", "float"),
    ("sampler3D", 49, "3d", "float"),
    ("sampler1DShadow", 51, "1d", "shadow"),
    ("sampler2DShadow", 52, "2d", "shadow"),
    ("samplerCubeShadow", 53, "cube", "shadow"),
    ("sampler2DArrayShadow", 55, "2d_array", "shadow"),
    ("isampler1D", 57, "1d", "int"),
    ("isampler1DArray", 60, "1d_array", "int"),
    ("isampler2D", 58, "2d", "int"),
    ("isamplerCube", 59, "cube", "int"),
    ("isampler2DArray", 61, "2d_array", "int"),
    ("isampler3D", 62, "3d", "int"),
    ("usampler1D", 64, "1d", "uint"),
    ("usampler1DArray", 67, "1d_array", "uint"),
    ("usampler2D", 65, "2d", "uint"),
    ("usamplerCube", 66, "cube", "uint"),
    ("usampler2DArray", 68, "2d_array", "uint"),
    ("usampler3D", 69, "3d", "uint"),
]
SAMPLER_COORDS = {"1d": 1, "1d_array": 2, "2d": 2, "cube": 3, "2d_array": 3, "3d": 3}


def sampler_coord_count(glsl_name, tex_type, kind):
    count = SAMPLER_COORDS[tex_type]
    if glsl_name == "sampler1DShadow":
        return 3
    return count + 1 if kind == "shadow" else count


def opaque_sampler_specs():
    """The `sampler` group of vktOpaqueTypeIndexingTests.cpp over the vertex, fragment and compute executors."""
    specs = []
    num_samplers, num_lookups = 8, 4
    for kind, kind_name in enumerate(INDEX_EXPR_TYPES):
        for shader_ndx, shader_name in enumerate(OPAQUE_SHADER_TYPES):
            if shader_name not in ("vertex", "fragment", "compute"):
                continue
            for glsl_name, type_ndx, tex_type, result_kind in SAMPLER_TYPES:
                rnd = DeRandom(de_int32_hash(type_ndx) ^ de_int32_hash(shader_ndx) ^ de_int32_hash(kind))
                lookup_indices = [rnd.get_int(0, num_samplers - 1) for _ in range(num_lookups)]
                glob = ""
                if kind != 0:
                    glob += "#extension GL_EXT_gpu_shader5 : require\n"
                if kind == 1:
                    glob += "const highp int indexBase = 1;\n"
                glob += f"layout(set = 1, binding = 0) uniform highp {glsl_name} texSampler[{num_samplers}];\n"
                inputs = [Symbol("coords", "float", sampler_coord_count(glsl_name, tex_type, result_kind))]
                if kind == 3:
                    inputs += [Symbol(f"index{ndx}", "int") for ndx in range(num_lookups)]
                elif kind == 2:
                    glob += f"layout(set = 1, binding = {num_samplers}, std140) uniform Indices\n{{\n" + "".join(f"\thighp int index{ndx};\n" for ndx in range(num_lookups)) + "};\n"
                out_kind, out_size = {"float": ("float", 4), "shadow": ("float", 1), "int": ("int", 4), "uint": ("uint", 4)}[result_kind]
                outputs = [Symbol(f"result{ndx}", out_kind, out_size) for ndx in range(num_lookups)]
                lines = ""
                for ndx in range(num_lookups):
                    if kind == 0:
                        idx = str(lookup_indices[ndx])
                    elif kind == 1:
                        idx = f"indexBase + {lookup_indices[ndx] - 1}"
                    else:
                        idx = f"index{ndx}"
                    lines += f"result{ndx} = texture(texSampler[{idx}], coords);\n"
                specs.append(Spec(f"opaque_sampler_{kind_name}_{shader_name}_{glsl_name.lower()}", inputs, outputs, glob, lines, stages=(OPAQUE_STAGE_NAMES[shader_name],)))
    return specs


def common_function_specs():
    """The specs of vktShaderCommonFunctionTests.cpp (vec5 is VK_EXT_shader_long_vector): compute shaders only."""
    specs = []

    def add(name, base, sizes, precisions, make):
        for size in sizes:
            for prec in precisions:
                inputs, outputs, source = make(base, size, prec)
                specs.append(Spec(f"common_{name}_{base}{size}" + (f"_{prec}" if prec else ""), inputs, outputs, "", source, stages=("compute",)))

    add("abs", "int", range(1, 6), ("mediump", "highp"), lambda b, n, p: ([Symbol("in0", b, n, p)], [Symbol("out0", b, n, p)], "out0 = abs(in0);"))
    add("sign", "int", range(1, 6), ("mediump", "highp"), lambda b, n, p: ([Symbol("in0", b, n, p)], [Symbol("out0", b, n, p)], "out0 = sign(in0);"))
    add("isnan", "float", range(1, 6), ("mediump", "highp"), lambda b, n, p: ([Symbol("in0", b, n, p)], [Symbol("out0", "bool", n, "")], "out0 = isnan(in0);"))
    add("isinf", "float", range(1, 6), ("mediump", "highp"), lambda b, n, p: ([Symbol("in0", b, n, p)], [Symbol("out0", "bool", n, "")], "out0 = isinf(in0);"))
    add("floatbitstoint", "float", range(1, 6), ("mediump", "highp"), lambda b, n, p: ([Symbol("in0", b, n, p)], [Symbol("out0", "int", n, "highp")], "out0 = floatBitsToInt(in0);"))
    add("floatbitstouint", "float", range(1, 6), ("mediump", "highp"), lambda b, n, p: ([Symbol("in0", b, n, p)], [Symbol("out0", "uint", n, "highp")], "out0 = floatBitsToUint(in0);"))
    add("intbitstofloat", "int", range(1, 6), ("highp",), lambda b, n, p: ([Symbol("in0", b, n, p)], [Symbol("out0", "float", n, "highp")], "out0 = intBitsToFloat(in0);"))
    add("uintbitstofloat", "uint", range(1, 6), ("highp",), lambda b, n, p: ([Symbol("in0", b, n, p)], [Symbol("out0", "float", n, "highp")], "out0 = uintBitsToFloat(in0);"))
    for name, glsl_fn in (("isnan", "isnan"), ("isinf", "isinf")):
        add(name, "double", range(1, 6), ("",), lambda b, n, p, f=glsl_fn: ([Symbol("in0", b, n, p)], [Symbol("out0", "bool", n, "")], f"out0 = {f}(in0);"))
    specs.append(
        Spec(
            "common_clamp_const_array_dynamic_index",
            [Symbol("in0", "int")],
            [Symbol("out0", "float", 2)],
            "const vec2 data[4] = vec2[](\n    vec2(-1.0, -1.0),\n    vec2(3.0, -1.0),\n    vec2(-1.0, 3.0),\n    vec2(3.0, 3.0)\n);\n",
            "vec2 pos_xy = data[clamp(in0, 0, 3)];\nout0 = clamp(pos_xy, vec2(0.0, 0.0), vec2(1.0, 1.0));\n",
            stages=("compute",),
        )
    )
    return specs


def packing_function_specs():
    """The specs of vktShaderPackingFunctionTests.cpp: the 4x8 functions over every shader type, the 2x16 ones over geometry and compute only."""
    specs = []
    new_stages = ("geometry", "compute")
    for name, width, pack, unpack_vec, stages in (
        ("snorm2x16", 2, True, 2, new_stages),
        ("unorm2x16", 2, True, 2, new_stages),
        ("snorm4x8", 4, True, 4, None),
        ("unorm4x8", 4, True, 4, None),
    ):
        for prec in ("mediump", "highp"):
            specs.append(
                Spec(f"pack_{name}_{prec}", [Symbol("in0", "float", width, prec)], [Symbol("out0", "uint")], "", f"out0 = pack{name[0].upper()}{name[1:]}(in0);", stages=stages)
            )
        specs.append(Spec(f"unpack_{name}", [Symbol("in0", "uint")], [Symbol("out0", "float", width)], "", f"out0 = unpack{name[0].upper()}{name[1:]}(in0);", stages=stages))
    specs.append(Spec("pack_half2x16", [Symbol("in0", "float", 2)], [Symbol("out0", "uint")], "", "out0 = packHalf2x16(in0);", stages=new_stages))
    specs.append(Spec("unpack_half2x16", [Symbol("in0", "uint")], [Symbol("out0", "float", 2, "mediump")], "", "out0 = unpackHalf2x16(in0);", stages=new_stages))
    return specs


ATOMIC_OPS = [("exchange", "atomicExchange"), ("comp_swap", "atomicCompSwap"), ("add", "atomicAdd"), ("min", "atomicMin"), ("max", "atomicMax"), ("and", "atomicAnd"), ("or", "atomicOr"), ("xor", "atomicXor")]
ATOMIC_DATA_TYPES = [
    ("float16", "float16_t", True), ("f16vec2", "f16vec2", True), ("f16vec4", "f16vec4", True), ("signed", "int", False), ("unsigned", "uint", False),
    ("float32", "float", True), ("signed64bit", "int64_t", False), ("unsigned64bit", "uint64_t", False), ("float64", "double", True),
]
ATOMIC_NUM_ELEMENTS = 32


def atomic_operation_specs():
    """The cases of vktAtomicOperationTests.cpp `createShaderSpec`, for the executors that are ported (the mesh and task ones are stubs): one spec per
    operation, data type, shader type and memory type (buffer, shared, reference), the strings of upstream's `AtomicOperationCase::createShaderSpec`."""
    specs = []
    n = ATOMIC_NUM_ELEMENTS
    shader_types = [("vertex", "vertex"), ("fragment", "fragment"), ("geometry", "geometry"), ("tess_ctrl", "tessellation_control"), ("tess_eval", "tessellation_evaluation"), ("compute", "compute"), ("task", "task"), ("mesh", "mesh")]
    for op_name, glsl_op in ATOMIC_OPS:
        for dt_name, glsl_type, is_float in ATOMIC_DATA_TYPES:
            if is_float and op_name not in ("add", "min", "max", "exchange"):
                continue
            if dt_name in ("signed64bit", "unsigned64bit"):
                extensions = "#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable\n#extension GL_EXT_shader_atomic_int64 : enable\n"
            elif is_float:
                extensions = (
                    "#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable\n#extension GL_EXT_shader_atomic_float : enable\n"
                    "#extension GL_EXT_shader_atomic_float2 : enable\n#extension GL_KHR_memory_scope_semantics : enable\n"
                )
                if dt_name in ("f16vec2", "f16vec4"):
                    extensions += "#extension GL_NV_shader_atomic_fp16_vector : require\n"
            else:
                extensions = ""
            for shader_name, stage_name in shader_types:
                for memory, suffix in (("buffer", ""), ("shared", "_shared"), ("reference", "_reference"), ("payload", "_payload")):
                    if memory == "shared" and shader_name not in ("compute", "task", "mesh"):
                        continue
                    if memory == "payload" and shader_name != "task":
                        continue
                    shared_like = memory in ("shared", "payload")
                    ext = extensions + ("#extension GL_EXT_buffer_reference : require\n" if memory == "reference" else "")
                    result_name = "result" if shared_like else "buf"
                    glob = f"{ext}\nstruct AtomicStruct\n{{\n"
                    glob += f"    {glsl_type} inoutValues[{n}/2];\n    {glsl_type} inputValues[{n}];\n    {glsl_type} compareValues[{n}];\n    {glsl_type} outputValues[{n}];\n"
                    glob += f"    int invocationHitCount[{n}];\n    int index;\n}};\n\n"
                    if memory != "reference":
                        glob += f"layout (set = 1, binding = 0) buffer AtomicBuffer {{\n    AtomicStruct data;\n}} {result_name};\n\n"
                        if memory == "shared":
                            glob += "shared struct { AtomicStruct data; } buf;\n\n"
                        elif memory == "payload":
                            glob += "struct TaskData { AtomicStruct data; };\ntaskPayloadSharedEXT TaskData buf;\n"
                    else:
                        glob += "layout (buffer_reference) buffer AtomicBuffer {\n    AtomicStruct data;\n};\n\n"
                        glob += "layout (set = 1, binding = 0) uniform References {\n    AtomicBuffer buf;\n};\n\n"
                    compare_arg = "buf.data.compareValues[idx], " if op_name == "comp_swap" else ""
                    call = f"buf.data.outputValues[idx] = {glsl_op}(buf.data.inoutValues[idx % ({n}/2)], {compare_arg}buf.data.inputValues[idx]);\n"
                    if shader_name == "vertex":
                        source = f"int idx = gl_VertexIndex;\nif (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)\n{{\n    {call}}}\n"
                    else:
                        source = ""
                        if shared_like:
                            source += f"if (gl_LocalInvocationIndex == 0u)\n{{\n    buf.data = {result_name}.data;\n}}\nbarrier();\n"
                        if shader_name == "fragment":
                            source += f"if (!gl_HelperInvocation) {{\n    int idx = atomicAdd(buf.data.index, 1);\n    {call}}}\n"
                        else:
                            source += f"if (atomicAdd(buf.data.invocationHitCount[0], 1) < {n})\n{{\n    int idx = atomicAdd(buf.data.index, 1);\n    {call}}}\n"
                        if shared_like:
                            source += f"barrier();\nif (gl_LocalInvocationIndex == 0u)\n{{\n    {result_name}.data = buf.data;\n}}\n"
                    specs.append(
                        Spec(f"atomic_{op_name}_{dt_name}_{shader_name}{suffix}", [], [Symbol("outData", "uint")], glob, source, stages=(stage_name,), local_size_x=n if shared_like else 1, mesh_task=shader_name in ("task", "mesh"))
                    )
    return specs


def shader_clock_specs():
    """The specs of vktShaderClockTests.cpp `initShaderSpec`, for the vertex and fragment stages (the compute stage goes through gen_shader_clock_manifest.py)."""
    specs = []
    for name, device, bits64 in (("clockARB", False, True), ("clock2x32ARB", False, False), ("clockRealtimeEXT", True, True), ("clockRealtime2x32EXT", True, False)):
        extensions = "#extension GL_ARB_gpu_shader_int64 : require\n" if bits64 else ""
        extensions += "#extension GL_EXT_shader_realtime_clock : require\n" if device else "#extension GL_ARB_shader_clock : enable\n"
        if bits64:
            source = f"uint64_t time1 = {name}();\nuint64_t time2 = {name}();\nout0 = uvec2(0, 0);\nif (time1 > time2) {{\n    out0.x = 1;\n}}\n"
        else:
            source = (
                f"uvec2 time1 = {name}();\nuvec2 time2 = {name}();\nout0 = uvec2(0, 0);\n"
                "if (time1.y > time2.y || (time1.y == time2.y && time1.x > time2.x)){\n    out0.x = 1;\n}\n"
            )
        specs.append(Spec(f"shader_clock_{name}", [], [Symbol("out0", "uint", 2)], extensions, source, stages=("vertex", "fragment")))
    return specs


def ycbcr_conversion_specs():
    """The specs of vktYCbCrConversionTests.cpp `createShaderSpec`: one sampler or an array of four (one per colour model), at each sampler binding, run by the vertex, fragment and compute executors."""
    specs = []
    for binding in (0, 7, 15, 31):
        specs.append(
            Spec(
                f"ycbcr_conv_b{binding}",
                [Symbol("uv", "float", 2)],
                [Symbol("o_color", "float", 4)],
                f"layout(set=1, binding={binding}) uniform highp sampler2D u_sampler;",
                "o_color = texture(u_sampler, uv);\n",
                stages=("vertex", "fragment", "compute"),
            )
        )
        specs.append(
            Spec(
                f"ycbcr_conv_array_b{binding}",
                [Symbol("uv", "float", 2)],
                [Symbol(f"o_color{i}", "float", 4) for i in range(4)],
                f"layout(set=1, binding={binding}) uniform highp sampler2D u_sampler[4];",
                "".join(f"o_color{i} = texture(u_sampler[{i}], uv);\n" for i in range(4)),
                stages=("vertex", "fragment", "compute"),
            )
        )
    return specs


SPECS = [
    # vktYCbCrFormatTests.cpp getShaderSpec: one spec per useArrayLayers
    sampler_spec("ycbcr_format_2d", "sampler2D"),
    sampler_spec("ycbcr_format_array", "sampler2DArray"),
    # vktYCbCrViewTests.cpp getShaderSpec: one spec per sampled type of the plane compatible format
    *[
        Spec(
            f"ycbcr_view_{kind}",
            [Symbol("texCoord", "float", 2)],
            [Symbol("result0", "float", 4), Symbol("result1", kind, 4)],
            f"layout(binding = 1, set = 1) uniform highp sampler2D u_image;\nlayout(binding = 0, set = 1) uniform highp {sampler} u_planeView;\n",
            f"result0 = texture(u_image, texCoord);\nresult1 = {vec}(texture(u_planeView, texCoord));\n",
        )
        for kind, sampler, vec in (("float", "sampler2D", "vec4"), ("int", "isampler2D", "ivec4"), ("uint", "usampler2D", "uvec4"))
    ],
    # vktYCbCrImageQueryTests.cpp getShaderSpec
    Spec(
        "ycbcr_query_size_lod",
        [Symbol("lod", "int")],
        [Symbol("result", "int", 2)],
        "layout(binding = 0, set = 1) uniform highp sampler2D u_image;\n",
        "result = textureSize(u_image, lod);\n",
        mesh_task=True,
    ),
    Spec(
        "ycbcr_query_levels",
        [Symbol("lod", "int")],
        [Symbol("result", "int")],
        "layout(binding = 0, set = 1) uniform highp sampler2D u_image;\n",
        "result = textureQueryLevels(u_image);\n",
        mesh_task=True,
    ),
] + ycbcr_conversion_specs() + integer_function_specs() + packing_function_specs() + common_function_specs() + opaque_type_indexing_specs() + opaque_sampler_specs() + atomic_operation_specs() + shader_clock_specs()


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for the ShaderExecutor specs of dEQP-VK (ycbcr.query, ycbcr.plane_view, glsl.builtin.function.integer, pack_unpack and common, glsl.opaque_type_indexing).",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_executor_programs.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderexecutor/vktShaderExecutor.cpp"',
        'rust_module = "shaderexecutor"',
        "",
    ]
    for spec in SPECS:
        for shader_type, programs in program_sets(spec):
            if spec.stages is not None and shader_type not in spec.stages:
                continue
            name = f"se_{spec.key}__{shader_type}"
            out += ["[[case]]", f'name = "{name}"', f'rust_const = "{name.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
            for program_name, stage, source in programs:
                template = f"shader_executor/{name}_{program_name}.{stage}"
                (SRC / f"{name}_{program_name}.{stage}").write_text(source)
                spirv_version = spec.spirv_version or ("spirv1.4" if stage in ("mesh", "task") else None)
                spirv = f', spirv_version = "{spirv_version}"' if spirv_version else ""
                out.append(f'    {{ name = "{program_name}", template = "{template}", stage = "{stage}"{spirv} }},')
            out += ["]", ""]
    MANIFEST.write_text("\n".join(out))


if __name__ == "__main__":
    main()

"""The case tree and the shader sources of dEQP-VK.robustness.{robustness2,image_robustness,pipeline_robustness}.*

`createTests`, `createLongVectorTests`, `generateLayout` and `RobustnessExtsTestCase::initPrograms` of vktRobustnessExtsTests.cpp, transliterated.
Used by gen_robustness_exts_manifest.py (shader manifest and the Rust program table) and checkable against tmp/missing_vk.txt (written by `missing_cases.py`).

A pure text module: no glslang and no cargo.
"""

import struct
from dataclasses import dataclass, field, replace

# VkDescriptorType values, plus upstream's phony VERTEX_ATTRIBUTE_FETCH
UBO, SSBO, UBO_DYN, SSBO_DYN, UTB, STB, SIMG, CIS, VAF = 6, 7, 8, 9, 4, 5, 3, 1, 999
STAGE_COMPUTE, STAGE_VERTEX, STAGE_FRAGMENT, STAGE_RAYGEN = 0, 1, 2, 3
V1D, V2D, V3D, VCUBE, V1DA, V2DA, VCUBEA = "1d", "2d", "3d", "cube", "1d_array", "2d_array", "cube_array"
NULL_LEN = -1

LV_NONE, LV_F32, LV_I32, LV_U32, LV_F16 = 0, 1, 2, 3, 4

FORMATS = [
    ("R32_SINT", "r32i"), ("R32_UINT", "r32ui"), ("R32_SFLOAT", "r32f"), ("R32G32_SINT", "rg32i"), ("R32G32_UINT", "rg32ui"), ("R32G32_SFLOAT", "rg32f"),
    ("R32G32B32A32_SINT", "rgba32i"), ("R32G32B32A32_UINT", "rgba32ui"), ("R32G32B32A32_SFLOAT", "rgba32f"), ("R64_SINT", "r64i"), ("R64_UINT", "r64ui"),
]
FULL_DESC = [(UBO, "uniform_buffer"), (SSBO, "storage_buffer"), (UBO_DYN, "uniform_buffer_dynamic"), (SSBO_DYN, "storage_buffer_dynamic"),
             (UTB, "uniform_texel_buffer"), (STB, "storage_texel_buffer"), (SIMG, "storage_image"), (CIS, "sampled_image"), (VAF, "vertex_attribute_fetch")]
IMG_DESC = [(SIMG, "storage_image"), (CIS, "sampled_image")]
LEN32 = [(NULL_LEN, "null_descriptor"), (0, "img"), (4, "len_4"), (8, "len_8"), (12, "len_12"), (16, "len_16"), (20, "len_20"), (31, "len_31"), (32, "len_32"),
         (33, "len_33"), (35, "len_35"), (36, "len_36"), (39, "len_39"), (40, "len_41"), (252, "len_252"), (256, "len_256"), (260, "len_260")]
LEN64 = [(NULL_LEN, "null_descriptor"), (0, "img"), (8, "len_8"), (16, "len_16"), (24, "len_24"), (32, "len_32"), (40, "len_40"), (62, "len_62"), (64, "len_64"),
         (66, "len_66"), (70, "len_70"), (72, "len_72"), (78, "len_78"), (80, "len_80"), (504, "len_504"), (512, "len_512"), (520, "len_520")]
IMG_LEN = [(0, "img")]
VIEWS = [V1D, V2D, V3D, VCUBE, V1DA, V2DA, VCUBEA]
SAMPLES = [(1, "samples_1"), (4, "samples_4")]
STAGES = [(STAGE_COMPUTE, "comp"), (STAGE_FRAGMENT, "frag"), (STAGE_VERTEX, "vert"), (STAGE_RAYGEN, "rgen")]
QUEUES = [(0, ""), (1, "compute")]
VOLS = [(0, "nonvolatile"), (1, "volatile")]
UNROLLS = [(0, "dontunroll"), (1, "unroll")]
TEMPS = [(0, "notemplate"), (1, "template")]
PUSHES = [(0, "bind"), (1, "push")]
FMTQUALS = [(0, "no_fmt_qual"), (1, "fmt_qual")]
READONLYS = [(0, "readwrite"), (1, "readonly")]

PR_DISABLED, PR_MONO, PR_FAST_GPL, PR_OPT_GPL = 0, 1, 2, 3
GPL_SUFFIX = {PR_DISABLED: "", PR_MONO: "", PR_FAST_GPL: "_fast_gpl", PR_OPT_GPL: "_optimized_gpl"}


def is_r64(fmt):
    return fmt in ("R64_SINT", "R64_UINT")


def is_float(fmt):
    return fmt in ("R32_SFLOAT", "R32G32_SFLOAT", "R32G32B32A32_SFLOAT")


def is_signed(fmt):
    return fmt in ("R32_SINT", "R64_SINT", "R32G32_SINT", "R32G32B32A32_SINT")


def pixel_size(fmt):
    return {"R32": 4, "R64": 8, "R32G32": 8, "R32G32B32A32": 16}[fmt.rsplit("_", 1)[0]]


def channel_size(fmt):
    return 8 if is_r64(fmt) else 4


def supports_stores(desc):
    return desc in (SSBO_DYN, SSBO, STB, SIMG)


@dataclass(frozen=True)
class Case:
    fmt: str
    stage: int
    desc: int
    view: str
    samples: int
    buffer_len: int
    unroll: bool
    vol: bool
    null_descriptor: bool
    use_template: bool
    format_qualifier: bool
    push_descriptor: bool
    test_robustness2: bool
    pipeline_robustness_case: int
    image_dim: tuple
    read_only: bool
    uses_64bit_indexing: bool
    use_compute_queue: bool
    lv_components: int = 0
    lv_scalar: int = LV_NONE

    @property
    def is_long_vector(self):
        return self.lv_components != 0

    @property
    def needs_scalar_block_layout(self):
        return self.desc in (UBO_DYN, UBO, SSBO_DYN, SSBO)

    @property
    def needs_pipeline_robustness(self):
        return self.pipeline_robustness_case != PR_DISABLED


def enumerate_cases(robustness2, pipeline_robustness, uses_64bit_indexing):
    """`createTests`: yields (path components, Case)."""
    out = []
    for push, push_name in PUSHES:
        for temp, temp_name in TEMPS:
            for fmt, fmt_name in FORMATS:
                if (pipeline_robustness or uses_64bit_indexing) and fmt not in ("R32_UINT", "R32G32B32A32_SFLOAT", "R64_SINT"):
                    continue
                fmt_size = pixel_size(fmt)
                for unroll, unroll_name in UNROLLS:
                    # upstream: `if (unrollNdx > 0 && (pipelineRobustness || uses64BitIndexing)) continue;`
                    if unroll > 0 and (pipeline_robustness or uses_64bit_indexing):
                        continue
                    for vol, vol_name in VOLS:
                        desc_cases = FULL_DESC if robustness2 else IMG_DESC
                        for desc, desc_name in desc_cases:
                            if pipeline_robustness and desc not in (UBO, SSBO, CIS, VAF):
                                continue
                            if uses_64bit_indexing and desc != SSBO:
                                continue
                            if fmt == "R64_SINT" and desc == UTB:
                                continue
                            for ro, ro_name in READONLYS:
                                if ro != 0 and desc not in (SSBO, SSBO_DYN):
                                    continue
                                if (pipeline_robustness or uses_64bit_indexing) and ro != 0:
                                    continue
                                for fq, fq_name in FMTQUALS:
                                    if fq and desc not in (STB, SIMG):
                                        continue
                                    if push and desc in (UBO_DYN, SSBO_DYN, VAF):
                                        continue
                                    r64 = is_r64(fmt)
                                    if robustness2:
                                        len_cases = LEN64 if r64 else LEN32
                                    else:
                                        len_cases = IMG_LEN
                                    for ln, len_name in len_cases:
                                        if ln != NULL_LEN:
                                            buffer_len = ln != 0
                                            buffer_desc = desc not in (SIMG, CIS)
                                            if buffer_len != buffer_desc:
                                                continue
                                            if temp:
                                                continue
                                        if desc in (STB, UTB) and ln != NULL_LEN and (ln % fmt_size) != 0:
                                            continue
                                        lnu = ln & 0xFFFFFFFF
                                        if (pipeline_robustness or uses_64bit_indexing) and robustness2 and (lnu == 0 or (lnu & (lnu - 1)) != 0):
                                            continue
                                        if vol and not supports_stores(desc):
                                            continue
                                        for samp, samp_name in SAMPLES:
                                            if pipeline_robustness and samp != 1:
                                                continue
                                            if samp != 1 and desc not in (SIMG, CIS):
                                                continue
                                            for view in VIEWS:
                                                if view != V1D and desc not in (SIMG, CIS):
                                                    continue
                                                if view not in (V2D, V2DA) and samp != 1:
                                                    continue
                                                if pipeline_robustness and view not in (V1D, V2D, V2DA):
                                                    continue
                                                for stage, stage_name in STAGES:
                                                    if stage == STAGE_RAYGEN and pipeline_robustness:
                                                        continue
                                                    if ln == NULL_LEN and pipeline_robustness:
                                                        continue
                                                    if desc == VAF and stage != STAGE_VERTEX:
                                                        continue
                                                    image_dim = [5, 11, 6]
                                                    if view in (VCUBE, VCUBEA):
                                                        image_dim[1] = image_dim[0]
                                                    if not pipeline_robustness:
                                                        prcases = [PR_DISABLED]
                                                    else:
                                                        prcases = [PR_MONO]
                                                        if stage not in (STAGE_RAYGEN, STAGE_COMPUTE):
                                                            prcases += [PR_FAST_GPL, PR_OPT_GPL]
                                                    for prc in prcases:
                                                        for queue, queue_name in QUEUES:
                                                            if stage not in (STAGE_COMPUTE, STAGE_RAYGEN) and queue == 1:
                                                                continue
                                                            c = Case(fmt, stage, desc, view, samp, ln, bool(unroll), bool(vol), ln == NULL_LEN, bool(temp), bool(fq),
                                                                     bool(push), robustness2, prc, tuple(image_dim), ro == 1, uses_64bit_indexing, bool(queue))
                                                            name = stage_name + GPL_SUFFIX[prc] + ("_compute" if queue else "")
                                                            path = [push_name, temp_name, fmt_name, unroll_name, vol_name, desc_name]
                                                            if desc in (SSBO, SSBO_DYN):
                                                                path.append(ro_name)
                                                            path += [fq_name, len_name, samp_name, view, name]
                                                            out.append((path, c))
    return out


LV_SCALARS = [(LV_F32, "f32"), (LV_I32, "i32"), (LV_U32, "u32"), (LV_F16, "f16")]
LV_WIDTHS = [(5, "w5"), (7, "w7"), (8, "w8"), (11, "w11"), (13, "w13"), (16, "w16")]
LV_DESCS = [(SSBO, "ssbo", False), (SSBO_DYN, "ssbo_dyn", False), (UBO, "ubo", True), (UBO_DYN, "ubo_dyn", True)]
LV_LENS = [(32, "len_32"), (256, "len_256"), (260, "len_260")]
LV_UNROLLS = [(True, "unroll"), (False, "dont_unroll")]
LV_ROS = [(False, "readwrite"), (True, "readonly")]


def lv_scalar_size(s):
    return {LV_F16: 2, LV_F32: 4, LV_I32: 4, LV_U32: 4}.get(s, 0)


def enumerate_long_vector(pipeline_robustness):
    """`createLongVectorTests`"""
    out = []
    for scalar, scalar_name in LV_SCALARS:
        for comps, comps_name in LV_WIDTHS:
            for desc, desc_name, is_ubo in LV_DESCS:
                for ln, len_name in LV_LENS:
                    for unroll, unroll_name in LV_UNROLLS:
                        for ro, ro_name in LV_ROS:
                            if is_ubo and not ro:
                                continue
                            element_bytes = comps * lv_scalar_size(scalar)
                            if element_bytes == 0 or ln < element_bytes:
                                continue
                            c = Case("R32_UINT", STAGE_COMPUTE, desc, V1D, 1, ln, unroll, False, False, False, False, False, True,
                                     PR_MONO if pipeline_robustness else PR_DISABLED, (1, 1, 1), ro, False, False, comps, scalar)
                            out.append(([scalar_name, comps_name, desc_name, len_name, "comp", unroll_name, ro_name], c))
    return out


def all_cases():
    """(group path below `robustness`, Case)"""
    out = []
    for path, c in enumerate_cases(True, False, False):
        out.append((["robustness2"] + path, c))
    for path, c in enumerate_cases(True, False, True):
        out.append((["robustness2", "64b_indexing"] + path, c))
    for path, c in enumerate_long_vector(False):
        out.append((["robustness2", "long_vector"] + path, c))
    for path, c in enumerate_cases(False, False, False):
        out.append((["image_robustness"] + path, c))
    for path, c in enumerate_cases(True, True, False):
        out.append((["pipeline_robustness", "robustness2"] + path, c))
    for path, c in enumerate_long_vector(True):
        out.append((["pipeline_robustness", "robustness2", "long_vector"] + path, c))
    for path, c in enumerate_cases(False, True, False):
        out.append((["pipeline_robustness", "image_robustness"] + path, c))
    return out


# ---------------------------------------------------------------------------------------------------------------------
# generateLayout
# ---------------------------------------------------------------------------------------------------------------------


def f16_bits(value):
    return struct.unpack("<H", struct.pack("<e", value))[0]


def generate_ref_data(c):
    """`generateLayout`'s refData as bytes (empty for a null descriptor)."""
    if c.null_descriptor:
        return bytearray()
    if c.is_long_vector:
        scalar_bytes = lv_scalar_size(c.lv_scalar)
        element_bytes = c.lv_components * scalar_bytes
        aligned = 0 if element_bytes == 0 else c.buffer_len // element_bytes * element_bytes
        data = bytearray(aligned)
        for i in range(0 if scalar_bytes == 0 else aligned // scalar_bytes):
            if c.lv_scalar == LV_F32:
                struct.pack_into("<f", data, i * 4, 2.0 * i + 3.0)
            elif c.lv_scalar == LV_I32:
                struct.pack_into("<i", data, i * 4, 2 * i + 3)
            elif c.lv_scalar == LV_U32:
                struct.pack_into("<I", data, i * 4, 2 * i + 3)
            else:
                struct.pack_into("<H", data, i * 2, f16_bits(2.0 * i + 3.0))
        return data
    if c.buffer_len == 0:
        if is_r64(c.fmt):
            data = bytearray(32)
            for i, v in enumerate([0x1234567887654321, 0x234567899, 0x345678909, 0x456789019]):
                struct.pack_into("<Q", data, i * 8, v)
            return data
        data = bytearray(16)
        if is_float(c.fmt):
            for i, v in enumerate([123.0, 234.0, 345.0, 456.0]):
                struct.pack_into("<f", data, i * 4, v)
        else:
            for i, v in enumerate([0x12345678, 0x23456789, 0x34567890, 0x45678901]):
                struct.pack_into("<I", data, i * 4, v)
        return data
    # the float branch writes 2*i+3 as a float and then falls into the integer `else` of the second `if` and overwrites it
    size = c.buffer_len & (~7 if is_r64(c.fmt) else ~3)
    data = bytearray(size)
    for i in range(c.buffer_len // (8 if is_r64(c.fmt) else 4)):
        if is_r64(c.fmt):
            if (i + 1) * 8 <= size:
                struct.pack_into("<Q", data, i * 8, 2 * i + 3)
        else:
            if (i + 1) * 4 <= size:
                struct.pack_into("<I", data, i * 4, 2 * i + 3)
    return data


# ---------------------------------------------------------------------------------------------------------------------
# initPrograms
# ---------------------------------------------------------------------------------------------------------------------

DIM = 8
STORE_VALUE = 123


def round_pow2(x, a):
    return (x + a - 1) // a * a


def cfmt(value):
    """`ostream << float`: six significant digits, `%g`"""
    return f"{value:g}"


def image_qualifier(fmt):
    ty = fmt.split("_")[1]
    bits = fmt.split("_")[0]
    orderpart = {"R32": "r", "R64": "r", "R32G32": "rg", "R32G32B32A32": "rgba"}[bits]
    typepart = {"SFLOAT": "32f", "UINT": "32ui", "SINT": "32i"}[ty]
    if is_r64(fmt):
        typepart = "64ui" if ty == "UINT" else "64i"
    return orderpart + typepart


def gen_coord(c, num_coords, samples, dim):
    if num_coords == 1:
        return c
    if samples != 1:
        num_coords -= 1
    coord = f"ivec{num_coords}("
    for i in range(num_coords):
        coord += c if i == dim else "0"
        if i < num_coords - 1:
            coord += ", "
    coord += ")"
    if samples != 1:
        coord += ", "
        coord += c if dim == num_coords else "0"
    return coord


def gen_coord_norm(case, c, num_coords, num_normalized, dim):
    dim = min(dim, 2)
    if num_coords == 1:
        return f"{c} / float({case.image_dim[dim]})"
    coord = f"vec{num_coords}("
    for i in range(num_coords):
        coord += c if i == dim else "0.25"
        if i < num_normalized:
            coord += f" / float({case.image_dim[dim]})"
        if i < num_coords - 1:
            coord += ", "
    coord += ")"
    return coord


def gen_fetch(case, num_components, vec_type, coord, lod):
    d = case.desc
    if d in (UBO_DYN, UBO):
        return f"{vec_type}(ubo0_1.val[{coord}]" + ", 0" * max(0, 4 - num_components) + ")"
    if d in (SSBO_DYN, SSBO):
        return f"{vec_type}(ssbo0_1.val[{coord}]" + ", 0" * max(0, 4 - num_components) + ")"
    if d == UTB:
        return f"texelFetch(texbo0_1, {coord})"
    if d == STB:
        return f"imageLoad(image0_1, {coord})"
    if d == CIS:
        if case.samples > 1:
            return f"texelFetch(texture0_1, {coord})"
        return f"texelFetch(texture0_1, {coord}, {lod})"
    if d == SIMG:
        return f"imageLoad(image0_1, {coord})"
    if d == VAF:
        return "attr"
    raise AssertionError


def get_store_value(desc, num_components, vec_type, buf_type):
    if desc in (SSBO_DYN, SSBO):
        return f"{vec_type}({buf_type}({STORE_VALUE})" + ", 0" * max(0, 4 - num_components) + ")"
    if desc in (STB, SIMG):
        return f"{vec_type}({STORE_VALUE})"
    raise AssertionError


def gen_store(desc, vec_type, buf_type, coord):
    if desc in (SSBO_DYN, SSBO):
        return f"ssbo0_1.val[{coord}] = {buf_type}({STORE_VALUE})"
    if desc in (STB, SIMG):
        return f"imageStore(image0_1, {coord}, {vec_type}({STORE_VALUE}))"
    raise AssertionError


def gen_atomic(desc, buf_type, coord):
    if desc in (SSBO_DYN, SSBO):
        return f"atomicAdd(ssbo0_1.val[{coord}], {buf_type}(10))"
    if desc in (STB, SIMG):
        return f"imageAtomicAdd(image0_1, {coord}, {buf_type}(10))"
    raise AssertionError


LV_GLSL = {LV_F32: "float", LV_I32: "int", LV_U32: "uint", LV_F16: "float16_t"}


def init_long_vector_programs(c, ref):
    """Returns {program name: (glsl stage, source, spirv version, flags)}"""
    is_ubo = c.desc in (UBO, UBO_DYN)
    emit_store = (not is_ubo) and not c.read_only
    n = c.lv_components
    scalar_bytes = lv_scalar_size(c.lv_scalar)
    element_bytes = n * scalar_bytes
    inbound = 0 if element_bytes == 0 else len(ref) // element_bytes
    num_scalars = inbound * n
    scalar_glsl = LV_GLSL[c.lv_scalar]
    vec_glsl = f"vector<{scalar_glsl}, {n}>"
    store_sentinel = 7777

    s = ("#version 460 core\n#extension GL_EXT_long_vector : enable\n#extension GL_EXT_scalar_block_layout : enable\n"
         "#extension GL_EXT_control_flow_attributes : enable\n#extension GL_EXT_nonuniform_qualifier : enable\n")
    if c.lv_scalar == LV_F16:
        s += "#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable\n#extension GL_EXT_shader_16bit_storage : enable\n"
    s += "layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;\n"
    if is_ubo:
        ubo_elems = 1 if element_bytes == 0 else 1024 // n
        s += f"layout(scalar, set = 0, binding = 1) uniform UBO_t {{ {vec_glsl} val[{ubo_elems}]; }} ubo0_1;\n"
    else:
        ro_qual = "readonly " if c.read_only else ""
        s += f"layout(scalar, set = 0, binding = 1) {ro_qual}buffer SSBO_t {{ {vec_glsl} val[]; }} ssbo0_1;\n"
    s += f"{scalar_glsl} refData[{max(num_scalars, 1)}] = {scalar_glsl}[]("
    if num_scalars == 0:
        s += f"{scalar_glsl}(0)"
    else:
        parts = []
        for i in range(num_scalars):
            if c.lv_scalar in (LV_F32, LV_F16):
                parts.append(f"{scalar_glsl}({cfmt(2.0 * i + 3.0)})")
            else:
                parts.append(f"{scalar_glsl}({2 * i + 3})")
        s += ", ".join(parts)
    s += ");\n"
    loop_low = 10
    loop_high = inbound + 10
    s += f"const int N            = {n};\nconst int INBOUND      = {inbound};\nconst int LOOP_LOW     = -{loop_low};\nconst int LOOP_HIGH    = {loop_high};\n"
    s += f"const {scalar_glsl} STORE_VAL = {scalar_glsl}({store_sentinel});\n"
    s += f"void main()\n{{\n    uint accum = 0u;\n    {vec_glsl} v;\n    {scalar_glsl} expected;\n"
    unroll_attr = "unroll" if c.unroll else "dont_unroll"
    src_name = "ubo0_1" if is_ubo else "ssbo0_1"
    s += (f"    [[{unroll_attr}]]\n    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {{\n        bool inb = (c >= 0 && c < INBOUND);\n        v = {src_name}.val[c];\n"
          "        [[unroll]] for (int i = 0; i < N; ++i) {\n            if (inb) {\n                expected = refData[c * N + i];\n            } else {\n"
          f"                expected = {scalar_glsl}(0);\n            }}\n            if (v[i] != expected) accum += 1u;\n        }}\n    }}\n")
    if emit_store:
        s += (f"    [[{unroll_attr}]]\n    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {{\n        bool oob = (c < 0 || c >= INBOUND);\n        if (oob) {{\n"
              f"            ssbo0_1.val[c] = {vec_glsl}(STORE_VAL);\n        }}\n    }}\n    memoryBarrierBuffer();\n")
        s += (f"    [[{unroll_attr}]]\n    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {{\n        bool inb = (c >= 0 && c < INBOUND);\n        v = ssbo0_1.val[c];\n"
              "        [[unroll]] for (int i = 0; i < N; ++i) {\n            if (inb) {\n                expected = refData[c * N + i];\n            } else {\n"
              f"                expected = {scalar_glsl}(0);\n            }}\n            if (v[i] != expected) accum += 1u;\n        }}\n    }}\n")
    s += "    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);\n"
    s += "    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);\n}\n"
    marker = "void main()\n"
    pos = s.index(marker)
    s = s[:pos] + "layout(local_size_x = 1, local_size_y = 1) in;\n" + s[pos:]
    return {"test": ("comp", s, "spirv1.3", True)}


def init_programs(c):
    """`initPrograms`: {program name: (glsl stage, source, spirv version or None, scalar block layout)}; """
    ref = generate_ref_data(c)
    if c.is_long_vector:
        return init_long_vector_programs(c, ref)
    fmt = c.fmt
    if c.desc == CIS:
        if fmt == "R64_SINT":
            fmt = "R32G32_SINT"
        if fmt == "R64_UINT":
            fmt = "R32G32_UINT"

    r64 = "64" if is_r64(fmt) else ""
    i64_type = "64_t" if is_r64(fmt) else ""
    vec_type = "vec4" if is_float(fmt) else (f"i{r64}vec4" if is_signed(fmt) else f"u{r64}vec4")
    q_level_type = "float" if vec_type == "vec4" else (("int" + i64_type) if vec_type in ("ivec4", "i64vec4") else ("uint" + i64_type))

    decls = "uvec4 abs(uvec4 x) { return x; }\n"
    if is_r64(fmt):
        decls += "u64vec4 abs(u64vec4 x) { return x; }\n"
    decls += "int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }\n"

    components_size = 8 if is_r64(fmt) else 4
    ref_n = round_pow2(len(ref) // components_size, 4)
    if c.desc in (UBO, UBO_DYN):
        ref_n = round_pow2(ref_n, 256 // (8 if is_r64(fmt) else 4))
    if c.null_descriptor:
        ref_n = 4

    def ref_at(fmt_str, i):
        return struct.unpack_from(fmt_str, ref, i * struct.calcsize(fmt_str))[0]

    if is_float(fmt):
        decls += f"float refData[{ref_n}] = {{"
        i = 0
        vals = []
        while i < len(ref) // 4:
            vals.append(cfmt(ref_at("<f", i)))
            i += 1
        while i < ref_n:
            vals.append("0")
            i += 1
        decls += ", ".join(vals)
    elif is_r64(fmt):
        decls += f"int{i64_type} refData[{ref_n}] = {{"
        vals = []
        i = 0
        while i < len(ref) // 8:
            vals.append(f"{ref_at('<Q', i)}l")
            i += 1
        while i < ref_n:
            vals.append("0l")
            i += 1
        decls += ", ".join(vals)
    else:
        decls += f"int refData[{ref_n}] = {{"
        vals = []
        i = 0
        while i < len(ref) // 4:
            vals.append(str(ref_at("<i", i)))
            i += 1
        while i < ref_n:
            vals.append("0")
            i += 1
        decls += ", ".join(vals)
    decls += "};\n"
    decls += f"{vec_type} zzzz = {vec_type}(0);\n"
    decls += f"{vec_type} zzzo = {vec_type}(0, 0, 0, 1);\n"
    decls += f"{vec_type} expectedIB;\n"

    imgprefix = ("" if is_float(fmt) else ("i" if is_signed(fmt) else "u")) + r64
    imgqualif = image_qualifier(fmt) + ", " if c.format_qualifier else ""
    outputimgqualif = image_qualifier(fmt)

    view = c.view
    num_coords, num_norm, layered = {
        V1D: (1, 1, False), V1DA: (2, 1, True), V2D: (2, 2, False), V2DA: (3, 2, True), V3D: (3, 3, False), VCUBE: (3, 3, False), VCUBEA: (4, 3, True)}[view]
    image_dim = {V1D: "1D", V1DA: "1DArray", V2D: "2D", V2DA: "2DArray", V3D: "3D", VCUBE: "Cube", VCUBEA: "CubeArray"}[view]
    if c.samples > 1:
        image_dim = "2DMS" if view == V2D else "2DMSArray"
        num_coords += 1
    data_depends_on_layer = view in (V1DA, V2DA) and not c.null_descriptor
    if c.desc == SIMG and view == VCUBEA:
        num_coords = 3

    num_components = pixel_size(fmt) // channel_size(fmt)
    if num_components == 1:
        buf_type = ("float" if is_float(fmt) else "int" if is_signed(fmt) else "uint") + i64_type
    else:
        buf_type = f"{imgprefix}vec{num_components}"

    declared_size = c.desc in (UBO_DYN, UBO)

    checks = "  int inboundcoords, clampedLayer;\n"
    checks += f"  {vec_type} expectedIB2;\n"
    if c.unroll:
        checks += "  [[unroll]] for (int c = 0; c <= 10; ++c) {\n" if declared_size else "  [[unroll]] for (int c = -10; c <= 10; ++c) {\n"
    else:
        checks += "  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {\n" if declared_size else "  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {\n"

    if c.desc == VAF:
        checks += f"    int idx = smod(gl_VertexIndex * {num_components}, {ref_n});\n"
    else:
        checks += f"    int idx = smod(c * {num_components}, {ref_n});\n"

    decls += f"layout({outputimgqualif}, set = 0, binding = 0) uniform {imgprefix}image2D image0_0;\n"
    vol = "volatile " if c.vol else ""
    ro = "readonly " if c.read_only else ""

    d = c.desc
    if d in (UBO_DYN, UBO):
        decls += f"layout(scalar, set = 0, binding = 1) uniform ubodef0_1 {{ {buf_type} val[1024]; }} ubo0_1;\n"
    elif d in (SSBO_DYN, SSBO):
        decls += f"layout(scalar, set = 0, binding = 1) {vol}{ro}buffer sbodef0_1 {{ {buf_type} val[]; }} ssbo0_1;\n"
        decls += f"layout(scalar, set = 0, binding = 1) {vol}{ro}buffer sbodef0_1_pad {{ vec4 pad; {buf_type} val[]; }} ssbo0_1_pad;\n"
    elif d == UTB:
        if fmt == "R64_SINT":
            decls += "layout(set = 0, binding = 1) uniform itextureBuffer texbo0_1;\n"
        elif fmt == "R64_UINT":
            decls += "layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;\n"
        else:
            decls += f"layout(set = 0, binding = 1) uniform {imgprefix}textureBuffer texbo0_1;\n"
    elif d == STB:
        decls += f"layout({imgqualif}set = 0, binding = 1) {vol}uniform {imgprefix}imageBuffer image0_1;\n"
    elif d == SIMG:
        decls += f"layout({imgqualif}set = 0, binding = 1) {vol}uniform {imgprefix}image{image_dim} image0_1;\n"
    elif d == CIS:
        if fmt == "R64_SINT":
            decls += f"layout(set = 0, binding = 1) uniform isampler{image_dim} texture0_1; \n"
        elif fmt == "R64_UINT":
            decls += f"layout(set = 0, binding = 1) uniform usampler{image_dim} texture0_1; \n"
        else:
            decls += f"layout(set = 0, binding = 1) uniform {imgprefix}sampler{image_dim} texture0_1;\n"
    elif d == VAF:
        if is_r64(fmt):
            decls += f"layout(location = 0) in {'int64_t' if is_signed(fmt) else 'uint64_t'} attr;\n"
        else:
            decls += f"layout(location = 0) in {vec_type} attr;\n"

    if d in (UBO_DYN, UBO, SSBO_DYN, SSBO):
        expected_oob, defaultw = "zzzz", "0"
    else:
        if num_components == 1:
            expected_oob = "zzzo"
        elif num_components == 2:
            expected_oob = "zzzo"
        else:
            expected_oob = "zzzz"
        defaultw = "1"

    idx = "0" if d in (SIMG, CIS) else "idx"

    if c.null_descriptor:
        checks += "    expectedIB = zzzz;\n    inboundcoords = 0;\n    int paddedinboundcoords = 0;\n"
        if d != VAF:
            expected_oob = "zzzz"
    else:
        checks += f"    expectedIB.x = refData[{idx}];\n"
        if num_components > 1:
            checks += f"    expectedIB.y = refData[{idx}+1];\n"
        else:
            checks += "    expectedIB.y = 0;\n"
        if num_components > 2:
            checks += f"    expectedIB.z = refData[{idx}+2];\n    expectedIB.w = refData[{idx}+3];\n"
        else:
            checks += f"    expectedIB.z = 0;\n    expectedIB.w = {defaultw};\n"
        if d in (UBO_DYN, UBO):
            checks += f"    int paddedinboundcoords = {ref_n // num_components};\n"
        if d in (UBO_DYN, UBO, SSBO_DYN, SSBO, UTB, STB, VAF):
            checks += f"    inboundcoords = {len(ref) // (8 if is_r64(fmt) else 4) // num_components};\n"

    if d in (SIMG, STB, SSBO, SSBO_DYN) and not c.read_only:
        for i in range(num_coords):
            coord_dim = c.image_dim[2 if i == 3 else i]
            if not c.null_descriptor and d == SIMG:
                checks += f"    inboundcoords = {coord_dim};\n"
            coord = gen_coord("c", num_coords, c.samples, i)
            if c.null_descriptor:
                inboundcoords = "0"
            elif c.samples > 1 and i == num_coords - 1:
                inboundcoords = str(c.samples)
            else:
                inboundcoords = "inboundcoords"
            checks += f"    if (c < 0 || c >= {inboundcoords}) {gen_store(d, vec_type, buf_type, coord)};\n"
            if (c.format_qualifier or d in (SSBO, SSBO_DYN)) and fmt in ("R32_SINT", "R32_UINT"):
                checks += f"    if (c < 0 || c >= {inboundcoords}) {gen_atomic(d, buf_type, coord)};\n"

    for i in range(num_coords):
        coord_dim = c.image_dim[2 if i == 3 else i]
        if not c.null_descriptor and d in (SIMG, CIS):
            checks += f"    inboundcoords = {coord_dim};\n"
        coord = gen_coord("c", num_coords, c.samples, i)

        if d == VAF:
            if is_r64(fmt):
                checks += ("    temp.x = attr;\n    temp.y = 0l;\n    temp.z = 0l;\n    temp.w = 0l;\n"
                           "    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp.x -= expectedIB.x; else temp -= zzzz;\n")
            else:
                checks += f"    temp = {gen_fetch(c, num_components, vec_type, coord, '0')};\n"
                checks += f"    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp -= expectedIB; else temp -= {expected_oob};\n"
            checks += "    accum += abs(temp);\n"
        if d != VAF and not (d == CIS and view in (VCUBE, VCUBEA)):
            checks += f"    temp = {gen_fetch(c, num_components, vec_type, coord, '0')};\n"
            checks += "    expectedIB2 = expectedIB;\n"
            if data_depends_on_layer and i == num_norm:
                checks += f"    if (c >= 0 && c < inboundcoords) expectedIB2 += {vec_type}(c, 0, 0, 0);\n"
            if c.samples > 1 and i == num_coords - 1:
                if c.null_descriptor and d == SIMG:
                    checks += f"    if (temp == zzzz) temp = {vec_type}(0);\n"
                    if c.format_qualifier and num_components < 4:
                        checks += f"    else if (temp == zzzo) temp = {vec_type}(0);\n"
                    checks += f"    else temp = {vec_type}(1);\n"
                else:
                    checks += f"    if (c >= 0 && c < {c.samples}) temp -= expectedIB2; else temp = {vec_type}(0);\n"
            else:
                expected_oob2 = expected_oob
                expected_oob3 = expected_oob
                if d in (SSBO, SSBO_DYN) and not c.null_descriptor:
                    ln = c.buffer_len & (~7 if is_r64(fmt) else ~3)
                    mod = (ln // (8 if is_r64(fmt) else 4)) % num_components
                    ss = str(STORE_VALUE)
                    if mod == 1:
                        expected_oob2 = f"{vec_type}(expectedIB2.x, 0, 0, 0)"
                        expected_oob3 = f"{vec_type}({ss}, 0, 0, 0)"
                    elif mod == 2:
                        expected_oob2 = f"{vec_type}(expectedIB2.xy, 0, 0)"
                        expected_oob3 = f"{vec_type}({ss}, {ss}, 0, 0)"
                    elif mod == 3:
                        expected_oob2 = f"{vec_type}(expectedIB2.xyz, 0)"
                        expected_oob3 = f"{vec_type}({ss}, {ss}, {ss}, 0)"
                checks += f"    if (c >= 0 && c < inboundcoords) {{\n       if (temp == expectedIB2) temp = {vec_type}(0); else temp = {vec_type}(1);\n    }}\n"
                if c.test_robustness2:
                    checks += f"    else if (temp == {expected_oob}) temp = {vec_type}(0);\n"
                else:
                    checks += f"    else if (temp == zzzz || temp == zzzo) temp = {vec_type}(0);\n"
                if d in (UBO, UBO_DYN):
                    checks += f"    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = {vec_type}(0);\n"
                if c.null_descriptor and c.format_qualifier and d in (SIMG, STB) and num_components < 4:
                    checks += f"    else if (temp == zzzo) temp = {vec_type}(0);\n"
                if supports_stores(d) and not c.vol:
                    checks += f"    else if (temp == {get_store_value(d, num_components, vec_type, buf_type)}) temp = {vec_type}(0);\n"
                    if d in (SSBO_DYN, SSBO):
                        for mask in range(num_components * num_components - 2, 0, -1):
                            items = [str(STORE_VALUE) if mask & (1 << v) else "0" for v in range(4)]
                            checks += f"    else if (temp == {vec_type}({','.join(items)})) temp = {vec_type}(0);\n"
                if expected_oob2 != expected_oob:
                    checks += f"    else if (c == inboundcoords && temp == {expected_oob2}) temp = {vec_type}(0);\n"
                if expected_oob3 != expected_oob:
                    checks += f"    else if (c == inboundcoords && temp == {expected_oob3}) temp = {vec_type}(0);\n"
                checks += f"    else temp = {vec_type}(1);\n"
            checks += "    accum += abs(temp);\n"
            if c.test_robustness2 and d == CIS and c.samples == 1:
                coord0 = gen_coord("0", num_coords, c.samples, i)
                checks += f"    if (c != 0) temp = {gen_fetch(c, num_components, vec_type, coord0, 'c')}; else temp = {vec_type}(0);\n"
                checks += f"    if (c != 0) temp -= {expected_oob};\n"
                checks += "    accum += abs(temp);\n"
        if d == CIS and c.samples == 1:
            coord_norm = gen_coord_norm(c, "(c+0.25)", num_coords, num_norm, i)
            checks += "    expectedIB2 = expectedIB;\n"
            if data_depends_on_layer and i == num_norm:
                checks += f"    clampedLayer = clamp(c, 0, {coord_dim - 1});\n"
                checks += f"    expectedIB2 += {vec_type}(clampedLayer, 0, 0, 0);\n"
            if view in (VCUBE, VCUBEA) or (layered and i == num_coords - 1):
                normexpected = "    temp -= expectedIB2;\n"
            else:
                normexpected = "    if (c >= 0 && c < inboundcoords)\n        temp -= expectedIB2;\n    else\n"
                if c.test_robustness2:
                    normexpected += f"        temp -= {expected_oob};\n"
                else:
                    normexpected += f"        temp = {vec_type}((temp == zzzz || temp == zzzo) ? 0 : 1);\n"
            checks += f"    temp = texture(texture0_1, {coord_norm});\n" + normexpected + "    accum += abs(temp);\n"
            checks += f"    temp = textureLod(texture0_1, {coord_norm}, 0.0f);\n" + normexpected + "    accum += abs(temp);\n"
            checks += (f"    temp = textureGrad(texture0_1, {coord_norm}, {gen_coord('1.0', num_norm, c.samples, i)}, {gen_coord('1.0', num_norm, c.samples, i)});\n"
                       + normexpected + "    accum += abs(temp);\n")
        if c.null_descriptor:
            sizeswiz = {V1D: ".xxxx", V1DA: ".xyxx", V2D: ".xyxx", V2DA: ".xyzx", V3D: ".xyzx", VCUBE: ".xyxx", VCUBEA: ".xyzx"}[view]
            if d == CIS:
                if c.samples == 1:
                    checks += f"    temp = textureSize(texture0_1, 0){sizeswiz};\n    accum += abs(temp);\n"
                    checks += f"    temp = textureSize(texture0_1, {-i}){sizeswiz};\n    accum += abs(temp);\n"
                    checks += f"    temp = textureSize(texture0_1, {2147483647 - i}){sizeswiz};\n    accum += abs(temp);\n"
                else:
                    checks += f"    temp = textureSize(texture0_1){sizeswiz};\n    accum += abs(temp);\n"
                    checks += "    temp = textureSamples(texture0_1).xxxx;\n    accum += abs(temp);\n"
            if d == SIMG:
                if c.samples == 1:
                    checks += f"    temp = imageSize(image0_1){sizeswiz};\n    accum += abs(temp);\n"
                else:
                    checks += f"    temp = imageSize(image0_1){sizeswiz};\n    accum += abs(temp);\n"
                    checks += "    temp = imageSamples(image0_1).xxxx;\n    accum += abs(temp);\n"
            if d in (SSBO, SSBO_DYN):
                checks += f"    temp = {vec_type}(ssbo0_1.val.length());\n    accum += abs(temp);\n"
                checks += f"    temp = {vec_type}(ssbo0_1_pad.val.length());\n    accum += abs(temp);\n"
    checks += "  }\n"

    if c.null_descriptor and d == CIS and c.samples == 1:
        checks += f"  temp_ql = {q_level_type}(textureQueryLevels(texture0_1));\n  temp = {vec_type}(temp_ql);\n  accum += abs(temp);\n"
        if c.stage == STAGE_FRAGMENT:
            lod_str = ");" if num_norm == 1 else ("y);" if num_norm == 2 else "yz);")
            checks += f"  vec2 lod = textureQueryLod(texture0_1, gl_FragCoord.x{lod_str}\n"
            checks += f"  temp_ql = {q_level_type}(ceil(abs(lod.x) + abs(lod.y)));\n  temp = {vec_type}(temp_ql);\n  accum += abs(temp);\n"

    needs_scalar = c.needs_scalar_block_layout
    is64 = is_r64(c.fmt)
    support = "#version 460 core\n#extension GL_EXT_nonuniform_qualifier : enable\n"
    if needs_scalar:
        support += "#extension GL_EXT_scalar_block_layout : enable\n"
    support += "#extension GL_EXT_samplerless_texture_functions : enable\n#extension GL_EXT_control_flow_attributes : enable\n#extension GL_EXT_shader_image_load_formatted : enable\n"
    support_r64 = "#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require\n#extension GL_EXT_shader_image_int64 : require\n"
    if is64:
        support += support_r64
    if c.stage == STAGE_RAYGEN:
        support += "#extension GL_EXT_ray_tracing : require\n"

    code = (f"  {vec_type} accum = {vec_type}(0);\n  {vec_type} temp;\n  {q_level_type} temp_ql;\n" + checks +
            f"  {vec_type} color = (accum != {vec_type}(0)) ? {vec_type}(0,0,0,0) : {vec_type}(1,0,0,1);\n")

    progs = {}
    spv_default = "spirv1.3" if is64 else None
    if c.stage == STAGE_COMPUTE:
        css = support + decls + "layout(local_size_x = 1, local_size_y = 1) in;\nvoid main()\n{\n" + code + "  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);\n}\n"
        progs["test"] = ("comp", css, spv_default, needs_scalar)
    elif c.stage == STAGE_RAYGEN:
        rss = support + decls + "void main()\n{\n" + code + "  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);\n}\n"
        progs["test"] = ("rgen", rss, "spirv1.4", needs_scalar)
    elif c.stage == STAGE_VERTEX:
        vss = (support + decls + "void main()\n{\n" + code + f"  imageStore(image0_0, ivec2(gl_VertexIndex % {DIM}, gl_VertexIndex / {DIM}), color);\n"
               "  gl_PointSize = 1.0f;\n  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);\n}\n")
        progs["test"] = ("vert", vss, None, needs_scalar)
    elif c.stage == STAGE_FRAGMENT:
        vss = ("#version 450 core\nvoid main()\n{\n  gl_Position = vec4( 2.0*float(gl_VertexIndex&2) - 1.0, 4.0*(gl_VertexIndex&1)-1.0, 1.0 - 2.0 * float(gl_VertexIndex&1), 1);\n}\n")
        progs["vert"] = ("vert", vss, None, needs_scalar)
        fss = support + decls + "void main()\n{\n" + code + "  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);\n}\n"
        progs["test"] = ("frag", fss, None, needs_scalar)

    if c.samples > 1 and is64:
        ivec_coords = "ivec2(gx, gy)" if view == V2D else "ivec3(gx, gy, gz)"
        fill = ("#version 450\n" + support_r64 + "\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
                f"layout ({image_qualifier(c.fmt)}, binding=0) volatile uniform {'i' if is_signed(c.fmt) else 'u'}64image{image_dim} u_resultImage;\n\n"
                "layout(std430, binding = 1) buffer inputBuffer\n{\n  int64_t data[];\n} inBuffer;\n\nvoid main(void)\n{\n"
                "  int gx = int(gl_GlobalInvocationID.x);\n  int gy = int(gl_GlobalInvocationID.y);\n  int gz = int(gl_GlobalInvocationID.z);\n"
                "  uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);\n")
        for ndx in range(c.samples):
            fill += f"  imageStore(u_resultImage, {ivec_coords}, {ndx}, i64vec4(inBuffer.data[index]));\n"
        fill += "}\n"
        progs["fillShader"] = ("comp", fill, "spirv1.3", needs_scalar)
    return progs


DESC_KEY = {UBO: "ubo", SSBO: "ssbo", UBO_DYN: "ubod", SSBO_DYN: "ssbod", UTB: "utb", STB: "stb", SIMG: "simg", CIS: "cis", VAF: "vaf"}
FORMAT_KEY = {full: short for full, short in FORMATS}
STAGE_KEY = {STAGE_COMPUTE: "comp", STAGE_VERTEX: "vert", STAGE_FRAGMENT: "frag", STAGE_RAYGEN: "rgen"}
LV_KEY = {LV_F32: "f32", LV_I32: "i32", LV_U32: "u32", LV_F16: "f16"}


def shader_key(c):
    """The identity of the shader set a case compiles; two cases with the same key share the programs. `exts_tests.rs::shader_key` writes the same string."""
    if c.is_long_vector:
        return f"lv.{LV_KEY[c.lv_scalar]}.w{c.lv_components}.{DESC_KEY[c.desc]}.l{c.buffer_len}.u{int(c.unroll)}.o{int(c.read_only)}"
    ln = "null" if c.null_descriptor else str(c.buffer_len)
    return (f"{FORMAT_KEY[c.fmt]}.{STAGE_KEY[c.stage]}.{DESC_KEY[c.desc]}.{c.view}.s{c.samples}.l{ln}.u{int(c.unroll)}v{int(c.vol)}f{int(c.format_qualifier)}"
            f"r{int(c.test_robustness2)}o{int(c.read_only)}")

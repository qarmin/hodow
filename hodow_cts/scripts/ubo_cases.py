"""The case tree, layout and shader sources of dEQP-VK.ubo.*

A transliteration of vktUniformBlockCase.cpp, vktUniformBlockTests.cpp and vktRandomUniformBlockCase.cpp. gen_ubo_manifest.py writes the shader manifest and the
Rust case table from it; src/vkt/tests/ubo/ only has to upload the blocks and run the shader.

Upstream never sets `UniformLayoutEntry::size` (it stays 0), so `generateValue` draws no values, every block holds zeros, and the shaders compare against literal
zeros; `generate_values` here reproduces that rather than what it was meant to do.

A pure text module: no glslang and no cargo.
"""

from dataclasses import dataclass, field

import de_random

MASK32 = 0xFFFFFFFF

PRECISION_LOW = 1 << 0
PRECISION_MEDIUM = 1 << 1
PRECISION_HIGH = 1 << 2
PRECISION_MASK = PRECISION_LOW | PRECISION_MEDIUM | PRECISION_HIGH
LAYOUT_SHARED = 1 << 3
LAYOUT_PACKED = 1 << 4
LAYOUT_STD140 = 1 << 5
LAYOUT_ROW_MAJOR = 1 << 6
LAYOUT_COLUMN_MAJOR = 1 << 7
LAYOUT_OFFSET = 1 << 8
LAYOUT_STD430 = 1 << 9
LAYOUT_SCALAR = 1 << 10
LAYOUT_MASK = LAYOUT_SHARED | LAYOUT_PACKED | LAYOUT_STD140 | LAYOUT_STD430 | LAYOUT_SCALAR | LAYOUT_ROW_MAJOR | LAYOUT_COLUMN_MAJOR | LAYOUT_OFFSET
DECLARE_VERTEX = 1 << 11
DECLARE_FRAGMENT = 1 << 12
DECLARE_COMPUTE = 1 << 13
UNUSED_VERTEX = 1 << 14
UNUSED_FRAGMENT = 1 << 15
UNUSED_BOTH = UNUSED_VERTEX | UNUSED_FRAGMENT
LAYOUT_16BIT_STORAGE = 1 << 16
LAYOUT_8BIT_STORAGE = 1 << 17
LAYOUT_DESCRIPTOR_INDEXING = 1 << 18

LOAD_FULL_MATRIX = 0
LOAD_MATRIX_COMPONENTS = 1

BUFFERMODE_SINGLE = 0
BUFFERMODE_PER_BLOCK = 1

UNSIZED_ARRAY = -1


def align32(value: int, alignment: int) -> int:
    return (value + alignment - 1) & ~(alignment - 1)


def round_up32(value: int, alignment: int) -> int:
    return align32(value, alignment)


# ---------------------------------------------------------------------------------------------------------------------
# glu::DataType
# ---------------------------------------------------------------------------------------------------------------------


@dataclass(frozen=True)
class DataType:
    name: str
    scalar: str  # name of the scalar type
    size: int  # scalar size
    rows: int = 0
    cols: int = 0

    @property
    def is_matrix(self) -> bool:
        return self.cols > 0

    @property
    def is_scalar(self) -> bool:
        return self.size == 1 and not self.is_matrix

    @property
    def is_vector(self) -> bool:
        return 2 <= self.size <= 4 and not self.is_matrix


SCALAR_BYTES = {"float": 4, "int": 4, "uint": 4, "bool": 4, "uint8_t": 1, "int8_t": 1, "uint16_t": 2, "int16_t": 2, "float16_t": 2}
EXPLICIT_PRECISION = {"uint8_t", "int8_t", "uint16_t", "int16_t", "float16_t"}

TYPES: dict[str, DataType] = {}
ENUM_ORDER: list[str] = []


def _add(dt: DataType) -> None:
    TYPES[dt.name] = dt
    ENUM_ORDER.append(dt.name)


for _n, _s in (("float", 1), ("vec2", 2), ("vec3", 3), ("vec4", 4)):
    _add(DataType(_n, "float", _s))
for _c, _r in ((2, 2), (2, 3), (2, 4), (3, 2), (3, 3), (3, 4), (4, 2), (4, 3), (4, 4)):
    _add(DataType(f"mat{_c}" if _c == _r else f"mat{_c}x{_r}", "float", _c * _r, _r, _c))
for _prefix, _scalar in (("i", "int"), ("u", "uint"), ("b", "bool")):
    _add(DataType(_scalar, _scalar, 1))
    for _s in (2, 3, 4):
        _add(DataType(f"{_prefix}vec{_s}", _scalar, _s))
for _prefix, _scalar in (("u8", "uint8_t"), ("i8", "int8_t"), ("u16", "uint16_t"), ("i16", "int16_t"), ("f16", "float16_t")):
    _add(DataType(_scalar, _scalar, 1))
    for _s in (2, 3, 4):
        _add(DataType(f"{_prefix}vec{_s}", _scalar, _s))

FLOAT_VEC = {1: "float", 2: "vec2", 3: "vec3", 4: "vec4"}
PROMOTE = {
    "uint8_t": "uint", "u8vec2": "uvec2", "u8vec3": "uvec3", "u8vec4": "uvec4", "int8_t": "int", "i8vec2": "ivec2", "i8vec3": "ivec3", "i8vec4": "ivec4",
    "uint16_t": "uint", "u16vec2": "uvec2", "u16vec3": "uvec3", "u16vec4": "uvec4", "int16_t": "int", "i16vec2": "ivec2", "i16vec3": "ivec3", "i16vec4": "ivec4",
    "float16_t": "float", "f16vec2": "vec2", "f16vec3": "vec3", "f16vec4": "vec4",
}


def supports_precision(name: str) -> bool:
    dt = TYPES[name]
    return dt.scalar != "bool" and dt.scalar not in EXPLICIT_PRECISION


def byte_size(name: str) -> int:
    dt = TYPES[name]
    return dt.size * SCALAR_BYTES[dt.scalar]


def byte_alignment(name: str) -> int:
    dt = TYPES[name]
    components = 4 if dt.size == 3 else dt.size
    return components * SCALAR_BYTES[dt.scalar]


def scalar_type_name(name: str) -> str:
    return TYPES[name].scalar


# ---------------------------------------------------------------------------------------------------------------------
# VarType / StructType / Uniform / UniformBlock / ShaderInterface
# ---------------------------------------------------------------------------------------------------------------------


@dataclass
class StructMember:
    name: str
    type: "VarType"
    flags: int


@dataclass
class StructType:
    name: str
    members: list = field(default_factory=list)

    def add_member(self, name, type_, flags=0):
        self.members.append(StructMember(name, type_, flags))

    @property
    def has_name(self):
        return bool(self.name)


@dataclass
class VarType:
    kind: str  # basic | array | struct
    flags: int = 0
    basic: str = ""
    elem: "VarType | None" = None
    size: int = 0
    struct: "StructType | None" = None

    @property
    def is_basic(self):
        return self.kind == "basic"

    @property
    def is_array(self):
        return self.kind == "array"

    @property
    def is_struct(self):
        return self.kind == "struct"


def basic(name: str, flags: int = 0) -> VarType:
    return VarType("basic", flags, basic=name)


def array(elem: VarType, size: int) -> VarType:
    return VarType("array", 0, elem=elem, size=size)


def struct(st: StructType, flags: int = 0) -> VarType:
    return VarType("struct", flags, struct=st)


@dataclass
class Uniform:
    name: str
    type: VarType
    flags: int = 0


class UniformBlock:
    def __init__(self, name: str):
        self.block_name = name
        self.instance_name = ""
        self.uniforms: list[Uniform] = []
        self.array_size = 0
        self.flags = 0
        self.last_unsized = [0]

    @property
    def has_instance_name(self):
        return bool(self.instance_name)

    @property
    def is_array(self):
        return self.array_size > 0

    def set_array_size(self, size: int):
        self.last_unsized = [0] * (1 if size == 0 else size)
        self.array_size = size

    def add_uniform(self, uniform: Uniform):
        self.uniforms.append(uniform)


class ShaderInterface:
    def __init__(self):
        self.structs: list[StructType] = []
        self.blocks: list[UniformBlock] = []

    def alloc_struct(self, name: str) -> StructType:
        st = StructType(name)
        self.structs.append(st)
        return st

    def alloc_block(self, name: str) -> UniformBlock:
        block = UniformBlock(name)
        self.blocks.append(block)
        return block

    def named_structs(self):
        return [s for s in self.structs if s.has_name]

    def uses_block_layout(self, flag: int) -> bool:
        return any(b.flags & flag for b in self.blocks)


# ---------------------------------------------------------------------------------------------------------------------
# Layout
# ---------------------------------------------------------------------------------------------------------------------


@dataclass
class UniformLayoutEntry:
    name: str = ""
    type: str = ""
    size: int = 0
    block_ndx: int = -1
    offset: int = -1
    array_size: int = -1
    array_stride: int = -1
    matrix_stride: int = -1
    is_row_major: bool = False


@dataclass
class BlockLayoutEntry:
    name: str = ""
    size: int = 0
    active_uniform_indices: list = field(default_factory=list)
    block_declaration_ndx: int = -1
    binding_ndx: int = -1
    instance_ndx: int = -1


@dataclass
class UniformLayout:
    blocks: list = field(default_factory=list)
    uniforms: list = field(default_factory=list)

    def uniform_index(self, block_ndx: int, name: str) -> int:
        for ndx, u in enumerate(self.uniforms):
            if self.blocks[u.block_ndx].block_declaration_ndx == block_ndx and u.name == name:
                return ndx
        return -1

    def block_index(self, block_ndx: int, instance_ndx: int) -> int:
        for ndx, b in enumerate(self.blocks):
            if b.block_declaration_ndx == block_ndx and b.instance_ndx == instance_ndx:
                return ndx
        return -1


def std140_base_alignment(t: VarType, flags: int) -> int:
    vec4 = 16
    if t.is_basic:
        dt = TYPES[t.basic]
        if dt.is_matrix:
            row_major = bool(flags & LAYOUT_ROW_MAJOR)
            vec_size = dt.cols if row_major else dt.rows
            return align32(byte_alignment(FLOAT_VEC[vec_size]), vec4)
        return byte_alignment(t.basic)
    if t.is_array:
        return align32(std140_base_alignment(t.elem, flags), vec4)
    return align32(max([0] + [std140_base_alignment(m.type, flags) for m in t.struct.members]), vec4)


def std430_base_alignment(t: VarType, flags: int) -> int:
    if t.is_basic:
        dt = TYPES[t.basic]
        if dt.is_matrix:
            row_major = bool(flags & LAYOUT_ROW_MAJOR)
            vec_size = dt.cols if row_major else dt.rows
            return byte_alignment(FLOAT_VEC[vec_size])
        return byte_alignment(t.basic)
    if t.is_array:
        return std430_base_alignment(t.elem, flags)
    return max([0] + [std430_base_alignment(m.type, flags) for m in t.struct.members])


def scalar_block_alignment(t: VarType, flags: int) -> int:
    if t.is_basic:
        return byte_alignment(TYPES[t.basic].scalar)
    if t.is_array:
        return scalar_block_alignment(t.elem, flags)
    return max([0] + [scalar_block_alignment(m.type, flags) for m in t.struct.members])


def merge_layout_flags(prev: int, new: int) -> int:
    packing = LAYOUT_STD140 | LAYOUT_STD430 | LAYOUT_SCALAR
    matrix = LAYOUT_ROW_MAJOR | LAYOUT_COLUMN_MAJOR
    merged = 0
    merged |= (new if new & packing else prev) & packing
    merged |= (new if new & matrix else prev) & matrix
    return merged


def compute_reference_layout_type(layout: UniformLayout, block_ndx: int, base_offset: int, prefix: str, t: VarType, flags: int, interface: ShaderInterface, instance_ndx: int) -> int:
    if flags & LAYOUT_SCALAR:
        base_alignment = scalar_block_alignment(t, flags)
    elif flags & LAYOUT_STD430:
        base_alignment = std430_base_alignment(t, flags)
    else:
        base_alignment = std140_base_alignment(t, flags)
    cur_offset = align32(base_offset, base_alignment)

    if t.is_basic:
        dt = TYPES[t.basic]
        entry = UniformLayoutEntry(name=prefix, type=t.basic, array_size=1, array_stride=0, matrix_stride=0, block_ndx=block_ndx)
        if dt.is_matrix:
            row_major = bool(flags & LAYOUT_ROW_MAJOR)
            vec_size = dt.cols if row_major else dt.rows
            vec_type = FLOAT_VEC[vec_size]
            num_vecs = dt.rows if row_major else dt.cols
            vec_stride = byte_size(vec_type) if flags & LAYOUT_SCALAR else base_alignment
            entry.offset = cur_offset
            entry.matrix_stride = vec_stride
            entry.is_row_major = row_major
            cur_offset += num_vecs * entry.matrix_stride
        else:
            entry.offset = cur_offset
            cur_offset += byte_size(t.basic)
        layout.uniforms.append(entry)
    elif t.is_array:
        elem = t.elem
        array_size = t.size
        if array_size == UNSIZED_ARRAY:
            block = interface.blocks[block_ndx] if 0 <= block_ndx < len(interface.blocks) else None
            array_size = block.last_unsized[instance_ndx] if block else 0
        if elem.is_basic and not TYPES[elem.basic].is_matrix:
            stride = byte_size(elem.basic) if flags & LAYOUT_SCALAR else base_alignment
            entry = UniformLayoutEntry(name=prefix + "[0]", type=elem.basic, block_ndx=block_ndx, offset=cur_offset, array_size=array_size, array_stride=stride, matrix_stride=0)
            cur_offset += stride * array_size
            layout.uniforms.append(entry)
        elif elem.is_basic:
            dt = TYPES[elem.basic]
            row_major = bool(flags & LAYOUT_ROW_MAJOR)
            vec_size = dt.cols if row_major else dt.rows
            vec_type = FLOAT_VEC[vec_size]
            num_vecs = dt.rows if row_major else dt.cols
            vec_stride = byte_size(vec_type) if flags & LAYOUT_SCALAR else base_alignment
            entry = UniformLayoutEntry(name=prefix + "[0]", type=elem.basic, block_ndx=block_ndx, offset=cur_offset, array_size=array_size, array_stride=vec_stride * num_vecs,
                                       matrix_stride=vec_stride, is_row_major=row_major)
            cur_offset += entry.array_stride * array_size
            layout.uniforms.append(entry)
        else:
            for elem_ndx in range(array_size):
                cur_offset += compute_reference_layout_type(layout, block_ndx, cur_offset, f"{prefix}[{elem_ndx}]", t.elem, flags, interface, instance_ndx)
    else:
        for member in t.struct.members:
            cur_offset += compute_reference_layout_type(layout, block_ndx, cur_offset, prefix + "." + member.name, member.type, flags, interface, instance_ndx)
        if not flags & LAYOUT_SCALAR:
            cur_offset = align32(cur_offset, base_alignment)

    return cur_offset - base_offset


def compute_reference_layout(interface: ShaderInterface) -> UniformLayout:
    layout = UniformLayout()
    for block_ndx, block in enumerate(interface.blocks):
        block_prefix = block.block_name + "." if block.has_instance_name else ""
        num_instances = block.array_size if block.is_array else 1
        for instance_ndx in range(num_instances):
            cur_offset = 0
            active_block_ndx = len(layout.blocks)
            first_uniform = len(layout.uniforms)
            for uniform in block.uniforms:
                cur_offset += compute_reference_layout_type(layout, active_block_ndx, cur_offset, block_prefix + uniform.name, uniform.type,
                                                            merge_layout_flags(block.flags, uniform.flags), interface, instance_ndx)
            entry = BlockLayoutEntry(name=block.block_name, size=cur_offset, block_declaration_ndx=block_ndx, binding_ndx=block_ndx, instance_ndx=instance_ndx)
            entry.active_uniform_indices = list(range(first_uniform, len(layout.uniforms)))
            if block.is_array:
                entry.name += f"[{instance_ndx}]"
            layout.blocks.append(entry)
    return layout


# ---------------------------------------------------------------------------------------------------------------------
# Shader generation
# ---------------------------------------------------------------------------------------------------------------------

COMPARE_FUNCS = {
    "float": "mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }\n",
    "vec2": "mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }\n",
    "vec3": "mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }\n",
    "vec4": "mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }\n",
    "mat2": "mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }\n",
    "mat2x3": "mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }\n",
    "mat2x4": "mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }\n",
    "mat3x2": "mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }\n",
    "mat3": "mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }\n",
    "mat3x4": "mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }\n",
    "mat4x2": "mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }\n",
    "mat4x3": "mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }\n",
    "mat4": "mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }\n",
    "int": "mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }\n",
    "ivec2": "mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }\n",
    "ivec3": "mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }\n",
    "ivec4": "mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }\n",
    "uint": "mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }\n",
    "uvec2": "mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }\n",
    "uvec3": "mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }\n",
    "uvec4": "mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }\n",
    "bool": "mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }\n",
    "bvec2": "mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }\n",
    "bvec3": "mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }\n",
    "bvec4": "mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }\n",
    "float16_t": "mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }\n",
    "f16vec2": "mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }\n",
    "f16vec3": "mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }\n",
    "f16vec4": "mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }\n",
    "int8_t": "mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }\n",
    "i8vec2": "mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }\n",
    "i8vec3": "mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }\n",
    "i8vec4": "mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }\n",
    "uint8_t": "mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }\n",
    "u8vec2": "mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }\n",
    "u8vec3": "mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }\n",
    "u8vec4": "mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }\n",
    "int16_t": "mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }\n",
    "i16vec2": "mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }\n",
    "i16vec3": "mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }\n",
    "i16vec4": "mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }\n",
    "uint16_t": "mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }\n",
    "u16vec2": "mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }\n",
    "u16vec3": "mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }\n",
    "u16vec4": "mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }\n",
}


def compare_dependencies(funcs: set, name: str) -> None:
    dt = TYPES[name]
    if name in ("vec2", "vec3", "vec4", "f16vec2", "f16vec3", "f16vec4"):
        funcs.add("float")
        funcs.add(name)
    elif dt.is_matrix:
        funcs.add("float")
        funcs.add(FLOAT_VEC[dt.rows])
        funcs.add(name)
    else:
        funcs.add(name)


def collect_basic_types(types: set, t: VarType) -> None:
    if t.is_struct:
        for m in t.struct.members:
            collect_basic_types(types, m.type)
    elif t.is_array:
        collect_basic_types(types, t.elem)
    else:
        types.add(t.basic)


def generate_compare_funcs(interface: ShaderInterface) -> str:
    types: set = set()
    for block in interface.blocks:
        for u in block.uniforms:
            collect_basic_types(types, u.type)
    funcs: set = set()
    for name in types:
        compare_dependencies(funcs, name)
    return "".join(COMPARE_FUNCS[name] for name in ENUM_ORDER if name in funcs)


def layout_flags_fmt(flags: int, offset: int = 0) -> str:
    bits = [(LAYOUT_STD140, "std140"), (LAYOUT_STD430, "std430"), (LAYOUT_SCALAR, "scalar"), (LAYOUT_ROW_MAJOR, "row_major"), (LAYOUT_COLUMN_MAJOR, "column_major"),
            (LAYOUT_OFFSET, "offset")]
    out = []
    for bit, token in bits:
        if flags & bit:
            out.append(f"{token} = {offset}" if bit == LAYOUT_OFFSET else token)
    return ", ".join(out)


def precision_fmt(flags: int) -> str:
    if flags & PRECISION_LOW:
        return "lowp"
    if flags & PRECISION_MEDIUM:
        return "mediump"
    if flags & PRECISION_HIGH:
        return "highp"
    return ""


def layout_and_precision(flags: int, offset: int) -> str:
    out = ""
    if flags & LAYOUT_MASK:
        out += "layout(" + layout_flags_fmt(flags & LAYOUT_MASK, offset) + ") "
    if flags & PRECISION_MASK:
        out += precision_fmt(flags & PRECISION_MASK) + " "
    return out


def indent(level: int) -> str:
    return "\t" * level


def generate_full_struct_declaration(st: StructType, indent_level: int) -> str:
    out = "struct"
    if st.has_name:
        out += " " + st.name
    out += "\n" + indent(indent_level) + "{\n"
    for m in st.members:
        out += indent(indent_level + 1) + generate_var_declaration(m.type, m.name, indent_level + 1, m.flags & UNUSED_BOTH, ~LAYOUT_OFFSET & 0xFFFFFFFF, 0)
    out += indent(indent_level) + "}"
    return out


def generate_var_declaration(t: VarType, name: str, indent_level: int, unused_hints: int, flags_mask: int, offset: int) -> str:
    out = layout_and_precision(t.flags & flags_mask, offset)
    if t.is_basic:
        out += t.basic + " " + name
    elif t.is_array:
        sizes = []
        cur = t
        while cur.is_array:
            sizes.append(cur.size)
            cur = cur.elem
        out += layout_and_precision(cur.flags & flags_mask, offset)
        if cur.is_basic:
            out += cur.basic
        else:
            out += cur.struct.name
        out += " " + name
        for size in sizes:
            out += "[]" if size == UNSIZED_ARRAY else f"[{size}]"
    else:
        out += t.struct.name + " " + name
    out += ";"
    if unused_hints:
        out += " // unused in " + ("both shaders" if unused_hints == UNUSED_BOTH else "vertex shader" if unused_hints == UNUSED_VERTEX else "fragment shader" if unused_hints == UNUSED_FRAGMENT else "???")
    out += "\n"
    return out


def generate_uniform_declaration(u: Uniform, indent_level: int, offset: int) -> str:
    out = ""
    if u.flags & LAYOUT_MASK:
        out += "layout(" + layout_flags_fmt(u.flags & LAYOUT_MASK) + ") "
    out += generate_var_declaration(u.type, u.name, indent_level, u.flags & UNUSED_BOTH, MASK32, offset)
    return out


def block_member_offset(block_ndx: int, block: UniformBlock, u: Uniform, layout: UniformLayout) -> int:
    name = ""
    if block.instance_name:
        name += block.block_name + "."
    name += u.name
    cur = u.type
    while not cur.is_basic:
        if cur.is_array:
            name += "[0]"
            cur = cur.elem
        if cur.is_struct:
            first = cur.struct.members[0]
            name += "." + first.name
            cur = first.type
    ndx = layout.uniform_index(block_ndx, name)
    assert ndx >= 0, name
    return layout.uniforms[ndx].offset


def semi_shuffle(items: list) -> list:
    src = list(items)
    i = -1
    n = len(src)
    out = []
    while n:
        i += n
        out.append(src[i])
        n = 1 - n if n > 0 else -1 - n
    return out


def generate_block_declaration(block_ndx: int, block: UniformBlock, layout: UniformLayout, shuffle: bool) -> str:
    out = f"layout(set = 0, binding = {block_ndx}"
    if block.flags & LAYOUT_MASK:
        out += ", " + layout_flags_fmt(block.flags & LAYOUT_MASK)
    out += ") "
    out += "uniform " + block.block_name
    out += "\n{\n"
    uniforms = semi_shuffle(block.uniforms) if shuffle else list(block.uniforms)
    for u in uniforms:
        out += indent(1) + generate_uniform_declaration(u, 1, block_member_offset(block_ndx, block, u, layout))
    out += "}"
    if block.has_instance_name:
        out += " " + block.instance_name
        if block.is_array:
            out += "[]" if block.flags & LAYOUT_DESCRIPTOR_INDEXING else f"[{block.array_size}]"
    else:
        assert not block.is_array
    out += ";\n"
    return out


def float_to_string(value: float) -> str:
    return f"{value:.1f}"


def generate_value_src(entry: UniformLayoutEntry, base: bytes, element_ndx: int) -> str:
    """`generateValueSrc` over a block of zeros; `isArray` is false because `entry.size` is never set."""
    dt = TYPES[entry.type]
    scalar = dt.scalar
    scalar_size = dt.size
    out = ""
    if scalar_size > 1:
        out += PROMOTE.get(entry.type, entry.type) + "("
    if dt.is_matrix:
        for col in range(dt.cols):
            for row in range(dt.rows):
                if col > 0 or row > 0:
                    out += ", "
                out += float_to_string(0.0)
    else:
        for scalar_ndx in range(scalar_size):
            if scalar_ndx > 0:
                out += ", "
            if scalar in ("int8_t", "int16_t", "int"):
                out += "0"
            elif scalar in ("uint8_t", "uint16_t", "uint"):
                out += "0u"
            elif scalar == "bool":
                out += "false"
            else:
                out += float_to_string(0.0)
    if scalar_size > 1:
        out += ")"
    return out


MATRIX_PER_VEC = {"mat2": (2, 2, "vec2"), "mat2x3": (2, 3, "vec3"), "mat2x4": (2, 4, "vec4"), "mat3x4": (3, 4, "vec4"), "mat4": (4, 4, "vec4"), "mat4x2": (4, 2, "vec2"),
                  "mat4x3": (4, 3, "vec3")}
MATRIX_PER_ELEMENT = {k: (v[0], v[1]) for k, v in MATRIX_PER_VEC.items()}


def write_matrix_type_src(column_count: int, row_count: int, compare: str, compare_type: str, src_name: str, base: bytes, entry: UniformLayoutEntry, vector: bool) -> str:
    out = ""
    if vector:
        for col in range(column_count):
            out += f"\tresult *= {compare + compare_type}({src_name}[{col}], "
            if TYPES[entry.type].is_matrix:
                scalar_size = TYPES[entry.type].size
                if scalar_size > 1:
                    out += compare_type + "("
                for row in range(row_count):
                    out += float_to_string(0.0)
                    if row < row_count - 1:
                        out += ", "
                out += "));\n"
            else:
                out += generate_value_src(entry, base, 0)
                out += f"[{col}]);\n"
    else:
        for col in range(column_count):
            for row in range(row_count):
                out += f"\tresult *= {compare + compare_type}({src_name}[{col}][{row}], "
                if TYPES[entry.type].is_matrix:
                    out += float_to_string(0.0) + ");\n"
                else:
                    out += generate_value_src(entry, base, 0)
                    out += f"[{col}][{row}]);\n"
    return out


def generate_single_compare(element_type: str, src_name: str, base: bytes, entry: UniformLayoutEntry, matrix_load: int) -> str:
    if matrix_load == LOAD_FULL_MATRIX:
        promote = PROMOTE.get(element_type, element_type)
        cast = promote if promote != element_type else ""
        return f"\tresult *= compare_{element_type}({cast}({src_name}), " + generate_value_src(entry, base, 0) + ");\n"
    out = ""
    if TYPES[element_type].is_matrix:
        if element_type in MATRIX_PER_VEC:
            columns, rows, vec = MATRIX_PER_VEC[element_type]
            out += write_matrix_type_src(columns, rows, "compare_", vec, src_name, base, entry, True)
            out += write_matrix_type_src(columns, rows, "compare_", "float", src_name, base, entry, False)
    return out


def generate_compare_src_type(t: VarType, src_name: str, api_name: str, layout: UniformLayout, block_ndx: int, block: UniformBlock, instance_ndx: int, base: bytes, unused_mask: int,
                              matrix_load: int) -> str:
    if t.is_basic or (t.is_array and t.elem.is_basic):
        is_array = t.is_array
        element_type = t.elem.basic if is_array else t.basic
        full_api_name = api_name + ("[0]" if is_array else "")
        entry = layout.uniforms[layout.uniform_index(block_ndx, full_api_name)]
        promote = PROMOTE.get(element_type, element_type)
        cast = promote if promote != element_type else ""
        out = ""
        if is_array:
            array_size = block.last_unsized[instance_ndx] if t.size == UNSIZED_ARRAY else t.size
            for elem_ndx in range(array_size):
                out += f"\tresult *= compare_{element_type}({cast}({src_name}[{elem_ndx}]), " + generate_value_src(entry, base, elem_ndx) + ");\n"
        else:
            out += generate_single_compare(element_type, src_name, base, entry, matrix_load)
        return out
    out = ""
    if t.is_array:
        for elem_ndx in range(t.size):
            out += generate_compare_src_type(t.elem, f"{src_name}[{elem_ndx}]", f"{api_name}[{elem_ndx}]", layout, block_ndx, block, instance_ndx, base, unused_mask, LOAD_FULL_MATRIX)
    else:
        for m in t.struct.members:
            if m.flags & unused_mask:
                continue
            out += generate_compare_src_type(m.type, f"{src_name}.{m.name}", f"{api_name}.{m.name}", layout, block_ndx, block, instance_ndx, base, unused_mask, LOAD_FULL_MATRIX)
    return out


def generate_compare_src(interface: ShaderInterface, layout: UniformLayout, check_flag: int, unused_mask: int, matrix_load: int) -> str:
    out = ""
    for block_ndx, block in enumerate(interface.blocks):
        if not block.flags & check_flag:
            continue
        has_instance = block.has_instance_name
        is_array = block.is_array
        num_instances = block.array_size if is_array else 1
        api_prefix = block.block_name + "." if has_instance else ""
        assert not is_array or has_instance
        for instance_ndx in range(num_instances):
            instance_postfix = ""
            if is_array:
                index = str(instance_ndx)
                if interface.uses_block_layout(LAYOUT_DESCRIPTOR_INDEXING):
                    index = f"nonuniformEXT({index})"
                instance_postfix = f"[{index}]"
            src_prefix = block.instance_name + instance_postfix + "." if has_instance else ""
            for u in block.uniforms:
                if u.flags & unused_mask:
                    continue
                out += generate_compare_src_type(u.type, src_prefix + u.name, api_prefix + u.name, layout, block_ndx, block, instance_ndx, b"", unused_mask, matrix_load)
    return out


def has_unsized_array(interface: ShaderInterface) -> bool:
    return any(u.type.is_array and u.type.size == UNSIZED_ARRAY for b in interface.blocks for u in b.uniforms)


def shader_header(interface: ShaderInterface) -> str:
    out = "#version 450\n"
    out += "#extension GL_EXT_shader_16bit_storage : enable\n#extension GL_EXT_shader_8bit_storage : enable\n#extension GL_EXT_scalar_block_layout : enable\n#extension GL_EXT_nonuniform_qualifier : enable\n"
    if has_unsized_array(interface):
        out += "#extension GL_EXT_uniform_buffer_unsized_array : enable\n"
    return out


def struct_declarations(interface: ShaderInterface) -> str:
    return "".join(generate_full_struct_declaration(s, 0) + ";\n" for s in interface.named_structs())


def generate_vertex_shader(interface, layout, matrix_load, shuffle) -> str:
    src = shader_header(interface)
    src += "layout(location = 0) in highp vec4 a_position;\nlayout(location = 0) out mediump float v_vtxResult;\n\n"
    src += struct_declarations(interface)
    for block_ndx, block in enumerate(interface.blocks):
        if block.flags & DECLARE_VERTEX:
            src += generate_block_declaration(block_ndx, block, layout, shuffle)
    src += "\n" + generate_compare_funcs(interface)
    src += "\nvoid main (void)\n{\n    gl_Position = a_position;\n    mediump float result = 1.0;\n"
    src += generate_compare_src(interface, layout, DECLARE_VERTEX, UNUSED_VERTEX, matrix_load)
    src += "    v_vtxResult = result;\n}\n"
    return src


def generate_fragment_shader(interface, layout, matrix_load, shuffle) -> str:
    src = shader_header(interface)
    src += "layout(location = 0) in mediump float v_vtxResult;\nlayout(location = 0) out mediump vec4 dEQP_FragColor;\n\n"
    src += struct_declarations(interface)
    for block_ndx, block in enumerate(interface.blocks):
        if block.flags & DECLARE_FRAGMENT:
            src += generate_block_declaration(block_ndx, block, layout, shuffle)
    src += "\n" + generate_compare_funcs(interface)
    src += "\nvoid main (void)\n{\n    mediump float result = 1.0;\n"
    src += generate_compare_src(interface, layout, DECLARE_FRAGMENT, UNUSED_FRAGMENT, matrix_load)
    src += "    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);\n}\n"
    return src


def generate_compute_shader(interface, layout, matrix_load, shuffle) -> str:
    src = shader_header(interface)
    src += "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\n"
    num_blocks = len(interface.blocks)
    max_binding = num_blocks - 1 if num_blocks else -1
    image_binding = max_binding + 1
    src += f"layout(set = 0, binding = {image_binding}, rgba8) writeonly uniform image2D outImage;\n\n"
    src += struct_declarations(interface)
    for block_ndx, block in enumerate(interface.blocks):
        if block.flags & DECLARE_COMPUTE:
            src += generate_block_declaration(block_ndx, block, layout, shuffle)
    src += "\n" + generate_compare_funcs(interface)
    src += "\nvoid main (void)\n{\n    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);\n    mediump float result = 1.0;\n"
    src += generate_compare_src(interface, layout, DECLARE_COMPUTE, 0, matrix_load)
    src += "    imageStore(outImage, coord, vec4(result));\n}\n"
    return src


# ---------------------------------------------------------------------------------------------------------------------
# UniformBlockCase
# ---------------------------------------------------------------------------------------------------------------------


@dataclass
class UboCase:
    path: list
    buffer_mode: int
    interface: ShaderInterface
    matrix_load: int
    shuffle: bool = False
    layout: UniformLayout = None
    programs: dict = field(default_factory=dict)

    def delayed_init(self):
        self.layout = compute_reference_layout(self.interface)
        if self.is_compute:
            self.programs["comp"] = ("comp", generate_compute_shader(self.interface, self.layout, self.matrix_load, self.shuffle))
        else:
            self.programs["vert"] = ("vert", generate_vertex_shader(self.interface, self.layout, self.matrix_load, self.shuffle))
            self.programs["frag"] = ("frag", generate_fragment_shader(self.interface, self.layout, self.matrix_load, self.shuffle))

    @property
    def is_compute(self) -> bool:
        return self.interface.uses_block_layout(DECLARE_COMPUTE)

    def uses(self, flag: int) -> bool:
        return self.interface.uses_block_layout(flag)

    @property
    def requirements(self) -> int:
        """bit set of the flags checkSupport looks at"""
        mask = 0
        for flag in (LAYOUT_16BIT_STORAGE, LAYOUT_8BIT_STORAGE, LAYOUT_STD430, LAYOUT_SCALAR, LAYOUT_DESCRIPTOR_INDEXING):
            if self.uses(flag):
                mask |= flag
        return mask

    @property
    def unsized(self) -> bool:
        return has_unsized_array(self.interface)


def block_basic_type_case(path, type_: VarType, layout_flags: int, num_instances: int, matrix_load: int) -> UboCase:
    temp = type_
    while temp.is_array:
        temp = temp.elem
    scalar = TYPES[temp.basic].scalar
    if scalar in ("uint16_t", "int16_t", "float16_t"):
        layout_flags |= LAYOUT_16BIT_STORAGE
    if scalar in ("uint8_t", "int8_t"):
        layout_flags |= LAYOUT_8BIT_STORAGE
    interface = ShaderInterface()
    block = interface.alloc_block("Block")
    # `isDataTypeScalar(type.getBasicType())` on an array reads the union's pointer bits as a DataType, which is never a scalar type, so arrays get the padding too
    if layout_flags & LAYOUT_SCALAR and (type_.is_array or not TYPES[type_.basic].is_scalar):
        block.add_uniform(Uniform("padding", basic(scalar, 0), 0))
    block.add_uniform(Uniform("var", type_, 0))
    block.flags = layout_flags
    if num_instances > 0:
        block.set_array_size(num_instances)
        block.instance_name = "block"
    return UboCase(path, BUFFERMODE_PER_BLOCK, interface, matrix_load)


def unsized_array_case(path, element_type: VarType, array_size: int, layout_flags: int, matrix_load: int) -> UboCase:
    interface = ShaderInterface()
    block = interface.alloc_block("Block")
    block.add_uniform(Uniform("var", array(element_type, UNSIZED_ARRAY), 0))
    temp = element_type
    while temp.is_array:
        temp = temp.elem
    scalar = TYPES[temp.basic].scalar
    if scalar in ("uint16_t", "int16_t", "float16_t"):
        layout_flags |= LAYOUT_16BIT_STORAGE
    if scalar in ("uint8_t", "int8_t"):
        layout_flags |= LAYOUT_8BIT_STORAGE
    block.flags = layout_flags
    block.last_unsized[0] = array_size
    return UboCase(path, BUFFERMODE_PER_BLOCK, interface, matrix_load)


def _with_instances(block: UniformBlock, num_instances: int, instance_name: str = "block"):
    if num_instances > 0:
        block.instance_name = instance_name
        block.set_array_size(num_instances)


def single_struct_case(path, layout_flags, buffer_mode, num_instances, matrix_load) -> UboCase:
    interface = ShaderInterface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("ivec3", PRECISION_HIGH), UNUSED_BOTH)
    s.add_member("b", array(basic("mat3", PRECISION_MEDIUM), 4))
    s.add_member("c", basic("vec4", PRECISION_HIGH))
    block = interface.alloc_block("Block")
    block.add_uniform(Uniform("s", struct(s), 0))
    block.flags = layout_flags
    _with_instances(block, num_instances)
    return UboCase(path, buffer_mode, interface, matrix_load)


def single_struct_array_case(path, layout_flags, buffer_mode, num_instances, matrix_load) -> UboCase:
    interface = ShaderInterface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("ivec3", PRECISION_HIGH), UNUSED_BOTH)
    s.add_member("b", array(basic("mat3", PRECISION_MEDIUM), 4))
    s.add_member("c", basic("vec4", PRECISION_HIGH))
    block = interface.alloc_block("Block")
    block.add_uniform(Uniform("u", basic("uint", PRECISION_LOW)))
    block.add_uniform(Uniform("s", array(struct(s), 3)))
    block.add_uniform(Uniform("v", basic("vec4", PRECISION_MEDIUM)))
    block.flags = layout_flags
    _with_instances(block, num_instances)
    return UboCase(path, buffer_mode, interface, matrix_load)


def single_nested_struct_case(path, layout_flags, buffer_mode, num_instances, matrix_load) -> UboCase:
    interface = ShaderInterface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("ivec3", PRECISION_HIGH))
    s.add_member("b", array(basic("mat3", PRECISION_MEDIUM), 4))
    s.add_member("c", basic("vec4", PRECISION_HIGH), UNUSED_BOTH)
    t = interface.alloc_struct("T")
    t.add_member("a", basic("mat3", PRECISION_MEDIUM))
    t.add_member("b", struct(s))
    block = interface.alloc_block("Block")
    block.add_uniform(Uniform("s", struct(s), 0))
    block.add_uniform(Uniform("v", basic("vec2", PRECISION_LOW), UNUSED_BOTH))
    block.add_uniform(Uniform("t", struct(t), 0))
    block.add_uniform(Uniform("u", basic("uint", PRECISION_HIGH), 0))
    block.flags = layout_flags
    _with_instances(block, num_instances)
    return UboCase(path, buffer_mode, interface, matrix_load)


def single_nested_struct_array_case(path, layout_flags, buffer_mode, num_instances, matrix_load) -> UboCase:
    interface = ShaderInterface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("ivec3", PRECISION_HIGH))
    s.add_member("b", array(basic("ivec2", PRECISION_MEDIUM), 4))
    s.add_member("c", basic("vec4", PRECISION_HIGH), UNUSED_BOTH)
    t = interface.alloc_struct("T")
    t.add_member("a", basic("mat3", PRECISION_MEDIUM))
    t.add_member("b", array(struct(s), 3))
    block = interface.alloc_block("Block")
    block.add_uniform(Uniform("s", struct(s), 0))
    block.add_uniform(Uniform("v", basic("vec2", PRECISION_LOW), UNUSED_BOTH))
    block.add_uniform(Uniform("t", array(struct(t), 2), 0))
    block.add_uniform(Uniform("u", basic("uint", PRECISION_HIGH), 0))
    block.flags = layout_flags
    _with_instances(block, num_instances)
    return UboCase(path, buffer_mode, interface, matrix_load)


def multi_basic_types_case(path, flags_a, flags_b, buffer_mode, num_instances, matrix_load) -> UboCase:
    interface = ShaderInterface()
    a = interface.alloc_block("BlockA")
    a.add_uniform(Uniform("a", basic("float", PRECISION_HIGH)))
    a.add_uniform(Uniform("b", basic("uvec3", PRECISION_LOW), UNUSED_BOTH))
    a.add_uniform(Uniform("c", basic("mat2", PRECISION_MEDIUM)))
    a.instance_name = "blockA"
    a.flags = flags_a
    b = interface.alloc_block("BlockB")
    b.add_uniform(Uniform("a", basic("mat3", PRECISION_MEDIUM)))
    b.add_uniform(Uniform("b", basic("ivec2", PRECISION_LOW)))
    b.add_uniform(Uniform("c", basic("vec4", PRECISION_HIGH), UNUSED_BOTH))
    b.add_uniform(Uniform("d", basic("bool", 0)))
    b.instance_name = "blockB"
    b.flags = flags_b
    if num_instances > 0:
        a.set_array_size(num_instances)
        b.set_array_size(num_instances)
    return UboCase(path, buffer_mode, interface, matrix_load)


def multi_nested_struct_case(path, flags_a, flags_b, buffer_mode, num_instances, matrix_load) -> UboCase:
    interface = ShaderInterface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("mat3", PRECISION_LOW))
    s.add_member("b", array(basic("ivec2", PRECISION_MEDIUM), 4))
    s.add_member("c", basic("vec4", PRECISION_HIGH))
    t = interface.alloc_struct("T")
    t.add_member("a", basic("uint", PRECISION_MEDIUM), UNUSED_BOTH)
    t.add_member("b", struct(s))
    t.add_member("c", basic("bvec4", 0))
    a = interface.alloc_block("BlockA")
    a.add_uniform(Uniform("a", basic("float", PRECISION_HIGH)))
    a.add_uniform(Uniform("b", struct(s)))
    a.add_uniform(Uniform("c", basic("uvec3", PRECISION_LOW), UNUSED_BOTH))
    a.instance_name = "blockA"
    a.flags = flags_a
    b = interface.alloc_block("BlockB")
    b.add_uniform(Uniform("a", basic("mat2", PRECISION_MEDIUM)))
    b.add_uniform(Uniform("b", struct(t)))
    b.add_uniform(Uniform("c", basic("bvec4", 0), UNUSED_BOTH))
    b.add_uniform(Uniform("d", basic("bool", 0)))
    b.instance_name = "blockB"
    b.flags = flags_b
    if num_instances > 0:
        a.set_array_size(num_instances)
        b.set_array_size(num_instances)
    return UboCase(path, buffer_mode, interface, matrix_load)


def block_2level_struct_array_case(path, layout_flags, buffer_mode, num_instances, matrix_load) -> UboCase:
    interface = ShaderInterface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("uvec3", PRECISION_HIGH), UNUSED_BOTH)
    s.add_member("b", array(basic("mat2", PRECISION_MEDIUM), 4))
    s.add_member("c", basic("uint", PRECISION_LOW))
    block = interface.alloc_block("Block")
    block.add_uniform(Uniform("u", basic("int", PRECISION_MEDIUM)))
    block.add_uniform(Uniform("s", array(array(struct(s), 3), 2)))
    block.add_uniform(Uniform("v", basic("vec2", PRECISION_MEDIUM)))
    block.flags = layout_flags
    _with_instances(block, num_instances)
    return UboCase(path, buffer_mode, interface, matrix_load)


def link_by_binding_case(path, buffer_mode, num_instances) -> UboCase:
    interface = ShaderInterface()
    a = interface.alloc_block("TestBlock")
    a.add_uniform(Uniform("a", basic("float", PRECISION_HIGH)))
    a.add_uniform(Uniform("b", basic("uvec3", PRECISION_LOW), UNUSED_BOTH))
    a.add_uniform(Uniform("c", basic("mat2", PRECISION_MEDIUM)))
    a.flags = LAYOUT_STD140 | DECLARE_VERTEX
    b = interface.alloc_block("TestBlock")
    b.add_uniform(Uniform("a", basic("mat3", PRECISION_MEDIUM)))
    b.add_uniform(Uniform("b", basic("ivec2", PRECISION_LOW)))
    b.add_uniform(Uniform("c", basic("vec4", PRECISION_HIGH), UNUSED_BOTH))
    b.add_uniform(Uniform("d", basic("bool", 0)))
    b.flags = LAYOUT_STD140 | DECLARE_FRAGMENT
    if num_instances > 0:
        a.instance_name = "testBlock"
        a.set_array_size(num_instances)
        b.instance_name = "testBlock"
        b.set_array_size(num_instances)
    return UboCase(path, buffer_mode, interface, LOAD_FULL_MATRIX)


# ---------------------------------------------------------------------------------------------------------------------
# RandomUniformBlockCase
# ---------------------------------------------------------------------------------------------------------------------

FEATURE_VECTORS = 1 << 0
FEATURE_MATRICES = 1 << 1
FEATURE_ARRAYS = 1 << 2
FEATURE_STRUCTS = 1 << 3
FEATURE_NESTED_STRUCTS = 1 << 4
FEATURE_INSTANCE_ARRAYS = 1 << 5
FEATURE_VERTEX_BLOCKS = 1 << 6
FEATURE_FRAGMENT_BLOCKS = 1 << 7
FEATURE_COMPUTE_BLOCKS = 1 << 8
FEATURE_SHARED_BLOCKS = 1 << 9
FEATURE_UNUSED_UNIFORMS = 1 << 10
FEATURE_UNUSED_MEMBERS = 1 << 11
FEATURE_PACKED_LAYOUT = 1 << 12
FEATURE_SHARED_LAYOUT = 1 << 13
FEATURE_STD140_LAYOUT = 1 << 14
FEATURE_MATRIX_LAYOUT = 1 << 15
FEATURE_ARRAYS_OF_ARRAYS = 1 << 16
FEATURE_OUT_OF_ORDER_OFFSETS = 1 << 17
FEATURE_16BIT_STORAGE = 1 << 18
FEATURE_8BIT_STORAGE = 1 << 19
FEATURE_STD430_LAYOUT = 1 << 20
FEATURE_SCALAR_LAYOUT = 1 << 21
FEATURE_DESCRIPTOR_INDEXING = 1 << 22


class Rnd(de_random.DeRandom):
    """`de::Random` with the calls the random cases make"""

    def get_bool(self) -> bool:
        return (self.get_uint32() & 0xFFFFFF) < 0x800000

    def choose(self, items):
        chosen = items[0]
        for ndx in range(1, len(items)):
            if self.get_int(0, ndx) < 1:
                chosen = items[ndx]
        return chosen


F32 = de_random.to_f32


def gen_name(first: str, last: str, ndx: int) -> str:
    alphabet_len = ord(last) - ord(first) + 1
    out = ""
    while ndx > alphabet_len:
        out = chr(ord(first) + ((ndx - 1) % alphabet_len)) + out
        ndx = (ndx - 1) // alphabet_len
    out = chr(ord(first) + (ndx % (alphabet_len + 1)) - 1) + out
    return out


class RandomBuilder:
    def __init__(self, features: int, seed: int):
        self.features = features
        self.max_vertex = 4 if features & FEATURE_VERTEX_BLOCKS else 0
        self.max_fragment = 4 if features & FEATURE_FRAGMENT_BLOCKS else 0
        self.max_compute = 4 if features & FEATURE_COMPUTE_BLOCKS else 0
        self.max_shared = 4 if features & FEATURE_SHARED_BLOCKS else 0
        self.max_instances = 3 if features & FEATURE_INSTANCE_ARRAYS else 0
        self.max_array_length = 8 if features & FEATURE_ARRAYS else 0
        self.max_struct_depth = 2 if features & FEATURE_STRUCTS else 0
        self.max_block_members = 5
        self.max_struct_members = 4
        self.shuffle = bool(features & FEATURE_OUT_OF_ORDER_OFFSETS)
        self.block_ndx = 1
        self.uniform_ndx = 1
        self.struct_ndx = 1
        self.available_descriptors = 12
        self.interface = ShaderInterface()

        rnd = Rnd(seed & MASK32)
        num_shared = rnd.get_int(1, self.max_shared) if self.max_shared > 0 else 0
        num_vtx = rnd.get_int(1, self.max_vertex - num_shared) if self.max_vertex - num_shared > 0 else 0
        num_frag = rnd.get_int(1, self.max_fragment - num_shared) if self.max_fragment - num_shared > 0 else 0
        num_comp = rnd.get_int(1, self.max_compute) if self.max_compute > 0 else 0
        self.available_descriptors -= num_vtx + num_frag + num_comp

        for _ in range(num_shared):
            self.generate_block(rnd, DECLARE_VERTEX | DECLARE_FRAGMENT)
        for _ in range(num_vtx):
            self.generate_block(rnd, DECLARE_VERTEX)
        for _ in range(num_frag):
            self.generate_block(rnd, DECLARE_FRAGMENT)
        for _ in range(num_comp):
            self.generate_block(rnd, DECLARE_COMPUTE)

    def generate_block(self, rnd: Rnd, layout_flags: int):
        instance_array_weight = F32(0.3)
        block = self.interface.alloc_block("Block" + chr(ord("A") + self.block_ndx))
        num_instances = rnd.get_int(0, self.max_instances) if (self.max_instances > 0 and rnd.get_float() < instance_array_weight) else 0
        num_uniforms = rnd.get_int(1, self.max_block_members)

        if self.features & FEATURE_DESCRIPTOR_INDEXING:
            if self.available_descriptors > 3:
                num_instances = rnd.get_int(2, 4)
            elif self.available_descriptors > 1:
                num_instances = self.available_descriptors
            else:
                num_instances = 0
            self.available_descriptors -= num_instances

        if num_instances > 0:
            block.set_array_size(num_instances)

        if num_instances > 0 or rnd.get_bool():
            block.instance_name = "block" + chr(ord("A") + self.block_ndx)

        candidates = [0]
        if self.features & FEATURE_STD140_LAYOUT:
            candidates.append(LAYOUT_STD140)
        if self.features & FEATURE_STD430_LAYOUT:
            candidates.append(LAYOUT_STD430)
        if self.features & FEATURE_SCALAR_LAYOUT:
            candidates.append(LAYOUT_SCALAR)
        if self.features & FEATURE_16BIT_STORAGE:
            layout_flags |= LAYOUT_16BIT_STORAGE
        if self.features & FEATURE_8BIT_STORAGE:
            layout_flags |= LAYOUT_8BIT_STORAGE
        if self.features & FEATURE_DESCRIPTOR_INDEXING:
            layout_flags |= LAYOUT_DESCRIPTOR_INDEXING
        layout_flags |= rnd.choose(candidates)
        if self.features & FEATURE_MATRIX_LAYOUT:
            layout_flags |= rnd.choose([0, LAYOUT_ROW_MAJOR, LAYOUT_COLUMN_MAJOR])
        block.flags = layout_flags

        for _ in range(num_uniforms):
            self.generate_uniform(rnd, block, num_instances if num_instances else 1)
        self.block_ndx += 1

    def generate_uniform(self, rnd: Rnd, block: UniformBlock, complexity: int):
        unused_vtx_weight = F32(0.15)
        unused_frag_weight = F32(0.15)
        unused_ok = bool(self.features & FEATURE_UNUSED_UNIFORMS)
        flags = 0
        name = gen_name("a", "z", self.uniform_ndx)
        type_ = self.generate_type(rnd, 0, True, complexity)
        flags |= UNUSED_VERTEX if (unused_ok and rnd.get_float() < unused_vtx_weight) else 0
        flags |= UNUSED_FRAGMENT if (unused_ok and rnd.get_float() < unused_frag_weight) else 0
        block.add_uniform(Uniform(name, type_, flags))
        self.uniform_ndx += 1

    def generate_type(self, rnd: Rnd, type_depth: int, array_ok: bool, complexity: int) -> VarType:
        struct_weight = F32(0.1)
        array_weight = F32(0.1)

        if type_depth < self.max_struct_depth and rnd.get_float() < struct_weight:
            unused_vtx_weight = F32(0.15)
            unused_frag_weight = F32(0.15)
            unused_ok = bool(self.features & FEATURE_UNUSED_MEMBERS)
            num_members = rnd.get_int(1, self.max_struct_members)
            member_types = [self.generate_type(rnd, type_depth + 1, True, complexity) for _ in range(num_members)]
            st = self.interface.alloc_struct("s" + gen_name("A", "Z", self.struct_ndx))
            self.struct_ndx += 1
            for ndx in range(num_members):
                flags = 0
                flags |= UNUSED_VERTEX if (unused_ok and rnd.get_float() < unused_vtx_weight) else 0
                flags |= UNUSED_FRAGMENT if (unused_ok and rnd.get_float() < unused_frag_weight) else 0
                st.add_member("m" + chr(ord("A") + ndx), member_types[ndx], flags)
            return struct(st, LAYOUT_OFFSET if self.shuffle else 0)
        if self.max_array_length > 0 and array_ok and rnd.get_float() < array_weight:
            arrays_of_arrays_ok = bool(self.features & FEATURE_ARRAYS_OF_ARRAYS)
            array_length = rnd.get_int(1, self.max_array_length)
            if complexity * array_length >= 70:
                array_length = 1
            element_type = self.generate_type(rnd, type_depth, arrays_of_arrays_ok, complexity * array_length)
            return array(element_type, array_length)

        candidates = ["float", "int", "uint", "bool"]
        if self.features & FEATURE_16BIT_STORAGE:
            candidates += ["uint16_t", "int16_t", "float16_t"]
        if self.features & FEATURE_8BIT_STORAGE:
            candidates += ["uint8_t", "int8_t"]
        if self.features & FEATURE_VECTORS:
            candidates += ["vec2", "vec3", "vec4", "ivec2", "ivec3", "ivec4", "uvec2", "uvec3", "uvec4", "bvec2", "bvec3", "bvec4"]
            if self.features & FEATURE_16BIT_STORAGE:
                candidates += ["f16vec2", "f16vec3", "f16vec4", "i16vec2", "i16vec3", "i16vec4", "u16vec2", "u16vec3", "u16vec4"]
            if self.features & FEATURE_8BIT_STORAGE:
                candidates += ["i8vec2", "i8vec3", "i8vec4", "u8vec2", "u8vec3", "u8vec4"]
        if self.features & FEATURE_MATRICES:
            candidates += ["mat2", "mat2x3", "mat3x2", "mat3", "mat3x4", "mat4x2", "mat4x3", "mat4"]
        type_name = rnd.choose(candidates)
        flags = LAYOUT_OFFSET if self.shuffle else 0
        if supports_precision(type_name):
            flags |= rnd.choose([PRECISION_LOW, PRECISION_MEDIUM, PRECISION_HIGH])
        return basic(type_name, flags)


def random_case(path, buffer_mode, features: int, seed: int) -> UboCase:
    builder = RandomBuilder(features, seed)
    return UboCase(path, buffer_mode, builder.interface, LOAD_FULL_MATRIX, builder.shuffle)


# ---------------------------------------------------------------------------------------------------------------------
# The tree (UniformBlockTests::init)
# ---------------------------------------------------------------------------------------------------------------------

BASIC_TYPES = ["float", "vec2", "vec3", "vec4", "int", "ivec2", "ivec3", "ivec4", "uint", "uvec2", "uvec3", "uvec4", "bool", "bvec2", "bvec3", "bvec4", "mat2", "mat3", "mat4",
               "mat2x3", "mat2x4", "mat3x2", "mat3x4", "mat4x2", "mat4x3", "uint8_t", "u8vec2", "u8vec3", "u8vec4", "int8_t", "i8vec2", "i8vec3", "i8vec4", "uint16_t", "u16vec2",
               "u16vec3", "u16vec4", "int16_t", "i16vec2", "i16vec3", "i16vec4", "float16_t", "f16vec2", "f16vec3", "f16vec4"]
PRECISION_FLAGS = [("lowp", PRECISION_LOW), ("mediump", PRECISION_MEDIUM), ("highp", PRECISION_HIGH)]
LAYOUT_FLAGS = [("std140", LAYOUT_STD140), ("std430", LAYOUT_STD430), ("scalar", LAYOUT_SCALAR)]
MATRIX_FLAGS = [("row_major", LAYOUT_ROW_MAJOR), ("column_major", LAYOUT_COLUMN_MAJOR)]
BUFFER_MODES = [("per_block_buffer", BUFFERMODE_PER_BLOCK), ("single_buffer", BUFFERMODE_SINGLE)]


def prec_flags(name: str) -> int:
    return PRECISION_HIGH if supports_precision(name) else 0


def create_block_basic_type_cases(cases, group, name, type_, layout_flags, num_instances=0):
    path = group + [name]
    cases.append(block_basic_type_case(path + ["vertex"], type_, layout_flags | DECLARE_VERTEX, num_instances, LOAD_FULL_MATRIX))
    cases.append(block_basic_type_case(path + ["fragment"], type_, layout_flags | DECLARE_FRAGMENT, num_instances, LOAD_FULL_MATRIX))
    cases.append(block_basic_type_case(path + ["compute"], type_, layout_flags | DECLARE_COMPUTE, num_instances, LOAD_FULL_MATRIX))
    cases.append(block_basic_type_case(path + ["both"], type_, layout_flags | DECLARE_VERTEX | DECLARE_FRAGMENT, num_instances, LOAD_FULL_MATRIX))
    cases.append(block_basic_type_case(path + ["vertex_comp_access"], type_, layout_flags | DECLARE_VERTEX, num_instances, LOAD_MATRIX_COMPONENTS))
    cases.append(block_basic_type_case(path + ["fragment_comp_access"], type_, layout_flags | DECLARE_FRAGMENT, num_instances, LOAD_MATRIX_COMPONENTS))
    cases.append(block_basic_type_case(path + ["compute_comp_access"], type_, layout_flags | DECLARE_COMPUTE, num_instances, LOAD_MATRIX_COMPONENTS))
    cases.append(block_basic_type_case(path + ["both_comp_access"], type_, layout_flags | DECLARE_VERTEX | DECLARE_FRAGMENT, num_instances, LOAD_MATRIX_COMPONENTS))


def create_unsized_array_test_cases(cases, group, name, type_, layout_flags, array_size, matrix_load=LOAD_FULL_MATRIX):
    suffix = "_comp_access" if matrix_load == LOAD_MATRIX_COMPONENTS else ""
    cases.append(unsized_array_case(group + [name + "_vertex" + suffix], type_, array_size, layout_flags | DECLARE_VERTEX, matrix_load))
    cases.append(unsized_array_case(group + [name + "_fragment" + suffix], type_, array_size, layout_flags | DECLARE_FRAGMENT, matrix_load))
    cases.append(unsized_array_case(group + [name + "_compute" + suffix], type_, array_size, layout_flags | DECLARE_COMPUTE, matrix_load))
    cases.append(unsized_array_case(group + [name + "_both" + suffix], type_, array_size, layout_flags | DECLARE_VERTEX | DECLARE_FRAGMENT, matrix_load))


def create_random_case_group(cases, group, group_name, buffer_mode, features, num_cases, base_seed):
    for ndx in range(num_cases):
        cases.append(random_case(group + [group_name, str(ndx)], buffer_mode, features, (ndx + base_seed) & MASK32))


def struct_family(cases, group, factory, multi=False):
    """the `mode/layout[_instance_array]_{stage}[_comp_access]` families of single_struct and friends"""
    for mode_name, mode in BUFFER_MODES:
        for layout_name, layout_flag in LAYOUT_FLAGS:
            for is_array in (0, 1):
                base_name = layout_name
                base_flags = layout_flag
                if not multi and mode == BUFFERMODE_SINGLE and is_array == 0:
                    continue
                if is_array:
                    base_name += "_instance_array"
                n = 3 if is_array else 0
                path = group + [mode_name]
                if multi:
                    variants = [("_vertex", DECLARE_VERTEX, DECLARE_VERTEX, LOAD_FULL_MATRIX), ("_fragment", DECLARE_FRAGMENT, DECLARE_FRAGMENT, LOAD_FULL_MATRIX),
                                ("_compute", DECLARE_COMPUTE, DECLARE_COMPUTE, LOAD_FULL_MATRIX), ("_both", DECLARE_VERTEX | DECLARE_FRAGMENT, DECLARE_VERTEX | DECLARE_FRAGMENT, LOAD_FULL_MATRIX),
                                ("_mixed", DECLARE_VERTEX, DECLARE_FRAGMENT, LOAD_FULL_MATRIX), ("_vertex_comp_access", DECLARE_VERTEX, DECLARE_VERTEX, LOAD_MATRIX_COMPONENTS),
                                ("_fragment_comp_access", DECLARE_FRAGMENT, DECLARE_FRAGMENT, LOAD_MATRIX_COMPONENTS),
                                ("_compute_comp_access", DECLARE_COMPUTE, DECLARE_COMPUTE, LOAD_MATRIX_COMPONENTS),
                                ("_both_comp_access", DECLARE_VERTEX | DECLARE_FRAGMENT, DECLARE_VERTEX | DECLARE_FRAGMENT, LOAD_MATRIX_COMPONENTS),
                                ("_mixed_comp_access", DECLARE_VERTEX, DECLARE_FRAGMENT, LOAD_MATRIX_COMPONENTS)]
                    for suffix, a, b, load in variants:
                        cases.append(factory(path + [base_name + suffix], base_flags | a, base_flags | b, mode, n, load))
                else:
                    variants = [("_vertex", DECLARE_VERTEX, LOAD_FULL_MATRIX), ("_fragment", DECLARE_FRAGMENT, LOAD_FULL_MATRIX), ("_compute", DECLARE_COMPUTE, LOAD_FULL_MATRIX),
                                ("_both", DECLARE_VERTEX | DECLARE_FRAGMENT, LOAD_FULL_MATRIX), ("_vertex_comp_access", DECLARE_VERTEX, LOAD_MATRIX_COMPONENTS),
                                ("_fragment_comp_access", DECLARE_FRAGMENT, LOAD_MATRIX_COMPONENTS), ("_compute_comp_access", DECLARE_COMPUTE, LOAD_MATRIX_COMPONENTS),
                                ("_both_comp_access", DECLARE_VERTEX | DECLARE_FRAGMENT, LOAD_MATRIX_COMPONENTS)]
                    for suffix, d, load in variants:
                        cases.append(factory(path + [base_name + suffix], base_flags | d, mode, n, load))


def all_cases() -> list:
    cases: list[UboCase] = []

    for depth_name, make in (("2_level_array", lambda t: array(array(basic(t, prec_flags(t)), 4), 3)),
                             ("3_level_array", lambda t: array(array(array(basic(t, prec_flags(t)), 2), 4), 3))):
        for layout_name, layout_flag in LAYOUT_FLAGS:
            group = [depth_name, layout_name]
            for type_name in BASIC_TYPES:
                parent = make(type_name)
                create_block_basic_type_cases(cases, group, type_name, parent, layout_flag)
                if TYPES[type_name].is_matrix:
                    for mat_name, mat_flag in MATRIX_FLAGS:
                        create_block_basic_type_cases(cases, group, mat_name + "_" + type_name, parent, layout_flag | mat_flag)

    # ubo.2_level_struct_array
    for mode_name, mode in BUFFER_MODES:
        for layout_name, layout_flag in LAYOUT_FLAGS:
            for is_array in (0, 1):
                if mode == BUFFERMODE_SINGLE and is_array == 0:
                    continue
                base_name = layout_name + ("_instance_array" if is_array else "")
                n = 3 if is_array else 0
                path = ["2_level_struct_array", mode_name]
                for suffix, d, load in (("_vertex", DECLARE_VERTEX, LOAD_FULL_MATRIX), ("_fragment", DECLARE_FRAGMENT, LOAD_FULL_MATRIX),
                                        ("_both", DECLARE_VERTEX | DECLARE_FRAGMENT, LOAD_FULL_MATRIX), ("_vertex_comp_access", DECLARE_VERTEX, LOAD_MATRIX_COMPONENTS),
                                        ("_fragment_comp_access", DECLARE_FRAGMENT, LOAD_MATRIX_COMPONENTS), ("_both_comp_access", DECLARE_VERTEX | DECLARE_FRAGMENT, LOAD_MATRIX_COMPONENTS)):
                    cases.append(block_2level_struct_array_case(path + [base_name + suffix], layout_flag | d, mode, n, load))

    # ubo.single_basic_type
    for layout_name, layout_flag in LAYOUT_FLAGS:
        group = ["single_basic_type", layout_name]
        for type_name in BASIC_TYPES:
            if not supports_precision(type_name):
                create_block_basic_type_cases(cases, group, type_name, basic(type_name, 0), layout_flag)
        for prec_name, prec_flag in PRECISION_FLAGS:
            pgroup = group + [prec_name]
            for type_name in BASIC_TYPES:
                if supports_precision(type_name):
                    create_block_basic_type_cases(cases, pgroup, type_name, basic(type_name, prec_flag), layout_flag)
                if TYPES[type_name].is_matrix:
                    for mat_name, mat_flag in MATRIX_FLAGS:
                        create_block_basic_type_cases(cases, pgroup, mat_name + "_" + type_name, basic(type_name, prec_flag), layout_flag | mat_flag)

    # ubo.single_basic_array
    for layout_name, layout_flag in LAYOUT_FLAGS:
        group = ["single_basic_array", layout_name]
        for type_name in BASIC_TYPES:
            create_block_basic_type_cases(cases, group, type_name, array(basic(type_name, prec_flags(type_name)), 3), layout_flag)
            if TYPES[type_name].is_matrix:
                for mat_name, mat_flag in MATRIX_FLAGS:
                    create_block_basic_type_cases(cases, group, mat_name + "_" + type_name, array(basic(type_name, PRECISION_HIGH), 3), layout_flag | mat_flag)

    # ubo.unsized_array
    for layout_name, layout_flag in LAYOUT_FLAGS:
        group = ["unsized_array", layout_name]
        for type_name in BASIC_TYPES:
            with_precision = basic(type_name, prec_flags(type_name))
            create_unsized_array_test_cases(cases, group, type_name, with_precision, layout_flag, 19)
            if TYPES[type_name].is_matrix:
                for mat_name, mat_flag in MATRIX_FLAGS:
                    mat = mat_name + "_" + type_name
                    create_unsized_array_test_cases(cases, group, mat, with_precision, layout_flag | mat_flag, 19)
                    create_unsized_array_test_cases(cases, group, mat, with_precision, layout_flag | mat_flag, 19, LOAD_MATRIX_COMPONENTS)

    struct_family(cases, ["single_struct"], single_struct_case)
    struct_family(cases, ["single_struct_array"], single_struct_array_case)
    struct_family(cases, ["single_nested_struct"], single_nested_struct_case)
    struct_family(cases, ["single_nested_struct_array"], single_nested_struct_array_case)

    # ubo.instance_array_basic_type
    for layout_name, layout_flag in LAYOUT_FLAGS:
        group = ["instance_array_basic_type", layout_name]
        for type_name in BASIC_TYPES:
            create_block_basic_type_cases(cases, group, type_name, basic(type_name, prec_flags(type_name)), layout_flag, 3)
            if TYPES[type_name].is_matrix:
                for mat_name, mat_flag in MATRIX_FLAGS:
                    create_block_basic_type_cases(cases, group, mat_name + "_" + type_name, basic(type_name, PRECISION_HIGH), layout_flag | mat_flag, 3)

    struct_family(cases, ["multi_basic_types"], multi_basic_types_case, multi=True)
    struct_family(cases, ["multi_nested_struct"], multi_nested_struct_case, multi=True)

    # link_by_binding
    for name, mode, n in (("single_buf_single_instance", BUFFERMODE_SINGLE, 0), ("single_buf_instance_array", BUFFERMODE_SINGLE, 2),
                          ("per_block_buf_single_instance", BUFFERMODE_PER_BLOCK, 0), ("per_block_buf_instance_array", BUFFERMODE_PER_BLOCK, 2)):
        cases.append(link_by_binding_case(["link_by_binding", name], mode, n))

    # ubo.random
    all_graphics = FEATURE_VERTEX_BLOCKS | FEATURE_FRAGMENT_BLOCKS | FEATURE_SHARED_BLOCKS
    all_shaders = all_graphics | FEATURE_COMPUTE_BLOCKS
    all_layouts = FEATURE_STD140_LAYOUT
    all_basic = FEATURE_VECTORS | FEATURE_MATRICES
    unused = FEATURE_UNUSED_MEMBERS | FEATURE_UNUSED_UNIFORMS
    mat_flags = FEATURE_MATRIX_LAYOUT
    all_features = (~FEATURE_OUT_OF_ORDER_OFFSETS & ~FEATURE_16BIT_STORAGE & ~FEATURE_8BIT_STORAGE & ~FEATURE_STD430_LAYOUT & ~FEATURE_SCALAR_LAYOUT & ~FEATURE_DESCRIPTOR_INDEXING) & MASK32
    all_scalar = (~all_layouts & ~FEATURE_16BIT_STORAGE & ~FEATURE_8BIT_STORAGE & ~FEATURE_DESCRIPTOR_INDEXING) & MASK32
    descriptor_indexing = (FEATURE_STD140_LAYOUT | FEATURE_STD430_LAYOUT | FEATURE_SCALAR_LAYOUT | FEATURE_DESCRIPTOR_INDEXING | all_shaders | all_basic | unused | mat_flags)

    for i in range(3):
        group = ["random"] + (["16bit"] if i == 1 else ["8bit"] if i == 2 else [])
        use16 = FEATURE_16BIT_STORAGE if i == 1 else 0
        use8 = FEATURE_8BIT_STORAGE if i == 2 else 0
        base = use8 | use16
        pb = BUFFERMODE_PER_BLOCK
        specs = [
            ("scalar_types", pb, all_graphics | all_layouts | unused, 0),
            ("scalar_types_compute", pb, all_shaders | all_layouts | unused, 0),
            ("vector_types", pb, all_graphics | all_layouts | unused | FEATURE_VECTORS, 25),
            ("vector_types_compute", pb, all_shaders | all_layouts | unused | FEATURE_VECTORS, 25),
            ("basic_types", pb, all_graphics | all_layouts | unused | all_basic | mat_flags, 50),
            ("basic_types_compute", pb, all_shaders | all_layouts | unused | all_basic | mat_flags, 50),
            ("basic_arrays", pb, all_graphics | all_layouts | unused | all_basic | mat_flags | FEATURE_ARRAYS, 50),
            ("basic_arrays_compute", pb, all_shaders | all_layouts | unused | all_basic | mat_flags | FEATURE_ARRAYS, 50),
            ("basic_instance_arrays", pb, all_graphics | all_layouts | unused | all_basic | mat_flags | FEATURE_INSTANCE_ARRAYS, 75),
            ("basic_instance_arrays_compute", pb, all_shaders | all_layouts | unused | all_basic | mat_flags | FEATURE_INSTANCE_ARRAYS, 75),
            ("nested_structs", pb, all_graphics | all_layouts | unused | all_basic | mat_flags | FEATURE_STRUCTS, 100),
            ("nested_structs_compute", pb, all_shaders | all_layouts | unused | all_basic | mat_flags | FEATURE_STRUCTS, 100),
            ("nested_structs_arrays", pb, all_graphics | all_layouts | unused | all_basic | mat_flags | FEATURE_STRUCTS | FEATURE_ARRAYS, 150),
            ("nested_structs_arrays_compute", pb, all_shaders | all_layouts | unused | all_basic | mat_flags | FEATURE_STRUCTS | FEATURE_ARRAYS, 150),
            ("nested_structs_instance_arrays", pb, all_graphics | all_layouts | unused | all_basic | mat_flags | FEATURE_STRUCTS | FEATURE_INSTANCE_ARRAYS, 125),
            ("nested_structs_instance_arrays_compute", pb, all_shaders | all_layouts | unused | all_basic | mat_flags | FEATURE_STRUCTS | FEATURE_INSTANCE_ARRAYS, 125),
            ("nested_structs_arrays_instance_arrays", pb, all_graphics | all_layouts | unused | all_basic | mat_flags | FEATURE_STRUCTS | FEATURE_ARRAYS | FEATURE_INSTANCE_ARRAYS, 175),
            ("nested_structs_arrays_instance_arrays_compute", pb, all_shaders | all_layouts | unused | all_basic | mat_flags | FEATURE_STRUCTS | FEATURE_ARRAYS | FEATURE_INSTANCE_ARRAYS, 175),
        ]
        for name, mode, features, seed in specs:
            create_random_case_group(cases, group, name, mode, base | features, 25, seed)
        create_random_case_group(cases, group, "all_per_block_buffers", pb, base | all_features, 50, 200)
        create_random_case_group(cases, group, "all_shared_buffer", BUFFERMODE_SINGLE, base | all_features, 50, 250)
        create_random_case_group(cases, group, "all_out_of_order_offsets", pb, base | all_features | FEATURE_OUT_OF_ORDER_OFFSETS, 50, 300)
        create_random_case_group(cases, group, "scalar", BUFFERMODE_SINGLE, base | all_scalar, 100, de_int32_hash(313))
        create_random_case_group(cases, group, "descriptor_indexing", BUFFERMODE_SINGLE, base | descriptor_indexing, 50, 123)

    for case in cases:
        case.delayed_init()
    return cases


def de_int32_hash(a: int) -> int:
    key = a & MASK32
    key = ((key ^ 61) ^ (key >> 16)) & MASK32
    key = (key + ((key << 3) & MASK32)) & MASK32
    key ^= key >> 4
    key = (key * 0x27D4EB2D) & MASK32
    key ^= key >> 15
    return key & MASK32

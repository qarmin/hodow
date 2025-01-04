"""The case tree, reference layout, reference data and compute shaders of dEQP-VK.ssbo.layout / readonly.layout / phys.layout

A transliteration of vktSSBOLayoutCase.cpp and vktSSBOLayoutTests.cpp (plus the vktTypeComparisonUtil.cpp helpers). gen_ssbo_manifest.py writes the shader manifest and the Rust
case table from it; src/vkt/tests/ssbo/ only has to draw the reference data from the layout again (it needs the same seeds), run the shader and compare.

Cases that allocate just over 4 GB (the *_64b ones) are not generated: `Case.big` is set and the runner reports them as not ported.

A pure text module: no glslang and no cargo.
"""

import struct
from dataclasses import dataclass, field

import de_random
import ubo_cases as uc
from ubo_cases import TYPES, VarType, array, basic, struct as struct_type

MASK32 = 0xFFFFFFFF

L_STD140 = 1 << 0
L_STD430 = 1 << 1
L_ROW_MAJOR = 1 << 2
L_COLUMN_MAJOR = 1 << 3
L_SCALAR = 1 << 4
L_MASK = L_STD430 | L_STD140 | L_ROW_MAJOR | L_COLUMN_MAJOR | L_SCALAR
ACCESS_READ = 1 << 9
ACCESS_WRITE = 1 << 10
L_RELAXED = 1 << 11
L_16BIT = 1 << 12
L_8BIT = 1 << 13
L_DESCRIPTOR_INDEXING = 1 << 14

LOAD_FULL_MATRIX = 0
LOAD_MATRIX_COMPONENTS = 1
STORE_FULL_MATRIX = 0
STORE_MATRIX_COLUMNS = 1

BUFFERMODE_SINGLE = 0
BUFFERMODE_PER_BLOCK = 1

UNSIZED = uc.UNSIZED_ARRAY

FEATURE_VECTORS = 1 << 0
FEATURE_MATRICES = 1 << 1
FEATURE_ARRAYS = 1 << 2
FEATURE_STRUCTS = 1 << 3
FEATURE_NESTED_STRUCTS = 1 << 4
FEATURE_INSTANCE_ARRAYS = 1 << 5
FEATURE_UNUSED_VARS = 1 << 6
FEATURE_UNUSED_MEMBERS = 1 << 7
FEATURE_STD140_LAYOUT = 1 << 8
FEATURE_STD430_LAYOUT = 1 << 9
FEATURE_MATRIX_LAYOUT = 1 << 10
FEATURE_UNSIZED_ARRAYS = 1 << 11
FEATURE_ARRAYS_OF_ARRAYS = 1 << 12
FEATURE_RELAXED_LAYOUT = 1 << 13
FEATURE_16BIT_STORAGE = 1 << 14
FEATURE_8BIT_STORAGE = 1 << 15
FEATURE_SCALAR_LAYOUT = 1 << 16
FEATURE_DESCRIPTOR_INDEXING = 1 << 17
FEATURE_64B = 1 << 18

PREC_NAMES = {0: "", uc.PRECISION_LOW: "lowp", uc.PRECISION_MEDIUM: "mediump", uc.PRECISION_HIGH: "highp"}

SCALAR_KIND = {"float": 0, "int": 1, "uint": 2, "bool": 3, "int8_t": 4, "uint8_t": 5, "int16_t": 6, "uint16_t": 7, "float16_t": 8}


def align32(value: int, alignment: int) -> int:
    return (value + alignment - 1) & ~(alignment - 1)


def first_elem_to_compare(array_size: int) -> int:
    return array_size - 20 if array_size > 20 else 0


def byte_size(name: str) -> int:
    return uc.byte_size(name)


def byte_alignment(name: str) -> int:
    return uc.byte_alignment(name)


# ---------------------------------------------------------------------------------------------------------------------
# Interface
# ---------------------------------------------------------------------------------------------------------------------


@dataclass
class BufferVar:
    name: str
    type: VarType
    flags: int
    offset: int = -1


class BufferBlock:
    def __init__(self, name: str):
        self.block_name = name
        self.instance_name = ""
        self.vars: list[BufferVar] = []
        self.array_size = 0
        self.flags = 0
        self.last_unsized = [0]

    @property
    def is_array(self):
        return self.array_size > 0

    def set_array_size(self, size: int):
        self.last_unsized = [0] * (1 if size == 0 else size)
        self.array_size = size

    def add_member(self, var: BufferVar):
        self.vars.append(var)


class Interface:
    def __init__(self):
        self.structs: list[uc.StructType] = []
        self.blocks: list[BufferBlock] = []

    def alloc_struct(self, name: str) -> uc.StructType:
        st = uc.StructType(name)
        self.structs.append(st)
        return st

    def alloc_block(self, name: str) -> BufferBlock:
        block = BufferBlock(name)
        self.blocks.append(block)
        return block

    def uses(self, flag: int) -> bool:
        return any(b.flags & flag for b in self.blocks)


# ---------------------------------------------------------------------------------------------------------------------
# Layout
# ---------------------------------------------------------------------------------------------------------------------


@dataclass
class VarEntry:
    name: str = ""
    type: str = ""
    block_ndx: int = -1
    offset: int = -1
    array_size: int = -1
    array_stride: int = -1
    matrix_stride: int = -1
    top_size: int = -1
    top_stride: int = -1
    row_major: bool = False
    written: bool = False


@dataclass
class BlockEntry:
    name: str = ""
    size: int = 0
    active: list = field(default_factory=list)
    decl_ndx: int = -1
    instance_ndx: int = -1


@dataclass
class Layout:
    blocks: list = field(default_factory=list)
    vars: list = field(default_factory=list)

    def var_index(self, name: str) -> int:
        for ndx, v in enumerate(self.vars):
            if v.name == name:
                return ndx
        return -1

    def block_index(self, name: str) -> int:
        for ndx, b in enumerate(self.blocks):
            if b.name == name:
                return ndx
        return -1


def std140_alignment(t: VarType, flags: int) -> int:
    return uc.std140_base_alignment(t, _uc_flags(flags))


def std430_alignment(t: VarType, flags: int) -> int:
    return uc.std430_base_alignment(t, _uc_flags(flags))


def _uc_flags(flags: int) -> int:
    return uc.LAYOUT_ROW_MAJOR if flags & L_ROW_MAJOR else 0


def relaxed_alignment(t: VarType, flags: int) -> int:
    if t.is_basic:
        dt = TYPES[t.basic]
        if dt.is_vector:
            return byte_alignment(dt.scalar)
        if dt.is_matrix:
            row_major = bool(flags & L_ROW_MAJOR)
            vec_size = dt.cols if row_major else dt.rows
            return byte_alignment(uc.FLOAT_VEC[vec_size])
        return byte_alignment(t.basic)
    if t.is_array:
        return std430_alignment(t.elem, flags)
    return max([0] + [relaxed_alignment(m.type, flags) for m in t.struct.members])


def scalar_alignment(t: VarType, flags: int) -> int:
    return uc.scalar_block_alignment(t, 0)


def base_alignment(t: VarType, flags: int) -> int:
    if flags & L_SCALAR:
        return scalar_alignment(t, flags)
    if flags & L_STD140:
        return std140_alignment(t, flags)
    if flags & L_RELAXED:
        return relaxed_alignment(t, flags)
    return std430_alignment(t, flags)


def merge_layout_flags(prev: int, new: int) -> int:
    packing = L_STD430 | L_STD140 | L_RELAXED | L_SCALAR
    matrix = L_ROW_MAJOR | L_COLUMN_MAJOR
    merged = 0
    merged |= (new if new & packing else prev) & packing
    merged |= (new if new & matrix else prev) & matrix
    return merged


def ref_layout_type(layout: Layout, block_ndx: int, base_offset: int, prefix: str, t: VarType, flags: int) -> int:
    base_align = base_alignment(t, flags)
    cur_offset = align32(base_offset, base_align)

    if t.is_basic:
        dt = TYPES[t.basic]
        entry = VarEntry(name=prefix, type=t.basic, array_size=1, array_stride=0, matrix_stride=0, top_size=1, top_stride=0, block_ndx=block_ndx)
        if dt.is_matrix:
            row_major = bool(flags & L_ROW_MAJOR)
            vec_size = dt.cols if row_major else dt.rows
            vec_type = uc.FLOAT_VEC[vec_size]
            num_vecs = dt.rows if row_major else dt.cols
            vec_stride = byte_size(vec_type) if flags & L_SCALAR else base_align
            entry.offset = cur_offset
            entry.matrix_stride = vec_stride
            entry.row_major = row_major
            cur_offset += num_vecs * vec_stride
        else:
            if (not flags & L_SCALAR) and (flags & L_RELAXED) and dt.is_vector:
                size = byte_size(t.basic)
                straddle = cur_offset // 16 != (cur_offset + size - 1) // 16 if size <= 16 else cur_offset % 16 != 0
                if straddle:
                    cur_offset = align32(cur_offset, 16)
            entry.offset = cur_offset
            cur_offset += byte_size(t.basic)
        layout.vars.append(entry)
    elif t.is_array:
        elem = t.elem
        if elem.is_basic and not TYPES[elem.basic].is_matrix:
            stride = byte_size(elem.basic) if flags & L_SCALAR else base_align
            entry = VarEntry(name=prefix + "[0]", type=elem.basic, block_ndx=block_ndx, offset=cur_offset, array_size=t.size, array_stride=stride, matrix_stride=0, top_size=1, top_stride=0)
            cur_offset += stride * t.size
            layout.vars.append(entry)
        elif elem.is_basic:
            dt = TYPES[elem.basic]
            row_major = bool(flags & L_ROW_MAJOR)
            vec_size = dt.cols if row_major else dt.rows
            vec_type = uc.FLOAT_VEC[vec_size]
            num_vecs = dt.rows if row_major else dt.cols
            vec_stride = byte_size(vec_type) if flags & L_SCALAR else base_align
            entry = VarEntry(name=prefix + "[0]", type=elem.basic, block_ndx=block_ndx, offset=cur_offset, array_size=t.size, array_stride=vec_stride * num_vecs, matrix_stride=vec_stride,
                             row_major=row_major, top_size=1, top_stride=0)
            cur_offset += entry.array_stride * t.size
            layout.vars.append(entry)
        else:
            for elem_ndx in range(t.size):
                cur_offset += ref_layout_type(layout, block_ndx, cur_offset, f"{prefix}[{elem_ndx}]", t.elem, flags)
    else:
        for member in t.struct.members:
            cur_offset += ref_layout_type(layout, block_ndx, cur_offset, prefix + "." + member.name, member.type, flags)
        if not flags & L_SCALAR:
            cur_offset = align32(cur_offset, base_align)

    return cur_offset - base_offset


def ref_layout_var(layout: Layout, block_ndx: int, block_prefix: str, base_offset: int, var: BufferVar, block_flags: int) -> int:
    t = var.type
    combined = merge_layout_flags(block_flags, var.flags)
    if t.is_array:
        top_size = 0 if t.size == UNSIZED else t.size
        prefix = block_prefix + var.name + "[0]"
        is_std140 = bool(block_flags & L_STD140)
        vec4 = 16
        if block_flags & L_SCALAR:
            base_align = scalar_alignment(t, combined)
        elif is_std140:
            base_align = std140_alignment(t, combined)
        elif block_flags & L_RELAXED:
            base_align = relaxed_alignment(t, combined)
        else:
            base_align = std430_alignment(t, combined)
        cur_offset = align32(base_offset, base_align)
        elem = t.elem

        if elem.is_basic and not TYPES[elem.basic].is_matrix:
            elem_align = byte_alignment(elem.basic)
            stride = byte_size(elem.basic) if block_flags & L_SCALAR else (align32(elem_align, vec4) if is_std140 else elem_align)
            layout.vars.append(VarEntry(name=prefix, top_size=1, top_stride=0, type=elem.basic, block_ndx=block_ndx, offset=cur_offset, array_size=top_size, array_stride=stride, matrix_stride=0))
            cur_offset += stride * top_size
        elif elem.is_basic:
            dt = TYPES[elem.basic]
            row_major = bool(combined & L_ROW_MAJOR)
            vec_size = dt.cols if row_major else dt.rows
            num_vecs = dt.rows if row_major else dt.cols
            vec_type = uc.FLOAT_VEC[vec_size]
            vec_align = byte_alignment(vec_type)
            stride = byte_size(vec_type) if block_flags & L_SCALAR else (align32(vec_align, vec4) if is_std140 else vec_align)
            entry = VarEntry(name=prefix, top_size=1, top_stride=0, type=elem.basic, block_ndx=block_ndx, offset=cur_offset, array_size=top_size, array_stride=stride * num_vecs,
                             matrix_stride=stride, row_major=row_major)
            layout.vars.append(entry)
            cur_offset += entry.array_stride * top_size
        else:
            first_child = len(layout.vars)
            size = ref_layout_type(layout, block_ndx, align32(cur_offset, base_align), prefix, t.elem, combined)
            stride = align32(size, base_align)
            for child in layout.vars[first_child:]:
                child.top_size = top_size
                child.top_stride = stride
            if top_size != 0:
                cur_offset += stride * (top_size - 1) + size
        return cur_offset - base_offset
    return ref_layout_type(layout, block_ndx, base_offset, block_prefix + var.name, t, combined)


def compute_reference_layout(interface: Interface) -> Layout:
    layout = Layout()
    for decl_ndx, block in enumerate(interface.blocks):
        block_prefix = block.block_name + "." if block.instance_name else ""
        cur_offset = 0
        active_block_ndx = len(layout.blocks)
        first_var = len(layout.vars)
        old_size = len(layout.vars)
        for var in block.vars:
            cur_offset += ref_layout_var(layout, active_block_ndx, block_prefix, cur_offset, var, block.flags)
            for entry in layout.vars[old_size:]:
                entry.written = bool(var.flags & ACCESS_WRITE)
            if block.flags & L_RELAXED:
                assert len(layout.vars) > old_size
                var.offset = layout.vars[old_size].offset
            old_size = len(layout.vars)
        var_end = len(layout.vars)
        num_instances = block.array_size if block.is_array else 1
        for instance_ndx in range(num_instances):
            entry = BlockEntry(name=block.block_name, size=cur_offset, decl_ndx=decl_ndx, instance_ndx=instance_ndx)
            entry.active = list(range(first_var, var_end))
            if block.is_array:
                entry.name += f"[{instance_ndx}]"
            layout.blocks.append(entry)
    return layout


def is_unsized_entry(entry: VarEntry) -> bool:
    return entry.array_size == 0 or entry.top_size == 0


def has_unsized_array(layout: Layout, block: BlockEntry) -> bool:
    return any(is_unsized_entry(layout.vars[i]) for i in block.active)


def unsized_array_stride(layout: Layout, block: BlockEntry) -> int:
    for i in block.active:
        entry = layout.vars[i]
        if entry.array_size == 0:
            return entry.array_stride
        if entry.top_size == 0:
            return entry.top_stride
    return 0


def compute_buffer_sizes(interface: Interface, layout: Layout) -> list:
    sizes = [0] * len(layout.blocks)
    for block in interface.blocks:
        num_instances = block.array_size if block.is_array else 1
        for instance_ndx in range(num_instances):
            api_name = block.block_name + (f"[{instance_ndx}]" if block.is_array else "")
            block_ndx = layout.block_index(api_name)
            if block_ndx >= 0:
                entry = layout.blocks[block_ndx]
                unsized = has_unsized_array(layout, entry)
                last = block.last_unsized[instance_ndx] if unsized else 0
                stride = unsized_array_stride(layout, entry) if unsized else 0
                sizes[block_ndx] = entry.size + last * stride
    return sizes


# ---------------------------------------------------------------------------------------------------------------------
# Reference data
# ---------------------------------------------------------------------------------------------------------------------


class Rnd(uc.Rnd):
    pass


FMT = {"float": "<f", "int": "<i", "uint": "<I", "bool": "<I", "int8_t": "<b", "uint8_t": "<B", "int16_t": "<h", "uint16_t": "<H", "float16_t": "<H"}
COMP_BYTES = {"float": 4, "int": 4, "uint": 4, "bool": 4, "int8_t": 1, "uint8_t": 1, "int16_t": 2, "uint16_t": 2, "float16_t": 2}


def f16_bits(value: float) -> int:
    return struct.unpack("<H", struct.pack("<e", value))[0]


def generate_value(entry: VarEntry, unsized: int, data: bytearray, rnd: Rnd) -> None:
    dt = TYPES[entry.type]
    scalar = dt.scalar
    scalar_size = dt.size
    array_size = unsized if entry.array_size == 0 else entry.array_size
    top_size = unsized if entry.top_size == 0 else entry.top_size
    is_matrix = dt.is_matrix
    num_vecs = (dt.rows if entry.row_major else dt.cols) if is_matrix else 1
    vec_size = scalar_size // num_vecs
    comp = COMP_BYTES[scalar]
    for top in range(top_size):
        top_off = entry.offset + top * entry.top_stride
        for elem in range(first_elem_to_compare(array_size), array_size):
            elem_off = top_off + elem * entry.array_stride
            for vec in range(num_vecs):
                vec_off = elem_off + (vec * entry.matrix_stride if is_matrix else 0)
                for c in range(vec_size):
                    off = vec_off + comp * c
                    if scalar == "float":
                        value = float(rnd.get_int(-9, 9))
                    elif scalar in ("int", "int8_t", "int16_t"):
                        value = rnd.get_int(-9, 9)
                    elif scalar in ("uint", "uint8_t", "uint16_t"):
                        value = rnd.get_int(0, 9)
                    elif scalar == "float16_t":
                        value = f16_bits(float(rnd.get_int(-9, 9)))
                    else:
                        value = (rnd.get_uint32() | 1) if rnd.get_bool() else 0
                    struct.pack_into(FMT[scalar], data, off, value)


def generate_values(layout: Layout, datas: list, unsized: list, seed: int) -> None:
    rnd = Rnd(seed)
    for block_ndx, block in enumerate(layout.blocks):
        for var_ndx in block.active:
            generate_value(layout.vars[var_ndx], unsized[block_ndx], datas[block_ndx], rnd)


def copy_var_data(entry: VarEntry, dst: bytearray, src: bytearray, unsized: int) -> None:
    dt = TYPES[entry.type]
    comp = COMP_BYTES[dt.scalar]
    array_size = unsized if entry.array_size == 0 else entry.array_size
    top_size = unsized if entry.top_size == 0 else entry.top_size
    for top in range(top_size):
        top_off = entry.offset + top * entry.top_stride
        for elem in range(first_elem_to_compare(array_size), array_size):
            elem_off = top_off + elem * entry.array_stride
            if dt.is_matrix:
                for col in range(dt.cols):
                    for row in range(dt.rows):
                        off = elem_off + (row * entry.matrix_stride + col * comp if entry.row_major else col * entry.matrix_stride + row * comp)
                        dst[off:off + comp] = src[off:off + comp]
            else:
                dst[elem_off:elem_off + dt.size * comp] = src[elem_off:elem_off + dt.size * comp]


def copy_non_written(layout: Layout, src: list, dst: list, unsized: list) -> None:
    for block_ndx, block in enumerate(layout.blocks):
        for var_ndx in block.active:
            entry = layout.vars[var_ndx]
            if not entry.written:
                copy_var_data(entry, dst[block_ndx], src[block_ndx], unsized[block_ndx])


# ---------------------------------------------------------------------------------------------------------------------
# Shader
# ---------------------------------------------------------------------------------------------------------------------

COMPARE_BOOL = {}
for _name, _src in uc.COMPARE_FUNCS.items():
    _s = _src.replace("mediump float compare", "bool compare", 1).replace(" ? 1.0 : 0.0", "").replace(")*compare_", ")&&compare_")
    COMPARE_BOOL[_name] = _s


def generate_compare_funcs(interface: Interface) -> str:
    types: set = set()
    for block in interface.blocks:
        for var in block.vars:
            uc.collect_basic_types(types, var.type)
    funcs: set = set()
    for name in types:
        uc.compare_dependencies(funcs, name)
    return "".join(COMPARE_BOOL[name] for name in uc.ENUM_ORDER if name in funcs)


def layout_flags_fmt(flags: int) -> str:
    bits = [(L_STD140, "std140"), (L_STD430, "std430"), (L_SCALAR, "scalar"), (L_ROW_MAJOR, "row_major"), (L_COLUMN_MAJOR, "column_major")]
    return ", ".join(token for bit, token in bits if flags & bit)


def declare_var(t: VarType, name: str, indent_level: int) -> str:
    sizes = []
    cur = t
    while cur.is_array:
        sizes.append(cur.size)
        cur = cur.elem
    out = ""
    if cur.is_basic:
        prec = PREC_NAMES[cur.flags & uc.PRECISION_MASK]
        if prec:
            out += prec + " "
        out += cur.basic
    else:
        out += cur.struct.name
    out += " " + name
    for size in sizes:
        out += "[]" if size == UNSIZED else f"[{size}]"
    return out


def declare_struct(st: uc.StructType) -> str:
    out = f"struct {st.name}\n{{\n"
    for m in st.members:
        out += f"\t{declare_var(m.type, m.name, 1)};\n"
    return out + "}"


def generate_var_declaration(var: BufferVar) -> str:
    out = ""
    if var.flags & L_MASK:
        out += "layout(" + layout_flags_fmt(var.flags & L_MASK) + ") "
    elif var.offset != -1:
        out += f"layout(offset = {var.offset}) "
    return out + declare_var(var.type, var.name, 1)


def generate_block_declaration(block: BufferBlock, binding: int, phys: bool) -> str:
    out = "layout("
    if block.flags & L_MASK:
        out += layout_flags_fmt(block.flags & L_MASK) + ", "
    out += "buffer_reference" if phys else f"binding = {binding}"
    out += ") "
    if not any(v.flags & ACCESS_WRITE for v in block.vars):
        out += "readonly "
    out += "buffer " + block.block_name + "\n{\n"
    for var in block.vars:
        out += "\t" + generate_var_declaration(var) + ";\n"
    out += "}"
    if not phys:
        if block.instance_name:
            out += " " + block.instance_name
            if block.flags & L_DESCRIPTOR_INDEXING:
                out += "[]"
            elif block.is_array:
                out += f"[{block.array_size}]"
        else:
            assert not block.is_array
    return out + ";\n"


def float_str(value: float) -> str:
    return f"{value:.1f}"


def read_scalar(scalar: str, data: bytes, off: int):
    return struct.unpack_from(FMT[scalar], data, off)[0]


def imm_matrix_full(basic_type: str, matrix_stride: int, row_major: bool, single_col: bool, col_number: int, data: bytes, off: int) -> str:
    dt = TYPES[basic_type]
    name = uc.FLOAT_VEC[dt.rows] if single_col else basic_type
    out = name + "("
    first = True
    for col in range(dt.cols):
        if single_col and col != col_number:
            continue
        for row in range(dt.rows):
            pos = off + (row * matrix_stride + col * 4 if row_major else col * matrix_stride + row * 4)
            if not first:
                out += ", "
            out += float_str(read_scalar("float", data, pos))
            first = False
    return out + ")"


def imm_matrix_components(basic_type: str, matrix_stride: int, row_major: bool, data: bytes, off: int, result_var: str, shader_name: str) -> str:
    dt = TYPES[basic_type]
    out = ""
    for col in range(dt.cols):
        for row in range(dt.rows):
            pos = off + (row * matrix_stride + col * 4 if row_major else col * matrix_stride + row * 4)
            out += f"\t{result_var} = compare_float({shader_name}[{col}][{row}], {float_str(read_scalar('float', data, pos))}) && {result_var};\n"
    for col in range(dt.cols):
        vals = []
        for row in range(dt.rows):
            pos = off + (row * matrix_stride + col * 4 if row_major else col * matrix_stride + row * 4)
            vals.append(float_str(read_scalar("float", data, pos)))
        out += f"\t{result_var} = compare_vec{dt.rows}({shader_name}[{col}], vec{dt.rows}({', '.join(vals)})) && {result_var};\n"
    return out


def imm_scalar_vector(basic_type: str, data: bytes, off: int) -> str:
    dt = TYPES[basic_type]
    scalar = dt.scalar
    comp = COMP_BYTES[scalar]
    out = ""
    if dt.size > 1:
        out += uc.PROMOTE.get(basic_type, basic_type) + "("
    for n in range(dt.size):
        pos = off + n * comp
        if n > 0:
            out += ", "
        if scalar == "float16_t":
            out += float_str(struct.unpack("<e", struct.pack("<H", read_scalar(scalar, data, pos)))[0])
        elif scalar == "float":
            out += float_str(read_scalar(scalar, data, pos))
        elif scalar == "int8_t":
            out += str(read_scalar(scalar, data, pos) & MASK32)
        elif scalar in ("int16_t", "int"):
            out += str(read_scalar(scalar, data, pos))
        elif scalar in ("uint8_t", "uint16_t", "uint"):
            out += str(read_scalar(scalar, data, pos)) + "u"
        else:
            out += "true" if read_scalar(scalar, data, pos) != 0 else "false"
    if dt.size > 1:
        out += ")"
    return out


def api_name(block: BufferBlock, var: BufferVar, path: list) -> str:
    name = ""
    if block.instance_name:
        name += block.block_name + "."
    name += var.name
    cur = var.type
    for i, (kind, index) in enumerate(path):
        if kind == "m":
            name += "." + cur.struct.members[index].name
            cur = cur.struct.members[index].type
        else:
            name += "[0]" if i == 0 or i + 1 == len(path) else f"[{index}]"
            cur = cur.elem
    return name


def shader_name(block: BufferBlock, instance_ndx: int, var: BufferVar, path: list) -> str:
    name = ""
    if block.instance_name:
        name += block.instance_name
        if block.flags & L_DESCRIPTOR_INDEXING:
            name += f"[nonuniformEXT({instance_ndx})]"
        elif block.is_array:
            name += f"[{instance_ndx}]"
        name += "."
    else:
        assert instance_ndx == 0
    name += var.name
    cur = var.type
    for kind, index in path:
        if kind == "m":
            name += "." + cur.struct.members[index].name
            cur = cur.struct.members[index].type
        else:
            name += f"[{index}]"
            cur = cur.elem
    return name


def compute_offset(entry: VarEntry, path: list) -> int:
    top = path[0][1] if len(path) > 1 and path[0][0] == "e" else 0
    bottom = path[-1][1] if path and path[-1][0] == "e" else 0
    return entry.offset + entry.top_stride * top + entry.array_stride * bottom


class Gen:
    def __init__(self, interface: Interface, layout: Layout, compare_data: list, write_data: list, unsized: list):
        self.interface = interface
        self.layout = layout
        self.compare_data = compare_data
        self.write_data = write_data
        self.unsized = unsized
        self.compare_limit = 130

    def array_len(self, t: VarType, block: BufferBlock, instance_ndx: int) -> int:
        return block.last_unsized[instance_ndx] if t.size == UNSIZED else t.size

    def walk_compare(self, res: str, block, instance_ndx, block_ndx, var, t: VarType, path: list, matrix_load: int) -> str:
        if self.compare_limit < 1:
            return ""
        if t.is_array:
            n = self.array_len(t, block, instance_ndx)
            return "".join(self.walk_compare(res, block, instance_ndx, block_ndx, var, t.elem, path + [("e", e)], LOAD_FULL_MATRIX) for e in range(first_elem_to_compare(n), n))
        if t.is_struct:
            return "".join(self.walk_compare(res, block, instance_ndx, block_ndx, var, m.type, path + [("m", i)], LOAD_FULL_MATRIX) for i, m in enumerate(t.struct.members))
        self.compare_limit -= 1
        entry = self.layout.vars[self.layout.var_index(api_name(block, var, path))]
        sname = shader_name(block, instance_ndx, var, path)
        data = self.compare_data[block_ndx]
        off = compute_offset(entry, path)
        dt = TYPES[t.basic]
        if dt.is_matrix:
            if matrix_load == LOAD_MATRIX_COMPONENTS:
                return imm_matrix_components(t.basic, entry.matrix_stride, entry.row_major, data, off, res, sname)
            return f"\t{res} = compare_{t.basic}({sname}, {imm_matrix_full(t.basic, entry.matrix_stride, entry.row_major, False, -1, data, off)}) && {res};\n"
        promote = uc.PROMOTE.get(t.basic, t.basic)
        cast = promote if promote != t.basic else ""
        return f"\t{res} = compare_{t.basic}({cast}({sname}), {imm_scalar_vector(t.basic, data, off)}) && {res};\n"

    def walk_write(self, block, instance_ndx, block_ndx, var, t: VarType, path: list, store: int) -> str:
        if t.is_array:
            n = self.array_len(t, block, instance_ndx)
            return "".join(self.walk_write(block, instance_ndx, block_ndx, var, t.elem, path + [("e", e)], store) for e in range(first_elem_to_compare(n), n))
        if t.is_struct:
            return "".join(self.walk_write(block, instance_ndx, block_ndx, var, m.type, path + [("m", i)], store) for i, m in enumerate(t.struct.members))
        entry = self.layout.vars[self.layout.var_index(api_name(block, var, path))]
        sname = shader_name(block, instance_ndx, var, path)
        data = self.write_data[block_ndx]
        off = compute_offset(entry, path)
        dt = TYPES[t.basic]
        is_matrix = dt.is_matrix
        promote = uc.PROMOTE.get(t.basic, t.basic)
        cast = ""
        if promote != t.basic:
            cast = t.basic if (not is_matrix or store == STORE_FULL_MATRIX) else uc.FLOAT_VEC[dt.rows]
        if is_matrix:
            if store == STORE_FULL_MATRIX:
                return f"\t{sname} = {cast}({imm_matrix_full(t.basic, entry.matrix_stride, entry.row_major, False, -1, data, off)});\n"
            out = ""
            for col in range(dt.cols):
                out += f"\t{sname}[{col}] = {cast}({imm_matrix_full(t.basic, entry.matrix_stride, entry.row_major, True, col, data, off)});\n"
            return out
        return f"\t{sname} = {cast}({imm_scalar_vector(t.basic, data, off)});\n"

    def instances(self):
        for decl_ndx, block in enumerate(self.interface.blocks):
            num_instances = block.array_size if block.is_array else 1
            for instance_ndx in range(num_instances):
                name = block.block_name + (f"[{instance_ndx}]" if block.is_array else "")
                yield block, instance_ndx, self.layout.block_index(name)

    def compare_src(self, res: str, matrix_load: int) -> str:
        out = ""
        for block, instance_ndx, block_ndx in self.instances():
            for var in block.vars:
                if not var.flags & ACCESS_READ:
                    continue
                out += self.walk_compare(res, block, instance_ndx, block_ndx, var, var.type, [], matrix_load)
        return out

    def write_src(self, store: int) -> str:
        out = ""
        for block, instance_ndx, block_ndx in self.instances():
            for var in block.vars:
                if not var.flags & ACCESS_WRITE:
                    continue
                out += self.walk_write(block, instance_ndx, block_ndx, var, var.type, [], store)
        return out


def generate_compute_shader(interface: Interface, layout: Layout, compare_data: list, write_data: list, unsized: list, matrix_load: int, store: int, phys: bool) -> str:
    gen = Gen(interface, layout, compare_data, write_data, unsized)
    src = "#version 450\n"
    src += "#extension GL_EXT_shader_16bit_storage : enable\n"
    src += "#extension GL_EXT_shader_8bit_storage : enable\n"
    src += "#extension GL_EXT_scalar_block_layout : enable\n"
    src += "#extension GL_EXT_buffer_reference : enable\n"
    src += "#extension GL_EXT_nonuniform_qualifier : enable\n"
    src += "#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable\n"
    src += "#extension GL_EXT_shader_64bit_indexing : enable\n"
    src += "layout(local_size_x = 1) in;\n"
    src += "\n"
    src += "layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };\n\n"
    for st in interface.structs:
        src += declare_struct(st) + ";\n"
    for block_ndx, block in enumerate(interface.blocks):
        src += generate_block_declaration(block, 1 + block_ndx, phys)
    if phys:
        src += "layout (push_constant, std430) uniform PC {\n"
        for block in interface.blocks:
            if block.instance_name:
                src += f"    {block.block_name} {block.instance_name}"
                if block.is_array:
                    src += f"[{block.array_size}]"
                src += ";\n"
        src += "};\n"
    src += "\n"
    src += generate_compare_funcs(interface)
    src += "\nvoid main (void)\n{\n    bool allOk = true;\n"
    src += gen.compare_src("allOk", matrix_load)
    src += "    if (allOk)\n        ac_numPassed++;\n\n"
    src += gen.write_src(store)
    src += "}\n"
    return src


# ---------------------------------------------------------------------------------------------------------------------
# Case
# ---------------------------------------------------------------------------------------------------------------------


class Case:
    def __init__(self, path: list, buffer_mode: int, matrix_load: int, matrix_store: int, phys: bool, big: bool = False):
        self.path = path
        self.buffer_mode = buffer_mode
        self.matrix_load = matrix_load
        self.matrix_store = matrix_store
        self.phys = phys
        self.big = big
        self.interface = Interface()
        self.layout = None
        self.program = None
        self.unsized_sizes: list = []
        self.sizes: list = []
        self.deferred = None

    @property
    def name(self) -> str:
        return self.path[-1]

    def delayed_init(self):
        if self.big:
            return
        self.layout = compute_reference_layout(self.interface)
        self.sizes = compute_buffer_sizes(self.interface, self.layout)
        self.unsized_sizes = []
        for block_ndx, entry in enumerate(self.layout.blocks):
            block = self.interface.blocks[entry.decl_ndx]
            if has_unsized_array(self.layout, entry):
                self.unsized_sizes.append(block.last_unsized[entry.instance_ndx])
            else:
                self.unsized_sizes.append(0)
        seed = de_random.de_string_hash(self.name)
        init = [bytearray(s) for s in self.sizes]
        write = [bytearray(s) for s in self.sizes]
        generate_values(self.layout, init, self.unsized_sizes, seed ^ 0xAD2F7214)
        generate_values(self.layout, write, self.unsized_sizes, seed ^ 0x25CA4E7)
        copy_non_written(self.layout, init, write, self.unsized_sizes)
        self.program = generate_compute_shader(self.interface, self.layout, init, write, self.unsized_sizes, self.matrix_load, self.matrix_store, self.phys)

    def uses(self, flag: int) -> bool:
        return self.interface.uses(flag)


def type_flags(type_: VarType, layout_flags: int) -> int:
    t = type_
    while t.is_array:
        t = t.elem
    scalar = TYPES[t.basic].scalar
    if scalar in ("uint16_t", "int16_t", "float16_t"):
        layout_flags |= L_16BIT
    if scalar in ("uint8_t", "int8_t"):
        layout_flags |= L_8BIT
    return layout_flags


def inner_basic(type_: VarType) -> str:
    t = type_
    while t.is_array:
        t = t.elem
    return t.basic


def prec_flags(name: str) -> int:
    return uc.PRECISION_HIGH if uc.supports_precision(name) else 0


def block_basic_type_case(path, type_: VarType, layout_flags: int, num_instances: int, load: int, store: int, phys: bool, readonly: bool) -> Case:
    case = Case(path, BUFFERMODE_PER_BLOCK, load, store, phys)
    layout_flags = type_flags(type_, layout_flags)
    block = case.interface.alloc_block("Block")
    access = ACCESS_READ | (0 if readonly else ACCESS_WRITE)
    if (layout_flags & L_SCALAR) and not (type_.is_basic and TYPES[type_.basic].is_scalar):
        block.add_member(BufferVar("padding", basic(TYPES[inner_basic(type_)].scalar), access))
    block.add_member(BufferVar("var", type_, access))
    block.flags = layout_flags
    if phys or num_instances > 0:
        block.set_array_size(num_instances)
        block.instance_name = "block"
    return case


def block_basic_unsized_array_case(path, element_type: VarType, array_size: int, layout_flags: int, load: int, store: int, phys: bool, readonly: bool) -> Case:
    case = Case(path, BUFFERMODE_PER_BLOCK, load, store, phys)
    block = case.interface.alloc_block("Block")
    block.add_member(BufferVar("var", array(element_type, UNSIZED), ACCESS_READ | (0 if readonly else ACCESS_WRITE)))
    block.flags = type_flags(element_type, layout_flags)
    block.last_unsized[0] = array_size
    if phys:
        block.instance_name = "block"
    return case


def _finish_block(block: BufferBlock, flags: int, num_instances: int, phys: bool) -> None:
    block.flags = flags
    if phys or num_instances > 0:
        block.instance_name = "block"
        block.set_array_size(num_instances)


def _prec(name: str, prec: int) -> VarType:
    return basic(name, prec)


H = uc.PRECISION_HIGH
M = uc.PRECISION_MEDIUM
LO = uc.PRECISION_LOW


def single_struct_case(path, flags, mode, num_instances, load, store, phys, readonly) -> Case:
    case = Case(path, mode, load, store, phys)
    s = case.interface.alloc_struct("S")
    s.add_member("a", _prec("ivec3", H))
    s.add_member("b", array(_prec("mat3", M), 4))
    s.add_member("c", _prec("vec4", H))
    block = case.interface.alloc_block("Block")
    block.add_member(BufferVar("s", struct_type(s), ACCESS_READ | (0 if readonly else ACCESS_WRITE)))
    _finish_block(block, flags, num_instances, phys)
    return case


def single_struct_array_case(path, flags, mode, num_instances, load, store, phys) -> Case:
    case = Case(path, mode, load, store, phys)
    s = case.interface.alloc_struct("S")
    s.add_member("a", _prec("ivec3", H))
    s.add_member("b", array(_prec("mat3", M), 4))
    s.add_member("c", _prec("vec4", H))
    block = case.interface.alloc_block("Block")
    block.add_member(BufferVar("u", _prec("uint", LO), 0))
    block.add_member(BufferVar("s", array(struct_type(s), 3), ACCESS_READ | ACCESS_WRITE))
    block.add_member(BufferVar("v", _prec("vec4", M), ACCESS_WRITE))
    _finish_block(block, flags, num_instances, phys)
    return case


def single_nested_struct_case(path, flags, mode, num_instances, load, store, phys) -> Case:
    case = Case(path, mode, load, store, phys)
    s = case.interface.alloc_struct("S")
    s.add_member("a", _prec("ivec3", H))
    s.add_member("b", array(_prec("mat3", M), 4))
    s.add_member("c", _prec("vec4", H))
    t = case.interface.alloc_struct("T")
    t.add_member("a", _prec("mat3", M))
    t.add_member("b", struct_type(s))
    block = case.interface.alloc_block("Block")
    block.add_member(BufferVar("s", struct_type(s), ACCESS_READ))
    block.add_member(BufferVar("v", _prec("vec2", LO), 0))
    block.add_member(BufferVar("t", struct_type(t), ACCESS_READ | ACCESS_WRITE))
    block.add_member(BufferVar("u", _prec("uint", H), ACCESS_WRITE))
    _finish_block(block, flags, num_instances, phys)
    return case


def single_nested_struct_array_case(path, flags, mode, num_instances, load, store, phys) -> Case:
    case = Case(path, mode, load, store, phys)
    s = case.interface.alloc_struct("S")
    s.add_member("a", _prec("ivec3", H))
    s.add_member("b", array(_prec("ivec2", M), 4))
    s.add_member("c", _prec("vec4", H))
    t = case.interface.alloc_struct("T")
    t.add_member("a", _prec("mat3", M))
    t.add_member("b", array(struct_type(s), 3))
    block = case.interface.alloc_block("Block")
    block.add_member(BufferVar("s", struct_type(s), ACCESS_WRITE))
    block.add_member(BufferVar("v", _prec("vec2", LO), 0))
    block.add_member(BufferVar("t", array(struct_type(t), 2), ACCESS_READ))
    block.add_member(BufferVar("u", _prec("uint", H), ACCESS_READ | ACCESS_WRITE))
    _finish_block(block, flags, num_instances, phys)
    return case


def _unsized_lengths(block: BufferBlock, num_instances: int, seed: int) -> None:
    rnd = Rnd(seed)
    for ndx in range(num_instances if num_instances else 1):
        block.last_unsized[ndx] = rnd.get_int(1, 5)


def unsized_struct_array_case(path, flags, mode, num_instances, load, store, phys) -> Case:
    case = Case(path, mode, load, store, phys)
    s = case.interface.alloc_struct("S")
    s.add_member("a", _prec("uvec2", H))
    s.add_member("b", array(_prec("mat2x4", M), 4))
    s.add_member("c", _prec("vec3", H))
    block = case.interface.alloc_block("Block")
    block.add_member(BufferVar("u", _prec("vec2", LO), 0))
    block.add_member(BufferVar("v", _prec("uint", M), ACCESS_WRITE))
    block.add_member(BufferVar("s", array(struct_type(s), UNSIZED), ACCESS_READ | ACCESS_WRITE))
    _finish_block(block, flags, num_instances, phys)
    _unsized_lengths(block, num_instances, 246)
    return case


def two_level_unsized_struct_array_case(path, flags, mode, num_instances, load, store, phys) -> Case:
    case = Case(path, mode, load, store, phys)
    s = case.interface.alloc_struct("S")
    s.add_member("a", _prec("ivec3", H))
    s.add_member("c", _prec("vec4", H))
    block = case.interface.alloc_block("Block")
    block.add_member(BufferVar("u", _prec("uint", LO), 0))
    block.add_member(BufferVar("v", _prec("vec4", M), ACCESS_WRITE))
    block.add_member(BufferVar("s", array(array(struct_type(s), 2), UNSIZED), ACCESS_READ | ACCESS_WRITE))
    _finish_block(block, flags, num_instances, phys)
    _unsized_lengths(block, num_instances, 2344)
    return case


def unsized_nested_struct_array_case(path, flags, mode, num_instances, load, store, phys) -> Case:
    case = Case(path, mode, load, store, phys)
    s = case.interface.alloc_struct("S")
    s.add_member("a", _prec("uvec3", H))
    s.add_member("b", array(_prec("vec2", M), 4))
    s.add_member("c", _prec("vec4", H))
    t = case.interface.alloc_struct("T")
    t.add_member("a", _prec("mat4x3", M))
    t.add_member("b", array(struct_type(s), 3))
    t.add_member("c", _prec("int", H))
    block = case.interface.alloc_block("Block")
    block.add_member(BufferVar("s", struct_type(s), ACCESS_WRITE))
    block.add_member(BufferVar("v", _prec("vec2", LO), 0))
    block.add_member(BufferVar("u", _prec("uint", H), ACCESS_READ | ACCESS_WRITE))
    block.add_member(BufferVar("t", array(struct_type(t), UNSIZED), ACCESS_READ))
    _finish_block(block, flags, num_instances, phys)
    _unsized_lengths(block, num_instances, 7921)
    return case


def multi_basic_types_case(path, flags_a, flags_b, mode, num_instances, load, store, phys) -> Case:
    case = Case(path, mode, load, store, phys)
    a = case.interface.alloc_block("BlockA")
    a.add_member(BufferVar("a", _prec("float", H), ACCESS_READ | ACCESS_WRITE))
    a.add_member(BufferVar("b", _prec("uvec3", LO), 0))
    a.add_member(BufferVar("c", _prec("mat2", M), ACCESS_READ))
    a.instance_name = "blockA"
    a.flags = flags_a
    b = case.interface.alloc_block("BlockB")
    b.add_member(BufferVar("a", _prec("mat3", M), ACCESS_WRITE))
    b.add_member(BufferVar("b", _prec("ivec2", LO), ACCESS_READ))
    b.add_member(BufferVar("c", _prec("vec4", H), 0))
    b.add_member(BufferVar("d", basic("bool"), ACCESS_READ | ACCESS_WRITE))
    b.instance_name = "blockB"
    b.flags = flags_b
    if num_instances > 0:
        a.set_array_size(num_instances)
        b.set_array_size(num_instances)
    return case


def multi_nested_struct_case(path, flags_a, flags_b, mode, num_instances, load, store, phys) -> Case:
    case = Case(path, mode, load, store, phys)
    s = case.interface.alloc_struct("S")
    s.add_member("a", _prec("mat3", LO))
    s.add_member("b", array(_prec("ivec2", M), 4))
    s.add_member("c", _prec("vec4", H))
    t = case.interface.alloc_struct("T")
    t.add_member("a", _prec("uint", M))
    t.add_member("b", struct_type(s))
    t.add_member("c", basic("bvec4"))
    a = case.interface.alloc_block("BlockA")
    a.add_member(BufferVar("a", _prec("float", H), ACCESS_READ | ACCESS_WRITE))
    a.add_member(BufferVar("b", struct_type(s), ACCESS_WRITE))
    a.add_member(BufferVar("c", _prec("uvec3", LO), 0))
    a.instance_name = "blockA"
    a.flags = flags_a
    b = case.interface.alloc_block("BlockB")
    b.add_member(BufferVar("a", _prec("mat2", M), ACCESS_WRITE))
    b.add_member(BufferVar("b", struct_type(t), ACCESS_READ | ACCESS_WRITE))
    b.add_member(BufferVar("c", basic("bvec4"), 0))
    b.add_member(BufferVar("d", basic("bool"), ACCESS_READ | ACCESS_WRITE))
    b.instance_name = "blockB"
    b.flags = flags_b
    if num_instances > 0:
        a.set_array_size(num_instances)
        b.set_array_size(num_instances)
    return case


# ---------------------------------------------------------------------------------------------------------------------
# Random cases
# ---------------------------------------------------------------------------------------------------------------------

F32 = de_random.to_f32


def gen_name(first: str, last: str, ndx: int) -> str:
    return uc.gen_name(first, last, ndx)


class RandomCase(Case):
    def __init__(self, path, mode, features: int, seed: int, phys: bool):
        super().__init__(path, mode, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, big=bool(features & FEATURE_64B))
        self.features = features
        self.max_blocks = 1 if features & (FEATURE_DESCRIPTOR_INDEXING | FEATURE_64B) else 4
        self.max_instances = 3 if features & FEATURE_INSTANCE_ARRAYS else 0
        self.max_array_length = 8 if features & FEATURE_ARRAYS else 1
        self.max_array_depth = 2 if features & FEATURE_ARRAYS_OF_ARRAYS else 0
        self.max_struct_depth = 2 if features & FEATURE_STRUCTS else 0
        self.max_block_members = 5
        self.max_struct_members = 4
        self.block_ndx = 1
        self.var_ndx = 1
        self.struct_ndx = 1
        if self.big:
            return
        rnd = Rnd(seed)
        num_blocks = rnd.get_int(1, self.max_blocks)
        for _ in range(num_blocks):
            self.generate_block(rnd, 0)

    def generate_block(self, rnd: Rnd, layout_flags: int) -> None:
        instance_weight = F32(0.3)
        block = self.interface.alloc_block("Block" + chr(ord("A") + self.block_ndx))
        num_instances = 0
        if self.max_instances > 0 and rnd.get_float() < instance_weight:
            num_instances = rnd.get_int(0, self.max_instances)
        num_vars = rnd.get_int(1, self.max_block_members)
        if self.features & FEATURE_DESCRIPTOR_INDEXING:
            num_instances = rnd.get_int(2, 4)
        if num_instances > 0:
            block.set_array_size(num_instances)
        if self.phys or num_instances > 0 or rnd.get_bool():
            block.instance_name = "block" + chr(ord("A") + self.block_ndx)
        candidates = []
        if self.features & FEATURE_STD430_LAYOUT:
            candidates.append(L_STD430)
        if self.features & FEATURE_STD140_LAYOUT:
            candidates.append(L_STD140)
        if self.features & FEATURE_RELAXED_LAYOUT:
            candidates.append(L_RELAXED)
        if self.features & FEATURE_SCALAR_LAYOUT:
            candidates.append(L_SCALAR)
        if self.features & FEATURE_16BIT_STORAGE:
            layout_flags |= L_16BIT
        if self.features & FEATURE_8BIT_STORAGE:
            layout_flags |= L_8BIT
        if self.features & FEATURE_DESCRIPTOR_INDEXING:
            layout_flags |= L_DESCRIPTOR_INDEXING
        layout_flags |= rnd.choose(candidates)
        if self.features & FEATURE_MATRIX_LAYOUT:
            layout_flags |= rnd.choose([0, L_ROW_MAJOR, L_COLUMN_MAJOR])
        block.flags = layout_flags
        for ndx in range(num_vars):
            self.generate_buffer_var(rnd, block, ndx + 1 == num_vars)
        if num_vars > 0:
            last_type = block.vars[-1].type
            if last_type.is_array and last_type.size == UNSIZED:
                for instance_ndx in range(num_instances if num_instances else 1):
                    block.last_unsized[instance_ndx] = rnd.get_int(1, self.max_array_length)
        self.block_ndx += 1

    def generate_buffer_var(self, rnd: Rnd, block: BufferBlock, is_last: bool) -> None:
        read_weight = F32(0.7)
        write_weight = F32(0.7)
        access_weight = F32(0.85)
        unused_ok = bool(self.features & FEATURE_UNUSED_VARS)
        name = gen_name("a", "z", self.var_ndx)
        type_ = self.generate_type(rnd, 0, 0, True, is_last and bool(self.features & FEATURE_UNSIZED_ARRAYS))
        access = (not unused_ok) or (rnd.get_float() < access_weight)
        read = (rnd.get_float() < read_weight) if access else False
        write = ((not read) or (rnd.get_float() < write_weight)) if access else False
        flags = (ACCESS_READ if read else 0) | (ACCESS_WRITE if write else 0)
        block.add_member(BufferVar(name, type_, flags))
        self.var_ndx += 1

    def generate_type(self, rnd: Rnd, struct_depth: int, array_depth: int, array_ok: bool, unsized_ok: bool) -> VarType:
        struct_weight = F32(0.1)
        array_weight = F32(0.1)
        unsized_weight = F32(0.8)
        if unsized_ok and rnd.get_float() < unsized_weight:
            child_ok = bool(self.features & FEATURE_ARRAYS_OF_ARRAYS) and array_depth < self.max_array_depth
            elem = self.generate_type(rnd, struct_depth, array_depth + 1, child_ok, False)
            return array(elem, UNSIZED)
        if struct_depth < self.max_struct_depth and rnd.get_float() < struct_weight:
            member_types = []
            num_members = rnd.get_int(1, self.max_struct_members)
            for _ in range(num_members):
                member_types.append(self.generate_type(rnd, struct_depth + 1, array_depth, array_depth < self.max_array_depth, False))
            st = self.interface.alloc_struct("s" + gen_name("A", "Z", self.struct_ndx))
            self.struct_ndx += 1
            for ndx in range(num_members):
                st.add_member("m" + chr(ord("A") + ndx), member_types[ndx])
            return struct_type(st)
        if self.max_array_length > 0 and array_ok and rnd.get_float() < array_weight:
            length = rnd.get_int(1, self.max_array_length)
            child_ok = bool(self.features & FEATURE_ARRAYS_OF_ARRAYS) and array_depth < self.max_array_depth
            elem = self.generate_type(rnd, struct_depth, array_depth + 1, child_ok, False)
            return array(elem, length)
        names = ["float", "int", "uint", "bool"]
        if self.features & FEATURE_16BIT_STORAGE:
            names += ["uint16_t", "int16_t", "float16_t"]
        if self.features & FEATURE_8BIT_STORAGE:
            names += ["uint8_t", "int8_t"]
        if self.features & FEATURE_VECTORS:
            names += ["vec2", "vec3", "vec4", "ivec2", "ivec3", "ivec4", "uvec2", "uvec3", "uvec4", "bvec2", "bvec3", "bvec4"]
            if self.features & FEATURE_16BIT_STORAGE:
                names += ["f16vec2", "f16vec3", "f16vec4", "i16vec2", "i16vec3", "i16vec4", "u16vec2", "u16vec3", "u16vec4"]
            if self.features & FEATURE_8BIT_STORAGE:
                names += ["i8vec2", "i8vec3", "i8vec4", "u8vec2", "u8vec3", "u8vec4"]
        if self.features & FEATURE_MATRICES:
            names += ["mat2", "mat2x3", "mat3x2", "mat3", "mat3x4", "mat4x2", "mat4x3", "mat4"]
        name = rnd.choose(names)
        if uc.supports_precision(name):
            prec = rnd.choose([LO, M, H])
        else:
            prec = 0
        return basic(name, prec)


# ---------------------------------------------------------------------------------------------------------------------
# Tree
# ---------------------------------------------------------------------------------------------------------------------

BASIC_TYPES = ["float", "vec2", "vec3", "vec4", "int", "ivec2", "ivec3", "ivec4", "uint", "uvec2", "uvec3", "uvec4", "bool", "bvec2", "bvec3", "bvec4", "mat2", "mat3", "mat4", "mat2x3",
               "mat2x4", "mat3x2", "mat3x4", "mat4x2", "mat4x3", "uint8_t", "u8vec2", "u8vec3", "u8vec4", "int8_t", "i8vec2", "i8vec3", "i8vec4", "uint16_t", "u16vec2", "u16vec3", "u16vec4",
               "int16_t", "i16vec2", "i16vec3", "i16vec4", "float16_t", "f16vec2", "f16vec3", "f16vec4"]
BASIC_TYPES_FEW = ["uint", "uvec3", "mat2x4", "uint8_t", "i8vec3"]
LAYOUTS = [("std140", L_STD140), ("std430", L_STD430), ("scalar", L_SCALAR)]
MATRIX_FLAGS = [("row_major", L_ROW_MAJOR), ("column_major", L_COLUMN_MAJOR)]
BUFFER_MODES = [("per_block_buffer", BUFFERMODE_PER_BLOCK), ("single_buffer", BUFFERMODE_SINGLE)]
LOAD_TYPES = [("", LOAD_FULL_MATRIX), ("_comp_access", LOAD_MATRIX_COMPONENTS)]
STORE_TYPES = [("", STORE_FULL_MATRIX), ("_store_cols", STORE_MATRIX_COLUMNS)]
PRECISIONS = [("lowp", LO), ("mediump", M), ("highp", H)]


def matrix_variants():
    for mat_name, mat_flag in MATRIX_FLAGS:
        for load_name, load in LOAD_TYPES:
            for store_name, store in STORE_TYPES:
                yield mat_name, mat_flag, load_name, load, store_name, store


def layout_group_cases(prefix: list, phys: bool, readonly: bool) -> list:
    cases: list = []

    def add(case):
        cases.append(case)

    # single_basic_type
    for lname, lflags in LAYOUTS:
        path = prefix + ["single_basic_type", lname]
        for tname in BASIC_TYPES:
            dt = TYPES[tname]
            if not uc.supports_precision(tname):
                add(block_basic_type_case(path + [tname], basic(tname), lflags, 0, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, readonly))
            else:
                for pname, prec in PRECISIONS:
                    add(block_basic_type_case(path + [f"{pname}_{tname}"], basic(tname, prec), lflags, 0, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, readonly))
            if dt.is_matrix:
                for mat_name, mat_flag in MATRIX_FLAGS:
                    for pname, prec in PRECISIONS:
                        for load_name, load in LOAD_TYPES:
                            for store_name, store in STORE_TYPES:
                                add(block_basic_type_case(path + [f"{mat_name}_{pname}_{tname}{load_name}{store_name}"], basic(tname, prec), lflags | mat_flag, 0, load, store, phys, readonly))

    # single_basic_array
    for lname, lflags in LAYOUTS:
        path = prefix + ["single_basic_array", lname]
        for tname in BASIC_TYPES:
            dt = TYPES[tname]
            add(block_basic_type_case(path + [tname], array(basic(tname, prec_flags(tname)), 3), lflags, 0, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, readonly))
            if dt.is_matrix:
                for mat_name, mat_flag, load_name, load, store_name, store in matrix_variants():
                    add(block_basic_type_case(path + [f"{mat_name}_{tname}{load_name}{store_name}"], array(basic(tname, H), 3), lflags | mat_flag, 0, load, store, phys, readonly))

    # basic_unsized_array
    for lname, lflags in LAYOUTS:
        path = prefix + ["basic_unsized_array", lname]
        for tname in BASIC_TYPES:
            dt = TYPES[tname]
            add(block_basic_unsized_array_case(path + [tname], basic(tname, prec_flags(tname)), 19, lflags, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, readonly))
            if dt.is_matrix:
                for mat_name, mat_flag, load_name, load, store_name, store in matrix_variants():
                    add(block_basic_unsized_array_case(path + [f"{mat_name}_{tname}{load_name}{store_name}"], basic(tname, H), 19, lflags | mat_flag, load, store, phys, readonly))

    # basic_unsized_array_64b
    for lname, lflags in LAYOUTS:
        path = prefix + ["basic_unsized_array_64b", lname]
        for tname in BASIC_TYPES_FEW:
            add(Case(path + [tname], BUFFERMODE_PER_BLOCK, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, big=True))

    if not readonly:
        for group, dims in (("2_level_array", (3, 4)), ("3_level_array", (3, 2, 4))):
            for lname, lflags in LAYOUTS:
                path = prefix + [group, lname]
                for tname in BASIC_TYPES:
                    dt = TYPES[tname]

                    def full_type(prec):
                        t = basic(tname, prec)
                        for size in dims:
                            t = array(t, size)
                        return t

                    add(block_basic_type_case(path + [tname], full_type(prec_flags(tname)), lflags, 0, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, readonly))
                    if dt.is_matrix:
                        for mat_name, mat_flag, load_name, load, store_name, store in matrix_variants():
                            add(block_basic_type_case(path + [f"{mat_name}_{tname}{load_name}{store_name}"], full_type(prec_flags(tname)), lflags | mat_flag, 0, load, store, phys, readonly))

        for lname, lflags in LAYOUTS:
            path = prefix + ["3_level_unsized_array", lname]
            for tname in BASIC_TYPES:
                dt = TYPES[tname]
                child = array(array(basic(tname, prec_flags(tname)), 2), 4)
                add(block_basic_unsized_array_case(path + [tname], child, 3, lflags, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, readonly))
                if dt.is_matrix:
                    for mat_name, mat_flag, load_name, load, store_name, store in matrix_variants():
                        add(block_basic_unsized_array_case(path + [f"{mat_name}_{tname}{load_name}{store_name}"], child, 3, lflags | mat_flag, load, store, phys, readonly))

    # struct families
    def struct_family(group, factory, with_readonly=False, only_not_readonly=True):
        if only_not_readonly and readonly:
            return
        for mode_name, mode in BUFFER_MODES:
            path = prefix + [group, mode_name]
            for lname, lflags in LAYOUTS:
                for is_array in (0, 1):
                    if mode == BUFFERMODE_SINGLE and is_array == 0:
                        continue
                    base = lname + ("_instance_array" if is_array else "")
                    for load_name, load in LOAD_TYPES:
                        for store_name, store in STORE_TYPES:
                            extra = (readonly,) if with_readonly else ()
                            add(factory(path + [base + load_name + store_name], lflags, mode, 3 if is_array else 0, load, store, phys, *extra))

    struct_family("single_struct", single_struct_case, with_readonly=True, only_not_readonly=False)
    struct_family("single_struct_array", single_struct_array_case)
    struct_family("single_nested_struct", single_nested_struct_case)
    struct_family("single_nested_struct_array", single_nested_struct_array_case)
    struct_family("unsized_struct_array", unsized_struct_array_case)
    struct_family("2_level_unsized_struct_array", two_level_unsized_struct_array_case)
    struct_family("unsized_nested_struct_array", unsized_nested_struct_array_case)

    if not readonly:
        for lname, lflags in LAYOUTS:
            path = prefix + ["instance_array_basic_type", lname]
            for tname in BASIC_TYPES:
                dt = TYPES[tname]
                add(block_basic_type_case(path + [tname], basic(tname, prec_flags(tname)), lflags, 3, LOAD_FULL_MATRIX, STORE_FULL_MATRIX, phys, readonly))
                if dt.is_matrix:
                    for mat_name, mat_flag, load_name, load, store_name, store in matrix_variants():
                        add(block_basic_type_case(path + [f"{mat_name}_{tname}{load_name}{store_name}"], basic(tname, H), lflags | mat_flag, 3, load, store, phys, readonly))

        for group, factory in (("multi_basic_types", multi_basic_types_case), ("multi_nested_struct", multi_nested_struct_case)):
            for mode_name, mode in BUFFER_MODES:
                path = prefix + [group, mode_name]
                for lname, lflags in LAYOUTS:
                    for is_array in (0, 1):
                        base = lname + ("_instance_array" if is_array else "")
                        for load_name, load in LOAD_TYPES:
                            for store_name, store in STORE_TYPES:
                                add(factory(path + [base + load_name + store_name], lflags, lflags, mode, 3 if is_array else 0, load, store, phys))
                if group == "multi_basic_types":
                    for is_array in (0, 1):
                        base = "relaxed_block" + ("_instance_array" if is_array else "")
                        for load_name, load in LOAD_TYPES:
                            for store_name, store in STORE_TYPES:
                                add(factory(path + [base + load_name + store_name], L_RELAXED, L_RELAXED, mode, 3 if is_array else 0, load, store, phys))

        add_random(prefix, phys, cases)
    return cases


def de_int32_hash(a: int) -> int:
    return uc.de_int32_hash(a)


def add_random(prefix: list, phys: bool, cases: list) -> None:
    all_std = FEATURE_STD140_LAYOUT | FEATURE_STD430_LAYOUT
    all_basic = FEATURE_VECTORS | FEATURE_MATRICES
    unused = FEATURE_UNUSED_MEMBERS | FEATURE_UNUSED_VARS
    unsized = FEATURE_UNSIZED_ARRAYS
    mat_flags = FEATURE_MATRIX_LAYOUT
    everything = (1 << 19) - 1
    all_but_relaxed = everything & ~FEATURE_RELAXED_LAYOUT & ~FEATURE_16BIT_STORAGE & ~FEATURE_8BIT_STORAGE & ~FEATURE_SCALAR_LAYOUT & ~FEATURE_DESCRIPTOR_INDEXING & ~FEATURE_64B
    all_relaxed = FEATURE_VECTORS | FEATURE_RELAXED_LAYOUT | FEATURE_INSTANCE_ARRAYS
    all_scalar = everything & ~FEATURE_RELAXED_LAYOUT & ~all_std & ~FEATURE_16BIT_STORAGE & ~FEATURE_8BIT_STORAGE & ~FEATURE_DESCRIPTOR_INDEXING & ~FEATURE_64B
    descriptor_indexing = all_std | FEATURE_RELAXED_LAYOUT | FEATURE_SCALAR_LAYOUT | FEATURE_DESCRIPTOR_INDEXING | all_basic | unused | mat_flags
    pb = BUFFERMODE_PER_BLOCK

    for i in range(3):
        path = prefix + ["random"] + ([] if i == 0 else ["16bit" if i == 1 else "8bit"])
        s16 = FEATURE_16BIT_STORAGE if i == 1 else 0
        s8 = FEATURE_8BIT_STORAGE if i == 2 else 0
        base = s8 | s16 | all_std | unused
        full = base | all_basic | mat_flags
        specs = [
            ("scalar_types", pb, base, 25, 0),
            ("vector_types", pb, base | FEATURE_VECTORS, 25, 25),
            ("basic_types", pb, full, 25, 50),
            ("basic_arrays", pb, full | FEATURE_ARRAYS, 25, 50),
            ("unsized_arrays", pb, full | unsized | FEATURE_ARRAYS, 25, 50),
            ("unsized_arrays_64b", pb, full | unsized | FEATURE_ARRAYS | FEATURE_64B, 2, 50),
            ("arrays_of_arrays", pb, full | unsized | FEATURE_ARRAYS | FEATURE_ARRAYS_OF_ARRAYS, 25, 950),
            ("basic_instance_arrays", pb, full | unsized | FEATURE_INSTANCE_ARRAYS, 25, 75),
            ("nested_structs", pb, full | unsized | FEATURE_STRUCTS, 25, 100),
            ("nested_structs_arrays", pb, full | unsized | FEATURE_STRUCTS | FEATURE_ARRAYS | FEATURE_ARRAYS_OF_ARRAYS, 25, 150),
            ("nested_structs_instance_arrays", pb, full | unsized | FEATURE_STRUCTS | FEATURE_INSTANCE_ARRAYS, 25, 125),
            ("nested_structs_arrays_instance_arrays", pb, full | unsized | FEATURE_STRUCTS | FEATURE_ARRAYS | FEATURE_ARRAYS_OF_ARRAYS | FEATURE_INSTANCE_ARRAYS, 25, 175),
            ("all_per_block_buffers", pb, s8 | s16 | all_but_relaxed, 50, 200),
            ("all_shared_buffer", BUFFERMODE_SINGLE, s8 | s16 | all_but_relaxed, 50, 250),
            ("relaxed", BUFFERMODE_SINGLE, s8 | s16 | all_relaxed, 100, de_int32_hash(313)),
            ("scalar", BUFFERMODE_SINGLE, s8 | s16 | all_scalar, 100, de_int32_hash(313)),
            ("descriptor_indexing", BUFFERMODE_SINGLE, s8 | s16 | descriptor_indexing, 50, 123),
        ]
        for name, mode, features, count, base_seed in specs:
            for ndx in range(count):
                cases.append(RandomCase(path + [name, str(ndx)], mode, features, (ndx + base_seed) & MASK32, phys))


def all_cases() -> list:
    cases = layout_group_cases(["layout"], False, False)
    cases += layout_group_cases(["readonly", "layout"], False, True)
    cases += layout_group_cases(["phys", "layout"], True, False)
    for case in cases:
        case.delayed_init()
    return cases

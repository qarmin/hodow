#!/usr/bin/env python3
"""Writes the shader manifest and the case table of dEQP-VK.transform_feedback.fuzz.*

A replay of vktTransformFeedbackFuzzLayoutCase.cpp / vktTransformFeedbackFuzzLayoutTests.cpp / vktTransformFeedbackRandomLayoutCase.cpp: the case tree, the
random interface generator of the `random_*` groups (de::Random), `computeXfbLayout`, the reference values (`generateValues`, seed 1) and the vertex or
geometry shader that `generateTestShader` builds with those values written into it. The Rust side (`src/vkt/tests/transform_feedback/fuzz_tests.rs`) only
needs the transform feedback buffer bindings, the shader pair and the list of components to verify, all of which `fuzz_cases.rs` lists for every case.

Cases whose sources are identical share one manifest entry. A pure text generator: no glslang and no cargo.

    python3 hodow_cts/scripts/gen_xfb_fuzz_cases.py [--check-names <mustpass transform-feedback.txt>]
"""

import hashlib
import json
import struct
import sys
from collections import defaultdict
from pathlib import Path

from de_random import DeRandom, de_string_hash, to_f32

CRATE = Path(__file__).resolve().parent.parent
MANIFEST = CRATE / "shaders" / "manifest" / "transform_feedback_fuzz.toml"
TEMPLATE_DIR = CRATE / "shaders" / "src" / "transform_feedback" / "fuzz"
CASE_TABLE = CRATE / "src" / "vkt" / "tests" / "transform_feedback" / "fuzz_cases.rs"

PRECISION_LOW = 1 << 0
PRECISION_MEDIUM = 1 << 1
PRECISION_HIGH = 1 << 2
PRECISION_MASK = PRECISION_LOW | PRECISION_MEDIUM | PRECISION_HIGH
LAYOUT_XFBBUFFER = 1 << 3
LAYOUT_XFBOFFSET = 1 << 4
LAYOUT_XFBSTRIDE = 1 << 5
LAYOUT_MASK = LAYOUT_XFBBUFFER | LAYOUT_XFBOFFSET | LAYOUT_XFBSTRIDE
FIELD_UNASSIGNED = 1 << 6
FIELD_MISSING = 1 << 7
FIELD_OPTIONS = FIELD_UNASSIGNED | FIELD_MISSING
ALL_BITS = 0xFFFFFFFF

FEATURE_VECTORS = 1 << 0
FEATURE_MATRICES = 1 << 1
FEATURE_ARRAYS = 1 << 2
FEATURE_STRUCTS = 1 << 3
FEATURE_NESTED_STRUCTS = 1 << 4
FEATURE_INSTANCE_ARRAYS = 1 << 5
FEATURE_ARRAYS_OF_ARRAYS = 1 << 6
FEATURE_DOUBLES = 1 << 7
FEATURE_UNASSIGNED_FIELDS = 1 << 8
FEATURE_UNASSIGNED_BLOCK_MEMBERS = 1 << 9
FEATURE_MISSING_BLOCK_MEMBERS = 1 << 10
FEATURE_OUT_OF_ORDER_OFFSETS = 1 << 11

KIND_FLOAT, KIND_DOUBLE, KIND_INT, KIND_UINT = 0, 1, 2, 3

# name -> (scalar type, rows, columns); a scalar or vector has one column
TYPES: dict[str, tuple[str, int, int]] = {}


def _add_types() -> None:
    for scalar, names in (("float", ("float", "vec")), ("int", ("int", "ivec")), ("uint", ("uint", "uvec")), ("double", ("double", "dvec"))):
        TYPES[names[0]] = (scalar, 1, 1)
        for n in (2, 3, 4):
            TYPES[f"{names[1]}{n}"] = (scalar, n, 1)
    for scalar, prefix in (("float", "mat"), ("double", "dmat")):
        for cols in (2, 3, 4):
            for rows in (2, 3, 4):
                name = f"{prefix}{cols}" if cols == rows else f"{prefix}{cols}x{rows}"
                TYPES[name] = (scalar, rows, cols)


_add_types()

BASIC_TYPES = [
    "float", "vec2", "vec3", "vec4", "int", "ivec2", "ivec3", "ivec4", "uint", "uvec2", "uvec3", "uvec4",
    "mat2", "mat3", "mat4", "mat2x3", "mat2x4", "mat3x2", "mat3x4", "mat4x2", "mat4x3",
    "double", "dvec2", "dvec3", "dvec4",
    "dmat2", "dmat2x3", "dmat2x4", "dmat3x2", "dmat3", "dmat3x4", "dmat4x2", "dmat4x3", "dmat4",
]


def scalar_of(name: str) -> str:
    return TYPES[name][0]


def rows_of(name: str) -> int:
    return TYPES[name][1]


def cols_of(name: str) -> int:
    return TYPES[name][2]


def is_matrix(name: str) -> bool:
    return cols_of(name) > 1


def scalar_size(name: str) -> int:
    return rows_of(name) * cols_of(name)


def comp_size(name: str) -> int:
    return 8 if scalar_of(name) == "double" else 4


def byte_size(name: str) -> int:
    return scalar_size(name) * comp_size(name)


def vector_type(scalar: str, n: int) -> str:
    base = {"float": "vec", "int": "ivec", "uint": "uvec", "double": "dvec"}[scalar]
    return scalar if n == 1 else f"{base}{n}"


def supports_precision(name: str) -> bool:
    return scalar_of(name) != "double"


def align32(value: int, alignment: int) -> int:
    return (value + alignment - 1) & ~(alignment - 1)


def div_round_up(a: int, b: int) -> int:
    return (a + b - 1) // b


class StructType:
    def __init__(self, name: str):
        self.name = name
        self.members: list[tuple[str, "VarType", int]] = []

    def add_member(self, name: str, t: "VarType", flags: int = 0) -> None:
        self.members.append((name, t, flags))


class VarType:
    def __init__(self, kind: str, flags: int = 0, dtype: str = "", elem: "VarType | None" = None, size: int = 0, struct: "StructType | None" = None):
        self.kind = kind
        self.flags = flags
        self.dtype = dtype
        self.elem = elem
        self.size = size
        self.struct = struct

    @property
    def is_basic(self) -> bool:
        return self.kind == "basic"

    @property
    def is_array(self) -> bool:
        return self.kind == "array"

    @property
    def is_struct(self) -> bool:
        return self.kind == "struct"


def basic(dtype: str, flags: int = 0) -> VarType:
    return VarType("basic", flags, dtype=dtype)


def array(elem: VarType, size: int) -> VarType:
    return VarType("array", 0, elem=elem, size=size)


def struct_of(st: StructType, flags: int = 0) -> VarType:
    return VarType("struct", flags, struct=st)


class Block:
    def __init__(self, name: str):
        self.name = name
        self.instance_name = ""
        self.members: list[tuple[str, VarType, int]] = []
        self.xfb_buffer = 0
        self.array_size = 0
        self.flags = 0

    @property
    def is_array(self) -> bool:
        return self.array_size > 0

    @property
    def has_instance_name(self) -> bool:
        return self.instance_name != ""

    def add_member(self, name: str, t: VarType, flags: int = 0) -> None:
        self.members.append((name, t, flags))


class Interface:
    def __init__(self):
        self.structs: list[StructType] = []
        self.blocks: list[Block] = []

    def alloc_struct(self, name: str) -> StructType:
        self.structs.append(StructType(name))
        return self.structs[-1]

    def alloc_block(self, name: str) -> Block:
        self.blocks.append(Block(name))
        return self.blocks[-1]


class BlockEntry:
    def __init__(self):
        self.name = ""
        self.xfb_buffer = -1
        self.xfb_offset = -1
        self.xfb_size = 0
        self.xfb_stride = 0
        self.active: list[int] = []
        self.decl_ndx = -1
        self.instance_ndx = -1
        self.location = -1
        self.location_size = -1


class IfaceEntry:
    def __init__(self):
        self.name = ""
        self.type = ""
        self.array_size = 0
        self.block_layout_ndx = -1
        self.offset = -1
        self.array_stride = -1
        self.matrix_stride = -1
        self.location = -1
        self.validate = True


class Layout:
    def __init__(self):
        self.blocks: list[BlockEntry] = []
        self.interfaces: list[IfaceEntry] = []

    def interface_index(self, block_ndx: int, name: str) -> int:
        for ndx, entry in enumerate(self.interfaces):
            if self.blocks[entry.block_layout_ndx].decl_ndx == block_ndx and entry.name == name:
                return ndx
        return -1

    def block_index(self, block_ndx: int, instance_ndx: int) -> int:
        for ndx, entry in enumerate(self.blocks):
            if entry.decl_ndx == block_ndx and entry.instance_ndx == instance_ndx:
                return ndx
        return -1


def member_alignment(t: VarType) -> int:
    if t.is_basic:
        return comp_size(t.dtype)
    if t.is_array:
        return member_alignment(t.elem)
    best = 0
    for _, mt, _ in t.struct.members:
        best = max(best, member_alignment(mt))
    return best


def block_alignment(block: Block) -> int:
    best = 0
    for _, mt, _ in block.members:
        best = max(best, member_alignment(mt))
    return best


def array_stride_for_location(name: str) -> int:
    return align32(byte_size(name), 16)


class Cursor:
    def __init__(self):
        self.offset = 0
        self.location = 0


def compute_member_layout(layout: Layout, cur: Cursor, block_ndx: int, prefix: str, t: VarType, layout_flags: int) -> None:
    loc_align = 16
    validate = (layout_flags & (FIELD_MISSING | FIELD_UNASSIGNED)) == 0
    base_alignment = member_alignment(t)
    cur.offset = align32(cur.offset, base_alignment)

    def new_entry(name: str, dtype: str) -> IfaceEntry:
        entry = IfaceEntry()
        entry.name = name
        entry.type = dtype
        entry.array_size = 1
        entry.array_stride = 0
        entry.matrix_stride = 0
        entry.block_layout_ndx = block_ndx
        entry.location = 0
        entry.validate = validate
        return entry

    if t.is_basic:
        name = t.dtype
        entry = new_entry(prefix, name)
        if is_matrix(name):
            vec = vector_type(scalar_of(name), rows_of(name))
            stride = byte_size(vec)
            stride_loc = array_stride_for_location(vec)
            entry.matrix_stride = stride
            field_size = cols_of(name) * stride
            field_size_loc = cols_of(name) * stride_loc
        else:
            field_size = byte_size(name)
            field_size_loc = align32(field_size, loc_align)
        entry.offset = cur.offset
        entry.location = cur.location
        cur.offset += field_size
        cur.location += div_round_up(field_size_loc, loc_align)
        layout.interfaces.append(entry)
    elif t.is_array:
        elem = t.elem
        if elem.is_basic and not is_matrix(elem.dtype):
            stride = byte_size(elem.dtype)
            field_size = stride * t.size
            field_size_loc = array_stride_for_location(elem.dtype) * t.size
            entry = new_entry(prefix + "[0]", elem.dtype)
            entry.offset = cur.offset
            entry.array_size = t.size
            entry.array_stride = stride
            entry.matrix_stride = 0
            entry.location = cur.location
            cur.offset += field_size
            cur.location += div_round_up(field_size_loc, loc_align)
            layout.interfaces.append(entry)
        elif elem.is_basic:
            name = elem.dtype
            vec = vector_type(scalar_of(name), rows_of(name))
            num_vecs = cols_of(name)
            stride = byte_size(vec)
            field_size = num_vecs * t.size * stride
            field_size_loc = num_vecs * t.size * array_stride_for_location(vec)
            entry = new_entry(prefix + "[0]", name)
            entry.offset = cur.offset
            entry.array_size = t.size
            entry.array_stride = stride * num_vecs
            entry.matrix_stride = stride
            entry.location = cur.location
            cur.offset += field_size
            cur.location += div_round_up(field_size_loc, loc_align)
            layout.interfaces.append(entry)
        else:
            for elem_ndx in range(t.size):
                compute_member_layout(layout, cur, block_ndx, f"{prefix}[{elem_ndx}]", t.elem, layout_flags)
    else:
        for member_name, member_type, member_flags in t.struct.members:
            compute_member_layout(layout, cur, block_ndx, f"{prefix}.{member_name}", member_type, (member_flags | layout_flags) & FIELD_OPTIONS)
        cur.offset = align32(cur.offset, base_alignment)


def overlapped(a1: int, b1: int, a2: int, b2: int) -> bool:
    b1s = b1 - 1
    b2s = b2 - 1
    return a2 <= a1 <= b2s or a2 <= b1s <= b2s or a1 <= a2 <= b1s or a1 <= b2s <= b1s


def compute_xfb_layout(interface: Interface) -> tuple[Layout, dict, int]:
    layout = Layout()
    cur = Cursor()
    per_buffer = defaultdict(int)
    alignments = defaultdict(int)
    buffers_list: dict[int, int] = {}
    stride_group = defaultdict(int)
    used_ranges = defaultdict(list)

    for block in interface.blocks:
        buffers_list[block.xfb_buffer] = 1
        stride_group[block.xfb_buffer] = block.xfb_buffer

    for analyzed in sorted(buffers_list):
        for block_ndx, block in enumerate(interface.blocks):
            if block.xfb_buffer != analyzed:
                continue
            block_prefix = block.name + "." if block.has_instance_name else ""
            num_instances = block.array_size if block.is_array else 1
            active_block_ndx = len(layout.blocks)
            start_iface = len(layout.interfaces)
            start_location = cur.location
            iface_alignment = block_alignment(block)
            cur.offset = 0
            block_size = 0
            first_buffer = block.xfb_buffer

            while True:
                saved_ifaces = len(layout.interfaces)
                saved_offset = cur.offset
                saved_location = cur.location
                ranges = used_ranges[first_buffer]
                fit = True
                per_buffer[first_buffer] = align32(per_buffer[first_buffer], iface_alignment)
                for member_name, member_type, member_flags in block.members:
                    compute_member_layout(layout, cur, active_block_ndx, block_prefix + member_name, member_type, member_flags & FIELD_OPTIONS)
                block_size = align32(cur.offset, iface_alignment)
                for range_start, range_end in ranges:
                    gen_start = per_buffer[first_buffer]
                    gen_end = gen_start + block_size
                    if overlapped(gen_start, gen_end, range_start, range_end):
                        fit = False
                        per_buffer[first_buffer] = range_end
                        cur.offset = saved_offset
                        cur.location = saved_location
                        del layout.interfaces[saved_ifaces:]
                if fit:
                    break

            first_offset = per_buffer[first_buffer]
            end_iface = len(layout.interfaces)
            size_in_locations = cur.location - start_location
            cur.location -= size_in_locations

            if num_instances > 1:
                block.flags |= LAYOUT_XFBSTRIDE

            for instance_ndx in range(num_instances):
                entry = BlockEntry()
                layout.blocks.append(entry)
                buffer = first_buffer + instance_ndx
                per_buffer[buffer] = first_offset
                entry.name = block.name
                entry.xfb_buffer = buffer
                entry.xfb_offset = per_buffer[buffer]
                entry.xfb_size = block_size
                entry.decl_ndx = block_ndx
                entry.instance_ndx = instance_ndx
                entry.location = cur.location
                entry.location_size = size_in_locations
                per_buffer[buffer] += block_size
                cur.location += size_in_locations
                entry.active = list(range(start_iface, end_iface))
                if block.is_array:
                    entry.name += f"[{instance_ndx}]"
                used_ranges[buffer].append((entry.xfb_offset, entry.xfb_offset + entry.xfb_size))
                alignments[buffer] = max(iface_alignment, alignments[buffer])
                stride_group[buffer] = stride_group[first_buffer]

    group_stride = defaultdict(int)
    for buffer in sorted(per_buffer):
        group = stride_group[buffer]
        group_stride[group] = max(group_stride[group], per_buffer[buffer])
    for buffer in sorted(per_buffer):
        per_buffer[buffer] = group_stride[stride_group[buffer]]

    group_alignment = defaultdict(int)
    for buffer in sorted(per_buffer):
        group = stride_group[buffer]
        group_alignment[group] = max(group_alignment[group], alignments[buffer])
    for buffer in sorted(per_buffer):
        alignments[buffer] = group_alignment[stride_group[buffer]]

    for buffer in sorted(per_buffer):
        per_buffer[buffer] = align32(per_buffer[buffer], alignments[buffer])

    for entry in layout.blocks:
        entry.xfb_stride = per_buffer[entry.xfb_buffer]

    return layout, per_buffer, cur.location


def walk_entry(entry: IfaceEntry, base: int):
    """Yields (elem, vec, comp, absolute byte offset) for every component of an interface entry, in `generateValue` order."""
    name = entry.type
    csize = comp_size(name)
    num_vecs = cols_of(name) if is_matrix(name) else 1
    vec_size = scalar_size(name) // num_vecs
    is_array = entry.array_size > 1
    for elem in range(entry.array_size):
        elem_off = base + entry.offset + (elem * entry.array_stride if is_array else 0)
        for vec in range(num_vecs):
            vec_off = elem_off + (vec * entry.matrix_stride if is_matrix(name) else 0)
            for comp in range(vec_size):
                yield elem, vec, comp, vec_off + csize * comp


def float_str(value: float) -> str:
    return f"{value:.1f}"


def pack_value(scalar: str, value: int) -> bytes:
    if scalar == "double":
        return struct.pack("<d", float(value))
    if scalar == "float":
        return struct.pack("<f", float(value))
    if scalar == "int":
        return struct.pack("<i", value)
    return struct.pack("<I", value)


def read_value(data: bytearray, scalar: str, offset: int):
    if scalar == "double":
        return struct.unpack_from("<d", data, offset)[0]
    if scalar == "float":
        return struct.unpack_from("<f", data, offset)[0]
    if scalar == "int":
        return struct.unpack_from("<i", data, offset)[0]
    return struct.unpack_from("<I", data, offset)[0]


def indent(level: int) -> str:
    return "\t" * level


def precision_str(flags: int) -> str:
    if flags & PRECISION_LOW:
        return "lowp"
    if flags & PRECISION_MEDIUM:
        return "mediump"
    if flags & PRECISION_HIGH:
        return "highp"
    return ""


def layout_flags_fmt(flags: int, buffer: int, stride: int, offset: int) -> str:
    parts = []
    if flags & LAYOUT_XFBBUFFER:
        parts.append(f"xfb_buffer = {buffer}")
    if flags & LAYOUT_XFBOFFSET:
        parts.append(f"xfb_offset = {offset}")
    if flags & LAYOUT_XFBSTRIDE:
        parts.append(f"xfb_stride = {stride}")
    return ", ".join(parts)


def layout_and_precision(out: list, flags: int, buffer: int, stride: int, offset: int) -> None:
    if flags & LAYOUT_MASK:
        out.append(f"layout({layout_flags_fmt(flags & LAYOUT_MASK, buffer, stride, offset)}) ")
    if flags & PRECISION_MASK:
        out.append(precision_str(flags & PRECISION_MASK) + " ")


def decl_var(out: list, t: VarType, name: str, indent_level: int, hints: int, mask: int, buffer: int, stride: int, offset: int) -> None:
    if hints & FIELD_MISSING:
        out.append("// ")
    layout_and_precision(out, t.flags & mask, buffer, stride, offset)
    if t.is_basic:
        out.append(f"{t.dtype} {name}")
    elif t.is_array:
        sizes = []
        cur = t
        while cur.is_array:
            sizes.append(cur.size)
            cur = cur.elem
        layout_and_precision(out, cur.flags & mask, buffer, stride, offset)
        out.append(cur.dtype if cur.is_basic else cur.struct.name)
        out.append(" " + name)
        for size in sizes:
            out.append(f"[{size}]")
    else:
        out.append(f"{t.struct.name} {name}")
    out.append(";")
    if hints & FIELD_MISSING:
        out.append(" // missing field")
    elif hints & FIELD_UNASSIGNED:
        out.append(" // unassigned")
    out.append("\n")


def decl_struct(out: list, st: StructType) -> None:
    out.append(f"struct {st.name}\n{indent(0)}{{\n")
    for member_name, member_type, member_flags in st.members:
        out.append(indent(1))
        decl_var(out, member_type, member_name, 1, member_flags & FIELD_OPTIONS, ALL_BITS & ~LAYOUT_MASK, 0, 0, 0)
    out.append(indent(0) + "}")
    out.append(";\n")


def block_member_offset(block_ndx: int, block: Block, member_name: str, member_type: VarType, layout: Layout) -> int:
    name = ""
    if block.has_instance_name:
        name += block.name + "."
    name += member_name
    cur = member_type
    while not cur.is_basic:
        if cur.is_array:
            name += "[0]"
            cur = cur.elem
        if cur.is_struct:
            first_name, first_type, _ = cur.struct.members[0]
            name += "." + first_name
            cur = first_type
    index = layout.interface_index(block_ndx, name)
    assert index >= 0, name
    return layout.interfaces[index].offset


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


def decl_block(out: list, block_ndx: int, block: Block, layout: Layout, shuffle: bool) -> None:
    ndx = layout.block_index(block_ndx, 0)
    entry = layout.blocks[ndx]
    out.append("layout(")
    out.append(f"location = {entry.location}")
    if block.flags & LAYOUT_MASK:
        out.append(", " + layout_flags_fmt(block.flags & LAYOUT_MASK, entry.xfb_buffer, entry.xfb_stride, entry.xfb_offset))
    out.append(f") out {block.name}")
    out.append(f" // sizeInBytes={entry.xfb_size} sizeInLocations={entry.location_size}")
    out.append("\n{\n")
    members = semi_shuffle(block.members) if shuffle else block.members
    for member_name, member_type, member_flags in members:
        out.append(indent(1))
        if member_flags & LAYOUT_MASK:
            out.append(f"layout({layout_flags_fmt(member_flags & LAYOUT_MASK, entry.xfb_buffer, entry.xfb_stride, entry.xfb_offset + block_member_offset(block_ndx, block, member_name, member_type, layout))}) ")
        decl_var(out, member_type, member_name, 1, member_flags & FIELD_OPTIONS, ALL_BITS, entry.xfb_buffer, entry.xfb_stride, entry.xfb_offset + block_member_offset(block_ndx, block, member_name, member_type, layout))
    out.append("}")
    if block.has_instance_name:
        out.append(" " + block.instance_name)
        if block.is_array:
            out.append(f"[{block.array_size}]")
    out.append(";\n")


def value_src(data: bytearray, entry: IfaceEntry, base: int, elem_ndx: int) -> str:
    name = entry.type
    scalar = scalar_of(name)
    size = scalar_size(name)
    csize = comp_size(name)
    is_array = entry.array_size > 1
    elem_ptr = base + entry.offset + (elem_ndx * entry.array_stride if is_array else 0)
    out = []
    if size > 1:
        out.append(name + "(")
    if is_matrix(name):
        for col in range(cols_of(name)):
            for row in range(rows_of(name)):
                value = float(read_value(data, scalar, elem_ptr + col * entry.matrix_stride + row * csize))
                if col > 0 or row > 0:
                    out.append(", ")
                out.append(float_str(value))
    else:
        for ndx in range(size):
            value = read_value(data, scalar, elem_ptr + ndx * csize)
            if ndx > 0:
                out.append(", ")
            if scalar == "double":
                out.append(float_str(float(value)))
            elif scalar == "float":
                out.append(float_str(value) + "f")
            elif scalar == "int":
                out.append(str(value))
            else:
                out.append(f"{value}u")
    if size > 1:
        out.append(")")
    return "".join(out)


def gen_assignment(out: list, data: bytearray, layout: Layout, t: VarType, src_name: str, api_name: str, block_ndx: int, base: int) -> None:
    if t.is_basic or (t.is_array and t.elem.is_basic):
        is_array = t.is_array
        full_api_name = api_name + ("[0]" if is_array else "")
        entry = layout.interfaces[layout.interface_index(block_ndx, full_api_name)]
        if is_array:
            for elem_ndx in range(t.size):
                out.append(f"\t{src_name}[{elem_ndx}] = {value_src(data, entry, base, elem_ndx)};\n")
        else:
            out.append(f"\t{src_name} = {value_src(data, entry, base, 0)};\n")
    elif t.is_array:
        for elem_ndx in range(t.size):
            op = f"[{elem_ndx}]"
            gen_assignment(out, data, layout, t.elem, src_name + op, api_name + op, block_ndx, base)
    else:
        for member_name, member_type, member_flags in t.struct.members:
            if member_flags & (FIELD_UNASSIGNED | FIELD_MISSING) == 0:
                gen_assignment(out, data, layout, member_type, f"{src_name}.{member_name}", f"{api_name}.{member_name}", block_ndx, base)


def gen_assignments(out: list, data: bytearray, layout: Layout, interface: Interface, block_ptrs: dict) -> None:
    for block_ndx, block in enumerate(interface.blocks):
        has_instance = block.has_instance_name
        num_instances = block.array_size if block.is_array else 1
        api_prefix = block.name + "." if has_instance else ""
        for instance_ndx in range(num_instances):
            postfix = f"[{instance_ndx}]" if block.is_array else ""
            src_prefix = block.instance_name + postfix + "." if has_instance else ""
            block_layout_ndx = layout.block_index(block_ndx, instance_ndx)
            base = block_ptrs[block_layout_ndx]
            for member_name, member_type, member_flags in block.members:
                if member_flags & (FIELD_MISSING | FIELD_UNASSIGNED) == 0:
                    gen_assignment(out, data, layout, member_type, src_prefix + member_name, api_prefix + member_name, block_ndx, base)


def generate_test_shader(interface: Interface, layout: Layout, data: bytearray, block_ptrs: dict, geometry: bool, shuffle: bool) -> str:
    out = ["#version 450\n\n"]
    if geometry:
        out.append("layout(points) in;\nlayout(points, max_vertices = 1) out;\n\n")
    for st in interface.structs:
        if st.name:
            decl_struct(out, st)
    for block_ndx, block in enumerate(interface.blocks):
        decl_block(out, block_ndx, block, layout, shuffle)
    out.append("\nvoid main (void)\n{\n")
    gen_assignments(out, data, layout, interface, block_ptrs)
    if geometry:
        out.append("\n\tEmitVertex();\n\tEndPrimitive();\n")
    out.append("}\n")
    return "".join(out)


PASSTHROUGH_SHADER = "#version 450\n\nvoid main (void)\n{\n}\n"


class Case:
    def __init__(self, path: list, interface: Interface, geometry: bool, shuffle: bool = False):
        self.path = path
        self.geometry = geometry
        self.shuffle = shuffle
        self.interface = interface
        self.build()

    def build(self) -> None:
        layout, per_buffer, locations = compute_xfb_layout(self.interface)
        self.layout = layout
        self.locations_required = locations
        total = 0
        buffer_offsets = {}
        max_buffer = 0
        for buffer in sorted(per_buffer):
            buffer_offsets[buffer] = total
            total += per_buffer[buffer]
            max_buffer = max(max_buffer, buffer)
        self.data_size = total
        self.tf_sizes = [0] * (max_buffer + 1)
        self.tf_offsets = [0] * (max_buffer + 1)
        for buffer in sorted(per_buffer):
            self.tf_sizes[buffer] = per_buffer[buffer]
            self.tf_offsets[buffer] = buffer_offsets[buffer]
        block_ptrs = {}
        for ndx, block in enumerate(layout.blocks):
            block_ptrs[ndx] = buffer_offsets[block.xfb_buffer] + block.xfb_offset

        data = bytearray(total)
        rnd = DeRandom(1)
        checks = []
        for ndx, block in enumerate(layout.blocks):
            for iface_ndx in block.active:
                entry = layout.interfaces[iface_ndx]
                if not entry.validate:
                    continue
                scalar = scalar_of(entry.type)
                for _, _, _, offset in walk_entry(entry, block_ptrs[ndx]):
                    sign = 1 if rnd.get_uint32() & 0xFFFFFF < 0x800000 else -1
                    value = rnd.get_int(1, 127)
                    if scalar == "uint":
                        data[offset:offset + 4] = pack_value("uint", value)
                        checks.append((offset, KIND_UINT, value))
                    else:
                        data[offset:offset + comp_size(entry.type)] = pack_value(scalar, sign * value)
                        kind = {"float": KIND_FLOAT, "double": KIND_DOUBLE, "int": KIND_INT}[scalar]
                        checks.append((offset, kind, sign * value))
        self.checks = checks
        self.uses_float64 = any(scalar_of(e.type) == "double" for e in layout.interfaces)
        self.data = data

        main = generate_test_shader(self.interface, layout, data, block_ptrs, self.geometry, self.shuffle)
        if self.geometry:
            self.vert_src = PASSTHROUGH_SHADER
            self.geom_src = main
        else:
            self.vert_src = main
            self.geom_src = ""


def has_precision_flag(dtype: str) -> int:
    return PRECISION_HIGH if supports_precision(dtype) else 0


DEFAULT_FLAGS = LAYOUT_XFBBUFFER | LAYOUT_XFBOFFSET


def block_basic_type_case(path, vtype, layout_flags, num_instances, geometry):
    interface = Interface()
    block = interface.alloc_block("Block")
    block.add_member("var", vtype, 0)
    block.flags = layout_flags
    if num_instances > 0:
        block.array_size = num_instances
        block.instance_name = "block"
    return Case(path, interface, geometry)


def basic_type_cases(prefix: list, name: str, vtype: VarType, layout_flags: int, num_instances: int = 0) -> list:
    return [block_basic_type_case(prefix + [name, stage], vtype, layout_flags, num_instances, stage == "geometry") for stage in ("vertex", "geometry")]


def single_struct_interface(num_instances: int) -> Interface:
    interface = Interface()
    st = interface.alloc_struct("S")
    st.add_member("a", basic("ivec3", PRECISION_HIGH), FIELD_UNASSIGNED)
    st.add_member("b", array(basic("vec3", PRECISION_HIGH), 2))
    st.add_member("c", basic("mat3", PRECISION_MEDIUM))
    block = interface.alloc_block("Block")
    block.add_member("s", struct_of(st), 0)
    block.flags = DEFAULT_FLAGS
    if num_instances > 0:
        block.instance_name = "block"
        block.array_size = num_instances
    return interface


def single_struct_array_interface(num_instances: int) -> Interface:
    interface = Interface()
    st = interface.alloc_struct("S")
    st.add_member("a", basic("ivec3", PRECISION_HIGH), FIELD_UNASSIGNED)
    st.add_member("b", array(basic("mat2", PRECISION_MEDIUM), 2))
    st.add_member("c", basic("float", PRECISION_HIGH))
    block = interface.alloc_block("Block")
    block.add_member("u", basic("uint", PRECISION_LOW))
    block.add_member("s", array(struct_of(st), 2))
    block.add_member("v", basic("vec4", PRECISION_MEDIUM))
    block.flags = DEFAULT_FLAGS
    if num_instances > 0:
        block.instance_name = "block"
        block.array_size = num_instances
    return interface


def single_nested_struct_interface(num_instances: int) -> Interface:
    interface = Interface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("ivec3", PRECISION_HIGH))
    s.add_member("b", array(basic("mat2", PRECISION_MEDIUM), 2))
    s.add_member("c", basic("float", PRECISION_HIGH), FIELD_UNASSIGNED)
    t = interface.alloc_struct("T")
    t.add_member("a", basic("vec3", PRECISION_MEDIUM))
    t.add_member("b", struct_of(s))
    block = interface.alloc_block("Block")
    block.add_member("s", struct_of(s), 0)
    block.add_member("v", basic("uint", PRECISION_LOW), FIELD_UNASSIGNED)
    block.add_member("t", struct_of(t), 0)
    block.add_member("u", basic("vec2", PRECISION_HIGH), 0)
    block.flags = DEFAULT_FLAGS
    if num_instances > 0:
        block.instance_name = "block"
        block.array_size = num_instances
    return interface


def single_nested_struct_array_interface(num_instances: int) -> Interface:
    interface = Interface()
    s = interface.alloc_struct("S")
    s.add_member("a", array(basic("float", PRECISION_HIGH), 2))
    t = interface.alloc_struct("T")
    t.add_member("a", basic("mat2", PRECISION_MEDIUM))
    t.add_member("b", array(struct_of(s), 2))
    block = interface.alloc_block("Block")
    block.add_member("s", struct_of(s), 0)
    block.add_member("v", basic("vec2", PRECISION_LOW), FIELD_UNASSIGNED)
    block.add_member("t", array(struct_of(t), 2), 0)
    block.add_member("u", basic("uint", PRECISION_HIGH), 0)
    block.flags = DEFAULT_FLAGS
    if num_instances > 0:
        block.instance_name = "block"
        block.array_size = num_instances
    return interface


def multi_basic_types_interface(num_instances: int) -> Interface:
    interface = Interface()
    a = interface.alloc_block("BlockA")
    a.add_member("a", basic("float", PRECISION_HIGH))
    a.add_member("b", basic("uvec3", PRECISION_LOW), FIELD_UNASSIGNED)
    a.add_member("c", basic("mat2", PRECISION_MEDIUM))
    a.instance_name = "blockA"
    a.flags = DEFAULT_FLAGS
    b = interface.alloc_block("BlockB")
    b.add_member("a", basic("mat3", PRECISION_MEDIUM))
    b.add_member("b", basic("ivec2", PRECISION_LOW))
    b.add_member("c", basic("vec4", PRECISION_HIGH), FIELD_UNASSIGNED)
    b.add_member("d", basic("int", 0))
    b.instance_name = "blockB"
    b.flags = DEFAULT_FLAGS
    if num_instances > 0:
        a.array_size = num_instances
        b.array_size = num_instances
    return interface


def multi_nested_struct_interface(num_instances: int) -> Interface:
    interface = Interface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("mat2", PRECISION_LOW))
    s.add_member("b", array(basic("ivec2", PRECISION_MEDIUM), 2))
    t = interface.alloc_struct("T")
    t.add_member("a", basic("uint", PRECISION_MEDIUM), FIELD_UNASSIGNED)
    t.add_member("b", struct_of(s))
    t.add_member("c", basic("uvec3", 0))
    a = interface.alloc_block("BlockA")
    a.add_member("a", basic("float", PRECISION_HIGH))
    a.add_member("b", struct_of(s))
    a.add_member("c", basic("uint", PRECISION_LOW), FIELD_UNASSIGNED)
    a.instance_name = "blockA"
    a.flags = DEFAULT_FLAGS
    b = interface.alloc_block("BlockB")
    b.add_member("a", basic("mat2", PRECISION_MEDIUM))
    b.add_member("b", struct_of(t))
    b.add_member("c", basic("int", 0))
    b.instance_name = "blockB"
    b.flags = DEFAULT_FLAGS
    if num_instances > 0:
        a.array_size = num_instances
        b.array_size = num_instances
    return interface


def various_buffers_interface(num_instances: int, buffer_a: int, buffer_b: int, buffer_c: int) -> Interface:
    interface = Interface()
    s = interface.alloc_struct("S")
    s.add_member("a", array(basic("float", PRECISION_LOW), 3))
    s.add_member("b", array(basic("vec2", PRECISION_MEDIUM), 2))
    s.add_member("c", basic("vec4", PRECISION_HIGH))
    t = interface.alloc_struct("T")
    t.add_member("a", basic("uint", PRECISION_MEDIUM), FIELD_UNASSIGNED)
    t.add_member("b", basic("ivec3", 0))
    a = interface.alloc_block("BlockA")
    a.add_member("a", basic("int", PRECISION_HIGH))
    a.add_member("b", struct_of(s))
    a.add_member("c", basic("uvec3", PRECISION_LOW), FIELD_UNASSIGNED)
    a.instance_name = "blockA"
    a.flags = DEFAULT_FLAGS
    a.xfb_buffer = buffer_a
    b = interface.alloc_block("BlockB")
    b.add_member("a", basic("mat2", PRECISION_MEDIUM))
    b.add_member("b", struct_of(t))
    b.add_member("c", basic("ivec4", 0), FIELD_UNASSIGNED)
    b.add_member("d", basic("int", 0))
    b.instance_name = "blockB"
    b.flags = DEFAULT_FLAGS
    b.xfb_buffer = buffer_b
    c = interface.alloc_block("BlockC")
    c.add_member("a", basic("uint", PRECISION_HIGH))
    c.add_member("b", basic("mat2", PRECISION_HIGH))
    c.instance_name = "blockC"
    c.flags = DEFAULT_FLAGS
    c.xfb_buffer = buffer_c
    if num_instances > 0:
        a.array_size = num_instances
        b.array_size = num_instances
    return interface


def two_level_struct_array_interface(num_instances: int) -> Interface:
    interface = Interface()
    s = interface.alloc_struct("S")
    s.add_member("a", basic("uvec3", PRECISION_HIGH), FIELD_UNASSIGNED)
    s.add_member("b", basic("mat2", PRECISION_MEDIUM))
    block = interface.alloc_block("Block")
    block.add_member("u", basic("int", PRECISION_MEDIUM))
    block.add_member("s", array(array(struct_of(s), 2), 2))
    block.add_member("v", basic("vec2", PRECISION_MEDIUM))
    block.flags = DEFAULT_FLAGS
    if num_instances > 0:
        block.instance_name = "block"
        block.array_size = num_instances
    return interface


def gen_name(first: str, last: str, ndx: int) -> str:
    text = ""
    alphabet = ord(last) - ord(first) + 1
    while ndx > alphabet:
        text = chr(ord(first) + (ndx - 1) % alphabet) + text
        ndx = (ndx - 1) // alphabet
    return chr(ord(first) + (ndx % (alphabet + 1)) - 1) + text


F_STRUCT = to_f32(0.1)
F_ARRAY = to_f32(0.1)
F_INSTANCE = to_f32(0.3)
F_UNASSIGNED_FIELD = to_f32(0.15)
F_UNASSIGNED_MEMBER = to_f32(0.15)
F_MISSING_MEMBER = to_f32(0.15)


class RandomBuilder:
    def __init__(self, features: int, seed: int):
        self.features = features
        self.explicit_offsets = (features & (FEATURE_OUT_OF_ORDER_OFFSETS | FEATURE_MISSING_BLOCK_MEMBERS)) != 0
        self.max_blocks = 3
        self.max_instances = 3 if features & FEATURE_INSTANCE_ARRAYS else 0
        self.max_array_length = 4 if features & FEATURE_ARRAYS else 0
        self.max_struct_depth = 2 if features & FEATURE_STRUCTS else 0
        self.max_block_members = 3
        self.max_struct_members = 3
        self.block_ndx = 1
        self.interface_ndx = 1
        self.struct_ndx = 1
        self.interface = Interface()
        self.candidates = self.fill_type_candidates()
        rnd = DeRandom(seed)
        num_blocks = rnd.get_int(1, self.max_blocks)
        for _ in range(num_blocks):
            self.generate_block(rnd, LAYOUT_XFBBUFFER | LAYOUT_XFBOFFSET)

    def fill_type_candidates(self) -> list:
        f = self.features
        out = ["float", "int", "uint"]
        if f & FEATURE_DOUBLES:
            out.append("double")
        if f & FEATURE_VECTORS:
            out += ["vec2", "vec3", "vec4", "ivec2", "ivec3", "ivec4", "uvec2", "uvec3", "uvec4"]
            if f & FEATURE_DOUBLES:
                out += ["dvec2", "dvec3", "dvec4"]
        if f & FEATURE_MATRICES:
            out += ["mat2", "mat2x3", "mat3x2", "mat3", "mat3x4", "mat4x2", "mat4x3", "mat4"]
            if f & FEATURE_DOUBLES:
                out += ["dmat2", "dmat2x3", "dmat3x2", "dmat3", "dmat3x4", "dmat4x2", "dmat4x3", "dmat4"]
        return out

    @staticmethod
    def choose(rnd: DeRandom, items: list):
        chosen = items[0]
        for ndx in range(1, len(items)):
            if rnd.get_int(0, ndx) < 1:
                chosen = items[ndx]
        return chosen

    def generate_block(self, rnd: DeRandom, layout_flags: int) -> None:
        block = self.interface.alloc_block("Block" + chr(ord("A") + self.block_ndx))
        num_instances = 0
        if self.max_instances > 0 and rnd.get_float() < F_INSTANCE:
            num_instances = rnd.get_int(0, self.max_instances)
        num_members = rnd.get_int(1, self.max_block_members)
        counter = [0]
        if num_instances > 0:
            block.array_size = num_instances
        if num_instances > 0 or (rnd.get_uint32() & 0xFFFFFF) < 0x800000:
            block.instance_name = "block" + chr(ord("A") + self.block_ndx)
        block.flags = layout_flags
        for _ in range(num_members):
            self.generate_block_member(rnd, block, num_members, counter)
        self.block_ndx += 1

    def generate_block_member(self, rnd: DeRandom, block: Block, num_members: int, counter: list) -> None:
        unassigned_allowed = bool(self.features & FEATURE_UNASSIGNED_BLOCK_MEMBERS)
        missing_allowed = bool(self.features & FEATURE_MISSING_BLOCK_MEMBERS)
        flags = 0
        name = gen_name("a", "z", self.interface_ndx)
        vtype = self.generate_type(rnd, 0, True)
        if counter[0] < num_members - 1:
            if missing_allowed and rnd.get_float() < F_MISSING_MEMBER:
                flags |= FIELD_MISSING
                counter[0] += 1
            elif unassigned_allowed and rnd.get_float() < F_UNASSIGNED_MEMBER:
                flags |= FIELD_UNASSIGNED
                counter[0] += 1
        block.add_member(name, vtype, flags)
        self.interface_ndx += 1

    def generate_type(self, rnd: DeRandom, depth: int, array_ok: bool) -> VarType:
        if depth < self.max_struct_depth and rnd.get_float() < F_STRUCT:
            unassigned_ok = bool(self.features & FEATURE_UNASSIGNED_FIELDS)
            num_members = rnd.get_int(1, self.max_struct_members)
            member_types = [self.generate_type(rnd, depth + 1, True) for _ in range(num_members)]
            st = self.interface.alloc_struct("s" + gen_name("A", "Z", self.struct_ndx))
            self.struct_ndx += 1
            for ndx in range(num_members):
                flags = 0
                if unassigned_ok and rnd.get_float() < F_UNASSIGNED_FIELD:
                    flags |= FIELD_UNASSIGNED
                st.add_member("m" + chr(ord("A") + ndx), member_types[ndx], flags)
            return struct_of(st, LAYOUT_XFBOFFSET if self.explicit_offsets else 0)
        if self.max_array_length > 0 and array_ok and rnd.get_float() < F_ARRAY:
            arrays_of_arrays_ok = bool(self.features & FEATURE_ARRAYS_OF_ARRAYS)
            length = rnd.get_int(1, self.max_array_length)
            elem = self.generate_type(rnd, depth, arrays_of_arrays_ok)
            return array(elem, length)
        dtype = self.choose(rnd, self.candidates)
        flags = LAYOUT_XFBOFFSET if self.explicit_offsets else 0
        if supports_precision(dtype):
            flags |= self.choose(rnd, [PRECISION_LOW, PRECISION_MEDIUM, PRECISION_HIGH])
        return basic(dtype, flags)


def all_cases() -> list:
    cases: list[Case] = []
    prefix = []

    def add_group(group: str, make) -> None:
        make([group])

    # 2_level_array
    for dtype in BASIC_TYPES:
        vtype = array(array(basic(dtype, has_precision_flag(dtype)), 2), 2)
        cases += basic_type_cases(["2_level_array"], dtype, vtype, DEFAULT_FLAGS)
    # 3_level_array
    for dtype in BASIC_TYPES:
        vtype = array(array(array(basic(dtype, has_precision_flag(dtype)), 2), 2), 2)
        cases += basic_type_cases(["3_level_array"], dtype, vtype, DEFAULT_FLAGS)
    # 2_level_struct_array
    for is_array in (0, 1):
        base = "instance_array" if is_array else "std"
        n = 2 if is_array else 0
        for stage in ("vertex", "geometry"):
            cases.append(Case(["2_level_struct_array", f"{base}_{stage}"], two_level_struct_array_interface(n), stage == "geometry"))
    # single_basic_type
    for dtype in BASIC_TYPES:
        if not supports_precision(dtype):
            cases += basic_type_cases(["single_basic_type"], dtype, basic(dtype, 0), DEFAULT_FLAGS)
    for prec_name, prec_flag in (("lowp", PRECISION_LOW), ("mediump", PRECISION_MEDIUM), ("highp", PRECISION_HIGH)):
        for dtype in BASIC_TYPES:
            if supports_precision(dtype):
                cases += basic_type_cases(["single_basic_type", prec_name], dtype, basic(dtype, prec_flag), DEFAULT_FLAGS)
    # single_basic_array
    for dtype in BASIC_TYPES:
        cases += basic_type_cases(["single_basic_array"], dtype, array(basic(dtype, has_precision_flag(dtype)), 3), DEFAULT_FLAGS)
    # the struct groups
    for group, make, instances in (
        ("single_struct", single_struct_interface, 3),
        ("single_struct_array", single_struct_array_interface, 2),
        ("single_nested_struct", single_nested_struct_interface, 2),
        ("single_nested_struct_array", single_nested_struct_array_interface, 2),
    ):
        for is_array in (0, 1):
            base = "instance_array" if is_array else "std"
            n = instances if is_array else 0
            for stage in ("vertex", "geometry"):
                cases.append(Case([group, f"{base}_{stage}"], make(n), stage == "geometry"))
    # instance_array_basic_type
    for dtype in BASIC_TYPES:
        cases += basic_type_cases(["instance_array_basic_type"], dtype, basic(dtype, has_precision_flag(dtype)), DEFAULT_FLAGS, 3)
    # multi_basic_types, multi_nested_struct
    for group, make in (("multi_basic_types", multi_basic_types_interface), ("multi_nested_struct", multi_nested_struct_interface)):
        for is_array in (0, 1):
            base = "instance_array" if is_array else "std"
            n = 2 if is_array else 0
            for stage in ("vertex", "geometry"):
                cases.append(Case([group, f"{base}_{stage}"], make(n), stage == "geometry"))
    # various_buffers
    for name, buffer_a, buffer_b, buffer_c in (("000", 0, 0, 0), ("010", 0, 1, 0), ("100", 1, 0, 0), ("110", 1, 1, 0)):
        for is_array in (0, 1):
            base = "buffers" + name + ("_instance_array" if is_array else "")
            n = 2 if is_array else 0
            for stage in ("vertex", "geometry"):
                cases.append(Case(["various_buffers", f"{base}_{stage}"], various_buffers_interface(n, buffer_a, buffer_b, buffer_c), stage == "geometry"))
    # random
    all_basic = FEATURE_VECTORS | FEATURE_MATRICES | FEATURE_DOUBLES
    unused = FEATURE_UNASSIGNED_FIELDS | FEATURE_UNASSIGNED_BLOCK_MEMBERS
    disabled = FEATURE_INSTANCE_ARRAYS | FEATURE_MISSING_BLOCK_MEMBERS | FEATURE_OUT_OF_ORDER_OFFSETS
    all_features = ALL_BITS & ~disabled
    for stage in ("vertex", "geometry"):
        group_name = f"random_{stage}"
        num_cases = 50
        groups = [
            ("scalar_types", num_cases, unused),
            ("vector_types", num_cases, unused | FEATURE_VECTORS),
            ("basic_types", num_cases, unused | all_basic),
            ("basic_arrays", num_cases, unused | all_basic | FEATURE_ARRAYS),
            ("basic_instance_arrays", num_cases, unused | all_basic | FEATURE_INSTANCE_ARRAYS),
            ("nested_structs", num_cases, unused | all_basic | FEATURE_STRUCTS),
            ("nested_structs_arrays", num_cases, unused | all_basic | FEATURE_STRUCTS | FEATURE_ARRAYS),
            ("nested_structs_instance_arrays", num_cases, unused | all_basic | FEATURE_STRUCTS | FEATURE_INSTANCE_ARRAYS),
            ("nested_structs_arrays_instance_arrays", num_cases, unused | all_basic | FEATURE_STRUCTS | FEATURE_ARRAYS | FEATURE_INSTANCE_ARRAYS),
            ("all_instance_array", num_cases * 2, all_features | FEATURE_INSTANCE_ARRAYS),
            ("all_unordered_and_instance_array", num_cases * 2, all_features | FEATURE_OUT_OF_ORDER_OFFSETS | FEATURE_INSTANCE_ARRAYS),
            ("all_missing", num_cases * 2, all_features | FEATURE_MISSING_BLOCK_MEMBERS),
            ("all_unordered_and_missing", num_cases * 2, all_features | FEATURE_OUT_OF_ORDER_OFFSETS | FEATURE_MISSING_BLOCK_MEMBERS),
        ]
        for name, count, features in groups:
            base_seed = de_string_hash(name)
            for ndx in range(count):
                builder = RandomBuilder(features, (ndx + base_seed) & 0xFFFFFFFF)
                cases.append(Case([group_name, name, str(ndx)], builder.interface, stage == "geometry", bool(features & FEATURE_OUT_OF_ORDER_OFFSETS)))
    return cases


def py(value) -> str:
    return json.dumps(repr(value))


def main() -> None:
    cases = all_cases()
    TEMPLATE_DIR.mkdir(parents=True, exist_ok=True)
    (TEMPLATE_DIR / "src_vert.glsl").write_text("${src_vert}")
    (TEMPLATE_DIR / "src_geom.glsl").write_text("${src_geom}")

    by_signature: dict[tuple, str] = {}
    entries = []
    rows = []
    for case in cases:
        signature = (case.vert_src, case.geom_src)
        if signature not in by_signature:
            digest = hashlib.sha1(repr(signature).encode()).hexdigest()[:12]
            const = f"FZ_{digest.upper()}"
            by_signature[signature] = const
            programs = '{ name = "vert", template = "transform_feedback/fuzz/src_vert.glsl", stage = "vert" }'
            derived = f"src_vert = {py(case.vert_src)}"
            if case.geom_src:
                programs += ', { name = "geom", template = "transform_feedback/fuzz/src_geom.glsl", stage = "geom" }'
                derived += f", src_geom = {py(case.geom_src)}"
            entries.append(f'\n[[case]]\nname = "fz_{digest}"\nrust_const = "{const}"\nrust_type = "SharedProgram"\nprograms = [{programs}]\nderived = {{ {derived} }}\n')
        checks = ", ".join(f"({o}, {k}, {v})" for o, k, v in case.checks)
        offsets = ", ".join(str(v) for v in case.tf_offsets)
        sizes = ", ".join(str(v) for v in case.tf_sizes)
        rows.append(
            f'    FuzzCaseDef {{ name: "{".".join(case.path)}", geometry: {str(case.geometry).lower()}, locations_required: {case.locations_required}, '
            f'uses_float64: {str(case.uses_float64).lower()}, tf_offsets: &[{offsets}], tf_sizes: &[{sizes}], data_size: {case.data_size}, '
            f'checks: &[{checks}], programs: &{by_signature[signature]} }},'
        )

    header = (
        "# Shader manifest for dEQP-VK.transform_feedback.fuzz.*\n#\n# @generated by hodow_cts/scripts/gen_xfb_fuzz_cases.py - do not hand-edit.\n#\n"
        "# `InterfaceBlockCase::delayedInit` -> `generateTestShader`, one entry per distinct set of sources.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackFuzzLayoutCase.cpp"\n'
        'rust_module = "transform_feedback/fuzz_tests"\n'
    )
    MANIFEST.write_text(header + "".join(entries))

    lines = [
        "// @generated by hodow_cts/scripts/gen_xfb_fuzz_cases.py - do not hand-edit.",
        "//",
        "// Every case of dEQP-VK.transform_feedback.fuzz.* in upstream's order: the transform feedback buffer bindings `delayedInit` computes, the components",
        "// (offset, kind, expected value) `validateValues` compares and the programs of the manifest it uses. Kinds: 0 float, 1 double, 2 int, 3 uint.",
        "",
        "use crate::generated::shaders::transform_feedback_fuzz::*;",
        "use crate::vkt::tests::transform_feedback::fuzz_tests::FuzzCaseDef;",
        "",
        "pub static FUZZ_CASES: &[FuzzCaseDef] = &[",
    ] + rows + ["];"]
    CASE_TABLE.write_text("\n".join(lines) + "\n")
    print(f"{len(cases)} cases, {len(entries)} program sets -> {MANIFEST}")

    if len(sys.argv) == 3 and sys.argv[1] == "--check-names":
        expected = set()
        for line in Path(sys.argv[2]).read_text().splitlines():
            if line.startswith("dEQP-VK.transform_feedback.fuzz."):
                expected.add(line[len("dEQP-VK.transform_feedback.fuzz."):])
        got = {".".join(case.path) for case in cases}
        print(f"mustpass {len(expected)}, generated {len(got)}, missing {len(expected - got)}, extra {len(got - expected)}")
        for name in sorted(expected - got)[:10]:
            print("  missing", name)
        for name in sorted(got - expected)[:10]:
            print("  extra", name)


if __name__ == "__main__":
    main()

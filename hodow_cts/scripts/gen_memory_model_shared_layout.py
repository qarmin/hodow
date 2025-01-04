#!/usr/bin/env python3
"""Writes shaders/manifest/memory_model_shared_layout.toml: the GLSL compute shaders of dEQP-VK.memory_model.shared.*.

Upstream builds every case's shader at run time from a random layout (`RandomSharedLayoutCase`, vktMemoryModelSharedLayout.cpp) and the
values it writes into shared memory and compares (`SharedLayoutCase::delayedInit`, vktMemoryModelSharedLayoutCase.cpp). Both are driven by
`de::Random` with seeds that do not depend on the run, so this replays the draws in the same order and writes the 210 resulting shaders.
The comparison functions are read out of upstream's vktTypeComparisonUtil.cpp when it is available (`--cts-dir`), so they cannot drift.

    python3 hodow_cts/scripts/gen_memory_model_shared_layout.py [--cts-dir ../tmp/VK-GL-CTS]

A pure text generator: no glslang and no cargo.
"""

import argparse
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from de_random import DeRandom, de_string_hash, to_f32  # noqa: E402

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "memory_model_shared_layout.toml"
COMPARE_SOURCE = "external/vulkancts/modules/vulkan/util/vktTypeComparisonUtil.cpp"

FEATURE_VECTORS = 1 << 0
FEATURE_MATRICES = 1 << 1
FEATURE_ARRAYS = 1 << 2
FEATURE_STRUCTS = 1 << 3
FEATURE_UNUSED_VARS = 1 << 4
FEATURE_UNUSED_MEMBERS = 1 << 5
FEATURE_ARRAYS_OF_ARRAYS = 1 << 6
FEATURE_16BIT_TYPES = 1 << 7
FEATURE_8BIT_TYPES = 1 << 8

MAX_SHARED_OBJECTS = 3
MAX_SHARED_OBJECT_MEMBERS = 4
MAX_STRUCT_MEMBERS = 3

# (enum name without TYPE_, GLSL name, scalar kind, columns, rows) in the order of glu::DataType, which is the order the comparison
# functions are written in.
TYPES = []


def add_type(key, name, scalar, columns, rows):
    TYPES.append((key, name, scalar, columns, rows))


add_type("FLOAT", "float", "float", 1, 1)
for size in (2, 3, 4):
    add_type(f"FLOAT_VEC{size}", f"vec{size}", "float", 1, size)
for columns, rows in ((2, 2), (2, 3), (2, 4), (3, 2), (3, 3), (3, 4), (4, 2), (4, 3), (4, 4)):
    suffix = f"{columns}" if columns == rows else f"{columns}x{rows}"
    add_type(f"FLOAT_MAT{suffix.upper()}", f"mat{suffix}", "float", columns, rows)
for kind, prefix in (("INT", "i"), ("UINT", "u"), ("BOOL", "b")):
    add_type(kind, kind.lower(), kind.lower(), 1, 1)
    for size in (2, 3, 4):
        add_type(f"{kind}_VEC{size}", f"{prefix}vec{size}", kind.lower(), 1, size)
for bits in (8, 16):
    for kind, prefix in (("UINT", "u"), ("INT", "i")):
        add_type(f"{kind}{bits}", f"{kind.lower()}{bits}_t", f"{kind.lower()}{bits}", 1, 1)
        for size in (2, 3, 4):
            add_type(f"{kind}{bits}_VEC{size}", f"{prefix}{bits}vec{size}", f"{kind.lower()}{bits}", 1, size)
add_type("FLOAT16", "float16_t", "float16", 1, 1)
for size in (2, 3, 4):
    add_type(f"FLOAT16_VEC{size}", f"f16vec{size}", "float16", 1, size)

TYPE_BY_KEY = {key: (index, name, scalar, columns, rows) for index, (key, name, scalar, columns, rows) in enumerate(TYPES)}
EXPLICIT_PRECISION_SCALARS = {"uint8", "int8", "uint16", "int16", "float16"}

PROMOTED = {
    "UINT8": "UINT", "UINT8_VEC2": "UINT_VEC2", "UINT8_VEC3": "UINT_VEC3", "UINT8_VEC4": "UINT_VEC4",
    "INT8": "INT", "INT8_VEC2": "INT_VEC2", "INT8_VEC3": "INT_VEC3", "INT8_VEC4": "INT_VEC4",
    "UINT16": "UINT", "UINT16_VEC2": "UINT_VEC2", "UINT16_VEC3": "UINT_VEC3", "UINT16_VEC4": "UINT_VEC4",
    "INT16": "INT", "INT16_VEC2": "INT_VEC2", "INT16_VEC3": "INT_VEC3", "INT16_VEC4": "INT_VEC4",
    "FLOAT16": "FLOAT", "FLOAT16_VEC2": "FLOAT_VEC2", "FLOAT16_VEC3": "FLOAT_VEC3", "FLOAT16_VEC4": "FLOAT_VEC4",
}

SCALAR_TYPE = {  # scalar kind -> the type key of its generateValue branch
    "float": "float", "float16": "float", "int": "int", "int8": "int", "int16": "int", "uint": "uint", "uint8": "uint", "uint16": "uint", "bool": "bool",
}


def type_name(key):
    return TYPE_BY_KEY[key][1]


def scalar_size(key):
    _, _, _, columns, rows = TYPE_BY_KEY[key]
    return columns * rows


def is_matrix(key):
    return TYPE_BY_KEY[key][3] > 1


def supports_precision(key):
    _, _, scalar, _, _ = TYPE_BY_KEY[key]
    return scalar != "bool" and scalar not in EXPLICIT_PRECISION_SCALARS


class Basic:
    def __init__(self, key, precision):
        self.key = key
        self.precision = precision


class ArrayOf:
    def __init__(self, element, size):
        self.element = element
        self.size = size


class Struct:
    def __init__(self, name):
        self.name = name
        self.members = []


def parse_compare_functions(cts_dir):
    """`getCompareFuncForType` of vktTypeComparisonUtil.cpp as {type key: source}."""
    text = (Path(cts_dir) / COMPARE_SOURCE).read_text(encoding="utf-8")
    body = text[text.index("getCompareFuncForType") : text.index("getCompareDependencies")]
    functions = {}
    for match in re.finditer(r"case glu::TYPE_(\w+):\s*return((?:\s*\"(?:[^\"\\]|\\.)*\")+);", body):
        pieces = re.findall(r"\"((?:[^\"\\]|\\.)*)\"", match.group(2))
        functions[match.group(1)] = "".join(pieces).replace("\\n", "\n")
    return functions


def gen_name(first, last, index):
    text = ""
    alphabet = ord(last) - ord(first) + 1
    while index > 0:
        text = chr(ord(first) + (index - 1) % alphabet) + text
        index = (index - 1) // alphabet
    return text


def get_bool(rnd):
    return (rnd.get_uint32() & 0xFFFFFF) < 0x800000


def choose(rnd, items):
    chosen = items[0]
    for index in range(1, len(items)):
        if rnd.get_int(0, index) < 1:
            chosen = items[index]
    return chosen


class RandomLayout:
    def __init__(self, features, seed):
        self.features = features
        self.max_array_length = 3 if features & FEATURE_ARRAYS else 0
        self.structs = []
        self.objects = []
        rnd = DeRandom(seed)
        # The loop bound is drawn again on every iteration, like the C++ condition.
        index = 0
        while index < rnd.get_int(1, MAX_SHARED_OBJECTS):
            self.generate_object(rnd)
            index += 1

    def generate_object(self, rnd):
        number = len(self.objects) + 1
        members = []
        count = rnd.get_int(2, MAX_SHARED_OBJECT_MEMBERS)
        for _ in range(count):
            name = gen_name("a", "z", len(members) + 1)
            depth = 3 if self.features & (FEATURE_ARRAYS_OF_ARRAYS | FEATURE_STRUCTS) else 1
            members.append([name, self.generate_type(rnd, depth, True), None])
        for member in members:
            member[2] = member[1].size if isinstance(member[1], ArrayOf) else 1
        self.objects.append((f"S{number}", f"s{number}", members))

    def generate_type(self, rnd, depth, array_ok):
        if depth > 0 and rnd.get_float() < to_f32(0.7) and self.features & FEATURE_STRUCTS:
            member_types = [self.generate_type(rnd, depth - 1, True) for _ in range(rnd.get_int(1, MAX_STRUCT_MEMBERS))]
            struct = Struct("s" + gen_name("A", "Z", len(self.structs) + 1))
            self.structs.append(struct)
            for index, member_type in enumerate(member_types):
                struct.members.append((f"m{chr(ord('A') + index)}", member_type))
            return struct
        if depth > 0 and self.max_array_length > 0 and array_ok and rnd.get_float() < to_f32(0.8):
            length = rnd.get_int(1, self.max_array_length)
            child_array_ok = bool(self.features & FEATURE_ARRAYS_OF_ARRAYS)
            return ArrayOf(self.generate_type(rnd, depth - 1, child_array_ok), length)

        weight8 = to_f32(0.7) if self.features & FEATURE_8BIT_TYPES else 0.0
        weight16 = to_f32(0.7) if self.features & FEATURE_16BIT_TYPES else 0.0
        weight_matrices = to_f32(0.3) if self.features & FEATURE_MATRICES else 0.0
        vectors = bool(self.features & FEATURE_VECTORS)

        candidates = []
        if rnd.get_float() < weight16:
            candidates += ["UINT16", "INT16", "FLOAT16"]
            if vectors:
                candidates += [f"{kind}_VEC{size}" for kind in ("FLOAT16", "INT16", "UINT16") for size in (2, 3, 4)]
        elif rnd.get_float() < weight8:
            candidates += ["UINT8", "INT8"]
            if vectors:
                candidates += [f"{kind}_VEC{size}" for kind in ("INT8", "UINT8") for size in (2, 3, 4)]
        else:
            candidates += ["FLOAT", "INT", "UINT", "BOOL"]
            if vectors:
                candidates += [f"{kind}_VEC{size}" for kind in ("FLOAT", "INT", "UINT", "BOOL") for size in (2, 3, 4)]

        if rnd.get_float() < weight_matrices:
            candidates += ["FLOAT_MAT2", "FLOAT_MAT2X3", "FLOAT_MAT3X2", "FLOAT_MAT3", "FLOAT_MAT3X4", "FLOAT_MAT4X2", "FLOAT_MAT4X3", "FLOAT_MAT4"]

        key = choose(rnd, candidates)
        precision = choose(rnd, ["lowp", "mediump", "highp"]) if supports_precision(key) else None
        return Basic(key, precision)


def declare_type_name(vartype):
    if isinstance(vartype, Basic):
        prefix = f"{vartype.precision} " if vartype.precision is not None and TYPE_BY_KEY[vartype.key][2] != "float16" else ""
        return prefix + type_name(vartype.key)
    return vartype.name


def declare_variable(vartype, name):
    sizes = []
    while isinstance(vartype, ArrayOf):
        sizes.append(vartype.size)
        vartype = vartype.element
    return f"{declare_type_name(vartype)} {name}" + "".join(f"[{size}]" for size in sizes)


def declare_struct(struct):
    text = f"struct {struct.name}\n{{\n"
    for name, member_type in struct.members:
        text += "\t" + declare_variable(member_type, name) + ";\n"
    return text + "}"


def reference_layout(vartype, entries):
    if isinstance(vartype, Basic):
        entries.append((vartype.key, 1))
    elif isinstance(vartype, ArrayOf):
        if isinstance(vartype.element, Basic):
            entries.append((vartype.element.key, vartype.size))
        else:
            for _ in range(vartype.size):
                reference_layout(vartype.element, entries)
    else:
        for _, member_type in vartype.members:
            reference_layout(member_type, entries)


def generate_values(entry, rnd, values):
    key, array_size = entry
    _, _, scalar, columns, rows = TYPE_BY_KEY[key]
    for _ in range(array_size):
        for _ in range(columns):
            for _ in range(rows):
                kind = SCALAR_TYPE[scalar]
                if kind == "int":
                    values.append(str(rnd.get_int(-9, 9)))
                elif kind == "uint":
                    values.append(str(rnd.get_int(0, 9)) + "u")
                elif kind == "float":
                    values.append(f"{float(rnd.get_int(-9, 9)):.1f}")
                else:
                    values.append("true" if get_bool(rnd) else "false")


def member_path(path):
    return "".join(path)


def shared_memory_writes(lines, instance, vartype, path, values, compare):
    if isinstance(vartype, ArrayOf):
        for index in range(vartype.size):
            shared_memory_writes(lines, instance, vartype.element, path + [f"[{index}]"], values, compare)
    elif isinstance(vartype, Struct):
        for name, member_type in vartype.members:
            shared_memory_writes(lines, instance, member_type, path + [f".{name}"], values, compare)
    else:
        key = vartype.key
        name = type_name(key)
        promote = PROMOTED.get(key, key)
        elements = scalar_size(key)
        access = instance + member_path(path)
        wrap = key != promote or elements > 1
        line = "\t"
        if compare:
            line += f"allOk = compare_{name}("
            if wrap:
                line += type_name(promote) + "("
        else:
            line += f"{access} = "
            if wrap:
                line += name + "("
        line += ", ".join(next(values) for _ in range(elements))
        if wrap:
            line += ")"
        if compare:
            if key != promote:
                line += f", {type_name(promote)}({access})) && allOk"
            else:
                line += f", {access}) && allOk"
        lines.append(line + ";\n")


def collect_basic_types(vartype, found):
    if isinstance(vartype, Struct):
        for _, member_type in vartype.members:
            collect_basic_types(member_type, found)
    elif isinstance(vartype, ArrayOf):
        collect_basic_types(vartype.element, found)
    else:
        found.add(vartype.key)


def compare_dependencies(key, wanted):
    scalar = TYPE_BY_KEY[key][2]
    columns, rows = TYPE_BY_KEY[key][3], TYPE_BY_KEY[key][4]
    if columns == 1 and rows > 1 and scalar in ("float", "float16"):
        wanted.update(["FLOAT", key])
    elif columns > 1:
        wanted.update(["FLOAT", f"FLOAT_VEC{rows}", key])
    else:
        wanted.add(key)


def shader_source(layout, name, compare_functions):
    bits16 = bool(layout.features & FEATURE_16BIT_TYPES)
    bits8 = bool(layout.features & FEATURE_8BIT_TYPES)

    # entryValues: every variable gets topLevelArraySize repetitions of its reference layout, drawn in declaration order.
    rnd = DeRandom(de_string_hash(name) ^ 0xAD2F7214)
    object_values = []
    for _, _, members in layout.objects:
        member_values = []
        for _, vartype, top_level_size in members:
            entries = []
            reference_layout(vartype.element if isinstance(vartype, ArrayOf) else vartype, entries)
            values = []
            for _ in range(top_level_size):
                for entry in entries:
                    generate_values(entry, rnd, values)
            member_values.append(values)
        object_values.append(member_values)

    src = "#version 450\n"
    if bits16:
        src += "#extension GL_EXT_shader_explicit_arithmetic_types : enable\n"
    if bits8:
        src += "#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable\n"
    src += "layout(local_size_x = 1) in;\n\n"
    src += "layout(std140, binding = 0) buffer block { highp uint passed; };\n"
    for struct in layout.structs:
        src += declare_struct(struct) + ";\n"
    for struct_name, _, members in layout.objects:
        src += f"struct {struct_name} {{\n"
        for member_name, vartype, _ in members:
            src += "\t" + declare_variable(vartype, member_name) + ";\n"
        src += "};\n"

    src += "\n"
    types = set()
    for _, _, members in layout.objects:
        for _, vartype, _ in members:
            collect_basic_types(vartype, types)
    wanted = set()
    for key in types:
        compare_dependencies(key, wanted)
    for key, _, _, _, _ in TYPES:
        if key in wanted:
            src += compare_functions[key]

    src += "\n"
    for struct_name, instance, _ in layout.objects:
        src += f"shared {struct_name} {instance};\n"
    src += "\nvoid main (void) {\n"

    for compare in (False, True):
        if compare:
            src += "\n\tbarrier();\n\tmemoryBarrier();\n\tbool allOk = true;\n"
        for (_, instance, members), member_values in zip(layout.objects, object_values):
            for (member_name, vartype, _), values in zip(members, member_values):
                lines = []
                iterator = iter(values)
                shared_memory_writes(lines, instance, vartype, [f".{member_name}"], iterator, compare)
                src += "".join(lines)

    src += "\tif (allOk)\n\t\tpassed++;\n\n}\n"
    return src


def toml_string(text):
    return json.dumps(text, ensure_ascii=False)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cts-dir", default=str(CRATE.parent / "tmp" / "VK-GL-CTS"))
    args = parser.parse_args()
    compare_functions = parse_compare_functions(args.cts_dir)

    all_basic = FEATURE_VECTORS | FEATURE_MATRICES
    unused = FEATURE_UNUSED_MEMBERS | FEATURE_UNUSED_VARS
    groups = [
        ("scalar_types", unused, 0),
        ("vector_types", unused | FEATURE_VECTORS, 25),
        ("basic_types", unused | all_basic, 50),
        ("basic_arrays", unused | all_basic | FEATURE_ARRAYS, 50),
        ("arrays_of_arrays", unused | all_basic | FEATURE_ARRAYS | FEATURE_ARRAYS_OF_ARRAYS, 950),
        ("nested_structs", unused | all_basic | FEATURE_STRUCTS, 100),
        ("nested_structs_arrays", unused | all_basic | FEATURE_STRUCTS | FEATURE_ARRAYS | FEATURE_ARRAYS_OF_ARRAYS, 150),
    ]

    out = [
        "# Shader manifest for dEQP-VK.memory_model.shared.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_memory_model_shared_layout.py - do not hand-edit; the layouts are drawn from upstream's seeds.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/memory_model/vktMemoryModelSharedLayout.cpp"\n'
        'rust_module = "memory_model/shared_layout_tests"\n'
    ]
    written = 0
    for variant, extra in (("", 0), ("16bit", FEATURE_16BIT_TYPES), ("8bit", FEATURE_8BIT_TYPES)):
        for group, features, base_seed in groups:
            for index in range(10):
                features_used = features | extra
                case_name = str(index)
                layout = RandomLayout(features_used, index + base_seed)
                source = shader_source(layout, case_name, compare_functions)
                path = "/".join(part for part in (variant, group, case_name) if part)
                const = "SHARED_" + "".join(c if c.isalnum() else "_" for c in path).upper()
                width = 16 if extra == FEATURE_16BIT_TYPES else 8 if extra == FEATURE_8BIT_TYPES else 0
                out.append(
                    f'\n[[case]]\nname = {toml_string(path)}\nrust_const = "{const}"\nrust_type = "SharedLayoutCase"\n'
                    'programs = [ { name = "compute", template = "glsl/source.comp", stage = "comp" } ]\n'
                    f'params = {{ bits = {{ type = "u32", value = {width} }} }}\n'
                    f"derived = {{ source_comp = {json.dumps(repr(source), ensure_ascii=False)} }}\n"
                )
                written += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {written} cases")


if __name__ == "__main__":
    main()

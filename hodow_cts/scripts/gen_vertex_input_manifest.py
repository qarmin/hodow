#!/usr/bin/env python3
"""Writes the shader manifest and the case table of dEQP-VK.pipeline.*.vertex_input.{single_attribute,multiple_attributes,max_attributes,
component_mismatch} (`VertexInputTest`, vktPipelineVertexInputTests.cpp).

Three outputs:
  - shaders/manifest/pipeline_vertex_input.toml: one vertex + fragment program per distinct vertex shader (`VertexInputTest::initPrograms`,
    replayed here from the same C++ logic: `getGlslInputDeclarations`, `getGlslVertexCheck`, `getGlslAttributeConditions`, the thresholds of
    `getFormatThreshold`), found by the `key` of a case;
  - src/vkt/tests/pipeline/vertex_input_cases.rs: every case of the four groups (`createSingleAttributeTests`, `createMultipleAttributeTests`
    with its de::Random(102030) draws, `createMaxAttributeTests` with de::Random(132030), `createComponentMismatchTests`);
  - src/vkt/tests/pipeline/vertex_input_formats.rs: the tables of vktPipelineVertexUtil.cpp, parsed out of upstream's own source.

A pure text generator: no glslang and no cargo.
"""

import hashlib
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from de_random import DeRandom, to_f32  # noqa: E402

CRATE = Path(__file__).resolve().parent.parent
PIPELINE_DIR = CRATE / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "pipeline"
UTIL_CPP = PIPELINE_DIR / "vktPipelineVertexUtil.cpp"
TESTS_CPP = PIPELINE_DIR / "vktPipelineVertexInputTests.cpp"
MANIFEST = CRATE / "shaders" / "manifest" / "pipeline_vertex_input.toml"
CASES_RS = CRATE / "src" / "vkt" / "tests" / "pipeline" / "vertex_input_cases.rs"
FORMATS_RS = CRATE / "src" / "vkt" / "tests" / "pipeline" / "vertex_input_formats.rs"

K_MAX_COMPONENTS = 4

# (name, vertexInputComponentCount, vertexInputCount, basic type)
GLSL_TYPES = [
    ("int", 1, 1, "int"), ("ivec2", 2, 1, "int"), ("ivec3", 3, 1, "int"), ("ivec4", 4, 1, "int"),
    ("uint", 1, 1, "uint"), ("uvec2", 2, 1, "uint"), ("uvec3", 3, 1, "uint"), ("uvec4", 4, 1, "uint"),
    ("float", 1, 1, "float"), ("vec2", 2, 1, "float"), ("vec3", 3, 1, "float"), ("vec4", 4, 1, "float"),
    ("float16_t", 1, 1, "float16"), ("f16vec2", 2, 1, "float16"), ("f16vec3", 3, 1, "float16"), ("f16vec4", 4, 1, "float16"),
    ("mat2", 2, 2, "float"), ("mat3", 3, 3, "float"), ("mat4", 4, 4, "float"),
    ("double", 1, 1, "double"), ("dvec2", 2, 1, "double"), ("dvec3", 3, 1, "double"), ("dvec4", 4, 1, "double"),
    ("dmat2", 2, 2, "double"), ("dmat3", 3, 3, "double"), ("dmat4", 4, 4, "double"),
]
GLSL_DOUBLE = 19
GLSL_MAT2 = 16

EXPAND_TO_FULL = {
    "int": "ivec4", "ivec2": "ivec4", "ivec3": "ivec4", "ivec4": "ivec4",
    "uint": "uvec4", "uvec2": "uvec4", "uvec3": "uvec4", "uvec4": "uvec4",
    "float": "vec4", "vec2": "vec4", "vec3": "vec4", "vec4": "vec4",
    "float16_t": "f16vec4", "f16vec2": "f16vec4", "f16vec3": "f16vec4", "f16vec4": "f16vec4",
    "mat2": "mat2x4", "mat3": "mat3x4", "mat4": "mat4",
}

FLAGS = ["BGR", "ABGR", "ARGB", "SINT", "UINT", "SFLOAT", "UFLOAT", "UNORM", "SNORM", "SRGB", "SSCALED", "USCALED", "DOUBLE", "PACKED"]
BOOL_FUNCTIONS = {
    "isVertexFormatComponentOrderBGR": "BGR", "isVertexFormatComponentOrderABGR": "ABGR", "isVertexFormatComponentOrderARGB": "ARGB",
    "isVertexFormatSint": "SINT", "isVertexFormatUint": "UINT", "isVertexFormatSfloat": "SFLOAT", "isVertexFormatUfloat": "UFLOAT",
    "isVertexFormatUnorm": "UNORM", "isVertexFormatSnorm": "SNORM", "isVertexFormatSRGB": "SRGB", "isVertexFormatSscaled": "SSCALED",
    "isVertexFormatUscaled": "USCALED", "isVertexFormatDouble": "DOUBLE", "isVertexFormatPacked": "PACKED",
}


def rust_format(name: str) -> str:
    return name.removeprefix("VK_FORMAT_").removesuffix("_EXT")


def parse_util():
    """The vertex format tables of vktPipelineVertexUtil.cpp as {format: {size, comps, comp_size, widths, flags}}."""
    text = UTIL_CPP.read_text()
    bodies = {}
    matches = list(re.finditer(r"^(?:uint32_t|bool) (\w+)\(", text, re.M))
    for i, m in enumerate(matches):
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        bodies[m.group(1)] = text[m.end():end]

    info = {}

    def entry(fmt):
        return info.setdefault(fmt, {"size": None, "comps": None, "comp_size": None, "widths": None, "flags": set()})

    for func, key in (("getVertexFormatSize", "size"), ("getVertexFormatComponentCount", "comps"), ("getVertexFormatComponentSize", "comp_size")):
        labels = []
        for line in bodies[func].splitlines():
            line = line.strip()
            m = re.match(r"case (VK_FORMAT_\w+):", line)
            if m:
                labels.append(m.group(1))
                continue
            m = re.match(r"return (\d+);", line)
            if m:
                for fmt in labels:
                    entry(fmt)[key] = int(m.group(1))
                labels = []

    labels = []
    arrays = None
    for line in bodies["getPackedVertexFormatComponentWidth"].splitlines():
        line = line.strip()
        m = re.match(r"case (VK_FORMAT_\w+):", line)
        if m:
            labels.append(m.group(1))
            continue
        m = re.match(r"uint32_t componentSizes\[\d\] = \{([^}]*)\};", line)
        if m:
            arrays = [int(v) for v in m.group(1).split(",")]
            continue
        m = re.match(r"return componentSizes\[componentNdx\];", line)
        if m:
            for fmt in labels:
                entry(fmt)["widths"] = (arrays + [0, 0, 0, 0])[:4]
            labels, arrays = [], None
            continue
        m = re.match(r"return (\d+);", line)
        if m and labels:
            for fmt in labels:
                entry(fmt)["widths"] = [int(m.group(1))] * 4
            labels = []

    for func, flag in BOOL_FUNCTIONS.items():
        labels = []
        for line in bodies[func].splitlines():
            line = line.strip()
            m = re.match(r"case (VK_FORMAT_\w+):", line)
            if m:
                labels.append(m.group(1))
            elif line == "return true;":
                for fmt in labels:
                    entry(fmt)["flags"].add(flag)
                labels = []
    return info


UTIL = parse_util()


def f32(value):
    return to_f32(value)


def size_of(fmt):
    return UTIL[fmt]["size"]


def comp_count(fmt):
    return UTIL[fmt]["comps"]


def comp_size(fmt):
    return UTIL[fmt]["comp_size"]


def has(fmt, flag):
    return flag in UTIL[fmt]["flags"]


def packed_width(fmt, ndx):
    return UTIL[fmt]["widths"][ndx]


def repr_unorm(fmt):
    return f32(1.0 / f32(float((1 << (comp_size(fmt) * 8)) - 1)))


def repr_unorm_packed(fmt, ndx):
    return f32(1.0 / f32(float((1 << packed_width(fmt, ndx)) - 1)))


def repr_snorm(fmt):
    return f32(1.0 / f32(float((1 << (comp_size(fmt) * 8 - 1)) - 1)))


def repr_snorm_packed(fmt, ndx):
    return f32(1.0 / f32(float((1 << (packed_width(fmt, ndx) - 1)) - 1)))


def format_threshold(fmt):
    if fmt in ("VK_FORMAT_R32_SFLOAT", "VK_FORMAT_R32G32_SFLOAT", "VK_FORMAT_R32G32B32_SFLOAT", "VK_FORMAT_R32G32B32A32_SFLOAT",
               "VK_FORMAT_R64_SFLOAT", "VK_FORMAT_R64G64_SFLOAT", "VK_FORMAT_R64G64B64_SFLOAT", "VK_FORMAT_R64G64B64A64_SFLOAT"):
        return [f32(0.00001)] * 4
    if has(fmt, "SNORM"):
        if has(fmt, "PACKED"):
            return [f32(1.5 * repr_snorm_packed(fmt, i)) for i in range(4)]
        return [f32(1.5 * repr_snorm(fmt))] * 4
    if has(fmt, "UNORM"):
        if has(fmt, "PACKED"):
            return [f32(1.5 * repr_unorm_packed(fmt, i)) for i in range(4)]
        return [f32(1.5 * repr_unorm(fmt))] * 4
    if has(fmt, "UFLOAT"):
        return [f32(0.008)] * 4
    return [f32(0.001)] * 4


def fx(value):
    return "%f" % value


def attribute_conditions(attr, attribute_index, query_max, missing):
    glsl_type, fmt, rate = attr
    name, component_count, vertex_input_count, basic = GLSL_TYPES[glsl_type]
    total = component_count * vertex_input_count
    threshold = format_threshold(fmt)
    index_str = f"[{attribute_index}]" if query_max else attribute_index
    indent = "\t\t" if query_max else "\t"
    component_index = 0
    bgr = [2, 1, 0, 3]
    abgr = [3, 2, 1, 0]
    argb = [1, 2, 3, 0]
    index_id = "index" if query_max else ("gl_VertexIndex" if rate == "vertex" else "gl_InstanceIndex")
    attribute_var = f"attr{index_str}"
    out = []
    for column in range(vertex_input_count):
        for row in range(K_MAX_COMPONENTS):
            if has(fmt, "ABGR"):
                order = abgr[row]
            elif has(fmt, "ARGB"):
                order = argb[row]
            else:
                order = bgr[row]

            access = attribute_var
            if vertex_input_count == 1:
                if component_count > 1 or missing:
                    access += f"[{row}]"
            else:
                access += f"[{column}][{row}]"

            if row < component_count and not missing:
                packed = has(fmt, "PACKED")
                if has(fmt, "SINT"):
                    if packed:
                        max_int = (1 << (packed_width(fmt, order) - 1)) - 1
                        min_int = -max_int
                        out.append(f"{indent}if ({access} == clamp(-({total} * {index_id} + {component_index}), {min_int}, {max_int}))\n")
                    else:
                        out.append(f"{indent}if ({access} == -({total} * {index_id} + {component_index}))\n")
                elif has(fmt, "UINT"):
                    if packed:
                        max_uint = (1 << packed_width(fmt, order)) - 1
                        out.append(f"{indent}if ({access} == clamp(uint({total} * {index_id} + {component_index}), 0, {max_uint}))\n")
                    else:
                        out.append(f"{indent}if ({access} == uint({total} * {index_id} + {component_index}))\n")
                elif has(fmt, "SFLOAT"):
                    if basic == "double":
                        out.append(f"{indent}if (abs({access} + double(0.01 * ({total}.0 * float({index_id}) + {component_index}.0))) < double({fx(threshold[row])}))\n")
                    elif basic == "float16":
                        out.append(f"{indent}if (abs({access} + float16_t(0.01HF * ({total}.0HF * float16_t({index_id}) + {component_index}.0HF))) < float16_t({fx(threshold[row])}HF))\n")
                    else:
                        out.append(f"{indent}if (abs({access} + (0.01 * ({total}.0 * float({index_id}) + {component_index}.0))) < {fx(threshold[row])})\n")
                elif has(fmt, "SSCALED"):
                    if packed:
                        max_scaled = f32(float((1 << (packed_width(fmt, order) - 1)) - 1))
                        min_scaled = f32(-max_scaled - 1.0)
                        out.append(f"{indent}if (abs({access} + clamp({total}.0 * float({index_id}) + {component_index}.0, {fx(min_scaled)}, {fx(max_scaled)})) < {fx(threshold[order])})\n")
                    else:
                        out.append(f"{indent}if (abs({access} + ({total}.0 * float({index_id}) + {component_index}.0)) < {fx(threshold[row])})\n")
                elif has(fmt, "USCALED"):
                    if packed:
                        max_scaled = f32(float((1 << packed_width(fmt, order)) - 1))
                        out.append(f"{indent}if (abs({access} - clamp({total}.0 * float({index_id}) + {component_index}.0, 0, {fx(max_scaled)})) < {fx(threshold[order])})\n")
                    else:
                        out.append(f"{indent}if (abs({access} - ({total}.0 * float({index_id}) + {component_index}.0)) < {fx(threshold[row])})\n")
                elif has(fmt, "SNORM"):
                    diff = repr_snorm_packed(fmt, order) if packed else repr_snorm(fmt)
                    if packed:
                        out.append(f"{indent}if (abs({access} - clamp((-1.0 + {fx(diff)} * ({total}.0 * float({index_id}) + {component_index}.0)), -1.0, 1.0)) < {fx(threshold[order])})\n")
                    else:
                        out.append(f"{indent}if (abs({access} - (-1.0 + {fx(diff)} * ({total}.0 * float({index_id}) + {component_index}.0))) < {fx(threshold[row])})\n")
                elif has(fmt, "UNORM") or has(fmt, "SRGB"):
                    diff = repr_unorm_packed(fmt, order) if packed else repr_unorm(fmt)
                    if packed:
                        out.append(f"{indent}if (abs({access} - clamp(({fx(diff)} * ({total}.0 * float({index_id}) + {component_index}.0)), 0.0, 1.0)) < {fx(threshold[order])})\n")
                    else:
                        out.append(f"{indent}if (abs({access} - ({fx(diff)} * ({total}.0 * float({index_id}) + {component_index}.0))) < {fx(threshold[row])})\n")
                elif has(fmt, "UFLOAT"):
                    if basic == "double":
                        out.append(f"{indent}if (abs({access} - double(0.01 * ({total}.0 * float({index_id}) + {component_index}.0))) < double({fx(threshold[row])}))\n")
                    elif basic == "float16":
                        out.append(f"{indent}if (abs({access} - float16_t(0.01HF * ({total}.0HF * float16_t({index_id}) + {component_index}.0HF))) < float16_t({fx(threshold[row])}HF))\n")
                    else:
                        out.append(f"{indent}if (abs({access} - (0.01 * ({total}.0 * float({index_id}) + {component_index}.0))) < ({fx(threshold[row])}))\n")
                else:
                    raise SystemExit(f"unclassified vertex format {fmt}")
                out.append(f"{indent}\tokCount++;\n\n")
                component_index += 1
            elif row >= component_count and missing:
                expected = 1 if row == K_MAX_COMPONENTS - 1 else 0
                glsl = {"int": "int", "uint": "uint", "float": "float", "double": "double", "float16": "float16_t"}[basic]
                out.append(f"{indent}if ({access} == {glsl}({expected}))\n")
                out.append(f"{indent}\tokCount++;\n\n")
    return "".join(out)


def vertex_check(attrs, query_max, missing):
    out = ["    int okCount = 0;\n"]
    if query_max:
        attr = (GLSL_TYPES.index(next(t for t in GLSL_TYPES if t[0] == "vec4")), "VK_FORMAT_R8G8B8A8_SNORM", "vertex")
        out.append("    for (int checkNdx = 1; checkNdx < numAttributes; checkNdx++)\n    {\n        uint index = (checkNdx % 2 == 0) ? gl_VertexIndex : gl_InstanceIndex;\n")
        out.append(attribute_conditions(attr, "checkNdx-1", True, False) + "    }\n")
        _, comps, count, _ = GLSL_TYPES[attr[0]]
        input_count = f"{count * comps} * (numAttributes-1)"
    else:
        total = 0
        for i, attr in enumerate(attrs):
            out.append(attribute_conditions(attr, str(i), False, missing))
            _, comps, count, _ = GLSL_TYPES[attr[0]]
            total += count * (comps if not missing else K_MAX_COMPONENTS - comps)
        input_count = str(total)
    out.append(
        f"    if (okCount == {input_count})\n"
        "    {\n"
        "        if (gl_InstanceIndex == 0)\n"
        "            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);\n"
        "        else\n"
        "            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "    }\n"
        "    else\n"
        "    {\n"
        f"        vtxColor = vec4(okCount / float({input_count}), 0.0f, 0.0f, 1.0);\n"
        "    }\n\n"
        "    if (gl_InstanceIndex == 0)\n"
        "    {\n"
        "        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n"
        "        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);\n"
        "        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n"
        "        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);\n"
        "        else gl_Position = vec4(0.0);\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);\n"
        "        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);\n"
        "        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);\n"
        "        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);\n"
        "        else gl_Position = vec4(0.0);\n"
        "    }\n"
    )
    return "".join(out)


def consumed_locations(attr):
    glsl_type, fmt, _ = attr
    if GLSL_TYPES[glsl_type][0] in ("dmat2", "dmat3", "dmat4") and fmt in ("VK_FORMAT_R64G64B64_SFLOAT", "VK_FORMAT_R64G64B64A64_SFLOAT"):
        return 2
    return 1


def locations(attrs, skip, out_of_order):
    needed = []
    location = 0
    for attr in attrs:
        previous = location
        location += GLSL_TYPES[attr[0]][2] * consumed_locations(attr)
        if skip:
            location += 1
        needed.append(location - previous)
    if not out_of_order:
        result, loc = [], 0
        for n in needed:
            result.append(loc)
            loc += n
        return result
    indices = [i for i in range(len(attrs)) if i % 2 == 0] + [i for i in range(len(attrs)) if i % 2 != 0]
    slots, slot = [], 0
    for i in indices:
        slots.append(slot)
        slot += needed[i]
    result = []
    for ndx in range(len(attrs)):
        slot_idx = 0
        for i, idx in enumerate(indices):
            if ndx == idx:
                slot_idx = i
        result.append(slots[slot_idx])
    return result


def vertex_source(attrs, skip, out_of_order, missing, query_max):
    uses_f16 = any(GLSL_TYPES[a[0]][3] == "float16" for a in attrs)
    extensions = "#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require\n" if uses_f16 else ""
    if query_max:
        inputs = "layout(location = 1) in vec4 attr[numAttributes-1];\n"
    else:
        locs = locations(attrs, skip, out_of_order)
        inputs = ""
        for i, attr in enumerate(attrs):
            decl = EXPAND_TO_FULL[GLSL_TYPES[attr[0]][0]] if missing else GLSL_TYPES[attr[0]][0]
            inputs += f"layout(location = {locs[i]}) in {decl} attr{i};\n"
    check = vertex_check(attrs, query_max, missing)
    return extensions, inputs, check


def parse_format_lists():
    text = TESTS_CPP.read_text()
    blocks = re.findall(r"const VkFormat vertexFormats\[\] = \{(.*?)\};", text, re.S)
    assert len(blocks) == 3, len(blocks)
    return [re.findall(r"VK_FORMAT_\w+", b) for b in blocks]


def is_compatible(fmt, glsl_type):
    name, comps, count, basic = GLSL_TYPES[glsl_type]
    if comps != comp_count(fmt):
        return False
    if basic == "int":
        return has(fmt, "SINT")
    if basic == "uint":
        return has(fmt, "UINT")
    if basic == "float":
        small = size_of(fmt) <= 4 if has(fmt, "PACKED") else comp_size(fmt) <= 4
        return small and any(has(fmt, f) for f in ("SFLOAT", "SNORM", "UNORM", "SSCALED", "USCALED", "SRGB", "UFLOAT"))
    if basic == "double":
        return has(fmt, "SFLOAT") and comp_size(fmt) == 8
    if basic == "float16":
        return has(fmt, "SFLOAT") and comp_size(fmt) == 2
    raise AssertionError


def case_name_for(attr):
    return f"as_{attr[1][10:].lower()}_rate_{attr[2]}"


class Case:
    def __init__(self, path, name, attrs, mapping, layout, skip=False, out_of_order=False, missing=False):
        self.path, self.name, self.attrs = path, name, attrs
        self.mapping, self.layout, self.skip, self.out_of_order, self.missing = mapping, layout, skip, out_of_order, missing


def single_attribute_cases(formats):
    cases = []
    for glsl_type in range(len(GLSL_TYPES)):
        group = f"single_attribute/{GLSL_TYPES[glsl_type][0]}"
        for fmt in formats:
            if not is_compatible(fmt, glsl_type):
                continue
            for rate in ("vertex", "instance"):
                attr = (glsl_type, fmt, rate)
                cases.append(Case(group, case_name_for(attr), [attr], "OneToOne", "Interleaved"))
            _, comps, _, basic = GLSL_TYPES[glsl_type]
            if comps < K_MAX_COMPONENTS and basic != "double":
                for rate in ("vertex", "instance"):
                    attr = (glsl_type, fmt, rate)
                    cases.append(Case(group, case_name_for(attr) + "_missing_components", [attr], "OneToOne", "Interleaved", missing=True))
    return cases


def multiple_attribute_cases(formats):
    compatible = [[f for f in formats if is_compatible(f, t)] for t in range(len(GLSL_TYPES))]
    rnd = DeRandom(102030)
    cases = []

    def recurse(prefix, depth, first, mapping, layout, skip, out_of_order, infos):
        for current in range(first, GLSL_DOUBLE - depth):
            new_infos = infos + [[current, None, "vertex" if depth % 2 == 0 else "instance"]]
            name = GLSL_TYPES[current][0]
            if depth == 0:
                for info in new_infos:
                    fmts = compatible[info[0]]
                    info[1] = fmts[rnd.get_uint32() % len(fmts)]
                cases.append(Case(prefix, name, [tuple(i) for i in new_infos], mapping, layout, skip, out_of_order))
            else:
                recurse(f"{prefix}/{name}", depth - 1, current + 1, mapping, layout, skip, out_of_order, new_infos)

    for skip in (False, True):
        for out_of_order in (False, True):
            if skip and out_of_order:
                continue
            if skip:
                base = "multiple_attributes/layout_skip"
            elif out_of_order:
                base = "multiple_attributes/out_of_order"
            else:
                base = "multiple_attributes"
            recurse(f"{base}/binding_one_to_one/attributes", 2, 0, "OneToOne", "Interleaved", skip, out_of_order, [])
            recurse(f"{base}/binding_one_to_many/attributes", 2, 0, "OneToMany", "Interleaved", skip, out_of_order, [])
            recurse(f"{base}/binding_one_to_many/attributes_sequential", 2, 0, "OneToMany", "Sequential", skip, out_of_order, [])
    return cases


def max_attribute_cases(formats):
    compatible = [[f for f in formats if is_compatible(f, t)] for t in range(len(GLSL_TYPES))]
    rnd = DeRandom(132030)
    cases = []
    for count_ndx, count in enumerate([16, 32, 64, 128, 0]):
        group = f"max_attributes/{'query_max' if count == 0 else count}_attributes"
        attrs = []
        for attribute_ndx in range(count):
            glsl_type = rnd.get_uint32() % GLSL_MAT2
            fmts = compatible[glsl_type]
            fmt = fmts[rnd.get_uint32() % len(fmts)]
            rate = "vertex" if (count_ndx + attribute_ndx) % 2 == 0 else "instance"
            attrs.append((glsl_type, fmt, rate))
        cases.append(Case(f"{group}/binding_one_to_one", "interleaved", attrs, "OneToOne", "Interleaved"))
        cases.append(Case(f"{group}/binding_one_to_many", "interleaved", attrs, "OneToMany", "Interleaved"))
        cases.append(Case(f"{group}/binding_one_to_many", "sequential", attrs, "OneToMany", "Sequential"))
    return cases


def component_mismatch_cases():
    table = [
        ("VK_FORMAT_R64G64_SFLOAT", "double", "r64g64_to_double"),
        ("VK_FORMAT_R64G64B64_SFLOAT", "double", "r64g64b64_to_double"),
        ("VK_FORMAT_R64G64B64_SFLOAT", "dvec2", "r64g64b64_to_dvec2"),
        ("VK_FORMAT_R64G64B64A64_SFLOAT", "double", "r64g64b64a64_to_double"),
        ("VK_FORMAT_R64G64B64A64_SFLOAT", "dvec2", "r64g64b64a64_to_dvec2"),
        ("VK_FORMAT_R64G64B64A64_SFLOAT", "dvec3", "r64g64b64a64_to_dvec3"),
    ]
    names = [t[0] for t in GLSL_TYPES]
    return [Case("component_mismatch", name, [(names.index(glsl), fmt, "vertex")], "OneToOne", "Interleaved") for fmt, glsl, name in table]


def write_formats_rs():
    lines = [
        "// @generated by hodow_cts/scripts/gen_vertex_input_manifest.py - do not hand-edit.",
        "//",
        "// The vertex format tables of vktPipelineVertexUtil.cpp (`getVertexFormatSize` and its siblings), read out of upstream's source.",
        "",
        "use vulkanalia::vk;",
        "",
        "use super::vertex_input_tests::VertexFormatInfo;",
        "",
        "pub static VERTEX_FORMATS: &[VertexFormatInfo] = &[",
    ]
    for fmt in sorted(UTIL):
        entry = UTIL[fmt]
        flags = " | ".join(f"VertexFormatInfo::{f}" for f in FLAGS if f in entry["flags"]) or "0"
        w = entry["widths"] or [0, 0, 0, 0]
        lines.append(
            f"    VertexFormatInfo {{ format: vk::Format::{rust_format(fmt)}, size: {entry['size'] or 0}, component_count: {entry['comps'] or 0}, "
            f"component_size: {entry['comp_size'] or 0}, packed_widths: [{w[0]}, {w[1]}, {w[2]}, {w[3]}], flags: {flags} }},"
        )
    lines.append("];")
    FORMATS_RS.write_text("\n".join(lines) + "\n")


def write_cases_rs(cases, keys):
    lines = [
        "// @generated by hodow_cts/scripts/gen_vertex_input_manifest.py - do not hand-edit.",
        "//",
        "// The cases of dEQP-VK.pipeline.*.vertex_input.{single_attribute,multiple_attributes,max_attributes,component_mismatch}.",
        "",
        "use vulkanalia::vk;",
        "",
        "use super::vertex_input_tests::{AttributeInfo, AttributeLayout, BindingMapping, CaseSpec, GlslType};",
        "",
        "const V: vk::VertexInputRate = vk::VertexInputRate::VERTEX;",
        "const I: vk::VertexInputRate = vk::VertexInputRate::INSTANCE;",
        "",
        f"pub static VERTEX_INPUT_CASES: [CaseSpec; {len(cases)}] = [",
    ]
    type_names = {t[0]: "".join(p.capitalize() for p in re.split(r"_", t[0])) for t in GLSL_TYPES}
    type_names.update({"float16_t": "F16", "f16vec2": "F16Vec2", "f16vec3": "F16Vec3", "f16vec4": "F16Vec4"})
    for case, key in zip(cases, keys):
        attrs = ", ".join(
            f"AttributeInfo {{ glsl_type: GlslType::{type_names[GLSL_TYPES[a[0]][0]]}, vk_type: vk::Format::{rust_format(a[1])}, input_rate: {'V' if a[2] == 'vertex' else 'I'} }}"
            for a in case.attrs
        )
        lines.append(
            f'    CaseSpec {{ path: "{case.path}", name: "{case.name}", key: "{key}", attributes: &[{attrs}], binding_mapping: BindingMapping::{case.mapping}, '
            f"attribute_layout: AttributeLayout::{case.layout}, layout_skip: {str(case.skip).lower()}, out_of_order: {str(case.out_of_order).lower()}, "
            f"missing_components: {str(case.missing).lower()} }},"
        )
    lines.append("];")
    CASES_RS.write_text("\n".join(lines) + "\n")


def toml_str(text):
    import json

    return json.dumps(text)


def main():
    lists = parse_format_lists()
    cases = single_attribute_cases(lists[0]) + multiple_attribute_cases(lists[1]) + max_attribute_cases(lists[2]) + component_mismatch_cases()

    shaders = {}
    keys = []
    for case in cases:
        query_max = len(case.attrs) == 0
        extensions, inputs, check = vertex_source(case.attrs, case.skip, case.out_of_order, case.missing, query_max)
        source = extensions + "\0" + inputs + "\0" + check
        key = "vi_" + hashlib.sha1(source.encode()).hexdigest()[:16]
        shaders.setdefault(key, (extensions, inputs, check))
        keys.append(key)

    out = [
        "# Shader manifest for dEQP-VK.pipeline.*.vertex_input.{single_attribute,multiple_attributes,max_attributes,component_mismatch}\n",
        "#\n",
        "# @generated by hodow_cts/scripts/gen_vertex_input_manifest.py - do not hand-edit.\n",
        "#\n",
        "# `VertexInputTest::initPrograms`, one entry per distinct vertex shader (the fragment shader is the same everywhere).\n\n",
        'upstream_source = "external/vulkancts/modules/vulkan/pipeline/vktPipelineVertexInputTests.cpp"\n',
        'rust_module = "pipeline/vertex_input_tests"\n',
    ]
    for key, (extensions, inputs, check) in shaders.items():
        derived = {
            "extensions": repr(extensions),
            "max_attributes": "16",
            "inputs": repr(inputs),
            "check": repr(check),
        }
        out.append("\n[[case]]\n")
        out.append(f'name = "{key}"\n')
        out.append(f'rust_const = "{key.upper()}"\n')
        out.append('rust_type = "SharedProgram"\n')
        out.append(
            "programs = [\n"
            '    { name = "attribute_test_vert", template = "pipeline/vertex_input/attribute_test.vert", stage = "vert" },\n'
            '    { name = "attribute_test_frag", template = "pipeline/vertex_input/attribute_test.frag", stage = "frag" },\n'
            "]\n"
        )
        out.append("derived = { " + ", ".join(f"{k} = {toml_str(v)}" for k, v in derived.items()) + " }\n")
    MANIFEST.write_text("".join(out))

    write_formats_rs()
    write_cases_rs(cases, keys)
    print(f"{len(cases)} cases, {len(shaders)} distinct vertex shaders")


if __name__ == "__main__":
    main()

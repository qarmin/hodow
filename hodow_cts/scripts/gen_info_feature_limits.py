#!/usr/bin/env python3
"""Translate `validateFeatureLimits` of vktApiFeatureInfo.cpp into src/vkt/tests/info/feature_limits.rs.

The two tables there (`featureLimitTable` and `unsupportedFeatureTable`) are read straight from the vendored C++ so a re-sync only
needs this run again. The few entries whose expected value is computed from other limits are translated by hand below.

Usage:
    python3 hodow_cts/scripts/gen_info_feature_limits.py
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
SOURCE = CRATE_DIR / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "api" / "vktApiFeatureInfo.cpp"
OUT = CRATE_DIR / "src" / "vkt" / "tests" / "info" / "feature_limits.rs"

DYNAMIC_FLOATS = {
    "maxInterpolationOffset": "0.5 - (1.0 / (limits.sub_pixel_interpolation_offset_bits as f32).exp2())",
    "pointSizeRange[1]": "64.0 - limits.point_size_granularity",
    "lineWidthRange[1]": "8.0 - limits.line_width_granularity",
}


def snake(name: str) -> str:
    """vulkanalia's field naming: words split at capitals, a `1D`/`2D`/`3D` a word of its own."""
    name = re.sub(r"(\d)([A-Z])(?=[A-Z][a-z]|$)", lambda m: m.group(1) + m.group(2).lower(), name)
    name = re.sub(r"([a-z])(\d+[a-z])(?=[A-Z]|$)", r"\1_\2", name)
    name = re.sub(r"(?<=[a-z0-9])([A-Z])", r"_\1", name)
    return name.lower()


def field_path(raw: str) -> str:
    m = re.fullmatch(r"([A-Za-z0-9]+)(\[(\d)\])?", raw)
    assert m, raw
    path = snake(m.group(1))
    return f"{path}[{m.group(3)}]" if m.group(2) else path


def split_top_level(text: str) -> list[str]:
    parts, depth, cur = [], 0, ""
    for ch in text:
        if ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
        if ch == "," and depth == 0:
            parts.append(cur.strip())
            cur = ""
        else:
            cur += ch
    if cur.strip():
        parts.append(cur.strip())
    return parts


def rust_u32(expr: str) -> str:
    expr = expr.strip()
    expr = re.sub(r"\(uint32_t\)~0", "u32::MAX", expr)
    expr = expr.replace("maxPerStageResourcesMin", "max_per_stage_resources_min").replace("shaderStages", "shader_stages")
    expr = re.sub(r"VK_SAMPLE_COUNT_(\d+)_BIT", lambda m: f"vk::SampleCountFlags::_{m.group(1)}.bits()", expr)
    expr = expr.replace("(1 << 24) - 1", "(1u32 << 24) - 1")
    return expr


def main() -> int:
    text = SOURCE.read_text()
    start = text.index("} featureLimitTable[] =")
    start = text.index("{", start + len("} featureLimitTable[] ="))
    end = text.index("};", start)
    body = text[start + 1 : end]
    entries = re.split(r"\{LIMIT\(", body)[1:]

    lines = []
    for entry in entries:
        entry = re.sub(r"\s+", " ", entry)
        entry = entry.rstrip().rstrip(",").rstrip()
        assert entry.endswith("}"), entry
        entry = entry[:-1]
        name_end = entry.index(")")
        name = entry[:name_end]
        # LIMIT(x) expands to offsetof(...), "x" - the rest of the row follows the closing parenthesis
        fields = split_top_level(entry[name_end + 1 :].lstrip(", "))
        uint_v, int_v, size_v, float_v, fmt, typ, _unsupp, pot = fields
        kind = {"LIMIT_TYPE_MIN": "Kind::Min", "LIMIT_TYPE_MAX": "Kind::Max", "LIMIT_TYPE_NONE": "Kind::None"}[typ]
        # A limit with no bound has nothing to check, whatever its format says.
        if kind == "Kind::None":
            continue
        access = f"limits.{field_path(name)}"
        pot_s = "true" if pot == "true" else "false"
        if fmt == "LIMIT_FORMAT_UNSIGNED_INT":
            lines.append(f'    c.uint("{name}", {access}, {rust_u32(uint_v)}, {kind}, {pot_s});')
        elif fmt == "LIMIT_FORMAT_BITMASK":
            lines.append(f'    c.bitmask("{name}", {access}.bits(), {rust_u32(uint_v)}, {kind});')
        elif fmt == "LIMIT_FORMAT_SIGNED_INT":
            lines.append(f'    c.int("{name}", {access}, {int_v}, {kind});')
        elif fmt == "LIMIT_FORMAT_DEVICE_SIZE":
            lines.append(f'    c.size("{name}", {access}, {size_v.replace("UL", "u64")}u64, {kind});'.replace("u64u64", "u64"))
        elif fmt == "LIMIT_FORMAT_FLOAT":
            expected = DYNAMIC_FLOATS.get(name, float_v.replace("f", ""))
            lines.append(f'    c.float("{name}", {access}, {expected}, {kind});')
        else:
            raise SystemExit(f"unknown format {fmt}")

    # The unsupported-feature table: per limit, the value that stands in while a feature is off.
    ustart = text.index("} unsupportedFeatureTable[] = {")
    ustart = text.index("{", ustart + len("} unsupportedFeatureTable[] ="))
    uend = text.index("};", ustart)
    ubody = text[ustart + 1 : uend]
    unsupported = []
    for entry in re.split(r"\{LIMIT\(", ubody)[1:]:
        entry = re.sub(r"\s+", " ", entry).rstrip().rstrip(",").rstrip()
        entry = entry[:-1]
        name_end = entry.index(")")
        name = entry[:name_end]
        fields = split_top_level(entry[name_end + 1 :].lstrip(", "))
        feature = re.fullmatch(r"FEATURE\((\w+)\)", fields[0]).group(1)
        uint_v, int_v, size_v, float_v = fields[1:5]
        unsupported.append((name, snake(feature), rust_u32(uint_v), float_v.replace("f", "")))

    out = [
        "// SPDX-License-Identifier: Apache-2.0",
        "//",
        "// @generated by hodow_cts/scripts/gen_info_feature_limits.py from vktApiFeatureInfo.cpp (`validateFeatureLimits`) - do not hand-edit.",
        "",
        "use vulkanalia::prelude::v1_0::*;",
        "",
        "#[derive(Clone, Copy, PartialEq, Eq)]",
        "enum Kind {",
        "    Min,",
        "    Max,",
        "}",
        "",
        "struct Checker<'a> {",
        "    ok: bool,",
        "    features: &'a vk::PhysicalDeviceFeatures,",
        "}",
        "",
        "impl Checker<'_> {",
        "    /// The value `unsupportedFeatureTable` substitutes for `name` while its feature is off: `(uintVal, floatVal)`.",
        "    fn unsupported(&self, name: &str) -> Option<(u32, f32)> {",
        "        let features = self.features;",
        "        match name {",
    ]
    for name, feature, uint_v, float_v in unsupported:
        out.append(f'            "{name}" if features.{feature} == vk::FALSE => Some(({uint_v}, {float_v}_f32)),')
    out += [
        "            _ => None,",
        "        }",
        "    }",
        "",
        "    fn uint(&mut self, name: &str, actual: u32, expected: u32, kind: Kind, pot: bool) {",
        "        let expected = self.unsupported(name).map_or(expected, |(uint, _)| uint);",
        "        if pot && (actual == 0 || !actual.is_power_of_two()) {",
        '            log::info!("limit Validation failed {name} is not a power of two.");',
        "            self.ok = false;",
        "        }",
        "        match kind {",
        '            Kind::Min if actual < expected => self.fail(name, "MIN", &actual.to_string()),',
        '            Kind::Max if actual > expected => self.fail(name, "MAX", &actual.to_string()),',
        "            _ => {}",
        "        }",
        "    }",
        "",
        "    fn bitmask(&mut self, name: &str, actual: u32, expected: u32, kind: Kind) {",
        "        let expected = self.unsupported(name).map_or(expected, |(uint, _)| uint);",
        "        if kind == Kind::Min && actual & expected != expected {",
        '            self.fail(name, "bitmask", &actual.to_string());',
        "        }",
        "    }",
        "",
        "    fn int(&mut self, name: &str, actual: i32, expected: i32, kind: Kind) {",
        "        let expected = if self.unsupported(name).is_some() { 0 } else { expected };",
        "        match kind {",
        '            Kind::Min if actual < expected => self.fail(name, "MIN", &actual.to_string()),',
        '            Kind::Max if actual > expected => self.fail(name, "MAX", &actual.to_string()),',
        "            _ => {}",
        "        }",
        "    }",
        "",
        "    fn size(&mut self, name: &str, actual: u64, expected: u64, kind: Kind) {",
        "        let expected = if self.unsupported(name).is_some() { 0 } else { expected };",
        "        match kind {",
        '            Kind::Min if actual < expected => self.fail(name, "MIN", &actual.to_string()),',
        '            Kind::Max if actual > expected => self.fail(name, "MAX", &actual.to_string()),',
        "            _ => {}",
        "        }",
        "    }",
        "",
        "    fn float(&mut self, name: &str, actual: f32, expected: f32, kind: Kind) {",
        "        let expected = self.unsupported(name).map_or(expected, |(_, float)| float);",
        "        match kind {",
        '            Kind::Min if actual < expected => self.fail(name, "MIN", &actual.to_string()),',
        '            Kind::Max if actual > expected => self.fail(name, "MAX", &actual.to_string()),',
        "            _ => {}",
        "        }",
        "    }",
        "",
        "    fn fail(&mut self, name: &str, kind: &str, actual: &str) {",
        '        log::info!("limit validation failed, {name} not valid-limit type {kind} - actual is {actual}");',
        "        self.ok = false;",
        "    }",
        "}",
        "",
        "/// `validateFeatureLimits` - whether the limits meet the minimums of the 1.0 specification given the features that are on.",
        "pub fn validate_feature_limits(properties: &vk::PhysicalDeviceProperties, features: &vk::PhysicalDeviceFeatures) -> bool {",
        "    let limits = &properties.limits;",
        "    let mut shader_stages = 3u32;",
        "    let max_per_stage_resources_min = 128u32.min(",
        "        limits.max_per_stage_descriptor_uniform_buffers",
        "            + limits.max_per_stage_descriptor_storage_buffers",
        "            + limits.max_per_stage_descriptor_sampled_images",
        "            + limits.max_per_stage_descriptor_storage_images",
        "            + limits.max_per_stage_descriptor_input_attachments",
        "            + limits.max_color_attachments,",
        "    );",
        "",
        "    if features.tessellation_shader != vk::FALSE {",
        "        shader_stages += 2;",
        "    }",
        "    if features.geometry_shader != vk::FALSE {",
        "        shader_stages += 1;",
        "    }",
        "",
        "    let mut c = Checker { ok: true, features };",
        "",
        *lines,
        "",
        "    let mut limits_ok = c.ok;",
        "",
        "    if limits.max_framebuffer_width > limits.max_viewport_dimensions[0] || limits.max_framebuffer_height > limits.max_viewport_dimensions[1] {",
        '        log::info!("limit validation failed, maxFramebufferDimension of [{}, {}] is larger than maxViewportDimension of [{}, {}]", limits.max_framebuffer_width, limits.max_framebuffer_height, limits.max_viewport_dimensions[0], limits.max_viewport_dimensions[1]);',
        "        limits_ok = false;",
        "    }",
        "",
        "    if limits.viewport_bounds_range[0] > (-2 * limits.max_viewport_dimensions[0] as i64) as f32 {",
        '        log::info!("limit validation failed, viewPortBoundsRange[0] of {} is larger than -2*maxViewportDimension[0] of {}", limits.viewport_bounds_range[0], -2 * limits.max_viewport_dimensions[0] as i64);',
        "        limits_ok = false;",
        "    }",
        "",
        "    if limits.viewport_bounds_range[1] < (2 * limits.max_viewport_dimensions[1] as i64 - 1) as f32 {",
        '        log::info!("limit validation failed, viewportBoundsRange[1] of {} is less than 2*maxViewportDimension[1] of {}", limits.viewport_bounds_range[1], 2 * limits.max_viewport_dimensions[1] as i64);',
        "        limits_ok = false;",
        "    }",
        "",
        "    limits_ok",
        "}",
        "",
    ]
    pstart = text.index("s_physicalDevicePropertiesOffsetTable[] = {")
    pend = text.index("{0, 0}};", pstart)
    paths = re.findall(r"OFFSET_TABLE_ENTRY\(VkPhysicalDeviceProperties, ([A-Za-z0-9_.\[\]]+)\)", text[pstart:pend])
    rust_paths = []
    for path in paths:
        parts = [re.sub(r"\[\d+\]$", "", seg) for seg in path.split(".")]
        rust_paths.append(".".join(snake(seg) for seg in parts))
    out += [
        "fn same_bytes<T>(a: &T, b: &T) -> bool {",
        "    let bytes = |value: &T| unsafe { std::slice::from_raw_parts(std::ptr::from_ref(value).cast::<u8>(), std::mem::size_of::<T>()) };",
        "    bytes(a) == bytes(b)",
        "}",
        "",
        "/// The `s_physicalDevicePropertiesOffsetTable` members of two queries, one into zeroed and one into 0xFF-filled memory, are equal",
        "/// only when the implementation wrote every one of them.",
        "pub fn properties_init_complete(a: &vk::PhysicalDeviceProperties, b: &vk::PhysicalDeviceProperties) -> bool {",
        "    true",
        *[f"        && same_bytes(&a.{path}, &b.{path})" for path in rust_paths],
        "}",
        "",
    ]
    OUT.write_text("\n".join(out))
    print(f"wrote {OUT.relative_to(CRATE_DIR.parent)} with {len(lines)} limits and {len(unsupported)} feature fallbacks")
    return 0


if __name__ == "__main__":
    sys.exit(main())

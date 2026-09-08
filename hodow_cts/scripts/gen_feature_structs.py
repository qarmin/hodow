#!/usr/bin/env python3
"""Generate src/vkt/tests/api/feature_struct_list.rs from upstream's vkDeviceFeatures2.inl.

`dEQP-VK.api.info.get_physical_device_properties2.features.*` is 182 near-identical
cases, one per VkPhysicalDevice*Features struct: chain the struct into a
VkPhysicalDeviceFeatures2, query twice from differently pre-filled memory, and check
the two answers agree. Upstream generates them from the registry; retyping 182 struct
names, sType values, extension conditions and field lists by hand would be a few
thousand chances to get one wrong, and a wrong one does not fail to build.

The generated table is deliberately structural rather than typed: a case is a
`(sType, size, field offsets)` triple that the test fills as raw bytes. That means
vulkanalia does not have to define every one of these structs - most of them it does
not - and a struct that only exists in a newer registry still works.

Usage:
    python3 hodow_cts/scripts/gen_feature_structs.py [--cts-dir tmp/VK-GL-CTS]
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
OUT = CRATE_DIR / "src" / "vkt" / "tests" / "api" / "feature_struct_list.rs"

GEN = "external/vulkancts/framework/vulkan/generated/vulkan"


def parse_structure_types(text: str) -> dict[str, int]:
    """`VkStructureType` as name -> numeric value, resolving the alias lines."""
    values: dict[str, int] = {}
    aliases: list[tuple[str, str]] = []
    for name, rhs in re.findall(r"\t(VK_STRUCTURE_TYPE_\w+)\s*=\s*([^,\n]+),", text):
        rhs = rhs.strip()
        if re.fullmatch(r"-?\d+", rhs):
            values[name] = int(rhs)
        elif rhs.startswith("VK_STRUCTURE_TYPE_"):
            aliases.append((name, rhs))
    for name, target in aliases:
        if target in values:
            values[name] = values[target]
    return values


def parse_structs(text: str) -> dict[str, list[tuple[str, str]]]:
    """Struct name -> [(type, member)], in declaration order."""
    out: dict[str, list[tuple[str, str]]] = {}
    for name, body in re.findall(r"\nstruct (Vk\w+)\n\{\n(.*?)\n\};", text, re.S):
        members = []
        for line in body.splitlines():
            m = re.match(r"\s*([\w:*]+(?:\s*\*)?)\s+(\w+)(\[[^\]]*\])?;", line.strip())
            if m:
                members.append((m.group(1).strip(), m.group(2) + (m.group(3) or "")))
        out[name] = members
    return out


def align_up(value: int, alignment: int) -> int:
    return (value + alignment - 1) // alignment * alignment


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cts-dir", type=Path, default=REPO_DIR / "tmp" / "VK-GL-CTS")
    args = ap.parse_args()

    gen_dir = args.cts_dir / GEN
    paths = {
        "features2": gen_dir / "vkDeviceFeatures2.inl",
        "structs": gen_dir / "vkStructTypes.inl",
        "basic": gen_dir / "vkBasicTypes.inl",
    }
    for p in paths.values():
        if not p.is_file():
            print(f"error: {p} not found; is --cts-dir right?", file=sys.stderr)
            return 2

    features2 = paths["features2"].read_text()
    structure_types = parse_structure_types(paths["basic"].read_text())
    structs = parse_structs(paths["structs"].read_text())

    # The registration list gives the case names and their order.
    registrations = re.findall(r'addFunctionCase\(testGroup, "([^"]+)", (testPhysicalDeviceFeature\w+)\);', features2)
    if not registrations:
        print("error: no addFunctionCase entries found", file=sys.stderr)
        return 2

    # Split the file into one block per test function.
    bodies: dict[str, str] = {}
    for m in re.finditer(r"\ntcu::TestStatus (testPhysicalDeviceFeature\w+) \(Context& context\)\n\{\n(.*?)\n\}\n", features2, re.S):
        bodies[m.group(1)] = m.group(2)

    entries = []
    skipped = []
    for case_name, fn_name in registrations:
        body = bodies.get(fn_name)
        if body is None:
            skipped.append((case_name, "no function body"))
            continue

        m = re.search(r"\n\s{4}(Vk\w+)\s+(\w+)\[count\];", body)
        if not m:
            skipped.append((case_name, "no struct declaration"))
            continue
        struct_name, var_name = m.group(1), m.group(2)

        m = re.search(r"\.sType = (VK_STRUCTURE_TYPE_\w+);", body)
        if not m or m.group(1) not in structure_types:
            skipped.append((case_name, "no resolvable sType"))
            continue
        s_type = structure_types[m.group(1)]

        cond = re.search(r"const bool\s+\w+\s*=\s*(.*?);", body, re.S)
        if not cond:
            skipped.append((case_name, "no support condition"))
            continue
        cond_text = cond.group(1)
        extensions = re.findall(r'checkExtension\(properties, "([^"]+)"\)', cond_text)
        version = re.search(r"contextSupports\(vk::ApiVersion\(\d+,\s*(\d+),\s*(\d+),\s*\d+\)\)", cond_text)
        api_version = (int(version.group(1)), int(version.group(2))) if version else None

        # The fields the generated code compares, in declaration order.
        compared = re.findall(re.escape(var_name) + r"\[0\]\.(\w+) != " + re.escape(var_name) + r"\[1\]\.(\w+)", body)
        fields = [a for a, b in compared if a == b]
        if len(fields) != len(compared):
            skipped.append((case_name, "asymmetric field comparison"))
            continue

        members = structs.get(struct_name)
        if members is None:
            skipped.append((case_name, f"struct {struct_name} not found"))
            continue
        payload = members[2:]  # after sType and pNext
        if [name for _, name in payload] != fields:
            skipped.append((case_name, f"{struct_name} members do not match the comparison list"))
            continue
        if any(ty != "VkBool32" for ty, _ in payload):
            # The offset arithmetic below assumes a run of VkBool32 after pNext.
            skipped.append((case_name, f"{struct_name} has a non-VkBool32 member"))
            continue

        entries.append(
            {
                "name": case_name,
                "struct": struct_name,
                "s_type": s_type,
                "extensions": extensions,
                "api_version": api_version,
                "fields": fields,
                # sType (4) + 4 bytes of padding + pNext (8), then one VkBool32 each,
                # rounded up to the struct's 8-byte alignment.
                "size": align_up(16 + 4 * len(fields), 8),
            }
        )

    print(f"{len(entries)} feature structs, {len(skipped)} skipped")
    for name, why in skipped:
        print(f"  skipped {name}: {why}")

    lines = [
        "// SPDX-License-Identifier: Apache-2.0",
        "//",
        "// Derived from VK-GL-CTS:",
        "//   external/vulkancts/framework/vulkan/generated/vulkan/vkDeviceFeatures2.inl",
        "//   external/vulkancts/framework/vulkan/generated/vulkan/vkStructTypes.inl",
        "// Upstream revision: see hodow_cts/upstream/COMMIT",
        "//",
        "// Copyright (c) 2025 The Khronos Group Inc.",
        "// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).",
        "//",
        "// Generated by scripts/gen_feature_structs.py; do not hand-edit.",
        "",
        "/// One `testPhysicalDeviceFeature*` case. The struct is described rather than",
        "/// declared: `size` bytes, `fields.len()` VkBool32 members starting at offset 16.",
        "pub struct FeatureStruct {",
        "    pub name: &'static str,",
        "    /// The Vulkan struct this stands for, for the failure message.",
        "    pub struct_name: &'static str,",
        "    /// `VkStructureType` as its numeric value - vulkanalia does not define a",
        "    /// constant for every one of these.",
        "    pub s_type: i32,",
        "    pub size: usize,",
        "    /// Any one of these device extensions enables the query.",
        "    pub extensions: &'static [&'static str],",
        "    /// Or this core API version does, as (major, minor).",
        "    pub api_version: Option<(u32, u32)>,",
        "    pub fields: &'static [&'static str],",
        "}",
        "",
        "/// `addSeparateFeatureTests`, in upstream's order.",
        "pub static FEATURE_STRUCTS: &[FeatureStruct] = &[",
    ]
    for e in entries:
        exts = ", ".join(f'"{x}"' for x in e["extensions"])
        ver = f'Some(({e["api_version"][0]}, {e["api_version"][1]}))' if e["api_version"] else "None"
        fields = ", ".join(f'"{f}"' for f in e["fields"])
        lines.append("    FeatureStruct {")
        lines.append(f'        name: "{e["name"]}",')
        lines.append(f'        struct_name: "{e["struct"]}",')
        lines.append(f"        s_type: {e['s_type']},")
        lines.append(f"        size: {e['size']},")
        lines.append(f"        extensions: &[{exts}],")
        lines.append(f"        api_version: {ver},")
        lines.append(f"        fields: &[{fields}],")
        lines.append("    },")
    lines.append("];")
    lines.append("")

    OUT.write_text("\n".join(lines))
    subprocess.run(["rustfmt", "--edition", "2024", str(OUT)], cwd=CRATE_DIR, check=False)
    print(f"wrote {OUT.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

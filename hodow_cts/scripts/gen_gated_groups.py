#!/usr/bin/env python3
"""Writes src/vkt/tests/<group>/{mod.rs,cases.txt} for the dEQP-VK groups whose bodies are not ported (ray_query, ray_tracing_pipeline, protected_memory, video, wsi).

Each case is registered under its mustpass name and gated on the extension upstream's first support check requires (`data_graph::build_gated_groups`):
NotSupported without it, NotPorted with it. The names come from the mustpass list of the pinned revision, which holds exactly what a run registers.

Run from hodow_cts/:  python3 scripts/gen_gated_groups.py [group ...]  (no argument: every group, overwriting each mod.rs)
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MUSTPASS = ROOT.parent / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "mustpass" / "main" / "vk-default"
TESTS = ROOT / "src" / "vkt" / "tests"

# group -> (mustpass file, upstream entry point, required device extensions, description of what is not ported)
GROUPS = {
    "ray_query": ("ray-query.txt", "ray_query/vktRayQueryTests.cpp", ["VK_KHR_ray_query", "VK_KHR_acceleration_structure"], "the ray query tests"),
    "ray_tracing_pipeline": ("ray-tracing-pipeline.txt", "ray_tracing/vktRayTracingTests.cpp", ["VK_KHR_ray_tracing_pipeline", "VK_KHR_acceleration_structure"], "the ray tracing pipeline tests"),
    "protected_memory": ("protected-memory.txt", "protected_memory/vktProtectedMemTests.cpp", [], "the protected memory tests"),
    "video": ("video.txt", "video/vktVideoTests.cpp", ["VK_KHR_video_queue"], "the video tests"),
    "wsi": ("wsi.txt", "wsi/vktWsiTests.cpp", ["VK_KHR_swapchain"], "the WSI tests"),
    "cooperative_vector": ("cooperative-vector.txt", "cooperative_vector/vktCooperativeVectorTests.cpp", ["VK_NV_cooperative_vector"], "the cooperative vector tests"),
}

TEMPLATE = '''// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/{upstream}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case tree is registered with upstream's first support check and the bodies are not ported, so a
// device without the extensions ends in NotSupported as under deqp-vk and one with them in NotPorted. The names are the mustpass list of the pinned
// revision (`scripts/gen_gated_groups.py` writes `cases.txt`).

use crate::vkt::TestCaseGroup;
use crate::vkt::tests::data_graph::build_gated_groups;

const CASE_NAMES: &str = include_str!("cases.txt");

/// The `{group}` group.
pub fn create_tests() -> TestCaseGroup {{
    let mut group = TestCaseGroup::new("{group}");
    for child in build_gated_groups(CASE_NAMES, &[{extensions}], "{what}") {{
        group.add_child(child);
    }}
    group
}}
'''


def main():
    wanted = sys.argv[1:] or list(GROUPS)
    for group in wanted:
        mustpass, upstream, extensions, what = GROUPS[group]
        prefix = f"dEQP-VK.{group}."
        names = [l.strip()[len(prefix):] for l in (MUSTPASS / mustpass).read_text().splitlines() if l.startswith(prefix)]
        out = TESTS / group
        out.mkdir(parents=True, exist_ok=True)
        (out / "cases.txt").write_text("\n".join(names) + "\n")
        exts = ", ".join(f'"{e}"' for e in extensions)
        (out / "mod.rs").write_text(TEMPLATE.format(upstream=upstream, group=group, extensions=exts, what=what))
        print(group, len(names), "cases")


if __name__ == "__main__":
    main()

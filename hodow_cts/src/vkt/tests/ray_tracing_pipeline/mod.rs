// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ray_tracing/vktRayTracingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case tree is registered with upstream's first support check and the bodies are not ported, so a
// device without the extensions ends in NotSupported as under deqp-vk and one with them in NotPorted. The names are the mustpass list of the pinned
// revision (`scripts/gen_gated_groups.py` writes `cases.txt`).

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const CASE_NAMES: &str = include_str!("cases.txt");

/// The `ray_tracing_pipeline` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ray_tracing_pipeline");
    for child in build_gated_groups(
        CASE_NAMES,
        &["VK_KHR_ray_tracing_pipeline", "VK_KHR_acceleration_structure"],
        "the ray tracing pipeline tests",
    ) {
        group.add_child(child);
    }
    group
}

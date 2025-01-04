// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectIndependentSetsTests.cpp
//   external/vulkancts/modules/vulkan/util/vktIndependentSetsUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the case tree is registered, gated on VK_EXT_shader_object and VK_KHR_maintenance11
// (NotSupported without them, NotPorted with them); the names are the mustpass list of the pinned revision.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const CASES: [&str; 4] = [
    include_str!("independent_sets_cases/unlinked_spirv.txt"),
    include_str!("independent_sets_cases/unlinked_binary.txt"),
    include_str!("independent_sets_cases/linked_spirv.txt"),
    include_str!("independent_sets_cases/linked_binary.txt"),
];

/// `createShaderObjectIndependentSetsTests`, names only.
pub fn create_shader_object_independent_sets_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("m11_independent_sets");
    for names in CASES {
        for child in build_gated_groups(
            names,
            &["VK_EXT_shader_object", "VK_KHR_maintenance11"],
            "the independent sets tests with shader objects",
        ) {
            group.add_child(child);
        }
    }
    group
}

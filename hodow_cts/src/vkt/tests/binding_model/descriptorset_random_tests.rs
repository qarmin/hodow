// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorSetRandomTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the case tree is registered (names from the mustpass list of the pinned revision); the bodies are
// not ported and end in NotPorted.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const CASE_NAMES: &str = include_str!("descriptorset_random_cases/cases.txt");

/// The `descriptorset_random` group.
pub fn create_descriptorset_random_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("descriptorset_random");
    for child in build_gated_groups(CASE_NAMES, &[], "the descriptor set random tests") {
        group.add_child(child);
    }
    group
}

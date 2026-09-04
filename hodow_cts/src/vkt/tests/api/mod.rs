// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// None of the ported groups here uses a shader, so every case hands back an empty
// `BinaryCollection` and nothing in this subtree has a manifest entry.

pub mod feature_info_tests;
pub mod object_tests;

use crate::tcu::TestCaseGroup;

/// `createApiTests`.
///
/// The groups upstream registers here that are absent - copy_and_blit,
/// image_clearing, smoke, descriptor_set, external, ... - are absent rather than
/// present-and-skipped, so a comparison against `deqp-vk` reports them as missing
/// instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut api_tests = TestCaseGroup::new("api");

    for group in object_tests::create_object_groups() {
        api_tests.add_child(group);
    }
    for group in feature_info_tests::create_info_groups() {
        api_tests.add_child(group);
    }

    api_tests
}

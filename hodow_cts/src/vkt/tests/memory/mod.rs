// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// None of the ported groups uses a shader, so every case here hands back an empty
// `BinaryCollection` and nothing in this subtree has a manifest entry.

pub mod allocation_tests;
pub mod binding_tests;
pub mod mapping_tests;
pub mod zero_initialize_device_memory_tests;

use crate::tcu::TestCaseGroup;

/// `createMemoryTests` for the `memory` group.
///
/// Upstream registers a dozen more sub-groups here (pipeline_barrier, requirements,
/// device_memory_report, external_memory_*, decompression, ...). They are absent rather
/// than present-and-skipped, so a comparison against `deqp-vk` reports them as missing
/// instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut memory_tests = TestCaseGroup::new("memory");

    memory_tests.add_child(allocation_tests::create_allocation_tests());
    memory_tests.add_child(binding_tests::create_memory_binding_tests());
    memory_tests.add_child(allocation_tests::create_device_group_allocation_tests());
    memory_tests.add_child(mapping_tests::create_mapping_tests());
    memory_tests.add_child(allocation_tests::create_pageable_allocation_tests());
    memory_tests.add_child(zero_initialize_device_memory_tests::create_zero_initialize_device_memory_tests());

    memory_tests
}

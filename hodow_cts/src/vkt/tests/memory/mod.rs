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
// Most ported groups use no shader and hand back an empty `BinaryCollection`; the ones that
// do (`concurrent_access`, `external_memory_host`, `map_placed`) have manifests under shaders/manifest/
// named `memory_*.toml`.

pub mod acquire_unmodified_tests;
pub mod allocation_tests;
pub mod binding_tests;
pub mod concurrent_access_tests;
pub mod decompression_tests;
pub mod dma_heap_tests;
pub mod external_memory_host_tests;
pub mod map_placed_tests;
pub mod mapping_tests;
pub mod opaque_and_dma_tests;
pub mod pipeline_barrier_tests;
pub mod requirements_image_tests;
pub mod requirements_tests;
pub mod zero_initialize_device_memory_tests;
pub mod zero_initialize_image_tests;

use crate::vkt::TestCaseGroup;

/// `createMemoryTests` for the `memory` group.
///
/// Upstream registers a dozen more sub-groups here (pipeline_barrier,
/// decompression, ...). They are absent rather
/// than present-and-skipped, so a comparison against `deqp-vk` reports them as missing
/// instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut memory_tests = TestCaseGroup::new("memory");

    memory_tests.add_child(allocation_tests::create_allocation_tests());
    memory_tests.add_child(binding_tests::create_memory_binding_tests());
    memory_tests.add_child(external_memory_host_tests::create_memory_external_memory_host_tests());
    memory_tests.add_child(allocation_tests::create_device_group_allocation_tests());
    memory_tests.add_child(mapping_tests::create_mapping_tests());
    memory_tests.add_child(allocation_tests::create_pageable_allocation_tests());
    memory_tests.add_child(map_placed_tests::create_map_placed_tests());
    memory_tests.add_child(concurrent_access_tests::create_concurrent_access_tests());
    memory_tests.add_child(requirements_tests::create_requirements_tests());
    memory_tests.add_child(dma_heap_tests::create_dma_heap_tests());
    memory_tests.add_child(zero_initialize_device_memory_tests::create_zero_initialize_device_memory_tests());
    memory_tests.add_child(crate::vkt::tests::api::device_memory_report_tests::create_device_memory_report_tests());
    memory_tests.add_child(crate::vkt::tests::api::address_binding_report_tests::create_address_binding_report_tests());
    memory_tests.add_child(decompression_tests::create_memory_decompression_tests());
    memory_tests.add_child(acquire_unmodified_tests::create_external_memory_acquire_unmodified_tests());
    memory_tests.add_child(opaque_and_dma_tests::create_opaque_and_dma_image_tests());
    memory_tests.add_child(pipeline_barrier_tests::create_pipeline_barrier_tests());

    memory_tests
}

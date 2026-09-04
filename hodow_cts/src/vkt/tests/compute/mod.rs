// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod basic_compute_image_tests;
pub mod basic_compute_shader_tests;
pub mod indirect_compute_dispatch_tests;
pub mod zero_initialize_workgroup_memory_tests;

use crate::tcu::TestCaseGroup;
use crate::vk::compute_pipeline::ComputePipelineConstructionType;

/// `createTests` for the `compute` group.
///
/// Upstream registers the whole subtree once per ComputePipelineConstructionType,
/// which is where the `pipeline` / `shader_object_spirv` / `shader_object_binary`
/// level in `dEQP-VK.compute.pipeline.basic.*` comes from. Only the monolithic
/// pipeline type is ported, so only that group is registered - the shader-object
/// groups are absent rather than present-and-skipped, so a comparison against
/// `deqp-vk` shows them as missing instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut compute_tests = TestCaseGroup::new("compute");

    // Kept as a loop even with one element: upstream loops over all three construction
    // types here, and the other two get added to this array as they are ported.
    #[allow(clippy::single_element_loop)]
    for construction_type in [ComputePipelineConstructionType::Pipeline] {
        let mut group = TestCaseGroup::new(construction_type.group_name());
        group.add_child(basic_compute_shader_tests::create_basic_compute_shader_tests(construction_type));
        group.add_child(indirect_compute_dispatch_tests::create_indirect_compute_dispatch_tests(construction_type));
        group.add_child(zero_initialize_workgroup_memory_tests::create_zero_initialize_workgroup_memory_tests(construction_type));
        compute_tests.add_child(group);
    }

    compute_tests
}

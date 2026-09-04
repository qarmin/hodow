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

pub mod basic_compute_extra_tests;
pub mod basic_compute_image_tests;
pub mod basic_compute_shader_tests;
pub mod indirect_compute_dispatch_tests;
pub mod shader_builtin_var_tests;
pub mod workgroup_memory_explicit_layout_alias_tests;
pub mod workgroup_memory_explicit_layout_padding_tests;
pub mod workgroup_memory_explicit_layout_zero_tests;
pub mod zero_initialize_types_tests;
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
///
/// Several upstream groups are split across more than one module here, because they
/// were ported in parallel. The tree they build is merged back into upstream's shape
/// below: the case names are what has to match, not the file layout.
pub fn create_tests() -> TestCaseGroup {
    let mut compute_tests = TestCaseGroup::new("compute");

    // Kept as a loop even with one element: upstream loops over all three construction
    // types here, and the other two get added to this array as they are ported.
    #[allow(clippy::single_element_loop)]
    for construction_type in [ComputePipelineConstructionType::Pipeline] {
        let mut group = TestCaseGroup::new(construction_type.group_name());

        group.add_child(basic_compute_shader_tests::create_basic_compute_shader_tests(construction_type));

        for builtin_group in shader_builtin_var_tests::create_builtin_var_device_group_and_64b_groups() {
            group.add_child(builtin_group);
        }

        group.add_child(indirect_compute_dispatch_tests::create_indirect_compute_dispatch_tests(construction_type));

        // zero_initialize_workgroup_memory: one module owns max_workgroups,
        // specialize_workgroup, max_workgroup_memory and repeat_pipeline, the other
        // owns types, composites and shared_memory_blocks.
        let mut zero_init = zero_initialize_workgroup_memory_tests::create_zero_initialize_workgroup_memory_tests(construction_type);
        for extra in zero_initialize_types_tests::create_types_composites_and_blocks_groups() {
            zero_init.add_child(extra);
        }
        group.add_child(zero_init);

        // workgroup_memory_explicit_layout: the padding module returns the parent
        // group (with padding + size in it), the other two return sub-groups.
        let mut wmel = workgroup_memory_explicit_layout_padding_tests::create_padding_and_size_tests();
        wmel.add_child(workgroup_memory_explicit_layout_alias_tests::create_alias_tests());
        wmel.add_child(workgroup_memory_explicit_layout_zero_tests::create_zero_tests());
        group.add_child(wmel);

        compute_tests.add_child(group);
    }

    compute_tests
}

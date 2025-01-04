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
pub mod construction_type;
pub mod cooperative_matrix_extra_tests;
pub mod cooperative_matrix_float;
pub mod cooperative_matrix_run;
pub mod cooperative_matrix_tests;
pub mod indirect_compute_dispatch_tests;
pub mod isnan_isinf_tests;
pub mod replicated_composites_tests;
pub mod shader_builtin_var_tests;
pub mod workgroup_memory_explicit_layout_alias_tests;
pub mod workgroup_memory_explicit_layout_padding_tests;
pub mod workgroup_memory_explicit_layout_zero_tests;
pub mod zero_initialize_types_tests;
pub mod zero_initialize_workgroup_memory_tests;

use crate::vk::compute_pipeline::ComputePipelineConstructionType;
use crate::vkt::TestCaseGroup;

/// `createTests` for the `compute` group.
///
/// Upstream registers the whole subtree once per ComputePipelineConstructionType,
/// which is where the `pipeline` / `shader_object_spirv` / `shader_object_binary`
/// level in `dEQP-VK.compute.pipeline.basic.*` comes from. The cases are the statics of
/// the shader manifests and carry no construction type, so the two shader-object groups
/// are the same subtree with every case wrapped in `construction_type::ConstructionTypeCase`
/// (see there); a case that never builds its pipeline through `ComputePipelineWrapper` is
/// reported as not ported in those groups instead of as a pass.
///
/// Several upstream groups are split across more than one module here, because they
/// were ported in parallel. The tree they build is merged back into upstream's shape
/// below: the case names are what has to match, not the file layout.
pub fn create_tests() -> TestCaseGroup {
    let mut compute_tests = TestCaseGroup::new("compute");

    for construction_type in [
        ComputePipelineConstructionType::Pipeline,
        ComputePipelineConstructionType::ShaderObjectSpirv,
        ComputePipelineConstructionType::ShaderObjectBinary,
    ] {
        let mut group = TestCaseGroup::new(construction_type.group_name());

        // The builders below take the type for upstream's sake and only the monolithic one is ever passed: the wrapping at the end of the
        // loop is what makes the other two groups run their cases through shader objects.
        let builder_type = ComputePipelineConstructionType::Pipeline;

        let mut basic = basic_compute_shader_tests::create_basic_compute_shader_tests(builder_type);
        for case in replicated_composites_tests::create_replicated_composites_cases() {
            basic.add_child(case);
        }
        group.add_child(basic);

        for builtin_group in shader_builtin_var_tests::create_builtin_var_device_group_and_64b_groups() {
            group.add_child(builtin_group);
        }

        group.add_child(cooperative_matrix_tests::create_cooperative_matrix_tests(
            construction_type,
        ));

        group.add_child(indirect_compute_dispatch_tests::create_indirect_compute_dispatch_tests(
            construction_type,
        ));

        // zero_initialize_workgroup_memory: one module owns max_workgroups,
        // specialize_workgroup, max_workgroup_memory and repeat_pipeline, the other
        // owns types, composites and shared_memory_blocks.
        let mut zero_init =
            zero_initialize_workgroup_memory_tests::create_zero_initialize_workgroup_memory_tests(builder_type);
        for extra in zero_initialize_types_tests::create_types_composites_and_blocks_groups() {
            zero_init.add_child(extra);
        }
        if construction_type == ComputePipelineConstructionType::Pipeline {
            zero_init.add_child(super::spirv_assembly::amber_tests::create_shared_memory_blocks_group());
        }
        group.add_child(zero_init);

        // workgroup_memory_explicit_layout: the padding module returns the parent
        // group (with padding + size in it), the other two return sub-groups.
        let mut wmel = workgroup_memory_explicit_layout_padding_tests::create_padding_and_size_tests();
        wmel.add_child(workgroup_memory_explicit_layout_alias_tests::create_alias_tests());
        wmel.add_child(workgroup_memory_explicit_layout_zero_tests::create_zero_tests());
        if construction_type == ComputePipelineConstructionType::Pipeline {
            for amber_group in
                super::spirv_assembly::amber_tests::create_workgroup_memory_explicit_layout_amber_groups()
            {
                wmel.add_child(amber_group);
            }
        }
        group.add_child(wmel);

        if construction_type != ComputePipelineConstructionType::Pipeline {
            group = group.map_cases(&mut |case| construction_type::ConstructionTypeCase::wrap(case, construction_type));
        }
        compute_tests.add_child(group);
    }

    compute_tests
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Children are registered in upstream order as they are ported: `api`, `create`,
// `link`, `binary`, `pipeline_interaction`, `binding`, `rendering` and `misc` (without `device_features`, which iterates the generated `vkDeviceFeaturesForShaderObject.inl` structure list).

pub mod api_tests;
pub mod binary_device_features_tests;
pub mod binary_tests;
pub mod binding_tests;
pub mod create_tests;
pub mod independent_sets_tests;
pub mod link_tests;
pub mod misc_state_tests;
pub mod misc_tests;
pub mod pipeline_interaction_tests;
pub mod rendering_programs;
pub mod rendering_tests;
pub mod second_device;
pub mod tessellation_programs;
pub mod tessellation_tests;
pub mod util;

use crate::vkt::TestCaseGroup;

/// `createTests` (`shader_object`)
pub fn create_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("shader_object");

    main_group.add_child(api_tests::create_shader_object_api_tests());
    main_group.add_child(create_tests::create_shader_object_create_tests());
    main_group.add_child(link_tests::create_shader_object_link_tests());
    main_group.add_child(binary_tests::create_shader_object_binary_tests());
    main_group.add_child(pipeline_interaction_tests::create_shader_object_pipeline_interaction_tests());
    main_group.add_child(binding_tests::create_shader_object_binding_tests());
    main_group.add_child(rendering_tests::create_shader_object_rendering_tests());
    main_group.add_child(misc_tests::create_shader_object_misc_tests());
    main_group.add_child(tessellation_tests::create_shader_object_tessellation_tests());
    main_group.add_child(independent_sets_tests::create_shader_object_independent_sets_tests());

    main_group
}

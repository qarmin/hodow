// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod depth_stencil_resolve_tests;
pub mod dynamic_rendering_depth_stencil_resolve_tests;
pub mod group_params;
pub mod multisample_resolve_tests;
pub mod multisample_tests;
pub mod render_pass_tests;
pub mod sample_read_tests;
pub mod unused_attachment_tests;
pub mod unused_clear_attachment_tests;

use group_params::{GroupParams, RenderingType};

use crate::tcu::TestCaseGroup;

/// `createRenderPassTests`.
///
/// Only the sub-groups that are actually ported are registered; the rest are absent
/// rather than present-and-skipped, so a comparison against `deqp-vk` reports them as
/// missing instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("renderpasses");
    for mut group in render_pass_tests::create_render_pass_groups() {
        // `depth_stencil_resolve` is a renderpass2 test: it needs the resolve mode
        // fields that only VkSubpassDescription2 carries.
        if group.name() == "renderpass2" {
            group.add_child(depth_stencil_resolve_tests::create_tests());
        }
        tests.add_child(group);
    }
    tests.add_child(create_dynamic_rendering_tests());
    tests
}

/// `createDynamicRenderingTests`.
///
/// Upstream builds four variants; the fourth (`graphics_pipeline_library`) never gets
/// as far as `depth_stencil_resolve`, because `createRenderPassTestsInternal` returns
/// early for a non-monolithic pipeline construction type - so with only that group
/// ported, the variant would be empty and is left out.
fn create_dynamic_rendering_tests() -> TestCaseGroup {
    let mut dynamic_rendering_group = TestCaseGroup::new("dynamic_rendering");
    for (name, use_secondary_cmd_buffer, completely_contains) in [
        ("primary_cmd_buff", false, false),
        ("partial_secondary_cmd_buff", true, false),
        ("complete_secondary_cmd_buff", true, true),
    ] {
        let group_params = GroupParams {
            rendering_type: RenderingType::DynamicRendering,
            use_secondary_cmd_buffer,
            secondary_cmd_buffer_completely_contains_dynamic_renderpass: completely_contains,
        };

        let mut rendering_tests = TestCaseGroup::new(name);
        rendering_tests.add_child(dynamic_rendering_depth_stencil_resolve_tests::create_dynamic_rendering_depth_stencil_resolve_tests(
            group_params,
        ));

        // `suballocationTestGroup`: upstream adds several groups here, of which only
        // `multisample_resolve` is registered for dynamic rendering so far.
        let mut suballocation_test_group = TestCaseGroup::new("suballocation");
        suballocation_test_group.add_child(multisample_resolve_tests::create_multisample_resolve_tests(group_params));
        suballocation_test_group.add_child(unused_clear_attachment_tests::create_unused_clear_attachment_tests(group_params));
        rendering_tests.add_child(suballocation_test_group);

        dynamic_rendering_group.add_child(rendering_tests);
    }
    dynamic_rendering_group
}

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

pub mod clear_some_attachments_tests;
pub mod custom_resolve_tests;
pub mod depth_stencil_resolve_tests;
pub mod depth_stencil_write_conditions_tests;
pub mod dithering_tests;
pub mod dynamic_rendering_depth_stencil_resolve_tests;
pub mod dynamic_rendering_local_read_basic_tests;
pub mod dynamic_rendering_local_read_extra_tests;
pub mod dynamic_rendering_local_read_maint10_tests;
pub mod dynamic_rendering_local_read_tests;
pub mod dynamic_rendering_multiview_clear_tests;
pub mod dynamic_rendering_random_tests;
pub mod dynamic_rendering_tests;
mod exotic_tests;
pub mod group_params;
pub mod load_store_op_none_tests;
mod local_read_m10_programs;
pub mod low_resolution_z_tests;
pub mod mixed_sample_count_tests;
pub mod multiple_subpasses_cmd_buffers_tests;
pub mod multisample_resolve_tests;
pub mod multisample_tests;
pub mod nested_command_buffers_tests;
pub mod no_draw_tests;
pub mod remaining_array_layers_tests;
pub mod render_pass_tests;
pub mod resolve_into_3d_image_tests;
pub mod sample_read_tests;
pub mod sparse_render_target_tests;
pub mod subpass_dependency_external_tests;
pub mod subpass_dependency_self_tests;
pub mod subpass_dependency_tests;
pub mod subpass_merge_feedback_tests;
pub mod unused_attachment_sparse_filling_tests;
pub mod unused_attachment_tests;
pub mod unused_attachments_tests;
pub mod unused_clear_attachment_tests;

use group_params::{GroupParams, RenderingType};

use super::api::copies_buffer_tests::AllocationKind;
use crate::vkt::TestCaseGroup;

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
        if let Some(custom_resolve) = custom_resolve_tests::create_custom_resolve_tests_for_render_pass(group.name()) {
            group.add_child(custom_resolve);
        }
        for exotic in exotic_tests::create_exotic_groups(group.name()) {
            group.add_child(exotic);
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
/// early for a non-monolithic pipeline construction type - so it holds only the groups
/// `render_pass_tests::create_graphics_pipeline_library_group` ports.
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
        for exotic in exotic_tests::create_exotic_groups(&format!("dynamic_rendering.{name}")) {
            rendering_tests.add_child(exotic);
        }
        if let Some(custom_resolve) =
            custom_resolve_tests::create_custom_resolve_tests_for_dynamic_rendering(group_params)
        {
            rendering_tests.add_child(custom_resolve);
        }
        // `createDynamicRenderingLocalReadTests`; the null, remapping to high locations and attachment mapping cases sit behind `!useSecondaryCmdBuffer`.
        if !use_secondary_cmd_buffer {
            rendering_tests.add_child(dynamic_rendering_local_read_tests::create_dynamic_rendering_local_read_tests());
        } else if !completely_contains {
            rendering_tests
                .add_child(dynamic_rendering_local_read_tests::create_dynamic_rendering_local_read_secondary_tests());
        }
        rendering_tests.add_child(
            dynamic_rendering_depth_stencil_resolve_tests::create_dynamic_rendering_depth_stencil_resolve_tests(
                group_params,
            ),
        );

        rendering_tests.add_child(dithering_tests::create_dithering_tests(group_params));

        // Upstream adds it only when no secondary command buffer is used.
        if !use_secondary_cmd_buffer {
            rendering_tests.add_child(dynamic_rendering_random_tests::create_dynamic_rendering_random_tests());
            rendering_tests.add_child(
                dynamic_rendering_local_read_maint10_tests::create_dynamic_rendering_local_read_maint10_tests(),
            );
            rendering_tests.add_child(dynamic_rendering_tests::create_dynamic_rendering_basic_tests());
            rendering_tests
                .add_child(unused_attachments_tests::create_dynamic_rendering_unused_attachments_tests(false));
            rendering_tests
                .add_child(dynamic_rendering_multiview_clear_tests::create_dynamic_rendering_multiview_clear_tests());
            rendering_tests.add_child(nested_command_buffers_tests::create_nested_command_buffer_tests(
                group_params,
            ));
        } else if !completely_contains {
            rendering_tests
                .add_child(unused_attachments_tests::create_dynamic_rendering_unused_attachments_tests(true));
        }

        // `suballocationTestGroup`: upstream adds several groups here, of which only
        // `multisample_resolve` is registered for dynamic rendering so far.
        let mut suballocation_test_group = TestCaseGroup::new("suballocation");
        // What `addRenderPassTests` adds for the primary command buffer variant.
        if !use_secondary_cmd_buffer {
            render_pass_tests::add_dynamic_rendering_core_groups(
                &mut suballocation_test_group,
                AllocationKind::Suballocated,
            );
        } else if completely_contains {
            render_pass_tests::add_dynamic_rendering_complete_secondary_groups(
                &mut suballocation_test_group,
                AllocationKind::Suballocated,
            );
        }
        // `createRenderPassSampleReadTests` and `createRenderPassMultisampleTests`: not for a secondary command buffer that only partially contains the render pass.
        if use_secondary_cmd_buffer == completely_contains {
            let render_pass_type = if completely_contains {
                render_pass_tests::RenderPassType::DynamicRenderingCompleteSecondary
            } else {
                render_pass_tests::RenderPassType::DynamicRendering
            };
            suballocation_test_group.add_child(sample_read_tests::create_sample_read_tests(render_pass_type));
            suballocation_test_group.add_child(multisample_tests::create_multisample_tests(render_pass_type));
        }
        suballocation_test_group.add_child(
            unused_attachment_sparse_filling_tests::create_unused_attachment_sparse_filling_tests(group_params),
        );
        suballocation_test_group.add_child(multisample_resolve_tests::create_multisample_resolve_tests(
            group_params,
        ));
        suballocation_test_group.add_child(low_resolution_z_tests::create_render_pass_low_resolution_z_tests(
            group_params,
        ));
        suballocation_test_group.add_child(load_store_op_none_tests::create_render_pass_load_store_op_none_tests(
            group_params,
        ));
        suballocation_test_group.add_child(unused_clear_attachment_tests::create_unused_clear_attachment_tests(
            group_params,
        ));
        if use_secondary_cmd_buffer == completely_contains {
            suballocation_test_group.add_child(clear_some_attachments_tests::create_clear_some_attachments_tests(
                group_params,
            ));
        }
        suballocation_test_group.add_child(sparse_render_target_tests::create_sparse_render_target_tests(
            group_params,
        ));
        suballocation_test_group.add_child(subpass_dependency_tests::create_subpass_dependency_tests(group_params));
        rendering_tests.add_child(suballocation_test_group);
        if !use_secondary_cmd_buffer || completely_contains {
            let mut dedicated_allocation_test_group = TestCaseGroup::new("dedicated_allocation");
            if !use_secondary_cmd_buffer {
                render_pass_tests::add_dynamic_rendering_core_groups(
                    &mut dedicated_allocation_test_group,
                    AllocationKind::Dedicated,
                );
            } else {
                render_pass_tests::add_dynamic_rendering_complete_secondary_groups(
                    &mut dedicated_allocation_test_group,
                    AllocationKind::Dedicated,
                );
            }
            rendering_tests.add_child(dedicated_allocation_test_group);
        }
        if !use_secondary_cmd_buffer {
            rendering_tests.add_child(no_draw_tests::create_render_pass_no_draw_tests(group_params));
        }

        dynamic_rendering_group.add_child(rendering_tests);
    }
    // The `graphics_pipeline_library` variant: only the groups of `addRenderPassTests` have it so far.
    let mut graphics_pipeline_library_group = render_pass_tests::create_graphics_pipeline_library_group();
    for exotic in exotic_tests::create_exotic_groups("dynamic_rendering.graphics_pipeline_library") {
        graphics_pipeline_library_group.add_child(exotic);
    }
    for local_read in exotic_tests::create_gpl_local_read_groups() {
        graphics_pipeline_library_group.add_child(local_read);
    }
    dynamic_rendering_group.add_child(graphics_pipeline_library_group);
    dynamic_rendering_group
}

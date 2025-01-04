// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawImageObjectUtil.cpp (the 2D transition helpers)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The layout-transition helpers and `DrawTestsBaseClass` (`base_class`) other groups (query_pool,
// conditional_rendering, ...) borrow from the Draw framework are here, and the part of the `draw`
// test group that is ported (see `named_children`). The
// nested secondary command buffer variants hold only `basic_draw`.

pub mod ahb_tests;
pub mod base_class;
pub mod basic_tests;
pub mod concurrent_tests;
pub mod depth_bias_tests;
pub mod depth_clamp_tests;
pub mod differing_interpolation_tests;
pub mod discard_rectangles_tests;
pub mod explicit_vertex_parameter_tests;
pub mod indexed_tests;
pub mod indirect_instanced_tests;
pub mod indirect_tests;
pub mod instanced_tests;
pub mod inverted_depth_ranges_tests;
pub mod large_viewport_tests;
pub mod linear_interpolation_tests;
pub mod misc_tests;
pub mod multi_draw_tests;
pub mod multiple_clears_tests;
pub mod multiple_interpolation_tests;
pub mod negative_viewport_height_tests;
pub mod non_line_tests;
pub mod output_location_tests;
pub mod point_clamp_tests;
pub mod sample_attribute_tests;
pub mod scissor_tests;
pub mod shader_draw_parameters_tests;
pub mod shader_invocation_tests;
pub mod shader_layer_tests;
pub mod shader_viewport_index_tests;
pub mod simple_tests;
pub mod util;
pub mod vertex_attrib_divisor_tests;

use base_class::GroupParams;
use vulkanalia::prelude::v1_0::*;

use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vkt::TestCaseGroup;

/// `Draw::transition2DImage`
#[allow(clippy::too_many_arguments)]
pub fn transition_2d_image(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    aspect_mask: vk::ImageAspectFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
    num_layers: u32,
) {
    let barrier = make_image_memory_barrier(
        src_access_mask,
        dst_access_mask,
        old_layout,
        new_layout,
        image,
        make_image_subresource_range(aspect_mask, 0, 1, 0, num_layers),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage_mask,
            dst_stage_mask,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

/// `Draw::initialTransitionColor2DImage`
pub fn initial_transition_color_2d_image(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    layout: vk::ImageLayout,
    dst_access_mask: vk::AccessFlags,
    dst_stage_mask: vk::PipelineStageFlags,
    num_layers: u32,
) {
    transition_2d_image(
        device,
        cmd_buffer,
        image,
        vk::ImageAspectFlags::COLOR,
        vk::ImageLayout::UNDEFINED,
        layout,
        vk::AccessFlags::empty(),
        dst_access_mask,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        dst_stage_mask,
        num_layers,
    );
}

/// `Draw::initialTransitionDepth2DImage`
pub fn initial_transition_depth_2d_image(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    layout: vk::ImageLayout,
    dst_access_mask: vk::AccessFlags,
    dst_stage_mask: vk::PipelineStageFlags,
) {
    transition_2d_image(
        device,
        cmd_buffer,
        image,
        vk::ImageAspectFlags::DEPTH,
        vk::ImageLayout::UNDEFINED,
        layout,
        vk::AccessFlags::empty(),
        dst_access_mask,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        dst_stage_mask,
        1,
    );
}

/// `createChildren`, into a group of the given name.
fn named_children(name: &str, group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    if !group_params.nested_secondary_cmd_buffer {
        group.add_child(concurrent_tests::create_concurrent_draw_tests(group_params));
        group.add_child(simple_tests::create_simple_draw_tests(group_params));
        group.add_child(indexed_tests::create_indexed_draw_tests(group_params));
        group.add_child(indirect_tests::create_indirect_draw_tests(group_params));
    }
    group.add_child(basic_tests::create_basic_draw_tests(group_params));
    if !group_params.nested_secondary_cmd_buffer {
        group.add_child(instanced_tests::create_instanced_tests(group_params));
        group.add_child(shader_draw_parameters_tests::create_shader_draw_parameters_tests(
            group_params,
        ));
        group.add_child(negative_viewport_height_tests::create_negative_viewport_height_tests(
            group_params,
        ));
        group.add_child(negative_viewport_height_tests::create_zero_viewport_height_tests(
            group_params,
        ));
        group.add_child(negative_viewport_height_tests::create_off_screen_viewport_tests(
            group_params,
        ));
        group.add_child(inverted_depth_ranges_tests::create_inverted_depth_ranges_tests(
            group_params,
        ));
        group.add_child(differing_interpolation_tests::create_differing_interpolation_tests(
            group_params,
        ));
        group.add_child(shader_layer_tests::create_shader_layer_tests(group_params));
        group.add_child(shader_viewport_index_tests::create_shader_viewport_index_tests(
            group_params,
        ));
        group.add_child(scissor_tests::create_scissor_tests(group_params));
        group.add_child(multiple_interpolation_tests::create_multiple_interpolation_tests(
            group_params,
        ));
        group.add_child(linear_interpolation_tests::create_multisample_linear_interpolation_tests(group_params));
        group.add_child(discard_rectangles_tests::create_discard_rectangles_tests(group_params));
        group.add_child(explicit_vertex_parameter_tests::create_explicit_vertex_parameter_tests(
            group_params,
        ));
        group.add_child(depth_clamp_tests::create_depth_clamp_tests(group_params));
        group.add_child(multiple_clears_tests::create_multiple_clears_tests(group_params));
        group.add_child(vertex_attrib_divisor_tests::create_vertex_attribute_divisor_tests(
            group_params,
        ));
        group.add_child(sample_attribute_tests::create_sample_attribute_tests(group_params));
        group.add_child(indirect_instanced_tests::create_indirect_instanced_tests(group_params));
        group.add_child(large_viewport_tests::create_large_viewport_tests(group_params));
        group.add_child(multi_draw_tests::create_draw_multi_ext_tests(group_params));

        if !group_params.use_dynamic_rendering {
            // amber tests - no support for dynamic rendering
            group.add_child(depth_bias_tests::create_depth_bias_tests());
            group.add_child(output_location_tests::create_output_location_tests());
            group.add_child(shader_invocation_tests::create_shader_invocation_tests());
            group.add_child(ahb_tests::create_ahb_tests());

            // subpasses can't be translated to dynamic rendering
            group.add_child(non_line_tests::create_draw_non_line_tests());
        }

        group.add_child(ahb_tests::create_ahb_external_format_resolve_tests(group_params));
    }
    group
}

/// `createTests` - the `draw` group.
pub fn create_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("draw");

    // Draw using renderpass object
    let mut renderpass_group = named_children("renderpass", GroupParams::default());
    renderpass_group.add_child(point_clamp_tests::create_draw_point_clamp_tests());
    main_group.add_child(renderpass_group);

    // Draw using VK_KHR_dynamic_rendering
    let dynamic = GroupParams {
        use_dynamic_rendering: true,
        ..GroupParams::default()
    };
    let mut dynamic_rendering_group = TestCaseGroup::new("dynamic_rendering");
    dynamic_rendering_group.add_child(named_children("primary_cmd_buff", dynamic));
    dynamic_rendering_group.add_child(named_children(
        "partial_secondary_cmd_buff",
        GroupParams {
            use_secondary_cmd_buffer: true,
            ..dynamic
        },
    ));
    dynamic_rendering_group.add_child(named_children(
        "complete_secondary_cmd_buff",
        GroupParams {
            use_secondary_cmd_buffer: true,
            secondary_cmd_buffer_completely_contains_dynamic_renderpass: true,
            ..dynamic
        },
    ));
    dynamic_rendering_group.add_child(named_children(
        "nested_partial_secondary_cmd_buff",
        GroupParams {
            use_secondary_cmd_buffer: true,
            nested_secondary_cmd_buffer: true,
            ..dynamic
        },
    ));
    dynamic_rendering_group.add_child(named_children(
        "nested_complete_secondary_cmd_buff",
        GroupParams {
            use_secondary_cmd_buffer: true,
            secondary_cmd_buffer_completely_contains_dynamic_renderpass: true,
            nested_secondary_cmd_buffer: true,
            ..dynamic
        },
    ));
    main_group.add_child(dynamic_rendering_group);

    main_group
}

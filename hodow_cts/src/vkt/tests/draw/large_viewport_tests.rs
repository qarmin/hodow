// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawLargeViewportTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_large_viewport::LARGE_VIEWPORT;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, RGBA, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::GroupParams;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, DrawRecorder, ImageWithBuffer, clear_color_image, clear_value_color, create_draw_pipeline,
    make_color_render_pass, rect_2d, viewport,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 64;
const HEIGHT: u32 = 64;

#[derive(Clone, Copy, PartialEq, Eq)]
enum ViewportCase {
    NegativeYMaxHeight,
    NegativeXMaxWidth,
    NegativeYMaxHeightOverlap,
    NegativeXMaxWidthOverlap,
}

#[derive(Clone, Copy)]
struct TestParams {
    viewport_case: ViewportCase,
    dynamic_viewport: bool,
    group_params: GroupParams,
}

struct LargeViewportTestCase {
    name: String,
    params: TestParams,
}

impl TestCase for LargeViewportTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        LARGE_VIEWPORT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LargeViewportTestInstance {
            context,
            params: self.params,
        })
    }
}

struct LargeViewportTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `getViewport`
fn get_viewport(context: &Context<'_>, viewport_case: ViewportCase, image_size: (u32, u32)) -> vk::Viewport {
    let limits = &context.get_device_properties().limits;
    let max_viewport_dimension_x = limits.max_viewport_dimensions[0];
    let max_viewport_dimension_y = limits.max_viewport_dimensions[1];
    let bounds_max = limits.viewport_bounds_range[1];

    match viewport_case {
        ViewportCase::NegativeYMaxHeight => viewport(
            0.0,
            -bounds_max,
            image_size.0 as f32,
            max_viewport_dimension_y as f32,
            0.0,
            1.0,
        ),
        ViewportCase::NegativeXMaxWidth => viewport(
            -bounds_max,
            0.0,
            max_viewport_dimension_x as f32,
            image_size.1 as f32,
            0.0,
            1.0,
        ),
        ViewportCase::NegativeYMaxHeightOverlap => viewport(
            0.0,
            -(max_viewport_dimension_y as f32) * 0.75,
            image_size.0 as f32,
            max_viewport_dimension_y as f32,
            0.0,
            1.0,
        ),
        ViewportCase::NegativeXMaxWidthOverlap => viewport(
            -(max_viewport_dimension_x as f32) * 0.75,
            0.0,
            max_viewport_dimension_x as f32,
            image_size.1 as f32,
            0.0,
            1.0,
        ),
    }
}

impl TestInstance for LargeViewportTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();

        let image_size = (WIDTH, HEIGHT);
        let render_area = rect_2d(WIDTH, HEIGHT);
        let image_usage = vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::COLOR_ATTACHMENT;
        let image_format = vk::Format::R8G8B8A8_UNORM;
        let tcu_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let clear_color = RGBA::black().to_vec().m_data;

        // Large view port
        let custom_viewport = get_viewport(context, params.viewport_case, image_size);
        let num_viewports = 1u32;

        // Output image
        let color_buffer = ImageWithBuffer::new(context, WIDTH, HEIGHT, image_format, image_usage, 4)?;

        // Render pass
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let (render_pass, frame_buffer) = if dynamic_rendering {
            (None, None)
        } else {
            let render_pass = make_color_render_pass(
                device,
                image_format,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::STORE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?;
            let frame_buffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], WIDTH, HEIGHT, 1)?;
            (Some(render_pass), Some(frame_buffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = frame_buffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Shader modules
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Pipeline
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP);
        state.scissors = vec![render_area];
        state.viewport_count = num_viewports;
        if params.dynamic_viewport {
            state.dynamic_states = vec![vk::DynamicState::VIEWPORT];
        } else {
            state.viewports = vec![custom_viewport; num_viewports as usize];
        }
        if dynamic_rendering {
            state.rendering_format = Some(image_format);
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        // Command pool and command buffer
        let cmd_pool = make_command_pool(device, queue_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let sec_cmd_buffer = if params.group_params.use_secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        // Clear
        clear_color_image(
            context,
            color_buffer.image.get(),
            clear_color,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            1,
            1,
        )?;

        // Execute draw
        let recorder = DrawRecorder {
            device,
            group_params: params.group_params,
            format: image_format,
            image_view: *color_buffer.view,
            render_area,
            clear_value: clear_value_color(clear_color),
            image_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            load_op: vk::AttachmentLoadOp::CLEAR,
            render_pass: render_pass_handle,
            framebuffer: framebuffer_handle,
            layer_count: 1,
            view_mask: 0,
        };
        recorder.record(
            *cmd_buffer,
            sec_cmd_buffer.as_ref().map(|buffer| **buffer),
            |_| {},
            |cmd| {
                unsafe {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                    if params.dynamic_viewport {
                        device.cmd_set_viewport(cmd, 0, &[custom_viewport]);
                    }
                    device.cmd_draw(cmd, 4, 1, 0, 0);
                }
                Ok(())
            },
            |cmd| {
                copy_image_to_buffer(
                    device,
                    cmd,
                    color_buffer.image.get(),
                    color_buffer.buffer.get(),
                    WIDTH,
                    HEIGHT,
                )
            },
        )?;

        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Get results
        let result_bytes = color_buffer.read_bytes(device)?;

        let mut reference = TextureLevel::new(tcu_format, WIDTH, HEIGHT, 1)?;
        let channel_threshold = 0.005f32; // 1/255 < 0.005 < 2/255
        let threshold = [channel_threshold, channel_threshold, channel_threshold, 0.0];

        {
            let mut ref_access = reference.get_access();
            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    ref_access.set_pixel(clear_color, x, y, 0);
                }
            }

            if params.viewport_case == ViewportCase::NegativeYMaxHeightOverlap
                || params.viewport_case == ViewportCase::NegativeXMaxWidthOverlap
            {
                let expected_color = RGBA::red().to_vec().m_data;

                for y in 0..HEIGHT {
                    for x in 0..WIDTH {
                        let ndc_x = (2.0 * ((x as f32 + 0.5) - custom_viewport.x) / custom_viewport.width) - 1.0;
                        let ndc_y = (2.0 * ((y as f32 + 0.5) - custom_viewport.y) / custom_viewport.height) - 1.0;

                        if (-1.0..=1.0).contains(&ndc_y) && (-1.0..=1.0).contains(&ndc_x) {
                            ref_access.set_pixel(expected_color, x, y, 0);
                        } else {
                            ref_access.set_pixel(clear_color, x, y, 0);
                        }
                    }
                }
            }
        }

        let result = ConstPixelBufferAccess::new(tcu_format, [WIDTH, HEIGHT, 1], result_bytes);

        if !float_threshold_compare(&reference.get_const_access(), &result, threshold).ok {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createLargeViewportTests`
pub fn create_large_viewport_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("large_viewport");

    for (viewport_case, name) in [
        (ViewportCase::NegativeYMaxHeight, "large_negative_y_max_height"),
        (ViewportCase::NegativeXMaxWidth, "large_negative_x_max_width"),
        (
            ViewportCase::NegativeYMaxHeightOverlap,
            "large_negative_y_max_height_overlap",
        ),
        (
            ViewportCase::NegativeXMaxWidthOverlap,
            "large_negative_x_max_width_overlap",
        ),
    ] {
        for dynamic_viewport in [true, false] {
            let params = TestParams {
                viewport_case,
                dynamic_viewport,
                group_params,
            };
            let test_name = format!("{name}{}", if dynamic_viewport { "_dynamic" } else { "" });
            group.add_child(Box::new(LargeViewportTestCase {
                name: test_name,
                params,
            }) as Box<dyn TestCase>);
        }
    }
    group
}

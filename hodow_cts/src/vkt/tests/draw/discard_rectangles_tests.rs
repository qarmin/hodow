// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawDiscardRectanglesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDiscardRectanglesExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::draw_discard_rectangles::DISCARD_RECTANGLES;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::initial_transition_color_2d_image;
use crate::vkt::tests::draw::util::{
    DiscardRectangleState, DrawPipelineState, DrawRecorder, ImageWithBuffer, clear_value_color, create_draw_pipeline,
    make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    Inclusive,
    Exclusive,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestScissorMode {
    None,
    Static,
    Dynamic,
}

#[derive(Clone, Copy)]
struct TestParams {
    test_mode: TestMode,
    num_rectangles: u32,
    dynamic_discard_rectangles: bool,
    scissor_mode: TestScissorMode,
    group_params: GroupParams,
}

/// `generateDiscardRectangles`
fn generate_discard_rectangles(render_size: (u32, u32), num_rect: u32) -> Vec<vk::Rect2D> {
    let cell_height = render_size.1 - 10;
    let cell_width = (render_size.0 - 10) / (2 * num_rect - 1);

    (0..num_rect)
        .map(|i| vk::Rect2D {
            offset: vk::Offset2D {
                x: (5 + i * 2 * cell_width) as i32,
                y: 5,
            },
            extent: vk::Extent2D {
                width: cell_width,
                height: cell_height,
            },
        })
        .collect()
}

/// `generateReferenceImage` - renders a colorful grid of rectangles.
#[allow(clippy::too_many_arguments)]
fn generate_reference_image(
    format: TextureFormat,
    render_size: (u32, u32),
    test_mode: TestMode,
    color: [f32; 4],
    num_rectangles: u32,
    rectangles: &[vk::Rect2D],
    enable_scissor: bool,
    scissor: vk::Rect2D,
) -> Result<TextureLevel, TestError> {
    let mut image = TextureLevel::new(format, render_size.0, render_size.1, 1)?;
    let green = [0.0f32, 1.0, 0.0, 1.0];
    let rect_color = if test_mode == TestMode::Inclusive { green } else { color };
    let clear_color = if test_mode == TestMode::Inclusive { color } else { green };

    let mut access = image.get_access();
    let mut fill = |x0: u32, y0: u32, width: u32, height: u32, fill_color: [f32; 4]| {
        for y in y0..y0 + height {
            for x in x0..x0 + width {
                access.set_pixel(fill_color, x, y, 0);
            }
        }
    };

    if !enable_scissor {
        // Clear the image with clearColor
        fill(0, 0, render_size.0, render_size.1, clear_color);

        // Now draw the discard rectangles taking into account the selected mode.
        for rectangle in rectangles.iter().take(num_rectangles as usize) {
            fill(
                rectangle.offset.x as u32,
                rectangle.offset.y as u32,
                rectangle.extent.width,
                rectangle.extent.height,
                rect_color,
            );
        }
    } else {
        // Clear the image with the original clear color
        fill(0, 0, render_size.0, render_size.1, color);
        // Clear the scissor are with the clearColor which depends on the selected mode
        fill(
            scissor.offset.x as u32,
            scissor.offset.y as u32,
            scissor.extent.width,
            scissor.extent.height,
            clear_color,
        );

        // Now draw the discard rectangles taking into account both the scissor area and
        // the selected mode.
        for rectangle in rectangles.iter().take(num_rectangles as usize) {
            for x in rectangle.offset.x as u32..rectangle.offset.x as u32 + rectangle.extent.width {
                for y in rectangle.offset.y as u32..rectangle.offset.y as u32 + rectangle.extent.height {
                    if x >= scissor.offset.x as u32
                        && x < scissor.offset.x as u32 + scissor.extent.width
                        && y >= scissor.offset.y as u32
                        && y < scissor.offset.y as u32 + scissor.extent.height
                    {
                        fill(x, y, 1, 1, rect_color);
                    }
                }
            }
        }
    }
    Ok(image)
}

struct DiscardRectanglesTestCase {
    name: String,
    params: TestParams,
}

impl TestCase for DiscardRectanglesTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DiscardRectanglesTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_discard_rectangles")?;
        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        // Check for VK_EXT_discard_rectangles support and maximum number of active discard rectangles
        let mut discard_rectangle_properties = vk::PhysicalDeviceDiscardRectanglePropertiesEXT::default();
        let mut physical_device_properties =
            vk::PhysicalDeviceProperties2::builder().push_next(&mut discard_rectangle_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut physical_device_properties)
        };

        if discard_rectangle_properties.max_discard_rectangles == 0 {
            return Err(TestError::NotSupported(
                "Implementation doesn't support discard rectangles".to_string(),
            ));
        }

        if discard_rectangle_properties.max_discard_rectangles < self.params.num_rectangles {
            return Err(TestError::NotSupported(format!(
                "Implementation doesn't support the required number of discard rectangles: {} < {}",
                discard_rectangle_properties.max_discard_rectangles, self.params.num_rectangles
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DISCARD_RECTANGLES.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DiscardRectanglesTestInstance {
            context,
            params: self.params,
        })
    }
}

struct DiscardRectanglesTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for DiscardRectanglesTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let clear_color = [1.0f32, 0.0, 0.0, 1.0];
        let render_size = (340u32, 100u32);
        let discard_rectangle_mode = if params.test_mode == TestMode::Exclusive {
            vk::DiscardRectangleModeEXT::EXCLUSIVE
        } else {
            vk::DiscardRectangleModeEXT::INCLUSIVE
        };
        let rect_scissor = vk::Rect2D {
            offset: vk::Offset2D { x: 90, y: 25 },
            extent: vk::Extent2D { width: 160, height: 50 },
        };
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let dynamic_rendering = params.group_params.use_dynamic_rendering;

        // Color attachment
        let color_target = ImageWithBuffer::new(
            context,
            render_size.0,
            render_size.1,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        // Initialize the pipeline and other variables
        // Draw a quad covering the whole framebuffer
        let vertices: [[f32; 4]; 4] = [
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let render_pass = make_color_render_pass(
                device,
                color_format,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::STORE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?;
            let framebuffer = make_framebuffer(
                device,
                *render_pass,
                &[*color_target.view],
                render_size.0,
                render_size.1,
                1,
            )?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let rectangles = generate_discard_rectangles(render_size, params.num_rectangles);

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .with_position_input()
            .with_full_viewport(render_size.0, render_size.1);
        if params.scissor_mode != TestScissorMode::None {
            state.scissors = vec![rect_scissor];
        }
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.discard_rectangles = Some(DiscardRectangleState {
            mode: discard_rectangle_mode,
            count: params.num_rectangles,
            rectangles: rectangles.clone(),
            dynamic: params.dynamic_discard_rectangles,
        });
        if params.dynamic_discard_rectangles {
            state.dynamic_states.push(vk::DynamicState::DISCARD_RECTANGLE_EXT);
        }
        if params.scissor_mode == TestScissorMode::Dynamic {
            state.dynamic_states.push(vk::DynamicState::SCISSOR);
        }
        if dynamic_rendering {
            state.rendering_format = Some(color_format);
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
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

        // Write command buffers and submit it
        let recorder = DrawRecorder {
            device,
            group_params: params.group_params,
            format: color_format,
            image_view: *color_target.view,
            render_area: rect_2d(render_size.0, render_size.1),
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
            |cmd| {
                // `preRenderCommands`
                if dynamic_rendering {
                    initial_transition_color_2d_image(
                        device,
                        cmd,
                        color_target.image.get(),
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::PipelineStageFlags::TRANSFER,
                        1,
                    );
                }
            },
            |cmd| {
                // `drawCommands`
                unsafe {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    if params.dynamic_discard_rectangles {
                        device.cmd_set_discard_rectangle_ext(cmd, 0, &rectangles[..params.num_rectangles as usize]);
                    }
                    if params.scissor_mode == TestScissorMode::Dynamic {
                        device.cmd_set_scissor(cmd, 0, &[rect_scissor]);
                    }
                    device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0); // two triangles
                }
                Ok(())
            },
            |cmd| {
                copy_image_to_buffer(
                    device,
                    cmd,
                    color_target.image.get(),
                    color_target.buffer.get(),
                    render_size.0,
                    render_size.1,
                )
            },
        )?;

        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Verify results
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let result_bytes = color_target.read_bytes(device)?;
        let result_image = ConstPixelBufferAccess::new(format, [render_size.0, render_size.1, 1], result_bytes);
        let reference_image = generate_reference_image(
            format,
            render_size,
            params.test_mode,
            clear_color,
            params.num_rectangles,
            &rectangles,
            params.scissor_mode != TestScissorMode::None,
            rect_scissor,
        )?;
        if !float_threshold_compare(&reference_image.get_const_access(), &result_image, [0.02; 4]).ok {
            return Ok(TestStatus::fail("Rendered image is not correct"));
        }
        Ok(TestStatus::pass("OK"))
    }
}

/// `createDiscardRectanglesTests`
pub fn create_discard_rectangles_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("discard_rectangles");
    let num_rect = [1u32, 2, 3, 4, 8, 16];
    let mode_name = [(TestMode::Inclusive, "inclusive_"), (TestMode::Exclusive, "exclusive_")];
    let scissor_name = [
        (TestScissorMode::None, ""),
        (TestScissorMode::Static, "scissor_"),
        (TestScissorMode::Dynamic, "dynamic_scissor_"),
    ];
    let dynamic_name = [(false, ""), (true, "dynamic_discard_")];

    for (dynamic, dynamic_prefix) in dynamic_name {
        for (scissor_mode, scissor_prefix) in scissor_name {
            for (test_mode, mode_prefix) in mode_name {
                for rect in num_rect {
                    let params = TestParams {
                        test_mode,
                        num_rectangles: rect,
                        dynamic_discard_rectangles: dynamic,
                        scissor_mode,
                        group_params,
                    };
                    let name = format!("{dynamic_prefix}{scissor_prefix}{mode_prefix}rect_{rect}");
                    group.add_child(Box::new(DiscardRectanglesTestCase { name, params }) as Box<dyn TestCase>);
                }
            }
        }
    }
    group
}

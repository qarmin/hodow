// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawNegativeViewportHeightTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `createZeroViewportHeightTests` builds its sub-group with
// `zeroViewportHeight` false, exactly as upstream does, so `zero_viewport_height` repeats `negative_viewport_height`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_negative_viewport_height::{NEGATIVE_VIEWPORT_HEIGHT, OFFSCREEN_VIEWPORT};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, Random, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, DrawRecorder, ImageWithBuffer, clear_value_color, copy_general_image_to_buffer,
    create_draw_pipeline, make_color_render_pass, pre_render_clear_attachment_optimal, pre_render_clear_general,
    rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: i32 = 256;
const HEIGHT: i32 = WIDTH / 2;
const COLOR_ATTACHMENT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy)]
struct TestParams {
    front_face: vk::FrontFace,
    cull_mode: vk::CullModeFlags,
    zero_viewport_height: bool,
    group_params: GroupParams,
}

struct NegativeViewportHeightTest {
    name: String,
    params: TestParams,
}

impl TestCase for NegativeViewportHeightTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        context.require_device_functionality("VK_KHR_maintenance1")
    }

    fn programs(&self) -> BinaryCollection {
        NEGATIVE_VIEWPORT_HEIGHT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NegativeViewportHeightTestInstance {
            context,
            params: self.params,
        })
    }
}

struct NegativeViewportHeightTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl NegativeViewportHeightTestInstance<'_> {
    /// `isCulled` - determine if a triangle with `triangle_face` orientation will be culled or not
    fn is_culled(&self, triangle_face: vk::FrontFace) -> bool {
        let is_front_facing = triangle_face == self.params.front_face;

        if self.params.cull_mode == vk::CullModeFlags::FRONT && is_front_facing {
            return true;
        }
        if self.params.cull_mode == vk::CullModeFlags::BACK && !is_front_facing {
            return true;
        }

        self.params.cull_mode == vk::CullModeFlags::FRONT_AND_BACK
    }

    /// `generateReferenceImage`
    fn generate_reference_image(&self) -> Result<TextureLevel, TestError> {
        const { assert!(HEIGHT == WIDTH / 2) };

        let mut image = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            WIDTH as u32,
            HEIGHT as u32,
            1,
        )?;
        {
            let mut access = image.get_access();
            let blue = [0.125f32, 0.25, 0.5, 1.0];
            let white = [1.0f32; 4];
            let gray = [0.5f32, 0.5, 0.5, 1.0];

            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    access.set_pixel(blue, x as u32, y as u32, 0);
                }
            }

            // Zero viewport height
            if self.params.zero_viewport_height {
                return Ok(image);
            }

            // Negative viewport height
            let p1 = (HEIGHT as f32 * (1.0 - 0.6) / 2.0) as i32;
            let p2 = p1 + (HEIGHT as f32 * (2.0 * 0.6) / 2.0) as i32;

            // left triangle (CCW -> CW after y-flip)
            if !self.is_culled(vk::FrontFace::CLOCKWISE) {
                let color = if self.params.front_face == vk::FrontFace::CLOCKWISE {
                    white
                } else {
                    gray
                };

                for y in p1..=p2 {
                    for x in p1..y {
                        access.set_pixel(color, x as u32, y as u32, 0);
                    }
                }
            }

            // right triangle (CW -> CCW after y-flip)
            if !self.is_culled(vk::FrontFace::COUNTER_CLOCKWISE) {
                let color = if self.params.front_face == vk::FrontFace::COUNTER_CLOCKWISE {
                    white
                } else {
                    gray
                };

                for y in p1..=p2 {
                    for x in (WIDTH - y)..(p2 + HEIGHT) {
                        access.set_pixel(color, x as u32, y as u32, 0);
                    }
                }
            }
        }
        Ok(image)
    }
}

impl TestInstance for NegativeViewportHeightTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let alloc_context = context;

        // Vertex data
        let vertex_data: [[f32; 4]; 6] = [
            // CCW triangle
            [-0.8, -0.6, 0.0, 1.0], //  0-----2
            [-0.8, 0.6, 0.0, 1.0],  //   |  /
            [-0.2, -0.6, 0.0, 1.0], //  1|/
            // CW triangle
            [0.2, -0.6, 0.0, 1.0], //  0-----1
            [0.8, -0.6, 0.0, 1.0], //    \  |
            [0.8, 0.6, 0.0, 1.0],  //      \|2
        ];
        let vertex_buffer = create_host_buffer(alloc_context, &vertex_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let target_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let target = ImageWithBuffer::new(
            context,
            WIDTH as u32,
            HEIGHT as u32,
            COLOR_ATTACHMENT_FORMAT,
            target_usage,
            4,
        )?;

        // Render pass and framebuffer
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let render_pass = make_color_render_pass(
                device,
                COLOR_ATTACHMENT_FORMAT,
                vk::AttachmentLoadOp::LOAD,
                vk::AttachmentStoreOp::STORE,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
            )?;
            let framebuffer = make_framebuffer(device, *render_pass, &[*target.view], WIDTH as u32, HEIGHT as u32, 1)?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Graphics pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_position_input();
        state.scissors = vec![rect_2d(WIDTH as u32, HEIGHT as u32)];
        state.viewport_count = 1;
        state.dynamic_states = vec![vk::DynamicState::VIEWPORT];
        state.rasterization.cull_mode = params.cull_mode;
        state.rasterization.front_face = params.front_face;
        state.rasterization.depth_bias_enable = vk::FALSE;
        if dynamic_rendering {
            state.rendering_format = Some(COLOR_ATTACHMENT_FORMAT);
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

        // Set up the viewport and draw
        let viewport = vk::Viewport {
            x: 0.0,
            y: HEIGHT as f32,
            width: WIDTH as f32,
            height: -(HEIGHT as f32),
            min_depth: 0.0,
            max_depth: 1.0,
        };
        let rect = rect_2d(WIDTH as u32, HEIGHT as u32);
        let clear_color = [0.125f32, 0.25, 0.5, 1.0];

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

        let recorder = DrawRecorder {
            device,
            group_params: params.group_params,
            format: COLOR_ATTACHMENT_FORMAT,
            image_view: *target.view,
            render_area: rect,
            clear_value: clear_value_color(clear_color),
            image_layout: vk::ImageLayout::GENERAL,
            load_op: vk::AttachmentLoadOp::LOAD,
            render_pass: render_pass_handle,
            framebuffer: framebuffer_handle,
            layer_count: 1,
            view_mask: 0,
        };
        recorder.record(
            *cmd_buffer,
            sec_cmd_buffer.as_ref().map(|buffer| **buffer),
            |cmd| pre_render_clear_general(device, cmd, target.image.get(), clear_color),
            |cmd| {
                // `draw`
                unsafe {
                    if params.zero_viewport_height {
                        // Set zero viewport height
                        let zero_viewport_height = vk::Viewport {
                            x: viewport.x,
                            y: viewport.y / 2.0,
                            width: viewport.width,
                            height: 0.0,
                            min_depth: viewport.min_depth,
                            max_depth: viewport.max_depth,
                        };
                        device.cmd_set_viewport(cmd, 0, &[zero_viewport_height]);
                    } else {
                        device.cmd_set_viewport(cmd, 0, &[viewport]);
                    }

                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                    device.cmd_draw(cmd, 6, 1, 0, 0);
                }
                Ok(())
            },
            |cmd| {
                copy_general_image_to_buffer(
                    device,
                    cmd,
                    target.image.get(),
                    target.buffer.get(),
                    WIDTH as u32,
                    HEIGHT as u32,
                )
            },
        )?;

        // Submit
        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Get result
        let result_bytes = target.read_bytes(device)?;
        let result_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let result_image = ConstPixelBufferAccess::new(result_format, [WIDTH as u32, HEIGHT as u32, 1], result_bytes);

        // Verify the results
        let reference_image = self.generate_reference_image()?;

        if fuzzy_compare_ok(&reference_image.get_const_access(), &result_image, 0.02) != Some(true) {
            return Ok(TestStatus::fail("Rendered image is incorrect"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum OffScreenAxisCase {
    OnScreen,
    NegativeSide,
    PositiveSide,
}

#[derive(Clone, Copy)]
struct OffScreenParams {
    random_seed: u32,
    x_axis: OffScreenAxisCase,
    y_axis: OffScreenAxisCase,
    negative_height: bool,
    group_params: GroupParams,
}

/// Width and Height of the framebuffer.
const FRAMEBUFFER_SIZE: i32 = 32;
/// When generating offscreen coords, use this limit as the negative or positive max coord for X/Y.
const VIEWPORT_MAX_DIM: i32 = 1024;
const VERTEX_COUNT: u32 = 4;

/// `OffScreenViewportCase::genAxis` - choose a couple of values for the Axis range (X or Y) according to the chosen Axis case.
fn gen_axis(rnd: &mut Random, axis_case: OffScreenAxisCase) -> [i32; 2] {
    let (min_val, max_val) = match axis_case {
        OffScreenAxisCase::OnScreen => (0, FRAMEBUFFER_SIZE - 1),
        OffScreenAxisCase::NegativeSide => (-VIEWPORT_MAX_DIM, -1),
        OffScreenAxisCase::PositiveSide => (FRAMEBUFFER_SIZE + 1, VIEWPORT_MAX_DIM),
    };

    let a = rnd.get_int(min_val, max_val);
    let b = rnd.get_int(min_val, max_val);

    [a.min(b), a.max(b)]
}

struct OffScreenViewportCase {
    name: String,
    params: OffScreenParams,
}

impl TestCase for OffScreenViewportCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if self.params.negative_height {
            context.require_device_functionality("VK_KHR_maintenance1")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        OFFSCREEN_VIEWPORT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OffScreenViewportInstance {
            context,
            params: self.params,
        })
    }
}

struct OffScreenViewportInstance<'a> {
    context: &'a Context<'a>,
    params: OffScreenParams,
}

impl TestInstance for OffScreenViewportInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let mut rnd = Random::new(params.random_seed);

        // Pseudorandomly generate viewport data.
        let x_axis = gen_axis(&mut rnd, params.x_axis);
        let mut y_axis = gen_axis(&mut rnd, params.y_axis);
        let width = x_axis[1] - x_axis[0] + 1;
        let mut height = y_axis[1] - y_axis[0] + 1;

        if params.negative_height {
            height = -height;
            y_axis.swap(0, 1);
        }

        let test_viewport = vk::Viewport {
            x: x_axis[0] as f32,
            y: y_axis[0] as f32,
            width: width as f32,
            height: height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        };

        // Framebuffer parameters.
        let fb_size = FRAMEBUFFER_SIZE as u32;
        let fb_format = vk::Format::R8G8B8A8_UNORM;
        let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let color_res = ImageWithBuffer::new(context, fb_size, fb_size, fb_format, fb_usage, 4)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Render pass and framebuffer.
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let render_pass = make_color_render_pass(
            device,
            fb_format,
            vk::AttachmentLoadOp::LOAD,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_res.view], fb_size, fb_size, 1)?;

        // Pipeline.
        let scissor = rect_2d(fb_size, fb_size);
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline_render_pass = if dynamic_rendering {
            vk::RenderPass::null()
        } else {
            *render_pass
        };
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP);
        state.viewports = vec![test_viewport];
        state.scissors = vec![scissor];
        // `vk::makeGraphicsPipeline`'s rasterization state rather than `PipelineCreateInfo`'s.
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        if dynamic_rendering {
            state.rendering_format = Some(fb_format);
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            pipeline_render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        let sec_cmd_buffer = if params.group_params.use_secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];

        // Draw (offscreen due to the viewport).
        let recorder = DrawRecorder {
            device,
            group_params: params.group_params,
            format: fb_format,
            image_view: *color_res.view,
            render_area: scissor,
            clear_value: clear_value_color(clear_color),
            image_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            load_op: vk::AttachmentLoadOp::LOAD,
            render_pass: pipeline_render_pass,
            framebuffer: *framebuffer,
            layer_count: 1,
            view_mask: 0,
        };
        recorder.record(
            *cmd_buffer,
            sec_cmd_buffer.as_ref().map(|buffer| **buffer),
            // Clear color image outside render pass.
            |cmd| pre_render_clear_attachment_optimal(device, cmd, color_res.image.get(), clear_color),
            |cmd| {
                unsafe {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                    device.cmd_draw(cmd, VERTEX_COUNT, 1, 0, 0);
                }
                Ok(())
            },
            // Copy to results buffer.
            |cmd| {
                copy_image_to_buffer(
                    device,
                    cmd,
                    color_res.image.get(),
                    color_res.buffer.get(),
                    fb_size,
                    fb_size,
                )
            },
        )?;
        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Verify color buffer.
        let result_bytes = color_res.read_bytes(device)?;
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let result_access = ConstPixelBufferAccess::new(format, [fb_size, fb_size, 1], result_bytes);

        let mut reference = TextureLevel::new(format, fb_size, fb_size, 1)?;
        {
            let mut access = reference.get_access();
            for y in 0..fb_size {
                for x in 0..fb_size {
                    access.set_pixel(clear_color, x, y, 0);
                }
            }
        }

        if !float_threshold_compare(&reference.get_const_access(), &result_access, [0.0; 4]).ok {
            return Ok(TestStatus::fail("Unexpected color result; check log for details"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `populateTestGroup`
fn populate_test_group(group: &mut TestCaseGroup, zero_viewport_height: bool, group_params: GroupParams) {
    for (front_face_name, front_face) in [
        ("front_ccw", vk::FrontFace::COUNTER_CLOCKWISE),
        ("front_cw", vk::FrontFace::CLOCKWISE),
    ] {
        for (cull_mode_name, cull_mode) in [
            ("cull_none", vk::CullModeFlags::NONE),
            ("cull_front", vk::CullModeFlags::FRONT),
            ("cull_back", vk::CullModeFlags::BACK),
            ("cull_both", vk::CullModeFlags::FRONT_AND_BACK),
        ] {
            let params = TestParams {
                front_face,
                cull_mode,
                zero_viewport_height,
                group_params,
            };
            let name = format!("{front_face_name}_{cull_mode_name}");
            group.add_child(Box::new(NegativeViewportHeightTest { name, params }) as Box<dyn TestCase>);
        }
    }
}

/// `createNegativeViewportHeightTests` - negative viewport height (VK_KHR_maintenance1)
pub fn create_negative_viewport_height_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("negative_viewport_height");
    populate_test_group(&mut group, false, group_params);
    group
}

/// `createZeroViewportHeightTests` - zero viewport height (VK_KHR_maintenance1)
pub fn create_zero_viewport_height_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("zero_viewport_height");
    populate_test_group(&mut group, false, group_params);
    group
}

/// `createOffScreenViewportTests` - test using off-screen viewports
pub fn create_off_screen_viewport_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("offscreen_viewport");

    let axis_cases = [
        (OffScreenAxisCase::OnScreen, "_on_screen"),
        (OffScreenAxisCase::NegativeSide, "_off_screen_negative"),
        (OffScreenAxisCase::PositiveSide, "_off_screen_positive"),
    ];
    let negative_height_cases = [(false, ""), (true, "_negative_height")];

    let mut seed = 1674229780u32;

    for (x_case, x_suffix) in axis_cases {
        for (y_case, y_suffix) in axis_cases {
            // At least one of the axis has to be offscreen for the framebuffer to remain clear.
            if x_case == OffScreenAxisCase::OnScreen && y_case == OffScreenAxisCase::OnScreen {
                continue;
            }

            for (negative_height, neg_suffix) in negative_height_cases {
                let params = OffScreenParams {
                    random_seed: seed,
                    x_axis: x_case,
                    y_axis: y_case,
                    negative_height,
                    group_params,
                };
                seed += 1;

                let test_name = format!("x{x_suffix}_y{y_suffix}{neg_suffix}");
                group.add_child(Box::new(OffScreenViewportCase {
                    name: test_name,
                    params,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

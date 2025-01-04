// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawScissorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The C++ `TestCommand` class hierarchy is the `Command` enum.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_scissor::SCISSOR;
use crate::tcu::image_compare::int_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::vector::UVec4;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, DrawRecorder, ImageWithBuffer, clear_color_image, clear_value_color, create_draw_pipeline,
    make_color_render_pass, rect_2d, viewport,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 256;
const HEIGHT: u32 = 256;

#[derive(Clone, Copy)]
struct ColorQuad {
    x: u32,
    y: u32,
    width: u32,
    height: u32,
    color: [f32; 4],
}

/// `scissorQuad`
fn scissor_quad(quad: ColorQuad, scissor: vk::Rect2D, framebuffer_size: vk::Extent2D) -> ColorQuad {
    let mut left = quad.x as i64;
    let mut right = quad.x as i64 + quad.width as i64;
    let mut top = quad.y as i64;
    let mut bottom = quad.y as i64 + quad.height as i64;

    left = left.max(scissor.offset.x as i64);
    left = left.max(0);
    right = right.min(scissor.offset.x as i64 + scissor.extent.width as i64);
    right = right.min(framebuffer_size.width as i64);
    top = top.max(scissor.offset.y as i64);
    top = top.max(0);
    bottom = bottom.min(scissor.offset.y as i64 + scissor.extent.height as i64);
    bottom = bottom.min(framebuffer_size.height as i64);

    ColorQuad {
        x: left as u32,
        y: top as u32,
        width: (right - left).max(0) as u32,
        height: (bottom - top).max(0) as u32,
        color: quad.color,
    }
}

fn make_rect_2d(x: i32, y: i32, width: u32, height: u32) -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x, y },
        extent: vk::Extent2D { width, height },
    }
}

/// `TestCommand` and its three subclasses
#[derive(Clone)]
enum Command {
    /// `QuadDrawTestCommand`
    QuadDraw(ColorQuad),
    /// `RectClearTestCommand`
    RectClear(ColorQuad),
    /// `DynamicScissorTestCommand`
    DynamicScissor {
        first_scissor: u32,
        scissors: Vec<vk::Rect2D>,
    },
}

fn quad_draw(x: u32, y: u32, width: u32, height: u32, color: [f32; 4]) -> Command {
    Command::QuadDraw(ColorQuad {
        x,
        y,
        width,
        height,
        color,
    })
}

fn rect_clear(x: u32, y: u32, width: u32, height: u32, color: [f32; 4]) -> Command {
    Command::RectClear(ColorQuad {
        x,
        y,
        width,
        height,
        color,
    })
}

fn dynamic_scissor(first_scissor: u32, scissors: Vec<vk::Rect2D>) -> Command {
    Command::DynamicScissor {
        first_scissor,
        scissors,
    }
}

impl Command {
    /// `getVertices`
    fn get_vertices(&self) -> Vec<[f32; 8]> {
        let Command::QuadDraw(quad) = self else {
            return Vec::new();
        };
        let scale_width = 2.0 / WIDTH as f32;
        let scale_height = 2.0 / HEIGHT as f32;
        let top_left = [
            -1.0 + scale_width * quad.x as f32,
            -1.0 + scale_height * quad.y as f32,
            0.0,
            1.0,
        ];
        let top_right = [
            -1.0 + scale_width * (quad.x + quad.width) as f32,
            -1.0 + scale_height * quad.y as f32,
            0.0,
            1.0,
        ];
        let bottom_left = [
            -1.0 + scale_width * quad.x as f32,
            -1.0 + scale_height * (quad.y + quad.height) as f32,
            0.0,
            1.0,
        ];
        let bottom_right = [
            -1.0 + scale_width * (quad.x + quad.width) as f32,
            -1.0 + scale_height * (quad.y + quad.height) as f32,
            0.0,
            1.0,
        ];

        let vertex = |position: [f32; 4]| -> [f32; 8] {
            let c = quad.color;
            [
                position[0],
                position[1],
                position[2],
                position[3],
                c[0],
                c[1],
                c[2],
                c[3],
            ]
        };
        vec![
            vertex(top_left),
            vertex(bottom_right),
            vertex(bottom_left),
            vertex(top_left),
            vertex(top_right),
            vertex(bottom_right),
        ]
    }

    /// `addCommands`; `offset` is the index of the command's first vertex in the vertex buffer.
    fn add_commands(&self, device: &Device, cmd_buffer: vk::CommandBuffer, offset: u32) {
        match self {
            Command::QuadDraw(_) => unsafe { device.cmd_draw(cmd_buffer, 6, 1, offset, 0) },
            Command::RectClear(quad) => {
                let attachment = vk::ClearAttachment {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    color_attachment: 0,
                    clear_value: clear_value_color(quad.color),
                };
                let rect = vk::ClearRect {
                    rect: make_rect_2d(quad.x as i32, quad.y as i32, quad.width, quad.height),
                    base_array_layer: 0,
                    layer_count: 1,
                };
                unsafe { device.cmd_clear_attachments(cmd_buffer, &[attachment], &[rect]) };
            }
            Command::DynamicScissor {
                first_scissor,
                scissors,
            } => unsafe { device.cmd_set_scissor(cmd_buffer, *first_scissor, scissors) },
        }
    }

    /// `getMaxScissor`
    fn get_max_scissor(&self) -> u32 {
        match self {
            Command::DynamicScissor {
                first_scissor,
                scissors,
            } => first_scissor + scissors.len() as u32,
            _ => 0,
        }
    }

    /// `getQuad`
    fn get_quad(&self) -> Option<ColorQuad> {
        match self {
            Command::QuadDraw(quad) | Command::RectClear(quad) => Some(*quad),
            Command::DynamicScissor { .. } => None,
        }
    }

    /// `updateScissors`
    fn update_scissors(&self, mut scissors: Vec<vk::Rect2D>) -> Vec<vk::Rect2D> {
        if let Command::DynamicScissor {
            first_scissor,
            scissors: updates,
        } = self
        {
            for (scissor_idx, update) in updates.iter().enumerate() {
                while scissors.len() <= *first_scissor as usize + scissor_idx {
                    scissors.push(make_rect_2d(0, 0, 0, 0)); // Add empty scissor
                }
                scissors[*first_scissor as usize + scissor_idx] = *update;
            }
        }
        scissors
    }

    /// `isScissored`
    fn is_scissored(&self) -> bool {
        matches!(self, Command::QuadDraw(_))
    }
}

#[derive(Clone)]
struct TestParams {
    dynamic_scissor: bool,
    static_scissors: Vec<vk::Rect2D>,
    commands: Vec<Command>,
    uses_multiple_scissors: bool,
    group_params: GroupParams,
    framebuffer_size: vk::Extent2D,
}

impl TestParams {
    fn new(group_params: GroupParams) -> Self {
        Self {
            dynamic_scissor: false,
            static_scissors: Vec::new(),
            commands: Vec::new(),
            uses_multiple_scissors: false,
            group_params,
            framebuffer_size: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        }
    }
}

/// `countScissors`
fn count_scissors(params: &TestParams) -> u32 {
    if params.dynamic_scissor {
        params.commands.iter().map(Command::get_max_scissor).max().unwrap_or(0)
    } else {
        params.static_scissors.len() as u32
    }
}

struct ScissorTestCase {
    name: &'static str,
    params: TestParams,
}

impl ScissorTestCase {
    /// `ScissorTestCase::ScissorTestCase`
    fn new(name: &'static str, mut params: TestParams) -> Self {
        params.uses_multiple_scissors = params.static_scissors.len() > 1;

        if params.commands.iter().any(|command| command.get_max_scissor() > 1) {
            params.uses_multiple_scissors = true;
        }
        Self { name, params }
    }
}

impl TestCase for ScissorTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `ScissorTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if self.params.uses_multiple_scissors {
            if context.get_device_features().geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requested core feature is not supported: geometryShader".to_string(),
                ));
            }
            if context.get_device_features().multi_viewport == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requested core feature is not supported: multiViewport".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SCISSOR.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ScissorTestInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct ScissorTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for ScissorTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let color_image_format = vk::Format::R8G8B8A8_UNORM;
        let tcu_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let num_scissors = count_scissors(params);
        let framebuffer_size = params.framebuffer_size;
        let dynamic_rendering = params.group_params.use_dynamic_rendering;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
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

        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let gs = if params.uses_multiple_scissors {
            Some(create_shader_module(
                device,
                binaries.get(&format!("geom_{num_scissors}"))?,
            )?)
        } else {
            None
        };
        let fs = create_shader_module(device, binaries.get("frag")?)?;

        // Create color buffer image
        let image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let color_target = ImageWithBuffer::new(context, WIDTH, HEIGHT, color_image_format, image_usage, 4)?;

        // Create render pass and framebuffer
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let render_pass = make_color_render_pass(
                device,
                color_image_format,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::STORE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?;
            let framebuffer = make_framebuffer(
                device,
                *render_pass,
                &[*color_target.view],
                framebuffer_size.width,
                framebuffer_size.height,
                1,
            )?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Create vertex buffer
        let mut vertices: Vec<[f32; 8]> = Vec::new();
        let mut command_offsets = Vec::with_capacity(params.commands.len());
        for command in &params.commands {
            command_offsets.push(vertices.len() as u32);
            vertices.extend(command.get_vertices());
        }
        let vertex_buffer = if vertices.is_empty() {
            None
        } else {
            Some(create_host_buffer(
                context,
                &vertices,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            )?)
        };

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Create pipeline
        let pipeline_viewport = viewport(0.0, 0.0, WIDTH as f32, HEIGHT as f32, 0.0, 1.0);
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        state.viewport_count = num_scissors;
        state.viewports = vec![pipeline_viewport; num_scissors as usize];
        if params.dynamic_scissor {
            state.dynamic_states = vec![vk::DynamicState::SCISSOR];
            state.scissors = vec![rect_2d(0, 0); num_scissors as usize];
        } else {
            state.scissors = params.static_scissors.clone();
        }
        if dynamic_rendering {
            state.rendering_format = Some(color_image_format);
        }
        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vs)];
        if let Some(gs) = &gs {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **gs));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *fs));
        let pipeline = create_draw_pipeline(device, *pipeline_layout, render_pass_handle, &stages, &state)?;

        // Queue commands and read results.
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let render_area = rect_2d(framebuffer_size.width, framebuffer_size.height);

        clear_color_image(
            context,
            color_target.image.get(),
            clear_color,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            1,
            1,
        )?;

        let recorder = DrawRecorder {
            device,
            group_params: params.group_params,
            format: color_image_format,
            image_view: *color_target.view,
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
                // `drawCommands`
                unsafe {
                    if let Some(vertex_buffer) = &vertex_buffer {
                        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    }
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                }
                for (command, &offset) in params.commands.iter().zip(&command_offsets) {
                    command.add_commands(device, cmd, offset);
                }
                Ok(())
            },
            |cmd| {
                copy_image_to_buffer(
                    device,
                    cmd,
                    color_target.image.get(),
                    color_target.buffer.get(),
                    WIDTH,
                    HEIGHT,
                )
            },
        )?;

        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *cmd_buffer)?;

        let frame_bytes = color_target.read_bytes(device)?;
        let frame = ConstPixelBufferAccess::new(tcu_format, [WIDTH, HEIGHT, 1], frame_bytes);

        // Generate reference
        let mut ref_image = TextureLevel::new(tcu_format, WIDTH, HEIGHT, 1)?;
        {
            let mut ref_access = ref_image.get_access();
            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    ref_access.set_pixel(clear_color, x, y, 0);
                }
            }

            let mut scissors = params.static_scissors.clone();

            for command in &params.commands {
                scissors = command.update_scissors(scissors);

                let Some(quad) = command.get_quad() else {
                    continue;
                };

                for scissor in &scissors {
                    let scissored_quad = if command.is_scissored() {
                        scissor_quad(quad, *scissor, framebuffer_size)
                    } else {
                        quad
                    };

                    if scissored_quad.width == 0 || scissored_quad.height == 0 {
                        continue;
                    }

                    for y in scissored_quad.y..scissored_quad.y + scissored_quad.height {
                        for x in scissored_quad.x..scissored_quad.x + scissored_quad.width {
                            ref_access.set_pixel(scissored_quad.color, x, y, 0);
                        }
                    }
                }
            }
        }

        // Compare results
        if !int_threshold_compare(&ref_image.get_const_access(), &frame, UVec4::new(0, 0, 0, 0)).ok {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createTests` of vktDrawScissorTests.cpp
pub fn create_scissor_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("scissor");
    let red = [1.0f32, 0.0, 0.0, 1.0];
    let green = [0.0f32, 1.0, 0.0, 1.0];
    let blue = [0.0f32, 0.0, 1.0, 1.0];
    let yellow = [1.0f32, 1.0, 0.0, 1.0];

    let mut add = |name: &'static str, params: TestParams| {
        group.add_child(Box::new(ScissorTestCase::new(name, params)) as Box<dyn TestCase>);
    };

    // Two quads with a single static scissor
    {
        let mut params = TestParams::new(group_params);
        params
            .static_scissors
            .push(make_rect_2d(30, 40, WIDTH - 60, HEIGHT - 80));
        params.commands.push(quad_draw(10, 10, 50, 50, red));
        params.commands.push(quad_draw(WIDTH - 80, HEIGHT - 100, 30, 40, green));
        add("static_scissor_two_quads", params);
    }

    // Two clears with a single static scissor
    {
        let mut params = TestParams::new(group_params);
        params
            .static_scissors
            .push(make_rect_2d(30, 40, WIDTH - 60, HEIGHT - 80));
        params.commands.push(rect_clear(10, 10, 50, 50, red));
        params
            .commands
            .push(rect_clear(WIDTH - 80, HEIGHT - 100, 30, 40, green));
        add("static_scissor_two_clears", params);
    }

    // One quad with two static scissors
    {
        let mut params = TestParams::new(group_params);
        params
            .static_scissors
            .push(make_rect_2d(30, 40, WIDTH - 60, HEIGHT - 70));
        params
            .static_scissors
            .push(make_rect_2d(40, 50, WIDTH - 60, HEIGHT - 70));
        params.commands.push(quad_draw(10, 10, WIDTH - 10, HEIGHT - 10, red));
        add("two_static_scissors_one_quad", params);
    }

    // Static scissor extending outside viewport
    {
        let mut params = TestParams::new(group_params);
        params.static_scissors.push(make_rect_2d(30, 40, WIDTH, HEIGHT));
        params.commands.push(quad_draw(0, 0, WIDTH, HEIGHT + 30, green));
        add("static_scissor_partially_outside_viewport", params);
    }

    // Static scissor completely outside viewport
    {
        let mut params = TestParams::new(group_params);
        params
            .static_scissors
            .push(make_rect_2d((WIDTH + 30) as i32, (HEIGHT + 40) as i32, WIDTH, HEIGHT));
        params.commands.push(quad_draw(100, 100, 20, 30, green));
        add("static_scissor_outside_viewport", params);
    }

    // Static scissor outside viewport and touching right border of viewport
    {
        let mut params = TestParams::new(group_params);
        params
            .static_scissors
            .push(make_rect_2d(WIDTH as i32, 0, WIDTH, HEIGHT));
        params.commands.push(quad_draw(100, 100, 20, 30, green));
        add("static_scissor_viewport_border", params);
    }

    // Static scissor with offset + extent equal to largest positive int32
    {
        let mut params = TestParams::new(group_params);
        params
            .static_scissors
            .push(make_rect_2d(100, 100, 0x7fffffff - 100, 0x7fffffff - 100));
        params.commands.push(quad_draw(0, 0, WIDTH, HEIGHT, green));
        add("static_scissor_max_int32", params);
    }

    // 16 static scissors (minimum number required when multiViewport supported)
    {
        let mut params = TestParams::new(group_params);
        for i in 0..16u32 {
            params.static_scissors.push(make_rect_2d(
                (10 + i * 3) as i32,
                (20 + i * 2) as i32,
                WIDTH / 2,
                HEIGHT / 2,
            ));
        }
        params.commands.push(quad_draw(5, 6, WIDTH - 10, HEIGHT - 2, red));
        add("16_static_scissors", params);
    }

    // Two quads with an empty scissor
    {
        let mut params = TestParams::new(group_params);
        params.static_scissors.push(make_rect_2d(0, 0, 0, 0));
        params.commands.push(quad_draw(10, 10, 50, 50, red));
        params.commands.push(quad_draw(WIDTH - 80, HEIGHT - 100, 30, 40, green));
        add("empty_static_scissor", params);
    }

    // Two quads with a single dynamic scissor
    {
        let mut params = TestParams::new(group_params);
        params.dynamic_scissor = true;
        params
            .commands
            .push(dynamic_scissor(0, vec![make_rect_2d(30, 40, WIDTH - 60, HEIGHT - 80)]));
        params.commands.push(quad_draw(10, 10, 50, 50, red));
        params.commands.push(quad_draw(WIDTH - 80, HEIGHT - 100, 30, 40, green));
        add("dynamic_scissor_two_quads", params);
    }

    // Empty scissor for the first draw
    {
        let mut params = TestParams::new(group_params);
        params.dynamic_scissor = true;
        params.commands.push(dynamic_scissor(0, vec![make_rect_2d(0, 0, 0, 0)]));
        params.commands.push(quad_draw(10, 10, 50, 50, red));
        params
            .commands
            .push(dynamic_scissor(0, vec![make_rect_2d(30, 40, WIDTH - 60, HEIGHT - 80)]));
        params.commands.push(quad_draw(WIDTH - 80, HEIGHT - 100, 30, 40, green));
        add("empty_dynamic_scissor_first_draw", params);
    }

    // Two quads with three scissors updated in between
    {
        let mut params = TestParams::new(group_params);
        let mut rect = make_rect_2d(10, 20, WIDTH - 60, HEIGHT - 70);
        let mut scissors = Vec::new();

        params.dynamic_scissor = true;

        scissors.push(rect);
        rect.offset.x += 10;
        rect.offset.y += 10;
        scissors.push(rect);
        rect.offset.x += 10;
        rect.offset.y += 10;
        scissors.push(rect);

        params.commands.push(dynamic_scissor(0, scissors.clone()));
        params.commands.push(quad_draw(5, 7, WIDTH - 20, HEIGHT - 9, red));

        for scissor in &mut scissors {
            scissor.offset.x += 20;
        }

        params.commands.push(dynamic_scissor(0, scissors));
        params.commands.push(quad_draw(8, 12, WIDTH - 2, HEIGHT - 19, green));
        add("dynamic_scissor_updates_between_draws", params);
    }

    // Scissor updates out of order
    {
        let mut params = TestParams::new(group_params);
        let mut rect = make_rect_2d(10, 20, WIDTH - 60, HEIGHT - 70);
        let mut scissors = Vec::new();

        params.dynamic_scissor = true;

        scissors.push(rect);
        rect.offset.x += 10;
        rect.offset.y += 10;
        scissors.push(rect);
        rect.offset.x += 10;
        rect.offset.y += 10;
        scissors.push(rect);

        params.commands.push(dynamic_scissor(2, vec![scissors[2]]));
        params.commands.push(dynamic_scissor(1, vec![scissors[1]]));
        params.commands.push(dynamic_scissor(0, vec![scissors[0]]));
        params.commands.push(quad_draw(5, 7, WIDTH - 20, HEIGHT - 9, red));

        for scissor in &mut scissors {
            scissor.offset.x += 20;
        }

        params.commands.push(dynamic_scissor(1, vec![scissors[1]]));
        params.commands.push(dynamic_scissor(0, vec![scissors[0]]));
        params.commands.push(dynamic_scissor(2, vec![scissors[2]]));
        params.commands.push(quad_draw(8, 12, WIDTH - 2, HEIGHT - 19, green));
        add("dynamic_scissor_out_of_order_updates", params);
    }

    // Dynamic scissor extending outside viewport
    {
        let mut params = TestParams::new(group_params);
        params.dynamic_scissor = true;
        params
            .commands
            .push(dynamic_scissor(0, vec![make_rect_2d(30, 40, WIDTH, HEIGHT)]));
        params.commands.push(quad_draw(0, 0, WIDTH + 50, HEIGHT + 20, green));
        add("dynamic_scissor_partially_outside_viewport", params);
    }

    // Dynamic scissor completely outside viewport
    {
        let mut params = TestParams::new(group_params);
        params.dynamic_scissor = true;
        params.commands.push(dynamic_scissor(
            0,
            vec![make_rect_2d((WIDTH + 30) as i32, (HEIGHT + 40) as i32, WIDTH, HEIGHT)],
        ));
        params.commands.push(quad_draw(100, 100, 20, 30, green));
        add("dynamic_scissor_outside_viewport", params);
    }

    // Dynamic scissor outside viewport and touching right border of viewport
    {
        let mut params = TestParams::new(group_params);
        params.dynamic_scissor = true;
        params
            .commands
            .push(dynamic_scissor(0, vec![make_rect_2d(WIDTH as i32, 0, WIDTH, HEIGHT)]));
        params.commands.push(quad_draw(100, 100, 20, 30, green));
        add("dynamic_scissor_viewport_border", params);
    }

    // Dynamic scissor with offset + extent equal to largest positive int32
    {
        let mut params = TestParams::new(group_params);
        params.dynamic_scissor = true;
        params.commands.push(dynamic_scissor(
            0,
            vec![make_rect_2d(100, 100, 0x7fffffff - 100, 0x7fffffff - 100)],
        ));
        params.commands.push(quad_draw(0, 0, WIDTH, HEIGHT, green));
        add("dynamic_scissor_max_int32", params);
    }

    // 16 dynamic scissors (minimum number required when multiViewport supported)
    {
        let mut params = TestParams::new(group_params);
        let scissors = (0..16u32)
            .map(|i| make_rect_2d((10 + i * 3) as i32, (20 + i * 2) as i32, WIDTH / 2, HEIGHT / 2))
            .collect();
        params.dynamic_scissor = true;
        params.commands.push(dynamic_scissor(0, scissors));
        params.commands.push(quad_draw(5, 6, WIDTH - 10, HEIGHT - 2, red));
        add("16_dynamic_scissors", params);
    }

    // Two clears with a single dynamic scissor
    {
        let mut params = TestParams::new(group_params);
        params.dynamic_scissor = true;
        params
            .commands
            .push(dynamic_scissor(0, vec![make_rect_2d(30, 40, WIDTH - 60, HEIGHT - 80)]));
        params.commands.push(rect_clear(10, 10, 50, 50, red));
        params
            .commands
            .push(rect_clear(WIDTH - 80, HEIGHT - 100, 30, 40, green));
        add("dynamic_scissor_two_clears", params);
    }

    // Mixture of quad draws and clears with dynamic scissor updates
    {
        let mut params = TestParams::new(group_params);
        let mut scissors = Vec::new();

        params.dynamic_scissor = true;

        scissors.push(make_rect_2d(30, 40, 50, 60));
        scissors.push(make_rect_2d(40, 20, 50, 50));
        params.commands.push(dynamic_scissor(0, scissors.clone()));
        params.commands.push(rect_clear(10, 10, 50, 50, red));
        params.commands.push(quad_draw(40, 30, 50, 50, green));
        scissors[1].extent.width -= 20;
        scissors[1].extent.height += 30;
        scissors[1].offset.x -= 20;
        params.commands.push(dynamic_scissor(1, vec![scissors[1]]));
        params.commands.push(quad_draw(70, 70, 50, 50, blue));
        params.commands.push(rect_clear(75, 77, 50, 50, yellow));
        add("dynamic_scissor_mix", params);
    }

    // Static scissor off by one, inside frame buffer border
    {
        let size = vk::Extent2D {
            width: WIDTH / 2 - 1,
            height: HEIGHT / 2 - 1,
        };
        let mut params = TestParams::new(group_params);

        params.framebuffer_size = size;
        params
            .static_scissors
            .push(make_rect_2d(1, 1, size.width - 2, size.height - 2));
        params.commands.push(quad_draw(0, 0, WIDTH * 4, HEIGHT * 4, red));
        add("static_scissor_framebuffer_border_in", params);
    }

    // Dynamic scissor off by one, inside frame buffer border
    {
        let size = vk::Extent2D {
            width: WIDTH / 2 - 1,
            height: HEIGHT / 2 - 1,
        };
        let mut params = TestParams::new(group_params);

        params.framebuffer_size = size;
        params.dynamic_scissor = true;
        params.commands.push(dynamic_scissor(
            0,
            vec![make_rect_2d(1, 1, size.width - 2, size.height - 2)],
        ));
        params.commands.push(quad_draw(0, 0, WIDTH * 4, HEIGHT * 4, red));
        add("dynamic_scissor_framebuffer_border_in", params);
    }

    group
}

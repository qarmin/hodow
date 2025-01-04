// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawDifferingInterpolationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_differing_interpolation::DIFFERING_INTERPOLATION;
use crate::tcu::image_compare::int_threshold_compare;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::vector::UVec4;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, DrawRecorder, ImageWithBuffer, clear_value_color, copy_general_image_to_buffer,
    create_draw_pipeline, make_color_render_pass, pre_render_clear_general, rect_2d,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 256;
const HEIGHT: u32 = 256;

#[derive(Clone, Copy)]
struct DrawParams {
    vert_shader: &'static str,
    frag_shader: &'static str,
    ref_vert_shader: &'static str,
    ref_frag_shader: &'static str,
    group_params: GroupParams,
}

struct DrawTestCase {
    name: &'static str,
    data: DrawParams,
}

impl TestCase for DrawTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.data.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DIFFERING_INTERPOLATION.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawTestInstance {
            context,
            data: self.data,
        })
    }
}

struct DrawTestInstance<'a> {
    context: &'a Context<'a>,
    data: DrawParams,
}

impl TestInstance for DrawTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let data = self.data;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let mut frames: Vec<Vec<u8>> = Vec::new();
        let vert_shader_names = [data.vert_shader, data.ref_vert_shader];
        let frag_shader_names = [data.frag_shader, data.ref_frag_shader];

        // Run two iterations with shaders that have different interpolation decorations. Images should still match.
        for frame_idx in 0..2 {
            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let binaries = context.get_binary_collection();
            let vs = create_shader_module(device, binaries.get(vert_shader_names[frame_idx])?)?;
            let fs = create_shader_module(device, binaries.get(frag_shader_names[frame_idx])?)?;
            let target_image_format = vk::Format::R8G8B8A8_UNORM;

            // Create color buffer image.
            let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST;
            let target = ImageWithBuffer::new(context, WIDTH, HEIGHT, target_image_format, usage, 4)?;

            // Create render pass and frame buffer.
            let dynamic_rendering = data.group_params.use_dynamic_rendering;
            let (render_pass, framebuffer) = if dynamic_rendering {
                (None, None)
            } else {
                let render_pass = make_color_render_pass(
                    device,
                    target_image_format,
                    vk::AttachmentLoadOp::LOAD,
                    vk::AttachmentStoreOp::STORE,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::GENERAL,
                )?;
                let framebuffer = make_framebuffer(device, *render_pass, &[*target.view], WIDTH, HEIGHT, 1)?;
                (Some(render_pass), Some(framebuffer))
            };
            let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
            let framebuffer_handle = framebuffer
                .as_ref()
                .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

            // Create vertex buffer.
            let vertices: [[f32; 8]; 3] = [
                [-0.8, -0.7, 1.0, 1.0, /* Color */ 1.0, 0.0, 0.0, 1.0],
                [0.0, 0.4, 0.5, 0.5, /* Color */ 0.0, 1.0, 0.0, 1.0],
                [0.8, -0.5, 1.0, 1.0, /* Color */ 0.0, 0.0, 1.0, 1.0],
            ];
            let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

            let pipeline_layout = make_pipeline_layout(device, &[])?;

            // Create pipeline
            let mut state =
                DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(WIDTH, HEIGHT);
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
            if dynamic_rendering {
                state.rendering_format = Some(target_image_format);
            }
            let pipeline = create_draw_pipeline(
                device,
                *pipeline_layout,
                render_pass_handle,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vs),
                    (vk::ShaderStageFlags::FRAGMENT, *fs),
                ],
                &state,
            )?;

            let render_area = rect_2d(WIDTH, HEIGHT);
            let clear_color = [0.0f32, 0.0, 0.0, 1.0];

            // Record commands
            let sec_cmd_buffer = if data.group_params.use_secondary_cmd_buffer {
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
                group_params: data.group_params,
                format: target_image_format,
                image_view: *target.view,
                render_area,
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
                        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                        device.cmd_draw(cmd, 3, 1, 0, 0);
                    }
                    Ok(())
                },
                |cmd| copy_general_image_to_buffer(device, cmd, target.image.get(), target.buffer.get(), WIDTH, HEIGHT),
            )?;

            // Submit and read results.
            crate::vk::cmd_util::submit_commands_and_wait(device, queue, *cmd_buffer)?;
            frames.push(target.read_bytes(device)?.to_vec());
        }

        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let frame0 = ConstPixelBufferAccess::new(format, [WIDTH, HEIGHT, 1], &frames[0]);
        let frame1 = ConstPixelBufferAccess::new(format, [WIDTH, HEIGHT, 1], &frames[1]);

        if !int_threshold_compare(&frame0, &frame1, UVec4::new(0, 0, 0, 0)).ok {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDifferingInterpolationTests`
pub fn create_differing_interpolation_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("differing_interpolation");

    let params_flat0 = DrawParams {
        vert_shader: "vert",
        frag_shader: "fragFlatColor",
        ref_vert_shader: "vertFlatColor",
        ref_frag_shader: "fragFlatColor",
        group_params,
    };
    let params_flat1 = DrawParams {
        vert_shader: "vertFlatColor",
        frag_shader: "frag",
        ref_vert_shader: "vert",
        ref_frag_shader: "frag",
        group_params,
    };

    let params_no_perspective0 = DrawParams {
        vert_shader: "vert",
        frag_shader: "fragNoPerspective",
        ref_vert_shader: "vertNoPerspective",
        ref_frag_shader: "fragNoPerspective",
        group_params,
    };
    let params_no_perspective1 = DrawParams {
        vert_shader: "vertNoPerspective",
        frag_shader: "frag",
        ref_vert_shader: "vert",
        ref_frag_shader: "frag",
        group_params,
    };

    // Mismatching flat interpolation testcase 0.
    group.add_child(Box::new(DrawTestCase {
        name: "flat_0",
        data: params_flat0,
    }) as Box<dyn TestCase>);
    // Mismatching flat interpolation testcase 1.
    group.add_child(Box::new(DrawTestCase {
        name: "flat_1",
        data: params_flat1,
    }) as Box<dyn TestCase>);

    // Mismatching noperspective interpolation testcase 0.
    group.add_child(Box::new(DrawTestCase {
        name: "noperspective_0",
        data: params_no_perspective0,
    }) as Box<dyn TestCase>);
    // Mismatching noperspective interpolation testcase 1.
    group.add_child(Box::new(DrawTestCase {
        name: "noperspective_1",
        data: params_no_perspective1,
    }) as Box<dyn TestCase>);
    group
}

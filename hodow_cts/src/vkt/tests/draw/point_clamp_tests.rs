// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawPointClampTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_point_clamp::POINT_SIZE_CLAMP;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_memory_barrier, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `Vertex`
#[repr(C)]
#[derive(Clone, Copy)]
struct Vertex {
    pos: [f32; 4],
    color: [f32; 4],
}

struct PointSizeClampCase;

impl TestCase for PointSizeClampCase {
    fn name(&self) -> &str {
        "point_size_clamp_max"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().large_points == vk::FALSE {
            return Err(TestError::NotSupported("Large points not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        POINT_SIZE_CLAMP.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PointSizeClampInstance { context })
    }
}

/// `renderPointSizeClampTest`
struct PointSizeClampInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for PointSizeClampInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let clear_color = [0.0f32, 1.0, 0.0, 1.0];
        let point_color = [0.0f32; 4];

        let max_point_size_range = context.get_device_properties().limits.point_size_range[1];

        let fb_width_size = (max_point_size_range * 0.5).ceil() as u32 + 1;
        let render_size = (fb_width_size, 1u32);

        let test_point_size = (max_point_size_range * 2.0).floor();

        let pc_point_size = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: std::mem::size_of::<f32>() as u32,
        };

        let px_center = fb_width_size as f32 - 0.25;

        let test_point_x_coord = ((2.0 * px_center) / fb_width_size as f32) - 1.0;

        let vertices = [Vertex {
            pos: [test_point_x_coord, 0.0, 0.0, 1.0],
            color: point_color,
        }];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let target = ImageWithBuffer::new(
            context,
            render_size.0,
            render_size.1,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*target.view], render_size.0, render_size.1, 1)?;

        // Pipeline layout
        let push_constant_ranges = [pc_point_size];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Shaders
        let binaries = context.get_binary_collection();
        let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader_module = create_shader_module(device, binaries.get("frag")?)?;

        // Pipeline
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<Vertex>() as u32,
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
                format: color_format,
                offset: 16,
            },
        ];
        state = state.with_full_viewport(render_size.0, render_size.1);
        // `vk::makeGraphicsPipeline`'s rasterization state rather than `PipelineCreateInfo`'s.
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buf = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Record commands
        begin_command_buffer(device, *cmd_buf)?;

        {
            let vert_flush_barrier =
                make_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::VERTEX_ATTRIBUTE_READ);
            let color_att_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                target.image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buf,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[vert_flush_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_att_barrier],
                );
            }
        }

        begin_render_pass(
            device,
            *cmd_buf,
            *render_pass,
            *framebuffer,
            rect_2d(render_size.0, render_size.1),
            clear_value_color(clear_color),
        );

        unsafe {
            device.cmd_bind_pipeline(*cmd_buf, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(*cmd_buf, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_push_constants(
                *cmd_buf,
                *pipeline_layout,
                pc_point_size.stage_flags,
                pc_point_size.offset,
                &test_point_size.to_ne_bytes(),
            );
            device.cmd_draw(*cmd_buf, 1, 1, 0, 0);
        }
        end_render_pass(device, *cmd_buf);
        copy_image_to_buffer(
            device,
            *cmd_buf,
            target.image.get(),
            target.buffer.get(),
            render_size.0,
            render_size.1,
        );
        end_command_buffer(device, *cmd_buf)?;

        // Submit & wait for completion
        submit_commands_and_wait(device, queue, *cmd_buf)?;

        {
            let tcu_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
            let result_access = ConstPixelBufferAccess::new(
                tcu_format,
                [render_size.0, render_size.1, 1],
                target.read_bytes(device)?,
            );

            let mut reference_level = TextureLevel::new(tcu_format, render_size.0, render_size.1, 1)?;
            {
                let mut reference_access = reference_level.get_access();
                for x in 0..render_size.0 {
                    reference_access.set_pixel(point_color, x, 0, 0);
                }
                reference_access.set_pixel(clear_color, 0, 0, 0);
            }

            let threshold = [0.0f32; 4];

            if !float_threshold_compare(&reference_level.get_const_access(), &result_access, threshold).ok {
                return Ok(TestStatus::fail(
                    "Unexpected color in result buffer; check log for details",
                ));
            }
        }
        Ok(TestStatus::pass("Rendering succeeded"))
    }
}

/// `createDrawPointClampTests`
pub fn create_draw_point_clamp_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("point_size_clamp");
    group.add_child(Box::new(PointSizeClampCase) as Box<dyn TestCase>);
    group
}

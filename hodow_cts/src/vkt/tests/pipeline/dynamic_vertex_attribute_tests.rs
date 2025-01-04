// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDynamicVertexAttributeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtVertexInputDynamicStateExtensionDeviceCommands;

use crate::generated::shaders::pipeline_dynamic_vertex_attribute::DYNAMIC_VERTEX_ATTRIBUTE_NONSEQUENTIAL;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `defaultClearColorUnorm`
const CLEAR_COLOR: [f32; 4] = [0.39, 0.58, 0.93, 1.0];

/// `NonSequentialInstance::VertexInfo`
#[repr(C)]
#[derive(Clone, Copy)]
struct VertexInfo {
    position: [f32; 4],
    color: [f32; 4],
}

struct NonSequentialCase {
    name: &'static str,
    num_instances: u32,
    attribute_locations: [u32; 2],
}

impl TestCase for NonSequentialCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `NonSequentialCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        for extension in [
            "VK_EXT_extended_dynamic_state",
            "VK_EXT_vertex_input_dynamic_state",
            "VK_EXT_extended_dynamic_state2",
        ] {
            context.require_device_functionality(extension)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DYNAMIC_VERTEX_ATTRIBUTE_NONSEQUENTIAL.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NonSequentialInstance {
            context,
            num_instances: self.num_instances,
            attribute_locations: self.attribute_locations,
        })
    }
}

struct NonSequentialInstance<'a> {
    context: &'a Context<'a>,
    num_instances: u32,
    attribute_locations: [u32; 2],
}

impl TestInstance for NonSequentialInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        const SIZE: u32 = 32;
        let format = vk::Format::R8G8B8A8_UNORM;

        // Create shaders
        let binaries = context.get_binary_collection();
        let vertex_shader_modules = [
            create_shader_module(device, binaries.get("vert_0")?)?,
            create_shader_module(device, binaries.get("vert_1")?)?,
        ];
        let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;

        let vertex_buffer_bind_index = 0u32;

        // Vertex input state and binding
        let binding_description = vk::VertexInputBindingDescription2EXT {
            binding: vertex_buffer_bind_index,
            stride: std::mem::size_of::<VertexInfo>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
            divisor: 1,
            ..Default::default()
        };
        let attribute_description = |location: u32, offset: u32| vk::VertexInputAttributeDescription2EXT {
            location,
            binding: vertex_buffer_bind_index,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset,
            ..Default::default()
        };
        let vertex_input_attribute_desc_greens = [
            attribute_description(0, 0),
            attribute_description(self.attribute_locations[0], (std::mem::size_of::<f32>() * 4) as u32),
        ];
        let vertex_input_attribute_desc_reds = [
            attribute_description(0, 0),
            attribute_description(self.attribute_locations[1], (std::mem::size_of::<f32>() * 4) as u32),
        ];

        let color_buffer = ImageWithBuffer::new(
            context,
            SIZE,
            SIZE,
            format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        // Create renderpass and framebuffer
        let render_pass = make_color_render_pass(
            device,
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], SIZE, SIZE, 1)?;

        // Create pipeline layout and graphics pipelines: the vertex input is dynamic state.
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(SIZE, SIZE);
        state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_EXT];
        let shader_objects = [
            make_shader_objects_stages(
                context,
                &[
                    (vk::ShaderStageFlags::VERTEX, "vert_0"),
                    (vk::ShaderStageFlags::FRAGMENT, "frag"),
                ],
                &[],
                &[],
            )?,
            make_shader_objects_stages(
                context,
                &[
                    (vk::ShaderStageFlags::VERTEX, "vert_1"),
                    (vk::ShaderStageFlags::FRAGMENT, "frag"),
                ],
                &[],
                &[],
            )?,
        ];
        let make_pipeline = |vertex_shader: vk::ShaderModule| {
            create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, vertex_shader),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
                ],
                &state,
            )
        };
        let (pipeline_0, pipeline_1) = if shader_objects[0].is_none() {
            (
                Some(make_pipeline(*vertex_shader_modules[0])?),
                Some(make_pipeline(*vertex_shader_modules[1])?),
            )
        } else {
            (None, None)
        };

        // Create vertex buffers
        let num_vertices = 6u32;
        let instance_size = (self.num_instances as f32).sqrt() as u32;
        let pos_increment = 1.0 / self.num_instances as f32 * instance_size as f32;
        let make_vertices = |vertex_color: [f32; 4]| {
            vec![
                VertexInfo {
                    position: [pos_increment, -pos_increment, 0.0, 1.0],
                    color: vertex_color,
                },
                VertexInfo {
                    position: [-pos_increment, -pos_increment, 0.0, 1.0],
                    color: vertex_color,
                },
                VertexInfo {
                    position: [-pos_increment, pos_increment, 0.0, 1.0],
                    color: vertex_color,
                },
                VertexInfo {
                    position: [-pos_increment, pos_increment, 1.0, 1.0],
                    color: vertex_color,
                },
                VertexInfo {
                    position: [pos_increment, pos_increment, 1.0, 1.0],
                    color: vertex_color,
                },
                VertexInfo {
                    position: [pos_increment, -pos_increment, 1.0, 1.0],
                    color: vertex_color,
                },
            ]
        };
        let vertex_buffers = [
            create_host_buffer(
                context,
                &make_vertices([0.0, 0.5, 0.0, 1.0]),
                vk::BufferUsageFlags::VERTEX_BUFFER,
            )?,
            create_host_buffer(
                context,
                &make_vertices([0.5, 0.0, 0.0, 1.0]),
                vk::BufferUsageFlags::VERTEX_BUFFER,
            )?,
        ];

        // Command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *cmd_buffer)?;
        let clear_values = [clear_value_color(CLEAR_COLOR)];
        begin_draw(
            device,
            *cmd_buffer,
            shader_objects[0].as_ref(),
            &state,
            pipeline_0.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            rect_2d(SIZE, SIZE),
            &clear_values,
            &[(color_buffer.image.get(), *color_buffer.view)],
        );
        unsafe {
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffers[0].get()], &[0]);
            device.cmd_set_vertex_input_ext(*cmd_buffer, &[binding_description], &vertex_input_attribute_desc_greens);
            device.cmd_draw(*cmd_buffer, num_vertices, 1, 0, 0);

            if let Some(shader_objects) = &shader_objects[1] {
                shader_objects.bind(*cmd_buffer, &state);
            } else if let Some(pipeline_1) = &pipeline_1 {
                device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline_1);
            }
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffers[1].get()], &[0]);
            device.cmd_set_vertex_input_ext(*cmd_buffer, &[binding_description], &vertex_input_attribute_desc_reds);
            device.cmd_draw(*cmd_buffer, num_vertices, 1, 0, 0);
        }
        end_draw(device, *cmd_buffer, shader_objects[0].is_some());
        copy_image_to_buffer(
            device,
            *cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            SIZE,
            SIZE,
        );
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Check result image
        let segment_size = SIZE / instance_size;
        let segment_loc = (SIZE - segment_size) / 2;
        let result = color_buffer.read_bytes(device)?;
        for y in 0..SIZE {
            for x in 0..SIZE {
                // Create reference image: the clear colour, with a red square in the middle.
                let inside = (segment_loc..segment_loc + segment_size).contains(&x)
                    && (segment_loc..segment_loc + segment_size).contains(&y);
                let expected = if inside { [0.5, 0.0, 0.0, 1.0] } else { CLEAR_COLOR };
                let offset = ((y * SIZE + x) * 4) as usize;
                for channel in 0..4 {
                    if (f32::from(result[offset + channel]) / 255.0 - expected[channel]).abs() > 0.01 {
                        return Ok(TestStatus::fail("Rendered image is not correct"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Success"))
    }
}

/// `createDynamicVertexAttributeTests`
pub fn create_dynamic_vertex_attribute_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("dynamic_vertex_attribute");
    group.add_child(Box::new(NonSequentialCase {
        name: "nonsequential",
        num_instances: 16,
        attribute_locations: [1, 7],
    }) as Box<dyn TestCase>);
    group
}

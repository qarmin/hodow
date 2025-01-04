// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineInputAssemblyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `input_assembly.misc.null_state_dynamic_primitive_rast_discard`: a pipeline created with a null
// input assembly state, rasterization discard (static or dynamic) and dynamic primitive topology and restart, whose vertex shader's storage buffer
// writes are all that is checked, besides nothing being drawn. The vertex buffer holds all four vertices, where upstream sizes it by their count
// in bytes. Monolithic pipelines only.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtExtendedDynamicState2ExtensionDeviceCommands, ExtExtendedDynamicStateExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::pipeline_input_assembly_null_state::NULL_STATE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FB_EXTENT: u32 = 2;
const RESTART_MARKER: u16 = u16::MAX;

struct NullStateTestCase {
    name: String,
    is_rast_discard_dynamic: bool,
}

impl TestCase for NullStateTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `NullStateTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;

        let mut eds3_properties = vk::PhysicalDeviceExtendedDynamicState3PropertiesEXT::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut eds3_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }
        if eds3_properties.dynamic_primitive_topology_unrestricted == vk::FALSE {
            return Err(TestError::NotSupported(
                "dynamicPrimitiveTopologyUnrestricted not supported".to_string(),
            ));
        }

        if context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Vertex pipeline stores and atomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NULL_STATE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NullStateTestInstance {
            context,
            is_rast_discard_dynamic: self.is_rast_discard_dynamic,
        })
    }
}

struct NullStateTestInstance<'a> {
    context: &'a Context<'a>,
    is_rast_discard_dynamic: bool,
}

impl TestInstance for NullStateTestInstance<'_> {
    /// `NullStateTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];

        // Position and color of each vertex.
        let blue = [0.0f32, 0.0, 1.0, 1.0];
        let vertices: [[f32; 8]; 4] = [
            [-1.0, -1.0, 0.0, 1.0, blue[0], blue[1], blue[2], blue[3]],
            [-1.0, 0.0, 0.0, 1.0, blue[0], blue[1], blue[2], blue[3]],
            [0.0, -1.0, 0.0, 1.0, blue[0], blue[1], blue[2], blue[3]],
            [0.0, 0.0, 0.0, 1.0, blue[0], blue[1], blue[2], blue[3]],
        ];
        let num_vertices = vertices.len() as u32;
        let vtx_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Index buffer.
        let indices: [u16; 4] = [0, 1, 2, RESTART_MARKER]; // restart index = 3
        let index_buffer = create_host_buffer(context, &indices, vk::BufferUsageFlags::INDEX_BUFFER)?;
        let restart_index = 3u32;

        // Output data buffer.
        let output_data_buffer_size = (num_vertices as usize * std::mem::size_of::<i32>()) as vk::DeviceSize;
        let output_data_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(output_data_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let random_data = vec![0x7FFF_FFFFi32; num_vertices as usize];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    random_data.as_ptr().cast::<u8>(),
                    output_data_buffer.get_allocation().get_host_ptr(),
                    output_data_buffer_size as usize,
                )
            };
            flush_alloc(device, output_data_buffer.get_allocation())?;
        }

        // Descriptor set.
        let desc_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::VERTEX)
            .build(device)?;
        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let desc_set = make_descriptor_set(device, *desc_pool, *desc_set_layout)?;
        let desc_buffer_info = vk::DescriptorBufferInfo {
            buffer: output_data_buffer.get(),
            offset: 0,
            range: output_data_buffer_size,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                desc_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &desc_buffer_info,
            )
            .update(device);

        // Color buffer.
        let color_buffer = ImageWithBuffer::new(
            context,
            FB_EXTENT,
            FB_EXTENT,
            FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
            4,
        )?;
        let render_pass = make_color_render_pass(
            device,
            FORMAT,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], FB_EXTENT, FB_EXTENT, 1)?;

        // Shaders and the pipeline, with a null input assembly state.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*desc_set_layout])?;

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(FB_EXTENT, FB_EXTENT);
        state.bindings = vec![
            vk::VertexInputBindingDescription {
                binding: 0,
                stride: 32,
                input_rate: vk::VertexInputRate::VERTEX,
            },
            vk::VertexInputBindingDescription {
                binding: 1,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            },
        ];
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
        state.null_input_assembly_state = true;
        state.dynamic_states = vec![
            vk::DynamicState::PRIMITIVE_TOPOLOGY,
            vk::DynamicState::PRIMITIVE_RESTART_ENABLE,
        ];
        if self.is_rast_discard_dynamic {
            state.dynamic_states.push(vk::DynamicState::RASTERIZER_DISCARD_ENABLE);
        } else {
            // Rasterization disabled statically.
            state.rasterization.rasterizer_discard_enable = vk::TRUE;
        }
        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if self.is_rast_discard_dynamic {
            stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        }
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let clear_values = [clear_value_color(clear_color)];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(FB_EXTENT, FB_EXTENT))
            .clear_values(&clear_values);

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_vertex_buffers(cmd, 0, &[vtx_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, vk::IndexType::UINT16);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[desc_set.get()],
                &[] as &[u32],
            );

            // Rasterization disabled dynamically.
            if self.is_rast_discard_dynamic {
                device.cmd_set_rasterizer_discard_enable_ext(cmd, true);
            }
            // Primitive topology set dynamically.
            device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP);
            // Primitive restart enabled dynamically.
            device.cmd_set_primitive_restart_enable_ext(cmd, true);

            device.cmd_draw_indexed(cmd, indices.len() as u32, 1, 0, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            FB_EXTENT,
            FB_EXTENT,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify that output color is the clear color (nothing was rasterized).
        let clear_bytes = clear_color.map(|channel| (channel * 255.0).round() as u8);
        let result = color_buffer.read_bytes(device)?;
        if result
            .chunks_exact(4)
            .take((FB_EXTENT * FB_EXTENT) as usize)
            .any(|pixel| pixel != clear_bytes)
        {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffer; check log for details --",
            ));
        }

        // Verify output data is vertex index + 1.
        invalidate_alloc(device, output_data_buffer.get_allocation())?;
        let output = unsafe {
            std::slice::from_raw_parts(
                output_data_buffer.get_allocation().get_host_ptr().cast::<i32>(),
                num_vertices as usize,
            )
        };
        for (vertex_idx, &value) in output.iter().enumerate() {
            if vertex_idx as u32 == restart_index {
                continue;
            }
            if value != vertex_idx as i32 + 1 {
                return Ok(TestStatus::fail("Unexpected results in data buffer"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMiscTests`
pub fn create_input_assembly_misc_tests() -> TestCaseGroup {
    let mut misc_tests = TestCaseGroup::new("misc");
    // Null input assembly state with rasterization discard enabled and dynamic primitive topology and restart
    for is_rast_discard_dynamic in [false, true] {
        let name = format!(
            "null_state_dynamic_primitive_rast_discard{}",
            if is_rast_discard_dynamic { "_dynamic" } else { "" }
        );
        misc_tests.add_child(Box::new(NullStateTestCase {
            name,
            is_rast_discard_dynamic,
        }) as Box<dyn TestCase>);
    }
    misc_tests
}

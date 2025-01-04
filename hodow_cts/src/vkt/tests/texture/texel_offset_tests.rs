// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/texture/texel_offset/texel_offset.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What the two Amber graphics pipelines do is done directly in one command buffer: `setup` draws `DRAW_RECT 0 0 256 256`
// into the 256x256 texture, `pipeline` draws the same rectangle sampling it (nearest filtering, repeat addressing) into a 256x256 R8G8B8A8 target, whose texels
// 1 to 254 must be (15, 0, 0, 0). The shaders are written by `scripts/gen_texel_offset_amber.py`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::texture_texel_offset::TEXEL_OFFSET;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE: u32 = 256;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

struct TexelOffsetCase;

impl TestCase for TexelOffsetCase {
    fn name(&self) -> &str {
        "texel_offset"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        TEXEL_OFFSET.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TexelOffsetInstance { context })
    }
}

struct TexelOffsetInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for TexelOffsetInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let texture = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(SIZE as i32, SIZE as i32),
                FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED,
            ),
            MemoryRequirement::ANY,
        )?;
        let texture_view = make_image_view(device, texture.get(), vk::ImageViewType::_2D, FORMAT, range)?;
        let target = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(SIZE as i32, SIZE as i32),
                FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let target_view = make_image_view(device, target.get(), vk::ImageViewType::_2D, FORMAT, range)?;
        let render_pass = make_render_pass(device, FORMAT)?;
        let texture_framebuffer = make_framebuffer(device, *render_pass, &[*texture_view], SIZE, SIZE, 1)?;
        let target_framebuffer = make_framebuffer(device, *render_pass, &[*target_view], SIZE, SIZE, 1)?;

        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .max_lod(0.0);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                1,
            )
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *texture_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            image_info: &image_info,
            buffer_info: std::ptr::null(),
            texel_buffer_view: std::ptr::null(),
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // DRAW_RECT 0 0 256 256: two triangles over the whole target
        let positions: [f32; 12] = [-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0];
        let position_bytes: Vec<u8> = positions.iter().flat_map(|value| value.to_ne_bytes()).collect();
        let position_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                position_bytes.len() as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                position_bytes.as_ptr(),
                position_buffer.get_allocation().get_host_ptr(),
                position_bytes.len(),
            )
        };
        flush_alloc(device, position_buffer.get_allocation())?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(SIZE, SIZE);
        state.color_attachment_count = 1;
        state.bindings.push(vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        });
        state.attributes.push(vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        });

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let setup_module = create_shader_module(device, binaries.get("frag_setup")?)?;
        let sample_module = create_shader_module(device, binaries.get("frag")?)?;
        let empty_layout = make_pipeline_layout(device, &[])?;
        let sample_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let setup_pipeline = create_draw_pipeline(
            device,
            *empty_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *setup_module),
            ],
            &state,
        )?;
        let sample_pipeline = create_draw_pipeline(
            device,
            *sample_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *sample_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let clear = vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        };
        let render_area = make_rect_2d(0, 0, SIZE, SIZE);
        begin_command_buffer(device, cmd)?;
        unsafe {
            begin_render_pass(device, cmd, *render_pass, *texture_framebuffer, render_area, clear);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *setup_pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[position_buffer.get()], &[0]);
            device.cmd_draw(cmd, 6, 1, 0, 0);
            end_render_pass(device, cmd);

            let to_sampled = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                texture.get(),
                range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_sampled],
            );

            begin_render_pass(device, cmd, *render_pass, *target_framebuffer, render_area, clear);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *sample_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *sample_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[position_buffer.get()], &[0]);
            device.cmd_draw(cmd, 6, 1, 0, 0);
            end_render_pass(device, cmd);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = read_color_attachment(
            context,
            target.get(),
            FORMAT,
            (SIZE, SIZE),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let pixels = result.data();
        // EXPECT framebuffer IDX 1 1 SIZE 254 254 EQ_RGBA 15 0 0 0
        for y in 1..SIZE - 1 {
            for x in 1..SIZE - 1 {
                let offset = ((y * SIZE + x) * 4) as usize;
                if pixels[offset..offset + 4] != [15, 0, 0, 0] {
                    log::error!(
                        "Probe failed at ({x}, {y}): expected [15, 0, 0, 0], got {:?}",
                        &pixels[offset..offset + 4]
                    );
                    return Ok(TestStatus::fail("Probe failed"));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `dEQP-VK.texture.texel_offset`
pub fn create_texel_offset_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texel_offset");
    group.add_child(Box::new(TexelOffsetCase) as Box<dyn TestCase>);
    group
}

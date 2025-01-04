// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/texture/subgroup_lod/{texel_fetch,texture_grad,texture_lod}.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What the Amber pipelines do is done directly: every mip level of the 512x512 texture is cleared to its own colour
// (Amber does it with one render per `BASE_MIP_LEVEL`), then `DRAW_RECT 0 0 512 512`, which Amber draws as a four vertex triangle strip (bottom left, top left,
// bottom right, top right), samples the texture in the vertex shader with a vertex dependent level of detail; the corners of the target are checked. The shaders are
// written by `scripts/gen_subgroup_lod_amber.py`.

use vulkanalia::prelude::v1_0::*;

use super::subgroup_lod_cases::SUBGROUP_LOD_CASES;
use super::texel_buffer_tests::Expectation;
use crate::generated::shaders::texture_subgroup_lod::ALL_SHARED_PROGRAM;
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

const SIZE: u32 = 512;
const FORMAT: vk::Format = vk::Format::B8G8R8A8_UNORM;

/// One Amber script of `texture.subgroup_lod`
pub struct SubgroupLodCase {
    pub name: &'static str,
    pub key: &'static str,
    /// The colour of each mip level, as the script's `CLEAR_COLOR` 0 to 255 RGBA
    pub clears: &'static [[u8; 4]],
    pub max_lod: f32,
    pub expectations: &'static [Expectation],
}

struct SubgroupLodTestCase {
    data: &'static SubgroupLodCase,
}

impl TestCase for SubgroupLodTestCase {
    fn name(&self) -> &str {
        self.data.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.data.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SubgroupLodInstance {
            context,
            data: self.data,
        })
    }
}

struct SubgroupLodInstance<'a> {
    context: &'a Context<'a>,
    data: &'static SubgroupLodCase,
}

impl TestInstance for SubgroupLodInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let data = self.data;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let mip_levels = data.clears.len() as u32;
        let all_mips = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, mip_levels, 0, 1);
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let texture_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width: SIZE,
                height: SIZE,
                depth: 1,
            })
            .mip_levels(mip_levels)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let texture = ImageWithMemory::new(device, allocator, texture_info, MemoryRequirement::ANY)?;
        let texture_view = make_image_view(device, texture.get(), vk::ImageViewType::_2D, FORMAT, all_mips)?;
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
        let target_view = make_image_view(device, target.get(), vk::ImageViewType::_2D, FORMAT, color_range)?;
        let render_pass = make_render_pass(device, FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*target_view], SIZE, SIZE, 1)?;

        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .max_lod(data.max_lod);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::ALL,
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

        // DRAW_RECT 0 0 512 512 in Amber's vertex order: bottom left, top left, bottom right, top right
        let positions: [f32; 8] = [-1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, -1.0];
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

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(SIZE, SIZE);
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

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            let to_transfer = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                texture.get(),
                all_mips,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            for (level, color) in data.clears.iter().enumerate() {
                // CLEAR_COLOR in the script is 0 to 255 per channel
                let value = vk::ClearColorValue {
                    float32: color.map(|channel| f32::from(channel) / 255.0),
                };
                let level_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, level as u32, 1, 0, 1);
                device.cmd_clear_color_image(
                    cmd,
                    texture.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &value,
                    &[level_range],
                );
            }
            let to_sampled = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                texture.get(),
                all_mips,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::VERTEX_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_sampled],
            );

            // CLEAR_COLOR lod_pipeline 0 0 0 255
            let clear = vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            };
            begin_render_pass(
                device,
                cmd,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, SIZE, SIZE),
                clear,
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[position_buffer.get()], &[0]);
            device.cmd_draw(cmd, 4, 1, 0, 0);
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
        for expectation in data.expectations {
            let offset = ((expectation.y * SIZE + expectation.x) * 4) as usize;
            // The target is B8G8R8A8: the bytes are blue, green, red, alpha
            let actual = [
                pixels[offset + 2],
                pixels[offset + 1],
                pixels[offset],
                pixels[offset + 3],
            ];
            if actual != expectation.rgba {
                log::error!(
                    "Probe failed at ({}, {}): expected {:?}, got {actual:?}",
                    expectation.x,
                    expectation.y,
                    expectation.rgba
                );
                return Ok(TestStatus::fail("Probe failed"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `dEQP-VK.texture.subgroup_lod`
pub fn create_subgroup_lod_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("subgroup_lod");
    for data in SUBGROUP_LOD_CASES {
        group.add_child(Box::new(SubgroupLodTestCase { data }) as Box<dyn TestCase>);
    }
    group
}

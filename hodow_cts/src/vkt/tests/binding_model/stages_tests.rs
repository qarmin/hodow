// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingStagesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrMaintenance6ExtensionDeviceCommands;

use super::dynamic_offset_tests::make_compute_pipeline;
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
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_graphics_pipeline, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The generated case. `descriptor_type` is the case name, which is also how the Rust
/// side recovers the `VkDescriptorType` the shaders were written for.
#[derive(Clone, Copy)]
pub struct StagesCase {
    pub name: &'static str,
    pub descriptor_type: &'static str,
    pub programs: BinaryCollection,
}

impl StagesCase {
    fn descriptor_type(&self) -> vk::DescriptorType {
        match self.descriptor_type {
            "storage_buffer" => vk::DescriptorType::STORAGE_BUFFER,
            "uniform_buffer" => vk::DescriptorType::UNIFORM_BUFFER,
            "combined_image_sampler" => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            other => panic!("unknown descriptor type {other}"),
        }
    }
}

impl TestCase for StagesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_maintenance6")
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StagesTestInstance {
            context,
            descriptor_type: self.descriptor_type(),
        })
    }
}

struct StagesTestInstance<'a> {
    context: &'a Context<'a>,
    descriptor_type: vk::DescriptorType,
}

impl TestInstance for StagesTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let descriptor_type = self.descriptor_type;

        let cmd_pool = make_command_pool(vk, queue_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let read_descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(
            vk,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let write_descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let read_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                descriptor_type,
                vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::COMPUTE,
            )
            .build(vk)?;
        let write_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::COMPUTE,
            )
            .build(vk)?;
        let pipeline_layout = make_pipeline_layout(vk, &[*read_descriptor_set_layout, *write_descriptor_set_layout])?;
        let read_descriptor_set = make_descriptor_set(vk, *read_descriptor_pool, *read_descriptor_set_layout)?;
        let write_descriptor_set = make_descriptor_set(vk, *write_descriptor_pool, *write_descriptor_set_layout)?;

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let sampler_create_info = vk::SamplerCreateInfo {
            s_type: vk::StructureType::SAMPLER_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::SamplerCreateFlags::empty(),
            mag_filter: vk::Filter::LINEAR,
            min_filter: vk::Filter::LINEAR,
            mipmap_mode: vk::SamplerMipmapMode::NEAREST,
            address_mode_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            address_mode_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            address_mode_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            mip_lod_bias: 0.0,
            anisotropy_enable: vk::FALSE,
            max_anisotropy: 1.0,
            compare_enable: vk::FALSE,
            compare_op: vk::CompareOp::NEVER,
            min_lod: 0.0,
            max_lod: 1.0,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            unnormalized_coordinates: vk::FALSE,
        };

        let sampler = Unique::new(
            vk,
            unsafe { vk.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        // Kept alive until the end of the iteration.
        let read_buffer;
        let read_image;
        let read_image_view;

        if descriptor_type == vk::DescriptorType::STORAGE_BUFFER
            || descriptor_type == vk::DescriptorType::UNIFORM_BUFFER
        {
            let usage = if descriptor_type == vk::DescriptorType::STORAGE_BUFFER {
                vk::BufferUsageFlags::STORAGE_BUFFER
            } else {
                vk::BufferUsageFlags::UNIFORM_BUFFER
            };

            read_buffer = BufferWithMemory::new(
                vk,
                allocator,
                make_buffer_create_info(std::mem::size_of::<f32>() as u64 * 4, usage),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            read_image = None;
            read_image_view = None;

            let read_buffer_info = vk::DescriptorBufferInfo {
                buffer: read_buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };

            let read_descriptor_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: read_descriptor_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type,
                image_info: std::ptr::null(),
                buffer_info: &read_buffer_info,
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { vk.update_descriptor_sets(&[read_descriptor_write], &[] as &[vk::CopyDescriptorSet]) };

            let read_alloc = read_buffer.get_allocation();
            let read_data_ptr = read_alloc.get_host_ptr().cast::<f32>();
            for i in 0..4u32 {
                unsafe { *read_data_ptr.add(i as usize) = i as f32 + 1.0 };
            }
            flush_alloc(vk, read_alloc)?;
        } else {
            let image_create_info = make_image_create_info(
                IVec2::new(4, 4),
                vk::Format::R8G8B8A8_UNORM,
                vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
            );
            let image = ImageWithMemory::new(vk, allocator, image_create_info, MemoryRequirement::ANY)?;

            let image_view_create_info = vk::ImageViewCreateInfo {
                s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::ImageViewCreateFlags::empty(),
                image: image.get(),
                view_type: vk::ImageViewType::_2D,
                format: vk::Format::R8G8B8A8_UNORM,
                components: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                subresource_range,
            };
            let view = Unique::new(
                vk,
                unsafe { vk.create_image_view(&image_view_create_info, None) }.vk_check("vkCreateImageView")?,
            );

            let read_image_info = vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            };

            let read_descriptor_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: read_descriptor_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type,
                image_info: &read_image_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { vk.update_descriptor_sets(&[read_descriptor_write], &[] as &[vk::CopyDescriptorSet]) };

            let buffer_size: vk::DeviceSize = 4 * 4 * 4;

            read_buffer = BufferWithMemory::new(
                vk,
                allocator,
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            let read_alloc = read_buffer.get_allocation();
            let read_data_ptr = read_alloc.get_host_ptr();
            for i in 0..4u32 * 4 * 4 {
                unsafe { *read_data_ptr.add(i as usize) = ((((i + 1) % 4) * 64) as i32 - 1) as u8 };
            }
            flush_alloc(vk, read_alloc)?;

            let copy_cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let copy_cmd_buffer = copy_cmd_buffer.get();
            begin_command_buffer(vk, copy_cmd_buffer)?;
            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: 1,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: 4,
                    height: 4,
                    depth: 1,
                },
            };
            let pre_image_memory_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image.get(),
                subresource_range,
            );
            let post_image_memory_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                image.get(),
                subresource_range,
            );
            unsafe {
                vk.cmd_pipeline_barrier(
                    copy_cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_image_memory_barrier],
                );
                vk.cmd_copy_buffer_to_image(
                    copy_cmd_buffer,
                    read_buffer.get(),
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[region],
                );
                vk.cmd_pipeline_barrier(
                    copy_cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_image_memory_barrier],
                );
            }
            end_command_buffer(vk, copy_cmd_buffer)?;
            submit_commands_and_wait(vk, queue, copy_cmd_buffer)?;

            read_image_view = Some(view);
            read_image = Some(image);
        }
        let _ = (&read_image, &read_image_view);

        let write_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                std::mem::size_of::<f32>() as u64 * 4,
                vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let write_buffer_info = vk::DescriptorBufferInfo {
            buffer: write_buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        };

        let write_descriptor_write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: write_descriptor_set.get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            image_info: std::ptr::null(),
            buffer_info: &write_buffer_info,
            texel_buffer_view: std::ptr::null(),
        };
        unsafe { vk.update_descriptor_sets(&[write_descriptor_write], &[] as &[vk::CopyDescriptorSet]) };

        let render_size = (32u32, 32u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image = ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(
                IVec2::new(render_size.0 as i32, render_size.1 as i32),
                color_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_image_view = make_image_view(
            vk,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range,
        )?;

        let render_pass = make_render_pass(vk, color_format)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_image_view], render_size.0, render_size.1, 1)?;

        let binaries = self.context.get_binary_collection();
        let vertex_module = create_shader_module(vk, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(vk, binaries.get("frag")?)?;
        let comp_module = create_shader_module(vk, binaries.get("comp")?)?;

        // The default viewport and scissor of upstream's makeGraphicsPipeline are 256x256
        // whatever the framebuffer is, and the 4-vertex draw below is a triangle list: only
        // the corner of the covered half that falls in the 32x32 target is ever rasterised.
        let pipeline = make_graphics_pipeline(
            vk,
            *pipeline_layout,
            *vertex_module,
            *fragment_module,
            *render_pass,
            (256, 256),
            vk::PrimitiveTopology::TRIANGLE_LIST,
        )?;
        let compute_pipeline = make_compute_pipeline(vk, *pipeline_layout, *comp_module)?;

        let descriptor_sets = [read_descriptor_set.get(), write_descriptor_set.get()];

        let bind_descriptor_sets_info = vk::BindDescriptorSetsInfo {
            s_type: vk::StructureType::BIND_DESCRIPTOR_SETS_INFO,
            next: std::ptr::null(),
            stage_flags: vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::COMPUTE,
            layout: *pipeline_layout,
            first_set: 0,
            descriptor_set_count: 2,
            descriptor_sets: descriptor_sets.as_ptr(),
            dynamic_offset_count: 0,
            dynamic_offsets: std::ptr::null(),
        };

        let color_output_buffer_size = (render_size.0 * render_size.1 * 4) as vk::DeviceSize;
        let color_output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(color_output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_buffer = cmd_buffer.get();
        begin_command_buffer(vk, cmd_buffer)?;
        unsafe { vk.cmd_bind_descriptor_sets2_khr(cmd_buffer, &bind_descriptor_sets_info) };

        unsafe { vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline) };
        begin_render_pass(
            vk,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, render_size.0, render_size.1),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        );
        unsafe { vk.cmd_draw(cmd_buffer, 4, 1, 0, 0) };
        end_render_pass(vk, cmd_buffer);
        unsafe {
            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
            vk.cmd_dispatch(cmd_buffer, 4, 1, 1);
        }

        let image_memory_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            subresource_range,
        );
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: render_size.0,
                height: render_size.1,
                depth: 1,
            },
        };
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_memory_barrier],
            );
            vk.cmd_copy_image_to_buffer(
                cmd_buffer,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_output_buffer.get(),
                &[region],
            );
        }

        end_command_buffer(vk, cmd_buffer)?;

        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        invalidate_alloc(vk, write_buffer.get_allocation())?;
        let write_data_ptr = write_buffer.get_allocation().get_host_ptr().cast::<f32>();

        for i in 0..4u32 {
            let value = unsafe { *write_data_ptr.add(i as usize) };
            if (value - (i as f32 + 1.0)).abs() >= 0.02 {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        invalidate_alloc(vk, color_output_buffer.get_allocation())?;
        let result_buffer = unsafe {
            std::slice::from_raw_parts(
                color_output_buffer.get_allocation().get_host_ptr().cast_const(),
                color_output_buffer_size as usize,
            )
        };

        for y in 0..render_size.1 as usize {
            for x in 0..render_size.0 as usize {
                let pixel = &result_buffer[(y * render_size.0 as usize + x) * 4..][..4];
                for (i, &channel) in pixel.iter().enumerate() {
                    if (channel as f32 / 255.0 - (i as f32 + 1.0) / 4.0).abs() >= 0.02 {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createStagesTests`
pub fn create_stages_tests() -> TestCaseGroup {
    use crate::generated::shaders::binding_model_stages as g;

    let mut group = TestCaseGroup::new("stages");

    for case in [
        g::STAGES_STORAGE_BUFFER,
        g::STAGES_UNIFORM_BUFFER,
        g::STAGES_COMBINED_IMAGE_SAMPLER,
    ] {
        group.add_child(Box::new(case) as Box<dyn TestCase>);
    }

    group
}

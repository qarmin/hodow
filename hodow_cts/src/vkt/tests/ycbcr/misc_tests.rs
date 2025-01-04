// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrMiscTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's fragment shader is SPIR-V
// assembly; here it is mediump GLSL compiled ahead of time (see the manifest).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_set, make_framebuffer, make_graphics_pipeline,
    make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `Move<VkSamplerYcbcrConversion>` - `Unique` has no entry for this handle type.
struct YcbcrConversion<'a> {
    device: &'a Device,
    handle: vk::SamplerYcbcrConversion,
}

impl Drop for YcbcrConversion<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_sampler_ycbcr_conversion(self.handle, None) };
    }
}

#[derive(Clone, Copy)]
pub struct RelaxedPrecisionCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for RelaxedPrecisionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RelaxedPrecisionTestInstance { context })
    }
}

struct RelaxedPrecisionTestInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for RelaxedPrecisionTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let alloc = self.context.get_default_allocator();

        let render_size = (256u32, 256u32);
        let format = vk::Format::G8_B8_R8_3PLANE_420_UNORM;

        let identity = vk::ComponentMapping {
            r: vk::ComponentSwizzle::IDENTITY,
            g: vk::ComponentSwizzle::IDENTITY,
            b: vk::ComponentSwizzle::IDENTITY,
            a: vk::ComponentSwizzle::IDENTITY,
        };

        let conversion_info = vk::SamplerYcbcrConversionCreateInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_CREATE_INFO,
            next: std::ptr::null(),
            format,
            ycbcr_model: vk::SamplerYcbcrModelConversion::RGB_IDENTITY,
            ycbcr_range: vk::SamplerYcbcrRange::ITU_FULL,
            components: identity,
            x_chroma_offset: vk::ChromaLocation::COSITED_EVEN,
            y_chroma_offset: vk::ChromaLocation::COSITED_EVEN,
            chroma_filter: vk::Filter::NEAREST,
            force_explicit_reconstruction: vk::FALSE,
        };

        let ycbcr_conversion = YcbcrConversion {
            device: vk,
            handle: unsafe { vk.create_sampler_ycbcr_conversion(&conversion_info, None) }
                .vk_check("vkCreateSamplerYcbcrConversion")?,
        };

        let sampler_conversion_info = vk::SamplerYcbcrConversionInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_INFO,
            next: std::ptr::null(),
            conversion: ycbcr_conversion.handle,
        };

        let sampler_create_info = vk::SamplerCreateInfo {
            s_type: vk::StructureType::SAMPLER_CREATE_INFO,
            next: (&sampler_conversion_info as *const vk::SamplerYcbcrConversionInfo).cast(),
            flags: vk::SamplerCreateFlags::empty(),
            mag_filter: vk::Filter::NEAREST,
            min_filter: vk::Filter::NEAREST,
            mipmap_mode: vk::SamplerMipmapMode::NEAREST,
            address_mode_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            address_mode_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            address_mode_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            mip_lod_bias: 0.0,
            anisotropy_enable: vk::FALSE,
            max_anisotropy: 1.0,
            compare_enable: vk::FALSE,
            compare_op: vk::CompareOp::ALWAYS,
            min_lod: 0.0,
            max_lod: 0.0,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            unnormalized_coordinates: vk::FALSE,
        };

        let sampler = Unique::new(
            vk,
            unsafe { vk.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        let image_create_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format,
            extent: vk::Extent3D {
                width: render_size.0,
                height: render_size.1,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };

        let image = ImageWithMemory::new(vk, alloc, image_create_info, MemoryRequirement::ANY)?;

        let view_info = vk::ImageViewCreateInfo {
            s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
            next: (&sampler_conversion_info as *const vk::SamplerYcbcrConversionInfo).cast(),
            flags: vk::ImageViewCreateFlags::empty(),
            image: image.get(),
            view_type: vk::ImageViewType::_2D,
            format,
            components: identity,
            subresource_range: make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        };

        let image_view = Unique::new(
            vk,
            unsafe { vk.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
        );

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_sampler_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                &[*sampler],
            )
            .build(vk)?;
        // The pool is sized for three descriptors although the set holds one - as upstream.
        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 3)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *desc_pool, *descriptor_set_layout)?;

        let image_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let descriptor_write = vk::WriteDescriptorSet {
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
        unsafe { vk.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };

        let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;

        let fb_image_create_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: vk::Format::R8G8B8A8_UNORM,
            extent: vk::Extent3D {
                width: render_size.0,
                height: render_size.1,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };

        let fb_image = ImageWithMemory::new(vk, alloc, fb_image_create_info, MemoryRequirement::ANY)?;

        let fb_view_info = vk::ImageViewCreateInfo {
            s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageViewCreateFlags::empty(),
            image: fb_image.get(),
            view_type: vk::ImageViewType::_2D,
            format: vk::Format::R8G8B8A8_UNORM,
            components: identity,
            subresource_range: make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        };

        let fb_image_view = Unique::new(
            vk,
            unsafe { vk.create_image_view(&fb_view_info, None) }.vk_check("vkCreateImageView")?,
        );
        let render_pass = make_render_pass(vk, vk::Format::R8G8B8A8_UNORM)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[*fb_image_view], render_size.0, render_size.1, 1)?;

        let vert_shader_module = create_shader_module(vk, self.context.get_binary_collection().get("vert")?)?;
        let frag_shader_module = create_shader_module(vk, self.context.get_binary_collection().get("frag")?)?;

        let pipeline = make_graphics_pipeline(
            vk,
            *pipeline_layout,
            *vert_shader_module,
            *frag_shader_module,
            *render_pass,
            render_size,
            vk::PrimitiveTopology::TRIANGLE_STRIP,
        )?;

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        begin_command_buffer(vk, cmd_buffer)?;
        let image_memory_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            image.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_memory_barrier],
            );
        }
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
        unsafe {
            vk.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            vk.cmd_draw(cmd_buffer, 4, 1, 0, 0);
        }
        end_render_pass(vk, cmd_buffer);
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMiscTests`
pub fn create_misc_tests() -> TestCaseGroup {
    use crate::generated::shaders::ycbcr_misc as g;

    let mut misc_group = TestCaseGroup::new("misc");
    misc_group.add_child(Box::new(g::RELAXED_PRECISION) as Box<dyn TestCase>);
    misc_group
}

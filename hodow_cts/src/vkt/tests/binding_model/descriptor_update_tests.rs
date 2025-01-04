// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorUpdateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Copyright (c) 2019 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only `empty_descriptor` and `samplerless`
// are ported here, `acceleration_structure` is in `descriptor_update_as_tests.rs`; `random` is not.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::Handle;

use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_graphics_pipeline, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

// ---------------------------------------------------------------------------------
// empty_descriptor
// ---------------------------------------------------------------------------------

/// `EmptyDescriptorUpdateCase` - matches VkPositiveLayerTest.EmptyDescriptorUpdateTest.
struct EmptyDescriptorUpdateCase;

impl TestCase for EmptyDescriptorUpdateCase {
    fn name(&self) -> &str {
        "uniform_buffer"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EmptyDescriptorUpdateInstance { context })
    }
}

struct EmptyDescriptorUpdateInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for EmptyDescriptorUpdateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vki = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        // Create layout with two uniform buffer descriptors w/ empty binding between them
        let layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::ALL)
            .add_indexed_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::empty(), 1, 0)
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::ALL)
            .build(vki)?;

        // Create descriptor pool
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 2)
            .build(vki, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        // Create descriptor set
        let descriptor_set = make_descriptor_set(vki, *descriptor_pool, *layout)?;

        // Create a buffer to be used for update
        let buffer = BufferWithMemory::new(
            vki,
            allocator,
            make_buffer_create_info(256, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::ANY,
        )?;

        // Only update the descriptor at binding 2
        let descriptor_info = vk::DescriptorBufferInfo {
            buffer: buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        };

        let descriptor_write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 2,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::UNIFORM_BUFFER,
            image_info: std::ptr::null(),
            buffer_info: &descriptor_info,
            texel_buffer_view: std::ptr::null(),
        };

        unsafe { vki.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };

        // Test should always pass
        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// samplerless
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum PointerCase {
    Zero,
    One,
    Destroyed,
}

#[derive(Clone, Copy)]
struct SamplerlessParams {
    type_: vk::DescriptorType,
    pointer: PointerCase,
    descriptor_set: u32,
    use_general_layout: bool,
    use_compute_pipeline: bool,
}

/// `SamplerlessDescriptorWriteTestInstance::kImageFormat`
const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
/// `kFramebufferExtent`
const FRAMEBUFFER_EXTENT: (u32, u32) = (64, 64);
/// `kMinimumExtent`
const MINIMUM_EXTENT: (u32, u32) = (1, 1);
/// `kDescriptorColor` as the 8-bit UNORM texel the target image ends up holding.
const DESCRIPTOR_COLOR_BYTES: [u8; 4] = [0, 255, 0, 255];

struct SamplerlessDescriptorWriteTestCase {
    name: String,
    params: SamplerlessParams,
    programs: BinaryCollection,
}

impl SamplerlessDescriptorWriteTestCase {
    /// `getMainImageFeature`
    fn main_image_feature(&self) -> vk::FormatFeatureFlags {
        match self.params.type_ {
            vk::DescriptorType::SAMPLED_IMAGE => vk::FormatFeatureFlags::SAMPLED_IMAGE,
            vk::DescriptorType::STORAGE_IMAGE => vk::FormatFeatureFlags::STORAGE_IMAGE,
            vk::DescriptorType::INPUT_ATTACHMENT => vk::FormatFeatureFlags::COLOR_ATTACHMENT,
            _ => unreachable!(),
        }
    }
}

impl TestCase for SamplerlessDescriptorWriteTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let main_feature = self.main_image_feature();

        let features = vk::FormatFeatureFlags::TRANSFER_DST | // For color clearing.
            vk::FormatFeatureFlags::COLOR_ATTACHMENT | // For the separate frame buffer image (uses the same format).
            main_feature;

        let props = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), IMAGE_FORMAT)
        };
        if !props.optimal_tiling_features.contains(features) {
            return Err(TestError::NotSupported(
                "Image format does not support the required features".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SamplerlessDescriptorWriteTestInstance {
            context,
            params: self.params,
        })
    }
}

struct SamplerlessDescriptorWriteTestInstance<'a> {
    context: &'a Context<'a>,
    params: SamplerlessParams,
}

impl SamplerlessDescriptorWriteTestInstance<'_> {
    /// `getSamplerHandle` - the handle that goes into the descriptor of a type that has
    /// no sampler, which the implementation must ignore whatever it is.
    fn sampler_handle(&self) -> Result<vk::Sampler, TestError> {
        match self.params.pointer {
            PointerCase::Zero => Ok(vk::Sampler::from_raw(0)),
            PointerCase::One => Ok(vk::Sampler::from_raw(1)),
            PointerCase::Destroyed => {
                // `DestroyedSampler`: the sampler is destroyed when `new_sampler` goes out
                // of scope and the handle it held is what gets returned.
                let vkd = self.context.get_device();
                let create_info = vk::SamplerCreateInfo {
                    s_type: vk::StructureType::SAMPLER_CREATE_INFO,
                    next: std::ptr::null(),
                    flags: vk::SamplerCreateFlags::empty(),
                    mag_filter: vk::Filter::NEAREST,
                    min_filter: vk::Filter::NEAREST,
                    mipmap_mode: vk::SamplerMipmapMode::NEAREST,
                    address_mode_u: vk::SamplerAddressMode::REPEAT,
                    address_mode_v: vk::SamplerAddressMode::REPEAT,
                    address_mode_w: vk::SamplerAddressMode::REPEAT,
                    mip_lod_bias: 0.0,
                    anisotropy_enable: vk::FALSE,
                    max_anisotropy: 1.0,
                    compare_enable: vk::FALSE,
                    compare_op: vk::CompareOp::NEVER,
                    min_lod: 0.0,
                    max_lod: 0.0,
                    border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
                    unnormalized_coordinates: vk::FALSE,
                };
                let new_sampler = Unique::new(
                    vkd,
                    unsafe { vkd.create_sampler(&create_info, None) }.vk_check("vkCreateSampler")?,
                );
                Ok(new_sampler.get())
            }
        }
    }

    /// `getMainImageExtent`
    fn main_image_extent(&self) -> (u32, u32) {
        match self.params.type_ {
            vk::DescriptorType::SAMPLED_IMAGE | vk::DescriptorType::STORAGE_IMAGE => MINIMUM_EXTENT,
            vk::DescriptorType::INPUT_ATTACHMENT => FRAMEBUFFER_EXTENT,
            _ => unreachable!(),
        }
    }

    /// `getMainImageUsage`
    fn main_image_usage(&self) -> vk::ImageUsageFlags {
        let mut usage = vk::ImageUsageFlags::TRANSFER_DST; // Used when clearing the image.

        match self.params.type_ {
            vk::DescriptorType::SAMPLED_IMAGE => usage |= vk::ImageUsageFlags::SAMPLED,
            vk::DescriptorType::STORAGE_IMAGE => usage |= vk::ImageUsageFlags::STORAGE,
            vk::DescriptorType::INPUT_ATTACHMENT => usage |= vk::ImageUsageFlags::INPUT_ATTACHMENT,
            _ => unreachable!(),
        }

        usage
    }

    /// `getFbImageUsage`
    fn fb_image_usage(&self) -> vk::ImageUsageFlags {
        let mut usage = vk::ImageUsageFlags::TRANSFER_SRC;
        if !self.params.use_compute_pipeline {
            usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
        } else {
            usage |= vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST;
        }

        usage
    }

    /// `getMainImageShaderLayout`
    fn main_image_shader_layout(&self) -> vk::ImageLayout {
        if self.params.use_general_layout {
            return vk::ImageLayout::GENERAL;
        }

        match self.params.type_ {
            vk::DescriptorType::SAMPLED_IMAGE | vk::DescriptorType::INPUT_ATTACHMENT => {
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
            }
            vk::DescriptorType::STORAGE_IMAGE => vk::ImageLayout::GENERAL,
            _ => unreachable!(),
        }
    }

    /// `MultiQueueRunnerTestInstance` - one pass per queue the case runs on: the universal
    /// queue, plus the compute-only family's for a compute pipeline.
    fn queues(&self) -> Vec<(vk::Queue, u32)> {
        let mut queues = vec![(
            self.context.get_universal_queue(),
            self.context.get_universal_queue_family_index(),
        )];
        if self.params.use_compute_pipeline
            && let Some((queue, family)) = self.context.get_compute_queue()
            && family != self.context.get_universal_queue_family_index()
        {
            queues.push((queue, family));
        }
        queues
    }

    /// `copyImageToBuffer` for a single 2D color layer.
    #[allow(clippy::too_many_arguments)]
    fn copy_image_to_buffer(
        &self,
        cmd_buffer: vk::CommandBuffer,
        image: vk::Image,
        buffer: vk::Buffer,
        size: (u32, u32),
        src_access_mask: vk::AccessFlags,
        old_layout: vk::ImageLayout,
    ) {
        let vkd = self.context.get_device();
        let image_barrier = make_image_memory_barrier(
            src_access_mask,
            vk::AccessFlags::TRANSFER_READ,
            old_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: size.0,
                height: size.1,
                depth: 1,
            },
        };
        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer,
            0,
            (size.0 * size.1 * 4) as vk::DeviceSize,
        );
        unsafe {
            vkd.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            vkd.cmd_copy_image_to_buffer(
                cmd_buffer,
                image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer,
                &[region],
            );
            vkd.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `queuePass`
    fn queue_pass(&self, queue: vk::Queue, queue_index: u32) -> TestOutcome {
        let params = self.params;
        let vkd = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let main_extent = self.main_image_extent();
        let make_image_info = |extent: (u32, u32), usage: vk::ImageUsageFlags| vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: IMAGE_FORMAT,
            extent: vk::Extent3D {
                width: extent.0,
                height: extent.1,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 1,
            queue_family_indices: &queue_index,
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let main_img_create_info = make_image_info(main_extent, self.main_image_usage());
        // `getFbImageUsage() | TRANSFER_SRC` - already included, used when verifying the image.
        let fb_img_create_info = make_image_info(
            FRAMEBUFFER_EXTENT,
            self.fb_image_usage() | vk::ImageUsageFlags::TRANSFER_SRC,
        );

        // Create main and framebuffer images.
        let main_image = ImageWithMemory::new(vkd, allocator, main_img_create_info, MemoryRequirement::ANY)?;
        let fb_image = ImageWithMemory::new(vkd, allocator, fb_img_create_info, MemoryRequirement::ANY)?;

        // Corresponding image views.
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let main_view = make_image_view(
            vkd,
            main_image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            color_subresource_range,
        )?;
        let fb_view = make_image_view(
            vkd,
            fb_image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            color_subresource_range,
        )?;

        // Buffer to copy rendering result to.
        let results_buffer_size = (4 * FRAMEBUFFER_EXTENT.0 * FRAMEBUFFER_EXTENT.1) as vk::DeviceSize;
        let results_buffer = BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(results_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let clear_desc_color = vk::ClearColorValue {
            float32: [0.0, 1.0, 0.0, 1.0],
        };
        let binaries = self.context.get_binary_collection();

        let write_image_descriptor = |set: vk::DescriptorSet,
                                      binding: u32,
                                      descriptor_type: vk::DescriptorType,
                                      info: &vk::DescriptorImageInfo| {
            let write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: set,
                dst_binding: binding,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type,
                image_info: info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { vkd.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        };

        if !params.use_compute_pipeline {
            let full_screen_quad: [[f32; 4]; 6] = [
                [-1.0, -1.0, 0.0, 1.0],
                [1.0, -1.0, 0.0, 1.0],
                [-1.0, 1.0, 0.0, 1.0],
                [-1.0, 1.0, 0.0, 1.0],
                [1.0, -1.0, 0.0, 1.0],
                [1.0, 1.0, 0.0, 1.0],
            ];

            // Vertex buffer.
            let vertex_buffer_size = (full_screen_quad.len() * std::mem::size_of::<[f32; 4]>()) as vk::DeviceSize;
            let vertex_buffer = BufferWithMemory::new(
                vkd,
                allocator,
                make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            // Copy data to vertex buffer.
            let vertex_alloc = vertex_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    full_screen_quad.as_ptr().cast::<u8>(),
                    vertex_alloc.get_host_ptr(),
                    vertex_buffer_size as usize,
                )
            };
            flush_alloc(vkd, vertex_alloc)?;

            // Descriptor set layouts.
            let mut descriptor_set_layouts: Vec<Unique<'_, vk::DescriptorSetLayout>> = Vec::new();
            // Create layouts for required amount of empty descriptor sets before the one that is actually used.
            for _ in 0..params.descriptor_set {
                descriptor_set_layouts.push(DescriptorSetLayoutBuilder::new().build(vkd)?);
            }
            // Create a layout for the descriptor set that is actually used.
            descriptor_set_layouts.push(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(params.type_, vk::ShaderStageFlags::FRAGMENT)
                    .build(vkd)?,
            );

            // Descriptor pool.
            let descriptor_pool = DescriptorPoolBuilder::new().add_type(params.type_, 1).build(
                vkd,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                params.descriptor_set + 1,
            )?;

            // Descriptor sets.
            let mut descriptor_sets: Vec<UniqueDescriptorSet<'_>> = Vec::new();
            for desc_idx in 0..params.descriptor_set as usize {
                descriptor_sets.push(make_descriptor_set(
                    vkd,
                    *descriptor_pool,
                    *descriptor_set_layouts[desc_idx],
                )?);
            }
            descriptor_sets.push(make_descriptor_set(
                vkd,
                *descriptor_pool,
                *descriptor_set_layouts[params.descriptor_set as usize],
            )?);

            // Update descriptor set with the descriptor.
            // IMPORTANT: the chosen sampler handle is used here.
            let descriptor_image_info = vk::DescriptorImageInfo {
                sampler: self.sampler_handle()?,
                image_view: *main_view,
                image_layout: self.main_image_shader_layout(),
            };
            write_image_descriptor(
                descriptor_sets[params.descriptor_set as usize].get(),
                0,
                params.type_,
                &descriptor_image_info,
            );

            // Shader modules.
            let vertex_module = create_shader_module(vkd, binaries.get("vert")?)?;
            let frag_module = create_shader_module(vkd, binaries.get("frag")?)?;

            // Render pass.
            let attachment_layout = if params.use_general_layout {
                vk::ImageLayout::GENERAL
            } else {
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
            };
            let fb_attachment = vk::AttachmentDescription::builder()
                .format(IMAGE_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(attachment_layout)
                .build();

            let mut attachment_descs = vec![fb_attachment];

            if params.type_ == vk::DescriptorType::INPUT_ATTACHMENT {
                // Add it as a frame buffer attachment.
                let input_attachment = vk::AttachmentDescription::builder()
                    .format(IMAGE_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(self.main_image_shader_layout())
                    .final_layout(self.main_image_shader_layout())
                    .build();

                attachment_descs.push(input_attachment);
            }

            let mut input_attachments: Vec<vk::AttachmentReference> = Vec::new();
            if params.type_ == vk::DescriptorType::INPUT_ATTACHMENT {
                input_attachments.push(vk::AttachmentReference {
                    attachment: 1,
                    layout: self.main_image_shader_layout(),
                });
            }

            let color_attachments = [vk::AttachmentReference {
                attachment: 0,
                layout: attachment_layout,
            }];

            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .input_attachments(&input_attachments)
                .color_attachments(&color_attachments)
                .build()];

            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachment_descs)
                .subpasses(&subpasses);
            let render_pass = Unique::new(
                vkd,
                unsafe { vkd.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );

            // Framebuffer.
            let mut attachments = vec![*fb_view];
            if params.type_ == vk::DescriptorType::INPUT_ATTACHMENT {
                attachments.push(*main_view);
            }
            let framebuffer = make_framebuffer(
                vkd,
                *render_pass,
                &attachments,
                FRAMEBUFFER_EXTENT.0,
                FRAMEBUFFER_EXTENT.1,
                1,
            )?;

            // Pipeline layout.
            let set_layout_handles: Vec<vk::DescriptorSetLayout> = descriptor_set_layouts.iter().map(|l| **l).collect();
            let pipeline_layout = make_pipeline_layout(vkd, &set_layout_handles)?;

            // Graphics pipeline.
            let pipeline = make_graphics_pipeline(
                vkd,
                *pipeline_layout,
                *vertex_module,
                *frag_module,
                *render_pass,
                FRAMEBUFFER_EXTENT,
                vk::PrimitiveTopology::TRIANGLE_LIST,
            )?;

            // Command pool and command buffer.
            let cmd_pool = make_command_pool(vkd, queue_index)?;
            let cmd_buffer_ptr = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer_ptr.get();

            // Draw quad.
            let render_area = make_rect_2d(0, 0, FRAMEBUFFER_EXTENT.0, FRAMEBUFFER_EXTENT.1);
            let clear_fb_color = vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            };
            let vertex_buffer_offset: vk::DeviceSize = 0;

            let vtx_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::VERTEX_ATTRIBUTE_READ,
                vertex_buffer.get(),
                0,
                vertex_buffer_size,
            );
            let pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                main_image.get(),
                color_subresource_range,
            );
            let post_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ | vk::AccessFlags::COLOR_ATTACHMENT_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                self.main_image_shader_layout(),
                main_image.get(),
                color_subresource_range,
            );

            begin_command_buffer(vkd, cmd_buffer)?;

            unsafe {
                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::VERTEX_INPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[vtx_buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_clear_barrier],
                );
                vkd.cmd_clear_color_image(
                    cmd_buffer,
                    main_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_desc_color,
                    &[color_subresource_range],
                );
                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_clear_barrier],
                );
            }

            begin_render_pass(vkd, cmd_buffer, *render_pass, *framebuffer, render_area, clear_fb_color);
            unsafe {
                vkd.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                vkd.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    params.descriptor_set,
                    &[descriptor_sets[params.descriptor_set as usize].get()],
                    &[],
                );
                vkd.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                vkd.cmd_draw(cmd_buffer, full_screen_quad.len() as u32, 1, 0, 0);
            }
            end_render_pass(vkd, cmd_buffer);

            self.copy_image_to_buffer(
                cmd_buffer,
                fb_image.get(),
                results_buffer.get(),
                FRAMEBUFFER_EXTENT,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                attachment_layout,
            );

            end_command_buffer(vkd, cmd_buffer)?;
            submit_commands_and_wait(vkd, queue, cmd_buffer)?;
        } else {
            // Compute pipeline

            // Descriptor set layouts.
            let mut descriptor_set_layouts: Vec<Unique<'_, vk::DescriptorSetLayout>> = Vec::new();
            // Create layouts for required amount of empty descriptor sets before the one that is actually used.
            for _ in 0..params.descriptor_set {
                descriptor_set_layouts.push(DescriptorSetLayoutBuilder::new().build(vkd)?);
            }
            // Create a layout for the descriptor set that is actually used.
            descriptor_set_layouts.push(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(params.type_, vk::ShaderStageFlags::COMPUTE)
                    .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
                    .build(vkd)?,
            );

            // Descriptor pool.
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(params.type_, 1)
                .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                .build(
                    vkd,
                    vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                    params.descriptor_set + 1,
                )?;

            // Descriptor sets.
            let mut descriptor_sets: Vec<UniqueDescriptorSet<'_>> = Vec::new();
            for desc_idx in 0..params.descriptor_set as usize {
                descriptor_sets.push(make_descriptor_set(
                    vkd,
                    *descriptor_pool,
                    *descriptor_set_layouts[desc_idx],
                )?);
            }
            descriptor_sets.push(make_descriptor_set(
                vkd,
                *descriptor_pool,
                *descriptor_set_layouts[params.descriptor_set as usize],
            )?);

            // Update descriptor set with the descriptor.
            // IMPORTANT: the chosen sampler handle is used here.
            let descriptor_image_info = vk::DescriptorImageInfo {
                sampler: self.sampler_handle()?,
                image_view: *main_view,
                image_layout: self.main_image_shader_layout(),
            };
            write_image_descriptor(
                descriptor_sets[params.descriptor_set as usize].get(),
                0,
                params.type_,
                &descriptor_image_info,
            );
            let descriptor_storage_image_info = vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *fb_view,
                image_layout: vk::ImageLayout::GENERAL,
            };
            write_image_descriptor(
                descriptor_sets[params.descriptor_set as usize].get(),
                1,
                vk::DescriptorType::STORAGE_IMAGE,
                &descriptor_storage_image_info,
            );

            // Shader modules.
            let compute_module = create_shader_module(vkd, binaries.get("comp")?)?;

            // Pipeline layout.
            let set_layout_handles: Vec<vk::DescriptorSetLayout> = descriptor_set_layouts.iter().map(|l| **l).collect();
            let pipeline_layout = make_pipeline_layout(vkd, &set_layout_handles)?;

            let pipeline = super::dynamic_offset_tests::make_compute_pipeline(vkd, *pipeline_layout, *compute_module)?;

            // Command pool and command buffer.
            let cmd_pool = make_command_pool(vkd, queue_index)?;
            let cmd_buffer_ptr = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer_ptr.get();

            let main_pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                main_image.get(),
                color_subresource_range,
            );
            let main_post_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                self.main_image_shader_layout(),
                main_image.get(),
                color_subresource_range,
            );

            let storage_pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                fb_image.get(),
                color_subresource_range,
            );
            let storage_post_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                fb_image.get(),
                color_subresource_range,
            );

            begin_command_buffer(vkd, cmd_buffer)?;

            unsafe {
                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[main_pre_clear_barrier],
                );
                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[storage_pre_clear_barrier],
                );

                vkd.cmd_clear_color_image(
                    cmd_buffer,
                    main_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_desc_color,
                    &[color_subresource_range],
                );
                vkd.cmd_clear_color_image(
                    cmd_buffer,
                    fb_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_desc_color,
                    &[color_subresource_range],
                );

                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[main_post_clear_barrier],
                );
                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[storage_post_clear_barrier],
                );

                vkd.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
                vkd.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    params.descriptor_set,
                    &[descriptor_sets[params.descriptor_set as usize].get()],
                    &[],
                );
                vkd.cmd_dispatch(cmd_buffer, FRAMEBUFFER_EXTENT.0, FRAMEBUFFER_EXTENT.1, 1);
            }

            self.copy_image_to_buffer(
                cmd_buffer,
                fb_image.get(),
                results_buffer.get(),
                FRAMEBUFFER_EXTENT,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::GENERAL,
            );

            end_command_buffer(vkd, cmd_buffer)?;
            submit_commands_and_wait(vkd, queue, cmd_buffer)?;
        }

        // Check results.
        invalidate_alloc(vkd, results_buffer.get_allocation())?;

        let result_pixels = unsafe {
            std::slice::from_raw_parts(
                results_buffer.get_allocation().get_host_ptr().cast_const(),
                results_buffer_size as usize,
            )
        };

        let pass = result_pixels
            .chunks_exact(4)
            .all(|pixel| pixel == DESCRIPTOR_COLOR_BYTES);

        if !pass {
            log::info!(
                "Rendered image: the first pixel is {:?}, expected {:?}",
                &result_pixels[..4],
                DESCRIPTOR_COLOR_BYTES
            );
            return Ok(TestStatus::fail("Pixel mismatch; please check the rendered image"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for SamplerlessDescriptorWriteTestInstance<'_> {
    /// `MultiQueueRunnerTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        for (queue, queue_index) in self.queues() {
            let status = self.queue_pass(queue, queue_index)?;
            if status.code() != TestResult::Pass {
                return Ok(status);
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createSamplerlessWriteTests`
fn create_samplerless_write_tests() -> TestCaseGroup {
    use crate::generated::shaders::binding_model_descriptor_update as g;

    let mut group = TestCaseGroup::new("samplerless");

    let descriptor_types = [
        (vk::DescriptorType::SAMPLED_IMAGE, "sampled_img"),
        (vk::DescriptorType::STORAGE_IMAGE, "storage_img"),
        (vk::DescriptorType::INPUT_ATTACHMENT, "input_attachment"),
    ];

    let pointer_cases = [
        (PointerCase::Zero, "sampler_zero"),
        (PointerCase::One, "sampler_one"),
        (PointerCase::Destroyed, "sampler_destroyed"),
    ];

    let pipeline_cases = ["graphics", "compute"];

    let programs_for = |type_: vk::DescriptorType, descriptor_set: u32| -> &'static SharedProgram {
        match (type_, descriptor_set) {
            (vk::DescriptorType::SAMPLED_IMAGE, 0) => &g::SAMPLERLESS_SAMPLED_IMG_SET0,
            (vk::DescriptorType::SAMPLED_IMAGE, _) => &g::SAMPLERLESS_SAMPLED_IMG_SET1,
            (vk::DescriptorType::STORAGE_IMAGE, 0) => &g::SAMPLERLESS_STORAGE_IMG_SET0,
            (vk::DescriptorType::STORAGE_IMAGE, _) => &g::SAMPLERLESS_STORAGE_IMG_SET1,
            (_, 0) => &g::SAMPLERLESS_INPUT_ATTACHMENT_SET0,
            (_, _) => &g::SAMPLERLESS_INPUT_ATTACHMENT_SET1,
        }
    };

    for (type_, type_name) in descriptor_types {
        for (pointer, pointer_name) in pointer_cases {
            for descriptor_set in 0..2u32 {
                for layout_ndx in 0..2u32 {
                    for pipeline_ndx in 0..2usize {
                        if type_ == vk::DescriptorType::INPUT_ATTACHMENT && pipeline_ndx != 0 {
                            continue;
                        }

                        let use_general_layout = layout_ndx == 1;
                        let use_compute_pipeline = pipeline_ndx == 1;
                        let mut case_name = format!("{type_name}_{pointer_name}");
                        if use_general_layout {
                            case_name += "_general_layout";
                        }
                        let params = SamplerlessParams {
                            type_,
                            pointer,
                            descriptor_set,
                            use_general_layout,
                            use_compute_pipeline,
                        };
                        if descriptor_set > 0 {
                            case_name += &format!("_set_{descriptor_set}");
                        }
                        case_name += &format!("_{}", pipeline_cases[pipeline_ndx]);

                        group.add_child(Box::new(SamplerlessDescriptorWriteTestCase {
                            name: case_name,
                            params,
                            programs: programs_for(type_, descriptor_set).programs,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }

    group
}

/// `createDescriptorUpdateTests`
pub fn create_descriptor_update_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("descriptor_update");

    // createEmptyDescriptorUpdateTests
    let mut empty_group = TestCaseGroup::new("empty_descriptor");
    empty_group.add_child(Box::new(EmptyDescriptorUpdateCase) as Box<dyn TestCase>);
    group.add_child(empty_group);

    group.add_child(create_samplerless_write_tests());
    group.add_child(super::descriptor_update_as_tests::create_descriptor_update_as_tests());

    group
}

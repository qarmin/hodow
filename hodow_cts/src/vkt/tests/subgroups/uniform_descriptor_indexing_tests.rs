// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsUniformDescriptorIndexingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two shaders of each case are in `shaders/manifest/subgroups_uniform_descriptor_indexing.toml`
// (written by `scripts/gen_subgroups_uniform_descriptor_indexing_manifest.py`, the manifest params are upstream's `ShaderConfiguration`).
// The image, buffer, view and sampler vectors of upstream's instance are locals of `iterate` here (they only live for one call).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::utils::subgroup_properties;
use crate::generated::shaders::subgroups_uniform_descriptor_indexing::ALL_UNIFORM_DESCRIPTOR_INDEXING_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_graphics_pipeline, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_SIZE: u32 = 32;
const IMAGE_FORMAT: vk::Format = vk::Format::R8_UNORM;

/// The `rust_type` of the manifest entries: one `UniformDescriptorIndexingTestCase`.
#[derive(Clone, Copy)]
pub struct UniformDescriptorIndexingProgram {
    pub name: &'static str,
    pub declaration: &'static str,
    pub count: &'static str,
    pub access_method: &'static str,
    pub extra_declarations: &'static str,
    pub extra_layout: &'static str,
    pub programs: BinaryCollection,
}

fn descriptor_type_of(name: &str) -> vk::DescriptorType {
    match name {
        "storage_buffer" => vk::DescriptorType::STORAGE_BUFFER,
        "uniform_buffer" => vk::DescriptorType::UNIFORM_BUFFER,
        "storage_texel_buffer" => vk::DescriptorType::STORAGE_TEXEL_BUFFER,
        "uniform_texel_buffer" => vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
        "input_attachment" => vk::DescriptorType::INPUT_ATTACHMENT,
        "sampler" => vk::DescriptorType::SAMPLER,
        "sampled_image" => vk::DescriptorType::SAMPLED_IMAGE,
        "combined_image_sampler" => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
        "storage_image" => vk::DescriptorType::STORAGE_IMAGE,
        _ => panic!("unknown uniform descriptor indexing case {name}"),
    }
}

/// `TestConfig` of `iterate`
struct TestConfig {
    descriptor_count: u32,
    images_count: u32,
    buffers_count: u32,
    samplers_count: u32,
    min_groups_count: usize,
}

fn test_config(descriptor_type: vk::DescriptorType) -> TestConfig {
    let (descriptor_count, images_count, buffers_count, samplers_count, min_groups_count) = match descriptor_type {
        vk::DescriptorType::STORAGE_BUFFER => (4, 0, 4, 0, 4),
        vk::DescriptorType::UNIFORM_BUFFER => (12, 0, 1, 0, 9),
        vk::DescriptorType::STORAGE_TEXEL_BUFFER => (16, 0, 1, 0, 5),
        vk::DescriptorType::UNIFORM_TEXEL_BUFFER => (16, 0, 1, 0, 5),
        vk::DescriptorType::INPUT_ATTACHMENT => (4, 4, 0, 0, 4),
        vk::DescriptorType::SAMPLER => (4, 1, 0, 4, 2),
        vk::DescriptorType::SAMPLED_IMAGE => (16, 16, 0, 1, 10),
        vk::DescriptorType::COMBINED_IMAGE_SAMPLER => (4, 4, 0, 4, 4),
        vk::DescriptorType::STORAGE_IMAGE => (4, 4, 0, 0, 4),
        _ => unreachable!(),
    };
    TestConfig {
        descriptor_count,
        images_count,
        buffers_count,
        samplers_count,
        min_groups_count,
    }
}

impl TestCase for UniformDescriptorIndexingProgram {
    fn name(&self) -> &str {
        self.name
    }

    /// `UniformDescriptorIndexingTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let subgroup = subgroup_properties(context);
        if subgroup.subgroup_size == 1 {
            return Err(TestError::NotSupported("subgroupSize is 1".to_string()));
        }
        if !subgroup.supported_stages.contains(vk::ShaderStageFlags::FRAGMENT) {
            return Err(TestError::NotSupported(
                "fragment stage doesn't support subgroup operations".to_string(),
            ));
        }

        let mut indexing = vk::PhysicalDeviceVulkan12Features::default();
        let mut features2 = vk::PhysicalDeviceFeatures2 {
            next: std::ptr::from_mut(&mut indexing).cast(),
            ..Default::default()
        };
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if indexing.runtime_descriptor_array == vk::FALSE {
            return Err(TestError::NotSupported(
                "runtimeDescriptorArray not supported".to_string(),
            ));
        }

        let (supported, what) = match descriptor_type_of(self.name) {
            vk::DescriptorType::STORAGE_BUFFER => (
                indexing.shader_storage_buffer_array_non_uniform_indexing,
                "Non-uniform indexing over storage buffer descriptor arrays is not supported.",
            ),
            vk::DescriptorType::UNIFORM_BUFFER => (
                indexing.shader_uniform_buffer_array_non_uniform_indexing,
                "Non-uniform indexing for uniform buffer descriptor arrays is not supported.",
            ),
            vk::DescriptorType::STORAGE_TEXEL_BUFFER => (
                indexing.shader_storage_texel_buffer_array_non_uniform_indexing,
                "Non-uniform indexing for storage texel buffer descriptor arrays is not supported.",
            ),
            vk::DescriptorType::UNIFORM_TEXEL_BUFFER => (
                indexing.shader_uniform_texel_buffer_array_non_uniform_indexing,
                "Non-uniform indexing for uniform texel buffer descriptor arrays is not supported.",
            ),
            vk::DescriptorType::INPUT_ATTACHMENT => (
                indexing.shader_input_attachment_array_non_uniform_indexing,
                "Non-uniform indexing over input attachment descriptor arrays is not supported.",
            ),
            vk::DescriptorType::SAMPLER => (
                indexing.shader_sampled_image_array_non_uniform_indexing,
                "Non-uniform indexing over sampler descriptor arrays is not supported.",
            ),
            vk::DescriptorType::SAMPLED_IMAGE => (
                indexing.shader_sampled_image_array_non_uniform_indexing,
                "Non-uniform indexing over sampled image descriptor arrays is not supported.",
            ),
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER => (
                indexing.shader_sampled_image_array_non_uniform_indexing,
                "Non-uniform indexing over combined image sampler descriptor arrays is not supported.",
            ),
            _ => (
                indexing.shader_storage_image_array_non_uniform_indexing,
                "Non-uniform indexing over storage image descriptor arrays is not supported.",
            ),
        };
        if supported == vk::FALSE {
            return Err(TestError::NotSupported(what.to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UniformDescriptorIndexingInstance {
            context,
            descriptor_type: descriptor_type_of(self.name),
        })
    }
}

struct UniformDescriptorIndexingInstance<'a> {
    context: &'a Context<'a>,
    descriptor_type: vk::DescriptorType,
}

fn image_subresource_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

fn image_create_info(extent: vk::Extent3D, usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format: IMAGE_FORMAT,
        extent,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

fn clear_color_value(value: f32) -> vk::ClearColorValue {
    vk::ClearColorValue { float32: [value; 4] }
}

/// What `setupImages` creates: the images and their views, in the order of the descriptors.
struct Images<'a> {
    images: Vec<ImageWithMemory<'a>>,
    views: Vec<Unique<'a, vk::ImageView>>,
}

/// `setupImages`
fn setup_images<'a>(
    context: &'a Context<'a>,
    images_count: u32,
    image_size: u32,
    usage: vk::ImageUsageFlags,
) -> Result<Images<'a>, TestError> {
    let device = context.get_device();
    let extent = vk::Extent3D {
        width: image_size,
        height: image_size,
        depth: 1,
    };
    let create_info = image_create_info(extent, vk::ImageUsageFlags::TRANSFER_DST | usage);
    let mut images = Vec::new();
    let mut views = Vec::new();
    for _ in 0..images_count {
        let image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            create_info,
            MemoryRequirement::ANY,
        )?;
        views.push(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            image_subresource_range(),
        )?);
        images.push(image);
    }
    Ok(Images { images, views })
}

fn host_buffer<'a>(
    context: &'a Context<'a>,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size, vk::BufferUsageFlags::TRANSFER_DST | usage),
        MemoryRequirement::HOST_VISIBLE,
    )
}

fn fill_floats(buffer: &BufferWithMemory<'_>, byte_offset: usize, count: usize, value: f32) {
    let ptr = unsafe { buffer.get_allocation().get_host_ptr().add(byte_offset) }.cast::<f32>();
    for i in 0..count {
        unsafe { ptr.add(i).write_unaligned(value) };
    }
}

/// `setupRenderPass`
fn setup_render_pass<'a>(
    context: &'a Context<'_>,
    input_attachment_count: u32,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let device = context.get_device();
    let default_attachment = vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format: IMAGE_FORMAT,
        samples: vk::SampleCountFlags::_1,
        load_op: vk::AttachmentLoadOp::DONT_CARE,
        store_op: vk::AttachmentStoreOp::STORE,
        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    };
    let mut attachment_descriptions = vec![default_attachment; 1 + input_attachment_count as usize];
    let color_attachment_ref = vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    };
    let mut input_attachment_refs = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }; 4];
    for i in 0..input_attachment_count as usize {
        let input_attachment = &mut attachment_descriptions[i + 1];
        input_attachment.load_op = vk::AttachmentLoadOp::LOAD;
        input_attachment.initial_layout = vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL;
        input_attachment.final_layout = vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL;
        input_attachment_refs[i].attachment = i as u32 + 1;
    }

    let color_attachments = [color_attachment_ref];
    let subpass_description = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .input_attachments(&input_attachment_refs[..input_attachment_count as usize])
        .color_attachments(&color_attachments)
        .build();
    let subpasses = [subpass_description];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

impl TestInstance for UniformDescriptorIndexingInstance<'_> {
    /// `UniformDescriptorIndexingTestCaseTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let descriptor_type = self.descriptor_type;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let config = test_config(descriptor_type);
        let descriptor_count = config.descriptor_count;
        let images_count = config.images_count;
        let buffers_count = config.buffers_count;
        let samplers_count = config.samplers_count;

        let mut clear_colors = vec![0.0f32; descriptor_count as usize + 1];
        for (i, color) in clear_colors.iter_mut().enumerate().skip(1) {
            *color = i as f32 / (descriptor_count + 1) as f32;
        }

        let extent = vk::Extent3D {
            width: IMAGE_SIZE,
            height: IMAGE_SIZE,
            depth: 1,
        };
        let scissor = make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE);

        // The image the result is written to, and the buffer it is copied to.
        let subresource_range = image_subresource_range();
        let copy_region = make_buffer_image_copy(
            extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let image_layout = if descriptor_type == vk::DescriptorType::STORAGE_IMAGE {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
        };
        let out_image = ImageWithMemory::new(
            device,
            allocator,
            image_create_info(
                extent,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let out_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                (IMAGE_SIZE * IMAGE_SIZE) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let out_image_view = make_image_view(
            device,
            out_image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            subresource_range,
        )?;

        let mut framebuffer_image_views = vec![*out_image_view];
        let mut image_infos: Vec<vk::DescriptorImageInfo> = Vec::new();
        let mut buffer_infos: Vec<vk::DescriptorBufferInfo> = Vec::new();
        let mut buffer_views_raw: Vec<vk::BufferView> = Vec::new();

        let mut images = Images {
            images: Vec::new(),
            views: Vec::new(),
        };
        let mut buffers: Vec<BufferWithMemory> = Vec::new();
        let mut buffer_views: Vec<Unique<'_, vk::BufferView>> = Vec::new();
        let mut samplers: Vec<Unique<'_, vk::Sampler>> = Vec::new();

        if images_count > 0 {
            // Samplers are included when allocating the infos, except for combined image samplers, whose infos hold both.
            let image_info_count = images_count
                + samplers_count * u32::from(descriptor_type != vk::DescriptorType::COMBINED_IMAGE_SAMPLER);
            image_infos = vec![
                vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: vk::ImageView::null(),
                    image_layout,
                };
                image_info_count as usize
            ];

            let (image_size, usage, infos_offset) = match descriptor_type {
                vk::DescriptorType::SAMPLER => (3, vk::ImageUsageFlags::SAMPLED, samplers_count as usize),
                vk::DescriptorType::SAMPLED_IMAGE => (3, vk::ImageUsageFlags::SAMPLED, 0),
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER => (3, vk::ImageUsageFlags::SAMPLED, 0),
                vk::DescriptorType::STORAGE_IMAGE => (3, vk::ImageUsageFlags::STORAGE, 0),
                _ => (IMAGE_SIZE, vk::ImageUsageFlags::INPUT_ATTACHMENT, 0),
            };
            images = setup_images(context, images_count, image_size, usage)?;
            for (i, view) in images.views.iter().enumerate() {
                image_infos[infos_offset + i].image_view = **view;
                if descriptor_type == vk::DescriptorType::INPUT_ATTACHMENT {
                    framebuffer_image_views.push(**view);
                }
            }
        }

        if buffers_count > 0 {
            buffer_infos = vec![
                vk::DescriptorBufferInfo {
                    buffer: vk::Buffer::null(),
                    offset: 0,
                    range: vk::WHOLE_SIZE,
                };
                descriptor_count as usize
            ];

            match descriptor_type {
                vk::DescriptorType::UNIFORM_BUFFER => {
                    // setupUniformBuffers
                    let alignment = context
                        .get_device_properties()
                        .limits
                        .min_uniform_buffer_offset_alignment;
                    let rounded_size = (4 as vk::DeviceSize).div_ceil(alignment.max(1)) * alignment.max(1);
                    let buffer = host_buffer(
                        context,
                        descriptor_count as vk::DeviceSize * rounded_size,
                        vk::BufferUsageFlags::UNIFORM_BUFFER,
                    )?;
                    for i in 0..descriptor_count as usize {
                        let info = &mut buffer_infos[i];
                        info.buffer = buffer.get();
                        info.offset = i as vk::DeviceSize * rounded_size;
                        info.range = rounded_size;
                        fill_floats(&buffer, info.offset as usize, 1, clear_colors[i + 1]);
                    }
                    flush_alloc(device, buffer.get_allocation())?;
                    buffers.push(buffer);
                }
                vk::DescriptorType::STORAGE_BUFFER => {
                    // setupStorageBuffers
                    let values_count = (IMAGE_SIZE * IMAGE_SIZE) as usize;
                    for i in 0..buffers_count as usize {
                        let buffer = host_buffer(
                            context,
                            (values_count * 4) as vk::DeviceSize,
                            vk::BufferUsageFlags::STORAGE_BUFFER,
                        )?;
                        buffer_infos[i] = vk::DescriptorBufferInfo {
                            buffer: buffer.get(),
                            offset: 0,
                            range: vk::WHOLE_SIZE,
                        };
                        fill_floats(&buffer, 0, values_count, clear_colors[1 + i % (clear_colors.len() - 1)]);
                        flush_alloc(device, buffer.get_allocation())?;
                        buffers.push(buffer);
                    }
                }
                _ => {
                    // setupTexelBuffer
                    let usage = if descriptor_type == vk::DescriptorType::UNIFORM_TEXEL_BUFFER {
                        vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
                    } else {
                        vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
                    };
                    let mut alignment = context.get_device_properties().limits.min_texel_buffer_offset_alignment;
                    let mut alignment_features = vk::PhysicalDeviceTexelBufferAlignmentFeaturesEXT::default();
                    let mut features2 = vk::PhysicalDeviceFeatures2 {
                        next: std::ptr::from_mut(&mut alignment_features).cast(),
                        ..Default::default()
                    };
                    unsafe {
                        context
                            .get_instance()
                            .get_physical_device_features2(context.get_physical_device(), &mut features2)
                    };
                    if alignment_features.texel_buffer_alignment != vk::FALSE {
                        let mut alignment_properties = vk::PhysicalDeviceTexelBufferAlignmentPropertiesEXT::default();
                        let mut properties2 = vk::PhysicalDeviceProperties2 {
                            next: std::ptr::from_mut(&mut alignment_properties).cast(),
                            ..Default::default()
                        };
                        unsafe {
                            context
                                .get_instance()
                                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                        };
                        let is_uniform = usage.contains(vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER);
                        let single_texel_alignment = if is_uniform {
                            alignment_properties.uniform_texel_buffer_offset_single_texel_alignment
                        } else {
                            alignment_properties.storage_texel_buffer_offset_single_texel_alignment
                        };
                        let align = if is_uniform {
                            alignment_properties.uniform_texel_buffer_offset_alignment_bytes
                        } else {
                            alignment_properties.storage_texel_buffer_offset_alignment_bytes
                        };
                        alignment = align;
                        if single_texel_alignment != vk::FALSE {
                            alignment = align.min(4);
                        }
                    }

                    let view_items = 2usize;
                    let used_view_size = (view_items * 4) as vk::DeviceSize;
                    let required_alignment = alignment - used_view_size % alignment;
                    let aligned_view_size = used_view_size + required_alignment;
                    let buffer = host_buffer(context, descriptor_count as vk::DeviceSize * aligned_view_size, usage)?;
                    buffer_infos[0] = vk::DescriptorBufferInfo {
                        buffer: buffer.get(),
                        offset: 0,
                        range: vk::WHOLE_SIZE,
                    };
                    for i in 0..descriptor_count as usize {
                        let offset = i as vk::DeviceSize * aligned_view_size;
                        let view_info = vk::BufferViewCreateInfo::builder()
                            .buffer(buffer.get())
                            .format(IMAGE_FORMAT)
                            .offset(offset)
                            .range(used_view_size);
                        let view = Unique::new(
                            device,
                            unsafe { device.create_buffer_view(&view_info, None) }.vk_check("vkCreateBufferView")?,
                        );
                        buffer_views_raw.push(*view);
                        buffer_views.push(view);
                        fill_floats(
                            &buffer,
                            offset as usize,
                            view_items,
                            clear_colors[1 + i % (clear_colors.len() - 1)],
                        );
                    }
                    flush_alloc(device, buffer.get_allocation())?;
                    buffers.push(buffer);
                }
            }
        }

        if samplers_count > 0 {
            // Image infos are offset only for the sampled image case.
            let infos_offset = if descriptor_type == vk::DescriptorType::SAMPLED_IMAGE {
                descriptor_count as usize
            } else {
                0
            };
            let address_modes = [
                vk::SamplerAddressMode::REPEAT,
                vk::SamplerAddressMode::MIRRORED_REPEAT,
                vk::SamplerAddressMode::CLAMP_TO_EDGE,
                vk::SamplerAddressMode::CLAMP_TO_BORDER,
            ];
            for i in 0..samplers_count as usize {
                let sampler_info = vk::SamplerCreateInfo::builder()
                    .border_color(vk::BorderColor::FLOAT_OPAQUE_WHITE)
                    .address_mode_u(address_modes[i % 4]);
                let sampler = Unique::new(
                    device,
                    unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
                );
                image_infos[infos_offset + i].sampler = *sampler;
                samplers.push(sampler);
            }
        }

        let mut pool_builder = DescriptorPoolBuilder::new().add_type(descriptor_type, descriptor_count);
        let mut layout_builder = DescriptorSetLayoutBuilder::new().add_indexed_binding(
            descriptor_type,
            vk::ShaderStageFlags::FRAGMENT,
            0,
            descriptor_count,
        );
        // Some cases need another descriptor type to be able to check the tested one.
        if descriptor_type == vk::DescriptorType::SAMPLER {
            pool_builder = pool_builder.add_type(vk::DescriptorType::SAMPLED_IMAGE, 1);
            layout_builder = layout_builder.add_indexed_binding(
                vk::DescriptorType::SAMPLED_IMAGE,
                vk::ShaderStageFlags::FRAGMENT,
                4,
                1,
            );
        } else if descriptor_type == vk::DescriptorType::SAMPLED_IMAGE {
            pool_builder = pool_builder.add_type(vk::DescriptorType::SAMPLER, 1);
            layout_builder = layout_builder.add_indexed_binding(
                vk::DescriptorType::SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
                descriptor_count,
                1,
            );
        }

        let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let is_buffer = matches!(
            descriptor_type,
            vk::DescriptorType::STORAGE_BUFFER | vk::DescriptorType::UNIFORM_BUFFER
        );
        let is_texel = matches!(
            descriptor_type,
            vk::DescriptorType::STORAGE_TEXEL_BUFFER | vk::DescriptorType::UNIFORM_TEXEL_BUFFER
        );
        let mut writes = vec![vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count,
            descriptor_type,
            image_info: if !is_buffer && !is_texel {
                image_infos.as_ptr()
            } else {
                std::ptr::null()
            },
            buffer_info: if is_buffer {
                buffer_infos.as_ptr()
            } else {
                std::ptr::null()
            },
            texel_buffer_view: if is_texel {
                buffer_views_raw.as_ptr()
            } else {
                std::ptr::null()
            },
        }];
        let extra_type = match descriptor_type {
            vk::DescriptorType::SAMPLER => Some(vk::DescriptorType::SAMPLED_IMAGE),
            vk::DescriptorType::SAMPLED_IMAGE => Some(vk::DescriptorType::SAMPLER),
            _ => None,
        };
        if let Some(extra_type) = extra_type {
            writes.push(vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: descriptor_count,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: extra_type,
                image_info: &image_infos[descriptor_count as usize],
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            });
        }
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let inputs_count = if descriptor_type == vk::DescriptorType::INPUT_ATTACHMENT {
            descriptor_count
        } else {
            0
        };
        let render_pass = setup_render_pass(context, inputs_count)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &framebuffer_image_views,
            IMAGE_SIZE,
            IMAGE_SIZE,
            1,
        )?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *vert_module,
            *frag_module,
            *render_pass,
            (IMAGE_SIZE, IMAGE_SIZE),
            vk::PrimitiveTopology::TRIANGLE_STRIP,
        )?;

        let buffer_access_mask = if descriptor_type == vk::DescriptorType::UNIFORM_BUFFER {
            vk::AccessFlags::UNIFORM_READ
        } else {
            vk::AccessFlags::SHADER_READ
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;

        if images_count > 0 {
            let before_clear: Vec<vk::ImageMemoryBarrier> = images
                .images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        image.get(),
                        subresource_range,
                    )
                })
                .collect();
            let after_clear: Vec<vk::ImageMemoryBarrier> = images
                .images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        image_layout,
                        image.get(),
                        subresource_range,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &before_clear,
                );
                for (i, image) in images.images.iter().enumerate() {
                    device.cmd_clear_color_image(
                        cmd,
                        image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_color_value(clear_colors[i + 1]),
                        &[subresource_range],
                    );
                }
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::ALL_GRAPHICS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &after_clear,
                );
            }
        }

        if buffers_count > 0 {
            let before_draw: Vec<vk::BufferMemoryBarrier> = buffers
                .iter()
                .map(|buffer| {
                    make_buffer_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        buffer_access_mask,
                        buffer.get(),
                        0,
                        vk::WHOLE_SIZE,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &before_draw,
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        // draw a single triangle big enough to cover the whole framebuffer
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            scissor,
            vk::ClearValue {
                color: clear_color_value(0.0),
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        let before_copy = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            out_image.get(),
            subresource_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[before_copy],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                out_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                out_buffer.get(),
                &[copy_region],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, out_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                out_buffer.get_allocation().get_host_ptr().cast_const(),
                (IMAGE_SIZE * IMAGE_SIZE) as usize,
            )
        };

        // count the fragments that have the same value
        let mut result_map = std::collections::BTreeMap::<u32, u32>::new();
        for &pixel in pixels {
            *result_map.entry(u32::from(pixel)).or_insert(0) += 1;
        }

        // none of the fragments may have the background colour and there must be the expected number of colour groups
        if !result_map.contains_key(&0)
            && result_map.len() >= config.min_groups_count
            && result_map.len() <= descriptor_count as usize
        {
            return Ok(TestStatus::pass("Pass"));
        }

        if let Some(background) = result_map.get(&0) {
            return Ok(TestStatus::fail(format!(
                "{background} fragments have background color"
            )));
        }

        Ok(TestStatus::fail(format!(
            "{} groups, expected <{}, {}>",
            result_map.len(),
            config.min_groups_count,
            descriptor_count
        )))
    }
}

/// `createSubgroupsUniformDescriptorIndexingTests`
pub fn create_uniform_descriptor_indexing_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("uniform_descriptor_indexing");
    for program in ALL_UNIFORM_DESCRIPTOR_INDEXING_PROGRAM.iter() {
        group.add_child(Box::new(**program) as Box<dyn TestCase>);
    }
    group
}

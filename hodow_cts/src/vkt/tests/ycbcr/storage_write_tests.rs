// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrStorageImageWriteTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `initPrograms` is `shaders/manifest/ycbcr_storage_image_write.toml`
// (scripts/gen_ycbcr_storage_write_manifest.py), one entry per (format, size) with the programs comp0..compN, found by `programs_for`.
// All channels of these formats are unsigned fixed point, so only that branch of the verification exists.

use std::cell::RefCell;
use std::rc::Rc;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::conversion_util::{SharedPlane, channel_desc, get_channel_access};
use super::storage_write_programs::programs_for;
use super::util::{
    allocate_and_bind_image_memory, format_description, plane_aspect, plane_extent, plane_size_in_bytes,
};
use crate::tcu::tex_verifier::compute_fixed_point_error;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const MAX_PLANES: u32 = 3;
const BUFFER_IMAGE_COPY_OFFSET_GRANULARITY: u32 = 4;
const SIZES: [(u32, u32); 3] = [(512, 512), (1024, 128), (66, 32)];

/// `VK_YCBCR_FORMAT_FIRST..VK_YCBCR_FORMAT_LAST` and then the four 2PLANE_444 formats, in upstream's order
const FORMATS: &[vk::Format] = &[
    vk::Format::G8B8G8R8_422_UNORM,
    vk::Format::B8G8R8G8_422_UNORM,
    vk::Format::G8_B8_R8_3PLANE_420_UNORM,
    vk::Format::G8_B8R8_2PLANE_420_UNORM,
    vk::Format::G8_B8_R8_3PLANE_422_UNORM,
    vk::Format::G8_B8R8_2PLANE_422_UNORM,
    vk::Format::G8_B8_R8_3PLANE_444_UNORM,
    vk::Format::R10X6_UNORM_PACK16,
    vk::Format::R10X6G10X6_UNORM_2PACK16,
    vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16,
    vk::Format::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16,
    vk::Format::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16,
    vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16,
    vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16,
    vk::Format::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16,
    vk::Format::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16,
    vk::Format::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16,
    vk::Format::R12X4_UNORM_PACK16,
    vk::Format::R12X4G12X4_UNORM_2PACK16,
    vk::Format::R12X4G12X4B12X4A12X4_UNORM_4PACK16,
    vk::Format::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16,
    vk::Format::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16,
    vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16,
    vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16,
    vk::Format::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16,
    vk::Format::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16,
    vk::Format::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16,
    vk::Format::G16B16G16R16_422_UNORM,
    vk::Format::B16G16R16G16_422_UNORM,
    vk::Format::G16_B16_R16_3PLANE_420_UNORM,
    vk::Format::G16_B16R16_2PLANE_420_UNORM,
    vk::Format::G16_B16_R16_3PLANE_422_UNORM,
    vk::Format::G16_B16R16_2PLANE_422_UNORM,
    vk::Format::G16_B16_R16_3PLANE_444_UNORM,
    vk::Format::G8_B8R8_2PLANE_444_UNORM,
    vk::Format::G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16,
    vk::Format::G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16,
    vk::Format::G16_B16R16_2PLANE_444_UNORM,
];

#[derive(Clone, Copy)]
struct TestParameters {
    format: vk::Format,
    size: (u32, u32),
    flags: vk::ImageCreateFlags,
}

impl TestParameters {
    fn disjoint(&self) -> bool {
        self.flags.contains(vk::ImageCreateFlags::DISJOINT)
    }
}

/// `getPlaneCompatibleFormatForWriting`
fn plane_compatible_format_for_writing(format: vk::Format, plane_ndx: usize) -> vk::Format {
    let result = format_description(format).planes[plane_ndx].compatible_format;
    match result {
        vk::Format::G8B8G8R8_422_UNORM | vk::Format::B8G8R8G8_422_UNORM => vk::Format::R8G8B8A8_UNORM,
        vk::Format::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
        | vk::Format::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
        | vk::Format::G16B16G16R16_422_UNORM
        | vk::Format::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
        | vk::Format::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
        | vk::Format::B16G16R16G16_422_UNORM => vk::Format::R16G16B16A16_UNORM,
        other => other,
    }
}

/// The format whose description the shader grid of a plane is derived from: the writing format when it differs from what the plane copies as
fn compatible_description_format(format: vk::Format, plane_ndx: usize) -> vk::Format {
    let plane_compatible_format = plane_compatible_format_for_writing(format, plane_ndx);
    if plane_compatible_format != format_description(format).planes[plane_ndx].compatible_format {
        plane_compatible_format
    } else {
        format
    }
}

/// `computeWorkGroupSize`
fn compute_work_group_size(extent: (u32, u32)) -> (u32, u32, u32) {
    let max_invocations = 128u32;
    let x = extent.0.min(128).min(max_invocations);
    let y = extent.1.min(128).min(max_invocations / x);
    let z = 1u32.min(max_invocations / (x * y));
    (x, y, z)
}

fn image_format_supported(
    context: &Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    flags: vk::ImageCreateFlags,
) -> Result<bool, TestError> {
    let info = vk::PhysicalDeviceImageFormatInfo2::builder()
        .format(format)
        .type_(vk::ImageType::_2D)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .flags(flags);
    let mut ycbcr_properties = vk::SamplerYcbcrConversionImageFormatProperties::default();
    let mut properties = vk::ImageFormatProperties2::builder().push_next(&mut ycbcr_properties);
    let result = unsafe {
        context.get_instance().get_physical_device_image_format_properties2(
            context.get_physical_device(),
            &info,
            &mut properties,
        )
    };
    match result {
        Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => Ok(false),
        other => {
            other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?;
            Ok(true)
        }
    }
}

struct StorageImageWriteCase {
    name: &'static str,
    params: TestParameters,
}

impl TestCase for StorageImageWriteCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;
        let disjoint = params.disjoint();
        let description = format_description(params.format);

        if disjoint {
            context.require_device_functionality("VK_KHR_bind_memory2")?;
            context.require_device_functionality("VK_KHR_get_memory_requirements2")?;
        }

        let sampled_usage = vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED;
        if !image_format_supported(context, params.format, sampled_usage, vk::ImageCreateFlags::empty())? {
            return Err(TestError::NotSupported("Format not supported.".to_string()));
        }

        if disjoint {
            for channel_ndx in 0..4 {
                let Some(channel) = channel_desc(params.format, channel_ndx) else {
                    continue;
                };
                let plane_compatible_format =
                    plane_compatible_format_for_writing(params.format, channel.plane as usize);
                if !image_format_supported(
                    context,
                    plane_compatible_format,
                    sampled_usage,
                    vk::ImageCreateFlags::empty(),
                )? {
                    return Err(TestError::NotSupported(
                        "Plane compatibile format not supported.".to_string(),
                    ));
                }
            }
        }

        {
            let mut image_create_flags = params.flags;
            if plane_compatible_format_for_writing(params.format, 0) != params.format {
                image_create_flags |= vk::ImageCreateFlags::MUTABLE_FORMAT;
            }
            let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE;
            if !image_format_supported(context, params.format, usage, image_create_flags)? {
                return Err(TestError::NotSupported("Format not supported.".to_string()));
            }
        }

        {
            let format_properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), params.format)
            };
            let transfer_by_views = disjoint && description.planes.len() > 1;

            if !disjoint
                && !format_properties
                    .optimal_tiling_features
                    .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
            {
                return Err(TestError::NotSupported(
                    "Storage images are not supported for this format".to_string(),
                ));
            }

            if disjoint
                && !format_properties
                    .optimal_tiling_features
                    .contains(vk::FormatFeatureFlags::DISJOINT)
            {
                return Err(TestError::NotSupported(
                    "Disjoint planes are not supported for this format".to_string(),
                ));
            }

            if disjoint && transfer_by_views {
                for plane_ndx in 0..description.planes.len() {
                    let plane_compatible_format = plane_compatible_format_for_writing(params.format, plane_ndx);
                    let plane_properties = unsafe {
                        context.get_instance().get_physical_device_format_properties(
                            context.get_physical_device(),
                            plane_compatible_format,
                        )
                    };
                    if !plane_properties
                        .optimal_tiling_features
                        .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
                    {
                        return Err(TestError::NotSupported(
                            "Storage images are not supported for the plane compatible format".to_string(),
                        ));
                    }
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let name = format!(
            "{}_{}_{}",
            format!("{:?}", self.params.format).to_lowercase(),
            self.params.size.0,
            self.params.size.1
        );
        programs_for(&name).unwrap_or_else(|| BinaryCollection::new(&[]))
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StorageImageWriteInstance {
            context,
            params: self.params,
            programs: self.programs(),
        })
    }
}

struct StorageImageWriteInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
    programs: BinaryCollection,
}

impl TestInstance for StorageImageWriteInstance<'_> {
    /// `testStorageImageWrite`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let vkd = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let description = format_description(params.format);
        let num_planes = description.planes.len();
        let disjoint = params.disjoint();
        let transfer_by_views = disjoint && num_planes > 1;
        let size = params.size;

        let mut image_flags = params.flags;
        if plane_compatible_format_for_writing(params.format, 0) != params.format {
            image_flags |= vk::ImageCreateFlags::MUTABLE_FORMAT;
        }
        let image_create_info = vk::ImageCreateInfo::builder()
            .flags(image_flags)
            .image_type(vk::ImageType::_2D)
            .format(params.format)
            .extent(vk::Extent3D {
                width: size.0,
                height: size.1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED);
        let image = Unique::new(
            vkd,
            unsafe { vkd.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
        );
        let _allocations =
            allocate_and_bind_image_memory(vkd, allocator, *image, params.format, disjoint, MemoryRequirement::ANY)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(vkd)?;
        let pipeline_layout = make_pipeline_layout(vkd, &[*descriptor_set_layout])?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, MAX_PLANES)
            .build(vkd, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, MAX_PLANES)?;

        let command_pool = make_command_pool(vkd, queue_family_index)?;
        let command_buffer = allocate_command_buffer(vkd, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        let mut shader_modules = Vec::new();
        let mut compute_pipelines = Vec::new();
        let mut descriptor_sets = Vec::new();
        let mut image_views = Vec::new();

        begin_command_buffer(vkd, cmd)?;

        for plane_ndx in 0..num_planes {
            let aspect = if num_planes > 1 {
                plane_aspect(plane_ndx)
            } else {
                vk::ImageAspectFlags::COLOR
            };
            let subresource_range = make_image_subresource_range(aspect, 0, 1, 0, 1);
            let plane_compatible_format = plane_compatible_format_for_writing(params.format, plane_ndx);
            let compatible_description = format_description(compatible_description_format(params.format, plane_ndx));
            let compatible_shader_grid_size = (size.0 / description.block_width, size.1 / description.block_height);
            let shader_extent = plane_extent(&compatible_description, compatible_shader_grid_size, plane_ndx);

            let shader_module = create_shader_module(vkd, self.programs.get(&format!("comp{plane_ndx}"))?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*shader_module)
                .name(b"main\0");
            let compute_info = vk::ComputePipelineCreateInfo::builder()
                .stage(*stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0);
            let pipelines = unsafe { vkd.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
                .vk_check("vkCreateComputePipelines")?;
            let compute_pipeline = Unique::new(vkd, pipelines.0[0]);
            unsafe { vkd.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

            let descriptor_set = make_descriptor_set(vkd, *descriptor_pool, *descriptor_set_layout)?;

            let mut image_view_usage = vk::ImageViewUsageCreateInfo::builder().usage(vk::ImageUsageFlags::STORAGE);
            let mut view_info = vk::ImageViewCreateInfo::builder()
                .image(*image)
                .view_type(vk::ImageViewType::_2D)
                .format(plane_compatible_format)
                .components(vk::ComponentMapping::default())
                .subresource_range(subresource_range);
            if transfer_by_views {
                view_info = view_info.push_next(&mut image_view_usage);
            }
            let image_view = Unique::new(
                vkd,
                unsafe { vkd.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
            );

            let image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&image_info);
            unsafe {
                vkd.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]);
                vkd.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
            }

            {
                let layout_change_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    *image,
                    subresource_range,
                );
                unsafe {
                    vkd.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[layout_change_barrier],
                    )
                };
            }

            {
                let work_group_size = compute_work_group_size(shader_extent);
                let x_count = shader_extent.0.div_ceil(work_group_size.0);
                let y_count = shader_extent.1.div_ceil(work_group_size.1);
                let z_count = 1u32.div_ceil(work_group_size.2);

                let max_count = 65535u32;
                if max_count < x_count || max_count < y_count || max_count < z_count {
                    return Err(TestError::NotSupported("Image size is not supported".to_string()));
                }
                unsafe { vkd.cmd_dispatch(cmd, x_count, y_count, z_count) };
            }

            {
                let transfer_barrier = make_image_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    *image,
                    subresource_range,
                );
                unsafe {
                    vkd.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[transfer_barrier],
                    )
                };
            }

            shader_modules.push(shader_module);
            compute_pipelines.push(compute_pipeline);
            descriptor_sets.push(descriptor_set);
            image_views.push(image_view);
        }

        let mut image_size_in_bytes = 0u32;
        let mut plane_offsets = Vec::with_capacity(num_planes);
        for plane_ndx in 0..num_planes {
            plane_offsets.push(image_size_in_bytes);
            image_size_in_bytes += (plane_size_in_bytes(&description, size, plane_ndx) as u32)
                .next_multiple_of(BUFFER_IMAGE_COPY_OFFSET_GRANULARITY);
        }

        let output_buffer = BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(image_size_in_bytes as u64, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer_image_copy: Vec<vk::BufferImageCopy> = (0..num_planes)
            .map(|plane_ndx| {
                let aspect = if num_planes > 1 {
                    plane_aspect(plane_ndx)
                } else {
                    vk::ImageAspectFlags::COLOR
                };
                let extent = plane_extent(&description, size, plane_ndx);
                vk::BufferImageCopy {
                    buffer_offset: plane_offsets[plane_ndx] as u64,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: make_image_subresource_layers(aspect, 0, 0, 1),
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: vk::Extent3D {
                        width: extent.0,
                        height: extent.1,
                        depth: 1,
                    },
                }
            })
            .collect();
        unsafe {
            vkd.cmd_copy_image_to_buffer(
                cmd,
                *image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &buffer_image_copy,
            )
        };

        {
            let host_read_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer.get(),
                0,
                image_size_in_bytes as u64,
            );
            unsafe {
                vkd.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[host_read_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                )
            };
        }

        end_command_buffer(vkd, cmd)?;
        submit_commands_and_wait(vkd, queue, cmd)?;

        invalidate_alloc(vkd, output_buffer.get_allocation())?;
        let output_data = output_buffer.get_allocation().get_host_ptr();
        let planes: Vec<SharedPlane> = (0..num_planes)
            .map(|plane_ndx| {
                let length = plane_size_in_bytes(&description, size, plane_ndx);
                let bytes =
                    unsafe { std::slice::from_raw_parts(output_data.add(plane_offsets[plane_ndx] as usize), length) };
                Rc::new(RefCell::new(bytes.to_vec()))
            })
            .collect();

        let epsilon = 1e-5f32;
        for channel_ndx in 0..4usize {
            let Some(channel) = channel_desc(params.format, channel_ndx) else {
                continue;
            };
            let plane_ndx = channel.plane as usize;
            let compatible_format = compatible_description_format(params.format, plane_ndx);
            let compatible_description = format_description(compatible_format);
            let compatible_shader_grid_size = (size.0 / description.block_width, size.1 / description.block_height);
            let compatible_image_size = (size.0 / description.block_width, size.1 / description.block_height);
            let pixel_buffer = get_channel_access(&planes, compatible_format, compatible_shader_grid_size, channel_ndx);
            let extent = plane_extent(&compatible_description, compatible_image_size, plane_ndx);

            for offset_y in 0..extent.1 {
                for offset_x in 0..extent.0 {
                    let f_reference_value = match channel_ndx {
                        0 => (offset_x % 127) as f32 / 127.0,
                        1 => (offset_y % 127) as f32 / 127.0,
                        2 => 0.0,
                        _ => 1.0,
                    };
                    let acceptable_error = epsilon + compute_fixed_point_error(channel.size_bits as i32);
                    let output_value = pixel_buffer.get_channel([offset_x as i32, offset_y as i32, 0]);
                    if (output_value - f_reference_value).abs() > acceptable_error {
                        return Ok(TestStatus::fail("Failed"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `populateStorageImageWriteFormatGroup`
fn populate_storage_image_write_format_group(test_group: &mut TestCaseGroup) {
    for &format in FORMATS {
        let image_size_alignment = {
            let info = format_description(format);
            let mut alignment = (info.block_width, info.block_height);
            for plane in info.planes {
                alignment.0 = alignment.0.max(plane.width_divisor);
                alignment.1 = alignment.1.max(plane.height_divisor);
            }
            alignment
        };
        let mut format_group = TestCaseGroup::new(format!("{format:?}").to_lowercase());

        for image_size in SIZES {
            if image_size.0 % image_size_alignment.0 != 0 || image_size.1 % image_size_alignment.1 != 0 {
                continue;
            }

            let mut size_group = TestCaseGroup::new(format!("{}_{}_1", image_size.0, image_size.1));
            size_group.add_child(Box::new(StorageImageWriteCase {
                name: "joint",
                params: TestParameters {
                    format,
                    size: image_size,
                    flags: vk::ImageCreateFlags::empty(),
                },
            }) as Box<dyn TestCase>);
            size_group.add_child(Box::new(StorageImageWriteCase {
                name: "disjoint",
                params: TestParameters {
                    format,
                    size: image_size,
                    flags: vk::ImageCreateFlags::DISJOINT | vk::ImageCreateFlags::EXTENDED_USAGE,
                },
            }) as Box<dyn TestCase>);
            format_group.add_child(size_group);
        }
        test_group.add_child(format_group);
    }
}

/// `createStorageImageWriteTests`
pub fn create_storage_image_write_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("storage_image_write");
    populate_storage_image_write_format_group(&mut test_group);
    test_group
}

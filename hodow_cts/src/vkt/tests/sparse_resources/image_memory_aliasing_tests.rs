// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageMemoryAliasing.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device group variant (`device_group_image_sparse_memory_aliasing`) is not ported, so
// the loop over physical devices runs once, and neither are the multi-planar and YCbCr formats (their channels are read through
// `getChannelAccess`, which the reduced `FormatInfo` cannot describe). The compute shaders are in
// shaders/manifest/sparse_resources_image_aliasing.toml (`scripts/gen_sparse_aliasing_manifest.py`): the manifest gives a program no
// parameters of its own, so there is an entry per image type, format, size and mip level and the instance looks them up by `alias_key`
// itself instead of through the case's `programs()`.
//
// Two sparse images (`imageRead`, `imageWrite`) are bound to the same memory for every level above the mip tail. A buffer is copied into
// `imageRead`, a compute shader then writes a pattern into `imageWrite` and `imageRead` is read back: the levels above the mip tail must
// hold the shader's pattern (the memory is aliased), the levels in the mip tail, bound separately, the data copied in.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    BUFFER_IMAGE_COPY_OFFSET_GRANULARITY, ImageType, NO_MATCH_FOUND, TestImageParameters, aligned_divide,
    check_image_format_feature_support, check_sparse_support_for_image_format, check_sparse_support_for_image_type,
    find_matching_memory_type, format_is_r64, get_image_format_id, get_image_mip_level_size_in_bytes,
    get_image_size_alignment, get_image_type_name, get_layer_size, get_mipmap_count, get_num_layers, get_plane_extent,
    get_shader_grid_size, get_sparse_aspect_requirements_index, get_storage_compatible_format, get_test_formats,
    is_image_size_supported, make_sparse_image_memory_bind, make_sparse_memory_bind, map_image_type,
    map_image_view_type, submit_commands_and_wait,
};
use crate::generated::shaders::sparse_resources_image_aliasing::ALL_SHARED_PROGRAM;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::tex_verifier::compute_fixed_point_error;
use crate::tcu::texture::{TextureChannelClass, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::ycbcr::copy_tests::is_ycbcr_format;
use crate::vkt::tests::ycbcr::util::format_description;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const MODULO_DIVISOR: u32 = 127;
const EPSILON: f32 = 1e-5;

/// The key of the manifest entry of a case and mip level.
fn alias_key(image_type: ImageType, image_size: [u32; 3], format: vk::Format, mip_level: u32) -> String {
    format!(
        "alias_{}_{}_{}_{}_{}_m{}",
        get_image_type_name(image_type),
        get_image_format_id(format),
        image_size[0],
        image_size[1],
        image_size[2],
        mip_level
    )
}

/// The number of channels a single plane format has.
fn channel_count(format: vk::Format) -> usize {
    let name = format!("{format:?}");
    name.split('_')
        .next()
        .unwrap_or("")
        .chars()
        .filter(|c| matches!(c, 'R' | 'G' | 'B' | 'A'))
        .count()
}

struct ImageSparseMemoryAliasingCase {
    name: String,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestCase for ImageSparseMemoryAliasingCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ImageSparseMemoryAliasingCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        if context.get_device_features().sparse_residency_aliased == vk::FALSE {
            return Err(TestError::NotSupported(
                "sparseResidencyAliased not supported".to_string(),
            ));
        }

        // Check if image size does not exceed device limits
        if !is_image_size_supported(instance, physical_device, self.image_type, self.image_size) {
            return Err(TestError::NotSupported(
                "Image size not supported for device".to_string(),
            ));
        }

        // Check if device supports sparse operations for image type
        if !check_sparse_support_for_image_type(instance, physical_device, self.image_type) {
            return Err(TestError::NotSupported(
                "Sparse residency for image type is not supported".to_string(),
            ));
        }

        if format_is_r64(self.format) {
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;

            let mut atomic_int64_features = vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut atomic_int64_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };

            if atomic_int64_features.shader_image_int64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderImageInt64Atomics is not supported".to_string(),
                ));
            }

            if atomic_int64_features.sparse_image_int64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "sparseImageInt64Atomics is not supported for device".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn is_stub(&self) -> bool {
        is_ycbcr_format(self.format)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageSparseMemoryAliasingInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            format: self.format,
        })
    }
}

struct ImageSparseMemoryAliasingInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestInstance for ImageSparseMemoryAliasingInstance<'_> {
    /// `ImageSparseMemoryAliasingInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;

        // Create logical device supporting both sparse and compute queues
        let sparse_device = SparseDevice::new(
            context,
            &[
                QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
                QueueRequirements::new(vk::QueueFlags::COMPUTE, 1),
            ],
            false,
        )?;
        let device = sparse_device.device();

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let max_work_group_size = [128u32, 128, 64];
        let max_work_group_count = 65535u32;
        let max_work_group_invocations = 128u32;
        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);
        let format_description = format_description(self.format);
        let tcu_format = map_vk_format(self.format);

        let layer_size = get_layer_size(self.image_type, self.image_size);
        let mut image_sparse_info = vk::ImageCreateInfo::builder()
            .flags(
                vk::ImageCreateFlags::SPARSE_RESIDENCY
                    | vk::ImageCreateFlags::SPARSE_ALIASED
                    | vk::ImageCreateFlags::SPARSE_BINDING,
            )
            .image_type(map_image_type(self.image_type))
            .format(self.format)
            .extent(vk::Extent3D {
                width: layer_size[0],
                height: layer_size[1],
                depth: layer_size[2],
            })
            .mip_levels(1)
            .array_layers(get_num_layers(self.image_type, self.image_size))
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();

        if self.image_type == ImageType::Cube || self.image_type == ImageType::CubeArray {
            image_sparse_info.flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        // Check if device supports sparse operations for image format
        if !check_sparse_support_for_image_format(instance, physical_device, &image_sparse_info) {
            return Err(TestError::NotSupported(
                "The image format does not support sparse operations".to_string(),
            ));
        }

        // Check if image format supports storage images
        if !check_image_format_feature_support(
            instance,
            physical_device,
            image_sparse_info.format,
            vk::FormatFeatureFlags::STORAGE_IMAGE,
        ) {
            return Err(TestError::NotSupported(
                "Device does not support image format for storage image".to_string(),
            ));
        }

        // The YCbCr, multi-planar and `R10X6` family formats are only registered: they stop here, where a device without sparse support for
        // them (every desktop one) has already reported NotSupported as upstream does.
        if is_ycbcr_format(self.format) {
            return Err(TestError::NotPorted(
                "sparse memory aliasing of multi-planar and YCbCr formats".to_string(),
            ));
        }

        let storage_format = get_storage_compatible_format(image_sparse_info.format);
        if storage_format != image_sparse_info.format {
            image_sparse_info.flags |= vk::ImageCreateFlags::MUTABLE_FORMAT;
        }

        {
            // Assign maximum allowed mipmap levels to image
            let result = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    image_sparse_info.format,
                    image_sparse_info.image_type,
                    image_sparse_info.tiling,
                    image_sparse_info.usage,
                    image_sparse_info.flags,
                )
            };
            match result {
                Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                    return Err(TestError::NotSupported(
                        "Image format does not support sparse operations".to_string(),
                    ));
                }
                Ok(image_format_properties) => {
                    image_sparse_info.mip_levels =
                        get_mipmap_count(self.format, &image_format_properties, image_sparse_info.extent);
                }
                Err(_) => image_sparse_info.mip_levels = 1,
            }
        }
        let mip_levels = image_sparse_info.mip_levels;

        // Create sparse image
        let image_read = Unique::new(
            device,
            unsafe { device.create_image(&image_sparse_info, None) }.vk_check("vkCreateImage")?,
        );
        let image_write = Unique::new(
            device,
            unsafe { device.create_image(&image_sparse_info, None) }.vk_check("vkCreateImage")?,
        );

        // Create semaphores to synchronize sparse binding operations with other operations on the sparse images
        let memory_bind_semaphore_transfer = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );
        let memory_bind_semaphore_compute = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );
        let image_memory_bind_semaphores = [*memory_bind_semaphore_transfer, *memory_bind_semaphore_compute];

        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();
        let sparse_memory_requirements;

        {
            // Get sparse image general memory requirements
            let image_memory_requirements = unsafe { device.get_image_memory_requirements(*image_read) };

            // Check if required image memory size does not exceed device limits
            if image_memory_requirements.size
                > unsafe { instance.get_physical_device_properties(physical_device) }
                    .limits
                    .sparse_address_space_size
            {
                return Err(TestError::NotSupported(
                    "Required memory size for sparse resource exceeds device limits".to_string(),
                ));
            }

            assert!(image_memory_requirements.size % image_memory_requirements.alignment == 0);

            let memory_type = find_matching_memory_type(
                instance,
                physical_device,
                &image_memory_requirements,
                MemoryRequirement::ANY,
            );

            if memory_type == NO_MATCH_FOUND {
                return Ok(TestStatus::fail("No matching memory type found"));
            }

            // Get sparse image sparse memory requirements
            sparse_memory_requirements = unsafe { device.get_image_sparse_memory_requirements(*image_read) };
            assert!(!sparse_memory_requirements.is_empty());

            let mut image_residency_memory_binds: Vec<vk::SparseImageMemoryBind> = Vec::new();
            let mut image_read_mip_tail_binds: Vec<vk::SparseMemoryBind> = Vec::new();
            let mut image_write_mip_tail_binds: Vec<vk::SparseMemoryBind> = Vec::new();

            {
                let aspect = vk::ImageAspectFlags::COLOR;
                let aspect_index = get_sparse_aspect_requirements_index(&sparse_memory_requirements, aspect);

                if aspect_index == NO_MATCH_FOUND {
                    return Err(TestError::NotSupported("Not supported image aspect".to_string()));
                }

                let aspect_requirements = sparse_memory_requirements[aspect_index as usize];

                assert!(aspect_requirements.image_mip_tail_size % image_memory_requirements.alignment == 0);

                let image_granularity = aspect_requirements.format_properties.image_granularity;

                // Bind memory for each layer
                for layer_ndx in 0..image_sparse_info.array_layers {
                    for mip_level_ndx in 0..aspect_requirements.image_mip_tail_first_lod {
                        let mip_extent =
                            get_plane_extent(&format_description, image_sparse_info.extent, 0, mip_level_ndx);
                        let sparse_blocks = aligned_divide(mip_extent, image_granularity);
                        let num_sparse_blocks = sparse_blocks[0] * sparse_blocks[1] * sparse_blocks[2];
                        let subresource = vk::ImageSubresource {
                            aspect_mask: aspect,
                            mip_level: mip_level_ndx,
                            array_layer: layer_ndx,
                        };

                        let image_memory_bind = make_sparse_image_memory_bind(
                            device,
                            image_memory_requirements.alignment * vk::DeviceSize::from(num_sparse_blocks),
                            memory_type,
                            subresource,
                            vk::Offset3D { x: 0, y: 0, z: 0 },
                            mip_extent,
                        )?;

                        device_memory.push(Unique::new(device, image_memory_bind.memory));
                        image_residency_memory_binds.push(image_memory_bind);
                    }

                    if !aspect_requirements
                        .format_properties
                        .flags
                        .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                        && aspect_requirements.image_mip_tail_first_lod < image_sparse_info.mip_levels
                    {
                        let offset = aspect_requirements.image_mip_tail_offset
                            + vk::DeviceSize::from(layer_ndx) * aspect_requirements.image_mip_tail_stride;

                        let image_read_mip_tail_memory_bind = make_sparse_memory_bind(
                            device,
                            aspect_requirements.image_mip_tail_size,
                            memory_type,
                            offset,
                            vk::SparseMemoryBindFlags::empty(),
                        )?;
                        device_memory.push(Unique::new(device, image_read_mip_tail_memory_bind.memory));
                        image_read_mip_tail_binds.push(image_read_mip_tail_memory_bind);

                        let image_write_mip_tail_memory_bind = make_sparse_memory_bind(
                            device,
                            aspect_requirements.image_mip_tail_size,
                            memory_type,
                            offset,
                            vk::SparseMemoryBindFlags::empty(),
                        )?;
                        device_memory.push(Unique::new(device, image_write_mip_tail_memory_bind.memory));
                        image_write_mip_tail_binds.push(image_write_mip_tail_memory_bind);
                    }
                }

                if aspect_requirements
                    .format_properties
                    .flags
                    .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                    && aspect_requirements.image_mip_tail_first_lod < image_sparse_info.mip_levels
                {
                    let image_read_mip_tail_memory_bind = make_sparse_memory_bind(
                        device,
                        aspect_requirements.image_mip_tail_size,
                        memory_type,
                        aspect_requirements.image_mip_tail_offset,
                        vk::SparseMemoryBindFlags::empty(),
                    )?;
                    device_memory.push(Unique::new(device, image_read_mip_tail_memory_bind.memory));
                    image_read_mip_tail_binds.push(image_read_mip_tail_memory_bind);

                    let image_write_mip_tail_memory_bind = make_sparse_memory_bind(
                        device,
                        aspect_requirements.image_mip_tail_size,
                        memory_type,
                        aspect_requirements.image_mip_tail_offset,
                        vk::SparseMemoryBindFlags::empty(),
                    )?;
                    device_memory.push(Unique::new(device, image_write_mip_tail_memory_bind.memory));
                    image_write_mip_tail_binds.push(image_write_mip_tail_memory_bind);
                }
            }

            let image_residency_bind_info = [
                vk::SparseImageMemoryBindInfo::builder()
                    .image(*image_read)
                    .binds(&image_residency_memory_binds)
                    .build(),
                vk::SparseImageMemoryBindInfo::builder()
                    .image(*image_write)
                    .binds(&image_residency_memory_binds)
                    .build(),
            ];
            let image_mip_tail_bind_info = [
                vk::SparseImageOpaqueMemoryBindInfo::builder()
                    .image(*image_read)
                    .binds(&image_read_mip_tail_binds)
                    .build(),
                vk::SparseImageOpaqueMemoryBindInfo::builder()
                    .image(*image_write)
                    .binds(&image_write_mip_tail_binds)
                    .build(),
            ];

            let mut bind_sparse_info = vk::BindSparseInfo::builder().signal_semaphores(&image_memory_bind_semaphores);

            if !image_residency_memory_binds.is_empty() {
                bind_sparse_info = bind_sparse_info.image_binds(&image_residency_bind_info);
            }

            if !image_read_mip_tail_binds.is_empty() {
                bind_sparse_info = bind_sparse_info.image_opaque_binds(&image_mip_tail_bind_info);
            }

            // Submit sparse bind commands for execution
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
        }

        let mut image_size_in_bytes = 0u32;
        let mut plane_offsets = vec![0u32; mip_levels as usize];

        for mipmap_ndx in 0..mip_levels {
            plane_offsets[mipmap_ndx as usize] = image_size_in_bytes;
            image_size_in_bytes += get_image_mip_level_size_in_bytes(
                image_sparse_info.extent,
                image_sparse_info.array_layers,
                self.format,
                0,
                mipmap_ndx,
                BUFFER_IMAGE_COPY_OFFSET_GRANULARITY,
            );
        }

        let mut buffer_image_copy: Vec<vk::BufferImageCopy> = Vec::with_capacity(mip_levels as usize);
        for mipmap_ndx in 0..mip_levels {
            buffer_image_copy.push(vk::BufferImageCopy {
                buffer_offset: vk::DeviceSize::from(plane_offsets[mipmap_ndx as usize]),
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: mipmap_ndx,
                    base_array_layer: 0,
                    layer_count: image_sparse_info.array_layers,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: get_plane_extent(&format_description, image_sparse_info.extent, 0, mipmap_ndx),
            });
        }

        // Create command buffer for compute and transfer operations
        let command_pool = make_command_pool(device, compute_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        // Start recording commands
        begin_command_buffer(device, cmd)?;

        let input_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                vk::DeviceSize::from(image_size_in_bytes),
                vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut reference_data = vec![0u8; image_size_in_bytes as usize];

        for mipmap_ndx in 0..mip_levels {
            let mip_level_size_in_bytes = get_image_mip_level_size_in_bytes(
                image_sparse_info.extent,
                image_sparse_info.array_layers,
                self.format,
                0,
                mipmap_ndx,
                BUFFER_IMAGE_COPY_OFFSET_GRANULARITY,
            );
            let buffer_offset = buffer_image_copy[mipmap_ndx as usize].buffer_offset as usize;

            reference_data[buffer_offset..buffer_offset + mip_level_size_in_bytes as usize]
                .fill((mipmap_ndx + 1) as u8);
        }

        unsafe {
            std::ptr::copy_nonoverlapping(
                reference_data.as_ptr(),
                input_buffer.get_allocation().get_host_ptr(),
                image_size_in_bytes as usize,
            )
        };

        flush_alloc(device, input_buffer.get_allocation())?;

        {
            let input_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                input_buffer.get(),
                0,
                vk::DeviceSize::from(image_size_in_bytes),
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[input_buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        {
            let mut image_sparse_transfer_dst_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                *image_read,
                make_image_subresource_range(
                    vk::ImageAspectFlags::COLOR,
                    0,
                    image_sparse_info.mip_levels,
                    0,
                    image_sparse_info.array_layers,
                ),
            );
            if sparse_queue.family_index != compute_queue.family_index {
                image_sparse_transfer_dst_barrier.src_queue_family_index = sparse_queue.family_index;
                image_sparse_transfer_dst_barrier.dst_queue_family_index = compute_queue.family_index;
            }

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_sparse_transfer_dst_barrier],
                );
            }
        }

        unsafe {
            device.cmd_copy_buffer_to_image(
                cmd,
                input_buffer.get(),
                *image_read,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &buffer_image_copy,
            )
        };

        {
            let image_sparse_transfer_src_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                *image_read,
                make_image_subresource_range(
                    vk::ImageAspectFlags::COLOR,
                    0,
                    image_sparse_info.mip_levels,
                    0,
                    image_sparse_info.array_layers,
                ),
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_sparse_transfer_src_barrier],
                );
            }
        }

        {
            let image_sparse_shader_storage_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                *image_write,
                make_image_subresource_range(
                    vk::ImageAspectFlags::COLOR,
                    0,
                    image_sparse_info.mip_levels,
                    0,
                    image_sparse_info.array_layers,
                ),
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_sparse_shader_storage_barrier],
                );
            }
        }

        // Create descriptor set layout
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let total_descriptor_sets = mip_levels;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, total_descriptor_sets)
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                total_descriptor_sets,
            )?;

        let mut image_views = Vec::new();
        let mut descriptor_sets = Vec::new();
        let mut compute_pipelines = Vec::new();
        let mut shader_modules = Vec::new();

        let storage_view_format = get_storage_compatible_format(self.format);

        for mip_level_ndx in 0..mip_levels {
            let key = alias_key(self.image_type, self.image_size, self.format, mip_level_ndx);
            let program = ALL_SHARED_PROGRAM
                .iter()
                .find(|program| program.name == key)
                .ok_or_else(|| TestError::InternalError(format!("no shader {key}")))?;

            // Create and bind compute pipeline
            let shader_module = create_shader_module(device, program.programs.get("comp0")?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*shader_module)
                .name(b"main\0");
            let compute_info = vk::ComputePipelineCreateInfo::builder()
                .stage(*stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0);
            let pipelines =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            let compute_pipeline = Unique::new(device, pipelines.0[0]);

            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

            // Create and bind descriptor set
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

            // Select which mipmap level to bind
            let subresource_range = make_image_subresource_range(
                vk::ImageAspectFlags::COLOR,
                mip_level_ndx,
                1,
                0,
                image_sparse_info.array_layers,
            );

            let image_view = make_image_view(
                device,
                *image_write,
                map_image_view_type(self.image_type),
                storage_view_format,
                subresource_range,
            )?;

            let descriptor_image_sparse_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&descriptor_image_sparse_info);
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                )
            };

            let grid_size = get_shader_grid_size(self.image_type, self.image_size, mip_level_ndx);
            let plane_extent = grid_size;

            let x_work_group_size = plane_extent[0]
                .min(max_work_group_size[0])
                .min(max_work_group_invocations);
            let y_work_group_size = plane_extent[1]
                .min(max_work_group_size[1])
                .min(max_work_group_invocations / x_work_group_size);
            let z_work_group_size = plane_extent[2]
                .min(max_work_group_size[2])
                .min(max_work_group_invocations / (x_work_group_size * y_work_group_size));

            let x_work_group_count = plane_extent[0].div_ceil(x_work_group_size);
            let y_work_group_count = plane_extent[1].div_ceil(y_work_group_size);
            let z_work_group_count = plane_extent[2].div_ceil(z_work_group_size);

            if max_work_group_count < x_work_group_count
                || max_work_group_count < y_work_group_count
                || max_work_group_count < z_work_group_count
            {
                return Err(TestError::NotSupported("Image size is not supported".to_string()));
            }

            unsafe { device.cmd_dispatch(cmd, x_work_group_count, y_work_group_count, z_work_group_count) };

            image_views.push(image_view);
            descriptor_sets.push(descriptor_set);
            compute_pipelines.push(compute_pipeline);
            shader_modules.push(shader_module);
        }

        {
            let memory_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::TRANSFER_READ);

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                vk::DeviceSize::from(image_size_in_bytes),
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                *image_read,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &buffer_image_copy,
            )
        };

        {
            let output_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer.get(),
                0,
                vk::DeviceSize::from(image_size_in_bytes),
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[output_buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        // End recording commands
        end_command_buffer(device, cmd)?;

        let stage_bits = [vk::PipelineStageFlags::TRANSFER, vk::PipelineStageFlags::COMPUTE_SHADER];

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(
            device,
            compute_queue.handle,
            cmd,
            &image_memory_bind_semaphores,
            &stage_bits,
            &[],
        )?;

        // Retrieve data from buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;

        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                image_size_in_bytes as usize,
            )
        };

        // Wait for sparse queue to become idle
        unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        let tcu_format =
            tcu_format.ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", self.format)))?;
        let class = tcu_format.channel_class();
        let size_bits = (tcu_format.pixel_size().unwrap_or(1) * 8 / channel_count(self.format) as u32) as i32;
        let aspect_index =
            get_sparse_aspect_requirements_index(&sparse_memory_requirements, vk::ImageAspectFlags::COLOR);
        if aspect_index == NO_MATCH_FOUND {
            return Err(TestError::NotSupported("Not supported image aspect".to_string()));
        }
        let aspect_requirements = sparse_memory_requirements[aspect_index as usize];
        let first_tail_lod = aspect_requirements.image_mip_tail_first_lod.min(mip_levels);

        for channel_ndx in 0..channel_count(self.format) {
            for mipmap_ndx in 0..first_tail_lod {
                let grid_size = get_shader_grid_size(self.image_type, self.image_size, mipmap_ndx);
                let pixel_buffer = ConstPixelBufferAccess::new(
                    tcu_format,
                    grid_size,
                    &output_data[plane_offsets[mipmap_ndx as usize] as usize..],
                );

                for offset_z in 0..grid_size[2] {
                    for offset_y in 0..grid_size[1] {
                        for offset_x in 0..grid_size[0] {
                            let index = offset_x + grid_size[0] * offset_y + grid_size[0] * grid_size[1] * offset_z;
                            let (integer_reference, float_reference) = if channel_ndx == 3 {
                                (1u32, 1.0f32)
                            } else {
                                (
                                    index % MODULO_DIVISOR,
                                    (index % MODULO_DIVISOR) as f32 / MODULO_DIVISOR as f32,
                                )
                            };

                            let ok = match class {
                                TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger => {
                                    pixel_buffer.get_pixel_uint(offset_x, offset_y, offset_z)[channel_ndx]
                                        == integer_reference
                                }
                                TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint => {
                                    (pixel_buffer.get_pixel(offset_x, offset_y, offset_z)[channel_ndx]
                                        - float_reference)
                                        .abs()
                                        <= EPSILON + compute_fixed_point_error(size_bits)
                                }
                                _ => {
                                    (pixel_buffer.get_pixel(offset_x, offset_y, offset_z)[channel_ndx]
                                        - float_reference)
                                        .abs()
                                        <= EPSILON
                                }
                            };

                            if !ok {
                                return Ok(TestStatus::fail("Failed"));
                            }
                        }
                    }
                }
            }

            for mipmap_ndx in first_tail_lod..mip_levels {
                let mip_level_size_in_bytes = get_image_mip_level_size_in_bytes(
                    image_sparse_info.extent,
                    image_sparse_info.array_layers,
                    self.format,
                    0,
                    mipmap_ndx,
                    1,
                ) as usize;
                let buffer_offset = buffer_image_copy[mipmap_ndx as usize].buffer_offset as usize;

                if output_data[buffer_offset..buffer_offset + mip_level_size_in_bytes]
                    != reference_data[buffer_offset..buffer_offset + mip_level_size_in_bytes]
                {
                    return Ok(TestStatus::fail("Failed"));
                }
            }
        }

        // Keep the bound memory alive until here.
        drop(device_memory);

        Ok(TestStatus::pass("Passed"))
    }
}

/// `createImageSparseMemoryAliasingTestsCommon`, less the device group variant; the YCbCr formats are registered and stop with NotPorted.
pub fn create_image_sparse_memory_aliasing_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("image_sparse_memory_aliasing");

    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1], [128, 128, 1], [503, 137, 1], [11, 37, 1]],
            get_test_formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6], [128, 128, 8], [503, 137, 3], [11, 37, 3]],
            get_test_formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(
            ImageType::Cube,
            vec![[256, 256, 1], [128, 128, 1], [137, 137, 1], [11, 11, 1]],
            get_test_formats(ImageType::Cube),
        ),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6], [128, 128, 8], [137, 137, 3], [11, 11, 3]],
            get_test_formats(ImageType::CubeArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[256, 256, 16], [128, 128, 8], [503, 137, 3], [11, 37, 3]],
            get_test_formats(ImageType::ThreeD),
        ),
    ];

    for parameters in &image_parameters {
        let image_type = parameters.image_type;
        let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_type));

        for &format in &parameters.formats {
            let mut format_group = TestCaseGroup::new(get_image_format_id(format));

            let image_size_alignment = get_image_size_alignment(format);

            for &image_size in &parameters.image_sizes {
                // skip test for images with odd sizes for some YCbCr formats
                if image_size[0] % image_size_alignment[0] != 0 {
                    continue;
                }
                if image_size[1] % image_size_alignment[1] != 0 {
                    continue;
                }

                let name = format!("{}_{}_{}", image_size[0], image_size[1], image_size[2]);
                format_group.add_child(Box::new(ImageSparseMemoryAliasingCase {
                    name,
                    image_type,
                    image_size,
                    format,
                }) as Box<dyn TestCase>);
            }
            image_type_group.add_child(format_group);
        }
        test_group.add_child(image_type_group);
    }

    test_group
}

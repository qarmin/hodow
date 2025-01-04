// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesMipmapSparseResidency.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device group variant (`device_group_mipmap_sparse_residency`) is not
// ported, so the loop over physical devices runs once.
//
// Binds every mip level above the mip tail of a sparse residency image (plus the mip tail and the metadata aspect), writes a
// reference pattern through a buffer copy and reads it back.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    BUFFER_IMAGE_COPY_OFFSET_GRANULARITY, ImageType, NO_MATCH_FOUND, TestImageParameters, aligned_divide,
    check_sparse_support_for_image_format, check_sparse_support_for_image_type, find_matching_memory_type,
    format_is_r64, get_image_format_id, get_image_mip_level_size_in_bytes, get_image_size_alignment,
    get_image_type_name, get_layer_size, get_mipmap_count, get_num_layers, get_plane_extent,
    get_sparse_aspect_requirements_index, get_test_formats, is_image_size_supported, make_sparse_image_memory_bind,
    make_sparse_memory_bind, map_image_type, submit_commands_and_wait,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::ycbcr::util::{format_description, plane_aspect};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct MipmapSparseResidencyCase {
    name: String,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestCase for MipmapSparseResidencyCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

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

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MipmapSparseResidencyInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            format: self.format,
        })
    }
}

struct MipmapSparseResidencyInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestInstance for MipmapSparseResidencyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;

        // Create logical device supporting both sparse and compute operations
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

        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);
        let format_description = format_description(self.format);
        let num_planes = format_description.planes.len();
        let plane_aspect_of = |plane_ndx: usize| {
            if num_planes > 1 {
                plane_aspect(plane_ndx)
            } else {
                vk::ImageAspectFlags::COLOR
            }
        };

        let layer_size = get_layer_size(self.image_type, self.image_size);
        let mut image_sparse_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::SPARSE_RESIDENCY | vk::ImageCreateFlags::SPARSE_BINDING)
            .image_type(map_image_type(self.image_type))
            .format(self.format)
            .extent(vk::Extent3D {
                width: layer_size[0],
                height: layer_size[1],
                depth: layer_size[2],
            })
            .array_layers(get_num_layers(self.image_type, self.image_size))
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC)
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

        {
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

        // Create sparse image
        let image_sparse = Unique::new(
            device,
            unsafe { device.create_image(&image_sparse_info, None) }.vk_check("vkCreateImage")?,
        );

        // Create sparse image memory bind semaphore
        let image_memory_bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        // The bound memory has to outlive the image's use.
        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();

        {
            // Get sparse image general memory requirements
            let image_memory_requirements = unsafe { device.get_image_memory_requirements(*image_sparse) };

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
            let sparse_memory_requirements = unsafe { device.get_image_sparse_memory_requirements(*image_sparse) };
            assert!(!sparse_memory_requirements.is_empty());

            let metadata_aspect_index =
                get_sparse_aspect_requirements_index(&sparse_memory_requirements, vk::ImageAspectFlags::METADATA);

            let mut image_residency_memory_binds: Vec<vk::SparseImageMemoryBind> = Vec::new();
            let mut image_mip_tail_memory_binds: Vec<vk::SparseMemoryBind> = Vec::new();

            for plane_ndx in 0..num_planes {
                let aspect = plane_aspect_of(plane_ndx);
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
                            get_plane_extent(&format_description, image_sparse_info.extent, plane_ndx, mip_level_ndx);
                        let sparse_blocks = aligned_divide(mip_extent, image_granularity);
                        let num_sparse_blocks = sparse_blocks[0] * sparse_blocks[1] * sparse_blocks[2];
                        let subresource = vk::ImageSubresource {
                            aspect_mask: aspect,
                            mip_level: mip_level_ndx,
                            array_layer: layer_ndx,
                        };

                        let image_memory_bind = make_sparse_image_memory_bind(
                            device,
                            image_memory_requirements.alignment * num_sparse_blocks as vk::DeviceSize,
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
                        let image_mip_tail_memory_bind = make_sparse_memory_bind(
                            device,
                            aspect_requirements.image_mip_tail_size,
                            memory_type,
                            aspect_requirements.image_mip_tail_offset
                                + layer_ndx as vk::DeviceSize * aspect_requirements.image_mip_tail_stride,
                            vk::SparseMemoryBindFlags::empty(),
                        )?;

                        device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                        image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                    }

                    // Metadata
                    if metadata_aspect_index != NO_MATCH_FOUND {
                        let metadata_aspect_requirements = sparse_memory_requirements[metadata_aspect_index as usize];

                        if !metadata_aspect_requirements
                            .format_properties
                            .flags
                            .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                        {
                            let image_mip_tail_memory_bind = make_sparse_memory_bind(
                                device,
                                metadata_aspect_requirements.image_mip_tail_size,
                                memory_type,
                                metadata_aspect_requirements.image_mip_tail_offset
                                    + layer_ndx as vk::DeviceSize * metadata_aspect_requirements.image_mip_tail_stride,
                                vk::SparseMemoryBindFlags::METADATA,
                            )?;

                            device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                            image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                        }
                    }
                }

                if aspect_requirements
                    .format_properties
                    .flags
                    .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                    && aspect_requirements.image_mip_tail_first_lod < image_sparse_info.mip_levels
                {
                    let image_mip_tail_memory_bind = make_sparse_memory_bind(
                        device,
                        aspect_requirements.image_mip_tail_size,
                        memory_type,
                        aspect_requirements.image_mip_tail_offset,
                        vk::SparseMemoryBindFlags::empty(),
                    )?;

                    device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                    image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                }
            }

            // Metadata
            if metadata_aspect_index != NO_MATCH_FOUND {
                let metadata_aspect_requirements = sparse_memory_requirements[metadata_aspect_index as usize];

                if metadata_aspect_requirements
                    .format_properties
                    .flags
                    .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                {
                    let image_mip_tail_memory_bind = make_sparse_memory_bind(
                        device,
                        metadata_aspect_requirements.image_mip_tail_size,
                        memory_type,
                        metadata_aspect_requirements.image_mip_tail_offset,
                        vk::SparseMemoryBindFlags::METADATA,
                    )?;

                    device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                    image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                }
            }

            let signal_semaphores = [*image_memory_bind_semaphore];
            let image_residency_bind_info = [vk::SparseImageMemoryBindInfo::builder()
                .image(*image_sparse)
                .binds(&image_residency_memory_binds)
                .build()];
            let image_mip_tail_bind_info = [vk::SparseImageOpaqueMemoryBindInfo::builder()
                .image(*image_sparse)
                .binds(&image_mip_tail_memory_binds)
                .build()];

            let mut bind_sparse_info = vk::BindSparseInfo::builder().signal_semaphores(&signal_semaphores);

            if !image_residency_memory_binds.is_empty() {
                bind_sparse_info = bind_sparse_info.image_binds(&image_residency_bind_info);
            }

            if !image_mip_tail_memory_binds.is_empty() {
                bind_sparse_info = bind_sparse_info.image_opaque_binds(&image_mip_tail_bind_info);
            }

            // Submit sparse bind commands for execution
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
        }

        let mut image_size_in_bytes = 0u32;

        for plane_ndx in 0..num_planes {
            for mipmap_ndx in 0..image_sparse_info.mip_levels {
                image_size_in_bytes += get_image_mip_level_size_in_bytes(
                    image_sparse_info.extent,
                    image_sparse_info.array_layers,
                    self.format,
                    plane_ndx,
                    mipmap_ndx,
                    BUFFER_IMAGE_COPY_OFFSET_GRANULARITY,
                );
            }
        }

        let mut buffer_image_copy = Vec::with_capacity(num_planes * image_sparse_info.mip_levels as usize);
        {
            let mut buffer_offset = 0u32;

            for plane_ndx in 0..num_planes {
                let aspect = plane_aspect_of(plane_ndx);

                for mipmap_ndx in 0..image_sparse_info.mip_levels {
                    buffer_image_copy.push(vk::BufferImageCopy {
                        buffer_offset: buffer_offset as vk::DeviceSize,
                        buffer_row_length: 0,
                        buffer_image_height: 0,
                        image_subresource: vk::ImageSubresourceLayers {
                            aspect_mask: aspect,
                            mip_level: mipmap_ndx,
                            base_array_layer: 0,
                            layer_count: image_sparse_info.array_layers,
                        },
                        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        image_extent: get_plane_extent(
                            &format_description,
                            image_sparse_info.extent,
                            plane_ndx,
                            mipmap_ndx,
                        ),
                    });
                    buffer_offset += get_image_mip_level_size_in_bytes(
                        image_sparse_info.extent,
                        image_sparse_info.array_layers,
                        self.format,
                        plane_ndx,
                        mipmap_ndx,
                        BUFFER_IMAGE_COPY_OFFSET_GRANULARITY,
                    );
                }
            }
        }

        // Create command buffer for compute and transfer operations
        let command_pool = make_command_pool(device, compute_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands
        begin_command_buffer(device, *command_buffer)?;

        let input_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                image_size_in_bytes as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let image_memory_requirements = unsafe { device.get_image_memory_requirements(*image_sparse) };
        let reference_data: Vec<u8> = (0..image_size_in_bytes)
            .map(|value_ndx| ((value_ndx as vk::DeviceSize % image_memory_requirements.alignment) + 1) as u8)
            .collect();

        {
            unsafe {
                std::ptr::copy_nonoverlapping(
                    reference_data.as_ptr(),
                    input_buffer.get_allocation().get_host_ptr(),
                    image_size_in_bytes as usize,
                )
            };
            flush_alloc(device, input_buffer.get_allocation())?;

            let input_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                input_buffer.get(),
                0,
                image_size_in_bytes as vk::DeviceSize,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
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
            let (src_family, dst_family) = if sparse_queue.family_index != compute_queue.family_index {
                (sparse_queue.family_index, compute_queue.family_index)
            } else {
                (vk::QUEUE_FAMILY_IGNORED, vk::QUEUE_FAMILY_IGNORED)
            };
            let image_sparse_transfer_dst_barriers: Vec<vk::ImageMemoryBarrier> = (0..num_planes)
                .map(|plane_ndx| {
                    vk::ImageMemoryBarrier::builder()
                        .src_access_mask(vk::AccessFlags::empty())
                        .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                        .old_layout(vk::ImageLayout::UNDEFINED)
                        .new_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                        .src_queue_family_index(src_family)
                        .dst_queue_family_index(dst_family)
                        .image(*image_sparse)
                        .subresource_range(make_image_subresource_range(
                            plane_aspect_of(plane_ndx),
                            0,
                            image_sparse_info.mip_levels,
                            0,
                            image_sparse_info.array_layers,
                        ))
                        .build()
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &image_sparse_transfer_dst_barriers,
                );
            }
        }

        unsafe {
            device.cmd_copy_buffer_to_image(
                *command_buffer,
                input_buffer.get(),
                *image_sparse,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &buffer_image_copy,
            )
        };

        {
            let image_sparse_transfer_src_barriers: Vec<vk::ImageMemoryBarrier> = (0..num_planes)
                .map(|plane_ndx| {
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        *image_sparse,
                        make_image_subresource_range(
                            plane_aspect_of(plane_ndx),
                            0,
                            image_sparse_info.mip_levels,
                            0,
                            image_sparse_info.array_layers,
                        ),
                    )
                })
                .collect();

            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &image_sparse_transfer_src_barriers,
                );
            }
        }

        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                image_size_in_bytes as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        unsafe {
            device.cmd_copy_image_to_buffer(
                *command_buffer,
                *image_sparse,
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
                image_size_in_bytes as vk::DeviceSize,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
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
        end_command_buffer(device, *command_buffer)?;

        let stage_bits = [vk::PipelineStageFlags::TRANSFER];

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(
            device,
            compute_queue.handle,
            *command_buffer,
            &[*image_memory_bind_semaphore],
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

        for plane_ndx in 0..num_planes {
            for mipmap_ndx in 0..image_sparse_info.mip_levels {
                let mip_level_size_in_bytes = get_image_mip_level_size_in_bytes(
                    image_sparse_info.extent,
                    image_sparse_info.array_layers,
                    self.format,
                    plane_ndx,
                    mipmap_ndx,
                    1,
                ) as usize;
                let buffer_offset = buffer_image_copy
                    [plane_ndx * image_sparse_info.mip_levels as usize + mipmap_ndx as usize]
                    .buffer_offset as usize;

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

/// `createMipmapSparseResidencyTests`
pub fn create_mipmap_sparse_residency_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("mipmap_sparse_residency");

    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1], [1024, 128, 1], [11, 137, 1]],
            get_test_formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6], [1024, 128, 8], [11, 137, 3]],
            get_test_formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(
            ImageType::Cube,
            vec![[256, 256, 1], [128, 128, 1], [137, 137, 1]],
            get_test_formats(ImageType::Cube),
        ),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6], [128, 128, 8], [137, 137, 3]],
            get_test_formats(ImageType::CubeArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[256, 256, 16], [1024, 128, 8], [11, 137, 3]],
            get_test_formats(ImageType::ThreeD),
        ),
    ];

    for parameters in &image_parameters {
        let image_type = parameters.image_type;
        let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_type));

        for &format in &parameters.formats {
            let image_size_alignment = get_image_size_alignment(format);
            let mut format_group = TestCaseGroup::new(get_image_format_id(format));

            for &image_size in &parameters.image_sizes {
                // skip test for images with odd sizes for some YCbCr formats
                if image_size[0] % image_size_alignment[0] != 0 {
                    continue;
                }
                if image_size[1] % image_size_alignment[1] != 0 {
                    continue;
                }

                let name = format!("{}_{}_{}", image_size[0], image_size[1], image_size[2]);

                format_group.add_child(Box::new(MipmapSparseResidencyCase {
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

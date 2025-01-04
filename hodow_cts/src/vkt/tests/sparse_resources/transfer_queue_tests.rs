// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesTransferQueueTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Sparse resources on a transfer queue: a sparse binding image is bound, uploaded and read back, all on one queue family that has
// SPARSE_BINDING and TRANSFER and nothing else of the core flags.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    BUFFER_IMAGE_COPY_OFFSET_GRANULARITY, ImageType, NO_MATCH_FOUND, TestImageParameters, are_lsb4_bits_dont_care,
    are_lsb6_bits_dont_care, find_matching_memory_type, format_is_r64, get_image_format_id,
    get_image_mip_level_size_in_bytes, get_image_size_alignment, get_image_type_name, get_layer_size, get_mipmap_count,
    get_num_layers, get_plane_extent, is_image_size_supported, make_sparse_memory_bind, map_image_type,
    submit_commands_and_wait,
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

/// `getBasicTestFormats`
fn get_basic_test_formats() -> Vec<vk::Format> {
    use vk::Format as F;
    vec![
        // Float formats
        F::R32G32B32A32_SFLOAT,
        F::R16G16B16A16_SFLOAT,
        F::R32_SFLOAT,
        // Uint formats
        F::R32G32B32A32_UINT,
        F::R16G16B16A16_UINT,
        F::R8G8B8A8_UINT,
        F::R32_UINT,
        // Sint formats
        F::R32G32B32A32_SINT,
        F::R16G16B16A16_SINT,
        F::R8G8B8A8_SINT,
        F::R32_SINT,
        // Unorm
        F::R8G8B8A8_UNORM,
        // Snorm
        F::R8G8B8A8_SNORM,
    ]
}

struct SparseResourceTransferQueueCase {
    name: String,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestCase for SparseResourceTransferQueueCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
        }

        if !is_image_size_supported(
            context.get_instance(),
            context.get_physical_device(),
            self.image_type,
            self.image_size,
        ) {
            return Err(TestError::NotSupported(
                "Image size not supported for device".to_string(),
            ));
        }

        if format_is_r64(self.format) {
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;

            let mut atomic_int64_features = vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut atomic_int64_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
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
        Box::new(SparseResourceTransferQueueInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            format: self.format,
        })
    }
}

struct SparseResourceTransferQueueInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestInstance for SparseResourceTransferQueueInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;

        // Create logical device supporting both sparse and transfer queues; upstream forces a specific (transfer only) family here.
        let transfer_flags = vk::QueueFlags::SPARSE_BINDING | vk::QueueFlags::TRANSFER;
        let sparse_device = SparseDevice::new(context, &[QueueRequirements::new(transfer_flags, 1)], true)?;
        let device = sparse_device.device();

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let transfer_queue = sparse_device.get_queue(transfer_flags, 0);

        let description = format_description(self.format);
        let num_planes = description.planes.len() as u32;

        // Filling sparse image info
        let layer_size = get_layer_size(self.image_type, self.image_size);
        let mut sparse_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::SPARSE_BINDING)
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
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();

        if self.image_type == ImageType::Cube || self.image_type == ImageType::CubeArray {
            sparse_info.flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        let image_format_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                sparse_info.format,
                sparse_info.image_type,
                sparse_info.tiling,
                sparse_info.usage,
                sparse_info.flags,
            )
        };
        match image_format_properties {
            Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                return Err(TestError::NotSupported(
                    "Image format does not support sparse binding operations".to_string(),
                ));
            }
            Ok(properties) => sparse_info.mip_levels = get_mipmap_count(self.format, &properties, sparse_info.extent),
            Err(_) => sparse_info.mip_levels = 1,
        }

        // Creating and binding sparse image
        let sparse_image = Unique::new(
            device,
            unsafe { device.create_image(&sparse_info, None) }.vk_check("vkCreateImage")?,
        );
        let image_memory_bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );
        let image_memory_requirements = unsafe { device.get_image_memory_requirements(*sparse_image) };
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

        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();
        {
            let num_sparse_binds = (image_memory_requirements.size / image_memory_requirements.alignment) as u32;
            let memory_type = find_matching_memory_type(
                instance,
                physical_device,
                &image_memory_requirements,
                MemoryRequirement::ANY,
            );

            if memory_type == NO_MATCH_FOUND {
                return Ok(TestStatus::fail("No matching memory type found"));
            }

            let mut sparse_memory_binds = Vec::new();
            for sparse_bind_ndx in 0..num_sparse_binds {
                let sparse_memory_bind = make_sparse_memory_bind(
                    device,
                    image_memory_requirements.alignment,
                    memory_type,
                    image_memory_requirements.alignment * sparse_bind_ndx as vk::DeviceSize,
                    vk::SparseMemoryBindFlags::empty(),
                )?;
                device_memory.push(Unique::new(device, sparse_memory_bind.memory));
                sparse_memory_binds.push(sparse_memory_bind);
            }

            let opaque_bind_info = [vk::SparseImageOpaqueMemoryBindInfo::builder()
                .image(*sparse_image)
                .binds(&sparse_memory_binds)
                .build()];
            let signal_semaphores = [*image_memory_bind_semaphore];
            let bind_sparse_info = vk::BindSparseInfo::builder()
                .image_opaque_binds(&opaque_bind_info)
                .signal_semaphores(&signal_semaphores);

            // Submit sparse bind commands for execution
            unsafe { device.queue_bind_sparse(transfer_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
        }

        // Uploading
        let mut image_size_in_bytes = 0u32;

        for plane_ndx in 0..num_planes as usize {
            for mipmap_ndx in 0..sparse_info.mip_levels {
                image_size_in_bytes += get_image_mip_level_size_in_bytes(
                    sparse_info.extent,
                    sparse_info.array_layers,
                    self.format,
                    plane_ndx,
                    mipmap_ndx,
                    BUFFER_IMAGE_COPY_OFFSET_GRANULARITY,
                );
            }
        }

        let plane_aspect_of = |plane_ndx: usize| {
            if num_planes > 1 {
                plane_aspect(plane_ndx)
            } else {
                vk::ImageAspectFlags::COLOR
            }
        };

        let mut buffer_image_copy = Vec::with_capacity((num_planes * sparse_info.mip_levels) as usize);
        {
            let mut buffer_offset = 0u32;
            for plane_ndx in 0..num_planes as usize {
                let aspect = plane_aspect_of(plane_ndx);

                for mipmap_ndx in 0..sparse_info.mip_levels {
                    buffer_image_copy.push(vk::BufferImageCopy {
                        buffer_offset: buffer_offset as vk::DeviceSize,
                        buffer_row_length: 0,
                        buffer_image_height: 0,
                        image_subresource: vk::ImageSubresourceLayers {
                            aspect_mask: aspect,
                            mip_level: mipmap_ndx,
                            base_array_layer: 0,
                            layer_count: sparse_info.array_layers,
                        },
                        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        image_extent: get_plane_extent(&description, sparse_info.extent, plane_ndx, mipmap_ndx),
                    });
                    buffer_offset += get_image_mip_level_size_in_bytes(
                        sparse_info.extent,
                        sparse_info.array_layers,
                        self.format,
                        plane_ndx,
                        mipmap_ndx,
                        BUFFER_IMAGE_COPY_OFFSET_GRANULARITY,
                    );
                }
            }
        }

        // Create command buffer for compute and transfer operations
        let command_pool = make_command_pool(device, transfer_queue.family_index)?;
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
            let image_sparse_transfer_dst_barriers: Vec<vk::ImageMemoryBarrier> = (0..num_planes as usize)
                .map(|plane_ndx| {
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        *sparse_image,
                        make_image_subresource_range(
                            plane_aspect_of(plane_ndx),
                            0,
                            sparse_info.mip_levels,
                            0,
                            sparse_info.array_layers,
                        ),
                    )
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
                *sparse_image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &buffer_image_copy,
            )
        };

        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                image_size_in_bytes as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Reading back from sparse image
        {
            let image_sparse_transfer_src_barriers: Vec<vk::ImageMemoryBarrier> = (0..num_planes as usize)
                .map(|plane_ndx| {
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        *sparse_image,
                        make_image_subresource_range(
                            plane_aspect_of(plane_ndx),
                            0,
                            sparse_info.mip_levels,
                            0,
                            sparse_info.array_layers,
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
                device.cmd_copy_image_to_buffer(
                    *command_buffer,
                    *sparse_image,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    output_buffer.get(),
                    &buffer_image_copy,
                );
            }
        }

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

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(
            device,
            transfer_queue.handle,
            *command_buffer,
            &[*image_memory_bind_semaphore],
            &[vk::PipelineStageFlags::TRANSFER],
            &[],
        )?;

        // Retrieve data from buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;

        // Wait for sparse queue to become idle
        unsafe { device.queue_wait_idle(transfer_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                image_size_in_bytes as usize,
            )
        };
        let ignore_lsb6_bits = are_lsb6_bits_dont_care(sparse_info.format);
        let ignore_lsb4_bits = are_lsb4_bits_dont_care(sparse_info.format);

        for plane_ndx in 0..num_planes as usize {
            for mipmap_ndx in 0..sparse_info.mip_levels {
                let mip_level_size_in_bytes = get_image_mip_level_size_in_bytes(
                    sparse_info.extent,
                    sparse_info.array_layers,
                    self.format,
                    plane_ndx,
                    mipmap_ndx,
                    1,
                );
                let buffer_offset = buffer_image_copy[plane_ndx * sparse_info.mip_levels as usize + mipmap_ndx as usize]
                    .buffer_offset as usize;

                // Validate results
                for byte_ndx in 0..mip_level_size_in_bytes as usize {
                    let res = output_data[buffer_offset + byte_ndx];
                    let reference = reference_data[buffer_offset + byte_ndx];

                    let mut mask = 0xFFu8;

                    if byte_ndx & 0x01 == 0 && ignore_lsb6_bits {
                        mask = 0xC0;
                    } else if byte_ndx & 0x01 == 0 && ignore_lsb4_bits {
                        mask = 0xF0;
                    }

                    if res & mask != reference & mask {
                        return Ok(TestStatus::fail("Failed"));
                    }
                }
            }
        }

        drop(device_memory);
        Ok(TestStatus::pass("Passed"))
    }
}

/// `createTransferQueueTests`
pub fn create_transfer_queue_tests() -> TestCaseGroup {
    let image_parameters = vec![TestImageParameters::new(
        ImageType::TwoD,
        vec![[512, 256, 1]],
        get_basic_test_formats(),
    )];

    // Sparse resources on transfer queue operation tests.
    let mut transfer_group = TestCaseGroup::new("transfer_queue");

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
                format_group.add_child(Box::new(SparseResourceTransferQueueCase {
                    name,
                    image_type,
                    image_size,
                    format,
                }) as Box<dyn TestCase>);
            }
            image_type_group.add_child(format_group);
        }
        transfer_group.add_child(image_type_group);
    }

    transfer_group
}

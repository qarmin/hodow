// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageRebind.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device group variant is not ported, so the loop over physical devices runs
// once. YCbCr formats are skipped by the case tree as upstream does, so every image has exactly one plane and the comparison goes
// through a tightly packed `tcu::ConstPixelBufferAccess` of the format; the readback image is not logged.
//
// Creates a sparse residency image and two backing device memory objects.
// 1) Binds the first memory fully to the image and fills it with data.
// 2) Binds the second memory fully (this unbinds the first memory) to the image and fills it with different data.
// 3) Rebinds one block from the first memory back into one layer and at non 0, 0 offset.
// 4) Copies data out of the sparse image into a host accessible buffer.
// 5) Verifies that the data in the host accessible buffer is correct.

use vulkanalia::prelude::v1_0::*;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    BUFFER_IMAGE_COPY_OFFSET_GRANULARITY, ImageType, NO_MATCH_FOUND, TestImageParameters, aligned_divide,
    check_sparse_support_for_image_format, check_sparse_support_for_image_type, find_matching_memory_type,
    get_image_format_id, get_image_mip_level_size_in_bytes, get_image_type_name, get_layer_size, get_num_layers,
    get_plane_extent, get_sparse_aspect_requirements_index, get_test_formats, is_image_size_supported, map_image_type,
    submit_commands_and_wait,
};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::tex_verifier::compute_fixed_point_error;
use crate::tcu::texture::{TextureChannelClass, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::ycbcr::copy_tests::is_ycbcr_format;
use crate::vkt::tests::ycbcr::util::{format_description, plane_aspect};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const MEMORY_OBJECT_COUNT: usize = 2;

struct ImageSparseRebindCase {
    name: String,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestCase for ImageSparseRebindCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
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

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageSparseRebindInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            format: self.format,
        })
    }
}

struct ImageSparseRebindInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl ImageSparseRebindInstance<'_> {
    /// `getColorClearValue`
    fn get_color_clear_value(&self, memory_idx: usize) -> vk::ClearColorValue {
        let start_i = [7u32, 13];
        let start_u = [53u32, 61];
        let start_f = [1.0f32, 0.5];

        match map_vk_format(self.format).map(|format| format.channel_class()) {
            Some(TextureChannelClass::SignedInteger) => {
                let mut int32 = [0i32; 4];
                for (channel_ndx, value) in int32.iter_mut().enumerate() {
                    // `-1 * channelNdx % 2` is evaluated on an unsigned channel index upstream: 1 for odd channels, 0 for even ones.
                    let sign = (channel_ndx as u32).wrapping_mul(u32::MAX) % 2;
                    *value = start_i[memory_idx]
                        .wrapping_mul(channel_ndx as u32 + 1)
                        .wrapping_mul(sign) as i32;
                }
                vk::ClearColorValue { int32 }
            }
            Some(TextureChannelClass::UnsignedInteger) => {
                let mut uint32 = [0u32; 4];
                for (channel_ndx, value) in uint32.iter_mut().enumerate() {
                    *value = start_u[memory_idx] * (channel_ndx as u32 + 1);
                }
                vk::ClearColorValue { uint32 }
            }
            _ => {
                let mut float32 = [0.0f32; 4];
                for (channel_ndx, value) in float32.iter_mut().enumerate() {
                    *value = start_f[memory_idx] - 0.1 * channel_ndx as f32;
                }
                vk::ClearColorValue { float32 }
            }
        }
    }
}

impl TestInstance for ImageSparseRebindInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let epsilon = 1e-5f32;

        // Create logical device supporting both sparse and transfer queues
        let sparse_device = SparseDevice::new(
            context,
            &[
                QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
                QueueRequirements::new(vk::QueueFlags::TRANSFER, 1),
            ],
            false,
        )?;
        let device = sparse_device.device();

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let transfer_queue = sparse_device.get_queue(vk::QueueFlags::TRANSFER, 0);
        let format_description = format_description(self.format);
        let num_planes = format_description.planes.len();

        let layer_size = get_layer_size(self.image_type, self.image_size);
        let mut image_sparse_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY)
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
            if let Err(error) = result
                && error == vk::ErrorCode::FORMAT_NOT_SUPPORTED
            {
                return Err(TestError::NotSupported(
                    "Image format does not support sparse operations".to_string(),
                ));
            }
        }

        // Create sparse image
        let image = Unique::new(
            device,
            unsafe { device.create_image(&image_sparse_info, None) }.vk_check("vkCreateImage")?,
        );

        // Create semaphores to synchronize sparse binding operations with transfer operations on the sparse images
        let bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );
        let transfer_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        // Get sparse image general memory requirements
        let image_memory_requirements = unsafe { device.get_image_memory_requirements(*image) };

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
        let sparse_memory_requirements = unsafe { device.get_image_sparse_memory_requirements(*image) };
        assert!(!sparse_memory_requirements.is_empty());

        // Select only one layer to partial bind
        let partially_bound_layer = image_sparse_info.array_layers - 1;

        // Prepare the binding structures and calculate the memory size
        let mut allocation_size: vk::DeviceSize = 0;

        let mut image_full_binds: [Vec<vk::SparseImageMemoryBind>; MEMORY_OBJECT_COUNT] = [Vec::new(), Vec::new()];
        let mut image_partial_bind: Option<vk::SparseImageMemoryBind> = None;

        for plane_ndx in 0..num_planes {
            let aspect = if num_planes > 1 {
                plane_aspect(plane_ndx)
            } else {
                vk::ImageAspectFlags::COLOR
            };
            let aspect_index = get_sparse_aspect_requirements_index(&sparse_memory_requirements, aspect);

            if aspect_index == NO_MATCH_FOUND {
                return Err(TestError::NotSupported("Not supported image aspect".to_string()));
            }

            let aspect_requirements = sparse_memory_requirements[aspect_index as usize];

            let image_granularity = aspect_requirements.format_properties.image_granularity;
            let plane_extent = get_plane_extent(&format_description, image_sparse_info.extent, plane_ndx, 0);
            let sparse_blocks = aligned_divide(plane_extent, image_granularity);
            let num_sparse_blocks = sparse_blocks[0] * sparse_blocks[1] * sparse_blocks[2];

            if num_sparse_blocks < 2 {
                return Err(TestError::NotSupported(
                    "Image size is too small for partial binding".to_string(),
                ));
            }

            if aspect_requirements.image_mip_tail_first_lod == 0 {
                return Err(TestError::NotSupported(
                    "Image needs mip tail for mip level 0, partial binding is not possible".to_string(),
                ));
            }

            for layer_ndx in 0..image_sparse_info.array_layers {
                let subresource = vk::ImageSubresource {
                    aspect_mask: aspect,
                    mip_level: 0,
                    array_layer: layer_ndx,
                };

                let mut sparse_memory_offset = allocation_size;
                for sparse_block_index in 0..num_sparse_blocks {
                    let sparse_block_idz = sparse_block_index / (sparse_blocks[0] * sparse_blocks[1]);
                    let sparse_block_idy =
                        (sparse_block_index % (sparse_blocks[0] * sparse_blocks[1])) / sparse_blocks[0];
                    let sparse_block_idx = sparse_block_index % sparse_blocks[0];

                    let sparse_block_offset = vk::Offset3D {
                        x: (sparse_block_idx * image_granularity.width) as i32,
                        y: (sparse_block_idy * image_granularity.height) as i32,
                        z: (sparse_block_idz * image_granularity.depth) as i32,
                    };

                    let sparse_block_extent = vk::Extent3D {
                        width: image_granularity
                            .width
                            .min(plane_extent.width - sparse_block_offset.x as u32),
                        height: image_granularity
                            .height
                            .min(plane_extent.height - sparse_block_offset.y as u32),
                        depth: image_granularity
                            .depth
                            .min(plane_extent.depth - sparse_block_offset.z as u32),
                    };

                    // The memory will be patched in later.
                    let sparse_block_bind = vk::SparseImageMemoryBind {
                        subresource,
                        offset: sparse_block_offset,
                        extent: sparse_block_extent,
                        memory: vk::DeviceMemory::null(),
                        memory_offset: sparse_memory_offset,
                        flags: vk::SparseMemoryBindFlags::empty(),
                    };

                    for binds in image_full_binds.iter_mut() {
                        binds.push(sparse_block_bind);
                    }

                    sparse_memory_offset += image_memory_requirements.alignment;
                }

                // Partially bind only one layer
                if layer_ndx == partially_bound_layer {
                    // Offset by one block in every direction if possible
                    let mut partial_offset = vk::Offset3D { x: 0, y: 0, z: 0 };
                    let mut sparse_block_offset = [0u32; 3];
                    if sparse_blocks[0] > 1 {
                        partial_offset.x = image_granularity.width as i32;
                        sparse_block_offset[0] = 1;
                    }
                    if sparse_blocks[1] > 1 {
                        partial_offset.y = image_granularity.height as i32;
                        sparse_block_offset[1] = 1;
                    }
                    if sparse_blocks[2] > 1 {
                        partial_offset.z = image_granularity.depth as i32;
                        sparse_block_offset[2] = 1;
                    }

                    let partial_memory_offset = (sparse_blocks[0] * sparse_blocks[1] * sparse_block_offset[2]
                        + sparse_blocks[0] * sparse_block_offset[1]
                        + sparse_block_offset[0]) as vk::DeviceSize
                        * image_memory_requirements.alignment;

                    // Map only one block and clamp it to the image dimensions
                    let partial_extent = vk::Extent3D {
                        width: image_granularity
                            .width
                            .min(plane_extent.width - partial_offset.x as u32),
                        height: image_granularity
                            .height
                            .min(plane_extent.height - partial_offset.y as u32),
                        depth: image_granularity
                            .depth
                            .min(plane_extent.depth - partial_offset.z as u32),
                    };

                    // The memory will be patched in later.
                    image_partial_bind = Some(vk::SparseImageMemoryBind {
                        subresource,
                        offset: partial_offset,
                        extent: partial_extent,
                        memory: vk::DeviceMemory::null(),
                        memory_offset: partial_memory_offset,
                        flags: vk::SparseMemoryBindFlags::empty(),
                    });
                }

                allocation_size += image_memory_requirements.alignment * num_sparse_blocks as vk::DeviceSize;
            }
        }

        let mut image_partial_bind = image_partial_bind.expect("the partially bound layer is the last one");

        // Allocate device memory
        let mut device_memories: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();
        for _ in 0..MEMORY_OBJECT_COUNT {
            let alloc_info = vk::MemoryAllocateInfo::builder()
                .allocation_size(allocation_size)
                .memory_type_index(memory_type);
            device_memories.push(Unique::new(
                device,
                unsafe { device.allocate_memory(&alloc_info, None) }.vk_check("vkAllocateMemory")?,
            ));
        }

        // Patch-in the newly generated memory objects into the pre-created binding structures
        for (memory_idx, binds) in image_full_binds.iter_mut().enumerate() {
            for bind in binds.iter_mut() {
                bind.memory = *device_memories[memory_idx];
            }
        }

        image_partial_bind.memory = *device_memories[0];

        let command_pool = make_command_pool(device, transfer_queue.family_index)?;

        let wait_stage_bits = [vk::PipelineStageFlags::TRANSFER];

        // Fully bind the memory and fill it with a value
        for memory_idx in 0..MEMORY_OBJECT_COUNT {
            let wait_semaphores = [*transfer_semaphore];
            let signal_semaphores = [*bind_semaphore];

            let image_bind_info = [vk::SparseImageMemoryBindInfo::builder()
                .image(*image)
                .binds(&image_full_binds[memory_idx])
                .build()];

            let mut bind_sparse_info = vk::BindSparseInfo::builder().signal_semaphores(&signal_semaphores);
            if memory_idx != 0 {
                bind_sparse_info = bind_sparse_info.wait_semaphores(&wait_semaphores);
            }
            if !image_full_binds[memory_idx].is_empty() {
                bind_sparse_info = bind_sparse_info.image_binds(&image_bind_info);
            }

            // Submit sparse bind commands
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;

            let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, *command_buffer)?;

            // Clear everything
            for plane_ndx in 0..num_planes {
                let aspect = if num_planes > 1 {
                    plane_aspect(plane_ndx)
                } else {
                    vk::ImageAspectFlags::COLOR
                };

                let range =
                    make_image_subresource_range(aspect, 0, vk::REMAINING_MIP_LEVELS, 0, vk::REMAINING_ARRAY_LAYERS);

                let image_memory_barrier_before = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    *image,
                    range,
                );

                unsafe {
                    device.cmd_pipeline_barrier(
                        *command_buffer,
                        vk::PipelineStageFlags::ALL_COMMANDS,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[image_memory_barrier_before],
                    );
                }
                let clear_value = self.get_color_clear_value(memory_idx);
                unsafe {
                    device.cmd_clear_color_image(
                        *command_buffer,
                        *image,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_value,
                        &[range],
                    )
                };

                let image_memory_barrier_after = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    *image,
                    range,
                );

                unsafe {
                    device.cmd_pipeline_barrier(
                        *command_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[image_memory_barrier_after],
                    );
                }
            }

            end_command_buffer(device, *command_buffer)?;

            // Wait for the sparse bind operation semaphore, submit and wait on host for the transfer stage.
            submit_commands_and_wait(
                device,
                transfer_queue.handle,
                *command_buffer,
                &[*bind_semaphore],
                &wait_stage_bits,
                &[*transfer_semaphore],
            )?;
        }

        // Partially bind memory 1 back to the image
        {
            let wait_semaphores = [*transfer_semaphore];
            let signal_semaphores = [*bind_semaphore];
            let partial_binds = [image_partial_bind];
            let image_bind_info = [vk::SparseImageMemoryBindInfo::builder()
                .image(*image)
                .binds(&partial_binds)
                .build()];

            let bind_sparse_info = vk::BindSparseInfo::builder()
                .wait_semaphores(&wait_semaphores)
                .image_binds(&image_bind_info)
                .signal_semaphores(&signal_semaphores);

            // Submit sparse bind commands for execution
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
        }

        // Verify the results
        // Create a big buffer ...
        let mut buffer_size = 0u32;
        let mut buffer_offsets = Vec::with_capacity(num_planes);

        for plane_ndx in 0..num_planes {
            buffer_offsets.push(buffer_size);
            buffer_size += get_image_mip_level_size_in_bytes(
                image_sparse_info.extent,
                1,
                self.format,
                plane_ndx,
                0,
                BUFFER_IMAGE_COPY_OFFSET_GRANULARITY,
            );
        }

        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut buffer_image_copy = Vec::with_capacity(num_planes);
        for plane_ndx in 0..num_planes {
            let aspect = if num_planes > 1 {
                plane_aspect(plane_ndx)
            } else {
                vk::ImageAspectFlags::COLOR
            };

            buffer_image_copy.push(vk::BufferImageCopy {
                buffer_offset: buffer_offsets[plane_ndx] as vk::DeviceSize,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(aspect, 0, partially_bound_layer, 1),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: get_plane_extent(&format_description, image_sparse_info.extent, plane_ndx, 0),
            });
        }

        //... and copy selected layer into it
        {
            let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, *command_buffer)?;

            unsafe {
                device.cmd_copy_image_to_buffer(
                    *command_buffer,
                    *image,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    output_buffer.get(),
                    &buffer_image_copy,
                )
            };

            // Make the changes visible to the host
            {
                let output_buffer_host_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    output_buffer.get(),
                    0,
                    buffer_size as vk::DeviceSize,
                );

                unsafe {
                    device.cmd_pipeline_barrier(
                        *command_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[output_buffer_host_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }

            end_command_buffer(device, *command_buffer)?;

            // Wait for the sparse bind operations, submit and wait on host for the transfer stage.
            submit_commands_and_wait(
                device,
                transfer_queue.handle,
                *command_buffer,
                &[*bind_semaphore],
                &wait_stage_bits,
                &[],
            )?;
        }

        // Retrieve data from output buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;

        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                buffer_size as usize,
            )
        };

        // Only the single-plane formats reach here.
        let tcu_format = map_vk_format(self.format)
            .ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", self.format)))?;
        let extent = get_plane_extent(&format_description, image_sparse_info.extent, 0, 0);
        let pixel_buffer = ConstPixelBufferAccess::new(
            tcu_format,
            [extent.width, extent.height, extent.depth],
            &output_data[buffer_offsets[0] as usize..],
        );

        let partial_bind_offset = image_partial_bind.offset;
        let partial_bind_extent = image_partial_bind.extent;

        let clear_value0 = self.get_color_clear_value(0);
        let clear_value_last = self.get_color_clear_value(MEMORY_OBJECT_COUNT - 1);
        let channel_class = tcu_format.channel_class();

        for channel_ndx in 0..tcu_format.order.num_used_channels() as usize {
            for offset_z in 0..extent.depth {
                for offset_y in 0..extent.height {
                    for offset_x in 0..extent.width {
                        let mut acceptable_error = epsilon;

                        let inside_partial_bind = offset_x >= partial_bind_offset.x as u32
                            && offset_x < partial_bind_offset.x as u32 + partial_bind_extent.width
                            && offset_y >= partial_bind_offset.y as u32
                            && offset_y < partial_bind_offset.y as u32 + partial_bind_extent.height
                            && offset_z >= partial_bind_offset.z as u32
                            && offset_z < partial_bind_offset.z as u32 + partial_bind_extent.depth;
                        let reference = if inside_partial_bind {
                            &clear_value0
                        } else {
                            &clear_value_last
                        };

                        // The reference of every channel class is read from the matching view of the clear colour.
                        let (f_reference_value, u_reference_value, i_reference_value) = unsafe {
                            (
                                reference.float32[channel_ndx],
                                reference.uint32[channel_ndx],
                                reference.int32[channel_ndx],
                            )
                        };

                        match channel_class {
                            TextureChannelClass::SignedInteger => {
                                let output_value = pixel_buffer.get_pixel_int(offset_x, offset_y, offset_z);

                                if output_value[channel_ndx] != i_reference_value {
                                    return Ok(TestStatus::fail("Failed"));
                                }
                            }
                            TextureChannelClass::UnsignedInteger => {
                                let output_value = pixel_buffer.get_pixel_uint(offset_x, offset_y, offset_z);

                                if output_value[channel_ndx] != u_reference_value {
                                    return Ok(TestStatus::fail("Failed"));
                                }
                            }
                            TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint => {
                                let mut num_accurate_bits =
                                    tcu_format.type_.channel_size().map_or(32, |size| size as i32 * 8);
                                if channel_class == TextureChannelClass::SignedFixedPoint {
                                    num_accurate_bits -= 1;
                                }
                                acceptable_error += compute_fixed_point_error(num_accurate_bits);
                                let output_value = pixel_buffer.get_pixel(offset_x, offset_y, offset_z);

                                if (output_value[channel_ndx] - f_reference_value).abs() > acceptable_error {
                                    return Ok(TestStatus::fail("Failed"));
                                }
                            }
                            TextureChannelClass::FloatingPoint => {
                                let output_value = pixel_buffer.get_pixel(offset_x, offset_y, offset_z);

                                if (output_value[channel_ndx] - f_reference_value).abs() > acceptable_error {
                                    return Ok(TestStatus::fail("Failed"));
                                }
                            }
                            TextureChannelClass::Last => {
                                return Err(TestError::InternalError("Unexpected channel type".to_string()));
                            }
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `createImageSparseRebindTests`
pub fn create_image_sparse_rebind_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("image_rebind");

    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1], [128, 128, 1], [503, 137, 1]],
            get_test_formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6], [128, 128, 8], [503, 137, 3]],
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
            vec![[256, 256, 16], [128, 128, 8], [503, 137, 3]],
            get_test_formats(ImageType::ThreeD),
        ),
    ];

    for parameters in &image_parameters {
        let image_type = parameters.image_type;
        let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_type));

        for &format in &parameters.formats {
            // skip YCbCr formats for simplicity
            if is_ycbcr_format(format) {
                continue;
            }

            let mut format_group = TestCaseGroup::new(get_image_format_id(format));

            for &image_size in &parameters.image_sizes {
                let name = format!("{}_{}_{}", image_size[0], image_size[1], image_size[2]);

                format_group.add_child(Box::new(ImageSparseRebindCase {
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

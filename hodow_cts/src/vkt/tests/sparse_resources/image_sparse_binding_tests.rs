// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageSparseBinding.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device group variant (`device_group_image_sparse_binding`) is not ported, so
// the loop over physical devices runs once.
//
// Binds a fully sparse-bound (not residency) image in one of three ways, writes a reference pattern through a buffer copy and reads
// it back.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    BUFFER_IMAGE_COPY_OFFSET_GRANULARITY, ImageType, NO_MATCH_FOUND, TestImageParameters, are_lsb4_bits_dont_care,
    are_lsb6_bits_dont_care, find_matching_memory_type, format_is_r64, get_image_format_id,
    get_image_mip_level_size_in_bytes, get_image_size_alignment, get_image_type_name, get_layer_size, get_mipmap_count,
    get_num_layers, get_plane_extent, get_test_formats, is_image_size_supported, make_sparse_memory_bind,
    map_image_type, submit_commands_and_wait,
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

#[derive(Clone, Copy, PartialEq, Eq)]
enum BindType {
    MultipleSparseMemoryBind,
    MultipleSparseImageOpaqueMemoryBindInfo,
    MultipleBindSparseInfo,
}

impl BindType {
    /// `toString`
    fn name(self) -> &'static str {
        match self {
            BindType::MultipleSparseMemoryBind => "multiple_sparse_memory_bind",
            BindType::MultipleSparseImageOpaqueMemoryBindInfo => "multiple_sparse_image_opaque_memory_bind_info",
            BindType::MultipleBindSparseInfo => "multiple_bind_sparse_info",
        }
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
    bind_type: BindType,
}

struct ImageSparseBindingCase {
    name: String,
    params: TestParams,
}

impl TestCase for ImageSparseBindingCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
        }

        if self.params.format == vk::Format::A8_UNORM {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if !is_image_size_supported(
            context.get_instance(),
            context.get_physical_device(),
            self.params.image_type,
            self.params.image_size,
        ) {
            return Err(TestError::NotSupported(
                "Image size not supported for device".to_string(),
            ));
        }

        if format_is_r64(self.params.format) {
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
        Box::new(ImageSparseBindingInstance {
            context,
            params: self.params,
        })
    }
}

struct ImageSparseBindingInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for ImageSparseBindingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;

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
        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);
        let format_description = format_description(params.format);
        let num_planes = format_description.planes.len() as u32;

        let layer_size = get_layer_size(params.image_type, params.image_size);
        let mut image_sparse_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::SPARSE_BINDING)
            .image_type(map_image_type(params.image_type))
            .format(params.format)
            .extent(vk::Extent3D {
                width: layer_size[0],
                height: layer_size[1],
                depth: layer_size[2],
            })
            .array_layers(get_num_layers(params.image_type, params.image_size))
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();

        if params.image_type == ImageType::Cube || params.image_type == ImageType::CubeArray {
            image_sparse_info.flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
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
                    return Err(TestError::NotSupported(format!(
                        "Image format {:?} does not support sparse binding operations",
                        image_sparse_info.format
                    )));
                }
                Ok(image_format_properties) => {
                    image_sparse_info.mip_levels =
                        get_mipmap_count(params.format, &image_format_properties, image_sparse_info.extent);
                }
                Err(_) => image_sparse_info.mip_levels = 1,
            }
        }

        // Create sparse image
        let image_sparse = Unique::new(
            device,
            unsafe { device.create_image(&image_sparse_info, None) }.vk_check("vkCreateImage")?,
        );

        let image_sparse_bind_fence = Unique::new(
            device,
            unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
        );

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

        // The bound memory has to outlive the image's use.
        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();
        let mut sparse_memory_binds: Vec<vk::SparseMemoryBind> = Vec::new();
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

        match params.bind_type {
            BindType::MultipleSparseMemoryBind => {
                let opaque_bind_info = [vk::SparseImageOpaqueMemoryBindInfo::builder()
                    .image(*image_sparse)
                    .binds(&sparse_memory_binds)
                    .build()];
                let bind_sparse_info = vk::BindSparseInfo::builder().image_opaque_binds(&opaque_bind_info);

                // Submit sparse bind commands for execution
                unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], *image_sparse_bind_fence) }
                    .vk_check("vkQueueBindSparse")?;
            }
            BindType::MultipleSparseImageOpaqueMemoryBindInfo => {
                let opaque_bind_infos: Vec<vk::SparseImageOpaqueMemoryBindInfo> = (0..num_sparse_binds as usize)
                    .map(|index| {
                        vk::SparseImageOpaqueMemoryBindInfo::builder()
                            .image(*image_sparse)
                            .binds(&sparse_memory_binds[index..index + 1])
                            .build()
                    })
                    .collect();
                let bind_sparse_info = vk::BindSparseInfo::builder().image_opaque_binds(&opaque_bind_infos);

                // Submit sparse bind commands for execution
                unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], *image_sparse_bind_fence) }
                    .vk_check("vkQueueBindSparse")?;
            }
            BindType::MultipleBindSparseInfo => {
                let opaque_bind_infos: Vec<vk::SparseImageOpaqueMemoryBindInfo> = (0..num_sparse_binds as usize)
                    .map(|index| {
                        vk::SparseImageOpaqueMemoryBindInfo::builder()
                            .image(*image_sparse)
                            .binds(&sparse_memory_binds[index..index + 1])
                            .build()
                    })
                    .collect();
                let bind_sparse_infos: Vec<vk::BindSparseInfoBuilder<'_>> = (0..num_sparse_binds as usize)
                    .map(|index| vk::BindSparseInfo::builder().image_opaque_binds(&opaque_bind_infos[index..index + 1]))
                    .collect();

                // Submit sparse bind commands for execution
                unsafe { device.queue_bind_sparse(sparse_queue.handle, &bind_sparse_infos, *image_sparse_bind_fence) }
                    .vk_check("vkQueueBindSparse")?;
            }
        }

        // Waiting for resources to be bound
        unsafe { device.wait_for_fences(&[*image_sparse_bind_fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

        let mut image_size_in_bytes = 0u32;
        for plane_ndx in 0..num_planes as usize {
            for mipmap_ndx in 0..image_sparse_info.mip_levels {
                image_size_in_bytes += get_image_mip_level_size_in_bytes(
                    image_sparse_info.extent,
                    image_sparse_info.array_layers,
                    params.format,
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

        let mut buffer_image_copy = Vec::with_capacity((num_planes * image_sparse_info.mip_levels) as usize);
        {
            let mut buffer_offset = 0u32;
            for plane_ndx in 0..num_planes as usize {
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
                        params.format,
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
            let image_sparse_transfer_dst_barriers: Vec<vk::ImageMemoryBarrier> = (0..num_planes as usize)
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
            let image_sparse_transfer_src_barriers: Vec<vk::ImageMemoryBarrier> = (0..num_planes as usize)
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

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(device, compute_queue.handle, *command_buffer, &[], &[], &[])?;

        // Retrieve data from buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;

        // Wait for sparse queue to become idle
        unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                image_size_in_bytes as usize,
            )
        };
        let ignore_lsb6_bits = are_lsb6_bits_dont_care(image_sparse_info.format);
        let ignore_lsb4_bits = are_lsb4_bits_dont_care(image_sparse_info.format);

        for plane_ndx in 0..num_planes as usize {
            for mipmap_ndx in 0..image_sparse_info.mip_levels {
                let mip_level_size_in_bytes = get_image_mip_level_size_in_bytes(
                    image_sparse_info.extent,
                    image_sparse_info.array_layers,
                    params.format,
                    plane_ndx,
                    mipmap_ndx,
                    1,
                );
                let buffer_offset = buffer_image_copy
                    [plane_ndx * image_sparse_info.mip_levels as usize + mipmap_ndx as usize]
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

        // Keep the bound memory alive until here.
        drop(device_memory);

        Ok(TestStatus::pass("Passed"))
    }
}

/// `getSparseBindingTestFormats`
fn get_sparse_binding_test_formats(image_type: ImageType) -> Vec<vk::Format> {
    let mut formats = get_test_formats(image_type);

    // 256-bit (64-bit-per-component) formats are usually buffer-only, but the spec does not forbid
    // image support; exercise sparse binding where the driver advertises it (skipped otherwise).
    formats.push(vk::Format::R64G64B64A64_UINT);
    formats.push(vk::Format::R64G64B64A64_SINT);

    formats.push(vk::Format::A8_UNORM);
    formats
}

/// `createImageSparseBindingTests`
pub fn create_image_sparse_binding_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("image_sparse_binding");

    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::OneD,
            vec![[512, 1, 1], [1024, 1, 1], [11, 1, 1]],
            get_sparse_binding_test_formats(ImageType::OneD),
        ),
        TestImageParameters::new(
            ImageType::OneDArray,
            vec![[512, 1, 64], [1024, 1, 8], [11, 1, 3]],
            get_sparse_binding_test_formats(ImageType::OneDArray),
        ),
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1], [1024, 128, 1], [11, 137, 1]],
            get_sparse_binding_test_formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6], [1024, 128, 8], [11, 137, 3]],
            get_sparse_binding_test_formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[512, 256, 6], [1024, 128, 8], [11, 137, 3]],
            get_sparse_binding_test_formats(ImageType::ThreeD),
        ),
        TestImageParameters::new(
            ImageType::Cube,
            vec![[256, 256, 1], [128, 128, 1], [137, 137, 1]],
            get_sparse_binding_test_formats(ImageType::Cube),
        ),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6], [128, 128, 8], [137, 137, 3]],
            get_sparse_binding_test_formats(ImageType::CubeArray),
        ),
    ];

    let bind_types = [
        BindType::MultipleSparseMemoryBind,
        BindType::MultipleSparseImageOpaqueMemoryBindInfo,
        BindType::MultipleBindSparseInfo,
    ];

    for bind_type in bind_types {
        let mut bind_type_group = TestCaseGroup::new(bind_type.name());

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
                    format_group.add_child(Box::new(ImageSparseBindingCase {
                        name,
                        params: TestParams {
                            image_type,
                            image_size,
                            format,
                            bind_type,
                        },
                    }) as Box<dyn TestCase>);
                }
                image_type_group.add_child(format_group);
            }
            bind_type_group.add_child(image_type_group);
        }
        test_group.add_child(bind_type_group);
    }

    test_group
}

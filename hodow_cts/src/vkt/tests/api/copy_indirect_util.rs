// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkImageUtil.cpp   (copyBufferToImageIndirect)
//   external/vulkancts/modules/vulkan/api/vktApiCopyImageToBufferTests.cpp   (the INDIRECT_COPY branch of checkSupport)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `vkCmdCopyMemoryToImageIndirectKHR` driven the way `vk::copyBufferToImageIndirect` does: the `VkBufferImageCopy` regions become
// `VkCopyMemoryToImageIndirectCommandKHR` entries (source address plus the region's buffer offset) in a device-addressed buffer.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1, KhrCopyMemoryIndirectExtensionDeviceCommands};

use super::copies_buffer_tests::QueueSelection;
use crate::tcu::TestError;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
};
use crate::vkt::Context;

/// The part of `CopyImageToBufferTestCase::checkSupport` that applies when `INDIRECT_COPY` is set, after `checkExtensionSupport`.
pub fn check_indirect_copy_support(
    context: &Context<'_>,
    format: vk::Format,
    tiling: vk::ImageTiling,
    queue_selection: QueueSelection,
) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_copy_memory_indirect")?;
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut indirect_features = vk::PhysicalDeviceCopyMemoryIndirectFeaturesKHR::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indirect_features);
        unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
    }
    if indirect_features.indirect_memory_to_image_copy == vk::FALSE {
        return Err(TestError::NotSupported(
            "Indirect memory copy to image feature not supported".to_string(),
        ));
    }

    let mut format_properties3 = vk::FormatProperties3::default();
    {
        let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut format_properties3);
        unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties2) };
    }
    let features = if tiling == vk::ImageTiling::LINEAR {
        format_properties3.linear_tiling_features
    } else {
        format_properties3.optimal_tiling_features
    };
    if !features.contains(vk::FormatFeatureFlags2::COPY_IMAGE_INDIRECT_DST_KHR) {
        return Err(TestError::NotSupported(
            "Format feature is not supported on this format".to_string(),
        ));
    }

    let mut copy_memory_indirect_properties = vk::PhysicalDeviceCopyMemoryIndirectPropertiesKHR::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut copy_memory_indirect_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
    }
    let (needed, name) = match queue_selection {
        QueueSelection::Universal => (vk::QueueFlags::GRAPHICS, "Graphics"),
        QueueSelection::TransferOnly => (vk::QueueFlags::TRANSFER, "Transfer"),
        QueueSelection::ComputeOnly => (vk::QueueFlags::COMPUTE, "Compute"),
    };
    if !copy_memory_indirect_properties.supported_queues.contains(needed) {
        return Err(TestError::NotSupported(format!("{name} queue not supported!")));
    }
    Ok(())
}

/// What `vk::copyBufferToImageIndirect` is given besides the device and queue.
pub struct IndirectUpload<'a> {
    pub buffer: vk::Buffer,
    pub buffer_size: vk::DeviceSize,
    pub regions: &'a [vk::BufferImageCopy],
    pub aspect: vk::ImageAspectFlags,
    pub mip_levels: u32,
    pub array_layers: u32,
    pub image: vk::Image,
    pub dest_layout: vk::ImageLayout,
    pub dest_stage: vk::PipelineStageFlags,
    pub dest_access: vk::AccessFlags,
}

/// `copyBufferToImageIndirect` with a local command pool and `baseMipLevel` 0. The source buffer needs `SHADER_DEVICE_ADDRESS` usage.
pub fn copy_buffer_to_image_indirect(
    context: &Context<'_>,
    queue: vk::Queue,
    queue_family_index: u32,
    upload: &IndirectUpload<'_>,
) -> Result<(), TestError> {
    let device = context.get_device();
    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *cmd_buffer)?;

    let buffer_address = |buffer: vk::Buffer| {
        let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer);
        unsafe { device.get_buffer_device_address(&info) }
    };
    let source_address = buffer_address(upload.buffer);

    let commands: Vec<vk::CopyMemoryToImageIndirectCommandKHR> = upload
        .regions
        .iter()
        .map(|region| vk::CopyMemoryToImageIndirectCommandKHR {
            src_address: source_address + region.buffer_offset,
            buffer_row_length: region.buffer_row_length,
            buffer_image_height: region.buffer_image_height,
            image_subresource: region.image_subresource,
            image_offset: region.image_offset,
            image_extent: region.image_extent,
        })
        .collect();
    let indirect_size = std::mem::size_of_val(commands.as_slice()) as vk::DeviceSize;
    let indirect_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            indirect_size,
            vk::BufferUsageFlags::TRANSFER_SRC
                | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
                | vk::BufferUsageFlags::INDIRECT_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            commands.as_ptr().cast::<u8>(),
            indirect_buffer.get_allocation().get_host_ptr(),
            indirect_size as usize,
        )
    };
    flush_alloc(device, indirect_buffer.get_allocation())?;
    let indirect_address = buffer_address(indirect_buffer.get());

    let subresources: Vec<vk::ImageSubresourceLayers> =
        upload.regions.iter().map(|region| region.image_subresource).collect();
    let range = make_image_subresource_range(upload.aspect, 0, upload.mip_levels, 0, upload.array_layers);
    let buffer_barriers = [
        make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            upload.buffer,
            0,
            upload.buffer_size,
        ),
        make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            indirect_buffer.get(),
            0,
            indirect_size,
        ),
    ];
    let pre_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        upload.image,
        range,
    );
    let post_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        upload.dest_access,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        upload.dest_layout,
        upload.image,
        range,
    );

    let info = vk::CopyMemoryToImageIndirectInfoKHR {
        src_copy_flags: vk::AddressCopyFlagsKHR::DEVICE_LOCAL,
        copy_count: upload.regions.len() as u32,
        copy_address_range: vk::StridedDeviceAddressRangeKHR {
            address: indirect_address,
            size: indirect_size,
            stride: std::mem::size_of::<vk::CopyMemoryToImageIndirectCommandKHR>() as vk::DeviceSize,
        },
        dst_image: upload.image,
        dst_image_layout: vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image_subresources: subresources.as_ptr(),
        ..Default::default()
    };
    unsafe {
        device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &buffer_barriers,
            &[pre_image_barrier],
        );
        device.cmd_copy_memory_to_image_indirect_khr(*cmd_buffer, &info);
        device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            upload.dest_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_image_barrier],
        );
    }
    end_command_buffer(device, *cmd_buffer)?;
    submit_commands_and_wait(device, queue, *cmd_buffer)
}

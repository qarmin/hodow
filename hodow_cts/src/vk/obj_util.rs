// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkObjUtil.hpp / .cpp
//   external/vulkancts/framework/vulkan/vkBarrierUtil.hpp / .cpp
//   external/vulkancts/framework/vulkan/vkBufferWithMemory.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};

/// `vk::makeBufferCreateInfo`
pub fn make_buffer_create_info(size: vk::DeviceSize, usage: vk::BufferUsageFlags) -> vk::BufferCreateInfo {
    vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::BufferCreateFlags::empty(),
        size,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
    }
}

/// `vk::makeDescriptorBufferInfo`
pub fn make_descriptor_buffer_info(buffer: vk::Buffer, offset: vk::DeviceSize, range: vk::DeviceSize) -> vk::DescriptorBufferInfo {
    vk::DescriptorBufferInfo { buffer, offset, range }
}

/// `vk::makeMemoryBarrier`
pub fn make_memory_barrier(src_access_mask: vk::AccessFlags, dst_access_mask: vk::AccessFlags) -> vk::MemoryBarrier {
    vk::MemoryBarrier {
        s_type: vk::StructureType::MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask,
        dst_access_mask,
    }
}

/// `vk::makeBufferMemoryBarrier`
pub fn make_buffer_memory_barrier(
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    buffer: vk::Buffer,
    offset: vk::DeviceSize,
    size: vk::DeviceSize,
) -> vk::BufferMemoryBarrier {
    vk::BufferMemoryBarrier {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask,
        dst_access_mask,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset,
        size,
    }
}

/// `vk::makeCommandPool`
pub fn make_command_pool(device: &Device, queue_family_index: u32) -> Result<Unique<'_, vk::CommandPool>, TestError> {
    let info = vk::CommandPoolCreateInfo::builder()
        .flags(vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)
        .queue_family_index(queue_family_index);
    let pool = unsafe { device.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?;
    Ok(Unique::new(device, pool))
}

/// `vk::allocateCommandBuffer`
pub fn allocate_command_buffer(device: &Device, pool: vk::CommandPool, level: vk::CommandBufferLevel) -> Result<UniqueCommandBuffer<'_>, TestError> {
    let info = vk::CommandBufferAllocateInfo::builder().command_pool(pool).level(level).command_buffer_count(1);
    let buffers = unsafe { device.allocate_command_buffers(&info) }.vk_check("vkAllocateCommandBuffers")?;
    Ok(UniqueCommandBuffer::new(device, pool, buffers[0]))
}

/// `vk::makeDescriptorSet`
pub fn make_descriptor_set<'a>(device: &'a Device, pool: vk::DescriptorPool, layout: vk::DescriptorSetLayout) -> Result<UniqueDescriptorSet<'a>, TestError> {
    let layouts = [layout];
    let info = vk::DescriptorSetAllocateInfo::builder().descriptor_pool(pool).set_layouts(&layouts);
    let sets = unsafe { device.allocate_descriptor_sets(&info) }.vk_check("vkAllocateDescriptorSets")?;
    Ok(UniqueDescriptorSet::new(device, pool, sets[0]))
}

/// `vk::makeFramebuffer`
pub fn make_framebuffer<'a>(
    device: &'a Device,
    render_pass: vk::RenderPass,
    attachments: &[vk::ImageView],
    width: u32,
    height: u32,
    layers: u32,
) -> Result<Unique<'a, vk::Framebuffer>, TestError> {
    let info = vk::FramebufferCreateInfo::builder()
        .render_pass(render_pass)
        .attachments(attachments)
        .width(width)
        .height(height)
        .layers(layers);
    let framebuffer = unsafe { device.create_framebuffer(&info, None) }.vk_check("vkCreateFramebuffer")?;
    Ok(Unique::new(device, framebuffer))
}

/// `vk::BufferWithMemory` - a buffer plus the allocation backing it, bound together.
pub struct BufferWithMemory<'a> {
    buffer: Unique<'a, vk::Buffer>,
    allocation: Allocation<'a>,
}

impl<'a> BufferWithMemory<'a> {
    pub fn new(device: &'a Device, allocator: &SimpleAllocator, buffer_create_info: vk::BufferCreateInfo, requirement: MemoryRequirement) -> Result<Self, TestError> {
        let buffer = unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?;
        let buffer = Unique::new(device, buffer);

        let req = unsafe { device.get_buffer_memory_requirements(*buffer) };
        let allocation = allocator.allocate(device, req, requirement)?;

        unsafe { device.bind_buffer_memory(*buffer, allocation.get_memory(), allocation.get_offset()) }.vk_check("vkBindBufferMemory")?;

        Ok(Self { buffer, allocation })
    }

    pub fn get(&self) -> vk::Buffer {
        *self.buffer
    }

    /// `BufferWithMemory::getAllocation`
    pub fn get_allocation(&self) -> &Allocation<'a> {
        &self.allocation
    }
}

impl std::ops::Deref for BufferWithMemory<'_> {
    type Target = vk::Buffer;

    fn deref(&self) -> &vk::Buffer {
        &self.buffer
    }
}

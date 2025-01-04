// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalRenderingTestUtil.cpp
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalRenderingTestUtil.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtConditionalRenderingExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{Allocation, MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::ref_util::Unique;
use crate::vkt::Context;

/// `ConditionalBufferMemory`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ConditionalBufferMemory {
    Local,
    Host,
}

/// `ConditionalData`
#[derive(Clone, Copy)]
pub struct ConditionalData {
    pub condition_in_primary_command_buffer: bool,
    pub condition_in_secondary_command_buffer: bool,
    pub condition_inverted: bool,
    pub condition_inherited: bool,
    pub condition_value: u32,
    pub pad_condition_value: bool,
    pub allocation_offset: bool,
    pub clear_in_render_pass: bool,
    pub secondary_command_buffer_nested: bool,
    pub expect_command_execution: bool,
    pub memory_type: ConditionalBufferMemory,
}

impl ConditionalData {
    pub const fn none() -> Self {
        Self {
            condition_in_primary_command_buffer: false,
            condition_in_secondary_command_buffer: false,
            condition_inverted: false,
            condition_inherited: false,
            condition_value: 0,
            pad_condition_value: false,
            allocation_offset: false,
            clear_in_render_pass: false,
            secondary_command_buffer_nested: false,
            expect_command_execution: false,
            memory_type: ConditionalBufferMemory::Local,
        }
    }

    /// `operator<<(std::ostream &, ConditionalData const &)`
    #[allow(clippy::wrong_self_convention)]
    pub fn to_name(&self) -> String {
        let condition_enabled = self.condition_in_primary_command_buffer || self.condition_in_secondary_command_buffer;
        let mut s = String::new();
        s.push_str(if condition_enabled { "condition" } else { "no_condition" });
        s.push_str(if self.memory_type == ConditionalBufferMemory::Host {
            "_host_memory"
        } else {
            "_local_memory"
        });

        if self.condition_in_secondary_command_buffer || !condition_enabled {
            s.push_str(if self.secondary_command_buffer_nested {
                "_nested_buffer"
            } else {
                "_secondary_buffer"
            });
        }

        if self.condition_inherited {
            s.push_str(if self.secondary_command_buffer_nested {
                "_nested_inherited"
            } else {
                "_inherited"
            });
        }

        s.push_str(if self.expect_command_execution {
            "_expect_execution"
        } else {
            "_expect_noop"
        });

        if self.condition_inverted {
            s.push_str("_inverted");
        }
        if self.pad_condition_value {
            s.push_str("_padded");
        }
        if self.clear_in_render_pass {
            s.push_str("_rp_clear");
        }
        s
    }
}

const fn row(
    primary: bool,
    secondary: bool,
    inverted: bool,
    inherited: bool,
    value: u32,
    nested: bool,
    expect_execution: bool,
    memory_type: ConditionalBufferMemory,
) -> ConditionalData {
    ConditionalData {
        condition_in_primary_command_buffer: primary,
        condition_in_secondary_command_buffer: secondary,
        condition_inverted: inverted,
        condition_inherited: inherited,
        condition_value: value,
        pad_condition_value: false,
        allocation_offset: false,
        clear_in_render_pass: false,
        secondary_command_buffer_nested: nested,
        expect_command_execution: expect_execution,
        memory_type,
    }
}

const fn rp_clear(mut data: ConditionalData) -> ConditionalData {
    data.clear_in_render_pass = true;
    data
}

use ConditionalBufferMemory::{Host as HOST, Local as LOCAL};

/// `s_testsData`
pub static TESTS_DATA: [ConditionalData; 64] = [
    row(true, false, false, false, 1, false, true, HOST),
    row(true, false, false, false, 0, false, false, HOST),
    row(true, false, true, false, 0, false, true, HOST),
    row(true, false, true, false, 1, false, false, HOST),
    row(true, false, false, true, 1, false, true, HOST),
    row(true, false, false, true, 0, false, false, HOST),
    row(true, false, true, true, 0, false, true, HOST),
    row(true, false, true, true, 1, false, false, HOST),
    row(true, false, false, false, 1, false, true, LOCAL),
    row(true, false, false, false, 0, false, false, LOCAL),
    row(true, false, true, false, 0, false, true, LOCAL),
    row(true, false, true, false, 1, false, false, LOCAL),
    row(true, false, false, true, 1, false, true, LOCAL),
    row(true, false, false, true, 0, false, false, LOCAL),
    row(true, false, true, true, 0, false, true, LOCAL),
    row(true, false, true, true, 1, false, false, LOCAL),
    row(false, true, false, false, 1, false, true, HOST),
    row(false, true, false, false, 0, false, false, HOST),
    row(false, true, true, false, 0, false, true, HOST),
    row(false, true, true, false, 1, false, false, HOST),
    row(false, true, false, false, 1, false, true, LOCAL),
    row(false, true, false, false, 0, false, false, LOCAL),
    row(false, true, true, false, 0, false, true, LOCAL),
    row(false, true, true, false, 1, false, false, LOCAL),
    // Inheritance does not affect the outcome of a secondary command buffer, conditional or not.
    row(false, false, false, true, 0, false, true, HOST),
    row(false, false, false, true, 0, false, true, LOCAL),
    row(false, true, false, true, 1, false, true, HOST),
    row(false, true, false, true, 0, false, false, HOST),
    row(false, true, true, true, 1, false, false, HOST),
    row(false, true, true, true, 0, false, true, HOST),
    row(false, true, false, true, 1, false, true, LOCAL),
    row(false, true, false, true, 0, false, false, LOCAL),
    row(false, true, true, true, 1, false, false, LOCAL),
    row(false, true, true, true, 0, false, true, LOCAL),
    // Clearing the attachment when beginning the render pass.
    rp_clear(row(true, false, false, false, 1, true, true, HOST)),
    rp_clear(row(true, false, false, false, 0, true, false, HOST)),
    rp_clear(row(true, false, true, false, 0, true, true, HOST)),
    rp_clear(row(true, false, true, false, 1, true, false, HOST)),
    // Secondary buffers with nesting.
    row(true, false, false, true, 1, true, true, HOST),
    row(true, false, false, true, 0, true, false, HOST),
    row(true, false, true, true, 0, true, true, HOST),
    row(true, false, true, true, 1, true, false, HOST),
    row(true, false, false, true, 1, true, true, LOCAL),
    row(true, false, false, true, 0, true, false, LOCAL),
    row(true, false, true, true, 0, true, true, LOCAL),
    row(true, false, true, true, 1, true, false, LOCAL),
    row(false, true, false, false, 1, true, true, HOST),
    row(false, true, false, false, 0, true, false, HOST),
    row(false, true, true, false, 0, true, true, HOST),
    row(false, true, true, false, 1, true, false, HOST),
    row(false, true, false, false, 1, true, true, LOCAL),
    row(false, true, false, false, 0, true, false, LOCAL),
    row(false, true, true, false, 0, true, true, LOCAL),
    row(false, true, true, false, 1, true, false, LOCAL),
    row(false, false, false, true, 0, true, true, HOST),
    row(false, false, false, true, 0, true, true, LOCAL),
    row(false, true, false, true, 1, true, true, HOST),
    row(false, true, false, true, 0, true, false, HOST),
    row(false, true, true, true, 1, true, false, HOST),
    row(false, true, true, true, 0, true, true, HOST),
    row(false, true, false, true, 1, true, true, LOCAL),
    row(false, true, false, true, 0, true, false, LOCAL),
    row(false, true, true, true, 1, true, false, LOCAL),
    row(false, true, true, true, 0, true, true, LOCAL),
];

/// `checkConditionalRenderingCapabilities`
pub fn check_conditional_rendering_capabilities(
    context: &Context<'_>,
    data: &ConditionalData,
) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_conditional_rendering")?;

    let mut conditional_features = vk::PhysicalDeviceConditionalRenderingFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut conditional_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    if conditional_features.conditional_rendering == vk::FALSE {
        return Err(TestError::Fail(
            "conditionalRendering feature not supported but VK_EXT_conditional_rendering present".to_string(),
        ));
    }

    if data.condition_inherited && conditional_features.inherited_conditional_rendering == vk::FALSE {
        return Err(TestError::NotSupported(
            "Device does not support inherited conditional rendering".to_string(),
        ));
    }

    if data.secondary_command_buffer_nested {
        context.require_device_functionality("VK_EXT_nested_command_buffer")?;
        let mut nested_features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut nested_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if nested_features.nested_command_buffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "nestedCommandBuffer is not supported".to_string(),
            ));
        }
    }

    if data.condition_inherited && !data.condition_in_secondary_command_buffer {
        context.require_device_functionality("VK_KHR_maintenance7")?;
    }

    Ok(())
}

/// `checkNestedRenderPassCapabilities`
pub fn check_nested_render_pass_capabilities(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_nested_command_buffer")?;

    let mut nested_features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut nested_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    if nested_features.nested_command_buffer == vk::FALSE {
        return Err(TestError::NotSupported(
            "nestedCommandBuffer is not supported".to_string(),
        ));
    }
    if nested_features.nested_command_buffer_rendering == vk::FALSE {
        return Err(TestError::NotSupported(
            "nestedCommandBufferRendering is not supported".to_string(),
        ));
    }
    Ok(())
}

/// `Draw::Buffer` as `createConditionalRenderingBuffer` uses it: a buffer whose memory
/// is bound `extra_room` bytes into the allocation.
pub struct ConditionalBuffer<'a> {
    buffer: Unique<'a, vk::Buffer>,
    allocation: Allocation<'a>,
    extra_room: u64,
}

impl<'a> ConditionalBuffer<'a> {
    /// `Draw::Buffer::createAndAlloc`, with its `allocationOffset` handling.
    fn create_and_alloc(
        context: &'a Context<'a>,
        size: u64,
        usage: vk::BufferUsageFlags,
        requirement: MemoryRequirement,
        allocation_offset: u64,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let info = make_buffer_create_info(size, usage);
        let buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&info, None) }.vk_check("vkCreateBuffer")?,
        );

        let mut requirements = unsafe { device.get_buffer_memory_requirements(*buffer) };
        let extra_room = allocation_offset.div_ceil(requirements.alignment) * requirements.alignment;
        requirements.size += extra_room;

        let allocation = context
            .get_default_allocator()
            .allocate(device, requirements, requirement)?;
        unsafe { device.bind_buffer_memory(*buffer, allocation.get_memory(), allocation.get_offset() + extra_room) }
            .vk_check("vkBindBufferMemory")?;

        Ok(Self {
            buffer,
            allocation,
            extra_room,
        })
    }

    pub fn object(&self) -> vk::Buffer {
        *self.buffer
    }

    /// `Draw::Buffer::getHostPtr`
    fn host_ptr(&self) -> *mut u8 {
        unsafe { self.allocation.get_host_ptr().add(self.extra_room as usize) }
    }
}

/// `createConditionalRenderingBuffer`
///
/// `queue` and `queue_family_index` are the pair the staging copy of a device-local
/// buffer is submitted to; upstream picks them from `computeQueue`.
pub fn create_conditional_rendering_buffer<'a>(
    context: &'a Context<'a>,
    data: &ConditionalData,
    queue: vk::Queue,
    queue_family_index: u32,
) -> Result<ConditionalBuffer<'a>, TestError> {
    let device = context.get_device();
    let value_size = std::mem::size_of::<u32>() as u64;

    // Padding surrounds the condition value with two nonzero words; an allocation offset is four values.
    let buffer_size = value_size * if data.pad_condition_value { 3 } else { 1 };
    let data_offset = if data.pad_condition_value { value_size } else { 0 };
    let alloc_offset = value_size * if data.allocation_offset { 4 } else { 0 };

    let host_usage = if data.memory_type == ConditionalBufferMemory::Host {
        vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT
    } else {
        vk::BufferUsageFlags::TRANSFER_SRC
    };
    let host_buffer = ConditionalBuffer::create_and_alloc(
        context,
        buffer_size,
        host_usage,
        MemoryRequirement::HOST_VISIBLE,
        alloc_offset,
    )?;

    unsafe {
        let ptr = host_buffer.host_ptr();
        std::ptr::write_bytes(ptr, 1, buffer_size as usize);
        std::ptr::copy_nonoverlapping(
            data.condition_value.to_ne_bytes().as_ptr(),
            ptr.add(data_offset as usize),
            value_size as usize,
        );
    }
    flush_alloc(device, &host_buffer.allocation)?;

    if data.memory_type == ConditionalBufferMemory::Host {
        return Ok(host_buffer);
    }

    let device_local_usage = vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT | vk::BufferUsageFlags::TRANSFER_DST;
    let device_local_buffer = ConditionalBuffer::create_and_alloc(
        context,
        buffer_size,
        device_local_usage,
        MemoryRequirement::LOCAL,
        alloc_offset,
    )?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let copy_info = vk::BufferCopy::builder().src_offset(0).dst_offset(0).size(buffer_size);

    begin_command_buffer(device, *cmd_buffer)?;
    unsafe {
        device.cmd_copy_buffer(
            *cmd_buffer,
            host_buffer.object(),
            device_local_buffer.object(),
            &[copy_info],
        )
    };
    end_command_buffer(device, *cmd_buffer)?;
    submit_commands_and_wait(device, queue, *cmd_buffer)?;

    Ok(device_local_buffer)
}

/// `beginConditionalRendering`
pub fn begin_conditional_rendering(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    buffer: &ConditionalBuffer<'_>,
    data: &ConditionalData,
) {
    let offset = if data.pad_condition_value {
        std::mem::size_of::<u32>() as u64
    } else {
        0
    };
    let flags = if data.condition_inverted {
        vk::ConditionalRenderingFlagsEXT::INVERTED
    } else {
        vk::ConditionalRenderingFlagsEXT::empty()
    };
    let begin_info = vk::ConditionalRenderingBeginInfoEXT::builder()
        .buffer(buffer.object())
        .offset(offset)
        .flags(flags);
    unsafe { device.cmd_begin_conditional_rendering_ext(cmd_buffer, &begin_info) };
}

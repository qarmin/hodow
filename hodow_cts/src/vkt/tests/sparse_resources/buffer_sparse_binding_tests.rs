// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferSparseBinding.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Binds one memory allocation to a whole sparse buffer, copies a reference pattern in and out through staging buffers and compares.

use vulkanalia::prelude::v1_0::*;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{NO_MATCH_FOUND, find_matching_memory_type, submit_commands_and_wait};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct BufferSparseBindingCase {
    name: String,
    buffer_size: u32,
}

impl TestCase for BufferSparseBindingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferSparseBindingInstance {
            context,
            buffer_size: self.buffer_size,
        })
    }
}

struct BufferSparseBindingInstance<'a> {
    context: &'a Context<'a>,
    buffer_size: u32,
}

impl TestInstance for BufferSparseBindingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let buffer_size = self.buffer_size;

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

        let queue_family_indices = [sparse_queue.family_index, compute_queue.family_index];
        let mut buffer_create_info = vk::BufferCreateInfo::builder()
            .flags(vk::BufferCreateFlags::SPARSE_BINDING)
            .size(buffer_size as vk::DeviceSize)
            .usage(vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE);
        if sparse_queue.family_index != compute_queue.family_index {
            buffer_create_info = buffer_create_info
                .sharing_mode(vk::SharingMode::CONCURRENT)
                .queue_family_indices(&queue_family_indices);
        }

        // Create sparse buffer
        let sparse_buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
        );

        // Create sparse buffer memory bind semaphore
        let buffer_memory_bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        let buffer_mem_requirement = unsafe { device.get_buffer_memory_requirements(*sparse_buffer) };

        if buffer_mem_requirement.size
            > unsafe { instance.get_physical_device_properties(physical_device) }
                .limits
                .sparse_address_space_size
        {
            return Err(TestError::NotSupported(
                "Required memory size for sparse resources exceeds device limits".to_string(),
            ));
        }

        assert!(buffer_mem_requirement.size % buffer_mem_requirement.alignment == 0);

        let num_sparse_binds = (buffer_mem_requirement.size / buffer_mem_requirement.alignment) as u32;
        let memory_type = find_matching_memory_type(
            instance,
            physical_device,
            &buffer_mem_requirement,
            MemoryRequirement::ANY,
        );

        if memory_type == NO_MATCH_FOUND {
            return Ok(TestStatus::fail("No matching memory type found"));
        }

        let allocate_info = vk::MemoryAllocateInfo::builder()
            .allocation_size(buffer_mem_requirement.size)
            .memory_type_index(memory_type);
        let sparse_memory_allocation = Unique::new(
            device,
            unsafe { device.allocate_memory(&allocate_info, None) }.vk_check("vkAllocateMemory")?,
        );

        let sparse_memory_binds: Vec<vk::SparseMemoryBind> = (0..num_sparse_binds)
            .map(|sparse_bind_ndx| vk::SparseMemoryBind {
                resource_offset: buffer_mem_requirement.alignment * sparse_bind_ndx as vk::DeviceSize,
                size: buffer_mem_requirement.alignment,
                memory: *sparse_memory_allocation,
                memory_offset: buffer_mem_requirement.alignment * sparse_bind_ndx as vk::DeviceSize,
                flags: vk::SparseMemoryBindFlags::empty(),
            })
            .collect();

        let sparse_buffer_bind_info = [vk::SparseBufferMemoryBindInfo::builder()
            .buffer(*sparse_buffer)
            .binds(&sparse_memory_binds)
            .build()];
        let signal_semaphores = [*buffer_memory_bind_semaphore];
        let bind_sparse_info = vk::BindSparseInfo::builder()
            .buffer_binds(&sparse_buffer_bind_info)
            .signal_semaphores(&signal_semaphores);

        // Submit sparse bind commands for execution
        unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
            .vk_check("vkQueueBindSparse")?;

        // Create command buffer for transfer operations
        let command_pool = make_command_pool(device, compute_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording transfer commands
        begin_command_buffer(device, *command_buffer)?;

        let input_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let reference_data: Vec<u8> = (0..buffer_size)
            .map(|value_ndx| ((value_ndx as vk::DeviceSize % buffer_mem_requirement.alignment) + 1) as u8)
            .collect();

        unsafe {
            std::ptr::copy_nonoverlapping(
                reference_data.as_ptr(),
                input_buffer.get_allocation().get_host_ptr(),
                buffer_size as usize,
            )
        };
        flush_alloc(device, input_buffer.get_allocation())?;

        let pipeline_barrier = |src_stage: vk::PipelineStageFlags,
                                dst_stage: vk::PipelineStageFlags,
                                barrier: vk::BufferMemoryBarrier| unsafe {
            device.cmd_pipeline_barrier(
                *command_buffer,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        };

        pipeline_barrier(
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                input_buffer.get(),
                0,
                buffer_size as vk::DeviceSize,
            ),
        );

        let buffer_copy = [vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: buffer_size as vk::DeviceSize,
        }];
        unsafe { device.cmd_copy_buffer(*command_buffer, input_buffer.get(), *sparse_buffer, &buffer_copy) };

        pipeline_barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                *sparse_buffer,
                0,
                buffer_size as vk::DeviceSize,
            ),
        );

        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        unsafe { device.cmd_copy_buffer(*command_buffer, *sparse_buffer, output_buffer.get(), &buffer_copy) };

        pipeline_barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer.get(),
                0,
                buffer_size as vk::DeviceSize,
            ),
        );

        // End recording transfer commands
        end_command_buffer(device, *command_buffer)?;

        // Submit transfer commands for execution and wait for completion
        submit_commands_and_wait(
            device,
            compute_queue.handle,
            *command_buffer,
            &[*buffer_memory_bind_semaphore],
            &[vk::PipelineStageFlags::TRANSFER],
            &[],
        )?;

        // Retrieve data from output buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;

        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                buffer_size as usize,
            )
        };

        // Wait for sparse queue to become idle
        unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        // Compare output data with reference data
        if reference_data != output_data {
            return Ok(TestStatus::fail("Failed"));
        }
        Ok(TestStatus::pass("Passed"))
    }
}

/// `addBufferSparseBindingTests`
pub fn add_buffer_sparse_binding_tests(group: &mut TestCaseGroup) {
    for (name, shift) in [
        ("buffer_size_2_10", 10),
        ("buffer_size_2_12", 12),
        ("buffer_size_2_16", 16),
        ("buffer_size_2_17", 17),
        ("buffer_size_2_20", 20),
        ("buffer_size_2_24", 24),
    ] {
        group.add_child(Box::new(BufferSparseBindingCase {
            name: name.to_string(),
            buffer_size: 1 << shift,
        }) as Box<dyn TestCase>);
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferRebind.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device group variant is not ported.
//
// Rebinds a sparse buffer: two memories are bound in turn over the whole buffer and filled with different patterns, then a partial
// bind of the first one is laid over the middle, and the buffer read back must show the first pattern only where that bind is.
//
//  256 KB
// +----------------------------------------------+
// | buffer                                       |
// +-----------+----------------------+-----------+
// | memory 2  | memory 1             | memory 2  |
// +-----------+----------------------+-----------+
//   64 KB       128 KB                 64 KB

use vulkanalia::prelude::v1_0::*;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{NO_MATCH_FOUND, find_matching_memory_type, make_sparse_memory_bind, submit_commands_and_wait};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const MEMORY_PATTERNS: [u32; 2] = [0xAAAA_AAAA, 0x5555_5555];

struct BufferSparseRebindCase {
    name: String,
    buffer_size: u32,
}

impl TestCase for BufferSparseRebindCase {
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
        Box::new(BufferSparseRebindInstance {
            context,
            buffer_size: self.buffer_size,
        })
    }
}

struct BufferSparseRebindInstance<'a> {
    context: &'a Context<'a>,
    buffer_size: u32,
}

impl TestInstance for BufferSparseRebindInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let buffer_size = self.buffer_size;

        // Create logical device supporting both sparse and transfer operations
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

        let queue_family_indices = [sparse_queue.family_index, transfer_queue.family_index];
        let mut buffer_create_info = vk::BufferCreateInfo::builder()
            .flags(vk::BufferCreateFlags::SPARSE_BINDING)
            .size(buffer_size as vk::DeviceSize)
            .usage(vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE);
        if sparse_queue.family_index != transfer_queue.family_index {
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

        let buffer_mem_requirements = unsafe { device.get_buffer_memory_requirements(*sparse_buffer) };

        if buffer_mem_requirements.size
            > unsafe { instance.get_physical_device_properties(physical_device) }
                .limits
                .sparse_address_space_size
        {
            return Err(TestError::NotSupported(
                "Required memory size for sparse resources exceeds device limits".to_string(),
            ));
        }

        assert!(buffer_mem_requirements.size % buffer_mem_requirements.alignment == 0);

        // Mark as not supported if the buffer is too small and cannot be backed by two memories
        if buffer_mem_requirements.size / buffer_mem_requirements.alignment < 2 {
            return Err(TestError::NotSupported(
                "Buffer size is too small for partial binding".to_string(),
            ));
        }

        let partial_bind_offset = buffer_mem_requirements.alignment;
        let partial_bind_size = buffer_mem_requirements.size / 2;

        let memory_type = find_matching_memory_type(
            instance,
            physical_device,
            &buffer_mem_requirements,
            MemoryRequirement::ANY,
        );

        if memory_type == NO_MATCH_FOUND {
            return Ok(TestStatus::fail("No matching memory type found"));
        }

        // Create two memories which will be backing the buffer
        let sparse_memory_bind_full = [
            make_sparse_memory_bind(
                device,
                buffer_mem_requirements.size,
                memory_type,
                0,
                vk::SparseMemoryBindFlags::empty(),
            )?,
            make_sparse_memory_bind(
                device,
                buffer_mem_requirements.size,
                memory_type,
                0,
                vk::SparseMemoryBindFlags::empty(),
            )?,
        ];
        let device_memories = [
            Unique::new(device, sparse_memory_bind_full[0].memory),
            Unique::new(device, sparse_memory_bind_full[1].memory),
        ];

        // Command pool for command buffers used by the test
        let command_pool = make_command_pool(device, transfer_queue.family_index)?;
        let wait_stage_bits = [vk::PipelineStageFlags::TRANSFER];
        let signal_semaphores = [*buffer_memory_bind_semaphore];

        // Bind the memories fully and fill them with a pattern
        for memory_idx in 0..2 {
            // First bind the memory
            let sparse_buffer_memory_bind_info = [vk::SparseBufferMemoryBindInfo::builder()
                .buffer(*sparse_buffer)
                .binds(&sparse_memory_bind_full[memory_idx..memory_idx + 1])
                .build()];
            let bind_sparse_info = vk::BindSparseInfo::builder()
                .buffer_binds(&sparse_buffer_memory_bind_info)
                .signal_semaphores(&signal_semaphores);

            // Submit sparse bind commands for execution
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;

            // And then fill the buffer with data on the device
            let command_buffer_fill = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, *command_buffer_fill)?;
            unsafe {
                device.cmd_fill_buffer(
                    *command_buffer_fill,
                    *sparse_buffer,
                    0,
                    vk::WHOLE_SIZE,
                    MEMORY_PATTERNS[memory_idx],
                )
            };
            end_command_buffer(device, *command_buffer_fill)?;

            // Wait for the sparse bind operation semaphore, submit and wait on host for the transfer stage
            submit_commands_and_wait(
                device,
                transfer_queue.handle,
                *command_buffer_fill,
                &signal_semaphores,
                &wait_stage_bits,
                &[],
            )?;
        }

        // The final binding would be half and half between memory 1 and memory 2 starting with a slight offset from the start
        {
            let sparse_memory_bind_partial = [vk::SparseMemoryBind {
                resource_offset: partial_bind_offset,
                size: partial_bind_size,
                memory: *device_memories[0],
                memory_offset: partial_bind_offset,
                flags: vk::SparseMemoryBindFlags::empty(),
            }];
            let sparse_buffer_memory_bind_info = [vk::SparseBufferMemoryBindInfo::builder()
                .buffer(*sparse_buffer)
                .binds(&sparse_memory_bind_partial)
                .build()];
            let bind_sparse_info = vk::BindSparseInfo::builder()
                .buffer_binds(&sparse_buffer_memory_bind_info)
                .signal_semaphores(&signal_semaphores);

            // Submit sparse bind commands for execution, no need for a waitSemaphore as the host waited for the previous submit.
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
        }

        // And verify the result by copying sparse buffer data into a new host-visible buffer

        // Create output buffer
        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let command_buffer_copy = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *command_buffer_copy)?;

        let buffer_copy = [vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: buffer_size as vk::DeviceSize,
        }];
        unsafe { device.cmd_copy_buffer(*command_buffer_copy, *sparse_buffer, output_buffer.get(), &buffer_copy) };

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
                    *command_buffer_copy,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[output_buffer_host_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, *command_buffer_copy)?;

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(
            device,
            transfer_queue.handle,
            *command_buffer_copy,
            &signal_semaphores,
            &wait_stage_bits,
            &[],
        )?;

        // Retrieve data from output buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;

        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                buffer_size as usize / 4,
            )
        };

        // Wait for sparse queue to become idle
        unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        // Prepare reference data
        let reference_data: Vec<u32> = (0..buffer_size as usize / 4)
            .map(|i| {
                let byte_offset = (i * 4) as vk::DeviceSize;
                if byte_offset >= partial_bind_offset && byte_offset < partial_bind_offset + partial_bind_size {
                    MEMORY_PATTERNS[0]
                } else {
                    MEMORY_PATTERNS[1]
                }
            })
            .collect();

        // Compare reference data with output data
        if reference_data != output_data {
            return Ok(TestStatus::fail("Failed"));
        }
        Ok(TestStatus::pass("Passed"))
    }
}

/// `addBufferSparseRebindTests`
pub fn add_buffer_sparse_rebind_tests(group: &mut TestCaseGroup) {
    for (name, shift) in [
        ("buffer_size_2_16", 16),
        ("buffer_size_2_18", 18),
        ("buffer_size_2_20", 20),
        ("buffer_size_2_24", 24),
    ] {
        group.add_child(Box::new(BufferSparseRebindCase {
            name: name.to_string(),
            buffer_size: 1 << shift,
        }) as Box<dyn TestCase>);
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferMemoryAliasing.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader depends only on the buffer size, so the manifest holds one program per
// size and `programs()` looks it up by that size. The device group variant is not ported.
//
// Two sparse aliased buffers are backed by the same memory; a compute shader writes through one and the other is copied out and
// compared with the pattern.

use vulkanalia::prelude::v1_0::*;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{NO_MATCH_FOUND, find_matching_memory_type, make_sparse_memory_bind, submit_commands_and_wait};
use crate::generated::shaders::sparse_resources_buffer_memory_aliasing::{
    SPARSE_ALIASING_2_10, SPARSE_ALIASING_2_12, SPARSE_ALIASING_2_16, SPARSE_ALIASING_2_17, SPARSE_ALIASING_2_20,
    SPARSE_ALIASING_2_24,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE_OF_UINT_IN_SHADER: u32 = 4;
const MODULO_DIVISOR: u32 = 1024;

/// `computeWorkGroupSize`
fn compute_work_group_size(num_invocations: u32) -> [u32; 3] {
    let max_compute_work_group_invocations = 128u32;
    let max_compute_work_group_size = [128u32, 128, 64];
    let mut num_invocations_left = num_invocations;

    let x_work_group_size = num_invocations_left
        .min(max_compute_work_group_size[0])
        .min(max_compute_work_group_invocations);
    num_invocations_left =
        num_invocations_left / x_work_group_size + u32::from(!num_invocations_left.is_multiple_of(x_work_group_size));

    let y_work_group_size = num_invocations_left
        .min(max_compute_work_group_size[1])
        .min(max_compute_work_group_invocations / x_work_group_size);
    num_invocations_left =
        num_invocations_left / y_work_group_size + u32::from(!num_invocations_left.is_multiple_of(y_work_group_size));

    let z_work_group_size = num_invocations_left
        .min(max_compute_work_group_size[2])
        .min(max_compute_work_group_invocations / (x_work_group_size * y_work_group_size));

    [x_work_group_size, y_work_group_size, z_work_group_size]
}

struct BufferSparseMemoryAliasingCase {
    name: String,
    buffer_size: u32,
}

impl TestCase for BufferSparseMemoryAliasingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
        }
        if features.sparse_residency_aliased == vk::FALSE {
            return Err(TestError::NotSupported(
                "sparseResidencyAliased not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.buffer_size {
            1024 => SPARSE_ALIASING_2_10.programs,
            4096 => SPARSE_ALIASING_2_12.programs,
            65536 => SPARSE_ALIASING_2_16.programs,
            131072 => SPARSE_ALIASING_2_17.programs,
            1048576 => SPARSE_ALIASING_2_20.programs,
            _ => SPARSE_ALIASING_2_24.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferSparseMemoryAliasingInstance {
            context,
            buffer_size_in_bytes: self.buffer_size,
        })
    }
}

struct BufferSparseMemoryAliasingInstance<'a> {
    context: &'a Context<'a>,
    buffer_size_in_bytes: u32,
}

impl TestInstance for BufferSparseMemoryAliasingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let size = self.buffer_size_in_bytes;

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
            .flags(vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_ALIASED)
            .size(size as vk::DeviceSize)
            .usage(vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE);
        if sparse_queue.family_index != compute_queue.family_index {
            buffer_create_info = buffer_create_info
                .sharing_mode(vk::SharingMode::CONCURRENT)
                .queue_family_indices(&queue_family_indices);
        }

        // Create sparse buffers
        let sparse_buffer_write = Unique::new(
            device,
            unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
        );
        let sparse_buffer_read = Unique::new(
            device,
            unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
        );

        // Create sparse buffers memory bind semaphore
        let buffer_memory_bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        let buffer_mem_requirements = unsafe { device.get_buffer_memory_requirements(*sparse_buffer_write) };

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

        let memory_type = find_matching_memory_type(
            instance,
            physical_device,
            &buffer_mem_requirements,
            MemoryRequirement::ANY,
        );

        if memory_type == NO_MATCH_FOUND {
            return Ok(TestStatus::fail("No matching memory type found"));
        }

        let sparse_memory_bind = [make_sparse_memory_bind(
            device,
            buffer_mem_requirements.size,
            memory_type,
            0,
            vk::SparseMemoryBindFlags::empty(),
        )?];
        let _device_memory = Unique::new(device, sparse_memory_bind[0].memory);

        {
            let sparse_buffer_memory_bind_info = [
                vk::SparseBufferMemoryBindInfo::builder()
                    .buffer(*sparse_buffer_write)
                    .binds(&sparse_memory_bind)
                    .build(),
                vk::SparseBufferMemoryBindInfo::builder()
                    .buffer(*sparse_buffer_read)
                    .binds(&sparse_memory_bind)
                    .build(),
            ];
            let signal_semaphores = [*buffer_memory_bind_semaphore];
            let bind_sparse_info = vk::BindSparseInfo::builder()
                .buffer_binds(&sparse_buffer_memory_bind_info)
                .signal_semaphores(&signal_semaphores);

            // Submit sparse bind commands for execution
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
        }

        // Create output buffer
        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create command buffer for compute and data transfer operations
        let command_pool = make_command_pool(device, compute_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands
        begin_command_buffer(device, *command_buffer)?;

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        // Create compute pipeline
        let mut compute_pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        compute_pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        compute_pipeline.build_pipeline()?;
        compute_pipeline.bind(*command_buffer);

        // Create descriptor set
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        {
            let sparse_buffer_info = [vk::DescriptorBufferInfo {
                buffer: *sparse_buffer_write,
                offset: 0,
                range: size as vk::DeviceSize,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&sparse_buffer_info)
                .build();
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        }

        unsafe {
            device.cmd_bind_descriptor_sets(
                *command_buffer,
                vk::PipelineBindPoint::COMPUTE,
                compute_pipeline.get_pipeline_layout(),
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            )
        };

        {
            let mut num_invocations_left = size / SIZE_OF_UINT_IN_SHADER;
            let work_group_size = compute_work_group_size(num_invocations_left);
            let max_compute_work_group_count = [65535u32, 65535, 65535];

            num_invocations_left -= work_group_size[0] * work_group_size[1] * work_group_size[2];

            let x_work_group_count = num_invocations_left.min(max_compute_work_group_count[0]);
            num_invocations_left = num_invocations_left / x_work_group_count
                + u32::from(!num_invocations_left.is_multiple_of(x_work_group_count));
            let y_work_group_count = num_invocations_left.min(max_compute_work_group_count[1]);
            num_invocations_left = num_invocations_left / y_work_group_count
                + u32::from(!num_invocations_left.is_multiple_of(y_work_group_count));
            let z_work_group_count = num_invocations_left.min(max_compute_work_group_count[2]);
            num_invocations_left = num_invocations_left / z_work_group_count
                + u32::from(!num_invocations_left.is_multiple_of(z_work_group_count));

            if num_invocations_left != 1 {
                return Err(TestError::NotSupported("Buffer size is not supported".to_string()));
            }

            unsafe {
                device.cmd_dispatch(
                    *command_buffer,
                    x_work_group_count,
                    y_work_group_count,
                    z_work_group_count,
                )
            };
        }

        {
            let sparse_buffer_write_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                *sparse_buffer_write,
                0,
                size as vk::DeviceSize,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[sparse_buffer_write_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        {
            let buffer_copy = [vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: size as vk::DeviceSize,
            }];
            unsafe { device.cmd_copy_buffer(*command_buffer, *sparse_buffer_read, output_buffer.get(), &buffer_copy) };
        }

        {
            let output_buffer_host_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer.get(),
                0,
                size as vk::DeviceSize,
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

        // End recording commands
        end_command_buffer(device, *command_buffer)?;

        // The stage at which execution is going to wait for finish of sparse binding operations
        let wait_stage_bits = [vk::PipelineStageFlags::COMPUTE_SHADER];

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(
            device,
            compute_queue.handle,
            *command_buffer,
            &[*buffer_memory_bind_semaphore],
            &wait_stage_bits,
            &[],
        )?;

        // Retrieve data from output buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;

        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                size as usize,
            )
        };

        // Wait for sparse queue to become idle
        unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        // Prepare reference data
        let mut reference_data = vec![0u8; size as usize];
        let reference_data_block: Vec<u32> = (0..MODULO_DIVISOR)
            .map(|value_ndx| value_ndx % MODULO_DIVISOR)
            .collect();
        let block_bytes: Vec<u8> = reference_data_block
            .iter()
            .flat_map(|value| value.to_ne_bytes())
            .collect();

        let full_block_size_in_bytes = MODULO_DIVISOR * SIZE_OF_UINT_IN_SHADER;
        let last_block_size_in_bytes = size % full_block_size_in_bytes;
        let number_of_blocks = size / full_block_size_in_bytes + u32::from(last_block_size_in_bytes != 0);

        for block_ndx in 0..number_of_blocks {
            let offset = (block_ndx * full_block_size_in_bytes) as usize;
            let length = (if offset as u32 + full_block_size_in_bytes <= size {
                full_block_size_in_bytes
            } else {
                last_block_size_in_bytes
            }) as usize;
            reference_data[offset..offset + length].copy_from_slice(&block_bytes[..length]);
        }

        // Compare reference data with output data
        if reference_data != output_data {
            return Ok(TestStatus::fail("Failed"));
        }
        Ok(TestStatus::pass("Passed"))
    }
}

/// `addBufferSparseMemoryAliasingTests`
pub fn add_buffer_sparse_memory_aliasing_tests(group: &mut TestCaseGroup) {
    for (name, shift) in [
        ("buffer_size_2_10", 10),
        ("buffer_size_2_12", 12),
        ("buffer_size_2_16", 16),
        ("buffer_size_2_17", 17),
        ("buffer_size_2_20", 20),
        ("buffer_size_2_24", 24),
    ] {
        group.add_child(Box::new(BufferSparseMemoryAliasingCase {
            name: name.to_string(),
            buffer_size: 1 << shift,
        }) as Box<dyn TestCase>);
    }
}

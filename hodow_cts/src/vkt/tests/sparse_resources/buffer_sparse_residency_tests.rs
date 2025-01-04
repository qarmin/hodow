// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferSparseResidency.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Not ported: the device group variant and `TexelBufferSparseResidencyCase`, whose
// shaders are SPIR-V assembly. The three programs are in the manifest and picked by what the case needs.
//
// A sparse residency buffer with every other block backed by memory is written by a shader and read back, and with
// `residencyNonResidentStrict` the unbacked blocks must read as zero. The non-resident cases do the same through copy, fill and
// update commands, on buffers that are partially resident or not resident at all.

use vulkanalia::prelude::v1_0::*;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{NO_MATCH_FOUND, find_matching_memory_type, make_sparse_memory_bind, submit_commands_and_wait};
use crate::generated::shaders::sparse_resources_buffer_residency::{
    SPARSE_RESIDENCY_COPY, SPARSE_RESIDENCY_VERIFY_NONE, SPARSE_RESIDENCY_VERIFY_PARTIAL,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[allow(dead_code)]
const SIZE_OF_UINT_IN_SHADER: u32 = 4;

#[derive(Clone, Copy, PartialEq, Eq)]
enum BufferInitCommand {
    Copy,
    Fill,
    Update,
}

impl BufferInitCommand {
    /// `getbufferInitCmdName`
    fn name(self) -> &'static str {
        match self {
            BufferInitCommand::Copy => "copy",
            BufferInitCommand::Fill => "fill",
            BufferInitCommand::Update => "update",
        }
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    buffer_init_cmd: BufferInitCommand,
    /// true = residencyNonResidentStrict enabled, false = residencyNonResidentStrict ignored
    with_strict_residency: bool,
    /// true = completely non-resident, false = partially non-resident
    is_buffer_non_resident: bool,
    buffer_size: u32,
    /// Applies only on copy command; true = source buffer in the copy command is sparse, false = destination buffer is
    is_copy_src_sparse: bool,
    /// Applies only on copy command
    is_multi_copy: bool,
}

/// The pipeline layout of these cases is one set and a compute push constant range, which `ComputePipelineWrapper` cannot build.
fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(-1)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn make_pipeline_layout_with_push_constants<'a>(
    device: &'a Device,
    set_layout: vk::DescriptorSetLayout,
    push_constant_size: u32,
) -> Result<Unique<'a, vk::PipelineLayout>, TestError> {
    let set_layouts = [set_layout];
    let push_constant_ranges = [vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::COMPUTE,
        offset: 0,
        size: push_constant_size,
    }];
    let info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&push_constant_ranges);
    Ok(Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
    ))
}

/// `BufferSparseResidencyCase`
struct BufferSparseResidencyCase {
    name: String,
    buffer_size: u32,
}

impl TestCase for BufferSparseResidencyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SPARSE_RESIDENCY_COPY.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferSparseResidencyInstance {
            context,
            buffer_size: self.buffer_size,
        })
    }
}

struct BufferSparseResidencyInstance<'a> {
    context: &'a Context<'a>,
    buffer_size: u32,
}

impl TestInstance for BufferSparseResidencyInstance<'_> {
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
        let physical_device_properties = unsafe { instance.get_physical_device_properties(physical_device) };

        if unsafe { instance.get_physical_device_features(physical_device) }.sparse_residency_buffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "Sparse partially resident buffers not supported".to_string(),
            ));
        }

        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);

        let queue_family_indices = [sparse_queue.family_index, compute_queue.family_index];
        let mut buffer_create_info = vk::BufferCreateInfo::builder()
            .flags(vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_RESIDENCY)
            .size(buffer_size as vk::DeviceSize)
            .usage(vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC)
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

        let buffer_mem_requirements = unsafe { device.get_buffer_memory_requirements(*sparse_buffer) };

        if buffer_mem_requirements.size > physical_device_properties.limits.sparse_address_space_size {
            return Err(TestError::NotSupported(
                "Required memory size for sparse resources exceeds device limits".to_string(),
            ));
        }

        assert!(buffer_mem_requirements.size % buffer_mem_requirements.alignment == 0);

        let num_sparse_slots = (buffer_mem_requirements.size / buffer_mem_requirements.alignment) as u32;
        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();

        {
            let memory_type = find_matching_memory_type(
                instance,
                physical_device,
                &buffer_mem_requirements,
                MemoryRequirement::ANY,
            );

            if memory_type == NO_MATCH_FOUND {
                return Ok(TestStatus::fail("No matching memory type found"));
            }

            let mut sparse_memory_binds = Vec::new();
            for sparse_bind_ndx in (0..num_sparse_slots).step_by(2) {
                let sparse_memory_bind = make_sparse_memory_bind(
                    device,
                    buffer_mem_requirements.alignment,
                    memory_type,
                    buffer_mem_requirements.alignment * sparse_bind_ndx as vk::DeviceSize,
                    vk::SparseMemoryBindFlags::empty(),
                )?;
                device_memory.push(Unique::new(device, sparse_memory_bind.memory));
                sparse_memory_binds.push(sparse_memory_bind);
            }

            let sparse_buffer_bind_info = [vk::SparseBufferMemoryBindInfo::builder()
                .buffer(*sparse_buffer)
                .binds(&sparse_memory_binds)
                .build()];
            let signal_semaphores = [*buffer_memory_bind_semaphore];
            let bind_sparse_info = vk::BindSparseInfo::builder()
                .buffer_binds(&sparse_buffer_bind_info)
                .signal_semaphores(&signal_semaphores);

            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
        }

        // Create input buffer
        let input_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut reference_data: Vec<u8> = (0..buffer_size)
            .map(|value_ndx| ((value_ndx as vk::DeviceSize % buffer_mem_requirements.alignment) + 1) as u8)
            .collect();

        unsafe {
            std::ptr::copy_nonoverlapping(
                reference_data.as_ptr(),
                input_buffer.get_allocation().get_host_ptr(),
                buffer_size as usize,
            )
        };
        flush_alloc(device, input_buffer.get_allocation())?;

        // Create output buffer
        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create command buffer for compute and data transfer operations
        let command_pool = make_command_pool(device, compute_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording compute and transfer commands
        begin_command_buffer(device, *command_buffer)?;

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        // Create compute pipeline
        let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let pipeline_layout = make_pipeline_layout_with_push_constants(
            device,
            *descriptor_set_layout,
            std::mem::size_of::<u32>() as u32,
        )?;
        let compute_pipeline = create_compute_pipeline(device, *pipeline_layout, *shader_module)?;

        unsafe { device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        {
            let input_buffer_info = [vk::DescriptorBufferInfo {
                buffer: input_buffer.get(),
                offset: 0,
                range: buffer_size as vk::DeviceSize,
            }];
            let sparse_buffer_info = [vk::DescriptorBufferInfo {
                buffer: *sparse_buffer,
                offset: 0,
                range: buffer_size as vk::DeviceSize,
            }];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&input_buffer_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&sparse_buffer_info)
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        unsafe {
            device.cmd_bind_descriptor_sets(
                *command_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            )
        };

        let buffer_barrier = |src_access: vk::AccessFlags,
                              dst_access: vk::AccessFlags,
                              buffer: vk::Buffer,
                              src_stage: vk::PipelineStageFlags,
                              dst_stage: vk::PipelineStageFlags| unsafe {
            device.cmd_pipeline_barrier(
                *command_buffer,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[make_buffer_memory_barrier(
                    src_access,
                    dst_access,
                    buffer,
                    0,
                    buffer_size as vk::DeviceSize,
                )],
                &[] as &[vk::ImageMemoryBarrier],
            );
        };

        buffer_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_READ,
            input_buffer.get(),
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::COMPUTE_SHADER,
        );

        {
            let sqrt_size = (buffer_size as f32).sqrt().ceil() as u32;
            // Spec minimum requirement for maxComputeWorkGroupCount[]
            assert!(sqrt_size <= 65535);

            unsafe {
                device.cmd_push_constants(
                    *command_buffer,
                    *pipeline_layout,
                    vk::ShaderStageFlags::COMPUTE,
                    0,
                    &buffer_size.to_ne_bytes(),
                );
                device.cmd_dispatch(*command_buffer, sqrt_size, sqrt_size, 1);
            }
        }

        buffer_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            *sparse_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::TRANSFER,
        );

        {
            let buffer_copy = [vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: buffer_size as vk::DeviceSize,
            }];
            unsafe { device.cmd_copy_buffer(*command_buffer, *sparse_buffer, output_buffer.get(), &buffer_copy) };
        }

        buffer_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer.get(),
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
        );

        // End recording compute and transfer commands
        end_command_buffer(device, *command_buffer)?;

        let wait_stage_bits = [vk::PipelineStageFlags::TRANSFER];

        // Submit transfer commands for execution and wait for completion
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
                buffer_size as usize,
            )
        };

        // Wait for sparse queue to become idle
        unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        // Compare output data with reference data
        for sparse_bind_ndx in 0..num_sparse_slots {
            let alignment = buffer_mem_requirements.alignment as u32;
            let offset = (alignment * sparse_bind_ndx) as usize;
            let size = (if sparse_bind_ndx == num_sparse_slots - 1 {
                buffer_size % alignment
            } else {
                alignment
            }) as usize;

            if sparse_bind_ndx % 2 == 0 {
                if reference_data[offset..offset + size] != output_data[offset..offset + size] {
                    return Ok(TestStatus::fail("Failed"));
                }
            } else if physical_device_properties
                .sparse_properties
                .residency_non_resident_strict
                != vk::FALSE
            {
                reference_data[offset..offset + size].fill(0);

                if reference_data[offset..offset + size] != output_data[offset..offset + size] {
                    return Ok(TestStatus::fail("Failed"));
                }
            }
        }

        drop(device_memory);
        Ok(TestStatus::pass("Passed"))
    }
}

/// `BufferSparseResidencyNonResidentCase`
struct BufferSparseResidencyNonResidentCase {
    name: String,
    test_params: TestParams,
}

impl TestCase for BufferSparseResidencyNonResidentCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
        }
        if features.sparse_residency_buffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "sparseResidencyBuffer not supported".to_string(),
            ));
        }

        if self.test_params.with_strict_residency
            && context
                .get_device_properties()
                .sparse_properties
                .residency_non_resident_strict
                == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Property residencyNonResidentStrict is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.test_params;
        if params.buffer_init_cmd == BufferInitCommand::Copy && !params.is_copy_src_sparse {
            if params.is_buffer_non_resident {
                SPARSE_RESIDENCY_VERIFY_NONE.programs
            } else {
                SPARSE_RESIDENCY_VERIFY_PARTIAL.programs
            }
        } else {
            SPARSE_RESIDENCY_COPY.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferSparseResidencyNonResidentInstance {
            context,
            test_params: self.test_params,
        })
    }
}

struct BufferSparseResidencyNonResidentInstance<'a> {
    context: &'a Context<'a>,
    test_params: TestParams,
}

impl TestInstance for BufferSparseResidencyNonResidentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.test_params;
        let buffer_size = params.buffer_size;

        // Try to use transfer queue (if available) for copy, fill and update operations
        let cmd_queue_bit = if params.buffer_init_cmd == BufferInitCommand::Copy {
            vk::QueueFlags::COMPUTE
        } else {
            vk::QueueFlags::TRANSFER
        };

        // Initialize fill value for fill command
        let fill_value = 0xAAAA_AAAAu32;

        // Create logical device supporting both sparse and compute operations
        let mut queue_requirements = Vec::new();
        if !params.is_buffer_non_resident {
            queue_requirements.push(QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1));
        }
        queue_requirements.push(QueueRequirements::new(cmd_queue_bit, 1));
        let sparse_device = SparseDevice::new(context, &queue_requirements, false)?;
        let device = sparse_device.device();

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let physical_device_properties = unsafe { instance.get_physical_device_properties(physical_device) };

        let cmd_queue = sparse_device.get_queue(cmd_queue_bit, 0);
        let queue_family_indices;
        let mut buffer_create_info = vk::BufferCreateInfo::builder()
            .flags(vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_RESIDENCY)
            .size(buffer_size as vk::DeviceSize)
            .usage(
                vk::BufferUsageFlags::STORAGE_BUFFER
                    | vk::BufferUsageFlags::TRANSFER_SRC
                    | vk::BufferUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE);
        if !params.is_buffer_non_resident {
            let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
            queue_family_indices = [sparse_queue.family_index, cmd_queue.family_index];

            if sparse_queue.family_index != cmd_queue.family_index {
                buffer_create_info = buffer_create_info
                    .sharing_mode(vk::SharingMode::CONCURRENT)
                    .queue_family_indices(&queue_family_indices);
            }
        }

        // Create sparse buffer
        let sparse_buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
        );

        let buffer_mem_requirements = unsafe { device.get_buffer_memory_requirements(*sparse_buffer) };

        if !params.is_buffer_non_resident
            && buffer_mem_requirements.size > physical_device_properties.limits.sparse_address_space_size
        {
            return Err(TestError::NotSupported(
                "Required memory size for sparse resources exceeds device limits".to_string(),
            ));
        }

        assert!(buffer_mem_requirements.size % buffer_mem_requirements.alignment == 0);

        // Create sparse buffer memory bind semaphore
        let buffer_memory_bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        let num_sparse_slots = if !params.is_buffer_non_resident {
            (buffer_mem_requirements.size / buffer_mem_requirements.alignment) as u32
        } else {
            0
        };

        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();

        // Bind sparse memory if partially non-resident buffer
        if !params.is_buffer_non_resident {
            let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);

            {
                let memory_type = find_matching_memory_type(
                    instance,
                    physical_device,
                    &buffer_mem_requirements,
                    MemoryRequirement::ANY,
                );

                if memory_type == NO_MATCH_FOUND {
                    return Ok(TestStatus::fail("No matching memory type found"));
                }

                let mut sparse_memory_binds = Vec::new();
                for sparse_bind_ndx in (0..num_sparse_slots).step_by(2) {
                    let sparse_memory_bind = make_sparse_memory_bind(
                        device,
                        buffer_mem_requirements.alignment,
                        memory_type,
                        buffer_mem_requirements.alignment * sparse_bind_ndx as vk::DeviceSize,
                        vk::SparseMemoryBindFlags::empty(),
                    )?;
                    device_memory.push(Unique::new(device, sparse_memory_bind.memory));
                    sparse_memory_binds.push(sparse_memory_bind);
                }

                let sparse_buffer_bind_info = [vk::SparseBufferMemoryBindInfo::builder()
                    .buffer(*sparse_buffer)
                    .binds(&sparse_memory_binds)
                    .build()];
                let signal_semaphores = [*buffer_memory_bind_semaphore];
                let bind_sparse_info = vk::BindSparseInfo::builder()
                    .buffer_binds(&sparse_buffer_bind_info)
                    .signal_semaphores(&signal_semaphores);

                unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                    .vk_check("vkQueueBindSparse")?;
            }

            // Wait for sparse queue to become idle
            unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;
        }

        let is_copy_cmd = params.buffer_init_cmd == BufferInitCommand::Copy;
        let is_input_desc_sparse = is_copy_cmd && !params.is_copy_src_sparse;
        let is_output_desc_sparse = (is_copy_cmd && params.is_copy_src_sparse) || !is_copy_cmd;

        // Create input buffer for reading in shader or copy command
        let input_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                buffer_size as vk::DeviceSize,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut reference_data: Vec<u8> = (0..buffer_size)
            .map(|value_ndx| ((value_ndx as vk::DeviceSize % buffer_mem_requirements.alignment) + 1) as u8)
            .collect();

        unsafe {
            std::ptr::copy_nonoverlapping(
                reference_data.as_ptr(),
                input_buffer.get_allocation().get_host_ptr(),
                buffer_size as usize,
            )
        };
        flush_alloc(device, input_buffer.get_allocation())?;

        // Create output buffer
        let output_buffer_size_bytes = buffer_size as vk::DeviceSize;
        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(output_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Initialize output buffer with all 0xFF
        {
            let random_data = vec![0xFFu8; buffer_size as usize];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    random_data.as_ptr(),
                    output_buffer.get_allocation().get_host_ptr(),
                    buffer_size as usize,
                )
            };
            flush_alloc(device, output_buffer.get_allocation())?;
        }

        let output_test_buffer_size_bytes = std::mem::size_of::<u32>() as vk::DeviceSize;
        let output_test_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(output_test_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create command buffer for compute and data transfer operations
        let command_pool = make_command_pool(device, cmd_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording compute and transfer commands
        begin_command_buffer(device, *command_buffer)?;

        // Create objects for compute pipeline
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;

        // Push constant range: TestPushConstants { bufferSize, blockSize }
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, *descriptor_set_layout, 8)?;

        let compute_pipeline = create_compute_pipeline(device, *pipeline_layout, *shader_module)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let in_buffer_info = [vk::DescriptorBufferInfo {
            buffer: if is_input_desc_sparse {
                *sparse_buffer
            } else {
                input_buffer.get()
            },
            offset: 0,
            range: buffer_size as vk::DeviceSize,
        }];

        let out_buffer = if is_output_desc_sparse {
            *sparse_buffer
        } else if is_input_desc_sparse {
            output_test_buffer.get()
        } else {
            output_buffer.get()
        };
        let out_range = if is_output_desc_sparse {
            buffer_size as vk::DeviceSize
        } else if is_input_desc_sparse {
            output_test_buffer_size_bytes
        } else {
            output_buffer_size_bytes
        };
        let out_buffer_info = [vk::DescriptorBufferInfo {
            buffer: out_buffer,
            offset: 0,
            range: out_range,
        }];

        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&in_buffer_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&out_buffer_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let barrier = |src_access: vk::AccessFlags,
                       dst_access: vk::AccessFlags,
                       buffer: vk::Buffer,
                       size: vk::DeviceSize,
                       src_stage: vk::PipelineStageFlags,
                       dst_stage: vk::PipelineStageFlags| unsafe {
            device.cmd_pipeline_barrier(
                *command_buffer,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[make_buffer_memory_barrier(src_access, dst_access, buffer, 0, size)],
                &[] as &[vk::ImageMemoryBarrier],
            );
        };
        let size = buffer_size as vk::DeviceSize;
        let full_copy = [vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size,
        }];

        // Update output buffer before being written over
        barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::TRANSFER_WRITE,
            output_buffer.get(),
            size,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
        );

        // Fill command buffer based on buffer commands
        match params.buffer_init_cmd {
            BufferInitCommand::Copy => {
                if !params.is_copy_src_sparse {
                    // Update input buffer before being read in the transfer
                    barrier(
                        vk::AccessFlags::HOST_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        input_buffer.get(),
                        size,
                        vk::PipelineStageFlags::HOST,
                        vk::PipelineStageFlags::TRANSFER,
                    );

                    // Copy input buffer to sparse buffer with copy command
                    unsafe { device.cmd_copy_buffer(*command_buffer, input_buffer.get(), *sparse_buffer, &full_copy) };

                    // Update sparse buffer before being read and verified in the shader
                    barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::SHADER_READ,
                        *sparse_buffer,
                        size,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                    );

                    unsafe {
                        device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
                        device.cmd_bind_descriptor_sets(
                            *command_buffer,
                            vk::PipelineBindPoint::COMPUTE,
                            *pipeline_layout,
                            0,
                            &[descriptor_set.get()],
                            &[] as &[u32],
                        );
                    }

                    {
                        // Push constant data
                        let mut push_constants = Vec::with_capacity(8);
                        push_constants.extend_from_slice(&buffer_size.to_ne_bytes());
                        push_constants.extend_from_slice(&(buffer_mem_requirements.alignment as u32).to_ne_bytes());
                        unsafe {
                            device.cmd_push_constants(
                                *command_buffer,
                                *pipeline_layout,
                                vk::ShaderStageFlags::COMPUTE,
                                0,
                                &push_constants,
                            )
                        };
                    }
                    // Read sparse buffer in the compute shader and output verification result
                    unsafe { device.cmd_dispatch(*command_buffer, 1, 1, 1) };

                    // Update output buffer before being read on the host
                    barrier(
                        vk::AccessFlags::SHADER_WRITE,
                        vk::AccessFlags::HOST_READ,
                        output_test_buffer.get(),
                        output_test_buffer_size_bytes,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::HOST,
                    );
                } else if !params.is_multi_copy {
                    // Update input buffer before being read in the shader
                    barrier(
                        vk::AccessFlags::HOST_WRITE,
                        vk::AccessFlags::SHADER_READ,
                        input_buffer.get(),
                        size,
                        vk::PipelineStageFlags::HOST,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                    );

                    unsafe {
                        device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
                        device.cmd_bind_descriptor_sets(
                            *command_buffer,
                            vk::PipelineBindPoint::COMPUTE,
                            *pipeline_layout,
                            0,
                            &[descriptor_set.get()],
                            &[] as &[u32],
                        );
                    }

                    // Copy input buffer to sparse buffer in the compute shader
                    {
                        let sqrt_size = (buffer_size as f32).sqrt().ceil() as u32;
                        // Spec minimum requirement for maxComputeWorkGroupCount[]
                        assert!(sqrt_size <= 65535);

                        unsafe {
                            device.cmd_push_constants(
                                *command_buffer,
                                *pipeline_layout,
                                vk::ShaderStageFlags::COMPUTE,
                                0,
                                &buffer_size.to_ne_bytes(),
                            );
                            device.cmd_dispatch(*command_buffer, sqrt_size, sqrt_size, 1);
                        }
                    }

                    // Update sparse buffer before being read in the transfer
                    barrier(
                        vk::AccessFlags::SHADER_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        *sparse_buffer,
                        size,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::TRANSFER,
                    );

                    // Copy sparse buffer to output buffer with copy command
                    unsafe { device.cmd_copy_buffer(*command_buffer, *sparse_buffer, output_buffer.get(), &full_copy) };

                    // Update output buffer before being read on the host
                    barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::HOST_READ,
                        output_buffer.get(),
                        size,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                    );
                } else {
                    // MultiCopy case:
                    // Sparse buffer is completely non-resident

                    // Copy multiple small regions of sparse buffer to output buffer with copy command
                    let regions = [
                        vk::BufferCopy {
                            src_offset: 0,
                            dst_offset: 0,
                            size: 4,
                        },
                        vk::BufferCopy {
                            src_offset: 2,
                            dst_offset: 8,
                            size: 4,
                        },
                        vk::BufferCopy {
                            src_offset: 0,
                            dst_offset: 18,
                            size: 4,
                        },
                    ];

                    unsafe { device.cmd_copy_buffer(*command_buffer, *sparse_buffer, output_buffer.get(), &regions) };

                    // Update output buffer before being read on the host
                    barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::HOST_READ,
                        output_buffer.get(),
                        size,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                    );
                }
            }
            BufferInitCommand::Fill => {
                // Fill sparse buffer with fill command
                unsafe { device.cmd_fill_buffer(*command_buffer, *sparse_buffer, 0, size, fill_value) };

                // Update sparse buffer before being read in the transfer
                barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    *sparse_buffer,
                    size,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                );

                // Copy sparse buffer to output buffer with copy command
                unsafe { device.cmd_copy_buffer(*command_buffer, *sparse_buffer, output_buffer.get(), &full_copy) };

                // Update output buffer before being read on the host
                barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    output_buffer.get(),
                    size,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                );
            }
            BufferInitCommand::Update => {
                let chunk_size = 65536u32;

                let mut data_offset = 0u32;
                while data_offset < buffer_size {
                    let mut chunk = chunk_size;

                    if buffer_size - data_offset < chunk_size {
                        chunk = buffer_size - data_offset;
                    }

                    unsafe {
                        device.cmd_update_buffer(
                            *command_buffer,
                            *sparse_buffer,
                            data_offset as vk::DeviceSize,
                            &reference_data[data_offset as usize..(data_offset + chunk) as usize],
                        )
                    };
                    data_offset += chunk_size;
                }

                // Update sparse buffer before being read in the transfer
                barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    *sparse_buffer,
                    size,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                );

                // Copy sparse buffer to output buffer with copy command
                unsafe { device.cmd_copy_buffer(*command_buffer, *sparse_buffer, output_buffer.get(), &full_copy) };

                // Update output buffer before being read on the host
                barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    output_buffer.get(),
                    size,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                );
            }
        }

        // End recording compute and transfer commands
        end_command_buffer(device, *command_buffer)?;

        let wait_stage_bits = [vk::PipelineStageFlags::TRANSFER];

        // Submit transfer commands for execution and wait for completion
        if !params.is_buffer_non_resident {
            submit_commands_and_wait(
                device,
                cmd_queue.handle,
                *command_buffer,
                &[*buffer_memory_bind_semaphore],
                &wait_stage_bits,
                &[],
            )?;
        } else {
            submit_commands_and_wait(device, cmd_queue.handle, *command_buffer, &[], &[], &[])?;
        }

        if params.buffer_init_cmd == BufferInitCommand::Copy && !params.is_copy_src_sparse {
            // Retrieve data from output buffer to host memory
            invalidate_alloc(device, output_test_buffer.get_allocation())?;

            let output_data = unsafe {
                std::ptr::read(
                    output_test_buffer
                        .get_allocation()
                        .get_host_ptr()
                        .cast_const()
                        .cast::<u32>(),
                )
            };

            if output_data == 0 {
                return Ok(TestStatus::fail("Failed"));
            }
        } else if params.buffer_init_cmd == BufferInitCommand::Copy && params.is_multi_copy {
            // Retrieve data from output buffer to host memory
            invalidate_alloc(device, output_buffer.get_allocation())?;

            let output_data = unsafe {
                std::slice::from_raw_parts(
                    output_buffer.get_allocation().get_host_ptr().cast_const(),
                    buffer_size as usize,
                )
            };

            for byte_idx in 0..32u32 {
                let null_mask = 0xFFC3_F0F0u32;
                let result_value = output_data[byte_idx as usize] as u32;
                let has_value = null_mask & (1 << byte_idx) != 0;
                let reference_value = if has_value { 0xFF } else { 0x00 };

                if !params.with_strict_residency && !has_value {
                    continue;
                }

                if result_value != reference_value {
                    return Ok(TestStatus::fail("Failed"));
                }
            }
        } else {
            // Retrieve data from output buffer to host memory
            invalidate_alloc(device, output_buffer.get_allocation())?;

            let output_data = unsafe {
                std::slice::from_raw_parts(
                    output_buffer.get_allocation().get_host_ptr().cast_const(),
                    buffer_size as usize,
                )
            };

            // Compare output data with reference data
            if !params.is_buffer_non_resident {
                for sparse_bind_ndx in 0..num_sparse_slots {
                    let alignment = buffer_mem_requirements.alignment as u32;
                    let offset = (alignment * sparse_bind_ndx) as usize;
                    let chunk = (if sparse_bind_ndx == num_sparse_slots - 1 {
                        buffer_size % alignment
                    } else {
                        alignment
                    }) as usize;

                    if sparse_bind_ndx % 2 == 0 {
                        if params.buffer_init_cmd == BufferInitCommand::Fill {
                            reference_data[offset..offset + chunk].fill((fill_value & 0xFF) as u8);
                        }

                        if reference_data[offset..offset + chunk] != output_data[offset..offset + chunk] {
                            return Ok(TestStatus::fail("Failed"));
                        }
                    } else if params.with_strict_residency {
                        reference_data[offset..offset + chunk].fill(0);

                        if reference_data[offset..offset + chunk] != output_data[offset..offset + chunk] {
                            return Ok(TestStatus::fail("Failed"));
                        }
                    }
                }
            } else if params.with_strict_residency {
                // Compare full buffer
                reference_data.fill(0);
                if reference_data != output_data {
                    return Ok(TestStatus::fail("Failed"));
                }
            }
        }

        drop(device_memory);
        Ok(TestStatus::pass("Passed"))
    }
}

/// `addBufferSparseResidencyTests`
pub fn add_buffer_sparse_residency_tests(group: &mut TestCaseGroup) {
    for (name, shift) in [
        ("buffer_size_2_10", 10),
        ("buffer_size_2_12", 12),
        ("buffer_size_2_16", 16),
        ("buffer_size_2_17", 17),
        ("buffer_size_2_20", 20),
        ("buffer_size_2_24", 24),
    ] {
        group.add_child(Box::new(BufferSparseResidencyCase {
            name: name.to_string(),
            buffer_size: 1 << shift,
        }) as Box<dyn TestCase>);
    }

    // Tests different reads/writes with sparse buffers that are partially resident or not resident at all
    for buffer_init_cmd in [
        BufferInitCommand::Copy,
        BufferInitCommand::Fill,
        BufferInitCommand::Update,
    ] {
        for buffer_size in [1u32 << 10, 1 << 16, 1 << 24] {
            for strict_residency in [true, false] {
                for buffer_non_residency in [true, false] {
                    let mut test_params = TestParams {
                        buffer_init_cmd,
                        with_strict_residency: strict_residency,
                        is_buffer_non_resident: buffer_non_residency,
                        buffer_size,
                        is_copy_src_sparse: true,
                        is_multi_copy: false,
                    };

                    let test_name_p1 = format!(
                        "non_resident_buffer_{}{}",
                        if strict_residency { "strict_" } else { "" },
                        buffer_init_cmd.name()
                    );
                    let test_name_p2 = format!(
                        "_alloc_{}_{}",
                        if buffer_non_residency { "none" } else { "partial" },
                        buffer_size
                    );
                    {
                        let test_name = format!(
                            "{test_name_p1}{}{test_name_p2}",
                            if buffer_init_cmd == BufferInitCommand::Copy {
                                "_src"
                            } else {
                                ""
                            }
                        );
                        group.add_child(Box::new(BufferSparseResidencyNonResidentCase {
                            name: test_name,
                            test_params,
                        }) as Box<dyn TestCase>);
                    }

                    if !strict_residency {
                        continue;
                    }

                    if buffer_init_cmd == BufferInitCommand::Copy {
                        test_params.is_copy_src_sparse = false; // sparse buffer is destination of copy
                        let test_name = format!("{test_name_p1}_dest{test_name_p2}");

                        group.add_child(Box::new(BufferSparseResidencyNonResidentCase {
                            name: test_name,
                            test_params,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }

    // Test multiple small aligned and unaligned copies from sparse buffer
    for strict_residency in [true, false] {
        let test_params = TestParams {
            buffer_init_cmd: BufferInitCommand::Copy,
            with_strict_residency: strict_residency,
            is_buffer_non_resident: true,
            buffer_size: 1 << 16,
            is_copy_src_sparse: true,
            is_multi_copy: true,
        };

        let test_name = format!(
            "non_resident_buffer{}_multi_{}",
            if strict_residency { "_strict" } else { "" },
            BufferInitCommand::Copy.name()
        );

        group.add_child(Box::new(BufferSparseResidencyNonResidentCase {
            name: test_name,
            test_params,
        }) as Box<dyn TestCase>);
    }
}

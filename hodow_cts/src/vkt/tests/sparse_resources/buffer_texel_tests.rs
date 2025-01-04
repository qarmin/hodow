// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferSparseResidency.cpp (TexelBufferSparseResidencyCase,
//   TexelBufferSparseResidencyInstance, addTexelBufferSparseResidencyTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are `shaders/manifest/sparse_resources_texel_buffer.toml`
// (scripts/gen_sparse_texel_buffer_manifest.py), picked by (buffer type, operation, format).
//
// A sparse residency texel buffer with every other block backed by memory is filled by a copy and read by a compute shader through
// texelFetch/imageLoad, or through OpImageSparseFetch/OpImageSparseRead whose residency code is written out.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{NO_MATCH_FOUND, find_matching_memory_type, make_sparse_memory_bind, submit_commands_and_wait};
use super::texel_programs::programs_for;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE_OF_UINT_IN_SHADER: u32 = 4;
const SIZE_OF_UINT64_IN_SHADER: u32 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TexelBufferType {
    Uniform,
    Storage,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TexelBufferOperation {
    SparseFetch,
    SparseRead,
    Read,
}

fn format_is_r64(format: vk::Format) -> bool {
    format == vk::Format::R64_UINT || format == vk::Format::R64_SINT
}

/// `tcu::getPixelSize` of the formats these tests use
fn pixel_size(format: vk::Format) -> u32 {
    if format_is_r64(format) { 8 } else { 4 }
}

struct TexelBufferSparseResidencyCase {
    name: String,
    format: vk::Format,
    buffer_size: u32,
    buffer_type: TexelBufferType,
    is_buffer_non_resident_strict: bool,
    texel_buffer_op: TexelBufferOperation,
}

impl TexelBufferSparseResidencyCase {
    fn program_name(&self) -> String {
        format!(
            "{}_{}_{}",
            if self.buffer_type == TexelBufferType::Uniform {
                "uniform"
            } else {
                "storage"
            },
            match self.texel_buffer_op {
                TexelBufferOperation::SparseFetch => "sparse_fetch",
                TexelBufferOperation::SparseRead => "sparse_read",
                TexelBufferOperation::Read => "read",
            },
            if format_is_r64(self.format) { "r64" } else { "r32" }
        )
    }
}

impl TestCase for TexelBufferSparseResidencyCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TexelBufferSparseResidencyCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let max_device_texels = context.get_device_properties().limits.max_texel_buffer_elements;
        let num_texels = self.buffer_size / pixel_size(self.format);

        let features = context.get_device_features();
        if features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature sparseBinding not supported".to_string(),
            ));
        }
        if features.sparse_residency_buffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature sparseResidencyBuffer not supported".to_string(),
            ));
        }

        if matches!(
            self.texel_buffer_op,
            TexelBufferOperation::SparseFetch | TexelBufferOperation::SparseRead
        ) && features.shader_resource_residency == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Core feature shaderResourceResidency not supported".to_string(),
            ));
        }

        let buffer_features =
            unsafe { instance.get_physical_device_format_properties(physical_device, self.format) }.buffer_features;
        if self.buffer_type == TexelBufferType::Uniform
            && !buffer_features.contains(vk::FormatFeatureFlags::UNIFORM_TEXEL_BUFFER)
        {
            return Err(TestError::NotSupported(
                "Format not supported for uniform texel buffers".to_string(),
            ));
        }
        if self.buffer_type == TexelBufferType::Storage
            && !buffer_features.contains(vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER)
        {
            return Err(TestError::NotSupported(
                "Format not supported for storage texel buffers".to_string(),
            ));
        }

        if num_texels > max_device_texels {
            return Err(TestError::NotSupported(
                "maxTexelBufferElements not large enough".to_string(),
            ));
        }

        if format_is_r64(self.format) {
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;

            let mut atomic_int64 = vk::PhysicalDeviceShaderAtomicInt64Features::default();
            let mut image_atomic_int64 = vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                    .push_next(&mut atomic_int64)
                    .push_next(&mut image_atomic_int64);
                unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            }

            if features.shader_int64 == vk::FALSE || atomic_int64.shader_buffer_int64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "64-bit integers not supported in shaders".to_string(),
                ));
            }

            if image_atomic_int64.shader_image_int64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderImageInt64Atomics is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        programs_for(&self.program_name()).unwrap_or_else(|| BinaryCollection::new(&[]))
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TexelBufferSparseResidencyInstance {
            context,
            buffer_size: self.buffer_size,
            buffer_type: self.buffer_type,
            is_buffer_non_resident_strict: self.is_buffer_non_resident_strict,
            texel_buffer_op: self.texel_buffer_op,
            format: self.format,
        })
    }
}

struct TexelBufferSparseResidencyInstance<'a> {
    context: &'a Context<'a>,
    buffer_size: u32,
    buffer_type: TexelBufferType,
    is_buffer_non_resident_strict: bool,
    texel_buffer_op: TexelBufferOperation,
    format: vk::Format,
}

impl TestInstance for TexelBufferSparseResidencyInstance<'_> {
    /// `TexelBufferSparseResidencyInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let buffer_size = self.buffer_size;
        let is_format_64b = format_is_r64(self.format);

        // Create a logical device supporting both sparse and compute operations
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

        if self.is_buffer_non_resident_strict
            && physical_device_properties
                .sparse_properties
                .residency_non_resident_strict
                == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Sparse buffers property residencyNonResidentStrict not supported".to_string(),
            ));
        }

        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);

        let is_texel_uniform_buffer = self.buffer_type == TexelBufferType::Uniform;
        let buffer_usage_flags = if is_texel_uniform_buffer {
            vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
        };

        let queue_family_indices = [sparse_queue.family_index, compute_queue.family_index];
        let mut buffer_create_info = vk::BufferCreateInfo::builder()
            .flags(vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_RESIDENCY)
            .size(vk::DeviceSize::from(buffer_size))
            .usage(vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC | buffer_usage_flags)
            .sharing_mode(vk::SharingMode::EXCLUSIVE);
        if sparse_queue.family_index != compute_queue.family_index {
            buffer_create_info = buffer_create_info
                .sharing_mode(vk::SharingMode::CONCURRENT)
                .queue_family_indices(&queue_family_indices);
        }

        // Create the sparse buffer
        let sparse_buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
        );

        // Create the sparse buffer memory bind semaphore
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
                buffer_mem_requirements.alignment * vk::DeviceSize::from(sparse_bind_ndx),
                vk::SparseMemoryBindFlags::empty(),
            )?;
            device_memory.push(Unique::new(device, sparse_memory_bind.memory));
            sparse_memory_binds.push(sparse_memory_bind);
        }

        {
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

        // Wait for the sparse queue to become idle
        unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        // Create the input buffer
        let input_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                vk::DeviceSize::from(buffer_size),
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let unit_size = pixel_size(self.format);
        let num_of_workgroups = buffer_size / unit_size;

        let max_compute_work_group_count = context.get_device_properties().limits.max_compute_work_group_count;
        if num_of_workgroups > max_compute_work_group_count[0] {
            return Err(TestError::NotSupported(
                "Compute workgroup count not supported".to_string(),
            ));
        }

        let mut reference_data: Vec<u8> = (0..buffer_size).map(|i| ((i % 255) + 1) as u8).collect();

        unsafe {
            std::ptr::copy_nonoverlapping(
                reference_data.as_ptr(),
                input_buffer.get_allocation().get_host_ptr(),
                buffer_size as usize,
            )
        };
        flush_alloc(device, input_buffer.get_allocation())?;

        // Create a texel buffer view
        let sparse_buffer_view = Unique::new(
            device,
            unsafe {
                device.create_buffer_view(
                    &vk::BufferViewCreateInfo::builder()
                        .buffer(*sparse_buffer)
                        .format(self.format)
                        .offset(0)
                        .range(vk::DeviceSize::from(buffer_size)),
                    None,
                )
            }
            .vk_check("vkCreateBufferView")?,
        );

        // Create the output buffer
        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                vk::DeviceSize::from(buffer_size),
                vk::BufferUsageFlags::STORAGE_BUFFER
                    | vk::BufferUsageFlags::TRANSFER_SRC
                    | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Initialize the output buffer with all 0xFF
        {
            let allocation = output_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(allocation.get_host_ptr(), 0xFF, buffer_size as usize) };
            flush_alloc(device, allocation)?;
        }

        // Create a command buffer for compute and data transfer operations
        let command_pool = make_command_pool(device, compute_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        begin_command_buffer(device, cmd)?;

        // Create a barrier to update the input before it is copied (read)
        {
            let input_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                input_buffer.get(),
                0,
                vk::DeviceSize::from(buffer_size),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[input_buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                )
            };
        }

        // Copy the initial data to the sparse buffer
        let copy_region = vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: vk::DeviceSize::from(buffer_size),
        };
        unsafe { device.cmd_copy_buffer(cmd, input_buffer.get(), *sparse_buffer, &[copy_region]) };

        // Now bind the buffer as a uniform/storage texel buffer in a descriptor set
        let descriptor_type = if is_texel_uniform_buffer {
            vk::DescriptorType::UNIFORM_TEXEL_BUFFER
        } else {
            vk::DescriptorType::STORAGE_TEXEL_BUFFER
        };

        // Create the descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        // Create the compute pipeline
        let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(-1)
            .build();
        let compute_pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(descriptor_type, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        {
            let output_buffer_info = vk::DescriptorBufferInfo {
                buffer: output_buffer.get(),
                offset: 0,
                range: vk::DeviceSize::from(buffer_size),
            };
            let texel_buffer_view = *sparse_buffer_view;
            let writes = [
                vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: descriptor_set.get(),
                    dst_binding: 0,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type,
                    image_info: std::ptr::null(),
                    buffer_info: std::ptr::null(),
                    texel_buffer_view: &texel_buffer_view,
                },
                vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: descriptor_set.get(),
                    dst_binding: 1,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                    image_info: std::ptr::null(),
                    buffer_info: &output_buffer_info,
                    texel_buffer_view: std::ptr::null(),
                },
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            )
        };

        {
            let sparse_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                *sparse_buffer,
                0,
                vk::DeviceSize::from(buffer_size),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[sparse_buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                )
            };
        }

        unsafe { device.cmd_dispatch(cmd, num_of_workgroups, 1, 1) };

        {
            let output_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer.get(),
                0,
                vk::DeviceSize::from(buffer_size),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[output_buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                )
            };
        }

        end_command_buffer(device, cmd)?;

        // Submit the commands for execution and wait for completion
        submit_commands_and_wait(
            device,
            compute_queue.handle,
            cmd,
            &[*buffer_memory_bind_semaphore],
            &[vk::PipelineStageFlags::COMPUTE_SHADER],
            &[],
        )?;

        // Retrieve the data from the output buffer to host memory
        let output_allocation = output_buffer.get_allocation();
        invalidate_alloc(device, output_allocation)?;
        let output_data =
            unsafe { std::slice::from_raw_parts(output_allocation.get_host_ptr().cast_const(), buffer_size as usize) };

        let alignment = buffer_mem_requirements.alignment as u32;
        let slot_range = |sparse_bind_ndx: u32| -> (usize, usize) {
            let offset = alignment * sparse_bind_ndx;
            let size = if sparse_bind_ndx == num_sparse_slots - 1 {
                buffer_size % alignment
            } else {
                alignment
            };
            (offset as usize, size as usize)
        };

        if self.texel_buffer_op == TexelBufferOperation::Read {
            // Compare the output data with the reference data
            for sparse_bind_ndx in 0..num_sparse_slots {
                let (offset, size) = slot_range(sparse_bind_ndx);

                if sparse_bind_ndx % 2 == 0 {
                    // Bound memory region
                    if reference_data[offset..offset + size] != output_data[offset..offset + size] {
                        return Ok(TestStatus::fail("Failed"));
                    }
                } else if self.is_buffer_non_resident_strict {
                    // Unbound memory region
                    reference_data[offset..offset + size].fill(0);
                    if reference_data[offset..offset + size] != output_data[offset..offset + size] {
                        return Ok(TestStatus::fail("Failed"));
                    }
                }
            }
        } else {
            // Compare the output residency status
            for sparse_bind_ndx in 0..num_sparse_slots {
                let (offset, size) = slot_range(sparse_bind_ndx);

                let output_block_size = if is_format_64b {
                    SIZE_OF_UINT64_IN_SHADER
                } else {
                    SIZE_OF_UINT_IN_SHADER
                } as usize;
                let output_blocks = size / output_block_size;
                let mut output_block_offset = offset;
                for _ in 0..output_blocks {
                    let resident = sparse_bind_ndx % 2 == 0;
                    let expected: Vec<u8> = if is_format_64b {
                        u64::from(resident).to_ne_bytes().to_vec()
                    } else {
                        u32::from(resident).to_ne_bytes().to_vec()
                    };
                    if expected != output_data[output_block_offset..output_block_offset + output_block_size] {
                        return Ok(TestStatus::fail("Failed"));
                    }

                    output_block_offset += output_block_size;
                }
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `addTexelBufferSparseResidencyTests`
pub fn add_texel_buffer_sparse_residency_tests(group: &mut TestCaseGroup) {
    let formats = [vk::Format::R32_UINT, vk::Format::R64_UINT];
    let texel_buffer_names = ["uniform_texel_buffer", "storage_texel_buffer"];
    let texel_op_names = ["sparse_fetch", "sparse_read", "read"];
    let format_ids = ["r32ui", "r64ui"];

    for (tex_buff_type_idx, tex_buff_type) in [TexelBufferType::Uniform, TexelBufferType::Storage]
        .into_iter()
        .enumerate()
    {
        for (tex_op_idx, texel_buffer_op) in [
            TexelBufferOperation::SparseFetch,
            TexelBufferOperation::SparseRead,
            TexelBufferOperation::Read,
        ]
        .into_iter()
        .enumerate()
        {
            if (tex_buff_type == TexelBufferType::Uniform && texel_buffer_op == TexelBufferOperation::SparseRead)
                || (tex_buff_type == TexelBufferType::Storage && texel_buffer_op == TexelBufferOperation::SparseFetch)
            {
                continue;
            }

            for buffer_size in [10u32, 16, 24] {
                for (fmt_idx, &format) in formats.iter().enumerate() {
                    for is_buffer_non_resident_strict in [true, false] {
                        if tex_buff_type == TexelBufferType::Uniform && format_is_r64(format) {
                            continue;
                        }

                        let test_name = format!(
                            "{}_{}_size_2_{}_{}{}",
                            texel_buffer_names[tex_buff_type_idx],
                            texel_op_names[tex_op_idx],
                            buffer_size,
                            format_ids[fmt_idx],
                            if is_buffer_non_resident_strict { "_strict" } else { "" }
                        );

                        group.add_child(Box::new(TexelBufferSparseResidencyCase {
                            name: test_name,
                            format,
                            buffer_size: 1 << buffer_size,
                            buffer_type: tex_buff_type,
                            is_buffer_non_resident_strict,
                            texel_buffer_op,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }
}

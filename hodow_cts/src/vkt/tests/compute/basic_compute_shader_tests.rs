// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeBasicComputeShaderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
// Vendored original: hodow_cts/upstream/modules/vulkan/compute/
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The structure follows the upstream file closely on purpose: one TestCase +
// TestInstance pair per test, `check_support` / `programs` / `create_instance`
// in that order, and `iterate` doing the same operations in the same sequence with
// the same names. That is what keeps this file diffable against the C++ when the
// upstream one changes.
//
// Parameters are NOT written here: they come from `generated::shaders`, which the
// manifest generates. `MultiQueueRunnerTestInstance` is also not ported - upstream
// uses it to repeat a case on every compute-capable queue, which is a separate
// dimension from what these cases check, so they run on the universal queue only.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::compute_basic;
use crate::tcu::{self, IVec3, Random, TestError, TestOutcome, TestStatus, UVec3, multiply_components};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool, make_descriptor_buffer_info, make_descriptor_set,
    make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// `squared()` from the anonymous namespace at the top of the upstream file.
fn squared(a: i32) -> u32 {
    (a * a) as u32
}

// ---------------------------------------------------------------------------------
// EmptyShaderTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct EmptyShaderCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for EmptyShaderCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EmptyShaderInstance { context })
    }
}

struct EmptyShaderInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for EmptyShaderInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.build_pipeline()?;

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands

        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);

        let work_groups = IVec3::new(1, 1, 1);
        unsafe { vk.cmd_dispatch(*cmd_buffer, work_groups.x() as u32, work_groups.y() as u32, work_groups.z() as u32) };

        end_command_buffer(vk, *cmd_buffer)?;

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// SharedVarTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct SharedVarCase {
    pub name: &'static str,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub programs: BinaryCollection,
}

impl TestCase for SharedVarCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SharedVarInstance {
            context,
            local_size: self.local_size,
            work_size: self.work_size,
        })
    }
}

struct SharedVarInstance<'a> {
    context: &'a Context<'a>,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestInstance for SharedVarInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        let work_group_size = multiply_components(self.local_size);
        let work_group_count = multiply_components(self.work_size);

        // Create a buffer and host-visible memory for it

        let buffer_size_bytes = (std::mem::size_of::<u32>() as i32 * work_group_size * work_group_count) as u64;
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &descriptor_info)
            .update(vk);

        // Perform the computation

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let compute_finish_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, buffer.get(), 0, buffer_size_bytes);

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands

        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[compute_finish_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results

        let buffer_allocation = buffer.get_allocation();
        invalidate_alloc(vk, buffer_allocation)?;

        let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();

        for group_ndx in 0..work_group_count {
            let global_offset = group_ndx * work_group_size;
            for local_offset in 0..work_group_size {
                let res = unsafe { *buffer_ptr.add((global_offset + local_offset) as usize) };
                let reference = global_offset as u32 + squared(work_group_size - local_offset - 1);

                if res != reference {
                    return Ok(TestStatus::fail(format!("Comparison failed for Output.values[{}]", global_offset + local_offset)));
                }
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// BufferToBufferInvertTest (CopyInvertSSBOCase)
// ---------------------------------------------------------------------------------

/// `BufferType` from the anonymous namespace at the top of the upstream file.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum BufferType {
    /// `BUFFER_TYPE_UNIFORM`
    Uniform,
    /// `BUFFER_TYPE_SSBO`
    Ssbo,
}

#[derive(Clone, Copy)]
pub struct BufferToBufferInvertCase {
    pub name: &'static str,
    pub buffer_type: BufferType,
    pub num_values: u32,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub random_seed: u32,
    pub programs: BinaryCollection,
}

impl TestCase for BufferToBufferInvertCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)?;
        // The 64-bit-indexing and robustness2 branches of the upstream checkSupport
        // belong to the copy_ssbo_64b* / copy_ssbo_bounds cases, which are not ported.
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferToBufferInvertInstance {
            context,
            buffer_type: self.buffer_type,
            num_values: self.num_values,
            work_size: self.work_size,
            random_seed: self.random_seed,
        })
    }
}

struct BufferToBufferInvertInstance<'a> {
    context: &'a Context<'a>,
    buffer_type: BufferType,
    num_values: u32,
    work_size: IVec3,
    random_seed: u32,
}

impl TestInstance for BufferToBufferInvertInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // The buffer holds a UVec4 per value even though only .x is used - upstream
        // does the same, and the padding is part of what the shader indexes over.
        let buffer_size_bytes = (std::mem::size_of::<tcu::UVec4>() as u64) * self.num_values as u64;

        // Customize the test based on buffer type

        let input_buffer_usage_flags = match self.buffer_type {
            BufferType::Uniform => vk::BufferUsageFlags::UNIFORM_BUFFER,
            BufferType::Ssbo => vk::BufferUsageFlags::STORAGE_BUFFER,
        };
        let input_buffer_descriptor_type = match self.buffer_type {
            BufferType::Uniform => vk::DescriptorType::UNIFORM_BUFFER,
            BufferType::Ssbo => vk::DescriptorType::STORAGE_BUFFER,
        };

        // Create an input buffer

        let input_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, input_buffer_usage_flags),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill the input buffer with data
        let mut input_values: Vec<tcu::UVec4> = Vec::with_capacity(self.num_values as usize);
        {
            let mut rnd = Random::new(self.random_seed);
            for _ in 0..self.num_values {
                input_values.push(tcu::UVec4::new(rnd.get_uint32(), 0, 0, 0));
            }

            let input_buffer_allocation = input_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    input_values.as_ptr().cast::<u8>(),
                    input_buffer_allocation.get_host_ptr(),
                    std::mem::size_of_val(input_values.as_slice()),
                );
            }
            flush_alloc(vk, input_buffer_allocation)?;
        }

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Create an output buffer

        let output_buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
        let output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, output_buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Prefill with a pattern the shader must overwrite. Upstream does this so a
        // shader that writes nothing fails loudly instead of reading back zeroes that
        // happen to match.
        begin_command_buffer(vk, *cmd_buffer)?;
        unsafe { vk.cmd_fill_buffer(*cmd_buffer, output_buffer.get(), 0, buffer_size_bytes, 0xBEBEBEBE) };
        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion
        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(input_buffer_descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(input_buffer_descriptor_type, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let input_range = vk::WHOLE_SIZE;
        let output_range = vk::WHOLE_SIZE;

        let input_buffer_descriptor_info = make_descriptor_buffer_info(input_buffer.get(), 0, input_range);
        let output_buffer_descriptor_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_range);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), input_buffer_descriptor_type, &input_buffer_descriptor_info)
            .write_single(*descriptor_set, Location::binding(1), vk::DescriptorType::STORAGE_BUFFER, &output_buffer_descriptor_info)
            .update(vk);

        // Perform the computation

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let host_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::SHADER_READ, input_buffer.get(), 0, buffer_size_bytes);

        let shader_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, output_buffer.get(), 0, buffer_size_bytes);

        // Start recording commands
        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results
        let output_buffer_allocation = output_buffer.get_allocation();
        invalidate_alloc(vk, output_buffer_allocation)?;

        let buffer_ptr = output_buffer_allocation.get_host_ptr().cast::<tcu::UVec4>();

        for ndx in 0..self.num_values {
            let res = unsafe { (*buffer_ptr.add(ndx as usize)).x() };
            let reference = !input_values[ndx as usize].x();

            if res != reference {
                return Ok(TestStatus::fail(format!("Comparison failed for Output.values[{ndx}]")));
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// SSBOBarrierTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct SsboBarrierCase {
    pub name: &'static str,
    pub work_size: IVec3,
    pub base_value: u32,
    pub programs: BinaryCollection,
}

impl TestCase for SsboBarrierCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SsboBarrierInstance {
            context,
            work_size: self.work_size,
            base_value: self.base_value,
        })
    }
}

struct SsboBarrierInstance<'a> {
    context: &'a Context<'a>,
    work_size: IVec3,
    base_value: u32,
}

impl TestInstance for SsboBarrierInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // Create a work buffer used by both shaders

        let work_group_count = multiply_components(self.work_size);
        let work_buffer_size_bytes = (std::mem::size_of::<u32>() as i32 * work_group_count) as u64;
        let work_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(work_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::ANY,
        )?;

        // Create an output buffer

        let output_buffer_size_bytes = std::mem::size_of::<u32>() as u64;
        let output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(output_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Initialize atomic counter value to zero
        {
            let output_buffer_allocation = output_buffer.get_allocation();
            unsafe { *output_buffer_allocation.get_host_ptr().cast::<u32>() = 0 };
            flush_alloc(vk, output_buffer_allocation)?;
        }

        // Create a uniform buffer (to pass uniform constants)

        let uniform_buffer_size_bytes = std::mem::size_of::<u32>() as u64;
        let uniform_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(uniform_buffer_size_bytes, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Set the constants in the uniform buffer

        let base_value = self.base_value;
        {
            let uniform_buffer_allocation = uniform_buffer.get_allocation();
            unsafe { *uniform_buffer_allocation.get_host_ptr().cast::<u32>() = base_value };
            flush_alloc(vk, uniform_buffer_allocation)?;
        }

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let work_buffer_descriptor_info = make_descriptor_buffer_info(work_buffer.get(), 0, work_buffer_size_bytes);
        let output_buffer_descriptor_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_buffer_size_bytes);
        let uniform_buffer_descriptor_info = make_descriptor_buffer_info(uniform_buffer.get(), 0, uniform_buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &output_buffer_descriptor_info)
            .write_single(*descriptor_set, Location::binding(1), vk::DescriptorType::STORAGE_BUFFER, &work_buffer_descriptor_info)
            .write_single(*descriptor_set, Location::binding(2), vk::DescriptorType::UNIFORM_BUFFER, &uniform_buffer_descriptor_info)
            .update(vk);

        // Perform the computation

        let mut pipeline0 = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp0")?);
        pipeline0.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline0.build_pipeline()?;

        let mut pipeline1 = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp1")?);
        pipeline1.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline1.build_pipeline()?;

        let write_uniform_constants_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::UNIFORM_READ,
            uniform_buffer.get(),
            0,
            uniform_buffer_size_bytes,
        );

        let between_shaders_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::SHADER_READ, work_buffer.get(), 0, work_buffer_size_bytes);

        let after_compute_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, output_buffer.get(), 0, output_buffer_size_bytes);

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands

        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline0.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline0.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[write_uniform_constants_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[between_shaders_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        // Switch to the second shader program
        pipeline1.bind(*cmd_buffer);

        unsafe {
            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[after_compute_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results

        let output_buffer_allocation = output_buffer.get_allocation();
        invalidate_alloc(vk, output_buffer_allocation)?;

        let res = unsafe { *output_buffer_allocation.get_host_ptr().cast::<u32>() };
        let mut reference: u32 = 0;

        for ndx in 0..work_group_count {
            reference += base_value + ndx as u32;
        }

        if res != reference {
            return Ok(TestStatus::fail(format!("ERROR: comparison failed, expected {reference}, got {res}")));
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// SharedVarAtomicOpTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct SharedVarAtomicOpCase {
    pub name: &'static str,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub programs: BinaryCollection,
}

impl TestCase for SharedVarAtomicOpCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SharedVarAtomicOpInstance {
            context,
            local_size: self.local_size,
            work_size: self.work_size,
        })
    }
}

struct SharedVarAtomicOpInstance<'a> {
    context: &'a Context<'a>,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestInstance for SharedVarAtomicOpInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        let work_group_size = multiply_components(self.local_size);
        let work_group_count = multiply_components(self.work_size);

        // Create a buffer and host-visible memory for it

        let buffer_size_bytes = (std::mem::size_of::<u32>() as i32 * work_group_size * work_group_count) as u64;
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &descriptor_info)
            .update(vk);

        // Perform the computation

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let compute_finish_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, buffer.get(), 0, buffer_size_bytes);

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands

        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[compute_finish_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results

        let buffer_allocation = buffer.get_allocation();
        invalidate_alloc(vk, buffer_allocation)?;

        let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();

        for group_ndx in 0..work_group_count {
            let global_offset = group_ndx * work_group_size;
            for local_offset in 0..work_group_size {
                let res = unsafe { *buffer_ptr.add((global_offset + local_offset) as usize) };
                let reference = (local_offset + 1) as u32;

                if res != reference {
                    return Ok(TestStatus::fail(format!("Comparison failed for Output.values[{}]", global_offset + local_offset)));
                }
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// SSBOLocalBarrierTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct SsboLocalBarrierCase {
    pub name: &'static str,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub programs: BinaryCollection,
}

impl TestCase for SsboLocalBarrierCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SsboLocalBarrierInstance {
            context,
            local_size: self.local_size,
            work_size: self.work_size,
        })
    }
}

struct SsboLocalBarrierInstance<'a> {
    context: &'a Context<'a>,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestInstance for SsboLocalBarrierInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        let work_group_size = multiply_components(self.local_size);
        let work_group_count = multiply_components(self.work_size);

        // Create a buffer and host-visible memory for it

        let buffer_size_bytes = (std::mem::size_of::<u32>() as i32 * work_group_size * work_group_count) as u64;
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &descriptor_info)
            .update(vk);

        // Perform the computation

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let compute_finish_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, buffer.get(), 0, buffer_size_bytes);

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands

        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[compute_finish_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results

        let buffer_allocation = buffer.get_allocation();
        invalidate_alloc(vk, buffer_allocation)?;

        let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();

        for group_ndx in 0..work_group_count {
            let global_offset = group_ndx * work_group_size;
            for local_offset in 0..work_group_size {
                let res = unsafe { *buffer_ptr.add((global_offset + local_offset) as usize) };
                let offs0 = if local_offset - 1 < 0 {
                    (local_offset + work_group_size - 1) % work_group_size
                } else {
                    (local_offset - 1) % work_group_size
                };
                let offs1 = if local_offset - 2 < 0 {
                    (local_offset + work_group_size - 2) % work_group_size
                } else {
                    (local_offset - 2) % work_group_size
                };
                let reference = (global_offset + offs0 + offs1) as u32;

                if res != reference {
                    return Ok(TestStatus::fail(format!("Comparison failed for Output.values[{}]", global_offset + local_offset)));
                }
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// InvertSSBOInPlaceTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct InvertSsboInPlaceCase {
    pub name: &'static str,
    pub num_values: u32,
    pub sized: bool,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub programs: BinaryCollection,
}

impl TestCase for InvertSsboInPlaceCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InvertSsboInPlaceInstance {
            context,
            num_values: self.num_values,
            work_size: self.work_size,
        })
    }
}

struct InvertSsboInPlaceInstance<'a> {
    context: &'a Context<'a>,
    num_values: u32,
    work_size: IVec3,
}

impl TestInstance for InvertSsboInPlaceInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // Create an input/output buffer

        let buffer_size_bytes = std::mem::size_of::<u32>() as u64 * self.num_values as u64;
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill the buffer with data

        let mut input_data: Vec<u32> = Vec::with_capacity(self.num_values as usize);
        {
            let mut rnd = Random::new(0x82ce7f);
            let buffer_allocation = buffer.get_allocation();
            let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();
            for i in 0..self.num_values {
                let value = rnd.get_uint32();
                input_data.push(value);
                unsafe { *buffer_ptr.add(i as usize) = value };
            }
            flush_alloc(vk, buffer_allocation)?;
        }

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &descriptor_info)
            .update(vk);

        // Perform the computation

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let host_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::SHADER_READ, buffer.get(), 0, buffer_size_bytes);

        let shader_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, buffer.get(), 0, buffer_size_bytes);

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands

        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results

        let buffer_allocation = buffer.get_allocation();
        invalidate_alloc(vk, buffer_allocation)?;

        let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();

        for ndx in 0..self.num_values {
            let res = unsafe { *buffer_ptr.add(ndx as usize) };
            let reference = !input_data[ndx as usize];

            if res != reference {
                return Ok(TestStatus::fail(format!("Comparison failed for InOut.values[{ndx}]")));
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// WriteToMultipleSSBOTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct WriteToMultipleSsboCase {
    pub name: &'static str,
    pub num_values: u32,
    pub sized: bool,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub programs: BinaryCollection,
}

impl TestCase for WriteToMultipleSsboCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(WriteToMultipleSsboInstance {
            context,
            num_values: self.num_values,
            work_size: self.work_size,
        })
    }
}

struct WriteToMultipleSsboInstance<'a> {
    context: &'a Context<'a>,
    num_values: u32,
    work_size: IVec3,
}

impl TestInstance for WriteToMultipleSsboInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // Create two output buffers

        let buffer_size_bytes = std::mem::size_of::<u32>() as u64 * self.num_values as u64;
        let buffer0 = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer1 = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let buffer0_descriptor_info = make_descriptor_buffer_info(buffer0.get(), 0, buffer_size_bytes);
        let buffer1_descriptor_info = make_descriptor_buffer_info(buffer1.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &buffer0_descriptor_info)
            .write_single(*descriptor_set, Location::binding(1), vk::DescriptorType::STORAGE_BUFFER, &buffer1_descriptor_info)
            .update(vk);

        // Perform the computation

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let shader_write_barriers = [
            make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, buffer0.get(), 0, buffer_size_bytes),
            make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, buffer1.get(), 0, buffer_size_bytes),
        ];

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands

        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &shader_write_barriers,
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results

        {
            let buffer0_allocation = buffer0.get_allocation();
            invalidate_alloc(vk, buffer0_allocation)?;

            let buffer0_ptr = buffer0_allocation.get_host_ptr().cast::<u32>();

            for ndx in 0..self.num_values {
                let res = unsafe { *buffer0_ptr.add(ndx as usize) };
                let reference = ndx;

                if res != reference {
                    return Ok(TestStatus::fail(format!("Comparison failed for Out0.values[{ndx}] res={res} ref={reference}")));
                }
            }
        }
        {
            let buffer1_allocation = buffer1.get_allocation();
            invalidate_alloc(vk, buffer1_allocation)?;

            let buffer1_ptr = buffer1_allocation.get_host_ptr().cast::<u32>();

            for ndx in 0..self.num_values {
                let res = unsafe { *buffer1_ptr.add(ndx as usize) };
                let reference = self.num_values - ndx;

                if res != reference {
                    return Ok(TestStatus::fail(format!("Comparison failed for Out1.values[{ndx}] res={res} ref={reference}")));
                }
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// EmptyWorkGroupCase
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct EmptyWorkGroupCase {
    pub name: &'static str,
    pub dispatch_size: UVec3,
    pub programs: BinaryCollection,
}

impl TestCase for EmptyWorkGroupCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        debug_assert!(self.dispatch_size.x() == 0 || self.dispatch_size.y() == 0 || self.dispatch_size.z() == 0);
        Box::new(EmptyWorkGroupInstance {
            context,
            dispatch_size: self.dispatch_size,
        })
    }
}

struct EmptyWorkGroupInstance<'a> {
    context: &'a Context<'a>,
    dispatch_size: UVec3,
}

impl TestInstance for EmptyWorkGroupInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vkd = self.context.get_device();
        let alloc = self.context.get_default_allocator();
        let queue_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();

        let verif_buffer_size = std::mem::size_of::<u32>() as u64;
        let verif_buffer_info = make_buffer_create_info(verif_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER);
        let verif_buffer = BufferWithMemory::new(vkd, alloc, verif_buffer_info, MemoryRequirement::HOST_VISIBLE)?;
        let verif_buffer_alloc = verif_buffer.get_allocation();
        unsafe { *verif_buffer_alloc.get_host_ptr().cast::<u32>() = 0 };
        flush_alloc(vkd, verif_buffer_alloc)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vkd)?;

        let mut pipeline = ComputePipelineWrapper::new(vkd, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vkd, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vkd, *descriptor_pool, *descriptor_set_layout)?;

        let verif_buffer_desc_info = make_descriptor_buffer_info(verif_buffer.get(), 0, verif_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &verif_buffer_desc_info)
            .update(vkd);

        let cmd_pool = make_command_pool(vkd, queue_index)?;
        let cmd_buffer = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(vkd, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vkd.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            // The dispatch that must do nothing: one dimension is zero.
            vkd.cmd_dispatch(*cmd_buffer, self.dispatch_size.x(), self.dispatch_size.y(), self.dispatch_size.z());

            let read_write_access = vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::SHADER_READ;
            let compute_to_compute = make_memory_barrier(read_write_access, read_write_access);
            vkd.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[compute_to_compute],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            // The one that must run, contributing the single expected increment.
            vkd.cmd_dispatch(*cmd_buffer, 1, 1, 1);

            let compute_to_host = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            vkd.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[compute_to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vkd, *cmd_buffer)?;
        submit_commands_and_wait(vkd, queue, *cmd_buffer)?;

        invalidate_alloc(vkd, verif_buffer_alloc)?;
        let value = unsafe { *verif_buffer_alloc.get_host_ptr().cast::<u32>() };

        if value != 1 {
            return Ok(TestStatus::fail(format!("Unexpected value found in buffer: {value} while expecting 1")));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// MaxWorkGroupSizeTest
// ---------------------------------------------------------------------------------

/// `MaxWorkGroupSizeTest::Axis`
#[derive(Clone, Copy)]
pub enum Axis {
    X,
    Y,
    Z,
}

impl Axis {
    /// `MaxWorkGroupSizeTest::getIndex`
    fn get_index(self) -> usize {
        match self {
            Self::X => 0,
            Self::Y => 1,
            Self::Z => 2,
        }
    }
}

/// `MaxWorkGroupSizeTest::getInvocations`
fn get_invocations(axis: Axis, properties: &vk::PhysicalDeviceProperties) -> u32 {
    properties.limits.max_compute_work_group_size[axis.get_index()]
}

/// `MaxWorkGroupSizeTest::getSSBOSize`
fn get_ssbo_size(invocations: u32) -> u32 {
    invocations * std::mem::size_of::<u32>() as u32
}

#[derive(Clone, Copy)]
pub struct MaxWorkGroupSizeCase {
    pub name: &'static str,
    pub axis: Axis,
    pub programs: BinaryCollection,
}

impl TestCase for MaxWorkGroupSizeCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let properties = context.get_device_properties();
        let invocations = get_invocations(self.axis, properties);

        if invocations > properties.limits.max_compute_work_group_invocations {
            // TCU_FAIL, i.e. the driver is inconsistent about its own limits. There is
            // no TestStatus to return from check_support, so it becomes an error that
            // the runner turns into a verdict.
            return Err(TestError::InternalError(
                "Reported workgroup size limit in the axis is greater than the global invocation limit".to_string(),
            ));
        }

        if properties.limits.max_storage_buffer_range / (std::mem::size_of::<u32>() as u32) < invocations {
            return Err(TestError::NotSupported("Maximum supported storage buffer range too small".to_string()));
        }

        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MaxWorkGroupSizeInstance { context, axis: self.axis })
    }
}

struct MaxWorkGroupSizeInstance<'a> {
    context: &'a Context<'a>,
    axis: Axis,
}

impl TestInstance for MaxWorkGroupSizeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vkd = self.context.get_device();
        let alloc = self.context.get_default_allocator();
        let queue_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();

        let axis = self.axis.get_index();
        let invocations = get_invocations(self.axis, self.context.get_device_properties());
        let ssbo_size = get_ssbo_size(invocations) as u64;

        log::info!("Running test with {invocations} invocations on axis {axis} using a storage buffer size of {ssbo_size} bytes");

        // Main SSBO buffer.
        let ssbo_info = make_buffer_create_info(ssbo_size, vk::BufferUsageFlags::STORAGE_BUFFER);
        let ssbo = BufferWithMemory::new(vkd, alloc, ssbo_info, MemoryRequirement::HOST_VISIBLE)?;

        // Descriptor set layouts.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vkd)?;

        // Specialization constants: set the number of invocations in the appropriate local size id.
        let entry_size = std::mem::size_of::<i32>() as u32;
        let mut specialization_data = [1i32, 1, 1];
        specialization_data[axis] = invocations as i32;

        let specialization_maps = vec![
            vk::SpecializationMapEntry {
                constant_id: 0,
                offset: 0,
                size: entry_size as usize,
            },
            vk::SpecializationMapEntry {
                constant_id: 1,
                offset: entry_size,
                size: entry_size as usize,
            },
            vk::SpecializationMapEntry {
                constant_id: 2,
                offset: entry_size * 2,
                size: entry_size as usize,
            },
        ];
        let specialization_bytes = specialization_data.iter().flat_map(|v| v.to_ne_bytes()).collect::<Vec<u8>>();

        let mut test_pipeline = ComputePipelineWrapper::new(vkd, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        test_pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        test_pipeline.set_specialization_info(specialization_maps, specialization_bytes);
        test_pipeline.build_pipeline()?;

        // Create descriptor pool and set.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vkd, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vkd, *descriptor_pool, *descriptor_set_layout)?;

        // Update descriptor set.
        let ssbo_buffer_info = make_descriptor_buffer_info(ssbo.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &ssbo_buffer_info)
            .update(vkd);

        // Clear buffer.
        let ssbo_alloc = ssbo.get_allocation();
        unsafe { std::ptr::write_bytes(ssbo_alloc.get_host_ptr(), 0, ssbo_size as usize) };
        flush_alloc(vkd, ssbo_alloc)?;

        let cmd_pool = make_command_pool(vkd, queue_index)?;
        let cmd_buffer = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(vkd, *cmd_buffer)?;

        // Run the main test shader.
        let host_to_compute_barrier = make_buffer_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::SHADER_WRITE, ssbo.get(), 0, vk::WHOLE_SIZE);
        unsafe {
            vkd.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_to_compute_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        test_pipeline.bind(*cmd_buffer);
        unsafe {
            vkd.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, test_pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);
            vkd.cmd_dispatch(*cmd_buffer, 1, 1, 1);

            let compute_to_host_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, ssbo.get(), 0, vk::WHOLE_SIZE);
            vkd.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[compute_to_host_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vkd, *cmd_buffer)?;
        submit_commands_and_wait(vkd, queue, *cmd_buffer)?;

        // Verify buffer contents.
        invalidate_alloc(vkd, ssbo_alloc)?;
        let values_ptr = ssbo_alloc.get_host_ptr().cast::<u32>();

        for i in 0..invocations {
            let value = unsafe { *values_ptr.add(i as usize) };
            if value != 1 {
                return Ok(TestStatus::fail(format!("Found invalid value for invocation index {i}: expected 1u and found {value}")));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// createBasicComputeShaderTests
// ---------------------------------------------------------------------------------

/// `createBasicComputeShaderTests`
///
/// Registration order matches upstream, because both binaries execute in this order
/// and a diff of the two result files is easier to read when they agree on it.
pub fn create_basic_compute_shader_tests(construction_type: ComputePipelineConstructionType) -> tcu::TestCaseGroup {
    debug_assert_eq!(construction_type, ComputePipelineConstructionType::Pipeline);

    let mut basic_compute_tests = tcu::TestCaseGroup::new("basic");

    let mut add = |case: Box<dyn TestCase>| {
        basic_compute_tests.add_child(case);
    };

    // Shader that does nothing
    add(Box::new(compute_basic::EMPTY_SHADER));

    // ConcurrentCompute is not ported: it needs several queues at once.

    // Use an empty workgroup with size 0 on the X / Y / Z / all axes
    add(Box::new(compute_basic::EMPTY_WORKGROUP_X));
    add(Box::new(compute_basic::EMPTY_WORKGROUP_Y));
    add(Box::new(compute_basic::EMPTY_WORKGROUP_Z));
    add(Box::new(compute_basic::EMPTY_WORKGROUP_ALL));

    // Use the maximum work group size on each axis
    add(Box::new(compute_basic::MAX_LOCAL_SIZE_X));
    add(Box::new(compute_basic::MAX_LOCAL_SIZE_Y));
    add(Box::new(compute_basic::MAX_LOCAL_SIZE_Z));

    add(Box::new(compute_basic::UBO_TO_SSBO_SINGLE_INVOCATION));
    add(Box::new(compute_basic::UBO_TO_SSBO_SINGLE_GROUP));
    add(Box::new(compute_basic::UBO_TO_SSBO_MULTIPLE_INVOCATIONS));
    add(Box::new(compute_basic::UBO_TO_SSBO_MULTIPLE_GROUPS));

    add(Box::new(compute_basic::COPY_SSBO_SINGLE_INVOCATION));
    add(Box::new(compute_basic::COPY_SSBO_MULTIPLE_INVOCATIONS));
    add(Box::new(compute_basic::COPY_SSBO_MULTIPLE_GROUPS));
    // copy_ssbo_bounds needs VK_EXT_robustness2 and a custom device; not ported.

    // Read and write same SSBO
    add(Box::new(compute_basic::SSBO_RW_SINGLE_INVOCATION));
    add(Box::new(compute_basic::SSBO_RW_MULTIPLE_GROUPS));
    add(Box::new(compute_basic::SSBO_UNSIZED_ARR_SINGLE_INVOCATION));
    add(Box::new(compute_basic::SSBO_UNSIZED_ARR_MULTIPLE_GROUPS));

    // Write to multiple SSBOs
    add(Box::new(compute_basic::WRITE_MULTIPLE_ARR_SINGLE_INVOCATION));
    add(Box::new(compute_basic::WRITE_MULTIPLE_ARR_MULTIPLE_GROUPS));
    add(Box::new(compute_basic::WRITE_MULTIPLE_UNSIZED_ARR_SINGLE_INVOCATION));
    add(Box::new(compute_basic::WRITE_MULTIPLE_UNSIZED_ARR_MULTIPLE_GROUPS));

    // read_unbound_ssbo needs a partially bound descriptor; not ported.

    // SSBO local barrier usage
    add(Box::new(compute_basic::SSBO_LOCAL_BARRIER_SINGLE_INVOCATION));
    add(Box::new(compute_basic::SSBO_LOCAL_BARRIER_SINGLE_GROUP));
    add(Box::new(compute_basic::SSBO_LOCAL_BARRIER_MULTIPLE_GROUPS));

    // SSBO memory barrier usage
    add(Box::new(compute_basic::SSBO_CMD_BARRIER_SINGLE));
    add(Box::new(compute_basic::SSBO_CMD_BARRIER_MULTIPLE));

    // Basic shared variable usage
    add(Box::new(compute_basic::SHARED_VAR_SINGLE_INVOCATION));
    add(Box::new(compute_basic::SHARED_VAR_SINGLE_GROUP));
    add(Box::new(compute_basic::SHARED_VAR_MULTIPLE_INVOCATIONS));
    add(Box::new(compute_basic::SHARED_VAR_MULTIPLE_GROUPS));

    // Atomic operation with shared var
    add(Box::new(compute_basic::SHARED_ATOMIC_OP_SINGLE_INVOCATION));
    add(Box::new(compute_basic::SHARED_ATOMIC_OP_SINGLE_GROUP));
    add(Box::new(compute_basic::SHARED_ATOMIC_OP_MULTIPLE_INVOCATIONS));
    add(Box::new(compute_basic::SHARED_ATOMIC_OP_MULTIPLE_GROUPS));

    // Image to SSBO copy, SSBO to image copy. image_atomic_op and image_barrier are
    // not ported yet, nor are the Amber-driven cases.
    super::basic_compute_image_tests::add_basic_compute_image_tests(&mut basic_compute_tests);

    basic_compute_tests
}

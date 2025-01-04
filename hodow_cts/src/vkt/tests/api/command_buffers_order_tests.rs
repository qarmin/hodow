// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCommandBuffersTests.cpp (`orderBindPipelineTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A compute pipeline that writes zeros is bound and immediately replaced by the one that writes
// the uniform colours; the dispatch must run the second. Upstream's layout also binds a second, unused uniform buffer, which is left out here.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::api_command_buffers::ORDER_BIND_PIPELINE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Allocate a lot more than required.
const ADDRESSABLE_SIZE: vk::DeviceSize = 256;

struct OrderBindPipelineCase;

impl TestCase for OrderBindPipelineCase {
    fn name(&self) -> &str {
        "order_bind_pipeline"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ORDER_BIND_PIPELINE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OrderBindPipelineInstance { context })
    }
}

struct OrderBindPipelineInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for OrderBindPipelineInstance<'_> {
    /// `orderBindPipelineTest`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        // `ComputeInstanceResultBuffer`: four vec4 filled with -1 so an unwritten buffer shows.
        let result_size = 4 * 16;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let words = result_buffer.get_allocation().get_host_ptr() as *mut f32;
            for i in 0..16 {
                words.add(i).write(-1.0);
            }
        }
        flush_alloc(device, result_buffer.get_allocation())?;

        let color_a1: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
        let color_a2: [f32; 4] = [1.0, 1.0, 0.0, 1.0];

        // `createColorDataBuffer`: the two colours of the uniform block at the start of a larger buffer.
        let buffer_a = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(ADDRESSABLE_SIZE, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let words = buffer_a.get_allocation().get_host_ptr() as *mut f32;
            for i in 0..(ADDRESSABLE_SIZE as usize / 4) {
                words.add(i).write(0.0);
            }
            std::ptr::copy_nonoverlapping(color_a1.as_ptr(), words, 4);
            std::ptr::copy_nonoverlapping(color_a2.as_ptr(), words.add(4), 4);
        }
        flush_alloc(device, buffer_a.get_allocation())?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let result_info = make_descriptor_buffer_info(result_buffer.get(), 0, vk::WHOLE_SIZE);
        let uniform_info = make_descriptor_buffer_info(buffer_a.get(), 0, ADDRESSABLE_SIZE);
        let writes = [
            vk::WriteDescriptorSet {
                dst_set: *descriptor_set,
                dst_binding: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                buffer_info: &result_info,
                ..Default::default()
            },
            vk::WriteDescriptorSet {
                dst_set: *descriptor_set,
                dst_binding: 1,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::UNIFORM_BUFFER,
                buffer_info: &uniform_info,
                ..Default::default()
            },
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let set_layouts = [*set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let module_good = create_shader_module(device, binaries.get("compute_good")?)?;
        let module_bad = create_shader_module(device, binaries.get("compute_bad")?)?;
        let make_pipeline = |module: vk::ShaderModule| -> Result<Unique<'_, vk::Pipeline>, TestError> {
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(module)
                .name(b"main\0")
                .build();
            let info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0);
            let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateComputePipelines")?;
            Ok(Unique::new(device, pipelines.0[0]))
        };
        let pipeline_good = make_pipeline(*module_good)?;
        let pipeline_bad = make_pipeline(*module_bad)?;

        let pre_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::UNIFORM_READ,
            buffer_a.get(),
            0,
            ADDRESSABLE_SIZE,
        );
        let post_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            result_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;
        unsafe {
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::COMPUTE, *pipeline_bad);
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::COMPUTE, *pipeline_good);
            device.cmd_bind_descriptor_sets(
                *cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[pre_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_dispatch(*cmd, 4, 1, 1);
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[post_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let results =
            unsafe { std::slice::from_raw_parts(result_buffer.get_allocation().get_host_ptr() as *const [f32; 4], 4) };

        // The two outer quadrants take the second colour, the two inner ones the first.
        let references = [color_a2, color_a1, color_a1, color_a2];
        if results == references {
            Ok(TestStatus::pass("Pass"))
        } else if results.iter().all(|color| *color == [-1.0; 4]) {
            Ok(TestStatus::fail("Result buffer was not written to"))
        } else {
            Ok(TestStatus::fail(format!(
                "Invalid result values: expected {references:?}, got {results:?}"
            )))
        }
    }
}

/// `secondary_on_transfer_queue`: a buffer copy recorded in a secondary command buffer and executed from a primary on the transfer queue, with a
/// staging buffer so that a barrier sits between the primary's copy and the secondary's.
struct SecondariesXferQueueCase;

impl TestCase for SecondariesXferQueueCase {
    fn name(&self) -> &str {
        "secondary_on_transfer_queue"
    }

    /// `SecondariesXferQueueCheckSupport`: getTransferQueue() throws if there is none.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context
            .get_transfer_queue()
            .map(|_| ())
            .ok_or_else(|| TestError::NotSupported("no transfer queue".to_string()))
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[] as &'static [crate::vk::programs::ProgramBinary])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SecondariesXferQueueInstance { context })
    }
}

struct SecondariesXferQueueInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for SecondariesXferQueueInstance<'_> {
    /// `SecondariesXferQueueRun`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let (queue, qf_index) = context
            .get_transfer_queue()
            .ok_or_else(|| TestError::NotSupported("no transfer queue".to_string()))?;

        let cmd_pool = make_command_pool(device, qf_index)?;
        let primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

        let src: [f32; 4] = [1.0, 2.0, 3.0, 4.0];
        let buffer_size = std::mem::size_of_val(&src) as vk::DeviceSize;
        let src_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                src.as_ptr().cast::<u8>(),
                src_buffer.get_allocation().get_host_ptr(),
                buffer_size as usize,
            )
        };
        flush_alloc(device, src_buffer.get_allocation())?;

        // We could transfer directly from the source buffer to the destination buffer, but this staging buffer allows a barrier in between that
        // happens to be problematic for some drivers.
        let staging_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                buffer_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;
        let dst_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let region = vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: buffer_size,
        };

        // Staging to final buffer in the secondary.
        let inheritance_info = vk::CommandBufferInheritanceInfo::default();
        let secondary_begin_info = vk::CommandBufferBeginInfo::builder().inheritance_info(&inheritance_info);
        unsafe {
            device
                .begin_command_buffer(*secondary, &secondary_begin_info)
                .vk_check("vkBeginCommandBuffer")?;
            device.cmd_copy_buffer(*secondary, staging_buffer.get(), dst_buffer.get(), &[region]);
        }
        end_command_buffer(device, *secondary)?;

        // Source to staging in the primary, barrier and execution of the secondary.
        begin_command_buffer(device, *primary)?;
        let copy_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ);
        let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_copy_buffer(*primary, src_buffer.get(), staging_buffer.get(), &[region]);
            device.cmd_pipeline_barrier(
                *primary,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[copy_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_execute_commands(*primary, &[*secondary]);
            device.cmd_pipeline_barrier(
                *primary,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *primary)?;
        submit_commands_and_wait(device, queue, *primary)?;

        invalidate_alloc(device, dst_buffer.get_allocation())?;
        let dst = unsafe { std::ptr::read_unaligned(dst_buffer.get_allocation().get_host_ptr() as *const [f32; 4]) };
        if src != dst {
            return Ok(TestStatus::fail(format!("Expected {src:?} but found {dst:?}")));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `order_bind_pipeline` and `secondary_on_transfer_queue`
pub fn add_order_bind_pipeline_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(OrderBindPipelineCase) as Box<dyn TestCase>);
    group.add_child(Box::new(SecondariesXferQueueCase) as Box<dyn TestCase>);
}

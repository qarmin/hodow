// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmFromHlslTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The HLSL source is in `shaders/manifest/spirv_assembly_hlsl.toml` (stage `hlsl_comp`).

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::spirv_assembly_hlsl::ALL_HLSL_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one `HlslTestInstance` (only `TT_CBUFFER_PACKING` exists).
#[derive(Clone, Copy)]
pub struct HlslCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for HlslCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_scalar_block_layout")
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(HlslTest { context })
    }
}

struct HlslTest<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for HlslTest<'_> {
    /// `HlslTest::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let test_value = 5i32;

        // the input buffer: a 2 element array with a 16 byte stride
        let in_buffer_size_bytes = 32usize;
        let in_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                in_buffer_size_bytes as vk::DeviceSize,
                vk::BufferUsageFlags::UNIFORM_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // The first attribute is an array that has a 16 byte stride, so the second attribute has to start at offset 20 (4 + 16)
        unsafe {
            let buffer_ptr = in_buffer.get_allocation().get_host_ptr();
            std::ptr::write_bytes(buffer_ptr, 0, in_buffer_size_bytes);
            std::ptr::write_unaligned(buffer_ptr.cast::<i32>().add(5), test_value);
        }
        flush_alloc(device, in_buffer.get_allocation())?;

        let out_buffer_size_bytes = std::mem::size_of::<i32>();
        let out_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                out_buffer_size_bytes as vk::DeviceSize,
                vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // the descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let input_buffer_descriptor_info =
            make_descriptor_buffer_info(in_buffer.get(), 0, in_buffer_size_bytes as vk::DeviceSize);
        let output_buffer_descriptor_info =
            make_descriptor_buffer_info(out_buffer.get(), 0, out_buffer_size_bytes as vk::DeviceSize);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::UNIFORM_BUFFER,
                &input_buffer_descriptor_info,
            )
            .write_single(
                descriptor_set.get(),
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &output_buffer_descriptor_info,
            )
            .update(device);

        // the computation
        let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );
        let host_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_READ,
            in_buffer.get(),
            0,
            in_buffer_size_bytes as vk::DeviceSize,
        );
        let shader_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            out_buffer.get(),
            0,
            out_buffer_size_bytes as vk::DeviceSize,
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // validate the results
        invalidate_alloc(device, out_buffer.get_allocation())?;
        let value = unsafe { std::ptr::read_unaligned(out_buffer.get_allocation().get_host_ptr().cast::<i32>()) };
        Ok(if value == test_value {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `createHlslComputeGroup`: the group `hlsl_cases` below `compute`, then the case.
pub fn create_hlsl_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_HLSL_CASE
        .iter()
        .map(|case| (vec!["hlsl_cases"], Box::new(**case) as Box<dyn TestCase>))
        .collect()
}

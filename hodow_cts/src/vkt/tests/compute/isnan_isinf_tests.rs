// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/compute/float16_isnan_isinf.amber
//   external/vulkancts/data/vulkan/amber/compute/float64_isnan_isinf.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The three Amber pipelines of a script (the same shader over a NaN, over the bits 0x7f800000 and over a zero) are three
// dispatches of one pipeline with a different first buffer; after each, the result buffer must hold 1, 1 and 0. The shaders are written by
// `scripts/gen_compute_isnan_isinf_amber.py`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::compute_isnan_isinf::{FLOAT16_ISNAN_ISINF, FLOAT64_ISNAN_ISINF};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Width {
    Float16,
    Float64,
}

struct IsnanIsinfCase {
    width: Width,
}

impl TestCase for IsnanIsinfCase {
    fn name(&self) -> &str {
        match self.width {
            Width::Float16 => "float16_isnan_isinf",
            Width::Float64 => "float64_isnan_isinf",
        }
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.width {
            Width::Float16 => {
                let mut features12 = vk::PhysicalDeviceVulkan12Features::default();
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features12);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
                if features12.shader_float16 == vk::FALSE {
                    return Err(TestError::NotSupported("shaderFloat16 not supported".to_string()));
                }
            }
            Width::Float64 => {
                if context.get_device_features().shader_float64 == vk::FALSE {
                    return Err(TestError::NotSupported("shaderFloat64 not supported".to_string()));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.width {
            Width::Float16 => FLOAT16_ISNAN_ISINF.programs,
            Width::Float64 => FLOAT64_ISNAN_ISINF.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IsnanIsinfInstance { context })
    }
}

struct IsnanIsinfInstance<'a> {
    context: &'a Context<'a>,
}

fn word_buffer<'a>(context: &'a Context<'_>, value: u32) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(4, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(value.to_ne_bytes().as_ptr(), buffer.get_allocation().get_host_ptr(), 4) };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

impl TestInstance for IsnanIsinfInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        // nan_buffer (a float NaN), inf_buffer (0x7f800000), zero_buffer, each followed by the expected result
        let inputs = [(f32::NAN.to_bits(), 1u32), (0x7f800000u32, 1), (0, 0)];
        let result_buffer = word_buffer(context, 0)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE, 0, 1)
            .add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE, 1, 1)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("comp")?)?;
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
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        for (input, expected) in inputs {
            let input_buffer = word_buffer(context, input)?;
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
            let input_info = vk::DescriptorBufferInfo {
                buffer: input_buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            let result_info = vk::DescriptorBufferInfo {
                buffer: result_buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    descriptor_set.get(),
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &input_info,
                )
                .write_single(
                    descriptor_set.get(),
                    Location::binding(1),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &result_info,
                )
                .update(device);

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
                device.cmd_dispatch(cmd, 1, 1, 1);
                let barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .build();
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

            invalidate_alloc(device, result_buffer.get_allocation())?;
            let result =
                unsafe { std::ptr::read(result_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>()) };
            // EXPECT result_buffer IDX 0 EQ expected
            if result != expected {
                log::error!("The input {input:#x} gave {result}, expected {expected}");
                return Ok(TestStatus::fail("Probe failed"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The two `*_isnan_isinf` cases of `compute.pipeline.basic`
pub fn create_isnan_isinf_cases() -> Vec<Box<dyn TestCase>> {
    vec![
        Box::new(IsnanIsinfCase { width: Width::Float16 }),
        Box::new(IsnanIsinfCase { width: Width::Float64 }),
    ]
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineSpecConstantTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2023 LunarG, Inc.
// Copyright (c) 2023 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `spec_constant.compute.unaligned_spec_constant` and `.same_id`: two compute shaders written
// in SPIR-V assembly (`shaders/manifest/pipeline_spec_constant_asm.toml`), each specialized from a raw byte vector through map entries that
// do not line up with the constants' sizes (or share one SpecId) and checked against values computed on the host.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_spec_constant_asm::{SAME_ID, UNALIGNED_SPEC_CONSTANT};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    Unaligned,
    SameId,
}

pub struct SpecConstantAsmCase {
    kind: Kind,
}

impl SpecConstantAsmCase {
    pub fn unaligned() -> Self {
        Self { kind: Kind::Unaligned }
    }

    pub fn same_id() -> Self {
        Self { kind: Kind::SameId }
    }
}

impl TestCase for SpecConstantAsmCase {
    fn name(&self) -> &str {
        "test"
    }

    /// `unalignedSpecConstantCheckSupport` and `sameIdSpecConstantCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.kind == Kind::SameId {
            return Ok(());
        }

        context.require_device_functionality("VK_KHR_shader_float16_int8")?;
        let mut float16_int8 = vk::PhysicalDeviceShaderFloat16Int8Features::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut float16_int8);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if float16_int8.shader_int8 == vk::FALSE {
            return Err(TestError::NotSupported("shaderInt8 not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::Unaligned => UNALIGNED_SPEC_CONSTANT.programs,
            Kind::SameId => SAME_ID.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SpecConstantAsmInstance {
            context,
            kind: self.kind,
        })
    }
}

struct SpecConstantAsmInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

/// The dispatch both tests share: a storage buffer with `initial_data`, bound for a compute pipeline specialized with the given entries and data.
fn run_compute<'a>(
    context: &'a Context<'a>,
    buffer_size: vk::DeviceSize,
    initial_data: Option<&[u8]>,
    entries: &[vk::SpecializationMapEntry],
    specialization_data: &[u8],
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();

    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    if let Some(initial_data) = initial_data {
        unsafe {
            std::ptr::copy_nonoverlapping(
                initial_data.as_ptr(),
                buffer.get_allocation().get_host_ptr(),
                initial_data.len(),
            )
        };
        flush_alloc(device, buffer.get_allocation())?;
    }

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

    let descriptor_buffer_info = vk::DescriptorBufferInfo {
        buffer: buffer.get(),
        offset: 0,
        range: vk::WHOLE_SIZE,
    };
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &descriptor_buffer_info,
        )
        .update(device);

    let binaries = context.get_binary_collection();
    let comp_shader = create_shader_module(device, binaries.get("comp")?)?;

    let specialization_info = vk::SpecializationInfo::builder()
        .map_entries(entries)
        .data(specialization_data);
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*comp_shader)
        .name(b"main\0")
        .specialization_info(&specialization_info);
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*pipeline_layout)
        .base_pipeline_handle(vk::Pipeline::null())
        .base_pipeline_index(0);
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
        .vk_check("vkCreateComputePipelines")?;
    let pipeline = Unique::new(device, pipelines.0[0]);

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
        device.cmd_dispatch(cmd, 1, 1, 1);
        let barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer.get(),
            0,
            buffer_size,
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// `unalignedSpecConstantTest`
fn unaligned_spec_constant_test(context: &Context<'_>) -> TestOutcome {
    let output_data = [0u32; 5];
    let initial_bytes: Vec<u8> = output_data.iter().flat_map(|value| value.to_ne_bytes()).collect();

    let input_data: [u8; 8] = [1, 2, 3, 4, 5, 6, 7, 8];
    let specialization_entries = [
        // constant id, offset, size; see input_data.
        vk::SpecializationMapEntry {
            constant_id: 0,
            offset: 1,
            size: 1,
        }, // Byte values: 2
        vk::SpecializationMapEntry {
            constant_id: 1,
            offset: 1,
            size: 4,
        }, // Byte values: 2,3,4,5
        vk::SpecializationMapEntry {
            constant_id: 3,
            offset: 2,
            size: 4,
        }, // Byte values: 3,4,5,6
        vk::SpecializationMapEntry {
            constant_id: 4,
            offset: 3,
            size: 4,
        }, // Byte values: 4,5,6,7
        vk::SpecializationMapEntry {
            constant_id: 5,
            offset: 3,
            size: 1,
        }, // Byte values: 4
    ];

    let buffer = run_compute(
        context,
        initial_bytes.len() as vk::DeviceSize,
        Some(&initial_bytes),
        &specialization_entries,
        &input_data,
    )?;

    // Calculate reference values.
    let mut reference = [0u32; 5];
    for (i, entry) in specialization_entries.iter().enumerate() {
        let offset = entry.offset as usize;
        reference[i] = if entry.size == 1 {
            u32::from(input_data[offset])
        } else {
            u32::from_ne_bytes([
                input_data[offset],
                input_data[offset + 1],
                input_data[offset + 2],
                input_data[offset + 3],
            ])
        };
    }

    // Compare with output values.
    let result =
        unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast::<u32>(), output_data.len()) };
    if result != reference {
        return Ok(TestStatus::fail(format!(
            "Unexpected results found in output buffer: expected {reference:#x?} but found {result:#x?}"
        )));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `sameIdSpecConstantTest`
fn same_id_spec_constant_test(context: &Context<'_>) -> TestOutcome {
    #[repr(C)]
    #[derive(Clone, Copy)]
    struct Output {
        a: f32,
        b: i32,
        c: u32,
        padding: u32,
    }

    let input_data: u32 = 1024 * 1024 * 1024 + 31;
    let write_index = ((input_data % 1024) + (input_data % 1024)) as usize;

    let buffer_size = (1024 * 1024 * std::mem::size_of::<Output>()) as vk::DeviceSize;
    let entries = [vk::SpecializationMapEntry {
        constant_id: 0,
        offset: 0,
        size: 4,
    }];
    let buffer = run_compute(context, buffer_size, None, &entries, &input_data.to_ne_bytes())?;

    let output =
        unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast::<Output>(), 1024 * 1024) };
    let result = output[write_index];

    let expected_float = f32::from_bits(input_data);
    let expected_int = input_data as i32;
    let epsilon = 1.0e-6f32;

    if (result.a - expected_float).abs() > epsilon || result.b != expected_int || result.c != input_data {
        return Ok(TestStatus::fail(format!(
            "Unexpected data: expected (a: {expected_float}, b: {expected_int}, c: {input_data}) but found (a: {}, b: {}, c: {})",
            result.a, result.b, result.c
        )));
    }
    Ok(TestStatus::pass("Pass"))
}

impl TestInstance for SpecConstantAsmInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::Unaligned => unaligned_spec_constant_test(self.context),
            Kind::SameId => same_id_spec_constant_test(self.context),
        }
    }
}

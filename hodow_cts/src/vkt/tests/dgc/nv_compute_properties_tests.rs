// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCPropertyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are the ones of the EXT property tests (`shaders/manifest/dgc_properties.toml`,
// `prop_pc_index`: store a value at an index, both push constants) and `preprocess_store_pc` of the EXT preprocess tests (store one push constant).
//
// `dgc.nv.misc.properties` (VK_NV_device_generated_commands): every limit of `VkPhysicalDeviceDeviceGeneratedCommandsPropertiesNV` is exercised
// with a compute sequence that uses it at (or near) its maximum, plus the check of the required ranges.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, NvDeviceGeneratedCommandsExtensionDeviceCommands};

use crate::generated::shaders::dgc_compute_preprocess::ALL_SHARED_PROGRAM as STORE_PC_PROGRAMS;
use crate::generated::shaders::dgc_properties::ALL_SHARED_PROGRAM as PROPERTY_PROGRAMS;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, OffsetParams, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier, make_pipeline_layout_with_push_constants,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::dgc::util_nv::{
    GeneratedCommandsInfoNv, IndirectCommandsLayoutBuilderNv, PreprocessBufferNv, check_dgc_compute_support,
    check_dgc_support, create_compute_pipeline, make_indirect_commands_stream_nv,
};
use crate::vkt::{Context, TestCase, TestInstance};

const STAGE_FLAGS: vk::ShaderStageFlags = vk::ShaderStageFlags::COMPUTE;
const BIND_POINT: vk::PipelineBindPoint = vk::PipelineBindPoint::COMPUTE;

#[derive(Clone, Copy, PartialEq, Eq)]
enum AlignmentType {
    /// Check minSequencesCountBufferOffsetAlignment
    CountBuffer,
    /// Check minSequencesIndexBufferOffsetAlignment
    IndexBuffer,
}

#[derive(Clone, Copy)]
enum Variant {
    ValidLimits,
    MaxTokenCount,
    MaxStreamCount,
    MaxTokenOffset,
    MaxStreamStride,
    MinBufferOffsetAlignment(u32),
    MinSequencesOffsetAlignment(AlignmentType),
}

struct PropertyCase {
    name: String,
    variant: Variant,
}

fn dgc_properties(context: &Context<'_>) -> vk::PhysicalDeviceDeviceGeneratedCommandsPropertiesNV {
    let mut properties = vk::PhysicalDeviceDeviceGeneratedCommandsPropertiesNV::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties
}

impl TestCase for PropertyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.variant {
            Variant::ValidLimits => check_dgc_support(context),
            Variant::MinBufferOffsetAlignment(offset) => {
                check_dgc_compute_support(context, false, false)?;
                if offset
                    % dgc_properties(context)
                        .min_indirect_commands_buffer_offset_alignment
                        .max(1)
                    != 0
                {
                    return Err(TestError::NotSupported(
                        "Requested offset not a multiple of minIndirectCommandsBufferOffsetAlignment".to_string(),
                    ));
                }
                Ok(())
            }
            _ => check_dgc_compute_support(context, false, false),
        }
    }

    fn programs(&self) -> BinaryCollection {
        let (programs, wanted) = match self.variant {
            Variant::ValidLimits => return BinaryCollection::new(&[]),
            Variant::MaxStreamStride | Variant::MinSequencesOffsetAlignment(_) => {
                (&PROPERTY_PROGRAMS[..], "prop_pc_index")
            }
            _ => (&STORE_PC_PROGRAMS[..], "preprocess_store_pc"),
        };
        programs
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PropertyInstance {
            context,
            variant: self.variant,
        })
    }
}

struct PropertyInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
}

/// The output buffer, descriptor set, pipeline layout and compute pipeline every test of the group uses.
struct Fixture<'a> {
    output_buffer: BufferWithMemory<'a>,
    descriptor_set: UniqueDescriptorSet<'a>,
    _descriptor_pool: Unique<'a, vk::DescriptorPool>,
    _set_layout: Unique<'a, vk::DescriptorSetLayout>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pipeline: Unique<'a, vk::Pipeline>,
    _module: Unique<'a, vk::ShaderModule>,
    pc_range: vk::PushConstantRange,
}

impl<'a> Fixture<'a> {
    fn new(context: &'a Context<'a>, output_values: &[u32], pc_size: u32) -> Result<Self, TestError> {
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let output_buffer_size = std::mem::size_of_val(output_values) as vk::DeviceSize;

        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = output_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    output_values.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    output_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, STAGE_FLAGS)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                desc_type,
                &output_buffer_desc_info,
            )
            .update(device);

        let pc_range = vk::PushConstantRange {
            stage_flags: STAGE_FLAGS,
            offset: 0,
            size: pc_size,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let binaries = context.get_binary_collection();
        let module = create_shader_module(device, binaries.get("comp")?)?;
        let pipeline = create_compute_pipeline(device, *pipeline_layout, *module, 0)?;
        Ok(Self {
            output_buffer,
            descriptor_set,
            _descriptor_pool: descriptor_pool,
            _set_layout: set_layout,
            pipeline_layout,
            pipeline,
            _module: module,
            pc_range,
        })
    }

    /// Records, submits and waits for one `vkCmdExecuteGeneratedCommandsNV` of `info` and returns the output buffer words.
    fn execute(
        &self,
        context: &Context<'_>,
        info: &GeneratedCommandsInfoNv,
        word_count: usize,
    ) -> Result<Vec<u32>, TestError> {
        let device = context.get_device();
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                BIND_POINT,
                *self.pipeline_layout,
                0,
                &[self.descriptor_set.get()],
                &[],
            );
            device.cmd_bind_pipeline(cmd_buffer, BIND_POINT, *self.pipeline);
            device.cmd_execute_generated_commands_nv(cmd_buffer, false, info.get());
        }
        {
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;

        let alloc = self.output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        // SAFETY: the buffer holds `word_count` words and the device finished writing.
        Ok(unsafe { std::slice::from_raw_parts(alloc.get_host_ptr().cast_const().cast::<u32>(), word_count) }.to_vec())
    }
}

fn host_indirect_buffer<'a>(context: &'a Context<'a>, data: &[u8]) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(data.len() as vk::DeviceSize, vk::BufferUsageFlags::INDIRECT_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let alloc = buffer.get_allocation();
        // SAFETY: the buffer was created with the size of the data.
        unsafe { std::ptr::copy_nonoverlapping(data.as_ptr(), alloc.get_host_ptr(), data.len()) };
        flush_alloc(device, alloc)?;
    }
    Ok(buffer)
}

fn u32_bytes(words: &[u32]) -> Vec<u8> {
    words.iter().flat_map(|word| word.to_ne_bytes()).collect()
}

fn expect_value(output_value: u32, expected: u32) -> TestOutcome {
    if output_value != expected {
        return Ok(TestStatus::fail(format!(
            "Unexpected value found in output buffer; expected {expected} but found {output_value}"
        )));
    }
    Ok(TestStatus::pass("Pass"))
}

impl TestInstance for PropertyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::ValidLimits => self.valid_limits(),
            Variant::MaxTokenCount => self.max_token_count(),
            Variant::MaxStreamCount => self.max_stream_count(),
            Variant::MaxTokenOffset => self.max_token_offset(),
            Variant::MaxStreamStride => self.max_stream_stride(),
            Variant::MinBufferOffsetAlignment(offset) => self.min_buffer_offset_alignment(offset),
            Variant::MinSequencesOffsetAlignment(alignment_type) => self.min_sequences_offset_alignment(alignment_type),
        }
    }
}

impl PropertyInstance<'_> {
    fn max_token_count(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let pc_size = 4u32;
        let fixture = Fixture::new(context, &[0u32], pc_size)?;

        let property_limit = dgc_properties(context).max_indirect_commands_token_count;
        log::info!("maxIndirectCommandsTokenCount: {property_limit}");
        if property_limit < 1 {
            return Ok(TestStatus::fail("maxIndirectCommandsTokenCount too low"));
        }

        const MAX_TOKENS: u32 = 1024; // Hard reasonable limit: this is much higher than typical limits.
        let chosen_limit = property_limit.min(MAX_TOKENS);
        let pc_cmds_count = chosen_limit - 1; // The last one will be the dispatch token.

        let mut builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), BIND_POINT);
        for i in 0..pc_cmds_count {
            builder.add_push_constant_token(0, i * pc_size, *fixture.pipeline_layout, STAGE_FLAGS, 0, pc_size);
        }
        builder.add_dispatch_token(0, pc_cmds_count * pc_size);
        let cmds_layout = builder.build(device)?;

        let mut gen_cmds_data: Vec<u32> = (0..pc_cmds_count).map(|i| i + 1).collect(); // Push constants.
        gen_cmds_data.extend([1, 1, 1]); // VkDispatchIndirectCommand
        let gen_cmds_buffer = host_indirect_buffer(context, &u32_bytes(&gen_cmds_data))?;

        let preprocess_buffer = PreprocessBufferNv::new(context, BIND_POINT, *fixture.pipeline, cmds_layout.get(), 1)?;
        let info = GeneratedCommandsInfoNv::new(
            BIND_POINT,
            *fixture.pipeline,
            cmds_layout.get(),
            &[make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0)],
            1,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            vk::Buffer::null(),
            0,
        );
        let output = fixture.execute(context, &info, 1)?;
        expect_value(output[0], pc_cmds_count)
    }

    fn max_stream_count(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let pc_size = 4u32;
        let fixture = Fixture::new(context, &[0u32], pc_size)?;

        let dgc = dgc_properties(context);
        let max_stream_count = dgc.max_indirect_commands_stream_count;
        let max_token_count = dgc.max_indirect_commands_token_count;
        const MAX_VALUE: u32 = 1024; // Hard reasonable limit: this is much higher than typical limits.

        if max_stream_count < 1 {
            return Ok(TestStatus::fail("maxIndirectCommandsStreamCount too low"));
        }
        if max_token_count < 1 {
            return Ok(TestStatus::fail("maxIndirectCommandsTokenCount too low"));
        }

        let chosen_limit = MAX_VALUE.min(max_token_count.min(max_stream_count));
        let pc_cmds_count = chosen_limit - 1; // The last one will be the dispatch token.
        log::info!("maxIndirectCommandsStreamCount: {max_stream_count}");
        log::info!("maxIndirectCommandsTokenCount:  {max_token_count}");
        log::info!("Chosen limit:                   {chosen_limit}");

        // One stream per token.
        let mut builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), BIND_POINT);
        for i in 0..pc_cmds_count {
            builder.add_push_constant_token(i, 0, *fixture.pipeline_layout, STAGE_FLAGS, 0, pc_size);
        }
        builder.add_dispatch_token(pc_cmds_count, 0);
        let cmds_layout = builder.build(device)?;

        // One buffer per stream: a push constant each, and the dispatch command in the last one.
        let mut gen_cmds_buffers: Vec<BufferWithMemory<'_>> = Vec::with_capacity(chosen_limit as usize);
        for i in 0..pc_cmds_count {
            gen_cmds_buffers.push(host_indirect_buffer(context, &(i + 1).to_ne_bytes())?);
        }
        gen_cmds_buffers.push(host_indirect_buffer(context, &u32_bytes(&[1, 1, 1]))?);
        let streams: Vec<vk::IndirectCommandsStreamNV> = gen_cmds_buffers
            .iter()
            .map(|buffer| make_indirect_commands_stream_nv(buffer.get(), 0))
            .collect();

        let preprocess_buffer = PreprocessBufferNv::new(context, BIND_POINT, *fixture.pipeline, cmds_layout.get(), 1)?;
        let info = GeneratedCommandsInfoNv::new(
            BIND_POINT,
            *fixture.pipeline,
            cmds_layout.get(),
            &streams,
            1,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            vk::Buffer::null(),
            0,
        );
        let output = fixture.execute(context, &info, 1)?;
        expect_value(output[0], pc_cmds_count)
    }

    fn max_token_offset(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let u32_size = 4u32;
        let pc_value = 777u32; // Arbitrary.
        let pc_size = u32_size;
        let fixture = Fixture::new(context, &[0u32], pc_size)?;

        let dgc = dgc_properties(context);
        let max_stride = dgc.max_indirect_commands_stream_stride;
        let max_token_offset = dgc.max_indirect_commands_token_offset;
        const HARD_MAX: u32 = 1024 * 1024; // 1MB is a lot for a single sequence. Note we'll likely use this limit.

        let min_required_offset = u32_size * 3; // 3 uints for the indirect dispatch args.
        let min_required_stride = min_required_offset + pc_size;

        if max_stride < min_required_stride {
            return Ok(TestStatus::fail("maxIndirectCommandsStreamStride too low"));
        }
        if max_token_offset < min_required_offset {
            return Ok(TestStatus::fail("maxIndirectCommandsTokenOffset too low"));
        }

        let candidate = (max_stride - pc_size).min(max_token_offset);
        let pc_token_offset = HARD_MAX.min(candidate / u32_size * u32_size);
        let stream_stride = pc_token_offset + pc_size;

        log::info!("maxIndirectCommandsTokenOffset:  {max_token_offset}");
        log::info!("maxIndirectCommandsStreamStride: {max_stride}");
        log::info!("Hard maximum for the test:       {HARD_MAX}");
        log::info!("Chosen token offset:             {pc_token_offset}");

        let mut builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), BIND_POINT);
        builder.add_push_constant_token(0, pc_token_offset, *fixture.pipeline_layout, STAGE_FLAGS, 0, pc_size);
        builder.add_dispatch_token(0, 0);
        let cmds_layout = builder.build(device)?;

        let mut gen_cmds_data = vec![0u8; stream_stride as usize];
        gen_cmds_data[..12].copy_from_slice(&u32_bytes(&[1, 1, 1]));
        gen_cmds_data[pc_token_offset as usize..pc_token_offset as usize + 4].copy_from_slice(&pc_value.to_ne_bytes());
        let gen_cmds_buffer = host_indirect_buffer(context, &gen_cmds_data)?;

        let preprocess_buffer = PreprocessBufferNv::new(context, BIND_POINT, *fixture.pipeline, cmds_layout.get(), 1)?;
        let info = GeneratedCommandsInfoNv::new(
            BIND_POINT,
            *fixture.pipeline,
            cmds_layout.get(),
            &[make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0)],
            1,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            vk::Buffer::null(),
            0,
        );
        let output = fixture.execute(context, &info, 1)?;
        expect_value(output[0], pc_value)
    }

    fn max_stream_stride(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let u32_size = 4u32;

        // Push constants: index and value.
        let pc_size = 8u32;
        let pc_values: [(u32, u32); 2] = [(0, 555), (1, 777)];
        let fixture = Fixture::new(context, &[0u32, 0u32], pc_size)?;

        let max_stride = dgc_properties(context).max_indirect_commands_stream_stride;
        const HARD_MAX: u32 = 1024 * 1024; // 1MB is a lot for a single sequence. Note we'll likely use this limit.
        let min_required_stride = pc_size + std::mem::size_of::<vk::DispatchIndirectCommand>() as u32;

        if max_stride < min_required_stride {
            return Ok(TestStatus::fail("maxIndirectCommandsStreamStride too low"));
        }

        let chosen_stride = HARD_MAX.min(max_stride) / u32_size * u32_size;
        let data_size = chosen_stride as usize * pc_values.len();

        log::info!("maxIndirectCommandsStreamStride: {max_stride}");
        log::info!("Hard maximum for the test:       {HARD_MAX}");
        log::info!("Chosen stride:                   {chosen_stride}");

        let mut builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), BIND_POINT);
        builder.add_push_constant_token(0, 0, *fixture.pipeline_layout, STAGE_FLAGS, 0, pc_size);
        builder.add_dispatch_token(0, pc_size);
        builder.set_stream_stride(0, chosen_stride);
        let cmds_layout = builder.build(device)?;

        let mut gen_cmds_data = vec![0u8; data_size];
        for (i, (index, value)) in pc_values.iter().enumerate() {
            let offset = i * chosen_stride as usize;
            gen_cmds_data[offset..offset + 20].copy_from_slice(&u32_bytes(&[*index, *value, 1, 1, 1]));
        }
        let gen_cmds_buffer = host_indirect_buffer(context, &gen_cmds_data)?;

        let max_sequences = pc_values.len() as u32;
        let preprocess_buffer =
            PreprocessBufferNv::new(context, BIND_POINT, *fixture.pipeline, cmds_layout.get(), max_sequences)?;
        let info = GeneratedCommandsInfoNv::new(
            BIND_POINT,
            *fixture.pipeline,
            cmds_layout.get(),
            &[make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0)],
            max_sequences,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            vk::Buffer::null(),
            0,
        );
        let output = fixture.execute(context, &info, pc_values.len())?;

        let mut fail = false;
        for (i, result) in output.iter().enumerate() {
            let reference = pc_values
                .iter()
                .find(|(index, _)| *index as usize == i)
                .map_or(u32::MAX, |(_, value)| *value);
            if reference != *result {
                fail = true;
                log::error!("Unexpected value found at index {i}: expected {reference} but found {result}");
            }
        }
        if fail {
            return Ok(TestStatus::fail(
                "Unexpected value found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    fn min_buffer_offset_alignment(&self, offset: u32) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let u32_size = 4u32;
        debug_assert!(offset % u32_size == 0);
        let offset_items = offset / u32_size;
        let pc_value = 777u32; // Arbitrary.
        let fixture = Fixture::new(context, &[0u32], u32_size)?;

        let mut builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), BIND_POINT);
        builder.add_push_constant_token(0, 0, *fixture.pipeline_layout, STAGE_FLAGS, 0, u32_size);
        builder.add_dispatch_token(0, u32_size);
        let cmds_layout = builder.build(device)?;

        // Padding up to the offset, then the push constant and the indirect dispatch command.
        let mut gen_cmds_data: Vec<u32> = vec![0x1AB2C3D4; offset_items as usize];
        gen_cmds_data.extend([pc_value, 1, 1, 1]);
        let gen_cmds_buffer = host_indirect_buffer(context, &u32_bytes(&gen_cmds_data))?;

        let preprocess_buffer = PreprocessBufferNv::new(context, BIND_POINT, *fixture.pipeline, cmds_layout.get(), 1)?;
        let info = GeneratedCommandsInfoNv::new(
            BIND_POINT,
            *fixture.pipeline,
            cmds_layout.get(),
            &[make_indirect_commands_stream_nv(
                gen_cmds_buffer.get(),
                vk::DeviceSize::from(offset),
            )],
            1,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            vk::Buffer::null(),
            0,
        );
        let output = fixture.execute(context, &info, 1)?;
        expect_value(output[0], pc_value)
    }

    fn min_sequences_offset_alignment(&self, alignment_type: AlignmentType) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let dgc = dgc_properties(context);
        let memory_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_memory_properties(context.get_physical_device())
        };
        let non_coherent_atom_size = context.get_device_properties().limits.non_coherent_atom_size;

        let total_value_count = 512u32;
        let count_in_buffer = total_value_count
            / if alignment_type == AlignmentType::CountBuffer {
                2
            } else {
                1
            };
        let pc_size = 8u32;

        let get_stored_value = |i: u32| (i + 1) * 1000;
        let fixture = Fixture::new(context, &vec![0u32; total_value_count as usize], pc_size)?;

        let mut builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), BIND_POINT);
        builder.add_push_constant_token(0, 0, *fixture.pipeline_layout, STAGE_FLAGS, 0, pc_size);
        builder.add_dispatch_token(0, pc_size);
        let cmds_layout = builder.build(device)?;

        let mut gen_cmds_data: Vec<u32> = Vec::with_capacity(total_value_count as usize * 5);
        for i in 0..total_value_count {
            gen_cmds_data.extend([i, get_stored_value(i), 1, 1, 1]);
        }
        let gen_cmds_buffer = host_indirect_buffer(context, &u32_bytes(&gen_cmds_data))?;

        let max_sequences = total_value_count;
        let preprocess_buffer =
            PreprocessBufferNv::new(context, BIND_POINT, *fixture.pipeline, cmds_layout.get(), max_sequences)?;

        // A buffer whose contents start at the given offset (the allocator binds it that many bytes in).
        let make_offset_buffer = |offset: u32, data: &[u8]| -> Result<BufferWithMemory<'_>, TestError> {
            let allocator = SimpleAllocator::with_offset(
                memory_properties,
                OffsetParams {
                    non_coherent_atom_size,
                    offset: vk::DeviceSize::from(offset),
                },
            );
            let buffer_size = vk::DeviceSize::from(offset) + data.len() as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                device,
                &allocator,
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::INDIRECT_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            {
                let alloc = buffer.get_allocation();
                // SAFETY: the buffer was created `offset` bytes larger than the data.
                unsafe {
                    std::ptr::copy_nonoverlapping(data.as_ptr(), alloc.get_host_ptr().add(offset as usize), data.len())
                };
                flush_alloc(device, alloc)?;
            }
            Ok(buffer)
        };

        let mut count_buffer = None;
        let mut count_buffer_offset = 0u64;
        let mut indices_buffer = None;
        let mut indices_buffer_offset = 0u64;

        if alignment_type == AlignmentType::CountBuffer {
            let offset = dgc.min_sequences_count_buffer_offset_alignment;
            log::info!("minSequencesCountBufferOffsetAlignment: {offset}");
            count_buffer_offset = vk::DeviceSize::from(offset);
            count_buffer = Some(make_offset_buffer(offset, &count_in_buffer.to_ne_bytes())?);
        }
        if alignment_type == AlignmentType::IndexBuffer {
            let mut indices: Vec<u32> = (0..total_value_count).collect();
            let mut rnd = Random::new(1_707_306_954);
            rnd.shuffle(&mut indices);

            let offset = dgc.min_sequences_index_buffer_offset_alignment;
            log::info!("minSequencesIndexBufferOffsetAlignment: {offset}");
            indices_buffer_offset = vk::DeviceSize::from(offset);
            indices_buffer = Some(make_offset_buffer(offset, &u32_bytes(&indices))?);
        }

        let mut info = GeneratedCommandsInfoNv::new(
            BIND_POINT,
            *fixture.pipeline,
            cmds_layout.get(),
            &[make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0)],
            max_sequences,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            count_buffer.as_ref().map_or(vk::Buffer::null(), BufferWithMemory::get),
            count_buffer_offset,
        );
        if let Some(buffer) = &indices_buffer {
            info = info.with_sequences_index(buffer.get(), indices_buffer_offset);
        }
        let output = fixture.execute(context, &info, total_value_count as usize)?;

        let mut fail = false;
        for (i, result) in output.iter().enumerate() {
            let reference = if (i as u32) < count_in_buffer {
                get_stored_value(i as u32)
            } else {
                0
            };
            if reference != *result {
                fail = true;
                log::error!("Unexpected value found at index {i}: expected {reference} but found {result}");
            }
        }
        if fail {
            return Ok(TestStatus::fail(
                "Unexpected value found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    fn valid_limits(&self) -> TestOutcome {
        let properties = dgc_properties(self.context);
        let checks = [
            (
                properties.max_graphics_shader_group_count >= (1 << 12)
                    || properties.max_graphics_shader_group_count == 0,
                "maxGraphicsShaderGroupCount not in required range",
            ),
            (
                properties.max_indirect_sequence_count >= (1 << 20),
                "maxIndirectSequenceCount not in required range",
            ),
            (
                properties.max_indirect_commands_token_count >= 16,
                "maxIndirectCommandsTokenCount not in required range",
            ),
            (
                properties.max_indirect_commands_stream_count >= 16,
                "maxIndirectCommandsStreamCount not in required range",
            ),
            (
                properties.max_indirect_commands_token_offset >= 2047,
                "maxIndirectCommandsTokenOffset not in required range",
            ),
            (
                properties.max_indirect_commands_stream_stride >= 2048,
                "maxIndirectCommandsStreamStride not in required range",
            ),
            (
                properties.min_sequences_count_buffer_offset_alignment <= 256,
                "minSequencesCountBufferOffsetAlignment not in required range",
            ),
            (
                properties.min_sequences_index_buffer_offset_alignment <= 256,
                "minSequencesIndexBufferOffsetAlignment not in required range",
            ),
            (
                properties.min_indirect_commands_buffer_offset_alignment <= 256,
                "minIndirectCommandsBufferOffsetAlignment not in required range",
            ),
        ];
        for (ok, message) in checks {
            if !ok {
                return Ok(TestStatus::fail(message));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCPropertyTests`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_property_tests_nv() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    let mut add = |name: String, variant: Variant| {
        cases.push((
            format!("nv.misc.properties.{name}"),
            Box::new(PropertyCase { name, variant }) as Box<dyn TestCase>,
        ));
    };

    add("valid_limits".to_string(), Variant::ValidLimits);
    add("maxIndirectCommandsTokenCount".to_string(), Variant::MaxTokenCount);
    add("maxIndirectCommandsStreamCount".to_string(), Variant::MaxStreamCount);
    add("maxIndirectCommandsTokenOffset".to_string(), Variant::MaxTokenOffset);
    add(
        "maxIndirectCommandsStreamStrideRun".to_string(),
        Variant::MaxStreamStride,
    );
    for offset in [4u32, 8, 256] {
        add(
            format!("minIndirectCommandsBufferOffsetAlignment_offset_{offset}"),
            Variant::MinBufferOffsetAlignment(offset),
        );
    }
    add(
        "minSequencesCountBufferOffsetAlignment".to_string(),
        Variant::MinSequencesOffsetAlignment(AlignmentType::CountBuffer),
    );
    add(
        "minSequencesIndexBufferOffsetAlignment".to_string(),
        Variant::MinSequencesOffsetAlignment(AlignmentType::IndexBuffer),
    );
    cases
}

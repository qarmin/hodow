// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCPropertyTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `valid_limits`, `maxIndirectCommandsTokenCount_*`, `maxIndirectCommandsTokenOffset` and
// `maxIndirectCommandsStreamIndirect` are ported here (`maxIndirectSequenceCount` renders a million points and stays gated). The programs are
// pre-expanded in `shaders/manifest/dgc_properties.toml` (`scripts/gen_dgc_properties_manifest.py`). The pipeline layout is the one of the
// pipeline wrapper.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtDeviceGeneratedCommandsExtensionDeviceCommands;

use crate::generated::shaders::dgc_properties::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcComputeSupportType, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_compute_support, check_dgc_ext_support, device_generated_commands_properties,
};
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy)]
enum Variant {
    ValidLimits,
    /// The number of push constant bytes: one push constant token per item.
    MaxIndirectCommandsTokenCount {
        pc_size_bytes: u32,
    },
    MaxIndirectCommandsTokenOffset,
    MaxIndirectCommandsIndirectStride,
}

struct PropertyCase {
    name: String,
    variant: Variant,
}

impl TestCase for PropertyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.variant {
            Variant::ValidLimits => check_dgc_ext_support(
                context,
                vk::ShaderStageFlags::empty(),
                vk::ShaderStageFlags::empty(),
                vk::ShaderStageFlags::empty(),
                vk::IndirectCommandsInputModeFlagsEXT::empty(),
                false,
            ),
            Variant::MaxIndirectCommandsTokenOffset | Variant::MaxIndirectCommandsIndirectStride => {
                check_dgc_ext_compute_support(context, DgcComputeSupportType::Basic)
            }
            Variant::MaxIndirectCommandsTokenCount { pc_size_bytes } => {
                check_dgc_ext_compute_support(context, DgcComputeSupportType::Basic)?;

                // Each item in the push constant array will be updated by a separate push constant token. Given the push constant array
                // length, we cannot run the test if we go over the max push constant size or the maximum number of tokens.
                let max_push_constants_size = context.get_device_properties().limits.max_push_constants_size;
                if max_push_constants_size < pc_size_bytes {
                    return Err(TestError::NotSupported(format!(
                        "maxPushConstantsSize not large enough ({max_push_constants_size} vs {pc_size_bytes})"
                    )));
                }

                let pc_len = pc_size_bytes / std::mem::size_of::<u32>() as u32;
                let total_tokens = pc_len + 1; // For the dispatch token.

                let dgc_properties = device_generated_commands_properties(context);
                if dgc_properties.max_indirect_commands_token_count < total_tokens {
                    return Err(TestError::NotSupported(format!(
                        "maxIndirectCommandsTokenCount not large enough ({} vs {total_tokens})",
                        dgc_properties.max_indirect_commands_token_count
                    )));
                }
                Ok(())
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        let key = match self.variant {
            Variant::ValidLimits => return BinaryCollection::new(&[]),
            Variant::MaxIndirectCommandsTokenCount { pc_size_bytes } => format!("prop_pc_array_{}", pc_size_bytes / 4),
            Variant::MaxIndirectCommandsTokenOffset => "prop_pc_bytes".to_string(),
            Variant::MaxIndirectCommandsIndirectStride => "prop_pc_index".to_string(),
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
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

impl TestInstance for PropertyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::ValidLimits => self.valid_limits(),
            Variant::MaxIndirectCommandsTokenCount { pc_size_bytes } => {
                self.max_indirect_commands_token_count_run(pc_size_bytes)
            }
            Variant::MaxIndirectCommandsTokenOffset => self.max_indirect_commands_token_offset_run(),
            Variant::MaxIndirectCommandsIndirectStride => self.max_indirect_commands_indirect_stride_run(),
        }
    }
}

/// How a run lays out its commands: a layout builder prepared by the caller, the bytes of the commands stream and the sequence count.
struct Run<'r> {
    pc_range: vk::PushConstantRange,
    output_buffer_size: vk::DeviceSize,
    initial_output: &'r [u8],
    max_sequences: u32,
}

impl<'a> PropertyInstance<'a> {
    /// `validLimits`
    fn valid_limits(&self) -> TestOutcome {
        let properties = device_generated_commands_properties(self.context);
        let fail = |what: &str| Ok(TestStatus::fail(format!("{what} not in required range")));

        // Common with NV.
        if properties.max_indirect_sequence_count < (1 << 20) {
            return fail("maxIndirectSequenceCount");
        }
        if properties.max_indirect_commands_token_count < 16 {
            return fail("maxIndirectCommandsTokenCount");
        }
        if properties.max_indirect_commands_token_offset < 2047 {
            return fail("maxIndirectCommandsTokenOffset");
        }
        if properties.max_indirect_commands_indirect_stride < 2048 {
            return fail("maxIndirectCommandsIndirectStride");
        }

        // Particular to EXT.
        if properties.max_indirect_pipeline_count < (1 << 12) {
            return fail("maxIndirectPipelineCount");
        }
        if properties.max_indirect_shader_object_count > 0 && properties.max_indirect_shader_object_count < (1 << 12) {
            return fail("maxIndirectShaderObjectCount");
        }
        if !properties
            .supported_indirect_commands_input_modes
            .contains(vk::IndirectCommandsInputModeFlagsEXT::VULKAN_INDEX_BUFFER)
        {
            return Ok(TestStatus::fail(
                "supportedIndirectCommandsInputModes missing required bits",
            ));
        }

        let required_stages =
            vk::ShaderStageFlags::COMPUTE | vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        if (properties.supported_indirect_commands_shader_stages & required_stages) != required_stages {
            return Ok(TestStatus::fail(
                "supportedIndirectCommandsShaderStages missing required bits",
            ));
        }

        // supportedIndirectCommandsShaderStagesBinding has no required bits.
        Ok(TestStatus::pass("Pass"))
    }

    /// The common body of the three runs: an output buffer with a descriptor set, a pipeline with one push constant range, the commands layout
    /// that `build_layout` makes, the bytes in `gen_cmds_data`, one execution of `max_sequences` sequences. Returns the output buffer contents.
    fn execute(
        &self,
        run: &Run<'_>,
        build_layout: impl FnOnce(&mut IndirectCommandsLayoutBuilderExt),
        gen_cmds_data: &[u8],
    ) -> Result<Vec<u8>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;

        // Output buffer.
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(run.output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = output_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    run.initial_output.as_ptr(),
                    alloc.get_host_ptr(),
                    run.initial_output.len(),
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Descriptor set layout, pool and set preparation.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stage_flags)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, run.output_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                desc_type,
                &output_buffer_desc_info,
            )
            .update(device);

        // Pipeline layout, shader and pipeline.
        let mut pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*set_layout);
        pipeline.add_push_constant_range(run.pc_range);
        pipeline.build_pipeline()?;
        let pipeline_layout = pipeline.get_pipeline_layout();

        // Indirect commands layout.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            pipeline_layout,
        );
        build_layout(&mut cmds_layout_builder);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generated indirect commands buffer.
        let gen_cmds_buffer_size = gen_cmds_data.len() as vk::DeviceSize;
        let gen_cmds_buffer = DgcBuffer::new(
            context,
            gen_cmds_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = gen_cmds_buffer.get_allocation();
            unsafe { std::ptr::copy_nonoverlapping(gen_cmds_data.as_ptr(), alloc.get_host_ptr(), gen_cmds_data.len()) };
            flush_alloc(device, alloc)?;
        }

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            run.max_sequences,
            0,
            pipeline.get_pipeline(),
            0,
        )?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
        }
        pipeline.bind(cmd_buffer);
        {
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                gen_cmds_buffer.get_device_address(),
                gen_cmds_buffer_size,
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                run.max_sequences,
                0,
                0,
                pipeline.get_pipeline(),
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
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

        let alloc = output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let mut result = vec![0u8; run.output_buffer_size as usize];
        unsafe { std::ptr::copy_nonoverlapping(alloc.get_host_ptr(), result.as_mut_ptr(), result.len()) };
        Ok(result)
    }

    /// `maxIndirectCommandsTokenCountRun`
    fn max_indirect_commands_token_count_run(&self, pc_size_bytes: u32) -> TestOutcome {
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let item_size = std::mem::size_of::<u32>() as u32;
        let pc_len = pc_size_bytes / item_size;
        let pc_value_offset = 1000u32;

        let zeros = vec![0u8; pc_size_bytes as usize];
        let run = Run {
            pc_range: vk::PushConstantRange {
                stage_flags,
                offset: 0,
                size: pc_size_bytes,
            },
            output_buffer_size: vk::DeviceSize::from(pc_size_bytes),
            initial_output: &zeros,
            max_sequences: 1,
        };

        // Generated indirect commands buffer contents.
        let mut gen_cmds_data: Vec<u32> = (0..pc_len).map(|i| i + pc_value_offset).collect(); // Push constants.
        gen_cmds_data.extend([1, 1, 1]); // VkDispatchIndirectCommand

        let result_bytes = self.execute(
            &run,
            |builder| {
                // Push constants followed by dispatch.
                for i in 0..pc_len {
                    let offset = i * item_size;
                    builder.add_push_constant_token(
                        offset,
                        vk::PushConstantRange {
                            stage_flags,
                            offset,
                            size: item_size,
                        },
                    );
                }
                builder.add_dispatch_token(pc_len * item_size);
            },
            &gen_cmds_data
                .iter()
                .flat_map(|value| value.to_ne_bytes())
                .collect::<Vec<u8>>(),
        )?;

        // Verify results.
        let mut pass = true;
        for (i, chunk) in result_bytes.chunks_exact(4).enumerate() {
            let result = u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]);
            let expected = i as u32 + pc_value_offset;
            if result != expected {
                log::error!(
                    "Unexpected value found in output buffer at position {i}: expected {expected} but found {result}"
                );
                pass = false;
            }
        }

        if !pass {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `maxIndirectCommandsTokenOffsetRun`
    fn max_indirect_commands_token_offset_run(&self) -> TestOutcome {
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let u32_size = std::mem::size_of::<u32>() as u32;
        let u32_size_vk_sz = vk::DeviceSize::from(u32_size);
        let pc_value = 0x77u32; // Arbitrary, fits in a byte.
        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: u32_size,
        };

        // Generated commands layout: test the token offset limit. We'll use two tokens: the push constant one and the dispatch. Note
        // we're also affected by the stream stride limit.
        //
        // Lets start with the max stride first and then reduce that for the offset if needed. Also, set a maximum reasonable limit so we
        // don't allocate a huge amount of memory.
        let dgc_properties = device_generated_commands_properties(self.context);
        let max_stride = vk::DeviceSize::from(dgc_properties.max_indirect_commands_indirect_stride);
        let max_token_offset = vk::DeviceSize::from(dgc_properties.max_indirect_commands_token_offset);
        const HARD_MAX: vk::DeviceSize = 1024 * 1024; // 1MB is a lot for a single sequence. Note we'll likely use this limit.
        let min_required_offset = u32_size_vk_sz; // No less than this for the dispatch token.
        let dispatch_token_size = std::mem::size_of::<vk::DispatchIndirectCommand>() as vk::DeviceSize;
        let min_required_stride = u32_size_vk_sz + dispatch_token_size;
        if max_stride < min_required_stride {
            return Ok(TestStatus::fail("maxIndirectCommandsIndirectStride too low"));
        }
        if max_token_offset < min_required_offset {
            return Ok(TestStatus::fail("maxIndirectCommandsTokenOffset too low"));
        }

        // The offset of the dispatch token is the lowest of the max stride - sizeof(uint32_t) and the max token offset property. Note we
        // round the max token offset down to make sure the dispatch is aligned.
        let rounded = (max_stride - dispatch_token_size).min(max_token_offset) / u32_size_vk_sz * u32_size_vk_sz;
        let dispatch_token_offset = HARD_MAX.min(rounded);
        let stream_stride = dispatch_token_offset + dispatch_token_size;

        log::debug!("maxIndirectCommandsTokenOffset:    {max_token_offset}");
        log::debug!("maxIndirectCommandsIndirectStride: {max_stride}");
        log::debug!("Hard maximum for the test:         {HARD_MAX}");
        log::debug!("Chosen token offset:               {dispatch_token_offset}");

        // Generated indirect commands buffer contents.
        let mut gen_cmds_data = vec![0u8; stream_stride as usize];
        gen_cmds_data[..4].copy_from_slice(&pc_value.to_ne_bytes());
        let dispatch_cmd = [1u32, 1, 4];
        for (i, value) in dispatch_cmd.iter().enumerate() {
            let at = dispatch_token_offset as usize + i * 4;
            gen_cmds_data[at..at + 4].copy_from_slice(&value.to_ne_bytes());
        }

        let run = Run {
            pc_range,
            output_buffer_size: u32_size_vk_sz,
            initial_output: &[0u8; 4],
            max_sequences: 1,
        };
        let result_bytes = self.execute(
            &run,
            |builder| {
                builder.add_push_constant_token(0, pc_range);
                builder.add_dispatch_token(dispatch_token_offset as u32);
            },
            &gen_cmds_data,
        )?;

        // Verify results.
        let mut expected_value = 0u32;
        for i in 0..std::mem::size_of::<u32>() {
            expected_value |= pc_value << (8 * i); // Must match shader.
        }
        let output_value = u32::from_ne_bytes([result_bytes[0], result_bytes[1], result_bytes[2], result_bytes[3]]);
        if output_value != expected_value {
            return Ok(TestStatus::fail(format!(
                "Unexpected value found in output buffer; expected {expected_value} but found {output_value}"
            )));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `maxIndirectCommandsIndirectStrideRun`
    fn max_indirect_commands_indirect_stride_run(&self) -> TestOutcome {
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let u32_size = std::mem::size_of::<u32>() as u32;

        // Push constants. This must match the shader: index and value.
        let pc_size = 2 * u32_size;
        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: pc_size,
        };
        let pc_values: [(u32, u32); 2] = [(0, 555), (1, 777)];

        // To test the maximum stride, we'll generate a couple of dispatches and set them apart by the chosen stream stride. Both dispatches
        // will have to be emitted and will use the push constant values to update the buffer.
        let dgc_properties = device_generated_commands_properties(self.context);
        let max_stride = dgc_properties.max_indirect_commands_indirect_stride;
        const HARD_MAX: u32 = 1024 * 1024; // 1MB is a lot for a single sequence. Note we'll likely use this limit.
        let min_required_stride = pc_size + std::mem::size_of::<vk::DispatchIndirectCommand>() as u32;
        if max_stride < min_required_stride {
            return Ok(TestStatus::fail("maxIndirectCommandsIndirectStride too low"));
        }

        // We need to round down the chosen stride to make sure push constants and dispatch commands are aligned.
        let chosen_stride = HARD_MAX.min(max_stride) / u32_size * u32_size;
        let data_size = chosen_stride * pc_values.len() as u32;
        log::debug!("maxIndirectCommandsIndirectStride: {max_stride}");
        log::debug!("Hard maximum for the test:         {HARD_MAX}");
        log::debug!("Chosen stride:                     {chosen_stride}");

        // Generated indirect commands buffer contents.
        let mut gen_cmds_data = vec![0u8; data_size as usize];
        let dispatch_cmd = [1u32, 1, 1];
        for (i, (index, value)) in pc_values.iter().enumerate() {
            let offset = i * chosen_stride as usize;
            let words = [*index, *value, dispatch_cmd[0], dispatch_cmd[1], dispatch_cmd[2]];
            for (k, word) in words.iter().enumerate() {
                gen_cmds_data[offset + k * 4..offset + k * 4 + 4].copy_from_slice(&word.to_ne_bytes());
            }
        }

        let run = Run {
            pc_range,
            output_buffer_size: vk::DeviceSize::from(pc_values.len() as u32 * u32_size),
            initial_output: &[0u8; 8],
            max_sequences: pc_values.len() as u32,
        };
        let result_bytes = self.execute(
            &run,
            |builder| {
                builder.add_push_constant_token(0, pc_range);
                builder.add_dispatch_token(pc_size);
                builder.set_stream_stride(chosen_stride);
            },
            &gen_cmds_data,
        )?;

        // Verify results.
        let mut fail = false;
        for (i, chunk) in result_bytes.chunks_exact(4).enumerate() {
            let result = u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]);
            // Find the reference value in the push constants.
            let reference = pc_values
                .iter()
                .find(|(index, _)| *index as usize == i)
                .map_or(u32::MAX, |(_, value)| *value);
            if reference != result {
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
}

/// The ported part of `createDGCPropertyTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_property_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    let mut push = |name: String, variant: Variant| {
        cases.push((
            format!("ext.misc.properties.{name}"),
            Box::new(PropertyCase { name, variant }) as Box<dyn TestCase>,
        ));
    };

    push("valid_limits".to_string(), Variant::ValidLimits);

    // For maxIndirectCommandsTokenCount we depend on the push constant limits.
    for token_count in [16u32, 32] {
        let pc_tokens = token_count - 1;
        let pc_size_bytes = pc_tokens * std::mem::size_of::<u32>() as u32;
        push(
            format!("maxIndirectCommandsTokenCount_{token_count}"),
            Variant::MaxIndirectCommandsTokenCount { pc_size_bytes },
        );
    }

    push(
        "maxIndirectCommandsTokenOffset".to_string(),
        Variant::MaxIndirectCommandsTokenOffset,
    );
    push(
        "maxIndirectCommandsStreamIndirect".to_string(),
        Variant::MaxIndirectCommandsIndirectStride,
    );
    cases
}

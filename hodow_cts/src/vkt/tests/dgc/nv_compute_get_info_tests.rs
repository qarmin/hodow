// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeGetInfoTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The program is `get_info_basic` of the EXT get_info tests
// (`shaders/manifest/dgc_compute_get_info.toml`), the same basic compute shader.
//
// `dgc.nv.compute.get_info` (VK_NV_device_generated_commands_compute): the pipeline indirect memory requirements, the pipeline indirect device
// address, the capture/replay address and the generated commands memory requirements have to be constant for the same inputs.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::dgc_compute_get_info::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::obj_util::{make_pipeline_layout, make_pipeline_layout_with_push_constants};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::dgc::util_nv::{
    DgcComputePipeline, DgcComputePipelineMetaDataPool, IndirectCommandsLayoutBuilderNv, check_dgc_compute_support,
    create_compute_pipeline, get_generated_commands_memory_requirements_nv,
    get_pipeline_indirect_memory_requirements_nv, pipeline_indirect_device_address,
};
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum ConstantCommandsMemoryReqsCase {
    BasicCase,
    BasicCaseWithPipeline,
    IncreaseCount,
    MaxSequenceCount,
    IgnoreUnordered,
}

#[derive(Clone, Copy)]
enum Variant {
    PipelineMemoryRequirements,
    PipelineDeviceAddress,
    PipelineCaptureReplayAddress,
    CommandsMemoryRequirements(ConstantCommandsMemoryReqsCase),
}

struct GetInfoCase {
    name: String,
    variant: Variant,
}

impl TestCase for GetInfoCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.variant {
            Variant::PipelineMemoryRequirements | Variant::PipelineDeviceAddress => {
                check_dgc_compute_support(context, true, false)
            }
            Variant::PipelineCaptureReplayAddress => check_dgc_compute_support(context, true, true),
            Variant::CommandsMemoryRequirements(case) => check_dgc_compute_support(
                context,
                case == ConstantCommandsMemoryReqsCase::BasicCaseWithPipeline,
                false,
            ),
        }
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "get_info_basic")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GetInfoInstance {
            context,
            variant: self.variant,
        })
    }
}

struct GetInfoInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
}

/// `equalMemoryRequirements`
fn equal_memory_requirements(a: &vk::MemoryRequirements, b: &vk::MemoryRequirements) -> bool {
    a.memory_type_bits == b.memory_type_bits && a.alignment == b.alignment && a.size == b.size
}

impl TestInstance for GetInfoInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::PipelineMemoryRequirements => self.constant_pipeline_memory_requirements(),
            Variant::PipelineDeviceAddress => self.constant_pipeline_device_address(),
            Variant::PipelineCaptureReplayAddress => self.constant_pipeline_capture_replay_address(),
            Variant::CommandsMemoryRequirements(case) => self.constant_commands_mem_reqs(case),
        }
    }
}

impl GetInfoInstance<'_> {
    fn constant_pipeline_memory_requirements(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        let stage = vk::PipelineShaderStageCreateInfo {
            stage: vk::ShaderStageFlags::COMPUTE,
            module: *comp_module,
            name: c"main".as_ptr(),
            ..Default::default()
        };
        let mut create_info = vk::ComputePipelineCreateInfo {
            flags: vk::PipelineCreateFlags::INDIRECT_BINDABLE_NV,
            stage,
            layout: *pipeline_layout,
            base_pipeline_index: -1,
            ..Default::default()
        };

        // Retrieve the base memory requirements for a simple call.
        let base_mem_reqs = get_pipeline_indirect_memory_requirements_nv(device, &create_info);

        // Add a VkComputePipelineIndirectBufferInfoNV structure to the chain that should be ignored, according to spec.
        let mut rnd = Random::new(1_706_013_938);
        let garbage_buffer_info = vk::ComputePipelineIndirectBufferInfoNV {
            device_address: rnd.get_uint64(),
            size: rnd.get_uint64(),
            pipeline_device_address_capture_replay: rnd.get_uint64(),
            ..Default::default()
        };
        let backup = (
            garbage_buffer_info.device_address,
            garbage_buffer_info.size,
            garbage_buffer_info.pipeline_device_address_capture_replay,
        );

        create_info.next = (&garbage_buffer_info as *const vk::ComputePipelineIndirectBufferInfoNV).cast();
        let with_buffer_info_reqs = get_pipeline_indirect_memory_requirements_nv(device, &create_info);

        // The structure should not have been modified.
        if backup
            != (
                garbage_buffer_info.device_address,
                garbage_buffer_info.size,
                garbage_buffer_info.pipeline_device_address_capture_replay,
            )
        {
            return Ok(TestStatus::fail(
                "VkComputePipelineIndirectBufferInfoNV was modified in vkGetPipelineIndirectMemoryRequirementsNV",
            ));
        }

        // Finally request the base memory requirements again.
        create_info.next = std::ptr::null();
        let retry_mem_reqs = get_pipeline_indirect_memory_requirements_nv(device, &create_info);

        if !equal_memory_requirements(&base_mem_reqs, &with_buffer_info_reqs)
            || !equal_memory_requirements(&base_mem_reqs, &retry_mem_reqs)
        {
            log::error!("Base memory requirements: {base_mem_reqs:?}");
            log::error!("Memory requirements with buffer info: {with_buffer_info_reqs:?}");
            log::error!("Memory requirements on retry: {retry_mem_reqs:?}");
            return Ok(TestStatus::fail(
                "Indirect memory requirements are not constant for the same pipeline; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    fn constant_pipeline_device_address(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        let meta_data_pool =
            DgcComputePipelineMetaDataPool::new(context, DgcComputePipelineMetaDataPool::DEFAULT_MULTIPLIER, false);
        let pipeline = DgcComputePipeline::new(
            &meta_data_pool,
            device,
            vk::PipelineCreateFlags::empty(),
            *pipeline_layout,
            vk::PipelineShaderStageCreateFlags::empty(),
            *comp_module,
            None,
            0,
            vk::Pipeline::null(),
            -1,
            0,
        )?;

        // Retrieve the pipeline device address manually and check it matches the saved one.
        let address = pipeline_indirect_device_address(device, pipeline.get());
        if address != pipeline.get_indirect_device_address() {
            return Ok(TestStatus::fail("Pipeline indirect device address is not constant"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    fn constant_pipeline_capture_replay_address(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        // Retrieve the capture replay address first. Note metadata pools have the capture/replay flag enabled.
        let capture_address = {
            let meta_data_pool = DgcComputePipelineMetaDataPool::new(context, 1, true);
            let pipeline = DgcComputePipeline::new(
                &meta_data_pool,
                device,
                vk::PipelineCreateFlags::empty(),
                *pipeline_layout,
                vk::PipelineShaderStageCreateFlags::empty(),
                *comp_module,
                None,
                0,
                vk::Pipeline::null(),
                -1,
                0,
            )?;
            // Note the pipeline and pool go out of scope here, destroying resources.
            pipeline.get_indirect_device_address()
        };

        // Re-create the pipeline providing the capture/replay address. Make sure both match.
        let meta_data_pool = DgcComputePipelineMetaDataPool::new(context, 1, true);
        let pipeline = DgcComputePipeline::new(
            &meta_data_pool,
            device,
            vk::PipelineCreateFlags::empty(),
            *pipeline_layout,
            vk::PipelineShaderStageCreateFlags::empty(),
            *comp_module,
            None,
            capture_address,
            vk::Pipeline::null(),
            -1,
            0,
        )?;
        let replay_address = pipeline.get_indirect_device_address();

        if capture_address != replay_address {
            return Ok(TestStatus::fail("Capture and replay addresses are not equal"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    fn constant_commands_mem_reqs(&self, mem_reqs_case: ConstantCommandsMemoryReqsCase) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let shader_stage = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;

        // We need an actual pipeline for those cases where the sequence does not include a pipeline switch token. Since this pipeline would
        // presumably be set outside the generated commands, it can be a normal compute pipeline.
        let pipeline_needed = mem_reqs_case != ConstantCommandsMemoryReqsCase::BasicCaseWithPipeline;

        // We'll pretend to use push constants in one particular case, even if they're not used by the compute shader.
        let needs_push_constant = mem_reqs_case == ConstantCommandsMemoryReqsCase::IncreaseCount;
        let pc_range = vk::PushConstantRange {
            stage_flags: shader_stage,
            offset: 0,
            size: 4,
        };

        // We will pretend to use preprocess in some cases.
        let needs_preprocess = mem_reqs_case == ConstantCommandsMemoryReqsCase::BasicCase;

        // For the flag ignore test, we'll need two actual indirect command layouts.
        let builder_count = if mem_reqs_case == ConstantCommandsMemoryReqsCase::IgnoreUnordered {
            2
        } else {
            1
        };

        let mut set_layout = None;
        let mut pipeline_layout = None;
        let mut comp_module = None;
        let mut pipeline = None;

        if pipeline_needed {
            let binaries = context.get_binary_collection();
            let module = create_shader_module(device, binaries.get("comp")?)?;
            let layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, shader_stage)
                .build(device)?;
            let ranges: &[vk::PushConstantRange] = if needs_push_constant {
                std::slice::from_ref(&pc_range)
            } else {
                &[]
            };
            let pipe_layout = make_pipeline_layout_with_push_constants(device, &[*layout], ranges)?;
            pipeline = Some(create_compute_pipeline(device, *pipe_layout, *module, 0)?);
            comp_module = Some(module);
            set_layout = Some(layout);
            pipeline_layout = Some(pipe_layout);
        }
        let _keep_alive = (&comp_module, &set_layout);
        let pipeline_handle = pipeline.as_ref().map_or(vk::Pipeline::null(), |pipeline| **pipeline);

        // Now build a command sequence. It will be different depending on the case. The flags will also vary a bit.
        let layout_usage_flags = if needs_preprocess {
            vk::IndirectCommandsLayoutUsageFlagsNV::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsNV::empty()
        };

        let mut cmd_layouts = Vec::new();
        for i in 0..builder_count {
            let extra_flags = if i > 0 {
                vk::IndirectCommandsLayoutUsageFlagsNV::UNORDERED_SEQUENCES
            } else {
                vk::IndirectCommandsLayoutUsageFlagsNV::empty()
            };
            let mut builder = IndirectCommandsLayoutBuilderNv::new(layout_usage_flags | extra_flags, bind_point);

            match mem_reqs_case {
                ConstantCommandsMemoryReqsCase::BasicCase
                | ConstantCommandsMemoryReqsCase::MaxSequenceCount
                | ConstantCommandsMemoryReqsCase::IgnoreUnordered => builder.add_dispatch_token(0, 0),
                ConstantCommandsMemoryReqsCase::BasicCaseWithPipeline => {
                    builder.add_pipeline_token(0, 0);
                    let offset = builder.get_stream_range(0);
                    builder.add_dispatch_token(0, offset);
                }
                ConstantCommandsMemoryReqsCase::IncreaseCount => {
                    let layout = pipeline_layout
                        .as_ref()
                        .map_or(vk::PipelineLayout::null(), |layout| **layout);
                    builder.add_push_constant_token(0, 0, layout, pc_range.stage_flags, pc_range.offset, pc_range.size);
                    let offset = builder.get_stream_range(0);
                    builder.add_dispatch_token(0, offset);
                }
            }
            cmd_layouts.push(builder.build(device)?);
        }

        // For the maxSequencesCount value, we'll use something reasonable.
        let mut max_sequences_count = 1024u32;
        if mem_reqs_case == ConstantCommandsMemoryReqsCase::MaxSequenceCount {
            let mut properties = vk::PhysicalDeviceDeviceGeneratedCommandsPropertiesNV::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            max_sequences_count = properties.max_indirect_sequence_count;
        }

        // Get an initial set of requirements.
        let mem_reqs = get_generated_commands_memory_requirements_nv(
            device,
            bind_point,
            pipeline_handle,
            cmd_layouts[0].get(),
            max_sequences_count,
        );

        // Now request it a second time, varying some parameters if needed.
        let mut second_count = max_sequences_count;
        let mut second_layout = cmd_layouts[0].get();
        if mem_reqs_case == ConstantCommandsMemoryReqsCase::IncreaseCount {
            second_count *= 2;
        }
        if mem_reqs_case == ConstantCommandsMemoryReqsCase::IgnoreUnordered {
            second_layout = cmd_layouts[1].get();
        }

        // Get a second set of memory requirements.
        let other_mem_reqs = get_generated_commands_memory_requirements_nv(
            device,
            bind_point,
            pipeline_handle,
            second_layout,
            second_count,
        );

        // Compare requirements.
        let mut error_message = String::new();
        if mem_reqs_case == ConstantCommandsMemoryReqsCase::IncreaseCount {
            if mem_reqs.size > other_mem_reqs.size {
                error_message = "Required memory size got smaller despite increasing maxSequencesCount".to_string();
            }
        } else if mem_reqs.size != other_mem_reqs.size {
            error_message = "Required memory size changed between calls".to_string();
        }
        if error_message.is_empty() && mem_reqs.alignment != other_mem_reqs.alignment {
            error_message = "Required memory alignment changed between calls".to_string();
        }
        if error_message.is_empty() && mem_reqs.memory_type_bits != other_mem_reqs.memory_type_bits {
            error_message = "Required memory type bites changed between calls".to_string();
        }

        if !error_message.is_empty() {
            log::error!("First: {mem_reqs:?}\nSecond: {other_mem_reqs:?}");
            return Ok(TestStatus::fail(error_message));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCComputeGetInfoTests`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_get_info_tests_nv() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    let mut add = |name: String, variant: Variant| {
        cases.push((
            format!("nv.compute.get_info.{name}"),
            Box::new(GetInfoCase { name, variant }) as Box<dyn TestCase>,
        ));
    };

    add(
        "constant_pipeline_memory_requirements".to_string(),
        Variant::PipelineMemoryRequirements,
    );
    add(
        "constant_pipeline_device_address".to_string(),
        Variant::PipelineDeviceAddress,
    );
    add(
        "constant_pipeline_capture_replay_address".to_string(),
        Variant::PipelineCaptureReplayAddress,
    );

    let cmd_mem_cases = [
        (ConstantCommandsMemoryReqsCase::BasicCase, "basic_case"),
        (
            ConstantCommandsMemoryReqsCase::BasicCaseWithPipeline,
            "basic_case_with_pipeline",
        ),
        (ConstantCommandsMemoryReqsCase::IncreaseCount, "increase_count"),
        (ConstantCommandsMemoryReqsCase::MaxSequenceCount, "max_sequence_count"),
        (ConstantCommandsMemoryReqsCase::IgnoreUnordered, "ignore_unordered_flag"),
    ];
    for (case, name) in cmd_mem_cases {
        add(
            format!("constant_cmd_memory_requirements_{name}"),
            Variant::CommandsMemoryRequirements(case),
        );
    }
    cases
}

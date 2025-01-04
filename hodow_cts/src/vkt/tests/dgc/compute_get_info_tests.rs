// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeGetInfoTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are pre-expanded in `shaders/manifest/dgc_compute_get_info.toml`
// (`scripts/gen_dgc_compute_get_info_manifest.py`): with and without the push constant. The pipeline layout is the one of the pipeline wrapper.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::dgc_compute_get_info::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::dgc::util_ext::{
    DgcComputeSupportType, DgcMemReqsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt,
    check_dgc_ext_compute_support, device_generated_commands_properties,
    get_generated_commands_memory_requirements_ext,
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

struct GetInfoCase {
    name: String,
    mem_reqs_case: ConstantCommandsMemoryReqsCase,
    needs_pipeline: bool,
}

impl GetInfoCase {
    fn key(&self) -> &'static str {
        if self.mem_reqs_case == ConstantCommandsMemoryReqsCase::IncreaseCount {
            "get_info_pc"
        } else {
            "get_info_basic"
        }
    }
}

impl TestCase for GetInfoCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let support_type = if self.needs_pipeline {
            DgcComputeSupportType::BindPipeline
        } else {
            DgcComputeSupportType::Basic
        };
        check_dgc_ext_compute_support(context, support_type)
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.key())
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GetInfoInstance {
            context,
            mem_reqs_case: self.mem_reqs_case,
        })
    }
}

struct GetInfoInstance<'a> {
    context: &'a Context<'a>,
    mem_reqs_case: ConstantCommandsMemoryReqsCase,
}

impl TestInstance for GetInfoInstance<'_> {
    /// `constantCommandsMemReqs`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let mem_reqs_case = self.mem_reqs_case;
        let device = context.get_device();
        let shader_stage = vk::ShaderStageFlags::COMPUTE;

        // We need an indirect execution set if the commands layout contains a pipeline token.
        let indirect_execution_set_needed = mem_reqs_case == ConstantCommandsMemoryReqsCase::BasicCaseWithPipeline;
        // Non-zero reasonable count.
        let max_pipeline_count = if indirect_execution_set_needed { 64 } else { 0 };

        // We'll pretend to use push constants in one particular case, even if they're not used by the compute shader.
        let needs_push_constant = mem_reqs_case == ConstantCommandsMemoryReqsCase::IncreaseCount;
        let pc_size = std::mem::size_of::<u32>() as u32;
        let pc_range = vk::PushConstantRange {
            stage_flags: shader_stage,
            offset: 0,
            size: pc_size,
        };

        // We will pretend to use preprocess in some cases.
        let needs_preprocess = mem_reqs_case == ConstantCommandsMemoryReqsCase::BasicCase;

        // For the flag ignore test, we'll need two actual indirect command layouts.
        let builder_count = if mem_reqs_case == ConstantCommandsMemoryReqsCase::IgnoreUnordered {
            2
        } else {
            1
        };

        // The set and pipeline layout are always needed to create the indirect commands layout.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        let mut compute_pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        compute_pipeline.set_descriptor_set_layout(*set_layout);
        if needs_push_constant {
            compute_pipeline.add_push_constant_range(pc_range);
        }
        if indirect_execution_set_needed {
            compute_pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
        }
        compute_pipeline.build_pipeline()?;
        let pipeline_layout = compute_pipeline.get_pipeline_layout();

        let mut execution_set_handle = vk::IndirectExecutionSetEXT::null();
        let mut pipeline = compute_pipeline.get_pipeline();
        let execution_set_manager = if indirect_execution_set_needed {
            let manager = ExecutionSetManagerExt::new_pipeline(device, pipeline, max_pipeline_count)?;
            execution_set_handle = manager.get();
            // The normal pipeline of upstream stays null when a DGC pipeline is used.
            pipeline = vk::Pipeline::null();
            Some(manager)
        } else {
            None
        };

        // Now build a command sequence. It will be different depending on the case. The flags will also vary a bit.
        let layout_usage_flags = if needs_preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };

        let mut builders = Vec::new();
        for i in 0..builder_count {
            let extra_flags = if i > 0 {
                vk::IndirectCommandsLayoutUsageFlagsEXT::UNORDERED_SEQUENCES
            } else {
                vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
            };
            let mut current_builder =
                IndirectCommandsLayoutBuilderExt::new(layout_usage_flags | extra_flags, shader_stage, pipeline_layout);

            match mem_reqs_case {
                ConstantCommandsMemoryReqsCase::BasicCase => current_builder.add_dispatch_token(0),
                ConstantCommandsMemoryReqsCase::BasicCaseWithPipeline => {
                    current_builder.add_compute_pipeline_token(0);
                    let stream_range = current_builder.get_stream_stride();
                    current_builder.add_dispatch_token(stream_range);
                }
                ConstantCommandsMemoryReqsCase::IncreaseCount => {
                    current_builder.add_push_constant_token(0, pc_range);
                    let stream_range = current_builder.get_stream_stride();
                    current_builder.add_dispatch_token(stream_range);
                }
                ConstantCommandsMemoryReqsCase::MaxSequenceCount => current_builder.add_dispatch_token(0),
                ConstantCommandsMemoryReqsCase::IgnoreUnordered => current_builder.add_dispatch_token(0),
            }
            builders.push(current_builder);
        }

        let mut cmd_layouts = Vec::new();
        for builder in &builders {
            cmd_layouts.push(builder.build(device)?);
        }

        // For the maxSequencesCount value, we'll use something reasonable.
        let max_sequences_count = if mem_reqs_case == ConstantCommandsMemoryReqsCase::MaxSequenceCount {
            device_generated_commands_properties(context).max_indirect_sequence_count
        } else {
            1024
        };

        // Get an initial set of requirements.
        let mut mem_reqs_info = DgcMemReqsInfo::new(
            execution_set_handle,
            cmd_layouts[0].get(),
            max_sequences_count,
            0,
            pipeline,
        );
        let mem_reqs = get_generated_commands_memory_requirements_ext(device, mem_reqs_info.get());

        // Now request it a second time, varying some parameters if needed.
        if mem_reqs_case == ConstantCommandsMemoryReqsCase::IncreaseCount {
            let doubled = mem_reqs_info.get().max_sequence_count * 2;
            mem_reqs_info.set_max_sequence_count(doubled);
        }

        if mem_reqs_case == ConstantCommandsMemoryReqsCase::IgnoreUnordered {
            mem_reqs_info.set_commands_layout(cmd_layouts[1].get());
        }

        // Get a second set of memory requirements.
        let other_mem_reqs = get_generated_commands_memory_requirements_ext(device, mem_reqs_info.get());

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

        drop(execution_set_manager);

        if !error_message.is_empty() {
            log::error!("First: {mem_reqs:?}\nSecond: {other_mem_reqs:?}");
            return Ok(TestStatus::fail(error_message));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCComputeGetInfoTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_get_info_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let cmd_mem_cases = [
        (ConstantCommandsMemoryReqsCase::BasicCase, false, "basic_case"),
        (
            ConstantCommandsMemoryReqsCase::BasicCaseWithPipeline,
            true,
            "basic_case_with_pipeline",
        ),
        (ConstantCommandsMemoryReqsCase::IncreaseCount, false, "increase_count"),
        (
            ConstantCommandsMemoryReqsCase::MaxSequenceCount,
            false,
            "max_sequence_count",
        ),
        (
            ConstantCommandsMemoryReqsCase::IgnoreUnordered,
            false,
            "ignore_unordered_flag",
        ),
    ];
    cmd_mem_cases
        .into_iter()
        .map(|(mem_reqs_case, needs_pipeline, name)| {
            let test_name = format!("constant_cmd_memory_requirements_{name}");
            (
                format!("ext.compute.get_info.{test_name}"),
                Box::new(GetInfoCase {
                    name: test_name,
                    mem_reqs_case,
                    needs_pipeline,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}

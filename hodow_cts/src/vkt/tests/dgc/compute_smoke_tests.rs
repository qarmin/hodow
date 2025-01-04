// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeSmokeTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are pre-expanded in `shaders/manifest/dgc_compute_smoke.toml`
// (`scripts/gen_dgc_compute_smoke_manifest.py`), one set per sequence count and "commands from a compute shader" flag.
//
// These smoke tests use dispatches but no pipeline binds nor push constants: each dispatch launches a pseudorandom number of workgroups in
// [1, 256] along a pseudorandom axis, every invocation increases the counter of its workgroup index, and the end result is fairly unique per
// group of sequences.

use std::collections::BTreeMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDeviceGeneratedCommandsExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::dgc_compute_smoke::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::dgc::util_ext::{
    DgcComputeSupportType, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_compute_support, preprocess_to_execute_barrier_ext,
};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum PreprocessType {
    None,
    /// stateCommandBuffer is the same as the main command buffer.
    StateSame,
    /// stateCommandbuffer is a separate command buffer.
    StateOther,
}

#[derive(Clone, Copy)]
struct SmokeTestParams {
    /// Number of sequences to generate.
    sequence_count: u32,
    /// Do an explicit preprocessing stage.
    pre_process: PreprocessType,
    /// Make the indirect commands buffer host-visible.
    host_visible: bool,
    /// Generate the indirect commands from another compute shader.
    pre_compute: bool,
    /// Attempt to use a compute queue instead of a universal queue.
    compute_queue: bool,
    /// Include the VK_INDIRECT_COMMANDS_LAYOUT_USAGE_UNORDERED_SEQUENCES_BIT_EXT bit?
    unordered: bool,
}

impl SmokeTestParams {
    fn do_preprocess(&self) -> bool {
        self.pre_process != PreprocessType::None
    }
}

const LOCAL_INVOCATIONS: u32 = 64;
const MAX_WORK_GROUPS: u32 = 256;

struct SmokeTestCase {
    name: String,
    key: String,
    params: SmokeTestParams,
}

impl TestCase for SmokeTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_dgc_ext_compute_support(context, DgcComputeSupportType::Basic)?;

        // This is needed for the scopes and semantics.
        let mut memory_model_features = vk::PhysicalDeviceVulkanMemoryModelFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut memory_model_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if memory_model_features.vulkan_memory_model == vk::FALSE {
            return Err(TestError::NotSupported("vulkanMemoryModel not supported".to_string()));
        }

        if self.params.compute_queue && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("No compute queue available".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SmokeTestInstance {
            context,
            params: self.params,
        })
    }
}

/// A descriptor set and the pool it came from; the set is declared first so it is freed before its pool.
struct DescriptorSetWithPool<'a> {
    set: UniqueDescriptorSet<'a>,
    _pool: Unique<'a, vk::DescriptorPool>,
}

struct SmokeTestInstance<'a> {
    context: &'a Context<'a>,
    params: SmokeTestParams,
}

fn cmd_pipeline_memory_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::MemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

impl TestInstance for SmokeTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let stages = vk::ShaderStageFlags::COMPUTE;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER; // Used by all buffers in shaders.
        let (queue, qf_index) = if params.compute_queue {
            context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("No compute queue available".to_string()))?
        } else {
            (
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )
        };

        let randomizer_seed = (params.sequence_count << 4)
            | (u32::from(params.host_visible) << 3)
            | (u32::from(params.pre_compute) << 2)
            | ((params.pre_process as u32) << 1)
            | u32::from(params.compute_queue);

        // Pipelines, built in advance.
        let comp_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stages)
            .build(device)?;
        let gen_set_layout = if params.pre_compute {
            Some(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(desc_type, stages)
                    .add_single_binding(desc_type, stages)
                    .build(device)?,
            )
        } else {
            None
        };

        let binaries = context.get_binary_collection();
        let mut comp_pipeline =
            ComputePipelineWrapper::new(device, ComputePipelineConstructionType::Pipeline, binaries.get("comp")?);
        comp_pipeline.set_descriptor_set_layout(*comp_set_layout);
        comp_pipeline.build_pipeline()?;

        let gen_pipeline = match &gen_set_layout {
            Some(layout) => {
                let mut pipeline = ComputePipelineWrapper::new(
                    device,
                    ComputePipelineConstructionType::Pipeline,
                    binaries.get("gen")?,
                );
                pipeline.set_descriptor_set_layout(**layout);
                pipeline.build_pipeline()?;
                Some(pipeline)
            }
            None => None,
        };

        // Indirect commands layout.
        let mut cmd_layout_usage_flags = vk::IndirectCommandsLayoutUsageFlagsEXT::empty();
        if params.do_preprocess() {
            cmd_layout_usage_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS;
        }
        // Note compute pipelines are unordered by default. Explicitly adding the flag should be a no-op and nothing should crash.
        if params.unordered {
            cmd_layout_usage_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::UNORDERED_SEQUENCES;
        }
        let mut cmd_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmd_layout_usage_flags, stages, comp_pipeline.get_pipeline_layout());
        cmd_layout_builder.add_dispatch_token(0);
        let cmd_layout = cmd_layout_builder.build(device)?;

        // Create a buffer to contain execution results.
        let mut results = vec![0u32; MAX_WORK_GROUPS as usize];
        let results_buffer = create_host_buffer(context, &results, vk::BufferUsageFlags::STORAGE_BUFFER)?;

        // Pseudorandomly generate indirect dispatch commands.
        let mut rnd = Random::new(randomizer_seed);
        let mut indirect_commands: Vec<vk::DispatchIndirectCommand> =
            Vec::with_capacity(params.sequence_count as usize);
        for _ in 0..params.sequence_count {
            let dispatch_size = rnd.get_int(1, MAX_WORK_GROUPS as i32) as u32;
            let major_dim = rnd.get_int(0, 2);

            let mut cmd = vk::DispatchIndirectCommand { x: 1, y: 1, z: 1 };
            let axis = match major_dim {
                0 => &mut cmd.x,
                1 => &mut cmd.y,
                _ => &mut cmd.z,
            };
            *axis = dispatch_size;
            indirect_commands.push(cmd);
        }

        // Depending on host_visible and pre_compute, we will have one or more buffers, with different usage flags. We will always have a
        // host-visible initial buffer that we will use to copy the above commands into.
        let memory_requirement_host_visible_only = MemoryRequirement::HOST_VISIBLE;
        let memory_requirement_host_visible_device_address =
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS;
        let memory_requirement_local_device_address = MemoryRequirement::LOCAL | MemoryRequirement::DEVICE_ADDRESS;

        let mut second_buffer = false;

        #[expect(
            unused_assignments,
            reason = "upstream initialises it before the branches that set it"
        )]
        let mut first_buffer_usage = vk::BufferUsageFlags::empty();
        let mut second_buffer_usage = vk::BufferUsageFlags::empty();
        let indirect_usage_flags = vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;

        let mut first_buffer_mem_req = memory_requirement_host_visible_only;
        let mut second_buffer_mem_req = memory_requirement_local_device_address;

        if params.pre_compute {
            second_buffer = true;
            first_buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER;
            second_buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER | indirect_usage_flags;

            if params.host_visible {
                second_buffer_mem_req = memory_requirement_host_visible_device_address;
            }
        } else if params.host_visible {
            first_buffer_usage = indirect_usage_flags;
            first_buffer_mem_req = memory_requirement_host_visible_device_address;
        } else {
            second_buffer = true;
            first_buffer_usage = vk::BufferUsageFlags::TRANSFER_SRC;
            second_buffer_usage = indirect_usage_flags | vk::BufferUsageFlags::TRANSFER_DST;
        }

        let indirect_cmds_buffer_size = std::mem::size_of_val(indirect_commands.as_slice()) as vk::DeviceSize;

        let first_cmds_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(indirect_cmds_buffer_size, first_buffer_usage),
            first_buffer_mem_req,
        )?;
        let mut indirect_cmds_buffer_handle = first_cmds_buffer.get();

        // Copy indirect commands to the first commands buffer.
        {
            let alloc = first_cmds_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indirect_commands.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    indirect_cmds_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // If needed, create a second buffer to hold indirect commands.
        let second_cmds_buffer = if second_buffer {
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(indirect_cmds_buffer_size, second_buffer_usage),
                second_buffer_mem_req,
            )?;
            indirect_cmds_buffer_handle = buffer.get();
            Some(buffer)
        } else {
            None
        };

        // Create preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmd_layout.get(),
            params.sequence_count,
            0,
            comp_pipeline.get_pipeline(),
            0,
        )?;

        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        // Prepare descriptor sets.
        let gen_descriptor = match (&gen_set_layout, &second_cmds_buffer) {
            (Some(layout), Some(second)) => {
                let pool = DescriptorPoolBuilder::new().add_type(desc_type, 2).build(
                    device,
                    vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                    1,
                )?;
                let set = make_descriptor_set(device, *pool, **layout)?;

                let first_buffer_desc_info = make_descriptor_buffer_info(first_cmds_buffer.get(), 0, vk::WHOLE_SIZE);
                let second_buffer_desc_info = make_descriptor_buffer_info(second.get(), 0, vk::WHOLE_SIZE);
                DescriptorSetUpdateBuilder::new()
                    .write_single(set.get(), Location::binding(0), desc_type, &first_buffer_desc_info)
                    .write_single(set.get(), Location::binding(1), desc_type, &second_buffer_desc_info)
                    .update(device);
                Some(DescriptorSetWithPool { set, _pool: pool })
            }
            _ => None,
        };
        let comp_descriptor = {
            let pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                1,
            )?;
            let set = make_descriptor_set(device, *pool, *comp_set_layout)?;

            let results_buffer_desc_info = make_descriptor_buffer_info(results_buffer.get(), 0, vk::WHOLE_SIZE);
            DescriptorSetUpdateBuilder::new()
                .write_single(set.get(), Location::binding(0), desc_type, &results_buffer_desc_info)
                .update(device);
            DescriptorSetWithPool { set, _pool: pool }
        };

        begin_command_buffer(device, cmd_buffer)?;
        if let (Some(gen_pipeline), Some(gen_descriptor)) = (&gen_pipeline, &gen_descriptor) {
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    gen_pipeline.get_pipeline_layout(),
                    0,
                    &[gen_descriptor.set.get()],
                    &[] as &[u32],
                );
            }
            gen_pipeline.bind(cmd_buffer);
            unsafe { device.cmd_dispatch(cmd_buffer, 1, 1, 1) };
            // Synchronize precompute writes with indirect dispatches.
            cmd_pipeline_memory_barrier(
                device,
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::DRAW_INDIRECT,
                make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::INDIRECT_COMMAND_READ),
            );
        } else if !params.host_visible {
            let second = second_cmds_buffer
                .as_ref()
                .ok_or_else(|| TestError::InternalError("the second commands buffer is missing".to_string()))?;
            let copy_region = vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: indirect_cmds_buffer_size,
            };
            unsafe { device.cmd_copy_buffer(cmd_buffer, first_cmds_buffer.get(), second.get(), &[copy_region]) };
            // Synchronize transfer with indirect dispatches.
            cmd_pipeline_memory_barrier(
                device,
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::DRAW_INDIRECT,
                make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::INDIRECT_COMMAND_READ),
            );
        }

        let indirect_cmds_buffer_address = buffer_device_address(device, indirect_cmds_buffer_handle);

        let generated_commands_info = DgcGenCmdsInfo::new(
            stages,
            vk::IndirectExecutionSetEXT::null(),
            cmd_layout.get(),
            indirect_cmds_buffer_address,
            indirect_cmds_buffer_size,
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            params.sequence_count,
            0,
            0,
            comp_pipeline.get_pipeline(),
        );

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                comp_pipeline.get_pipeline_layout(),
                0,
                &[comp_descriptor.set.get()],
                &[] as &[u32],
            );
        }
        comp_pipeline.bind(cmd_buffer);
        // Must outlive the submission: it is the state command buffer of the preprocess command and upstream never ends it.
        let mut separate_cmd_buffer = None;
        if params.do_preprocess() {
            let is_separate = params.pre_process == PreprocessType::StateOther;
            if is_separate {
                let separate = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                begin_command_buffer(device, separate.get())?;
                unsafe {
                    device.cmd_bind_descriptor_sets(
                        separate.get(),
                        bind_point,
                        comp_pipeline.get_pipeline_layout(),
                        0,
                        &[comp_descriptor.set.get()],
                        &[] as &[u32],
                    );
                }
                comp_pipeline.bind(separate.get());
                separate_cmd_buffer = Some(separate);
            }
            let state_command_buffer = separate_cmd_buffer
                .as_ref()
                .map_or(cmd_buffer, |separate| separate.get());
            unsafe {
                device.cmd_preprocess_generated_commands_ext(
                    cmd_buffer,
                    generated_commands_info.get(),
                    state_command_buffer,
                )
            };
            preprocess_to_execute_barrier_ext(device, cmd_buffer);
        }
        unsafe {
            device.cmd_execute_generated_commands_ext(cmd_buffer, params.do_preprocess(), generated_commands_info.get())
        };
        // Make results buffer available on the host.
        cmd_pipeline_memory_barrier(
            device,
            cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ),
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        let results_alloc = results_buffer.get_allocation();
        invalidate_alloc(device, results_alloc)?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                results_alloc.get_host_ptr().cast::<u32>(),
                results.as_mut_ptr(),
                results.len(),
            )
        };

        // How many commands have a particular work group count. E.g. if the pseudorandom work group counts generated above are 21, 43,
        // 21 and 15, the map will end up containing: 15 -> 1, 21 -> 2, 43 -> 1.
        let mut counter_map: BTreeMap<u32, u32> = BTreeMap::new();
        for indirect_cmd in &indirect_commands {
            let num_work_groups = indirect_cmd.x * indirect_cmd.y * indirect_cmd.z;
            *counter_map.entry(num_work_groups).or_insert(0) += 1;
        }
        // Now accumulate results in reverse order to calculate how many dispatches contain that count or more. The map ends up with:
        // 15 -> 4 dispatches, 21 -> 3 dispatches, 43 -> 1 dispatch.
        {
            let mut accumulated = 0u32;
            for count in counter_map.values_mut().rev() {
                *count += accumulated;
                accumulated = *count;
            }
        }
        // Now we now that results in the range [0, 15) have been affected by 4 dispatches, values in [15, 21) by 3 and values in the range
        // [21, 43) by 1. The rest stay at 0. For this last point, insert a new element in the map if needed.
        if let Some((&last, _)) = counter_map.iter().next_back()
            && last != MAX_WORK_GROUPS
        {
            counter_map.insert(MAX_WORK_GROUPS, 0);
        }

        // Verify results are as expected.
        let mut test_ok = true;
        let mut range_begin = 0u32;
        for (&range_end, &range_end_dispatches) in &counter_map {
            let expected_value = range_end_dispatches * LOCAL_INVOCATIONS;
            log::debug!("Verifying range [{range_begin}, {range_end}) contains {expected_value}");
            for i in range_begin..range_end {
                if results[i as usize] != expected_value {
                    test_ok = false;
                    log::error!("results[{i}] = {} but expected {expected_value}", results[i as usize]);
                }
            }
            range_begin = range_end;
        }

        if !test_ok {
            // Log the full indirect commands list and the full results buffer.
            for (i, indirect_cmd) in indirect_commands.iter().enumerate() {
                log::error!(
                    "indirectCommands[{i}] = {{{}, {}, {}}}",
                    indirect_cmd.x,
                    indirect_cmd.y,
                    indirect_cmd.z
                );
            }
            for (i, result) in results.iter().enumerate() {
                log::error!("results[{i}] = {result}");
            }
            return Ok(TestStatus::fail("Unexpected results; check log for details"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCComputeSmokeTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_smoke_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let preprocess_cases = [
        (PreprocessType::None, "no_preprocess"),
        (PreprocessType::StateSame, "preprocess_state_same"),
        (PreprocessType::StateOther, "preprocess_state_separate"),
    ];

    let mut cases = Vec::new();
    for sequence_count in [4u32, 1024] {
        for host_visible in [false, true] {
            for pre_compute in [false, true] {
                for (pre_process, pp_string) in preprocess_cases {
                    for compute_queue in [false, true] {
                        // Some variants will set the unordered bit.
                        let unordered = sequence_count == 1024;
                        let params = SmokeTestParams {
                            sequence_count,
                            pre_process,
                            host_visible,
                            pre_compute,
                            compute_queue,
                            unordered,
                        };

                        let hv_string = if host_visible { "host_visible" } else { "device_local" };
                        let pc_string = if pre_compute { "from_compute" } else { "from_host" };
                        let cq_string = if compute_queue {
                            "compute_queue"
                        } else {
                            "universal_queue"
                        };
                        let test_name =
                            format!("{sequence_count}_sequences_{hv_string}_{pc_string}_{pp_string}_{cq_string}");
                        let key = format!("smoke_s{sequence_count}_{}", if pre_compute { "gen" } else { "host" });

                        cases.push((
                            format!("ext.compute.smoke.{test_name}"),
                            Box::new(SmokeTestCase {
                                name: test_name,
                                key,
                                params,
                            }) as Box<dyn TestCase>,
                        ));
                    }
                }
            }
        }
    }
    cases
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputePreprocessTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The program is pre-expanded in `shaders/manifest/dgc_compute_preprocess.toml`
// (`scripts/gen_dgc_compute_preprocess_manifest.py`). The pipeline layout is the one of the pipeline wrapper.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtDeviceGeneratedCommandsExtensionDeviceCommands;

use crate::generated::shaders::dgc_compute_preprocess::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
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
    check_dgc_ext_compute_support, preprocess_to_execute_barrier_ext,
};
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Method {
    UniversalQueue,
    ComputeQueue,
    PreprocessComputeExecuteUniversal,
    PreprocessUniversalExecuteCompute,
}

fn has_queue_switch(method: Method) -> bool {
    matches!(
        method,
        Method::PreprocessComputeExecuteUniversal | Method::PreprocessUniversalExecuteCompute
    )
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum StateCmdBuffer {
    Same,
    Other,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CountBuffer {
    /// No count buffer.
    No,
    /// Using a count buffer.
    Yes,
    /// Using a count buffer, but the count is zero.
    YesButZero,
}

#[derive(Clone, Copy)]
struct PreprocessParams {
    method: Method,
    count_buffer: CountBuffer,
    state_cmd_buffer: StateCmdBuffer,
}

fn uses_universal_queue(method: Method) -> bool {
    method != Method::ComputeQueue
}

fn uses_compute_queue(method: Method) -> bool {
    method != Method::UniversalQueue
}

struct PreprocessCase {
    name: String,
    params: PreprocessParams,
}

impl TestCase for PreprocessCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkDGCComputeAndQueueSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_dgc_ext_compute_support(context, DgcComputeSupportType::Basic)?;

        if uses_compute_queue(self.params.method) && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("No compute queue available".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "preprocess_store_pc")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PreprocessInstance {
            context,
            params: self.params,
        })
    }
}

struct PreprocessInstance<'a> {
    context: &'a Context<'a>,
    params: PreprocessParams,
}

/// A fence of `submitCommands`, destroyed when dropped.
struct SubmitFence<'a> {
    device: &'a Device,
    fence: vk::Fence,
}

impl Drop for SubmitFence<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_fence(self.fence, None) };
    }
}

/// `submitCommands`: submits without waiting.
fn submit_commands<'a>(
    device: &'a Device,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
) -> Result<SubmitFence<'a>, TestError> {
    let fence_info = vk::FenceCreateInfo::builder();
    let fence = unsafe { device.create_fence(&fence_info, None) }.vk_check("vkCreateFence")?;
    let fence = SubmitFence { device, fence };
    let cmd_buffers = [cmd_buffer];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
    unsafe { device.queue_submit(queue, &[submit_info], fence.fence) }.vk_check("vkQueueSubmit")?;
    Ok(fence)
}

/// `waitForFence`
fn wait_for_fence(fence: &SubmitFence<'_>) -> Result<(), TestError> {
    unsafe { fence.device.wait_for_fences(&[fence.fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

/// Record a memory barrier from compute shader writes to host reads.
pub(super) fn shader_write_to_host_barrier(device: &Device, cmd_buffer: vk::CommandBuffer) {
    let pre_host_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[pre_host_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// Creates a buffer memory barrier structure to sync access from preprocessing to execution.
pub(super) fn make_preprocess_to_execute_barrier(
    buffer: vk::Buffer,
    size: vk::DeviceSize,
    src_queue_index: u32,
    dst_queue_index: u32,
) -> vk::BufferMemoryBarrier {
    vk::BufferMemoryBarrier {
        src_access_mask: vk::AccessFlags::COMMAND_PREPROCESS_WRITE_EXT,
        dst_access_mask: vk::AccessFlags::INDIRECT_COMMAND_READ,
        src_queue_family_index: src_queue_index,
        dst_queue_family_index: dst_queue_index,
        buffer,
        offset: 0,
        size,
        ..Default::default()
    }
}

struct QueueInfo {
    qf_index: u32,
    queue: vk::Queue,
    cmd_pool: vk::CommandPool,
}

impl TestInstance for PreprocessInstance<'_> {
    /// `parallelPreprocessRun`: we'll use a single sequence buffer and a single storage buffer, but we'll work with 2 indirect commands
    /// executions by using offsets into them.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let u32_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let execute_count = 2usize;
        let use_count_buffer = params.count_buffer != CountBuffer::No;
        // For the info structure when using a count buffer.
        let fake_count = 100u32;
        let real_count = 1u32;

        // Sequence count buffer.
        let mut sequences_count_buffers = Vec::new();
        if use_count_buffer {
            for _ in 0..execute_count {
                let buffer = DgcBuffer::new(
                    context,
                    u32_size,
                    vk::BufferUsageFlags::empty(),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                let allocation = buffer.get_allocation();
                let count = if params.count_buffer == CountBuffer::YesButZero {
                    0u32
                } else {
                    real_count
                };
                unsafe {
                    std::ptr::copy_nonoverlapping((&count as *const u32).cast::<u8>(), allocation.get_host_ptr(), 4)
                };
                flush_alloc(device, allocation)?;
                sequences_count_buffers.push(buffer);
            }
        }

        // Output buffers.
        let mut output_buffers = Vec::new();
        for _ in 0..execute_count {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(u32_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let allocation = buffer.get_allocation();
            unsafe { std::ptr::write_bytes(allocation.get_host_ptr(), 0, u32_size as usize) };
            flush_alloc(device, allocation)?;
            output_buffers.push(buffer);
        }

        // Descriptor set layout, pool and sets preparation. The layout is the same for both executions.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stage_flags)
            .build(device)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(desc_type, execute_count as u32)
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                execute_count as u32,
            )?;

        let mut descriptor_sets = Vec::new();
        for _ in 0..execute_count {
            descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, *set_layout)?);
        }

        let mut set_update_builder = DescriptorSetUpdateBuilder::new();
        for (i, buffer) in output_buffers.iter().enumerate() {
            let output_buffer_desc_info = make_descriptor_buffer_info(buffer.get(), 0, u32_size);
            set_update_builder = set_update_builder.write_single(
                descriptor_sets[i].get(),
                Location::binding(0),
                desc_type,
                &output_buffer_desc_info,
            );
        }
        set_update_builder.update(device);

        // Push constants
        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: u32_size as u32,
        };

        // Shader, pipeline layout and pipeline.
        let mut compute_pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        compute_pipeline.set_descriptor_set_layout(*set_layout);
        compute_pipeline.add_push_constant_range(pc_range);
        compute_pipeline.build_pipeline()?;
        let pipeline_layout = compute_pipeline.get_pipeline_layout();
        let pipeline = compute_pipeline.get_pipeline();

        // Generated commands layout: push constant followed by a dispatch, with preprocessing.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS,
            stage_flags,
            pipeline_layout,
        );
        cmds_layout_builder.add_push_constant_token(0, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generate value for push constant "i". We'll reuse this in the verification part.
        let get_push_constant = |i: u32| i + 100;

        // Generated indirect commands buffer contents. Note we'll split this in two executions.
        let mut gen_cmd_data_vecs: Vec<Vec<u32>> = Vec::new();
        for i in 0..execute_count as u32 {
            // push constant + indirect dispatch args (x, y, z)
            gen_cmd_data_vecs.push(vec![get_push_constant(i), 1, 1, 1]);
        }

        // Buffers for generated indirect commands.
        let gen_cmds_buffer_size = std::mem::size_of_val(gen_cmd_data_vecs[0].as_slice()) as vk::DeviceSize;
        let mut gen_cmd_buffers = Vec::new();
        for cmd_data in &gen_cmd_data_vecs {
            let cmds_buffer = DgcBuffer::new(
                context,
                gen_cmds_buffer_size,
                vk::BufferUsageFlags::empty(),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let alloc = cmds_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    cmd_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    gen_cmds_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
            gen_cmd_buffers.push(cmds_buffer);
        }

        // Preprocess buffers for 1 sequence. We'll make them separate in this case.
        let mut preprocess_buffers = Vec::new();
        for _ in 0..execute_count {
            // We need to pass the fake count here in some cases due to VUID-VkGeneratedCommandsInfoNV-sequencesCount-02917.
            let preprocess_sequences_count = if use_count_buffer { fake_count } else { real_count };
            preprocess_buffers.push(PreprocessBufferExt::new(
                context,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                preprocess_sequences_count,
                0,
                pipeline,
                0,
            )?);
        }

        let mut cmd_infos = Vec::new();
        for i in 0..execute_count {
            let preprocess_buffer = &preprocess_buffers[i];
            let gen_cmd_buffer = &gen_cmd_buffers[i];
            let count_buffer_address = if use_count_buffer {
                sequences_count_buffers[i].get_device_address()
            } else {
                0
            };
            let info_sequences_count = if use_count_buffer { fake_count } else { real_count };

            cmd_infos.push(DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                gen_cmd_buffer.get_device_address(),
                gen_cmds_buffer_size,
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                info_sequences_count,
                count_buffer_address,
                0,
                pipeline,
            ));
        }

        let need_universal = uses_universal_queue(params.method);
        let need_compute = uses_compute_queue(params.method);

        let universal_pool;
        let compute_pool;
        let mut universal_info = None;
        let mut compute_info = None;
        if need_universal {
            let qf_index = context.get_universal_queue_family_index();
            universal_pool = Some(make_command_pool(device, qf_index)?);
            universal_info = Some(QueueInfo {
                qf_index,
                queue: context.get_universal_queue(),
                cmd_pool: **universal_pool
                    .as_ref()
                    .ok_or_else(|| TestError::InternalError("no pool".to_string()))?,
            });
        } else {
            universal_pool = None;
        }
        if need_compute {
            let (queue, qf_index) = context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("No compute queue available".to_string()))?;
            compute_pool = Some(make_command_pool(device, qf_index)?);
            compute_info = Some(QueueInfo {
                qf_index,
                queue,
                cmd_pool: **compute_pool
                    .as_ref()
                    .ok_or_else(|| TestError::InternalError("no pool".to_string()))?,
            });
        } else {
            compute_pool = None;
        }
        let _keep_pools_alive = (&universal_pool, &compute_pool);

        let missing_queue = || TestError::InternalError("the queue info of the method is missing".to_string());
        let preprocess_queue_info = if matches!(
            params.method,
            Method::UniversalQueue | Method::PreprocessUniversalExecuteCompute
        ) {
            universal_info.as_ref().ok_or_else(missing_queue)?
        } else {
            compute_info.as_ref().ok_or_else(missing_queue)?
        };
        let execute_queue_info = if matches!(
            params.method,
            Method::UniversalQueue | Method::PreprocessComputeExecuteUniversal
        ) {
            universal_info.as_ref().ok_or_else(missing_queue)?
        } else {
            compute_info.as_ref().ok_or_else(missing_queue)?
        };

        let queue_switch = has_queue_switch(params.method);

        let bind_state = |cmd_buffer: vk::CommandBuffer, set: usize| {
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[descriptor_sets[set].get()],
                    &[] as &[u32],
                );
            }
            compute_pipeline.bind(cmd_buffer);
        };

        // These may be used to transfer buffers from the preprocess queue to the execution queue.
        let mut ownership_barriers: Vec<vk::BufferMemoryBarrier> = Vec::new();

        // We will preprocess one sequence first, and wait for the preprocessing to finish using a fence.
        {
            let cmd_buffer_owner =
                allocate_command_buffer(device, preprocess_queue_info.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer_owner.get();

            begin_command_buffer(device, cmd_buffer)?;
            bind_state(cmd_buffer, 0);
            {
                let separate_state = params.state_cmd_buffer == StateCmdBuffer::Other;
                let mut separate_cmd_buffer_owner = None;

                if separate_state {
                    let separate =
                        allocate_command_buffer(device, execute_queue_info.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                    begin_command_buffer(device, separate.get())?;
                    bind_state(separate.get(), 0);
                    separate_cmd_buffer_owner = Some(separate);
                }
                let state_cmd_buffer = separate_cmd_buffer_owner
                    .as_ref()
                    .map_or(cmd_buffer, |separate| separate.get());

                unsafe {
                    device.cmd_preprocess_generated_commands_ext(cmd_buffer, cmd_infos[0].get(), state_cmd_buffer)
                };

                if queue_switch {
                    // When using queue switches, the preprocessing queue will not be the same as the execution queue and buffers need
                    // to be transferred between queues. This is the "release" barrier for those buffers. Make sure we cover every
                    // buffer in use.
                    ownership_barriers.push(make_preprocess_to_execute_barrier(
                        output_buffers[0].get(),
                        u32_size,
                        preprocess_queue_info.qf_index,
                        execute_queue_info.qf_index,
                    ));
                    ownership_barriers.push(make_preprocess_to_execute_barrier(
                        gen_cmd_buffers[0].get(),
                        gen_cmds_buffer_size,
                        preprocess_queue_info.qf_index,
                        execute_queue_info.qf_index,
                    ));

                    if preprocess_buffers[0].get() != vk::Buffer::null() {
                        ownership_barriers.push(make_preprocess_to_execute_barrier(
                            preprocess_buffers[0].get(),
                            preprocess_buffers[0].get_size(),
                            preprocess_queue_info.qf_index,
                            execute_queue_info.qf_index,
                        ));
                    }

                    if use_count_buffer {
                        ownership_barriers.push(make_preprocess_to_execute_barrier(
                            sequences_count_buffers[0].get(),
                            u32_size,
                            preprocess_queue_info.qf_index,
                            execute_queue_info.qf_index,
                        ));
                    }

                    unsafe {
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            vk::PipelineStageFlags::COMMAND_PREPROCESS_EXT,
                            vk::PipelineStageFlags::DRAW_INDIRECT,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &ownership_barriers,
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                    }
                }

                end_command_buffer(device, cmd_buffer)?;
                submit_commands_and_wait(device, preprocess_queue_info.queue, cmd_buffer)?;
            }
        }

        // Separately, execute the preprocessed commands and preprocess+execute the second sequence.
        {
            // Separate command buffer needed sometimes.
            let mut preprocess_cmd_buffer_owner = None;
            // Separate fence needed sometimes.
            let mut execution_fence = None;
            // Saved for later sometimes.
            let mut execute_cmd_buffer: Option<vk::CommandBuffer> = None;

            let execute_cmd_buffer_owner =
                allocate_command_buffer(device, execute_queue_info.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            // The command buffer we are recording and the pool it was allocated from.
            let mut cmd_buffer = execute_cmd_buffer_owner.get();
            let mut cmd_buffer_pool = execute_queue_info.cmd_pool;

            begin_command_buffer(device, cmd_buffer)?;

            if queue_switch {
                // This is the "acquire" barrier to transfer buffer ownership for execution. See above.
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::COMMAND_PREPROCESS_EXT,
                        vk::PipelineStageFlags::DRAW_INDIRECT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &ownership_barriers,
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }

            // Execution of preprocessed commands.
            bind_state(cmd_buffer, 0);
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, true, cmd_infos[0].get()) };

            if queue_switch {
                // Barrier to the host and finish.
                shader_write_to_host_barrier(device, cmd_buffer);
                end_command_buffer(device, cmd_buffer)?;
                // Save this for later.
                execute_cmd_buffer = Some(cmd_buffer);

                // Separate command buffer for the second sequence. Note we call this the "preprocess" command buffer, but we'll do both
                // preprocessing and execution.
                let owner =
                    allocate_command_buffer(device, preprocess_queue_info.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                cmd_buffer = owner.get();
                cmd_buffer_pool = preprocess_queue_info.cmd_pool;
                preprocess_cmd_buffer_owner = Some(owner);

                begin_command_buffer(device, cmd_buffer)?;
            }

            // Preprocessing and execution of the second sequence.
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[descriptor_sets[1].get()],
                    &[] as &[u32],
                );
            }
            if queue_switch {
                // Rebind pipeline. If there's no queue switch, the previous pipeline bind command above still applies because there's
                // no command buffer change.
                compute_pipeline.bind(cmd_buffer);
            }
            let separate_state = params.state_cmd_buffer == StateCmdBuffer::Other;
            let mut separate_cmd_buffer_owner = None;
            if separate_state {
                let separate = allocate_command_buffer(device, cmd_buffer_pool, vk::CommandBufferLevel::PRIMARY)?;
                begin_command_buffer(device, separate.get())?;
                bind_state(separate.get(), 1);
                separate_cmd_buffer_owner = Some(separate);
            }
            let state_cmd_buffer = separate_cmd_buffer_owner
                .as_ref()
                .map_or(cmd_buffer, |separate| separate.get());

            unsafe { device.cmd_preprocess_generated_commands_ext(cmd_buffer, cmd_infos[1].get(), state_cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, cmd_buffer);
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, true, cmd_infos[1].get()) };
            shader_write_to_host_barrier(device, cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;

            // Submit all pending command buffers "simultaneously".
            if let Some(execute_cmd_buffer) = execute_cmd_buffer {
                execution_fence = Some(submit_commands(device, execute_queue_info.queue, execute_cmd_buffer)?);
            }
            let preprocessing_fence = submit_commands(device, preprocess_queue_info.queue, cmd_buffer)?;

            // Wait on all fences.
            wait_for_fence(&preprocessing_fence)?;
            if let Some(execution_fence) = &execution_fence {
                wait_for_fence(execution_fence)?;
            }
            drop(preprocess_cmd_buffer_owner);
        }

        // Verify results.
        let execution = params.count_buffer != CountBuffer::YesButZero;
        let mut fail = false;

        for (i, buffer) in output_buffers.iter().enumerate() {
            let alloc = buffer.get_allocation();
            invalidate_alloc(device, alloc)?;

            let output_buffer_value = unsafe { std::ptr::read_unaligned(alloc.get_host_ptr().cast::<u32>()) };
            let reference = if execution { get_push_constant(i as u32) } else { 0 };

            if output_buffer_value != reference {
                fail = true;
                log::error!(
                    "Unexpected value found in output buffer at position {i}: expected {reference} but found {output_buffer_value}"
                );
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCComputePreprocessTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_preprocess_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let method_cases = [
        (Method::UniversalQueue, "universal"),
        (Method::ComputeQueue, "compute"),
        (Method::PreprocessComputeExecuteUniversal, "compute_with_universal_exec"),
        (Method::PreprocessUniversalExecuteCompute, "universal_with_compute_exec"),
    ];
    let count_buffer_cases = [
        (CountBuffer::No, ""),
        (CountBuffer::Yes, "_with_count_buffer"),
        (CountBuffer::YesButZero, "_with_count_buffer_zero_count"),
    ];
    let state_cmd_buffer_cases = [
        (StateCmdBuffer::Same, ""),
        (StateCmdBuffer::Other, "_separate_state_cmd_buffer"),
    ];

    let mut cases = Vec::new();
    for (method, method_name) in method_cases {
        for (count_buffer, count_suffix) in count_buffer_cases {
            for (state_cmd_buffer, state_suffix) in state_cmd_buffer_cases {
                // When the state command buffer is the same we run preprocessing on, and the preprocess and execution happens on a
                // different queue, the state command buffer would not come from the same queue as the execution command buffer, which
                // is forbidden by the spec.
                if state_cmd_buffer == StateCmdBuffer::Same && has_queue_switch(method) {
                    continue;
                }

                let test_name = format!("parallel_preprocessing_{method_name}{count_suffix}{state_suffix}");
                cases.push((
                    format!("ext.compute.preprocess.{test_name}"),
                    Box::new(PreprocessCase {
                        name: test_name,
                        params: PreprocessParams {
                            method,
                            count_buffer,
                            state_cmd_buffer,
                        },
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases
}

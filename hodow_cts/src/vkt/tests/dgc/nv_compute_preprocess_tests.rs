// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputePreprocessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The program is the push constant store of the EXT preprocess tests
// (`shaders/manifest/dgc_compute_preprocess.toml`, `preprocess_store_pc`), whose source is the one of the NV tests.
//
// `dgc.nv.compute.preprocess` (VK_NV_device_generated_commands_compute): two sequences preprocessed and executed in parallel, optionally across
// the universal and the compute queue and with a (possibly zero) count buffer.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::NvDeviceGeneratedCommandsExtensionDeviceCommands;

use crate::generated::shaders::dgc_compute_preprocess::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_pipeline_layout_with_push_constants,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::dgc::compute_preprocess_tests::{
    make_preprocess_to_execute_barrier, shader_write_to_host_barrier,
};
use crate::vkt::tests::dgc::util_nv::{
    GeneratedCommandsInfoNv, IndirectCommandsLayoutBuilderNv, PreprocessBufferNv, check_dgc_compute_support,
    create_compute_pipeline, make_indirect_commands_stream_nv, preprocess_to_execute_barrier,
};
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Method {
    UniversalQueue,
    ComputeQueue,
    PreprocessComputeExecuteUniversal,
    PreprocessUniversalExecuteCompute,
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
        check_dgc_compute_support(context, false, false)?;
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

struct SubmitFence<'a> {
    device: &'a Device,
    fence: vk::Fence,
}

impl Drop for SubmitFence<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_fence(self.fence, None) };
    }
}

/// `vk::submitCommands`: a submission that is waited for later.
fn submit_commands<'a>(
    device: &'a Device,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
) -> Result<SubmitFence<'a>, TestError> {
    let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
    let fence = SubmitFence { device, fence };
    let cmd_buffers = [cmd_buffer];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
    unsafe { device.queue_submit(queue, &[submit_info], fence.fence) }.vk_check("vkQueueSubmit")?;
    Ok(fence)
}

fn wait_for_fence(fence: &SubmitFence<'_>) -> Result<(), TestError> {
    unsafe { fence.device.wait_for_fences(&[fence.fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

struct QueueInfo {
    qf_index: u32,
    queue: vk::Queue,
    cmd_pool: vk::CommandPool,
}

impl TestInstance for PreprocessInstance<'_> {
    /// `parallelPreprocessRun`: a single sequence buffer and a single storage buffer, but 2 indirect commands executions.
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
        let fake_count = 100u32; // For the info structure when using a count buffer.
        let real_count = 1u32;

        // Sequence count buffers.
        let mut sequences_count_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        if use_count_buffer {
            for _ in 0..execute_count {
                let buffer = BufferWithMemory::new(
                    device,
                    context.get_default_allocator(),
                    make_buffer_create_info(u32_size, vk::BufferUsageFlags::INDIRECT_BUFFER),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                let count: u32 = if params.count_buffer == CountBuffer::YesButZero {
                    0
                } else {
                    real_count
                };
                {
                    let alloc = buffer.get_allocation();
                    // SAFETY: the buffer holds 4 bytes.
                    unsafe { std::ptr::copy_nonoverlapping(count.to_ne_bytes().as_ptr(), alloc.get_host_ptr(), 4) };
                    flush_alloc(device, alloc)?;
                }
                sequences_count_buffers.push(buffer);
            }
        }

        // Output buffers.
        let mut output_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        for _ in 0..execute_count {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(u32_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            {
                let alloc = buffer.get_allocation();
                // SAFETY: the buffer holds 4 bytes.
                unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, 4) };
                flush_alloc(device, alloc)?;
            }
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
        let mut descriptor_sets = Vec::with_capacity(execute_count);
        for _ in 0..execute_count {
            descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, *set_layout)?);
        }
        {
            let mut update_builder = DescriptorSetUpdateBuilder::new();
            let infos: Vec<vk::DescriptorBufferInfo> = output_buffers
                .iter()
                .map(|buffer| make_descriptor_buffer_info(buffer.get(), 0, u32_size))
                .collect();
            for i in 0..execute_count {
                update_builder =
                    update_builder.write_single(descriptor_sets[i].get(), Location::binding(0), desc_type, &infos[i]);
            }
            update_builder.update(device);
        }

        // Push constants and pipeline layout.
        let pc_size = u32_size as u32;
        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: pc_size,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        // Shader and pipeline.
        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;
        let pipeline = create_compute_pipeline(device, *pipeline_layout, *comp_module, 0)?;

        // Generated commands layout: push constant followed by a dispatch, with preprocessing.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderNv::new(
            vk::IndirectCommandsLayoutUsageFlagsNV::EXPLICIT_PREPROCESS,
            bind_point,
        );
        cmds_layout_builder.add_push_constant_token(0, 0, *pipeline_layout, stage_flags, 0, pc_size);
        cmds_layout_builder.add_dispatch_token(0, pc_size);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generate value for push constant "i". We'll reuse this in the verification part.
        let get_push_constant = |i: u32| i + 100;

        // Generated indirect commands buffer contents. Note we'll split this in two executions.
        let mut gen_cmd_data_vecs: Vec<Vec<u32>> = Vec::with_capacity(execute_count);
        for i in 0..execute_count as u32 {
            // Push constant and the indirect dispatch arguments.
            gen_cmd_data_vecs.push(vec![get_push_constant(i), 1, 1, 1]);
        }

        // Buffers for generated indirect commands.
        let gen_cmds_buffer_size = std::mem::size_of_val(gen_cmd_data_vecs[0].as_slice()) as vk::DeviceSize;
        let mut gen_cmd_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        for cmd_data in &gen_cmd_data_vecs {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(gen_cmds_buffer_size, vk::BufferUsageFlags::INDIRECT_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            {
                let alloc = buffer.get_allocation();
                // SAFETY: the buffer was created with the size of the data.
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        cmd_data.as_ptr().cast::<u8>(),
                        alloc.get_host_ptr(),
                        gen_cmds_buffer_size as usize,
                    )
                };
                flush_alloc(device, alloc)?;
            }
            gen_cmd_buffers.push(buffer);
        }

        // Preprocess buffers for 1 sequence. We'll make them separate in this case.
        let mut preprocess_buffers: Vec<PreprocessBufferNv<'_>> = Vec::new();
        for _ in 0..execute_count {
            // We need to pass the fake count here in some cases due to VUID-VkGeneratedCommandsInfoNV-sequencesCount-02917.
            let preprocess_sequences_count = if use_count_buffer { fake_count } else { real_count };
            preprocess_buffers.push(PreprocessBufferNv::new(
                context,
                bind_point,
                *pipeline,
                cmds_layout.get(),
                preprocess_sequences_count,
            )?);
        }

        let mut cmd_infos: Vec<GeneratedCommandsInfoNv> = Vec::with_capacity(execute_count);
        for i in 0..execute_count {
            let count_buffer = if use_count_buffer {
                sequences_count_buffers[i].get()
            } else {
                vk::Buffer::null()
            };
            let info_sequences_count = if use_count_buffer { fake_count } else { real_count };
            let stream_info = make_indirect_commands_stream_nv(gen_cmd_buffers[i].get(), 0);
            cmd_infos.push(GeneratedCommandsInfoNv::new(
                bind_point,
                *pipeline,
                cmds_layout.get(),
                &[stream_info],
                info_sequences_count,
                preprocess_buffers[i].get(),
                preprocess_buffers[i].get_size(),
                count_buffer,
                0,
            ));
        }

        let universal_qf_index = context.get_universal_queue_family_index();
        let mut command_pools = Vec::new();
        let mut universal_info: Option<QueueInfo> = None;
        let mut compute_info: Option<QueueInfo> = None;

        if uses_universal_queue(params.method) {
            let pool = make_command_pool(device, universal_qf_index)?;
            universal_info = Some(QueueInfo {
                qf_index: universal_qf_index,
                queue: context.get_universal_queue(),
                cmd_pool: *pool,
            });
            command_pools.push(pool);
        }
        if uses_compute_queue(params.method) {
            let (queue, qf_index) = context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("No compute queue available".to_string()))?;
            let pool = make_command_pool(device, qf_index)?;
            compute_info = Some(QueueInfo {
                qf_index,
                queue,
                cmd_pool: *pool,
            });
            command_pools.push(pool);
        }

        let (preprocess_queue_info, execute_queue_info) = match params.method {
            Method::UniversalQueue => (universal_info.as_ref(), universal_info.as_ref()),
            Method::ComputeQueue => (compute_info.as_ref(), compute_info.as_ref()),
            Method::PreprocessComputeExecuteUniversal => (compute_info.as_ref(), universal_info.as_ref()),
            Method::PreprocessUniversalExecuteCompute => (universal_info.as_ref(), compute_info.as_ref()),
        };
        let preprocess_queue_info =
            preprocess_queue_info.ok_or_else(|| TestError::InternalError("missing preprocess queue".to_string()))?;
        let execute_queue_info =
            execute_queue_info.ok_or_else(|| TestError::InternalError("missing execute queue".to_string()))?;

        let queue_switch = execute_queue_info.qf_index != preprocess_queue_info.qf_index;

        // These may be used to transfer buffers from the preprocess queue to the execution queue.
        let mut ownership_barriers: Vec<vk::BufferMemoryBarrier> = Vec::new();

        let record_ownership_barriers = |cmd: vk::CommandBuffer, barriers: &[vk::BufferMemoryBarrier]| unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMMAND_PREPROCESS_EXT,
                vk::PipelineStageFlags::DRAW_INDIRECT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                barriers,
                &[] as &[vk::ImageMemoryBarrier],
            );
        };

        // We will preprocess one sequence first, and wait for the preprocessing to finish using a fence.
        {
            let cmd_buffer_owner =
                allocate_command_buffer(device, preprocess_queue_info.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer_owner.get();

            begin_command_buffer(device, cmd_buffer)?;
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_sets[0].get()],
                    &[],
                );
                device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
                device.cmd_preprocess_generated_commands_nv(cmd_buffer, cmd_infos[0].get());
            }

            if queue_switch {
                // When using queue switches, the preprocessing queue will not be the same as the execution queue and buffers need to be
                // transferred between queues. This is the "release" barrier for those buffers. Make sure we cover every buffer in use.
                let (src, dst) = (preprocess_queue_info.qf_index, execute_queue_info.qf_index);
                ownership_barriers.push(make_preprocess_to_execute_barrier(
                    output_buffers[0].get(),
                    u32_size,
                    src,
                    dst,
                ));
                ownership_barriers.push(make_preprocess_to_execute_barrier(
                    gen_cmd_buffers[0].get(),
                    gen_cmds_buffer_size,
                    src,
                    dst,
                ));
                ownership_barriers.push(make_preprocess_to_execute_barrier(
                    preprocess_buffers[0].get(),
                    preprocess_buffers[0].get_size(),
                    src,
                    dst,
                ));
                if use_count_buffer {
                    ownership_barriers.push(make_preprocess_to_execute_barrier(
                        sequences_count_buffers[0].get(),
                        u32_size,
                        src,
                        dst,
                    ));
                }
                record_ownership_barriers(cmd_buffer, &ownership_barriers);
            }

            end_command_buffer(device, cmd_buffer)?;
            submit_commands_and_wait(device, preprocess_queue_info.queue, cmd_buffer)?;
        }

        // Separately, execute the preprocessed commands and preprocess+execute the second sequence.
        {
            let execute_cmd_buffer_owner =
                allocate_command_buffer(device, execute_queue_info.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let mut cmd_buffer = execute_cmd_buffer_owner.get();
            let mut execute_cmd_buffer = vk::CommandBuffer::null(); // Saved for later sometimes.
            // Separate command buffer needed sometimes.
            let mut preprocess_cmd_buffer_owner = None;

            begin_command_buffer(device, cmd_buffer)?;

            if queue_switch {
                // This is the "acquire" barrier to transfer buffer ownership for execution. See above.
                record_ownership_barriers(cmd_buffer, &ownership_barriers);
            }

            // Execution of preprocessed commands.
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_sets[0].get()],
                    &[],
                );
                device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
                device.cmd_execute_generated_commands_nv(cmd_buffer, true, cmd_infos[0].get());
            }

            if queue_switch {
                // Barrier to the host and finish.
                shader_write_to_host_barrier(device, cmd_buffer);
                end_command_buffer(device, cmd_buffer)?;
                execute_cmd_buffer = cmd_buffer; // Save this for later.

                // Separate command buffer for the second sequence. Note we call this the "preprocess" command buffer, but we'll do both
                // preprocessing and execution.
                let owner =
                    allocate_command_buffer(device, preprocess_queue_info.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                cmd_buffer = owner.get();
                preprocess_cmd_buffer_owner = Some(owner);

                begin_command_buffer(device, cmd_buffer)?;
            }

            // Preprocessing and execution of the second sequence.
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_sets[1].get()],
                    &[],
                );
                if queue_switch {
                    // Rebind pipeline. If there's no queue switch, the previous pipeline bind command above still applies because there's
                    // no command buffer change.
                    device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
                }
                device.cmd_preprocess_generated_commands_nv(cmd_buffer, cmd_infos[1].get());
            }
            preprocess_to_execute_barrier(device, cmd_buffer);
            unsafe { device.cmd_execute_generated_commands_nv(cmd_buffer, true, cmd_infos[1].get()) };
            shader_write_to_host_barrier(device, cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;

            // Submit all pending command buffers "simultaneously".
            let extra_submit = execute_cmd_buffer != vk::CommandBuffer::null();
            let execution_fence = if extra_submit {
                Some(submit_commands(device, execute_queue_info.queue, execute_cmd_buffer)?)
            } else {
                None
            };
            let preprocessing_fence = submit_commands(device, preprocess_queue_info.queue, cmd_buffer)?;

            // Wait on all fences.
            wait_for_fence(&preprocessing_fence)?;
            if let Some(fence) = &execution_fence {
                wait_for_fence(fence)?;
            }
            drop(preprocess_cmd_buffer_owner);
        }

        // Verify results.
        let execution = params.count_buffer != CountBuffer::YesButZero;
        let mut fail = false;
        for (i, buffer) in output_buffers.iter().enumerate() {
            let alloc = buffer.get_allocation();
            invalidate_alloc(device, alloc)?;
            // SAFETY: the buffer holds one word and the device finished writing.
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

/// `createDGCComputePreprocessTests`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_preprocess_tests_nv() -> Vec<(String, Box<dyn TestCase>)> {
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

    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (method, method_name) in method_cases {
        for (count_buffer, suffix) in count_buffer_cases {
            let name = format!("parallel_preprocessing_{method_name}{suffix}");
            cases.push((
                format!("nv.compute.preprocess.{name}"),
                Box::new(PreprocessCase {
                    name,
                    params: PreprocessParams { method, count_buffer },
                }) as Box<dyn TestCase>,
            ));
        }
    }
    cases
}

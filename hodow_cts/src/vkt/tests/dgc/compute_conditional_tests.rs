// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeConditionalTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The program is the one of the preprocess tests (`storePushConstantProgram` is the same GLSL
// in both files), pre-expanded in `shaders/manifest/dgc_compute_preprocess.toml`. The pipeline layout is the one of the pipeline wrapper.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtConditionalRenderingExtensionDeviceCommands, ExtDeviceGeneratedCommandsExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_compute_preprocess::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::dgc::compute_preprocess_tests::{
    make_preprocess_to_execute_barrier, shader_write_to_host_barrier,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcComputeSupportType, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt,
    PreprocessBufferExt, check_dgc_ext_compute_support, preprocess_to_execute_barrier_ext,
};
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy)]
struct TestParams {
    /// Use a DGC indirect pipeline.
    pipeline_token: bool,
    /// Use an indirect count buffer.
    indirect_count_buffer: bool,
    /// Value for the condition buffer.
    condition_value: bool,
    /// Inverted condition?
    inverted: bool,
    /// Use the compute queue instead of the universal one.
    compute_queue: bool,
}

#[derive(Clone, Copy)]
struct ConditionalPreprocessParams {
    condition_value: bool,
    inverted: bool,
    execute_on_compute: bool,
    /// Use a separate command buffer for the preprocessing state.
    separate_state: bool,
}

#[derive(Clone, Copy)]
enum Variant {
    Dispatch(TestParams),
    Preprocess(ConditionalPreprocessParams),
}

struct ConditionalCase {
    name: String,
    variant: Variant,
}

fn check_conditional_rendering_ext(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_conditional_rendering")
}

fn require_compute_queue(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_compute_queue().is_none() {
        return Err(TestError::NotSupported("No compute queue available".to_string()));
    }
    Ok(())
}

impl TestCase for ConditionalCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkConditionalDGCComputeSupport` / `checkConditionalPreprocessSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.variant {
            Variant::Dispatch(params) => {
                let support_type = if params.pipeline_token {
                    DgcComputeSupportType::BindPipeline
                } else {
                    DgcComputeSupportType::Basic
                };
                check_dgc_ext_compute_support(context, support_type)?;
                check_conditional_rendering_ext(context)?;
                if params.compute_queue {
                    require_compute_queue(context)?;
                }
            }
            Variant::Preprocess(params) => {
                check_dgc_ext_compute_support(context, DgcComputeSupportType::Basic)?;
                check_conditional_rendering_ext(context)?;
                if params.execute_on_compute {
                    require_compute_queue(context)?;
                }
            }
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
        Box::new(ConditionalInstance {
            context,
            variant: self.variant,
        })
    }
}

struct ConditionalInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
}

fn begin_conditional_rendering(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    condition_buffer: vk::Buffer,
    inverted: bool,
) {
    let flags = if inverted {
        vk::ConditionalRenderingFlagsEXT::INVERTED
    } else {
        vk::ConditionalRenderingFlagsEXT::empty()
    };
    let begin_info = vk::ConditionalRenderingBeginInfoEXT {
        buffer: condition_buffer,
        offset: 0,
        flags,
        ..Default::default()
    };
    unsafe { device.cmd_begin_conditional_rendering_ext(cmd_buffer, &begin_info) };
}

/// The output and condition buffers, descriptor set and pipeline shared by both variants.
struct Common<'a> {
    output_buffer: BufferWithMemory<'a>,
    condition_buffer: BufferWithMemory<'a>,
    set: UniqueDescriptorSet<'a>,
    _pool: Unique<'a, vk::DescriptorPool>,
    _set_layout: Unique<'a, vk::DescriptorSetLayout>,
}

const PC_VALUE: u32 = 777;

impl TestInstance for ConditionalInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::Dispatch(params) => self.conditional_dispatch_run(params),
            Variant::Preprocess(params) => self.conditional_preprocess_run(params),
        }
    }
}

impl<'a> ConditionalInstance<'a> {
    fn make_common(&self, condition_value: u32) -> Result<(Common<'a>, vk::PushConstantRange), TestError> {
        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let u32_size = std::mem::size_of::<u32>() as vk::DeviceSize;

        // Output buffer.
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(u32_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = output_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, u32_size as usize) };
            flush_alloc(device, alloc)?;
        }

        // Descriptor set layout, pool and set preparation.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stage_flags)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;

        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, u32_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(set.get(), Location::binding(0), desc_type, &output_buffer_desc_info)
            .update(device);

        // Conditional rendering buffer.
        let condition_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(u32_size, vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = condition_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping((&condition_value as *const u32).cast::<u8>(), alloc.get_host_ptr(), 4)
            };
            flush_alloc(device, alloc)?;
        }

        // Push constants
        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: u32_size as u32,
        };
        Ok((
            Common {
                output_buffer,
                condition_buffer,
                set,
                _pool: pool,
                _set_layout: set_layout,
            },
            pc_range,
        ))
    }

    fn make_pipeline(
        &self,
        set_layout: vk::DescriptorSetLayout,
        pc_range: vk::PushConstantRange,
        indirect_bindable: bool,
    ) -> Result<ComputePipelineWrapper<'a>, TestError> {
        let mut pipeline = ComputePipelineWrapper::new(
            self.context.get_device(),
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(set_layout);
        pipeline.add_push_constant_range(pc_range);
        if indirect_bindable {
            pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
        }
        pipeline.build_pipeline()?;
        Ok(pipeline)
    }

    /// `conditionalDispatchRun`
    fn conditional_dispatch_run(&self, params: TestParams) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
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
        let u32_size = std::mem::size_of::<u32>() as vk::DeviceSize;

        // Avoid using value 1, just to make it interesting.
        let condition_buffer_value = if params.condition_value { 2u32 } else { 0 };
        let (common, pc_range) = self.make_common(condition_buffer_value)?;

        // The set layout handle is needed by the pipeline wrapper.
        let set_layout = *common._set_layout;
        let compute_pipeline = self.make_pipeline(set_layout, pc_range, params.pipeline_token)?;
        let pipeline_layout = compute_pipeline.get_pipeline_layout();
        // Pipeline, multiple options: the normal pipeline stays null when a DGC pipeline is used.
        let normal_pipeline = if params.pipeline_token {
            vk::Pipeline::null()
        } else {
            compute_pipeline.get_pipeline()
        };

        // Indirect commands layout. Push constant followed by dispatch, optionally preceded by a pipeline bind.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            pipeline_layout,
        );
        if params.pipeline_token {
            cmds_layout_builder.add_compute_pipeline_token(0);
        }
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_push_constant_token(stream_range, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generated indirect commands buffer contents: pipeline index, push constant and dispatch.
        let mut gen_cmds_data: Vec<u32> = Vec::with_capacity(5);
        if params.pipeline_token {
            gen_cmds_data.push(0);
        }
        gen_cmds_data.push(PC_VALUE);
        gen_cmds_data.extend([1, 1, 1]);

        // Generated indirect commands buffer.
        let gen_cmds_buffer_size = std::mem::size_of_val(gen_cmds_data.as_slice()) as vk::DeviceSize;
        let gen_cmds_buffer = DgcBuffer::new(
            context,
            gen_cmds_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = gen_cmds_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    gen_cmds_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    gen_cmds_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Indirect execution set.
        let execution_set_manager = if params.pipeline_token {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, compute_pipeline.get_pipeline(), 1)?;
            // Lets rely on the initial value.
            manager.update();
            Some(manager)
        } else {
            None
        };
        let execution_set_handle = execution_set_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        // Preprocess buffer for 256 sequences (actually only using one, but we'll pretend we may use more). Note the minimum property
        // requirements are large enough so that 256 sequences should fit.
        let potential_sequence_count = 256u32;
        let actual_sequence_count = 1u32;
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            execution_set_handle,
            cmds_layout.get(),
            potential_sequence_count,
            0,
            normal_pipeline,
            0,
        )?;

        // (Optional) Sequence count buffer.
        let sequence_count_buffer = if params.indirect_count_buffer {
            let buffer = DgcBuffer::new(
                context,
                u32_size,
                vk::BufferUsageFlags::empty(),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let alloc = buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    (&actual_sequence_count as *const u32).cast::<u8>(),
                    alloc.get_host_ptr(),
                    4,
                )
            };
            flush_alloc(device, alloc)?;
            Some(buffer)
        } else {
            None
        };

        // Generated commands info.
        let sequence_count_buffer_address = sequence_count_buffer.as_ref().map_or(0, DgcBuffer::get_device_address);
        let info_sequences_count = if params.indirect_count_buffer {
            potential_sequence_count
        } else {
            actual_sequence_count
        };

        let cmds_info = DgcGenCmdsInfo::new(
            stage_flags,
            execution_set_handle,
            cmds_layout.get(),
            gen_cmds_buffer.get_device_address(),
            gen_cmds_buffer_size,
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            info_sequences_count,
            sequence_count_buffer_address,
            0,
            normal_pipeline,
        );

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        {
            // Everything is recorded on the primary command buffer.
            begin_command_buffer(device, cmd_buffer)?;
            begin_conditional_rendering(device, cmd_buffer, common.condition_buffer.get(), params.inverted);
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[common.set.get()],
                    &[] as &[u32],
                );
            }
            // Binds the pipeline, normal or DGC: they are never both present.
            compute_pipeline.bind(cmd_buffer);
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
            unsafe { device.cmd_end_conditional_rendering_ext(cmd_buffer) };
            shader_write_to_host_barrier(device, cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        }

        // Verify results.
        submit_commands_and_wait(device, queue, cmd_buffer)?;
        let output_alloc = common.output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let output_value = unsafe { std::ptr::read_unaligned(output_alloc.get_host_ptr().cast::<u32>()) };

        // Note the expected value is a logical xor of the condition value and the inverted flag.
        let expected_value = if params.condition_value != params.inverted {
            PC_VALUE
        } else {
            0
        };

        drop(execution_set_manager);

        if output_value != expected_value {
            return Ok(TestStatus::fail(format!(
                "Unexpected value found in output buffer; expected {expected_value} but found {output_value}"
            )));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `conditionalPreprocessRun`: these tests try to check conditional rendering does not affect preprocessing.
    fn conditional_preprocess_run(&self, params: ConditionalPreprocessParams) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let seq_count = 1u32;
        let u32_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let universal_qf_index = context.get_universal_queue_family_index();

        // Avoid using value 1.
        let condition_value = if params.condition_value { 256u32 } else { 0 };
        let (common, pc_range) = self.make_common(condition_value)?;

        let set_layout = *common._set_layout;
        let compute_pipeline = self.make_pipeline(set_layout, pc_range, false)?;
        let pipeline_layout = compute_pipeline.get_pipeline_layout();
        let normal_pipeline = compute_pipeline.get_pipeline();

        // Indirect commands layout. Push constant followed by dispatch.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS,
            stage_flags,
            pipeline_layout,
        );
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_push_constant_token(stream_range, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generated indirect commands buffer contents: push constant and dispatch.
        let gen_cmds_data: Vec<u32> = vec![PC_VALUE, 1, 1, 1];

        // Generated indirect commands buffer.
        let gen_cmds_buffer_size = std::mem::size_of_val(gen_cmds_data.as_slice()) as vk::DeviceSize;
        let gen_cmds_buffer = DgcBuffer::new(
            context,
            gen_cmds_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = gen_cmds_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    gen_cmds_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    gen_cmds_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            seq_count,
            0,
            normal_pipeline,
            0,
        )?;

        // Generated commands info.
        let cmds_info = DgcGenCmdsInfo::new(
            stage_flags,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            gen_cmds_buffer.get_device_address(),
            gen_cmds_buffer_size,
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            seq_count,
            0,
            0,
            normal_pipeline,
        );

        // Command pool and buffer.
        let universal_pool = make_command_pool(device, universal_qf_index)?;
        let preprocess_cmd = allocate_command_buffer(device, *universal_pool, vk::CommandBufferLevel::PRIMARY)?;

        // The execute command buffer is allocated lazily from a pool of the queue family that executes.
        let mut comp_queue_index = u32::MAX;
        let mut compute_queue = None;
        if params.execute_on_compute {
            let (queue, qf_index) = context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("No compute queue available".to_string()))?;
            comp_queue_index = qf_index;
            compute_queue = Some(queue);
        }
        let exec_queue_family = if params.execute_on_compute {
            comp_queue_index
        } else {
            universal_qf_index
        };
        let exec_queue = compute_queue.unwrap_or_else(|| context.get_universal_queue());

        // These will be used to transfer buffers from the preprocess queue to the execution queue if needed.
        let mut ownership_barriers: Vec<vk::BufferMemoryBarrier> = Vec::new();

        if params.execute_on_compute {
            // Prepare ownership barriers.
            ownership_barriers.push(make_preprocess_to_execute_barrier(
                common.output_buffer.get(),
                u32_size,
                universal_qf_index,
                comp_queue_index,
            ));
            ownership_barriers.push(make_preprocess_to_execute_barrier(
                gen_cmds_buffer.get(),
                gen_cmds_buffer_size,
                universal_qf_index,
                comp_queue_index,
            ));

            if preprocess_buffer.get() != vk::Buffer::null() {
                ownership_barriers.push(make_preprocess_to_execute_barrier(
                    preprocess_buffer.get(),
                    preprocess_buffer.get_size(),
                    universal_qf_index,
                    comp_queue_index,
                ));
            }
        }

        // This records the initial state (pipeline, descriptors, conditional rendering) in a command buffer.
        let record_initial_state = |cmd_buffer: vk::CommandBuffer| {
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[common.set.get()],
                    &[] as &[u32],
                );
            }
            compute_pipeline.bind(cmd_buffer);
            begin_conditional_rendering(device, cmd_buffer, common.condition_buffer.get(), params.inverted);
        };

        // Records the acquire barrier in a command buffer if needed.
        let maybe_record_acquire_barrier = |cmd_buffer: vk::CommandBuffer| {
            if params.execute_on_compute {
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
        };

        // How separate_state is handled:
        //
        // If we don't have separate state, we will record the preprocess buffer first directly. We will record state in it and use the
        // preprocess command buffer as the initial state when recording the preprocessing command to itself.
        //
        // If we have separate state, we will record the initial part of the execution command buffer first (until just before the
        // execution), then we will use the execution command buffer as state for preprocessing, without recording any state in the
        // preprocessing command buffer itself. Later, we will finish recording the execution command buffer.
        let exec_pool = make_command_pool(device, exec_queue_family)?;
        let exec_cmd = allocate_command_buffer(device, *exec_pool, vk::CommandBufferLevel::PRIMARY)?;

        if params.separate_state {
            // Record the inital state first in the execution command buffer.
            begin_command_buffer(device, exec_cmd.get())?;
            maybe_record_acquire_barrier(exec_cmd.get());
            record_initial_state(exec_cmd.get());
        }

        // Switch to the preprocess command buffer and record its contents.
        let cmd_buffer = preprocess_cmd.get();
        begin_command_buffer(device, cmd_buffer)?;

        if !params.separate_state {
            // Record the initial state on the preprocess command buffer itself. If we don't use a separate command buffer for state, we
            // cannot be recording the conditional rendering commands on the preprocess command buffer only.
            record_initial_state(cmd_buffer);
        }
        let state_cmd_buffer = if params.separate_state {
            exec_cmd.get()
        } else {
            cmd_buffer
        };
        unsafe { device.cmd_preprocess_generated_commands_ext(cmd_buffer, cmds_info.get(), state_cmd_buffer) };
        if !params.separate_state {
            unsafe { device.cmd_end_conditional_rendering_ext(cmd_buffer) };
        }
        preprocess_to_execute_barrier_ext(device, cmd_buffer);

        if params.execute_on_compute {
            // Record release barrier in the preprocess command buffer.
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
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;

        // Switch to the execution command buffer.
        let cmd_buffer = exec_cmd.get();

        // If the state has not been recorded yet, do it now.
        if !params.separate_state {
            begin_command_buffer(device, cmd_buffer)?;
            maybe_record_acquire_barrier(cmd_buffer);
            record_initial_state(cmd_buffer);
        }

        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, true, cmds_info.get()) };
        unsafe { device.cmd_end_conditional_rendering_ext(cmd_buffer) };
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, exec_queue, cmd_buffer)?;

        // Verify results.
        let output_alloc = common.output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let output_value = unsafe { std::ptr::read_unaligned(output_alloc.get_host_ptr().cast::<u32>()) };

        let expected_value = if params.inverted != params.condition_value {
            PC_VALUE
        } else {
            0
        };
        if output_value != expected_value {
            return Ok(TestStatus::fail(format!(
                "Unexpected value found in output buffer; expected {expected_value} but found {output_value}"
            )));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCComputeConditionalTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_conditional_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases = Vec::new();

    for pipeline_token in [false, true] {
        for indirect_count_buffer in [false, true] {
            for condition_value in [false, true] {
                for inverted in [false, true] {
                    for compute_queue in [false, true] {
                        let params = TestParams {
                            pipeline_token,
                            indirect_count_buffer,
                            condition_value,
                            inverted,
                            compute_queue,
                        };

                        let test_name = format!(
                            "{}{}{}{}{}",
                            if pipeline_token {
                                "pipeline_token"
                            } else {
                                "classic_bind"
                            },
                            if indirect_count_buffer {
                                "_with_count_buffer"
                            } else {
                                "_without_count_buffer"
                            },
                            if condition_value {
                                "_condition_true"
                            } else {
                                "_condition_false"
                            },
                            if inverted { "_inverted_flag" } else { "" },
                            if compute_queue { "_cq" } else { "_uq" },
                        );
                        cases.push((
                            format!("ext.compute.conditional_rendering.general.{test_name}"),
                            Box::new(ConditionalCase {
                                name: test_name,
                                variant: Variant::Dispatch(params),
                            }) as Box<dyn TestCase>,
                        ));
                    }
                }
            }
        }
    }

    // Preprocessing tests.
    for condition_value in [false, true] {
        for inverted in [false, true] {
            for exec_on_compute in [false, true] {
                for separate_state in [false, true] {
                    // The spec requires that vkCmdExecuteGeneratedCommandsEXT is recorded on the same queue as the stateCommandBuffer used
                    // for vkCmdPreprocessGeneratedCommandsEXT if isPreprocessed is VK_TRUE. If exec_on_compute is true but
                    // separate_state is false, the preprocessing would be done with state from the universal queue, and the execution
                    // would happen on the compute queue.
                    if exec_on_compute && !separate_state {
                        continue;
                    }

                    let params = ConditionalPreprocessParams {
                        condition_value,
                        inverted,
                        execute_on_compute: exec_on_compute,
                        separate_state,
                    };
                    let test_name = format!(
                        "{}{}{}{}",
                        if condition_value {
                            "condition_true"
                        } else {
                            "condition_false"
                        },
                        if inverted { "_inverted_flag" } else { "" },
                        if separate_state { "_separate_state" } else { "" },
                        if exec_on_compute { "_exec_on_compute" } else { "" },
                    );
                    cases.push((
                        format!("ext.compute.conditional_rendering.preprocess.{test_name}"),
                        Box::new(ConditionalCase {
                            name: test_name,
                            variant: Variant::Preprocess(params),
                        }) as Box<dyn TestCase>,
                    ));
                }
            }
        }
    }
    cases
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeConditionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The program is the push constant store of the EXT preprocess tests
// (`shaders/manifest/dgc_compute_preprocess.toml`, `preprocess_store_pc`), whose source is the one of the NV tests.
//
// `dgc.nv.compute.conditional_rendering` (VK_NV_device_generated_commands_compute): generated dispatches inside conditional rendering, recorded
// on the primary command buffer or a secondary one (with or without conditional rendering inheritance), and the preprocessing step recorded
// with conditional rendering enabled.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtConditionalRenderingExtensionDeviceCommands, InstanceV1_1,
    NvDeviceGeneratedCommandsComputeExtensionDeviceCommands, NvDeviceGeneratedCommandsExtensionDeviceCommands,
};

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
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::compute_preprocess_tests::{
    make_preprocess_to_execute_barrier, shader_write_to_host_barrier,
};
use crate::vkt::tests::dgc::util_nv::{
    DgcComputePipeline, DgcComputePipelineMetaDataPool, GeneratedCommandsInfoNv, IndirectCommandsLayoutBuilderNv,
    PreprocessBufferNv, check_dgc_compute_support, make_indirect_commands_stream_nv,
    metadata_update_to_preprocess_barrier, preprocess_to_execute_barrier,
};
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum UseSecondaries {
    No,
    YesWithoutInheritance,
    YesWithInheritance,
}

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
    /// Use secondaries? How?
    use_secondaries: UseSecondaries,
    /// Use the compute queue instead of the universal one.
    compute_queue: bool,
}

#[derive(Clone, Copy)]
struct ConditionalPreprocessParams {
    condition_value: bool,
    inverted: bool,
    execute_on_compute: bool,
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
                check_dgc_compute_support(context, params.pipeline_token, false)?;
                context.require_device_functionality("VK_EXT_conditional_rendering")?;

                if params.use_secondaries == UseSecondaries::YesWithInheritance {
                    let mut features = vk::PhysicalDeviceConditionalRenderingFeaturesEXT::default();
                    {
                        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
                        unsafe {
                            context
                                .get_instance()
                                .get_physical_device_features2(context.get_physical_device(), &mut features2)
                        };
                    }
                    if features.inherited_conditional_rendering == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "inheritedConditionalRendering not supported".to_string(),
                        ));
                    }
                }
                if params.compute_queue {
                    require_compute_queue(context)?;
                }
            }
            Variant::Preprocess(params) => {
                check_dgc_compute_support(context, false, false)?;
                context.require_device_functionality("VK_EXT_conditional_rendering")?;
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

const PC_VALUE: u32 = 777;

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

/// `beginSecondaryCommandBuffer` with no render pass: one time submit, optionally with the conditional rendering inheritance structure.
fn begin_secondary_command_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    inherit_conditional_rendering: bool,
) -> Result<(), TestError> {
    let icr_info = vk::CommandBufferInheritanceConditionalRenderingInfoEXT {
        conditional_rendering_enable: vk::TRUE,
        ..Default::default()
    };
    let mut inheritance = vk::CommandBufferInheritanceInfo {
        render_pass: vk::RenderPass::null(),
        subpass: 0,
        framebuffer: vk::Framebuffer::null(),
        occlusion_query_enable: vk::FALSE,
        ..Default::default()
    };
    if inherit_conditional_rendering {
        inheritance.next = (&icr_info as *const vk::CommandBufferInheritanceConditionalRenderingInfoEXT).cast();
    }
    let info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
        .inheritance_info(&inheritance);
    unsafe { device.begin_command_buffer(cmd_buffer, &info) }.vk_check("vkBeginCommandBuffer")
}

fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(c"main".to_bytes_with_nul())
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn host_buffer_with_value<'a>(
    context: &'a Context<'a>,
    usage: vk::BufferUsageFlags,
    value: u32,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(4, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let alloc = buffer.get_allocation();
        // SAFETY: the buffer holds 4 bytes.
        unsafe { std::ptr::copy_nonoverlapping(value.to_ne_bytes().as_ptr(), alloc.get_host_ptr(), 4) };
        flush_alloc(device, alloc)?;
    }
    Ok(buffer)
}

fn host_gen_cmds_buffer<'a>(context: &'a Context<'a>, data: &[u32]) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = std::mem::size_of_val(data) as vk::DeviceSize;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, vk::BufferUsageFlags::INDIRECT_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let alloc = buffer.get_allocation();
        // SAFETY: the buffer was created with the size of the data.
        unsafe { std::ptr::copy_nonoverlapping(data.as_ptr().cast::<u8>(), alloc.get_host_ptr(), size as usize) };
        flush_alloc(device, alloc)?;
    }
    Ok(buffer)
}

impl TestInstance for ConditionalInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::Dispatch(params) => self.conditional_dispatch_run(params),
            Variant::Preprocess(params) => self.conditional_preprocess_run(params),
        }
    }
}

impl ConditionalInstance<'_> {
    /// `conditionalDispatchRun`
    fn conditional_dispatch_run(&self, params: TestParams) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
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

        // Output buffer.
        let output_buffer = host_buffer_with_value(context, vk::BufferUsageFlags::STORAGE_BUFFER, 0)?;

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
        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, 4);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                desc_type,
                &output_buffer_desc_info,
            )
            .update(device);

        // Push constants and pipeline layout.
        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: 4,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        // Shader.
        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        // Pipeline, multiple options.
        let metadata_pool =
            DgcComputePipelineMetaDataPool::new(context, DgcComputePipelineMetaDataPool::DEFAULT_MULTIPLIER, false);
        let dgc_pipeline = if params.pipeline_token {
            Some(DgcComputePipeline::new(
                &metadata_pool,
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
            )?)
        } else {
            None
        };
        let normal_pipeline = if params.pipeline_token {
            None
        } else {
            Some(create_compute_pipeline(device, *pipeline_layout, *comp_module)?)
        };
        let normal_pipeline_handle = normal_pipeline
            .as_ref()
            .map_or(vk::Pipeline::null(), |pipeline| **pipeline);

        // Indirect commands layout. Push constant followed by dispatch, optionally preceded by a pipeline bind.
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), bind_point);
        if params.pipeline_token {
            cmds_layout_builder.add_pipeline_token(0, 0);
        }
        let offset = cmds_layout_builder.get_stream_range(0);
        cmds_layout_builder.add_push_constant_token(0, offset, *pipeline_layout, stage_flags, 0, 4);
        let offset = cmds_layout_builder.get_stream_range(0);
        cmds_layout_builder.add_dispatch_token(0, offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generated indirect commands buffer contents.
        let mut gen_cmds_data: Vec<u32> = Vec::with_capacity(6);
        if let Some(pipeline) = &dgc_pipeline {
            let address = pipeline.get_indirect_device_address();
            gen_cmds_data.push(address as u32);
            gen_cmds_data.push((address >> 32) as u32);
        }
        gen_cmds_data.push(PC_VALUE);
        gen_cmds_data.extend([1, 1, 1]); // VkDispatchIndirectCommand

        let gen_cmds_buffer = host_gen_cmds_buffer(context, &gen_cmds_data)?;

        // Conditional rendering buffer. Avoid using value 1, just to make it interesting.
        let condition_buffer = host_buffer_with_value(
            context,
            vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT,
            if params.condition_value { 2 } else { 0 },
        )?;

        // Preprocess buffer for 256 sequences (actually only using one, but we'll pretend we may use more). The pipeline is null for the
        // pipeline token case, which is exactly what we want.
        let potential_sequence_count = 256u32;
        let actual_sequence_count = 1u32;
        let preprocess_buffer = PreprocessBufferNv::new(
            context,
            bind_point,
            normal_pipeline_handle,
            cmds_layout.get(),
            potential_sequence_count,
        )?;

        // (Optional) Sequence count buffer.
        let sequence_count_buffer = if params.indirect_count_buffer {
            Some(host_buffer_with_value(
                context,
                vk::BufferUsageFlags::INDIRECT_BUFFER,
                actual_sequence_count,
            )?)
        } else {
            None
        };

        // Generated commands info.
        let info_sequences_count = if params.indirect_count_buffer {
            potential_sequence_count
        } else {
            actual_sequence_count
        };
        let info_count_buffer = sequence_count_buffer
            .as_ref()
            .map_or(vk::Buffer::null(), BufferWithMemory::get);
        let stream_info = make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0);
        let cmds_info = GeneratedCommandsInfoNv::new(
            bind_point,
            normal_pipeline_handle,
            cmds_layout.get(),
            &[stream_info],
            info_sequences_count,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            info_count_buffer,
            0,
        );

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        let secondary_owner = if params.use_secondaries != UseSecondaries::No {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        // Binds the normal pipeline or updates the indirect buffer for the DGC pipeline and sets the proper barrier.
        let bind_or_prepare_pipeline = |cmd: vk::CommandBuffer| {
            if let Some(pipeline) = &dgc_pipeline {
                unsafe { device.cmd_update_pipeline_indirect_buffer_nv(cmd, bind_point, pipeline.get()) };
                metadata_update_to_preprocess_barrier(device, cmd);
            } else {
                unsafe { device.cmd_bind_pipeline(cmd, bind_point, normal_pipeline_handle) };
            }
        };
        let bind_descriptors = |cmd: vk::CommandBuffer| unsafe {
            device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &[descriptor_set.get()], &[]);
        };

        match params.use_secondaries {
            UseSecondaries::YesWithInheritance => {
                let sec = secondary_owner.as_ref().expect("secondary").get();
                begin_secondary_command_buffer(device, sec, true)?;
                bind_descriptors(sec);
                bind_or_prepare_pipeline(sec);
                unsafe { device.cmd_execute_generated_commands_nv(sec, false, cmds_info.get()) };
                end_command_buffer(device, sec)?;

                // In the primary, set up the conditional rendering part and execute the secondary command buffer.
                begin_command_buffer(device, cmd_buffer)?;
                begin_conditional_rendering(device, cmd_buffer, condition_buffer.get(), params.inverted);
                unsafe {
                    device.cmd_execute_commands(cmd_buffer, &[sec]);
                    device.cmd_end_conditional_rendering_ext(cmd_buffer);
                }
                shader_write_to_host_barrier(device, cmd_buffer);
                end_command_buffer(device, cmd_buffer)?;
            }
            UseSecondaries::YesWithoutInheritance => {
                let sec = secondary_owner.as_ref().expect("secondary").get();
                begin_secondary_command_buffer(device, sec, false)?;
                bind_descriptors(sec);
                bind_or_prepare_pipeline(sec);
                begin_conditional_rendering(device, sec, condition_buffer.get(), params.inverted);
                unsafe {
                    device.cmd_execute_generated_commands_nv(sec, false, cmds_info.get());
                    device.cmd_end_conditional_rendering_ext(sec);
                }
                end_command_buffer(device, sec)?;

                // In the primary, just execute the secondary command buffer.
                begin_command_buffer(device, cmd_buffer)?;
                unsafe { device.cmd_execute_commands(cmd_buffer, &[sec]) };
                shader_write_to_host_barrier(device, cmd_buffer);
                end_command_buffer(device, cmd_buffer)?;
            }
            UseSecondaries::No => {
                // Everything is recorded on the primary command buffer.
                begin_command_buffer(device, cmd_buffer)?;
                begin_conditional_rendering(device, cmd_buffer, condition_buffer.get(), params.inverted);
                bind_descriptors(cmd_buffer);
                bind_or_prepare_pipeline(cmd_buffer);
                unsafe {
                    device.cmd_execute_generated_commands_nv(cmd_buffer, false, cmds_info.get());
                    device.cmd_end_conditional_rendering_ext(cmd_buffer);
                }
                shader_write_to_host_barrier(device, cmd_buffer);
                end_command_buffer(device, cmd_buffer)?;
            }
        }

        // Verify results.
        submit_commands_and_wait(device, queue, cmd_buffer)?;
        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        // SAFETY: the buffer holds one word and the device finished writing.
        let output_value = unsafe { std::ptr::read_unaligned(output_alloc.get_host_ptr().cast::<u32>()) };

        // Note the expected value is a logical xor of the condition value and the inverted flag.
        let expected_value = if params.condition_value != params.inverted {
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

    /// `conditionalPreprocessRun`: these tests try to check conditional rendering does not affect preprocessing.
    fn conditional_preprocess_run(&self, params: ConditionalPreprocessParams) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let seq_count = 1u32;
        let universal_qf_index = context.get_universal_queue_family_index();

        // Output buffer.
        let output_buffer = host_buffer_with_value(context, vk::BufferUsageFlags::STORAGE_BUFFER, 0)?;

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
        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, 4);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                desc_type,
                &output_buffer_desc_info,
            )
            .update(device);

        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: 4,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;
        let normal_pipeline = create_compute_pipeline(device, *pipeline_layout, *comp_module)?;

        // Indirect commands layout. Push constant followed by dispatch.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderNv::new(
            vk::IndirectCommandsLayoutUsageFlagsNV::EXPLICIT_PREPROCESS,
            bind_point,
        );
        let offset = cmds_layout_builder.get_stream_range(0);
        cmds_layout_builder.add_push_constant_token(0, offset, *pipeline_layout, stage_flags, 0, 4);
        let offset = cmds_layout_builder.get_stream_range(0);
        cmds_layout_builder.add_dispatch_token(0, offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let gen_cmds_data: Vec<u32> = vec![PC_VALUE, 1, 1, 1];
        let gen_cmds_buffer_size = std::mem::size_of_val(gen_cmds_data.as_slice()) as vk::DeviceSize;
        let gen_cmds_buffer = host_gen_cmds_buffer(context, &gen_cmds_data)?;

        // Conditional rendering buffer. Avoid using value 1, just to make it interesting.
        let condition_buffer = host_buffer_with_value(
            context,
            vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT,
            if params.condition_value { 2 } else { 0 },
        )?;

        let preprocess_buffer =
            PreprocessBufferNv::new(context, bind_point, *normal_pipeline, cmds_layout.get(), seq_count)?;

        let stream_info = make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0);
        let cmds_info = GeneratedCommandsInfoNv::new(
            bind_point,
            *normal_pipeline,
            cmds_layout.get(),
            &[stream_info],
            seq_count,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            vk::Buffer::null(),
            0,
        );

        // Command pool and buffer.
        let universal_pool = make_command_pool(device, universal_qf_index)?;
        let universal_cmd = allocate_command_buffer(device, *universal_pool, vk::CommandBufferLevel::PRIMARY)?;
        let mut queue = context.get_universal_queue();
        let mut cmd_buffer = universal_cmd.get();
        begin_command_buffer(device, cmd_buffer)?;

        // Record the preprocessing step with conditional rendering enabled.
        begin_conditional_rendering(device, cmd_buffer, condition_buffer.get(), params.inverted);
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            device.cmd_bind_pipeline(cmd_buffer, bind_point, *normal_pipeline);
            device.cmd_preprocess_generated_commands_nv(cmd_buffer, cmds_info.get());
            device.cmd_end_conditional_rendering_ext(cmd_buffer);
        }
        preprocess_to_execute_barrier(device, cmd_buffer);

        // Kept alive until the end of the test when execution happens on the compute queue.
        let compute_pool;
        let compute_cmd;
        if params.execute_on_compute {
            let (compute_queue, comp_queue_index) = context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("No compute queue available".to_string()))?;

            // These will be used to transfer buffers from the preprocess queue to the execution queue.
            let ownership_barriers = [
                make_preprocess_to_execute_barrier(output_buffer.get(), 4, universal_qf_index, comp_queue_index),
                make_preprocess_to_execute_barrier(
                    gen_cmds_buffer.get(),
                    gen_cmds_buffer_size,
                    universal_qf_index,
                    comp_queue_index,
                ),
                make_preprocess_to_execute_barrier(
                    preprocess_buffer.get(),
                    preprocess_buffer.get_size(),
                    universal_qf_index,
                    comp_queue_index,
                ),
            ];

            let record_ownership_barrier = |cmd: vk::CommandBuffer| unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMMAND_PREPROCESS_EXT,
                    vk::PipelineStageFlags::DRAW_INDIRECT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &ownership_barriers,
                    &[] as &[vk::ImageMemoryBarrier],
                );
            };
            record_ownership_barrier(cmd_buffer);

            end_command_buffer(device, cmd_buffer)?;
            submit_commands_and_wait(device, queue, cmd_buffer)?;

            // Switch to the compute command buffer and queue.
            compute_pool = make_command_pool(device, comp_queue_index)?;
            compute_cmd = allocate_command_buffer(device, *compute_pool, vk::CommandBufferLevel::PRIMARY)?;
            cmd_buffer = compute_cmd.get();
            queue = compute_queue;

            begin_command_buffer(device, cmd_buffer)?;

            // This is the "acquire" barrier to transfer buffer ownership for execution. See above.
            record_ownership_barrier(cmd_buffer);

            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[],
                );
                device.cmd_bind_pipeline(cmd_buffer, bind_point, *normal_pipeline);
            }
        }

        // Conditional rendering state must match between preprocess and execute.
        begin_conditional_rendering(device, cmd_buffer, condition_buffer.get(), params.inverted);
        unsafe {
            device.cmd_execute_generated_commands_nv(cmd_buffer, true, cmds_info.get());
            device.cmd_end_conditional_rendering_ext(cmd_buffer);
        }

        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify results.
        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        // SAFETY: the buffer holds one word and the device finished writing.
        let output_value = unsafe { std::ptr::read_unaligned(output_alloc.get_host_ptr().cast::<u32>()) };

        // Note the expected value is a logical xor of the condition value and the inverted flag.
        let expected_value = if params.condition_value != params.inverted {
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

/// `createDGCComputeConditionalTests`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_conditional_tests_nv() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();

    let secondary_usage_cases = [
        (UseSecondaries::No, "_primary"),
        (UseSecondaries::YesWithoutInheritance, "_secondary"),
        (UseSecondaries::YesWithInheritance, "_secondary_with_inheritance"),
    ];

    for pipeline_token in [false, true] {
        for indirect_count_buffer in [false, true] {
            for condition_value in [false, true] {
                for inverted in [false, true] {
                    for (use_secondaries, suffix) in secondary_usage_cases {
                        for compute_queue in [false, true] {
                            let params = TestParams {
                                pipeline_token,
                                indirect_count_buffer,
                                condition_value,
                                inverted,
                                use_secondaries,
                                compute_queue,
                            };
                            let name = format!(
                                "{}{}{}{}{}{}",
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
                                suffix,
                                if inverted { "_inverted_flag" } else { "" },
                                if compute_queue { "_cq" } else { "_uq" },
                            );
                            cases.push((
                                format!("nv.compute.conditional_rendering.general.{name}"),
                                Box::new(ConditionalCase {
                                    name,
                                    variant: Variant::Dispatch(params),
                                }) as Box<dyn TestCase>,
                            ));
                        }
                    }
                }
            }
        }
    }

    for condition_value in [false, true] {
        for inverted in [false, true] {
            for execute_on_compute in [false, true] {
                let params = ConditionalPreprocessParams {
                    condition_value,
                    inverted,
                    execute_on_compute,
                };
                let name = format!(
                    "{}{}{}",
                    if condition_value {
                        "condition_true"
                    } else {
                        "condition_false"
                    },
                    if inverted { "_inverted_flag" } else { "" },
                    if execute_on_compute { "_exec_on_compute" } else { "" },
                );
                cases.push((
                    format!("nv.compute.conditional_rendering.preprocess.{name}"),
                    Box::new(ConditionalCase {
                        name,
                        variant: Variant::Preprocess(params),
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases
}

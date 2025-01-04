// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeMiscTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_nv_misc.toml` (`scripts/gen_dgc_nv_misc_manifest.py`);
// the scratch space shader is `misc_scratch_space` of the EXT misc tests (the same SPIR-V assembly file).
//
// `dgc.nv.compute.misc` (VK_NV_device_generated_commands_compute): many executions of one sequence each on primary or secondary command
// buffers, a full capture/replay of a pipeline address, and a pipeline that needs scratch space.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    NvDeviceGeneratedCommandsComputeExtensionDeviceCommands, NvDeviceGeneratedCommandsExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_compute_misc::ALL_SHARED_PROGRAM as EXT_MISC_PROGRAMS;
use crate::generated::shaders::dgc_nv_misc::ALL_SHARED_PROGRAM as NV_MISC_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier, make_pipeline_layout, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::util_nv::{
    DgcComputePipeline, DgcComputePipelineMetaDataPool, GeneratedCommandsInfoNv, IndirectCommandsLayoutBuilderNv,
    PreprocessBufferNv, begin_plain_secondary_command_buffer, check_dgc_compute_support, create_compute_pipeline,
    get_generated_commands_memory_requirements_nv, make_indirect_commands_stream_nv,
    metadata_update_to_preprocess_barrier,
};
use crate::vkt::{Context, TestCase, TestInstance};

const MANY_EXECUTES_LOCAL_INVOCATIONS: u32 = 64;

#[derive(Clone, Copy)]
enum Variant {
    /// Amount of executes to run, secondary command buffer, compute queue.
    ManyExecutes {
        execute_count: u32,
        secondaries: bool,
        compute_queue: bool,
    },
    FullReplay,
    ScratchSpace,
}

struct MiscCase {
    name: String,
    variant: Variant,
}

impl TestCase for MiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.variant {
            Variant::ManyExecutes { .. } => check_dgc_compute_support(context, false, false),
            Variant::FullReplay => check_dgc_compute_support(context, true, true),
            Variant::ScratchSpace => {
                check_dgc_compute_support(context, true, false)?;
                if context.get_compute_queue().is_none() {
                    return Err(TestError::NotSupported("No compute queue available".to_string()));
                }
                Ok(())
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        let (programs, wanted) = match self.variant {
            Variant::ManyExecutes { .. } => (&NV_MISC_PROGRAMS[..], "nv_misc_many"),
            Variant::FullReplay => (&NV_MISC_PROGRAMS[..], "nv_misc_replay"),
            Variant::ScratchSpace => (&EXT_MISC_PROGRAMS[..], "misc_scratch_space"),
        };
        programs
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MiscInstance {
            context,
            variant: self.variant,
        })
    }
}

struct MiscInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
}

fn host_buffer<'a, T: Copy>(context: &'a Context<'a>, data: &[T]) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = std::mem::size_of_val(data) as vk::DeviceSize;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            size,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::INDIRECT_BUFFER,
        ),
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

fn shader_write_to_host_barrier(device: &Device, cmd: vk::CommandBuffer) {
    let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

impl TestInstance for MiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::ManyExecutes {
                execute_count,
                secondaries,
                compute_queue,
            } => self.many_executes_run(execute_count, secondaries, compute_queue),
            Variant::FullReplay => self.full_replay_run(),
            Variant::ScratchSpace => self.scratch_space_run(),
        }
    }
}

impl MiscInstance<'_> {
    /// `manyExecutesRun`
    fn many_executes_run(&self, execute_count: u32, secondaries: bool, compute_queue: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = if compute_queue {
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
        let output_buffer_size = vk::DeviceSize::from(execute_count) * 4;
        let output_buffer = host_buffer(context, &vec![0u32; execute_count as usize])?;

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
        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_buffer_size);
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

        // Shader and pipeline.
        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;
        let pipeline = create_compute_pipeline(device, *pipeline_layout, *comp_module, 0)?;

        // Generated commands layout: push constant and dispatch.
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), bind_point);
        cmds_layout_builder.add_push_constant_token(0, 0, *pipeline_layout, stage_flags, 0, 4);
        cmds_layout_builder.add_dispatch_token(0, 4);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generated indirect commands buffer contents. Increase the value index (indicated by the push constant) in each sequence, then
        // dispatch one workgroup.
        let mut gen_cmds_data: Vec<u32> = Vec::with_capacity(4 * execute_count as usize);
        for i in 0..execute_count {
            gen_cmds_data.push(i); // Push constant.
            gen_cmds_data.extend([1, 1, 1]); // VkDispatchIndirectCommand
        }
        let gen_cmds_buffer = host_buffer(context, &gen_cmds_data)?;

        // Critical for the test: instead of running all these sequences in parallel, we execute one sequence at a time. For the preprocess
        // buffer, we'll use a region of the same large buffer in each execution.
        let mut dgc_properties = vk::PhysicalDeviceDeviceGeneratedCommandsPropertiesNV::default();
        {
            use vulkanalia::vk::InstanceV1_1;
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut dgc_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }
        let preprocess_alignment =
            vk::DeviceSize::from(dgc_properties.min_indirect_commands_buffer_offset_alignment).max(1);

        let mut preprocess_buffer_reqs =
            get_generated_commands_memory_requirements_nv(device, bind_point, *pipeline, cmds_layout.get(), 1);

        // Round up to the proper alignment, and multiply by the number of executions.
        let preprocess_buffer_stride =
            preprocess_buffer_reqs.size.div_ceil(preprocess_alignment) * preprocess_alignment;
        preprocess_buffer_reqs.size = preprocess_buffer_stride * vk::DeviceSize::from(execute_count);

        let preprocess_buffer_info =
            make_buffer_create_info(preprocess_buffer_reqs.size, vk::BufferUsageFlags::INDIRECT_BUFFER);
        let preprocess_buffer =
            unsafe { device.create_buffer(&preprocess_buffer_info, None) }.vk_check("vkCreateBuffer")?;
        let preprocess_buffer = Unique::new(device, preprocess_buffer);
        let preprocess_buffer_alloc =
            context
                .get_default_allocator()
                .allocate(device, preprocess_buffer_reqs, MemoryRequirement::ANY)?;
        unsafe {
            device.bind_buffer_memory(
                *preprocess_buffer,
                preprocess_buffer_alloc.get_memory(),
                preprocess_buffer_alloc.get_offset(),
            )
        }
        .vk_check("vkBindBufferMemory")?;

        // Command pool and buffers.
        let cmd_pool = make_command_pool(device, qf_index)?;
        let pri_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let pri_cmd_buffer = pri_owner.get();
        let sec_owner = if secondaries {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        // Main command buffer contents.
        let main_cmd_buffer = sec_owner.as_ref().map_or(pri_cmd_buffer, |owner| owner.get());
        if secondaries {
            begin_plain_secondary_command_buffer(device, main_cmd_buffer)?;
        } else {
            begin_command_buffer(device, main_cmd_buffer)?;
        }

        unsafe {
            device.cmd_bind_descriptor_sets(
                main_cmd_buffer,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            device.cmd_bind_pipeline(main_cmd_buffer, bind_point, *pipeline);
        }

        // Again, key for the test: run multiple executions instead of a single one.
        let gen_cmds_stride = vk::DeviceSize::from(cmds_layout_builder.get_stream_range(0));
        let mut infos = Vec::with_capacity(execute_count as usize);
        for i in 0..execute_count {
            // Specify a per-execution offset in the commands stream.
            let gen_cmds_buffer_offset = gen_cmds_stride * vk::DeviceSize::from(i);
            let stream_info = make_indirect_commands_stream_nv(gen_cmds_buffer.get(), gen_cmds_buffer_offset);
            let preprocess_offset = preprocess_buffer_stride * vk::DeviceSize::from(i);
            let cmds_info = GeneratedCommandsInfoNv::new(
                bind_point,
                *pipeline,
                cmds_layout.get(),
                &[stream_info],
                1,
                *preprocess_buffer,
                preprocess_buffer_stride,
                vk::Buffer::null(),
                0,
            )
            .with_preprocess_offset(preprocess_offset);
            unsafe { device.cmd_execute_generated_commands_nv(main_cmd_buffer, false, cmds_info.get()) };
            infos.push(cmds_info);
        }
        shader_write_to_host_barrier(device, main_cmd_buffer);
        end_command_buffer(device, main_cmd_buffer)?;

        if let Some(secondary) = &sec_owner {
            begin_command_buffer(device, pri_cmd_buffer)?;
            unsafe { device.cmd_execute_commands(pri_cmd_buffer, &[secondary.get()]) };
            end_command_buffer(device, pri_cmd_buffer)?;
        }

        submit_commands_and_wait(device, queue, pri_cmd_buffer)?;
        drop(preprocess_buffer_alloc);

        // Verify results.
        let alloc = output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        // SAFETY: the buffer holds `execute_count` words and the device finished writing.
        let output_values = unsafe {
            std::slice::from_raw_parts(alloc.get_host_ptr().cast_const().cast::<u32>(), execute_count as usize)
        };

        let mut fail = false;
        for (i, result) in output_values.iter().enumerate() {
            if *result != MANY_EXECUTES_LOCAL_INVOCATIONS {
                log::error!("Error at execution {i}: expected {MANY_EXECUTES_LOCAL_INVOCATIONS} but found {result}");
                fail = true;
            }
        }
        if fail {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `fullReplayRun`: two runs, one with the normal pipeline and the second one with a replayed address.
    fn full_replay_run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let iter_count = 2u32; // First one capturing the address and the second one replaying it.

        // Output buffer.
        let output_buffer_size = vk::DeviceSize::from(iter_count) * 4;
        let output_buffer = host_buffer(context, &vec![0u32; iter_count as usize])?;

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
            stage_flags,
            offset: 0,
            size: 4,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        // Indirect commands layout.
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), bind_point);
        cmds_layout_builder.add_pipeline_token(0, 0);
        let offset = cmds_layout_builder.get_stream_range(0);
        cmds_layout_builder.add_push_constant_token(0, offset, *pipeline_layout, stage_flags, 0, 4);
        let offset = cmds_layout_builder.get_stream_range(0);
        cmds_layout_builder.add_dispatch_token(0, offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // This one will store the captured address for the second iteration.
        let mut captured_address = 0u64;

        for iter_idx in 0..iter_count {
            // Prepare the pipeline, with capture/replay enabled in the metadata pool.
            let metadata_pool =
                DgcComputePipelineMetaDataPool::new(context, DgcComputePipelineMetaDataPool::DEFAULT_MULTIPLIER, true);
            let pipeline = DgcComputePipeline::new(
                &metadata_pool,
                device,
                vk::PipelineCreateFlags::empty(),
                *pipeline_layout,
                vk::PipelineShaderStageCreateFlags::empty(),
                *comp_module,
                None,
                captured_address,
                vk::Pipeline::null(),
                -1,
                0,
            )?;
            let pipeline_address = pipeline.get_indirect_device_address();

            if captured_address != 0 && captured_address != pipeline_address {
                return Ok(TestStatus::fail("Captured address and replayed address do not match"));
            }
            captured_address = pipeline_address;

            // Generated indirect commands buffer contents.
            let gen_cmds_data: Vec<u32> = vec![
                pipeline_address as u32,
                (pipeline_address >> 32) as u32, // Pipeline address (2 uints).
                iter_idx,                        // Push constant: the index to the output buffer.
                1,
                1,
                1, // VkDispatchIndirectCommand
            ];
            let gen_cmds_buffer = host_buffer(context, &gen_cmds_data)?;

            // Preprocess buffer for 1 sequence.
            let preprocess_buffer =
                PreprocessBufferNv::new(context, bind_point, vk::Pipeline::null(), cmds_layout.get(), 1)?;

            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer_owner.get();

            begin_command_buffer(device, cmd_buffer)?;
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[],
                );
                device.cmd_update_pipeline_indirect_buffer_nv(cmd_buffer, bind_point, pipeline.get());
            }
            metadata_update_to_preprocess_barrier(device, cmd_buffer);
            {
                let stream_info = make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0);
                let cmds_info = GeneratedCommandsInfoNv::new(
                    bind_point,
                    vk::Pipeline::null(),
                    cmds_layout.get(),
                    &[stream_info],
                    1,
                    preprocess_buffer.get(),
                    preprocess_buffer.get_size(),
                    vk::Buffer::null(),
                    0,
                );
                unsafe { device.cmd_execute_generated_commands_nv(cmd_buffer, false, cmds_info.get()) };
            }
            shader_write_to_host_barrier(device, cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;
        }

        // Verify results.
        let alloc = output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        // SAFETY: the buffer holds `iter_count` words and the device finished writing.
        let output_values =
            unsafe { std::slice::from_raw_parts(alloc.get_host_ptr().cast_const().cast::<u32>(), iter_count as usize) };

        let reference = 1u32;
        let mut fail = false;
        for (i, result) in output_values.iter().enumerate() {
            if reference != *result {
                log::error!(
                    "Unexpected value found in output buffer position {i}: expected {reference} but found {result}"
                );
                fail = true;
            }
        }
        if fail {
            return Ok(TestStatus::fail(
                "Unexpected data found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `ScratchSpaceInstance::iterate`
    fn scratch_space_run(&self) -> TestOutcome {
        const LOCAL_INVOCATIONS: usize = 4; // Must match ScratchSpace.comp
        // Must match ScratchSpace.comp: these were obtained in practice by converting the shader to C.
        const EXPECTED_OUTPUTS: [i32; LOCAL_INVOCATIONS] = [-256, -46, -327, -722];

        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (compute_queue, compute_qf_index) = context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("No compute queue available".to_string()))?;
        let buffer_size = (LOCAL_INVOCATIONS * 4) as vk::DeviceSize;

        // Output and input buffers.
        let output_buffer = host_buffer(context, &[0i32; LOCAL_INVOCATIONS])?;
        let input_values: Vec<i32> = (0..LOCAL_INVOCATIONS as i32).collect();
        let input_buffer = host_buffer(context, &input_values)?;

        // Descriptor set layout, pool and set preparation.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stage_flags)
            .add_single_binding(desc_type, stage_flags)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 2).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let input_desc_info = make_descriptor_buffer_info(input_buffer.get(), 0, buffer_size);
        let output_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(descriptor_set.get(), Location::binding(0), desc_type, &input_desc_info)
            .write_single(descriptor_set.get(), Location::binding(1), desc_type, &output_desc_info)
            .update(device);

        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        // DGC Pipeline.
        let metadata_pool =
            DgcComputePipelineMetaDataPool::new(context, DgcComputePipelineMetaDataPool::DEFAULT_MULTIPLIER, false);
        let dgc_pipeline = DgcComputePipeline::new(
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
        )?;

        // Indirect commands layout: pipeline token followed by dispatch.
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), bind_point);
        cmds_layout_builder.add_pipeline_token(0, 0);
        let offset = cmds_layout_builder.get_stream_range(0);
        cmds_layout_builder.add_dispatch_token(0, offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generated indirect commands buffer contents.
        let address = dgc_pipeline.get_indirect_device_address();
        let gen_cmds_data: Vec<u32> = vec![address as u32, (address >> 32) as u32, 1, 1, 1];
        let gen_cmds_buffer = host_buffer(context, &gen_cmds_data)?;

        // Preprocess buffer for 1 sequence.
        let preprocess_buffer =
            PreprocessBufferNv::new(context, bind_point, vk::Pipeline::null(), cmds_layout.get(), 1)?;

        // We will update the pipeline metadata buffer on the universal queue, and submit the dispatch to the compute queue.
        {
            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer_owner.get();

            begin_command_buffer(device, cmd_buffer)?;
            unsafe { device.cmd_update_pipeline_indirect_buffer_nv(cmd_buffer, bind_point, dgc_pipeline.get()) };
            metadata_update_to_preprocess_barrier(device, cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;
            unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?; // Why not?
        }
        {
            let cmd_pool = make_command_pool(device, compute_qf_index)?;
            let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer_owner.get();

            begin_command_buffer(device, cmd_buffer)?;
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[],
                );
            }
            {
                let stream_info = make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0);
                let cmds_info = GeneratedCommandsInfoNv::new(
                    bind_point,
                    vk::Pipeline::null(),
                    cmds_layout.get(),
                    &[stream_info],
                    1,
                    preprocess_buffer.get(),
                    preprocess_buffer.get_size(),
                    vk::Buffer::null(),
                    0,
                );
                unsafe { device.cmd_execute_generated_commands_nv(cmd_buffer, false, cmds_info.get()) };
            }
            shader_write_to_host_barrier(device, cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
            submit_commands_and_wait(device, compute_queue, cmd_buffer)?;
        }

        // Verify results.
        let alloc = output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        // SAFETY: the buffer holds `LOCAL_INVOCATIONS` words and the device finished writing.
        let output_values =
            unsafe { std::slice::from_raw_parts(alloc.get_host_ptr().cast_const().cast::<i32>(), LOCAL_INVOCATIONS) };

        let mut fail = false;
        for (i, (result, reference)) in output_values.iter().zip(EXPECTED_OUTPUTS).enumerate() {
            if *result != reference {
                log::error!(
                    "Unexpected value found in output buffer at position {i}: expected {reference} but found {result}"
                );
                fail = true;
            }
        }
        if fail {
            return Ok(TestStatus::fail(
                "Unexpected values in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCComputeMiscTests`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_misc_tests_nv() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for execute_count in [64u32, 1024, 8192] {
        for secondaries in [false, true] {
            for compute_queue in [false, true] {
                let type_variant = if secondaries { "_secondary_cmd" } else { "_primary_cmd" };
                let queue_variant = if compute_queue {
                    "_compute_queue"
                } else {
                    "_universal_queue"
                };
                let name = format!("execute_many_{execute_count}{type_variant}{queue_variant}");
                cases.push((
                    format!("nv.compute.misc.{name}"),
                    Box::new(MiscCase {
                        name,
                        variant: Variant::ManyExecutes {
                            execute_count,
                            secondaries,
                            compute_queue,
                        },
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases.push((
        "nv.compute.misc.full_replay".to_string(),
        Box::new(MiscCase {
            name: "full_replay".to_string(),
            variant: Variant::FullReplay,
        }) as Box<dyn TestCase>,
    ));
    cases.push((
        "nv.compute.misc.scratch_space".to_string(),
        Box::new(MiscCase {
            name: "scratch_space".to_string(),
            variant: Variant::ScratchSpace,
        }) as Box<dyn TestCase>,
    ));
    cases
}

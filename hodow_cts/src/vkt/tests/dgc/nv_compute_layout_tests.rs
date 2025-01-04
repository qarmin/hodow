// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeLayoutTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_nv_layout.toml`
// (`scripts/gen_dgc_nv_layout_manifest.py`), one shared program per kind of constants.
//
// `dgc.nv.compute.layout` (VK_NV_device_generated_commands_compute): sequences of push constant, pipeline and dispatch tokens in several
// layouts, each dispatch specialized by push constants, specialization constants or both, writing to a different area of the output buffer.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    InstanceV1_1, NvDeviceGeneratedCommandsComputeExtensionDeviceCommands,
    NvDeviceGeneratedCommandsExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_nv_layout::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
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
    PreprocessBufferNv, check_dgc_compute_support, create_compute_pipeline, make_indirect_commands_stream_nv,
    metadata_update_to_preprocess_barrier,
};
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    PushDispatch,
    ComplementaryPushDispatch,
    PartialPushDispatch,
    PipelineDispatch,
    PipelinePushDispatch,
    PipelineComplementaryPushDispatch,
}

impl TestType {
    fn has_pipeline_switch(self) -> bool {
        matches!(
            self,
            TestType::PipelineDispatch | TestType::PipelinePushDispatch | TestType::PipelineComplementaryPushDispatch
        )
    }

    /// Has a fourth push constant that's pushed outside the indirect commands stream.
    fn has_complementary_push(self) -> bool {
        matches!(
            self,
            TestType::ComplementaryPushDispatch | TestType::PipelineComplementaryPushDispatch
        )
    }

    fn numeric(self) -> u32 {
        match self {
            TestType::PushDispatch => 0,
            TestType::ComplementaryPushDispatch => 1,
            TestType::PartialPushDispatch => 2,
            TestType::PipelineDispatch => 3,
            TestType::PipelinePushDispatch => 4,
            TestType::PipelineComplementaryPushDispatch => 5,
        }
    }

    fn program_name(self) -> &'static str {
        match self {
            TestType::PushDispatch | TestType::PartialPushDispatch => "nv_layout_push",
            TestType::ComplementaryPushDispatch => "nv_layout_complementary",
            TestType::PipelineDispatch => "nv_layout_spec",
            TestType::PipelinePushDispatch => "nv_layout_pipeline_push",
            TestType::PipelineComplementaryPushDispatch => "nv_layout_pipeline_complementary",
        }
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    test_type: TestType,
    /// Attempt to align pipeline addresses to 4 bytes instead of 8.
    align4: bool,
    /// Use the compute queue.
    compute_queue: bool,
    /// Use capture/replay for pipeline addresses.
    capture_replay: bool,
}

/// The specialization data used in each dispatch: as specialization constants, push constants or both.
#[repr(C)]
#[derive(Clone, Copy)]
struct SpecializationData {
    /// Offset in the array for this dispatch.
    dispatch_offset: u32,
    /// This invocation will not perform the write.
    skip_index: u32,
    /// The local invocation index and workgroup index will be combined with this.
    value_offset: u32,
}

const LOCAL_INVOCATIONS: u32 = 64;
const SEQUENCE_COUNT: u32 = 4;
const CONSTANT_SIZE: u32 = 4;

struct LayoutCase {
    name: String,
    params: TestParams,
}

impl TestCase for LayoutCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let require_pipeline_support = self.params.test_type.has_pipeline_switch();
        check_dgc_compute_support(context, require_pipeline_support, self.params.capture_replay)?;

        if self.params.align4 {
            let mut properties = vk::PhysicalDeviceDeviceGeneratedCommandsPropertiesNV::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            if properties.min_indirect_commands_buffer_offset_alignment > 4 {
                return Err(TestError::NotSupported(
                    "minIndirectCommandsBufferOffsetAlignment greater than 4".to_string(),
                ));
            }
        }

        if self.params.compute_queue && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("No compute queue available".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = self.params.test_type.program_name();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LayoutInstance {
            context,
            params: self.params,
        })
    }
}

struct LayoutInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// The pipelines of a test: a single normal one when there are no pipeline switches, one DGC pipeline per dispatch otherwise.
struct Pipelines<'a> {
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pc_token_data_size: u32,
    layout_pc_size: u32,
    single_pipeline: Option<Unique<'a, vk::Pipeline>>,
    _meta_data_pool: Option<DgcComputePipelineMetaDataPool<'a>>,
    dgc_pipelines: Vec<DgcComputePipeline<'a>>,
    _module: Unique<'a, vk::ShaderModule>,
}

impl<'a> LayoutInstance<'a> {
    /// `createPipelines`
    fn create_pipelines(
        &self,
        set_layout: vk::DescriptorSetLayout,
        specialization_data: &[SpecializationData],
    ) -> Result<Pipelines<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let params = self.params;
        let shader_stage = vk::ShaderStageFlags::COMPUTE;
        let pipeline_switch = params.test_type.has_pipeline_switch();
        let extra_push = params.test_type.has_complementary_push();

        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        let pipeline_layout;
        let mut pc_token_data_size = 0u32;
        let mut layout_pc_size = 0u32;
        let mut single_pipeline = None;
        let mut meta_data_pool = None;
        let mut dgc_pipelines = Vec::new();

        if pipeline_switch {
            // The sequence includes a set-pipeline token, so there is one different pipeline per dispatch.

            // Specialization constant ids used by the shader.
            let constant_ids: Vec<u32> = if params.test_type == TestType::PipelineDispatch {
                // 3 constants with ids 0, 1, 2; see shader code.
                vec![0, 1, 2]
            } else {
                // Single constant with id 2; see shader code.
                vec![2]
            };

            // Specialization map entries, depending on constant_ids. Note for the case of a single constant with id 2, the offset is not
            // zero: the base address of the SpecializationData structure is always the base address of the data.
            let map_entries: Vec<vk::SpecializationMapEntry> = constant_ids
                .iter()
                .map(|constant_id| vk::SpecializationMapEntry {
                    constant_id: *constant_id,
                    offset: CONSTANT_SIZE * constant_id,
                    size: CONSTANT_SIZE as usize,
                })
                .collect();

            // Prepare the right layout.
            if params.test_type == TestType::PipelineDispatch {
                // Specialization constants only.
                pipeline_layout = make_pipeline_layout(device, &[set_layout])?;
            } else {
                // Mix of push constants and spec constants: 2 push constants (3 for complementary push) and 1 spec constant.
                let pc_items = 2u32;
                pc_token_data_size = pc_items * CONSTANT_SIZE;
                layout_pc_size = pc_token_data_size;
                if extra_push {
                    layout_pc_size += CONSTANT_SIZE;
                }
                let pc_range = vk::PushConstantRange {
                    stage_flags: shader_stage,
                    offset: 0,
                    size: layout_pc_size,
                };
                pipeline_layout = make_pipeline_layout_with_push_constants(device, &[set_layout], &[pc_range])?;
            }

            // Create the pipelines, optionally using capture/replay.
            let mut captured_addresses = vec![0u64; specialization_data.len()];

            if params.capture_replay {
                let temporary_pool = DgcComputePipelineMetaDataPool::new(
                    context,
                    DgcComputePipelineMetaDataPool::DEFAULT_MULTIPLIER,
                    true,
                );
                let mut temporary_pipelines = Vec::with_capacity(specialization_data.len());
                for (i, data) in specialization_data.iter().enumerate() {
                    let specialization_info = vk::SpecializationInfo {
                        map_entry_count: map_entries.len() as u32,
                        map_entries: map_entries.as_ptr(),
                        data_size: std::mem::size_of::<SpecializationData>(),
                        data: (data as *const SpecializationData).cast(),
                    };
                    // Note no capture/replay address given.
                    let pipeline = DgcComputePipeline::new(
                        &temporary_pool,
                        device,
                        vk::PipelineCreateFlags::empty(),
                        *pipeline_layout,
                        vk::PipelineShaderStageCreateFlags::empty(),
                        *comp_module,
                        Some(&specialization_info),
                        0,
                        vk::Pipeline::null(),
                        -1,
                        0,
                    )?;
                    // Save capture/replay address.
                    captured_addresses[i] = pipeline.get_indirect_device_address();
                    temporary_pipelines.push(pipeline);
                }
                // The temporary pipelines and metadata pool go out of scope here.
            }

            let pool = DgcComputePipelineMetaDataPool::new(
                context,
                DgcComputePipelineMetaDataPool::DEFAULT_MULTIPLIER,
                params.capture_replay,
            );
            for (i, data) in specialization_data.iter().enumerate() {
                let specialization_info = vk::SpecializationInfo {
                    map_entry_count: map_entries.len() as u32,
                    map_entries: map_entries.as_ptr(),
                    data_size: std::mem::size_of::<SpecializationData>(),
                    data: (data as *const SpecializationData).cast(),
                };
                // Capture/replay address if needed (it will be 0 otherwise).
                dgc_pipelines.push(DgcComputePipeline::new(
                    &pool,
                    device,
                    vk::PipelineCreateFlags::empty(),
                    *pipeline_layout,
                    vk::PipelineShaderStageCreateFlags::empty(),
                    *comp_module,
                    Some(&specialization_info),
                    captured_addresses[i],
                    vk::Pipeline::null(),
                    -1,
                    0,
                )?);
            }
            meta_data_pool = Some(pool);
        } else {
            // Create the single pipeline. This case uses push constants only.
            pc_token_data_size = std::mem::size_of::<SpecializationData>() as u32;
            layout_pc_size = pc_token_data_size;
            if extra_push {
                // An extra constant to be pushed outside the cmd stream.
                layout_pc_size += CONSTANT_SIZE;
            }
            let pc_range = vk::PushConstantRange {
                stage_flags: shader_stage,
                offset: 0,
                size: layout_pc_size,
            };
            pipeline_layout = make_pipeline_layout_with_push_constants(device, &[set_layout], &[pc_range])?;
            single_pipeline = Some(create_compute_pipeline(device, *pipeline_layout, *comp_module, 0)?);
        }

        Ok(Pipelines {
            pipeline_layout,
            pc_token_data_size,
            layout_pc_size,
            single_pipeline,
            _meta_data_pool: meta_data_pool,
            dgc_pipelines,
            _module: comp_module,
        })
    }

    /// `makeCommandsLayout`
    fn make_commands_layout(
        &self,
        pipelines: &Pipelines<'a>,
    ) -> Result<crate::vkt::tests::dgc::util_nv::IndirectCommandsLayoutNv<'a>, TestError> {
        let device = self.context.get_device();
        let params = self.params;
        let shader_stage = vk::ShaderStageFlags::COMPUTE;
        let pipeline_layout = *pipelines.pipeline_layout;

        // Note we always add the dispatch token at the end.
        let mut builder = IndirectCommandsLayoutBuilderNv::new(
            vk::IndirectCommandsLayoutUsageFlagsNV::empty(),
            vk::PipelineBindPoint::COMPUTE,
        );

        match params.test_type {
            TestType::PushDispatch | TestType::ComplementaryPushDispatch => {
                debug_assert!(pipelines.pc_token_data_size != 0);
                builder.add_push_constant_token(0, 0, pipeline_layout, shader_stage, 0, pipelines.pc_token_data_size);
            }
            TestType::PartialPushDispatch => {
                // We have 3 push constants and we'll update them in two steps: 0,1 followed by 1,2. This means both updates will be
                // partial, the value of the middle constant will be overwritten, and the first value we push will not be the correct one.
                builder.add_push_constant_token(0, 0, pipeline_layout, shader_stage, 0, CONSTANT_SIZE * 2);
                let offset = builder.get_stream_range(0);
                builder.add_push_constant_token(
                    0,
                    offset,
                    pipeline_layout,
                    shader_stage,
                    CONSTANT_SIZE,
                    CONSTANT_SIZE * 2,
                );
            }
            TestType::PipelineDispatch => builder.add_pipeline_token(0, 0),
            TestType::PipelinePushDispatch | TestType::PipelineComplementaryPushDispatch => {
                debug_assert!(pipelines.pc_token_data_size != 0);
                let pc_offset = if params.test_type == TestType::PipelineComplementaryPushDispatch {
                    CONSTANT_SIZE
                } else {
                    0
                };
                builder.add_pipeline_token(0, 0);
                let offset = builder.get_stream_range(0);
                builder.add_push_constant_token(
                    0,
                    offset,
                    pipeline_layout,
                    shader_stage,
                    pc_offset,
                    pipelines.pc_token_data_size,
                );
            }
        }

        // The dispatch always comes last.
        let offset = builder.get_stream_range(0);
        builder.add_dispatch_token(0, offset);

        if params.test_type.has_pipeline_switch() && !params.align4 {
            // Extend the stream stride manually to make sure pipeline addresses are always aligned to their native size.
            for i in 0..builder.get_stream_count() {
                let auto_stride = builder.get_stream_range(i);
                let manual_stride = auto_stride.div_ceil(8) * 8;
                builder.set_stream_stride(i, manual_stride);
            }
        }
        builder.build(device)
    }

    /// `makeIndirectCommands`
    fn make_indirect_commands(
        &self,
        pipelines: &Pipelines<'a>,
        wg_counts: &[u32],
        specialization_data: &[SpecializationData],
    ) -> Vec<u32> {
        debug_assert_eq!(wg_counts.len(), specialization_data.len());
        let params = self.params;
        let mut indirect_cmds: Vec<u32> = Vec::new();

        let push_dispatch_indirect_command = |indirect_cmds: &mut Vec<u32>, count: u32, add_padding: bool| {
            // These will be interpreted as a VkDispatchIndirectCommand: .x=count .y=1 .z=1
            indirect_cmds.push(count);
            indirect_cmds.push(1);
            indirect_cmds.push(1);
            if add_padding {
                indirect_cmds.push(0xA1B2C3D4);
            }
        };
        let push_address = |indirect_cmds: &mut Vec<u32>, address: u64| {
            indirect_cmds.push(address as u32);
            indirect_cmds.push((address >> 32) as u32);
        };

        let align8 = !params.align4;

        match params.test_type {
            TestType::PushDispatch | TestType::ComplementaryPushDispatch => {
                // 6 uint32_t in total per dispatch: 3 push constants and the indirect dispatch dimensions.
                for (data, wg_count) in specialization_data.iter().zip(wg_counts) {
                    indirect_cmds.push(data.dispatch_offset);
                    indirect_cmds.push(data.skip_index);
                    indirect_cmds.push(data.value_offset);
                    push_dispatch_indirect_command(&mut indirect_cmds, *wg_count, false); // No padding needed.
                }
            }
            TestType::PartialPushDispatch => {
                // 7 uint32_t in total per dispatch: 4 push constants (with overlap) and the indirect dispatch dimensions.
                for (data, wg_count) in specialization_data.iter().zip(wg_counts) {
                    indirect_cmds.push(data.dispatch_offset);
                    indirect_cmds.push(LOCAL_INVOCATIONS - data.skip_index - 1); // Bad value on purpose.
                    indirect_cmds.push(data.skip_index);
                    indirect_cmds.push(data.value_offset);
                    push_dispatch_indirect_command(&mut indirect_cmds, *wg_count, false); // No padding needed.
                }
            }
            TestType::PipelineDispatch => {
                // 5 uint32_t per dispatch (2 for the pipeline address, 3 for the indirect dispatch command), one more for padding.
                debug_assert_eq!(pipelines.dgc_pipelines.len(), wg_counts.len());
                for (pipeline, wg_count) in pipelines.dgc_pipelines.iter().zip(wg_counts) {
                    push_address(&mut indirect_cmds, pipeline.get_indirect_device_address());
                    push_dispatch_indirect_command(&mut indirect_cmds, *wg_count, align8); // Padding may be added.
                }
            }
            TestType::PipelinePushDispatch | TestType::PipelineComplementaryPushDispatch => {
                // 7 uint32_t per dispatch: 2 for the pipeline address, 2 for the push constants and 3 for the indirect dispatch command,
                // plus one more for padding.
                debug_assert_eq!(pipelines.dgc_pipelines.len(), wg_counts.len());
                for ((pipeline, data), wg_count) in
                    pipelines.dgc_pipelines.iter().zip(specialization_data).zip(wg_counts)
                {
                    push_address(&mut indirect_cmds, pipeline.get_indirect_device_address());
                    indirect_cmds.push(data.dispatch_offset);
                    indirect_cmds.push(data.skip_index);
                    // valueOffset provided as a specialization constant in the shader.
                    push_dispatch_indirect_command(&mut indirect_cmds, *wg_count, align8); // Padding may be added.
                }
            }
        }
        indirect_cmds
    }
}

impl TestInstance for LayoutInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let shader_stage = vk::ShaderStageFlags::COMPUTE;
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
        let extra_push = params.test_type.has_complementary_push();
        let value_offset2 = if extra_push { LOCAL_INVOCATIONS } else { 0 };

        // Generate the work group count for each dispatch.
        let min_dispatch_size = 1;
        let max_dispatch_size = 16;

        let seed = 0xff0000u32 | params.test_type.numeric();
        let mut rnd = Random::new(seed);

        // Work group count for each dispatch.
        let wg_counts: Vec<u32> = (0..SEQUENCE_COUNT)
            .map(|_| rnd.get_int(min_dispatch_size, max_dispatch_size) as u32)
            .collect();

        // Specialization data for each dispatch.
        let mut specialization_data: Vec<SpecializationData> = Vec::with_capacity(wg_counts.len());
        {
            let mut prev_wgs = 0u32;
            for (i, wg_count) in wg_counts.iter().enumerate() {
                specialization_data.push(SpecializationData {
                    dispatch_offset: prev_wgs * LOCAL_INVOCATIONS,
                    skip_index: rnd.get_int(0, LOCAL_INVOCATIONS as i32 - 1) as u32,
                    value_offset: (i as u32 + 1) << 20,
                });
                prev_wgs += wg_count;
            }
        }

        // Calculate the required size of the output buffer.
        let total_num_work_groups: u32 = wg_counts.iter().sum();
        let total_invocations = LOCAL_INVOCATIONS * total_num_work_groups;
        let output_buffer_size = vk::DeviceSize::from(total_invocations) * 4;

        // Create a host-visible output buffer.
        let output_buffer_type = vk::DescriptorType::STORAGE_BUFFER;
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = output_buffer.get_allocation();
            // SAFETY: the buffer was created with this size.
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, output_buffer_size as usize) };
            flush_alloc(device, alloc)?;
        }

        // Create the descriptor set layout, descriptor set and update it.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(output_buffer_type, shader_stage)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(output_buffer_type, 1).build(
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
                output_buffer_type,
                &output_buffer_desc_info,
            )
            .update(device);

        // Create the pipelines and the commands layout.
        let pipelines = self.create_pipelines(*set_layout, &specialization_data)?;
        let commands_layout = self.make_commands_layout(&pipelines)?;

        // Create indirect commands buffer contents in a host-visible buffer.
        let indirect_commands = self.make_indirect_commands(&pipelines, &wg_counts, &specialization_data);
        let indirect_cmds_buffer_size = std::mem::size_of_val(indirect_commands.as_slice()) as vk::DeviceSize;
        let indirect_cmds_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(indirect_cmds_buffer_size, vk::BufferUsageFlags::INDIRECT_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = indirect_cmds_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indirect_commands.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    indirect_cmds_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Create a preprocess buffer. The single pipeline is null when using multiple pipelines, which is exactly what we need.
        let single_pipeline_handle = pipelines
            .single_pipeline
            .as_ref()
            .map_or(vk::Pipeline::null(), |pipeline| **pipeline);
        let preprocess_buffer = PreprocessBufferNv::new(
            context,
            bind_point,
            single_pipeline_handle,
            commands_layout.get(),
            wg_counts.len() as u32,
        )?;

        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        let pipeline_layout = *pipelines.pipeline_layout;

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(cmd_buffer, bind_point, pipeline_layout, 0, &[descriptor_set.get()], &[]);
        }

        // Bind or prepare pipelines.
        if single_pipeline_handle != vk::Pipeline::null() {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, bind_point, single_pipeline_handle) };
        } else {
            debug_assert!(!pipelines.dgc_pipelines.is_empty());
            for pipeline in &pipelines.dgc_pipelines {
                unsafe { device.cmd_update_pipeline_indirect_buffer_nv(cmd_buffer, bind_point, pipeline.get()) };
            }
            metadata_update_to_preprocess_barrier(device, cmd_buffer);
        }

        if extra_push {
            // Must match the offset and size of valueOffset2 in the shaders.
            let pc_offset = if params.test_type == TestType::ComplementaryPushDispatch {
                pipelines.pc_token_data_size
            } else {
                0
            };
            debug_assert!(pc_offset + CONSTANT_SIZE <= pipelines.layout_pc_size);
            unsafe {
                device.cmd_push_constants(
                    cmd_buffer,
                    pipeline_layout,
                    shader_stage,
                    pc_offset,
                    &value_offset2.to_ne_bytes(),
                )
            };
        }

        // Execute indirect commands. The single pipeline is null when using multiple pipelines, which is exactly what we want.
        let stream_info = make_indirect_commands_stream_nv(indirect_cmds_buffer.get(), 0);
        let generated_commands_info = GeneratedCommandsInfoNv::new(
            bind_point,
            single_pipeline_handle,
            commands_layout.get(),
            &[stream_info],
            wg_counts.len() as u32,
            preprocess_buffer.get(),
            preprocess_buffer.get_size(),
            vk::Buffer::null(),
            0,
        );
        unsafe { device.cmd_execute_generated_commands_nv(cmd_buffer, false, generated_commands_info.get()) };

        // Sync writes to the output buffer.
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
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Retrieve output values.
        let alloc = output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        // SAFETY: the buffer holds `total_invocations` words and the device finished writing.
        let output_buffer_values = unsafe {
            std::slice::from_raw_parts(
                alloc.get_host_ptr().cast_const().cast::<u32>(),
                total_invocations as usize,
            )
        };

        // Verify results.
        let mut fail = false;
        let mut value_index = 0usize;
        for (dispatch_idx, (wg_count, data)) in wg_counts.iter().zip(&specialization_data).enumerate() {
            for wg_idx in 0..*wg_count {
                for invocation_idx in 0..LOCAL_INVOCATIONS {
                    // Must match the calculation in the shader, obviously.
                    let expected = if invocation_idx == data.skip_index {
                        0
                    } else {
                        data.value_offset + (wg_idx << 10) + invocation_idx + value_offset2
                    };
                    let result = output_buffer_values[value_index];
                    if expected != result {
                        log::error!(
                            "Unexpected value at index {value_index}; expected {expected} but found {result} ; dispatchIndex={dispatch_idx} workGroupIndex={wg_idx} invocationIndex={invocation_idx} skipIndex={} valueOffset={}",
                            data.skip_index,
                            data.value_offset
                        );
                        fail = true;
                    }
                    value_index += 1;
                }
            }
        }

        if fail {
            for wg_count in &wg_counts {
                log::error!("Dispatch size: {wg_count}");
            }
            return Ok(TestStatus::fail(
                "Unexpected output values found; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCComputeLayoutTests`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_layout_tests_nv() -> Vec<(String, Box<dyn TestCase>)> {
    let test_types_table = [
        (TestType::PushDispatch, false, false, "push_dispatch"),
        (
            TestType::ComplementaryPushDispatch,
            false,
            false,
            "complementary_push_dispatch",
        ),
        (TestType::PartialPushDispatch, false, false, "partial_push_dispatch"),
        (TestType::PipelineDispatch, false, false, "pipeline_dispatch"),
        (TestType::PipelinePushDispatch, false, false, "pipeline_push_dispatch"),
        (
            TestType::PipelinePushDispatch,
            false,
            true,
            "pipeline_push_dispatch_capture_replay",
        ),
        (TestType::PipelineDispatch, true, false, "pipeline_dispatch_align4"),
        (
            TestType::PipelinePushDispatch,
            true,
            false,
            "pipeline_push_dispatch_align4",
        ),
        (
            TestType::PipelineComplementaryPushDispatch,
            false,
            false,
            "pipeline_complementary_push_dispatch",
        ),
    ];

    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for use_compute_queue in [false, true] {
        for (test_type, align4, capture_replay, name) in test_types_table {
            let test_name = format!("{name}{}", if use_compute_queue { "_cq" } else { "" });
            cases.push((
                format!("nv.compute.layout.{test_name}"),
                Box::new(LayoutCase {
                    name: test_name,
                    params: TestParams {
                        test_type,
                        align4,
                        compute_queue: use_compute_queue,
                        capture_replay,
                    },
                }) as Box<dyn TestCase>,
            ));
        }
    }
    cases
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCStatQueryTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Copyright (c) 2026 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the compute case (`comp_inv_*`, 12 names) is ported: the graphics and mesh
// stats (pipeline wrappers over vertex, tessellation, geometry, fragment, task and mesh stages, built three ways) stay gated. The
// programs are pre-expanded in `shaders/manifest/dgc_stat_query.toml` (`scripts/gen_dgc_stat_query_manifest.py`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands};

use crate::generated::shaders::dgc_stat_query::ALL_SHARED_PROGRAM;
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
    make_descriptor_set, make_memory_barrier, make_pipeline_layout_with_push_constants,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::compute_layout_tests::make_compute_shader;
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::shader_object::util::ShaderObject;
use crate::vkt::{Context, TestCase, TestInstance};

const COMP_WORK_GROUP_SIZE: u32 = 64;
const COMP_WORK_GROUP_COUNT: u32 = 64;

#[derive(Clone, Copy)]
struct TestParams {
    construction_type: PipelineConstructionType,
    use_execution_set: bool,
    preprocess: bool,
}

impl TestParams {
    fn use_eso(&self) -> bool {
        self.construction_type == PipelineConstructionType::ShaderObjectUnlinkedSpirv
    }

    /// `getShaderVariantCount(VK_SHADER_STAGE_COMPUTE_BIT)`
    fn comp_shader_count(&self) -> u32 {
        if self.use_execution_set { 2 } else { 1 }
    }
}

struct StatQueryCase {
    name: String,
    params: TestParams,
}

impl TestCase for StatQueryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;
        let stages = vk::ShaderStageFlags::COMPUTE;
        let use_eso = params.use_eso();
        let bind_stages_pipeline = if params.use_execution_set && !use_eso {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        let bind_stages_shader_object = if params.use_execution_set && use_eso {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        check_dgc_ext_support(
            context,
            stages,
            bind_stages_pipeline,
            bind_stages_shader_object,
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;

        check_pipeline_construction_requirements(context, params.construction_type)?;

        if context.get_device_features().pipeline_statistics_query == vk::FALSE {
            return Err(TestError::NotSupported(
                "pipelineStatisticsQuery not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "stat_query_comp")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StatQueryInstance {
            context,
            params: self.params,
        })
    }
}

struct StatQueryInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for StatQueryInstance<'_> {
    /// `iterate`, compute path
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let use_eso = params.use_eso();
        let shader_stage = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let comp_shader_count = params.comp_shader_count();
        let max_sequence_count = 2u32.max(comp_shader_count);

        let comp_buffer_item_count = COMP_WORK_GROUP_SIZE * COMP_WORK_GROUP_COUNT;
        let comp_buffer_size =
            vk::DeviceSize::from(comp_buffer_item_count) * std::mem::size_of::<u32>() as vk::DeviceSize;
        let comp_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(comp_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = comp_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, comp_buffer_size as usize) };
            flush_alloc(device, alloc)?;
        }

        // Both the compute and task shaders need a uint32_t push constant.
        let pc_range = vk::PushConstantRange {
            stage_flags: shader_stage,
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        };
        let pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, shader_stage)
            .build(device)?;
        let desc_set = make_descriptor_set(device, *pool, *set_layout)?;
        let buffer_desc = make_descriptor_buffer_info(comp_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(desc_set.get(), Location::binding(0), desc_type, &buffer_desc)
            .update(device);
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let binaries = context.get_binary_collection();
        let mut comp_shaders: Vec<ShaderObject<'_>> = Vec::new();
        let mut comp_pipelines: Vec<ComputePipelineWrapper<'_>> = Vec::new();
        for i in 0..comp_shader_count {
            let binary = binaries.get(&format!("comp{i}"))?;
            if use_eso {
                comp_shaders.push(make_compute_shader(
                    device,
                    &binary,
                    params.use_execution_set,
                    &[*set_layout],
                    &[pc_range],
                    None,
                )?);
            } else {
                let mut pipeline =
                    ComputePipelineWrapper::new(device, ComputePipelineConstructionType::Pipeline, binary);
                pipeline.set_descriptor_set_layout(*set_layout);
                pipeline.add_push_constant_range(pc_range);
                if params.use_execution_set {
                    pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
                }
                pipeline.build_pipeline()?;
                comp_pipelines.push(pipeline);
            }
        }
        // Each pipeline has a layout of its own, identical to the one used for the rest of the commands.
        let layout_handle = comp_pipelines
            .first()
            .map_or(*pipeline_layout, ComputePipelineWrapper::get_pipeline_layout);

        let mut ies_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if params.use_execution_set {
            let mut manager = if use_eso {
                let mut manager = ExecutionSetManagerExt::new_shader(
                    device,
                    &[(comp_shaders[0].get(), vec![*set_layout])],
                    &[pc_range],
                    comp_shader_count,
                )?;
                for (i, shader) in comp_shaders.iter().enumerate() {
                    manager.add_shader(i as u32, shader.get());
                }
                manager
            } else {
                let mut manager =
                    ExecutionSetManagerExt::new_pipeline(device, comp_pipelines[0].get_pipeline(), comp_shader_count)?;
                for (i, pipeline) in comp_pipelines.iter().enumerate() {
                    manager.add_pipeline(i as u32, pipeline.get_pipeline());
                }
                manager
            };
            manager.update();
            ies_manager = Some(manager);
        }

        let mut cmds_layout_flags = vk::IndirectCommandsLayoutUsageFlagsEXT::empty();
        if params.preprocess {
            cmds_layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS;
        }
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, shader_stage, layout_handle);
        if params.use_execution_set {
            if use_eso {
                cmds_layout_builder.add_compute_shader_object_token(0);
            } else {
                cmds_layout_builder.add_compute_pipeline_token(0);
            }
        }
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_push_constant_token(stream_range, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let comp_dispatch_x = COMP_WORK_GROUP_COUNT / max_sequence_count;
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..max_sequence_count {
            if params.use_execution_set {
                dgc_data.push(i);
            }
            dgc_data.push(i * comp_dispatch_x); // wgOffset
            dgc_data.extend([comp_dispatch_x, 1, 1]); // VkDispatchIndirectCommand
        }
        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let ies_handle = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);
        let preprocess_pipeline = if ies_handle != vk::IndirectExecutionSetEXT::null() || use_eso {
            vk::Pipeline::null()
        } else {
            comp_pipelines[0].get_pipeline()
        };
        let preprocess_shaders: Vec<vk::ShaderEXT> = if use_eso && ies_handle == vk::IndirectExecutionSetEXT::null() {
            comp_shaders.iter().map(ShaderObject::get).collect()
        } else {
            Vec::new()
        };
        let preprocess_buffer = PreprocessBufferExt::new_with_shaders(
            context,
            ies_handle,
            cmds_layout.get(),
            max_sequence_count,
            0,
            preprocess_pipeline,
            &preprocess_shaders,
            0,
        )?;
        let gen_cmds_info = DgcGenCmdsInfo::new_with_shaders(
            shader_stage,
            ies_handle,
            cmds_layout.get(),
            dgc_buffer.get_device_address(),
            dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            max_sequence_count,
            0,
            0,
            &preprocess_shaders,
        );
        let gen_cmds_info = if preprocess_shaders.is_empty() && preprocess_pipeline != vk::Pipeline::null() {
            DgcGenCmdsInfo::new(
                shader_stage,
                ies_handle,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                max_sequence_count,
                0,
                0,
                preprocess_pipeline,
            )
        } else {
            gen_cmds_info
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        let preprocess_cmd_owner = if params.preprocess {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::PRIMARY,
            )?)
        } else {
            None
        };
        let preprocess_cmd = preprocess_cmd_owner
            .as_ref()
            .map_or(vk::CommandBuffer::null(), |owner| owner.get());

        let query_pool_create_info = vk::QueryPoolCreateInfo {
            query_type: vk::QueryType::PIPELINE_STATISTICS,
            query_count: 1,
            pipeline_statistics: vk::QueryPipelineStatisticFlags::COMPUTE_SHADER_INVOCATIONS,
            ..Default::default()
        };
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_create_info, None) }.vk_check("vkCreateQueryPool")?,
        );
        let reset_cmd_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, reset_cmd_owner.get())?;
        unsafe { device.cmd_reset_query_pool(reset_cmd_owner.get(), *query_pool, 0, 1) };
        end_command_buffer(device, reset_cmd_owner.get())?;
        submit_commands_and_wait(device, context.get_universal_queue(), reset_cmd_owner.get())?;

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                layout_handle,
                0,
                &[desc_set.get()],
                &[] as &[u32],
            );
        }
        if use_eso {
            unsafe { device.cmd_bind_shaders_ext(cmd_buffer, &[shader_stage], &[comp_shaders[0].get()]) };
        } else {
            comp_pipelines[0].bind(cmd_buffer);
        }
        unsafe { device.cmd_begin_query(cmd_buffer, *query_pool, 0, vk::QueryControlFlags::empty()) };
        if params.preprocess {
            begin_command_buffer(device, preprocess_cmd)?;
            unsafe { device.cmd_preprocess_generated_commands_ext(preprocess_cmd, gen_cmds_info.get(), cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, preprocess_cmd);
            end_command_buffer(device, preprocess_cmd)?;
        }
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, gen_cmds_info.get()) };
        unsafe { device.cmd_end_query(cmd_buffer, *query_pool, 0) };
        {
            let host_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[host_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(device, context.get_universal_queue(), cmd_buffer, preprocess_cmd)?;

        let mut fail = false;

        // Verify the output buffer.
        let alloc = comp_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let mut result = vec![0u32; comp_buffer_item_count as usize];
        unsafe { std::ptr::copy_nonoverlapping(alloc.get_host_ptr().cast::<u32>(), result.as_mut_ptr(), result.len()) };

        let mut reference = vec![0u32; comp_buffer_item_count as usize];
        for i in 0..max_sequence_count {
            let shader_idx = i.min(comp_shader_count - 1);
            for j in 0..comp_dispatch_x {
                for k in 0..COMP_WORK_GROUP_SIZE {
                    let wg_idx = comp_dispatch_x * i + j;
                    let idx = wg_idx * COMP_WORK_GROUP_SIZE + k;
                    reference[idx as usize] = shader_idx + 1;
                }
            }
        }
        for (i, (&res, &reference)) in result.iter().zip(reference.iter()).enumerate() {
            if res != reference {
                fail = true;
                log::error!("Unexpected value in buffer item {i}: expected {reference} but found {res}");
            }
        }

        // Verify the query.
        {
            let mut query_result_bytes = [0u8; 4];
            unsafe {
                device
                    .get_query_pool_results(
                        *query_pool,
                        0,
                        1,
                        &mut query_result_bytes,
                        4,
                        vk::QueryResultFlags::WAIT,
                    )
                    .vk_check("vkGetQueryPoolResults")?;
            }
            let query_result = u32::from_ne_bytes(query_result_bytes);
            let minimum = COMP_WORK_GROUP_COUNT * COMP_WORK_GROUP_SIZE;
            if query_result < minimum {
                fail = true;
                log::error!("Expected at least {minimum} compute shader invocations but found {query_result}");
            }
        }

        drop(preprocess_buffer);
        drop(ies_manager);

        if fail {
            return Ok(TestStatus::fail("Unexpected results; check log for details -- "));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The compute cases of `populateStatQueryTestGroup`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_stat_query_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let construction_cases = [
        (PipelineConstructionType::Monolithic, "monolithic"),
        (PipelineConstructionType::FastLinkedLibrary, "fast_lib"),
        (PipelineConstructionType::ShaderObjectUnlinkedSpirv, "shader_obj"),
    ];

    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (construction_type, construction_name) in construction_cases {
        for use_execution_set in [false, true] {
            for preprocess in [false, true] {
                let name = format!(
                    "comp_inv_{construction_name}{}{}",
                    if use_execution_set { "_ies" } else { "" },
                    if preprocess { "_preprocess" } else { "" },
                );
                cases.push((
                    format!("ext.stat_query.{name}"),
                    Box::new(StatQueryCase {
                        name,
                        params: TestParams {
                            construction_type,
                            use_execution_set,
                            preprocess,
                        },
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases
}

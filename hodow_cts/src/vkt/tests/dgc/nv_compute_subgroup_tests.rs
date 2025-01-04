// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeSubgroupTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are the ones of the EXT subgroup tests (`shaders/manifest/dgc_compute_subgroups.toml`,
// one per workgroup size and subgroup size).
//
// `dgc.nv.compute.subgroups.builtins` (VK_NV_device_generated_commands_compute): subgroup built-ins verified from a generated dispatch with a
// required subgroup size, with a normal or a DGC pipeline.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    InstanceV1_1, NvDeviceGeneratedCommandsComputeExtensionDeviceCommands,
    NvDeviceGeneratedCommandsExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_compute_subgroups::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::dgc::util_nv::{
    DgcComputePipeline, DgcComputePipelineMetaDataPool, GeneratedCommandsInfoNv, IndirectCommandsLayoutBuilderNv,
    PreprocessBufferNv, check_dgc_compute_support, create_compute_pipeline, make_indirect_commands_stream_nv,
    metadata_update_to_preprocess_barrier,
};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy)]
struct BuiltinParams {
    total_invocations: u32,
    subgroup_size: u32,
    pipeline_token: bool,
    compute_queue: bool,
}

struct SubgroupCase {
    name: String,
    key: String,
    params: BuiltinParams,
}

impl TestCase for SubgroupCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSubgroupSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;
        check_dgc_compute_support(context, params.pipeline_token, false)?;

        if context.api_version() < (1, 3, 0) {
            return Err(TestError::NotSupported("Vulkan 1.3 not supported".to_string()));
        }

        let mut vk13_properties = vk::PhysicalDeviceVulkan13Properties::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut vk13_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }

        debug_assert!(params.subgroup_size.is_power_of_two());

        if params.subgroup_size < vk13_properties.min_subgroup_size
            || params.subgroup_size > vk13_properties.max_subgroup_size
        {
            return Err(TestError::NotSupported("Unsupported subgroup size".to_string()));
        }

        if !vk13_properties
            .required_subgroup_size_stages
            .contains(vk::ShaderStageFlags::COMPUTE)
        {
            return Err(TestError::NotSupported(
                "Compute stage does not support a required subgroup size".to_string(),
            ));
        }

        if params.compute_queue && context.get_compute_queue().is_none() {
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
        Box::new(SubgroupInstance {
            context,
            params: self.params,
        })
    }
}

struct SubgroupInstance<'a> {
    context: &'a Context<'a>,
    params: BuiltinParams,
}

impl TestInstance for SubgroupInstance<'_> {
    /// `verifyBuiltins`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
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
        // This must match the shader.
        let output_buffer_count = 9usize;

        // Output buffers.
        let mut output_values = vec![0u32; params.total_invocations as usize];
        let output_buffer_size = std::mem::size_of_val(output_values.as_slice()) as vk::DeviceSize;
        let mut output_buffers = Vec::with_capacity(output_buffer_count);
        for _ in 0..output_buffer_count {
            output_buffers.push(create_host_buffer(
                context,
                &output_values,
                vk::BufferUsageFlags::STORAGE_BUFFER,
            )?);
        }

        // Descriptor set layout, pool and set preparation.
        let mut set_layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in &output_buffers {
            set_layout_builder = set_layout_builder.add_single_binding(desc_type, stage_flags);
        }
        let set_layout = set_layout_builder.build(device)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(desc_type, output_buffers.len() as u32)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let mut set_update_builder = DescriptorSetUpdateBuilder::new();
        for (i, buffer) in output_buffers.iter().enumerate() {
            let desc_info = make_descriptor_buffer_info(buffer.get(), 0, output_buffer_size);
            set_update_builder = set_update_builder.write_single(
                descriptor_set.get(),
                Location::binding(i as u32),
                desc_type,
                &desc_info,
            );
        }
        set_update_builder.update(device);

        // Pipeline layout.
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        // Shader.
        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        // Pipeline: either a normal compute pipeline or a DGC compute pipeline.
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
                params.subgroup_size,
            )?)
        } else {
            None
        };
        let normal_pipeline = if params.pipeline_token {
            None
        } else {
            Some(create_compute_pipeline(
                device,
                *pipeline_layout,
                *comp_module,
                params.subgroup_size,
            )?)
        };
        let normal_pipeline_handle = normal_pipeline
            .as_ref()
            .map_or(vk::Pipeline::null(), |pipeline| **pipeline);

        // Indirect commands layout. Note the dispatch token is last, but its offset in the sequence is 0.
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderNv::new(vk::IndirectCommandsLayoutUsageFlagsNV::empty(), bind_point);
        if params.pipeline_token {
            cmds_layout_builder.add_pipeline_token(0, 0);
        }
        let stream_range = cmds_layout_builder.get_stream_range(0);
        cmds_layout_builder.add_dispatch_token(0, stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Generated indirect commands buffer contents.
        let mut gen_cmds_data: Vec<u32> = Vec::with_capacity(5);
        if let Some(pipeline) = &dgc_pipeline {
            let address = pipeline.get_indirect_device_address();
            gen_cmds_data.push(address as u32);
            gen_cmds_data.push((address >> 32) as u32);
        }
        // Dispatch token data.
        gen_cmds_data.extend([1, 1, 1]);

        // Generated indirect commands buffer.
        let gen_cmds_buffer_size = std::mem::size_of_val(gen_cmds_data.as_slice()) as vk::DeviceSize;
        let gen_cmds_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(gen_cmds_buffer_size, vk::BufferUsageFlags::INDIRECT_BUFFER),
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

        // Preprocess buffer for 1 sequence. The pipeline is null when using a DGC pipeline, which is what we want.
        let preprocess_buffer =
            PreprocessBufferNv::new(context, bind_point, normal_pipeline_handle, cmds_layout.get(), 1)?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, qf_index)?;
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
        if let Some(pipeline) = &dgc_pipeline {
            unsafe { device.cmd_update_pipeline_indirect_buffer_nv(cmd_buffer, bind_point, pipeline.get()) };
            metadata_update_to_preprocess_barrier(device, cmd_buffer);
        } else {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, bind_point, normal_pipeline_handle) };
        }

        {
            let stream_info = make_indirect_commands_stream_nv(gen_cmds_buffer.get(), 0);
            let cmds_info = GeneratedCommandsInfoNv::new(
                bind_point,
                normal_pipeline_handle,
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

        // Verify results.
        let mut test_fail = false;
        for (i, output_buffer) in output_buffers.iter().enumerate() {
            let alloc = output_buffer.get_allocation();
            invalidate_alloc(device, alloc)?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    alloc.get_host_ptr().cast::<u32>(),
                    output_values.as_mut_ptr(),
                    output_values.len(),
                )
            };

            for (j, &result) in output_values.iter().enumerate() {
                let reference = 1u32;
                if result != reference {
                    test_fail = true;
                    log::error!(
                        "Unexpected value at binding {i} position {j}: expected {reference} but found {result}"
                    );
                }
            }
        }

        if test_fail {
            return Ok(TestStatus::fail(
                "Unexpected value found in output buffers; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCComputeSubgroupTests`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_subgroup_tests_nv() -> Vec<(String, Box<dyn TestCase>)> {
    let invocation_counts = [16u32, 32, 64, 128];

    let mut cases = Vec::new();
    for compute_queue in [false, true] {
        for dgc_pipeline in [false, true] {
            for workgroup_size in invocation_counts {
                for subgroup_size in invocation_counts {
                    if subgroup_size > workgroup_size {
                        break;
                    }

                    let test_name = format!(
                        "workgroup_size_{workgroup_size}_subgroup_size_{subgroup_size}{}{}",
                        if dgc_pipeline {
                            "_dgc_pipeline"
                        } else {
                            "_normal_pipeline"
                        },
                        if compute_queue { "_cq" } else { "" }
                    );
                    cases.push((
                        format!("nv.compute.subgroups.builtins.{test_name}"),
                        Box::new(SubgroupCase {
                            name: test_name,
                            key: format!("subgroups_w{workgroup_size}_s{subgroup_size}"),
                            params: BuiltinParams {
                                total_invocations: workgroup_size,
                                subgroup_size,
                                pipeline_token: dgc_pipeline,
                                compute_queue,
                            },
                        }) as Box<dyn TestCase>,
                    ));
                }
            }
        }
    }
    cases
}

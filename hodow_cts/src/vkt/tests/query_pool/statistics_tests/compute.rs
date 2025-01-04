// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolStatisticsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `QueryPoolComputeStatsTest` with its three instances: the primary command buffer
// (`ComputeInvocationsTestInstance`), the secondary one that holds the query (`ComputeInvocationsSecondaryTestInstance`) and the
// one whose query is begun in the primary and inherited by the secondary (`ComputeInvocationsSecondaryInheritedTestInstance`).
// Upstream runs the case on every queue of the device; the default device here has one universal queue, so the `_cq` cases run
// on the compute queue and the others on the universal one.

use vulkanalia::prelude::v1_0::*;

use super::common::*;
use super::{ALL_STATISTICS_PROGRAM, StatisticsProgram};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};
use crate::vkt::{Context, TestCase, TestInstance};

const COMPUTE_STATISTIC: vk::QueryPipelineStatisticFlags = vk::QueryPipelineStatisticFlags::COMPUTE_SHADER_INVOCATIONS;

/// `ComputeInvocationsTestInstance::ParametersCompute` without the generic part.
#[derive(Clone, Copy)]
struct ParametersCompute {
    local_size: [u32; 3],
    group_size: [u32; 3],
    shader_name: &'static str,
}

impl ParametersCompute {
    /// `getComputeExecution`
    fn compute_execution(&self) -> u32 {
        self.local_size.iter().product::<u32>() * self.group_size.iter().product::<u32>()
    }
}

/// `QueryPoolComputeStatsTest<Instance>`
pub(super) struct ComputeStatsCase {
    name: String,
    kind: CommandBufferType,
    generic: GenericParameters,
    use_compute_queue: bool,
    parameters: Vec<ParametersCompute>,
}

impl ComputeStatsCase {
    #[allow(clippy::too_many_arguments)]
    pub(super) fn new(
        name: String,
        kind: CommandBufferType,
        reset_type: ResetType,
        copy_type: CopyType,
        query_64_bits: bool,
        use_compute_queue: bool,
        dst_offset: bool,
        stride_type: StrideType,
        use_device_address_commands: bool,
    ) -> Self {
        let local_size = [[2, 2, 2], [1, 1, 1], [WIDTH / (7 * 3), 7, 3]];
        let group_size = [[2, 2, 2], [WIDTH / (7 * 3), 7, 3], [1, 1, 1]];
        let shader_names = ["compute_0", "compute_1", "compute_2"];

        let parameters = (0..local_size.len())
            .map(|ndx| ParametersCompute {
                local_size: local_size[ndx],
                group_size: group_size[ndx],
                shader_name: shader_names[ndx],
            })
            .collect();

        Self {
            name,
            kind,
            generic: GenericParameters {
                reset_type,
                copy_type,
                query_64_bits,
                dst_offset,
                stride_type,
                use_device_address_commands,
            },
            use_compute_queue,
            parameters,
        }
    }
}

impl TestCase for ComputeStatsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context, self.generic.reset_type == ResetType::Host)?;

        if self.kind == CommandBufferType::SecondaryInherited
            && context.get_device_features().inherited_queries == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Inherited queries are not supported".to_string(),
            ));
        }

        if self.use_compute_queue && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported(
                "The device has no compute-only queue".to_string(),
            ));
        }

        if self.generic.use_device_address_commands {
            context.require_device_functionality("VK_KHR_device_address_commands")?;
            return Err(TestError::NotPorted(
                "vkCmdCopyQueryPoolResultsToMemoryKHR is not bound by vulkanalia".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program: &'static StatisticsProgram = ALL_STATISTICS_PROGRAM
            .iter()
            .copied()
            .find(|p| p.key == "compute")
            .expect("the manifest has the compute shaders");
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ComputeInstance { context, case: self })
    }
}

/// What every executor shares: the storage buffer the shaders write, its descriptor set and the layout.
struct ComputeResources<'a> {
    buffer: BufferWithMemory<'a>,
    buffer_size: vk::DeviceSize,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    descriptor_set: UniqueDescriptorSet<'a>,
    _descriptor_set_layout: Unique<'a, vk::DescriptorSetLayout>,
    _descriptor_pool: Unique<'a, vk::DescriptorPool>,
}

struct ComputeInstance<'a> {
    context: &'a Context<'a>,
    case: &'a ComputeStatsCase,
}

/// `clearBuffer`
fn clear_buffer(device: &Device, buffer: &BufferWithMemory<'_>, size: vk::DeviceSize) -> Result<(), TestError> {
    let allocation = buffer.get_allocation();
    invalidate_alloc(device, allocation)?;
    unsafe { std::ptr::write_bytes(allocation.get_host_ptr(), 0, size as usize) };
    flush_alloc(device, allocation)
}

fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0");
    let info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(layout);
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn compute_buffer_barrier(
    buffer: vk::Buffer,
    size: vk::DeviceSize,
    dst_access_mask: vk::AccessFlags,
) -> vk::BufferMemoryBarrier {
    make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
        dst_access_mask,
        buffer,
        0,
        size,
    )
}

fn cmd_buffer_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    src: vk::PipelineStageFlags,
    dst: vk::PipelineStageFlags,
    barrier: vk::BufferMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src,
            dst,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

impl ComputeInstance<'_> {
    fn reader<'b>(&'b self, query_pool: vk::QueryPool, reset_buffer: &'b BufferWithMemory<'b>) -> ResultReader<'b> {
        ResultReader {
            context: self.context,
            query_pool,
            query_count: 1,
            params: self.case.generic,
            reset_buffer,
        }
    }

    /// The result checks the three executors share, against the number of invocations `expected` the query has to have counted.
    fn check_query(&self, reader: &ResultReader<'_>, expected: u64) -> Result<Option<TestStatus>, TestError> {
        let generic = &self.case.generic;
        let device = self.context.get_device();

        match generic.reset_type {
            ResetType::Normal | ResetType::AfterCopy => {
                let data = reader.read_values()?;
                if expected != data[0] {
                    return Ok(Some(TestStatus::fail("QueryPoolResults incorrect")));
                }
            }
            ResetType::Host => {
                let mut data = reader.read_values_with_availability()?;
                if expected != data[0].0 || data[0].1 == 0 {
                    return Ok(Some(TestStatus::fail("QueryPoolResults incorrect")));
                }
                if !reader.check_reset_again(&mut data)? {
                    return Ok(Some(TestStatus::fail("QueryPoolResults incorrect reset")));
                }
            }
            ResetType::BeforeCopy => {
                // With RESET_TYPE_BEFORE_COPY, we only need to verify the result after the copy include an availability bit set as zero.
                let status = verify_unavailable(device, reader.reset_buffer, generic.dst_offset)?;
                if status.is_fail() {
                    return Ok(Some(status));
                }
            }
        }

        Ok(None)
    }

    /// `ComputeInvocationsTestInstance::executeTest`
    fn execute_primary(
        &self,
        queue: vk::Queue,
        cmd_pool: vk::CommandPool,
        resources: &ComputeResources<'_>,
        reset_buffer: &BufferWithMemory<'_>,
    ) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let generic = &self.case.generic;
        let binaries = context.get_binary_collection();

        for parameters in &self.case.parameters {
            clear_buffer(device, &resources.buffer, resources.buffer_size)?;
            let module = create_shader_module(device, binaries.get(parameters.shader_name)?)?;
            let pipeline = create_compute_pipeline(device, *resources.pipeline_layout, *module)?;

            let cmd_buffer = allocate_command_buffer(device, cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let query_pool = Unique::new(device, make_query_pool(device, 1, COMPUTE_STATISTIC)?);

            begin_command_buffer(device, *cmd_buffer)?;
            unsafe {
                if generic.reset_type != ResetType::Host {
                    device.cmd_reset_query_pool(*cmd_buffer, *query_pool, 0, 1);
                }

                device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
                device.cmd_bind_descriptor_sets(
                    *cmd_buffer,
                    vk::PipelineBindPoint::COMPUTE,
                    *resources.pipeline_layout,
                    0,
                    &[*resources.descriptor_set],
                    &[],
                );

                device.cmd_begin_query(*cmd_buffer, *query_pool, 0, vk::QueryControlFlags::empty());
                device.cmd_dispatch(
                    *cmd_buffer,
                    parameters.group_size[0],
                    parameters.group_size[1],
                    parameters.group_size[2],
                );
                device.cmd_end_query(*cmd_buffer, *query_pool, 0);
            }

            record_query_copy(device, *cmd_buffer, *query_pool, 1, generic, reset_buffer.get());
            cmd_buffer_barrier(
                device,
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                compute_buffer_barrier(
                    resources.buffer.get(),
                    resources.buffer_size,
                    vk::AccessFlags::HOST_READ,
                ),
            );
            end_command_buffer(device, *cmd_buffer)?;

            log::info!("Compute shader invocations: {}", parameters.compute_execution());

            if generic.reset_type == ResetType::Host {
                host_reset_query_pool(context, *query_pool, 0, 1);
            }

            // Wait for completion
            submit_commands_and_wait(device, queue, *cmd_buffer)?;

            // Validate the results
            invalidate_alloc(device, resources.buffer.get_allocation())?;

            let reader = self.reader(*query_pool, reset_buffer);
            if let Some(status) = self.check_query(&reader, u64::from(parameters.compute_execution()))? {
                return Ok(status);
            }

            let buffer_ptr = resources.buffer.get_allocation().get_host_ptr().cast::<u32>();
            for ndx in 0..parameters.compute_execution() {
                if unsafe { buffer_ptr.add(ndx as usize).read() } != ndx {
                    return Ok(TestStatus::fail("Compute shader didn't write data to the buffer"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// The pipelines of every parameter set, built up front: the secondary executors record all of them into one buffer.
    fn create_all_pipelines<'a>(
        &'a self,
        resources: &ComputeResources<'_>,
    ) -> Result<(Vec<Unique<'a, vk::ShaderModule>>, Vec<Unique<'a, vk::Pipeline>>), TestError> {
        let device = self.context.get_device();
        let binaries = self.context.get_binary_collection();
        let mut modules = Vec::new();
        let mut pipelines = Vec::new();

        for parameters in &self.case.parameters {
            let module = create_shader_module(device, binaries.get(parameters.shader_name)?)?;
            pipelines.push(create_compute_pipeline(device, *resources.pipeline_layout, *module)?);
            modules.push(module);
        }

        Ok((modules, pipelines))
    }

    /// `ComputeInvocationsSecondaryTestInstance::executeTest` and `ComputeInvocationsSecondaryInheritedTestInstance::executeTest`:
    /// the first records the query and every dispatch into the secondary command buffer; the second begins the query in the
    /// primary, dispatches the first parameter set there and leaves the others to the secondary.
    fn execute_secondary(
        &self,
        inherited: bool,
        queue: vk::Queue,
        cmd_pool: vk::CommandPool,
        resources: &ComputeResources<'_>,
        reset_buffer: &BufferWithMemory<'_>,
    ) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let generic = &self.case.generic;
        let parameters = &self.case.parameters;

        let (_modules, pipelines) = self.create_all_pipelines(resources)?;

        let primary = allocate_command_buffer(device, cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let secondary: UniqueCommandBuffer<'_> =
            allocate_command_buffer(device, cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let query_pool = Unique::new(device, make_query_pool(device, 1, COMPUTE_STATISTIC)?);

        let shader_write_barrier = compute_buffer_barrier(
            resources.buffer.get(),
            resources.buffer_size,
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
        );
        let finish_barrier = compute_buffer_barrier(
            resources.buffer.get(),
            resources.buffer_size,
            vk::AccessFlags::HOST_READ,
        );

        clear_buffer(device, &resources.buffer, resources.buffer_size)?;
        begin_secondary_command_buffer(
            device,
            *secondary,
            COMPUTE_STATISTIC,
            vk::RenderPass::null(),
            vk::Framebuffer::null(),
            vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT,
        )?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                *secondary,
                vk::PipelineBindPoint::COMPUTE,
                *resources.pipeline_layout,
                0,
                &[*resources.descriptor_set],
                &[],
            );

            if !inherited {
                if generic.reset_type != ResetType::Host {
                    device.cmd_reset_query_pool(*secondary, *query_pool, 0, 1);
                }
                device.cmd_begin_query(*secondary, *query_pool, 0, vk::QueryControlFlags::empty());
            }

            let first = if inherited { 1 } else { 0 };
            for ndx in first..parameters.len() {
                device.cmd_bind_pipeline(*secondary, vk::PipelineBindPoint::COMPUTE, *pipelines[ndx]);
                device.cmd_dispatch(
                    *secondary,
                    parameters[ndx].group_size[0],
                    parameters[ndx].group_size[1],
                    parameters[ndx].group_size[2],
                );
                cmd_buffer_barrier(
                    device,
                    *secondary,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    shader_write_barrier,
                );
            }

            if !inherited {
                device.cmd_end_query(*secondary, *query_pool, 0);
            }
        }
        if !inherited {
            record_query_copy(device, *secondary, *query_pool, 1, generic, reset_buffer.get());
        }
        end_command_buffer(device, *secondary)?;

        begin_command_buffer(device, *primary)?;
        unsafe {
            if inherited {
                if generic.reset_type != ResetType::Host {
                    device.cmd_reset_query_pool(*primary, *query_pool, 0, 1);
                }
                device.cmd_bind_descriptor_sets(
                    *primary,
                    vk::PipelineBindPoint::COMPUTE,
                    *resources.pipeline_layout,
                    0,
                    &[*resources.descriptor_set],
                    &[],
                );
                device.cmd_bind_pipeline(*primary, vk::PipelineBindPoint::COMPUTE, *pipelines[0]);

                device.cmd_begin_query(*primary, *query_pool, 0, vk::QueryControlFlags::empty());
                device.cmd_dispatch(
                    *primary,
                    parameters[0].group_size[0],
                    parameters[0].group_size[1],
                    parameters[0].group_size[2],
                );
                cmd_buffer_barrier(
                    device,
                    *primary,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    shader_write_barrier,
                );
            }

            device.cmd_execute_commands(*primary, &[*secondary]);
            cmd_buffer_barrier(
                device,
                *primary,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                finish_barrier,
            );

            if inherited {
                device.cmd_end_query(*primary, *query_pool, 0);
            }
        }
        if inherited {
            record_query_copy(device, *primary, *query_pool, 1, generic, reset_buffer.get());
        }
        end_command_buffer(device, *primary)?;

        // Secondary buffer is emitted only once, so it is safe to reset the query pool here.
        if generic.reset_type == ResetType::Host {
            host_reset_query_pool(context, *query_pool, 0, 1);
        }

        // Wait for completion
        submit_commands_and_wait(device, queue, *primary)?;
        self.check_secondary_result(resources, &self.reader(*query_pool, reset_buffer))
    }

    /// `ComputeInvocationsSecondaryTestInstance::checkResult`
    fn check_secondary_result(&self, resources: &ComputeResources<'_>, reader: &ResultReader<'_>) -> TestOutcome {
        let device = self.context.get_device();
        let parameters = &self.case.parameters;

        let expected: u64 = parameters.iter().map(|p| u64::from(p.compute_execution())).sum();
        if let Some(status) = self.check_query(reader, expected)? {
            return Ok(status);
        }

        // Validate the results
        invalidate_alloc(device, resources.buffer.get_allocation())?;
        let buffer_ptr = resources.buffer.get_allocation().get_host_ptr().cast::<u32>();
        let min_size = parameters.iter().map(|p| p.compute_execution()).min().unwrap_or(0);
        for ndx in 0..min_size {
            if unsafe { buffer_ptr.add(ndx as usize).read() } != ndx * parameters.len() as u32 {
                return Ok(TestStatus::fail("Compute shader didn't write data to the buffer"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for ComputeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let generic = &self.case.generic;

        let max_size = self
            .case
            .parameters
            .iter()
            .map(ParametersCompute::compute_execution)
            .max()
            .unwrap_or(0);
        let atom_size = context.get_device_properties().limits.non_coherent_atom_size.max(1);
        let buffer_size = (vk::DeviceSize::from(max_size) * 4).div_ceil(atom_size) * atom_size;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &make_descriptor_buffer_info(buffer.get(), 0, buffer_size),
            )
            .update(device);

        let resources = ComputeResources {
            buffer,
            buffer_size,
            pipeline_layout,
            descriptor_set,
            _descriptor_set_layout: descriptor_set_layout,
            _descriptor_pool: descriptor_pool,
        };

        let (queue, queue_family_index) = if self.case.use_compute_queue {
            context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("The device has no compute-only queue".to_string()))?
        } else {
            (
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )
        };

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let reset_buffer = create_reset_buffer(context, 1, generic.dst_offset)?;

        match self.case.kind {
            CommandBufferType::Primary => self.execute_primary(queue, *cmd_pool, &resources, &reset_buffer),
            CommandBufferType::Secondary => self.execute_secondary(false, queue, *cmd_pool, &resources, &reset_buffer),
            CommandBufferType::SecondaryInherited => {
                self.execute_secondary(true, queue, *cmd_pool, &resources, &reset_buffer)
            }
        }
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsMultipleDispatchesUniformSubgroupSizeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader is in `shaders/manifest/subgroups_multiple_dispatches.toml`.

use vulkanalia::prelude::v1_0::*;

use super::utils::{subgroup_size_control_features, subgroup_size_control_properties};
use crate::generated::shaders::subgroups_multiple_dispatches::ALL_MULTIPLE_DISPATCHES_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries: `MultipleDispatchesUniformSubgroupSize`.
#[derive(Clone, Copy)]
pub struct MultipleDispatchesCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for MultipleDispatchesCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `MultipleDispatchesUniformSubgroupSize::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if subgroup_size_control_features(context).subgroup_size_control == vk::FALSE {
            return Err(TestError::NotSupported(
                "Device does not support varying subgroup sizes".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultipleDispatchesInstance { context })
    }
}

struct MultipleDispatchesInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MultipleDispatchesInstance<'_> {
    /// `MultipleDispatchesUniformSubgroupSizeInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let compute_shader = create_shader_module(device, context.get_binary_collection().get("comp")?)?;

        // The maximum number of invocations in a workgroup.
        let max_local_size = context.get_device_properties().limits.max_compute_work_group_size[0];
        let min_subgroup_size = subgroup_size_control_properties(context).min_subgroup_size;

        // A storage buffer to hold the sizes of subgroups.
        let buffer_size = (max_local_size / min_subgroup_size + 1) as vk::DeviceSize * 4;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                buffer_size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // descriptors for the storage buffer
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let result_info = make_descriptor_buffer_info(result_buffer.get(), 0, buffer_size);
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_info,
            )
            .update(device);

        // compute pipelines
        let set_layouts = [*descriptor_set_layout];
        let compute_pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

        let mut local_sizes = Vec::new();
        let mut pipeline_variants: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
        let mut local_size = 1u32;
        while local_size <= max_local_size {
            let entries = [vk::SpecializationMapEntry {
                constant_id: 0,
                offset: 0,
                size: std::mem::size_of::<u32>(),
            }];
            let data = local_size.to_ne_bytes();
            let spec_info = vk::SpecializationInfo::builder().map_entries(&entries).data(&data);
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .flags(vk::PipelineShaderStageCreateFlags::ALLOW_VARYING_SUBGROUP_SIZE)
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*compute_shader)
                .name(b"main\0")
                .specialization_info(&spec_info)
                .build();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*compute_pipeline_layout)
                .base_pipeline_index(0)
                .build();
            let pipeline = Unique::new(
                device,
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?
                    .0[0],
            );
            local_sizes.push(local_size);
            pipeline_variants.push(pipeline);
            local_size *= 2;
        }

        let mut local_size = 1u32;
        while local_size <= max_local_size {
            begin_command_buffer(device, cmd)?;

            // clears the values in the buffer
            unsafe { device.cmd_fill_buffer(cmd, result_buffer.get(), 0, vk::WHOLE_SIZE, 0) };

            let fill_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                result_buffer.get(),
                0,
                buffer_size,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[fill_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );

                // runs the pipeline
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *compute_pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
            }

            if let Some(i) = local_sizes.iter().position(|&size| size == local_size) {
                unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline_variants[i]) };
            }

            unsafe { device.cmd_dispatch(cmd, 1, 1, 1) };

            let compute_to_host_barrier =
                make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[compute_to_host_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;

            invalidate_alloc(device, result_buffer.get_allocation())?;

            // Validate results: all non-zero subgroup sizes must be the same.
            let max_iters = (buffer_size / 4) as usize;
            let res = unsafe {
                std::slice::from_raw_parts(
                    result_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                    max_iters,
                )
            };
            let mut size = 0u32;
            let mut subgroup_count = 0u32;

            for (size_idx, &value) in res.iter().enumerate() {
                if value != 0 {
                    if size == 0 {
                        size = value;
                    } else if value != size {
                        return Ok(TestStatus::fail(format!(
                            "Subgroup size not uniform in command scope: {value} != {size} at position {size_idx}"
                        )));
                    }
                    subgroup_count += 1;
                }
            }

            // Subgroup size is guaranteed to be at least 1.
            if size == 0 {
                return Ok(TestStatus::fail("Subgroup size must be at least 1"));
            }

            // The number of reported sizes must match.
            let expected_subgroup_count = local_size / size + u32::from(local_size % size != 0);
            if subgroup_count != expected_subgroup_count {
                return Ok(TestStatus::fail(format!(
                    "Local size {local_size} with subgroup size {size} resulted in subgroup count {subgroup_count} != {expected_subgroup_count}"
                )));
            }

            log::info!("Subgroup size {size} with local size {local_size}");
            local_size *= 2;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMultipleDispatchesUniformSubgroupSizeTests`
pub fn create_multiple_dispatches_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multiple_dispatches");
    for case in ALL_MULTIPLE_DISPATCHES_CASE.iter() {
        group.add_child(Box::new(**case) as Box<dyn TestCase>);
    }
    group
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/subgroup_uniform_control_flow/{large,large_control,small,small_control}/*.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What an Amber compute script does for these is done directly: the uint32 storage buffers of the script (filled with a
// value or with a series), the `fill` pipeline and then the `test` pipeline, each dispatched once, with a barrier between them, and the two expectations of the scripts:
// the first four words of `compare` and `b == compare`. `FULLY_POPULATED on` is the require-full-subgroups stage flag. The scripts are read by
// `scripts/gen_subgroup_uniform_control_flow_amber.py`, which writes the shaders and `uniform_control_flow_cases.rs`; the graphics script of the `discard` group is not ported.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::uniform_control_flow_cases::UNIFORM_CONTROL_FLOW_CASES;
use crate::generated::shaders::subgroups_uniform_control_flow::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `BUFFER name DATA_TYPE uint32 SIZE count FILL from` (step 0) or `SERIES_FROM from INC_BY step`
pub struct BufferSpec {
    pub name: &'static str,
    pub count: u32,
    pub from: u32,
    pub step: u32,
}

/// `PIPELINE compute`: the program of the case, `SUBGROUP .. FULLY_POPULATED on` and the buffer of each storage buffer binding
pub struct PipelineSpec {
    pub program: &'static str,
    pub fully_populated: bool,
    pub bindings: &'static [&'static str],
}

/// One Amber script of `subgroups.subgroup_uniform_control_flow`
pub struct UniformControlFlowCase {
    pub group: &'static str,
    pub name: &'static str,
    pub key: &'static str,
    /// The script asks for `SubgroupSizeControl.subgroupSizeControl` and `computeFullSubgroups`
    pub size_control: bool,
    pub buffers: &'static [BufferSpec],
    pub pipelines: &'static [PipelineSpec],
    /// `EXPECT compare IDX 0 EQ a b c d`
    pub expected_compare: [u32; 4],
}

struct UniformControlFlowTestCase {
    data: &'static UniformControlFlowCase,
}

impl TestCase for UniformControlFlowTestCase {
    fn name(&self) -> &str {
        self.data.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_shader_subgroup_uniform_control_flow")?;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut uniform_control_flow = vk::PhysicalDeviceShaderSubgroupUniformControlFlowFeaturesKHR::default();
        let mut size_control = vk::PhysicalDeviceSubgroupSizeControlFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder()
            .push_next(&mut uniform_control_flow)
            .push_next(&mut size_control);
        unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
        if uniform_control_flow.shader_subgroup_uniform_control_flow == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderSubgroupUniformControlFlow not supported".to_string(),
            ));
        }
        if self.data.size_control
            && (size_control.subgroup_size_control == vk::FALSE || size_control.compute_full_subgroups == vk::FALSE)
        {
            return Err(TestError::NotSupported(
                "subgroupSizeControl and computeFullSubgroups are required".to_string(),
            ));
        }

        let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
        let required = vk::SubgroupFeatureFlags::BASIC | vk::SubgroupFeatureFlags::BALLOT;
        if !subgroup_properties
            .supported_stages
            .contains(vk::ShaderStageFlags::COMPUTE)
            || !subgroup_properties.supported_operations.contains(required)
        {
            return Err(TestError::NotSupported(
                "compute subgroup basic and ballot operations are required".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.data.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UniformControlFlowInstance {
            context,
            data: self.data,
        })
    }
}

struct UniformControlFlowInstance<'a> {
    context: &'a Context<'a>,
    data: &'static UniformControlFlowCase,
}

fn read_words(buffer: &BufferWithMemory<'_>, count: usize) -> Vec<u32> {
    unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(), count) }
        .to_vec()
}

impl TestInstance for UniformControlFlowInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let data = self.data;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        let mut buffers = Vec::new();
        for spec in data.buffers {
            let words: Vec<u32> = (0..spec.count).map(|ndx| spec.from + ndx * spec.step).collect();
            let size = u64::from(spec.count) * 4;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    words.as_ptr().cast::<u8>(),
                    buffer.get_allocation().get_host_ptr(),
                    words.len() * 4,
                )
            };
            flush_alloc(device, buffer.get_allocation())?;
            buffers.push((spec.name, spec.count as usize, buffer));
        }
        let buffer_of = |name: &str| {
            buffers
                .iter()
                .find(|(buffer_name, _, _)| *buffer_name == name)
                .map(|(_, _, buffer)| buffer)
                .expect("a buffer of the script")
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let binaries = context.get_binary_collection();

        // Everything a pipeline needs stays alive until the submission has finished.
        let mut resources = Vec::new();
        begin_command_buffer(device, cmd)?;
        for pipeline_spec in data.pipelines {
            let mut layout_builder = DescriptorSetLayoutBuilder::new();
            for binding in 0..pipeline_spec.bindings.len() {
                layout_builder = layout_builder.add_indexed_binding(
                    vk::DescriptorType::STORAGE_BUFFER,
                    vk::ShaderStageFlags::COMPUTE,
                    binding as u32,
                    1,
                );
            }
            let descriptor_set_layout = layout_builder.build(device)?;
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, pipeline_spec.bindings.len() as u32)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
            let infos: Vec<vk::DescriptorBufferInfo> = pipeline_spec
                .bindings
                .iter()
                .map(|name| vk::DescriptorBufferInfo {
                    buffer: buffer_of(name).get(),
                    offset: 0,
                    range: vk::WHOLE_SIZE,
                })
                .collect();
            let mut update = DescriptorSetUpdateBuilder::new();
            for (binding, info) in infos.iter().enumerate() {
                update = update.write_single(
                    descriptor_set.get(),
                    Location::binding(binding as u32),
                    vk::DescriptorType::STORAGE_BUFFER,
                    info,
                );
            }
            update.update(device);

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let program = binaries.get(pipeline_spec.program)?;
            let shader_module = create_shader_module(device, program)?;
            let flags = if pipeline_spec.fully_populated {
                vk::PipelineShaderStageCreateFlags::REQUIRE_FULL_SUBGROUPS
            } else {
                vk::PipelineShaderStageCreateFlags::empty()
            };
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .flags(flags)
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*shader_module)
                .name(b"main\0")
                .build();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0)
                .build();
            let pipeline = Unique::new(
                device,
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?
                    .0[0],
            );

            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd, 1, 1, 1);
                let barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(
                        vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::HOST_READ,
                    )
                    .build();
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::COMPUTE_SHADER | vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            resources.push((
                pipeline,
                shader_module,
                pipeline_layout,
                descriptor_set,
                descriptor_pool,
                descriptor_set_layout,
            ));
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
        drop(resources);

        for (_, _, buffer) in &buffers {
            invalidate_alloc(device, buffer.get_allocation())?;
        }
        let compare = read_words(
            buffer_of("compare"),
            data.buffers
                .iter()
                .find(|spec| spec.name == "compare")
                .map_or(0, |spec| spec.count as usize),
        );
        let b = read_words(
            buffer_of("b"),
            data.buffers
                .iter()
                .find(|spec| spec.name == "b")
                .map_or(0, |spec| spec.count as usize),
        );

        // EXPECT compare IDX 0 EQ a b c d
        if compare[..4] != data.expected_compare {
            log::error!(
                "compare[0..4] is {:?}, expected {:?}",
                &compare[..4],
                data.expected_compare
            );
            return Ok(TestStatus::fail("Unexpected values in the compare buffer"));
        }
        // EXPECT b EQ_BUFFER compare
        if b != compare {
            if let Some(ndx) = b.iter().zip(&compare).position(|(left, right)| left != right) {
                log::error!("b[{ndx}] is {}, compare[{ndx}] is {}", b[ndx], compare[ndx]);
            }
            return Ok(TestStatus::fail("The buffers b and compare differ"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `dEQP-VK.subgroups.subgroup_uniform_control_flow`
pub fn create_uniform_control_flow_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("subgroup_uniform_control_flow");
    for group_name in ["large_full", "large_full_control", "small_full", "small_full_control"] {
        let mut sub_group = TestCaseGroup::new(group_name);
        for data in UNIFORM_CONTROL_FLOW_CASES
            .iter()
            .filter(|data| data.group == group_name)
        {
            sub_group.add_child(Box::new(UniformControlFlowTestCase { data }) as Box<dyn TestCase>);
        }
        group.add_child(sub_group);
    }
    group
}

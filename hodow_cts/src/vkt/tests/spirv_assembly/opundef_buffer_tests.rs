// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmOpUndefTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the 16 cases is in `shaders/manifest/spirv_assembly_opundef_buffer.toml`
// (written by `scripts/gen_spirv_assembly_opundef_manifest.py`); upstream's `Params` are read back from the case name, which carries the
// descriptor type (`storage`, `uniform`, `storage_dynamic`, `uniform_dynamic`), `_array` and `livecode`. The case passes when the dispatch
// completes: nothing is read back, the shader only has to be accepted and to run.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::spirv_assembly_opundef_buffer::ALL_OP_UNDEF_BUFFER_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one `OpUndefBufferComputeTestCase`.
#[derive(Clone, Copy)]
pub struct OpUndefBufferCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `Params::type`, from the middle of the case name.
fn descriptor_type(name: &str) -> vk::DescriptorType {
    match (name.contains("_storage"), name.contains("_dynamic")) {
        (true, false) => vk::DescriptorType::STORAGE_BUFFER,
        (false, false) => vk::DescriptorType::UNIFORM_BUFFER,
        (true, true) => vk::DescriptorType::STORAGE_BUFFER_DYNAMIC,
        (false, true) => vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC,
    }
}

impl TestCase for OpUndefBufferCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OpUndefBufferInstance {
            context,
            descriptor_type: descriptor_type(self.name),
        })
    }
}

struct OpUndefBufferInstance<'a> {
    context: &'a Context<'a>,
    descriptor_type: vk::DescriptorType,
}

impl TestInstance for OpUndefBufferInstance<'_> {
    /// `OpUndefBufferComputeTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let di = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let is_uniform = matches!(
            self.descriptor_type,
            vk::DescriptorType::UNIFORM_BUFFER | vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC
        );
        let is_dynamic = matches!(
            self.descriptor_type,
            vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC | vk::DescriptorType::STORAGE_BUFFER_DYNAMIC
        );

        const BUFFER_SIZE: vk::DeviceSize = 16;
        let usage = if is_uniform {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };
        let buffer = BufferWithMemory::new(
            di,
            allocator,
            make_buffer_create_info(BUFFER_SIZE, usage),
            MemoryRequirement::LOCAL,
        )?;

        let ds_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(self.descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .build(di)?;

        let mut pipeline = ComputePipelineWrapper::new(
            di,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("opundef")?,
        );
        pipeline.set_descriptor_set_layout(*ds_layout);
        pipeline.build_pipeline()?;

        let ds_pool = DescriptorPoolBuilder::new().add_type(self.descriptor_type, 1).build(
            di,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(di, *ds_pool, *ds_layout)?;

        let descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, BUFFER_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                self.descriptor_type,
                &descriptor_info,
            )
            .update(di);

        let cmd_pool = make_command_pool(di, queue_family_index)?;
        let cmd = allocate_command_buffer(di, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let dynamic_offsets: &[u32] = if is_dynamic { &[0] } else { &[] };

        begin_command_buffer(di, *cmd)?;
        pipeline.bind(*cmd);
        unsafe {
            di.cmd_bind_descriptor_sets(
                *cmd,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[*descriptor_set],
                dynamic_offsets,
            );
            di.cmd_dispatch(*cmd, 1, 1, 1);
        }
        end_command_buffer(di, *cmd)?;
        submit_commands_and_wait(di, queue, *cmd)?;

        Ok(TestStatus::pass(""))
    }
}

/// `appendOpUndefTests`, the buffer cases of the `opundef` group.
pub fn create_opundef_buffer_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_OP_UNDEF_BUFFER_CASE
        .iter()
        .map(|case| (vec!["opundef"], Box::new(**case) as Box<dyn TestCase>))
        .collect()
}

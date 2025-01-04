// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ssbo/vktSSBOCornerCase.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The 589 line shader (`useCornerCaseShader`) is in `shaders/manifest/ssbo_corner_case.toml`, written by
// `scripts/gen_ssbo_corner_case_manifest.py` from `de::Random(1)`. The case passes when the dispatch does not crash.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::generated::shaders::ssbo_corner_case::LONG_SHADER_BITWISE_AND;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorPoolBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

const TEST_SIZE: u64 = 589;
const AC_BUFFER_SIZE: u64 = 4;

/// `CornerCase`
pub struct CornerCase;

impl TestCase for CornerCase {
    fn name(&self) -> &str {
        "long_shader_bitwise_and"
    }

    /// `CornerCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let mut bda = vk::PhysicalDeviceBufferDeviceAddressFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut bda);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if bda.buffer_device_address == vk::FALSE {
            return Err(TestError::NotSupported(
                "Physical storage buffer pointers not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        LONG_SHADER_BITWISE_AND.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CornerCaseInstance { context })
    }
}

struct CornerCaseInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for CornerCaseInstance<'_> {
    /// `SSBOCornerCaseInstance::queuePass`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let (queue, queue_family_index) = context.get_compute_queue().unwrap_or((
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        ));

        let ac_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(AC_BUFFER_SIZE, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(ac_buffer.get_allocation().get_host_ptr(), 0, AC_BUFFER_SIZE as usize) };
        flush_alloc(device, ac_buffer.get_allocation())?;

        let binding = [vk::DescriptorSetLayoutBinding {
            binding: 0,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            descriptor_count: 1,
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            immutable_samplers: std::ptr::null(),
        }];
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&binding);
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let ac_info = make_descriptor_buffer_info(ac_buffer.get(), 0, AC_BUFFER_SIZE);
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(std::slice::from_ref(&ac_info))
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let buffer_size = 64 * TEST_SIZE;
        let requirement = if context.is_device_functionality_supported("VK_KHR_buffer_device_address") {
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS
        } else {
            MemoryRequirement::HOST_VISIBLE
        };
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                buffer_size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
            ),
            requirement,
        )?;
        let address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
        let address = unsafe { device.get_buffer_device_address(&address_info) };

        let set_layouts = [*descriptor_set_layout];
        let push_range = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: std::mem::size_of::<vk::DeviceAddress>() as u32,
        }];
        let layout_create_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_range);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_create_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let compute_module = create_shader_module(device, binaries.get("compute")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_module)
            .name(b"main\0");
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_push_constants(
                cmd,
                *pipeline_layout,
                vk::ShaderStageFlags::COMPUTE,
                0,
                &address.to_le_bytes(),
            );
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        Ok(TestStatus::pass("Test did not cause a crash"))
    }
}

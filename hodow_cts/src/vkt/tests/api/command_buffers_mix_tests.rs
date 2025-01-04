// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCommandBuffersTests.cpp (`PipelineShaderObjMixSecondaries*`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader is in shaders/manifest/api_command_buffers.toml.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtShaderObjectExtensionDeviceCommands;

use crate::generated::shaders::api_command_buffers::MIX_SECONDARIES;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::shader_object::util::{create_shader, shader_create_info};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct MixSecondariesCase;

impl TestCase for MixSecondariesCase {
    fn name(&self) -> &str {
        "pipeline_shader_object_mix_with_secondaries"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")
    }

    fn programs(&self) -> BinaryCollection {
        MIX_SECONDARIES.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MixSecondariesInstance { context })
    }
}

struct MixSecondariesInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MixSecondariesInstance<'_> {
    /// `PipelineShaderObjMixSecondariesRun`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let shader_stage = vk::ShaderStageFlags::COMPUTE;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, shader_stage)
            .build(device)?;
        let pc_size = std::mem::size_of::<u32>() as u32;
        let pc_range = vk::PushConstantRange {
            stage_flags: shader_stage,
            offset: 0,
            size: pc_size,
        };
        let set_layouts = [*set_layout];
        let pc_ranges = [pc_range];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let comp_binary = context.get_binary_collection().get("comp")?;

        // One specialization for the shader object and another one for the pipeline: the pipeline stores 1s, the shader object 2s.
        let (k_one, k_two) = (1u32, 2u32);
        let specialization_map_entry = vk::SpecializationMapEntry {
            constant_id: 0,
            offset: 0,
            size: std::mem::size_of::<u32>(),
        };
        let comp_module = create_shader_module(device, comp_binary)?;
        let pipeline_specialization = vk::SpecializationInfo {
            map_entry_count: 1,
            map_entries: &specialization_map_entry,
            data_size: std::mem::size_of::<u32>(),
            data: (&k_one as *const u32).cast(),
        };
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_module)
            .name(b"main\0")
            .specialization_info(&pipeline_specialization)
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(-1);
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let shader_object_specialization = vk::SpecializationInfo {
            map_entry_count: 1,
            map_entries: &specialization_map_entry,
            data_size: std::mem::size_of::<u32>(),
            data: (&k_two as *const u32).cast(),
        };
        let mut shader_object_info = shader_create_info(
            vk::ShaderCreateFlagsEXT::empty(),
            vk::ShaderStageFlags::COMPUTE,
            vk::ShaderStageFlags::empty(),
            vk::ShaderCodeTypeEXT::SPIRV,
            std::mem::size_of_val(comp_binary.spirv),
            comp_binary.spirv.as_ptr().cast(),
            &set_layouts,
            &pc_ranges,
        );
        shader_object_info.specialization_info = &shader_object_specialization;
        let comp_shader = create_shader(device, &shader_object_info)?;

        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let buffer_values = [0u32; 3];
        let buffer_size = std::mem::size_of_val(&buffer_values) as u64;
        let ssbo = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let allocation = ssbo.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer_values.as_ptr() as *const u8,
                allocation.get_host_ptr(),
                buffer_size as usize,
            )
        };
        flush_alloc(device, allocation)?;

        let buffer_desc_info = make_descriptor_buffer_info(ssbo.get(), 0, vk::WHOLE_SIZE);
        let write = vk::WriteDescriptorSet {
            dst_set: *descriptor_set,
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: desc_type,
            buffer_info: &buffer_desc_info,
            ..Default::default()
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let bind_point = vk::PipelineBindPoint::COMPUTE;

        let dispatch_write_at_index = |cmd: vk::CommandBuffer, index: u32| unsafe {
            device.cmd_push_constants(cmd, *pipeline_layout, shader_stage, 0, &index.to_ne_bytes());
            device.cmd_dispatch(cmd, 1, 1, 1);
        };
        let bind_descriptor_set = |cmd: vk::CommandBuffer| unsafe {
            device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &[*descriptor_set], &[] as &[u32]);
        };

        let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let inheritance_info = vk::CommandBufferInheritanceInfo::default();
        let secondary_begin = vk::CommandBufferBeginInfo::builder().inheritance_info(&inheritance_info);
        unsafe { device.begin_command_buffer(*secondary, &secondary_begin) }.vk_check("vkBeginCommandBuffer")?;
        bind_descriptor_set(*secondary);
        unsafe { device.cmd_bind_shaders_ext(*secondary, &[shader_stage], &[comp_shader.get()]) };
        dispatch_write_at_index(*secondary, 1);
        end_command_buffer(device, *secondary)?;

        let primary_begin = vk::CommandBufferBeginInfo::builder();
        unsafe { device.begin_command_buffer(*primary, &primary_begin) }.vk_check("vkBeginCommandBuffer")?;
        bind_descriptor_set(*primary);
        unsafe { device.cmd_bind_pipeline(*primary, bind_point, *pipeline) };
        dispatch_write_at_index(*primary, 0);
        unsafe { device.cmd_execute_commands(*primary, &[*secondary]) };
        bind_descriptor_set(*primary);
        unsafe { device.cmd_bind_pipeline(*primary, bind_point, *pipeline) };
        dispatch_write_at_index(*primary, 2);
        end_command_buffer(device, *primary)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *primary)?;

        invalidate_alloc(device, allocation)?;
        let mut values = [0u32; 3];
        unsafe {
            std::ptr::copy_nonoverlapping(
                allocation.get_host_ptr() as *const u8,
                values.as_mut_ptr() as *mut u8,
                buffer_size as usize,
            )
        };

        let reference_values = [k_one, k_two, k_one];
        if values != reference_values {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details --",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `pipeline_shader_object_mix_with_secondaries`
pub fn add_mix_with_secondaries_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(MixSecondariesCase) as Box<dyn TestCase>);
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkRayTracingUtil.cpp (RayTracingPipeline: addShader, createPipeline, createShaderBindingTable)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written by hand for hodow_cts. One shader per stage and group index, as the mutable descriptor tests use it: the raygen, miss and callable
// shaders are general groups, a closest hit or any hit shader makes a triangle hit group and an intersection shader a procedural one. A shader binding table
// holds one group and is placed at the base alignment inside a larger buffer, so it does not depend on the alignment of the allocation.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1, KhrRayTracingPipelineExtensionDeviceCommands};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc};
use crate::vk::obj_util::{BufferWithMemory, make_buffer_create_info};
use crate::vk::ref_util::Unique;

/// `shaderGroupHandleSize` and `shaderGroupBaseAlignment` of the device.
pub fn shader_group_sizes(instance: &Instance, physical_device: vk::PhysicalDevice) -> (u32, u32) {
    let mut properties = vk::PhysicalDeviceRayTracingPipelinePropertiesKHR::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
    unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
    (
        properties.shader_group_handle_size,
        properties.shader_group_base_alignment,
    )
}

/// `RayTracingPipeline`, for one shader per stage.
#[derive(Default)]
pub struct RayTracingPipelineBuilder {
    shaders: Vec<(vk::ShaderStageFlags, vk::ShaderModule, usize)>,
    max_recursion_depth: Option<u32>,
}

impl RayTracingPipelineBuilder {
    pub fn new() -> Self {
        Self::default()
    }

    /// `addShader(shaderStage, shaderModule, group)`
    pub fn add_shader(&mut self, stage: vk::ShaderStageFlags, module: vk::ShaderModule, group: usize) -> &mut Self {
        self.shaders.push((stage, module, group));
        self
    }

    /// `setMaxRecursionDepth`
    pub fn set_max_recursion_depth(&mut self, depth: u32) -> &mut Self {
        self.max_recursion_depth = Some(depth);
        self
    }

    /// `createPipeline`
    pub fn create_pipeline<'a>(
        &self,
        device: &'a Device,
        layout: vk::PipelineLayout,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let group_count = self
            .shaders
            .iter()
            .map(|&(_, _, group)| group)
            .max()
            .map_or(0, |max| max + 1);
        let mut groups = vec![
            vk::RayTracingShaderGroupCreateInfoKHR {
                type_: vk::RayTracingShaderGroupTypeKHR::GENERAL,
                general_shader: vk::SHADER_UNUSED_KHR,
                closest_hit_shader: vk::SHADER_UNUSED_KHR,
                any_hit_shader: vk::SHADER_UNUSED_KHR,
                intersection_shader: vk::SHADER_UNUSED_KHR,
                ..Default::default()
            };
            group_count
        ];
        let mut stages = Vec::with_capacity(self.shaders.len());
        for (index, &(stage, module, group)) in self.shaders.iter().enumerate() {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(stage)
                    .module(module)
                    .name(b"main\0")
                    .build(),
            );
            let entry = &mut groups[group];
            let index = index as u32;
            if stage == vk::ShaderStageFlags::RAYGEN_KHR
                || stage == vk::ShaderStageFlags::MISS_KHR
                || stage == vk::ShaderStageFlags::CALLABLE_KHR
            {
                entry.type_ = vk::RayTracingShaderGroupTypeKHR::GENERAL;
                entry.general_shader = index;
            } else if stage == vk::ShaderStageFlags::CLOSEST_HIT_KHR {
                entry.type_ = vk::RayTracingShaderGroupTypeKHR::TRIANGLES_HIT_GROUP;
                entry.closest_hit_shader = index;
            } else if stage == vk::ShaderStageFlags::ANY_HIT_KHR {
                entry.type_ = vk::RayTracingShaderGroupTypeKHR::TRIANGLES_HIT_GROUP;
                entry.any_hit_shader = index;
            } else if stage == vk::ShaderStageFlags::INTERSECTION_KHR {
                entry.type_ = vk::RayTracingShaderGroupTypeKHR::PROCEDURAL_HIT_GROUP;
                entry.intersection_shader = index;
            } else {
                return Err(TestError::InternalError(format!(
                    "Unexpected ray tracing shader stage {stage:?}"
                )));
            }
        }

        let info = vk::RayTracingPipelineCreateInfoKHR {
            stage_count: stages.len() as u32,
            stages: stages.as_ptr(),
            group_count: groups.len() as u32,
            groups: groups.as_ptr(),
            max_pipeline_ray_recursion_depth: self.max_recursion_depth.unwrap_or(1),
            layout,
            base_pipeline_index: 0,
            ..Default::default()
        };
        let pipelines = unsafe {
            device.create_ray_tracing_pipelines_khr(
                vk::DeferredOperationKHR::null(),
                vk::PipelineCache::null(),
                &[info],
                None,
            )
        }
        .vk_check("vkCreateRayTracingPipelinesKHR")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }
}

/// `createShaderBindingTable` for `group_count` groups from `first_group`, and the region of it that `vkCmdTraceRaysKHR` takes.
pub fn create_shader_binding_table<'a>(
    device: &'a Device,
    alloc: &SimpleAllocator,
    pipeline: vk::Pipeline,
    handle_size: u32,
    base_alignment: u32,
    first_group: u32,
    group_count: u32,
) -> Result<(BufferWithMemory<'a>, vk::StridedDeviceAddressRegionKHR), TestError> {
    let table_size = u64::from(handle_size) * u64::from(group_count);
    let mut handles = vec![0u8; table_size as usize];
    unsafe { device.get_ray_tracing_shader_group_handles_khr(pipeline, first_group, group_count, &mut handles) }
        .vk_check("vkGetRayTracingShaderGroupHandlesKHR")?;

    let buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(
            table_size + u64::from(base_alignment),
            vk::BufferUsageFlags::SHADER_BINDING_TABLE_KHR | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    let address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
    let base_address = unsafe { device.get_buffer_device_address(&address_info) };
    let aligned_address = base_address.next_multiple_of(u64::from(base_alignment));
    let offset = (aligned_address - base_address) as usize;
    unsafe {
        std::ptr::copy_nonoverlapping(
            handles.as_ptr(),
            buffer.get_allocation().get_host_ptr().add(offset),
            handles.len(),
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    let region = vk::StridedDeviceAddressRegionKHR {
        device_address: aligned_address,
        stride: u64::from(handle_size),
        size: table_size,
    };
    Ok((buffer, region))
}

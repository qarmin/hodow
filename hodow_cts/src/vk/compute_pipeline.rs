// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkComputePipelineConstructionUtil.hpp / .cpp
//   (vk::ComputePipelineWrapper)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the
// COMPUTE_PIPELINE_CONSTRUCTION_TYPE_PIPELINE path is ported; the two shader-object
// paths back the `dEQP-VK.compute.shader_object_*` groups, which are not in scope
// yet. Selecting one raises NotPorted rather than silently falling back to the
// monolithic pipeline, which would report a pass for a group that was never run.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::programs::{ProgramBinary, create_shader_module};
use crate::vk::ref_util::Unique;

/// `vk::ComputePipelineConstructionType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ComputePipelineConstructionType {
    /// `COMPUTE_PIPELINE_CONSTRUCTION_TYPE_PIPELINE`
    Pipeline,
    /// `COMPUTE_PIPELINE_CONSTRUCTION_TYPE_SHADER_OBJECT_SPIRV`
    ShaderObjectSpirv,
    /// `COMPUTE_PIPELINE_CONSTRUCTION_TYPE_SHADER_OBJECT_BINARY`
    ShaderObjectBinary,
}

impl ComputePipelineConstructionType {
    /// The group name upstream registers this construction type under, which is what
    /// puts `pipeline` in `dEQP-VK.compute.pipeline.basic.*`.
    pub fn group_name(self) -> &'static str {
        match self {
            Self::Pipeline => "pipeline",
            Self::ShaderObjectSpirv => "shader_object_spirv",
            Self::ShaderObjectBinary => "shader_object_binary",
        }
    }
}

/// `vk::checkShaderObjectRequirements`
pub fn check_shader_object_requirements(construction_type: ComputePipelineConstructionType) -> Result<(), TestError> {
    match construction_type {
        ComputePipelineConstructionType::Pipeline => Ok(()),
        other => Err(TestError::NotPorted(format!("compute pipeline construction type {other:?} (VK_EXT_shader_object path)"))),
    }
}

/// `vk::ComputePipelineWrapper`
pub struct ComputePipelineWrapper<'a> {
    device: &'a Device,
    construction_type: ComputePipelineConstructionType,
    binary: ProgramBinary,
    descriptor_set_layouts: Vec<vk::DescriptorSetLayout>,
    specialization_info: Option<SpecializationState>,
    built: Option<BuiltPipeline<'a>>,
}

struct BuiltPipeline<'a> {
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pipeline: Unique<'a, vk::Pipeline>,
}

/// Owns the specialization data so the pointers handed to Vulkan stay alive for the
/// duration of `vkCreateComputePipelines`.
struct SpecializationState {
    entries: Vec<vk::SpecializationMapEntry>,
    data: Vec<u8>,
}

impl<'a> ComputePipelineWrapper<'a> {
    pub fn new(device: &'a Device, construction_type: ComputePipelineConstructionType, binary: ProgramBinary) -> Self {
        Self {
            device,
            construction_type,
            binary,
            descriptor_set_layouts: Vec::new(),
            specialization_info: None,
            built: None,
        }
    }

    /// `ComputePipelineWrapper::setDescriptorSetLayout`
    pub fn set_descriptor_set_layout(&mut self, layout: vk::DescriptorSetLayout) -> &mut Self {
        self.descriptor_set_layouts = vec![layout];
        self
    }

    /// `ComputePipelineWrapper::setSpecializationInfo`
    pub fn set_specialization_info(&mut self, entries: Vec<vk::SpecializationMapEntry>, data: Vec<u8>) -> &mut Self {
        self.specialization_info = Some(SpecializationState { entries, data });
        self
    }

    /// `ComputePipelineWrapper::buildPipeline`
    pub fn build_pipeline(&mut self) -> Result<(), TestError> {
        check_shader_object_requirements(self.construction_type)?;

        let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&self.descriptor_set_layouts);
        let pipeline_layout = unsafe { self.device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?;
        let pipeline_layout = Unique::new(self.device, pipeline_layout);

        let shader_module = create_shader_module(self.device, self.binary)?;

        let entry_point = b"main\0";
        let specialization = self.specialization_info.as_ref().map(|s| vk::SpecializationInfo {
            map_entry_count: s.entries.len() as u32,
            map_entries: s.entries.as_ptr(),
            data_size: s.data.len(),
            data: s.data.as_ptr().cast(),
        });

        let stage = vk::PipelineShaderStageCreateInfo {
            s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::PipelineShaderStageCreateFlags::empty(),
            stage: vk::ShaderStageFlags::COMPUTE,
            module: *shader_module,
            name: entry_point.as_ptr().cast(),
            specialization_info: specialization.as_ref().map_or(std::ptr::null(), |s| s),
        };

        let create_info = vk::ComputePipelineCreateInfo {
            s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::PipelineCreateFlags::empty(),
            stage,
            layout: *pipeline_layout,
            base_pipeline_handle: vk::Pipeline::null(),
            base_pipeline_index: -1,
        };

        let pipelines = unsafe { self.device.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
            .map_err(|e| crate::tcu::TestError::InternalError(format!("vkCreateComputePipelines returned {e:?}")))?;

        self.built = Some(BuiltPipeline {
            pipeline_layout,
            pipeline: Unique::new(self.device, pipelines.0[0]),
        });
        Ok(())
    }

    /// `ComputePipelineWrapper::getPipelineLayout`
    pub fn get_pipeline_layout(&self) -> vk::PipelineLayout {
        *self.built.as_ref().expect("buildPipeline() not called").pipeline_layout
    }

    /// `ComputePipelineWrapper::bind`
    pub fn bind(&self, cmd_buffer: vk::CommandBuffer) {
        let built = self.built.as_ref().expect("buildPipeline() not called");
        unsafe {
            self.device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *built.pipeline);
        }
    }
}

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
// Modifications: rewritten in Rust for hodow_cts. The two shader-object paths back the
// `dEQP-VK.compute.shader_object_*` groups. A case does not carry its construction type (the cases are the statics of
// the shader manifests), so the group that registers a subtree wraps its cases (`compute/construction_type.rs`) and
// makes the type ambient for the duration of the case: `ComputePipelineWrapper::new` uses the ambient type over the
// one it is given, and the wrapper case reports a case that never built a pipeline through the wrapper as not ported
// rather than as a pass for a shader-object variant that was never run.

use std::cell::Cell;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtShaderObjectExtensionDeviceCommands;

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

thread_local! {
    static AMBIENT: Cell<Option<ComputePipelineConstructionType>> = const { Cell::new(None) };
    static WRAPPERS_BUILT: Cell<u32> = const { Cell::new(0) };
}

/// Makes a construction type ambient on this thread until dropped; wrappers created meanwhile use it and are counted.
pub struct AmbientConstructionType {
    previous: Option<ComputePipelineConstructionType>,
    previous_built: u32,
}

impl AmbientConstructionType {
    pub fn enter(construction_type: ComputePipelineConstructionType) -> Self {
        let previous = AMBIENT.with(|ambient| ambient.replace(Some(construction_type)));
        let previous_built = WRAPPERS_BUILT.with(|built| built.replace(0));
        Self {
            previous,
            previous_built,
        }
    }

    /// How many `ComputePipelineWrapper`s were created since `enter`.
    pub fn wrappers_created(&self) -> u32 {
        WRAPPERS_BUILT.with(Cell::get)
    }
}

impl Drop for AmbientConstructionType {
    fn drop(&mut self) {
        AMBIENT.with(|ambient| ambient.set(self.previous));
        WRAPPERS_BUILT.with(|built| built.set(self.previous_built));
    }
}

/// For a case upstream builds with `makeComputePipeline` in every group, so its construction type does not apply: it counts as a wrapper made,
/// which keeps the shader-object groups from reporting it as one that missed the wrapper.
pub fn note_construction_type_independent() {
    WRAPPERS_BUILT.with(|built| built.set(built.get() + 1));
}

/// `vk::checkShaderObjectRequirements` - the VK_EXT_shader_object extension itself is checked by the case wrapper of the shader-object groups,
/// which has the context.
pub fn check_shader_object_requirements(_construction_type: ComputePipelineConstructionType) -> Result<(), TestError> {
    Ok(())
}

/// `vk::ComputePipelineWrapper`
pub struct ComputePipelineWrapper<'a> {
    device: &'a Device,
    construction_type: ComputePipelineConstructionType,
    binary: ProgramBinary,
    descriptor_set_layouts: Vec<vk::DescriptorSetLayout>,
    specialization_info: Option<SpecializationState>,
    push_constant_ranges: Vec<vk::PushConstantRange>,
    subgroup_size: u32,
    pipeline_flags2: Option<vk::PipelineCreateFlags2>,
    built: Option<BuiltPipeline<'a>>,
}

struct BuiltPipeline<'a> {
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    object: BuiltObject<'a>,
}

enum BuiltObject<'a> {
    Pipeline(Unique<'a, vk::Pipeline>),
    Shader(ShaderHandle<'a>),
}

/// A `VkShaderEXT`, destroyed when dropped.
struct ShaderHandle<'a> {
    device: &'a Device,
    handle: vk::ShaderEXT,
}

impl Drop for ShaderHandle<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_shader_ext(self.handle, None) };
    }
}

/// Owns the specialization data so the pointers handed to Vulkan stay alive for the
/// duration of `vkCreateComputePipelines`.
struct SpecializationState {
    entries: Vec<vk::SpecializationMapEntry>,
    data: Vec<u8>,
}

impl<'a> ComputePipelineWrapper<'a> {
    pub fn new(device: &'a Device, construction_type: ComputePipelineConstructionType, binary: ProgramBinary) -> Self {
        let construction_type = match AMBIENT.with(Cell::get) {
            Some(ambient) => {
                WRAPPERS_BUILT.with(|built| built.set(built.get() + 1));
                ambient
            }
            None => construction_type,
        };
        Self {
            device,
            construction_type,
            binary,
            descriptor_set_layouts: Vec::new(),
            specialization_info: None,
            push_constant_ranges: Vec::new(),
            subgroup_size: 0,
            pipeline_flags2: None,
            built: None,
        }
    }

    /// `ComputePipelineWrapper::addPushConstantRange`
    pub fn add_push_constant_range(&mut self, range: vk::PushConstantRange) -> &mut Self {
        self.push_constant_ranges.push(range);
        self
    }

    /// `ComputePipelineWrapper::setSubgroupSize` - 0 means no required size
    pub fn set_subgroup_size(&mut self, subgroup_size: u32) -> &mut Self {
        self.subgroup_size = subgroup_size;
        self
    }

    /// The creation flags of `VkPipelineCreateFlags2CreateInfo` (`DGCComputePipelineExt` asks for `INDIRECT_BINDABLE_EXT`)
    pub fn set_pipeline_create_flags2(&mut self, flags: vk::PipelineCreateFlags2) -> &mut Self {
        self.pipeline_flags2 = Some(flags);
        self
    }

    /// `ComputePipelineWrapper::setDescriptorSetLayout`
    pub fn set_descriptor_set_layout(&mut self, layout: vk::DescriptorSetLayout) -> &mut Self {
        self.descriptor_set_layouts = vec![layout];
        self
    }

    /// Appends a set layout (the wrapper of upstream takes them one by one through `setDescriptorSetLayout` calls of a pipeline layout)
    pub fn add_descriptor_set_layout(&mut self, layout: vk::DescriptorSetLayout) -> &mut Self {
        self.descriptor_set_layouts.push(layout);
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

        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&self.descriptor_set_layouts)
            .push_constant_ranges(&self.push_constant_ranges);
        let pipeline_layout =
            unsafe { self.device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?;
        let pipeline_layout = Unique::new(self.device, pipeline_layout);

        let specialization = self.specialization_info.as_ref().map(|s| vk::SpecializationInfo {
            map_entry_count: s.entries.len() as u32,
            map_entries: s.entries.as_ptr(),
            data_size: s.data.len(),
            data: s.data.as_ptr().cast(),
        });

        let subgroup_size_info = vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo {
            s_type: vk::StructureType::PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO,
            next: std::ptr::null(),
            required_subgroup_size: self.subgroup_size,
        };
        let subgroup_size_next: *const std::ffi::c_void = if self.subgroup_size != 0 {
            (&subgroup_size_info as *const vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo).cast()
        } else {
            std::ptr::null()
        };

        let object = if self.construction_type == ComputePipelineConstructionType::Pipeline {
            let shader_module = create_shader_module(self.device, self.binary)?;
            let entry_point = b"main\0";

            let stage = vk::PipelineShaderStageCreateInfo {
                s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
                next: subgroup_size_next,
                flags: vk::PipelineShaderStageCreateFlags::empty(),
                stage: vk::ShaderStageFlags::COMPUTE,
                module: *shader_module,
                name: entry_point.as_ptr().cast(),
                specialization_info: specialization.as_ref().map_or(std::ptr::null(), |s| s),
            };

            let flags2_info = vk::PipelineCreateFlags2CreateInfo {
                flags: self.pipeline_flags2.unwrap_or_else(vk::PipelineCreateFlags2::empty),
                ..Default::default()
            };
            let create_info = vk::ComputePipelineCreateInfo {
                s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
                next: if self.pipeline_flags2.is_some() {
                    (&flags2_info as *const vk::PipelineCreateFlags2CreateInfo).cast()
                } else {
                    std::ptr::null()
                },
                flags: vk::PipelineCreateFlags::empty(),
                stage,
                layout: *pipeline_layout,
                base_pipeline_handle: vk::Pipeline::null(),
                base_pipeline_index: -1,
            };

            let pipelines = unsafe {
                self.device
                    .create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None)
            }
            .map_err(|e| crate::tcu::TestError::InternalError(format!("vkCreateComputePipelines returned {e:?}")))?;
            BuiltObject::Pipeline(Unique::new(self.device, pipelines.0[0]))
        } else {
            let mut create_info = vk::ShaderCreateInfoEXT {
                s_type: vk::StructureType::SHADER_CREATE_INFO_EXT,
                next: subgroup_size_next,
                flags: vk::ShaderCreateFlagsEXT::empty(),
                stage: vk::ShaderStageFlags::COMPUTE,
                next_stage: vk::ShaderStageFlags::empty(),
                code_type: vk::ShaderCodeTypeEXT::SPIRV,
                code_size: std::mem::size_of_val(self.binary.spirv),
                code: self.binary.spirv.as_ptr().cast(),
                name: c"main".as_ptr(),
                set_layout_count: self.descriptor_set_layouts.len() as u32,
                set_layouts: self.descriptor_set_layouts.as_ptr(),
                push_constant_range_count: self.push_constant_ranges.len() as u32,
                push_constant_ranges: self.push_constant_ranges.as_ptr(),
                specialization_info: specialization.as_ref().map_or(std::ptr::null(), |s| s),
            };

            let mut shader = self.create_shader(&create_info)?;

            if self.construction_type == ComputePipelineConstructionType::ShaderObjectBinary {
                let data = unsafe { self.device.get_shader_binary_data_ext(shader.handle) }
                    .vk_check("vkGetShaderBinaryDataEXT")?;
                create_info.code_type = vk::ShaderCodeTypeEXT::BINARY;
                create_info.code_size = data.len();
                create_info.code = data.as_ptr().cast();
                shader = self.create_shader(&create_info)?;
            }

            BuiltObject::Shader(shader)
        };

        self.built = Some(BuiltPipeline {
            pipeline_layout,
            object,
        });
        Ok(())
    }

    /// `vk::createShader`
    fn create_shader(&self, create_info: &vk::ShaderCreateInfoEXT) -> Result<ShaderHandle<'a>, TestError> {
        let (shaders, _) = unsafe { self.device.create_shaders_ext(std::slice::from_ref(create_info), None) }
            .vk_check("vkCreateShadersEXT")?;
        Ok(ShaderHandle {
            device: self.device,
            handle: shaders[0],
        })
    }

    /// `ComputePipelineWrapper::getPipelineLayout`
    pub fn get_pipeline_layout(&self) -> vk::PipelineLayout {
        *self.built.as_ref().expect("buildPipeline() not called").pipeline_layout
    }

    /// `ComputePipelineWrapper::getPipeline`: null when the program is a shader object
    pub fn get_pipeline(&self) -> vk::Pipeline {
        match &self.built.as_ref().expect("buildPipeline() not called").object {
            BuiltObject::Pipeline(pipeline) => **pipeline,
            BuiltObject::Shader(_) => vk::Pipeline::null(),
        }
    }

    /// `ComputePipelineWrapper::bind`
    pub fn bind(&self, cmd_buffer: vk::CommandBuffer) {
        let built = self.built.as_ref().expect("buildPipeline() not called");
        match &built.object {
            BuiltObject::Pipeline(pipeline) => unsafe {
                self.device
                    .cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, **pipeline);
            },
            BuiltObject::Shader(shader) => unsafe {
                self.device
                    .cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::COMPUTE], &[shader.handle]);
            },
        }
    }
}

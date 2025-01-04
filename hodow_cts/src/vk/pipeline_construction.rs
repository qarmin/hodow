// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkPipelineConstructionUtil.hpp / vkPipelineConstructionUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `GraphicsPipelineWrapper` is a builder that is fed the four
// pipeline states one `setup*` call at a time and then builds; every test that this port has ported creates its pipeline from one
// `DrawPipelineState` in one call, so the construction types are applied there instead: `create_linked_pipeline` takes the
// state the monolithic pipeline would have been created from, cuts it into the four graphics pipeline library parts
// (vertex input interface, pre-rasterization shaders, fragment shader, fragment output interface) and links them. The shader
// object construction types are not here.

use std::ptr;

use vulkanalia::Device;
use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::ref_util::Unique;
use crate::vkt::Context;

/// `PipelineConstructionType`. The four shader object types are only understood by the cases that record their own draws
/// (`pipeline::image_sampling_instance`); the pipeline helpers refuse them.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum PipelineConstructionType {
    /// `PIPELINE_CONSTRUCTION_TYPE_MONOLITHIC`
    Monolithic,
    /// `PIPELINE_CONSTRUCTION_TYPE_LINK_TIME_OPTIMIZED_LIBRARY`
    LinkTimeOptimizedLibrary,
    /// `PIPELINE_CONSTRUCTION_TYPE_FAST_LINKED_LIBRARY`
    FastLinkedLibrary,
    /// `PIPELINE_CONSTRUCTION_TYPE_SHADER_OBJECT_UNLINKED_SPIRV`
    ShaderObjectUnlinkedSpirv,
    /// `PIPELINE_CONSTRUCTION_TYPE_SHADER_OBJECT_UNLINKED_BINARY`
    ShaderObjectUnlinkedBinary,
    /// `PIPELINE_CONSTRUCTION_TYPE_SHADER_OBJECT_LINKED_SPIRV`
    ShaderObjectLinkedSpirv,
    /// `PIPELINE_CONSTRUCTION_TYPE_SHADER_OBJECT_LINKED_BINARY`
    ShaderObjectLinkedBinary,
}

impl PipelineConstructionType {
    /// `getPipelineConstructionTypeName`, the name of the group the type's tests sit in.
    pub fn group_name(self) -> &'static str {
        match self {
            Self::Monolithic => "monolithic",
            Self::LinkTimeOptimizedLibrary => "pipeline_library",
            Self::FastLinkedLibrary => "fast_linked_library",
            Self::ShaderObjectUnlinkedSpirv => "shader_object_unlinked_spirv",
            Self::ShaderObjectUnlinkedBinary => "shader_object_unlinked_binary",
            Self::ShaderObjectLinkedSpirv => "shader_object_linked_spirv",
            Self::ShaderObjectLinkedBinary => "shader_object_linked_binary",
        }
    }

    /// `isConstructionTypeShaderObject`
    pub fn is_shader_object(self) -> bool {
        matches!(
            self,
            Self::ShaderObjectUnlinkedSpirv
                | Self::ShaderObjectUnlinkedBinary
                | Self::ShaderObjectLinkedSpirv
                | Self::ShaderObjectLinkedBinary
        )
    }

    /// The shader object types that create both shaders in one `vkCreateShadersEXT` call with the link flag.
    pub fn is_shader_object_linked(self) -> bool {
        matches!(self, Self::ShaderObjectLinkedSpirv | Self::ShaderObjectLinkedBinary)
    }

    /// The shader object types that create their shaders from binaries retrieved from the first shaders.
    pub fn is_shader_object_binary(self) -> bool {
        matches!(self, Self::ShaderObjectUnlinkedBinary | Self::ShaderObjectLinkedBinary)
    }

    /// `isConstructionTypeLibrary`
    pub fn is_library(self) -> bool {
        matches!(self, Self::LinkTimeOptimizedLibrary | Self::FastLinkedLibrary)
    }
}

/// `checkPipelineConstructionRequirements`
pub fn check_pipeline_construction_requirements(
    context: &Context<'_>,
    construction: PipelineConstructionType,
) -> Result<(), TestError> {
    if construction == PipelineConstructionType::Monolithic {
        return Ok(());
    }

    if construction.is_shader_object() {
        context.require_device_functionality("VK_EXT_shader_object")?;

        let mut features = vk::PhysicalDeviceShaderObjectFeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if features.shader_object == vk::FALSE {
            return Err(TestError::NotSupported("shaderObject is not supported".to_string()));
        }
        return Ok(());
    }

    context.require_device_functionality("VK_EXT_graphics_pipeline_library")?;

    let mut features = vk::PhysicalDeviceGraphicsPipelineLibraryFeaturesEXT::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    if features.graphics_pipeline_library == vk::FALSE {
        return Err(TestError::NotSupported(
            "graphicsPipelineLibrary is not supported".to_string(),
        ));
    }

    if construction == PipelineConstructionType::FastLinkedLibrary {
        let mut properties = vk::PhysicalDeviceGraphicsPipelineLibraryPropertiesEXT::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }
        if properties.graphics_pipeline_library_fast_linking == vk::FALSE {
            return Err(TestError::NotSupported(
                "graphicsPipelineLibraryFastLinking is not supported".to_string(),
            ));
        }
    }

    Ok(())
}

/// The create info states of a monolithic graphics pipeline, as `create_linked_pipeline` receives them. Each library is created
/// from the members its part of the pipeline reads and ignores the rest.
pub struct PipelineParts<'a> {
    pub flags: vk::PipelineCreateFlags,
    pub layout: vk::PipelineLayout,
    pub render_pass: vk::RenderPass,
    pub subpass: u32,
    pub stages: &'a [vk::PipelineShaderStageCreateInfo],
    pub vertex_input: &'a vk::PipelineVertexInputStateCreateInfo,
    pub input_assembly: &'a vk::PipelineInputAssemblyStateCreateInfo,
    pub tessellation: Option<&'a vk::PipelineTessellationStateCreateInfo>,
    pub viewport: &'a vk::PipelineViewportStateCreateInfo,
    pub rasterization: &'a vk::PipelineRasterizationStateCreateInfo,
    pub multisample: &'a vk::PipelineMultisampleStateCreateInfo,
    pub depth_stencil: &'a vk::PipelineDepthStencilStateCreateInfo,
    pub color_blend: Option<&'a vk::PipelineColorBlendStateCreateInfo>,
    pub dynamic: Option<&'a vk::PipelineDynamicStateCreateInfo>,
    pub rendering: Option<&'a vk::PipelineRenderingCreateInfo>,
    pub fragment_shading_rate: Option<&'a vk::PipelineFragmentShadingRateStateCreateInfoKHR>,
}

/// The stages that belong to the pre-rasterization shaders part: everything that is not the fragment shader.
fn is_pre_rasterization_stage(stage: vk::ShaderStageFlags) -> bool {
    stage != vk::ShaderStageFlags::FRAGMENT
}

/// What `GraphicsPipelineWrapper::buildPipeline` does for the library construction types: the four parts as library pipelines,
/// then one pipeline linking them. A link time optimized library keeps the information the link needs for it (the libraries are
/// created with `RETAIN_LINK_TIME_OPTIMIZATION_INFO` and the link asks for `LINK_TIME_OPTIMIZATION`), a fast linked one does not.
pub fn create_linked_pipeline<'a>(
    device: &'a Device,
    construction: PipelineConstructionType,
    parts: &PipelineParts<'_>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let link_time_optimized = construction == PipelineConstructionType::LinkTimeOptimizedLibrary;
    let mut library_flags = parts.flags | vk::PipelineCreateFlags::LIBRARY_KHR;
    if link_time_optimized {
        library_flags |= vk::PipelineCreateFlags::RETAIN_LINK_TIME_OPTIMIZATION_INFO_EXT;
    }

    let pre_rasterization_stages: Vec<vk::PipelineShaderStageCreateInfo> = parts
        .stages
        .iter()
        .filter(|stage| is_pre_rasterization_stage(stage.stage))
        .copied()
        .collect();
    let fragment_stages: Vec<vk::PipelineShaderStageCreateInfo> = parts
        .stages
        .iter()
        .filter(|stage| !is_pre_rasterization_stage(stage.stage))
        .copied()
        .collect();

    // A copy that starts a chain of its own: `push_next` links whatever the pushed structure already points to.
    let rendering_copy = || {
        parts.rendering.map(|rendering| {
            let mut copy = *rendering;
            copy.next = ptr::null();
            copy
        })
    };

    let create_library = |library: vk::GraphicsPipelineLibraryFlagsEXT| -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let mut library_info = vk::GraphicsPipelineLibraryCreateInfoEXT::builder().flags(library);
        let mut rendering = rendering_copy();
        let mut shading_rate = parts.fragment_shading_rate.map(|state| {
            let mut copy = *state;
            copy.next = ptr::null();
            copy
        });

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .flags(library_flags)
            .layout(parts.layout)
            .base_pipeline_index(0);

        if library == vk::GraphicsPipelineLibraryFlagsEXT::VERTEX_INPUT_INTERFACE {
            info = info
                .vertex_input_state(parts.vertex_input)
                .input_assembly_state(parts.input_assembly);
        } else if library == vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS {
            info = info
                .stages(&pre_rasterization_stages)
                .viewport_state(parts.viewport)
                .rasterization_state(parts.rasterization)
                .render_pass(parts.render_pass)
                .subpass(parts.subpass);
            if let Some(tessellation) = parts.tessellation {
                info = info.tessellation_state(tessellation);
            }
            if let Some(state) = shading_rate.as_mut() {
                info = info.push_next(state);
            }
            if let Some(state) = rendering.as_mut() {
                info = info.push_next(state);
            }
        } else if library == vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_SHADER {
            info = info
                .stages(&fragment_stages)
                .depth_stencil_state(parts.depth_stencil)
                .multisample_state(parts.multisample)
                .render_pass(parts.render_pass)
                .subpass(parts.subpass);
            if let Some(state) = rendering.as_mut() {
                info = info.push_next(state);
            }
        } else {
            info = info
                .multisample_state(parts.multisample)
                .render_pass(parts.render_pass)
                .subpass(parts.subpass);
            if let Some(color_blend) = parts.color_blend {
                info = info.color_blend_state(color_blend);
            }
            if let Some(state) = rendering.as_mut() {
                info = info.push_next(state);
            }
        }
        if let Some(dynamic) = parts.dynamic {
            info = info.dynamic_state(dynamic);
        }
        let info = info.push_next(&mut library_info);

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    };

    // A pipeline with a mesh shader has no vertex input interface, so there is no such library to link.
    let has_mesh_stage = parts.stages.iter().any(|stage| {
        stage
            .stage
            .intersects(vk::ShaderStageFlags::MESH_EXT | vk::ShaderStageFlags::TASK_EXT)
    });
    let vertex_input = if has_mesh_stage {
        None
    } else {
        Some(create_library(
            vk::GraphicsPipelineLibraryFlagsEXT::VERTEX_INPUT_INTERFACE,
        )?)
    };
    let pre_rasterization = create_library(vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS)?;
    let fragment_shader = create_library(vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_SHADER)?;
    let fragment_output = create_library(vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_OUTPUT_INTERFACE)?;

    let mut libraries: Vec<vk::Pipeline> = Vec::with_capacity(4);
    if let Some(vertex_input) = &vertex_input {
        libraries.push(**vertex_input);
    }
    libraries.extend([*pre_rasterization, *fragment_shader, *fragment_output]);
    let mut link_info = vk::PipelineLibraryCreateInfoKHR::builder().libraries(&libraries);
    let link_flags = if link_time_optimized {
        parts.flags | vk::PipelineCreateFlags::LINK_TIME_OPTIMIZATION_EXT
    } else {
        parts.flags
    };
    let info = vk::GraphicsPipelineCreateInfo::builder()
        .flags(link_flags)
        .layout(parts.layout)
        .base_pipeline_index(0)
        .push_next(&mut link_info);

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    let linked = Unique::new(device, pipelines.0[0]);

    // The linked pipeline keeps referring to its libraries until it is destroyed, and it is destroyed when its case ends.
    LIBRARIES.with(|pending| {
        let mut pending = pending.borrow_mut();
        pending.extend(
            vertex_input
                .into_iter()
                .chain([pre_rasterization, fragment_shader, fragment_output])
                .map(|library| (device.clone(), library.release())),
        );
    });
    Ok(linked)
}

thread_local! {
    static LIBRARIES: std::cell::RefCell<Vec<(Device, vk::Pipeline)>> = const { std::cell::RefCell::new(Vec::new()) };
}

/// Destroys the libraries of the pipelines `create_linked_pipeline` made; the runner calls it once a case and everything it owns is gone.
pub fn release_libraries() {
    for (device, library) in LIBRARIES.with(|pending| std::mem::take(&mut *pending.borrow_mut())) {
        unsafe { device.destroy_pipeline(library, None) };
    }
}

// ---------------------------------------------------------------------------------------------------------------------------
// The ambient construction type: the cases of a whole group run again with their pipelines built from libraries
// (`createChildren` once per `PipelineConstructionType` upstream). `obj_util`'s pipeline helpers go through
// `create_graphics_pipeline`, which reads the type that is ambient while a case runs; `with_construction_type` makes it so.
// ---------------------------------------------------------------------------------------------------------------------------

thread_local! {
    static AMBIENT_CONSTRUCTION: std::cell::Cell<PipelineConstructionType> = const { std::cell::Cell::new(PipelineConstructionType::Monolithic) };
}

/// The construction type the pipelines of the running case are made with.
pub fn ambient_construction_type() -> PipelineConstructionType {
    AMBIENT_CONSTRUCTION.with(std::cell::Cell::get)
}

/// `vkCreateGraphicsPipelines` for one create info, made from graphics pipeline libraries when the running case asks for them. The
/// states the libraries are made of are read off the info's members, and a `VkPipelineRenderingCreateInfo` anywhere in its pNext
/// chain is carried to the libraries that need it; any other chained structure is not.
pub fn create_graphics_pipeline<'a>(
    device: &'a Device,
    info: &vk::GraphicsPipelineCreateInfo,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let construction = ambient_construction_type();
    if construction.is_shader_object() {
        return Err(TestError::NotPorted(
            "a case that builds a graphics pipeline cannot run with shader objects".to_string(),
        ));
    }
    if construction == PipelineConstructionType::Monolithic {
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[*info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        return Ok(Unique::new(device, pipelines.0[0]));
    }

    let default_depth_stencil = vk::PipelineDepthStencilStateCreateInfo::default();
    let default_vertex_input = vk::PipelineVertexInputStateCreateInfo::default();
    let default_input_assembly = vk::PipelineInputAssemblyStateCreateInfo::default();
    // SAFETY: the pointers are those of a create info the caller built from live states for this very call.
    let rendering = unsafe {
        let mut node = info.next.cast::<vk::BaseInStructure>();
        let mut found = None;
        while !node.is_null() {
            if (*node).s_type == vk::StructureType::PIPELINE_RENDERING_CREATE_INFO {
                found = Some(&*node.cast::<vk::PipelineRenderingCreateInfo>());
                break;
            }
            node = (*node).next;
        }
        found
    };
    // SAFETY: as above.
    let parts = unsafe {
        PipelineParts {
            flags: info.flags,
            layout: info.layout,
            render_pass: info.render_pass,
            subpass: info.subpass,
            stages: std::slice::from_raw_parts(info.stages, info.stage_count as usize),
            vertex_input: info.vertex_input_state.as_ref().unwrap_or(&default_vertex_input),
            input_assembly: info.input_assembly_state.as_ref().unwrap_or(&default_input_assembly),
            tessellation: info.tessellation_state.as_ref(),
            viewport: info
                .viewport_state
                .as_ref()
                .ok_or_else(|| TestError::InternalError("a library pipeline needs a viewport state".to_string()))?,
            rasterization: info.rasterization_state.as_ref().ok_or_else(|| {
                TestError::InternalError("a library pipeline needs a rasterization state".to_string())
            })?,
            multisample: info
                .multisample_state
                .as_ref()
                .ok_or_else(|| TestError::InternalError("a library pipeline needs a multisample state".to_string()))?,
            depth_stencil: info.depth_stencil_state.as_ref().unwrap_or(&default_depth_stencil),
            color_blend: info.color_blend_state.as_ref(),
            dynamic: info.dynamic_state.as_ref(),
            rendering,
            fragment_shading_rate: None,
        }
    };
    create_linked_pipeline(device, construction, &parts)
}

/// A case run with the pipelines of a construction type other than monolithic.
struct ConstructionCase {
    inner: Box<dyn crate::vkt::TestCase>,
    construction: PipelineConstructionType,
}

impl crate::vkt::TestCase for ConstructionCase {
    fn name(&self) -> &str {
        self.inner.name()
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_pipeline_construction_requirements(context, self.construction)?;
        self.inner.check_support(context)
    }

    fn programs(&self) -> crate::vk::programs::BinaryCollection {
        self.inner.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn crate::vkt::TestInstance + 'a> {
        Box::new(ConstructionInstance {
            inner: self.inner.create_instance(context),
            construction: self.construction,
        })
    }

    fn is_stub(&self) -> bool {
        self.inner.is_stub()
    }
}

struct ConstructionInstance<'a> {
    inner: Box<dyn crate::vkt::TestInstance + 'a>,
    construction: PipelineConstructionType,
}

impl crate::vkt::TestInstance for ConstructionInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        let previous = AMBIENT_CONSTRUCTION.with(|ambient| ambient.replace(self.construction));
        let outcome = self.inner.iterate();
        AMBIENT_CONSTRUCTION.with(|ambient| ambient.set(previous));
        outcome
    }
}

/// Every case of `group` run with the pipelines of `construction`.
pub fn with_construction_type(
    group: crate::vkt::TestCaseGroup,
    construction: PipelineConstructionType,
) -> crate::vkt::TestCaseGroup {
    group.map_cases(&mut |case| {
        Box::new(ConstructionCase {
            inner: case,
            construction,
        }) as Box<dyn crate::vkt::TestCase>
    })
}

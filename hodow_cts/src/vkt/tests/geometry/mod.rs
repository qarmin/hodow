// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/geometry/vktGeometryTests.cpp
//   external/vulkancts/modules/vulkan/geometry/vktGeometryTestsUtil.cpp (`GraphicsPipelineBuilder`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: `input`, `basic`, `layered`, `instanced`, `varying`, `emit` and `builtin_variable` (the
// `outside_block.position` geometry shader is HLSL, compiled by glslang -D as stage `hlsl_geom`). The cases that compare against PNG reference images embed them
// from `data/geometry`.

pub mod builtin_variable_tests;
pub mod expander;
pub mod expander_tests;
pub mod instanced_tests;
pub mod layered_tests;
pub mod reference_images;
pub mod side_effect_tests;

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::ref_util::Unique;
use crate::vkt::TestCaseGroup;

/// `GeometryExpanderRenderTestInstance`-era `GraphicsPipelineBuilder`: shaders by stage, one vertex binding with attributes, a
/// topology, optional patch control points, and fixed viewport, rasterization, depth/stencil and blend state.
pub struct GraphicsPipelineBuilder {
    render_size: (u32, u32),
    shaders: Vec<(vk::ShaderStageFlags, vk::ShaderModule)>,
    vertex_input_bindings: Vec<vk::VertexInputBindingDescription>,
    vertex_input_attributes: Vec<vk::VertexInputAttributeDescription>,
    primitive_topology: vk::PrimitiveTopology,
    patch_control_points: u32,
    blend_enable: bool,
    cull_mode_flags: vk::CullModeFlags,
    front_face: vk::FrontFace,
}

impl GraphicsPipelineBuilder {
    pub fn new(render_size: (u32, u32)) -> Self {
        Self {
            render_size,
            shaders: Vec::new(),
            vertex_input_bindings: Vec::new(),
            vertex_input_attributes: Vec::new(),
            primitive_topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            patch_control_points: 0,
            blend_enable: false,
            cull_mode_flags: vk::CullModeFlags::NONE,
            front_face: vk::FrontFace::COUNTER_CLOCKWISE,
        }
    }

    pub fn set_shader(mut self, stage: vk::ShaderStageFlags, module: vk::ShaderModule) -> Self {
        self.shaders.push((stage, module));
        self
    }

    pub fn add_vertex_binding(mut self, binding: vk::VertexInputBindingDescription) -> Self {
        self.vertex_input_bindings.push(binding);
        self
    }

    pub fn add_vertex_attribute(mut self, attribute: vk::VertexInputAttributeDescription) -> Self {
        self.vertex_input_attributes.push(attribute);
        self
    }

    pub fn set_primitive_topology(mut self, topology: vk::PrimitiveTopology) -> Self {
        self.primitive_topology = topology;
        self
    }

    pub fn set_patch_control_points(mut self, patch_control_points: u32) -> Self {
        self.patch_control_points = patch_control_points;
        self
    }

    /// `GraphicsPipelineBuilder::build`
    pub fn build<'a>(
        &self,
        device: &'a Device,
        pipeline_layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let stage_infos: Vec<vk::PipelineShaderStageCreateInfo> = self
            .shaders
            .iter()
            .map(|&(stage, module)| {
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(stage)
                    .module(module)
                    .name(b"main\0")
                    .build()
            })
            .collect();
        let has_stage =
            |stage: vk::ShaderStageFlags| self.shaders.iter().any(|&(shader_stage, _)| shader_stage == stage);
        let has_tessellation = has_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL);
        let is_rasterization_disabled = !has_stage(vk::ShaderStageFlags::FRAGMENT);

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&self.vertex_input_bindings)
            .vertex_attribute_descriptions(&self.vertex_input_attributes);

        let topology = if has_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            self.primitive_topology
        };
        let primitive_restart_enable = !matches!(
            self.primitive_topology,
            vk::PrimitiveTopology::POINT_LIST
                | vk::PrimitiveTopology::LINE_LIST
                | vk::PrimitiveTopology::TRIANGLE_LIST
                | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::PATCH_LIST
        );
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(topology)
            .primitive_restart_enable(primitive_restart_enable);
        let tessellation_state =
            vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(self.patch_control_points);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: self.render_size.0 as f32,
            height: self.render_size.1 as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: self.render_size.0,
                height: self.render_size.1,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);

        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(is_rasterization_disabled)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(self.cull_mode_flags)
            .front_face(self.front_face)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .sample_shading_enable(false)
            .min_sample_shading(0.0);
        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::NEVER)
            .compare_mask(0)
            .write_mask(0)
            .reference(0)
            .build();
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(false)
            .depth_write_enable(false)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(self.blend_enable)
            .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
            .dst_color_blend_factor(vk::BlendFactor::ONE)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::SRC_ALPHA)
            .dst_alpha_blend_factor(vk::BlendFactor::ONE)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&blend_attachments)
            .blend_constants([0.0; 4]);

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stage_infos)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .rasterization_state(&rasterization_state)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        if has_tessellation {
            info = info.tessellation_state(&tessellation_state);
        }
        if !is_rasterization_disabled {
            info = info
                .viewport_state(&viewport_state)
                .multisample_state(&multisample_state)
                .depth_stencil_state(&depth_stencil_state)
                .color_blend_state(&color_blend_state);
        }
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }
}

/// `createTests`
pub fn create_tests() -> TestCaseGroup {
    let mut geometry_tests = TestCaseGroup::new("geometry");

    geometry_tests.add_child(expander_tests::create_input_geometry_shader_tests());
    geometry_tests.add_child(expander_tests::create_basic_geometry_shader_tests());
    geometry_tests.add_child(layered_tests::create_layered_rendering_tests());
    geometry_tests.add_child(instanced_tests::create_instanced_rendering_tests());
    geometry_tests.add_child(expander_tests::create_varying_geometry_shader_tests());
    geometry_tests.add_child(expander_tests::create_emit_geometry_shader_tests());
    geometry_tests.add_child(builtin_variable_tests::create_builtin_variable_geometry_shader_tests());

    geometry_tests
}

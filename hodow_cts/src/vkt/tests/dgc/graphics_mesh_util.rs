// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMeshTestsExt.cpp
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMeshConditionalTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Shared by the DGC mesh shading groups: `makeGraphicsPipeline` with a task, a mesh and a
// fragment module (no vertex input and no input assembly state, as the framework passes none without a vertex module).

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::make_rect_2d;
use crate::vk::ref_util::Unique;

#[derive(Clone, Copy)]
pub(super) struct MeshStages {
    pub task: Option<vk::ShaderModule>,
    pub mesh: vk::ShaderModule,
    pub frag: Option<vk::ShaderModule>,
}

/// What `build_mesh_pipeline` varies.
#[derive(Clone, Copy, Default)]
pub(super) struct MeshPipelineOptions {
    /// The DGC indirect bindable flag, through `VkPipelineCreateFlags2CreateInfo`.
    pub indirect_bindable: bool,
    /// `rasterizerDiscardEnable` of the rasterization state.
    pub rasterizer_discard: bool,
    /// The three graphics pipeline library parts used by mesh shading (pre-rasterization, fragment shader, fragment output) linked with
    /// the fast flavour, instead of one monolithic pipeline.
    pub fast_linked: bool,
    /// The same libraries built with the retain-link-time-optimization-info flag and linked with link time optimization.
    pub link_time_optimized: bool,
}

/// A pipeline and the libraries it was linked from (they must outlive it).
pub(super) struct MeshPipeline<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    _libraries: Vec<Unique<'a, vk::Pipeline>>,
}

impl std::ops::Deref for MeshPipeline<'_> {
    type Target = vk::Pipeline;

    fn deref(&self) -> &vk::Pipeline {
        &self.pipeline
    }
}

/// A render pass with one subpass and no attachment.
pub(super) fn make_empty_render_pass(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// A monolithic mesh shading pipeline over a `extent` sized target (see `build_mesh_pipeline`).
pub(super) fn make_mesh_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &MeshStages,
    extent: (u32, u32),
    indirect_bindable: bool,
) -> Result<MeshPipeline<'a>, TestError> {
    build_mesh_pipeline(
        device,
        pipeline_layout,
        render_pass,
        stages,
        extent,
        &MeshPipelineOptions {
            indirect_bindable,
            ..Default::default()
        },
    )
}

/// A mesh shading pipeline over a `extent` sized target. The colour blend state has one attachment when there is a fragment module and
/// none otherwise (the render pass then has no attachment).
pub(super) fn build_mesh_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &MeshStages,
    extent: (u32, u32),
    options: &MeshPipelineOptions,
) -> Result<MeshPipeline<'a>, TestError> {
    let entry = c"main";
    let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(stage)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build()
    };
    let mut pre_rasterization_stages = Vec::with_capacity(2);
    if let Some(module) = stages.task {
        pre_rasterization_stages.push(make_stage(vk::ShaderStageFlags::TASK_EXT, module));
    }
    pre_rasterization_stages.push(make_stage(vk::ShaderStageFlags::MESH_EXT, stages.mesh));
    let mut fragment_stages = Vec::with_capacity(1);
    if let Some(module) = stages.frag {
        fragment_stages.push(make_stage(vk::ShaderStageFlags::FRAGMENT, module));
    }
    let mut shader_stages = pre_rasterization_stages.clone();
    shader_stages.extend_from_slice(&fragment_stages);

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: extent.0 as f32,
        height: extent.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, extent.0, extent.1)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(options.rasterizer_discard)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(1.0);
    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::NEVER)
        .build();
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);
    let blend_attachment = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .src_color_blend_factor(vk::BlendFactor::ZERO)
        .dst_color_blend_factor(vk::BlendFactor::ZERO)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ZERO)
        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(
            vk::ColorComponentFlags::R
                | vk::ColorComponentFlags::G
                | vk::ColorComponentFlags::B
                | vk::ColorComponentFlags::A,
        )
        .build();
    let blend_attachments: &[vk::PipelineColorBlendAttachmentState] = if stages.frag.is_some() {
        std::slice::from_ref(&blend_attachment)
    } else {
        &[]
    };
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(blend_attachments)
        .blend_constants([0.0; 4]);

    let flags2_info = vk::PipelineCreateFlags2CreateInfo {
        flags: vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT,
        ..Default::default()
    };

    if options.fast_linked || options.link_time_optimized {
        let mut library_flags = vk::PipelineCreateFlags::LIBRARY_KHR;
        if options.link_time_optimized {
            library_flags |= vk::PipelineCreateFlags::RETAIN_LINK_TIME_OPTIMIZATION_INFO_EXT;
        }
        let create_library =
            |library: vk::GraphicsPipelineLibraryFlagsEXT| -> Result<Unique<'a, vk::Pipeline>, TestError> {
                let library_info = vk::GraphicsPipelineLibraryCreateInfoEXT {
                    flags: library,
                    ..Default::default()
                };
                let mut flags2 = flags2_info;
                flags2.next = (&library_info as *const vk::GraphicsPipelineLibraryCreateInfoEXT).cast();

                let mut info = vk::GraphicsPipelineCreateInfo::builder()
                    .flags(library_flags)
                    .layout(pipeline_layout)
                    .base_pipeline_index(0);
                if library == vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS {
                    info = info
                        .stages(&pre_rasterization_stages)
                        .viewport_state(&viewport_state)
                        .rasterization_state(&rasterization)
                        .render_pass(render_pass)
                        .subpass(0);
                } else if library == vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_SHADER {
                    info = info
                        .stages(&fragment_stages)
                        .depth_stencil_state(&depth_stencil)
                        .multisample_state(&multisample)
                        .render_pass(render_pass)
                        .subpass(0);
                } else {
                    info = info
                        .multisample_state(&multisample)
                        .color_blend_state(&color_blend)
                        .render_pass(render_pass)
                        .subpass(0);
                }
                let mut info = info.build();
                info.next = if options.indirect_bindable {
                    (&flags2 as *const vk::PipelineCreateFlags2CreateInfo).cast()
                } else {
                    (&library_info as *const vk::GraphicsPipelineLibraryCreateInfoEXT).cast()
                };
                let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
                    .vk_check("vkCreateGraphicsPipelines")?;
                Ok(Unique::new(device, pipelines.0[0]))
            };

        let libraries = vec![
            create_library(vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS)?,
            create_library(vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_SHADER)?,
            create_library(vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_OUTPUT_INTERFACE)?,
        ];
        let handles: Vec<vk::Pipeline> = libraries.iter().map(|library| **library).collect();
        let link_info = vk::PipelineLibraryCreateInfoKHR::builder().libraries(&handles).build();
        let mut flags2_link = flags2_info;
        flags2_link.next = (&link_info as *const vk::PipelineLibraryCreateInfoKHR).cast();

        let link_flags = if options.link_time_optimized {
            vk::PipelineCreateFlags::LINK_TIME_OPTIMIZATION_EXT
        } else {
            vk::PipelineCreateFlags::empty()
        };
        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .flags(link_flags)
            .layout(pipeline_layout)
            .base_pipeline_index(0)
            .build();
        info.next = if options.indirect_bindable {
            (&flags2_link as *const vk::PipelineCreateFlags2CreateInfo).cast()
        } else {
            (&link_info as *const vk::PipelineLibraryCreateInfoKHR).cast()
        };
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        return Ok(MeshPipeline {
            pipeline: Unique::new(device, pipelines.0[0]),
            _libraries: libraries,
        });
    }

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&shader_stages)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0)
        .build();
    if options.indirect_bindable {
        info.next = (&flags2_info as *const vk::PipelineCreateFlags2CreateInfo).cast();
    }
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(MeshPipeline {
        pipeline: Unique::new(device, pipelines.0[0]),
        _libraries: Vec::new(),
    })
}

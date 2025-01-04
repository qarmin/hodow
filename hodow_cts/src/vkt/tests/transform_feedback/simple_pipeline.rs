// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackSimpleTests.cpp (`makeGraphicsPipeline`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Mobica Limited.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The general form of the pipeline helper, with every stage optional: the
// `simple_tests.rs` ones are the vertex-only specialisations the first ported test types needed. The construction type is the one
// `construction.rs` makes ambient while a case of the `simple_*_gpl` groups runs.

use std::ffi::c_void;

use vulkanalia::Device;
use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::make_rect_2d;
use crate::vk::pipeline_construction::{PipelineConstructionType, PipelineParts, create_linked_pipeline};
use crate::vk::ref_util::Unique;

/// The shader modules of one pipeline; a missing module is a stage the pipeline does not have (`ShaderWrapper()` upstream).
#[derive(Clone, Copy, Default)]
pub(super) struct XfbStages {
    pub vert: vk::ShaderModule,
    pub tesc: Option<vk::ShaderModule>,
    pub tese: Option<vk::ShaderModule>,
    pub geom: Option<vk::ShaderModule>,
    pub frag: Option<vk::ShaderModule>,
}

/// The defaulted trailing parameters of upstream's `makeGraphicsPipeline`.
#[derive(Clone, Copy)]
pub(super) struct XfbPipelineOptions<'a> {
    /// `rasterizationStreamPtr`; `None` leaves the rasterization state at its default (no stream chained).
    pub rasterization_stream: Option<u32>,
    pub topology: vk::PrimitiveTopology,
    /// `inputVertices`: the vertex input state is the one `vertex_input` carries instead of an empty one.
    pub vertex_input: Option<&'a vk::PipelineVertexInputStateCreateInfo>,
    pub depth_clip_control: bool,
    pub attachment_count: u32,
}

impl Default for XfbPipelineOptions<'_> {
    fn default() -> Self {
        Self {
            rasterization_stream: None,
            topology: vk::PrimitiveTopology::POINT_LIST,
            vertex_input: None,
            depth_clip_control: false,
            attachment_count: 0,
        }
    }
}

/// `makeGraphicsPipeline`
pub(super) fn make_xfb_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &XfbStages,
    render_size: (u32, u32),
    subpass: u32,
    options: &XfbPipelineOptions<'_>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: render_size.0 as f32,
        height: render_size.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, render_size.0, render_size.1)];

    let depth_clip_control_info = vk::PipelineViewportDepthClipControlCreateInfoEXT {
        s_type: vk::StructureType::PIPELINE_VIEWPORT_DEPTH_CLIP_CONTROL_CREATE_INFO_EXT,
        next: std::ptr::null(),
        negative_one_to_one: vk::TRUE,
    };
    let mut viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors)
        .build();
    if options.depth_clip_control {
        viewport_state.next =
            (&depth_clip_control_info as *const vk::PipelineViewportDepthClipControlCreateInfoEXT).cast::<c_void>();
    }

    let empty_vertex_input = vk::PipelineVertexInputStateCreateInfo::default();
    let vertex_input = options.vertex_input.unwrap_or(&empty_vertex_input);

    let disable_rasterization = stages.frag.is_none();
    let stream_info = vk::PipelineRasterizationStateStreamCreateInfoEXT {
        s_type: vk::StructureType::PIPELINE_RASTERIZATION_STATE_STREAM_CREATE_INFO_EXT,
        next: std::ptr::null(),
        flags: vk::PipelineRasterizationStateStreamCreateFlagsEXT::empty(),
        rasterization_stream: options.rasterization_stream.unwrap_or(0),
    };
    let stream_chain: *const c_void = if options.rasterization_stream.is_some() {
        (&stream_info as *const vk::PipelineRasterizationStateStreamCreateInfoEXT).cast::<c_void>()
    } else {
        std::ptr::null()
    };
    let rasterization = vk::PipelineRasterizationStateCreateInfo {
        s_type: vk::StructureType::PIPELINE_RASTERIZATION_STATE_CREATE_INFO,
        next: stream_chain,
        flags: vk::PipelineRasterizationStateCreateFlags::empty(),
        depth_clamp_enable: vk::FALSE,
        rasterizer_discard_enable: disable_rasterization as vk::Bool32,
        polygon_mode: vk::PolygonMode::FILL,
        cull_mode: vk::CullModeFlags::NONE,
        front_face: vk::FrontFace::COUNTER_CLOCKWISE,
        depth_bias_enable: vk::FALSE,
        depth_bias_constant_factor: 0.0,
        depth_bias_clamp: 0.0,
        depth_bias_slope_factor: 0.0,
        line_width: 1.0,
    };

    let attachment_state = vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::FALSE,
        src_color_blend_factor: vk::BlendFactor::ZERO,
        dst_color_blend_factor: vk::BlendFactor::ZERO,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ZERO,
        dst_alpha_blend_factor: vk::BlendFactor::ZERO,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::R
            | vk::ColorComponentFlags::G
            | vk::ColorComponentFlags::B
            | vk::ColorComponentFlags::A,
    };
    let attachment_states = vec![attachment_state; options.attachment_count as usize];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&attachment_states);

    let entry = c"main";
    let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(stage)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build()
    };
    let mut stage_infos = vec![make_stage(vk::ShaderStageFlags::VERTEX, stages.vert)];
    if let Some(module) = stages.tesc {
        stage_infos.push(make_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, module));
    }
    if let Some(module) = stages.tese {
        stage_infos.push(make_stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, module));
    }
    if let Some(module) = stages.geom {
        stage_infos.push(make_stage(vk::ShaderStageFlags::GEOMETRY, module));
    }
    if let Some(module) = stages.frag {
        stage_infos.push(make_stage(vk::ShaderStageFlags::FRAGMENT, module));
    }

    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(options.topology);
    let tessellation = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(3);
    let has_tessellation = stages.tesc.is_some() || stages.tese.is_some();
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::default();

    let construction = super::construction::ambient_construction_type();
    if construction != PipelineConstructionType::Monolithic {
        let parts = PipelineParts {
            flags: vk::PipelineCreateFlags::empty(),
            layout: pipeline_layout,
            render_pass,
            subpass,
            stages: &stage_infos,
            vertex_input,
            input_assembly: &input_assembly,
            tessellation: has_tessellation.then_some(&tessellation),
            viewport: &viewport_state,
            rasterization: &rasterization,
            multisample: &multisample,
            depth_stencil: &depth_stencil,
            color_blend: Some(&color_blend),
            dynamic: None,
            rendering: None,
            fragment_shading_rate: None,
        };
        return create_linked_pipeline(device, construction, &parts);
    }

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stage_infos)
        .vertex_input_state(vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(subpass);
    if has_tessellation {
        info = info.tessellation_state(&tessellation);
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

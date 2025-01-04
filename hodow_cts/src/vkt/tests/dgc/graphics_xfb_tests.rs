// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsXfbTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_xfb.toml` (`scripts/gen_dgc_xfb_manifest.py`), one
// shared set per (tessellation, geometry) combination.
//
// Two quads are drawn by two generated draw sequences with transform feedback active (the last pre-rasterization stage writes the
// positions), then drawn again with vkCmdDrawIndirectByteCountEXT from the captured vertices. Both colour targets and the captured triangles
// are verified.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands,
    ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::dgc_xfb::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, ProgramBinary, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    bind_shader_object_state, bind_shaders_with_nulls, copy_image_to_buffer, float_threshold_compare, push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt, check_dgc_ext_support,
};
use crate::vkt::tests::draw::util::{ImageWithBuffer, begin_rendering, clear_value_color, end_rendering};
use crate::vkt::tests::shader_object::util::{
    ShaderObject, create_shader, get_shader_object_next_stages, shader_create_info,
};
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

#[derive(Clone, Copy)]
struct Params {
    discard_xfb: bool,
    use_geom: bool,
    use_tess: bool,
    use_shader_objects: bool,
}

impl Params {
    fn shader_stages(&self) -> vk::ShaderStageFlags {
        let mut stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        if self.use_geom {
            stages |= vk::ShaderStageFlags::GEOMETRY;
        }
        if self.use_tess {
            stages |= vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION;
        }
        stages
    }

    fn program_name(&self) -> &'static str {
        match (self.use_tess, self.use_geom) {
            (false, false) => "xfb",
            (false, true) => "xfb_geom",
            (true, false) => "xfb_tess",
            (true, true) => "xfb_tess_geom",
        }
    }
}

struct XfbCase {
    name: String,
    params: Params,
}

impl TestCase for XfbCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `XfbTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_dgc_ext_support(
            context,
            self.params.shader_stages(),
            vk::ShaderStageFlags::empty(),
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            true,
        )?;

        {
            let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut xfb_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if xfb_features.transform_feedback == vk::FALSE {
                return Err(TestError::NotSupported("transformFeedback not supported".to_string()));
            }

            let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if xfb_properties.transform_feedback_draw == vk::FALSE {
                return Err(TestError::NotSupported(
                    "transformFeedbackDraw not supported".to_string(),
                ));
            }
        }

        if self.params.use_shader_objects {
            context.require_device_functionality("VK_EXT_shader_object")?;
        }
        if self.params.use_geom && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("geometryShader not supported".to_string()));
        }
        if self.params.use_tess && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("tessellationShader not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = self.params.program_name();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(XfbInstance {
            context,
            params: self.params,
        })
    }
}

struct XfbInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

/// `makeShader` of the upstream file: a SPIR-V shader object without the indirect bindable flag.
fn make_shader<'a>(
    device: &'a Device,
    stage: vk::ShaderStageFlags,
    binary: &ProgramBinary,
    tessellation_feature: bool,
    geometry_feature: bool,
) -> Result<ShaderObject<'a>, TestError> {
    let create_info = shader_create_info(
        vk::ShaderCreateFlagsEXT::empty(),
        stage,
        get_shader_object_next_stages(stage, tessellation_feature, geometry_feature),
        vk::ShaderCodeTypeEXT::SPIRV,
        std::mem::size_of_val(binary.spirv),
        binary.spirv.as_ptr().cast(),
        &[],
        &[],
    );
    create_shader(device, &create_info)
}

/// The render pass the `makeRenderPass` of the framework builds for a colour format, or one without attachments for an undefined format
/// (load op LOAD, everything in COLOR_ATTACHMENT_OPTIMAL).
fn make_xfb_render_pass(device: &Device, color_format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    if color_format != vk::Format::UNDEFINED {
        return crate::vkt::tests::draw::util::make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::LOAD,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );
    }
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

struct PipelineStages {
    vert: vk::ShaderModule,
    tesc: Option<vk::ShaderModule>,
    tese: Option<vk::ShaderModule>,
    geom: Option<vk::ShaderModule>,
    frag: Option<vk::ShaderModule>,
}

/// `makeGraphicsPipeline` with a vertex input of one `Vec4` at location 0, a fixed viewport and scissor, and the given rasterization
/// discard state. The colour blend state is only given when rasterization is not discarded.
fn make_xfb_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &PipelineStages,
    extent: (u32, u32),
    topology: vk::PrimitiveTopology,
    patch_control_points: u32,
    rasterizer_discard: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry = c"main";
    let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(stage)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build()
    };
    let mut shader_stages = vec![make_stage(vk::ShaderStageFlags::VERTEX, stages.vert)];
    if let Some(module) = stages.tesc {
        shader_stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, module));
    }
    if let Some(module) = stages.tese {
        shader_stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, module));
    }
    if let Some(module) = stages.geom {
        shader_stages.push(make_stage(vk::ShaderStageFlags::GEOMETRY, module));
    }
    if let Some(module) = stages.frag {
        shader_stages.push(make_stage(vk::ShaderStageFlags::FRAGMENT, module));
    }

    let bindings = [vk::VertexInputBindingDescription::builder()
        .binding(0)
        .stride(std::mem::size_of::<Vec4>() as u32)
        .input_rate(vk::VertexInputRate::VERTEX)
        .build()];
    let attributes = [vk::VertexInputAttributeDescription::builder()
        .location(0)
        .binding(0)
        .format(vk::Format::R32G32B32A32_SFLOAT)
        .offset(0)
        .build()];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);
    let tessellation = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(patch_control_points);
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
        .rasterizer_discard_enable(rasterizer_discard)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(1.0);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
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
        .build()];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&blend_attachments)
        .blend_constants([0.0; 4]);

    let mut builder = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&shader_stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);
    if stages.tesc.is_some() && stages.tese.is_some() {
        builder = builder.tessellation_state(&tessellation);
    }
    if !rasterizer_discard {
        builder = builder.color_blend_state(&color_blend);
    }
    let info = builder.build();
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn sorted_triangle(triangle: [Vec4; 3]) -> Vec<Vec4> {
    let mut vertices = triangle.to_vec();
    vertices.sort_by(|a, b| a.partial_cmp(b).unwrap_or(std::cmp::Ordering::Equal));
    vertices.dedup();
    vertices
}

/// `verifyTriangle`: the same vertices in any order.
fn verify_triangle(a: [Vec4; 3], b: [Vec4; 3]) -> bool {
    sorted_triangle(a) == sorted_triangle(b)
}

impl TestInstance for XfbInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = (8u32, 8u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let per_draw_vertices = if params.use_tess { 6u32 } else { 4u32 };
        let per_draw_triangles = 2u32;
        let per_triangle_vertices = 3u32;
        let draw_count = 2u32;
        let input_vertex_count = per_draw_vertices * draw_count;
        let output_triangle_count = per_draw_triangles * draw_count;
        let output_vertex_count = per_triangle_vertices * output_triangle_count;
        let xfb_topology = if params.use_tess {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_STRIP
        };
        let indirect_draw_topology = if params.use_tess {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let shader_stages = params.shader_stages();

        // Vertices using 2 half-screen quads.
        let mut vertices: Vec<Vec4> = Vec::with_capacity(input_vertex_count as usize);
        if params.use_tess {
            // Patch list in this case, which works as a triangle list with the passthrough shaders.
            vertices.extend_from_slice(&[
                // First patches.
                [-1.0, -1.0, 0.0, 1.0],
                [-1.0, 0.0, 0.0, 1.0],
                [1.0, -1.0, 0.0, 1.0],
                [1.0, -1.0, 0.0, 1.0],
                [-1.0, 0.0, 0.0, 1.0],
                [1.0, 0.0, 0.0, 1.0],
                // Second patches.
                [-1.0, 0.0, 0.0, 1.0],
                [-1.0, 1.0, 0.0, 1.0],
                [1.0, 0.0, 0.0, 1.0],
                [1.0, 0.0, 0.0, 1.0],
                [-1.0, 1.0, 0.0, 1.0],
                [1.0, 1.0, 0.0, 1.0],
            ]);
        } else {
            vertices.extend_from_slice(&[
                // First strip.
                [-1.0, -1.0, 0.0, 1.0],
                [-1.0, 0.0, 0.0, 1.0],
                [1.0, -1.0, 0.0, 1.0],
                [1.0, 0.0, 0.0, 1.0],
                // Second strip.
                [-1.0, 0.0, 0.0, 1.0],
                [-1.0, 1.0, 0.0, 1.0],
                [1.0, 0.0, 0.0, 1.0],
                [1.0, 1.0, 0.0, 1.0],
            ]);
        }

        let vertex_buffer_size = std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = vertex_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    vertex_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Color buffer for the indirect draw without XFB.
        let color_draw_buffer = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, color_format, color_usage, 4)?;
        // Color buffer for the intermediate draw with XFB on.
        let color_xfb_buffer = if params.discard_xfb {
            None
        } else {
            Some(ImageWithBuffer::new(
                context,
                fb_extent.0,
                fb_extent.1,
                color_format,
                color_usage,
                4,
            )?)
        };

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let tessellation_feature = context.get_device_features().tessellation_shader != vk::FALSE;
        let geometry_feature = context.get_device_features().geometry_shader != vk::FALSE;

        // Render passes and framebuffers in usage order.
        let xfb_format = if params.discard_xfb {
            vk::Format::UNDEFINED
        } else {
            color_format
        };
        let xfb_image_view = color_xfb_buffer
            .as_ref()
            .map_or(vk::ImageView::null(), |buffer| *buffer.view);

        let mut render_passes = Vec::new();
        let mut frame_buffers = Vec::new();
        if !params.use_shader_objects {
            render_passes.push(make_xfb_render_pass(device, xfb_format)?);
            render_passes.push(make_xfb_render_pass(device, color_format)?);
            let xfb_attachments: Vec<vk::ImageView> = if xfb_image_view == vk::ImageView::null() {
                Vec::new()
            } else {
                vec![xfb_image_view]
            };
            frame_buffers.push(make_framebuffer(
                device,
                *render_passes[0],
                &xfb_attachments,
                fb_extent.0,
                fb_extent.1,
                1,
            )?);
            frame_buffers.push(make_framebuffer(
                device,
                *render_passes[1],
                &[*color_draw_buffer.view],
                fb_extent.0,
                fb_extent.1,
                1,
            )?);
        }

        let patch_control_points = if params.use_tess { per_triangle_vertices } else { 0 };

        let mut shader_handles: Vec<vk::ShaderEXT> = Vec::with_capacity(5);
        let mut vert_shader = None;
        let mut frag_shader = None;
        let mut tesc_shader = None;
        let mut tese_shader = None;
        let mut geom_shader = None;
        let mut pipelines = Vec::new();

        let mut vert_module = None;
        let mut frag_module = None;
        let mut tesc_module = None;
        let mut tese_module = None;
        let mut geom_module = None;

        // Shaders, modules and pipelines.
        if params.use_shader_objects {
            let vert_binary = binaries.get("vert")?;
            let frag_binary = binaries.get("frag")?;
            let shader = make_shader(
                device,
                vk::ShaderStageFlags::VERTEX,
                &vert_binary,
                tessellation_feature,
                geometry_feature,
            )?;
            shader_handles.push(shader.get());
            vert_shader = Some(shader);
            let shader = make_shader(
                device,
                vk::ShaderStageFlags::FRAGMENT,
                &frag_binary,
                tessellation_feature,
                geometry_feature,
            )?;
            shader_handles.push(shader.get());
            frag_shader = Some(shader);

            if params.use_tess {
                let tesc_binary = binaries.get("tesc")?;
                let tese_binary = binaries.get("tese")?;
                let shader = make_shader(
                    device,
                    vk::ShaderStageFlags::TESSELLATION_CONTROL,
                    &tesc_binary,
                    tessellation_feature,
                    geometry_feature,
                )?;
                shader_handles.push(shader.get());
                tesc_shader = Some(shader);
                let shader = make_shader(
                    device,
                    vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                    &tese_binary,
                    tessellation_feature,
                    geometry_feature,
                )?;
                shader_handles.push(shader.get());
                tese_shader = Some(shader);
            }
            if params.use_geom {
                let geom_binary = binaries.get("geom")?;
                let shader = make_shader(
                    device,
                    vk::ShaderStageFlags::GEOMETRY,
                    &geom_binary,
                    tessellation_feature,
                    geometry_feature,
                )?;
                shader_handles.push(shader.get());
                geom_shader = Some(shader);
            }
        } else {
            vert_module = Some(create_shader_module(device, binaries.get("vert")?)?);
            frag_module = Some(create_shader_module(device, binaries.get("frag")?)?);
            if params.use_tess {
                tesc_module = Some(create_shader_module(device, binaries.get("tesc")?)?);
                tese_module = Some(create_shader_module(device, binaries.get("tese")?)?);
            }
            if params.use_geom {
                geom_module = Some(create_shader_module(device, binaries.get("geom")?)?);
            }
            let vert = **vert_module.as_ref().expect("vertex module");
            let frag = **frag_module.as_ref().expect("fragment module");
            let tesc = tesc_module.as_ref().map(|module| **module);
            let tese = tese_module.as_ref().map(|module| **module);
            let geom = geom_module.as_ref().map(|module| **module);

            // Pipeline to be used during XFB.
            pipelines.push(make_xfb_pipeline(
                device,
                *pipeline_layout,
                *render_passes[0],
                &PipelineStages {
                    vert,
                    tesc,
                    tese,
                    geom,
                    frag: if params.discard_xfb { None } else { Some(frag) },
                },
                fb_extent,
                xfb_topology,
                patch_control_points,
                params.discard_xfb,
            )?);

            // Pipeline to be used in the indirect draw. Note: frag module always present, different rasterization info.
            pipelines.push(make_xfb_pipeline(
                device,
                *pipeline_layout,
                *render_passes[1],
                &PipelineStages {
                    vert,
                    tesc,
                    tese,
                    geom,
                    frag: Some(frag),
                },
                fb_extent,
                indirect_draw_topology,
                patch_control_points,
                false,
            )?);
        }

        // Indirect commands layout.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stages,
            vk::PipelineLayout::null(),
        );
        cmds_layout_builder.add_draw_token(0);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // DGC sequences.
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..draw_count {
            let draw_cmd = vk::DrawIndirectCommand {
                vertex_count: per_draw_vertices,
                instance_count: 1,
                first_vertex: i * per_draw_vertices,
                first_instance: 0,
            };
            push_back_element(&mut dgc_data, &draw_cmd);
        }

        let dgc_data_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_data_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_data_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Preprocess buffer.
        let preprocess_pipeline = if params.use_shader_objects {
            vk::Pipeline::null()
        } else {
            *pipelines[0]
        };
        let preprocess_buffer = PreprocessBufferExt::new_with_shaders(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            draw_count,
            0,
            preprocess_pipeline,
            &shader_handles,
            0,
        )?;

        let cmds_info = if params.use_shader_objects {
            DgcGenCmdsInfo::new_with_shaders(
                shader_stages,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                draw_count,
                0,
                0,
                &shader_handles,
            )
        } else {
            DgcGenCmdsInfo::new(
                shader_stages,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                draw_count,
                0,
                0,
                preprocess_pipeline,
            )
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        let scissor = make_rect_2d(0, 0, fb_extent.0, fb_extent.1);
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let api_clear_value = clear_value_color(clear_color);

        // XFB counter buffer.
        let counter_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                std::mem::size_of::<u32>() as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFORM_FEEDBACK_COUNTER_BUFFER_EXT | vk::BufferUsageFlags::INDIRECT_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let counter_buffer_offset: vk::DeviceSize = 0;
        {
            let alloc = counter_buffer.get_allocation();
            // SAFETY: the buffer holds 4 bytes.
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, std::mem::size_of::<u32>()) };
            flush_alloc(device, alloc)?;
        }

        // XFB buffer.
        let xfb_buffer_size = (std::mem::size_of::<Vec4>() as u32 * output_vertex_count) as vk::DeviceSize;
        let xfb_buffer_offset: vk::DeviceSize = 0;
        let xfb_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                xfb_buffer_size,
                vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT | vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = xfb_buffer.get_allocation();
            // SAFETY: the buffer was created with this size.
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, xfb_buffer_size as usize) };
            flush_alloc(device, alloc)?;
        }

        let vertex_bindings = [vk::VertexInputBindingDescription2EXT {
            binding: 0,
            stride: std::mem::size_of::<Vec4>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
            divisor: 1,
            ..Default::default()
        }];
        let vertex_attributes = [vk::VertexInputAttributeDescription2EXT {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
            ..Default::default()
        }];
        let given_shaders: Vec<(vk::ShaderStageFlags, vk::ShaderEXT)> = {
            let mut given = Vec::new();
            if let Some(shader) = &vert_shader {
                given.push((vk::ShaderStageFlags::VERTEX, shader.get()));
            }
            if let Some(shader) = &frag_shader {
                given.push((vk::ShaderStageFlags::FRAGMENT, shader.get()));
            }
            if let Some(shader) = &tesc_shader {
                given.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, shader.get()));
            }
            if let Some(shader) = &tese_shader {
                given.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, shader.get()));
            }
            if let Some(shader) = &geom_shader {
                given.push((vk::ShaderStageFlags::GEOMETRY, shader.get()));
            }
            given
        };

        begin_command_buffer(device, cmd_buffer)?;

        // Clear and prepare color buffers.
        {
            let color_att_access = vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
            let images: Vec<vk::Image> = std::iter::once(color_draw_buffer.image.get())
                .chain(color_xfb_buffer.as_ref().map(|buffer| buffer.image.get()))
                .collect();

            let pre_clear_barriers: Vec<vk::ImageMemoryBarrier> = images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        *image,
                        color_srr,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_clear_barriers,
                );
                for image in &images {
                    device.cmd_clear_color_image(
                        cmd_buffer,
                        *image,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &vk::ClearColorValue { float32: clear_color },
                        &[color_srr],
                    );
                }
            }

            let post_clear_barriers: Vec<vk::ImageMemoryBarrier> = images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        color_att_access,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        *image,
                        color_srr,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &post_clear_barriers,
                );
            }
        }

        unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]) };

        if params.use_shader_objects {
            begin_rendering(
                device,
                cmd_buffer,
                xfb_image_view,
                scissor,
                api_clear_value,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
            bind_shaders_with_nulls(context, cmd_buffer, &given_shaders);
            bind_shader_object_state(
                context,
                cmd_buffer,
                xfb_topology,
                patch_control_points,
                fb_extent,
                Some((&vertex_bindings[..], &vertex_attributes[..])),
            );
            unsafe { device.cmd_set_rasterizer_discard_enable_ext(cmd_buffer, params.discard_xfb) };
        } else {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_passes[0],
                *frame_buffers[0],
                scissor,
                api_clear_value,
            );
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipelines[0]) };
        }

        unsafe {
            device.cmd_bind_transform_feedback_buffers_ext(
                cmd_buffer,
                0,
                &[xfb_buffer.get()],
                &[xfb_buffer_offset],
                &[xfb_buffer_size],
            );
            let counter_handle = counter_buffer.get();
            (device.commands().cmd_begin_transform_feedback_ext)(
                cmd_buffer,
                0,
                1,
                &counter_handle,
                &counter_buffer_offset,
            );
            // Draw once for each quad.
            device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get());
            (device.commands().cmd_end_transform_feedback_ext)(
                cmd_buffer,
                0,
                1,
                &counter_handle,
                &counter_buffer_offset,
            );
        }

        if params.use_shader_objects {
            end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }

        {
            // Synchronize transform feedback writes to indirect draws.
            let barriers = [
                make_memory_barrier(
                    vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT,
                    vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_READ_EXT,
                ),
                make_memory_barrier(
                    vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
                    vk::AccessFlags::VERTEX_ATTRIBUTE_READ,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::VERTEX_INPUT | vk::PipelineStageFlags::DRAW_INDIRECT,
                    vk::DependencyFlags::empty(),
                    &barriers,
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        // Second render pass.
        if params.use_shader_objects {
            begin_rendering(
                device,
                cmd_buffer,
                *color_draw_buffer.view,
                scissor,
                api_clear_value,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
            bind_shaders_with_nulls(context, cmd_buffer, &given_shaders);
            bind_shader_object_state(
                context,
                cmd_buffer,
                indirect_draw_topology,
                patch_control_points,
                fb_extent,
                Some((&vertex_bindings[..], &vertex_attributes[..])),
            );
            unsafe { device.cmd_set_rasterizer_discard_enable_ext(cmd_buffer, false) };
        } else {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_passes[1],
                *frame_buffers[1],
                scissor,
                api_clear_value,
            );
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipelines[1]) };
        }

        // Indirect draw.
        unsafe {
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[xfb_buffer.get()], &[0]);
            device.cmd_draw_indirect_byte_count_ext(
                cmd_buffer,
                1,
                0,
                counter_buffer.get(),
                0,
                0,
                std::mem::size_of::<Vec4>() as u32,
            );
        }

        if params.use_shader_objects {
            end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }

        // Copy color buffers.
        if let Some(buffer) = &color_xfb_buffer {
            copy_image_to_buffer(
                device,
                cmd_buffer,
                buffer.image.get(),
                buffer.buffer.get(),
                fb_extent.0,
                fb_extent.1,
                1,
            );
        }
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_draw_buffer.image.get(),
            color_draw_buffer.buffer.get(),
            fb_extent.0,
            fb_extent.1,
            1,
        );

        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify color buffers.
        let geometry_color: Vec4 = [0.0, 0.0, 1.0, 1.0]; // Must match the fragment shader.
        let reference = vec![geometry_color; (fb_extent.0 * fb_extent.1) as usize];
        let threshold = [0.0f32; 4];

        let mut fail = false;
        if let Some(buffer) = &color_xfb_buffer {
            let result = buffer.read_bytes(device)?;
            if !float_threshold_compare(result, &reference, threshold) {
                log::error!("XFBDrawResult differs from the reference");
                fail = true;
            }
        }
        {
            let result = color_draw_buffer.read_bytes(device)?;
            if !float_threshold_compare(result, &reference, threshold) {
                log::error!("IndirectDrawResult differs from the reference");
                fail = true;
            }
        }

        // Verify vertex output.
        let xfb_alloc = xfb_buffer.get_allocation();
        invalidate_alloc(device, xfb_alloc)?;
        // SAFETY: the buffer holds `output_vertex_count` vectors of four floats and the device finished writing.
        let xfb_output: Vec<Vec4> = unsafe {
            std::slice::from_raw_parts(
                xfb_alloc.get_host_ptr().cast_const().cast::<Vec4>(),
                output_vertex_count as usize,
            )
        }
        .to_vec();

        let expected_xfb_output: Vec<Vec4> = if params.use_tess {
            // The output triangles come from the patch list (triangle list), so the vertices are copied directly.
            debug_assert_eq!(vertices.len() as u32, output_vertex_count);
            vertices.clone()
        } else {
            // The triangle list is built from the strips.
            [0usize, 1, 2, 2, 1, 3, 4, 5, 6, 6, 5, 7]
                .iter()
                .map(|index| vertices[*index])
                .collect()
        };

        for i in 0..output_triangle_count as usize {
            let first_vertex = i * per_triangle_vertices as usize;
            let expected = [
                expected_xfb_output[first_vertex],
                expected_xfb_output[first_vertex + 1],
                expected_xfb_output[first_vertex + 2],
            ];
            let found = [
                xfb_output[first_vertex],
                xfb_output[first_vertex + 1],
                xfb_output[first_vertex + 2],
            ];
            if !verify_triangle(expected, found) {
                log::error!("Error in output triangle {i}: expected in any order {expected:?} but found {found:?}");
                fail = true;
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected result in color buffers or vertex buffers; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCGraphicsXfbTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_graphics_xfb_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for discard_xfb in [false, true] {
        for use_geom in [false, true] {
            for use_tess in [false, true] {
                for use_shader_objects in [false, true] {
                    let name = format!(
                        "{}{}{}{}",
                        if discard_xfb { "discard" } else { "nodiscard" },
                        if use_tess { "_tess" } else { "" },
                        if use_geom { "_geom" } else { "" },
                        if use_shader_objects { "_shader_objects" } else { "" },
                    );
                    cases.push((
                        format!("ext.graphics.xfb.{name}"),
                        Box::new(XfbCase {
                            name,
                            params: Params {
                                discard_xfb,
                                use_geom,
                                use_tess,
                                use_shader_objects,
                            },
                        }) as Box<dyn TestCase>,
                    ));
                }
            }
        }
    }
    cases
}

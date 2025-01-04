// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_graphics_misc.toml` (case `mix_normal_dgc`,
// `scripts/gen_dgc_graphics_misc_manifest.py`). Only the pipeline, non-mesh flavours of `mix_normal_dgc*` are here (the `_shader_objects` and
// `_mesh` ones stay gated stubs). The pipelines have a different cull mode and depth state per use, so they are made by a builder of this file.
//
// Here: NormalDGCMixInstance: a 16x16 framebuffer in four areas; the left-to-right, top-to-bottom areas alternate normal point draws (depth
// test LESS, back face culling) and DGC triangle strip draws (no depth test, front face culling), one execute per DGC area.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtDeviceGeneratedCommandsExtensionDeviceCommands;

use crate::generated::shaders::dgc_graphics_misc::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, end_render_pass, make_rect_2d};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{copy_image_to_buffer, float_threshold_compare, push_back_element};
use crate::vkt::tests::dgc::graphics_misc_tests::{DepthTarget, make_color_depth_render_pass, write_buffer_bytes};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

#[derive(Clone, Copy)]
struct Params {
    preprocess: bool,
    use_execution_set: bool,
    use_vbo_token: bool,
}

struct MixCase {
    name: String,
    params: Params,
}

impl TestCase for MixCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `NormalDGCMixCase::checkSupport` (pipelines, no mesh)
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stages = vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::VERTEX;
        let bind_stages = if self.params.use_execution_set {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        check_dgc_ext_support(
            context,
            stages,
            bind_stages,
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "mix_normal_dgc")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MixInstance {
            context,
            params: self.params,
        })
    }
}

struct MixInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

#[allow(clippy::too_many_arguments)]
pub(super) fn make_mix_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    extent: u32,
    topology: vk::PrimitiveTopology,
    cull_mode: vk::CullModeFlags,
    depth_test: bool,
    depth_compare: vk::CompareOp,
    dynamic_stride: bool,
    indirect_bindable: bool,
    dynamic_vertex_input: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry = c"main";
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vert)
            .name(entry.to_bytes_with_nul())
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(frag)
            .name(entry.to_bytes_with_nul())
            .build(),
    ];
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
    // With the vertex input as dynamic state the static one is empty.
    let vertex_input = if dynamic_vertex_input {
        vk::PipelineVertexInputStateCreateInfo::builder()
    } else {
        vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes)
    };
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: extent as f32,
        height: extent as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, extent, extent)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(cull_mode)
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
        .compare_mask(0xFF)
        .write_mask(0xFF)
        .reference(0)
        .build();
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(depth_test)
        .depth_write_enable(depth_test)
        .depth_compare_op(depth_compare)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(
            vk::ColorComponentFlags::R
                | vk::ColorComponentFlags::G
                | vk::ColorComponentFlags::B
                | vk::ColorComponentFlags::A,
        )
        .build()];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .attachments(&blend_attachments)
        .blend_constants([0.0; 4]);
    let mut dynamic_states: Vec<vk::DynamicState> = Vec::new();
    if dynamic_vertex_input {
        dynamic_states.push(vk::DynamicState::VERTEX_INPUT_EXT);
    }
    if dynamic_stride {
        dynamic_states.push(vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE);
    }
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let flags2_info = vk::PipelineCreateFlags2CreateInfo {
        flags: vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT,
        ..Default::default()
    };

    let mut builder = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);
    if !dynamic_states.is_empty() {
        builder = builder.dynamic_state(&dynamic_state);
    }
    let mut info = builder.build();
    if indirect_bindable {
        info.next = (&flags2_info as *const vk::PipelineCreateFlags2CreateInfo).cast();
    }
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

impl TestInstance for MixInstance<'_> {
    /// `NormalDGCMixInstance::iterate` (pipelines, no mesh)
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let depth_format = vk::Format::D16_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::TRANSFER_SRC;
        let depth_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
        let fb_extent = 16u32;
        let height_areas = 2u32;
        let width_areas = 2u32;
        let total_areas = height_areas * width_areas;
        let dgc_per_area_vertices = 4u32; // One for each corner.
        let normal_depth = 0.0f32;
        let dgc_depth = 1.0f32;
        let vertex_size = std::mem::size_of::<Vec4>() as u32;
        let shader_stages = vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::VERTEX;

        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, color_format, color_usage, 4)?;
        let depth_buffer = DepthTarget::new(context, fb_extent, fb_extent, depth_format, depth_usage)?;

        // Normal draws will draw one point per pixel, while DGC draws will use triangle strips covering each quadrant. We'll cover 4
        // quadrants from top to bottom and, in each row, from left to right alternating normal draw and DGC. Note we must store vertices
        // quad by quad, not exactly row by row.
        let area_offsets: [Vec4; 4] = [
            [-1.0, -1.0, 0.0, 0.0],
            [0.0, -1.0, 0.0, 0.0],
            [-1.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
        ];
        let area_extent = fb_extent / width_areas;
        let mut normal_vertices: Vec<Vec4> = Vec::with_capacity((fb_extent * fb_extent) as usize);
        for offset in &area_offsets {
            for y in 0..area_extent {
                for x in 0..area_extent {
                    let x_center = (x as f32 + 0.5) / area_extent as f32 + offset[0];
                    let y_center = (y as f32 + 0.5) / area_extent as f32 + offset[1];
                    normal_vertices.push([x_center, y_center, normal_depth, 1.0]);
                }
            }
        }
        let normal_vertex_buffer_size = std::mem::size_of_val(normal_vertices.as_slice()) as vk::DeviceSize;
        let normal_vertex_buffer = DgcBuffer::new(
            context,
            normal_vertex_buffer_size,
            vk::BufferUsageFlags::VERTEX_BUFFER,
            MemoryRequirement::HOST_VISIBLE,
        )?;
        // SAFETY: a Vec4 slice viewed as bytes.
        let normal_bytes = unsafe {
            std::slice::from_raw_parts(
                normal_vertices.as_ptr().cast::<u8>(),
                normal_vertex_buffer_size as usize,
            )
        };
        write_buffer_bytes(device, normal_vertex_buffer.get_allocation(), normal_bytes)?;

        // Note: clockwise in each quadrant.
        let dgc_vertices: Vec<Vec4> = vec![
            [-1.0, -1.0, dgc_depth, 1.0],
            [0.0, -1.0, dgc_depth, 1.0],
            [-1.0, 0.0, dgc_depth, 1.0],
            [0.0, 0.0, dgc_depth, 1.0],
            [0.0, -1.0, dgc_depth, 1.0],
            [1.0, -1.0, dgc_depth, 1.0],
            [0.0, 0.0, dgc_depth, 1.0],
            [1.0, 0.0, dgc_depth, 1.0],
            [-1.0, 0.0, dgc_depth, 1.0],
            [0.0, 0.0, dgc_depth, 1.0],
            [-1.0, 1.0, dgc_depth, 1.0],
            [0.0, 1.0, dgc_depth, 1.0],
            [0.0, 0.0, dgc_depth, 1.0],
            [1.0, 0.0, dgc_depth, 1.0],
            [0.0, 1.0, dgc_depth, 1.0],
            [1.0, 1.0, dgc_depth, 1.0],
        ];
        debug_assert_eq!(dgc_vertices.len() as u32, total_areas * dgc_per_area_vertices);

        // When not using VBO tokens, a normal buffer could be used but, to simplify things, DGC buffers can be used in all cases.
        let dgc_vertex_buffer_size = std::mem::size_of_val(dgc_vertices.as_slice()) as vk::DeviceSize;
        let dgc_vertex_buffer = DgcBuffer::new(
            context,
            dgc_vertex_buffer_size,
            vk::BufferUsageFlags::VERTEX_BUFFER,
            MemoryRequirement::HOST_VISIBLE,
        )?;
        // SAFETY: a Vec4 slice viewed as bytes.
        let dgc_vertex_bytes =
            unsafe { std::slice::from_raw_parts(dgc_vertices.as_ptr().cast::<u8>(), dgc_vertex_buffer_size as usize) };
        write_buffer_bytes(device, dgc_vertex_buffer.get_allocation(), dgc_vertex_bytes)?;

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;
        let render_pass = make_color_depth_render_pass(device, color_format, depth_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer.view, *depth_buffer.view],
            fb_extent,
            fb_extent,
            1,
        )?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let normal_pipeline = make_mix_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            fb_extent,
            vk::PrimitiveTopology::POINT_LIST,
            vk::CullModeFlags::BACK,
            true,
            vk::CompareOp::LESS,
            false,
            false,
            false,
        )?;
        let dgc_pipeline = make_mix_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            fb_extent,
            vk::PrimitiveTopology::TRIANGLE_STRIP,
            vk::CullModeFlags::FRONT,
            false,
            vk::CompareOp::NEVER,
            params.use_vbo_token,
            params.use_execution_set,
            false,
        )?;

        let ies_manager = if params.use_execution_set {
            Some(ExecutionSetManagerExt::new_pipeline(device, *dgc_pipeline, 1)?)
        } else {
            None
        };
        let ies = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        let layout_flags = if params.preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(layout_flags, shader_stages, *pipeline_layout);
        if params.use_execution_set {
            cmds_layout_builder.add_execution_set_token(
                0,
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES,
                shader_stages,
            );
        }
        if params.use_vbo_token {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_vertex_buffer_token(offset, 0);
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;
        let dgc_stride = cmds_layout_builder.get_stream_stride();

        let dgc_draw_count = total_areas / 2;

        let mut dgc_data: Vec<u32> = Vec::new();
        let dgc_vertex_buffer_area_stride = dgc_per_area_vertices * vertex_size;
        let dgc_vertex_buffer_address = dgc_vertex_buffer.get_device_address();
        for i in 0..dgc_draw_count {
            let area_index = 2 * i + 1;
            if params.use_execution_set {
                dgc_data.push(0);
            }
            if params.use_vbo_token {
                let bind_cmd = vk::BindVertexBufferIndirectCommandEXT {
                    buffer_address: dgc_vertex_buffer_address
                        + vk::DeviceAddress::from(area_index * dgc_vertex_buffer_area_stride),
                    size: dgc_vertex_buffer_area_stride,
                    stride: vertex_size,
                };
                push_back_element(&mut dgc_data, &bind_cmd);
            }
            let draw_cmd = vk::DrawIndirectCommand {
                vertex_count: dgc_per_area_vertices,
                instance_count: 1,
                first_vertex: 0, // We'll use vertex buffer offsets instead of firstVertex offsets.
                first_instance: 0,
            };
            push_back_element(&mut dgc_data, &draw_cmd);
        }
        let cmds_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let cmds_buffer = DgcBuffer::new(
            context,
            cmds_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        // SAFETY: a u32 slice viewed as bytes.
        let cmds_bytes =
            unsafe { std::slice::from_raw_parts(dgc_data.as_ptr().cast::<u8>(), cmds_buffer_size as usize) };
        write_buffer_bytes(device, cmds_buffer.get_allocation(), cmds_bytes)?;

        let preprocess_pipeline = if ies == vk::IndirectExecutionSetEXT::null() {
            *dgc_pipeline
        } else {
            vk::Pipeline::null()
        };
        let mut preprocess_buffers = Vec::new();
        for _ in 0..dgc_draw_count {
            preprocess_buffers.push(PreprocessBufferExt::new(
                context,
                ies,
                cmds_layout.get(),
                1,
                0,
                preprocess_pipeline,
                0,
            )?);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        let mut cmd_infos = Vec::new();
        for (i, preprocess_buffer) in preprocess_buffers.iter().enumerate() {
            let dgc_address = cmds_buffer.get_device_address() + vk::DeviceAddress::from(dgc_stride * i as u32);
            cmd_infos.push(DgcGenCmdsInfo::new(
                shader_stages,
                ies,
                cmds_layout.get(),
                dgc_address,
                vk::DeviceSize::from(dgc_stride),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                1,
                0,
                0,
                preprocess_pipeline,
            ));
        }

        let preprocess_cmd_buffer = if params.preprocess {
            let owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, owner.get())?;
            Some(owner)
        } else {
            None
        };

        begin_command_buffer(device, cmd_buffer)?;
        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(make_rect_2d(0, 0, fb_extent, fb_extent))
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }

        let area_pixels = area_extent * area_extent;
        let normal_vertex_buffer_area_stride = vk::DeviceSize::from(vertex_size * area_pixels);
        let bind_point = vk::PipelineBindPoint::GRAPHICS;

        for i in 0..dgc_draw_count {
            {
                let area_idx = 2 * i;
                let offset = normal_vertex_buffer_area_stride * vk::DeviceSize::from(area_idx);
                unsafe {
                    device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[normal_vertex_buffer.get()], &[offset]);
                    device.cmd_bind_pipeline(cmd_buffer, bind_point, *normal_pipeline);
                    device.cmd_draw(cmd_buffer, area_pixels, 1, 0, 0);
                }
            }
            {
                unsafe { device.cmd_bind_pipeline(cmd_buffer, bind_point, *dgc_pipeline) };
                if !params.use_vbo_token {
                    let offset = vk::DeviceSize::from(dgc_vertex_buffer_area_stride * (2 * i + 1));
                    unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[dgc_vertex_buffer.get()], &[offset]) };
                }
                let cmd_info = cmd_infos[i as usize].get();
                if let Some(preprocess_cmd_buffer) = &preprocess_cmd_buffer {
                    unsafe {
                        device.cmd_preprocess_generated_commands_ext(preprocess_cmd_buffer.get(), cmd_info, cmd_buffer)
                    };
                    preprocess_to_execute_barrier_ext(device, preprocess_cmd_buffer.get());
                }
                unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, cmd_info) };
            }
        }

        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_extent,
            fb_extent,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        if let Some(preprocess_cmd_buffer) = &preprocess_cmd_buffer {
            end_command_buffer(device, preprocess_cmd_buffer.get())?;
        }
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |owner| owner.get()),
        )?;

        let geom_color: Vec4 = [0.0, 0.0, 1.0, 1.0]; // Must match frag shader.
        let reference = vec![geom_color; (fb_extent * fb_extent) as usize];
        let result = color_buffer.read_bytes(device)?;
        if !float_threshold_compare(result, &reference, [0.0; 4]) {
            return Ok(TestStatus::fail(
                "Unexpected results found in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The pipeline, non-mesh `mix_normal_dgc*` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_mix_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for preprocess in [false, true] {
        for use_execution_set in [false, true] {
            for use_vbo_token in [false, true] {
                let name = format!(
                    "mix_normal_dgc{}{}{}",
                    if preprocess { "_preprocess" } else { "" },
                    if use_execution_set { "_with_ies" } else { "" },
                    if use_vbo_token { "_with_vbo_token" } else { "" },
                );
                cases.push((
                    format!("ext.graphics.misc.{name}"),
                    Box::new(MixCase {
                        name,
                        params: Params {
                            preprocess,
                            use_execution_set,
                            use_vbo_token,
                        },
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases
}

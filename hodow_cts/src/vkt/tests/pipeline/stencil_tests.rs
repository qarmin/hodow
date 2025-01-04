// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineStencilTests.cpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineUniqueRandomIterator.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic construction type is ported, so the pipelines come
// from `create_draw_pipeline` and the pipeline and render pass wrappers are plain Vulkan calls. The `no_stencil_att` group
// and the VK_KHR_portability_subset `separateStencilMaskRef` check are not ported.
//
// Draws four overlapping quads, each with its own stencil masks and references, with a front and a back stencil state taken
// from the cross product of the stencil ops and compare ops, and compares the colour and stencil results with a software
// rendering of the same quads.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_stencil::{STENCIL_COLOR, STENCIL_NO_COLOR};
use crate::rr::render_state::{FaceType, RenderState};
use crate::rr::renderer::Program;
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::random::Random;
use crate::tcu::texture::ChannelOrder;
use crate::tcu::vector::UVec4;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
use crate::vk::pipeline_construction::ambient_construction_type;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, create_draw_pipeline, default_depth_stencil_state, default_rasterization_state, rect_2d,
};
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorVertexShader, ReferenceRenderer, Vertex4Rgba, create_overlapping_quads,
    default_clear_value, make_color_depth_render_pass, map_vk_compare_op, map_vk_stencil_op, read_color_attachment,
    read_stencil_attachment,
};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, ShaderObjectDraw, begin_dynamic_rendering, end_dynamic_rendering,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const QUAD_COUNT: usize = 4;
const QUAD_DEPTHS: [f32; QUAD_COUNT] = [0.1, 0.0, 0.3, 0.2];
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const RENDER_SIZE: (u32, u32) = (32, 32);

/// `StencilTest::StencilStateConfig`
struct StencilStateConfig {
    front_read_mask: u32,
    front_write_mask: u32,
    front_ref: u32,
    back_read_mask: u32,
    back_write_mask: u32,
    back_ref: u32,
}

/// `StencilTest::s_stencilStateConfigs`
const STENCIL_STATE_CONFIGS: [StencilStateConfig; QUAD_COUNT] = [
    StencilStateConfig {
        front_read_mask: 0xFF,
        front_write_mask: 0xFF,
        front_ref: 0xAB,
        back_read_mask: 0xF0,
        back_write_mask: 0xFF,
        back_ref: 0xFF,
    },
    StencilStateConfig {
        front_read_mask: 0xFF,
        front_write_mask: 0xF0,
        front_ref: 0xCD,
        back_read_mask: 0xF0,
        back_write_mask: 0xF0,
        back_ref: 0xEF,
    },
    StencilStateConfig {
        front_read_mask: 0xF0,
        front_write_mask: 0x0F,
        front_ref: 0xEF,
        back_read_mask: 0xFF,
        back_write_mask: 0x0F,
        back_ref: 0xCD,
    },
    StencilStateConfig {
        front_read_mask: 0xF0,
        front_write_mask: 0x01,
        front_ref: 0xFF,
        back_read_mask: 0xFF,
        back_write_mask: 0x01,
        back_ref: 0xAB,
    },
];

const STENCIL_OPS: [vk::StencilOp; 8] = [
    vk::StencilOp::KEEP,
    vk::StencilOp::ZERO,
    vk::StencilOp::REPLACE,
    vk::StencilOp::INCREMENT_AND_CLAMP,
    vk::StencilOp::DECREMENT_AND_CLAMP,
    vk::StencilOp::INVERT,
    vk::StencilOp::INCREMENT_AND_WRAP,
    vk::StencilOp::DECREMENT_AND_WRAP,
];

const COMPARE_OPS: [vk::CompareOp; 8] = [
    vk::CompareOp::NEVER,
    vk::CompareOp::LESS,
    vk::CompareOp::EQUAL,
    vk::CompareOp::LESS_OR_EQUAL,
    vk::CompareOp::GREATER,
    vk::CompareOp::NOT_EQUAL,
    vk::CompareOp::GREATER_OR_EQUAL,
    vk::CompareOp::ALWAYS,
];

/// `StencilOpStateUniqueRandomIterator` - every cross-combination of stencil ops and compare op exactly once, in an order
/// scrambled by the seed.
struct StencilOpStateUniqueRandomIterator {
    indices: Vec<u32>,
    current_index: usize,
}

impl StencilOpStateUniqueRandomIterator {
    const STENCIL_OPS_LENGTH: u32 = 8;
    const STENCIL_OPS_LENGTH2: u32 = Self::STENCIL_OPS_LENGTH * Self::STENCIL_OPS_LENGTH;
    const STENCIL_OPS_LENGTH3: u32 = Self::STENCIL_OPS_LENGTH2 * Self::STENCIL_OPS_LENGTH;
    const COMPARE_OPS_LENGTH: u32 = 8;
    const TOTAL_STENCIL_OP_STATES: u32 = Self::STENCIL_OPS_LENGTH3 * Self::COMPARE_OPS_LENGTH;

    fn new(seed: u32) -> Self {
        // The fast way upstream takes when all the values are wanted: the sequence, then scrambled.
        let mut rnd = Random::new(seed);
        let mut indices: Vec<u32> = (0..Self::TOTAL_STENCIL_OP_STATES).collect();
        rnd.shuffle(&mut indices);

        Self {
            indices,
            current_index: 0,
        }
    }

    fn reset(&mut self) {
        self.current_index = 0;
    }

    fn next(&mut self) -> vk::StencilOpState {
        let index = self.indices[self.current_index];
        self.current_index += 1;
        Self::get_indexed_value(index)
    }

    fn get_indexed_value(index: u32) -> vk::StencilOpState {
        let stencil_compare_op_index = index / Self::STENCIL_OPS_LENGTH3;
        let stencil_compare_op_seq_index = stencil_compare_op_index * Self::STENCIL_OPS_LENGTH3;

        let stencil_depth_fail_op_index = (index - stencil_compare_op_seq_index) / Self::STENCIL_OPS_LENGTH2;
        let stencil_depth_fail_op_seq_index = stencil_depth_fail_op_index * Self::STENCIL_OPS_LENGTH2;

        let stencil_pass_op_index =
            (index - stencil_compare_op_seq_index - stencil_depth_fail_op_seq_index) / Self::STENCIL_OPS_LENGTH;
        let stencil_pass_op_seq_index = stencil_pass_op_index * Self::STENCIL_OPS_LENGTH;

        let stencil_fail_op_index =
            index - stencil_compare_op_seq_index - stencil_depth_fail_op_seq_index - stencil_pass_op_seq_index;

        vk::StencilOpState {
            fail_op: STENCIL_OPS[stencil_fail_op_index as usize],
            pass_op: STENCIL_OPS[stencil_pass_op_index as usize],
            depth_fail_op: STENCIL_OPS[stencil_depth_fail_op_index as usize],
            compare_op: COMPARE_OPS[stencil_compare_op_index as usize],
            compare_mask: 0,
            write_mask: 0,
            reference: 0,
        }
    }
}

fn is_supported_depth_stencil_format(context: &Context<'_>, format: vk::Format) -> bool {
    let format_props = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    format_props
        .optimal_tiling_features
        .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
}

#[derive(Clone, Copy)]
struct StencilParams {
    stencil_format: vk::Format,
    stencil_op_state_front: vk::StencilOpState,
    stencil_op_state_back: vk::StencilOpState,
    color_attachment_enable: bool,
    separate_depth_stencil_layouts: bool,
    use_general_layout: bool,
}

struct StencilTest {
    name: String,
    params: StencilParams,
}

impl TestCase for StencilTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !is_supported_depth_stencil_format(context, self.params.stencil_format) {
            return Err(TestError::NotSupported(format!(
                "Unsupported depth/stencil format: {:?}",
                self.params.stencil_format
            )));
        }

        if self.params.separate_depth_stencil_layouts
            && !context.is_device_functionality_supported("VK_KHR_separate_depth_stencil_layouts")
        {
            return Err(TestError::NotSupported(
                "VK_KHR_separate_depth_stencil_layouts is not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.color_attachment_enable {
            STENCIL_COLOR.programs
        } else {
            STENCIL_NO_COLOR.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StencilTestInstance {
            context,
            params: self.params,
        })
    }
}

struct StencilTestInstance<'a> {
    context: &'a Context<'a>,
    params: StencilParams,
}

impl TestInstance for StencilTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let (render_width, render_height) = RENDER_SIZE;
        let color_format = if params.color_attachment_enable {
            COLOR_FORMAT
        } else {
            vk::Format::UNDEFINED
        };
        let stencil_format = params.stencil_format;

        let color_layout = if params.use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };
        let ds_layout = if params.use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
        };

        let make_image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: render_width,
                    height: render_height,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        // Create color image
        let color_image = if params.color_attachment_enable {
            Some(ImageWithMemory::new(
                device,
                alloc,
                make_image_info(
                    COLOR_FORMAT,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                ),
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };

        // Create stencil image
        let tcu_stencil_format = map_vk_format(stencil_format)
            .ok_or_else(|| TestError::NotPorted("stencil format without a texture format".to_string()))?;
        let stencil_image = ImageWithMemory::new(
            device,
            alloc,
            make_image_info(
                stencil_format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let aspect = if tcu_stencil_format.order == ChannelOrder::DS {
            vk::ImageAspectFlags::STENCIL | vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::STENCIL
        };
        let stencil_image_subresource_range = make_image_subresource_range(aspect, 0, 1, 0, 1);

        // Create color attachment view
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_attachment_view = match &color_image {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                COLOR_FORMAT,
                color_srr,
            )?),
            None => None,
        };

        // Create stencil attachment view
        let stencil_attachment_view = make_image_view(
            device,
            stencil_image.get(),
            vk::ImageViewType::_2D,
            stencil_format,
            stencil_image_subresource_range,
        )?;

        // Create render pass
        let render_pass = make_color_depth_render_pass(
            device,
            color_format,
            stencil_format,
            vk::AttachmentLoadOp::CLEAR,
            color_layout,
            ds_layout,
            color_layout,
            ds_layout,
        )?;

        // Create framebuffer
        let mut attachment_bind_infos: Vec<vk::ImageView> = Vec::new();
        if let Some(view) = &color_attachment_view {
            attachment_bind_infos.push(**view);
        }
        attachment_bind_infos.push(*stencil_attachment_view);
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &attachment_bind_infos,
            render_width,
            render_height,
            1,
        )?;

        // Create pipeline layout
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let fragment_shader_module = if params.color_attachment_enable {
            Some(create_shader_module(device, binaries.get("color_frag")?)?)
        } else {
            None
        };

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vertex_shader_module)];
        if let Some(module) = &fragment_shader_module {
            stages.push((vk::ShaderStageFlags::FRAGMENT, **module));
        }

        // Create pipelines, with different stencil masks and refs in each quad
        let is_depth_enabled = tcu_stencil_format.order != ChannelOrder::S;
        let construction = ambient_construction_type();
        let mut graphics_pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
        let mut draw_states: Vec<DrawPipelineState> = Vec::new();

        for config in &STENCIL_STATE_CONFIGS {
            let mut front = params.stencil_op_state_front;
            let mut back = params.stencil_op_state_back;

            front.compare_mask = config.front_read_mask;
            front.write_mask = config.front_write_mask;
            front.reference = config.front_ref;

            back.compare_mask = config.back_read_mask;
            back.write_mask = config.back_write_mask;
            back.reference = config.back_ref;

            let mut depth_stencil = default_depth_stencil_state();
            depth_stencil.depth_test_enable = u32::from(is_depth_enabled);
            depth_stencil.depth_write_enable = u32::from(is_depth_enabled);
            depth_stencil.depth_compare_op = vk::CompareOp::LESS;
            depth_stencil.depth_bounds_test_enable = vk::FALSE;
            depth_stencil.stencil_test_enable = vk::TRUE;
            depth_stencil.front = front;
            depth_stencil.back = back;
            depth_stencil.min_depth_bounds = 0.0;
            depth_stencil.max_depth_bounds = 1.0;

            // Make sure rasterization is not disabled when the fragment shader is missing.
            let mut rasterization = default_rasterization_state();
            rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
            rasterization.depth_bias_enable = vk::FALSE;

            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_full_viewport(render_width, render_height);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: std::mem::size_of::<Vertex4Rgba>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![
                vk::VertexInputAttributeDescription {
                    location: 0,
                    binding: 0,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: 0,
                },
                vk::VertexInputAttributeDescription {
                    location: 1,
                    binding: 0,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: std::mem::offset_of!(Vertex4Rgba, color) as u32,
                },
            ];
            state.rasterization = rasterization;
            state.depth_stencil = depth_stencil;
            state.color_attachment_count = u32::from(params.color_attachment_enable);

            if construction.is_shader_object() {
                draw_states.push(state);
            } else {
                graphics_pipelines.push(create_draw_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    &stages,
                    &state,
                )?);
            }
        }

        let shader_object_draw = if construction.is_shader_object() {
            let fragment = if params.color_attachment_enable {
                Some(binaries.get("color_frag")?)
            } else {
                None
            };
            Some(ShaderObjectDraw::new(
                context,
                construction,
                binaries.get("color_vert")?,
                fragment,
                &[],
                &[],
            )?)
        } else {
            None
        };

        // Create vertex buffer, with the quad depths adjusted
        let mut vertices = create_overlapping_quads();
        for quad_ndx in 0..QUAD_COUNT {
            for vertex_ndx in 0..6 {
                vertices[quad_ndx * 6 + vertex_ndx].position[2] = QUAD_DEPTHS[quad_ndx];
            }
        }
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create command pool and command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let mut stencil_image_barrier_subresource_range = stencil_image_subresource_range;
        let mut new_layout = vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
        if params.separate_depth_stencil_layouts {
            stencil_image_barrier_subresource_range.aspect_mask = vk::ImageAspectFlags::STENCIL;
            new_layout = vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL;
        }
        if params.use_general_layout {
            new_layout = vk::ImageLayout::GENERAL;
        }

        let mut attachment_clear_values: Vec<vk::ClearValue> = Vec::new();
        let mut image_layout_barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();

        if let Some(image) = &color_image {
            attachment_clear_values.push(default_clear_value(COLOR_FORMAT));
            image_layout_barriers.push(
                vk::ImageMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::empty())
                    .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                    .old_layout(vk::ImageLayout::UNDEFINED)
                    .new_layout(color_layout)
                    .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .image(image.get())
                    .subresource_range(color_srr)
                    .build(),
            );
        }

        attachment_clear_values.push(default_clear_value(stencil_format));
        image_layout_barriers.push(
            vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(new_layout)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(stencil_image.get())
                .subresource_range(stencil_image_barrier_subresource_range)
                .build(),
        );

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_layout_barriers,
            );

            let quad_offset = (vertices.len() / QUAD_COUNT * std::mem::size_of::<Vertex4Rgba>()) as vk::DeviceSize;
            if let Some(shader_objects) = &shader_object_draw {
                let colors: Vec<RenderingAttachment> = match &color_attachment_view {
                    Some(view) => vec![RenderingAttachment {
                        view: **view,
                        layout: color_layout,
                        clear_value: attachment_clear_values[0],
                    }],
                    None => Vec::new(),
                };
                let ds_attachment = RenderingAttachment {
                    view: *stencil_attachment_view,
                    layout: ds_layout,
                    clear_value: *attachment_clear_values
                        .last()
                        .expect("the stencil clear value is always present"),
                };
                let depth = if is_depth_enabled { Some(ds_attachment) } else { None };
                begin_dynamic_rendering(
                    device,
                    cmd,
                    rect_2d(render_width, render_height),
                    &colors,
                    depth,
                    Some(ds_attachment),
                );
                for quad_ndx in 0..QUAD_COUNT {
                    let vertex_buffer_offset = quad_offset * quad_ndx as vk::DeviceSize;

                    shader_objects.bind(cmd, &draw_states[quad_ndx]);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                    device.cmd_draw(cmd, (vertices.len() / QUAD_COUNT) as u32, 1, 0, 0);
                }
                end_dynamic_rendering(device, cmd);
            } else {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffer)
                    .render_area(rect_2d(render_width, render_height))
                    .clear_values(&attachment_clear_values);
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

                for quad_ndx in 0..QUAD_COUNT {
                    let vertex_buffer_offset = quad_offset * quad_ndx as vk::DeviceSize;

                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines[quad_ndx]);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                    device.cmd_draw(cmd, (vertices.len() / QUAD_COUNT) as u32, 1, 0, 0);
                }

                device.cmd_end_render_pass(cmd);
            }
        }
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify the image
        let tcu_color_format = map_vk_format(COLOR_FORMAT).expect("RGBA8 has a texture format");
        let vertex_shader = ColorVertexShader::new();
        let fragment_shader = ColorFragmentShader::new(tcu_color_format, Some(tcu_stencil_format), false);
        let program = Program {
            vertex_shader: &vertex_shader,
            fragment_shader: &fragment_shader,
            geometry_shader: None,
        };
        let mut ref_renderer =
            ReferenceRenderer::new(render_width, render_height, tcu_color_format, Some(tcu_stencil_format))?;

        // Render reference image
        {
            // Set depth state
            let mut render_state = RenderState::new(
                ref_renderer.get_viewport_state(),
                context.get_device_properties().limits.sub_pixel_precision_bits as i32,
            );

            render_state.frag_ops.depth_test_enabled = true;
            render_state.frag_ops.depth_func = map_vk_compare_op(vk::CompareOp::LESS);
            render_state.frag_ops.stencil_test_enabled = true;

            for (face, state) in [
                (FaceType::Front, &params.stencil_op_state_front),
                (FaceType::Back, &params.stencil_op_state_back),
            ] {
                let ref_stencil = &mut render_state.frag_ops.stencil_states[face as usize];
                ref_stencil.s_fail = map_vk_stencil_op(state.fail_op);
                ref_stencil.dp_fail = map_vk_stencil_op(state.depth_fail_op);
                ref_stencil.dp_pass = map_vk_stencil_op(state.pass_op);
                ref_stencil.func = map_vk_compare_op(state.compare_op);
            }

            // Reverse winding of vertices, as Vulkan screen coordinates start at upper left
            let mut cw_vertices = vertices.clone();
            for vertex_ndx in (0..cw_vertices.len() - 2).step_by(3) {
                cw_vertices.swap(vertex_ndx + 1, vertex_ndx + 2);
            }

            for quad_ndx in 0..QUAD_COUNT {
                let config = &STENCIL_STATE_CONFIGS[quad_ndx];

                let front = &mut render_state.frag_ops.stencil_states[FaceType::Front as usize];
                front.reference = config.front_ref as i32;
                front.comp_mask = config.front_read_mask;
                front.write_mask = config.front_write_mask;

                let back = &mut render_state.frag_ops.stencil_states[FaceType::Back as usize];
                back.reference = config.back_ref as i32;
                back.comp_mask = config.back_read_mask;
                back.write_mask = config.back_write_mask;

                ref_renderer.draw(
                    &program,
                    &render_state,
                    crate::rr::primitive_types::PrimitiveType::Triangles,
                    &cw_vertices[quad_ndx * 6..(quad_ndx + 1) * 6],
                );
            }
        }

        // Compare result with reference image
        let color_compare_ok = match &color_image {
            Some(image) => {
                let result = read_color_attachment(context, image.get(), COLOR_FORMAT, RENDER_SIZE, color_layout)?;
                int_threshold_position_deviation_compare(
                    &ref_renderer.get_access(),
                    &result.get_const_access(),
                    UVec4::new(2, 2, 2, 2),
                    [1, 1, 0],
                    true,
                )
            }
            None => true,
        };

        // Compare stencil result with reference image
        let stencil_compare_ok = {
            let result = read_stencil_attachment(context, stencil_image.get(), stencil_format, RENDER_SIZE, ds_layout)?;
            let reference = ref_renderer
                .get_stencil_access()
                .expect("a stencil attachment has a reference buffer");
            int_threshold_position_deviation_compare(
                &reference,
                &result.get_const_access(),
                UVec4::new(2, 2, 2, 2),
                [1, 1, 0],
                true,
            )
        };

        if color_compare_ok && stencil_compare_ok {
            Ok(TestStatus::pass("Result image matches reference"))
        } else {
            Ok(TestStatus::fail("Image mismatch"))
        }
    }
}

fn stencil_op_short_name(stencil_op: vk::StencilOp) -> &'static str {
    match stencil_op {
        vk::StencilOp::KEEP => "keep",
        vk::StencilOp::ZERO => "zero",
        vk::StencilOp::REPLACE => "repl",
        vk::StencilOp::INCREMENT_AND_CLAMP => "incc",
        vk::StencilOp::DECREMENT_AND_CLAMP => "decc",
        vk::StencilOp::INVERT => "inv",
        vk::StencilOp::INCREMENT_AND_WRAP => "wrap",
        _ => "decw",
    }
}

fn format_case_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::S8_UINT => "s8_uint",
        vk::Format::D16_UNORM_S8_UINT => "d16_unorm_s8_uint",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        _ => "d32_sfloat_s8_uint",
    }
}

/// `createStencilTests` for `PIPELINE_CONSTRUCTION_TYPE_MONOLITHIC`.
pub fn create_stencil_tests() -> TestCaseGroup {
    let compare_op_names = [
        "comp_never",
        "comp_less",
        "comp_equal",
        "comp_less_or_equal",
        "comp_greater",
        "comp_not_equal",
        "comp_greater_or_equal",
        "comp_always",
    ];
    let stencil_formats = [
        vk::Format::S8_UINT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];

    // Stencil tests
    let mut stencil_tests = TestCaseGroup::new("stencil");
    // Stencil tests with no color attachment
    let mut no_color_attachment_tests = TestCaseGroup::new("nocolor");

    for color_enabled in [true, false] {
        let mut format_tests = TestCaseGroup::new("format");
        let mut stencil_op_itr = StencilOpStateUniqueRandomIterator::new(123);

        for format in stencil_formats {
            let tcu_format = map_vk_format(format).expect("stencil formats have texture formats");
            let has_depth = matches!(tcu_format.order, ChannelOrder::D | ChannelOrder::DS);
            let has_stencil = matches!(tcu_format.order, ChannelOrder::S | ChannelOrder::DS);
            let separate_layouts_loop_count = if has_depth && has_stencil { 2 } else { 1 };

            for separate_depth_stencil_layouts in 0..separate_layouts_loop_count {
                let use_separate_depth_stencil_layouts = separate_depth_stencil_layouts != 0;

                let mut format_test = TestCaseGroup::new(format!(
                    "{}{}",
                    format_case_name(format),
                    if use_separate_depth_stencil_layouts {
                        "_separate_layouts"
                    } else {
                        ""
                    }
                ));

                // Draws 4 quads with the depths and dynamic stencil states of STENCIL_STATE_CONFIGS.
                let mut stencil_state_tests = TestCaseGroup::new("states");

                stencil_op_itr.reset();

                for (fail_op_ndx, &fail_op) in STENCIL_OPS.iter().enumerate() {
                    let mut fail_op_test = TestCaseGroup::new(format!("fail_{}", stencil_op_short_name(fail_op)));

                    for (pass_op_ndx, &pass_op) in STENCIL_OPS.iter().enumerate() {
                        let mut pass_op_test = TestCaseGroup::new(format!("pass_{}", stencil_op_short_name(pass_op)));

                        for (d_fail_op_ndx, &d_fail_op) in STENCIL_OPS.iter().enumerate() {
                            let mut d_fail_op_test =
                                TestCaseGroup::new(format!("dfail_{}", stencil_op_short_name(d_fail_op)));

                            for (compare_op_ndx, &compare_op) in COMPARE_OPS.iter().enumerate() {
                                // Iterate front set of stencil state in ascending order
                                let stencil_state_front = vk::StencilOpState {
                                    fail_op,
                                    pass_op,
                                    depth_fail_op: d_fail_op,
                                    compare_op,
                                    compare_mask: 0,
                                    write_mask: 0,
                                    reference: 0,
                                };

                                // Iterate back set of stencil state in random order
                                let stencil_state_back = stencil_op_itr.next();

                                let mut layout_test = TestCaseGroup::new(compare_op_names[compare_op_ndx]);

                                for layout_ndx in 0..2 {
                                    let use_general_layout = layout_ndx == 1;
                                    if use_general_layout
                                        && (fail_op_ndx > 2
                                            || pass_op_ndx > 2
                                            || d_fail_op_ndx > 2
                                            || compare_op_ndx > 2)
                                    {
                                        continue;
                                    }
                                    let layout_name = if use_general_layout { "general" } else { "any" };
                                    let params = StencilParams {
                                        stencil_format: format,
                                        stencil_op_state_front: stencil_state_front,
                                        stencil_op_state_back: stencil_state_back,
                                        color_attachment_enable: color_enabled,
                                        separate_depth_stencil_layouts: use_separate_depth_stencil_layouts,
                                        use_general_layout,
                                    };
                                    layout_test.add_child(Box::new(StencilTest {
                                        name: layout_name.to_string(),
                                        params,
                                    }) as Box<dyn TestCase>);
                                }
                                d_fail_op_test.add_child(layout_test);
                            }
                            pass_op_test.add_child(d_fail_op_test);
                        }
                        fail_op_test.add_child(pass_op_test);
                    }
                    stencil_state_tests.add_child(fail_op_test);
                }

                format_test.add_child(stencil_state_tests);
                format_tests.add_child(format_test);
            }
        }

        if color_enabled {
            stencil_tests.add_child(format_tests);
        } else {
            no_color_attachment_tests.add_child(format_tests);
        }
    }

    stencil_tests.add_child(no_color_attachment_tests);
    stencil_tests
}

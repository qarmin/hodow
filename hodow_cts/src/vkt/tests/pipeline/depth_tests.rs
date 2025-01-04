// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDepthTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic construction type is ported, so the pipelines come
// from `create_draw_pipeline` and the `GraphicsPipelineWrapper` / `RenderPassWrapper` / `ShaderWrapper` choreography is
// plain Vulkan calls. The `xfer_queue_layout` and `depth_only` groups are not ported. The depth image is allocated
// from local, host visible memory when the case asks for it, without upstream's VulkanSC fallback.
//
// Draws four overlapping quads with a different depth compare op each (optionally with a depth bounds test, a depth clip
// control range, dynamic viewports, or without a colour or a depth attachment) and compares the colour and depth results
// with a software rendering of the same quads.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_depth::{DEPTH_COLOR, DEPTH_NO_COLOR};
use crate::rr::render_state::RenderState;
use crate::rr::renderer::Program;
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_position_deviation_compare};
use crate::tcu::pixel::get_texture_format_bit_depth;
use crate::tcu::texture::{ChannelOrder, TextureChannelClass};
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
    viewport,
};
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorVertexShader, ReferenceRenderer, Vertex4Rgba, create_overlapping_quads,
    default_clear_value, make_color_depth_render_pass, map_vk_compare_op, map_vk_primitive_topology,
    read_color_attachment, read_depth_attachment,
};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, ShaderObjectDraw, begin_dynamic_rendering, end_dynamic_rendering,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const QUAD_COUNT: usize = 4;
const QUAD_DEPTHS: [f32; QUAD_COUNT] = [0.1, 0.0, 0.3, 0.2];
/// Depth values suitable for the depth range of -1..1.
const QUAD_DEPTHS_MINUS_ONE_TO_ONE: [f32; QUAD_COUNT] = [-0.8, -1.0, 0.6, 0.2];
const QUAD_WS: [f32; QUAD_COUNT] = [2.0, 1.25, 0.5, 0.25];
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum DepthClipControlCase {
    /// No depth clip control.
    Disabled,
    /// Depth clip control with static viewport.
    Normal,
    /// Depth clip control with static viewport and .w different from 1.0f
    NormalW,
    /// Set dynamic viewport state, then bind a static pipeline.
    BeforeStatic,
    /// Set dynamic viewport state, bind dynamic pipeline.
    BeforeDynamic,
    /// Set dynamic viewport state, bind dynamic pipeline with [0,1] view volume, then bind dynamic pipeline with [-1,1] view volume.
    BeforeTwoDynamics,
    /// Bind dynamic pipeline, then set dynamic viewport state.
    AfterDynamic,
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

fn format_case_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::D16_UNORM => "d16_unorm",
        vk::Format::X8_D24_UNORM_PACK32 => "x8_d24_unorm_pack32",
        vk::Format::D32_SFLOAT => "d32_sfloat",
        vk::Format::D16_UNORM_S8_UINT => "d16_unorm_s8_uint",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        _ => "d32_sfloat_s8_uint",
    }
}

fn topology_name(topology: vk::PrimitiveTopology) -> &'static str {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => "point_list",
        vk::PrimitiveTopology::LINE_LIST => "line_list",
        _ => "triangle_list",
    }
}

fn compare_op_name(op: vk::CompareOp) -> &'static str {
    match op {
        vk::CompareOp::NEVER => "never",
        vk::CompareOp::LESS => "less",
        vk::CompareOp::EQUAL => "equal",
        vk::CompareOp::LESS_OR_EQUAL => "less_or_equal",
        vk::CompareOp::GREATER => "greater",
        vk::CompareOp::NOT_EQUAL => "not_equal",
        vk::CompareOp::GREATER_OR_EQUAL => "greater_or_equal",
        _ => "always",
    }
}

fn compare_ops_name(ops: &[vk::CompareOp; QUAD_COUNT]) -> String {
    ops.iter().map(|&op| compare_op_name(op)).collect::<Vec<_>>().join("_")
}

/// `testSupportsDepthStencilFormat` and `testSupportsAtLeastOneDepthStencilFormat`: the case passes when `any` of the
/// formats (a single format for the former) can be used in a depth/stencil attachment.
struct FormatSupportCase {
    name: String,
    formats: Vec<vk::Format>,
}

impl TestCase for FormatSupportCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FormatSupportInstance {
            context,
            formats: &self.formats,
        })
    }
}

struct FormatSupportInstance<'a> {
    context: &'a Context<'a>,
    formats: &'a [vk::Format],
}

impl TestInstance for FormatSupportInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let supported: Vec<String> = self
            .formats
            .iter()
            .filter(|&&format| is_supported_depth_stencil_format(self.context, format))
            .map(|&format| format_case_name(format).to_uppercase())
            .collect();

        if self.formats.len() == 1 {
            if supported.is_empty() {
                return Ok(TestStatus::fail("Unsupported depth/stencil attachment format"));
            }
            return Ok(TestStatus::pass("Format can be used in depth/stencil attachment"));
        }

        if supported.is_empty() {
            return Ok(TestStatus::fail("All depth/stencil formats are unsupported"));
        }
        Ok(TestStatus::pass(format!(
            "Supported depth/stencil formats: {}",
            supported.join(", ")
        )))
    }
}

#[derive(Clone, Copy)]
struct DepthParams {
    depth_format: vk::Format,
    depth_compare_ops: [vk::CompareOp; QUAD_COUNT],
    separate_depth_stencil_layouts: bool,
    primitive_topology: vk::PrimitiveTopology,
    depth_bounds_test_enable: bool,
    depth_bounds_min: f32,
    depth_bounds_max: f32,
    depth_test_enable: bool,
    stencil_test_enable: bool,
    depth_attachment_bound: bool,
    color_attachment_enable: bool,
    host_visible: bool,
    render_size: (u32, u32),
    depth_clip_control: DepthClipControlCase,
    use_general_layout: bool,
}

impl DepthParams {
    /// `DepthTest`'s constructor defaults.
    fn new(
        depth_format: vk::Format,
        depth_compare_ops: [vk::CompareOp; QUAD_COUNT],
        separate_depth_stencil_layouts: bool,
    ) -> Self {
        Self {
            depth_format,
            depth_compare_ops,
            separate_depth_stencil_layouts,
            primitive_topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            depth_bounds_test_enable: false,
            depth_bounds_min: 0.0,
            depth_bounds_max: 1.0,
            depth_test_enable: true,
            stencil_test_enable: false,
            depth_attachment_bound: true,
            color_attachment_enable: true,
            host_visible: false,
            render_size: (32, 32),
            depth_clip_control: DepthClipControlCase::Disabled,
            use_general_layout: false,
        }
    }
}

struct DepthTest {
    name: String,
    params: DepthParams,
}

impl TestCase for DepthTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if params.depth_bounds_test_enable && context.get_device_features().depth_bounds == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: depthBounds".to_string(),
            ));
        }

        if params.depth_attachment_bound && !is_supported_depth_stencil_format(context, params.depth_format) {
            return Err(TestError::NotSupported(format!(
                "Unsupported depth/stencil format: {:?}",
                params.depth_format
            )));
        }

        if params.separate_depth_stencil_layouts
            && !context.is_device_functionality_supported("VK_KHR_separate_depth_stencil_layouts")
        {
            return Err(TestError::NotSupported(
                "VK_KHR_separate_depth_stencil_layouts is not supported".to_string(),
            ));
        }

        if params.depth_clip_control != DepthClipControlCase::Disabled
            && !context.is_device_functionality_supported("VK_EXT_depth_clip_control")
        {
            return Err(TestError::NotSupported(
                "VK_EXT_depth_clip_control is not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.color_attachment_enable {
            DEPTH_COLOR.programs
        } else {
            DEPTH_NO_COLOR.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthTestInstance {
            context,
            params: self.params,
        })
    }
}

struct DepthTestInstance<'a> {
    context: &'a Context<'a>,
    params: DepthParams,
}

impl TestInstance for DepthTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let (render_width, render_height) = params.render_size;
        let color_format = if params.color_attachment_enable {
            COLOR_FORMAT
        } else {
            vk::Format::UNDEFINED
        };
        let depth_format = params.depth_format;

        let has_depth_clip_control = params.depth_clip_control != DepthClipControlCase::Disabled;
        let use_alt_graphics_pipelines = matches!(
            params.depth_clip_control,
            DepthClipControlCase::BeforeTwoDynamics | DepthClipControlCase::NormalW
        );
        let use_alt_vertices = params.depth_clip_control == DepthClipControlCase::NormalW;

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

        // Create color image
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

        // Bind depth attachment or depth format should be undefined.
        debug_assert!(params.depth_attachment_bound || depth_format == vk::Format::UNDEFINED);

        // Create depth image
        let tcu_depth_format = if params.depth_attachment_bound {
            map_vk_format(depth_format)
        } else {
            None
        };
        let mut depth_image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let depth_image = if params.depth_attachment_bound {
            let requirement = if params.host_visible {
                MemoryRequirement::LOCAL | MemoryRequirement::HOST_VISIBLE
            } else {
                MemoryRequirement::ANY
            };
            let image = ImageWithMemory::new(
                device,
                alloc,
                make_image_info(
                    depth_format,
                    vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                ),
                requirement,
            )?;

            let aspect = if tcu_depth_format.is_some_and(|format| format.order == ChannelOrder::DS) {
                vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
            } else {
                vk::ImageAspectFlags::DEPTH
            };
            depth_image_subresource_range = make_image_subresource_range(aspect, 0, 1, 0, 1);
            Some(image)
        } else {
            None
        };

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

        // Create depth attachment view
        let depth_attachment_view = match &depth_image {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                depth_format,
                depth_image_subresource_range,
            )?),
            None => None,
        };

        // Create render pass
        let render_pass = make_color_depth_render_pass(
            device,
            color_format,
            depth_format,
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
        if let Some(view) = &depth_attachment_view {
            attachment_bind_infos.push(**view);
        }
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

        // Shader modules
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let fragment_shader_module = if params.color_attachment_enable {
            Some(create_shader_module(device, binaries.get("color_frag")?)?)
        } else {
            None
        };

        let viewports = [viewport(0.0, 0.0, render_width as f32, render_height as f32, 0.0, 1.0)];
        let bad_viewports = [viewport(
            0.0,
            0.0,
            render_width as f32 / 2.0,
            render_height as f32 / 2.0,
            1.0,
            0.0,
        )];
        let scissors = [rect_2d(render_width, render_height)];
        let dynamic_viewport = matches!(
            params.depth_clip_control,
            DepthClipControlCase::BeforeDynamic
                | DepthClipControlCase::BeforeTwoDynamics
                | DepthClipControlCase::AfterDynamic
        );

        // Create pipelines
        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vertex_shader_module)];
        if let Some(module) = &fragment_shader_module {
            stages.push((vk::ShaderStageFlags::FRAGMENT, **module));
        }

        let build_state = |depth_compare_op: vk::CompareOp, depth_clip_control: Option<bool>| -> DrawPipelineState {
            let stencil_op_state = vk::StencilOpState {
                fail_op: vk::StencilOp::KEEP,
                pass_op: vk::StencilOp::KEEP,
                depth_fail_op: vk::StencilOp::KEEP,
                compare_op: vk::CompareOp::NEVER,
                compare_mask: 0,
                write_mask: 0,
                reference: 0,
            };

            let mut depth_stencil = default_depth_stencil_state();
            depth_stencil.depth_test_enable = u32::from(params.depth_test_enable);
            depth_stencil.depth_write_enable = vk::TRUE;
            depth_stencil.depth_compare_op = depth_compare_op;
            depth_stencil.depth_bounds_test_enable = u32::from(params.depth_bounds_test_enable);
            depth_stencil.stencil_test_enable = u32::from(params.stencil_test_enable);
            depth_stencil.front = stencil_op_state;
            depth_stencil.back = stencil_op_state;
            depth_stencil.min_depth_bounds = params.depth_bounds_min;
            depth_stencil.max_depth_bounds = params.depth_bounds_max;

            // Make sure rasterization is not disabled when the fragment shader is missing.
            let mut rasterization = default_rasterization_state();
            rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
            rasterization.depth_bias_enable = vk::FALSE;

            let mut state = DrawPipelineState::new(params.primitive_topology);
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
            state.viewports = if dynamic_viewport {
                bad_viewports.to_vec()
            } else {
                viewports.to_vec()
            };
            state.scissors = scissors.to_vec();
            state.viewport_count = 1;
            if dynamic_viewport {
                state.dynamic_states.push(vk::DynamicState::VIEWPORT);
            }
            state.rasterization = rasterization;
            state.depth_stencil = depth_stencil;
            state.color_attachment_count = u32::from(params.color_attachment_enable);
            state.depth_clip_control = depth_clip_control;
            state
        };

        let construction = ambient_construction_type();
        let mut draw_states: Vec<DrawPipelineState> = Vec::new();
        let mut alt_draw_states: Vec<DrawPipelineState> = Vec::new();
        let mut graphics_pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
        let mut alt_graphics_pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
        for quad_ndx in 0..QUAD_COUNT {
            let op = params.depth_compare_ops[quad_ndx];

            if construction.is_shader_object() {
                draw_states.push(build_state(op, if has_depth_clip_control { Some(true) } else { None }));
                if use_alt_graphics_pipelines {
                    alt_draw_states.push(build_state(op, Some(false)));
                }
                continue;
            }

            graphics_pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &build_state(op, if has_depth_clip_control { Some(true) } else { None }),
            )?);

            if use_alt_graphics_pipelines {
                alt_graphics_pipelines.push(create_draw_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    &stages,
                    &build_state(op, Some(false)),
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
        let mut alt_vertices = if use_alt_vertices {
            create_overlapping_quads()
        } else {
            Vec::new()
        };

        for quad_ndx in 0..QUAD_COUNT {
            for vertex_ndx in 0..6 {
                let index = quad_ndx * 6 + vertex_ndx;
                vertices[index].position[2] = if has_depth_clip_control {
                    QUAD_DEPTHS_MINUS_ONE_TO_ONE[quad_ndx]
                } else {
                    QUAD_DEPTHS[quad_ndx]
                };
                if params.depth_clip_control == DepthClipControlCase::NormalW {
                    let w = QUAD_WS[quad_ndx];
                    vertices[index].position[0] *= w;
                    vertices[index].position[1] *= w;
                    vertices[index].position[2] *= w;
                    vertices[index].position[3] = w;
                }
                if use_alt_vertices {
                    alt_vertices[index].position = vertices[index].position;
                    let mut z = alt_vertices[index].position[2];
                    let w = alt_vertices[index].position[3];
                    match params.depth_compare_ops[quad_ndx] {
                        vk::CompareOp::NOT_EQUAL | vk::CompareOp::LESS | vk::CompareOp::LESS_OR_EQUAL => z += 0.01,
                        vk::CompareOp::GREATER | vk::CompareOp::GREATER_OR_EQUAL => z -= 0.01,
                        _ => {}
                    }
                    alt_vertices[index].position[2] = (z + w) * 0.5;
                }
            }
        }

        // Load vertices into vertex buffer
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let alt_vertex_buffer = if use_alt_vertices {
            Some(create_host_buffer(
                context,
                &alt_vertices,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            )?)
        } else {
            None
        };

        // Create command pool and command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let mut attachment_clear_values: Vec<vk::ClearValue> = Vec::new();
        if params.color_attachment_enable {
            attachment_clear_values.push(default_clear_value(COLOR_FORMAT));
        }
        if params.depth_attachment_bound {
            attachment_clear_values.push(default_clear_value(depth_format));
        }

        let mut image_layout_barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();
        if let Some(image) = &color_image {
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
        if let Some(image) = &depth_image {
            let mut depth_barrier_subresource_range = depth_image_subresource_range;
            let mut new_layout = vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
            if params.separate_depth_stencil_layouts {
                depth_barrier_subresource_range.aspect_mask = vk::ImageAspectFlags::DEPTH;
                new_layout = vk::ImageLayout::DEPTH_ATTACHMENT_OPTIMAL;
            }
            if params.use_general_layout {
                new_layout = ds_layout;
            }

            image_layout_barriers.push(
                vk::ImageMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::empty())
                    .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
                    .old_layout(vk::ImageLayout::UNDEFINED)
                    .new_layout(new_layout)
                    .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .image(image.get())
                    .subresource_range(depth_barrier_subresource_range)
                    .build(),
            );
        }

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                    | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
                    | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_layout_barriers,
            );

            if shader_object_draw.is_some() {
                let colors: Vec<RenderingAttachment> = match &color_attachment_view {
                    Some(view) => vec![RenderingAttachment {
                        view: **view,
                        layout: color_layout,
                        clear_value: attachment_clear_values[0],
                    }],
                    None => Vec::new(),
                };
                let depth_stencil = depth_attachment_view.as_ref().map(|view| RenderingAttachment {
                    view: **view,
                    layout: ds_layout,
                    clear_value: *attachment_clear_values
                        .last()
                        .expect("the depth clear value is always present"),
                });
                let has_stencil = tcu_depth_format.is_some_and(|format| format.order == ChannelOrder::DS);
                begin_dynamic_rendering(
                    device,
                    cmd,
                    rect_2d(render_width, render_height),
                    &colors,
                    depth_stencil,
                    if has_stencil { depth_stencil } else { None },
                );
            } else {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffer)
                    .render_area(rect_2d(render_width, render_height))
                    .clear_values(&attachment_clear_values);
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            }
        }

        let quad_vertex_count = (vertices.len() / QUAD_COUNT) as u32;
        let quad_offset = (vertices.len() / QUAD_COUNT * std::mem::size_of::<Vertex4Rgba>()) as vk::DeviceSize;

        for quad_ndx in 0..QUAD_COUNT {
            let vertex_buffer_offset = quad_offset * quad_ndx as vk::DeviceSize;

            if let Some(shader_objects) = &shader_object_draw {
                if params.depth_clip_control == DepthClipControlCase::NormalW
                    && params.depth_compare_ops[quad_ndx] != vk::CompareOp::NEVER
                {
                    let alt_buffer = alt_vertex_buffer
                        .as_ref()
                        .expect("alt vertices for the different w case");
                    shader_objects.bind(cmd, &alt_draw_states[quad_ndx]);
                    unsafe {
                        device.cmd_bind_vertex_buffers(cmd, 0, &[alt_buffer.get()], &[vertex_buffer_offset]);
                        device.cmd_draw(cmd, (alt_vertices.len() / QUAD_COUNT) as u32, 1, 0, 0);
                    }
                }

                if params.depth_clip_control == DepthClipControlCase::BeforeTwoDynamics {
                    shader_objects.bind(cmd, &alt_draw_states[quad_ndx]);
                }
                shader_objects.bind(cmd, &draw_states[quad_ndx]);
                unsafe {
                    // The states hold placeholder viewports where the viewport is dynamic
                    if dynamic_viewport {
                        device.cmd_set_viewport(cmd, 0, &viewports);
                    }
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                    device.cmd_draw(cmd, quad_vertex_count, 1, 0, 0);
                }
                continue;
            }

            unsafe {
                if params.depth_clip_control == DepthClipControlCase::NormalW
                    && params.depth_compare_ops[quad_ndx] != vk::CompareOp::NEVER
                {
                    let alt_buffer = alt_vertex_buffer
                        .as_ref()
                        .expect("alt vertices for the different w case");
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *alt_graphics_pipelines[quad_ndx]);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[alt_buffer.get()], &[vertex_buffer_offset]);
                    device.cmd_draw(cmd, (alt_vertices.len() / QUAD_COUNT) as u32, 1, 0, 0);
                }

                if matches!(
                    params.depth_clip_control,
                    DepthClipControlCase::BeforeStatic
                        | DepthClipControlCase::BeforeDynamic
                        | DepthClipControlCase::BeforeTwoDynamics
                ) {
                    device.cmd_set_viewport(cmd, 0, &viewports);
                }

                if params.depth_clip_control == DepthClipControlCase::BeforeTwoDynamics {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *alt_graphics_pipelines[quad_ndx]);
                }
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines[quad_ndx]);

                if params.depth_clip_control == DepthClipControlCase::AfterDynamic {
                    device.cmd_set_viewport(cmd, 0, &viewports);
                }

                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                device.cmd_draw(cmd, quad_vertex_count, 1, 0, 0);
            }
        }

        if shader_object_draw.is_some() {
            end_dynamic_rendering(device, cmd);
        } else {
            unsafe { device.cmd_end_render_pass(cmd) };
        }
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify the image
        let tcu_color_format = map_vk_format(COLOR_FORMAT).expect("RGBA8 has a texture format");

        let vertex_shader = ColorVertexShader::new();
        let fragment_shader = ColorFragmentShader::new(
            tcu_color_format,
            tcu_depth_format,
            params.depth_clip_control != DepthClipControlCase::Disabled,
        );
        let program = Program {
            vertex_shader: &vertex_shader,
            fragment_shader: &fragment_shader,
            geometry_shader: None,
        };
        let mut ref_renderer = ReferenceRenderer::new(render_width, render_height, tcu_color_format, tcu_depth_format)?;

        // Render reference image
        for quad_ndx in 0..QUAD_COUNT {
            // Set depth state
            let mut render_state = RenderState::new(
                ref_renderer.get_viewport_state(),
                context.get_device_properties().limits.sub_pixel_precision_bits as i32,
            );
            render_state.frag_ops.depth_test_enabled = params.depth_test_enable;
            render_state.frag_ops.depth_func = map_vk_compare_op(params.depth_compare_ops[quad_ndx]);
            if params.depth_bounds_test_enable {
                render_state.frag_ops.depth_bounds_test_enabled = true;
                render_state.frag_ops.min_depth_bound = params.depth_bounds_min;
                render_state.frag_ops.max_depth_bound = params.depth_bounds_max;
            }

            ref_renderer.draw(
                &program,
                &render_state,
                map_vk_primitive_topology(params.primitive_topology),
                &vertices[quad_ndx * 6..(quad_ndx + 1) * 6],
            );
        }

        // Compare color result with reference image
        let color_compare_ok = match &color_image {
            Some(image) => {
                let result =
                    read_color_attachment(context, image.get(), COLOR_FORMAT, params.render_size, color_layout)?;
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

        // Compare depth result with reference image
        let depth_compare_ok = match &depth_image {
            Some(image) => {
                let result = read_depth_attachment(context, image.get(), depth_format, params.render_size, ds_layout)?;
                let reference = ref_renderer
                    .get_depth_access()
                    .expect("a depth attachment has a reference depth buffer");

                let depth_threshold = match result.format().channel_class() {
                    TextureChannelClass::UnsignedFixedPoint => {
                        let format_bits = get_texture_format_bit_depth(result.format());
                        1.0 / ((1u32 << format_bits[0]) - 1) as f32
                    }
                    TextureChannelClass::FloatingPoint => 0.000_000_1,
                    _ => return Err(TestError::Fail("unrecognized format type class".to_string())),
                };

                float_threshold_compare(&reference, &result.get_const_access(), [depth_threshold, 0.0, 0.0, 0.0]).ok
            }
            None => true,
        };

        if color_compare_ok && depth_compare_ok {
            Ok(TestStatus::pass("Result image matches reference"))
        } else {
            Ok(TestStatus::fail("Image mismatch"))
        }
    }
}

/// Each entry configures the depth compare operators of `QUAD_COUNT` quads. All entries cover pair-wise combinations of
/// compare operators.
fn depth_ops() -> Vec<[vk::CompareOp; QUAD_COUNT]> {
    use vk::CompareOp as Op;
    const NE: Op = Op::NOT_EQUAL;
    const EQ: Op = Op::EQUAL;
    const GT: Op = Op::GREATER;
    const LE: Op = Op::LESS_OR_EQUAL;
    const GE: Op = Op::GREATER_OR_EQUAL;
    const LT: Op = Op::LESS;
    const NV: Op = Op::NEVER;
    const AL: Op = Op::ALWAYS;

    vec![
        [NE, NE, NE, NE],
        [NE, EQ, EQ, GT],
        [NE, GT, GT, LE],
        [NE, GE, GE, GE],
        [NE, LE, LE, AL],
        [NE, LT, LT, LT],
        [NE, NV, NV, NV],
        [EQ, NE, EQ, EQ],
        [EQ, EQ, NE, LT],
        [EQ, GT, GE, NE],
        [EQ, GE, GT, GT],
        [EQ, LE, LT, LE],
        [NE, AL, AL, EQ],
        [EQ, LT, NV, AL],
        [EQ, NV, LE, GE],
        [GT, NE, GT, LT],
        [GT, EQ, GE, AL],
        [GT, GT, NE, GT],
        [GT, GE, LE, NE],
        [GT, LE, NV, GE],
        [GT, LT, EQ, NV],
        [GE, NE, GE, GT],
        [GT, NV, AL, LE],
        [GE, EQ, GT, NE],
        [GE, GT, EQ, GE],
        [GE, GE, NE, LE],
        [GE, LE, AL, LT],
        [GE, LT, LE, EQ],
        [GE, AL, LT, NV],
        [LE, NE, LE, LE],
        [LE, EQ, LT, EQ],
        [LE, GT, NV, LT],
        [LE, GE, EQ, AL],
        [LE, LT, NE, GE],
        [LE, LE, GE, NV],
        [LT, NE, LT, GE],
        [LT, EQ, NV, LE],
        [LT, GT, LE, NV],
        [LT, LE, GT, EQ],
        [LT, LT, AL, NE],
        [LT, NV, NE, AL],
        [NV, NE, AL, AL],
        [LT, AL, GE, LT],
        [NV, GE, NV, EQ],
        [NV, NV, LT, GT],
        [NV, LE, EQ, NE],
        [NV, LT, GE, LE],
        [NV, AL, GT, GE],
        [AL, EQ, AL, NV],
        [AL, NV, EQ, LT],
        [AL, GT, LT, AL],
        [AL, AL, NV, GT],
        [AL, LE, NE, EQ],
        [LE, NV, GT, NE],
        [NV, EQ, LE, LT],
        [EQ, GE, AL, NV],
        [GT, AL, LT, NE],
        [GT, NV, GE, EQ],
        [EQ, AL, EQ, LE],
        [LE, GT, AL, GT],
        [NV, NE, NE, NV],
        [AL, LT, GT, GT],
        [AL, NE, NV, NE],
        [GE, AL, NE, AL],
        [LE, AL, LE, GT],
        [LT, GE, LT, GT],
        [AL, EQ, LE, GE],
        [AL, GE, GE, LE],
        [GE, GE, NV, LT],
        [GE, NV, GT, NV],
        [LT, GT, EQ, EQ],
        [NV, GT, AL, GE],
        [NE, NE, GT, AL],
        [NE, LE, NE, GT],
    ]
}

/// `createDepthTests` for `PIPELINE_CONSTRUCTION_TYPE_MONOLITHIC`.
pub fn create_depth_tests() -> TestCaseGroup {
    let depth_formats = [
        vk::Format::D16_UNORM,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D32_SFLOAT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];
    let depth_ops = depth_ops();
    let color_attachment_enabled = [true, false];
    let primitive_topologies = [
        vk::PrimitiveTopology::POINT_LIST,
        vk::PrimitiveTopology::LINE_LIST,
        vk::PrimitiveTopology::TRIANGLE_LIST,
    ];

    let mut depth_tests = TestCaseGroup::new("depth");
    let mut no_color_attachment_tests = TestCaseGroup::new("nocolor");

    // Tests for format features
    {
        let mut format_features_tests = TestCaseGroup::new("format_features");

        // Formats that must be supported in all implementations
        format_features_tests.add_child(Box::new(FormatSupportCase {
            name: "support_d16_unorm".to_string(),
            formats: vec![vk::Format::D16_UNORM],
        }) as Box<dyn TestCase>);

        // Sets where at least one of the formats must be supported
        format_features_tests.add_child(Box::new(FormatSupportCase {
            name: "support_d24_unorm_or_d32_sfloat".to_string(),
            formats: vec![vk::Format::X8_D24_UNORM_PACK32, vk::Format::D32_SFLOAT],
        }) as Box<dyn TestCase>);
        format_features_tests.add_child(Box::new(FormatSupportCase {
            name: "support_d24_unorm_s8_uint_or_d32_sfloat_s8_uint".to_string(),
            formats: vec![vk::Format::D24_UNORM_S8_UINT, vk::Format::D32_SFLOAT_S8_UINT],
        }) as Box<dyn TestCase>);

        depth_tests.add_child(format_features_tests);
    }

    for color_enabled in color_attachment_enabled {
        // Tests for format and compare operators. Uses different depth formats.
        let mut format_tests = TestCaseGroup::new("format");

        for (format_ndx, &format) in depth_formats.iter().enumerate() {
            let tcu_format = map_vk_format(format).expect("depth formats have texture formats");
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
                // Combines depth compare operators
                let mut compare_ops_tests = TestCaseGroup::new("compare_ops");

                for &topology in &primitive_topologies {
                    let topology_prefix = format!("{}_", topology_name(topology));
                    for (ops_ndx, ops) in depth_ops.iter().enumerate() {
                        let base = DepthParams {
                            primitive_topology: topology,
                            ..DepthParams::new(format, *ops, use_separate_depth_stencil_layouts)
                        };

                        compare_ops_tests.add_child(Box::new(DepthTest {
                            name: format!("{topology_prefix}{}", compare_ops_name(ops)),
                            params: base,
                        }) as Box<dyn TestCase>);

                        let bounds = DepthParams {
                            depth_bounds_test_enable: true,
                            depth_bounds_min: 0.1,
                            depth_bounds_max: 0.25,
                            color_attachment_enable: color_enabled,
                            ..base
                        };
                        compare_ops_tests.add_child(Box::new(DepthTest {
                            name: format!("{topology_prefix}{}_depth_bounds_test", compare_ops_name(ops)),
                            params: bounds,
                        }) as Box<dyn TestCase>);

                        // Use general layout for some of the test cases
                        if (format_ndx + ops_ndx) % 10 == 0 {
                            let general = DepthParams {
                                use_general_layout: true,
                                ..bounds
                            };
                            compare_ops_tests.add_child(Box::new(DepthTest {
                                name: format!(
                                    "{topology_prefix}{}_depth_bounds_test_general_layout",
                                    compare_ops_name(ops)
                                ),
                                params: general,
                            }) as Box<dyn TestCase>);
                        }
                    }
                }

                // Special VkPipelineDepthStencilStateCreateInfo known to have issues
                {
                    let depth_ops_special = [vk::CompareOp::NEVER; QUAD_COUNT];
                    let params = DepthParams {
                        depth_bounds_test_enable: true,
                        depth_bounds_min: 0.0,
                        depth_bounds_max: 0.0,
                        depth_test_enable: false,
                        stencil_test_enable: true,
                        color_attachment_enable: color_enabled,
                        ..DepthParams::new(format, depth_ops_special, use_separate_depth_stencil_layouts)
                    };
                    compare_ops_tests.add_child(Box::new(DepthTest {
                        name: "never_zerodepthbounds_depthdisabled_stencilenabled".to_string(),
                        params,
                    }) as Box<dyn TestCase>);
                }
                format_test.add_child(compare_ops_tests);

                // Test case with depth test enabled, but depth write disabled
                let mut depth_test_disabled = TestCaseGroup::new("depth_test_disabled");
                {
                    let depth_ops_depth_test_disabled = [
                        vk::CompareOp::NEVER,
                        vk::CompareOp::LESS,
                        vk::CompareOp::GREATER,
                        vk::CompareOp::ALWAYS,
                    ];
                    let params = DepthParams {
                        depth_test_enable: false,
                        color_attachment_enable: color_enabled,
                        ..DepthParams::new(
                            format,
                            depth_ops_depth_test_disabled,
                            use_separate_depth_stencil_layouts,
                        )
                    };
                    depth_test_disabled.add_child(Box::new(DepthTest {
                        name: "depth_write_enabled".to_string(),
                        params,
                    }) as Box<dyn TestCase>);
                }
                format_test.add_child(depth_test_disabled);

                // Test case with depth buffer placed in local memory
                let mut host_visible_tests = TestCaseGroup::new("host_visible");
                {
                    let host_visible_ops = [
                        vk::CompareOp::NEVER,
                        vk::CompareOp::LESS,
                        vk::CompareOp::GREATER,
                        vk::CompareOp::ALWAYS,
                    ];
                    let params = DepthParams {
                        color_attachment_enable: color_enabled,
                        host_visible: true,
                        render_size: (256, 256),
                        ..DepthParams::new(format, host_visible_ops, use_separate_depth_stencil_layouts)
                    };
                    host_visible_tests.add_child(Box::new(DepthTest {
                        name: "local_memory_depth_buffer".to_string(),
                        params,
                    }) as Box<dyn TestCase>);
                }
                format_test.add_child(host_visible_tests);
                format_tests.add_child(format_test);
            }
        }

        if color_enabled {
            depth_tests.add_child(format_tests);
        } else {
            no_color_attachment_tests.add_child(format_tests);
        }
    }
    depth_tests.add_child(no_color_attachment_tests);

    // no depth attachment bound test.
    {
        let mut depth_bound_test_no_depth_attachment = TestCaseGroup::new("no_depth_attachment");
        let ops = [
            vk::CompareOp::NEVER,
            vk::CompareOp::LESS,
            vk::CompareOp::GREATER,
            vk::CompareOp::ALWAYS,
        ];
        let params = DepthParams {
            depth_bounds_test_enable: true,
            depth_bounds_min: 0.1,
            depth_bounds_max: 0.2,
            depth_test_enable: false,
            depth_attachment_bound: false,
            ..DepthParams::new(vk::Format::UNDEFINED, ops, false)
        };
        depth_bound_test_no_depth_attachment.add_child(Box::new(DepthTest {
            name: "depth_bound_test".to_string(),
            params,
        }) as Box<dyn TestCase>);
        depth_tests.add_child(depth_bound_test_no_depth_attachment);
    }

    let mut depth_clip_control_tests = TestCaseGroup::new("depth_clip_control");
    {
        let compare_ops = [vk::CompareOp::ALWAYS, vk::CompareOp::LESS];

        let viewport_cases = [
            (DepthClipControlCase::Normal, ""),
            (DepthClipControlCase::NormalW, "_different_w"),
            (DepthClipControlCase::BeforeStatic, "_viewport_before_static"),
            (DepthClipControlCase::BeforeDynamic, "_viewport_before_dynamic"),
            (DepthClipControlCase::BeforeTwoDynamics, "_viewport_before_two_dynamic"),
            (DepthClipControlCase::AfterDynamic, "_viewport_after_dynamic"),
        ];

        for (viewport_case, suffix) in viewport_cases {
            for &format in &depth_formats {
                for &compare_op in &compare_ops {
                    let test_name = format!("{}_{}{suffix}", format_case_name(format), compare_op_name(compare_op));
                    let params = DepthParams {
                        depth_clip_control: viewport_case,
                        ..DepthParams::new(format, [compare_op; QUAD_COUNT], false)
                    };
                    depth_clip_control_tests.add_child(Box::new(DepthTest {
                        name: test_name,
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }
    depth_tests.add_child(depth_clip_control_tests);

    depth_tests
}

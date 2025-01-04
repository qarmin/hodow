// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only monolithic pipelines, regular (not sparse) image backing and no fragment
// shading rate: raster_samples, raster_samples_consistency, min_sample_shading (+_enabled, _disabled), sample_mask, alpha_to_one,
// alpha_to_coverage, alpha_to_coverage_no_color_attachment and alpha_to_coverage_unused_attachment. Not ported: the sparse and
// fragment shading rate variants, the conservative rasterization and post depth coverage groups, and the other multisample
// groups upstream registers beside these (`sample_rate_a2c`, `z_export`, `compatible_render_pass`, `variable_rate`, `mixed_count`
// and `a2c_with_a2one` are in modules of their own). The image and log
// output of a failing comparison is not produced; the verdict is the same.

use std::collections::HashSet;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::pipeline_multisample::ALL_SHARED_PROGRAM;
use crate::rr::render_state::RenderState;
use crate::rr::renderer::Program;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, default_depth_stencil_state, rect_2d};
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorVertexShader, ReferenceRenderer, Vertex4Rgba, map_vk_primitive_topology,
    read_color_attachment,
};
use crate::vkt::tests::pipeline::shader_object_draw::{ShaderObjectDraw, end_dynamic_rendering, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const RENDER_SIZE: (u32, u32) = (32, 32);

const SAMPLE_COUNTS: [vk::SampleCountFlags; 6] = [
    vk::SampleCountFlags::_2,
    vk::SampleCountFlags::_4,
    vk::SampleCountFlags::_8,
    vk::SampleCountFlags::_16,
    vk::SampleCountFlags::_32,
    vk::SampleCountFlags::_64,
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum GeometryType {
    OpaqueTriangle,
    OpaqueLine,
    OpaquePoint,
    OpaqueQuad,
    /// Placed at z = 0.5.
    OpaqueQuadNonzeroDepth,
    TranslucentQuad,
    InvisibleTriangle,
    InvisibleQuad,
    GradientQuad,
}

const TEST_MODE_DEPTH_BIT: u32 = 1;
const TEST_MODE_STENCIL_BIT: u32 = 2;

#[derive(Clone, Copy, PartialEq, Eq)]
enum RenderType {
    /// Resolve multisample rendering to single sampled image.
    Resolve,
    /// Copy samples to an array of single sampled images.
    CopySamples,
    /// Render first with only depth/stencil and then with color + depth/stencil.
    DepthStencilOnly,
    /// Render using color attachment at location 1 and location 0 set as unused.
    UnusedAttachment,
    /// Render using color attachment with single sample, required by alpha_to_one tests.
    SingleSample,
}

/// The `VkPipelineMultisampleStateCreateInfo` of a test.
#[derive(Clone, Copy)]
struct MultisampleParams {
    samples: vk::SampleCountFlags,
    sample_shading_enable: bool,
    min_sample_shading: f32,
    /// Every word of the mask has this value.
    sample_mask: Option<u32>,
    alpha_to_coverage_enable: bool,
    alpha_to_one_enable: bool,
}

impl MultisampleParams {
    fn new(samples: vk::SampleCountFlags) -> Self {
        Self {
            samples,
            sample_shading_enable: false,
            min_sample_shading: 0.0,
            sample_mask: None,
            alpha_to_coverage_enable: false,
            alpha_to_one_enable: false,
        }
    }
}

fn sample_count_value(samples: vk::SampleCountFlags) -> u32 {
    samples.bits()
}

fn as_bytes<T: Copy>(values: &[T]) -> &[u8] {
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

/// `isSupportedSampleCount` for regular images.
fn is_supported_sample_count(context: &Context<'_>, rasterization_samples: vk::SampleCountFlags) -> bool {
    context
        .get_device_properties()
        .limits
        .framebuffer_color_sample_counts
        .contains(rasterization_samples)
}

/// `getDefaultColorBlendAttachmentState`
fn default_color_blend_attachment_state() -> vk::PipelineColorBlendAttachmentState {
    vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::FALSE,
        src_color_blend_factor: vk::BlendFactor::ONE,
        dst_color_blend_factor: vk::BlendFactor::ZERO,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ONE,
        dst_alpha_blend_factor: vk::BlendFactor::ZERO,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::all(),
    }
}

/// `getAlphaToCoverageBlendState`
fn alpha_to_coverage_blend_state(blend_enable: bool) -> vk::PipelineColorBlendAttachmentState {
    vk::PipelineColorBlendAttachmentState {
        blend_enable: if blend_enable { vk::TRUE } else { vk::FALSE },
        src_color_blend_factor: vk::BlendFactor::SRC_ALPHA,
        dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ZERO,
        dst_alpha_blend_factor: vk::BlendFactor::ONE,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::all(),
    }
}

/// `AlphaToOneTest::getAlphaToOneBlendState`
fn alpha_to_one_blend_state() -> vk::PipelineColorBlendAttachmentState {
    vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::TRUE,
        src_color_blend_factor: vk::BlendFactor::SRC_ALPHA,
        dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::SRC_ALPHA,
        dst_alpha_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::all(),
    }
}

/// `getUniqueColorsCount`
fn get_unique_colors_count(image: &TextureLevel) -> u32 {
    let colors: HashSet<u32> = image
        .data()
        .chunks_exact(4)
        .map(|pixel| u32::from_ne_bytes([pixel[0], pixel[1], pixel[2], pixel[3]]))
        .collect();
    colors.len() as u32
}

/// `getImageAspectFlags`
fn get_image_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::D16_UNORM | vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D32_SFLOAT => vk::ImageAspectFlags::DEPTH,
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        _ => vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
    }
}

/// `generateVertices`
fn generate_vertices(geometry_type: GeometryType) -> Vec<Vertex4Rgba> {
    let red = [1.0f32, 0.0, 0.0, 1.0];

    match geometry_type {
        GeometryType::OpaqueTriangle | GeometryType::InvisibleTriangle => {
            let color = if geometry_type == GeometryType::InvisibleTriangle {
                [0.0; 4]
            } else {
                red
            };
            vec![
                Vertex4Rgba {
                    position: [-0.75, 0.0, 0.0, 1.0],
                    color,
                },
                Vertex4Rgba {
                    position: [0.75, 0.125, 0.0, 1.0],
                    color,
                },
                Vertex4Rgba {
                    position: [0.75, -0.125, 0.0, 1.0],
                    color,
                },
            ]
        }
        GeometryType::OpaqueLine => vec![
            Vertex4Rgba {
                position: [-0.75, 0.25, 0.0, 1.0],
                color: red,
            },
            Vertex4Rgba {
                position: [0.75, -0.25, 0.0, 1.0],
                color: red,
            },
        ],
        GeometryType::OpaquePoint => vec![Vertex4Rgba {
            position: [0.0, 0.0, 0.0, 1.0],
            color: red,
        }],
        GeometryType::OpaqueQuad
        | GeometryType::OpaqueQuadNonzeroDepth
        | GeometryType::TranslucentQuad
        | GeometryType::InvisibleQuad
        | GeometryType::GradientQuad => {
            let mut vertices = vec![
                Vertex4Rgba {
                    position: [-1.0, -1.0, 0.0, 1.0],
                    color: red,
                },
                Vertex4Rgba {
                    position: [1.0, -1.0, 0.0, 1.0],
                    color: red,
                },
                Vertex4Rgba {
                    position: [-1.0, 1.0, 0.0, 1.0],
                    color: red,
                },
                Vertex4Rgba {
                    position: [1.0, 1.0, 0.0, 1.0],
                    color: red,
                },
            ];

            match geometry_type {
                GeometryType::TranslucentQuad => {
                    for vertex in vertices.iter_mut() {
                        vertex.color[3] = 0.25;
                    }
                }
                GeometryType::InvisibleQuad => {
                    for vertex in vertices.iter_mut() {
                        vertex.color[3] = 0.0;
                    }
                }
                GeometryType::GradientQuad => {
                    vertices[0].color[3] = 0.0;
                    vertices[2].color[3] = 0.0;
                }
                GeometryType::OpaqueQuadNonzeroDepth => {
                    for vertex in vertices.iter_mut() {
                        vertex.position[2] = 0.5;
                    }
                }
                _ => {}
            }
            vertices
        }
    }
}

/// `getPrimitiveTopology`
fn get_primitive_topology(geometry_type: GeometryType) -> vk::PrimitiveTopology {
    match geometry_type {
        GeometryType::OpaqueTriangle | GeometryType::InvisibleTriangle => vk::PrimitiveTopology::TRIANGLE_LIST,
        GeometryType::OpaqueLine => vk::PrimitiveTopology::LINE_LIST,
        GeometryType::OpaquePoint => vk::PrimitiveTopology::POINT_LIST,
        GeometryType::OpaqueQuad
        | GeometryType::OpaqueQuadNonzeroDepth
        | GeometryType::TranslucentQuad
        | GeometryType::InvisibleQuad
        | GeometryType::GradientQuad => vk::PrimitiveTopology::TRIANGLE_STRIP,
    }
}

/// `isSupportedDepthStencilFormat`
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

/// `findSupportedDepthStencilFormat`
fn find_supported_depth_stencil_format(context: &Context<'_>, use_depth: bool, use_stencil: bool) -> vk::Format {
    if use_depth && !use_stencil {
        return vk::Format::D16_UNORM; // must be supported
    }

    // One of these formats must be supported.
    if is_supported_depth_stencil_format(context, vk::Format::D24_UNORM_S8_UINT) {
        return vk::Format::D24_UNORM_S8_UINT;
    }
    if is_supported_depth_stencil_format(context, vk::Format::D32_SFLOAT_S8_UINT) {
        return vk::Format::D32_SFLOAT_S8_UINT;
    }
    vk::Format::UNDEFINED
}

fn make_2d_image_info(
    size: (u32, u32),
    format: vk::Format,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

struct Attachment<'a> {
    view: Unique<'a, vk::ImageView>,
    image: ImageWithMemory<'a>,
}

fn make_attachment<'a>(
    context: &'a Context<'a>,
    size: (u32, u32),
    format: vk::Format,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
    aspect: vk::ImageAspectFlags,
) -> Result<Attachment<'a>, TestError> {
    let device = context.get_device();
    let image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        make_2d_image_info(size, format, samples, usage),
        MemoryRequirement::ANY,
    )?;
    let view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        format,
        make_image_subresource_range(aspect, 0, 1, 0, 1),
    )?;
    Ok(Attachment { view, image })
}

/// What the `MultisampleRenderer` constructors of upstream take.
struct RendererConfig {
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    use_depth: bool,
    use_stencil: bool,
    topologies: Vec<vk::PrimitiveTopology>,
    vertices: Vec<Vec<Vertex4Rgba>>,
    multisample: MultisampleParams,
    blend_state: vk::PipelineColorBlendAttachmentState,
    render_type: RenderType,
    depth_clear_value: f32,
    render_size: (u32, u32),
    /// Chains a `VkPipelineRasterizationConservativeStateCreateInfoEXT` with this mode and extra overestimation size.
    conservative: Option<(vk::ConservativeRasterizationModeEXT, f32)>,
}

impl RendererConfig {
    /// The first `MultisampleRenderer` constructor: colour only.
    fn color_only(
        color_format: vk::Format,
        topology: vk::PrimitiveTopology,
        vertices: &[Vertex4Rgba],
        multisample: MultisampleParams,
        blend_state: vk::PipelineColorBlendAttachmentState,
        render_type: RenderType,
    ) -> Self {
        Self {
            color_format,
            depth_stencil_format: vk::Format::UNDEFINED,
            use_depth: false,
            use_stencil: false,
            topologies: vec![topology],
            vertices: vec![vertices.to_vec()],
            multisample,
            blend_state,
            render_type,
            depth_clear_value: 1.0,
            render_size: RENDER_SIZE,
            conservative: None,
        }
    }
}

/// `vkCmdBeginRendering` for what a render of the `MultisampleRenderer` had in its render pass: the multisampled colour image
/// (resolved into `resolve_view` when given, preceded by an unused attachment when `unused_first_attachment`) and the depth
/// and stencil image, whose used aspects are loaded as `depth_stencil_load_op` and kept.
#[allow(clippy::too_many_arguments)]
fn begin_rendering_ms(
    device: &Device,
    cmd: vk::CommandBuffer,
    render_size: (u32, u32),
    color: Option<(vk::ImageView, Option<vk::ImageView>)>,
    unused_first_attachment: bool,
    color_clear: vk::ClearValue,
    depth_stencil: Option<(vk::ImageView, vk::ImageAspectFlags, bool, bool)>,
    depth_stencil_load_op: vk::AttachmentLoadOp,
    depth_clear_value: f32,
) {
    let mut color_attachments = Vec::new();
    if unused_first_attachment {
        color_attachments.push(
            vk::RenderingAttachmentInfo::builder()
                .image_view(vk::ImageView::null())
                .image_layout(vk::ImageLayout::UNDEFINED)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .build(),
        );
    }
    if let Some((view, resolve_view)) = color {
        let mut attachment = vk::RenderingAttachmentInfo::builder()
            .image_view(view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(color_clear);
        if let Some(resolve_view) = resolve_view {
            attachment = attachment
                .resolve_mode(vk::ResolveModeFlags::AVERAGE)
                .resolve_image_view(resolve_view)
                .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
        }
        color_attachments.push(attachment.build());
    }

    let mut depth_attachment = None;
    let mut stencil_attachment = None;
    if let Some((view, aspect, use_depth, use_stencil)) = depth_stencil {
        let attachment = |used: bool| {
            vk::RenderingAttachmentInfo::builder()
                .image_view(view)
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(if used {
                    depth_stencil_load_op
                } else {
                    vk::AttachmentLoadOp::DONT_CARE
                })
                .store_op(if used {
                    vk::AttachmentStoreOp::STORE
                } else {
                    vk::AttachmentStoreOp::DONT_CARE
                })
                .clear_value(vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: depth_clear_value,
                        stencil: 0,
                    },
                })
                .build()
        };
        if aspect.contains(vk::ImageAspectFlags::DEPTH) {
            depth_attachment = Some(attachment(use_depth));
        }
        if aspect.contains(vk::ImageAspectFlags::STENCIL) {
            stencil_attachment = Some(attachment(use_stencil));
        }
    }

    let mut rendering_info = vk::RenderingInfo::builder()
        .render_area(rect_2d(render_size.0, render_size.1))
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments);
    if let Some(depth_attachment) = &depth_attachment {
        rendering_info = rendering_info.depth_attachment(depth_attachment);
    }
    if let Some(stencil_attachment) = &stencil_attachment {
        rendering_info = rendering_info.stencil_attachment(stencil_attachment);
    }
    unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
}

/// `MultisampleRenderer` - the images, the render pass, the pipelines and the recorded command buffer of one render.
#[allow(dead_code)]
struct MultisampleRenderer<'a> {
    context: &'a Context<'a>,
    render_size: (u32, u32),
    color_format: vk::Format,
    render_type: RenderType,
    depth_clear_value: f32,
    depth_stencil_format: vk::Format,
    multisample: MultisampleParams,
    cmd_buffer: UniqueCommandBuffer<'a>,
    cmd_pool: Unique<'a, vk::CommandPool>,
    vertex_buffer: BufferWithMemory<'a>,
    copy_sample_descriptor_set: Option<UniqueDescriptorSet<'a>>,
    copy_sample_descriptor_pool: Option<Unique<'a, vk::DescriptorPool>>,
    copy_sample_pipelines: Vec<Unique<'a, vk::Pipeline>>,
    graphics_pipelines: Vec<Unique<'a, vk::Pipeline>>,
    shader_objects: Option<ShaderObjectDraw<'a>>,
    copy_sample_pipeline_layout: Option<Unique<'a, vk::PipelineLayout>>,
    copy_sample_descriptor_layout: Option<Unique<'a, vk::DescriptorSetLayout>>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    depth_stencil: Option<Attachment<'a>>,
    per_sample_images: Vec<Attachment<'a>>,
    resolve: Option<Attachment<'a>>,
    color: Attachment<'a>,
}

impl<'a> MultisampleRenderer<'a> {
    fn new(context: &'a Context<'a>, config: RendererConfig) -> Result<Self, TestError> {
        let render_size = config.render_size;
        let conservative_state = config.conservative.map(|(mode, extra_size)| {
            vk::PipelineRasterizationConservativeStateCreateInfoEXT::builder()
                .conservative_rasterization_mode(mode)
                .extra_primitive_overestimation_size(extra_size)
                .build()
        });
        let device = context.get_device();
        let multisample = config.multisample;
        let render_type = config.render_type;
        let color_format = config.color_format;
        let use_depth_stencil = config.use_depth || config.use_stencil;
        let uses_resolve_image = matches!(
            render_type,
            RenderType::Resolve | RenderType::DepthStencilOnly | RenderType::UnusedAttachment
        );
        let num_topologies = config.topologies.len();

        // Create color image
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | if render_type == RenderType::CopySamples {
                vk::ImageUsageFlags::INPUT_ATTACHMENT
            } else {
                vk::ImageUsageFlags::empty()
            };
        let color = make_attachment(
            context,
            render_size,
            color_format,
            multisample.samples,
            color_usage,
            vk::ImageAspectFlags::COLOR,
        )?;

        // Create resolve image
        let resolve_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let resolve = if uses_resolve_image {
            Some(make_attachment(
                context,
                render_size,
                color_format,
                vk::SampleCountFlags::_1,
                resolve_usage,
                vk::ImageAspectFlags::COLOR,
            )?)
        } else {
            None
        };

        // Create per-sample output images
        let mut per_sample_images = Vec::new();
        if render_type == RenderType::CopySamples {
            for _ in 0..sample_count_value(multisample.samples) {
                per_sample_images.push(make_attachment(
                    context,
                    render_size,
                    color_format,
                    vk::SampleCountFlags::_1,
                    resolve_usage,
                    vk::ImageAspectFlags::COLOR,
                )?);
            }
        }

        // Create a depth/stencil image
        let depth_stencil_aspect = if use_depth_stencil {
            get_image_aspect_flags(config.depth_stencil_format)
        } else {
            vk::ImageAspectFlags::empty()
        };
        let depth_stencil = if use_depth_stencil {
            Some(make_attachment(
                context,
                render_size,
                config.depth_stencil_format,
                multisample.samples,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
                depth_stencil_aspect,
            )?)
        } else {
            None
        };

        // Create render pass
        let render_pass = {
            let mut attachment_descriptions = vec![
                vk::AttachmentDescription::builder()
                    .format(color_format)
                    .samples(multisample.samples)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .build(),
            ];

            let single_sample_color_attachment = vk::AttachmentDescription::builder()
                .format(color_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build();

            let mut resolve_attachment_index = vk::ATTACHMENT_UNUSED;
            if uses_resolve_image {
                resolve_attachment_index = attachment_descriptions.len() as u32;
                attachment_descriptions.push(single_sample_color_attachment);
            }

            let mut per_sample_attachment_index = vk::ATTACHMENT_UNUSED;
            if render_type == RenderType::CopySamples {
                per_sample_attachment_index = attachment_descriptions.len() as u32;
                for _ in 0..per_sample_images.len() {
                    attachment_descriptions.push(single_sample_color_attachment);
                }
            }

            let mut depth_stencil_attachment_index = vk::ATTACHMENT_UNUSED;
            if use_depth_stencil {
                depth_stencil_attachment_index = attachment_descriptions.len() as u32;
                attachment_descriptions.push(
                    vk::AttachmentDescription::builder()
                        .format(config.depth_stencil_format)
                        .samples(multisample.samples)
                        .load_op(if config.use_depth {
                            vk::AttachmentLoadOp::CLEAR
                        } else {
                            vk::AttachmentLoadOp::DONT_CARE
                        })
                        .store_op(if config.use_depth {
                            vk::AttachmentStoreOp::STORE
                        } else {
                            vk::AttachmentStoreOp::DONT_CARE
                        })
                        .stencil_load_op(if config.use_stencil {
                            vk::AttachmentLoadOp::CLEAR
                        } else {
                            vk::AttachmentLoadOp::DONT_CARE
                        })
                        .stencil_store_op(if config.use_stencil {
                            vk::AttachmentStoreOp::STORE
                        } else {
                            vk::AttachmentStoreOp::DONT_CARE
                        })
                        .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                        .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                        .build(),
                );
            }

            let color_attachment_reference = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            let input_attachment_reference = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let resolve_attachment_reference = [vk::AttachmentReference {
                attachment: resolve_attachment_index,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            let color_attachment_references_unused_attachment = [
                vk::AttachmentReference {
                    attachment: vk::ATTACHMENT_UNUSED,
                    layout: vk::ImageLayout::UNDEFINED,
                },
                vk::AttachmentReference {
                    attachment: 0,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                },
            ];
            let resolve_attachment_references_unused_attachment = [
                vk::AttachmentReference {
                    attachment: vk::ATTACHMENT_UNUSED,
                    layout: vk::ImageLayout::UNDEFINED,
                },
                vk::AttachmentReference {
                    attachment: resolve_attachment_index,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                },
            ];
            let per_sample_attachment_references: Vec<[vk::AttachmentReference; 1]> = (0..per_sample_images.len())
                .map(|i| {
                    [vk::AttachmentReference {
                        attachment: per_sample_attachment_index + i as u32,
                        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    }]
                })
                .collect();
            let depth_stencil_attachment_reference = vk::AttachmentReference {
                attachment: depth_stencil_attachment_index,
                layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            };

            let mut subpass_descriptions: Vec<vk::SubpassDescription> = Vec::new();
            let mut subpass_dependencies: Vec<vk::SubpassDependency> = Vec::new();

            if render_type == RenderType::DepthStencilOnly {
                subpass_descriptions.push(
                    vk::SubpassDescription::builder()
                        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                        .depth_stencil_attachment(&depth_stencil_attachment_reference)
                        .build(),
                );
                subpass_descriptions.push(
                    vk::SubpassDescription::builder()
                        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                        .color_attachments(&color_attachment_reference)
                        .resolve_attachments(&resolve_attachment_reference)
                        .depth_stencil_attachment(&depth_stencil_attachment_reference)
                        .build(),
                );
                subpass_dependencies.push(
                    vk::SubpassDependency::builder()
                        .src_subpass(0)
                        .dst_subpass(1)
                        .src_stage_mask(vk::PipelineStageFlags::LATE_FRAGMENT_TESTS)
                        .dst_stage_mask(vk::PipelineStageFlags::LATE_FRAGMENT_TESTS)
                        .src_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
                        .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ)
                        .dependency_flags(vk::DependencyFlags::empty())
                        .build(),
                );
            } else if render_type == RenderType::UnusedAttachment {
                subpass_descriptions.push(
                    vk::SubpassDescription::builder()
                        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                        .color_attachments(&color_attachment_references_unused_attachment)
                        .resolve_attachments(&resolve_attachment_references_unused_attachment)
                        .build(),
                );
            } else {
                let mut render_subpass = vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .color_attachments(&color_attachment_reference);
                if uses_resolve_image {
                    render_subpass = render_subpass.resolve_attachments(&resolve_attachment_reference);
                }
                if use_depth_stencil {
                    render_subpass = render_subpass.depth_stencil_attachment(&depth_stencil_attachment_reference);
                }
                subpass_descriptions.push(render_subpass.build());

                if render_type == RenderType::CopySamples {
                    for (i, per_sample_reference) in per_sample_attachment_references.iter().enumerate() {
                        subpass_descriptions.push(
                            vk::SubpassDescription::builder()
                                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                                .input_attachments(&input_attachment_reference)
                                .color_attachments(per_sample_reference)
                                .build(),
                        );

                        subpass_dependencies.push(
                            vk::SubpassDependency::builder()
                                .src_subpass(0)
                                .dst_subpass(1 + i as u32)
                                .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
                                .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                                .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                                .dependency_flags(vk::DependencyFlags::empty())
                                .build(),
                        );
                    }
                    // the very last sample pass must synchronize with all prior subpasses
                    for i in 0..per_sample_images.len() - 1 {
                        subpass_dependencies.push(
                            vk::SubpassDependency::builder()
                                .src_subpass(1 + i as u32)
                                .dst_subpass(per_sample_images.len() as u32)
                                .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
                                .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                                .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                                .dependency_flags(vk::DependencyFlags::empty())
                                .build(),
                        );
                    }
                }
            }

            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachment_descriptions)
                .subpasses(&subpass_descriptions)
                .dependencies(&subpass_dependencies);
            let render_pass =
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
            Unique::new(device, render_pass)
        };

        // Create framebuffer
        let framebuffer = {
            let mut attachments = vec![*color.view];
            if let Some(resolve) = &resolve {
                attachments.push(*resolve.view);
            }
            for per_sample in &per_sample_images {
                attachments.push(*per_sample.view);
            }
            if let Some(depth_stencil) = &depth_stencil {
                attachments.push(*depth_stencil.view);
            }
            make_framebuffer(device, *render_pass, &attachments, render_size.0, render_size.1, 1)?
        };

        // Create pipeline layout
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let mut copy_sample_descriptor_layout = None;
        let mut copy_sample_pipeline_layout = None;
        if render_type == RenderType::CopySamples {
            let descriptor_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?;

            let set_layouts = [*descriptor_layout];
            let push_constant_ranges = [vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::FRAGMENT,
                offset: 0,
                size: std::mem::size_of::<i32>() as u32,
            }];
            let layout_info = vk::PipelineLayoutCreateInfo::builder()
                .set_layouts(&set_layouts)
                .push_constant_ranges(&push_constant_ranges);
            let layout =
                unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?;
            copy_sample_pipeline_layout = Some(Unique::new(device, layout));
            copy_sample_descriptor_layout = Some(descriptor_layout);
        }

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("color_frag")?)?;

        // Create pipeline
        let shader_objects = if render_type == RenderType::CopySamples {
            None
        } else {
            make_shader_objects(context, "color_vert", Some("color_frag"), &[], &[])?
        };
        let mut graphics_pipelines = Vec::new();
        let mut graphics_states = Vec::new();
        {
            let attachment_count = if render_type == RenderType::UnusedAttachment {
                2
            } else {
                1
            };

            let stencil_op_state = vk::StencilOpState {
                fail_op: vk::StencilOp::KEEP,
                pass_op: vk::StencilOp::REPLACE,
                depth_fail_op: vk::StencilOp::KEEP,
                compare_op: vk::CompareOp::GREATER,
                compare_mask: 1,
                write_mask: 1,
                reference: 1,
            };

            let num_subpasses = if render_type == RenderType::DepthStencilOnly {
                2
            } else {
                1
            };

            for subpass_idx in 0..num_subpasses {
                for topology in &config.topologies {
                    let mut state = DrawPipelineState::new(*topology).with_full_viewport(render_size.0, render_size.1);
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
                            offset: 16,
                        },
                    ];
                    state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
                    state.rasterization.depth_bias_enable = vk::FALSE;
                    state.depth_stencil = default_depth_stencil_state();
                    state.depth_stencil.depth_test_enable = if config.use_depth { vk::TRUE } else { vk::FALSE };
                    state.depth_stencil.depth_write_enable = if config.use_depth { vk::TRUE } else { vk::FALSE };
                    state.depth_stencil.depth_compare_op = vk::CompareOp::LESS;
                    state.depth_stencil.stencil_test_enable = if config.use_stencil { vk::TRUE } else { vk::FALSE };
                    state.depth_stencil.front = stencil_op_state;
                    state.depth_stencil.back = stencil_op_state;
                    state.samples = multisample.samples;
                    state.sample_shading = multisample.sample_shading_enable;
                    state.min_sample_shading = multisample.min_sample_shading;
                    state.sample_mask = multisample.sample_mask;
                    state.alpha_to_coverage_enable = multisample.alpha_to_coverage_enable;
                    state.alpha_to_one_enable = multisample.alpha_to_one_enable;
                    state.subpass = subpass_idx;
                    // The first subpass of the depth/stencil only render has no colour attachment.
                    state.color_attachment_count = if render_type == RenderType::DepthStencilOnly && subpass_idx == 0 {
                        0
                    } else {
                        attachment_count
                    };
                    state.color_blend_attachments = vec![config.blend_state; state.color_attachment_count as usize];
                    if let Some(conservative_state) = &conservative_state {
                        state.rasterization.next = std::ptr::from_ref(conservative_state).cast();
                    }

                    if shader_objects.is_none() {
                        graphics_pipelines.push(create_draw_pipeline(
                            device,
                            *pipeline_layout,
                            *render_pass,
                            &[
                                (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
                                (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
                            ],
                            &state,
                        )?);
                    }
                    state.rasterization.next = std::ptr::null();
                    graphics_states.push(state);
                }
            }
        }

        let mut copy_sample_pipelines = Vec::new();
        let mut copy_sample_descriptor_pool = None;
        let mut copy_sample_descriptor_set = None;
        if render_type == RenderType::CopySamples {
            let quad_vertex_module = create_shader_module(device, binaries.get("quad_vert")?)?;
            let copy_sample_fragment_module = create_shader_module(device, binaries.get("copy_sample_frag")?)?;

            // Create pipelines for copying samples to single sampled images
            for i in 0..per_sample_images.len() {
                // Pipeline is to be used in subpasses subsequent to sample-shading subpass
                let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
                    .with_full_viewport(render_size.0, render_size.1);
                state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
                state.rasterization.depth_bias_enable = vk::FALSE;
                state.subpass = 1 + i as u32;
                state.color_blend_attachments = vec![config.blend_state];
                copy_sample_pipelines.push(create_draw_pipeline(
                    device,
                    **copy_sample_pipeline_layout
                        .as_ref()
                        .expect("created for the copy sample render type"),
                    *render_pass,
                    &[
                        (vk::ShaderStageFlags::VERTEX, *quad_vertex_module),
                        (vk::ShaderStageFlags::FRAGMENT, *copy_sample_fragment_module),
                    ],
                    &state,
                )?);
            }

            let descriptor_pool_sizes = [vk::DescriptorPoolSize {
                type_: vk::DescriptorType::INPUT_ATTACHMENT,
                descriptor_count: 1,
            }];
            let descriptor_pool_info = vk::DescriptorPoolCreateInfo::builder()
                .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
                .max_sets(1)
                .pool_sizes(&descriptor_pool_sizes);
            let pool = unsafe { device.create_descriptor_pool(&descriptor_pool_info, None) }
                .vk_check("vkCreateDescriptorPool")?;
            let pool = Unique::new(device, pool);

            let set_layouts = [**copy_sample_descriptor_layout
                .as_ref()
                .expect("created for the copy sample render type")];
            let allocate_info = vk::DescriptorSetAllocateInfo::builder()
                .descriptor_pool(*pool)
                .set_layouts(&set_layouts);
            let sets =
                unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?;
            let set = UniqueDescriptorSet::new(device, *pool, sets[0]);

            let image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *color.view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(set.get())
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                .image_info(&image_info)
                .build();
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

            copy_sample_descriptor_pool = Some(pool);
            copy_sample_descriptor_set = Some(set);
        }

        // Create vertex buffer
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(1024, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Load vertices into vertex buffer
        {
            let mut vertex_data: Vec<u8> = Vec::new();

            if render_type == RenderType::DepthStencilOnly {
                debug_assert!(num_topologies == 1);

                // Set alpha to zero for the first draw. This should prevent depth writes because of zero coverage.
                let mut vertices = config.vertices[0].clone();
                for vertex in vertices.iter_mut() {
                    vertex.color[3] = 0.0;
                }
                vertex_data.extend_from_slice(as_bytes(&vertices));

                // The second draw uses original vertices which are pure red.
                vertex_data.extend_from_slice(as_bytes(&config.vertices[0]));
            } else {
                for vertices in &config.vertices {
                    vertex_data.extend_from_slice(as_bytes(vertices));
                }
            }

            let allocation = vertex_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(vertex_data.as_ptr(), allocation.get_host_ptr(), vertex_data.len())
            };
            flush_alloc(device, allocation)?;
        }

        // Create command pool and command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        {
            let color_clear_value = if render_type == RenderType::DepthStencilOnly {
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.25, 0.25, 0.25, 1.0],
                    },
                }
            } else {
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 0.0],
                    },
                }
            };
            let depth_stencil_clear_value = vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: config.depth_clear_value,
                    stencil: 0,
                },
            };

            let mut clear_values = vec![color_clear_value];
            if uses_resolve_image {
                clear_values.push(color_clear_value);
            }
            if render_type == RenderType::CopySamples {
                for _ in 0..per_sample_images.len() {
                    clear_values.push(color_clear_value);
                }
            }
            if use_depth_stencil {
                clear_values.push(depth_stencil_clear_value);
            }

            let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let mut dst_stage_mask = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
            let mut image_layout_barriers = vec![make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color.image.get(),
                color_range,
            )];
            if let Some(resolve) = &resolve {
                image_layout_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    resolve.image.get(),
                    color_range,
                ));
            }
            for per_sample in &per_sample_images {
                image_layout_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    per_sample.image.get(),
                    color_range,
                ));
            }
            if let Some(depth_stencil) = &depth_stencil {
                image_layout_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    depth_stencil.image.get(),
                    make_image_subresource_range(depth_stencil_aspect, 0, 1, 0, 1),
                ));
                dst_stage_mask |= vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS;
            }

            let cmd = *cmd_buffer;
            begin_command_buffer(device, cmd)?;

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    dst_stage_mask,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &image_layout_barriers,
                );

                if let Some(objects) = &shader_objects {
                    // The subpasses of the render pass become renderings of their own.
                    let ds = depth_stencil.as_ref().map(|attachment| {
                        (
                            *attachment.view,
                            depth_stencil_aspect,
                            config.use_depth,
                            config.use_stencil,
                        )
                    });
                    let resolve_view = resolve.as_ref().map(|attachment| *attachment.view);
                    let mut vertex_buffer_offset: vk::DeviceSize = 0;
                    if render_type == RenderType::DepthStencilOnly {
                        begin_rendering_ms(
                            device,
                            cmd,
                            render_size,
                            None,
                            false,
                            color_clear_value,
                            ds,
                            vk::AttachmentLoadOp::CLEAR,
                            config.depth_clear_value,
                        );
                        for i in 0..num_topologies {
                            objects.bind(cmd, &graphics_states[i]);
                            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                            device.cmd_draw(cmd, config.vertices[i].len() as u32, 1, 0, 0);
                            vertex_buffer_offset +=
                                (config.vertices[i].len() * std::mem::size_of::<Vertex4Rgba>()) as vk::DeviceSize;
                        }
                        end_dynamic_rendering(device, cmd);

                        let dependency = vk::MemoryBarrier::builder()
                            .src_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
                            .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ)
                            .build();
                        device.cmd_pipeline_barrier(
                            cmd,
                            vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                            vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                            vk::DependencyFlags::empty(),
                            &[dependency],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                        begin_rendering_ms(
                            device,
                            cmd,
                            render_size,
                            Some((*color.view, resolve_view)),
                            false,
                            color_clear_value,
                            ds,
                            vk::AttachmentLoadOp::LOAD,
                            config.depth_clear_value,
                        );
                        objects.bind(cmd, &graphics_states[num_topologies]);
                        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                        device.cmd_draw(cmd, config.vertices[0].len() as u32, 1, 0, 0);
                        end_dynamic_rendering(device, cmd);
                    } else {
                        begin_rendering_ms(
                            device,
                            cmd,
                            render_size,
                            Some((*color.view, resolve_view)),
                            render_type == RenderType::UnusedAttachment,
                            color_clear_value,
                            ds,
                            vk::AttachmentLoadOp::CLEAR,
                            config.depth_clear_value,
                        );
                        for i in 0..num_topologies {
                            objects.bind(cmd, &graphics_states[i]);
                            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                            device.cmd_draw(cmd, config.vertices[i].len() as u32, 1, 0, 0);
                            vertex_buffer_offset +=
                                (config.vertices[i].len() * std::mem::size_of::<Vertex4Rgba>()) as vk::DeviceSize;
                        }
                        end_dynamic_rendering(device, cmd);
                    }
                } else {
                    let begin_info = vk::RenderPassBeginInfo::builder()
                        .render_pass(*render_pass)
                        .framebuffer(*framebuffer)
                        .render_area(rect_2d(render_size.0, render_size.1))
                        .clear_values(&clear_values);
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

                    let mut vertex_buffer_offset: vk::DeviceSize = 0;

                    for i in 0..num_topologies {
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines[i]);
                        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                        device.cmd_draw(cmd, config.vertices[i].len() as u32, 1, 0, 0);

                        vertex_buffer_offset +=
                            (config.vertices[i].len() * std::mem::size_of::<Vertex4Rgba>()) as vk::DeviceSize;
                    }

                    if render_type == RenderType::DepthStencilOnly {
                        // The first draw was without color buffer and zero coverage. The depth buffer is expected to still have the clear value.
                        device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines[1]);
                        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
                        // The depth test should pass as the first draw didn't touch the depth buffer.
                        device.cmd_draw(cmd, config.vertices[0].len() as u32, 1, 0, 0);
                    } else if render_type == RenderType::CopySamples {
                        // Copy each sample id to single sampled image
                        for sample_id in 0..per_sample_images.len() as i32 {
                            device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
                            device.cmd_bind_pipeline(
                                cmd,
                                vk::PipelineBindPoint::GRAPHICS,
                                *copy_sample_pipelines[sample_id as usize],
                            );
                            device.cmd_bind_descriptor_sets(
                                cmd,
                                vk::PipelineBindPoint::GRAPHICS,
                                **copy_sample_pipeline_layout
                                    .as_ref()
                                    .expect("created for the copy sample render type"),
                                0,
                                &[copy_sample_descriptor_set
                                    .as_ref()
                                    .expect("created for the copy sample render type")
                                    .get()],
                                &[] as &[u32],
                            );
                            device.cmd_push_constants(
                                cmd,
                                **copy_sample_pipeline_layout
                                    .as_ref()
                                    .expect("created for the copy sample render type"),
                                vk::ShaderStageFlags::FRAGMENT,
                                0,
                                &sample_id.to_ne_bytes(),
                            );
                            device.cmd_draw(cmd, 4, 1, 0, 0);
                        }
                    }

                    device.cmd_end_render_pass(cmd);
                }
            }

            end_command_buffer(device, cmd)?;
        }

        Ok(Self {
            context,
            render_size,
            color_format,
            render_type,
            depth_clear_value: config.depth_clear_value,
            depth_stencil_format: config.depth_stencil_format,
            multisample,
            cmd_buffer,
            cmd_pool,
            vertex_buffer,
            copy_sample_descriptor_set,
            copy_sample_descriptor_pool,
            copy_sample_pipelines,
            graphics_pipelines,
            shader_objects,
            copy_sample_pipeline_layout,
            copy_sample_descriptor_layout,
            pipeline_layout,
            framebuffer,
            render_pass,
            depth_stencil,
            per_sample_images,
            resolve,
            color,
        })
    }

    /// `MultisampleRenderer::render` - none for the render type that keeps the samples apart.
    fn render(&self) -> Result<Option<TextureLevel>, TestError> {
        let context = self.context;
        submit_commands_and_wait(context.get_device(), context.get_universal_queue(), *self.cmd_buffer)?;

        match self.render_type {
            RenderType::Resolve | RenderType::DepthStencilOnly | RenderType::UnusedAttachment => {
                let resolve = self.resolve.as_ref().expect("these render types resolve");
                Ok(Some(read_color_attachment(
                    context,
                    resolve.image.get(),
                    self.color_format,
                    self.render_size,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                )?))
            }
            RenderType::SingleSample => Ok(Some(read_color_attachment(
                context,
                self.color.image.get(),
                self.color_format,
                self.render_size,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?)),
            RenderType::CopySamples => Ok(None),
        }
    }

    /// `MultisampleRenderer::getSingleSampledImage`
    fn get_single_sampled_image(&self, sample_id: usize) -> Result<TextureLevel, TestError> {
        read_color_attachment(
            self.context,
            self.per_sample_images[sample_id].image.get(),
            self.color_format,
            self.render_size,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )
    }

    /// `MultisampleRenderer::renderReusingDepth` - draws a full screen triangle that passes only where the depth buffer still holds
    /// the clear value, over the depth buffer the first render left behind.
    fn render_reusing_depth(&self) -> Result<TextureLevel, TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let sample_count = self.multisample.samples;
        let depth_stencil = self
            .depth_stencil
            .as_ref()
            .expect("the depth check renders with a depth buffer");

        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let second_color_buffer = make_attachment(
            context,
            self.render_size,
            self.color_format,
            sample_count,
            color_usage,
            vk::ImageAspectFlags::COLOR,
        )?;
        let second_resolve_buffer = make_attachment(
            context,
            self.render_size,
            self.color_format,
            vk::SampleCountFlags::_1,
            color_usage,
            vk::ImageAspectFlags::COLOR,
        )?;

        let pc_size = std::mem::size_of::<f32>() as u32;
        let pc_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: pc_size,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&pc_ranges);
        let pipeline_layout =
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?;
        let pipeline_layout = Unique::new(device, pipeline_layout);

        let attachment_descriptions = [
            // Color attachment.
            vk::AttachmentDescription::builder()
                .format(self.color_format)
                .samples(sample_count)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            // Depth/stencil attachment.
            vk::AttachmentDescription::builder()
                .format(self.depth_stencil_format)
                .samples(sample_count)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
            // Resolve attachment.
            vk::AttachmentDescription::builder()
                .format(self.color_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        ];

        let color_attachment_reference = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let ds_attachment_reference = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let resolve_attachment_reference = [vk::AttachmentReference {
            attachment: 2,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];

        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_reference)
            .resolve_attachments(&resolve_attachment_reference)
            .depth_stencil_attachment(&ds_attachment_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        let render_pass = Unique::new(device, render_pass);

        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[
                *second_color_buffer.view,
                *depth_stencil.view,
                *second_resolve_buffer.view,
            ],
            self.render_size.0,
            self.render_size.1,
            1,
        )?;

        let stencil_op_state = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::KEEP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::NEVER,
            compare_mask: 0,
            write_mask: 0,
            reference: 0,
        };

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("checkDepth-vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("color_frag")?)?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(self.render_size.0, self.render_size.1);
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        // This is the key to test the depth buffer contains the clear value and has not been written to:
        // The comparison op is EQUAL, so we will only draw if the depth buffer contains the expected value.
        state.depth_stencil = default_depth_stencil_state();
        state.depth_stencil.depth_test_enable = vk::TRUE;
        state.depth_stencil.depth_write_enable = vk::FALSE;
        state.depth_stencil.depth_compare_op = vk::CompareOp::EQUAL;
        state.depth_stencil.stencil_test_enable = vk::FALSE;
        state.depth_stencil.front = stencil_op_state;
        state.depth_stencil.back = stencil_op_state;
        state.samples = sample_count;
        state.sample_shading = false;
        state.min_sample_shading = 1.0;
        let shader_objects = make_shader_objects(context, "checkDepth-vert", Some("color_frag"), &[], &pc_ranges)?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        }];

        begin_command_buffer(device, cmd)?;
        unsafe {
            // Make sure the previous depth buffer writes have completed already.
            let depth_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
                .dst_access_mask(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                )
                .build();
            let depth_stages =
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
            device.cmd_pipeline_barrier(
                cmd,
                depth_stages,
                depth_stages,
                vk::DependencyFlags::empty(),
                &[depth_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            if let Some(objects) = &shader_objects {
                let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
                let to_attachment = [
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        second_color_buffer.image.get(),
                        color_range,
                    ),
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        second_resolve_buffer.image.get(),
                        color_range,
                    ),
                ];
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &to_attachment,
                );
                begin_rendering_ms(
                    device,
                    cmd,
                    self.render_size,
                    Some((*second_color_buffer.view, Some(*second_resolve_buffer.view))),
                    false,
                    clear_values[0],
                    Some((
                        *depth_stencil.view,
                        get_image_aspect_flags(self.depth_stencil_format),
                        true,
                        false,
                    )),
                    vk::AttachmentLoadOp::LOAD,
                    self.depth_clear_value,
                );
                objects.bind(cmd, &state);
                device.cmd_push_constants(
                    cmd,
                    *pipeline_layout,
                    vk::ShaderStageFlags::VERTEX,
                    0,
                    &self.depth_clear_value.to_ne_bytes(),
                );
                device.cmd_draw(cmd, 3, 1, 0, 0);
                end_dynamic_rendering(device, cmd);
            } else if let Some(pipeline) = &pipeline {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffer)
                    .render_area(rect_2d(self.render_size.0, self.render_size.1))
                    .clear_values(&clear_values);
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                device.cmd_push_constants(
                    cmd,
                    *pipeline_layout,
                    vk::ShaderStageFlags::VERTEX,
                    0,
                    &self.depth_clear_value.to_ne_bytes(),
                );
                device.cmd_draw(cmd, 3, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        read_color_attachment(
            context,
            second_resolve_buffer.image.get(),
            self.color_format,
            self.render_size,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    /// `RasterizationSamplesTest`, with its `TestModeFlags`.
    RasterizationSamples(u32),
    /// `MinSampleShadingTest`, with `minSampleShadingEnabled`.
    MinSampleShading(bool),
    SampleMask,
    AlphaToOne,
    /// `AlphaToCoverageTest`, with `checkDepthBuffer`.
    AlphaToCoverage(bool),
    AlphaToCoverageNoColorAttachment,
    AlphaToCoverageColorUnusedAttachment,
}

struct MultisampleCase {
    name: String,
    kind: Kind,
    geometry_type: GeometryType,
    point_size: f32,
    multisample: MultisampleParams,
    blend_state: vk::PipelineColorBlendAttachmentState,
}

impl MultisampleCase {
    #[allow(clippy::new_ret_no_self)]
    fn new(
        name: &str,
        kind: Kind,
        geometry_type: GeometryType,
        point_size: f32,
        multisample: MultisampleParams,
        blend_state: vk::PipelineColorBlendAttachmentState,
    ) -> Box<dyn TestCase> {
        Box::new(Self {
            name: name.to_string(),
            kind,
            geometry_type,
            point_size,
            multisample,
            blend_state,
        })
    }

    /// The case of the shader manifest this test's `initPrograms` builds.
    fn program_set(&self) -> &'static str {
        let point_variant = self.geometry_type == GeometryType::OpaquePoint;
        match self.kind {
            Kind::MinSampleShading(_) => {
                if !point_variant {
                    "sample_shading"
                } else if self.point_size == 1.0 {
                    "sample_shading_point1"
                } else {
                    "sample_shading_point3"
                }
            }
            Kind::AlphaToCoverage(true) => "color_check_depth",
            Kind::AlphaToCoverageColorUnusedAttachment => "unused_attachment",
            _ => {
                if !point_variant {
                    "color"
                } else if self.point_size == 1.0 {
                    "color_point1"
                } else {
                    "color_point3"
                }
            }
        }
    }
}

impl TestCase for MultisampleCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MultisampleTest::checkSupport` and the override of each test kind.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();

        if self.geometry_type == GeometryType::OpaquePoint
            && self.point_size > 1.0
            && features.large_points == vk::FALSE
        {
            return Err(TestError::NotSupported("Large points not supported".to_string()));
        }

        match self.kind {
            Kind::MinSampleShading(_) if features.sample_rate_shading == vk::FALSE => {
                return Err(TestError::NotSupported("Sample rate shading not supported".to_string()));
            }
            Kind::AlphaToOne if features.alpha_to_one == vk::FALSE => {
                return Err(TestError::NotSupported("Alpha to one not supported".to_string()));
            }
            _ => {}
        }

        if !is_supported_sample_count(context, self.multisample.samples) {
            return Err(TestError::NotSupported(
                "Unsupported number of rasterization samples".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program_set = self.program_set();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == program_set)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {program_set}"))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleInstance {
            context,
            kind: self.kind,
            geometry_type: self.geometry_type,
            point_size: self.point_size,
            topology: get_primitive_topology(self.geometry_type),
            vertices: generate_vertices(self.geometry_type),
            multisample: self.multisample,
            blend_state: self.blend_state,
        })
    }
}

struct MultisampleInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    geometry_type: GeometryType,
    point_size: f32,
    topology: vk::PrimitiveTopology,
    vertices: Vec<Vertex4Rgba>,
    multisample: MultisampleParams,
    blend_state: vk::PipelineColorBlendAttachmentState,
}

impl<'a> MultisampleInstance<'a> {
    /// A resolved render of the test's geometry with the given multisample state.
    fn render_resolved(
        &self,
        multisample: MultisampleParams,
        render_type: RenderType,
    ) -> Result<TextureLevel, TestError> {
        let renderer = MultisampleRenderer::new(
            self.context,
            RendererConfig::color_only(
                COLOR_FORMAT,
                self.topology,
                &self.vertices,
                multisample,
                self.blend_state,
                render_type,
            ),
        )?;
        Ok(renderer.render()?.expect("this render type reads its image back"))
    }

    /// `RasterizationSamplesInstance`
    fn iterate_rasterization_samples(&self, mode_flags: u32) -> TestOutcome {
        let context = self.context;

        let result = if mode_flags != 0 {
            let use_depth = (mode_flags & TEST_MODE_DEPTH_BIT) != 0;
            let use_stencil = (mode_flags & TEST_MODE_STENCIL_BIT) != 0;
            let depth_stencil_format = find_supported_depth_stencil_format(context, use_depth, use_stencil);

            if depth_stencil_format == vk::Format::UNDEFINED {
                return Err(TestError::NotSupported(
                    "Required depth/stencil format is not supported".to_string(),
                ));
            }

            let config = RendererConfig {
                color_format: COLOR_FORMAT,
                depth_stencil_format,
                use_depth,
                use_stencil,
                topologies: vec![self.topology, vk::PrimitiveTopology::TRIANGLE_STRIP],
                vertices: vec![
                    self.vertices.clone(),
                    generate_vertices(GeometryType::OpaqueQuadNonzeroDepth),
                ],
                multisample: self.multisample,
                blend_state: self.blend_state,
                render_type: RenderType::Resolve,
                depth_clear_value: 1.0,
                render_size: RENDER_SIZE,
                conservative: None,
            };
            let renderer = MultisampleRenderer::new(context, config)?;
            renderer.render()?.expect("resolve render type reads its image back")
        } else {
            self.render_resolved(self.multisample, RenderType::Resolve)?
        };

        // Verify range of unique pixels
        {
            let num_unique_colors = get_unique_colors_count(&result);
            let min_unique_colors = if self.topology == vk::PrimitiveTopology::POINT_LIST && self.point_size == 1.0 {
                2
            } else {
                3
            };

            if num_unique_colors < min_unique_colors {
                return Ok(TestStatus::fail("Unique colors out of expected bounds"));
            }
        }

        // Verify shape of the rendered primitive (fuzzy-compare)
        {
            let tcu_color_format = map_vk_format(COLOR_FORMAT).expect("RGBA8 has a texture format");
            let vertex_shader = ColorVertexShader::new();
            let fragment_shader = ColorFragmentShader::new(tcu_color_format, None, false);
            let program = Program {
                vertex_shader: &vertex_shader,
                fragment_shader: &fragment_shader,
                geometry_shader: None,
            };
            let mut ref_renderer = ReferenceRenderer::new(RENDER_SIZE.0, RENDER_SIZE.1, tcu_color_format, None)?;
            let mut render_state = RenderState::new(
                ref_renderer.get_viewport_state(),
                context.get_device_properties().limits.sub_pixel_precision_bits as i32,
            );

            if self.topology == vk::PrimitiveTopology::POINT_LIST {
                // gl_PointSize is clamped to pointSizeRange
                render_state.point.point_size = self
                    .point_size
                    .min(context.get_device_properties().limits.point_size_range[1]);
            }

            if mode_flags == 0 {
                ref_renderer.color_clear([0.0; 4]);
            } else {
                // For depth/stencil case the primitive is invisible and the surroundings are filled red.
                ref_renderer.color_clear([1.0, 0.0, 0.0, 1.0]);
            }
            ref_renderer.draw(
                &program,
                &render_state,
                map_vk_primitive_topology(self.topology),
                &self.vertices,
            );

            if fuzzy_compare_ok(&ref_renderer.get_access(), &result.get_const_access(), 0.05) != Some(true) {
                return Ok(TestStatus::fail("Primitive has unexpected shape"));
            }
        }

        Ok(TestStatus::pass(
            "Primitive rendered, unique colors within expected bounds",
        ))
    }

    /// `MinSampleShadingInstance::iterate`
    fn iterate_min_sample_shading(&self, enabled: bool) -> TestOutcome {
        // Render and resolve without sample shading
        let mut no_sample_shading_params = self.multisample;
        no_sample_shading_params.sample_shading_enable = false;
        no_sample_shading_params.min_sample_shading = 0.0;
        let no_sample_shading_image = self.render_resolved(no_sample_shading_params, RenderType::Resolve)?;

        // Render with test minSampleShading and collect per-sample images
        let renderer = MultisampleRenderer::new(
            self.context,
            RendererConfig::color_only(
                COLOR_FORMAT,
                self.topology,
                &self.vertices,
                self.multisample,
                self.blend_state,
                RenderType::CopySamples,
            ),
        )?;
        renderer.render()?;

        let mut sample_shaded_images = Vec::new();
        for sample_id in 0..sample_count_value(self.multisample.samples) as usize {
            sample_shaded_images.push(renderer.get_single_sampled_image(sample_id)?);
        }

        if enabled {
            Ok(self.verify_sample_shaded_image(&sample_shaded_images, &no_sample_shading_image))
        } else {
            Ok(Self::verify_sample_shaded_image_disabled(
                &sample_shaded_images,
                &no_sample_shading_image,
            ))
        }
    }

    /// `MinSampleShadingInstance::verifySampleShadedImage`
    fn verify_sample_shaded_image(
        &self,
        sample_shaded_images: &[TextureLevel],
        no_sample_shading_image: &TextureLevel,
    ) -> TestStatus {
        let pixel_value = |image: &TextureLevel, pixel_ndx: usize| -> u32 {
            let bytes = &image.data()[pixel_ndx * 4..pixel_ndx * 4 + 4];
            u32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]])
        };
        let size = no_sample_shading_image.size();
        let pixel_count = (size[0] * size[1] * size[2]) as usize;

        let mut any_pixel_covered = false;

        for pixel_ndx in 0..pixel_count {
            let no_sample_shading_value = pixel_value(no_sample_shading_image, pixel_ndx);

            if no_sample_shading_value == 0 {
                // non-covered pixel, continue
                continue;
            }
            any_pixel_covered = true;

            let mut num_not_covered_samples = 0;

            // Collect histogram of occurrences or each pixel across all samples
            let mut histogram: HashSet<u32> = HashSet::new();
            for sample_shaded_image in sample_shaded_images {
                let sample_shaded_value = pixel_value(sample_shaded_image, pixel_ndx);

                if sample_shaded_value == 0 {
                    num_not_covered_samples += 1;
                    continue;
                }
                histogram.insert(sample_shaded_value);
            }

            if num_not_covered_samples == sample_shaded_images.len() as i32 {
                return TestStatus::fail("Got uncovered pixel, where covered samples were expected");
            }

            let unique_colors_count = histogram.len() as i32;
            let expected_unique_samples_count =
                (self.multisample.min_sample_shading * sample_shaded_images.len() as f32 + 0.5) as i32;

            if unique_colors_count + num_not_covered_samples < expected_unique_samples_count {
                return TestStatus::fail("Got less unique colors than requested through minSampleShading");
            }
        }

        if !any_pixel_covered {
            return TestStatus::fail("Did not get any covered pixel, cannot test minSampleShading");
        }

        TestStatus::pass("Got proper count of unique colors")
    }

    /// `MinSampleShadingDisabledInstance::verifySampleShadedImage`
    fn verify_sample_shaded_image_disabled(
        sample_shaded_images: &[TextureLevel],
        no_sample_shading_image: &TextureLevel,
    ) -> TestStatus {
        let samples_count = sample_shaded_images.len() as u32;
        let [width, height, depth] = no_sample_shading_image.size();
        let no_sample_shading_access = no_sample_shading_image.get_const_access();
        let zero_pixel = [0u32; 4];
        let mut any_pixel_covered = false;

        debug_assert!(depth == 1);

        for y in 0..height {
            for x in 0..width {
                let no_sample_shading_value = no_sample_shading_access.get_pixel_uint(x, y, 0);

                if no_sample_shading_value == zero_pixel {
                    continue;
                }

                any_pixel_covered = true;
                let mut sample_shading_value = [0u32; 4];

                // Collect histogram of occurrences or each pixel across all samples
                for sample_shaded_image in sample_shaded_images {
                    let sample_shaded_value = sample_shaded_image.get_const_access().get_pixel_uint(x, y, 0);

                    for (sum, value) in sample_shading_value.iter_mut().zip(sample_shaded_value) {
                        *sum += value;
                    }
                }

                for value in sample_shading_value.iter_mut() {
                    *value /= samples_count;
                }

                if sample_shading_value[3] != 255 {
                    return TestStatus::fail("Invalid Alpha channel value");
                }

                if sample_shading_value != no_sample_shading_value {
                    return TestStatus::fail("Invalid color");
                }
            }
        }

        if !any_pixel_covered {
            return TestStatus::fail("Did not get any covered pixel, cannot test minSampleShadingDisabled");
        }

        TestStatus::pass("Got proper count of unique colors")
    }

    /// `SampleMaskInstance::iterate`
    fn iterate_sample_mask(&self) -> TestOutcome {
        // Render with test flags
        let test_sample_mask_image = self.render_resolved(self.multisample, RenderType::Resolve)?;

        // Render with all flags off
        let mut all_off = self.multisample;
        all_off.sample_mask = Some(0);
        let min_sample_mask_image = self.render_resolved(all_off, RenderType::Resolve)?;

        // Render with all flags on
        let mut all_on = self.multisample;
        all_on.sample_mask = Some(!0);
        let max_sample_mask_image = self.render_resolved(all_on, RenderType::Resolve)?;

        let test_color_count = get_unique_colors_count(&test_sample_mask_image);
        let min_color_count = get_unique_colors_count(&min_sample_mask_image);
        let max_color_count = get_unique_colors_count(&max_sample_mask_image);

        if min_color_count > test_color_count || test_color_count > max_color_count {
            Ok(TestStatus::fail("Unique colors out of expected bounds"))
        } else {
            Ok(TestStatus::pass("Unique colors within expected bounds"))
        }
    }

    /// `AlphaToOneInstance::iterate`
    fn iterate_alpha_to_one(&self) -> TestOutcome {
        debug_assert!(self.multisample.alpha_to_one_enable);
        debug_assert!(self.blend_state.blend_enable == vk::TRUE);

        let render_type = if self.multisample.samples == vk::SampleCountFlags::_1 {
            RenderType::SingleSample
        } else {
            RenderType::Resolve
        };

        // Render with blend enabled and alpha to one on
        let alpha_one_image = self.render_resolved(self.multisample, render_type)?;

        // Render with blend enabled and alpha to one off
        let mut no_alpha_one_params = self.multisample;
        no_alpha_one_params.alpha_to_one_enable = false;
        let no_alpha_one_image = self.render_resolved(no_alpha_one_params, render_type)?;

        let alpha_one_access = alpha_one_image.get_const_access();
        let no_alpha_one_access = no_alpha_one_image.get_const_access();

        for y in 0..RENDER_SIZE.1 {
            for x in 0..RENDER_SIZE.0 {
                let alpha_one_pixel = alpha_one_access.get_pixel(x, y, 0);
                let no_alpha_one_pixel = no_alpha_one_access.get_pixel(x, y, 0);

                if alpha_one_pixel[3] != 1.0 {
                    return Ok(TestStatus::fail(format!(
                        "Unsatisfied condition: {alpha_one_pixel:?} doesn't have alpha set to 1"
                    )));
                }

                if !(0..4).all(|channel| alpha_one_pixel[channel] >= no_alpha_one_pixel[channel]) {
                    return Ok(TestStatus::fail(format!(
                        "Unsatisfied condition: {alpha_one_pixel:?} >= {no_alpha_one_pixel:?}"
                    )));
                }
            }
        }

        Ok(TestStatus::pass(
            "Image rendered with alpha-to-one contains pixels of image rendered with no alpha-to-one",
        ))
    }

    /// `AlphaToCoverageInstance::iterate`
    fn iterate_alpha_to_coverage(&self, check_depth_buffer: bool) -> TestOutcome {
        debug_assert!(self.multisample.alpha_to_coverage_enable);

        let config = RendererConfig {
            color_format: COLOR_FORMAT,
            depth_stencil_format: vk::Format::D16_UNORM,
            use_depth: check_depth_buffer,
            use_stencil: false,
            topologies: vec![self.topology],
            vertices: vec![self.vertices.clone()],
            multisample: self.multisample,
            blend_state: self.blend_state,
            render_type: RenderType::Resolve,
            depth_clear_value: 1.0,
            render_size: RENDER_SIZE,
            conservative: None,
        };
        let renderer = MultisampleRenderer::new(self.context, config)?;
        let result = renderer.render()?.expect("resolve render type reads its image back");

        let color_status = self.verify_alpha_to_coverage_image(&result);
        let mut depth_status = TestStatus::pass("Pass");

        if check_depth_buffer {
            let redraw_result = renderer.render_reusing_depth()?;
            depth_status = Self::verify_depth_buffer_check(&redraw_result);
        }

        if color_status.is_fail() {
            return Ok(color_status);
        }

        if depth_status.is_fail() {
            return Ok(depth_status);
        }

        Ok(color_status)
    }

    /// `AlphaToCoverageInstance::verifyDepthBufferCheck`
    fn verify_depth_buffer_check(result: &TextureLevel) -> TestStatus {
        let ref_color = [0.0f32, 0.0, 1.0, 1.0]; // Must match "checkDepth-vert".
        let access = result.get_const_access();

        for y in 0..RENDER_SIZE.1 {
            for x in 0..RENDER_SIZE.0 {
                if access.get_pixel(x, y, 0) != ref_color {
                    return TestStatus::fail("Depth buffer verification failed: depth buffer was not clear");
                }
            }
        }
        TestStatus::pass("Pass")
    }

    /// `AlphaToCoverageInstance::verifyImage`
    fn verify_alpha_to_coverage_image(&self, result: &TextureLevel) -> TestStatus {
        let (max_color_value, min_color_value) = match self.geometry_type {
            GeometryType::OpaqueQuad => (1.01f32, 0.99f32),
            GeometryType::TranslucentQuad => (0.52, 0.0),
            GeometryType::InvisibleQuad => (0.01, 0.0),
            _ => (0.0, 0.0),
        };

        let access = result.get_const_access();
        for y in 0..RENDER_SIZE.1 {
            for x in 0..RENDER_SIZE.0 {
                let red = access.get_pixel(x, y, 0)[0];

                if red > max_color_value || red < min_color_value {
                    return TestStatus::fail(format!(
                        "Pixel is not in the expected range: {red} not in [{min_color_value}, {max_color_value}]"
                    ));
                }
            }
        }

        TestStatus::pass("Image matches reference value")
    }

    /// `AlphaToCoverageNoColorAttachmentInstance::iterate`
    fn iterate_alpha_to_coverage_no_color_attachment(&self) -> TestOutcome {
        debug_assert!(self.multisample.alpha_to_coverage_enable);

        let config = RendererConfig {
            color_format: COLOR_FORMAT,
            depth_stencil_format: vk::Format::D16_UNORM,
            use_depth: true,
            use_stencil: false,
            topologies: vec![self.topology],
            vertices: vec![self.vertices.clone()],
            multisample: self.multisample,
            blend_state: self.blend_state,
            render_type: RenderType::DepthStencilOnly,
            depth_clear_value: 1.0,
            render_size: RENDER_SIZE,
            conservative: None,
        };
        let renderer = MultisampleRenderer::new(self.context, config)?;
        let result = renderer
            .render()?
            .expect("depth/stencil only render type reads its image back");
        let access = result.get_const_access();

        for y in 0..RENDER_SIZE.1 {
            for x in 0..RENDER_SIZE.0 {
                // Expect full red for each pixel. Fail if clear color is showing.
                if access.get_pixel(x, y, 0)[0] < 1.0 {
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `AlphaToCoverageColorUnusedAttachmentInstance::iterate`
    fn iterate_alpha_to_coverage_color_unused_attachment(&self) -> TestOutcome {
        debug_assert!(self.multisample.alpha_to_coverage_enable);

        let color_format = vk::Format::R5G6B5_UNORM_PACK16;
        let renderer = MultisampleRenderer::new(
            self.context,
            RendererConfig::color_only(
                color_format,
                self.topology,
                &self.vertices,
                self.multisample,
                self.blend_state,
                RenderType::UnusedAttachment,
            ),
        )?;
        let result = renderer
            .render()?
            .expect("unused attachment render type reads its image back");
        let access = result.get_const_access();

        for y in 0..RENDER_SIZE.1 {
            for x in 0..RENDER_SIZE.0 {
                // Quad color gets written to color buffer at location 1, and the alpha value to location 0 which is unused.
                // The coverage should still be affected by the alpha written to location 0.
                let red = access.get_pixel(x, y, 0)[0];
                if (self.geometry_type == GeometryType::OpaqueQuad && red < 1.0)
                    || (self.geometry_type == GeometryType::InvisibleQuad && red > 0.0)
                {
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for MultisampleInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::RasterizationSamples(mode_flags) => self.iterate_rasterization_samples(mode_flags),
            Kind::MinSampleShading(enabled) => self.iterate_min_sample_shading(enabled),
            Kind::SampleMask => self.iterate_sample_mask(),
            Kind::AlphaToOne => self.iterate_alpha_to_one(),
            Kind::AlphaToCoverage(check_depth_buffer) => self.iterate_alpha_to_coverage(check_depth_buffer),
            Kind::AlphaToCoverageNoColorAttachment => self.iterate_alpha_to_coverage_no_color_attachment(),
            Kind::AlphaToCoverageColorUnusedAttachment => self.iterate_alpha_to_coverage_color_unused_attachment(),
        }
    }
}

/// `testRasterSamplesConsistency`
struct RasterSamplesConsistencyCase;

impl TestCase for RasterSamplesConsistencyCase {
    fn name(&self) -> &str {
        "unique_colors_check"
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !is_supported_sample_count(context, vk::SampleCountFlags::_2) {
            return Err(TestError::NotSupported(
                "Unsupported number of rasterization samples".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "color")
            .expect("the shader manifest has the color case")
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RasterSamplesConsistencyInstance { context })
    }
}

struct RasterSamplesConsistencyInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for RasterSamplesConsistencyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let samples = [
            vk::SampleCountFlags::_1,
            vk::SampleCountFlags::_2,
            vk::SampleCountFlags::_4,
            vk::SampleCountFlags::_8,
            vk::SampleCountFlags::_16,
            vk::SampleCountFlags::_32,
            vk::SampleCountFlags::_64,
        ];

        let vertices = vec![
            Vertex4Rgba {
                position: [-0.75, 0.0, 0.0, 1.0],
                color: [1.0, 0.0, 0.0, 1.0],
            },
            Vertex4Rgba {
                position: [0.75, 0.125, 0.0, 1.0],
                color: [1.0, 0.0, 0.0, 1.0],
            },
            Vertex4Rgba {
                position: [0.75, -0.125, 0.0, 1.0],
                color: [1.0, 0.0, 0.0, 1.0],
            },
        ];
        let mut prev_unique_colors = 2;
        let mut render_count = 0;

        // Do not render with 1 sample (start with samplesNdx = 1).
        for samples_ndx in 1..samples.len() {
            if !is_supported_sample_count(context, samples[samples_ndx])
                || !super::fsr_ambient::ambient_rates_support(samples[samples_ndx])
            {
                continue;
            }

            let renderer = MultisampleRenderer::new(
                context,
                RendererConfig::color_only(
                    COLOR_FORMAT,
                    vk::PrimitiveTopology::TRIANGLE_LIST,
                    &vertices,
                    MultisampleParams::new(samples[samples_ndx]),
                    default_color_blend_attachment_state(),
                    RenderType::Resolve,
                ),
            )?;
            let result = renderer.render()?.expect("resolve render type reads its image back");
            let unique_colors = get_unique_colors_count(&result);

            render_count += 1;

            if prev_unique_colors > unique_colors {
                return Ok(TestStatus::fail(format!(
                    "More unique colors generated with {} than with {}",
                    sample_count_value(samples[samples_ndx - 1]),
                    sample_count_value(samples[samples_ndx])
                )));
            }

            prev_unique_colors = unique_colors;
        }

        if render_count == 0 {
            return Err(TestError::NotSupported("Multisampling is unsupported".to_string()));
        }

        Ok(TestStatus::pass(
            "Number of unique colors increases as the sample count increases",
        ))
    }
}

fn samples_group_name(samples: vk::SampleCountFlags) -> String {
    format!("samples_{}", sample_count_value(samples))
}

/// The multisample state of a test that only sets the sample count.
fn rasterization_samples_params(samples: vk::SampleCountFlags) -> MultisampleParams {
    MultisampleParams::new(samples)
}

/// The groups of `createMultisampleTests` this port has, added to the `multisample` group.
pub fn add_multisample_tests(multisample_tests: &mut TestCaseGroup) {
    add_multisample_tests_for(multisample_tests, false);
}

/// `add_multisample_tests`; the shader object types have no `min_sample_shading` groups (the sample copy needs input
/// attachments) and no `raster_samples_consistency`.
pub fn add_multisample_tests_for(multisample_tests: &mut TestCaseGroup, shader_object: bool) {
    let default_blend = default_color_blend_attachment_state();

    // Rasterization samples tests
    {
        let mut rasterization_samples_tests = TestCaseGroup::new("raster_samples");

        for samples in SAMPLE_COUNTS {
            let mut samples_tests = TestCaseGroup::new(samples_group_name(samples));
            let params = rasterization_samples_params(samples);

            samples_tests.add_child(MultisampleCase::new(
                "primitive_triangle",
                Kind::RasterizationSamples(0),
                GeometryType::OpaqueTriangle,
                1.0,
                params,
                default_blend,
            ));
            samples_tests.add_child(MultisampleCase::new(
                "primitive_line",
                Kind::RasterizationSamples(0),
                GeometryType::OpaqueLine,
                1.0,
                params,
                default_blend,
            ));
            samples_tests.add_child(MultisampleCase::new(
                "primitive_point_1px",
                Kind::RasterizationSamples(0),
                GeometryType::OpaquePoint,
                1.0,
                params,
                default_blend,
            ));
            samples_tests.add_child(MultisampleCase::new(
                "primitive_point",
                Kind::RasterizationSamples(0),
                GeometryType::OpaquePoint,
                3.0,
                params,
                default_blend,
            ));

            samples_tests.add_child(MultisampleCase::new(
                "depth",
                Kind::RasterizationSamples(TEST_MODE_DEPTH_BIT),
                GeometryType::InvisibleTriangle,
                1.0,
                params,
                default_blend,
            ));
            samples_tests.add_child(MultisampleCase::new(
                "stencil",
                Kind::RasterizationSamples(TEST_MODE_STENCIL_BIT),
                GeometryType::InvisibleTriangle,
                1.0,
                params,
                default_blend,
            ));
            samples_tests.add_child(MultisampleCase::new(
                "depth_stencil",
                Kind::RasterizationSamples(TEST_MODE_DEPTH_BIT | TEST_MODE_STENCIL_BIT),
                GeometryType::InvisibleTriangle,
                1.0,
                params,
                default_blend,
            ));

            rasterization_samples_tests.add_child(samples_tests);
        }

        multisample_tests.add_child(rasterization_samples_tests);
    }

    // Raster samples consistency check
    if !shader_object {
        let mut raster_samples_consistency_tests = TestCaseGroup::new("raster_samples_consistency");
        raster_samples_consistency_tests.add_child(Box::new(RasterSamplesConsistencyCase) as Box<dyn TestCase>);
        multisample_tests.add_child(raster_samples_consistency_tests);
    }

    // minSampleShading tests
    if !shader_object {
        let test_configs: [(&str, f32); 5] = [
            ("min_0_0", 0.0),
            ("min_0_25", 0.25),
            ("min_0_5", 0.5),
            ("min_0_75", 0.75),
            ("min_1_0", 1.0),
        ];
        let min_sample_shading_params =
            |samples: vk::SampleCountFlags, min_sample_shading: f32, enabled: bool| MultisampleParams {
                samples,
                sample_shading_enable: enabled,
                min_sample_shading,
                sample_mask: None,
                alpha_to_coverage_enable: false,
                alpha_to_one_enable: false,
            };

        {
            let mut min_sample_shading_tests = TestCaseGroup::new("min_sample_shading");

            for (config_name, min_sample_shading) in test_configs {
                let mut min_shading_value_tests = TestCaseGroup::new(config_name);

                for samples in SAMPLE_COUNTS {
                    let mut samples_tests = TestCaseGroup::new(samples_group_name(samples));
                    let params = min_sample_shading_params(samples, min_sample_shading, true);

                    samples_tests.add_child(MultisampleCase::new(
                        "primitive_triangle",
                        Kind::MinSampleShading(true),
                        GeometryType::OpaqueTriangle,
                        1.0,
                        params,
                        default_blend,
                    ));
                    samples_tests.add_child(MultisampleCase::new(
                        "primitive_line",
                        Kind::MinSampleShading(true),
                        GeometryType::OpaqueLine,
                        1.0,
                        params,
                        default_blend,
                    ));
                    samples_tests.add_child(MultisampleCase::new(
                        "primitive_point_1px",
                        Kind::MinSampleShading(true),
                        GeometryType::OpaquePoint,
                        1.0,
                        params,
                        default_blend,
                    ));
                    samples_tests.add_child(MultisampleCase::new(
                        "primitive_point",
                        Kind::MinSampleShading(true),
                        GeometryType::OpaquePoint,
                        3.0,
                        params,
                        default_blend,
                    ));

                    min_shading_value_tests.add_child(samples_tests);
                }

                min_sample_shading_tests.add_child(min_shading_value_tests);
            }

            multisample_tests.add_child(min_sample_shading_tests);
        }

        for (group_name, enabled) in [
            ("min_sample_shading_enabled", true),
            ("min_sample_shading_disabled", false),
        ] {
            let mut min_sample_shading_tests = TestCaseGroup::new(group_name);

            for (config_name, min_sample_shading) in test_configs {
                let mut min_shading_value_tests = TestCaseGroup::new(config_name);

                for samples in SAMPLE_COUNTS {
                    let mut samples_tests = TestCaseGroup::new(samples_group_name(samples));
                    let params = min_sample_shading_params(samples, min_sample_shading, enabled);

                    samples_tests.add_child(MultisampleCase::new(
                        "quad",
                        Kind::MinSampleShading(enabled),
                        GeometryType::OpaqueQuad,
                        1.0,
                        params,
                        default_blend,
                    ));

                    min_shading_value_tests.add_child(samples_tests);
                }

                min_sample_shading_tests.add_child(min_shading_value_tests);
            }

            multisample_tests.add_child(min_sample_shading_tests);
        }
    }

    // SampleMask tests
    {
        // upstream names the all-zero mask "mask_all_on" and the all-ones one "mask_all_off"
        let test_configs: [(&str, u32); 4] = [
            ("mask_all_on", 0x0),
            ("mask_all_off", 0xFFFF_FFFF),
            ("mask_one", 0x1),
            ("mask_random", 0xAAAA_AAAA),
        ];

        let mut sample_mask_tests = TestCaseGroup::new("sample_mask");

        for (config_name, sample_mask) in test_configs {
            let mut sample_mask_value_tests = TestCaseGroup::new(config_name);

            for samples in SAMPLE_COUNTS {
                let mut samples_tests = TestCaseGroup::new(samples_group_name(samples));
                let mut params = MultisampleParams::new(samples);
                params.sample_mask = Some(sample_mask);

                samples_tests.add_child(MultisampleCase::new(
                    "primitive_triangle",
                    Kind::SampleMask,
                    GeometryType::OpaqueTriangle,
                    1.0,
                    params,
                    default_blend,
                ));
                samples_tests.add_child(MultisampleCase::new(
                    "primitive_line",
                    Kind::SampleMask,
                    GeometryType::OpaqueLine,
                    1.0,
                    params,
                    default_blend,
                ));
                samples_tests.add_child(MultisampleCase::new(
                    "primitive_point_1px",
                    Kind::SampleMask,
                    GeometryType::OpaquePoint,
                    1.0,
                    params,
                    default_blend,
                ));
                samples_tests.add_child(MultisampleCase::new(
                    "primitive_point",
                    Kind::SampleMask,
                    GeometryType::OpaquePoint,
                    3.0,
                    params,
                    default_blend,
                ));

                sample_mask_value_tests.add_child(samples_tests);
            }

            sample_mask_tests.add_child(sample_mask_value_tests);
        }

        multisample_tests.add_child(sample_mask_tests);
    }

    // AlphaToOne tests
    {
        let samples_for_alpha_to_one = [
            vk::SampleCountFlags::_1,
            vk::SampleCountFlags::_2,
            vk::SampleCountFlags::_4,
            vk::SampleCountFlags::_8,
            vk::SampleCountFlags::_16,
            vk::SampleCountFlags::_32,
            vk::SampleCountFlags::_64,
        ];
        let mut alpha_to_one_tests = TestCaseGroup::new("alpha_to_one");

        for samples in samples_for_alpha_to_one {
            let mut params = MultisampleParams::new(samples);
            params.alpha_to_one_enable = true;

            alpha_to_one_tests.add_child(MultisampleCase::new(
                &samples_group_name(samples),
                Kind::AlphaToOne,
                GeometryType::GradientQuad,
                1.0,
                params,
                alpha_to_one_blend_state(),
            ));
        }

        multisample_tests.add_child(alpha_to_one_tests);
    }

    let alpha_to_coverage_params = |samples: vk::SampleCountFlags| {
        let mut params = MultisampleParams::new(samples);
        params.alpha_to_coverage_enable = true;
        params
    };

    // AlphaToCoverageEnable tests
    {
        let mut alpha_to_coverage_tests = TestCaseGroup::new("alpha_to_coverage");

        for samples in SAMPLE_COUNTS {
            let mut samples_tests = TestCaseGroup::new(samples_group_name(samples));
            let params = alpha_to_coverage_params(samples);

            samples_tests.add_child(MultisampleCase::new(
                "alpha_opaque",
                Kind::AlphaToCoverage(false),
                GeometryType::OpaqueQuad,
                1.0,
                params,
                alpha_to_coverage_blend_state(false),
            ));
            samples_tests.add_child(MultisampleCase::new(
                "alpha_translucent",
                Kind::AlphaToCoverage(false),
                GeometryType::TranslucentQuad,
                1.0,
                params,
                alpha_to_coverage_blend_state(false),
            ));
            samples_tests.add_child(MultisampleCase::new(
                "alpha_invisible",
                Kind::AlphaToCoverage(false),
                GeometryType::InvisibleQuad,
                1.0,
                params,
                alpha_to_coverage_blend_state(false),
            ));
            samples_tests.add_child(MultisampleCase::new(
                "alpha_invisible_check_depth",
                Kind::AlphaToCoverage(true),
                GeometryType::InvisibleQuad,
                1.0,
                params,
                alpha_to_coverage_blend_state(true),
            ));

            alpha_to_coverage_tests.add_child(samples_tests);
        }

        multisample_tests.add_child(alpha_to_coverage_tests);
    }

    // AlphaToCoverageEnable without color buffer tests
    {
        let mut alpha_to_coverage_no_color_attachment_tests =
            TestCaseGroup::new("alpha_to_coverage_no_color_attachment");

        for samples in SAMPLE_COUNTS {
            let mut samples_tests = TestCaseGroup::new(samples_group_name(samples));
            let params = alpha_to_coverage_params(samples);

            samples_tests.add_child(MultisampleCase::new(
                "alpha_opaque",
                Kind::AlphaToCoverageNoColorAttachment,
                GeometryType::OpaqueQuad,
                1.0,
                params,
                alpha_to_coverage_blend_state(false),
            ));

            alpha_to_coverage_no_color_attachment_tests.add_child(samples_tests);
        }

        multisample_tests.add_child(alpha_to_coverage_no_color_attachment_tests);
    }

    // AlphaToCoverageEnable with unused color attachment:
    // Set color output at location 0 as unused, but use the alpha write to control coverage for rendering to color buffer at location 1.
    {
        let mut alpha_to_coverage_color_unused_attachment_tests =
            TestCaseGroup::new("alpha_to_coverage_unused_attachment");

        for samples in SAMPLE_COUNTS {
            let mut samples_tests = TestCaseGroup::new(samples_group_name(samples));
            let params = alpha_to_coverage_params(samples);

            samples_tests.add_child(MultisampleCase::new(
                "alpha_opaque",
                Kind::AlphaToCoverageColorUnusedAttachment,
                GeometryType::OpaqueQuad,
                1.0,
                params,
                alpha_to_coverage_blend_state(false),
            ));
            samples_tests.add_child(MultisampleCase::new(
                "alpha_invisible",
                Kind::AlphaToCoverageColorUnusedAttachment,
                GeometryType::InvisibleQuad,
                1.0,
                params,
                alpha_to_coverage_blend_state(false),
            ));

            alpha_to_coverage_color_unused_attachment_tests.add_child(samples_tests);
        }

        multisample_tests.add_child(alpha_to_coverage_color_unused_attachment_tests);
    }
}

use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_multisample_conservative as conservative_shaders;
use crate::generated::shaders::pipeline_multisample_depth_mask::*;

/// `SampleMaskWithDepthTestTest::initPrograms` for one case: the fragment shader depends on post depth coverage and on the number of
/// samples one invocation covers.
fn depth_mask_program(post_depth_coverage: bool, samples_per_fragment: u32) -> &'static SharedProgram {
    match (post_depth_coverage, samples_per_fragment) {
        (false, 2) => &DEPTH_MASK_PDC0_SPF2,
        (false, 4) => &DEPTH_MASK_PDC0_SPF4,
        (false, 7) => &DEPTH_MASK_PDC0_SPF7,
        (false, 8) => &DEPTH_MASK_PDC0_SPF8,
        (false, 14) => &DEPTH_MASK_PDC0_SPF14,
        (false, 16) => &DEPTH_MASK_PDC0_SPF16,
        (false, 28) => &DEPTH_MASK_PDC0_SPF28,
        (false, 56) => &DEPTH_MASK_PDC0_SPF56,
        (true, 2) => &DEPTH_MASK_PDC1_SPF2,
        (true, 4) => &DEPTH_MASK_PDC1_SPF4,
        (true, 8) => &DEPTH_MASK_PDC1_SPF8,
        (true, 16) => &DEPTH_MASK_PDC1_SPF16,
        (true, 32) => &DEPTH_MASK_PDC1_SPF32,
        (true, 64) => &DEPTH_MASK_PDC1_SPF64,
        _ => unreachable!("no sample_mask_with_depth_test shader for {post_depth_coverage} and {samples_per_fragment}"),
    }
}

struct SampleMaskWithDepthTestCase {
    name: String,
    rasterization_samples: vk::SampleCountFlags,
    enable_post_depth_coverage: bool,
    use_fragment_shading_rate: bool,
}

impl SampleMaskWithDepthTestCase {
    fn samples_per_fragment(&self) -> u32 {
        let samples = sample_count_value(self.rasterization_samples);
        let mut count = samples;
        if self.use_fragment_shading_rate {
            count *= 4;
            if !self.enable_post_depth_coverage {
                count -= samples / 2;
            }
        }
        count
    }
}

impl TestCase for SampleMaskWithDepthTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `SampleMaskWithDepthTestTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_properties().limits.standard_sample_locations == vk::FALSE {
            return Err(TestError::NotSupported("standardSampleLocations required".to_string()));
        }

        context.require_device_functionality("VK_EXT_post_depth_coverage")?;

        if self.use_fragment_shading_rate {
            context.require_device_functionality("VK_KHR_fragment_shading_rate")?;
            let mut properties = vk::PhysicalDeviceFragmentShadingRatePropertiesKHR::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            if properties.fragment_shading_rate_with_shader_sample_mask == vk::FALSE {
                return Err(TestError::NotSupported(
                    "fragmentShadingRateWithShaderSampleMask not supported".to_string(),
                ));
            }
        }

        if !is_supported_sample_count(context, self.rasterization_samples) {
            return Err(TestError::NotSupported(
                "Unsupported number of rasterization samples".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        depth_mask_program(self.enable_post_depth_coverage, self.samples_per_fragment()).programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SampleMaskWithDepthTestInstance {
            context,
            rasterization_samples: self.rasterization_samples,
            enable_post_depth_coverage: self.enable_post_depth_coverage,
            use_fragment_shading_rate: self.use_fragment_shading_rate,
        })
    }
}

struct SampleMaskWithDepthTestInstance<'a> {
    context: &'a Context<'a>,
    rasterization_samples: vk::SampleCountFlags,
    enable_post_depth_coverage: bool,
    use_fragment_shading_rate: bool,
}

impl SampleMaskWithDepthTestInstance<'_> {
    const RENDER_COLOR: [f32; 4] = [0.0, 1.0, 0.0, 1.0];

    /// `m_refCoverageAfterDepthTest`: the sample coverage of the diagonally halved pixel, with the maximum subPixelPrecisionBits threshold.
    fn ref_coverage_after_depth_test(&self) -> (u32, u32) {
        match sample_count_value(self.rasterization_samples) {
            2 => (1, 1),
            4 => (2, 2),
            8 => (2, 6),
            _ => (6, 11),
        }
    }

    /// `SampleMaskWithDepthTestInstance::generateVertices`
    fn generate_vertices() -> Vec<Vertex4Rgba> {
        vec![
            Vertex4Rgba {
                position: [-1.0, -1.0, 0.0, 1.0],
                color: Self::RENDER_COLOR,
            },
            Vertex4Rgba {
                position: [1.0, -1.0, 1.0, 1.0],
                color: Self::RENDER_COLOR,
            },
            Vertex4Rgba {
                position: [-1.0, 1.0, 1.0, 1.0],
                color: Self::RENDER_COLOR,
            },
        ]
    }

    /// `SampleMaskWithDepthTestInstance::verifyImage`
    fn verify_image(&self, result: &TextureLevel) -> TestStatus {
        let access = result.get_const_access();
        let [width, height, _] = result.size();
        let render_color = Self::RENDER_COLOR;
        let mut pass = true;

        for x in 0..width {
            for y in 0..height {
                let result_pixel = access.get_pixel(x, y, 0);

                if x + y == 0 {
                    let threshold = 0.02f32;
                    let mut expected_pixel = render_color;

                    if self.use_fragment_shading_rate && self.enable_post_depth_coverage {
                        // The sample mask of an FSR fragment covers four pixels, so after the depth test it holds about half the bits.
                        expected_pixel = expected_pixel.map(|component| component * 0.5);
                    }

                    let local_pass = (0..4).all(|component| {
                        render_color[component] == 0.0
                            || (result_pixel[component] > expected_pixel[component] * (1.0 - threshold)
                                && result_pixel[component] < expected_pixel[component] * (1.0 + threshold))
                    });
                    if !local_pass {
                        log::error!(
                            "x: {x} y: {y} Result: {result_pixel:?} Reference: {expected_pixel:?} +-{threshold}"
                        );
                        pass = false;
                    }
                } else if x + y == 1 {
                    let threshold = 0.02f32;
                    let samples = sample_count_value(self.rasterization_samples) as f32;
                    let (min, max) = self.ref_coverage_after_depth_test();
                    let mut min_coverage = min as f32 / samples;
                    let mut max_coverage = max as f32 / samples;

                    if self.enable_post_depth_coverage {
                        min_coverage *= min_coverage;
                        max_coverage *= max_coverage;
                    }

                    let local_pass = (0..4).all(|component| {
                        render_color[component] == 0.0
                            || (result_pixel[component] > render_color[component] * (min_coverage - threshold)
                                && result_pixel[component] < render_color[component] * (max_coverage + threshold))
                    });
                    if !local_pass {
                        log::error!(
                            "x: {x} y: {y} Result: {result_pixel:?} Reference range ( {:?} ; {:?} )",
                            render_color.map(|component| component * (min_coverage - threshold)),
                            render_color.map(|component| component * (max_coverage + threshold))
                        );
                        pass = false;
                    }
                } else if result_pixel != [0.0; 4] {
                    log::error!("x: {x} y: {y} Result: {result_pixel:?} Reference: [0.0, 0.0, 0.0, 0.0]");
                    pass = false;
                }
            }
        }

        if pass {
            TestStatus::pass("Passed")
        } else {
            TestStatus::fail("Failed")
        }
    }
}

impl TestInstance for SampleMaskWithDepthTestInstance<'_> {
    /// `SampleMaskWithDepthTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let config = RendererConfig {
            color_format: COLOR_FORMAT,
            depth_stencil_format: vk::Format::D16_UNORM,
            use_depth: true,
            use_stencil: false,
            topologies: vec![vk::PrimitiveTopology::TRIANGLE_STRIP],
            vertices: vec![Self::generate_vertices()],
            multisample: MultisampleParams::new(self.rasterization_samples),
            blend_state: default_color_blend_attachment_state(),
            render_type: RenderType::Resolve,
            depth_clear_value: 0.667,
            render_size: (3, 3),
            conservative: None,
        };
        let renderer = MultisampleRenderer::new(self.context, config)?;
        let result = renderer.render()?.expect("resolve render type reads its image back");
        Ok(self.verify_image(&result))
    }
}

/// The `sample_mask_with_depth_test` group of `createMultisampleTests`.
pub fn add_sample_mask_with_depth_test_tests(multisample_tests: &mut TestCaseGroup, use_fragment_shading_rate: bool) {
    let standard_samples = [
        (vk::SampleCountFlags::_2, 2u32),
        (vk::SampleCountFlags::_4, 4),
        (vk::SampleCountFlags::_8, 8),
        (vk::SampleCountFlags::_16, 16),
    ];

    let mut group = TestCaseGroup::new("sample_mask_with_depth_test");
    for (samples, value) in standard_samples {
        for enable_post_depth_coverage in [false, true] {
            let name = format!(
                "samples_{value}{}",
                if enable_post_depth_coverage {
                    "_post_depth_coverage"
                } else {
                    ""
                }
            );
            group.add_child(Box::new(SampleMaskWithDepthTestCase {
                name,
                rasterization_samples: samples,
                enable_post_depth_coverage,
                use_fragment_shading_rate,
            }) as Box<dyn TestCase>);
        }
    }
    multisample_tests.add_child(group);
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum FullyCoveredVariant {
    None,
    Overestimate,
    OverestimateExtraSize,
    OverestimateSubpixel,
}

struct ConservativeConfig {
    name: &'static str,
    enable_min_sample_shading: bool,
    min_sample_shading: f32,
    enable_sample_mask: bool,
    sample_mask: u32,
    enable_post_depth_coverage: bool,
}

struct SampleMaskWithConservativeCase {
    name: String,
    rasterization_samples: vk::SampleCountFlags,
    mode: vk::ConservativeRasterizationModeEXT,
    config: &'static ConservativeConfig,
    use_fragment_shading_rate: bool,
    variant: FullyCoveredVariant,
}

impl SampleMaskWithConservativeCase {
    fn shader_uses_fully_covered(&self) -> bool {
        self.variant != FullyCoveredVariant::None
            || (self.mode == vk::ConservativeRasterizationModeEXT::UNDERESTIMATE
                && !self.config.enable_min_sample_shading)
    }
}

fn conservative_properties(context: &Context<'_>) -> vk::PhysicalDeviceConservativeRasterizationPropertiesEXT {
    let mut properties = vk::PhysicalDeviceConservativeRasterizationPropertiesEXT::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties
}

impl TestCase for SampleMaskWithConservativeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `SampleMaskWithConservativeTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_properties().limits.standard_sample_locations == vk::FALSE {
            return Err(TestError::NotSupported("standardSampleLocations required".to_string()));
        }

        if self.use_fragment_shading_rate {
            context.require_device_functionality("VK_KHR_fragment_shading_rate")?;
            let mut properties = vk::PhysicalDeviceFragmentShadingRatePropertiesKHR::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            if properties.fragment_shading_rate_with_conservative_rasterization == vk::FALSE {
                return Err(TestError::NotSupported(
                    "fragmentShadingRateWithConservativeRasterization not supported with conservative rasterization"
                        .to_string(),
                ));
            }
        }

        context.require_device_functionality("VK_EXT_conservative_rasterization")?;

        let properties = conservative_properties(context);

        if self.config.enable_post_depth_coverage {
            context.require_device_functionality("VK_EXT_post_depth_coverage")?;
            if properties.conservative_rasterization_post_depth_coverage == vk::FALSE {
                return Err(TestError::NotSupported(
                    "conservativeRasterizationPostDepthCoverage not supported".to_string(),
                ));
            }
        }

        if self.mode == vk::ConservativeRasterizationModeEXT::OVERESTIMATE {
            if properties.extra_primitive_overestimation_size_granularity
                > properties.max_extra_primitive_overestimation_size
            {
                return Err(TestError::Fail(
                    "Granularity cannot be greater than maximum extra size".to_string(),
                ));
            }
        } else if self.mode == vk::ConservativeRasterizationModeEXT::UNDERESTIMATE {
            if properties.primitive_underestimation == vk::FALSE {
                return Err(TestError::NotSupported("Underestimation is not supported".to_string()));
            }
        } else {
            return Err(TestError::NotPorted(
                "Non-conservative mode tests are not supported by this class".to_string(),
            ));
        }

        if self.shader_uses_fully_covered() && properties.fully_covered_fragment_shader_input_variable == vk::FALSE {
            return Err(TestError::NotSupported(
                "FullyCoveredEXT input variable is not supported".to_string(),
            ));
        }

        if self.variant == FullyCoveredVariant::OverestimateExtraSize
            && properties.max_extra_primitive_overestimation_size == 0.0
        {
            return Err(TestError::NotSupported(
                "maxExtraPrimitiveOverestimationSize is zero".to_string(),
            ));
        }

        if !is_supported_sample_count(context, self.rasterization_samples) {
            return Err(TestError::NotSupported(
                "Unsupported number of rasterization samples".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let samples = sample_count_value(self.rasterization_samples);
        let key = format!(
            "pdc{}_min{}_fc{}_s{}",
            u8::from(self.config.enable_post_depth_coverage),
            u8::from(self.config.enable_min_sample_shading),
            u8::from(self.shader_uses_fully_covered()),
            if self.config.enable_min_sample_shading {
                samples
            } else {
                0
            }
        );
        conservative_shaders::ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .unwrap_or_else(|| panic!("the conservative shader manifest has no case named {key}"))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SampleMaskWithConservativeInstance {
            context,
            rasterization_samples: self.rasterization_samples,
            mode: self.mode,
            config: self.config,
            variant: self.variant,
            use_fragment_shading_rate: self.use_fragment_shading_rate,
        })
    }
}

struct SampleMaskWithConservativeInstance<'a> {
    context: &'a Context<'a>,
    rasterization_samples: vk::SampleCountFlags,
    mode: vk::ConservativeRasterizationModeEXT,
    config: &'static ConservativeConfig,
    variant: FullyCoveredVariant,
    use_fragment_shading_rate: bool,
}

impl SampleMaskWithConservativeInstance<'_> {
    const RENDER_COLOR: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
    const RENDER_SIZE: (u32, u32) = (10, 10);

    /// `SampleMaskWithConservativeInstance::generateVertices`
    fn generate_vertices(&self) -> Vec<Vertex4Rgba> {
        let color = Self::RENDER_COLOR;
        if self.variant == FullyCoveredVariant::OverestimateSubpixel {
            vec![
                Vertex4Rgba {
                    position: [-0.05, -0.05, 0.0, 1.0],
                    color,
                },
                Vertex4Rgba {
                    position: [0.05, -0.05, 0.0, 1.0],
                    color,
                },
                Vertex4Rgba {
                    position: [-0.05, 0.05, 0.0, 1.0],
                    color,
                },
            ]
        } else {
            vec![
                Vertex4Rgba {
                    position: [-1.0, -1.0, 0.0, 1.0],
                    color,
                },
                Vertex4Rgba {
                    position: [1.0, -1.0, 1.0, 1.0],
                    color,
                },
                Vertex4Rgba {
                    position: [-1.0, 1.0, 0.0, 1.0],
                    color,
                },
            ]
        }
    }

    /// `SampleMaskWithConservativeInstance::verifyImage`
    fn verify_image(
        &self,
        sample_shaded_images: &[TextureLevel],
        result: &TextureLevel,
        extra_overestimation_size: f32,
    ) -> TestStatus {
        let access = result.get_const_access();
        let [width, height, _] = result.size();
        let (width, height) = (width as i32, height as i32);
        let samples_count = sample_shaded_images.len() as u32;
        let render_color = Self::RENDER_COLOR;
        let clear_color = [0.0f32; 4];
        let mut pass = true;

        let sample_count_divider = |x: f32| {
            let mut power = 1.0f32;
            while power < x {
                power *= 2.0;
            }
            power
        };

        let mut fully_covered_pixels: Vec<(i32, i32)> = Vec::new();
        let mut borderline_pixels: Vec<(i32, i32)> = Vec::new();

        let overestimate_variant = matches!(
            self.variant,
            FullyCoveredVariant::Overestimate | FullyCoveredVariant::OverestimateExtraSize
        );
        if overestimate_variant {
            let diag_margin = extra_overestimation_size.ceil() as i32;

            if self.use_fragment_shading_rate {
                let (fw, fh) = (2i32, 2i32);
                let allow_partial_block_coverage = fw == 1 || !self.config.enable_post_depth_coverage;

                let block_fully_covered = |bx: i32, by: i32, margin: i32| {
                    (bx..bx + fw).all(|i| (by..by + fh).all(|j| i + j < width - 2 - margin))
                };

                let mut bx = 0;
                while bx + fw <= width {
                    let mut by = 0;
                    while by + fh <= height {
                        if block_fully_covered(bx, by, 0) {
                            if bx == 0 || by == 0 || !block_fully_covered(bx, by, diag_margin) {
                                for i in bx..bx + fw {
                                    for j in by..by + fh {
                                        borderline_pixels.push((i, j));
                                    }
                                }
                            } else {
                                let crosses_depth_boundary = !allow_partial_block_coverage && bx + fw > width / 2;
                                for i in bx..(bx + fw).min(width / 2) {
                                    for j in by..by + fh {
                                        if crosses_depth_boundary {
                                            borderline_pixels.push((i, j));
                                        } else {
                                            fully_covered_pixels.push((i, j));
                                        }
                                    }
                                }
                            }
                        }
                        by += fh;
                    }
                    bx += fw;
                }
            } else {
                for i in 0..width {
                    for j in 0..height {
                        if i < width / 2 && i + j < width - 2 - diag_margin {
                            if i == 0 || j == 0 {
                                borderline_pixels.push((i, j));
                            } else {
                                fully_covered_pixels.push((i, j));
                            }
                        }
                    }
                }
            }
        } else if self.variant == FullyCoveredVariant::OverestimateSubpixel {
        } else if self.mode == vk::ConservativeRasterizationModeEXT::OVERESTIMATE {
            for i in 0..width {
                for j in 0..height {
                    if i < width / 2 && i + j < width + 1 {
                        fully_covered_pixels.push((i, j));
                    }
                }
            }
        } else if self.use_fragment_shading_rate && !self.config.enable_min_sample_shading {
            for i in 2..4 {
                for j in 2..4 {
                    fully_covered_pixels.push((i, j));
                }
            }
        } else {
            for i in 1..width {
                for j in 1..height {
                    if i < width / 2 && i + j < width - 2 {
                        fully_covered_pixels.push((i, j));
                    }
                }
            }
        }

        let sample_mask = self.config.sample_mask;
        for x in 0..width {
            for y in 0..height {
                let result_pixel = access.get_pixel(x as u32, y as u32, 0);

                if borderline_pixels.contains(&(x, y)) {
                    let mut covered_color = render_color;
                    let mut covered_threshold = 0.0f32;
                    if self.config.enable_sample_mask && sample_mask == 0xAAAA_AAAA {
                        covered_color = [0.0, 0.5, 0.0, 0.5];
                        covered_threshold = 0.02;
                    } else if self.config.enable_sample_mask && sample_mask == 0 {
                        covered_color = clear_color;
                    }

                    let matches_covered = (0..4).all(|component| {
                        (result_pixel[component] - covered_color[component]).abs() <= covered_threshold
                    });
                    if !matches_covered && result_pixel != clear_color {
                        log::error!(
                            "Borderline x: {x} y: {y} Result: {result_pixel:?} expected either {covered_color:?} (+/- {covered_threshold}) or {clear_color:?}"
                        );
                        pass = false;
                    }
                    continue;
                }

                if fully_covered_pixels.contains(&(x, y)) {
                    if self.config.enable_min_sample_shading {
                        let mut alpha_sum = 0u32;
                        for image in sample_shaded_images {
                            let offset = (y as usize * width as usize + x as usize) * 4;
                            alpha_sum += u32::from(image.data()[offset + 3]);
                        }

                        let sample_coverage_value = (alpha_sum / samples_count) as i32;
                        let expected_coverage_value = (255.0
                            / sample_count_divider(
                                sample_count_value(self.rasterization_samples) as f32 * self.config.min_sample_shading,
                            )) as i32
                            + 1;

                        if sample_coverage_value > expected_coverage_value {
                            log::error!(
                                "Coverage value {sample_coverage_value} greather than expected: {expected_coverage_value}"
                            );
                            pass = false;
                        }
                    } else if self.config.enable_sample_mask {
                        if sample_mask == 0xFFFF_FFFF {
                            if result_pixel != render_color {
                                log::error!("x: {x} y: {y} Result: {result_pixel:?} Reference: {render_color:?}");
                                pass = false;
                            }
                        } else if sample_mask == 0xAAAA_AAAA {
                            let half_opacity = [0.0f32, 0.5, 0.0, 0.5];
                            let threshold = 0.02f32;
                            for component in 0..4 {
                                if (half_opacity[component] != 0.0
                                    && result_pixel[component] <= half_opacity[component] - threshold)
                                    || result_pixel[component] >= half_opacity[component] + threshold
                                {
                                    log::error!(
                                        "x: {x} y: {y} Result: {result_pixel:?} Reference: {half_opacity:?} +/- {threshold}"
                                    );
                                    pass = false;
                                }
                            }
                        } else if sample_mask == 0 {
                            if result_pixel != clear_color {
                                log::error!("x: {x} y: {y} Result: {result_pixel:?} Reference: {clear_color:?}");
                                pass = false;
                            }
                        } else {
                            log::error!("Unexpected sample mask value");
                            pass = false;
                        }
                    } else if result_pixel != render_color {
                        log::error!("x: {x} y: {y} Result: {result_pixel:?} Reference: {render_color:?}");
                        pass = false;
                    }
                } else if result_pixel != clear_color {
                    log::error!("x: {x} y: {y} Result: {result_pixel:?} Reference: {clear_color:?}");
                    pass = false;
                }
            }
        }

        if pass {
            TestStatus::pass("Passed")
        } else {
            TestStatus::fail("Failed")
        }
    }
}

impl TestInstance for SampleMaskWithConservativeInstance<'_> {
    /// `SampleMaskWithConservativeInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let extra_overestimation_size = if self.variant == FullyCoveredVariant::OverestimateExtraSize {
            conservative_properties(context).max_extra_primitive_overestimation_size
        } else {
            0.0
        };

        let vertices = self.generate_vertices();
        let mut multisample = MultisampleParams::new(self.rasterization_samples);
        multisample.sample_shading_enable = self.config.enable_min_sample_shading;
        multisample.min_sample_shading = if self.config.enable_min_sample_shading {
            self.config.min_sample_shading
        } else {
            0.0
        };
        multisample.sample_mask = self.config.enable_sample_mask.then_some(self.config.sample_mask);

        let no_sample_shading_image = {
            let config = RendererConfig {
                color_format: COLOR_FORMAT,
                depth_stencil_format: vk::Format::D16_UNORM,
                use_depth: true,
                use_stencil: false,
                topologies: vec![vk::PrimitiveTopology::TRIANGLE_STRIP],
                vertices: vec![vertices.clone()],
                multisample,
                blend_state: default_color_blend_attachment_state(),
                render_type: RenderType::Resolve,
                depth_clear_value: 0.5,
                render_size: Self::RENDER_SIZE,
                conservative: Some((self.mode, extra_overestimation_size)),
            };
            let renderer = MultisampleRenderer::new(context, config)?;
            renderer.render()?.expect("resolve render type reads its image back")
        };

        let mut sample_shaded_images = Vec::new();
        {
            let mut config = RendererConfig::color_only(
                COLOR_FORMAT,
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                &vertices,
                multisample,
                default_color_blend_attachment_state(),
                RenderType::CopySamples,
            );
            config.render_size = Self::RENDER_SIZE;
            let renderer = MultisampleRenderer::new(context, config)?;
            renderer.render()?;
            for sample_id in 0..sample_count_value(self.rasterization_samples) as usize {
                sample_shaded_images.push(renderer.get_single_sampled_image(sample_id)?);
            }
        }

        Ok(self.verify_image(
            &sample_shaded_images,
            &no_sample_shading_image,
            extra_overestimation_size,
        ))
    }
}

static CONSERVATIVE_CONFIGS: [ConservativeConfig; 9] = [
    ConservativeConfig {
        name: "plain_conservative",
        enable_min_sample_shading: false,
        min_sample_shading: 0.0,
        enable_sample_mask: false,
        sample_mask: 0,
        enable_post_depth_coverage: false,
    },
    ConservativeConfig {
        name: "post_depth_coverage",
        enable_min_sample_shading: false,
        min_sample_shading: 0.0,
        enable_sample_mask: false,
        sample_mask: 0,
        enable_post_depth_coverage: true,
    },
    ConservativeConfig {
        name: "min_0_25",
        enable_min_sample_shading: true,
        min_sample_shading: 0.25,
        enable_sample_mask: false,
        sample_mask: 0,
        enable_post_depth_coverage: false,
    },
    ConservativeConfig {
        name: "min_0_5",
        enable_min_sample_shading: true,
        min_sample_shading: 0.5,
        enable_sample_mask: false,
        sample_mask: 0,
        enable_post_depth_coverage: false,
    },
    ConservativeConfig {
        name: "min_0_75",
        enable_min_sample_shading: true,
        min_sample_shading: 0.75,
        enable_sample_mask: false,
        sample_mask: 0,
        enable_post_depth_coverage: false,
    },
    ConservativeConfig {
        name: "min_0_1_0",
        enable_min_sample_shading: true,
        min_sample_shading: 1.0,
        enable_sample_mask: false,
        sample_mask: 0,
        enable_post_depth_coverage: false,
    },
    ConservativeConfig {
        name: "mask_all_off",
        enable_min_sample_shading: false,
        min_sample_shading: 0.0,
        enable_sample_mask: true,
        sample_mask: 0x0,
        enable_post_depth_coverage: false,
    },
    ConservativeConfig {
        name: "mask_all_on",
        enable_min_sample_shading: false,
        min_sample_shading: 0.0,
        enable_sample_mask: true,
        sample_mask: 0xFFFF_FFFF,
        enable_post_depth_coverage: false,
    },
    ConservativeConfig {
        name: "mask_half_on",
        enable_min_sample_shading: false,
        min_sample_shading: 0.0,
        enable_sample_mask: true,
        sample_mask: 0xAAAA_AAAA,
        enable_post_depth_coverage: false,
    },
];

/// The `conservative_with_full_coverage` group of `createMultisampleTests`. The fragment shading rate group's `_rate2x1` and
/// `_rate1x2` variants (fragment areas other than 2x2) are not ported, so that group has the 2x2 cases only.
pub fn add_conservative_with_full_coverage_tests(
    multisample_tests: &mut TestCaseGroup,
    use_fragment_shading_rate: bool,
) {
    let standard_samples = [
        (vk::SampleCountFlags::_2, 2u32),
        (vk::SampleCountFlags::_4, 4),
        (vk::SampleCountFlags::_8, 8),
        (vk::SampleCountFlags::_16, 16),
    ];
    let overestimate_configs = [
        ("", FullyCoveredVariant::None),
        ("_fully_covered", FullyCoveredVariant::Overestimate),
        (
            "_fully_covered_extra_overestimate",
            FullyCoveredVariant::OverestimateExtraSize,
        ),
        ("_fully_covered_subpixel", FullyCoveredVariant::OverestimateSubpixel),
    ];
    let underestimate_configs = [("", FullyCoveredVariant::None)];

    let mut conservative_group = TestCaseGroup::new("conservative_with_full_coverage");

    for (mode, mode_name, fully_covered_configs) in [
        (
            vk::ConservativeRasterizationModeEXT::OVERESTIMATE,
            "overestimate",
            &overestimate_configs[..],
        ),
        (
            vk::ConservativeRasterizationModeEXT::UNDERESTIMATE,
            "underestimate",
            &underestimate_configs[..],
        ),
    ] {
        let mut modes_group = TestCaseGroup::new(mode_name);

        for (samples, samples_value) in standard_samples {
            for config in &CONSERVATIVE_CONFIGS {
                for (suffix, variant) in fully_covered_configs {
                    if *variant != FullyCoveredVariant::None && config.enable_min_sample_shading {
                        continue;
                    }

                    modes_group.add_child(Box::new(SampleMaskWithConservativeCase {
                        name: format!("samples_{samples_value}_{}{suffix}", config.name),
                        rasterization_samples: samples,
                        mode,
                        config,
                        use_fragment_shading_rate,
                        variant: *variant,
                    }) as Box<dyn TestCase>);
                }
            }
        }

        conservative_group.add_child(modes_group);
    }

    multisample_tests.add_child(conservative_group);
}

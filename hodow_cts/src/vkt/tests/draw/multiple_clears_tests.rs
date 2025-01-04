// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawMultipleClearsWithinRenderPass.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A depth-only case builds its pipeline without a colour blend state
// (upstream passes one attachment state for a subpass that has no colour attachment), and the results are copied
// into buffers by the primary command buffer rather than read back with `Image::readSurface`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::draw_multiple_clears::MULTIPLE_CLEARS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, end_rendering, rect_2d};
use crate::vkt::tests::draw::{
    initial_transition_color_2d_image, initial_transition_depth_2d_image, transition_2d_image,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 400;
const HEIGHT: u32 = 300;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Topology {
    TriangleStrip,
    Triangles,
    Triangle,
}

const TOPOLOGIES_TO_TEST: [Topology; 3] = [Topology::TriangleStrip, Topology::Triangles, Topology::Triangle];

/// `FormatPair`: the format and the name fragment it contributes to the case name
#[derive(Clone, Copy)]
struct FormatPair {
    color_format: vk::Format,
    color_name: &'static str,
    depth_format: vk::Format,
    depth_name: &'static str,
}

const R8G8B8A8_UNORM: (vk::Format, &str) = (vk::Format::R8G8B8A8_UNORM, "_c_r8g8b8a8_unorm");
const R8G8B8A8_SNORM: (vk::Format, &str) = (vk::Format::R8G8B8A8_SNORM, "_c_r8g8b8a8_snorm");
const NO_COLOR: (vk::Format, &str) = (vk::Format::UNDEFINED, "");
const D32_SFLOAT: (vk::Format, &str) = (vk::Format::D32_SFLOAT, "_d_d32_sfloat");
const D16_UNORM: (vk::Format, &str) = (vk::Format::D16_UNORM, "_d_d16_unorm");
const NO_DEPTH: (vk::Format, &str) = (vk::Format::UNDEFINED, "");

fn formats_to_test() -> Vec<FormatPair> {
    [
        (R8G8B8A8_UNORM, NO_DEPTH),
        (R8G8B8A8_SNORM, NO_DEPTH),
        (NO_COLOR, D32_SFLOAT),
        (NO_COLOR, D16_UNORM),
        (R8G8B8A8_UNORM, D32_SFLOAT),
        (R8G8B8A8_UNORM, D16_UNORM),
        (R8G8B8A8_SNORM, D32_SFLOAT),
        (R8G8B8A8_SNORM, D16_UNORM),
    ]
    .into_iter()
    .map(|(color, depth)| FormatPair {
        color_format: color.0,
        color_name: color.1,
        depth_format: depth.0,
        depth_name: depth.1,
    })
    .collect()
}

const VERTICES_TRIANGLE_STRIP: [[f32; 4]; 4] = [
    [-1.0, -1.0, 0.0, 1.0], // 0 -- 2
    [-1.0, 1.0, 0.0, 1.0],  // |  / |
    [1.0, -1.0, 0.0, 1.0],  // | /    |
    [1.0, 1.0, 0.0, 1.0],   // 1 -- 3
];
const VERTICES_TRIANGLES: [[f32; 4]; 6] = [
    [-1.0, -1.0, 0.0, 1.0], // 0 - 1
    [-1.0, 1.0, 0.0, 1.0],  // | /
    [1.0, -1.0, 0.0, 1.0],  // 2
    [1.0, -1.0, 0.0, 1.0],  //       4
    [-1.0, 1.0, 0.0, 1.0],  //     / |
    [1.0, 1.0, 0.0, 1.0],   // 3 - 5
];
const VERTICES_BIG_TRIANGLE: [[f32; 4]; 3] = [
    [-1.0, -1.0, 0.0, 1.0], // 0 - 2
    [-1.0, 3.0, 0.0, 1.0],  // | /
    [3.0, -1.0, 0.0, 1.0],  // 1
];

/// `Vertices`, selected by `Topology`
struct Vertices {
    test_name_suffix: &'static str,
    topology: vk::PrimitiveTopology,
    vertices: &'static [[f32; 4]],
}

fn vertices_by_topology(topology: Topology) -> Vertices {
    match topology {
        Topology::TriangleStrip => Vertices {
            test_name_suffix: "_triangle_strip",
            topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
            vertices: &VERTICES_TRIANGLE_STRIP,
        },
        Topology::Triangles => Vertices {
            test_name_suffix: "_triangles",
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            vertices: &VERTICES_TRIANGLES,
        },
        Topology::Triangle => Vertices {
            test_name_suffix: "_big_triangle",
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            vertices: &VERTICES_BIG_TRIANGLE,
        },
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ClearOp {
    Load,
    Draw,
    Clear,
}

#[derive(Clone, Copy)]
struct ClearStep {
    clear_op: ClearOp,
    color: [f32; 4],
    depth: f32,
}

#[derive(Clone)]
struct TestParams {
    color_format: vk::Format,
    depth_format: vk::Format,
    topology: Topology,
    expected_color: [f32; 4],
    color_epsilon: f32,
    expected_depth: f32,
    depth_epsilon: f32,
    repeat_count: u32,
    enable_blend: bool,
    group_params: GroupParams,
    steps: Vec<ClearStep>,
}

struct MultipleClearsWithinRenderPassTest {
    name: String,
    params: TestParams,
}

impl TestCase for MultipleClearsWithinRenderPassTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MultipleClearsWithinRenderPassTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        if self.params.color_format != vk::Format::UNDEFINED {
            let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST;
            let properties = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    self.params.color_format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    color_usage,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if properties.is_err() {
                return Err(TestError::NotSupported("Color format not supported".to_string()));
            }

            let format_properties =
                unsafe { instance.get_physical_device_format_properties(physical_device, self.params.color_format) };
            if !format_properties
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT_BLEND)
            {
                return Err(TestError::NotSupported("Color format not supported".to_string()));
            }
        }
        if self.params.depth_format != vk::Format::UNDEFINED {
            let depth_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST;
            let properties = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    self.params.depth_format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    depth_usage,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if properties.is_err() {
                return Err(TestError::NotSupported("Depth format not supported".to_string()));
            }
        }

        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MULTIPLE_CLEARS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultipleClearsTest {
            context,
            params: self.params.clone(),
        })
    }
}

struct MultipleClearsTest<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// R8G8B8A8_UNORM / R8G8B8A8_SNORM texel to floats
fn decode_color(format: vk::Format, texel: &[u8]) -> [f32; 4] {
    let mut color = [0.0f32; 4];
    for (channel, byte) in color.iter_mut().zip(texel) {
        *channel = if format == vk::Format::R8G8B8A8_SNORM {
            (*byte as i8 as f32 / 127.0).max(-1.0)
        } else {
            *byte as f32 / 255.0
        };
    }
    color
}

fn decode_depth(format: vk::Format, texel: &[u8]) -> f32 {
    if format == vk::Format::D16_UNORM {
        u16::from_le_bytes([texel[0], texel[1]]) as f32 / 65535.0
    } else {
        f32::from_le_bytes([texel[0], texel[1], texel[2], texel[3]])
    }
}

impl TestInstance for MultipleClearsTest<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let alloc = context.get_default_allocator();
        let has_color = params.color_format != vk::Format::UNDEFINED;
        let has_depth = params.depth_format != vk::Format::UNDEFINED;
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let render_area = rect_2d(WIDTH, HEIGHT);
        let extent = vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        };

        // Vertex data
        let vertex_data = vertices_by_topology(params.topology);
        let vertices_count = vertex_data.vertices.len();
        let mut all_vertices: Vec<[f32; 4]> = Vec::with_capacity(params.steps.len() * vertices_count);
        for step in &params.steps {
            for vertex in vertex_data.vertices {
                all_vertices.push([vertex[0], vertex[1], step.depth, vertex[3]]);
            }
        }
        let vertex_buffer = create_host_buffer(context, &all_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let color_target_image = if has_color {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(params.color_format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(
                    vk::ImageUsageFlags::COLOR_ATTACHMENT
                        | vk::ImageUsageFlags::TRANSFER_SRC
                        | vk::ImageUsageFlags::TRANSFER_DST,
                )
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            Some(ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)?)
        } else {
            None
        };
        let color_target_view = match &color_target_image {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                params.color_format,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?),
            None => None,
        };

        let depth_target_image = if has_depth {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(params.depth_format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(
                    vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                        | vk::ImageUsageFlags::TRANSFER_SRC
                        | vk::ImageUsageFlags::TRANSFER_DST,
                )
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            Some(ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)?)
        } else {
            None
        };
        let depth_target_view = match &depth_target_image {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                params.depth_format,
                make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
            )?),
            None => None,
        };

        let color_buffer_size = (WIDTH * HEIGHT * 4) as usize;
        let color_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(color_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let depth_texel_size = if params.depth_format == vk::Format::D16_UNORM {
            2
        } else {
            4
        };
        let depth_buffer_size = (WIDTH * HEIGHT) as usize * depth_texel_size;
        let depth_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(depth_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Render pass
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let mut attachments = Vec::new();
            let mut attachment_views = Vec::new();
            if let Some(view) = &color_target_view {
                attachments.push(
                    vk::AttachmentDescription::builder()
                        .format(params.color_format)
                        .samples(vk::SampleCountFlags::_1)
                        .load_op(vk::AttachmentLoadOp::LOAD)
                        .store_op(vk::AttachmentStoreOp::STORE)
                        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                        .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                        .build(),
                );
                attachment_views.push(**view);
            }
            if let Some(view) = &depth_target_view {
                attachments.push(
                    vk::AttachmentDescription::builder()
                        .format(params.depth_format)
                        .samples(vk::SampleCountFlags::_1)
                        .load_op(vk::AttachmentLoadOp::LOAD)
                        .store_op(vk::AttachmentStoreOp::STORE)
                        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                        .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                        .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                        .build(),
                );
                attachment_views.push(**view);
            }
            let color_attachment_references = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            let depth_attachment_reference = vk::AttachmentReference {
                attachment: if has_color { 1 } else { 0 },
                layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            };
            let mut subpass = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
            if has_color {
                subpass = subpass.color_attachments(&color_attachment_references);
            }
            if has_depth {
                subpass = subpass.depth_stencil_attachment(&depth_attachment_reference);
            }
            let subpasses = [subpass.build()];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );
            let framebuffer = make_framebuffer(device, *render_pass, &attachment_views, WIDTH, HEIGHT, 1)?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Graphics pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module =
            create_shader_module(device, binaries.get(if has_color { "frag" } else { "frag_depthonly" })?)?;

        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 16,
        };
        let push_constant_ranges = [pc_range];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let mut state = DrawPipelineState::new(vertex_data.topology)
            .with_position_input()
            .with_full_viewport(WIDTH, HEIGHT);
        state.color_blend_attachment = Some(
            vk::PipelineColorBlendAttachmentState::builder()
                .blend_enable(params.enable_blend)
                .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
                .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
                .color_blend_op(vk::BlendOp::ADD)
                .src_alpha_blend_factor(vk::BlendFactor::ZERO)
                .dst_alpha_blend_factor(vk::BlendFactor::ONE)
                .alpha_blend_op(vk::BlendOp::ADD)
                .color_write_mask(
                    vk::ColorComponentFlags::R
                        | vk::ColorComponentFlags::G
                        | vk::ColorComponentFlags::B
                        | vk::ColorComponentFlags::A,
                )
                .build(),
        );
        state.depth_stencil.depth_test_enable = if has_depth { vk::TRUE } else { vk::FALSE };
        state.depth_stencil.depth_write_enable = if has_depth { vk::TRUE } else { vk::FALSE };
        state.color_attachment_count = has_color as u32;
        if dynamic_rendering {
            state.rendering_format = Some(params.color_format);
            state.depth_rendering_format = params.depth_format;
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        // Command buffers
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // `preRenderCommands`
        let pre_render_commands = |cmd: vk::CommandBuffer| {
            if let Some(image) = &color_target_image {
                initial_transition_color_2d_image(
                    device,
                    cmd,
                    image.get(),
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    1,
                );
            }
            if let Some(image) = &depth_target_image {
                initial_transition_depth_2d_image(
                    device,
                    cmd,
                    image.get(),
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                );
            }
        };

        let first_step_loads = params.steps.first().is_some_and(|step| step.clear_op == ClearOp::Load);

        // `drawCommands`
        let draw_commands = |cmd: vk::CommandBuffer| {
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            }

            for _ in 0..params.repeat_count {
                for (step_index, step) in params.steps.iter().enumerate() {
                    // ClearOp::LOAD only supported for first step
                    debug_assert!(step_index == 0 || step.clear_op != ClearOp::Load);

                    match step.clear_op {
                        ClearOp::Load => {}
                        ClearOp::Draw => {
                            let color_bytes: Vec<u8> = step
                                .color
                                .iter()
                                .flat_map(|component| component.to_ne_bytes())
                                .collect();
                            unsafe {
                                device.cmd_push_constants(
                                    cmd,
                                    *pipeline_layout,
                                    vk::ShaderStageFlags::FRAGMENT,
                                    0,
                                    &color_bytes,
                                );
                                device.cmd_draw(cmd, vertices_count as u32, 1, (vertices_count * step_index) as u32, 0);
                            }
                        }
                        ClearOp::Clear => {
                            let mut clear_attachments: Vec<vk::ClearAttachment> = Vec::new();
                            if has_color {
                                clear_attachments.push(vk::ClearAttachment {
                                    aspect_mask: vk::ImageAspectFlags::COLOR,
                                    color_attachment: clear_attachments.len() as u32,
                                    clear_value: vk::ClearValue {
                                        color: vk::ClearColorValue { float32: step.color },
                                    },
                                });
                            }
                            if has_depth {
                                clear_attachments.push(vk::ClearAttachment {
                                    aspect_mask: vk::ImageAspectFlags::DEPTH,
                                    color_attachment: clear_attachments.len() as u32,
                                    clear_value: vk::ClearValue {
                                        depth_stencil: vk::ClearDepthStencilValue {
                                            depth: step.depth,
                                            stencil: 0,
                                        },
                                    },
                                });
                            }
                            let clear_rect = vk::ClearRect {
                                rect: render_area,
                                base_array_layer: 0,
                                layer_count: 1,
                            };
                            unsafe { device.cmd_clear_attachments(cmd, &clear_attachments, &[clear_rect]) };
                        }
                    }
                }
            }
        };

        // `beginDynamicRender`
        let begin_dynamic_render = |cmd: vk::CommandBuffer, flags: vk::RenderingFlags| {
            let mut clear_color_value = vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            };
            let mut clear_depth_value = vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            };
            if first_step_loads {
                clear_color_value = vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: params.steps[0].color,
                    },
                };
                clear_depth_value = vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: params.steps[0].depth,
                        stencil: 0,
                    },
                };
            }

            let color_attachments: Vec<vk::RenderingAttachmentInfo> = color_target_view
                .iter()
                .map(|view| {
                    vk::RenderingAttachmentInfo::builder()
                        .image_view(**view)
                        .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                        .resolve_mode(vk::ResolveModeFlags::NONE)
                        .load_op(vk::AttachmentLoadOp::LOAD)
                        .store_op(vk::AttachmentStoreOp::STORE)
                        .clear_value(clear_color_value)
                        .build()
                })
                .collect();
            let depth_attachment = depth_target_view.as_ref().map(|view| {
                vk::RenderingAttachmentInfo::builder()
                    .image_view(**view)
                    .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(clear_depth_value)
                    .build()
            });

            let mut rendering_info = vk::RenderingInfo::builder()
                .flags(flags)
                .render_area(render_area)
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments);
            if let Some(depth_attachment) = &depth_attachment {
                rendering_info = rendering_info.depth_attachment(depth_attachment);
            }
            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        };

        // `beginSecondaryCmdBuffer`
        let begin_secondary_cmd_buffer =
            |cmd: vk::CommandBuffer, rendering_flags: vk::RenderingFlags| -> Result<(), TestError> {
                let color_formats: &[vk::Format] = if has_color { &[params.color_format] } else { &[] };
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(rendering_flags)
                    .view_mask(0)
                    .color_attachment_formats(color_formats)
                    .depth_attachment_format(params.depth_format)
                    .stencil_attachment_format(vk::Format::UNDEFINED)
                    .rasterization_samples(vk::SampleCountFlags::_1);
                let inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

                let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
                if !params
                    .group_params
                    .secondary_cmd_buffer_completely_contains_dynamic_renderpass
                {
                    usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
                }
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(usage_flags)
                    .inheritance_info(&inheritance_info);
                unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
            };

        let mut sec_cmd_buffers = Vec::new();
        if params.group_params.use_secondary_cmd_buffer {
            let sec_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let sec = *sec_cmd_buffer;
            sec_cmd_buffers.push(sec_cmd_buffer);
            let contains = params
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

            // record secondary command buffer
            if contains {
                begin_secondary_cmd_buffer(sec, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)?;
                begin_dynamic_render(sec, vk::RenderingFlags::empty());
            } else {
                begin_secondary_cmd_buffer(sec, vk::RenderingFlags::empty())?;
            }

            draw_commands(sec);

            if contains {
                end_rendering(device, sec);
            }
            end_command_buffer(device, sec)?;

            // record primary command buffer
            begin_command_buffer(device, *cmd_buffer)?;
            pre_render_commands(*cmd_buffer);

            if !contains {
                begin_dynamic_render(*cmd_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
            }

            unsafe { device.cmd_execute_commands(*cmd_buffer, &[sec]) };

            if !contains {
                end_rendering(device, *cmd_buffer);
            }
        } else if dynamic_rendering {
            begin_command_buffer(device, *cmd_buffer)?;
            pre_render_commands(*cmd_buffer);
            begin_dynamic_render(*cmd_buffer, vk::RenderingFlags::empty());
            draw_commands(*cmd_buffer);
            end_rendering(device, *cmd_buffer);
        } else {
            begin_command_buffer(device, *cmd_buffer)?;
            pre_render_commands(*cmd_buffer);

            // `beginLegacyRender`
            let clear_values = [
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: params.steps[0].color,
                    },
                },
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: params.steps[0].depth,
                        stencil: 0,
                    },
                },
            ];
            let mut begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass_handle)
                .framebuffer(framebuffer_handle)
                .render_area(render_area);
            if first_step_loads {
                begin_info = begin_info.clear_values(&clear_values);
            }
            unsafe { device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            draw_commands(*cmd_buffer);
            unsafe { device.cmd_end_render_pass(*cmd_buffer) };
        }

        if has_depth {
            let mem_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                )
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[mem_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        if has_color {
            let mem_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[mem_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        // The results go to the host through a buffer copy of each aspect.
        let to_host = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        if let Some(image) = &color_target_image {
            transition_2d_image(
                device,
                *cmd_buffer,
                image.get(),
                vk::ImageAspectFlags::COLOR,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
            let copy_region = make_buffer_image_copy(
                extent,
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            unsafe {
                device.cmd_copy_image_to_buffer(
                    *cmd_buffer,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.get(),
                    &[copy_region],
                )
            };
        }
        if let Some(image) = &depth_target_image {
            transition_2d_image(
                device,
                *cmd_buffer,
                image.get(),
                vk::ImageAspectFlags::DEPTH,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
            let copy_region = make_buffer_image_copy(
                extent,
                make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
            );
            unsafe {
                device.cmd_copy_image_to_buffer(
                    *cmd_buffer,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_buffer.get(),
                    &[copy_region],
                )
            };
        }
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;

        if has_color {
            invalidate_alloc(device, color_buffer.get_allocation())?;
            let color_bytes =
                unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size) };

            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    let offset = ((y * WIDTH + x) * 4) as usize;
                    let pixel = decode_color(params.color_format, &color_bytes[offset..offset + 4]);
                    let difference = [
                        params.expected_color[0] - pixel[0],
                        params.expected_color[1] - pixel[1],
                        params.expected_color[2] - pixel[2],
                    ];
                    if difference
                        .iter()
                        .any(|component| component.abs() >= params.color_epsilon)
                    {
                        return Ok(TestStatus::fail(format!(
                            "Color value mismatch, expected: {:?}, got: {:?} at ({x}, {y}, 0)",
                            params.expected_color, pixel
                        )));
                    }
                }
            }
        }
        if has_depth {
            invalidate_alloc(device, depth_buffer.get_allocation())?;
            let depth_bytes =
                unsafe { std::slice::from_raw_parts(depth_buffer.get_allocation().get_host_ptr(), depth_buffer_size) };

            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    let offset = (y * WIDTH + x) as usize * depth_texel_size;
                    let value = decode_depth(params.depth_format, &depth_bytes[offset..offset + depth_texel_size]);
                    if (params.expected_depth - value).abs() >= params.depth_epsilon {
                        return Ok(TestStatus::fail(format!(
                            "Depth value mismatch, expected: {}, got: {value} at ({x}, {y}, 0)",
                            params.expected_depth
                        )));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `MultipleClearsWithinRenderPassTests::init`
pub fn create_multiple_clears_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multiple_clears_within_render_pass");

    let step = |clear_op: ClearOp, color: [f32; 4], depth: f32| ClearStep { clear_op, color, depth };

    for format_pair in formats_to_test() {
        let format_suffix = format!("{}{}", format_pair.color_name, format_pair.depth_name);
        for topology in TOPOLOGIES_TO_TEST {
            // reduce number of tests for dynamic rendering cases where secondary command buffer is used
            if group_params.use_secondary_cmd_buffer && topology != Topology::TriangleStrip {
                continue;
            }

            let test_name_suffix = format!("{format_suffix}{}", vertices_by_topology(topology).test_name_suffix);

            let params = |expected_color: [f32; 4], enable_blend: bool, steps: Vec<ClearStep>| TestParams {
                color_format: format_pair.color_format,
                depth_format: format_pair.depth_format,
                topology,
                expected_color,
                color_epsilon: 0.01,
                expected_depth: 0.9,
                depth_epsilon: 0.01,
                repeat_count: 1,
                enable_blend,
                group_params,
                steps,
            };
            let mut add = |name: &str, params: TestParams| {
                group.add_child(Box::new(MultipleClearsWithinRenderPassTest {
                    name: format!("{name}{test_name_suffix}"),
                    params,
                }) as Box<dyn TestCase>);
            };

            let red = [1.0, 0.0, 0.0, 1.0];
            let green = [0.0, 1.0, 0.0, 1.0];
            let blue_half = [0.0, 0.0, 1.0, 0.5];
            let blended = [0.0, 0.5, 0.5, 1.0];

            // Multiple clears within same render pass, methods: load, clear, draw
            add(
                "load_clear_draw",
                params(
                    blended,
                    true,
                    vec![
                        step(ClearOp::Load, red, 0.7),
                        step(ClearOp::Clear, green, 0.3),
                        step(ClearOp::Draw, blue_half, 0.9),
                    ],
                ),
            );
            // Multiple clears within same render pass, methods: draw, clear, draw
            add(
                "draw_clear_draw",
                params(
                    blended,
                    true,
                    vec![
                        step(ClearOp::Draw, red, 0.7),
                        step(ClearOp::Clear, green, 0.3),
                        step(ClearOp::Draw, blue_half, 0.9),
                    ],
                ),
            );
            // Multiple clears within same render pass, methods: clear, clear, draw
            add(
                "clear_clear_draw",
                params(
                    blended,
                    true,
                    vec![
                        step(ClearOp::Clear, red, 0.7),
                        step(ClearOp::Clear, green, 0.3),
                        step(ClearOp::Draw, blue_half, 0.9),
                    ],
                ),
            );
            // Multiple clears within same render pass, methods: load, clear
            add(
                "load_clear",
                params(
                    green,
                    false,
                    vec![step(ClearOp::Load, red, 0.3), step(ClearOp::Clear, green, 0.9)],
                ),
            );
            // Multiple clears within same render pass, methods: draw, clear
            add(
                "draw_clear",
                params(
                    green,
                    false,
                    vec![step(ClearOp::Draw, red, 0.3), step(ClearOp::Clear, green, 0.9)],
                ),
            );
            // Multiple clears within same render pass, methods: clear, clear
            add(
                "clear_clear",
                params(
                    green,
                    false,
                    vec![step(ClearOp::Clear, red, 0.3), step(ClearOp::Clear, green, 0.9)],
                ),
            );
        }
    }
    group
}

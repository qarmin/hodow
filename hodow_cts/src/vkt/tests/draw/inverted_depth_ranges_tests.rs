// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawInvertedDepthRangesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The reference depth is a plain `Vec<f32>` with a parallel mask of
// the pixels that must not be compared (upstream keeps both in a D16_UNORM_S8_UINT `tcu::TextureLevel`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::draw_inverted_depth_ranges::INVERTED_DEPTH_RANGES;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, copy_general_image_to_buffer, create_draw_pipeline, end_rendering, rect_2d,
};
use crate::vkt::tests::draw::{initial_transition_color_2d_image, initial_transition_depth_2d_image};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct TestParams {
    min_depth: f32,
    max_depth: f32,
    depth_clamp_enable: bool,
    depth_bias_enable: bool,
    depth_bias_clamp: f32,
    group_params: GroupParams,
}

const IMAGE_DIM: u32 = 256;
const COLOR_ATTACHMENT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_ATTACHMENT_FORMAT: vk::Format = vk::Format::D16_UNORM;
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const CLEAR_DEPTH: f32 = 1.0;
const DEPTH_EPSILON: f32 = 0.00025; // Used to decide if a calculated depth passes the depth test.
const DEPTH_THRESHOLD: f32 = 0.0064; // Used when checking depth buffer values. Less than depth delta in each pixel (~= 1.4/205).
const MARGIN: f32 = 0.2; // Space between triangle and image border. See VERTICES.
const DIAGONAL_MARGIN: f32 = 0.00125; // Makes sure the image diagonal falls inside the triangle. See VERTICES.
const VERTEX_COLOR: [f32; 4] = [0.0, 0.5, 0.5, 1.0]; // Note: the first component will vary.

// Maximum depth slope is constant for triangle and the value here is true only for triangle used it this tests.
const MAX_DEPTH_SLOPE: f32 = 1.4 / 205.0;

const VERTICES: [[f32; 4]; 3] = [
    [-1.0 + MARGIN, -1.0 + MARGIN, -0.2, 1.0],                 //  0-----2
    [-1.0 + MARGIN, 1.0 - MARGIN + DIAGONAL_MARGIN, 0.0, 1.0], //   |  /
    [1.0 - MARGIN + DIAGONAL_MARGIN, -1.0 + MARGIN, 1.2, 1.0], //  1|/
];

struct InvertedDepthRangesTest {
    name: String,
    params: TestParams,
}

impl TestCase for InvertedDepthRangesTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `InvertedDepthRangesTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if params.depth_clamp_enable && context.get_device_features().depth_clamp == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: depthClamp".to_string(),
            ));
        }

        if params.depth_bias_enable
            && params.depth_bias_clamp != 0.0
            && context.get_device_features().depth_bias_clamp == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: depthBiasClamp".to_string(),
            ));
        }

        if params.min_depth > 1.0 || params.min_depth < 0.0 || params.max_depth > 1.0 || params.max_depth < 0.0 {
            context.require_device_functionality("VK_EXT_depth_range_unrestricted")?;
        }

        if params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        INVERTED_DEPTH_RANGES.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InvertedDepthRangesTestInstance {
            context,
            params: self.params,
        })
    }
}

struct InvertedDepthRangesTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// The reference of both aspects; `masked` marks the depth pixels that must not be compared.
struct ReferenceImages {
    color: TextureLevel,
    depth: Vec<f32>,
    masked: Vec<bool>,
}

impl InvertedDepthRangesTestInstance<'_> {
    /// `generateReferenceImage` for both `ReferenceImageType`s at once.
    fn generate_reference_images(&self) -> Result<ReferenceImages, TestError> {
        let params = &self.params;
        let width = IMAGE_DIM as i32;
        let height = IMAGE_DIM as i32;
        let mut color = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            IMAGE_DIM,
            IMAGE_DIM,
            1,
        )?;
        let mut depth = vec![CLEAR_DEPTH; (IMAGE_DIM * IMAGE_DIM) as usize];
        let mut masked = vec![false; (IMAGE_DIM * IMAGE_DIM) as usize];
        let f_image_dim = IMAGE_DIM as f32;
        let p1f = f_image_dim * MARGIN / 2.0;
        let p2f = f_image_dim * (2.0 - MARGIN + DIAGONAL_MARGIN) / 2.0;
        let triangle_side = f_image_dim * (2.0 - (2.0 * MARGIN - DIAGONAL_MARGIN)) / 2.0;
        let clamp_min = params.min_depth.min(params.max_depth);
        let clamp_max = params.min_depth.max(params.max_depth);
        let depth_values: [f32; 3] = [VERTICES[0][2], VERTICES[1][2], VERTICES[2][2]];
        let mut depth_bias = 0.0f32;

        if params.depth_bias_enable {
            let depth_bias_slope_factor = 1.0f32;
            let r = 0.000030518f32; // minimum resolvable difference is an implementation-dependent parameter
            let depth_bias_constant_factor = 0.0f32; // so we use factor 0.0 to not include it; same as in PipelineCreateInfo

            // Equations taken from vkCmdSetDepthBias manual page
            depth_bias = MAX_DEPTH_SLOPE * depth_bias_slope_factor + r * depth_bias_constant_factor;

            // dbclamp(x) function depends on the sign of the depthBiasClamp
            if params.depth_bias_clamp < 0.0 {
                depth_bias = depth_bias.max(params.depth_bias_clamp);
            } else if params.depth_bias_clamp > 0.0 {
                depth_bias = depth_bias.min(params.depth_bias_clamp);
            }

            if params.max_depth < params.min_depth {
                depth_bias *= -1.0;
            }
        }

        let mut color_access = color.get_access();
        for y in 0..IMAGE_DIM {
            for x in 0..IMAGE_DIM {
                color_access.set_pixel(CLEAR_COLOR, x, y, 0);
            }
        }

        for y in 0..height {
            for x in 0..width {
                let xcoord = x as f32 + 0.5;
                let ycoord = y as f32 + 0.5;

                if xcoord < p1f || xcoord > p2f {
                    continue;
                }

                if ycoord < p1f || ycoord > p2f {
                    continue;
                }

                if ycoord > -xcoord + f_image_dim {
                    continue;
                }

                // Interpolate depth value taking the 3 triangle corners into account.
                let b = (ycoord - p1f) / triangle_side;
                let c = (xcoord - p1f) / triangle_side;
                let a = 1.0 - b - c;
                let depth_interpolated = a * depth_values[0] + b * depth_values[1] + c * depth_values[2];

                // Depth values are always limited to the range [0,1] by clamping after depth bias addition is performed
                let depth_clamped = (depth_interpolated + depth_bias).clamp(0.0, 1.0);
                let depth_final = depth_clamped * params.max_depth + (1.0 - depth_clamped) * params.min_depth;
                let stored_depth = if params.depth_clamp_enable {
                    depth_final.clamp(clamp_min, clamp_max)
                } else {
                    depth_final
                };

                let in_range = |value: f32, low: f32, high: f32| value >= low && value <= high;

                if params.depth_clamp_enable || in_range(depth_interpolated, -DEPTH_EPSILON, 1.0 + DEPTH_EPSILON) {
                    color_access.set_pixel(
                        [depth_final, VERTEX_COLOR[1], VERTEX_COLOR[2], VERTEX_COLOR[3]],
                        x as u32,
                        y as u32,
                        0,
                    );

                    let index = (y as u32 * IMAGE_DIM + x as u32) as usize;
                    if !params.depth_clamp_enable
                        && (in_range(depth_interpolated, -DEPTH_EPSILON, DEPTH_EPSILON)
                            || in_range(depth_interpolated, 1.0 - DEPTH_EPSILON, 1.0 + DEPTH_EPSILON))
                    {
                        // We should avoid comparing this pixel due to possible rounding problems.
                        masked[index] = true;
                    }
                    // upstream stores into a D16 level, which saturates to [0, 1]
                    depth[index] = stored_depth.clamp(0.0, 1.0);
                }
            }
        }

        Ok(ReferenceImages { color, depth, masked })
    }
}

/// The depth counterpart of `copy_general_image_to_buffer`.
fn copy_general_depth_image_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
) {
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: IMAGE_DIM,
            height: IMAGE_DIM,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
    );
    let to_transfer = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::MEMORY_WRITE)
        .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
        .build();
    let to_host = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::HOST_READ)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[to_transfer],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
        device.cmd_copy_image_to_buffer(cmd_buffer, image, vk::ImageLayout::GENERAL, buffer, &[copy_region]);
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

impl TestInstance for InvertedDepthRangesTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let alloc = context.get_default_allocator();
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let extent = vk::Extent3D {
            width: IMAGE_DIM,
            height: IMAGE_DIM,
            depth: 1,
        };

        // Set up the viewport and draw
        let viewport = vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: IMAGE_DIM as f32,
            height: IMAGE_DIM as f32,
            min_depth: params.min_depth,
            max_depth: params.max_depth,
        };
        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue { float32: CLEAR_COLOR },
        };
        let clear_depth = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: CLEAR_DEPTH,
                stencil: 0,
            },
        };
        let render_area = rect_2d(IMAGE_DIM, IMAGE_DIM);

        // Vertex data
        let vertex_buffer = create_host_buffer(context, &VERTICES, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Targets
        let color_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_ATTACHMENT_FORMAT)
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
        let color_target_image = ImageWithMemory::new(device, alloc, color_info, MemoryRequirement::ANY)?;
        let depth_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(DEPTH_ATTACHMENT_FORMAT)
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
        let depth_target_image = ImageWithMemory::new(device, alloc, depth_info, MemoryRequirement::ANY)?;
        let color_target_view = make_image_view(
            device,
            color_target_image.get(),
            vk::ImageViewType::_2D,
            COLOR_ATTACHMENT_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let depth_target_view = make_image_view(
            device,
            depth_target_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_ATTACHMENT_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;

        let color_buffer_size = (IMAGE_DIM * IMAGE_DIM * 4) as vk::DeviceSize;
        let color_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let depth_buffer_size = (IMAGE_DIM * IMAGE_DIM * 2) as vk::DeviceSize;
        let depth_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(depth_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Render pass and framebuffer
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let attachments = [
                vk::AttachmentDescription::builder()
                    .format(COLOR_ATTACHMENT_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::GENERAL)
                    .final_layout(vk::ImageLayout::GENERAL)
                    .build(),
                vk::AttachmentDescription::builder()
                    .format(DEPTH_ATTACHMENT_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::GENERAL)
                    .final_layout(vk::ImageLayout::GENERAL)
                    .build(),
            ];
            let color_attachment_references = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::GENERAL,
            }];
            let depth_attachment_reference = vk::AttachmentReference {
                attachment: 1,
                layout: vk::ImageLayout::GENERAL,
            };
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_attachment_references)
                .depth_stencil_attachment(&depth_attachment_reference)
                .build()];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );
            let framebuffer = make_framebuffer(
                device,
                *render_pass,
                &[*color_target_view, *depth_target_view],
                IMAGE_DIM,
                IMAGE_DIM,
                1,
            )?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Graphics pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_position_input();
        state.scissors = vec![render_area];
        state.viewport_count = 1;
        state.dynamic_states = vec![vk::DynamicState::VIEWPORT];
        state.depth_stencil.depth_test_enable = vk::TRUE;
        state.depth_stencil.depth_write_enable = vk::TRUE;
        state.rasterization.depth_clamp_enable = if params.depth_clamp_enable { vk::TRUE } else { vk::FALSE };
        state.rasterization.front_face = vk::FrontFace::CLOCKWISE;
        state.rasterization.depth_bias_enable = if params.depth_bias_enable { vk::TRUE } else { vk::FALSE };
        state.rasterization.depth_bias_constant_factor = 0.0;
        state.rasterization.depth_bias_clamp = if params.depth_bias_enable {
            params.depth_bias_clamp
        } else {
            0.0
        };
        state.rasterization.depth_bias_slope_factor = if params.depth_bias_enable { 1.0 } else { 0.0 };
        if dynamic_rendering {
            state.rendering_format = Some(COLOR_ATTACHMENT_FORMAT);
            state.depth_rendering_format = DEPTH_ATTACHMENT_FORMAT;
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

        // Command buffer
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let sec_cmd_buffer = if params.group_params.use_secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        // `preRenderCommands`
        let pre_render_commands = |cmd: vk::CommandBuffer| {
            let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let depth_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);

            initial_transition_color_2d_image(
                device,
                cmd,
                color_target_image.get(),
                vk::ImageLayout::GENERAL,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
            initial_transition_depth_2d_image(
                device,
                cmd,
                depth_target_image.get(),
                vk::ImageLayout::GENERAL,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::PipelineStageFlags::TRANSFER,
            );
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    color_target_image.get(),
                    vk::ImageLayout::GENERAL,
                    &vk::ClearColorValue { float32: CLEAR_COLOR },
                    &[subresource_range],
                );
                device.cmd_clear_depth_stencil_image(
                    cmd,
                    depth_target_image.get(),
                    vk::ImageLayout::GENERAL,
                    &vk::ClearDepthStencilValue {
                        depth: CLEAR_DEPTH,
                        stencil: 0,
                    },
                    &[depth_subresource_range],
                );
            }

            let mem_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .build();
            let depth_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                )
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[mem_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[depth_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        };

        // `draw`
        let draw = |cmd: vk::CommandBuffer| unsafe {
            device.cmd_set_viewport(cmd, 0, &[viewport]);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        };

        // `beginRender`
        let begin_render = |cmd: vk::CommandBuffer, flags: vk::RenderingFlags| {
            let color_attachments = [vk::RenderingAttachmentInfo::builder()
                .image_view(*color_target_view)
                .image_layout(vk::ImageLayout::GENERAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_color)
                .build()];
            let depth_attachment = vk::RenderingAttachmentInfo::builder()
                .image_view(*depth_target_view)
                .image_layout(vk::ImageLayout::GENERAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_depth)
                .build();
            let rendering_info = vk::RenderingInfo::builder()
                .flags(flags)
                .render_area(render_area)
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments)
                .depth_attachment(&depth_attachment);
            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        };

        // `beginSecondaryCmdBuffer`
        let begin_secondary_cmd_buffer =
            |cmd: vk::CommandBuffer, rendering_flags: vk::RenderingFlags| -> Result<(), TestError> {
                let color_formats = [COLOR_ATTACHMENT_FORMAT];
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(rendering_flags)
                    .view_mask(0)
                    .color_attachment_formats(&color_formats)
                    .depth_attachment_format(DEPTH_ATTACHMENT_FORMAT)
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

        let post_commands = |cmd: vk::CommandBuffer| {
            copy_general_image_to_buffer(
                device,
                cmd,
                color_target_image.get(),
                color_buffer.get(),
                IMAGE_DIM,
                IMAGE_DIM,
            );
            copy_general_depth_image_to_buffer(device, cmd, depth_target_image.get(), depth_buffer.get());
        };

        if params.group_params.use_secondary_cmd_buffer {
            let sec = **sec_cmd_buffer.as_ref().expect("secondary command buffer");
            let contains = params
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

            // record secondary command buffer
            if contains {
                begin_secondary_cmd_buffer(sec, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)?;
                begin_render(sec, vk::RenderingFlags::empty());
            } else {
                begin_secondary_cmd_buffer(sec, vk::RenderingFlags::empty())?;
            }

            draw(sec);

            if contains {
                end_rendering(device, sec);
            }

            end_command_buffer(device, sec)?;

            // record primary command buffer
            begin_command_buffer(device, *cmd_buffer)?;

            pre_render_commands(*cmd_buffer);

            if !contains {
                begin_render(*cmd_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
            }

            unsafe { device.cmd_execute_commands(*cmd_buffer, &[sec]) };

            if !contains {
                end_rendering(device, *cmd_buffer);
            }

            post_commands(*cmd_buffer);
            end_command_buffer(device, *cmd_buffer)?;
        } else if dynamic_rendering {
            begin_command_buffer(device, *cmd_buffer)?;

            pre_render_commands(*cmd_buffer);
            begin_render(*cmd_buffer, vk::RenderingFlags::empty());
            draw(*cmd_buffer);
            end_rendering(device, *cmd_buffer);

            post_commands(*cmd_buffer);
            end_command_buffer(device, *cmd_buffer)?;
        } else {
            begin_command_buffer(device, *cmd_buffer)?;

            pre_render_commands(*cmd_buffer);
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass_handle)
                .framebuffer(framebuffer_handle)
                .render_area(render_area);
            unsafe { device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            draw(*cmd_buffer);
            unsafe { device.cmd_end_render_pass(*cmd_buffer) };

            post_commands(*cmd_buffer);
            end_command_buffer(device, *cmd_buffer)?;
        }

        // Submit
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Get result
        invalidate_alloc(device, color_buffer.get_allocation())?;
        invalidate_alloc(device, depth_buffer.get_allocation())?;
        let color_bytes = unsafe {
            std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size as usize)
        };
        let depth_bytes = unsafe {
            std::slice::from_raw_parts(depth_buffer.get_allocation().get_host_ptr(), depth_buffer_size as usize)
        };
        let result_image = ConstPixelBufferAccess::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            [IMAGE_DIM, IMAGE_DIM, 1],
            color_bytes,
        );

        // Verify results
        let reference = self.generate_reference_images()?;

        let mut fail = false;
        // Color aspect.
        if fuzzy_compare_ok(&reference.color.get_const_access(), &result_image, 0.02) != Some(true) {
            fail = true;
        }

        // Depth aspect.
        let mut depth_fail = false;

        for (index, texel) in depth_bytes.chunks_exact(2).enumerate() {
            // Ignore pixels that could be too close to having or not having coverage.
            if reference.masked[index] {
                continue;
            }

            // Compare the rest using a known threshold.
            let ref_value = reference.depth[index];
            let res_value = u16::from_le_bytes([texel[0], texel[1]]) as f32 / 65535.0;
            if !(res_value >= ref_value - DEPTH_THRESHOLD && res_value <= ref_value + DEPTH_THRESHOLD) {
                depth_fail = true;
            }
        }

        if fail || depth_fail {
            return Ok(TestStatus::fail("Result images are incorrect"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createInvertedDepthRangesTests`
pub fn create_inverted_depth_ranges_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("inverted_depth_ranges");

    let depth_clamp = [("depthclamp", true), ("nodepthclamp", false)];

    // (name, delta, depthBiasEnable, depthBiasClamp)
    let depth_params: [(&str, f32, bool, f32); 6] = [
        ("deltazero", 0.0, false, 0.0),
        ("deltasmall", 0.3, false, 0.0),
        ("deltaone", 1.0, false, 0.0),
        // depthBiasClamp must be smaller then maximum depth slope to make a difference
        ("deltaone_bias_clamp_neg", 1.0, true, -0.003),
        ("deltasmall_bias_clamp_pos", 0.3, true, 0.003),
        // Range > 1.0 requires VK_EXT_depth_range_unrestricted extension
        ("depth_range_unrestricted", 2.7, false, 0.0),
    ];

    for (clamp_name, depth_clamp_enable) in depth_clamp {
        for (params_name, delta, depth_bias_enable, depth_bias_clamp) in depth_params {
            let min_depth = 0.5 + delta / 2.0;
            let max_depth = min_depth - delta;
            debug_assert!(min_depth >= max_depth);

            let params = TestParams {
                min_depth,
                max_depth,
                depth_clamp_enable,
                depth_bias_enable,
                depth_bias_clamp,
                group_params,
            };
            group.add_child(Box::new(InvertedDepthRangesTest {
                name: format!("{clamp_name}_{params_name}"),
                params,
            }) as Box<dyn TestCase>);
        }
    }
    group
}

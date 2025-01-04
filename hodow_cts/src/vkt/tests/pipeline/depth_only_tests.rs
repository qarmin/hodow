// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDepthTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `depth.depth_only`: render passes (or subpasses, or dynamic rendering passes) that only update
// the depth buffer, as depth pre-passes or post-passes.
//
// A pre-pass clears depth to 1.0, draws the left half with depth 0.0, then (with color cleared to black) draws the whole framebuffer with depth 0.5:
// only the right half is drawn, so color is clear on the left and the geometry color on the right, and depth is 0.0 and 0.5. A post-pass clears
// color and depth, draws the left half with depth 0.0 into both, and then, loading, draws the whole framebuffer at depth 0.5 into depth only: color
// is the geometry color on the left and clear on the right. The shader object variants are not built.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::pipeline_depth_only::{DEPTH_ONLY, DEPTH_ONLY_VIEW_INDEX};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, default_rasterization_state, rect_2d,
};
use crate::vkt::tests::pipeline::pipeline_util::make_color_depth_render_pass;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EXTENT: u32 = 8;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const GEOM_COLOR: [u8; 4] = [0, 0, 255, 255];
const DEPTH_BACK: f32 = 1.0;
const DEPTH_MID: f32 = 0.5;
const DEPTH_FRONT: f32 = 0.0;

/// `DepthOnlyType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DepthOnlyType {
    SeparateRenderPasses,
    Subpasses,
    DynamicRendering,
}

/// `DepthOnlyParams`
#[derive(Clone, Copy)]
struct DepthOnlyParams {
    construction: PipelineConstructionType,
    depth_only_type: DepthOnlyType,
    /// true: pre-pass, false: post-pass.
    prepass: bool,
    add_view_index: bool,
}

struct DepthOnlyCase {
    name: String,
    params: DepthOnlyParams,
}

impl TestCase for DepthOnlyCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DepthOnlyCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_pipeline_construction_requirements(context, self.params.construction)?;
        if self.params.depth_only_type == DepthOnlyType::DynamicRendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.add_view_index {
            DEPTH_ONLY_VIEW_INDEX.programs
        } else {
            DEPTH_ONLY.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthOnlyInstance {
            context,
            params: self.params,
        })
    }
}

struct DepthOnlyInstance<'a> {
    context: &'a Context<'a>,
    params: DepthOnlyParams,
}

#[repr(C)]
#[derive(Clone, Copy)]
struct PushConstants {
    scale: [f32; 2],
    offset: [f32; 2],
    depth: f32,
}

fn push_constant_bytes(values: &PushConstants) -> Vec<u8> {
    values
        .scale
        .iter()
        .chain(values.offset.iter())
        .chain(std::iter::once(&values.depth))
        .flat_map(|value| value.to_ne_bytes())
        .collect()
}

fn attachment_description(
    format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    initial_layout: vk::ImageLayout,
    final_layout: vk::ImageLayout,
) -> vk::AttachmentDescription {
    vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(load_op)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(initial_layout)
        .final_layout(final_layout)
        .build()
}

fn create_render_pass<'a>(
    device: &'a Device,
    attachments: &[vk::AttachmentDescription],
    subpasses: &[vk::SubpassDescription],
    dependencies: &[vk::SubpassDependency],
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(attachments)
        .subpasses(subpasses)
        .dependencies(dependencies);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

impl TestInstance for DepthOnlyInstance<'_> {
    /// `DepthOnlyInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let params = self.params;
        let extent_vk = vk::Extent3D {
            width: EXTENT,
            height: EXTENT,
            depth: 1,
        };
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);

        // These are used for several barriers and dependencies.
        let color_access = vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        let color_stage = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
        let depth_access =
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
        let depth_stage = vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;

        // Color and depth buffers.
        let color_buffer = ImageWithBuffer::new(
            context,
            EXTENT,
            EXTENT,
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let depth_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(DEPTH_FORMAT)
            .extent(extent_vk)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let depth_image = ImageWithMemory::new(device, alloc, depth_info, MemoryRequirement::ANY)?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            depth_srr,
        )?;
        let depth_result_size = (EXTENT * EXTENT * 2) as vk::DeviceSize;
        let depth_result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(depth_result_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let use_subpasses = params.depth_only_type == DepthOnlyType::Subpasses;
        let use_dynamic_rendering = params.depth_only_type == DepthOnlyType::DynamicRendering;

        // Render passes and framebuffers.
        let mut depth_only_render_pass = None;
        let mut depth_color_render_pass = None;
        let mut common_render_pass = None;
        let mut depth_only_framebuffer = None;
        let mut depth_color_framebuffer = None;
        let mut common_framebuffer = None;

        let color_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_ref_1 = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };

        match params.depth_only_type {
            DepthOnlyType::SeparateRenderPasses => {
                if params.prepass {
                    // The first render pass will clear attachments and use only a depth attachment.
                    depth_only_render_pass = Some(make_color_depth_render_pass(
                        device,
                        vk::Format::UNDEFINED,
                        DEPTH_FORMAT,
                        vk::AttachmentLoadOp::CLEAR,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    )?);

                    // The second render pass will load the depth attachment and clear the color attachment.
                    let att_descs = [
                        attachment_description(
                            COLOR_FORMAT,
                            vk::AttachmentLoadOp::CLEAR,
                            vk::ImageLayout::UNDEFINED,
                            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        ),
                        attachment_description(
                            DEPTH_FORMAT,
                            vk::AttachmentLoadOp::LOAD,
                            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        ),
                    ];
                    let subpasses = [vk::SubpassDescription::builder()
                        .pipeline_bind_point(bind_point)
                        .color_attachments(&color_ref)
                        .depth_stencil_attachment(&depth_ref_1)
                        .build()];
                    depth_color_render_pass = Some(create_render_pass(device, &att_descs, &subpasses, &[])?);
                } else {
                    // The first render pass will clear both the color and depth attachments.
                    depth_color_render_pass = Some(make_color_depth_render_pass(
                        device,
                        COLOR_FORMAT,
                        DEPTH_FORMAT,
                        vk::AttachmentLoadOp::CLEAR,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    )?);

                    // The second render pass will load and use the depth attachment only.
                    depth_only_render_pass = Some(make_color_depth_render_pass(
                        device,
                        vk::Format::UNDEFINED,
                        DEPTH_FORMAT,
                        vk::AttachmentLoadOp::LOAD,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    )?);
                }
                depth_only_framebuffer = Some(make_framebuffer(
                    device,
                    **depth_only_render_pass.as_ref().expect("set above"),
                    &[*depth_view],
                    EXTENT,
                    EXTENT,
                    1,
                )?);
                depth_color_framebuffer = Some(make_framebuffer(
                    device,
                    **depth_color_render_pass.as_ref().expect("set above"),
                    &[*color_buffer.view, *depth_view],
                    EXTENT,
                    EXTENT,
                    1,
                )?);
            }
            DepthOnlyType::Subpasses => {
                let att_descs = [
                    attachment_description(
                        COLOR_FORMAT,
                        vk::AttachmentLoadOp::CLEAR,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    ),
                    attachment_description(
                        DEPTH_FORMAT,
                        vk::AttachmentLoadOp::CLEAR,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    ),
                ];
                let subpass_dependency = [vk::SubpassDependency {
                    src_subpass: 0,
                    dst_subpass: 1,
                    src_stage_mask: depth_stage,
                    dst_stage_mask: depth_stage,
                    src_access_mask: depth_access,
                    dst_access_mask: depth_access,
                    dependency_flags: vk::DependencyFlags::BY_REGION,
                }];
                let depth_only_refs = [depth_ref_1];
                let depth_only_subpass = vk::SubpassDescription::builder()
                    .pipeline_bind_point(bind_point)
                    .depth_stencil_attachment(&depth_only_refs[0])
                    .build();
                let depth_color_subpass = vk::SubpassDescription::builder()
                    .pipeline_bind_point(bind_point)
                    .color_attachments(&color_ref)
                    .depth_stencil_attachment(&depth_ref_1)
                    .build();
                // A pre-pass draws depth only first and then both; a post-pass the other way around.
                let subpasses = if params.prepass {
                    [depth_only_subpass, depth_color_subpass]
                } else {
                    [depth_color_subpass, depth_only_subpass]
                };
                common_render_pass = Some(create_render_pass(device, &att_descs, &subpasses, &subpass_dependency)?);
                common_framebuffer = Some(make_framebuffer(
                    device,
                    **common_render_pass.as_ref().expect("set above"),
                    &[*color_buffer.view, *depth_view],
                    EXTENT,
                    EXTENT,
                    1,
                )?);
            }
            DepthOnlyType::DynamicRendering => {}
        }

        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: std::mem::size_of::<PushConstants>() as u32,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let make_state = |with_color: bool, subpass: u32| -> DrawPipelineState {
            let mut state =
                DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(EXTENT, EXTENT);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            }];
            state.rasterization = default_rasterization_state();
            state.rasterization.depth_bias_enable = vk::FALSE;
            state.depth_stencil.depth_test_enable = vk::TRUE;
            state.depth_stencil.depth_write_enable = vk::TRUE;
            state.depth_stencil.depth_compare_op = vk::CompareOp::LESS;
            state.depth_stencil.stencil_test_enable = vk::FALSE;
            state.color_attachment_count = u32::from(with_color);
            state.subpass = subpass;
            state.construction = params.construction;
            if use_dynamic_rendering {
                state.rendering_format = Some(if with_color {
                    COLOR_FORMAT
                } else {
                    vk::Format::UNDEFINED
                });
                state.depth_rendering_format = DEPTH_FORMAT;
            }
            state
        };

        let depth_only_render_pass_handle = if use_subpasses {
            common_render_pass.as_ref()
        } else {
            depth_only_render_pass.as_ref()
        }
        .map(|render_pass| **render_pass)
        .unwrap_or_default();
        let depth_only_subpass = if use_subpasses && !params.prepass { 1 } else { 0 };
        let depth_color_render_pass_handle = if use_subpasses {
            common_render_pass.as_ref()
        } else {
            depth_color_render_pass.as_ref()
        }
        .map(|render_pass| **render_pass)
        .unwrap_or_default();
        let depth_color_subpass = if use_subpasses && params.prepass { 1 } else { 0 };

        let depth_only_pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            depth_only_render_pass_handle,
            &[(vk::ShaderStageFlags::VERTEX, *vert_module)],
            &make_state(false, depth_only_subpass),
        )?;
        let depth_color_pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            depth_color_render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &make_state(true, depth_color_subpass),
        )?;

        let vertices: [[f32; 4]; 4] = [
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let depth_clear_value = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: DEPTH_BACK,
                stencil: 0,
            },
        };
        let color_clear_value = clear_value_color(CLEAR_COLOR);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let render_area = rect_2d(EXTENT, EXTENT);
        let layout = *pipeline_layout;

        let draw = |scale: [f32; 2], depth: f32| {
            let values = PushConstants {
                scale,
                offset: [-1.0, -1.0],
                depth,
            };
            unsafe {
                device.cmd_push_constants(
                    cmd,
                    layout,
                    vk::ShaderStageFlags::VERTEX,
                    0,
                    &push_constant_bytes(&values),
                );
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
        };
        let draw_left = |depth: f32| draw([1.0, 2.0], depth);
        let draw_full = |depth: f32| draw([2.0, 2.0], depth);
        let memory_barrier = || {
            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(depth_access)
                .dst_access_mask(depth_access)
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    depth_stage,
                    depth_stage,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                )
            };
        };
        let begin_render_pass =
            |render_pass: vk::RenderPass, framebuffer: vk::Framebuffer, clear_values: &[vk::ClearValue]| {
                let info = vk::RenderPassBeginInfo::builder()
                    .render_pass(render_pass)
                    .framebuffer(framebuffer)
                    .render_area(render_area)
                    .clear_values(clear_values);
                unsafe { device.cmd_begin_render_pass(cmd, &info, vk::SubpassContents::INLINE) };
            };
        let attachment_info = |view: vk::ImageView,
                               layout: vk::ImageLayout,
                               load_op: vk::AttachmentLoadOp,
                               clear_value: vk::ClearValue| {
            vk::RenderingAttachmentInfo::builder()
                .image_view(view)
                .image_layout(layout)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(load_op)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_value)
                .build()
        };
        let color_attachment = |load_op: vk::AttachmentLoadOp| {
            attachment_info(
                *color_buffer.view,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                load_op,
                color_clear_value,
            )
        };
        let depth_attachment = |load_op: vk::AttachmentLoadOp| {
            attachment_info(
                *depth_view,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                load_op,
                depth_clear_value,
            )
        };

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]) };

        match params.depth_only_type {
            DepthOnlyType::DynamicRendering => {
                let barriers = [
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        color_access,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        color_buffer.image.get(),
                        color_srr,
                    ),
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        depth_access,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        depth_image.get(),
                        depth_srr,
                    ),
                ];
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                        color_stage | depth_stage,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &barriers,
                    );
                }

                let begin_depth_only = |load_op: vk::AttachmentLoadOp| {
                    let depth = depth_attachment(load_op);
                    let info = vk::RenderingInfo::builder()
                        .render_area(render_area)
                        .layer_count(1)
                        .view_mask(0)
                        .depth_attachment(&depth);
                    unsafe { device.cmd_begin_rendering(cmd, &info) };
                };
                let begin_depth_color = |depth_load_op: vk::AttachmentLoadOp| {
                    let colors = [color_attachment(vk::AttachmentLoadOp::CLEAR)];
                    let depth = depth_attachment(depth_load_op);
                    let info = vk::RenderingInfo::builder()
                        .render_area(render_area)
                        .layer_count(1)
                        .view_mask(0)
                        .color_attachments(&colors)
                        .depth_attachment(&depth);
                    unsafe { device.cmd_begin_rendering(cmd, &info) };
                };
                let bind = |pipeline: &Unique<'_, vk::Pipeline>| unsafe {
                    device.cmd_bind_pipeline(cmd, bind_point, pipeline.get())
                };

                if params.prepass {
                    begin_depth_only(vk::AttachmentLoadOp::CLEAR);
                    bind(&depth_only_pipeline);
                    draw_left(DEPTH_FRONT);
                    unsafe { device.cmd_end_rendering(cmd) };

                    memory_barrier();

                    begin_depth_color(vk::AttachmentLoadOp::LOAD);
                    bind(&depth_color_pipeline);
                    draw_full(DEPTH_MID);
                    unsafe { device.cmd_end_rendering(cmd) };
                } else {
                    begin_depth_color(vk::AttachmentLoadOp::CLEAR);
                    bind(&depth_color_pipeline);
                    draw_left(DEPTH_FRONT);
                    unsafe { device.cmd_end_rendering(cmd) };

                    memory_barrier();

                    begin_depth_only(vk::AttachmentLoadOp::LOAD);
                    bind(&depth_only_pipeline);
                    draw_full(DEPTH_MID);
                    unsafe { device.cmd_end_rendering(cmd) };
                }
            }
            DepthOnlyType::Subpasses => {
                let clear_values = [color_clear_value, depth_clear_value];
                begin_render_pass(
                    **common_render_pass.as_ref().expect("subpasses"),
                    **common_framebuffer.as_ref().expect("subpasses"),
                    &clear_values,
                );
                let (first, second) = if params.prepass {
                    (&depth_only_pipeline, &depth_color_pipeline)
                } else {
                    (&depth_color_pipeline, &depth_only_pipeline)
                };
                unsafe { device.cmd_bind_pipeline(cmd, bind_point, first.get()) };
                draw_left(DEPTH_FRONT);
                unsafe {
                    device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
                    device.cmd_bind_pipeline(cmd, bind_point, second.get());
                }
                draw_full(DEPTH_MID);
                unsafe { device.cmd_end_render_pass(cmd) };
            }
            DepthOnlyType::SeparateRenderPasses => {
                let depth_only_rp = **depth_only_render_pass.as_ref().expect("separate render passes");
                let depth_color_rp = **depth_color_render_pass.as_ref().expect("separate render passes");
                let depth_only_fb = **depth_only_framebuffer.as_ref().expect("separate render passes");
                let depth_color_fb = **depth_color_framebuffer.as_ref().expect("separate render passes");
                if params.prepass {
                    begin_render_pass(depth_only_rp, depth_only_fb, &[depth_clear_value]);
                    unsafe { device.cmd_bind_pipeline(cmd, bind_point, depth_only_pipeline.get()) };
                    draw_left(DEPTH_FRONT);
                    unsafe { device.cmd_end_render_pass(cmd) };

                    memory_barrier();

                    begin_render_pass(depth_color_rp, depth_color_fb, &[color_clear_value]);
                    unsafe { device.cmd_bind_pipeline(cmd, bind_point, depth_color_pipeline.get()) };
                    draw_full(DEPTH_MID);
                    unsafe { device.cmd_end_render_pass(cmd) };
                } else {
                    begin_render_pass(depth_color_rp, depth_color_fb, &[color_clear_value, depth_clear_value]);
                    unsafe { device.cmd_bind_pipeline(cmd, bind_point, depth_color_pipeline.get()) };
                    draw_left(DEPTH_FRONT);
                    unsafe { device.cmd_end_render_pass(cmd) };

                    memory_barrier();

                    begin_render_pass(depth_only_rp, depth_only_fb, &[]);
                    unsafe { device.cmd_bind_pipeline(cmd, bind_point, depth_only_pipeline.get()) };
                    draw_full(DEPTH_MID);
                    unsafe { device.cmd_end_render_pass(cmd) };
                }
            }
        }

        {
            let copy_access = vk::AccessFlags::TRANSFER_READ;
            let copy_stage = vk::PipelineStageFlags::TRANSFER;
            let pre_copy_barriers = [
                make_image_memory_barrier(
                    color_access,
                    copy_access,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    depth_access,
                    copy_access,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_image.get(),
                    depth_srr,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    color_stage | depth_stage,
                    copy_stage,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_copy_barriers,
                );
                let color_region = vk::BufferImageCopy {
                    buffer_offset: 0,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        mip_level: 0,
                        base_array_layer: 0,
                        layer_count: 1,
                    },
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: extent_vk,
                };
                device.cmd_copy_image_to_buffer(
                    cmd,
                    color_buffer.image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.buffer.get(),
                    &[color_region],
                );
                let depth_region = vk::BufferImageCopy {
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::DEPTH,
                        ..color_region.image_subresource
                    },
                    ..color_region
                };
                device.cmd_copy_image_to_buffer(
                    cmd,
                    depth_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_result_buffer.get(),
                    &[depth_region],
                );
                let post_copy_barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(copy_access)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .build();
                device.cmd_pipeline_barrier(
                    cmd,
                    copy_stage,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[post_copy_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, depth_result_buffer.get_allocation())?;
        let color = color_buffer.read_bytes(device)?;
        let depth_bytes = unsafe {
            std::slice::from_raw_parts(
                depth_result_buffer.get_allocation().get_host_ptr(),
                depth_result_size as usize,
            )
        };

        let clear_bytes = CLEAR_COLOR.map(|channel| (channel * 255.0).round() as u8);
        let half = EXTENT / 2;
        let mut color_ok = true;
        let mut depth_ok = true;
        // 1/65535 < 0.000025 < 2/65535
        let depth_threshold = 0.000025f32;
        for y in 0..EXTENT {
            for x in 0..EXTENT {
                let left = x < half;
                let expected_color = if left == params.prepass {
                    clear_bytes
                } else {
                    GEOM_COLOR
                };
                let index = (y * EXTENT + x) as usize;
                if color[index * 4..index * 4 + 4] != expected_color {
                    color_ok = false;
                }
                let depth =
                    f32::from(u16::from_ne_bytes([depth_bytes[index * 2], depth_bytes[index * 2 + 1]])) / 65535.0;
                let expected_depth = if left { DEPTH_FRONT } else { DEPTH_MID };
                if (depth - expected_depth).abs() > depth_threshold {
                    depth_ok = false;
                }
            }
        }

        if !(color_ok && depth_ok) {
            return Ok(TestStatus::fail(
                "Unexpected results found in color/depth buffers; check log for details --",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `depth_only` group of `createDepthTests`.
pub fn create_depth_only_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("depth_only");
    let type_cases = [
        (DepthOnlyType::SeparateRenderPasses, "separate_render_passes"),
        (DepthOnlyType::Subpasses, "subpasses"),
        (DepthOnlyType::DynamicRendering, "dynamic_rendering"),
    ];

    for (depth_only_type, type_name) in type_cases {
        for prepass in [false, true] {
            for add_view_index in [false, true] {
                let params = DepthOnlyParams {
                    construction,
                    depth_only_type,
                    prepass,
                    add_view_index,
                };
                let name = format!(
                    "{type_name}{}{}",
                    if prepass { "_prepass" } else { "_postpass" },
                    if add_view_index { "_add_view_index" } else { "" }
                );
                group.add_child(Box::new(DepthOnlyCase { name, params }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineFramebufferAttachmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. `tcu::intThresholdCompare` with a threshold of 1 is a
// per-byte comparison with a tolerance of 1 on the RGBA8 readback, and the result image is not logged.
//
// `framebuffer_attachment`: rendering to a framebuffer smaller than its attachments must leave the rest of the attachments alone.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_framebuffer_attachment::{
    FB_COLOR, FB_DIFFERENT_SIZES, FB_INPUT_RESOLVE, FB_NO_ATTACHMENTS, FB_NO_ATTACHMENTS_MS, FB_NOT_EXPORTED,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, begin_dynamic_rendering_with_load_op, end_dynamic_rendering, make_shader_objects,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const PIXEL_SIZE: usize = 4;

/// The RGBA8 value of `vec4(1.0, 0.5, 0.25, 1.0)`.
const FRAGMENT_COLOR: [u8; 4] = [255, 128, 64, 255];

#[derive(Clone, Copy, PartialEq, Eq)]
enum ViewKind {
    OneD,
    OneDArray,
    TwoD,
    TwoDArray,
    Cube,
    CubeArray,
}

impl ViewKind {
    /// `getImageType`
    fn image_type(self) -> vk::ImageType {
        match self {
            ViewKind::OneD | ViewKind::OneDArray => vk::ImageType::_1D,
            ViewKind::TwoD | ViewKind::TwoDArray | ViewKind::Cube | ViewKind::CubeArray => vk::ImageType::_2D,
        }
    }

    /// The view type of one layer: a cube is attached as a 2D view.
    fn attachment_view_type(self) -> vk::ImageViewType {
        match self {
            ViewKind::OneD => vk::ImageViewType::_1D,
            ViewKind::OneDArray => vk::ImageViewType::_1D_ARRAY,
            ViewKind::TwoD => vk::ImageViewType::_2D,
            ViewKind::TwoDArray => vk::ImageViewType::_2D_ARRAY,
            ViewKind::Cube | ViewKind::CubeArray => vk::ImageViewType::_2D,
        }
    }

    /// `getShortImageViewTypeName`
    fn short_name(self) -> &'static str {
        match self {
            ViewKind::OneD => "1d",
            ViewKind::OneDArray => "1d_array",
            ViewKind::TwoD => "2d",
            ViewKind::TwoDArray => "2d_array",
            ViewKind::Cube => "cube",
            ViewKind::CubeArray => "cube_array",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum MultiAttachmentsTestType {
    None,
    DifferentSizes,
    NotExported,
}

/// `CaseDef`
#[derive(Clone, Copy)]
struct CaseDef {
    image_type: ViewKind,
    render_size: [i32; 3],
    attachment_size: [i32; 3],
    num_layers: u32,
    multisample: bool,
    multi_attachments_test_type: MultiAttachmentsTestType,
}

/// `getSizeString`
fn get_size_string(case_def: &CaseDef) -> String {
    let mut s = case_def.render_size[0].to_string();
    if case_def.render_size[1] > 1 {
        s += &format!("x{}", case_def.render_size[1]);
    }
    if case_def.render_size[2] > 1 {
        s += &format!("x{}", case_def.render_size[2]);
    }

    s += &format!("_{}", case_def.attachment_size[0]);

    if case_def.attachment_size[1] > 1 {
        s += &format!("x{}", case_def.attachment_size[1]);
    }
    if case_def.attachment_size[2] > 1 {
        s += &format!("x{}", case_def.attachment_size[2]);
    }
    if case_def.num_layers > 1 {
        s += &format!("_{}", case_def.num_layers);
    }
    s
}

/// `getTestCaseString`
fn get_test_case_string(case_def: &CaseDef) -> String {
    format!(
        "{}_{}{}",
        case_def.image_type.short_name(),
        get_size_string(case_def),
        if case_def.multisample { "_ms" } else { "" }
    )
}

#[derive(Clone, Copy)]
enum Kind {
    Attachment(CaseDef),
    NoAttachments { multisample: bool },
    UnusedAttachment,
    MultiAttachments(CaseDef),
    InputResolveSameAttachment(CaseDef),
}

struct FramebufferAttachmentCase {
    name: String,
    kind: Kind,
}

impl TestCase for FramebufferAttachmentCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // `checkSupportNoAtt`; the other cases only check the pipeline construction type.
        if let Kind::NoAttachments { multisample } = self.kind {
            let features = context.get_device_features();
            if features.fragment_stores_and_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "fragmentStoresAndAtomics not supported".to_string(),
                ));
            }

            // Shader uses gl_PrimitiveID
            if features.geometry_shader == vk::FALSE && features.tessellation_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "geometryShader or tessellationShader feature not supported".to_string(),
                ));
            }

            // MS shader uses gl_SampleID
            if multisample && features.sample_rate_shading == vk::FALSE {
                return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::Attachment(_) => FB_COLOR.programs,
            Kind::NoAttachments { multisample: false } => FB_NO_ATTACHMENTS.programs,
            Kind::NoAttachments { multisample: true } => FB_NO_ATTACHMENTS_MS.programs,
            Kind::UnusedAttachment => BinaryCollection::new(&[]),
            Kind::MultiAttachments(case_def) => {
                if case_def.multi_attachments_test_type == MultiAttachmentsTestType::NotExported {
                    FB_NOT_EXPORTED.programs
                } else {
                    FB_DIFFERENT_SIZES.programs
                }
            }
            Kind::InputResolveSameAttachment(_) => FB_INPUT_RESOLVE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FramebufferAttachmentInstance {
            context,
            kind: self.kind,
        })
    }
}

struct FramebufferAttachmentInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for FramebufferAttachmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::Attachment(case_def) => test(self.context, case_def),
            Kind::NoAttachments { multisample } => test_no_att(self.context, multisample),
            Kind::UnusedAttachment => test_unused_att(self.context),
            Kind::MultiAttachments(case_def) => test_multi_attachments(self.context, case_def),
            Kind::InputResolveSameAttachment(case_def) => test_input_resolve_same_attachment(self.context, case_def),
        }
    }
}

/// `makeColorSubresourceRange`
fn make_color_subresource_range(base_array_layer: u32, layer_count: u32) -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, base_array_layer, layer_count)
}

fn samples_for(multisample: bool) -> vk::SampleCountFlags {
    if multisample {
        vk::SampleCountFlags::_4
    } else {
        vk::SampleCountFlags::_1
    }
}

fn extent_of(size: [i32; 3]) -> vk::Extent3D {
    vk::Extent3D {
        width: size[0] as u32,
        height: size[1] as u32,
        depth: size[2] as u32,
    }
}

/// `makeImage`
fn make_image<'a>(
    context: &'a Context<'a>,
    image_type: vk::ImageType,
    size: [i32; 3],
    num_layers: u32,
    usage: vk::ImageUsageFlags,
    multisample: bool,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(image_type)
        .format(COLOR_FORMAT)
        .extent(extent_of(size))
        .mip_levels(1)
        .array_layers(num_layers)
        .samples(samples_for(multisample))
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// `makeBuffer` plus `bindBuffer`: a host visible buffer the images are copied to.
fn make_readback_buffer<'a>(context: &'a Context<'a>, size: vk::DeviceSize) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )
}

/// `genFullQuadVertices`
fn gen_full_quad_vertices(subpass_count: u32) -> Vec<[f32; 4]> {
    let mut vertices = Vec::new();
    for _ in 0..subpass_count {
        vertices.push([-1.0, -1.0, 0.0, 1.0]);
        vertices.push([-1.0, 1.0, 0.0, 1.0]);
        vertices.push([1.0, -1.0, 0.0, 1.0]);
        vertices.push([1.0, 1.0, 0.0, 1.0]);
    }
    vertices
}

fn image_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            barriers,
        )
    };
}

/// Copies the whole `size` x `layers` image to the buffer and makes it readable by the host.
fn copy_image_to_buffer_for_host(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: [i32; 3],
    layers: u32,
) {
    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, layers),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: extent_of(size),
    };
    unsafe { device.cmd_copy_image_to_buffer(cmd, image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]) };

    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer,
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `tcu::intThresholdCompare` with a threshold of 1 over an RGBA8 `width` x `height` x `depth` image, against `expected(x, y, z)`.
fn matches_expected(
    result: &[u8],
    width: usize,
    height: usize,
    depth: usize,
    expected: impl Fn(usize, usize, usize) -> [u8; 4],
) -> bool {
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let offset = ((z * height + y) * width + x) * PIXEL_SIZE;
                let want = expected(x, y, z);
                if result[offset..offset + PIXEL_SIZE]
                    .iter()
                    .zip(want)
                    .any(|(&got, want)| got.abs_diff(want) > 1)
                {
                    return false;
                }
            }
        }
    }
    true
}

/// `makeRenderPass`: a render pass with one subpass per color attachment and one attachment per image layer.
fn make_render_pass_layers(
    device: &Device,
    num_layers: u32,
    multisample: bool,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_descriptions: Vec<vk::AttachmentDescription> = (0..num_layers)
        .map(|_| {
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(samples_for(multisample))
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::GENERAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build()
        })
        .collect();

    // Create a subpass for each attachment (each attachment is a layer of an arrayed image).
    let color_attachment_references: Vec<vk::AttachmentReference> = (0..num_layers)
        .map(|i| vk::AttachmentReference {
            attachment: i,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        })
        .collect();
    let subpasses: Vec<vk::SubpassDescription> = (0..num_layers as usize)
        .map(|i| {
            vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_attachment_references[i..=i])
                .build()
        })
        .collect();

    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `preparePipelineWrapper`, for the monolithic construction type.
#[allow(clippy::too_many_arguments)]
fn prepare_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    render_size: [i32; 3],
    topology: vk::PrimitiveTopology,
    subpass: u32,
    num_attachments: u32,
    multisample: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let mut state = DrawPipelineState::new(topology)
        .with_position_input()
        .with_full_viewport(render_size[0] as u32, render_size[1] as u32);
    state.color_attachment_count = num_attachments;
    state.samples = samples_for(multisample);
    state.subpass = subpass;
    create_draw_pipeline(
        device,
        layout,
        render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, fragment_module),
        ],
        &state,
    )
}

/// Tests rendering to a a framebuffer with color attachments larger than the framebuffer dimensions and verifies that rendering does
/// not affect the areas of the attachment outside the framebuffer dimensions. Tests both single-sample and multi-sample
/// configurations.
fn test<'a>(context: &'a Context<'a>, case_def: CaseDef) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let num_layers = case_def.num_layers;

    // Host memory buffer where we will copy the rendered image for verification
    let color_buffer_size = (case_def.attachment_size[0] * case_def.attachment_size[1] * case_def.attachment_size[2])
        as vk::DeviceSize
        * num_layers as vk::DeviceSize
        * PIXEL_SIZE as vk::DeviceSize;
    let color_buffer = make_readback_buffer(context, color_buffer_size)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let render_pass = make_render_pass_layers(device, num_layers, case_def.multisample)?;
    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let image_view_type = case_def.image_type.attachment_view_type();

    // create vertexBuffer
    let vertex_buffer = create_host_buffer(
        context,
        &gen_full_quad_vertices(num_layers),
        vk::BufferUsageFlags::VERTEX_BUFFER,
    )?;

    // create colorImage (and msColorImage) using the configured attachmentsize
    let color_image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let color_image = make_image(
        context,
        case_def.image_type.image_type(),
        case_def.attachment_size,
        num_layers,
        color_image_usage,
        false,
    )?;
    let ms_color_image = if case_def.multisample {
        Some(make_image(
            context,
            case_def.image_type.image_type(),
            case_def.attachment_size,
            num_layers,
            color_image_usage,
            true,
        )?)
    } else {
        None
    };
    let render_target = ms_color_image.as_ref().unwrap_or(&color_image).get();

    // create attachmentHandles and pipelines (one for each layer). We use the renderSize for viewport and scissor
    let mut color_attachments = Vec::new();
    let mut pipelines = Vec::new();
    for layer_ndx in 0..num_layers {
        color_attachments.push(make_image_view(
            device,
            render_target,
            image_view_type,
            COLOR_FORMAT,
            make_color_subresource_range(layer_ndx, 1),
        )?);
        if shader_objects.is_none() {
            pipelines.push(prepare_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                *vertex_module,
                *fragment_module,
                case_def.render_size,
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                layer_ndx,
                1,
                case_def.multisample,
            )?);
        }
    }
    let attachment_handles: Vec<vk::ImageView> = color_attachments.iter().map(|view| **view).collect();

    // create framebuffer
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &attachment_handles,
        case_def.render_size[0] as u32,
        case_def.render_size[1] as u32,
        1,
    )?;

    // record command buffer
    begin_command_buffer(device, cmd)?;
    {
        // Clear the entire image attachment to black
        let all_layers = make_color_subresource_range(0, num_layers);
        let layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            render_target,
            all_layers,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &[layout_barrier],
        );

        let clear_color = vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        };
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                render_target,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color,
                &[all_layers],
            )
        };

        let clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            if shader_objects.is_some() {
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
            } else {
                vk::ImageLayout::GENERAL
            },
            render_target,
            all_layers,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &[clear_barrier],
        );

        // Render pass: this should render only to the area defined by renderSize (smaller than the size of the attachment)
        if let Some(shader_objects) = &shader_objects {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
                .with_position_input()
                .with_full_viewport(case_def.render_size[0] as u32, case_def.render_size[1] as u32);
            state.color_attachment_count = 1;
            state.samples = samples_for(case_def.multisample);
            unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]) };
            for layer_ndx in 0..num_layers {
                let color = RenderingAttachment {
                    view: *color_attachments[layer_ndx as usize],
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    clear_value: vk::ClearValue {
                        color: vk::ClearColorValue { float32: [0.0; 4] },
                    },
                };
                begin_dynamic_rendering_with_load_op(
                    device,
                    cmd,
                    rect_2d(case_def.render_size[0] as u32, case_def.render_size[1] as u32),
                    &[color],
                    None,
                    None,
                    vk::AttachmentLoadOp::LOAD,
                );
                shader_objects.bind(cmd, &state);
                unsafe { device.cmd_draw(cmd, 4, 1, layer_ndx * 4, 0) };
                end_dynamic_rendering(device, cmd);
            }
        } else {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(case_def.render_size[0] as u32, case_def.render_size[1] as u32));
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                for layer_ndx in 0..num_layers {
                    if layer_ndx != 0 {
                        device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
                    }

                    device.cmd_bind_pipeline(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        pipelines[layer_ndx as usize].get(),
                    );
                    device.cmd_draw(cmd, 4, 1, layer_ndx * 4, 0);
                }
                device.cmd_end_render_pass(cmd);
            }
        }

        // If we are using a multi-sampled render target (msColorImage), resolve it now (to colorImage)
        if case_def.multisample {
            // Transition msColorImage (from layout COLOR_ATTACHMENT_OPTIMAL) and colorImage (from layout UNDEFINED) to layout GENERAL before resolving
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    render_target,
                    all_layers,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    color_image.get(),
                    all_layers,
                ),
            ];
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::PipelineStageFlags::TRANSFER,
                &barriers,
            );

            let region = vk::ImageResolve {
                src_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, num_layers),
                src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                dst_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, num_layers),
                dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                extent: extent_of(case_def.attachment_size),
            };
            unsafe {
                device.cmd_resolve_image(
                    cmd,
                    render_target,
                    vk::ImageLayout::GENERAL,
                    color_image.get(),
                    vk::ImageLayout::GENERAL,
                    &[region],
                )
            };
        }

        // copy colorImage to host visible colorBuffer
        let (src_access, old_layout, src_stage) = if case_def.multisample {
            (
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::GENERAL,
                vk::PipelineStageFlags::TRANSFER,
            )
        } else {
            (
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            )
        };
        let copy_barrier = make_image_memory_barrier(
            src_access,
            vk::AccessFlags::TRANSFER_READ,
            old_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            all_layers,
        );
        image_barrier(
            device,
            cmd,
            src_stage,
            vk::PipelineStageFlags::TRANSFER,
            &[copy_barrier],
        );

        copy_image_to_buffer_for_host(
            device,
            cmd,
            color_image.get(),
            color_buffer.get(),
            case_def.attachment_size,
            num_layers,
        );
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Verify results
    invalidate_alloc(device, color_buffer.get_allocation())?;
    let depth = case_def.attachment_size[2].max(num_layers as i32) as usize;
    let render_depth = case_def.render_size[2].max(num_layers as i32);
    let result = unsafe {
        std::slice::from_raw_parts(
            color_buffer.get_allocation().get_host_ptr(),
            case_def.attachment_size[0] as usize * case_def.attachment_size[1] as usize * depth * PIXEL_SIZE,
        )
    };

    let ok = matches_expected(
        result,
        case_def.attachment_size[0] as usize,
        case_def.attachment_size[1] as usize,
        depth,
        |x, y, z| {
            if (x as i32) < case_def.render_size[0] && (y as i32) < case_def.render_size[1] && (z as i32) < render_depth
            {
                FRAGMENT_COLOR
            } else {
                [0, 0, 0, 255]
            }
        },
    );
    if !ok {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `genPointVertices`
fn gen_point_vertices() -> Vec<[f32; 4]> {
    vec![
        [-0.25, -0.25, 0.0, 1.0],
        [-0.25, 0.25, 0.0, 1.0],
        [0.25, -0.25, 0.0, 1.0],
        [0.25, 0.25, 0.0, 1.0],
    ]
}

/// Tests rendering to a framebuffer without color attachments, checking that the fragment shader is run even in the absence of color
/// output. In this case we render 4 point primitives and we make the fragment shader write to a different pixel of an image via an
/// imageStore command. For the single-sampled configuration we use a 4x1 image to record the output and for the multi-sampled case
/// we use a 4x4 image to record all 16 samples produced by 4-sample multi-sampling
fn test_no_att(context: &Context<'_>, multisample: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let render_size = [32, 32, 1];

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

    // Create image where we will record the writes. For single-sampled cases this is a 4x1 image and for multi-sampled cases this is
    // a 4x<num_samples> image.
    let num_samples = if multisample { 4 } else { 1 };
    let image_width = 4;
    let image_height = num_samples;
    let image_dim = [image_width, image_height, 1];
    let image_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE;
    let image = make_image(context, vk::ImageType::_2D, image_dim, 1, image_usage, false)?;
    let image_subresource_range = make_color_subresource_range(0, 1);
    let image_view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        image_subresource_range,
    )?;

    // Create a buffer where we will copy the image for verification
    let color_buffer_size = (image_width * image_height * num_samples) as vk::DeviceSize * PIXEL_SIZE as vk::DeviceSize;
    let color_buffer = make_readback_buffer(context, color_buffer_size)?;

    // Create pipeline descriptor set for the image
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    let descriptor_image_info = [vk::DescriptorImageInfo::builder()
        .sampler(vk::Sampler::null())
        .image_view(*image_view)
        .image_layout(vk::ImageLayout::GENERAL)
        .build()];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
        .image_info(&descriptor_image_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    // `makeRenderPassNoAtt`: a single subpass with no attachment references
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    // create vertexBuffer
    let vertex_buffer = create_host_buffer(context, &gen_point_vertices(), vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Create pipeline
    let pipeline = prepare_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        *vertex_module,
        *fragment_module,
        render_size,
        vk::PrimitiveTopology::POINT_LIST,
        0,
        0,
        multisample,
    )?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[],
        render_size[0] as u32,
        render_size[1] as u32,
        1,
    )?;

    // Record command buffer
    begin_command_buffer(device, cmd)?;
    {
        // shader image layout transition undefined -> general
        let set_image_layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image.get(),
            image_subresource_range,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            &[set_image_layout_barrier],
        );

        // Render pass
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(render_size[0] as u32, render_size[1] as u32));
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 4, 1, 0, 0);

            device.cmd_end_render_pass(cmd);
        }

        // copy image to host visible colorBuffer
        let copy_barrier = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image.get(),
            make_color_subresource_range(0, 1),
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::PipelineStageFlags::TRANSFER,
            &[copy_barrier],
        );

        copy_image_to_buffer_for_host(device, cmd, image.get(), color_buffer.get(), image_dim, 1);
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Verify results
    invalidate_alloc(device, color_buffer.get_allocation())?;
    let result = unsafe {
        std::slice::from_raw_parts(
            color_buffer.get_allocation().get_host_ptr(),
            (image_width * image_height) as usize * PIXEL_SIZE,
        )
    };
    if !matches_expected(result, image_width as usize, image_height as usize, 1, |_, _, _| {
        FRAGMENT_COLOR
    }) {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `testUnusedAtt`
fn test_unused_att(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let att_ref = [vk::AttachmentReference {
        attachment: vk::ATTACHMENT_UNUSED,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&att_ref)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );

    let framebuffer = make_framebuffer(device, *render_pass, &[], 32, 32, 1)?;

    begin_command_buffer(device, cmd)?;
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(32, 32));
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_end_render_pass(cmd);
    }
    end_command_buffer(device, cmd)?;

    Ok(TestStatus::pass("Pass"))
}

/// `makeRenderPassMultiAttachments`: a render pass with three color attachments in one subpass.
fn make_render_pass_multi_attachments(
    device: &Device,
    num_attachments: u32,
    multisample: bool,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_descriptions: Vec<vk::AttachmentDescription> = (0..num_attachments)
        .map(|_| {
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(samples_for(multisample))
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build()
        })
        .collect();
    let color_attachment_references: Vec<vk::AttachmentReference> = (0..num_attachments)
        .map(|i| vk::AttachmentReference {
            attachment: i,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        })
        .collect();

    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_references)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// Tests framebuffer with attachments of different sizes
fn test_multi_attachments(context: &Context<'_>, case_def: CaseDef) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    const NUM_RENDER_TARGETS: usize = 3;
    let different_size_test = case_def.multi_attachments_test_type == MultiAttachmentsTestType::DifferentSizes;
    let not_export_test = case_def.multi_attachments_test_type == MultiAttachmentsTestType::NotExported;

    // Vary attachment sizes by adding an offset to the base size.
    let base = case_def.attachment_size;
    let attachment_sizes = [
        base,
        [base[0] + 10, base[1] + if base[1] == 1 { 0 } else { 15 }, base[2]],
        [base[0] + 27, base[1] + if base[1] == 1 { 0 } else { 4 }, base[2]],
    ];
    let size_of_target = |idx: usize| {
        if different_size_test {
            attachment_sizes[idx]
        } else {
            base
        }
    };

    // Use unique clear color for each render target to verify no leaking happens between render target clears.
    let clear_colors = [[1.0f32, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0], [0.0, 0.0, 1.0, 1.0]];
    let clear_color_bytes = [[255u8, 0, 0, 255], [0, 255, 0, 255], [0, 0, 255, 255]];
    let expected_colors = [[255u8, 128, 64, 255], [128, 255, 64, 255], [64, 128, 255, 255]];

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let render_pass = make_render_pass_multi_attachments(device, NUM_RENDER_TARGETS as u32, case_def.multisample)?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let image_view_type = case_def.image_type.attachment_view_type();
    let range = make_color_subresource_range(0, 1);

    // create color buffers
    let mut color_buffers = Vec::new();
    for render_target_idx in 0..NUM_RENDER_TARGETS {
        let size = size_of_target(render_target_idx);
        let color_buffer_size = (size[0] * size[1] * size[2]) as vk::DeviceSize * PIXEL_SIZE as vk::DeviceSize;
        color_buffers.push(make_readback_buffer(context, color_buffer_size)?);
    }

    // create vertexBuffer
    let vertex_buffer = create_host_buffer(context, &gen_full_quad_vertices(1), vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // create colorImages (and msColorImages) using the configured attachmentsize
    let image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let mut color_images = Vec::new();
    let mut ms_color_images = Vec::new();
    for render_target_idx in 0..NUM_RENDER_TARGETS {
        let size = size_of_target(render_target_idx);

        color_images.push(make_image(
            context,
            case_def.image_type.image_type(),
            size,
            1,
            image_usage,
            false,
        )?);
        if case_def.multisample {
            ms_color_images.push(make_image(
                context,
                case_def.image_type.image_type(),
                size,
                1,
                image_usage,
                true,
            )?);
        }
    }
    let render_targets: Vec<vk::Image> = (0..NUM_RENDER_TARGETS)
        .map(|idx| {
            if case_def.multisample {
                ms_color_images[idx].get()
            } else {
                color_images[idx].get()
            }
        })
        .collect();

    // create attachmentHandles. We use the renderSize for viewport and scissor
    let mut color_attachments = Vec::new();
    for &render_target in &render_targets {
        color_attachments.push(make_image_view(
            device,
            render_target,
            image_view_type,
            COLOR_FORMAT,
            range,
        )?);
    }
    let attachment_handles: Vec<vk::ImageView> = color_attachments.iter().map(|view| **view).collect();

    let pipeline = prepare_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        *vertex_module,
        *fragment_module,
        case_def.render_size,
        vk::PrimitiveTopology::TRIANGLE_STRIP,
        0,
        NUM_RENDER_TARGETS as u32,
        case_def.multisample,
    )?;

    // create framebuffer
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &attachment_handles,
        case_def.render_size[0] as u32,
        case_def.render_size[1] as u32,
        1,
    )?;

    // record command buffer
    begin_command_buffer(device, cmd)?;

    // Clear image attachments
    for render_target_idx in 0..NUM_RENDER_TARGETS {
        let target = render_targets[render_target_idx];

        let layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            target,
            range,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &[layout_barrier],
        );

        let clear_color = vk::ClearColorValue {
            float32: clear_colors[render_target_idx],
        };
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                target,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color,
                &[range],
            )
        };

        let clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            target,
            range,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &[clear_barrier],
        );
    }

    // Render pass: this should render only to the area defined by renderSize (smaller than the size of the attachment)
    {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(case_def.render_size[0] as u32, case_def.render_size[1] as u32));
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
    }

    // If we are using a multi-sampled render target (msColorImage), resolve it now (to colorImage)
    if case_def.multisample {
        for render_target_idx in 0..NUM_RENDER_TARGETS {
            let attachment_size = size_of_target(render_target_idx);

            // Transition msColorImage (from layout COLOR_ATTACHMENT_OPTIMAL) and colorImage (from layout UNDEFINED) to layout GENERAL before resolving
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    ms_color_images[render_target_idx].get(),
                    range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    color_images[render_target_idx].get(),
                    range,
                ),
            ];
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::PipelineStageFlags::TRANSFER,
                &barriers,
            );

            let region = vk::ImageResolve {
                src_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                dst_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                extent: extent_of(attachment_size),
            };
            unsafe {
                device.cmd_resolve_image(
                    cmd,
                    ms_color_images[render_target_idx].get(),
                    vk::ImageLayout::GENERAL,
                    color_images[render_target_idx].get(),
                    vk::ImageLayout::GENERAL,
                    &[region],
                )
            };
        }
    }

    for render_target_idx in 0..NUM_RENDER_TARGETS {
        let attachment_size = size_of_target(render_target_idx);

        // copy colorImage to host visible colorBuffer
        let (src_access, old_layout, src_stage) = if case_def.multisample {
            (
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::GENERAL,
                vk::PipelineStageFlags::TRANSFER,
            )
        } else {
            (
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            )
        };
        let barrier = make_image_memory_barrier(
            src_access,
            vk::AccessFlags::TRANSFER_READ,
            old_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_images[render_target_idx].get(),
            range,
        );
        image_barrier(device, cmd, src_stage, vk::PipelineStageFlags::TRANSFER, &[barrier]);

        copy_image_to_buffer_for_host(
            device,
            cmd,
            color_images[render_target_idx].get(),
            color_buffers[render_target_idx].get(),
            attachment_size,
            1,
        );
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Verify results
    let skipped_render_target = if not_export_test { 1 } else { NUM_RENDER_TARGETS };

    for render_target_idx in 0..NUM_RENDER_TARGETS {
        let size = size_of_target(render_target_idx);

        // Doesn't need to check the output of unused MRT, that may be undefined.
        if not_export_test && render_target_idx == skipped_render_target {
            continue;
        }

        let alloc = color_buffers[render_target_idx].get_allocation();
        invalidate_alloc(device, alloc)?;
        let result = unsafe {
            std::slice::from_raw_parts(
                alloc.get_host_ptr(),
                (size[0] * size[1] * size[2]) as usize * PIXEL_SIZE,
            )
        };

        let ok = matches_expected(
            result,
            size[0] as usize,
            size[1] as usize,
            size[2] as usize,
            |x, y, z| {
                if (x as i32) < case_def.render_size[0]
                    && (y as i32) < case_def.render_size[1]
                    && (z as i32) < case_def.render_size[2]
                {
                    expected_colors[render_target_idx]
                } else {
                    clear_color_bytes[render_target_idx]
                }
            },
        );
        if !ok {
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `makeRenderPassInputResolveSameAttachment`
fn make_render_pass_input_resolve_same_attachment(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let color_attachment_description = vk::AttachmentDescription::builder()
        .format(COLOR_FORMAT)
        .samples(vk::SampleCountFlags::_4)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let input_attachment_description = vk::AttachmentDescription::builder()
        .format(COLOR_FORMAT)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::GENERAL)
        .final_layout(vk::ImageLayout::GENERAL)
        .build();
    let attachment_descriptions = [color_attachment_description, input_attachment_description];

    let color_attachment_ref = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let input_attachment_ref = [vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::GENERAL,
    }];

    // The same attachment is the input and the resolve target.
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .input_attachments(&input_attachment_ref)
        .color_attachments(&color_attachment_ref)
        .resolve_attachments(&input_attachment_ref)
        .build()];

    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `testInputResolveSameAttachment`
fn test_input_resolve_same_attachment(context: &Context<'_>, case_def: CaseDef) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();

    // Use unique clear color for each render target to verify no leaking happens between render target clears.
    let clear_color = [
        vk::ClearColorValue {
            float32: [1.0, 0.0, 0.0, 1.0],
        },
        vk::ClearColorValue {
            float32: [0.0, 0.5, 0.0, 1.0],
        },
    ];

    // Create pipeline descriptor set for the image
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
    let render_pass = make_render_pass_input_resolve_same_attachment(device)?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let image_view_type = case_def.image_type.attachment_view_type();
    let range = make_color_subresource_range(0, 1);

    // create color buffer
    let attachment_size = case_def.attachment_size;
    let color_buffer_size =
        (attachment_size[0] * attachment_size[1] * attachment_size[2]) as vk::DeviceSize * PIXEL_SIZE as vk::DeviceSize;
    let color_buffer = make_readback_buffer(context, color_buffer_size)?;

    // create vertexBuffer
    let vertex_buffer = create_host_buffer(context, &gen_full_quad_vertices(1), vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // create colorImages (and msColorImages)
    let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::INPUT_ATTACHMENT;
    let color_image = make_image(
        context,
        case_def.image_type.image_type(),
        attachment_size,
        1,
        color_image_usage,
        false,
    )?;

    let ms_image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC;
    let ms_color_image = make_image(
        context,
        case_def.image_type.image_type(),
        attachment_size,
        1,
        ms_image_usage,
        true,
    )?;

    // create attachmentHandles. We use the renderSize for viewport and scissor
    let ms_view = make_image_view(device, ms_color_image.get(), image_view_type, COLOR_FORMAT, range)?;
    let color_view = make_image_view(device, color_image.get(), image_view_type, COLOR_FORMAT, range)?;
    let attachment_handles = [*ms_view, *color_view];

    let descriptor_image_info = [vk::DescriptorImageInfo::builder()
        .sampler(vk::Sampler::null())
        .image_view(attachment_handles[1])
        .image_layout(vk::ImageLayout::GENERAL)
        .build()];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
        .image_info(&descriptor_image_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let pipeline = prepare_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        *vertex_module,
        *fragment_module,
        case_def.render_size,
        vk::PrimitiveTopology::TRIANGLE_STRIP,
        0,
        1,
        true,
    )?;

    // create framebuffer
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &attachment_handles,
        case_def.render_size[0] as u32,
        case_def.render_size[1] as u32,
        1,
    )?;

    // record command buffer
    begin_command_buffer(device, cmd)?;

    // Clear image attachments
    {
        let layout_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                ms_color_image.get(),
                range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                color_image.get(),
                range,
            ),
        ];
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &layout_barriers,
        );

        unsafe {
            device.cmd_clear_color_image(
                cmd,
                ms_color_image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color[0],
                &[range],
            );
            device.cmd_clear_color_image(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color[1],
                &[range],
            );
        }

        let clear_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                ms_color_image.get(),
                range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                color_image.get(),
                range,
            ),
        ];
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &clear_barriers[..1],
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            &clear_barriers[1..],
        );
    }

    // Render pass: this should render only to the area defined by renderSize (smaller than the size of the attachment)
    {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(case_def.render_size[0] as u32, case_def.render_size[1] as u32));
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
    }

    // copy colorImage to host visible colorBuffer
    let barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        color_image.get(),
        range,
    );
    image_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        &[barrier],
    );

    copy_image_to_buffer_for_host(device, cmd, color_image.get(), color_buffer.get(), attachment_size, 1);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Verify results
    invalidate_alloc(device, color_buffer.get_allocation())?;
    let result = unsafe {
        std::slice::from_raw_parts(
            color_buffer.get_allocation().get_host_ptr(),
            (attachment_size[0] * attachment_size[1] * attachment_size[2]) as usize * PIXEL_SIZE,
        )
    };

    let ok = matches_expected(
        result,
        attachment_size[0] as usize,
        attachment_size[1] as usize,
        attachment_size[2] as usize,
        |x, y, z| {
            if (x as i32) < case_def.render_size[0]
                && (y as i32) < case_def.render_size[1]
                && (z as i32) < case_def.render_size[2]
            {
                FRAGMENT_COLOR
            } else {
                [255, 0, 0, 255]
            }
        },
    );
    if !ok {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// The `caseDef` tables of `addAttachmentTestCasesWithFunctions`, in upstream's order.
fn attachment_case_defs(multi: MultiAttachmentsTestType) -> Vec<CaseDef> {
    let mut defs = Vec::new();
    let mut push =
        |image_type: ViewKind, render_size: [i32; 3], attachment_size: [i32; 3], num_layers: u32, multisample: bool| {
            defs.push(CaseDef {
                image_type,
                render_size,
                attachment_size,
                num_layers,
                multisample,
                multi_attachments_test_type: multi,
            });
        };

    // The four size combinations every image type is tested with.
    let size_sets = |two_dimensional: bool| -> [([i32; 3], [i32; 3]); 4] {
        if two_dimensional {
            [
                ([32, 32, 1], [64, 64, 1]),
                ([32, 32, 1], [48, 48, 1]),
                ([32, 32, 1], [39, 41, 1]),
                ([19, 27, 1], [32, 32, 1]),
            ]
        } else {
            [
                ([32, 1, 1], [64, 1, 1]),
                ([32, 1, 1], [48, 1, 1]),
                ([32, 1, 1], [39, 1, 1]),
                ([19, 1, 1], [32, 1, 1]),
            ]
        }
    };

    if multi == MultiAttachmentsTestType::None {
        // Single-sample test cases
        for (kind, layers, two_dimensional) in [
            (ViewKind::OneD, 1, false),
            (ViewKind::OneDArray, 4, false),
            (ViewKind::TwoD, 1, true),
            (ViewKind::TwoDArray, 4, true),
            (ViewKind::Cube, 6, true),
            (ViewKind::CubeArray, 12, true),
        ] {
            for (render_size, attachment_size) in size_sets(two_dimensional) {
                push(kind, render_size, attachment_size, layers, false);
            }
        }

        // Multi-sample test cases
        for (kind, layers) in [(ViewKind::TwoD, 1), (ViewKind::TwoDArray, 4)] {
            for (render_size, attachment_size) in size_sets(true) {
                push(kind, render_size, attachment_size, layers, true);
            }
        }
    } else if multi == MultiAttachmentsTestType::DifferentSizes {
        // Single-sample test cases
        for (kind, two_dimensional) in [(ViewKind::OneD, false), (ViewKind::TwoD, true)] {
            for (render_size, attachment_size) in size_sets(two_dimensional) {
                push(kind, render_size, attachment_size, 1, false);
            }
        }

        // Multi-sample test cases
        for (render_size, attachment_size) in size_sets(true) {
            push(ViewKind::TwoD, render_size, attachment_size, 1, true);
        }
    }

    defs
}

/// `createFramebufferAttachmentTests`
pub fn create_framebuffer_attachment_tests(shader_object: bool) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("framebuffer_attachment");

    // Add test cases for attachment strictly sizes larger than the framebuffer
    for case_def in attachment_case_defs(MultiAttachmentsTestType::None) {
        group.add_child(Box::new(FramebufferAttachmentCase {
            name: get_test_case_string(&case_def),
            kind: Kind::Attachment(case_def),
        }) as Box<dyn TestCase>);
    }

    // The shader object construction types only repeat the attachment size cases.
    if shader_object {
        return group;
    }

    // Add tests for the case where there are no color attachments but the fragment shader writes to an image via imageStore().
    group.add_child(Box::new(FramebufferAttachmentCase {
        name: "no_attachments".to_string(),
        kind: Kind::NoAttachments { multisample: false },
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebufferAttachmentCase {
        name: "no_attachments_ms".to_string(),
        kind: Kind::NoAttachments { multisample: true },
    }) as Box<dyn TestCase>);

    // Test render pass with attachment set as unused.
    group.add_child(Box::new(FramebufferAttachmentCase {
        name: "unused_attachment".to_string(),
        kind: Kind::UnusedAttachment,
    }) as Box<dyn TestCase>);

    // Tests with multiple attachments that have different sizes.
    for case_def in attachment_case_defs(MultiAttachmentsTestType::DifferentSizes) {
        group.add_child(Box::new(FramebufferAttachmentCase {
            name: format!("diff_attachments_{}", get_test_case_string(&case_def)),
            kind: Kind::MultiAttachments(case_def),
        }) as Box<dyn TestCase>);
    }

    // Tests with same attachment for input and resolving.
    let resolve_input_same_attachment_case_def = CaseDef {
        image_type: ViewKind::TwoD,
        render_size: [64, 64, 1],
        attachment_size: [64, 64, 1],
        num_layers: 1,
        multisample: true,
        multi_attachments_test_type: MultiAttachmentsTestType::None,
    };
    group.add_child(Box::new(FramebufferAttachmentCase {
        name: "resolve_input_same_attachment".to_string(),
        kind: Kind::InputResolveSameAttachment(resolve_input_same_attachment_case_def),
    }) as Box<dyn TestCase>);

    // Tests with multiple attachments, which some of them are not used in FS.
    for multisample in [false, true] {
        let case_def = CaseDef {
            image_type: ViewKind::TwoD,
            render_size: [64, 64, 1],
            attachment_size: [64, 64, 1],
            num_layers: 1,
            multisample,
            multi_attachments_test_type: MultiAttachmentsTestType::NotExported,
        };
        group.add_child(Box::new(FramebufferAttachmentCase {
            name: format!("multi_attachments_not_exported_{}", get_test_case_string(&case_def)),
            kind: Kind::MultiAttachments(case_def),
        }) as Box<dyn TestCase>);
    }

    group
}

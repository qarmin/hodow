// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleSampleLocationsExtTests.cpp (namespace Draw)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only, without the VK_KHR_fragment_shading_rate
// option and without the VK_KHR_portability_subset events check. `RenderTarget` is a smaller version of upstream's
// (the render pass and framebuffer are built by `bake`, as there). The image logging is dropped, and the unique colour
// counts and the half image comparisons work over the RGBA8 bytes of the read back image.
//
// Two shapes are drawn with two sample patterns (two render passes, two subpasses or the same subpass, with clears of
// several kinds in between), and the resolved image has to show the expected number of distinct colours per half and
// differing halves exactly when the pattern was changed.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtSampleLocationsExtensionDeviceCommands, ExtSampleLocationsExtensionInstanceCommands};

use super::sample_locations_tests::{
    MultisamplePixelGrid, VERIFY_SAMPLE_COUNTS, check_sample_locations_ext, fill_sample_locations_random,
    fill_sample_locations_std, get_sample_locations_properties, samples_string,
};
use crate::generated::shaders::pipeline_multisample_sample_locations::SAMPLE_LOCATIONS_DRAW;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_secondary_command_buffer, end_command_buffer, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const STENCIL_REFERENCE: u32 = 1;
const DEPTH_CLEAR: f32 = 1.0;
const DEPTH_REFERENCE: f32 = 0.5;
const CLEAR_COLOR_0: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const CLEAR_COLOR_1: [f32; 4] = [0.5, 0.25, 0.75, 1.0];
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const NUM_PASSES: usize = 2;
const RENDER_SIZE: (u32, u32) = (64, 32);

const TEST_OPTION_SAME_PATTERN_BIT: u32 = 1 << 0;
const TEST_OPTION_DYNAMIC_STATE_BIT: u32 = 1 << 1;
const TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT: u32 = 1 << 2;
const TEST_OPTION_GENERAL_LAYOUT_BIT: u32 = 1 << 3;
const TEST_OPTION_WAIT_EVENTS_BIT: u32 = 1 << 4;
const TEST_OPTION_STD_SAMPLE_LOCATIONS_BIT: u32 = 1 << 6;

/// `TestDrawIn`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestDrawIn {
    RenderPasses,
    Subpasses,
    SameSubpass,
}

/// `TestClears`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestClears {
    NoClear,
    LoadOpClear,
    CmdClearAttachments,
    CmdClearImage,
}

/// `TestImageAspect`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestImageAspect {
    Color,
    Depth,
    Stencil,
}

#[derive(Clone, Copy)]
struct DrawParams {
    num_samples: vk::SampleCountFlags,
    options: u32,
    draw_in: TestDrawIn,
    clears: TestClears,
    image_aspect: TestImageAspect,
}

impl DrawParams {
    fn use_std_locations(&self) -> bool {
        self.options & TEST_OPTION_STD_SAMPLE_LOCATIONS_BIT != 0
    }

    fn use_depth(&self) -> bool {
        self.image_aspect == TestImageAspect::Depth
    }

    fn use_stencil(&self) -> bool {
        self.image_aspect == TestImageAspect::Stencil
    }

    fn use_same_sample_pattern(&self) -> bool {
        self.options & TEST_OPTION_SAME_PATTERN_BIT != 0
    }

    fn use_dynamic_state(&self) -> bool {
        self.options & TEST_OPTION_DYNAMIC_STATE_BIT != 0
    }

    fn use_secondary_cmd_buffer(&self) -> bool {
        self.options & TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT != 0
    }

    fn use_general_layout(&self) -> bool {
        self.options & TEST_OPTION_GENERAL_LAYOUT_BIT != 0
    }

    fn use_wait_events(&self) -> bool {
        self.options & TEST_OPTION_WAIT_EVENTS_BIT != 0
    }

    fn is_msaa(&self) -> bool {
        self.num_samples != vk::SampleCountFlags::_1
    }
}

fn aspect_string(aspect: TestImageAspect) -> &'static str {
    match aspect {
        TestImageAspect::Color => "color",
        TestImageAspect::Depth => "depth",
        TestImageAspect::Stencil => "stencil",
    }
}

fn draw_in_string(draw_in: TestDrawIn) -> &'static str {
    match draw_in {
        TestDrawIn::RenderPasses => "separate_renderpass",
        TestDrawIn::Subpasses => "separate_subpass",
        TestDrawIn::SameSubpass => "same_subpass",
    }
}

fn clears_string(clears: TestClears) -> &'static str {
    match clears {
        TestClears::NoClear => "no_clear",
        TestClears::LoadOpClear => "load_op_clear",
        TestClears::CmdClearAttachments => "clear_attachments",
        TestClears::CmdClearImage => "clear_image",
    }
}

/// `getTestOptionFlagsString`
fn options_string(flags: u32) -> String {
    let mut parts = Vec::new();
    if flags & TEST_OPTION_SAME_PATTERN_BIT != 0 {
        parts.push("same_pattern");
    }
    if flags & TEST_OPTION_DYNAMIC_STATE_BIT != 0 {
        parts.push("dynamic");
    }
    if flags & TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT != 0 {
        parts.push("secondary_cmd_buf");
    }
    if flags & TEST_OPTION_GENERAL_LAYOUT_BIT != 0 {
        parts.push("general_layout");
    }
    if flags & TEST_OPTION_WAIT_EVENTS_BIT != 0 {
        parts.push("event");
    }
    parts.join("_")
}

/// `PositionColor`, as the vertex the pipelines read.
type PositionColor = [[f32; 4]; 2];

/// `genVerticesFullQuad`
fn gen_vertices_full_quad(color: [f32; 4], z: f32) -> Vec<PositionColor> {
    vec![
        [[1.0, -1.0, z, 1.0], color],
        [[-1.0, -1.0, z, 1.0], color],
        [[-1.0, 1.0, z, 1.0], color],
        [[-1.0, 1.0, z, 1.0], color],
        [[1.0, 1.0, z, 1.0], color],
        [[1.0, -1.0, z, 1.0], color],
    ]
}

/// `genVerticesShapes`: some abstract geometry with angled edges, to make multisampling visible.
fn gen_vertices_shapes(color: [f32; 4], z: f32) -> Vec<PositionColor> {
    let mut vertices = Vec::new();

    let num_steps = 16.0f32;
    let angle_step = (2.0 * std::f32::consts::PI) / num_steps;

    let mut a = 0.0f32;
    while a <= 2.0 * std::f32::consts::PI {
        vertices.push([[1.0 * a.cos(), 1.0 * a.sin(), z, 1.0], color]);
        vertices.push([
            [0.1 * (a - angle_step).cos(), 0.1 * (a - angle_step).sin(), z, 1.0],
            color,
        ]);
        vertices.push([
            [0.1 * (a + angle_step).cos(), 0.1 * (a + angle_step).sin(), z, 1.0],
            color,
        ]);
        a += angle_step;
    }

    vertices
}

/// `stencilOpStateDrawOnce`: only allows drawing over the cleared area of an attachment.
fn stencil_op_state_draw_once() -> vk::StencilOpState {
    vk::StencilOpState {
        fail_op: vk::StencilOp::KEEP,
        pass_op: vk::StencilOp::ZERO,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::EQUAL,
        compare_mask: !0,
        write_mask: !0,
        reference: STENCIL_REFERENCE,
    }
}

fn clear_depth_stencil_value() -> vk::ClearValue {
    vk::ClearValue {
        depth_stencil: vk::ClearDepthStencilValue {
            depth: DEPTH_CLEAR,
            stencil: STENCIL_REFERENCE,
        },
    }
}

#[derive(Default)]
struct SubpassRefs {
    color: Vec<vk::AttachmentReference>,
    resolve: Vec<vk::AttachmentReference>,
    depth_stencil: Vec<vk::AttachmentReference>,
}

/// `RenderTarget`: a render pass, framebuffer and related resources built from the attachments added to it.
struct RenderTarget<'a> {
    device: &'a Device,
    views: Vec<vk::ImageView>,
    descriptions: Vec<vk::AttachmentDescription>,
    clear_values: Vec<vk::ClearValue>,
    attachment_sample_locations: Vec<vk::AttachmentSampleLocationsEXT>,
    subpass_sample_locations: Vec<vk::SubpassSampleLocationsEXT>,
    subpasses: Vec<SubpassRefs>,
    render_pass: Option<Unique<'a, vk::RenderPass>>,
    framebuffer: Option<Unique<'a, vk::Framebuffer>>,
}

impl<'a> RenderTarget<'a> {
    fn new(device: &'a Device) -> Self {
        Self {
            device,
            views: Vec::new(),
            descriptions: Vec::new(),
            clear_values: Vec::new(),
            attachment_sample_locations: Vec::new(),
            subpass_sample_locations: Vec::new(),
            subpasses: vec![SubpassRefs::default()],
            render_pass: None,
            framebuffer: None,
        }
    }

    /// Returns an attachment index that is used to reference this attachment later.
    #[allow(clippy::too_many_arguments)]
    fn add_attachment(
        &mut self,
        image_view: vk::ImageView,
        format: vk::Format,
        num_samples: vk::SampleCountFlags,
        load_op: vk::AttachmentLoadOp,
        store_op: vk::AttachmentStoreOp,
        stencil_load_op: vk::AttachmentLoadOp,
        stencil_store_op: vk::AttachmentStoreOp,
        initial_layout: vk::ImageLayout,
        final_layout: vk::ImageLayout,
        clear_value: vk::ClearValue,
        initial_sample_locations: Option<&vk::SampleLocationsInfoEXT>,
    ) -> u32 {
        let index = self.descriptions.len() as u32;

        self.views.push(image_view);
        self.descriptions.push(vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format,
            samples: num_samples,
            load_op,
            store_op,
            stencil_load_op,
            stencil_store_op,
            initial_layout,
            final_layout,
        });
        self.clear_values.push(clear_value); // always add, even if unused

        if let Some(locations) = initial_sample_locations {
            self.attachment_sample_locations.push(vk::AttachmentSampleLocationsEXT {
                attachment_index: index,
                sample_locations_info: *locations,
            });
        }

        index
    }

    fn add_subpass_sample_locations(&mut self, sample_locations: Option<&vk::SampleLocationsInfoEXT>) {
        if let Some(locations) = sample_locations {
            self.subpass_sample_locations.push(vk::SubpassSampleLocationsEXT {
                subpass_index: (self.subpasses.len() - 1) as u32,
                sample_locations_info: *locations,
            });
        }
    }

    fn add_subpass_color_attachment(
        &mut self,
        attachment_index: u32,
        subpass_layout: vk::ImageLayout,
        sample_locations: Option<&vk::SampleLocationsInfoEXT>,
    ) {
        let subpass = self.subpasses.last_mut().expect("a subpass");
        subpass.color.push(vk::AttachmentReference {
            attachment: attachment_index,
            layout: subpass_layout,
        });
        subpass.resolve.push(vk::AttachmentReference {
            attachment: vk::ATTACHMENT_UNUSED,
            layout: vk::ImageLayout::UNDEFINED,
        });
        self.add_subpass_sample_locations(sample_locations);
    }

    fn add_subpass_color_attachment_with_resolve(
        &mut self,
        color_index: u32,
        color_layout: vk::ImageLayout,
        resolve_index: u32,
        resolve_layout: vk::ImageLayout,
    ) {
        let subpass = self.subpasses.last_mut().expect("a subpass");
        subpass.color.push(vk::AttachmentReference {
            attachment: color_index,
            layout: color_layout,
        });
        subpass.resolve.push(vk::AttachmentReference {
            attachment: resolve_index,
            layout: resolve_layout,
        });
    }

    fn add_subpass_depth_stencil_attachment(
        &mut self,
        attachment_index: u32,
        subpass_layout: vk::ImageLayout,
        sample_locations: Option<&vk::SampleLocationsInfoEXT>,
    ) {
        self.subpasses
            .last_mut()
            .expect("a subpass")
            .depth_stencil
            .push(vk::AttachmentReference {
                attachment: attachment_index,
                layout: subpass_layout,
            });
        self.add_subpass_sample_locations(sample_locations);
    }

    fn next_subpass_definition(&mut self) {
        self.subpasses.push(SubpassRefs::default());
    }

    /// Creates a render pass and framebuffer from the attachments provided.
    fn bake(&mut self, framebuffer_size: (u32, u32)) -> Result<(), TestError> {
        let device = self.device;
        let num_subpasses = self.subpasses.len();

        let mut subpass_descriptions = Vec::new();
        let mut subpass_dependencies = Vec::new();
        for (subpass_ndx, sd) in self.subpasses.iter().enumerate() {
            let mut description = vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&sd.color);
            if !sd.resolve.is_empty() {
                description = description.resolve_attachments(&sd.resolve);
            }
            if let Some(depth_stencil) = sd.depth_stencil.first() {
                description = description.depth_stencil_attachment(depth_stencil);
            }
            subpass_descriptions.push(description.build());

            // Add a very coarse dependency enforcing sequential ordering of subpasses
            if subpass_ndx > 0 {
                let access_any = vk::AccessFlags::COLOR_ATTACHMENT_READ
                    | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                    | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
                    | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
                    | vk::AccessFlags::INPUT_ATTACHMENT_READ;
                subpass_dependencies.push(vk::SubpassDependency {
                    src_subpass: subpass_ndx as u32 - 1,
                    dst_subpass: subpass_ndx as u32,
                    src_stage_mask: vk::PipelineStageFlags::ALL_GRAPHICS,
                    dst_stage_mask: vk::PipelineStageFlags::ALL_GRAPHICS,
                    src_access_mask: access_any,
                    dst_access_mask: access_any,
                    dependency_flags: vk::DependencyFlags::empty(),
                });
            }
        }
        // add a final dependency to synchronize results for the copy commands that will follow the renderpass
        subpass_dependencies.push(vk::SubpassDependency {
            src_subpass: num_subpasses as u32 - 1,
            dst_subpass: vk::SUBPASS_EXTERNAL,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            dst_stage_mask: vk::PipelineStageFlags::TRANSFER,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::TRANSFER_READ,
            dependency_flags: vk::DependencyFlags::empty(),
        });

        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&self.descriptions)
            .subpasses(&subpass_descriptions)
            .dependencies(&subpass_dependencies);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let framebuffer_info = vk::FramebufferCreateInfo::builder()
            .render_pass(*render_pass)
            .attachments(&self.views)
            .width(framebuffer_size.0)
            .height(framebuffer_size.1)
            .layers(1);
        let framebuffer = Unique::new(
            device,
            unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
        );

        self.render_pass = Some(render_pass);
        self.framebuffer = Some(framebuffer);
        Ok(())
    }

    fn render_pass(&self) -> vk::RenderPass {
        **self.render_pass.as_ref().expect("a baked render target")
    }

    fn framebuffer(&self) -> vk::Framebuffer {
        **self.framebuffer.as_ref().expect("a baked render target")
    }

    fn record_begin_render_pass(
        &self,
        cmd: vk::CommandBuffer,
        render_area: vk::Rect2D,
        contents: vk::SubpassContents,
        use_std_locations: bool,
    ) {
        let mut sample_locations_begin_info = vk::RenderPassSampleLocationsBeginInfoEXT::builder()
            .attachment_initial_sample_locations(&self.attachment_sample_locations)
            .post_subpass_sample_locations(&self.subpass_sample_locations);
        let mut begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(self.render_pass())
            .framebuffer(self.framebuffer())
            .render_area(render_area)
            .clear_values(&self.clear_values);
        if !use_std_locations {
            begin_info = begin_info.push_next(&mut sample_locations_begin_info);
        }
        unsafe { self.device.cmd_begin_render_pass(cmd, &begin_info, contents) };
    }

    fn next_subpass(&self, cmd: vk::CommandBuffer, contents: vk::SubpassContents) {
        unsafe { self.device.cmd_next_subpass(cmd, contents) };
    }

    fn end_render_pass(&self, cmd: vk::CommandBuffer) {
        unsafe { self.device.cmd_end_render_pass(cmd) };
    }
}

/// `recordImageBarrier`
#[allow(clippy::too_many_arguments)]
fn record_image_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    aspect: vk::ImageAspectFlags,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    sample_locations_info: Option<&vk::SampleLocationsInfoEXT>,
) {
    let mut sample_locations = sample_locations_info.copied().unwrap_or_default();
    let mut barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(src_access_mask)
        .dst_access_mask(dst_access_mask)
        .old_layout(old_layout)
        .new_layout(new_layout)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(make_image_subresource_range(aspect, 0, 1, 0, 1));
    if sample_locations_info.is_some() {
        barrier = barrier.push_next(&mut sample_locations);
    }
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage_mask,
            dst_stage_mask,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier.build()],
        );
    }
}

/// `recordWaitEventWithImage`
#[allow(clippy::too_many_arguments)]
fn record_wait_event_with_image(
    device: &Device,
    cmd: vk::CommandBuffer,
    event: vk::Event,
    image: vk::Image,
    aspect: vk::ImageAspectFlags,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    sample_locations_info: Option<&vk::SampleLocationsInfoEXT>,
) {
    let mut sample_locations = sample_locations_info.copied().unwrap_or_default();
    let mut barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(src_access_mask)
        .dst_access_mask(dst_access_mask)
        .old_layout(old_layout)
        .new_layout(new_layout)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(make_image_subresource_range(aspect, 0, 1, 0, 1));
    if sample_locations_info.is_some() {
        barrier = barrier.push_next(&mut sample_locations);
    }
    unsafe {
        device.cmd_wait_events(
            cmd,
            &[event],
            src_stage_mask,
            dst_stage_mask,
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier.build()],
        );
    }
}

/// `recordCopyImageToBuffer`
fn record_copy_image_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image_size: (u32, u32),
    src_image: vk::Image,
    dst_buffer: vk::Buffer,
    layout: vk::ImageLayout,
) {
    // Image read barrier
    let barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
        .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
        .old_layout(layout)
        .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(src_image)
        .subresource_range(make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1))
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }

    // Color/Resolve image -> host buffer
    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: image_size.0,
            height: image_size.1,
            depth: 1,
        },
    };
    unsafe {
        device.cmd_copy_image_to_buffer(
            cmd,
            src_image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            dst_buffer,
            &[region],
        )
    };

    // Buffer write barrier
    let buffer_barrier = vk::BufferMemoryBarrier {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
        dst_access_mask: vk::AccessFlags::HOST_READ,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer: dst_buffer,
        offset: 0,
        size: vk::WHOLE_SIZE,
    };
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

/// `recordClearAttachments`
fn record_clear_attachments(
    device: &Device,
    cmd: vk::CommandBuffer,
    color_attachment: u32,
    color_clear_value: vk::ClearValue,
    depth_stencil_aspect: vk::ImageAspectFlags,
    depth_stencil_clear_value: vk::ClearValue,
    clear_rect: vk::Rect2D,
) {
    let mut attachments = vec![vk::ClearAttachment {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        color_attachment,
        clear_value: color_clear_value,
    }];

    if depth_stencil_aspect.intersects(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL) {
        attachments.push(vk::ClearAttachment {
            aspect_mask: depth_stencil_aspect,
            color_attachment: vk::ATTACHMENT_UNUSED,
            clear_value: depth_stencil_clear_value,
        });
    }

    let rect = vk::ClearRect {
        rect: clear_rect,
        base_array_layer: 0,
        layer_count: 1,
    };
    unsafe { device.cmd_clear_attachments(cmd, &attachments, &[rect]) };
}

fn make_event(device: &Device) -> Result<Unique<'_, vk::Event>, TestError> {
    let info = vk::EventCreateInfo::builder();
    Ok(Unique::new(
        device,
        unsafe { device.create_event(&info, None) }.vk_check("vkCreateEvent")?,
    ))
}

fn make_image<'a>(
    context: &'a Context<'a>,
    flags: vk::ImageCreateFlags,
    format: vk::Format,
    size: (u32, u32),
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .flags(flags)
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
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// `findSupportedDepthStencilFormat`
fn find_supported_depth_stencil_format(context: &Context<'_>, use_depth: bool, use_stencil: bool) -> vk::Format {
    if use_depth && !use_stencil {
        return vk::Format::D16_UNORM; // must be supported
    }

    // One of these formats must be supported.
    for format in [vk::Format::D24_UNORM_S8_UINT, vk::Format::D32_SFLOAT_S8_UINT] {
        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return format;
        }
    }

    vk::Format::UNDEFINED
}

fn get_image_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::D16_UNORM | vk::Format::D32_SFLOAT | vk::Format::X8_D24_UNORM_PACK32 => vk::ImageAspectFlags::DEPTH,
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        _ => vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
    }
}

/// The pixels of a `width` x `height` region of an RGBA8 image `image_width` pixels wide.
fn region_pixels(bytes: &[u8], image_width: u32, x0: u32, width: u32, height: u32) -> Vec<[u8; 4]> {
    let mut pixels = Vec::with_capacity((width * height) as usize);
    for y in 0..height {
        for x in x0..x0 + width {
            let offset = ((y * image_width + x) * 4) as usize;
            pixels.push([bytes[offset], bytes[offset + 1], bytes[offset + 2], bytes[offset + 3]]);
        }
    }
    pixels
}

/// `countUniqueColors`
fn count_unique_colors(pixels: &[[u8; 4]]) -> usize {
    let mut colors: Vec<[u8; 4]> = Vec::new();
    for color in pixels {
        let found = colors
            .iter()
            .any(|existing| color.iter().zip(existing).all(|(&a, &b)| a.abs_diff(b) <= 1));
        if !found {
            colors.push(*color);
        }
    }
    colors.len()
}

/// `intThresholdCompare`: silent, no logging
fn int_threshold_compare(reference: &[[u8; 4]], result: &[[u8; 4]], threshold: u8) -> bool {
    reference
        .iter()
        .zip(result)
        .all(|(a, b)| a.iter().zip(b).all(|(&x, &y)| x.abs_diff(y) <= threshold))
}

fn submit_buffers_and_wait(
    device: &Device,
    queue: vk::Queue,
    cmd_buffers: &[vk::CommandBuffer],
) -> Result<(), TestError> {
    let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
    let result = (|| -> Result<(), TestError> {
        let submit_info = vk::SubmitInfo::builder().command_buffers(cmd_buffers);
        unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;
        unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        Ok(())
    })();
    unsafe { device.destroy_fence(fence, None) };
    result
}

/// `Draw::DrawTest`
struct DrawTest<'a> {
    context: &'a Context<'a>,
    device: &'a Device,
    params: DrawParams,
    pixel_grids: Vec<MultisamplePixelGrid>,
    num_vertices: u32,
    vertex_buffer: BufferWithMemory<'a>,
    color_image: ImageWithMemory<'a>,
    color_view: Unique<'a, vk::ImageView>,
    resolve_image: ImageWithMemory<'a>,
    resolve_view: Unique<'a, vk::ImageView>,
    depth_stencil_format: vk::Format,
    depth_stencil_aspect: vk::ImageAspectFlags,
    depth_stencil: Option<(ImageWithMemory<'a>, Unique<'a, vk::ImageView>)>,
    color_buffer: BufferWithMemory<'a>,
}

impl<'a> DrawTest<'a> {
    fn depth_stencil_image(&self) -> vk::Image {
        self.depth_stencil.as_ref().expect("a depth/stencil image").0.get()
    }

    fn depth_stencil_view(&self) -> vk::ImageView {
        *self.depth_stencil.as_ref().expect("a depth/stencil image").1
    }

    fn uses_depth_or_stencil(&self) -> bool {
        self.params.use_depth() || self.params.use_stencil()
    }

    fn sample_locations_info(&self) -> [vk::SampleLocationsInfoEXT; NUM_PASSES] {
        [
            self.pixel_grids[0].locations_info(),
            self.pixel_grids[if self.params.use_same_sample_pattern() { 0 } else { 1 }].locations_info(),
        ]
    }

    /// The pipeline of `preparePipelineWrapper` with the vertex input of `VERTEX_INPUT_VEC4_VEC4` over the draw shaders.
    fn make_pipeline(
        &self,
        layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
        subpass: u32,
        sample_locations_info: &vk::SampleLocationsInfoEXT,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.device;
        let binaries = self.context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(RENDER_SIZE.0, RENDER_SIZE.1);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
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
        state.samples = self.params.num_samples;
        state.sample_shading = true;
        state.min_sample_shading = 1.0;
        state.subpass = subpass;
        let stencil_op_state = stencil_op_state_draw_once();
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(self.params.use_depth())
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(self.params.use_stencil())
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0)
            .build();
        if self.params.use_dynamic_state() {
            debug_assert!(!self.params.use_std_locations());
            state.dynamic_states = vec![vk::DynamicState::SAMPLE_LOCATIONS_EXT];
            state.sample_locations = Some((true, vk::SampleLocationsInfoEXT::default()));
        } else if !self.params.use_std_locations() {
            state.sample_locations = Some((true, *sample_locations_info));
        }

        create_draw_pipeline(
            device,
            layout,
            render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )
    }

    /// Records the contents of the first pass; the left shape only, or both without a clear.
    fn record_first_pass_contents(
        &self,
        cmd: vk::CommandBuffer,
        pipeline: vk::Pipeline,
        sample_locations_info: &vk::SampleLocationsInfoEXT,
    ) {
        let device = self.device;
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[self.vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline);

            if self.params.use_dynamic_state() {
                device.cmd_set_sample_locations_ext(cmd, sample_locations_info);
            }

            if self.params.clears == TestClears::NoClear {
                device.cmd_draw(cmd, self.num_vertices, 1, 0, 0); // left shape only
            } else {
                device.cmd_draw(cmd, self.num_vertices, NUM_PASSES as u32, 0, 0); // both shapes
            }
        }
    }

    fn record_second_pass_contents(
        &self,
        cmd: vk::CommandBuffer,
        pipeline: vk::Pipeline,
        sample_locations_info: &vk::SampleLocationsInfoEXT,
        clear_color: vk::ClearValue,
        clear_depth_stencil: vk::ClearValue,
        clear_rect: vk::Rect2D,
    ) {
        let device = self.device;
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[self.vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline);
        }

        if self.params.clears == TestClears::CmdClearAttachments {
            record_clear_attachments(
                device,
                cmd,
                0,
                clear_color,
                self.depth_stencil_aspect,
                clear_depth_stencil,
                clear_rect,
            );
        }

        unsafe {
            if self.params.use_dynamic_state() {
                device.cmd_set_sample_locations_ext(cmd, sample_locations_info);
            }

            // Draw the right shape only
            device.cmd_draw(cmd, self.num_vertices, 1, 0, 1);
        }
    }

    fn source_image(&self) -> vk::Image {
        if self.params.is_msaa() {
            self.resolve_image.get()
        } else {
            self.color_image.get()
        }
    }

    fn read_color_buffer(&self) -> Result<Vec<u8>, TestError> {
        invalidate_alloc(self.device, self.color_buffer.get_allocation())?;
        let size = (RENDER_SIZE.0 * RENDER_SIZE.1 * 4) as usize;
        Ok(
            unsafe { std::slice::from_raw_parts(self.color_buffer.get_allocation().get_host_ptr().cast_const(), size) }
                .to_vec(),
        )
    }

    /// The colour and the depth/stencil attachments every first render pass or subpass starts with.
    fn add_color_attachment(
        &self,
        rt: &mut RenderTarget<'a>,
        load_op: vk::AttachmentLoadOp,
        initial_layout: vk::ImageLayout,
        final_layout: vk::ImageLayout,
        clear_value: vk::ClearValue,
    ) -> u32 {
        rt.add_attachment(
            *self.color_view,
            COLOR_FORMAT,
            self.params.num_samples,
            load_op,
            vk::AttachmentStoreOp::STORE,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::DONT_CARE,
            initial_layout,
            final_layout,
            clear_value,
            None,
        )
    }

    fn add_resolve_attachment(&self, rt: &mut RenderTarget<'a>, final_layout: vk::ImageLayout) -> u32 {
        rt.add_attachment(
            *self.resolve_view,
            COLOR_FORMAT,
            vk::SampleCountFlags::_1,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::STORE,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::ImageLayout::UNDEFINED,
            final_layout,
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
            None,
        )
    }

    #[allow(clippy::too_many_arguments)]
    fn add_depth_stencil_attachment(
        &self,
        rt: &mut RenderTarget<'a>,
        load_op: vk::AttachmentLoadOp,
        initial_layout: vk::ImageLayout,
        final_layout: vk::ImageLayout,
        initial_sample_locations: Option<&vk::SampleLocationsInfoEXT>,
    ) -> u32 {
        rt.add_attachment(
            self.depth_stencil_view(),
            self.depth_stencil_format,
            self.params.num_samples,
            load_op,
            vk::AttachmentStoreOp::STORE,
            load_op,
            vk::AttachmentStoreOp::STORE,
            initial_layout,
            final_layout,
            clear_depth_stencil_value(),
            initial_sample_locations,
        )
    }

    /// `drawPatternChangeReference`: draw the second pass image, but with sample pattern from the first pass.
    fn draw_pattern_change_reference(&self) -> Result<(), TestError> {
        let device = self.device;
        let render_area = rect_2d(RENDER_SIZE.0, RENDER_SIZE.1);
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let sample_locations_info = self.pixel_grids[0].locations_info();
        let clear_color_0 = if self.params.clears == TestClears::NoClear {
            clear_value_color(CLEAR_COLOR_0)
        } else {
            clear_value_color(CLEAR_COLOR_1)
        };
        let use_std_locations = self.params.use_std_locations();
        let locations_ptr = if use_std_locations {
            None
        } else {
            Some(&sample_locations_info)
        };

        let mut rt = RenderTarget::new(device);
        self.add_color_attachment(
            &mut rt,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            clear_color_0,
        );
        self.add_resolve_attachment(&mut rt, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);

        if self.params.is_msaa() {
            rt.add_subpass_color_attachment_with_resolve(
                0,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                1,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            );
        } else {
            rt.add_subpass_color_attachment(0, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, None);
        }

        if self.uses_depth_or_stencil() {
            self.add_depth_stencil_attachment(
                &mut rt,
                vk::AttachmentLoadOp::CLEAR,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                locations_ptr,
            );
            rt.add_subpass_depth_stencil_attachment(
                2,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                locations_ptr,
            );
        }

        rt.bake(RENDER_SIZE)?;

        let pipeline = self.make_pipeline(*pipeline_layout, rt.render_pass(), 0, &sample_locations_info)?;

        let cmd_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let mut secondary_cmd_buffer: Option<UniqueCommandBuffer<'_>> = None;

        begin_command_buffer(device, *cmd_buffer)?;
        let contents = if self.params.use_secondary_cmd_buffer() {
            vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
        } else {
            vk::SubpassContents::INLINE
        };
        rt.record_begin_render_pass(*cmd_buffer, render_area, contents, use_std_locations);

        // For maximum consistency also use a secondary command buffer, if the two-pass path uses it
        let mut current_cmd_buffer = *cmd_buffer;
        if self.params.use_secondary_cmd_buffer() {
            let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            current_cmd_buffer = *secondary;
            begin_secondary_command_buffer(device, current_cmd_buffer, rt.render_pass(), 0, rt.framebuffer())?;
            secondary_cmd_buffer = Some(secondary);
        }

        unsafe {
            device.cmd_bind_vertex_buffers(current_cmd_buffer, 0, &[self.vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(current_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

            // Draw the right shape only
            device.cmd_draw(current_cmd_buffer, self.num_vertices, 1, 0, 1);
        }

        if let Some(secondary) = &secondary_cmd_buffer {
            end_command_buffer(device, current_cmd_buffer)?;
            unsafe { device.cmd_execute_commands(*cmd_buffer, &[**secondary]) };
        }

        rt.end_render_pass(*cmd_buffer);

        // Color/Resolve image -> host buffer
        record_copy_image_to_buffer(
            device,
            *cmd_buffer,
            RENDER_SIZE,
            self.source_image(),
            self.color_buffer.get(),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), *cmd_buffer)
    }

    /// The layouts the second render pass or subpass expects: `(colorLayout1, depthStencilLayout1)`.
    fn second_pass_layouts(&self) -> (vk::ImageLayout, vk::ImageLayout) {
        let color_layout = if self.params.use_general_layout() && !self.uses_depth_or_stencil() {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };
        let depth_stencil_layout = if self.params.use_general_layout() && self.uses_depth_or_stencil() {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
        };
        (color_layout, depth_stencil_layout)
    }

    /// `drawRenderPasses`: draw two shapes with distinct sample patterns, each in its own render pass.
    fn draw_render_passes(&self) -> Result<(), TestError> {
        let device = self.device;
        let render_area = rect_2d(RENDER_SIZE.0, RENDER_SIZE.1);
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let clear_color_0 = clear_value_color(CLEAR_COLOR_0);
        let clear_color_1 = clear_value_color(CLEAR_COLOR_1);
        let clear_depth_stencil_0 = clear_depth_stencil_value();
        let sample_locations_info = self.sample_locations_info();
        let use_std_locations = self.params.use_std_locations();
        let locations_ptr = |index: usize| {
            if use_std_locations {
                None
            } else {
                Some(&sample_locations_info[index])
            }
        };
        let cmd_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;
        let cmd_buffers = [
            allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?,
            allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?,
        ];
        let (color_layout_1, depth_stencil_layout_1) = self.second_pass_layouts();

        // First render pass - no resolves
        let mut rt0 = RenderTarget::new(device);
        {
            self.add_color_attachment(
                &mut rt0,
                vk::AttachmentLoadOp::CLEAR,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                clear_color_0,
            );
            rt0.add_subpass_color_attachment(0, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, None);

            if self.uses_depth_or_stencil() {
                self.add_depth_stencil_attachment(
                    &mut rt0,
                    vk::AttachmentLoadOp::CLEAR,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    locations_ptr(0),
                );
                rt0.add_subpass_depth_stencil_attachment(
                    1,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    locations_ptr(0),
                );
            }

            rt0.bake(RENDER_SIZE)?;
        }

        // Second render pass
        let mut rt1 = RenderTarget::new(device);
        {
            let load_op = if self.params.clears == TestClears::LoadOpClear {
                vk::AttachmentLoadOp::CLEAR
            } else {
                vk::AttachmentLoadOp::LOAD
            };

            self.add_color_attachment(&mut rt1, load_op, color_layout_1, color_layout_1, clear_color_1);
            self.add_resolve_attachment(&mut rt1, color_layout_1);

            if self.params.is_msaa() {
                rt1.add_subpass_color_attachment_with_resolve(0, color_layout_1, 1, color_layout_1);
            } else {
                rt1.add_subpass_color_attachment(0, color_layout_1, None);
            }

            if self.uses_depth_or_stencil() {
                self.add_depth_stencil_attachment(
                    &mut rt1,
                    load_op,
                    depth_stencil_layout_1,
                    depth_stencil_layout_1,
                    locations_ptr(1),
                );
                rt1.add_subpass_depth_stencil_attachment(2, depth_stencil_layout_1, locations_ptr(1));
            }

            rt1.bake(RENDER_SIZE)?;
        }

        // Pipelines
        let pipelines = [
            self.make_pipeline(*pipeline_layout, rt0.render_pass(), 0, &sample_locations_info[0])?,
            self.make_pipeline(*pipeline_layout, rt1.render_pass(), 0, &sample_locations_info[1])?,
        ];

        // Record secondary command buffers
        let mut secondary_cmd_buffers: Vec<UniqueCommandBuffer<'_>> = Vec::new();
        if self.params.use_secondary_cmd_buffer() {
            let secondary0 = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let secondary1 = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

            // First render pass contents
            begin_secondary_command_buffer(device, *secondary0, rt0.render_pass(), 0, rt0.framebuffer())?;
            self.record_first_pass_contents(*secondary0, *pipelines[0], &sample_locations_info[0]);
            end_command_buffer(device, *secondary0)?;

            // Second render pass contents
            begin_secondary_command_buffer(device, *secondary1, rt1.render_pass(), 0, rt1.framebuffer())?;
            self.record_second_pass_contents(
                *secondary1,
                *pipelines[1],
                &sample_locations_info[1],
                clear_color_1,
                clear_depth_stencil_0,
                render_area,
            );
            end_command_buffer(device, *secondary1)?;

            secondary_cmd_buffers.push(secondary0);
            secondary_cmd_buffers.push(secondary1);
        }

        // Record primary command buffers
        let mut current_cmd_buffer = *cmd_buffers[0];
        begin_command_buffer(device, current_cmd_buffer)?;

        // First render pass
        if self.params.use_secondary_cmd_buffer() {
            rt0.record_begin_render_pass(
                current_cmd_buffer,
                render_area,
                vk::SubpassContents::SECONDARY_COMMAND_BUFFERS,
                use_std_locations,
            );
            unsafe { device.cmd_execute_commands(current_cmd_buffer, &[*secondary_cmd_buffers[0]]) };
            rt0.end_render_pass(current_cmd_buffer);
        } else {
            rt0.record_begin_render_pass(
                current_cmd_buffer,
                render_area,
                vk::SubpassContents::INLINE,
                use_std_locations,
            );
            self.record_first_pass_contents(current_cmd_buffer, *pipelines[0], &sample_locations_info[0]);
            rt0.end_render_pass(current_cmd_buffer);
        }

        end_command_buffer(device, current_cmd_buffer)?;

        // Record the second primary command buffer
        current_cmd_buffer = *cmd_buffers[1];
        begin_command_buffer(device, current_cmd_buffer)?;

        let color_aspect = vk::ImageAspectFlags::COLOR;
        let mut events: Vec<Unique<'_, vk::Event>> = Vec::new(); // color and depth/stencil
        if self.params.clears == TestClears::CmdClearImage {
            {
                let final_layout = if self.params.use_wait_events() {
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
                } else {
                    color_layout_1
                };

                record_image_barrier(
                    device,
                    current_cmd_buffer,
                    self.color_image.get(),
                    color_aspect,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    None,
                );

                let subresource_range = make_image_subresource_range(color_aspect, 0, 1, 0, 1);
                unsafe {
                    device.cmd_clear_color_image(
                        current_cmd_buffer,
                        self.color_image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_color_1.color,
                        &[subresource_range],
                    )
                };

                record_image_barrier(
                    device,
                    current_cmd_buffer,
                    self.color_image.get(),
                    color_aspect,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    final_layout,
                    None,
                );
            }

            if self.uses_depth_or_stencil() {
                let final_layout = if self.params.use_wait_events() {
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
                } else {
                    depth_stencil_layout_1
                };
                let p_sample_locations = locations_ptr(0);

                record_image_barrier(
                    device,
                    current_cmd_buffer,
                    self.depth_stencil_image(),
                    get_image_aspect_flags(self.depth_stencil_format),
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    p_sample_locations,
                );

                let subresource_range = make_image_subresource_range(self.depth_stencil_aspect, 0, 1, 0, 1);
                unsafe {
                    device.cmd_clear_depth_stencil_image(
                        current_cmd_buffer,
                        self.depth_stencil_image(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_depth_stencil_0.depth_stencil,
                        &[subresource_range],
                    )
                };

                record_image_barrier(
                    device,
                    current_cmd_buffer,
                    self.depth_stencil_image(),
                    get_image_aspect_flags(self.depth_stencil_format),
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    final_layout,
                    p_sample_locations,
                );
            }
        } else if !self.params.use_wait_events() {
            // Barrier between the render passes
            record_image_barrier(
                device,
                current_cmd_buffer,
                self.color_image.get(),
                color_aspect,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_layout_1,
                None,
            );

            if self.uses_depth_or_stencil() {
                record_image_barrier(
                    device,
                    current_cmd_buffer,
                    self.depth_stencil_image(),
                    get_image_aspect_flags(self.depth_stencil_format),
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    depth_stencil_layout_1,
                    None,
                );
            }
        }

        if self.params.use_wait_events() {
            // Use events to sync both render passes
            let color_event = make_event(device)?;
            unsafe {
                device.cmd_set_event(
                    current_cmd_buffer,
                    *color_event,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                )
            };

            record_wait_event_with_image(
                device,
                current_cmd_buffer,
                *color_event,
                self.color_image.get(),
                color_aspect,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_layout_1,
                None,
            );
            events.push(color_event);

            if self.uses_depth_or_stencil() {
                let depth_stencil_event = make_event(device)?;
                unsafe {
                    device.cmd_set_event(
                        current_cmd_buffer,
                        *depth_stencil_event,
                        vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    )
                };

                record_wait_event_with_image(
                    device,
                    current_cmd_buffer,
                    *depth_stencil_event,
                    self.depth_stencil_image(),
                    get_image_aspect_flags(self.depth_stencil_format),
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    depth_stencil_layout_1,
                    locations_ptr(0),
                );
                events.push(depth_stencil_event);
            }
        }

        // Second render pass
        if self.params.use_secondary_cmd_buffer() {
            rt1.record_begin_render_pass(
                current_cmd_buffer,
                render_area,
                vk::SubpassContents::SECONDARY_COMMAND_BUFFERS,
                use_std_locations,
            );
            unsafe { device.cmd_execute_commands(current_cmd_buffer, &[*secondary_cmd_buffers[1]]) };
            rt1.end_render_pass(current_cmd_buffer);
        } else {
            rt1.record_begin_render_pass(
                current_cmd_buffer,
                render_area,
                vk::SubpassContents::INLINE,
                use_std_locations,
            );
            self.record_second_pass_contents(
                current_cmd_buffer,
                *pipelines[1],
                &sample_locations_info[1],
                clear_color_1,
                clear_depth_stencil_0,
                render_area,
            );
            rt1.end_render_pass(current_cmd_buffer);
        }

        // Color/Resolve image -> host buffer
        record_copy_image_to_buffer(
            device,
            current_cmd_buffer,
            RENDER_SIZE,
            self.source_image(),
            self.color_buffer.get(),
            color_layout_1,
        );

        end_command_buffer(device, current_cmd_buffer)?;

        // Submit work
        submit_buffers_and_wait(
            device,
            self.context.get_universal_queue(),
            &[*cmd_buffers[0], *cmd_buffers[1]],
        )
    }

    /// The colour attachments, resolve attachment and subpass layout both `drawSubpasses` and `drawSameSubpass` start from.
    fn add_first_subpass_attachments(
        &self,
        rt: &mut RenderTarget<'a>,
        clear_color_0: vk::ClearValue,
        sample_locations_info: &[vk::SampleLocationsInfoEXT; NUM_PASSES],
        resolve_in_first_subpass: bool,
    ) {
        let use_std_locations = self.params.use_std_locations();
        let initial_locations = if use_std_locations {
            None
        } else {
            Some(&sample_locations_info[0])
        };

        self.add_color_attachment(
            rt,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            clear_color_0,
        );
        self.add_resolve_attachment(rt, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);

        // First subpass
        if resolve_in_first_subpass && self.params.is_msaa() {
            rt.add_subpass_color_attachment_with_resolve(
                0,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                1,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            );
        } else {
            rt.add_subpass_color_attachment(0, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, None);
        }

        if self.uses_depth_or_stencil() {
            self.add_depth_stencil_attachment(
                rt,
                vk::AttachmentLoadOp::CLEAR,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                initial_locations,
            );
            rt.add_subpass_depth_stencil_attachment(
                2,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                initial_locations,
            );
        }
    }

    /// `drawSubpasses`: draw two shapes in two subpasses of the same render pass.
    fn draw_subpasses(&self) -> Result<(), TestError> {
        debug_assert!(self.params.clears != TestClears::CmdClearImage); // not possible in a render pass
        debug_assert!(self.params.clears != TestClears::LoadOpClear); // can't specify a load op for a subpass
        debug_assert!(!self.params.use_wait_events()); // can't change layouts inside a subpass

        let device = self.device;
        let render_area = rect_2d(RENDER_SIZE.0, RENDER_SIZE.1);
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let clear_color_0 = clear_value_color(CLEAR_COLOR_0);
        let clear_color_1 = clear_value_color(CLEAR_COLOR_1);
        let clear_depth_stencil_0 = clear_depth_stencil_value();
        let sample_locations_info = self.sample_locations_info();
        let use_std_locations = self.params.use_std_locations();
        let cmd_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let (color_layout_1, depth_stencil_layout_1) = self.second_pass_layouts();

        // Prepare the render pass
        let mut rt = RenderTarget::new(device);
        {
            self.add_first_subpass_attachments(&mut rt, clear_color_0, &sample_locations_info, false);

            // Second subpass
            rt.next_subpass_definition();

            if self.params.is_msaa() {
                rt.add_subpass_color_attachment_with_resolve(0, color_layout_1, 1, color_layout_1);
            } else {
                rt.add_subpass_color_attachment(0, color_layout_1, None);
            }

            if self.uses_depth_or_stencil() {
                let p_sample_locations = if use_std_locations {
                    None
                } else {
                    Some(&sample_locations_info[1])
                };
                rt.add_subpass_depth_stencil_attachment(2, depth_stencil_layout_1, p_sample_locations);
            }

            rt.bake(RENDER_SIZE)?;
        }

        // Pipelines
        let pipelines = [
            self.make_pipeline(*pipeline_layout, rt.render_pass(), 0, &sample_locations_info[0])?,
            self.make_pipeline(*pipeline_layout, rt.render_pass(), 1, &sample_locations_info[1])?,
        ];

        // Record secondary command buffers
        let mut secondary_cmd_buffers: Vec<UniqueCommandBuffer<'_>> = Vec::new();
        if self.params.use_secondary_cmd_buffer() {
            let secondary0 = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let secondary1 = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

            // First subpass contents
            begin_secondary_command_buffer(device, *secondary0, rt.render_pass(), 0, rt.framebuffer())?;
            self.record_first_pass_contents(*secondary0, *pipelines[0], &sample_locations_info[0]);
            end_command_buffer(device, *secondary0)?;

            // Second subpass contents
            begin_secondary_command_buffer(device, *secondary1, rt.render_pass(), 1, rt.framebuffer())?;
            self.record_second_pass_contents(
                *secondary1,
                *pipelines[1],
                &sample_locations_info[1],
                clear_color_1,
                clear_depth_stencil_0,
                render_area,
            );
            end_command_buffer(device, *secondary1)?;

            secondary_cmd_buffers.push(secondary0);
            secondary_cmd_buffers.push(secondary1);
        }

        // Record primary command buffer
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;

        if self.params.use_secondary_cmd_buffer() {
            rt.record_begin_render_pass(
                cmd,
                render_area,
                vk::SubpassContents::SECONDARY_COMMAND_BUFFERS,
                use_std_locations,
            );
            unsafe { device.cmd_execute_commands(cmd, &[*secondary_cmd_buffers[0]]) };

            rt.next_subpass(cmd, vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
            unsafe { device.cmd_execute_commands(cmd, &[*secondary_cmd_buffers[1]]) };
        } else {
            rt.record_begin_render_pass(cmd, render_area, vk::SubpassContents::INLINE, use_std_locations);
            self.record_first_pass_contents(cmd, *pipelines[0], &sample_locations_info[0]);

            rt.next_subpass(cmd, vk::SubpassContents::INLINE);
            self.record_second_pass_contents(
                cmd,
                *pipelines[1],
                &sample_locations_info[1],
                clear_color_1,
                clear_depth_stencil_0,
                render_area,
            );
        }

        rt.end_render_pass(cmd);

        // Color/Resolve image -> host buffer
        record_copy_image_to_buffer(
            device,
            cmd,
            RENDER_SIZE,
            self.source_image(),
            self.color_buffer.get(),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), cmd)
    }

    /// `drawSameSubpass`: draw two shapes within the same subpass of a render pass.
    fn draw_same_subpass(&self) -> Result<(), TestError> {
        debug_assert!(self.params.clears != TestClears::CmdClearImage); // not possible in a render pass
        debug_assert!(self.params.clears != TestClears::LoadOpClear); // can't specify a load op for a subpass
        debug_assert!(!self.params.use_wait_events()); // can't change layouts inside a subpass
        debug_assert!(!self.params.use_general_layout()); // can't change layouts inside a subpass

        let device = self.device;
        let render_area = rect_2d(RENDER_SIZE.0, RENDER_SIZE.1);
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let clear_color_0 = clear_value_color(CLEAR_COLOR_0);
        let clear_color_1 = clear_value_color(CLEAR_COLOR_1);
        let clear_depth_stencil_0 = clear_depth_stencil_value();
        let sample_locations_info = self.sample_locations_info();
        let use_std_locations = self.params.use_std_locations();
        let cmd_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Prepare the render pass
        let mut rt = RenderTarget::new(device);
        self.add_first_subpass_attachments(&mut rt, clear_color_0, &sample_locations_info, true);
        rt.bake(RENDER_SIZE)?;

        // Pipelines
        let pipelines = [
            self.make_pipeline(*pipeline_layout, rt.render_pass(), 0, &sample_locations_info[0])?,
            self.make_pipeline(*pipeline_layout, rt.render_pass(), 0, &sample_locations_info[1])?,
        ];

        // Record secondary command buffers
        let mut secondary_cmd_buffer: Option<UniqueCommandBuffer<'_>> = None;
        if self.params.use_secondary_cmd_buffer() {
            let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

            begin_secondary_command_buffer(device, *secondary, rt.render_pass(), 0, rt.framebuffer())?;
            self.record_first_pass_contents(*secondary, *pipelines[0], &sample_locations_info[0]);
            self.record_second_pass_contents(
                *secondary,
                *pipelines[1],
                &sample_locations_info[1],
                clear_color_1,
                clear_depth_stencil_0,
                render_area,
            );
            end_command_buffer(device, *secondary)?;

            secondary_cmd_buffer = Some(secondary);
        }

        // Record primary command buffer
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;

        if let Some(secondary) = &secondary_cmd_buffer {
            rt.record_begin_render_pass(
                cmd,
                render_area,
                vk::SubpassContents::SECONDARY_COMMAND_BUFFERS,
                use_std_locations,
            );
            unsafe { device.cmd_execute_commands(cmd, &[**secondary]) };
        } else {
            rt.record_begin_render_pass(cmd, render_area, vk::SubpassContents::INLINE, use_std_locations);
            self.record_first_pass_contents(cmd, *pipelines[0], &sample_locations_info[0]);
            self.record_second_pass_contents(
                cmd,
                *pipelines[1],
                &sample_locations_info[1],
                clear_color_1,
                clear_depth_stencil_0,
                render_area,
            );
        }

        rt.end_render_pass(cmd);

        // Color/Resolve image -> host buffer
        record_copy_image_to_buffer(
            device,
            cmd,
            RENDER_SIZE,
            self.source_image(),
            self.color_buffer.get(),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), cmd)
    }
}

/// `DrawTest::iterate`
fn iterate_draw<'a>(context: &'a Context<'a>, params: &DrawParams) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let use_std_locations = params.use_std_locations();
    let props = if use_std_locations {
        vk::PhysicalDeviceSampleLocationsPropertiesEXT::default()
    } else {
        get_sample_locations_properties(context)
    };

    // For this test always use the full pixel grid
    let grid_size = if use_std_locations {
        (1u32, 1u32)
    } else {
        let mut multisample_properties = vk::MultisamplePropertiesEXT::default();
        unsafe {
            context.get_instance().get_physical_device_multisample_properties_ext(
                context.get_physical_device(),
                params.num_samples,
                &mut multisample_properties,
            )
        };
        (
            multisample_properties.max_sample_location_grid_size.width,
            multisample_properties.max_sample_location_grid_size.height,
        )
    };

    // Requirements
    if !(grid_size.0 >= 1 && grid_size.1 >= 1) {
        return Err(TestError::Fail("maxSampleLocationGridSize is invalid".to_string()));
    }

    // Images
    let color_image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let color_image = make_image(
        context,
        vk::ImageCreateFlags::empty(),
        COLOR_FORMAT,
        RENDER_SIZE,
        params.num_samples,
        color_image_usage,
    )?;
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let resolve_image = make_image(
        context,
        vk::ImageCreateFlags::empty(),
        COLOR_FORMAT,
        RENDER_SIZE,
        vk::SampleCountFlags::_1,
        color_image_usage,
    )?;
    let resolve_view = make_image_view(
        device,
        resolve_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;

    let color_buffer_size = (RENDER_SIZE.0 * RENDER_SIZE.1 * 4) as vk::DeviceSize;
    let color_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let mut depth_stencil_format = vk::Format::UNDEFINED;
    let mut depth_stencil_aspect = vk::ImageAspectFlags::empty();
    let mut depth_stencil = None;
    if params.image_aspect != TestImageAspect::Color {
        let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST;
        let create_flags = if use_std_locations {
            vk::ImageCreateFlags::empty()
        } else {
            vk::ImageCreateFlags::SAMPLE_LOCATIONS_COMPATIBLE_DEPTH_EXT
        };

        depth_stencil_format = find_supported_depth_stencil_format(context, params.use_depth(), params.use_stencil());
        if depth_stencil_format == vk::Format::UNDEFINED {
            return Err(TestError::NotSupported("No supported depth/stencil format".to_string()));
        }
        depth_stencil_aspect = (if params.use_depth() {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::empty()
        }) | (if params.use_stencil() {
            vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::empty()
        });
        let image = make_image(
            context,
            create_flags,
            depth_stencil_format,
            RENDER_SIZE,
            params.num_samples,
            usage,
        )?;
        let view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            depth_stencil_format,
            make_image_subresource_range(depth_stencil_aspect, 0, 1, 0, 1),
        )?;
        depth_stencil = Some((image, view));
    }

    // Vertices
    let mut vertices: Vec<PositionColor> = Vec::new();
    if params.use_depth() {
        vertices.extend(gen_vertices_shapes([0.0, 0.0, 0.0, 1.0], DEPTH_REFERENCE / 2.0)); // mask above (z = 0.0 is nearest)
        vertices.extend(gen_vertices_full_quad([1.0, 1.0, 1.0, 1.0], DEPTH_REFERENCE)); // fill below the mask, using the depth test
    } else if params.use_stencil() {
        vertices.extend(gen_vertices_shapes([0.0, 0.0, 0.0, 1.0], DEPTH_REFERENCE)); // first mask
        vertices.extend(gen_vertices_full_quad([1.0, 1.0, 1.0, 1.0], DEPTH_REFERENCE / 2.0)); // then fill the whole area, using the stencil test
    } else {
        vertices = gen_vertices_shapes([1.0; 4], 0.0);
    }
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Multisample pixel grids - set up two sample patterns for two draw passes
    let num_grids = if params.use_same_sample_pattern() {
        1
    } else {
        NUM_PASSES
    };
    let mut pixel_grids = Vec::with_capacity(num_grids);
    if !params.use_same_sample_pattern() {
        debug_assert!(!use_std_locations);
    }
    for pass_ndx in 0..num_grids {
        let mut grid = MultisamplePixelGrid::new(grid_size, params.num_samples);
        if use_std_locations {
            fill_sample_locations_std(&mut grid)?;
        } else {
            let seed = 142 + 75 * pass_ndx as u32;
            fill_sample_locations_random(&mut grid, props.sample_location_sub_pixel_bits, seed);
        }
        pixel_grids.push(grid);
    }

    let test = DrawTest {
        context,
        device,
        params: *params,
        pixel_grids,
        num_vertices: vertices.len() as u32,
        vertex_buffer,
        color_image,
        color_view,
        resolve_image,
        resolve_view,
        depth_stencil_format,
        depth_stencil_aspect,
        depth_stencil,
        color_buffer,
    };

    // Some test cases will not clear the left hand image, so we can use it directly
    let is_clear_case = params.clears != TestClears::NoClear;
    let has_left_side_image = !is_clear_case
        || (params.draw_in != TestDrawIn::RenderPasses && params.clears != TestClears::CmdClearAttachments);

    // Render second pass reference image with the first pattern
    let mut ref_image_pattern_0 = Vec::new();
    if !params.use_same_sample_pattern() && !has_left_side_image {
        test.draw_pattern_change_reference()?;
        ref_image_pattern_0 = test.read_color_buffer()?;
    }

    // Two-pass rendering
    match params.draw_in {
        TestDrawIn::RenderPasses => test.draw_render_passes()?,
        TestDrawIn::Subpasses => test.draw_subpasses()?,
        TestDrawIn::SameSubpass => test.draw_same_subpass()?,
    }

    let image = test.read_color_buffer()?;

    // Verify result
    debug_assert!(RENDER_SIZE.0 % 2 == 0);
    debug_assert!(RENDER_SIZE.1 % 2 == 0);
    let half = RENDER_SIZE.0 / 2;

    // Count colors in each image half separately, each half may have its own background color
    let num_background_colors = 1usize;
    let num_expected_colors_right = num_background_colors + params.num_samples.bits() as usize;
    let num_expected_colors_left = if is_clear_case {
        num_background_colors
    } else {
        num_expected_colors_right
    };
    let left = region_pixels(&image, RENDER_SIZE.0, 0, half, RENDER_SIZE.1);
    let right = region_pixels(&image, RENDER_SIZE.0, half, half, RENDER_SIZE.1);
    let num_actual_colors_left = count_unique_colors(&left);
    let num_actual_colors_right = count_unique_colors(&right);

    if num_actual_colors_left != num_expected_colors_left || num_actual_colors_right != num_expected_colors_right {
        return Err(TestError::Fail(
            "Resolved image has incorrect unique color counts; check log for details --".to_string(),
        ));
    }

    if has_left_side_image {
        // Compare the left and the right half
        let matches = int_threshold_compare(&left, &right, 2);
        if params.use_same_sample_pattern() && !matches {
            return Err(TestError::Fail(
                "Multisample pattern should be identical in both image halves".to_string(),
            ));
        } else if !params.use_same_sample_pattern() && matches {
            return Err(TestError::Fail(
                "Multisample pattern doesn't seem to change between left and right image halves".to_string(),
            ));
        }
    } else if !params.use_same_sample_pattern() {
        // Compare the right half with the previously rendered reference image -- patterns should be different
        let reference_right = region_pixels(&ref_image_pattern_0, RENDER_SIZE.0, half, half, RENDER_SIZE.1);
        if int_threshold_compare(&reference_right, &right, 2) {
            return Err(TestError::Fail(
                "Multisample pattern doesn't seem to change between passes".to_string(),
            ));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `addInstanceTestCaseWithPrograms<DrawTest>`
struct DrawCase {
    name: String,
    params: DrawParams,
}

impl TestCase for DrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupportDrawTests`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let use_std_locations = self.params.use_std_locations();
        if use_std_locations {
            if context.get_device_properties().limits.standard_sample_locations == vk::FALSE {
                return Err(TestError::NotSupported(
                    "standardSampleLocations not supported".to_string(),
                ));
            }
        } else {
            check_sample_locations_ext(context)?;
        }

        if !context
            .get_device_properties()
            .limits
            .framebuffer_color_sample_counts
            .contains(self.params.num_samples)
        {
            return Err(TestError::NotSupported(
                "framebufferColorSampleCounts: sample count not supported".to_string(),
            ));
        }

        if !use_std_locations
            && !get_sample_locations_properties(context)
                .sample_location_sample_counts
                .contains(self.params.num_samples)
        {
            return Err(TestError::NotSupported(
                "VkPhysicalDeviceSampleLocationsPropertiesEXT: sample count not supported".to_string(),
            ));
        }

        // Are we allowed to modify the sample pattern within the same subpass?
        if self.params.draw_in == TestDrawIn::SameSubpass
            && !self.params.use_same_sample_pattern()
            && get_sample_locations_properties(context).variable_sample_locations == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "VkPhysicalDeviceSampleLocationsPropertiesEXT: variableSampleLocations not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SAMPLE_LOCATIONS_DRAW.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawInstance {
            context,
            params: self.params,
        })
    }
}

struct DrawInstance<'a> {
    context: &'a Context<'a>,
    params: DrawParams,
}

impl TestInstance for DrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        iterate_draw(self.context, &self.params)
    }
}

/// The `draw` group of `createTestsInGroup`.
pub(super) fn create_draw_group(use_std_locations: bool) -> TestCaseGroup {
    let global_option = if use_std_locations {
        TEST_OPTION_STD_SAMPLE_LOCATIONS_BIT
    } else {
        0
    };

    let option_sets: Vec<u32> = if use_std_locations {
        let base_options = global_option | TEST_OPTION_SAME_PATTERN_BIT;
        vec![
            base_options,
            base_options | TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT,
            base_options | TEST_OPTION_GENERAL_LAYOUT_BIT,
            base_options | TEST_OPTION_GENERAL_LAYOUT_BIT | TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT,
            base_options | TEST_OPTION_WAIT_EVENTS_BIT,
            base_options | TEST_OPTION_WAIT_EVENTS_BIT | TEST_OPTION_GENERAL_LAYOUT_BIT,
            base_options
                | TEST_OPTION_WAIT_EVENTS_BIT
                | TEST_OPTION_GENERAL_LAYOUT_BIT
                | TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT,
        ]
    } else {
        vec![
            global_option | TEST_OPTION_SAME_PATTERN_BIT,
            global_option,
            global_option | TEST_OPTION_DYNAMIC_STATE_BIT,
            global_option | TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT,
            global_option | TEST_OPTION_DYNAMIC_STATE_BIT | TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT,
            global_option | TEST_OPTION_GENERAL_LAYOUT_BIT,
            global_option | TEST_OPTION_GENERAL_LAYOUT_BIT | TEST_OPTION_DYNAMIC_STATE_BIT,
            global_option | TEST_OPTION_GENERAL_LAYOUT_BIT | TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT,
            global_option
                | TEST_OPTION_GENERAL_LAYOUT_BIT
                | TEST_OPTION_DYNAMIC_STATE_BIT
                | TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT,
            global_option | TEST_OPTION_WAIT_EVENTS_BIT,
            global_option | TEST_OPTION_WAIT_EVENTS_BIT | TEST_OPTION_GENERAL_LAYOUT_BIT,
            global_option
                | TEST_OPTION_WAIT_EVENTS_BIT
                | TEST_OPTION_GENERAL_LAYOUT_BIT
                | TEST_OPTION_SECONDARY_COMMAND_BUFFER_BIT,
        ]
    };

    let draw_clear_sets = [
        (TestDrawIn::RenderPasses, TestClears::NoClear),
        (TestDrawIn::RenderPasses, TestClears::LoadOpClear),
        (TestDrawIn::RenderPasses, TestClears::CmdClearAttachments),
        (TestDrawIn::RenderPasses, TestClears::CmdClearImage),
        (TestDrawIn::Subpasses, TestClears::NoClear),
        (TestDrawIn::Subpasses, TestClears::CmdClearAttachments),
        (TestDrawIn::SameSubpass, TestClears::NoClear),
        (TestDrawIn::SameSubpass, TestClears::CmdClearAttachments),
    ];

    let aspect_range = [TestImageAspect::Color, TestImageAspect::Depth, TestImageAspect::Stencil];

    let mut draw_group = TestCaseGroup::new("draw");
    for image_aspect in aspect_range {
        let mut aspect_group = TestCaseGroup::new(aspect_string(image_aspect));
        for num_samples in VERIFY_SAMPLE_COUNTS {
            let mut samples_group = TestCaseGroup::new(samples_string(num_samples));

            for &(draw_in, clears) in &draw_clear_sets {
                for &option_set in &option_sets {
                    let params = DrawParams {
                        num_samples,
                        options: option_set,
                        draw_in,
                        clears,
                        image_aspect,
                    };

                    // Filter out incompatible parameter combinations
                    if params.image_aspect != TestImageAspect::Color {
                        // If the sample pattern is changed, the D/S image must be cleared or the result is undefined
                        if params.options & TEST_OPTION_SAME_PATTERN_BIT == 0 && params.clears == TestClears::NoClear {
                            continue;
                        }
                    }

                    // We are using events to change image layout and this is only allowed outside a render pass
                    if params.options & TEST_OPTION_WAIT_EVENTS_BIT != 0 && params.draw_in != TestDrawIn::RenderPasses {
                        continue;
                    }

                    // Can't change image layout inside a subpass
                    if params.options & TEST_OPTION_GENERAL_LAYOUT_BIT != 0 && params.draw_in == TestDrawIn::SameSubpass
                    {
                        continue;
                    }

                    let name = format!(
                        "{}_{}{}{}",
                        draw_in_string(params.draw_in),
                        clears_string(params.clears),
                        if params.options != 0 { "_" } else { "" },
                        options_string(params.options)
                    );
                    samples_group.add_child(Box::new(DrawCase { name, params }) as Box<dyn TestCase>);
                }
            }
            aspect_group.add_child(samples_group);
        }
        draw_group.add_child(aspect_group);
    }
    draw_group
}

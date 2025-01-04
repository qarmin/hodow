// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateInheritanceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2020 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Simple test cases for secondary command buffers inheriting dynamic viewport and scissor state from the calling
// primary command buffer or an earlier secondary command buffer. Tests draw a bunch of color rectangles using a trivial
// geometry pipeline (no vertex transformation except for fixed-function viewport transform, geometry shader selects
// viewport/scissor index). The depth test is enabled to check for incorrect depth transformation.
//
// Only the monolithic pipeline construction type is built, so the shader object only branches of `startRenderCmds` are
// left out. The device is the one the whole suite shares, which enables `VK_NV_inherited_viewport_scissor`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicStateExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::dynamic_state_inheritance::INHERITANCE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

// Size of test framebuffer, power of 2 to avoid rounding errors.
const WIDTH: i32 = 256;
const HEIGHT: i32 = 128;

// Maximum viewport/scissors, and maximum rectangles, for any test case.
const MAX_VIEWPORTS: usize = 16;
const MAX_RECTANGLES: usize = 1024;

// Color format of framebuffer image, this seems universally supported.
const FORMAT: vk::Format = vk::Format::B8G8R8A8_UNORM;

/// `Rectangle`: parameters of axis-aligned rectangle to rasterize. No mvp matrix or anything, only testing fixed-function
/// viewport transformation. Its layout is the vertex layout of the pipeline.
#[derive(Clone, Copy)]
#[repr(C)]
struct Rectangle {
    /// Before viewport transformation
    xyz: [f32; 3],
    /// (8-bit) red << 16 | green << 8 | blue
    r8g8b8: i32,
    /// Positive; before viewport transformation
    width_height: [f32; 2],
    viewport_index: i32,
}

/// `InheritanceMode`: determines where the secondary command buffer's inherited viewport/scissor state comes from (if
/// inherited at all).
#[derive(Clone, Copy, PartialEq, Eq)]
enum InheritanceMode {
    /// Disable extension, use non-dynamic viewport/scissor count
    Disabled,
    /// Inherit from calling primary cmd buffer
    FromPrimary,
    /// Inherit from earlier secondary cmd buffer
    FromSecondary,
    /// Inherit from earlier secondary cmd buffer nested within another secondary buffer
    FromSecondaryNested,
    /// Split viewport/scissor array in two, inherit some from primary and rest from secondary
    Split,
    /// Inherit state-with-count-EXT from calling primary cmd buffer
    FromPrimaryWithCount,
    /// Inherit state-with-count-EXT from earlier secondary cmd buffer
    FromSecondaryWithCount,
    /// Inherit state-with-count-EXT from earlier secondary cmd buffer nested within another secondary buffer
    FromSecondaryNestedWithCount,
}

impl InheritanceMode {
    fn is_nested(self) -> bool {
        self == Self::FromSecondaryNested || self == Self::FromSecondaryNestedWithCount
    }

    fn is_with_count(self) -> bool {
        matches!(
            self,
            Self::FromPrimaryWithCount | Self::FromSecondaryWithCount | Self::FromSecondaryNestedWithCount
        )
    }
}

/// `TestGeometry`: input test geometry.
#[derive(Clone)]
struct TestGeometry {
    /// Color and depth to clear the framebuffer to.
    clear_color: [f32; 3],
    clear_depth: f32,

    /// List of rectangles to rasterize, in order.
    rectangles: Vec<Rectangle>,

    /// List of viewports and scissors to use, both vectors must have same length and have length at least 1.
    viewports: Vec<vk::Viewport>,
    scissors: Vec<vk::Rect2D>,
}

fn viewport(x: f32, y: f32, width: f32, height: f32, min_depth: f32, max_depth: f32) -> vk::Viewport {
    vk::Viewport {
        x,
        y,
        width,
        height,
        min_depth,
        max_depth,
    }
}

fn scissor(x: i32, y: i32, width: u32, height: u32) -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x, y },
        extent: vk::Extent2D { width, height },
    }
}

/// `makeGeometry`
fn make_geometry() -> Vec<TestGeometry> {
    let (w, h) = (WIDTH as f32, HEIGHT as f32);
    let (wu, hu) = (WIDTH as u32, HEIGHT as u32);
    let mut cases = Vec::new();

    let mut geometry = TestGeometry {
        clear_color: [1.0, 1.0, 1.0],
        clear_depth: 1.0,
        rectangles: Vec::new(),
        viewports: Vec::new(),
        scissors: Vec::new(),
    };

    // Simple test case, three squares, the last one should go in between the first two in depth due to viewport 1 halving
    // the actual depth value.
    geometry.rectangles.push(Rectangle {
        xyz: [-0.5, -1.0, 0.2],
        r8g8b8: 0xFF0000,
        width_height: [0.5, 1.0],
        viewport_index: 0,
    });
    geometry.rectangles.push(Rectangle {
        xyz: [0.0, 0.0, 0.6],
        r8g8b8: 0x0000FF,
        width_height: [0.5, 1.0],
        viewport_index: 0,
    });
    geometry.rectangles.push(Rectangle {
        // becomes 0.4f depth
        xyz: [-0.25, -0.5, 0.8],
        r8g8b8: 0x008000,
        width_height: [0.5, 1.0],
        viewport_index: 1,
    });
    geometry.viewports.push(viewport(0.0, 0.0, w, h, 0.0, 1.0));
    geometry.viewports.push(viewport(0.0, 0.0, w, h, 0.0, 0.5));
    geometry.scissors.push(scissor(0, 0, wu, hu));
    geometry.scissors.push(scissor(0, 0, wu, hu));

    cases.push(geometry.clone());

    // Apply scissor rectangle to red and blue squares.
    geometry.scissors[0].extent.width = wu / 2 + 1;
    cases.push(geometry.clone());

    // Squash down and offset green rectangle's viewport.
    geometry.viewports[1].y = h * 0.25;
    geometry.viewports[1].height = h * 0.75;
    cases.push(geometry.clone());

    // Add another viewport and scissor.
    geometry.viewports.push(viewport(
        (WIDTH / 2 - 4) as f32,
        0.0,
        (WIDTH / 2) as f32,
        (HEIGHT - 8) as f32,
        0.5,
        1.0,
    ));
    geometry.scissors.push(scissor(WIDTH / 2 - 2, 10, wu / 2, hu));
    geometry.rectangles.push(Rectangle {
        // Becomes 0.75f depth
        xyz: [-1.0, -1.0, 0.5],
        r8g8b8: 0x000000,
        width_height: [1.75, 1.75],
        viewport_index: 2,
    });
    cases.push(geometry.clone());

    // Add a few more rectangles.
    geometry.rectangles.push(Rectangle {
        xyz: [-0.25, -0.25, 0.1],
        r8g8b8: 0xFF00FF,
        width_height: [0.375, 0.375],
        viewport_index: 0,
    });
    geometry.rectangles.push(Rectangle {
        // Becomes 0.9f depth
        xyz: [-1.0, -1.0, 0.8],
        r8g8b8: 0x00FFFF,
        width_height: [2.0, 2.0],
        viewport_index: 2,
    });
    geometry.rectangles.push(Rectangle {
        xyz: [-1.0, -1.0, 0.7],
        r8g8b8: 0x808000,
        width_height: [2.0, 2.0],
        viewport_index: 0,
    });
    cases.push(geometry.clone());

    // Change clear depth and color.
    geometry.clear_depth = 0.85;
    geometry.clear_color = [1.0, 1.0, 0.0];
    cases.push(geometry.clone());

    // Alter viewport/scissor 2.
    geometry.viewports[2] = viewport(0.0, 0.0, w, h, 0.51, 0.53);
    geometry.scissors[2] = scissor(20, 0, wu, hu);
    cases.push(geometry.clone());

    // Change clear depth and color again.
    geometry.clear_depth = 0.5;
    geometry.clear_color = [0.0, 1.0, 0.0];
    cases.push(geometry);

    cases
}

fn clamp(value: f32, low: f32, high: f32) -> f32 {
    value.max(low).min(high)
}

fn clamp_i32(value: i32, low: i32, high: i32) -> i32 {
    value.max(low).min(high)
}

fn u8_from_unorm(x: f32) -> u8 {
    (clamp(x, 0.0, 1.0) * 255.0).round() as u8
}

/// `rasterizeExpectedResults`: the expected image as (blue, green, red) texels indexed [y * WIDTH + x].
#[allow(clippy::neg_cmp_op_on_partial_ord)]
fn rasterize_expected_results(geometry: &TestGeometry) -> Vec<[u8; 3]> {
    let (width, height) = (WIDTH as usize, HEIGHT as usize);

    // Clear color and depth buffers.
    let clear_color_texel = [
        u8_from_unorm(geometry.clear_color[2]),
        u8_from_unorm(geometry.clear_color[1]),
        u8_from_unorm(geometry.clear_color[0]),
    ];
    let mut cpu_depth_buffer = vec![geometry.clear_depth; width * height];
    let mut output = vec![clear_color_texel; width * height];

    // Rasterize each rectangle. Pixels have half-integer centers.
    for r in &geometry.rectangles {
        // Select correct viewport and scissor.
        let viewport = geometry.viewports[r.viewport_index as usize];
        let scissor = geometry.scissors[r.viewport_index as usize];

        // Transform xyz and width/height with selected viewport.
        let ox = viewport.x + viewport.width * 0.5;
        let oy = viewport.y + viewport.height * 0.5;
        let oz = viewport.min_depth;

        let px = viewport.width;
        let py = viewport.height;
        let pz = viewport.max_depth - viewport.min_depth;

        let x_low = clamp(r.xyz[0], -1.0, 1.0);
        let x_high = clamp(r.xyz[0] + r.width_height[0], -1.0, 1.0);
        let y_low = clamp(r.xyz[1], -1.0, 1.0);
        let y_high = clamp(r.xyz[1] + r.width_height[1], -1.0, 1.0);

        let xf = [px * 0.5 * x_low + ox, px * 0.5 * x_high + ox];
        let yf = [py * 0.5 * y_low + oy, py * 0.5 * y_high + oy];
        let zf = pz * r.xyz[2] + oz;

        let mut x_begin = (xf[0] + 0.5).floor() as i32;
        let mut x_end = (xf[1] + 0.5).floor() as i32;
        let mut y_begin = (yf[0] + 0.5).floor() as i32;
        let mut y_end = (yf[1] + 0.5).floor() as i32;

        // Scissor test, only correct when drawn rectangle has positive width/height.
        let xs_low = scissor.offset.x;
        let xs_high = xs_low + scissor.extent.width as i32;
        x_begin = clamp_i32(x_begin, xs_low, xs_high);
        x_end = clamp_i32(x_end, xs_low, xs_high);
        let ys_low = scissor.offset.y;
        let ys_high = ys_low + scissor.extent.height as i32;
        y_begin = clamp_i32(y_begin, ys_low, ys_high);
        y_end = clamp_i32(y_end, ys_low, ys_high);

        // Clamp to framebuffer size
        x_begin = clamp_i32(x_begin, 0, WIDTH);
        x_end = clamp_i32(x_end, 0, WIDTH);
        y_begin = clamp_i32(y_begin, 0, HEIGHT);
        y_end = clamp_i32(y_end, 0, HEIGHT);

        // Rasterize.
        let rect_texel = [
            (r.r8g8b8 & 255) as u8,
            ((r.r8g8b8 >> 8) & 255) as u8,
            ((r.r8g8b8 >> 16) & 255) as u8,
        ];
        for x in x_begin..x_end {
            for y in y_begin..y_end {
                // Depth test
                let index = y as usize * width + x as usize;
                if !(zf < cpu_depth_buffer[index]) {
                    continue;
                }

                output[index] = rect_texel;
                cpu_depth_buffer[index] = zf;
            }
        }
    }

    output
}

struct InheritanceTestCase {
    name: &'static str,
    inheritance_mode: InheritanceMode,
}

impl TestCase for InheritanceTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_NV_inherited_viewport_scissor")?;
        if self.inheritance_mode == InheritanceMode::FromPrimaryWithCount
            || self.inheritance_mode == InheritanceMode::FromSecondaryWithCount
        {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }
        if self.inheritance_mode.is_nested() {
            context.require_device_functionality("VK_EXT_nested_command_buffer")?;
            let mut features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.nested_command_buffer == vk::FALSE {
                return Err(TestError::NotSupported(
                    "nestedCommandBuffer is not supported".to_string(),
                ));
            }
            if features.nested_command_buffer_rendering == vk::FALSE {
                return Err(TestError::NotSupported(
                    "nestedCommandBufferRendering is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        INHERITANCE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InheritanceTestInstance {
            context,
            inheritance_mode: self.inheritance_mode,
        })
    }
}

struct InheritanceTestInstance<'a> {
    context: &'a Context<'a>,
    inheritance_mode: InheritanceMode,
}

/// `makeDepthImageInfo`'s format search.
fn find_depth_format(context: &Context<'_>) -> Result<vk::Format, TestError> {
    let depth_formats = [
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];
    for format in depth_formats {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Ok(format);
        }
    }
    Err(TestError::InternalError(
        "Did not find suitable depth attachment format.".to_string(),
    ))
}

fn create_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: WIDTH as u32,
            height: HEIGHT as u32,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::LOCAL,
    )
}

impl TestInstance for InheritanceTestInstance<'_> {
    /// `InheritanceTestInstance::iterate`, with the constructor's setup in front.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let mode = self.inheritance_mode;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();

        // Vertex buffer storing rectangle list, kMaxRectangles is its capacity (in Rectangles), and the buffer for
        // downloading the rendered image from the device.
        let rectangle_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                (MAX_RECTANGLES * std::mem::size_of::<Rectangle>()) as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        )?;
        let download_buffer_size = (WIDTH * HEIGHT * 4) as usize;
        let download_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                download_buffer_size as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        )?;

        // Image attachments and views.
        let depth_format = find_depth_format(context)?;
        let color_image = create_image(
            context,
            FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let depth_image = create_image(context, depth_format, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            depth_format,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;

        // Render pass, adapted from Alexander Overvoorde's vulkan-tutorial.com (CC0 1.0 Universal)
        let attachments = [
            vk::AttachmentDescription::builder()
                .format(FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(depth_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_attachment_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_attachment_ref = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_ref)
            .depth_stencil_attachment(&depth_attachment_ref)
            .build()];
        let dependencies = [vk::SubpassDependency {
            src_subpass: vk::SUBPASS_EXTERNAL,
            dst_subpass: 0,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            src_access_mask: vk::AccessFlags::empty(),
            dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dependency_flags: vk::DependencyFlags::empty(),
        }];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // Set up framebuffer
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view, *depth_view],
            WIDTH as u32,
            HEIGHT as u32,
            1,
        )?;

        // Compile graphics pipeline stages.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let geom_module = create_shader_module(device, binaries.get("geom")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Set up pipeline layout (empty)
        let rectangle_pipeline_layout = make_pipeline_layout(device, &[])?;

        // Graphics pipelines are created on-the-fly later. Pipeline array maps viewport/scissor count to the pipeline to use
        // (special value 0 indicates that viewport/scissor count is dynamic state).
        let mut rectangle_pipelines: Vec<Option<Unique<'_, vk::Pipeline>>> = Vec::new();
        for _ in 0..=MAX_VIEWPORTS {
            rectangle_pipelines.push(None);
        }

        // Command pool and command buffers.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let primary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let set_state_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let subpass_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let nested_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

        let test_geometries = make_geometry();
        let mut fail_bits = 0u32;

        for (i, geometry) in test_geometries.iter().enumerate() {
            debug_assert!(
                !geometry.viewports.is_empty()
                    && geometry.viewports.len() <= MAX_VIEWPORTS
                    && geometry.viewports.len() == geometry.scissors.len()
            );

            // Fill vertex buffer
            debug_assert!(MAX_RECTANGLES >= geometry.rectangles.len());
            unsafe {
                std::ptr::copy_nonoverlapping(
                    geometry.rectangles.as_ptr().cast::<u8>(),
                    rectangle_buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(geometry.rectangles.as_slice()),
                );
            }
            flush_alloc(device, rectangle_buffer.get_allocation())?;

            let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(*render_pass)
                .subpass(0)
                .framebuffer(*framebuffer);
            let cmd_begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);

            let viewports = geometry.viewports.as_slice();
            let scissors = geometry.scissors.as_slice();

            // ************************************************************************
            // Record state-setting secondary command buffer.
            // ************************************************************************
            unsafe { device.begin_command_buffer(*set_state_cmd_buffer, &cmd_begin_info) }
                .vk_check("vkBeginCommandBuffer")?;
            unsafe {
                match mode {
                    InheritanceMode::Disabled
                    | InheritanceMode::FromPrimary
                    | InheritanceMode::FromPrimaryWithCount => {}
                    InheritanceMode::FromSecondary | InheritanceMode::FromSecondaryNested => {
                        // Set all viewport/scissor state.
                        device.cmd_set_viewport(*set_state_cmd_buffer, 0, viewports);
                        device.cmd_set_scissor(*set_state_cmd_buffer, 0, scissors);
                    }
                    InheritanceMode::Split => {
                        // Set just the first viewport / scissor, rest are set in primary command buffer. Checks that
                        // extension properly muxes state from different sources.
                        device.cmd_set_viewport(*set_state_cmd_buffer, 0, &viewports[..1]);
                        device.cmd_set_scissor(*set_state_cmd_buffer, 0, &scissors[..1]);
                    }
                    InheritanceMode::FromSecondaryWithCount | InheritanceMode::FromSecondaryNestedWithCount => {
                        device.cmd_set_viewport_with_count_ext(*set_state_cmd_buffer, viewports);
                        device.cmd_set_scissor_with_count_ext(*set_state_cmd_buffer, scissors);
                    }
                }
            }
            end_command_buffer(device, *set_state_cmd_buffer)?;

            // ************************************************************************
            // Record subpass command buffer, bind vertex buffer and pipeline, then draw rectangles.
            // ************************************************************************
            if mode != InheritanceMode::Disabled {
                // Enable viewport/scissor inheritance struct.
                let mut inherit_viewport_info = vk::CommandBufferInheritanceViewportScissorInfoNV::builder()
                    .viewport_scissor_2d(true)
                    .viewport_depth_count(viewports.len() as u32)
                    .viewport_depths(&viewports[0]);
                let inheritance_info_nv = vk::CommandBufferInheritanceInfo::builder()
                    .render_pass(*render_pass)
                    .subpass(0)
                    .framebuffer(*framebuffer)
                    .push_next(&mut inherit_viewport_info);
                let cmd_begin_info_nv = vk::CommandBufferBeginInfo::builder()
                    .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                    .inheritance_info(&inheritance_info_nv);
                unsafe { device.begin_command_buffer(*subpass_cmd_buffer, &cmd_begin_info_nv) }
                    .vk_check("vkBeginCommandBuffer")?;
            } else {
                unsafe { device.begin_command_buffer(*subpass_cmd_buffer, &cmd_begin_info) }
                    .vk_check("vkBeginCommandBuffer")?;
            }
            // Set viewport/scissor state only when not inherited.
            if mode == InheritanceMode::Disabled {
                unsafe {
                    device.cmd_set_viewport(*subpass_cmd_buffer, 0, viewports);
                    device.cmd_set_scissor(*subpass_cmd_buffer, 0, scissors);
                }
            }
            // Get the graphics pipeline, creating it if needed (encountered new static viewport/scissor count). 0 = dynamic count.
            let static_viewport_count = if mode.is_with_count() { 0 } else { viewports.len() };
            if rectangle_pipelines[static_viewport_count].is_none() {
                let mut state = DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST);
                state.bindings = vec![vk::VertexInputBindingDescription {
                    binding: 0,
                    stride: std::mem::size_of::<Rectangle>() as u32,
                    input_rate: vk::VertexInputRate::VERTEX,
                }];
                state.attributes = vec![
                    vk::VertexInputAttributeDescription {
                        location: 0,
                        binding: 0,
                        format: vk::Format::R32G32B32_SFLOAT,
                        offset: 0,
                    },
                    vk::VertexInputAttributeDescription {
                        location: 1,
                        binding: 0,
                        format: vk::Format::R32_SINT,
                        offset: 12,
                    },
                    vk::VertexInputAttributeDescription {
                        location: 2,
                        binding: 0,
                        format: vk::Format::R32G32_SFLOAT,
                        offset: 16,
                    },
                    vk::VertexInputAttributeDescription {
                        location: 3,
                        binding: 0,
                        format: vk::Format::R32_SINT,
                        offset: 24,
                    },
                ];
                state.viewport_count = static_viewport_count as u32;
                state.dynamic_states = if static_viewport_count == 0 {
                    vec![
                        vk::DynamicState::VIEWPORT_WITH_COUNT,
                        vk::DynamicState::SCISSOR_WITH_COUNT,
                    ]
                } else {
                    vec![vk::DynamicState::VIEWPORT, vk::DynamicState::SCISSOR]
                };
                state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
                    .polygon_mode(vk::PolygonMode::FILL)
                    .cull_mode(vk::CullModeFlags::BACK)
                    .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
                    .line_width(1.0)
                    .build();
                state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
                    .depth_test_enable(true)
                    .depth_write_enable(true)
                    .depth_compare_op(vk::CompareOp::LESS)
                    .build();
                rectangle_pipelines[static_viewport_count] = Some(create_draw_pipeline(
                    device,
                    *rectangle_pipeline_layout,
                    *render_pass,
                    &[
                        (vk::ShaderStageFlags::VERTEX, *vert_module),
                        (vk::ShaderStageFlags::GEOMETRY, *geom_module),
                        (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                    ],
                    &state,
                )?);
            }
            let rectangle_pipeline = rectangle_pipelines[static_viewport_count]
                .as_ref()
                .ok_or_else(|| TestError::InternalError("pipeline missing".to_string()))?;
            unsafe {
                device.cmd_bind_pipeline(
                    *subpass_cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    rectangle_pipeline.get(),
                );

                // Bind vertex buffer and draw.
                device.cmd_bind_vertex_buffers(*subpass_cmd_buffer, 0, &[rectangle_buffer.get()], &[0]);
                device.cmd_draw(*subpass_cmd_buffer, geometry.rectangles.len() as u32, 1, 0, 0);
            }
            end_command_buffer(device, *subpass_cmd_buffer)?;

            let secondary_cmd_buffers = [*set_state_cmd_buffer, *subpass_cmd_buffer];

            if mode.is_nested() {
                unsafe { device.begin_command_buffer(*nested_cmd_buffer, &cmd_begin_info) }
                    .vk_check("vkBeginCommandBuffer")?;
                unsafe { device.cmd_execute_commands(*nested_cmd_buffer, &secondary_cmd_buffers) };
                end_command_buffer(device, *nested_cmd_buffer)?;
            }

            // ************************************************************************
            // Primary command buffer commands, start render pass and execute the secondary command buffers, then copy
            // rendered image to download buffer.
            // ************************************************************************
            begin_command_buffer(device, *primary_cmd_buffer)?;

            let clear_values = [
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [
                            geometry.clear_color[0],
                            geometry.clear_color[1],
                            geometry.clear_color[2],
                            1.0,
                        ],
                    },
                },
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: geometry.clear_depth,
                        stencil: 0,
                    },
                },
            ];
            let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(scissor(0, 0, WIDTH as u32, HEIGHT as u32))
                .clear_values(&clear_values);

            unsafe {
                match mode {
                    InheritanceMode::FromPrimary => {
                        // Specify all viewport/scissor state only when we expect to. Inherit ALL viewport/scissor state from primary command buffer.
                        device.cmd_set_viewport(*primary_cmd_buffer, 0, viewports);
                        device.cmd_set_scissor(*primary_cmd_buffer, 0, scissors);
                    }
                    InheritanceMode::FromPrimaryWithCount => {
                        // Same but with count inherited.
                        device.cmd_set_viewport_with_count_ext(*primary_cmd_buffer, viewports);
                        device.cmd_set_scissor_with_count_ext(*primary_cmd_buffer, scissors);
                    }
                    _ => {
                        if mode == InheritanceMode::Split && viewports.len() > 1 {
                            // Specify the remaining viewport, scissors not set by the setStateCmdBuffer in this test mode.
                            device.cmd_set_viewport(*primary_cmd_buffer, 1, &viewports[1..]);
                            device.cmd_set_scissor(*primary_cmd_buffer, 1, &scissors[1..]);
                        }

                        // Specify some bogus state, ensure correctly overwritten later.
                        let bogus_viewport = viewport(0.0, 0.0, 8.0, 8.0, 0.0, 0.1);
                        let bogus_scissors = scissor(2, 0, 100, 100);
                        device.cmd_set_viewport(*primary_cmd_buffer, 0, &[bogus_viewport]);
                        device.cmd_set_scissor(*primary_cmd_buffer, 0, &[bogus_scissors]);
                    }
                }

                device.cmd_begin_render_pass(
                    *primary_cmd_buffer,
                    &render_pass_begin_info,
                    vk::SubpassContents::SECONDARY_COMMAND_BUFFERS,
                );

                if mode.is_nested() {
                    device.cmd_execute_commands(*primary_cmd_buffer, &[*nested_cmd_buffer]);
                } else {
                    device.cmd_execute_commands(*primary_cmd_buffer, &secondary_cmd_buffers);
                }

                device.cmd_end_render_pass(*primary_cmd_buffer);
            }

            // Barrier, then copy rendered image to download buffer.
            let image_barrier = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
                .old_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(color_image.get())
                .subresource_range(make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1))
                .build();
            let buffer_image_copy = vk::BufferImageCopy {
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
                image_extent: vk::Extent3D {
                    width: WIDTH as u32,
                    height: HEIGHT as u32,
                    depth: 1,
                },
            };
            let buffer_barrier = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(download_buffer.get())
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    *primary_cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
                device.cmd_copy_image_to_buffer(
                    *primary_cmd_buffer,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    download_buffer.get(),
                    &[buffer_image_copy],
                );

                // Barrier, make buffer visible to host.
                device.cmd_pipeline_barrier(
                    *primary_cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            // End and submit primary command buffer, and wait for it.
            end_command_buffer(device, *primary_cmd_buffer)?;
            submit_commands_and_wait(device, queue, *primary_cmd_buffer)?;

            // Work on CPU-side expected results.
            let expected_result = rasterize_expected_results(geometry);

            invalidate_alloc(device, download_buffer.get_allocation())?;
            let device_result = unsafe {
                std::slice::from_raw_parts(download_buffer.get_allocation().get_host_ptr(), download_buffer_size)
            };

            // Compare results. The test cases should be simple enough not to require fuzzy matching (power of 2
            // framebuffer, no nearby depth values, etc.)
            let passed = expected_result
                .iter()
                .zip(device_result.chunks_exact(4))
                .all(|(expected, texel)| texel[..3] == expected[..]);

            fail_bits |= u32::from(!passed) << i;
        }

        if fail_bits != 0 {
            let mut message = "Failed for test geometry".to_string();
            for i in 0..32 {
                if (fail_bits >> i) & 1 != 0 {
                    message.push_str(&format!(" {i}"));
                }
            }
            return Ok(TestStatus::fail(message));
        }
        Ok(TestStatus::pass("pass"))
    }
}

/// `DynamicStateInheritanceTests::init`
pub fn create_inheritance_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("inheritance");

    // Baseline, no viewport/scissor inheritance
    group.add_child(Box::new(InheritanceTestCase {
        name: "baseline",
        inheritance_mode: InheritanceMode::Disabled,
    }) as Box<dyn TestCase>);
    // Inherit viewport/scissor from calling primary command buffer
    group.add_child(Box::new(InheritanceTestCase {
        name: "primary",
        inheritance_mode: InheritanceMode::FromPrimary,
    }) as Box<dyn TestCase>);
    // Inherit viewport/scissor from another secondary command buffer
    group.add_child(Box::new(InheritanceTestCase {
        name: "secondary",
        inheritance_mode: InheritanceMode::FromSecondary,
    }) as Box<dyn TestCase>);
    // Inherit viewport/scissor from another secondary command buffer
    group.add_child(Box::new(InheritanceTestCase {
        name: "nested",
        inheritance_mode: InheritanceMode::FromSecondaryNested,
    }) as Box<dyn TestCase>);
    // Inherit some viewports/scissors from primary, some from secondary
    group.add_child(Box::new(InheritanceTestCase {
        name: "split",
        inheritance_mode: InheritanceMode::Split,
    }) as Box<dyn TestCase>);
    // Inherit viewport/scissor with count from calling primary command buffer
    group.add_child(Box::new(InheritanceTestCase {
        name: "primary_with_count",
        inheritance_mode: InheritanceMode::FromPrimaryWithCount,
    }) as Box<dyn TestCase>);
    // Inherit viewport/scissor with count from another secondary command buffer
    group.add_child(Box::new(InheritanceTestCase {
        name: "secondary_with_count",
        inheritance_mode: InheritanceMode::FromSecondaryWithCount,
    }) as Box<dyn TestCase>);
    // Inherit viewport/scissor with count from another secondary command buffer within a secondary buffer
    group.add_child(Box::new(InheritanceTestCase {
        name: "nested_with_count",
        inheritance_mode: InheritanceMode::FromSecondaryNestedWithCount,
    }) as Box<dyn TestCase>);

    group
}

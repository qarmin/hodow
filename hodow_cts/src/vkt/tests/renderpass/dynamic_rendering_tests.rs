// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream has one `DynamicRenderingTestInstance` subclass per command buffer layout,
// each repeating the same draw pass and clear pass with the commands cut up differently. Here a layout is a `Scenario` - the
// instances of one rendering sequence with the primary command buffer each lives in, its suspend/resume flags, and whether its
// commands are recorded inline or in secondary command buffers - and `run_pass` records the commands in the order the subclasses
// did. `partial_binding_depth_stencil` keeps its own code. The references are computed per pixel instead of through
// `tcu::TextureLevel`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, InstanceV1_1, KhrMaintenance10ExtensionDeviceCommands};

use crate::generated::shaders::renderpass_dynamic_rendering_basic::DYNAMIC_RENDERING_BASIC;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// maxColorAttachments is guaranteed to be at least 4.
const COLOR_ATTACHMENTS_NUMBER: usize = 4;

const TEST_ATTACHMENT_LOAD_OP_LAST: i32 = 3;
const TEST_ATTACHMENT_STORE_OP_LAST: i32 = 2;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    /// Draw two triangles in a single primary command buffer, beginning and ending the render pass instance.
    SingleCmdbuf = 0,
    /// Draw two triangles in a single primary command buffer, but across two render pass instances, with the second RESUMING the first.
    SingleCmdbufResuming,
    /// Draw two triangles in two primary command buffers, across two render pass instances, with the second RESUMING the first.
    TwoCmdbufResuming,
    /// Draw two triangles in two secondary command buffers, across two render pass instances, with the second RESUMING the first,
    /// both recorded to the same primary command buffer.
    SecondaryCmdbufResuming,
    /// Draw two triangles in two secondary command buffers, across two render pass instances, with the second RESUMING the first,
    /// executed in the two primary command buffers.
    SecondaryCmdbufTwoPrimaryResuming,
    /// Using CONTENTS_SECONDARY_COMMAND_BUFFER_BIT_KHR, draw two triangles in one secondary command buffer, and execute it inside a
    /// single render pass instance in one primary command buffer.
    ContentsSecondaryCommandBuffer,
    /// Using CONTENTS_SECONDARY_COMMAND_BUFFER_BIT_KHR, draw two triangles in two secondary command buffers, and execute them inside
    /// a single render pass instance in one primary command buffer.
    Contents2SecondaryCommandBuffer,
    /// Using CONTENTS_SECONDARY_COMMAND_BUFFER_BIT_KHR, draw two triangles in two secondary command buffers, and execute them inside
    /// two render pass instances, with the second RESUMING the first, both recorded in the same primary command buffer.
    Contents2SecondaryCommandBufferResuming,
    /// The same, recorded into two primary command buffers.
    Contents2Secondary2PrimaryCmdbufResuming,
    /// In one primary command buffer, record two render pass instances, with the second resuming the first. In the first, draw one
    /// triangle directly in the primary command buffer. For the second, use CONTENTS_SECONDARY_COMMAND_BUFFER_BIT_KHR, draw the second
    /// triangle in a secondary command buffer, and execute it in that second render pass instance.
    ContentsPrimarySecondaryCmdbufResuming,
    /// In one primary command buffer, record two render pass instances, with the second resuming the first. In the first, use
    /// CONTENTS_SECONDARY_COMMAND_BUFFER_BIT_KHR, draw the first triangle in a secondary command buffer, and execute it in that first
    /// render pass instance. In the second, draw one triangle directly in the primary command buffer.
    ContentsSecondaryPrimaryCmdbufResuming,
    /// As `ContentsPrimarySecondaryCmdbufResuming`, in two primary command buffers (one per render pass instance).
    Contents2PrimarySecondaryCmdbufResuming,
    /// As `ContentsSecondaryPrimaryCmdbufResuming`, in two primary command buffers (one per render pass instance).
    ContentsSecondary2PrimaryCmdbufResuming,
    /// Draw triangles inside rendering of secondary command buffer, and after rendering is ended copy results on secondary buffer.
    /// Tests mixing inside & outside render pass commands in secondary command buffers
    SecondaryCmdbufOutOfRenderingCommands,
    /// Test partial binding of depth/stencil formats. 3 sets of tests:
    /// 1. Clears bound resource and leaves the other untouched.
    /// 2. Clears and draws to the resource leaving the unbound as is.
    /// 3. Previous ones with secondary commands to check inheritance works as expected
    PartialBindingDepthStencil,
}

const TEST_TYPES: [(TestType, &str); 15] = [
    (TestType::SingleCmdbuf, "single_cmdbuffer"),
    (TestType::SingleCmdbufResuming, "single_cmdbuffer_resuming"),
    (TestType::TwoCmdbufResuming, "2_cmdbuffers_resuming"),
    (TestType::SecondaryCmdbufResuming, "2_secondary_cmdbuffers_resuming"),
    (
        TestType::SecondaryCmdbufTwoPrimaryResuming,
        "2_secondary_2_primary_cmdbuffers_resuming",
    ),
    (
        TestType::ContentsSecondaryCommandBuffer,
        "contents_secondary_cmdbuffers",
    ),
    (
        TestType::Contents2SecondaryCommandBuffer,
        "contents_2_secondary_cmdbuffers",
    ),
    (
        TestType::Contents2SecondaryCommandBufferResuming,
        "contents_2_secondary_cmdbuffers_resuming",
    ),
    (
        TestType::Contents2Secondary2PrimaryCmdbufResuming,
        "contents_2_secondary_2_primary_cmdbuffers_resuming",
    ),
    (
        TestType::ContentsPrimarySecondaryCmdbufResuming,
        "contents_primary_secondary_cmdbuffers_resuming",
    ),
    (
        TestType::ContentsSecondaryPrimaryCmdbufResuming,
        "contents_secondary_primary_cmdbuffers_resuming",
    ),
    (
        TestType::Contents2PrimarySecondaryCmdbufResuming,
        "contents_2_primary_secondary_cmdbuffers_resuming",
    ),
    (
        TestType::ContentsSecondary2PrimaryCmdbufResuming,
        "contents_secondary_2_primary_cmdbuffers_resuming",
    ),
    (
        TestType::SecondaryCmdbufOutOfRenderingCommands,
        "secondary_cmdbuffer_out_of_rendering_commands",
    ),
    (TestType::PartialBindingDepthStencil, "partial_binding_depth_stencil"),
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestAttachmentType {
    SingleColor = 0,
    DepthAttachment,
    StencilAttachment,
    MultipleColor,
    None,
    All,
    /// Run all the variants.
    Last,
}

const TEST_ATTACHMENT_TYPES: [TestAttachmentType; 7] = [
    TestAttachmentType::SingleColor,
    TestAttachmentType::DepthAttachment,
    TestAttachmentType::StencilAttachment,
    TestAttachmentType::MultipleColor,
    TestAttachmentType::None,
    TestAttachmentType::All,
    TestAttachmentType::Last,
];

fn good_for_partial_binding_ds(test_attachment_type: TestAttachmentType) -> bool {
    // These combinations are useless because there is no depth/stencil attachment info.
    !matches!(
        test_attachment_type,
        TestAttachmentType::SingleColor | TestAttachmentType::MultipleColor | TestAttachmentType::None
    )
}

fn test_attachment_type_suffix(test_attachment_type: TestAttachmentType) -> &'static str {
    match test_attachment_type {
        TestAttachmentType::SingleColor => "_att_single_color",
        TestAttachmentType::DepthAttachment => "_att_depth_attachment",
        TestAttachmentType::StencilAttachment => "_att_stencil_attachment",
        TestAttachmentType::MultipleColor => "_att_multiple_color",
        TestAttachmentType::None => "_att_none",
        TestAttachmentType::All => "_att_all",
        TestAttachmentType::Last => "",
    }
}

/// `PartialBindDsForBase`
#[derive(Clone, Copy)]
struct PartialBindDsForBase {
    load_op: vk::AttachmentLoadOp,
    clear_only: bool,
    use_secondary: bool,
}

/// `PartialBindDsParams`, the union by its tag.
#[derive(Clone, Copy)]
enum PartialBindDsParams {
    /// `TEST_ATTACHMENT_DEPTH_ATTACHMENT` or `TEST_ATTACHMENT_STENCIL_ATTACHMENT`
    Base(PartialBindDsForBase),
    /// `TEST_ATTACHMENT_ALL`: the aspect that is left out of `VkCommandBufferInheritanceRenderingInfo`.
    UndefinedFormat { discard_aspect: vk::ImageAspectFlags },
}

#[derive(Clone, Copy)]
struct TestParameters {
    test_type: TestType,
    clear_color: [f32; 4],
    depth_clear_value: f32,
    stencil_clear_value: u32,
    image_format: vk::Format,
    render_size: (u32, u32),
    end_rendering2: bool,
    /// If `Last`, run all the variants.
    test_attachment_type: TestAttachmentType,
    partial_binds_ds_info: Option<PartialBindDsParams>,
}

#[derive(Clone, Copy)]
struct ImagesLayout {
    old_colors: [vk::ImageLayout; COLOR_ATTACHMENTS_NUMBER],
    old_stencil: vk::ImageLayout,
    old_depth: vk::ImageLayout,
}

#[derive(Clone, Copy)]
struct ImagesFormat {
    colors: [vk::Format; COLOR_ATTACHMENTS_NUMBER],
    depth: vk::Format,
    stencil: vk::Format,
}

/// `ClearAttachmentData`
struct ClearAttachmentData {
    color_depth_clear1: Vec<vk::ClearAttachment>,
    color_depth_clear2: Vec<vk::ClearAttachment>,
    stencil_clear1: vk::ClearAttachment,
    stencil_clear2: vk::ClearAttachment,
    rect_color_depth1: vk::ClearRect,
    rect_color_depth2: vk::ClearRect,
    rect_stencil1: vk::ClearRect,
    rect_stencil2: vk::ClearRect,
}

fn clear_rect(x: i32, y: i32, width: u32, height: u32) -> vk::ClearRect {
    vk::ClearRect {
        rect: make_rect_2d(x, y, width, height),
        base_array_layer: 0,
        layer_count: 1,
    }
}

fn clear_value_depth_stencil(depth: f32, stencil: u32) -> vk::ClearValue {
    vk::ClearValue {
        depth_stencil: vk::ClearDepthStencilValue { depth, stencil },
    }
}

impl ClearAttachmentData {
    fn new(color_atch_count: u32, depth: vk::Format, stencil: vk::Format) -> Self {
        let mut color_depth_clear1 = Vec::new();
        let mut color_depth_clear2 = Vec::new();
        let mut stencil_clear1 = vk::ClearAttachment::default();
        let mut stencil_clear2 = vk::ClearAttachment::default();

        for atch_ndx in 0..color_atch_count {
            let blue = atch_ndx as f32 * 0.15;
            let green = vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                color_attachment: atch_ndx,
                clear_value: vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 1.0, blue, 1.0],
                    },
                },
            };
            color_depth_clear1.push(green);

            let yellow = vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                color_attachment: atch_ndx,
                clear_value: vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [1.0, 1.0, blue, 1.0],
                    },
                },
            };
            color_depth_clear2.push(yellow);
        }

        if depth != vk::Format::UNDEFINED {
            color_depth_clear1.push(vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::DEPTH,
                color_attachment: 0,
                clear_value: clear_value_depth_stencil(0.0, 0),
            });
            color_depth_clear2.push(vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::DEPTH,
                color_attachment: 0,
                clear_value: clear_value_depth_stencil(0.2, 0),
            });
        }

        if stencil != vk::Format::UNDEFINED {
            stencil_clear1 = vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::STENCIL,
                color_attachment: 0,
                clear_value: clear_value_depth_stencil(0.0, 1),
            };
            stencil_clear2 = vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::STENCIL,
                color_attachment: 0,
                clear_value: clear_value_depth_stencil(0.0, 2),
            };
        }

        Self {
            color_depth_clear1,
            color_depth_clear2,
            stencil_clear1,
            stencil_clear2,
            rect_color_depth1: clear_rect(0, 0, 16, 32),
            rect_color_depth2: clear_rect(16, 0, 16, 32),
            rect_stencil1: clear_rect(0, 0, 32, 16),
            rect_stencil2: clear_rect(0, 16, 32, 16),
        }
    }
}

/// `getSupportedStencilFormat`
fn get_supported_stencil_format(context: &Context<'_>) -> vk::Format {
    let requirements = vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;

    for format in [vk::Format::D24_UNORM_S8_UINT, vk::Format::D32_SFLOAT_S8_UINT] {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if properties.optimal_tiling_features.contains(requirements) {
            return format;
        }
    }

    vk::Format::UNDEFINED
}

fn make_image_create_info(format: vk::Format, size: (u32, u32), usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
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
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// `makeGraphicsPipeline`
#[allow(clippy::too_many_arguments)]
fn make_graphics_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    render_size: (u32, u32),
    color_attachment_count: usize,
    color_attachment_formats: &[vk::Format; COLOR_ATTACHMENTS_NUMBER],
    depth_attachment_format: vk::Format,
    stencil_attachment_format: vk::Format,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let vertex_input_binding_descriptions = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: 16,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let vertex_input_attribute_descriptions = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    let vertex_input_state_info = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&vertex_input_binding_descriptions)
        .vertex_attribute_descriptions(&vertex_input_attribute_descriptions);

    let pipeline_input_assembly_state_info = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .primitive_restart_enable(false);

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: render_size.0 as f32,
        height: render_size.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, render_size.0, render_size.1)];
    let pipeline_viewport_state_info = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);

    let pipeline_rasterization_state_info = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);

    let pipeline_multisample_state_info = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(0.0);

    let stencil_op = vk::StencilOpState {
        fail_op: vk::StencilOp::ZERO,                      // stencil fail
        pass_op: vk::StencilOp::INCREMENT_AND_CLAMP,       // depth & stencil pass
        depth_fail_op: vk::StencilOp::INCREMENT_AND_CLAMP, // depth only fail
        compare_op: vk::CompareOp::NOT_EQUAL,
        compare_mask: 240,
        write_mask: 255,
        reference: 255,
    };

    let use_depth = depth_attachment_format != vk::Format::UNDEFINED;
    let use_stencil = stencil_attachment_format != vk::Format::UNDEFINED;

    let pipeline_depth_stencil_state_info = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(use_depth)
        .depth_write_enable(use_depth)
        .depth_compare_op(vk::CompareOp::ALWAYS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(use_stencil)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    let color_blend_attachment_state: Vec<vk::PipelineColorBlendAttachmentState> = (0..color_attachment_count)
        .map(|_| vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::FALSE,
            src_color_blend_factor: vk::BlendFactor::ONE,
            dst_color_blend_factor: vk::BlendFactor::ZERO,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ONE,
            dst_alpha_blend_factor: vk::BlendFactor::ZERO,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::all(),
        })
        .collect();

    let pipeline_color_blend_state_info = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::COPY)
        .attachments(&color_blend_attachment_state)
        .blend_constants([0.0; 4]);

    let shader_stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vertex_module)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(fragment_module)
            .name(b"main\0")
            .build(),
    ];

    let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
        .view_mask(0)
        .color_attachment_formats(&color_attachment_formats[..color_attachment_count])
        .depth_attachment_format(depth_attachment_format)
        .stencil_attachment_format(stencil_attachment_format);

    let graphics_pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&shader_stages)
        .vertex_input_state(&vertex_input_state_info)
        .input_assembly_state(&pipeline_input_assembly_state_info)
        .viewport_state(&pipeline_viewport_state_info)
        .rasterization_state(&pipeline_rasterization_state_info)
        .multisample_state(&pipeline_multisample_state_info)
        .depth_stencil_state(&pipeline_depth_stencil_state_info)
        .color_blend_state(&pipeline_color_blend_state_info)
        .layout(pipeline_layout)
        .subpass(0)
        .base_pipeline_index(0)
        .push_next(&mut rendering_create_info);

    let pipelines =
        unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[graphics_pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `submitCommandsAndWait` for two command buffers.
fn submit_commands_and_wait2(
    device: &Device,
    queue: vk::Queue,
    command_buffer: vk::CommandBuffer,
    command_buffer2: vk::CommandBuffer,
) -> Result<(), TestError> {
    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    let cmd_buffers = [command_buffer, command_buffer2];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);

    unsafe {
        device
            .queue_submit(queue, &[submit_info], *fence)
            .vk_check("vkQueueSubmit")?;
        device
            .wait_for_fences(&[*fence], true, u64::MAX)
            .vk_check("vkWaitForFences")?;
    }
    Ok(())
}

fn submit_commands_and_wait1(
    device: &Device,
    queue: vk::Queue,
    command_buffer: vk::CommandBuffer,
) -> Result<(), TestError> {
    crate::vk::cmd_util::submit_commands_and_wait(device, queue, command_buffer)
}

/// The secondary command buffer begin of `beginSecondaryCmdBuffer(vk, cmd, renderingFlags, colorAttachmentCount, imagesFormat)`, with
/// the formats spelled out so the partial binding tests can leave an aspect out.
fn begin_secondary_cmd_buffer_with_rendering(
    device: &Device,
    command_buffer: vk::CommandBuffer,
    rendering_flags: vk::RenderingFlags,
    color_formats: &[vk::Format],
    depth: vk::Format,
    stencil: vk::Format,
) -> Result<(), TestError> {
    let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
        .flags(rendering_flags)
        .view_mask(0)
        .color_attachment_formats(color_formats)
        .depth_attachment_format(depth)
        .stencil_attachment_format(stencil)
        .rasterization_samples(vk::SampleCountFlags::_1);

    let buffer_inheritance_info = vk::CommandBufferInheritanceInfo::builder()
        .occlusion_query_enable(false)
        .push_next(&mut inheritance_rendering_info);

    let command_buf_begin_params = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
        .inheritance_info(&buffer_inheritance_info);
    unsafe { device.begin_command_buffer(command_buffer, &command_buf_begin_params) }.vk_check("vkBeginCommandBuffer")
}

/// `beginSecondaryCmdBuffer(vk, commandBuffer)`: a secondary command buffer that is not a render pass continuation.
fn begin_secondary_cmd_buffer_plain(device: &Device, command_buffer: vk::CommandBuffer) -> Result<(), TestError> {
    let buffer_inheritance_info = vk::CommandBufferInheritanceInfo::builder().occlusion_query_enable(false);
    let command_buf_begin_params = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
        .inheritance_info(&buffer_inheritance_info);
    unsafe { device.begin_command_buffer(command_buffer, &command_buf_begin_params) }.vk_check("vkBeginCommandBuffer")
}

/// How much of a pass's operations a render pass instance records.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Part {
    All,
    First,
    Second,
}

/// What a pass records: three draws (vertex offsets 8, 0 and 4), or the two halves of the `vkCmdClearAttachments` sequence.
enum PassOps<'b> {
    Draw { pipeline: vk::Pipeline },
    Clear(&'b ClearAttachmentData),
}

/// Where the commands of a render pass instance are recorded.
enum Contents {
    Inline,
    /// Secondary command buffers (index, part), executed inside the instance with CONTENTS_SECONDARY_COMMAND_BUFFERS.
    Secondary(Vec<(usize, Part)>),
}

/// One render pass instance of a scenario.
struct RenderInstance {
    primary: usize,
    /// SUSPENDING / RESUMING.
    flags: vk::RenderingFlags,
    contents: Contents,
    part: Part,
}

/// A command buffer layout, `TestType` by `TestType` (see the header comment).
enum Scenario {
    /// The render pass instances are begun and ended in primary command buffers.
    Primary(Vec<RenderInstance>),
    /// Secondary command buffers begin and end rendering themselves: (flags, part) each, executed from the listed primaries.
    SecondaryRendering {
        secondaries: Vec<(vk::RenderingFlags, Part)>,
        primaries: Vec<Vec<usize>>,
    },
    /// One secondary command buffer holding the whole of a pass - barrier, rendering and copy - executed from a primary.
    SecondaryOutOfRendering,
}

fn scenario_for(test_type: TestType) -> Option<Scenario> {
    let suspending = vk::RenderingFlags::SUSPENDING;
    let resuming = vk::RenderingFlags::RESUMING;
    let none = vk::RenderingFlags::empty();

    let inline = |primary: usize, flags: vk::RenderingFlags, part: Part| RenderInstance {
        primary,
        flags,
        contents: Contents::Inline,
        part,
    };
    let secondary = |primary: usize, flags: vk::RenderingFlags, buffers: Vec<(usize, Part)>| RenderInstance {
        primary,
        flags,
        contents: Contents::Secondary(buffers),
        part: Part::All,
    };

    Some(match test_type {
        TestType::SingleCmdbuf => Scenario::Primary(vec![inline(0, none, Part::All)]),
        TestType::SingleCmdbufResuming => Scenario::Primary(vec![
            inline(0, suspending, Part::First),
            inline(0, resuming, Part::Second),
        ]),
        TestType::TwoCmdbufResuming => Scenario::Primary(vec![
            inline(0, suspending, Part::First),
            inline(1, resuming, Part::Second),
        ]),
        TestType::SecondaryCmdbufResuming => Scenario::SecondaryRendering {
            secondaries: vec![(suspending, Part::First), (resuming, Part::Second)],
            primaries: vec![vec![0, 1]],
        },
        TestType::SecondaryCmdbufTwoPrimaryResuming => Scenario::SecondaryRendering {
            secondaries: vec![(suspending, Part::First), (resuming, Part::Second)],
            primaries: vec![vec![0], vec![1]],
        },
        TestType::ContentsSecondaryCommandBuffer => Scenario::Primary(vec![secondary(0, none, vec![(0, Part::All)])]),
        TestType::Contents2SecondaryCommandBuffer => {
            Scenario::Primary(vec![secondary(0, none, vec![(0, Part::First), (1, Part::Second)])])
        }
        TestType::Contents2SecondaryCommandBufferResuming => Scenario::Primary(vec![
            secondary(0, suspending, vec![(0, Part::First)]),
            secondary(0, resuming, vec![(1, Part::Second)]),
        ]),
        TestType::Contents2Secondary2PrimaryCmdbufResuming => Scenario::Primary(vec![
            secondary(0, suspending, vec![(0, Part::First)]),
            secondary(1, resuming, vec![(1, Part::Second)]),
        ]),
        TestType::ContentsPrimarySecondaryCmdbufResuming => Scenario::Primary(vec![
            inline(0, suspending, Part::First),
            secondary(0, resuming, vec![(0, Part::Second)]),
        ]),
        TestType::ContentsSecondaryPrimaryCmdbufResuming => Scenario::Primary(vec![
            secondary(0, suspending, vec![(0, Part::First)]),
            inline(0, resuming, Part::Second),
        ]),
        TestType::Contents2PrimarySecondaryCmdbufResuming => Scenario::Primary(vec![
            inline(0, suspending, Part::First),
            secondary(1, resuming, vec![(0, Part::Second)]),
        ]),
        TestType::ContentsSecondary2PrimaryCmdbufResuming => Scenario::Primary(vec![
            secondary(0, suspending, vec![(0, Part::First)]),
            inline(1, resuming, Part::Second),
        ]),
        TestType::SecondaryCmdbufOutOfRenderingCommands => Scenario::SecondaryOutOfRendering,
        TestType::PartialBindingDepthStencil => return None,
    })
}

/// What the references are: the colour/depth/stencil values the three draws and the clears are expected to leave.
#[derive(Clone, Copy)]
enum DepthRef {
    /// Left half 0.0, right half the value (`generateDepthImage`).
    SplitLeftRight(f32),
    Constant(f32),
}

#[derive(Clone, Copy)]
enum StencilRef {
    /// Top half 1, bottom half the value (`generateStencilImage`).
    SplitTopBottom(u32),
    Constant(u32),
}

/// `copyImageToBuffer` with separate barrier and copy aspects, and the default `ALL_COMMANDS` source stage.
#[allow(clippy::too_many_arguments)]
fn copy_image_to_buffer_aspect(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: (u32, u32),
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    barrier_aspect: vk::ImageAspectFlags,
    copy_aspect: vk::ImageAspectFlags,
) {
    let transfer_layout = if old_layout == vk::ImageLayout::GENERAL {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
    };

    let image_barrier = make_image_memory_barrier(
        src_access_mask,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        transfer_layout,
        image,
        make_image_subresource_range(barrier_aspect, 0, 1, 0, 1),
    );
    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: vk::ImageSubresourceLayers {
            aspect_mask: copy_aspect,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        },
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        },
    };
    let buffer_barrier = vk::BufferMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::HOST_READ)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .buffer(buffer)
        .offset(0)
        .size(vk::WHOLE_SIZE)
        .build();

    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
        device.cmd_copy_image_to_buffer(cmd_buffer, image, transfer_layout, buffer, &[region]);
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

struct DynamicRenderingTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: TestParameters,
    format_stencil_depth_image: vk::Format,
    image_color: Vec<ImageWithMemory<'a>>,
    image_stencil_depth: ImageWithMemory<'a>,
    color_attachment_view: Vec<Unique<'a, vk::ImageView>>,
    stencil_depth_attachment_view: Unique<'a, vk::ImageView>,
    image_buffer: Vec<BufferWithMemory<'a>>,
    image_depth_buffer: BufferWithMemory<'a>,
    image_stencil_buffer: BufferWithMemory<'a>,
    vertex_module: Unique<'a, vk::ShaderModule>,
    fragment_module: Unique<'a, vk::ShaderModule>,
    vertex_buffer: BufferWithMemory<'a>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    /// Declared after the objects that are recorded into, so the pool outlives the command buffers allocated from it.
    primary_cmd_buffers: Vec<UniqueCommandBuffer<'a>>,
    secondary_cmd_buffers: Vec<UniqueCommandBuffer<'a>>,
    #[allow(dead_code)]
    cmd_pool: Unique<'a, vk::CommandPool>,
}

impl<'a> DynamicRenderingTestInstance<'a> {
    /// The constructor, `initialize` and `createCmdBuffer`, with the second primary and the two secondary command buffers every
    /// layout but the first needs.
    fn new(context: &'a Context<'a>, parameters: TestParameters) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        let mut features = vk::PhysicalDeviceDynamicRenderingFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if features.dynamic_rendering == vk::FALSE {
            return Err(TestError::Fail("dynamicRendering is not supported".to_string()));
        }

        // Vertices: a quad covering the whole render area, in three draws.
        let vertices: [[f32; 4]; 12] = [
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [0.0, -1.0, 0.0, 1.0],
            [1.0, -1.0, 0.2, 1.0],
            [0.0, -1.0, 0.2, 1.0],
            [1.0, 1.0, 0.2, 1.0],
            [0.0, 1.0, 0.2, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
        ];
        let vertex_buffer_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr(),
                vertex_buffer.get_allocation().get_host_ptr().cast::<[f32; 4]>(),
                vertices.len(),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Images color attachment.
        let image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let pixel_size = crate::tcu::map_vk_format(parameters.image_format)
            .and_then(|f| f.pixel_size())
            .ok_or_else(|| TestError::InternalError("no pixel size".to_string()))?;
        let image_buffer_size = (parameters.render_size.0 * parameters.render_size.1 * pixel_size) as vk::DeviceSize;
        let image_subresource = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let mut image_color = Vec::new();
        let mut color_attachment_view = Vec::new();
        let mut image_buffer = Vec::new();
        for _ndx in 0..COLOR_ATTACHMENTS_NUMBER {
            let image = ImageWithMemory::new(
                device,
                allocator,
                make_image_create_info(parameters.image_format, parameters.render_size, image_usage),
                MemoryRequirement::ANY,
            )?;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(image_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                parameters.image_format,
                image_subresource,
            )?;

            let alloc = buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, image_buffer_size as usize) };
            flush_alloc(device, alloc)?;

            image_color.push(image);
            color_attachment_view.push(view);
            image_buffer.push(buffer);
        }

        // Image stencil and depth attachment.
        let format_stencil_depth_image = get_supported_stencil_format(context);
        if format_stencil_depth_image == vk::Format::UNDEFINED {
            return Err(TestError::NotSupported("No supported depth/stencil format".to_string()));
        }

        let image_depth_stencil_aspect = vk::ImageAspectFlags::STENCIL | vk::ImageAspectFlags::DEPTH;
        let image_stencil_subresource = make_image_subresource_range(image_depth_stencil_aspect, 0, 1, 0, 1);
        let image_buffer_stencil_size = (parameters.render_size.0 * parameters.render_size.1) as vk::DeviceSize;
        let image_buffer_depth_size = (parameters.render_size.0 * parameters.render_size.1 * 4) as vk::DeviceSize;

        let image_stencil_depth_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let image_stencil_depth = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                format_stencil_depth_image,
                parameters.render_size,
                image_stencil_depth_usage,
            ),
            MemoryRequirement::ANY,
        )?;

        let image_stencil_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(image_buffer_stencil_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let image_depth_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(image_buffer_depth_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let stencil_depth_attachment_view = make_image_view(
            device,
            image_stencil_depth.get(),
            vk::ImageViewType::_2D,
            format_stencil_depth_image,
            image_stencil_subresource,
        )?;

        for (buffer, size) in [
            (&image_stencil_buffer, image_buffer_stencil_size),
            (&image_depth_buffer, image_buffer_depth_size),
        ] {
            let alloc = buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, size as usize) };
            flush_alloc(device, alloc)?;
        }

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let vertex_module = create_shader_module(device, context.get_binary_collection().get("vert")?)?;
        let fragment_module = create_shader_module(device, context.get_binary_collection().get("frag")?)?;

        let cmd_pool = {
            let info = vk::CommandPoolCreateInfo::builder()
                .flags(vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)
                .queue_family_index(context.get_universal_queue_family_index());
            Unique::new(
                device,
                unsafe { device.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?,
            )
        };
        let primary_cmd_buffers = vec![
            allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?,
            allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?,
        ];
        let secondary_cmd_buffers = vec![
            allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?,
            allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?,
        ];

        Ok(Self {
            context,
            parameters,
            format_stencil_depth_image,
            image_color,
            image_stencil_depth,
            color_attachment_view,
            stencil_depth_attachment_view,
            image_buffer,
            image_depth_buffer,
            image_stencil_buffer,
            vertex_module,
            fragment_module,
            vertex_buffer,
            pipeline_layout,
            primary_cmd_buffers,
            secondary_cmd_buffers,
            cmd_pool,
        })
    }

    fn device(&self) -> &'a Device {
        self.context.get_device()
    }

    fn primary(&self, ndx: usize) -> vk::CommandBuffer {
        self.primary_cmd_buffers[ndx].get()
    }

    fn secondary(&self, ndx: usize) -> vk::CommandBuffer {
        self.secondary_cmd_buffers[ndx].get()
    }

    /// `DynamicRenderingTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let device = self.device();

        let mut images_layout = ImagesLayout {
            old_colors: [vk::ImageLayout::UNDEFINED; COLOR_ATTACHMENTS_NUMBER],
            old_stencil: vk::ImageLayout::UNDEFINED,
            old_depth: vk::ImageLayout::UNDEFINED,
        };

        for attachment_test in TEST_ATTACHMENT_TYPES
            .iter()
            .copied()
            .filter(|t| *t != TestAttachmentType::Last)
        {
            // If we provide an explicit attachment test type in the parameters, run only that one; if not, run them all.
            if self.parameters.test_attachment_type != TestAttachmentType::Last
                && attachment_test != self.parameters.test_attachment_type
            {
                continue;
            }

            let mut attachment_bind_infos: Vec<vk::ImageView> = Vec::new();

            let mut images_format = ImagesFormat {
                colors: [self.parameters.image_format; COLOR_ATTACHMENTS_NUMBER],
                depth: self.format_stencil_depth_image,
                stencil: self.format_stencil_depth_image,
            };

            let mut color_atch_count = 0usize;

            match attachment_test {
                TestAttachmentType::SingleColor => {
                    attachment_bind_infos.push(*self.color_attachment_view[0]);
                    images_format.depth = vk::Format::UNDEFINED;
                    images_format.stencil = vk::Format::UNDEFINED;
                    color_atch_count = 1;
                }
                TestAttachmentType::DepthAttachment => {
                    attachment_bind_infos.push(*self.stencil_depth_attachment_view);
                    images_format.colors[0] = vk::Format::UNDEFINED;
                    images_format.stencil = vk::Format::UNDEFINED;
                }
                TestAttachmentType::StencilAttachment => {
                    attachment_bind_infos.push(*self.stencil_depth_attachment_view);
                    images_format.colors[0] = vk::Format::UNDEFINED;
                    images_format.depth = vk::Format::UNDEFINED;
                }
                TestAttachmentType::MultipleColor => {
                    for ndx in 0..COLOR_ATTACHMENTS_NUMBER {
                        attachment_bind_infos.push(*self.color_attachment_view[ndx]);
                    }

                    color_atch_count = COLOR_ATTACHMENTS_NUMBER;
                    images_format.depth = vk::Format::UNDEFINED;
                    images_format.stencil = vk::Format::UNDEFINED;
                }
                TestAttachmentType::None => {
                    images_format.depth = vk::Format::UNDEFINED;
                    images_format.stencil = vk::Format::UNDEFINED;
                }
                TestAttachmentType::All => {
                    for ndx in 0..COLOR_ATTACHMENTS_NUMBER {
                        attachment_bind_infos.push(*self.color_attachment_view[ndx]);
                    }

                    attachment_bind_infos.push(*self.stencil_depth_attachment_view);
                    attachment_bind_infos.push(*self.stencil_depth_attachment_view);

                    color_atch_count = COLOR_ATTACHMENTS_NUMBER;
                }
                TestAttachmentType::Last => continue,
            }

            let pipeline = make_graphics_pipeline(
                device,
                *self.pipeline_layout,
                *self.vertex_module,
                *self.fragment_module,
                self.parameters.render_size,
                color_atch_count,
                &images_format.colors,
                images_format.depth,
                images_format.stencil,
            )?;

            self.rendering(
                *pipeline,
                &attachment_bind_infos,
                color_atch_count,
                &mut images_layout,
                &images_format,
            )?;
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// The `rendering` override of every layout: the draw pass for each load/store op, and for CLEAR/STORE the clear pass as well.
    fn rendering(
        &mut self,
        pipeline: vk::Pipeline,
        attachment_bind_infos: &[vk::ImageView],
        color_atch_count: usize,
        images_layout: &mut ImagesLayout,
        images_format: &ImagesFormat,
    ) -> Result<(), TestError> {
        if self.parameters.test_type == TestType::PartialBindingDepthStencil {
            return self.rendering_partial_binding(
                pipeline,
                attachment_bind_infos,
                color_atch_count,
                images_layout,
                images_format,
            );
        }

        let scenario = scenario_for(self.parameters.test_type)
            .ok_or_else(|| TestError::InternalError("no scenario".to_string()))?;

        for attachment_load_op in 0..TEST_ATTACHMENT_LOAD_OP_LAST {
            for attachment_store_op in 0..TEST_ATTACHMENT_STORE_OP_LAST {
                let load_op = vk::AttachmentLoadOp::from_raw(attachment_load_op);
                let store_op = vk::AttachmentStoreOp::from_raw(attachment_store_op);

                self.run_pass(
                    &scenario,
                    &PassOps::Draw { pipeline },
                    attachment_bind_infos,
                    color_atch_count,
                    images_layout,
                    images_format,
                    load_op,
                    store_op,
                )?;

                if load_op == vk::AttachmentLoadOp::CLEAR && store_op == vk::AttachmentStoreOp::STORE {
                    self.verify_results(color_atch_count, images_format)?;

                    let clear_data =
                        ClearAttachmentData::new(color_atch_count as u32, images_format.depth, images_format.stencil);

                    self.run_pass(
                        &scenario,
                        &PassOps::Clear(&clear_data),
                        attachment_bind_infos,
                        color_atch_count,
                        images_layout,
                        images_format,
                        load_op,
                        store_op,
                    )?;

                    self.verify_results(color_atch_count, images_format)?;
                }
            }
        }
        Ok(())
    }

    /// Records the operations of one part of a pass into `cmd_buffer`. `bind` is the pipeline and vertex buffer bind a draw sequence starts with.
    fn record_ops(
        &self,
        cmd_buffer: vk::CommandBuffer,
        ops: &PassOps<'_>,
        part: Part,
        bind: bool,
        images_format: &ImagesFormat,
    ) {
        let device = self.device();
        match ops {
            PassOps::Draw { pipeline } => {
                if bind {
                    unsafe {
                        device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                        device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[self.vertex_buffer.get()], &[0]);
                    }
                }

                let first_vertices: &[u32] = match part {
                    Part::All => &[8, 0, 4],
                    Part::First => &[8, 0],
                    Part::Second => &[4],
                };
                for &first_vertex in first_vertices {
                    unsafe { device.cmd_draw(cmd_buffer, 4, 1, first_vertex, 0) };
                }
            }
            PassOps::Clear(clear_data) => {
                if part != Part::Second {
                    if !clear_data.color_depth_clear1.is_empty() {
                        unsafe {
                            device.cmd_clear_attachments(
                                cmd_buffer,
                                &clear_data.color_depth_clear1,
                                &[clear_data.rect_color_depth1],
                            )
                        };
                    }

                    if images_format.stencil != vk::Format::UNDEFINED {
                        unsafe {
                            device.cmd_clear_attachments(
                                cmd_buffer,
                                &[clear_data.stencil_clear1],
                                &[clear_data.rect_stencil1],
                            )
                        };
                    }
                }

                if part != Part::First {
                    if !clear_data.color_depth_clear2.is_empty() {
                        unsafe {
                            device.cmd_clear_attachments(
                                cmd_buffer,
                                &clear_data.color_depth_clear2,
                                &[clear_data.rect_color_depth2],
                            )
                        };
                    }

                    if images_format.stencil != vk::Format::UNDEFINED {
                        unsafe {
                            device.cmd_clear_attachments(
                                cmd_buffer,
                                &[clear_data.stencil_clear2],
                                &[clear_data.rect_stencil2],
                            )
                        };
                    }
                }
            }
        }
    }

    /// Records and submits one pass of a scenario.
    #[allow(clippy::too_many_arguments)]
    fn run_pass(
        &self,
        scenario: &Scenario,
        ops: &PassOps<'_>,
        attachment_bind_infos: &[vk::ImageView],
        color_atch_count: usize,
        images_layout: &mut ImagesLayout,
        images_format: &ImagesFormat,
        load_op: vk::AttachmentLoadOp,
        store_op: vk::AttachmentStoreOp,
    ) -> Result<(), TestError> {
        let device = self.device();
        let queue = self.context.get_universal_queue();
        let color_formats: &[vk::Format] = if color_atch_count > 0 {
            &images_format.colors[..color_atch_count]
        } else {
            &[]
        };

        match scenario {
            Scenario::Primary(instances) => {
                // The secondary command buffers are recorded first.
                for instance in instances {
                    if let Contents::Secondary(buffers) = &instance.contents {
                        for &(sec_ndx, part) in buffers {
                            let sec = self.secondary(sec_ndx);
                            begin_secondary_cmd_buffer_with_rendering(
                                device,
                                sec,
                                instance.flags,
                                color_formats,
                                images_format.depth,
                                images_format.stencil,
                            )?;
                            self.record_ops(sec, ops, part, true, images_format);
                            end_command_buffer(device, sec)?;
                        }
                    }
                }

                let num_primaries = instances.iter().map(|i| i.primary).max().unwrap_or(0) + 1;
                let mut recorded_inline = vec![false; num_primaries];
                let mut current_primary: Option<usize> = None;

                for instance in instances {
                    let cmd_buffer = self.primary(instance.primary);

                    if current_primary != Some(instance.primary) {
                        if let Some(previous) = current_primary {
                            end_command_buffer(device, self.primary(previous))?;
                        }
                        begin_command_buffer(device, cmd_buffer)?;
                        if current_primary.is_none() {
                            self.pre_barrier(cmd_buffer, color_atch_count, images_layout, images_format);
                        }
                        current_primary = Some(instance.primary);
                    }

                    let contents_flag = if matches!(instance.contents, Contents::Secondary(_)) {
                        vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
                    } else {
                        vk::RenderingFlags::empty()
                    };
                    self.begin_rendering(
                        cmd_buffer,
                        attachment_bind_infos,
                        instance.flags | contents_flag,
                        color_atch_count,
                        images_format,
                        load_op,
                        store_op,
                    );

                    match &instance.contents {
                        Contents::Inline => {
                            self.record_ops(
                                cmd_buffer,
                                ops,
                                instance.part,
                                !recorded_inline[instance.primary],
                                images_format,
                            );
                            recorded_inline[instance.primary] = true;
                        }
                        Contents::Secondary(buffers) => {
                            let handles: Vec<vk::CommandBuffer> =
                                buffers.iter().map(|&(sec_ndx, _)| self.secondary(sec_ndx)).collect();
                            unsafe { device.cmd_execute_commands(cmd_buffer, &handles) };
                        }
                    }

                    self.end_rendering(cmd_buffer);
                }

                let last = current_primary.ok_or_else(|| TestError::InternalError("empty scenario".to_string()))?;
                self.copy_img_to_buff(self.primary(last), color_atch_count, images_layout, images_format);
                end_command_buffer(device, self.primary(last))?;

                if num_primaries == 1 {
                    submit_commands_and_wait1(device, queue, self.primary(0))?;
                } else {
                    submit_commands_and_wait2(device, queue, self.primary(0), self.primary(1))?;
                }
            }
            Scenario::SecondaryRendering { secondaries, primaries } => {
                for (ndx, &(flags, part)) in secondaries.iter().enumerate() {
                    let sec = self.secondary(ndx);
                    begin_secondary_cmd_buffer_plain(device, sec)?;

                    self.begin_rendering(
                        sec,
                        attachment_bind_infos,
                        flags,
                        color_atch_count,
                        images_format,
                        load_op,
                        store_op,
                    );
                    self.record_ops(sec, ops, part, true, images_format);
                    self.end_rendering(sec);
                    end_command_buffer(device, sec)?;
                }

                for (primary_ndx, executed) in primaries.iter().enumerate() {
                    let cmd_buffer = self.primary(primary_ndx);
                    begin_command_buffer(device, cmd_buffer)?;
                    if primary_ndx == 0 {
                        self.pre_barrier(cmd_buffer, color_atch_count, images_layout, images_format);
                    }

                    let handles: Vec<vk::CommandBuffer> =
                        executed.iter().map(|&sec_ndx| self.secondary(sec_ndx)).collect();
                    unsafe { device.cmd_execute_commands(cmd_buffer, &handles) };

                    if primary_ndx == primaries.len() - 1 {
                        self.copy_img_to_buff(cmd_buffer, color_atch_count, images_layout, images_format);
                    }
                    end_command_buffer(device, cmd_buffer)?;
                }

                if primaries.len() == 1 {
                    submit_commands_and_wait1(device, queue, self.primary(0))?;
                } else {
                    submit_commands_and_wait2(device, queue, self.primary(0), self.primary(1))?;
                }
            }
            Scenario::SecondaryOutOfRendering => {
                let sec = self.secondary(0);
                begin_secondary_cmd_buffer_plain(device, sec)?;

                self.pre_barrier(sec, color_atch_count, images_layout, images_format);

                self.begin_rendering(
                    sec,
                    attachment_bind_infos,
                    vk::RenderingFlags::empty(),
                    color_atch_count,
                    images_format,
                    load_op,
                    store_op,
                );
                self.record_ops(sec, ops, Part::All, true, images_format);
                self.end_rendering(sec);

                self.copy_img_to_buff(sec, color_atch_count, images_layout, images_format);
                end_command_buffer(device, sec)?;

                // Primary command buffer
                let cmd_buffer = self.primary(0);
                begin_command_buffer(device, cmd_buffer)?;
                unsafe { device.cmd_execute_commands(cmd_buffer, &[sec]) };
                end_command_buffer(device, cmd_buffer)?;

                submit_commands_and_wait1(device, queue, cmd_buffer)?;
            }
        }
        Ok(())
    }

    /// `DynamicRenderingTestInstance::preBarier`
    fn pre_barrier(
        &self,
        cmd_buffer: vk::CommandBuffer,
        color_atch_count: usize,
        images_layout: &mut ImagesLayout,
        images_format: &ImagesFormat,
    ) {
        let device = self.device();

        let mut src_stages = vk::PipelineStageFlags::TOP_OF_PIPE;

        let mut barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();

        for ndx in 0..color_atch_count {
            let subresource = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let dst_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ;
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                dst_access,
                images_layout.old_colors[ndx],
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                self.image_color[ndx].get(),
                subresource,
            );
            barriers.push(barrier);
            images_layout.old_colors[ndx] = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
        }

        if images_format.depth != vk::Format::UNDEFINED {
            let prev_xfer = images_layout.old_depth == vk::ImageLayout::TRANSFER_DST_OPTIMAL;
            let src_access = if prev_xfer {
                vk::AccessFlags::TRANSFER_WRITE
            } else {
                vk::AccessFlags::empty()
            };
            let dst_access =
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
            let subresource = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
            let barrier = make_image_memory_barrier(
                src_access,
                dst_access,
                images_layout.old_depth,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                self.image_stencil_depth.get(),
                subresource,
            );
            images_layout.old_depth = vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
            barriers.push(barrier);

            if prev_xfer {
                src_stages |= vk::PipelineStageFlags::TRANSFER;
            }
        }

        if images_format.stencil != vk::Format::UNDEFINED {
            let prev_xfer = images_layout.old_stencil == vk::ImageLayout::TRANSFER_DST_OPTIMAL;
            let src_access = if prev_xfer {
                vk::AccessFlags::TRANSFER_WRITE
            } else {
                vk::AccessFlags::empty()
            };
            let dst_access =
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
            let subresource = make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
            let barrier = make_image_memory_barrier(
                src_access,
                dst_access,
                images_layout.old_stencil,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                self.image_stencil_depth.get(),
                subresource,
            );
            images_layout.old_stencil = vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
            barriers.push(barrier);

            if prev_xfer {
                src_stages |= vk::PipelineStageFlags::TRANSFER;
            }
        }

        let dst_stages = vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
            | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
            | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;

        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                src_stages,
                dst_stages,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &barriers,
            );
        }
    }

    /// `DynamicRenderingTestInstance::beginRendering`
    #[allow(clippy::too_many_arguments)]
    fn begin_rendering(
        &self,
        cmd_buffer: vk::CommandBuffer,
        attachment_bind_infos: &[vk::ImageView],
        flags: vk::RenderingFlags,
        color_atch_count: usize,
        images_format: &ImagesFormat,
        load_op: vk::AttachmentLoadOp,
        store_op: vk::AttachmentStoreOp,
    ) {
        let device = self.device();
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: self.parameters.clear_color,
            },
        };
        let depth_stencil_clear_value =
            clear_value_depth_stencil(self.parameters.depth_clear_value, self.parameters.stencil_clear_value);

        let render_area = make_rect_2d(0, 0, self.parameters.render_size.0, self.parameters.render_size.1);

        let make_attachment = |image_view: vk::ImageView, image_layout: vk::ImageLayout, clear: vk::ClearValue| {
            vk::RenderingAttachmentInfo::builder()
                .image_view(image_view)
                .image_layout(image_layout)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .resolve_image_view(vk::ImageView::null())
                .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                .load_op(load_op)
                .store_op(store_op)
                .clear_value(clear)
                .build()
        };

        let mut attachments: Vec<vk::RenderingAttachmentInfo> = Vec::new();

        for ndx in 0..color_atch_count {
            attachments.push(make_attachment(
                attachment_bind_infos[ndx],
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                clear_value,
            ));
        }

        if images_format.depth != vk::Format::UNDEFINED {
            attachments.push(make_attachment(
                attachment_bind_infos[color_atch_count],
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                depth_stencil_clear_value,
            ));
        }

        let stencil_ndx = color_atch_count + usize::from(images_format.depth != vk::Format::UNDEFINED);

        if images_format.stencil != vk::Format::UNDEFINED {
            attachments.push(make_attachment(
                attachment_bind_infos[stencil_ndx],
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                depth_stencil_clear_value,
            ));
        }

        let mut rendering_info = vk::RenderingInfo::builder()
            .flags(flags)
            .render_area(render_area)
            .layer_count(1)
            .view_mask(0);
        if color_atch_count != 0 {
            rendering_info = rendering_info.color_attachments(&attachments[..color_atch_count]);
        }
        if images_format.depth != vk::Format::UNDEFINED {
            rendering_info = rendering_info.depth_attachment(&attachments[color_atch_count]);
        }
        if images_format.stencil != vk::Format::UNDEFINED {
            rendering_info = rendering_info.stencil_attachment(&attachments[stencil_ndx]);
        }

        unsafe { device.cmd_begin_rendering(cmd_buffer, &rendering_info) };
    }

    /// `DynamicRenderingTestInstance::endRendering`
    fn end_rendering(&self, cmd_buffer: vk::CommandBuffer) {
        let device = self.device();
        if self.parameters.end_rendering2 {
            let rendering_end_info = vk::RenderingEndInfoKHR::default();
            unsafe { device.cmd_end_rendering2_khr(cmd_buffer, Some(&rendering_end_info)) };
        } else {
            unsafe { device.cmd_end_rendering(cmd_buffer) };
        }
    }

    /// `DynamicRenderingTestInstance::copyImgToBuff`
    fn copy_img_to_buff(
        &self,
        cmd_buffer: vk::CommandBuffer,
        color_atch_count: usize,
        images_layout: &mut ImagesLayout,
        images_format: &ImagesFormat,
    ) {
        let device = self.device();
        let size = self.parameters.render_size;

        if images_format.colors[0] != vk::Format::UNDEFINED {
            for ndx in 0..color_atch_count {
                copy_image_to_buffer_aspect(
                    device,
                    cmd_buffer,
                    self.image_color[ndx].get(),
                    self.image_buffer[ndx].get(),
                    size,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    images_layout.old_colors[ndx],
                    vk::ImageAspectFlags::COLOR,
                    vk::ImageAspectFlags::COLOR,
                );
                images_layout.old_colors[ndx] = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
            }
        }
        if images_format.depth != vk::Format::UNDEFINED {
            copy_image_to_buffer_aspect(
                device,
                cmd_buffer,
                self.image_stencil_depth.get(),
                self.image_depth_buffer.get(),
                size,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                images_layout.old_depth,
                vk::ImageAspectFlags::DEPTH,
                vk::ImageAspectFlags::DEPTH,
            );
            images_layout.old_depth = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
        }
        if images_format.stencil != vk::Format::UNDEFINED {
            copy_image_to_buffer_aspect(
                device,
                cmd_buffer,
                self.image_stencil_depth.get(),
                self.image_stencil_buffer.get(),
                size,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                images_layout.old_stencil,
                vk::ImageAspectFlags::STENCIL,
                vk::ImageAspectFlags::STENCIL,
            );
            images_layout.old_stencil = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
        }
    }

    /// `DynamicRenderingTestInstance::verifyResults`
    fn verify_results(&self, color_atch_count: usize, images_format: &ImagesFormat) -> Result<(), TestError> {
        let device = self.device();
        let (width, height) = self.parameters.render_size;

        if images_format.colors[0] != vk::Format::UNDEFINED {
            for ndx in 0..color_atch_count {
                let alloc = self.image_buffer[ndx].get_allocation();
                invalidate_alloc(device, alloc)?;
                let result = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), (width * height * 4) as usize) };

                // generateColorImage: the left half green, the right half yellow, the blue channel 0.15 times the attachment index.
                let blue = ((ndx as f32 * 0.15) * 255.0).round() as i32;
                for y in 0..height {
                    for x in 0..width {
                        let expected: [i32; 4] = if x < width / 2 {
                            [0, 255, blue, 255]
                        } else {
                            [255, 255, blue, 255]
                        };
                        let pixel = &result[((y * width + x) * 4) as usize..][..4];
                        // The threshold is 0.02 of the range.
                        if (0..4).any(|c| (expected[c] - pixel[c] as i32).abs() as f32 / 255.0 > 0.02) {
                            return Err(TestError::Fail("Rendered color image is not correct".to_string()));
                        }
                    }
                }
            }
        }

        if images_format.depth != vk::Format::UNDEFINED {
            self.verify_depth(DepthRef::SplitLeftRight(0.2))?;
        }

        if images_format.stencil != vk::Format::UNDEFINED {
            self.verify_stencil(StencilRef::SplitTopBottom(2))?;
        }
        Ok(())
    }

    /// `DynamicRenderingTestInstance::verifyDepth`
    fn verify_depth(&self, reference: DepthRef) -> Result<(), TestError> {
        let device = self.device();
        let (width, height) = self.parameters.render_size;

        let alloc = self.image_depth_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let result = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), (width * height * 4) as usize) };

        for y in 0..height {
            for x in 0..width {
                let expected = match reference {
                    DepthRef::SplitLeftRight(value) => {
                        if x < width / 2 {
                            0.0
                        } else {
                            value
                        }
                    }
                    DepthRef::Constant(value) => value,
                };
                let word = u32::from_ne_bytes(
                    result[((y * width + x) * 4) as usize..][..4]
                        .try_into()
                        .unwrap_or([0; 4]),
                );

                let ok = if self.format_stencil_depth_image == vk::Format::D24_UNORM_S8_UINT {
                    // The 24 bit values have to match exactly.
                    (word & 0x00FF_FFFF) == (expected * 16_777_215.0).round() as u32
                } else {
                    (f32::from_bits(word) - expected).abs() <= 0.02
                };
                if !ok {
                    return Err(TestError::Fail("Rendered depth image is not correct".to_string()));
                }
            }
        }
        Ok(())
    }

    /// `DynamicRenderingTestInstance::verifyStencil`
    fn verify_stencil(&self, reference: StencilRef) -> Result<(), TestError> {
        let device = self.device();
        let (width, height) = self.parameters.render_size;

        let alloc = self.image_stencil_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let result = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), (width * height) as usize) };

        for y in 0..height {
            for x in 0..width {
                let expected = match reference {
                    StencilRef::SplitTopBottom(value) => {
                        if y < height / 2 {
                            1
                        } else {
                            value
                        }
                    }
                    StencilRef::Constant(value) => value,
                };
                if result[(y * width + x) as usize] as u32 != expected {
                    return Err(TestError::Fail("Rendered stencil image is not correct".to_string()));
                }
            }
        }
        Ok(())
    }

    // -----------------------------------------------------------------------------------------------------------------------------
    // PartialBindingDepthStencil
    // -----------------------------------------------------------------------------------------------------------------------------

    /// `PartialBindingDepthStencil::recordRenderingCommands`
    fn record_rendering_commands(
        &self,
        cmd_buffer: vk::CommandBuffer,
        load_op: vk::AttachmentLoadOp,
        pipeline: vk::Pipeline,
        clear_values: vk::ClearAttachment,
        clear_rect: vk::ClearRect,
        clear_only: bool,
    ) {
        let device = self.device();
        if load_op == vk::AttachmentLoadOp::LOAD {
            unsafe { device.cmd_clear_attachments(cmd_buffer, &[clear_values], &[clear_rect]) };
        }

        if !clear_only {
            unsafe {
                device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
                device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[self.vertex_buffer.get()], &[0]);

                device.cmd_draw(cmd_buffer, 4, 1, 8, 0);
                device.cmd_draw(cmd_buffer, 4, 1, 0, 0);
                device.cmd_draw(cmd_buffer, 4, 1, 4, 0);
            }
        }
    }

    /// The "Clear before we start rendering with a different value to ensure unbound one is not modified when rendering" block.
    fn clear_depth_stencil_before_rendering(
        &self,
        cmd_buffer: vk::CommandBuffer,
        images_layout: &mut ImagesLayout,
        depth_stencil_clear: vk::ClearDepthStencilValue,
    ) {
        let device = self.device();
        let subresource =
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
        let pre_clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            images_layout.old_depth,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            self.image_stencil_depth.get(),
            subresource,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_clear_barrier],
            );
        }
        images_layout.old_depth = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
        images_layout.old_stencil = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
        unsafe {
            device.cmd_clear_depth_stencil_image(
                cmd_buffer,
                self.image_stencil_depth.get(),
                images_layout.old_depth,
                &depth_stencil_clear,
                &[subresource],
            )
        };
    }

    /// The "Copy images" block that ends both partial binding tests.
    fn copy_depth_stencil_images(&self, cmd_buffer: vk::CommandBuffer, images_layout: &mut ImagesLayout) {
        let device = self.device();
        let size = self.parameters.render_size;

        let prev_depth_xfer = images_layout.old_depth == vk::ImageLayout::TRANSFER_DST_OPTIMAL;
        let prev_stencil_xfer = images_layout.old_stencil == vk::ImageLayout::TRANSFER_DST_OPTIMAL;
        let src_access_depth = vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            | if prev_depth_xfer {
                vk::AccessFlags::TRANSFER_WRITE
            } else {
                vk::AccessFlags::empty()
            };
        let src_access_stencil = vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            | if prev_stencil_xfer {
                vk::AccessFlags::TRANSFER_WRITE
            } else {
                vk::AccessFlags::empty()
            };

        copy_image_to_buffer_aspect(
            device,
            cmd_buffer,
            self.image_stencil_depth.get(),
            self.image_depth_buffer.get(),
            size,
            src_access_depth,
            images_layout.old_depth,
            vk::ImageAspectFlags::DEPTH,
            vk::ImageAspectFlags::DEPTH,
        );
        images_layout.old_depth = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;

        copy_image_to_buffer_aspect(
            device,
            cmd_buffer,
            self.image_stencil_depth.get(),
            self.image_stencil_buffer.get(),
            size,
            src_access_stencil,
            images_layout.old_stencil,
            vk::ImageAspectFlags::STENCIL,
            vk::ImageAspectFlags::STENCIL,
        );
        images_layout.old_stencil = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
    }

    /// `PartialBindingDepthStencil::baseTest`
    fn base_test(
        &self,
        pipeline: vk::Pipeline,
        attachment_bind_infos: &[vk::ImageView],
        color_atch_count: usize,
        images_layout: &mut ImagesLayout,
        images_format: &ImagesFormat,
        base_test_params: PartialBindDsForBase,
    ) -> Result<(), TestError> {
        let load_op = base_test_params.load_op;
        let use_secondary = base_test_params.use_secondary;
        let clear_only = base_test_params.clear_only;

        let device = self.device();
        let queue = self.context.get_universal_queue();

        let uses_depth = images_format.depth != vk::Format::UNDEFINED;
        let uses_stencil = images_format.stencil != vk::Format::UNDEFINED;

        // Clear values before rendering is started
        let depth_stencil_clear = vk::ClearDepthStencilValue {
            depth: 0.5,
            stencil: 127,
        };

        // Clear values for attachment clear in render pass. Same one as in beginRendering
        let clear_value =
            clear_value_depth_stencil(self.parameters.depth_clear_value, self.parameters.stencil_clear_value);

        // Expected values
        let expected_depth = if uses_depth {
            self.parameters.depth_clear_value
        } else {
            depth_stencil_clear.depth
        };
        let expected_stencil = if uses_stencil {
            self.parameters.stencil_clear_value
        } else {
            depth_stencil_clear.stencil
        };

        // Aspect masks
        let depth_mask = if uses_depth {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::empty()
        };
        let stencil_mask = if uses_stencil {
            vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::empty()
        };

        let clear_values = vk::ClearAttachment {
            aspect_mask: depth_mask | stencil_mask,
            color_attachment: 0,
            clear_value,
        };
        let clear_rect = clear_rect_full(self.parameters.render_size);

        let secondary_cmd_buffer = self.secondary(0);
        let cmd_buffer = self.primary(0);

        if use_secondary {
            begin_secondary_cmd_buffer_with_rendering(
                device,
                secondary_cmd_buffer,
                vk::RenderingFlags::empty(),
                &[],
                images_format.depth,
                images_format.stencil,
            )?;
            self.record_rendering_commands(
                secondary_cmd_buffer,
                load_op,
                pipeline,
                clear_values,
                clear_rect,
                clear_only,
            );
            end_command_buffer(device, secondary_cmd_buffer)?;
        }

        begin_command_buffer(device, cmd_buffer)?;

        // Clear before we start rendering with a different value to ensure unbound one is not modified when rendering
        self.clear_depth_stencil_before_rendering(cmd_buffer, images_layout, depth_stencil_clear);

        self.pre_barrier(cmd_buffer, color_atch_count, images_layout, images_format);

        self.begin_rendering(
            cmd_buffer,
            attachment_bind_infos,
            if use_secondary {
                vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
            } else {
                vk::RenderingFlags::empty()
            },
            color_atch_count,
            images_format,
            load_op,
            vk::AttachmentStoreOp::STORE,
        );

        if use_secondary {
            unsafe { device.cmd_execute_commands(cmd_buffer, &[secondary_cmd_buffer]) };
        } else {
            self.record_rendering_commands(cmd_buffer, load_op, pipeline, clear_values, clear_rect, clear_only);
        }

        self.end_rendering(cmd_buffer);

        self.copy_depth_stencil_images(cmd_buffer, images_layout);

        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait1(device, queue, cmd_buffer)?;

        // Verify depth
        if !clear_only && uses_depth {
            self.verify_depth(DepthRef::SplitLeftRight(0.2))?;
        } else {
            self.verify_depth(DepthRef::Constant(expected_depth))?;
        }

        // Verify stencil
        if !clear_only && uses_stencil {
            self.verify_stencil(StencilRef::SplitTopBottom(2))?;
        } else {
            self.verify_stencil(StencilRef::Constant(expected_stencil))?;
        }
        Ok(())
    }

    /// `PartialBindingDepthStencil::secondaryUndefinedFormatTest`
    fn secondary_undefined_format_test(
        &self,
        pipeline: vk::Pipeline,
        attachment_bind_infos: &[vk::ImageView],
        color_atch_count: usize,
        images_layout: &mut ImagesLayout,
        images_format: &ImagesFormat,
        discard_aspect: vk::ImageAspectFlags,
    ) -> Result<(), TestError> {
        let discard_depth = discard_aspect == vk::ImageAspectFlags::DEPTH;
        let discard_stencil = discard_aspect == vk::ImageAspectFlags::STENCIL;
        // Exactly one must be true.
        if discard_depth == discard_stencil
            || images_format.depth == vk::Format::UNDEFINED
            || images_format.stencil == vk::Format::UNDEFINED
        {
            return Err(TestError::InternalError(
                "secondaryUndefinedFormatTest needs one discarded aspect and both formats".to_string(),
            ));
        }

        let device = self.device();
        let queue = self.context.get_universal_queue();

        // Clear values before rendering is started
        let depth_stencil_clear = vk::ClearDepthStencilValue {
            depth: self.parameters.depth_clear_value,
            stencil: self.parameters.stencil_clear_value,
        };

        // Clear values for attachment clear in render pass. Same one as in beginRendering
        let clear_value =
            clear_value_depth_stencil(self.parameters.depth_clear_value, self.parameters.stencil_clear_value);

        // Expected values
        let expected_depth = self.parameters.depth_clear_value;
        let expected_stencil = self.parameters.stencil_clear_value;

        let clear_values = vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
            color_attachment: 0,
            clear_value,
        };
        let clear_rect = clear_rect_full(self.parameters.render_size);

        let secondary_cmd_buffer = self.secondary(0);
        let cmd_buffer = self.primary(0);

        // beginSecondaryCmdBuffer
        begin_secondary_cmd_buffer_with_rendering(
            device,
            secondary_cmd_buffer,
            vk::RenderingFlags::empty(),
            &images_format.colors,
            if discard_depth {
                vk::Format::UNDEFINED
            } else {
                images_format.depth
            },
            if discard_stencil {
                vk::Format::UNDEFINED
            } else {
                images_format.stencil
            },
        )?;
        self.record_rendering_commands(
            secondary_cmd_buffer,
            vk::AttachmentLoadOp::LOAD,
            pipeline,
            clear_values,
            clear_rect,
            false,
        );
        end_command_buffer(device, secondary_cmd_buffer)?;

        begin_command_buffer(device, cmd_buffer)?;

        // Clear before we start rendering with a different value to ensure unbound one is not modified when rendering
        self.clear_depth_stencil_before_rendering(cmd_buffer, images_layout, depth_stencil_clear);

        self.pre_barrier(cmd_buffer, color_atch_count, images_layout, images_format);

        {
            let mut images_format_copy = *images_format;
            if discard_depth {
                images_format_copy.depth = vk::Format::UNDEFINED;
            }
            if discard_stencil {
                images_format_copy.stencil = vk::Format::UNDEFINED;
            }
            self.begin_rendering(
                cmd_buffer,
                attachment_bind_infos,
                vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS,
                color_atch_count,
                &images_format_copy,
                vk::AttachmentLoadOp::LOAD,
                vk::AttachmentStoreOp::STORE,
            );
        }

        unsafe {
            device.cmd_execute_commands(cmd_buffer, &[secondary_cmd_buffer]);
            device.cmd_end_rendering(cmd_buffer);
        }

        self.copy_depth_stencil_images(cmd_buffer, images_layout);

        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait1(device, queue, cmd_buffer)?;

        // Verify depth
        if !discard_depth {
            self.verify_depth(DepthRef::SplitLeftRight(0.2))?;
        } else {
            self.verify_depth(DepthRef::Constant(expected_depth))?;
        }

        // Verify stencil
        if !discard_stencil {
            self.verify_stencil(StencilRef::SplitTopBottom(2))?;
        } else {
            self.verify_stencil(StencilRef::Constant(expected_stencil))?;
        }
        Ok(())
    }

    /// `PartialBindingDepthStencil::rendering`
    fn rendering_partial_binding(
        &self,
        pipeline: vk::Pipeline,
        attachment_bind_infos: &[vk::ImageView],
        color_atch_count: usize,
        images_layout: &mut ImagesLayout,
        images_format: &ImagesFormat,
    ) -> Result<(), TestError> {
        // Only test when one of both depth or stencil is enabled
        // If no depth/stencil format is available, both will be undefined and therefore pass
        if (images_format.depth != vk::Format::UNDEFINED) ^ (images_format.stencil != vk::Format::UNDEFINED) {
            if let Some(info) = self.parameters.partial_binds_ds_info {
                let PartialBindDsParams::Base(base_test_params) = info else {
                    return Err(TestError::InternalError(
                        "partial binding parameters of the wrong kind".to_string(),
                    ));
                };
                self.base_test(
                    pipeline,
                    attachment_bind_infos,
                    color_atch_count,
                    images_layout,
                    images_format,
                    base_test_params,
                )?;
            } else {
                for load_op in [vk::AttachmentLoadOp::LOAD, vk::AttachmentLoadOp::CLEAR] {
                    // Primary clear only, primary non trivial draw, secondary clear only, secondary non trivial draw
                    for (clear_only, use_secondary) in [(true, false), (false, false), (true, true), (false, true)] {
                        self.base_test(
                            pipeline,
                            attachment_bind_infos,
                            color_atch_count,
                            images_layout,
                            images_format,
                            PartialBindDsForBase {
                                load_op,
                                clear_only,
                                use_secondary,
                            },
                        )?;
                    }
                }
            }
        } else if images_format.depth != vk::Format::UNDEFINED && images_format.stencil != vk::Format::UNDEFINED {
            if let Some(info) = self.parameters.partial_binds_ds_info {
                let PartialBindDsParams::UndefinedFormat { discard_aspect } = info else {
                    return Err(TestError::InternalError(
                        "partial binding parameters of the wrong kind".to_string(),
                    ));
                };
                self.secondary_undefined_format_test(
                    pipeline,
                    attachment_bind_infos,
                    color_atch_count,
                    images_layout,
                    images_format,
                    discard_aspect,
                )?;
            } else {
                // Depth disabled in VkCommandBufferInheritanceRenderingInfo, then stencil
                for discard_aspect in [vk::ImageAspectFlags::DEPTH, vk::ImageAspectFlags::STENCIL] {
                    self.secondary_undefined_format_test(
                        pipeline,
                        attachment_bind_infos,
                        color_atch_count,
                        images_layout,
                        images_format,
                        discard_aspect,
                    )?;
                }
            }
        } else {
            // For TEST_ATTACHMENT_LAST this means we're running different combinations in the same test. If not, we are
            // running a specific combination here and the combination is useless.
            debug_assert!(self.parameters.test_attachment_type == TestAttachmentType::Last);
        }
        Ok(())
    }
}

fn clear_rect_full(render_size: (u32, u32)) -> vk::ClearRect {
    clear_rect(0, 0, render_size.0, render_size.1)
}

struct BaseTestCase {
    name: String,
    parameters: TestParameters,
}

impl TestCase for BaseTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_dynamic_rendering")?;

        if self.parameters.end_rendering2 {
            context.require_device_functionality("VK_KHR_maintenance10")?;
        }

        // VUID-vkCmdDraw-dynamicRenderingUnusedAttachments-08914
        if self.parameters.test_type == TestType::PartialBindingDepthStencil {
            context.require_device_functionality("VK_EXT_dynamic_rendering_unused_attachments")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DYNAMIC_RENDERING_BASIC.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BaseTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

struct BaseTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: TestParameters,
}

impl TestInstance for BaseTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let mut instance = DynamicRenderingTestInstance::new(self.context, self.parameters)?;
        instance.iterate()
    }
}

/// `dynamicRenderingTests`: the case for one parameter set, named after them.
fn dynamic_rendering_test(parameters: TestParameters) -> Box<dyn TestCase> {
    let test_name = TEST_TYPES
        .iter()
        .find(|(t, _)| *t == parameters.test_type)
        .map_or("", |(_, name)| name);

    let mut partial_binding_suffix = String::new();
    if let Some(partial_binds_params) = parameters.partial_binds_ds_info {
        match partial_binds_params {
            PartialBindDsParams::Base(base_test_params) => {
                if base_test_params.load_op == vk::AttachmentLoadOp::CLEAR {
                    partial_binding_suffix += "_load_op_clear";
                } else if base_test_params.load_op == vk::AttachmentLoadOp::LOAD {
                    partial_binding_suffix += "_load_op_load";
                }

                if base_test_params.clear_only {
                    partial_binding_suffix += "_clear_only";
                }

                if base_test_params.use_secondary {
                    partial_binding_suffix += "_use_secondary";
                }
            }
            PartialBindDsParams::UndefinedFormat { discard_aspect } => {
                if discard_aspect == vk::ImageAspectFlags::DEPTH {
                    partial_binding_suffix += "_discard_depth";
                } else if discard_aspect == vk::ImageAspectFlags::STENCIL {
                    partial_binding_suffix += "_discard_stencil";
                }
            }
        }
    }

    // Dynamic Rendering tests
    let final_name = format!(
        "{test_name}{}{partial_binding_suffix}{}",
        test_attachment_type_suffix(parameters.test_attachment_type),
        if parameters.end_rendering2 {
            "_end_rendering_2"
        } else {
            ""
        }
    );
    Box::new(BaseTestCase {
        name: final_name,
        parameters,
    })
}

/// `createDynamicRenderingBasicTests`
pub fn create_dynamic_rendering_basic_tests() -> TestCaseGroup {
    // Basic dynamic rendering tests
    let mut dynamic_rendering_group = TestCaseGroup::new("basic");

    for end_rendering2 in [false, true] {
        for (test_type, _) in TEST_TYPES {
            for test_attachment_type in TEST_ATTACHMENT_TYPES {
                // Skip useless combinations.
                if test_type == TestType::PartialBindingDepthStencil
                    && !good_for_partial_binding_ds(test_attachment_type)
                {
                    continue;
                }

                let mut parameters = TestParameters {
                    test_type,
                    clear_color: [0.0, 0.0, 0.0, 1.0],
                    depth_clear_value: 1.0,
                    stencil_clear_value: 0,
                    image_format: vk::Format::R8G8B8A8_UNORM,
                    render_size: (32, 32),
                    end_rendering2,
                    test_attachment_type,
                    partial_binds_ds_info: None,
                };

                dynamic_rendering_group.add_child(dynamic_rendering_test(parameters));

                if test_type == TestType::PartialBindingDepthStencil && test_attachment_type != TestAttachmentType::Last
                {
                    if matches!(
                        test_attachment_type,
                        TestAttachmentType::DepthAttachment | TestAttachmentType::StencilAttachment
                    ) {
                        for load_op in [vk::AttachmentLoadOp::LOAD, vk::AttachmentLoadOp::CLEAR] {
                            for clear_only in [false, true] {
                                for use_secondary in [false, true] {
                                    parameters.partial_binds_ds_info =
                                        Some(PartialBindDsParams::Base(PartialBindDsForBase {
                                            load_op,
                                            clear_only,
                                            use_secondary,
                                        }));
                                    dynamic_rendering_group.add_child(dynamic_rendering_test(parameters));
                                }
                            }
                        }
                    } else if test_attachment_type == TestAttachmentType::All {
                        for discard_aspect in [vk::ImageAspectFlags::DEPTH, vk::ImageAspectFlags::STENCIL] {
                            parameters.partial_binds_ds_info =
                                Some(PartialBindDsParams::UndefinedFormat { discard_aspect });
                            dynamic_rendering_group.add_child(dynamic_rendering_test(parameters));
                        }
                    }
                }
            }
        }
    }

    dynamic_rendering_group
}

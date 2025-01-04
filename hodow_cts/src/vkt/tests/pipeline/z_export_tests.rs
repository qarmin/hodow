// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleTests.cpp (Z export tests, the `z_export` group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines on a render pass only (upstream adds the dynamic rendering
// variants for the pipeline library construction types alone). The six flag combinations each have their own pre-expanded
// shader pair in the manifest.
//
// The tests enable alpha to coverage statically or dynamically, and play with 3 other parameters, which we can be testing or not
// as outputs from the frag shader: the depth value, the stencil reference value and the sample mask. Alpha values on the left side
// of the framebuffer are 0.0 and on the right side 1.0, so the left side should have no coverage and the right side should.
//
// Expected result: the left side has the clear colour, depth and stencil; the right side has the geometry colour, the expected
// depth and the expected stencil, except that when the sample mask is tested the lower half of the right side is like the left.

use vulkanalia::prelude::v1_2::*;
use vulkanalia::vk::{DeviceV1_3, ExtExtendedDynamicState3ExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::pipeline_z_export::{
    Z_EXPORT_DEPTH, Z_EXPORT_DEPTH_STENCIL, Z_EXPORT_SAMPLE_MASK, Z_EXPORT_SAMPLE_MASK_PIPELINE, Z_EXPORT_STENCIL,
    Z_EXPORT_WRITE_ALL,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::pipeline_util::{
    read_color_attachment, read_depth_attachment, read_stencil_attachment,
};
use crate::vkt::tests::pipeline::shader_object_draw::{end_dynamic_rendering, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const ZEXP_DEPTH_BIT: u32 = 0x1;
/// Requires VK_EXT_shader_stencil_export
const ZEXP_STENCIL_BIT: u32 = 0x2;
const ZEXP_SAMPLE_MASK_SHADER_BIT: u32 = 0x4;
const ZEXP_SAMPLE_MASK_PIPELINE_BIT: u32 = 0x8;

const CLEAR_DEPTH: f32 = 1.0;
const EXPECTED_DEPTH: f32 = 0.0;
const CLEAR_STENCIL: u32 = 0;
const EXPECTED_STENCIL: u32 = 255;
const BAD_STENCIL: u32 = 128;
const WIDTH: u32 = 4;
const HEIGHT: u32 = 4;

#[derive(Clone, Copy)]
struct ZExportParams {
    test_flags: u32,
    dynamic_alpha_to_coverage: bool,
}

impl ZExportParams {
    #[allow(dead_code)]
    fn test_depth(&self) -> bool {
        self.test_flags & ZEXP_DEPTH_BIT != 0
    }

    fn test_stencil(&self) -> bool {
        self.test_flags & ZEXP_STENCIL_BIT != 0
    }

    fn test_sample_mask_shader(&self) -> bool {
        self.test_flags & ZEXP_SAMPLE_MASK_SHADER_BIT != 0
    }

    fn test_sample_mask_pipeline(&self) -> bool {
        self.test_flags & ZEXP_SAMPLE_MASK_PIPELINE_BIT != 0
    }
}

struct ZExportCase {
    name: String,
    params: ZExportParams,
    programs: BinaryCollection,
}

impl TestCase for ZExportCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ZExportCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_create_renderpass2")?;
        context.require_device_functionality("VK_KHR_depth_stencil_resolve")?;

        let mut ds_resolve_properties = vk::PhysicalDeviceDepthStencilResolveProperties::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut ds_resolve_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }

        if !ds_resolve_properties
            .supported_depth_resolve_modes
            .contains(vk::ResolveModeFlags::SAMPLE_ZERO)
        {
            return Err(TestError::NotSupported(
                "VK_RESOLVE_MODE_SAMPLE_ZERO_BIT not supported for depth".to_string(),
            ));
        }

        if !ds_resolve_properties
            .supported_stencil_resolve_modes
            .contains(vk::ResolveModeFlags::SAMPLE_ZERO)
        {
            return Err(TestError::NotSupported(
                "VK_RESOLVE_MODE_SAMPLE_ZERO_BIT not supported for stencil".to_string(),
            ));
        }

        if self.params.test_stencil() {
            context.require_device_functionality("VK_EXT_shader_stencil_export")?;
        }

        if self.params.dynamic_alpha_to_coverage {
            context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;

            let mut eds3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds3_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if eds3_features.extended_dynamic_state3_alpha_to_coverage_enable == vk::FALSE {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3AlphaToCoverageEnable not supported".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ZExportInstance {
            context,
            params: self.params,
        })
    }
}

struct ZExportInstance<'a> {
    context: &'a Context<'a>,
    params: ZExportParams,
}

impl TestInstance for ZExportInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        z_export_iterate(self.context, &self.params)
    }
}

/// `findSupportedDepthStencilFormat` for both aspects
fn find_supported_depth_stencil_format(context: &Context<'_>) -> vk::Format {
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

fn make_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
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

fn attachment_description(
    format: vk::Format,
    samples: vk::SampleCountFlags,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    final_layout: vk::ImageLayout,
) -> vk::AttachmentDescription2 {
    vk::AttachmentDescription2::builder()
        .format(format)
        .samples(samples)
        .load_op(load_op)
        .store_op(store_op)
        .stencil_load_op(stencil_load_op)
        .stencil_store_op(stencil_store_op)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(final_layout)
        .build()
}

/// `ZExportIterate`
fn z_export_iterate<'a>(context: &'a Context<'a>, params: &ZExportParams) -> TestOutcome {
    let device = context.get_device();

    // Choose depth/stencil format.
    let ds_format = find_supported_depth_stencil_format(context);
    if ds_format == vk::Format::UNDEFINED {
        return Err(TestError::Fail(
            "Unable to find supported depth/stencil format".to_string(),
        ));
    }

    let color_format = vk::Format::R8G8B8A8_UNORM;
    let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let ds_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let color_aspect = vk::ImageAspectFlags::COLOR;
    let ds_aspect = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
    let color_srr = make_image_subresource_range(color_aspect, 0, 1, 0, 1);
    let ds_srr = make_image_subresource_range(ds_aspect, 0, 1, 0, 1);
    let sample_count = vk::SampleCountFlags::_4;

    // Multisample color attachment.
    let color_attachment = make_image(context, color_format, sample_count, color_usage)?;
    let color_attachment_view = make_image_view(
        device,
        color_attachment.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_srr,
    )?;

    // Multisample depth/stencil attachment.
    let ds_attachment = make_image(context, ds_format, sample_count, ds_usage)?;
    let ds_attachment_view = make_image_view(device, ds_attachment.get(), vk::ImageViewType::_2D, ds_format, ds_srr)?;

    // Resolve attachments.
    let color_resolve_attachment = make_image(context, color_format, vk::SampleCountFlags::_1, color_usage)?;
    let ds_resolve_attachment = make_image(context, ds_format, vk::SampleCountFlags::_1, ds_usage)?;
    let color_resolve_attachment_view = make_image_view(
        device,
        color_resolve_attachment.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_srr,
    )?;
    let ds_resolve_attachment_view = make_image_view(
        device,
        ds_resolve_attachment.get(),
        vk::ImageViewType::_2D,
        ds_format,
        ds_srr,
    )?;

    // Render pass and framebuffer.
    let attachment_descriptions = [
        attachment_description(
            color_format,
            sample_count,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        ),
        attachment_description(
            ds_format,
            sample_count,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        ),
        attachment_description(
            color_format,
            vk::SampleCountFlags::_1,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::STORE,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        ),
        attachment_description(
            ds_format,
            vk::SampleCountFlags::_1,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::STORE,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        ),
    ];

    let color_attachment_reference = [vk::AttachmentReference2::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .aspect_mask(color_aspect)
        .build()];
    let ds_attachment_reference = vk::AttachmentReference2::builder()
        .attachment(1)
        .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .aspect_mask(ds_aspect)
        .build();
    let color_resolve_attachment_reference = [vk::AttachmentReference2::builder()
        .attachment(2)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .aspect_mask(color_aspect)
        .build()];
    let ds_resolve_attachment_reference = vk::AttachmentReference2::builder()
        .attachment(3)
        .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .aspect_mask(ds_aspect)
        .build();

    let mut ds_resolve_description = vk::SubpassDescriptionDepthStencilResolve::builder()
        .depth_resolve_mode(vk::ResolveModeFlags::SAMPLE_ZERO)
        .stencil_resolve_mode(vk::ResolveModeFlags::SAMPLE_ZERO)
        .depth_stencil_resolve_attachment(&ds_resolve_attachment_reference);

    let subpass_description = [vk::SubpassDescription2::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .view_mask(0)
        .color_attachments(&color_attachment_reference)
        .resolve_attachments(&color_resolve_attachment_reference)
        .depth_stencil_attachment(&ds_attachment_reference)
        .push_next(&mut ds_resolve_description)
        .build()];

    let render_pass_info = vk::RenderPassCreateInfo2::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpass_description);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass2(&render_pass_info, None) }.vk_check("vkCreateRenderPass2")?,
    );

    let attachment_views = [
        *color_attachment_view,
        *ds_attachment_view,
        *color_resolve_attachment_view,
        *ds_resolve_attachment_view,
    ];
    let framebuffer_info = vk::FramebufferCreateInfo::builder()
        .render_pass(*render_pass)
        .attachments(&attachment_views)
        .width(WIDTH)
        .height(HEIGHT)
        .layers(1);
    let framebuffer = Unique::new(
        device,
        unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    // Pipeline layout.
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    // Shaders.
    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let front_stencil_ref = if params.test_stencil() {
        BAD_STENCIL
    } else {
        EXPECTED_STENCIL
    };
    let front_stencil_op_state = vk::StencilOpState {
        fail_op: vk::StencilOp::KEEP,
        pass_op: vk::StencilOp::REPLACE,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::ALWAYS,
        compare_mask: 0xFF,
        write_mask: 0xFF,
        reference: front_stencil_ref,
    };
    let back_stencil_op_state = vk::StencilOpState {
        fail_op: vk::StencilOp::KEEP,
        pass_op: vk::StencilOp::KEEP,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::NEVER,
        compare_mask: 0xFF,
        write_mask: 0xFF,
        reference: 0,
    };

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(WIDTH, HEIGHT);
    state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(true)
        .depth_write_enable(true)
        .depth_compare_op(vk::CompareOp::LESS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(true)
        .front(front_stencil_op_state)
        .back(back_stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build();

    // Multisample state, including alpha to coverage, which is key for these tests.
    state.samples = sample_count;
    state.alpha_to_coverage_enable = !params.dynamic_alpha_to_coverage;
    state.sample_mask = if params.test_sample_mask_pipeline() {
        Some(0b1101)
    } else {
        None
    };
    if params.dynamic_alpha_to_coverage {
        state
            .dynamic_states
            .push(vk::DynamicState::ALPHA_TO_COVERAGE_ENABLE_EXT);
    }
    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;
    let pipeline = if shader_objects.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            &state,
        )?)
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_color = [0.0f32, 0.0, 0.0, 0.0];
    let mut geometry_color = [0.0f32, 0.0, 1.0, 1.0]; // For pixels with coverage. Must match frag shader.
    let mut color_threshold = 0.0f32;

    // cover interactions between pSampleMask and alphaToCoverageEnable
    if params.test_sample_mask_pipeline() {
        geometry_color = [0.0, 0.0, 0.75, 0.75]; // there are 4 samples but one is masked
        color_threshold = 0.02;
    }

    let clear_values = [
        clear_value_color(clear_color),
        vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: CLEAR_DEPTH,
                stencil: CLEAR_STENCIL,
            },
        },
    ];

    begin_command_buffer(device, cmd)?;
    if let Some(objects) = &shader_objects {
        let to_attachment = [
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_attachment.get(),
                color_srr,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_resolve_attachment.get(),
                color_srr,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                ds_attachment.get(),
                ds_srr,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                ds_resolve_attachment.get(),
                ds_srr,
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &to_attachment,
            );
        }
        let color_rendering = [vk::RenderingAttachmentInfo::builder()
            .image_view(*color_attachment_view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::AVERAGE)
            .resolve_image_view(*color_resolve_attachment_view)
            .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .clear_value(clear_values[0])
            .build()];
        let ds_rendering = vk::RenderingAttachmentInfo::builder()
            .image_view(*ds_attachment_view)
            .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::SAMPLE_ZERO)
            .resolve_image_view(*ds_resolve_attachment_view)
            .resolve_image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .clear_value(clear_values[1])
            .build();
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(rect_2d(WIDTH, HEIGHT))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_rendering)
            .depth_attachment(&ds_rendering)
            .stencil_attachment(&ds_rendering);
        unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        objects.bind(cmd, &state);
        unsafe {
            if params.dynamic_alpha_to_coverage {
                device.cmd_set_alpha_to_coverage_enable_ext(cmd, true);
            }
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_dynamic_rendering(device, cmd);
    } else if let Some(pipeline) = &pipeline {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(WIDTH, HEIGHT))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);
            if params.dynamic_alpha_to_coverage {
                device.cmd_set_alpha_to_coverage_enable_ext(cmd, true);
            }
            device.cmd_draw(cmd, 3, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    let render_size = (WIDTH, HEIGHT);
    let color_level = read_color_attachment(
        context,
        color_resolve_attachment.get(),
        color_format,
        render_size,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let depth_level = read_depth_attachment(
        context,
        ds_resolve_attachment.get(),
        ds_format,
        render_size,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    )?;
    let stencil_level = read_stencil_attachment(
        context,
        ds_resolve_attachment.get(),
        ds_format,
        render_size,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
    )?;

    let color_access = color_level.get_const_access();
    let depth_access = depth_level.get_const_access();
    let stencil_access = stencil_level.get_const_access();

    let half_width = WIDTH / 2;
    let half_height = HEIGHT / 2;

    let geometry_color_no_alpha = [geometry_color[0], geometry_color[1], geometry_color[2], 0.0]; // For pixels with coverage but alpha set to 0

    // allow skipping alpha to coverage if sample mask output is used
    let skip_alpha_to_coverage_behaviors: &[bool] = if params.test_sample_mask_shader() {
        &[false, true]
    } else {
        &[false]
    };
    let mask_shader = params.test_sample_mask_shader();

    for &skip_alpha_to_coverage in skip_alpha_to_coverage_behaviors {
        // The references of the four quadrants (top left, bottom left, top right, bottom right).
        let reference_color = [
            if skip_alpha_to_coverage {
                geometry_color_no_alpha
            } else {
                clear_color
            },
            if skip_alpha_to_coverage {
                if mask_shader {
                    clear_color
                } else {
                    geometry_color_no_alpha
                }
            } else {
                clear_color
            },
            geometry_color,
            if mask_shader { clear_color } else { geometry_color },
        ];
        let reference_depth = [
            if skip_alpha_to_coverage {
                EXPECTED_DEPTH
            } else {
                CLEAR_DEPTH
            },
            if skip_alpha_to_coverage {
                if mask_shader { CLEAR_DEPTH } else { EXPECTED_DEPTH }
            } else {
                CLEAR_DEPTH
            },
            EXPECTED_DEPTH,
            if mask_shader { CLEAR_DEPTH } else { EXPECTED_DEPTH },
        ];
        let reference_stencil = [
            if skip_alpha_to_coverage {
                EXPECTED_STENCIL
            } else {
                CLEAR_STENCIL
            },
            if skip_alpha_to_coverage {
                if mask_shader { CLEAR_STENCIL } else { EXPECTED_STENCIL }
            } else {
                CLEAR_STENCIL
            },
            EXPECTED_STENCIL,
            if mask_shader { CLEAR_STENCIL } else { EXPECTED_STENCIL },
        ];

        // Compare results and references.
        let mut color_ok = true;
        let mut depth_ok = true;
        let mut stencil_ok = true;
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                let quadrant = usize::from(y >= half_height) + 2 * usize::from(x >= half_width);

                let pixel = color_access.get_pixel(x, y, 0);
                color_ok &= pixel
                    .iter()
                    .zip(reference_color[quadrant])
                    .all(|(&value, expected)| (value - expected).abs() <= color_threshold);
                depth_ok &= depth_access.get_pix_depth(x, y, 0) == reference_depth[quadrant];
                stencil_ok &= stencil_access.get_pix_stencil(x, y, 0) == reference_stencil[quadrant];
            }
        }

        if color_ok && depth_ok && stencil_ok {
            return Ok(TestStatus::pass("Pass"));
        }
    }

    Ok(TestStatus::fail(
        "Unexpected color, depth or stencil result; check log for details",
    ))
}

/// The `z_export` child of upstream's `multisample` group (monolithic, without fragment shading rate).
pub(super) fn add_z_export_tests(multisample_tests: &mut TestCaseGroup) {
    let mut z_export_group = TestCaseGroup::new("z_export");

    let flags_cases = [
        (ZEXP_DEPTH_BIT, "depth", Z_EXPORT_DEPTH.programs),
        (ZEXP_STENCIL_BIT, "stencil", Z_EXPORT_STENCIL.programs),
        (
            ZEXP_SAMPLE_MASK_SHADER_BIT,
            "sample_mask",
            Z_EXPORT_SAMPLE_MASK.programs,
        ),
        (
            ZEXP_SAMPLE_MASK_PIPELINE_BIT,
            "sample_mask_pipeline",
            Z_EXPORT_SAMPLE_MASK_PIPELINE.programs,
        ),
        (
            ZEXP_DEPTH_BIT | ZEXP_STENCIL_BIT,
            "depth_stencil",
            Z_EXPORT_DEPTH_STENCIL.programs,
        ),
        (
            ZEXP_DEPTH_BIT | ZEXP_STENCIL_BIT | ZEXP_SAMPLE_MASK_SHADER_BIT,
            "write_all",
            Z_EXPORT_WRITE_ALL.programs,
        ),
    ];

    for (flags, name, programs) in flags_cases {
        for dynamic_alpha_to_coverage in [false, true] {
            let test_name = format!(
                "{}_{}_atc",
                name,
                if dynamic_alpha_to_coverage { "dynamic" } else { "static" }
            );
            let params = ZExportParams {
                test_flags: flags,
                dynamic_alpha_to_coverage,
            };
            z_export_group.add_child(Box::new(ZExportCase {
                name: test_name,
                params,
                programs,
            }) as Box<dyn TestCase>);
        }
    }

    multisample_tests.add_child(z_export_group);
}

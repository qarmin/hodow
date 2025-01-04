// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/imageless_framebuffer/vktImagelessFramebufferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Framebuffers created with VK_FRAMEBUFFER_CREATE_IMAGELESS_BIT: the attachment image views are only given to
// vkCmdBeginRenderPass. Upstream's class hierarchy (ColorImagelessTestInstance and its five subclasses) is one
// `ImagelessInstance` dispatching on the test type, the per-type reference images are `reference_image`, and the
// verification (including converting depth and stencil copies to colour first) is `verify_buffer`. Colours are compared
// as 8-bit values within the threshold of 1 `tcu::intThresholdCompare` uses. The shaders are in
// `shaders/manifest/imageless_framebuffer.toml`.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, KhrCreateRenderpass2ExtensionDeviceCommands};

use crate::generated::shaders::imageless_framebuffer::{
    IMAGELESS_COLOR, IMAGELESS_COLOR_RESOLVE, IMAGELESS_DEPTH_STENCIL, IMAGELESS_DEPTH_STENCIL_RESOLVE,
    IMAGELESS_DIFFERENT_ATTACHMENTS, IMAGELESS_MULTISUBPASS,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass as begin_simple_render_pass, end_command_buffer, end_render_pass,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: just the shader set of one test type.
pub struct ImagelessProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Color,
    DepthStencil,
    ColorResolve,
    DepthStencilResolve,
    Multisubpass,
    DifferentAttachments,
}

const ASPECT_NONE: u32 = 0;
const ASPECT_COLOR: u32 = 1 << 0;
const ASPECT_DEPTH: u32 = 1 << 1;
const ASPECT_STENCIL: u32 = 1 << 2;
const ASPECT_DEPTH_STENCIL: u32 = ASPECT_DEPTH | ASPECT_STENCIL;

const WIDTH: u32 = 32;
const HEIGHT: u32 = 32;

#[derive(Clone, Copy)]
struct TestParameters {
    test_type: TestType,
    color_format: vk::Format,
    ds_format: vk::Format,
    extended_flags: bool,
}

/// `VkImageCreateFlags2CreateInfoKHR` and `VkImageUsageFlags2CreateInfoKHR` share this layout; vulkanalia 0.35 has
/// neither, so the two structure types are written out.
#[repr(C)]
#[derive(Clone, Copy)]
struct Flags2CreateInfo {
    s_type: vk::StructureType,
    next: *const c_void,
    flags: u64,
}

const STRUCTURE_TYPE_IMAGE_CREATE_FLAGS_2_CREATE_INFO_KHR: i32 = 1000668001;
const STRUCTURE_TYPE_IMAGE_USAGE_FLAGS_2_CREATE_INFO_KHR: i32 = 1000668002;

fn render_area() -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: WIDTH,
            height: HEIGHT,
        },
    }
}

fn image_extent() -> vk::Extent3D {
    vk::Extent3D {
        width: WIDTH,
        height: HEIGHT,
        depth: 1,
    }
}

fn color_subresource_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

fn ds_subresource_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1)
}

/// `getFullQuadVertices`
fn get_full_quad_vertices() -> Vec<f32> {
    vec![
        -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0,
        1.0, 0.0, 1.0,
    ]
}

/// `getVertices` of the instance class for the test type.
fn get_vertices(test_type: TestType) -> Vec<f32> {
    match test_type {
        TestType::Color | TestType::Multisubpass | TestType::DifferentAttachments => {
            vec![
                -1.0, 0.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0,
                1.0, 1.0, 0.0, 1.0,
            ]
        }
        TestType::DepthStencil => vec![
            -1.0, 0.0, 0.50, 1.0, -1.0, 1.0, 0.50, 1.0, 1.0, 0.0, 0.50, 1.0, -1.0, 1.0, 0.50, 1.0, 1.0, 0.0, 0.50, 1.0,
            1.0, 1.0, 0.50, 1.0, //
            0.0, 0.0, 0.25, 1.0, 0.0, 1.0, 0.25, 1.0, 1.0, 0.0, 0.25, 1.0, 0.0, 1.0, 0.25, 1.0, 1.0, 0.0, 0.25, 1.0,
            1.0, 1.0, 0.25, 1.0,
        ],
        TestType::ColorResolve => vec![-1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0],
        TestType::DepthStencilResolve => vec![
            -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, //
            -1.0, -1.0, 0.5, 1.0, -1.0, 1.0, 0.5, 1.0, 1.0, -1.0, 0.5, 1.0,
        ],
    }
}

/// `checkImageFormatProperties`
fn check_image_format_properties(
    context: &Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<(), TestError> {
    let properties = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    };

    match properties {
        Ok(p)
            if p.max_array_layers >= 1
                && p.max_extent.height >= HEIGHT
                && p.max_extent.width >= WIDTH
                && p.max_extent.depth >= 1 =>
        {
            Ok(())
        }
        _ => Err(TestError::NotSupported(
            "Depth/stencil format is not supported".to_string(),
        )),
    }
}

fn color_image_usage(params: &TestParameters) -> vk::ImageUsageFlags {
    let base = vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::INPUT_ATTACHMENT;
    // To validate per-sample images the multisample image must also be sampled.
    match params.test_type {
        TestType::ColorResolve | TestType::DepthStencilResolve => base | vk::ImageUsageFlags::SAMPLED,
        _ => base,
    }
}

fn ds_image_usage(params: &TestParameters) -> vk::ImageUsageFlags {
    let base = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    if params.test_type == TestType::DepthStencilResolve {
        base | vk::ImageUsageFlags::SAMPLED
    } else {
        base
    }
}

fn make_image_create_info(
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    samples: vk::SampleCountFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(image_extent())
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// `makeFramebuffer` of the imageless test - the attachment infos come from the formats and usages, never from views.
#[allow(clippy::too_many_arguments)]
fn make_imageless_framebuffer<'a>(
    device: &'a Device,
    render_pass: vk::RenderPass,
    color_format: vk::Format,
    color_usage: vk::ImageUsageFlags,
    ds_format: vk::Format,
    extended_flags: bool,
    ds_usage: vk::ImageUsageFlags,
    resolve_aspects: u32,
    input_attachment_count: u32,
) -> Result<Unique<'a, vk::Framebuffer>, TestError> {
    let color_formats = [color_format];
    let ds_formats = [ds_format];

    let make_info = |usage: vk::ImageUsageFlags, formats: &[vk::Format]| vk::FramebufferAttachmentImageInfo {
        s_type: vk::StructureType::FRAMEBUFFER_ATTACHMENT_IMAGE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        usage,
        width: WIDTH,
        height: HEIGHT,
        layer_count: 1,
        view_format_count: 1,
        view_formats: formats.as_ptr(),
    };

    let color_resolve = resolve_aspects & ASPECT_COLOR != 0;
    let depth_stencil_resolve = resolve_aspects & ASPECT_DEPTH_STENCIL != 0;

    let mut infos: Vec<vk::FramebufferAttachmentImageInfo> = Vec::new();
    if color_format != vk::Format::UNDEFINED {
        infos.push(make_info(color_usage, &color_formats));
    }
    if ds_format != vk::Format::UNDEFINED {
        infos.push(make_info(ds_usage, &ds_formats));
    }
    if color_resolve {
        debug_assert!(color_format != vk::Format::UNDEFINED);
        infos.push(make_info(color_usage, &color_formats));
    }
    if depth_stencil_resolve {
        debug_assert!(ds_format != vk::Format::UNDEFINED);
        infos.push(make_info(ds_usage, &ds_formats));
    }
    for _ in 0..input_attachment_count {
        infos.push(make_info(
            color_usage | vk::ImageUsageFlags::INPUT_ATTACHMENT,
            &color_formats,
        ));
    }

    // The two vectors are filled completely before any pointer into them is taken.
    let mut create_flags2_infos = Vec::new();
    let mut usage_flags2_infos = Vec::new();
    if extended_flags {
        for info in &infos {
            create_flags2_infos.push(Flags2CreateInfo {
                s_type: vk::StructureType::from_raw(STRUCTURE_TYPE_IMAGE_CREATE_FLAGS_2_CREATE_INFO_KHR),
                next: std::ptr::null(),
                flags: u64::from(info.flags.bits()),
            });
            usage_flags2_infos.push(Flags2CreateInfo {
                s_type: vk::StructureType::from_raw(STRUCTURE_TYPE_IMAGE_USAGE_FLAGS_2_CREATE_INFO_KHR),
                next: std::ptr::null(),
                flags: u64::from(info.usage.bits()),
            });
        }
        for i in 0..infos.len() {
            usage_flags2_infos[i].next = (&create_flags2_infos[i] as *const Flags2CreateInfo).cast();
            infos[i].next = (&usage_flags2_infos[i] as *const Flags2CreateInfo).cast();
            infos[i].flags = vk::ImageCreateFlags::empty();
            infos[i].usage = vk::ImageUsageFlags::empty();
        }
    }

    let attachment_count = infos.len() as u32;
    let attachments_create_info = vk::FramebufferAttachmentsCreateInfo {
        s_type: vk::StructureType::FRAMEBUFFER_ATTACHMENTS_CREATE_INFO,
        next: std::ptr::null(),
        attachment_image_info_count: attachment_count,
        attachment_image_infos: infos.as_ptr(),
    };
    let framebuffer_info = vk::FramebufferCreateInfo {
        s_type: vk::StructureType::FRAMEBUFFER_CREATE_INFO,
        next: (&attachments_create_info as *const vk::FramebufferAttachmentsCreateInfo).cast(),
        flags: vk::FramebufferCreateFlags::IMAGELESS,
        render_pass,
        attachment_count,
        attachments: std::ptr::null(),
        width: WIDTH,
        height: HEIGHT,
        layers: 1,
    };
    let framebuffer = unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?;
    Ok(Unique::new(device, framebuffer))
}

/// `makeRenderPass` with the colour and depth/stencil formats and sample counts. A multisample attachment gets a
/// single sample resolve attachment after the others, and a multisample depth/stencil attachment needs the
/// render pass 2 path for its VkSubpassDescriptionDepthStencilResolve.
fn make_render_pass<'a>(
    device: &'a Device,
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    color_samples: vk::SampleCountFlags,
    depth_stencil_samples: vk::SampleCountFlags,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let has_color = color_format != vk::Format::UNDEFINED;
    let has_depth_stencil = depth_stencil_format != vk::Format::UNDEFINED;
    let has_color_resolve = has_color && color_samples != vk::SampleCountFlags::_1;
    let has_depth_stencil_resolve = has_depth_stencil && depth_stencil_samples != vk::SampleCountFlags::_1;

    let color_attachment_description = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(color_samples)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let depth_stencil_attachment_description = vk::AttachmentDescription::builder()
        .format(depth_stencil_format)
        .samples(depth_stencil_samples)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
        .stencil_store_op(vk::AttachmentStoreOp::STORE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .build();
    let color_resolve_attachment_description = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::DONT_CARE)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let depth_stencil_resolve_attachment_description = vk::AttachmentDescription::builder()
        .format(depth_stencil_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::DONT_CARE)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::STORE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .build();

    let mut attachment_descriptions = Vec::new();
    if has_color {
        attachment_descriptions.push(color_attachment_description);
    }
    if has_depth_stencil {
        attachment_descriptions.push(depth_stencil_attachment_description);
    }
    if has_color_resolve {
        attachment_descriptions.push(color_resolve_attachment_description);
    }
    if has_depth_stencil_resolve {
        attachment_descriptions.push(depth_stencil_resolve_attachment_description);
    }

    let mut attachment_counter = 0u32;
    let mut next_attachment = |used: bool| {
        if used {
            let attachment = attachment_counter;
            attachment_counter += 1;
            attachment
        } else {
            0
        }
    };
    let color_attachment = next_attachment(has_color);
    let depth_stencil_attachment = next_attachment(has_depth_stencil);
    let color_resolve_attachment = next_attachment(has_color_resolve);
    let depth_stencil_resolve_attachment = next_attachment(has_depth_stencil_resolve);

    if has_depth_stencil_resolve {
        let color_aspect_mask = vk::ImageAspectFlags::COLOR;
        let depth_stencil_aspect_mask = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
        let reference2 =
            |attachment: u32, layout: vk::ImageLayout, aspect_mask: vk::ImageAspectFlags| vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment,
                layout,
                aspect_mask,
            };
        let color_attachment_ref2 = reference2(
            color_attachment,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_aspect_mask,
        );
        let depth_stencil_attachment_ref2 = reference2(
            depth_stencil_attachment,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            depth_stencil_aspect_mask,
        );
        let color_resolve_attachment_ref2 = reference2(
            color_resolve_attachment,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_aspect_mask,
        );
        let depth_stencil_resolve_attachment_ref2 = reference2(
            depth_stencil_resolve_attachment,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            depth_stencil_aspect_mask,
        );
        let subpass_description_depth_stencil_resolve = vk::SubpassDescriptionDepthStencilResolve {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_DEPTH_STENCIL_RESOLVE,
            next: std::ptr::null(),
            depth_resolve_mode: vk::ResolveModeFlags::SAMPLE_ZERO,
            stencil_resolve_mode: vk::ResolveModeFlags::SAMPLE_ZERO,
            depth_stencil_resolve_attachment: &depth_stencil_resolve_attachment_ref2,
        };
        let subpass_description2 = vk::SubpassDescription2 {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
            next: (&subpass_description_depth_stencil_resolve as *const vk::SubpassDescriptionDepthStencilResolve)
                .cast(),
            flags: vk::SubpassDescriptionFlags::empty(),
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: 0,
            input_attachments: std::ptr::null(),
            color_attachment_count: u32::from(has_color),
            color_attachments: if has_color {
                &color_attachment_ref2 as *const vk::AttachmentReference2
            } else {
                std::ptr::null()
            },
            resolve_attachments: if has_color_resolve {
                &color_resolve_attachment_ref2 as *const vk::AttachmentReference2
            } else {
                std::ptr::null()
            },
            depth_stencil_attachment: if has_depth_stencil {
                &depth_stencil_attachment_ref2 as *const vk::AttachmentReference2
            } else {
                std::ptr::null()
            },
            preserve_attachment_count: 0,
            preserve_attachments: std::ptr::null(),
        };
        let attachment_descriptions2: Vec<vk::AttachmentDescription2> = attachment_descriptions
            .iter()
            .map(|description| vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: description.flags,
                format: description.format,
                samples: description.samples,
                load_op: description.load_op,
                store_op: description.store_op,
                stencil_load_op: description.stencil_load_op,
                stencil_store_op: description.stencil_store_op,
                initial_layout: description.initial_layout,
                final_layout: description.final_layout,
            })
            .collect();
        let render_pass_info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachment_descriptions2.len() as u32,
            attachments: attachment_descriptions2.as_ptr(),
            subpass_count: 1,
            subpasses: &subpass_description2,
            dependency_count: 0,
            dependencies: std::ptr::null(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };
        let render_pass =
            unsafe { device.create_render_pass2_khr(&render_pass_info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        Ok(Unique::new(device, render_pass))
    } else {
        let color_attachment_ref = [vk::AttachmentReference {
            attachment: color_attachment,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let color_resolve_attachment_ref = [vk::AttachmentReference {
            attachment: color_resolve_attachment,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_stencil_attachment_ref = vk::AttachmentReference {
            attachment: depth_stencil_attachment,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };

        let mut subpass_description =
            vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
        if has_color {
            subpass_description = subpass_description.color_attachments(&color_attachment_ref);
        }
        if has_color_resolve {
            subpass_description = subpass_description.resolve_attachments(&color_resolve_attachment_ref);
        }
        if has_depth_stencil {
            subpass_description = subpass_description.depth_stencil_attachment(&depth_stencil_attachment_ref);
        }
        let subpass_descriptions = [subpass_description.build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpass_descriptions);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, render_pass))
    }
}

fn make_multisubpass_render_pass(
    device: &Device,
    color_format: vk::Format,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_description = |load_op: vk::AttachmentLoadOp| {
        vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::GENERAL)
            .build()
    };
    let attachment_descriptions = [
        attachment_description(vk::AttachmentLoadOp::CLEAR),
        attachment_description(vk::AttachmentLoadOp::DONT_CARE),
    ];

    let color_attachment_ref0 = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::GENERAL,
    }];
    let preserve_attachment = [1u32];
    let input_attachment_ref1 = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::GENERAL,
    }];
    let color_attachment_ref1 = [vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::GENERAL,
    }];
    let subpass_descriptions = [
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_ref0)
            .preserve_attachments(&preserve_attachment)
            .build(),
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .input_attachments(&input_attachment_ref1)
            .color_attachments(&color_attachment_ref1)
            .build(),
    ];
    let subpass_dependencies = [vk::SubpassDependency::builder()
        .src_subpass(0)
        .dst_subpass(1)
        .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
        .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
        .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
        .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
        .dependency_flags(vk::DependencyFlags::VIEW_LOCAL)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpass_descriptions)
        .dependencies(&subpass_dependencies);
    let render_pass = unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `makeSingleAttachmentRenderPass`
fn make_single_attachment_render_pass(
    device: &Device,
    color_format: vk::Format,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_descriptions = [vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::GENERAL)
        .build()];
    let color_attachment_ref0 = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::GENERAL,
    }];
    let subpass_descriptions = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_ref0)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpass_descriptions);
    let render_pass = unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `makeGraphicsPipeline` of the imageless test: one `vec4` vertex attribute, triangle list, optional depth and stencil
/// tests, a chosen sample count and subpass.
#[allow(clippy::too_many_arguments)]
fn make_graphics_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    depth_stencil_aspects: u32,
    sample_count: vk::SampleCountFlags,
    subpass: u32,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let use_depth = depth_stencil_aspects & ASPECT_DEPTH != 0;
    let use_stencil = depth_stencil_aspects & ASPECT_STENCIL != 0;

    let vertex_bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<[f32; 4]>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let vertex_attributes = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&vertex_bindings)
        .vertex_attribute_descriptions(&vertex_attributes);
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: WIDTH as f32,
        height: HEIGHT as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [render_area()];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(sample_count)
        .sample_shading_enable(false)
        .min_sample_shading(0.0)
        .alpha_to_coverage_enable(false)
        .alpha_to_one_enable(false);
    let stencil_op_state = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::INCREMENT_AND_CLAMP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::ALWAYS)
        .compare_mask(!0)
        .write_mask(!0)
        .reference(0)
        .build();
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(use_depth)
        .depth_write_enable(use_depth)
        .depth_compare_op(vk::CompareOp::LESS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(use_stencil)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);
    let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
    let stages = [
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
    let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(subpass)
        .base_pipeline_index(0);
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `vkCmdBeginRenderPass` with the `VkRenderPassAttachmentBeginInfo` an imageless framebuffer needs.
fn begin_imageless_render_pass(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    attachments: &[vk::ImageView],
    clear_values: &[vk::ClearValue],
) {
    let attachment_begin_info = vk::RenderPassAttachmentBeginInfo {
        s_type: vk::StructureType::RENDER_PASS_ATTACHMENT_BEGIN_INFO,
        next: std::ptr::null(),
        attachment_count: attachments.len() as u32,
        attachments: attachments.as_ptr(),
    };
    let begin_info = vk::RenderPassBeginInfo {
        s_type: vk::StructureType::RENDER_PASS_BEGIN_INFO,
        next: (&attachment_begin_info as *const vk::RenderPassAttachmentBeginInfo).cast(),
        render_pass,
        framebuffer,
        render_area: render_area(),
        clear_value_count: clear_values.len() as u32,
        clear_values: clear_values.as_ptr(),
    };
    unsafe { device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
}

fn clear_color_value() -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    }
}

fn clear_depth_stencil_value() -> vk::ClearValue {
    vk::ClearValue {
        depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
    }
}

/// The colour image copy every case ends with: the image is left by the render pass in `old_layout`.
fn record_color_copy(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    old_layout: vk::ImageLayout,
) {
    let pre_copy_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        color_subresource_range(),
    );
    let region = make_buffer_image_copy(
        image_extent(),
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let post_copy_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer,
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_copy_barrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[region],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[post_copy_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// The depth/stencil image copy: both aspects go to their own buffer.
#[allow(clippy::too_many_arguments)]
fn record_depth_stencil_copy(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    depth_buffer: vk::Buffer,
    stencil_buffer: vk::Buffer,
    src_access_mask: vk::AccessFlags,
    src_stage_mask: vk::PipelineStageFlags,
) {
    let pre_copy_barrier = make_image_memory_barrier(
        src_access_mask,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        ds_subresource_range(),
    );
    let depth_copy_region = make_buffer_image_copy(
        image_extent(),
        make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
    );
    let stencil_copy_region = make_buffer_image_copy(
        image_extent(),
        make_image_subresource_layers(vk::ImageAspectFlags::STENCIL, 0, 0, 1),
    );
    let post_copy_barriers = [
        make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            depth_buffer,
            0,
            vk::WHOLE_SIZE,
        ),
        make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            stencil_buffer,
            0,
            vk::WHOLE_SIZE,
        ),
    ];
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage_mask,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_copy_barrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            depth_buffer,
            &[depth_copy_region],
        );
        device.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            stencil_buffer,
            &[stencil_copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &post_copy_barriers,
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `tcu::RGBA::toVec` stored back as an UNORM8 channel, i.e. the byte itself.
const BLACK: [u8; 4] = [0, 0, 0, 255];
const BLUE: [u8; 4] = [0, 0, 255, 255];
const GRAY_75: [u8; 4] = [192, 192, 192, 255];
const WHITE: [u8; 4] = [255, 255, 255, 255];

/// A channel value upstream builds from `static_cast<int>(f * 0x100)`, saturated to a byte by `setPixel(IVec4)`.
fn int_channel(f: f32) -> u8 {
    ((f * 256.0) as i32).clamp(0, 255) as u8
}

/// `tcu::floatToChannel` for UNORM_INT8.
fn unorm8(f: f32) -> u8 {
    (f * 255.0).round_ties_even().clamp(0.0, 255.0) as u8
}

/// The colour a pixel of the multisample reference takes for the given sample: the sample positions put sample 0 and 2
/// in the drawn half and 1 and 3 in the filled one, and the resolved image is the average.
fn pick_edge(sample: Option<u32>, draw: [u8; 4], fill: [u8; 4], resolved: [u8; 4]) -> [u8; 4] {
    match sample {
        Some(0) | Some(2) => draw,
        Some(1) | Some(3) => fill,
        _ => resolved,
    }
}

struct ImagelessTestCase {
    name: &'static str,
    params: TestParameters,
}

impl TestCase for ImagelessTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `BaseTestCase::checkSupport` followed by what the instance constructors check.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if matches!(params.test_type, TestType::ColorResolve | TestType::DepthStencilResolve)
            && context.get_device_properties().limits.standard_sample_locations == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Non-standard sample locations are not supported".to_string(),
            ));
        }
        if params.extended_flags {
            context.require_device_functionality("VK_KHR_extended_flags")?;
        }

        context.require_device_functionality("VK_KHR_imageless_framebuffer")?;
        let mut imageless_framebuffer_features = vk::PhysicalDeviceImagelessFramebufferFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut imageless_framebuffer_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if imageless_framebuffer_features.imageless_framebuffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "Imageless framebuffer is not supported".to_string(),
            ));
        }

        check_image_format_properties(context, params.color_format, color_image_usage(params))?;
        if matches!(params.test_type, TestType::DepthStencil | TestType::DepthStencilResolve) {
            check_image_format_properties(context, params.ds_format, ds_image_usage(params))?;
        }
        if params.test_type == TestType::DepthStencilResolve {
            context.require_device_functionality("VK_KHR_depth_stencil_resolve")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.test_type {
            TestType::Color => IMAGELESS_COLOR.programs,
            TestType::DepthStencil => IMAGELESS_DEPTH_STENCIL.programs,
            TestType::ColorResolve => IMAGELESS_COLOR_RESOLVE.programs,
            TestType::DepthStencilResolve => IMAGELESS_DEPTH_STENCIL_RESOLVE.programs,
            TestType::Multisubpass => IMAGELESS_MULTISUBPASS.programs,
            TestType::DifferentAttachments => IMAGELESS_DIFFERENT_ATTACHMENTS.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImagelessInstance {
            context,
            params: self.params,
        })
    }
}

struct ImagelessInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

impl<'a> ImagelessInstance<'a> {
    fn make_image(
        &self,
        format: vk::Format,
        usage: vk::ImageUsageFlags,
        samples: vk::SampleCountFlags,
    ) -> Result<ImageWithMemory<'a>, TestError> {
        let context: &'a Context<'a> = self.context;
        ImageWithMemory::new(
            context.get_device(),
            context.get_default_allocator(),
            make_image_create_info(format, usage, samples),
            MemoryRequirement::ANY,
        )
    }

    fn make_host_buffer(
        &self,
        size: vk::DeviceSize,
        usage: vk::BufferUsageFlags,
    ) -> Result<BufferWithMemory<'a>, TestError> {
        let context: &'a Context<'a> = self.context;
        BufferWithMemory::new(
            context.get_device(),
            context.get_default_allocator(),
            make_buffer_create_info(size, usage),
            MemoryRequirement::HOST_VISIBLE,
        )
    }

    /// `makeBuffer` + `fillBuffer` of a vertex array.
    fn make_vertex_buffer(&self, vertices: &[f32]) -> Result<BufferWithMemory<'a>, TestError> {
        let size = std::mem::size_of_val(vertices) as vk::DeviceSize;
        let buffer = self.make_host_buffer(size, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                buffer.get_allocation().get_host_ptr(),
                size as usize,
            )
        };
        flush_alloc(self.context.get_device(), buffer.get_allocation())?;
        Ok(buffer)
    }

    fn color_buffer_size(&self) -> vk::DeviceSize {
        (WIDTH * HEIGHT * 4) as vk::DeviceSize
    }

    /// The reference image of `generateReferenceImage`, as a texel per pixel. The channels a converted depth or stencil
    /// image does not have are present and ignored, because the comparison only looks at the channels of the result.
    fn reference_image(&self, aspect: u32, sample: Option<u32>, subpass: Option<u32>) -> Vec<[u8; 4]> {
        let (width, height) = (WIDTH as i32, HEIGHT as i32);
        let mut image = Vec::with_capacity((WIDTH * HEIGHT) as usize);

        for y in 0..height {
            for x in 0..width {
                let mx = width - 1 - x;
                let texel = match self.params.test_type {
                    TestType::Color => {
                        if y < height / 2 {
                            BLACK
                        } else {
                            GRAY_75
                        }
                    }
                    TestType::DepthStencil => {
                        let region = if y < height / 2 {
                            0
                        } else if x < width / 2 {
                            1
                        } else {
                            2
                        };
                        if aspect & ASPECT_COLOR != 0 {
                            [BLACK, GRAY_75, WHITE][region]
                        } else if aspect & ASPECT_DEPTH != 0 {
                            [
                                [int_channel(1.00), 0, 0, 255],
                                [int_channel(0.50), 0, 0, 255],
                                [int_channel(0.25), 0, 0, 255],
                            ][region]
                        } else {
                            [
                                [int_channel(0.00), 0, 0, 255],
                                [int_channel(0.25), 0, 0, 255],
                                [int_channel(0.50), 0, 0, 255],
                            ][region]
                        }
                    }
                    TestType::ColorResolve => {
                        let average = [
                            unorm8((f32::from(GRAY_75[0]) / 255.0 + 0.0) / 2.0),
                            unorm8((f32::from(GRAY_75[1]) / 255.0 + 0.0) / 2.0),
                            unorm8((f32::from(GRAY_75[2]) / 255.0 + 0.0) / 2.0),
                            255,
                        ];
                        let edge = pick_edge(sample, GRAY_75, BLACK, average);
                        if y == mx {
                            edge
                        } else if y > mx {
                            BLACK
                        } else {
                            GRAY_75
                        }
                    }
                    TestType::DepthStencilResolve => {
                        let (draw, fill, average): ([u8; 4], [u8; 4], [u8; 4]) = if aspect & ASPECT_COLOR != 0 {
                            (BLUE, BLACK, [0, 0, unorm8((1.0 + 0.0) / 2.0), 255])
                        } else if aspect & ASPECT_DEPTH != 0 {
                            let (fill, draw) = (int_channel(1.00), int_channel(0.00));
                            (
                                [draw, draw, draw, 255],
                                [fill, fill, fill, 255],
                                [draw, draw, draw, 255],
                            )
                        } else {
                            let (fill, draw) = (0u8, (0x100 / 4) as u8);
                            (
                                [draw, draw, draw, 255],
                                [fill, fill, fill, 255],
                                [draw, draw, draw, 255],
                            )
                        };
                        let edge = pick_edge(sample, draw, fill, average);
                        if y == mx {
                            edge
                        } else if y > mx {
                            fill
                        } else {
                            draw
                        }
                    }
                    TestType::Multisubpass => {
                        let (draw, fill) = if subpass == Some(0) {
                            (BLUE, BLACK)
                        } else {
                            ([0, 255, 255, 255], [0, 255, 0, 255])
                        };
                        if y < height / 2 { fill } else { draw }
                    }
                    TestType::DifferentAttachments => {
                        if y < height / 2 {
                            BLACK
                        } else {
                            BLUE
                        }
                    }
                };
                image.push(texel);
            }
        }
        image
    }

    /// `verifyBuffer`. A depth or stencil copy of a single sample image is converted to a one channel UNORM8 image
    /// first, a sample read back through the demultiplexing shader already is a colour image.
    fn verify_buffer(
        &self,
        buffer: &BufferWithMemory<'_>,
        name: &str,
        aspect: u32,
        sample: Option<u32>,
        subpass: Option<u32>,
    ) -> Result<bool, TestError> {
        let device = self.context.get_device();
        invalidate_alloc(device, buffer.get_allocation())?;

        let multisampled = sample.is_some();
        let depth = aspect & ASPECT_DEPTH != 0;
        let stencil = aspect & ASPECT_STENCIL != 0;
        let texel_count = (WIDTH * HEIGHT) as usize;
        let ptr = buffer.get_allocation().get_host_ptr();

        let (result, channels): (Vec<[u8; 4]>, usize) = if !multisampled && depth {
            // `getDepthCopyFormat` of D24_UNORM_S8_UINT: the depth sits in the low 24 bits of a 32 bit texel.
            let bytes = unsafe { std::slice::from_raw_parts(ptr, texel_count * 4) };
            let texels = bytes
                .chunks_exact(4)
                .map(|texel| {
                    let raw = u32::from_ne_bytes([texel[0], texel[1], texel[2], texel[3]]) & 0x00FF_FFFF;
                    [unorm8(raw as f32 / 16_777_215.0), 0, 0, 255]
                })
                .collect();
            (texels, 1)
        } else if !multisampled && stencil {
            let max_value = 4;
            let bytes = unsafe { std::slice::from_raw_parts(ptr, texel_count) };
            let texels = bytes
                .iter()
                .map(|&stencil_int| {
                    let value = if i32::from(stencil_int) < max_value {
                        f32::from(stencil_int) / max_value as f32
                    } else {
                        1.0
                    };
                    [unorm8(value), 0, 0, 255]
                })
                .collect();
            (texels, 1)
        } else {
            let bytes = unsafe { std::slice::from_raw_parts(ptr, texel_count * 4) };
            (
                bytes
                    .chunks_exact(4)
                    .map(|texel| [texel[0], texel[1], texel[2], texel[3]])
                    .collect(),
                4,
            )
        };

        let reference = self.reference_image(aspect, sample, subpass);
        let matches = result
            .iter()
            .zip(&reference)
            .all(|(actual, expected)| (0..channels).all(|c| actual[c].abs_diff(expected[c]) <= 1));
        if !matches {
            log::warn!("Image {name} does not match the reference");
        }
        Ok(matches)
    }

    /// `readOneSampleFromMultisampleImage`: draw a full-screen quad that fetches `sample_id` of the source into a
    /// single sample colour image, and copy that to `dst_buffer`.
    fn read_one_sample_from_multisample_image(
        &self,
        src_format: vk::Format,
        src_image: vk::Image,
        sample_id: u32,
        dst_image: &ImageWithMemory<'_>,
        dst_buffer: &BufferWithMemory<'_>,
        aspect: u32,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let dst_format = self.params.color_format;

        let color = aspect & ASPECT_COLOR != 0;
        let depth = aspect & ASPECT_DEPTH != 0;
        let src_aspect = if color {
            vk::ImageAspectFlags::COLOR
        } else if depth {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::STENCIL
        };
        let src_view = make_image_view(
            device,
            src_image,
            vk::ImageViewType::_2D,
            src_format,
            make_image_subresource_range(src_aspect, 0, 1, 0, 1),
        )?;
        let dst_attachment = make_image_view(
            device,
            dst_image.get(),
            vk::ImageViewType::_2D,
            dst_format,
            color_subresource_range(),
        )?;

        let frag_module_infix = if color {
            "-color"
        } else if depth {
            "-depth"
        } else {
            "-stencil"
        };
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("demultisample-vert")?)?;
        let frag_module =
            create_shader_module(device, binaries.get(&format!("demultisample{frag_module_infix}-frag"))?)?;
        let render_pass = make_render_pass(
            device,
            dst_format,
            vk::Format::UNDEFINED,
            vk::SampleCountFlags::_1,
            vk::SampleCountFlags::_1,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*dst_attachment], WIDTH, HEIGHT, 1)?;

        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::LINEAR)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let sampler_descriptor_type = vk::DescriptorType::COMBINED_IMAGE_SAMPLER;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_sampler_binding(sampler_descriptor_type, vk::ShaderStageFlags::FRAGMENT, 0, &[*sampler])
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(sampler_descriptor_type, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_descriptor_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *src_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(sampler_descriptor_type)
            .image_info(&image_descriptor_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // `makeVerifyPipelineLayout`
        let set_layouts = [*descriptor_set_layout];
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        }];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            ASPECT_NONE,
            vk::SampleCountFlags::_1,
            0,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let vertex_array = get_full_quad_vertices();
        let vertex_count = (vertex_array.len() / 4) as u32;
        let vertex_buffer = self.make_vertex_buffer(&vertex_array)?;

        begin_command_buffer(device, cmd)?;
        if sample_id == 0 {
            if color {
                let pre_copy_barrier = make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    src_image,
                    make_image_subresource_range(src_aspect, 0, 1, 0, 1),
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[pre_copy_barrier],
                    );
                }
            } else if depth {
                let pre_copy_barrier = make_image_memory_barrier(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    src_image,
                    ds_subresource_range(),
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[pre_copy_barrier],
                    );
                }
            }
        }

        begin_simple_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            render_area(),
            clear_color_value(),
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_push_constants(
                cmd,
                *pipeline_layout,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                &sample_id.to_ne_bytes(),
            );
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        record_color_copy(
            device,
            cmd,
            dst_image.get(),
            dst_buffer.get(),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)
    }

    /// One sample of a multisample image, read back and verified against the reference of that sample.
    fn verify_sample(
        &self,
        src_format: vk::Format,
        src_image: vk::Image,
        sample_ndx: u32,
        aspect: u32,
        name: &str,
    ) -> Result<bool, TestError> {
        let color_format = self.params.color_format;
        let image_sample = self.make_image(color_format, color_image_usage(&self.params), vk::SampleCountFlags::_1)?;
        let image_buffer = self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        self.read_one_sample_from_multisample_image(
            src_format,
            src_image,
            sample_ndx,
            &image_sample,
            &image_buffer,
            aspect,
        )?;
        self.verify_buffer(&image_buffer, name, aspect, Some(sample_ndx), None)
    }

    /// `ColorImagelessTestInstance::iterate`
    fn iterate_color(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = self.params;
        let color_format = params.color_format;
        let color_usage = color_image_usage(&params);

        let color_image = self.make_image(color_format, color_usage, vk::SampleCountFlags::_1)?;
        let color_attachment = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;
        let color_buffer = self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_render_pass(
            device,
            color_format,
            params.ds_format,
            vk::SampleCountFlags::_1,
            vk::SampleCountFlags::_1,
        )?;
        let framebuffer = make_imageless_framebuffer(
            device,
            *render_pass,
            color_format,
            color_usage,
            params.ds_format,
            params.extended_flags,
            vk::ImageUsageFlags::empty(),
            ASPECT_NONE,
            0,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            ASPECT_NONE,
            vk::SampleCountFlags::_1,
            0,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let vertex_array = get_vertices(params.test_type);
        let vertex_count = (vertex_array.len() / 4) as u32;
        let vertex_buffer = self.make_vertex_buffer(&vertex_array)?;

        begin_command_buffer(device, cmd)?;
        begin_imageless_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            &[*color_attachment],
            &[clear_color_value()],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        record_color_copy(
            device,
            cmd,
            color_image.get(),
            color_buffer.get(),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        if self.verify_buffer(&color_buffer, "Color", ASPECT_COLOR, None, None)? {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }

    /// `DepthImagelessTestInstance::iterate`
    fn iterate_depth_stencil(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = self.params;
        let color_format = params.color_format;
        let ds_format = params.ds_format;
        let color_usage = color_image_usage(&params);
        let ds_usage = ds_image_usage(&params);

        let color_image = self.make_image(color_format, color_usage, vk::SampleCountFlags::_1)?;
        let color_attachment = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;
        let color_buffer = self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        // The depth copy of D24_UNORM_S8_UINT is a 32 bit texel, the stencil copy a byte.
        let depth_buffer_size = (WIDTH * HEIGHT * 4) as vk::DeviceSize;
        let stencil_buffer_size = (WIDTH * HEIGHT) as vk::DeviceSize;
        let ds_image = self.make_image(ds_format, ds_usage, vk::SampleCountFlags::_1)?;
        let ds_attachment = make_image_view(
            device,
            ds_image.get(),
            vk::ImageViewType::_2D,
            ds_format,
            ds_subresource_range(),
        )?;
        let depth_buffer = self.make_host_buffer(
            depth_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        )?;
        let stencil_buffer = self.make_host_buffer(
            stencil_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        )?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_render_pass(
            device,
            color_format,
            ds_format,
            vk::SampleCountFlags::_1,
            vk::SampleCountFlags::_1,
        )?;
        let framebuffer = make_imageless_framebuffer(
            device,
            *render_pass,
            color_format,
            color_usage,
            ds_format,
            params.extended_flags,
            ds_usage,
            ASPECT_NONE,
            0,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            ASPECT_DEPTH_STENCIL,
            vk::SampleCountFlags::_1,
            0,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let vertex_array = get_vertices(params.test_type);
        let vertex_count = (vertex_array.len() / 4) as u32;
        let vertex_buffer = self.make_vertex_buffer(&vertex_array)?;

        begin_command_buffer(device, cmd)?;
        begin_imageless_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            &[*color_attachment, *ds_attachment],
            &[clear_color_value(), clear_depth_stencil_value()],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        record_color_copy(
            device,
            cmd,
            color_image.get(),
            color_buffer.get(),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );
        record_depth_stencil_copy(
            device,
            cmd,
            ds_image.get(),
            depth_buffer.get(),
            stencil_buffer.get(),
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let mut result = String::new();
        if !self.verify_buffer(&color_buffer, "Color", ASPECT_COLOR, None, None)? {
            result += " Color";
        }
        if !self.verify_buffer(&depth_buffer, "Depth", ASPECT_DEPTH, None, None)? {
            result += " Depth";
        }
        if !self.verify_buffer(&stencil_buffer, "Stencil", ASPECT_STENCIL, None, None)? {
            result += " Stencil";
        }

        if result.is_empty() {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(format!(
                "Following parts of image are incorrect:{result}"
            )))
        }
    }

    /// `ColorResolveImagelessTestInstance::iterate`
    fn iterate_color_resolve(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = self.params;
        let sample_count_flag = vk::SampleCountFlags::_4;
        let sample_count = 4u32;
        let color_format = params.color_format;
        let color_usage = color_image_usage(&params);

        let color_image = self.make_image(color_format, color_usage, sample_count_flag)?;
        let color_attachment = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;

        let color_resolve_image = self.make_image(color_format, color_usage, vk::SampleCountFlags::_1)?;
        let color_resolve_attachment = make_image_view(
            device,
            color_resolve_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;
        let color_resolve_buffer =
            self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_render_pass(
            device,
            color_format,
            params.ds_format,
            sample_count_flag,
            vk::SampleCountFlags::_1,
        )?;
        let framebuffer = make_imageless_framebuffer(
            device,
            *render_pass,
            color_format,
            color_usage,
            params.ds_format,
            params.extended_flags,
            vk::ImageUsageFlags::empty(),
            ASPECT_COLOR,
            0,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            ASPECT_NONE,
            sample_count_flag,
            0,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let vertex_array = get_vertices(params.test_type);
        let vertex_count = (vertex_array.len() / 4) as u32;
        let vertex_buffer = self.make_vertex_buffer(&vertex_array)?;

        begin_command_buffer(device, cmd)?;
        begin_imageless_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            &[*color_attachment, *color_resolve_attachment],
            &[clear_color_value()],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        record_color_copy(
            device,
            cmd,
            color_resolve_image.get(),
            color_resolve_buffer.get(),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let mut result = String::new();
        if !self.verify_buffer(&color_resolve_buffer, "ResolveColor", ASPECT_COLOR, None, None)? {
            result += " ResolveColor";
        }

        // Parse color aspect of separate samples of multisample image
        for sample_ndx in 0..sample_count {
            let name = format!("Color{sample_ndx}");
            if !self.verify_sample(color_format, color_image.get(), sample_ndx, ASPECT_COLOR, &name)? {
                result += &format!(" {name}");
            }
        }

        if result.is_empty() {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }

    /// `DepthResolveImagelessTestInstance::iterate`
    fn iterate_depth_stencil_resolve(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = self.params;
        let sample_count_flag = vk::SampleCountFlags::_4;
        let sample_count = 4u32;
        let color_format = params.color_format;
        let ds_format = params.ds_format;
        let color_usage = color_image_usage(&params);
        let ds_usage = ds_image_usage(&params);

        let color_image = self.make_image(color_format, color_usage, sample_count_flag)?;
        let color_attachment = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;

        let color_resolve_image = self.make_image(color_format, color_usage, vk::SampleCountFlags::_1)?;
        let color_resolve_attachment = make_image_view(
            device,
            color_resolve_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;
        let color_resolve_buffer =
            self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        let depth_buffer_size = (WIDTH * HEIGHT * 4) as vk::DeviceSize;
        let stencil_buffer_size = (WIDTH * HEIGHT) as vk::DeviceSize;
        let ds_image = self.make_image(ds_format, ds_usage, sample_count_flag)?;
        let ds_attachment = make_image_view(
            device,
            ds_image.get(),
            vk::ImageViewType::_2D,
            ds_format,
            ds_subresource_range(),
        )?;

        let ds_resolve_image = self.make_image(ds_format, ds_usage, vk::SampleCountFlags::_1)?;
        let ds_resolve_attachment = make_image_view(
            device,
            ds_resolve_image.get(),
            vk::ImageViewType::_2D,
            ds_format,
            ds_subresource_range(),
        )?;
        let depth_resolve_buffer = self.make_host_buffer(
            depth_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        )?;
        let stencil_resolve_buffer = self.make_host_buffer(
            stencil_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        )?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_render_pass(device, color_format, ds_format, sample_count_flag, sample_count_flag)?;
        let framebuffer = make_imageless_framebuffer(
            device,
            *render_pass,
            color_format,
            color_usage,
            ds_format,
            params.extended_flags,
            ds_usage,
            ASPECT_COLOR | ASPECT_DEPTH_STENCIL,
            0,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            ASPECT_DEPTH_STENCIL,
            sample_count_flag,
            0,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let vertex_array = get_vertices(params.test_type);
        let vertex_count = (vertex_array.len() / 4) as u32;
        let vertex_buffer = self.make_vertex_buffer(&vertex_array)?;

        begin_command_buffer(device, cmd)?;
        begin_imageless_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            &[
                *color_attachment,
                *ds_attachment,
                *color_resolve_attachment,
                *ds_resolve_attachment,
            ],
            &[clear_color_value(), clear_depth_stencil_value()],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        record_color_copy(
            device,
            cmd,
            color_resolve_image.get(),
            color_resolve_buffer.get(),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );
        record_depth_stencil_copy(
            device,
            cmd,
            ds_resolve_image.get(),
            depth_resolve_buffer.get(),
            stencil_resolve_buffer.get(),
            vk::AccessFlags::empty(),
            vk::PipelineStageFlags::BOTTOM_OF_PIPE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let mut result = String::new();
        if !self.verify_buffer(&color_resolve_buffer, "ResolveColor", ASPECT_COLOR, None, None)? {
            result += " ResolveColor";
        }
        if !self.verify_buffer(&depth_resolve_buffer, "ResolveDepth", ASPECT_DEPTH, None, None)? {
            result += " ResolveDepth";
        }
        if !self.verify_buffer(&stencil_resolve_buffer, "ResolveStencil", ASPECT_STENCIL, None, None)? {
            result += " ResolveStencil";
        }

        // Parse color, depth and stencil aspects of separate samples of the multisample images
        for (prefix, src_format, src_image, aspect) in [
            ("Color", color_format, color_image.get(), ASPECT_COLOR),
            ("Depth", ds_format, ds_image.get(), ASPECT_DEPTH),
            ("Stencil", ds_format, ds_image.get(), ASPECT_STENCIL),
        ] {
            for sample_ndx in 0..sample_count {
                let name = format!("{prefix}{sample_ndx}");
                if !self.verify_sample(src_format, src_image, sample_ndx, aspect, &name)? {
                    result += &format!(" {name}");
                }
            }
        }

        if result.is_empty() {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(format!(
                "Following parts of image are incorrect:{result}"
            )))
        }
    }

    /// `MultisubpassTestInstance::iterate`
    fn iterate_multisubpass(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = self.params;
        let color_format = params.color_format;
        let color_usage = color_image_usage(&params);
        let usage = color_usage | vk::ImageUsageFlags::INPUT_ATTACHMENT;

        let color0_image = self.make_image(color_format, usage, vk::SampleCountFlags::_1)?;
        let color0_attachment = make_image_view(
            device,
            color0_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;
        let color0_buffer = self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        let color1_image = self.make_image(color_format, usage, vk::SampleCountFlags::_1)?;
        let color1_attachment = make_image_view(
            device,
            color1_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;
        let color1_buffer = self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        let descriptor_type = vk::DescriptorType::INPUT_ATTACHMENT;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_descriptor_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *color0_attachment,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(descriptor_type)
            .image_info(&image_descriptor_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let render_pass = make_multisubpass_render_pass(device, color_format)?;
        let framebuffer = make_imageless_framebuffer(
            device,
            *render_pass,
            color_format,
            color_usage,
            params.ds_format,
            params.extended_flags,
            vk::ImageUsageFlags::empty(),
            ASPECT_NONE,
            1,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let binaries = context.get_binary_collection();
        let vert_module0 = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module0 = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout0 = make_pipeline_layout(device, &[])?;
        let pipeline0 = make_graphics_pipeline(
            device,
            *pipeline_layout0,
            *render_pass,
            *vert_module0,
            *frag_module0,
            ASPECT_NONE,
            vk::SampleCountFlags::_1,
            0,
        )?;

        let vert_module1 = create_shader_module(device, binaries.get("vert1")?)?;
        let frag_module1 = create_shader_module(device, binaries.get("frag1")?)?;
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout1 = make_pipeline_layout(device, &set_layouts)?;
        let pipeline1 = make_graphics_pipeline(
            device,
            *pipeline_layout1,
            *render_pass,
            *vert_module1,
            *frag_module1,
            ASPECT_NONE,
            vk::SampleCountFlags::_1,
            1,
        )?;

        let vertex0_array = get_vertices(params.test_type);
        let vertex0_count = (vertex0_array.len() / 4) as u32;
        let vertex0_buffer = self.make_vertex_buffer(&vertex0_array)?;
        let vertex1_array = get_full_quad_vertices();
        let vertex1_count = (vertex1_array.len() / 4) as u32;
        let vertex1_buffer = self.make_vertex_buffer(&vertex1_array)?;

        begin_command_buffer(device, cmd)?;
        begin_imageless_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            &[*color0_attachment, *color1_attachment],
            &[clear_color_value()],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline0);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex0_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertex0_count, 1, 0, 0);

            device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline1);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex1_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout1,
                0,
                &[*descriptor_set],
                &[],
            );
            device.cmd_draw(cmd, vertex1_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        record_color_copy(
            device,
            cmd,
            color0_image.get(),
            color0_buffer.get(),
            vk::ImageLayout::GENERAL,
        );
        record_color_copy(
            device,
            cmd,
            color1_image.get(),
            color1_buffer.get(),
            vk::ImageLayout::GENERAL,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        self.verify_subpass_results(&color0_buffer, &color1_buffer)
    }

    /// `DifferentAttachmentsTestInstance::iterate`
    fn iterate_different_attachments(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = self.params;
        let color_format = params.color_format;
        let color_usage = color_image_usage(&params);
        let usage = color_usage | vk::ImageUsageFlags::INPUT_ATTACHMENT;

        let color0_image = self.make_image(color_format, usage, vk::SampleCountFlags::_1)?;
        let color0_attachment = make_image_view(
            device,
            color0_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;
        let color0_buffer = self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        let color1_image = self.make_image(color_format, usage, vk::SampleCountFlags::_1)?;
        let color1_attachment = make_image_view(
            device,
            color1_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range(),
        )?;
        let color1_buffer = self.make_host_buffer(self.color_buffer_size(), vk::BufferUsageFlags::TRANSFER_DST)?;

        let render_pass = make_single_attachment_render_pass(device, color_format)?;
        let framebuffer = make_imageless_framebuffer(
            device,
            *render_pass,
            color_format,
            color_usage,
            params.ds_format,
            params.extended_flags,
            vk::ImageUsageFlags::empty(),
            ASPECT_NONE,
            0,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            ASPECT_NONE,
            vk::SampleCountFlags::_1,
            0,
        )?;

        let vertex_array = get_vertices(params.test_type);
        let vertex_count = (vertex_array.len() / 4) as u32;
        let vertex_buffer = self.make_vertex_buffer(&vertex_array)?;

        begin_command_buffer(device, cmd)?;
        for attachment in [*color0_attachment, *color1_attachment] {
            begin_imageless_render_pass(
                device,
                cmd,
                *render_pass,
                *framebuffer,
                &[attachment],
                &[clear_color_value()],
            );
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_draw(cmd, vertex_count, 1, 0, 0);
            }
            end_render_pass(device, cmd);
        }

        record_color_copy(
            device,
            cmd,
            color0_image.get(),
            color0_buffer.get(),
            vk::ImageLayout::GENERAL,
        );
        record_color_copy(
            device,
            cmd,
            color1_image.get(),
            color1_buffer.get(),
            vk::ImageLayout::GENERAL,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        self.verify_subpass_results(&color0_buffer, &color1_buffer)
    }

    fn verify_subpass_results(
        &self,
        color0_buffer: &BufferWithMemory<'_>,
        color1_buffer: &BufferWithMemory<'_>,
    ) -> TestOutcome {
        let mut result = String::new();
        if !self.verify_buffer(color0_buffer, "ColorSubpass0", ASPECT_COLOR, None, Some(0))? {
            result += " ColorSubpass0";
        }
        if !self.verify_buffer(color1_buffer, "ColorSubpass1", ASPECT_COLOR, None, Some(1))? {
            result += " ColorSubpass1";
        }

        if result.is_empty() {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(format!(
                "Following parts of image are incorrect:{result}"
            )))
        }
    }
}

impl TestInstance for ImagelessInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.params.test_type {
            TestType::Color => self.iterate_color(),
            TestType::DepthStencil => self.iterate_depth_stencil(),
            TestType::ColorResolve => self.iterate_color_resolve(),
            TestType::DepthStencilResolve => self.iterate_depth_stencil_resolve(),
            TestType::Multisubpass => self.iterate_multisubpass(),
            TestType::DifferentAttachments => self.iterate_different_attachments(),
        }
    }
}

/// `createTests`
pub fn create_tests(name: &'static str) -> TestCaseGroup {
    let mut imageless_framebuffer_group = TestCaseGroup::new(name);

    for (extended_flags, flags_name) in [(false, "none"), (true, "extended_flags")] {
        let mut flags_group = TestCaseGroup::new(flags_name);

        let case = |name: &'static str, test_type: TestType, ds_format: vk::Format| {
            Box::new(ImagelessTestCase {
                name,
                params: TestParameters {
                    test_type,
                    color_format: vk::Format::R8G8B8A8_UNORM,
                    ds_format,
                    extended_flags,
                },
            }) as Box<dyn TestCase>
        };
        // Color only test
        flags_group.add_child(case("color", TestType::Color, vk::Format::UNDEFINED));
        // Color and depth/stencil test
        flags_group.add_child(case(
            "depth_stencil",
            TestType::DepthStencil,
            vk::Format::D24_UNORM_S8_UINT,
        ));
        // Color and color resolve test
        flags_group.add_child(case("color_resolve", TestType::ColorResolve, vk::Format::UNDEFINED));
        // Color, depth and depth resolve test (interaction with VK_KHR_depth_stencil_resolve)
        flags_group.add_child(case(
            "depth_stencil_resolve",
            TestType::DepthStencilResolve,
            vk::Format::D24_UNORM_S8_UINT,
        ));
        // Multi-subpass test
        flags_group.add_child(case("multisubpass", TestType::Multisubpass, vk::Format::UNDEFINED));
        // Different attachments in multiple render passes
        flags_group.add_child(case(
            "different_attachments",
            TestType::DifferentAttachments,
            vk::Format::UNDEFINED,
        ));

        imageless_framebuffer_group.add_child(flags_group);
    }

    imageless_framebuffer_group
}

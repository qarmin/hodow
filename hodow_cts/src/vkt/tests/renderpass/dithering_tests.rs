// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassDitheringTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// VK_EXT_legacy_dithering: the same quad is rendered twice into identical targets, once without and once
// with dithering enabled, and the two results must agree within one ULP per channel (four for additive
// blending); depth and stencil must not change at all. The shaders are in
// `shaders/manifest/renderpass_dithering.toml`.
//
// Upstream creates a private instance and device (a singleton) with the legacy dithering feature enabled;
// here the feature is part of the shared device's feature chain, so the case runs on `Context`'s device.

use std::ffi::CStr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrCreateRenderpass2ExtensionDeviceCommands};

use crate::generated::shaders::renderpass_dithering::DITHERING;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

// ~1 ULP in D24_UNORM (1/2^24 == 0.00000006)
const BASE_DEPTH_VALUE: u32 = 0b0011_1110_0000_0000_0000_0000_0000_0000; // 0.125f
const ONE_ULP_MORE_DEPTH_VALUE: u32 = 0b0011_1110_0000_0000_0000_0000_0000_0101; // 0.125000074506f
const ONE_ULP_LESS_DEPTH_VALUE: u32 = 0b0011_1101_1111_1111_1111_1111_1111_0111; // 0.124999932945f

/// `TestParams`
#[derive(Clone)]
struct TestParams {
    render_areas: Vec<vk::Viewport>,
    color_formats: Vec<vk::Format>,
    override_color: [f32; 4],
    image_size: (u32, u32),
    depth_stencil_format: vk::Format,
    group_params: GroupParams,
    src_factor: vk::BlendFactor,
    dst_factor: vk::BlendFactor,
    stencil_clear_value: u32,
    depth_compare_op: vk::CompareOp,
    depth_clear_value: f32,
    blending: bool,
    revision2: bool,
}

impl TestParams {
    fn use_depth_stencil(&self) -> bool {
        self.depth_stencil_format != vk::Format::UNDEFINED
    }

    /// Additive blending accumulates four draws, and a driver may dither each of them.
    fn additive_blending(&self) -> bool {
        self.blending && self.dst_factor == vk::BlendFactor::ONE
    }
}

/// `Vertex4RGBA`
#[derive(Clone, Copy)]
#[allow(dead_code)]
struct Vertex4Rgba {
    position: [f32; 4],
    color: [f32; 4],
}

/// `createQuad()`
fn create_quad() -> Vec<Vertex4Rgba> {
    let size = 1.0f32;
    let red = [1.0f32, 0.0, 0.0, 1.0];
    let green = [0.0f32, 1.0, 0.0, 1.0];
    let blue = [0.0f32, 0.0, 1.0, 1.0];
    let white = [1.0f32, 1.0, 1.0, 1.0];
    let depth_value = f32::from_bits(BASE_DEPTH_VALUE);
    let lower_left = Vertex4Rgba {
        position: [-size, -size, depth_value, 1.0],
        color: red,
    };
    let lower_right = Vertex4Rgba {
        position: [size, -size, depth_value, 1.0],
        color: green,
    };
    let upper_left = Vertex4Rgba {
        position: [-size, size, depth_value, 1.0],
        color: blue,
    };
    let upper_right = Vertex4Rgba {
        position: [size, size, depth_value, 1.0],
        color: white,
    };

    vec![
        lower_left,
        upper_left,
        lower_right,
        upper_left,
        upper_right,
        lower_right,
    ]
}

/// `createQuad(color)`
fn create_quad_with_color(color: [f32; 4]) -> Vec<Vertex4Rgba> {
    let size = 1.0f32;
    let depth_value = f32::from_bits(BASE_DEPTH_VALUE);
    let lower_left = Vertex4Rgba {
        position: [-size, -size, depth_value, 1.0],
        color,
    };
    let lower_right = Vertex4Rgba {
        position: [size, -size, depth_value, 1.0],
        color,
    };
    let upper_left = Vertex4Rgba {
        position: [-size, size, depth_value, 1.0],
        color,
    };
    let upper_right = Vertex4Rgba {
        position: [size, size, depth_value, 1.0],
        color,
    };

    vec![
        lower_left,
        upper_left,
        lower_right,
        upper_left,
        upper_right,
        lower_right,
    ]
}

fn viewport(x: f32, y: f32, width: f32, height: f32) -> vk::Viewport {
    vk::Viewport {
        x,
        y,
        width,
        height,
        min_depth: 0.0,
        max_depth: 1.0,
    }
}

fn rect_2d(size: (u32, u32)) -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: size.0,
            height: size.1,
        },
    }
}

/// Bytes per texel of the colour formats the tests use.
fn color_texel_size(format: vk::Format) -> usize {
    if format == vk::Format::R8G8B8A8_UNORM { 4 } else { 2 }
}

/// The four channels of one texel as integers, in R, G, B, A order (what `getPixelUint` yields).
fn unpack_texel(format: vk::Format, bytes: &[u8]) -> [u32; 4] {
    if format == vk::Format::R8G8B8A8_UNORM {
        return [
            u32::from(bytes[0]),
            u32::from(bytes[1]),
            u32::from(bytes[2]),
            u32::from(bytes[3]),
        ];
    }
    let v = u32::from(u16::from_le_bytes([bytes[0], bytes[1]]));
    match format {
        vk::Format::R5G6B5_UNORM_PACK16 => [v >> 11, (v >> 5) & 0x3f, v & 0x1f, 0],
        vk::Format::R4G4B4A4_UNORM_PACK16 => [v >> 12, (v >> 8) & 0xf, (v >> 4) & 0xf, v & 0xf],
        _ => [v >> 11, (v >> 6) & 0x1f, (v >> 1) & 0x1f, v & 0x1],
    }
}

/// `de::toLower(getFormatStr(format)).substr(10)`
fn format_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R8G8B8A8_UNORM => "r8g8b8a8_unorm",
        vk::Format::R5G6B5_UNORM_PACK16 => "r5g6b5_unorm_pack16",
        vk::Format::R4G4B4A4_UNORM_PACK16 => "r4g4b4a4_unorm_pack16",
        _ => "r5g5b5a1_unorm_pack16",
    }
}

/// `DitheringTest`
struct DitheringTest {
    name: String,
    params: TestParams,
}

impl TestCase for DitheringTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let params = &self.params;

        match params.group_params.rendering_type {
            RenderingType::RenderPass2 => context.require_device_functionality("VK_KHR_create_renderpass2")?,
            RenderingType::DynamicRendering => context.require_device_functionality("VK_KHR_dynamic_rendering")?,
            RenderingType::Legacy => {}
        }

        context.require_device_functionality("VK_EXT_legacy_dithering")?;

        let extension_properties = unsafe {
            context
                .get_instance()
                .enumerate_device_extension_properties(context.get_physical_device(), None)
        }
        .vk_check("vkEnumerateDeviceExtensionProperties")?;
        let spec_version = extension_properties
            .iter()
            .find(|property| {
                unsafe { CStr::from_ptr(property.extension_name.as_ptr()) }.to_string_lossy()
                    == "VK_EXT_legacy_dithering"
            })
            .map_or(0, |property| property.spec_version);

        if params.revision2 {
            context.require_device_functionality("VK_KHR_maintenance5")?;

            if spec_version < 2 {
                return Err(TestError::NotSupported(
                    "VK_EXT_legacy_dithering specVersion at least 2 is required".to_string(),
                ));
            }
        } else if spec_version > 1 {
            return Err(TestError::NotSupported(
                "VK_EXT_legacy_dithering specVersion at 1 is required".to_string(),
            ));
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        for &format in &params.color_formats {
            let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST;
            let result = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    usage,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if result.is_err() {
                return Err(TestError::NotSupported("Color format not supported".to_string()));
            }
        }

        if params.use_depth_stencil() {
            let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST;
            let result = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    params.depth_stencil_format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    usage,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if result.is_err() {
                return Err(TestError::NotSupported(
                    "Depth/stencil format not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DITHERING.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DitheringTestInstance {
            context,
            params: &self.params,
        })
    }
}

/// `DitheringTestInstance::DrawResources`; the fields are declared in the order they have to be destroyed in.
struct DrawResources<'a> {
    framebuffer: Option<Unique<'a, vk::Framebuffer>>,
    render_pass: Option<Unique<'a, vk::RenderPass>>,
    pipeline: Unique<'a, vk::Pipeline>,
    image_views: Vec<Unique<'a, vk::ImageView>>,
    depth_stencil_image_view: Option<Unique<'a, vk::ImageView>>,
    attachment_images: Vec<ImageWithMemory<'a>>,
    depth_stencil_image: Option<ImageWithMemory<'a>>,
}

/// `DitheringTestInstance`
struct DitheringTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a TestParams,
}

/// `clearColorImage`: clears `image` and leaves it in `new_layout`, in a submission of its own.
fn clear_color_image(
    context: &Context<'_>,
    image: vk::Image,
    color: [f32; 4],
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    dst_access: vk::AccessFlags,
    dst_stage: vk::PipelineStageFlags,
) -> Result<(), TestError> {
    let device = context.get_device();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

    let pre_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        old_layout,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        range,
    );
    let post_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        dst_access,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        new_layout,
        image,
        range,
    );
    let clear_value = vk::ClearColorValue { float32: color };

    begin_command_buffer(device, *cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            *cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_barrier],
        );
        device.cmd_clear_color_image(
            *cmd,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_value,
            &[range],
        );
        device.cmd_pipeline_barrier(
            *cmd,
            vk::PipelineStageFlags::TRANSFER,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_barrier],
        );
    }
    end_command_buffer(device, *cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *cmd)
}

/// `clearDepthStencilImage`
#[allow(clippy::too_many_arguments)]
fn clear_depth_stencil_image(
    context: &Context<'_>,
    image: vk::Image,
    depth: f32,
    stencil: u32,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    dst_access: vk::AccessFlags,
    dst_stage: vk::PipelineStageFlags,
) -> Result<(), TestError> {
    let device = context.get_device();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);

    let pre_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        old_layout,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        range,
    );
    let post_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        dst_access,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        new_layout,
        image,
        range,
    );
    let clear_value = vk::ClearDepthStencilValue { depth, stencil };

    begin_command_buffer(device, *cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            *cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_barrier],
        );
        device.cmd_clear_depth_stencil_image(
            *cmd,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_value,
            &[range],
        );
        device.cmd_pipeline_barrier(
            *cmd,
            vk::PipelineStageFlags::TRANSFER,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_barrier],
        );
    }
    end_command_buffer(device, *cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *cmd)
}

/// `pipeline::readColorAttachment` / `readDepthAttachment` / `readStencilAttachment`: one aspect of an image
/// that is in `TRANSFER_SRC_OPTIMAL`, copied to a host-visible buffer and returned.
fn read_image_aspect(
    context: &Context<'_>,
    image: vk::Image,
    barrier_aspect: vk::ImageAspectFlags,
    copy_aspect: vk::ImageAspectFlags,
    size: (u32, u32),
    texel_size: usize,
) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;

    let buffer_size = size.0 as usize * size.1 as usize * texel_size;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let image_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            | vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(barrier_aspect, 0, 1, 0, 1),
    );
    let buffer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    let copy_region = vk::BufferImageCopy {
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

    begin_command_buffer(device, *cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            *cmd,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
        device.cmd_copy_image_to_buffer(
            *cmd,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer.get(),
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            *cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[buffer_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, *cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

    let allocation = buffer.get_allocation();
    invalidate_alloc(device, allocation)?;
    Ok(unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), buffer_size) }.to_vec())
}

/// `createRenderPassFramebuffer`'s render pass, for either `VkRenderPassCreateInfo` form.
fn create_render_pass<'a>(
    device: &'a Device,
    params: &TestParams,
    use_dithering: bool,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let use_depth_stencil = params.use_depth_stencil();
    let subpass_flags = if use_dithering {
        vk::SubpassDescriptionFlags::ENABLE_LEGACY_DITHERING_EXT
    } else {
        vk::SubpassDescriptionFlags::empty()
    };

    if params.group_params.rendering_type == RenderingType::RenderPass2 {
        let mut attachment_descriptions: Vec<vk::AttachmentDescription2> = Vec::new();
        let mut attachment_references: Vec<vk::AttachmentReference2> = Vec::new();

        for (i, &format) in params.color_formats.iter().enumerate() {
            attachment_descriptions.push(vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::AttachmentDescriptionFlags::empty(),
                format,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::LOAD,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            });
            attachment_references.push(vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: i as u32,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                aspect_mask: vk::ImageAspectFlags::COLOR,
            });
        }

        let depth_stencil_reference = vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: attachment_references.len() as u32,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            aspect_mask: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
        };
        if use_depth_stencil {
            attachment_descriptions.push(vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: params.depth_stencil_format,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::LOAD,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::LOAD,
                stencil_store_op: vk::AttachmentStoreOp::STORE,
                initial_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            });
        }

        let subpass_description = vk::SubpassDescription2 {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: subpass_flags,
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: 0,
            input_attachments: std::ptr::null(),
            color_attachment_count: attachment_references.len() as u32,
            color_attachments: attachment_references.as_ptr(),
            resolve_attachments: std::ptr::null(),
            depth_stencil_attachment: if use_depth_stencil {
                &depth_stencil_reference
            } else {
                std::ptr::null()
            },
            preserve_attachment_count: 0,
            preserve_attachments: std::ptr::null(),
        };
        let info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachment_descriptions.len() as u32,
            attachments: attachment_descriptions.as_ptr(),
            subpass_count: 1,
            subpasses: &subpass_description,
            dependency_count: 0,
            dependencies: std::ptr::null(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };
        let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        return Ok(Unique::new(device, handle));
    }

    let mut attachment_descriptions: Vec<vk::AttachmentDescription> = Vec::new();
    let mut attachment_references: Vec<vk::AttachmentReference> = Vec::new();

    for (i, &format) in params.color_formats.iter().enumerate() {
        attachment_descriptions.push(
            vk::AttachmentDescription::builder()
                .format(format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .build(),
        );
        attachment_references.push(
            vk::AttachmentReference::builder()
                .attachment(i as u32)
                .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        );
    }

    let depth_stencil_reference = vk::AttachmentReference::builder()
        .attachment(attachment_references.len() as u32)
        .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .build();
    if use_depth_stencil {
        attachment_descriptions.push(
            vk::AttachmentDescription::builder()
                .format(params.depth_stencil_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::LOAD)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .build(),
        );
    }

    let mut subpass = vk::SubpassDescription::builder()
        .flags(subpass_flags)
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&attachment_references);
    if use_depth_stencil {
        subpass = subpass.depth_stencil_attachment(&depth_stencil_reference);
    }
    let subpasses = [subpass.build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, handle))
}

/// The `makeGraphicsPipeline` call of `createDrawResources`.
fn create_pipeline<'a>(
    device: &'a Device,
    params: &TestParams,
    layout: vk::PipelineLayout,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    render_pass: vk::RenderPass,
    use_dithering: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let use_depth_stencil = params.use_depth_stencil();
    let dynamic_rendering = params.group_params.rendering_type == RenderingType::DynamicRendering;

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

    let bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<Vertex4Rgba>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let attributes = [
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
            offset: (std::mem::size_of::<f32>() * 4) as u32,
        },
    ];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);

    let blend_state = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(params.blending)
        .src_color_blend_factor(params.src_factor)
        .dst_color_blend_factor(params.dst_factor)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ONE)
        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(
            vk::ColorComponentFlags::R
                | vk::ColorComponentFlags::G
                | vk::ColorComponentFlags::B
                | vk::ColorComponentFlags::A,
        )
        .build();
    let color_blend_attachments = vec![blend_state; params.color_formats.len()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&color_blend_attachments)
        .blend_constants([0.0, 0.0, 0.0, 0.0]);

    let stencil_op_state = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::EQUAL)
        .compare_mask(0xff)
        .write_mask(0xff)
        .reference(0x81)
        .build();
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(use_depth_stencil)
        .depth_write_enable(use_depth_stencil)
        .depth_compare_op(params.depth_compare_op)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(use_depth_stencil)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(1.0)
        .alpha_to_coverage_enable(false)
        .alpha_to_one_enable(false);

    let dynamic_states = [vk::DynamicState::VIEWPORT];
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let viewports = [viewport(
        0.0,
        0.0,
        params.image_size.0 as f32,
        params.image_size.1 as f32,
    )];
    let scissors = [rect_2d(params.image_size)];
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

    let depth_format = if use_depth_stencil {
        params.depth_stencil_format
    } else {
        vk::Format::UNDEFINED
    };
    let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
        .view_mask(0)
        .color_attachment_formats(&params.color_formats)
        .depth_attachment_format(depth_format)
        .stencil_attachment_format(depth_format);

    // VUID-vkCmdDraw-None-09643
    let mut pipeline_create_flags2_info = vk::PipelineCreateFlags2CreateInfo {
        flags: vk::PipelineCreateFlags2::ENABLE_LEGACY_DITHERING_EXT,
        ..Default::default()
    };

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .dynamic_state(&dynamic_state)
        .layout(layout)
        .render_pass(render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    if dynamic_rendering {
        info = info.push_next(&mut rendering_create_info);
        if params.revision2 && use_dithering {
            info = info.push_next(&mut pipeline_create_flags2_info);
        }
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

impl<'a> DitheringTestInstance<'a> {
    fn create_image(&self, format: vk::Format, usage: vk::ImageUsageFlags) -> Result<ImageWithMemory<'a>, TestError> {
        let context = self.context;
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: self.params.image_size.0,
                height: self.params.image_size.1,
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
            MemoryRequirement::ANY,
        )
    }

    /// `createDrawResources`
    fn create_draw_resources(
        &self,
        layout: vk::PipelineLayout,
        vertex_module: vk::ShaderModule,
        fragment_module: vk::ShaderModule,
        use_dithering: bool,
    ) -> Result<DrawResources<'a>, TestError> {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let identity_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let mut attachment_images = Vec::new();
        let mut image_views = Vec::new();
        for &format in &params.color_formats {
            let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST;
            let image = self.create_image(format, usage)?;
            let image_view = make_image_view(device, image.get(), vk::ImageViewType::_2D, format, identity_range)?;

            // Clear and transition image to desired layout for easier looping later when rendering.
            clear_color_image(
                context,
                image.get(),
                [0.0, 0.0, 0.0, 1.0],
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::AccessFlags::COLOR_ATTACHMENT_READ
                    | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                    | vk::AccessFlags::SHADER_READ
                    | vk::AccessFlags::SHADER_WRITE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::FRAGMENT_SHADER,
            )?;

            attachment_images.push(image);
            image_views.push(image_view);
        }

        let mut depth_stencil_image = None;
        let mut depth_stencil_image_view = None;
        if params.use_depth_stencil() {
            let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST;
            let image = self.create_image(params.depth_stencil_format, usage)?;
            let range =
                make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
            let image_view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                params.depth_stencil_format,
                range,
            )?;

            clear_depth_stencil_image(
                context,
                image.get(),
                params.depth_clear_value,
                params.stencil_clear_value,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            )?;

            depth_stencil_image = Some(image);
            depth_stencil_image_view = Some(image_view);
        }

        let mut render_pass = None;
        let mut framebuffer = None;
        if params.group_params.rendering_type != RenderingType::DynamicRendering {
            let created_render_pass = create_render_pass(device, params, use_dithering)?;

            let mut views: Vec<vk::ImageView> = image_views.iter().map(|view| **view).collect();
            if let Some(view) = &depth_stencil_image_view {
                views.push(**view);
            }
            framebuffer = Some(make_framebuffer(
                device,
                *created_render_pass,
                &views,
                params.image_size.0,
                params.image_size.1,
                1,
            )?);
            render_pass = Some(created_render_pass);
        }

        let render_pass_handle = render_pass
            .as_ref()
            .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
        let pipeline = create_pipeline(
            device,
            params,
            layout,
            vertex_module,
            fragment_module,
            render_pass_handle,
            use_dithering,
        )?;

        Ok(DrawResources {
            framebuffer,
            render_pass,
            pipeline,
            image_views,
            depth_stencil_image_view,
            attachment_images,
            depth_stencil_image,
        })
    }

    /// `render`
    fn render(
        &self,
        resources: &DrawResources<'_>,
        vertex_buffer: vk::Buffer,
        vp: &vk::Viewport,
        use_dithering: bool,
    ) -> Result<(), TestError> {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let rendering_type = params.group_params.rendering_type;
        let use_depth_stencil = params.use_depth_stencil();

        // Clear color and transition image to desired layout.
        {
            let dst_access = vk::AccessFlags::COLOR_ATTACHMENT_READ
                | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                | vk::AccessFlags::SHADER_READ
                | vk::AccessFlags::SHADER_WRITE;
            let dst_stage = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::FRAGMENT_SHADER;
            let clear_color = if params.blending {
                [0.0, 1.0, 0.0, 1.0]
            } else {
                [0.0, 0.0, 0.0, 1.0]
            };

            for image in &resources.attachment_images {
                clear_color_image(
                    context,
                    image.get(),
                    clear_color,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    dst_access,
                    dst_stage,
                )?;
            }
        }

        // Clear depth/stencil.
        if let Some(image) = &resources.depth_stencil_image {
            clear_depth_stencil_image(
                context,
                image.get(),
                params.depth_clear_value,
                params.stencil_clear_value,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            )?;
        }

        // Rendering.
        let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let draw_count = if params.additive_blending() { 4 } else { 1 };

        begin_command_buffer(device, cmd)?;

        if rendering_type == RenderingType::DynamicRendering {
            let color_attachments: Vec<vk::RenderingAttachmentInfo> = resources
                .image_views
                .iter()
                .map(|image_view| {
                    vk::RenderingAttachmentInfo::builder()
                        .image_view(**image_view)
                        .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                        .resolve_mode(vk::ResolveModeFlags::NONE)
                        .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                        .load_op(vk::AttachmentLoadOp::LOAD)
                        .store_op(vk::AttachmentStoreOp::STORE)
                        .clear_value(vk::ClearValue {
                            color: vk::ClearColorValue {
                                float32: [0.0, 0.0, 0.0, 1.0],
                            },
                        })
                        .build()
                })
                .collect();

            let mut depth_stencil_attachment = vk::RenderingAttachmentInfo::builder()
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: params.depth_clear_value,
                        stencil: params.stencil_clear_value,
                    },
                });
            if let Some(view) = &resources.depth_stencil_image_view {
                depth_stencil_attachment = depth_stencil_attachment.image_view(**view);
            }
            let depth_stencil_attachment = depth_stencil_attachment.build();

            let rendering_flags = if use_dithering {
                vk::RenderingFlags::ENABLE_LEGACY_DITHERING_EXT
            } else {
                vk::RenderingFlags::empty()
            };
            let mut rendering_info = vk::RenderingInfo::builder()
                .flags(rendering_flags)
                .render_area(rect_2d(params.image_size))
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments);
            if use_depth_stencil {
                rendering_info = rendering_info
                    .depth_attachment(&depth_stencil_attachment)
                    .stencil_attachment(&depth_stencil_attachment);
            }

            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        } else {
            let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(
                    resources
                        .render_pass
                        .as_ref()
                        .map_or_else(vk::RenderPass::null, |render_pass| **render_pass),
                )
                .framebuffer(
                    resources
                        .framebuffer
                        .as_ref()
                        .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer),
                )
                .render_area(rect_2d(params.image_size))
                .build();
            unsafe {
                if rendering_type == RenderingType::RenderPass2 {
                    let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                    device.cmd_begin_render_pass2_khr(cmd, &render_pass_begin_info, &subpass_begin_info);
                } else {
                    device.cmd_begin_render_pass(cmd, &render_pass_begin_info, vk::SubpassContents::INLINE);
                }
            }
        }

        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *resources.pipeline);
            device.cmd_set_viewport(cmd, 0, &[*vp]);
            for _ in 0..draw_count {
                device.cmd_draw(cmd, 6, 1, 0, 0);
            }
        }

        if rendering_type == RenderingType::DynamicRendering {
            unsafe { device.cmd_end_rendering(cmd) };

            // VUID-vkCmdBeginRendering-pRenderingInfo-09592
            let color_barriers: Vec<vk::ImageMemoryBarrier> = resources
                .attachment_images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        image.get(),
                        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &color_barriers,
                );
            }

            if let Some(image) = &resources.depth_stencil_image {
                let barrier = make_image_memory_barrier(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    image.get(),
                    make_image_subresource_range(
                        vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                        0,
                        1,
                        0,
                        1,
                    ),
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[barrier],
                    );
                }
            }
        } else if rendering_type == RenderingType::RenderPass2 {
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(cmd, &subpass_end_info) };
        } else {
            unsafe { device.cmd_end_render_pass(cmd) };
        }
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)
    }
}

impl TestInstance for DitheringTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();

        // createCommonResources
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("color_frag")?)?;

        let vertices = if params.blending {
            create_quad_with_color(params.override_color)
        } else {
            create_quad()
        };
        let vertex_buffer_size = std::mem::size_of_val(vertices.as_slice());
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                vertex_buffer_size as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let no_dithering = self.create_draw_resources(*pipeline_layout, *vertex_module, *fragment_module, false)?;
        let dithering = self.create_draw_resources(*pipeline_layout, *vertex_module, *fragment_module, true)?;

        for vp in &params.render_areas {
            self.render(&no_dithering, vertex_buffer.get(), vp, false)?;
            self.render(&dithering, vertex_buffer.get(), vp, true)?;

            // Check output matches to expected within one ULP.
            for (i, &format) in params.color_formats.iter().enumerate() {
                let texel_size = color_texel_size(format);
                let reference = read_image_aspect(
                    context,
                    no_dithering.attachment_images[i].get(),
                    vk::ImageAspectFlags::COLOR,
                    vk::ImageAspectFlags::COLOR,
                    params.image_size,
                    texel_size,
                )?;
                let result = read_image_aspect(
                    context,
                    dithering.attachment_images[i].get(),
                    vk::ImageAspectFlags::COLOR,
                    vk::ImageAspectFlags::COLOR,
                    params.image_size,
                    texel_size,
                )?;

                // 1 ULP will always be 1 bit difference no matter the format
                // However, we allow N ULP for additive blending tests since drivers may do dithering while rendering (per draw)
                // which can cause dither pattern to exceed 1ULP threshold with additive blending, see discussion in:
                // https://gitlab.khronos.org/Tracker/vk-gl-cts/-/issues/3785#note_384389
                let n_ulp: u32 = if params.additive_blending() { 4 } else { 1 };

                for (reference_texel, result_texel) in
                    reference.chunks_exact(texel_size).zip(result.chunks_exact(texel_size))
                {
                    let reference_channels = unpack_texel(format, reference_texel);
                    let result_channels = unpack_texel(format, result_texel);
                    if reference_channels
                        .iter()
                        .zip(&result_channels)
                        .any(|(a, b)| a.abs_diff(*b) > n_ulp)
                    {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }

            // Check depth/stencil
            if let (Some(reference_image), Some(result_image)) =
                (&no_dithering.depth_stencil_image, &dithering.depth_stencil_image)
            {
                let both = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;

                // Depth should be unaffected by dithering. The X8 byte of a D24 copy is undefined.
                let reference = read_image_aspect(
                    context,
                    reference_image.get(),
                    both,
                    vk::ImageAspectFlags::DEPTH,
                    params.image_size,
                    4,
                )?;
                let result = read_image_aspect(
                    context,
                    result_image.get(),
                    both,
                    vk::ImageAspectFlags::DEPTH,
                    params.image_size,
                    4,
                )?;
                for (reference_texel, result_texel) in reference.chunks_exact(4).zip(result.chunks_exact(4)) {
                    let reference_depth =
                        u32::from_le_bytes([reference_texel[0], reference_texel[1], reference_texel[2], 0]);
                    let result_depth = u32::from_le_bytes([result_texel[0], result_texel[1], result_texel[2], 0]);
                    if reference_depth != result_depth {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }

                // Stencil should be unaffected by dithering.
                let reference = read_image_aspect(
                    context,
                    reference_image.get(),
                    both,
                    vk::ImageAspectFlags::STENCIL,
                    params.image_size,
                    1,
                )?;
                let result = read_image_aspect(
                    context,
                    result_image.get(),
                    both,
                    vk::ImageAspectFlags::STENCIL,
                    params.image_size,
                    1,
                )?;
                if reference != result {
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createChildren`
fn create_children(dithering_tests: &mut TestCaseGroup, group_params: GroupParams, revision2: bool) {
    let image_dimensions = 256u32;
    let small_render_area_dimensions = 31u32;
    let max_render_offset = image_dimensions - small_render_area_dimensions;
    let extra_random_area_render_count = 10u32;
    let test_formats = [
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R5G6B5_UNORM_PACK16,
        vk::Format::R4G4B4A4_UNORM_PACK16,
        vk::Format::R5G5B5A1_UNORM_PACK16,
    ];

    let mut test_params = TestParams {
        render_areas: Vec::new(),
        color_formats: Vec::new(),
        override_color: [0.5, 0.0, 0.0, 1.0],
        image_size: (image_dimensions, image_dimensions),
        depth_stencil_format: vk::Format::UNDEFINED,
        group_params,
        src_factor: vk::BlendFactor::SRC_ALPHA,
        dst_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
        stencil_clear_value: 0x81,
        depth_compare_op: vk::CompareOp::LESS,
        depth_clear_value: 1.0,
        blending: false,
        revision2,
    };

    let small = small_render_area_dimensions as f32;
    let max_offset = max_render_offset as f32;

    // Complete render pass.
    test_params
        .render_areas
        .push(viewport(0.0, 0.0, image_dimensions as f32, image_dimensions as f32));

    // Base tests. Ensures dithering works and values are within one ULP.
    {
        let mut base_tests = TestCaseGroup::new("base");

        // Small render area, snapped to each side (Left, Right, Bottom, Top).
        test_params.render_areas.push(viewport(0.0, 99.0, small, small));
        test_params.render_areas.push(viewport(max_offset, 99.0, small, small));
        test_params.render_areas.push(viewport(99.0, 0.0, small, small));
        test_params.render_areas.push(viewport(99.0, max_offset, small, small));

        // Small render area, snapped to each corner (BotLeft, BotRight, TopLeft, TopRight).
        test_params.render_areas.push(viewport(0.0, 0.0, small, small));
        test_params.render_areas.push(viewport(max_offset, 0.0, small, small));
        test_params.render_areas.push(viewport(0.0, max_offset, small, small));
        test_params
            .render_areas
            .push(viewport(max_offset, max_offset, small, small));

        // Some random offsets; upstream seeds with the time, a fixed seed keeps a run reproducible.
        let mut state = 0x2545_f491u32;
        let mut next_random = move || {
            state ^= state << 13;
            state ^= state >> 17;
            state ^= state << 5;
            state
        };
        for _ in 0..extra_random_area_render_count {
            let mut x_offset = next_random() % (max_render_offset - 1);
            let mut y_offset = next_random() % (max_render_offset - 1);

            // Ensure odd offset
            x_offset |= 1;
            y_offset |= 1;

            test_params
                .render_areas
                .push(viewport(x_offset as f32, y_offset as f32, small, small));
        }

        for i in 0..test_formats.len() {
            test_params.color_formats.push(test_formats[i]);
            let i_format_name = format_name(test_formats[i]).to_string();
            base_tests.add_child(Box::new(DitheringTest {
                name: i_format_name.clone(),
                params: test_params.clone(),
            }) as Box<dyn TestCase>);

            for j in (i + 1)..test_formats.len() {
                test_params.color_formats.push(test_formats[j]);
                let j_format_name = format!("{i_format_name}_and_{}", format_name(test_formats[j]));
                base_tests.add_child(Box::new(DitheringTest {
                    name: j_format_name.clone(),
                    params: test_params.clone(),
                }) as Box<dyn TestCase>);

                for k in (j + 1)..test_formats.len() {
                    test_params.color_formats.push(test_formats[k]);
                    let k_format_name = format!("{j_format_name}_and_{}", format_name(test_formats[k]));
                    base_tests.add_child(Box::new(DitheringTest {
                        name: k_format_name,
                        params: test_params.clone(),
                    }) as Box<dyn TestCase>);

                    test_params.color_formats.pop();
                }

                test_params.color_formats.pop();
            }

            test_params.color_formats.pop();
        }

        dithering_tests.add_child(base_tests);
    }

    // Complete render pass.
    test_params.render_areas.clear(); // Need to reset all
    test_params
        .render_areas
        .push(viewport(0.0, 0.0, image_dimensions as f32, image_dimensions as f32));

    // Depth/stencil tests. Ensure dithering works with depth/stencil and it does not affect depth/stencil.
    {
        let mut depth_stencil_tests = TestCaseGroup::new("depth_stencil");

        let names = ["Less", "Greater", "Equal"];
        let stencil_values = [0x80u32, 0x82, 0x81];
        let depth_values = [
            f32::from_bits(ONE_ULP_LESS_DEPTH_VALUE),
            f32::from_bits(ONE_ULP_MORE_DEPTH_VALUE),
            f32::from_bits(BASE_DEPTH_VALUE),
        ];
        let compare_ops = [vk::CompareOp::LESS, vk::CompareOp::GREATER];

        test_params.depth_stencil_format = vk::Format::D24_UNORM_S8_UINT;
        for &format in &test_formats {
            test_params.color_formats.push(format);
            let name_of_format = format_name(format);

            for (j, &stencil_value) in stencil_values.iter().enumerate() {
                test_params.stencil_clear_value = stencil_value;

                for (k, &depth_value) in depth_values.iter().enumerate() {
                    test_params.depth_clear_value = depth_value;

                    for (l, &compare_op) in compare_ops.iter().enumerate() {
                        test_params.depth_compare_op = compare_op;
                        let name = format!("stencil{}_depth{}_op{}_{name_of_format}", names[j], names[k], names[l]);
                        depth_stencil_tests.add_child(Box::new(DitheringTest {
                            name,
                            params: test_params.clone(),
                        }) as Box<dyn TestCase>);
                    }
                }
            }
            test_params.color_formats.pop();
        }
        test_params.depth_stencil_format = vk::Format::UNDEFINED;

        dithering_tests.add_child(depth_stencil_tests);
    }

    // Blend tests. Ensure dithering works with blending.
    {
        let mut blend_tests = TestCaseGroup::new("blend");

        test_params.blending = true;
        for &format in &test_formats {
            test_params.color_formats.push(format);
            let name_of_format = format_name(format);

            test_params.override_color = [0.5, 0.0, 0.0, 1.0];
            test_params.src_factor = vk::BlendFactor::SRC_ALPHA;
            test_params.dst_factor = vk::BlendFactor::ONE_MINUS_SRC_ALPHA;
            blend_tests.add_child(Box::new(DitheringTest {
                name: format!("srcAlpha_{name_of_format}"),
                params: test_params.clone(),
            }) as Box<dyn TestCase>);

            test_params.override_color = [0.125, 0.0, 0.0, 1.0];
            test_params.src_factor = vk::BlendFactor::ONE;
            test_params.dst_factor = vk::BlendFactor::ONE;
            blend_tests.add_child(Box::new(DitheringTest {
                name: format!("additive_{name_of_format}"),
                params: test_params.clone(),
            }) as Box<dyn TestCase>);
            test_params.color_formats.pop();
        }
        test_params.blending = false;

        dithering_tests.add_child(blend_tests);
    }
}

/// `createRenderPassDitheringTests`
pub fn create_dithering_tests(group_params: GroupParams) -> TestCaseGroup {
    // Tests for VK_EXT_legacy_dithering
    let mut dithering_tests = TestCaseGroup::new("dithering");

    let mut revision1 = TestCaseGroup::new("v1");
    create_children(&mut revision1, group_params, false);
    dithering_tests.add_child(revision1);

    if group_params.rendering_type == RenderingType::DynamicRendering {
        let mut revision2 = TestCaseGroup::new("v2");
        create_children(&mut revision2, group_params, true);
        dithering_tests.add_child(revision2);
    }

    dithering_tests
}

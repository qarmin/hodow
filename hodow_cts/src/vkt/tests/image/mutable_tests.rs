// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageMutableTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `image.mutable.{2d,2d_array}`: an image created with a format and used through a view of
// another one of the same texel size, uploaded by clear, copy, store or draw and downloaded by copy, load or texture. The GLSL is generated
// by scripts/gen_image_mutable_manifest.py into shaders/manifest/image_mutable.toml, one program set per view format, image type and upload
// and download kind, found by `mutable_key`. `swapchain_mutable.headless.*` runs the same executor on a swapchain image of a headless surface
// (a device of its own with VK_KHR_swapchain_mutable_format; the other WSI platforms need a native window and stay gated), and the
// `_extended_flags` cases require the extension upstream asks for (`VK_KHR_extended_flags`) and so never get past `check_support`.

use std::collections::HashMap;
use std::ffi::c_void;
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtHeadlessSurfaceExtensionInstanceCommands, InstanceV1_1, KhrSurfaceExtensionInstanceCommands,
    KhrSwapchainExtensionDeviceCommands,
};

use super::image_texture::Texture;
use super::tests_util::{ImageType, get_image_type_name, map_image_type, map_image_view_type};
use crate::generated::shaders::image_mutable::ALL_SHARED_PROGRAM;
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess, TextureLevel, linear_to_srgb};
use crate::tcu::texture::{TextureChannelClass, map_vk_format};
use crate::tcu::vector::UVec4;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::api::case_util::{create_custom_instance, is_instance_extension_available};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Upload {
    Clear,
    Copy,
    Store,
    Draw,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Download {
    Copy,
    Load,
    Texture,
}

const UPLOADS: [Upload; 4] = [Upload::Clear, Upload::Copy, Upload::Store, Upload::Draw];
const DOWNLOADS: [Download; 3] = [Download::Copy, Download::Load, Download::Texture];

fn upload_string(upload: Upload) -> &'static str {
    match upload {
        Upload::Clear => "clear",
        Upload::Copy => "copy",
        Upload::Store => "store",
        Upload::Draw => "draw",
    }
}

fn download_string(download: Download) -> &'static str {
    match download {
        Download::Copy => "copy",
        Download::Load => "load",
        Download::Texture => "texture",
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ResolveAttachmentTestType {
    /// Not a resolve attachment test
    None,
    /// All attachments are mutable
    AllMutable,
    /// Only resolve attachment is mutable, multisampled color attachment is non-mutable
    RaMutable,
    /// Only multisampled color attachment is mutable, resolve attachment is non-mutable
    CaMutable,
}

/// `CaseDef`, without the swapchain's `wsiType`.
#[derive(Clone, Copy)]
struct CaseDef {
    image_type: ImageType,
    size: [u32; 3],
    num_layers: u32,
    image_format: vk::Format,
    view_format: vk::Format,
    upload: Upload,
    download: Download,
    is_format_list_test: bool,
    extended_flags: bool,
    resolve_attachment_test_type: ResolveAttachmentTestType,
    is_load_op_clear_test: bool,
}

const COLOR_TABLE_SIZE: usize = 4;

/// Reference color values for float color rendering, chosen so that the bit patterns reinterpreted as a 16-bit float are no NaN, inf or denorm.
const COLOR_TABLE_FLOAT: [[f32; 4]; COLOR_TABLE_SIZE] = [
    [0.00, 0.40, 0.80, 0.10],
    [0.50, 0.10, 0.90, 0.20],
    [0.20, 0.60, 1.00, 0.30],
    [0.30, 0.70, 0.00, 0.40],
];

/// Reference color values for integer color rendering. Negative values are avoided (even for SINT formats) so that sign extension does not
/// lead to NaN or inf values when they are reinterpreted with a float format.
const COLOR_TABLE_INT: [[i32; 4]; COLOR_TABLE_SIZE] = [
    [0x70707070, 0x3C3C3C3C, 0x65656565, 0x29292929],
    [0x3C3C3C3C, 0x65656565, 0x29292929, 0x70707070],
    [0x29292929, 0x70707070, 0x3C3C3C3C, 0x65656565],
    [0x65656565, 0x29292929, 0x70707070, 0x3C3C3C3C],
];

const S_FORMATS: [vk::Format; 23] = [
    vk::Format::R32G32B32A32_SFLOAT,
    vk::Format::R16G16B16A16_SFLOAT,
    vk::Format::R32G32_SFLOAT,
    vk::Format::R16G16_SFLOAT,
    vk::Format::R32_SFLOAT,
    vk::Format::R32G32B32A32_UINT,
    vk::Format::R16G16B16A16_UINT,
    vk::Format::R8G8B8A8_UINT,
    vk::Format::R32G32_UINT,
    vk::Format::R16G16_UINT,
    vk::Format::R32_UINT,
    vk::Format::R32G32B32A32_SINT,
    vk::Format::R16G16B16A16_SINT,
    vk::Format::R8G8B8A8_SINT,
    vk::Format::R32G32_SINT,
    vk::Format::R16G16_SINT,
    vk::Format::R32_SINT,
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::R8G8B8A8_SNORM,
    vk::Format::R8G8B8A8_SRGB,
    vk::Format::B8G8R8A8_UNORM,
    vk::Format::B8G8R8A8_SNORM,
    vk::Format::B8G8R8A8_SRGB,
];

fn is_uint_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|tcu_format| tcu_format.channel_class() == TextureChannelClass::UnsignedInteger)
}

fn is_int_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|tcu_format| tcu_format.channel_class() == TextureChannelClass::SignedInteger)
}

fn is_integer_format(format: vk::Format) -> bool {
    is_uint_format(format) || is_int_format(format)
}

fn is_srgb_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|tcu_format| tcu_format.order.is_srgb())
}

fn pixel_size(format: vk::Format) -> Result<u32, TestError> {
    map_vk_format(format)
        .and_then(|tcu_format| tcu_format.pixel_size())
        .ok_or_else(|| TestError::NotPorted(format!("{format:?} has no pixel size")))
}

/// `isFormatImageLoadStoreCapable`, for the formats of `S_FORMATS`.
fn is_format_image_load_store_capable(format: vk::Format) -> bool {
    !matches!(
        format,
        vk::Format::R8G8B8A8_SRGB | vk::Format::B8G8R8A8_UNORM | vk::Format::B8G8R8A8_SNORM | vk::Format::B8G8R8A8_SRGB
    )
}

/// `getFormatShortString`
fn format_short_string(format: vk::Format) -> String {
    format!("{format:?}").to_lowercase()
}

/// `getClearValueInt`
fn get_clear_value_int(case_def: &CaseDef, color_table_index: usize) -> [i32; 4] {
    // Small color values in the vertex buffer avoid round off errors from int-to-float conversions; otherwise the mask is chosen so that
    // no integer-based color value ends up reinterpreted as NaN, inf or denorm.
    let channel_mask: u32 = if case_def.upload == Upload::Draw {
        0xFF
    } else {
        let format = if matches!(case_def.upload, Upload::Clear | Upload::Copy) {
            case_def.image_format
        } else {
            case_def.view_format
        };
        match map_vk_format(format).and_then(|tcu_format| tcu_format.type_.channel_size()) {
            Some(1) => 0xFF,
            Some(2) => 0xFFFF,
            Some(4) => 0xFFFF_FFFF,
            _ => unreachable!("channel size of {format:?}"),
        }
    };
    COLOR_TABLE_INT[color_table_index].map(|value| (value as u32 & channel_mask) as i32)
}

fn is_srgb_conversion_required(case_def: &CaseDef) -> bool {
    (is_srgb_format(case_def.image_format) && case_def.upload == Upload::Clear)
        || (is_srgb_format(case_def.view_format) && matches!(case_def.upload, Upload::Draw | Upload::Store))
}

fn formats_are_compatible(format0: vk::Format, format1: vk::Format) -> bool {
    format0 == format1 || pixel_size(format0).ok() == pixel_size(format1).ok()
}

/// `getImageUsageForTestCase`
fn get_image_usage_for_test_case(case_def: &CaseDef) -> vk::ImageUsageFlags {
    let mut flags = vk::ImageUsageFlags::empty();
    flags |= match case_def.upload {
        Upload::Clear | Upload::Copy => vk::ImageUsageFlags::TRANSFER_DST,
        Upload::Draw => vk::ImageUsageFlags::COLOR_ATTACHMENT,
        Upload::Store => vk::ImageUsageFlags::STORAGE,
    };
    flags |= match case_def.download {
        Download::Texture => vk::ImageUsageFlags::SAMPLED,
        Download::Load => vk::ImageUsageFlags::STORAGE,
        Download::Copy => vk::ImageUsageFlags::TRANSFER_SRC,
    };
    // A view can only be created if the image has one of these usages.
    let view_required_flags =
        vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::COLOR_ATTACHMENT;
    if !flags.intersects(view_required_flags) {
        flags |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
    }
    flags
}

/// The key of the manifest entry of a case.
fn mutable_key(case_def: &CaseDef) -> String {
    let upload = match case_def.upload {
        Upload::Draw => "draw",
        Upload::Store => "store",
        _ => "other",
    };
    format!(
        "mut_{}_{}_{}_{}",
        get_image_type_name(case_def.image_type),
        format_short_string(case_def.view_format),
        upload,
        download_string(case_def.download)
    )
}

/// `getMaxAvailableSampleCount`: the highest sample count usable by the platform.
fn get_max_available_sample_count(
    context: &Context<'_>,
    format: vk::Format,
    image_type: vk::ImageType,
    usage: vk::ImageUsageFlags,
    flags: vk::ImageCreateFlags,
) -> vk::SampleCountFlags {
    let limits = &context.get_device_properties().limits;
    let supported_sample_count = limits
        .framebuffer_color_sample_counts
        .bits()
        .min(limits.framebuffer_depth_sample_counts.bits());
    let possible = [
        vk::SampleCountFlags::_64,
        vk::SampleCountFlags::_32,
        vk::SampleCountFlags::_16,
        vk::SampleCountFlags::_8,
        vk::SampleCountFlags::_4,
        vk::SampleCountFlags::_2,
    ];

    let properties = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            image_type,
            vk::ImageTiling::OPTIMAL,
            usage,
            flags,
        )
    };
    let image_sample_counts = properties
        .map(|properties| properties.sample_counts.bits())
        .unwrap_or(0);

    for possible_sample_count in possible {
        if supported_sample_count & possible_sample_count.bits() != 0
            && image_sample_counts & possible_sample_count.bits() != 0
        {
            return possible_sample_count;
        }
    }
    vk::SampleCountFlags::_1
}

fn image_format_not_supported(
    context: &Context<'_>,
    format: vk::Format,
    image_type: vk::ImageType,
    usage: vk::ImageUsageFlags,
    flags: vk::ImageCreateFlags,
) -> bool {
    let result = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            image_type,
            vk::ImageTiling::OPTIMAL,
            usage,
            flags,
        )
    };
    matches!(result, Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED)
}

fn color_subresource_range(base_array_layer: u32, layer_count: u32) -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, base_array_layer, layer_count)
}

/// `genVertexData`: per layer a four vertex strip, each vertex a position and the color of the layer.
fn gen_vertex_data(case_def: &CaseDef) -> Vec<[f32; 4]> {
    let is_integer = is_integer_format(case_def.view_format);
    let position = if case_def.is_load_op_clear_test { 0.5f32 } else { 1.0 };
    let mut data = Vec::new();
    for z in 0..case_def.num_layers as usize {
        let color_idx = z % COLOR_TABLE_SIZE;
        let color = if is_integer {
            get_clear_value_int(case_def, color_idx).map(|value| value as f32)
        } else {
            COLOR_TABLE_FLOAT[color_idx]
        };
        for corner in [
            [-position, -position],
            [-position, position],
            [position, -position],
            [position, position],
        ] {
            data.push([corner[0], corner[1], 0.0, 1.0]);
            data.push(color);
        }
    }
    data
}

/// `generateExpectedImage`
fn generate_expected_image(image: &mut PixelBufferAccess<'_>, case_def: &CaseDef, is_integer_format: bool) {
    for z in 0..case_def.num_layers {
        let color_idx = (z as usize) % COLOR_TABLE_SIZE;
        for y in 0..case_def.size[1] {
            for x in 0..case_def.size[0] {
                if is_integer_format {
                    let _ = image.set_pixel_int(get_clear_value_int(case_def, color_idx), x, y, z);
                } else if is_srgb_conversion_required(case_def) {
                    image.set_pixel(linear_to_srgb(COLOR_TABLE_FLOAT[color_idx]), x, y, z);
                } else {
                    image.set_pixel(COLOR_TABLE_FLOAT[color_idx], x, y, z);
                }
            }
        }
    }
}

/// `makeImage`
#[allow(clippy::too_many_arguments)]
fn make_image<'a>(
    context: &'a Context<'a>,
    device: &'a Device,
    flags: vk::ImageCreateFlags,
    image_type: vk::ImageType,
    format: vk::Format,
    view_format: vk::Format,
    use_image_format_list: bool,
    size: [u32; 3],
    num_layers: u32,
    usage: vk::ImageUsageFlags,
    samples: vk::SampleCountFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let format_list = [format, view_format];
    let mut format_list_info = vk::ImageFormatListCreateInfo::builder().view_formats(&format_list);
    let mut builder = vk::ImageCreateInfo::builder()
        .flags(flags)
        .image_type(image_type)
        .format(format)
        .extent(vk::Extent3D {
            width: size[0],
            height: size[1],
            depth: size[2],
        })
        .mip_levels(1)
        .array_layers(num_layers)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED);
    if use_image_format_list {
        builder = builder.push_next(&mut format_list_info);
    }
    ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        builder.build(),
        MemoryRequirement::ANY,
    )
}

/// `createHostBuffer` of the draw tests on `device`, which the swapchain cases create themselves.
fn create_host_vertex_buffer<'a>(
    context: &'a Context<'a>,
    device: &'a Device,
    bytes: &[u8],
) -> Result<BufferWithMemory<'a>, TestError> {
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(bytes.len() as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// `makeImageView`, with a `VkImageViewUsageCreateInfo` chained when `usage` is given.
fn make_image_view<'a>(
    device: &'a Device,
    image: vk::Image,
    view_type: vk::ImageViewType,
    format: vk::Format,
    subresource_range: vk::ImageSubresourceRange,
    usage: Option<vk::ImageUsageFlags>,
) -> Result<Unique<'a, vk::ImageView>, TestError> {
    let mut usage_info = vk::ImageViewUsageCreateInfo::builder().usage(usage.unwrap_or_default());
    let mut builder = vk::ImageViewCreateInfo::builder()
        .image(image)
        .view_type(view_type)
        .format(format)
        .components(vk::ComponentMapping {
            r: vk::ComponentSwizzle::IDENTITY,
            g: vk::ComponentSwizzle::IDENTITY,
            b: vk::ComponentSwizzle::IDENTITY,
            a: vk::ComponentSwizzle::IDENTITY,
        })
        .subresource_range(subresource_range);
    if usage.is_some() {
        builder = builder.push_next(&mut usage_info);
    }
    let view = unsafe { device.create_image_view(&builder, None) }.vk_check("vkCreateImageView")?;
    Ok(Unique::new(device, view))
}

fn make_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0");
    let info = vk::ComputePipelineCreateInfo::builder().stage(*stage).layout(layout);
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[*info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `makeRenderPass`: one subpass per layer, each with its color attachment and (for a resolve test) its resolve attachment.
fn make_render_pass<'a>(
    device: &'a Device,
    view_format: vk::Format,
    num_layers: u32,
    sample_count: vk::SampleCountFlags,
    resolve_test: ResolveAttachmentTestType,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let is_resolve_test = resolve_test != ResolveAttachmentTestType::None;

    let color_attachment = vk::AttachmentDescription::builder()
        .format(view_format)
        .samples(sample_count)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(if is_resolve_test {
            vk::AttachmentStoreOp::DONT_CARE
        } else {
            vk::AttachmentStoreOp::STORE
        })
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let mut attachment_descriptions = vec![color_attachment; num_layers as usize];

    if is_resolve_test {
        let resolve_attachment = vk::AttachmentDescription::builder()
            .format(view_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build();
        // Resolve attachments are appended at the end of multisampled attachments
        attachment_descriptions.extend(std::iter::repeat_n(resolve_attachment, num_layers as usize));
    }

    let color_attachment_references: Vec<vk::AttachmentReference> = (0..num_layers)
        .map(|i| vk::AttachmentReference {
            attachment: i,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        })
        .collect();
    // All resolve attachments go after all color attachments in the frame buffer
    let resolve_attachment_references: Vec<vk::AttachmentReference> = (0..num_layers)
        .map(|i| vk::AttachmentReference {
            attachment: num_layers + i,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        })
        .collect();

    let subpasses: Vec<vk::SubpassDescription> = (0..num_layers as usize)
        .map(|i| {
            let mut subpass = vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_attachment_references[i..=i]);
            if is_resolve_test {
                subpass = subpass.resolve_attachments(&resolve_attachment_references[i..=i]);
            }
            subpass.build()
        })
        .collect();

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// Everything the executor creates, kept until the command buffer has been submitted. Descriptor sets are declared before their pools.
struct Resources<'a> {
    descriptor_sets: Vec<UniqueDescriptorSet<'a>>,
    descriptor_pools: Vec<Unique<'a, vk::DescriptorPool>>,
    pipelines: Vec<Unique<'a, vk::Pipeline>>,
    framebuffers: Vec<Unique<'a, vk::Framebuffer>>,
    render_passes: Vec<Unique<'a, vk::RenderPass>>,
    pipeline_layouts: Vec<Unique<'a, vk::PipelineLayout>>,
    set_layouts: Vec<Unique<'a, vk::DescriptorSetLayout>>,
    shader_modules: Vec<Unique<'a, vk::ShaderModule>>,
    samplers: Vec<Unique<'a, vk::Sampler>>,
    views: Vec<Unique<'a, vk::ImageView>>,
    images: Vec<ImageWithMemory<'a>>,
    buffers: Vec<BufferWithMemory<'a>>,
}

impl Resources<'_> {
    fn new() -> Self {
        Self {
            descriptor_sets: Vec::new(),
            descriptor_pools: Vec::new(),
            pipelines: Vec::new(),
            framebuffers: Vec::new(),
            render_passes: Vec::new(),
            pipeline_layouts: Vec::new(),
            set_layouts: Vec::new(),
            shader_modules: Vec::new(),
            samplers: Vec::new(),
            views: Vec::new(),
            images: Vec::new(),
            buffers: Vec::new(),
        }
    }
}

/// `UploadDownloadExecutor`: executes a combination of upload and download methods.
struct UploadDownloadExecutor<'a> {
    context: &'a Context<'a>,
    device: &'a Device,
    queue: vk::Queue,
    queue_family_index: u32,
    case_def: CaseDef,
    have_maintenance2: bool,
    res: Resources<'a>,
    cmd: vk::CommandBuffer,
    image_is_integer_format: bool,
    view_is_integer_format: bool,
    /// Target image for upload paths
    image: vk::Image,
    /// Multisampled image
    multisampled_image: vk::Image,
    image_layout_after_upload: vk::ImageLayout,
    image_upload_access_mask: vk::AccessFlags,
}

impl<'a> UploadDownloadExecutor<'a> {
    fn new(context: &'a Context<'a>, have_maintenance2: bool, case_def: CaseDef) -> Self {
        Self {
            context,
            device: context.get_device(),
            queue: context.get_universal_queue(),
            queue_family_index: context.get_universal_queue_family_index(),
            case_def,
            have_maintenance2,
            res: Resources::new(),
            cmd: vk::CommandBuffer::null(),
            image_is_integer_format: false,
            view_is_integer_format: false,
            image: vk::Image::null(),
            multisampled_image: vk::Image::null(),
            image_layout_after_upload: vk::ImageLayout::UNDEFINED,
            image_upload_access_mask: vk::AccessFlags::empty(),
        }
    }

    /// The executor on a device the test created itself (the swapchain cases) instead of the context's.
    fn with_device(mut self, device: &'a Device, queue: vk::Queue, queue_family_index: u32) -> Self {
        self.device = device;
        self.queue = queue;
        self.queue_family_index = queue_family_index;
        self
    }

    fn view_usage(&self, usage: vk::ImageUsageFlags) -> Option<vk::ImageUsageFlags> {
        self.have_maintenance2.then_some(usage)
    }

    fn image_view_type(&self) -> Result<vk::ImageViewType, TestError> {
        map_image_view_type(self.case_def.image_type)
            .ok_or_else(|| TestError::InternalError("image type without a view type".to_string()))
    }

    fn pipeline_barrier(
        &self,
        src_stage: vk::PipelineStageFlags,
        dst_stage: vk::PipelineStageFlags,
        buffer_barriers: &[vk::BufferMemoryBarrier],
        image_barriers: &[vk::ImageMemoryBarrier],
    ) {
        unsafe {
            self.device.cmd_pipeline_barrier(
                self.cmd,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                buffer_barriers,
                image_barriers,
            )
        };
    }

    fn write_image_descriptors(
        &self,
        set: vk::DescriptorSet,
        writes: &[(u32, vk::DescriptorType, vk::DescriptorImageInfo)],
    ) {
        let infos: Vec<[vk::DescriptorImageInfo; 1]> = writes.iter().map(|(_, _, info)| [*info]).collect();
        let descriptor_writes: Vec<vk::WriteDescriptorSet> = writes
            .iter()
            .zip(&infos)
            .map(|((binding, descriptor_type, _), info)| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(set)
                    .dst_binding(*binding)
                    .descriptor_type(*descriptor_type)
                    .image_info(info)
                    .build()
            })
            .collect();
        unsafe {
            self.device
                .update_descriptor_sets(&descriptor_writes, &[] as &[vk::CopyDescriptorSet])
        };
    }

    /// `UploadDownloadExecutor::run`
    fn run(&mut self, buffer: vk::Buffer) -> Result<(), TestError> {
        let context = self.context;
        let device = self.device;
        let case_def = self.case_def;
        self.image_is_integer_format = is_integer_format(case_def.image_format);
        self.view_is_integer_format = is_integer_format(case_def.view_format);

        let cmd_pool = make_command_pool(device, self.queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        self.cmd = *cmd_buffer;
        begin_command_buffer(device, self.cmd)?;

        let image_usage = get_image_usage_for_test_case(&case_def);
        let image_flags = vk::ImageCreateFlags::MUTABLE_FORMAT
            | if self.have_maintenance2 {
                vk::ImageCreateFlags::EXTENDED_USAGE
            } else {
                vk::ImageCreateFlags::empty()
            };
        let image_flags_non_mutable = if self.have_maintenance2 {
            vk::ImageCreateFlags::EXTENDED_USAGE
        } else {
            vk::ImageCreateFlags::empty()
        };
        let vk_image_type = map_image_type(case_def.image_type);

        if case_def.resolve_attachment_test_type != ResolveAttachmentTestType::None {
            let ms_image_flags = if case_def.resolve_attachment_test_type == ResolveAttachmentTestType::RaMutable {
                image_flags_non_mutable
            } else {
                image_flags
            };
            let format = if ms_image_flags == image_flags_non_mutable {
                case_def.view_format
            } else {
                case_def.image_format
            };
            let samples = get_max_available_sample_count(context, format, vk_image_type, image_usage, ms_image_flags);

            if samples == vk::SampleCountFlags::_1
                || image_format_not_supported(context, format, vk_image_type, image_usage, ms_image_flags)
            {
                return Err(TestError::NotSupported(
                    "Format not supported for multisampled image".to_string(),
                ));
            }

            let multisampled_image = make_image(
                context,
                device,
                ms_image_flags,
                vk_image_type,
                format,
                case_def.view_format,
                case_def.is_format_list_test,
                case_def.size,
                case_def.num_layers,
                image_usage,
                samples,
            )?;
            self.multisampled_image = multisampled_image.get();
            self.res.images.push(multisampled_image);
        }

        let img_flags = if case_def.resolve_attachment_test_type == ResolveAttachmentTestType::CaMutable {
            image_flags_non_mutable
        } else {
            image_flags
        };
        let img_format = if img_flags == image_flags_non_mutable {
            case_def.view_format
        } else {
            case_def.image_format
        };

        if image_format_not_supported(context, img_format, vk_image_type, image_usage, img_flags) {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }

        let image = make_image(
            context,
            device,
            img_flags,
            vk_image_type,
            img_format,
            case_def.view_format,
            case_def.is_format_list_test,
            case_def.size,
            case_def.num_layers,
            image_usage,
            vk::SampleCountFlags::_1,
        )?;
        self.image = image.get();
        self.res.images.push(image);

        match case_def.upload {
            Upload::Draw => self.upload_draw()?,
            Upload::Store => self.upload_store()?,
            Upload::Clear => self.upload_clear(),
            Upload::Copy => self.upload_copy()?,
        }

        match case_def.download {
            Download::Copy => self.download_copy(buffer),
            Download::Load => self.download_load(buffer)?,
            Download::Texture => self.download_texture(buffer)?,
        }

        end_command_buffer(device, self.cmd)?;
        submit_commands_and_wait(device, self.queue, self.cmd)
    }

    /// `UploadDownloadExecutor::runSwapchain`: the upload and download on a swapchain image, submitted after `image_ready_semaphore`
    fn run_swapchain(
        &mut self,
        buffer: vk::Buffer,
        image: vk::Image,
        image_ready_semaphore: vk::Semaphore,
    ) -> Result<(), TestError> {
        let device = self.device;
        let case_def = self.case_def;
        self.image_is_integer_format = is_integer_format(case_def.image_format);
        self.view_is_integer_format = is_integer_format(case_def.view_format);

        let cmd_pool = make_command_pool(device, self.queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        self.cmd = *cmd_buffer;
        begin_command_buffer(device, self.cmd)?;

        self.image = image;

        match case_def.upload {
            Upload::Draw => self.upload_draw()?,
            Upload::Store => self.upload_store()?,
            Upload::Clear => self.upload_clear(),
            Upload::Copy => self.upload_copy()?,
        }

        match case_def.download {
            Download::Copy => self.download_copy(buffer),
            Download::Load => self.download_load(buffer)?,
            Download::Texture => self.download_texture(buffer)?,
        }

        end_command_buffer(device, self.cmd)?;

        let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::default(), None) }.vk_check("vkCreateFence")?;
        let wait_semaphores = [image_ready_semaphore];
        let wait_stages = [vk::PipelineStageFlags::TOP_OF_PIPE];
        let command_buffers = [self.cmd];
        let submit_info = vk::SubmitInfo::builder()
            .wait_semaphores(&wait_semaphores)
            .wait_dst_stage_mask(&wait_stages)
            .command_buffers(&command_buffers)
            .build();
        let result = unsafe { device.queue_submit(self.queue, &[submit_info], fence) }
            .vk_check("vkQueueSubmit")
            .and_then(|()| {
                unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }
                    .map(|_| ())
                    .vk_check("vkWaitForFences")
            });
        unsafe { device.destroy_fence(fence, None) };
        result
    }

    fn upload_clear(&mut self) {
        let required_image_layout = vk::ImageLayout::GENERAL;
        let case_def = self.case_def;

        let image_init_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            required_image_layout,
            self.image,
            color_subresource_range(0, case_def.num_layers),
        );
        self.pipeline_barrier(
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &[],
            &[image_init_barrier],
        );

        for layer in 0..case_def.num_layers {
            let layer_subresource_range = color_subresource_range(layer, 1);
            let color_idx = layer as usize % COLOR_TABLE_SIZE;
            let clear_color = if self.image_is_integer_format {
                vk::ClearColorValue {
                    int32: get_clear_value_int(&case_def, color_idx),
                }
            } else {
                vk::ClearColorValue {
                    float32: COLOR_TABLE_FLOAT[color_idx],
                }
            };
            unsafe {
                self.device.cmd_clear_color_image(
                    self.cmd,
                    self.image,
                    required_image_layout,
                    &clear_color,
                    &[layer_subresource_range],
                )
            };
        }

        self.image_layout_after_upload = required_image_layout;
        self.image_upload_access_mask = vk::AccessFlags::TRANSFER_WRITE;
    }

    fn upload_store(&mut self) -> Result<(), TestError> {
        let device = self.device;
        let case_def = self.case_def;
        let binaries = self.context.get_binary_collection();

        let image_view = make_image_view(
            device,
            self.image,
            self.image_view_type()?,
            case_def.view_format,
            color_subresource_range(0, case_def.num_layers),
            self.view_usage(vk::ImageUsageFlags::STORAGE),
        )?;
        let view = *image_view;
        self.res.views.push(image_view);

        // Setup compute pipeline
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let pool = *descriptor_pool;
        self.res.descriptor_pools.push(descriptor_pool);
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let set_layout = *descriptor_set_layout;
        self.res.set_layouts.push(descriptor_set_layout);
        let pipeline_layout = make_pipeline_layout(device, &[set_layout])?;
        let layout = *pipeline_layout;
        self.res.pipeline_layouts.push(pipeline_layout);
        let descriptor_set = crate::vk::obj_util::make_descriptor_set(device, pool, set_layout)?;
        let set = descriptor_set.get();
        self.res.descriptor_sets.push(descriptor_set);
        let compute_module = create_shader_module(device, binaries.get("uploadStoreComp")?)?;
        let module = *compute_module;
        self.res.shader_modules.push(compute_module);
        let compute_pipeline = make_compute_pipeline(device, layout, module)?;
        let pipeline = *compute_pipeline;
        self.res.pipelines.push(compute_pipeline);

        self.write_image_descriptors(
            set,
            &[(
                0,
                vk::DescriptorType::STORAGE_IMAGE,
                vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: view,
                    image_layout: vk::ImageLayout::GENERAL,
                },
            )],
        );

        // Transition storage image for shader access (imageStore)
        let required_image_layout = vk::ImageLayout::GENERAL;
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            required_image_layout,
            self.image,
            color_subresource_range(0, case_def.num_layers),
        );
        self.pipeline_barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            &[],
            &[image_barrier],
        );

        // Dispatch
        unsafe {
            device.cmd_bind_pipeline(self.cmd, vk::PipelineBindPoint::COMPUTE, pipeline);
            device.cmd_bind_descriptor_sets(
                self.cmd,
                vk::PipelineBindPoint::COMPUTE,
                layout,
                0,
                &[set],
                &[] as &[u32],
            );
            device.cmd_dispatch(self.cmd, case_def.size[0], case_def.size[1], case_def.num_layers);
        }

        self.image_layout_after_upload = required_image_layout;
        self.image_upload_access_mask = vk::AccessFlags::SHADER_WRITE;
        Ok(())
    }

    fn upload_copy(&mut self) -> Result<(), TestError> {
        let device = self.device;
        let case_def = self.case_def;

        // Create a host-mappable buffer with the color data to upload
        let tcu_format = map_vk_format(case_def.image_format)
            .ok_or_else(|| TestError::NotPorted("image format without a texture format".to_string()))?;
        let pixel = pixel_size(case_def.image_format)? as usize;
        let layer_size = case_def.size[0] as usize * case_def.size[1] as usize * case_def.size[2] as usize * pixel;
        let color_buffer_size = layer_size * case_def.num_layers as usize;

        let color_buffer = BufferWithMemory::new(
            device,
            self.context.get_default_allocator(),
            make_buffer_create_info(color_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer = color_buffer.get();

        // Fill color buffer
        {
            let host = unsafe {
                std::slice::from_raw_parts_mut(color_buffer.get_allocation().get_host_ptr(), color_buffer_size)
            };
            for layer in 0..case_def.num_layers as usize {
                let color_idx = layer % COLOR_TABLE_SIZE;
                let mut image_access = PixelBufferAccess::new(
                    tcu_format,
                    [case_def.size[0], case_def.size[1], 1],
                    &mut host[layer * layer_size..(layer + 1) * layer_size],
                );
                for y in 0..case_def.size[1] {
                    for x in 0..case_def.size[0] {
                        if self.image_is_integer_format {
                            let _ = image_access.set_pixel_int(get_clear_value_int(&case_def, color_idx), x, y, 0);
                        } else {
                            image_access.set_pixel(COLOR_TABLE_FLOAT[color_idx], x, y, 0);
                        }
                    }
                }
            }
        }
        flush_alloc(device, color_buffer.get_allocation())?;
        self.res.buffers.push(color_buffer);

        // Prepare buffer and image for copy
        let buffer_init_barrier = vk::BufferMemoryBarrier {
            s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
            next: std::ptr::null(),
            src_access_mask: vk::AccessFlags::HOST_WRITE,
            dst_access_mask: vk::AccessFlags::TRANSFER_READ,
            src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            buffer,
            offset: 0,
            size: vk::WHOLE_SIZE,
        };
        let image_init_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            self.image,
            color_subresource_range(0, case_def.num_layers),
        );
        self.pipeline_barrier(
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            &[buffer_init_barrier],
            &[image_init_barrier],
        );

        // Copy buffer to image
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: case_def.num_layers,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: case_def.size[0],
                height: case_def.size[1],
                depth: case_def.size[2],
            },
        };
        unsafe {
            device.cmd_copy_buffer_to_image(
                self.cmd,
                buffer,
                self.image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[region],
            )
        };

        let image_post_init_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            self.image,
            color_subresource_range(0, case_def.num_layers),
        );
        self.pipeline_barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            &[],
            &[image_post_init_barrier],
        );

        self.image_layout_after_upload = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
        self.image_upload_access_mask = vk::AccessFlags::TRANSFER_WRITE;
        Ok(())
    }

    fn upload_draw(&mut self) -> Result<(), TestError> {
        let context = self.context;
        let device = self.device;
        let case_def = self.case_def;
        let binaries = context.get_binary_collection();
        let is_resolve_test = case_def.resolve_attachment_test_type != ResolveAttachmentTestType::None;

        let max_sample_count = get_max_available_sample_count(
            context,
            case_def.image_format,
            map_image_type(case_def.image_type),
            get_image_usage_for_test_case(&case_def),
            vk::ImageCreateFlags::empty(),
        );
        let sample_count = if is_resolve_test {
            max_sample_count
        } else {
            vk::SampleCountFlags::_1
        };

        // Create vertex buffer
        let vertices = gen_vertex_data(&case_def);
        let vertex_bytes: Vec<u8> = vertices
            .iter()
            .flatten()
            .flat_map(|value| value.to_ne_bytes())
            .collect();
        let vertex_buffer = create_host_vertex_buffer(context, device, &vertex_bytes)?;
        let vertex_buffer_handle = vertex_buffer.get();
        self.res.buffers.push(vertex_buffer);

        // Create attachments and pipelines for each image layer
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let layout = *pipeline_layout;
        self.res.pipeline_layouts.push(pipeline_layout);
        let render_pass = make_render_pass(
            device,
            case_def.view_format,
            case_def.num_layers,
            sample_count,
            case_def.resolve_attachment_test_type,
        )?;
        let render_pass_handle = *render_pass;
        self.res.render_passes.push(render_pass);
        let vertex_module = create_shader_module(device, binaries.get("uploadDrawVert")?)?;
        let vertex_module_handle = *vertex_module;
        self.res.shader_modules.push(vertex_module);
        let fragment_module = create_shader_module(device, binaries.get("uploadDrawFrag")?)?;
        let fragment_module_handle = *fragment_module;
        self.res.shader_modules.push(fragment_module);

        let view_type = self.image_view_type()?;
        let view_usage = self.view_usage(vk::ImageUsageFlags::COLOR_ATTACHMENT);
        let mut attachment_handles = Vec::new();

        // Create multisampled attachment view
        if is_resolve_test {
            for subpass_ndx in 0..case_def.num_layers {
                let view = make_image_view(
                    device,
                    self.multisampled_image,
                    view_type,
                    case_def.view_format,
                    color_subresource_range(subpass_ndx, 1),
                    view_usage,
                )?;
                // Add multisampled image first in attachments as we did in the renderpass
                attachment_handles.push(*view);
                self.res.views.push(view);
            }
        }

        let mut pipeline_handles = Vec::new();
        for subpass_ndx in 0..case_def.num_layers {
            let view = make_image_view(
                device,
                self.image,
                view_type,
                case_def.view_format,
                color_subresource_range(subpass_ndx, 1),
                view_usage,
            )?;
            attachment_handles.push(*view);
            self.res.views.push(view);

            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
                .with_full_viewport(case_def.size[0], case_def.size[1]);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: 2 * 16,
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
            state.subpass = subpass_ndx;
            if is_resolve_test {
                state.samples = sample_count;
            }
            let pipeline = create_draw_pipeline(
                device,
                layout,
                render_pass_handle,
                &[
                    (vk::ShaderStageFlags::VERTEX, vertex_module_handle),
                    (vk::ShaderStageFlags::FRAGMENT, fragment_module_handle),
                ],
                &state,
            )?;
            pipeline_handles.push(*pipeline);
            self.res.pipelines.push(pipeline);
        }

        // Create framebuffer
        let framebuffer = make_framebuffer(
            device,
            render_pass_handle,
            &attachment_handles,
            case_def.size[0],
            case_def.size[1],
            1,
        )?;
        let framebuffer_handle = *framebuffer;
        self.res.framebuffers.push(framebuffer);

        // Create command buffer
        let clear_value = if self.view_is_integer_format {
            vk::ClearValue {
                color: vk::ClearColorValue {
                    int32: get_clear_value_int(&case_def, 0),
                },
            }
        } else {
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: COLOR_TABLE_FLOAT[0],
                },
            }
        };
        let clear_values = vec![clear_value; case_def.num_layers as usize * if is_resolve_test { 2 } else { 1 }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass_handle)
            .framebuffer(framebuffer_handle)
            .render_area(rect_2d(case_def.size[0], case_def.size[1]))
            .clear_values(&clear_values);

        // Render
        let vertex_data_per_draw = (4 * 2 * 16) as vk::DeviceSize;
        let mut vertex_buffer_offset = 0 as vk::DeviceSize;
        unsafe {
            device.cmd_begin_render_pass(self.cmd, &begin_info, vk::SubpassContents::INLINE);
            for (subpass_ndx, &pipeline) in pipeline_handles.iter().enumerate() {
                if subpass_ndx != 0 {
                    device.cmd_next_subpass(self.cmd, vk::SubpassContents::INLINE);
                }
                device.cmd_bind_pipeline(self.cmd, vk::PipelineBindPoint::GRAPHICS, pipeline);
                device.cmd_bind_vertex_buffers(self.cmd, 0, &[vertex_buffer_handle], &[vertex_buffer_offset]);
                device.cmd_draw(self.cmd, 4, 1, 0, 0);
                vertex_buffer_offset += vertex_data_per_draw;
            }
            device.cmd_end_render_pass(self.cmd);
        }

        self.image_layout_after_upload = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
        self.image_upload_access_mask = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        Ok(())
    }

    fn download_copy(&mut self, buffer: vk::Buffer) {
        self.copy_image_to_buffer(
            self.image,
            buffer,
            self.image_upload_access_mask,
            self.image_layout_after_upload,
            self.case_def.num_layers,
        );
    }

    /// The image the download shader writes: the view format, 2D, storage and transfer source.
    fn make_out_image(&mut self) -> Result<(vk::Image, vk::ImageView), TestError> {
        let case_def = self.case_def;
        let out_image = make_image(
            self.context,
            self.device,
            vk::ImageCreateFlags::empty(),
            vk::ImageType::_2D,
            case_def.view_format,
            case_def.view_format,
            false,
            case_def.size,
            case_def.num_layers,
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC,
            vk::SampleCountFlags::_1,
        )?;
        let image = out_image.get();
        self.res.images.push(out_image);
        let out_view = make_image_view(
            self.device,
            image,
            self.image_view_type()?,
            case_def.view_format,
            color_subresource_range(0, case_def.num_layers),
            None,
        )?;
        let view = *out_view;
        self.res.views.push(out_view);
        Ok((image, view))
    }

    fn download_texture(&mut self, buffer: vk::Buffer) -> Result<(), TestError> {
        let device = self.device;
        let case_def = self.case_def;
        let binaries = self.context.get_binary_collection();

        // Create output image with download result
        let (out_image, out_view) = self.make_out_image()?;

        let in_view = make_image_view(
            device,
            self.image,
            self.image_view_type()?,
            case_def.view_format,
            color_subresource_range(0, case_def.num_layers),
            self.view_usage(vk::ImageUsageFlags::SAMPLED),
        )?;
        let in_view_handle = *in_view;
        self.res.views.push(in_view);

        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
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
        let sampler_handle = *sampler;
        self.res.samplers.push(sampler);

        // Setup compute pipeline
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let pool = *descriptor_pool;
        self.res.descriptor_pools.push(descriptor_pool);
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_sampler_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::COMPUTE,
                0,
                &[sampler_handle],
            )
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE, 1, 1)
            .build(device)?;
        let set_layout = *descriptor_set_layout;
        self.res.set_layouts.push(descriptor_set_layout);
        let pipeline_layout = make_pipeline_layout(device, &[set_layout])?;
        let layout = *pipeline_layout;
        self.res.pipeline_layouts.push(pipeline_layout);
        let descriptor_set = crate::vk::obj_util::make_descriptor_set(device, pool, set_layout)?;
        let set = descriptor_set.get();
        self.res.descriptor_sets.push(descriptor_set);
        let compute_module = create_shader_module(device, binaries.get("downloadTextureComp")?)?;
        let module = *compute_module;
        self.res.shader_modules.push(compute_module);
        let compute_pipeline = make_compute_pipeline(device, layout, module)?;
        let pipeline = *compute_pipeline;
        self.res.pipelines.push(compute_pipeline);

        self.write_image_descriptors(
            set,
            &[
                (
                    0,
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    vk::DescriptorImageInfo {
                        sampler: vk::Sampler::null(),
                        image_view: in_view_handle,
                        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    },
                ),
                (
                    1,
                    vk::DescriptorType::STORAGE_IMAGE,
                    vk::DescriptorImageInfo {
                        sampler: vk::Sampler::null(),
                        image_view: out_view,
                        image_layout: vk::ImageLayout::GENERAL,
                    },
                ),
            ],
        );

        // Transition images for shader access (texture / imageStore)
        let image_barriers = [
            make_image_memory_barrier(
                self.image_upload_access_mask,
                vk::AccessFlags::SHADER_READ,
                self.image_layout_after_upload,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                self.image,
                color_subresource_range(0, case_def.num_layers),
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                out_image,
                color_subresource_range(0, case_def.num_layers),
            ),
        ];
        self.pipeline_barrier(
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            &[],
            &image_barriers,
        );

        // Dispatch
        unsafe {
            device.cmd_bind_pipeline(self.cmd, vk::PipelineBindPoint::COMPUTE, pipeline);
            device.cmd_bind_descriptor_sets(
                self.cmd,
                vk::PipelineBindPoint::COMPUTE,
                layout,
                0,
                &[set],
                &[] as &[u32],
            );
            device.cmd_dispatch(self.cmd, case_def.size[0], case_def.size[1], case_def.num_layers);
        }

        // Copy output image to color buffer
        self.copy_image_to_buffer(
            out_image,
            buffer,
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::GENERAL,
            case_def.num_layers,
        );
        Ok(())
    }

    fn download_load(&mut self, buffer: vk::Buffer) -> Result<(), TestError> {
        let device = self.device;
        let case_def = self.case_def;
        let binaries = self.context.get_binary_collection();

        // Create output image with download result
        let (out_image, out_view) = self.make_out_image()?;

        let in_view = make_image_view(
            device,
            self.image,
            self.image_view_type()?,
            case_def.view_format,
            color_subresource_range(0, case_def.num_layers),
            self.view_usage(vk::ImageUsageFlags::STORAGE),
        )?;
        let in_view_handle = *in_view;
        self.res.views.push(in_view);

        // Setup compute pipeline
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let pool = *descriptor_pool;
        self.res.descriptor_pools.push(descriptor_pool);
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE, 0, 1)
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE, 1, 1)
            .build(device)?;
        let set_layout = *descriptor_set_layout;
        self.res.set_layouts.push(descriptor_set_layout);
        let pipeline_layout = make_pipeline_layout(device, &[set_layout])?;
        let layout = *pipeline_layout;
        self.res.pipeline_layouts.push(pipeline_layout);
        let descriptor_set = crate::vk::obj_util::make_descriptor_set(device, pool, set_layout)?;
        let set = descriptor_set.get();
        self.res.descriptor_sets.push(descriptor_set);
        let compute_module = create_shader_module(device, binaries.get("downloadLoadComp")?)?;
        let module = *compute_module;
        self.res.shader_modules.push(compute_module);
        let compute_pipeline = make_compute_pipeline(device, layout, module)?;
        let pipeline = *compute_pipeline;
        self.res.pipelines.push(compute_pipeline);

        self.write_image_descriptors(
            set,
            &[
                (
                    0,
                    vk::DescriptorType::STORAGE_IMAGE,
                    vk::DescriptorImageInfo {
                        sampler: vk::Sampler::null(),
                        image_view: in_view_handle,
                        image_layout: vk::ImageLayout::GENERAL,
                    },
                ),
                (
                    1,
                    vk::DescriptorType::STORAGE_IMAGE,
                    vk::DescriptorImageInfo {
                        sampler: vk::Sampler::null(),
                        image_view: out_view,
                        image_layout: vk::ImageLayout::GENERAL,
                    },
                ),
            ],
        );

        // Transition storage images for shader access (imageLoad/Store)
        let required_image_layout = vk::ImageLayout::GENERAL;
        let image_barriers = [
            make_image_memory_barrier(
                self.image_upload_access_mask,
                vk::AccessFlags::SHADER_READ,
                self.image_layout_after_upload,
                required_image_layout,
                self.image,
                color_subresource_range(0, case_def.num_layers),
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                required_image_layout,
                out_image,
                color_subresource_range(0, case_def.num_layers),
            ),
        ];
        self.pipeline_barrier(
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            &[],
            &image_barriers,
        );

        // Dispatch
        unsafe {
            device.cmd_bind_pipeline(self.cmd, vk::PipelineBindPoint::COMPUTE, pipeline);
            device.cmd_bind_descriptor_sets(
                self.cmd,
                vk::PipelineBindPoint::COMPUTE,
                layout,
                0,
                &[set],
                &[] as &[u32],
            );
            device.cmd_dispatch(self.cmd, case_def.size[0], case_def.size[1], case_def.num_layers);
        }

        // Copy output image to color buffer
        self.copy_image_to_buffer(
            out_image,
            buffer,
            vk::AccessFlags::SHADER_WRITE,
            required_image_layout,
            case_def.num_layers,
        );
        Ok(())
    }

    /// `UploadDownloadExecutor::copyImageToBuffer`: copy the result to a host visible buffer for inspection.
    fn copy_image_to_buffer(
        &self,
        source_image: vk::Image,
        buffer: vk::Buffer,
        src_access_mask: vk::AccessFlags,
        old_layout: vk::ImageLayout,
        num_layers: u32,
    ) {
        let case_def = self.case_def;
        let image_barrier = make_image_memory_barrier(
            src_access_mask,
            vk::AccessFlags::TRANSFER_READ,
            old_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            source_image,
            color_subresource_range(0, num_layers),
        );
        self.pipeline_barrier(
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            &[],
            &[image_barrier],
        );

        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: num_layers,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: case_def.size[0],
                height: case_def.size[1],
                depth: case_def.size[2],
            },
        };
        unsafe {
            self.device.cmd_copy_image_to_buffer(
                self.cmd,
                source_image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer,
                &[region],
            )
        };

        let buffer_barrier = vk::BufferMemoryBarrier {
            s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
            next: std::ptr::null(),
            src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
            dst_access_mask: vk::AccessFlags::HOST_READ,
            src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            buffer,
            offset: 0,
            size: vk::WHOLE_SIZE,
        };
        self.pipeline_barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            &[buffer_barrier],
            &[],
        );
    }
}

/// `testMutable`
fn test_mutable(context: &Context<'_>, case_def: CaseDef) -> TestOutcome {
    let device = context.get_device();

    // A color buffer for host inspection of the results. For the copy download method it is the target of the download, for the other
    // methods the pixel data is copied to it from the download target.
    let color_buffer_size = (case_def.size[0]
        * case_def.size[1]
        * case_def.size[2]
        * case_def.num_layers
        * pixel_size(case_def.image_format)?) as usize;
    let color_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(color_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::write_bytes(color_buffer.get_allocation().get_host_ptr(), 0, color_buffer_size) };
    flush_alloc(device, color_buffer.get_allocation())?;

    // Execute the test
    let mut executor = UploadDownloadExecutor::new(
        context,
        context.is_device_functionality_supported("VK_KHR_maintenance2"),
        case_def,
    );
    executor.run(color_buffer.get())?;
    drop(executor);

    verify_color_buffer(device, &color_buffer, color_buffer_size, &case_def)
}

/// The verification half of `testMutable` and `testSwapchainMutable`: `color_buffer` against the expected image of the case
fn verify_color_buffer(
    device: &Device,
    color_buffer: &BufferWithMemory<'_>,
    color_buffer_size: usize,
    case_def: &CaseDef,
) -> TestOutcome {
    let case_def = *case_def;
    invalidate_alloc(device, color_buffer.get_allocation())?;

    // For verification purposes, the format of the upload is used to generate the expected image
    let format = if matches!(case_def.upload, Upload::Clear | Upload::Copy) {
        case_def.image_format
    } else {
        case_def.view_format
    };
    let tcu_format =
        map_vk_format(format).ok_or_else(|| TestError::NotPorted("format without a texture format".to_string()))?;
    let is_integer = is_integer_format(format);
    let size = [case_def.size[0], case_def.size[1], case_def.num_layers];
    let result_bytes =
        unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size) };
    let result_image = ConstPixelBufferAccess::new(tcu_format, size, result_bytes);
    let mut texture_level = TextureLevel::new(tcu_format, size[0], size[1], size[2])?;
    generate_expected_image(&mut texture_level.get_access(), &case_def, is_integer);

    let ok = if is_integer {
        int_threshold_compare(
            &texture_level.get_const_access(),
            &result_image,
            UVec4::from_array([1; 4]),
        )
        .ok
    } else {
        float_threshold_compare(&texture_level.get_const_access(), &result_image, [0.01; 4]).ok
    };
    Ok(if ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

struct ImageMutableCase {
    name: String,
    case_def: CaseDef,
}

impl TestCase for ImageMutableCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let case_def = self.case_def;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        // If this is a VK_KHR_image_format_list test, check that the extension is supported
        if case_def.is_format_list_test {
            context.require_device_functionality("VK_KHR_image_format_list")?;
        }

        // Check required features on the format for the required upload/download methods
        let image_format_props =
            unsafe { instance.get_physical_device_format_properties(physical_device, case_def.image_format) };
        let view_format_props =
            unsafe { instance.get_physical_device_format_properties(physical_device, case_def.view_format) };

        let mut view_format_feature_flags = vk::FormatFeatureFlags::empty();
        view_format_feature_flags |= match case_def.upload {
            Upload::Draw => vk::FormatFeatureFlags::COLOR_ATTACHMENT,
            Upload::Store => vk::FormatFeatureFlags::STORAGE_IMAGE,
            Upload::Clear | Upload::Copy => vk::FormatFeatureFlags::TRANSFER_DST,
        };
        view_format_feature_flags |= match case_def.download {
            // The samples read are written to a separate output image with the same view format, which then has to be usable for storage too.
            Download::Texture => vk::FormatFeatureFlags::SAMPLED_IMAGE | vk::FormatFeatureFlags::STORAGE_IMAGE,
            Download::Load => vk::FormatFeatureFlags::STORAGE_IMAGE,
            Download::Copy => vk::FormatFeatureFlags::TRANSFER_DST,
        };

        if !view_format_props
            .optimal_tiling_features
            .contains(view_format_feature_flags)
        {
            return Err(TestError::NotSupported(
                "View format doesn't support upload/download method".to_string(),
            ));
        }

        let have_maintenance2 = context.is_device_functionality_supported("VK_KHR_maintenance2");

        // The base image is only used for transfer operations so there are no features to check. The Vulkan 1.0 spec does not allow an image
        // view with usage the main format does not support, which VK_KHR_maintenance2's extended usage bit makes possible.
        if !image_format_props
            .optimal_tiling_features
            .contains(view_format_feature_flags)
            && !have_maintenance2
        {
            return Err(TestError::NotSupported(
                "Image format doesn't support upload/download method".to_string(),
            ));
        }

        // If no format feature flags are supported, the format itself is not supported, and images of that format cannot be created.
        if image_format_props.optimal_tiling_features.is_empty() {
            return Err(TestError::NotSupported(
                "Base image format is not supported".to_string(),
            ));
        }

        let usage = get_image_usage_for_test_case(&case_def);
        let image_flags = vk::ImageCreateFlags::MUTABLE_FORMAT
            | if have_maintenance2 {
                vk::ImageCreateFlags::EXTENDED_USAGE
            } else {
                vk::ImageCreateFlags::empty()
            };

        if get_max_available_sample_count(
            context,
            case_def.image_format,
            map_image_type(case_def.image_type),
            usage,
            image_flags,
        ) == vk::SampleCountFlags::_1
        {
            return Err(TestError::NotSupported(
                "Maximum available sample count is VK_SAMPLE_COUNT_1_BIT".to_string(),
            ));
        }

        if case_def.extended_flags {
            context.require_device_functionality("VK_KHR_extended_flags")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = mutable_key(&self.case_def);
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map(|program| program.programs)
            .unwrap_or_else(|| BinaryCollection::new(&[]))
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageMutableInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct ImageMutableInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDef,
}

impl TestInstance for ImageMutableInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_mutable(self.context, self.case_def)
    }
}

/// `createImageMutableTests`
pub fn create_image_mutable_tests() -> TestCaseGroup {
    let textures = [
        Texture::simple(ImageType::TwoD, [32, 32, 1], 1),
        Texture::simple(ImageType::TwoDArray, [32, 32, 1], 4),
    ];
    let mut test_group = TestCaseGroup::new("mutable");

    for texture in textures {
        let mut group_by_image_view_type = TestCaseGroup::new(get_image_type_name(texture.type_()));
        let layer_size = texture.layer_size(0);
        let size = [layer_size[0] as u32, layer_size[1] as u32, layer_size[2] as u32];
        let num_layers = texture.num_layers() as u32;

        for (image_format_ndx, &image_format) in S_FORMATS.iter().enumerate() {
            for (view_format_ndx, &view_format) in S_FORMATS.iter().enumerate() {
                if image_format_ndx == view_format_ndx || !formats_are_compatible(image_format, view_format) {
                    continue;
                }

                let base_case_def = CaseDef {
                    image_type: texture.type_(),
                    size,
                    num_layers,
                    image_format,
                    view_format,
                    upload: Upload::Clear,
                    download: Download::Copy,
                    is_format_list_test: false,
                    extended_flags: false,
                    resolve_attachment_test_type: ResolveAttachmentTestType::None,
                    is_load_op_clear_test: false,
                };
                let mut add = |name: String, case_def: CaseDef| {
                    group_by_image_view_type
                        .add_child(Box::new(ImageMutableCase { name, case_def }) as Box<dyn TestCase>);
                };

                for upload in UPLOADS {
                    if upload == Upload::Store && !is_format_image_load_store_capable(view_format) {
                        continue;
                    }

                    for download in DOWNLOADS {
                        if matches!(download, Download::Load | Download::Texture)
                            && !is_format_image_load_store_capable(view_format)
                        {
                            continue;
                        }

                        let mut case_def = CaseDef {
                            upload,
                            download,
                            ..base_case_def
                        };
                        let case_name = format!(
                            "{}_{}_{}_{}",
                            format_short_string(image_format),
                            format_short_string(view_format),
                            upload_string(upload),
                            download_string(download)
                        );
                        add(case_name.clone(), case_def);

                        case_def.is_format_list_test = true;
                        add(format!("{case_name}_format_list"), case_def);

                        if matches!(
                            image_format,
                            vk::Format::R32G32B32A32_SFLOAT | vk::Format::R8G8B8A8_UNORM | vk::Format::R32_UINT
                        ) {
                            case_def.is_format_list_test = false;
                            case_def.extended_flags = true;
                            add(format!("{case_name}_extended_flags"), case_def);
                        }
                    }
                }

                // Multisampling and resolve attachment tests
                {
                    let mut case_def = CaseDef {
                        upload: Upload::Draw,
                        download: Download::Copy,
                        resolve_attachment_test_type: ResolveAttachmentTestType::AllMutable,
                        ..base_case_def
                    };
                    let base_case_name = format!(
                        "{}_{}_{}_{}_resolve",
                        format_short_string(image_format),
                        format_short_string(view_format),
                        upload_string(Upload::Draw),
                        download_string(Download::Copy)
                    );
                    add(base_case_name.clone(), case_def);

                    // Resolve attachment is mutable and color attachment is non-mutable
                    case_def.resolve_attachment_test_type = ResolveAttachmentTestType::RaMutable;
                    add(format!("{base_case_name}_mutable_resolve_att"), case_def);

                    // Color attachment is mutable and resolve attachment is non-mutable
                    case_def.resolve_attachment_test_type = ResolveAttachmentTestType::CaMutable;
                    add(format!("{base_case_name}_mutable_color_att"), case_def);
                }

                // VK_ATTACHMENT_LOAD_OP_CLEAR tests
                if texture.num_layers() <= 1 {
                    let case_def = CaseDef {
                        upload: Upload::Draw,
                        download: Download::Copy,
                        is_load_op_clear_test: true,
                        ..base_case_def
                    };
                    let case_name = format!(
                        "{}_{}_{}_{}_load_op_clear",
                        format_short_string(image_format),
                        format_short_string(view_format),
                        upload_string(Upload::Draw),
                        download_string(Download::Copy)
                    );
                    add(case_name, case_def);
                }
            }
        }

        test_group.add_child(group_by_image_view_type);
    }
    test_group
}

const S_SWAPCHAIN_FORMATS: [vk::Format; 6] = [
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::R8G8B8A8_SNORM,
    vk::Format::R8G8B8A8_SRGB,
    vk::Format::B8G8R8A8_UNORM,
    vk::Format::B8G8R8A8_SNORM,
    vk::Format::B8G8R8A8_SRGB,
];

struct HeadlessSurface<'a> {
    instance: &'a Instance,
    surface: vk::SurfaceKHR,
}

impl Drop for HeadlessSurface<'_> {
    fn drop(&mut self) {
        unsafe { self.instance.destroy_surface_khr(self.surface, None) };
    }
}

struct SwapchainDevice(Device);

impl Drop for SwapchainDevice {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

/// The swapchain and the semaphore of `testSwapchainMutable`, destroyed after a `deviceWaitIdle`
struct SwapchainGuard<'a> {
    device: &'a Device,
    swapchain: vk::SwapchainKHR,
    semaphore: vk::Semaphore,
}

impl Drop for SwapchainGuard<'_> {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_semaphore(self.semaphore, None);
            self.device.destroy_swapchain_khr(self.swapchain, None);
        }
    }
}

/// `testSwapchainMutable` for the headless platform
fn test_swapchain_mutable(context: &Context<'_>, mut case_def: CaseDef) -> TestOutcome {
    const DESIRED_SIZE: (u32, u32) = (256, 256);

    let mut instance_extensions = vec!["VK_KHR_surface", "VK_EXT_headless_surface"];
    for extension in &instance_extensions {
        if !is_instance_extension_available(context, extension) {
            return Err(TestError::NotSupported(format!(
                "{extension} is not supported by this implementation"
            )));
        }
    }
    // VK_EXT_swapchain_colorspace adds new surface formats, enabled when advertised
    if is_instance_extension_available(context, "VK_EXT_swapchain_colorspace") {
        instance_extensions.push("VK_EXT_swapchain_colorspace");
    }
    let helper = create_custom_instance(context, &instance_extensions)?;
    let instance = &helper.instance;
    let physical_device = helper.physical_device;

    let surface = HeadlessSurface {
        instance,
        surface: unsafe { instance.create_headless_surface_ext(&vk::HeadlessSurfaceCreateInfoEXT::default(), None) }
            .vk_check("vkCreateHeadlessSurfaceEXT")?,
    };

    // DeviceHelper: one queue of the first family that can present to the surface
    let family_count = unsafe { instance.get_physical_device_queue_family_properties(physical_device) }.len() as u32;
    let mut queue_family_index = None;
    for family in 0..family_count {
        if unsafe { instance.get_physical_device_surface_support_khr(physical_device, family, surface.surface) }
            .vk_check("vkGetPhysicalDeviceSurfaceSupportKHR")?
        {
            queue_family_index = Some(family);
            break;
        }
    }
    let queue_family_index = queue_family_index.ok_or_else(|| {
        TestError::NotSupported("Device does not support presentation to the given surfaces".to_string())
    })?;

    let device_extensions = ["VK_KHR_swapchain", "VK_KHR_swapchain_mutable_format"];
    for extension in device_extensions {
        if !context.is_device_functionality_supported(extension) {
            return Err(TestError::NotSupported(format!("{extension} is not supported")));
        }
    }
    let extension_names = device_extensions.map(|extension| std::ffi::CString::new(extension).unwrap());
    let extension_ptrs: Vec<*const std::ffi::c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();
    let queue_priorities = [1.0f32];
    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priorities)
        .build()];
    let device_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&extension_ptrs);
    let device_guard = SwapchainDevice(
        unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?,
    );
    let device = &device_guard.0;
    let queue = unsafe { device.get_device_queue(queue_family_index, 0) };

    let image_usage = get_image_usage_for_test_case(&case_def);
    for format in [case_def.image_format, case_def.view_format] {
        let result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                format,
                map_image_type(case_def.image_type),
                vk::ImageTiling::OPTIMAL,
                image_usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if result == Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
            return Err(TestError::NotSupported(
                "Image format is not supported for required usage".to_string(),
            ));
        }
    }

    let capabilities =
        unsafe { instance.get_physical_device_surface_capabilities_khr(physical_device, surface.surface) }
            .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;

    if case_def.num_layers > capabilities.max_image_array_layers {
        case_def.num_layers = capabilities.max_image_array_layers;
    }

    // Check support for requested formats by swapchain surface
    let surface_formats = unsafe { instance.get_physical_device_surface_formats_khr(physical_device, surface.surface) }
        .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
    let surface_format = surface_formats
        .iter()
        .rev()
        .find(|surface_format| surface_format.format == case_def.image_format)
        .copied()
        .ok_or_else(|| TestError::NotSupported("Image format is not supported by swapchain.".to_string()))?;
    if !surface_formats
        .iter()
        .any(|format| format.format == case_def.view_format)
    {
        return Err(TestError::NotSupported(
            "Image view format is not supported by swapchain.".to_string(),
        ));
    }
    if !capabilities.supported_usage_flags.contains(image_usage) {
        return Err(TestError::NotSupported(
            "Image usage request not supported by swapchain.".to_string(),
        ));
    }

    // makeSwapchain
    let format_list = [surface_format.format, case_def.view_format];
    let format_list_info = vk::ImageFormatListCreateInfo {
        view_format_count: 2,
        view_formats: format_list.as_ptr(),
        ..Default::default()
    };
    let transform = if capabilities
        .supported_transforms
        .contains(vk::SurfaceTransformFlagsKHR::IDENTITY)
    {
        vk::SurfaceTransformFlagsKHR::IDENTITY
    } else {
        capabilities.current_transform
    };
    let max_image_count = if capabilities.max_image_count > 0 {
        capabilities.max_image_count
    } else {
        capabilities.min_image_count + 2
    };
    let swapchain_info = vk::SwapchainCreateInfoKHR {
        next: ptr::from_ref(&format_list_info).cast::<c_void>(),
        flags: vk::SwapchainCreateFlagsKHR::MUTABLE_FORMAT,
        surface: surface.surface,
        min_image_count: 2u32.max(capabilities.min_image_count).min(max_image_count),
        image_format: surface_format.format,
        image_color_space: surface_format.color_space,
        image_extent: vk::Extent2D {
            width: DESIRED_SIZE.0,
            height: DESIRED_SIZE.1,
        },
        image_array_layers: case_def.num_layers,
        image_usage,
        image_sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: ptr::null(),
        pre_transform: transform,
        composite_alpha: vk::CompositeAlphaFlagsKHR::OPAQUE,
        present_mode: vk::PresentModeKHR::FIFO,
        clipped: vk::FALSE,
        old_swapchain: vk::SwapchainKHR::null(),
        ..Default::default()
    };
    let swapchain = unsafe { device.create_swapchain_khr(&swapchain_info, None) }.vk_check("vkCreateSwapchainKHR")?;
    let mut guard = SwapchainGuard {
        device,
        swapchain,
        semaphore: vk::Semaphore::null(),
    };
    let swapchain_images = unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;

    guard.semaphore =
        unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::default(), None) }.vk_check("vkCreateSemaphore")?;
    let (image_ndx, _) =
        unsafe { device.acquire_next_image_khr(swapchain, u64::MAX, guard.semaphore, vk::Fence::null()) }
            .vk_check("vkAcquireNextImageKHR")?;

    // A color buffer for host inspection of the results (see `test_mutable`)
    let color_buffer_size = (case_def.size[0]
        * case_def.size[1]
        * case_def.size[2]
        * case_def.num_layers
        * pixel_size(case_def.image_format)?) as usize;
    let color_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(color_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::write_bytes(color_buffer.get_allocation().get_host_ptr(), 0, color_buffer_size) };
    flush_alloc(device, color_buffer.get_allocation())?;

    // Execute the test
    let mut executor =
        UploadDownloadExecutor::new(context, false, case_def).with_device(device, queue, queue_family_index);
    executor.run_swapchain(
        color_buffer.get(),
        swapchain_images[image_ndx as usize],
        guard.semaphore,
    )?;
    drop(executor);

    verify_color_buffer(device, &color_buffer, color_buffer_size, &case_def)
}

struct ImageSwapchainMutableCase {
    inner: ImageMutableCase,
}

impl TestCase for ImageSwapchainMutableCase {
    fn name(&self) -> &str {
        self.inner.name()
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.inner.check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.inner.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageSwapchainMutableInstance {
            context,
            case_def: self.inner.case_def,
        })
    }
}

struct ImageSwapchainMutableInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDef,
}

impl TestInstance for ImageSwapchainMutableInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_swapchain_mutable(self.context, self.case_def)
    }
}

/// `createSwapchainImageMutableTests` for the headless platform: the cases keyed by their dotted path (`swapchain_mutable.headless.<type>.<name>`)
pub fn create_headless_swapchain_mutable_cases() -> HashMap<String, Box<dyn TestCase>> {
    let textures = [
        Texture::simple(ImageType::TwoD, [32, 32, 1], 1),
        Texture::simple(ImageType::TwoDArray, [32, 32, 1], 4),
    ];
    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();

    for texture in textures {
        let layer_size = texture.layer_size(0);
        let size = [layer_size[0] as u32, layer_size[1] as u32, layer_size[2] as u32];
        let num_layers = texture.num_layers() as u32;

        for (image_format_ndx, &image_format) in S_SWAPCHAIN_FORMATS.iter().enumerate() {
            for (view_format_ndx, &view_format) in S_SWAPCHAIN_FORMATS.iter().enumerate() {
                if image_format_ndx == view_format_ndx || !formats_are_compatible(image_format, view_format) {
                    continue;
                }

                for upload in UPLOADS {
                    if upload == Upload::Store && !is_format_image_load_store_capable(view_format) {
                        continue;
                    }

                    for download in DOWNLOADS {
                        if matches!(download, Download::Load | Download::Texture)
                            && !is_format_image_load_store_capable(view_format)
                        {
                            continue;
                        }

                        let case_def = CaseDef {
                            image_type: texture.type_(),
                            size,
                            num_layers,
                            image_format,
                            view_format,
                            upload,
                            download,
                            is_format_list_test: true,
                            extended_flags: false,
                            resolve_attachment_test_type: ResolveAttachmentTestType::None,
                            is_load_op_clear_test: false,
                        };
                        let case_name = format!(
                            "{}_{}_{}_{}_format_list",
                            format_short_string(image_format),
                            format_short_string(view_format),
                            upload_string(upload),
                            download_string(download)
                        );
                        cases.insert(
                            format!(
                                "swapchain_mutable.headless.{}.{case_name}",
                                get_image_type_name(texture.type_())
                            ),
                            Box::new(ImageSwapchainMutableCase {
                                inner: ImageMutableCase {
                                    name: case_name,
                                    case_def,
                                },
                            }),
                        );
                    }
                }
            }
        }
    }
    cases
}

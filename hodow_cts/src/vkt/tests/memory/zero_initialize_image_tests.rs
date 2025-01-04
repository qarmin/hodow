// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryZeroInitializeDeviceMemoryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `image_transition` group of `zero_initialize_device_memory`: an image whose memory was allocated with
// VK_MEMORY_ALLOCATE_ZERO_INITIALIZE_BIT_EXT is moved out of VK_IMAGE_LAYOUT_ZERO_INITIALIZED_EXT and read
// back through a transfer, a compute shader or a fragment shader (`ImageTransitionCase`), or used as the
// depth/stencil attachment of a draw that only passes where it reads zero (`DepthFormatCase`). The GLSL of
// the shader cases is `shaders/manifest/memory_zero_initialize_image.toml`, written by
// `scripts/gen_zero_init_image_manifest.py`.
//
// Everything runs on the device `ZeroInitDevice` creates, because the Context's own device does not enable
// the extension's feature. Its allocator cannot be used with that device either, so the images and buffers
// here are bound to memory allocated directly, as the buffer group does.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::memory_zero_initialize_image::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::memory::zero_initialize_device_memory_tests::{
    ZeroInitAllocation, ZeroInitDevice, allocate_memory, check_zero_initialize_device_memory_support, create_buffer,
    get_tested_memory_types, is_host_visible_memory,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};
use crate::{tcu_fail, tcu_throw_not_supported};

#[derive(Clone, Copy, PartialEq, Eq)]
enum ChannelClass {
    Float,
    Int,
    Uint,
}

/// What `ImageTransitionParams` derives from a `VkFormat` through `tcu::TextureFormat`.
struct ColorFormatInfo {
    format: vk::Format,
    name: &'static str,
    channels: u32,
    class: ChannelClass,
    pixel_size: usize,
    compressed: bool,
}

/// `formatList` of the colour cases, in upstream's order.
static COLOR_FORMATS: [ColorFormatInfo; 10] = [
    ColorFormatInfo {
        format: vk::Format::R8_UNORM,
        name: "r8_unorm",
        channels: 1,
        class: ChannelClass::Float,
        pixel_size: 1,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::R8G8_UNORM,
        name: "r8g8_unorm",
        channels: 2,
        class: ChannelClass::Float,
        pixel_size: 2,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::R16_UNORM,
        name: "r16_unorm",
        channels: 1,
        class: ChannelClass::Float,
        pixel_size: 2,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::R8G8B8_UNORM,
        name: "r8g8b8_unorm",
        channels: 3,
        class: ChannelClass::Float,
        pixel_size: 3,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::R8G8B8A8_UNORM,
        name: "r8g8b8a8_unorm",
        channels: 4,
        class: ChannelClass::Float,
        pixel_size: 4,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::R32_UINT,
        name: "r32_uint",
        channels: 1,
        class: ChannelClass::Uint,
        pixel_size: 4,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::R32_SINT,
        name: "r32_sint",
        channels: 1,
        class: ChannelClass::Int,
        pixel_size: 4,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::R32_SFLOAT,
        name: "r32_sfloat",
        channels: 1,
        class: ChannelClass::Float,
        pixel_size: 4,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::R32G32B32A32_SFLOAT,
        name: "r32g32b32a32_sfloat",
        channels: 4,
        class: ChannelClass::Float,
        pixel_size: 16,
        compressed: false,
    },
    ColorFormatInfo {
        format: vk::Format::BC1_RGBA_UNORM_BLOCK,
        name: "bc1_rgba_unorm_block",
        channels: 4,
        class: ChannelClass::Float,
        pixel_size: 0,
        compressed: true,
    },
];

/// `formats::depthAndStencilFormats`, paired with the case name.
static DEPTH_STENCIL_FORMATS: [(vk::Format, &str); 7] = [
    (vk::Format::D16_UNORM, "d16_unorm"),
    (vk::Format::X8_D24_UNORM_PACK32, "x8_d24_unorm_pack32"),
    (vk::Format::D32_SFLOAT, "d32_sfloat"),
    (vk::Format::S8_UINT, "s8_uint"),
    (vk::Format::D16_UNORM_S8_UINT, "d16_unorm_s8_uint"),
    (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
    (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
];

const MIP_SIZES: [(u32, u32); 4] = [(1, 1), (4, 4), (53, 92), (512, 512)];

/// `getImageAspectFlags(mapVkFormat(format))` for the depth/stencil formats.
fn depth_stencil_aspects(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::D16_UNORM | vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D32_SFLOAT => vk::ImageAspectFlags::DEPTH,
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        _ => vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
    }
}

/// The part of `checkSupport` both case kinds share: the extension, the format's properties for `usage` and the extents it needs.
fn check_image_support(
    context: &Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    creation_extent: (u32, u32),
    mip_level_count: u32,
) -> Result<(), TestError> {
    check_zero_initialize_device_memory_support(context)?;

    let properties = match unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    } {
        Ok(properties) => properties,
        Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
            tcu_throw_not_supported!("Format not supported for the target usage")
        }
        Err(error) => {
            return Err(TestError::Fail(format!(
                "vkGetPhysicalDeviceImageFormatProperties returned {error:?}"
            )));
        }
    };

    if creation_extent.0 > properties.max_extent.width
        || creation_extent.1 > properties.max_extent.height
        || 1 > properties.max_extent.depth
    {
        tcu_throw_not_supported!("Requested extent not supported");
    }

    if mip_level_count > properties.max_mip_levels {
        tcu_throw_not_supported!("Requested mip level count not supported");
    }
    Ok(())
}

/// `vk::createImage`
fn create_image<'a>(vk: &'a Device, create_info: &vk::ImageCreateInfo) -> Result<Unique<'a, vk::Image>, TestError> {
    let image = unsafe { vk.create_image(create_info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(vk, image))
}

/// An image and the memory bound to it, in the order they must be destroyed: the handle first.
struct TestedImage<'a> {
    image: Unique<'a, vk::Image>,
    _allocation: ZeroInitAllocation<'a>,
}

impl<'a> TestedImage<'a> {
    fn new(
        vk: &'a Device,
        create_info: &vk::ImageCreateInfo,
        mem_reqs: &vk::MemoryRequirements,
        mem_properties: &vk::PhysicalDeviceMemoryProperties,
        mem_type_idx: u32,
        zero_initialize: bool,
    ) -> Result<Self, TestError> {
        let image = create_image(vk, create_info)?;
        let allocation = allocate_memory(vk, mem_properties, mem_reqs, mem_type_idx, zero_initialize)?;
        unsafe { vk.bind_image_memory(*image, allocation.get_memory(), allocation.get_offset()) }
            .vk_check("vkBindImageMemory")?;
        Ok(Self {
            image,
            _allocation: allocation,
        })
    }

    fn get(&self) -> vk::Image {
        *self.image
    }
}

/// A host-visible buffer bound to memory allocated without the zero-initialize flag.
struct HostBuffer<'a> {
    buffer: Unique<'a, vk::Buffer>,
    allocation: ZeroInitAllocation<'a>,
    size: usize,
}

impl<'a> HostBuffer<'a> {
    fn new(
        vk: &'a Device,
        mem_properties: &vk::PhysicalDeviceMemoryProperties,
        size: vk::DeviceSize,
        usage: vk::BufferUsageFlags,
    ) -> Result<Self, TestError> {
        let buffer = create_buffer(vk, &make_buffer_create_info(size, usage))?;
        let mem_reqs = unsafe { vk.get_buffer_memory_requirements(*buffer) };

        let host_visible = (0..mem_properties.memory_type_count)
            .filter(|&i| (mem_reqs.memory_type_bits & (1u32 << i)) != 0 && is_host_visible_memory(mem_properties, i))
            .collect::<Vec<_>>();
        let coherent = host_visible.iter().copied().find(|&i| {
            mem_properties.memory_types[i as usize]
                .property_flags
                .contains(vk::MemoryPropertyFlags::HOST_COHERENT)
        });
        let Some(mem_type_idx) = coherent.or_else(|| host_visible.first().copied()) else {
            tcu_throw_not_supported!("No host-visible memory type for the result buffer");
        };

        let allocation = allocate_memory(vk, mem_properties, &mem_reqs, mem_type_idx, false)?;
        unsafe { vk.bind_buffer_memory(*buffer, allocation.get_memory(), allocation.get_offset()) }
            .vk_check("vkBindBufferMemory")?;
        Ok(Self {
            buffer,
            allocation,
            size: size as usize,
        })
    }

    fn get(&self) -> vk::Buffer {
        *self.buffer
    }

    /// `invalidateAlloc` followed by `getHostPtr`, as a slice of the whole buffer.
    fn read(&self) -> Result<&[u8], TestError> {
        self.allocation.invalidate()?;
        Ok(unsafe { std::slice::from_raw_parts(self.allocation.get_host_ptr(), self.size) })
    }
}

/// The lowest memory type the resource accepts; the memory of the result buffer and of the colour target is never what is under test.
fn first_usable_memory_type(
    mem_properties: &vk::PhysicalDeviceMemoryProperties,
    usable_mem_types: u32,
) -> Result<u32, TestError> {
    let types = get_tested_memory_types(mem_properties, usable_mem_types, MemoryRequirement::ANY);
    if types == 0 {
        tcu_throw_not_supported!("No compatible memory types found");
    }
    Ok(types.trailing_zeros())
}

/// A render pass over `attachments` that renders with one subpass and keeps everything it loads.
fn make_load_render_pass<'a>(
    device: &'a Device,
    color_format: Option<vk::Format>,
    ds_format: Option<vk::Format>,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let mut attachments = Vec::new();
    let mut color_references = Vec::new();
    if let Some(format) = color_format {
        attachments.push(
            vk::AttachmentDescription::builder()
                .format(format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        );
        color_references.push(vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        });
    }
    let depth_reference = ds_format.map(|format| {
        let index = attachments.len() as u32;
        attachments.push(
            vk::AttachmentDescription::builder()
                .format(format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::LOAD)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        );
        vk::AttachmentReference {
            attachment: index,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        }
    });

    let mut subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_references);
    if let Some(reference) = depth_reference.as_ref() {
        subpass = subpass.depth_stencil_attachment(reference);
    }
    let subpasses = [subpass.build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

fn begin_load_render_pass(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    width: u32,
    height: u32,
) {
    let info = vk::RenderPassBeginInfo::builder()
        .render_pass(render_pass)
        .framebuffer(framebuffer)
        .render_area(vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width, height },
        });
    unsafe { device.cmd_begin_render_pass(cmd_buffer, &info, vk::SubpassContents::INLINE) };
}

fn pipeline_image_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

fn pipeline_memory_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::MemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `ImageTransitionParams`
#[derive(Clone, Copy)]
struct ImageTransitionParams {
    info: &'static ColorFormatInfo,
    main_usage: vk::ImageUsageFlags,
    mip_extent: (u32, u32),
    first_mip: bool,
    /// `None` is upstream's `VK_SHADER_STAGE_FLAG_BITS_MAX_ENUM`: the transfer cases have no read stage.
    read_stage: Option<vk::ShaderStageFlags>,
}

impl ImageTransitionParams {
    fn mip_level_count(&self) -> u32 {
        if self.first_mip { 1 } else { 2 }
    }

    fn creation_extent(&self) -> (u32, u32) {
        if self.first_mip {
            self.mip_extent
        } else {
            (2 * self.mip_extent.0, 2 * self.mip_extent.1)
        }
    }

    fn is_transfer(&self) -> bool {
        self.main_usage == vk::ImageUsageFlags::TRANSFER_SRC
    }

    fn read_pipeline_stage(&self) -> vk::PipelineStageFlags {
        if self.is_transfer() {
            vk::PipelineStageFlags::TRANSFER
        } else if self.read_stage == Some(vk::ShaderStageFlags::COMPUTE) {
            vk::PipelineStageFlags::COMPUTE_SHADER
        } else {
            vk::PipelineStageFlags::FRAGMENT_SHADER
        }
    }

    /// The key of this case's entry in the shader manifest.
    fn shader_key(&self) -> Option<String> {
        let stage = match self.read_stage {
            Some(vk::ShaderStageFlags::COMPUTE) => "comp",
            Some(vk::ShaderStageFlags::FRAGMENT) => "frag",
            _ => return None,
        };
        let usage = if self.main_usage == vk::ImageUsageFlags::STORAGE {
            "storage"
        } else {
            "sampled"
        };
        Some(format!(
            "{}_{}_{}_{}x{}",
            self.info.name, usage, stage, self.mip_extent.0, self.mip_extent.1
        ))
    }
}

/// `ImageTransitionCase`
struct ImageTransitionCase {
    name: String,
    params: ImageTransitionParams,
}

impl TestCase for ImageTransitionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_image_support(
            context,
            self.params.info.format,
            self.params.main_usage,
            self.params.creation_extent(),
            self.params.mip_level_count(),
        )?;

        // The zero-initialize device enables whatever of these the physical device has; the shaders need them.
        let features = context.get_device_features();
        if self.params.info.compressed && features.texture_compression_bc == vk::FALSE {
            tcu_throw_not_supported!("textureCompressionBC not supported");
        }
        if self.params.read_stage == Some(vk::ShaderStageFlags::FRAGMENT)
            && features.fragment_stores_and_atomics == vk::FALSE
        {
            tcu_throw_not_supported!("fragmentStoresAndAtomics not supported");
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.shader_key() {
            Some(key) => ALL_SHARED_PROGRAM
                .iter()
                .find(|program| program.name == key)
                .map_or_else(|| BinaryCollection::new(&[]), |program| program.programs),
            None => BinaryCollection::new(&[]),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageTransitionTest {
            context,
            params: self.params,
        })
    }
}

struct ImageTransitionTest<'a> {
    context: &'a Context<'a>,
    params: ImageTransitionParams,
}

impl TestInstance for ImageTransitionTest<'_> {
    fn iterate(&mut self) -> TestOutcome {
        iterate_image_transition(self.context, &self.params)
    }
}

/// Whether the shader result of every texel is `(0, 0, 0, alpha)`, with `alpha` 1 for a format that has no alpha to hold a zero.
fn shader_result_is_zero(bytes: &[u8], info: &ColorFormatInfo) -> bool {
    let alpha_is_one = info.channels <= 3 || info.compressed;
    bytes.chunks_exact(16).all(|texel| {
        let words: Vec<[u8; 4]> = texel
            .chunks_exact(4)
            .map(|word| [word[0], word[1], word[2], word[3]])
            .collect();
        match info.class {
            ChannelClass::Float => {
                let alpha = f32::from_ne_bytes(words[3]);
                words[..3].iter().all(|word| f32::from_ne_bytes(*word) == 0.0)
                    && alpha == if alpha_is_one { 1.0 } else { 0.0 }
            }
            ChannelClass::Int | ChannelClass::Uint => {
                words[..3].iter().all(|word| u32::from_ne_bytes(*word) == 0)
                    && u32::from_ne_bytes(words[3]) == u32::from(alpha_is_one)
            }
        }
    })
}

/// `ImageTransitionTest::iterate`
fn iterate_image_transition(context: &Context<'_>, params: &ImageTransitionParams) -> TestOutcome {
    let zero_init_device = ZeroInitDevice::new(context)?;
    let vk = &zero_init_device.device;
    let queue = zero_init_device.queue;
    let qf_index = context.get_universal_queue_family_index();

    let info = params.info;
    let (mip_width, mip_height) = params.mip_extent;
    let mip_level_count = params.mip_level_count();
    let image_usage = vk::ImageUsageFlags::TRANSFER_SRC | params.main_usage;
    let pixel_count = (mip_width * mip_height) as usize;
    let is_transfer = params.is_transfer();
    let creation_extent = params.creation_extent();

    let image_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(info.format)
        .extent(vk::Extent3D {
            width: creation_extent.0,
            height: creation_extent.1,
            depth: 1,
        })
        .mip_levels(mip_level_count)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(image_usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::ZERO_INITIALIZED_EXT)
        .build();
    let template_image = create_image(vk, &image_create_info)?;
    let image_mem_reqs = unsafe { vk.get_image_memory_requirements(*template_image) };

    let mem_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };

    let tested_mem_types =
        get_tested_memory_types(&mem_properties, image_mem_reqs.memory_type_bits, MemoryRequirement::ANY);

    let full_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, mip_level_count, 0, 1);
    let view_level = mip_level_count - 1;
    let view_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, view_level, 1, 0, 1);

    let (buffer_size, buffer_usage) = if is_transfer {
        (info.pixel_size * pixel_count, vk::BufferUsageFlags::TRANSFER_DST)
    } else {
        (pixel_count * 16, vk::BufferUsageFlags::STORAGE_BUFFER)
    };
    let buffer = HostBuffer::new(vk, &mem_properties, buffer_size as vk::DeviceSize, buffer_usage)?;

    let mut failed_mem_types = Vec::<u32>::new();

    for mem_type_idx in 0..mem_properties.memory_type_count {
        if (tested_mem_types & (1u32 << mem_type_idx)) == 0 {
            continue;
        }

        let image = TestedImage::new(
            vk,
            &image_create_info,
            &image_mem_reqs,
            &mem_properties,
            mem_type_idx,
            true,
        )?;

        let image_view = if is_transfer {
            None
        } else {
            Some(make_image_view(
                vk,
                image.get(),
                vk::ImageViewType::_2D,
                info.format,
                view_srr,
            )?)
        };

        let cmd_pool = make_command_pool(vk, qf_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        if is_transfer {
            begin_command_buffer(vk, *cmd_buffer)?;
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::ZERO_INITIALIZED_EXT,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image.get(),
                full_srr,
            );
            pipeline_image_barrier(
                vk,
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                barrier,
            );

            let copy_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, view_level, 0, 1);
            let region = make_buffer_image_copy(
                vk::Extent3D {
                    width: mip_width,
                    height: mip_height,
                    depth: 1,
                },
                copy_srl,
            );
            unsafe {
                vk.cmd_copy_image_to_buffer(
                    *cmd_buffer,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffer.get(),
                    &[region],
                )
            };

            let barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            pipeline_memory_barrier(
                vk,
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                barrier,
            );
            end_command_buffer(vk, *cmd_buffer)?;
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;
        } else {
            let border_color = if info.class == ChannelClass::Float {
                vk::BorderColor::FLOAT_TRANSPARENT_BLACK
            } else {
                vk::BorderColor::INT_TRANSPARENT_BLACK
            };
            let sampler_create_info = vk::SamplerCreateInfo::builder()
                .mag_filter(vk::Filter::NEAREST)
                .min_filter(vk::Filter::NEAREST)
                .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
                .address_mode_u(vk::SamplerAddressMode::REPEAT)
                .address_mode_v(vk::SamplerAddressMode::REPEAT)
                .address_mode_w(vk::SamplerAddressMode::REPEAT)
                .mip_lod_bias(0.0)
                .anisotropy_enable(false)
                .max_anisotropy(0.0)
                .compare_enable(false)
                .compare_op(vk::CompareOp::NEVER)
                .min_lod(0.0)
                .max_lod(0.0)
                .border_color(border_color)
                .unnormalized_coordinates(false);
            let sampler = Unique::new(
                vk,
                unsafe { vk.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
            );

            let (img_desc_type, final_layout, descriptor_sampler) = if params.main_usage == vk::ImageUsageFlags::STORAGE
            {
                (
                    vk::DescriptorType::STORAGE_IMAGE,
                    vk::ImageLayout::GENERAL,
                    vk::Sampler::null(),
                )
            } else {
                (
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    *sampler,
                )
            };
            let buffer_desc_type = vk::DescriptorType::STORAGE_BUFFER;
            let read_stage = params.read_stage.expect("a shader case has a read stage");

            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(img_desc_type, 1)
                .add_type(buffer_desc_type, 1)
                .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(img_desc_type, read_stage)
                .add_single_binding(buffer_desc_type, read_stage)
                .build(vk)?;
            let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *set_layout)?;

            let image_infos = [vk::DescriptorImageInfo {
                sampler: descriptor_sampler,
                image_view: **image_view.as_ref().expect("a shader case has a view"),
                image_layout: final_layout,
            }];
            let buffer_infos = [make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE)];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(0)
                    .descriptor_type(img_desc_type)
                    .image_info(&image_infos)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(1)
                    .descriptor_type(buffer_desc_type)
                    .buffer_info(&buffer_infos)
                    .build(),
            ];
            unsafe { vk.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

            let programs = context.get_binary_collection();

            let mut comp_pipeline = None;
            let mut graphics_state = None;
            if read_stage == vk::ShaderStageFlags::COMPUTE {
                let mut pipeline =
                    ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, programs.get("comp")?);
                pipeline.set_descriptor_set_layout(*set_layout);
                pipeline.build_pipeline()?;
                comp_pipeline = Some(pipeline);
            } else {
                let pipeline_layout = make_pipeline_layout(vk, &[*set_layout])?;
                let render_pass = make_load_render_pass(vk, None, None)?;
                let framebuffer = make_framebuffer(vk, *render_pass, &[], mip_width, mip_height, 1)?;
                let vert_shader = create_shader_module(vk, programs.get("vert")?)?;
                let frag_shader = create_shader_module(vk, programs.get("frag")?)?;

                let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                    .with_full_viewport(mip_width, mip_height);
                state.color_attachment_count = 0;
                let pipeline = create_draw_pipeline(
                    vk,
                    *pipeline_layout,
                    *render_pass,
                    &[
                        (vk::ShaderStageFlags::VERTEX, *vert_shader),
                        (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
                    ],
                    &state,
                )?;
                graphics_state = Some((
                    pipeline,
                    framebuffer,
                    render_pass,
                    pipeline_layout,
                    vert_shader,
                    frag_shader,
                ));
            }

            begin_command_buffer(vk, *cmd_buffer)?;
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::ZERO_INITIALIZED_EXT,
                final_layout,
                image.get(),
                full_srr,
            );
            pipeline_image_barrier(
                vk,
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                barrier,
            );

            if let Some(pipeline) = comp_pipeline.as_ref() {
                unsafe {
                    vk.cmd_bind_descriptor_sets(
                        *cmd_buffer,
                        vk::PipelineBindPoint::COMPUTE,
                        pipeline.get_pipeline_layout(),
                        0,
                        &[*descriptor_set],
                        &[] as &[u32],
                    );
                }
                pipeline.bind(*cmd_buffer);
                unsafe { vk.cmd_dispatch(*cmd_buffer, mip_height, 1, 1) };
            } else if let Some((pipeline, framebuffer, render_pass, pipeline_layout, _, _)) = graphics_state.as_ref() {
                begin_load_render_pass(vk, *cmd_buffer, **render_pass, **framebuffer, mip_width, mip_height);
                unsafe {
                    vk.cmd_bind_descriptor_sets(
                        *cmd_buffer,
                        vk::PipelineBindPoint::GRAPHICS,
                        **pipeline_layout,
                        0,
                        &[*descriptor_set],
                        &[] as &[u32],
                    );
                    vk.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                    vk.cmd_draw(*cmd_buffer, 3, 1, 0, 0);
                    vk.cmd_end_render_pass(*cmd_buffer);
                }
            }

            let src_access = if is_transfer {
                vk::AccessFlags::TRANSFER_WRITE
            } else {
                vk::AccessFlags::SHADER_WRITE
            };
            let barrier = make_memory_barrier(src_access, vk::AccessFlags::HOST_READ);
            pipeline_memory_barrier(
                vk,
                *cmd_buffer,
                params.read_pipeline_stage(),
                vk::PipelineStageFlags::HOST,
                barrier,
            );
            end_command_buffer(vk, *cmd_buffer)?;
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;
        }

        let result = buffer.read()?;
        let buffer_ok = if is_transfer {
            result.iter().all(|&byte| byte == 0)
        } else {
            shader_result_is_zero(result, info)
        };

        if !buffer_ok {
            failed_mem_types.push(mem_type_idx);
        }
    }

    if !failed_mem_types.is_empty() {
        tcu_fail!(
            "Some memory types failed; unexpected results in the output buffer for memory types {failed_mem_types:?}"
        );
    }

    Ok(TestStatus::pass("Pass"))
}

/// `DepthFormatParams`
#[derive(Clone, Copy)]
struct DepthFormatParams {
    format: vk::Format,
    mip_extent: (u32, u32),
    first_mip: bool,
}

impl DepthFormatParams {
    fn usage(&self) -> vk::ImageUsageFlags {
        vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
    }

    fn mip_level_count(&self) -> u32 {
        if self.first_mip { 1 } else { 2 }
    }

    fn creation_extent(&self) -> (u32, u32) {
        if self.first_mip {
            self.mip_extent
        } else {
            (2 * self.mip_extent.0, 2 * self.mip_extent.1)
        }
    }
}

/// `DepthFormatCase`
struct DepthFormatCase {
    name: String,
    params: DepthFormatParams,
}

impl TestCase for DepthFormatCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_image_support(
            context,
            self.params.format,
            self.params.usage(),
            self.params.creation_extent(),
            self.params.mip_level_count(),
        )
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "depth")
            .map_or_else(|| BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthFormatTest {
            context,
            params: self.params,
        })
    }
}

struct DepthFormatTest<'a> {
    context: &'a Context<'a>,
    params: DepthFormatParams,
}

impl TestInstance for DepthFormatTest<'_> {
    fn iterate(&mut self) -> TestOutcome {
        iterate_depth_format(self.context, &self.params)
    }
}

/// `DepthFormatTest::iterate`
fn iterate_depth_format(context: &Context<'_>, params: &DepthFormatParams) -> TestOutcome {
    let zero_init_device = ZeroInitDevice::new(context)?;
    let vk = &zero_init_device.device;
    let queue = zero_init_device.queue;
    let qf_index = context.get_universal_queue_family_index();

    let color_format = vk::Format::R8G8B8A8_UNORM;
    let (fb_width, fb_height) = params.mip_extent;
    let color_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let mip_level_count = params.mip_level_count();
    let mem_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };

    let color_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(color_format)
        .extent(vk::Extent3D {
            width: fb_width,
            height: fb_height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(color_usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_template = create_image(vk, &color_create_info)?;
    let color_mem_reqs = unsafe { vk.get_image_memory_requirements(*color_template) };
    let color_mem_type = first_usable_memory_type(&mem_properties, color_mem_reqs.memory_type_bits)?;
    let color_image = TestedImage::new(
        vk,
        &color_create_info,
        &color_mem_reqs,
        &mem_properties,
        color_mem_type,
        false,
    )?;
    let color_view = make_image_view(vk, color_image.get(), vk::ImageViewType::_2D, color_format, color_srr)?;
    let color_buffer = HostBuffer::new(
        vk,
        &mem_properties,
        (fb_width * fb_height * 4) as vk::DeviceSize,
        vk::BufferUsageFlags::TRANSFER_DST,
    )?;

    let ds_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(params.format)
        .extent(vk::Extent3D {
            width: params.creation_extent().0,
            height: params.creation_extent().1,
            depth: 1,
        })
        .mip_levels(mip_level_count)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(params.usage())
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::ZERO_INITIALIZED_EXT)
        .build();
    let ds_template = create_image(vk, &ds_create_info)?;
    let ds_mem_reqs = unsafe { vk.get_image_memory_requirements(*ds_template) };
    let tested_mem_types =
        get_tested_memory_types(&mem_properties, ds_mem_reqs.memory_type_bits, MemoryRequirement::ANY);

    let ds_aspects = depth_stencil_aspects(params.format);
    let ds_full_srr = make_image_subresource_range(ds_aspects, 0, mip_level_count, 0, 1);
    let view_level = mip_level_count - 1;
    let view_srr = make_image_subresource_range(ds_aspects, view_level, 1, 0, 1);

    let mut failed_mem_types = Vec::<u32>::new();

    for mem_type_idx in 0..mem_properties.memory_type_count {
        if (tested_mem_types & (1u32 << mem_type_idx)) == 0 {
            continue;
        }

        let ds_image = TestedImage::new(vk, &ds_create_info, &ds_mem_reqs, &mem_properties, mem_type_idx, true)?;
        let ds_view = make_image_view(vk, ds_image.get(), vk::ImageViewType::_2D, params.format, view_srr)?;

        let cmd_pool = make_command_pool(vk, qf_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let pipeline_layout = make_pipeline_layout(vk, &[])?;
        let render_pass = make_load_render_pass(vk, Some(color_format), Some(params.format))?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_view, *ds_view], fb_width, fb_height, 1)?;

        let programs = context.get_binary_collection();
        let vert_shader = create_shader_module(vk, programs.get("vert")?)?;
        let frag_shader = create_shader_module(vk, programs.get("frag")?)?;

        let depth_enable = ds_aspects.contains(vk::ImageAspectFlags::DEPTH);
        let stencil_enable = ds_aspects.contains(vk::ImageAspectFlags::STENCIL);
        let stencil_op = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::EQUAL)
            .compare_mask(0xFF)
            .write_mask(0xFF)
            .reference(0)
            .build();
        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(fb_width, fb_height);
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(depth_enable)
            .depth_write_enable(false)
            .depth_compare_op(vk::CompareOp::EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(stencil_enable)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0)
            .build();
        let pipeline = create_draw_pipeline(
            vk,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            &state,
        )?;

        begin_command_buffer(vk, *cmd_buffer)?;
        {
            let dst_access =
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
            let dst_stages = vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                dst_access,
                vk::ImageLayout::ZERO_INITIALIZED_EXT,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                ds_image.get(),
                ds_full_srr,
            );
            pipeline_image_barrier(
                vk,
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                dst_stages,
                barrier,
            );

            let pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                color_image.get(),
                color_srr,
            );
            pipeline_image_barrier(
                vk,
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                pre_clear_barrier,
            );

            let clear_color = vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            };
            unsafe {
                vk.cmd_clear_color_image(
                    *cmd_buffer,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color,
                    &[color_srr],
                )
            };

            let post_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                color_srr,
            );
            pipeline_image_barrier(
                vk,
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                post_clear_barrier,
            );
        }
        begin_load_render_pass(vk, *cmd_buffer, *render_pass, *framebuffer, fb_width, fb_height);
        unsafe {
            vk.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            vk.cmd_draw(*cmd_buffer, 3, 1, 0, 0);
            vk.cmd_end_render_pass(*cmd_buffer);
        }

        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            color_srr,
        );
        pipeline_image_barrier(
            vk,
            *cmd_buffer,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            to_transfer,
        );
        let copy_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: fb_width,
                height: fb_height,
                depth: 1,
            },
            copy_srl,
        );
        unsafe {
            vk.cmd_copy_image_to_buffer(
                *cmd_buffer,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                &[region],
            )
        };
        let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        pipeline_memory_barrier(
            vk,
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            to_host,
        );

        end_command_buffer(vk, *cmd_buffer)?;
        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        let result = color_buffer.read()?;
        if !result.chunks_exact(4).all(|texel| texel == [0, 0, 255, 255]) {
            failed_mem_types.push(mem_type_idx);
        }
    }

    if !failed_mem_types.is_empty() {
        tcu_fail!(
            "Some memory types failed; unexpected results in the color buffer for memory types {failed_mem_types:?}"
        );
    }

    Ok(TestStatus::pass("Pass"))
}

/// The `image_transition` group of `createClearedAllocationControlTests`.
pub fn create_image_transition_tests() -> TestCaseGroup {
    let mut image_transition = TestCaseGroup::new("image_transition");

    let usage_cases = [
        (vk::ImageUsageFlags::TRANSFER_SRC, "transfer_src"),
        (vk::ImageUsageFlags::SAMPLED, "sampled"),
        (vk::ImageUsageFlags::STORAGE, "storage"),
    ];
    let read_stage_cases: [(Option<vk::ShaderStageFlags>, &str); 3] = [
        (None, "xfer"),
        (Some(vk::ShaderStageFlags::COMPUTE), "comp"),
        (Some(vk::ShaderStageFlags::FRAGMENT), "frag"),
    ];

    for info in &COLOR_FORMATS {
        for (usage, usage_name) in usage_cases {
            // RGB8 storage images do not exist.
            if !info.compressed && info.channels == 3 && usage == vk::ImageUsageFlags::STORAGE {
                continue;
            }

            for (read_stage, stage_name) in read_stage_cases {
                let is_transfer = usage == vk::ImageUsageFlags::TRANSFER_SRC;

                if is_transfer && read_stage.is_some() {
                    continue;
                }
                if !is_transfer && read_stage.is_none() {
                    continue;
                }
                if is_transfer && info.compressed {
                    continue;
                }

                for mip_extent in MIP_SIZES {
                    for first_mip in [true, false] {
                        let params = ImageTransitionParams {
                            info,
                            main_usage: usage,
                            mip_extent,
                            first_mip,
                            read_stage,
                        };
                        let name = format!(
                            "{}_{}_shader_{}_{}x{}{}",
                            info.name,
                            usage_name,
                            stage_name,
                            mip_extent.0,
                            mip_extent.1,
                            if first_mip { "_first_mip" } else { "_second_mip" }
                        );
                        image_transition.add_child(Box::new(ImageTransitionCase { name, params }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }

    for (format, format_name) in DEPTH_STENCIL_FORMATS {
        for mip_extent in MIP_SIZES {
            for first_mip in [true, false] {
                let params = DepthFormatParams {
                    format,
                    mip_extent,
                    first_mip,
                };
                let name = format!(
                    "{}_{}x{}{}",
                    format_name,
                    mip_extent.0,
                    mip_extent.1,
                    if first_mip { "_first_mip" } else { "_second_mip" }
                );
                image_transition.add_child(Box::new(DepthFormatCase { name, params }) as Box<dyn TestCase>);
            }
        }
    }

    image_transition
}

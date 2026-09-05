// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyBufferToImageTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiCopiesAndBlittingUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// These tests compare against a reference image built on the host with a threshold of
// zero, so every byte of the source data and of the expected result has to be produced
// the same way twice - once uploaded to the driver, once computed here.

use vulkanalia::prelude::v1_0::*;
// vkCmdCopyBufferToImage2 is core in 1.3; the copy_commands2 group also accepts the
// KHR alias, but vulkanalia exposes the promoted name.
use vulkanalia::vk::DeviceV1_3;

use super::copies_buffer_tests::{AllocationKind, CopyCommandVariant, QueueSelection, bind_buffer_memory, select_queue};
use super::copy_format_lists::{COLOR_IMAGE_FORMATS_TO_TEST, CopyFormat, DEPTH_AND_STENCIL_FORMATS, SIGNED_AND_UNSIGNED_FLOAT_FORMATS};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, PixelBufferAccess, TextureLevel, fill_with_component_gradients2, fill_with_component_gradients3, get_texture_format_bit_depth, has_depth_component,
    has_stencil_component, is_combined_depth_stencil_type,
};
use crate::tcu::random::de_int32_hash;
use crate::tcu::texture::TextureChannelClass;
use crate::tcu::{self, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, get_depth_copy_format, get_stencil_copy_format, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// `defaultSize`
const DEFAULT_SIZE: u32 = 64;
/// `defaultHalfSize`
const DEFAULT_HALF_SIZE: u32 = DEFAULT_SIZE / 2;
/// `defaultQuarterSize`
const DEFAULT_QUARTER_SIZE: u32 = DEFAULT_SIZE / 4;
/// `default1dExtent`
const DEFAULT_1D_EXTENT: [u32; 3] = [DEFAULT_SIZE, 1, 1];
/// `defaultExtent`
const DEFAULT_EXTENT: [u32; 3] = [DEFAULT_SIZE, DEFAULT_SIZE, 1];
/// `defaultHalfExtent`
const DEFAULT_HALF_EXTENT: [u32; 3] = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, 1];

/// `de::roundUp`
fn round_up(value: u32, alignment: u32) -> u32 {
    value.div_ceil(alignment) * alignment
}

/// `FillMode`, narrowed to the modes the ported groups use.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum FillMode {
    Gradient,
    Pyramid,
    White,
    Red,
    RandomGray,
    BlueRedX,
    BlueRedY,
    BlueRedZ,
}

/// `ImageParms`
#[derive(Clone, Copy)]
pub struct ImageParms {
    pub image_type: vk::ImageType,
    pub format: vk::Format,
    pub extent: [u32; 3],
    pub tiling: vk::ImageTiling,
    pub fill_mode: FillMode,
    /// `ImageParms::createFlags`. Upstream defaults it to a sentinel meaning "derive
    /// from the type and layer count"; `None` is that sentinel. The cube tests set it
    /// explicitly, because a six-layer 2D image would otherwise always be made
    /// cube-compatible and the array side of a cube-to-array copy must not be.
    pub create_flags: Option<vk::ImageCreateFlags>,
}

impl ImageParms {
    /// `getArraySize`
    pub fn array_size(&self) -> u32 {
        if self.image_type != vk::ImageType::_3D { self.extent[2] } else { 1 }
    }

    /// `getExtent3D`
    pub fn extent_3d(&self) -> vk::Extent3D {
        self.extent_3d_at(0)
    }

    /// `getExtent3D(parms, mipLevel)`, uncompressed formats only.
    pub fn extent_3d_at(&self, mip_level: u32) -> vk::Extent3D {
        vk::Extent3D {
            width: self.extent[0] >> mip_level,
            height: if self.image_type != vk::ImageType::_1D { self.extent[1] >> mip_level } else { 1 },
            depth: if self.image_type == vk::ImageType::_3D { self.extent[2] >> mip_level } else { 1 },
        }
    }

    /// `getCreateFlags` - a 2D image whose layer count is a multiple of six is made
    /// cube-compatible, which upstream relies on for the cube array cases.
    pub fn create_flags(&self) -> vk::ImageCreateFlags {
        if let Some(flags) = self.create_flags {
            return flags;
        }
        if self.image_type == vk::ImageType::_2D && self.extent[2].is_multiple_of(6) {
            vk::ImageCreateFlags::CUBE_COMPATIBLE
        } else {
            vk::ImageCreateFlags::empty()
        }
    }
}

/// `vk::getAspectFlags`
pub fn get_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    let Some(f) = map_vk_format(format) else {
        return vk::ImageAspectFlags::COLOR;
    };
    let mut mask = vk::ImageAspectFlags::empty();
    if has_depth_component(f.order) {
        mask |= vk::ImageAspectFlags::DEPTH;
    }
    if has_stencil_component(f.order) {
        mask |= vk::ImageAspectFlags::STENCIL;
    }
    if mask.is_empty() { vk::ImageAspectFlags::COLOR } else { mask }
}

/// `CopyRegion::bufferImageCopy`
#[derive(Clone, Copy)]
pub struct BufferImageCopy {
    /// Which aspect the region names; colour for the buffer/image copies.
    pub aspect_mask: vk::ImageAspectFlags,
    pub buffer_offset: u64,
    pub buffer_row_length: u32,
    pub buffer_image_height: u32,
    pub base_array_layer: u32,
    pub layer_count: u32,
    pub image_offset: [i32; 3],
    pub image_extent: [u32; 3],
}

impl BufferImageCopy {
    fn to_vk(self) -> vk::BufferImageCopy {
        vk::BufferImageCopy {
            buffer_offset: self.buffer_offset,
            buffer_row_length: self.buffer_row_length,
            buffer_image_height: self.buffer_image_height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: self.aspect_mask,
                mip_level: 0,
                base_array_layer: self.base_array_layer,
                layer_count: self.layer_count,
            },
            image_offset: vk::Offset3D {
                x: self.image_offset[0],
                y: self.image_offset[1],
                z: self.image_offset[2],
            },
            image_extent: vk::Extent3D {
                width: self.image_extent[0],
                height: self.image_extent[1],
                depth: self.image_extent[2],
            },
        }
    }
}

/// `CopiesAndBlittingTestInstance::generateBuffer`
///
/// `float_byte_pattern` is the `signedAndUnsignedFloatFormats` test upstream makes on
/// the *test parameters* rather than on this buffer's format, so it is passed in.
pub fn generate_buffer(access: &mut PixelBufferAccess<'_>, width: u32, height: u32, depth: u32, mode: FillMode, float_byte_pattern: bool) {
    let format = access.format();
    let channel_class = format.channel_class();
    let mut max_value = [1.0f32; 4];

    if matches!(channel_class, TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger) {
        // The tcu::Vectors we use as pixels are 32-bit, so clamp to that.
        let bits = get_texture_format_bit_depth(format);
        let sign_bit = i32::from(channel_class == TextureChannelClass::SignedInteger);
        for i in 0..4 {
            let b = bits[i].min(32);
            if b != 0 {
                max_value[i] = ((1u64 << (b - sign_bit)) - 1) as f32;
            }
        }
    }

    match mode {
        FillMode::Gradient => fill_with_component_gradients2(access, [0.0; 4], max_value),
        FillMode::Pyramid => fill_with_component_gradients3(access, [0.0; 4], max_value),
        FillMode::RandomGray => {
            let mut rng = tcu::Random::new(de_int32_hash(format.type_ as i32));
            let pixel_size = access.format().pixel_size().expect("checked in TextureLevel::new") as usize;
            for z in 0..depth {
                for y in 0..height {
                    for x in 0..width {
                        if float_byte_pattern {
                            // A free-running byte pattern can land on a bit pattern that
                            // reads back as NaN in a float format, so upstream picks from
                            // two known-good bytes instead.
                            const VALID_BYTES: [u8; 2] = [0b1000_1000, 0b1010_1010];
                            let selected = (rng.get_uint32() % (2 * VALID_BYTES.len() as u32)) as usize;
                            let mut color = VALID_BYTES[selected % VALID_BYTES.len()];
                            let alpha = VALID_BYTES[selected / VALID_BYTES.len()];
                            color >>= rng.get_uint32() % 7;
                            access.fill_pixel_bytes(x, y, z, color, alpha, pixel_size);
                        } else {
                            let v = rng.get_float();
                            access.set_pixel([v, v, v, max_value[3]], x, y, z);
                        }
                    }
                }
            }
        }
        FillMode::White | FillMode::Red | FillMode::BlueRedX | FillMode::BlueRedY | FillMode::BlueRedZ => {
            let red_color = [max_value[0], 0.0, 0.0, max_value[3]];
            let blue_color = [0.0, 0.0, max_value[2], max_value[3]];
            let combined = is_combined_depth_stencil_type(format.type_);
            let has_stencil = has_stencil_component(format.order);
            for z in 0..depth {
                for y in 0..height {
                    for x in 0..width {
                        let color = match mode {
                            FillMode::White => max_value,
                            FillMode::Red => red_color,
                            // Every other texel along one axis, which is what makes the
                            // stripes cases sensitive to a filter sampling the wrong one.
                            FillMode::BlueRedX => {
                                if x & 1 != 0 {
                                    blue_color
                                } else {
                                    red_color
                                }
                            }
                            FillMode::BlueRedY => {
                                if y & 1 != 0 {
                                    blue_color
                                } else {
                                    red_color
                                }
                            }
                            _ => {
                                if z & 1 != 0 {
                                    blue_color
                                } else {
                                    red_color
                                }
                            }
                        };
                        if combined {
                            access.set_pix_depth(color[0], x, y, z);
                            if has_stencil {
                                access.set_pix_stencil(color[3] as u32, x, y, z);
                            }
                        } else {
                            access.set_pixel(color, x, y, z);
                        }
                    }
                }
            }
        }
    }
}

/// `CopyBufferToImage::copyRegionToTextureLevel`
fn copy_region_to_texture_level(src: &ConstPixelBufferAccess<'_>, dst: &mut PixelBufferAccess<'_>, region: BufferImageCopy, texel_size: usize) {
    let row_length = if region.buffer_row_length == 0 {
        region.image_extent[0]
    } else {
        region.buffer_row_length
    };
    let image_height = if region.buffer_image_height == 0 {
        region.image_extent[1]
    } else {
        region.buffer_image_height
    };

    let texel_offset = (region.buffer_offset / texel_size as u64) as u32;

    for z in 0..region.image_extent[2] {
        for y in 0..region.image_extent[1] {
            let texel_index = texel_offset + (z * image_height + y) * row_length;
            let dst_z = (region.image_offset[2] as u32) + z + region.base_array_layer;
            let dst_y = (region.image_offset[1] as u32) + y;
            let dst_x = region.image_offset[0] as u32;
            dst.copy_texels_from(src, texel_index as usize, (dst_x, dst_y, dst_z), region.image_extent[0] as usize);
        }
    }
}

/// `m_queueFamilyIndices` as a buffer create info: upstream switches the staging
/// buffers to CONCURRENT sharing whenever a second queue family is in play. Sharing
/// mode is not verdict-visible on a correct driver, but it can change which internal
/// path a driver takes, so it is worth matching rather than always using EXCLUSIVE.
fn staging_buffer_create_info(size: u64, usage: vk::BufferUsageFlags, families: &[u32]) -> vk::BufferCreateInfo {
    let mut info = make_buffer_create_info(size, usage);
    if families.len() > 1 {
        info.sharing_mode = vk::SharingMode::CONCURRENT;
        info.queue_family_index_count = families.len() as u32;
        info.queue_family_indices = families.as_ptr();
    }
    info
}

/// The aspects a format has to be staged through, with the tightly-packed format each
/// one travels in.
///
/// A copy region names exactly one aspect, so a combined depth/stencil image needs one
/// buffer-to-image copy per aspect, each in that aspect's own copy format rather than
/// the combined texel layout.
fn staging_aspects(format: vk::Format) -> Vec<(vk::ImageAspectFlags, tcu::TextureFormat)> {
    let Some(tcu_format) = map_vk_format(format) else { return Vec::new() };
    if !is_combined_depth_stencil_type(tcu_format.type_) {
        return vec![(get_aspect_flags(format), tcu_format)];
    }
    let mut out = Vec::new();
    if let Some(f) = get_depth_copy_format(format) {
        out.push((vk::ImageAspectFlags::DEPTH, f));
    }
    if let Some(f) = get_stencil_copy_format(format) {
        out.push((vk::ImageAspectFlags::STENCIL, f));
    }
    out
}

/// Splits a combined depth/stencil level into a single-aspect one, or merges it back.
fn transfer_aspect(combined: &mut TextureLevel, aspect: vk::ImageAspectFlags, single: &mut TextureLevel, into_single: bool) {
    let [w, h, d] = combined.size();
    for z in 0..d {
        for y in 0..h {
            for x in 0..w {
                if aspect == vk::ImageAspectFlags::DEPTH {
                    if into_single {
                        let v = combined.get_const_access().get_pix_depth(x, y, z);
                        single.get_access().set_pix_depth(v, x, y, z);
                    } else {
                        let v = single.get_const_access().get_pix_depth(x, y, z);
                        combined.get_access().set_pix_depth(v, x, y, z);
                    }
                } else if into_single {
                    let v = combined.get_const_access().get_pix_stencil(x, y, z);
                    single.get_access().set_pix_stencil(v, x, y, z);
                } else {
                    let v = single.get_const_access().get_pix_stencil(x, y, z);
                    combined.get_access().set_pix_stencil(v, x, y, z);
                }
            }
        }
    }
}

/// `CopiesAndBlittingTestInstance::uploadImage`, one mip level.
#[allow(clippy::too_many_arguments)]
pub fn upload_image(
    context: &Context<'_>,
    src: &ConstPixelBufferAccess<'_>,
    image: vk::Image,
    parms: &ImageParms,
    general_layout: bool,
    families: &[u32],
    separate_depth_stencil_layouts: bool,
) -> Result<(), TestError> {
    upload_image_mip_levels(context, src, image, parms, general_layout, families, separate_depth_stencil_layouts, 1)
}

/// `uploadImage` filling `mip_levels` levels from the same source data.
///
/// Every level reads the staging buffer from offset zero, so a level is the top-left
/// corner of the source rather than a downscale of it - which is what upstream does,
/// and what the mipmap tests expect as a starting state.
#[allow(clippy::too_many_arguments)]
pub fn upload_image_mip_levels(
    context: &Context<'_>,
    src: &ConstPixelBufferAccess<'_>,
    image: vk::Image,
    parms: &ImageParms,
    general_layout: bool,
    families: &[u32],
    separate_depth_stencil_layouts: bool,
    mip_levels: u32,
) -> Result<(), TestError> {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let layout = if general_layout {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_DST_OPTIMAL
    };
    let extent = parms.extent_3d();
    let full_aspect = get_aspect_flags(parms.format);
    let range = make_image_subresource_range(full_aspect, 0, mip_levels, 0, parms.array_size());

    // One staging buffer per aspect, each holding that aspect's own texel layout.
    let mut staged: Vec<(vk::ImageAspectFlags, BufferWithMemory)> = Vec::new();
    let mut combined = TextureLevel::new(src.format(), src.size()[0], src.size()[1], src.size()[2])?;
    combined.data_mut().copy_from_slice(src.raw());

    for (aspect, aspect_format) in staging_aspects(parms.format) {
        let bytes = if aspect_format == src.format() {
            src.raw().to_vec()
        } else {
            let [w, h, d] = src.size();
            let mut level = TextureLevel::new(aspect_format, w, h, d)?;
            transfer_aspect(&mut combined, aspect, &mut level, true);
            level.data().to_vec()
        };
        let staging = BufferWithMemory::new(
            vk_device,
            context.get_default_allocator(),
            staging_buffer_create_info(bytes.len() as u64, vk::BufferUsageFlags::TRANSFER_SRC, families),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), staging.get_allocation().get_host_ptr(), bytes.len()) };
        flush_alloc(vk_device, staging.get_allocation())?;
        staged.push((aspect, staging));
    }

    let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(vk_device, *cmd_buffer)?;
    unsafe {
        // `formatAspect`. With SEPARATE_DEPTH_STENCIL_LAYOUT each aspect is transitioned
        // on its own, before its own copy; without it one barrier covers both and the
        // second copy needs none (upstream's `skipPreImageBarrier`).
        if !separate_depth_stencil_layouts {
            let pre = make_image_memory_barrier(vk::AccessFlags::empty(), vk::AccessFlags::TRANSFER_WRITE, vk::ImageLayout::UNDEFINED, layout, image, range);
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre],
            );
        }

        for (aspect, staging) in &staged {
            if separate_depth_stencil_layouts {
                let aspect_range = make_image_subresource_range(*aspect, 0, mip_levels, 0, parms.array_size());
                let pre = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    layout,
                    image,
                    aspect_range,
                );
                vk_device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre],
                );
            }
            let regions: Vec<vk::BufferImageCopy> = (0..mip_levels)
                .map(|level| {
                    let copy_extent = vk::Extent3D {
                        width: extent.width >> level,
                        height: extent.height >> level,
                        depth: extent.depth,
                    };
                    vk::BufferImageCopy {
                        buffer_offset: 0,
                        buffer_row_length: copy_extent.width,
                        buffer_image_height: copy_extent.height,
                        image_subresource: vk::ImageSubresourceLayers {
                            aspect_mask: *aspect,
                            mip_level: level,
                            base_array_layer: 0,
                            layer_count: parms.array_size(),
                        },
                        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        image_extent: copy_extent,
                    }
                })
                .collect();
            vk_device.cmd_copy_buffer_to_image(*cmd_buffer, staging.get(), image, layout, &regions);
        }

        let post = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_WRITE, layout, layout, image, range);
        vk_device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post],
        );
    }
    end_command_buffer(vk_device, *cmd_buffer)?;
    submit_commands_and_wait(vk_device, queue, *cmd_buffer)
}

/// `CopiesAndBlittingTestInstance::readImage`, colour aspect and one mip level.
pub fn read_image(context: &Context<'_>, image: vk::Image, parms: &ImageParms, dst: &mut TextureLevel, general_layout: bool, families: &[u32]) -> Result<(), TestError> {
    read_image_mip_level(context, image, parms, dst, general_layout, families, 0)
}

/// `CopiesAndBlittingTestInstance::readImage` at a chosen mip level.
#[allow(clippy::too_many_arguments)]
pub fn read_image_mip_level(
    context: &Context<'_>,
    image: vk::Image,
    parms: &ImageParms,
    dst: &mut TextureLevel,
    general_layout: bool,
    families: &[u32],
    mip_level: u32,
) -> Result<(), TestError> {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let src_layout = if general_layout {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
    };
    let old_layout = if general_layout {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_DST_OPTIMAL
    };
    let extent = parms.extent_3d_at(mip_level);
    let full_aspect = get_aspect_flags(parms.format);
    let range = make_image_subresource_range(full_aspect, mip_level, 1, 0, parms.array_size());
    let [w, h, d] = dst.size();

    let aspects = staging_aspects(parms.format);
    let mut staged: Vec<(vk::ImageAspectFlags, tcu::TextureFormat, BufferWithMemory)> = Vec::new();
    for (aspect, aspect_format) in &aspects {
        let pixel_size = aspect_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))? as u64;
        let bytes = u64::from(w) * u64::from(h) * u64::from(d) * pixel_size;
        let staging = BufferWithMemory::new(
            vk_device,
            context.get_default_allocator(),
            staging_buffer_create_info(bytes, vk::BufferUsageFlags::TRANSFER_DST, families),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        staged.push((*aspect, *aspect_format, staging));
    }

    let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(vk_device, *cmd_buffer)?;
    unsafe {
        let pre = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ, old_layout, src_layout, image, range);
        vk_device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre],
        );

        for (aspect, _, staging) in &staged {
            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: extent.width,
                buffer_image_height: extent.height,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: *aspect,
                    mip_level,
                    base_array_layer: 0,
                    layer_count: parms.array_size(),
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: extent,
            };
            vk_device.cmd_copy_image_to_buffer(*cmd_buffer, image, src_layout, staging.get(), &[region]);
        }
    }
    end_command_buffer(vk_device, *cmd_buffer)?;
    submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

    for (aspect, aspect_format, staging) in &staged {
        invalidate_alloc(vk_device, staging.get_allocation())?;
        if *aspect_format == dst.format() {
            let len = dst.data().len();
            unsafe { std::ptr::copy_nonoverlapping(staging.get_allocation().get_host_ptr().cast_const(), dst.data_mut().as_mut_ptr(), len) };
        } else {
            let mut level = TextureLevel::new(*aspect_format, w, h, d)?;
            let len = level.data().len();
            unsafe { std::ptr::copy_nonoverlapping(staging.get_allocation().get_host_ptr().cast_const(), level.data_mut().as_mut_ptr(), len) };
            transfer_aspect(dst, *aspect, &mut level, false);
        }
    }
    Ok(())
}

/// `CopiesAndBlittingTestInstance::checkTestResult` - the copy tests compare exactly,
/// so any difference at all is a failure.
fn check_test_result(expected: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>) -> TestStatus {
    if expected.raw() == result.raw() {
        return TestStatus::pass("CopiesAndBlitting test");
    }
    let at = expected.raw().iter().zip(result.raw()).position(|(a, b)| a != b).unwrap_or(0);
    TestStatus::fail(format!("CopiesAndBlitting test: first difference at byte {at}"))
}

/// `TestParams`, narrowed to what the buffer-to-image cases carry.
pub struct CopyBufferToImageCase {
    name: String,
    src_buffer_size: u32,
    src_fill_mode: FillMode,
    dst: ImageParms,
    regions: Vec<BufferImageCopy>,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
    /// Set when a region asks for `VK_REMAINING_ARRAY_LAYERS`, which only became legal
    /// for a copy subresource with VK_KHR_maintenance5.
    needs_maintenance5: bool,
    /// Set for the relaxed buffer offset on a transfer-only queue, where the loosened
    /// alignment rule comes from VK_KHR_maintenance11.
    needs_maintenance11: bool,
}

impl TestCase for CopyBufferToImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        if self.needs_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        if self.needs_maintenance11 {
            context.require_device_functionality("VK_KHR_maintenance11")?;
        }
        select_queue(context, self.queue_selection)?;

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.dst.format,
                self.dst.image_type,
                self.dst.tiling,
                usage,
                self.dst.create_flags(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format does not support the required parameters".to_string()))?;

        if properties.max_array_layers < self.dst.array_size() {
            return Err(TestError::NotSupported("maxArrayLayers too small".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyBufferToImageInstance { context, params: self })
    }
}

struct CopyBufferToImageInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CopyBufferToImageCase,
}

impl TestInstance for CopyBufferToImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        // `m_queueFamilyIndices` - the universal queue always, plus the copy's own queue
        // when it is a different family.
        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;
        let mut families = vec![self.context.get_universal_queue_family_index()];
        if queue_family_index != families[0] {
            families.push(queue_family_index);
        }

        let texture_format = map_vk_format(p.dst.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let texel_size = texture_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))? as usize;

        // Host-side source data, expected result, and the image's starting contents.
        let mut source_level = TextureLevel::new(texture_format, p.src_buffer_size, 1, 1)?;
        generate_buffer(&mut source_level.get_access(), p.src_buffer_size, 1, 1, p.src_fill_mode, false);

        let mut destination_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        generate_buffer(
            &mut destination_level.get_access(),
            p.dst.extent[0],
            p.dst.extent[1],
            p.dst.extent[2],
            p.dst.fill_mode,
            false,
        );

        // `generateExpectedResult` - start from the destination contents, then replay
        // each region on the host.
        let mut expected_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        {
            let source_access = source_level.get_const_access();
            let mut expected_access = expected_level.get_access();
            for region in &p.regions {
                copy_region_to_texture_level(&source_access, &mut expected_access, *region, texel_size);
            }
        }

        // Source buffer.
        let buffer_size = u64::from(p.src_buffer_size) * texel_size as u64;
        let source_info = make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC);
        let source_buffer = unsafe { vk_device.create_buffer(&source_info, None) }.vk_check("vkCreateBuffer")?;
        let source_buffer = Unique::new(vk_device, source_buffer);
        let source_alloc = bind_buffer_memory(self.context, *source_buffer, p.allocation_kind)?;
        unsafe { std::ptr::copy_nonoverlapping(source_level.data().as_ptr(), source_alloc.get_host_ptr(), source_level.data().len()) };
        flush_alloc(vk_device, &source_alloc)?;

        // Destination image.
        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: p.dst.create_flags(),
            image_type: p.dst.image_type,
            format: p.dst.format,
            extent: p.dst.extent_3d(),
            mip_levels: 1,
            array_layers: p.dst.array_size(),
            samples: vk::SampleCountFlags::_1,
            tiling: p.dst.tiling,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let destination = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        };

        upload_image(
            self.context,
            &destination_level.get_const_access(),
            destination.get(),
            &p.dst,
            p.general_layout,
            &families,
            false,
        )?;

        // The copy under test.
        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.dst.array_size());

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let barrier = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_WRITE, layout, layout, destination.get(), range);
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );

            let copies: Vec<vk::BufferImageCopy> = p.regions.iter().map(|r| r.to_vk()).collect();
            if p.command_variant == CopyCommandVariant::CopyCommands2 {
                let copies2: Vec<vk::BufferImageCopy2> = copies
                    .iter()
                    .map(|c| vk::BufferImageCopy2 {
                        s_type: vk::StructureType::BUFFER_IMAGE_COPY_2,
                        next: std::ptr::null(),
                        buffer_offset: c.buffer_offset,
                        buffer_row_length: c.buffer_row_length,
                        buffer_image_height: c.buffer_image_height,
                        image_subresource: c.image_subresource,
                        image_offset: c.image_offset,
                        image_extent: c.image_extent,
                    })
                    .collect();
                let info = vk::CopyBufferToImageInfo2 {
                    s_type: vk::StructureType::COPY_BUFFER_TO_IMAGE_INFO_2,
                    next: std::ptr::null(),
                    src_buffer: *source_buffer,
                    dst_image: destination.get(),
                    dst_image_layout: layout,
                    region_count: copies2.len() as u32,
                    regions: copies2.as_ptr(),
                };
                vk_device.cmd_copy_buffer_to_image2(*cmd_buffer, &info);
            } else {
                vk_device.cmd_copy_buffer_to_image(*cmd_buffer, *source_buffer, destination.get(), layout, &copies);
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        let mut result_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        read_image(self.context, destination.get(), &p.dst, &mut result_level, p.general_layout, &families)?;

        Ok(check_test_result(&expected_level.get_const_access(), &result_level.get_const_access()))
    }
}

/// `restrictedFormatList` - deliberately short, so the matrix does not explode. The
/// 96-bit format appears twice because some implementations do not support it natively
/// with optimal tiling and take a different path for linear.
static RESTRICTED_FORMAT_LIST: &[(vk::Format, vk::ImageTiling, &str)] = &[
    (vk::Format::R8G8B8A8_UNORM, vk::ImageTiling::OPTIMAL, ""),
    (vk::Format::R8G8B8A8_UINT, vk::ImageTiling::OPTIMAL, "_rgba8_uint"),
    (vk::Format::R32G32B32_SFLOAT, vk::ImageTiling::OPTIMAL, "_rgb32_sfloat"),
    (vk::Format::R32G32B32_SFLOAT, vk::ImageTiling::LINEAR, "_rgb32_sfloat_linear"),
];

/// `VK_REMAINING_ARRAY_LAYERS`
const REMAINING_ARRAY_LAYERS: u32 = u32::MAX;

pub struct GroupParams {
    pub allocation_kind: AllocationKind,
    pub command_variant: CopyCommandVariant,
    pub queue_selection: QueueSelection,
    pub general_layout: bool,
}

/// `add1dBufferToImageTests`
fn add_1d_buffer_to_image_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let image_type = vk::ImageType::_1D;

    for &(format, tiling, suffix) in RESTRICTED_FORMAT_LIST {
        let Some(tcu_format) = map_vk_format(format) else { continue };
        let Some(pixel_size) = tcu_format.pixel_size() else { continue };

        let make =
            |name: String, src_buffer_size: u32, src_fill_mode: FillMode, dst_fill_mode: FillMode, extent: [u32; 3], regions: Vec<BufferImageCopy>, needs_maintenance5: bool| {
                Box::new(CopyBufferToImageCase {
                    name,
                    src_buffer_size,
                    src_fill_mode,
                    dst: ImageParms {
                        image_type,
                        format,
                        extent,
                        tiling,
                        fill_mode: dst_fill_mode,
                        create_flags: None,
                    },
                    regions,
                    allocation_kind: gp.allocation_kind,
                    command_variant: gp.command_variant,
                    queue_selection: gp.queue_selection,
                    general_layout: gp.general_layout,
                    needs_maintenance5,
                    needs_maintenance11: false,
                }) as Box<dyn TestCase>
            };

        let whole_1d = |buffer_image_height: u32, buffer_offset: u64, base_array_layer: u32, layer_count: u32| BufferImageCopy {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            buffer_offset,
            buffer_row_length: 0,
            buffer_image_height,
            base_array_layer,
            layer_count,
            image_offset: [0, 0, 0],
            image_extent: DEFAULT_1D_EXTENT,
        };

        group.add_child(make(
            format!("tightly_sized_buffer{suffix}"),
            DEFAULT_SIZE,
            FillMode::Gradient,
            FillMode::Gradient,
            DEFAULT_1D_EXTENT,
            vec![whole_1d(0, 0, 0, 1)],
            false,
        ));

        group.add_child(make(
            format!("larger_buffer{suffix}"),
            DEFAULT_SIZE + 1,
            FillMode::Gradient,
            FillMode::Gradient,
            DEFAULT_1D_EXTENT,
            vec![whole_1d(DEFAULT_SIZE + 1, 0, 0, 1)],
            false,
        ));

        {
            let array_layers = 16u32;
            let regions = (0..array_layers).map(|n| whole_1d(0, u64::from(DEFAULT_SIZE * pixel_size * n), n, 1)).collect();
            group.add_child(make(
                format!("array_tightly_sized_buffer{suffix}"),
                DEFAULT_SIZE * array_layers,
                FillMode::Gradient,
                FillMode::Gradient,
                [DEFAULT_SIZE, 1, array_layers],
                regions,
                false,
            ));
        }

        // Both sides are filled red, so the reference stays correct however many layers
        // the driver writes - which is what lets upstream keep the host-side replay of
        // a VK_REMAINING_ARRAY_LAYERS region down to a single layer.
        for (name, base_layer) in [("array_all_remaining_layers", 0u32), ("array_not_all_remaining_layers", 2)] {
            group.add_child(make(
                format!("{name}{suffix}"),
                DEFAULT_SIZE * 16,
                FillMode::Red,
                FillMode::Red,
                [DEFAULT_SIZE, 1, 16],
                vec![whole_1d(0, 0, base_layer, REMAINING_ARRAY_LAYERS)],
                true,
            ));
        }

        {
            let array_layers = 16u32;
            let regions = (0..array_layers)
                .map(|n| whole_1d(DEFAULT_SIZE + 1, u64::from(DEFAULT_SIZE * pixel_size * n), n, 1))
                .collect();
            group.add_child(make(
                format!("array_larger_buffer{suffix}"),
                DEFAULT_SIZE * array_layers,
                FillMode::Gradient,
                FillMode::Gradient,
                [DEFAULT_SIZE, 1, array_layers],
                regions,
                false,
            ));
        }
    }
}

/// `add2dBufferToImageTests`'s format list. Longer than the 1D one: R8_UNORM covers
/// the single-byte texel path and R64_UINT the 64-bit one.
static RESTRICTED_FORMAT_LIST_2D: &[(vk::Format, vk::ImageTiling, &str)] = &[
    (vk::Format::R8G8B8A8_UNORM, vk::ImageTiling::OPTIMAL, ""),
    (vk::Format::R8_UNORM, vk::ImageTiling::OPTIMAL, "_r8_unorm"),
    (vk::Format::R8_UNORM, vk::ImageTiling::LINEAR, "_r8_unorm_linear"),
    (vk::Format::R8G8B8A8_UINT, vk::ImageTiling::OPTIMAL, "_rgba8_uint"),
    (vk::Format::R32G32B32_SFLOAT, vk::ImageTiling::OPTIMAL, "_rgb32_sfloat"),
    (vk::Format::R32G32B32_SFLOAT, vk::ImageTiling::LINEAR, "_rgb32_sfloat_linear"),
    (vk::Format::R64_UINT, vk::ImageTiling::OPTIMAL, "_r64_uint"),
];

/// `add2dBufferToImageTests`
fn add_2d_buffer_to_image_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let image_type = vk::ImageType::_2D;

    for &(format, tiling, suffix) in RESTRICTED_FORMAT_LIST_2D {
        let Some(tcu_format) = map_vk_format(format) else { continue };
        let Some(pixel_size) = tcu_format.pixel_size() else { continue };

        let make = |name: String, src_buffer_size: u32, fill: FillMode, extent: [u32; 3], regions: Vec<BufferImageCopy>, needs_maintenance5: bool, needs_maintenance11: bool| {
            Box::new(CopyBufferToImageCase {
                name,
                src_buffer_size,
                src_fill_mode: fill,
                dst: ImageParms {
                    image_type,
                    format,
                    extent,
                    tiling,
                    fill_mode: fill,
                    create_flags: None,
                },
                regions,
                allocation_kind: gp.allocation_kind,
                command_variant: gp.command_variant,
                queue_selection: gp.queue_selection,
                general_layout: gp.general_layout,
                needs_maintenance5,
                needs_maintenance11,
            }) as Box<dyn TestCase>
        };

        let region = |buffer_offset: u64, row_length: u32, image_height: u32, base_layer: u32, layer_count: u32, image_offset: [i32; 3], image_extent: [u32; 3]| BufferImageCopy {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            buffer_offset,
            buffer_row_length: row_length,
            buffer_image_height: image_height,
            base_array_layer: base_layer,
            layer_count,
            image_offset,
            image_extent,
        };

        group.add_child(make(
            format!("whole{suffix}"),
            DEFAULT_SIZE * DEFAULT_SIZE,
            FillMode::Gradient,
            DEFAULT_EXTENT,
            vec![region(0, 0, 0, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
            false,
            false,
        ));

        {
            let buffer_width = DEFAULT_SIZE + 1;
            let buffer_height = DEFAULT_SIZE + 1;
            group.add_child(make(
                format!("whole_unaligned{suffix}"),
                buffer_width * buffer_height,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                vec![region(0, buffer_width, buffer_height, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
                false,
                false,
            ));
        }

        {
            // Upstream's loop shrinks each region as it walks right; `divisor` is
            // post-incremented inside the step expression, so the body always sees the
            // value the condition was tested with.
            let mut regions = Vec::new();
            let mut divisor = 1u32;
            let mut offset = 0u32;
            while offset + DEFAULT_QUARTER_SIZE / divisor < DEFAULT_SIZE && DEFAULT_QUARTER_SIZE > divisor {
                let side = DEFAULT_QUARTER_SIZE / divisor;
                regions.push(region(0, 0, 0, 0, 1, [offset as i32, DEFAULT_HALF_SIZE as i32, 0], [side, side, 1]));
                offset += side;
                divisor += 1;
            }
            group.add_child(make(
                format!("regions{suffix}"),
                DEFAULT_SIZE * DEFAULT_SIZE,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                regions,
                false,
                false,
            ));
        }

        {
            let offset = u64::from(round_up(DEFAULT_QUARTER_SIZE, pixel_size));
            let row = DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE;
            group.add_child(make(
                format!("buffer_offset{suffix}"),
                DEFAULT_SIZE * DEFAULT_SIZE,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                vec![region(
                    offset,
                    row,
                    row,
                    0,
                    1,
                    [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                    DEFAULT_HALF_EXTENT,
                )],
                false,
                false,
            ));
        }

        // The relaxed-offset case is not registered for a compute queue upstream, which
        // is the whole of the 115-vs-108 difference between those groups.
        if gp.queue_selection != QueueSelection::ComputeOnly {
            let offset = u64::from(round_up(DEFAULT_QUARTER_SIZE + 1, pixel_size));
            let row = DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE;
            group.add_child(make(
                format!("buffer_offset_relaxed{suffix}"),
                DEFAULT_SIZE * DEFAULT_SIZE,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                vec![region(
                    offset,
                    row,
                    row,
                    0,
                    1,
                    [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                    DEFAULT_HALF_EXTENT,
                )],
                false,
                gp.queue_selection == QueueSelection::TransferOnly,
            ));
        }

        group.add_child(make(
            format!("tightly_sized_buffer{suffix}"),
            (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE,
            FillMode::Gradient,
            DEFAULT_EXTENT,
            vec![region(
                0,
                DEFAULT_SIZE,
                DEFAULT_SIZE,
                0,
                1,
                [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                DEFAULT_HALF_EXTENT,
            )],
            false,
            false,
        ));

        {
            let buffer_image_height = DEFAULT_SIZE + 1;
            group.add_child(make(
                format!("larger_buffer{suffix}"),
                DEFAULT_SIZE * buffer_image_height,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                vec![region(0, DEFAULT_SIZE, buffer_image_height, 0, 1, [0, 0, 0], DEFAULT_HALF_EXTENT)],
                false,
                false,
            ));
        }

        group.add_child(make(
            format!("tightly_sized_buffer_offset{suffix}"),
            (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE,
            FillMode::Gradient,
            DEFAULT_EXTENT,
            vec![region(
                u64::from(DEFAULT_QUARTER_SIZE * pixel_size),
                DEFAULT_SIZE,
                DEFAULT_SIZE,
                0,
                1,
                [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                DEFAULT_HALF_EXTENT,
            )],
            false,
            false,
        ));

        let array_layers = 16u32;
        let array_extent = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, array_layers];

        {
            let regions = (0..array_layers)
                .map(|n| {
                    region(
                        u64::from(DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * n),
                        0,
                        0,
                        n,
                        1,
                        [0, 0, 0],
                        DEFAULT_HALF_EXTENT,
                    )
                })
                .collect();
            group.add_child(make(
                format!("array{suffix}"),
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                FillMode::Gradient,
                array_extent,
                regions,
                false,
                false,
            ));
        }

        {
            let buffer_image_height = DEFAULT_HALF_SIZE + 1;
            let regions = (0..array_layers)
                .map(|n| {
                    region(
                        u64::from(DEFAULT_HALF_SIZE * buffer_image_height * pixel_size * n),
                        DEFAULT_HALF_SIZE,
                        buffer_image_height,
                        n,
                        1,
                        [0, 0, 0],
                        DEFAULT_HALF_EXTENT,
                    )
                })
                .collect();
            group.add_child(make(
                format!("array_larger_buffer{suffix}"),
                DEFAULT_HALF_SIZE * buffer_image_height * array_layers,
                FillMode::Gradient,
                array_extent,
                regions,
                false,
                false,
            ));
        }

        {
            let regions = (0..array_layers)
                .map(|n| {
                    region(
                        u64::from(DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * n),
                        DEFAULT_HALF_SIZE,
                        DEFAULT_HALF_SIZE,
                        n,
                        1,
                        [0, 0, 0],
                        DEFAULT_HALF_EXTENT,
                    )
                })
                .collect();
            group.add_child(make(
                format!("array_tightly_sized_buffer{suffix}"),
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                FillMode::Gradient,
                array_extent,
                regions,
                false,
                false,
            ));
        }

        for (name, base_layer) in [("array_all_remaining_layers", 0u32), ("array_not_all_remaining_layers", 2)] {
            group.add_child(make(
                format!("{name}{suffix}"),
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                FillMode::Red,
                array_extent,
                vec![region(0, 0, 0, base_layer, REMAINING_ARRAY_LAYERS, [0, 0, 0], DEFAULT_HALF_EXTENT)],
                true,
                false,
            ));
        }
    }
}

/// `addCopyBufferToImageTests`
fn add_copy_buffer_to_image_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let mut images_1d = tcu::TestCaseGroup::new("1d_images");
    add_1d_buffer_to_image_tests(&mut images_1d, gp);
    group.add_child(images_1d);
    let mut images_2d = tcu::TestCaseGroup::new("2d_images");
    add_2d_buffer_to_image_tests(&mut images_2d, gp);
    group.add_child(images_2d);
    // 3d_images is not ported yet.
}

/// The `buffer_to_image*` groups of `createCopiesAndBlittingTests`.
pub fn add_buffer_to_image_groups(
    parent: &mut tcu::TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
) {
    let mut group = tcu::TestCaseGroup::new(name);
    add_copy_buffer_to_image_tests(
        &mut group,
        &GroupParams {
            allocation_kind,
            command_variant,
            queue_selection,
            general_layout,
        },
    );
    parent.add_child(group);
}

// ---------------------------------------------------------------------------------
// CopyImageToBuffer - the same machinery with source and destination swapped.
// ---------------------------------------------------------------------------------

/// `CopyImageToBuffer::copyRegionToTextureLevel`
fn copy_region_to_buffer_level(src: &ConstPixelBufferAccess<'_>, dst: &mut PixelBufferAccess<'_>, region: BufferImageCopy, texel_size: usize) {
    let row_length = if region.buffer_row_length == 0 {
        region.image_extent[0]
    } else {
        region.buffer_row_length
    };
    let image_height = if region.buffer_image_height == 0 {
        region.image_extent[1]
    } else {
        region.buffer_image_height
    };

    let texel_offset = (region.buffer_offset / texel_size as u64) as u32;

    for z in 0..region.image_extent[2] {
        for y in 0..region.image_extent[1] {
            let texel_index = texel_offset + (z * image_height + y) * row_length;
            let src_z = (region.image_offset[2] as u32) + z + region.base_array_layer;
            let src_y = (region.image_offset[1] as u32) + y;
            let src_x = region.image_offset[0] as u32;
            dst.copy_texels_from_position(src, (src_x, src_y, src_z), texel_index as usize, region.image_extent[0] as usize);
        }
    }
}

/// `CopyImageToBufferTestCase`
pub struct CopyImageToBufferCase {
    name: String,
    src: ImageParms,
    dst_buffer_size: u32,
    dst_fill_mode: FillMode,
    regions: Vec<BufferImageCopy>,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
    needs_maintenance5: bool,
    needs_maintenance11: bool,
}

impl TestCase for CopyImageToBufferCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        if self.needs_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        if self.needs_maintenance11 {
            context.require_device_functionality("VK_KHR_maintenance11")?;
        }
        select_queue(context, self.queue_selection)?;

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.src.format,
                self.src.image_type,
                self.src.tiling,
                usage,
                self.src.create_flags(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format does not support the required parameters".to_string()))?;

        if properties.max_array_layers < self.src.array_size() {
            return Err(TestError::NotSupported("maxArrayLayers too small".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyImageToBufferInstance { context, params: self })
    }
}

struct CopyImageToBufferInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CopyImageToBufferCase,
}

impl TestInstance for CopyImageToBufferInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;
        let mut families = vec![self.context.get_universal_queue_family_index()];
        if queue_family_index != families[0] {
            families.push(queue_family_index);
        }

        let texture_format = map_vk_format(p.src.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let texel_size = texture_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))? as usize;

        let mut source_level = TextureLevel::new(texture_format, p.src.extent[0], p.src.extent[1], p.src.extent[2])?;
        generate_buffer(&mut source_level.get_access(), p.src.extent[0], p.src.extent[1], p.src.extent[2], p.src.fill_mode, false);

        let mut destination_level = TextureLevel::new(texture_format, p.dst_buffer_size, 1, 1)?;
        generate_buffer(&mut destination_level.get_access(), p.dst_buffer_size, 1, 1, p.dst_fill_mode, false);

        let mut expected_level = TextureLevel::new(texture_format, p.dst_buffer_size, 1, 1)?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        {
            let source_access = source_level.get_const_access();
            let mut expected_access = expected_level.get_access();
            for region in &p.regions {
                copy_region_to_buffer_level(&source_access, &mut expected_access, *region, texel_size);
            }
        }

        // Source image.
        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: p.src.create_flags(),
            image_type: p.src.image_type,
            format: p.src.format,
            extent: p.src.extent_3d(),
            mip_levels: 1,
            array_layers: p.src.array_size(),
            samples: vk::SampleCountFlags::_1,
            tiling: p.src.tiling,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let source = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        };

        // Destination buffer, pre-filled so a region the copy must not touch is checked.
        let buffer_bytes = u64::from(p.dst_buffer_size) * texel_size as u64;
        let dst_info = staging_buffer_create_info(buffer_bytes, vk::BufferUsageFlags::TRANSFER_DST, &families);
        let destination = unsafe { vk_device.create_buffer(&dst_info, None) }.vk_check("vkCreateBuffer")?;
        let destination = Unique::new(vk_device, destination);
        let destination_alloc = bind_buffer_memory(self.context, *destination, p.allocation_kind)?;
        unsafe { std::ptr::copy_nonoverlapping(destination_level.data().as_ptr(), destination_alloc.get_host_ptr(), destination_level.data().len()) };
        flush_alloc(vk_device, &destination_alloc)?;

        upload_image(self.context, &source_level.get_const_access(), source.get(), &p.src, p.general_layout, &families, false)?;

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        };
        let old_layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.src.array_size());

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let barrier = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ, old_layout, layout, source.get(), range);
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );

            let copies: Vec<vk::BufferImageCopy> = p.regions.iter().map(|r| r.to_vk()).collect();
            if p.command_variant == CopyCommandVariant::CopyCommands2 {
                let copies2: Vec<vk::BufferImageCopy2> = copies
                    .iter()
                    .map(|c| vk::BufferImageCopy2 {
                        s_type: vk::StructureType::BUFFER_IMAGE_COPY_2,
                        next: std::ptr::null(),
                        buffer_offset: c.buffer_offset,
                        buffer_row_length: c.buffer_row_length,
                        buffer_image_height: c.buffer_image_height,
                        image_subresource: c.image_subresource,
                        image_offset: c.image_offset,
                        image_extent: c.image_extent,
                    })
                    .collect();
                let info = vk::CopyImageToBufferInfo2 {
                    s_type: vk::StructureType::COPY_IMAGE_TO_BUFFER_INFO_2,
                    next: std::ptr::null(),
                    src_image: source.get(),
                    src_image_layout: layout,
                    dst_buffer: *destination,
                    region_count: copies2.len() as u32,
                    regions: copies2.as_ptr(),
                };
                vk_device.cmd_copy_image_to_buffer2(*cmd_buffer, &info);
            } else {
                vk_device.cmd_copy_image_to_buffer(*cmd_buffer, source.get(), layout, *destination, &copies);
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        invalidate_alloc(vk_device, &destination_alloc)?;
        // Copied out of the mapping in one go; scattered reads through host-visible
        // device memory cost an order of magnitude more.
        let result = unsafe { std::slice::from_raw_parts(destination_alloc.get_host_ptr().cast_const(), destination_level.data().len()) }.to_vec();
        let result_access = ConstPixelBufferAccess::new(texture_format, [p.dst_buffer_size, 1, 1], &result);

        Ok(check_test_result(&expected_level.get_const_access(), &result_access))
    }
}

/// `add2dImageToBufferTests`' format list, crossed with both tilings.
static IMAGE_TO_BUFFER_FORMATS_2D: &[vk::Format] = &[vk::Format::R8G8B8A8_UNORM, vk::Format::R8_UNORM, vk::Format::R32G32B32_UINT, vk::Format::R32G32B32_SFLOAT];

/// `getFormatCaseName` for the formats above - the enum name lowercased, minus the
/// VK_FORMAT_ prefix.
fn image_to_buffer_format_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R8_UNORM => "r8_unorm",
        vk::Format::R32G32B32_UINT => "r32g32b32_uint",
        vk::Format::R32G32B32_SFLOAT => "r32g32b32_sfloat",
        _ => "r8g8b8a8_unorm",
    }
}

/// `add1dImageToBufferTests`, minus the compressed mip_copies cases.
fn add_1d_image_to_buffer_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let format = vk::Format::R8G8B8A8_UNORM;
    let Some(tcu_format) = map_vk_format(format) else { return };
    let Some(pixel_size) = tcu_format.pixel_size() else { return };

    let make = |name: &str, extent: [u32; 3], fill: FillMode, dst_buffer_size: u32, regions: Vec<BufferImageCopy>, needs_maintenance5: bool| {
        Box::new(CopyImageToBufferCase {
            name: name.to_string(),
            src: ImageParms {
                image_type: vk::ImageType::_1D,
                format,
                extent,
                tiling: vk::ImageTiling::OPTIMAL,
                fill_mode: fill,
                create_flags: None,
            },
            dst_buffer_size,
            dst_fill_mode: fill,
            regions,
            allocation_kind: gp.allocation_kind,
            command_variant: gp.command_variant,
            queue_selection: gp.queue_selection,
            general_layout: gp.general_layout,
            needs_maintenance5,
            needs_maintenance11: false,
        }) as Box<dyn TestCase>
    };

    let region = |buffer_offset: u64, image_height: u32, base_layer: u32, layer_count: u32| BufferImageCopy {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        buffer_offset,
        buffer_row_length: 0,
        buffer_image_height: image_height,
        base_array_layer: base_layer,
        layer_count,
        image_offset: [0, 0, 0],
        image_extent: DEFAULT_1D_EXTENT,
    };

    group.add_child(make(
        "tightly_sized_buffer",
        DEFAULT_1D_EXTENT,
        FillMode::Gradient,
        DEFAULT_SIZE,
        vec![region(0, 0, 0, 1)],
        false,
    ));

    let larger = DEFAULT_SIZE + 1;
    group.add_child(make("larger_buffer", DEFAULT_1D_EXTENT, FillMode::Gradient, larger, vec![region(0, larger, 0, 1)], false));

    let array_layers = 16u32;
    let array_extent = [DEFAULT_SIZE, 1, array_layers];

    group.add_child(make(
        "array_tightly_sized_buffer",
        array_extent,
        FillMode::Gradient,
        DEFAULT_SIZE * array_layers,
        (0..array_layers).map(|n| region(u64::from(DEFAULT_SIZE * pixel_size * n), DEFAULT_SIZE, n, 1)).collect(),
        false,
    ));

    group.add_child(make(
        "array_larger_buffer",
        array_extent,
        FillMode::Gradient,
        larger * array_layers,
        (0..array_layers).map(|n| region(u64::from(larger * pixel_size * n), larger, n, 1)).collect(),
        false,
    ));

    for (name, base_layer) in [("array_all_remaining_layers", 0u32), ("array_not_all_remaining_layers", 2)] {
        group.add_child(make(
            name,
            array_extent,
            FillMode::Red,
            DEFAULT_SIZE * array_layers,
            vec![region(0, 0, base_layer, REMAINING_ARRAY_LAYERS)],
            true,
        ));
    }
}

/// `add2dImageToBufferTests`, minus the compressed mip_copies cases and `padding_bytes`
/// (which needs FILL_MODE_RANDOM_GRAY).
fn add_2d_image_to_buffer_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    for &format in IMAGE_TO_BUFFER_FORMATS_2D {
        for tiling in [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR] {
            let Some(tcu_format) = map_vk_format(format) else { continue };
            let Some(pixel_size) = tcu_format.pixel_size() else { continue };

            let suffix = format!(
                "{}{}",
                if format == vk::Format::R8G8B8A8_UNORM {
                    String::new()
                } else {
                    format!("_{}", image_to_buffer_format_name(format))
                },
                if tiling == vk::ImageTiling::LINEAR { "_linear" } else { "" }
            );

            let make =
                |name: String, extent: [u32; 3], fill: FillMode, dst_buffer_size: u32, regions: Vec<BufferImageCopy>, needs_maintenance5: bool, needs_maintenance11: bool| {
                    Box::new(CopyImageToBufferCase {
                        name,
                        src: ImageParms {
                            image_type: vk::ImageType::_2D,
                            format,
                            extent,
                            tiling,
                            fill_mode: fill,
                            create_flags: None,
                        },
                        dst_buffer_size,
                        dst_fill_mode: fill,
                        regions,
                        allocation_kind: gp.allocation_kind,
                        command_variant: gp.command_variant,
                        queue_selection: gp.queue_selection,
                        general_layout: gp.general_layout,
                        needs_maintenance5,
                        needs_maintenance11,
                    }) as Box<dyn TestCase>
                };

            let region =
                |buffer_offset: u64, row_length: u32, image_height: u32, base_layer: u32, layer_count: u32, image_offset: [i32; 3], image_extent: [u32; 3]| BufferImageCopy {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    buffer_offset,
                    buffer_row_length: row_length,
                    buffer_image_height: image_height,
                    base_array_layer: base_layer,
                    layer_count,
                    image_offset,
                    image_extent,
                };

            group.add_child(make(
                format!("whole{suffix}"),
                DEFAULT_EXTENT,
                FillMode::Gradient,
                DEFAULT_SIZE * DEFAULT_SIZE,
                vec![region(0, 0, 0, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
                false,
                false,
            ));

            {
                let bw = DEFAULT_SIZE + 1;
                let bh = DEFAULT_SIZE + 1;
                group.add_child(make(
                    format!("whole_unaligned{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    bw * bh,
                    vec![region(0, bw, bh, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
                    false,
                    false,
                ));
            }

            {
                let offset = u64::from(round_up(DEFAULT_SIZE * DEFAULT_HALF_SIZE, pixel_size));
                group.add_child(make(
                    format!("buffer_offset{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    DEFAULT_SIZE * DEFAULT_SIZE,
                    vec![region(
                        offset,
                        0,
                        0,
                        0,
                        1,
                        [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                        DEFAULT_HALF_EXTENT,
                    )],
                    false,
                    false,
                ));
            }

            if gp.queue_selection != QueueSelection::ComputeOnly {
                let offset = u64::from(round_up(DEFAULT_SIZE * DEFAULT_HALF_SIZE + 1, pixel_size));
                group.add_child(make(
                    format!("buffer_offset_relaxed{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    DEFAULT_SIZE * DEFAULT_SIZE,
                    vec![region(
                        offset,
                        0,
                        0,
                        0,
                        1,
                        [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                        DEFAULT_HALF_EXTENT,
                    )],
                    false,
                    gp.queue_selection == QueueSelection::TransferOnly,
                ));
            }

            {
                // The buffer offset walks forward in fixed steps while the copied width
                // shrinks; the divisor advances once per step, so the body sees 1, 2, 3...
                let buffer_size = u64::from(pixel_size) * u64::from(DEFAULT_SIZE * DEFAULT_SIZE);
                let offset_size = u64::from(pixel_size) * u64::from(DEFAULT_QUARTER_SIZE * DEFAULT_QUARTER_SIZE);
                let mut regions = Vec::new();
                let mut divisor = 1u32;
                let mut offset = 0u64;
                while offset < buffer_size - offset_size {
                    regions.push(region(
                        offset,
                        DEFAULT_QUARTER_SIZE,
                        DEFAULT_QUARTER_SIZE,
                        0,
                        1,
                        [0, 0, 0],
                        [DEFAULT_QUARTER_SIZE / divisor, DEFAULT_QUARTER_SIZE, 1],
                    ));
                    offset += offset_size;
                    divisor += 1;
                }
                group.add_child(make(
                    format!("regions{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    DEFAULT_SIZE * DEFAULT_SIZE,
                    regions,
                    false,
                    false,
                ));
            }

            group.add_child(make(
                format!("tightly_sized_buffer{suffix}"),
                DEFAULT_EXTENT,
                FillMode::Gradient,
                (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE,
                vec![region(
                    0,
                    DEFAULT_SIZE,
                    DEFAULT_SIZE,
                    0,
                    1,
                    [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                    DEFAULT_HALF_EXTENT,
                )],
                false,
                false,
            ));

            {
                let bh = DEFAULT_SIZE + 1;
                group.add_child(make(
                    format!("larger_buffer{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    bh * DEFAULT_SIZE,
                    vec![region(0, DEFAULT_SIZE, bh, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
                    false,
                    false,
                ));
            }

            {
                // Here the offset is a texel count as well as a byte offset: upstream adds
                // it to `dst.buffer.size`, which is measured in texels.
                let offset = round_up(DEFAULT_QUARTER_SIZE, pixel_size);
                group.add_child(make(
                    format!("tightly_sized_buffer_offset{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE + offset,
                    vec![region(
                        u64::from(offset),
                        DEFAULT_SIZE,
                        DEFAULT_SIZE,
                        0,
                        1,
                        [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                        DEFAULT_HALF_EXTENT,
                    )],
                    false,
                    false,
                ));
            }

            let array_layers = 16u32;
            let array_extent = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, array_layers];

            group.add_child(make(
                format!("array{suffix}"),
                array_extent,
                FillMode::Gradient,
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                (0..array_layers)
                    .map(|n| {
                        region(
                            u64::from(DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * n),
                            0,
                            0,
                            n,
                            1,
                            [0, 0, 0],
                            DEFAULT_HALF_EXTENT,
                        )
                    })
                    .collect(),
                false,
                false,
            ));

            {
                let bh = DEFAULT_HALF_SIZE + 1;
                group.add_child(make(
                    format!("array_larger_buffer{suffix}"),
                    array_extent,
                    FillMode::Gradient,
                    DEFAULT_HALF_SIZE * bh * array_layers,
                    (0..array_layers)
                        .map(|n| {
                            region(
                                u64::from(DEFAULT_HALF_SIZE * bh * pixel_size * n),
                                DEFAULT_HALF_SIZE,
                                bh,
                                n,
                                1,
                                [0, 0, 0],
                                DEFAULT_HALF_EXTENT,
                            )
                        })
                        .collect(),
                    false,
                    false,
                ));
            }

            group.add_child(make(
                format!("array_tightly_sized_buffer{suffix}"),
                array_extent,
                FillMode::Gradient,
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                (0..array_layers)
                    .map(|n| {
                        region(
                            u64::from(DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * n),
                            DEFAULT_HALF_SIZE,
                            DEFAULT_HALF_SIZE,
                            n,
                            1,
                            [0, 0, 0],
                            DEFAULT_HALF_EXTENT,
                        )
                    })
                    .collect(),
                false,
                false,
            ));

            for (name, base_layer) in [("array_all_remaining_layers", 0u32), ("array_not_all_remaining_layers", 2)] {
                group.add_child(make(
                    format!("{name}{suffix}"),
                    array_extent,
                    FillMode::Red,
                    DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                    vec![region(0, 0, 0, base_layer, REMAINING_ARRAY_LAYERS, [0, 0, 0], DEFAULT_HALF_EXTENT)],
                    true,
                    false,
                ));
            }

            // `padding_bytes` is not registered: it fills the destination with
            // FILL_MODE_RANDOM_GRAY, which is not ported yet.
        }
    }
}

/// The `image_to_buffer*` groups of `createCopiesAndBlittingTests`.
pub fn add_image_to_buffer_groups(
    parent: &mut tcu::TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
) {
    let gp = GroupParams {
        allocation_kind,
        command_variant,
        queue_selection,
        general_layout,
    };
    let mut group = tcu::TestCaseGroup::new(name);
    let mut images_1d = tcu::TestCaseGroup::new("1d_images");
    add_1d_image_to_buffer_tests(&mut images_1d, &gp);
    group.add_child(images_1d);
    let mut images_2d = tcu::TestCaseGroup::new("2d_images");
    add_2d_image_to_buffer_tests(&mut images_2d, &gp);
    group.add_child(images_2d);
    // 3d_images is entirely compressed mip_copies upstream, so nothing is registered.
    parent.add_child(group);
}

// ---------------------------------------------------------------------------------
// CopyImageToImage
// ---------------------------------------------------------------------------------

/// `CopyRegion::imageCopy`
#[derive(Clone, Copy)]
pub struct ImageCopy {
    pub src_offset: [i32; 3],
    pub dst_offset: [i32; 3],
    pub extent: [u32; 3],
    pub aspect_mask: vk::ImageAspectFlags,
    pub src_base_layer: u32,
    pub src_layer_count: u32,
    pub dst_base_layer: u32,
    pub dst_layer_count: u32,
}

impl ImageCopy {
    /// The offsets and extent as `copyRegionToTextureLevel` adjusts them.
    ///
    /// A 2D array layer and a 3D slice are the same axis in the host reference, so when
    /// one side addresses a layer through the subresource and the other through the z
    /// offset, upstream aligns them by copying the addressed side's z onto the other.
    fn adjusted(self) -> ([i32; 3], [i32; 3], [u32; 3]) {
        let (mut src_offset, mut dst_offset, mut extent) = (self.src_offset, self.dst_offset, self.extent);
        if self.dst_base_layer > self.src_base_layer {
            dst_offset[2] = src_offset[2];
            extent[2] = extent[2].max(self.src_layer_count);
        }
        if self.dst_base_layer < self.src_base_layer {
            src_offset[2] = dst_offset[2];
            extent[2] = extent[2].max(self.src_layer_count);
        }
        (src_offset, dst_offset, extent)
    }

    fn to_vk(self) -> vk::ImageCopy {
        let layers = vk::ImageSubresourceLayers {
            aspect_mask: self.aspect_mask,
            mip_level: 0,
            base_array_layer: self.src_base_layer,
            layer_count: self.src_layer_count,
        };
        vk::ImageCopy {
            src_subresource: layers,
            src_offset: vk::Offset3D {
                x: self.src_offset[0],
                y: self.src_offset[1],
                z: self.src_offset[2],
            },
            dst_subresource: vk::ImageSubresourceLayers {
                aspect_mask: self.aspect_mask,
                mip_level: 0,
                base_array_layer: self.dst_base_layer,
                layer_count: self.dst_layer_count,
            },
            dst_offset: vk::Offset3D {
                x: self.dst_offset[0],
                y: self.dst_offset[1],
                z: self.dst_offset[2],
            },
            extent: vk::Extent3D {
                width: self.extent[0],
                height: self.extent[1],
                depth: self.extent[2],
            },
        }
    }
}

/// `CopyImageToImageTestCase`
pub struct CopyImageToImageCase {
    name: String,
    src: ImageParms,
    dst: ImageParms,
    regions: Vec<ImageCopy>,
    /// `TestParams::clearDestinationWithRed` - the destination is cleared to opaque red
    /// on the device and filled red on the host, so a copy that writes outside its
    /// region is caught against a known background rather than a gradient.
    clear_destination_with_red: bool,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
    needs_maintenance5: bool,
    /// Copying a 3D image into a 2D one needs VK_KHR_maintenance1.
    needs_maintenance1: bool,
    /// The `_separate_layouts` variants transition the two aspects independently.
    needs_separate_depth_stencil_layouts: bool,
    /// `ImageParms::operationLayout` per side. The all_formats and dimensions groups
    /// vary these independently, which is the whole of their `<src>_<dst>` name suffix;
    /// `None` means the default for that side, or GENERAL when the group asks for it.
    src_operation_layout: Option<vk::ImageLayout>,
    dst_operation_layout: Option<vk::ImageLayout>,
}

impl TestCase for CopyImageToImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        if self.needs_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        if self.needs_maintenance1 {
            context.require_device_functionality("VK_KHR_maintenance1")?;
        }
        if self.needs_separate_depth_stencil_layouts {
            context.require_device_functionality("VK_KHR_separate_depth_stencil_layouts")?;
        }
        select_queue(context, self.queue_selection)?;

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        for parms in [&self.src, &self.dst] {
            let props = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    parms.format,
                    parms.image_type,
                    parms.tiling,
                    usage,
                    parms.create_flags(),
                )
            }
            .map_err(|_| TestError::NotSupported("Format does not support the required parameters".to_string()))?;

            if props.max_array_layers < parms.array_size() {
                return Err(TestError::NotSupported("maxArrayLayers too small".to_string()));
            }
        }

        // The dimensions group asks for images up to 32768 wide, which most
        // implementations cannot create. Checked against the device limits, the way
        // upstream does, rather than left for image creation to fail on.
        let limits = context.get_device_properties().limits;
        for (parms, side) in [(&self.src, "src"), (&self.dst, "dst")] {
            let too_big = match parms.image_type {
                vk::ImageType::_1D => parms.extent[0] > limits.max_image_dimension_1d,
                vk::ImageType::_2D => parms.extent[0] > limits.max_image_dimension_2d || parms.extent[1] > limits.max_image_dimension_2d,
                _ => parms.extent.iter().any(|&d| d > limits.max_image_dimension_3d),
            };
            if too_big {
                let kind = match parms.image_type {
                    vk::ImageType::_1D => "1D",
                    vk::ImageType::_2D => "2D",
                    _ => "3D",
                };
                return Err(TestError::NotSupported(format!("Requested {kind} {side} image dimensions not supported")));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyImageToImageInstance { context, params: self })
    }
}

struct CopyImageToImageInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CopyImageToImageCase,
}

impl CopyImageToImageInstance<'_> {
    fn make_image(&self, parms: &ImageParms) -> Result<ImageWithMemory<'_>, TestError> {
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: parms.create_flags(),
            image_type: parms.image_type,
            format: parms.format,
            extent: parms.extent_3d(),
            mip_levels: 1,
            array_layers: parms.array_size(),
            samples: vk::SampleCountFlags::_1,
            tiling: parms.tiling,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        if self.params.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(vk_device, allocator, info, MemoryRequirement::ANY)
        } else {
            ImageWithMemory::new(vk_device, allocator, info, MemoryRequirement::ANY)
        }
    }
}

impl TestInstance for CopyImageToImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();

        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;
        let mut families = vec![self.context.get_universal_queue_family_index()];
        if queue_family_index != families[0] {
            families.push(queue_family_index);
        }

        let src_format = map_vk_format(p.src.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let dst_format = map_vk_format(p.dst.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;

        // `de::contains(signedAndUnsignedFloatFormats, ...)` over both sides.
        let float_byte_pattern = SIGNED_AND_UNSIGNED_FLOAT_FORMATS.contains(&p.src.format) || SIGNED_AND_UNSIGNED_FLOAT_FORMATS.contains(&p.dst.format);

        let mut source_level = TextureLevel::new(src_format, p.src.extent[0], p.src.extent[1], p.src.extent[2])?;
        generate_buffer(
            &mut source_level.get_access(),
            p.src.extent[0],
            p.src.extent[1],
            p.src.extent[2],
            p.src.fill_mode,
            float_byte_pattern,
        );

        let dst_fill = if p.clear_destination_with_red { FillMode::Red } else { p.dst.fill_mode };
        let mut destination_level = TextureLevel::new(dst_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        generate_buffer(
            &mut destination_level.get_access(),
            p.dst.extent[0],
            p.dst.extent[1],
            p.dst.extent[2],
            dst_fill,
            float_byte_pattern,
        );

        // `generateExpectedResult`. The copy is a memcpy even across formats, so the
        // expected level is viewed in the *source* format while the region lands.
        let mut expected_level = TextureLevel::new(src_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        {
            let source_access = source_level.get_const_access();
            let mut expected_access = expected_level.get_access();
            for r in &p.regions {
                let (src_offset, dst_offset, extent) = r.adjusted();
                expected_access.copy_region_from(
                    &source_access,
                    (src_offset[0] as u32, src_offset[1] as u32, src_offset[2] as u32),
                    (dst_offset[0] as u32, dst_offset[1] as u32, dst_offset[2] as u32),
                    (extent[0], extent[1], extent[2]),
                );
            }
        }

        let source = self.make_image(&p.src)?;
        let destination = self.make_image(&p.dst)?;

        upload_image(self.context, &source_level.get_const_access(), source.get(), &p.src, p.general_layout, &families, false)?;
        upload_image(
            self.context,
            &destination_level.get_const_access(),
            destination.get(),
            &p.dst,
            p.general_layout,
            &families,
            false,
        )?;

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let src_layout = p.src_operation_layout.unwrap_or(if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        });
        let dst_layout = p.dst_operation_layout.unwrap_or(if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        });
        let uploaded = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let src_range = make_image_subresource_range(get_aspect_flags(p.src.format), 0, 1, 0, p.src.array_size());
        let dst_range = make_image_subresource_range(get_aspect_flags(p.dst.format), 0, 1, 0, p.dst.array_size());

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    uploaded,
                    src_layout,
                    source.get(),
                    src_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_WRITE,
                    uploaded,
                    dst_layout,
                    destination.get(),
                    dst_range,
                ),
            ];
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &barriers,
            );

            if p.clear_destination_with_red {
                let clear = vk::ClearColorValue { float32: [1.0, 0.0, 0.0, 1.0] };
                let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
                vk_device.cmd_clear_color_image(*cmd_buffer, destination.get(), dst_layout, &clear, &[range]);

                let after_clear = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_WRITE,
                    dst_layout,
                    dst_layout,
                    destination.get(),
                    dst_range,
                );
                vk_device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[after_clear],
                );
            }

            let copies: Vec<vk::ImageCopy> = p.regions.iter().map(|r| r.to_vk()).collect();
            if p.command_variant == CopyCommandVariant::CopyCommands2 {
                let copies2: Vec<vk::ImageCopy2> = copies
                    .iter()
                    .map(|c| vk::ImageCopy2 {
                        s_type: vk::StructureType::IMAGE_COPY_2,
                        next: std::ptr::null(),
                        src_subresource: c.src_subresource,
                        src_offset: c.src_offset,
                        dst_subresource: c.dst_subresource,
                        dst_offset: c.dst_offset,
                        extent: c.extent,
                    })
                    .collect();
                let info = vk::CopyImageInfo2 {
                    s_type: vk::StructureType::COPY_IMAGE_INFO_2,
                    next: std::ptr::null(),
                    src_image: source.get(),
                    src_image_layout: src_layout,
                    dst_image: destination.get(),
                    dst_image_layout: dst_layout,
                    region_count: copies2.len() as u32,
                    regions: copies2.as_ptr(),
                };
                vk_device.cmd_copy_image2(*cmd_buffer, &info);
            } else {
                vk_device.cmd_copy_image(*cmd_buffer, source.get(), src_layout, destination.get(), dst_layout, &copies);
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        // Read back in the destination's own format, then compare the raw bytes -
        // upstream's bitwiseCompare, which is what makes a cross-format copy checkable.
        let mut result_level = TextureLevel::new(dst_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        read_image(self.context, destination.get(), &p.dst, &mut result_level, p.general_layout, &families)?;

        Ok(check_test_result(&expected_level.get_const_access(), &result_level.get_const_access()))
    }
}

/// `addImageToImageSimpleTests`
fn add_image_to_image_simple_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let parms = |format: vk::Format, extent: [u32; 3], tiling: vk::ImageTiling, fill: FillMode| ImageParms {
        image_type: vk::ImageType::_2D,
        format,
        extent,
        tiling,
        fill_mode: fill,
        create_flags: None,
    };
    let make = |name: String, src: ImageParms, dst: ImageParms, regions: Vec<ImageCopy>, clear: bool| {
        Box::new(CopyImageToImageCase {
            name,
            src,
            dst,
            regions,
            clear_destination_with_red: clear,
            needs_maintenance5: false,
            needs_maintenance1: false,
            needs_separate_depth_stencil_layouts: false,
            src_operation_layout: None,
            dst_operation_layout: None,
            allocation_kind: gp.allocation_kind,
            command_variant: gp.command_variant,
            queue_selection: gp.queue_selection,
            general_layout: gp.general_layout,
        }) as Box<dyn TestCase>
    };
    let color = |src_offset: [i32; 3], dst_offset: [i32; 3], extent: [u32; 3]| ImageCopy {
        src_offset,
        dst_offset,
        extent,
        aspect_mask: vk::ImageAspectFlags::COLOR,
        src_base_layer: 0,
        src_layer_count: 1,
        dst_base_layer: 0,
        dst_layer_count: 1,
    };

    // The destination defaults to FILL_MODE_WHITE and the source to FILL_MODE_GRADIENT
    // in TestParams' constructor, which is where these two come from.
    const SRC_FILL: FillMode = FillMode::Gradient;
    const DST_FILL: FillMode = FillMode::White;

    let suffix = |format: vk::Format, tiling: vk::ImageTiling| {
        format!(
            "{}{}",
            if format == vk::Format::R8G8B8A8_UINT {
                String::new()
            } else {
                format!("_{}", image_to_buffer_format_name(format))
            },
            if tiling == vk::ImageTiling::LINEAR { "_linear" } else { "" }
        )
    };
    static SIMPLE_FORMATS: &[vk::Format] = &[vk::Format::R8G8B8A8_UINT, vk::Format::R32G32B32_UINT, vk::Format::R32G32B32_SFLOAT];

    for &format in SIMPLE_FORMATS {
        for tiling in [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR] {
            group.add_child(make(
                format!("whole_image{}", suffix(format, tiling)),
                parms(format, DEFAULT_EXTENT, tiling, SRC_FILL),
                parms(format, DEFAULT_EXTENT, tiling, DST_FILL),
                vec![color([0, 0, 0], [0, 0, 0], DEFAULT_EXTENT)],
                false,
            ));
        }
    }

    // A copy is a memcpy even across formats, so this pair only has to be size
    // compatible - 32 bits either way.
    group.add_child(make(
        "whole_image_diff_format".to_string(),
        parms(vk::Format::R8G8B8A8_UINT, DEFAULT_EXTENT, vk::ImageTiling::OPTIMAL, SRC_FILL),
        parms(vk::Format::R32_UINT, DEFAULT_EXTENT, vk::ImageTiling::OPTIMAL, DST_FILL),
        vec![color([0, 0, 0], [0, 0, 0], DEFAULT_EXTENT)],
        false,
    ));

    for &format in SIMPLE_FORMATS {
        for tiling in [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR] {
            group.add_child(make(
                format!("partial_image{}", suffix(format, tiling)),
                parms(format, DEFAULT_EXTENT, tiling, SRC_FILL),
                parms(format, DEFAULT_EXTENT, tiling, DST_FILL),
                vec![color(
                    [0, 0, 0],
                    [DEFAULT_QUARTER_SIZE as i32, (DEFAULT_QUARTER_SIZE / 2) as i32, 0],
                    [DEFAULT_QUARTER_SIZE / 2, DEFAULT_QUARTER_SIZE / 2, 1],
                )],
                false,
            ));
        }
    }

    // The pot/npot matrix is not registered for a transfer-only queue upstream.
    if gp.queue_selection != QueueSelection::TransferOnly {
        for (format_name, format1, format2) in [
            ("diff_format", vk::Format::R32_UINT, vk::Format::R8G8B8A8_UNORM),
            ("same_format", vk::Format::R8G8B8A8_UNORM, vk::Format::R8G8B8A8_UNORM),
        ] {
            for (clear_name, clear) in [("clear", true), ("noclear", false)] {
                for (extent_name, extent) in [("npot", [65u32, 63, 1]), ("pot", [64, 64, 1])] {
                    let region = if extent_name == "pot" {
                        color([16, 16, 0], [0, 0, 0], [32, 32, 1])
                    } else {
                        color([34, 34, 0], [0, 0, 0], [31, 29, 1])
                    };
                    group.add_child(make(
                        format!("partial_image_{extent_name}_{format_name}_{clear_name}"),
                        parms(format1, extent, vk::ImageTiling::OPTIMAL, SRC_FILL),
                        parms(format2, extent, vk::ImageTiling::OPTIMAL, DST_FILL),
                        vec![region],
                        clear,
                    ));
                }
            }
        }
    }

    for (name, format, aspect) in [
        ("depth", vk::Format::D32_SFLOAT, vk::ImageAspectFlags::DEPTH),
        ("stencil", vk::Format::S8_UINT, vk::ImageAspectFlags::STENCIL),
    ] {
        group.add_child(make(
            name.to_string(),
            parms(format, DEFAULT_EXTENT, vk::ImageTiling::OPTIMAL, SRC_FILL),
            parms(format, DEFAULT_EXTENT, vk::ImageTiling::OPTIMAL, DST_FILL),
            vec![ImageCopy {
                src_offset: [0, 0, 0],
                dst_offset: [DEFAULT_QUARTER_SIZE as i32, (DEFAULT_QUARTER_SIZE / 2) as i32, 0],
                extent: [DEFAULT_QUARTER_SIZE / 2, DEFAULT_QUARTER_SIZE / 2, 1],
                aspect_mask: aspect,
                src_base_layer: 0,
                src_layer_count: 1,
                dst_base_layer: 0,
                dst_layer_count: 1,
            }],
            false,
        ));
    }
}

/// `addImageToImage3dImagesTests`
fn add_image_to_image_3d_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    const SLICES_LAYERS: u32 = 16;
    let extent = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, SLICES_LAYERS];

    let parms = |image_type: vk::ImageType, fill: FillMode| ImageParms {
        image_type,
        format: vk::Format::R8G8B8A8_UINT,
        extent,
        tiling: vk::ImageTiling::OPTIMAL,
        fill_mode: fill,
        create_flags: None,
    };
    let make = |name: &str, src_type: vk::ImageType, dst_type: vk::ImageType, regions: Vec<ImageCopy>| {
        Box::new(CopyImageToImageCase {
            name: name.to_string(),
            src: parms(src_type, FillMode::Gradient),
            dst: parms(dst_type, FillMode::White),
            regions,
            clear_destination_with_red: false,
            needs_maintenance5: false,
            needs_maintenance1: false,
            needs_separate_depth_stencil_layouts: false,
            src_operation_layout: None,
            dst_operation_layout: None,
            allocation_kind: gp.allocation_kind,
            command_variant: gp.command_variant,
            queue_selection: gp.queue_selection,
            general_layout: gp.general_layout,
        }) as Box<dyn TestCase>
    };
    let copy = |src_offset: [i32; 3], dst_offset: [i32; 3], extent: [u32; 3], src_base: u32, src_count: u32, dst_base: u32, dst_count: u32| ImageCopy {
        src_offset,
        dst_offset,
        extent,
        aspect_mask: vk::ImageAspectFlags::COLOR,
        src_base_layer: src_base,
        src_layer_count: src_count,
        dst_base_layer: dst_base,
        dst_layer_count: dst_count,
    };
    let half = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, 1];

    group.add_child(make(
        "3d_to_2d_by_slices",
        vk::ImageType::_3D,
        vk::ImageType::_2D,
        (0..SLICES_LAYERS).map(|n| copy([0, 0, n as i32], [0, 0, 0], half, 0, 1, n, 1)).collect(),
    ));

    group.add_child(make(
        "2d_to_3d_by_layers",
        vk::ImageType::_2D,
        vk::ImageType::_3D,
        (0..SLICES_LAYERS).map(|n| copy([0, 0, 0], [0, 0, n as i32], half, n, 1, 0, 1)).collect(),
    ));

    group.add_child(make(
        "3d_to_2d_whole",
        vk::ImageType::_3D,
        vk::ImageType::_2D,
        vec![copy([0, 0, 0], [0, 0, 0], extent, 0, 1, 0, SLICES_LAYERS)],
    ));

    group.add_child(make(
        "2d_to_3d_whole",
        vk::ImageType::_2D,
        vk::ImageType::_3D,
        vec![copy([0, 0, 0], [0, 0, 0], extent, 0, SLICES_LAYERS, 0, 1)],
    ));

    // The regions shrink as the slice index grows, so each one starts further into the
    // source and covers less of it.
    let region_width = DEFAULT_HALF_SIZE / SLICES_LAYERS - 1;
    let region_height = DEFAULT_HALF_SIZE / SLICES_LAYERS - 1;

    group.add_child(make(
        "3d_to_2d_regions",
        vk::ImageType::_3D,
        vk::ImageType::_2D,
        (0..SLICES_LAYERS)
            .map(|n| {
                copy(
                    [0, (region_height * n) as i32, n as i32],
                    [(region_width * n) as i32, 0, 0],
                    [DEFAULT_HALF_SIZE - region_width * n, DEFAULT_HALF_SIZE - region_height * n, 1],
                    0,
                    1,
                    n,
                    1,
                )
            })
            .collect(),
    ));

    group.add_child(make(
        "2d_to_3d_regions",
        vk::ImageType::_2D,
        vk::ImageType::_3D,
        (0..SLICES_LAYERS)
            .map(|n| {
                copy(
                    [(region_width * n) as i32, 0, 0],
                    [0, (region_height * n) as i32, n as i32],
                    [DEFAULT_HALF_SIZE - region_width * n, DEFAULT_HALF_SIZE - region_height * n, 1],
                    n,
                    1,
                    0,
                    1,
                )
            })
            .collect(),
    ));
}

/// `addImageToImageArrayTests`, minus the mipmap cases (which need
/// CopyImageToImageMipmap, a separate instance).
fn add_image_to_image_array_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    const ARRAY_LAYERS: u32 = 16;
    let extent = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, ARRAY_LAYERS];
    let half = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, 1];

    let parms = |fill: FillMode| ImageParms {
        image_type: vk::ImageType::_2D,
        format: vk::Format::R8G8B8A8_UINT,
        extent,
        tiling: vk::ImageTiling::OPTIMAL,
        fill_mode: fill,
        create_flags: None,
    };
    let make = |name: &str, dst_fill: FillMode, regions: Vec<ImageCopy>, needs_maintenance5: bool| {
        Box::new(CopyImageToImageCase {
            name: name.to_string(),
            src: parms(FillMode::Gradient),
            dst: parms(dst_fill),
            regions,
            clear_destination_with_red: false,
            needs_maintenance5,
            needs_maintenance1: false,
            needs_separate_depth_stencil_layouts: false,
            src_operation_layout: None,
            dst_operation_layout: None,
            allocation_kind: gp.allocation_kind,
            command_variant: gp.command_variant,
            queue_selection: gp.queue_selection,
            general_layout: gp.general_layout,
        }) as Box<dyn TestCase>
    };
    let copy = |src_base: u32, src_count: u32, dst_base: u32, dst_count: u32| ImageCopy {
        src_offset: [0, 0, 0],
        dst_offset: [0, 0, 0],
        extent: half,
        aspect_mask: vk::ImageAspectFlags::COLOR,
        src_base_layer: src_base,
        src_layer_count: src_count,
        dst_base_layer: dst_base,
        dst_layer_count: dst_count,
    };

    // Every case here fills *both* images with the same gradient, so the copy cannot
    // change the destination whatever layers it touches. That is load-bearing, not
    // incidental: the host replay works from the z offsets, which are zero, while the
    // device selects the layer through the subresource - so a differently filled
    // destination would disagree from the second layer on.
    group.add_child(make(
        "array_to_array_layers",
        FillMode::Gradient,
        (0..ARRAY_LAYERS).map(|n| copy(n, 1, n, 1)).collect(),
        false,
    ));

    group.add_child(make("array_to_array_whole", FillMode::Gradient, vec![copy(0, ARRAY_LAYERS, 0, ARRAY_LAYERS)], false));

    // Only the `whole` variant is gated to the universal queue upstream; `partial`
    // is registered for every queue selection.
    for (name, base, universal_only) in [("array_to_array_whole_remaining_layers", 0u32, true), ("array_to_array_partial_remaining_layers", 3, false)] {
        if universal_only && gp.queue_selection != QueueSelection::Universal {
            continue;
        }
        group.add_child(make(name, FillMode::Gradient, vec![copy(base, REMAINING_ARRAY_LAYERS, base, REMAINING_ARRAY_LAYERS)], true));
    }
}

/// `addImageToImageCubeTests`
///
/// Structurally the array tests with six layers, but the create flags are set
/// explicitly on each side: a six-layer 2D image would otherwise always be derived as
/// cube-compatible, and the array half of a cube-to-array copy must not be.
fn add_image_to_image_cube_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    const ARRAY_LAYERS: u32 = 6;
    let extent = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, ARRAY_LAYERS];
    let half = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, 1];

    let parms = |cube: bool, fill: FillMode| ImageParms {
        image_type: vk::ImageType::_2D,
        format: vk::Format::R8G8B8A8_UINT,
        extent,
        tiling: vk::ImageTiling::OPTIMAL,
        fill_mode: fill,
        create_flags: Some(if cube { vk::ImageCreateFlags::CUBE_COMPATIBLE } else { vk::ImageCreateFlags::empty() }),
    };
    let make = |name: &str, src_cube: bool, dst_cube: bool, regions: Vec<ImageCopy>| {
        Box::new(CopyImageToImageCase {
            name: name.to_string(),
            src: parms(src_cube, FillMode::Gradient),
            dst: parms(dst_cube, FillMode::Gradient),
            regions,
            clear_destination_with_red: false,
            needs_maintenance5: false,
            needs_maintenance1: false,
            needs_separate_depth_stencil_layouts: false,
            src_operation_layout: None,
            dst_operation_layout: None,
            allocation_kind: gp.allocation_kind,
            command_variant: gp.command_variant,
            queue_selection: gp.queue_selection,
            general_layout: gp.general_layout,
        }) as Box<dyn TestCase>
    };
    let copy = |src_base: u32, src_count: u32, dst_base: u32, dst_count: u32| ImageCopy {
        src_offset: [0, 0, 0],
        dst_offset: [0, 0, 0],
        extent: half,
        aspect_mask: vk::ImageAspectFlags::COLOR,
        src_base_layer: src_base,
        src_layer_count: src_count,
        dst_base_layer: dst_base,
        dst_layer_count: dst_count,
    };

    for (name, src_cube, dst_cube) in [("cube_to_array", true, false), ("array_to_cube", false, true), ("cube_to_cube", true, true)] {
        group.add_child(make(&format!("{name}_layers"), src_cube, dst_cube, (0..ARRAY_LAYERS).map(|n| copy(n, 1, n, 1)).collect()));
        group.add_child(make(&format!("{name}_whole"), src_cube, dst_cube, vec![copy(0, ARRAY_LAYERS, 0, ARRAY_LAYERS)]));
    }
}

/// `addImageToImageDimensionsTests`' format table: one entry per texel-block size, two
/// compatible formats each.
static DIMENSION_TEST_FORMATS: &[&[(vk::Format, &str)]] = &[
    &[(vk::Format::R4G4_UNORM_PACK8, "r4g4_unorm_pack8"), (vk::Format::R8_SRGB, "r8_srgb")],
    &[(vk::Format::R4G4B4A4_UNORM_PACK16, "r4g4b4a4_unorm_pack16"), (vk::Format::R16_SFLOAT, "r16_sfloat")],
    &[(vk::Format::R8G8B8_UNORM, "r8g8b8_unorm"), (vk::Format::B8G8R8_SRGB, "b8g8r8_srgb")],
    &[(vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"), (vk::Format::R32_SFLOAT, "r32_sfloat")],
    &[(vk::Format::R16G16B16_UNORM, "r16g16b16_unorm"), (vk::Format::R16G16B16_SFLOAT, "r16g16b16_sfloat")],
    // R64_SFLOAT and the wider 64-bit-per-channel formats below are dropped by
    // isSupportedByFramework, which is why these groups are one-sided.
    &[(vk::Format::R16G16B16A16_UNORM, "r16g16b16a16_unorm")],
    &[(vk::Format::R32G32B32_UINT, "r32g32b32_uint"), (vk::Format::R32G32B32_SFLOAT, "r32g32b32_sfloat")],
    &[(vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint")],
];

/// `imageDimensions` - a large power-of-two axis against a small one, both ways round
/// and with a non-power-of-two variant.
static IMAGE_DIMENSIONS_2D: &[[u32; 2]] = &[
    [4096, 4],
    [8192, 4],
    [16384, 4],
    [32768, 4],
    [4096, 6],
    [8192, 6],
    [16384, 6],
    [32768, 6],
    [4, 4096],
    [4, 8192],
    [4, 16384],
    [4, 32768],
    [6, 4096],
    [6, 8192],
    [6, 16384],
    [6, 32768],
];

/// `getImageLayoutCaseName`
fn image_layout_case_name(layout: vk::ImageLayout) -> &'static str {
    if layout == vk::ImageLayout::GENERAL { "general" } else { "optimal" }
}

/// `addImageToImageDimensionsTests`
fn add_image_to_image_dimensions_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    const SRC_LAYOUTS: [vk::ImageLayout; 2] = [vk::ImageLayout::TRANSFER_SRC_OPTIMAL, vk::ImageLayout::GENERAL];
    const DST_LAYOUTS: [vk::ImageLayout; 2] = [vk::ImageLayout::TRANSFER_DST_OPTIMAL, vk::ImageLayout::GENERAL];

    for &[width, height] in IMAGE_DIMENSIONS_2D {
        let extent = [width, height, 1];
        let mut size_group = tcu::TestCaseGroup::new(format!("src{width}x{height}_dst{width}x{height}"));

        for compatible in DIMENSION_TEST_FORMATS {
            for &(src_format, src_name) in *compatible {
                let mut src_group = tcu::TestCaseGroup::new(src_name);

                for &(dst_format, dst_name) in *compatible {
                    let mut dst_group = tcu::TestCaseGroup::new(dst_name);

                    for src_layout in SRC_LAYOUTS {
                        for dst_layout in DST_LAYOUTS {
                            dst_group.add_child(Box::new(CopyImageToImageCase {
                                name: format!("{}_{}", image_layout_case_name(src_layout), image_layout_case_name(dst_layout)),
                                src: ImageParms {
                                    image_type: vk::ImageType::_2D,
                                    format: src_format,
                                    extent,
                                    tiling: vk::ImageTiling::OPTIMAL,
                                    fill_mode: FillMode::Pyramid,
                                    create_flags: None,
                                },
                                dst: ImageParms {
                                    image_type: vk::ImageType::_2D,
                                    format: dst_format,
                                    extent,
                                    tiling: vk::ImageTiling::OPTIMAL,
                                    fill_mode: FillMode::White,
                                    create_flags: None,
                                },
                                regions: vec![ImageCopy {
                                    src_offset: [0, 0, 0],
                                    dst_offset: [0, 0, 0],
                                    extent,
                                    aspect_mask: vk::ImageAspectFlags::COLOR,
                                    src_base_layer: 0,
                                    src_layer_count: 1,
                                    dst_base_layer: 0,
                                    dst_layer_count: 1,
                                }],
                                clear_destination_with_red: false,
                                needs_maintenance5: false,
                                needs_maintenance1: false,
                                needs_separate_depth_stencil_layouts: false,
                                src_operation_layout: Some(src_layout),
                                dst_operation_layout: Some(dst_layout),
                                allocation_kind: gp.allocation_kind,
                                command_variant: gp.command_variant,
                                queue_selection: gp.queue_selection,
                                general_layout: gp.general_layout,
                            }) as Box<dyn TestCase>);
                        }
                    }
                    src_group.add_child(dst_group);
                }
                size_group.add_child(src_group);
            }
        }
        group.add_child(size_group);
    }
}

/// `VK_FORMAT_ASTC_12x12_SRGB_BLOCK`, upstream's `VK_CORE_FORMAT_LAST` minus one.
const LAST_CORE_FORMAT: i32 = 184;

/// `vk::isSupportedByFramework`
///
/// Two rules, both needed: anything past the core format range is out (which is how the
/// ycbcr-adjacent r10x6/r12x4 packings and the a4r4g4b4 pair fall away), and the
/// 64-bit-per-channel formats are rejected by name even though they sit inside it.
pub fn is_supported_by_framework(format: vk::Format) -> bool {
    if matches!(format, vk::Format::A8_UNORM | vk::Format::A1B5G5R5_UNORM_PACK16) {
        return true;
    }
    if format == vk::Format::UNDEFINED || format.as_raw() > LAST_CORE_FORMAT {
        return false;
    }
    !matches!(
        format,
        vk::Format::R64_UINT
            | vk::Format::R64_SINT
            | vk::Format::R64_SFLOAT
            | vk::Format::R64G64_UINT
            | vk::Format::R64G64_SINT
            | vk::Format::R64G64_SFLOAT
            | vk::Format::R64G64B64_UINT
            | vk::Format::R64G64B64_SINT
            | vk::Format::R64G64B64_SFLOAT
            | vk::Format::R64G64B64A64_UINT
            | vk::Format::R64G64B64A64_SINT
            | vk::Format::R64G64B64A64_SFLOAT
    )
}

/// `dedicatedAllocationImageToImageFormatsToTest` - the same fourteen formats the
/// dimensions table uses. `isAllowedImageToImageAllFormatsColorSrcFormatTests` narrows
/// the all_formats matrix to these whenever the allocation is dedicated, which is why
/// the dedicated_allocation and copy_commands2 groups are a fraction of core's size.
static DEDICATED_ALLOCATION_FORMATS: &[vk::Format] = &[
    vk::Format::R4G4_UNORM_PACK8,
    vk::Format::R8_SRGB,
    vk::Format::R4G4B4A4_UNORM_PACK16,
    vk::Format::R16_SFLOAT,
    vk::Format::R8G8B8_UNORM,
    vk::Format::B8G8R8_SRGB,
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::R32_SFLOAT,
    vk::Format::R16G16B16_UNORM,
    vk::Format::R16G16B16_SFLOAT,
    vk::Format::R16G16B16A16_UNORM,
    vk::Format::R32G32B32_UINT,
    vk::Format::R32G32B32_SFLOAT,
    vk::Format::R32G32B32A32_UINT,
];

/// `defaultRootSize` - the square root of `defaultSize`, so a 1D run of 64 texels maps
/// onto an 8x8 image.
const DEFAULT_ROOT_SIZE: u32 = 8;
/// `defaultSixteenthSize`
const DEFAULT_SIXTEENTH_SIZE: u32 = DEFAULT_SIZE / 16;

fn color_copy(src_offset: [i32; 3], dst_offset: [i32; 3], extent: [u32; 3]) -> ImageCopy {
    ImageCopy {
        src_offset,
        dst_offset,
        extent,
        aspect_mask: vk::ImageAspectFlags::COLOR,
        src_base_layer: 0,
        src_layer_count: 1,
        dst_base_layer: 0,
        dst_layer_count: 1,
    }
}

/// The three blocks whose destination format follows the source.
fn all_formats_same_format_blocks() -> Vec<(&'static str, AllFormatsBlock)> {
    // 1d_to_1d: two quarter-width regions landing a quarter and three quarters across.
    let mut regions_1d = Vec::new();
    let mut i = DEFAULT_QUARTER_SIZE;
    while i < DEFAULT_SIZE {
        regions_1d.push(color_copy([0, 0, 0], [i as i32, 0, 0], [DEFAULT_QUARTER_SIZE, 1, 1]));
        i += DEFAULT_SIZE / 2;
    }

    // 1d_to_2d: the 1D run is dealt out one row at a time.
    let regions_1d_2d: Vec<ImageCopy> = (0..DEFAULT_ROOT_SIZE)
        .map(|i| color_copy([(DEFAULT_ROOT_SIZE * i) as i32, 0, 0], [0, i as i32, 0], [DEFAULT_ROOT_SIZE, 1, 1]))
        .collect();

    // 1d_to_3d: one row per (slice, row) pair of a small cube.
    let mut regions_1d_3d = Vec::new();
    for i in 0..DEFAULT_SIXTEENTH_SIZE {
        for j in 0..DEFAULT_SIXTEENTH_SIZE {
            regions_1d_3d.push(color_copy(
                [(i * DEFAULT_QUARTER_SIZE + j * DEFAULT_SIXTEENTH_SIZE) as i32, 0, 0],
                [0, j as i32, (i % DEFAULT_SIXTEENTH_SIZE) as i32],
                [DEFAULT_SIXTEENTH_SIZE, 1, 1],
            ));
        }
    }

    // 3d_to_1d: one row per (slice, row) pair, dealt out along the 1D run.
    let mut regions_3d_1d = Vec::new();
    for i in 0..DEFAULT_SIXTEENTH_SIZE {
        for j in 0..DEFAULT_SIXTEENTH_SIZE {
            regions_3d_1d.push(color_copy(
                [0, (j % DEFAULT_SIXTEENTH_SIZE) as i32, (i % DEFAULT_SIXTEENTH_SIZE) as i32],
                [(j * DEFAULT_SIXTEENTH_SIZE + i * DEFAULT_QUARTER_SIZE) as i32, 0, 0],
                [DEFAULT_SIXTEENTH_SIZE, 1, 1],
            ));
        }
    }

    // 3d_to_2d: each slice of the cube becomes one tile of a 4x4 grid.
    let mut regions_3d_2d = Vec::new();
    for i in 0..DEFAULT_SIXTEENTH_SIZE {
        for j in 0..DEFAULT_SIXTEENTH_SIZE {
            regions_3d_2d.push(color_copy(
                [0, 0, (i * DEFAULT_SIXTEENTH_SIZE + j) as i32],
                [(j * DEFAULT_QUARTER_SIZE) as i32, (i * DEFAULT_QUARTER_SIZE) as i32, 0],
                [DEFAULT_QUARTER_SIZE, DEFAULT_QUARTER_SIZE, 1],
            ));
        }
    }

    // 3d_to_3d: small cubes stepping along a diagonal, with y running backwards.
    let mut regions_3d_3d = Vec::new();
    let mut i = 0u32;
    while i < DEFAULT_QUARTER_SIZE {
        regions_3d_3d.push(color_copy(
            [0, 0, 0],
            [i as i32, (DEFAULT_QUARTER_SIZE - i - DEFAULT_SIXTEENTH_SIZE) as i32, i as i32],
            [DEFAULT_SIXTEENTH_SIZE, DEFAULT_SIXTEENTH_SIZE, DEFAULT_SIXTEENTH_SIZE],
        ));
        i += DEFAULT_SIXTEENTH_SIZE;
    }

    // 2d_to_2d: quarter-size tiles stepping across, with y running backwards.
    let mut regions_2d_2d = Vec::new();
    let mut i = 0u32;
    while i < DEFAULT_SIZE {
        regions_2d_2d.push(color_copy(
            [0, 0, 0],
            [i as i32, (DEFAULT_SIZE - i - DEFAULT_QUARTER_SIZE) as i32, 0],
            [DEFAULT_QUARTER_SIZE, DEFAULT_QUARTER_SIZE, 1],
        ));
        i += DEFAULT_QUARTER_SIZE;
    }

    // 2d_to_3d: one small tile per slice, walking diagonally across the source.
    let regions_2d_3d: Vec<ImageCopy> = (0..DEFAULT_SIXTEENTH_SIZE)
        .map(|i| {
            color_copy(
                [(i * DEFAULT_SIXTEENTH_SIZE) as i32, (i % DEFAULT_SIXTEENTH_SIZE) as i32, 0],
                [0, 0, i as i32],
                [DEFAULT_SIXTEENTH_SIZE, DEFAULT_SIXTEENTH_SIZE, 1],
            )
        })
        .collect();

    // 2d_to_1d: each row of a quarter-size square is laid end to end along the 1D run.
    let regions_2d_1d: Vec<ImageCopy> = (0..DEFAULT_QUARTER_SIZE)
        .map(|i| color_copy([0, i as i32, 0], [(i * DEFAULT_QUARTER_SIZE) as i32, 0, 0], [DEFAULT_QUARTER_SIZE, 1, 1]))
        .collect();

    let extent_3d = [DEFAULT_QUARTER_SIZE, DEFAULT_QUARTER_SIZE, DEFAULT_QUARTER_SIZE];
    let quarter_extent = [DEFAULT_QUARTER_SIZE, DEFAULT_QUARTER_SIZE, 1];
    let quarter_squared_1d = [DEFAULT_QUARTER_SIZE * DEFAULT_QUARTER_SIZE, 1, 1];

    let root_extent = [DEFAULT_ROOT_SIZE, DEFAULT_ROOT_SIZE, 1];
    let small_3d = [DEFAULT_SIXTEENTH_SIZE, DEFAULT_SIXTEENTH_SIZE, DEFAULT_SIXTEENTH_SIZE];

    vec![
        (
            "1d_to_1d",
            AllFormatsBlock {
                src_type: vk::ImageType::_1D,
                dst_type: vk::ImageType::_1D,
                src_extent: DEFAULT_1D_EXTENT,
                dst_extent: DEFAULT_1D_EXTENT,
                regions: regions_1d,
                needs_maintenance5: false,
                needs_maintenance1: false,
                src_fill: FillMode::White,
                has_ds_aspects_variant: false,
                cross_format: false,
            },
        ),
        (
            "1d_to_2d",
            AllFormatsBlock {
                src_type: vk::ImageType::_1D,
                dst_type: vk::ImageType::_2D,
                src_extent: DEFAULT_1D_EXTENT,
                dst_extent: root_extent,
                regions: regions_1d_2d,
                needs_maintenance5: true,
                needs_maintenance1: false,
                src_fill: FillMode::White,
                has_ds_aspects_variant: false,
                cross_format: false,
            },
        ),
        (
            "1d_to_3d",
            AllFormatsBlock {
                src_type: vk::ImageType::_1D,
                dst_type: vk::ImageType::_3D,
                src_extent: DEFAULT_1D_EXTENT,
                dst_extent: small_3d,
                regions: regions_1d_3d,
                needs_maintenance5: true,
                needs_maintenance1: false,
                src_fill: FillMode::White,
                has_ds_aspects_variant: false,
                cross_format: false,
            },
        ),
        (
            "2d_to_1d",
            AllFormatsBlock {
                src_type: vk::ImageType::_2D,
                dst_type: vk::ImageType::_1D,
                src_extent: quarter_extent,
                dst_extent: quarter_squared_1d,
                regions: regions_2d_1d,
                needs_maintenance5: true,
                needs_maintenance1: false,
                src_fill: FillMode::White,
                has_ds_aspects_variant: true,
                cross_format: true,
            },
        ),
        (
            "2d_to_2d",
            AllFormatsBlock {
                src_type: vk::ImageType::_2D,
                dst_type: vk::ImageType::_2D,
                src_extent: DEFAULT_EXTENT,
                dst_extent: DEFAULT_EXTENT,
                regions: regions_2d_2d,
                needs_maintenance5: false,
                needs_maintenance1: false,
                src_fill: FillMode::RandomGray,
                has_ds_aspects_variant: true,
                cross_format: true,
            },
        ),
        (
            "2d_to_3d",
            AllFormatsBlock {
                src_type: vk::ImageType::_2D,
                dst_type: vk::ImageType::_3D,
                src_extent: DEFAULT_EXTENT,
                dst_extent: small_3d,
                regions: regions_2d_3d,
                needs_maintenance5: false,
                needs_maintenance1: true,
                src_fill: FillMode::RandomGray,
                has_ds_aspects_variant: true,
                cross_format: true,
            },
        ),
        (
            "3d_to_1d",
            AllFormatsBlock {
                src_type: vk::ImageType::_3D,
                dst_type: vk::ImageType::_1D,
                src_extent: small_3d,
                dst_extent: DEFAULT_1D_EXTENT,
                regions: regions_3d_1d,
                needs_maintenance5: true,
                needs_maintenance1: false,
                src_fill: FillMode::White,
                has_ds_aspects_variant: false,
                cross_format: false,
            },
        ),
        (
            "3d_to_2d",
            AllFormatsBlock {
                src_type: vk::ImageType::_3D,
                dst_type: vk::ImageType::_2D,
                src_extent: extent_3d,
                dst_extent: DEFAULT_EXTENT,
                regions: regions_3d_2d,
                needs_maintenance5: false,
                needs_maintenance1: true,
                src_fill: FillMode::White,
                has_ds_aspects_variant: false,
                cross_format: false,
            },
        ),
        (
            "3d_to_3d",
            AllFormatsBlock {
                src_type: vk::ImageType::_3D,
                dst_type: vk::ImageType::_3D,
                src_extent: extent_3d,
                dst_extent: extent_3d,
                regions: regions_3d_3d,
                needs_maintenance5: false,
                needs_maintenance1: false,
                src_fill: FillMode::White,
                has_ds_aspects_variant: false,
                cross_format: false,
            },
        ),
    ]
}

/// One `<src>_to_<dst>` block of `addImageToImageAllFormatsColorTests`.
struct AllFormatsBlock {
    src_type: vk::ImageType,
    dst_type: vk::ImageType,
    src_extent: [u32; 3],
    dst_extent: [u32; 3],
    regions: Vec<ImageCopy>,
    /// Copying between different image types only became legal with
    /// VK_KHR_maintenance5, so the mixed blocks carry the requirement.
    needs_maintenance5: bool,
    /// 3D-to-2D is the one pairing that predates it, under VK_KHR_maintenance1.
    needs_maintenance1: bool,
    /// `src.image.fillMode` - most blocks use white, the two 2D-source ones use the
    /// random-grey fill.
    src_fill: FillMode,
    /// The 2D-source blocks add a third depth/stencil variant that copies both aspects
    /// in one region instead of one region per aspect - legal for vkCmdCopyImage, which
    /// is what makes it worth testing separately.
    has_ds_aspects_variant: bool,
    /// When set, the destination iterates over the whole compatible-format group
    /// instead of following the source. Upstream expresses this by passing the group
    /// rather than a null list.
    cross_format: bool,
}

/// One `<src>_to_<dst>` block of `addImageToImageAllFormatsColorTests`.
fn add_image_to_image_all_formats_block(group: &mut tcu::TestCaseGroup, gp: &GroupParams, block: &AllFormatsBlock) {
    const SRC_LAYOUTS: [vk::ImageLayout; 2] = [vk::ImageLayout::TRANSFER_SRC_OPTIMAL, vk::ImageLayout::GENERAL];
    const DST_LAYOUTS: [vk::ImageLayout; 2] = [vk::ImageLayout::TRANSFER_DST_OPTIMAL, vk::ImageLayout::GENERAL];

    for compatible in COLOR_IMAGE_FORMATS_TO_TEST {
        for entry in *compatible {
            // The compressed formats need a block model in tcu that is not ported, so
            // they are absent rather than answered with a verdict.
            if entry.compressed || !is_supported_by_framework(entry.format) {
                continue;
            }
            // The dedicated filter is deliberately not applied to the source alone:
            // `isAllowedImageToImageAllFormatsColorSrcFormatTests` accepts a pair when
            // *either* side is in the list, so a source outside it still gets a group as
            // long as some destination is inside. Applying it per side instead drops a
            // quarter of the cross-format pairs.
            let allowed = |src: vk::Format, dst: vk::Format| {
                gp.allocation_kind != AllocationKind::Dedicated || DEDICATED_ALLOCATION_FORMATS.contains(&src) || DEDICATED_ALLOCATION_FORMATS.contains(&dst)
            };
            let mut src_group = tcu::TestCaseGroup::new(entry.name);

            // Either the whole compatible group, or just this format.
            let destinations: Vec<&CopyFormat> = if block.cross_format {
                compatible
                    .iter()
                    .filter(|d| !d.compressed && is_supported_by_framework(d.format) && allowed(entry.format, d.format))
                    .collect()
            } else {
                if !allowed(entry.format, entry.format) {
                    continue;
                }
                vec![entry]
            };
            if destinations.is_empty() {
                continue;
            }

            for dst_entry in destinations {
                let mut dst_group = tcu::TestCaseGroup::new(dst_entry.name);

                for src_layout in SRC_LAYOUTS {
                    for dst_layout in DST_LAYOUTS {
                        dst_group.add_child(Box::new(CopyImageToImageCase {
                            name: format!("{}_{}", image_layout_case_name(src_layout), image_layout_case_name(dst_layout)),
                            src: ImageParms {
                                image_type: block.src_type,
                                format: entry.format,
                                extent: block.src_extent,
                                tiling: vk::ImageTiling::OPTIMAL,
                                fill_mode: block.src_fill,
                                create_flags: None,
                            },
                            dst: ImageParms {
                                image_type: block.dst_type,
                                format: dst_entry.format,
                                extent: block.dst_extent,
                                tiling: vk::ImageTiling::OPTIMAL,
                                fill_mode: FillMode::Gradient,
                                create_flags: None,
                            },
                            regions: block.regions.clone(),
                            clear_destination_with_red: false,
                            needs_maintenance5: block.needs_maintenance5,
                            needs_maintenance1: block.needs_maintenance1,
                            needs_separate_depth_stencil_layouts: false,
                            src_operation_layout: Some(src_layout),
                            dst_operation_layout: Some(dst_layout),
                            allocation_kind: gp.allocation_kind,
                            command_variant: gp.command_variant,
                            queue_selection: gp.queue_selection,
                            general_layout: gp.general_layout,
                        }) as Box<dyn TestCase>);
                    }
                }
                src_group.add_child(dst_group);
            }
            group.add_child(src_group);
        }
    }
}

/// `addImageToImageAllFormatsDepthStencilTests`
///
/// A combined format copies one region per aspect, and gets a `_separate_layouts`
/// sibling on top - the layout pair is the same, but the aspects are transitioned
/// independently, which needs VK_KHR_separate_depth_stencil_layouts.
fn add_image_to_image_all_formats_depth_stencil(group: &mut tcu::TestCaseGroup, gp: &GroupParams, block: &AllFormatsBlock) {
    const SRC_LAYOUTS: [vk::ImageLayout; 2] = [vk::ImageLayout::TRANSFER_SRC_OPTIMAL, vk::ImageLayout::GENERAL];
    const DST_LAYOUTS: [vk::ImageLayout; 2] = [vk::ImageLayout::TRANSFER_DST_OPTIMAL, vk::ImageLayout::GENERAL];

    for &(format, name) in DEPTH_AND_STENCIL_FORMATS {
        let aspects = get_aspect_flags(format);
        let has_depth = aspects.contains(vk::ImageAspectFlags::DEPTH);
        let has_stencil = aspects.contains(vk::ImageAspectFlags::STENCIL);

        // One region per aspect present, for each of the block's geometries.
        let mut regions = Vec::new();
        for r in &block.regions {
            if has_depth {
                regions.push(ImageCopy {
                    aspect_mask: vk::ImageAspectFlags::DEPTH,
                    ..*r
                });
            }
            if has_stencil {
                regions.push(ImageCopy {
                    aspect_mask: vk::ImageAspectFlags::STENCIL,
                    ..*r
                });
            }
        }

        // Both aspects in one region, which is what the third variant exists to cover.
        let combined_regions: Vec<ImageCopy> = block
            .regions
            .iter()
            .map(|r| ImageCopy {
                aspect_mask: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                ..*r
            })
            .collect();

        let mut variants: Vec<(&str, bool, &Vec<ImageCopy>)> = vec![("", false, &regions)];
        if has_depth && has_stencil {
            variants.push(("_separate_layouts", true, &regions));
            if block.has_ds_aspects_variant {
                variants.push(("_depth_stencil_aspects", false, &combined_regions));
            }
        }

        for &(suffix, separate_layouts, variant_regions) in &variants {
            let mut format_group = tcu::TestCaseGroup::new(format!("{name}_{name}{suffix}"));
            for src_layout in SRC_LAYOUTS {
                for dst_layout in DST_LAYOUTS {
                    format_group.add_child(Box::new(CopyImageToImageCase {
                        name: format!("{}_{}", image_layout_case_name(src_layout), image_layout_case_name(dst_layout)),
                        src: ImageParms {
                            image_type: block.src_type,
                            format,
                            extent: block.src_extent,
                            tiling: vk::ImageTiling::OPTIMAL,
                            fill_mode: FillMode::Gradient,
                            create_flags: None,
                        },
                        dst: ImageParms {
                            image_type: block.dst_type,
                            format,
                            extent: block.dst_extent,
                            tiling: vk::ImageTiling::OPTIMAL,
                            fill_mode: FillMode::Gradient,
                            create_flags: None,
                        },
                        regions: variant_regions.clone(),
                        clear_destination_with_red: false,
                        needs_maintenance5: block.needs_maintenance5,
                        needs_maintenance1: block.needs_maintenance1,
                        needs_separate_depth_stencil_layouts: separate_layouts,
                        src_operation_layout: Some(src_layout),
                        dst_operation_layout: Some(dst_layout),
                        allocation_kind: gp.allocation_kind,
                        command_variant: gp.command_variant,
                        queue_selection: gp.queue_selection,
                        general_layout: gp.general_layout,
                    }) as Box<dyn TestCase>);
                }
            }
            group.add_child(format_group);
        }
    }
}

/// The `image_to_image*` groups.
pub fn add_image_to_image_groups(
    parent: &mut tcu::TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
) {
    let gp = GroupParams {
        allocation_kind,
        command_variant,
        queue_selection,
        general_layout,
    };
    let mut group = tcu::TestCaseGroup::new(name);
    let mut simple = tcu::TestCaseGroup::new("simple_tests");
    add_image_to_image_simple_tests(&mut simple, &gp);
    group.add_child(simple);

    // `image_to_image_general_layout` goes through addCopyImageToImageTestsSimpleOnly
    // upstream, so it gets simple_tests and nothing else.
    if !general_layout {
        let mut images_3d = tcu::TestCaseGroup::new("3d_images");
        add_image_to_image_3d_tests(&mut images_3d, &gp);
        group.add_child(images_3d);

        let mut all_formats = tcu::TestCaseGroup::new("all_formats");
        let mut color = tcu::TestCaseGroup::new("color");
        for (name, block) in all_formats_same_format_blocks() {
            let mut sub = tcu::TestCaseGroup::new(name);
            add_image_to_image_all_formats_block(&mut sub, &gp, &block);
            color.add_child(sub);
        }
        all_formats.add_child(color);

        let mut depth_stencil = tcu::TestCaseGroup::new("depth_stencil");
        for (name, block) in all_formats_same_format_blocks() {
            let mut sub = tcu::TestCaseGroup::new(name);
            add_image_to_image_all_formats_depth_stencil(&mut sub, &gp, &block);
            depth_stencil.add_child(sub);
        }
        all_formats.add_child(depth_stencil);
        group.add_child(all_formats);

        let mut dimensions = tcu::TestCaseGroup::new("dimensions");
        add_image_to_image_dimensions_tests(&mut dimensions, &gp);
        group.add_child(dimensions);

        let mut cube = tcu::TestCaseGroup::new("cube");
        add_image_to_image_cube_tests(&mut cube, &gp);
        group.add_child(cube);

        let mut array = tcu::TestCaseGroup::new("array");
        add_image_to_image_array_tests(&mut array, &gp);
        group.add_child(array);
    }
    // all_formats still needs a compressed-format model in tcu for the compressed cases.
    parent.add_child(group);
}

// ---------------------------------------------------------------------------------
// CopyBufferToDepthStencil
// ---------------------------------------------------------------------------------

/// `mapCombinedToDepthTransferFormat`
///
/// The packed depth-only layout a combined format's depth aspect travels in. Not the
/// same as `get_depth_copy_format`: a 24_8_REV depth stays 24_8_REV here rather than
/// becoming a 24-bit unorm, because this one describes bytes on the wire.
fn map_combined_to_depth_transfer_format(combined: tcu::TextureFormat) -> Option<tcu::TextureFormat> {
    use crate::tcu::texture::{ChannelOrder, ChannelType};
    let type_ = match combined.type_ {
        ChannelType::UNORM_INT16 | ChannelType::UNSIGNED_INT_16_8_8 => ChannelType::UNORM_INT16,
        ChannelType::UNSIGNED_INT_24_8_REV => ChannelType::UNSIGNED_INT_24_8_REV,
        ChannelType::FLOAT_UNSIGNED_INT_24_8_REV | ChannelType::FLOAT => ChannelType::FLOAT,
        _ => return None,
    };
    Some(tcu::TextureFormat::new(ChannelOrder::D, type_))
}

/// `CopyBufferToDepthStencilTestCase`
pub struct CopyBufferToDepthStencilCase {
    name: String,
    src_buffer_size: u32,
    dst: ImageParms,
    regions: Vec<BufferImageCopy>,
    /// `TestParams::singleCommand` - all regions in one vkCmdCopyBufferToImage rather
    /// than one command per region.
    single_command: bool,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
}

impl TestCase for CopyBufferToDepthStencilCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        select_queue(context, self.queue_selection)?;

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.dst.format,
                self.dst.image_type,
                self.dst.tiling,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format not supported".to_string()))?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyBufferToDepthStencilInstance { context, params: self })
    }
}

struct CopyBufferToDepthStencilInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CopyBufferToDepthStencilCase,
}

/// `CopyBufferToDepthStencil::copyRegionToTextureLevel` - one aspect of a combined
/// source run into the matching aspect of a combined destination image.
fn copy_ds_region_to_texture_level(src: &ConstPixelBufferAccess<'_>, dst: &mut TextureLevel, region: BufferImageCopy, texel_size: usize, depth_transfer_size: usize) {
    let row_length = if region.buffer_row_length == 0 {
        region.image_extent[0]
    } else {
        region.buffer_row_length
    };
    let image_height = if region.buffer_image_height == 0 {
        region.image_extent[1]
    } else {
        region.buffer_image_height
    };
    let depth = region.aspect_mask == vk::ImageAspectFlags::DEPTH;
    // The device reads a depth region straight out of the packed depth run without
    // rescaling its offset, but rescales a stencil one by the combined texel size
    // first. The reference has to read the same texel, so the divisor differs per
    // aspect - it only looks symmetric when the two happen to be equal, as they are
    // for d24_unorm_s8_uint.
    let divisor = if depth { depth_transfer_size } else { texel_size };
    let texel_offset = (region.buffer_offset / divisor as u64) as u32;

    for z in 0..region.image_extent[2] {
        for y in 0..region.image_extent[1] {
            let texel_index = texel_offset + (z * image_height + y) * row_length;
            for x in 0..region.image_extent[0] {
                let dst_x = region.image_offset[0] as u32 + x;
                let dst_y = region.image_offset[1] as u32 + y;
                let dst_z = region.image_offset[2] as u32 + z;
                if depth {
                    let v = src.get_pix_depth(texel_index + x, 0, 0);
                    dst.get_access().set_pix_depth(v, dst_x, dst_y, dst_z);
                } else {
                    let v = src.get_pix_stencil(texel_index + x, 0, 0);
                    dst.get_access().set_pix_stencil(v, dst_x, dst_y, dst_z);
                }
            }
        }
    }
}

impl TestInstance for CopyBufferToDepthStencilInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;
        let mut families = vec![self.context.get_universal_queue_family_index()];
        if queue_family_index != families[0] {
            families.push(queue_family_index);
        }

        let texture_format = map_vk_format(p.dst.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let texel_size = texture_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))? as usize;

        // The source is a flat run of combined texels; only the aspect each region names
        // is ever read out of it.
        let mut source_level = TextureLevel::new(texture_format, p.src_buffer_size, 1, 1)?;
        generate_buffer(&mut source_level.get_access(), p.src_buffer_size, 1, 1, FillMode::Gradient, false);

        let mut destination_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        generate_buffer(
            &mut destination_level.get_access(),
            p.dst.extent[0],
            p.dst.extent[1],
            p.dst.extent[2],
            FillMode::Gradient,
            false,
        );

        let mut expected_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        let depth_transfer_size = map_combined_to_depth_transfer_format(texture_format)
            .and_then(|f| f.pixel_size())
            .unwrap_or(texel_size as u32) as usize;
        for region in &p.regions {
            copy_ds_region_to_texture_level(&source_level.get_const_access(), &mut expected_level, *region, texel_size, depth_transfer_size);
        }

        // The device sees packed single-aspect runs laid out in region order, so each
        // region's buffer offset has to be rewritten to point at its own run.
        let texels = p.src_buffer_size;
        let mut packed: Vec<u8> = Vec::new();
        let mut device_regions: Vec<BufferImageCopy> = Vec::new();
        let (mut depth_offset, mut stencil_offset) = (None::<u64>, None::<u64>);

        for region in &p.regions {
            let mut r = *region;
            if r.aspect_mask == vk::ImageAspectFlags::DEPTH {
                if depth_offset.is_none() {
                    let format = map_combined_to_depth_transfer_format(texture_format).ok_or_else(|| TestError::NotSupported("no depth transfer format".to_string()))?;
                    let mut level = TextureLevel::new(format, texels, 1, 1)?;
                    transfer_aspect(&mut source_level, vk::ImageAspectFlags::DEPTH, &mut level, true);
                    depth_offset = Some(packed.len() as u64);
                    packed.extend_from_slice(level.data());
                }
                r.buffer_offset += depth_offset.expect("just set");
            } else {
                if stencil_offset.is_none() {
                    let format = get_stencil_copy_format(p.dst.format).ok_or_else(|| TestError::NotSupported("no stencil transfer format".to_string()))?;
                    let mut level = TextureLevel::new(format, texels, 1, 1)?;
                    transfer_aspect(&mut source_level, vk::ImageAspectFlags::STENCIL, &mut level, true);
                    stencil_offset = Some(packed.len() as u64);
                    packed.extend_from_slice(level.data());
                }
                // The reference works in combined texels, the device in packed stencil
                // bytes, so the offset is rescaled before the run's base is added.
                r.buffer_offset = r.buffer_offset / texel_size as u64 + stencil_offset.expect("just set");
            }
            device_regions.push(r);
        }

        let source_info = staging_buffer_create_info(packed.len() as u64, vk::BufferUsageFlags::TRANSFER_SRC, &families);
        let source_buffer = unsafe { vk_device.create_buffer(&source_info, None) }.vk_check("vkCreateBuffer")?;
        let source_buffer = Unique::new(vk_device, source_buffer);
        let source_alloc = bind_buffer_memory(self.context, *source_buffer, p.allocation_kind)?;
        unsafe { std::ptr::copy_nonoverlapping(packed.as_ptr(), source_alloc.get_host_ptr(), packed.len()) };
        flush_alloc(vk_device, &source_alloc)?;

        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: p.dst.image_type,
            format: p.dst.format,
            extent: p.dst.extent_3d(),
            mip_levels: 1,
            array_layers: p.dst.array_size(),
            samples: vk::SampleCountFlags::_1,
            tiling: p.dst.tiling,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let destination = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        };

        upload_image(
            self.context,
            &destination_level.get_const_access(),
            destination.get(),
            &p.dst,
            p.general_layout,
            &families,
            false,
        )?;

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let range = make_image_subresource_range(get_aspect_flags(p.dst.format), 0, 1, 0, p.dst.array_size());

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let barrier = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_WRITE, layout, layout, destination.get(), range);
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );

            let copies: Vec<vk::BufferImageCopy> = device_regions.iter().map(|r| r.to_vk()).collect();
            let batches: Vec<&[vk::BufferImageCopy]> = if p.single_command { vec![&copies] } else { copies.chunks(1).collect() };
            for batch in batches {
                if p.command_variant == CopyCommandVariant::CopyCommands2 {
                    let copies2: Vec<vk::BufferImageCopy2> = batch
                        .iter()
                        .map(|c| vk::BufferImageCopy2 {
                            s_type: vk::StructureType::BUFFER_IMAGE_COPY_2,
                            next: std::ptr::null(),
                            buffer_offset: c.buffer_offset,
                            buffer_row_length: c.buffer_row_length,
                            buffer_image_height: c.buffer_image_height,
                            image_subresource: c.image_subresource,
                            image_offset: c.image_offset,
                            image_extent: c.image_extent,
                        })
                        .collect();
                    let info = vk::CopyBufferToImageInfo2 {
                        s_type: vk::StructureType::COPY_BUFFER_TO_IMAGE_INFO_2,
                        next: std::ptr::null(),
                        src_buffer: *source_buffer,
                        dst_image: destination.get(),
                        dst_image_layout: layout,
                        region_count: copies2.len() as u32,
                        regions: copies2.as_ptr(),
                    };
                    vk_device.cmd_copy_buffer_to_image2(*cmd_buffer, &info);
                } else {
                    vk_device.cmd_copy_buffer_to_image(*cmd_buffer, *source_buffer, destination.get(), layout, batch);
                }
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        let mut result_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        read_image(self.context, destination.get(), &p.dst, &mut result_level, p.general_layout, &families)?;

        Ok(check_test_result(&expected_level.get_const_access(), &result_level.get_const_access()))
    }
}

/// `addCopyBufferToDepthStencilTests`
fn add_copy_buffer_to_depth_stencil_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let region = |aspect: vk::ImageAspectFlags, offset: bool| BufferImageCopy {
        aspect_mask: aspect,
        buffer_offset: if offset { 32 } else { 0 },
        buffer_row_length: if offset { DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE } else { 0 },
        buffer_image_height: if offset { DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE } else { 0 },
        base_array_layer: 0,
        layer_count: 1,
        image_offset: if offset {
            [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0]
        } else {
            [0, 0, 0]
        },
        image_extent: if offset { DEFAULT_HALF_EXTENT } else { DEFAULT_EXTENT },
    };

    for &(format, format_name) in DEPTH_AND_STENCIL_FORMATS {
        for offset in [false, true] {
            let aspects = get_aspect_flags(format);
            let has_depth = aspects.contains(vk::ImageAspectFlags::DEPTH);
            let has_stencil = aspects.contains(vk::ImageAspectFlags::STENCIL);

            let src_buffer_size = if offset {
                (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE
            } else {
                DEFAULT_SIZE * DEFAULT_SIZE
            };
            let prefix = if offset { "buffer_offset_" } else { "" };
            let depth = region(vk::ImageAspectFlags::DEPTH, offset);
            let stencil = region(vk::ImageAspectFlags::STENCIL, offset);

            let mut make = |suffix: &str, regions: Vec<BufferImageCopy>, single_command: bool| {
                group.add_child(Box::new(CopyBufferToDepthStencilCase {
                    name: format!("{prefix}{format_name}{suffix}"),
                    src_buffer_size,
                    dst: ImageParms {
                        image_type: vk::ImageType::_2D,
                        format,
                        extent: DEFAULT_EXTENT,
                        tiling: vk::ImageTiling::OPTIMAL,
                        fill_mode: FillMode::Gradient,
                        create_flags: None,
                    },
                    regions,
                    single_command,
                    allocation_kind: gp.allocation_kind,
                    command_variant: gp.command_variant,
                    queue_selection: gp.queue_selection,
                    general_layout: gp.general_layout,
                }) as Box<dyn TestCase>);
            };

            // The four combined variants are the two aspect orders crossed with whether
            // they go in one command or two - which is what the names spell out.
            if has_depth && has_stencil {
                make("_DS", vec![depth, stencil], true);
                make("_D_S", vec![depth, stencil], false);
                make("_S_D", vec![stencil, depth], false);
                make("_SD", vec![stencil, depth], true);
            }
            if has_stencil {
                make("_S", vec![stencil], false);
            }
            if has_depth {
                make("_D", vec![depth], false);
            }
        }
    }
}

/// The `buffer_to_depthstencil*` groups.
pub fn add_buffer_to_depth_stencil_groups(
    parent: &mut tcu::TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
) {
    let mut group = tcu::TestCaseGroup::new(name);
    add_copy_buffer_to_depth_stencil_tests(
        &mut group,
        &GroupParams {
            allocation_kind,
            command_variant,
            queue_selection,
            general_layout,
        },
    );
    parent.add_child(group);
}

// ---------------------------------------------------------------------------------
// CopyDepthStencilToBuffer - the mirror of the above.
// ---------------------------------------------------------------------------------

/// `CopyDepthStencilToBufferTestCase`
pub struct CopyDepthStencilToBufferCase {
    name: String,
    src: ImageParms,
    dst_buffer_size: u32,
    regions: Vec<BufferImageCopy>,
    single_command: bool,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
}

impl TestCase for CopyDepthStencilToBufferCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        select_queue(context, self.queue_selection)?;

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.src.format,
                self.src.image_type,
                self.src.tiling,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format not supported".to_string()))?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyDepthStencilToBufferInstance { context, params: self })
    }
}

struct CopyDepthStencilToBufferInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CopyDepthStencilToBufferCase,
}

/// `CopyDepthStencilToBuffer::copyRegionToTextureLevel` - one aspect of the image into
/// the matching aspect of a flat destination run.
fn copy_ds_region_to_buffer_level(src: &ConstPixelBufferAccess<'_>, dst: &mut TextureLevel, region: BufferImageCopy, divisor: usize) {
    let row_length = if region.buffer_row_length == 0 {
        region.image_extent[0]
    } else {
        region.buffer_row_length
    };
    let image_height = if region.buffer_image_height == 0 {
        region.image_extent[1]
    } else {
        region.buffer_image_height
    };
    let texel_offset = (region.buffer_offset / divisor as u64) as u32;
    let depth = region.aspect_mask == vk::ImageAspectFlags::DEPTH;

    for z in 0..region.image_extent[2] {
        for y in 0..region.image_extent[1] {
            let texel_index = texel_offset + (z * image_height + y) * row_length;
            for x in 0..region.image_extent[0] {
                let sx = region.image_offset[0] as u32 + x;
                let sy = region.image_offset[1] as u32 + y;
                let sz = region.image_offset[2] as u32 + z;
                if depth {
                    let v = src.get_pix_depth(sx, sy, sz);
                    dst.get_access().set_pix_depth(v, texel_index + x, 0, 0);
                } else {
                    let v = src.get_pix_stencil(sx, sy, sz);
                    dst.get_access().set_pix_stencil(v, texel_index + x, 0, 0);
                }
            }
        }
    }
}

/// `tcu::clearDepth` / `tcu::clearStencil` over a whole level.
fn clear_aspect(level: &mut TextureLevel, depth: bool) {
    let [w, h, d] = level.size();
    for z in 0..d {
        for y in 0..h {
            for x in 0..w {
                if depth {
                    level.get_access().set_pix_depth(0.0, x, y, z);
                } else {
                    level.get_access().set_pix_stencil(0, x, y, z);
                }
            }
        }
    }
}

impl TestInstance for CopyDepthStencilToBufferInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;
        let mut families = vec![self.context.get_universal_queue_family_index()];
        if queue_family_index != families[0] {
            families.push(queue_family_index);
        }

        let texture_format = map_vk_format(p.src.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let texels = p.dst_buffer_size;

        let mut source_level = TextureLevel::new(texture_format, p.src.extent[0], p.src.extent[1], p.src.extent[2])?;
        generate_buffer(&mut source_level.get_access(), p.src.extent[0], p.src.extent[1], p.src.extent[2], FillMode::Gradient, false);

        let mut destination_level = TextureLevel::new(texture_format, texels, 1, 1)?;
        generate_buffer(&mut destination_level.get_access(), texels, 1, 1, FillMode::Gradient, false);

        let depth_format = map_combined_to_depth_transfer_format(texture_format);
        let stencil_format = get_stencil_copy_format(p.src.format);
        let depth_texel = depth_format.and_then(|f| f.pixel_size()).unwrap_or(1) as usize;
        let stencil_texel = stencil_format.and_then(|f| f.pixel_size()).unwrap_or(1) as usize;

        // The destination is packed single-aspect runs, so a region's offset counts in
        // that aspect's texels, not the combined ones.
        let mut expected_level = TextureLevel::new(texture_format, texels, 1, 1)?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        for region in &p.regions {
            let divisor = if region.aspect_mask == vk::ImageAspectFlags::DEPTH {
                depth_texel
            } else {
                stencil_texel
            };
            copy_ds_region_to_buffer_level(&source_level.get_const_access(), &mut expected_level, *region, divisor);
        }

        // The buffer starts out holding the packed initial data, laid out in region
        // order, and the copy overwrites part of it.
        let mut packed: Vec<u8> = Vec::new();
        let mut device_regions: Vec<BufferImageCopy> = Vec::new();
        let (mut depth_offset, mut stencil_offset) = (None::<u64>, None::<u64>);
        for region in &p.regions {
            let mut r = *region;
            if r.aspect_mask == vk::ImageAspectFlags::DEPTH {
                if depth_offset.is_none() {
                    let mut level = TextureLevel::new(depth_format.ok_or_else(|| TestError::NotSupported("no depth transfer format".to_string()))?, texels, 1, 1)?;
                    transfer_aspect(&mut destination_level, vk::ImageAspectFlags::DEPTH, &mut level, true);
                    depth_offset = Some(packed.len() as u64);
                    packed.extend_from_slice(level.data());
                }
                r.buffer_offset += depth_offset.expect("just set");
            } else {
                if stencil_offset.is_none() {
                    let mut level = TextureLevel::new(
                        stencil_format.ok_or_else(|| TestError::NotSupported("no stencil transfer format".to_string()))?,
                        texels,
                        1,
                        1,
                    )?;
                    transfer_aspect(&mut destination_level, vk::ImageAspectFlags::STENCIL, &mut level, true);
                    stencil_offset = Some(packed.len() as u64);
                    packed.extend_from_slice(level.data());
                }
                r.buffer_offset += stencil_offset.expect("just set");
            }
            device_regions.push(r);
        }

        let dst_info = staging_buffer_create_info(packed.len() as u64, vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC, &families);
        let destination = unsafe { vk_device.create_buffer(&dst_info, None) }.vk_check("vkCreateBuffer")?;
        let destination = Unique::new(vk_device, destination);
        let destination_alloc = bind_buffer_memory(self.context, *destination, p.allocation_kind)?;
        unsafe { std::ptr::copy_nonoverlapping(packed.as_ptr(), destination_alloc.get_host_ptr(), packed.len()) };
        flush_alloc(vk_device, &destination_alloc)?;

        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: p.src.image_type,
            format: p.src.format,
            extent: p.src.extent_3d(),
            mip_levels: 1,
            array_layers: p.src.array_size(),
            samples: vk::SampleCountFlags::_1,
            tiling: p.src.tiling,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let source = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        };

        upload_image(self.context, &source_level.get_const_access(), source.get(), &p.src, p.general_layout, &families, false)?;

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        };
        let old_layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let range = make_image_subresource_range(get_aspect_flags(p.src.format), 0, 1, 0, p.src.array_size());

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let barrier = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ, old_layout, layout, source.get(), range);
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );

            let copies: Vec<vk::BufferImageCopy> = device_regions.iter().map(|r| r.to_vk()).collect();
            let batches: Vec<&[vk::BufferImageCopy]> = if p.single_command { vec![&copies] } else { copies.chunks(1).collect() };
            for batch in batches {
                if p.command_variant == CopyCommandVariant::CopyCommands2 {
                    let copies2: Vec<vk::BufferImageCopy2> = batch
                        .iter()
                        .map(|c| vk::BufferImageCopy2 {
                            s_type: vk::StructureType::BUFFER_IMAGE_COPY_2,
                            next: std::ptr::null(),
                            buffer_offset: c.buffer_offset,
                            buffer_row_length: c.buffer_row_length,
                            buffer_image_height: c.buffer_image_height,
                            image_subresource: c.image_subresource,
                            image_offset: c.image_offset,
                            image_extent: c.image_extent,
                        })
                        .collect();
                    let info = vk::CopyImageToBufferInfo2 {
                        s_type: vk::StructureType::COPY_IMAGE_TO_BUFFER_INFO_2,
                        next: std::ptr::null(),
                        src_image: source.get(),
                        src_image_layout: layout,
                        dst_buffer: *destination,
                        region_count: copies2.len() as u32,
                        regions: copies2.as_ptr(),
                    };
                    vk_device.cmd_copy_image_to_buffer2(*cmd_buffer, &info);
                } else {
                    vk_device.cmd_copy_image_to_buffer(*cmd_buffer, source.get(), layout, *destination, batch);
                }
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        invalidate_alloc(vk_device, &destination_alloc)?;
        let raw = unsafe { std::slice::from_raw_parts(destination_alloc.get_host_ptr().cast_const(), packed.len()) }.to_vec();

        // Reassemble the packed runs back into a combined level so the two sides can be
        // compared in the same layout.
        let mut result_level = TextureLevel::new(texture_format, texels, 1, 1)?;
        for (aspect, base, format) in [
            (vk::ImageAspectFlags::DEPTH, depth_offset, depth_format),
            (vk::ImageAspectFlags::STENCIL, stencil_offset, stencil_format),
        ] {
            let (Some(base), Some(format)) = (base, format) else { continue };
            let mut level = TextureLevel::new(format, texels, 1, 1)?;
            let len = level.data().len();
            level.data_mut().copy_from_slice(&raw[base as usize..base as usize + len]);
            transfer_aspect(&mut result_level, aspect, &mut level, false);
        }

        // A combined format has both aspects compared even when only one was copied, so
        // the untouched one is cleared on both sides rather than left to differ.
        let aspects = get_aspect_flags(p.src.format);
        if aspects.contains(vk::ImageAspectFlags::DEPTH) && depth_offset.is_none() {
            clear_aspect(&mut expected_level, true);
            clear_aspect(&mut result_level, true);
        }
        if aspects.contains(vk::ImageAspectFlags::STENCIL) && stencil_offset.is_none() {
            clear_aspect(&mut expected_level, false);
            clear_aspect(&mut result_level, false);
        }

        Ok(check_test_result(&expected_level.get_const_access(), &result_level.get_const_access()))
    }
}

/// `addCopyDepthStencilToBufferTests`
fn add_copy_depth_stencil_to_buffer_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    // Same seven formats, listed in this group's own order.
    static FORMATS: &[(vk::Format, &str)] = &[
        (vk::Format::S8_UINT, "s8_uint"),
        (vk::Format::D16_UNORM, "d16_unorm"),
        (vk::Format::X8_D24_UNORM_PACK32, "x8_d24_unorm_pack32"),
        (vk::Format::D32_SFLOAT, "d32_sfloat"),
        (vk::Format::D16_UNORM_S8_UINT, "d16_unorm_s8_uint"),
        (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
        (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
    ];

    let region = |aspect: vk::ImageAspectFlags, offset: bool| BufferImageCopy {
        aspect_mask: aspect,
        buffer_offset: if offset { 32 } else { 0 },
        buffer_row_length: if offset { DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE } else { 0 },
        buffer_image_height: if offset { DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE } else { 0 },
        base_array_layer: 0,
        layer_count: 1,
        image_offset: if offset {
            [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0]
        } else {
            [0, 0, 0]
        },
        image_extent: if offset { DEFAULT_HALF_EXTENT } else { DEFAULT_EXTENT },
    };

    for &(format, format_name) in FORMATS {
        for offset in [false, true] {
            let aspects = get_aspect_flags(format);
            let has_depth = aspects.contains(vk::ImageAspectFlags::DEPTH);
            let has_stencil = aspects.contains(vk::ImageAspectFlags::STENCIL);

            let dst_buffer_size = if offset {
                (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE
            } else {
                DEFAULT_SIZE * DEFAULT_SIZE
            };
            let prefix = if offset { "buffer_offset_" } else { "" };
            let depth = region(vk::ImageAspectFlags::DEPTH, offset);
            let stencil = region(vk::ImageAspectFlags::STENCIL, offset);

            let mut make = |suffix: &str, regions: Vec<BufferImageCopy>, single_command: bool| {
                group.add_child(Box::new(CopyDepthStencilToBufferCase {
                    name: format!("{prefix}{format_name}{suffix}"),
                    src: ImageParms {
                        image_type: vk::ImageType::_2D,
                        format,
                        extent: DEFAULT_EXTENT,
                        tiling: vk::ImageTiling::OPTIMAL,
                        fill_mode: FillMode::Gradient,
                        create_flags: None,
                    },
                    dst_buffer_size,
                    regions,
                    single_command,
                    allocation_kind: gp.allocation_kind,
                    command_variant: gp.command_variant,
                    queue_selection: gp.queue_selection,
                    general_layout: gp.general_layout,
                }) as Box<dyn TestCase>);
            };

            if has_depth && has_stencil {
                make("_DS", vec![depth, stencil], true);
                make("_D_S", vec![depth, stencil], false);
                make("_SD", vec![stencil, depth], false);
                make("_SD_combined", vec![stencil, depth], true);
            }
            if has_depth {
                make("_D", vec![depth], false);
            }
            if has_stencil {
                make("_S", vec![stencil], false);
            }
        }
    }
}

/// The `depthstencil_to_buffer*` groups.
pub fn add_depth_stencil_to_buffer_groups(
    parent: &mut tcu::TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
) {
    let mut group = tcu::TestCaseGroup::new(name);
    add_copy_depth_stencil_to_buffer_tests(
        &mut group,
        &GroupParams {
            allocation_kind,
            command_variant,
            queue_selection,
            general_layout,
        },
    );
    parent.add_child(group);
}

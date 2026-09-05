// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiBlittingTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiCopiesAndBlittingUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Unlike a copy, a blit has no byte-exact reference: the driver picks the source texel
// from a coordinate it computes at a precision the spec leaves open. So `checkTestResult`
// for VK_FILTER_NEAREST asks, for every destination pixel, whether *some* texel the
// coordinate could legally have landed on explains the result - `tcu::tex_verifier`.
//
// Ported so far: every VK_FILTER_NEAREST case of simple_tests and of
// all_formats.color that has an uncompressed source format. LINEAR and CUBIC need two
// reference images built with a scaled filter (`checkNonNearestFilteredResult`), which
// is not ported; the array-to-3D groups, the compressed source formats and
// all_formats.depth_stencil are not registered either.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use super::copies_buffer_tests::{AllocationKind, CopyCommandVariant};
use super::copies_image_tests::{FillMode, GroupParams, ImageParms, generate_buffer, get_aspect_flags, is_supported_by_framework, read_image, upload_image};
use super::copy_format_lists::{BlitFormat, COMPATIBLE_FORMATS_FLOATS, COMPATIBLE_FORMATS_S_INTS, COMPATIBLE_FORMATS_SRGB, COMPATIBLE_FORMATS_U_INTS, DEPTH_AND_STENCIL_FORMATS};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, DepthStencilMode, FilterMode, PixelBufferAccess, Sampler, TextureLevel, get_effective_depth_stencil_access, get_effective_depth_stencil_access_mut,
    get_effective_depth_stencil_texture_format, get_texture_format_bit_depth, get_texture_format_mantissa_bit_depth, has_depth_component, has_stencil_component,
    is_combined_depth_stencil_type, linear_to_srgb_if_needed,
};
use crate::tcu::tex_verifier::{LookupPrecision, is_nearest_sample_result_valid_float, is_nearest_sample_result_valid_int, srgb_to_linear};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};
use crate::tcu::{self, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// `defaultSize`
const DEFAULT_SIZE: i32 = 64;
/// `defaultHalfSize`
const DEFAULT_HALF_SIZE: i32 = DEFAULT_SIZE / 2;
/// `defaultQuarterSize`
const DEFAULT_QUARTER_SIZE: i32 = DEFAULT_SIZE / 4;
/// `defaultSixteenthSize`
const DEFAULT_SIXTEENTH_SIZE: i32 = DEFAULT_SIZE / 16;

/// `CopyRegion::imageBlit`, narrowed to the single-layer blits the ported subgroups
/// use - every one of them passes the same subresource layers on both sides, differing
/// only in the aspect.
#[derive(Clone, Copy)]
pub struct ImageBlit {
    pub src_offsets: [[i32; 3]; 2],
    pub dst_offsets: [[i32; 3]; 2],
    /// `defaultSourceLayer`'s aspect, or the depth/stencil one the depth_stencil group
    /// names per region.
    pub aspect_mask: vk::ImageAspectFlags,
}

impl ImageBlit {
    fn color(src_offsets: [[i32; 3]; 2], dst_offsets: [[i32; 3]; 2]) -> Self {
        Self {
            src_offsets,
            dst_offsets,
            aspect_mask: vk::ImageAspectFlags::COLOR,
        }
    }

    fn to_vk(self) -> vk::ImageBlit {
        let layers = vk::ImageSubresourceLayers {
            aspect_mask: self.aspect_mask,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };
        let off = |o: [i32; 3]| vk::Offset3D { x: o[0], y: o[1], z: o[2] };
        vk::ImageBlit {
            src_subresource: layers,
            src_offsets: [off(self.src_offsets[0]), off(self.src_offsets[1])],
            dst_subresource: layers,
            dst_offsets: [off(self.dst_offsets[0]), off(self.dst_offsets[1])],
        }
    }

    /// `CompareEachPixelInEachRegion::getUsedZRange` for a single-layer blit. A 2D
    /// image's z range comes from the subresource layers, not from the offsets - the
    /// offsets' z is required to be 0..1 there and says nothing about which layer.
    fn used_z_range(offsets: [[i32; 3]; 2], image_type: vk::ImageType) -> [i32; 2] {
        match image_type {
            vk::ImageType::_3D => [offsets[0][2], offsets[1][2]],
            vk::ImageType::_2D => [0, 1],
            _ => [0, 1],
        }
    }
}

/// `vkt::api::isFloatFormat`
///
/// Not `vk::isFloatFormat(mapTextureFormat(format))`: a single aspect of a combined
/// depth/stencil format has no VkFormat to map back to.
fn is_float_format(format: TextureFormat) -> bool {
    format.channel_class() == TextureChannelClass::FloatingPoint
}

/// `calculateFloatConversionError`
fn calculate_float_conversion_error(src_bits: i32) -> f32 {
    if src_bits > 0 {
        let clamped_bits = src_bits.clamp(0, 32);
        let src_max_value = (((1u64 << clamped_bits) - 1) as f32).max(1.0);
        (1.0 / src_max_value).clamp(0.0, 1.0)
    } else {
        1.0
    }
}

/// `getFormatThreshold`
fn get_format_threshold(format: TextureFormat) -> [f32; 4] {
    let threshold = match format.type_ {
        ChannelType::HALF_FLOAT => [0.005; 4],
        ChannelType::FLOAT | ChannelType::FLOAT64 => [0.001; 4],
        ChannelType::UNSIGNED_INT_11F_11F_10F_REV => [0.02, 0.02, 0.0625, 1.0],
        ChannelType::UNSIGNED_INT_999_E5_REV => [0.05, 0.05, 0.05, 1.0],
        ChannelType::UNORM_INT_1010102_REV => [0.002, 0.002, 0.002, 0.3],
        ChannelType::UNORM_INT8 => [0.008; 4],
        _ => {
            let bits = get_texture_format_mantissa_bit_depth(format);
            std::array::from_fn(|c| calculate_float_conversion_error(bits[c]))
        }
    };

    if format.order == ChannelOrder::BGR || format.order == ChannelOrder::BGRA {
        [threshold[2], threshold[1], threshold[0], threshold[3]]
    } else {
        threshold
    }
}

/// `getFloatOrFixedPointFormatThreshold`
fn get_float_or_fixed_point_format_threshold(format: TextureFormat) -> [f32; 4] {
    let channel_class = format.channel_class();
    let bit_depth = get_texture_format_bit_depth(format);

    match channel_class {
        TextureChannelClass::FloatingPoint => get_format_threshold(format),
        TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint => {
            let range = if channel_class == TextureChannelClass::SignedFixedPoint { 2.0 } else { 1.0 };
            // An absent channel gets 1.0, not 0.0 - it is masked out of the comparison
            // anyway, and a zero threshold there would be a trap if it ever were not.
            std::array::from_fn(|c| if bit_depth[c] == 0 { 1.0 } else { range / (((1u64 << bit_depth[c]) - 1) as f32) })
        }
        _ => [0.0; 4],
    }
}

/// `CompareEachPixelInEachRegion::forEach`
fn for_each_pixel_in_each_region(
    params: &BlitImageCase,
    source_width: i32,
    source_height: i32,
    source_depth: i32,
    mut compare: impl FnMut(i32, i32, i32, [f32; 3]) -> bool,
) -> bool {
    let mut compare_ok = true;

    for blit in &params.regions {
        let src_z = ImageBlit::used_z_range(blit.src_offsets, params.src.image_type);
        let dst_z = ImageBlit::used_z_range(blit.dst_offsets, params.dst.image_type);

        let x_start = blit.dst_offsets[0][0].min(blit.dst_offsets[1][0]);
        let y_start = blit.dst_offsets[0][1].min(blit.dst_offsets[1][1]);
        let z_start = dst_z[0].min(dst_z[1]);
        let x_end = blit.dst_offsets[0][0].max(blit.dst_offsets[1][0]);
        let y_end = blit.dst_offsets[0][1].max(blit.dst_offsets[1][1]);
        let z_end = dst_z[0].max(dst_z[1]);

        // The scales are signed, which is how a mirrored blit falls out of the same
        // formula instead of needing a case of its own.
        let x_scale = (blit.src_offsets[1][0] - blit.src_offsets[0][0]) as f32 / (blit.dst_offsets[1][0] - blit.dst_offsets[0][0]) as f32;
        let y_scale = (blit.src_offsets[1][1] - blit.src_offsets[0][1]) as f32 / (blit.dst_offsets[1][1] - blit.dst_offsets[0][1]) as f32;
        let z_scale = (src_z[1] - src_z[0]) as f32 / (dst_z[1] - dst_z[0]) as f32;
        let src_inv_w = 1.0 / source_width as f32;
        let src_inv_h = 1.0 / source_height as f32;
        let src_inv_d = 1.0 / source_depth as f32;

        for z in z_start..z_end {
            for y in y_start..y_end {
                for x in x_start..x_end {
                    let src_norm_coord = [
                        (x_scale * ((x - blit.dst_offsets[0][0]) as f32 + 0.5) + blit.src_offsets[0][0] as f32) * src_inv_w,
                        (y_scale * ((y - blit.dst_offsets[0][1]) as f32 + 0.5) + blit.src_offsets[0][1] as f32) * src_inv_h,
                        (z_scale * ((z - dst_z[0]) as f32 + 0.5) + src_z[0] as f32) * src_inv_d,
                    ];

                    if !compare(x, y, z, src_norm_coord) {
                        compare_ok = false;
                    }
                }
            }
        }
    }
    compare_ok
}

/// `floatNearestBlitCompare`
fn float_nearest_blit_compare(
    source: &ConstPixelBufferAccess<'_>,
    result: &ConstPixelBufferAccess<'_>,
    source_threshold: [f32; 4],
    result_threshold: [f32; 4],
    params: &BlitImageCase,
) -> bool {
    let dst_bit_depth = get_texture_format_bit_depth(result.format());
    let precision = LookupPrecision {
        color_mask: std::array::from_fn(|c| dst_bit_depth[c] != 0),
        ..LookupPrecision::default()
    };
    let color_threshold: [f32; 4] = std::array::from_fn(|c| source_threshold[c].max(result_threshold[c]));
    let is_srgb = result.format().order.is_srgb();

    let [w, h, d] = source.size();
    for_each_pixel_in_each_region(params, w as i32, h as i32, d as i32, |x, y, z, src_norm_coord| {
        let mut dst_color = result.get_pixel(x as u32, y as u32, z as u32);

        // TexLookupVerifier performs a conversion to linear space, so we have to as well
        if is_srgb {
            dst_color = srgb_to_linear(dst_color);
        }

        is_nearest_sample_result_valid_float(source, &precision, color_threshold, src_norm_coord, dst_color)
    })
}

/// `intNearestBlitCompare`
fn int_nearest_blit_compare(source: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>, params: &BlitImageCase) -> Result<bool, TestError> {
    let src_bit_depth = get_texture_format_bit_depth(source.format());
    let dst_bit_depth = get_texture_format_bit_depth(result.format());
    let precision = LookupPrecision {
        color_mask: std::array::from_fn(|c| dst_bit_depth[c] != 0),
        ..LookupPrecision::default()
    };
    let color_threshold: [u32; 4] = std::array::from_fn(|c| (src_bit_depth[c] / 8).max(dst_bit_depth[c] / 8).max(1) as u32);

    // Prepare a source image with a matching (converted) pixel format. Ideally, we would've used a wrapper that
    // does the conversion on the fly without wasting memory, but this approach is more straightforward.
    let [w, h, d] = source.size();
    let mut converted_source_texture = TextureLevel::new(result.format(), w, h, d)?;
    {
        let mut converted_source = converted_source_texture.get_access();
        for z in 0..d {
            for y in 0..h {
                for x in 0..w {
                    // will be clamped to max. representable value
                    if !converted_source.set_pixel_int(source.get_pixel_int(x, y, z), x, y, z) {
                        return Err(TestError::NotPorted(format!("integer write path for {:?}", result.format())));
                    }
                }
            }
        }
    }
    let converted_source = converted_source_texture.get_const_access();

    Ok(for_each_pixel_in_each_region(params, w as i32, h as i32, d as i32, |x, y, z, src_norm_coord| {
        let dst_color = result.get_pixel_int(x as u32, y as u32, z as u32);
        is_nearest_sample_result_valid_int(&converted_source, &precision, color_threshold, src_norm_coord, dst_color)
    }))
}

/// The two reference images a non-nearest blit is checked against.
struct ExpectedLevels {
    clamped: TextureLevel,
    unclamped: TextureLevel,
}

/// `MirrorModeBits`
const MIRROR_MODE_X: u32 = 1 << 0;
const MIRROR_MODE_Y: u32 = 1 << 1;
const MIRROR_MODE_Z: u32 = 1 << 2;

/// `getMirrorMode(from, to)`
fn get_mirror_mode_pair(from: [i32; 3], to: [i32; 3]) -> u32 {
    let mut mode = 0;
    if from[0] > to[0] {
        mode |= MIRROR_MODE_X;
    }
    if from[1] > to[1] {
        mode |= MIRROR_MODE_Y;
    }
    if from[2] > to[2] {
        mode |= MIRROR_MODE_Z;
    }
    mode
}

/// `getMirrorMode(s1, s2, d1, d2)` - an axis is mirrored when the two sides disagree
/// about its direction, so a blit that reverses both is not a mirror at all.
fn get_mirror_mode(s1: [i32; 3], s2: [i32; 3], d1: [i32; 3], d2: [i32; 3]) -> u32 {
    let source = get_mirror_mode_pair(s1, s2);
    let destination = get_mirror_mode_pair(d1, d2);
    let mut mode = 0;
    for bit in [MIRROR_MODE_X, MIRROR_MODE_Y, MIRROR_MODE_Z] {
        if (source & bit) != (destination & bit) {
            mode |= bit;
        }
    }
    mode
}

/// `flipCoordinates`
fn flip_coordinates(region: &mut ImageBlit, mirror_mode: u32) {
    if mirror_mode == 0 {
        return;
    }
    let (s0, s1) = (region.src_offsets[0], region.src_offsets[1]);
    let (d0, d1) = (region.dst_offsets[0], region.dst_offsets[1]);
    region.src_offsets = [std::array::from_fn(|c| s0[c].min(s1[c])), std::array::from_fn(|c| s0[c].max(s1[c]))];
    region.dst_offsets = [std::array::from_fn(|c| d0[c].min(d1[c])), std::array::from_fn(|c| d0[c].max(d1[c]))];
}

/// `vkt::api::blit` - the clamped reference, sampled inside the source subregion so
/// its edges clamp to the region rather than to the whole image.
fn blit_reference(dst: &mut PixelBufferAccess<'_>, src: &ConstPixelBufferAccess<'_>, filter: FilterMode, mirror_mode: u32) {
    let sampler = Sampler::clamp_to_edge(filter);
    let [sw, sh, sd] = src.size();
    let [dw, dh, dd] = dst.size();

    let s_x = sw as f32 / dw as f32;
    let s_y = sh as f32 / dh as f32;
    let s_z = sd as f32 / dd as f32;

    let (x_offset, x_scale) = if mirror_mode & MIRROR_MODE_X != 0 { (dw as i32 - 1, -1) } else { (0, 1) };
    let (y_offset, y_scale) = if mirror_mode & MIRROR_MODE_Y != 0 { (dh as i32 - 1, -1) } else { (0, 1) };
    let (z_offset, z_scale) = if mirror_mode & MIRROR_MODE_Z != 0 { (dd as i32 - 1, -1) } else { (0, 1) };
    let dst_format = dst.format();

    for z in 0..dd {
        for y in 0..dh {
            for x in 0..dw {
                let c = src.sample_3d(&sampler, (x as f32 + 0.5) * s_x, (y as f32 + 0.5) * s_y, (z as f32 + 0.5) * s_z);
                dst.set_pixel(
                    linear_to_srgb_if_needed(dst_format, c),
                    (x as i32 * x_scale + x_offset) as u32,
                    (y as i32 * y_scale + y_offset) as u32,
                    (z as i32 * z_scale + z_offset) as u32,
                );
            }
        }
    }
}

/// `scaleFromWholeSrcBuffer` - the same reference sampled from the *whole* source, so
/// a texel at the region's edge blends with what lies outside it. A driver may legally
/// do either, which is why the check accepts the result if it matches this or the
/// clamped one.
fn scale_from_whole_src_buffer(
    dst: &mut PixelBufferAccess<'_>,
    src: &ConstPixelBufferAccess<'_>,
    region_offset: [i32; 3],
    region_extent: [i32; 3],
    filter: FilterMode,
    mirror_mode: u32,
) {
    let sampler = Sampler::clamp_to_edge(filter);
    let [dw, dh, dd] = dst.size();

    let s_x = region_extent[0] as f32 / dw as f32;
    let s_y = region_extent[1] as f32 / dh as f32;
    let s_z = region_extent[2] as f32 / dd as f32;
    let dst_format = dst.format();

    for z in 0..dd {
        for y in 0..dh {
            for x in 0..dw {
                let coord = |i: u32, s: f32, axis: usize, bit: u32| {
                    if mirror_mode & bit != 0 {
                        region_extent[axis] as f32 + region_offset[axis] as f32 - (i as f32 + 0.5) * s
                    } else {
                        region_offset[axis] as f32 + (i as f32 + 0.5) * s
                    }
                };
                let src_x = coord(x, s_x, 0, MIRROR_MODE_X);
                let src_y = coord(y, s_y, 1, MIRROR_MODE_Y);
                let src_z = coord(z, s_z, 2, MIRROR_MODE_Z);
                let c = if dd > 1 {
                    src.sample_3d(&sampler, src_x, src_y, src_z)
                } else {
                    src.sample_2d(&sampler, src_x, src_y, 0)
                };
                dst.set_pixel(linear_to_srgb_if_needed(dst_format, c), x, y, z);
            }
        }
    }
}

/// `tcu::floatThresholdCompare`
fn float_threshold_compare(reference: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>, threshold: [f32; 4]) -> bool {
    let [w, h, d] = reference.size();
    for z in 0..d {
        for y in 0..h {
            for x in 0..w {
                let r = reference.get_pixel(x, y, z);
                let c = result.get_pixel(x, y, z);
                // Negated rather than `>`: a NaN difference must fail, and `>` would
                // let it through.
                if !(0..4).all(|i| (r[i] - c[i]).abs() <= threshold[i]) {
                    return false;
                }
            }
        }
    }
    true
}

/// `tcu::intThresholdCompare`, the 32-bit form the blit checks call.
fn int_threshold_compare(reference: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>, threshold: [u32; 4]) -> bool {
    let [w, h, d] = reference.size();
    for z in 0..d {
        for y in 0..h {
            for x in 0..w {
                let r = reference.get_pixel_int(x, y, z);
                let c = result.get_pixel_int(x, y, z);
                if (0..4).any(|i| r[i].abs_diff(c[i]) > threshold[i]) {
                    return false;
                }
            }
        }
    }
    true
}

/// `BlitImageTestCase`
pub struct BlitImageCase {
    name: String,
    src: ImageParms,
    dst: ImageParms,
    src_operation_layout: vk::ImageLayout,
    dst_operation_layout: vk::ImageLayout,
    regions: Vec<ImageBlit>,
    filter: vk::Filter,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    /// `SEPARATE_DEPTH_STENCIL_LAYOUT` - the two aspects are transitioned one at a
    /// time on upload instead of together.
    separate_depth_stencil_layouts: bool,
}

impl TestCase for BlitImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let phys_device = context.get_physical_device();

        for (parms, usage, msg) in [
            (&self.src, vk::ImageUsageFlags::TRANSFER_SRC, "Source format not supported"),
            (&self.dst, vk::ImageUsageFlags::TRANSFER_DST, "Destination format not supported"),
        ] {
            unsafe { instance.get_physical_device_image_format_properties(phys_device, parms.format, parms.image_type, parms.tiling, usage, vk::ImageCreateFlags::empty()) }
                .map_err(|_| TestError::NotSupported(msg.to_string()))?;
        }

        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.separate_depth_stencil_layouts {
            context.require_device_functionality("VK_KHR_separate_depth_stencil_layouts")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }

        let features = |parms: &ImageParms| {
            let props = unsafe { instance.get_physical_device_format_properties(phys_device, parms.format) };
            if parms.tiling == vk::ImageTiling::LINEAR {
                props.linear_tiling_features
            } else {
                props.optimal_tiling_features
            }
        };
        let src_format_features = features(&self.src);
        if !src_format_features.contains(vk::FormatFeatureFlags::BLIT_SRC) {
            return Err(TestError::NotSupported("Format feature blit source not supported".to_string()));
        }
        if !features(&self.dst).contains(vk::FormatFeatureFlags::BLIT_DST) {
            return Err(TestError::NotSupported("Format feature blit destination not supported".to_string()));
        }
        if self.filter == vk::Filter::LINEAR && !src_format_features.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR) {
            return Err(TestError::NotSupported("Source format feature sampled image filter linear not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BlittingImages { context, params: self })
    }
}

/// `BlittingImages`
struct BlittingImages<'a> {
    context: &'a Context<'a>,
    params: &'a BlitImageCase,
}

/// `BlittingImages::copyRegionToTextureLevel`
///
/// Builds both references for one region: `clamped` samples inside the source
/// subregion, `unclamped` from the whole source image.
fn copy_region_to_texture_level(
    src: &ConstPixelBufferAccess<'_>,
    expected: &mut ExpectedLevels,
    region: ImageBlit,
    filter: FilterMode,
    src_image_type: vk::ImageType,
    dst_image_type: vk::ImageType,
) {
    let mut region = region;
    let mirror_mode = get_mirror_mode(region.src_offsets[0], region.src_offsets[1], region.dst_offsets[0], region.dst_offsets[1]);
    flip_coordinates(&mut region, mirror_mode);

    let mut src_offset = region.src_offsets[0];
    let mut src_extent: [i32; 3] = std::array::from_fn(|c| region.src_offsets[1][c] - src_offset[c]);
    let mut dst_offset = region.dst_offsets[0];
    let mut dst_extent: [i32; 3] = std::array::from_fn(|c| region.dst_offsets[1][c] - dst_offset[c]);

    // A 2D side addresses its slice through the subresource layers, so the z axis of
    // the host reference has to be taken from there instead of from the offsets. Only
    // the array-to-3D groups exercise this; every other blit has one layer at zero.
    if src_image_type == vk::ImageType::_2D {
        src_offset[2] = 0;
        src_extent[2] = 1;
    }
    if dst_image_type == vk::ImageType::_2D {
        dst_offset[2] = 0;
        dst_extent[2] = 1;
    }

    // flipCoordinates is not detailed enough for what follows: the extent is used to
    // take subregions, so it has to be positive.
    let mut src_region_offset = src_offset;
    let mut src_region_extent = src_extent;
    let mut dst_region_offset = dst_offset;
    let mut dst_region_extent = dst_extent;
    for c in 0..3 {
        if src_region_extent[c] < 0 {
            src_region_extent[c] = -src_region_extent[c];
            src_region_offset[c] = region.src_offsets[1][c];
        }
        if dst_region_extent[c] < 0 {
            dst_region_extent[c] = -dst_region_extent[c];
            dst_region_offset[c] = region.dst_offsets[1][c];
        }
    }

    let u = |v: [i32; 3]| [v[0] as u32, v[1] as u32, v[2] as u32];
    let (so, se) = (u(src_region_offset), u(src_region_extent));
    let (dfo, de) = (u(dst_region_offset), u(dst_region_extent));

    if is_combined_depth_stencil_type(src.format().type_) {
        for (mode, present) in [
            (DepthStencilMode::Depth, has_depth_component(src.format().order)),
            (DepthStencilMode::Stencil, has_stencil_component(src.format().order)),
        ] {
            if !present {
                continue;
            }
            let src_sub_combined = src.get_subregion(so[0], so[1], so[2], se[0], se[1], se[2]);
            let src_sub = get_effective_depth_stencil_access(&src_sub_combined, mode);
            {
                let mut clamped = expected.clamped.get_access();
                let mut dst_sub_combined = clamped.get_subregion(dfo[0], dfo[1], dfo[2], de[0], de[1], de[2]);
                let mut dst_sub = get_effective_depth_stencil_access_mut(&mut dst_sub_combined, mode);
                blit_reference(&mut dst_sub, &src_sub, filter, mirror_mode);
            }
            if filter != FilterMode::Nearest {
                let aspect_src = get_effective_depth_stencil_access(src, mode);
                let mut unclamped = expected.unclamped.get_access();
                let mut dst_sub_combined = unclamped.get_subregion(dfo[0], dfo[1], dfo[2], de[0], de[1], de[2]);
                let mut dst_sub = get_effective_depth_stencil_access_mut(&mut dst_sub_combined, mode);
                scale_from_whole_src_buffer(&mut dst_sub, &aspect_src, src_offset, src_extent, filter, mirror_mode);
            }
        }
    } else {
        {
            let src_sub = src.get_subregion(so[0], so[1], so[2], se[0], se[1], se[2]);
            let mut clamped = expected.clamped.get_access();
            let mut dst_sub = clamped.get_subregion(dfo[0], dfo[1], dfo[2], de[0], de[1], de[2]);
            blit_reference(&mut dst_sub, &src_sub, filter, mirror_mode);
        }
        if filter != FilterMode::Nearest {
            let mut unclamped = expected.unclamped.get_access();
            let mut dst_sub = unclamped.get_subregion(dfo[0], dfo[1], dfo[2], de[0], de[1], de[2]);
            scale_from_whole_src_buffer(&mut dst_sub, src, src_region_offset, src_region_extent, filter, mirror_mode);
        }
    }
}

impl BlittingImages<'_> {
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

    /// `BlittingImages::checkNearestFilteredResult`
    fn check_nearest_filtered_result(&self, result: &ConstPixelBufferAccess<'_>, source: &ConstPixelBufferAccess<'_>) -> Result<bool, TestError> {
        let dst_channel_class = result.format().channel_class();
        let src_channel_class = source.format().channel_class();

        // if either of srcImage or dstImage stores values as a signed/unsigned integer,
        // the other must also store values a signed/unsigned integer
        // e.g. blit unorm to uscaled is not allowed as uscaled formats store data as integers
        // despite the fact that both formats are sampled as floats
        let is_int_class = |c: TextureChannelClass| matches!(c, TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger);
        if is_int_class(dst_channel_class) != is_int_class(src_channel_class) {
            return Ok(false);
        }

        if is_int_class(dst_channel_class) {
            int_nearest_blit_compare(source, result, self.params)
        } else {
            let src_max_diff = get_float_or_fixed_point_format_threshold(source.format());
            let dst_max_diff = get_float_or_fixed_point_format_threshold(result.format());
            Ok(float_nearest_blit_compare(source, result, src_max_diff, dst_max_diff, self.params))
        }
    }

    /// `BlittingImages::checkNonNearestFilteredResult`
    fn check_non_nearest_filtered_result(
        &self,
        result: &ConstPixelBufferAccess<'_>,
        clamped_expected: &ConstPixelBufferAccess<'_>,
        unclamped_expected: &ConstPixelBufferAccess<'_>,
        src_format: TextureFormat,
    ) -> bool {
        let dst_format = result.format();
        let dst_channel_class = dst_format.channel_class();
        let src_channel_class = src_format.channel_class();

        let is_int_class = |c: TextureChannelClass| matches!(c, TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger);
        if is_int_class(dst_channel_class) != is_int_class(src_channel_class) {
            return false;
        }

        // The driver may clamp the sample at the region's edge or let it reach outside,
        // so the result is accepted if it matches either reference.
        if is_float_format(dst_format) {
            let src_is_srgb = src_format.order.is_srgb();
            let src_max_diff = get_format_threshold(src_format).map(|v| v * if src_is_srgb { 2.0 } else { 1.0 });
            let dst_max_diff = get_format_threshold(dst_format);
            let threshold: [f32; 4] = std::array::from_fn(|c| src_max_diff[c] + dst_max_diff[c]);

            float_threshold_compare(clamped_expected, result, threshold) || float_threshold_compare(unclamped_expected, result, threshold)
        } else {
            // Calculate threshold depending on channel width of destination format.
            let dst_bit_depth = get_texture_format_bit_depth(dst_format);
            let src_bit_depth = get_texture_format_bit_depth(src_format);
            let threshold: [u32; 4] = std::array::from_fn(|i| {
                let max_of = |bits: i32| if bits >= 64 { u64::MAX } else { (1u64 << bits) - 1 };
                let dst_max = max_of(dst_bit_depth[i]);
                let src_max = max_of(src_bit_depth[i]);
                let threshold64 = 1 + (dst_max / src_max.clamp(1, 256)).max(1);
                threshold64.min(u64::from(u32::MAX)) as u32
            });

            int_threshold_compare(clamped_expected, result, threshold) || int_threshold_compare(unclamped_expected, result, threshold)
        }
    }

    /// `BlittingImages::checkTestResult`
    fn check_test_result(&self, result: &ConstPixelBufferAccess<'_>, source: &ConstPixelBufferAccess<'_>, expected: Option<&ExpectedLevels>) -> Result<TestStatus, TestError> {
        const FAIL_MESSAGE: &str = "Result image is incorrect";

        if let Some(expected) = expected {
            let src_format = source.format();
            let clamped = expected.clamped.get_const_access();
            let unclamped = expected.unclamped.get_const_access();

            if is_combined_depth_stencil_type(result.format().type_) {
                for (mode, present) in [
                    (DepthStencilMode::Depth, has_depth_component(result.format().order)),
                    (DepthStencilMode::Stencil, has_stencil_component(result.format().order)),
                ] {
                    if !present {
                        continue;
                    }
                    let aspect_result = get_effective_depth_stencil_access(result, mode);
                    let aspect_clamped = get_effective_depth_stencil_access(&clamped, mode);
                    let aspect_unclamped = get_effective_depth_stencil_access(&unclamped, mode);
                    let aspect_src_format = get_effective_depth_stencil_texture_format(src_format, mode);
                    if !self.check_non_nearest_filtered_result(&aspect_result, &aspect_clamped, &aspect_unclamped, aspect_src_format) {
                        return Ok(TestStatus::fail(FAIL_MESSAGE));
                    }
                }
            } else if !self.check_non_nearest_filtered_result(result, &clamped, &unclamped, src_format) {
                return Ok(TestStatus::fail(FAIL_MESSAGE));
            }
            return Ok(TestStatus::pass("Pass"));
        }

        // A combined depth/stencil result is checked one aspect at a time: the two have
        // different channel classes, so there is no single comparison covering both.
        if is_combined_depth_stencil_type(result.format().type_) {
            if has_depth_component(result.format().order) {
                let depth_result = get_effective_depth_stencil_access(result, DepthStencilMode::Depth);
                let depth_source = get_effective_depth_stencil_access(source, DepthStencilMode::Depth);
                if !self.check_nearest_filtered_result(&depth_result, &depth_source)? {
                    return Ok(TestStatus::fail(FAIL_MESSAGE));
                }
            }
            if has_stencil_component(result.format().order) {
                let stencil_result = get_effective_depth_stencil_access(result, DepthStencilMode::Stencil);
                let stencil_source = get_effective_depth_stencil_access(source, DepthStencilMode::Stencil);
                if !self.check_nearest_filtered_result(&stencil_result, &stencil_source)? {
                    return Ok(TestStatus::fail(FAIL_MESSAGE));
                }
            }
        } else if !self.check_nearest_filtered_result(result, source)? {
            return Ok(TestStatus::fail(FAIL_MESSAGE));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for BlittingImages<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let families = [queue_family_index];

        let src_image_params = &p.src;
        let (src_width, src_height, src_depth) = (src_image_params.extent[0], src_image_params.extent[1], src_image_params.extent[2]);
        let dst_image_params = &p.dst;
        let (dst_width, dst_height, dst_depth) = (dst_image_params.extent[0], dst_image_params.extent[1], dst_image_params.extent[2]);

        let source = self.make_image(src_image_params)?;
        let destination = self.make_image(dst_image_params)?;

        // generate source image
        let src_tcu_format = map_vk_format(src_image_params.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let mut source_texture_level = TextureLevel::new(src_tcu_format, src_width, src_height, src_depth)?;
        generate_buffer(&mut source_texture_level.get_access(), src_width, src_height, src_depth, src_image_params.fill_mode, false);
        upload_image(
            self.context,
            &source_texture_level.get_const_access(),
            source.get(),
            src_image_params,
            false,
            &families,
            p.separate_depth_stencil_layouts,
        )?;

        // generate destination image
        let dst_tcu_format = map_vk_format(dst_image_params.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let mut destination_texture_level = TextureLevel::new(dst_tcu_format, dst_width, dst_height, dst_depth)?;
        generate_buffer(
            &mut destination_texture_level.get_access(),
            dst_width,
            dst_height,
            dst_depth,
            dst_image_params.fill_mode,
            false,
        );
        upload_image(
            self.context,
            &destination_texture_level.get_const_access(),
            destination.get(),
            dst_image_params,
            false,
            &families,
            p.separate_depth_stencil_layouts,
        )?;

        // `generateExpectedResult`. A NEAREST blit is checked against the source
        // directly, so it builds nothing here.
        let expected = if p.filter == vk::Filter::NEAREST {
            None
        } else {
            let filter = match p.filter {
                vk::Filter::LINEAR => FilterMode::Linear,
                other => return Err(TestError::NotPorted(format!("blit filter {other:?}"))),
            };
            let mut levels = ExpectedLevels {
                clamped: TextureLevel::new(dst_tcu_format, dst_width, dst_height, dst_depth)?,
                unclamped: TextureLevel::new(dst_tcu_format, dst_width, dst_height, dst_depth)?,
            };
            levels.clamped.data_mut().copy_from_slice(destination_texture_level.data());
            levels.unclamped.data_mut().copy_from_slice(destination_texture_level.data());
            for region in &p.regions {
                copy_region_to_texture_level(
                    &source_texture_level.get_const_access(),
                    &mut levels,
                    *region,
                    filter,
                    src_image_params.image_type,
                    dst_image_params.image_type,
                );
            }
            Some(levels)
        };

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Barriers for copying images to buffer
        let image_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                p.src_operation_layout,
                source.get(),
                make_image_subresource_range(get_aspect_flags(src_image_params.format), 0, 1, 0, src_image_params.array_size()),
            ),
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                p.dst_operation_layout,
                destination.get(),
                make_image_subresource_range(get_aspect_flags(dst_image_params.format), 0, 1, 0, dst_image_params.array_size()),
            ),
        ];

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers,
            );

            let regions: Vec<vk::ImageBlit> = p.regions.iter().map(|r| r.to_vk()).collect();
            if p.command_variant == CopyCommandVariant::CopyCommands2 {
                let regions2: Vec<vk::ImageBlit2> = regions
                    .iter()
                    .map(|r| vk::ImageBlit2 {
                        s_type: vk::StructureType::IMAGE_BLIT_2,
                        next: std::ptr::null(),
                        src_subresource: r.src_subresource,
                        src_offsets: r.src_offsets,
                        dst_subresource: r.dst_subresource,
                        dst_offsets: r.dst_offsets,
                    })
                    .collect();
                let blit_image_info2 = vk::BlitImageInfo2 {
                    s_type: vk::StructureType::BLIT_IMAGE_INFO_2,
                    next: std::ptr::null(),
                    src_image: source.get(),
                    src_image_layout: p.src_operation_layout,
                    dst_image: destination.get(),
                    dst_image_layout: p.dst_operation_layout,
                    region_count: regions2.len() as u32,
                    regions: regions2.as_ptr(),
                    filter: p.filter,
                };
                vk_device.cmd_blit_image2(*cmd_buffer, &blit_image_info2);
            } else {
                vk_device.cmd_blit_image(
                    *cmd_buffer,
                    source.get(),
                    p.src_operation_layout,
                    destination.get(),
                    p.dst_operation_layout,
                    &regions,
                    p.filter,
                );
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        let mut result_level = TextureLevel::new(dst_tcu_format, dst_width, dst_height, dst_depth)?;
        read_image(self.context, destination.get(), dst_image_params, &mut result_level, false, &families)?;

        self.check_test_result(&result_level.get_const_access(), &source_texture_level.get_const_access(), expected.as_ref())
    }
}

/// The shared shape of a `simple_tests` subgroup: both sides start from the same
/// image parameters and only the extents and the regions differ.
struct SimpleBlitParams {
    src_extent: [u32; 3],
    dst_extent: [u32; 3],
    regions: Vec<ImageBlit>,
}

/// `addBlittingImageSimpleTests`
///
/// Only the VK_FILTER_NEAREST third of it: LINEAR and CUBIC need the reference images
/// that `checkNonNearestFilteredResult` compares against, which is not ported.
fn add_blitting_image_simple_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams, image_type: vk::ImageType, sp: &SimpleBlitParams) {
    let make = |dst_format: vk::Format, name: String, filter: vk::Filter| BlitImageCase {
        name,
        src: ImageParms {
            image_type,
            format: vk::Format::R8G8B8A8_UNORM,
            extent: sp.src_extent,
            tiling: vk::ImageTiling::OPTIMAL,
            fill_mode: FillMode::Gradient,
            create_flags: None,
        },
        dst: ImageParms {
            image_type,
            format: dst_format,
            extent: sp.dst_extent,
            tiling: vk::ImageTiling::OPTIMAL,
            fill_mode: FillMode::White,
            create_flags: None,
        },
        src_operation_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        dst_operation_layout: vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        regions: sp.regions.clone(),
        filter,
        allocation_kind: gp.allocation_kind,
        command_variant: gp.command_variant,
        separate_depth_stencil_layouts: false,
    };

    // `getFormatCaseName` - the enum name lowercased, minus the VK_FORMAT_ prefix.
    // CUBIC is not registered: it needs sampleCubic, which is not ported.
    for (filter, suffix) in [(vk::Filter::NEAREST, "nearest"), (vk::Filter::LINEAR, "linear")] {
        group.add_child(Box::new(make(vk::Format::R8G8B8A8_UNORM, suffix.to_string(), filter)) as Box<dyn TestCase>);
        for (format, case_name) in [(vk::Format::R32_SFLOAT, "r32_sfloat"), (vk::Format::B8G8R8A8_UNORM, "b8g8r8a8_unorm")] {
            group.add_child(Box::new(make(format, format!("{case_name}_{suffix}"), filter)) as Box<dyn TestCase>);
        }
    }
}

/// The `defaultExtent`/`defaultHalfExtent` pair a subgroup starts from, with the depth
/// set by the image type - every subgroup opens with the same four lines.
fn simple_extents(image_type: vk::ImageType, half_src: bool, half_dst: bool) -> ([u32; 3], [u32; 3]) {
    let image_depth = if image_type == vk::ImageType::_3D { DEFAULT_SIZE } else { 1 };
    let half_image_depth = if image_type == vk::ImageType::_3D { DEFAULT_HALF_SIZE } else { 1 };
    let side = |half: bool| {
        let s = if half { DEFAULT_HALF_SIZE } else { DEFAULT_SIZE } as u32;
        let d = if half { half_image_depth } else { image_depth } as u32;
        [s, s, d]
    };
    (side(half_src), side(half_dst))
}

/// `addBlittingImageSimpleWholeTests`, and the mirror variants that differ from it only
/// in the destination offsets.
fn simple_whole_like(image_type: vk::ImageType, dst_offsets: [[i32; 3]; 2]) -> SimpleBlitParams {
    let image_depth = if image_type == vk::ImageType::_3D { DEFAULT_SIZE } else { 1 };
    let (src_extent, dst_extent) = simple_extents(image_type, false, false);
    SimpleBlitParams {
        src_extent,
        dst_extent,
        regions: vec![ImageBlit::color([[0, 0, 0], [DEFAULT_SIZE, DEFAULT_SIZE, image_depth]], dst_offsets)],
    }
}

/// `addBlittingImageSimpleMirrorSubregionsTests`
fn simple_mirror_subregions(image_type: vk::ImageType) -> SimpleBlitParams {
    let d = if image_type == vk::ImageType::_3D { DEFAULT_SIZE } else { 1 };
    let (h, s) = (DEFAULT_HALF_SIZE, DEFAULT_SIZE);
    let (src_extent, dst_extent) = simple_extents(image_type, false, false);
    SimpleBlitParams {
        src_extent,
        dst_extent,
        regions: vec![
            // No mirroring.
            ImageBlit::color([[0, 0, 0], [h, h, d]], [[0, 0, 0], [h, h, d]]),
            // Flipping y coordinates.
            ImageBlit::color([[h, 0, 0], [s, h, d]], [[h, h, 0], [s, 0, d]]),
            // Flipping x coordinates.
            ImageBlit::color([[0, h, 0], [h, s, d]], [[h, h, 0], [0, s, d]]),
            // Flipping x and y coordinates.
            ImageBlit::color([[h, h, 0], [s, s, d]], [[s, s, 0], [h, h, d]]),
        ],
    }
}

/// `addBlittingImageSimpleScalingWhole1Tests` / `...Whole2Tests` - a whole-image blit
/// where exactly one side is half size.
fn simple_scaling_whole(image_type: vk::ImageType, src_is_half: bool) -> SimpleBlitParams {
    let image_depth = if image_type == vk::ImageType::_3D { DEFAULT_SIZE } else { 1 };
    let half_image_depth = if image_type == vk::ImageType::_3D { DEFAULT_HALF_SIZE } else { 1 };
    let (src_extent, dst_extent) = simple_extents(image_type, src_is_half, !src_is_half);
    let full = [[0, 0, 0], [DEFAULT_SIZE, DEFAULT_SIZE, image_depth]];
    let half = [[0, 0, 0], [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, half_image_depth]];
    SimpleBlitParams {
        src_extent,
        dst_extent,
        regions: vec![ImageBlit::color(if src_is_half { half } else { full }, if src_is_half { full } else { half })],
    }
}

/// `addBlittingImageSimpleScalingAndOffsetTests`
fn simple_scaling_and_offset(image_type: vk::ImageType) -> SimpleBlitParams {
    let is_3d = image_type == vk::ImageType::_3D;
    let image_depth = if is_3d { DEFAULT_SIZE } else { 1 };
    let src_depth_offset = if is_3d { DEFAULT_QUARTER_SIZE } else { 0 };
    let src_depth_size = if is_3d { DEFAULT_QUARTER_SIZE * 3 } else { 1 };
    let (src_extent, dst_extent) = simple_extents(image_type, false, false);
    SimpleBlitParams {
        src_extent,
        dst_extent,
        regions: vec![ImageBlit::color(
            [
                [DEFAULT_QUARTER_SIZE, DEFAULT_QUARTER_SIZE, src_depth_offset],
                [DEFAULT_QUARTER_SIZE * 3, DEFAULT_QUARTER_SIZE * 3, src_depth_size],
            ],
            [[0, 0, 0], [DEFAULT_SIZE, DEFAULT_SIZE, image_depth]],
        )],
    }
}

/// `addBlittingImageSimpleWithoutScalingPartialTests`
fn simple_without_scaling_partial(image_type: vk::ImageType) -> SimpleBlitParams {
    let is_3d_blit = image_type == vk::ImageType::_3D;
    let (src_extent, dst_extent) = simple_extents(image_type, false, false);
    let mut regions = Vec::new();
    let mut i = 0;
    while i < DEFAULT_SIZE {
        regions.push(ImageBlit::color(
            [
                [
                    DEFAULT_SIZE - DEFAULT_QUARTER_SIZE - i,
                    DEFAULT_SIZE - DEFAULT_QUARTER_SIZE - i,
                    if is_3d_blit { DEFAULT_SIZE - DEFAULT_QUARTER_SIZE - i } else { 0 },
                ],
                [DEFAULT_SIZE - i, DEFAULT_SIZE - i, if is_3d_blit { DEFAULT_SIZE - i } else { 1 }],
            ],
            [
                [i, i, if is_3d_blit { i } else { 0 }],
                [i + DEFAULT_QUARTER_SIZE, i + DEFAULT_QUARTER_SIZE, if is_3d_blit { i + DEFAULT_QUARTER_SIZE } else { 1 }],
            ],
        ));
        i += DEFAULT_QUARTER_SIZE;
    }
    SimpleBlitParams { src_extent, dst_extent, regions }
}

/// `addBlittingImageSimpleTests(group, allocationKind, extensionFlags)`
///
/// The 2D and 3D subgroups. `array`, `3d_to_2d_array` and `2d_array_to_3d` are not
/// registered: they blit between array layers and 3D slices, which needs the
/// per-layer `getUsedZRange` path the ported verifier does not cover yet.
fn add_blitting_image_simple_tests_group(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let s = DEFAULT_SIZE;

    for image_type in [vk::ImageType::_2D, vk::ImageType::_3D] {
        let t = image_type;
        let is_3d = t == vk::ImageType::_3D;
        // `imageDepth` - the z the whole-image blits span.
        let d = if is_3d { DEFAULT_SIZE } else { 1 };
        let suffix = if is_3d { "_3d" } else { "" };

        let mut subgroups: Vec<(String, SimpleBlitParams)> = vec![
            ("whole".to_string(), simple_whole_like(t, [[0, 0, 0], [s, s, d]])),
            ("mirror_xy".to_string(), simple_whole_like(t, [[s, s, 0], [0, 0, d]])),
            ("mirror_x".to_string(), simple_whole_like(t, [[s, 0, 0], [0, s, d]])),
            ("mirror_y".to_string(), simple_whole_like(t, [[0, s, 0], [s, 0, d]])),
        ];
        // Mirroring z only makes sense for a 3D image, so upstream registers it there
        // alone - and it is the reason the 2D and 3D lists are not the same list.
        if is_3d {
            subgroups.push(("mirror_z".to_string(), simple_whole_like(t, [[0, 0, s], [s, s, 0]])));
        }
        subgroups.extend([
            ("mirror_subregions".to_string(), simple_mirror_subregions(t)),
            ("scaling_whole1".to_string(), simple_scaling_whole(t, false)),
            ("scaling_whole2".to_string(), simple_scaling_whole(t, true)),
            ("scaling_and_offset".to_string(), simple_scaling_and_offset(t)),
            ("without_scaling_partial".to_string(), simple_without_scaling_partial(t)),
        ]);

        // `array` sits between `whole` and `mirror_xy` upstream, in the 2D list only.
        for (name, sp) in &subgroups {
            let mut sub = tcu::TestCaseGroup::new(format!("{name}{suffix}"));
            add_blitting_image_simple_tests(&mut sub, gp, t, sp);
            group.add_child(sub);
        }
    }
}

/// `addBlittingImageTests`
pub fn add_blitting_image_groups(parent: &mut tcu::TestCaseGroup, name: &str, allocation_kind: AllocationKind, command_variant: CopyCommandVariant) {
    let gp = GroupParams {
        allocation_kind,
        command_variant,
        queue_selection: super::copies_buffer_tests::QueueSelection::Universal,
        general_layout: false,
    };
    let mut group = tcu::TestCaseGroup::new(name);
    let mut simple = tcu::TestCaseGroup::new("simple_tests");
    add_blitting_image_simple_tests_group(&mut simple, &gp);
    group.add_child(simple);

    let mut all_formats = tcu::TestCaseGroup::new("all_formats");
    let mut color = tcu::TestCaseGroup::new("color");
    add_blitting_image_all_formats_color_tests(&mut color, &gp);
    all_formats.add_child(color);
    let mut depth_stencil = tcu::TestCaseGroup::new("depth_stencil");
    add_blitting_image_all_formats_depth_stencil_tests(&mut depth_stencil, &gp);
    all_formats.add_child(depth_stencil);
    // The generate_mipmaps group needs the non-nearest reference path.
    group.add_child(all_formats);
    parent.add_child(group);
}

// ---------------------------------------------------------------------------------

/// `linearOtherImageFormatsToTest` - the only formats the other side of a LINEAR-tiled
/// blit is tried against, two per compatible-format group.
static LINEAR_OTHER_IMAGE_FORMATS_TO_TEST: &[vk::Format] = &[
    // From compatibleFormats8Bit
    vk::Format::R4G4_UNORM_PACK8,
    vk::Format::R8_SRGB,
    // From compatibleFormats16Bit
    vk::Format::R4G4B4A4_UNORM_PACK16,
    vk::Format::R16_SFLOAT,
    // From compatibleFormats24Bit
    vk::Format::R8G8B8_UNORM,
    vk::Format::B8G8R8_SRGB,
    // From compatibleFormats32Bit
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::R32_SFLOAT,
    // From compatibleFormats48Bit
    vk::Format::R16G16B16_UNORM,
    vk::Format::R16G16B16_SFLOAT,
    // From compatibleFormats64Bit
    vk::Format::R16G16B16A16_UNORM,
    vk::Format::R64_SFLOAT,
    // From compatibleFormats96Bit
    vk::Format::R32G32B32_UINT,
    vk::Format::R32G32B32_SFLOAT,
    // From compatibleFormats128Bit
    vk::Format::R32G32B32A32_UINT,
    vk::Format::R64G64_SFLOAT,
    // From compatibleFormats192Bit
    vk::Format::R64G64B64_UINT,
    vk::Format::R64G64B64_SFLOAT,
    // From compatibleFormats256Bit
    vk::Format::R64G64B64A64_UINT,
    vk::Format::R64G64B64A64_SFLOAT,
];

/// `dedicatedAllocationBlittingFormatsToTest` - under dedicated allocation only a pair
/// touching one of these is registered at all, which is what keeps that variant from
/// being the full cross product a third time over.
static DEDICATED_ALLOCATION_BLITTING_FORMATS_TO_TEST: &[vk::Format] = &[
    // compatibleFormatsUInts
    vk::Format::R8_UINT,
    vk::Format::R64G64B64A64_UINT,
    // compatibleFormatsSInts
    vk::Format::R8_SINT,
    vk::Format::R64G64B64A64_SINT,
    // compatibleFormatsFloats
    vk::Format::R4G4_UNORM_PACK8,
    vk::Format::E5B9G9R9_UFLOAT_PACK32,
    // compatibleFormatsSrgb
    vk::Format::R8_SRGB,
    vk::Format::A8B8G8R8_SRGB_PACK32,
];

/// `getBlitImageTilingLayoutCaseName`
fn blit_image_tiling_layout_case_name(tiling: vk::ImageTiling, layout: vk::ImageLayout) -> &'static str {
    match tiling {
        vk::ImageTiling::LINEAR => "linear",
        // `getImageLayoutCaseName`
        _ if layout == vk::ImageLayout::GENERAL => "general",
        _ => "optimal",
    }
}

/// `create2DCopyRegions`
fn create_2d_copy_regions(src_width: i32, src_height: i32, dst_width: i32, dst_height: i32) -> Vec<ImageBlit> {
    let mut regions = Vec::new();

    let fourth_of_src_width = src_width / 4;
    let fourth_of_src_height = src_height / 4;
    let fourth_of_dst_width = dst_width / 4;
    let fourth_of_dst_height = dst_height / 4;

    // to the top of resulting image copy whole source image but with increasingly smaller sizes
    let (mut i, mut j) = (0, 1);
    while (i + fourth_of_dst_width / j < dst_width) && (fourth_of_dst_width > j) {
        regions.push(ImageBlit::color(
            [[0, 0, 0], [src_width, src_height, 1]],
            [[i, 0, 0], [i + fourth_of_dst_width / j, fourth_of_dst_height / j, 1]],
        ));
        i += fourth_of_dst_width / j;
        j += 1;
    }

    // to the bottom of resulting image copy parts of source image;
    for i in 0..4 {
        let src_x = i * fourth_of_src_width;
        let src_y = i * fourth_of_src_height;
        let dst_x = i * fourth_of_dst_width;

        regions.push(ImageBlit::color(
            [[src_x, src_y, 0], [src_x + fourth_of_src_width, src_y + fourth_of_src_height, 1]],
            [[dst_x, 2 * fourth_of_dst_height, 0], [dst_x + fourth_of_dst_width, 3 * fourth_of_dst_height, 1]],
        ));
    }

    regions
}

/// The 1D region list `addBlittingImageAllFormatsColorTests` builds inline.
fn create_1d_copy_regions() -> Vec<ImageBlit> {
    let mut regions = Vec::new();
    let mut i = 0;
    while i < DEFAULT_SIZE {
        regions.push(ImageBlit::color([[0, 0, 0], [DEFAULT_SIZE, 1, 1]], [[i, 0, 0], [i + DEFAULT_QUARTER_SIZE, 1, 1]]));
        i += DEFAULT_SIZE / 2;
    }
    regions.push(ImageBlit::color(
        [[0, 0, 0], [DEFAULT_QUARTER_SIZE, 1, 1]],
        [[DEFAULT_QUARTER_SIZE, 0, 0], [2 * DEFAULT_QUARTER_SIZE, 1, 1]],
    ));
    regions
}

/// What `BlitColorTestParams` carries into the two registration levels below it.
struct BlitColorTestParams<'a> {
    image_type: vk::ImageType,
    extent: [u32; 3],
    regions: &'a [ImageBlit],
    src: &'a BlitFormat,
    /// `makeFilterMask`'s LINEAR bit. The integer format lists are nearest-only:
    /// a linear filter has nothing to interpolate between integer texels.
    test_linear: bool,
}

/// `addBlittingImageAllFormatsColorSrcFormatDstFormatTests`
///
/// Only the VK_FILTER_NEAREST case of each tiling/layout combination. The `_linear`,
/// `_cubic` and 3D `_stripes_*` cases all need a reference image.
fn add_blitting_image_all_formats_color_src_format_dst_format_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams, p: &BlitColorTestParams<'_>, dst_format: vk::Format) {
    let blit_src_tilings = [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR];
    let blit_src_layouts = [vk::ImageLayout::TRANSFER_SRC_OPTIMAL, vk::ImageLayout::GENERAL];
    let blit_dst_tilings = [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR];
    let blit_dst_layouts = [vk::ImageLayout::TRANSFER_DST_OPTIMAL, vk::ImageLayout::GENERAL];

    for src_tiling in blit_src_tilings {
        for src_layout in blit_src_layouts {
            // Don't bother testing VK_IMAGE_TILING_LINEAR + VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL as it's likely to be the same as VK_IMAGE_LAYOUT_GENERAL
            if src_tiling == vk::ImageTiling::LINEAR && src_layout == vk::ImageLayout::TRANSFER_SRC_OPTIMAL {
                continue;
            }

            for dst_tiling in blit_dst_tilings {
                for dst_layout in blit_dst_layouts {
                    // Don't bother testing VK_IMAGE_TILING_LINEAR + VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL as it's likely to be the same as VK_IMAGE_LAYOUT_GENERAL
                    if dst_tiling == vk::ImageTiling::LINEAR && dst_layout == vk::ImageLayout::TRANSFER_DST_OPTIMAL {
                        continue;
                    }

                    // A linear-tiled side is only tried against the short list of
                    // formats on the *other* side, not against all of them.
                    if (dst_tiling == vk::ImageTiling::LINEAR && !LINEAR_OTHER_IMAGE_FORMATS_TO_TEST.contains(&p.src.format))
                        || (src_tiling == vk::ImageTiling::LINEAR && !LINEAR_OTHER_IMAGE_FORMATS_TO_TEST.contains(&dst_format))
                    {
                        continue;
                    }

                    let test_name = format!(
                        "{}_{}",
                        blit_image_tiling_layout_case_name(src_tiling, src_layout),
                        blit_image_tiling_layout_case_name(dst_tiling, dst_layout)
                    );
                    let make = |name: String, src_fill: FillMode, filter: vk::Filter| {
                        Box::new(BlitImageCase {
                            name,
                            src: ImageParms {
                                image_type: p.image_type,
                                format: p.src.format,
                                extent: p.extent,
                                tiling: src_tiling,
                                fill_mode: src_fill,
                                create_flags: None,
                            },
                            dst: ImageParms {
                                image_type: p.image_type,
                                format: dst_format,
                                extent: p.extent,
                                tiling: dst_tiling,
                                fill_mode: FillMode::White,
                                create_flags: None,
                            },
                            src_operation_layout: src_layout,
                            dst_operation_layout: dst_layout,
                            regions: p.regions.to_vec(),
                            filter,
                            allocation_kind: gp.allocation_kind,
                            command_variant: gp.command_variant,
                            separate_depth_stencil_layouts: false,
                        }) as Box<dyn TestCase>
                    };
                    group.add_child(make(format!("{test_name}_nearest"), FillMode::Gradient, vk::Filter::NEAREST));
                    if p.test_linear {
                        group.add_child(make(format!("{test_name}_linear"), FillMode::Gradient, vk::Filter::LINEAR));
                    }

                    // A 3D source also gets the stripe fills, one per axis - a gradient
                    // varies too slowly to notice a filter reaching for the wrong slice.
                    if p.image_type == vk::ImageType::_3D {
                        for (mode, name) in [(FillMode::BlueRedX, "x"), (FillMode::BlueRedY, "y"), (FillMode::BlueRedZ, "z")] {
                            // Upstream emits linear before nearest for these.
                            group.add_child(make(format!("{test_name}_linear_stripes_{name}"), mode, vk::Filter::LINEAR));
                            group.add_child(make(format!("{test_name}_nearest_stripes_{name}"), mode, vk::Filter::NEAREST));
                        }
                    }
                }
            }
        }
    }
}

/// `addBlittingImageAllFormatsColorSrcFormatTests`
fn add_blitting_image_all_formats_color_src_format_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams, p: &BlitColorTestParams<'_>, compatible_formats: Option<&[BlitFormat]>) {
    if let Some(formats) = compatible_formats {
        for dst in formats {
            if !is_supported_by_framework(dst.format) {
                continue;
            }
            // `isAllowedBlittingAllFormatsColorSrcFormatTests` - an OR over the pair,
            // not a test of one side.
            if gp.allocation_kind == AllocationKind::Dedicated
                && !(DEDICATED_ALLOCATION_BLITTING_FORMATS_TO_TEST.contains(&dst.format) || DEDICATED_ALLOCATION_BLITTING_FORMATS_TO_TEST.contains(&p.src.format))
            {
                continue;
            }
            let mut dst_group = tcu::TestCaseGroup::new(dst.name);
            add_blitting_image_all_formats_color_src_format_dst_format_tests(&mut dst_group, gp, p, dst.format);
            group.add_child(dst_group);
        }
    } else {
        // With no compatible-format list the destination format is copied from the
        // source, which is how the 1D and 3D groups get a single destination each.
        let mut dst_group = tcu::TestCaseGroup::new(p.src.name);
        add_blitting_image_all_formats_color_src_format_dst_format_tests(&mut dst_group, gp, p, p.src.format);
        group.add_child(dst_group);
    }
}

/// `colorImageFormatsToTestBlit`, minus the two compressed source lists.
fn color_image_formats_to_test_blit() -> [(&'static [BlitFormat], &'static [BlitFormat], bool); 4] {
    [
        (COMPATIBLE_FORMATS_U_INTS, COMPATIBLE_FORMATS_U_INTS, true),
        (COMPATIBLE_FORMATS_S_INTS, COMPATIBLE_FORMATS_S_INTS, true),
        (COMPATIBLE_FORMATS_FLOATS, COMPATIBLE_FORMATS_FLOATS, false),
        (COMPATIBLE_FORMATS_SRGB, COMPATIBLE_FORMATS_SRGB, false),
    ]
}

/// `addBlittingImageAllFormatsColorTests`
fn add_blitting_image_all_formats_color_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    // 2D tests.
    {
        let mut sub_group = tcu::TestCaseGroup::new("2d");
        let regions = create_2d_copy_regions(DEFAULT_SIZE, DEFAULT_SIZE, DEFAULT_SIZE, DEFAULT_SIZE);

        for (source_formats, destination_formats, only_nearest) in color_image_formats_to_test_blit() {
            for src in source_formats {
                let p = BlitColorTestParams {
                    image_type: vk::ImageType::_2D,
                    extent: [DEFAULT_SIZE as u32, DEFAULT_SIZE as u32, 1],
                    regions: &regions,
                    src,
                    test_linear: !only_nearest,
                };
                let mut src_group = tcu::TestCaseGroup::new(src.name);
                add_blitting_image_all_formats_color_src_format_tests(&mut src_group, gp, &p, Some(destination_formats));
                sub_group.add_child(src_group);
            }
        }
        group.add_child(sub_group);
    }

    // 1D tests.
    {
        let mut sub_group = tcu::TestCaseGroup::new("1d");
        let regions = create_1d_copy_regions();

        for (source_formats, _, only_nearest) in color_image_formats_to_test_blit() {
            for src in source_formats {
                if !is_supported_by_framework(src.format) {
                    continue;
                }
                let p = BlitColorTestParams {
                    image_type: vk::ImageType::_1D,
                    extent: [DEFAULT_SIZE as u32, 1, 1],
                    regions: &regions,
                    src,
                    test_linear: !only_nearest,
                };
                let mut src_group = tcu::TestCaseGroup::new(src.name);
                add_blitting_image_all_formats_color_src_format_tests(&mut src_group, gp, &p, None);
                sub_group.add_child(src_group);
            }
        }
        group.add_child(sub_group);
    }

    // 3D tests. Note we use smaller dimensions here for performance reasons.
    {
        let mut sub_group = tcu::TestCaseGroup::new("3d");
        let regions = create_3d_all_formats_regions();

        for (source_formats, _, only_nearest) in color_image_formats_to_test_blit() {
            for src in source_formats {
                if !is_supported_by_framework(src.format) {
                    continue;
                }
                let p = BlitColorTestParams {
                    image_type: vk::ImageType::_3D,
                    // `default3dExtent`
                    extent: [DEFAULT_QUARTER_SIZE as u32; 3],
                    regions: &regions,
                    src,
                    test_linear: !only_nearest,
                };
                let mut src_group = tcu::TestCaseGroup::new(src.name);
                add_blitting_image_all_formats_color_src_format_tests(&mut src_group, gp, &p, None);
                sub_group.add_child(src_group);
            }
        }
        group.add_child(sub_group);
    }
}

/// `addBlittingImageAllFormatsDepthStencilFormatsTests`
///
/// Only the VK_FILTER_NEAREST case - upstream registers nothing else here.
fn add_blitting_image_all_formats_depth_stencil_formats_tests(
    group: &mut tcu::TestCaseGroup,
    gp: &GroupParams,
    image_type: vk::ImageType,
    extent: [u32; 3],
    format: vk::Format,
    regions: &[ImageBlit],
    separate_layouts: bool,
) {
    let blit_src_layouts = [vk::ImageLayout::TRANSFER_SRC_OPTIMAL, vk::ImageLayout::GENERAL];
    let blit_dst_layouts = [vk::ImageLayout::TRANSFER_DST_OPTIMAL, vk::ImageLayout::GENERAL];

    for src_layout in blit_src_layouts {
        for dst_layout in blit_dst_layouts {
            let parms = |tiling| ImageParms {
                image_type,
                format,
                extent,
                tiling,
                fill_mode: FillMode::Gradient,
                create_flags: None,
            };
            group.add_child(Box::new(BlitImageCase {
                name: format!("{}_{}_nearest", image_layout_case_name(src_layout), image_layout_case_name(dst_layout)),
                src: parms(vk::ImageTiling::OPTIMAL),
                dst: ImageParms {
                    fill_mode: FillMode::White,
                    ..parms(vk::ImageTiling::OPTIMAL)
                },
                src_operation_layout: src_layout,
                dst_operation_layout: dst_layout,
                regions: regions.to_vec(),
                filter: vk::Filter::NEAREST,
                allocation_kind: gp.allocation_kind,
                command_variant: gp.command_variant,
                separate_depth_stencil_layouts: separate_layouts,
            }) as Box<dyn TestCase>);
        }
    }
}

/// `getImageLayoutCaseName`
fn image_layout_case_name(layout: vk::ImageLayout) -> &'static str {
    if layout == vk::ImageLayout::GENERAL { "general" } else { "optimal" }
}

/// One depth/stencil region: upstream emits the same offsets once per aspect the
/// format has, so the aspect is the only thing that varies.
fn ds_regions(has_depth: bool, has_stencil: bool, src: [[i32; 3]; 2], dst: [[i32; 3]; 2]) -> Vec<ImageBlit> {
    let mut out = Vec::new();
    if has_depth {
        out.push(ImageBlit {
            src_offsets: src,
            dst_offsets: dst,
            aspect_mask: vk::ImageAspectFlags::DEPTH,
        });
    }
    if has_stencil {
        out.push(ImageBlit {
            src_offsets: src,
            dst_offsets: dst,
            aspect_mask: vk::ImageAspectFlags::STENCIL,
        });
    }
    out
}

/// The region lists `addBlittingImageAllFormatsDepthStencilTests` builds inline, per
/// image type.
fn create_depth_stencil_regions(image_type: vk::ImageType, has_depth: bool, has_stencil: bool) -> Vec<ImageBlit> {
    let (s, q, sixteenth) = (DEFAULT_SIZE, DEFAULT_QUARTER_SIZE, DEFAULT_SIXTEENTH_SIZE);
    let mut regions = Vec::new();
    let both = has_depth && has_stencil;

    match image_type {
        vk::ImageType::_2D => {
            let (mut i, mut j) = (0, 1);
            while (i + q / j < s) && (q > j) {
                regions.extend(ds_regions(has_depth, has_stencil, [[0, 0, 0], [s, s, 1]], [[i, 0, 0], [i + q / j, q / j, 1]]));
                i += q / j;
                j += 1;
            }
            let mut i = 0;
            while i < s {
                let src = [[i, i, 0], [i + q, i + q, 1]];
                regions.extend(ds_regions(has_depth, has_stencil, src, [[i, s / 2, 0], [i + q, s / 2 + q, 1]]));
                if both {
                    regions.push(ImageBlit {
                        src_offsets: src,
                        dst_offsets: [[i, 3 * q, 0], [i + q, s, 1]],
                        aspect_mask: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                    });
                }
                i += q;
            }
        }
        vk::ImageType::_1D => {
            let mut i = 0;
            while i < s {
                regions.extend(ds_regions(has_depth, has_stencil, [[0, 0, 0], [s, 1, 1]], [[i, 0, 0], [i + q, 1, 1]]));
                i += s / 2;
            }
            let src = [[0, 0, 0], [q, 1, 1]];
            regions.extend(ds_regions(has_depth, has_stencil, src, [[q, 0, 0], [2 * q, 1, 1]]));
            if both {
                regions.push(ImageBlit {
                    src_offsets: src,
                    dst_offsets: [[3 * q, 0, 0], [3 * q + q / 2, 1, 1]],
                    aspect_mask: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                });
            }
        }
        _ => {
            let (mut i, mut j) = (0, 1);
            while (i + sixteenth / j < q) && (sixteenth > j) {
                regions.extend(ds_regions(
                    has_depth,
                    has_stencil,
                    [[0, 0, 0], [q, q, q]],
                    [[i, 0, i], [i + sixteenth / j, sixteenth / j, i + sixteenth / j]],
                ));
                i += sixteenth / j;
                j += 1;
            }
            let mut i = 0;
            while i < q {
                let src = [[i, i, i], [i + sixteenth, i + sixteenth, i + sixteenth]];
                regions.extend(ds_regions(has_depth, has_stencil, src, [[i, q / 2, i], [i + sixteenth, q / 2 + sixteenth, i + sixteenth]]));
                if both {
                    regions.push(ImageBlit {
                        src_offsets: src,
                        dst_offsets: [[i, 3 * sixteenth, i], [i + sixteenth, q, i + sixteenth]],
                        aspect_mask: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                    });
                }
                i += sixteenth;
            }
        }
    }
    regions
}

/// `addBlittingImageAllFormatsDepthStencilTests`
fn add_blitting_image_all_formats_depth_stencil_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    for (sub_name, image_type, extent) in [
        ("2d", vk::ImageType::_2D, [DEFAULT_SIZE as u32, DEFAULT_SIZE as u32, 1]),
        ("1d", vk::ImageType::_1D, [DEFAULT_SIZE as u32, 1, 1]),
        ("3d", vk::ImageType::_3D, [DEFAULT_QUARTER_SIZE as u32; 3]),
    ] {
        let mut sub_group = tcu::TestCaseGroup::new(sub_name);
        for (format, name) in DEPTH_AND_STENCIL_FORMATS {
            let Some(tcu_format) = map_vk_format(*format) else { continue };
            let has_depth = has_depth_component(tcu_format.order);
            let has_stencil = has_stencil_component(tcu_format.order);
            let regions = create_depth_stencil_regions(image_type, has_depth, has_stencil);

            let mut format_group = tcu::TestCaseGroup::new(format!("{name}_{name}"));
            add_blitting_image_all_formats_depth_stencil_formats_tests(&mut format_group, gp, image_type, extent, *format, &regions, false);
            sub_group.add_child(format_group);

            if has_depth && has_stencil {
                let mut separate = tcu::TestCaseGroup::new(format!("{name}_{name}_separate_layouts"));
                add_blitting_image_all_formats_depth_stencil_formats_tests(&mut separate, gp, image_type, extent, *format, &regions, true);
                sub_group.add_child(separate);
            }
        }
        group.add_child(sub_group);
    }
}

/// The 3D region list `addBlittingImageAllFormatsColorTests` builds inline.
fn create_3d_all_formats_regions() -> Vec<ImageBlit> {
    let q = DEFAULT_QUARTER_SIZE;
    let s = DEFAULT_SIXTEENTH_SIZE;
    let mut regions = Vec::new();

    let (mut i, mut j) = (0, 1);
    while (i + s / j < q) && (s > j) {
        regions.push(ImageBlit::color([[0, 0, 0], [q, q, q]], [[i, 0, i], [i + s / j, s / j, i + s / j]]));
        i += s / j;
        j += 1;
    }

    let mut i = 0;
    while i < q {
        regions.push(ImageBlit::color([[i, i, i], [i + s, i + s, i + s]], [[i, q / 2, i], [i + s, q / 2 + s, i + s]]));
        i += s;
    }

    regions
}

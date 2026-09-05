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
// Ported so far: the VK_FILTER_NEAREST cases of the 2D and 3D simple_tests subgroups.
// LINEAR and CUBIC need two reference images built with a scaled filter
// (`checkNonNearestFilteredResult`), which is not ported; the array-to-3D groups and
// all_formats are not registered yet either.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use super::copies_buffer_tests::{AllocationKind, CopyCommandVariant};
use super::copies_image_tests::{FillMode, GroupParams, ImageParms, generate_buffer, get_aspect_flags, read_image, upload_image};
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, get_texture_format_bit_depth, get_texture_format_mantissa_bit_depth};
use crate::tcu::tex_verifier::{LookupPrecision, is_nearest_sample_result_valid_float, srgb_to_linear};
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

/// `CopyRegion::imageBlit`, narrowed to the single-layer colour blits the ported
/// subgroups use - every one of them passes `defaultSourceLayer` on both sides.
#[derive(Clone, Copy)]
pub struct ImageBlit {
    pub src_offsets: [[i32; 3]; 2],
    pub dst_offsets: [[i32; 3]; 2],
}

impl ImageBlit {
    fn to_vk(self) -> vk::ImageBlit {
        let layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
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
            // `intNearestBlitCompare` converts the source into the destination format
            // first, which needs a `setPixelInt` write path tcu does not have here yet.
            // No registered case reaches this - only all_formats has integer formats.
            return Err(TestError::NotPorted("integer nearest blit comparison".to_string()));
        }
        {
            let src_max_diff = get_float_or_fixed_point_format_threshold(source.format());
            let dst_max_diff = get_float_or_fixed_point_format_threshold(result.format());
            Ok(float_nearest_blit_compare(source, result, src_max_diff, dst_max_diff, self.params))
        }
    }

    /// `BlittingImages::checkTestResult`, NEAREST branch only.
    fn check_test_result(&self, result: &ConstPixelBufferAccess<'_>, source: &ConstPixelBufferAccess<'_>) -> Result<TestStatus, TestError> {
        const FAIL_MESSAGE: &str = "Result image is incorrect";
        if !self.check_nearest_filtered_result(result, source)? {
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
        upload_image(self.context, &source_texture_level.get_const_access(), source.get(), src_image_params, false, &families)?;

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
        )?;

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

        self.check_test_result(&result_level.get_const_access(), &source_texture_level.get_const_access())
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
    let make = |dst_format: vk::Format, name: String| BlitImageCase {
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
        filter: vk::Filter::NEAREST,
        allocation_kind: gp.allocation_kind,
        command_variant: gp.command_variant,
    };

    group.add_child(Box::new(make(vk::Format::R8G8B8A8_UNORM, "nearest".to_string())) as Box<dyn TestCase>);
    // `getFormatCaseName` - the enum name lowercased, minus the VK_FORMAT_ prefix.
    for (format, case_name) in [(vk::Format::R32_SFLOAT, "r32_sfloat"), (vk::Format::B8G8R8A8_UNORM, "b8g8r8a8_unorm")] {
        group.add_child(Box::new(make(format, format!("{case_name}_nearest"))) as Box<dyn TestCase>);
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
        regions: vec![ImageBlit {
            src_offsets: [[0, 0, 0], [DEFAULT_SIZE, DEFAULT_SIZE, image_depth]],
            dst_offsets,
        }],
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
            ImageBlit {
                src_offsets: [[0, 0, 0], [h, h, d]],
                dst_offsets: [[0, 0, 0], [h, h, d]],
            },
            // Flipping y coordinates.
            ImageBlit {
                src_offsets: [[h, 0, 0], [s, h, d]],
                dst_offsets: [[h, h, 0], [s, 0, d]],
            },
            // Flipping x coordinates.
            ImageBlit {
                src_offsets: [[0, h, 0], [h, s, d]],
                dst_offsets: [[h, h, 0], [0, s, d]],
            },
            // Flipping x and y coordinates.
            ImageBlit {
                src_offsets: [[h, h, 0], [s, s, d]],
                dst_offsets: [[s, s, 0], [h, h, d]],
            },
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
        regions: vec![ImageBlit {
            src_offsets: if src_is_half { half } else { full },
            dst_offsets: if src_is_half { full } else { half },
        }],
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
        regions: vec![ImageBlit {
            src_offsets: [
                [DEFAULT_QUARTER_SIZE, DEFAULT_QUARTER_SIZE, src_depth_offset],
                [DEFAULT_QUARTER_SIZE * 3, DEFAULT_QUARTER_SIZE * 3, src_depth_size],
            ],
            dst_offsets: [[0, 0, 0], [DEFAULT_SIZE, DEFAULT_SIZE, image_depth]],
        }],
    }
}

/// `addBlittingImageSimpleWithoutScalingPartialTests`
fn simple_without_scaling_partial(image_type: vk::ImageType) -> SimpleBlitParams {
    let is_3d_blit = image_type == vk::ImageType::_3D;
    let (src_extent, dst_extent) = simple_extents(image_type, false, false);
    let mut regions = Vec::new();
    let mut i = 0;
    while i < DEFAULT_SIZE {
        regions.push(ImageBlit {
            src_offsets: [
                [
                    DEFAULT_SIZE - DEFAULT_QUARTER_SIZE - i,
                    DEFAULT_SIZE - DEFAULT_QUARTER_SIZE - i,
                    if is_3d_blit { DEFAULT_SIZE - DEFAULT_QUARTER_SIZE - i } else { 0 },
                ],
                [DEFAULT_SIZE - i, DEFAULT_SIZE - i, if is_3d_blit { DEFAULT_SIZE - i } else { 1 }],
            ],
            dst_offsets: [
                [i, i, if is_3d_blit { i } else { 0 }],
                [i + DEFAULT_QUARTER_SIZE, i + DEFAULT_QUARTER_SIZE, if is_3d_blit { i + DEFAULT_QUARTER_SIZE } else { 1 }],
            ],
        });
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
    // all_formats and mipmap are not ported: both need the non-nearest reference path.
    parent.add_child(group);
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFeatureInfo.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Every case here is a pure query test - vkGetPhysicalDeviceFormatProperties,
// vkGetPhysicalDeviceImageFormatProperties(2), vkGetPhysicalDeviceSparseImageFormat-
// Properties(2) and friends. None of them runs a shader, so `programs()` hands back an
// empty collection and there is no manifest entry for this file.
//
// Ported so far, out of `dEQP-VK.api.info.*`:
//   format_properties                              225
//   image_format_properties                       1186
//   unsupported_image_usage                       2220
//   get_physical_device_properties2               2209 of 2216
//   image_format_properties2                      1186
//   extended_flags_image_format_properties2       1186
//   sparse_image_format_properties2               1110
//   extended_flags_sparse_image_format_properties2 1110
//
// Not ported: `get_physical_device_properties2.properties.basic`, which enumerates
// every extension property struct from upstream's generated table, the six
// `features.*` cases upstream hand-writes rather than generates;
// `extension_core_versions`,
// `vulkan1p2`/`1p3`/`1p4`, `profiles`. (`vulkan1p3_limits_validation`,
// `vulkan1p4_limits_validation` and `subgroup_features` live in limits_validation_tests.rs.) `android` is Android-only upstream and has no mustpass entry.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::feature_struct_list::{FEATURE_STRUCTS, FeatureStruct};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

// bitflags 1.x - which is what vulkanalia uses - has no `from_bits_retain`. The
// difference matters: upstream builds its "everything is allowed" masks as a plain
// `~0u`, so a bit the driver reports that these headers do not know about must be
// kept. `from_bits_truncate` would silently drop it and turn an allowed feature into a
// reported violation. `from_bits_unchecked` is the retaining constructor, and it is
// sound here because a bitflag is an integer with no validity invariant.
#[inline]
fn format_features_retain(bits: u32) -> vk::FormatFeatureFlags {
    unsafe { vk::FormatFeatureFlags::from_bits_unchecked(bits) }
}

#[inline]
fn format_features2_retain(bits: u64) -> vk::FormatFeatureFlags2 {
    unsafe { vk::FormatFeatureFlags2::from_bits_unchecked(bits) }
}

#[inline]
fn sample_counts_retain(bits: u32) -> vk::SampleCountFlags {
    unsafe { vk::SampleCountFlags::from_bits_unchecked(bits) }
}

#[inline]
fn image_usage_retain(bits: u32) -> vk::ImageUsageFlags {
    unsafe { vk::ImageUsageFlags::from_bits_unchecked(bits) }
}

#[inline]
fn image_create_retain(bits: u32) -> vk::ImageCreateFlags {
    unsafe { vk::ImageCreateFlags::from_bits_unchecked(bits) }
}

/// Every case in this file is a query; none of them has a shader.
const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `MINIMUM_REQUIRED_IMAGE_RESOURCE_SIZE` - minimum for `VkImageFormatProperties::maxResourceSize` (2GiB).
const MINIMUM_REQUIRED_IMAGE_RESOURCE_SIZE: vk::DeviceSize = 1 << 31;

/// `VK_CORE_FORMAT_LAST`
const VK_CORE_FORMAT_LAST: usize = 185;

// ---------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------
// VkFormat table
// ---------------------------------------------------------------------------------

/// `tcu::TextureChannelClass`, for the one place a format's numeric class decides
/// which sample-count limit applies.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ChannelClass {
    SignedFixedPoint,
    UnsignedFixedPoint,
    SignedInteger,
    UnsignedInteger,
    FloatingPoint,
    /// `TEXTURECHANNELCLASS_LAST` - the combined depth/stencil types, which have no class.
    Last,
}

/// One row of the format table: the enum value, the name upstream builds case names
/// from, and the handful of facts `vkImageUtil`'s `mapVkFormat`/`isCompressedFormat`/
/// `isYCbCrFormat`/`getPlaneCount` would answer for it.
///
/// Generated from `vk.xml` (the same registry upstream's `gen_framework.py` reads) and
/// checked name-for-name against the mustpass list; it lives here rather than in
/// `src/vk/` because nothing else in the port needs it yet.
#[derive(Clone, Copy)]
struct FormatInfo {
    format: vk::Format,
    /// `de::toLower(string(getFormatName(format)).substr(10))`
    name: &'static str,
    compressed: bool,
    ycbcr: bool,
    plane_count: u32,
    /// `tcu::getNumUsedChannels(mapVkFormat(format).order)`
    num_used_channels: u32,
    /// `mapVkFormat(format).getPixelSize()`, in bytes; 0 for block-compressed formats.
    pixel_size: u32,
    has_depth: bool,
    has_stencil: bool,
    channel_class: ChannelClass,
}

#[allow(clippy::too_many_arguments)]
const fn f(
    value: i32,
    name: &'static str,
    compressed: bool,
    ycbcr: bool,
    plane_count: u32,
    num_used_channels: u32,
    pixel_size: u32,
    has_depth: bool,
    has_stencil: bool,
    channel_class: ChannelClass,
) -> FormatInfo {
    FormatInfo {
        format: vk::Format::from_raw(value),
        name,
        compressed,
        ycbcr,
        plane_count,
        num_used_channels,
        pixel_size,
        has_depth,
        has_stencil,
        channel_class,
    }
}

/// The three ranges `createFormatTests` walks: the core formats `[0, VK_CORE_FORMAT_LAST)`,
/// the YCbCr formats `[G8B8G8R8_422_UNORM, G16_B16_R16_3PLANE_444_UNORM]`, and the YCbCr
/// extended formats `[G8_B8R8_2PLANE_444_UNORM, G16_B16R16_2PLANE_444_UNORM]`.
static FORMAT_INFO: &[FormatInfo] = &[
    f(0, "undefined", false, false, 1, 0, 0, false, false, ChannelClass::Last),
    f(
        1,
        "r4g4_unorm_pack8",
        false,
        false,
        1,
        2,
        1,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        2,
        "r4g4b4a4_unorm_pack16",
        false,
        false,
        1,
        4,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        3,
        "b4g4r4a4_unorm_pack16",
        false,
        false,
        1,
        4,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        4,
        "r5g6b5_unorm_pack16",
        false,
        false,
        1,
        3,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        5,
        "b5g6r5_unorm_pack16",
        false,
        false,
        1,
        3,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        6,
        "r5g5b5a1_unorm_pack16",
        false,
        false,
        1,
        4,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        7,
        "b5g5r5a1_unorm_pack16",
        false,
        false,
        1,
        4,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        8,
        "a1r5g5b5_unorm_pack16",
        false,
        false,
        1,
        4,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        9,
        "r8_unorm",
        false,
        false,
        1,
        1,
        1,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        10,
        "r8_snorm",
        false,
        false,
        1,
        1,
        1,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        11,
        "r8_uscaled",
        false,
        false,
        1,
        1,
        1,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        12,
        "r8_sscaled",
        false,
        false,
        1,
        1,
        1,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        13,
        "r8_uint",
        false,
        false,
        1,
        1,
        1,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        14,
        "r8_sint",
        false,
        false,
        1,
        1,
        1,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        15,
        "r8_srgb",
        false,
        false,
        1,
        1,
        1,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        16,
        "r8g8_unorm",
        false,
        false,
        1,
        2,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        17,
        "r8g8_snorm",
        false,
        false,
        1,
        2,
        2,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        18,
        "r8g8_uscaled",
        false,
        false,
        1,
        2,
        2,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        19,
        "r8g8_sscaled",
        false,
        false,
        1,
        2,
        2,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        20,
        "r8g8_uint",
        false,
        false,
        1,
        2,
        2,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        21,
        "r8g8_sint",
        false,
        false,
        1,
        2,
        2,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        22,
        "r8g8_srgb",
        false,
        false,
        1,
        2,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        23,
        "r8g8b8_unorm",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        24,
        "r8g8b8_snorm",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        25,
        "r8g8b8_uscaled",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        26,
        "r8g8b8_sscaled",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        27,
        "r8g8b8_uint",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        28,
        "r8g8b8_sint",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        29,
        "r8g8b8_srgb",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        30,
        "b8g8r8_unorm",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        31,
        "b8g8r8_snorm",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        32,
        "b8g8r8_uscaled",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        33,
        "b8g8r8_sscaled",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        34,
        "b8g8r8_uint",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        35,
        "b8g8r8_sint",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        36,
        "b8g8r8_srgb",
        false,
        false,
        1,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        37,
        "r8g8b8a8_unorm",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        38,
        "r8g8b8a8_snorm",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        39,
        "r8g8b8a8_uscaled",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        40,
        "r8g8b8a8_sscaled",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        41,
        "r8g8b8a8_uint",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        42,
        "r8g8b8a8_sint",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        43,
        "r8g8b8a8_srgb",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        44,
        "b8g8r8a8_unorm",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        45,
        "b8g8r8a8_snorm",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        46,
        "b8g8r8a8_uscaled",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        47,
        "b8g8r8a8_sscaled",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        48,
        "b8g8r8a8_uint",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        49,
        "b8g8r8a8_sint",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        50,
        "b8g8r8a8_srgb",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        51,
        "a8b8g8r8_unorm_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        52,
        "a8b8g8r8_snorm_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        53,
        "a8b8g8r8_uscaled_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        54,
        "a8b8g8r8_sscaled_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        55,
        "a8b8g8r8_uint_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        56,
        "a8b8g8r8_sint_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        57,
        "a8b8g8r8_srgb_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        58,
        "a2r10g10b10_unorm_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        59,
        "a2r10g10b10_snorm_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        60,
        "a2r10g10b10_uscaled_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        61,
        "a2r10g10b10_sscaled_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        62,
        "a2r10g10b10_uint_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        63,
        "a2r10g10b10_sint_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        64,
        "a2b10g10r10_unorm_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        65,
        "a2b10g10r10_snorm_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        66,
        "a2b10g10r10_uscaled_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        67,
        "a2b10g10r10_sscaled_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        68,
        "a2b10g10r10_uint_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        69,
        "a2b10g10r10_sint_pack32",
        false,
        false,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        70,
        "r16_unorm",
        false,
        false,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        71,
        "r16_snorm",
        false,
        false,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        72,
        "r16_uscaled",
        false,
        false,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        73,
        "r16_sscaled",
        false,
        false,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        74,
        "r16_uint",
        false,
        false,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        75,
        "r16_sint",
        false,
        false,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        76,
        "r16_sfloat",
        false,
        false,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        77,
        "r16g16_unorm",
        false,
        false,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        78,
        "r16g16_snorm",
        false,
        false,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        79,
        "r16g16_uscaled",
        false,
        false,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        80,
        "r16g16_sscaled",
        false,
        false,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        81,
        "r16g16_uint",
        false,
        false,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        82,
        "r16g16_sint",
        false,
        false,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        83,
        "r16g16_sfloat",
        false,
        false,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        84,
        "r16g16b16_unorm",
        false,
        false,
        1,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        85,
        "r16g16b16_snorm",
        false,
        false,
        1,
        3,
        6,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        86,
        "r16g16b16_uscaled",
        false,
        false,
        1,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        87,
        "r16g16b16_sscaled",
        false,
        false,
        1,
        3,
        6,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        88,
        "r16g16b16_uint",
        false,
        false,
        1,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        89,
        "r16g16b16_sint",
        false,
        false,
        1,
        3,
        6,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        90,
        "r16g16b16_sfloat",
        false,
        false,
        1,
        3,
        6,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        91,
        "r16g16b16a16_unorm",
        false,
        false,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        92,
        "r16g16b16a16_snorm",
        false,
        false,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        93,
        "r16g16b16a16_uscaled",
        false,
        false,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        94,
        "r16g16b16a16_sscaled",
        false,
        false,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        95,
        "r16g16b16a16_uint",
        false,
        false,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        96,
        "r16g16b16a16_sint",
        false,
        false,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        97,
        "r16g16b16a16_sfloat",
        false,
        false,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        98,
        "r32_uint",
        false,
        false,
        1,
        1,
        4,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        99,
        "r32_sint",
        false,
        false,
        1,
        1,
        4,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        100,
        "r32_sfloat",
        false,
        false,
        1,
        1,
        4,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        101,
        "r32g32_uint",
        false,
        false,
        1,
        2,
        8,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        102,
        "r32g32_sint",
        false,
        false,
        1,
        2,
        8,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        103,
        "r32g32_sfloat",
        false,
        false,
        1,
        2,
        8,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        104,
        "r32g32b32_uint",
        false,
        false,
        1,
        3,
        12,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        105,
        "r32g32b32_sint",
        false,
        false,
        1,
        3,
        12,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        106,
        "r32g32b32_sfloat",
        false,
        false,
        1,
        3,
        12,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        107,
        "r32g32b32a32_uint",
        false,
        false,
        1,
        4,
        16,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        108,
        "r32g32b32a32_sint",
        false,
        false,
        1,
        4,
        16,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        109,
        "r32g32b32a32_sfloat",
        false,
        false,
        1,
        4,
        16,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        110,
        "r64_uint",
        false,
        false,
        1,
        1,
        8,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        111,
        "r64_sint",
        false,
        false,
        1,
        1,
        8,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        112,
        "r64_sfloat",
        false,
        false,
        1,
        1,
        8,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        113,
        "r64g64_uint",
        false,
        false,
        1,
        2,
        16,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        114,
        "r64g64_sint",
        false,
        false,
        1,
        2,
        16,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        115,
        "r64g64_sfloat",
        false,
        false,
        1,
        2,
        16,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        116,
        "r64g64b64_uint",
        false,
        false,
        1,
        3,
        24,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        117,
        "r64g64b64_sint",
        false,
        false,
        1,
        3,
        24,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        118,
        "r64g64b64_sfloat",
        false,
        false,
        1,
        3,
        24,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        119,
        "r64g64b64a64_uint",
        false,
        false,
        1,
        4,
        32,
        false,
        false,
        ChannelClass::UnsignedInteger,
    ),
    f(
        120,
        "r64g64b64a64_sint",
        false,
        false,
        1,
        4,
        32,
        false,
        false,
        ChannelClass::SignedInteger,
    ),
    f(
        121,
        "r64g64b64a64_sfloat",
        false,
        false,
        1,
        4,
        32,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        122,
        "b10g11r11_ufloat_pack32",
        false,
        false,
        1,
        3,
        4,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        123,
        "e5b9g9r9_ufloat_pack32",
        false,
        false,
        1,
        3,
        4,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        124,
        "d16_unorm",
        false,
        false,
        1,
        1,
        2,
        true,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        125,
        "x8_d24_unorm_pack32",
        false,
        false,
        1,
        1,
        4,
        true,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        126,
        "d32_sfloat",
        false,
        false,
        1,
        1,
        4,
        true,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        127,
        "s8_uint",
        false,
        false,
        1,
        1,
        1,
        false,
        true,
        ChannelClass::UnsignedInteger,
    ),
    f(
        128,
        "d16_unorm_s8_uint",
        false,
        false,
        1,
        2,
        3,
        true,
        true,
        ChannelClass::Last,
    ),
    f(
        129,
        "d24_unorm_s8_uint",
        false,
        false,
        1,
        2,
        4,
        true,
        true,
        ChannelClass::Last,
    ),
    f(
        130,
        "d32_sfloat_s8_uint",
        false,
        false,
        1,
        2,
        5,
        true,
        true,
        ChannelClass::Last,
    ),
    f(
        131,
        "bc1_rgb_unorm_block",
        true,
        false,
        1,
        3,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        132,
        "bc1_rgb_srgb_block",
        true,
        false,
        1,
        3,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        133,
        "bc1_rgba_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        134,
        "bc1_rgba_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        135,
        "bc2_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        136,
        "bc2_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        137,
        "bc3_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        138,
        "bc3_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        139,
        "bc4_unorm_block",
        true,
        false,
        1,
        1,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        140,
        "bc4_snorm_block",
        true,
        false,
        1,
        1,
        0,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        141,
        "bc5_unorm_block",
        true,
        false,
        1,
        2,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        142,
        "bc5_snorm_block",
        true,
        false,
        1,
        2,
        0,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        143,
        "bc6h_ufloat_block",
        true,
        false,
        1,
        3,
        0,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        144,
        "bc6h_sfloat_block",
        true,
        false,
        1,
        3,
        0,
        false,
        false,
        ChannelClass::FloatingPoint,
    ),
    f(
        145,
        "bc7_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        146,
        "bc7_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        147,
        "etc2_r8g8b8_unorm_block",
        true,
        false,
        1,
        3,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        148,
        "etc2_r8g8b8_srgb_block",
        true,
        false,
        1,
        3,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        149,
        "etc2_r8g8b8a1_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        150,
        "etc2_r8g8b8a1_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        151,
        "etc2_r8g8b8a8_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        152,
        "etc2_r8g8b8a8_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        153,
        "eac_r11_unorm_block",
        true,
        false,
        1,
        1,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        154,
        "eac_r11_snorm_block",
        true,
        false,
        1,
        1,
        0,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        155,
        "eac_r11g11_unorm_block",
        true,
        false,
        1,
        2,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        156,
        "eac_r11g11_snorm_block",
        true,
        false,
        1,
        2,
        0,
        false,
        false,
        ChannelClass::SignedFixedPoint,
    ),
    f(
        157,
        "astc_4x4_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        158,
        "astc_4x4_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        159,
        "astc_5x4_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        160,
        "astc_5x4_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        161,
        "astc_5x5_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        162,
        "astc_5x5_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        163,
        "astc_6x5_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        164,
        "astc_6x5_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        165,
        "astc_6x6_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        166,
        "astc_6x6_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        167,
        "astc_8x5_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        168,
        "astc_8x5_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        169,
        "astc_8x6_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        170,
        "astc_8x6_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        171,
        "astc_8x8_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        172,
        "astc_8x8_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        173,
        "astc_10x5_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        174,
        "astc_10x5_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        175,
        "astc_10x6_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        176,
        "astc_10x6_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        177,
        "astc_10x8_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        178,
        "astc_10x8_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        179,
        "astc_10x10_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        180,
        "astc_10x10_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        181,
        "astc_12x10_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        182,
        "astc_12x10_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        183,
        "astc_12x12_unorm_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        184,
        "astc_12x12_srgb_block",
        true,
        false,
        1,
        4,
        0,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156000,
        "g8b8g8r8_422_unorm",
        false,
        true,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156001,
        "b8g8r8g8_422_unorm",
        false,
        true,
        1,
        4,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156002,
        "g8_b8_r8_3plane_420_unorm",
        false,
        true,
        3,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156003,
        "g8_b8r8_2plane_420_unorm",
        false,
        true,
        2,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156004,
        "g8_b8_r8_3plane_422_unorm",
        false,
        true,
        3,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156005,
        "g8_b8r8_2plane_422_unorm",
        false,
        true,
        2,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156006,
        "g8_b8_r8_3plane_444_unorm",
        false,
        true,
        3,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156007,
        "r10x6_unorm_pack16",
        false,
        true,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156008,
        "r10x6g10x6_unorm_2pack16",
        false,
        true,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156009,
        "r10x6g10x6b10x6a10x6_unorm_4pack16",
        false,
        true,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156010,
        "g10x6b10x6g10x6r10x6_422_unorm_4pack16",
        false,
        true,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156011,
        "b10x6g10x6r10x6g10x6_422_unorm_4pack16",
        false,
        true,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156012,
        "g10x6_b10x6_r10x6_3plane_420_unorm_3pack16",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156013,
        "g10x6_b10x6r10x6_2plane_420_unorm_3pack16",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156014,
        "g10x6_b10x6_r10x6_3plane_422_unorm_3pack16",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156015,
        "g10x6_b10x6r10x6_2plane_422_unorm_3pack16",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156016,
        "g10x6_b10x6_r10x6_3plane_444_unorm_3pack16",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156017,
        "r12x4_unorm_pack16",
        false,
        true,
        1,
        1,
        2,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156018,
        "r12x4g12x4_unorm_2pack16",
        false,
        true,
        1,
        2,
        4,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156019,
        "r12x4g12x4b12x4a12x4_unorm_4pack16",
        false,
        true,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156020,
        "g12x4b12x4g12x4r12x4_422_unorm_4pack16",
        false,
        true,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156021,
        "b12x4g12x4r12x4g12x4_422_unorm_4pack16",
        false,
        true,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156022,
        "g12x4_b12x4_r12x4_3plane_420_unorm_3pack16",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156023,
        "g12x4_b12x4r12x4_2plane_420_unorm_3pack16",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156024,
        "g12x4_b12x4_r12x4_3plane_422_unorm_3pack16",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156025,
        "g12x4_b12x4r12x4_2plane_422_unorm_3pack16",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156026,
        "g12x4_b12x4_r12x4_3plane_444_unorm_3pack16",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156027,
        "g16b16g16r16_422_unorm",
        false,
        true,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156028,
        "b16g16r16g16_422_unorm",
        false,
        true,
        1,
        4,
        8,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156029,
        "g16_b16_r16_3plane_420_unorm",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156030,
        "g16_b16r16_2plane_420_unorm",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156031,
        "g16_b16_r16_3plane_422_unorm",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156032,
        "g16_b16r16_2plane_422_unorm",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000156033,
        "g16_b16_r16_3plane_444_unorm",
        false,
        true,
        3,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000330000,
        "g8_b8r8_2plane_444_unorm",
        false,
        true,
        2,
        3,
        3,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000330001,
        "g10x6_b10x6r10x6_2plane_444_unorm_3pack16",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000330002,
        "g12x4_b12x4r12x4_2plane_444_unorm_3pack16",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
    f(
        1000330003,
        "g16_b16r16_2plane_444_unorm",
        false,
        true,
        2,
        3,
        6,
        false,
        false,
        ChannelClass::UnsignedFixedPoint,
    ),
];

/// `[VK_FORMAT_UNDEFINED, VK_CORE_FORMAT_LAST)`
fn core_formats() -> &'static [FormatInfo] {
    &FORMAT_INFO[..VK_CORE_FORMAT_LAST]
}

/// The YCbCr and YCbCr-extended ranges, which only the 2D image-format groups walk.
/// Ported from upstream but not yet wired to a caller: the YCbCr-specific format
/// checks it feeds are part of `image_format_properties`, which is not ported.
#[allow(dead_code)]
fn ycbcr_formats() -> &'static [FormatInfo] {
    &FORMAT_INFO[VK_CORE_FORMAT_LAST..]
}

/// What `addImageCompressionControlTests` walks: every non-compressed format of the core,
/// YCbCr and YCbCr extended ranges, as (format, case name, is YCbCr, plane count).
pub(super) fn uncompressed_formats_with_planes() -> Vec<(vk::Format, &'static str, bool, u32)> {
    FORMAT_INFO
        .iter()
        .filter(|info| info.format != vk::Format::UNDEFINED && !info.compressed)
        .map(|info| (info.format, info.name, info.ycbcr, info.plane_count))
        .collect()
}

fn format_info(format: vk::Format) -> FormatInfo {
    let raw = format.as_raw();
    match FORMAT_INFO.binary_search_by_key(&raw, |i| i.format.as_raw()) {
        Ok(ndx) => FORMAT_INFO[ndx],
        // Only formats taken out of the table are ever handed to these tests, so this
        // is unreachable; answering "plain colour format" keeps it total either way.
        Err(_) => f(raw, "", false, false, 1, 4, 0, false, false, ChannelClass::Last),
    }
}

/// `vk::isCompressedFormat`
fn is_compressed_format(format: vk::Format) -> bool {
    format_info(format).compressed
}

/// `vk::isYCbCrFormat`
fn is_ycbcr_format(format: vk::Format) -> bool {
    format_info(format).ycbcr
}

/// `vk::isDepthStencilFormat`
fn is_depth_stencil_format(format: vk::Format) -> bool {
    let info = format_info(format);
    if info.compressed || info.ycbcr {
        return false;
    }
    info.has_depth || info.has_stencil
}

/// `vk::getPlaneCount`
fn get_plane_count(format: vk::Format) -> u32 {
    format_info(format).plane_count
}

// ---------------------------------------------------------------------------------
// Small pieces of vkt::Context and vk:: that this file needs
// ---------------------------------------------------------------------------------

/// `Context::getUsedApiVersion`.
///
/// Upstream builds its instance at the highest version the loader reports, so its used
/// version is effectively the physical device's. hodow_cts asks for 1.1 at instance
/// level, so the device property is the closest equivalent and is what the queries in
/// this file are gated on.
fn get_used_api_version(context: &Context<'_>) -> u32 {
    context.get_device_properties().api_version
}

/// `Context::contextSupports`
fn context_supports(context: &Context<'_>, version: u32) -> bool {
    get_used_api_version(context) >= version
}

/// `isApiVersionEqual` - compares the major/minor pair only.
fn is_api_version_equal(a: u32, b: u32) -> bool {
    vk::version_major(a) == vk::version_major(b) && vk::version_minor(a) == vk::version_minor(b)
}

/// `vk::isCoreDeviceExtension`, for the extensions this file asks about. A wrong entry
/// turns a real verdict into NotSupported, so the table is explicit rather than derived.
fn core_device_extension_version(extension: &str) -> Option<u32> {
    Some(match extension {
        "VK_KHR_maintenance1" | "VK_KHR_sampler_ycbcr_conversion" | "VK_KHR_get_physical_device_properties2" => {
            vk::make_version(1, 1, 0)
        }
        "VK_EXT_sampler_filter_minmax" => vk::make_version(1, 2, 0),
        "VK_KHR_format_feature_flags2" => vk::make_version(1, 3, 0),
        _ => return None,
    })
}

fn is_core_device_extension(api_version: u32, extension: &str) -> bool {
    core_device_extension_version(extension).is_some_and(|promoted| api_version >= promoted)
}

/// `Context::isDeviceFunctionalitySupported`
fn is_device_functionality_supported(context: &Context<'_>, extension: &str) -> bool {
    context.get_device_extensions().iter().any(|e| e == extension)
        || is_core_device_extension(get_used_api_version(context), extension)
}

/// `de::contains(context.getDeviceExtensions().begin(), ..., name)` - the raw advertised
/// list, without the promoted-to-core fallback. Upstream uses both spellings and they
/// are not interchangeable, so both are kept.
fn has_device_extension(context: &Context<'_>, extension: &str) -> bool {
    context.get_device_extensions().iter().any(|e| e == extension)
}

/// `vk::getPhysicalDeviceFormatProperties`
fn get_physical_device_format_properties(context: &Context<'_>, format: vk::Format) -> vk::FormatProperties {
    unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    }
}

/// `getPhysicalDeviceSamplerYcbcrConversionFeatures`
fn get_physical_device_sampler_ycbcr_conversion_features(
    context: &Context<'_>,
) -> vk::PhysicalDeviceSamplerYcbcrConversionFeatures {
    let mut ycbcr_features = vk::PhysicalDeviceSamplerYcbcrConversionFeatures::default();
    let mut core_features = vk::PhysicalDeviceFeatures2::builder().push_next(&mut ycbcr_features);

    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut core_features)
    };

    ycbcr_features
}

/// `Context::getDeviceVulkan12Properties`
fn get_device_vulkan12_properties(context: &Context<'_>) -> vk::PhysicalDeviceVulkan12Properties {
    let mut vulkan12_properties = vk::PhysicalDeviceVulkan12Properties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut vulkan12_properties);

    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };

    vulkan12_properties
}

/// `Context::getLinearColorAttachmentFeatures`
fn get_linear_color_attachment_features(context: &Context<'_>) -> vk::PhysicalDeviceLinearColorAttachmentFeaturesNV {
    let mut linear_color_attachment_features = vk::PhysicalDeviceLinearColorAttachmentFeaturesNV::default();
    if !is_device_functionality_supported(context, "VK_NV_linear_color_attachment") {
        return linear_color_attachment_features;
    }

    let mut core_features = vk::PhysicalDeviceFeatures2::builder().push_next(&mut linear_color_attachment_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut core_features)
    };

    linear_color_attachment_features
}

/// `Context::getFormatProperties`.
///
/// The fallback branch is upstream's `getRequiredFormatProperties` reduced to the plain
/// widening: every extra bit that function synthesises
/// (`STORAGE_{READ,WRITE}_WITHOUT_FORMAT`, `SAMPLED_IMAGE_DEPTH_COMPARISON`, and a
/// `STORAGE_IMAGE`/`STORAGE_TEXEL_BUFFER` that is only re-added where it was already
/// set) is outside the set `unsupportedImageUsage` - this file's only caller - looks at.
fn get_format_properties3(context: &Context<'_>, format: vk::Format) -> vk::FormatProperties3 {
    if is_device_functionality_supported(context, "VK_KHR_format_feature_flags2") {
        let mut p = vk::FormatProperties3::default();
        let mut properties = vk::FormatProperties2::builder().push_next(&mut p);

        unsafe {
            context.get_instance().get_physical_device_format_properties2(
                context.get_physical_device(),
                format,
                &mut properties,
            )
        };

        return p;
    }

    let properties = get_physical_device_format_properties(context, format);
    vk::FormatProperties3 {
        linear_tiling_features: format_features2_retain(u64::from(properties.linear_tiling_features.bits())),
        optimal_tiling_features: format_features2_retain(u64::from(properties.optimal_tiling_features.bits())),
        buffer_features: format_features2_retain(u64::from(properties.buffer_features.bits())),
        ..Default::default()
    }
}

/// `getFormatFeatureFlagsStr`, for the messages the result collector reports. Message
/// text does not change a verdict; the bit names are kept spelled as upstream prints
/// them so a failure reads the same on both sides.
fn get_format_feature_flags_str(flags: vk::FormatFeatureFlags) -> String {
    const NAMES: &[(u32, &str)] = &[
        (1, "VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT"),
        (1 << 1, "VK_FORMAT_FEATURE_STORAGE_IMAGE_BIT"),
        (1 << 2, "VK_FORMAT_FEATURE_STORAGE_IMAGE_ATOMIC_BIT"),
        (1 << 3, "VK_FORMAT_FEATURE_UNIFORM_TEXEL_BUFFER_BIT"),
        (1 << 4, "VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_BIT"),
        (1 << 5, "VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_ATOMIC_BIT"),
        (1 << 6, "VK_FORMAT_FEATURE_VERTEX_BUFFER_BIT"),
        (1 << 7, "VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BIT"),
        (1 << 8, "VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BLEND_BIT"),
        (1 << 9, "VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT"),
        (1 << 10, "VK_FORMAT_FEATURE_BLIT_SRC_BIT"),
        (1 << 11, "VK_FORMAT_FEATURE_BLIT_DST_BIT"),
        (1 << 12, "VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_LINEAR_BIT"),
        (1 << 13, "VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_CUBIC_BIT_EXT"),
        (1 << 14, "VK_FORMAT_FEATURE_TRANSFER_SRC_BIT"),
        (1 << 15, "VK_FORMAT_FEATURE_TRANSFER_DST_BIT"),
        (1 << 16, "VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_MINMAX_BIT"),
        (1 << 17, "VK_FORMAT_FEATURE_MIDPOINT_CHROMA_SAMPLES_BIT"),
        (
            1 << 18,
            "VK_FORMAT_FEATURE_SAMPLED_IMAGE_YCBCR_CONVERSION_LINEAR_FILTER_BIT",
        ),
        (
            1 << 19,
            "VK_FORMAT_FEATURE_SAMPLED_IMAGE_YCBCR_CONVERSION_SEPARATE_RECONSTRUCTION_FILTER_BIT",
        ),
        (
            1 << 20,
            "VK_FORMAT_FEATURE_SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT_BIT",
        ),
        (
            1 << 21,
            "VK_FORMAT_FEATURE_SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT_FORCEABLE_BIT",
        ),
        (1 << 22, "VK_FORMAT_FEATURE_DISJOINT_BIT"),
        (1 << 23, "VK_FORMAT_FEATURE_COSITED_CHROMA_SAMPLES_BIT"),
        (1 << 24, "VK_FORMAT_FEATURE_FRAGMENT_DENSITY_MAP_BIT_EXT"),
        (1 << 25, "VK_FORMAT_FEATURE_VIDEO_DECODE_OUTPUT_BIT_KHR"),
        (1 << 26, "VK_FORMAT_FEATURE_VIDEO_DECODE_DPB_BIT_KHR"),
        (1 << 27, "VK_FORMAT_FEATURE_VIDEO_ENCODE_INPUT_BIT_KHR"),
        (1 << 28, "VK_FORMAT_FEATURE_VIDEO_ENCODE_DPB_BIT_KHR"),
        (
            1 << 29,
            "VK_FORMAT_FEATURE_ACCELERATION_STRUCTURE_VERTEX_BUFFER_BIT_KHR",
        ),
        (1 << 30, "VK_FORMAT_FEATURE_FRAGMENT_SHADING_RATE_ATTACHMENT_BIT_KHR"),
    ];

    let bits = flags.bits();
    let mut out: Vec<&str> = Vec::new();
    let mut leftover = bits;
    for (bit, name) in NAMES {
        if bits & bit != 0 {
            out.push(name);
            leftover &= !bit;
        }
    }
    if out.is_empty() {
        return "0".to_string();
    }
    let mut s = out.join("|");
    if leftover != 0 {
        s.push_str(&format!("|{leftover:#x}"));
    }
    s
}

// ---------------------------------------------------------------------------------
// VK_KHR_extended_flags
//
// The `extended_flags_*` groups chain VkImageCreateFlags2CreateInfoKHR /
// VkImageUsageFlags2CreateInfoKHR, which the bindings do not carry yet. They are
// declared here rather than in src/vk/ so this file stays self-contained; both are
// plain repr(C) headers plus a 64-bit flags word, and the sType values are the ones
// vk.xml assigns to extension 669.
// ---------------------------------------------------------------------------------

const STRUCTURE_TYPE_IMAGE_CREATE_FLAGS_2_CREATE_INFO_KHR: i32 = 1_000_668_001;
const STRUCTURE_TYPE_IMAGE_USAGE_FLAGS_2_CREATE_INFO_KHR: i32 = 1_000_668_002;

/// `VK_KHR_EXTENDED_FLAGS_EXTENSION_NAME`
const VK_KHR_EXTENDED_FLAGS_EXTENSION_NAME: &str = "VK_KHR_extended_flags";

#[repr(C)]
struct ImageCreateFlags2CreateInfoKHR {
    s_type: i32,
    next: *const c_void,
    flags: u64,
}

#[repr(C)]
struct ImageUsageFlags2CreateInfoKHR {
    s_type: i32,
    next: *const c_void,
    usage: u64,
}

/// `checkExtendedFlagsSupport`
fn check_extended_flags_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality(VK_KHR_EXTENDED_FLAGS_EXTENSION_NAME)
}

// ---------------------------------------------------------------------------------
// Mandatory format features
//
// These three tables are the substance of `format_properties`: they say which
// VkFormatFeatureFlags the spec requires of every format. A wrong entry produces a
// wrong verdict on real hardware, so they are transcribed line for line from upstream.
// ---------------------------------------------------------------------------------

const SAIM: u32 = vk::FormatFeatureFlags::SAMPLED_IMAGE.bits();
const BLSR: u32 = vk::FormatFeatureFlags::BLIT_SRC.bits();
const SIFL: u32 = vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR.bits();
const COAT: u32 = vk::FormatFeatureFlags::COLOR_ATTACHMENT.bits();
const BLDS: u32 = vk::FormatFeatureFlags::BLIT_DST.bits();
const CABL: u32 = vk::FormatFeatureFlags::COLOR_ATTACHMENT_BLEND.bits();
const STIM: u32 = vk::FormatFeatureFlags::STORAGE_IMAGE.bits();
const STIA: u32 = vk::FormatFeatureFlags::STORAGE_IMAGE_ATOMIC.bits();
const DSAT: u32 = vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT.bits();
const TRSR: u32 = vk::FormatFeatureFlags::TRANSFER_SRC.bits();
const TRDS: u32 = vk::FormatFeatureFlags::TRANSFER_DST.bits();

/// `getBaseRequiredOptimalTilingFeatures`
fn get_base_required_optimal_tiling_features(format: vk::Format) -> vk::FormatFeatureFlags {
    /// `Formatpair`
    struct Formatpair(vk::Format, u32);

    static FORMATFLAGS: &[Formatpair] = &[
        Formatpair(vk::Format::B4G4R4A4_UNORM_PACK16, SAIM | BLSR | TRSR | TRDS | SIFL),
        Formatpair(
            vk::Format::R5G6B5_UNORM_PACK16,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(
            vk::Format::A1R5G5B5_UNORM_PACK16,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(
            vk::Format::R8_UNORM,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(vk::Format::R8_SNORM, SAIM | BLSR | TRSR | TRDS | SIFL),
        Formatpair(vk::Format::R8_UINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS),
        Formatpair(vk::Format::R8_SINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS),
        Formatpair(
            vk::Format::R8G8_UNORM,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(vk::Format::R8G8_SNORM, SAIM | BLSR | TRSR | TRDS | SIFL),
        Formatpair(vk::Format::R8G8_UINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS),
        Formatpair(vk::Format::R8G8_SINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS),
        Formatpair(
            vk::Format::R8G8B8A8_UNORM,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | STIM | CABL,
        ),
        Formatpair(vk::Format::R8G8B8A8_SNORM, SAIM | BLSR | TRSR | TRDS | SIFL | STIM),
        Formatpair(
            vk::Format::R8G8B8A8_UINT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM,
        ),
        Formatpair(
            vk::Format::R8G8B8A8_SINT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM,
        ),
        Formatpair(
            vk::Format::R8G8B8A8_SRGB,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(
            vk::Format::B8G8R8A8_UNORM,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(
            vk::Format::B8G8R8A8_SRGB,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(
            vk::Format::A8B8G8R8_UNORM_PACK32,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(vk::Format::A8B8G8R8_SNORM_PACK32, SAIM | BLSR | TRSR | TRDS | SIFL),
        Formatpair(
            vk::Format::A8B8G8R8_UINT_PACK32,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS,
        ),
        Formatpair(
            vk::Format::A8B8G8R8_SINT_PACK32,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS,
        ),
        Formatpair(
            vk::Format::A8B8G8R8_SRGB_PACK32,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(
            vk::Format::A2B10G10R10_UNORM_PACK32,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(
            vk::Format::A2B10G10R10_UINT_PACK32,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS,
        ),
        Formatpair(vk::Format::R16_UINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS),
        Formatpair(vk::Format::R16_SINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS),
        Formatpair(
            vk::Format::R16_SFLOAT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(vk::Format::R16G16_UINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS),
        Formatpair(vk::Format::R16G16_SINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS),
        Formatpair(
            vk::Format::R16G16_SFLOAT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | CABL,
        ),
        Formatpair(
            vk::Format::R16G16B16A16_UINT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM,
        ),
        Formatpair(
            vk::Format::R16G16B16A16_SINT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM,
        ),
        Formatpair(
            vk::Format::R16G16B16A16_SFLOAT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | SIFL | STIM | CABL,
        ),
        Formatpair(
            vk::Format::R32_UINT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM | STIA,
        ),
        Formatpair(
            vk::Format::R32_SINT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM | STIA,
        ),
        Formatpair(vk::Format::R32_SFLOAT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM),
        Formatpair(vk::Format::R32G32_UINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM),
        Formatpair(vk::Format::R32G32_SINT, SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM),
        Formatpair(
            vk::Format::R32G32_SFLOAT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM,
        ),
        Formatpair(
            vk::Format::R32G32B32A32_UINT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM,
        ),
        Formatpair(
            vk::Format::R32G32B32A32_SINT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM,
        ),
        Formatpair(
            vk::Format::R32G32B32A32_SFLOAT,
            SAIM | BLSR | TRSR | TRDS | COAT | BLDS | STIM,
        ),
        Formatpair(vk::Format::B10G11R11_UFLOAT_PACK32, SAIM | BLSR | TRSR | TRDS | SIFL),
        Formatpair(vk::Format::E5B9G9R9_UFLOAT_PACK32, SAIM | BLSR | TRSR | TRDS | SIFL),
        Formatpair(vk::Format::D16_UNORM, SAIM | BLSR | TRSR | TRDS | DSAT),
    ];

    for pair in FORMATFLAGS {
        if pair.0 == format {
            return format_features_retain(pair.1);
        }
    }
    vk::FormatFeatureFlags::empty()
}

/// `getRequiredOptimalExtendedTilingFeatures`
fn get_required_optimal_extended_tiling_features(
    context: &Context<'_>,
    format: vk::Format,
    queried_flags: vk::FormatFeatureFlags,
) -> vk::FormatFeatureFlags {
    let mut flags = vk::FormatFeatureFlags::empty();

    // VK_EXT_sampler_filter_minmax:
    //    If filterMinmaxSingleComponentFormats is VK_TRUE, the following formats must
    //    support the VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_MINMAX_BIT_EXT feature with
    //    VK_IMAGE_TILING_OPTIMAL, if they support VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT.
    static S_REQUIRED_SAMPLED_IMAGE_FILTER_MIN_MAX_FORMATS: &[vk::Format] = &[
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R16_UNORM,
        vk::Format::R16_SNORM,
        vk::Format::R16_SFLOAT,
        vk::Format::R32_SFLOAT,
        vk::Format::D16_UNORM,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D32_SFLOAT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];

    if queried_flags.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE)
        && has_device_extension(context, "VK_EXT_sampler_filter_minmax")
        && S_REQUIRED_SAMPLED_IMAGE_FILTER_MIN_MAX_FORMATS.contains(&format)
    {
        let mut physical_device_sampler_min_max_properties = vk::PhysicalDeviceSamplerFilterMinmaxProperties::default();
        {
            let mut physical_device_properties =
                vk::PhysicalDeviceProperties2::builder().push_next(&mut physical_device_sampler_min_max_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut physical_device_properties)
            };
        }

        if physical_device_sampler_min_max_properties.filter_minmax_single_component_formats == vk::TRUE {
            flags |= vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_MINMAX;
        }
    }

    // VK_EXT_filter_cubic:
    // If cubic filtering is supported, VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_CUBIC_BIT_EXT must be supported for the following image view types:
    // VK_IMAGE_VIEW_TYPE_2D, VK_IMAGE_VIEW_TYPE_2D_ARRAY
    static S_REQUIRED_SAMPLED_IMAGE_FILTER_CUBIC_FORMATS: &[vk::Format] = &[
        vk::Format::R4G4_UNORM_PACK8,
        vk::Format::R4G4B4A4_UNORM_PACK16,
        vk::Format::B4G4R4A4_UNORM_PACK16,
        vk::Format::R5G6B5_UNORM_PACK16,
        vk::Format::B5G6R5_UNORM_PACK16,
        vk::Format::R5G5B5A1_UNORM_PACK16,
        vk::Format::B5G5R5A1_UNORM_PACK16,
        vk::Format::A1R5G5B5_UNORM_PACK16,
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R8_SRGB,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8G8_SRGB,
        vk::Format::R8G8B8_UNORM,
        vk::Format::R8G8B8_SNORM,
        vk::Format::R8G8B8_SRGB,
        vk::Format::B8G8R8_UNORM,
        vk::Format::B8G8R8_SNORM,
        vk::Format::B8G8R8_SRGB,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_SRGB,
        vk::Format::B8G8R8A8_UNORM,
        vk::Format::B8G8R8A8_SNORM,
        vk::Format::B8G8R8A8_SRGB,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_SNORM_PACK32,
        vk::Format::A8B8G8R8_SRGB_PACK32,
    ];

    static S_REQUIRED_SAMPLED_IMAGE_FILTER_CUBIC_FORMATS_ETC2: &[vk::Format] = &[
        vk::Format::ETC2_R8G8B8_UNORM_BLOCK,
        vk::Format::ETC2_R8G8B8_SRGB_BLOCK,
        vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK,
        vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK,
        vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK,
        vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK,
    ];

    if queried_flags.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE)
        && has_device_extension(context, "VK_EXT_filter_cubic")
    {
        if S_REQUIRED_SAMPLED_IMAGE_FILTER_CUBIC_FORMATS.contains(&format) {
            flags |= vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_CUBIC_EXT;
        }

        let core_features = context.get_device_features();
        if core_features.texture_compression_etc2 == vk::TRUE
            && S_REQUIRED_SAMPLED_IMAGE_FILTER_CUBIC_FORMATS_ETC2.contains(&format)
        {
            flags |= vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_CUBIC_EXT;
        }
    }

    flags
}

/// `getRequiredBufferFeatures`
fn get_required_buffer_features(format: vk::Format) -> vk::FormatFeatureFlags {
    static S_REQUIRED_VERTEX_BUFFER_FORMATS: &[vk::Format] = &[
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::B8G8R8A8_UNORM,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_SNORM_PACK32,
        vk::Format::A8B8G8R8_UINT_PACK32,
        vk::Format::A8B8G8R8_SINT_PACK32,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::R16_UNORM,
        vk::Format::R16_SNORM,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16_UNORM,
        vk::Format::R16G16_SNORM,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R16G16B16A16_SNORM,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32_UINT,
        vk::Format::R32G32B32_SINT,
        vk::Format::R32G32B32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
    ];
    static S_REQUIRED_UNIFORM_TEXEL_BUFFER_FORMATS: &[vk::Format] = &[
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::B8G8R8A8_UNORM,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_SNORM_PACK32,
        vk::Format::A8B8G8R8_UINT_PACK32,
        vk::Format::A8B8G8R8_SINT_PACK32,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::A2B10G10R10_UINT_PACK32,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::B10G11R11_UFLOAT_PACK32,
    ];
    static S_REQUIRED_STORAGE_TEXEL_BUFFER_FORMATS: &[vk::Format] = &[
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_SNORM_PACK32,
        vk::Format::A8B8G8R8_UINT_PACK32,
        vk::Format::A8B8G8R8_SINT_PACK32,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
    ];
    static S_REQUIRED_STORAGE_TEXEL_BUFFER_ATOMIC_FORMATS: &[vk::Format] =
        &[vk::Format::R32_UINT, vk::Format::R32_SINT];

    let mut flags = vk::FormatFeatureFlags::empty();

    if S_REQUIRED_VERTEX_BUFFER_FORMATS.contains(&format) {
        flags |= vk::FormatFeatureFlags::VERTEX_BUFFER;
    }

    if S_REQUIRED_UNIFORM_TEXEL_BUFFER_FORMATS.contains(&format) {
        flags |= vk::FormatFeatureFlags::UNIFORM_TEXEL_BUFFER;
    }

    if S_REQUIRED_STORAGE_TEXEL_BUFFER_FORMATS.contains(&format) {
        flags |= vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER;
    }

    if S_REQUIRED_STORAGE_TEXEL_BUFFER_ATOMIC_FORMATS.contains(&format) {
        flags |= vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER_ATOMIC;
    }

    flags
}

/// `checkYcbcrApiSupport`.
///
/// Upstream also `TCU_CHECK`s that VK_KHR_get_physical_device_properties2 is present as
/// a hard dependency; hodow_cts always builds a >= 1.1 instance, where that is core, so
/// the check can never trip and there is nothing here to port it onto.
fn check_ycbcr_api_support(context: &Context<'_>) -> Result<(), TestError> {
    // check if YCbcr API and are supported by implementation

    // the support for formats and YCbCr may still be optional - see isYcbcrConversionSupported below

    if !is_core_device_extension(get_used_api_version(context), "VK_KHR_sampler_ycbcr_conversion")
        && !is_device_functionality_supported(context, "VK_KHR_sampler_ycbcr_conversion")
    {
        return Err(TestError::NotSupported(
            "VK_KHR_sampler_ycbcr_conversion is not supported".to_string(),
        ));
    }

    Ok(())
}

/// `isYcbcrConversionSupported`
fn is_ycbcr_conversion_supported(context: &Context<'_>) -> Result<bool, TestError> {
    check_ycbcr_api_support(context)?;

    let ycbcr_features = get_physical_device_sampler_ycbcr_conversion_features(context);

    Ok(ycbcr_features.sampler_ycbcr_conversion == vk::TRUE)
}

/// `getRequiredYcbcrFormatFeatures`
fn get_required_ycbcr_format_features(
    context: &Context<'_>,
    format: vk::Format,
) -> Result<vk::FormatFeatureFlags, TestError> {
    let req = is_ycbcr_conversion_supported(context)?
        && (format == vk::Format::G8_B8R8_2PLANE_420_UNORM || format == vk::Format::G8_B8_R8_3PLANE_420_UNORM);

    let required = vk::FormatFeatureFlags::SAMPLED_IMAGE
        | vk::FormatFeatureFlags::TRANSFER_SRC
        | vk::FormatFeatureFlags::TRANSFER_DST
        | vk::FormatFeatureFlags::COSITED_CHROMA_SAMPLES;
    Ok(if req { required } else { vk::FormatFeatureFlags::empty() })
}

/// `getRequiredOptimalTilingFeatures`
fn get_required_optimal_tiling_features(
    context: &Context<'_>,
    format: vk::Format,
) -> Result<vk::FormatFeatureFlags, TestError> {
    if is_ycbcr_format(format) {
        get_required_ycbcr_format_features(context, format)
    } else {
        let mut ret = get_base_required_optimal_tiling_features(format);

        // \todo [2017-05-16 pyry] This should be extended to cover for example COLOR_ATTACHMENT for depth formats etc.
        // \todo [2017-05-18 pyry] Any other color conversion related features that can't be supported by regular formats?
        ret |= get_required_optimal_extended_tiling_features(context, format, ret);

        // Compressed formats have optional support for some features
        // TODO: Is this really correct? It looks like it should be checking the different compressed features
        if is_compressed_format(format) && ret.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR) {
            ret |= vk::FormatFeatureFlags::TRANSFER_SRC
                | vk::FormatFeatureFlags::TRANSFER_DST
                | vk::FormatFeatureFlags::SAMPLED_IMAGE
                | vk::FormatFeatureFlags::BLIT_SRC;
        }

        Ok(ret)
    }
}

/// `requiresYCbCrConversion`
fn requires_ycbcr_conversion(context: &Context<'_>, format: vk::Format) -> bool {
    if format == vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16 {
        if !is_device_functionality_supported(context, "VK_EXT_rgba10x6_formats") {
            return true;
        }

        let mut rgba10x6features = vk::PhysicalDeviceRGBA10X6FormatsFeaturesEXT::default();
        let mut core_features = vk::PhysicalDeviceFeatures2::builder().push_next(&mut rgba10x6features);

        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut core_features)
        };

        return rgba10x6features.format_rgba10x6_without_y_cb_cr_sampler != vk::TRUE;
    }

    is_ycbcr_format(format)
        && format != vk::Format::R10X6_UNORM_PACK16
        && format != vk::Format::R10X6G10X6_UNORM_2PACK16
        && format != vk::Format::R12X4_UNORM_PACK16
        && format != vk::Format::R12X4G12X4_UNORM_2PACK16
}

/// `getAllowedOptimalTilingFeatures`
fn get_allowed_optimal_tiling_features(context: &Context<'_>, format: vk::Format) -> vk::FormatFeatureFlags {
    let mut vulkan_only_feature_flags = vk::FormatFeatureFlags::empty();
    if is_device_functionality_supported(context, "VK_KHR_video_decode_queue") {
        vulkan_only_feature_flags |=
            vk::FormatFeatureFlags::VIDEO_DECODE_DPB_KHR | vk::FormatFeatureFlags::VIDEO_DECODE_OUTPUT_KHR;
    }
    if is_device_functionality_supported(context, "VK_KHR_video_encode_queue") {
        vulkan_only_feature_flags |=
            vk::FormatFeatureFlags::VIDEO_ENCODE_INPUT_KHR | vk::FormatFeatureFlags::VIDEO_ENCODE_DPB_KHR;
    }

    // YCbCr formats only support a subset of format feature flags
    let ycbcr_allows = vk::FormatFeatureFlags::SAMPLED_IMAGE
        | vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR
        | vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_CUBIC_EXT
        | vk::FormatFeatureFlags::TRANSFER_SRC
        | vk::FormatFeatureFlags::TRANSFER_DST
        | vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES
        | vk::FormatFeatureFlags::COSITED_CHROMA_SAMPLES
        | vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_LINEAR_FILTER
        | vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_SEPARATE_RECONSTRUCTION_FILTER
        | vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT
        | vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT_FORCEABLE
        | vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_MINMAX
        | vk::FormatFeatureFlags::DISJOINT
        | vulkan_only_feature_flags;

    // By default everything is allowed.
    let mut allow = format_features_retain(!0u32);
    // Formats for which SamplerYCbCrConversion is required may not support certain features.
    if requires_ycbcr_conversion(context, format) {
        allow &= ycbcr_allows;
    }
    // single-plane formats *may not* support DISJOINT_BIT
    if !is_ycbcr_format(format) || get_plane_count(format) == 1 {
        allow &= !vk::FormatFeatureFlags::DISJOINT;
    }

    allow
}

/// `getAllowedBufferFeatures`
fn get_allowed_buffer_features(context: &Context<'_>, format: vk::Format) -> vk::FormatFeatureFlags {
    // TODO: Do we allow non-buffer flags in the bufferFeatures?
    if requires_ycbcr_conversion(context, format) {
        vk::FormatFeatureFlags::empty()
    } else {
        format_features_retain(!vk::FormatFeatureFlags::DISJOINT.bits())
    }
}

// ---------------------------------------------------------------------------------
// format_properties
// ---------------------------------------------------------------------------------

/// `formatProperties`
fn format_properties(context: &Context<'_>, format: vk::Format) -> TestOutcome {
    // check if Ycbcr format enums are valid given the version and extensions
    if is_ycbcr_format(format) {
        check_ycbcr_api_support(context)?;
    }

    let properties = get_physical_device_format_properties(context, format);
    let api_version10_without_khr_maintenance1 =
        is_api_version_equal(get_used_api_version(context), vk::make_version(1, 0, 0))
            && !is_device_functionality_supported(context, "VK_KHR_maintenance1");

    let req_img = get_required_optimal_tiling_features(context, format)?;
    let req_buf = get_required_buffer_features(format);
    let allow_img = get_allowed_optimal_tiling_features(context, format);
    let allow_buf = get_allowed_buffer_features(context, format);
    let mut results = ResultCollector::new("ERROR: ");

    let fields = [
        (
            "linearTilingFeatures",
            properties.linear_tiling_features,
            vk::FormatFeatureFlags::empty(),
            allow_img,
        ),
        (
            "optimalTilingFeatures",
            properties.optimal_tiling_features,
            req_img,
            allow_img,
        ),
        ("bufferFeatures", properties.buffer_features, req_buf, allow_buf),
    ];

    if format == vk::Format::UNDEFINED {
        // VkFormatProperties is three feature words and nothing else, so upstream's
        // memcmp against an all-0xcd struct with the three words zeroed is this.
        let all_zero = properties.linear_tiling_features.is_empty()
            && properties.optimal_tiling_features.is_empty()
            && properties.buffer_features.is_empty();
        results.check(
            all_zero,
            "vkGetPhysicalDeviceFormatProperties, with VK_FORMAT_UNDEFINED as input format, is returning non-zero properties",
        );
    } else {
        for (field_name, supported_features, required, allowed) in fields {
            let mut supported = supported_features;

            if api_version10_without_khr_maintenance1 && !supported.is_empty() {
                supported |= vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST;
            }

            results.check(
                (supported & required) == required,
                format!(
                    "{field_name}: required: {}  missing: {}",
                    get_format_feature_flags_str(required),
                    get_format_feature_flags_str(!supported & required)
                ),
            );

            results.check(
                (supported & !allowed).is_empty(),
                format!(
                    "{field_name}: has: {}",
                    get_format_feature_flags_str(supported & !allowed)
                ),
            );

            if supported.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT)
                && !supported.contains(
                    vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT_FORCEABLE,
                )
            {
                results.add_result(
                    TestResult::Fail,
                    format!(
                        "{field_name} supports VK_FORMAT_FEATURE_SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT_BIT but not \
                         VK_FORMAT_FEATURE_SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT_FORCEABLE_BIT"
                    ),
                );
            }

            if !is_ycbcr_format(format) && !is_compressed_format(format) {
                let tcu_format = format_info(format);
                if tcu_format.num_used_channels != 1
                    && supported.intersects(
                        vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER_ATOMIC
                            | vk::FormatFeatureFlags::STORAGE_IMAGE_ATOMIC,
                    )
                {
                    results.add_result(
                        TestResult::QualityWarning,
                        "VK_FORMAT_FEATURE_STORAGE_*_ATOMIC_BIT is only defined for single-component images"
                            .to_string(),
                    );
                }
            }
        }
    }

    Ok(results.to_status())
}

/// `optimalTilingFeaturesSupported`
fn optimal_tiling_features_supported(
    context: &Context<'_>,
    format: vk::Format,
    features: vk::FormatFeatureFlags,
) -> bool {
    let properties = get_physical_device_format_properties(context, format);
    let api_version10_without_khr_maintenance1 =
        is_api_version_equal(get_used_api_version(context), vk::make_version(1, 0, 0))
            && !is_device_functionality_supported(context, "VK_KHR_maintenance1");
    let mut supported = properties.optimal_tiling_features;

    if api_version10_without_khr_maintenance1 && !supported.is_empty() {
        supported |= vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST;
    }

    (supported & features) == features
}

/// `optimalTilingFeaturesSupportedForAll`
fn optimal_tiling_features_supported_for_all(
    context: &Context<'_>,
    formats: &[vk::Format],
    features: vk::FormatFeatureFlags,
) -> bool {
    formats
        .iter()
        .all(|f| optimal_tiling_features_supported(context, *f, features))
}

/// `testDepthStencilSupported`
fn test_depth_stencil_supported(context: &Context<'_>) -> TestOutcome {
    if !optimal_tiling_features_supported(
        context,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT,
    ) && !optimal_tiling_features_supported(
        context,
        vk::Format::D32_SFLOAT,
        vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT,
    ) {
        return Ok(TestStatus::fail(
            "Doesn't support one of VK_FORMAT_X8_D24_UNORM_PACK32 or VK_FORMAT_D32_SFLOAT",
        ));
    }

    if !optimal_tiling_features_supported(
        context,
        vk::Format::D24_UNORM_S8_UINT,
        vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT,
    ) && !optimal_tiling_features_supported(
        context,
        vk::Format::D32_SFLOAT_S8_UINT,
        vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT,
    ) {
        return Ok(TestStatus::fail(
            "Doesn't support one of VK_FORMAT_D24_UNORM_S8_UINT or VK_FORMAT_D32_SFLOAT_S8_UINT",
        ));
    }

    Ok(TestStatus::pass("Required depth/stencil formats supported"))
}

/// `testCompressedFormatsSupported`.
///
/// The `ASTC 3D` arm upstream added for VK_EXT_texture_compression_astc_3d is left out:
/// the bindings have no VK_FORMAT_ASTC_*x*x*_BLOCK_EXT enumerants to query, and the arm
/// is entered only when that extension is advertised.
fn test_compressed_formats_supported(context: &Context<'_>) -> TestOutcome {
    static S_ALL_BC_FORMATS: &[vk::Format] = &[
        vk::Format::BC1_RGB_UNORM_BLOCK,
        vk::Format::BC1_RGB_SRGB_BLOCK,
        vk::Format::BC1_RGBA_UNORM_BLOCK,
        vk::Format::BC1_RGBA_SRGB_BLOCK,
        vk::Format::BC2_UNORM_BLOCK,
        vk::Format::BC2_SRGB_BLOCK,
        vk::Format::BC3_UNORM_BLOCK,
        vk::Format::BC3_SRGB_BLOCK,
        vk::Format::BC4_UNORM_BLOCK,
        vk::Format::BC4_SNORM_BLOCK,
        vk::Format::BC5_UNORM_BLOCK,
        vk::Format::BC5_SNORM_BLOCK,
        vk::Format::BC6H_UFLOAT_BLOCK,
        vk::Format::BC6H_SFLOAT_BLOCK,
        vk::Format::BC7_UNORM_BLOCK,
        vk::Format::BC7_SRGB_BLOCK,
    ];
    static S_ALL_ETC2_FORMATS: &[vk::Format] = &[
        vk::Format::ETC2_R8G8B8_UNORM_BLOCK,
        vk::Format::ETC2_R8G8B8_SRGB_BLOCK,
        vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK,
        vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK,
        vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK,
        vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK,
        vk::Format::EAC_R11_UNORM_BLOCK,
        vk::Format::EAC_R11_SNORM_BLOCK,
        vk::Format::EAC_R11G11_UNORM_BLOCK,
        vk::Format::EAC_R11G11_SNORM_BLOCK,
    ];
    static S_ALL_ASTC_LDR_FORMATS: &[vk::Format] = &[
        vk::Format::ASTC_4X4_UNORM_BLOCK,
        vk::Format::ASTC_4X4_SRGB_BLOCK,
        vk::Format::ASTC_5X4_UNORM_BLOCK,
        vk::Format::ASTC_5X4_SRGB_BLOCK,
        vk::Format::ASTC_5X5_UNORM_BLOCK,
        vk::Format::ASTC_5X5_SRGB_BLOCK,
        vk::Format::ASTC_6X5_UNORM_BLOCK,
        vk::Format::ASTC_6X5_SRGB_BLOCK,
        vk::Format::ASTC_6X6_UNORM_BLOCK,
        vk::Format::ASTC_6X6_SRGB_BLOCK,
        vk::Format::ASTC_8X5_UNORM_BLOCK,
        vk::Format::ASTC_8X5_SRGB_BLOCK,
        vk::Format::ASTC_8X6_UNORM_BLOCK,
        vk::Format::ASTC_8X6_SRGB_BLOCK,
        vk::Format::ASTC_8X8_UNORM_BLOCK,
        vk::Format::ASTC_8X8_SRGB_BLOCK,
        vk::Format::ASTC_10X5_UNORM_BLOCK,
        vk::Format::ASTC_10X5_SRGB_BLOCK,
        vk::Format::ASTC_10X6_UNORM_BLOCK,
        vk::Format::ASTC_10X6_SRGB_BLOCK,
        vk::Format::ASTC_10X8_UNORM_BLOCK,
        vk::Format::ASTC_10X8_SRGB_BLOCK,
        vk::Format::ASTC_10X10_UNORM_BLOCK,
        vk::Format::ASTC_10X10_SRGB_BLOCK,
        vk::Format::ASTC_12X10_UNORM_BLOCK,
        vk::Format::ASTC_12X10_SRGB_BLOCK,
        vk::Format::ASTC_12X12_UNORM_BLOCK,
        vk::Format::ASTC_12X12_SRGB_BLOCK,
    ];

    let features = context.get_device_features();
    let s_compressed_format_sets: [(&str, &str, bool, &[vk::Format]); 3] = [
        (
            "BC",
            "textureCompressionBC",
            features.texture_compression_bc == vk::TRUE,
            S_ALL_BC_FORMATS,
        ),
        (
            "ETC2",
            "textureCompressionETC2",
            features.texture_compression_etc2 == vk::TRUE,
            S_ALL_ETC2_FORMATS,
        ),
        (
            "ASTC LDR",
            "textureCompressionASTC_LDR",
            features.texture_compression_astc_ldr == vk::TRUE,
            S_ALL_ASTC_LDR_FORMATS,
        ),
    ];

    let mut num_supported_sets = 0;
    let mut num_errors = 0;
    let mut num_warnings = 0;

    for (set_name, feature_name, feature_bit_set, formats) in s_compressed_format_sets {
        let required_features = vk::FormatFeatureFlags::SAMPLED_IMAGE
            | vk::FormatFeatureFlags::BLIT_SRC
            | vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR
            | vk::FormatFeatureFlags::TRANSFER_SRC
            | vk::FormatFeatureFlags::TRANSFER_DST;
        let all_supported = optimal_tiling_features_supported_for_all(context, formats, required_features);

        if feature_bit_set && !all_supported {
            log::info!("ERROR: {feature_name} = VK_TRUE but {set_name} formats not supported");
            num_errors += 1;
        } else if all_supported && !feature_bit_set {
            log::info!("WARNING: {set_name} formats supported but {feature_name} = VK_FALSE");
            num_warnings += 1;
        }

        if feature_bit_set {
            log::info!("All {set_name} formats are supported");
            num_supported_sets += 1;
        } else {
            log::info!("{set_name} formats are not supported");
        }
    }

    if num_supported_sets == 0 {
        log::info!("No compressed format sets supported");
        num_errors += 1;
    }

    if num_errors > 0 {
        Ok(TestStatus::fail("Compressed format support not valid"))
    } else if num_warnings > 0 {
        Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Found inconsistencies in compressed format support",
        ))
    } else {
        Ok(TestStatus::pass("Compressed texture format support is valid"))
    }
}

// ---------------------------------------------------------------------------------
// image_format_properties / image_format_properties2 / sparse_image_format_properties2
// ---------------------------------------------------------------------------------

/// `getValidImageUsageFlags`
fn get_valid_image_usage_flags(
    supported_features: vk::FormatFeatureFlags,
    use_khr_maintenance1_semantics: bool,
) -> vk::ImageUsageFlags {
    let mut flags = vk::ImageUsageFlags::empty();

    if use_khr_maintenance1_semantics {
        if supported_features.contains(vk::FormatFeatureFlags::TRANSFER_SRC) {
            flags |= vk::ImageUsageFlags::TRANSFER_SRC;
        }

        if supported_features.contains(vk::FormatFeatureFlags::TRANSFER_DST) {
            flags |= vk::ImageUsageFlags::TRANSFER_DST;
        }
    } else if !supported_features.is_empty() {
        // If format is supported at all, it must be valid transfer src+dst
        flags |= vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    }

    if supported_features.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE) {
        flags |= vk::ImageUsageFlags::SAMPLED;
    }

    if supported_features.contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT) {
        flags |= vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
            | vk::ImageUsageFlags::INPUT_ATTACHMENT;
    }

    if supported_features.contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT) {
        flags |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
    }

    if supported_features.contains(vk::FormatFeatureFlags::STORAGE_IMAGE) {
        flags |= vk::ImageUsageFlags::STORAGE;
    }

    if supported_features
        .intersects(vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
    {
        flags |= vk::ImageUsageFlags::INPUT_ATTACHMENT;
    }

    flags
}

/// `isValidImageUsageFlagCombination`
fn is_valid_image_usage_flag_combination(usage: vk::ImageUsageFlags) -> bool {
    if usage.contains(vk::ImageUsageFlags::TRANSIENT_ATTACHMENT) {
        let allowed_flags = vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
            | vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::INPUT_ATTACHMENT;

        // Only *_ATTACHMENT_BIT flags can be combined with TRANSIENT_ATTACHMENT_BIT
        if !(usage & !allowed_flags).is_empty() {
            return false;
        }

        // TRANSIENT_ATTACHMENT_BIT is not valid without COLOR_ or DEPTH_STENCIL_ATTACHMENT_BIT
        if !usage.intersects(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT) {
            return false;
        }
    }

    !usage.is_empty()
}

/// `getValidImageCreateFlags`
fn get_valid_image_create_flags(
    device_features: &vk::PhysicalDeviceFeatures,
    format: vk::Format,
    format_features: vk::FormatFeatureFlags,
    type_: vk::ImageType,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateFlags {
    let mut flags = vk::ImageCreateFlags::empty();

    if usage.contains(vk::ImageUsageFlags::SAMPLED) {
        flags |= vk::ImageCreateFlags::MUTABLE_FORMAT;

        if type_ == vk::ImageType::_2D && !is_ycbcr_format(format) {
            flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }
    }

    if is_ycbcr_format(format)
        && get_plane_count(format) > 1
        && format_features.contains(vk::FormatFeatureFlags::DISJOINT)
    {
        flags |= vk::ImageCreateFlags::DISJOINT;
    }

    if usage.intersects(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::STORAGE)
        && !usage.contains(vk::ImageUsageFlags::TRANSIENT_ATTACHMENT)
    {
        if device_features.sparse_binding == vk::TRUE {
            flags |= vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY;
        }

        if device_features.sparse_residency_aliased == vk::TRUE {
            flags |= vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_ALIASED;
        }
    }

    flags
}

/// `isValidImageCreateFlagCombination`
fn is_valid_image_create_flag_combination(create_flags: vk::ImageCreateFlags) -> bool {
    let mut is_valid = true;

    if create_flags.intersects(vk::ImageCreateFlags::SPARSE_RESIDENCY | vk::ImageCreateFlags::SPARSE_ALIASED)
        && !create_flags.contains(vk::ImageCreateFlags::SPARSE_BINDING)
    {
        is_valid = false;
    }

    is_valid
}

/// `isRequiredImageParameterCombination`
fn is_required_image_parameter_combination(
    device_features: &vk::PhysicalDeviceFeatures,
    format: vk::Format,
    image_type: vk::ImageType,
    image_tiling: vk::ImageTiling,
    usage_flags: vk::ImageUsageFlags,
    create_flags: vk::ImageCreateFlags,
) -> bool {
    // Linear images can have arbitrary limitations
    if image_tiling == vk::ImageTiling::LINEAR {
        return false;
    }

    // Support for other usages for compressed formats is optional
    if is_compressed_format(format)
        && !(usage_flags
            & !(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST))
            .is_empty()
    {
        return false;
    }

    // Support for 1D, and sliced 3D compressed formats is optional
    if is_compressed_format(format) && (image_type == vk::ImageType::_1D || image_type == vk::ImageType::_3D) {
        return false;
    }

    // Support for 1D and 3D depth/stencil textures is optional
    if is_depth_stencil_format(format) && (image_type == vk::ImageType::_1D || image_type == vk::ImageType::_3D) {
        return false;
    }

    if is_ycbcr_format(format)
        && create_flags.intersects(
            vk::ImageCreateFlags::SPARSE_BINDING
                | vk::ImageCreateFlags::SPARSE_ALIASED
                | vk::ImageCreateFlags::SPARSE_RESIDENCY,
        )
    {
        return false;
    }

    if create_flags.contains(vk::ImageCreateFlags::SPARSE_RESIDENCY) {
        if is_compressed_format(format) {
            return false;
        }

        if is_depth_stencil_format(format) {
            return false;
        }

        if !format_info(format).pixel_size.is_power_of_two() {
            return false;
        }

        return match image_type {
            vk::ImageType::_2D => device_features.sparse_residency_image_2d == vk::TRUE,
            vk::ImageType::_3D => device_features.sparse_residency_image_3d == vk::TRUE,
            _ => false,
        };
    }

    true
}

/// `getRequiredOptimalTilingSampleCounts`
fn get_required_optimal_tiling_sample_counts(
    device_limits: &vk::PhysicalDeviceLimits,
    has_vulkan12: bool,
    vulkan12_properties: &vk::PhysicalDeviceVulkan12Properties,
    device_features: &vk::PhysicalDeviceFeatures,
    create_flags: vk::ImageCreateFlags,
    format: vk::Format,
    usage_flags: vk::ImageUsageFlags,
) -> vk::SampleCountFlags {
    if is_compressed_format(format) {
        return vk::SampleCountFlags::_1;
    }

    let info = format_info(format);
    let is_ycbcr = info.ycbcr;
    let has_depth_comp = !is_ycbcr && info.has_depth;
    let has_stencil_comp = !is_ycbcr && info.has_stencil;

    let is_color_format = !has_depth_comp && !has_stencil_comp;
    let mut sample_counts = sample_counts_retain(!0u32);

    if usage_flags.contains(vk::ImageUsageFlags::STORAGE) {
        sample_counts &= device_limits.storage_image_sample_counts;
    }

    if usage_flags.contains(vk::ImageUsageFlags::SAMPLED) {
        if has_depth_comp {
            sample_counts &= device_limits.sampled_image_depth_sample_counts;
        }

        if has_stencil_comp {
            sample_counts &= device_limits.sampled_image_stencil_sample_counts;
        }

        if is_color_format {
            if is_ycbcr {
                sample_counts &= device_limits.sampled_image_color_sample_counts;
            } else if info.channel_class == ChannelClass::UnsignedInteger
                || info.channel_class == ChannelClass::SignedInteger
            {
                sample_counts &= device_limits.sampled_image_integer_sample_counts;
            } else {
                sample_counts &= device_limits.sampled_image_color_sample_counts;
            }
        }
    }

    if usage_flags.contains(vk::ImageUsageFlags::COLOR_ATTACHMENT) {
        if has_vulkan12
            && (info.channel_class == ChannelClass::UnsignedInteger
                || info.channel_class == ChannelClass::SignedInteger)
        {
            sample_counts &= vulkan12_properties.framebuffer_integer_color_sample_counts;
        } else {
            sample_counts &= device_limits.framebuffer_color_sample_counts;
        }
    }

    if usage_flags.contains(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT) {
        if has_depth_comp {
            sample_counts &= device_limits.framebuffer_depth_sample_counts;
        }

        if has_stencil_comp {
            sample_counts &= device_limits.framebuffer_stencil_sample_counts;
        }
    }

    if create_flags.contains(vk::ImageCreateFlags::SPARSE_RESIDENCY) {
        let mut sparse_sample_counts = vk::SampleCountFlags::_1;
        if device_features.sparse_residency2_samples == vk::TRUE {
            sparse_sample_counts |= vk::SampleCountFlags::_2;
        }
        if device_features.sparse_residency4_samples == vk::TRUE {
            sparse_sample_counts |= vk::SampleCountFlags::_4;
        }
        if device_features.sparse_residency8_samples == vk::TRUE {
            sparse_sample_counts |= vk::SampleCountFlags::_8;
        }
        if device_features.sparse_residency16_samples == vk::TRUE {
            sparse_sample_counts |= vk::SampleCountFlags::_16;
        }

        sample_counts &= sparse_sample_counts;

        // Vulkan spec says:
        //     A sparse image created using VK_IMAGE_CREATE_SPARSE_RESIDENCY_BIT supports all non-compressed
        //     color formats with power-of-two element size that non-sparse usage supports. Additional formats
        //     may also be supported and can be queried via vkGetPhysicalDeviceSparseImageFormatProperties.
        //
        // So for non-color formats, just require VK_SAMPLE_COUNT_1_BIT.
        if !is_color_format {
            sample_counts &= vk::SampleCountFlags::_1;
        }
    }

    // If there is no usage flag set that would have corresponding device limit,
    // only VK_SAMPLE_COUNT_1_BIT is required.
    if sample_counts == sample_counts_retain(!0u32) {
        sample_counts &= vk::SampleCountFlags::_1;
    }

    sample_counts
}

/// `deLog2Floor32`
fn de_log2_floor32(a: u32) -> u32 {
    31 - a.max(1).leading_zeros()
}

/// Which of the three query functions an `ImageFormatPropertyCase` dispatches to.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ImageFormatFunction {
    ImageFormatProperties,
    ImageFormatProperties2,
    SparseImageFormatProperties2,
}

/// `imageFormatProperties`
fn image_format_properties(
    context: &Context<'_>,
    format: vk::Format,
    image_type: vk::ImageType,
    tiling: vk::ImageTiling,
    extended_flags: bool,
) -> TestOutcome {
    if is_ycbcr_format(format) {
        // check if Ycbcr format enums are valid given the version and extensions
        check_ycbcr_api_support(context)?;
    }

    let device_features = *context.get_device_features();
    let device_limits = context.get_device_properties().limits;
    let vulkan12_properties = get_device_vulkan12_properties(context);
    let format_properties = get_physical_device_format_properties(context, format);
    let has_khr_maintenance1 = is_device_functionality_supported(context, "VK_KHR_maintenance1");
    let has_vulkan12 = context_supports(context, vk::make_version(1, 2, 0));

    let supported_features = if tiling == vk::ImageTiling::LINEAR {
        format_properties.linear_tiling_features
    } else {
        format_properties.optimal_tiling_features
    };
    let usage_flag_set = get_valid_image_usage_flags(supported_features, has_khr_maintenance1);

    let mut results = ResultCollector::new("ERROR: ");

    if has_khr_maintenance1 && supported_features.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE) {
        results.check(
            supported_features.intersects(vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST),
            "A sampled image format must have VK_FORMAT_FEATURE_TRANSFER_SRC_BIT and VK_FORMAT_FEATURE_TRANSFER_DST_BIT format feature flags set",
        );
    }

    if is_ycbcr_conversion_supported(context)?
        && (format == vk::Format::G8_B8_R8_3PLANE_420_UNORM || format == vk::Format::G8_B8R8_2PLANE_420_UNORM)
    {
        let mut required_features = vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST;
        if tiling == vk::ImageTiling::OPTIMAL {
            required_features |= vk::FormatFeatureFlags::SAMPLED_IMAGE | vk::FormatFeatureFlags::COSITED_CHROMA_SAMPLES;
        }

        let name = format_info(format).name;
        results.check(
            (supported_features & required_features) == required_features,
            format!(
                "VK_FORMAT_{} must support {}",
                name.to_uppercase(),
                get_format_feature_flags_str(required_features)
            ),
        );
    }

    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    for cur_usage_bits in 0..=usage_flag_set.bits() {
        let cur_usage_flags = image_usage_retain(cur_usage_bits);
        if !(cur_usage_flags & !usage_flag_set).is_empty() || !is_valid_image_usage_flag_combination(cur_usage_flags) {
            continue;
        }

        let create_flag_set = get_valid_image_create_flags(
            &device_features,
            format,
            supported_features,
            image_type,
            cur_usage_flags,
        );

        for cur_create_bits in 0..=create_flag_set.bits() {
            let cur_create_flags = image_create_retain(cur_create_bits);
            if !(cur_create_flags & !create_flag_set).is_empty()
                || !is_valid_image_create_flag_combination(cur_create_flags)
            {
                continue;
            }

            let is_required_combination = is_required_image_parameter_combination(
                &device_features,
                format,
                image_type,
                tiling,
                cur_usage_flags,
                cur_create_flags,
            );

            // Set return value to known garbage, so that a driver that reports
            // VK_ERROR_FORMAT_NOT_SUPPORTED without zeroing the struct is caught.
            let mut properties: vk::ImageFormatProperties = unsafe { std::mem::zeroed() };
            unsafe {
                std::ptr::write_bytes(
                    (&raw mut properties).cast::<u8>(),
                    0xcd,
                    size_of::<vk::ImageFormatProperties>(),
                )
            };
            let query_result;

            if !extended_flags {
                query_result = unsafe {
                    (instance.commands().get_physical_device_image_format_properties)(
                        physical_device,
                        format,
                        image_type,
                        tiling,
                        cur_usage_flags,
                        cur_create_flags,
                        &raw mut properties,
                    )
                };
            } else {
                let image_create_flags2_info = ImageCreateFlags2CreateInfoKHR {
                    s_type: STRUCTURE_TYPE_IMAGE_CREATE_FLAGS_2_CREATE_INFO_KHR,
                    next: std::ptr::null(),
                    flags: u64::from(cur_create_bits),
                };
                let image_usage_flags2_info = ImageUsageFlags2CreateInfoKHR {
                    s_type: STRUCTURE_TYPE_IMAGE_USAGE_FLAGS_2_CREATE_INFO_KHR,
                    next: (&raw const image_create_flags2_info).cast(),
                    usage: u64::from(cur_usage_bits),
                };
                // usage/flags are deliberately set to all-ones: the extension says the
                // chained flags2 structs replace them, so a driver that reads these
                // instead is caught.
                let image_format_info2 = vk::PhysicalDeviceImageFormatInfo2 {
                    next: (&raw const image_usage_flags2_info).cast(),
                    format,
                    type_: image_type,
                    tiling,
                    usage: image_usage_retain(0xFFFF_FFFF),
                    flags: image_create_retain(0xFFFF_FFFF),
                    ..Default::default()
                };
                let mut image_format_properties2 = vk::ImageFormatProperties2::default();
                query_result = unsafe {
                    (instance.commands().get_physical_device_image_format_properties2)(
                        physical_device,
                        &raw const image_format_info2,
                        &raw mut image_format_properties2,
                    )
                };
                properties = image_format_properties2.image_format_properties;
            }

            if query_result == vk::Result::SUCCESS {
                let full_mip_pyramid_size = de_log2_floor32(properties.max_extent.width)
                    .max(de_log2_floor32(properties.max_extent.height))
                    .max(de_log2_floor32(properties.max_extent.depth))
                    + 1;

                results.check(
                    image_type != vk::ImageType::_1D
                        || (properties.max_extent.width >= 1
                            && properties.max_extent.height == 1
                            && properties.max_extent.depth == 1),
                    "Invalid dimensions for 1D image",
                );
                results.check(
                    image_type != vk::ImageType::_2D
                        || (properties.max_extent.width >= 1
                            && properties.max_extent.height >= 1
                            && properties.max_extent.depth == 1),
                    "Invalid dimensions for 2D image",
                );
                results.check(
                    image_type != vk::ImageType::_3D
                        || (properties.max_extent.width >= 1
                            && properties.max_extent.height >= 1
                            && properties.max_extent.depth >= 1),
                    "Invalid dimensions for 3D image",
                );
                results.check(
                    image_type != vk::ImageType::_3D || properties.max_array_layers == 1,
                    "Invalid maxArrayLayers for 3D image",
                );

                if tiling == vk::ImageTiling::OPTIMAL
                    && image_type == vk::ImageType::_2D
                    && !cur_create_flags.contains(vk::ImageCreateFlags::CUBE_COMPATIBLE)
                    && supported_features.intersects(
                        vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT | vk::FormatFeatureFlags::COLOR_ATTACHMENT,
                    )
                {
                    let required_sample_counts = get_required_optimal_tiling_sample_counts(
                        &device_limits,
                        has_vulkan12,
                        &vulkan12_properties,
                        &device_features,
                        cur_create_flags,
                        format,
                        cur_usage_flags,
                    );
                    results.check(
                        (properties.sample_counts & required_sample_counts) == required_sample_counts,
                        "Required sample counts not supported",
                    );
                } else {
                    results.check(
                        properties.sample_counts == vk::SampleCountFlags::_1,
                        "sampleCounts != VK_SAMPLE_COUNT_1_BIT",
                    );
                }

                if is_required_combination {
                    results.check(
                        image_type != vk::ImageType::_1D
                            || (properties.max_extent.width >= device_limits.max_image_dimension_1d),
                        "Reported dimensions smaller than device limits",
                    );
                    results.check(
                        image_type != vk::ImageType::_2D
                            || (properties.max_extent.width >= device_limits.max_image_dimension_2d
                                && properties.max_extent.height >= device_limits.max_image_dimension_2d),
                        "Reported dimensions smaller than device limits",
                    );
                    results.check(
                        image_type != vk::ImageType::_3D
                            || (properties.max_extent.width >= device_limits.max_image_dimension_3d
                                && properties.max_extent.height >= device_limits.max_image_dimension_3d
                                && properties.max_extent.depth >= device_limits.max_image_dimension_3d),
                        "Reported dimensions smaller than device limits",
                    );
                    results.check(
                        (is_ycbcr_format(format) && properties.max_mip_levels == 1)
                            || properties.max_mip_levels == full_mip_pyramid_size,
                        "Invalid mip pyramid size",
                    );
                    results.check(
                        (is_ycbcr_format(format) && properties.max_array_layers == 1)
                            || image_type == vk::ImageType::_3D
                            || properties.max_array_layers >= device_limits.max_image_array_layers,
                        "Invalid maxArrayLayers",
                    );
                } else {
                    results.check(
                        properties.max_mip_levels == 1 || properties.max_mip_levels == full_mip_pyramid_size,
                        "Invalid mip pyramid size",
                    );
                    results.check(properties.max_array_layers >= 1, "Invalid maxArrayLayers");
                }

                results.check(
                    properties.max_resource_size >= MINIMUM_REQUIRED_IMAGE_RESOURCE_SIZE,
                    "maxResourceSize smaller than minimum required size",
                );

                if format == vk::Format::UNDEFINED {
                    results.fail("VK_SUCCESS returned for VK_FORMAT_UNDEFINED format");
                }
            } else if query_result == vk::Result::ERROR_FORMAT_NOT_SUPPORTED {
                if is_required_combination {
                    results.fail("VK_ERROR_FORMAT_NOT_SUPPORTED returned for required image parameter combination");
                }

                // Specification requires that all fields are set to 0
                results.check(properties.max_extent.width == 0, "maxExtent.width != 0");
                results.check(properties.max_extent.height == 0, "maxExtent.height != 0");
                results.check(properties.max_extent.depth == 0, "maxExtent.depth != 0");
                results.check(properties.max_mip_levels == 0, "maxMipLevels != 0");
                results.check(properties.max_array_layers == 0, "maxArrayLayers != 0");
                results.check(properties.sample_counts.is_empty(), "sampleCounts != 0");
                results.check(properties.max_resource_size == 0, "maxResourceSize != 0");
            } else {
                if format == vk::Format::UNDEFINED {
                    results.fail(format!("{query_result:?} returned for VK_FORMAT_UNDEFINED format"));
                }

                results.fail(format!("Got unexpected error{query_result:?}"));
            }
        }
    }

    Ok(results.to_status())
}

/// `imageFormatProperties2`
fn image_format_properties2(
    context: &Context<'_>,
    format: vk::Format,
    image_type: vk::ImageType,
    tiling: vk::ImageTiling,
    extended_flags: bool,
) -> TestOutcome {
    if is_ycbcr_format(format) {
        // check if Ycbcr format enums are valid given the version and extensions
        check_ycbcr_api_support(context)?;
    }
    if extended_flags {
        check_extended_flags_support(context)?;
    }

    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let ycbcr_flags = if is_ycbcr_format(format) {
        vk::ImageCreateFlags::DISJOINT
    } else {
        vk::ImageCreateFlags::empty()
    };
    let all_usage_flags = vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::SAMPLED
        | vk::ImageUsageFlags::STORAGE
        | vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
        | vk::ImageUsageFlags::INPUT_ATTACHMENT;
    let all_create_flags = vk::ImageCreateFlags::SPARSE_BINDING
        | vk::ImageCreateFlags::SPARSE_RESIDENCY
        | vk::ImageCreateFlags::SPARSE_ALIASED
        | vk::ImageCreateFlags::MUTABLE_FORMAT
        | vk::ImageCreateFlags::CUBE_COMPATIBLE
        | ycbcr_flags;

    for cur_usage_bits in 1..=all_usage_flags.bits() {
        let cur_usage_flags = image_usage_retain(cur_usage_bits);
        if !is_valid_image_usage_flag_combination(cur_usage_flags) {
            continue;
        }

        for cur_create_bits in 0..=all_create_flags.bits() {
            let cur_create_flags = image_create_retain(cur_create_bits);

            let mut image_format_info = vk::PhysicalDeviceImageFormatInfo2 {
                next: std::ptr::null(),
                format,
                type_: image_type,
                tiling,
                usage: cur_usage_flags,
                flags: cur_create_flags,
                ..Default::default()
            };

            let mut core_properties: vk::ImageFormatProperties = unsafe { std::mem::zeroed() };
            let mut ext_properties: vk::ImageFormatProperties2 = unsafe { std::mem::zeroed() };

            unsafe {
                std::ptr::write_bytes(
                    (&raw mut core_properties).cast::<u8>(),
                    0xcd,
                    size_of::<vk::ImageFormatProperties>(),
                );
                std::ptr::write_bytes(
                    (&raw mut ext_properties).cast::<u8>(),
                    0xcd,
                    size_of::<vk::ImageFormatProperties2>(),
                );
            }

            ext_properties.s_type = vk::StructureType::IMAGE_FORMAT_PROPERTIES_2;
            ext_properties.next = std::ptr::null_mut();

            let core_result = unsafe {
                (instance.commands().get_physical_device_image_format_properties)(
                    physical_device,
                    image_format_info.format,
                    image_format_info.type_,
                    image_format_info.tiling,
                    image_format_info.usage,
                    image_format_info.flags,
                    &raw mut core_properties,
                )
            };

            let create_flags2 = ImageCreateFlags2CreateInfoKHR {
                s_type: STRUCTURE_TYPE_IMAGE_CREATE_FLAGS_2_CREATE_INFO_KHR,
                next: std::ptr::null(),
                flags: u64::from(cur_create_bits),
            };
            let usage_flags2 = ImageUsageFlags2CreateInfoKHR {
                s_type: STRUCTURE_TYPE_IMAGE_USAGE_FLAGS_2_CREATE_INFO_KHR,
                next: (&raw const create_flags2).cast(),
                usage: u64::from(cur_usage_bits),
            };

            if extended_flags {
                image_format_info.next = (&raw const usage_flags2).cast();
                // Swap the usage and create flags, to make sure they are correctly ignored
                image_format_info.usage = image_usage_retain(cur_create_bits);
                image_format_info.flags = image_create_retain(cur_usage_bits);
            }

            let ext_result = unsafe {
                (instance.commands().get_physical_device_image_format_properties2)(
                    physical_device,
                    &raw const image_format_info,
                    &raw mut ext_properties,
                )
            };

            if ext_properties.s_type != vk::StructureType::IMAGE_FORMAT_PROPERTIES_2 || !ext_properties.next.is_null() {
                return Ok(TestStatus::fail(
                    "VkImageFormatProperties2 sType/pNext were modified by the driver",
                ));
            }

            if core_result != ext_result || core_properties != ext_properties.image_format_properties {
                log::error!(
                    "ERROR: device mismatch with query format={format:?} type={image_type:?} tiling={tiling:?} usage={cur_usage_bits:#x} flags={cur_create_bits:#x}"
                );
                log::error!("vkGetPhysicalDeviceImageFormatProperties() returned {core_result:?}, {core_properties:?}");
                log::error!("vkGetPhysicalDeviceImageFormatProperties2() returned {ext_result:?}, {ext_properties:?}");
                return Ok(TestStatus::fail(
                    "Mismatch between image format properties reported by vkGetPhysicalDeviceImageFormatProperties and vkGetPhysicalDeviceImageFormatProperties2",
                ));
            }
        }
    }

    Ok(TestStatus::pass("Querying image format properties succeeded"))
}

/// `sparseImageFormatProperties2`
fn sparse_image_format_properties2(
    context: &Context<'_>,
    format: vk::Format,
    image_type: vk::ImageType,
    tiling: vk::ImageTiling,
    extended_flags: bool,
) -> TestOutcome {
    if extended_flags {
        check_extended_flags_support(context)?;
    }

    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let all_usage_flags = vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::SAMPLED
        | vk::ImageUsageFlags::STORAGE
        | vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
        | vk::ImageUsageFlags::INPUT_ATTACHMENT;

    let mut sample_count_bit = vk::SampleCountFlags::_1.bits();
    while sample_count_bit <= vk::SampleCountFlags::_64.bits() {
        for cur_usage_bits in 1..=all_usage_flags.bits() {
            let cur_usage_flags = image_usage_retain(cur_usage_bits);
            if !is_valid_image_usage_flag_combination(cur_usage_flags) {
                continue;
            }

            let usage_flags2 = ImageUsageFlags2CreateInfoKHR {
                s_type: STRUCTURE_TYPE_IMAGE_USAGE_FLAGS_2_CREATE_INFO_KHR,
                next: std::ptr::null(),
                usage: u64::from(cur_usage_bits),
            };

            let extended_usage_image_format_info = vk::PhysicalDeviceSparseImageFormatInfo2 {
                next: (&raw const usage_flags2).cast(),
                format,
                type_: image_type,
                samples: sample_counts_retain(sample_count_bit),
                usage: image_usage_retain(!cur_usage_bits),
                tiling,
                ..Default::default()
            };
            let image_format_info = vk::PhysicalDeviceSparseImageFormatInfo2 {
                next: std::ptr::null(),
                format,
                type_: image_type,
                samples: sample_counts_retain(sample_count_bit),
                usage: cur_usage_flags,
                tiling,
                ..Default::default()
            };

            let mut num_core_properties = 0u32;
            let mut num_ext_properties = 0u32;

            // Query count
            unsafe {
                (instance.commands().get_physical_device_sparse_image_format_properties)(
                    physical_device,
                    image_format_info.format,
                    image_format_info.type_,
                    image_format_info.samples,
                    image_format_info.usage,
                    image_format_info.tiling,
                    &raw mut num_core_properties,
                    std::ptr::null_mut(),
                );
            }
            let image_format_info_ptr: *const vk::PhysicalDeviceSparseImageFormatInfo2 = if extended_flags {
                &raw const extended_usage_image_format_info
            } else {
                &raw const image_format_info
            };
            unsafe {
                (instance.commands().get_physical_device_sparse_image_format_properties2)(
                    physical_device,
                    image_format_info_ptr,
                    &raw mut num_ext_properties,
                    std::ptr::null_mut(),
                );
            }

            if num_core_properties != num_ext_properties {
                log::error!(
                    "ERROR: different number of properties reported for format={format:?} type={image_type:?} samples={sample_count_bit:#x} usage={cur_usage_bits:#x}"
                );
                return Ok(TestStatus::fail("Mismatch in reported property count"));
            }

            if context.get_device_features().sparse_binding != vk::TRUE {
                // There is no support for sparse binding, getPhysicalDeviceSparseImageFormatProperties* MUST report no properties
                // Only have to check one of the entrypoints as a mismatch in count is already caught.
                if num_core_properties > 0 {
                    log::error!(
                        "ERROR: device does not support sparse binding but claims support for {num_core_properties} properties in \
                         vkGetPhysicalDeviceSparseImageFormatProperties with parameters format={format:?} type={image_type:?}"
                    );
                    return Ok(TestStatus::fail(
                        "Claimed format properties inconsistent with overall sparseBinding feature",
                    ));
                }
            }

            if num_core_properties > 0 {
                let mut core_properties: Vec<vk::SparseImageFormatProperties> =
                    vec![unsafe { std::mem::zeroed() }; num_core_properties as usize];
                let mut ext_properties: Vec<vk::SparseImageFormatProperties2> =
                    vec![unsafe { std::mem::zeroed() }; num_ext_properties as usize];

                unsafe {
                    std::ptr::write_bytes(
                        core_properties.as_mut_ptr().cast::<u8>(),
                        0xcd,
                        size_of::<vk::SparseImageFormatProperties>() * num_core_properties as usize,
                    );
                    std::ptr::write_bytes(
                        ext_properties.as_mut_ptr().cast::<u8>(),
                        0xcd,
                        size_of::<vk::SparseImageFormatProperties2>() * num_ext_properties as usize,
                    );
                }

                for p in &mut ext_properties {
                    p.s_type = vk::StructureType::SPARSE_IMAGE_FORMAT_PROPERTIES_2;
                    p.next = std::ptr::null_mut();
                }

                unsafe {
                    (instance.commands().get_physical_device_sparse_image_format_properties)(
                        physical_device,
                        image_format_info.format,
                        image_format_info.type_,
                        image_format_info.samples,
                        image_format_info.usage,
                        image_format_info.tiling,
                        &raw mut num_core_properties,
                        core_properties.as_mut_ptr(),
                    );
                    (instance.commands().get_physical_device_sparse_image_format_properties2)(
                        physical_device,
                        image_format_info_ptr,
                        &raw mut num_ext_properties,
                        ext_properties.as_mut_ptr(),
                    );
                }

                for ndx in 0..num_core_properties as usize {
                    if ext_properties[ndx].s_type != vk::StructureType::SPARSE_IMAGE_FORMAT_PROPERTIES_2
                        || !ext_properties[ndx].next.is_null()
                    {
                        return Ok(TestStatus::fail(
                            "VkSparseImageFormatProperties2 sType/pNext were modified by the driver",
                        ));
                    }

                    if core_properties[ndx] != ext_properties[ndx].properties {
                        log::error!(
                            "ERROR: device mismatch with query format={format:?} type={image_type:?} property {ndx}"
                        );
                        log::error!(
                            "vkGetPhysicalDeviceSparseImageFormatProperties() returned {:?}",
                            core_properties[ndx]
                        );
                        log::error!(
                            "vkGetPhysicalDeviceSparseImageFormatProperties2() returned {:?}",
                            ext_properties[ndx]
                        );
                        return Ok(TestStatus::fail(
                            "Mismatch between image format properties reported by vkGetPhysicalDeviceSparseImageFormatProperties and \
                             vkGetPhysicalDeviceSparseImageFormatProperties2",
                        ));
                    }
                }
            }
        }

        sample_count_bit <<= 1;
    }

    Ok(TestStatus::pass("Querying sparse image format properties succeeded"))
}

/// `ImageFormatPropertyCase`
struct ImageFormatPropertyCase {
    test_function: ImageFormatFunction,
    format: FormatInfo,
    image_type: vk::ImageType,
    tiling: vk::ImageTiling,
    extended_flags: bool,
}

impl TestCase for ImageFormatPropertyCase {
    fn name(&self) -> &str {
        self.format.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageFormatPropertyInstance {
            context,
            test_function: self.test_function,
            format: self.format.format,
            image_type: self.image_type,
            tiling: self.tiling,
            extended_flags: self.extended_flags,
        })
    }
}

struct ImageFormatPropertyInstance<'a> {
    context: &'a Context<'a>,
    test_function: ImageFormatFunction,
    format: vk::Format,
    image_type: vk::ImageType,
    tiling: vk::ImageTiling,
    extended_flags: bool,
}

impl TestInstance for ImageFormatPropertyInstance<'_> {
    /// `execImageFormatTest`
    fn iterate(&mut self) -> TestOutcome {
        match self.test_function {
            ImageFormatFunction::ImageFormatProperties => image_format_properties(
                self.context,
                self.format,
                self.image_type,
                self.tiling,
                self.extended_flags,
            ),
            ImageFormatFunction::ImageFormatProperties2 => image_format_properties2(
                self.context,
                self.format,
                self.image_type,
                self.tiling,
                self.extended_flags,
            ),
            ImageFormatFunction::SparseImageFormatProperties2 => sparse_image_format_properties2(
                self.context,
                self.format,
                self.image_type,
                self.tiling,
                self.extended_flags,
            ),
        }
    }
}

// ---------------------------------------------------------------------------------
// unsupported_image_usage
// ---------------------------------------------------------------------------------

/// `VK_FORMAT_FEATURE_2_LINEAR_COLOR_ATTACHMENT_BIT_NV`, which the bindings spell as a
/// 64-bit format-feature bit the enum does not carry a name for.
const FORMAT_FEATURE_2_LINEAR_COLOR_ATTACHMENT_NV: u64 = 1 << 38;

/// `unsupportedImageUsage`
fn unsupported_image_usage(
    context: &Context<'_>,
    format: vk::Format,
    image_usage: vk::ImageUsageFlags,
    tiling: vk::ImageTiling,
) -> TestOutcome {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();
    let format_properties = get_format_properties3(context, format);
    let supported_features = if tiling == vk::ImageTiling::LINEAR {
        format_properties.linear_tiling_features
    } else {
        format_properties.optimal_tiling_features
    };

    let usage_required_features = match image_usage {
        vk::ImageUsageFlags::SAMPLED => vk::FormatFeatureFlags2::SAMPLED_IMAGE,
        vk::ImageUsageFlags::STORAGE => vk::FormatFeatureFlags2::STORAGE_IMAGE,
        vk::ImageUsageFlags::COLOR_ATTACHMENT => {
            if tiling == vk::ImageTiling::LINEAR
                && get_linear_color_attachment_features(context).linear_color_attachment == vk::TRUE
            {
                format_features2_retain(FORMAT_FEATURE_2_LINEAR_COLOR_ATTACHMENT_NV)
            } else {
                vk::FormatFeatureFlags2::COLOR_ATTACHMENT
            }
        }
        vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT => vk::FormatFeatureFlags2::DEPTH_STENCIL_ATTACHMENT,
        vk::ImageUsageFlags::INPUT_ATTACHMENT => {
            vk::FormatFeatureFlags2::COLOR_ATTACHMENT | vk::FormatFeatureFlags2::DEPTH_STENCIL_ATTACHMENT
        }
        vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR => {
            vk::FormatFeatureFlags2::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR
        }
        _ => unreachable!("createImageUsageTilingTests only registers the six usages above"),
    };

    let mut image_format_properties: vk::ImageFormatProperties = unsafe { std::mem::zeroed() };
    let res = unsafe {
        (vki.commands().get_physical_device_image_format_properties)(
            physical_device,
            format,
            vk::ImageType::_2D,
            tiling,
            image_usage,
            vk::ImageCreateFlags::empty(),
            &raw mut image_format_properties,
        )
    };

    if (supported_features & usage_required_features).is_empty() && res != vk::Result::ERROR_FORMAT_NOT_SUPPORTED {
        log::error!(
            "Required format features for usage {image_usage:?} are not supported. Format features are {supported_features:?}, but \
             vkGetPhysicalDeviceImageFormatProperties with usage {image_usage:?} returned {res:?}"
        );
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `ImageUsagePropertyCase`
struct ImageUsagePropertyCase {
    name: String,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    tiling: vk::ImageTiling,
}

impl TestCase for ImageUsagePropertyCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupportImageUsage`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.usage == vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR {
            context.require_device_functionality("VK_KHR_fragment_shading_rate")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageUsagePropertyInstance {
            context,
            format: self.format,
            usage: self.usage,
            tiling: self.tiling,
        })
    }
}

struct ImageUsagePropertyInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    tiling: vk::ImageTiling,
}

impl TestInstance for ImageUsagePropertyInstance<'_> {
    /// `execImageUsageTest`
    fn iterate(&mut self) -> TestOutcome {
        unsupported_image_usage(self.context, self.format, self.usage, self.tiling)
    }
}

// ---------------------------------------------------------------------------------
// get_physical_device_properties2
// ---------------------------------------------------------------------------------

/// `deviceFormatProperties2`
fn device_format_properties2(context: &Context<'_>) -> TestOutcome {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    for info in core_formats() {
        let format = info.format;
        let mut core_properties: vk::FormatProperties = unsafe { std::mem::zeroed() };
        let mut ext_properties: vk::FormatProperties2 = unsafe { std::mem::zeroed() };

        unsafe {
            std::ptr::write_bytes(
                (&raw mut core_properties).cast::<u8>(),
                0xcd,
                size_of::<vk::FormatProperties>(),
            );
            std::ptr::write_bytes(
                (&raw mut ext_properties).cast::<u8>(),
                0xcd,
                size_of::<vk::FormatProperties2>(),
            );
        }

        ext_properties.s_type = vk::StructureType::FORMAT_PROPERTIES_2;
        ext_properties.next = std::ptr::null_mut();

        unsafe {
            (vki.commands().get_physical_device_format_properties)(physical_device, format, &raw mut core_properties);
            (vki.commands().get_physical_device_format_properties2)(physical_device, format, &raw mut ext_properties);
        }

        if ext_properties.s_type != vk::StructureType::FORMAT_PROPERTIES_2 {
            return Ok(TestStatus::fail(
                "sType was modified by vkGetPhysicalDeviceFormatProperties2",
            ));
        }

        if format == vk::Format::UNDEFINED {
            let zeroed = ext_properties.format_properties.buffer_features.is_empty()
                && ext_properties.format_properties.linear_tiling_features.is_empty()
                && ext_properties.format_properties.optimal_tiling_features.is_empty();
            if !zeroed || !ext_properties.next.is_null() {
                return Ok(TestStatus::fail(
                    "vkGetPhysicalDeviceFormatProperties2, with VK_FORMAT_UNDEFINED as input format, is returning non-zero properties",
                ));
            }
        } else if !ext_properties.next.is_null() {
            return Ok(TestStatus::fail(
                "pNext was modified by vkGetPhysicalDeviceFormatProperties2",
            ));
        }

        if core_properties != ext_properties.format_properties {
            return Ok(TestStatus::fail(
                "Mismatch between format properties reported by vkGetPhysicalDeviceFormatProperties and vkGetPhysicalDeviceFormatProperties2",
            ));
        }
    }

    Ok(TestStatus::pass("Querying device format properties succeeded"))
}

/// `deviceQueueFamilyProperties2`
fn device_queue_family_properties2(context: &Context<'_>) -> TestOutcome {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();
    let mut num_core_queue_families = u32::MAX;
    let mut num_ext_queue_families = u32::MAX;

    unsafe {
        (vki.commands().get_physical_device_queue_family_properties)(
            physical_device,
            &raw mut num_core_queue_families,
            std::ptr::null_mut(),
        );
        (vki.commands().get_physical_device_queue_family_properties2)(
            physical_device,
            &raw mut num_ext_queue_families,
            std::ptr::null_mut(),
        );
    }

    if num_core_queue_families != num_ext_queue_families {
        return Ok(TestStatus::fail("Different number of queue family properties reported"));
    }
    if num_core_queue_families == 0 {
        return Ok(TestStatus::fail("No queue families reported"));
    }

    {
        let mut core_properties: Vec<vk::QueueFamilyProperties> =
            vec![unsafe { std::mem::zeroed() }; num_core_queue_families as usize];
        let mut ext_properties: Vec<vk::QueueFamilyProperties2> =
            vec![unsafe { std::mem::zeroed() }; num_ext_queue_families as usize];

        unsafe {
            std::ptr::write_bytes(
                core_properties.as_mut_ptr().cast::<u8>(),
                0xcd,
                size_of::<vk::QueueFamilyProperties>() * num_core_queue_families as usize,
            );
            std::ptr::write_bytes(
                ext_properties.as_mut_ptr().cast::<u8>(),
                0xcd,
                size_of::<vk::QueueFamilyProperties2>() * num_ext_queue_families as usize,
            );
        }

        for p in &mut ext_properties {
            p.s_type = vk::StructureType::QUEUE_FAMILY_PROPERTIES_2;
            p.next = std::ptr::null_mut();
        }

        unsafe {
            (vki.commands().get_physical_device_queue_family_properties)(
                physical_device,
                &raw mut num_core_queue_families,
                core_properties.as_mut_ptr(),
            );
            (vki.commands().get_physical_device_queue_family_properties2)(
                physical_device,
                &raw mut num_ext_queue_families,
                ext_properties.as_mut_ptr(),
            );
        }

        for ndx in 0..ext_properties.len() {
            if ext_properties[ndx].s_type != vk::StructureType::QUEUE_FAMILY_PROPERTIES_2
                || !ext_properties[ndx].next.is_null()
            {
                return Ok(TestStatus::fail(
                    "VkQueueFamilyProperties2 sType/pNext were modified by the driver",
                ));
            }

            if core_properties[ndx] != ext_properties[ndx].queue_family_properties {
                return Ok(TestStatus::fail(
                    "Mismatch between format properties reported by vkGetPhysicalDeviceQueueFamilyProperties and vkGetPhysicalDeviceQueueFamilyProperties2",
                ));
            }
        }
    }

    Ok(TestStatus::pass("Querying device queue family properties succeeded"))
}

/// `deviceMemoryProperties2`
fn device_memory_properties2(context: &Context<'_>) -> TestOutcome {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut core_properties: vk::PhysicalDeviceMemoryProperties = unsafe { std::mem::zeroed() };
    let mut ext_properties: vk::PhysicalDeviceMemoryProperties2 = unsafe { std::mem::zeroed() };

    unsafe {
        std::ptr::write_bytes(
            (&raw mut core_properties).cast::<u8>(),
            0xcd,
            size_of::<vk::PhysicalDeviceMemoryProperties>(),
        );
        std::ptr::write_bytes(
            (&raw mut ext_properties).cast::<u8>(),
            0xcd,
            size_of::<vk::PhysicalDeviceMemoryProperties2>(),
        );
    }

    ext_properties.s_type = vk::StructureType::PHYSICAL_DEVICE_MEMORY_PROPERTIES_2;
    ext_properties.next = std::ptr::null_mut();

    unsafe {
        (vki.commands().get_physical_device_memory_properties)(physical_device, &raw mut core_properties);
        (vki.commands().get_physical_device_memory_properties2)(physical_device, &raw mut ext_properties);
    }

    if ext_properties.s_type != vk::StructureType::PHYSICAL_DEVICE_MEMORY_PROPERTIES_2 || !ext_properties.next.is_null()
    {
        return Ok(TestStatus::fail(
            "VkPhysicalDeviceMemoryProperties2 sType/pNext were modified by the driver",
        ));
    }

    if core_properties.memory_type_count != ext_properties.memory_properties.memory_type_count {
        return Ok(TestStatus::fail(
            "Mismatch between memoryTypeCount reported by vkGetPhysicalDeviceMemoryProperties and vkGetPhysicalDeviceMemoryProperties2",
        ));
    }
    if core_properties.memory_heap_count != ext_properties.memory_properties.memory_heap_count {
        return Ok(TestStatus::fail(
            "Mismatch between memoryHeapCount reported by vkGetPhysicalDeviceMemoryProperties and vkGetPhysicalDeviceMemoryProperties2",
        ));
    }
    for i in 0..core_properties.memory_type_count as usize {
        let core_type = &core_properties.memory_types[i];
        let ext_type = &ext_properties.memory_properties.memory_types[i];
        if core_type.property_flags != ext_type.property_flags || core_type.heap_index != ext_type.heap_index {
            return Ok(TestStatus::fail(
                "Mismatch between memoryTypes reported by vkGetPhysicalDeviceMemoryProperties and vkGetPhysicalDeviceMemoryProperties2",
            ));
        }
    }
    for i in 0..core_properties.memory_heap_count as usize {
        let core_heap = &core_properties.memory_heaps[i];
        let ext_heap = &ext_properties.memory_properties.memory_heaps[i];
        if core_heap.size != ext_heap.size || core_heap.flags != ext_heap.flags {
            return Ok(TestStatus::fail(
                "Mismatch between memoryHeaps reported by vkGetPhysicalDeviceMemoryProperties and vkGetPhysicalDeviceMemoryProperties2",
            ));
        }
    }

    Ok(TestStatus::pass("Querying device memory properties succeeded"))
}

/// The `basic` case that `addFunctionCaseInNewSubgroup` puts in each of the
/// `get_physical_device_properties2` sub-groups.
struct BasicQueryCase {
    test_function: fn(&Context<'_>) -> TestOutcome,
}

impl TestCase for BasicQueryCase {
    fn name(&self) -> &str {
        "basic"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FunctionInstance {
            context,
            test_function: self.test_function,
        })
    }
}

struct FunctionInstance<'a> {
    context: &'a Context<'a>,
    test_function: fn(&Context<'_>) -> TestOutcome,
}

impl TestInstance for FunctionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test_function)(self.context)
    }
}

// ---------------------------------------------------------------------------------
// get_physical_device_properties2.features
// ---------------------------------------------------------------------------------

/// `testPhysicalDeviceFeature*` - one case per VkPhysicalDevice*Features struct.
///
/// The struct is never declared, only described: `feature_struct_list.rs` carries its
/// sType, its size and its VkBool32 members, and the query works on raw bytes. That
/// keeps the case list tied to the registry rather than to whatever subset of these
/// structs vulkanalia happens to define.
struct PhysicalDeviceFeatureCase {
    spec: &'static FeatureStruct,
}

impl TestCase for PhysicalDeviceFeatureCase {
    fn name(&self) -> &str {
        self.spec.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PhysicalDeviceFeatureInstance {
            context,
            spec: self.spec,
        })
    }
}

struct PhysicalDeviceFeatureInstance<'a> {
    context: &'a Context<'a>,
    spec: &'static FeatureStruct,
}

impl TestInstance for PhysicalDeviceFeatureInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let spec = self.spec;
        let context = self.context;

        // `checkExtension(properties, ...)` reads the raw device extension list, so
        // this deliberately does not go through `isDeviceFunctionalitySupported` and
        // its promotion fallback - the core version is the other half of the condition.
        let extensions = context.get_device_extensions();
        let by_extension = spec
            .extensions
            .iter()
            .any(|wanted| extensions.iter().any(|have| have == wanted));
        let (major, minor, _) = context.api_version();
        let by_version = spec
            .api_version
            .is_some_and(|(want_major, want_minor)| (major, minor) >= (want_major, want_minor));
        if !by_extension && !by_version {
            return Ok(TestStatus::pass("Querying not supported"));
        }

        // Two queries into memory pre-filled differently, so a field the driver leaves
        // alone shows up as a mismatch instead of as agreement on garbage.
        let mut answers: [Vec<u8>; 2] = [vec![0x00; spec.size], vec![0xFF; spec.size]];
        for buffer in &mut answers {
            buffer[0..4].copy_from_slice(&spec.s_type.to_ne_bytes());
            buffer[8..16].fill(0);

            let mut features2 = vk::PhysicalDeviceFeatures2 {
                s_type: vk::StructureType::PHYSICAL_DEVICE_FEATURES_2,
                next: buffer.as_mut_ptr().cast::<c_void>(),
                // `deMemset(&extFeatures.features, 0xcd, ...)` - the query overwrites it.
                features: unsafe {
                    std::mem::transmute::<
                        [u8; std::mem::size_of::<vk::PhysicalDeviceFeatures>()],
                        vk::PhysicalDeviceFeatures,
                    >([0xcd; std::mem::size_of::<vk::PhysicalDeviceFeatures>()])
                },
            };
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        for (index, field) in spec.fields.iter().enumerate() {
            let at = 16 + 4 * index;
            let first = u32::from_ne_bytes(answers[0][at..at + 4].try_into().expect("four bytes"));
            let second = u32::from_ne_bytes(answers[1][at..at + 4].try_into().expect("four bytes"));
            if first != second {
                return Ok(TestStatus::fail(format!(
                    "Mismatch between {} ({field})",
                    spec.struct_name
                )));
            }
        }
        Ok(TestStatus::pass("Querying succeeded"))
    }
}

/// `addSeparateFeatureTests`
fn add_separate_feature_tests(group: &mut TestCaseGroup) {
    for spec in FEATURE_STRUCTS {
        group.add_child(Box::new(PhysicalDeviceFeatureCase { spec }) as Box<dyn TestCase>);
    }
}

// ---------------------------------------------------------------------------------
// get_physical_device_properties2.pnext_format_properties
// ---------------------------------------------------------------------------------

/// `FormatPropsPNextFlagBits`
const PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST: u32 = 2;
const PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2: u32 = 1;
const PNEXT_FORMAT_PROPERTIES_3: u32 = 4;
const PNEXT_SUBPASS_RESOLVE_PERFORMANCE_QUERY: u32 = 8;

/// `FormatPropsPNextParams`
#[derive(Clone, Copy)]
struct FormatPropsPNextParams {
    format: vk::Format,
    p_next_flags: u32,
}

/// `FormatPropsCase`
struct FormatPropsCase {
    name: &'static str,
    params: FormatPropsPNextParams,
}

impl TestCase for FormatPropsCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `FormatPropsCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // The instance is always >= 1.1 here, where VK_KHR_get_physical_device_properties2
        // is core, so upstream's requireInstanceFunctionality for it is always satisfied.

        if self.params.p_next_flags & PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST != 0
            || self.params.p_next_flags & PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2 != 0
        {
            context.require_device_functionality("VK_EXT_image_drm_format_modifier")?;
        }

        if self.params.p_next_flags & PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2 != 0
            || self.params.p_next_flags & PNEXT_FORMAT_PROPERTIES_3 != 0
        {
            context.require_device_functionality("VK_KHR_format_feature_flags2")?;
        }

        if self.params.p_next_flags & PNEXT_SUBPASS_RESOLVE_PERFORMANCE_QUERY != 0 {
            context.require_device_functionality("VK_EXT_multisampled_render_to_single_sampled")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FormatPropsTest {
            context,
            params: self.params,
        })
    }
}

/// `FormatPropsTest`
struct FormatPropsTest<'a> {
    context: &'a Context<'a>,
    params: FormatPropsPNextParams,
}

impl TestInstance for FormatPropsTest<'_> {
    /// `FormatPropsTest::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let vki = self.context.get_instance();
        let physical_device = self.context.get_physical_device();

        let mut basic_props = vk::FormatProperties2::default();

        unsafe {
            (vki.commands().get_physical_device_format_properties2)(
                physical_device,
                self.params.format,
                &raw mut basic_props,
            )
        };

        let mut drm_mod_props = vk::DrmFormatModifierPropertiesListEXT::default();
        let mut drm_mod_props2 = vk::DrmFormatModifierPropertiesList2EXT::default();
        let mut props3 = vk::FormatProperties3::default();
        let mut subpass_resolve_props = vk::SubpassResolvePerformanceQueryEXT::default();

        // `makeStructChainAdder(&retryProps)` - each struct is appended to the tail, so
        // the chain keeps the order the flags are tested in.
        let mut retry_props = vk::FormatProperties2::default();
        let mut tail: *mut *mut c_void = &raw mut retry_props.next;

        if self.params.p_next_flags & PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST != 0 {
            unsafe {
                *tail = (&raw mut drm_mod_props).cast();
                tail = &raw mut drm_mod_props.next;
            }
        }

        if self.params.p_next_flags & PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2 != 0 {
            unsafe {
                *tail = (&raw mut drm_mod_props2).cast();
                tail = &raw mut drm_mod_props2.next;
            }
        }

        if self.params.p_next_flags & PNEXT_FORMAT_PROPERTIES_3 != 0 {
            unsafe {
                *tail = (&raw mut props3).cast();
                tail = &raw mut props3.next;
            }
        }

        if self.params.p_next_flags & PNEXT_SUBPASS_RESOLVE_PERFORMANCE_QUERY != 0 {
            unsafe {
                *tail = (&raw mut subpass_resolve_props).cast();
                tail = &raw mut subpass_resolve_props.next;
            }
        }
        let _ = tail;

        unsafe {
            (vki.commands().get_physical_device_format_properties2)(
                physical_device,
                self.params.format,
                &raw mut retry_props,
            )
        };

        if basic_props.format_properties.buffer_features != retry_props.format_properties.buffer_features {
            return Ok(TestStatus::fail("Mismatch in bufferFeatures"));
        }

        if basic_props.format_properties.linear_tiling_features != retry_props.format_properties.linear_tiling_features
        {
            return Ok(TestStatus::fail("Mismatch in linearTilingFeatures"));
        }

        if basic_props.format_properties.optimal_tiling_features
            != retry_props.format_properties.optimal_tiling_features
        {
            return Ok(TestStatus::fail("Mismatch in optimalTilingFeatures"));
        }

        if self.params.p_next_flags & PNEXT_FORMAT_PROPERTIES_3 != 0 {
            let basic_buffer_features2 =
                format_features2_retain(u64::from(basic_props.format_properties.buffer_features.bits()));
            let basic_linear_tiling_features2 =
                format_features2_retain(u64::from(basic_props.format_properties.linear_tiling_features.bits()));
            let basic_optimal_tiling_features2 =
                format_features2_retain(u64::from(basic_props.format_properties.optimal_tiling_features.bits()));

            if (basic_buffer_features2 & props3.buffer_features) != basic_buffer_features2 {
                return Ok(TestStatus::fail("Mismatch in bufferFeatures from VkFormatProperties3"));
            }

            if (basic_linear_tiling_features2 & props3.linear_tiling_features) != basic_linear_tiling_features2 {
                return Ok(TestStatus::fail(
                    "Mismatch in linearTilingFeatures from VkFormatProperties3",
                ));
            }

            if (basic_optimal_tiling_features2 & props3.optimal_tiling_features) != basic_optimal_tiling_features2 {
                return Ok(TestStatus::fail(
                    "Mismatch in optimalTilingFeatures from VkFormatProperties3",
                ));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// FormatPropertiesCase (the format_properties group)
// ---------------------------------------------------------------------------------

/// One `format_properties.<format>` case, plus the two named cases at the end of the group.
struct FormatPropertiesCase {
    name: &'static str,
    format: vk::Format,
    test_function: fn(&Context<'_>, vk::Format) -> TestOutcome,
}

impl TestCase for FormatPropertiesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FormatPropertiesInstance {
            context,
            format: self.format,
            test_function: self.test_function,
        })
    }
}

struct FormatPropertiesInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    test_function: fn(&Context<'_>, vk::Format) -> TestOutcome,
}

impl TestInstance for FormatPropertiesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test_function)(self.context, self.format)
    }
}

// ---------------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------------

fn add_case(group: &mut TestCaseGroup, case: impl TestCase + 'static) {
    group.add_child(Box::new(case) as Box<dyn TestCase>);
}

/// `createFormatTests`
fn create_format_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("format_properties");

    for info in FORMAT_INFO {
        add_case(
            &mut test_group,
            FormatPropertiesCase {
                name: info.name,
                format: info.format,
                test_function: format_properties,
            },
        );
    }

    add_case(
        &mut test_group,
        FormatPropertiesCase {
            name: "depth_stencil",
            format: vk::Format::UNDEFINED,
            test_function: |context, _format| test_depth_stencil_supported(context),
        },
    );
    add_case(
        &mut test_group,
        FormatPropertiesCase {
            name: "compressed_formats",
            format: vk::Format::UNDEFINED,
            test_function: |context, _format| test_compressed_formats_supported(context),
        },
    );

    test_group
}

/// `createImageFormatTypeTilingTests`
fn create_image_format_type_tiling_tests(
    name: &str,
    test_function: ImageFormatFunction,
    image_type: vk::ImageType,
    tiling: vk::ImageTiling,
    extended_flags: bool,
) -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new(name);

    for info in FORMAT_INFO {
        let is_ycbcr = info.ycbcr;
        let is_sparse = test_function == ImageFormatFunction::SparseImageFormatProperties2;

        if is_ycbcr && is_sparse {
            continue;
        }

        if is_ycbcr && image_type != vk::ImageType::_2D {
            continue;
        }

        add_case(
            &mut test_group,
            ImageFormatPropertyCase {
                test_function,
                format: *info,
                image_type,
                tiling,
                extended_flags,
            },
        );
    }

    test_group
}

/// `createImageFormatTypeTests`
fn create_image_format_type_tests(
    name: &str,
    test_function: ImageFormatFunction,
    image_type: vk::ImageType,
    extended_flags: bool,
) -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new(name);

    test_group.add_child(create_image_format_type_tiling_tests(
        "optimal",
        test_function,
        image_type,
        vk::ImageTiling::OPTIMAL,
        extended_flags,
    ));
    test_group.add_child(create_image_format_type_tiling_tests(
        "linear",
        test_function,
        image_type,
        vk::ImageTiling::LINEAR,
        extended_flags,
    ));

    test_group
}

/// `createImageFormatTests` / `createExtendedFlagsImageFormatTests`
fn create_image_format_tests(name: &str, test_function: ImageFormatFunction, extended_flags: bool) -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new(name);

    test_group.add_child(create_image_format_type_tests(
        "1d",
        test_function,
        vk::ImageType::_1D,
        extended_flags,
    ));
    test_group.add_child(create_image_format_type_tests(
        "2d",
        test_function,
        vk::ImageType::_2D,
        extended_flags,
    ));
    test_group.add_child(create_image_format_type_tests(
        "3d",
        test_function,
        vk::ImageType::_3D,
        extended_flags,
    ));

    test_group
}

/// `createImageUsageTilingTests`
fn create_image_usage_tiling_tests(name: &str, tiling: vk::ImageTiling) -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new(name);

    let usage_tests: [(&str, vk::ImageUsageFlags); 6] = [
        ("sampled", vk::ImageUsageFlags::SAMPLED),
        ("storage", vk::ImageUsageFlags::STORAGE),
        ("color_attachment", vk::ImageUsageFlags::COLOR_ATTACHMENT),
        (
            "depth_stencil_attachment",
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
        ),
        ("input_attachment", vk::ImageUsageFlags::INPUT_ATTACHMENT),
        (
            "fragment_shading_rate_attachment",
            vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
        ),
    ];

    for (usage_name, usage) in usage_tests {
        for info in core_formats() {
            add_case(
                &mut test_group,
                ImageUsagePropertyCase {
                    name: format!("{usage_name}_{}", info.name),
                    format: info.format,
                    usage,
                    tiling,
                },
            );
        }
    }

    test_group
}

/// `createImageUsageTests`
fn create_image_usage_tests(name: &str) -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new(name);

    test_group.add_child(create_image_usage_tiling_tests("optimal", vk::ImageTiling::OPTIMAL));
    test_group.add_child(create_image_usage_tiling_tests("linear", vk::ImageTiling::LINEAR));

    test_group
}

/// `addFunctionCaseInNewSubgroup`
fn add_function_case_in_new_subgroup(
    group: &mut TestCaseGroup,
    subgroup_name: &str,
    test_func: fn(&Context<'_>) -> TestOutcome,
) {
    let mut subgroup = TestCaseGroup::new(subgroup_name);
    add_case(
        &mut subgroup,
        BasicQueryCase {
            test_function: test_func,
        },
    );
    group.add_child(subgroup);
}

/// The `get_physical_device_properties2` group, minus `properties.basic`, which walks
/// upstream's generated per-extension property struct table.
fn create_extended_properties_tests() -> TestCaseGroup {
    let mut extended_properties_tests = TestCaseGroup::new("get_physical_device_properties2");

    {
        let mut subgroup = TestCaseGroup::new("features");
        super::case_util::add_function_case_no_support(&mut subgroup, "core", device_features2);
        add_separate_feature_tests(&mut subgroup);
        super::promoted_structures_tests::add_promoted_structures_cases(&mut subgroup);
        super::case_util::add_function_case(
            &mut subgroup,
            "shader_subgroup_rotate_property_consistency_khr",
            check_support_khr_shader_subgroup_rotate,
            subgroup_rotate_property_extension_feature_consistency,
        );
        extended_properties_tests.add_child(subgroup);
    }

    add_function_case_in_new_subgroup(
        &mut extended_properties_tests,
        "format_properties",
        device_format_properties2,
    );
    add_function_case_in_new_subgroup(
        &mut extended_properties_tests,
        "queue_family_properties",
        device_queue_family_properties2,
    );
    add_function_case_in_new_subgroup(
        &mut extended_properties_tests,
        "memory_properties",
        device_memory_properties2,
    );

    {
        let mut format_properties_pnext_group = TestCaseGroup::new("pnext_format_properties");

        let flags_cases: [(u32, &'static str); 11] = [
            (PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST, "drm_format_mod_1"),
            (PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2, "drm_format_mod_2"),
            (PNEXT_FORMAT_PROPERTIES_3, "format_props_3"),
            (PNEXT_SUBPASS_RESOLVE_PERFORMANCE_QUERY, "subpass_resolve_query"),
            (
                PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST | PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2,
                "drm_format_mod_1_and_2",
            ),
            (
                PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST | PNEXT_FORMAT_PROPERTIES_3,
                "drm_format_mod_1_and_format_props_3",
            ),
            (
                PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST | PNEXT_SUBPASS_RESOLVE_PERFORMANCE_QUERY,
                "drm_format_mod_1_and_subpass_resolve_query",
            ),
            (
                PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2 | PNEXT_FORMAT_PROPERTIES_3,
                "drm_format_mod_2_and_format_props_3",
            ),
            (
                PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2 | PNEXT_SUBPASS_RESOLVE_PERFORMANCE_QUERY,
                "drm_format_mod_2_and_subpass_resolve_query",
            ),
            (
                PNEXT_FORMAT_PROPERTIES_3 | PNEXT_SUBPASS_RESOLVE_PERFORMANCE_QUERY,
                "format_props_3_and_subpass_resolve_query",
            ),
            (
                PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST
                    | PNEXT_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2
                    | PNEXT_FORMAT_PROPERTIES_3
                    | PNEXT_SUBPASS_RESOLVE_PERFORMANCE_QUERY,
                "all_format_props",
            ),
        ];

        // Test all the basic formats that do not require extensions. The loop starts by
        // stepping past VK_FORMAT_UNDEFINED, so the group has no `undefined` entry.
        for info in &core_formats()[1..] {
            let mut format_group = TestCaseGroup::new(info.name);

            for (p_next_flags, flags_case_name) in flags_cases {
                let params = FormatPropsPNextParams {
                    format: info.format,
                    p_next_flags,
                };
                add_case(
                    &mut format_group,
                    FormatPropsCase {
                        name: flags_case_name,
                        params,
                    },
                );
            }

            format_properties_pnext_group.add_child(format_group);
        }

        extended_properties_tests.add_child(format_properties_pnext_group);
    }

    extended_properties_tests
}

/// `createFeatureInfoTests`
fn create_feature_info_tests() -> TestCaseGroup {
    let mut info_tests = TestCaseGroup::new("info");

    info_tests.add_child(create_format_tests());
    info_tests.add_child(create_image_format_tests(
        "image_format_properties",
        ImageFormatFunction::ImageFormatProperties,
        false,
    ));
    info_tests.add_child(create_image_usage_tests("unsupported_image_usage"));

    info_tests.add_child(super::extension_core_versions_tests::create_extension_core_versions_group());

    info_tests.add_child(create_extended_properties_tests());
    super::vulkan_features_tests::add_vulkan_features_groups(&mut info_tests);

    info_tests.add_child(create_image_format_tests(
        "image_format_properties2",
        ImageFormatFunction::ImageFormatProperties2,
        false,
    ));
    info_tests.add_child(create_image_format_tests(
        "extended_flags_image_format_properties2",
        ImageFormatFunction::ImageFormatProperties2,
        true,
    ));
    info_tests.add_child(create_image_format_tests(
        "sparse_image_format_properties2",
        ImageFormatFunction::SparseImageFormatProperties2,
        false,
    ));
    info_tests.add_child(create_image_format_tests(
        "extended_flags_sparse_image_format_properties2",
        ImageFormatFunction::SparseImageFormatProperties2,
        true,
    ));

    super::limits_validation_tests::add_limits_validation_groups(&mut info_tests);
    super::limits_validation12_tests::add_limits_validation12_groups(&mut info_tests);

    info_tests
}

/// The groups this file contributes.
///
/// Only `dEQP-VK.api.info` is returned; the top-level `dEQP-VK.info` group, which
/// upstream builds from `createFeatureInfoInstanceTests`/`createFeatureInfoDeviceTests`/
/// `createFeatureInfoDeviceGroupTests` in this same file, is not ported yet.
pub fn create_info_groups() -> Vec<TestCaseGroup> {
    vec![create_feature_info_tests()]
}

/// `deviceFeatures2`: `vkGetPhysicalDeviceFeatures2` reports what `vkGetPhysicalDeviceFeatures` does.
fn device_features2(context: &Context<'_>) -> TestOutcome {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let core_features = unsafe { instance.get_physical_device_features(physical_device) };
    let mut ext_features = vk::PhysicalDeviceFeatures2::default();
    unsafe { instance.get_physical_device_features2(physical_device, &mut ext_features) };

    if ext_features.s_type != vk::StructureType::PHYSICAL_DEVICE_FEATURES_2 || !ext_features.next.is_null() {
        return Err(TestError::Fail(
            "vkGetPhysicalDeviceFeatures2 changed sType or pNext".to_string(),
        ));
    }

    let bytes = |features: &vk::PhysicalDeviceFeatures| {
        unsafe {
            std::slice::from_raw_parts(
                (features as *const vk::PhysicalDeviceFeatures).cast::<u8>(),
                std::mem::size_of::<vk::PhysicalDeviceFeatures>(),
            )
        }
        .to_vec()
    };
    if bytes(&core_features) != bytes(&ext_features.features) {
        return Ok(TestStatus::fail(
            "Mismatch between features reported by vkGetPhysicalDeviceFeatures and vkGetPhysicalDeviceFeatures2",
        ));
    }

    Ok(TestStatus::pass("Querying device features succeeded"))
}

fn check_support_khr_shader_subgroup_rotate(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_shader_subgroup_rotate")
}

/// `subgroupRotatePropertyExtensionFeatureConsistency`
fn subgroup_rotate_property_extension_feature_consistency(context: &Context<'_>) -> TestOutcome {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
    }
    let mut subgroup_rotate_features = vk::PhysicalDeviceShaderSubgroupRotateFeatures::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut subgroup_rotate_features);
        unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
    }

    let (major, minor, _) = context.api_version();
    if (major, minor) < (1, 1) {
        return Err(TestError::NotSupported(
            "At least Vulkan 1.1 required to run test".to_string(),
        ));
    }

    // "VK_KHR_shader_subgroup_rotate" must be at least spec version 2.
    let extension_name = "VK_KHR_shader_subgroup_rotate";
    let device_extensions = unsafe { instance.enumerate_device_extension_properties(physical_device, None) }
        .map_err(|e| TestError::InternalError(format!("vkEnumerateDeviceExtensionProperties returned {e:?}")))?;
    for property in &device_extensions {
        if property.extension_name.to_string_lossy() == extension_name && property.spec_version < 2 {
            return Ok(TestStatus::fail(format!(
                "{extension_name} is version 1. Need version 2 or higher"
            )));
        }
    }

    let rotate = subgroup_properties
        .supported_operations
        .contains(vk::SubgroupFeatureFlags::ROTATE);
    let rotate_clustered = subgroup_properties
        .supported_operations
        .contains(vk::SubgroupFeatureFlags::ROTATE_CLUSTERED);
    if (subgroup_rotate_features.shader_subgroup_rotate != vk::FALSE) != rotate
        || (subgroup_rotate_features.shader_subgroup_rotate_clustered != vk::FALSE) != rotate_clustered
    {
        return Ok(TestStatus::fail(
            "Mismatch between VkPhysicalDeviceShaderSubgroupRotateFeaturesKHR and VkPhysicalDeviceVulkan11Properties",
        ));
    }

    Ok(TestStatus::pass(
        "Vulkan device properties are consistent with VkPhysicalDeviceShaderSubgroupRotateFeaturesKHR",
    ))
}

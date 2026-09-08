// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexture.hpp / .cpp                     (TextureFormat and helpers)
//   external/vulkancts/framework/vulkan/vkImageUtil.cpp        (mapVkFormat)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The enum variants and the mapVkFormat table were extracted mechanically from the
// upstream sources rather than retyped, because a single wrong entry here is a wrong
// verdict on real hardware and there are several hundred of them. Regenerate with
// hodow_cts/scripts/gen_texture_formats.py after a re-sync.

use vulkanalia::vk;

/// `tcu::TextureFormat::ChannelOrder`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[allow(non_camel_case_types)]
pub enum ChannelOrder {
    R,
    A,
    I,
    L,
    LA,
    RG,
    RA,
    RGB,
    RGBA,
    ARGB,
    ABGR,
    BGR,
    BGRA,
    sR,
    sRG,
    sRGB,
    sRGBA,
    sBGR,
    sBGRA,
    D,
    S,
    DS,
}

/// `tcu::TextureFormat::ChannelType`
///
/// The declaration order is upstream's and is load-bearing: `generateBuffer` seeds its
/// random fill with `deInt32Hash(format.type)`, so a reordering silently changes the
/// test data rather than failing to build.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[allow(non_camel_case_types)]
#[repr(u32)]
pub enum ChannelType {
    SNORM_INT8,
    SNORM_INT16,
    SNORM_INT32,
    UNORM_INT8,
    UNORM_INT16,
    UNORM_INT24,
    UNORM_INT32,
    UNORM_BYTE_44,
    UNORM_SHORT_565,
    UNORM_SHORT_555,
    UNORM_SHORT_4444,
    UNORM_SHORT_5551,
    UNORM_SHORT_1555,
    UNORM_INT_101010,
    SNORM_INT_1010102_REV,
    UNORM_INT_1010102_REV,
    UNSIGNED_BYTE_44,
    UNSIGNED_SHORT_565,
    UNSIGNED_SHORT_4444,
    UNSIGNED_SHORT_5551,
    SIGNED_INT_1010102_REV,
    UNSIGNED_INT_1010102_REV,
    UNSIGNED_INT_11F_11F_10F_REV,
    UNSIGNED_INT_999_E5_REV,
    UNSIGNED_INT_16_8_8,
    UNSIGNED_INT_24_8,
    UNSIGNED_INT_24_8_REV,
    SIGNED_INT8,
    SIGNED_INT16,
    SIGNED_INT32,
    SIGNED_INT64,
    UNSIGNED_INT8,
    UNSIGNED_INT16,
    UNSIGNED_INT24,
    UNSIGNED_INT32,
    UNSIGNED_INT64,
    HALF_FLOAT,
    FLOAT,
    FLOAT64,
    FLOAT_UNSIGNED_INT_24_8_REV,
    UNORM_SHORT_10,
    UNORM_SHORT_12,
    USCALED_INT8,
    USCALED_INT16,
    SSCALED_INT8,
    SSCALED_INT16,
    USCALED_INT_1010102_REV,
    SSCALED_INT_1010102_REV,
}

impl ChannelOrder {
    /// `tcu::getNumUsedChannels`
    pub fn num_used_channels(self) -> u32 {
        match self {
            // @generated:num_used_channels
            Self::R => 1,
            Self::A => 1,
            Self::I => 1,
            Self::L => 1,
            Self::LA => 2,
            Self::RG => 2,
            Self::RA => 2,
            Self::RGB => 3,
            Self::RGBA => 4,
            Self::ARGB => 4,
            Self::ABGR => 4,
            Self::BGR => 3,
            Self::BGRA => 4,
            Self::sR => 1,
            Self::sRG => 2,
            Self::sRGB => 3,
            Self::sRGBA => 4,
            Self::sBGR => 3,
            Self::sBGRA => 4,
            Self::D => 1,
            Self::S => 1,
            Self::DS => 2,
        }
    }

    /// True for the orders that carry depth or stencil rather than colour.
    pub fn has_depth(self) -> bool {
        matches!(self, Self::D | Self::DS)
    }

    pub fn has_stencil(self) -> bool {
        matches!(self, Self::S | Self::DS)
    }

    /// True for the sRGB-encoded orders.
    pub fn is_srgb(self) -> bool {
        matches!(self, Self::sR | Self::sRG | Self::sRGB | Self::sRGBA | Self::sBGR | Self::sBGRA)
    }
}

impl ChannelType {
    /// `tcu::getChannelSize`. None for the packed types, whose size belongs to the
    /// format as a whole rather than to one channel - `TextureFormat::pixel_size`
    /// handles those.
    pub fn channel_size(self) -> Option<u32> {
        match self {
            // @generated:channel_size
            Self::SNORM_INT8 => Some(1),
            Self::SNORM_INT16 => Some(2),
            Self::SNORM_INT32 => Some(4),
            Self::UNORM_INT8 => Some(1),
            Self::UNORM_INT16 => Some(2),
            Self::UNORM_INT24 => Some(3),
            Self::UNORM_INT32 => Some(4),
            Self::SNORM_INT_1010102_REV => Some(4),
            Self::UNORM_INT_1010102_REV => Some(4),
            Self::SIGNED_INT_1010102_REV => Some(4),
            Self::UNSIGNED_INT_1010102_REV => Some(4),
            Self::UNSIGNED_INT_11F_11F_10F_REV => Some(4),
            Self::UNSIGNED_INT_999_E5_REV => Some(4),
            Self::SIGNED_INT8 => Some(1),
            Self::SIGNED_INT16 => Some(2),
            Self::SIGNED_INT32 => Some(4),
            Self::SIGNED_INT64 => Some(8),
            Self::UNSIGNED_INT8 => Some(1),
            Self::UNSIGNED_INT16 => Some(2),
            Self::UNSIGNED_INT24 => Some(3),
            Self::UNSIGNED_INT32 => Some(4),
            Self::UNSIGNED_INT64 => Some(8),
            Self::HALF_FLOAT => Some(2),
            Self::FLOAT => Some(4),
            Self::FLOAT64 => Some(8),
            Self::UNORM_SHORT_10 => Some(2),
            Self::UNORM_SHORT_12 => Some(2),
            Self::USCALED_INT8 => Some(1),
            Self::USCALED_INT16 => Some(2),
            Self::SSCALED_INT8 => Some(1),
            Self::SSCALED_INT16 => Some(2),
            Self::USCALED_INT_1010102_REV => Some(4),
            Self::SSCALED_INT_1010102_REV => Some(4),
            _ => None,
        }
    }

    /// `tcu::getTextureChannelClass`
    pub fn channel_class(self) -> TextureChannelClass {
        use ChannelType::*;
        match self {
            // @generated:channel_class
            SNORM_INT8 => TextureChannelClass::SignedFixedPoint,
            SNORM_INT16 => TextureChannelClass::SignedFixedPoint,
            SNORM_INT32 => TextureChannelClass::SignedFixedPoint,
            UNORM_INT8 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_INT16 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_INT24 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_INT32 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_BYTE_44 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_SHORT_565 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_SHORT_555 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_SHORT_4444 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_SHORT_5551 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_SHORT_1555 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_INT_101010 => TextureChannelClass::UnsignedFixedPoint,
            SNORM_INT_1010102_REV => TextureChannelClass::SignedFixedPoint,
            UNORM_INT_1010102_REV => TextureChannelClass::UnsignedFixedPoint,
            UNSIGNED_BYTE_44 => TextureChannelClass::UnsignedInteger,
            UNSIGNED_SHORT_565 => TextureChannelClass::UnsignedInteger,
            UNSIGNED_SHORT_4444 => TextureChannelClass::UnsignedInteger,
            UNSIGNED_SHORT_5551 => TextureChannelClass::UnsignedInteger,
            SIGNED_INT_1010102_REV => TextureChannelClass::SignedInteger,
            UNSIGNED_INT_1010102_REV => TextureChannelClass::UnsignedInteger,
            UNSIGNED_INT_11F_11F_10F_REV => TextureChannelClass::FloatingPoint,
            UNSIGNED_INT_999_E5_REV => TextureChannelClass::FloatingPoint,
            UNSIGNED_INT_16_8_8 => TextureChannelClass::Last,
            UNSIGNED_INT_24_8 => TextureChannelClass::Last,
            UNSIGNED_INT_24_8_REV => TextureChannelClass::Last,
            SIGNED_INT8 => TextureChannelClass::SignedInteger,
            SIGNED_INT16 => TextureChannelClass::SignedInteger,
            SIGNED_INT32 => TextureChannelClass::SignedInteger,
            SIGNED_INT64 => TextureChannelClass::SignedInteger,
            UNSIGNED_INT8 => TextureChannelClass::UnsignedInteger,
            UNSIGNED_INT16 => TextureChannelClass::UnsignedInteger,
            UNSIGNED_INT24 => TextureChannelClass::UnsignedInteger,
            UNSIGNED_INT32 => TextureChannelClass::UnsignedInteger,
            UNSIGNED_INT64 => TextureChannelClass::UnsignedInteger,
            HALF_FLOAT => TextureChannelClass::FloatingPoint,
            FLOAT => TextureChannelClass::FloatingPoint,
            FLOAT64 => TextureChannelClass::FloatingPoint,
            FLOAT_UNSIGNED_INT_24_8_REV => TextureChannelClass::Last,
            UNORM_SHORT_10 => TextureChannelClass::UnsignedFixedPoint,
            UNORM_SHORT_12 => TextureChannelClass::UnsignedFixedPoint,
            USCALED_INT8 => TextureChannelClass::UnsignedInteger,
            USCALED_INT16 => TextureChannelClass::UnsignedInteger,
            SSCALED_INT8 => TextureChannelClass::SignedInteger,
            SSCALED_INT16 => TextureChannelClass::SignedInteger,
            USCALED_INT_1010102_REV => TextureChannelClass::UnsignedInteger,
            SSCALED_INT_1010102_REV => TextureChannelClass::SignedInteger,
        }
    }
}

/// `tcu::TextureChannelClass`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum TextureChannelClass {
    SignedFixedPoint,
    UnsignedFixedPoint,
    SignedInteger,
    UnsignedInteger,
    FloatingPoint,
    /// `TEXTURECHANNELCLASS_LAST` - upstream's sentinel. The combined depth/stencil
    /// types return it because their two aspects have different classes, and the clear
    /// colour table uses it to mean "no channel-class filter".
    Last,
}

/// `tcu::TextureFormat`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct TextureFormat {
    pub order: ChannelOrder,
    pub type_: ChannelType,
}

impl TextureFormat {
    pub const fn new(order: ChannelOrder, type_: ChannelType) -> Self {
        Self { order, type_ }
    }

    /// `tcu::getPixelSize`. A packed type stores every channel in one unit, so its
    /// size is the size of that unit; everything else is channels x channel size.
    pub fn pixel_size(self) -> Option<u32> {
        use ChannelType::*;
        let packed = match self.type_ {
            UNORM_BYTE_44 | UNSIGNED_BYTE_44 => Some(1),
            UNORM_SHORT_565 | UNSIGNED_SHORT_565 | UNORM_SHORT_555 | UNORM_SHORT_4444 | UNSIGNED_SHORT_4444 | UNORM_SHORT_5551 | UNSIGNED_SHORT_5551 | UNORM_SHORT_1555 => Some(2),
            UNORM_INT_101010
            | UNSIGNED_INT_999_E5_REV
            | UNSIGNED_INT_11F_11F_10F_REV
            | SNORM_INT_1010102_REV
            | UNORM_INT_1010102_REV
            | SIGNED_INT_1010102_REV
            | UNSIGNED_INT_1010102_REV
            | UNSIGNED_INT_24_8
            | UNSIGNED_INT_24_8_REV
            | UNSIGNED_INT_16_8_8
            | USCALED_INT_1010102_REV
            | SSCALED_INT_1010102_REV => Some(4),
            FLOAT_UNSIGNED_INT_24_8_REV => Some(8),
            _ => None,
        };
        match packed {
            Some(n) => Some(n),
            None => Some(self.order.num_used_channels() * self.type_.channel_size()?),
        }
    }

    pub fn channel_class(self) -> TextureChannelClass {
        self.type_.channel_class()
    }
}

/// `vk::mapVkFormat`
///
/// None for the formats upstream refuses to map - the compressed ones and the
/// multi-planar YCbCr ones, which it handles through separate paths.
pub fn map_vk_format(format: vk::Format) -> Option<TextureFormat> {
    match format {
        // @generated:map_vk_format
        vk::Format::R4G4_UNORM_PACK8 => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNORM_BYTE_44)),
        vk::Format::R5G6B5_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_SHORT_565)),
        vk::Format::R4G4B4A4_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_SHORT_4444)),
        vk::Format::R5G5B5A1_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_SHORT_5551)),
        vk::Format::B5G6R5_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::BGR, ChannelType::UNORM_SHORT_565)),
        vk::Format::B4G4R4A4_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNORM_SHORT_4444)),
        vk::Format::B5G5R5A1_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNORM_SHORT_5551)),
        vk::Format::A1R5G5B5_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::ARGB, ChannelType::UNORM_SHORT_1555)),
        vk::Format::A1B5G5R5_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::ABGR, ChannelType::UNORM_SHORT_1555)),
        vk::Format::R8_UNORM => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNORM_INT8)),
        vk::Format::R8_SNORM => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SNORM_INT8)),
        vk::Format::R8_USCALED => Some(TextureFormat::new(ChannelOrder::R, ChannelType::USCALED_INT8)),
        vk::Format::R8_SSCALED => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SSCALED_INT8)),
        vk::Format::R8_UINT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT8)),
        vk::Format::R8_SINT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT8)),
        vk::Format::R8_SRGB => Some(TextureFormat::new(ChannelOrder::sR, ChannelType::UNORM_INT8)),
        vk::Format::A8_UNORM => Some(TextureFormat::new(ChannelOrder::A, ChannelType::UNORM_INT8)),
        vk::Format::R8G8_UNORM => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNORM_INT8)),
        vk::Format::R8G8_SNORM => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SNORM_INT8)),
        vk::Format::R8G8_USCALED => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::USCALED_INT8)),
        vk::Format::R8G8_SSCALED => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SSCALED_INT8)),
        vk::Format::R8G8_UINT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNSIGNED_INT8)),
        vk::Format::R8G8_SINT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SIGNED_INT8)),
        vk::Format::R8G8_SRGB => Some(TextureFormat::new(ChannelOrder::sRG, ChannelType::UNORM_INT8)),
        vk::Format::R8G8B8_UNORM => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_INT8)),
        vk::Format::R8G8B8_SNORM => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SNORM_INT8)),
        vk::Format::R8G8B8_USCALED => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::USCALED_INT8)),
        vk::Format::R8G8B8_SSCALED => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SSCALED_INT8)),
        vk::Format::R8G8B8_UINT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT8)),
        vk::Format::R8G8B8_SINT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SIGNED_INT8)),
        vk::Format::R8G8B8_SRGB => Some(TextureFormat::new(ChannelOrder::sRGB, ChannelType::UNORM_INT8)),
        vk::Format::R8G8B8A8_UNORM => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)),
        vk::Format::R8G8B8A8_SNORM => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SNORM_INT8)),
        vk::Format::R8G8B8A8_USCALED => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::USCALED_INT8)),
        vk::Format::R8G8B8A8_SSCALED => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SSCALED_INT8)),
        vk::Format::R8G8B8A8_UINT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8)),
        vk::Format::R8G8B8A8_SINT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT8)),
        vk::Format::R8G8B8A8_SRGB => Some(TextureFormat::new(ChannelOrder::sRGBA, ChannelType::UNORM_INT8)),
        vk::Format::R16_UNORM => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNORM_INT16)),
        vk::Format::R16_SNORM => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SNORM_INT16)),
        vk::Format::R16_USCALED => Some(TextureFormat::new(ChannelOrder::R, ChannelType::USCALED_INT16)),
        vk::Format::R16_SSCALED => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SSCALED_INT16)),
        vk::Format::R16_UINT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT16)),
        vk::Format::R16_SINT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT16)),
        vk::Format::R16_SFLOAT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::HALF_FLOAT)),
        vk::Format::R16G16_UNORM => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNORM_INT16)),
        vk::Format::R16G16_SNORM => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SNORM_INT16)),
        vk::Format::R16G16_USCALED => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::USCALED_INT16)),
        vk::Format::R16G16_SSCALED => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SSCALED_INT16)),
        vk::Format::R16G16_UINT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNSIGNED_INT16)),
        vk::Format::R16G16_SINT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SIGNED_INT16)),
        vk::Format::R16G16_SFLOAT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::HALF_FLOAT)),
        vk::Format::R16G16B16_UNORM => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_INT16)),
        vk::Format::R16G16B16_SNORM => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SNORM_INT16)),
        vk::Format::R16G16B16_USCALED => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::USCALED_INT16)),
        vk::Format::R16G16B16_SSCALED => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SSCALED_INT16)),
        vk::Format::R16G16B16_UINT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT16)),
        vk::Format::R16G16B16_SINT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SIGNED_INT16)),
        vk::Format::R16G16B16_SFLOAT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::HALF_FLOAT)),
        vk::Format::R16G16B16A16_UNORM => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT16)),
        vk::Format::R16G16B16A16_SNORM => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SNORM_INT16)),
        vk::Format::R16G16B16A16_USCALED => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::USCALED_INT16)),
        vk::Format::R16G16B16A16_SSCALED => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SSCALED_INT16)),
        vk::Format::R16G16B16A16_UINT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT16)),
        vk::Format::R16G16B16A16_SINT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT16)),
        vk::Format::R16G16B16A16_SFLOAT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::HALF_FLOAT)),
        vk::Format::R32_UINT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT32)),
        vk::Format::R32_SINT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT32)),
        vk::Format::R32_SFLOAT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::FLOAT)),
        vk::Format::R32G32_UINT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNSIGNED_INT32)),
        vk::Format::R32G32_SINT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SIGNED_INT32)),
        vk::Format::R32G32_SFLOAT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::FLOAT)),
        vk::Format::R32G32B32_UINT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT32)),
        vk::Format::R32G32B32_SINT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SIGNED_INT32)),
        vk::Format::R32G32B32_SFLOAT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::FLOAT)),
        vk::Format::R32G32B32A32_UINT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32)),
        vk::Format::R32G32B32A32_SINT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32)),
        vk::Format::R32G32B32A32_SFLOAT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT)),
        vk::Format::R64_UINT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT64)),
        vk::Format::R64G64_UINT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNSIGNED_INT64)),
        vk::Format::R64G64B64_UINT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT64)),
        vk::Format::R64G64B64A64_UINT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT64)),
        vk::Format::R64_SINT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT64)),
        vk::Format::R64G64_SINT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SIGNED_INT64)),
        vk::Format::R64G64B64_SINT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SIGNED_INT64)),
        vk::Format::R64G64B64A64_SINT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT64)),
        vk::Format::R64_SFLOAT => Some(TextureFormat::new(ChannelOrder::R, ChannelType::FLOAT64)),
        vk::Format::R64G64_SFLOAT => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::FLOAT64)),
        vk::Format::R64G64B64_SFLOAT => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::FLOAT64)),
        vk::Format::R64G64B64A64_SFLOAT => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT64)),
        vk::Format::B10G11R11_UFLOAT_PACK32 => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT_11F_11F_10F_REV)),
        vk::Format::E5B9G9R9_UFLOAT_PACK32 => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT_999_E5_REV)),
        vk::Format::B8G8R8_UNORM => Some(TextureFormat::new(ChannelOrder::BGR, ChannelType::UNORM_INT8)),
        vk::Format::B8G8R8_SNORM => Some(TextureFormat::new(ChannelOrder::BGR, ChannelType::SNORM_INT8)),
        vk::Format::B8G8R8_USCALED => Some(TextureFormat::new(ChannelOrder::BGR, ChannelType::USCALED_INT8)),
        vk::Format::B8G8R8_SSCALED => Some(TextureFormat::new(ChannelOrder::BGR, ChannelType::SSCALED_INT8)),
        vk::Format::B8G8R8_UINT => Some(TextureFormat::new(ChannelOrder::BGR, ChannelType::UNSIGNED_INT8)),
        vk::Format::B8G8R8_SINT => Some(TextureFormat::new(ChannelOrder::BGR, ChannelType::SIGNED_INT8)),
        vk::Format::B8G8R8_SRGB => Some(TextureFormat::new(ChannelOrder::sBGR, ChannelType::UNORM_INT8)),
        vk::Format::B8G8R8A8_UNORM => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNORM_INT8)),
        vk::Format::B8G8R8A8_SNORM => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::SNORM_INT8)),
        vk::Format::B8G8R8A8_USCALED => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::USCALED_INT8)),
        vk::Format::B8G8R8A8_SSCALED => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::SSCALED_INT8)),
        vk::Format::B8G8R8A8_UINT => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNSIGNED_INT8)),
        vk::Format::B8G8R8A8_SINT => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::SIGNED_INT8)),
        vk::Format::B8G8R8A8_SRGB => Some(TextureFormat::new(ChannelOrder::sBGRA, ChannelType::UNORM_INT8)),
        vk::Format::D16_UNORM => Some(TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16)),
        vk::Format::X8_D24_UNORM_PACK32 => Some(TextureFormat::new(ChannelOrder::D, ChannelType::UNSIGNED_INT_24_8_REV)),
        vk::Format::D32_SFLOAT => Some(TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT)),
        vk::Format::S8_UINT => Some(TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8)),
        vk::Format::D16_UNORM_S8_UINT => Some(TextureFormat::new(ChannelOrder::DS, ChannelType::UNSIGNED_INT_16_8_8)),
        vk::Format::D24_UNORM_S8_UINT => Some(TextureFormat::new(ChannelOrder::DS, ChannelType::UNSIGNED_INT_24_8_REV)),
        vk::Format::D32_SFLOAT_S8_UINT => Some(TextureFormat::new(ChannelOrder::DS, ChannelType::FLOAT_UNSIGNED_INT_24_8_REV)),
        vk::Format::A8B8G8R8_UNORM_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)),
        vk::Format::A8B8G8R8_SNORM_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SNORM_INT8)),
        vk::Format::A8B8G8R8_USCALED_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::USCALED_INT8)),
        vk::Format::A8B8G8R8_SSCALED_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SSCALED_INT8)),
        vk::Format::A8B8G8R8_UINT_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8)),
        vk::Format::A8B8G8R8_SINT_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT8)),
        vk::Format::A8B8G8R8_SRGB_PACK32 => Some(TextureFormat::new(ChannelOrder::sRGBA, ChannelType::UNORM_INT8)),
        vk::Format::A2R10G10B10_UNORM_PACK32 => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNORM_INT_1010102_REV)),
        vk::Format::A2R10G10B10_SNORM_PACK32 => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::SNORM_INT_1010102_REV)),
        vk::Format::A2R10G10B10_USCALED_PACK32 => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::USCALED_INT_1010102_REV)),
        vk::Format::A2R10G10B10_SSCALED_PACK32 => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::SSCALED_INT_1010102_REV)),
        vk::Format::A2R10G10B10_UINT_PACK32 => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNSIGNED_INT_1010102_REV)),
        vk::Format::A2R10G10B10_SINT_PACK32 => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::SIGNED_INT_1010102_REV)),
        vk::Format::A2B10G10R10_UNORM_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT_1010102_REV)),
        vk::Format::A2B10G10R10_SNORM_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SNORM_INT_1010102_REV)),
        vk::Format::A2B10G10R10_USCALED_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::USCALED_INT_1010102_REV)),
        vk::Format::A2B10G10R10_SSCALED_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SSCALED_INT_1010102_REV)),
        vk::Format::A2B10G10R10_UINT_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT_1010102_REV)),
        vk::Format::A2B10G10R10_SINT_PACK32 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT_1010102_REV)),
        vk::Format::R10X6_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNORM_SHORT_10)),
        vk::Format::R10X6G10X6_UNORM_2PACK16 => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNORM_SHORT_10)),
        vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_SHORT_10)),
        vk::Format::R12X4_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNORM_SHORT_12)),
        vk::Format::R12X4G12X4_UNORM_2PACK16 => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNORM_SHORT_12)),
        vk::Format::R12X4G12X4B12X4A12X4_UNORM_4PACK16 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_SHORT_12)),
        vk::Format::A4R4G4B4_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::ARGB, ChannelType::UNORM_SHORT_4444)),
        vk::Format::A4B4G4R4_UNORM_PACK16 => Some(TextureFormat::new(ChannelOrder::ABGR, ChannelType::UNORM_SHORT_4444)),
        _ => None,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Spot checks against values read out of the upstream sources by hand. The table
    /// itself is generated, so this is the guard against a regeneration that silently
    /// produces something plausible but wrong.
    #[test]
    fn known_formats_map_as_upstream_does() {
        let cases: &[(vk::Format, ChannelOrder, ChannelType, u32)] = &[
            (vk::Format::R8G8B8A8_UNORM, ChannelOrder::RGBA, ChannelType::UNORM_INT8, 4),
            (vk::Format::B8G8R8A8_UNORM, ChannelOrder::BGRA, ChannelType::UNORM_INT8, 4),
            (vk::Format::R5G6B5_UNORM_PACK16, ChannelOrder::RGB, ChannelType::UNORM_SHORT_565, 2),
            (vk::Format::R32G32B32A32_SFLOAT, ChannelOrder::RGBA, ChannelType::FLOAT, 16),
            (vk::Format::R16G16_SINT, ChannelOrder::RG, ChannelType::SIGNED_INT16, 4),
            (vk::Format::D32_SFLOAT, ChannelOrder::D, ChannelType::FLOAT, 4),
            (vk::Format::D24_UNORM_S8_UINT, ChannelOrder::DS, ChannelType::UNSIGNED_INT_24_8_REV, 4),
            (vk::Format::S8_UINT, ChannelOrder::S, ChannelType::UNSIGNED_INT8, 1),
            (vk::Format::B10G11R11_UFLOAT_PACK32, ChannelOrder::RGB, ChannelType::UNSIGNED_INT_11F_11F_10F_REV, 4),
            (vk::Format::R8G8B8A8_SRGB, ChannelOrder::sRGBA, ChannelType::UNORM_INT8, 4),
        ];

        for &(format, order, type_, pixel_size) in cases {
            let mapped = map_vk_format(format).unwrap_or_else(|| panic!("{format:?} did not map"));
            assert_eq!(mapped.order, order, "{format:?} order");
            assert_eq!(mapped.type_, type_, "{format:?} type");
            assert_eq!(mapped.pixel_size(), Some(pixel_size), "{format:?} pixel size");
        }
    }

    #[test]
    fn compressed_formats_are_not_mapped() {
        // Upstream's mapVkFormat throws for these; None is the equivalent, and a
        // caller that silently treated a block-compressed format as uncompressed
        // would read the wrong number of bytes per texel.
        assert_eq!(map_vk_format(vk::Format::BC1_RGB_UNORM_BLOCK), None);
        assert_eq!(map_vk_format(vk::Format::ASTC_4X4_UNORM_BLOCK), None);
    }

    #[test]
    fn channel_classes_match_upstream() {
        assert_eq!(ChannelType::UNORM_INT8.channel_class(), TextureChannelClass::UnsignedFixedPoint);
        assert_eq!(ChannelType::SNORM_INT8.channel_class(), TextureChannelClass::SignedFixedPoint);
        assert_eq!(ChannelType::SIGNED_INT32.channel_class(), TextureChannelClass::SignedInteger);
        assert_eq!(ChannelType::UNSIGNED_INT32.channel_class(), TextureChannelClass::UnsignedInteger);
        assert_eq!(ChannelType::FLOAT.channel_class(), TextureChannelClass::FloatingPoint);
    }
}

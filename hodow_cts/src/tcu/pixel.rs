// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexture.cpp   (ConstPixelBufferAccess, channelToFloat,
//                                      channelToIntType, the bit-depth tables)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Decoding a stored texel back into a colour is what every image test needs in order
// to check what the driver actually wrote. Narrowed to the tightly-packed, single-
// plane case the copy and clear tests read back, so the pitch is derived from the
// size rather than carried.

// A port of a library layer: upstream's tcu exposes all of this and no single
// consumer uses every entry point. The image copy and clear groups being ported next
// use most of it; silencing here beats deleting code that is about to be needed.
#![allow(dead_code)]

use super::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};

#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum Swz {
    C0,
    C1,
    C2,
    C3,
    ZERO,
    ONE,
}

impl Swz {
    fn index(self) -> Option<usize> {
        match self {
            Self::C0 => Some(0),
            Self::C1 => Some(1),
            Self::C2 => Some(2),
            Self::C3 => Some(3),
            Self::ZERO | Self::ONE => None,
        }
    }
}

/// `tcu::getChannelReadSwizzle` - the full 22-order table, extracted from upstream.
fn get_channel_read_swizzle(order: ChannelOrder) -> [Swz; 4] {
    use ChannelOrder::*;
    use Swz::*;
    match order {
        R => [C0, ZERO, ZERO, ONE],
        A => [ZERO, ZERO, ZERO, C0],
        I => [C0, C0, C0, C0],
        L => [C0, C0, C0, ONE],
        LA => [C0, C0, C0, C1],
        RG => [C0, C1, ZERO, ONE],
        RA => [C0, ZERO, ZERO, C1],
        RGB => [C0, C1, C2, ONE],
        RGBA => [C0, C1, C2, C3],
        ARGB => [C1, C2, C3, C0],
        ABGR => [C3, C2, C1, C0],
        BGR => [C2, C1, C0, ONE],
        BGRA => [C2, C1, C0, C3],
        sR => [C0, ZERO, ZERO, ONE],
        sRG => [C0, C1, ZERO, ONE],
        sRGB => [C0, C1, C2, ONE],
        sRGBA => [C0, C1, C2, C3],
        sBGR => [C2, C1, C0, ONE],
        sBGRA => [C2, C1, C0, C3],
        D => [C0, ZERO, ZERO, ONE],
        S => [C0, ZERO, ZERO, ONE],
        DS => [C0, C1, ZERO, ONE],
    }
}

/// `tcu::isCombinedDepthStencilType`
fn is_combined_depth_stencil_type(type_: ChannelType) -> bool {
    use ChannelType::*;
    matches!(type_, UNSIGNED_INT_16_8_8 | UNSIGNED_INT_24_8_REV | FLOAT_UNSIGNED_INT_24_8_REV)
}

/// `tcu::getChannelBitDepth` - the full 48-type table, extracted from upstream.
pub fn get_channel_bit_depth(type_: ChannelType) -> [i32; 4] {
    use ChannelType::*;
    match type_ {
        SNORM_INT8 => [8, 8, 8, 8],
        SNORM_INT16 => [16, 16, 16, 16],
        SNORM_INT32 => [32, 32, 32, 32],
        UNORM_INT8 => [8, 8, 8, 8],
        UNORM_INT16 => [16, 16, 16, 16],
        UNORM_INT24 => [24, 24, 24, 24],
        UNORM_INT32 => [32, 32, 32, 32],
        UNORM_BYTE_44 => [4, 4, 0, 0],
        UNORM_SHORT_565 => [5, 6, 5, 0],
        UNORM_SHORT_555 => [5, 5, 5, 0],
        UNORM_SHORT_4444 => [4, 4, 4, 4],
        UNORM_SHORT_5551 => [5, 5, 5, 1],
        UNORM_SHORT_1555 => [1, 5, 5, 5],
        UNORM_INT_101010 => [10, 10, 10, 0],
        SNORM_INT_1010102_REV => [10, 10, 10, 2],
        UNORM_INT_1010102_REV => [10, 10, 10, 2],
        UNSIGNED_BYTE_44 => [4, 4, 0, 0],
        UNSIGNED_SHORT_565 => [5, 6, 5, 0],
        UNSIGNED_SHORT_4444 => [4, 4, 4, 4],
        UNSIGNED_SHORT_5551 => [5, 5, 5, 1],
        SIGNED_INT_1010102_REV => [10, 10, 10, 2],
        UNSIGNED_INT_1010102_REV => [10, 10, 10, 2],
        UNSIGNED_INT_11F_11F_10F_REV => [11, 11, 10, 0],
        UNSIGNED_INT_999_E5_REV => [9, 9, 9, 0],
        UNSIGNED_INT_16_8_8 => [16, 8, 0, 0],
        UNSIGNED_INT_24_8 => [24, 8, 0, 0],
        UNSIGNED_INT_24_8_REV => [24, 8, 0, 0],
        SIGNED_INT8 => [8, 8, 8, 8],
        SIGNED_INT16 => [16, 16, 16, 16],
        SIGNED_INT32 => [32, 32, 32, 32],
        SIGNED_INT64 => [64, 64, 64, 64],
        UNSIGNED_INT8 => [8, 8, 8, 8],
        UNSIGNED_INT16 => [16, 16, 16, 16],
        UNSIGNED_INT24 => [24, 24, 24, 24],
        UNSIGNED_INT32 => [32, 32, 32, 32],
        UNSIGNED_INT64 => [64, 64, 64, 64],
        HALF_FLOAT => [16, 16, 16, 16],
        FLOAT => [32, 32, 32, 32],
        FLOAT64 => [64, 64, 64, 64],
        FLOAT_UNSIGNED_INT_24_8_REV => [32, 8, 0, 0],
        UNORM_SHORT_10 => [10, 10, 10, 10],
        UNORM_SHORT_12 => [12, 12, 12, 12],
        USCALED_INT8 => [8, 8, 8, 8],
        USCALED_INT16 => [16, 16, 16, 16],
        SSCALED_INT8 => [8, 8, 8, 8],
        SSCALED_INT16 => [16, 16, 16, 16],
        USCALED_INT_1010102_REV => [10, 10, 10, 2],
        SSCALED_INT_1010102_REV => [10, 10, 10, 2],
    }
}

/// `tcu::getChannelMantissaBitDepth`
fn get_channel_mantissa_bit_depth(type_: ChannelType) -> [i32; 4] {
    use ChannelType::*;
    match type_ {
        HALF_FLOAT => [10; 4],
        FLOAT => [23; 4],
        UNSIGNED_INT_11F_11F_10F_REV => [6, 6, 5, 0],
        FLOAT_UNSIGNED_INT_24_8_REV => [23, 8, 0, 0],
        other => get_channel_bit_depth(other),
    }
}

/// Shared body of `getTextureFormatBitDepth` / `getTextureFormatMantissaBitDepth`:
/// swizzle the per-channel depths through the read swizzle, zeroing constant channels.
fn swizzle_bit_depth(chn_bits: [i32; 4], order: ChannelOrder) -> [i32; 4] {
    let map = get_channel_read_swizzle(order);
    let mut out = [0i32; 4];
    for c in 0..4 {
        if let Some(i) = map[c].index() {
            out[c] = chn_bits[i];
        }
    }
    out
}

/// `tcu::getTextureFormatBitDepth`
pub fn get_texture_format_bit_depth(format: TextureFormat) -> [i32; 4] {
    swizzle_bit_depth(get_channel_bit_depth(format.type_), format.order)
}

/// `tcu::getTextureFormatMantissaBitDepth`
pub fn get_texture_format_mantissa_bit_depth(format: TextureFormat) -> [i32; 4] {
    swizzle_bit_depth(get_channel_mantissa_bit_depth(format.type_), format.order)
}

/// `tcu::getTextureFormatChannelMask`
pub fn get_texture_format_channel_mask(format: TextureFormat) -> [bool; 4] {
    let map = get_channel_read_swizzle(format.order);
    [map[0].index().is_some(), map[1].index().is_some(), map[2].index().is_some(), map[3].index().is_some()]
}

/// `tcu::linearChannelToSRGB`
fn linear_channel_to_srgb(cl: f32) -> f32 {
    if cl <= 0.0 {
        0.0
    } else if cl < 0.003_130_8 {
        12.92 * cl
    } else if cl < 1.0 {
        1.055 * cl.powf(0.41666) - 0.055
    } else {
        1.0
    }
}

/// `tcu::linearToSRGB`
pub fn linear_to_srgb(cl: [f32; 4]) -> [f32; 4] {
    [linear_channel_to_srgb(cl[0]), linear_channel_to_srgb(cl[1]), linear_channel_to_srgb(cl[2]), cl[3]]
}

/// `tcu::getFormatMaxUintValue`
pub fn get_format_max_uint_value(format: TextureFormat) -> [u32; 4] {
    use ChannelOrder::{BGRA, RGBA};
    use ChannelType::*;
    if matches!(format.order, RGBA | BGRA) && matches!(format.type_, UNSIGNED_INT_1010102_REV | USCALED_INT_1010102_REV) {
        return [1023, 1023, 1023, 3];
    }
    match format.type_ {
        UNSIGNED_INT8 | USCALED_INT8 => [u8::MAX as u32; 4],
        UNSIGNED_INT16 | USCALED_INT16 => [u16::MAX as u32; 4],
        UNSIGNED_INT32 => [u32::MAX; 4],
        _ => [0; 4],
    }
}

/// `tcu::getFormatMaxIntValue`
pub fn get_format_max_int_value(format: TextureFormat) -> [i32; 4] {
    use ChannelOrder::{BGRA, RGBA};
    use ChannelType::*;
    if matches!(format.order, RGBA | BGRA) && matches!(format.type_, SIGNED_INT_1010102_REV | SSCALED_INT_1010102_REV) {
        return [511, 511, 511, 1];
    }
    match format.type_ {
        SIGNED_INT8 | SSCALED_INT8 => [i8::MAX as i32; 4],
        SIGNED_INT16 | SSCALED_INT16 => [i16::MAX as i32; 4],
        SIGNED_INT32 => [i32::MAX; 4],
        _ => [0; 4],
    }
}

/// `tcu::hasDepthComponent`
pub fn has_depth_component(order: ChannelOrder) -> bool {
    matches!(order, ChannelOrder::D | ChannelOrder::DS)
}

/// `tcu::hasStencilComponent`
pub fn has_stencil_component(order: ChannelOrder) -> bool {
    matches!(order, ChannelOrder::S | ChannelOrder::DS)
}

/// `tcu::getEffectiveDepthStencilTextureFormat`
///
/// Only the format half of upstream's `toSamplerAccess` - the pointer/pitch fixup it
/// also does is unnecessary here, because `get_pix_depth`/`get_pix_stencil` already
/// decode the combined types in place. What is needed is the format the *threshold*
/// is computed from: a combined type has no channel class of its own (it reports
/// `Last`), so comparing against it would fall off the end of the switch.
pub fn get_effective_depth_stencil_texture_format(base: TextureFormat, mode: DepthStencilMode) -> TextureFormat {
    if base.order != ChannelOrder::DS && !matches!(base.type_, ChannelType::UNSIGNED_INT_24_8_REV) {
        return base;
    }
    match (base.type_, mode) {
        (ChannelType::UNSIGNED_INT_16_8_8, DepthStencilMode::Depth) => TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16),
        (ChannelType::UNSIGNED_INT_24_8, DepthStencilMode::Depth) | (ChannelType::UNSIGNED_INT_24_8_REV, DepthStencilMode::Depth) => {
            TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT24)
        }
        (ChannelType::FLOAT_UNSIGNED_INT_24_8_REV, DepthStencilMode::Depth) => TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT),
        (_, DepthStencilMode::Stencil) => TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8),
        _ => base,
    }
}

/// `tcu::Sampler::DepthStencilMode`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DepthStencilMode {
    Depth,
    Stencil,
}

fn rd_u8(p: &[u8]) -> u8 {
    p[0]
}
fn rd_i8(p: &[u8]) -> i8 {
    p[0] as i8
}
fn rd_u16(p: &[u8]) -> u16 {
    u16::from_ne_bytes([p[0], p[1]])
}
fn rd_i16(p: &[u8]) -> i16 {
    rd_u16(p) as i16
}
fn rd_u32(p: &[u8]) -> u32 {
    u32::from_ne_bytes([p[0], p[1], p[2], p[3]])
}
fn rd_i32(p: &[u8]) -> i32 {
    rd_u32(p) as i32
}
fn rd_u64(p: &[u8]) -> u64 {
    u64::from_ne_bytes([p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]])
}
fn rd_i64(p: &[u8]) -> i64 {
    rd_u64(p) as i64
}
fn rd_f32(p: &[u8]) -> f32 {
    f32::from_bits(rd_u32(p))
}
fn rd_f16(p: &[u8]) -> f32 {
    float_bits_to_f32(rd_u16(p) as u32, 5, 10, 15, true)
}

/// `tcu::readUint24`
fn read_uint24(p: &[u8]) -> u32 {
    (p[0] as u32) | ((p[1] as u32) << 8) | ((p[2] as u32) << 16)
}

/// `tcu::signExtend`
fn sign_extend(src: u32, bits: i32) -> i32 {
    let shift = 32 - bits;
    ((src << shift) as i32) >> shift
}

/// `tcu::channelToUnormFloat`
fn channel_to_unorm_float(src: u32, bits: i32) -> f32 {
    let max_val = (1u32 << bits) - 1;
    src as f32 / max_val as f32
}

/// `tcu::channelToSnormFloat`
fn channel_to_snorm_float(src: u32, bits: i32) -> f32 {
    let range = (1u32 << (bits - 1)) - 1;
    (sign_extend(src, bits) as f32 / range as f32).max(-1.0)
}

/// The IEEE-style unpack behind `tcu::Float<...>::asFloat()`, for the small
/// unsigned floats (`Float11`, `Float10`) and `deFloat16To32`.
///
/// Upstream reaches this through a generic `Float<>` conversion template; the direct
/// unpack is written out here instead because porting that template would add a lot
/// of code for three call sites and no behavioural difference.
fn float_bits_to_f32(bits: u32, exponent_bits: u32, mantissa_bits: u32, exponent_bias: i32, has_sign: bool) -> f32 {
    let mantissa_mask = (1u32 << mantissa_bits) - 1;
    let exponent_mask = (1u32 << exponent_bits) - 1;

    let mantissa = bits & mantissa_mask;
    let exponent = (bits >> mantissa_bits) & exponent_mask;
    let sign = if has_sign && ((bits >> (mantissa_bits + exponent_bits)) & 1) != 0 {
        -1.0f32
    } else {
        1.0f32
    };

    if exponent == 0 {
        // Zero or denormal.
        sign * (mantissa as f32) * 2.0f32.powi(1 - exponent_bias - mantissa_bits as i32)
    } else if exponent == exponent_mask {
        if mantissa == 0 { sign * f32::INFINITY } else { f32::NAN }
    } else {
        let m = 1.0f32 + (mantissa as f32) / ((1u32 << mantissa_bits) as f32);
        sign * m * 2.0f32.powi(exponent as i32 - exponent_bias)
    }
}

/// `tcu::unpackRGB999E5`
fn unpack_rgb999e5(color: u32) -> [f32; 4] {
    let m_bits = 9;
    let e_bias = 15;

    let exp = color >> 27;
    let bs = (color >> 18) & ((1 << 9) - 1);
    let gs = (color >> 9) & ((1 << 9) - 1);
    let rs = color & ((1 << 9) - 1);

    let e = 2.0f32.powi(exp as i32 - e_bias - m_bits);
    [rs as f32 * e, gs as f32 * e, bs as f32 * e, 1.0]
}

/// `tcu::swizzleGe` - swizzle generally based on channel order.
fn swizzle_ge<T: Copy>(v: [T; 4], src: ChannelOrder, dst: ChannelOrder) -> [T; 4] {
    use ChannelOrder::*;
    if src == dst {
        return v;
    }
    let s = |a: usize, b: usize, c: usize, d: usize| [v[a], v[b], v[c], v[d]];

    if (src == RGBA && dst == ARGB) || (src == BGRA && dst == ABGR) {
        return s(3, 0, 1, 2);
    }
    if (src == ARGB && dst == RGBA) || (src == ABGR && dst == BGRA) {
        return s(1, 2, 3, 0);
    }
    if (src == BGRA && dst == ARGB) || (src == ABGR && dst == RGBA) || (src == RGBA && dst == ABGR) || (src == ARGB && dst == BGRA) {
        return s(3, 2, 1, 0);
    }
    if (src == RGB && dst == BGR) || (src == BGR && dst == RGB) || (src == RGBA && dst == BGRA) || (src == BGRA && dst == RGBA) {
        return s(2, 1, 0, 3);
    }
    v
}

/// `tcu::channelToFloat`
fn channel_to_float(value: &[u8], type_: ChannelType) -> f32 {
    use ChannelType::*;
    match type_ {
        SNORM_INT8 => (rd_i8(value) as f32 / 127.0).max(-1.0),
        SNORM_INT16 => (rd_i16(value) as f32 / 32767.0).max(-1.0),
        UNORM_INT8 => rd_u8(value) as f32 / 255.0,
        UNORM_INT16 => rd_u16(value) as f32 / 65535.0,
        UNORM_INT24 => read_uint24(value) as f32 / 16_777_215.0,
        SIGNED_INT8 => rd_i8(value) as f32,
        SIGNED_INT16 => rd_i16(value) as f32,
        SIGNED_INT32 => rd_i32(value) as f32,
        SIGNED_INT64 => rd_i64(value) as f32,
        UNSIGNED_INT8 => rd_u8(value) as f32,
        UNSIGNED_INT16 => rd_u16(value) as f32,
        UNSIGNED_INT32 => rd_u32(value) as f32,
        UNSIGNED_INT64 => rd_u64(value) as f32,
        HALF_FLOAT => rd_f16(value),
        FLOAT => rd_f32(value),
        USCALED_INT8 => rd_u8(value) as f32,
        USCALED_INT16 => rd_u16(value) as f32,
        SSCALED_INT8 => rd_i8(value) as f32,
        SSCALED_INT16 => rd_i16(value) as f32,
        _ => 0.0,
    }
}

/// `tcu::channelToIntType<int64_t>`
fn channel_to_int64(value: &[u8], type_: ChannelType) -> i64 {
    use ChannelType::*;
    match type_ {
        SNORM_INT8 | SIGNED_INT8 | SSCALED_INT8 => rd_i8(value) as i64,
        SNORM_INT16 | SIGNED_INT16 | SSCALED_INT16 => rd_i16(value) as i64,
        UNORM_INT8 | UNSIGNED_INT8 | USCALED_INT8 => rd_u8(value) as i64,
        UNORM_INT16 | UNSIGNED_INT16 | USCALED_INT16 => rd_u16(value) as i64,
        UNORM_INT24 => read_uint24(value) as i64,
        SIGNED_INT32 => rd_i32(value) as i64,
        SIGNED_INT64 => rd_i64(value),
        UNSIGNED_INT32 => rd_u32(value) as i64,
        UNSIGNED_INT64 => rd_u64(value) as i64,
        HALF_FLOAT => rd_f16(value) as i64,
        FLOAT => rd_f32(value) as i64,
        UNSIGNED_INT_11F_11F_10F_REV
        | UNORM_INT_1010102_REV
        | SNORM_INT_1010102_REV
        | USCALED_INT_1010102_REV
        | SSCALED_INT_1010102_REV
        | UNSIGNED_INT_1010102_REV
        | SIGNED_INT_1010102_REV
        | UNSIGNED_INT_999_E5_REV => rd_u32(value) as i64,
        _ => 0,
    }
}

/// `tcu::ConstPixelBufferAccess`, narrowed to the tightly-packed, non-YCbCr case that
/// `readImage` produces (so the pitch is derived rather than carried).
pub struct ConstPixelBufferAccess<'a> {
    format: TextureFormat,
    size: [u32; 3],
    data: &'a [u8],
}

impl<'a> ConstPixelBufferAccess<'a> {
    /// Wraps tightly-packed texel data of `size` in `format`.
    pub fn new(format: TextureFormat, size: [u32; 3], data: &'a [u8]) -> Self {
        Self { format, size, data }
    }

    /// `getFormat`
    pub fn format(&self) -> TextureFormat {
        self.format
    }
}

impl ConstPixelBufferAccess<'_> {
    pub fn get_format(&self) -> TextureFormat {
        self.format
    }

    /// `ConstPixelBufferAccess::getPixelPtr`
    pub fn pixel(&self, x: u32, y: u32, z: u32) -> &[u8] {
        let pixel_size = pixel_size_of(self.format);
        let row_pitch = pixel_size * self.size[0] as usize;
        let slice_pitch = row_pitch * self.size[1] as usize;
        let offset = x as usize * pixel_size + y as usize * row_pitch + z as usize * slice_pitch;
        &self.data[offset..]
    }

    /// `ConstPixelBufferAccess::getPixel`
    pub fn get_pixel(&self, x: u32, y: u32, z: u32) -> [f32; 4] {
        use ChannelType::*;
        let p = self.pixel(x, y, z);

        let ui8 = |offs: i32, count: i32| (rd_u8(p) as u32 >> offs) & ((1u32 << count) - 1);
        let ui16 = |offs: i32, count: i32| (rd_u16(p) as u32 >> offs) & ((1u32 << count) - 1);
        let ui32 = |offs: i32, count: i32| (rd_u32(p) >> offs) & ((1u32 << count) - 1);
        let si32 = |offs: i32, count: i32| sign_extend(ui32(offs, count), count);
        let un8 = |offs: i32, count: i32| channel_to_unorm_float(ui8(offs, count), count);
        let un16 = |offs: i32, count: i32| channel_to_unorm_float(ui16(offs, count), count);
        let un32 = |offs: i32, count: i32| channel_to_unorm_float(ui32(offs, count), count);
        let sn32 = |offs: i32, count: i32| channel_to_snorm_float(ui32(offs, count), count);

        let order = self.format.order;
        match self.format.type_ {
            UNORM_BYTE_44 => return [un8(4, 4), un8(0, 4), 0.0, 1.0],
            UNORM_SHORT_565 => return swizzle_ge([un16(11, 5), un16(5, 6), un16(0, 5), 1.0], order, ChannelOrder::RGB),
            UNORM_SHORT_4444 => return swizzle_ge([un16(12, 4), un16(8, 4), un16(4, 4), un16(0, 4)], order, ChannelOrder::RGBA),
            UNORM_SHORT_5551 => return swizzle_ge([un16(11, 5), un16(6, 5), un16(1, 5), un16(0, 1)], order, ChannelOrder::RGBA),
            UNORM_SHORT_1555 => return swizzle_ge([un16(15, 1), un16(10, 5), un16(5, 5), un16(0, 5)], order, ChannelOrder::RGBA),
            UNORM_INT_1010102_REV => return swizzle_ge([un32(0, 10), un32(10, 10), un32(20, 10), un32(30, 2)], order, ChannelOrder::RGBA),
            SNORM_INT_1010102_REV => return swizzle_ge([sn32(0, 10), sn32(10, 10), sn32(20, 10), sn32(30, 2)], order, ChannelOrder::RGBA),
            USCALED_INT_1010102_REV | UNSIGNED_INT_1010102_REV => {
                let v = swizzle_ge([ui32(0, 10), ui32(10, 10), ui32(20, 10), ui32(30, 2)], order, ChannelOrder::RGBA);
                return [v[0] as f32, v[1] as f32, v[2] as f32, v[3] as f32];
            }
            SSCALED_INT_1010102_REV => {
                // Upstream puts the sign-extended values into a UVec4 before casting to
                // float; the wrap is kept so the value matches deqp bit for bit.
                let v = swizzle_ge(
                    [si32(0, 10) as u32, si32(10, 10) as u32, si32(20, 10) as u32, si32(30, 2) as u32],
                    order,
                    ChannelOrder::RGBA,
                );
                return [v[0] as f32, v[1] as f32, v[2] as f32, v[3] as f32];
            }
            SIGNED_INT_1010102_REV => {
                let v = swizzle_ge([si32(0, 10), si32(10, 10), si32(20, 10), si32(30, 2)], order, ChannelOrder::RGBA);
                return [v[0] as f32, v[1] as f32, v[2] as f32, v[3] as f32];
            }
            UNSIGNED_INT_999_E5_REV => return unpack_rgb999e5(rd_u32(p)),
            UNSIGNED_INT_11F_11F_10F_REV => {
                return [
                    float_bits_to_f32(ui32(0, 11), 5, 6, 15, false),
                    float_bits_to_f32(ui32(11, 11), 5, 6, 15, false),
                    float_bits_to_f32(ui32(22, 10), 5, 5, 15, false),
                    1.0,
                ];
            }
            _ => {}
        }

        // Generic path.
        let channel_map = get_channel_read_swizzle(order);
        let channel_size = channel_size_of(self.format.type_);
        let mut result = [0.0f32; 4];
        for c in 0..4 {
            result[c] = match channel_map[c] {
                Swz::ZERO => 0.0,
                Swz::ONE => 1.0,
                ch => channel_to_float(&p[channel_size * ch.index().unwrap()..], self.format.type_),
            };
        }
        result
    }

    /// `ConstPixelBufferAccess::getPixelInt64`
    pub fn get_pixel_int64(&self, x: u32, y: u32, z: u32) -> [i64; 4] {
        use ChannelType::*;
        let p = self.pixel(x, y, z);

        let u8v = |offs: i32, count: i32| ((rd_u8(p) as u32 >> offs) & ((1u32 << count) - 1)) as i64;
        let u16v = |offs: i32, count: i32| ((rd_u16(p) as u32 >> offs) & ((1u32 << count) - 1)) as i64;
        let u32v = |offs: i32, count: i32| ((rd_u32(p) >> offs) & ((1u32 << count) - 1)) as i64;
        let s32v = |offs: i32, count: i32| sign_extend((rd_u32(p) >> offs) & ((1u32 << count) - 1), count) as i64;

        let order = self.format.order;
        match self.format.type_ {
            UNORM_BYTE_44 => return [u8v(4, 4), u8v(0, 4), 0, 1],
            UNORM_SHORT_565 => return swizzle_ge([u16v(11, 5), u16v(5, 6), u16v(0, 5), 1], order, ChannelOrder::RGB),
            UNORM_SHORT_4444 => return swizzle_ge([u16v(12, 4), u16v(8, 4), u16v(4, 4), u16v(0, 4)], order, ChannelOrder::RGBA),
            UNORM_SHORT_5551 => return swizzle_ge([u16v(11, 5), u16v(6, 5), u16v(1, 5), u16v(0, 1)], order, ChannelOrder::RGBA),
            UNORM_SHORT_1555 => return swizzle_ge([u16v(15, 1), u16v(10, 5), u16v(5, 5), u16v(0, 5)], order, ChannelOrder::RGBA),
            UNORM_INT_1010102_REV | USCALED_INT_1010102_REV | UNSIGNED_INT_1010102_REV => {
                return swizzle_ge([u32v(0, 10), u32v(10, 10), u32v(20, 10), u32v(30, 2)], order, ChannelOrder::RGBA);
            }
            UNSIGNED_INT_11F_11F_10F_REV => return swizzle_ge([u32v(0, 11), u32v(11, 11), u32v(22, 10), 1], order, ChannelOrder::RGB),
            SNORM_INT_1010102_REV | SSCALED_INT_1010102_REV | SIGNED_INT_1010102_REV => {
                return swizzle_ge([s32v(0, 10), s32v(10, 10), s32v(20, 10), s32v(30, 2)], order, ChannelOrder::RGBA);
            }
            _ => {}
        }

        // Generic path.
        let channel_map = get_channel_read_swizzle(order);
        let channel_size = channel_size_of(self.format.type_);
        let mut result = [0i64; 4];
        for c in 0..4 {
            result[c] = match channel_map[c] {
                Swz::ZERO => 0,
                Swz::ONE => 1,
                ch => channel_to_int64(&p[channel_size * ch.index().unwrap()..], self.format.type_),
            };
        }
        result
    }

    /// `ConstPixelBufferAccess::getPixelUint64`
    pub fn get_pixel_uint64(&self, x: u32, y: u32, z: u32) -> [u64; 4] {
        let v = self.get_pixel_int64(x, y, z);
        [v[0] as u64, v[1] as u64, v[2] as u64, v[3] as u64]
    }

    /// `ConstPixelBufferAccess::getPixDepth`
    pub fn get_pix_depth(&self, x: u32, y: u32, z: u32) -> f32 {
        use ChannelType::*;
        let p = self.pixel(x, y, z);
        match self.format.type_ {
            UNSIGNED_INT_16_8_8 => rd_u16(&p[2..]) as f32 / 65535.0,
            UNSIGNED_INT_24_8_REV => read_uint24(p) as f32 / 16_777_215.0,
            FLOAT_UNSIGNED_INT_24_8_REV => rd_f32(p),
            other => channel_to_float(p, other),
        }
    }

    /// `ConstPixelBufferAccess::getPixStencil`
    pub fn get_pix_stencil(&self, x: u32, y: u32, z: u32) -> u32 {
        use ChannelType::*;
        let p = self.pixel(x, y, z);
        match self.format.type_ {
            UNSIGNED_INT_24_8_REV => p[3] as u32,
            UNSIGNED_INT_16_8_8 => p[0] as u32,
            FLOAT_UNSIGNED_INT_24_8_REV => p[4] as u32,
            other => channel_to_int64(p, other) as u32,
        }
    }
}

/// `tcu::TextureLevelPyramid`, reduced to what `readImage` fills in and
/// `verifyResultImage` reads back.
struct TextureLevelPyramid {
    format: TextureFormat,
    levels: Vec<([u32; 3], Vec<u8>)>,
}

impl TextureLevelPyramid {
    fn new(format: TextureFormat, num_levels: usize) -> Self {
        Self {
            format,
            levels: vec![([0, 0, 0], Vec::new()); num_levels],
        }
    }

    /// `TextureLevelPyramid::allocLevel`
    fn alloc_level(&mut self, level: usize, width: u32, height: u32, depth: u32) {
        let size = pixel_size_of(self.format) * (width * height * depth) as usize;
        self.levels[level] = ([width, height, depth], vec![0u8; size]);
    }

    fn get_level(&self, level: usize) -> ConstPixelBufferAccess<'_> {
        ConstPixelBufferAccess {
            format: self.format,
            size: self.levels[level].0,
            data: &self.levels[level].1,
        }
    }
}

// __PART2__

/// Thin adapters onto the generated tables in `super::texture`, so this module never
/// carries a second copy of them.
fn num_used_channels_of(order: ChannelOrder) -> usize {
    order.num_used_channels() as usize
}

fn channel_size_of(type_: ChannelType) -> usize {
    type_.channel_size().unwrap_or(0) as usize
}

fn pixel_size_of(format: TextureFormat) -> usize {
    format.pixel_size().unwrap_or(0) as usize
}

fn channel_class_of(type_: ChannelType) -> TextureChannelClass {
    type_.channel_class()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn access(format: TextureFormat, data: &[u8]) -> ConstPixelBufferAccess<'_> {
        ConstPixelBufferAccess { format, size: [1, 1, 1], data }
    }

    /// Decoding a stored texel is the step where a mistake looks exactly like a driver
    /// bug, so these check the paths the image groups actually take: normalised,
    /// integer, float, packed and depth/stencil.
    #[test]
    fn decodes_unorm8_rgba() {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let px = access(fmt, &[0, 51, 204, 255]).get_pixel(0, 0, 0);
        assert!((px[0] - 0.0).abs() < 1e-6, "px={px:?}");
        assert!((px[1] - 0.2).abs() < 1e-2, "px={px:?}");
        assert!((px[2] - 0.8).abs() < 1e-2);
        assert!((px[3] - 1.0).abs() < 1e-6);
    }

    #[test]
    fn decodes_bgra_in_channel_order() {
        // The swizzle is the whole point: the bytes are B,G,R,A but the pixel is RGBA.
        let fmt = TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNORM_INT8);
        let px = access(fmt, &[255, 0, 0, 255]).get_pixel(0, 0, 0);
        assert!(px[2] > 0.99, "blue byte must land in the blue channel, got {px:?}");
        assert!(px[0] < 0.01, "red must be zero, got {px:?}");
    }

    #[test]
    fn decodes_signed_and_unsigned_integers() {
        let s32 = TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT32);
        assert_eq!(access(s32, &(-42i32).to_ne_bytes()).get_pixel_int64(0, 0, 0)[0], -42);

        let u32f = TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT32);
        assert_eq!(access(u32f, &4_000_000_000u32.to_ne_bytes()).get_pixel_uint64(0, 0, 0)[0], 4_000_000_000);
    }

    #[test]
    fn decodes_float32() {
        let fmt = TextureFormat::new(ChannelOrder::R, ChannelType::FLOAT);
        let px = access(fmt, &1.5f32.to_ne_bytes()).get_pixel(0, 0, 0);
        assert!((px[0] - 1.5).abs() < 1e-6);
    }

    #[test]
    fn decodes_packed_565() {
        // R5G6B5: all-ones must read back as white in the three used channels.
        let fmt = TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_SHORT_565);
        let px = access(fmt, &0xFFFFu16.to_ne_bytes()).get_pixel(0, 0, 0);
        for (c, &value) in px.iter().take(3).enumerate() {
            assert!((value - 1.0).abs() < 1e-6, "channel {c} of white 565 was {value}");
        }
    }

    #[test]
    fn decodes_depth_and_stencil_separately() {
        let fmt = TextureFormat::new(ChannelOrder::DS, ChannelType::UNSIGNED_INT_24_8_REV);
        // depth = 0xFFFFFF (1.0), stencil = 0x7F
        let word: u32 = 0x7F00_0000 | 0x00FF_FFFF;
        let bytes = word.to_ne_bytes();
        let a = access(fmt, &bytes);
        assert!((a.get_pix_depth(0, 0, 0) - 1.0).abs() < 1e-6);
        assert_eq!(a.get_pix_stencil(0, 0, 0), 0x7F);
    }

    #[test]
    fn bit_depth_table_is_complete_and_matches_upstream() {
        assert_eq!(get_channel_bit_depth(ChannelType::UNORM_INT8), [8, 8, 8, 8]);
        assert_eq!(get_channel_bit_depth(ChannelType::UNORM_SHORT_565), [5, 6, 5, 0]);
        assert_eq!(get_channel_bit_depth(ChannelType::UNORM_INT_1010102_REV), [10, 10, 10, 2]);
        assert_eq!(get_channel_bit_depth(ChannelType::SIGNED_INT64), [64, 64, 64, 64]);
    }
}

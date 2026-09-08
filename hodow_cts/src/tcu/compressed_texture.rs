// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuCompressedTexture.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The BC1-BC5 and ETC2/EAC decoders, which a blit out of a compressed image needs: the reference
// has to be built from the same texels the driver samples, and there is no way to get
// those without decoding the blocks on the host. Everything here is exact integer or
// exactly-representable float arithmetic straight out of the spec, so the reference
// matches the driver bit for bit rather than within a tolerance.
//
// tcu keys these off its own `CompressedTexFormat`; this keys them off `vk::Format`,
// which saves keeping a second enum in step with the registry for no gain - the port
// only ever arrives here from a VkFormat.

use vulkanalia::vk;

use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess, TextureLevel};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::vk::compressed_formats::{is_astc_format, is_astc_srgb_format};

/// `BC_BLOCK_WIDTH` / `BC_BLOCK_HEIGHT`
const BC_BLOCK_WIDTH: usize = 4;
const BC_BLOCK_HEIGHT: usize = 4;

/// `tcu::getUncompressedFormat`, for the BC formats.
pub fn get_uncompressed_format(format: vk::Format) -> Option<TextureFormat> {
    use ChannelOrder::*;
    use ChannelType::*;
    Some(match format {
        vk::Format::EAC_R11_UNORM_BLOCK => TextureFormat::new(R, UNORM_INT16),
        vk::Format::EAC_R11_SNORM_BLOCK => TextureFormat::new(R, SNORM_INT16),
        vk::Format::EAC_R11G11_UNORM_BLOCK => TextureFormat::new(RG, UNORM_INT16),
        vk::Format::EAC_R11G11_SNORM_BLOCK => TextureFormat::new(RG, SNORM_INT16),
        vk::Format::ETC2_R8G8B8_UNORM_BLOCK => TextureFormat::new(RGB, UNORM_INT8),
        vk::Format::ETC2_R8G8B8_SRGB_BLOCK => TextureFormat::new(sRGB, UNORM_INT8),
        vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK | vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK => TextureFormat::new(RGBA, UNORM_INT8),
        vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK | vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK => TextureFormat::new(sRGBA, UNORM_INT8),
        _ if is_astc_format(format) => {
            if is_astc_srgb_format(format) {
                TextureFormat::new(sRGBA, UNORM_INT8)
            } else {
                TextureFormat::new(RGBA, HALF_FLOAT)
            }
        }
        vk::Format::BC6H_UFLOAT_BLOCK | vk::Format::BC6H_SFLOAT_BLOCK => TextureFormat::new(RGB, HALF_FLOAT),
        vk::Format::BC7_SRGB_BLOCK => TextureFormat::new(sRGBA, UNORM_INT8),
        vk::Format::BC7_UNORM_BLOCK => TextureFormat::new(RGBA, UNORM_INT8),
        vk::Format::BC4_UNORM_BLOCK | vk::Format::BC4_SNORM_BLOCK => TextureFormat::new(R, FLOAT),
        vk::Format::BC5_UNORM_BLOCK | vk::Format::BC5_SNORM_BLOCK => TextureFormat::new(RG, FLOAT),
        vk::Format::BC1_RGB_SRGB_BLOCK | vk::Format::BC1_RGBA_SRGB_BLOCK | vk::Format::BC2_SRGB_BLOCK | vk::Format::BC3_SRGB_BLOCK => TextureFormat::new(sRGBA, UNORM_INT8),
        vk::Format::BC1_RGB_UNORM_BLOCK | vk::Format::BC1_RGBA_UNORM_BLOCK | vk::Format::BC2_UNORM_BLOCK | vk::Format::BC3_UNORM_BLOCK => TextureFormat::new(RGBA, UNORM_INT8),
        _ => return None,
    })
}

/// Whether `decompress` knows this format.
pub fn is_decompressible(format: vk::Format) -> bool {
    get_uncompressed_format(format).is_some()
}

/// `extend4To8` / `extend5To8` / `extend6To8`
fn extend4_to_8(src: u8) -> u8 {
    (src << 4) | src
}

fn extend5_to_8(src: u8) -> u8 {
    (src << 3) | (src >> 2)
}

fn extend6_to_8(src: u8) -> u8 {
    (src << 2) | (src >> 4)
}

fn uint8_to_float(src: u8) -> f32 {
    f32::from(src) / 255.0
}

fn int8_to_float(src: i8) -> f32 {
    f32::from(src) / 128.0
}

/// `bgr16torgba32` - the 5:6:5 endpoint, expanded to 8 bits per channel and packed
/// r | g<<8 | b<<16 | a<<24.
fn bgr16_to_rgba32(src: u16) -> u32 {
    let b5 = (src & 0x1f) as u8;
    let g6 = ((src >> 5) & 0x3f) as u8;
    let r5 = ((src >> 11) & 0x1f) as u8;
    u32::from(extend5_to_8(r5)) | (u32::from(extend6_to_8(g6)) << 8) | (u32::from(extend5_to_8(b5)) << 16) | (0xffu32 << 24)
}

/// `interpolateColor` - two thirds of `c1` plus one third of `c0`.
fn interpolate_color(c0: u32, c1: u32) -> u32 {
    let mut out = 0u32;
    for shift in [0, 8, 16, 24] {
        let a = (c0 >> shift) & 0xff;
        let b = (c1 >> shift) & 0xff;
        out |= ((a + (b << 1)) / 3) << shift;
    }
    out
}

/// `averageColor`
fn average_color(c0: u32, c1: u32) -> u32 {
    let mut out = 0u32;
    for shift in [0, 8, 16, 24] {
        let a = (c0 >> shift) & 0xff;
        let b = (c1 >> shift) & 0xff;
        out |= ((a + b) >> 1) << shift;
    }
    out
}

/// `get64BitBlockLE`
fn get_64bit_block_le(src: &[u8], block_ndx: usize) -> u64 {
    let mut block = 0u64;
    for i in 0..8 {
        block |= u64::from(src[block_ndx * 8 + i]) << (8 * i);
    }
    block
}

fn read_u16_le(src: &[u8], index: usize) -> u16 {
    u16::from(src[index * 2]) | (u16::from(src[index * 2 + 1]) << 8)
}

/// The 4x4 colour indices BC1/BC2/BC3 pack two bits at a time.
fn two_bit_indices(indices8: &[u8]) -> [usize; 16] {
    std::array::from_fn(|i| ((indices8[i / 4] >> (2 * (i % 4))) & 0x3) as usize)
}

/// The 4x4 three-bit indices BC3's alpha and BC4/BC5 use.
fn three_bit_indices(index_bits: u64) -> [usize; 16] {
    std::array::from_fn(|i| ((index_bits >> (3 * i)) & 0x7) as usize)
}

/// A 4x4 block of decoded texels, laid out exactly as the destination access expects.
struct BlockOut<'a> {
    data: &'a mut [u8],
    row_pitch: usize,
    pixel_size: usize,
}

impl BlockOut<'_> {
    fn write_bytes(&mut self, x: usize, y: usize, bytes: &[u8]) {
        let at = y * self.row_pitch + x * self.pixel_size;
        self.data[at..at + bytes.len()].copy_from_slice(bytes);
    }

    fn write_u32(&mut self, x: usize, y: usize, value: u32) {
        let at = y * self.row_pitch + x * self.pixel_size;
        self.data[at..at + 4].copy_from_slice(&value.to_ne_bytes());
    }

    fn write_f32(&mut self, x: usize, y: usize, component: usize, value: f32) {
        let at = y * self.row_pitch + x * self.pixel_size + component * 4;
        self.data[at..at + 4].copy_from_slice(&value.to_ne_bytes());
    }
}

/// `decompressBc1`
fn decompress_bc1(dst: &mut BlockOut<'_>, src: &[u8], has_alpha: bool) {
    let color0_16 = read_u16_le(src, 0);
    let color1_16 = read_u16_le(src, 1);
    let color0 = bgr16_to_rgba32(color0_16);
    let color1 = bgr16_to_rgba32(color1_16);
    let indices = two_bit_indices(&src[4..8]);

    // The one-bit alpha mode is selected by the endpoint order, not by a flag.
    let alpha_mode = color1_16 > color0_16;
    let colors = [
        color0,
        color1,
        if alpha_mode { average_color(color0, color1) } else { interpolate_color(color1, color0) },
        if alpha_mode {
            if has_alpha { 0 } else { 0xff00_0000 }
        } else {
            interpolate_color(color0, color1)
        },
    ];

    for y in 0..BC_BLOCK_HEIGHT {
        for x in 0..BC_BLOCK_WIDTH {
            dst.write_u32(x, y, colors[indices[y * BC_BLOCK_WIDTH + x]]);
        }
    }
}

/// `decompressBc2`
fn decompress_bc2(dst: &mut BlockOut<'_>, src: &[u8]) {
    let color0 = bgr16_to_rgba32(read_u16_le(src, 4));
    let color1 = bgr16_to_rgba32(read_u16_le(src, 5));
    let indices = two_bit_indices(&src[12..16]);
    let alphas: [u32; 16] = std::array::from_fn(|i| u32::from(extend4_to_8((src[i / 2] >> (4 * (i % 2))) & 0xf)) << 24);
    let colors = [color0, color1, interpolate_color(color1, color0), interpolate_color(color0, color1)];

    for y in 0..BC_BLOCK_HEIGHT {
        for x in 0..BC_BLOCK_WIDTH {
            let i = y * BC_BLOCK_WIDTH + x;
            dst.write_u32(x, y, (colors[indices[i]] & 0x00ff_ffff) | alphas[i]);
        }
    }
}

/// `decompressBc3`
fn decompress_bc3(dst: &mut BlockOut<'_>, src: &[u8]) {
    let alpha0 = u32::from(src[0]);
    let alpha1 = u32::from(src[1]);
    let color0 = bgr16_to_rgba32(read_u16_le(src, 4));
    let color1 = bgr16_to_rgba32(read_u16_le(src, 5));
    let indices = two_bit_indices(&src[12..16]);
    let alpha_indices = three_bit_indices(get_64bit_block_le(src, 0) >> 16);
    let colors = [color0, color1, interpolate_color(color1, color0), interpolate_color(color0, color1)];

    let mut alphas = [0u32; 8];
    alphas[0] = alpha0 << 24;
    alphas[1] = alpha1 << 24;
    if alpha0 > alpha1 {
        for i in 0..6u32 {
            alphas[(i + 2) as usize] = ((alpha0 * (6 - i) + alpha1 * (1 + i)) / 7) << 24;
        }
    } else {
        for i in 0..4u32 {
            alphas[(i + 2) as usize] = ((alpha0 * (4 - i) + alpha1 * (1 + i)) / 5) << 24;
        }
        alphas[6] = 0;
        alphas[7] = 0xff00_0000;
    }

    for y in 0..BC_BLOCK_HEIGHT {
        for x in 0..BC_BLOCK_WIDTH {
            let i = y * BC_BLOCK_WIDTH + x;
            dst.write_u32(x, y, (colors[indices[i]] & 0x00ff_ffff) | alphas[alpha_indices[i]]);
        }
    }
}

/// The eight interpolated values a BC4-style channel takes, from its two endpoints.
fn bc4_channel_values(src: &[u8], offset: usize, has_sign: bool) -> [f32; 8] {
    let mut values = [0.0f32; 8];
    values[0] = if has_sign { int8_to_float(src[offset] as i8) } else { uint8_to_float(src[offset]) };
    values[1] = if has_sign {
        int8_to_float(src[offset + 1] as i8)
    } else {
        uint8_to_float(src[offset + 1])
    };

    if values[0] > values[1] {
        for i in 0..6 {
            values[i + 2] = (values[0] * (6.0 - i as f32) + values[1] * (1.0 + i as f32)) / 7.0;
        }
    } else {
        for i in 0..4 {
            values[i + 2] = (values[0] * (4.0 - i as f32) + values[1] * (1.0 + i as f32)) / 5.0;
        }
        values[6] = if has_sign { -1.0 } else { 0.0 };
        values[7] = 1.0;
    }
    values
}

/// `decompressBc4`
fn decompress_bc4(dst: &mut BlockOut<'_>, src: &[u8], has_sign: bool) {
    let reds = bc4_channel_values(src, 0, has_sign);
    let indices = three_bit_indices(get_64bit_block_le(src, 0) >> 16);
    for y in 0..BC_BLOCK_HEIGHT {
        for x in 0..BC_BLOCK_WIDTH {
            dst.write_f32(x, y, 0, reds[indices[y * BC_BLOCK_WIDTH + x]]);
        }
    }
}

/// `decompressBc5`
fn decompress_bc5(dst: &mut BlockOut<'_>, src: &[u8], has_sign: bool) {
    for c in 0..2 {
        let values = bc4_channel_values(src, c * 8, has_sign);
        let indices = three_bit_indices(get_64bit_block_le(src, c) >> 16);
        for y in 0..BC_BLOCK_HEIGHT {
            for x in 0..BC_BLOCK_WIDTH {
                dst.write_f32(x, y, c, values[indices[y * BC_BLOCK_WIDTH + x]]);
            }
        }
    }
}

// ---------------------------------------------------------------------------------
// ETC2 and EAC
// ---------------------------------------------------------------------------------

/// `get64BitBlock` - big-endian, unlike the BC blocks.
fn get_64bit_block(src: &[u8], block_ndx: usize) -> u64 {
    let mut block = 0u64;
    for i in 0..8 {
        block = (block << 8) | u64::from(src[block_ndx * 8 + i]);
    }
    block
}

fn get_bit(src: u64, bit: u32) -> u32 {
    ((src >> bit) & 1) as u32
}

fn get_bits(src: u64, low: u32, high: u32) -> u32 {
    let num_bits = high - low + 1;
    if num_bits < 32 {
        ((src >> low) & ((1u64 << num_bits) - 1)) as u32
    } else {
        ((src >> low) & 0xFFFF_FFFF) as u32
    }
}

fn extend7_to_8(src: u8) -> u8 {
    (src << 1) | (src >> 6)
}

fn extend_signed3_to_8(src: u8) -> i8 {
    let is_neg = (src & (1 << 2)) != 0;
    ((if is_neg { !((1u8 << 3) - 1) } else { 0 }) | src) as i8
}

fn extend11_to_16(src: u16) -> u16 {
    (src << 5) | (src >> 6)
}

fn extend11_to_16_with_sign(src: i16) -> i16 {
    if src < 0 {
        -(extend11_to_16(src.unsigned_abs()) as i16)
    } else {
        extend11_to_16(src as u16) as i16
    }
}

fn clamp_u8(value: i32) -> u8 {
    value.clamp(0, 255) as u8
}

/// `modifierTable` shared by the individual and differential ETC modes.
const ETC_MODIFIER_TABLE: [[i32; 4]; 8] = [
    [2, 8, -2, -8],
    [5, 17, -5, -17],
    [9, 29, -9, -29],
    [13, 42, -13, -42],
    [18, 60, -18, -60],
    [24, 80, -24, -80],
    [33, 106, -33, -106],
    [47, 183, -47, -183],
];

/// `modifierTable` shared by EAC's 8-bit and 11-bit blocks.
const EAC_MODIFIER_TABLE: [[i32; 8]; 16] = [
    [-3, -6, -9, -15, 2, 5, 8, 14],
    [-3, -7, -10, -13, 2, 6, 9, 12],
    [-2, -5, -8, -13, 1, 4, 7, 12],
    [-2, -4, -6, -13, 1, 3, 5, 12],
    [-3, -6, -8, -12, 2, 5, 7, 11],
    [-3, -7, -9, -11, 2, 6, 8, 10],
    [-4, -7, -8, -11, 3, 6, 7, 10],
    [-3, -5, -8, -11, 2, 4, 7, 10],
    [-2, -6, -8, -10, 1, 5, 7, 9],
    [-2, -5, -8, -10, 1, 4, 7, 9],
    [-2, -4, -8, -10, 1, 3, 7, 9],
    [-2, -5, -7, -10, 1, 4, 6, 9],
    [-3, -4, -7, -10, 2, 3, 6, 9],
    [-1, -2, -3, -10, 0, 1, 2, 9],
    [-4, -6, -8, -9, 3, 5, 7, 8],
    [-3, -5, -7, -9, 2, 4, 6, 8],
];

/// `decompressETC2Block` - the RGB half of every ETC2 format, writing a 4x4 block of
/// RGB triples and, in punchthrough mode, the alpha that goes with them.
fn decompress_etc2_block(rgb: &mut [u8; 48], src: u64, alpha: Option<&mut [u8; 16]>, alpha_mode: bool) {
    let diff_opaque_bit = get_bit(src, 33) as i32;
    let sel_br = get_bits(src, 59, 63) as i8;
    let sel_bg = get_bits(src, 51, 55) as i8;
    let sel_bb = get_bits(src, 43, 47) as i8;
    let sel_dr = extend_signed3_to_8(get_bits(src, 56, 58) as u8);
    let sel_dg = extend_signed3_to_8(get_bits(src, 48, 50) as u8);
    let sel_db = extend_signed3_to_8(get_bits(src, 40, 42) as u8);

    #[derive(PartialEq, Eq)]
    enum Etc2Mode {
        Individual,
        Differential,
        T,
        H,
        Planar,
    }
    let in_range = |v: i32| (0..=31).contains(&v);
    let mode = if !alpha_mode && diff_opaque_bit == 0 {
        Etc2Mode::Individual
    } else if !in_range(i32::from(sel_br) + i32::from(sel_dr)) {
        Etc2Mode::T
    } else if !in_range(i32::from(sel_bg) + i32::from(sel_dg)) {
        Etc2Mode::H
    } else if !in_range(i32::from(sel_bb) + i32::from(sel_db)) {
        Etc2Mode::Planar
    } else {
        Etc2Mode::Differential
    };

    let mut alpha = alpha;
    let mut set_alpha = |index: usize, value: u8| {
        if let Some(dst) = alpha.as_deref_mut() {
            dst[index] = value;
        }
    };

    match mode {
        Etc2Mode::Individual | Etc2Mode::Differential => {
            let flip_bit = get_bit(src, 32);
            let table = [get_bits(src, 37, 39), get_bits(src, 34, 36)];
            let (base_r, base_g, base_b) = if mode == Etc2Mode::Individual {
                (
                    [extend4_to_8(get_bits(src, 60, 63) as u8), extend4_to_8(get_bits(src, 56, 59) as u8)],
                    [extend4_to_8(get_bits(src, 52, 55) as u8), extend4_to_8(get_bits(src, 48, 51) as u8)],
                    [extend4_to_8(get_bits(src, 44, 47) as u8), extend4_to_8(get_bits(src, 40, 43) as u8)],
                )
            } else {
                (
                    [extend5_to_8(sel_br as u8), extend5_to_8(sel_br.wrapping_add(sel_dr) as u8)],
                    [extend5_to_8(sel_bg as u8), extend5_to_8(sel_bg.wrapping_add(sel_dg) as u8)],
                    [extend5_to_8(sel_bb as u8), extend5_to_8(sel_bb.wrapping_add(sel_db) as u8)],
                )
            };

            for pixel_ndx in 0..16u32 {
                let x = (pixel_ndx / 4) as usize;
                let y = (pixel_ndx % 4) as usize;
                let dst_offset = (y * BC_BLOCK_WIDTH + x) * 3;
                let sub_block = usize::from(if flip_bit != 0 { y } else { x } >= 2);
                let table_ndx = table[sub_block] as usize;
                let modifier_ndx = (get_bit(src, 16 + pixel_ndx) << 1) | get_bit(src, pixel_ndx);

                if alpha_mode && diff_opaque_bit == 0 && modifier_ndx == 2 {
                    rgb[dst_offset..dst_offset + 3].fill(0);
                    set_alpha(y * BC_BLOCK_WIDTH + x, 0);
                } else {
                    let modifier = if alpha_mode && diff_opaque_bit == 0 && (modifier_ndx == 0 || modifier_ndx == 2) {
                        0
                    } else {
                        ETC_MODIFIER_TABLE[table_ndx][modifier_ndx as usize]
                    };
                    rgb[dst_offset] = clamp_u8(i32::from(base_r[sub_block]) + modifier);
                    rgb[dst_offset + 1] = clamp_u8(i32::from(base_g[sub_block]) + modifier);
                    rgb[dst_offset + 2] = clamp_u8(i32::from(base_b[sub_block]) + modifier);
                    if alpha_mode {
                        set_alpha(y * BC_BLOCK_WIDTH + x, 255);
                    }
                }
            }
        }
        Etc2Mode::T | Etc2Mode::H => {
            const DIST_TABLE: [i32; 8] = [3, 6, 11, 16, 23, 32, 41, 64];
            let (paint_r, paint_g, paint_b) = if mode == Etc2Mode::T {
                let r1a = get_bits(src, 59, 60) as u8;
                let r1b = get_bits(src, 56, 57) as u8;
                let g1 = get_bits(src, 52, 55) as u8;
                let b1 = get_bits(src, 48, 51) as u8;
                let r2 = get_bits(src, 44, 47) as u8;
                let g2 = get_bits(src, 40, 43) as u8;
                let b2 = get_bits(src, 36, 39) as u8;
                let dist = DIST_TABLE[(((get_bits(src, 34, 35) << 1) | get_bit(src, 32)) & 0x7) as usize];
                let base = |c0: u8, c2: u8| {
                    [
                        extend4_to_8(c0),
                        clamp_u8(i32::from(extend4_to_8(c2)) + dist),
                        extend4_to_8(c2),
                        clamp_u8(i32::from(extend4_to_8(c2)) - dist),
                    ]
                };
                (base((r1a << 2) | r1b, r2), base(g1, g2), base(b1, b2))
            } else {
                let r1 = get_bits(src, 59, 62) as u8;
                let g1a = get_bits(src, 56, 58) as u8;
                let g1b = get_bit(src, 52) as u8;
                let b1a = get_bit(src, 51) as u8;
                let b1b = get_bits(src, 47, 49) as u8;
                let r2 = get_bits(src, 43, 46) as u8;
                let g2 = get_bits(src, 39, 42) as u8;
                let b2 = get_bits(src, 35, 38) as u8;
                let base_r = [extend4_to_8(r1), extend4_to_8(r2)];
                let base_g = [extend4_to_8((g1a << 1) | g1b), extend4_to_8(g2)];
                let base_b = [extend4_to_8((b1a << 3) | b1b), extend4_to_8(b2)];
                let base_value = |i: usize| (u32::from(base_r[i]) << 16) | (u32::from(base_g[i]) << 8) | u32::from(base_b[i]);
                let dist_ndx = (get_bit(src, 34) << 2) | (get_bit(src, 32) << 1) | u32::from(base_value(0) >= base_value(1));
                let dist = DIST_TABLE[dist_ndx as usize];
                let paint = |base: [u8; 2]| {
                    [
                        clamp_u8(i32::from(base[0]) + dist),
                        clamp_u8(i32::from(base[0]) - dist),
                        clamp_u8(i32::from(base[1]) + dist),
                        clamp_u8(i32::from(base[1]) - dist),
                    ]
                };
                (paint(base_r), paint(base_g), paint(base_b))
            };

            for pixel_ndx in 0..16u32 {
                let x = (pixel_ndx / 4) as usize;
                let y = (pixel_ndx % 4) as usize;
                let dst_offset = (y * BC_BLOCK_WIDTH + x) * 3;
                let paint_ndx = ((get_bit(src, 16 + pixel_ndx) << 1) | get_bit(src, pixel_ndx)) as usize;

                if alpha_mode && diff_opaque_bit == 0 && paint_ndx == 2 {
                    rgb[dst_offset..dst_offset + 3].fill(0);
                    set_alpha(y * BC_BLOCK_WIDTH + x, 0);
                } else {
                    rgb[dst_offset] = paint_r[paint_ndx];
                    rgb[dst_offset + 1] = paint_g[paint_ndx];
                    rgb[dst_offset + 2] = paint_b[paint_ndx];
                    if alpha_mode {
                        set_alpha(y * BC_BLOCK_WIDTH + x, 255);
                    }
                }
            }
        }
        Etc2Mode::Planar => {
            let go1 = get_bit(src, 56) as u8;
            let go2 = get_bits(src, 49, 54) as u8;
            let bo1 = get_bit(src, 48) as u8;
            let bo2 = get_bits(src, 43, 44) as u8;
            let bo3 = get_bits(src, 39, 41) as u8;
            let rh1 = get_bits(src, 34, 38) as u8;
            let rh2 = get_bit(src, 32) as u8;
            let origin = [
                extend6_to_8(get_bits(src, 57, 62) as u8),
                extend7_to_8((go1 << 6) | go2),
                extend6_to_8((bo1 << 5) | (bo2 << 3) | bo3),
            ];
            let horizontal = [
                extend6_to_8((rh1 << 1) | rh2),
                extend7_to_8(get_bits(src, 25, 31) as u8),
                extend6_to_8(get_bits(src, 19, 24) as u8),
            ];
            let vertical = [
                extend6_to_8(get_bits(src, 13, 18) as u8),
                extend7_to_8(get_bits(src, 6, 12) as u8),
                extend6_to_8(get_bits(src, 0, 5) as u8),
            ];

            for y in 0..BC_BLOCK_HEIGHT {
                for x in 0..BC_BLOCK_WIDTH {
                    let dst_offset = (y * BC_BLOCK_WIDTH + x) * 3;
                    for c in 0..3 {
                        let (o, h, v) = (i32::from(origin[c]), i32::from(horizontal[c]), i32::from(vertical[c]));
                        let unclamped = (x as i32 * (h - o) + y as i32 * (v - o) + 4 * o + 2) >> 2;
                        rgb[dst_offset + c] = clamp_u8(unclamped);
                    }
                    if alpha_mode {
                        set_alpha(y * BC_BLOCK_WIDTH + x, 255);
                    }
                }
            }
        }
    }
}

/// `decompressEAC8Block`
fn decompress_eac8_block(dst: &mut [u8; 16], src: u64) {
    let base_codeword = i32::from(get_bits(src, 56, 63) as u8);
    let multiplier = i32::from(get_bits(src, 52, 55) as u8);
    let table_ndx = get_bits(src, 48, 51) as usize;

    for pixel_ndx in 0..16u32 {
        let x = (pixel_ndx / 4) as usize;
        let y = (pixel_ndx % 4) as usize;
        let pixel_bit_ndx = 45 - 3 * pixel_ndx;
        let modifier_ndx = (get_bit(src, pixel_bit_ndx + 2) << 2) | (get_bit(src, pixel_bit_ndx + 1) << 1) | get_bit(src, pixel_bit_ndx);
        let modifier = EAC_MODIFIER_TABLE[table_ndx][modifier_ndx as usize];
        dst[y * BC_BLOCK_WIDTH + x] = clamp_u8(base_codeword + multiplier * modifier);
    }
}

/// `decompressEAC11Block` - 16 values in the 11-bit range, before the widening to 16.
fn decompress_eac11_block(dst: &mut [i32; 16], src: u64, signed_mode: bool) {
    let multiplier = get_bits(src, 52, 55) as i32;
    let table_ndx = get_bits(src, 48, 51) as usize;
    let mut base_codeword = get_bits(src, 56, 63) as i32;

    if signed_mode {
        if base_codeword > 127 {
            base_codeword -= 256;
        }
        if base_codeword == -128 {
            base_codeword = -127;
        }
    }

    for pixel_ndx in 0..16u32 {
        let x = (pixel_ndx / 4) as usize;
        let y = (pixel_ndx % 4) as usize;
        let pixel_bit_ndx = 45 - 3 * pixel_ndx;
        let modifier_ndx = (get_bit(src, pixel_bit_ndx + 2) << 2) | (get_bit(src, pixel_bit_ndx + 1) << 1) | get_bit(src, pixel_bit_ndx);
        let modifier = EAC_MODIFIER_TABLE[table_ndx][modifier_ndx as usize];

        let value = if signed_mode {
            let raw = if multiplier != 0 {
                base_codeword * 8 + multiplier * modifier * 8
            } else {
                base_codeword * 8 + modifier
            };
            raw.clamp(-1023, 1023)
        } else {
            let raw = if multiplier != 0 {
                base_codeword * 8 + 4 + multiplier * modifier * 8
            } else {
                base_codeword * 8 + 4 + modifier
            };
            raw.clamp(0, 2047)
        };
        dst[y * BC_BLOCK_WIDTH + x] = value;
    }
}

/// `decompressETC2` / `decompressETC2_EAC_RGBA8` / `decompressETC2_RGB8_PUNCHTHROUGH_ALPHA1`
fn decompress_etc2(dst: &mut BlockOut<'_>, src: &[u8], format: vk::Format) {
    let mut rgb = [0u8; 48];
    let mut alpha = [0u8; 16];

    match format {
        vk::Format::ETC2_R8G8B8_UNORM_BLOCK | vk::Format::ETC2_R8G8B8_SRGB_BLOCK => {
            decompress_etc2_block(&mut rgb, get_64bit_block(src, 0), None, false);
            for y in 0..BC_BLOCK_HEIGHT {
                for x in 0..BC_BLOCK_WIDTH {
                    let at = (y * BC_BLOCK_WIDTH + x) * 3;
                    dst.write_bytes(x, y, &rgb[at..at + 3]);
                }
            }
        }
        vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK | vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK => {
            decompress_etc2_block(&mut rgb, get_64bit_block(src, 0), Some(&mut alpha), true);
            for y in 0..BC_BLOCK_HEIGHT {
                for x in 0..BC_BLOCK_WIDTH {
                    let i = y * BC_BLOCK_WIDTH + x;
                    dst.write_bytes(x, y, &[rgb[i * 3], rgb[i * 3 + 1], rgb[i * 3 + 2], alpha[i]]);
                }
            }
        }
        vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK | vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK => {
            decompress_etc2_block(&mut rgb, get_64bit_block(src, 1), None, false);
            decompress_eac8_block(&mut alpha, get_64bit_block(src, 0));
            for y in 0..BC_BLOCK_HEIGHT {
                for x in 0..BC_BLOCK_WIDTH {
                    let i = y * BC_BLOCK_WIDTH + x;
                    dst.write_bytes(x, y, &[rgb[i * 3], rgb[i * 3 + 1], rgb[i * 3 + 2], alpha[i]]);
                }
            }
        }
        other => unreachable!("decompress_etc2 called for {other:?}"),
    }
}

/// `decompressEAC_R11` / `decompressEAC_RG11`
fn decompress_eac11(dst: &mut BlockOut<'_>, src: &[u8], channels: usize, signed_mode: bool) {
    let mut values = [[0i32; 16]; 2];
    for (c, channel) in values.iter_mut().enumerate().take(channels) {
        decompress_eac11_block(channel, get_64bit_block(src, c), signed_mode);
    }

    for y in 0..BC_BLOCK_HEIGHT {
        for x in 0..BC_BLOCK_WIDTH {
            let i = y * BC_BLOCK_WIDTH + x;
            let mut bytes = [0u8; 4];
            for c in 0..channels {
                let widened = if signed_mode {
                    extend11_to_16_with_sign(values[c][i] as i16) as u16
                } else {
                    extend11_to_16(values[c][i] as u16)
                };
                bytes[c * 2..c * 2 + 2].copy_from_slice(&widened.to_ne_bytes());
            }
            dst.write_bytes(x, y, &bytes[..channels * 2]);
        }
    }
}

// ---------------------------------------------------------------------------------
// BC6H and BC7
// ---------------------------------------------------------------------------------

const EP_BITS: [u8; 14] = [10, 7, 11, 11, 11, 9, 8, 8, 8, 6, 10, 11, 12, 16];

const PARTITIONS2: [[u8; 16]; 64] = [
    [0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1],
    [0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1],
    [0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1],
    [0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1],
    [0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1],
    [0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1],
    [0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
    [0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1],
    [0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0],
    [0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0],
    [0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1],
    [0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0],
    [0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0],
    [0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0],
    [0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
    [0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0],
    [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
    [0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1],
    [0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0],
    [0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0],
    [0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
    [0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0],
    [0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1],
    [0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1],
    [0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0],
    [0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0],
    [0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0],
    [0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1],
    [0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1],
    [0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0],
    [0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1],
    [0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1],
    [0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0],
    [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0],
    [0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1],
    [0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1],
    [0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1],
    [0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1],
    [0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1],
    [0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0],
    [0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1],
];

const PARTITIONS3: [[u8; 16]; 64] = [
    [0, 0, 1, 1, 0, 0, 1, 1, 0, 2, 2, 1, 2, 2, 2, 2],
    [0, 0, 0, 1, 0, 0, 1, 1, 2, 2, 1, 1, 2, 2, 2, 1],
    [0, 0, 0, 0, 2, 0, 0, 1, 2, 2, 1, 1, 2, 2, 1, 1],
    [0, 2, 2, 2, 0, 0, 2, 2, 0, 0, 1, 1, 0, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 1, 1, 2, 2],
    [0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 2, 2, 0, 0, 2, 2],
    [0, 0, 2, 2, 0, 0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 1, 1, 0, 0, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2],
    [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2],
    [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2],
    [0, 0, 1, 2, 0, 0, 1, 2, 0, 0, 1, 2, 0, 0, 1, 2],
    [0, 1, 1, 2, 0, 1, 1, 2, 0, 1, 1, 2, 0, 1, 1, 2],
    [0, 1, 2, 2, 0, 1, 2, 2, 0, 1, 2, 2, 0, 1, 2, 2],
    [0, 0, 1, 1, 0, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
    [0, 0, 1, 1, 2, 0, 0, 1, 2, 2, 0, 0, 2, 2, 2, 0],
    [0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 2, 1, 1, 2, 2],
    [0, 1, 1, 1, 0, 0, 1, 1, 2, 0, 0, 1, 2, 2, 0, 0],
    [0, 0, 0, 0, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2],
    [0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 2, 2, 1, 1, 1, 1],
    [0, 1, 1, 1, 0, 1, 1, 1, 0, 2, 2, 2, 0, 2, 2, 2],
    [0, 0, 0, 1, 0, 0, 0, 1, 2, 2, 2, 1, 2, 2, 2, 1],
    [0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 2, 2, 0, 1, 2, 2],
    [0, 0, 0, 0, 1, 1, 0, 0, 2, 2, 1, 0, 2, 2, 1, 0],
    [0, 1, 2, 2, 0, 1, 2, 2, 0, 0, 1, 1, 0, 0, 0, 0],
    [0, 0, 1, 2, 0, 0, 1, 2, 1, 1, 2, 2, 2, 2, 2, 2],
    [0, 1, 1, 0, 1, 2, 2, 1, 1, 2, 2, 1, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0, 1, 2, 2, 1, 1, 2, 2, 1],
    [0, 0, 2, 2, 1, 1, 0, 2, 1, 1, 0, 2, 0, 0, 2, 2],
    [0, 1, 1, 0, 0, 1, 1, 0, 2, 0, 0, 2, 2, 2, 2, 2],
    [0, 0, 1, 1, 0, 1, 2, 2, 0, 1, 2, 2, 0, 0, 1, 1],
    [0, 0, 0, 0, 2, 0, 0, 0, 2, 2, 1, 1, 2, 2, 2, 1],
    [0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 2, 1, 2, 2, 2],
    [0, 2, 2, 2, 0, 0, 2, 2, 0, 0, 1, 2, 0, 0, 1, 1],
    [0, 0, 1, 1, 0, 0, 1, 2, 0, 0, 2, 2, 0, 2, 2, 2],
    [0, 1, 2, 0, 0, 1, 2, 0, 0, 1, 2, 0, 0, 1, 2, 0],
    [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 0, 0, 0, 0],
    [0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0],
    [0, 1, 2, 0, 2, 0, 1, 2, 1, 2, 0, 1, 0, 1, 2, 0],
    [0, 0, 1, 1, 2, 2, 0, 0, 1, 1, 2, 2, 0, 0, 1, 1],
    [0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 0, 0, 0, 0, 1, 1],
    [0, 1, 0, 1, 0, 1, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2],
    [0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 2, 1, 2, 1, 2, 1],
    [0, 0, 2, 2, 1, 1, 2, 2, 0, 0, 2, 2, 1, 1, 2, 2],
    [0, 0, 2, 2, 0, 0, 1, 1, 0, 0, 2, 2, 0, 0, 1, 1],
    [0, 2, 2, 0, 1, 2, 2, 1, 0, 2, 2, 0, 1, 2, 2, 1],
    [0, 1, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 1, 0, 1],
    [0, 0, 0, 0, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],
    [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2, 2, 2, 2],
    [0, 2, 2, 2, 0, 1, 1, 1, 0, 2, 2, 2, 0, 1, 1, 1],
    [0, 0, 0, 2, 1, 1, 1, 2, 0, 0, 0, 2, 1, 1, 1, 2],
    [0, 0, 0, 0, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2],
    [0, 2, 2, 2, 0, 1, 1, 1, 0, 1, 1, 1, 0, 2, 2, 2],
    [0, 0, 0, 2, 1, 1, 1, 2, 1, 1, 1, 2, 0, 0, 0, 2],
    [0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 2, 2, 2, 2],
    [0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 2, 1, 1, 2],
    [0, 1, 1, 0, 0, 1, 1, 0, 2, 2, 2, 2, 2, 2, 2, 2],
    [0, 0, 2, 2, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 2, 2],
    [0, 0, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 0, 0, 2, 2],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2],
    [0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1],
    [0, 2, 2, 2, 1, 2, 2, 2, 0, 2, 2, 2, 1, 2, 2, 2],
    [0, 1, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
    [0, 1, 1, 1, 2, 0, 1, 1, 2, 2, 0, 1, 2, 2, 2, 0],
];

const ANCHOR_INDICES_SECOND_SUBSET2: [u8; 64] = [
    15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 2, 8, 2, 2, 8, 8, 15, 2, 8, 2, 2, 8, 8, 2, 2, 15, 15, 6, 8, 2, 8, 15, 15, 2, 8, 2, 2, 2, 15, 15, 6, 6, 2,
    6, 8, 15, 15, 2, 2, 15, 15, 15, 15, 15, 2, 2, 15,
];

const ANCHOR_INDICES_SECOND_SUBSET3: [u8; 64] = [
    3, 3, 15, 15, 8, 3, 15, 15, 8, 8, 6, 6, 6, 5, 3, 3, 3, 3, 8, 15, 3, 3, 6, 10, 5, 8, 8, 6, 8, 5, 15, 15, 8, 15, 3, 5, 6, 10, 8, 15, 15, 3, 15, 5, 15, 15, 15, 15, 3, 15, 5, 5,
    5, 8, 5, 10, 5, 10, 8, 13, 15, 12, 3, 3,
];

const ANCHOR_INDICES_THIRD_SUBSET: [u8; 64] = [
    15, 8, 8, 3, 15, 15, 3, 8, 15, 15, 15, 15, 15, 15, 15, 8, 15, 8, 15, 3, 15, 8, 15, 8, 3, 15, 6, 10, 15, 15, 10, 8, 15, 3, 15, 10, 10, 8, 9, 10, 6, 15, 8, 15, 3, 6, 6, 8, 15,
    3, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 3, 15, 15, 8,
];

const WEIGHTS2: [u16; 4] = [0, 21, 43, 64];

const WEIGHTS3: [u16; 8] = [0, 9, 18, 27, 37, 46, 55, 64];

const WEIGHTS4: [u16; 16] = [0, 4, 9, 13, 17, 21, 26, 30, 34, 38, 43, 47, 51, 55, 60, 64];

/// `extractModeBc6` - -1 for an illegal mode, which decodes to opaque black.
fn extract_mode_bc6(src: u8) -> i32 {
    if matches!(src & 0x1f, 0x13 | 0x17 | 0x1b | 0x1f) {
        return -1;
    }
    match src & 0x3 {
        0 => 0,
        1 => 1,
        2 => 2 + i32::from((src >> 2) & 0x7),
        _ => 10 + i32::from((src >> 2) & 0x7),
    }
}

/// `extractModeBc7` - the mode is unary-coded in the first byte.
fn extract_mode_bc7(src: u8) -> i32 {
    (0..8).find(|i| src & (1 << i) != 0).unwrap_or(-1)
}

fn low_bit_mask(bits: u32) -> u32 {
    if bits >= 32 { u32::MAX } else { (1u32 << bits) - 1 }
}

/// `getBits128` - `first > last` names the field the other way round and asks for its
/// bits reversed, which several BC6H modes rely on.
fn get_bits128(low: u64, high: u64, first: u32, last: u32) -> u32 {
    let d = [low, high];
    let reverse = first > last;
    let (first, last) = if reverse { (last, first) } else { (first, last) };

    let element_first = (first / 64) as usize;
    let element_last = (last / 64) as usize;

    let mut ret = if element_first == element_last {
        let shift = first % 64;
        let len = last - first + 1;
        ((d[element_first] >> shift) as u32) & low_bit_mask(len)
    } else {
        let len0 = 64 - first;
        let data0 = ((low >> first) as u32) & low_bit_mask(len0);
        let len1 = last - 63;
        let data1 = (high as u32) & low_bit_mask(len1);
        (data1 << len0) | data0
    };

    if reverse {
        let len = last - first + 1;
        let orig = ret;
        ret = 0;
        for i in 0..len {
            ret |= ((orig >> (len - 1 - i)) & 1) << i;
        }
    }
    ret
}

/// `signExtend`
fn sign_extend(value: i32, src_bits: u32, dst_bits: u32) -> i32 {
    if value & (1 << (src_bits - 1)) == 0 {
        return value;
    }
    let dst_mask = ((1u64 << dst_bits) - 1) as u32 as i32;
    let extended_bits = (0xffff_ffffu32 << src_bits) as i32;
    (value | extended_bits) & dst_mask
}

/// `unquantize`
fn unquantize(x: i32, mode: usize, has_sign: bool) -> i32 {
    let ep_bits = i32::from(EP_BITS[mode]);
    if has_sign {
        if ep_bits >= 16 {
            return x;
        }
        let s = x < 0;
        let mut x = x.abs();
        if x == 0 {
            x = 0;
        } else if x >= (1 << (ep_bits - 1)) - 1 {
            x = 0x7fff;
        } else {
            x = ((x << 15) + 0x4000) >> (ep_bits - 1);
        }
        if s { -x } else { x }
    } else if ep_bits >= 15 {
        x
    } else if x == 0 {
        0
    } else if x == (1 << ep_bits) - 1 {
        0xffff
    } else {
        ((x << 15) + 0x4000) >> (ep_bits - 1)
    }
}

/// `interpolate`
fn interpolate(a: i32, b: i32, index: u32, index_precision: u32) -> i32 {
    let weight = i32::from(match index_precision {
        2 => WEIGHTS2[index as usize],
        3 => WEIGHTS3[index as usize],
        _ => WEIGHTS4[index as usize],
    });
    ((64 - weight) * a + weight * b + 32) >> 6
}

/// `finishUnquantize`
fn finish_unquantize(x: i32, has_sign: bool) -> i16 {
    let mut x = x;
    if has_sign {
        x = if x < 0 { -(((-x) * 31) >> 5) } else { (x * 31) >> 5 };
        if x < 0 {
            x = (-x) | 0x8000;
        }
    } else {
        x = (x * 31) / 64;
    }
    x as i16
}

/// `decompressBc6H`
fn decompress_bc6h(dst: &mut BlockOut<'_>, src: &[u8], has_sign: bool) {
    let mode = extract_mode_bc6(src[0]);
    let mut r = [0i32; 4];
    let mut g = [0i32; 4];
    let mut b = [0i32; 4];
    let mut delta_bits_r = 0u32;
    let mut delta_bits_g = 0u32;
    let mut delta_bits_b = 0u32;
    let low = get_64bit_block_le(src, 0);
    let high = get_64bit_block_le(src, 1);
    let d = if mode < 10 { get_bits128(low, high, 77, 81) } else { 0 } as usize;
    let num_regions = if mode > 9 { 1u32 } else { 2 };
    let num_endpoints = (num_regions * 2) as usize;
    let transformed = mode != 9 && mode != 10;
    let color_index_bc = if mode < 10 { 3u32 } else { 4 };
    let mut color_index_data = high >> (if mode < 10 { 18 } else { 1 });
    let anchor_index = [0u32, u32::from(ANCHOR_INDICES_SECOND_SUBSET2[d])];

    match mode {
        0 => {
            g[2] |= (get_bits128(low, high, 2, 2) as i32) << 4;
            b[2] |= (get_bits128(low, high, 3, 3) as i32) << 4;
            b[3] |= (get_bits128(low, high, 4, 4) as i32) << 4;
            r[0] |= get_bits128(low, high, 5, 14) as i32;
            g[0] |= get_bits128(low, high, 15, 24) as i32;
            b[0] |= get_bits128(low, high, 25, 34) as i32;
            r[1] |= get_bits128(low, high, 35, 39) as i32;
            g[3] |= (get_bits128(low, high, 40, 40) as i32) << 4;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 49) as i32;
            b[3] |= get_bits128(low, high, 50, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 59) as i32;
            b[3] |= (get_bits128(low, high, 60, 60) as i32) << 1;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 69) as i32;
            b[3] |= (get_bits128(low, high, 70, 70) as i32) << 2;
            r[3] |= get_bits128(low, high, 71, 75) as i32;
            b[3] |= (get_bits128(low, high, 76, 76) as i32) << 3;
            delta_bits_r = 5;
            delta_bits_g = 5;
            delta_bits_b = 5;
        }
        1 => {
            g[2] |= (get_bits128(low, high, 2, 2) as i32) << 5;
            g[3] |= (get_bits128(low, high, 3, 3) as i32) << 4;
            g[3] |= (get_bits128(low, high, 4, 4) as i32) << 5;
            r[0] |= get_bits128(low, high, 5, 11) as i32;
            b[3] |= get_bits128(low, high, 12, 12) as i32;
            b[3] |= (get_bits128(low, high, 13, 13) as i32) << 1;
            b[2] |= (get_bits128(low, high, 14, 14) as i32) << 4;
            g[0] |= get_bits128(low, high, 15, 21) as i32;
            b[2] |= (get_bits128(low, high, 22, 22) as i32) << 5;
            b[3] |= (get_bits128(low, high, 23, 23) as i32) << 2;
            g[2] |= (get_bits128(low, high, 24, 24) as i32) << 4;
            b[0] |= get_bits128(low, high, 25, 31) as i32;
            b[3] |= (get_bits128(low, high, 32, 32) as i32) << 3;
            b[3] |= (get_bits128(low, high, 33, 33) as i32) << 5;
            b[3] |= (get_bits128(low, high, 34, 34) as i32) << 4;
            r[1] |= get_bits128(low, high, 35, 40) as i32;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 60) as i32;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 70) as i32;
            r[3] |= get_bits128(low, high, 71, 76) as i32;
            delta_bits_r = 6;
            delta_bits_g = 6;
            delta_bits_b = 6;
        }
        2 => {
            r[0] |= get_bits128(low, high, 5, 14) as i32;
            g[0] |= get_bits128(low, high, 15, 24) as i32;
            b[0] |= get_bits128(low, high, 25, 34) as i32;
            r[1] |= get_bits128(low, high, 35, 39) as i32;
            r[0] |= (get_bits128(low, high, 40, 40) as i32) << 10;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 48) as i32;
            g[0] |= (get_bits128(low, high, 49, 49) as i32) << 10;
            b[3] |= get_bits128(low, high, 50, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 58) as i32;
            b[0] |= (get_bits128(low, high, 59, 59) as i32) << 10;
            b[3] |= (get_bits128(low, high, 60, 60) as i32) << 1;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 69) as i32;
            b[3] |= (get_bits128(low, high, 70, 70) as i32) << 2;
            r[3] |= get_bits128(low, high, 71, 75) as i32;
            b[3] |= (get_bits128(low, high, 76, 76) as i32) << 3;
            delta_bits_r = 5;
            delta_bits_g = 4;
            delta_bits_b = 4;
        }
        3 => {
            r[0] |= get_bits128(low, high, 5, 14) as i32;
            g[0] |= get_bits128(low, high, 15, 24) as i32;
            b[0] |= get_bits128(low, high, 25, 34) as i32;
            r[1] |= get_bits128(low, high, 35, 38) as i32;
            r[0] |= (get_bits128(low, high, 39, 39) as i32) << 10;
            g[3] |= (get_bits128(low, high, 40, 40) as i32) << 4;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 49) as i32;
            g[0] |= (get_bits128(low, high, 50, 50) as i32) << 10;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 58) as i32;
            b[0] |= (get_bits128(low, high, 59, 59) as i32) << 10;
            b[3] |= (get_bits128(low, high, 60, 60) as i32) << 1;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 68) as i32;
            b[3] |= get_bits128(low, high, 69, 69) as i32;
            b[3] |= (get_bits128(low, high, 70, 70) as i32) << 2;
            r[3] |= get_bits128(low, high, 71, 74) as i32;
            g[2] |= (get_bits128(low, high, 75, 75) as i32) << 4;
            b[3] |= (get_bits128(low, high, 76, 76) as i32) << 3;
            delta_bits_r = 4;
            delta_bits_b = 4;
            delta_bits_g = 5;
        }
        4 => {
            r[0] |= get_bits128(low, high, 5, 14) as i32;
            g[0] |= get_bits128(low, high, 15, 24) as i32;
            b[0] |= get_bits128(low, high, 25, 34) as i32;
            r[1] |= get_bits128(low, high, 35, 38) as i32;
            r[0] |= (get_bits128(low, high, 39, 39) as i32) << 10;
            b[2] |= (get_bits128(low, high, 40, 40) as i32) << 4;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 48) as i32;
            g[0] |= (get_bits128(low, high, 49, 49) as i32) << 10;
            b[3] |= get_bits128(low, high, 50, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 59) as i32;
            b[0] |= (get_bits128(low, high, 60, 60) as i32) << 10;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 68) as i32;
            b[3] |= (get_bits128(low, high, 69, 69) as i32) << 1;
            b[3] |= (get_bits128(low, high, 70, 70) as i32) << 2;
            r[3] |= get_bits128(low, high, 71, 74) as i32;
            b[3] |= (get_bits128(low, high, 75, 75) as i32) << 4;
            b[3] |= (get_bits128(low, high, 76, 76) as i32) << 3;
            delta_bits_r = 4;
            delta_bits_g = 4;
            delta_bits_b = 5;
        }
        5 => {
            r[0] |= get_bits128(low, high, 5, 13) as i32;
            b[2] |= (get_bits128(low, high, 14, 14) as i32) << 4;
            g[0] |= get_bits128(low, high, 15, 23) as i32;
            g[2] |= (get_bits128(low, high, 24, 24) as i32) << 4;
            b[0] |= get_bits128(low, high, 25, 33) as i32;
            b[3] |= (get_bits128(low, high, 34, 34) as i32) << 4;
            r[1] |= get_bits128(low, high, 35, 39) as i32;
            g[3] |= (get_bits128(low, high, 40, 40) as i32) << 4;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 49) as i32;
            b[3] |= get_bits128(low, high, 50, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 59) as i32;
            b[3] |= (get_bits128(low, high, 60, 60) as i32) << 1;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 69) as i32;
            b[3] |= (get_bits128(low, high, 70, 70) as i32) << 2;
            r[3] |= get_bits128(low, high, 71, 75) as i32;
            b[3] |= (get_bits128(low, high, 76, 76) as i32) << 3;
            delta_bits_r = 5;
            delta_bits_g = 5;
            delta_bits_b = 5;
        }
        6 => {
            r[0] |= get_bits128(low, high, 5, 12) as i32;
            g[3] |= (get_bits128(low, high, 13, 13) as i32) << 4;
            b[2] |= (get_bits128(low, high, 14, 14) as i32) << 4;
            g[0] |= get_bits128(low, high, 15, 22) as i32;
            b[3] |= (get_bits128(low, high, 23, 23) as i32) << 2;
            g[2] |= (get_bits128(low, high, 24, 24) as i32) << 4;
            b[0] |= get_bits128(low, high, 25, 32) as i32;
            b[3] |= (get_bits128(low, high, 33, 33) as i32) << 3;
            b[3] |= (get_bits128(low, high, 34, 34) as i32) << 4;
            r[1] |= get_bits128(low, high, 35, 40) as i32;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 49) as i32;
            b[3] |= get_bits128(low, high, 50, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 59) as i32;
            b[3] |= (get_bits128(low, high, 60, 60) as i32) << 1;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 70) as i32;
            r[3] |= get_bits128(low, high, 71, 76) as i32;
            delta_bits_r = 6;
            delta_bits_g = 5;
            delta_bits_b = 5;
        }
        7 => {
            r[0] |= get_bits128(low, high, 5, 12) as i32;
            b[3] |= get_bits128(low, high, 13, 13) as i32;
            b[2] |= (get_bits128(low, high, 14, 14) as i32) << 4;
            g[0] |= get_bits128(low, high, 15, 22) as i32;
            g[2] |= (get_bits128(low, high, 23, 23) as i32) << 5;
            g[2] |= (get_bits128(low, high, 24, 24) as i32) << 4;
            b[0] |= get_bits128(low, high, 25, 32) as i32;
            g[3] |= (get_bits128(low, high, 33, 33) as i32) << 5;
            b[3] |= (get_bits128(low, high, 34, 34) as i32) << 4;
            r[1] |= get_bits128(low, high, 35, 39) as i32;
            g[3] |= (get_bits128(low, high, 40, 40) as i32) << 4;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 59) as i32;
            b[3] |= (get_bits128(low, high, 60, 60) as i32) << 1;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 69) as i32;
            b[3] |= (get_bits128(low, high, 70, 70) as i32) << 2;
            r[3] |= get_bits128(low, high, 71, 75) as i32;
            b[3] |= (get_bits128(low, high, 76, 76) as i32) << 3;
            delta_bits_r = 5;
            delta_bits_b = 5;
            delta_bits_g = 6;
        }
        8 => {
            r[0] |= get_bits128(low, high, 5, 12) as i32;
            b[3] |= (get_bits128(low, high, 13, 13) as i32) << 1;
            b[2] |= (get_bits128(low, high, 14, 14) as i32) << 4;
            g[0] |= get_bits128(low, high, 15, 22) as i32;
            b[2] |= (get_bits128(low, high, 23, 23) as i32) << 5;
            g[2] |= (get_bits128(low, high, 24, 24) as i32) << 4;
            b[0] |= get_bits128(low, high, 25, 32) as i32;
            b[3] |= (get_bits128(low, high, 33, 33) as i32) << 5;
            b[3] |= (get_bits128(low, high, 34, 34) as i32) << 4;
            r[1] |= get_bits128(low, high, 35, 39) as i32;
            g[3] |= (get_bits128(low, high, 40, 40) as i32) << 4;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 49) as i32;
            b[3] |= get_bits128(low, high, 50, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 60) as i32;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 69) as i32;
            b[3] |= (get_bits128(low, high, 70, 70) as i32) << 2;
            r[3] |= get_bits128(low, high, 71, 75) as i32;
            b[3] |= (get_bits128(low, high, 76, 76) as i32) << 3;
            delta_bits_r = 5;
            delta_bits_g = 5;
            delta_bits_b = 6;
        }
        9 => {
            r[0] |= get_bits128(low, high, 5, 10) as i32;
            g[3] |= (get_bits128(low, high, 11, 11) as i32) << 4;
            b[3] |= get_bits128(low, high, 12, 13) as i32;
            b[2] |= (get_bits128(low, high, 14, 14) as i32) << 4;
            g[0] |= get_bits128(low, high, 15, 20) as i32;
            g[2] |= (get_bits128(low, high, 21, 21) as i32) << 5;
            b[2] |= (get_bits128(low, high, 22, 22) as i32) << 5;
            b[3] |= (get_bits128(low, high, 23, 23) as i32) << 2;
            g[2] |= (get_bits128(low, high, 24, 24) as i32) << 4;
            b[0] |= get_bits128(low, high, 25, 30) as i32;
            g[3] |= (get_bits128(low, high, 31, 31) as i32) << 5;
            b[3] |= (get_bits128(low, high, 32, 32) as i32) << 3;
            b[3] |= (get_bits128(low, high, 33, 33) as i32) << 5;
            b[3] |= (get_bits128(low, high, 34, 34) as i32) << 4;
            r[1] |= get_bits128(low, high, 35, 40) as i32;
            g[2] |= get_bits128(low, high, 41, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 50) as i32;
            g[3] |= get_bits128(low, high, 51, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 60) as i32;
            b[2] |= get_bits128(low, high, 61, 64) as i32;
            r[2] |= get_bits128(low, high, 65, 70) as i32;
            r[3] |= get_bits128(low, high, 71, 76) as i32;
            delta_bits_r = 6;
            delta_bits_g = 6;
            delta_bits_b = 6;
        }
        10 => {
            r[0] |= get_bits128(low, high, 5, 14) as i32;
            g[0] |= get_bits128(low, high, 15, 24) as i32;
            b[0] |= get_bits128(low, high, 25, 34) as i32;
            r[1] |= get_bits128(low, high, 35, 44) as i32;
            g[1] |= get_bits128(low, high, 45, 54) as i32;
            b[1] |= get_bits128(low, high, 55, 64) as i32;
            delta_bits_r = 10;
            delta_bits_g = 10;
            delta_bits_b = 10;
        }
        11 => {
            r[0] |= get_bits128(low, high, 5, 14) as i32;
            g[0] |= get_bits128(low, high, 15, 24) as i32;
            b[0] |= get_bits128(low, high, 25, 34) as i32;
            r[1] |= get_bits128(low, high, 35, 43) as i32;
            r[0] |= (get_bits128(low, high, 44, 44) as i32) << 10;
            g[1] |= get_bits128(low, high, 45, 53) as i32;
            g[0] |= (get_bits128(low, high, 54, 54) as i32) << 10;
            b[1] |= get_bits128(low, high, 55, 63) as i32;
            b[0] |= (get_bits128(low, high, 64, 64) as i32) << 10;
            delta_bits_r = 9;
            delta_bits_g = 9;
            delta_bits_b = 9;
        }
        12 => {
            r[0] |= get_bits128(low, high, 5, 14) as i32;
            g[0] |= get_bits128(low, high, 15, 24) as i32;
            b[0] |= get_bits128(low, high, 25, 34) as i32;
            r[1] |= get_bits128(low, high, 35, 42) as i32;
            r[0] |= (get_bits128(low, high, 44, 43) as i32) << 10;
            g[1] |= get_bits128(low, high, 45, 52) as i32;
            g[0] |= (get_bits128(low, high, 54, 53) as i32) << 10;
            b[1] |= get_bits128(low, high, 55, 62) as i32;
            b[0] |= (get_bits128(low, high, 64, 63) as i32) << 10;
            delta_bits_r = 8;
            delta_bits_g = 8;
            delta_bits_b = 8;
        }
        13 => {
            r[0] |= get_bits128(low, high, 5, 14) as i32;
            g[0] |= get_bits128(low, high, 15, 24) as i32;
            b[0] |= get_bits128(low, high, 25, 34) as i32;
            r[1] |= get_bits128(low, high, 35, 38) as i32;
            r[0] |= (get_bits128(low, high, 44, 39) as i32) << 10;
            g[1] |= get_bits128(low, high, 45, 48) as i32;
            g[0] |= (get_bits128(low, high, 54, 49) as i32) << 10;
            b[1] |= get_bits128(low, high, 55, 58) as i32;
            b[0] |= (get_bits128(low, high, 64, 59) as i32) << 10;
            delta_bits_r = 4;
            delta_bits_g = 4;
            delta_bits_b = 4;
        }
        _ => {}
    }

    if mode != -1 {
        let mode_ndx = mode as usize;
        let ep_bits = u32::from(EP_BITS[mode_ndx]);

        if has_sign {
            r[0] = sign_extend(r[0], ep_bits, 32);
            g[0] = sign_extend(g[0], ep_bits, 32);
            b[0] = sign_extend(b[0], ep_bits, 32);
        }

        if transformed {
            let mask = low_bit_mask(ep_bits) as i32;
            for i in 1..num_endpoints {
                r[i] = sign_extend(r[i], delta_bits_r, 32);
                r[i] = (r[0] + r[i]) & mask;
                g[i] = sign_extend(g[i], delta_bits_g, 32);
                g[i] = (g[0] + g[i]) & mask;
                b[i] = sign_extend(b[i], delta_bits_b, 32);
                b[i] = (b[0] + b[i]) & mask;
            }
        }

        if has_sign {
            for i in 1..4 {
                r[i] = sign_extend(r[i], ep_bits, 32);
                g[i] = sign_extend(g[i], ep_bits, 32);
                b[i] = sign_extend(b[i], ep_bits, 32);
            }
        }

        for i in 0..num_endpoints {
            r[i] = unquantize(r[i], mode_ndx, has_sign);
            g[i] = unquantize(g[i], mode_ndx, has_sign);
            b[i] = unquantize(b[i], mode_ndx, has_sign);
        }
    }

    for i in 0..16u32 {
        let subset_index = if num_regions == 1 { 0 } else { usize::from(PARTITIONS2[d][i as usize]) };
        let bits = if i == anchor_index[subset_index] { color_index_bc - 1 } else { color_index_bc };
        let color_index = (color_index_data & u64::from(low_bit_mask(bits))) as u32;
        let r16 = finish_unquantize(interpolate(r[2 * subset_index], r[2 * subset_index + 1], color_index, color_index_bc), has_sign);
        let g16 = finish_unquantize(interpolate(g[2 * subset_index], g[2 * subset_index + 1], color_index, color_index_bc), has_sign);
        let b16 = finish_unquantize(interpolate(b[2 * subset_index], b[2 * subset_index + 1], color_index, color_index_bc), has_sign);
        let y = (i / 4) as usize;
        let x = (i % 4) as usize;

        if mode == -1 {
            dst.write_bytes(x, y, &[0u8; 6]);
        } else {
            let mut bytes = [0u8; 6];
            bytes[0..2].copy_from_slice(&r16.to_ne_bytes());
            bytes[2..4].copy_from_slice(&g16.to_ne_bytes());
            bytes[4..6].copy_from_slice(&b16.to_ne_bytes());
            dst.write_bytes(x, y, &bytes);
        }

        color_index_data >>= bits;
    }
}

/// `decompressBc7`
// The endpoint loops index by (endpoint, component) exactly as upstream does; the
// iterator forms clippy suggests lose that correspondence for no gain.
#[allow(clippy::needless_range_loop)]
fn decompress_bc7(dst: &mut BlockOut<'_>, src: &[u8]) {
    const SUBSETS: [u32; 8] = [3, 2, 3, 2, 1, 1, 1, 2];
    const PARTITION_BITS: [u32; 8] = [4, 6, 6, 6, 0, 0, 0, 6];
    // r, g, b, a, p
    const ENDPOINT_BITS: [[u32; 5]; 8] = [
        [4, 4, 4, 0, 1],
        [6, 6, 6, 0, 1],
        [5, 5, 5, 0, 0],
        [7, 7, 7, 0, 1],
        [5, 5, 5, 6, 0],
        [7, 7, 7, 8, 0],
        [7, 7, 7, 7, 1],
        [5, 5, 5, 5, 1],
    ];
    const INDEX_BITS: [u32; 8] = [3, 3, 2, 2, 2, 2, 4, 2];

    let low = get_64bit_block_le(src, 0);
    let high = get_64bit_block_le(src, 1);
    let mode = extract_mode_bc7(src[0]);
    let mut num_subsets = 1u32;
    let mut offset = (mode + 1) as u32;
    let mut rotation = 0u32;
    let mut idx_mode = 0u32;
    let mut endpoints = [[0u32; 5]; 6];
    let mut partition_set_id = 0usize;

    // Decode partition data from explicit partition bits
    if matches!(mode, 0 | 1 | 2 | 3 | 7) {
        let m = mode as usize;
        num_subsets = SUBSETS[m];
        partition_set_id = get_bits128(low, high, offset, offset + PARTITION_BITS[m] - 1) as usize;
        offset += PARTITION_BITS[m];
    }

    // Extract rotation bits
    if mode == 4 || mode == 5 {
        rotation = get_bits128(low, high, offset, offset + 1);
        offset += 2;
        if mode == 4 {
            idx_mode = get_bits128(low, high, offset, offset);
            offset += 1;
        }
    }

    let num_endpoints = (num_subsets * 2) as usize;

    // Extract raw, compressed endpoint bits
    for cpnt in 0..5 {
        for ep in 0..num_endpoints {
            if mode == 1 && cpnt == 4 && ep > 1 {
                continue; // Mode 1 has shared P bits
            }
            let n = if mode == -1 { 0 } else { ENDPOINT_BITS[mode as usize][cpnt] };
            if n > 0 {
                endpoints[ep][cpnt] = get_bits128(low, high, offset, offset + n - 1);
            }
            offset += n;
        }
    }

    // Decode endpoints
    if matches!(mode, 0 | 1 | 3 | 6 | 7) {
        // First handle modes that have P-bits
        for ep in endpoints.iter_mut().take(num_endpoints) {
            for cpnt in 0..4 {
                ep[cpnt] <<= 1;
            }
        }

        if mode == 1 {
            // P-bit is shared
            let pbit_zero = endpoints[0][4];
            let pbit_one = endpoints[1][4];

            for cpnt in 0..3 {
                endpoints[0][cpnt] |= pbit_zero;
                endpoints[1][cpnt] |= pbit_zero;
                endpoints[2][cpnt] |= pbit_one;
                endpoints[3][cpnt] |= pbit_one;
            }
        } else {
            // Unique p-bit per endpoint
            for ep in endpoints.iter_mut().take(num_endpoints) {
                for cpnt in 0..4 {
                    ep[cpnt] |= ep[4];
                }
            }
        }
    }

    if mode != -1 {
        let bits = ENDPOINT_BITS[mode as usize];
        for ep in endpoints.iter_mut().take(num_endpoints) {
            // Left shift endpoint components so that their MSB lies in bit 7
            for cpnt in 0..4 {
                ep[cpnt] <<= 8 - (bits[cpnt] + bits[4]);
            }
            // Replicate each component's MSB into the LSBs revealed by the left-shift above
            for cpnt in 0..4 {
                ep[cpnt] |= ep[cpnt] >> (bits[cpnt] + bits[4]);
            }
        }

        // If this mode does not explicitly define the alpha component set alpha equal to 1.0
        if mode < 4 {
            for ep in endpoints.iter_mut().take(num_endpoints) {
                ep[3] = 255;
            }
        }
    }

    let mut color_idx_offset = offset + if mode == 4 && idx_mode != 0 { 31 } else { 0 };
    let mut alpha_idx_offset = offset + if mode == 5 || (mode == 4 && idx_mode == 0) { 31 } else { 0 };

    for pixel in 0..16u32 {
        let y = (pixel / 4) as usize;
        let x = (pixel % 4) as usize;

        if mode == -1 {
            dst.write_u32(x, y, 0);
            continue;
        }

        let subset_index = match num_subsets {
            2 => usize::from(PARTITIONS2[partition_set_id][pixel as usize]),
            3 => usize::from(PARTITIONS3[partition_set_id][pixel as usize]),
            _ => 0,
        };

        let anchor_index = if num_subsets == 2 && subset_index == 1 {
            u32::from(ANCHOR_INDICES_SECOND_SUBSET2[partition_set_id])
        } else if num_subsets == 3 && subset_index == 1 {
            u32::from(ANCHOR_INDICES_SECOND_SUBSET3[partition_set_id])
        } else if num_subsets == 3 && subset_index == 2 {
            u32::from(ANCHOR_INDICES_THIRD_SUBSET[partition_set_id])
        } else {
            0
        };

        let endpoint_start = endpoints[2 * subset_index];
        let endpoint_end = endpoints[2 * subset_index + 1];

        let color_interpolation_bits = INDEX_BITS[mode as usize] + idx_mode;
        let color_index_bits = color_interpolation_bits - u32::from(anchor_index == pixel);
        let alpha_interpolation_bits = if mode == 4 {
            3 - idx_mode
        } else if mode == 5 {
            2
        } else {
            color_interpolation_bits
        };
        let alpha_index_bits = alpha_interpolation_bits - u32::from(anchor_index == pixel);
        let color_idx = get_bits128(low, high, color_idx_offset, color_idx_offset + color_index_bits - 1);
        let alpha_idx = if mode == 4 || mode == 5 {
            get_bits128(low, high, alpha_idx_offset, alpha_idx_offset + alpha_index_bits - 1)
        } else {
            color_idx
        };
        let r = interpolate(endpoint_start[0] as i32, endpoint_end[0] as i32, color_idx, color_interpolation_bits) as u32;
        let g = interpolate(endpoint_start[1] as i32, endpoint_end[1] as i32, color_idx, color_interpolation_bits) as u32;
        let b = interpolate(endpoint_start[2] as i32, endpoint_end[2] as i32, color_idx, color_interpolation_bits) as u32;
        let a = interpolate(endpoint_start[3] as i32, endpoint_end[3] as i32, alpha_idx, alpha_interpolation_bits) as u32;

        color_idx_offset += color_index_bits;
        alpha_idx_offset += alpha_index_bits;

        let packed = match rotation {
            1 if mode == 4 || mode == 5 => a | (g << 8) | (b << 16) | (r << 24),
            2 if mode == 4 || mode == 5 => r | (a << 8) | (b << 16) | (g << 24),
            3 if mode == 4 || mode == 5 => r | (g << 8) | (a << 16) | (b << 24),
            _ => r | (g << 8) | (b << 16) | (a << 24),
        };
        dst.write_u32(x, y, packed);
    }
}

/// `decompressBlock`, narrowed to the BC and ETC2/EAC families.
fn decompress_block(dst: &mut BlockOut<'_>, format: vk::Format, src: &[u8]) {
    match format {
        vk::Format::BC1_RGB_UNORM_BLOCK | vk::Format::BC1_RGB_SRGB_BLOCK => decompress_bc1(dst, src, false),
        vk::Format::BC1_RGBA_UNORM_BLOCK | vk::Format::BC1_RGBA_SRGB_BLOCK => decompress_bc1(dst, src, true),
        vk::Format::BC2_UNORM_BLOCK | vk::Format::BC2_SRGB_BLOCK => decompress_bc2(dst, src),
        vk::Format::BC3_UNORM_BLOCK | vk::Format::BC3_SRGB_BLOCK => decompress_bc3(dst, src),
        vk::Format::BC4_UNORM_BLOCK => decompress_bc4(dst, src, false),
        vk::Format::BC4_SNORM_BLOCK => decompress_bc4(dst, src, true),
        vk::Format::BC5_UNORM_BLOCK => decompress_bc5(dst, src, false),
        vk::Format::BC5_SNORM_BLOCK => decompress_bc5(dst, src, true),
        vk::Format::ETC2_R8G8B8_UNORM_BLOCK
        | vk::Format::ETC2_R8G8B8_SRGB_BLOCK
        | vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK
        | vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK
        | vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK
        | vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK => decompress_etc2(dst, src, format),
        vk::Format::EAC_R11_UNORM_BLOCK => decompress_eac11(dst, src, 1, false),
        vk::Format::EAC_R11_SNORM_BLOCK => decompress_eac11(dst, src, 1, true),
        vk::Format::EAC_R11G11_UNORM_BLOCK => decompress_eac11(dst, src, 2, false),
        vk::Format::EAC_R11G11_SNORM_BLOCK => decompress_eac11(dst, src, 2, true),
        vk::Format::BC6H_UFLOAT_BLOCK => decompress_bc6h(dst, src, false),
        vk::Format::BC6H_SFLOAT_BLOCK => decompress_bc6h(dst, src, true),
        vk::Format::BC7_UNORM_BLOCK | vk::Format::BC7_SRGB_BLOCK => decompress_bc7(dst, src),
        other => unreachable!("decompress_block called for {other:?}"),
    }
}

/// `tcu::decompress` - block by block, clipping the last block of a row or column to
/// the image edge.
///
/// Returns false when the format is one this port does not decode.
pub fn decompress(dst: &mut PixelBufferAccess<'_>, format: vk::Format, src: &[u8]) -> bool {
    let Some(uncompressed) = get_uncompressed_format(format) else {
        return false;
    };
    debug_assert_eq!(dst.format(), uncompressed);
    let pixel_size = uncompressed.pixel_size().expect("a compressed format decodes to a sized format") as usize;
    let block_size = crate::vk::compressed_formats::get_block_size_in_bytes(format) as usize;
    let block_width = crate::vk::compressed_formats::get_block_width(format) as usize;
    let block_height = crate::vk::compressed_formats::get_block_height(format) as usize;
    let [width, height, depth] = dst.size();

    let block_count_x = (width as usize).div_ceil(block_width);
    let block_count_y = (height as usize).div_ceil(block_height);

    let row_pitch = pixel_size * block_width;
    let mut scratch = vec![0u8; row_pitch * block_height];
    // ASTC decodes through a format-aware access rather than raw bytes, so it needs a
    // real level to write into.
    let astc = is_astc_format(format);
    let mut astc_level = astc.then(|| TextureLevel::new(uncompressed, block_width as u32, block_height as u32, 1).expect("the decoded format is writable"));

    for block_z in 0..depth as usize {
        for block_y in 0..block_count_y {
            for block_x in 0..block_count_x {
                let at = (block_z * block_count_y * block_count_x + block_y * block_count_x + block_x) * block_size;
                let block = &src[at..at + block_size];

                if let Some(level) = astc_level.as_mut() {
                    // sRGB implies LDR; nothing ported reaches the HDR-only formats.
                    let is_srgb = is_astc_srgb_format(format);
                    crate::tcu::astc::decompress_block_to(&mut level.get_access(), block, is_srgb, true);
                } else {
                    let mut out = BlockOut {
                        data: &mut scratch,
                        row_pitch,
                        pixel_size,
                    };
                    decompress_block(&mut out, format, block);
                }

                let copy_width = block_width.min(width as usize - block_x * block_width);
                let copy_height = block_height.min(height as usize - block_y * block_height);
                let owned_access;
                let block_access = match astc_level.as_ref() {
                    Some(level) => {
                        owned_access = level.get_const_access();
                        &owned_access
                    }
                    None => {
                        owned_access = ConstPixelBufferAccess::new_with_pitch(
                            uncompressed,
                            [block_width as u32, block_height as u32, 1],
                            [pixel_size, row_pitch, row_pitch * block_height],
                            &scratch,
                        );
                        &owned_access
                    }
                };
                dst.copy_region_from(
                    block_access,
                    (0, 0, 0),
                    ((block_x * block_width) as u32, (block_y * block_height) as u32, block_z as u32),
                    (copy_width as u32, copy_height as u32, 1),
                );
            }
        }
    }
    true
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::TextureLevel;

    /// A block whose two endpoints are equal decodes to that colour everywhere,
    /// whichever index a texel carries.
    #[test]
    fn bc1_with_equal_endpoints_is_flat() {
        // 0x7c00 is r=0b11111, g=0, b=0 in 5:6:5.
        let mut block = [0u8; 8];
        block[0..2].copy_from_slice(&0x001fu16.to_le_bytes());
        block[2..4].copy_from_slice(&0x001fu16.to_le_bytes());
        block[4..8].copy_from_slice(&[0b1110_0100; 4]);

        let mut level = TextureLevel::new(get_uncompressed_format(vk::Format::BC1_RGB_UNORM_BLOCK).unwrap(), 4, 4, 1).unwrap();
        assert!(decompress(&mut level.get_access(), vk::Format::BC1_RGB_UNORM_BLOCK, &block));

        // 0x001f is b=0b11111 -> 255, everything else zero.
        let access = level.get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                assert_eq!(access.get_pixel(x, y, 0), [0.0, 0.0, 1.0, 1.0], "at ({x}, {y})");
            }
        }
    }

    /// `red0 > red1` selects the eight-value interpolation, and index 0 and 1 are the
    /// endpoints themselves.
    #[test]
    fn bc4_endpoints_decode_to_their_own_values() {
        let mut block = [0u8; 8];
        block[0] = 255;
        block[1] = 0;
        // Indices: texel 0 -> 0, texel 1 -> 1, the rest 0.
        let index_bits: u64 = 1 << 3;
        block[2..8].copy_from_slice(&index_bits.to_le_bytes()[0..6]);

        let mut level = TextureLevel::new(get_uncompressed_format(vk::Format::BC4_UNORM_BLOCK).unwrap(), 4, 4, 1).unwrap();
        assert!(decompress(&mut level.get_access(), vk::Format::BC4_UNORM_BLOCK, &block));

        let access = level.get_const_access();
        assert_eq!(access.get_pixel(0, 0, 0)[0], 1.0);
        assert_eq!(access.get_pixel(1, 0, 0)[0], 0.0);
    }

    /// An all-zero ETC2 block takes the individual path: every base is zero, the
    /// modifier table index is zero and the per-texel index is zero, so every texel
    /// comes out at the first modifier, 2.
    #[test]
    fn etc2_zero_block_decodes_to_the_first_modifier() {
        let block = [0u8; 8];
        let format = vk::Format::ETC2_R8G8B8_UNORM_BLOCK;
        let mut level = TextureLevel::new(get_uncompressed_format(format).unwrap(), 4, 4, 1).unwrap();
        assert!(decompress(&mut level.get_access(), format, &block));

        let access = level.get_const_access();
        let expected = 2.0 / 255.0;
        for y in 0..4 {
            for x in 0..4 {
                assert_eq!(access.get_pixel(x, y, 0), [expected, expected, expected, 1.0], "at ({x}, {y})");
            }
        }
    }

    /// The 11-bit EAC path: base 0, multiplier 0 and table 0 give `0*8 + 4 - 3 = 1`,
    /// which `extend11To16` widens to 32.
    #[test]
    fn eac_r11_zero_block_widens_to_16_bits() {
        let block = [0u8; 8];
        let format = vk::Format::EAC_R11_UNORM_BLOCK;
        let mut level = TextureLevel::new(get_uncompressed_format(format).unwrap(), 4, 4, 1).unwrap();
        assert!(decompress(&mut level.get_access(), format, &block));

        let access = level.get_const_access();
        assert_eq!(access.get_pixel(0, 0, 0)[0], 32.0 / 65535.0);
        assert_eq!(access.get_pixel(3, 3, 0)[0], 32.0 / 65535.0);
    }

    /// The last block of a row is clipped rather than written past the edge.
    #[test]
    fn a_width_that_is_not_a_multiple_of_the_block_is_clipped() {
        let block = [0u8; 8];
        let mut level = TextureLevel::new(get_uncompressed_format(vk::Format::BC1_RGB_UNORM_BLOCK).unwrap(), 6, 4, 1).unwrap();
        // Two blocks wide, the second only half used.
        assert!(decompress(&mut level.get_access(), vk::Format::BC1_RGB_UNORM_BLOCK, &[block, block].concat()));
        assert_eq!(level.get_const_access().size(), [6, 4, 1]);
    }
}

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

use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

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

/// `decompressBlock`, narrowed to the BC1-BC5 and ETC2/EAC families.
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
    let pixel_size = uncompressed.pixel_size().expect("BC formats decode to a sized format") as usize;
    let block_size = crate::vk::compressed_formats::get_block_size_in_bytes(format) as usize;
    let [width, height, depth] = dst.size();

    let block_count_x = (width as usize).div_ceil(BC_BLOCK_WIDTH);
    let block_count_y = (height as usize).div_ceil(BC_BLOCK_HEIGHT);

    let row_pitch = pixel_size * BC_BLOCK_WIDTH;
    let mut scratch = vec![0u8; row_pitch * BC_BLOCK_HEIGHT];

    for block_z in 0..depth as usize {
        for block_y in 0..block_count_y {
            for block_x in 0..block_count_x {
                let at = (block_z * block_count_y * block_count_x + block_y * block_count_x + block_x) * block_size;
                {
                    let mut out = BlockOut {
                        data: &mut scratch,
                        row_pitch,
                        pixel_size,
                    };
                    decompress_block(&mut out, format, &src[at..at + block_size]);
                }
                let copy_width = BC_BLOCK_WIDTH.min(width as usize - block_x * BC_BLOCK_WIDTH);
                let copy_height = BC_BLOCK_HEIGHT.min(height as usize - block_y * BC_BLOCK_HEIGHT);
                let block_access = ConstPixelBufferAccess::new_with_pitch(
                    uncompressed,
                    [BC_BLOCK_WIDTH as u32, BC_BLOCK_HEIGHT as u32, 1],
                    [pixel_size, row_pitch, row_pitch * BC_BLOCK_HEIGHT],
                    &scratch,
                );
                dst.copy_region_from(
                    &block_access,
                    (0, 0, 0),
                    ((block_x * BC_BLOCK_WIDTH) as u32, (block_y * BC_BLOCK_HEIGHT) as u32, block_z as u32),
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

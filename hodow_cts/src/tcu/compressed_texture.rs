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
// The BC1-BC5 decoders, which a blit out of a compressed image needs: the reference
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

/// `decompressBlock`, narrowed to the BC1-BC5 family.
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

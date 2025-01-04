// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuBilinearImageCompare.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// An image comparison that tolerates the result being shifted or resampled by up to
// about a pixel, which is what a rasteriser is allowed to do at a triangle edge. A
// plain per-pixel compare would reject a correct image wherever two quadrants meet.
//
// A pixel passes if it matches any of the nine reference pixels around it, or any of
// 28 bilinear samples taken at fixed sub-pixel offsets nearby. The comparison is run
// both ways round, because "result matches somewhere in reference" alone would accept a
// result that has lost detail the reference has.

use super::pixel::{ConstPixelBufferAccess, PixelBufferAccess};
use super::texture::{ChannelOrder, ChannelType, TextureFormat};

/// Number of subpixel bits used when doing bilinear interpolation.
const NUM_SUBPIXEL_BITS: u32 = 8;

/// `s_offsets` - the sub-pixel positions the bilinear samples are taken at. Upstream
/// leaves a note that they are not optimised; they are reproduced exactly, because a
/// different set accepts a different set of images.
const SAMPLE_OFFSETS: [[u32; 2]; 28] = [
    [226, 186],
    [335, 235],
    [279, 334],
    [178, 272],
    [112, 202],
    [306, 117],
    [396, 299],
    [206, 382],
    [146, 96],
    [423, 155],
    [361, 412],
    [84, 339],
    [48, 130],
    [367, 43],
    [455, 367],
    [105, 439],
    [83, 46],
    [217, 24],
    [461, 71],
    [450, 459],
    [239, 469],
    [67, 267],
    [459, 255],
    [13, 416],
    [10, 192],
    [141, 502],
    [503, 304],
    [380, 506],
];

fn rgba8_format() -> TextureFormat {
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)
}

/// `readRGBA8Raw` - the four bytes of a texel, in memory order.
fn read_rgba8(access: &ConstPixelBufferAccess<'_>, x: u32, y: u32) -> [u8; 4] {
    let pitch = access.pitch();
    let offset = y as usize * pitch[1] + x as usize * 4;
    let bytes = &access.raw()[offset..offset + 4];
    [bytes[0], bytes[1], bytes[2], bytes[3]]
}

/// `compareThreshold` - equal, or differing by no more than the threshold in every
/// channel.
fn compare_threshold(a: [u8; 4], b: [u8; 4], threshold: [u8; 4]) -> bool {
    (0..4).all(|i| a[i].abs_diff(b[i]) <= threshold[i])
}

/// `interpolateChannel` - fixed-point bilinear interpolation of one channel.
fn interpolate_channel(fx1: u32, fy1: u32, p00: u8, p01: u8, p10: u8, p11: u8) -> u8 {
    let fx0 = (1u32 << NUM_SUBPIXEL_BITS) - fx1;
    let fy0 = (1u32 << NUM_SUBPIXEL_BITS) - fy1;
    let half = 1u32 << (NUM_SUBPIXEL_BITS * 2 - 1);
    let sum = fx0 * fy0 * u32::from(p00)
        + fx1 * fy0 * u32::from(p10)
        + fx0 * fy1 * u32::from(p01)
        + fx1 * fy1 * u32::from(p11);
    ((sum + half) >> (NUM_SUBPIXEL_BITS * 2)) as u8
}

/// `bilinearSampleRGBA8` - `u` and `v` are in sub-pixel units.
fn bilinear_sample(access: &ConstPixelBufferAccess<'_>, u: u32, v: u32) -> [u8; 4] {
    let x0 = u >> NUM_SUBPIXEL_BITS;
    let y0 = v >> NUM_SUBPIXEL_BITS;
    let x1 = x0 + 1;
    let y1 = y0 + 1;
    let fx1 = u - (x0 << NUM_SUBPIXEL_BITS);
    let fy1 = v - (y0 << NUM_SUBPIXEL_BITS);

    let p00 = read_rgba8(access, x0, y0);
    let p10 = read_rgba8(access, x1, y0);
    let p01 = read_rgba8(access, x0, y1);
    let p11 = read_rgba8(access, x1, y1);

    let mut out = [0u8; 4];
    for (channel, byte) in out.iter_mut().enumerate() {
        *byte = interpolate_channel(fx1, fy1, p00[channel], p01[channel], p10[channel], p11[channel]);
    }
    out
}

/// `comparePixelRGBA8` - whether the result pixel at (x, y) is explainable by the
/// reference somewhere in its immediate neighbourhood.
fn compare_pixel(
    reference: &ConstPixelBufferAccess<'_>,
    result: &ConstPixelBufferAccess<'_>,
    threshold: [u8; 4],
    x: i32,
    y: i32,
) -> bool {
    let [ref_w, ref_h, _] = reference.size();
    let res_pix = read_rgba8(result, x as u32, y as u32);

    // Step 1: the 3x3 neighbourhood.
    let x0 = (x - 1).max(0) as u32;
    let x1 = x as u32;
    let x2 = (x + 1).min(ref_w as i32 - 1) as u32;
    let y0 = (y - 1).max(0) as u32;
    let y1 = y as u32;
    let y2 = (y + 1).min(ref_h as i32 - 1) as u32;
    for (nx, ny) in [
        (x1, y1),
        (x0, y1),
        (x2, y1),
        (x0, y0),
        (x1, y0),
        (x2, y0),
        (x0, y2),
        (x1, y2),
        (x2, y2),
    ] {
        if compare_threshold(res_pix, read_rgba8(reference, nx, ny), threshold) {
            return true;
        }
    }

    // Step 2: bilinear samples at fixed offsets, which catches a result whose edge
    // landed between two reference pixels rather than on one.
    for offset in SAMPLE_OFFSETS {
        let u = (x << NUM_SUBPIXEL_BITS) + offset[0] as i32 - (1 << NUM_SUBPIXEL_BITS);
        let v = (y << NUM_SUBPIXEL_BITS) + offset[1] as i32 - (1 << NUM_SUBPIXEL_BITS);
        if u < 0
            || v < 0
            || u >= ((ref_w as i32 - 1) << NUM_SUBPIXEL_BITS)
            || v >= ((ref_h as i32 - 1) << NUM_SUBPIXEL_BITS)
        {
            continue;
        }
        if compare_threshold(res_pix, bilinear_sample(reference, u as u32, v as u32), threshold) {
            return true;
        }
    }

    false
}

/// `bilinearCompare`. `error_mask`, when given, is filled green where the pixel passed
/// and red where it did not.
pub fn bilinear_compare(
    reference: &ConstPixelBufferAccess<'_>,
    result: &ConstPixelBufferAccess<'_>,
    mut error_mask: Option<&mut PixelBufferAccess<'_>>,
    threshold: [u8; 4],
) -> bool {
    assert_eq!(
        reference.size(),
        result.size(),
        "bilinear compare needs images of one size"
    );
    assert_eq!(
        reference.format(),
        rgba8_format(),
        "bilinear compare only handles RGBA8"
    );
    assert_eq!(result.format(), rgba8_format(), "bilinear compare only handles RGBA8");

    if let Some(mask) = error_mask.as_deref_mut() {
        let [w, h, _] = mask.size();
        for y in 0..h {
            for x in 0..w {
                mask.set_pixel([0.0, 1.0, 0.0, 1.0], x, y, 0);
            }
        }
    }

    let [width, height, _] = reference.size();
    let mut all_ok = true;
    for y in 0..height as i32 {
        for x in 0..width as i32 {
            // Both directions: "result is explainable by reference" alone would accept
            // a result that dropped detail the reference has.
            if !compare_pixel(reference, result, threshold, x, y) && !compare_pixel(result, reference, threshold, x, y)
            {
                all_ok = false;
                if let Some(mask) = error_mask.as_deref_mut() {
                    mask.set_pixel([1.0, 0.0, 0.0, 1.0], x as u32, y as u32, 0);
                }
            }
        }
    }

    all_ok
}

#[cfg(test)]
mod tests {
    use super::*;

    fn solid(width: u32, height: u32, colour: [u8; 4]) -> Vec<u8> {
        let mut data = vec![0u8; (width * height * 4) as usize];
        for pixel in data.as_chunks_mut::<4>().0 {
            pixel.copy_from_slice(&colour);
        }
        data
    }

    #[test]
    fn identical_images_match() {
        let data = solid(8, 8, [10, 20, 30, 40]);
        let a = ConstPixelBufferAccess::new(rgba8_format(), [8, 8, 1], &data);
        assert!(bilinear_compare(&a, &a, None, [0, 0, 0, 0]));
    }

    #[test]
    fn a_wholly_different_image_does_not_match() {
        let a_data = solid(8, 8, [0, 0, 0, 255]);
        let b_data = solid(8, 8, [255, 255, 255, 255]);
        let a = ConstPixelBufferAccess::new(rgba8_format(), [8, 8, 1], &a_data);
        let b = ConstPixelBufferAccess::new(rgba8_format(), [8, 8, 1], &b_data);
        assert!(!bilinear_compare(&a, &b, None, [1, 1, 1, 1]));
    }

    /// The whole point of the comparison: an edge that moved by one pixel is accepted,
    /// which a plain per-pixel compare would reject.
    #[test]
    fn an_edge_shifted_by_one_pixel_matches() {
        let mut a_data = solid(8, 8, [0, 0, 0, 255]);
        let mut b_data = solid(8, 8, [0, 0, 0, 255]);
        for y in 0..8u32 {
            for x in 0..8u32 {
                let ndx = ((y * 8 + x) * 4) as usize;
                if x >= 4 {
                    a_data[ndx] = 255;
                }
                if x >= 5 {
                    b_data[ndx] = 255;
                }
            }
        }
        let a = ConstPixelBufferAccess::new(rgba8_format(), [8, 8, 1], &a_data);
        let b = ConstPixelBufferAccess::new(rgba8_format(), [8, 8, 1], &b_data);
        assert!(bilinear_compare(&a, &b, None, [1, 1, 1, 1]));
    }

    #[test]
    fn the_error_mask_marks_the_pixels_that_failed() {
        let a_data = solid(4, 4, [0, 0, 0, 255]);
        let b_data = solid(4, 4, [255, 255, 255, 255]);
        let a = ConstPixelBufferAccess::new(rgba8_format(), [4, 4, 1], &a_data);
        let b = ConstPixelBufferAccess::new(rgba8_format(), [4, 4, 1], &b_data);
        let mut mask_data = vec![0u8; 4 * 4 * 4];
        let mut mask = PixelBufferAccess::new(rgba8_format(), [4, 4, 1], &mut mask_data);
        assert!(!bilinear_compare(&a, &b, Some(&mut mask), [1, 1, 1, 1]));
        assert_eq!(mask.as_const().get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0]);
    }
}

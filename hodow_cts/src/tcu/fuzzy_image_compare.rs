// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuFuzzyImageCompare.cpp
//   framework/common/tcuImageCompare.cpp (the fuzzyCompare wrapper)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The comparison the rendering tests use when a per-pixel threshold would be too
// strict: both images are blurred, then each sampled pixel is matched against its
// neighbourhood in the other image - including 32 randomly placed bilinear samples -
// and the smallest distance found is what counts. A one-pixel shift in an edge
// therefore costs almost nothing, while a wrong colour costs a lot.
//
// The random sequence is part of the result, so `de::Random(667)` and the order of
// the draws from it have to match upstream exactly.

use super::pixel::ConstPixelBufferAccess;
use super::random::Random;
use super::texture::{ChannelOrder, ChannelType, TextureFormat};

/// `MIN_ERR_THRESHOLD` - magic to make small differences go away.
const MIN_ERR_THRESHOLD: i32 = 4;

/// `FuzzyCompareParams`
pub struct FuzzyCompareParams {
    pub max_sample_skip: i32,
    pub return_max_error: bool,
}

impl Default for FuzzyCompareParams {
    fn default() -> Self {
        Self {
            max_sample_skip: 8,
            return_max_error: false,
        }
    }
}

/// A pixel as the comparison handles it: four 8-bit channels packed little-endian,
/// which is what `readUnorm8` produces and what every distance below works on.
type Rgba8 = u32;

fn channel(color: Rgba8, c: usize) -> u8 {
    ((color >> (c * 8)) & 0xFF) as u8
}

fn set_channel(color: Rgba8, c: usize, val: u8) -> Rgba8 {
    (color & !(0xFFu32 << (8 * c))) | (u32::from(val) << (8 * c))
}

fn round_to_uint8_sat(v: f32) -> u8 {
    ((v + 0.5) as i32).clamp(0, 255) as u8
}

fn to_color(v: [f32; 4]) -> Rgba8 {
    u32::from(round_to_uint8_sat(v[0]))
        | (u32::from(round_to_uint8_sat(v[1])) << 8)
        | (u32::from(round_to_uint8_sat(v[2])) << 16)
        | (u32::from(round_to_uint8_sat(v[3])) << 24)
}

/// `readUnorm8` - the raw bytes, with alpha forced opaque for a three-channel source.
fn read_unorm8(src: &ConstPixelBufferAccess<'_>, num_channels: usize, x: i32, y: i32) -> Rgba8 {
    let p = src.pixel(x as u32, y as u32, 0);
    let mut v = 0u32;
    for (c, byte) in p.iter().take(num_channels).enumerate() {
        v |= u32::from(*byte) << (c * 8);
    }
    if num_channels < 4 {
        v |= 0xFFu32 << 24;
    }
    v
}

/// `colorDistSquared` - the squared distance, with each channel's first few steps
/// forgiven outright.
fn color_dist_squared(pa: Rgba8, pb: Rgba8) -> u32 {
    let d = |c: usize| {
        (i32::from(channel(pa, c)) - i32::from(channel(pb, c)))
            .abs()
            .saturating_sub(MIN_ERR_THRESHOLD)
            .max(0)
    };
    let (r, g, b, a) = (d(0), d(1), d(2), d(3));
    (r * r + g * g + b * b + a * a) as u32
}

/// `bilinearSample`, over the packed byte view.
fn bilinear_sample(src: &[Rgba8], w: i32, h: i32, u: f32, v: f32) -> Rgba8 {
    let x0 = (u - 0.5).floor() as i32;
    let y0 = (v - 0.5).floor() as i32;
    let i0 = x0.clamp(0, w - 1);
    let i1 = (x0 + 1).clamp(0, w - 1);
    let j0 = y0.clamp(0, h - 1);
    let j1 = (y0 + 1).clamp(0, h - 1);

    let a = (u - 0.5) - (u - 0.5).floor();
    let b = (v - 0.5) - (v - 0.5).floor();

    let at = |x: i32, y: i32| src[(y * w + x) as usize];
    let (p00, p10, p01, p11) = (at(i0, j0), at(i1, j0), at(i0, j1), at(i1, j1));

    let mut dst = 0u32;
    for c in 0..4 {
        let f = f32::from(channel(p00, c)) * (1.0 - a) * (1.0 - b)
            + f32::from(channel(p10, c)) * a * (1.0 - b)
            + f32::from(channel(p01, c)) * (1.0 - a) * b
            + f32::from(channel(p11, c)) * a * b;
        dst = set_channel(dst, c, round_to_uint8_sat(f));
    }
    dst
}

/// `separableConvolve` with the fixed {0.1, 0.8, 0.1} kernel.
///
/// The horizontal pass writes its temporary column-wise, which the vertical pass then
/// reads back transposed - a detail that matters only because the rounding to 8 bits
/// happens in between, so the two passes are not interchangeable.
fn separable_convolve(src: &ConstPixelBufferAccess<'_>, src_channels: usize, width: i32, height: i32) -> Vec<Rgba8> {
    const KERNEL: [f32; 3] = [0.1, 0.8, 0.1];
    let shift = (KERNEL.len() as i32 - 1) / 2;

    // `tmp` is (height x width), addressed as tmp[i * height + j].
    let mut tmp = vec![0u32; (width * height) as usize];
    for j in 0..height {
        for i in 0..width {
            let mut sum = [0.0f32; 4];
            for (kx, _) in KERNEL.iter().enumerate() {
                let f = KERNEL[KERNEL.len() - kx - 1];
                let p = read_unorm8(src, src_channels, (i + kx as i32 - shift).clamp(0, width - 1), j);
                for (c, s) in sum.iter_mut().enumerate() {
                    *s += f32::from(channel(p, c)) * f;
                }
            }
            tmp[(i * height + j) as usize] = to_color(sum);
        }
    }

    let mut dst = vec![0u32; (width * height) as usize];
    for j in 0..height {
        for i in 0..width {
            let mut sum = [0.0f32; 4];
            for (ky, _) in KERNEL.iter().enumerate() {
                let f = KERNEL[KERNEL.len() - ky - 1];
                // tmp is width-tall and height-wide, so the clamp is against `height`.
                let p = tmp[(i * height + (j + ky as i32 - shift).clamp(0, height - 1)) as usize];
                for (c, s) in sum.iter_mut().enumerate() {
                    *s += f32::from(channel(p, c)) * f;
                }
            }
            dst[(j * width + i) as usize] = to_color(sum);
        }
    }
    dst
}

/// `distSquaredToNeighbor` - the eight neighbours, then 32 random bilinear samples.
fn dist_squared_to_neighbor(rnd: &mut Random, pixel: Rgba8, surface: &[Rgba8], w: i32, h: i32, x: i32, y: i32) -> u32 {
    let at = |x: i32, y: i32| surface[(y * w + x) as usize];

    let mut min_dist = color_dist_squared(pixel, at(x, y));
    if min_dist == 0 {
        return 0;
    }

    const COORDS: [(i32, i32); 8] = [(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1)];
    for (ox, oy) in COORDS {
        let (dx, dy) = (x + ox, y + oy);
        if dx < 0 || dx >= w || dy < 0 || dy >= h {
            continue;
        }
        min_dist = min_dist.min(color_dist_squared(pixel, at(dx, dy)));
        if min_dist == 0 {
            return 0;
        }
    }

    for _ in 0..32 {
        let dx = x as f32 + rnd.get_float() * 2.0 - 0.5;
        let dy = y as f32 + rnd.get_float() * 2.0 - 0.5;
        let sample = bilinear_sample(surface, w, h, dx, dy);
        min_dist = min_dist.min(color_dist_squared(pixel, sample));
        if min_dist == 0 {
            return 0;
        }
    }

    min_dist
}

/// `isFormatSupported`
fn is_format_supported(format: TextureFormat) -> bool {
    format.type_ == ChannelType::UNORM_INT8 && matches!(format.order, ChannelOrder::RGB | ChannelOrder::RGBA)
}

/// `tcu::fuzzyCompare` - the error figure, not the verdict.
///
/// The error mask upstream also fills is not built: nothing here reads it, and it
/// consumes no randomness, so leaving it out cannot move the number.
pub fn fuzzy_compare(
    params: &FuzzyCompareParams,
    reference: &ConstPixelBufferAccess<'_>,
    cmp: &ConstPixelBufferAccess<'_>,
) -> Option<f32> {
    if !is_format_supported(reference.format()) || !is_format_supported(cmp.format()) {
        return None;
    }
    let [w, h, _] = reference.size();
    let (width, height) = (w as i32, h as i32);
    let mut rnd = Random::new(667);

    let ref_channels = if reference.format().order == ChannelOrder::RGBA {
        4
    } else {
        3
    };
    let cmp_channels = if cmp.format().order == ChannelOrder::RGBA { 4 } else { 3 };
    let ref_filtered = separable_convolve(reference, ref_channels, width, height);
    let cmp_filtered = separable_convolve(cmp, cmp_channels, width, height);

    let mut num_samples = 0u64;
    let mut dist_sum4 = 0u64;
    let mut dist_max2 = 0u32;

    for y in 1..height - 1 {
        let mut x = 1;
        while x < width - 1 {
            let a = dist_squared_to_neighbor(
                &mut rnd,
                ref_filtered[(y * width + x) as usize],
                &cmp_filtered,
                width,
                height,
                x,
                y,
            );
            let b = dist_squared_to_neighbor(
                &mut rnd,
                cmp_filtered[(y * width + x) as usize],
                &ref_filtered,
                width,
                height,
                x,
                y,
            );
            let min_dist2 = a.min(b);

            let term = u64::from(min_dist2) * u64::from(min_dist2);
            // In case of overflow - upstream saturates rather than wrapping here.
            dist_sum4 = dist_sum4.saturating_add(term);
            dist_max2 = dist_max2.max(min_dist2);
            num_samples += 1;

            x += if params.max_sample_skip > 0 {
                rnd.get_int(1, params.max_sample_skip)
            } else {
                1
            };
        }
    }

    if params.return_max_error {
        return Some((dist_max2 as f32).sqrt() / 255.0);
    }

    // Scale error sum based on number of samples taken
    let p_samples = f64::from((width - 2) * (height - 2)) / num_samples as f64;
    let col_scale = (255 - MIN_ERR_THRESHOLD) as u64;
    let col_scale4 = col_scale * col_scale * col_scale * col_scale;
    Some((dist_sum4 as f64 / col_scale4 as f64 * p_samples) as f32)
}

/// `tcu::fuzzyCompare(log, ...)` - the verdict.
pub fn fuzzy_compare_ok(
    reference: &ConstPixelBufferAccess<'_>,
    cmp: &ConstPixelBufferAccess<'_>,
    threshold: f32,
) -> Option<bool> {
    fuzzy_compare(&FuzzyCompareParams::default(), reference, cmp).map(|difference| difference <= threshold)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::TextureLevel;

    fn level(width: u32, height: u32, f: impl Fn(u32, u32) -> [f32; 4]) -> TextureLevel {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut level = TextureLevel::new(format, width, height, 1).unwrap();
        for y in 0..height {
            for x in 0..width {
                level.get_access().set_pixel(f(x, y), x, y, 0);
            }
        }
        level
    }

    /// An image compared against itself has no error at all.
    #[test]
    fn identical_images_score_zero() {
        let a = level(32, 32, |x, y| [x as f32 / 32.0, y as f32 / 32.0, 0.5, 1.0]);
        let access = a.get_const_access();
        let d = fuzzy_compare(&FuzzyCompareParams::default(), &access, &access).unwrap();
        assert_eq!(d, 0.0, "{d}");
    }

    /// The whole point of the metric: an edge moved by one pixel is nearly free,
    /// while recolouring the same area is not. Without that ordering the comparison
    /// would be no better than a per-pixel threshold.
    #[test]
    fn a_shifted_edge_costs_far_less_than_a_wrong_colour() {
        let split = |at: u32| {
            level(32, 32, |x, _| {
                if x < at {
                    [1.0, 0.0, 0.0, 1.0]
                } else {
                    [0.0, 1.0, 0.0, 1.0]
                }
            })
        };
        let a = split(16);
        let b = split(17);
        let wrong = level(32, 32, |x, _| {
            if x < 16 {
                [1.0, 0.0, 0.0, 1.0]
            } else {
                [0.0, 0.0, 1.0, 1.0]
            }
        });

        let shifted = fuzzy_compare(
            &FuzzyCompareParams::default(),
            &a.get_const_access(),
            &b.get_const_access(),
        )
        .unwrap();
        let recoloured = fuzzy_compare(
            &FuzzyCompareParams::default(),
            &a.get_const_access(),
            &wrong.get_const_access(),
        )
        .unwrap();
        assert!(
            shifted < recoloured / 100.0,
            "shifted={shifted} recoloured={recoloured}"
        );
        assert!(
            shifted <= 0.01,
            "a one-pixel shift must pass the usual threshold: {shifted}"
        );
        assert!(recoloured > 0.01, "a wrong colour must not: {recoloured}");
    }

    /// A format the comparison cannot read is refused rather than approximated.
    #[test]
    fn unsupported_format_is_refused() {
        let format = TextureFormat::new(ChannelOrder::R, ChannelType::FLOAT);
        let a = TextureLevel::new(format, 4, 4, 1).unwrap();
        let access = a.get_const_access();
        assert!(fuzzy_compare(&FuzzyCompareParams::default(), &access, &access).is_none());
    }
}

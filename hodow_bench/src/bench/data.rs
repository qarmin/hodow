//! Deterministic inputs and the scalar reference every backend is checked against.
//!
//! The synthetic frame looks like what the eye-tracking camera sees - a gradient, an iris,
//! a dark pupil, two bright corneal reflections and noise - so a kernel that is wrong at
//! an edge or off by a pixel shows up, which a uniform image would hide.

/// Weights of a gaussian of `radius` taps each side, summing to exactly 256.
pub fn gaussian_weights(radius: usize) -> Vec<u16> {
    if radius == 0 {
        return vec![256];
    }
    let sigma = (radius as f64 / 3.0).max(0.5);
    let raw: Vec<f64> = (0..=2 * radius)
        .map(|i| (-((i as f64 - radius as f64).powi(2)) / (2.0 * sigma * sigma)).exp())
        .collect();
    let sum: f64 = raw.iter().sum();
    let mut weights: Vec<u16> = raw.iter().map(|v| (v / sum * 256.0).round() as u16).collect();
    let total: i32 = weights.iter().map(|&w| i32::from(w)).sum();
    weights[radius] = (i32::from(weights[radius]) + 256 - total) as u16;
    debug_assert!(weights[radius] < 256, "a center weight of 256 would only be radius 0");
    weights
}

fn hash(x: u32, y: u32, seed: u32) -> u32 {
    let mut h = x.wrapping_mul(0x9E37_79B1) ^ y.wrapping_mul(0x85EB_CA77) ^ seed.wrapping_mul(0xC2B2_AE3D);
    h ^= h >> 15;
    h = h.wrapping_mul(0x2C1B_3C6D);
    h ^= h >> 12;
    h = h.wrapping_mul(0x297A_2D39);
    h ^ (h >> 15)
}

/// A rectangle of a larger frame: while one is set on this thread the generators produce that
/// rectangle's pixels of the `frame_w` x `frame_h` scene instead of a whole frame of their own.
/// `x0` and `y0` must be even, or a Bayer tile starts mid-quad.
#[derive(Clone, Copy, Debug)]
pub struct Tile {
    pub x0: u32,
    pub y0: u32,
    pub frame_w: u32,
    pub frame_h: u32,
}

thread_local! {
    static TILE: std::cell::Cell<Option<Tile>> = const { std::cell::Cell::new(None) };
}

pub fn with_tile<R>(tile: Tile, f: impl FnOnce() -> R) -> R {
    let previous = TILE.replace(Some(tile));
    let result = f();
    TILE.set(previous);
    result
}

/// Scene luminance in 0..=1 at a pixel of a `width` x `height` frame.
fn luminance(x: u32, y: u32, width: u32, height: u32) -> f32 {
    let (x, y, width, height) = match TILE.get() {
        Some(t) => (x + t.x0, y + t.y0, t.frame_w, t.frame_h),
        None => (x, y, width, height),
    };
    let u = x as f32 / width as f32;
    let v = y as f32 / height as f32;
    let aspect = width as f32 / height as f32;
    let dist = |cx: f32, cy: f32| (((u - cx) * aspect).powi(2) + (v - cy).powi(2)).sqrt();
    let mut lum = 0.25 + 0.3 * u + 0.08 * (v * 14.0).sin();
    let iris = dist(0.5, 0.5);
    if iris < 0.32 {
        lum *= 0.55 + 0.25 * (iris / 0.32) + 0.05 * (u * 90.0).sin();
    }
    if iris < 0.11 {
        lum = 0.04;
    }
    if dist(0.46, 0.44) < 0.015 || dist(0.55, 0.43) < 0.012 {
        lum = 1.0;
    }
    let noise = (hash(x, y, 1) & 0xFFFF) as f32 / 65535.0 - 0.5;
    (lum + noise * 0.06).clamp(0.0, 1.0)
}

/// An RGGB 10-bit frame, one `u16` per photosite in the low 10 bits.
pub fn bayer_rg10(width: u32, height: u32) -> Vec<u16> {
    let mut out = Vec::with_capacity((width * height) as usize);
    for y in 0..height {
        for x in 0..width {
            let gain = match (y & 1, x & 1) {
                (0, 0) => 0.9,
                (1, 1) => 0.72,
                _ => 1.0,
            };
            let lum = luminance(x / 2 * 2, y / 2 * 2, width, height);
            out.push((lum * gain * 1023.0).round() as u16);
        }
    }
    out
}

pub fn gray_u8(width: u32, height: u32) -> Vec<u8> {
    (0..height)
        .flat_map(|y| (0..width).map(move |x| (luminance(x, y, width, height) * 255.0).round() as u8))
        .collect()
}

pub fn random_bytes(len: usize) -> Vec<u8> {
    (0..len)
        .map(|i| hash(i as u32, (i as u64 >> 32) as u32, 7) as u8)
        .collect()
}

/// One gray pixel per 2x2 quad: `(77 R + 75 G1 + 75 G2 + 29 B) >> 10`, i.e. BT.601 luma
/// of the quad, scaled from 10 to 8 bits.
#[inline]
pub fn debayer_quad(r: u16, g1: u16, g2: u16, b: u16) -> u8 {
    ((77 * u32::from(r) + 75 * (u32::from(g1) + u32::from(g2)) + 29 * u32::from(b)) >> 10) as u8
}

pub fn reference_debayer(src: &[u16], width: usize, height: usize) -> Vec<u8> {
    let (ow, oh) = (width / 2, height / 2);
    let mut out = vec![0u8; ow * oh];
    for y in 0..oh {
        for x in 0..ow {
            let i = 2 * y * width + 2 * x;
            out[y * ow + x] = debayer_quad(src[i], src[i + 1], src[i + width], src[i + width + 1]);
        }
    }
    out
}

/// Horizontal sums kept unrounded (they fit in `u16` because the weights sum to 256),
/// then `(vertical + 32768) >> 16`. Equal, bit for bit, to the full 2D window.
pub fn reference_blur(src: &[u8], width: usize, height: usize, weights: &[u16]) -> Vec<u8> {
    let r = weights.len() / 2;
    let mut tmp = vec![0u16; width * height];
    for y in 0..height {
        for x in 0..width {
            let mut acc = 0u32;
            for (k, &w) in weights.iter().enumerate() {
                let xx = (x + k).saturating_sub(r).min(width - 1);
                acc += u32::from(w) * u32::from(src[y * width + xx]);
            }
            tmp[y * width + x] = acc as u16;
        }
    }
    let mut out = vec![0u8; width * height];
    for y in 0..height {
        for x in 0..width {
            let mut acc = 0u32;
            for (k, &w) in weights.iter().enumerate() {
                let yy = (y + k).saturating_sub(r).min(height - 1);
                acc += u32::from(w) * u32::from(tmp[yy * width + x]);
            }
            out[y * width + x] = ((acc + 32768) >> 16) as u8;
        }
    }
    out
}

/// Gray in the Y plane, neutral chroma in the interleaved UV plane.
pub fn nv12_from_gray(gray: &[u8]) -> Vec<u8> {
    let mut out = gray.to_vec();
    out.resize(gray.len() + gray.len() / 2, 128);
    out
}

/// A pixel darker than this belongs to the pupil.
pub const PUPIL_BELOW: u8 = 40;
/// A pixel brighter than this belongs to a corneal reflection.
pub const GLINT_ABOVE: u8 = 230;
/// The eye pipeline's blur.
pub const EYE_RADIUS: usize = 2;

fn at(src: &[u8], w: usize, h: usize, x: isize, y: isize) -> u8 {
    src[(y.clamp(0, h as isize - 1) as usize) * w + x.clamp(0, w as isize - 1) as usize]
}

/// 255 where the pixel and its eight neighbours (clamped) are all below the pupil
/// threshold - threshold and erosion in one pass.
pub fn reference_erode(src: &[u8], w: usize, h: usize) -> Vec<u8> {
    let mut out = vec![0u8; w * h];
    for y in 0..h as isize {
        for x in 0..w as isize {
            let all = (-1..=1).all(|dy| (-1..=1).all(|dx| at(src, w, h, x + dx, y + dy) < PUPIL_BELOW));
            out[y as usize * w + x as usize] = if all { 255 } else { 0 };
        }
    }
    out
}

/// 255 where any pixel of the 3x3 neighbourhood (clamped) is set.
pub fn reference_dilate(src: &[u8], w: usize, h: usize) -> Vec<u8> {
    let mut out = vec![0u8; w * h];
    for y in 0..h as isize {
        for x in 0..w as isize {
            let any = (-1..=1).any(|dy| (-1..=1).any(|dx| at(src, w, h, x + dx, y + dy) != 0));
            out[y as usize * w + x as usize] = if any { 255 } else { 0 };
        }
    }
    out
}

/// |gx| + |gy| of the 3x3 Sobel operator, clamped to the image, saturated at 255.
pub fn reference_sobel(src: &[u8], w: usize, h: usize) -> Vec<u8> {
    let mut out = vec![0u8; w * h];
    for y in 0..h as isize {
        for x in 0..w as isize {
            let p = |dx, dy| i32::from(at(src, w, h, x + dx, y + dy));
            let gx = p(1, -1) + 2 * p(1, 0) + p(1, 1) - p(-1, -1) - 2 * p(-1, 0) - p(-1, 1);
            let gy = p(-1, 1) + 2 * p(0, 1) + p(1, 1) - p(-1, -1) - 2 * p(0, -1) - p(1, -1);
            out[y as usize * w + x as usize] = (gx.abs() + gy.abs()).min(255) as u8;
        }
    }
    out
}

/// 256 bins, as little-endian `u32`s.
pub fn reference_histogram(src: &[u8]) -> Vec<u8> {
    let mut bins = [0u32; 256];
    for &v in src {
        bins[v as usize] += 1;
    }
    bins.iter().flat_map(|b| b.to_le_bytes()).collect()
}

/// Per row: pupil pixel count and sum of their x, glint count and sum of x - four
/// little-endian `u32`s, from which the host takes both centroids. The pupil comes from a
/// mask (non-zero) or straight from gray (below the threshold).
pub fn reference_moments(pupil: &[u8], glint: &[u8], w: usize, h: usize, pupil_is_mask: bool) -> Vec<u8> {
    let mut out = Vec::with_capacity(h * 16);
    for y in 0..h {
        let mut m = [0u32; 4];
        for x in 0..w {
            let p = pupil[y * w + x];
            if if pupil_is_mask { p != 0 } else { p < PUPIL_BELOW } {
                m[0] += 1;
                m[1] += x as u32;
            }
            if glint[y * w + x] > GLINT_ABOVE {
                m[2] += 1;
                m[3] += x as u32;
            }
        }
        out.extend(m.iter().flat_map(|v| v.to_le_bytes()));
    }
    out
}

/// The eye-tracking frame: RG10 -> gray -> blur -> opened pupil mask -> per-row moments of
/// the pupil (from the mask) and the glints (from the blurred gray).
pub fn reference_eye(bayer: &[u16], width: usize, height: usize) -> Vec<u8> {
    let (w, h) = (width / 2, height / 2);
    let gray = reference_blur(
        &reference_debayer(bayer, width, height),
        w,
        h,
        &gaussian_weights(EYE_RADIUS),
    );
    let mask = reference_dilate(&reference_erode(&gray, w, h), w, h);
    reference_moments(&mask, &gray, w, h, true)
}

/// n x n matrices A and B: small integers, or in f32 multiples of 1/16 below 1.
pub fn gemm_inputs(n: u32, float: bool) -> (Vec<u32>, Vec<u32>) {
    let make = |seed: u32| -> Vec<u32> {
        (0..n * n)
            .map(|i| {
                let v = hash(i, n, seed) % 16;
                if float {
                    (v as f32 / 16.0).to_bits()
                } else {
                    (v as i32 - 8) as u32
                }
            })
            .collect()
    };
    (make(11), make(12))
}

pub fn reference_gemm(a: &[u32], b: &[u32], n: usize, float: bool) -> Vec<u8> {
    let mut out = Vec::with_capacity(n * n * 4);
    for i in 0..n {
        for j in 0..n {
            let v = if float {
                (0..n)
                    .map(|k| f32::from_bits(a[i * n + k]) * f32::from_bits(b[k * n + j]))
                    .sum::<f32>()
                    .to_bits()
            } else {
                (0..n).fold(0i32, |acc, k| {
                    acc.wrapping_add((a[i * n + k] as i32).wrapping_mul(b[k * n + j] as i32))
                }) as u32
            };
            out.extend(v.to_le_bytes());
        }
    }
    out
}

pub fn words(n: u32, seed: u32) -> Vec<u32> {
    (0..n).map(|i| hash(i, 0, seed)).collect()
}

/// The point of the complex plane a pixel samples, in 12-bit fixed point.
pub fn mandel_point(x: u32, y: u32, width: u32, height: u32) -> (i32, i32) {
    let cr = -2 * 4096 + (x as i32 * 3 * 4096) / width as i32;
    let ci = -4096 - 512 + (y as i32 * 9 * 512) / height as i32;
    (cr, ci)
}

/// Iterations before |z| exceeds 2, capped, as one byte per pixel (saturated at 255).
pub fn mandel_count(cr: i32, ci: i32, iters: u32) -> u8 {
    let (mut zr, mut zi) = (0i32, 0i32);
    let mut n = 0;
    while n < iters {
        let (zr2, zi2) = (zr * zr, zi * zi);
        if zr2 + zi2 > 4 << 24 {
            break;
        }
        let zri = zr * zi;
        zi = (zri >> 11) + ci;
        zr = ((zr2 - zi2) >> 12) + cr;
        n += 1;
    }
    n.min(255) as u8
}

/// One element of an `Alu` row: `rounds` steps of an LCG (u32) or of x = 0.999 x + 0.001.
pub fn alu_chain(seed: u32, rounds: u32, float: bool) -> u32 {
    if float {
        let mut x = (seed % 1024) as f32 / 1024.0;
        for _ in 0..rounds {
            x = x * 0.999 + 0.001;
        }
        x.to_bits()
    } else {
        let mut x = seed;
        for _ in 0..rounds {
            x = x.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
        }
        x
    }
}

pub fn u32_bytes(words: &[u32]) -> Vec<u8> {
    words.iter().flat_map(|w| w.to_le_bytes()).collect()
}

pub fn as_bytes(words: &[u16]) -> &[u8] {
    unsafe { std::slice::from_raw_parts(words.as_ptr().cast::<u8>(), std::mem::size_of_val(words)) }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn weights_sum_to_256() {
        for r in 0..=32 {
            let w = gaussian_weights(r);
            assert_eq!(w.len(), 2 * r + 1);
            assert_eq!(w.iter().map(|&v| u32::from(v)).sum::<u32>(), 256, "radius {r}");
        }
    }

    #[test]
    fn separable_equals_full_window() {
        let (w, h) = (37, 23);
        let src = gray_u8(w as u32, h as u32);
        for r in [0usize, 1, 3, 8] {
            let weights = gaussian_weights(r);
            let separable = reference_blur(&src, w, h, &weights);
            for y in 0..h {
                for x in 0..w {
                    let mut acc = 0u64;
                    for (j, &wy) in weights.iter().enumerate() {
                        let yy = (y + j).saturating_sub(r).min(h - 1);
                        for (i, &wx) in weights.iter().enumerate() {
                            let xx = (x + i).saturating_sub(r).min(w - 1);
                            acc += u64::from(wy) * u64::from(wx) * u64::from(src[yy * w + xx]);
                        }
                    }
                    assert_eq!(separable[y * w + x], ((acc + 32768) >> 16) as u8, "r={r} at {x},{y}");
                }
            }
        }
    }

    #[test]
    fn radius_zero_is_identity() {
        let src = gray_u8(16, 9);
        assert_eq!(reference_blur(&src, 16, 9, &gaussian_weights(0)), src);
    }
}

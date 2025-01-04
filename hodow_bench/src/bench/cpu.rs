//! The CPU side: every kernel at three levels of effort, split into row bands over threads.

use std::ops::Range;
use std::time::Instant;

use super::data::{
    EYE_RADIUS, GLINT_ABOVE, PUPIL_BELOW, alu_chain, as_bytes, bayer_rg10, debayer_quad, gaussian_weights, gemm_inputs,
    gray_u8, mandel_count, mandel_point, random_bytes, words,
};
use super::spec::{ALU_ROUNDS, CpuLevel, MANDEL_ITERS, Task};
use super::{Bench, FrameTimes};

/// What `Simd` means on this machine, or `None` when it has nothing for it.
pub fn simd_name() -> Option<&'static str> {
    #[cfg(target_arch = "aarch64")]
    return Some("neon");
    #[cfg(target_arch = "x86_64")]
    return is_x86_feature_detected!("avx2").then_some("avx2");
    #[allow(unreachable_code)]
    None
}

#[derive(Default)]
struct Scratch {
    rows: Vec<u16>,
    padded: Vec<u8>,
    acc: Vec<u32>,
}

enum Input {
    Bayer(Vec<u16>),
    Gray(Vec<u8>),
    Bytes(Vec<u8>),
    Words(Vec<u32>),
    Matrices(Vec<u32>, Vec<u32>),
    None,
}

pub struct CpuBench {
    task: Task,
    level: CpuLevel,
    threads: usize,
    input: Input,
    gray: Vec<u8>,
    /// Intermediate images of the eye pipeline and the morphology.
    blurred: Vec<u8>,
    eroded: Vec<u8>,
    out: Vec<u8>,
    weights: Vec<u16>,
    scratch: Vec<Scratch>,
    /// Single-threaded copies for a stream: each core takes whole frames.
    lanes: Vec<CpuBench>,
    sorted: Vec<u32>,
}

impl CpuBench {
    pub fn new(task: Task, level: CpuLevel, threads: u32) -> Result<CpuBench, String> {
        if matches!(task, Task::Cnn { .. }) {
            return Err("the network runs on TFLite only".into());
        }
        if level == CpuLevel::Simd && simd_name().is_none() {
            return Err("no SIMD implementation for this CPU".into());
        }
        if level == CpuLevel::Simd
            && !matches!(
                task,
                Task::Debayer { .. } | Task::Blur { .. } | Task::Pipeline { .. } | Task::Eye { .. }
            )
        {
            return Err("no hand-written SIMD for this kernel; autovec is the vectorized one".into());
        }
        let threads = threads.max(1) as usize;
        let pixels = task.size().map_or(0, |(w, h)| (w * h) as usize);
        let (input, gray_len, out_len) = match task {
            Task::Debayer { width, height } => (
                Input::Bayer(bayer_rg10(width, height)),
                0,
                (width * height / 4) as usize,
            ),
            Task::Blur { width, height, .. } => (Input::Gray(gray_u8(width, height)), 0, (width * height) as usize),
            Task::Pipeline { width, height, .. } => {
                let gray = (width * height / 4) as usize;
                (Input::Bayer(bayer_rg10(width, height)), gray, gray + gray / 2)
            }
            Task::Copy { bytes } | Task::Upload { bytes } | Task::Download { bytes } => {
                (Input::Bytes(random_bytes(bytes as usize)), 0, bytes as usize)
            }
            Task::Dispatch => (Input::None, 0, 0),
            Task::Morph { width, height } | Task::Sobel { width, height } => {
                (Input::Gray(gray_u8(width, height)), 0, pixels)
            }
            Task::Histogram { width, height } => (Input::Gray(gray_u8(width, height)), 0, 1024),
            Task::Moments { width, height } => (Input::Gray(gray_u8(width, height)), 0, height as usize * 16),
            Task::Eye { width, height } => (
                Input::Bayer(bayer_rg10(width, height)),
                pixels / 4,
                height as usize / 2 * 16,
            ),
            Task::Gemm { n, float } => {
                let (a, b) = gemm_inputs(n, float);
                (Input::Matrices(a, b), 0, (n * n * 4) as usize)
            }
            Task::Reduce { n } => (Input::Words(words(n, 21)), 0, 4),
            Task::Mandelbrot { .. } => (Input::None, 0, pixels),
            Task::Alu { n, .. } => (Input::Words(words(n, 31)), 0, n as usize * 4),
            Task::Sort { n } => (Input::Words(words(n, 41)), 0, n as usize * 4),
            Task::Cnn { .. } => unreachable!("refused above"),
        };
        let image = match task {
            Task::Eye { .. } => pixels / 4,
            Task::Morph { .. } => pixels,
            _ => 0,
        };
        Ok(CpuBench {
            task,
            level,
            threads,
            input,
            gray: vec![0; gray_len],
            blurred: vec![0; image],
            eroded: vec![0; image],
            out: vec![0; out_len],
            weights: gaussian_weights(if matches!(task, Task::Eye { .. }) {
                EYE_RADIUS
            } else {
                task.radius().unwrap_or(0) as usize
            }),
            scratch: (0..threads).map(|_| Scratch::default()).collect(),
            lanes: Vec::new(),
            sorted: Vec::new(),
        })
    }

    fn run(&mut self) {
        let (level, threads) = (self.level, self.threads);
        match (self.task, &self.input) {
            (Task::Debayer { width, .. }, Input::Bayer(src)) => {
                debayer(level, threads, src, width as usize, &mut self.out)
            }
            (Task::Blur { width, height, .. }, Input::Gray(src)) => blur(
                level,
                threads,
                src,
                width as usize,
                height as usize,
                &self.weights,
                &mut self.out,
                &mut self.scratch,
            ),
            (Task::Pipeline { width, height, .. }, Input::Bayer(src)) => {
                let (ow, oh) = (width as usize / 2, height as usize / 2);
                debayer(level, threads, src, width as usize, &mut self.gray);
                let (y_plane, uv) = self.out.split_at_mut(ow * oh);
                blur(
                    level,
                    threads,
                    &self.gray,
                    ow,
                    oh,
                    &self.weights,
                    y_plane,
                    &mut self.scratch,
                );
                uv.fill(128);
            }
            (Task::Copy { .. } | Task::Upload { .. } | Task::Download { .. }, Input::Bytes(src)) => {
                let out = std::hint::black_box(&mut self.out);
                let src = std::hint::black_box(src);
                out.copy_from_slice(src);
            }
            (Task::Morph { width, height }, Input::Gray(src)) => {
                let (w, h) = (width as usize, height as usize);
                erode(level, threads, src, w, h, &mut self.eroded);
                dilate(level, threads, &self.eroded, w, h, &mut self.out);
            }
            (Task::Sobel { width, height }, Input::Gray(src)) => {
                sobel(level, threads, src, width as usize, height as usize, &mut self.out)
            }
            (Task::Histogram { .. }, Input::Gray(src)) => histogram(level, threads, src, &mut self.out),
            (Task::Moments { width, height }, Input::Gray(src)) => moments(
                level,
                threads,
                src,
                src,
                width as usize,
                height as usize,
                false,
                &mut self.out,
            ),
            (Task::Eye { width, height }, Input::Bayer(src)) => {
                let (w, h) = (width as usize / 2, height as usize / 2);
                let rest = if level == CpuLevel::Simd {
                    CpuLevel::Autovec
                } else {
                    level
                };
                debayer(level, threads, src, width as usize, &mut self.gray);
                blur(
                    level,
                    threads,
                    &self.gray,
                    w,
                    h,
                    &self.weights,
                    &mut self.blurred,
                    &mut self.scratch,
                );
                erode(rest, threads, &self.blurred, w, h, &mut self.eroded);
                dilate(rest, threads, &self.eroded, w, h, &mut self.gray);
                moments(rest, threads, &self.gray, &self.blurred, w, h, true, &mut self.out);
            }
            (Task::Gemm { n, float }, Input::Matrices(a, b)) => {
                gemm(level, threads, a, b, n as usize, float, &mut self.out)
            }
            (Task::Reduce { .. }, Input::Words(src)) => {
                let sum = reduce(level, threads, src);
                self.out.copy_from_slice(&sum.to_le_bytes());
            }
            (Task::Mandelbrot { width, height }, Input::None) => mandelbrot(threads, width, height, &mut self.out),
            (Task::Alu { float, .. }, Input::Words(src)) => alu(level, threads, src, float, &mut self.out),
            (Task::Sort { .. }, Input::Words(src)) => sort(threads, src, &mut self.out, &mut self.sorted),
            (Task::Dispatch, _) => std::thread::scope(|s| {
                for _ in 0..threads {
                    s.spawn(|| std::hint::black_box(0));
                }
            }),
            _ => unreachable!("input built for another task"),
        }
    }
}

impl Bench for CpuBench {
    fn frame(&mut self) -> Result<FrameTimes, String> {
        let start = Instant::now();
        self.run();
        Ok(FrameTimes {
            compute: start.elapsed().as_secs_f64() * 1e3,
            ..FrameTimes::default()
        })
    }

    fn output(&mut self) -> Result<Vec<u8>, String> {
        Ok(self.out.clone())
    }

    fn prepare_stream(&mut self) -> Result<(), String> {
        if self.lanes.is_empty() && self.threads > 1 {
            self.lanes = (0..self.threads)
                .map(|_| CpuBench::new(self.task, self.level, 1))
                .collect::<Result<_, _>>()?;
        }
        Ok(())
    }

    /// One whole frame per core at a time, rather than every core on one frame's bands.
    fn stream(&mut self, frames: u32) -> Result<(), String> {
        if self.threads <= 1 || matches!(self.task, Task::Dispatch) {
            for _ in 0..frames {
                self.run();
            }
            return Ok(());
        }
        self.prepare_stream()?;
        let per_lane = frames.div_ceil(self.threads as u32);
        std::thread::scope(|s| {
            for lane in &mut self.lanes {
                s.spawn(move || {
                    for _ in 0..per_lane {
                        lane.run();
                    }
                });
            }
        });
        Ok(())
    }
}

/// Splits `dst` (rows of `row_len`) into one band per thread and runs `f` on each, the last
/// one on the calling thread.
fn for_bands(
    dst: &mut [u8],
    row_len: usize,
    threads: usize,
    scratch: &mut [Scratch],
    f: impl Fn(Range<usize>, &mut [u8], &mut Scratch) + Sync,
) {
    let rows = dst.len() / row_len.max(1);
    let per_band = rows.div_ceil(threads.max(1)).max(1);
    if threads <= 1 || rows <= 1 {
        f(0..rows, dst, &mut scratch[0]);
        return;
    }
    std::thread::scope(|s| {
        let mut bands: Vec<_> = dst
            .chunks_mut(per_band * row_len)
            .zip(scratch.iter_mut())
            .enumerate()
            .collect();
        let last = bands.pop();
        for (i, (band, scratch)) in bands {
            let f = &f;
            let start = i * per_band;
            s.spawn(move || f(start..start + band.len() / row_len, band, scratch));
        }
        if let Some((i, (band, scratch))) = last {
            let start = i * per_band;
            f(start..start + band.len() / row_len, band, scratch);
        }
    });
}

fn debayer(level: CpuLevel, threads: usize, src: &[u16], width: usize, dst: &mut [u8]) {
    let ow = width / 2;
    let mut scratch: Vec<Scratch> = (0..threads).map(|_| Scratch::default()).collect();
    for_bands(dst, ow, threads, &mut scratch, |rows, band, _| {
        for (y, out) in rows.zip(band.chunks_exact_mut(ow)) {
            let r0 = &src[2 * y * width..][..width];
            let r1 = &src[(2 * y + 1) * width..][..width];
            match level {
                CpuLevel::Scalar => {
                    for x in 0..ow {
                        out[x] = debayer_quad(r0[2 * x], r0[2 * x + 1], r1[2 * x], r1[2 * x + 1]);
                    }
                }
                CpuLevel::Autovec => debayer_row_autovec(r0, r1, out),
                CpuLevel::Simd => simd::debayer_row(r0, r1, out),
            }
        }
    });
}

fn debayer_row_autovec(r0: &[u16], r1: &[u16], out: &mut [u8]) {
    for ((o, a), b) in out.iter_mut().zip(r0.chunks_exact(2)).zip(r1.chunks_exact(2)) {
        let v = 77 * u32::from(a[0]) + 75 * (u32::from(a[1]) + u32::from(b[0])) + 29 * u32::from(b[1]);
        *o = (v >> 10) as u8;
    }
}

fn blur(
    level: CpuLevel,
    threads: usize,
    src: &[u8],
    width: usize,
    height: usize,
    weights: &[u16],
    dst: &mut [u8],
    scratch: &mut [Scratch],
) {
    let r = weights.len() / 2;
    for_bands(dst, width, threads, scratch, |rows, band, scratch| {
        // Horizontal sums for every source row this band's window touches.
        let first = rows.start.saturating_sub(r);
        let last = (rows.end + r).min(height);
        scratch.rows.resize((last - first) * width, 0);
        scratch.padded.resize(width + 2 * r, 0);
        scratch.acc.resize(width, 0);
        for y in first..last {
            let row = &src[y * width..][..width];
            let tmp = &mut scratch.rows[(y - first) * width..][..width];
            match level {
                CpuLevel::Scalar => {
                    for x in 0..width {
                        let mut acc = 0u32;
                        for (k, &w) in weights.iter().enumerate() {
                            acc += u32::from(w) * u32::from(row[(x + k).saturating_sub(r).min(width - 1)]);
                        }
                        tmp[x] = acc as u16;
                    }
                }
                CpuLevel::Autovec | CpuLevel::Simd => {
                    let padded = &mut scratch.padded;
                    padded[..r].fill(row[0]);
                    padded[r..r + width].copy_from_slice(row);
                    padded[r + width..].fill(row[width - 1]);
                    if level == CpuLevel::Simd && r > 0 {
                        simd::blur_h_row(padded, weights, tmp);
                    } else {
                        tmp.fill(0);
                        for (k, &w) in weights.iter().enumerate() {
                            for (t, &p) in tmp.iter_mut().zip(&padded[k..k + width]) {
                                *t = t.wrapping_add(w.wrapping_mul(u16::from(p)));
                            }
                        }
                    }
                }
            }
        }
        let mut sources: Vec<&[u16]> = Vec::with_capacity(weights.len());
        for (y, out) in rows.zip(band.chunks_exact_mut(width)) {
            let source_row = |k: usize| {
                let yy = (y + k).saturating_sub(r).min(height - 1) - first;
                &scratch.rows[yy * width..][..width]
            };
            match level {
                CpuLevel::Scalar => {
                    for x in 0..width {
                        let mut acc = 0u32;
                        for (k, &w) in weights.iter().enumerate() {
                            acc += u32::from(w) * u32::from(source_row(k)[x]);
                        }
                        out[x] = ((acc + 32768) >> 16) as u8;
                    }
                }
                CpuLevel::Autovec => {
                    let mut acc = std::mem::take(&mut scratch.acc);
                    acc.fill(0);
                    for (k, &w) in weights.iter().enumerate() {
                        for (a, &t) in acc.iter_mut().zip(source_row(k)) {
                            *a += u32::from(w) * u32::from(t);
                        }
                    }
                    for (o, &a) in out.iter_mut().zip(&acc) {
                        *o = ((a + 32768) >> 16) as u8;
                    }
                    scratch.acc = acc;
                }
                CpuLevel::Simd => {
                    sources.clear();
                    sources.extend((0..weights.len()).map(source_row));
                    simd::blur_v_row(&sources, weights, out);
                }
            }
        }
    });
}

/// Rows of C over threads. Scalar is the i-j-k dot product; autovec runs i-k-j, so the
/// innermost loop is a row of B times one scalar, added to a row of C - what vectorizes.
fn gemm(level: CpuLevel, threads: usize, a: &[u32], b: &[u32], n: usize, float: bool, dst: &mut [u8]) {
    let mut scratch: Vec<Scratch> = (0..threads).map(|_| Scratch::default()).collect();
    for_bands(dst, n * 4, threads, &mut scratch, |rows, band, scratch| {
        for (i, out) in rows.zip(band.chunks_exact_mut(n * 4)) {
            let arow = &a[i * n..][..n];
            if level == CpuLevel::Scalar {
                for j in 0..n {
                    let v = if float {
                        (0..n)
                            .map(|k| f32::from_bits(arow[k]) * f32::from_bits(b[k * n + j]))
                            .sum::<f32>()
                            .to_bits()
                    } else {
                        (0..n).fold(0i32, |acc, k| {
                            acc.wrapping_add((arow[k] as i32).wrapping_mul(b[k * n + j] as i32))
                        }) as u32
                    };
                    out[j * 4..j * 4 + 4].copy_from_slice(&v.to_le_bytes());
                }
                continue;
            }
            scratch.acc.clear();
            scratch.acc.resize(n, 0);
            if float {
                let acc: &mut [f32] = unsafe { std::slice::from_raw_parts_mut(scratch.acc.as_mut_ptr().cast(), n) };
                for k in 0..n {
                    let av = f32::from_bits(arow[k]);
                    let brow = &b[k * n..][..n];
                    for (c, &bv) in acc.iter_mut().zip(brow) {
                        *c += av * f32::from_bits(bv);
                    }
                }
            } else {
                let acc: &mut [i32] = unsafe { std::slice::from_raw_parts_mut(scratch.acc.as_mut_ptr().cast(), n) };
                for k in 0..n {
                    let av = arow[k] as i32;
                    let brow = &b[k * n..][..n];
                    for (c, &bv) in acc.iter_mut().zip(brow) {
                        *c = c.wrapping_add(av.wrapping_mul(bv as i32));
                    }
                }
            }
            for (o, v) in out.chunks_exact_mut(4).zip(&scratch.acc) {
                o.copy_from_slice(&v.to_le_bytes());
            }
        }
    });
}

fn reduce(level: CpuLevel, threads: usize, src: &[u32]) -> u32 {
    let sum = |part: &[u32]| -> u32 {
        if level == CpuLevel::Scalar {
            return part.iter().fold(0u32, |a, &w| a.wrapping_add(w));
        }
        let mut lanes = [0u32; 16];
        let mut chunks = part.chunks_exact(16);
        for c in &mut chunks {
            for (l, &w) in lanes.iter_mut().zip(c) {
                *l = l.wrapping_add(w);
            }
        }
        chunks
            .remainder()
            .iter()
            .chain(&lanes)
            .fold(0u32, |a, &w| a.wrapping_add(w))
    };
    if threads <= 1 {
        return sum(src);
    }
    let band = src.len().div_ceil(threads);
    std::thread::scope(|s| {
        src.chunks(band)
            .map(|p| s.spawn(move || sum(p)))
            .collect::<Vec<_>>()
            .into_iter()
            .fold(0u32, |a, t| a.wrapping_add(t.join().expect("reduce thread")))
    })
}

/// Rows dealt out in turn rather than in bands: the set's middle rows cost many times its edges.
fn mandelbrot(threads: usize, width: u32, height: u32, dst: &mut [u8]) {
    let row = |y: usize, out: &mut [u8]| {
        for (x, o) in out.iter_mut().enumerate() {
            let (cr, ci) = mandel_point(x as u32, y as u32, width, height);
            *o = mandel_count(cr, ci, MANDEL_ITERS);
        }
    };
    if threads <= 1 {
        for (y, out) in dst.chunks_exact_mut(width as usize).enumerate() {
            row(y, out);
        }
        return;
    }
    let mut lanes: Vec<Vec<(usize, &mut [u8])>> = (0..threads).map(|_| Vec::new()).collect();
    for (y, out) in dst.chunks_exact_mut(width as usize).enumerate() {
        lanes[y % threads].push((y, out));
    }
    std::thread::scope(|s| {
        for lane in lanes {
            s.spawn(move || {
                for (y, out) in lane {
                    row(y, out);
                }
            });
        }
    });
}

/// Scalar runs each element's chain to the end; autovec runs one round over every element
/// at a time, so the elements are the vector lanes.
fn alu(level: CpuLevel, threads: usize, src: &[u32], float: bool, dst: &mut [u8]) {
    let mut scratch: Vec<Scratch> = (0..threads).map(|_| Scratch::default()).collect();
    let chunk = 1024;
    for_bands(dst, 4 * chunk, threads, &mut scratch, |rows, band, scratch| {
        for (block, out) in rows.zip(band.chunks_exact_mut(4 * chunk)) {
            let seeds = &src[block * chunk..][..chunk];
            if level == CpuLevel::Scalar {
                for (o, &seed) in out.chunks_exact_mut(4).zip(seeds) {
                    o.copy_from_slice(&alu_chain(seed, ALU_ROUNDS, float).to_le_bytes());
                }
                continue;
            }
            scratch.acc.clear();
            if float {
                scratch
                    .acc
                    .extend(seeds.iter().map(|&s| ((s % 1024) as f32 / 1024.0).to_bits()));
                let xs: &mut [f32] = unsafe { std::slice::from_raw_parts_mut(scratch.acc.as_mut_ptr().cast(), chunk) };
                for _ in 0..ALU_ROUNDS {
                    for x in xs.iter_mut() {
                        *x = *x * 0.999 + 0.001;
                    }
                }
            } else {
                scratch.acc.extend_from_slice(seeds);
                for _ in 0..ALU_ROUNDS {
                    for x in scratch.acc.iter_mut() {
                        *x = x.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
                    }
                }
            }
            for (o, v) in out.chunks_exact_mut(4).zip(&scratch.acc) {
                o.copy_from_slice(&v.to_le_bytes());
            }
        }
    });
}

/// One thread: the standard library's sort. More: each sorts a slice, then one k-way merge.
fn sort(threads: usize, src: &[u32], dst: &mut [u8], work: &mut Vec<u32>) {
    work.clear();
    work.extend_from_slice(src);
    if threads <= 1 {
        work.sort_unstable();
    } else {
        let band = work.len().div_ceil(threads);
        std::thread::scope(|s| {
            for part in work.chunks_mut(band) {
                s.spawn(move || part.sort_unstable());
            }
        });
        let parts: Vec<&[u32]> = work.chunks(band).collect();
        let mut heads = vec![0usize; parts.len()];
        for o in dst.chunks_exact_mut(4) {
            let (p, v) = parts
                .iter()
                .enumerate()
                .filter_map(|(p, part)| part.get(heads[p]).map(|&v| (p, v)))
                .min_by_key(|&(_, v)| v)
                .expect("one head left");
            heads[p] += 1;
            o.copy_from_slice(&v.to_le_bytes());
        }
        return;
    }
    for (o, v) in dst.chunks_exact_mut(4).zip(work.iter()) {
        o.copy_from_slice(&v.to_le_bytes());
    }
}

/// Rows y-1, y, y+1 of `src`, clamped to the image.
fn rows3(src: &[u8], w: usize, h: usize, y: usize) -> [&[u8]; 3] {
    let row = |yy: usize| &src[yy * w..][..w];
    [row(y.saturating_sub(1)), row(y), row((y + 1).min(h - 1))]
}

/// `f` over the three-row column `c` and its left and right neighbours, clamped at the ends.
fn neighbours3(column: &[u8], out: &mut [u8], f: impl Fn(u8, u8, u8) -> u8) {
    let w = column.len();
    if w == 1 {
        out[0] = f(column[0], column[0], column[0]);
        return;
    }
    out[0] = f(column[0], column[0], column[1]);
    for x in 1..w - 1 {
        out[x] = f(column[x - 1], column[x], column[x + 1]);
    }
    out[w - 1] = f(column[w - 2], column[w - 1], column[w - 1]);
}

fn erode(level: CpuLevel, threads: usize, src: &[u8], w: usize, h: usize, dst: &mut [u8]) {
    let mut scratch: Vec<Scratch> = (0..threads).map(|_| Scratch::default()).collect();
    for_bands(dst, w, threads, &mut scratch, |rows, band, scratch| {
        for (y, out) in rows.zip(band.chunks_exact_mut(w)) {
            if level == CpuLevel::Scalar {
                for x in 0..w {
                    let all = (-1..=1isize).all(|dy| {
                        (-1..=1isize).all(|dx| {
                            let yy = (y as isize + dy).clamp(0, h as isize - 1) as usize;
                            let xx = (x as isize + dx).clamp(0, w as isize - 1) as usize;
                            src[yy * w + xx] < PUPIL_BELOW
                        })
                    });
                    out[x] = if all { 255 } else { 0 };
                }
                continue;
            }
            let [a, b, c] = rows3(src, w, h, y);
            scratch.padded.resize(w, 0);
            for (((v, &a), &b), &c) in scratch.padded.iter_mut().zip(a).zip(b).zip(c) {
                *v = if a < PUPIL_BELOW && b < PUPIL_BELOW && c < PUPIL_BELOW {
                    255
                } else {
                    0
                };
            }
            neighbours3(&scratch.padded, out, |l, m, r| l & m & r);
        }
    });
}

fn dilate(level: CpuLevel, threads: usize, src: &[u8], w: usize, h: usize, dst: &mut [u8]) {
    let mut scratch: Vec<Scratch> = (0..threads).map(|_| Scratch::default()).collect();
    for_bands(dst, w, threads, &mut scratch, |rows, band, scratch| {
        for (y, out) in rows.zip(band.chunks_exact_mut(w)) {
            if level == CpuLevel::Scalar {
                for x in 0..w {
                    let any = (-1..=1isize).any(|dy| {
                        (-1..=1isize).any(|dx| {
                            let yy = (y as isize + dy).clamp(0, h as isize - 1) as usize;
                            let xx = (x as isize + dx).clamp(0, w as isize - 1) as usize;
                            src[yy * w + xx] != 0
                        })
                    });
                    out[x] = if any { 255 } else { 0 };
                }
                continue;
            }
            let [a, b, c] = rows3(src, w, h, y);
            scratch.padded.resize(w, 0);
            for (((v, &a), &b), &c) in scratch.padded.iter_mut().zip(a).zip(b).zip(c) {
                *v = if (a | b | c) != 0 { 255 } else { 0 };
            }
            neighbours3(&scratch.padded, out, |l, m, r| l | m | r);
        }
    });
}

fn sobel(level: CpuLevel, threads: usize, src: &[u8], w: usize, h: usize, dst: &mut [u8]) {
    let mut scratch: Vec<Scratch> = (0..threads).map(|_| Scratch::default()).collect();
    for_bands(dst, w, threads, &mut scratch, |rows, band, scratch| {
        for (y, out) in rows.zip(band.chunks_exact_mut(w)) {
            let [a, b, c] = rows3(src, w, h, y);
            if level == CpuLevel::Scalar {
                for x in 0..w {
                    let p = |r: &[u8], dx: isize| i32::from(r[(x as isize + dx).clamp(0, w as isize - 1) as usize]);
                    let gx = p(a, 1) + 2 * p(b, 1) + p(c, 1) - p(a, -1) - 2 * p(b, -1) - p(c, -1);
                    let gy = p(c, -1) + 2 * p(c, 0) + p(c, 1) - p(a, -1) - 2 * p(a, 0) - p(a, 1);
                    out[x] = (gx.abs() + gy.abs()).min(255) as u8;
                }
                continue;
            }
            // Column sums first: vertical smoothing for gx, vertical difference for gy.
            scratch.rows.resize(2 * (w + 2), 0);
            let (smooth, diff) = scratch.rows.split_at_mut(w + 2);
            for x in 0..w {
                smooth[x + 1] = u16::from(a[x]) + 2 * u16::from(b[x]) + u16::from(c[x]);
                diff[x + 1] = (i16::from(c[x]) - i16::from(a[x])) as u16;
            }
            smooth[0] = smooth[1];
            smooth[w + 1] = smooth[w];
            diff[0] = diff[1];
            diff[w + 1] = diff[w];
            for x in 0..w {
                let gx = i32::from(smooth[x + 2]) - i32::from(smooth[x]);
                let gy = i32::from(diff[x] as i16) + 2 * i32::from(diff[x + 1] as i16) + i32::from(diff[x + 2] as i16);
                out[x] = (gx.abs() + gy.abs()).min(255) as u8;
            }
        }
    });
}

fn histogram(level: CpuLevel, threads: usize, src: &[u8], dst: &mut [u8]) {
    let band = src.len().div_ceil(threads.max(1)).max(1);
    let count = |part: &[u8]| -> [u32; 256] {
        let mut bins = [[0u32; 256]; 4];
        if level == CpuLevel::Scalar {
            for &v in part {
                bins[0][v as usize] += 1;
            }
        } else {
            // Four tables, so consecutive equal pixels do not serialize on one counter.
            let mut chunks = part.chunks_exact(4);
            for c in &mut chunks {
                bins[0][c[0] as usize] += 1;
                bins[1][c[1] as usize] += 1;
                bins[2][c[2] as usize] += 1;
                bins[3][c[3] as usize] += 1;
            }
            for &v in chunks.remainder() {
                bins[0][v as usize] += 1;
            }
        }
        std::array::from_fn(|i| bins[0][i] + bins[1][i] + bins[2][i] + bins[3][i])
    };
    let parts: Vec<[u32; 256]> = if threads <= 1 {
        vec![count(src)]
    } else {
        std::thread::scope(|s| {
            src.chunks(band)
                .map(|part| s.spawn(move || count(part)))
                .collect::<Vec<_>>()
                .into_iter()
                .map(|t| t.join().expect("histogram thread"))
                .collect()
        })
    };
    for (i, out) in dst.chunks_exact_mut(4).enumerate() {
        out.copy_from_slice(&parts.iter().map(|p| p[i]).sum::<u32>().to_le_bytes());
    }
}

fn moments(
    level: CpuLevel,
    threads: usize,
    pupil: &[u8],
    glint: &[u8],
    w: usize,
    _h: usize,
    pupil_is_mask: bool,
    dst: &mut [u8],
) {
    let mut scratch: Vec<Scratch> = (0..threads).map(|_| Scratch::default()).collect();
    for_bands(dst, 16, threads, &mut scratch, |rows, band, _| {
        for (y, out) in rows.zip(band.chunks_exact_mut(16)) {
            let (p, g) = (&pupil[y * w..][..w], &glint[y * w..][..w]);
            let mut m = [0u32; 4];
            if level == CpuLevel::Scalar {
                for x in 0..w {
                    if if pupil_is_mask { p[x] != 0 } else { p[x] < PUPIL_BELOW } {
                        m[0] += 1;
                        m[1] += x as u32;
                    }
                    if g[x] > GLINT_ABOVE {
                        m[2] += 1;
                        m[3] += x as u32;
                    }
                }
            } else {
                for (x, (&pv, &gv)) in p.iter().zip(g).enumerate() {
                    let pm = u32::from(if pupil_is_mask { pv != 0 } else { pv < PUPIL_BELOW });
                    let gm = u32::from(gv > GLINT_ABOVE);
                    m[0] += pm;
                    m[1] += pm * x as u32;
                    m[2] += gm;
                    m[3] += gm * x as u32;
                }
            }
            for (o, v) in out.chunks_exact_mut(4).zip(m) {
                o.copy_from_slice(&v.to_le_bytes());
            }
        }
    });
}

#[cfg(target_arch = "aarch64")]
mod simd {
    use core::arch::aarch64::*;

    use super::debayer_quad;

    pub fn debayer_row(r0: &[u16], r1: &[u16], out: &mut [u8]) {
        let ow = out.len();
        let mut x = 0;
        unsafe {
            while x + 8 <= ow {
                let a = vld2q_u16(r0.as_ptr().add(2 * x));
                let b = vld2q_u16(r1.as_ptr().add(2 * x));
                let g = vaddq_u16(a.1, b.0);
                let lo = vmlal_n_u16(
                    vmlal_n_u16(vmull_n_u16(vget_low_u16(a.0), 77), vget_low_u16(g), 75),
                    vget_low_u16(b.1),
                    29,
                );
                let hi = vmlal_high_n_u16(vmlal_high_n_u16(vmull_high_n_u16(a.0, 77), g, 75), b.1, 29);
                let narrow = vcombine_u16(vshrn_n_u32::<10>(lo), vshrn_n_u32::<10>(hi));
                vst1_u8(out.as_mut_ptr().add(x), vmovn_u16(narrow));
                x += 8;
            }
        }
        for x in x..ow {
            out[x] = debayer_quad(r0[2 * x], r0[2 * x + 1], r1[2 * x], r1[2 * x + 1]);
        }
    }

    /// Weights below 256 (any radius above 0), so `u8 x u8` products accumulate in `u16`.
    pub fn blur_h_row(padded: &[u8], weights: &[u16], out: &mut [u16]) {
        let width = out.len();
        let mut x = 0;
        unsafe {
            while x + 16 <= width {
                let mut lo = vdupq_n_u16(0);
                let mut hi = vdupq_n_u16(0);
                for (k, &w) in weights.iter().enumerate() {
                    let v = vld1q_u8(padded.as_ptr().add(x + k));
                    lo = vmlal_u8(lo, vget_low_u8(v), vdup_n_u8(w as u8));
                    hi = vmlal_high_u8(hi, v, vdupq_n_u8(w as u8));
                }
                vst1q_u16(out.as_mut_ptr().add(x), lo);
                vst1q_u16(out.as_mut_ptr().add(x + 8), hi);
                x += 16;
            }
        }
        for x in x..width {
            out[x] = weights
                .iter()
                .enumerate()
                .map(|(k, &w)| w * u16::from(padded[x + k]))
                .fold(0u16, u16::wrapping_add);
        }
    }

    pub fn blur_v_row(rows: &[&[u16]], weights: &[u16], out: &mut [u8]) {
        let width = out.len();
        let mut x = 0;
        unsafe {
            let round = vdupq_n_u32(32768);
            while x + 8 <= width {
                let mut lo = vdupq_n_u32(0);
                let mut hi = vdupq_n_u32(0);
                for (row, &w) in rows.iter().zip(weights) {
                    let v = vld1q_u16(row.as_ptr().add(x));
                    lo = vmlal_n_u16(lo, vget_low_u16(v), w);
                    hi = vmlal_high_n_u16(hi, v, w);
                }
                let narrow = vcombine_u16(vaddhn_u32(lo, round), vaddhn_u32(hi, round));
                vst1_u8(out.as_mut_ptr().add(x), vmovn_u16(narrow));
                x += 8;
            }
        }
        for x in x..width {
            let acc: u32 = rows
                .iter()
                .zip(weights)
                .map(|(row, &w)| u32::from(w) * u32::from(row[x]))
                .sum();
            out[x] = ((acc + 32768) >> 16) as u8;
        }
    }
}

#[cfg(target_arch = "x86_64")]
mod simd {
    use core::arch::x86_64::*;

    use super::debayer_quad;

    pub fn debayer_row(r0: &[u16], r1: &[u16], out: &mut [u8]) {
        unsafe { debayer_row_avx2(r0, r1, out) }
    }

    pub fn blur_h_row(padded: &[u8], weights: &[u16], out: &mut [u16]) {
        unsafe { blur_h_row_avx2(padded, weights, out) }
    }

    pub fn blur_v_row(rows: &[&[u16]], weights: &[u16], out: &mut [u8]) {
        unsafe { blur_v_row_avx2(rows, weights, out) }
    }

    /// Sixteen `u32` lanes, all at most 255, to sixteen bytes in order.
    #[target_feature(enable = "avx2")]
    fn narrow_to_u8(a: __m256i, b: __m256i) -> __m128i {
        let words = _mm256_permute4x64_epi64::<0xD8>(_mm256_packus_epi32(a, b));
        _mm_packus_epi16(_mm256_castsi256_si128(words), _mm256_extracti128_si256::<1>(words))
    }

    #[target_feature(enable = "avx2")]
    unsafe fn debayer_row_avx2(r0: &[u16], r1: &[u16], out: &mut [u8]) {
        let ow = out.len();
        let top = _mm256_set1_epi32((75 << 16) | 77);
        let bottom = _mm256_set1_epi32((29 << 16) | 75);
        let mut x = 0;
        while x + 16 <= ow {
            let quad = |at: usize| unsafe {
                let a = _mm256_loadu_si256(r0.as_ptr().add(2 * at).cast());
                let b = _mm256_loadu_si256(r1.as_ptr().add(2 * at).cast());
                _mm256_srli_epi32::<10>(_mm256_add_epi32(
                    _mm256_madd_epi16(a, top),
                    _mm256_madd_epi16(b, bottom),
                ))
            };
            let bytes = narrow_to_u8(quad(x), quad(x + 8));
            unsafe { _mm_storeu_si128(out.as_mut_ptr().add(x).cast(), bytes) };
            x += 16;
        }
        for x in x..ow {
            out[x] = debayer_quad(r0[2 * x], r0[2 * x + 1], r1[2 * x], r1[2 * x + 1]);
        }
    }

    #[target_feature(enable = "avx2")]
    unsafe fn blur_h_row_avx2(padded: &[u8], weights: &[u16], out: &mut [u16]) {
        let width = out.len();
        let mut x = 0;
        while x + 16 <= width {
            let mut acc = _mm256_setzero_si256();
            for (k, &w) in weights.iter().enumerate() {
                let v = unsafe { _mm256_cvtepu8_epi16(_mm_loadu_si128(padded.as_ptr().add(x + k).cast())) };
                acc = _mm256_add_epi16(acc, _mm256_mullo_epi16(v, _mm256_set1_epi16(w as i16)));
            }
            unsafe { _mm256_storeu_si256(out.as_mut_ptr().add(x).cast(), acc) };
            x += 16;
        }
        for x in x..width {
            out[x] = weights
                .iter()
                .enumerate()
                .map(|(k, &w)| w * u16::from(padded[x + k]))
                .fold(0u16, u16::wrapping_add);
        }
    }

    #[target_feature(enable = "avx2")]
    unsafe fn blur_v_row_avx2(rows: &[&[u16]], weights: &[u16], out: &mut [u8]) {
        let width = out.len();
        let round = _mm256_set1_epi32(32768);
        let mut x = 0;
        while x + 16 <= width {
            let mut lo = _mm256_setzero_si256();
            let mut hi = _mm256_setzero_si256();
            for (row, &w) in rows.iter().zip(weights) {
                let v = unsafe { _mm256_loadu_si256(row.as_ptr().add(x).cast()) };
                let wv = _mm256_set1_epi32(i32::from(w));
                lo = _mm256_add_epi32(
                    lo,
                    _mm256_mullo_epi32(_mm256_cvtepu16_epi32(_mm256_castsi256_si128(v)), wv),
                );
                hi = _mm256_add_epi32(
                    hi,
                    _mm256_mullo_epi32(_mm256_cvtepu16_epi32(_mm256_extracti128_si256::<1>(v)), wv),
                );
            }
            let lo = _mm256_srli_epi32::<16>(_mm256_add_epi32(lo, round));
            let hi = _mm256_srli_epi32::<16>(_mm256_add_epi32(hi, round));
            unsafe { _mm_storeu_si128(out.as_mut_ptr().add(x).cast(), narrow_to_u8(lo, hi)) };
            x += 16;
        }
        for x in x..width {
            let acc: u32 = rows
                .iter()
                .zip(weights)
                .map(|(row, &w)| u32::from(w) * u32::from(row[x]))
                .sum();
            out[x] = ((acc + 32768) >> 16) as u8;
        }
    }
}

#[cfg(not(any(target_arch = "aarch64", target_arch = "x86_64")))]
mod simd {
    pub fn debayer_row(r0: &[u16], r1: &[u16], out: &mut [u8]) {
        super::debayer_row_autovec(r0, r1, out)
    }

    pub fn blur_h_row(_: &[u8], _: &[u16], _: &mut [u16]) {
        unreachable!("CpuBench::new refuses Simd without an implementation")
    }

    pub fn blur_v_row(_: &[&[u16]], _: &[u16], _: &mut [u8]) {
        unreachable!("CpuBench::new refuses Simd without an implementation")
    }
}

#[cfg(test)]
mod tests {
    use super::super::data::{nv12_from_gray, reference_blur, reference_debayer};
    use super::*;

    fn levels() -> Vec<CpuLevel> {
        let mut levels = vec![CpuLevel::Scalar, CpuLevel::Autovec];
        if simd_name().is_some() {
            levels.push(CpuLevel::Simd);
        }
        levels
    }

    #[test]
    fn every_level_matches_the_reference() {
        let (w, h) = (70u32, 38u32);
        for level in levels() {
            for threads in [1, 3] {
                let mut b = CpuBench::new(Task::Debayer { width: w, height: h }, level, threads).unwrap();
                b.frame().unwrap();
                assert_eq!(
                    b.output().unwrap(),
                    reference_debayer(&bayer_rg10(w, h), w as usize, h as usize),
                    "debayer {level:?} {threads}t"
                );
                for radius in [0, 1, 2, 5, 17] {
                    let task = Task::Blur {
                        width: w,
                        height: h,
                        radius,
                    };
                    let mut b = CpuBench::new(task, level, threads).unwrap();
                    b.frame().unwrap();
                    let expected = reference_blur(
                        &gray_u8(w, h),
                        w as usize,
                        h as usize,
                        &gaussian_weights(radius as usize),
                    );
                    assert_eq!(b.output().unwrap(), expected, "blur r={radius} {level:?} {threads}t");
                    let task = Task::Pipeline {
                        width: w,
                        height: h,
                        radius,
                    };
                    let mut b = CpuBench::new(task, level, threads).unwrap();
                    b.frame().unwrap();
                    let gray = reference_debayer(&bayer_rg10(w, h), w as usize, h as usize);
                    let expected = nv12_from_gray(&reference_blur(
                        &gray,
                        w as usize / 2,
                        h as usize / 2,
                        &gaussian_weights(radius as usize),
                    ));
                    assert_eq!(
                        b.output().unwrap(),
                        expected,
                        "pipeline r={radius} {level:?} {threads}t"
                    );
                }
            }
        }
    }

    #[test]
    fn eye_kernels_match_the_reference() {
        let (w, h) = (70u32, 38u32);
        for level in [CpuLevel::Scalar, CpuLevel::Autovec] {
            for threads in [1, 3] {
                for task in [
                    Task::Morph { width: w, height: h },
                    Task::Sobel { width: w, height: h },
                    Task::Histogram { width: w, height: h },
                    Task::Moments { width: w, height: h },
                    Task::Eye {
                        width: 2 * w,
                        height: 2 * h,
                    },
                ] {
                    let mut b = CpuBench::new(task, level, threads).unwrap();
                    b.frame().unwrap();
                    assert_eq!(
                        b.output().unwrap(),
                        super::super::reference(task),
                        "{task:?} {level:?} {threads}t"
                    );
                }
            }
        }
        if simd_name().is_some() {
            let task = Task::Eye {
                width: 2 * w,
                height: 2 * h,
            };
            let mut b = CpuBench::new(task, CpuLevel::Simd, 3).unwrap();
            b.frame().unwrap();
            assert_eq!(b.output().unwrap(), super::super::reference(task));
        }
    }

    #[test]
    fn general_kernels_match_the_reference() {
        for level in [CpuLevel::Scalar, CpuLevel::Autovec] {
            for threads in [1, 3] {
                for task in [
                    Task::Gemm { n: 24, float: true },
                    Task::Gemm { n: 24, float: false },
                    Task::Reduce { n: 1000 },
                    Task::Mandelbrot { width: 40, height: 30 },
                    Task::Alu {
                        n: 3 * 1024,
                        float: false,
                    },
                    Task::Alu {
                        n: 3 * 1024,
                        float: true,
                    },
                    Task::Sort { n: 1000 },
                ] {
                    let mut b = CpuBench::new(task, level, threads).unwrap();
                    b.frame().unwrap();
                    let expected = super::super::reference(task);
                    if matches!(task, Task::Alu { float: true, .. }) {
                        assert!(
                            super::super::compare_task(task, &b.output().unwrap(), &expected, 0).is_ok(),
                            "{task:?} {level:?} {threads}t"
                        );
                    } else {
                        assert_eq!(b.output().unwrap(), expected, "{task:?} {level:?} {threads}t");
                    }
                }
            }
        }
    }

    #[test]
    fn the_scene_has_a_pupil_and_glints() {
        let m = super::super::reference(Task::Moments {
            width: 320,
            height: 240,
        });
        let total = |i: usize| {
            m.chunks_exact(16)
                .map(|r| u32::from_le_bytes(r[4 * i..4 * i + 4].try_into().unwrap()))
                .sum::<u32>()
        };
        assert!(total(0) > 500, "pupil pixels: {}", total(0));
        assert!(total(2) > 5, "glint pixels: {}", total(2));
    }

    #[test]
    fn bytes_view_is_little_endian_words() {
        assert_eq!(
            as_bytes(&[0x0102u16]),
            if cfg!(target_endian = "little") { [2, 1] } else { [1, 2] }
        );
    }
}

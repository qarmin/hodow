//! Building blocks of `hodow bench`: deterministic inputs, the reference every backend
//! is checked against, and the CPU and GPU implementations being timed.
//!
//! A frame always starts with the input in ordinary CPU memory and ends with the result
//! back there, the way an application would use it; upload, compute and download are
//! timed separately inside that.

pub mod cpu;
pub mod data;
#[cfg(feature = "bench_gles")]
pub mod gles;
#[cfg(feature = "opencl")]
pub mod opencl;
#[cfg(any(feature = "bench_gles", feature = "vulkan"))]
pub mod shaders;
pub mod spec;
#[cfg(feature = "tflite")]
pub mod tflite;
pub mod tflite_model;
#[cfg(feature = "vulkan")]
pub mod vk;

use std::collections::HashMap;
use std::sync::Arc;
use std::time::{Duration, Instant};

use spec::{Backend, RowResult, RowSpec, RowStatus, Stats, Task, TfliteDelegate, Timings, Variant};

#[derive(Clone, Copy, Debug, Default)]
pub struct FrameTimes {
    pub upload: f64,
    pub compute: f64,
    pub download: f64,
    pub gpu: Option<f64>,
}

pub trait Bench {
    fn frame(&mut self) -> Result<FrameTimes, String>;
    /// The last frame's result, read back outside any timing.
    fn output(&mut self) -> Result<Vec<u8>, String>;
    /// Something the implementation had to work around, for the row's detail.
    fn note(&self) -> Option<String> {
        None
    }
    /// `frames` frames with nothing waited for between them, only at the end - how fast a
    /// camera stream could go through, rather than how long one frame takes.
    fn stream(&mut self, frames: u32) -> Result<(), String> {
        for _ in 0..frames {
            self.frame()?;
        }
        Ok(())
    }
    /// Whatever a stream needs beyond what a frame does, built before any timing.
    fn prepare_stream(&mut self) -> Result<(), String> {
        Ok(())
    }
}

/// Everything a worker keeps between rows: references computed once per task, and open
/// OpenCL sessions.
#[derive(Default)]
pub struct Cache {
    references: HashMap<Task, Arc<Vec<u8>>>,
    #[cfg(feature = "opencl")]
    sessions: HashMap<String, Result<opencl::Session, String>>,
    /// Launch shapes a driver refused once, and on which row: the rows after it that would
    /// only be refused the same way are skipped rather than built and failed again.
    refused: HashMap<String, String>,
    #[cfg(feature = "bench_gles")]
    gles: Option<Result<gles::Session, String>>,
    #[cfg(feature = "vulkan")]
    vulkan: Option<Result<vk::Session, String>>,
    #[cfg(feature = "tflite")]
    tflite: Option<Result<Arc<tflite::Api>, String>>,
    /// The TFLite CPU kernels' answer per task, which every delegate is held to.
    #[cfg(feature = "tflite")]
    tflite_references: HashMap<Task, Result<Arc<Vec<u8>>, String>>,
}

/// What a work-group refusal depends on. The radius only as zero or not: the board's 1.2
/// library takes 32x8 for the local-memory kernel at radius 0 and refuses it above.
fn refusal_key(spec: &RowSpec) -> Option<String> {
    match &spec.backend {
        Backend::OpenCl {
            lib, variant, local, ..
        } => Some(format!(
            "{lib} {variant:?} {local:?} {}",
            spec.task.radius().unwrap_or(0) > 0
        )),
        Backend::Cpu { .. }
        | Backend::Gles { .. }
        | Backend::Vulkan { .. }
        | Backend::External { .. }
        | Backend::Tflite { .. } => None,
    }
}

impl Cache {
    #[cfg(feature = "bench_gles")]
    pub fn with_gles(session: gles::Session) -> Self {
        Self {
            gles: Some(Ok(session)),
            ..Self::default()
        }
    }

    fn reference(&mut self, task: Task) -> Arc<Vec<u8>> {
        self.references
            .entry(task)
            .or_insert_with(|| Arc::new(reference(task)))
            .clone()
    }

    #[cfg(feature = "bench_gles")]
    pub fn gles(&mut self) -> &Result<gles::Session, String> {
        self.gles.get_or_insert_with(gles::Session::open)
    }

    #[cfg(feature = "vulkan")]
    pub fn vulkan(&mut self) -> &Result<vk::Session, String> {
        self.vulkan.get_or_insert_with(vk::Session::open)
    }

    #[cfg(feature = "tflite")]
    pub fn tflite(&mut self) -> Result<Arc<tflite::Api>, String> {
        self.tflite
            .get_or_insert_with(|| tflite::Api::load().map(Arc::new))
            .clone()
    }

    #[cfg(feature = "tflite")]
    fn tflite_reference(&mut self, task: Task) -> Result<Arc<Vec<u8>>, String> {
        if let Some(r) = self.tflite_references.get(&task) {
            return r.clone();
        }
        let r = self.tflite().and_then(|api| {
            let mut b = tflite::TfliteBench::new(api, task, TfliteDelegate::Cpu { threads: 1 }).map_err(|(_, e)| e)?;
            b.frame()?;
            b.output().map(Arc::new)
        });
        self.tflite_references.insert(task, r.clone());
        r
    }

    #[cfg(feature = "opencl")]
    pub fn session(&mut self, lib: &str) -> Result<&opencl::Session, String> {
        self.sessions
            .entry(lib.to_string())
            .or_insert_with(|| opencl::Session::open(lib))
            .as_ref()
            .map_err(Clone::clone)
    }
}

pub fn reference(task: Task) -> Vec<u8> {
    use data::{
        alu_chain, bayer_rg10, gaussian_weights, gemm_inputs, gray_u8, mandel_count, mandel_point, nv12_from_gray,
        random_bytes, reference_blur, reference_debayer, reference_dilate, reference_erode, reference_eye,
        reference_gemm, reference_histogram, reference_moments, reference_sobel, u32_bytes, words,
    };
    match task {
        Task::Debayer { width, height } => {
            reference_debayer(&bayer_rg10(width, height), width as usize, height as usize)
        }
        Task::Blur { width, height, radius } => reference_blur(
            &gray_u8(width, height),
            width as usize,
            height as usize,
            &gaussian_weights(radius as usize),
        ),
        Task::Pipeline { width, height, radius } => {
            let gray = reference_debayer(&bayer_rg10(width, height), width as usize, height as usize);
            nv12_from_gray(&reference_blur(
                &gray,
                width as usize / 2,
                height as usize / 2,
                &gaussian_weights(radius as usize),
            ))
        }
        Task::Upload { bytes } | Task::Download { bytes } | Task::Copy { bytes } => random_bytes(bytes as usize),
        #[expect(clippy::match_same_arms, reason = "one arm per task keeps the list readable")]
        Task::Dispatch => Vec::new(),
        Task::Morph { width, height } => {
            let (w, h) = (width as usize, height as usize);
            reference_dilate(&reference_erode(&gray_u8(width, height), w, h), w, h)
        }
        Task::Sobel { width, height } => reference_sobel(&gray_u8(width, height), width as usize, height as usize),
        Task::Histogram { width, height } => reference_histogram(&gray_u8(width, height)),
        Task::Moments { width, height } => {
            let gray = gray_u8(width, height);
            reference_moments(&gray, &gray, width as usize, height as usize, false)
        }
        Task::Eye { width, height } => reference_eye(&bayer_rg10(width, height), width as usize, height as usize),
        Task::Gemm { n, float } => {
            let (a, b) = gemm_inputs(n, float);
            reference_gemm(&a, &b, n as usize, float)
        }
        Task::Reduce { n } => words(n, 21)
            .iter()
            .fold(0u32, |a, &w| a.wrapping_add(w))
            .to_le_bytes()
            .to_vec(),
        Task::Mandelbrot { width, height } => (0..height)
            .flat_map(|y| (0..width).map(move |x| mandel_point(x, y, width, height)))
            .map(|(cr, ci)| mandel_count(cr, ci, spec::MANDEL_ITERS))
            .collect(),
        Task::Alu { n, float } => u32_bytes(
            &words(n, 31)
                .iter()
                .map(|&s| alu_chain(s, spec::ALU_ROUNDS, float))
                .collect::<Vec<_>>(),
        ),
        Task::Sort { n } => {
            let mut w = words(n, 41);
            w.sort_unstable();
            u32_bytes(&w)
        }
        // Only TFLite runs it, and TFLite's own CPU kernels are its reference.
        Task::Cnn { .. } => Vec::new(),
    }
}

/// Frames a row stops at once it has spent three budgets, whatever its minimum.
const MIN_SLOW_REPS: usize = 3;

/// Frames per batch of a stream row; the per-frame time is a batch's time over this.
const STREAM_BATCH: u32 = 8;

fn stream_row(
    spec: &RowSpec,
    bench: &mut dyn Bench,
    mut result: RowResult,
    expected: &[u8],
    beat: &mut dyn FnMut(u32),
) -> RowResult {
    let budget = Duration::from_millis(spec.budget_ms);
    if let Err(e) = bench.prepare_stream().and_then(|()| bench.stream(STREAM_BATCH)) {
        result.status = RowStatus::Failed;
        result.detail = e;
        return result;
    }
    let start = Instant::now();
    let mut per_frame = Vec::new();
    let mut cpu = Vec::new();
    while per_frame.len() < spec.min_reps.div_ceil(2).max(3) as usize
        || (start.elapsed() < budget && per_frame.len() < spec.max_reps as usize)
    {
        let (t, c) = (Instant::now(), process_cpu_ms());
        if let Err(e) = bench.stream(STREAM_BATCH) {
            result.status = RowStatus::Failed;
            result.detail = e;
            return result;
        }
        per_frame.push(t.elapsed().as_secs_f64() * 1e3 / f64::from(STREAM_BATCH));
        cpu.push((process_cpu_ms() - c) / f64::from(STREAM_BATCH));
        beat(per_frame.len() as u32 * STREAM_BATCH);
    }
    result.reps = per_frame.len() as u32 * STREAM_BATCH;
    result.timings = Timings {
        total: Stats::of(&per_frame),
        cpu: Stats::of(&cpu),
        ..Timings::default()
    };
    result.frames = per_frame.iter().map(|&t| [0.0, t as f32, 0.0]).collect();
    match bench
        .output()
        .and_then(|out| compare_task(spec.task, &out, expected, tolerance(&spec.backend)))
    {
        Ok(max) => {
            result.max_error = (tolerance(&spec.backend) > 0).then_some(max);
            result.detail = bench.note().unwrap_or_default();
        }
        Err(e) => {
            result.status = RowStatus::Mismatch;
            result.detail = e;
        }
    }
    result
}

/// CPU time of this process so far, every thread included.
#[cfg(unix)]
fn process_cpu_ms() -> f64 {
    let mut ts = libc::timespec { tv_sec: 0, tv_nsec: 0 };
    unsafe { libc::clock_gettime(libc::CLOCK_PROCESS_CPUTIME_ID, &mut ts) };
    ts.tv_sec as f64 * 1e3 + ts.tv_nsec as f64 / 1e6
}

#[cfg(not(unix))]
fn process_cpu_ms() -> f64 {
    0.0
}

/// How far an output may stray from the reference and still be correct.
fn tolerance(backend: &Backend) -> u32 {
    match backend {
        // A delegate may requantize with its own rounding.
        Backend::OpenCl {
            variant: Variant::F32 | Variant::F16,
            ..
        }
        | Backend::Tflite {
            delegate: TfliteDelegate::Vx,
        } => 1,
        _ => 0,
    }
}

/// The f32 ALU chain is the one result whose rounding depends on FMA contraction; it is
/// compared as floats, within this relative error.
const ALU_F32_TOLERANCE: f32 = 1e-5;

pub(crate) fn compare_task(task: Task, output: &[u8], expected: &[u8], tolerance: u32) -> Result<u32, String> {
    if !matches!(task, Task::Alu { float: true, .. }) {
        return compare(task, output, expected, tolerance);
    }
    if output.len() != expected.len() {
        return Err(format!("output is {} bytes, expected {}", output.len(), expected.len()));
    }
    let floats = |b: &[u8]| -> Vec<f32> {
        b.chunks_exact(4)
            .map(|c| f32::from_le_bytes(c.try_into().expect("4 bytes")))
            .collect()
    };
    let (got, want) = (floats(output), floats(expected));
    let mut worst = (0.0f32, 0usize);
    for (i, (g, w)) in got.iter().zip(&want).enumerate() {
        let rel = (g - w).abs() / w.abs().max(f32::MIN_POSITIVE);
        if rel.is_nan() || rel > worst.0 {
            worst = (if rel.is_nan() { f32::INFINITY } else { rel }, i);
        }
    }
    if worst.0 > ALU_F32_TOLERANCE {
        return Err(format!(
            "element {} is {} against {} (relative error {:e})",
            worst.1, got[worst.1], want[worst.1], worst.0
        ));
    }
    Ok(0)
}

fn compare(task: Task, output: &[u8], expected: &[u8], tolerance: u32) -> Result<u32, String> {
    if output.len() != expected.len() {
        return Err(format!("output is {} bytes, expected {}", output.len(), expected.len()));
    }
    let mut max = 0u32;
    let mut wrong = 0usize;
    let mut first = None;
    for (i, (&a, &b)) in output.iter().zip(expected).enumerate() {
        let diff = u32::from(a.abs_diff(b));
        max = max.max(diff);
        if diff > tolerance {
            wrong += 1;
            first.get_or_insert((i, a, b));
        }
    }
    match first {
        None => Ok(max),
        Some((i, a, b)) => Err(format!(
            "{wrong} of {} bytes differ, first at {} (byte {i}): got {a}, expected {b} (max difference {max})",
            output.len(),
            task.locate(i)
        )),
    }
}

/// Runs one row: builds its implementation (timed as setup), runs the first frame (timed
/// on its own), then frames until the budget is spent, and checks the last output.
/// `beat` is called after every frame with the count so far.
pub fn execute(spec: &RowSpec, cache: &mut Cache, beat: &mut dyn FnMut(u32)) -> RowResult {
    let key = refusal_key(spec);
    if let Some(first) = key.as_ref().and_then(|k| cache.refused.get(k)) {
        return RowResult::status(
            RowStatus::Unsupported,
            format!("not run: the driver refused this work-group on {first}"),
        );
    }
    let result = execute_row(spec, cache, beat);
    if let Some(key) = key
        && result.status == RowStatus::Failed
        && result.detail.contains("CL_INVALID_WORK_GROUP_SIZE")
    {
        cache.refused.insert(key, spec.id());
    }
    result
}

fn execute_row(spec: &RowSpec, cache: &mut Cache, beat: &mut dyn FnMut(u32)) -> RowResult {
    let expected = match &spec.backend {
        #[cfg(feature = "tflite")]
        Backend::Tflite { .. } => match cache.tflite_reference(spec.task) {
            Ok(r) => r,
            Err(e) => return RowResult::status(RowStatus::Unsupported, e),
        },
        _ => cache.reference(spec.task),
    };
    let setup_start = Instant::now();
    let built: Result<Box<dyn Bench + '_>, (RowStatus, String)> = match &spec.backend {
        Backend::Cpu { level, threads } => cpu::CpuBench::new(spec.task, *level, *threads)
            .map(|b| Box::new(b) as Box<dyn Bench>)
            .map_err(|e| (RowStatus::Unsupported, e)),
        #[cfg(feature = "opencl")]
        Backend::OpenCl {
            lib,
            variant,
            strategy,
            local,
        } => match cache.session(lib) {
            Err(e) => Err((RowStatus::Unsupported, e)),
            Ok(session) => opencl::ClBench::new(session, spec.task, *variant, *strategy, *local)
                .map(|b| Box::new(b) as Box<dyn Bench>),
        },
        #[cfg(not(feature = "opencl"))]
        Backend::OpenCl { .. } => Err((RowStatus::Unsupported, "built without the `opencl` feature".into())),
        #[cfg(feature = "bench_gles")]
        Backend::Gles { variant, strategy } => match cache.gles.get_or_insert_with(gles::Session::open) {
            Err(e) => Err((RowStatus::Unsupported, e.clone())),
            Ok(session) => {
                gles::GlBench::new(session, spec.task, *variant, *strategy).map(|b| Box::new(b) as Box<dyn Bench>)
            }
        },
        #[cfg(not(feature = "bench_gles"))]
        Backend::Gles { .. } => Err((RowStatus::Unsupported, "built without the `bench_gles` feature".into())),
        #[cfg(feature = "vulkan")]
        Backend::Vulkan { variant, strategy } => match cache.vulkan.get_or_insert_with(vk::Session::open) {
            Err(e) => Err((RowStatus::Unsupported, e.clone())),
            Ok(session) => {
                vk::VkBench::new(session, spec.task, *variant, *strategy).map(|b| Box::new(b) as Box<dyn Bench>)
            }
        },
        #[cfg(not(feature = "vulkan"))]
        Backend::Vulkan { .. } => Err((RowStatus::Unsupported, "built without the `vulkan` feature".into())),
        Backend::External { .. } => Err((RowStatus::Unsupported, "imported numbers, nothing to run".into())),
        #[cfg(feature = "tflite")]
        Backend::Tflite { delegate } => match cache.tflite() {
            Err(e) => Err((RowStatus::Unsupported, e)),
            Ok(api) => tflite::TfliteBench::new(api, spec.task, *delegate).map(|b| Box::new(b) as Box<dyn Bench>),
        },
        #[cfg(not(feature = "tflite"))]
        Backend::Tflite { .. } => Err((RowStatus::Unsupported, "built without the `tflite` feature".into())),
    };
    let mut bench = match built {
        Ok(b) => b,
        Err((status, detail)) => return RowResult::status(status, detail),
    };
    let setup_ms = setup_start.elapsed().as_secs_f64() * 1e3;
    let mut result = RowResult::status(RowStatus::Ok, String::new());
    result.setup_ms = Some(setup_ms);
    let fail = |mut result: RowResult, e: String| {
        result.status = RowStatus::Failed;
        result.detail = e;
        result
    };

    let first = Instant::now();
    if let Err(e) = bench.frame() {
        return fail(result, e);
    }
    let first = first.elapsed();
    result.first_frame_ms = Some(first.as_secs_f64() * 1e3);
    if spec.verify_all
        && let Err(e) = bench
            .output()
            .and_then(|out| compare_task(spec.task, &out, &expected, tolerance(&spec.backend)))
    {
        result.status = RowStatus::Mismatch;
        result.detail = format!("first frame: {e}");
        return result;
    }
    let budget = Duration::from_millis(spec.budget_ms);
    // A warm-up is for kernels short enough that caches and clocks matter; one that already
    // takes longer than the whole budget is warm by the end of its first frame.
    if first < budget
        && let Err(e) = bench.frame()
    {
        return fail(result, e);
    }

    if spec.stream {
        return stream_row(spec, bench.as_mut(), result, &expected, beat);
    }
    let start = Instant::now();
    let mut frames = Vec::new();
    let mut gpu = Vec::new();
    let mut cpu = Vec::new();
    // At least `min_reps`, unless a slow row would take more than three budgets to get
    // there - then three frames are enough to give a median.
    let enough = |n: usize, elapsed: Duration| {
        n >= spec.max_reps as usize
            || (elapsed >= budget && (n >= spec.min_reps as usize || (n >= MIN_SLOW_REPS && elapsed >= budget * 3)))
    };
    while !enough(frames.len(), start.elapsed()) {
        let before = process_cpu_ms();
        match bench.frame() {
            Ok(t) => {
                cpu.push(process_cpu_ms() - before);
                frames.push(t);
                gpu.extend(t.gpu);
            }
            Err(e) => return fail(result, e),
        }
        if spec.verify_all
            && let Err(e) = bench
                .output()
                .and_then(|out| compare_task(spec.task, &out, &expected, tolerance(&spec.backend)))
        {
            result.status = RowStatus::Mismatch;
            result.detail = format!("frame {}: {e}", frames.len());
            return result;
        }
        beat(frames.len() as u32);
    }
    let column = |f: fn(&FrameTimes) -> f64| Stats::of(&frames.iter().map(f).collect::<Vec<_>>());
    result.reps = frames.len() as u32;
    result.timings = Timings {
        total: column(|t| t.upload + t.compute + t.download),
        upload: column(|t| t.upload),
        compute: column(|t| t.compute),
        download: column(|t| t.download),
        gpu: Stats::of(&gpu),
        cpu: Stats::of(&cpu),
    };
    result.frames = frames
        .iter()
        .map(|t| [t.upload as f32, t.compute as f32, t.download as f32])
        .collect();

    match bench
        .output()
        .and_then(|out| compare_task(spec.task, &out, &expected, tolerance(&spec.backend)))
    {
        Ok(max) => {
            result.max_error = (tolerance(&spec.backend) > 0).then_some(max);
            result.detail = bench.note().unwrap_or_default();
        }
        Err(e) => {
            result.status = RowStatus::Mismatch;
            result.detail = e;
        }
    }
    result
}

#[cfg(test)]
mod compare_tests {
    use super::*;

    #[test]
    fn a_mismatch_names_the_pixel() {
        let expected = vec![0u8; 640 * 480];
        let mut output = expected.clone();
        output[3 * 640 + 7] = 1;
        let task = Task::Sobel {
            width: 640,
            height: 480,
        };
        let err = compare(task, &output, &expected, 0).unwrap_err();
        assert!(err.contains("pixel (7, 3)"), "{err}");
    }

    #[test]
    fn a_mismatch_names_the_matrix_element() {
        let expected = vec![0u8; 64 * 64 * 4];
        let mut output = expected.clone();
        output[(5 * 64 + 9) * 4 + 2] = 1;
        let err = compare(Task::Gemm { n: 64, float: false }, &output, &expected, 0).unwrap_err();
        assert!(err.contains("element [5][9]"), "{err}");
    }
}

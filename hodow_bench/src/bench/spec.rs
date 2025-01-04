//! What a benchmark row asks for and what it reports back. Serialized between the
//! orchestrator and its workers, and into `results.json`.

use std::fmt;

use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Hash)]
#[serde(tag = "kind", rename_all = "snake_case")]
pub enum Task {
    /// RG10 Bayer of this size to an 8-bit gray image of half the size, one pixel per 2x2 quad.
    Debayer {
        width: u32,
        height: u32,
    },
    /// Separable gaussian over an 8-bit gray image, clamp-to-edge.
    Blur {
        width: u32,
        height: u32,
        radius: u32,
    },
    /// RG10 Bayer of this size to a half-size NV12 frame: debayer, blur, constant chroma.
    Pipeline {
        width: u32,
        height: u32,
        radius: u32,
    },
    Upload {
        bytes: u64,
    },
    Download {
        bytes: u64,
    },
    /// An empty kernel enqueued and waited for; on the CPU, threads started and joined.
    Dispatch,
    /// A buffer copied by the device itself.
    Copy {
        bytes: u64,
    },
    /// Pupil threshold, 3x3 erosion and 3x3 dilation of a gray image: the opened mask.
    Morph {
        width: u32,
        height: u32,
    },
    Sobel {
        width: u32,
        height: u32,
    },
    Histogram {
        width: u32,
        height: u32,
    },
    /// Per-row pupil and glint pixel counts and x sums of a gray image.
    Moments {
        width: u32,
        height: u32,
    },
    /// RG10 Bayer of this size to pupil and glint moments: debayer, blur, opened mask, moments.
    Eye {
        width: u32,
        height: u32,
    },
    /// n x n matrix product. In f32 the inputs are multiples of 1/16, so every summation
    /// order and every FMA gives the exact result.
    Gemm {
        n: u32,
        float: bool,
    },
    /// Sum of n `u32`s, wrapping.
    Reduce {
        n: u32,
    },
    /// Escape counts in 12-bit fixed point: divergent loops with an exact answer.
    Mandelbrot {
        width: u32,
        height: u32,
    },
    /// n independent chains of ALU_ROUNDS multiply-adds: an LCG in u32, a contraction in f32.
    Alu {
        n: u32,
        float: bool,
    },
    /// n `u32`s sorted; n a power of two for the GPU's bitonic network.
    Sort {
        n: u32,
    },
    /// A small uint8 convolutional network on a size x size RGB image - TFLite only.
    Cnn {
        size: u32,
    },
}

/// Multiply-adds per element of an `Alu` row.
pub const ALU_ROUNDS: u32 = 256;
/// Iteration cap of the Mandelbrot rows.
pub const MANDEL_ITERS: u32 = 256;

impl Task {
    pub fn kind(&self) -> &'static str {
        match self {
            Self::Debayer { .. } => "debayer",
            Self::Blur { .. } => "blur",
            Self::Pipeline { .. } => "pipeline",
            Self::Upload { .. } => "upload",
            Self::Download { .. } => "download",
            Self::Dispatch => "dispatch",
            Self::Copy { .. } => "copy",
            Self::Morph { .. } => "morph",
            Self::Sobel { .. } => "sobel",
            Self::Histogram { .. } => "histogram",
            Self::Moments { .. } => "moments",
            Self::Eye { .. } => "eye",
            Self::Gemm { .. } => "gemm",
            Self::Reduce { .. } => "reduce",
            Self::Mandelbrot { .. } => "mandelbrot",
            Self::Alu { .. } => "alu",
            Self::Sort { .. } => "sort",
            Self::Cnn { .. } => "cnn",
        }
    }

    pub fn radius(&self) -> Option<u32> {
        match *self {
            Self::Blur { radius, .. } | Self::Pipeline { radius, .. } => Some(radius),
            _ => None,
        }
    }

    /// The radius of the blur the task contains, if it contains one.
    pub fn blur_radius(&self) -> Option<u32> {
        match self {
            Self::Eye { .. } => Some(super::data::EYE_RADIUS as u32),
            _ => self.radius(),
        }
    }

    pub fn size(&self) -> Option<(u32, u32)> {
        match *self {
            Self::Debayer { width, height }
            | Self::Blur { width, height, .. }
            | Self::Pipeline { width, height, .. }
            | Self::Morph { width, height }
            | Self::Sobel { width, height }
            | Self::Histogram { width, height }
            | Self::Moments { width, height }
            | Self::Eye { width, height }
            | Self::Mandelbrot { width, height } => Some((width, height)),
            _ => None,
        }
    }

    /// Where output byte `i` sits, for a mismatch message: a pixel of an image output, a
    /// 32-bit element of a word output, a row of the moments table.
    pub fn locate(&self, i: usize) -> String {
        let pixel = |w: u32, i: usize| format!("pixel ({}, {})", i % w as usize, i / w as usize);
        match *self {
            Self::Debayer { width, .. } => pixel(width / 2, i),
            Self::Pipeline { width, height, .. } => {
                let luma = (width / 2 * (height / 2)) as usize;
                if i < luma {
                    format!("luma {}", pixel(width / 2, i))
                } else {
                    format!("chroma byte {}", i - luma)
                }
            }
            Self::Blur { width, .. }
            | Self::Morph { width, .. }
            | Self::Sobel { width, .. }
            | Self::Mandelbrot { width, .. } => pixel(width, i),
            Self::Histogram { .. } => format!("bin {}", i / 4),
            Self::Moments { .. } | Self::Eye { .. } => format!("row {}, field {}", i / 16, i % 16 / 4),
            Self::Gemm { n, .. } => format!("element [{}][{}]", i / 4 / n as usize, i / 4 % n as usize),
            Self::Reduce { .. } => "the sum".into(),
            Self::Alu { .. } | Self::Sort { .. } => format!("element {}", i / 4),
            _ => format!("byte {i}"),
        }
    }

    /// Arithmetic operations per frame, for a rate next to the time.
    pub fn ops(&self) -> Option<u64> {
        match *self {
            Self::Gemm { n, .. } => Some(2 * u64::from(n).pow(3)),
            Self::Alu { n, .. } => Some(2 * u64::from(n) * u64::from(ALU_ROUNDS)),
            Self::Reduce { n } => Some(u64::from(n)),
            _ => None,
        }
    }

    /// Bytes moved per frame, for a bandwidth figure next to the time.
    pub fn bytes(&self) -> Option<u64> {
        match *self {
            Self::Upload { bytes } | Self::Download { bytes } => Some(bytes),
            Self::Copy { bytes } => Some(bytes * 2),
            _ => None,
        }
    }
}

impl fmt::Display for Task {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match *self {
            Self::Debayer { width, height } => write!(f, "debayer {width}x{height} -> {}x{}", width / 2, height / 2),
            Self::Blur { width, height, radius } => write!(f, "blur r={radius} {width}x{height}"),
            Self::Pipeline { width, height, radius } => write!(
                f,
                "pipeline r={radius} {width}x{height} -> {}x{} NV12",
                width / 2,
                height / 2
            ),
            Self::Upload { bytes } => write!(f, "upload {}", fmt_bytes(bytes)),
            Self::Download { bytes } => write!(f, "download {}", fmt_bytes(bytes)),
            Self::Dispatch => write!(f, "dispatch"),
            Self::Copy { bytes } => write!(f, "copy {}", fmt_bytes(bytes)),
            Self::Morph { width, height } => write!(f, "morph {width}x{height}"),
            Self::Sobel { width, height } => write!(f, "sobel {width}x{height}"),
            Self::Histogram { width, height } => write!(f, "histogram {width}x{height}"),
            Self::Moments { width, height } => write!(f, "moments {width}x{height}"),
            Self::Eye { width, height } => write!(f, "eye {width}x{height} -> pupil and glint moments"),
            Self::Gemm { n, float } => write!(f, "gemm {} {n}x{n}", if float { "f32" } else { "i32" }),
            Self::Reduce { n } => write!(f, "reduce {} u32", fmt_count(n)),
            Self::Mandelbrot { width, height } => write!(f, "mandelbrot {width}x{height} x{MANDEL_ITERS}"),
            Self::Alu { n, float } => write!(
                f,
                "alu {} {} x{ALU_ROUNDS}",
                if float { "f32" } else { "u32" },
                fmt_count(n)
            ),
            Self::Sort { n } => write!(f, "sort {} u32", fmt_count(n)),
            Self::Cnn { size } => write!(f, "cnn uint8 {size}x{size}x3"),
        }
    }
}

pub fn fmt_count(n: u32) -> String {
    match n {
        n if n >= 1 << 20 && n % (1 << 20) == 0 => format!("{}M", n >> 20),
        n if n >= 1 << 10 && n % (1 << 10) == 0 => format!("{}K", n >> 10),
        n => n.to_string(),
    }
}

pub fn fmt_bytes(bytes: u64) -> String {
    match bytes {
        b if b >= 1 << 20 && b % (1 << 20) == 0 => format!("{} MB", b >> 20),
        b if b >= 1 << 10 && b % (1 << 10) == 0 => format!("{} KB", b >> 10),
        b => format!("{b} B"),
    }
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Hash)]
#[serde(rename_all = "snake_case")]
pub enum CpuLevel {
    /// One pixel at a time, every tap clamped - the loop anyone writes first.
    Scalar,
    /// Row-wise loops shaped so the compiler vectorizes them.
    Autovec,
    /// NEON on aarch64, AVX2 on x86_64 - the run's `simd` field says which.
    Simd,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Hash)]
#[serde(rename_all = "snake_case")]
pub enum Strategy {
    /// Plain buffers, `clEnqueueWriteBuffer`/`clEnqueueReadBuffer`.
    Copy,
    /// Driver-allocated host-visible buffers, mapped and memcpy'd.
    Map,
    /// The application's own memory wrapped by the driver; only map/unmap per frame.
    ZeroCopy,
}

/// How a GPU kernel is written. Debayer only distinguishes `Naive` (a pixel per work-item)
/// and the vector widths, capped at eight.
#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Hash)]
#[serde(rename_all = "snake_case")]
pub enum Variant {
    /// Blur: the full 2D window per pixel.
    Naive,
    Separable,
    /// Separable, with each work-group's tile and halo staged in local memory.
    Local,
    /// Separable, reading through image objects and the sampler's clamp-to-edge.
    Image,
    /// Separable, four pixels per work-item through vector loads.
    Vec4,
    Vec8,
    Vec16,
    /// Separable in float; may differ from the integer reference by one.
    F32,
    /// Float maths with the intermediate stored as half.
    F16,
    /// GLES/Vulkan: fully unrolled, weights as literals, the horizontal window read into
    /// registers once, and a clamp-free path away from the edges.
    Unrolled,
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, Eq, Hash)]
#[serde(tag = "api", rename_all = "snake_case")]
pub enum Backend {
    Cpu {
        level: CpuLevel,
        threads: u32,
    },
    OpenCl {
        /// The library opened, e.g. `libOpenCL.so.3`.
        lib: String,
        variant: Variant,
        strategy: Strategy,
        local: Option<[u32; 2]>,
    },
    /// GLES 3.1 compute shaders.
    Gles {
        variant: Variant,
        strategy: Strategy,
    },
    /// Vulkan compute pipelines.
    Vulkan {
        variant: Variant,
        strategy: Strategy,
    },
    /// Numbers imported from another program's output; never run here.
    External {
        name: String,
    },
    /// TensorFlow Lite: its CPU kernels, or the NPU through the VX delegate.
    Tflite {
        delegate: TfliteDelegate,
    },
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Hash)]
#[serde(rename_all = "snake_case")]
pub enum TfliteDelegate {
    Cpu {
        threads: u32,
    },
    /// `libvx_delegate.so`: TIM-VX over OpenVX, i.e. the i.MX8MP's NPU.
    Vx,
}

impl Backend {
    /// The accelerator side of a CPU-or-GPU verdict: a GPU API or the NPU.
    pub fn is_gpu(&self) -> bool {
        match self {
            Self::Cpu { .. }
            | Self::Tflite {
                delegate: TfliteDelegate::Cpu { .. },
            } => false,
            Self::External { name } => !name.contains("cpu"),
            _ => true,
        }
    }

    pub fn family(&self) -> String {
        match self {
            Self::Cpu { level, .. } => format!("cpu-{}", level_name(*level)),
            Self::OpenCl { lib, .. } => format!("opencl({})", short_lib(lib)),
            Self::Gles { .. } => "gles".into(),
            Self::Vulkan { .. } => "vulkan".into(),
            Self::External { name } => name.clone(),
            Self::Tflite {
                delegate: TfliteDelegate::Cpu { .. },
            } => "tflite-cpu".into(),
            Self::Tflite {
                delegate: TfliteDelegate::Vx,
            } => "tflite-npu".into(),
        }
    }
}

pub fn level_name(level: CpuLevel) -> &'static str {
    match level {
        CpuLevel::Scalar => "scalar",
        CpuLevel::Autovec => "autovec",
        // Which instruction set is in the run's header; a name that depended on the machine
        // rendering a report would call a board's NEON rows AVX2 on a laptop.
        CpuLevel::Simd => "simd",
    }
}

pub fn variant_name(variant: Variant) -> &'static str {
    match variant {
        Variant::Naive => "naive",
        Variant::Separable => "separable",
        Variant::Local => "local",
        Variant::Image => "image",
        Variant::Vec4 => "vec4",
        Variant::Vec8 => "vec8",
        Variant::Vec16 => "vec16",
        Variant::F32 => "f32",
        Variant::F16 => "f16",
        Variant::Unrolled => "unrolled",
    }
}

pub fn strategy_name(strategy: Strategy) -> &'static str {
    match strategy {
        Strategy::Copy => "copy",
        Strategy::Map => "map",
        Strategy::ZeroCopy => "zero-copy",
    }
}

/// `libOpenCL.so.3` -> `.so.3`; anything else is shown whole.
pub fn short_lib(lib: &str) -> &str {
    lib.rsplit('/')
        .next()
        .and_then(|name| name.strip_prefix("libOpenCL"))
        .filter(|s| !s.is_empty())
        .unwrap_or(lib)
}

impl fmt::Display for Backend {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Cpu { level, threads } => write!(f, "cpu {} {threads}t", level_name(*level)),
            Self::OpenCl {
                lib,
                variant,
                strategy,
                local,
            } => {
                write!(
                    f,
                    "opencl{} {} {}",
                    short_lib(lib),
                    variant_name(*variant),
                    strategy_name(*strategy)
                )?;
                if let Some([x, y]) = local {
                    write!(f, " wg={x}x{y}")?;
                }
                Ok(())
            }
            Self::Gles { variant, strategy } => {
                write!(f, "gles {} {}", variant_name(*variant), strategy_name(*strategy))
            }
            Self::Vulkan { variant, strategy } => {
                write!(f, "vulkan {} {}", variant_name(*variant), strategy_name(*strategy))
            }
            Self::External { name } => write!(f, "{name}"),
            Self::Tflite {
                delegate: TfliteDelegate::Cpu { threads },
            } => write!(f, "tflite cpu {threads}t"),
            Self::Tflite {
                delegate: TfliteDelegate::Vx,
            } => write!(f, "tflite npu (vx delegate)"),
        }
    }
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct RowSpec {
    pub task: Task,
    pub backend: Backend,
    /// A work-group sweep row: grouped apart, so it does not crowd the main comparison.
    #[serde(default)]
    pub sweep: bool,
    /// Throughput rather than latency: frames back to back, nothing waited for in between.
    #[serde(default)]
    pub stream: bool,
    /// A long stream, kept apart: its interest is how the frame time moves.
    #[serde(default)]
    pub soak: bool,
    /// Check every frame's output against the reference, not only the last one.
    #[serde(default)]
    pub verify_all: bool,
    pub budget_ms: u64,
    pub min_reps: u32,
    pub max_reps: u32,
}

impl RowSpec {
    /// Rows in one group compute the same thing and are compared with each other.
    pub fn group(&self) -> String {
        match (self.sweep, self.stream, self.soak) {
            (true, ..) => format!("{} (work-group sweep)", self.task),
            (_, _, true) => format!("{} (soak {}s)", self.task, self.budget_ms / 1000),
            (_, true, _) => format!("{} (stream)", self.task),
            _ => self.task.to_string(),
        }
    }

    pub fn id(&self) -> String {
        format!("{} | {}", self.group(), self.backend)
    }
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum RowStatus {
    Ok,
    /// Ran, and the output differs from the CPU reference.
    Mismatch,
    /// Not available here: no such library, no device, an unsupported image format.
    Unsupported,
    /// Setup or a frame returned an error.
    Failed,
    Crash,
    Hang,
}

impl RowStatus {
    pub fn has_time(self) -> bool {
        matches!(self, Self::Ok | Self::Mismatch)
    }
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, Default, PartialEq)]
pub struct Stats {
    pub median: f64,
    pub p95: f64,
    pub min: f64,
    pub mean: f64,
}

impl Stats {
    pub fn of(values: &[f64]) -> Option<Self> {
        if values.is_empty() {
            return None;
        }
        let mut sorted = values.to_vec();
        sorted.sort_by(f64::total_cmp);
        let at = |q: f64| sorted[((sorted.len() - 1) as f64 * q).round() as usize];
        Some(Self {
            median: at(0.5),
            p95: at(0.95),
            min: sorted[0],
            mean: sorted.iter().sum::<f64>() / sorted.len() as f64,
        })
    }
}

#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct Timings {
    pub total: Option<Stats>,
    pub upload: Option<Stats>,
    pub compute: Option<Stats>,
    pub download: Option<Stats>,
    /// Kernel time as the device's own profiling counters saw it.
    pub gpu: Option<Stats>,
    /// CPU time the process used per frame, all its threads together - what a GPU row
    /// still costs the CPU, and what a CPU row costs it.
    #[serde(default)]
    pub cpu: Option<Stats>,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct RowResult {
    pub status: RowStatus,
    pub detail: String,
    /// Building programs, allocating buffers - once per row, not per frame.
    pub setup_ms: Option<f64>,
    pub first_frame_ms: Option<f64>,
    pub reps: u32,
    pub timings: Timings,
    /// Largest per-byte difference from the reference, when one is tolerated.
    pub max_error: Option<u32>,
    /// Every frame as [upload, compute, download] in ms.
    pub frames: Vec<[f32; 3]>,
}

impl RowResult {
    pub fn status(status: RowStatus, detail: impl Into<String>) -> Self {
        Self {
            status,
            detail: detail.into(),
            setup_ms: None,
            first_frame_ms: None,
            reps: 0,
            timings: Timings::default(),
            max_error: None,
            frames: Vec::new(),
        }
    }

    pub fn total_ms(&self) -> Option<f64> {
        self.status
            .has_time()
            .then(|| self.timings.total.map(|t| t.median))
            .flatten()
    }
}

/// What a probe found behind one OpenCL library.
#[derive(Serialize, Deserialize, Clone, Debug, Default, PartialEq)]
pub struct ClDevice {
    pub lib: String,
    pub platform: String,
    pub platform_version: String,
    pub device: String,
    pub device_version: String,
    pub driver_version: String,
    pub is_gpu: bool,
    pub compute_units: u32,
    pub max_work_group: u64,
    pub local_mem_kb: u64,
    pub global_mem_mb: u64,
    pub image_support: bool,
    pub unified_memory: bool,
    pub il_version: String,
    pub extensions: String,
}

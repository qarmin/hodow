//! Which rows a run executes. Three profiles of one matrix; the axes that multiply fastest
//! (transfer strategy, work-group shape, library) are only crossed where they answer
//! something.

use hodow_bench::bench::spec::{Backend, CpuLevel, RowSpec, Strategy, Task, TfliteDelegate, Variant};

use super::protocol::Probe;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Profile {
    Quick,
    Default,
    Full,
}

impl Profile {
    pub fn name(self) -> &'static str {
        match self {
            Profile::Quick => "quick",
            Profile::Default => "default",
            Profile::Full => "full",
        }
    }

    fn budget(self) -> (u64, u32, u32) {
        match self {
            Profile::Quick => (400, 5, 200),
            Profile::Default => (1000, 10, 300),
            Profile::Full => (2500, 15, 500),
        }
    }
}

/// The camera's full frame; the pipeline halves it.
pub const CAMERA: (u32, u32) = (1920, 1080);
/// The eye-tracking crop.
pub const CROP: (u32, u32) = (640, 480);
const SWEEP_RADIUS: u32 = 8;
const SWEEP_SIZE: (u32, u32) = (960, 540);
const SWEEP_SHAPES: &[[u32; 2]] = &[
    [16, 1],
    [32, 1],
    [64, 1],
    [128, 1],
    [256, 1],
    [8, 8],
    [16, 4],
    [16, 8],
    [32, 4],
    [32, 8],
    [16, 16],
    [64, 4],
];
const LOCAL_SHAPES: &[[u32; 2]] = &[[16, 4], [16, 8], [32, 4], [32, 8], [64, 4], [16, 16]];

/// The general kernels of a profile.
fn general(profile: Profile) -> Vec<Task> {
    let mut tasks = vec![
        Task::Gemm { n: 256, float: true },
        Task::Mandelbrot {
            width: 960,
            height: 540,
        },
    ];
    if profile == Profile::Quick {
        return tasks;
    }
    tasks.extend([
        Task::Gemm { n: 256, float: false },
        Task::Gemm { n: 512, float: true },
        Task::Gemm { n: 512, float: false },
        Task::Reduce { n: 4 << 20 },
        Task::Alu {
            n: 1 << 20,
            float: false,
        },
        Task::Alu {
            n: 1 << 20,
            float: true,
        },
        Task::Sort { n: 1 << 20 },
    ]);
    if profile == Profile::Full {
        tasks.extend([
            Task::Gemm { n: 1024, float: true },
            Task::Reduce { n: 16 << 20 },
            Task::Mandelbrot {
                width: 1920,
                height: 1080,
            },
            Task::Sort { n: 4 << 20 },
        ]);
    }
    tasks
}

struct Matrix {
    /// Bayer sizes of the eye-tracking pipeline, and gray sizes of its kernels alone.
    eye_sizes: Vec<(u32, u32)>,
    eye_kernel_sizes: Vec<(u32, u32)>,
    pipeline_sizes: Vec<(u32, u32)>,
    pipeline_radii: Vec<u32>,
    blur_sizes: Vec<(u32, u32)>,
    blur_radii: Vec<u32>,
    debayer_sizes: Vec<(u32, u32)>,
    transfer_bytes: Vec<u64>,
    copy_bytes: Vec<u64>,
    blur_variants: Vec<Variant>,
    pipeline_variants: Vec<Variant>,
    strategies: Vec<Strategy>,
    /// GLES and Vulkan: pixels packed in words, so only whole-word shapes exist.
    packed_variants: Vec<Variant>,
    sweep: bool,
    all_libs_everywhere: bool,
}

fn matrix(profile: Profile) -> Matrix {
    const MB: u64 = 1 << 20;
    let all_radii = vec![0, 1, 2, 4, 8, 16, 32];
    let all_variants = vec![
        Variant::Naive,
        Variant::Separable,
        Variant::Local,
        Variant::Image,
        Variant::Vec4,
        Variant::Vec8,
        Variant::Vec16,
        Variant::F32,
        Variant::F16,
    ];
    match profile {
        Profile::Quick => Matrix {
            eye_sizes: vec![CROP],
            eye_kernel_sizes: vec![],
            pipeline_sizes: vec![CAMERA],
            pipeline_radii: vec![0, 4, 16],
            blur_sizes: vec![],
            blur_radii: vec![],
            debayer_sizes: vec![CROP],
            transfer_bytes: vec![4 * MB],
            copy_bytes: vec![16 * MB],
            blur_variants: vec![],
            pipeline_variants: vec![Variant::Vec4, Variant::Vec8, Variant::Vec16],
            strategies: vec![Strategy::Copy, Strategy::ZeroCopy],
            packed_variants: vec![Variant::Vec4, Variant::Unrolled],
            sweep: false,
            all_libs_everywhere: false,
        },
        Profile::Default => Matrix {
            eye_sizes: vec![CROP, CAMERA],
            eye_kernel_sizes: vec![(320, 240), (960, 540)],
            pipeline_sizes: vec![CAMERA, CROP],
            pipeline_radii: all_radii,
            blur_sizes: vec![CROP, (960, 540), CAMERA],
            blur_radii: vec![1, 4, 16],
            debayer_sizes: vec![CROP, CAMERA],
            transfer_bytes: vec![64 << 10, MB, 4 * MB, 16 * MB],
            copy_bytes: vec![16 * MB],
            blur_variants: all_variants,
            pipeline_variants: vec![
                Variant::Separable,
                Variant::Local,
                Variant::Image,
                Variant::Vec8,
                Variant::Vec16,
            ],
            strategies: vec![Strategy::Copy, Strategy::Map, Strategy::ZeroCopy],
            packed_variants: vec![Variant::Vec4, Variant::Local, Variant::Unrolled],
            sweep: true,
            all_libs_everywhere: false,
        },
        Profile::Full => Matrix {
            eye_sizes: vec![CROP, CAMERA],
            eye_kernel_sizes: vec![(320, 240), (960, 540), (1920, 1080)],
            pipeline_sizes: vec![CAMERA, CROP],
            pipeline_radii: all_radii.clone(),
            blur_sizes: vec![(320, 240), CROP, (960, 540), CAMERA, (3840, 2160)],
            blur_radii: all_radii,
            debayer_sizes: vec![CROP, (1280, 720), CAMERA, (3840, 2160)],
            transfer_bytes: vec![4 << 10, 64 << 10, MB, 4 * MB, 16 * MB, 64 * MB],
            copy_bytes: vec![MB, 16 * MB, 64 * MB],
            blur_variants: all_variants.clone(),
            pipeline_variants: all_variants,
            strategies: vec![Strategy::Copy, Strategy::Map, Strategy::ZeroCopy],
            packed_variants: vec![
                Variant::Naive,
                Variant::Vec4,
                Variant::Vec8,
                Variant::Vec16,
                Variant::Local,
                Variant::Unrolled,
            ],
            sweep: true,
            all_libs_everywhere: true,
        },
    }
}

/// 1, all but one (left for the rest of the system) and all of the cores this process may use.
fn thread_counts(threads: u32) -> Vec<u32> {
    let mut counts = vec![1];
    if threads > 2 {
        counts.push(threads - 1);
    }
    if threads > 1 {
        counts.push(threads);
    }
    counts
}

/// The library reporting the newest OpenCL version - the one every row runs on, while the
/// others only repeat the rows that compare libraries.
fn primary_lib(probe: &Probe) -> Option<&str> {
    probe
        .devices
        .iter()
        .max_by(|a, b| a.platform_version.cmp(&b.platform_version))
        .map(|d| d.lib.as_str())
}

/// The eye pipeline streamed for `secs` on each backend's best-known shape.
pub fn soak_rows(secs: u64, probe: &Probe) -> Vec<RowSpec> {
    let threads = probe.threads.max(1);
    let mut backends = vec![Backend::Cpu {
        level: if probe.simd.is_some() {
            CpuLevel::Simd
        } else {
            CpuLevel::Autovec
        },
        threads,
    }];
    if let Some(lib) = primary_lib(probe) {
        backends.push(Backend::OpenCl {
            lib: lib.to_string(),
            variant: Variant::Vec16,
            strategy: Strategy::ZeroCopy,
            local: None,
        });
    }
    if probe.gles.is_some() {
        backends.push(Backend::Gles {
            variant: Variant::Unrolled,
            strategy: Strategy::Map,
        });
    }
    if probe.vulkan.is_some() {
        backends.push(Backend::Vulkan {
            variant: Variant::Unrolled,
            strategy: Strategy::Map,
        });
    }
    backends
        .into_iter()
        .map(|backend| RowSpec {
            task: Task::Eye {
                width: CROP.0,
                height: CROP.1,
            },
            backend,
            sweep: false,
            stream: true,
            soak: true,
            verify_all: false,
            budget_ms: secs * 1000,
            min_reps: 3,
            max_reps: u32::MAX,
        })
        .collect()
}

pub fn rows(profile: Profile, probe: &Probe) -> Vec<RowSpec> {
    let m = matrix(profile);
    let (budget_ms, min_reps, max_reps) = profile.budget();
    let threads = thread_counts(probe.threads);
    let mut cpu: Vec<Backend> = vec![Backend::Cpu {
        level: CpuLevel::Scalar,
        threads: 1,
    }];
    let mut levels = vec![CpuLevel::Autovec];
    if probe.simd.is_some() {
        levels.push(CpuLevel::Simd);
    }
    for level in levels {
        for &t in &threads {
            if profile == Profile::Quick && t != probe.threads {
                continue;
            }
            cpu.push(Backend::Cpu { level, threads: t });
        }
    }
    let primary = primary_lib(probe);
    let libs: Vec<&str> = probe.devices.iter().map(|d| d.lib.as_str()).collect();
    let gpu = |lib: &str, variant, strategy| Backend::OpenCl {
        lib: lib.to_string(),
        variant,
        strategy,
        local: None,
    };
    // GLES and Vulkan backends by strategy; zero-copy exists in neither (yet).
    let mut packed: Vec<fn(Variant, Strategy) -> Backend> = Vec::new();
    if probe.gles.is_some() {
        packed.push(|variant, strategy| Backend::Gles { variant, strategy });
    }
    if probe.vulkan.is_some() {
        packed.push(|variant, strategy| Backend::Vulkan { variant, strategy });
    }
    let packed_strategies: Vec<Strategy> = m
        .strategies
        .iter()
        .copied()
        .filter(|&s| s != Strategy::ZeroCopy)
        .collect();
    let mut out = Vec::new();
    let mut push = |task: Task, backend: Backend, sweep: bool| {
        out.push(RowSpec {
            task,
            backend,
            sweep,
            stream: false,
            soak: false,
            verify_all: false,
            budget_ms,
            min_reps,
            max_reps,
        })
    };
    let libs_for = |every: bool| -> Vec<&str> {
        if every || m.all_libs_everywhere {
            libs.clone()
        } else {
            primary.into_iter().collect()
        }
    };

    for &(width, height) in &m.eye_sizes {
        let task = Task::Eye { width, height };
        for b in &cpu {
            push(task, b.clone(), false);
        }
        let cl_variants: &[Variant] = if profile == Profile::Quick {
            &[Variant::Vec16]
        } else {
            &[Variant::Separable, Variant::Vec8, Variant::Vec16]
        };
        for lib in libs_for(true) {
            for &variant in cl_variants {
                for &strategy in &m.strategies {
                    push(task, gpu(lib, variant, strategy), false);
                }
            }
        }
        for api in &packed {
            for variant in [Variant::Vec4, Variant::Unrolled] {
                for &strategy in &packed_strategies {
                    push(task, api(variant, strategy), false);
                }
            }
        }
    }
    for &(width, height) in &m.eye_kernel_sizes {
        for task in [
            Task::Morph { width, height },
            Task::Sobel { width, height },
            Task::Histogram { width, height },
            Task::Moments { width, height },
        ] {
            for b in cpu.iter().filter(|b| {
                !matches!(
                    b,
                    Backend::Cpu {
                        level: CpuLevel::Simd,
                        ..
                    }
                )
            }) {
                push(task, b.clone(), false);
            }
            let histogram = matches!(task, Task::Histogram { .. });
            let variants: &[Variant] = if histogram {
                &[Variant::Naive, Variant::Local]
            } else {
                &[Variant::Naive]
            };
            for lib in libs_for(false) {
                for &variant in variants {
                    push(task, gpu(lib, variant, Strategy::Copy), false);
                }
            }
            let variants: &[Variant] = if histogram {
                &[Variant::Naive, Variant::Local]
            } else {
                &[Variant::Vec4]
            };
            for api in &packed {
                for &variant in variants {
                    push(task, api(variant, Strategy::Copy), false);
                }
            }
        }
    }
    for &(width, height) in &m.pipeline_sizes {
        // Every radius at the camera's size, the colleague's table; the crop only around the
        // eye tracker's own radius, unless the profile asks for everything.
        let radii: Vec<u32> = if (width, height) == CAMERA || m.all_libs_everywhere {
            m.pipeline_radii.clone()
        } else {
            m.pipeline_radii
                .iter()
                .copied()
                .filter(|r| (2..=4).contains(r))
                .collect()
        };
        for radius in radii {
            let task = Task::Pipeline { width, height, radius };
            for b in &cpu {
                push(task, b.clone(), false);
            }
            for lib in libs_for(true) {
                let secondary = Some(lib) != primary && !m.all_libs_everywhere;
                for &variant in &m.pipeline_variants {
                    for &strategy in &m.strategies {
                        // Strategy only changes the transfers, so the slow variants run with one.
                        let only_copy = matches!(
                            variant,
                            Variant::Naive | Variant::Local | Variant::Image | Variant::F32 | Variant::F16
                        );
                        if only_copy && strategy != Strategy::Copy {
                            continue;
                        }
                        // Another library only has to answer whether it is faster at its best.
                        if secondary && (variant != Variant::Vec16 || strategy == Strategy::Map) {
                            continue;
                        }
                        push(task, gpu(lib, variant, strategy), false);
                    }
                }
            }
            for api in &packed {
                for &variant in &m.packed_variants {
                    for &strategy in &packed_strategies {
                        if matches!(variant, Variant::Naive | Variant::Local | Variant::Vec8)
                            && strategy != Strategy::Copy
                        {
                            continue;
                        }
                        push(task, api(variant, strategy), false);
                    }
                }
            }
        }
    }
    for &(width, height) in &m.debayer_sizes {
        let task = Task::Debayer { width, height };
        for b in &cpu {
            push(task, b.clone(), false);
        }
        for lib in libs_for(false) {
            for variant in [Variant::Naive, Variant::Vec4, Variant::Vec8] {
                for &strategy in &m.strategies {
                    push(task, gpu(lib, variant, strategy), false);
                }
            }
        }
        for api in &packed {
            for variant in [Variant::Vec4, Variant::Vec16] {
                for &strategy in &packed_strategies {
                    push(task, api(variant, strategy), false);
                }
            }
        }
    }
    for &(width, height) in &m.blur_sizes {
        for &radius in &m.blur_radii {
            let task = Task::Blur { width, height, radius };
            for b in &cpu {
                push(task, b.clone(), false);
            }
            for lib in libs_for(false) {
                for &variant in &m.blur_variants {
                    push(task, gpu(lib, variant, Strategy::Copy), false);
                }
            }
            if !m.blur_variants.is_empty() {
                for api in &packed {
                    for &variant in &m.packed_variants {
                        push(task, api(variant, Strategy::Copy), false);
                    }
                }
            }
        }
    }
    if m.sweep {
        let (width, height) = SWEEP_SIZE;
        for lib in libs_for(false) {
            let blur = Task::Blur {
                width,
                height,
                radius: SWEEP_RADIUS,
            };
            for &shape in SWEEP_SHAPES {
                push(
                    blur,
                    Backend::OpenCl {
                        lib: lib.into(),
                        variant: Variant::Separable,
                        strategy: Strategy::Copy,
                        local: Some(shape),
                    },
                    true,
                );
            }
            for &shape in LOCAL_SHAPES {
                push(
                    blur,
                    Backend::OpenCl {
                        lib: lib.into(),
                        variant: Variant::Local,
                        strategy: Strategy::Copy,
                        local: Some(shape),
                    },
                    true,
                );
            }
            let debayer = Task::Debayer {
                width: CAMERA.0,
                height: CAMERA.1,
            };
            for &shape in SWEEP_SHAPES {
                push(
                    debayer,
                    Backend::OpenCl {
                        lib: lib.into(),
                        variant: Variant::Naive,
                        strategy: Strategy::Copy,
                        local: Some(shape),
                    },
                    true,
                );
            }
        }
    }
    for &bytes in &m.transfer_bytes {
        for lib in libs_for(true) {
            for task in [Task::Upload { bytes }, Task::Download { bytes }] {
                for &strategy in &m.strategies {
                    push(task, gpu(lib, Variant::Separable, strategy), false);
                }
            }
        }
    }
    for &bytes in &m.transfer_bytes {
        for api in &packed {
            for task in [Task::Upload { bytes }, Task::Download { bytes }] {
                for &strategy in &packed_strategies {
                    push(task, api(Variant::Vec4, strategy), false);
                }
            }
        }
    }
    for &bytes in &m.copy_bytes {
        let task = Task::Copy { bytes };
        push(
            task,
            Backend::Cpu {
                level: CpuLevel::Autovec,
                threads: 1,
            },
            false,
        );
        for lib in libs_for(true) {
            push(task, gpu(lib, Variant::Separable, Strategy::Copy), false);
        }
        for api in &packed {
            push(task, api(Variant::Vec4, Strategy::Copy), false);
        }
    }
    // TensorFlow Lite: its CPU kernels on one and on every core, and the NPU.
    if probe.tflite.is_some() {
        let tflite = [
            TfliteDelegate::Cpu { threads: 1 },
            TfliteDelegate::Cpu {
                threads: probe.threads.max(1),
            },
            TfliteDelegate::Vx,
        ];
        let mut tasks = vec![Task::Cnn { size: 224 }];
        for &(width, height) in &m.blur_sizes {
            for &radius in m.blur_radii.iter().filter(|&&r| r > 0) {
                tasks.push(Task::Blur { width, height, radius });
            }
        }
        if profile == Profile::Quick {
            tasks.push(Task::Blur {
                width: 960,
                height: 540,
                radius: 4,
            });
        }
        for task in tasks {
            for delegate in tflite {
                push(task, Backend::Tflite { delegate }, false);
            }
        }
    }
    for task in general(profile) {
        // The textbook loop is minutes on a board for anything bigger.
        let scalar_too = !matches!(task, Task::Gemm { n, .. } if n > 256);
        for b in cpu.iter().filter(|b| {
            !matches!(
                b,
                Backend::Cpu {
                    level: CpuLevel::Simd,
                    ..
                }
            )
        }) {
            if scalar_too
                || !matches!(
                    b,
                    Backend::Cpu {
                        level: CpuLevel::Scalar,
                        ..
                    }
                )
            {
                push(task, b.clone(), false);
            }
        }
        let (cl, packed_variants): (&[Variant], &[Variant]) = match task {
            Task::Gemm { .. } => (&[Variant::Naive, Variant::Local], &[Variant::Naive, Variant::Local]),
            Task::Reduce { .. } => (&[Variant::Local], &[Variant::Local]),
            _ => (&[Variant::Naive], &[Variant::Vec4]),
        };
        for lib in libs_for(false) {
            for &variant in cl {
                push(task, gpu(lib, variant, Strategy::Copy), false);
            }
        }
        for api in &packed {
            for &variant in packed_variants {
                push(task, api(variant, Strategy::Copy), false);
            }
        }
    }
    // Throughput of the two frame loops that matter, on each backend's best-known shape.
    let mut streams = vec![Task::Eye {
        width: CROP.0,
        height: CROP.1,
    }];
    if profile != Profile::Quick {
        streams.push(Task::Pipeline {
            width: CAMERA.0,
            height: CAMERA.1,
            radius: 4,
        });
    }
    let all_cores = probe.threads.max(1);
    for task in streams {
        let mut backends: Vec<Backend> = vec![Backend::Cpu {
            level: CpuLevel::Autovec,
            threads: all_cores,
        }];
        if probe.simd.is_some() {
            backends.push(Backend::Cpu {
                level: CpuLevel::Simd,
                threads: all_cores,
            });
        }
        for lib in primary.into_iter() {
            for strategy in [Strategy::Copy, Strategy::ZeroCopy] {
                backends.push(gpu(lib, Variant::Vec16, strategy));
            }
        }
        for api in &packed {
            for &strategy in &packed_strategies {
                backends.push(api(Variant::Unrolled, strategy));
            }
        }
        for backend in backends {
            out.push(RowSpec {
                task,
                backend,
                sweep: false,
                stream: true,
                soak: false,
                verify_all: false,
                budget_ms,
                min_reps,
                max_reps,
            });
        }
    }
    let mut push = |task: Task, backend: Backend| {
        out.push(RowSpec {
            task,
            backend,
            sweep: false,
            stream: false,
            soak: false,
            verify_all: false,
            budget_ms,
            min_reps,
            max_reps,
        })
    };
    for &t in &threads {
        push(
            Task::Dispatch,
            Backend::Cpu {
                level: CpuLevel::Autovec,
                threads: t,
            },
        );
    }
    for lib in libs_for(true) {
        push(Task::Dispatch, gpu(lib, Variant::Separable, Strategy::Copy));
    }
    for api in &packed {
        push(Task::Dispatch, api(Variant::Vec4, Strategy::Copy));
    }
    out
}

/// Rows whose task text contains any of `kernels` and whose backend text contains any of
/// `backends`; an empty list matches everything. `sweep` matches the work-group sweeps.
pub fn filter(rows: Vec<RowSpec>, kernels: &[String], backends: &[String]) -> Vec<RowSpec> {
    let any =
        |patterns: &[String], text: &str| patterns.is_empty() || patterns.iter().any(|p| text.contains(p.as_str()));
    rows.into_iter()
        .filter(|r| any(kernels, &r.group()) && any(backends, &r.backend.to_string()))
        .collect()
}

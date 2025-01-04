//! Whole processing flows - a camera frame in, a result out - run on each device in the way
//! that suits it and checked against one scalar reference.
//!
//! The single-operation tests ask whether an instruction or a call is right; these ask
//! whether a pipeline of them still is when a CPU splits it across every core with SIMD and a
//! GPU runs a pixel per invocation. The implementations are the ones `hodow bench` times
//! (`crate::bench`), here run for a verdict instead of a duration.

use std::sync::atomic::{AtomicBool, AtomicU8, Ordering};

use crate::bench::cpu::CpuBench;
use crate::bench::data::{Tile, with_tile};
#[cfg(feature = "bench_gles")]
use crate::bench::gles;
use crate::bench::spec::{Backend, CpuLevel, RowSpec, RowStatus, Task};
#[cfg(any(feature = "bench_gles", feature = "vulkan"))]
use crate::bench::spec::{Strategy, Variant};
#[cfg(feature = "vulkan")]
use crate::bench::vk;
use crate::bench::{self, Bench, Cache};

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum FlowSize {
    /// Quarter-area frames and a few repetitions: seconds even on a small board.
    Small,
    /// The size the camera pipeline really runs at, and a longer repetition count.
    Full,
}

static SIZE: AtomicU8 = AtomicU8::new(0);

pub fn set_size(size: FlowSize) {
    SIZE.store(size as u8, Ordering::Relaxed);
}

static ENABLED: AtomicBool = AtomicBool::new(false);

/// Whether the flows join the test lists; off unless `--flows`.
pub fn enabled() -> bool {
    ENABLED.load(Ordering::Relaxed)
}

pub fn set_enabled(on: bool) {
    ENABLED.store(on, Ordering::Relaxed);
}

pub fn size() -> FlowSize {
    if SIZE.load(Ordering::Relaxed) == FlowSize::Full as u8 {
        FlowSize::Full
    } else {
        FlowSize::Small
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Device {
    Cpu,
    #[cfg(feature = "bench_gles")]
    Gles,
    #[cfg(feature = "vulkan")]
    Vulkan,
}

impl Device {
    fn backend(self, flow: Flow) -> Backend {
        match self {
            Device::Cpu => {
                // Hand-written SIMD exists for the image kernels only; the rest is the vectorized loop.
                let level = if flow.has_simd() && bench::cpu::simd_name().is_some() {
                    CpuLevel::Simd
                } else {
                    CpuLevel::Autovec
                };
                let threads = std::thread::available_parallelism().map_or(1, |n| n.get() as u32);
                Backend::Cpu { level, threads }
            }
            #[cfg(feature = "bench_gles")]
            Device::Gles => Backend::Gles {
                variant: flow.gpu_variant(),
                strategy: flow.strategy(),
            },
            #[cfg(feature = "vulkan")]
            Device::Vulkan => Backend::Vulkan {
                variant: flow.gpu_variant(),
                strategy: flow.strategy(),
            },
        }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Flow {
    /// RG10 Bayer -> debayer -> blur -> opened pupil mask -> per-row pupil and glint moments.
    Eye,
    /// RG10 Bayer -> debayer -> blur -> half-size NV12 frame.
    Camera,
    Debayer,
    /// Pupil threshold, 3x3 erosion and dilation.
    Morph,
    Sobel,
    /// 256-bin histogram: every invocation adds to shared bins.
    Histogram,
    Moments,
    GemmI32,
    /// Wrapping sum of words, a tree across work-groups.
    Reduce,
    /// Divergent loops with an exact integer answer.
    Mandelbrot,
    AluU32,
    /// Bitonic network on the GPU, a sort on the CPU.
    Sort,
    /// The frame cut into a grid of tiles, each its own scene region and its own buffers, all
    /// resident at once and processed in turn; a CPU gives every tile a thread.
    TiledEye,
    /// Tiled the same way, and the tiles' histograms added up must equal the whole frame's.
    TiledHistogram,
    /// Horizontal bands of the frame; their rows put back to back must equal the whole frame's.
    TiledMoments,
}

/// `(flow, name, GL test name, CPU test name)`; the names are tables because a test list wants `&'static str`.
const NAMES: &[(Flow, &str, &str, &str)] = &[
    (
        Flow::Eye,
        "eye_pipeline",
        "Flow_Eye_Pipeline",
        "test_flow_eye_pipeline_cpu",
    ),
    (
        Flow::Camera,
        "camera_pipeline",
        "Flow_Camera_Pipeline",
        "test_flow_camera_pipeline_cpu",
    ),
    (Flow::Debayer, "debayer", "Flow_Debayer", "test_flow_debayer_cpu"),
    (Flow::Morph, "morph", "Flow_Morph", "test_flow_morph_cpu"),
    (Flow::Sobel, "sobel", "Flow_Sobel", "test_flow_sobel_cpu"),
    (
        Flow::Histogram,
        "histogram",
        "Flow_Histogram",
        "test_flow_histogram_cpu",
    ),
    (Flow::Moments, "moments", "Flow_Moments", "test_flow_moments_cpu"),
    (Flow::GemmI32, "gemm_i32", "Flow_Gemm_I32", "test_flow_gemm_i32_cpu"),
    (Flow::Reduce, "reduce", "Flow_Reduce", "test_flow_reduce_cpu"),
    (
        Flow::Mandelbrot,
        "mandelbrot",
        "Flow_Mandelbrot",
        "test_flow_mandelbrot_cpu",
    ),
    (Flow::AluU32, "alu_u32", "Flow_Alu_U32", "test_flow_alu_u32_cpu"),
    (Flow::Sort, "sort", "Flow_Sort", "test_flow_sort_cpu"),
    (
        Flow::TiledEye,
        "tiled_eye_pipeline",
        "Flow_Tiled_Eye_Pipeline",
        "test_flow_tiled_eye_pipeline_cpu",
    ),
    (
        Flow::TiledHistogram,
        "tiled_histogram",
        "Flow_Tiled_Histogram",
        "test_flow_tiled_histogram_cpu",
    ),
    (
        Flow::TiledMoments,
        "tiled_moments",
        "Flow_Tiled_Moments",
        "test_flow_tiled_moments_cpu",
    ),
];

impl Flow {
    pub const ALL: &'static [Flow] = &[
        Flow::Eye,
        Flow::Camera,
        Flow::Debayer,
        Flow::Morph,
        Flow::Sobel,
        Flow::Histogram,
        Flow::Moments,
        Flow::GemmI32,
        Flow::Reduce,
        Flow::Mandelbrot,
        Flow::AluU32,
        Flow::Sort,
        Flow::TiledEye,
        Flow::TiledHistogram,
        Flow::TiledMoments,
    ];

    fn names(self) -> &'static (Flow, &'static str, &'static str, &'static str) {
        NAMES.iter().find(|n| n.0 == self).expect("every flow is in NAMES")
    }

    pub fn name(self) -> &'static str {
        self.names().1
    }

    pub fn gl_test_name(self) -> &'static str {
        self.names().2
    }

    pub fn cpu_test_name(self) -> &'static str {
        self.names().3
    }

    fn has_simd(self) -> bool {
        matches!(self, Flow::Eye | Flow::Camera | Flow::Debayer | Flow::TiledEye)
    }

    #[cfg(any(feature = "bench_gles", feature = "vulkan"))]
    fn gpu_variant(self) -> Variant {
        match self {
            Flow::Eye | Flow::Camera | Flow::TiledEye => Variant::Unrolled,
            Flow::Histogram | Flow::GemmI32 | Flow::Reduce | Flow::TiledHistogram => Variant::Local,
            Flow::Debayer
            | Flow::Morph
            | Flow::Sobel
            | Flow::Moments
            | Flow::Mandelbrot
            | Flow::AluU32
            | Flow::Sort
            | Flow::TiledMoments => Variant::Vec4,
        }
    }

    #[cfg(any(feature = "bench_gles", feature = "vulkan"))]
    fn strategy(self) -> Strategy {
        if matches!(self, Flow::Eye | Flow::TiledEye) {
            Strategy::Map
        } else {
            Strategy::Copy
        }
    }

    fn task(self, size: FlowSize) -> Task {
        let small = size == FlowSize::Small;
        let (w, h) = if small { (320, 240) } else { (640, 480) };
        match self {
            Flow::Eye => Task::Eye { width: w, height: h },
            Flow::Camera => {
                let (width, height) = if small { (640, 480) } else { (1920, 1080) };
                Task::Pipeline {
                    width,
                    height,
                    radius: 2,
                }
            }
            Flow::Debayer => {
                let (width, height) = if small { (640, 480) } else { (1920, 1080) };
                Task::Debayer { width, height }
            }
            Flow::Morph => Task::Morph { width: w, height: h },
            Flow::Sobel => Task::Sobel { width: w, height: h },
            Flow::Histogram => Task::Histogram { width: w, height: h },
            Flow::Moments => Task::Moments { width: w, height: h },
            Flow::GemmI32 => Task::Gemm {
                n: if small { 64 } else { 256 },
                float: false,
            },
            Flow::Reduce => Task::Reduce {
                n: if small { 1 << 16 } else { 4 << 20 },
            },
            Flow::Mandelbrot => {
                let (width, height) = if small { (128, 96) } else { (640, 480) };
                Task::Mandelbrot { width, height }
            }
            Flow::AluU32 => Task::Alu {
                n: if small { 1 << 12 } else { 1 << 20 },
                float: false,
            },
            Flow::Sort => Task::Sort {
                n: if small { 1 << 12 } else { 1 << 18 },
            },
            Flow::TiledEye | Flow::TiledHistogram | Flow::TiledMoments => {
                unreachable!("a tiled flow has one task per tile")
            }
        }
    }

    /// The frame, its grid of tiles and the task each tile runs, for a tiled flow.
    fn tiling(self, size: FlowSize) -> Option<Tiling> {
        let small = size == FlowSize::Small;
        let (frame, grid) = match self {
            Flow::TiledEye | Flow::TiledHistogram => {
                if small {
                    ((640, 480), (2, 2))
                } else {
                    ((1920, 1080), (3, 3))
                }
            }
            Flow::TiledMoments => {
                if small {
                    ((640, 480), (1, 4))
                } else {
                    ((1920, 1080), (1, 6))
                }
            }
            _ => return None,
        };
        let (tw, th) = (frame.0 / grid.0, frame.1 / grid.1);
        let task = match self {
            Flow::TiledEye => Task::Eye { width: tw, height: th },
            Flow::TiledHistogram => Task::Histogram { width: tw, height: th },
            _ => Task::Moments { width: tw, height: th },
        };
        Some(Tiling {
            frame,
            grid,
            task,
            merge: self != Flow::TiledEye,
            whole: match self {
                Flow::TiledHistogram => Task::Histogram {
                    width: frame.0,
                    height: frame.1,
                },
                _ => Task::Moments {
                    width: frame.0,
                    height: frame.1,
                },
            },
        })
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Outcome {
    Passed(String),
    Unsupported(String),
    Failed(String),
}

fn reps(size: FlowSize) -> u32 {
    match size {
        FlowSize::Small => 3,
        FlowSize::Full => 30,
    }
}

pub fn run(flow: Flow, device: Device, cache: &mut Cache) -> Outcome {
    let size = size();
    if let Some(tiling) = flow.tiling(size) {
        return run_tiled(flow, device, &tiling, size, cache);
    }
    let n = reps(size);
    let spec = RowSpec {
        task: flow.task(size),
        backend: device.backend(flow),
        sweep: false,
        stream: false,
        soak: false,
        verify_all: true,
        budget_ms: if size == FlowSize::Full { 1000 } else { 0 },
        min_reps: n,
        max_reps: n,
    };
    let result = bench::execute(&spec, cache, &mut |_| {});
    let what = format!("{} on {}", spec.task, spec.backend);
    match result.status {
        RowStatus::Ok if result.detail.is_empty() => {
            Outcome::Passed(format!("{what}: {} frames each matched the reference", result.reps))
        }
        RowStatus::Ok => Outcome::Passed(format!(
            "{what}: {} frames each matched the reference ({})",
            result.reps, result.detail
        )),
        RowStatus::Unsupported => Outcome::Unsupported(result.detail),
        RowStatus::Mismatch | RowStatus::Failed | RowStatus::Crash | RowStatus::Hang => {
            Outcome::Failed(format!("{what}: {}", result.detail))
        }
    }
}

struct Tiling {
    frame: (u32, u32),
    grid: (u32, u32),
    /// What one tile runs.
    task: Task,
    /// Whether the tiles' outputs combine into the whole frame's, which is then checked too.
    merge: bool,
    whole: Task,
}

type Tiles = [((u32, u32), Tile)];

impl Tiling {
    fn tiles(&self) -> Vec<((u32, u32), Tile)> {
        let (tw, th) = (self.frame.0 / self.grid.0, self.frame.1 / self.grid.1);
        let (frame_w, frame_h) = self.frame;
        (0..self.grid.1)
            .flat_map(|ty| {
                (0..self.grid.0).map(move |tx| {
                    (
                        (tx, ty),
                        Tile {
                            x0: tx * tw,
                            y0: ty * th,
                            frame_w,
                            frame_h,
                        },
                    )
                })
            })
            .collect()
    }

    /// The whole frame's output from the tiles'.
    fn combine(&self, outputs: &[Vec<u8>]) -> Vec<u8> {
        if matches!(self.whole, Task::Histogram { .. }) {
            let mut bins = vec![0u32; outputs[0].len() / 4];
            for out in outputs {
                for (bin, word) in bins.iter_mut().zip(out.chunks_exact(4)) {
                    *bin = bin.wrapping_add(u32::from_le_bytes(word.try_into().expect("4 bytes")));
                }
            }
            bins.iter().flat_map(|b| b.to_le_bytes()).collect()
        } else {
            outputs.concat()
        }
    }
}

fn tile_failure(pos: (u32, u32), round: u32, what: &str) -> Outcome {
    Outcome::Failed(format!("tile ({}, {}) round {round}: {what}", pos.0, pos.1))
}

/// One thread per tile, each on one core: how a CPU would work through a frame cut in pieces.
fn cpu_tiles(flow: Flow, tiling: &Tiling, tiles: &Tiles, rounds: u32) -> Result<Vec<Vec<u8>>, Outcome> {
    let level = if flow.has_simd() && bench::cpu::simd_name().is_some() {
        CpuLevel::Simd
    } else {
        CpuLevel::Autovec
    };
    let task = tiling.task;
    std::thread::scope(|scope| {
        let handles: Vec<_> = tiles
            .iter()
            .map(|&(pos, tile)| {
                scope.spawn(move || -> Result<Vec<u8>, Outcome> {
                    let (bench, expected) = with_tile(tile, || (CpuBench::new(task, level, 1), bench::reference(task)));
                    let mut bench = bench.map_err(Outcome::Unsupported)?;
                    let mut last = Vec::new();
                    for round in 0..rounds {
                        bench.frame().map_err(|e| tile_failure(pos, round, &e))?;
                        let out = bench.output().map_err(|e| tile_failure(pos, round, &e))?;
                        bench::compare_task(task, &out, &expected, 0).map_err(|e| tile_failure(pos, round, &e))?;
                        last = out;
                    }
                    Ok(last)
                })
            })
            .collect();
        handles
            .into_iter()
            .map(|h| {
                h.join()
                    .unwrap_or_else(|_| Err(Outcome::Failed("a tile thread panicked".into())))
            })
            .collect()
    })
}

/// Every tile's buffers resident at once, a round being one frame for each tile and then every
/// output checked - so a tile's result has to survive the others' work on the same device.
#[cfg(any(feature = "bench_gles", feature = "vulkan"))]
fn gpu_tiles<'s>(
    tiling: &Tiling,
    tiles: &Tiles,
    rounds: u32,
    make: impl Fn(Task) -> Result<Box<dyn Bench + 's>, (RowStatus, String)>,
) -> Result<Vec<Vec<u8>>, Outcome> {
    let mut resident = Vec::new();
    for &(pos, tile) in tiles {
        let (built, expected) = with_tile(tile, || (make(tiling.task), bench::reference(tiling.task)));
        let bench = built.map_err(|(status, e)| {
            if status == RowStatus::Unsupported {
                Outcome::Unsupported(e)
            } else {
                tile_failure(pos, 0, &e)
            }
        })?;
        resident.push((pos, bench, expected));
    }
    let mut last = Vec::new();
    for round in 0..rounds {
        for (pos, bench, _) in &mut resident {
            bench.frame().map_err(|e| tile_failure(*pos, round, &e))?;
        }
        last.clear();
        for (pos, bench, expected) in &mut resident {
            let out = bench.output().map_err(|e| tile_failure(*pos, round, &e))?;
            bench::compare_task(tiling.task, &out, expected, 0).map_err(|e| tile_failure(*pos, round, &e))?;
            last.push(out);
        }
    }
    Ok(last)
}

fn run_tiled(flow: Flow, device: Device, tiling: &Tiling, size: FlowSize, cache: &mut Cache) -> Outcome {
    let rounds = if size == FlowSize::Full { 10 } else { 3 };
    let tiles = tiling.tiles();
    let outputs = match device {
        Device::Cpu => cpu_tiles(flow, tiling, &tiles, rounds),
        #[cfg(feature = "bench_gles")]
        Device::Gles => match cache.gles() {
            Err(e) => Err(Outcome::Unsupported(e.clone())),
            Ok(session) => gpu_tiles(tiling, &tiles, rounds, |task| {
                gles::GlBench::new(session, task, flow.gpu_variant(), flow.strategy())
                    .map(|b| Box::new(b) as Box<dyn Bench>)
            }),
        },
        #[cfg(feature = "vulkan")]
        Device::Vulkan => match cache.vulkan() {
            Err(e) => Err(Outcome::Unsupported(e.clone())),
            Ok(session) => gpu_tiles(tiling, &tiles, rounds, |task| {
                vk::VkBench::new(session, task, flow.gpu_variant(), flow.strategy())
                    .map(|b| Box::new(b) as Box<dyn Bench>)
            }),
        },
    };
    let _ = &cache;
    let outputs = match outputs {
        Ok(o) => o,
        Err(outcome) => return outcome,
    };
    let what = format!(
        "{} tiles ({}x{} grid of a {}x{} frame) on {}",
        tiles.len(),
        tiling.grid.0,
        tiling.grid.1,
        tiling.frame.0,
        tiling.frame.1,
        device.backend(flow)
    );
    if tiling.merge
        && let Err(e) = bench::compare_task(
            tiling.whole,
            &tiling.combine(&outputs),
            &bench::reference(tiling.whole),
            0,
        )
    {
        return Outcome::Failed(format!(
            "{what}: the tiles put together differ from the whole frame: {e}"
        ));
    }
    let stitched = if tiling.merge {
        ", and put together equal the whole frame"
    } else {
        ""
    };
    Outcome::Passed(format!(
        "{what}: {rounds} rounds, every tile matched its reference{stitched}"
    ))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_tile_is_its_rectangle_of_the_frame() {
        let (fw, fh, tw, th, x0, y0) = (64u32, 48u32, 32u32, 24u32, 32u32, 24u32);
        let whole = crate::bench::data::bayer_rg10(fw, fh);
        let tile = with_tile(
            Tile {
                x0,
                y0,
                frame_w: fw,
                frame_h: fh,
            },
            || crate::bench::data::bayer_rg10(tw, th),
        );
        for y in 0..th {
            for x in 0..tw {
                assert_eq!(
                    tile[(y * tw + x) as usize],
                    whole[((y + y0) * fw + x + x0) as usize],
                    "({x}, {y})"
                );
            }
        }
        assert_ne!(
            tile,
            crate::bench::data::bayer_rg10(tw, th),
            "the tile is not a frame of its own"
        );
    }

    #[test]
    fn every_flow_matches_reference_on_cpu() {
        for &flow in Flow::ALL {
            match run(flow, Device::Cpu, &mut Cache::default()) {
                Outcome::Passed(msg) => eprintln!("{msg}"),
                other => panic!("{}: {other:?}", flow.name()),
            }
        }
    }
}

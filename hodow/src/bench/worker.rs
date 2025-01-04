//! The worker: rows read from stdin one at a time, run in this process. An OpenCL session
//! stays open between rows; whatever a driver does to this process costs only this worker.

use std::io::BufRead;
use std::time::{Duration, Instant};

use hodow_bench::bench::{Cache, execute};

use super::protocol::{Msg, Probe, Request, send};

pub fn run() -> ! {
    // A crashing worker is reported by the orchestrator; a core file only fills the disk.
    let no_core = libc::rlimit {
        rlim_cur: 0,
        rlim_max: 0,
    };
    unsafe { libc::setrlimit(libc::RLIMIT_CORE, &no_core) };
    let mut cache = Cache::default();
    for line in std::io::stdin().lock().lines().map_while(Result::ok) {
        let request: Request = match serde_json::from_str(&line) {
            Ok(r) => r,
            Err(e) => {
                eprintln!("bad request: {e}");
                std::process::exit(3);
            }
        };
        match request {
            Request::Probe => send(&Msg::Probe { probe: probe() }),
            Request::Row { spec } => {
                send(&Msg::Beat { reps: 0 });
                let mut last = Instant::now();
                let mut beat = |reps: u32| {
                    if last.elapsed() >= Duration::from_millis(200) {
                        last = Instant::now();
                        send(&Msg::Beat { reps });
                    }
                };
                let result = execute(&spec, &mut cache, &mut beat);
                send(&Msg::Result {
                    result: Box::new(result),
                });
            }
        }
    }
    std::process::exit(0)
}

fn probe() -> Probe {
    #[cfg(feature = "opencl")]
    let (devices, notes) = hodow_bench::bench::opencl::probe();
    #[cfg(not(feature = "opencl"))]
    let (devices, mut notes) = (Vec::new(), vec!["built without the `opencl` feature".to_string()]);
    #[cfg(feature = "opencl")]
    let mut notes = notes;
    let mut cache = hodow_bench::bench::Cache::default();
    #[cfg(feature = "bench_gles")]
    let gles = match cache.gles() {
        Ok(s) => Some(s.label.clone()),
        Err(e) => {
            notes.push(format!("GLES: {e}"));
            None
        }
    };
    #[cfg(not(feature = "bench_gles"))]
    let gles = None;
    #[cfg(feature = "vulkan")]
    let vulkan = match cache.vulkan() {
        Ok(s) => Some(s.label.clone()),
        Err(e) => {
            notes.push(format!("Vulkan: {e}"));
            None
        }
    };
    #[cfg(not(feature = "vulkan"))]
    let vulkan = None;
    #[cfg(feature = "tflite")]
    let tflite = match cache.tflite() {
        Ok(api) => Some(api.name.clone()),
        Err(e) => {
            notes.push(format!("TFLite: {e}"));
            None
        }
    };
    #[cfg(not(feature = "tflite"))]
    let tflite = None;
    drop(cache);
    Probe {
        tflite,
        devices,
        notes,
        threads: crate::burn::orchestrator::allowed_cpus().len() as u32,
        simd: hodow_bench::bench::cpu::simd_name().map(str::to_string),
        gles,
        vulkan,
    }
}

//! The worker side: one sub-test in its own process, reporting on stdout.
//!
//! Anything that goes wrong in here - a SIGILL, a SIGBUS from bad memory, a driver that
//! never returns - takes this process and nothing else.

use std::sync::Mutex;
use std::sync::atomic::{AtomicU64, AtomicUsize, Ordering};
use std::time::{Duration, Instant};

use super::protocol::{Job, Msg, WorkerSpec, WorkerVerdict, send};

pub enum WorkerError {
    /// Nothing could be tested here; not a finding.
    Skip(String),
    /// The test could not finish - a finding.
    #[cfg(any(feature = "gpu", feature = "vulkan"))]
    Fail(String),
}

#[derive(Default)]
pub struct Sink {
    count: AtomicU64,
    samples: Mutex<Vec<String>>,
}

impl Sink {
    pub fn record(&self, describe: impl FnOnce() -> String) {
        self.count.fetch_add(1, Ordering::Relaxed);
        let mut samples = self.samples.lock().unwrap_or_else(|e| e.into_inner());
        if samples.len() < hodow_gpu::burn::MAX_ERROR_SAMPLES {
            samples.push(describe());
        }
    }

    #[cfg(any(feature = "gpu", feature = "vulkan"))]
    pub fn absorb(&self, count: u64, samples: Vec<String>) {
        self.count.fetch_add(count, Ordering::Relaxed);
        let mut mine = self.samples.lock().unwrap_or_else(|e| e.into_inner());
        let room = hodow_gpu::burn::MAX_ERROR_SAMPLES.saturating_sub(mine.len());
        mine.extend(samples.into_iter().take(room));
    }

    pub fn count(&self) -> u64 {
        self.count.load(Ordering::Relaxed)
    }

    fn samples(&self) -> Vec<String> {
        self.samples.lock().unwrap_or_else(|e| e.into_inner()).clone()
    }
}

/// One thread per item, pinned in turn to `cores`. The calling thread turns movement of
/// `work` into `Beat`s - and only movement, so a thread stuck mid-sweep goes quiet.
pub fn run_pinned<T: Send>(items: Vec<T>, cores: &[usize], work: &AtomicU64, f: impl Fn(usize, T) + Sync) {
    let finished = AtomicUsize::new(0);
    let threads = items.len();
    std::thread::scope(|scope| {
        for (index, item) in items.into_iter().enumerate() {
            let (f, finished) = (&f, &finished);
            let core = (!cores.is_empty()).then(|| cores[index % cores.len()]);
            scope.spawn(move || {
                if let Some(core) = core {
                    crate::stress::pin_current_thread(core);
                }
                f(index, item);
                finished.fetch_add(1, Ordering::Release);
            });
        }
        let mut last = u64::MAX;
        while finished.load(Ordering::Acquire) < threads {
            std::thread::sleep(Duration::from_millis(100));
            let now = work.load(Ordering::Relaxed);
            if now != last {
                last = now;
                send(&Msg::Beat { work: now });
            }
        }
    });
}

pub fn run(json: &str) -> ! {
    let spec: WorkerSpec = match serde_json::from_str(json) {
        Ok(spec) => spec,
        Err(e) => {
            eprintln!("bad worker spec: {e}");
            std::process::exit(3);
        }
    };
    // A crashing worker is reported by the orchestrator; a core file of its address space
    // only fills the disk, which on a board is an SD card.
    let no_core = libc::rlimit {
        rlim_cur: 0,
        rlim_max: 0,
    };
    unsafe { libc::setrlimit(libc::RLIMIT_CORE, &no_core) };
    let deadline = Instant::now() + Duration::from_millis(spec.budget_ms);
    let sink = Sink::default();
    let work = AtomicU64::new(0);
    send(&Msg::Beat { work: 0 });

    let outcome = match spec.job {
        Job::Memory { test, mb } => super::memory::run(test, mb, &spec.cores, deadline, spec.inject, &sink, &work),
        Job::Cpu { test } => super::cpu::run(test, &spec.cores, deadline, spec.inject, &sink, &work),
        Job::Gpu { test, mb, cap_mb } => super::gpu::run(test, mb, cap_mb, deadline, spec.inject, &sink),
        #[expect(clippy::unreachable, reason = "the message states the invariant")]
        Job::SelfCrash => {
            unsafe { std::ptr::write_volatile(std::ptr::null_mut::<u64>(), 0) };
            unreachable!("a write through a null pointer returned");
        }
        Job::SelfHang => loop {
            std::thread::sleep(Duration::from_secs(3600));
        },
        Job::SelfNoResult => std::process::exit(0),
    };

    let (verdict, detail) = match outcome {
        Ok(detail) if sink.count() > 0 => (WorkerVerdict::Error, detail),
        Ok(detail) => (WorkerVerdict::Ok, detail),
        Err(WorkerError::Skip(why)) => (WorkerVerdict::Skip, why),
        #[cfg(any(feature = "gpu", feature = "vulkan"))]
        Err(WorkerError::Fail(why)) => (WorkerVerdict::Error, why),
    };
    send(&Msg::Done {
        verdict,
        detail,
        errors: sink.count(),
        samples: sink.samples(),
    });
    std::process::exit(0)
}

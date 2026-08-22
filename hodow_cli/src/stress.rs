//! Multi-core CPU stress + cross-core result comparison.
//!
//! Every deterministic CPU test has fixed inputs and a known-correct expected value, so a
//! *wrong* result on one core (but not others) is a strong signal of a faulty core; a wrong
//! result appearing only intermittently under sustained all-core load points at thermal or
//! voltage instability. This runner pins one worker thread per logical core, loops the whole
//! test suite until a deadline, and reports per-core iterations and failures.

use std::sync::Arc;
use std::sync::atomic::{AtomicBool, Ordering};
use std::time::{Duration, Instant};

use log::{error, info};

use crate::cli::CpuArgs;

const DEFAULT_STRESS_SECS: u64 = 10;

struct CoreResult {
    core: usize,
    pinned: bool,
    iterations: u64,
    tests_executed: u64,
    /// (test_name, message) for each failure/panic observed on this core.
    failures: Vec<(&'static str, String)>,
}

/// Tests whose result is not stable across repeated calls (hardware RNG). Their success flag
/// can legitimately fail under contention, so they are unsuitable for cross-core comparison.
fn is_nondeterministic(test_name: &str) -> bool {
    test_name.contains("rdrand") || test_name.contains("rdseed")
}

/// Best-effort pin the current thread to `core`. Returns true on success.
#[cfg(unix)]
fn pin_current_thread(core: usize) -> bool {
    // SAFETY: cpu_set_t is initialized before use; sched_setaffinity is a plain syscall.
    unsafe {
        let mut set: libc::cpu_set_t = std::mem::zeroed();
        libc::CPU_ZERO(&mut set);
        libc::CPU_SET(core, &mut set);
        libc::sched_setaffinity(0, std::mem::size_of::<libc::cpu_set_t>(), &set) == 0
    }
}

#[cfg(not(unix))]
fn pin_current_thread(_core: usize) -> bool {
    false
}

pub fn run_stress(args: &CpuArgs) {
    let secs = args.stress_secs.unwrap_or(DEFAULT_STRESS_SECS);
    let cores = std::thread::available_parallelism().map(|n| n.get()).unwrap_or(1);

    // Hardware RNG instructions (RDRAND/RDSEED) are non-deterministic and their success flag
    // legitimately fails when the shared entropy source saturates under heavy multi-core load,
    // so they would produce false "failures" that mask a real faulty-core signal. Exclude them.
    let all = hodow_core::all_tests();
    let excluded = all.iter().filter(|(n, _)| is_nondeterministic(n)).count();
    let test_count = all.len() - excluded;
    if test_count == 0 {
        info!("No deterministic CPU tests available for this target.");
        return;
    }

    info!("Stress: {cores} cores x {secs}s, {test_count} tests per iteration ({excluded} non-deterministic HW-RNG tests excluded)");

    let stop = Arc::new(AtomicBool::new(false));
    {
        let stop = stop.clone();
        // Ctrl+C ends the stress run early; ignore if a handler is already set.
        let _ = ctrlc::set_handler(move || stop.store(true, Ordering::Relaxed));
    }

    let deadline = Instant::now() + Duration::from_secs(secs);
    let results: Vec<CoreResult> = std::thread::scope(|scope| {
        let handles: Vec<_> = (0..cores)
            .map(|core| {
                let stop = stop.clone();
                scope.spawn(move || {
                    let pinned = pin_current_thread(core);
                    // Each thread resolves its own test list (identical order, deterministic).
                    let tests: Vec<_> = hodow_core::all_tests().into_iter().filter(|(n, _)| !is_nondeterministic(n)).collect();
                    let mut iterations = 0u64;
                    let mut tests_executed = 0u64;
                    let mut failures: Vec<(&'static str, String)> = Vec::new();

                    while Instant::now() < deadline && !stop.load(Ordering::Relaxed) {
                        for (name, f) in &tests {
                            tests_executed += 1;
                            let res = std::panic::catch_unwind(std::panic::AssertUnwindSafe(f));
                            match res {
                                Ok(Ok(())) => {}
                                Ok(Err(e)) => failures.push((name, e)),
                                Err(_) => failures.push((name, "panicked".to_string())),
                            }
                        }
                        iterations += 1;
                    }

                    CoreResult {
                        core,
                        pinned,
                        iterations,
                        tests_executed,
                        failures,
                    }
                })
            })
            .collect();

        handles.into_iter().map(|h| h.join().expect("stress worker panicked")).collect()
    });

    report(&results);
}

fn report(results: &[CoreResult]) {
    let any_unpinned = results.iter().any(|r| !r.pinned);
    if any_unpinned {
        info!("Note: thread pinning unavailable; per-core attribution is best-effort.");
    }

    info!("\n{}", "=".repeat(72));
    info!("{:^72}", "CPU STRESS - PER CORE");
    info!("{}", "=".repeat(72));
    info!("{:<8} {:>8} {:>12} {:>12} {:>10}", "Core", "Pinned", "Iterations", "Executed", "Failures");
    info!("{}", "-".repeat(72));
    let mut total_exec = 0u64;
    let mut total_fail = 0u64;
    for r in results {
        info!(
            "{:<8} {:>8} {:>12} {:>12} {:>10}",
            r.core,
            if r.pinned { "yes" } else { "no" },
            r.iterations,
            r.tests_executed,
            r.failures.len()
        );
        total_exec += r.tests_executed;
        total_fail += r.failures.len() as u64;
    }
    info!("{}", "-".repeat(72));
    info!("{:<8} {:>8} {:>12} {:>12} {:>10}", "TOTAL", "", "", total_exec, total_fail);
    info!("{}", "=".repeat(72));

    if total_fail == 0 {
        info!("All cores produced correct results under sustained load.");
        return;
    }

    // Cross-core analysis: which cores failed each test. A test that fails on a *subset* of
    // cores is a strong faulty-core signal; failing on all cores is more likely systematic.
    use std::collections::BTreeMap;
    let mut by_test: BTreeMap<&'static str, Vec<usize>> = BTreeMap::new();
    for r in results {
        for (name, _) in &r.failures {
            let cores = by_test.entry(name).or_default();
            if !cores.contains(&r.core) {
                cores.push(r.core);
            }
        }
    }

    error!("Cross-core failures detected:");
    let total_cores = results.len();
    for (test, cores) in &by_test {
        let scope = if cores.len() == total_cores {
            "ALL cores (systematic/flaky)"
        } else {
            "SUBSET of cores (likely faulty core)"
        };
        error!("  {test}: failed on cores {cores:?} - {scope}");
    }

    std::process::exit(1);
}

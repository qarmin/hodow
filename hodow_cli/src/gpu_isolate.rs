//! Subprocess isolation for the OpenGL tests.
//!
//! One test per child process. `cpu --isolate` needs a resumable line protocol because it has
//! ~16k tests and respawning per test would dominate the run; there are 65 GL tests and each one
//! needs a fresh context anyway, so a process per test costs little and removes the protocol,
//! the index bookkeeping and the respawn logic entirely.
//!
//! What this buys: a driver that segfaults or wedges the GPU costs that one test. Before it took
//! the whole run with it, and on an unknown driver - the case this project exists for - that is
//! the difference between one finding and no results at all.

use std::process::{Command, Stdio};
use std::time::{Duration, Instant};

use log::{error, info};

use crate::cli::GpuArgs;

const DEFAULT_TIMEOUT_MS: u64 = 30_000;

/// Rebuild the child's argument list from the parent's, minus the flags that must not recurse.
fn child_args(args: &GpuArgs, index: usize) -> Vec<String> {
    let mut out = vec!["gpu".to_string(), "--gpu-worker".to_string(), index.to_string()];
    if args.no_window {
        out.push("--no-window".into());
    }
    if args.force_software {
        out.push("--force-software".into());
    }
    for (flag, value) in [
        ("--display-api", args.display_api.clone()),
        ("--gl-api", args.gl_api.clone()),
        ("--time-limit", args.time_limit_ms.map(|v| v.to_string())),
        ("--frame-limit", args.frame_limit.map(|v| v.to_string())),
    ] {
        if let Some(v) = value {
            out.push(flag.into());
            out.push(v);
        }
    }
    out
}

pub fn run(args: &GpuArgs, total: usize) {
    let exe = match std::env::current_exe() {
        Ok(p) => p,
        Err(e) => {
            error!("cannot locate own executable for isolated GPU run: {e}");
            std::process::exit(1);
        }
    };
    let timeout = Duration::from_millis(args.isolate_timeout_ms.unwrap_or(DEFAULT_TIMEOUT_MS));
    info!("Isolated GL run: {total} tests, {} ms per-test timeout", timeout.as_millis());

    let (mut passed, mut skipped, mut failed, mut crashed, mut timed_out) = (0, 0, 0, 0, 0);
    for index in 0..total {
        let name = hodow_core::gl_test_name_at(index).unwrap_or("<unknown>");
        let output = Command::new(&exe)
            .args(child_args(args, index))
            .stdin(Stdio::null())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()
            .and_then(|child| wait_with_timeout(child, timeout));

        match output {
            Ok(Some(out)) if out.status.success() => {
                let line = String::from_utf8_lossy(&out.stdout);
                let payload = line.lines().find_map(|l| l.strip_prefix("RESULT "));
                match payload.map(|p| p.split_once(' ').unwrap_or((p, ""))) {
                    Some(("passed", msg)) => {
                        info!("GL Test '{name}' passed: {msg}");
                        passed += 1;
                    }
                    Some(("unsupported", why)) => {
                        info!("GL Test '{name}' not supported here: {why}");
                        skipped += 1;
                    }
                    Some((_, msg)) => {
                        error!("GL Test '{name}' failed: {msg}");
                        failed += 1;
                    }
                    // Exit 0 with no RESULT line means the child died after the harness but
                    // before printing - report it rather than silently counting a pass.
                    None => {
                        error!("GL Test '{name}' produced no result line");
                        crashed += 1;
                    }
                }
            }
            Ok(Some(out)) => {
                error!("GL Test '{name}' CRASHED ({})", crate::isolate::crash_reason(Some(out.status)));
                crashed += 1;
            }
            Ok(None) => {
                error!("GL Test '{name}' TIMEOUT after {} ms", timeout.as_millis());
                timed_out += 1;
            }
            Err(e) => {
                error!("GL Test '{name}' could not be run: {e}");
                crashed += 1;
            }
        }
    }

    info!("\n{}", "=".repeat(80));
    info!("{:^80}", "ISOLATED GL TEST STATISTICS");
    info!("{}", "=".repeat(80));
    info!("{:<22} {:>10}", "Passed", passed);
    info!("{:<22} {:>10}", "Not supported here", skipped);
    info!("{:<22} {:>10}", "Failed", failed);
    info!("{:<22} {:>10}", "Crashed", crashed);
    info!("{:<22} {:>10}", "Timed out", timed_out);
    info!("{}", "-".repeat(80));
    info!("{:<22} {:>10}", "Total", total);
    info!("{}", "=".repeat(80));

    if failed + crashed + timed_out > 0 {
        std::process::exit(1);
    }
}

/// `wait_with_output` has no timeout, so poll and kill instead. Returns `None` on timeout.
fn wait_with_timeout(mut child: std::process::Child, timeout: Duration) -> std::io::Result<Option<std::process::Output>> {
    let start = Instant::now();
    loop {
        if child.try_wait()?.is_some() {
            return child.wait_with_output().map(Some);
        }
        if start.elapsed() >= timeout {
            let _ = child.kill();
            let _ = child.wait();
            return Ok(None);
        }
        std::thread::sleep(Duration::from_millis(10));
    }
}

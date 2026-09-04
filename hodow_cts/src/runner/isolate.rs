// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Crash and hang isolation.
//
// The premise of this tool is that the driver under test may be broken, so a test
// segfaulting or wedging the GPU is an expected outcome, not an exceptional one. The
// parent runs batches in a child process and reads the child's JSONL as it is
// written; whatever case has no line when the child dies is the one that killed it.
//
// This costs one device creation per batch rather than per case, which is why batches
// exist at all - `--isolate-per-test` sets the batch size to 1 for triage.

use std::io::BufRead;
use std::path::Path;
use std::process::{Command, Stdio};
use std::time::{Duration, Instant};

use crate::report::{CaseResult, Summary};
use crate::tcu::TestResult;

/// Environment variable the parent sets to tell the child it is the worker.
pub const WORKER_ENV: &str = "HODOW_CTS_WORKER";

/// Exit code a worker uses when Vulkan could not be brought up at all.
///
/// This has to be distinguishable from a crash: a missing driver is an environment
/// problem, and reporting it as a crash would blame whichever case happened to be
/// first for something it had nothing to do with.
pub const EXIT_VULKAN_UNAVAILABLE: i32 = 2;

pub struct IsolateOptions {
    pub batch_size: usize,
    pub case_timeout: Duration,
    pub device_id: usize,
    pub validation: bool,
}

/// Outcome of supervising one child process.
struct BatchOutcome {
    results: Vec<CaseResult>,
    /// Set when the child died or hung; this is the case that was in flight.
    culprit: Option<(String, TestResult, String)>,
    /// The child could not bring Vulkan up. Nothing was tested.
    vulkan_unavailable: bool,
}

/// Raised when no worker can start because Vulkan is not usable here.
#[derive(Debug)]
pub struct VulkanUnavailable;

impl std::fmt::Display for VulkanUnavailable {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "Vulkan is not usable here - no loader, or no driver behind it.\n\
             No tests were run (this is not a test failure).\n\
             To run on a software driver, see the \"Running without a GPU\" section of\n\
             hodow_cts/README.md."
        )
    }
}

impl std::error::Error for VulkanUnavailable {}

/// Runs `case_names` through child processes, `batch_size` at a time.
pub fn run_isolated(case_names: &[String], options: &IsolateOptions, mut on_result: impl FnMut(&CaseResult)) -> Result<(Vec<CaseResult>, Summary), Box<dyn std::error::Error>> {
    let exe = std::env::current_exe()?;
    let mut all = Vec::with_capacity(case_names.len());
    let mut summary = Summary::default();
    let mut index = 0;

    while index < case_names.len() {
        let end = (index + options.batch_size).min(case_names.len());
        let batch = &case_names[index..end];

        let outcome = run_one_batch(&exe, batch, options)?;

        if outcome.vulkan_unavailable {
            return Err(Box::new(VulkanUnavailable));
        }

        for result in &outcome.results {
            summary.record(result.status);
            on_result(result);
        }
        let completed = outcome.results.len();
        all.extend(outcome.results);

        match outcome.culprit {
            Some((name, status, message)) => {
                let result = CaseResult {
                    name,
                    status,
                    message,
                    duration_ms: 0,
                };
                summary.record(result.status);
                on_result(&result);
                all.push(result);
                // Skip past the case that took the child down and restart after it.
                index += completed + 1;
            }
            None => index = end,
        }
    }

    Ok((all, summary))
}

fn run_one_batch(exe: &Path, batch: &[String], options: &IsolateOptions) -> std::io::Result<BatchOutcome> {
    let mut child = Command::new(exe)
        .env(WORKER_ENV, "1")
        .arg("--worker-cases")
        .arg(batch.join(","))
        .arg("--device-id")
        .arg(options.device_id.to_string())
        .args(if options.validation { vec!["--validation"] } else { vec![] })
        .stdout(Stdio::piped())
        .stderr(Stdio::inherit())
        .spawn()?;

    let stdout = child.stdout.take().expect("piped");
    let reader = std::io::BufReader::new(stdout);

    let deadline_per_case = options.case_timeout;
    let mut results = Vec::new();
    let mut last_progress = Instant::now();

    // The child writes one JSON line per finished case and flushes, so the parent's
    // view of progress is exact rather than inferred.
    for line in reader.lines() {
        let line = match line {
            Ok(l) => l,
            Err(_) => break,
        };
        if let Ok(result) = serde_json::from_str::<CaseResult>(&line) {
            results.push(result);
            last_progress = Instant::now();
        }
        if last_progress.elapsed() > deadline_per_case {
            break;
        }
    }

    let status = wait_with_timeout(&mut child, deadline_per_case)?;

    if matches!(status, WaitOutcome::Exited(EXIT_VULKAN_UNAVAILABLE)) && results.is_empty() {
        return Ok(BatchOutcome {
            results,
            culprit: None,
            vulkan_unavailable: true,
        });
    }

    let culprit = match status {
        WaitOutcome::Exited(0) => None,
        WaitOutcome::Exited(code) if results.len() == batch.len() => {
            // Everything reported; a non-zero code just means something failed.
            log::debug!("worker exited with {code} after reporting all cases");
            None
        }
        WaitOutcome::Exited(code) => Some((
            batch[results.len()].clone(),
            TestResult::Crash,
            format!("worker exited with code {code} while running this case"),
        )),
        WaitOutcome::Signalled(sig) => Some((
            batch.get(results.len()).cloned().unwrap_or_default(),
            TestResult::Crash,
            format!("worker killed by signal {sig} while running this case"),
        )),
        WaitOutcome::TimedOut => Some((
            batch.get(results.len()).cloned().unwrap_or_default(),
            TestResult::Timeout,
            format!("no progress for {:?} - worker killed", deadline_per_case),
        )),
    };

    Ok(BatchOutcome {
        results,
        culprit,
        vulkan_unavailable: false,
    })
}

enum WaitOutcome {
    Exited(i32),
    Signalled(i32),
    TimedOut,
}

fn wait_with_timeout(child: &mut std::process::Child, timeout: Duration) -> std::io::Result<WaitOutcome> {
    let deadline = Instant::now() + timeout;

    loop {
        if let Some(status) = child.try_wait()? {
            #[cfg(unix)]
            {
                use std::os::unix::process::ExitStatusExt;
                if let Some(sig) = status.signal() {
                    return Ok(WaitOutcome::Signalled(sig));
                }
            }
            return Ok(WaitOutcome::Exited(status.code().unwrap_or(-1)));
        }
        if Instant::now() >= deadline {
            let _ = child.kill();
            let _ = child.wait();
            return Ok(WaitOutcome::TimedOut);
        }
        std::thread::sleep(Duration::from_millis(10));
    }
}

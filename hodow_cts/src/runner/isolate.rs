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
// exist at all - `--isolate-per-test` sets the batch size to 1 for triage. Batches
// want to be large: a worker rebuilds the whole case tree before it runs anything, so
// that cost is paid once per batch no matter how few cases the batch holds. Nothing
// about attribution depends on the size - the culprit is always `batch[results.len()]`.

use std::io::{BufRead, Write};
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

/// A worker that could not set Vulkan up at all, for a reason other than a missing
/// driver - `--validation` without the layer installed being the one that happens in
/// practice. Same reasoning as above: it is an environment problem, and blaming the
/// first case for it sends whoever reads the log looking in the wrong place.
pub const EXIT_SETUP_ERROR: i32 = 3;

pub struct IsolateOptions {
    pub batch_size: usize,
    pub case_timeout: Duration,
    pub device_id: usize,
    pub validation: bool,
    /// How many worker processes may run at once. One means the old behaviour.
    pub jobs: usize,
}

/// Cases that must not share the device with anything else.
///
/// `dEQP-VK.memory.allocation.*` deliberately allocates a large fraction of a heap and
/// checks that the allocation succeeds; `memory.mapping.*` maps most of one. Two of
/// those at once would run the second out of memory, and it would report that as a
/// failure of the driver rather than of the scheduling. They are also, between them,
/// half the wall time of a full run - so this is not a small carve-out, it is the
/// reason the carve-out has to exist.
fn needs_exclusive_device(case_name: &str) -> bool {
    case_name.starts_with("dEQP-VK.memory.")
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
///
/// With `jobs > 1` the cases that tolerate company are split across that many worker
/// processes; the rest keep the device to themselves. Results arrive interleaved, which
/// is why the summary is accumulated from what comes back rather than from the order
/// the cases were asked for.
pub fn run_isolated(case_names: &[String], options: &IsolateOptions, mut on_result: impl FnMut(&CaseResult)) -> Result<(Vec<CaseResult>, Summary), Box<dyn std::error::Error>> {
    if options.jobs > 1 {
        return run_isolated_parallel(case_names, options, &mut on_result);
    }
    run_isolated_serial(case_names, options, on_result)
}

fn run_isolated_serial(case_names: &[String], options: &IsolateOptions, mut on_result: impl FnMut(&CaseResult)) -> Result<(Vec<CaseResult>, Summary), Box<dyn std::error::Error>> {
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
                    // The case never returned, so there is nothing to have measured.
                    duration_us: 0,
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
        .arg("--device-id")
        .arg(options.device_id.to_string())
        .args(if options.validation { vec!["--validation"] } else { vec![] })
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::inherit())
        .spawn()?;

    // The batch goes over stdin rather than argv: `MAX_ARG_STRLEN` caps a single
    // argument at 128 KiB, which a batch of a thousand case names comfortably exceeds.
    // The worker drains stdin to EOF before it writes anything, so filling the pipe
    // here cannot deadlock against the reader below.
    {
        let mut stdin = child.stdin.take().expect("piped");
        for name in batch {
            writeln!(stdin, "{name}")?;
        }
    }

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

    if matches!(status, WaitOutcome::Exited(EXIT_SETUP_ERROR)) && results.is_empty() {
        // The worker has already explained itself on stderr; anything further from here
        // would only bury it.
        return Err(std::io::Error::other("worker could not initialise Vulkan - see the error above"));
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

/// The `--jobs N` path: the exclusive cases first, alone, then everything else spread
/// across `N` worker processes.
///
/// Splitting by chunk rather than round-robin keeps each worker's case list contiguous,
/// which matters because a worker rebuilds the whole case tree before it runs anything
/// and a contiguous slice keeps the batching inside it as coarse as the serial path.
fn run_isolated_parallel(
    case_names: &[String],
    options: &IsolateOptions,
    on_result: &mut impl FnMut(&CaseResult),
) -> Result<(Vec<CaseResult>, Summary), Box<dyn std::error::Error>> {
    let (exclusive, shared): (Vec<String>, Vec<String>) = case_names.iter().cloned().partition(|n| needs_exclusive_device(n));

    let mut all = Vec::with_capacity(case_names.len());
    let mut summary = Summary::default();

    // The exclusive ones go first and alone, so the parallel phase cannot be starved
    // of memory by them or they by it.
    if !exclusive.is_empty() {
        let (results, sub) = run_isolated_serial(&exclusive, options, |r| on_result(r))?;
        summary.merge(&sub);
        all.extend(results);
    }

    if shared.is_empty() {
        return Ok((all, summary));
    }

    let jobs = options.jobs.min(shared.len()).max(1);
    let chunk = shared.len().div_ceil(jobs);
    let (tx, rx) = std::sync::mpsc::channel::<CaseResult>();

    let outcome = std::thread::scope(|scope| -> Result<Summary, Box<dyn std::error::Error + Send + Sync>> {
        let mut handles = Vec::new();
        for slice in shared.chunks(chunk) {
            let tx = tx.clone();
            handles.push(scope.spawn(move || -> Result<Summary, String> {
                let (_results, summary) = run_isolated_serial(slice, options, |r| {
                    let _ = tx.send(r.clone());
                })
                .map_err(|e| e.to_string())?;
                Ok(summary)
            }));
        }
        drop(tx);

        // Drain as the workers produce, so progress is visible while they run. The
        // report goes out here rather than in the worker threads: `on_result` is the
        // caller's printer and is not `Sync`, and interleaving it across threads would
        // tear lines anyway.
        for message in rx {
            on_result(&message);
            all.push(message);
        }

        let mut merged = Summary::default();
        for handle in handles {
            match handle.join() {
                Ok(Ok(sub)) => merged.merge(&sub),
                Ok(Err(e)) => return Err(e.into()),
                Err(_) => return Err("a worker supervisor thread panicked".into()),
            }
        }
        Ok(merged)
    });

    match outcome {
        Ok(sub) => summary.merge(&sub),
        Err(e) => {
            // A worker that could not bring Vulkan up is the same condition the serial
            // path reports, and has to stay distinguishable from a test failure.
            if e.to_string().contains("Vulkan is not usable here") {
                return Err(Box::new(VulkanUnavailable));
            }
            return Err(e.to_string().into());
        }
    }

    // The results were printed as they arrived; reporting them in the order they were
    // asked for keeps the JSONL comparable between a serial and a parallel run.
    let order: std::collections::HashMap<&str, usize> = case_names.iter().enumerate().map(|(i, n)| (n.as_str(), i)).collect();
    all.sort_by_key(|r| order.get(r.name.as_str()).copied().unwrap_or(usize::MAX));

    Ok((all, summary))
}

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
// about attribution depends on the size - the culprit is always `batch[results.len()]`,
// and when that is past the end of the batch the worker reported everything and then
// failed to exit, which is a fault of its shutdown rather than of any case.

use std::io::{BufRead, Write};
use std::path::Path;
use std::process::{Command, Stdio};
use std::time::{Duration, Instant};

use crate::report::{CaseResult, Summary};
use crate::runner::{Api, kmsg, reap};
use crate::tcu::TestResult;

/// Environment variable the parent sets to tell the child it is the worker.
pub const WORKER_ENV: &str = "HODOW_CTS_WORKER";

static REEXEC_PREFIX: std::sync::OnceLock<Vec<String>> = std::sync::OnceLock::new();

/// What a re-executed copy of this program needs before its own flags when the program is a command inside a bigger
/// binary (`hodow cts ...`) rather than a binary of its own.
pub fn set_reexec_prefix(prefix: Vec<String>) {
    let _ = REEXEC_PREFIX.set(prefix);
}

/// A command that runs this program again, ready for the flags of the child.
pub fn reexec_command(exe: &Path) -> Command {
    let mut command = Command::new(exe);
    command.args(REEXEC_PREFIX.get().into_iter().flatten());
    command
}
/// Set on every worker after the first, to keep the driver bring-up banner to one copy.
pub const QUIET_SETUP_ENV: &str = "HODOW_CTS_QUIET_SETUP";

/// Whether some worker has already printed the bring-up banner this run.
static SETUP_BANNER_SHOWN: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);

/// How often the supervisor looks at the kernel log while waiting for a verdict. Short
/// enough that a hang is noticed within a second of the driver announcing it, long
/// enough to be free.
const KERNEL_POLL: Duration = Duration::from_millis(500);

/// Exit code a worker uses when the API under test could not be brought up at all.
///
/// This has to be distinguishable from a crash: a missing driver is an environment
/// problem, and reporting it as a crash would blame whichever case happened to be
/// first for something it had nothing to do with. The value is part of the tool's
/// contract with its callers - `just cts-verify` and CI both read it - so it stays 2
/// whichever API was being brought up.
pub const EXIT_DRIVER_UNAVAILABLE: i32 = 2;

/// A worker that could not set the API up at all, for a reason other than a missing
/// driver - `--validation` without the layer installed being the one that happens in
/// practice. Same reasoning as above: it is an environment problem, and blaming the
/// first case for it sends whoever reads the log looking in the wrong place.
pub const EXIT_SETUP_ERROR: i32 = 3;

pub struct IsolateOptions {
    /// Which API the batch belongs to. Only used to say what was unavailable when a
    /// worker cannot start - a batch never mixes APIs, because the caller splits the
    /// selection by root before it gets here.
    pub api: Api,
    pub batch_size: usize,
    pub case_timeout: Duration,
    pub device_id: usize,
    pub validation: bool,
    /// How many worker processes may run at once. One means the old behaviour.
    pub jobs: usize,
    /// Pass `-v` on, so each worker names the case it is about to run.
    pub verbose: bool,
    /// Return as soon as a case takes a worker down, instead of stepping over it and
    /// running the rest of the list in a fresh process.
    ///
    /// For an ordinary run, stepping over is right: one bad case should not cost the
    /// other 999 their verdicts. For the fuzzer it is wrong, and quietly so - the state
    /// a group accumulated *is* the experiment, and everything after the crash would
    /// run against a driver that has just been restarted, which is a different one.
    pub stop_on_crash: bool,
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
    /// The child could not bring the API up. Nothing was tested.
    driver_unavailable: bool,
}

/// Raised when no worker can start because the API is not usable here.
///
/// The wording keeps the fixed `is not usable here` phrase: the parallel path below
/// can only see a worker supervisor's error as a string, and that is what it matches
/// on to keep this distinct from a test failure.
#[derive(Debug)]
pub struct DriverUnavailable(pub Api);

impl std::fmt::Display for DriverUnavailable {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{} is not usable here - no loader, or no driver behind it.\n\
             No tests were run (this is not a test failure).\n\
             To run on a software driver, see the \"Running without a GPU\" section of\n\
             hodow_cts/README.md.",
            self.0.label()
        )
    }
}

impl std::error::Error for DriverUnavailable {}

/// Runs `case_names` through child processes, `batch_size` at a time.
///
/// With `jobs > 1` the cases that tolerate company are split across that many worker
/// processes; the rest keep the device to themselves. Results arrive interleaved, which
/// is why the summary is accumulated from what comes back rather than from the order
/// the cases were asked for.
pub fn run_isolated(
    case_names: &[String],
    options: &IsolateOptions,
    mut on_result: impl FnMut(&CaseResult),
) -> Result<(Vec<CaseResult>, Summary), Box<dyn std::error::Error>> {
    if options.jobs > 1 {
        return run_isolated_parallel(case_names, options, &mut on_result);
    }
    run_isolated_serial(case_names, options, on_result)
}

fn run_isolated_serial(
    case_names: &[String],
    options: &IsolateOptions,
    mut on_result: impl FnMut(&CaseResult),
) -> Result<(Vec<CaseResult>, Summary), Box<dyn std::error::Error>> {
    let exe = std::env::current_exe()?;
    let mut all = Vec::with_capacity(case_names.len());
    let mut summary = Summary::default();
    let mut index = 0;

    while index < case_names.len() {
        let end = (index + options.batch_size).min(case_names.len());
        let batch = &case_names[index..end];

        // Reported as each line arrives, not once the batch is over. A group is one
        // batch, so anything deferred to the end of it is written exactly when it has
        // stopped being worth anything: the progress file existed to say how far a group
        // got when the machine did not come back, and it was empty every time.
        let outcome = run_one_batch(&exe, batch, options, &mut |result| {
            summary.record(result.status);
            on_result(result);
        })?;

        if outcome.driver_unavailable {
            return Err(Box::new(DriverUnavailable(options.api)));
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
                if options.stop_on_crash {
                    return Ok((all, summary));
                }
                // Skip past the case that took the child down and restart after it.
                index += completed + 1;
            }
            None => index = end,
        }
    }

    Ok((all, summary))
}

fn run_one_batch(
    exe: &Path,
    batch: &[String],
    options: &IsolateOptions,
    on_result: &mut dyn FnMut(&CaseResult),
) -> std::io::Result<BatchOutcome> {
    let mut child = reexec_command(exe)
        .env(WORKER_ENV, "1")
        .arg("--device-id")
        .arg(options.device_id.to_string())
        .args(if options.validation {
            vec!["--validation"]
        } else {
            vec![]
        })
        .args(if options.verbose { vec!["--verbose"] } else { vec![] })
        // Only the first worker of a run gets to print the setup banner. Under
        // `--isolate-per-test` every case is a fresh process, so without this the
        // EGL/context lines repeat once per case and bury the results.
        .envs(if SETUP_BANNER_SHOWN.swap(true, std::sync::atomic::Ordering::Relaxed) {
            vec![(QUIET_SETUP_ENV, "1")]
        } else {
            vec![]
        })
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

    let deadline_per_case = options.case_timeout;
    let mut results = Vec::new();

    // The child writes one JSON line per finished case and flushes, so the parent's
    // view of progress is exact rather than inferred.
    //
    // Read on a thread, not here. A hung case writes nothing more, so reading inline
    // blocks in `lines()` forever and the deadline below is never reached - which made
    // `--timeout-secs` do nothing in the one situation it exists for. `recv_timeout` is
    // what turns "no progress for N seconds" into something that actually fires.
    let (tx, rx) = std::sync::mpsc::channel::<String>();
    let pump = std::thread::spawn(move || {
        for line in std::io::BufReader::new(stdout).lines() {
            let Ok(line) = line else { break };
            if tx.send(line).is_err() {
                break;
            }
        }
    });

    // The kernel usually knows before the deadline does: a driver that has stopped
    // serving says so, and after that line the remaining timeout is spent waiting for
    // something that has already happened. `None` where /dev/kmsg is not readable, and
    // then this is exactly the timeout loop it was before.
    let kernel = kmsg::KernelWatch::start();
    let mut kernel_said: Option<String> = None;

    let mut timed_out = false;
    let mut last_progress = Instant::now();
    loop {
        // Polled rather than waited on, so the kernel gets looked at while a case is
        // still inside its deadline. The deadline itself is unchanged - it is the time
        // since the last *verdict*, not since the last poll.
        match rx.recv_timeout(KERNEL_POLL) {
            Ok(line) => {
                if let Ok(result) = serde_json::from_str::<CaseResult>(&line) {
                    on_result(&result);
                    results.push(result);
                    last_progress = Instant::now();
                }
            }
            Err(std::sync::mpsc::RecvTimeoutError::Timeout) => {
                if let Some(said) = kernel.as_ref().and_then(kmsg::KernelWatch::hang_reported) {
                    reap::mark_driver_gone();
                    kernel_said = Some(said);
                    timed_out = true;
                    break;
                }
                if last_progress.elapsed() >= deadline_per_case {
                    timed_out = true;
                    break;
                }
            }
            // The child closed its stdout: it is exiting, one way or another.
            Err(std::sync::mpsc::RecvTimeoutError::Disconnected) => break,
        }
    }

    let mut stuck = false;
    let status = if timed_out {
        // Killed here rather than by `wait_with_timeout`, so the outcome stays a
        // timeout: reaping it afterwards would read as "killed by signal 9" and blame
        // the case for a signal the parent sent.
        stuck = kill_worker(&mut child);
        WaitOutcome::TimedOut
    } else {
        wait_with_timeout(&mut child, deadline_per_case)?
    };
    // The pipe is closed once the child is gone, so this returns immediately - unless
    // the worker is stuck in the kernel with its stdout still open, where joining is
    // simply the second place the supervisor would hang. The thread goes with the
    // process instead.
    if !stuck {
        let _ = pump.join();
    }

    if matches!(status, WaitOutcome::Exited(EXIT_DRIVER_UNAVAILABLE)) && results.is_empty() {
        return Ok(BatchOutcome {
            results,
            culprit: None,
            driver_unavailable: true,
        });
    }

    if matches!(status, WaitOutcome::Exited(EXIT_SETUP_ERROR)) && results.is_empty() {
        // The worker has already explained itself on stderr; anything further from here
        // would only bury it.
        return Err(std::io::Error::other(
            "worker could not initialise the API under test - see the error above",
        ));
    }

    // The case the worker was running when it died: the first one it never reported.
    // `None` means it reported the whole batch and then failed to exit - a driver wedging
    // in teardown looks exactly like that. There is no case left to blame, and inventing a
    // record for one would add a nameless Crash to the totals and push the progress counter
    // past its own denominator, so that is a warning about the worker rather than a verdict.
    let pending = batch.get(results.len());
    let last = || batch.last().map(String::as_str).unwrap_or("none");

    let culprit = match status {
        WaitOutcome::Exited(0) => None,
        WaitOutcome::Exited(code) => match pending {
            Some(name) => Some((
                name.clone(),
                TestResult::Crash,
                format!("worker exited with code {code} while running this case"),
            )),
            None => {
                log::debug!("worker exited with {code} after reporting all cases");
                None
            }
        },
        WaitOutcome::Signalled(sig) => match pending {
            Some(name) => Some((
                name.clone(),
                TestResult::Crash,
                format!("worker killed by signal {sig} while running this case"),
            )),
            None => {
                log::warn!(
                    "worker was killed by signal {sig} after reporting all {} cases (last was {}) - the failure is in its shutdown, not in a case",
                    batch.len(),
                    last()
                );
                None
            }
        },
        WaitOutcome::TimedOut => match pending {
            Some(name) => {
                let why = match &kernel_said {
                    Some(said) => format!("{said} - worker killed"),
                    None => format!("no progress for {deadline_per_case:?} - worker killed"),
                };
                Some((name.clone(), TestResult::Timeout, why))
            }
            None => {
                log::warn!(
                    "worker did not exit within {deadline_per_case:?} after reporting all {} cases (last was {}) - the failure is in its shutdown, not in a case",
                    batch.len(),
                    last()
                );
                None
            }
        },
    };

    Ok(BatchOutcome {
        results,
        culprit,
        driver_unavailable: false,
    })
}

#[cfg_attr(not(unix), allow(dead_code))]
enum WaitOutcome {
    Exited(i32),
    Signalled(i32),
    TimedOut,
}

/// Kills a worker and reports it if the kernel will not retire it. Returns whether it is
/// still there, which is what decides that nothing may wait on its pipes afterwards.
///
/// A driver that stops returning leaves its caller in an uninterruptible state, where
/// SIGKILL is recorded and not delivered. The old code then called `wait()`, so a
/// timeout that fired exactly as designed ended in a supervisor blocked forever with the
/// finding unwritten - the campaign looked frozen, which is the one outcome this whole
/// layer exists to prevent.
fn kill_worker(child: &mut std::process::Child) -> bool {
    match reap::kill_and_reap(child, reap::REAP_GRACE) {
        reap::Reaped::Exited => false,
        reap::Reaped::Stuck(stuck) => {
            log::error!("{}", stuck.report());
            // Nothing gets a worker out of the kernel, so whatever it was doing to the
            // driver is still being done. This process must not try to tear its own
            // context down on the way out.
            reap::mark_driver_gone();
            true
        }
    }
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
            kill_worker(child);
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
    let (exclusive, shared): (Vec<String>, Vec<String>) =
        case_names.iter().cloned().partition(|n| needs_exclusive_device(n));

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
            // A worker that could not bring the API up is the same condition the serial
            // path reports, and has to stay distinguishable from a test failure.
            if e.to_string().contains("is not usable here") {
                return Err(Box::new(DriverUnavailable(options.api)));
            }
            return Err(e.to_string().into());
        }
    }

    // The results were printed as they arrived; reporting them in the order they were
    // asked for keeps the JSONL comparable between a serial and a parallel run.
    let order: std::collections::HashMap<&str, usize> =
        case_names.iter().enumerate().map(|(i, n)| (n.as_str(), i)).collect();
    all.sort_by_key(|r| order.get(r.name.as_str()).copied().unwrap_or(usize::MAX));

    Ok((all, summary))
}

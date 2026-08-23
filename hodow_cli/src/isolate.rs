//! Subprocess isolation for CPU tests.
//!
//! In `--isolate` mode the parent process spawns a worker child that runs tests in the
//! canonical order and streams a line protocol on stdout:
//!
//! ```text
//! START <index> <name>
//! DONE  <index> OK
//! DONE  <index> ERR <message>
//! DONE  <index> PANIC
//! END   <count>
//! ```
//!
//! The parent enforces a per-test timeout. If the child segfaults or hangs, the parent
//! attributes the failure to the in-flight test (CRASHED / TIMEOUT) and respawns a fresh
//! worker starting just after it, so a single bad instruction never aborts the whole run.

use std::io::{BufRead, BufReader, Write};
use std::process::{Command, Stdio};
use std::sync::mpsc;
use std::thread;
use std::time::Duration;

use log::info;

use crate::cli::CpuArgs;

const DEFAULT_TIMEOUT_MS: u64 = 10_000;

#[derive(Clone, PartialEq)]
pub(crate) enum Outcome {
    Pending,
    Pass,
    Fail(String),
    Panic,
    Timeout,
    Crashed,
}

/// The filtered test list (name, fn) both the worker and the parent must agree on, so
/// index-based progress/crash-attribution stays consistent between the two processes. Both
/// sides compute this independently from the same `-t`/`-e`/`-s` filter state (set on
/// `CpuArgs` before either the worker or the parent branch runs, see `process_cpu`), so the
/// filtered order is deterministic and identical in both.
fn filtered_tests() -> Vec<(&'static str, &'static hodow_core::TestFunction)> {
    hodow_core::all_tests()
        .into_iter()
        .filter(|(name, feature, _)| !hodow_core::should_skip_test_or_feature(name, feature))
        .map(|(name, _feature, f)| (name, f))
        .collect()
}

/// Worker: run every (filtered) test from `start` onward, streaming the line protocol on stdout.
pub fn run_worker(start: usize) {
    let tests = filtered_tests();
    let stdout = std::io::stdout();
    let mut out = stdout.lock();

    for (i, (name, f)) in tests.iter().enumerate().skip(start) {
        // Announce before running so the parent can attribute a crash to this exact test.
        let _ = writeln!(out, "START\t{i}\t{name}");
        let _ = out.flush();

        let res = std::panic::catch_unwind(std::panic::AssertUnwindSafe(f));
        match res {
            Ok(Ok(())) => {
                let _ = writeln!(out, "DONE\t{i}\tOK");
            }
            Ok(Err(e)) => {
                let _ = writeln!(out, "DONE\t{i}\tERR\t{}", sanitize(&e));
            }
            Err(_) => {
                let _ = writeln!(out, "DONE\t{i}\tPANIC");
            }
        }
        let _ = out.flush();
    }

    let _ = writeln!(out, "END\t{}", tests.len());
    let _ = out.flush();
}

fn sanitize(s: &str) -> String {
    s.replace(['\n', '\t', '\r'], " ")
}

/// Parent: orchestrate isolated workers and aggregate a report.
pub fn run_isolated(args: &CpuArgs) {
    let Some((names, outcome)) = run_isolated_core(args, |_, _, _| {}) else {
        return;
    };
    print_report(&names, &outcome);
}

/// Core orchestration loop, reusable by both the plain CLI path above and the server's job
/// executor. `on_event` is called once per test as soon as its outcome is finalized (in
/// execution order, which may skip indices when a crash/timeout forces a respawn past the
/// culprit — the respawn logic below still eventually finalizes every index). Returns
/// `None` if there are no tests to run for this target/filter, else `(names, outcomes)`.
pub(crate) fn run_isolated_core(args: &CpuArgs, mut on_event: impl FnMut(usize, &'static str, &Outcome)) -> Option<(Vec<&'static str>, Vec<Outcome>)> {
    // Build the (name-only) filtered list; the fn pointers are only ever executed in the child.
    let names: Vec<&'static str> = filtered_tests().iter().map(|(n, _)| *n).collect();
    let total = names.len();
    if total == 0 {
        info!("No CPU tests available for this target.");
        return None;
    }

    let timeout = Duration::from_millis(args.isolate_timeout_ms.unwrap_or(DEFAULT_TIMEOUT_MS));
    let exe = std::env::current_exe().expect("failed to resolve current executable");
    info!("Isolated run: {} tests, {} ms per-test timeout", total, timeout.as_millis());

    let mut outcome = vec![Outcome::Pending; total];
    let mut next = 0usize;

    while next < total {
        let prev_next = next;
        let mut cmd = Command::new(&exe);
        cmd.arg("cpu").arg("--worker-start").arg(next.to_string());
        if let Some(n) = args.iterations {
            cmd.arg("--iterations").arg(n.to_string());
        }
        if let Some(ref only) = args.test_function {
            cmd.arg("--test-function");
            for t in only {
                cmd.arg(t);
            }
        }
        if !args.feature.is_empty() {
            cmd.arg("--feature").arg(args.feature.join(","));
        }
        if !args.skip.is_empty() {
            cmd.arg("--skip").arg(args.skip.join(","));
        }
        let mut child = match cmd.stdout(Stdio::piped()).stderr(Stdio::null()).spawn() {
            Ok(c) => c,
            Err(e) => {
                info!("Failed to spawn worker: {e}");
                return None;
            }
        };

        let stdout = child.stdout.take().expect("worker stdout");
        let (tx, rx) = mpsc::channel::<String>();
        let reader = thread::spawn(move || {
            for line in BufReader::new(stdout).lines().map_while(Result::ok) {
                if tx.send(line).is_err() {
                    break;
                }
            }
        });

        let mut in_flight: Option<usize> = None;
        let mut advanced_to = next;

        loop {
            match rx.recv_timeout(timeout) {
                Ok(line) => {
                    let mut parts = line.splitn(4, '\t');
                    match parts.next() {
                        Some("START") => {
                            in_flight = parts.next().and_then(|s| s.parse().ok());
                        }
                        Some("DONE") => {
                            let idx: Option<usize> = parts.next().and_then(|s| s.parse().ok());
                            let kind = parts.next().unwrap_or("");
                            if let Some(i) = idx {
                                outcome[i] = match kind {
                                    "OK" => Outcome::Pass,
                                    "PANIC" => Outcome::Panic,
                                    "ERR" => Outcome::Fail(parts.next().unwrap_or("").to_string()),
                                    other => Outcome::Fail(other.to_string()),
                                };
                                on_event(i, names[i], &outcome[i]);
                                in_flight = None;
                                advanced_to = i + 1;
                            }
                        }
                        Some("END") => {
                            in_flight = None;
                            advanced_to = total;
                        }
                        _ => {}
                    }
                }
                Err(mpsc::RecvTimeoutError::Timeout) => {
                    let culprit = in_flight.unwrap_or(advanced_to);
                    if culprit < total {
                        info!("TIMEOUT after {} ms: {}", timeout.as_millis(), names[culprit]);
                        outcome[culprit] = Outcome::Timeout;
                        on_event(culprit, names[culprit], &outcome[culprit]);
                        advanced_to = culprit + 1;
                    }
                    let _ = child.kill();
                    in_flight = None;
                    break;
                }
                Err(mpsc::RecvTimeoutError::Disconnected) => break,
            }
        }

        let _ = child.wait();
        let _ = reader.join();

        // Child died mid-test without a DONE line => it crashed on that test.
        if let Some(culprit) = in_flight
            && culprit < total
        {
            info!("CRASHED: {}", names[culprit]);
            outcome[culprit] = Outcome::Crashed;
            on_event(culprit, names[culprit], &outcome[culprit]);
            advanced_to = culprit + 1;
        }

        next = advanced_to;
        // Guard against a startup crash producing no progress (avoid an infinite respawn loop).
        if next == prev_next && next < total {
            if outcome[next] == Outcome::Pending {
                outcome[next] = Outcome::Crashed;
                on_event(next, names[next], &outcome[next]);
            }
            next += 1;
        }
    }

    Some((names, outcome))
}

fn print_report(names: &[&'static str], outcome: &[Outcome]) {
    let mut pass = 0;
    let mut fail = 0;
    let mut panic = 0;
    let mut timeout = 0;
    let mut crashed = 0;
    let mut pending = 0;

    for o in outcome {
        match o {
            Outcome::Pass => pass += 1,
            Outcome::Fail(_) => fail += 1,
            Outcome::Panic => panic += 1,
            Outcome::Timeout => timeout += 1,
            Outcome::Crashed => crashed += 1,
            Outcome::Pending => pending += 1,
        }
    }

    info!("\n{}", "=".repeat(80));
    info!("{:^80}", "ISOLATED TEST STATISTICS");
    info!("{}", "=".repeat(80));
    info!("{:<12} {:>10}", "Passed", pass);
    info!("{:<12} {:>10}", "Failed", fail);
    info!("{:<12} {:>10}", "Panicked", panic);
    info!("{:<12} {:>10}", "Timed out", timeout);
    info!("{:<12} {:>10}", "Crashed", crashed);
    if pending > 0 {
        info!("{:<12} {:>10}", "Not run", pending);
    }
    info!("{}", "-".repeat(80));
    info!("{:<12} {:>10}", "Total", outcome.len());
    info!("{}", "=".repeat(80));

    let problems: Vec<(&str, String)> = names
        .iter()
        .zip(outcome)
        .filter_map(|(name, o)| match o {
            Outcome::Fail(msg) => Some((*name, format!("FAIL: {msg}"))),
            Outcome::Panic => Some((*name, "PANIC".to_string())),
            Outcome::Timeout => Some((*name, "TIMEOUT".to_string())),
            Outcome::Crashed => Some((*name, "CRASHED".to_string())),
            _ => None,
        })
        .collect();

    if problems.is_empty() {
        info!("All tests passed cleanly.");
    } else {
        info!("Problematic tests:");
        for (name, why) in &problems {
            info!("  {:<40} {}", name, why);
        }
    }

    if fail + panic + timeout + crashed > 0 {
        std::process::exit(1);
    }
}

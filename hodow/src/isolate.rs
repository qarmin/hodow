//! Subprocess isolation for CPU tests.
//!
//! In `--isolate` mode the parent process spawns a worker child that runs tests in the
//! canonical order and streams a line protocol on stdout:
//!
//! ```text
//! START <index> <name>
//! DONE  <index> OK
//! DONE  <index> UNVERIFIED <observed value, may be empty>
//! DONE  <index> SKIP <why>
//! DONE  <index> ERR <message>
//! DONE  <index> PANIC
//! END   <count>
//! ```
//!
//! The parent enforces a per-test timeout. If the child segfaults or hangs, the parent
//! attributes the failure to the in-flight test (CRASHED / TIMEOUT) and respawns a fresh
//! worker starting just after it, so a single bad instruction never aborts the whole run.

use std::io::{BufRead, BufReader, Write};
use std::path::Path;
use std::process::{Command, Stdio};
use std::sync::mpsc;
use std::thread;
use std::time::Duration;

use log::{error, info};
use serde::Serialize;

use crate::cli::CpuArgs;

const DEFAULT_TIMEOUT_MS: u64 = 10_000;

#[derive(Clone, PartialEq)]
pub(crate) enum Outcome {
    Pending,
    Pass,
    /// Ran without crashing, but compared its result against nothing - no expected value has
    /// ever been captured for it. Carries the observed value where there is one to capture.
    /// Neither a pass nor a failure: see `hodow_cpu::Verdict`.
    Unverified(Option<String>),
    /// Never executed: a feature guard or Miri turned it away.
    Skipped(String),
    Fail(String),
    Panic,
    Timeout,
    /// How the child died - a signal name where there was one, otherwise the exit status.
    Crashed(String),
}

/// Turn a dead child's exit status into something a reader can act on: SIGILL means the
/// instruction is not available here, SIGSEGV means a bad address, SIGBUS a misaligned one,
/// SIGKILL is usually the OOM killer rather than the test at all. Reporting all of them as a
/// bare "CRASHED" throws that away.
pub(crate) fn crash_reason(status: Option<std::process::ExitStatus>) -> String {
    let Some(status) = status else {
        return "could not be reaped".to_string();
    };
    #[cfg(unix)]
    {
        use std::os::unix::process::ExitStatusExt;
        if let Some(sig) = status.signal() {
            let name = match sig {
                4 => "SIGILL (illegal instruction)",
                5 => "SIGTRAP (trap)",
                6 => "SIGABRT (abort)",
                7 => "SIGBUS (bus error - misaligned or unmapped access)",
                8 => "SIGFPE (arithmetic error)",
                9 => "SIGKILL (killed - usually the OOM killer)",
                11 => "SIGSEGV (segmentation fault)",
                15 => "SIGTERM (terminated)",
                other => return format!("signal {other}"),
            };
            return format!("{name}{}", if status.core_dumped() { ", core dumped" } else { "" });
        }
    }
    #[cfg(windows)]
    if let Some(code) = status.code() {
        let name = match code as u32 {
            0xC000_001D => "STATUS_ILLEGAL_INSTRUCTION (instruction not available)",
            0xC000_0005 => "STATUS_ACCESS_VIOLATION (bad address)",
            0xC000_0094 => "STATUS_INTEGER_DIVIDE_BY_ZERO",
            0xC000_008E => "STATUS_FLOAT_DIVIDE_BY_ZERO",
            0xC000_0095 => "STATUS_INTEGER_OVERFLOW",
            0xC000_0096 => "STATUS_PRIVILEGED_INSTRUCTION",
            0xC000_0409 => "STATUS_STACK_BUFFER_OVERRUN (fast fail / abort)",
            0xC000_00FD => "STATUS_STACK_OVERFLOW",
            0xC000_013A => "STATUS_CONTROL_C_EXIT",
            _ => "",
        };
        if !name.is_empty() {
            return format!("{name}, exit code {:#010X}", code as u32);
        }
    }
    match status.code() {
        Some(code) => format!("exit code {code}"),
        None => "terminated for an unknown reason".to_string(),
    }
}

/// The filtered test list (name, fn) both the worker and the parent must agree on, so
/// index-based progress/crash-attribution stays consistent between the two processes. Both
/// sides compute this independently from the same `-t`/`-e`/`-s` filter state (set on
/// `CpuArgs` before either the worker or the parent branch runs, see `process_cpu`), so the
/// filtered order is deterministic and identical in both.
fn filtered_tests() -> Vec<(&'static str, hodow_cpu::TestFunction)> {
    hodow_cpu::all_tests()
        .into_iter()
        .filter(|(name, feature, _)| !hodow_cpu::should_skip_test_or_feature(name, feature))
        .map(|(name, _feature, f)| (name, f))
        .collect()
}

/// The feature each entry of `filtered_tests()`/`run_isolated_core`'s `names` belongs to, in
/// the same order - kept as a separate pass (rather than widening `filtered_tests()`'s return
/// type) so `run_isolated_core`'s signature, shared with the server executor, doesn't change.
fn filtered_features() -> Vec<&'static str> {
    hodow_cpu::all_tests()
        .into_iter()
        .filter(|(name, feature, _)| !hodow_cpu::should_skip_test_or_feature(name, feature))
        .map(|(_name, feature, _)| feature)
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
            Ok(Ok(hodow_cpu::Verdict::Checked)) => {
                let _ = writeln!(out, "DONE\t{i}\tOK");
            }
            Ok(Ok(hodow_cpu::Verdict::Unverified(value))) => {
                let _ = writeln!(
                    out,
                    "DONE\t{i}\tUNVERIFIED\t{}",
                    sanitize(value.as_deref().unwrap_or(""))
                );
            }
            Ok(Ok(hodow_cpu::Verdict::Skipped(why))) => {
                let _ = writeln!(out, "DONE\t{i}\tSKIP\t{}", sanitize(why));
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
    let session = crate::session::Session::start(
        "cpu",
        "CPU instruction tests (isolated)",
        &std::env::args().skip(1).collect::<Vec<_>>(),
    );
    let mut progress = CpuProgress::new(session.reporter().clone(), filtered_features());
    let result = run_isolated_core(args, |i, name, outcome| progress.on_test(i, name, outcome));
    progress.close();
    session.finish(None);
    let Some((names, outcome)) = result else {
        return;
    };
    if let Some(path) = &args.report {
        match write_report(path, &names, &outcome) {
            Ok(()) => info!("Wrote machine-readable report to {}", path.display()),
            Err(e) => error!("Failed to write report to {}: {e}", path.display()),
        }
    }
    print_report(&names, &outcome);
}

/// Core orchestration loop, reusable by both the plain CLI path above and the server's job
/// executor. `on_event` is called once per test as soon as its outcome is finalized (in
/// execution order, which may skip indices when a crash/timeout forces a respawn past the
/// culprit — the respawn logic below still eventually finalizes every index). Returns
/// `None` if there are no tests to run for this target/filter, else `(names, outcomes)`.
pub(crate) fn run_isolated_core(
    args: &CpuArgs,
    mut on_event: impl FnMut(usize, &'static str, &Outcome),
) -> Option<(Vec<&'static str>, Vec<Outcome>)> {
    // Build the (name-only) filtered list; the fn pointers are only ever executed in the child.
    let names: Vec<&'static str> = filtered_tests().iter().map(|(n, _)| *n).collect();
    let total = names.len();
    if total == 0 {
        info!("No CPU tests available for this target.");
        return None;
    }

    let timeout = Duration::from_millis(args.isolate_timeout_ms.unwrap_or(DEFAULT_TIMEOUT_MS));
    let exe = std::env::current_exe().expect("failed to resolve current executable");
    info!(
        "Isolated run: {} tests, {} ms per-test timeout",
        total,
        timeout.as_millis()
    );

    let mut outcome = vec![Outcome::Pending; total];
    let mut next = 0usize;

    while next < total {
        let prev_next = next;
        let mut cmd = Command::new(&exe);
        cmd.arg("cpu").arg("--worker-start").arg(next.to_string());
        cmd.args(args.flows.forward());
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
                                    "UNVERIFIED" => {
                                        Outcome::Unverified(parts.next().filter(|v| !v.is_empty()).map(str::to_string))
                                    }
                                    "SKIP" => Outcome::Skipped(parts.next().unwrap_or("").to_string()),
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

        let status = child.wait().ok();
        let _ = reader.join();

        // Child died mid-test without a DONE line => it crashed on that test.
        if let Some(culprit) = in_flight
            && culprit < total
        {
            let reason = crash_reason(status);
            info!("CRASHED ({reason}): {}", names[culprit]);
            outcome[culprit] = Outcome::Crashed(reason);
            on_event(culprit, names[culprit], &outcome[culprit]);
            advanced_to = culprit + 1;
        }

        next = advanced_to;
        // Guard against a startup crash producing no progress (avoid an infinite respawn loop).
        if next == prev_next && next < total {
            if outcome[next] == Outcome::Pending {
                let reason = crash_reason(status);
                error!("CRASHED before reporting any progress ({reason}): {}", names[next]);
                outcome[next] = Outcome::Crashed(reason);
                on_event(next, names[next], &outcome[next]);
            }
            next += 1;
        }
    }

    Some((names, outcome))
}

fn print_report(names: &[&'static str], outcome: &[Outcome]) {
    let mut pass = 0;
    let mut unverified = 0;
    let mut capturable = 0;
    let mut skipped = 0;
    let mut fail = 0;
    let mut panic = 0;
    let mut timeout = 0;
    let mut crashed = 0;
    let mut pending = 0;

    for o in outcome {
        match o {
            Outcome::Pass => pass += 1,
            Outcome::Unverified(value) => {
                unverified += 1;
                capturable += usize::from(value.is_some());
            }
            Outcome::Skipped(_) => skipped += 1,
            Outcome::Fail(_) => fail += 1,
            Outcome::Panic => panic += 1,
            Outcome::Timeout => timeout += 1,
            Outcome::Crashed(_) => crashed += 1,
            Outcome::Pending => pending += 1,
        }
    }

    info!("\n{}", "=".repeat(80));
    info!("{:^80}", "ISOLATED TEST STATISTICS");
    info!("{}", "=".repeat(80));
    info!("{:<12} {:>10}", "Passed", pass);
    info!("{:<12} {:>10}", "Unverified", unverified);
    info!("{:<12} {:>10}", "Skipped", skipped);
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
            Outcome::Crashed(reason) => Some((*name, format!("CRASHED: {reason}"))),
            _ => None,
        })
        .collect();

    if problems.is_empty() {
        info!("No failures.");
    } else {
        info!("Problematic tests:");
        for (name, why) in &problems {
            info!("  {:<40} {}", name, why);
        }
    }

    // A pass count on its own says nothing about the unverified ones, the same caveat
    // `gpu`'s not-supported count and hodow_cts's skip count carry.
    if unverified > 0 {
        info!("{unverified} test(s) compared their result against nothing; they only prove the instruction ran.");
        if capturable > 0 {
            info!(
                "  {capturable} of them observed a value: rerun with `--report <file>` and feed it to scripts/cpu/capture_expected.py to turn those into real checks."
            );
        }
        if unverified > capturable {
            info!(
                "  {} have no checkable result at all and stay unverified everywhere.",
                unverified - capturable
            );
        }
    }

    if fail + panic + timeout + crashed > 0 {
        std::process::exit(1);
    }
}

#[derive(Serialize)]
struct ReportRecord {
    name: String,
    feature: String,
    verdict: &'static str,
    got: Option<String>,
    expected: Option<String>,
    message: Option<String>,
}

/// Every `common::check_*` helper formats a mismatch as `"Got {a:?}, expected {b:?}..."`, so
/// this splits that prefix back out into separate fields instead of leaving callers to diff
/// the whole message (which also carries call-site/context text that differs run to run).
fn split_got_expected(msg: &str) -> (Option<String>, Option<String>) {
    let Some(rest) = msg.strip_prefix("Got ") else {
        return (None, None);
    };
    let Some(sep) = rest.find(", expected ") else {
        return (None, None);
    };
    let got = rest[..sep].to_string();
    let after = &rest[sep + ", expected ".len()..];
    let end = after
        .find(" (")
        .or_else(|| after.find(" | call:"))
        .unwrap_or(after.len());
    (Some(got), Some(after[..end].to_string()))
}

fn build_records(names: &[&'static str], outcome: &[Outcome]) -> Vec<ReportRecord> {
    let features = filtered_features();
    names
        .iter()
        .zip(features)
        .zip(outcome)
        .map(|((name, feature), o)| {
            let (verdict, message) = match o {
                Outcome::Pass => ("pass", None),
                Outcome::Unverified(value) => ("unverified", value.clone()),
                Outcome::Skipped(why) => ("skipped", Some(why.clone())),
                Outcome::Fail(msg) => ("fail", Some(msg.clone())),
                Outcome::Panic => ("panic", None),
                Outcome::Timeout => ("timeout", None),
                Outcome::Crashed(reason) => ("crashed", Some(reason.clone())),
                Outcome::Pending => ("pending", None),
            };
            // An unverified test has no `expected` by definition, and its message IS the
            // observed value - the one thing capture_expected.py needs out of this report.
            let (got, expected) = match o {
                Outcome::Unverified(value) => (value.clone(), None),
                _ => message.as_deref().map(split_got_expected).unwrap_or((None, None)),
            };
            ReportRecord {
                name: name.to_string(),
                feature: feature.to_string(),
                verdict,
                got,
                expected,
                message,
            }
        })
        .collect()
}

fn csv_field(s: &str) -> String {
    if s.contains(',') || s.contains('"') || s.contains('\n') {
        format!("\"{}\"", s.replace('"', "\"\""))
    } else {
        s.to_string()
    }
}

fn write_report(path: &Path, names: &[&'static str], outcome: &[Outcome]) -> std::io::Result<()> {
    let records = build_records(names, outcome);
    let is_csv = path
        .extension()
        .and_then(|e| e.to_str())
        .is_some_and(|e| e.eq_ignore_ascii_case("csv"));

    let out = if is_csv {
        let mut s = String::from("name,feature,verdict,got,expected,message\n");
        for r in &records {
            let fields = [
                r.name.as_str(),
                r.feature.as_str(),
                r.verdict,
                r.got.as_deref().unwrap_or(""),
                r.expected.as_deref().unwrap_or(""),
                r.message.as_deref().unwrap_or(""),
            ];
            s.push_str(&fields.map(csv_field).join(","));
            s.push('\n');
        }
        s
    } else {
        serde_json::to_string_pretty(&records).map_err(std::io::Error::other)?
    };

    std::fs::write(path, out)
}

/// Turns the parent's per-test callbacks into events: one overall step, one step per extension family, one finding
/// per test.
struct CpuProgress {
    reporter: hodow_common::Reporter,
    features: Vec<&'static str>,
    overall: hodow_common::Step,
    family: Option<Family>,
    done: u64,
}

struct Family {
    feature: &'static str,
    step: hodow_common::Step,
    done: u64,
}

impl CpuProgress {
    fn new(reporter: hodow_common::Reporter, features: Vec<&'static str>) -> Self {
        let overall = reporter
            .step("CPU tests")
            .unit("tests")
            .total(features.len() as u64)
            .start();
        Self {
            reporter,
            features,
            overall,
            family: None,
            done: 0,
        }
    }

    fn on_test(&mut self, index: usize, name: &'static str, outcome: &Outcome) {
        let Some((verdict, detail, value)) = finding_parts(outcome) else {
            return;
        };
        let feature = self.features.get(index).copied().unwrap_or("unknown");
        if self.family.as_ref().is_none_or(|f| f.feature != feature) {
            if let Some(old) = self.family.take() {
                old.step.finish(hodow_common::StepOutcome::Done);
            }
            let total = self.features.iter().filter(|f| **f == feature).count() as u64;
            let step = self
                .reporter
                .step(feature)
                .parent(&self.overall)
                .unit("tests")
                .total(total)
                .start();
            self.family = Some(Family { feature, step, done: 0 });
        }
        let family = self.family.as_mut().expect("a family step was just opened");
        let mut finding = hodow_common::Finding::new(name, verdict).in_step(family.step.id());
        finding.detail = detail;
        finding.value = value;
        self.reporter.finding(finding);
        self.done += 1;
        family.done += 1;
        self.overall.progress(self.done, Some(name));
        family.step.progress(family.done, Some(name));
    }

    fn close(mut self) {
        if let Some(family) = self.family.take() {
            family.step.finish(hodow_common::StepOutcome::Done);
        }
        self.overall.finish(hodow_common::StepOutcome::Done);
    }
}

fn finding_parts(outcome: &Outcome) -> Option<(hodow_common::Verdict, Option<String>, Option<String>)> {
    use hodow_common::Verdict;
    Some(match outcome {
        Outcome::Pending => return None,
        Outcome::Pass => (Verdict::Passed, None, None),
        Outcome::Unverified(value) => (Verdict::Unverified, None, value.clone()),
        Outcome::Skipped(reason) => (Verdict::Skipped, Some(reason.clone()), None),
        Outcome::Fail(message) => (Verdict::Failed, Some(message.clone()), None),
        Outcome::Panic => (Verdict::Panicked, None, None),
        Outcome::Timeout => (Verdict::TimedOut, None, None),
        Outcome::Crashed(reason) => (Verdict::Crashed, Some(reason.clone()), None),
    })
}

#[cfg(test)]
mod tests {
    use super::split_got_expected;

    #[test]
    fn parses_plain_got_expected() {
        assert_eq!(
            split_got_expected("Got 3, expected 1"),
            (Some("3".into()), Some("1".into()))
        );
    }

    #[test]
    fn parses_got_expected_with_call_suffix() {
        assert_eq!(
            split_got_expected("Got 3, expected 1 | call: _mm_cvtsd_si64(create__m128d_from([1.0, 2.0]))"),
            (Some("3".into()), Some("1".into()))
        );
    }

    #[test]
    fn parses_got_expected_with_paren_suffix() {
        assert_eq!(
            split_got_expected("Got [1.0, 2.0], expected [1.0, 3.0] (Difference is too big)"),
            (Some("[1.0, 2.0]".into()), Some("[1.0, 3.0]".into()))
        );
    }

    #[test]
    fn non_matching_message_returns_none() {
        assert_eq!(split_got_expected("some other error"), (None, None));
    }
}

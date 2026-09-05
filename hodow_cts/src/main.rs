// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).

use std::io::Write;
use std::path::PathBuf;
use std::time::Duration;

use clap::Parser;
use hodow_cts::color;
use hodow_cts::report::{CaseResult, JsonlWriter, Summary};
use hodow_cts::runner::isolate::{EXIT_VULKAN_UNAVAILABLE, IsolateOptions, WORKER_ENV, run_isolated};
use hodow_cts::runner::{RunOptions, execute_selected, matches_filter};
use hodow_cts::tcu::{FlatCase, TestResult};

/// Rust rewrite of the Khronos Vulkan Conformance Test Suite.
///
/// Case names are identical to upstream `deqp-vk`, so a case list works with either
/// binary and results can be compared directly.
#[derive(Parser, Debug)]
#[command(name = "hodow_cts", version, about, long_about = None)]
struct Args {
    /// Run only cases matching this glob, e.g. 'dEQP-VK.compute.*'. Repeatable.
    #[arg(short, long)]
    case: Vec<String>,

    /// Read case names from a file, one per line.
    #[arg(long, value_name = "FILE")]
    case_list: Option<PathBuf>,

    /// Skip cases matching this glob. Repeatable, applied after --case.
    #[arg(long)]
    exclude: Vec<String>,

    /// Print the matching case names and exit without touching Vulkan.
    #[arg(short, long)]
    list: bool,

    /// Turn off ANSI colours. `NO_COLOR` in the environment does the same.
    #[arg(long)]
    no_color: bool,

    /// Write machine-readable results here (JSON Lines, one record per case).
    #[arg(short, long, value_name = "FILE")]
    output: Option<PathBuf>,

    /// Physical device to run on, 1-based, in enumeration order.
    #[arg(long, default_value_t = 1)]
    device_id: usize,

    /// Enable VK_LAYER_KHRONOS_validation and fail any case that produces a message.
    ///
    /// Off by default: the layer changes driver behaviour, so a run with it on is not
    /// a conformance run. Use it to find API misuse in hodow_cts itself.
    #[arg(long)]
    validation: bool,

    /// Run every case in its own process. Slower, but pins down which case crashes.
    #[arg(long)]
    isolate_per_test: bool,

    /// Cases per worker process.
    ///
    /// A worker rebuilds the whole case tree before running anything, so a small batch
    /// pays that cost over and over; crash attribution is per-case regardless of size.
    #[arg(long, default_value_t = 1000)]
    batch_size: usize,

    /// Kill a worker that reports no progress for this many seconds.
    #[arg(long, default_value_t = 60)]
    timeout_secs: u64,

    /// Run in this process without a supervisor. A crash then takes the run with it.
    #[arg(long)]
    no_isolation: bool,
}

fn main() -> std::process::ExitCode {
    let args = Args::parse();
    init_logger(&args);

    if std::env::var(WORKER_ENV).is_ok() {
        return run_as_worker(&args);
    }

    let all = hodow_cts::all_cases();
    let selected = select_cases(&all, &args);

    if args.list {
        for case in &selected {
            println!("{}", case.full_name);
        }
        return std::process::ExitCode::SUCCESS;
    }

    if selected.is_empty() {
        eprintln!("no cases matched; try --list to see what is available");
        return std::process::ExitCode::FAILURE;
    }

    println!("hodow_cts {} ({} cases)", env!("CARGO_PKG_VERSION"), selected.len());
    println!();

    let started = std::time::Instant::now();
    let result = if args.no_isolation {
        run_in_process(&selected, &args)
    } else {
        run_supervised(&selected, &args)
    };
    let elapsed = started.elapsed();

    match result {
        Ok(summary) => {
            println!();
            println!("{summary}");
            println!("  Time:          {}", format_elapsed(elapsed));
            if summary.exit_code() == 0 {
                std::process::ExitCode::SUCCESS
            } else {
                std::process::ExitCode::FAILURE
            }
        }
        Err(e) => {
            eprintln!("error: {e}");
            // Exit 2 means "nothing ran": no driver here. Callers - CI, the justfile's
            // cts-verify - must not read that as a test failure, because no test was
            // given a chance to fail.
            if e.is::<hodow_cts::runner::isolate::VulkanUnavailable>()
                || e.downcast_ref::<hodow_cts::vk::platform::PlatformError>()
                    .is_some_and(|p| matches!(p, hodow_cts::vk::platform::PlatformError::Unavailable(_)))
            {
                return std::process::ExitCode::from(EXIT_VULKAN_UNAVAILABLE as u8);
            }
            std::process::ExitCode::FAILURE
        }
    }
}

fn select_cases<'a>(all: &'a [FlatCase], args: &Args) -> Vec<&'a FlatCase> {
    let from_file: Option<Vec<String>> = args.case_list.as_ref().map(|p| {
        std::fs::read_to_string(p)
            .unwrap_or_else(|e| {
                eprintln!("error: cannot read {}: {e}", p.display());
                std::process::exit(1);
            })
            .lines()
            .map(str::trim)
            .filter(|l| !l.is_empty() && !l.starts_with('#'))
            .map(str::to_string)
            .collect()
    });

    all.iter()
        .filter(|c| match &from_file {
            Some(names) => names.contains(&c.full_name),
            None => args.case.is_empty() || args.case.iter().any(|p| matches_filter(&c.full_name, p)),
        })
        .filter(|c| !args.exclude.iter().any(|p| matches_filter(&c.full_name, p)))
        .collect()
}

fn make_writer(args: &Args) -> std::io::Result<JsonlWriter> {
    match &args.output {
        Some(path) => JsonlWriter::to_file(path),
        None => Ok(JsonlWriter::new(Box::new(std::io::sink()))),
    }
}

/// Colours are forced on rather than gated on a terminal: every recipe pipes this
/// through `tee`, so terminal detection would turn them off exactly where they are
/// wanted. `NO_COLOR` and `--no-color` turn them off; `--list` output stays plain
/// either way, since that is what `diff_vs_deqp.py` reads.
fn init_logger(args: &Args) {
    let colors = !args.no_color && std::env::var_os("NO_COLOR").is_none();
    color::set_enabled(colors);
    // Isolated workers are separate processes that inherit the environment but not the
    // flags, so `--no-color` is passed on as the variable rather than as an argument.
    if !colors {
        unsafe { std::env::set_var("NO_COLOR", "1") };
    }

    env_logger::Builder::from_env(env_logger::Env::default().default_filter_or("info"))
        .write_style(if colors { env_logger::WriteStyle::Always } else { env_logger::WriteStyle::Never })
        .format(|buf, record| {
            let level = match record.level() {
                log::Level::Error => color::paint(color::BOLD_RED, "ERROR"),
                log::Level::Warn => color::paint(color::YELLOW, "WARN "),
                log::Level::Info => color::paint(color::GREEN, "INFO "),
                log::Level::Debug => color::paint(color::BLUE, "DEBUG"),
                log::Level::Trace => color::paint(color::MAGENTA, "TRACE"),
            };
            let case = color::current_case();
            if case.is_empty() {
                writeln!(buf, "{level} {}", record.args())
            } else {
                writeln!(buf, "{level} {} {}", color::paint(color::DIM, &case), record.args())
            }
        })
        .init();
}

fn print_case(result: &CaseResult) {
    let marker = match result.status {
        TestResult::Pass => color::paint(color::GREEN, "Pass"),
        TestResult::Fail => color::paint(color::BOLD_RED, "FAIL"),
        TestResult::Crash | TestResult::DeviceLost => color::paint(color::BOLD_RED, result.status.as_str()),
        TestResult::NotSupported => color::paint(color::YELLOW, result.status.as_str()),
        other => color::paint(color::CYAN, other.as_str()),
    };
    println!(
        "{}: {marker} ({}) [{}]",
        result.name,
        result.message,
        color::paint(color::DIM, &format_duration(result.duration_us))
    );
}

/// Whole-run wall time. Minutes once it is past one, because a four-digit second
/// count is the number nobody can read at a glance.
fn format_elapsed(elapsed: Duration) -> String {
    let secs = elapsed.as_secs_f64();
    if secs < 60.0 {
        format!("{secs:.1}s")
    } else {
        format!("{secs:.0}s ({}m {:02}s)", secs as u64 / 60, secs as u64 % 60)
    }
}

/// A fixed unit throughout, so the column can be scanned for the slow case rather than
/// read one line at a time.
fn format_duration(duration_us: u64) -> String {
    format!("{:.3} ms", duration_us as f64 / 1000.0)
}

fn run_in_process(selected: &[&FlatCase], args: &Args) -> Result<Summary, Box<dyn std::error::Error>> {
    let mut writer = make_writer(args)?;
    let options = RunOptions {
        device_id: args.device_id,
        validation: args.validation,
        write_header: true,
    };
    execute_selected(selected, &options, &mut writer, print_case)
}

fn run_supervised(selected: &[&FlatCase], args: &Args) -> Result<Summary, Box<dyn std::error::Error>> {
    let mut writer = make_writer(args)?;
    let names: Vec<String> = selected.iter().map(|c| c.full_name.clone()).collect();

    let options = IsolateOptions {
        batch_size: if args.isolate_per_test { 1 } else { args.batch_size.max(1) },
        case_timeout: Duration::from_secs(args.timeout_secs),
        device_id: args.device_id,
        validation: args.validation,
    };

    let (results, summary) = run_isolated(&names, &options, print_case)?;

    for result in &results {
        writer.write_case(result)?;
    }

    Ok(summary)
}

fn run_as_worker(args: &Args) -> std::process::ExitCode {
    // The parent sends the batch on stdin, one case name per line, and closes it.
    let mut batch = String::new();
    if let Err(e) = std::io::Read::read_to_string(&mut std::io::stdin(), &mut batch) {
        eprintln!("worker error: cannot read the case list from stdin: {e}");
        return std::process::ExitCode::FAILURE;
    }

    let all = hodow_cts::all_cases();
    let by_name: std::collections::HashMap<&str, &FlatCase> = all.iter().map(|c| (c.full_name.as_str(), c)).collect();
    let selected: Vec<&FlatCase> = batch.lines().map(str::trim).filter(|n| !n.is_empty()).filter_map(|n| by_name.get(n).copied()).collect();

    // The worker's stdout IS the result channel the parent parses, so nothing else may
    // be written to it.
    let mut writer = JsonlWriter::new(Box::new(WorkerStdout));
    let options = RunOptions {
        device_id: args.device_id,
        validation: args.validation,
        write_header: false,
    };

    match execute_selected(&selected, &options, &mut writer, |_| {}) {
        // Per-case verdicts travel in the stream; the exit code only says whether the
        // worker itself survived, which is what the parent uses to detect a crash.
        Ok(_) => std::process::ExitCode::SUCCESS,
        Err(e) => {
            eprintln!("worker error: {e}");
            // A missing driver is an environment problem, not a crash caused by the
            // case that happened to be first. The parent needs to tell them apart.
            if e.downcast_ref::<hodow_cts::vk::platform::PlatformError>()
                .is_some_and(|p| matches!(p, hodow_cts::vk::platform::PlatformError::Unavailable(_)))
            {
                return std::process::ExitCode::from(EXIT_VULKAN_UNAVAILABLE as u8);
            }
            std::process::ExitCode::FAILURE
        }
    }
}

struct WorkerStdout;

impl Write for WorkerStdout {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        std::io::stdout().write(buf)
    }

    fn flush(&mut self) -> std::io::Result<()> {
        std::io::stdout().flush()
    }
}

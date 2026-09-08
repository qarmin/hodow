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
use hodow_cts::runner::isolate::{DriverUnavailable, EXIT_DRIVER_UNAVAILABLE, EXIT_SETUP_ERROR, IsolateOptions, WORKER_ENV, run_isolated};
use hodow_cts::runner::{Api, RunOptions, matches_filter};
use hodow_cts::tcu::{FlatCase, TestResult};

/// Rust rewrite of the Khronos Conformance Test Suite.
///
/// Case names are identical to upstream `deqp-vk` / `deqp-gles31`, so a case list works
/// with either binary and results can be compared directly. Which API a case belongs to
/// is decided by the root of its name (`dEQP-VK.*`, `dEQP-GLES31.*`), so a run can span
/// both: each API is brought up in turn.
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

    /// Print the matching case names and exit without touching a driver.
    #[arg(short, long)]
    list: bool,

    /// Turn off ANSI colours. `NO_COLOR` in the environment does the same.
    #[arg(long)]
    no_color: bool,

    /// Run this many worker processes at once. `dEQP-VK.memory.*` always keeps the
    /// device to itself, whatever this says, because those cases claim most of a heap
    /// and would fail each other rather than the driver.
    #[arg(short = 'j', long, default_value_t = 1)]
    jobs: usize,

    /// Write machine-readable results here (JSON Lines, one record per case).
    #[arg(short, long, value_name = "FILE")]
    output: Option<PathBuf>,

    /// Device to run on, 1-based, in enumeration order. For `dEQP-GLES31` this selects
    /// an EGL device, which only the EGL device platform enumerates.
    #[arg(long, default_value_t = 1)]
    device_id: usize,

    /// List the cases that are registered but have no test logic behind them yet.
    #[arg(long)]
    list_stubs: bool,

    /// Fail any case that misused the API: `VK_LAYER_KHRONOS_validation` for Vulkan, a
    /// GL error left pending for OpenGL ES.
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

    let names_from_file = match read_case_list(&args) {
        Ok(names) => names,
        Err(e) => {
            eprintln!("error: {e}");
            return std::process::ExitCode::FAILURE;
        }
    };

    let all_vk = hodow_cts::all_cases();
    let all_gles = hodow_cts::all_gles31_cases();
    let vk_selected = select_cases(&all_vk, &args, names_from_file.as_deref());
    let gles_selected = select_cases(&all_gles, &args, names_from_file.as_deref());
    let total = vk_selected.len() + gles_selected.len();

    if args.list {
        for name in vk_selected.iter().map(|c| &c.full_name).chain(gles_selected.iter().map(|c| &c.full_name)) {
            println!("{name}");
        }
        return std::process::ExitCode::SUCCESS;
    }

    if args.list_stubs {
        for case in vk_selected.iter().filter(|c| c.case.is_stub()) {
            println!("{}", case.full_name);
        }
        for case in gles_selected.iter().filter(|c| c.case.is_stub()) {
            println!("{}", case.full_name);
        }
        return std::process::ExitCode::SUCCESS;
    }

    if total == 0 {
        eprintln!("no cases matched; try --list to see what is available");
        return std::process::ExitCode::FAILURE;
    }

    println!("hodow_cts {} ({total} cases)", env!("CARGO_PKG_VERSION"));
    println!();

    let started = std::time::Instant::now();
    let mut writer = match make_writer(&args) {
        Ok(writer) => writer,
        Err(e) => {
            eprintln!("error: {e}");
            return std::process::ExitCode::FAILURE;
        }
    };

    // Each API is a separate run against a separate driver, so they go one after the
    // other and the summaries are added up. Vulkan first, matching --list.
    let mut summary = Summary::default();
    let mut unavailable: Vec<String> = Vec::new();

    let spans_both = !vk_selected.is_empty() && !gles_selected.is_empty();

    for api in Api::ALL {
        let count = match api {
            Api::Vulkan => vk_selected.len(),
            Api::Gles31 => gles_selected.len(),
        };
        if count == 0 {
            continue;
        }

        if spans_both {
            println!("{} ({count} cases)", api.label());
        }

        let result = if args.no_isolation {
            match api {
                Api::Vulkan => hodow_cts::runner::vulkan::execute_selected(&vk_selected, &run_options(&args), &mut writer, print_case),
                Api::Gles31 => hodow_cts::runner::gles::execute_selected(&gles_selected, &run_options(&args), &mut writer, print_case),
            }
        } else {
            let names: Vec<String> = match api {
                Api::Vulkan => vk_selected.iter().map(|c| c.full_name.clone()).collect(),
                Api::Gles31 => gles_selected.iter().map(|c| c.full_name.clone()).collect(),
            };
            run_supervised(api, &names, &args, &mut writer)
        };

        match result {
            Ok(sub) => summary.merge(&sub),
            Err(e) => {
                if is_driver_unavailable(e.as_ref()) {
                    // Nothing ran for this API. That is not a test failure, and if the
                    // other API did run, its verdicts still stand.
                    eprintln!("{e}");
                    unavailable.push(api.label().to_string());
                    continue;
                }
                eprintln!("error: {e}");
                return std::process::ExitCode::FAILURE;
            }
        }
    }

    let elapsed = started.elapsed();
    println!();
    println!("{summary}");
    println!("  Time:          {}", format_elapsed(elapsed));

    if !unavailable.is_empty() {
        println!("  Unavailable:   {} (no driver - nothing was run for it)", unavailable.join(", "));
        // Exit 2 only when *nothing* ran; if one API produced verdicts, they decide.
        if summary.total() == 0 {
            return std::process::ExitCode::from(EXIT_DRIVER_UNAVAILABLE as u8);
        }
    }

    if summary.exit_code() == 0 {
        std::process::ExitCode::SUCCESS
    } else {
        std::process::ExitCode::FAILURE
    }
}

/// Whether an error means "no driver here", which is exit 2 rather than a failure.
///
/// Each API reports it in its own type, and the supervised path wraps it again, so all
/// three are checked here rather than at each call site.
fn is_driver_unavailable(error: &(dyn std::error::Error + 'static)) -> bool {
    error.is::<DriverUnavailable>()
        || error.is::<hodow_cts::eglw::LoadError>()
        || error
            .downcast_ref::<hodow_cts::vk::platform::PlatformError>()
            .is_some_and(|p| matches!(p, hodow_cts::vk::platform::PlatformError::Unavailable(_)))
}

fn run_options(args: &Args) -> RunOptions {
    RunOptions {
        device_id: args.device_id,
        validation: args.validation,
        write_header: true,
    }
}

fn read_case_list(args: &Args) -> std::io::Result<Option<Vec<String>>> {
    let Some(path) = &args.case_list else {
        return Ok(None);
    };
    let text = std::fs::read_to_string(path).map_err(|e| std::io::Error::new(e.kind(), format!("cannot read {}: {e}", path.display())))?;
    Ok(Some(
        text.lines().map(str::trim).filter(|l| !l.is_empty() && !l.starts_with('#')).map(str::to_string).collect(),
    ))
}

fn select_cases<'a, C: ?Sized>(all: &'a [FlatCase<C>], args: &Args, from_file: Option<&[String]>) -> Vec<&'a FlatCase<C>> {
    all.iter()
        .filter(|c| match from_file {
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

fn run_supervised(api: Api, names: &[String], args: &Args, writer: &mut JsonlWriter) -> Result<Summary, Box<dyn std::error::Error>> {
    let options = IsolateOptions {
        api,
        batch_size: if args.isolate_per_test { 1 } else { args.batch_size.max(1) },
        case_timeout: Duration::from_secs(args.timeout_secs),
        device_id: args.device_id,
        validation: args.validation,
        jobs: args.jobs.max(1),
    };

    let (results, summary) = run_isolated(names, &options, print_case)?;

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
    let wanted: Vec<&str> = batch.lines().map(str::trim).filter(|n| !n.is_empty()).collect();

    // A batch never mixes APIs - the parent splits the selection by root before it
    // gets here - so the first name says which driver to bring up.
    let Some(api) = wanted.first().and_then(|name| Api::from_case_name(name)) else {
        eprintln!("worker error: the batch is empty or names no known API");
        return std::process::ExitCode::FAILURE;
    };

    // The worker's stdout IS the result channel the parent parses, so nothing else may
    // be written to it.
    let mut writer = JsonlWriter::new(Box::new(WorkerStdout));
    let options = RunOptions {
        device_id: args.device_id,
        validation: args.validation,
        write_header: false,
    };

    let result = match api {
        Api::Vulkan => {
            let all = hodow_cts::all_cases();
            let selected = pick(&all, &wanted);
            hodow_cts::runner::vulkan::execute_selected(&selected, &options, &mut writer, |_| {})
        }
        Api::Gles31 => {
            let all = hodow_cts::all_gles31_cases();
            let selected = pick(&all, &wanted);
            hodow_cts::runner::gles::execute_selected(&selected, &options, &mut writer, |_| {})
        }
    };

    match result {
        // Per-case verdicts travel in the stream; the exit code only says whether the
        // worker itself survived, which is what the parent uses to detect a crash.
        Ok(_) => std::process::ExitCode::SUCCESS,
        Err(e) => {
            eprintln!("worker error: {e}");
            // A missing driver is an environment problem, not a crash caused by the
            // case that happened to be first. The parent needs to tell them apart.
            if is_driver_unavailable(e.as_ref()) {
                return std::process::ExitCode::from(EXIT_DRIVER_UNAVAILABLE as u8);
            }
            // Setting the API up failed for some other reason - a requested layer that
            // is not installed, say. Not this case's fault either.
            match e.downcast_ref::<hodow_cts::vk::platform::PlatformError>() {
                Some(hodow_cts::vk::platform::PlatformError::InitError(_)) => std::process::ExitCode::from(EXIT_SETUP_ERROR as u8),
                _ => std::process::ExitCode::FAILURE,
            }
        }
    }
}

/// The batch's cases, in the order the parent asked for them.
fn pick<'a, C: ?Sized>(all: &'a [FlatCase<C>], wanted: &[&str]) -> Vec<&'a FlatCase<C>> {
    let by_name: std::collections::HashMap<&str, &FlatCase<C>> = all.iter().map(|c| (c.full_name.as_str(), c)).collect();
    wanted.iter().filter_map(|name| by_name.get(*name).copied()).collect()
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

// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).

use std::io::Write;
use std::path::PathBuf;
use std::time::Duration;

use clap::Parser;

use crate::color;
use crate::report::{CaseResult, JsonlWriter, Summary};
use crate::runner::isolate::{
    DriverUnavailable, EXIT_DRIVER_UNAVAILABLE, EXIT_SETUP_ERROR, IsolateOptions, QUIET_SETUP_ENV, WORKER_ENV,
    run_isolated,
};
use crate::runner::{Api, RunOptions, matches_filter};
use crate::tcu::{FlatCase, TestResult};

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

    /// Print a line when a case *starts*, not only when it finishes.
    ///
    /// The result line can only be written once a case returns, so a case that hangs or
    /// takes the process down never names itself. This is what to turn on when chasing
    /// one: the last `>` line is the case that is still running.
    #[arg(short, long)]
    verbose: bool,

    /// Stop at the first case that crashes, hangs or loses the device instead of
    /// restarting the worker after it, so the whole selection is one process.
    #[arg(long)]
    stop_on_crash: bool,

    /// Print every result as `@result <json>` on stdout as soon as it arrives, for a
    /// supervisor reading the run over ssh.
    #[arg(long)]
    emit_results: bool,

    /// Optional, so every invocation above keeps working exactly as it did.
    #[command(subcommand)]
    cmd: Option<Command>,
}

#[derive(clap::Subcommand, Debug)]
enum Command {
    #[command(flatten)]
    Fuzz(crate::fuzz::cli::Cmd),
    /// Test a board over ssh unattended: batches, shuffled groups and full runs, with every
    /// crash or hang minimised, recorded and quarantined.
    Board(crate::board::BoardArgs),
}

/// What a caller embedding the runner (the `hodow` binary) is told as a run goes. The runner prints its own report either
/// way; this is the same information as values. `selected` and `finished` are called only for a real run, never for
/// `--list`, `fuzz` or `board`.
pub trait Observer: Send + Sync {
    /// How many cases can actually run, once the plan is known.
    fn selected(&self, _total: usize) {}
    fn result(&self, _result: &CaseResult) {}
    /// The exit code the run is about to return.
    fn finished(&self, _code: u8) {}
}

static OBSERVER: std::sync::OnceLock<Box<dyn Observer>> = std::sync::OnceLock::new();
static SELECTED: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);
static FINISHED: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);

pub fn set_observer(observer: Box<dyn Observer>) {
    let _ = OBSERVER.set(observer);
}

fn notify_selected(total: usize) {
    SELECTED.store(true, std::sync::atomic::Ordering::Relaxed);
    if let Some(o) = OBSERVER.get() {
        o.selected(total);
    }
}

fn notify_finished(code: u8) {
    use std::sync::atomic::Ordering;
    if SELECTED.load(Ordering::Relaxed)
        && !FINISHED.swap(true, Ordering::Relaxed)
        && let Some(o) = OBSERVER.get()
    {
        o.finished(code);
    }
}

/// The whole command line: `args` includes the program name, as `std::env::args_os` does.
pub fn main_from<I, T>(args: I) -> u8
where
    I: IntoIterator<Item = T>,
    T: Into<std::ffi::OsString> + Clone,
{
    crate::install_case_providers();
    let code = run(Args::parse_from(args));
    notify_finished(code);

    // A driver that stopped serving takes this process's own teardown with it. The
    // context brought up here to build the case tree has driver threads inside it, and
    // after a hang they are blocked in the kernel for good - so returning normally hangs
    // in exit, with the report already printed and nothing left to do. Observed on the
    // board: the supervisor sat there for minutes after its own summary, and the reboot
    // then waited on it as well.
    if crate::runner::reap::driver_is_gone() {
        crate::runner::reap::exit_without_teardown(code);
    }
    code
}

/// Whether `args` (without the program name) describe something the dashboard may queue: a plain run, not a listing,
/// a fuzz campaign or a board session, and nothing that writes outside the results directory.
pub fn validate_job(args: &[String]) -> Result<(), String> {
    let parsed = Args::try_parse_from(std::iter::once("hodow cts".to_string()).chain(args.iter().cloned()))
        .map_err(|e| e.render().to_string())?;
    if parsed.cmd.is_some()
        || parsed.list
        || parsed.list_stubs
        || parsed.output.is_some()
        || parsed.case_list.is_some()
        || parsed.emit_results
    {
        return Err("only a plain run is accepted: no fuzz, board, --list, --list-stubs, --output, --case-list or --emit-results".into());
    }
    if parsed.case.is_empty() {
        return Err("name what to run with --case, e.g. --case 'dEQP-GLES2.*'".into());
    }
    Ok(())
}

/// Exit codes as numbers rather than `ExitCode`, which cannot be read back - and the
/// number is what `_exit` needs on the way out of a hung driver.
const OK: u8 = 0;
const FAILED: u8 = 1;

fn run(mut args: Args) -> u8 {
    if matches!(args.cmd, Some(Command::Board(_)))
        && let Some(Command::Board(board_args)) = args.cmd.take()
    {
        return crate::board::main(board_args);
    }
    let defaulted_env = crate::runner::sysinfo::default_wayland_env();
    init_logger(&args);
    if !defaulted_env.is_empty() {
        log::info!("Wayland environment defaulted: {}", defaulted_env.join(" "));
    }

    // Before the subcommand: a fuzz campaign's workers are this same binary re-executed
    // with the top-level flags and no subcommand, so they must still land here.
    if std::env::var(WORKER_ENV).is_ok() {
        return run_as_worker(&args);
    }

    if let Some(Command::Fuzz(cmd)) = args.cmd.take() {
        return crate::fuzz::exit_code(cmd);
    }

    let names_from_file = match read_case_list(&args) {
        Ok(names) => names,
        Err(e) => {
            eprintln!("error: {e}");
            return FAILED;
        }
    };

    // Only the roots this invocation could possibly select. Building a case tree is not
    // free - the four together are 675k cases and ~460 ms of allocation on every process
    // start, 93% of it Vulkan - and a `dEQP-GLES*` run used to pay all of it and touch
    // none of it. `--isolate-per-test` and every fuzzer worker pay it per process.
    let wanted = roots_wanted(&args, names_from_file.as_deref());
    let all_vk = if wanted.contains(&Api::Vulkan) {
        crate::all_cases()
    } else {
        Vec::new()
    };
    let all_gl = crate::gl_cases(&wanted);

    if let Some(names) = names_from_file.as_deref() {
        let known: std::collections::HashSet<&str> = case_names(&all_vk).chain(case_names(&all_gl)).collect();
        warn_unknown_case_names(names, &known);
    }

    // One selection per API, in `Api::ALL` order, which is also the order they run in
    // and the order `--list` prints. Vulkan's cases are a different type from the GL
    // ones, so the two lists stay apart; everything past this point works off the
    // per-API selection and does not care which of the two it is.
    let selections: Vec<(Api, Selection<'_>)> = Api::ALL
        .into_iter()
        .map(|api| {
            let selected = match api {
                Api::Vulkan => Selection::Vk(select_cases(&all_vk, api, &args, names_from_file.as_deref())),
                _ => Selection::Gl(select_cases(&all_gl, api, &args, names_from_file.as_deref())),
            };
            (api, selected)
        })
        .collect();
    let total: usize = selections.iter().map(|(_, s)| s.len()).sum();

    if args.list {
        for (_, selection) in &selections {
            for name in selection.names() {
                println!("{name}");
            }
        }
        note_compiled_out_halves();
        return OK;
    }

    if args.list_stubs {
        for (_, selection) in &selections {
            for name in selection.stub_names() {
                println!("{name}");
            }
        }
        return OK;
    }

    if total == 0 {
        eprintln!("no cases matched; try --list to see what is available");
        note_compiled_out_halves();
        return FAILED;
    }

    println!("hodow_cts {} ({total} cases selected)", env!("CARGO_PKG_VERSION"));
    println!("System   {}", crate::runner::sysinfo::system_line());
    println!("Display  {}", crate::runner::sysinfo::display_line());
    println!();

    // Bring every selected root's driver up once before the first case, so the plan is
    // visible up front rather than discovered one root at a time. The counter's
    // denominator then counts only what can actually run - on a board with no Vulkan
    // driver the 625k dEQP-VK cases are not work anybody is waiting for.
    let probes = probe_drivers(&selections, &args);
    let runnable = print_plan(&selections, &probes);
    notify_selected(runnable);

    let started = std::time::Instant::now();
    let mut writer = match make_writer(&args) {
        Ok(writer) => writer,
        Err(e) => {
            eprintln!("error: {e}");
            return FAILED;
        }
    };

    // Each API is a separate run against a separate driver - and for the GL ones, a
    // separate context version - so they go one after the other and the summaries are
    // added up.
    let mut summary = Summary::default();
    let mut unavailable: Vec<String> = Vec::new();
    let progress = CaseProgress::new(runnable, args.verbose);

    let spans_several = selections.iter().filter(|(_, s)| s.len() > 0).count() > 1;

    for (api, selection) in &selections {
        if selection.len() == 0 {
            continue;
        }

        // The probe already answered this; running it again would only reproduce the
        // same failure, slowly.
        if let Some((_, DriverStatus::Unavailable(_))) = probes.iter().find(|(probed, _)| probed == api) {
            unavailable.push(api.label().to_string());
            continue;
        }

        if spans_several {
            println!("{} ({} cases)", api.label(), selection.len());
        }

        let result = if args.no_isolation {
            match selection {
                Selection::Vk(cases) => crate::runner::vulkan::execute_selected(
                    cases,
                    &run_options(&args),
                    &mut writer,
                    |n| progress.starting(n),
                    |r| progress.print(r),
                ),
                Selection::Gl(cases) => {
                    let api_types = api.gl_api_types().expect("a GL selection belongs to a GL API");
                    crate::runner::gles::execute_selected(
                        api_types,
                        cases,
                        &run_options(&args),
                        &mut writer,
                        |n| progress.starting(n),
                        |r| progress.print(r),
                    )
                }
            }
        } else {
            run_supervised(*api, &selection.names(), &args, &mut writer, &progress)
        };

        match result {
            Ok(sub) => summary.merge(&sub),
            Err(e) => {
                if is_driver_unavailable(e.as_ref()) {
                    // Nothing ran for this API. That is not a test failure, and any
                    // other API that did run keeps its verdicts.
                    eprintln!("{e}");
                    unavailable.push(api.label().to_string());
                    continue;
                }
                eprintln!("error: {e}");
                return FAILED;
            }
        }
    }

    let elapsed = started.elapsed();
    println!();
    println!("{summary}");
    println!("  Time:          {}", format_elapsed(elapsed));

    // A per-case duration is measured around the case body alone. Under isolation the
    // rest - spawning a worker, bringing the driver up, building the case tree - is
    // real time this run spent and is invisible in every other number here, which is
    // why a run of 60 ms of cases can take a second.
    let case_time = Duration::from_micros(progress.case_time_us.load(std::sync::atomic::Ordering::Relaxed));
    match elapsed.checked_sub(case_time) {
        Some(overhead) => {
            println!("    in cases:    {}", format_elapsed(case_time));
            println!(
                "    setup:       {} (process start, driver bring-up, case tree)",
                format_elapsed(overhead)
            );
        }
        // With several workers the case times are concurrent, so they add up to more
        // than the wall clock. That is the parallelism, not an error.
        None => println!(
            "    in cases:    {} summed across {} workers",
            format_elapsed(case_time),
            args.jobs.max(1)
        ),
    }

    // Exit 2 only when *nothing* ran; if one API produced verdicts, they decide.
    let nothing_ran = !unavailable.is_empty() && summary.total() == 0;
    if !unavailable.is_empty() {
        println!(
            "  Unavailable:   {} (no driver - nothing was run for it)",
            unavailable.join(", ")
        );
    }
    let code = if nothing_ran {
        EXIT_DRIVER_UNAVAILABLE as u8
    } else if summary.exit_code() == 0 {
        OK
    } else {
        FAILED
    };

    // Everything is reported by this line, and nothing below it is worth hanging for.
    // Returning would drop the render context, and on a driver that has stopped serving
    // that lands in `gckOS_AcquireMutex` holding a mutex no living thread will release -
    // observed on the board, a supervisor still there minutes after its own summary.
    notify_finished(code);
    if crate::runner::reap::driver_is_gone() {
        crate::runner::reap::exit_without_teardown(code);
    }
    code
}

/// Whether an error means "no driver here", which is exit 2 rather than a failure.
///
/// Each API reports it in its own type, and the supervised path wraps it again, so all
/// three are checked here rather than at each call site.
fn is_driver_unavailable(error: &(dyn std::error::Error + 'static)) -> bool {
    error.is::<DriverUnavailable>()
        || error.is::<crate::eglw::LoadError>()
        || error
            .downcast_ref::<crate::vk::platform::PlatformError>()
            .is_some_and(|p| matches!(p, crate::vk::platform::PlatformError::Unavailable(_)))
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
    let text = std::fs::read_to_string(path)
        .map_err(|e| std::io::Error::new(e.kind(), format!("cannot read {}: {e}", path.display())))?;
    Ok(Some(
        text.lines()
            .map(str::trim)
            .filter(|l| !l.is_empty() && !l.starts_with('#'))
            .map(str::to_string)
            .collect(),
    ))
}

/// One API's share of the selection. The two arms hold different case types, which is
/// the whole reason this enum exists rather than one list.
enum Selection<'a> {
    Vk(Vec<&'a crate::vkt::FlatCase>),
    Gl(Vec<&'a crate::glu::FlatCase>),
}

impl Selection<'_> {
    fn len(&self) -> usize {
        match self {
            Self::Vk(cases) => cases.len(),
            Self::Gl(cases) => cases.len(),
        }
    }

    fn names(&self) -> Vec<String> {
        match self {
            Self::Vk(cases) => cases.iter().map(|c| c.full_name.clone()).collect(),
            Self::Gl(cases) => cases.iter().map(|c| c.full_name.clone()).collect(),
        }
    }

    fn stub_names(&self) -> Vec<String> {
        match self {
            Self::Vk(cases) => cases
                .iter()
                .filter(|c| c.case.is_stub())
                .map(|c| c.full_name.clone())
                .collect(),
            Self::Gl(cases) => cases
                .iter()
                .filter(|c| c.case.is_stub())
                .map(|c| c.full_name.clone())
                .collect(),
        }
    }
}

/// The cases of one API that this run should execute, in the order it should execute
/// them.
///
/// With `--case-list` that order is the **file's**, not the corpus'. A case list is an
/// ordered sequence: anything chasing a failure that depends on what ran before it is
/// testing a different thing the moment the list is reordered, and reordering it was
/// exactly what this did. The worker's `pick` has always honoured the order it was
/// handed; this end was the one that did not. A name repeated in the file runs
/// repeatedly, for the same reason - and again because `pick` already does that.
fn select_cases<'a, C: ?Sized>(
    all: &'a [FlatCase<C>],
    api: Api,
    args: &Args,
    from_file: Option<&[String]>,
) -> Vec<&'a FlatCase<C>> {
    let in_api = |name: &str| name.split('.').next() == Some(api.root());
    let excluded = |name: &str| args.exclude.iter().any(|p| matches_filter(name, p));

    let Some(names) = from_file else {
        return all
            .iter()
            .filter(|c| in_api(&c.full_name))
            .filter(|c| args.case.is_empty() || args.case.iter().any(|p| matches_filter(&c.full_name, p)))
            .filter(|c| !excluded(&c.full_name))
            .collect();
    };

    // Resolved through a map rather than a scan of `all` per name: the corpus is 675k
    // cases, so a thousand-name list cost 675M string comparisons in `Vec::contains`.
    let by_name: std::collections::HashMap<&str, &FlatCase<C>> =
        all.iter().map(|c| (c.full_name.as_str(), c)).collect();
    names
        .iter()
        .filter(|name| in_api(name))
        .filter(|name| !excluded(name))
        .filter_map(|name| by_name.get(name.as_str()).copied())
        .collect()
}

fn case_names<C: ?Sized>(all: &[FlatCase<C>]) -> impl Iterator<Item = &str> {
    all.iter().map(|c| c.full_name.as_str())
}

/// Says so when half the suite was left out at build time.
///
/// Without this, a root that is absent because its feature is off looks exactly like a
/// filter that matched nothing, and the first thing anyone does is go hunting for a bug
/// in the selection. Goes to stderr so `--list` output stays machine-readable - that is
/// what `diff_vs_deqp.py` parses.
fn note_compiled_out_halves() {
    if !crate::HAS_GLES {
        eprintln!("note: the OpenGL ES half is not compiled into this binary (rebuild with --features gles)");
    }
    if !crate::HAS_GL {
        eprintln!(
            "note: the desktop OpenGL half (KHR-GL46) is not compiled into this binary (rebuild with --features gl)"
        );
    }
    if !crate::HAS_VULKAN {
        eprintln!("note: the Vulkan half is not compiled into this binary (rebuild with --features vulkan)");
    }
}

/// The roots this invocation could select something from, so the rest are never built.
///
/// Over-approximates deliberately. A false positive costs what this always used to cost;
/// a false negative would silently run nothing, which is the one outcome a test tool must
/// never produce quietly.
///
/// A `--case-list` decides it exactly - the file names its roots - which is also why the
/// unknown-name warning stays honest: every root the file mentions is built, so a name
/// reported unknown really is.
fn roots_wanted(args: &Args, from_file: Option<&[String]>) -> Vec<Api> {
    Api::ALL
        .into_iter()
        .filter(|api| match from_file {
            Some(names) => names.iter().any(|name| name.split('.').next() == Some(api.root())),
            None => {
                args.case.is_empty()
                    || args
                        .case
                        .iter()
                        .any(|pattern| pattern_could_match_root(pattern, api.root()))
            }
        })
        .collect()
}

/// Whether a glob could match any case name under `root`, without enumerating anything.
///
/// Everything before a pattern's first `*` must appear literally at the start of whatever
/// it matches, so comparing that head against `<root>.` settles it. Note this gets
/// `dEQP-GLES3.*` right: `dEQP-GLES31` case names do not start with `dEQP-GLES3.`, so
/// that root is correctly left out.
fn pattern_could_match_root(pattern: &str, root: &str) -> bool {
    let head = pattern.split('*').next().unwrap_or("");
    let prefix = format!("{root}.");
    prefix.starts_with(head) || head.starts_with(&prefix)
}

/// Reports `--case-list` entries that no case answers to any more.
///
/// Dropping them silently is how replaying a saved list quietly becomes a run of a
/// *different*, shorter list - which matters most for the one job a saved list has,
/// reproducing a failure that depends on exactly what ran before it. Not an error:
/// running an upstream mustpass file against a partial port is a legitimate use, and
/// there most of the file is expected to be missing.
fn warn_unknown_case_names(names: &[String], known: &std::collections::HashSet<&str>) {
    const SHOWN: usize = 5;

    let unknown = unknown_case_names(names, known);
    if unknown.is_empty() {
        return;
    }
    eprintln!(
        "warning: {} of {} name(s) in the case list match no registered case:",
        unknown.len(),
        names.len()
    );
    for name in unknown.iter().take(SHOWN) {
        eprintln!("  {name}");
    }
    if unknown.len() > SHOWN {
        eprintln!("  ... and {} more", unknown.len() - SHOWN);
    }
}

/// Every entry of `names` no case answers to, in the file's order and with repeats
/// kept - a name listed twice that is gone is two entries of a shorter run than the
/// file asked for.
fn unknown_case_names<'a>(names: &'a [String], known: &std::collections::HashSet<&str>) -> Vec<&'a String> {
    names.iter().filter(|n| !known.contains(n.as_str())).collect()
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

    let default_level = if std::env::var_os(QUIET_SETUP_ENV).is_some() {
        "warn"
    } else {
        "info"
    };
    env_logger::Builder::from_env(env_logger::Env::default().default_filter_or(default_level))
        .write_style(if colors {
            env_logger::WriteStyle::Always
        } else {
            env_logger::WriteStyle::Never
        })
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

/// What a root's driver answered when asked, before anything ran.
enum DriverStatus {
    Available(String),
    Unavailable(String),
}

/// Brings each selected root's driver up once, in advance, so the run can say what it is
/// about to do instead of finding out one root at a time.
///
/// Sequential on purpose. Vulkan and GL are separate drivers and could overlap, but the
/// three GL roots share one, each wanting its own context version - and bringing several
/// contexts up at once on an embedded driver is exactly the shape of thing that hangs it.
/// One bring-up per root costs a second or two against a run measured in tens of minutes.
fn probe_drivers(selections: &[(Api, Selection<'_>)], args: &Args) -> Vec<(Api, DriverStatus)> {
    // The bring-up logs a screenful per root, and the table below says the same thing in
    // one line. The real run brings the driver up again and prints it there.
    let restore = log::max_level();
    log::set_max_level(log::LevelFilter::Warn);
    println!("Bringing up the driver for each root:");
    crate::eglu::set_step_trace(true);
    let probes = probe_inner(selections, args);
    crate::eglu::set_step_trace(false);
    log::set_max_level(restore);
    println!();
    probes
}

fn probe_inner(selections: &[(Api, Selection<'_>)], args: &Args) -> Vec<(Api, DriverStatus)> {
    selections
        .iter()
        .filter(|(_, selection)| selection.len() > 0)
        .map(|(api, _)| {
            print!("  {}:", api.root());
            flush_stdout();
            let probed = match api {
                Api::Vulkan => crate::runner::vulkan::probe(args.device_id, args.validation),
                gl_api => {
                    let api_types = gl_api.gl_api_types().expect("every non-Vulkan API is a GL one");
                    crate::runner::gles::probe(api_types, args.device_id)
                }
            };
            let status = match probed {
                Ok(description) => DriverStatus::Available(description),
                Err(e) => DriverStatus::Unavailable(e.to_string()),
            };
            println!(
                " {}",
                if matches!(status, DriverStatus::Available(_)) {
                    "ok"
                } else {
                    "failed"
                }
            );
            (*api, status)
        })
        .collect()
}

/// The table printed before the first case runs: what will run, where, and what will not.
fn print_plan(selections: &[(Api, Selection<'_>)], probes: &[(Api, DriverStatus)]) -> usize {
    let mut runnable = 0;
    let name_width = selections.iter().map(|(api, _)| api.root().len()).max().unwrap_or(0);

    println!("{:<name_width$}  {:>9}  driver", "API", "cases");
    for (api, selection) in selections {
        if selection.len() == 0 {
            continue;
        }
        let status = probes.iter().find(|(probed, _)| probed == api).map(|(_, s)| s);
        let (cases, driver) = match status {
            Some(DriverStatus::Available(description)) => {
                runnable += selection.len();
                (selection.len().to_string(), description.clone())
            }
            // A root with no driver runs nothing, so counting its cases in the total
            // would make the progress counter a number nobody can act on.
            Some(DriverStatus::Unavailable(reason)) => (
                "-".to_string(),
                color::paint(color::YELLOW, &format!("unavailable: {reason}")),
            ),
            None => (selection.len().to_string(), String::new()),
        };
        println!("{:<name_width$}  {cases:>9}  {driver}", api.root());
    }
    println!();
    flush_stdout();

    runnable
}

/// The per-case line, with how far through the whole selection the run is.
///
/// The count spans every API in one run rather than restarting per root, because "how
/// much is left" is a question about the run, not about the driver currently up.
struct CaseProgress {
    done: std::sync::atomic::AtomicUsize,
    total: usize,
    verbose: bool,
    /// Summed per-case time, for the overhead line at the end.
    case_time_us: std::sync::atomic::AtomicU64,
}

impl CaseProgress {
    fn new(total: usize, verbose: bool) -> Self {
        Self {
            done: std::sync::atomic::AtomicUsize::new(0),
            total,
            verbose,
            case_time_us: std::sync::atomic::AtomicU64::new(0),
        }
    }

    /// `-v` only: the case is about to run. Written and flushed before the case starts,
    /// so it survives the process dying halfway through.
    fn starting(&self, name: &str) {
        if !self.verbose {
            return;
        }
        let done = self.done.load(std::sync::atomic::Ordering::Relaxed);
        let width = self.total.to_string().len();
        println!(
            "{} {name}",
            color::paint(color::DIM, &format!("[{:>width$}/{}] >", done + 1, self.total))
        );
        flush_stdout();
    }

    fn print(&self, result: &CaseResult) {
        if let Some(o) = OBSERVER.get() {
            o.result(result);
        }
        let done = self.done.fetch_add(1, std::sync::atomic::Ordering::Relaxed) + 1;
        self.case_time_us
            .fetch_add(result.duration_us, std::sync::atomic::Ordering::Relaxed);
        let marker = match result.status {
            TestResult::Pass => color::paint(color::GREEN, "Pass"),
            TestResult::Fail => color::paint(color::BOLD_RED, "FAIL"),
            TestResult::Crash | TestResult::DeviceLost => color::paint(color::BOLD_RED, result.status.as_str()),
            TestResult::NotSupported => color::paint(color::YELLOW, result.status.as_str()),
            other => color::paint(color::CYAN, other.as_str()),
        };
        // The counter is right-aligned to the total's own width, so the column does not
        // shift as the run goes from case 9 to case 10.
        let width = self.total.to_string().len();
        println!(
            "{} {}: {marker} ({}) [{}]",
            color::paint(color::DIM, &format!("[{done:>width$}/{}]", self.total)),
            result.name,
            result.message,
            color::paint(color::DIM, &format_duration(result.duration_us))
        );
        flush_stdout();
    }
}

/// Stdout is block-buffered the moment it is not a terminal, which is exactly how this
/// runs in practice - `> tmp/arm-cts.log`, `| tee`, over ssh. Without this the last
/// few KiB before a hang or a hard crash are never written, so the log stops short of
/// the case that matters.
fn flush_stdout() {
    use std::io::Write;
    let _ = std::io::stdout().flush();
}

/// Whole-run wall time. Minutes once it is past one, because a four-digit second
/// count is the number nobody can read at a glance.
fn format_elapsed(elapsed: Duration) -> String {
    let secs = elapsed.as_secs_f64();
    if secs < 10.0 {
        format!("{secs:.2}s")
    } else if secs < 60.0 {
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

fn run_supervised(
    api: Api,
    names: &[String],
    args: &Args,
    writer: &mut JsonlWriter,
    progress: &CaseProgress,
) -> Result<Summary, Box<dyn std::error::Error>> {
    let options = IsolateOptions {
        api,
        batch_size: if args.isolate_per_test {
            1
        } else {
            args.batch_size.max(1)
        },
        case_timeout: Duration::from_secs(args.timeout_secs),
        device_id: args.device_id,
        validation: args.validation,
        jobs: args.jobs.max(1),
        verbose: args.verbose,
        stop_on_crash: args.stop_on_crash,
    };

    let (results, summary) = run_isolated(names, &options, |r| {
        progress.print(r);
        if args.emit_results
            && let Ok(json) = serde_json::to_string(r)
        {
            println!("{}{json}", crate::board::RESULT_PREFIX);
        }
    })?;

    for result in &results {
        writer.write_case(result)?;
    }

    Ok(summary)
}

/// A worker's `on_start`. Its stdout IS the result channel the parent parses, so the
/// line goes to stderr, which the parent inherits and the user therefore sees.
fn worker_on_start(verbose: bool) -> impl FnMut(&str) {
    move |name: &str| {
        if verbose {
            eprintln!("{} {name}", color::paint(color::DIM, ">"));
        }
    }
}

fn run_as_worker(args: &Args) -> u8 {
    // The parent sends the batch on stdin, one case name per line, and closes it.
    let mut batch = String::new();
    if let Err(e) = std::io::Read::read_to_string(&mut std::io::stdin(), &mut batch) {
        eprintln!("worker error: cannot read the case list from stdin: {e}");
        return FAILED;
    }
    let wanted: Vec<&str> = batch.lines().map(str::trim).filter(|n| !n.is_empty()).collect();

    // A batch never mixes APIs - the parent splits the selection by root before it
    // gets here - so the first name says which driver to bring up.
    let Some(api) = wanted.first().and_then(|name| Api::from_case_name(name)) else {
        eprintln!("worker error: the batch is empty or names no known API");
        return FAILED;
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
            let all = crate::all_cases();
            let selected = pick(&all, &wanted);
            crate::runner::vulkan::execute_selected(
                &selected,
                &options,
                &mut writer,
                worker_on_start(args.verbose),
                |_| {},
            )
        }
        gl_api => {
            let all = crate::gl_cases(&[gl_api]);
            let selected = pick(&all, &wanted);
            let api_types = gl_api.gl_api_types().expect("every non-Vulkan API is a GL one");
            crate::runner::gles::execute_selected(
                api_types,
                &selected,
                &options,
                &mut writer,
                worker_on_start(args.verbose),
                |_| {},
            )
        }
    };

    match result {
        // Per-case verdicts travel in the stream; the exit code only says whether the
        // worker itself survived, which is what the parent uses to detect a crash.
        Ok(_) => OK,
        Err(e) => {
            eprintln!("worker error: {e}");
            // A missing driver is an environment problem, not a crash caused by the
            // case that happened to be first. The parent needs to tell them apart.
            if is_driver_unavailable(e.as_ref()) {
                return EXIT_DRIVER_UNAVAILABLE as u8;
            }
            // Setting the API up failed for some other reason - a requested layer that
            // is not installed, say. Not this case's fault either.
            match e.downcast_ref::<crate::vk::platform::PlatformError>() {
                Some(crate::vk::platform::PlatformError::InitError(_)) => EXIT_SETUP_ERROR as u8,
                _ => FAILED,
            }
        }
    }
}

/// The batch's cases, in the order the parent asked for them.
fn pick<'a, C: ?Sized>(all: &'a [FlatCase<C>], wanted: &[&str]) -> Vec<&'a FlatCase<C>> {
    let by_name: std::collections::HashMap<&str, &FlatCase<C>> =
        all.iter().map(|c| (c.full_name.as_str(), c)).collect();
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

#[cfg(test)]
mod tests {
    use super::*;

    /// `FlatCase` is generic over what a case *is*, and `str` is a legal choice - which
    /// is what lets the selection be exercised without a Vulkan or GL case behind every
    /// name, and therefore without a driver.
    fn corpus(names: &[&str]) -> Vec<FlatCase<str>> {
        names
            .iter()
            .map(|n| FlatCase {
                full_name: (*n).to_string(),
                case: Box::<str>::from(*n),
            })
            .collect()
    }

    fn list(names: &[&str]) -> Vec<String> {
        names.iter().map(|n| (*n).to_string()).collect()
    }

    fn selected(all: &[FlatCase<str>], args: &Args, from_file: Option<&[String]>) -> Vec<String> {
        select_cases(all, Api::Gles2, args, from_file)
            .iter()
            .map(|c| c.full_name.clone())
            .collect()
    }

    const CORPUS: &[&str] = &["dEQP-GLES2.a", "dEQP-GLES2.b", "dEQP-GLES2.c"];

    #[test]
    fn a_case_list_runs_in_the_files_order() {
        let wanted = list(&["dEQP-GLES2.c", "dEQP-GLES2.a", "dEQP-GLES2.b"]);
        assert_eq!(
            selected(&corpus(CORPUS), &Args::parse_from(["hodow_cts"]), Some(&wanted)),
            wanted
        );
    }

    /// The worker's `pick` runs a name once per occurrence, so the parent has to agree
    /// or the two disagree on how many cases a batch holds.
    #[test]
    fn a_repeated_name_runs_repeatedly() {
        let wanted = list(&["dEQP-GLES2.b", "dEQP-GLES2.a", "dEQP-GLES2.b"]);
        assert_eq!(
            selected(&corpus(CORPUS), &Args::parse_from(["hodow_cts"]), Some(&wanted)),
            wanted
        );
    }

    #[test]
    fn a_name_no_case_answers_to_is_dropped() {
        let wanted = list(&["dEQP-GLES2.c", "dEQP-GLES2.gone", "dEQP-GLES2.a"]);
        assert_eq!(
            selected(&corpus(CORPUS), &Args::parse_from(["hodow_cts"]), Some(&wanted)),
            list(&["dEQP-GLES2.c", "dEQP-GLES2.a"])
        );
    }

    #[test]
    fn exclude_still_applies_to_a_case_list() {
        let args = Args::parse_from(["hodow_cts", "--exclude", "*.b"]);
        let wanted = list(&["dEQP-GLES2.c", "dEQP-GLES2.b", "dEQP-GLES2.a"]);
        assert_eq!(
            selected(&corpus(CORPUS), &args, Some(&wanted)),
            list(&["dEQP-GLES2.c", "dEQP-GLES2.a"])
        );
    }

    /// A case list spanning several roots is split per API, so each selection takes
    /// only its own - still in the file's order.
    #[test]
    fn a_case_list_yields_only_the_asked_for_api() {
        let all = corpus(&["dEQP-GLES2.a", "dEQP-GLES3.a", "dEQP-GLES2.b"]);
        let wanted = list(&["dEQP-GLES3.a", "dEQP-GLES2.b", "dEQP-GLES2.a"]);
        assert_eq!(
            selected(&all, &Args::parse_from(["hodow_cts"]), Some(&wanted)),
            list(&["dEQP-GLES2.b", "dEQP-GLES2.a"])
        );
    }

    #[test]
    fn without_a_case_list_the_corpus_order_stands() {
        let args = Args::parse_from(["hodow_cts", "--case", "dEQP-GLES2.*"]);
        assert_eq!(selected(&corpus(CORPUS), &args, None), list(CORPUS));
    }

    /// The whole point of the lazy trees: a run that names one root must not pay for the
    /// other three. `dEQP-GLES3.*` excluding `dEQP-GLES31` is the case that is easy to
    /// get wrong and expensive to notice.
    #[test]
    fn a_pattern_only_reaches_the_roots_it_could_match() {
        for (pattern, root, expected) in [
            ("dEQP-VK.compute.*", "dEQP-VK", true),
            ("dEQP-VK.compute.*", "dEQP-GLES2", false),
            ("dEQP-GLES*", "dEQP-GLES31", true),
            ("dEQP-GLES*", "dEQP-VK", false),
            ("dEQP-GLES3.*", "dEQP-GLES3", true),
            ("dEQP-GLES3.*", "dEQP-GLES31", false),
            ("dEQP-GLES31.*", "dEQP-GLES3", false),
            ("*", "dEQP-VK", true),
            ("*.functional.read_pixels.*", "dEQP-GLES2", true),
            ("nothing-like-a-case", "dEQP-VK", false),
        ] {
            assert_eq!(pattern_could_match_root(pattern, root), expected, "{pattern} vs {root}");
        }
    }

    /// An exact case name, no glob at all, still has to reach its own root.
    #[test]
    fn a_pattern_with_no_glob_reaches_its_own_root() {
        assert!(pattern_could_match_root(
            "dEQP-GLES2.functional.negative_api.buffer.bind_buffer",
            "dEQP-GLES2"
        ));
        assert!(!pattern_could_match_root(
            "dEQP-GLES2.functional.negative_api.buffer.bind_buffer",
            "dEQP-GLES3"
        ));
    }

    #[test]
    fn a_case_list_decides_the_roots_exactly() {
        let args = Args::parse_from(["hodow_cts"]);
        let wanted = roots_wanted(&args, Some(&list(&["dEQP-GLES31.a", "dEQP-GLES31.b"])));
        assert_eq!(wanted, vec![Api::Gles31]);

        // No filter at all means everything, which is what `--list` relies on.
        assert_eq!(roots_wanted(&args, None).len(), Api::ALL.len());
    }

    #[test]
    fn only_names_no_case_answers_to_are_reported_unknown() {
        let known: std::collections::HashSet<&str> = CORPUS.iter().copied().collect();
        assert!(unknown_case_names(&list(&["dEQP-GLES2.a", "dEQP-GLES2.c"]), &known).is_empty());
        assert_eq!(
            unknown_case_names(
                &list(&["dEQP-GLES2.a", "dEQP-GLES2.gone", "dEQP-GLES2.also-gone"]),
                &known
            ),
            vec!["dEQP-GLES2.gone", "dEQP-GLES2.also-gone"]
        );
    }

    /// A name excluded by `--exclude` is selected-out, not unknown; conflating the two
    /// would make the warning fire on every run that narrows a list.
    #[test]
    fn an_excluded_name_is_not_an_unknown_one() {
        let known: std::collections::HashSet<&str> = CORPUS.iter().copied().collect();
        assert!(unknown_case_names(&list(&["dEQP-GLES2.b"]), &known).is_empty());
    }
}

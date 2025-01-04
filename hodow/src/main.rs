#![allow(incomplete_features)]

use clap::Parser;
use handsome_logger::ConfigBuilder;
use hodow_cpu::{TestStatistics, request_stop};
use log::{error, info};

mod bar_logger;
#[cfg(unix)]
mod bench;
#[cfg(unix)]
mod burn;
mod cli;
mod coverage;
mod cpu;
mod cts;
mod flows_glue;
mod gpu;
#[cfg(feature = "gpu")]
mod gpu_isolate;
mod info;
mod isolate;
mod probe;
mod run_log;
mod runs;
#[cfg(feature = "serve")]
mod serve;
mod session;
mod stress;
mod vulkan;

use crate::cli::{Cli, Commands};

/// Parses a RUST_LOG value into a single global level. Accepts a bare level ("debug"), or
/// the common env_logger "target=level[,target=level...]" shorthand - since this project's
/// logger only supports one global level (not per-target filtering), the most verbose
/// level mentioned anywhere in the value wins.
fn parse_rust_log_level(s: &str) -> Option<log::LevelFilter> {
    use std::str::FromStr;
    if let Ok(l) = log::LevelFilter::from_str(s.trim()) {
        return Some(l);
    }
    s.split(',')
        .filter_map(|part| part.rsplit('=').next())
        .filter_map(|lvl| log::LevelFilter::from_str(lvl.trim()).ok())
        .max()
}

pub fn setup_ctrlc_handler() {
    ctrlc::set_handler(move || {
        info!("\n[Ctrl+C] Stopping tests gracefully...");
        request_stop();
    })
    .expect("Failed to set Ctrl+C handler");
}

pub fn print_statistics(stats: &TestStatistics) {
    info!("\n{}", "=".repeat(80));
    info!("{:^80}", "TEST STATISTICS");
    info!("{}", "=".repeat(80));

    info!(
        "{:<24} {:>10} {:>10} {:>10} {:>10} {:>10}",
        "Feature", "Run", "Unverified", "Skipped", "Errors", "Total"
    );
    info!("{}", "-".repeat(80));

    for feature in &stats.features {
        info!(
            "{:<24} {:>10} {:>10} {:>10} {:>10} {:>10}",
            feature.feature_name,
            feature.tests_run,
            feature.tests_unverified,
            feature.tests_skipped,
            feature.tests_errored,
            feature.tests_run + feature.tests_skipped
        );
    }

    info!("{}", "-".repeat(80));
    info!(
        "{:<24} {:>10} {:>10} {:>10} {:>10} {:>10}",
        "TOTAL",
        stats.total_run(),
        stats.total_unverified(),
        stats.total_skipped(),
        stats.total_errors(),
        stats.total_run() + stats.total_skipped()
    );
    info!("{}", "=".repeat(80));
    info!("Unverified and Errors are subsets of Run.");

    // A run is only as meaningful as the share of it that compared against something, the same
    // caveat `gpu`'s not-supported count and hodow_cts's skip count carry.
    if stats.total_unverified() > 0 {
        let capturable = stats.total_capturable();
        info!(
            "{} test(s) compared their result against nothing; they only prove the instruction ran.",
            stats.total_unverified()
        );
        if capturable > 0 {
            info!(
                "  {capturable} of them observed a value: run `python3 scripts/cpu/capture_expected.py` here to turn those into real checks."
            );
        }
        if stats.total_unverified() > capturable {
            info!(
                "  {} have no checkable result at all (a `()` return, or `skip_result_check`) and stay unverified everywhere.",
                stats.total_unverified() - capturable
            );
        }
    }

    if stats.total_errors() > 0 {
        error!("\nFAILED TESTS ({}):", stats.total_errors());
        for failure in stats.failures() {
            error!("  {failure}");
        }
    }

    if stats.was_cancelled {
        info!("Note: Testing was cancelled by user (Ctrl+C)");
    }
}

fn main() {
    let mut cli = Cli::parse();
    let command = resolve_command(cli.command.take());
    flows_glue::register();
    session::configure(session::Options {
        data_dir: hodow_common::DataDir::resolve(cli.data_dir.as_deref()),
        save: !cli.no_results,
        events: cli.events,
    });
    let defaulted_env = hodow_gpu::default_wayland_env();

    // Isolation workers speak a line protocol on stdout; any log output would corrupt it.
    let is_worker = matches!(&command, Commands::Cpu(a) if a.worker_start.is_some())
        || matches!(&command, Commands::Gpu(a) if a.gpu_worker.is_some())
        || matches!(&command, Commands::Burn(a) if a.worker.is_some())
        || matches!(&command, Commands::Bench(a) if a.worker)
        || matches!(&command, Commands::Probe(_));

    // The logger must always be initialized: all user-facing output (statistics,
    // mode lists, errors) is emitted through the `log` macros. `--debug` always wins;
    // otherwise honor the standard RUST_LOG env var (a bare level, or the common
    // env_logger "target=level[,target=level...]" shorthand - we only support a single
    // global level, so the most verbose requested level wins); default Info.
    let level = if cli.debug {
        log::LevelFilter::Debug
    } else if let Ok(rust_log) = std::env::var("RUST_LOG") {
        parse_rust_log_level(&rust_log).unwrap_or(log::LevelFilter::Info)
    } else {
        log::LevelFilter::Info
    };
    let format = if cfg!(feature = "miri_build") {
        handsome_logger::FormatText::LevelMessageC.get()
    } else {
        handsome_logger::FormatText::DefaultWithFileNameC.get()
    };
    // With --events stdout carries the event lines, so the terminal gets no log; the log file still does.
    let term_level = if is_worker || cli.events {
        log::LevelFilter::Off
    } else {
        level
    };
    let file_level = if is_worker { log::LevelFilter::Off } else { level };
    let build_config = |format_text, level| {
        ConfigBuilder::new()
            .set_level(level)
            .set_format_text(format_text, None)
            // Dependency crates (notably the websocket stack the `serve` subcommand pulls in)
            // log their own protocol-internal chatter (ping/pong, close frames, ...) at Debug -
            // useful for debugging *those* crates, never for debugging hodow. Only this
            // project's own targets get the full level; every third-party crate is capped at
            // Info regardless of `--debug`.
            .set_message_filtering(Some(|record: &log::Record| {
                let target = record.target();
                target.starts_with("hodow") || target.starts_with("hodow_cpu") || record.level() <= log::Level::Info
            }))
            .set_single_write(true)
            .build()
    };
    let term = bar_logger::BarAware::new(*handsome_logger::TermLogger::new(
        build_config(format, term_level),
        Default::default(),
        Default::default(),
    ));
    let log_file = if is_worker { None } else { run_log::open(&cli, &command) };
    let log_path = log_file.as_ref().map(|(_, path)| path.clone());
    let mut loggers: Vec<Box<dyn handsome_logger::SharedLogger>> = vec![term];
    if let Some((file, _)) = log_file {
        let plain = handsome_logger::FormatText::DefaultWithFileName.get();
        loggers.push(handsome_logger::WriteLogger::new(build_config(plain, file_level), file));
    }
    // The conformance runner installs a logger of its own.
    if !matches!(&command, Commands::Cts(_)) {
        handsome_logger::CombinedLogger::init(loggers).expect("Failed to initialize logger");
    }

    // `info` writes a plain report on stdout, not a log - no timestamps, no call sites, and
    // no "Running: ..." banner ahead of it.
    if !is_worker
        && !matches!(
            command,
            Commands::Info(_)
                | Commands::Coverage(_)
                | Commands::Burn(_)
                | Commands::Bench(_)
                | Commands::Runs(_)
                | Commands::Cts(_)
        )
    {
        info!("{}", info::summary_line());
        info!("Running: {:?}", command);
        if !defaulted_env.is_empty() {
            info!("Wayland environment defaulted: {}", defaulted_env.join(" "));
        }
        if let Some(path) = &log_path {
            info!("Log file: {}", path.display());
        }
    }

    #[cfg(feature = "serve")]
    if let Some(url) = &cli.submit_to {
        std::process::exit(serve::submit::submit(url));
    }

    if matches!(&command, Commands::Test(_)) {
        std::process::exit(test_all(&cli));
    }

    match &command {
        Commands::Cpu(args) => args.flows.apply(),
        Commands::Gpu(args) => args.flows.apply(),
        Commands::Vulkan(args) => args.flows.apply(),
        _ => {}
    }

    match &command {
        Commands::Test(_) => unreachable!("handled above"),
        Commands::Dev(_) => unreachable!("normalized into the tool it names"),
        Commands::Cpu(args) => cpu::process_cpu(args),
        Commands::Gpu(args) => gpu::process_gpu(args),
        Commands::Vulkan(args) => vulkan::process_vulkan(args),
        #[cfg(feature = "serve")]
        Commands::Serve(args) => serve::process_serve(args),
        Commands::Info(args) => info::process_info(args),
        Commands::Coverage(args) => coverage::process_coverage(args),
        Commands::Runs(args) => runs::process_runs(args),
        Commands::Probe(args) => probe::process_probe(args),
        Commands::Cts(args) => std::process::exit(cts::process_cts(args)),
        #[cfg(unix)]
        Commands::Burn(args) => burn::process_burn(args),
        #[cfg(unix)]
        Commands::Bench(args) => bench::process_bench(args),
        #[cfg(not(unix))]
        Commands::Burn(_) | Commands::Bench(_) => {
            eprintln!(
                "`burn` and `bench` are not available on this platform (they need Unix process groups and signals)"
            );
            std::process::exit(2);
        }
    }
}

/// `hodow test` with no kind: each check in turn, as its own run with its own saved results. 0 when all passed, 2 when
/// none of them could run here (no driver), else 1.
fn test_all(cli: &Cli) -> i32 {
    let exe = match std::env::current_exe() {
        Ok(p) => p,
        Err(e) => {
            eprintln!("cannot locate own executable: {e}");
            return 1;
        }
    };
    let mut global: Vec<String> = Vec::new();
    if cli.debug {
        global.push("-d".into());
    }
    if let Some(dir) = &cli.data_dir {
        global.extend(["--data-dir".into(), dir.display().to_string()]);
    }
    if cli.no_results {
        global.push("--no-results".into());
    }
    if cli.events {
        global.push("--events".into());
    }
    let checks: [(&str, &[&str]); 3] = [
        ("cpu", &["--isolate"]),
        ("gpu", &["--isolate", "--no-window"]),
        ("vulkan", &[]),
    ];
    let mut codes = Vec::new();
    for (name, extra) in checks {
        eprintln!("== hodow test {name}");
        let code = std::process::Command::new(&exe)
            .args(&global)
            .arg("test")
            .arg(name)
            .args(extra)
            .status()
            .map_or(1, |s| s.code().unwrap_or(1));
        codes.push(code);
    }
    if codes.iter().all(|c| *c == 2) {
        2
    } else if codes.iter().all(|c| *c == 0 || *c == 2) {
        0
    } else {
        1
    }
}

/// No command means the dashboard. `normalized` maps the grouped spellings onto the old variants.
fn resolve_command(command: Option<Commands>) -> Commands {
    if let Some(command) = command {
        return command.normalized();
    }
    #[cfg(feature = "serve")]
    {
        Commands::Serve(cli::ServeArgs {
            bind: None,
            port: None,
            local: false,
            no_open: false,
        })
    }
    #[cfg(not(feature = "serve"))]
    {
        eprintln!("No command given. Run `hodow --help` (this build has no web dashboard).");
        std::process::exit(2);
    }
}

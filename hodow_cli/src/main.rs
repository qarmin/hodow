#![allow(incomplete_features)]

use std::env;
use std::fmt::Write as _;

use clap::Parser;
use handsome_logger::ConfigBuilder;
use hodow_core::{TestStatistics, request_stop};
use log::info;

mod cli;
mod cpu;
mod gpu;
mod info;
mod isolate;
#[cfg(feature = "serve")]
mod serve;
mod stress;
mod vulkan;

use crate::cli::{Cli, Commands};

fn print_build_info() {
    let arch = env::consts::ARCH;
    let os = env::consts::OS;
    let mut info = String::new();
    let _ = write!(&mut info, "arch={}, os={}", arch, os);

    if let Ok(profile) = env::var("PROFILE") {
        let _ = write!(&mut info, ", profile={}", profile);
    }

    log::debug!("Build info: {}", info);
}

/// Parses a RUST_LOG value into a single global level. Accepts a bare level ("debug"), or
/// the common env_logger "target=level[,target=level...]" shorthand - since this project's
/// logger only supports one global level (not per-target filtering), the most verbose
/// level mentioned anywhere in the value wins.
fn parse_rust_log_level(s: &str) -> Option<log::LevelFilter> {
    use std::str::FromStr;
    if let Ok(l) = log::LevelFilter::from_str(s.trim()) {
        return Some(l);
    }
    s.split(',').filter_map(|part| part.rsplit('=').next()).filter_map(|lvl| log::LevelFilter::from_str(lvl.trim()).ok()).max()
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

    info!("{:<30} {:>10} {:>10} {:>10} {:>10}", "Feature", "Run", "Skipped", "Errors", "Total");
    info!("{}", "-".repeat(80));

    for feature in &stats.features {
        let total = feature.tests_run + feature.tests_skipped + feature.tests_errored;
        info!(
            "{:<30} {:>10} {:>10} {:>10} {:>10}",
            feature.feature_name, feature.tests_run, feature.tests_skipped, feature.tests_errored, total
        );
    }

    info!("{}", "-".repeat(80));
    let grand_total = stats.total_run() + stats.total_skipped() + stats.total_errors();
    info!(
        "{:<30} {:>10} {:>10} {:>10} {:>10}",
        "TOTAL",
        stats.total_run(),
        stats.total_skipped(),
        stats.total_errors(),
        grand_total
    );
    info!("{}", "=".repeat(80));

    if stats.was_cancelled {
        info!("Note: Testing was cancelled by user (Ctrl+C)");
    }
}

fn main() {
    let cli = Cli::parse();

    // Isolation workers speak a line protocol on stdout; any log output would corrupt it.
    let is_worker = matches!(&cli.command, Commands::Cpu(a) if a.worker_start.is_some());

    // The logger must always be initialized: all user-facing output (statistics,
    // mode lists, errors) is emitted through the `log` macros. `--debug` always wins;
    // otherwise honor the standard RUST_LOG env var (a bare level, or the common
    // env_logger "target=level[,target=level...]" shorthand - we only support a single
    // global level, so the most verbose requested level wins); default Info.
    let level = if is_worker {
        log::LevelFilter::Off
    } else if cli.debug {
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
    let config = ConfigBuilder::new()
        .set_level(level)
        .set_format_text(format, None)
        // Dependency crates (notably the websocket stack the `serve` subcommand pulls in)
        // log their own protocol-internal chatter (ping/pong, close frames, ...) at Debug -
        // useful for debugging *those* crates, never for debugging hodow. Only this
        // project's own targets get the full level; every third-party crate is capped at
        // Info regardless of `--debug`.
        .set_message_filtering(Some(|record: &log::Record| {
            let target = record.target();
            target.starts_with("hodow_cli") || target.starts_with("hodow_core") || record.level() <= log::Level::Info
        }))
        .build();
    handsome_logger::TermLogger::init(config, Default::default(), Default::default()).expect("Failed to initialize logger");

    print_build_info();
    // `info` writes a plain report on stdout, not a log - no timestamps, no call sites, and
    // no "Running: ..." banner ahead of it.
    if !is_worker && !matches!(cli.command, Commands::Info(_)) {
        info!("Running: {:?}", cli.command);
    }

    match &cli.command {
        Commands::Cpu(args) => cpu::process_cpu(args),
        Commands::Gpu(args) => gpu::process_gpu(args),
        Commands::Vulkan(args) => vulkan::process_vulkan(args),
        #[cfg(feature = "serve")]
        Commands::Serve(args) => serve::process_serve(args),
        Commands::Info(args) => info::process_info(args),
    }
}

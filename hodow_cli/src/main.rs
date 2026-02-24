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

use crate::cli::{Cli, Commands};

fn print_build_info() {
    let arch = env::consts::ARCH;
    let os = env::consts::OS;
    let mut info = String::new();
    let _ = write!(&mut info, "arch={}, os={}", arch, os);

    if let Ok(profile) = env::var("PROFILE") {
        let _ = write!(&mut info, ", profile={}", profile);
    }

    log::info!("Build info: {}", info);
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

    if cli.debug {
        if !cfg!(feature = "miri_build") {
            let config = ConfigBuilder::new().set_format_text(handsome_logger::FormatText::DefaultWithFileNameC.get(), None).build();
            handsome_logger::TermLogger::init(config, Default::default(), Default::default()).expect("Failed to initialize logger");
        } else {
            let config = ConfigBuilder::new().set_format_text(handsome_logger::FormatText::LevelMessageC.get(), None).build();
            handsome_logger::TermLogger::init(config, Default::default(), Default::default()).expect("Failed to initialize logger");
        }
    }

    print_build_info();

    match &cli.command {
        Commands::Cpu(args) => cpu::process_cpu(args),
        Commands::Gpu(args) => gpu::process_gpu(args),
    }
}

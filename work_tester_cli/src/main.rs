#![allow(incomplete_features)]

use std::cmp::Reverse;
use std::env;
use std::fmt::Write as _;

use clap::Parser;
use handsome_logger::ConfigBuilder;
use indicatif::{MultiProgress, ProgressBar, ProgressStyle};
use work_tester_core::{available_modes, list_all_functions, request_stop, set_iterations, set_skip_tests, test_all_extensions, TestProgress, TestStatistics};

mod cli;

use crate::cli::Args;

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

fn setup_ctrlc_handler() {
    ctrlc::set_handler(move || {
        eprintln!("\n[Ctrl+C] Stopping tests gracefully...");
        request_stop();
    })
    .expect("Failed to set Ctrl+C handler");
}

fn create_progress_bars() -> (MultiProgress, ProgressBar, ProgressBar, ProgressBar) {
    let multi = MultiProgress::new();

    let overall_bar = multi.add(ProgressBar::new(0));
    overall_bar.set_style(
        ProgressStyle::default_bar()
            .template("{prefix:20} [{bar:40.cyan/blue}] {pos}/{len} features")
            .expect("Invalid template")
            .progress_chars("=>-"),
    );
    overall_bar.set_prefix("Overall progress");

    let feature_bar = multi.add(ProgressBar::new(0));
    feature_bar.set_style(
        ProgressStyle::default_bar()
            .template("{prefix:20} [{bar:40.green/blue}] {pos}/{len} tests")
            .expect("Invalid template")
            .progress_chars("=>-"),
    );
    feature_bar.set_prefix("Current feature");

    let test_bar = multi.add(ProgressBar::new(0));
    test_bar.set_style(ProgressStyle::default_bar().template("{prefix:20} {msg}").expect("Invalid template"));
    test_bar.set_prefix("Current test");

    (multi, overall_bar, feature_bar, test_bar)
}

fn print_statistics(stats: &TestStatistics) {
    println!("\n{}", "=".repeat(80));
    println!("{:^80}", "TEST STATISTICS");
    println!("{}", "=".repeat(80));

    println!("{:<30} {:>10} {:>10} {:>10} {:>10}", "Feature", "Run", "Skipped", "Errors", "Total");
    println!("{}", "-".repeat(80));

    for feature in &stats.features {
        let total = feature.tests_run + feature.tests_skipped + feature.tests_errored;
        println!(
            "{:<30} {:>10} {:>10} {:>10} {:>10}",
            feature.feature_name, feature.tests_run, feature.tests_skipped, feature.tests_errored, total
        );
    }

    println!("{}", "-".repeat(80));
    let grand_total = stats.total_run() + stats.total_skipped() + stats.total_errors();
    println!(
        "{:<30} {:>10} {:>10} {:>10} {:>10}",
        "TOTAL",
        stats.total_run(),
        stats.total_skipped(),
        stats.total_errors(),
        grand_total
    );
    println!("{}", "=".repeat(80));

    if stats.was_cancelled {
        println!("Note: Testing was cancelled by user (Ctrl+C)");
    }
}

fn main() {
    let args = Args::parse();

    // Initialize logger only if --debug flag is set
    if args.debug {
        if !cfg!(feature = "miri_build") {
            let config = ConfigBuilder::new().set_format_text(handsome_logger::FormatText::DefaultWithFileNameC.get(), None).build();
            handsome_logger::TermLogger::init(config, Default::default(), Default::default()).expect("Failed to initialize logger");
        } else {
            let config = ConfigBuilder::new().set_format_text(handsome_logger::FormatText::LevelMessageC.get(), None).build();
            handsome_logger::TermLogger::init(config, Default::default(), Default::default()).expect("Failed to initialize logger");
        }
    }

    if let Some(nv) = args.iterations {
        set_iterations(nv);
    }

    if !args.skip.is_empty() {
        set_skip_tests(args.skip);
    }

    print_build_info();

    if args.list_modes {
        let modes = available_modes();
        println!("Available modes: {:?}", modes);
        println!("Clean exit");
        return;
    }

    if args.list_functions {
        let functions = list_all_functions();
        println!("Available test functions ({} total):", functions.len());
        for func in functions {
            println!("  {}", func);
        }
        println!("Clean exit");
        return;
    }

    // Setup Ctrl+C handler
    setup_ctrlc_handler();

    // Create progress bars
    let (multi, overall_bar, feature_bar, test_bar) = create_progress_bars();

    // Clone progress bars for the closure
    let overall_bar_clone = overall_bar.clone();
    let feature_bar_clone = feature_bar.clone();
    let test_bar_clone = test_bar.clone();

    // Create progress callback
    let progress_callback = move |progress: &TestProgress| {
        // Update overall bar
        if overall_bar_clone.length() != Some(progress.total_features as u64) {
            overall_bar_clone.set_length(progress.total_features as u64);
        }
        overall_bar_clone.set_position(progress.completed_features as u64);

        // Update feature bar
        if feature_bar_clone.length() != Some(progress.total_tests_in_feature as u64) {
            feature_bar_clone.set_length(progress.total_tests_in_feature as u64);
            feature_bar_clone.set_prefix(format!("{:20}", progress.current_feature));
        }
        feature_bar_clone.set_position(progress.completed_tests_in_feature as u64);

        // Update test bar
        if progress.total_fuzzing_iterations > 0 {
            test_bar_clone.set_message(format!(
                "{} (fuzzing {}/{})",
                progress.current_test, progress.fuzzing_iteration, progress.total_fuzzing_iterations
            ));
        } else {
            test_bar_clone.set_message(progress.current_test.to_string());
        }
    };

    // Run tests
    match test_all_extensions(Some(&progress_callback)) {
        Ok(mut stats) => {
            // Finish progress bars
            overall_bar.finish();
            feature_bar.finish();
            test_bar.finish();
            multi.clear().ok();

            stats.features.sort_by_key(|f| Reverse(f.tests_run));

            // Print statistics
            print_statistics(&stats);

            // Exit with error code if there were errors
            if stats.total_errors() > 0 {
                eprintln!("\nTests completed with {} error(s)", stats.total_errors());
                std::process::exit(1);
            } else {
                println!("\nClean exit");
            }
        }
        Err(e) => {
            // Finish progress bars on error
            overall_bar.finish();
            feature_bar.finish();
            test_bar.finish();
            multi.clear().ok();

            eprintln!("Error: Running tests failed: {}", e);
            std::process::exit(1);
        }
    }
}

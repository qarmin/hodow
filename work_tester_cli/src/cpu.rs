use std::cmp::Reverse;

use indicatif::{MultiProgress, ProgressBar, ProgressStyle};
use log::{error, info};
use work_tester_core::{available_modes, list_all_functions, set_iterations, set_skip_tests, test_all_extensions, TestProgress};

use crate::cli::CpuArgs;
use crate::setup_ctrlc_handler;

pub fn process_cpu(args: &CpuArgs) {
    if let Some(nv) = args.iterations {
        set_iterations(nv);
    }

    if !args.skip.is_empty() {
        set_skip_tests(args.skip.clone());
    }

    if args.list_modes {
        let modes = available_modes();
        info!("Available modes: {:?}", modes);
        info!("Clean exit");
        return;
    }

    if args.list_functions {
        let functions = list_all_functions();
        info!("Available test functions ({} total):", functions.len());
        for func in functions {
            info!("  {}", func);
        }
        info!("Clean exit");
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
        if overall_bar_clone.length() != Some(progress.total_features as u64) {
            overall_bar_clone.set_length(progress.total_features as u64);
        }
        overall_bar_clone.set_position(progress.completed_features as u64);

        if feature_bar_clone.length() != Some(progress.total_tests_in_feature as u64) {
            feature_bar_clone.set_length(progress.total_tests_in_feature as u64);
            feature_bar_clone.set_prefix(format!("{:20}", progress.current_feature));
        }
        feature_bar_clone.set_position(progress.completed_tests_in_feature as u64);

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
            overall_bar.finish();
            feature_bar.finish();
            test_bar.finish();
            multi.clear().ok();

            stats.features.sort_by_key(|f| Reverse(f.tests_run));
            crate::print_statistics(&stats);

            if stats.total_errors() > 0 {
                error!("\nTests completed with {} error(s)", stats.total_errors());
                std::process::exit(1);
            } else {
                info!("\nClean exit");
            }
        }
        Err(e) => {
            overall_bar.finish();
            feature_bar.finish();
            test_bar.finish();
            multi.clear().ok();

            error!("Error: Running tests failed: {}", e);
            std::process::exit(1);
        }
    }
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


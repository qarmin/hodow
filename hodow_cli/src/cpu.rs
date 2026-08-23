use std::cmp::Reverse;

use hodow_core::{TestProgress, available_modes, list_all_functions, set_iterations, set_only_features, set_only_tests, set_skip_tests, test_all_extensions};
use indicatif::{MultiProgress, ProgressBar, ProgressStyle};
use log::{error, info};

use crate::cli::CpuArgs;
#[cfg(not(feature = "miri_build"))]
use crate::setup_ctrlc_handler;

pub fn process_cpu(args: &CpuArgs) {
    #[cfg(feature = "serve")]
    if let Some(ref url) = args.submit_to {
        return submit_to_server(args, url);
    }

    if let Some(nv) = args.iterations {
        set_iterations(nv);
    }

    // Filters must be set before any run mode below (including the isolation worker/parent
    // and stress paths) so `-t`/`-e`/`-s` apply uniformly regardless of how the suite runs.
    if let Some(ref only) = args.test_function {
        set_only_tests(only.clone());
    }

    if !args.feature.is_empty() {
        set_only_features(args.feature.clone());
    }

    if !args.skip.is_empty() {
        set_skip_tests(args.skip.clone());
    }

    // Isolation worker: run tests in a child process speaking the line protocol on stdout.
    if let Some(start) = args.worker_start {
        crate::isolate::run_worker(start);
        return;
    }

    // Isolation parent: orchestrate worker subprocesses with per-test timeouts.
    if args.isolate {
        crate::isolate::run_isolated(args);
        return;
    }

    // Stress mode: run the suite on every core in parallel and compare across cores.
    if args.stress {
        crate::stress::run_stress(args);
        return;
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

    // Setup Ctrl+C handler (skip in Miri as it doesn't support semaphores)
    #[cfg(not(feature = "miri_build"))]
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
                if cfg!(feature = "miri_build") {
                    error!(
                        "\nMiri build detected - skipping error exit to allow test completion. Total errors: {}",
                        stats.total_errors()
                    );
                    return;
                }
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

/// POSTs this invocation's args as a job to a running `hodow_cli serve` instead of running
/// them locally. `-i`/`--isolate`/`--stress`/`--worker-start`/list-* flags don't apply here -
/// the server always runs queued jobs through its own isolate-based executor.
#[cfg(feature = "serve")]
fn submit_to_server(args: &CpuArgs, base_url: &str) {
    let spec = serde_json::json!({
        "iterations": args.iterations,
        "test_function": args.test_function,
        "feature": args.feature,
        "skip": args.skip,
        "isolate_timeout_ms": args.isolate_timeout_ms,
    });
    let body = serde_json::json!({ "kind": "cpu", "spec": spec });
    let url = format!("{}/api/jobs", base_url.trim_end_matches('/'));
    match ureq::post(&url).send_json(&body) {
        Ok(mut resp) => match resp.body_mut().read_to_string() {
            Ok(text) => info!("Submitted job to {url}: {text}"),
            Err(e) => error!("Job submitted but failed to read response: {e}"),
        },
        Err(e) => {
            error!("Failed to submit job to {url}: {e}");
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

use std::cmp::Reverse;

use hodow_common::Summary;
use hodow_cpu::{
    TestProgress, available_modes, list_all_functions, set_iterations, set_only_features, set_only_tests,
    set_skip_tests, test_all_extensions,
};
use indicatif::{MultiProgress, ProgressBar, ProgressStyle};
use log::{error, info};

use crate::cli::CpuArgs;
#[cfg(not(feature = "miri_build"))]
use crate::setup_ctrlc_handler;

pub fn process_cpu(args: &CpuArgs) {
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
        info!("Available modes: {modes:?}");
        info!("Clean exit");
        return;
    }

    if args.list_functions {
        let functions = list_all_functions();
        info!("Available test functions ({} total):", functions.len());
        for func in functions {
            info!("  {func}");
        }
        info!("Clean exit");
        return;
    }

    // Setup Ctrl+C handler (skip in Miri as it doesn't support semaphores)
    #[cfg(not(feature = "miri_build"))]
    setup_ctrlc_handler();

    let session = crate::session::Session::start(
        "cpu",
        "CPU instruction tests (not isolated: per-extension counts, use --isolate for one result per test)",
        &std::env::args().skip(1).collect::<Vec<_>>(),
    );
    let stepper = std::sync::Arc::new(std::sync::Mutex::new(Stepper::new(session.reporter().clone())));
    let stepper_for_callback = stepper.clone();

    // Create progress bars
    let (multi, overall_bar, feature_bar, test_bar) = create_progress_bars();
    crate::bar_logger::set_active(Some(multi.clone()));

    // Clone progress bars for the closure
    let overall_bar_clone = overall_bar.clone();
    let feature_bar_clone = feature_bar.clone();
    let test_bar_clone = test_bar.clone();

    // Create progress callback
    let progress_callback = move |progress: &TestProgress| {
        stepper_for_callback
            .lock()
            .unwrap_or_else(|e| e.into_inner())
            .on_progress(progress);
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
            crate::bar_logger::set_active(None);
            let _ = multi.clear();

            stats.features.sort_by_key(|f| Reverse(f.tests_run));
            crate::print_statistics(&stats);
            stepper.lock().unwrap_or_else(|e| e.into_inner()).close();

            let flows = run_flows(session.reporter());
            let flow_failures = flows.failed as usize;
            report_failures(session.reporter(), &stats);
            let summary = summary_of(&stats, &flows);
            session.finish_with(summary.status(), summary);
            if flow_failures > 0 {
                error!("\n{flow_failures} processing flow(s) failed");
                std::process::exit(1);
            }

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
            }
            info!("\nClean exit");
        }
        Err(e) => {
            overall_bar.finish();
            feature_bar.finish();
            test_bar.finish();
            crate::bar_logger::set_active(None);
            let _ = multi.clear();

            stepper.lock().unwrap_or_else(|e| e.into_inner()).close();
            session
                .reporter()
                .log(hodow_common::Level::Error, format!("running tests failed: {e}"));
            session.finish_with(hodow_common::RunStatus::Failed, Summary::default());
            error!("Error: Running tests failed: {e}");
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
    test_bar.set_style(
        ProgressStyle::default_bar()
            .template("{prefix:20} {msg}")
            .expect("Invalid template"),
    );
    test_bar.set_prefix("Current test");

    (multi, overall_bar, feature_bar, test_bar)
}

#[derive(Default)]
struct FlowTally {
    passed: u64,
    skipped: u64,
    failed: u64,
}

/// The processing flows, which are not part of the generated per-extension suite.
fn run_flows(reporter: &hodow_common::Reporter) -> FlowTally {
    use hodow_common::{Finding, Verdict};
    let mut tally = FlowTally::default();
    for (name, feature, test) in hodow_cpu::all_tests() {
        if feature != "flows" || hodow_cpu::should_skip_test_or_feature(name, feature) {
            continue;
        }
        match test() {
            Ok(hodow_cpu::Verdict::Skipped(why)) => {
                info!("flow {name}: skipped ({why})");
                reporter.finding(Finding::new(name, Verdict::Skipped).detail(why));
                tally.skipped += 1;
            }
            Ok(_) => {
                info!("flow {name}: passed");
                reporter.finding(Finding::new(name, Verdict::Passed));
                tally.passed += 1;
            }
            Err(e) => {
                error!("flow {name}: FAILED: {e}");
                reporter.finding(Finding::new(name, Verdict::Failed).detail(e));
                tally.failed += 1;
            }
        }
    }
    tally
}

fn report_failures(reporter: &hodow_common::Reporter, stats: &hodow_cpu::TestStatistics) {
    for line in stats.failures() {
        let (name, detail) = line.split_once(": ").unwrap_or((line, ""));
        let name = name.split('(').next().unwrap_or(name);
        let mut finding = hodow_common::Finding::new(name, hodow_common::Verdict::Failed);
        if !detail.is_empty() {
            finding = finding.detail(detail);
        }
        reporter.finding(finding);
    }
}

/// Counts only: a plain run keeps no per-test result, so passes are what is left after the rest is taken out.
fn summary_of(stats: &hodow_cpu::TestStatistics, flows: &FlowTally) -> Summary {
    let (run, skipped) = (stats.total_run() as u64, stats.total_skipped() as u64);
    let (errored, unverified) = (stats.total_errors() as u64, stats.total_unverified() as u64);
    Summary {
        total: run + skipped + flows.passed + flows.skipped + flows.failed,
        passed: run.saturating_sub(errored + unverified) + flows.passed,
        unverified,
        skipped: skipped + flows.skipped,
        failed: errored + flows.failed,
        ..Summary::default()
    }
}

/// Turns the suite's progress callbacks into steps: one for the extensions, one for the extension being run.
struct Stepper {
    reporter: hodow_common::Reporter,
    overall: Option<hodow_common::Step>,
    family: Option<(&'static str, hodow_common::Step)>,
}

impl Stepper {
    fn new(reporter: hodow_common::Reporter) -> Self {
        Self {
            reporter,
            overall: None,
            family: None,
        }
    }

    fn on_progress(&mut self, p: &TestProgress) {
        let reporter = self.reporter.clone();
        let overall = self.overall.get_or_insert_with(|| {
            reporter
                .step("CPU extensions")
                .unit("extensions")
                .total(p.total_features as u64)
                .start()
        });
        if self
            .family
            .as_ref()
            .is_none_or(|(feature, _)| *feature != p.current_feature)
        {
            if let Some((_, old)) = self.family.take() {
                old.finish(hodow_common::StepOutcome::Done);
            }
            let step = reporter
                .step(p.current_feature)
                .parent(overall)
                .unit("tests")
                .total(p.total_tests_in_feature as u64)
                .start();
            self.family = Some((p.current_feature, step));
        }
        let current = if p.total_fuzzing_iterations > 0 {
            format!(
                "{} (fuzzing {}/{})",
                p.current_test, p.fuzzing_iteration, p.total_fuzzing_iterations
            )
        } else {
            p.current_test.to_string()
        };
        overall.progress(p.completed_features as u64, Some(p.current_feature));
        if let Some((_, step)) = self.family.as_mut() {
            step.progress(p.completed_tests_in_feature as u64, Some(&current));
        }
    }

    fn close(&mut self) {
        if let Some((_, step)) = self.family.take() {
            step.finish(hodow_common::StepOutcome::Done);
        }
        if let Some(step) = self.overall.take() {
            step.finish(hodow_common::StepOutcome::Done);
        }
    }
}

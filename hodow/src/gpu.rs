use log::{error, info};

use crate::cli::GpuArgs;

const QUICK_TIME_LIMIT_MS: u64 = 50;

pub fn process_gpu(args: &GpuArgs) {
    info!("GPU mode requested. Running OpenGL tests...");

    #[cfg(feature = "gpu")]
    {
        use hodow_gpu::{DisplayApiHint, GlApiHint};

        let display_api = args
            .display_api
            .as_deref()
            .map(|s| {
                s.parse::<DisplayApiHint>().unwrap_or_else(|e| {
                    log::warn!("Invalid --display-api value: {}. Falling back to EGL.", e);
                    DisplayApiHint::Egl
                })
            })
            .unwrap_or_default();

        let gl_api = args
            .gl_api
            .as_deref()
            .map(|s| {
                s.parse::<GlApiHint>().unwrap_or_else(|e| {
                    log::warn!("Invalid --gl-api value: {}. Falling back to auto.", e);
                    GlApiHint::Auto
                })
            })
            .unwrap_or_default();

        hodow_gpu::set_gl_quick(args.quick);
        let opts = hodow_gpu::GpuOptions {
            no_window: args.no_window,
            time_limit_ms: args.time_limit_ms.or(args.quick.then_some(QUICK_TIME_LIMIT_MS)),
            frame_limit: args.frame_limit,
            display_api,
            gl_api,
            force_software: args.force_software,
        };

        if let Some(index) = args.gpu_worker {
            return run_gpu_worker(&opts, index);
        }
        if args.isolate {
            return crate::gpu_isolate::run(args, hodow_gpu::gl_test_count());
        }
        if args.memtest {
            let size_mb = args.memtest_mb.unwrap_or(64);
            info!("Running GPU memory test ({} MB buffer)", size_mb);
            let session = crate::session::Session::start(
                "gpu-memtest",
                "GPU memory test",
                &std::env::args().skip(1).collect::<Vec<_>>(),
            );
            let result = hodow_gpu::run_memtest(&opts, size_mb);
            record_memtest(&session, &result);
            match result {
                Ok(report) => {
                    info!(
                        "Buffer: {} MB, compute pass: {}",
                        report.buffer_bytes / (1024 * 1024),
                        report.compute_used
                    );
                    for p in &report.patterns {
                        let errs = p.roundtrip_errors + p.compute_errors;
                        if errs == 0 {
                            info!("  [OK]    {:<14} no errors", p.name);
                        } else {
                            error!(
                                "  [ERROR] {:<14} {} errors (roundtrip {}, compute {}); first {:?}",
                                p.name, errs, p.roundtrip_errors, p.compute_errors, p.first_error
                            );
                        }
                    }
                    let total = report.total_errors();
                    if total > 0 {
                        error!("GPU memory test FAILED: {} bit errors", total);
                        std::process::exit(1);
                    }
                    info!(
                        "GPU memory test passed: no bit errors across {} patterns",
                        report.patterns.len()
                    );
                    info!("Clean exit");
                }
                Err(e) => {
                    error!("GPU memory test could not run: {}", e);
                    std::process::exit(1);
                }
            }
            return;
        }

        if opts.no_window {
            info!("Running in headless mode (no window)");
        }
        info!("Display backend: {:?}", opts.display_api);
        info!("GL API hint:     {:?}", opts.gl_api);
        if opts.force_software {
            info!("Force software rendering: enabled");
        }
        if let Some(ms) = opts.time_limit_ms {
            info!("Per-test time limit: {}ms", ms);
        }
        if let Some(fl) = opts.frame_limit {
            info!("Per-test frame limit: {} frames", fl);
        }

        let session = crate::session::Session::start(
            "gl",
            "OpenGL tests (not isolated: counts only, use --isolate for one result per test)",
            &std::env::args().skip(1).collect::<Vec<_>>(),
        );
        let step = session.reporter().step("OpenGL tests").unit("tests").start();
        let result = hodow_gpu::test_all_opengl(&opts);
        step.finish(match &result {
            Ok((_, _, 0)) => hodow_common::StepOutcome::Done,
            _ => hodow_common::StepOutcome::Failed,
        });
        match &result {
            Ok((run, skipped, errors)) => {
                let (run, skipped, errors) = (*run as u64, *skipped as u64, *errors as u64);
                let summary = hodow_common::Summary {
                    total: run,
                    passed: run.saturating_sub(skipped + errors),
                    not_supported: skipped,
                    failed: errors,
                    ..Default::default()
                };
                session.finish_with(summary.status(), summary);
            }
            Err(e) => {
                session
                    .reporter()
                    .log(hodow_common::Level::Error, format!("running GL tests failed: {e}"));
                session.finish_with(hodow_common::RunStatus::Failed, hodow_common::Summary::default());
            }
        }
        match result {
            Ok((run, skipped, errors)) => {
                info!(
                    "GL tests finished. Run: {}, Not supported here: {}, Errors: {}",
                    run, skipped, errors
                );
                if errors > 0 {
                    error!("GL tests completed with {} error(s)", errors);
                    std::process::exit(1);
                } else {
                    // A clean run over mostly-skipped tests proves very little, so never say
                    // "all tests passed" without the count that qualifies it.
                    info!(
                        "Clean exit - {} passed, {} not supported by this driver",
                        run - skipped,
                        skipped
                    );
                }
            }
            Err(e) => {
                error!("Running GL tests failed: {}", e);
                std::process::exit(1);
            }
        }
    }

    #[cfg(not(feature = "gpu"))]
    {
        let _ = args; // suppress unused warning
        error!(
            "GPU requested but the binary was compiled without the `gpu` feature. \
             Re-compile with `--features gpu` to enable OpenGL tests."
        );
        std::process::exit(1);
    }
}

/// The child half of `gpu --isolate`: run one test and print a single machine-readable line.
///
/// Logging is off in the child (see main.rs), so this line is the only thing on stdout and the
/// parent does not have to parse around driver chatter.
#[cfg(feature = "gpu")]
fn run_gpu_worker(opts: &hodow_gpu::GpuOptions, index: usize) {
    match hodow_gpu::run_single_gl_test(opts, index) {
        Ok((outcome, message)) => println!("RESULT {outcome} {message}"),
        Err(e) => println!("RESULT failed {e}"),
    }
}

#[cfg(feature = "gpu")]
fn record_memtest(session: &crate::session::Session, result: &Result<hodow_gpu::MemtestReport, String>) {
    use hodow_common::{Finding, Level, RunStatus, StepOutcome, Summary, Verdict};
    match result {
        Ok(report) => {
            let step = session
                .reporter()
                .step("memory patterns")
                .unit("patterns")
                .total(report.patterns.len() as u64)
                .start();
            for p in &report.patterns {
                let errors = p.roundtrip_errors + p.compute_errors;
                let finding = if errors == 0 {
                    Finding::new(format!("memtest {}", p.name), Verdict::Passed)
                } else {
                    Finding::new(format!("memtest {}", p.name), Verdict::Failed).detail(format!(
                        "{errors} errors (roundtrip {}, compute {}); first {:?}",
                        p.roundtrip_errors, p.compute_errors, p.first_error
                    ))
                };
                session.reporter().finding(finding);
            }
            step.finish(StepOutcome::Done);
            session.finish(None);
        }
        Err(e) => {
            session
                .reporter()
                .log(Level::Error, format!("GPU memory test could not run: {e}"));
            session.finish_with(RunStatus::Failed, Summary::default());
        }
    }
}

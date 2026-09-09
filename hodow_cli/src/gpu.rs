use log::{error, info};

use crate::cli::GpuArgs;

pub fn process_gpu(args: &GpuArgs) {
    #[cfg(feature = "serve")]
    if let Some(ref url) = args.submit_to {
        return submit_to_server(args, url);
    }

    info!("GPU mode requested. Running OpenGL tests...");

    #[cfg(feature = "gpu")]
    {
        use hodow_core::{DisplayApiHint, GlApiHint};

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

        let opts = hodow_core::GpuOptions {
            no_window: args.no_window,
            time_limit_ms: args.time_limit_ms,
            frame_limit: args.frame_limit,
            display_api,
            gl_api,
            force_software: args.force_software,
        };

        if let Some(index) = args.gpu_worker {
            return run_gpu_worker(&opts, index);
        }
        if args.isolate {
            return crate::gpu_isolate::run(args, hodow_core::gl_test_count());
        }
        if args.memtest {
            let size_mb = args.memtest_mb.unwrap_or(64);
            info!("Running GPU memory test ({} MB buffer)", size_mb);
            match hodow_core::run_memtest(&opts, size_mb) {
                Ok(report) => {
                    info!("Buffer: {} MB, compute pass: {}", report.buffer_bytes / (1024 * 1024), report.compute_used);
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
                    info!("GPU memory test passed: no bit errors across {} patterns", report.patterns.len());
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

        match hodow_core::test_all_opengl(&opts) {
            Ok((run, skipped, errors)) => {
                info!("GL tests finished. Run: {}, Not supported here: {}, Errors: {}", run, skipped, errors);
                if errors > 0 {
                    error!("GL tests completed with {} error(s)", errors);
                    std::process::exit(1);
                } else {
                    // A clean run over mostly-skipped tests proves very little, so never say
                    // "all tests passed" without the count that qualifies it.
                    info!("Clean exit - {} passed, {} not supported by this driver", run - skipped, skipped);
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

/// POSTs this invocation's args as a job to a running `hodow_cli serve` instead of running
/// them locally. The server runs Gpu jobs as a whole-process subprocess (see
/// `serve::executor::run_subprocess_job`), so it never runs GL calls in its own process.
#[cfg(feature = "serve")]
fn submit_to_server(args: &GpuArgs, base_url: &str) {
    let spec = serde_json::json!({
        "no_window": args.no_window,
        "time_limit_ms": args.time_limit_ms,
        "frame_limit": args.frame_limit,
        "display_api": args.display_api,
        "gl_api": args.gl_api,
        "force_software": args.force_software,
        "memtest": args.memtest,
        "memtest_mb": args.memtest_mb,
    });
    let body = serde_json::json!({ "kind": "gpu", "spec": spec });
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

/// The child half of `gpu --isolate`: run one test and print a single machine-readable line.
///
/// Logging is off in the child (see main.rs), so this line is the only thing on stdout and the
/// parent does not have to parse around driver chatter.
#[cfg(feature = "gpu")]
fn run_gpu_worker(opts: &hodow_core::GpuOptions, index: usize) {
    match hodow_core::run_single_gl_test(opts, index) {
        Ok((outcome, message)) => println!("RESULT {outcome} {message}"),
        Err(e) => println!("RESULT failed {e}"),
    }
}

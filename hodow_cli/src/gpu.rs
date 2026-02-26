use log::{error, info, warn};

use crate::cli::GpuArgs;

pub fn process_gpu(args: &GpuArgs) {
    info!("GPU mode requested. Running OpenGL tests...");

    #[cfg(feature = "gpu")]
    {
        use hodow_core::{DisplayApiHint, GlApiHint};

        let display_api = args
            .display_api
            .as_deref()
            .map(|s| {
                s.parse::<DisplayApiHint>().unwrap_or_else(|e| {
                    warn!("Invalid --display-api value: {}. Falling back to EGL.", e);
                    DisplayApiHint::Egl
                })
            })
            .unwrap_or_default();

        let gl_api = args
            .gl_api
            .as_deref()
            .map(|s| {
                s.parse::<GlApiHint>().unwrap_or_else(|e| {
                    warn!("Invalid --gl-api value: {}. Falling back to auto.", e);
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
                info!("GL tests finished. Run: {}, Skipped: {}, Errors: {}", run, skipped, errors);
                if errors > 0 {
                    error!("GL tests completed with {} error(s)", errors);
                    std::process::exit(1);
                } else {
                    info!("Clean exit - all {} tests passed", run);
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

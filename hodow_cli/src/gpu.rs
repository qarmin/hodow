use log::{error, info};

use crate::cli::GpuArgs;

pub fn process_gpu(args: &GpuArgs) {
    info!("GPU mode requested. Running OpenGL tests...");

    #[cfg(feature = "gpu")]
    {
        let opts = hodow_core::GpuOptions {
            no_window: args.no_window,
            time_limit_ms: args.time_limit_ms,
            frame_limit: args.frame_limit,
        };

        if opts.no_window {
            info!("Running in headless mode (no window)");
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

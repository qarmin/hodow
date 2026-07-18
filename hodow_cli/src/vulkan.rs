use crate::cli::VulkanArgs;

pub fn process_vulkan(_args: &VulkanArgs) {
    #[cfg(feature = "vulkan")]
    {
        use log::{error, info};

        info!("Vulkan compute validation");
        let report = hodow_core::vulkan::run_compute_validation();

        if let Some(err) = &report.init_error {
            error!("Vulkan initialization error: {}", err);
            std::process::exit(1);
        }

        if let Some(reason) = &report.unavailable {
            info!("Vulkan not available on this system: {}", reason);
            info!("Clean exit (nothing to test)");
            return;
        }

        if report.devices.is_empty() {
            info!("No Vulkan devices found (loader present but no physical devices).");
            info!("Clean exit");
            return;
        }

        let mut errors = 0;
        for dev in &report.devices {
            match &dev.outcome {
                Ok(()) => info!("[OK]    {} (Vulkan {}): compute output verified bit-exact", dev.name, dev.api_version),
                Err(e) => {
                    error!("[ERROR] {} (Vulkan {}): {}", dev.name, dev.api_version, e);
                    errors += 1;
                }
            }
        }

        info!("Vulkan validation finished: {} device(s), {} error(s)", report.devices.len(), errors);
        if errors > 0 {
            std::process::exit(1);
        }
        info!("Clean exit");
    }

    #[cfg(not(feature = "vulkan"))]
    {
        let _ = _args;
        log::error!("Vulkan requested but the binary was compiled without the `vulkan` feature. Re-compile with `--features vulkan`.");
        std::process::exit(1);
    }
}

use crate::cli::VulkanArgs;

pub fn process_vulkan(_args: &VulkanArgs) {
    #[cfg(feature = "serve")]
    if let Some(ref url) = _args.submit_to {
        return submit_to_server(url);
    }

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

/// POSTs a Vulkan job to a running `hodow_cli serve` instead of running it locally. The
/// server runs it as a whole-process subprocess (see `serve::executor::run_subprocess_job`),
/// so it never calls into the Vulkan loader from its own process.
#[cfg(feature = "serve")]
fn submit_to_server(base_url: &str) {
    use log::{error, info};

    let body = serde_json::json!({ "kind": "vulkan", "spec": {} });
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

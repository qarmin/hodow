use crate::cli::VulkanArgs;

pub fn process_vulkan(_args: &VulkanArgs) {
    #[cfg(feature = "vulkan")]
    {
        use hodow_common::{Finding, Level, RunStatus, StepOutcome, Summary, Verdict};
        use log::{error, info};

        info!("Vulkan compute validation");
        let session = crate::session::Session::start(
            "vulkan",
            "Vulkan compute validation",
            &std::env::args().skip(1).collect::<Vec<_>>(),
        );
        let reporter = session.reporter();
        let step = reporter.step("Vulkan devices").unit("devices").start();
        let report = hodow_gpu::vulkan::run_compute_validation();

        if let Some(err) = &report.init_error {
            reporter.log(Level::Error, format!("Vulkan initialization error: {err}"));
            step.finish(StepOutcome::Failed);
            session.finish_with(RunStatus::Failed, Summary::default());
            error!("Vulkan initialization error: {err}");
            std::process::exit(1);
        }

        if let Some(reason) = &report.unavailable {
            reporter.log(Level::Info, format!("Vulkan not available on this system: {reason}"));
            step.finish(StepOutcome::Skipped);
            session.finish(None);
            info!("Vulkan not available on this system: {reason}");
            info!("Clean exit (nothing to test)");
            return;
        }

        if report.devices.is_empty() {
            reporter.log(
                Level::Info,
                "No Vulkan devices found (loader present but no physical devices)",
            );
            step.finish(StepOutcome::Skipped);
            session.finish(None);
            info!("No Vulkan devices found (loader present but no physical devices).");
            info!("Clean exit");
            return;
        }

        let mut errors = 0;
        for dev in &report.devices {
            let name = format!("{} (Vulkan {})", dev.name, dev.api_version);
            match &dev.outcome {
                Ok(()) => {
                    info!("[OK]    {name}: compute output verified bit-exact");
                    reporter.finding(Finding::new(name, Verdict::Passed));
                }
                Err(e) => {
                    error!("[ERROR] {name}: {e}");
                    reporter.finding(Finding::new(name, Verdict::Failed).detail(e.clone()));
                    errors += 1;
                }
            }
        }

        errors += run_flows(reporter);
        step.finish(if errors > 0 {
            StepOutcome::Failed
        } else {
            StepOutcome::Done
        });
        session.finish(None);

        info!(
            "Vulkan validation finished: {} device(s), {} error(s)",
            report.devices.len(),
            errors
        );
        if errors > 0 {
            std::process::exit(1);
        }
        info!("Clean exit");
    }

    #[cfg(not(feature = "vulkan"))]
    {
        log::error!(
            "Vulkan requested but the binary was compiled without the `vulkan` feature. Re-compile with `--features vulkan`."
        );
        std::process::exit(1);
    }
}

/// The processing flows on the one device the bench kernels open (the first that is not a CPU, else the first). Returns how many failed.
#[cfg(feature = "vulkan")]
fn run_flows(reporter: &hodow_common::Reporter) -> usize {
    use hodow_bench::flows::{self, Device, Flow, Outcome};
    use hodow_common::{Finding, Verdict};
    use log::{error, info};

    if !flows::enabled() {
        return 0;
    }
    let mut cache = hodow_bench::bench::Cache::default();
    let (mut failed, mut unsupported) = (0, 0);
    for &flow in Flow::ALL {
        match flows::run(flow, Device::Vulkan, &mut cache) {
            Outcome::Passed(msg) => {
                info!("[OK]    flow {}: {msg}", flow.name());
                reporter.finding(Finding::new(format!("flow {}", flow.name()), Verdict::Passed).detail(msg));
            }
            Outcome::Unsupported(why) => {
                info!("[SKIP]  flow {}: not supported here: {why}", flow.name());
                reporter.finding(Finding::new(format!("flow {}", flow.name()), Verdict::NotSupported).detail(why));
                unsupported += 1;
            }
            Outcome::Failed(e) => {
                error!("[ERROR] flow {}: {e}", flow.name());
                reporter.finding(Finding::new(format!("flow {}", flow.name()), Verdict::Failed).detail(e));
                failed += 1;
            }
        }
    }
    info!(
        "Flows: {} passed, {unsupported} not supported here, {failed} failed",
        Flow::ALL.len() - failed - unsupported
    );
    failed
}

//! `hodow cts`: the Khronos CTS port, run inside this process. Its own report goes to the terminal as it always did;
//! what a run produces is also recorded here as one finding per case, so it is saved and shown like every other run.

use crate::cli::CtsArgs;

#[cfg(any(feature = "cts_opengles", feature = "cts_vulkan"))]
pub fn process_cts(args: &CtsArgs) -> i32 {
    use std::ffi::OsString;

    hodow_cts::runner::isolate::set_reexec_prefix(vec!["cts".to_string()]);
    hodow_cts::cli::set_observer(Box::new(Recorder::default()));
    let argv = std::iter::once(OsString::from("hodow cts")).chain(args.args.iter().cloned());
    i32::from(hodow_cts::cli::main_from(argv))
}

#[cfg(not(any(feature = "cts_opengles", feature = "cts_vulkan")))]
pub fn process_cts(_: &CtsArgs) -> i32 {
    eprintln!(
        "This hodow was built without the conformance suites. Rebuild with --features cts_opengles, cts_opengl and/or cts_vulkan."
    );
    2
}

/// Which halves are compiled in, as the dashboard shows them.
#[cfg(feature = "serve")]
pub fn built_in() -> Vec<&'static str> {
    let mut halves = Vec::new();
    if cfg!(feature = "cts_opengles") {
        halves.push("OpenGL ES");
    }
    if cfg!(feature = "cts_opengl") {
        halves.push("OpenGL");
    }
    if cfg!(feature = "cts_vulkan") {
        halves.push("Vulkan");
    }
    halves
}

#[cfg(any(feature = "cts_opengles", feature = "cts_vulkan"))]
fn verdict_of(status: hodow_cts::tcu::TestResult) -> hodow_common::Verdict {
    use hodow_common::Verdict;
    use hodow_cts::tcu::TestResult as R;
    match status {
        R::Pass | R::QualityWarning | R::CompatibilityWarning | R::CapabilityWarning => Verdict::Passed,
        R::NotSupported => Verdict::NotSupported,
        R::Fail | R::ResourceError | R::InternalError => Verdict::Failed,
        R::Crash | R::DeviceLost | R::Pending => Verdict::Crashed,
        R::Timeout => Verdict::TimedOut,
    }
}

#[cfg(any(feature = "cts_opengles", feature = "cts_vulkan"))]
struct Run {
    session: crate::session::Session,
    step: Option<hodow_common::Step>,
    done: u64,
}

/// Starts the run when the runner says it has a plan (a `--list` or a `fuzz` never does) and ends it with the runner's
/// own exit code, which may be the last thing the process does.
#[cfg(any(feature = "cts_opengles", feature = "cts_vulkan"))]
#[derive(Default)]
struct Recorder(std::sync::Mutex<Option<Run>>);

#[cfg(any(feature = "cts_opengles", feature = "cts_vulkan"))]
impl hodow_cts::cli::Observer for Recorder {
    fn selected(&self, total: usize) {
        let session =
            crate::session::Session::start("cts", "Khronos CTS", &std::env::args().skip(1).collect::<Vec<_>>());
        let step = session
            .reporter()
            .step("Cases")
            .unit("cases")
            .total(total as u64)
            .start();
        *self.0.lock().unwrap_or_else(|e| e.into_inner()) = Some(Run {
            session,
            step: Some(step),
            done: 0,
        });
    }

    fn result(&self, result: &hodow_cts::report::CaseResult) {
        let mut guard = self.0.lock().unwrap_or_else(|e| e.into_inner());
        let Some(run) = guard.as_mut() else { return };
        let mut finding = hodow_common::Finding::new(result.name.clone(), verdict_of(result.status));
        if let Some(step) = run.step.as_ref() {
            finding = finding.in_step(step.id());
        }
        if !result.message.is_empty() {
            finding = finding.detail(result.message.clone());
        }
        run.session.reporter().finding(finding.duration_us(result.duration_us));
        run.done += 1;
        if let Some(step) = run.step.as_mut() {
            step.progress(run.done, Some(&result.name));
        }
    }

    fn finished(&self, code: u8) {
        let Some(run) = self.0.lock().unwrap_or_else(|e| e.into_inner()).take() else {
            return;
        };
        if let Some(step) = run.step {
            step.finish(if code == 0 {
                hodow_common::StepOutcome::Done
            } else {
                hodow_common::StepOutcome::Failed
            });
        }
        // Exit 2 is "no driver for anything selected": nothing ran, which is not a failure.
        let status = match code {
            0 | 2 => None,
            _ => Some(hodow_common::RunStatus::Failed),
        };
        run.session.finish(status);
    }
}

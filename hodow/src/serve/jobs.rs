use clap::Parser;
use serde::Serialize;

use crate::cli::{Cli, Commands};

#[derive(Serialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum JobStatus {
    Queued,
    Running,
    Succeeded,
    /// Exit code 2: nothing could run here (no driver), which is not a failure.
    Skipped,
    Failed,
    Cancelled,
}

#[derive(Serialize, Clone, Debug)]
pub struct Job {
    pub id: u64,
    pub module: String,
    pub args: Vec<String>,
    pub status: JobStatus,
    pub submitted_ms: u64,
    pub started_ms: Option<u64>,
    pub finished_ms: Option<u64>,
    pub run: Option<String>,
    pub exit_code: Option<i32>,
}

pub struct Validated {
    pub module: &'static str,
    pub args: Vec<String>,
}

/// What a request may ask this machine to run. The arguments are parsed by the real command line definition, so a
/// flag that does not exist is refused by `clap` and one that reaches outside the results directory (`--out`,
/// `--report`, `--background`, `--log-file`, ...) is refused here: the server has no authentication on purpose, and a
/// job must not be a way to write arbitrary files or start arbitrary programs.
pub fn validate(args: &[String]) -> Result<Validated, String> {
    let cli = Cli::try_parse_from(std::iter::once("hodow".to_string()).chain(args.iter().cloned()))
        .map_err(|e| e.render().to_string())?;
    if cli.log_file.is_some() || cli.data_dir.is_some() || cli.no_results || cli.events || cli.no_log_file {
        return Err(
            "--log-file, --no-log-file, --data-dir, --no-results and --events are not accepted in a job".into(),
        );
    }
    #[cfg(feature = "serve")]
    if cli.submit_to.is_some() {
        return Err("--submit-to is not accepted in a job".into());
    }
    let command = cli.command.ok_or("no command")?.normalized();
    let mut args = args.to_vec();
    let module = match &command {
        Commands::Cpu(a) => {
            if a.report.is_some() || a.worker_start.is_some() || a.list_modes || a.list_functions {
                return Err("--report, --worker-start and the list flags are not accepted in a job".into());
            }
            if a.stress { "stress" } else { "cpu" }
        }
        Commands::Gpu(a) => {
            if a.gpu_worker.is_some() {
                return Err("--gpu-worker is not accepted in a job".into());
            }
            if a.memtest { "gpu-memtest" } else { "gl" }
        }
        Commands::Vulkan(_) => "vulkan",
        Commands::Burn(a) => {
            if a.worker.is_some() || a.show.is_some() || a.out.is_some() || a.http_port.is_some() || a.selftest {
                return Err("--worker, --show, --out, --http-port and --selftest are not accepted in a job".into());
            }
            args.extend(["--no-http".into(), "--exit-when-done".into()]);
            "burn"
        }
        Commands::Bench(a) => {
            if a.worker
                || a.out.is_some()
                || a.report.is_some()
                || a.compare.is_some()
                || a.list
                || !a.background.is_empty()
            {
                return Err(
                    "--worker, --out, --report, --compare, --list and --background are not accepted in a job".into(),
                );
            }
            "bench"
        }
        Commands::Cts(a) => {
            validate_cts(&a.args)?;
            "cts"
        }
        _ => return Err("only test, burn, bench and cts can be queued".into()),
    };
    Ok(Validated { module, args })
}

#[cfg(any(feature = "cts_opengles", feature = "cts_vulkan"))]
fn validate_cts(args: &[std::ffi::OsString]) -> Result<(), String> {
    let args: Vec<String> = args.iter().map(|a| a.to_string_lossy().into_owned()).collect();
    hodow_cts::cli::validate_job(&args)
}

#[cfg(not(any(feature = "cts_opengles", feature = "cts_vulkan")))]
fn validate_cts(_: &[std::ffi::OsString]) -> Result<(), String> {
    Err("this hodow was built without the conformance suites".into())
}

#[cfg(test)]
mod tests {
    use super::*;

    fn check(args: &[&str]) -> Result<Validated, String> {
        validate(&args.iter().map(|s| s.to_string()).collect::<Vec<_>>())
    }

    #[test]
    fn the_normal_ways_to_run_things_are_accepted() {
        assert_eq!(check(&["test", "cpu", "--isolate"]).unwrap().module, "cpu");
        assert_eq!(check(&["test", "gl", "--no-window", "--isolate"]).unwrap().module, "gl");
        assert_eq!(
            check(&["cpu", "--stress", "--stress-secs", "30"]).unwrap().module,
            "stress"
        );
        assert_eq!(check(&["gpu", "--memtest"]).unwrap().module, "gpu-memtest");
        assert_eq!(check(&["test", "vulkan"]).unwrap().module, "vulkan");
        assert_eq!(check(&["bench", "--quick", "-k", "eye"]).unwrap().module, "bench");
    }

    #[cfg(any(feature = "cts_opengles", feature = "cts_vulkan"))]
    #[test]
    fn a_conformance_run_needs_a_case_and_may_not_write_files_or_start_other_modes() {
        assert_eq!(
            check(&["cts", "--case", "dEQP-GLES2.info.*", "-j", "2"])
                .unwrap()
                .module,
            "cts"
        );
        for bad in [
            &["cts"][..],
            &["cts", "--list", "--case", "x"],
            &["cts", "--case", "x", "--output", "/tmp/x"],
            &["cts", "--case", "x", "--case-list", "/etc/passwd"],
            &["cts", "fuzz", "run"],
            &["cts", "board", "x"],
        ] {
            assert!(check(bad).is_err(), "{bad:?} must be refused");
        }
    }

    #[test]
    fn a_burn_job_never_opens_its_own_dashboard_or_waits_for_ctrl_c() {
        let burn = check(&["burn", "--quick"]).unwrap();
        assert!(burn.args.contains(&"--no-http".to_string()) && burn.args.contains(&"--exit-when-done".to_string()));
    }

    #[test]
    fn flags_that_reach_outside_the_results_directory_are_refused() {
        for bad in [
            &["bench", "--background", "rm -rf /"][..],
            &["bench", "--out", "/etc"],
            &["bench", "--report", "/tmp/x"],
            &["cpu", "--report", "/tmp/x"],
            &["burn", "--out", "/tmp/x"],
            &["--log-file", "/tmp/x", "test", "cpu"],
            &["--data-dir", "/tmp/x", "test", "cpu"],
            &["--no-results", "test", "cpu"],
            &["cpu", "--worker-start", "0"],
            &["gpu", "--gpu-worker", "0"],
        ] {
            assert!(check(bad).is_err(), "{bad:?} must be refused");
        }
    }

    #[test]
    fn other_commands_and_nonsense_are_refused() {
        for bad in [
            &["serve"][..],
            &["runs"],
            &["info"],
            &["frobnicate"],
            &["test", "cpu", "--no-such-flag"],
            &[],
        ] {
            assert!(check(bad).is_err(), "{bad:?} must be refused");
        }
    }
}

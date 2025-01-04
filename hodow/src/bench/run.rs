//! The run: probe, plan, every row through a worker, a live line for the row in progress,
//! and the record written as it goes. Nothing here times anything itself.

use std::path::PathBuf;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use hodow_bench::bench::spec::{RowResult, RowSpec, RowStatus};

use super::plan::{self, Profile};
use super::pool::{Ended, Pool};
use super::protocol::Probe;
use super::report::{Term, breakdown, fmt_ms};
use super::results::{Results, Row, RowEnv};
use crate::burn::dashboard::Dash;
use crate::burn::sensors::{Sample, Sensors};
use crate::burn::supervise::Status;
use crate::burn::ui::{Ui, fmt_secs};
use crate::cli::BenchArgs;

const DEFAULT_HANG_TIMEOUT: Duration = Duration::from_secs(60);
const SAVE_EVERY: Duration = Duration::from_secs(30);
const NAME_WIDTH: usize = 40;

fn status_tag(status: RowStatus) -> Status {
    match status {
        RowStatus::Ok => Status::Ok,
        RowStatus::Mismatch | RowStatus::Failed => Status::Error,
        RowStatus::Unsupported => Status::Skip,
        RowStatus::Crash => Status::Crash,
        RowStatus::Hang => Status::Hang,
    }
}

fn profile(args: &BenchArgs) -> Profile {
    if args.quick {
        Profile::Quick
    } else if args.full {
        Profile::Full
    } else {
        Profile::Default
    }
}

fn probe(ui: &Ui) -> Probe {
    match Pool::probe() {
        Ok(p) => p,
        Err(e) => {
            println!("{}", ui.red(&format!("OpenCL probe: {e}")));
            Probe {
                devices: Vec::new(),
                notes: vec![format!("probe: {e}")],
                threads: crate::burn::orchestrator::allowed_cpus().len() as u32,
                simd: hodow_bench::bench::cpu::simd_name().map(str::to_string),
                gles: None,
                vulkan: None,
                tflite: None,
            }
        }
    }
}

fn row_line(ui: &Ui, spec: &RowSpec, result: &RowResult, env: &RowEnv) -> String {
    let name = format!("{:<NAME_WIDTH$}", spec.backend.to_string());
    let tag = ui.tag(status_tag(result.status));
    match (result.status, result.timings.total) {
        (RowStatus::Ok | RowStatus::Mismatch, Some(total)) => {
            let mut line = format!(
                "{tag}{name} {:>8} ms  p95 {:>7}",
                fmt_ms(total.median),
                fmt_ms(total.p95)
            );
            if spec.backend.is_gpu() {
                line.push_str(&ui.dim(&format!(
                    "  ({})",
                    breakdown(&Row {
                        spec: spec.clone(),
                        result: result.clone(),
                        env: env.clone()
                    })
                )));
            }
            line.push_str(&ui.dim(&format!("  x{}", result.reps)));
            match (env.start_temp, env.max_temp) {
                (Some(a), Some(b)) if spec.soak => line.push_str(&ui.dim(&format!("  {a:.0}->{b:.0}°C"))),
                (_, Some(t)) => line.push_str(&ui.dim(&format!("  {t:.0}°C"))),
                _ => {}
            }
            if spec.soak
                && let Some((first, last)) = super::report::soak_trend(result)
            {
                line.push_str(&format!("  first {} -> last {} ms", fmt_ms(first), fmt_ms(last)));
            }
            if result.status == RowStatus::Mismatch {
                line.push_str(&format!("\n          {}", ui.red(&result.detail)));
            } else if !result.detail.is_empty() {
                line.push_str(&format!("\n          {}", ui.dim(&result.detail)));
            }
            line
        }
        _ => format!(
            "{tag}{name} {}",
            if result.status == RowStatus::Unsupported {
                ui.dim(&result.detail)
            } else {
                ui.red(&result.detail)
            }
        ),
    }
}

fn env_between(samples: &[Sample], from: f64, to: f64) -> RowEnv {
    let window: Vec<&Sample> = samples
        .iter()
        .filter(|s| s.t >= from - 0.6 && s.t <= to + 0.6)
        .collect();
    // The busiest core's clock per sample: idle cores park low and say nothing about throttling.
    let freqs: Vec<u32> = window
        .iter()
        .filter_map(|s| s.freq_mhz.iter().copied().max())
        .filter(|&f| f > 0)
        .collect();
    RowEnv {
        started: from,
        start_temp: window.first().and_then(|s| s.max_temp()),
        max_temp: window.iter().filter_map(|s| s.max_temp()).reduce(f32::max),
        cpu_mhz_min: freqs.iter().copied().min(),
        cpu_mhz_max: freqs.iter().copied().max(),
    }
}

pub fn write_reports(results: &Results, dir: &std::path::Path) -> Result<(), String> {
    results.save(dir)?;
    let md = dir.join("report.md");
    std::fs::write(&md, super::report::markdown(results)).map_err(|e| format!("cannot write {}: {e}", md.display()))?;
    let html = dir.join("report.html");
    std::fs::write(&html, super::html::report(results)).map_err(|e| format!("cannot write {}: {e}", html.display()))
}

fn planned(args: &BenchArgs, probe: &Probe) -> Vec<RowSpec> {
    let mut rows = plan::filter(plan::rows(profile(args), probe), &args.kernels, &args.backends);
    if let Some(secs) = args.soak {
        rows.extend(plan::filter(plan::soak_rows(secs, probe), &[], &args.backends));
    }
    rows
}

/// The --background commands, each in a process group of its own so that whatever it
/// starts goes when it does.
struct Background(Vec<std::process::Child>);

impl Background {
    fn start(commands: &[String], ui: &Ui) -> Background {
        use std::os::unix::process::CommandExt;
        let mut children = Vec::new();
        for cmd in commands {
            match std::process::Command::new("sh")
                .args(["-c", cmd])
                .process_group(0)
                .stdin(std::process::Stdio::null())
                .stdout(std::process::Stdio::null())
                .stderr(std::process::Stdio::null())
                .spawn()
            {
                Ok(child) => {
                    println!("{}", ui.note(&format!("background (pid {}): {cmd}", child.id())));
                    children.push(child);
                }
                Err(e) => println!("{}", ui.red(&format!("background command did not start: {cmd}: {e}"))),
            }
        }
        if !children.is_empty() {
            // Long enough for a compositor or a GUI to come up before anything is timed.
            std::thread::sleep(Duration::from_secs(3));
            for child in &mut children {
                if let Ok(Some(status)) = child.try_wait() {
                    println!(
                        "{}",
                        ui.red(&format!("background pid {} already exited: {status}", child.id()))
                    );
                }
            }
        }
        Background(children)
    }
}

impl Drop for Background {
    fn drop(&mut self) {
        for child in &mut self.0 {
            let group = -(child.id() as i32);
            unsafe { libc::kill(group, libc::SIGTERM) };
        }
        std::thread::sleep(Duration::from_millis(500));
        for child in &mut self.0 {
            unsafe { libc::kill(-(child.id() as i32), libc::SIGKILL) };
            let _ = child.wait();
        }
    }
}

pub fn list(args: &BenchArgs) -> i32 {
    let ui = Ui::new();
    let probe = probe(&ui);
    let rows = planned(args, &probe);
    for d in &probe.devices {
        println!(
            "{}",
            ui.note(&format!(
                "OpenCL {}: {} / {} ({})",
                d.lib, d.platform, d.device, d.platform_version
            ))
        );
    }
    for (api, label) in [
        ("GLES", &probe.gles),
        ("Vulkan", &probe.vulkan),
        ("TFLite", &probe.tflite),
    ] {
        if let Some(label) = label {
            println!("{}", ui.note(&format!("{api}: {label}")));
        }
    }
    for n in &probe.notes {
        println!("{}", ui.dim(n));
    }
    let mut group = String::new();
    for row in &rows {
        if row.group() != group {
            group = row.group();
            println!("{}", ui.header(&format!("\n== {group}")));
        }
        println!("  {}", row.backend);
    }
    let budget: u64 = rows.iter().map(|r| r.budget_ms).sum();
    println!(
        "\n{} rows, at least {} of timed frames",
        rows.len(),
        fmt_secs(budget as f64 / 1000.0)
    );
    0
}

pub fn run(args: &BenchArgs) -> i32 {
    let ui = Ui::new();
    let profile = profile(args);
    let start = Instant::now();
    let background = Background::start(&args.background, &ui);
    let probe = probe(&ui);
    let rows = planned(args, &probe);
    if rows.is_empty() {
        eprintln!("no rows match the filters");
        return 2;
    }
    let session = crate::session::Session::start(
        "bench",
        &format!("Benchmark ({} profile)", profile.name()),
        &std::env::args().skip(1).collect::<Vec<_>>(),
    );
    let out_dir = args
        .out
        .clone()
        .or_else(|| session.run_dir())
        .unwrap_or_else(|| std::env::temp_dir().join(format!("hodow-bench-{}", crate::run_log::timestamp())));
    if let Err(e) = std::fs::create_dir_all(&out_dir) {
        eprintln!("cannot create {}: {e}", out_dir.display());
        return 2;
    }
    let mut kernel = crate::burn::kernel::follow(&out_dir.join("kernel.log"), Dash::default());

    let (mut sensors, _) = Sensors::discover();
    let samples: Arc<Mutex<Vec<Sample>>> = Arc::default();
    {
        let samples = samples.clone();
        std::thread::spawn(move || {
            loop {
                std::thread::sleep(Duration::from_millis(500));
                let sample = sensors.sample(start.elapsed().as_secs_f64());
                samples.lock().unwrap_or_else(|e| e.into_inner()).push(sample);
            }
        });
    }
    let stop = Arc::new(AtomicBool::new(false));
    {
        let stop = stop.clone();
        let _ = ctrlc::set_handler(move || stop.store(true, Ordering::Relaxed));
    }

    let mut results = Results {
        started: crate::run_log::timestamp(),
        host: crate::info::summary_line(),
        hostname: sysinfo::System::host_name().unwrap_or_else(|_| "unknown".into()),
        profile: profile.name().into(),
        threads: probe.threads,
        simd: probe.simd.clone(),
        governor: std::fs::read_to_string("/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor")
            .ok()
            .map(|g| g.trim().to_string()),
        devices: probe.devices.clone(),
        gles: probe.gles.clone(),
        vulkan: probe.vulkan.clone(),
        notes: probe.notes.clone(),
        background: args.background.clone(),
        ..Results::default()
    };
    println!(
        "{}",
        ui.header(&format!(
            "hodow bench - {} profile, {} rows | {}",
            profile.name(),
            rows.len(),
            results.host
        ))
    );
    for d in &probe.devices {
        println!(
            "{}",
            ui.note(&format!(
                "OpenCL {}: {} / {} ({}), {} CU",
                d.lib, d.platform, d.device, d.platform_version, d.compute_units
            ))
        );
    }
    for (api, label) in [
        ("GLES", &probe.gles),
        ("Vulkan", &probe.vulkan),
        ("TFLite", &probe.tflite),
    ] {
        if let Some(label) = label {
            println!("{}", ui.note(&format!("{api}: {label}")));
        }
    }
    for n in &probe.notes {
        println!("{}", ui.dim(n));
    }
    println!("{}", ui.note(&format!("results: {}", out_dir.display())));

    let hang_timeout = args.hang_timeout.map_or(DEFAULT_HANG_TIMEOUT, Duration::from_secs);
    let mut pool = Pool::default();
    let mut wedged: Option<String> = None;
    let mut group = String::new();
    let mut saved = Instant::now();
    let reporter = session.reporter();
    let mut overall = reporter
        .step("Benchmark rows")
        .unit("rows")
        .total(rows.len() as u64)
        .start();
    let mut group_step: Option<hodow_common::Step> = None;
    for (index, spec) in rows.iter().enumerate() {
        if stop.load(Ordering::Relaxed) {
            println!(
                "{}",
                ui.red(&format!("stopped by Ctrl-C after {index} of {} rows", rows.len()))
            );
            break;
        }
        if spec.group() != group {
            group = spec.group();
            println!("{}", ui.phase(&group, None));
            if let Some(old) = group_step.take() {
                old.finish(hodow_common::StepOutcome::Done);
            }
            let in_group = rows.iter().filter(|r| r.group() == group).count() as u64;
            group_step = Some(
                reporter
                    .step(group.clone())
                    .parent(&overall)
                    .unit("rows")
                    .total(in_group)
                    .start(),
            );
        }
        overall.progress(index as u64, Some(&spec.backend.to_string()));
        let from = start.elapsed().as_secs_f64();
        let result = match (&wedged, spec.backend.is_gpu()) {
            (Some(by), true) => RowResult::status(RowStatus::Failed, format!("not run: the GPU was wedged by {by}")),
            _ => {
                let bar = ui.bar(
                    &format!("{:<NAME_WIDTH$}", spec.backend.to_string()),
                    Duration::from_millis(spec.budget_ms),
                );
                bar.set_prefix(format!("{}/{}", index + 1, rows.len()));
                let row_start = Instant::now();
                let ended = pool.run(spec, hang_timeout, |reps| {
                    bar.set_position(row_start.elapsed().as_millis() as u64);
                    bar.set_prefix(format!("{}/{}  {reps} frames", index + 1, rows.len()));
                });
                bar.finish_and_clear();
                match ended {
                    Ended::Result(r) => r,
                    Ended::Wedged(r) => {
                        wedged = Some(spec.id());
                        r
                    }
                }
            }
        };
        let env = env_between(
            &samples.lock().unwrap_or_else(|e| e.into_inner()),
            from,
            start.elapsed().as_secs_f64(),
        );
        println!("{}", row_line(&ui, spec, &result, &env));
        reporter.finding(row_finding(spec, &result, group_step.as_ref().map(|g| g.id())));
        overall.progress(index as u64 + 1, Some(&spec.backend.to_string()));
        results.rows.push(Row {
            spec: spec.clone(),
            result,
            env,
        });
        if saved.elapsed() > SAVE_EVERY {
            results.secs = start.elapsed().as_secs_f64();
            let _ = results.save(&out_dir);
            saved = Instant::now();
        }
    }
    drop(pool);
    drop(background);
    if let Some(step) = group_step.take() {
        step.finish(hodow_common::StepOutcome::Done);
    }
    let was_stopped = stop.load(Ordering::Relaxed);
    overall.finish(if was_stopped {
        hodow_common::StepOutcome::Cancelled
    } else {
        hodow_common::StepOutcome::Done
    });
    session.finish(was_stopped.then_some(hodow_common::RunStatus::Cancelled));
    results.secs = start.elapsed().as_secs_f64();
    if let Err(e) = write_reports(&results, &out_dir) {
        eprintln!("{e}");
    }
    print!("{}", Term { color: ui.color() }.summary(&results));
    if let Some(child) = kernel.as_mut() {
        let _ = child.kill();
        let _ = child.wait();
    }
    let failed = results
        .rows
        .iter()
        .filter(|r| {
            matches!(
                r.result.status,
                RowStatus::Mismatch | RowStatus::Failed | RowStatus::Crash | RowStatus::Hang
            )
        })
        .count();
    let skipped = results
        .rows
        .iter()
        .filter(|r| r.result.status == RowStatus::Unsupported)
        .count();
    println!(
        "\n{} rows in {}: {} ok, {} not available here, {} failed",
        results.rows.len(),
        fmt_secs(results.secs),
        results.rows.len() - failed - skipped,
        skipped,
        failed
    );
    let path = |name: &str| PathBuf::from(&out_dir).join(name).display().to_string();
    println!(
        "{}",
        ui.note(&format!(
            "report: {}\n        {}\n        {}",
            path("report.html"),
            path("report.md"),
            path("results.json")
        ))
    );
    if failed > 0 { 1 } else { 0 }
}

pub fn rerender(dir: &std::path::Path) -> i32 {
    match Results::load(dir) {
        Ok(results) => {
            let dir = Results::path(dir).parent().map(PathBuf::from).unwrap_or_default();
            match write_reports(&results, &dir) {
                Ok(()) => {
                    print!(
                        "{}",
                        Term {
                            color: Ui::new().color()
                        }
                        .summary(&results)
                    );
                    println!("\nwritten: {}/report.html, report.md", dir.display());
                    0
                }
                Err(e) => {
                    eprintln!("{e}");
                    2
                }
            }
        }
        Err(e) => {
            eprintln!("{e}");
            2
        }
    }
}

fn row_finding(spec: &RowSpec, result: &RowResult, step: Option<hodow_common::StepId>) -> hodow_common::Finding {
    use hodow_common::Verdict;
    let verdict = match result.status {
        RowStatus::Ok => Verdict::Passed,
        RowStatus::Mismatch | RowStatus::Failed => Verdict::Failed,
        RowStatus::Unsupported => Verdict::NotSupported,
        RowStatus::Crash => Verdict::Crashed,
        RowStatus::Hang => Verdict::TimedOut,
    };
    let mut parts = Vec::new();
    if let Some(total) = result.timings.total {
        parts.push(format!(
            "median {} ms, p95 {} ms",
            fmt_ms(total.median),
            fmt_ms(total.p95)
        ));
    }
    if !result.detail.is_empty() {
        parts.push(result.detail.clone());
    }
    let mut finding = hodow_common::Finding::new(spec.id(), verdict);
    finding.step = step;
    if !parts.is_empty() {
        finding = finding.detail(parts.join(" - "));
    }
    finding
}

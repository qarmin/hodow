//! The run itself: rows in order, each as one or more workers, with sensors, the journal,
//! the kernel log and the dashboard kept up to date around them. Nothing here runs a test.

use std::path::PathBuf;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use super::dashboard::{self, Dash, DashState, RowView};
use super::events::{Event, Journal, RowResult};
use super::plan::{self, Part, Phase, Row};
use super::protocol::{GpuTest, Job, WorkerSpec};
use super::sensors::{Sample, SensorInfo, Sensors};
use super::supervise::{self, Control, PartOutcome, Status};
use super::ui::{Ui, fmt_secs};
use crate::cli::BurnArgs;

const DEFAULT_DURATION: Duration = Duration::from_secs(600);
const DEFAULT_PORT: u16 = 5997;
const DEFAULT_HANG_TIMEOUT: Duration = Duration::from_secs(30);
const THROTTLE_RATIO: f32 = 0.85;

struct Run {
    ui: Ui,
    samples: Arc<Mutex<Vec<Sample>>>,
    info: SensorInfo,
    stop: Arc<AtomicBool>,
    start: Instant,
    hang_timeout: Duration,
    max_temp: Option<f32>,
    ram_mb: Option<u64>,
    gpu_mb: Option<u64>,
    cpus: Vec<usize>,
    gpu_dead: bool,
    aborted: Option<String>,
    /// Warnings already printed once - mlock and trip points would otherwise repeat on
    /// every row.
    warned: std::collections::HashSet<String>,
}

/// The cpus this process may run on, in order.
pub fn allowed_cpus() -> Vec<usize> {
    let mut set: libc::cpu_set_t = unsafe { std::mem::zeroed() };
    let ok = unsafe { libc::sched_getaffinity(0, std::mem::size_of::<libc::cpu_set_t>(), &mut set) } == 0;
    let cpus: Vec<usize> = if ok {
        (0..libc::CPU_SETSIZE as usize)
            .filter(|&c| unsafe { libc::CPU_ISSET(c, &set) })
            .collect()
    } else {
        Vec::new()
    };
    if cpus.is_empty() {
        (0..std::thread::available_parallelism().map_or(1, |n| n.get())).collect()
    } else {
        cpus
    }
}

/// What the memory phase may use when `--ram-mb` is not given; see `ram::plan`.
pub fn default_ram_mb() -> u64 {
    super::ram::plan_here().budget_mb
}

fn default_out_dir() -> PathBuf {
    std::env::temp_dir().join(format!("hodow-burn-{}", crate::run_log::timestamp()))
}

/// The address another machine would reach this one on. UDP `connect` sends nothing.
fn lan_address() -> String {
    std::net::UdpSocket::bind("0.0.0.0:0")
        .and_then(|s| s.connect("192.0.2.1:9").and_then(|_| s.local_addr()))
        .map(|a| a.ip().to_string())
        .unwrap_or_else(|_| "localhost".into())
}

pub fn run(args: &BurnArgs) -> i32 {
    let ui = Ui::new();
    let phases = match plan::phases(&args.only, &args.skip) {
        Ok(p) => p,
        Err(e) => {
            eprintln!("{e}");
            return 2;
        }
    };
    let duration = args.duration.unwrap_or(DEFAULT_DURATION);
    let rows = plan::build(&phases, duration, args.quick);
    let session = crate::session::Session::start(
        "burn",
        "Burn: CPU, RAM and GPU under load",
        &std::env::args().skip(1).collect::<Vec<_>>(),
    );
    // Its own events.jsonl lives in a subdirectory: the session's result file is called the same.
    let out_dir = args
        .out
        .clone()
        .or_else(|| session.run_dir().map(|d| d.join("burn")))
        .unwrap_or_else(default_out_dir);
    if let Err(e) = std::fs::create_dir_all(&out_dir) {
        eprintln!("cannot create {}: {e}", out_dir.display());
        return 2;
    }
    let start = Instant::now();
    let journal = match Journal::create(&out_dir.join("events.jsonl"), start) {
        Ok(j) => Arc::new(j),
        Err(e) => {
            eprintln!("cannot write {}: {e}", out_dir.join("events.jsonl").display());
            return 2;
        }
    };
    let (mut sensors, info) = Sensors::discover();
    let length = if args.quick {
        "one pass of each".to_string()
    } else {
        format!("{} total", fmt_secs(duration.as_secs_f64()))
    };
    let header = format!("hodow burn - {length} | {}", crate::info::summary_line());
    let initial = DashState {
        header: header.clone(),
        out_dir: out_dir.display().to_string(),
        info: info.clone(),
        duration_secs: rows.iter().map(|r| r.budget.as_secs_f64()).sum(),
        rows: rows
            .iter()
            .map(|r| RowView {
                name: r.name.clone(),
                phase: r.phase.title().to_string(),
                budget_secs: r.budget.as_secs_f64(),
                started_at: None,
                result: None,
            })
            .collect(),
        ..Default::default()
    };
    let port = args.http_port.unwrap_or(DEFAULT_PORT);
    let (dash, dash_note) = if args.no_http {
        (Dash::default(), None)
    } else {
        match dashboard::start(port, initial) {
            Ok(d) => (d, Some(format!("dashboard: http://{}:{port}", lan_address()))),
            Err(e) => (Dash::default(), Some(format!("no dashboard: {e}"))),
        }
    };
    let mut kernel = super::kernel::follow(&out_dir.join("kernel.log"), dash.clone());

    let samples = Arc::new(Mutex::new(Vec::new()));
    {
        let (samples, journal, dash) = (samples.clone(), journal.clone(), dash.clone());
        std::thread::spawn(move || {
            loop {
                std::thread::sleep(Duration::from_secs(1));
                let sample = sensors.sample(start.elapsed().as_secs_f64());
                journal.write(Event::Sample { sample: sample.clone() });
                dash.update(|d| {
                    d.elapsed = sample.t;
                    d.samples.push(sample.clone());
                });
                samples.lock().unwrap_or_else(|e| e.into_inner()).push(sample);
            }
        });
    }
    let stop = Arc::new(AtomicBool::new(false));
    {
        let stop = stop.clone();
        let _ = ctrlc::set_handler(move || stop.store(true, Ordering::Relaxed));
    }

    println!("{}", ui.header(&header));
    let mut where_to = vec![format!("results: {}", out_dir.display())];
    where_to.extend(dash_note);
    if kernel.is_none() {
        where_to.push("kernel log: unavailable (needs root or journal access)".into());
    }
    println!("{}", ui.note(&where_to.join("   ")));
    journal.write(Event::RunStart {
        header: header.clone(),
        rows: rows.iter().map(|r| r.name.clone()).collect(),
        sensors: info.clone(),
    });

    let mut run = Run {
        ui,
        samples,
        info,
        stop: stop.clone(),
        start,
        hang_timeout: args.hang_timeout.map_or(DEFAULT_HANG_TIMEOUT, Duration::from_secs),
        max_temp: args.max_temp,
        ram_mb: args.ram_mb,
        gpu_mb: args.gpu_mb,
        cpus: allowed_cpus(),
        gpu_dead: false,
        aborted: None,
        warned: Default::default(),
    };
    let mut results = Vec::new();
    let mut phase = None;
    let reporter = session.reporter().clone();
    let mut overall = reporter.step("Burn").unit("rows").total(rows.len() as u64).start();
    let mut phase_step: Option<hodow_common::Step> = None;
    for (index, row) in rows.iter().enumerate() {
        if phase != Some(row.phase) {
            phase = Some(row.phase);
            if let Some(old) = phase_step.take() {
                old.finish(hodow_common::StepOutcome::Done);
            }
            let in_phase = rows.iter().filter(|r| r.phase == row.phase).count() as u64;
            phase_step = Some(
                reporter
                    .step(row.phase.title())
                    .parent(&overall)
                    .unit("rows")
                    .total(in_phase)
                    .start(),
            );
            println!("{}", run.ui.phase(&phase_title(row.phase, &run), run.current_temp()));
            journal.write(Event::Phase {
                name: row.phase.title().into(),
            });
        }
        journal.write(Event::RowStart {
            row: index,
            name: row.name.clone(),
            budget_secs: row.budget.as_secs_f64(),
        });
        let started_at = start.elapsed().as_secs_f64();
        dash.update(|d| {
            d.current = Some(index);
            d.rows[index].started_at = Some(started_at);
        });
        overall.progress(index as u64, Some(&row.name));
        let row_step = reporter
            .step(row.name.clone())
            .parent(phase_step.as_ref().unwrap_or(&overall))
            .unit("s")
            .total(row.budget.as_secs())
            .start();
        let ticking = Arc::new(AtomicBool::new(false));
        let ticker = {
            let (ticking, budget, began) = (ticking.clone(), row.budget.as_secs(), Instant::now());
            std::thread::spawn(move || {
                let mut step = row_step;
                while !ticking.load(Ordering::Relaxed) {
                    step.progress(began.elapsed().as_secs().min(budget), None);
                    std::thread::sleep(Duration::from_millis(500));
                }
                step
            })
        };
        let result = run.row(row);
        ticking.store(true, Ordering::Relaxed);
        if let Ok(step) = ticker.join() {
            step.finish(if result.status.is_failure() {
                hodow_common::StepOutcome::Failed
            } else if result.status == Status::Skip {
                hodow_common::StepOutcome::Skipped
            } else {
                hodow_common::StepOutcome::Done
            });
        }
        reporter.finding(row_finding(&result, phase_step.as_ref().map(|s| s.id())));
        for warning in &result.warnings {
            reporter.log(hodow_common::Level::Warn, format!("{}: {warning}", result.name));
        }
        overall.progress(index as u64 + 1, Some(&row.name));
        for line in run.ui.row(&result) {
            println!("{line}");
        }
        dash.update(|d| d.rows[index].result = Some(result.clone()));
        journal.write(Event::RowEnd {
            row: index,
            result: result.clone(),
        });
        results.push(result);
    }

    if let Some(step) = phase_step.take() {
        step.finish(hodow_common::StepOutcome::Done);
    }
    let was_stopped = stop.load(Ordering::Relaxed);
    overall.finish(if was_stopped {
        hodow_common::StepOutcome::Cancelled
    } else {
        hodow_common::StepOutcome::Done
    });
    session.finish(was_stopped.then_some(hodow_common::RunStatus::Cancelled));
    let secs = start.elapsed().as_secs_f64();
    let max_temp = results.iter().filter_map(|r| r.max_temp).reduce(f32::max);
    let summary = run.ui.summary(&results, secs, max_temp);
    println!("{summary}");
    let failed = results.iter().any(|r| r.status.is_failure());
    journal.write(Event::RunEnd { failed, secs });
    let plain = Ui::plain();
    let mut text: Vec<String> = vec![header];
    for r in &results {
        text.extend(plain.row(r));
    }
    text.push(plain.summary(&results, secs, max_temp));
    let _ = std::fs::write(out_dir.join("summary.txt"), text.join("\n") + "\n");
    let verdict = if failed { "FAILED" } else { "PASSED" };
    dash.update(|d| {
        d.current = None;
        d.verdict = Some(verdict.into());
    });

    if dash.enabled() && !args.exit_when_done && !stop.load(Ordering::Relaxed) {
        println!(
            "{}",
            run.ui
                .dim("The dashboard stays up with the final state - Ctrl-C to exit.")
        );
        while !stop.load(Ordering::Relaxed) {
            std::thread::sleep(Duration::from_millis(200));
        }
    }
    if let Some(child) = kernel.as_mut() {
        let _ = child.kill();
        let _ = child.wait();
    }
    if results.iter().all(|r| r.status == Status::Skip) {
        2
    } else if failed {
        1
    } else {
        0
    }
}

fn phase_title(phase: Phase, run: &Run) -> String {
    match phase {
        Phase::Memory => match run.ram_mb {
            Some(mb) => format!("MEMORY ({mb} MB, as asked)"),
            None => {
                let plan = super::ram::plan_here();
                format!("MEMORY ({} MB: {}; --ram-mb changes it)", plan.budget_mb, plan.reason)
            }
        },
        other => other.title().to_string(),
    }
}

fn skipped(row: &Row, why: &str) -> RowResult {
    RowResult {
        name: row.name.clone(),
        status: Status::Skip,
        secs: 0.0,
        detail: why.to_string(),
        errors: 0,
        samples: Vec::new(),
        warnings: Vec::new(),
        max_temp: None,
    }
}

impl Run {
    fn current_temp(&self) -> Option<f32> {
        self.samples
            .lock()
            .unwrap_or_else(|e| e.into_inner())
            .last()
            .and_then(Sample::max_temp)
    }

    fn row(&mut self, row: &Row) -> RowResult {
        if let Some(why) = &self.aborted {
            return skipped(row, &format!("run aborted: {why}"));
        }
        if self.stop.load(Ordering::Relaxed) {
            return skipped(row, "interrupted (Ctrl-C)");
        }
        let mut warnings = Vec::new();
        let mut parts = row.parts.clone();
        if self.gpu_dead {
            if parts.iter().all(|p| matches!(p, Part::Gpu(_))) {
                return skipped(row, "GPU hung earlier");
            }
            parts.retain(|p| !matches!(p, Part::Gpu(_)));
            warnings.push("GPU part left out - the GPU hung earlier".to_string());
        }
        let combined = parts.len() > 1;
        let half = self.cpus.len().div_ceil(2);
        let (cpu_cores, memory_cores) = if combined && self.cpus.len() >= 2 {
            (self.cpus[..half].to_vec(), self.cpus[half..].to_vec())
        } else {
            (self.cpus.clone(), self.cpus.clone())
        };
        let ram_mb = self.ram_mb.unwrap_or_else(default_ram_mb);
        // A GPU on a shared-memory SoC allocates from the same RAM the memory test locks, and
        // its driver may keep a host copy too, so both come out of one budget.
        let shares_with_gpu = combined && parts.iter().any(|p| matches!(p, Part::Gpu(GpuTest::Memory)));
        let memory_mb = match (combined, shares_with_gpu) {
            (false, _) => ram_mb,
            (true, false) => ram_mb / 2,
            (true, true) => ram_mb * 4 / 10,
        };
        let budget_ms = row.budget.as_millis() as u64;
        let specs: Vec<WorkerSpec> = parts
            .iter()
            .map(|part| {
                let (job, cores) = match *part {
                    Part::Cpu(test) => (Job::Cpu { test }, cpu_cores.clone()),
                    Part::Memory(test) => (Job::Memory { test, mb: memory_mb }, memory_cores.clone()),
                    Part::Gpu(test) => (
                        Job::Gpu {
                            test,
                            mb: self.gpu_mb.map(|mb| if combined { mb / 2 } else { mb }),
                            cap_mb: combined.then_some(ram_mb * 2 / 10),
                        },
                        Vec::new(),
                    ),
                };
                WorkerSpec {
                    job,
                    budget_ms,
                    cores,
                    inject: false,
                }
            })
            .collect();

        let bar = self.ui.bar(&row.name, row.budget);
        let row_start = Instant::now();
        let t0 = self.start.elapsed().as_secs_f64();
        let (stop, max_temp, samples) = (self.stop.clone(), self.max_temp, self.samples.clone());
        let mut beats = 0u64;
        let outcomes = supervise::run_parts(specs, self.hang_timeout, || {
            beats += 1;
            let elapsed = row_start.elapsed();
            bar.set_position(elapsed.as_millis() as u64);
            if beats.is_multiple_of(5) {
                let temp = samples
                    .lock()
                    .unwrap_or_else(|e| e.into_inner())
                    .last()
                    .and_then(Sample::max_temp);
                bar.set_prefix(format!(
                    "{}/{}{}",
                    fmt_secs(elapsed.as_secs_f64()),
                    fmt_secs(row.budget.as_secs_f64()),
                    temp.map(|t| format!("  {t:.0}°C")).unwrap_or_default()
                ));
                if let (Some(limit), Some(t)) = (max_temp, temp)
                    && t > limit
                {
                    return Control::Abort(format!("{t:.0}°C > --max-temp {limit:.0}"));
                }
            }
            if stop.load(Ordering::Relaxed) {
                return Control::Abort("interrupted (Ctrl-C)".into());
            }
            Control::Continue
        });
        bar.finish_and_clear();
        let secs = row_start.elapsed().as_secs_f64();

        if outcomes
            .iter()
            .any(|o| o.role == "gpu" && (o.status == Status::Hang || o.stuck))
        {
            self.gpu_dead = true;
        }
        if let Some(o) = outcomes
            .iter()
            .find(|o| o.status == Status::Abort && !o.detail.starts_with("interrupted"))
        {
            self.aborted = Some(o.detail.clone());
        }
        let window: Vec<Sample> = self
            .samples
            .lock()
            .unwrap_or_else(|e| e.into_inner())
            .iter()
            .filter(|s| s.t >= t0)
            .cloned()
            .collect();
        let loads_cpu = parts.iter().any(|p| matches!(p, Part::Cpu(_) | Part::Memory(_)));
        let (row_max_temp, thermal) = thermal_warnings(&window, &self.info, loads_cpu);
        warnings.extend(thermal);
        let mut result = combine(row, outcomes, warnings, secs, row_max_temp);
        result.warnings.retain(|w| {
            let key = w
                .split_once(": ")
                .filter(|(role, _)| matches!(*role, "cpu" | "memory" | "gpu"))
                .map_or(w.as_str(), |(_, rest)| rest);
            self.warned.insert(key.to_string())
        });
        result
    }
}

fn combine(
    row: &Row,
    outcomes: Vec<PartOutcome>,
    mut warnings: Vec<String>,
    secs: f64,
    max_temp: Option<f32>,
) -> RowResult {
    let status = outcomes.iter().map(|o| o.status).max().unwrap_or(Status::Skip);
    let single = outcomes.len() == 1;
    let label = |o: &PartOutcome, text: &str| {
        if single {
            text.to_string()
        } else {
            format!("{}: {text}", o.role)
        }
    };
    let detail = outcomes
        .iter()
        .map(|o| label(o, &o.detail))
        .collect::<Vec<_>>()
        .join("; ");
    let errors = outcomes.iter().map(|o| o.errors).sum();
    let samples = outcomes
        .iter()
        .flat_map(|o| o.samples.iter().map(move |s| label(o, s)))
        .collect();
    for o in &outcomes {
        warnings.extend(o.warnings.iter().map(|w| label(o, w)));
    }
    RowResult {
        name: row.name.clone(),
        status,
        secs,
        detail,
        errors,
        samples,
        warnings,
        max_temp,
    }
}

/// The hottest reading of the row, every trip point it crossed, and how much of it the
/// loaded cores spent clocked well below their own peak.
fn thermal_warnings(window: &[Sample], info: &SensorInfo, loads_cpu: bool) -> (Option<f32>, Vec<String>) {
    let max_temp = window.iter().filter_map(Sample::max_temp).reduce(f32::max);
    let mut warnings = Vec::new();
    let mut crossed: Vec<(usize, &str, f32, f32)> = Vec::new();
    for trip in &info.trips {
        let peak = window
            .iter()
            .filter_map(|s| s.temps.get(trip.sensor).copied().flatten())
            .reduce(f32::max);
        if let Some(peak) = peak
            && peak >= trip.celsius
        {
            crossed.retain(|c| c.0 != trip.sensor || c.3 > trip.celsius);
            if !crossed.iter().any(|c| c.0 == trip.sensor) {
                crossed.push((trip.sensor, &trip.kind, peak, trip.celsius));
            }
        }
    }
    for (sensor, kind, peak, limit) in crossed {
        let name = info.temp_names.get(sensor).map_or("sensor", String::as_str);
        warnings.push(format!("{name} reached {peak:.0}°C ({kind} trip point {limit:.0}°C)"));
    }
    if loads_cpu && window.len() >= 3 {
        let averages: Vec<f32> = window
            .iter()
            .filter_map(|s| {
                let busy: Vec<f32> = s
                    .freq_mhz
                    .iter()
                    .zip(&s.load)
                    .filter(|(f, l)| **f > 0 && **l > 80.0)
                    .map(|(f, _)| *f as f32)
                    .collect();
                (!busy.is_empty()).then(|| busy.iter().sum::<f32>() / busy.len() as f32)
            })
            .collect();
        if let Some(peak) = averages.iter().copied().reduce(f32::max) {
            let low = averages.iter().filter(|&&a| a < peak * THROTTLE_RATIO).count();
            let share = low as f32 * 100.0 / averages.len() as f32;
            if share >= 10.0 {
                warnings.push(format!(
                    "clock below {:.0}% of its peak ({peak:.0} MHz) for {share:.0}% of the time - throttled",
                    THROTTLE_RATIO * 100.0
                ));
            }
        }
    }
    (max_temp, warnings)
}

fn row_finding(result: &RowResult, step: Option<hodow_common::StepId>) -> hodow_common::Finding {
    use hodow_common::Verdict;
    let verdict = match result.status {
        Status::Ok | Status::Warn => Verdict::Passed,
        Status::Skip => Verdict::Skipped,
        Status::Error | Status::Abort => Verdict::Failed,
        Status::Crash => Verdict::Crashed,
        Status::Hang => Verdict::TimedOut,
    };
    let mut parts = Vec::new();
    if !result.detail.is_empty() {
        parts.push(result.detail.clone());
    }
    if result.errors > 0 {
        parts.push(format!("{} error(s)", result.errors));
    }
    parts.extend(result.samples.iter().take(3).cloned());
    let mut finding = hodow_common::Finding::new(result.name.clone(), verdict);
    finding.step = step;
    if !parts.is_empty() {
        finding = finding.detail(parts.join("; "));
    }
    match result.max_temp {
        Some(t) => finding.value(format!("max {t:.1} C")),
        None => finding,
    }
}

//! What a run means: rows grouped by what they compute, the best of each backend family
//! side by side, a CPU-or-GPU verdict per task, and what looks wrong. Rendered for the
//! terminal and as Markdown here, as HTML in `html.rs`.

use std::collections::BTreeMap;
use std::fmt::Write as _;

use hodow_bench::bench::spec::{Backend, RowStatus, Stats, Strategy, Task, short_lib, strategy_name};

use super::results::{Results, Row};

/// GPU at most this fraction of the CPU's time counts as faster, at least its inverse as slower.
pub const VERDICT_MARGIN: f64 = 0.9;
/// One frame at the camera's 60 fps.
pub const FRAME_BUDGET_MS: f64 = 1000.0 / 60.0;
const LIB_DIFFERENCE: f64 = 1.2;
const THROTTLE_RATIO: f64 = 0.85;

pub fn fmt_ms(v: f64) -> String {
    match v {
        v if v < 1.0 => format!("{v:.3}"),
        v if v < 10.0 => format!("{v:.2}"),
        v if v < 100.0 => format!("{v:.1}"),
        v => format!("{v:.0}"),
    }
}

pub struct Group<'a> {
    pub name: String,
    pub task: Task,
    pub sweep: bool,
    /// Fastest first; rows without a time last.
    pub rows: Vec<&'a Row>,
}

impl Group<'_> {
    fn spec_stream(&self) -> bool {
        self.rows.first().is_some_and(|r| r.spec.stream)
    }

    pub fn best(&self, gpu: bool) -> Option<&Row> {
        self.rows
            .iter()
            .copied()
            .filter(|r| r.spec.backend.is_gpu() == gpu && r.result.status == RowStatus::Ok)
            .find(|r| r.result.total_ms().is_some())
    }

    pub fn range(&self) -> Option<(f64, f64)> {
        let times: Vec<f64> = self.rows.iter().filter_map(|r| r.result.total_ms()).collect();
        Some((
            times.iter().copied().reduce(f64::min)?,
            times.iter().copied().reduce(f64::max)?,
        ))
    }
}

fn order_key(task: &Task) -> (u8, u64, u32) {
    let (w, h) = task.size().unwrap_or((0, 0));
    let rank = match task {
        Task::Eye { .. } => 0,
        Task::Pipeline { .. } => 1,
        Task::Debayer { .. } => 2,
        Task::Blur { .. } => 3,
        Task::Morph { .. } => 4,
        Task::Sobel { .. } => 5,
        Task::Histogram { .. } => 6,
        Task::Moments { .. } => 7,
        Task::Gemm { .. } => 8,
        Task::Reduce { .. } => 9,
        Task::Mandelbrot { .. } => 10,
        Task::Alu { .. } => 11,
        Task::Sort { .. } => 12,
        Task::Cnn { .. } => 13,
        Task::Upload { .. } => 14,
        Task::Download { .. } => 15,
        Task::Copy { .. } => 16,
        Task::Dispatch => 17,
    };
    (
        rank,
        u64::from(w) * u64::from(h) + task.bytes().unwrap_or(0) + task.ops().unwrap_or(0),
        task.radius().unwrap_or(0),
    )
}

pub fn groups(results: &Results) -> Vec<Group<'_>> {
    let mut map: BTreeMap<(bool, (u8, u64, u32), bool, String), Group> = BTreeMap::new();
    for row in &results.rows {
        let name = row.spec.group();
        map.entry((row.spec.sweep, order_key(&row.spec.task), row.spec.stream, name.clone()))
            .or_insert_with(|| Group {
                name,
                task: row.spec.task,
                sweep: row.spec.sweep,
                rows: Vec::new(),
            })
            .rows
            .push(row);
    }
    let mut groups: Vec<Group> = map.into_values().collect();
    for g in &mut groups {
        g.rows.sort_by(|a, b| match (a.result.total_ms(), b.result.total_ms()) {
            (Some(x), Some(y)) => x.total_cmp(&y),
            (Some(_), None) => std::cmp::Ordering::Less,
            (None, Some(_)) => std::cmp::Ordering::Greater,
            (None, None) => std::cmp::Ordering::Equal,
        });
    }
    groups
}

/// Best time per backend family, one line per radius, for every task kind and size that
/// has a radius - the shape of the colleague's table.
pub struct Matrix {
    pub title: String,
    pub families: Vec<String>,
    pub lines: Vec<(String, Vec<Option<(f64, String)>>)>,
}

pub fn matrices(results: &Results) -> Vec<Matrix> {
    let mut by_title: BTreeMap<(u8, u64, String), Vec<&Row>> = BTreeMap::new();
    for row in results.rows.iter().filter(|r| !r.spec.sweep && !r.spec.stream) {
        let (Some(_), Some((w, h))) = (row.spec.task.radius(), row.spec.task.size()) else {
            continue;
        };
        let title = match row.spec.task {
            Task::Pipeline { .. } => format!("pipeline {w}x{h} -> {}x{} NV12", w / 2, h / 2),
            _ => format!("blur {w}x{h}"),
        };
        by_title
            .entry((order_key(&row.spec.task).0, u64::from(w) * u64::from(h), title))
            .or_default()
            .push(row);
    }
    by_title
        .into_iter()
        .map(|((_, _, title), rows)| {
            let mut families: Vec<String> = Vec::new();
            for r in &rows {
                let f = r.spec.backend.family();
                if !families.contains(&f) {
                    families.push(f);
                }
            }
            let mut radii: Vec<u32> = rows.iter().filter_map(|r| r.spec.task.radius()).collect();
            radii.sort_unstable();
            radii.dedup();
            let lines = radii
                .into_iter()
                .map(|radius| {
                    let cells = families
                        .iter()
                        .map(|f| {
                            rows.iter()
                                .filter(|r| {
                                    r.spec.task.radius() == Some(radius)
                                        && &r.spec.backend.family() == f
                                        && r.result.status == RowStatus::Ok
                                })
                                .filter_map(|r| Some((r.result.total_ms()?, r.spec.backend.to_string())))
                                .min_by(|a, b| a.0.total_cmp(&b.0))
                        })
                        .collect();
                    (format!("r={radius}"), cells)
                })
                .collect();
            Matrix { title, families, lines }
        })
        .collect()
}

pub struct Decision<'a> {
    pub group: String,
    pub cpu: Option<&'a Row>,
    pub gpu: Option<&'a Row>,
    pub verdict: &'static str,
    pub ratio: Option<f64>,
    /// For a camera pipeline: whether the fastest of everything fits one 60 fps frame.
    pub fits_frame: Option<bool>,
}

pub fn decisions<'a>(groups: &'a [Group<'a>]) -> Vec<Decision<'a>> {
    groups
        .iter()
        .filter(|g| {
            !g.sweep
                && !matches!(
                    g.task,
                    Task::Upload { .. } | Task::Download { .. } | Task::Copy { .. } | Task::Dispatch
                )
        })
        .map(|g| {
            let cpu = g.best(false);
            let gpu = g.best(true);
            let times = (
                cpu.and_then(|r| r.result.total_ms()),
                gpu.and_then(|r| r.result.total_ms()),
            );
            let ratio = match times {
                (Some(c), Some(x)) => Some(x / c),
                _ => None,
            };
            let verdict = match (times, ratio) {
                (_, Some(r)) if r <= VERDICT_MARGIN => "GPU",
                (_, Some(r)) if r >= 1.0 / VERDICT_MARGIN => "CPU",
                (_, Some(_)) => "tie - GPU frees the CPU",
                ((Some(_), None), _) => "CPU (no GPU result)",
                ((None, Some(_)), _) => "GPU (no CPU result)",
                _ => "no result",
            };
            let best = [times.0, times.1].into_iter().flatten().reduce(f64::min);
            Decision {
                group: g.name.clone(),
                cpu,
                gpu,
                verdict,
                ratio,
                fits_frame: matches!(g.task, Task::Pipeline { .. } | Task::Eye { .. })
                    .then(|| best.is_some_and(|b| b <= FRAME_BUDGET_MS)),
            }
        })
        .collect()
}

/// CPU time per frame and what share of one core that is over the frame's wall time.
pub fn cpu_load(row: &Row) -> String {
    match (row.result.timings.cpu, row.result.total_ms()) {
        (Some(cpu), Some(total)) if total > 0.0 => {
            format!("{} ({:.0}%)", fmt_ms(cpu.median), cpu.median / total * 100.0)
        }
        _ => "-".into(),
    }
}

pub fn breakdown(row: &Row) -> String {
    let t = &row.result.timings;
    if row.spec.stream {
        return "pipelined".into();
    }
    let part = |s: Option<Stats>| s.map_or("-".into(), |s| fmt_ms(s.median));
    if row.spec.backend.is_gpu() {
        format!("{} + {} + {}", part(t.upload), part(t.compute), part(t.download))
    } else {
        part(t.compute)
    }
}

/// Rates: arithmetic per second for the compute kernels' best row per backend family,
/// GB/s for transfers and copies, microseconds for a dispatch.
pub fn micro_rows(results: &Results) -> Vec<(String, String, String)> {
    let mut out = Vec::new();
    for g in groups(results)
        .iter()
        .filter(|g| g.task.ops().is_some() && !g.sweep && !g.spec_stream())
    {
        let mut seen = Vec::new();
        for r in &g.rows {
            let family = r.spec.backend.family();
            if seen.contains(&family) {
                continue;
            }
            if let Some(ms) = r.result.total_ms() {
                seen.push(family);
                let rate = g.task.ops().unwrap_or(0) as f64 / ms / 1e6;
                out.push((
                    g.name.clone(),
                    r.spec.backend.to_string(),
                    format!("{rate:.2} GOP/s  ({} ms, with transfers)", fmt_ms(ms)),
                ));
            }
        }
    }
    let mut rows: Vec<&Row> = results
        .rows
        .iter()
        .filter(|r| {
            matches!(
                r.spec.task,
                Task::Upload { .. } | Task::Download { .. } | Task::Copy { .. } | Task::Dispatch
            )
        })
        .collect();
    rows.sort_by_key(|r| order_key(&r.spec.task));
    out.extend(rows.into_iter().map(|r| {
        let value = match (r.result.total_ms(), r.spec.task) {
            (None, _) => format!("{:?}", r.result.status),
            (Some(ms), Task::Dispatch) => format!("{:.0} us", ms * 1000.0),
            (Some(ms), task) => format!(
                "{:.2} GB/s  ({} ms)",
                task.bytes().unwrap_or(0) as f64 / ms / 1e6,
                fmt_ms(ms)
            ),
        };
        let backend = match &r.spec.backend {
            Backend::OpenCl { lib, strategy, .. } if !matches!(r.spec.task, Task::Dispatch | Task::Copy { .. }) => {
                format!("opencl{} {}", short_lib(lib), strategy_name(*strategy))
            }
            Backend::OpenCl { lib, .. } => format!("opencl{}", short_lib(lib)),
            Backend::Gles { strategy, .. } | Backend::Vulkan { strategy, .. }
                if !matches!(r.spec.task, Task::Dispatch | Task::Copy { .. }) =>
            {
                format!("{} {}", r.spec.backend.family(), strategy_name(*strategy))
            }
            Backend::Gles { .. } | Backend::Vulkan { .. } => r.spec.backend.family(),
            b => b.to_string(),
        };
        (r.spec.task.to_string(), backend, value)
    }));
    out
}

pub fn anomalies(results: &Results, groups: &[Group]) -> Vec<String> {
    let mut out = Vec::new();
    // One line per distinct failure, however many rows it took down.
    let mut failures: BTreeMap<(String, String), Vec<&Row>> = BTreeMap::new();
    for row in results
        .rows
        .iter()
        .filter(|r| !matches!(r.result.status, RowStatus::Ok | RowStatus::Unsupported))
    {
        failures
            .entry((format!("{:?}", row.result.status), row.result.detail.clone()))
            .or_default()
            .push(row);
    }
    for ((status, detail), rows) in failures {
        let more = if rows.len() > 1 {
            format!(" and {} more", rows.len() - 1)
        } else {
            String::new()
        };
        out.push(format!(
            "{status}: {} - {}{more}: {detail}",
            rows[0].spec.group(),
            rows[0].spec.backend
        ));
    }
    for g in groups.iter().filter(|g| !g.sweep && g.task.size().is_some()) {
        if let Some(best) = g.best(true) {
            let t = &best.result.timings;
            if let (Some(up), Some(c), Some(down)) = (t.upload, t.compute, t.download) {
                let transfer = up.median + down.median;
                if transfer > c.median && transfer > 0.5 {
                    out.push(format!(
                        "{}: transfers take {} ms of the best GPU row's {} ms ({})",
                        g.name,
                        fmt_ms(transfer),
                        fmt_ms(transfer + c.median),
                        best.spec.backend
                    ));
                }
            }
            if let (Some(c), Some(gpu)) = (t.compute, t.gpu)
                && c.median > 2.0 * gpu.median
                && c.median - gpu.median > 0.5
            {
                out.push(format!(
                    "{}: the host waits {} ms for {} ms of kernel time ({}) - driver overhead",
                    g.name,
                    fmt_ms(c.median),
                    fmt_ms(gpu.median),
                    best.spec.backend
                ));
            }
        }
    }
    // The same rows on two OpenCL libraries, and other transfer strategies against plain
    // copies: one line per pair, not per row.
    let mut by_config: BTreeMap<String, Vec<&Row>> = BTreeMap::new();
    for row in &results.rows {
        if let Backend::OpenCl { lib, .. } = &row.spec.backend {
            by_config
                .entry(row.spec.id().replace(short_lib(lib), ""))
                .or_default()
                .push(row);
        }
    }
    let mut lib_ratios: BTreeMap<(String, String), Vec<(f64, String)>> = BTreeMap::new();
    for rows in by_config.values().filter(|r| r.len() > 1) {
        let times: Vec<(f64, &Row)> = rows.iter().filter_map(|r| Some((r.result.total_ms()?, *r))).collect();
        let (Some(fast), Some(slow)) = (
            times.iter().min_by(|a, b| a.0.total_cmp(&b.0)),
            times.iter().max_by(|a, b| a.0.total_cmp(&b.0)),
        ) else {
            continue;
        };
        lib_ratios
            .entry((slow.1.spec.backend.family(), fast.1.spec.backend.family()))
            .or_default()
            .push((slow.0 / fast.0, slow.1.spec.id()));
    }
    for ((slow, fast), ratios) in lib_ratios {
        summarize_ratios(&mut out, &format!("{slow} is slower than {fast}"), ratios);
    }
    let mut strategy_ratios: BTreeMap<String, Vec<(f64, String)>> = BTreeMap::new();
    for g in groups {
        for row in &g.rows {
            let Backend::OpenCl {
                lib,
                variant,
                strategy,
                local,
            } = &row.spec.backend
            else {
                continue;
            };
            if *strategy == Strategy::Copy {
                continue;
            }
            let copy = g.rows.iter().find(|r| {
                matches!(&r.spec.backend, Backend::OpenCl { lib: l, variant: v, strategy: Strategy::Copy, local: lc } if l == lib && v == variant && lc == local)
            });
            if let (Some(t), Some(c)) = (row.result.total_ms(), copy.and_then(|c| c.result.total_ms())) {
                strategy_ratios
                    .entry(strategy_name(*strategy).to_string())
                    .or_default()
                    .push((t / c, row.spec.id()));
            }
        }
    }
    for (strategy, ratios) in strategy_ratios {
        summarize_ratios(&mut out, &format!("{strategy} is slower than copy"), ratios);
    }
    for row in results.rows.iter().filter(|r| r.spec.soak) {
        if let Some((first, last)) = soak_trend(&row.result)
            && last > first * 1.1
        {
            let temps = match (row.env.start_temp, row.env.max_temp) {
                (Some(a), Some(b)) => format!(", {a:.0} -> {b:.0}°C"),
                _ => String::new(),
            };
            out.push(format!(
                "{}: frame time grew {:.0}% over the soak ({} -> {} ms{temps})",
                row.spec.id(),
                (last / first - 1.0) * 100.0,
                fmt_ms(first),
                fmt_ms(last)
            ));
        }
    }
    // Only rows that keep the CPU busy say anything: during a GPU row an idle governor parks it low.
    let cpu_rows: Vec<&Row> = results
        .rows
        .iter()
        .filter(|r| !r.spec.backend.is_gpu() && r.spec.task != Task::Dispatch)
        .collect();
    let peak = cpu_rows.iter().filter_map(|r| r.env.cpu_mhz_max).max();
    if let Some(peak) = peak {
        let throttled: Vec<&&Row> = cpu_rows
            .iter()
            .filter(|r| {
                r.env
                    .cpu_mhz_min
                    .is_some_and(|m| (m as f64) < peak as f64 * THROTTLE_RATIO)
            })
            .collect();
        if !throttled.is_empty() {
            let lowest = throttled.iter().filter_map(|r| r.env.cpu_mhz_min).min().unwrap_or(0);
            let governor = results
                .governor
                .as_deref()
                .map_or_default(|g| format!(", cpufreq governor `{g}`"));
            out.push(format!("CPU clock fell below {:.0}% of its {peak} MHz peak during {} of {} CPU rows (lowest {lowest} MHz{governor})", THROTTLE_RATIO * 100.0, throttled.len(), cpu_rows.len()));
        }
    }
    out
}

/// One line for a comparison that holds over many rows: how often B was over the margin
/// slower than A, the median ratio over those, and the worst.
fn summarize_ratios(out: &mut Vec<String>, what: &str, ratios: Vec<(f64, String)>) {
    let total = ratios.len();
    let mut slower: Vec<(f64, String)> = ratios.into_iter().filter(|(r, _)| *r > LIB_DIFFERENCE).collect();
    if slower.is_empty() {
        return;
    }
    slower.sort_by(|a, b| a.0.total_cmp(&b.0));
    let median = slower[slower.len() / 2].0;
    let (worst, id) = slower.last().expect("not empty");
    out.push(format!(
        "{what} by over {:.0}% in {} of {total} rows (median {median:.2}x, worst {worst:.2}x: {id})",
        (LIB_DIFFERENCE - 1.0) * 100.0,
        slower.len()
    ));
}

/// Median frame time of the first and the last tenth of a soak.
pub fn soak_trend(result: &hodow_bench::bench::spec::RowResult) -> Option<(f64, f64)> {
    let times: Vec<f64> = result.frames.iter().map(|f| f64::from(f[1])).collect();
    let tenth = (times.len() / 10).max(1);
    if times.len() < 3 {
        return None;
    }
    Some((
        Stats::of(&times[..tenth])?.median,
        Stats::of(&times[times.len() - tenth..])?.median,
    ))
}

pub fn notes() -> Vec<String> {
    vec![
        "Times are medians per frame in ms, from input in CPU memory to the result back in CPU memory; GPU breakdown is upload + compute + download.".to_string(),
        format!("Verdict: GPU when its best is at most {:.0}% of the best CPU time, CPU when it is at least {:.0}%, a tie in between - where the GPU still frees the CPU's cores.", VERDICT_MARGIN * 100.0, 100.0 / VERDICT_MARGIN),
        "Integer kernels must match the CPU reference bit for bit; the f32/f16 variants may differ by 1.".to_string(),
        "TFLite rows (CPU kernels, and the NPU through the VX delegate) run models written by the bench itself; their blur pads with zeros and requantizes after each pass, so they are checked against TFLite's own CPU kernels, the NPU within 1.".to_string(),
        "(stream) rows are throughput: batches of frames with nothing waited for in between, ms per frame. A CPU stream gives each core whole frames instead of splitting every frame across them.".to_string(),
        "OpenCL pipelines debayer with the vector kernel at the blur variant's width (four for a non-vector blur, at most eight), except naive (one pixel per work-item) and image (straight into an image).".to_string(),
        "GLES and Vulkan run the same WGSL kernels (naga: SPIR-V for Vulkan, GLSL ES 3.10 for the GLES driver to compile) over pixels packed four to a 32-bit word, so an invocation always produces at least four pixels; their vecN is N pixels per invocation. GLES reads results back by mapping in every strategy - it has no glGetBufferSubData.".to_string(),
    ]
}

/// Position of `v` between `min` and `max` on a log scale, 0 = best.
pub fn heat(v: f64, min: f64, max: f64) -> f64 {
    if max <= min * 1.0001 || v <= 0.0 {
        0.0
    } else {
        ((v.ln() - min.ln()) / (max.ln() - min.ln())).clamp(0.0, 1.0)
    }
}

// ── terminal ────────────────────────────────────────────────────────────────

pub struct Term {
    pub color: bool,
}

impl Term {
    fn paint(&self, code: &str, text: &str) -> String {
        if self.color {
            format!("\x1b[{code}m{text}\x1b[0m")
        } else {
            text.to_string()
        }
    }

    fn heat(&self, text: &str, t: f64) -> String {
        let code = match t {
            t if t <= 0.0 => "1;32",
            t if t < 0.34 => "32",
            t if t < 0.67 => "33",
            _ => "31",
        };
        self.paint(code, text)
    }

    pub fn summary(&self, results: &Results) -> String {
        let groups = groups(results);
        let mut s = String::new();
        for m in matrices(results) {
            let _ = writeln!(
                s,
                "\n{}",
                self.paint("1", &format!("== best per backend: {} (ms per frame)", m.title))
            );
            let _ = write!(s, "{:<6}", "");
            for f in &m.families {
                let _ = write!(s, "{f:>17}");
            }
            s.push('\n');
            for (label, cells) in &m.lines {
                let times: Vec<f64> = cells.iter().flatten().map(|c| c.0).collect();
                let (min, max) = (
                    times.iter().copied().fold(f64::MAX, f64::min),
                    times.iter().copied().fold(0.0, f64::max),
                );
                let _ = write!(s, "{label:<6}");
                for cell in cells {
                    match cell {
                        Some((ms, _)) => {
                            let _ = write!(s, "{}", self.heat(&format!("{:>17}", fmt_ms(*ms)), heat(*ms, min, max)));
                        }
                        None => {
                            let _ = write!(s, "{:>17}", "-");
                        }
                    }
                }
                s.push('\n');
            }
        }
        let decisions = decisions(&groups);
        if !decisions.is_empty() {
            let _ = writeln!(s, "\n{}", self.paint("1", "== CPU or GPU"));
            for d in &decisions {
                let cpu = d
                    .cpu
                    .and_then(|r| Some(format!("{} {}", fmt_ms(r.result.total_ms()?), r.spec.backend)))
                    .unwrap_or_else(|| "-".into());
                let gpu = d
                    .gpu
                    .and_then(|r| {
                        Some(format!(
                            "{} ({}) {}, CPU {}",
                            fmt_ms(r.result.total_ms()?),
                            breakdown(r),
                            r.spec.backend,
                            cpu_load(r)
                        ))
                    })
                    .unwrap_or_else(|| "-".into());
                let verdict = match d.verdict {
                    "GPU" => self.paint("1;32", d.verdict),
                    "CPU" => self.paint("1;33", d.verdict),
                    v => self.paint("1", v),
                };
                let ratio = d.ratio.map_or_default(|r| format!(" GPU/CPU {r:.2}"));
                let frame = match d.fits_frame {
                    Some(true) => " | fits 60 fps".to_string(),
                    Some(false) => self.paint("31", " | over 16.7 ms"),
                    None => String::new(),
                };
                let _ = writeln!(
                    s,
                    "{:<44} {verdict}{ratio}{frame}\n    CPU     {cpu}\n    GPU/NPU {gpu}",
                    d.group
                );
            }
        }
        let micro = micro_rows(results);
        if !micro.is_empty() {
            let _ = writeln!(s, "\n{}", self.paint("1", "== transfers and overheads"));
            for (task, backend, value) in micro {
                let _ = writeln!(s, "{task:<18} {backend:<30} {value}");
            }
        }
        let anomalies = anomalies(results, &groups);
        if !anomalies.is_empty() {
            let _ = writeln!(s, "\n{}", self.paint("1", "== worth a look"));
            for a in anomalies {
                let _ = writeln!(s, "  - {a}");
            }
        }
        s
    }
}

// ── markdown ────────────────────────────────────────────────────────────────

pub fn markdown(results: &Results) -> String {
    let groups = groups(results);
    let mut s = String::new();
    let _ = writeln!(s, "# hodow bench - {}\n", results.label());
    let _ = writeln!(s, "{}\n", results.host);
    let _ = writeln!(
        s,
        "Profile `{}`, {} rows in {:.0} s, {} CPU threads, SIMD: {}.\n",
        results.profile,
        results.rows.len(),
        results.secs,
        results.threads,
        results.simd.as_deref().unwrap_or("none")
    );
    for d in &results.devices {
        let _ = writeln!(
            s,
            "- `{}`: {} / {} ({}), {}, driver {}, {} CU, work-group up to {}, local {} KB, image support {}, unified memory {}",
            d.lib,
            d.platform,
            d.device,
            d.device_version,
            d.platform_version,
            d.driver_version,
            d.compute_units,
            d.max_work_group,
            d.local_mem_kb,
            d.image_support,
            d.unified_memory
        );
    }
    for (api, label) in [("GLES", &results.gles), ("Vulkan", &results.vulkan)] {
        if let Some(label) = label {
            let _ = writeln!(s, "- {api}: {label}");
        }
    }
    for cmd in &results.background {
        let _ = writeln!(s, "- running in the background: `{cmd}`");
    }
    for n in &results.notes {
        let _ = writeln!(s, "- {n}");
    }
    let _ = writeln!(s);
    for n in notes() {
        let _ = writeln!(s, "> {n}\n");
    }

    let decisions = decisions(&groups);
    if !decisions.is_empty() {
        let _ = writeln!(s, "## CPU or GPU\n");
        let _ = writeln!(
            s,
            "| task | best CPU (ms) | best GPU/NPU (ms, up + compute + down) | GPU/CPU | verdict | 60 fps |"
        );
        let _ = writeln!(s, "|---|---|---|---|---|---|");
        for d in &decisions {
            let cpu = d
                .cpu
                .and_then(|r| Some(format!("{} `{}`", fmt_ms(r.result.total_ms()?), r.spec.backend)))
                .unwrap_or_else(|| "-".into());
            let gpu = d
                .gpu
                .and_then(|r| {
                    Some(format!(
                        "{} ({}) `{}`, CPU {}",
                        fmt_ms(r.result.total_ms()?),
                        breakdown(r),
                        r.spec.backend,
                        cpu_load(r)
                    ))
                })
                .unwrap_or_else(|| "-".into());
            let ratio = d.ratio.map_or_else(|| "-".into(), |r| format!("{r:.2}"));
            let frame = match d.fits_frame {
                Some(true) => "yes",
                Some(false) => "**no**",
                None => "",
            };
            let _ = writeln!(
                s,
                "| {} | {cpu} | {gpu} | {ratio} | **{}** | {frame} |",
                d.group, d.verdict
            );
        }
        let _ = writeln!(s);
    }
    for m in matrices(results) {
        let _ = writeln!(s, "## Best per backend: {}\n", m.title);
        let _ = writeln!(s, "| radius | {} |", m.families.join(" | "));
        let _ = writeln!(s, "|---|{}", "---|".repeat(m.families.len()));
        for (label, cells) in &m.lines {
            let times: Vec<f64> = cells.iter().flatten().map(|c| c.0).collect();
            let min = times.iter().copied().fold(f64::MAX, f64::min);
            let cells: Vec<String> = cells
                .iter()
                .map(|c| {
                    c.as_ref().map_or("-".into(), |(ms, _)| {
                        if *ms <= min {
                            format!("**{}**", fmt_ms(*ms))
                        } else {
                            fmt_ms(*ms)
                        }
                    })
                })
                .collect();
            let _ = writeln!(s, "| {label} | {} |", cells.join(" | "));
        }
        let _ = writeln!(s);
    }
    let soaks: Vec<&Row> = results.rows.iter().filter(|r| r.spec.soak).collect();
    if !soaks.is_empty() {
        let _ = writeln!(
            s,
            "## Soak\n\n| task | backend | first 10% | last 10% | change | temperature |\n|---|---|---|---|---|---|"
        );
        for r in soaks {
            let (first, last) = soak_trend(&r.result).unwrap_or((0.0, 0.0));
            let temps = match (r.env.start_temp, r.env.max_temp) {
                (Some(a), Some(b)) => format!("{a:.0} -> {b:.0} °C"),
                _ => "-".into(),
            };
            let change = if first > 0.0 {
                format!("{:+.0}%", (last / first - 1.0) * 100.0)
            } else {
                "-".into()
            };
            let _ = writeln!(
                s,
                "| {} | {} | {} ms | {} ms | {change} | {temps} |",
                r.spec.group(),
                r.spec.backend,
                fmt_ms(first),
                fmt_ms(last)
            );
        }
        let _ = writeln!(s);
    }
    let micro = micro_rows(results);
    if !micro.is_empty() {
        let _ = writeln!(
            s,
            "## Transfers and overheads\n\n| task | backend | result |\n|---|---|---|"
        );
        for (task, backend, value) in micro {
            let _ = writeln!(s, "| {task} | {backend} | {value} |");
        }
        let _ = writeln!(s);
    }
    let anomalies = anomalies(results, &groups);
    if !anomalies.is_empty() {
        let _ = writeln!(s, "## Worth a look\n");
        for a in anomalies {
            let _ = writeln!(s, "- {a}");
        }
        let _ = writeln!(s);
    }
    let _ = writeln!(s, "## Every row\n");
    for g in &groups {
        let _ = writeln!(s, "### {}\n", g.name);
        let _ = writeln!(
            s,
            "| backend | total | p95 | upload | compute | download | gpu | cpu | setup | first | reps | status |"
        );
        let _ = writeln!(s, "|---|---|---|---|---|---|---|---|---|---|---|---|");
        for r in &g.rows {
            let t = &r.result.timings;
            let m = |s: Option<Stats>| s.map_or("-".into(), |s| fmt_ms(s.median));
            let status = match r.result.status {
                RowStatus::Ok => {
                    let mut status = r
                        .result
                        .max_error
                        .map_or("ok".into(), |e| format!("ok (max error {e})"));
                    if !r.result.detail.is_empty() {
                        status.push_str(&format!(" - {}", r.result.detail));
                    }
                    status
                }
                other => format!("{other:?}: {}", r.result.detail),
            };
            let _ = writeln!(
                s,
                "| {} | {} | {} | {} | {} | {} | {} | {} | {} | {} | {} | {} |",
                r.spec.backend,
                m(t.total),
                t.total.map_or("-".into(), |s| fmt_ms(s.p95)),
                m(t.upload),
                m(t.compute),
                m(t.download),
                m(t.gpu),
                cpu_load(r),
                r.result.setup_ms.map_or("-".into(), fmt_ms),
                r.result.first_frame_ms.map_or("-".into(), fmt_ms),
                r.result.reps,
                status.replace('|', "/")
            );
        }
        let _ = writeln!(s);
    }
    s
}

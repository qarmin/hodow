//! `report.html` and `compare.html`: one self-contained page each, no external files.
//! Every set of rows that compute the same thing is coloured on its own, green for the
//! fastest through yellow to red for the slowest, on a log scale so that "twice as slow"
//! is the same step of colour at 2 ms as at 200 ms. The number is always in the cell;
//! the colour only helps find it.

use std::fmt::Write as _;

use hodow_bench::bench::spec::{RowStatus, Stats};

use super::report::{
    Group, anomalies, breakdown, cpu_load, decisions, fmt_ms, groups, heat, matrices, micro_rows, notes,
};
use super::results::{Results, Row};

const STYLE: &str = r#"
:root { color-scheme: dark; }
body { font: 14px/1.4 system-ui, sans-serif; margin: 0 2em 4em; color: #d6dae2; background: #15181d; }
a { color: #8ab4f8; }
h1 { font-size: 1.5em; margin: 1em 0 .2em; } h2 { margin-top: 2em; border-bottom: 1px solid #333944; } h3 { margin: 1.5em 0 .4em; font-size: 1.05em; }
code { color: #e6c07b; }
.meta { color: #9aa3b0; font-size: .9em; } .note { color: #9aa3b0; font-size: .88em; margin: .2em 0; }
table { border-collapse: collapse; margin: .4em 0 1em; background: #1c2027; }
th, td { border: 1px solid #2e343e; padding: 3px 8px; text-align: right; white-space: nowrap; }
th { background: #252a33; color: #e2e6ec; cursor: pointer; user-select: none; position: sticky; top: 0; }
td.l, th.l { text-align: left; }
td.na { background: #23262c; color: #6c7380; text-align: center; }
td.err { background: #2b2f37; color: #c3c8d1; text-align: left; white-space: normal; max-width: 40em; }
.bar { display: inline-flex; width: 160px; height: 10px; background: #2a2f38; vertical-align: middle; }
.bar span { display: block; height: 100%; } .up { background: #5b8fd6; } .cp { background: #e0a030; } .dn { background: #a67ee0; }
.legend span { display: inline-block; width: 10px; height: 10px; margin: 0 3px 0 10px; vertical-align: middle; }
#filter { font-size: 1em; padding: 4px 8px; width: 28em; margin: 1em 0; background: #1c2027; color: #d6dae2; border: 1px solid #3a414d; }
.verdict-GPU { font-weight: bold; color: #7ddc8f; } .verdict-CPU { font-weight: bold; color: #f0c060; }
.best::after { content: " \2605"; }
"#;

const SCRIPT: &str = r#"
document.querySelectorAll('table.sortable th').forEach((th, i) => th.addEventListener('click', () => {
  const body = th.closest('table').tBodies[0];
  const asc = th.dataset.asc !== '1'; th.dataset.asc = asc ? '1' : '0';
  const key = r => { const c = r.cells[i]; const v = c.dataset.v; return v !== undefined ? parseFloat(v) : c.textContent; };
  [...body.rows].sort((a, b) => { const x = key(a), y = key(b);
    const c = typeof x === 'number' && typeof y === 'number' ? x - y : String(x).localeCompare(String(y));
    return asc ? c : -c; }).forEach(r => body.appendChild(r));
}));
document.getElementById('filter').addEventListener('input', e => {
  const words = e.target.value.toLowerCase().split(/\s+/).filter(Boolean);
  document.querySelectorAll('section.group').forEach(s => {
    const text = s.dataset.name.toLowerCase(); let shown = 0;
    s.querySelectorAll('tbody tr').forEach(r => {
      const all = (text + ' ' + r.textContent).toLowerCase();
      const ok = words.every(w => all.includes(w)); r.style.display = ok ? '' : 'none'; if (ok) shown++; });
    s.style.display = shown ? '' : 'none';
  });
});
"#;

pub fn escape(s: &str) -> String {
    s.replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
        .replace('"', "&quot;")
}

/// Green (0) through yellow to red (1), dark enough for the light text on top.
pub fn heat_color(t: f64) -> String {
    format!(
        "hsl({:.0}, 55%, {:.0}%)",
        120.0 * (1.0 - t),
        24.0 + 4.0 * (1.0 - (2.0 * t - 1.0).abs())
    )
}

fn time_cell(ms: f64, min: f64, max: f64) -> String {
    let t = heat(ms, min, max);
    let best = if t <= 0.0 { " class=\"best\"" } else { "" };
    format!(
        "<td data-v=\"{ms}\" style=\"background:{}\"><span{best}>{}</span></td>",
        heat_color(t),
        fmt_ms(ms)
    )
}

pub fn page(title: &str, body: &str) -> String {
    format!(
        "<!DOCTYPE html>\n<html><head><meta charset=\"utf-8\"><title>{}</title><style>{STYLE}</style></head><body>\n{body}\n<script>{SCRIPT}</script></body></html>\n",
        escape(title)
    )
}

fn bar(row: &Row, scale: f64) -> String {
    let t = &row.result.timings;
    let part = |s: Option<Stats>, class: &str| {
        s.map_or(String::new(), |s| {
            format!(
                "<span class=\"{class}\" style=\"width:{:.1}%\"></span>",
                (s.median / scale * 100.0).min(100.0)
            )
        })
    };
    format!(
        "<span class=\"bar\" title=\"{}\">{}{}{}</span>",
        escape(&breakdown(row)),
        part(t.upload, "up"),
        part(t.compute, "cp"),
        part(t.download, "dn")
    )
}

fn group_section(g: &Group) -> String {
    let mut s = String::new();
    let (min, max) = g.range().unwrap_or((0.0, 0.0));
    let _ = writeln!(
        s,
        "<section class=\"group\" data-name=\"{0}\"><h3>{0}</h3>",
        escape(&g.name)
    );
    let _ = writeln!(
        s,
        "<table class=\"sortable\"><thead><tr><th class=\"l\">backend</th><th>total</th><th>p95</th><th class=\"l\">upload / compute / download</th><th>upload</th><th>compute</th><th>download</th><th>gpu</th><th>cpu</th><th>setup</th><th>first</th><th>reps</th><th class=\"l\">status</th></tr></thead><tbody>"
    );
    for r in &g.rows {
        let t = &r.result.timings;
        let m = |s: Option<Stats>| {
            s.map_or("<td class=\"na\">-</td>".to_string(), |s| {
                format!("<td data-v=\"{}\">{}</td>", s.median, fmt_ms(s.median))
            })
        };
        let _ = write!(s, "<tr><td class=\"l\">{}</td>", escape(&r.spec.backend.to_string()));
        match r.result.total_ms() {
            Some(ms) => {
                let _ = write!(
                    s,
                    "{}<td data-v=\"{}\">{}</td>",
                    time_cell(ms, min, max),
                    t.total.map_or(0.0, |s| s.p95),
                    t.total.map_or("-".into(), |s| fmt_ms(s.p95))
                );
            }
            None => s.push_str("<td class=\"na\">-</td><td class=\"na\">-</td>"),
        }
        let _ = write!(
            s,
            "<td class=\"l\">{}</td>",
            if r.result.total_ms().is_some() {
                bar(r, max)
            } else {
                String::new()
            }
        );
        let _ = write!(
            s,
            "{}{}{}{}<td data-v=\"{}\">{}</td>",
            m(t.upload),
            m(t.compute),
            m(t.download),
            m(t.gpu),
            t.cpu.map_or(0.0, |c| c.median),
            cpu_load(r)
        );
        let opt = |v: Option<f64>| {
            v.map_or("<td class=\"na\">-</td>".to_string(), |v| {
                format!("<td data-v=\"{v}\">{}</td>", fmt_ms(v))
            })
        };
        let _ = write!(
            s,
            "{}{}<td>{}</td>",
            opt(r.result.setup_ms),
            opt(r.result.first_frame_ms),
            r.result.reps
        );
        match r.result.status {
            RowStatus::Ok => {
                let note = if r.result.detail.is_empty() {
                    String::new()
                } else {
                    format!(" - {}", escape(&r.result.detail))
                };
                let _ = write!(
                    s,
                    "<td class=\"l\">ok{}{note}</td>",
                    r.result
                        .max_error
                        .map_or(String::new(), |e| format!(" (max error {e})"))
                );
            }
            other => {
                let _ = write!(s, "<td class=\"err\">{other:?}: {}</td>", escape(&r.result.detail));
            }
        }
        s.push_str("</tr>\n");
    }
    s.push_str("</tbody></table></section>\n");
    s
}

pub fn report(results: &Results) -> String {
    let groups = groups(results);
    let mut s = String::new();
    let _ = writeln!(
        s,
        "<h1>hodow bench - {}</h1><div class=\"meta\">{}</div>",
        escape(&results.label()),
        escape(&results.host)
    );
    let _ = writeln!(
        s,
        "<div class=\"meta\">profile <b>{}</b>, {} rows in {:.0} s, {} CPU threads, SIMD: {}</div><ul class=\"meta\">",
        results.profile,
        results.rows.len(),
        results.secs,
        results.threads,
        results.simd.as_deref().unwrap_or("none")
    );
    for d in &results.devices {
        let _ = writeln!(
            s,
            "<li><code>{}</code>: {} / {} ({}), driver {}, {} CU, work-group up to {}, local {} KB, images {}, unified memory {}</li>",
            escape(&d.lib),
            escape(&d.platform),
            escape(&d.device),
            escape(&d.device_version),
            escape(&d.driver_version),
            d.compute_units,
            d.max_work_group,
            d.local_mem_kb,
            d.image_support,
            d.unified_memory
        );
    }
    for (api, label) in [("GLES", &results.gles), ("Vulkan", &results.vulkan)] {
        if let Some(label) = label {
            let _ = writeln!(s, "<li>{api}: {}</li>", escape(label));
        }
    }
    for cmd in &results.background {
        let _ = writeln!(s, "<li>running in the background: <code>{}</code></li>", escape(cmd));
    }
    for n in &results.notes {
        let _ = writeln!(s, "<li>{}</li>", escape(n));
    }
    s.push_str("</ul>\n");
    for n in notes() {
        let _ = writeln!(s, "<p class=\"note\">{}</p>", escape(&n));
    }

    let decisions = decisions(&groups);
    if !decisions.is_empty() {
        s.push_str("<h2>CPU or GPU</h2><table class=\"sortable\"><thead><tr><th class=\"l\">task</th><th>best CPU</th><th class=\"l\">config</th><th>best GPU/NPU</th><th class=\"l\">up + compute + down</th><th class=\"l\">config</th><th>CPU used by GPU row</th><th>GPU/CPU</th><th class=\"l\">verdict</th><th class=\"l\">60 fps</th></tr></thead><tbody>\n");
        for d in &decisions {
            let cells: Vec<Option<f64>> = [d.cpu, d.gpu]
                .iter()
                .map(|r| r.and_then(|r| r.result.total_ms()))
                .collect();
            let times: Vec<f64> = cells.iter().flatten().copied().collect();
            let (min, max) = (
                times.iter().copied().fold(f64::MAX, f64::min),
                times.iter().copied().fold(0.0, f64::max),
            );
            let cell = |v: Option<f64>| v.map_or("<td class=\"na\">-</td>".to_string(), |v| time_cell(v, min, max));
            let config = |r: Option<&Row>| r.map_or(String::new(), |r| escape(&r.spec.backend.to_string()));
            let _ = writeln!(
                s,
                "<tr><td class=\"l\">{}</td>{}<td class=\"l\">{}</td>{}<td class=\"l\">{}</td><td class=\"l\">{}</td><td>{}</td><td data-v=\"{}\">{}</td><td class=\"l verdict-{}\">{}</td><td class=\"l\">{}</td></tr>",
                escape(&d.group),
                cell(cells[0]),
                config(d.cpu),
                cell(cells[1]),
                d.gpu.map_or(String::new(), |r| escape(&breakdown(r))),
                config(d.gpu),
                d.gpu.map_or(String::new(), cpu_load),
                d.ratio.unwrap_or(0.0),
                d.ratio.map_or("-".into(), |r| format!("{r:.2}")),
                d.verdict.split_whitespace().next().unwrap_or(""),
                escape(d.verdict),
                match d.fits_frame {
                    Some(true) => "yes",
                    Some(false) => "<b>no</b>",
                    None => "",
                }
            );
        }
        s.push_str("</tbody></table>\n");
    }

    for m in matrices(results) {
        let _ = write!(
            s,
            "<h2>Best per backend: {}</h2><table><thead><tr><th class=\"l\">radius</th>",
            escape(&m.title)
        );
        for f in &m.families {
            let _ = write!(s, "<th>{}</th>", escape(f));
        }
        s.push_str("</tr></thead><tbody>\n");
        for (label, cells) in &m.lines {
            let times: Vec<f64> = cells.iter().flatten().map(|c| c.0).collect();
            let (min, max) = (
                times.iter().copied().fold(f64::MAX, f64::min),
                times.iter().copied().fold(0.0, f64::max),
            );
            let _ = write!(s, "<tr><td class=\"l\">{label}</td>");
            for cell in cells {
                match cell {
                    Some((ms, config)) => {
                        let t = heat(*ms, min, max);
                        let best = if t <= 0.0 { " class=\"best\"" } else { "" };
                        let _ = write!(
                            s,
                            "<td title=\"{}\" style=\"background:{}\"><span{best}>{}</span></td>",
                            escape(config),
                            heat_color(t),
                            fmt_ms(*ms)
                        );
                    }
                    None => s.push_str("<td class=\"na\">-</td>"),
                }
            }
            s.push_str("</tr>\n");
        }
        s.push_str("</tbody></table>\n");
    }

    let soaks: Vec<&Row> = results.rows.iter().filter(|r| r.spec.soak).collect();
    if !soaks.is_empty() {
        s.push_str("<h2>Soak</h2><table><thead><tr><th class=\"l\">task</th><th class=\"l\">backend</th><th>first 10%</th><th>last 10%</th><th>change</th><th>temperature</th></tr></thead><tbody>\n");
        for r in soaks {
            let (first, last) = super::report::soak_trend(&r.result).unwrap_or((0.0, 0.0));
            let ratio = if first > 0.0 { last / first } else { 1.0 };
            let temps = match (r.env.start_temp, r.env.max_temp) {
                (Some(a), Some(b)) => format!("{a:.0} -> {b:.0} °C"),
                _ => "-".into(),
            };
            let _ = writeln!(
                s,
                "<tr><td class=\"l\">{}</td><td class=\"l\">{}</td><td>{}</td><td>{}</td><td style=\"background:{}\">{:+.0}%</td><td>{temps}</td></tr>",
                escape(&r.spec.group()),
                escape(&r.spec.backend.to_string()),
                fmt_ms(first),
                fmt_ms(last),
                heat_color(((ratio - 1.0) * 5.0).clamp(0.0, 1.0)),
                (ratio - 1.0) * 100.0
            );
        }
        s.push_str("</tbody></table>\n");
    }
    let micro = micro_rows(results);
    if !micro.is_empty() {
        s.push_str("<h2>Transfers and overheads</h2><table class=\"sortable\"><thead><tr><th class=\"l\">task</th><th class=\"l\">backend</th><th class=\"l\">result</th></tr></thead><tbody>\n");
        for (task, backend, value) in micro {
            let _ = writeln!(
                s,
                "<tr><td class=\"l\">{}</td><td class=\"l\">{}</td><td class=\"l\">{}</td></tr>",
                escape(&task),
                escape(&backend),
                escape(&value)
            );
        }
        s.push_str("</tbody></table>\n");
    }
    let anomalies = anomalies(results, &groups);
    if !anomalies.is_empty() {
        s.push_str("<h2>Worth a look</h2><ul>\n");
        for a in anomalies {
            let _ = writeln!(s, "<li>{}</li>", escape(&a));
        }
        s.push_str("</ul>\n");
    }
    s.push_str("<h2>Every row</h2><div class=\"legend\">bar: <span class=\"up\"></span>upload<span class=\"cp\"></span>compute<span class=\"dn\"></span>download, scaled to the slowest row of its table</div>\n");
    s.push_str("<input id=\"filter\" placeholder=\"filter: e.g. pipeline r=8 opencl zero-copy\">\n");
    for g in &groups {
        s.push_str(&group_section(g));
    }
    page(&format!("hodow bench {}", results.label()), &s)
}

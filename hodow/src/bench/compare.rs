//! Two runs side by side: rows matched by what they compute and how, `B / A` per row.
//! Green where B is faster, red where it is slower, on a log scale centred on equal.

use std::collections::BTreeMap;
use std::fmt::Write as _;
use std::path::Path;

use super::html::{escape, heat_color, page};
use super::report::{fmt_ms, groups, matrices};
use super::results::{Results, Row};

/// A ratio this far from 1 in either direction is the end of the colour scale.
const SCALE: f64 = 4.0;

fn ratio_heat(ratio: f64) -> f64 {
    (0.5 + ratio.ln() / (2.0 * SCALE.ln())).clamp(0.0, 1.0)
}

struct Pair<'a> {
    group: String,
    backend: String,
    a: Option<&'a Row>,
    b: Option<&'a Row>,
}

fn pairs<'a>(a: &'a Results, b: &'a Results) -> Vec<Pair<'a>> {
    let mut map: BTreeMap<String, Pair> = BTreeMap::new();
    for g in groups(a).into_iter().chain(groups(b)) {
        for row in g.rows {
            map.entry(row.spec.id()).or_insert_with(|| Pair {
                group: row.spec.group(),
                backend: row.spec.backend.to_string(),
                a: None,
                b: None,
            });
        }
    }
    for row in &a.rows {
        map.get_mut(&row.spec.id()).expect("every row was entered").a = Some(row);
    }
    for row in &b.rows {
        map.get_mut(&row.spec.id()).expect("every row was entered").b = Some(row);
    }
    let order: Vec<String> = groups(a).into_iter().chain(groups(b)).map(|g| g.name).collect();
    let mut pairs: Vec<Pair> = map.into_values().collect();
    pairs.sort_by_key(|p| {
        (
            order.iter().position(|g| *g == p.group).unwrap_or(usize::MAX),
            p.backend.clone(),
        )
    });
    pairs
}

/// For every matrix both runs have: one column per backend family of A, then of B, each
/// the family's best time per radius.
fn side_by_side(a: &Results, b: &Results) -> Vec<(String, Vec<String>, Vec<(String, Vec<Option<f64>>)>)> {
    let (ma, mb) = (matrices(a), matrices(b));
    let mut out = Vec::new();
    for m in &ma {
        let Some(other) = mb.iter().find(|o| o.title == m.title) else {
            continue;
        };
        let columns: Vec<String> = m
            .families
            .iter()
            .map(|f| format!("A {f}"))
            .chain(other.families.iter().map(|f| format!("B {f}")))
            .collect();
        let mut labels: Vec<&String> = m
            .lines
            .iter()
            .map(|(l, _)| l)
            .chain(other.lines.iter().map(|(l, _)| l))
            .collect();
        labels.sort_by_key(|l| l.trim_start_matches("r=").parse::<u32>().unwrap_or(0));
        labels.dedup();
        let lines = labels
            .into_iter()
            .map(|label| {
                let row = |mx: &super::report::Matrix| -> Vec<Option<f64>> {
                    match mx.lines.iter().find(|(l, _)| l == label) {
                        Some((_, cells)) => cells.iter().map(|c| c.as_ref().map(|(ms, _)| *ms)).collect(),
                        None => vec![None; mx.families.len()],
                    }
                };
                let mut cells = row(m);
                cells.extend(row(other));
                (label.clone(), cells)
            })
            .collect();
        out.push((m.title.clone(), columns, lines));
    }
    out
}

fn time(row: Option<&Row>) -> Option<f64> {
    row.and_then(|r| r.result.total_ms())
}

pub fn run(a_path: &Path, b_path: &Path) -> i32 {
    let (a, b) = match (Results::load(a_path), Results::load(b_path)) {
        (Ok(a), Ok(b)) => (a, b),
        (Err(e), _) | (_, Err(e)) => {
            eprintln!("{e}");
            return 2;
        }
    };
    let color = std::io::IsTerminal::is_terminal(&std::io::stdout()) && std::env::var_os("NO_COLOR").is_none();
    let paint = |code: &str, text: &str| {
        if color {
            format!("\x1b[{code}m{text}\x1b[0m")
        } else {
            text.to_string()
        }
    };
    println!(
        "{}",
        paint(
            "1",
            &format!("A: {}\n   {}\nB: {}\n   {}", a.label(), a.host, b.label(), b.host)
        )
    );

    let side = side_by_side(&a, &b);
    for (title, columns, lines) in &side {
        println!(
            "\n{}",
            paint("1", &format!("== best per backend: {title} (ms per frame)"))
        );
        let width = columns.iter().map(|c| c.len()).max().unwrap_or(8) + 2;
        let mut head = format!("{:<6}", "");
        for c in columns {
            let _ = write!(head, "{c:>width$}");
        }
        println!("{head}");
        for (label, cells) in lines {
            let times: Vec<f64> = cells.iter().flatten().copied().collect();
            let (min, max) = (
                times.iter().copied().fold(f64::MAX, f64::min),
                times.iter().copied().fold(0.0, f64::max),
            );
            let mut line = format!("{label:<6}");
            for cell in cells {
                match cell {
                    Some(ms) => {
                        let t = super::report::heat(*ms, min, max);
                        let code = if t <= 0.0 {
                            "1;32"
                        } else if t < 0.34 {
                            "32"
                        } else if t < 0.67 {
                            "33"
                        } else {
                            "31"
                        };
                        let _ = write!(line, "{}", paint(code, &format!("{:>width$}", fmt_ms(*ms))));
                    }
                    None => {
                        let _ = write!(line, "{:>width$}", "-");
                    }
                }
            }
            println!("{line}");
        }
    }

    let pairs = pairs(&a, &b);
    let matched = pairs
        .iter()
        .filter(|p| time(p.a).is_some() && time(p.b).is_some())
        .count();
    println!(
        "\n{matched} rows timed in both, {} in A only, {} in B only",
        pairs.iter().filter(|p| p.b.is_none()).count(),
        pairs.iter().filter(|p| p.a.is_none()).count()
    );

    let dir = Results::path(b_path)
        .parent()
        .map(Path::to_path_buf)
        .unwrap_or_default();
    let html = render(&a, &b, &pairs);
    let out = dir.join("compare.html");
    match std::fs::write(&out, html) {
        Ok(()) => println!("{}", paint("36", &format!("written: {}", out.display()))),
        Err(e) => eprintln!("cannot write {}: {e}", out.display()),
    }
    0
}

fn render(a: &Results, b: &Results, pairs: &[Pair]) -> String {
    let mut s = String::new();
    let _ = writeln!(
        s,
        "<h1>hodow bench - comparison</h1><div class=\"meta\"><b>A</b> {}<br>{}</div><div class=\"meta\"><b>B</b> {}<br>{}</div>",
        escape(&a.label()),
        escape(&a.host),
        escape(&b.label()),
        escape(&b.host)
    );
    let _ = writeln!(
        s,
        "<p class=\"note\">B/A below 1 (green) means B is faster. Colour saturates at {SCALE}x either way, on a log scale.</p>"
    );
    for (title, columns, lines) in side_by_side(a, b) {
        let _ = write!(
            s,
            "<h2>Best per backend: {}</h2><table><thead><tr><th class=\"l\">radius</th>",
            escape(&title)
        );
        for c in &columns {
            let _ = write!(s, "<th>{}</th>", escape(c));
        }
        s.push_str("</tr></thead><tbody>\n");
        for (label, cells) in lines {
            let times: Vec<f64> = cells.iter().flatten().copied().collect();
            let (min, max) = (
                times.iter().copied().fold(f64::MAX, f64::min),
                times.iter().copied().fold(0.0, f64::max),
            );
            let _ = write!(s, "<tr><td class=\"l\">{label}</td>");
            for cell in cells {
                match cell {
                    Some(ms) => {
                        let _ = write!(
                            s,
                            "<td style=\"background:{}\">{}</td>",
                            heat_color(super::report::heat(ms, min, max)),
                            fmt_ms(ms)
                        );
                    }
                    None => s.push_str("<td class=\"na\">-</td>"),
                }
            }
            s.push_str("</tr>\n");
        }
        s.push_str("</tbody></table>\n");
    }
    s.push_str("<input id=\"filter\" placeholder=\"filter: e.g. pipeline r=8 opencl\">\n");
    let mut current = None;
    for p in pairs {
        if current != Some(&p.group) {
            if current.is_some() {
                s.push_str("</tbody></table></section>\n");
            }
            current = Some(&p.group);
            let _ = writeln!(
                s,
                "<section class=\"group\" data-name=\"{0}\"><h3>{0}</h3><table class=\"sortable\"><thead><tr><th class=\"l\">backend</th><th>A</th><th>B</th><th>B/A</th></tr></thead><tbody>",
                escape(&p.group)
            );
        }
        let cell = |r: Option<&Row>| match r {
            None => "<td class=\"na\">absent</td>".to_string(),
            Some(r) => match r.result.total_ms() {
                Some(ms) => format!("<td data-v=\"{ms}\">{}</td>", fmt_ms(ms)),
                None => format!("<td class=\"err\">{:?}</td>", r.result.status),
            },
        };
        let ratio = match (time(p.a), time(p.b)) {
            (Some(x), Some(y)) => format!(
                "<td data-v=\"{}\" style=\"background:{}\">{:.2}</td>",
                y / x,
                heat_color(ratio_heat(y / x)),
                y / x
            ),
            _ => "<td class=\"na\">-</td>".to_string(),
        };
        let _ = writeln!(
            s,
            "<tr><td class=\"l\">{}</td>{}{}{ratio}</tr>",
            escape(&p.backend),
            cell(p.a),
            cell(p.b)
        );
    }
    if current.is_some() {
        s.push_str("</tbody></table></section>\n");
    }
    page("hodow bench comparison", &s)
}

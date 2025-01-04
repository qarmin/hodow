//! The terminal side: a live progress bar for the row that is running, and one coloured
//! line per finished row. Without a terminal there are no bars and no colours, only the
//! finished lines.

use std::io::IsTerminal;
use std::time::Duration;

use indicatif::{ProgressBar, ProgressDrawTarget, ProgressStyle};

use super::events::RowResult;
use super::supervise::Status;

const RED: &str = "31";
const GREEN: &str = "32";
const YELLOW: &str = "33";
const MAGENTA: &str = "35";
const CYAN: &str = "36";
const DIM: &str = "2";
const BOLD_RED: &str = "1;31";
const BOLD: &str = "1";
const NAME_WIDTH: usize = 38;
const WIDTH: usize = 72;

#[derive(Clone, Copy)]
pub struct Ui {
    color: bool,
    tty: bool,
}

pub fn fmt_secs(secs: f64) -> String {
    let s = secs.round() as u64;
    match s {
        0..60 => format!("{s}s"),
        60..3600 => format!("{}m {:02}s", s / 60, s % 60),
        _ => format!("{}h {:02}m", s / 3600, s % 3600 / 60),
    }
}

impl Ui {
    pub fn new() -> Self {
        let tty = std::io::stdout().is_terminal();
        Ui {
            color: tty && std::env::var_os("NO_COLOR").is_none(),
            tty,
        }
    }

    pub fn color(&self) -> bool {
        self.color
    }

    pub fn plain() -> Self {
        Ui {
            color: false,
            tty: false,
        }
    }

    pub fn paint(&self, code: &str, text: &str) -> String {
        if self.color {
            format!("\x1b[{code}m{text}\x1b[0m")
        } else {
            text.to_string()
        }
    }

    pub fn tag(&self, status: Status) -> String {
        let (text, code) = match status {
            Status::Ok => ("[OK]", GREEN),
            Status::Warn => ("[WARN]", YELLOW),
            Status::Error => ("[ERROR]", RED),
            Status::Skip => ("[SKIP]", DIM),
            Status::Hang => ("[HANG]", BOLD_RED),
            Status::Crash => ("[CRASH]", BOLD_RED),
            Status::Abort => ("[ABORT]", MAGENTA),
        };
        format!("{}{}", self.paint(code, text), " ".repeat(8 - text.len()))
    }

    pub fn row(&self, row: &RowResult) -> Vec<String> {
        let mut detail = row.detail.clone();
        if let Some(temp) = row.max_temp {
            detail.push_str(&format!(", max {temp:.0}°C"));
        }
        let mut first = format!(
            "{}{:<NAME_WIDTH$} - {:<7} {detail}",
            self.tag(row.status),
            row.name,
            fmt_secs(row.secs)
        );
        if row.errors > 0 {
            first.push_str(&self.paint(
                RED,
                &format!("   {} error{}", row.errors, if row.errors == 1 { "" } else { "s" }),
            ));
        }
        let mut lines = vec![first];
        lines.extend(row.samples.iter().map(|s| format!("          {s}")));
        if row.errors > row.samples.len() as u64 && !row.samples.is_empty() {
            lines.push(format!("          +{} more", row.errors - row.samples.len() as u64));
        }
        lines.extend(
            row.warnings
                .iter()
                .map(|w| format!("{}{}: {w}", self.tag(Status::Warn), row.name)),
        );
        lines
    }

    pub fn phase(&self, title: &str, temp: Option<f32>) -> String {
        let head = format!("== {title} ");
        let temp = temp.map(|t| format!("  {t:.0}°C")).unwrap_or_default();
        self.paint(
            BOLD,
            &format!(
                "\n{head}{}{temp}",
                "=".repeat(WIDTH.saturating_sub(head.chars().count()))
            ),
        )
    }

    pub fn summary(&self, rows: &[RowResult], secs: f64, max_temp: Option<f32>) -> String {
        let count = |s: Status| rows.iter().filter(|r| r.status == s).count();
        let mut parts = Vec::new();
        for (status, word) in [
            (Status::Error, "error"),
            (Status::Crash, "crash"),
            (Status::Hang, "hang"),
            (Status::Abort, "abort"),
            (Status::Skip, "skipped"),
        ] {
            let n = count(status);
            if n > 0 {
                parts.push(format!(
                    "{n} {word}{}",
                    if n > 1 && status != Status::Skip { "s" } else { "" }
                ));
            }
        }
        let failed = rows.iter().any(|r| r.status.is_failure());
        let verdict = if failed { "FAILED" } else { "PASSED" };
        parts.insert(0, format!("{verdict}: {} ok", count(Status::Ok) + count(Status::Warn)));
        if let Some(t) = max_temp {
            parts.push(format!("max {t:.0}°C"));
        }
        parts.push(fmt_secs(secs));
        let line = parts.join(" | ");
        let painted = if !self.color {
            line
        } else if failed {
            format!("\x1b[1;37;41m {line} \x1b[0m")
        } else {
            format!("\x1b[1;30;42m {line} \x1b[0m")
        };
        format!("{}\n{painted}", self.phase("SUMMARY", None))
    }

    /// The live line of the running row: time-based bar, or a spinner for a pass-only run.
    pub fn bar(&self, name: &str, budget: Duration) -> ProgressBar {
        let target = if self.tty {
            ProgressDrawTarget::stdout()
        } else {
            ProgressDrawTarget::hidden()
        };
        let bar = ProgressBar::with_draw_target(Some(budget.as_millis().max(1) as u64), target);
        let template = if budget.is_zero() {
            "[ ]     {msg} {spinner:.cyan} {prefix}"
        } else {
            "[ ]     {msg} {wide_bar:.cyan/blue} {prefix}"
        };
        bar.set_style(
            ProgressStyle::with_template(template)
                .expect("valid template")
                .progress_chars("█▉▊▋▌▍▎▏ "),
        );
        bar.set_message(format!("{name:<NAME_WIDTH$}"));
        bar.enable_steady_tick(Duration::from_millis(120));
        bar
    }

    pub fn header(&self, text: &str) -> String {
        self.paint(BOLD, text)
    }

    pub fn note(&self, text: &str) -> String {
        self.paint(CYAN, text)
    }

    pub fn dim(&self, text: &str) -> String {
        self.paint(DIM, text)
    }

    pub fn red(&self, text: &str) -> String {
        self.paint(RED, text)
    }

    pub fn green(&self, text: &str) -> String {
        self.paint(GREEN, text)
    }
}

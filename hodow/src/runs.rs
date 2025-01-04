//! `hodow runs`: what the results directory holds.

use hodow_common::store::RunMeta;
use hodow_common::{Event, RunStatus, Store, Summary, Verdict};

use crate::cli::RunsArgs;

const NOTABLE_SHOWN: usize = 100;

pub fn process_runs(args: &RunsArgs) {
    let store = Store::new(crate::session::data_dir().results());
    let Some(wanted) = &args.id else {
        list(&store);
        return;
    };
    let id = match resolve(&store, wanted) {
        Ok(id) => id,
        Err(message) => {
            eprintln!("{message}");
            std::process::exit(2);
        }
    };
    if args.pin || args.unpin {
        match store.pin(&id, args.pin) {
            Ok(()) => println!("{id}: {}", if args.pin { "pinned" } else { "unpinned" }),
            Err(e) => {
                eprintln!("{id}: {e}");
                std::process::exit(1);
            }
        }
        return;
    }
    show(&store, &id, args.all);
}

fn resolve(store: &Store, wanted: &str) -> Result<String, String> {
    let runs = store.list();
    if let Some(exact) = runs.iter().find(|r| r.id == wanted) {
        return Ok(exact.id.clone());
    }
    let matching: Vec<&RunMeta> = runs.iter().filter(|r| r.id.contains(wanted)).collect();
    match matching.as_slice() {
        [one] => Ok(one.id.clone()),
        [] => Err(format!("no run matches '{wanted}' (see `hodow runs`)")),
        many => Err(format!(
            "'{wanted}' matches {} runs: {}",
            many.len(),
            many.iter()
                .take(5)
                .map(|r| r.id.as_str())
                .collect::<Vec<_>>()
                .join(", ")
        )),
    }
}

fn status_name(status: RunStatus) -> &'static str {
    match status {
        RunStatus::Running => "running",
        RunStatus::Succeeded => "ok",
        RunStatus::Failed => "FAILED",
        RunStatus::Crashed => "CRASHED",
        RunStatus::Interrupted => "interrupted",
        RunStatus::Cancelled => "cancelled",
    }
}

pub fn format_duration(ms: u64) -> String {
    let secs = ms / 1000;
    match secs {
        0..=59 => format!("{}.{}s", secs, (ms % 1000) / 100),
        60..=3599 => format!("{}m{:02}s", secs / 60, secs % 60),
        _ => format!("{}h{:02}m{:02}s", secs / 3600, (secs % 3600) / 60, secs % 60),
    }
}

fn counts(summary: &Summary) -> String {
    let mut parts = vec![format!("{} tests", summary.total)];
    for (n, label) in [
        (summary.passed, "passed"),
        (summary.unverified, "unverified"),
        (summary.skipped, "skipped"),
        (summary.not_supported, "not supported"),
        (summary.failed, "failed"),
        (summary.panicked, "panicked"),
        (summary.timed_out, "timed out"),
        (summary.crashed, "crashed"),
    ] {
        if n > 0 {
            parts.push(format!("{n} {label}"));
        }
    }
    parts.join(", ")
}

fn list(store: &Store) {
    let runs = store.list();
    if runs.is_empty() {
        println!("No runs kept in {}", store.dir().display());
        return;
    }
    let width = runs.iter().map(|r| r.id.len()).max().unwrap_or(2);
    println!("{:width$}  {:11}  {:>9}  RESULT", "ID", "STATUS", "TOOK");
    for run in &runs {
        let took = run
            .finished_ms
            .map_or_else(String::new, |f| format_duration(f.saturating_sub(run.started_ms)));
        let pin = if store.is_pinned(&run.id) { " [pinned]" } else { "" };
        let result = run.summary.as_ref().map_or_else(String::new, counts);
        println!(
            "{:width$}  {:11}  {took:>9}  {result}{pin}",
            run.id,
            status_name(run.status)
        );
    }
}

fn show(store: &Store, id: &str, all: bool) {
    let Some(meta) = store.meta(id) else {
        eprintln!("{id}: unreadable run");
        std::process::exit(1);
    };
    println!("{}  ({})", meta.id, meta.title);
    println!("status:   {}", status_name(meta.status));
    if let Some(f) = meta.finished_ms {
        println!("took:     {}", format_duration(f.saturating_sub(meta.started_ms)));
    }
    println!(
        "host:     {} ({} {})",
        meta.host.as_deref().unwrap_or("unknown"),
        meta.os,
        meta.arch
    );
    println!("version:  {}", meta.version);
    if !meta.args.is_empty() {
        println!("args:     {}", meta.args.join(" "));
    }
    if let Some(summary) = &meta.summary {
        println!("result:   {}", counts(summary));
    }
    let events = match store.read_events(id) {
        Ok(e) => e,
        Err(e) => {
            eprintln!("no events kept for this run: {e}");
            return;
        }
    };
    let mut shown = 0usize;
    let mut hidden = 0usize;
    for record in events.filter_map(Result::ok) {
        let Event::Finding(f) = record.event else { continue };
        if !all && f.verdict == Verdict::Passed {
            continue;
        }
        if !all && shown >= NOTABLE_SHOWN {
            hidden += 1;
            continue;
        }
        shown += 1;
        let extra = f
            .detail
            .or(f.value.map(|v| format!("= {v}")))
            .map_or_default(|d| format!("  {d}"));
        println!("  {:12} {}{extra}", format!("{:?}", f.verdict), f.name);
    }
    if hidden > 0 {
        println!("  ... {hidden} more (use --all to list every finding)");
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn durations_read_naturally() {
        assert_eq!(format_duration(0), "0.0s");
        assert_eq!(format_duration(1_500), "1.5s");
        assert_eq!(format_duration(61_000), "1m01s");
        assert_eq!(format_duration(3_723_000), "1h02m03s");
    }

    #[test]
    fn an_empty_summary_still_says_how_many_tests_ran() {
        assert_eq!(counts(&Summary::default()), "0 tests");
    }
}

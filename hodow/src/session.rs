//! One run of one module, as the rest of the program sees it: a `Reporter` whose events are kept in the results
//! directory, kept in a live state, and optionally printed as `@hodow` lines for whoever started this process.

use std::path::PathBuf;
use std::sync::{Arc, OnceLock};

use hodow_common::sink::{Fanout, StateSink, StdoutSink};
use hodow_common::store::retention;
use hodow_common::{DataDir, Reporter, RunState, RunStatus, RunWriter, Sink, Store, Summary};
use log::{info, warn};

pub struct Options {
    pub data_dir: DataDir,
    pub save: bool,
    pub events: bool,
}

static OPTIONS: OnceLock<Options> = OnceLock::new();

pub fn configure(options: Options) {
    let _ = OPTIONS.set(options);
}

pub fn data_dir() -> DataDir {
    OPTIONS
        .get()
        .map_or_else(|| DataDir::resolve(None), |o| o.data_dir.clone())
}

fn retention_limit() -> u64 {
    std::env::var("HODOW_RETENTION_GB")
        .ok()
        .and_then(|v| v.parse::<f64>().ok())
        .filter(|gb| *gb > 0.0)
        .map_or(retention::DEFAULT_LIMIT_BYTES, |gb| {
            (gb * 1024.0 * 1024.0 * 1024.0) as u64
        })
}

pub struct Session {
    reporter: Reporter,
    state: Arc<StateSink>,
    writer: Option<Arc<RunWriter>>,
    dir: DataDir,
}

impl Session {
    pub fn start(module: &str, title: &str, args: &[String]) -> Self {
        let (save, events) = OPTIONS.get().map_or((true, false), |o| (o.save, o.events));
        let dir = data_dir();
        let state = Arc::new(StateSink::new(RunState::new(
            module,
            title,
            hodow_common::time::now_ms(),
        )));
        let mut sinks: Vec<Arc<dyn Sink>> = vec![state.clone()];
        let writer = save.then(|| open_writer(&dir, module, title, args)).flatten();
        if let Some(w) = &writer {
            sinks.push(w.clone());
        }
        if events {
            sinks.push(Arc::new(StdoutSink));
        }
        let reporter = Reporter::new(Arc::new(Fanout(sinks)));
        reporter.run_started(module, title, args, writer.as_ref().map(|w| w.id()));
        Self {
            reporter,
            state,
            writer,
            dir,
        }
    }

    pub fn reporter(&self) -> &Reporter {
        &self.reporter
    }

    pub fn run_dir(&self) -> Option<PathBuf> {
        self.writer.as_ref().map(|w| w.dir().to_path_buf())
    }

    /// Ends the run with the status its findings imply, unless the module knows better.
    pub fn finish(&self, status: Option<RunStatus>) {
        let summary = self.state.with(|s| s.summary.clone());
        let status = status.unwrap_or_else(|| summary.status());
        self.finish_with(status, summary);
    }

    /// For a module that only has counts, not one finding per test.
    pub fn finish_with(&self, status: RunStatus, summary: Summary) {
        self.reporter.run_finished(status, summary);
        if let Some(dir) = self.run_dir() {
            info!("Results saved to {}", dir.display());
        }
        if self.writer.is_some() {
            match retention::enforce(&self.dir, retention_limit()) {
                Ok(report) if !report.removed.is_empty() => {
                    info!(
                        "Results folder over its limit: removed {} old item(s)",
                        report.removed.len()
                    );
                }
                Ok(report) if report.over_limit => {
                    warn!("Results folder is over its limit and nothing more can be removed (running or pinned runs)");
                }
                Ok(_) => {}
                Err(e) => warn!("Could not trim the results folder: {e}"),
            }
        }
    }
}

fn open_writer(dir: &DataDir, module: &str, title: &str, args: &[String]) -> Option<Arc<RunWriter>> {
    if let Err(e) = dir.ensure() {
        warn!(
            "Cannot create {}: {e} - this run's results are not saved",
            dir.root().display()
        );
        return None;
    }
    match Store::new(dir.results()).create_run(module, title, args) {
        Ok(w) => Some(Arc::new(w)),
        Err(e) => {
            warn!("Cannot start a results record: {e} - this run's results are not saved");
            None
        }
    }
}

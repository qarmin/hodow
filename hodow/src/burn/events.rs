//! `events.jsonl`: every start, result and sensor reading, each line synced to disk before
//! the run moves on, so a board that has to be power-cycled still says where it stopped.

use std::fs::File;
use std::io::{BufRead, BufReader, Write};
use std::path::Path;
use std::sync::Mutex;
use std::time::Instant;

use serde::{Deserialize, Serialize};

use super::sensors::{Sample, SensorInfo};
use super::supervise::Status;
use super::ui::{Ui, fmt_secs};

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct RowResult {
    pub name: String,
    pub status: Status,
    pub secs: f64,
    pub detail: String,
    pub errors: u64,
    pub samples: Vec<String>,
    pub warnings: Vec<String>,
    pub max_temp: Option<f32>,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
#[serde(tag = "event", rename_all = "snake_case")]
pub enum Event {
    RunStart {
        header: String,
        rows: Vec<String>,
        sensors: SensorInfo,
    },
    Phase {
        name: String,
    },
    RowStart {
        row: usize,
        name: String,
        budget_secs: f64,
    },
    RowEnd {
        row: usize,
        result: RowResult,
    },
    Sample {
        sample: Sample,
    },
    RunEnd {
        failed: bool,
        secs: f64,
    },
}

#[derive(Serialize, Deserialize)]
struct Record {
    t: f64,
    #[serde(flatten)]
    event: Event,
}

pub struct Journal {
    file: Mutex<File>,
    start: Instant,
}

impl Journal {
    pub fn create(path: &Path, start: Instant) -> std::io::Result<Self> {
        Ok(Journal {
            file: Mutex::new(File::create(path)?),
            start,
        })
    }

    pub fn write(&self, event: Event) {
        let record = Record {
            t: self.start.elapsed().as_secs_f64(),
            event,
        };
        let line = serde_json::to_string(&record).expect("event serializes");
        let file = self.file.lock().unwrap_or_else(|e| e.into_inner());
        let mut file = &*file;
        let _ = writeln!(file, "{line}");
        let _ = file.sync_data();
    }
}

/// `--show`: the summary of a run read back from its directory, finished or not.
pub fn show(dir: &Path) -> i32 {
    let ui = Ui::new();
    let path = dir.join("events.jsonl");
    let file = match File::open(&path) {
        Ok(f) => f,
        Err(e) => {
            eprintln!("cannot read {}: {e}", path.display());
            return 2;
        }
    };
    let mut started: Option<(String, f64)> = None;
    let mut results = Vec::new();
    let mut last_sample: Option<(Sample, SensorInfo)> = None;
    let mut sensors = SensorInfo::default();
    let mut end = None;
    let mut last_t = 0.0;
    for line in BufReader::new(file).lines().map_while(Result::ok) {
        // The last line of a run that lost power can be half written.
        let Ok(record) = serde_json::from_str::<Record>(&line) else {
            continue;
        };
        last_t = record.t;
        match record.event {
            Event::RunStart {
                header, sensors: info, ..
            } => {
                println!("{}", ui.header(&header));
                sensors = info;
            }
            Event::Phase { name } => println!("{}", ui.phase(&name, None)),
            Event::RowStart { name, .. } => started = Some((name, record.t)),
            Event::RowEnd { result, .. } => {
                started = None;
                for line in ui.row(&result) {
                    println!("{line}");
                }
                results.push(result);
            }
            Event::Sample { sample } => last_sample = Some((sample, sensors.clone())),
            Event::RunEnd { failed, secs } => end = Some((failed, secs)),
        }
    }
    if let Some((name, at)) = &started {
        println!(
            "{}{name} - {}",
            ui.tag(Status::Abort),
            ui.red(&format!(
                "was running for {} when the record ends - the machine stopped or the run was killed here",
                fmt_secs(last_t - at)
            ))
        );
    }
    if let Some((sample, info)) = last_sample {
        let temps: Vec<String> = info
            .temp_names
            .iter()
            .zip(&sample.temps)
            .filter_map(|(n, t)| t.map(|t| format!("{n} {t:.0}°C")))
            .collect();
        println!(
            "{}",
            ui.dim(&format!("last reading at {}: {}", fmt_secs(sample.t), temps.join(", ")))
        );
    }
    let max_temp = results.iter().filter_map(|r| r.max_temp).reduce(f32::max);
    match end {
        Some((_, secs)) => println!("{}", ui.summary(&results, secs, max_temp)),
        None => println!("{}", ui.red("\nThe run never finished.")),
    }
    let failed = results.iter().any(|r| r.status.is_failure()) || end.is_none();
    if failed { 1 } else { 0 }
}

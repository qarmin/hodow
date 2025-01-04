//! Requests the orchestrator writes to a worker's stdin, one JSON object per line, and the
//! `@bench`-prefixed lines the worker answers with on stdout. Anything a driver prints on
//! its own is simply not a message.

use std::io::Write;

use hodow_bench::bench::spec::{ClDevice, RowResult, RowSpec};
use serde::{Deserialize, Serialize};

pub const PREFIX: &str = "@bench ";

#[derive(Serialize, Deserialize, Debug)]
#[serde(tag = "t", rename_all = "snake_case")]
pub enum Request {
    Probe,
    Row { spec: RowSpec },
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct Probe {
    pub devices: Vec<ClDevice>,
    pub notes: Vec<String>,
    pub threads: u32,
    pub simd: Option<String>,
    /// What answered, when it did: GL version and renderer, Vulkan device and driver.
    #[serde(default)]
    pub gles: Option<String>,
    #[serde(default)]
    pub vulkan: Option<String>,
    /// The TensorFlow Lite library found, when one was.
    #[serde(default)]
    pub tflite: Option<String>,
}

#[derive(Serialize, Deserialize, Debug)]
#[serde(tag = "t", rename_all = "snake_case")]
pub enum Msg {
    /// A frame finished; only sent when one did, so silence means no progress.
    Beat {
        reps: u32,
    },
    Probe {
        probe: Probe,
    },
    Result {
        result: Box<RowResult>,
    },
}

pub fn send(msg: &Msg) {
    let line = serde_json::to_string(msg).expect("protocol message serializes");
    let mut out = std::io::stdout().lock();
    let _ = writeln!(out, "{PREFIX}{line}");
    let _ = out.flush();
}

pub fn parse(line: &str) -> Option<Msg> {
    serde_json::from_str(line.strip_prefix(PREFIX)?).ok()
}

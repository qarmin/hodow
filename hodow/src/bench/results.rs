//! `results.json`: everything a run measured, enough to rebuild every report from.

use std::path::{Path, PathBuf};

use hodow_bench::bench::spec::{ClDevice, RowResult, RowSpec};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct RowEnv {
    /// Seconds since the run started.
    pub started: f64,
    #[serde(default)]
    pub start_temp: Option<f32>,
    pub max_temp: Option<f32>,
    pub cpu_mhz_min: Option<u32>,
    pub cpu_mhz_max: Option<u32>,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct Row {
    pub spec: RowSpec,
    pub result: RowResult,
    #[serde(default)]
    pub env: RowEnv,
}

#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct Results {
    pub started: String,
    pub host: String,
    pub hostname: String,
    pub profile: String,
    pub threads: u32,
    pub simd: Option<String>,
    #[serde(default)]
    pub governor: Option<String>,
    pub devices: Vec<ClDevice>,
    #[serde(default)]
    pub gles: Option<String>,
    #[serde(default)]
    pub vulkan: Option<String>,
    pub notes: Vec<String>,
    /// Commands kept running in the background for the whole run.
    #[serde(default)]
    pub background: Vec<String>,
    pub secs: f64,
    pub rows: Vec<Row>,
}

impl Results {
    pub fn path(dir_or_file: &Path) -> PathBuf {
        if dir_or_file.is_dir() {
            dir_or_file.join("results.json")
        } else {
            dir_or_file.to_path_buf()
        }
    }

    pub fn load(dir_or_file: &Path) -> Result<Self, String> {
        let path = Self::path(dir_or_file);
        let text = std::fs::read_to_string(&path).map_err(|e| format!("cannot read {}: {e}", path.display()))?;
        serde_json::from_str(&text).map_err(|e| format!("{} is not a bench result: {e}", path.display()))
    }

    pub fn save(&self, dir: &Path) -> Result<(), String> {
        let path = dir.join("results.json");
        let tmp = dir.join("results.json.tmp");
        let text = serde_json::to_string(self).expect("results serialize");
        std::fs::write(&tmp, text)
            .and_then(|()| std::fs::rename(&tmp, &path))
            .map_err(|e| format!("cannot write {}: {e}", path.display()))
    }

    /// A short name for this run in a comparison.
    pub fn label(&self) -> String {
        format!("{} {}", self.hostname, self.started)
    }
}

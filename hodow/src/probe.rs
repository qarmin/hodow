//! `hodow probe`: whether a GPU API works here, answered in a process of its own. Creating a GL context or a Vulkan
//! instance is what hangs or crashes on the drivers this tool exists to test, so the server never does it itself.

use serde::{Deserialize, Serialize};

use crate::cli::{ProbeArgs, ProbeKind};

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Availability {
    /// `ok`, `unavailable` (no driver: not a failure), `failed` (the probe itself died or hung), `not_built`.
    pub state: String,
    pub detail: String,
    #[serde(default)]
    pub devices: Vec<String>,
}

// Built by the GPU probes and by the server; a build with none of those has no use for them.
#[cfg_attr(not(any(feature = "gpu", feature = "vulkan", feature = "serve")), allow(dead_code))]
impl Availability {
    pub fn ok(detail: impl Into<String>, devices: Vec<String>) -> Self {
        Self {
            state: "ok".into(),
            detail: detail.into(),
            devices,
        }
    }

    pub fn unavailable(detail: impl Into<String>) -> Self {
        Self {
            state: "unavailable".into(),
            detail: detail.into(),
            devices: Vec::new(),
        }
    }

    pub fn failed(detail: impl Into<String>) -> Self {
        Self {
            state: "failed".into(),
            detail: detail.into(),
            devices: Vec::new(),
        }
    }

    #[cfg_attr(all(feature = "gpu", feature = "vulkan"), allow(dead_code))]
    fn not_built(what: &str) -> Self {
        Self {
            state: "not_built".into(),
            detail: format!("this binary was built without {what}"),
            devices: Vec::new(),
        }
    }
}

pub fn process_probe(args: &ProbeArgs) {
    let result = match args.what {
        ProbeKind::Gl => probe_gl(),
        ProbeKind::Vulkan => probe_vulkan(),
    };
    println!("{}", serde_json::to_string(&result).expect("availability serializes"));
}

#[cfg(feature = "gpu")]
fn probe_gl() -> Availability {
    match hodow_gpu::probe_opengl() {
        Ok(info) => Availability::ok(format!("{} - {}", info.renderer, info.version), vec![info.renderer]),
        Err(e) => Availability::unavailable(e),
    }
}

#[cfg(not(feature = "gpu"))]
fn probe_gl() -> Availability {
    Availability::not_built("the `gpu` feature")
}

#[cfg(feature = "vulkan")]
fn probe_vulkan() -> Availability {
    match hodow_gpu::vulkan::probe_devices() {
        Ok(devices) if devices.is_empty() => {
            Availability::unavailable("a Vulkan loader is present but reports no device")
        }
        Ok(devices) => {
            let names: Vec<String> = devices
                .iter()
                .map(|d| format!("{} (Vulkan {})", d.name, d.api_version))
                .collect();
            Availability::ok(format!("{} device(s)", names.len()), names)
        }
        Err(e) => Availability::unavailable(e),
    }
}

#[cfg(not(feature = "vulkan"))]
fn probe_vulkan() -> Availability {
    Availability::not_built("the `vulkan` feature")
}

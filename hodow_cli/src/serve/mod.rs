//! `hodow_cli serve`: a persistent, remotely-controllable job queue + web dashboard.
//!
//! Architecture: single binary, `serve` is its own subcommand (unlike `--serve` flags on
//! other tools, there's no other synchronous work sharing this invocation), so it simply
//! builds a tokio runtime and blocks on the axum server for the process's lifetime. The
//! job executor (`executor::spawn_executor`) runs on a plain OS thread, not a tokio task,
//! since it's a blocking loop around subprocess I/O (see `isolate.rs`).

mod executor;
mod model;
mod routes;
mod store;
mod ws;

use std::net::SocketAddr;
use std::path::PathBuf;
use std::sync::Arc;

use log::{error, info};

use crate::cli::ServeArgs;
use store::Store;
use ws::Broadcaster;

pub struct AppState {
    pub store: Store,
    pub bus: Broadcaster,
    pub capabilities: Capabilities,
}

#[derive(serde::Serialize, Clone)]
pub struct Capabilities {
    /// "arch:feature" strings for every CPU extension detected as available at runtime on
    /// this machine (e.g. "x86:avx512f") - same data `hodow_cli cpu -l` prints.
    pub cpu_modes: Vec<String>,
    /// Total number of registered CPU test functions for those detected extensions - i.e.
    /// how many tests a filter-less `Cpu` job actually runs here.
    pub cpu_test_count: usize,
    pub gpu_compiled: bool,
    pub vulkan_compiled: bool,
}

fn detect_capabilities() -> Capabilities {
    Capabilities {
        cpu_modes: hodow_core::available_modes(),
        cpu_test_count: hodow_core::list_all_functions().len(),
        gpu_compiled: cfg!(feature = "gpu"),
        vulkan_compiled: cfg!(feature = "vulkan"),
    }
}

const DEFAULT_PORT: u16 = 7878;

fn data_dir(args: &ServeArgs) -> PathBuf {
    if let Some(ref d) = args.data_dir {
        return d.clone();
    }
    if let Ok(xdg) = std::env::var("XDG_DATA_HOME") {
        return PathBuf::from(xdg).join("hodow").join("serve");
    }
    let home = std::env::var("HOME").unwrap_or_else(|_| ".".to_string());
    PathBuf::from(home).join(".local").join("share").join("hodow").join("serve")
}

pub fn process_serve(args: &ServeArgs) {
    let dir = data_dir(args);
    let store = match Store::open(dir.clone()) {
        Ok(s) => s,
        Err(e) => {
            error!("Failed to open job store at {}: {e}", dir.display());
            return;
        }
    };
    info!("Job queue/history: {}", dir.display());

    let capabilities = detect_capabilities();
    info!(
        "CPU: {} extension(s) detected on this machine ({}), {} test(s) available. GPU support compiled in: {}. Vulkan support compiled in: {}.",
        capabilities.cpu_modes.len(),
        capabilities.cpu_modes.join(", "),
        capabilities.cpu_test_count,
        capabilities.gpu_compiled,
        capabilities.vulkan_compiled,
    );

    let state = Arc::new(AppState { store, bus: Broadcaster::new(), capabilities });

    // Defaults to 0.0.0.0 (LAN-reachable) - deliberately no authentication; run with
    // --bind 127.0.0.1 if you want it restricted to this machine only.
    let bind = args.bind.clone().unwrap_or_else(|| "0.0.0.0".to_string());
    let port = args.port.unwrap_or(DEFAULT_PORT);
    let addr: SocketAddr = match format!("{bind}:{port}").parse() {
        Ok(a) => a,
        Err(e) => {
            error!("Invalid --bind/--port ({bind}:{port}): {e}");
            return;
        }
    };

    let rt = match tokio::runtime::Builder::new_multi_thread().enable_all().build() {
        Ok(rt) => rt,
        Err(e) => {
            error!("Failed to start async runtime: {e}");
            return;
        }
    };

    rt.block_on(async move {
        executor::spawn_executor(state.clone());

        let app = routes::router(state);
        let listener = match tokio::net::TcpListener::bind(addr).await {
            Ok(l) => l,
            Err(e) => {
                error!("Failed to bind {addr}: {e}");
                return;
            }
        };
        info!("hodow serve listening on http://{addr}");
        if let Err(e) = axum::serve(listener, app).await {
            error!("Server error: {e}");
        }
    });
}

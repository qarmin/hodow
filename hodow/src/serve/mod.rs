//! `hodow serve`: the web dashboard and a job queue.
//!
//! A job is a `hodow ...` command line, run as a child process with `--events`; what the child prints as `@hodow`
//! lines becomes the live view, and the child saves its own results exactly as it would from a terminal. Runs started
//! from a terminal show up too (`watch`). The executor is a plain OS thread around blocking subprocess I/O; only the
//! HTTP side is async.

mod api;
mod executor;
mod jobs;
pub mod submit;
mod watch;

use std::collections::{BTreeMap, VecDeque};
use std::net::SocketAddr;
use std::path::PathBuf;
use std::sync::atomic::AtomicBool;
use std::sync::{Arc, Mutex, MutexGuard};

use hodow_common::store::RunMeta;
use hodow_common::{DataDir, RunState, Store};
use jobs::Job;
use log::{error, info, warn};

use crate::cli::ServeArgs;
use crate::probe::Availability;

const DEFAULT_PORT: u16 = 7878;

pub struct Active {
    pub job: Job,
    pub state: RunState,
    pub cancel: Arc<AtomicBool>,
}

/// A run some other process (a terminal) is writing: followed through its event file.
pub struct Foreign {
    pub state: RunState,
    pub offset: u64,
}

#[derive(Default)]
pub struct Live {
    pub next_job: u64,
    pub queue: VecDeque<Job>,
    pub active: Option<Active>,
    pub history: VecDeque<Job>,
    pub foreign: BTreeMap<String, Foreign>,
    pub runs: Vec<RunMeta>,
    pub probes: BTreeMap<String, Availability>,
    /// A re-check of the GPU drivers is under way, and when the last one finished.
    pub probing: bool,
    pub probed_ms: Option<u64>,
}

pub struct AppState {
    pub data_dir: DataDir,
    pub store: Store,
    pub exe: PathBuf,
    pub host: String,
    pub live: Mutex<Live>,
    pub changed: tokio::sync::watch::Sender<u64>,
}

impl AppState {
    pub fn live(&self) -> MutexGuard<'_, Live> {
        self.live.lock().unwrap_or_else(|e| e.into_inner())
    }

    /// Wakes every connected dashboard; they coalesce the wake-ups themselves.
    pub fn bump(&self) {
        self.changed.send_modify(|v| *v += 1);
    }
}

/// The address another machine would reach this one on. UDP `connect` sends nothing.
fn lan_address() -> Option<String> {
    std::net::UdpSocket::bind("0.0.0.0:0")
        .and_then(|s| s.connect("192.0.2.1:9").and_then(|()| s.local_addr()))
        .map(|a| a.ip().to_string())
        .ok()
}

fn display_available() -> bool {
    cfg!(windows) || std::env::var_os("DISPLAY").is_some() || std::env::var_os("WAYLAND_DISPLAY").is_some()
}

fn open_browser(url: &str) {
    #[cfg(windows)]
    let spawned = std::process::Command::new("cmd").args(["/C", "start", "", url]).spawn();
    #[cfg(not(windows))]
    let spawned = std::process::Command::new("xdg-open").arg(url).spawn();
    if let Err(e) = spawned {
        info!("Could not open a browser ({e}); open {url} yourself");
    }
}

pub fn process_serve(args: &ServeArgs) {
    let data_dir = crate::session::data_dir();
    if let Err(e) = data_dir.ensure() {
        error!("Cannot create {}: {e}", data_dir.root().display());
        return;
    }
    let exe = match std::env::current_exe() {
        Ok(p) => p,
        Err(e) => {
            error!("Cannot locate this executable to run jobs with: {e}");
            return;
        }
    };
    let bind = if args.local {
        Some("127.0.0.1".to_string())
    } else {
        args.bind.clone()
    };
    let bind = bind.unwrap_or_else(|| "0.0.0.0".to_string());
    let port = args.port.unwrap_or(DEFAULT_PORT);
    let addr: SocketAddr = match format!("{bind}:{port}").parse() {
        Ok(a) => a,
        Err(e) => {
            error!("Invalid --bind/--port ({bind}:{port}): {e}");
            return;
        }
    };

    let (changed, _) = tokio::sync::watch::channel(0u64);
    let state = Arc::new(AppState {
        store: Store::new(data_dir.results()),
        data_dir,
        exe,
        host: crate::info::summary_line(),
        live: Mutex::new(Live::default()),
        changed,
    });
    let rt = match tokio::runtime::Builder::new_multi_thread().enable_all().build() {
        Ok(rt) => rt,
        Err(e) => {
            error!("Failed to start async runtime: {e}");
            return;
        }
    };
    rt.block_on(async move {
        let listener = match tokio::net::TcpListener::bind(addr).await {
            Ok(l) => l,
            Err(e) => {
                error!("Failed to bind {addr}: {e}");
                return;
            }
        };
        executor::spawn(state.clone());
        watch::spawn(state.clone());

        let local = format!("http://127.0.0.1:{port}");
        info!("hodow dashboard: {local}");
        if addr.ip().is_unspecified() {
            if let Some(lan) = lan_address() {
                info!("                 http://{lan}:{port}  (from other machines)");
            }
            warn!("Listening on every interface with no authentication: anyone who can reach this port can queue tests. Use --local to restrict it to this machine.");
        }
        info!("Results and logs: {}", state.data_dir.root().display());
        if !args.no_open && display_available() {
            open_browser(&local);
        }
        if let Err(e) = axum::serve(listener, api::router(state)).await {
            error!("Server error: {e}");
        }
    });
}

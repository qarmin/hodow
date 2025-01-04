//! The live dashboard: one page, `/api/state` for everything so far and a websocket that
//! pushes what changed once a second. Read-only - it listens on every interface with no
//! authentication, so it must not be able to start or stop anything.

use std::sync::{Arc, Mutex};

use serde::Serialize;

use super::events::RowResult;
use super::sensors::{Sample, SensorInfo};

const KERNEL_LINES: usize = 500;

#[derive(Serialize, Clone)]
pub struct RowView {
    pub name: String,
    pub phase: String,
    pub budget_secs: f64,
    pub started_at: Option<f64>,
    pub result: Option<RowResult>,
}

#[derive(Serialize, Clone)]
pub struct KernelLine {
    pub seq: u64,
    pub text: String,
}

#[derive(Serialize, Clone, Default)]
pub struct DashState {
    pub header: String,
    pub out_dir: String,
    pub info: SensorInfo,
    pub duration_secs: f64,
    pub elapsed: f64,
    pub rows: Vec<RowView>,
    pub current: Option<usize>,
    pub verdict: Option<String>,
    pub samples: Vec<Sample>,
    pub kernel: Vec<KernelLine>,
    pub kernel_seq: u64,
}

impl DashState {
    pub fn push_kernel(&mut self, text: String) {
        self.kernel_seq += 1;
        self.kernel.push(KernelLine {
            seq: self.kernel_seq,
            text,
        });
        if self.kernel.len() > KERNEL_LINES {
            self.kernel.remove(0);
        }
    }

    /// What the websocket sends each second: everything but the sample history, which the
    /// page keeps itself from `/api/state` plus each tick's newest sample.
    #[cfg(feature = "serve")]
    fn tick(&self) -> serde_json::Value {
        serde_json::json!({
            "elapsed": self.elapsed,
            "rows": self.rows,
            "current": self.current,
            "verdict": self.verdict,
            "sample": self.samples.last(),
            "kernel": self.kernel.iter().rev().take(100).collect::<Vec<_>>(),
        })
    }
}

#[derive(Clone, Default)]
pub struct Dash(Option<Arc<Mutex<DashState>>>);

impl Dash {
    pub fn update(&self, f: impl FnOnce(&mut DashState)) {
        if let Some(state) = &self.0 {
            f(&mut state.lock().unwrap_or_else(|e| e.into_inner()));
        }
    }

    pub fn enabled(&self) -> bool {
        self.0.is_some()
    }
}

#[cfg(not(feature = "serve"))]
pub fn start(_port: u16, _initial: DashState) -> Result<Dash, String> {
    Err("this build has no dashboard (the `serve` feature is off)".into())
}

#[cfg(feature = "serve")]
pub fn start(port: u16, initial: DashState) -> Result<Dash, String> {
    use axum::Router;
    use axum::extract::State;
    use axum::extract::ws::{Message, WebSocket, WebSocketUpgrade};
    use axum::response::{Html, IntoResponse};
    use axum::routing::get;

    type Shared = Arc<Mutex<DashState>>;
    static PAGE: &str = include_str!("dashboard.html");

    async fn state(State(shared): State<Shared>) -> impl IntoResponse {
        let body = serde_json::to_string(&*shared.lock().unwrap_or_else(|e| e.into_inner())).unwrap_or_default();
        ([("content-type", "application/json")], body)
    }

    async fn ws(upgrade: WebSocketUpgrade, State(shared): State<Shared>) -> impl IntoResponse {
        upgrade.on_upgrade(move |socket| push(socket, shared))
    }

    async fn push(mut socket: WebSocket, shared: Shared) {
        let mut every = tokio::time::interval(std::time::Duration::from_secs(1));
        loop {
            every.tick().await;
            let text = shared.lock().unwrap_or_else(|e| e.into_inner()).tick().to_string();
            if socket.send(Message::Text(text.into())).await.is_err() {
                break;
            }
        }
    }

    let shared: Shared = Arc::new(Mutex::new(initial));
    let listener =
        std::net::TcpListener::bind(("0.0.0.0", port)).map_err(|e| format!("cannot listen on port {port}: {e}"))?;
    listener.set_nonblocking(true).map_err(|e| e.to_string())?;
    let app = Router::new()
        .route("/", get(|| async { Html(PAGE) }))
        .route("/api/state", get(state))
        .route("/api/ws", get(ws))
        .with_state(shared.clone());
    std::thread::Builder::new()
        .name("burn-dashboard".into())
        .spawn(move || {
            let Ok(runtime) = tokio::runtime::Builder::new_current_thread().enable_all().build() else {
                return;
            };
            runtime.block_on(async move {
                if let Ok(listener) = tokio::net::TcpListener::from_std(listener) {
                    let _ = axum::serve(listener, app).await;
                }
            });
        })
        .map_err(|e| e.to_string())?;
    Ok(Dash(Some(shared)))
}

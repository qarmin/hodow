//! Live-update fan-out: a single `tokio::sync::broadcast` channel, serialized to JSON once
//! per event and pushed to every connected websocket client. Mirrors the pattern used by
//! `system_info_collector`'s dashboard (one shared bus, skip serializing when nobody's
//! listening).

use std::sync::Arc;

use axum::extract::State;
use axum::extract::ws::{Message, WebSocket, WebSocketUpgrade};
use axum::response::IntoResponse;
use serde::Serialize;
use tokio::sync::broadcast;

use super::AppState;
use super::model::{JobId, JobStatus, JobSummary, TestOutcome};

// The shared "Job" prefix is intentional here (these are the only messages this websocket
// ever sends, and the prefix keeps each variant self-descriptive at the call site).
#[allow(clippy::enum_variant_names)]
#[derive(Serialize, Clone)]
#[serde(tag = "type", rename_all = "snake_case")]
pub enum WsMessage {
    JobStarted { id: JobId },
    JobProgress { id: JobId, idx: usize, name: String, outcome: TestOutcome },
    JobFinished { id: JobId, status: JobStatus, summary: JobSummary },
}

pub struct Broadcaster {
    tx: broadcast::Sender<WsMessage>,
}

impl Broadcaster {
    pub fn new() -> Self {
        let (tx, _rx) = broadcast::channel(1024);
        Broadcaster { tx }
    }

    /// Only serializes/sends if at least one client is connected.
    pub fn send(&self, msg: WsMessage) {
        if self.tx.receiver_count() > 0 {
            let _ = self.tx.send(msg);
        }
    }

    pub fn subscribe(&self) -> broadcast::Receiver<WsMessage> {
        self.tx.subscribe()
    }
}

pub async fn ws_handler(ws: WebSocketUpgrade, State(state): State<Arc<AppState>>) -> impl IntoResponse {
    ws.on_upgrade(move |socket| handle_socket(socket, state))
}

async fn handle_socket(mut socket: WebSocket, state: Arc<AppState>) {
    let mut rx = state.bus.subscribe();
    loop {
        tokio::select! {
            msg = rx.recv() => {
                match msg {
                    Ok(m) => {
                        let text = serde_json::to_string(&m).unwrap_or_default();
                        if socket.send(Message::Text(text.into())).await.is_err() {
                            break;
                        }
                    }
                    // A slow client fell behind the broadcast buffer - just resume from
                    // "now" rather than trying to replay the gap; it can re-fetch
                    // /api/snapshot for anything it missed.
                    Err(broadcast::error::RecvError::Lagged(_)) => continue,
                    Err(broadcast::error::RecvError::Closed) => break,
                }
            }
            incoming = socket.recv() => {
                if incoming.is_none() {
                    break;
                }
            }
        }
    }
}

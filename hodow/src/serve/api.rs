//! The HTTP side: the dashboard's files, a JSON API over the results store and the job queue, and one WebSocket that
//! pushes the whole live state whenever it changes.

use std::sync::Arc;
use std::sync::atomic::Ordering;
use std::time::Duration;

use axum::extract::ws::{Message, WebSocket, WebSocketUpgrade};
use axum::extract::{Path, Query, State};
use axum::http::{StatusCode, header};
use axum::response::{Html, IntoResponse, Response};
use axum::routing::{delete, get, post};
use axum::{Json, Router};
use hodow_common::time::now_ms;
use hodow_common::{Event, Finding, RunStatus, Verdict};
use serde::Deserialize;
use serde_json::{Value, json};

use super::jobs::{self, Job, JobStatus};
use super::{AppState, watch};

const INDEX_HTML: &str = include_str!("ui/index.html");
const APP_JS: &str = include_str!("ui/app.js");
const HELP_JS: &str = include_str!("ui/help.js");
const STYLE_CSS: &str = include_str!("ui/style.css");
const MAX_QUEUE: usize = 50;
const MAX_PAGE: usize = 500;
const PUSH_EVERY: Duration = Duration::from_millis(250);
const HEARTBEAT: Duration = Duration::from_secs(2);

/// Every kind of run a card is shown for, in display order: key (the module name in a run's record), title, what it
/// answers.
const MODULES: &[(&str, &str, &str)] = &[
    (
        "cpu",
        "CPU instructions",
        "Every SIMD intrinsic against a value captured on real hardware",
    ),
    (
        "gl",
        "OpenGL",
        "Driver behaviour: framebuffers, shaders, compute, queries",
    ),
    (
        "vulkan",
        "Vulkan compute",
        "A compute kernel with a known answer on every device",
    ),
    (
        "stress",
        "CPU stress",
        "The whole suite on every core at once, results compared between cores",
    ),
    (
        "burn",
        "Burn-in",
        "CPU, RAM and GPU loaded as hard as basic operations can, every result checked",
    ),
    (
        "bench",
        "Benchmarks",
        "Image kernels timed on the CPU and every GPU API, checked against a reference",
    ),
    (
        "gpu-memtest",
        "GPU memory",
        "Bit patterns written to GPU memory and read back",
    ),
    (
        "cts",
        "Khronos CTS",
        "The conformance suites, case by case, compared with upstream",
    ),
];

pub fn router(state: Arc<AppState>) -> Router {
    Router::new()
        .route("/", get(|| async { Html(INDEX_HTML) }))
        .route(
            "/app.js",
            get(|| async { ([(header::CONTENT_TYPE, "text/javascript; charset=utf-8")], APP_JS) }),
        )
        .route(
            "/help.js",
            get(|| async { ([(header::CONTENT_TYPE, "text/javascript; charset=utf-8")], HELP_JS) }),
        )
        .route(
            "/style.css",
            get(|| async { ([(header::CONTENT_TYPE, "text/css; charset=utf-8")], STYLE_CSS) }),
        )
        .route("/api/state", get(get_state))
        .route("/api/runs", get(list_runs))
        .route("/api/runs/{id}", get(get_run).delete(delete_run))
        .route("/api/runs/{id}/findings", get(get_findings))
        .route("/api/runs/{id}/files/{name}", get(get_file))
        .route("/api/runs/{id}/pin", post(pin_run))
        .route("/api/runs/{id}/cancel", post(cancel_run))
        .route("/api/jobs", post(submit_job))
        .route("/api/jobs/{id}", delete(cancel_job))
        .route("/api/probe", post(reprobe))
        .route("/ws", get(ws_handler))
        .with_state(state)
}

fn module_of_runs<'a>(live: &'a super::Live, key: &str) -> Option<&'a hodow_common::store::RunMeta> {
    live.runs.iter().find(|r| r.module == key && r.status.is_finished())
}

pub fn snapshot(state: &AppState) -> Value {
    let now = now_ms();
    let live = state.live();
    let modules: Vec<Value> = MODULES
        .iter()
        .map(|(key, title, about)| {
            let running = live.active.as_ref().is_some_and(|a| a.job.module == *key)
                || live.foreign.values().any(|f| f.state.module == *key);
            json!({
                "key": key,
                "title": title,
                "about": about,
                "availability": live.probes.get(if *key == "gpu-memtest" { "gl" } else { key }),
                "last_run": module_of_runs(&live, key),
                "running": running,
            })
        })
        .collect();
    let active = live
        .active
        .as_ref()
        .map(|a| json!({ "job": a.job, "run": a.state.snapshot(now) }));
    let foreign: Vec<Value> = live
        .foreign
        .iter()
        .map(|(id, f)| {
            let cancellable = live
                .runs
                .iter()
                .any(|r| &r.id == id && super::leftovers::is_server_job(r));
            json!({ "id": id, "run": f.state.snapshot(now), "cancellable": cancellable })
        })
        .collect();
    json!({
        "now": now,
        "host": state.host,
        "version": env!("CARGO_PKG_VERSION"),
        "data_dir": state.data_dir.root().display().to_string(),
        "modules": modules,
        "probe": { "running": live.probing, "finished_ms": live.probed_ms },
        "queue": live.queue,
        "active": active,
        "foreign": foreign,
        "recent_jobs": live.history,
        "runs": live.runs.iter().take(100).collect::<Vec<_>>(),
    })
}

async fn get_state(State(state): State<Arc<AppState>>) -> Json<Value> {
    Json(snapshot(&state))
}

async fn list_runs(State(state): State<Arc<AppState>>) -> Json<Value> {
    let runs: Vec<Value> = state
        .live()
        .runs
        .iter()
        .map(|r| json!({ "meta": r, "pinned": state.store.is_pinned(&r.id) }))
        .collect();
    Json(json!({ "runs": runs }))
}

fn not_found() -> Response {
    (StatusCode::NOT_FOUND, Json(json!({ "error": "no such run" }))).into_response()
}

fn artifacts(dir: &std::path::Path) -> Vec<String> {
    let mut names: Vec<String> = std::fs::read_dir(dir)
        .into_iter()
        .flatten()
        .filter_map(Result::ok)
        .filter(|e| e.file_type().is_ok_and(|t| t.is_file()))
        .filter_map(|e| e.file_name().into_string().ok())
        .filter(|n| !n.starts_with("events.jsonl") && !n.starts_with("meta.json") && n != "pinned")
        .collect();
    names.sort();
    names
}

async fn get_run(State(state): State<Arc<AppState>>, Path(id): Path<String>) -> Response {
    let Some(meta) = state.store.meta(&id) else {
        return not_found();
    };
    let dir = state.store.run_dir(&id).unwrap_or_default();
    Json(json!({ "meta": meta, "pinned": state.store.is_pinned(&id), "files": artifacts(&dir) })).into_response()
}

async fn delete_run(State(state): State<Arc<AppState>>, Path(id): Path<String>) -> Response {
    let Some(meta) = state.store.meta(&id) else {
        return not_found();
    };
    if meta.status == RunStatus::Running || state.store.is_pinned(&id) {
        return (
            StatusCode::CONFLICT,
            Json(json!({ "error": "a running or pinned run is not removed" })),
        )
            .into_response();
    }
    match state.store.remove(&id) {
        Ok(()) => {
            watch::refresh_runs(&state);
            Json(json!({ "ok": true })).into_response()
        }
        Err(e) => (
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(json!({ "error": e.to_string() })),
        )
            .into_response(),
    }
}

#[derive(Deserialize)]
struct FindingsQuery {
    verdict: Option<String>,
    q: Option<String>,
    offset: Option<usize>,
    limit: Option<usize>,
    /// `verdict` (worst first by default), `name`, `time` or `detail`; without it the findings keep the order they came in.
    sort: Option<String>,
    /// `asc` or `desc`: the default is the natural one for the column (worst and slowest first).
    dir: Option<String>,
}

fn sort_findings(items: &mut [Finding], key: &str, descending: bool) {
    match key {
        "name" => items.sort_by(|a, b| a.name.cmp(&b.name)),
        "time" => items.sort_by_key(|f| f.duration_us.unwrap_or(0)),
        "detail" => items.sort_by(|a, b| a.detail.cmp(&b.detail)),
        _ => items.sort_by_key(|f| f.verdict as u8),
    }
    if descending {
        items.reverse();
    }
}

fn collect_findings(state: &AppState, id: &str, query: &FindingsQuery) -> std::io::Result<Value> {
    let wanted: Option<Verdict> = match query.verdict.as_deref() {
        None | Some("notable" | "all" | "") => None,
        Some(v) => serde_json::from_value(Value::String(v.to_string())).ok(),
    };
    let only_notable = matches!(query.verdict.as_deref(), None | Some("notable" | ""));
    let needle = query.q.as_deref().filter(|q| !q.is_empty()).map(str::to_lowercase);
    let (offset, limit) = (query.offset.unwrap_or(0), query.limit.unwrap_or(100).min(MAX_PAGE));
    let sort = query
        .sort
        .as_deref()
        .filter(|k| matches!(*k, "verdict" | "name" | "time" | "detail"));
    let (mut total, mut items) = (0usize, Vec::new());
    let mut events = state.store.read_events(id)?;
    for record in events.by_ref().filter_map(Result::ok) {
        let Event::Finding(f) = record.event else { continue };
        if only_notable && !f.verdict.is_notable() || wanted.is_some_and(|w| f.verdict != w) {
            continue;
        }
        if let Some(needle) = &needle
            && !f.name.to_lowercase().contains(needle)
            && !f.detail.as_deref().unwrap_or("").to_lowercase().contains(needle)
        {
            continue;
        }
        if sort.is_some() || (total >= offset && items.len() < limit) {
            items.push(f);
        }
        total += 1;
    }
    if let Some(key) = sort {
        let natural_descending = matches!(key, "verdict" | "time");
        let descending = match query.dir.as_deref() {
            Some("asc") => false,
            Some("desc") => true,
            _ => natural_descending,
        };
        sort_findings(&mut items, key, descending);
        items = items.into_iter().skip(offset).take(limit).collect();
    }
    Ok(json!({ "total": total, "offset": offset, "items": items }))
}

async fn get_findings(
    State(state): State<Arc<AppState>>,
    Path(id): Path<String>,
    Query(query): Query<FindingsQuery>,
) -> Response {
    if state.store.meta(&id).is_none() {
        return not_found();
    }
    match tokio::task::spawn_blocking(move || collect_findings(&state, &id, &query)).await {
        Ok(Ok(value)) => Json(value).into_response(),
        Ok(Err(e)) => (StatusCode::NOT_FOUND, Json(json!({ "error": e.to_string() }))).into_response(),
        Err(_) => StatusCode::INTERNAL_SERVER_ERROR.into_response(),
    }
}

async fn get_file(State(state): State<Arc<AppState>>, Path((id, name)): Path<(String, String)>) -> Response {
    let Some(dir) = state.store.run_dir(&id) else {
        return not_found();
    };
    let plain = name
        .bytes()
        .all(|b| b.is_ascii_alphanumeric() || matches!(b, b'-' | b'_' | b'.'))
        && !name.starts_with('.');
    if !plain || name.starts_with("events.jsonl") || name.starts_with("meta.json") {
        return not_found();
    }
    let kind = match name.rsplit('.').next() {
        Some("html") => "text/html; charset=utf-8",
        Some("json") => "application/json",
        _ => "text/plain; charset=utf-8",
    };
    match std::fs::read(dir.join(&name)) {
        Ok(bytes) => ([(header::CONTENT_TYPE, kind)], bytes).into_response(),
        Err(_) => not_found(),
    }
}

#[derive(Deserialize)]
struct PinBody {
    pinned: bool,
}

async fn pin_run(State(state): State<Arc<AppState>>, Path(id): Path<String>, Json(body): Json<PinBody>) -> Response {
    match state.store.pin(&id, body.pinned) {
        Ok(()) => Json(json!({ "ok": true })).into_response(),
        Err(_) => not_found(),
    }
}

/// Stops a run that belongs to no live job of this server (one an earlier server left behind). A run a person started in a
/// terminal, or the job this server is running now (it has Stop), is refused.
async fn cancel_run(State(state): State<Arc<AppState>>, Path(id): Path<String>) -> Response {
    let Some(meta) = state.store.meta(&id) else {
        return not_found();
    };
    let ours = state.live().active.as_ref().and_then(|a| a.job.run.clone());
    if meta.status != RunStatus::Running
        || ours.as_deref() == Some(id.as_str())
        || !super::leftovers::is_server_job(&meta)
    {
        return (
            StatusCode::CONFLICT,
            Json(json!({ "error": "only a run left running by an earlier server can be cancelled here" })),
        )
            .into_response();
    }
    let store_state = state.clone();
    let _ = tokio::task::spawn_blocking(move || super::leftovers::stop_run(&store_state.store, &meta)).await;
    watch::refresh_runs(&state);
    Json(json!({ "ok": true })).into_response()
}

#[derive(Deserialize)]
struct JobBody {
    args: Vec<String>,
}

async fn submit_job(State(state): State<Arc<AppState>>, Json(body): Json<JobBody>) -> Response {
    let validated = match jobs::validate(&body.args) {
        Ok(v) => v,
        Err(message) => return (StatusCode::BAD_REQUEST, Json(json!({ "error": message }))).into_response(),
    };
    let mut live = state.live();
    if live.queue.len() >= MAX_QUEUE {
        return (
            StatusCode::SERVICE_UNAVAILABLE,
            Json(json!({ "error": "the queue is full" })),
        )
            .into_response();
    }
    live.next_job += 1;
    let id = live.next_job;
    live.queue.push_back(Job {
        id,
        module: validated.module.to_string(),
        args: validated.args,
        status: JobStatus::Queued,
        submitted_ms: now_ms(),
        started_ms: None,
        finished_ms: None,
        run: None,
        exit_code: None,
    });
    drop(live);
    state.bump();
    Json(json!({ "id": id })).into_response()
}

async fn cancel_job(State(state): State<Arc<AppState>>, Path(id): Path<u64>) -> Response {
    let mut live = state.live();
    if let Some(position) = live.queue.iter().position(|j| j.id == id) {
        let mut job = live.queue.remove(position).expect("the position was just found");
        job.status = JobStatus::Cancelled;
        job.finished_ms = Some(now_ms());
        live.history.push_front(job);
        drop(live);
        state.bump();
        return Json(json!({ "ok": true })).into_response();
    }
    if let Some(active) = live.active.as_ref().filter(|a| a.job.id == id) {
        active.cancel.store(true, Ordering::Relaxed);
        return Json(json!({ "ok": true })).into_response();
    }
    (StatusCode::NOT_FOUND, Json(json!({ "error": "no such job" }))).into_response()
}

async fn reprobe(State(state): State<Arc<AppState>>) -> Json<Value> {
    let started = watch::probe_gpu_in_background(state);
    Json(json!({ "ok": true, "started": started }))
}

async fn ws_handler(ws: WebSocketUpgrade, State(state): State<Arc<AppState>>) -> impl IntoResponse {
    ws.on_upgrade(move |socket| push_state(socket, state))
}

async fn push_state(mut socket: WebSocket, state: Arc<AppState>) {
    let mut changes = state.changed.subscribe();
    loop {
        let text = snapshot(&state).to_string();
        if socket.send(Message::Text(text.into())).await.is_err() {
            return;
        }
        tokio::select! {
            changed = changes.changed() => {
                if changed.is_err() {
                    return;
                }
            }
            () = tokio::time::sleep(HEARTBEAT) => {}
            incoming = socket.recv() => {
                match incoming {
                    None | Some(Err(_) | Ok(Message::Close(_))) => return,
                    Some(Ok(_)) => {}
                }
            }
        }
        // Coalesce a burst of events into one frame.
        tokio::time::sleep(PUSH_EVERY).await;
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn finding(name: &str, verdict: Verdict, micros: Option<u64>) -> Finding {
        let finding = Finding::new(name, verdict);
        match micros {
            Some(us) => finding.duration_us(us),
            None => finding,
        }
    }

    fn names(items: &[Finding]) -> Vec<&str> {
        items.iter().map(|f| f.name.as_str()).collect()
    }

    #[test]
    fn findings_sort_by_the_chosen_column_in_either_direction() {
        let mut items = vec![
            finding("b", Verdict::Passed, Some(5)),
            finding("c", Verdict::Crashed, None),
            finding("a", Verdict::Failed, Some(9)),
        ];
        sort_findings(&mut items, "name", false);
        assert_eq!(names(&items), ["a", "b", "c"]);
        sort_findings(&mut items, "verdict", true);
        assert_eq!(names(&items), ["c", "a", "b"]);
        sort_findings(&mut items, "time", true);
        assert_eq!(names(&items), ["a", "b", "c"]);
        sort_findings(&mut items, "time", false);
        assert_eq!(names(&items), ["c", "b", "a"]);
    }
}

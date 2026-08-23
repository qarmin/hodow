//! REST + dashboard routes. All job-submission/read logic lives in `Store`; handlers here
//! are thin adapters between axum and it.

use std::sync::Arc;

use axum::extract::{Path, State};
use axum::http::StatusCode;
use axum::response::Html;
use axum::routing::get;
use axum::{Json, Router};

use super::AppState;
use super::model::{JobId, JobKind, JobStatus};
use super::ws::ws_handler;

static INDEX_HTML: &str = include_str!("index.html");

pub fn router(state: Arc<AppState>) -> Router {
    Router::new()
        .route("/", get(index))
        .route("/api/info", get(info))
        .route("/api/jobs", get(snapshot).post(submit_job))
        .route("/api/jobs/{id}", get(job_detail).delete(cancel_job))
        .route("/api/ws", get(ws_handler))
        .with_state(state)
}

async fn index() -> Html<&'static str> {
    Html(INDEX_HTML)
}

async fn info(State(state): State<Arc<AppState>>) -> Json<super::Capabilities> {
    Json(state.capabilities.clone())
}

async fn submit_job(State(state): State<Arc<AppState>>, Json(kind): Json<JobKind>) -> Result<Json<serde_json::Value>, StatusCode> {
    state.store.submit(kind).map(|id| Json(serde_json::json!({ "id": id }))).map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)
}

async fn snapshot(State(state): State<Arc<AppState>>) -> Json<serde_json::Value> {
    let jobs = state.store.snapshot();
    let running_job_id = jobs.iter().find(|j| j.status == JobStatus::Running).map(|j| j.id);
    Json(serde_json::json!({ "jobs": jobs, "running_job_id": running_job_id }))
}

async fn job_detail(State(state): State<Arc<AppState>>, Path(id): Path<JobId>) -> Result<Json<serde_json::Value>, StatusCode> {
    let record = state.store.get(id).ok_or(StatusCode::NOT_FOUND)?;
    let events = state.store.read_events(id);
    Ok(Json(serde_json::json!({ "record": record, "events": events })))
}

async fn cancel_job(State(state): State<Arc<AppState>>, Path(id): Path<JobId>) -> StatusCode {
    if state.store.cancel_queued(id) { StatusCode::OK } else { StatusCode::CONFLICT }
}

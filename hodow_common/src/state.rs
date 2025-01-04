use std::collections::VecDeque;

use serde::Serialize;

use crate::event::{Event, Finding, Level, RunStatus, Summary};
use crate::tree::{NodeView, ProgressTree};

pub const NOTABLE_CAP: usize = 200;
pub const LOG_CAP: usize = 200;

/// Everything a live view of one run needs, built by feeding it the run's events. Bounded: counters and the tree
/// stay small however many tests pass, and only the latest non-passing findings are kept.
#[derive(Debug)]
pub struct RunState {
    pub module: String,
    pub title: String,
    pub status: RunStatus,
    pub started_ms: u64,
    pub finished_ms: Option<u64>,
    pub summary: Summary,
    pub tree: ProgressTree,
    pub notable: VecDeque<Finding>,
    pub notable_dropped: u64,
    pub logs: VecDeque<(Level, String)>,
}

#[derive(Serialize, Debug)]
pub struct StateSnapshot<'a> {
    pub module: &'a str,
    pub title: &'a str,
    pub status: RunStatus,
    pub elapsed_ms: u64,
    pub summary: &'a Summary,
    pub steps: Vec<NodeView>,
    pub notable: &'a VecDeque<Finding>,
    pub notable_dropped: u64,
    pub logs: &'a VecDeque<(Level, String)>,
}

impl RunState {
    pub fn new(module: impl Into<String>, title: impl Into<String>, now_ms: u64) -> Self {
        Self {
            module: module.into(),
            title: title.into(),
            status: RunStatus::Running,
            started_ms: now_ms,
            finished_ms: None,
            summary: Summary::default(),
            tree: ProgressTree::default(),
            notable: VecDeque::new(),
            notable_dropped: 0,
            logs: VecDeque::new(),
        }
    }

    pub fn apply(&mut self, event: &Event, now_ms: u64) {
        match event {
            Event::RunStarted { module, title, .. } => {
                self.module.clone_from(module);
                self.title.clone_from(title);
            }
            Event::StepStarted {
                id,
                parent,
                label,
                unit,
                total,
                weight,
            } => {
                self.tree
                    .start(*id, *parent, label, unit.as_deref(), *total, *weight, now_ms);
            }
            Event::StepProgress {
                id,
                done,
                total,
                current,
            } => {
                self.tree.progress(*id, *done, *total, current.as_deref(), now_ms);
            }
            Event::StepFinished { id, outcome } => self.tree.finish(*id, *outcome, now_ms),
            Event::Finding(finding) => {
                self.summary.add(finding.verdict);
                if finding.verdict.is_notable() {
                    if self.notable.len() == NOTABLE_CAP {
                        self.notable.pop_front();
                        self.notable_dropped += 1;
                    }
                    self.notable.push_back(finding.clone());
                }
            }
            Event::Log { level, message } => {
                if self.logs.len() == LOG_CAP {
                    self.logs.pop_front();
                }
                self.logs.push_back((*level, message.clone()));
            }
            Event::RunFinished { status, summary } => {
                self.status = *status;
                self.summary = summary.clone();
                self.finished_ms = Some(now_ms);
            }
        }
    }

    /// A line that did not come from the run's own events, e.g. what its process wrote to stderr.
    pub fn push_log(&mut self, level: Level, message: String) {
        if self.logs.len() == LOG_CAP {
            self.logs.pop_front();
        }
        self.logs.push_back((level, message));
    }

    pub fn snapshot(&self, now_ms: u64) -> StateSnapshot<'_> {
        StateSnapshot {
            module: &self.module,
            title: &self.title,
            status: self.status,
            elapsed_ms: self.finished_ms.unwrap_or(now_ms).saturating_sub(self.started_ms),
            summary: &self.summary,
            steps: self.tree.snapshot(now_ms),
            notable: &self.notable,
            notable_dropped: self.notable_dropped,
            logs: &self.logs,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::event::Verdict;

    #[test]
    fn a_hundred_thousand_passes_leave_the_state_small() {
        let mut state = RunState::new("cpu", "CPU", 0);
        for i in 0..100_000 {
            state.apply(&Event::Finding(Finding::new(format!("t{i}"), Verdict::Passed)), i);
        }
        assert_eq!(
            (state.summary.total, state.summary.passed, state.notable.len()),
            (100_000, 100_000, 0)
        );
    }

    #[test]
    fn only_the_latest_notable_findings_are_kept_and_the_rest_counted() {
        let mut state = RunState::new("cpu", "CPU", 0);
        for i in 0..(NOTABLE_CAP + 5) {
            state.apply(&Event::Finding(Finding::new(format!("t{i}"), Verdict::Unverified)), 0);
        }
        assert_eq!((state.notable.len(), state.notable_dropped), (NOTABLE_CAP, 5));
        assert_eq!(state.notable.front().unwrap().name, "t5");
        assert_eq!(state.summary.unverified, (NOTABLE_CAP + 5) as u64);
    }

    #[test]
    fn the_snapshot_serializes_with_the_tree_in_it() {
        let mut state = RunState::new("cpu", "CPU", 0);
        state.apply(
            &Event::StepStarted {
                id: 1,
                parent: None,
                label: "avx".into(),
                unit: None,
                total: Some(10),
                weight: None,
            },
            0,
        );
        let json = serde_json::to_value(state.snapshot(1500)).unwrap();
        assert_eq!(json["elapsed_ms"], 1500);
        assert_eq!(json["steps"][0]["label"], "avx");
        assert_eq!(json["status"], "running");
    }

    #[test]
    fn run_finished_sets_the_status_and_the_final_summary() {
        let mut state = RunState::new("cpu", "CPU", 10);
        let mut summary = Summary::default();
        summary.add(Verdict::Failed);
        state.apply(
            &Event::RunFinished {
                status: RunStatus::Failed,
                summary,
            },
            50,
        );
        assert_eq!(
            (state.status, state.summary.failed, state.finished_ms),
            (RunStatus::Failed, 1, Some(50))
        );
    }
}

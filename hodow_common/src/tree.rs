use std::collections::HashMap;

use serde::Serialize;

use crate::event::{StepId, StepOutcome};

const MIN_SAMPLE_MS: u64 = 200;
const RATE_SMOOTHING: f64 = 0.3;
const SAMPLES_FOR_ETA: u32 = 3;
const NEVER_COMPLETE: f64 = 0.999;

#[derive(Serialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum NodeState {
    Running,
    Done,
    Failed,
    Skipped,
    Cancelled,
}

impl From<StepOutcome> for NodeState {
    fn from(outcome: StepOutcome) -> Self {
        match outcome {
            StepOutcome::Done => Self::Done,
            StepOutcome::Failed => Self::Failed,
            StepOutcome::Skipped => Self::Skipped,
            StepOutcome::Cancelled => Self::Cancelled,
        }
    }
}

#[derive(Debug)]
struct Node {
    parent: Option<StepId>,
    children: Vec<StepId>,
    label: String,
    unit: Option<String>,
    total: Option<u64>,
    done: u64,
    /// Findings reported for this step: the only progress a reader that never sees progress events (a run in a file) has.
    counted: u64,
    current: Option<String>,
    weight: Option<f64>,
    progress_driven: bool,
    outcome: Option<StepOutcome>,
    started_ms: u64,
    finished_ms: Option<u64>,
    rate: Option<f64>,
    samples: u32,
    last_ms: u64,
    last_done: u64,
}

/// One step as a viewer sees it, derived values included. `fraction` is `None` for an indeterminate step, and
/// stays below 1.0 until the step has finished.
#[derive(Serialize, Clone, Debug, PartialEq)]
pub struct NodeView {
    pub id: StepId,
    pub parent: Option<StepId>,
    pub depth: u32,
    pub label: String,
    pub unit: Option<String>,
    pub done: u64,
    pub total: Option<u64>,
    pub current: Option<String>,
    pub state: NodeState,
    pub fraction: Option<f64>,
    pub rate: Option<f64>,
    pub eta_secs: Option<u64>,
    pub elapsed_ms: u64,
}

#[derive(Default, Debug)]
pub struct ProgressTree {
    nodes: HashMap<StepId, Node>,
    roots: Vec<StepId>,
}

impl ProgressTree {
    pub fn is_empty(&self) -> bool {
        self.nodes.is_empty()
    }

    pub fn start(
        &mut self,
        id: StepId,
        parent: Option<StepId>,
        label: &str,
        unit: Option<&str>,
        total: Option<u64>,
        weight: Option<f64>,
        now_ms: u64,
    ) {
        let parent = parent.filter(|p| self.nodes.contains_key(p));
        match parent {
            Some(p) => {
                if let Some(node) = self.nodes.get_mut(&p) {
                    node.children.push(id);
                }
            }
            None => self.roots.push(id),
        }
        self.nodes.insert(
            id,
            Node {
                parent,
                children: Vec::new(),
                label: label.to_owned(),
                unit: unit.map(str::to_owned),
                total,
                done: 0,
                counted: 0,
                current: None,
                weight,
                progress_driven: false,
                outcome: None,
                started_ms: now_ms,
                finished_ms: None,
                rate: None,
                samples: 0,
                last_ms: now_ms,
                last_done: 0,
            },
        );
    }

    pub fn progress(&mut self, id: StepId, done: u64, total: Option<u64>, current: Option<&str>, now_ms: u64) {
        let Some(node) = self.nodes.get_mut(&id) else { return };
        node.progress_driven = true;
        if total.is_some() {
            node.total = total;
        }
        if let Some(current) = current {
            node.current = Some(current.to_owned());
        }
        if node.samples == 0 || done < node.last_done {
            node.samples = 1;
            node.rate = None;
        } else if now_ms.saturating_sub(node.last_ms) >= MIN_SAMPLE_MS {
            let instant = (done - node.last_done) as f64 * 1000.0 / (now_ms - node.last_ms) as f64;
            node.rate = Some(match node.rate {
                Some(rate) => RATE_SMOOTHING * instant + (1.0 - RATE_SMOOTHING) * rate,
                None => instant,
            });
            node.samples += 1;
        } else {
            node.done = done;
            return;
        }
        node.done = done;
        node.last_ms = now_ms;
        node.last_done = done;
    }

    /// One more result belongs to this step. Only shows while no progress event has ever arrived for it.
    pub fn count_result(&mut self, id: StepId) {
        if let Some(node) = self.nodes.get_mut(&id) {
            node.counted += 1;
        }
    }

    /// Finishing a step closes everything still running below it.
    pub fn finish(&mut self, id: StepId, outcome: StepOutcome, now_ms: u64) {
        let children = match self.nodes.get_mut(&id) {
            Some(node) if node.outcome.is_none() => {
                node.outcome = Some(outcome);
                node.finished_ms = Some(now_ms);
                node.children.clone()
            }
            _ => return,
        };
        for child in children {
            self.finish(child, StepOutcome::Cancelled, now_ms);
        }
    }

    fn effective_done(&self, node: &Node) -> u64 {
        if node.progress_driven {
            return node.done;
        }
        if node.total.is_none() {
            return node.counted;
        }
        node.counted
            + node
                .children
                .iter()
                .filter(|c| self.nodes.get(c).is_some_and(|n| n.outcome.is_some()))
                .count() as u64
    }

    pub fn fraction(&self, id: StepId) -> Option<f64> {
        let node = self.nodes.get(&id)?;
        if node.outcome.is_some() {
            return Some(1.0);
        }
        if let Some(total) = node.total.filter(|t| *t > 0) {
            return Some((self.effective_done(node) as f64 / total as f64).min(NEVER_COMPLETE));
        }
        let weights: Option<Vec<f64>> = node.children.iter().map(|c| self.nodes.get(c)?.weight).collect();
        let weights = weights.filter(|w| !w.is_empty() && w.iter().sum::<f64>() > 0.0)?;
        let sum: f64 = weights.iter().sum();
        let weighted: f64 = node
            .children
            .iter()
            .zip(&weights)
            .map(|(c, w)| w * self.fraction(*c).unwrap_or(0.0))
            .sum();
        Some((weighted / sum).min(NEVER_COMPLETE))
    }

    fn eta_secs(&self, node: &Node) -> Option<u64> {
        let total = node.total?;
        let done = self.effective_done(node);
        let rate = node.rate.filter(|r| *r > 0.0)?;
        (node.outcome.is_none() && node.progress_driven && node.samples >= SAMPLES_FOR_ETA && done < total)
            .then(|| ((total - done) as f64 / rate).ceil() as u64)
    }

    pub fn snapshot(&self, now_ms: u64) -> Vec<NodeView> {
        let mut out = Vec::with_capacity(self.nodes.len());
        for root in &self.roots {
            self.collect(*root, 0, now_ms, &mut out);
        }
        out
    }

    fn collect(&self, id: StepId, depth: u32, now_ms: u64, out: &mut Vec<NodeView>) {
        let Some(node) = self.nodes.get(&id) else { return };
        out.push(NodeView {
            id,
            parent: node.parent,
            depth,
            label: node.label.clone(),
            unit: node.unit.clone(),
            done: self.effective_done(node),
            total: node.total,
            current: node.current.clone(),
            state: node.outcome.map_or(NodeState::Running, NodeState::from),
            fraction: self.fraction(id),
            rate: node.rate,
            eta_secs: self.eta_secs(node),
            elapsed_ms: node.finished_ms.unwrap_or(now_ms).saturating_sub(node.started_ms),
        });
        for child in &node.children {
            self.collect(*child, depth + 1, now_ms, out);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn view(tree: &ProgressTree, id: StepId) -> NodeView {
        tree.snapshot(0).into_iter().find(|n| n.id == id).unwrap()
    }

    #[test]
    fn a_counted_step_never_reads_complete_before_it_finishes() {
        let mut t = ProgressTree::default();
        t.start(1, None, "cpu", Some("tests"), Some(100), None, 0);
        t.progress(1, 50, None, Some("_mm_add_ps"), 10);
        assert_eq!(view(&t, 1).fraction, Some(0.5));
        t.progress(1, 100, None, None, 20);
        let almost = view(&t, 1).fraction.unwrap();
        assert!(almost > 0.99 && almost < 1.0, "{almost}");
        t.finish(1, StepOutcome::Done, 30);
        assert_eq!(view(&t, 1).fraction, Some(1.0));
        assert_eq!(view(&t, 1).current.as_deref(), Some("_mm_add_ps"));
    }

    #[test]
    fn results_alone_move_a_step_that_never_gets_progress_events() {
        let mut t = ProgressTree::default();
        t.start(1, None, "Cases", Some("cases"), Some(100), None, 0);
        for _ in 0..25 {
            t.count_result(1);
        }
        assert_eq!((view(&t, 1).done, view(&t, 1).fraction), (25, Some(0.25)));
        t.progress(1, 40, None, None, 10);
        t.count_result(1);
        assert_eq!(view(&t, 1).done, 40);
    }

    #[test]
    fn an_unknown_total_is_indeterminate_until_one_appears() {
        let mut t = ProgressTree::default();
        t.start(1, None, "group", None, None, None, 0);
        t.progress(1, 302, None, None, 10);
        let v = view(&t, 1);
        assert_eq!((v.done, v.total, v.fraction), (302, None, None));
        t.progress(1, 400, Some(1000), None, 20);
        assert_eq!(view(&t, 1).fraction, Some(0.4));
    }

    #[test]
    fn a_parent_counts_finished_phases_when_it_reports_nothing_itself() {
        let mut t = ProgressTree::default();
        t.start(1, None, "burn", Some("phases"), Some(4), None, 0);
        t.start(2, Some(1), "cpu", None, None, None, 0);
        t.finish(2, StepOutcome::Done, 5);
        t.start(3, Some(1), "ram", None, None, None, 5);
        let v = view(&t, 1);
        assert_eq!((v.done, v.total, v.fraction), (1, Some(4), Some(0.25)));
    }

    #[test]
    fn weights_combine_only_when_every_child_declares_one() {
        let mut t = ProgressTree::default();
        t.start(1, None, "bench", None, None, None, 0);
        t.start(2, Some(1), "a", None, Some(10), Some(3.0), 0);
        t.start(3, Some(1), "b", None, Some(10), Some(1.0), 0);
        t.progress(2, 10, None, None, 1);
        t.finish(2, StepOutcome::Done, 1);
        assert_eq!(view(&t, 1).fraction, Some(0.75));
        t.start(4, Some(1), "c", None, None, None, 2);
        assert_eq!(view(&t, 1).fraction, None);
    }

    #[test]
    fn finishing_a_parent_cancels_what_is_still_running_below() {
        let mut t = ProgressTree::default();
        t.start(1, None, "a", None, None, None, 0);
        t.start(2, Some(1), "b", None, None, None, 0);
        t.finish(1, StepOutcome::Failed, 9);
        assert_eq!(view(&t, 2).state, NodeState::Cancelled);
        assert_eq!(view(&t, 1).state, NodeState::Failed);
    }

    #[test]
    fn eta_needs_a_known_total_and_a_few_samples() {
        let mut t = ProgressTree::default();
        t.start(1, None, "x", Some("items"), Some(1000), None, 0);
        t.progress(1, 0, None, None, 0);
        t.progress(1, 100, None, None, 1000);
        assert_eq!(view(&t, 1).eta_secs, None);
        t.progress(1, 200, None, None, 2000);
        t.progress(1, 300, None, None, 3000);
        let v = view(&t, 1);
        assert_eq!((v.rate, v.eta_secs), (Some(100.0), Some(7)));
        let mut u = ProgressTree::default();
        u.start(1, None, "y", None, None, None, 0);
        for i in 0..6 {
            u.progress(1, i * 100, None, None, i * 1000);
        }
        assert_eq!(view(&u, 1).eta_secs, None);
    }

    #[test]
    fn a_step_under_an_unknown_parent_becomes_a_root() {
        let mut t = ProgressTree::default();
        t.start(5, Some(99), "orphan", None, None, None, 0);
        assert_eq!(t.snapshot(0).len(), 1);
        assert_eq!(view(&t, 5).depth, 0);
    }

    #[test]
    fn progress_for_an_unknown_step_is_ignored() {
        let mut t = ProgressTree::default();
        t.progress(7, 1, None, None, 0);
        assert!(t.is_empty());
    }
}

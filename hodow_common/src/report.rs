use std::sync::Arc;
use std::sync::atomic::{AtomicU32, Ordering};
use std::time::{Duration, Instant};

use crate::event::{Event, Finding, Level, RunStatus, StepId, StepOutcome, Summary};
use crate::sink::Sink;

pub const DEFAULT_PROGRESS_INTERVAL: Duration = Duration::from_millis(100);

struct Shared {
    sink: Arc<dyn Sink>,
    next_id: AtomicU32,
    min_interval: Duration,
}

/// The emitting side of a run: hands out step ids and turns calls into events on a [`Sink`]. A cheap handle; clones
/// share the id counter, so a step may outlive the code that opened it (a `'static` progress callback, say).
#[derive(Clone)]
pub struct Reporter(Arc<Shared>);

impl Reporter {
    pub fn new(sink: Arc<dyn Sink>) -> Self {
        Self(Arc::new(Shared {
            sink,
            next_id: AtomicU32::new(1),
            min_interval: DEFAULT_PROGRESS_INTERVAL,
        }))
    }

    /// Only meant before the first clone is taken.
    pub fn with_progress_interval(self, interval: Duration) -> Self {
        let shared =
            Arc::try_unwrap(self.0).unwrap_or_else(|_| panic!("the interval is set before the reporter is shared"));
        Self(Arc::new(Shared {
            min_interval: interval,
            ..shared
        }))
    }

    #[expect(clippy::needless_pass_by_value, reason = "the call sites build the event in place")]
    pub fn emit(&self, event: Event) {
        self.0.sink.emit(&event);
    }

    pub fn run_started(&self, module: &str, title: &str, args: &[String], run: Option<String>) {
        self.emit(Event::RunStarted {
            module: module.into(),
            title: title.into(),
            args: args.to_vec(),
            run,
        });
    }

    pub fn run_finished(&self, status: RunStatus, summary: Summary) {
        self.emit(Event::RunFinished { status, summary });
    }

    pub fn finding(&self, finding: Finding) {
        self.emit(Event::Finding(finding));
    }

    pub fn log(&self, level: Level, message: impl Into<String>) {
        self.emit(Event::Log {
            level,
            message: message.into(),
        });
    }

    pub fn step(&self, label: impl Into<String>) -> StepBuilder {
        StepBuilder {
            reporter: self.clone(),
            parent: None,
            label: label.into(),
            unit: None,
            total: None,
            weight: None,
        }
    }
}

pub struct StepBuilder {
    reporter: Reporter,
    parent: Option<StepId>,
    label: String,
    unit: Option<String>,
    total: Option<u64>,
    weight: Option<f64>,
}

impl StepBuilder {
    pub fn parent(mut self, parent: &Step) -> Self {
        self.parent = Some(parent.id);
        self
    }

    pub fn unit(mut self, unit: impl Into<String>) -> Self {
        self.unit = Some(unit.into());
        self
    }

    pub fn total(mut self, total: u64) -> Self {
        self.total = Some(total);
        self
    }

    pub fn weight(mut self, weight: f64) -> Self {
        self.weight = Some(weight);
        self
    }

    pub fn start(self) -> Step {
        let id = self.reporter.0.next_id.fetch_add(1, Ordering::Relaxed);
        self.reporter.emit(Event::StepStarted {
            id,
            parent: self.parent,
            label: self.label,
            unit: self.unit,
            total: self.total,
            weight: self.weight,
        });
        Step {
            reporter: self.reporter,
            id,
            total: self.total,
            last_emit: None,
            finished: false,
        }
    }
}

/// A step that was never finished (an early return, a panic unwinding) is reported as cancelled, so a viewer never
/// shows it running forever.
pub struct Step {
    reporter: Reporter,
    id: StepId,
    total: Option<u64>,
    last_emit: Option<Instant>,
    finished: bool,
}

impl Step {
    pub fn id(&self) -> StepId {
        self.id
    }

    pub fn set_total(&mut self, total: u64) {
        self.total = Some(total);
    }

    /// Throttled: emits at most once per interval, but always the first and the one that reaches the total.
    pub fn progress(&mut self, done: u64, current: Option<&str>) {
        let due = self
            .last_emit
            .is_none_or(|t| t.elapsed() >= self.reporter.0.min_interval);
        if !(due || self.total == Some(done)) {
            return;
        }
        self.last_emit = Some(Instant::now());
        self.reporter.emit(Event::StepProgress {
            id: self.id,
            done,
            total: self.total,
            current: current.map(str::to_owned),
        });
    }

    pub fn finish(mut self, outcome: StepOutcome) {
        self.close(outcome);
    }

    fn close(&mut self, outcome: StepOutcome) {
        if !std::mem::replace(&mut self.finished, true) {
            self.reporter.emit(Event::StepFinished { id: self.id, outcome });
        }
    }
}

impl Drop for Step {
    fn drop(&mut self) {
        self.close(StepOutcome::Cancelled);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::sink::MemorySink;

    fn reporter(interval: Duration) -> (Reporter, Arc<MemorySink>) {
        let sink = Arc::new(MemorySink::default());
        (Reporter::new(sink.clone()).with_progress_interval(interval), sink)
    }

    fn progress_count(sink: &MemorySink) -> usize {
        sink.events()
            .iter()
            .filter(|e| matches!(e, Event::StepProgress { .. }))
            .count()
    }

    #[test]
    fn a_tight_loop_emits_a_handful_of_progress_events() {
        let (r, sink) = reporter(Duration::from_secs(3600));
        let mut step = r.step("cpu").total(100_000).start();
        for i in 0..=100_000 {
            step.progress(i, None);
        }
        assert_eq!(progress_count(&sink), 2);
    }

    #[test]
    fn with_no_interval_every_call_is_reported() {
        let (r, sink) = reporter(Duration::ZERO);
        let mut step = r.step("x").start();
        for i in 0..10 {
            step.progress(i, None);
        }
        assert_eq!(progress_count(&sink), 10);
    }

    #[test]
    fn ids_are_unique_and_children_point_at_their_parent() {
        let (r, sink) = reporter(Duration::ZERO);
        let parent = r.step("p").start();
        let child = r.step("c").parent(&parent).unit("tests").weight(2.0).start();
        assert_ne!(parent.id(), child.id());
        let events = sink.events();
        assert!(matches!(&events[1], Event::StepStarted { parent: Some(p), weight: Some(_), .. } if *p == parent.id()));
    }

    #[test]
    fn a_dropped_step_is_cancelled_and_a_finished_one_is_not_reported_twice() {
        let (r, sink) = reporter(Duration::ZERO);
        drop(r.step("abandoned").start());
        r.step("done").start().finish(StepOutcome::Done);
        let finished: Vec<_> = sink
            .events()
            .into_iter()
            .filter_map(|e| match e {
                Event::StepFinished { outcome, .. } => Some(outcome),
                _ => None,
            })
            .collect();
        assert_eq!(finished, vec![StepOutcome::Cancelled, StepOutcome::Done]);
    }
}

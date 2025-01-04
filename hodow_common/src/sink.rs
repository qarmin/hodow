use std::io::Write;
use std::sync::{Arc, Mutex};

use crate::event::Event;
use crate::state::RunState;
use crate::time::now_ms;

/// Where a run's events go. `emit` cannot fail: a sink that loses its file or pipe reports that itself and the run
/// carries on.
pub trait Sink: Send + Sync {
    fn emit(&self, event: &Event);
}

impl<T: Sink + ?Sized> Sink for Arc<T> {
    fn emit(&self, event: &Event) {
        (**self).emit(event);
    }
}

pub struct NullSink;

impl Sink for NullSink {
    fn emit(&self, _: &Event) {}
}

/// `@hodow {json}` lines on stdout, which is how a worker process talks to whoever started it.
pub struct StdoutSink;

impl Sink for StdoutSink {
    fn emit(&self, event: &Event) {
        let mut out = std::io::stdout().lock();
        let _ = writeln!(out, "{}", event.to_line());
        let _ = out.flush();
    }
}

pub struct Fanout(pub Vec<Arc<dyn Sink>>);

impl Sink for Fanout {
    fn emit(&self, event: &Event) {
        for sink in &self.0 {
            sink.emit(event);
        }
    }
}

#[derive(Default)]
pub struct MemorySink(Mutex<Vec<Event>>);

impl MemorySink {
    pub fn events(&self) -> Vec<Event> {
        self.0.lock().unwrap_or_else(|e| e.into_inner()).clone()
    }
}

impl Sink for MemorySink {
    fn emit(&self, event: &Event) {
        self.0.lock().unwrap_or_else(|e| e.into_inner()).push(event.clone());
    }
}

/// Keeps a [`RunState`] up to date from the events it is given.
pub struct StateSink(Mutex<RunState>);

impl StateSink {
    pub fn new(state: RunState) -> Self {
        Self(Mutex::new(state))
    }

    pub fn with<R>(&self, f: impl FnOnce(&RunState) -> R) -> R {
        f(&self.0.lock().unwrap_or_else(|e| e.into_inner()))
    }
}

impl Sink for StateSink {
    fn emit(&self, event: &Event) {
        self.0.lock().unwrap_or_else(|e| e.into_inner()).apply(event, now_ms());
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::event::{Finding, Verdict};

    #[test]
    fn fanout_reaches_every_sink() {
        let (a, b) = (Arc::new(MemorySink::default()), Arc::new(MemorySink::default()));
        let fan = Fanout(vec![a.clone(), b.clone()]);
        fan.emit(&Event::Finding(Finding::new("t", Verdict::Passed)));
        assert_eq!((a.events().len(), b.events().len()), (1, 1));
    }

    #[test]
    fn the_state_sink_counts_what_it_is_fed() {
        let sink = StateSink::new(RunState::new("cpu", "CPU", now_ms()));
        sink.emit(&Event::Finding(Finding::new("t", Verdict::Failed)));
        assert_eq!(sink.with(|s| s.summary.failed), 1);
    }
}

use std::sync::Mutex;

use handsome_logger::{Config, SharedLogger};
use indicatif::MultiProgress;
use log::{LevelFilter, Log, Metadata, Record};

static ACTIVE: Mutex<Option<MultiProgress>> = Mutex::new(None);

/// While set, console log lines are printed with the bars suspended so they do not interleave with the redraws.
pub fn set_active(multi: Option<MultiProgress>) {
    *ACTIVE.lock().unwrap_or_else(|e| e.into_inner()) = multi;
}

pub struct BarAware<L>(L);

impl<L> BarAware<L> {
    pub fn new(inner: L) -> Box<Self> {
        Box::new(Self(inner))
    }
}

impl<L: SharedLogger> Log for BarAware<L> {
    fn enabled(&self, metadata: &Metadata) -> bool {
        self.0.enabled(metadata)
    }

    fn log(&self, record: &Record) {
        let active = ACTIVE.lock().unwrap_or_else(|e| e.into_inner()).clone();
        match active {
            Some(multi) => multi.suspend(|| self.0.log(record)),
            None => self.0.log(record),
        }
    }

    fn flush(&self) {
        self.0.flush();
    }
}

impl<L: SharedLogger + 'static> SharedLogger for BarAware<L> {
    fn level(&self) -> LevelFilter {
        self.0.level()
    }

    fn config(&self) -> Option<&Config> {
        self.0.config()
    }

    fn as_log(self: Box<Self>) -> Box<dyn Log> {
        self
    }
}

use serde::{Deserialize, Serialize};

pub const PREFIX: &str = "@hodow ";

pub type StepId = u32;

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, Hash)]
#[serde(rename_all = "snake_case")]
pub enum Verdict {
    Passed,
    Unverified,
    Skipped,
    NotSupported,
    Failed,
    Panicked,
    TimedOut,
    Crashed,
}

impl Verdict {
    pub fn is_failure(self) -> bool {
        matches!(self, Self::Failed | Self::Panicked | Self::TimedOut | Self::Crashed)
    }

    /// Everything but a plain pass: what a live view shows one by one.
    pub fn is_notable(self) -> bool {
        self != Self::Passed
    }
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum Level {
    Error,
    Warn,
    Info,
    Debug,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum StepOutcome {
    Done,
    Failed,
    Skipped,
    Cancelled,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum RunStatus {
    Running,
    Succeeded,
    Failed,
    Crashed,
    Interrupted,
    Cancelled,
}

impl RunStatus {
    pub fn is_finished(self) -> bool {
        self != Self::Running
    }
}

/// Counts per verdict. `passed` and `unverified` are separate on purpose: a run over an uncaptured extension must
/// not look clean.
#[derive(Serialize, Deserialize, Clone, Debug, Default, PartialEq, Eq)]
pub struct Summary {
    pub total: u64,
    pub passed: u64,
    pub unverified: u64,
    pub skipped: u64,
    pub not_supported: u64,
    pub failed: u64,
    pub panicked: u64,
    pub timed_out: u64,
    pub crashed: u64,
}

impl Summary {
    pub fn add(&mut self, verdict: Verdict) {
        self.total += 1;
        *match verdict {
            Verdict::Passed => &mut self.passed,
            Verdict::Unverified => &mut self.unverified,
            Verdict::Skipped => &mut self.skipped,
            Verdict::NotSupported => &mut self.not_supported,
            Verdict::Failed => &mut self.failed,
            Verdict::Panicked => &mut self.panicked,
            Verdict::TimedOut => &mut self.timed_out,
            Verdict::Crashed => &mut self.crashed,
        } += 1;
    }

    pub fn failures(&self) -> u64 {
        self.failed + self.panicked + self.timed_out + self.crashed
    }

    pub fn status(&self) -> RunStatus {
        if self.crashed > 0 {
            RunStatus::Crashed
        } else if self.failures() > 0 {
            RunStatus::Failed
        } else {
            RunStatus::Succeeded
        }
    }
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Finding {
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub step: Option<StepId>,
    pub name: String,
    pub verdict: Verdict,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub detail: Option<String>,
    /// The observed value of an unverified test, so an expectation can be captured from the run.
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub value: Option<String>,
}

impl Finding {
    pub fn new(name: impl Into<String>, verdict: Verdict) -> Self {
        Self {
            step: None,
            name: name.into(),
            verdict,
            detail: None,
            value: None,
        }
    }

    pub fn in_step(mut self, step: StepId) -> Self {
        self.step = Some(step);
        self
    }

    pub fn detail(mut self, detail: impl Into<String>) -> Self {
        self.detail = Some(detail.into());
        self
    }

    pub fn value(mut self, value: impl Into<String>) -> Self {
        self.value = Some(value.into());
        self
    }
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
#[serde(tag = "ev", rename_all = "snake_case")]
pub enum Event {
    RunStarted {
        module: String,
        title: String,
        #[serde(default, skip_serializing_if = "Vec::is_empty")]
        args: Vec<String>,
        /// The id of the saved run, when this run is being kept: how a parent finds it on disk.
        #[serde(default, skip_serializing_if = "Option::is_none")]
        run: Option<String>,
    },
    StepStarted {
        id: StepId,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        parent: Option<StepId>,
        label: String,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        unit: Option<String>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        total: Option<u64>,
        /// Share of the parent's bar; the parent shows a percentage only when every child declares one.
        #[serde(default, skip_serializing_if = "Option::is_none")]
        weight: Option<f64>,
    },
    StepProgress {
        id: StepId,
        done: u64,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        total: Option<u64>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        current: Option<String>,
    },
    StepFinished {
        id: StepId,
        outcome: StepOutcome,
    },
    Finding(Finding),
    Log {
        level: Level,
        message: String,
    },
    RunFinished {
        status: RunStatus,
        summary: Summary,
    },
}

impl Event {
    pub fn finding(finding: Finding) -> Self {
        Self::Finding(finding)
    }

    /// Frequent and derivable, so never written to a result file.
    pub fn is_ephemeral(&self) -> bool {
        matches!(self, Self::StepProgress { .. })
    }

    /// Written out immediately instead of on the next periodic sync.
    pub fn is_urgent(&self) -> bool {
        match self {
            Self::Finding(f) => f.verdict.is_notable(),
            Self::StepProgress { .. } => false,
            Self::Log { level, .. } => matches!(level, Level::Error | Level::Warn),
            _ => true,
        }
    }

    pub fn to_json(&self) -> String {
        serde_json::to_string(self).expect("an event always serializes")
    }

    pub fn to_line(&self) -> String {
        format!("{PREFIX}{}", self.to_json())
    }

    /// `Ok(None)` for a line that is not a message at all: whatever a driver prints on its own.
    pub fn parse_line(line: &str) -> Result<Option<Self>, serde_json::Error> {
        match line.trim_end().strip_prefix(PREFIX) {
            Some(json) => serde_json::from_str(json).map(Some),
            None => Ok(None),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn roundtrip(event: Event) {
        let line = event.to_line();
        assert!(line.starts_with(PREFIX) && !line.contains('\n'));
        assert_eq!(Event::parse_line(&line).unwrap(), Some(event));
    }

    #[test]
    fn every_variant_survives_a_line() {
        roundtrip(Event::RunStarted {
            module: "cpu".into(),
            title: "CPU".into(),
            args: vec!["-f".into()],
            run: Some("20261109-120000-cpu".into()),
        });
        roundtrip(Event::StepStarted {
            id: 3,
            parent: Some(1),
            label: "avx512f".into(),
            unit: Some("tests".into()),
            total: Some(4120),
            weight: Some(4120.0),
        });
        roundtrip(Event::StepProgress {
            id: 3,
            done: 302,
            total: None,
            current: Some("_mm512_add_ps".into()),
        });
        roundtrip(Event::StepFinished {
            id: 3,
            outcome: StepOutcome::Done,
        });
        roundtrip(Event::finding(
            Finding::new("t", Verdict::Unverified)
                .in_step(3)
                .detail("d")
                .value("0x1"),
        ));
        roundtrip(Event::Log {
            level: Level::Warn,
            message: "m".into(),
        });
        roundtrip(Event::RunFinished {
            status: RunStatus::Failed,
            summary: Summary::default(),
        });
    }

    #[test]
    fn foreign_output_is_not_a_message_but_a_broken_message_is_an_error() {
        assert_eq!(Event::parse_line("GL: vendor Mesa").unwrap(), None);
        assert!(Event::parse_line("@hodow {not json").is_err());
        assert!(Event::parse_line("@hodow {\"ev\":\"unknown\"}").is_err());
    }

    #[test]
    fn optional_fields_stay_out_of_the_line() {
        let json = Event::StepProgress {
            id: 1,
            done: 2,
            total: None,
            current: None,
        }
        .to_json();
        assert_eq!(json, r#"{"ev":"step_progress","id":1,"done":2}"#);
    }

    #[test]
    fn summary_status_puts_a_crash_above_a_failure() {
        let mut s = Summary::default();
        s.add(Verdict::Passed);
        s.add(Verdict::Unverified);
        assert_eq!((s.total, s.status()), (2, RunStatus::Succeeded));
        s.add(Verdict::Failed);
        assert_eq!(s.status(), RunStatus::Failed);
        s.add(Verdict::Crashed);
        assert_eq!((s.failures(), s.status()), (2, RunStatus::Crashed));
    }

    #[test]
    fn only_notable_findings_are_urgent() {
        let pass = Event::finding(Finding::new("t", Verdict::Passed));
        let fail = Event::finding(Finding::new("t", Verdict::Failed));
        assert!(!pass.is_urgent() && fail.is_urgent());
        assert!(
            Event::StepProgress {
                id: 0,
                done: 0,
                total: None,
                current: None
            }
            .is_ephemeral()
        );
    }
}

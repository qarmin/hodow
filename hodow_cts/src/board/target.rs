// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// What the tester needs from a board, so the whole of it can run against a simulated one.

use serde::{Deserialize, Serialize};

use crate::report::CaseResult;
use crate::tcu::TestResult;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum FatalKind {
    /// The kernel reported the GPU stopped serving; only a reboot brings it back.
    Hang,
    /// The board stopped answering ssh.
    System,
    /// The worker made no progress and the kernel said nothing.
    ClientHang,
    /// The worker died on a signal or an exit code of its own.
    Crash,
}

impl FatalKind {
    pub fn label(self) -> &'static str {
        match self {
            Self::Hang => "HANG",
            Self::System => "SYSTEM",
            Self::ClientHang => "CLIENTHANG",
            Self::Crash => "CRASH",
        }
    }

    /// A stall can surface as any of the three depending on timing, so a minimisation step
    /// counts any of them as the same bug; a crash is a different one.
    pub fn same_class(self, other: Self) -> bool {
        self.is_stall() == other.is_stall()
    }

    pub fn is_stall(self) -> bool {
        !matches!(self, Self::Crash)
    }
}

#[derive(Debug, Clone)]
pub struct Fatal {
    pub case: String,
    pub kind: FatalKind,
    pub message: String,
}

#[derive(Debug, Clone)]
pub enum Stop {
    Finished,
    Fatal(Fatal),
    /// Nothing ran because no driver answered - usually the compositor not being up yet.
    NoDriver,
    /// Ctrl-C; the run is to be repeated, not judged.
    Interrupted,
}

#[derive(Debug, Clone, Copy, Default)]
pub struct RunOpts {
    pub dump_shaders: bool,
    /// Every case in a process of its own.
    pub isolate_each: bool,
}

#[derive(Debug, Clone)]
pub struct Run {
    /// Verdicts in the order they arrived, the fatal case's included.
    pub results: Vec<CaseResult>,
    pub stop: Stop,
    pub output: String,
    /// What the kernel printed while the run was going.
    pub kernel: String,
}

impl Run {
    pub fn fatal(&self) -> Option<&Fatal> {
        match &self.stop {
            Stop::Fatal(f) => Some(f),
            _ => None,
        }
    }

    /// The cases that ran before `case` in this process.
    pub fn before(&self, case: &str) -> Vec<String> {
        self.results
            .iter()
            .take_while(|r| r.name != case)
            .map(|r| r.name.clone())
            .collect()
    }

    pub fn status_of(&self, case: &str) -> Option<TestResult> {
        self.results.iter().find(|r| r.name == case).map(|r| r.status)
    }
}

pub trait Board {
    /// Runs `cases` in one hodow_cts process, stopping at the first fatal case.
    fn run(&mut self, cases: &[String], opts: RunOpts, on_result: &mut dyn FnMut(&CaseResult)) -> Run;

    /// Whether a trivial case still runs, i.e. the driver survived whatever happened last.
    fn healthy(&mut self) -> bool;

    /// Returns only once the board is back and ready for GL.
    fn reboot(&mut self);

    /// After the board stopped answering: waits for it, however long that takes.
    fn wait_until_back(&mut self);

    /// No run since the last boot.
    fn fresh(&self) -> bool;

    /// The state of a wedged board, which a reboot destroys.
    fn diag(&mut self) -> String;

    /// After a run that found no driver.
    fn pause_for_driver(&mut self);
}

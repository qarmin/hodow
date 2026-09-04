// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// The result model. This is a library type rather than a formatting concern on
// purpose: a GUI is meant to consume `CaseResult`/`RunHeader` through the crate API,
// and the JSONL file is just their serialisation. Nothing here should need a parser
// on the consuming side.

use std::io::Write;

use serde::{Deserialize, Serialize};

use crate::tcu::{TestResult, TestStatus};

/// One line of the result file: the verdict for a single test case.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CaseResult {
    pub name: String,
    pub status: TestResult,
    pub message: String,
    pub duration_ms: u64,
}

impl CaseResult {
    pub fn from_status(name: impl Into<String>, status: &TestStatus, duration_ms: u64) -> Self {
        Self {
            name: name.into(),
            status: status.code(),
            message: status.description().to_string(),
            duration_ms,
        }
    }
}

/// The first line of the result file: what was run, and against what.
///
/// `translation_layer` is set on macOS/MoltenVK. Results from a translation layer are
/// not statements about hardware, and a consumer that does not know it is reading one
/// would mistake its limitations for driver bugs.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RunHeader {
    pub kind: String,
    pub hodow_cts_version: String,
    pub upstream_revision: String,
    pub device_name: String,
    pub api_version: String,
    pub driver_kind: String,
    pub translation_layer: bool,
    pub validation_enabled: bool,
    pub total_cases: usize,
}

/// Either line of the JSONL stream.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Record {
    Header(RunHeader),
    Case(CaseResult),
}

/// Appends records to the result file, flushing after each one.
///
/// The flush is what makes a run survive its own subject: when a test takes the
/// process down with it, everything up to that case is already on disk, and the
/// parent can see exactly which case was in flight.
pub struct JsonlWriter {
    out: Box<dyn Write + Send>,
}

impl JsonlWriter {
    pub fn new(out: Box<dyn Write + Send>) -> Self {
        Self { out }
    }

    pub fn to_file(path: &std::path::Path) -> std::io::Result<Self> {
        let file = std::fs::File::create(path)?;
        Ok(Self::new(Box::new(file)))
    }

    pub fn write_header(&mut self, header: &RunHeader) -> std::io::Result<()> {
        writeln!(self.out, "{}", serde_json::to_string(header)?)?;
        self.out.flush()
    }

    pub fn write_case(&mut self, result: &CaseResult) -> std::io::Result<()> {
        writeln!(self.out, "{}", serde_json::to_string(result)?)?;
        self.out.flush()
    }
}

/// Running tally, printed as the human-readable summary at the end of a run.
#[derive(Debug, Default, Clone)]
pub struct Summary {
    pub passed: usize,
    pub failed: usize,
    pub not_supported: usize,
    pub warnings: usize,
    pub crashed: usize,
    pub other: usize,
}

impl Summary {
    pub fn record(&mut self, status: TestResult) {
        match status {
            TestResult::Pass => self.passed += 1,
            TestResult::Fail => self.failed += 1,
            TestResult::NotSupported => self.not_supported += 1,
            TestResult::QualityWarning | TestResult::CompatibilityWarning | TestResult::CapabilityWarning => self.warnings += 1,
            TestResult::Crash | TestResult::Timeout | TestResult::DeviceLost => self.crashed += 1,
            _ => self.other += 1,
        }
    }

    pub fn total(&self) -> usize {
        self.passed + self.failed + self.not_supported + self.warnings + self.crashed + self.other
    }

    /// Non-zero when anything needs a human to look at it.
    pub fn exit_code(&self) -> i32 {
        if self.failed > 0 || self.crashed > 0 || self.other > 0 { 1 } else { 0 }
    }
}

impl std::fmt::Display for Summary {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let total = self.total().max(1);
        let pct = |n: usize| (n as f64) * 100.0 / (total as f64);
        writeln!(f, "Test run totals:")?;
        writeln!(f, "  Passed:        {}/{} ({:.1}%)", self.passed, self.total(), pct(self.passed))?;
        writeln!(f, "  Failed:        {}/{} ({:.1}%)", self.failed, self.total(), pct(self.failed))?;
        writeln!(f, "  Not supported: {}/{} ({:.1}%)", self.not_supported, self.total(), pct(self.not_supported))?;
        writeln!(f, "  Warnings:      {}/{} ({:.1}%)", self.warnings, self.total(), pct(self.warnings))?;
        write!(f, "  Crashed:       {}/{} ({:.1}%)", self.crashed, self.total(), pct(self.crashed))
    }
}

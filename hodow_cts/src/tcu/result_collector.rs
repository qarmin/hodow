// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuResultCollector.hpp / .cpp  (tcu::ResultCollector)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::tcu::{TestResult, TestStatus};

/// `tcu::ResultCollector` - accumulates the worst verdict seen plus the message that
/// produced it. Ported because these tests keep going after the first problem and
/// report the aggregate, which is what makes their verdicts comparable with upstream.
pub struct ResultCollector {
    prefix: &'static str,
    result: Option<TestResult>,
    message: String,
}

/// `testResultSeverity`
fn test_result_severity(result: TestResult) -> i32 {
    match result {
        TestResult::Pass => 0,
        TestResult::Pending => 10,
        TestResult::NotSupported => 20,
        TestResult::QualityWarning => 30,
        TestResult::CompatibilityWarning | TestResult::CapabilityWarning => 40,
        TestResult::Timeout => 50,
        TestResult::Fail => 100,
        TestResult::ResourceError => 110,
        TestResult::InternalError => 120,
        TestResult::Crash => 150,
        // Upstream's table has no DEVICE_LOST arm at all - it falls into
        // `default: DE_FATAL("Impossible case")`. Ranking it above Crash rather than
        // aborting keeps the run going and makes the situation visible in the result
        // file, which is more useful than taking the process down.
        TestResult::DeviceLost => 200,
    }
}

impl ResultCollector {
    pub fn new(prefix: &'static str) -> Self {
        Self {
            prefix,
            result: None,
            message: "Pass".to_string(),
        }
    }

    /// `ResultCollector::addResult`
    pub fn add_result(&mut self, result: TestResult, msg: String) {
        log::info!("{}{}", self.prefix, msg);

        let current = self.result.map_or(-1, test_result_severity);
        if test_result_severity(result) > current {
            self.result = Some(result);
            self.message = msg;
        }
    }

    /// `ResultCollector::checkResult`
    pub fn check_result(&mut self, condition: bool, result: TestResult, msg: impl Into<String>) -> bool {
        if !condition {
            self.add_result(result, msg.into());
        }
        condition
    }

    /// `ResultCollector::check`
    pub fn check(&mut self, condition: bool, msg: impl Into<String>) -> bool {
        self.check_result(condition, TestResult::Fail, msg)
    }

    /// `ResultCollector::fail`
    pub fn fail(&mut self, msg: impl Into<String>) {
        self.add_result(TestResult::Fail, msg.into());
    }

    /// Fold another collector's verdict into this one.
    ///
    /// Upstream hands one `tcu::ResultCollector&` to every helper a case builds, so they
    /// all write into the case's own. A helper here owns its collector (the borrow
    /// checker will not let one be shared across a `&mut` context that is rebuilt per
    /// run), so the case folds the result back at the end instead.
    pub fn merge(&mut self, other: &Self) {
        if let Some(result) = other.result {
            self.add_result(result, other.message.clone());
        }
    }

    /// `ResultCollector::getResult` plus `getMessage`, in the shape `tcu::TestStatus`
    /// is built from at every call site.
    pub fn to_status(&self) -> TestStatus {
        TestStatus::new(self.result.unwrap_or(TestResult::Pass), self.message.clone())
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/qphelper/qpTestLog.h  (qpTestResult)
//   framework/common/tcuTestCase.hpp (tcu::TestStatus)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use serde::{Deserialize, Serialize};

/// `qpTestResult` - the set of verdicts a test case can produce.
///
/// The variants and their spelling are kept identical to upstream because they end
/// up in the result file and are compared against `deqp-vk` output verbatim.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub enum TestResult {
    /// Implementation passed the test.
    Pass,
    /// Implementation produced incorrect results.
    Fail,
    /// Result is within specification, but is not of high quality.
    QualityWarning,
    /// Result is within specification, but likely to cause fragmentation in the market.
    CompatibilityWarning,
    /// Implementation does not support functionality needed by this test case.
    NotSupported,
    /// Implementation fails to pass the test due to lack of resources.
    ResourceError,
    /// Error occurred within the tester itself.
    InternalError,
    /// Crash occurred in test execution.
    Crash,
    /// Timeout occurred in test execution.
    Timeout,
    /// Test caused a device lost error.
    DeviceLost,
    /// Device returned incomplete or incorrect capability information.
    CapabilityWarning,
    /// The test is still running. Never a valid end result - used only by the runner
    /// to mark the case that was in flight when a child process died.
    Pending,
}

impl TestResult {
    pub fn as_str(self) -> &'static str {
        match self {
            Self::Pass => "Pass",
            Self::Fail => "Fail",
            Self::QualityWarning => "QualityWarning",
            Self::CompatibilityWarning => "CompatibilityWarning",
            Self::NotSupported => "NotSupported",
            Self::ResourceError => "ResourceError",
            Self::InternalError => "InternalError",
            Self::Crash => "Crash",
            Self::Timeout => "Timeout",
            Self::DeviceLost => "DeviceLost",
            Self::CapabilityWarning => "CapabilityWarning",
            Self::Pending => "Pending",
        }
    }
}

/// `tcu::TestStatus` - a verdict plus the human-readable description that upstream
/// prints alongside it.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct TestStatus {
    code: TestResult,
    description: String,
}

impl TestStatus {
    pub fn new(code: TestResult, description: impl Into<String>) -> Self {
        Self {
            code,
            description: description.into(),
        }
    }

    pub fn pass(description: impl Into<String>) -> Self {
        Self::new(TestResult::Pass, description)
    }

    pub fn fail(description: impl Into<String>) -> Self {
        Self::new(TestResult::Fail, description)
    }

    pub fn is_fail(&self) -> bool {
        self.code == TestResult::Fail
    }

    pub fn code(&self) -> TestResult {
        self.code
    }

    pub fn description(&self) -> &str {
        &self.description
    }
}

/// The error type a `TestInstance` may return instead of a `TestStatus`.
///
/// Upstream throws these; `TCU_THROW(NotSupportedError, ...)` and friends are the
/// idiomatic way a CTS test bails out. Each variant maps onto the verdict the
/// upstream exception handler in `tcuTestSessionExecutor.cpp` assigns.
#[derive(Debug, Clone)]
pub enum TestError {
    /// `tcu::NotSupportedError` - reported as NotSupported, not as a failure.
    NotSupported(String),
    /// `tcu::TestError` - a plain failure raised from inside a test.
    ///
    /// Where a Vulkan test can see the verdict it wants it returns
    /// `Ok(TestStatus::fail(..))` directly, which most of them do. A helper several
    /// layers down - a GL error check, an interface query - has no verdict to return
    /// and upstream throws from there, so this is the `?`-able form of the same thing.
    Fail(String),
    /// `tcu::ResourceError` - the implementation ran out of some resource.
    ResourceError(String),
    /// `VK_ERROR_OUT_OF_HOST_MEMORY` specifically. Reported as ResourceError like any
    /// other, but kept apart because the allocation-callback tests provoke it on
    /// purpose and have to tell it from every other out-of-memory.
    OutOfHostMemory(String),
    /// `tcu::InternalError` - a bug on our side, never a driver verdict.
    InternalError(String),
    /// `tcu::TestException` with a device lost code.
    DeviceLost(String),
    /// A path of the framework that has not been ported yet. Deliberately loud:
    /// silently substituting an approximation would produce a verdict that cannot
    /// be told apart from a real driver bug.
    NotPorted(String),
}

impl TestError {
    pub fn to_status(&self) -> TestStatus {
        match self {
            Self::NotSupported(m) => TestStatus::new(TestResult::NotSupported, m.clone()),
            Self::Fail(m) => TestStatus::new(TestResult::Fail, m.clone()),
            Self::ResourceError(m) | Self::OutOfHostMemory(m) => TestStatus::new(TestResult::ResourceError, m.clone()),
            Self::InternalError(m) => TestStatus::new(TestResult::InternalError, m.clone()),
            Self::DeviceLost(m) => TestStatus::new(TestResult::DeviceLost, m.clone()),
            Self::NotPorted(m) => TestStatus::new(TestResult::InternalError, format!("not ported: {m}")),
        }
    }
}

impl std::fmt::Display for TestError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let s = self.to_status();
        write!(f, "{}: {}", s.code().as_str(), s.description())
    }
}

impl std::error::Error for TestError {}

pub type TestOutcome = Result<TestStatus, TestError>;

/// `TCU_THROW(NotSupportedError, msg)`
#[macro_export]
macro_rules! tcu_throw_not_supported {
    ($($arg:tt)*) => {
        return Err($crate::tcu::TestError::NotSupported(format!($($arg)*)))
    };
}

/// `TCU_FAIL(msg)` - an immediate Fail verdict.
#[macro_export]
macro_rules! tcu_fail {
    ($($arg:tt)*) => {
        return Ok($crate::tcu::TestStatus::fail(format!($($arg)*)))
    };
}

/// Raised when the port reaches a framework path that has not been written yet.
#[macro_export]
macro_rules! tcu_not_ported {
    ($($arg:tt)*) => {
        return Err($crate::tcu::TestError::NotPorted(format!($($arg)*)))
    };
}

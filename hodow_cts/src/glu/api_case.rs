// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fApiCase.hpp / .cpp  (deqp::gles2::Functional::ApiCase)
//   modules/gles3/functional/es3fApiCase.hpp / .cpp  (the same class for ES 3.x)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream has one copy of this class
// per module (es2fApiCase, es3fApiCase, es31fApiCase) with the same body; one copy here
// serves all of them, because the only thing that differed was the namespace.
//
// The shape that matters, and that is kept: a case starts at Pass, runs its whole body
// even after a mismatch, and keeps the *first* failure as its verdict. Stopping at the
// first one would hide how much of a group is broken, which on a driver that gets a
// whole family of error codes wrong is the useful information.

use crate::glu::{self, Context};
use crate::glw::{self, GLenum};
use crate::tcu::{TestOutcome, TestResult, TestStatus};

/// The `-1` the negative-API cases pass wherever an enum is expected.
///
/// In the C++ that is a literal `-1` converted to `GLenum`, i.e. `0xFFFFFFFF`; Rust
/// will not convert it silently, so the value is named once here rather than cast at
/// each of the several hundred call sites.
pub const BAD_ENUM: GLenum = u32::MAX;

/// `deqp::gles2::Functional::ApiCase` - the running state of one API case.
pub struct ApiCase<'ctx> {
    context: &'ctx Context,
    /// The first failure, if any. Upstream keeps the first `setTestResult` that is not
    /// Pass for exactly the same reason.
    failure: Option<TestStatus>,
    /// How many failures have been recorded. A case whose upstream shape is a loop over
    /// iterations, each with its own `tcu::ResultCollector`, reads this before and after
    /// an iteration to recover the per-iteration verdict the collector would have given.
    failure_count: usize,
    /// Set by `not_supported`, which is upstream's `throw tcu::NotSupportedError`.
    not_supported: Option<String>,
}

impl<'ctx> ApiCase<'ctx> {
    pub fn new(context: &'ctx Context) -> Self {
        Self {
            context,
            failure: None,
            failure_count: 0,
            not_supported: None,
        }
    }

    pub fn gl(&self) -> &'ctx glw::Functions {
        self.context.gl()
    }

    /// `m_context` - for the few cases that need the context itself, to build a
    /// program or to ask what the implementation supports.
    pub fn context(&self) -> &'ctx Context {
        self.context
    }

    /// `m_context.getContextInfo().getInt(pname)`
    pub fn get_int(&self, pname: GLenum) -> i32 {
        self.context.context_info.get_int(self.gl(), pname)
    }

    /// `ApiCase::getSupportedExtensions` - the list behind a "how many, then which"
    /// pair of queries (shader binary formats, compressed texture formats).
    ///
    /// Empty means the implementation supports none, which is legal and is what the
    /// cases that use this then check for.
    pub fn get_supported_extensions(&mut self, num_supported_values: GLenum, extension: GLenum) -> Vec<i32> {
        let gl = self.gl();
        let mut num_formats = 0;
        // SAFETY: the count query writes one integer, and the array below is sized from
        // what it answered.
        unsafe { gl.get_integerv(num_supported_values, &mut num_formats) };
        self.expect_no_error("glGetIntegerv()");

        if num_formats <= 0 {
            log::debug!("// No supported extensions available.");
            return Vec::new();
        }

        let mut values = vec![0i32; num_formats as usize];
        // SAFETY: as above.
        unsafe { gl.get_integerv(extension, values.as_mut_ptr()) };
        self.expect_no_error("glGetIntegerv()");
        values
    }

    /// `m_log << TestLog::Section(...)` - what the following calls are checking.
    ///
    /// Logged at debug: a passing full-suite run would otherwise print several
    /// paragraphs of specification text per case.
    pub fn section(&self, description: &str) {
        log::debug!("{description}");
    }

    /// `ApiCase::expectError`
    #[track_caller]
    pub fn expect_error(&mut self, expected: GLenum) {
        let at = std::panic::Location::caller();
        // SAFETY: glGetError needs only a current context.
        let error = unsafe { self.gl().get_error() };
        if error != expected {
            self.fail(
                format!(
                    "expected {}, got {} ({at})",
                    glw::error_name(expected),
                    glw::error_name(error)
                ),
                "Got invalid error",
            );
        }
    }

    /// `ApiCase::expectError(error0, error1)` - the spec allows either.
    #[track_caller]
    pub fn expect_error2(&mut self, expected0: GLenum, expected1: GLenum) {
        let at = std::panic::Location::caller();
        // SAFETY: as above.
        let error = unsafe { self.gl().get_error() };
        if error != expected0 && error != expected1 {
            self.fail(
                format!(
                    "expected {} or {}, got {} ({at})",
                    glw::error_name(expected0),
                    glw::error_name(expected1),
                    glw::error_name(error)
                ),
                "Got invalid error",
            );
        }
    }

    /// `ApiCase::checkBooleans`
    pub fn check_booleans(&mut self, value: i32, expected: u8) {
        if value != i32::from(expected) {
            let expected_name = if expected != 0 { "GL_TRUE" } else { "GL_FALSE" };
            self.fail(
                format!("expected {expected_name}, got {value}"),
                "Got invalid boolean value",
            );
        }
    }

    /// `checkIntEquals` - used by the state-query and limit groups.
    pub fn check_int_equals(&mut self, value: i32, expected: i32) {
        if value != expected {
            self.fail(format!("expected {expected}, got {value}"), "Got invalid value");
        }
    }

    /// `GLU_EXPECT_NO_ERROR` inside an API case: a call that was supposed to succeed
    /// did not, which is a failure of the case rather than of the harness.
    pub fn expect_no_error(&mut self, message: &str) {
        if let Err(e) = glu::expect_no_error(self.gl(), message) {
            self.fail(e.to_string(), "Got unexpected error");
        }
    }

    /// Records a failure, keeping the first one.
    pub fn fail(&mut self, detail: String, verdict: &str) {
        log::warn!("// ERROR: {detail}");
        self.failure_count += 1;
        if self.failure.is_none() {
            self.failure = Some(TestStatus::new(TestResult::Fail, verdict.to_string()));
        }
    }

    /// How many failures have been recorded so far - see the field's comment.
    pub fn failure_count(&self) -> usize {
        self.failure_count
    }

    /// `throw tcu::NotSupportedError(reason)`.
    ///
    /// Upstream's throw leaves `test()` at once, which a plain `fn(&mut ApiCase)` cannot
    /// do, so a caller that needs the rest of the body skipped has to return itself -
    /// see `require_shader_compiler`, which reports the same thing as a `bool`.
    pub fn not_supported(&mut self, reason: impl Into<String>) {
        let reason = reason.into();
        log::debug!("// NotSupported: {reason}");
        if self.not_supported.is_none() {
            self.not_supported = Some(reason);
        }
    }

    /// The verdict: NotSupported, else the first failure, else Pass.
    ///
    /// NotSupported wins over a recorded failure because upstream's exception unwinds
    /// past `m_testCtx`'s result entirely - the wrapper that catches it sets the verdict
    /// from the exception, not from what the body had already recorded.
    pub fn finish(self) -> TestOutcome {
        if let Some(reason) = self.not_supported {
            return Ok(TestStatus::new(TestResult::NotSupported, reason));
        }
        Ok(self.failure.unwrap_or_else(|| TestStatus::pass("Pass")))
    }
}

/// One `ES2F_ADD_API_CASE` / `ES3F_ADD_API_CASE` entry.
///
/// Upstream's macro declares a class per case whose whole body is the `test()` method;
/// here that body is a function and the registration is a table of them, which keeps
/// the case list as compact and as reviewable against the C++ as the macro does. The
/// body is boxed rather than a bare `fn` because several groups register the same body
/// once per cube-map face, exactly as upstream's macro is invoked once per face.
pub struct ApiTestCase {
    name: String,
    test: Box<dyn Fn(&mut ApiCase<'_>) + Send + Sync>,
}

/// The signature every ported API-case body has.
pub type ApiCaseFn = fn(&mut ApiCase<'_>);

impl super::TestCase for ApiTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut case = ApiCase::new(context);
        (self.test)(&mut case);
        case.finish()
    }
}

/// Registers a table of `(name, fn)` pairs as one group, in the order given - which is
/// upstream's registration order, and therefore the order the cases run in.
pub fn add_api_cases(group: &mut super::TestCaseGroup, cases: &[(&'static str, ApiCaseFn)]) {
    for (name, test) in cases {
        add_api_case(group, *name, *test);
    }
}

/// Registers one case whose body needs to capture something - a cube-map face, a
/// texture target - which a bare `fn` cannot.
pub fn add_api_case(
    group: &mut super::TestCaseGroup,
    name: impl Into<String>,
    test: impl Fn(&mut ApiCase<'_>) + Send + Sync + 'static,
) {
    group.add_child(Box::new(ApiTestCase {
        name: name.into(),
        test: Box::new(test),
    }) as Box<dyn super::TestCase>);
}

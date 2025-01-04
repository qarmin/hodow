// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcTestSubcase.cpp
//   external/openglcts/modules/common/glcTestSubcase.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `SubcaseBase` is the `Subcase` trait and `TestSubcase` runs it the way upstream's `TestSubcase::iterate` does: setup, run and cleanup each map an escaping exception to a result (`NotSupportedError` to NOT_SUPPORTED in setup and run, anything else to ERROR), and a GL error left pending afterwards forces ERROR. `GLWrapper`'s call logging and the documentation sections (`Title`, `Purpose`, ...) are absent, and so is the iteration count (`--deqp-test-iteration-count`), which this runner has no counterpart of. A subcase gets the `Context` instead of reaching a global one, and the factory is a closure so a case can carry its template parameters.

use crate::glu::{Context, TestCase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

pub const NO_ERROR: i64 = 0;
pub const ERROR: i64 = -1;
pub const NOT_SUPPORTED: i64 = 0x10;

pub type SubcaseResult = Result<i64, TestError>;

/// `deqp::SubcaseBase`
pub trait Subcase {
    fn setup(&mut self, _context: &Context) -> SubcaseResult {
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult;

    fn cleanup(&mut self, _context: &Context) -> SubcaseResult {
        Ok(NO_ERROR)
    }
}

/// `SubcaseBase::OutputNotSupported`
pub fn output_not_supported(reason: &str) {
    log::info!("Not supported: {reason}, test will not run.");
}

/// A `catch` of `NotSupportedError`, `runtime_error` and `...` around setup or run.
fn result_of(result: SubcaseResult) -> i64 {
    match result {
        Ok(value) => value,
        Err(TestError::NotSupported(message)) => {
            log::info!("{message}");
            NOT_SUPPORTED
        }
        Err(error) => {
            log::info!("{error}");
            ERROR
        }
    }
}

/// `deqp::TestSubcase`
pub struct TestSubcase {
    name: String,
    factory: Box<dyn Fn() -> Box<dyn Subcase> + Send + Sync>,
}

impl TestSubcase {
    pub fn new(name: impl Into<String>, factory: impl Fn() -> Box<dyn Subcase> + Send + Sync + 'static) -> Self {
        Self {
            name: name.into(),
            factory: Box::new(factory),
        }
    }
}

impl TestCase for TestSubcase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut subcase = (self.factory)();

        // test case setup
        let mut sub_error = result_of(subcase.setup(context));
        if sub_error == ERROR {
            log::info!("Test Setup() failed");
        }

        // test case run
        if sub_error == NO_ERROR {
            sub_error = result_of(subcase.run(context));
            if sub_error == ERROR {
                log::info!("Test Run() failed");
            }
        }

        // test case cleanup
        match subcase.cleanup(context) {
            Ok(ERROR) => {
                sub_error = ERROR;
                log::info!("Test Cleanup() failed");
            }
            Ok(_) => {}
            Err(error) => {
                log::info!("{error}");
                sub_error = ERROR;
            }
        }

        // check gl error state
        let gl = context.gl();
        // SAFETY: no arguments.
        let gl_error = unsafe { gl.get_error() };
        for _ in 0..100 {
            // SAFETY: as above.
            if unsafe { gl.get_error() } == 0 {
                break;
            }
        }
        if gl_error != crate::glw::GL_NO_ERROR {
            log::info!(
                "After test execution glGetError() returned: {}, forcing FAIL for subcase",
                crate::glw::error_name(gl_error)
            );
            sub_error = ERROR;
        }

        match sub_error {
            ERROR => Ok(TestStatus::fail("Fail")),
            NOT_SUPPORTED => Err(TestError::NotSupported("Not supported".to_string())),
            _ => Ok(TestStatus::pass("Pass")),
        }
    }
}

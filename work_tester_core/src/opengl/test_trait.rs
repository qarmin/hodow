#![cfg(feature = "gpu")]

use std::error::Error;

/// OpenGL version specification
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct GLVersion {
    pub major: u8,
    pub minor: u8,
}

impl GLVersion {
    pub const fn new(major: u8, minor: u8) -> Self {
        Self { major, minor }
    }
}

impl std::fmt::Display for GLVersion {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}.{}", self.major, self.minor)
    }
}

/// Trait for OpenGL test examples
pub trait GLTest: Sync {
    /// Name of the test example
    fn name(&self) -> &'static str;

    /// OpenGL version this test targets
    fn gl_version(&self) -> GLVersion;

    /// List of OpenGL functions used in this test
    fn used_functions(&self) -> &[&'static str];

    /// Run the test - returns (success, message)
    fn run(&self) -> Result<String, Box<dyn Error>>;
}

/// Result type for GL tests similar to CPU tests
pub type GLTestResult = Result<(usize, usize, usize), String>;

/// Helper to run a GL test and convert to standard result format
pub fn run_gl_test(test: &dyn GLTest) -> GLTestResult {
    match test.run() {
        Ok(msg) => {
            log::info!("GL Test '{}' passed: {}", test.name(), msg);
            Ok((1, 0, 0))
        }
        Err(e) => {
            log::error!("GL Test '{}' failed: {}", test.name(), e);
            Ok((1, 0, 1))
        }
    }
}

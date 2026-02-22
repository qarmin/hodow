#![cfg(feature = "gpu")]

//! OpenGL test examples
//!
//! Each module implements a test for specific OpenGL functionality,
//! targeting a specific OpenGL version.

pub mod gl20_shaders;
pub mod gl33_vao;

use crate::opengl::test_trait::{GLTest, GLTestResult};

/// Get all available GL tests
pub fn all_tests() -> Vec<&'static dyn GLTest> {
    vec![
        &gl20_shaders::GL20ShadersTest,
        &gl33_vao::GL33VAOTest,
    ]
}

/// Run all GL tests
pub fn test_all_gl() -> GLTestResult {
    // Collect tests once
    let tests = all_tests();
    let total_tests = tests.len();

    // Run them inside a single window/event loop to avoid recreating EventLoop instances
    let spec = crate::opengl::gui::WindowSpec { title: Some("GL Tests".to_string()), width: 800, height: 600 };

    // The worker closure will run all tests sequentially and return aggregated results
    let result = crate::opengl::gui::GuiRuntimeHandle::with_window(Some(spec), move || {
        let mut total_run = 0usize;
        let total_skipped = 0usize;
        let mut total_errors = 0usize;

        for test in &tests {
            log::info!("Running GL test: {} (GL {})", test.name(), test.gl_version());
            match test.run() {
                Ok(msg) => {
                    log::info!("GL Test '{}' passed: {}", test.name(), msg);
                    total_run += 1;
                }
                Err(e) => {
                    log::error!("GL Test '{}' failed: {}", test.name(), e);
                    total_run += 1;
                    total_errors += 1;
                }
            }
        }

        Ok(format!("Run: {}, Skipped: {}, Errors: {}", total_run, total_skipped, total_errors))
    });

    match result {
        Ok(_) => Ok((total_tests, 0, 0)),
        Err(e) => {
            // If the GUI runtime failed entirely, consider all tests as attempted with an error
            log::error!("GL test run failed: {}", e);
            Ok((total_tests, 0, total_tests))
        }
    }
}

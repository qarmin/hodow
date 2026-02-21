#![cfg(feature = "gpu")]

//! OpenGL test examples
//!
//! Each module implements a test for specific OpenGL functionality,
//! targeting a specific OpenGL version.

pub mod gl20_shaders;
pub mod gl33_vao;

use crate::opengl::test_trait::{GLTest, GLTestResult, run_gl_test};

/// Get all available GL tests
pub fn all_tests() -> Vec<&'static dyn GLTest> {
    vec![
        &gl20_shaders::GL20ShadersTest,
        &gl33_vao::GL33VAOTest,
    ]
}

/// Run all GL tests
pub fn test_all_gl() -> GLTestResult {
    let mut total_run = 0;
    let mut total_skipped = 0;
    let mut total_errors = 0;

    for test in all_tests() {
        log::info!("Running GL test: {} (GL {})", test.name(), test.gl_version());
        match run_gl_test(test) {
            Ok((run, skipped, errors)) => {
                total_run += run;
                total_skipped += skipped;
                total_errors += errors;
            }
            Err(e) => {
                log::error!("GL test failed: {}", e);
                total_errors += 1;
            }
        }
    }

    Ok((total_run, total_skipped, total_errors))
}

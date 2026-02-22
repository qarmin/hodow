#![cfg(feature = "gpu")]

//! OpenGL test examples
//!
//! Each module implements a test for specific OpenGL functionality,
//! targeting a specific OpenGL version.

pub mod gl11_textures;
pub mod gl15_vbo;
pub mod gl20_shaders;
pub mod gl30_fbo;
pub mod gl33_vao;

use crate::opengl::test_trait::{GLTest, GLTestResult};

/// Get all available GL tests
pub fn all_tests() -> Vec<&'static dyn GLTest> {
    vec![
        &gl11_textures::GL11TexturesTest,
        &gl15_vbo::GL15VBOTest,
        &gl20_shaders::GL20ShadersTest,
        &gl30_fbo::GL30FBOTest,
        &gl33_vao::GL33VAOTest,
    ]
}

/// Run all GL tests
pub fn test_all_gl() -> GLTestResult {
    let tests = all_tests();
    let total_tests = tests.len();

    let spec = crate::opengl::gui::WindowSpec {
        title: Some(format!("GL Tests ({} tests)", total_tests)),
        width: 800,
        height: 600,
    };

    // Run all tests in a single window/event loop (winit limitation: can't recreate EventLoop)
    let result = crate::opengl::gui::GuiRuntimeHandle::with_window(Some(spec), move || {
        let mut total_run = 0usize;
        let total_skipped = 0usize;
        let mut total_errors = 0usize;

        for test in &tests {
            log::info!("Running GL test: {} (GL {})", test.name(), test.gl_version());

            // Clear screen before each test
            unsafe {
                gl::Clear(gl::COLOR_BUFFER_BIT | gl::DEPTH_BUFFER_BIT);
            }

            let test_start = std::time::Instant::now();
            match test.run() {
                Ok(msg) => {
                    let elapsed_ms = test_start.elapsed().as_millis();
                    log::info!("GL Test '{}' passed in {}ms: {}", test.name(), elapsed_ms, msg);
                    total_run += 1;

                    // Small delay between tests to show each result
                    std::thread::sleep(std::time::Duration::from_millis(500));
                }
                Err(e) => {
                    let elapsed_ms = test_start.elapsed().as_millis();
                    log::error!("GL Test '{}' failed after {}ms: {}", test.name(), elapsed_ms, e);
                    total_run += 1;
                    total_errors += 1;
                }
            }
        }

        Ok(format!(
            "Run: {}, Skipped: {}, Errors: {}",
            total_run, total_skipped, total_errors
        ))
    });

    match result {
        Ok(_) => Ok((total_tests, 0, 0)),
        Err(e) => {
            log::error!("GL test run failed: {}", e);
            Ok((total_tests, 0, total_tests))
        }
    }
}

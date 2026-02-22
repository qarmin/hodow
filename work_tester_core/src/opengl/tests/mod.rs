//! OpenGL test examples
//!
//! Each module implements a test for specific OpenGL functionality,
//! targeting a specific OpenGL version.

use std::time::Duration;

/// Test duration in milliseconds - how long each test should render
pub const TEST_DURATION_MS: u64 = 1000;

/// Test duration as Duration
pub const TEST_DURATION: Duration = Duration::from_millis(TEST_DURATION_MS);

pub mod gl11_textures;
pub mod gl13_multitexture;
pub mod gl15_vbo;
pub mod gl20_shaders;
pub mod gl21_pixelbuffers;
pub mod gl30_fbo;
pub mod gl31_ubo;
pub mod gl33_vao;
pub mod gl40_tessellation;
pub mod gl43_compute;

use crate::opengl::test_trait::{GLTest, GLTestResult};

/// Get all available GL tests
pub fn all_tests() -> Vec<&'static dyn GLTest> {
    vec![
        &gl11_textures::GL11TexturesTest,
        &gl13_multitexture::GL13MultitextureTest,
        &gl15_vbo::GL15VBOTest,
        &gl20_shaders::GL20ShadersTest,
        &gl21_pixelbuffers::GL21PixelBuffersTest,
        &gl30_fbo::GL30FBOTest,
        &gl31_ubo::GL31UBOTest,
        &gl33_vao::GL33VAOTest,
        &gl40_tessellation::GL40TessellationTest,
        &gl43_compute::GL43ComputeTest,
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

    // Prepare test runner state
    let test_runner = TestRunner {
        tests,
        current_test_idx: 0,
        total_run: 0,
        total_errors: 0,
    };

    // Run all tests in a single window with frame-by-frame rendering
    let result = crate::opengl::gui::GuiRuntimeHandle::with_window_stateful(Some(spec), move || Box::new(test_runner));

    match result {
        Ok((run, errors)) => Ok((run, 0, errors)),
        Err(e) => {
            log::error!("GL test run failed: {}", e);
            Ok((total_tests, 0, total_tests))
        }
    }
}

/// Test runner state for frame-by-frame execution
struct TestRunner {
    tests: Vec<&'static dyn GLTest>,
    current_test_idx: usize,
    total_run: usize,
    total_errors: usize,
}

impl crate::opengl::gui::StatefulRunner for TestRunner {
    fn init(&mut self) -> Result<(), Box<dyn std::error::Error>> {
        if self.current_test_idx < self.tests.len() {
            let test = self.tests[self.current_test_idx];
            log::info!("Running GL test: {} (GL {})", test.name(), test.gl_version());
            // Clear screen before each test
            unsafe {
                gl::Clear(gl::COLOR_BUFFER_BIT | gl::DEPTH_BUFFER_BIT);
            }
        }
        Ok(())
    }

    fn update(&mut self, _delta_ms: u64) -> Result<bool, Box<dyn std::error::Error>> {
        // Check if all tests are complete
        if self.current_test_idx >= self.tests.len() {
            return Ok(false); // All tests done
        }

        // Run current test synchronously (this will be refactored per-test in the future)
        let test = self.tests[self.current_test_idx];
        let test_start = std::time::Instant::now();

        match test.run() {
            Ok(msg) => {
                let elapsed_ms = test_start.elapsed().as_millis();
                log::info!("GL Test '{}' passed in {}ms: {}", test.name(), elapsed_ms, msg);
                self.total_run += 1;
            }
            Err(e) => {
                let elapsed_ms = test_start.elapsed().as_millis();
                log::error!("GL Test '{}' failed after {}ms: {}", test.name(), elapsed_ms, e);
                self.total_run += 1;
                self.total_errors += 1;
            }
        }

        self.current_test_idx += 1;

        // Start next test or finish
        if self.current_test_idx < self.tests.len() {
            let test = self.tests[self.current_test_idx];
            log::info!("Running GL test: {} (GL {})", test.name(), test.gl_version());
            unsafe {
                gl::Clear(gl::COLOR_BUFFER_BIT | gl::DEPTH_BUFFER_BIT);
            }
            Ok(true) // Continue to next test
        } else {
            Ok(false) // All tests complete
        }
    }

    fn get_result(&self) -> (usize, usize) {
        (self.total_run, self.total_errors)
    }
}

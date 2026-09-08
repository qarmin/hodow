//! OpenGL test examples
//!
//! Each module implements a test for specific OpenGL functionality,
//! targeting a specific OpenGL version.

use std::time::Duration;

use crate::opengl::GpuOptions;

/// Default test duration in milliseconds
pub const DEFAULT_TEST_DURATION_MS: u64 = 1000;

/// Per-test duration (atomically overridable via GpuOptions)
pub static TEST_DURATION_MS: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(DEFAULT_TEST_DURATION_MS);

/// Per-test frame limit; 0 = unlimited
pub static TEST_FRAME_LIMIT: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(0);

/// Apply GpuOptions so individual tests read the correct limits
pub fn apply_gpu_options(opts: &GpuOptions) {
    let ms = opts.time_limit_ms.unwrap_or(DEFAULT_TEST_DURATION_MS);
    TEST_DURATION_MS.store(ms, std::sync::atomic::Ordering::Relaxed);
    TEST_FRAME_LIMIT.store(opts.frame_limit.unwrap_or(0), std::sync::atomic::Ordering::Relaxed);
}

/// Current per-test Duration (reads the atomic)
pub fn test_duration() -> Duration {
    Duration::from_millis(TEST_DURATION_MS.load(std::sync::atomic::Ordering::Relaxed))
}

/// Current frame limit (0 = unlimited)
pub fn frame_limit() -> u64 {
    TEST_FRAME_LIMIT.load(std::sync::atomic::Ordering::Relaxed)
}

/// Returns true when the test loop should stop (duration elapsed OR frame limit hit)
pub fn should_stop_loop(start: std::time::Instant, frames: u64) -> bool {
    let fl = frame_limit();
    if fl > 0 && frames >= fl {
        return true;
    }
    start.elapsed() >= test_duration()
}

/// Kept for source compatibility with existing test files
pub const TEST_DURATION: Duration = Duration::from_millis(DEFAULT_TEST_DURATION_MS);

pub mod gl10_state;
pub mod gl10_textures;
pub mod gl11_texcopy;
pub mod gl11_textures;
pub mod gl12_textures3d;
pub mod gl13_compressed;
pub mod gl13_multitexture;
pub mod gl14_blend;
pub mod gl15_queries;
pub mod gl20_uniforms;
pub mod gl20_vertex_attribs;
pub mod gl21_matrices;
pub mod gl21_pixelbuffers;
pub mod gl30_advanced;
pub mod gl30_fbo;
pub mod gl30_shaders;
pub mod gl30_vbo;
pub mod gl31_ubo;
pub mod gl31_uniform_blocks;
pub mod gl32_geometry;
pub mod gl32_sync;
pub mod gl33_instancing;
pub mod gl33_packed;
pub mod gl33_vao;
pub mod gl40_tessellation;
pub mod gl40_transform_feedback;
pub mod gl41_program_pipeline;
pub mod gl41_program_uniforms;
pub mod gl42_image_load_store;
pub mod gl42_storage;
pub mod gl43_advanced;
pub mod gl43_compute;
pub mod gl43_debug;
pub mod gl44_batch_bind;
pub mod gl45_dsa;
pub mod gl45_dsa_extended;
pub mod validation;

use crate::opengl::test_trait::{GLTest, GLTestResult};

/// Get all available GL tests
pub fn all_tests() -> Vec<&'static dyn GLTest> {
    vec![
        &gl10_state::GL10StateTest,
        &gl10_textures::GL10TexturesTest,
        &gl11_texcopy::GL11TexCopyTest,
        &gl11_textures::GL11TexturesTest,
        &gl12_textures3d::GL12Textures3DTest,
        &gl13_compressed::GL13CompressedTest,
        &gl13_multitexture::GL13MultitextureTest,
        &gl14_blend::GL14BlendTest,
        &gl15_queries::GL15QueriesTest,
        &gl20_uniforms::GL20UniformsTest,
        &gl20_vertex_attribs::GL20VertexAttribsTest,
        &gl21_matrices::GL21MatricesTest,
        &gl21_pixelbuffers::GL21PixelBuffersTest,
        &gl30_advanced::GL30AdvancedTest,
        &gl30_vbo::GL30VBOTest,
        &gl30_shaders::GL30ShadersTest,
        &gl30_fbo::GL30FBOTest,
        &gl31_ubo::GL31UBOTest,
        &gl31_uniform_blocks::GL31UniformBlocksTest,
        &gl32_geometry::GL32GeometryTest,
        &gl32_sync::GL32SyncTest,
        &gl33_instancing::GL33InstancingTest,
        &gl33_packed::GL33PackedTest,
        &gl33_vao::GL33VAOTest,
        &gl40_tessellation::GL40TessellationTest,
        &gl40_transform_feedback::GL40TransformFeedbackTest,
        &gl41_program_pipeline::GL41ProgramPipelineTest,
        &gl41_program_uniforms::GL41ProgramUniformsTest,
        &gl42_image_load_store::GL42ImageLoadStoreTest,
        &gl42_storage::GL42StorageTest,
        &gl43_advanced::GL43AdvancedTest,
        &gl43_compute::GL43ComputeTest,
        &gl43_debug::GL43DebugTest,
        &gl44_batch_bind::GL44BatchBindTest,
        &gl45_dsa::GL45DSATest,
        &gl45_dsa_extended::GL45DSAExtendedTest,
        // Output-validating tests (analytical oracles, driver-independent).
        &validation::ClearColorValidation,
        &validation::RenderSolidValidation,
        &validation::ComputeValidation,
        &validation::BlendValidation,
    ]
}

/// Human-readable name for a GL error code.
fn gl_error_name(e: u32) -> &'static str {
    match e {
        gl::INVALID_ENUM => "GL_INVALID_ENUM",
        gl::INVALID_VALUE => "GL_INVALID_VALUE",
        gl::INVALID_OPERATION => "GL_INVALID_OPERATION",
        gl::INVALID_FRAMEBUFFER_OPERATION => "GL_INVALID_FRAMEBUFFER_OPERATION",
        gl::OUT_OF_MEMORY => "GL_OUT_OF_MEMORY",
        gl::STACK_OVERFLOW => "GL_STACK_OVERFLOW",
        gl::STACK_UNDERFLOW => "GL_STACK_UNDERFLOW",
        _ => "GL_ERROR",
    }
}

/// Drain the GL error queue. Returns the first error found (formatted), or None. Used both to
/// give each test a clean slate and to detect errors a test left behind even when it reported OK.
///
/// # Safety
/// Requires a current GL context.
unsafe fn drain_gl_errors() -> Option<String> {
    let mut first = None;
    loop {
        let e = unsafe { gl::GetError() };
        if e == gl::NO_ERROR {
            break;
        }
        if first.is_none() {
            first = Some(format!("{} (0x{e:04x})", gl_error_name(e)));
        }
    }
    first
}

/// GL debug-output callback: logs driver diagnostics (which call errored and why). Only
/// non-notification messages are logged to keep the output focused.
extern "system" fn gl_debug_callback(_source: u32, _gltype: u32, _id: u32, severity: u32, _length: i32, message: *const std::os::raw::c_char, _user: *mut std::ffi::c_void) {
    if severity == gl::DEBUG_SEVERITY_NOTIFICATION {
        return;
    }
    let msg = unsafe { std::ffi::CStr::from_ptr(message) }.to_string_lossy();
    log::warn!("[GL debug] {}", msg);
}

/// Enable synchronous GL debug output if the context supports it (GL 4.3 / KHR_debug).
/// Synchronous mode makes the callback fire on the offending call, pinpointing errors.
///
/// # Safety
/// Requires a current GL context.
unsafe fn enable_gl_debug_output() {
    unsafe {
        let mut flags = 0i32;
        gl::GetIntegerv(gl::CONTEXT_FLAGS, &mut flags);
        gl::Enable(gl::DEBUG_OUTPUT);
        gl::Enable(gl::DEBUG_OUTPUT_SYNCHRONOUS);
        gl::DebugMessageCallback(Some(gl_debug_callback), std::ptr::null());
        // Clear any error from unsupported enums on older contexts.
        while gl::GetError() != gl::NO_ERROR {}
    }
}

/// Run all GL tests with the provided options
pub fn test_all_gl(opts: &crate::opengl::GpuOptions) -> GLTestResult {
    apply_gpu_options(opts);

    let tests = all_tests();
    let total_tests = tests.len();

    if opts.no_window {
        // Headless: run tests directly without a windowing system
        let mut total_run = 0usize;
        let mut total_errors = 0usize;

        // Headless mode requires an OpenGL context without a visible window.
        // We create a surfaceless context via the existing init_opengl helper.
        let _ctx = match crate::opengl::init_opengl(opts) {
            Ok(c) => c,
            Err(e) => {
                log::error!("Failed to create headless OpenGL context: {}", e);
                return Ok((0, 0, total_tests));
            }
        };

        unsafe { enable_gl_debug_output() };

        for test in &tests {
            log::info!("Running GL test (headless): {} (GL {})", test.name(), test.gl_version());
            // Re-assert our debug callback each iteration: a test may install its own (e.g. the
            // debug-output test), which would otherwise blind diagnostics for all later tests.
            unsafe { enable_gl_debug_output() };
            unsafe { drain_gl_errors() }; // clean slate so errors are attributed to this test
            let outcome = run_test_catching_panic(test);
            let gl_err = unsafe { drain_gl_errors() };
            total_run += 1;
            match (outcome, gl_err) {
                (Ok(msg), None) => log::info!("GL Test '{}' passed: {}", test.name(), msg),
                (Ok(_), Some(err)) => {
                    log::error!("GL Test '{}' left a GL error: {}", test.name(), err);
                    total_errors += 1;
                }
                (Err(e), _) => {
                    log::error!("GL Test '{}' failed: {}", test.name(), e);
                    total_errors += 1;
                }
            }
        }
        return Ok((total_run, 0, total_errors));
    }

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

/// Run one test, turning a panic into that test's failure.
///
/// The `gl` crate's generated bindings `panic!("gl function was not loaded")` when a test calls
/// an entry point the driver does not export. That is the normal case on a GLES-only driver
/// (Vivante/imx-gpu-viv, where the desktop-GL 1.x tests have nothing to call), and killing the
/// process on the first one means the other 39 tests never report anything. A missing function
/// is a result about the driver, so it belongs in the results.
fn run_test_catching_panic(test: &&'static dyn GLTest) -> Result<String, String> {
    match std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| test.run())) {
        Ok(Ok(msg)) => Ok(msg),
        Ok(Err(e)) => Err(e.to_string()),
        Err(payload) => {
            let msg = payload
                .downcast_ref::<&str>()
                .map(|s| (*s).to_string())
                .or_else(|| payload.downcast_ref::<String>().cloned())
                .unwrap_or_else(|| "panicked with a non-string payload".to_string());
            Err(format!("panicked: {msg}"))
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

        unsafe { drain_gl_errors() }; // clean slate so errors are attributed to this test
        let outcome = run_test_catching_panic(&test);
        let gl_err = unsafe { drain_gl_errors() };
        let elapsed_ms = test_start.elapsed().as_millis();
        self.total_run += 1;
        match (outcome, gl_err) {
            (Ok(msg), None) => log::info!("GL Test '{}' passed in {}ms: {}", test.name(), elapsed_ms, msg),
            (Ok(_), Some(err)) => {
                log::error!("GL Test '{}' left a GL error after {}ms: {}", test.name(), elapsed_ms, err);
                self.total_errors += 1;
            }
            (Err(e), _) => {
                log::error!("GL Test '{}' failed after {}ms: {}", test.name(), elapsed_ms, e);
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

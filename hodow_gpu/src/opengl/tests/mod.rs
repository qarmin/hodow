//! OpenGL test examples
//!
//! Each module implements a test for specific OpenGL functionality,
//! targeting a specific OpenGL version.

use std::sync::atomic::{AtomicUsize, Ordering};
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

static QUICK: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);

/// Tests whose output is checked against an analytic value and that finish at once: what a toolkit
/// drawing 2D UI depends on (fill, blend, alpha in the window, texture round-trip, scissor, blit).
const QUICK_TESTS: &[&str] = &[
    "ES30_Draw",
    "ES30_Blend",
    "ES30_Texture",
    "ES30_Scissor",
    "ES30_Blit",
    "ES30_MRT",
    "Validate_ClearColor",
    "Validate_RenderSolid",
    "Validate_Blend",
    "Validate_WindowAlpha",
    "Validate_Compute",
];

/// Restrict `all_tests()` to `QUICK_TESTS`. Isolate parent and worker index into the same list, so both must set it.
pub fn set_quick(quick: bool) {
    QUICK.store(quick, Ordering::Relaxed);
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

pub mod es3_validation;
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
pub mod window_alpha;

use crate::opengl::test_trait::{GLTest, GLTestResult};

static EXTRA_TESTS: std::sync::OnceLock<fn() -> Vec<&'static dyn GLTest>> = std::sync::OnceLock::new();

/// Registers a provider of tests that live outside this crate (the processing flows, which need `hodow_bench`).
/// Asked on every `all_tests()` call. Parent and isolated worker must register the same provider, or their test
/// indices disagree.
pub fn set_extra_tests(provider: fn() -> Vec<&'static dyn GLTest>) {
    let _ = EXTRA_TESTS.set(provider);
}

/// Get all available GL tests
pub fn all_tests() -> Vec<&'static dyn GLTest> {
    #[allow(unused_mut)]
    let mut tests: Vec<&'static dyn GLTest> = vec![
        &es3_validation::Es30DrawTest,
        &es3_validation::Es30BlendTest,
        &es3_validation::Es30TextureTest,
        &es3_validation::Es30VertexAttribTest,
        &es3_validation::Es31ComputeTest,
        &es3_validation::Es30IntegerTextureTest,
        &es3_validation::Es30TransformFeedbackTest,
        &es3_validation::Es30UboTest,
        &es3_validation::Es30ScissorTest,
        &es3_validation::Es30DepthTest,
        &es3_validation::Es30InstancedTest,
        &es3_validation::Es30ColorMaskTest,
        &es3_validation::Es30StencilTest,
        &es3_validation::Es30DrawElementsTest,
        &es3_validation::Es30MrtTest,
        &es3_validation::Es30BlitTest,
        &es3_validation::Es30TextureArrayTest,
        &es3_validation::Es30Texture3DTest,
        &es3_validation::Es30MipmapTest,
        &es3_validation::Es30CopyBufferTest,
        &es3_validation::Es30SyncTest,
        &es3_validation::Es30OcclusionQueryTest,
        &es3_validation::Es31AtomicCounterTest,
        &es3_validation::Es31ImageStoreTest,
        &es3_validation::Es31ComputeSharedTest,
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
        &window_alpha::WindowAlphaTest,
    ];
    if let Some(provider) = EXTRA_TESTS.get() {
        tests.extend(provider());
    }
    if QUICK.load(Ordering::Relaxed) {
        tests.retain(|t| QUICK_TESTS.contains(&t.name()));
    }
    tests
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

/// How many driver messages one test may log before the rest are only counted. A test that
/// errors inside a render loop otherwise buries the run: one real finding (GL31_UBO on a
/// Vivante GC2000+) produced 6770 identical lines, 98% of the whole log.
const MAX_DEBUG_MESSAGES_PER_TEST: usize = 8;

static DEBUG_MESSAGES_THIS_TEST: AtomicUsize = AtomicUsize::new(0);

/// Say how many messages were held back, so a test spamming in a loop is still visible as such.
fn report_suppressed_debug_messages(test_name: &str) {
    let total = DEBUG_MESSAGES_THIS_TEST.load(Ordering::Relaxed);
    if total > MAX_DEBUG_MESSAGES_PER_TEST {
        log::warn!(
            "[GL debug] '{test_name}' produced {total} driver messages ({} not shown)",
            total - MAX_DEBUG_MESSAGES_PER_TEST
        );
    }
}

/// Called between tests so the budget above is per test, not per run.
fn reset_debug_message_budget() -> usize {
    DEBUG_MESSAGES_THIS_TEST.swap(0, Ordering::Relaxed)
}

/// GL debug-output callback: logs driver diagnostics (which call errored and why). Only
/// non-notification messages are logged, and only the first few per test.
extern "system" fn gl_debug_callback(
    _source: u32,
    _gltype: u32,
    _id: u32,
    severity: u32,
    _length: i32,
    message: *const std::os::raw::c_char,
    _user: *mut std::ffi::c_void,
) {
    if severity == gl::DEBUG_SEVERITY_NOTIFICATION {
        return;
    }
    let seen = DEBUG_MESSAGES_THIS_TEST.fetch_add(1, Ordering::Relaxed);
    if seen >= MAX_DEBUG_MESSAGES_PER_TEST {
        return;
    }
    let msg = unsafe { std::ffi::CStr::from_ptr(message) }.to_string_lossy();
    log::warn!("[GL debug] {}", msg);
    if seen + 1 == MAX_DEBUG_MESSAGES_PER_TEST {
        log::warn!("[GL debug] ...further messages from this test are only counted");
    }
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
/// How many tests `run_single` can be asked for.
pub fn test_count() -> usize {
    all_tests().len()
}

/// Run exactly one test, by index into `all_tests()`, in a context of its own.
///
/// The isolated runner gives every test its own process, so a driver that hangs or segfaults
/// costs that one test instead of the whole run - `cpu --isolate` has had that for a while,
/// and a GPU driver is the more likely of the two to take the process with it.
/// Returns `(outcome, message)` where outcome is `passed`, `unsupported` or `failed`.
pub fn run_single(opts: &crate::opengl::GpuOptions, index: usize) -> Result<(&'static str, String), String> {
    let tests = all_tests();
    let test = tests
        .get(index)
        .ok_or_else(|| format!("test index {index} out of range ({})", tests.len()))?;
    let _ctx = crate::opengl::init_opengl(opts).map_err(|e| format!("failed to create GL context: {e}"))?;
    unsafe { enable_gl_debug_output() };
    reset_debug_message_budget();
    unsafe { drain_gl_errors() };
    let outcome = run_one_test(test);
    let gl_err = unsafe { drain_gl_errors() };
    Ok(match (outcome, gl_err) {
        (TestOutcome::Unsupported(why), _) => ("unsupported", why),
        (TestOutcome::Passed(msg), None) => ("passed", msg),
        (TestOutcome::Passed(_), Some(err)) => ("failed", format!("left a GL error: {err}")),
        (TestOutcome::Failed(e), _) => ("failed", e),
    })
}

/// The name of the test at `index`, for the parent process to attribute a crash to.
pub fn test_name_at(index: usize) -> Option<&'static str> {
    all_tests().get(index).map(|t| t.name())
}

pub fn test_all_gl(opts: &crate::opengl::GpuOptions) -> GLTestResult {
    apply_gpu_options(opts);

    let tests = all_tests();
    let total_tests = tests.len();

    if opts.no_window {
        // Headless: run tests directly without a windowing system
        let mut total_run = 0usize;
        let mut total_skipped = 0usize;
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
            reset_debug_message_budget();
            let outcome = run_one_test(test);
            let gl_err = unsafe { drain_gl_errors() };
            report_suppressed_debug_messages(test.name());
            total_run += 1;
            match (outcome, gl_err) {
                (TestOutcome::Unsupported(why), _) => {
                    log::info!("GL Test '{}' not supported here: {}", test.name(), why);
                    total_skipped += 1;
                }
                (TestOutcome::Passed(msg), None) => log::info!("GL Test '{}' passed: {}", test.name(), msg),
                (TestOutcome::Passed(_), Some(err)) => {
                    log::error!("GL Test '{}' left a GL error: {}", test.name(), err);
                    total_errors += 1;
                }
                (TestOutcome::Failed(e), _) => {
                    log::error!("GL Test '{}' failed: {}", test.name(), e);
                    total_errors += 1;
                }
            }
        }
        return Ok((total_run, total_skipped, total_errors));
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
        total_skipped: 0,
        total_errors: 0,
    };

    // Run all tests in a single window with frame-by-frame rendering
    let result = crate::opengl::gui::GuiRuntimeHandle::with_window_stateful(Some(spec), move || Box::new(test_runner));

    // No window means no test ran; reporting that as one failure per test blames the tests.
    result.map_err(|e| format!("could not open a window ({e}) - use --no-window when there is no display"))
}

/// What one test run amounted to.
enum TestOutcome {
    Passed(String),
    /// The driver cannot run this test at all. Not a defect - counted as skipped.
    Unsupported(String),
    Failed(String),
}

/// The `gl` crate's generated bindings panic with exactly this when a test calls an entry point
/// the driver does not export.
const GL_FN_MISSING: &str = "gl function was not loaded";

/// What shading language this context actually accepts, from `GL_SHADING_LANGUAGE_VERSION`
/// ("4.50 ..." for desktop, "OpenGL ES GLSL ES 3.10" for ES).
enum ContextGlsl {
    Desktop(u32),
    /// GLSL ES version as NNN, e.g. 310 for "OpenGL ES GLSL ES 3.10".
    Es(u32),
    Unknown,
}

fn context_glsl() -> ContextGlsl {
    let raw = unsafe {
        let ptr = gl::GetString(gl::SHADING_LANGUAGE_VERSION);
        if ptr.is_null() {
            return ContextGlsl::Unknown;
        }
        std::ffi::CStr::from_ptr(ptr as *const std::os::raw::c_char)
            .to_string_lossy()
            .into_owned()
    };
    // "4.50 - Build ..." -> 450, "OpenGL ES GLSL ES 3.10" -> 310. The minor part is two digits
    // in both spellings.
    let mut parts = raw.split(|c: char| !c.is_ascii_digit()).filter(|p| !p.is_empty());
    let version = match (
        parts.next().and_then(|p| p.parse::<u32>().ok()),
        parts.next().and_then(|p| p.parse::<u32>().ok()),
    ) {
        (Some(major), Some(minor)) => major * 100 + minor,
        _ => return ContextGlsl::Unknown,
    };
    if raw.contains("ES") {
        ContextGlsl::Es(version)
    } else {
        ContextGlsl::Desktop(version)
    }
}

/// Why this context cannot compile the test's shaders, if it cannot.
fn glsl_shortfall(test: &&'static dyn GLTest) -> Option<String> {
    use crate::opengl::generated_requirements as req;
    let context = context_glsl();
    if let Some(needed) = req::required_glsl_version(test.name()) {
        return match context {
            ContextGlsl::Es(_) => Some(format!(
                "its shaders are #version {needed} (desktop GLSL); this is an OpenGL ES context"
            )),
            ContextGlsl::Desktop(have) if have < needed => {
                Some(format!("its shaders need GLSL {needed}, this context offers {have}"))
            }
            _ => None,
        };
    }
    if let Some(needed) = req::required_es_glsl_version(test.name()) {
        // A desktop context accepts ES shaders only from 4.3 (ARB_ES3_compatibility), and ES 3.1
        // shaders only from 4.5 (ARB_ES3_1_compatibility).
        let desktop_floor = if needed >= 310 { 450 } else { 430 };
        return match context {
            ContextGlsl::Es(have) if have < needed => Some(format!(
                "its shaders are #version {needed} es, this context offers GLSL ES {have}"
            )),
            ContextGlsl::Desktop(have) if have < desktop_floor => Some(format!(
                "its shaders are #version {needed} es; a desktop context needs GLSL {desktop_floor} to accept those, this one offers {have}"
            )),
            _ => None,
        };
    }
    None
}

/// The entry points `test` needs that this driver does not export, from the generated table -
/// checked before the test runs, so an unsupported test is never entered at all. Same shape as
/// the CPU side, where a missing feature means the group is skipped rather than executed.
fn missing_functions(test: &&'static dyn GLTest) -> Vec<&'static str> {
    crate::opengl::generated_requirements::required_functions(test.name())
        .iter()
        .filter(|(_, loaded)| !loaded())
        .map(|(name, _)| *name)
        .collect()
}

/// Run one test, catching a panic and separating "this driver cannot do it" from "this driver
/// got it wrong".
///
/// A missing entry point is routine on a GLES-only driver (Vivante/imx-gpu-viv: the desktop-GL
/// 1.x tests have nothing to call there) and used to abort the whole process on the first one.
/// Reporting it as a *failure* is just as wrong in the other direction - this project exists to
/// find hardware and driver defects, and "GL 4.5 DSA is absent from a GLES 3.1 driver" is not
/// one. Same for the `skipped: ...` string tests already return when they detect a version they
/// need is missing; that used to count as a pass, which quietly inflated the result.
/// Driver-supplied text reaches us through `glGet{Shader,Program}InfoLog`, and several tests
/// hand back the whole buffer including its NUL terminator. One such byte is enough for `grep`
/// to call the saved log a binary file and print nothing.
fn sanitize(msg: String) -> String {
    if msg.contains('\0') {
        msg.replace('\0', "").trim_end().to_string()
    } else {
        msg
    }
}

fn run_one_test(test: &&'static dyn GLTest) -> TestOutcome {
    if let Some(why) = glsl_shortfall(test) {
        return TestOutcome::Unsupported(why);
    }
    let missing = missing_functions(test);
    if !missing.is_empty() {
        return TestOutcome::Unsupported(format!(
            "the driver does not export {} of the {} function(s) it calls, e.g. {}",
            missing.len(),
            crate::opengl::generated_requirements::required_functions(test.name()).len(),
            missing.iter().take(3).copied().collect::<Vec<_>>().join(", ")
        ));
    }
    match std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| test.run())) {
        Ok(Ok(msg)) if msg.starts_with("skipped:") => TestOutcome::Unsupported(sanitize(msg)),
        Ok(Ok(msg)) => TestOutcome::Passed(sanitize(msg)),
        Ok(Err(e)) => TestOutcome::Failed(sanitize(e.to_string())),
        Err(payload) => {
            let msg = payload
                .downcast_ref::<&str>()
                .map(|s| (*s).to_string())
                .or_else(|| payload.downcast_ref::<String>().cloned())
                .unwrap_or_else(|| "panicked with a non-string payload".to_string());
            if msg.contains(GL_FN_MISSING) {
                TestOutcome::Unsupported("the driver does not export a function this test calls".into())
            } else {
                TestOutcome::Failed(format!("panicked: {msg}"))
            }
        }
    }
}

/// Test runner state for frame-by-frame execution
struct TestRunner {
    tests: Vec<&'static dyn GLTest>,
    current_test_idx: usize,
    total_run: usize,
    total_skipped: usize,
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
        reset_debug_message_budget();
        let outcome = run_one_test(&test);
        let gl_err = unsafe { drain_gl_errors() };
        report_suppressed_debug_messages(test.name());
        let elapsed_ms = test_start.elapsed().as_millis();
        self.total_run += 1;
        match (outcome, gl_err) {
            (TestOutcome::Unsupported(why), _) => {
                log::info!("GL Test '{}' not supported here: {}", test.name(), why);
                self.total_skipped += 1;
            }
            (TestOutcome::Passed(msg), None) => {
                log::info!("GL Test '{}' passed in {}ms: {}", test.name(), elapsed_ms, msg)
            }
            (TestOutcome::Passed(_), Some(err)) => {
                log::error!(
                    "GL Test '{}' left a GL error after {}ms: {}",
                    test.name(),
                    elapsed_ms,
                    err
                );
                self.total_errors += 1;
            }
            (TestOutcome::Failed(e), _) => {
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

    fn get_result(&self) -> (usize, usize, usize) {
        (self.total_run, self.total_skipped, self.total_errors)
    }
}

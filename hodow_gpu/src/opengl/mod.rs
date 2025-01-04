//! OpenGL helper module for GPU testing.
use log::info;

pub mod burn;
mod context;

#[rustfmt::skip]
mod generated_requirements;

mod loader;
#[cfg(test)]
mod query_size_lint;
#[cfg(windows)]
mod win32_window;

pub mod memtest;

mod test_trait;

pub mod tests;

// Export real implementations (no feature gating inside this module)
pub use context::OpenGLMode;
pub use loader::init_gl;
pub use test_trait::{GLTest, GLTestResult, GLVersion};

/// Which display/rendering API backend to use when creating the GL display.
///
/// On Linux this selects between EGL and GLX (and their fallback combinations).
/// On other platforms only a subset is applicable.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum DisplayApiHint {
    /// Pure EGL (default, works headless without an X server)
    #[default]
    Egl,
    /// Pure GLX (requires an X11 display)
    Glx,
    /// Try EGL first, fall back to GLX
    EglThenGlx,
    /// Try GLX first, fall back to EGL
    GlxThenEgl,
}

impl std::str::FromStr for DisplayApiHint {
    type Err = String;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s.to_ascii_lowercase().as_str() {
            "egl" => Ok(Self::Egl),
            "glx" => Ok(Self::Glx),
            "egl-then-glx" | "eglthenglx" => Ok(Self::EglThenGlx),
            "glx-then-egl" | "glxthenegl" => Ok(Self::GlxThenEgl),
            other => Err(format!(
                "unknown display-api '{}'; valid values: egl, glx, egl-then-glx, glx-then-egl",
                other
            )),
        }
    }
}

/// Which OpenGL API flavour and optional version to request from glutin.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum GlApiHint {
    /// Let glutin pick (OpenGL Core ≥ 3.3 by default)
    #[default]
    Auto,
    /// Request OpenGL (desktop) with an optional major.minor version
    OpenGl { major: u8, minor: u8 },
    /// Request OpenGL ES with an optional major.minor version
    Gles { major: u8, minor: u8 },
}

impl std::str::FromStr for GlApiHint {
    type Err = String;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let s = s.trim();
        if s.eq_ignore_ascii_case("auto") || s.is_empty() {
            return Ok(Self::Auto);
        }
        // Accept forms like "opengl", "opengl:3.3", "gles", "gles:3.0", "gles:2", "gl:4.6"
        let (api_part, version_part) = if let Some(pos) = s.find(':') {
            (&s[..pos], Some(&s[pos + 1..]))
        } else {
            (s, None)
        };
        let is_gles = matches!(api_part.to_ascii_lowercase().as_str(), "gles" | "es");
        let is_gl = matches!(api_part.to_ascii_lowercase().as_str(), "opengl" | "gl" | "desktop");
        if !is_gles && !is_gl {
            return Err(format!(
                "unknown gl-api '{}'; valid values: auto, opengl, opengl:MAJOR.MINOR, gles, gles:MAJOR.MINOR",
                s
            ));
        }
        let (major, minor) = if let Some(ver) = version_part {
            let parts: Vec<&str> = ver.splitn(2, '.').collect();
            let maj = parts[0]
                .parse::<u8>()
                .map_err(|_| format!("invalid major version in '{}'", s))?;
            let min = if parts.len() > 1 {
                parts[1]
                    .parse::<u8>()
                    .map_err(|_| format!("invalid minor version in '{}'", s))?
            } else {
                0
            };
            (maj, min)
        } else {
            (0, 0) // 0,0 → "any version"
        };
        if is_gles {
            Ok(Self::Gles { major, minor })
        } else {
            Ok(Self::OpenGl { major, minor })
        }
    }
}

/// Options controlling the GPU test run
#[derive(Debug, Clone, Default)]
pub struct GpuOptions {
    /// If true, run tests without creating a visible window (headless)
    pub no_window: bool,
    /// Per-test time limit in milliseconds (None = default 1000 ms)
    pub time_limit_ms: Option<u64>,
    /// Per-test frame limit (None / 0 = unlimited)
    pub frame_limit: Option<u64>,
    /// Which display/rendering backend to use (EGL, GLX, …)
    pub display_api: DisplayApiHint,
    /// Which GL API flavour (and optional version) to request
    pub gl_api: GlApiHint,
    /// Force Mesa software rendering (sets LIBGL_ALWAYS_SOFTWARE=1 before EGL init).
    /// Avoids hardware-driver crashes (e.g. Mesa gallium background-thread SEGV).
    pub force_software: bool,
}

pub fn init_opengl(opts: &GpuOptions) -> Result<OpenGLMode, Box<dyn std::error::Error>> {
    let ctx = OpenGLMode::create_with_opts(opts).map_err(|e| Box::new(e) as Box<dyn std::error::Error>)?;
    info!("Created OpenGL context");
    init_gl(&ctx)?;
    info!("Initialized OpenGL function pointers");
    Ok(ctx)
}

pub fn available_opengl_modes() -> Vec<String> {
    vec!["default-headless".to_string()]
}

/// What a headless context reports about the driver. Strings straight from `glGetString`.
pub struct GlInfo {
    pub vendor: String,
    pub renderer: String,
    pub version: String,
    pub glsl_version: String,
}

/// The combinations `probe_opengl` walks, in order. The default alone is not enough: it asks
/// for desktop OpenGL, which a GLES-only driver (Vivante/imx-gpu-viv, Mali, VideoCore) cannot
/// give at all, and it asks EGL for the default display, which the Wayland build of such a
/// driver rejects outright ("No default display support on wayland") when nothing else set up
/// a `wl_display`. Reporting "unavailable" off that one attempt says nothing about whether the
/// GPU works - only that one combination did not.
const PROBE_ATTEMPTS: &[(&str, DisplayApiHint, GlApiHint)] = &[
    ("EGL + OpenGL", DisplayApiHint::Egl, GlApiHint::Auto),
    (
        "EGL + GLES 3.0",
        DisplayApiHint::Egl,
        GlApiHint::Gles { major: 3, minor: 0 },
    ),
    (
        "EGL + GLES 2.0",
        DisplayApiHint::Egl,
        GlApiHint::Gles { major: 2, minor: 0 },
    ),
    ("GLX + OpenGL", DisplayApiHint::Glx, GlApiHint::Auto),
];

/// Create a throwaway headless context just to read the driver's identification strings.
/// Unlike `test_all_opengl` this renders nothing, but it does still load and initialize the
/// GL driver, so it is the one part of `hodow info` that can be affected by a broken one.
///
/// On failure the error lists every combination tried and why each one was refused, which is
/// what tells a GLES-only or Wayland-only driver apart from having no driver at all.
pub fn probe_opengl() -> Result<GlInfo, String> {
    let mut failures: Vec<(String, String)> = Vec::new();
    for (label, display_api, gl_api) in PROBE_ATTEMPTS {
        let opts = GpuOptions {
            no_window: true,
            display_api: *display_api,
            gl_api: *gl_api,
            ..Default::default()
        };
        match probe_with(&opts) {
            Ok(info) => return Ok(info),
            Err(e) => {
                // Every attempt after a repeat is wasted: the display/API hints only take
                // effect once an EGLDisplay exists (see OpenGLMode::create_with_opts - with no
                // $DISPLAY it ignores both and goes straight to the device platform, then the
                // default display). An identical message means the run died before that, so
                // continuing just makes the driver print the same warning again.
                let repeat = failures.last().is_some_and(|(_, prev)| *prev == e);
                failures.push((label.to_string(), e));
                if repeat {
                    break;
                }
            }
        }
    }
    Err(format_failures(&failures))
}

/// Collapse repeated identical failures, and add the environment that decides which display
/// path is even reachable - "failed to create EGLDisplay" plus "no compositor and no X server"
/// is a diagnosis, on its own it is not.
fn format_failures(failures: &[(String, String)]) -> String {
    let mut out = Vec::new();
    let mut i = 0;
    while i < failures.len() {
        let (label, message) = &failures[i];
        let same = failures[i..].iter().take_while(|(_, m)| m == message).count();
        if same > 1 {
            out.push(format!(
                "{message} (identically for {label} and {} other combination(s))",
                same - 1
            ));
        } else {
            out.push(format!("{label}: {message}"));
        }
        i += same;
    }
    let env = |k: &str| {
        std::env::var(k)
            .ok()
            .filter(|v| !v.is_empty())
            .unwrap_or_else(|| "unset".into())
    };
    out.push(format!(
        "environment: DISPLAY={}, WAYLAND_DISPLAY={}, XDG_RUNTIME_DIR={}",
        env("DISPLAY"),
        env("WAYLAND_DISPLAY"),
        env("XDG_RUNTIME_DIR")
    ));
    out.join("; ")
}

fn probe_with(opts: &GpuOptions) -> Result<GlInfo, String> {
    let ctx = init_opengl(opts).map_err(|e| e.to_string())?;
    let info = unsafe {
        let get = |name: u32| -> String {
            let ptr = gl::GetString(name);
            if ptr.is_null() {
                "unknown".to_string()
            } else {
                std::ffi::CStr::from_ptr(ptr as *const std::os::raw::c_char)
                    .to_string_lossy()
                    .into_owned()
            }
        };
        GlInfo {
            vendor: get(gl::VENDOR),
            renderer: get(gl::RENDERER),
            version: get(gl::VERSION),
            glsl_version: get(gl::SHADING_LANGUAGE_VERSION),
        }
    };
    drop(ctx);
    Ok(info)
}

pub fn test_all_opengl(opts: &GpuOptions) -> GLTestResult {
    tests::test_all_gl(opts)
}

// New GUI-related API stubs.
// Provide a thin abstraction so the CLI doesn't need to depend on `winit`.

// The GUI module should be compiled together with the `gpu` feature.

pub mod gui {
    use std::error::Error;
    use std::num::NonZeroU32;

    use glutin::config::{Config, ConfigTemplateBuilder, GetGlConfig};
    use glutin::context::{ContextApi, ContextAttributesBuilder, NotCurrentContext, PossiblyCurrentContext, Version};
    use glutin::display::GetGlDisplay;
    use glutin::prelude::*;
    use glutin::surface::{Surface, SurfaceAttributesBuilder, SwapInterval, WindowSurface};
    use glutin_winit::{DisplayBuilder, GlWindow};
    use raw_window_handle::HasWindowHandle;
    use winit::application::ApplicationHandler;
    use winit::event::WindowEvent;
    use winit::event_loop::{ActiveEventLoop, EventLoop};
    use winit::window::Window;

    #[derive(Debug, Clone)]
    pub struct WindowSpec {
        pub title: Option<String>,
        pub width: u32,
        pub height: u32,
    }

    impl Default for WindowSpec {
        fn default() -> Self {
            Self {
                title: None,
                width: 800,
                height: 600,
            }
        }
    }

    /// Trait for stateful runners that execute frame-by-frame
    pub trait StatefulRunner {
        /// Initialize before first frame
        fn init(&mut self) -> Result<(), Box<dyn Error>>;

        /// Update and render one frame. Returns true to continue, false when complete.
        /// delta_ms is time since last frame
        fn update(&mut self, delta_ms: u64) -> Result<bool, Box<dyn Error>>;

        /// Get final result (run_count, error_count)
        /// `(run, skipped, errors)` - skipped means the driver cannot run the test at all.
        fn get_result(&self) -> (usize, usize, usize);
    }

    /// Opaque runtime handle placeholder
    pub struct GuiRuntimeHandle;

    impl GuiRuntimeHandle {
        /// Create a window with OpenGL context and run the provided closure.
        /// The closure is executed on the event loop thread after OpenGL is initialized.
        pub fn with_window<F, T>(spec: Option<WindowSpec>, f: F) -> Result<T, Box<dyn Error>>
        where
            F: FnOnce() -> Result<T, String> + 'static,
            T: 'static,
        {
            let spec = spec.unwrap_or_default();

            // Create an event loop
            let event_loop = EventLoop::new()?;

            // Prepare display builder with window attributes
            let window_attrs = Window::default_attributes()
                .with_title(spec.title.unwrap_or_else(|| "hodow GL Test".to_string()))
                .with_inner_size(winit::dpi::LogicalSize::new(spec.width, spec.height));

            let template = ConfigTemplateBuilder::new().with_alpha_size(8);

            let display_builder = DisplayBuilder::new().with_window_attributes(Some(window_attrs));

            // Create the app
            let mut app = App::new(template, display_builder, f);

            // Run event loop (blocks until exit)
            event_loop.run_app(&mut app)?;

            // Return the result from the test closure
            app.test_result.unwrap_or_else(|| Err("No test result".into()))
        }

        /// Create a window with OpenGL context and run a stateful runner frame-by-frame.
        /// This makes the window visible during test execution.
        pub fn with_window_stateful<F>(spec: Option<WindowSpec>, f: F) -> Result<(usize, usize, usize), Box<dyn Error>>
        where
            F: FnOnce() -> Box<dyn StatefulRunner> + 'static,
        {
            let spec = spec.unwrap_or_default();

            // Create an event loop
            let event_loop = EventLoop::new()?;

            // Prepare display builder with window attributes
            let window_attrs = Window::default_attributes()
                .with_title(spec.title.unwrap_or_else(|| "hodow GL Test".to_string()))
                .with_inner_size(winit::dpi::LogicalSize::new(spec.width, spec.height));

            let template = ConfigTemplateBuilder::new().with_alpha_size(8);

            let display_builder = DisplayBuilder::new().with_window_attributes(Some(window_attrs));

            // Create the stateful app
            let mut app = StatefulApp::new(template, display_builder, f);

            // Run event loop (blocks until exit)
            event_loop.run_app(&mut app)?;

            // Return the result
            app.result.ok_or_else(|| {
                app.startup_error
                    .take()
                    .unwrap_or_else(|| "the window closed before any test ran".into())
                    .into()
            })
        }
    }

    enum GlDisplayCreationState {
        Builder(Box<DisplayBuilder>),
        Init,
    }

    struct App<F, T>
    where
        F: FnOnce() -> Result<T, String>,
        T: 'static,
    {
        template: ConfigTemplateBuilder,
        gl_display: GlDisplayCreationState,
        gl_context: Option<PossiblyCurrentContext>,
        state: Option<AppState>,
        test_closure: Option<F>,
        test_result: Option<Result<T, Box<dyn Error>>>,
        start_time: Option<std::time::Instant>,
        tests_executed: bool,
    }

    impl<F, T> App<F, T>
    where
        F: FnOnce() -> Result<T, String>,
        T: 'static,
    {
        fn new(template: ConfigTemplateBuilder, display_builder: DisplayBuilder, f: F) -> Self {
            Self {
                template,
                gl_display: GlDisplayCreationState::Builder(Box::new(display_builder)),
                gl_context: None,
                state: None,
                test_closure: Some(f),
                test_result: None,
                start_time: None,
                tests_executed: false,
            }
        }
    }

    impl<F, T> ApplicationHandler for App<F, T>
    where
        F: FnOnce() -> Result<T, String>,
        T: 'static,
    {
        fn resumed(&mut self, event_loop: &ActiveEventLoop) {
            let (window, gl_config) = match &self.gl_display {
                GlDisplayCreationState::Builder(display_builder) => {
                    // First time: create window and pick config
                    let (window, gl_config) =
                        match display_builder
                            .clone()
                            .build(event_loop, self.template.clone(), gl_config_picker)
                        {
                            Ok((Some(window), gl_config)) => (window, gl_config),
                            Ok((None, _)) => {
                                self.test_result = Some(Err("Failed to create window".into()));
                                event_loop.exit();
                                return;
                            }
                            Err(err) => {
                                self.test_result = Some(Err(err));
                                event_loop.exit();
                                return;
                            }
                        };

                    self.gl_display = GlDisplayCreationState::Init;

                    // Create GL context
                    let gl_context = match create_gl_context(&window, &gl_config) {
                        Ok(ctx) => ctx.treat_as_possibly_current(),
                        Err(e) => {
                            self.test_result = Some(Err(e));
                            event_loop.exit();
                            return;
                        }
                    };
                    self.gl_context = Some(gl_context);

                    (window, gl_config)
                }
                GlDisplayCreationState::Init => {
                    // Already have context, just recreate window (e.g., after suspend on Android)
                    // This path is unlikely in practice for desktop tests
                    self.test_result = Some(Err("Context recreation not supported in this implementation".into()));
                    event_loop.exit();
                    return;
                }
            };

            // Create window surface
            let attrs = match window.build_surface_attributes(Default::default()) {
                Ok(a) => a,
                Err(e) => {
                    self.test_result = Some(Err(format!("Failed to build surface attributes: {}", e).into()));
                    event_loop.exit();
                    return;
                }
            };
            let gl_surface = match unsafe { gl_config.display().create_window_surface(&gl_config, &attrs) } {
                Ok(s) => s,
                Err(e) => {
                    self.test_result = Some(Err(format!("Failed to create surface: {}", e).into()));
                    event_loop.exit();
                    return;
                }
            };

            // Make context current
            let gl_context = self.gl_context.as_ref().unwrap();
            if let Err(e) = gl_context.make_current(&gl_surface) {
                self.test_result = Some(Err(e.into()));
                event_loop.exit();
                return;
            }

            // Load OpenGL functions
            if let Err(e) = super::loader::load_gl_functions(&gl_config.display()) {
                self.test_result = Some(Err(e));
                event_loop.exit();
                return;
            }

            // Set vsync
            let _ = gl_surface.set_swap_interval(gl_context, SwapInterval::Wait(NonZeroU32::new(1).unwrap()));

            self.state = Some(AppState { gl_surface, window });

            // Execute tests now that OpenGL is ready
            if !self.tests_executed {
                self.tests_executed = true;
                if let Some(f) = self.test_closure.take() {
                    let result = f().map_err(|e| Box::new(std::io::Error::other(e)) as Box<dyn Error>);
                    self.test_result = Some(result);

                    // Swap buffers to show rendered content
                    if let Some(AppState { gl_surface, .. }) = &self.state {
                        let _ = gl_surface.swap_buffers(gl_context);
                    }

                    // Set start_time AFTER tests complete, so window stays visible for 1s after tests
                    self.start_time = Some(std::time::Instant::now());

                    // Request one more redraw to ensure content is visible
                    if let Some(AppState { window, .. }) = &self.state {
                        window.request_redraw();
                    }
                }
            }
        }

        fn window_event(
            &mut self,
            event_loop: &ActiveEventLoop,
            _window_id: winit::window::WindowId,
            event: WindowEvent,
        ) {
            match event {
                WindowEvent::RedrawRequested => {
                    // Swap buffers on redraw
                    if let (Some(AppState { gl_surface, window }), Some(gl_context)) = (&self.state, &self.gl_context) {
                        let _ = gl_surface.swap_buffers(gl_context);

                        // Check if 2 seconds has elapsed (show results after tests complete)
                        if let Some(start) = self.start_time {
                            if start.elapsed() >= std::time::Duration::from_secs(2) {
                                event_loop.exit();
                            } else {
                                // Keep requesting redraws to keep window responsive
                                window.request_redraw();
                            }
                        }
                    }
                }
                WindowEvent::CloseRequested => {
                    event_loop.exit();
                }
                _ => {}
            }
        }
    }

    struct AppState {
        gl_surface: Surface<WindowSurface>,
        window: Window,
    }

    // Stateful app for frame-by-frame rendering
    struct StatefulApp<F>
    where
        F: FnOnce() -> Box<dyn StatefulRunner>,
    {
        template: ConfigTemplateBuilder,
        gl_display: GlDisplayCreationState,
        gl_context: Option<PossiblyCurrentContext>,
        state: Option<AppState>,
        runner_factory: Option<F>,
        runner: Option<Box<dyn StatefulRunner>>,
        result: Option<(usize, usize, usize)>,
        startup_error: Option<String>,
        last_frame_time: Option<std::time::Instant>,
        show_result_until: Option<std::time::Instant>,
        redraw_requested_at: Option<std::time::Instant>,
        present: PresentStats,
    }

    /// Time the window spends waiting for the display rather than running tests. With vsync on, both
    /// `swap_buffers` and the next `RedrawRequested` wait for the compositor, so a test reporting 0 ms
    /// can still sit minutes between two tests when the compositor stops releasing frames.
    #[derive(Default)]
    struct PresentStats {
        frames: u64,
        swap_total: std::time::Duration,
        swap_worst: std::time::Duration,
        redraw_total: std::time::Duration,
        redraw_worst: std::time::Duration,
    }

    const PRESENT_STALL: std::time::Duration = std::time::Duration::from_millis(250);

    impl PresentStats {
        fn record_swap(&mut self, took: std::time::Duration) {
            self.frames += 1;
            self.swap_total += took;
            self.swap_worst = self.swap_worst.max(took);
            if took >= PRESENT_STALL {
                log::warn!(
                    "[present] swap_buffers blocked for {} ms: the compositor did not release the frame",
                    took.as_millis()
                );
            }
        }

        fn record_redraw(&mut self, took: std::time::Duration) {
            self.redraw_total += took;
            self.redraw_worst = self.redraw_worst.max(took);
            if took >= PRESENT_STALL {
                log::warn!(
                    "[present] the next redraw arrived {} ms after it was requested",
                    took.as_millis()
                );
            }
        }

        fn log_summary(&self) {
            log::info!(
                "[present] {} frames; swap_buffers total {} ms (worst {} ms); waiting for redraw total {} ms (worst {} ms)",
                self.frames,
                self.swap_total.as_millis(),
                self.swap_worst.as_millis(),
                self.redraw_total.as_millis(),
                self.redraw_worst.as_millis()
            );
        }
    }

    impl<F> StatefulApp<F>
    where
        F: FnOnce() -> Box<dyn StatefulRunner>,
    {
        fn new(template: ConfigTemplateBuilder, display_builder: DisplayBuilder, f: F) -> Self {
            Self {
                template,
                gl_display: GlDisplayCreationState::Builder(Box::new(display_builder)),
                gl_context: None,
                state: None,
                runner_factory: Some(f),
                runner: None,
                result: None,
                startup_error: None,
                last_frame_time: None,
                show_result_until: None,
                redraw_requested_at: None,
                present: PresentStats::default(),
            }
        }
    }

    impl<F> ApplicationHandler for StatefulApp<F>
    where
        F: FnOnce() -> Box<dyn StatefulRunner>,
    {
        fn resumed(&mut self, event_loop: &ActiveEventLoop) {
            let (window, gl_config) = match &self.gl_display {
                GlDisplayCreationState::Builder(display_builder) => {
                    let (window, gl_config) =
                        match display_builder
                            .clone()
                            .build(event_loop, self.template.clone(), gl_config_picker)
                        {
                            Ok((Some(window), gl_config)) => (window, gl_config),
                            Ok((None, _)) => {
                                self.startup_error = Some("the window was not created".into());
                                event_loop.exit();
                                return;
                            }
                            Err(e) => {
                                self.startup_error = Some(format!("window/GL config: {e}"));
                                event_loop.exit();
                                return;
                            }
                        };

                    self.gl_display = GlDisplayCreationState::Init;

                    let gl_context = match create_gl_context(&window, &gl_config) {
                        Ok(ctx) => ctx.treat_as_possibly_current(),
                        Err(e) => {
                            self.startup_error = Some(format!("GL context: {e}"));
                            event_loop.exit();
                            return;
                        }
                    };
                    self.gl_context = Some(gl_context);

                    (window, gl_config)
                }
                GlDisplayCreationState::Init => {
                    event_loop.exit();
                    return;
                }
            };

            let attrs = match window.build_surface_attributes(Default::default()) {
                Ok(a) => a,
                Err(e) => {
                    self.startup_error = Some(format!("surface attributes: {e}"));
                    event_loop.exit();
                    return;
                }
            };
            let gl_surface = match unsafe { gl_config.display().create_window_surface(&gl_config, &attrs) } {
                Ok(s) => s,
                Err(e) => {
                    self.startup_error = Some(format!("window surface: {e}"));
                    event_loop.exit();
                    return;
                }
            };

            let gl_context = self.gl_context.as_ref().unwrap();
            if let Err(e) = gl_context.make_current(&gl_surface) {
                self.startup_error = Some(format!("make_current: {e}"));
                event_loop.exit();
                return;
            }

            if let Err(e) = super::loader::load_gl_functions(&gl_config.display()) {
                self.startup_error = Some(format!("loading GL functions: {e}"));
                event_loop.exit();
                return;
            }

            let _ = gl_surface.set_swap_interval(gl_context, SwapInterval::Wait(NonZeroU32::new(1).unwrap()));

            self.state = Some(AppState { gl_surface, window });

            // Initialize runner
            if self.runner.is_none()
                && let Some(factory) = self.runner_factory.take()
            {
                let mut runner = factory();
                if let Err(e) = runner.init() {
                    self.startup_error = Some(format!("runner init: {e}"));
                    event_loop.exit();
                    return;
                }
                self.runner = Some(runner);
                self.last_frame_time = Some(std::time::Instant::now());
            }

            // Request first frame
            if let Some(AppState { window, .. }) = &self.state {
                window.request_redraw();
            }
        }

        fn window_event(
            &mut self,
            event_loop: &ActiveEventLoop,
            _window_id: winit::window::WindowId,
            event: WindowEvent,
        ) {
            match event {
                WindowEvent::RedrawRequested => {
                    if let (Some(AppState { gl_surface, window }), Some(gl_context)) = (&self.state, &self.gl_context) {
                        // Check if showing result
                        if let Some(show_until) = self.show_result_until {
                            if std::time::Instant::now() >= show_until {
                                event_loop.exit();
                                return;
                            }
                            let _ = gl_surface.swap_buffers(gl_context);
                            window.request_redraw();
                            return;
                        }

                        if let Some(requested) = self.redraw_requested_at.take() {
                            self.present.record_redraw(requested.elapsed());
                        }

                        // Run one frame of tests
                        if let Some(runner) = &mut self.runner {
                            let delta_ms = self
                                .last_frame_time
                                .map(|t| t.elapsed().as_millis() as u64)
                                .unwrap_or(0);
                            self.last_frame_time = Some(std::time::Instant::now());

                            match runner.update(delta_ms) {
                                Ok(true) => {
                                    // Continue - swap buffers and request next frame
                                    let swap_started = std::time::Instant::now();
                                    let _ = gl_surface.swap_buffers(gl_context);
                                    self.present.record_swap(swap_started.elapsed());
                                    window.request_redraw();
                                    self.redraw_requested_at = Some(std::time::Instant::now());
                                }
                                Ok(false) => {
                                    // Tests complete - show result for 1 second
                                    let _ = gl_surface.swap_buffers(gl_context);
                                    self.present.log_summary();
                                    self.result = Some(runner.get_result());
                                    self.show_result_until =
                                        Some(std::time::Instant::now() + std::time::Duration::from_secs(1));
                                    window.request_redraw();
                                }
                                Err(_) => {
                                    // Error - exit immediately
                                    event_loop.exit();
                                }
                            }
                        }
                    }
                }
                WindowEvent::CloseRequested => {
                    event_loop.exit();
                }
                _ => {}
            }
        }
    }

    fn gl_config_picker(configs: Box<dyn Iterator<Item = Config> + '_>) -> Config {
        configs
            .reduce(|accum, config| {
                if config.num_samples() > accum.num_samples() {
                    config
                } else {
                    accum
                }
            })
            .expect("No GL configs available")
    }

    fn create_gl_context(window: &Window, gl_config: &Config) -> Result<NotCurrentContext, Box<dyn Error>> {
        let raw_window_handle = window.window_handle().ok().map(|wh| wh.as_raw());

        let context_attributes = ContextAttributesBuilder::new().build(raw_window_handle);

        let fallback_context_attributes = ContextAttributesBuilder::new()
            .with_context_api(ContextApi::Gles(None))
            .build(raw_window_handle);

        let legacy_context_attributes = ContextAttributesBuilder::new()
            .with_context_api(ContextApi::OpenGl(Some(Version::new(2, 1))))
            .build(raw_window_handle);

        let gl_display = gl_config.display();

        unsafe {
            gl_display
                .create_context(gl_config, &context_attributes)
                .or_else(|_| gl_display.create_context(gl_config, &fallback_context_attributes))
                .or_else(|_| gl_display.create_context(gl_config, &legacy_context_attributes))
                .map_err(|e| e.into())
        }
    }
}

#[cfg(not(feature = "gpu"))]
pub mod gui {
    use std::error::Error;

    #[derive(Debug, Clone)]
    pub enum GuiBackend {}

    #[derive(Debug, Clone)]
    pub struct WindowSpec {
        pub title: Option<String>,
        pub width: u32,
        pub height: u32,
    }

    /// When compiled without `gpu` feature, these functions return errors.
    pub fn init_gui_runtime(_backend: GuiBackend) -> Result<(), Box<dyn Error>> {
        Err("Compiled without `gpu` feature".into())
    }

    pub fn create_window_for_test<T>(
        _runtime: &T,
        _test_name: &str,
        _spec: Option<WindowSpec>,
    ) -> Result<u64, Box<dyn Error>> {
        Err("Compiled without `gpu` feature".into())
    }

    pub fn close_window<T>(_runtime: &T, _id: u64) -> Result<(), Box<dyn Error>> {
        Err("Compiled without `gpu` feature".into())
    }
}

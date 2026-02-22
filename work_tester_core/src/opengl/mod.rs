//! OpenGL helper module for GPU testing.
use log::info;

mod context;

mod loader;

mod test_trait;

pub mod tests;

// Export real implementations (no feature gating inside this module)
pub use context::OpenGLMode;

pub use loader::init_gl;

pub use test_trait::{GLTest, GLVersion, GLTestResult};

pub fn init_opengl() -> Result<OpenGLMode, Box<dyn std::error::Error>> {
    let ctx = OpenGLMode::create().map_err(|e| Box::new(e) as Box<dyn std::error::Error>)?;
    info!("Created OpenGL context");
    init_gl(&ctx)?;
    info!("Initialized OpenGL function pointers");
    Ok(ctx)
}

pub fn available_opengl_modes() -> Vec<String> {
    vec!["default-headless".to_string()]
}

pub fn test_all_opengl() -> GLTestResult {
    tests::test_all_gl()
}

// New GUI-related API stubs.
// Provide a thin abstraction so the CLI doesn't need to depend on `winit`.

// The GUI module should be compiled together with the `gpu` feature.
#[cfg(feature = "gpu")]
pub mod gui {
    use std::error::Error;
    use std::num::NonZeroU32;

    use raw_window_handle::HasWindowHandle;
    use winit::application::ApplicationHandler;
    use winit::event::WindowEvent;
    use winit::event_loop::{EventLoop, ActiveEventLoop};
    use winit::window::Window;

    use glutin::config::{Config, ConfigTemplateBuilder, GetGlConfig};
    use glutin::context::{ContextApi, ContextAttributesBuilder, PossiblyCurrentContext, Version, NotCurrentContext};
    use glutin::display::GetGlDisplay;
    use glutin::prelude::*;
    use glutin::surface::{Surface, WindowSurface, SurfaceAttributesBuilder, SwapInterval};

    use glutin_winit::{DisplayBuilder, GlWindow};

    #[derive(Debug, Clone)]
    pub struct WindowSpec {
        pub title: Option<String>,
        pub width: u32,
        pub height: u32,
    }

    impl Default for WindowSpec {
        fn default() -> Self {
            Self { title: None, width: 800, height: 600 }
        }
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
                .with_title(spec.title.unwrap_or_else(|| "work_tester GL Test".to_string()))
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
                    let (window, gl_config) = match display_builder.clone().build(
                        event_loop,
                        self.template.clone(),
                        gl_config_picker,
                    ) {
                        Ok((Some(window), gl_config)) => (window, gl_config),
                        Ok((None, _)) => {
                            self.test_result = Some(Err("Failed to create window".into()));
                            event_loop.exit();
                            return;
                        }
                        Err(err) => {
                            self.test_result = Some(Err(err.into()));
                            event_loop.exit();
                            return;
                        }
                    };

                    self.gl_display = GlDisplayCreationState::Init;

                    // Create GL context
                    let gl_context = match create_gl_context(&window, &gl_config) {
                        Ok(ctx) => ctx.treat_as_possibly_current(),
                        Err(e) => {
                            self.test_result = Some(Err(e.into()));
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
            let gl_surface = match unsafe {
                gl_config.display().create_window_surface(&gl_config, &attrs)
            } {
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
            let _ = gl_surface.set_swap_interval(
                gl_context,
                SwapInterval::Wait(NonZeroU32::new(1).unwrap()),
            );

            self.state = Some(AppState { gl_surface, window });
            self.start_time = Some(std::time::Instant::now());

            // Execute tests now that OpenGL is ready
            if !self.tests_executed {
                self.tests_executed = true;
                if let Some(f) = self.test_closure.take() {
                    let result = f().map_err(|e| Box::new(std::io::Error::new(std::io::ErrorKind::Other, e)) as Box<dyn Error>);
                    self.test_result = Some(result);

                    // Swap buffers to show rendered content
                    if let Some(AppState { gl_surface, .. }) = &self.state {
                        let _ = gl_surface.swap_buffers(gl_context);
                    }

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
                    if let (Some(AppState { gl_surface, .. }), Some(gl_context)) =
                        (&self.state, &self.gl_context)
                    {
                        let _ = gl_surface.swap_buffers(gl_context);
                    }

                    // Check if 1 second has elapsed
                    if let Some(start) = self.start_time {
                        if start.elapsed() >= std::time::Duration::from_secs(1) {
                            event_loop.exit();
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

    fn create_gl_context(
        window: &Window,
        gl_config: &Config,
    ) -> Result<NotCurrentContext, Box<dyn Error>> {
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
    pub enum GuiBackend { }

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

    pub fn create_window_for_test<T>(_runtime: &T, _test_name: &str, _spec: Option<WindowSpec>) -> Result<u64, Box<dyn Error>> {
        Err("Compiled without `gpu` feature".into())
    }

    pub fn close_window<T>(_runtime: &T, _id: u64) -> Result<(), Box<dyn Error>> {
        Err("Compiled without `gpu` feature".into())
    }
}

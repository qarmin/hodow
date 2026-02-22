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
    use std::sync::mpsc::channel;
    use std::thread;

    use winit::application::ApplicationHandler;
    use winit::event::WindowEvent;
    use winit::event_loop::EventLoop;
    use winit::event_loop::ActiveEventLoop;
    use winit::window::WindowAttributes;

    #[derive(Debug, Clone)]
    pub enum GuiBackend {
        Winit,
    }

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

    /// Opaque runtime handle placeholder — per-test windows don't need a persistent handle.
    pub struct GuiRuntimeHandle;

    impl GuiRuntimeHandle {
        /// Create a window and run the provided closure while the event loop keeps the window alive.
        /// The closure runs on a worker thread; the event loop runs on the current thread.
        pub fn with_window<F, T>(spec: Option<WindowSpec>, f: F) -> Result<T, Box<dyn Error>>
        where
            F: FnOnce() -> Result<T, String> + Send + 'static,
            T: Send + 'static,
        {
            let spec = spec.unwrap_or_default();

            // Create an event loop for this test and run it on the current thread.
            // Use EventLoop::new() which returns a Result in this vendored winit.
            let event_loop = EventLoop::new()?;

            // channel to receive result from worker
            let (res_tx, res_rx) = channel();

            // spawn worker that runs the test closure; it will send result and wake the event loop
            let proxy = event_loop.create_proxy();
            thread::spawn(move || {
                let r = f();
                let _ = res_tx.send(r);
                // wake the event loop so it can exit
                proxy.wake_up();
            });

            // Application handler that creates a window and exits when proxy_wake_up is called
            struct App {
                title: String,
            }

            impl ApplicationHandler for App {
                fn can_create_surfaces(&mut self, event_loop: &dyn ActiveEventLoop) {
                    let mut attrs = WindowAttributes::default();
                    attrs = attrs.with_title(self.title.clone());
                    // request a surface/window; ignore errors but exit the loop if creation fails
                    if let Err(e) = event_loop.create_window(attrs) {
                        eprintln!("Failed to create window: {:?}", e);
                        event_loop.exit();
                    }
                }

                fn proxy_wake_up(&mut self, event_loop: &dyn ActiveEventLoop) {
                    // worker finished; exit the event loop so run_app returns
                    event_loop.exit();
                }

                fn window_event(&mut self, _event_loop: &dyn ActiveEventLoop, _window_id: winit::window::WindowId, _event: WindowEvent) {
                    // no-op for now
                }
            }

            // run the event loop; when proxy_wake_up is called it will exit
            let app = App { title: spec.title.unwrap_or_else(|| "work_tester window".to_string()) };
            let _ = event_loop.run_app(app);

            // after event loop returns, collect result
            match res_rx.recv() {
                Ok(Ok(v)) => Ok(v),
                Ok(Err(e)) => Err(Box::new(std::io::Error::new(std::io::ErrorKind::Other, e))),
                Err(e) => Err(Box::new(e)),
            }
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

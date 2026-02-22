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

    /// Opaque handle to GUI runtime (manages event loop and windows).
    pub struct GuiRuntimeHandle {
        // internal details hidden
    }

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

    /// Initialize GUI runtime for the selected backend.
    pub fn init_gui_runtime(_backend: GuiBackend) -> Result<GuiRuntimeHandle, Box<dyn Error>> {
        // real implementation lives behind `gpu` feature in a dedicated module
        Ok(GuiRuntimeHandle {})
    }

    /// Create a window for a given test; returns an opaque window id.
    pub fn create_window_for_test(_runtime: &GuiRuntimeHandle, _test_name: &str, _spec: Option<WindowSpec>) -> Result<u64, Box<dyn Error>> {
        // stub implementation; real code will create a winit window
        Ok(1)
    }

    pub fn close_window(_runtime: &GuiRuntimeHandle, _id: u64) -> Result<(), Box<dyn Error>> {
        Ok(())
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

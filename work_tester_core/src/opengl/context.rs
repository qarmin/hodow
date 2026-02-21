#![cfg(feature = "gpu")]

use std::error::Error;
use std::sync::Arc;

use glutin::context::{ContextApi, PossiblyCurrentContext, ContextAttributesBuilder};
use glutin::display::{Display, DisplayApiPreference};
use glutin::prelude::*;
use glutin::config::ConfigTemplateBuilder;
use raw_window_handle::{RawDisplayHandle, HasRawDisplayHandle};

/// Simple wrapper around a headless OpenGL context or similar.
pub struct OpenGLMode {
    pub(crate) inner: Arc<PossiblyCurrentContext>,
    pub(crate) display: Display,
}

/// Minimal RawDisplayHandle implementation for headless
struct HeadlessDisplay;

unsafe impl HasRawDisplayHandle for HeadlessDisplay {
    fn raw_display_handle(&self) -> RawDisplayHandle {
        #[cfg(target_os = "linux")]
        {
            use raw_window_handle::WaylandDisplayHandle;
            RawDisplayHandle::Wayland(WaylandDisplayHandle::empty())
        }
        #[cfg(not(target_os = "linux"))]
        {
            panic!("Headless OpenGL is not supported on this platform");
        }
    }
}

impl OpenGLMode {
    /// Create a headless OpenGL context. This tries to create a minimal context
    /// that won't show any window. On platforms where headless contexts are
    /// not available, this may still create an offscreen context.
    pub fn create() -> Result<Self, Box<dyn Error>> {
        let headless = HeadlessDisplay;
        let preference = DisplayApiPreference::Egl;
        let display = unsafe {
            Display::new(headless.raw_display_handle(), preference)?
        };

        let template = ConfigTemplateBuilder::new().build();
        let config = unsafe {
            display
                .find_configs(template)?
                .next()
                .ok_or("No GL config")?
        };

        let context_attributes = ContextAttributesBuilder::new().build(None);

        let not_current = unsafe { display.create_context(&config, &context_attributes)? };

        let possibly_current = unsafe { not_current.treat_as_possibly_current() };

        Ok(OpenGLMode {
            inner: Arc::new(possibly_current),
            display,
        })
    }

    /// Get reference to the display for function loading
    pub fn display(&self) -> &Display {
        &self.display
    }
}

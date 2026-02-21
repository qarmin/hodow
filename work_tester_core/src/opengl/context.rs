#![cfg(feature = "gpu")]

use std::error::Error;
use std::sync::Arc;

use glutin::context::{ContextApi, PossiblyCurrentContext, ContextAttributesBuilder};
use glutin::display::{Display, DisplayApiPreference};
use glutin::prelude::*;
use glutin::config::ConfigTemplateBuilder;
use raw_window_handle::{RawDisplayHandle, HasDisplayHandle, DisplayHandle, HandleError, WaylandDisplayHandle};
use std::ptr::NonNull;
use std::ffi::c_void;
use std::fmt;
use std::error::Error as StdError;

/// Simple wrapper around a headless OpenGL context or similar.
pub struct OpenGLMode {
    pub(crate) inner: Arc<PossiblyCurrentContext>,
    pub(crate) display: Display,
}

/// Error type for OpenGL context creation/initialization
#[derive(Debug)]
pub enum OpenGlError {
    Handle(HandleError),
    Glutin(String),
    Other(Box<dyn StdError + Send + Sync + 'static>),
}

impl fmt::Display for OpenGlError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            OpenGlError::Handle(h) => write!(f, "Handle error: {}", h),
            OpenGlError::Glutin(s) => write!(f, "Glutin error: {}", s),
            OpenGlError::Other(e) => write!(f, "{}", e),
        }
    }
}

impl StdError for OpenGlError {
    fn source(&self) -> Option<&(dyn StdError + 'static)> {
        match self {
            OpenGlError::Handle(_) => None,
            OpenGlError::Glutin(_) => None,
            OpenGlError::Other(e) => Some(&**e),
        }
    }
}

impl From<HandleError> for OpenGlError {
    fn from(h: HandleError) -> Self {
        OpenGlError::Handle(h)
    }
}

impl OpenGLMode {
    /// Create a headless OpenGL context. This tries to create a minimal context
    /// that won't show any window. On platforms where headless contexts are
    /// not available, this may still create an offscreen context.
    pub fn create() -> Result<Self, OpenGlError> {
        let headless = HeadlessDisplay;
        let preference = DisplayApiPreference::Egl;
        let display = unsafe {
            // get DisplayHandle then obtain RawDisplayHandle
            let dh = headless.display_handle().map_err(OpenGlError::from)?;
            let raw = dh.as_raw();
            Display::new(raw, preference).map_err(|e| OpenGlError::Other(Box::new(e)))?
        };

        let template = ConfigTemplateBuilder::new().build();
        let config = unsafe {
            display
                .find_configs(template).map_err(|e| OpenGlError::Other(Box::new(e)))?
                .next()
                .ok_or_else(|| OpenGlError::Glutin("No GL config".to_string()))?
        };

        let context_attributes = ContextAttributesBuilder::new().build(None);

        let not_current = unsafe { display.create_context(&config, &context_attributes)
            .map_err(|e| OpenGlError::Other(Box::new(e)))? };

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

struct HeadlessDisplay;

impl HasDisplayHandle for HeadlessDisplay {
    fn display_handle(&self) -> Result<DisplayHandle<'_>, HandleError> {
        #[cfg(target_os = "linux")]
        {
            let ptr: NonNull<c_void> = NonNull::dangling();
            let raw = RawDisplayHandle::Wayland(WaylandDisplayHandle::new(ptr));
            // Safety: creating a DisplayHandle from a RawDisplayHandle is ok here
            // because we only use it briefly and it's a platform-specific placeholder.
            unsafe { Ok(DisplayHandle::borrow_raw(raw)) }
        }
        #[cfg(not(target_os = "linux"))]
        {
            Err(HandleError::NotSupported)
        }
    }
}

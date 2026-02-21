#![cfg(feature = "gpu")]

use std::error::Error;
use std::sync::Arc;
use std::num::NonZeroU32;

use glutin::context::{ContextApi, PossiblyCurrentContext, ContextAttributesBuilder};
use glutin::display::{Display, DisplayApiPreference};
use glutin::prelude::*;
use glutin::config::ConfigTemplateBuilder;
use glutin::surface::{SurfaceAttributesBuilder, PbufferSurface};
use raw_window_handle::{RawDisplayHandle, HasDisplayHandle, DisplayHandle, HandleError, XlibDisplayHandle};
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

        // Try to create a native GL context; if that fails, fall back to GLES.
        let fallback_context_attributes = ContextAttributesBuilder::new()
            .with_context_api(ContextApi::Gles(None))
            .build(None);

        let not_current = unsafe {
            match display.create_context(&config, &context_attributes) {
                Ok(ctx) => ctx,
                Err(_) => display
                    .create_context(&config, &fallback_context_attributes)
                    .map_err(|e| OpenGlError::Other(Box::new(e)))?,
            }
        };

        // Create a small pbuffer surface and make the context current on it.
        let pbuffer = {
            // build a 128x128 pbuffer surface
            let attrs = SurfaceAttributesBuilder::<PbufferSurface>::new()
                .with_largest_pbuffer(false)
                .build(
                    NonZeroU32::new(128).expect("valid pbuffer width"),
                    NonZeroU32::new(128).expect("valid pbuffer height"),
                );

            unsafe {
                display
                    .create_pbuffer_surface(&config, &attrs)
                    .map_err(|e| OpenGlError::Other(Box::new(e)))?
            }
        };

        // Make the context current on the created pbuffer surface.
        let possibly_current = unsafe {
            not_current
                .make_current(&pbuffer)
                .map_err(|e| OpenGlError::Other(Box::new(e)))?
        };

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
            // Request default X11 display (None) which EGL may accept for
            // headless/offscreen contexts. This avoids constructing a
            // WaylandDisplayHandle with a dangling pointer which can cause
            // crashes in libwayland/libEGL when the display pointer is used.
            let raw = RawDisplayHandle::Xlib(XlibDisplayHandle::new(None, 0));
            unsafe { Ok(DisplayHandle::borrow_raw(raw)) }
        }
        #[cfg(not(target_os = "linux"))]
        {
            Err(HandleError::NotSupported)
        }
    }
}

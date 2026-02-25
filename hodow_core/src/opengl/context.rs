use std::error::Error as StdError;
use std::ffi::c_void;
use std::fmt;
use std::num::NonZeroU32;
use std::ptr::NonNull;
use std::sync::Arc;

use glutin::config::ConfigTemplateBuilder;
use glutin::context::{ContextApi, ContextAttributesBuilder, PossiblyCurrentContext, Version};
use glutin::display::{Display, DisplayApiPreference};
use glutin::prelude::*;
use glutin::surface::{PbufferSurface, SurfaceAttributesBuilder};
use raw_window_handle::{DisplayHandle, HandleError, HasDisplayHandle, RawDisplayHandle, XlibDisplayHandle};

use crate::opengl::{DisplayApiHint, GlApiHint, GpuOptions};

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
    /// Create a headless OpenGL context using default options.
    pub fn create() -> Result<Self, OpenGlError> {
        Self::create_with_opts(&GpuOptions::default())
    }

    /// Create a headless OpenGL context with the given [`GpuOptions`].
    ///
    /// * `opts.display_api` controls which backend (EGL / GLX / …) to use.
    /// * `opts.gl_api`      controls the API flavour (OpenGL / GLES) and
    ///                      optional version.
    pub fn create_with_opts(opts: &GpuOptions) -> Result<Self, OpenGlError> {
        let headless = HeadlessDisplay;

        // ── choose DisplayApiPreference ───────────────────────────────────
        #[cfg(target_os = "linux")]
        let preference = {
            use glutin::display::DisplayApiPreference;
            // GLX variants need an error-hook registrar; provide a no-op one.
            // XlibErrorHookRegistrar = Box<dyn Fn(Box<dyn Fn(*mut c_void, *mut c_void) -> bool + Send + Sync>)>
            let noop_registrar = || -> Box<dyn Fn(Box<dyn Fn(*mut c_void, *mut c_void) -> bool + Send + Sync>)> {
                Box::new(|_hook| {})
            };
            match opts.display_api {
                DisplayApiHint::Egl => DisplayApiPreference::Egl,
                DisplayApiHint::Glx => DisplayApiPreference::Glx(noop_registrar()),
                DisplayApiHint::EglThenGlx => DisplayApiPreference::EglThenGlx(noop_registrar()),
                DisplayApiHint::GlxThenEgl => DisplayApiPreference::GlxThenEgl(noop_registrar()),
            }
        };
        #[cfg(not(target_os = "linux"))]
        let preference = DisplayApiPreference::Egl;

        let display = unsafe {
            let dh = headless.display_handle().map_err(OpenGlError::from)?;
            let raw = dh.as_raw();
            Display::new(raw, preference).map_err(|e| OpenGlError::Other(Box::new(e)))?
        };

        let template = ConfigTemplateBuilder::new().build();
        let config = unsafe {
            display
                .find_configs(template)
                .map_err(|e| OpenGlError::Other(Box::new(e)))?
                .next()
                .ok_or_else(|| OpenGlError::Glutin("No GL config".to_string()))?
        };

        // ── build ContextAttributes according to GlApiHint ───────────────
        fn make_attrs(hint: GlApiHint) -> glutin::context::ContextAttributes {
            match hint {
                GlApiHint::Auto => ContextAttributesBuilder::new().build(None),
                GlApiHint::OpenGl { major: 0, minor: 0 } => {
                    ContextAttributesBuilder::new().with_context_api(ContextApi::OpenGl(None)).build(None)
                }
                GlApiHint::OpenGl { major, minor } => ContextAttributesBuilder::new()
                    .with_context_api(ContextApi::OpenGl(Some(Version::new(major, minor))))
                    .build(None),
                GlApiHint::Gles { major: 0, minor: 0 } => {
                    ContextAttributesBuilder::new().with_context_api(ContextApi::Gles(None)).build(None)
                }
                GlApiHint::Gles { major, minor } => ContextAttributesBuilder::new()
                    .with_context_api(ContextApi::Gles(Some(Version::new(major, minor))))
                    .build(None),
            }
        }

        let context_attributes = make_attrs(opts.gl_api);

        // Fallback: if the user asked for OpenGL desktop, try GLES next, and vice-versa.
        let fallback_attributes = match opts.gl_api {
            GlApiHint::Gles { .. } => ContextAttributesBuilder::new().with_context_api(ContextApi::OpenGl(None)).build(None),
            _ => ContextAttributesBuilder::new().with_context_api(ContextApi::Gles(None)).build(None),
        };

        let not_current = unsafe {
            match display.create_context(&config, &context_attributes) {
                Ok(ctx) => ctx,
                Err(_) => display.create_context(&config, &fallback_attributes).map_err(|e| OpenGlError::Other(Box::new(e)))?,
            }
        };

        // Create a small pbuffer surface and make the context current on it.
        let pbuffer = {
            let attrs = SurfaceAttributesBuilder::<PbufferSurface>::new()
                .with_largest_pbuffer(false)
                .build(NonZeroU32::new(128).expect("valid pbuffer width"), NonZeroU32::new(128).expect("valid pbuffer height"));
            unsafe { display.create_pbuffer_surface(&config, &attrs).map_err(|e| OpenGlError::Other(Box::new(e)))? }
        };

        let possibly_current = not_current.make_current(&pbuffer).map_err(|e| OpenGlError::Other(Box::new(e)))?;

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
            let raw = RawDisplayHandle::Xlib(XlibDisplayHandle::new(None, 0));
            unsafe { Ok(DisplayHandle::borrow_raw(raw)) }
        }
        #[cfg(not(target_os = "linux"))]
        {
            Err(HandleError::NotSupported)
        }
    }
}

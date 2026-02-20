#![cfg(feature = "gpu")]

use std::error::Error;
use std::sync::Arc;

use glutin::context::{ContextApi, PossiblyCurrentContext, ContextAttributesBuilder, NotCurrentContext};
use glutin::display::{Display, DisplayApiPreference};
use glutin::prelude::*;
use glutin::surface::{Surface, SurfaceAttributesBuilder, WindowSurface};
use glutin::config::{ConfigTemplateBuilder};

/// Simple wrapper around a headless OpenGL context or similar.
pub struct OpenGLMode {
    // For simplicity we only store the display/context as an opaque box.
    // Expand this struct to hold the loader and surfaces as needed.
    pub(crate) inner: Arc<PossiblyCurrentContext>,
}

impl OpenGLMode {
    /// Create a headless OpenGL context. This tries to create a minimal context
    /// that won't show any window. On platforms where headless contexts are
    /// not available, this may still create an offscreen context.
    pub fn create() -> Result<Self, Box<dyn Error>> {
        // Use the simplest display selection.
        let preference = DisplayApiPreference::EglThenGlx(Box::new(()));
        let display = unsafe { Display::new(preference)? };

        let template = ConfigTemplateBuilder::new();
        let config = display.find_configs(template.build())?.next().ok_or("No GL config")?;

        // Build context attributes; request a core profile.
        let context_attributes = ContextAttributesBuilder::new().with_context_api(ContextApi::Gles(Some((3, 0)))).build(Some(Default::default()));

        let not_current = unsafe { display.create_context(&config, &context_attributes)? };
        let possibly_current = unsafe { not_current.make_current().map_err(|(_not_current, e)| e)? };

        Ok(OpenGLMode { inner: Arc::new(possibly_current) })
    }
}


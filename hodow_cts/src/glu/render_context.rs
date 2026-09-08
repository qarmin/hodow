// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluRenderContext.hpp / .cpp  (glu::RenderContext, glu::ContextType)
//   framework/egl/egluGLContextFactory.cpp        (context creation)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::eglu::{self, Display};
use crate::eglw::{self, EGLContext, EGLSurface, Library, LoadError};
use crate::glu::GlslVersion;
use crate::glw;
use crate::tcu::PixelFormat;

/// The render target size every case gets when there is no window.
///
/// Upstream's default is 256x256 (`--deqp-surface-width/height`), and several tests
/// compare against a reference rendered at whatever size they are given, so this being
/// the same number as upstream's default is what keeps verdicts comparable.
pub const DEFAULT_SURFACE_SIZE: i32 = 256;

/// `glu::ApiType` - narrowed to the ES profiles, which is what this suite covers.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub struct ApiType {
    pub major: i32,
    pub minor: i32,
}

impl ApiType {
    /// `glu::ApiType::es`
    pub const fn es(major: i32, minor: i32) -> Self {
        Self { major, minor }
    }

    /// The `EGL_RENDERABLE_TYPE` bit a config must have to hold this context.
    fn renderable_type(self) -> u32 {
        if self.major >= 3 { eglw::EGL_OPENGL_ES3_BIT } else { eglw::EGL_OPENGL_ES2_BIT }
    }
}

/// `glu::ContextType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub struct ContextType {
    pub api: ApiType,
}

impl ContextType {
    /// `glu::getContextTypeGLSLVersion`
    pub fn glsl_version(self) -> GlslVersion {
        match (self.api.major, self.api.minor) {
            (3, 0) => GlslVersion::Es300,
            (3, 1) => GlslVersion::Es310,
            (3, minor) if minor >= 2 => GlslVersion::Es320,
            (major, _) if major >= 4 => GlslVersion::Es320,
            _ => GlslVersion::Es100,
        }
    }

    /// Whether the context is at least this ES version, i.e. upstream's
    /// `contextSupports(type, ApiType::es(major, minor))`.
    pub fn supports(self, major: i32, minor: i32) -> bool {
        (self.api.major, self.api.minor) >= (major, minor)
    }
}

/// `tcu::RenderTarget` - what the default framebuffer looks like.
#[derive(Clone, Copy, Debug)]
pub struct RenderTarget {
    pub width: i32,
    pub height: i32,
    pub red_bits: i32,
    pub green_bits: i32,
    pub blue_bits: i32,
    pub alpha_bits: i32,
    pub depth_bits: i32,
    pub stencil_bits: i32,
    pub num_samples: i32,
}

impl RenderTarget {
    /// `tcu::RenderTarget::getPixelFormat`
    pub fn pixel_format(&self) -> PixelFormat {
        PixelFormat::new(self.red_bits, self.green_bits, self.blue_bits, self.alpha_bits)
    }
}

/// `glu::RenderContext` - a current ES context and the entry points to drive it.
///
/// Field order is the drop order and is load-bearing: the context and the surface are
/// destroyed by `Drop` below, then the display is terminated, and only then is libEGL
/// unloaded. Unloading first would tear the driver out from under its own objects.
pub struct RenderContext {
    context: EGLContext,
    surface: EGLSurface,
    gl: glw::Functions,
    context_type: ContextType,
    render_target: RenderTarget,
    display: Display,
    library: Library,
}

impl RenderContext {
    /// Brings a headless ES context up at exactly the version asked for.
    ///
    /// Exactly, not "at least": each upstream module asks for its own version
    /// (`deqp-gles2` for ES 2.0, `deqp-gles31` for ES 3.1) and reports that version
    /// from `glu::RenderContext::getType()`, which decides both the `#version` line of
    /// every generated shader and - for the negative-API groups - what counts as an
    /// error at all. Several ES 2.0 calls that must fail on an ES 2.0 context are
    /// perfectly legal on an ES 3.0 one, so running the ES 2.0 cases on a newer
    /// context would disagree with upstream on cases that are not broken.
    ///
    /// `device_index` is `--device-id`, 1-based; it only has an effect on the EGL
    /// device platform, which is the one platform that enumerates GPUs.
    ///
    /// A pbuffer is used as the render target rather than an FBO: it needs no window
    /// system, it is one of the surface types upstream itself supports
    /// (`--deqp-surface-type=pbuffer`), and it gives the default framebuffer a real
    /// size, which several groups read straight out of `tcu::RenderTarget`. A driver
    /// that has `EGL_KHR_surfaceless_context` but no pbuffer config still gets a
    /// context, with a 0x0 target - fine for compute, and any case that needs pixels
    /// will say so rather than silently comparing against nothing.
    pub fn create(api: ApiType, device_index: usize) -> Result<Self, LoadError> {
        let library = Library::open()?;
        let display = eglu::open_display(&library, device_index)?;
        let egl = &library.egl;

        // SAFETY: every call below goes through an entry point this library loaded,
        // with a display it returned; the arguments are checked by EGL itself and
        // every failure is handled rather than ignored.
        unsafe {
            if egl.bind_api(eglw::EGL_OPENGL_ES_API) != eglw::EGL_TRUE {
                return Err(LoadError(format!("eglBindAPI(EGL_OPENGL_ES_API) failed: {}", eglu::last_error(egl))));
            }

            let (config, surface) = match eglu::choose_config(egl, display.handle(), true, api.renderable_type())
                .and_then(|config| eglu::create_pbuffer_surface(egl, display.handle(), config, DEFAULT_SURFACE_SIZE, DEFAULT_SURFACE_SIZE).map(|s| (config, s)))
            {
                Some((config, surface)) => (config, surface),
                None => {
                    // No pbuffer. A surfaceless context is the only way left, and only
                    // if the driver says it has one.
                    if !display.extensions.contains("EGL_KHR_surfaceless_context") {
                        return Err(LoadError(format!(
                            "no pbuffer config on the {} platform and no EGL_KHR_surfaceless_context: {}",
                            display.platform.as_str(),
                            eglu::last_error(egl)
                        )));
                    }
                    let Some(config) = eglu::choose_config(egl, display.handle(), false, api.renderable_type()) else {
                        return Err(LoadError(format!("no EGL config for OpenGL ES {}.{}: {}", api.major, api.minor, eglu::last_error(egl))));
                    };
                    log::warn!("no pbuffer surface; running surfaceless, so the default framebuffer is 0x0");
                    (config, eglw::EGL_NO_SURFACE)
                }
            };

            let attributes: [i32; 5] = [
                eglw::EGL_CONTEXT_MAJOR_VERSION as i32,
                api.major,
                eglw::EGL_CONTEXT_MINOR_VERSION as i32,
                api.minor,
                eglw::EGL_NONE as i32,
            ];
            let context = egl.create_context(display.handle(), config, eglw::EGL_NO_CONTEXT, attributes.as_ptr());
            if context == eglw::EGL_NO_CONTEXT {
                let error = eglu::last_error(egl);
                if surface != eglw::EGL_NO_SURFACE {
                    egl.destroy_surface(display.handle(), surface);
                }
                return Err(LoadError(format!("the driver would not create an OpenGL ES {}.{} context: {error}", api.major, api.minor)));
            }
            let context_type = ContextType { api };

            if egl.make_current(display.handle(), surface, surface, context) != eglw::EGL_TRUE {
                let error = eglu::last_error(egl);
                egl.destroy_context(display.handle(), context);
                if surface != eglw::EGL_NO_SURFACE {
                    egl.destroy_surface(display.handle(), surface);
                }
                return Err(LoadError(format!("eglMakeCurrent failed: {error}")));
            }

            // Only the entry points this version has, which is what upstream's
            // `glu::initFunctions` does. Loading the ES 3.1 table into an ES 2.0
            // context would let a ported test reach a function that is not supposed to
            // exist there, and the driver would be blamed for whatever happened next.
            let mut gl = glw::Functions::default();
            let mut get = |name: &str| library.get_proc(name);
            gl.load_es20(&mut get);
            if context_type.supports(3, 0) {
                gl.load_es30(&mut get);
            }
            if context_type.supports(3, 1) {
                gl.load_es31(&mut get);
            }
            if context_type.supports(3, 2) {
                gl.load_es32(&mut get);
            }
            // The extension entry points need the extension list, which needs the
            // context to be current - which it now is.
            let extensions = crate::glu::context_info::query_extensions(&gl);
            gl.load_ext_es(&extensions, &mut get);

            let render_target = query_render_target(egl, &display, config, surface);

            log::info!(
                "OpenGL ES {}.{} context on the {} platform, {}x{} target, {} GL extensions",
                context_type.api.major,
                context_type.api.minor,
                display.platform.as_str(),
                render_target.width,
                render_target.height,
                extensions.len()
            );

            Ok(Self {
                context,
                surface,
                gl,
                context_type,
                render_target,
                display,
                library,
            })
        }
    }

    pub fn functions(&self) -> &glw::Functions {
        &self.gl
    }

    pub fn context_type(&self) -> ContextType {
        self.context_type
    }

    pub fn render_target(&self) -> RenderTarget {
        self.render_target
    }

    pub fn egl_platform(&self) -> &'static str {
        self.display.platform.as_str()
    }

    pub fn egl_version(&self) -> (i32, i32) {
        self.display.version
    }
}

impl Drop for RenderContext {
    fn drop(&mut self) {
        let egl = &self.library.egl;
        let display = self.display.handle();
        // SAFETY: every handle here was created on this display by `create` above and
        // has not been destroyed yet.
        unsafe {
            egl.make_current(display, eglw::EGL_NO_SURFACE, eglw::EGL_NO_SURFACE, eglw::EGL_NO_CONTEXT);
            egl.destroy_context(display, self.context);
            if self.surface != eglw::EGL_NO_SURFACE {
                egl.destroy_surface(display, self.surface);
            }
            egl.terminate(display);
        }
    }
}

fn query_render_target(egl: &eglw::Functions, display: &Display, config: eglw::EGLConfig, surface: EGLSurface) -> RenderTarget {
    let attribute = |name: u32| {
        let mut value = 0;
        // SAFETY: `config` came from this display, and every name below is a config
        // attribute EGL defines; a driver that refuses one leaves `value` at 0.
        if unsafe { egl.get_config_attrib(display.handle(), config, name as i32, &mut value) } == eglw::EGL_TRUE {
            value
        } else {
            0
        }
    };
    let surface_attribute = |name: u32| {
        if surface == eglw::EGL_NO_SURFACE {
            return 0;
        }
        let mut value = 0;
        // SAFETY: as above, for a surface this display created.
        if unsafe { egl.query_surface(display.handle(), surface, name as i32, &mut value) } == eglw::EGL_TRUE {
            value
        } else {
            0
        }
    };

    RenderTarget {
        width: surface_attribute(eglw::EGL_WIDTH),
        height: surface_attribute(eglw::EGL_HEIGHT),
        red_bits: attribute(eglw::EGL_RED_SIZE),
        green_bits: attribute(eglw::EGL_GREEN_SIZE),
        blue_bits: attribute(eglw::EGL_BLUE_SIZE),
        alpha_bits: attribute(eglw::EGL_ALPHA_SIZE),
        depth_bits: attribute(eglw::EGL_DEPTH_SIZE),
        stencil_bits: attribute(eglw::EGL_STENCIL_SIZE),
        num_samples: attribute(eglw::EGL_SAMPLES),
    }
}

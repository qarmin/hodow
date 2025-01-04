use std::error::Error as StdError;
use std::ffi::c_void;
use std::fmt;
use std::num::NonZeroU32;
use std::ptr::NonNull;

use glutin::config::{ConfigSurfaceTypes, ConfigTemplateBuilder};
use glutin::context::{ContextApi, ContextAttributesBuilder, PossiblyCurrentContext, Version};
use glutin::display::{Display, DisplayApiPreference};
use glutin::prelude::*;
use glutin::surface::{PbufferSurface, SurfaceAttributesBuilder};
#[cfg(windows)]
use raw_window_handle::WindowsDisplayHandle;
use raw_window_handle::{
    DisplayHandle, HandleError, HasDisplayHandle, RawDisplayHandle, WaylandDisplayHandle, XlibDisplayHandle,
};

use crate::opengl::{DisplayApiHint, GlApiHint, GpuOptions};

/// GLX error hook registrar callback expected by `DisplayApiPreference::Glx`.
type GlxErrorHookRegistrar = Box<dyn Fn(Box<dyn Fn(*mut c_void, *mut c_void) -> bool + Send + Sync>)>;

/// Simple wrapper around a headless OpenGL context or similar.
pub struct OpenGLMode {
    pub(crate) inner: PossiblyCurrentContext,
    pub(crate) display: Display,
    /// Keep the Xlib Display* alive for the lifetime of the OpenGL context.
    /// Mesa's gallium driver spawns background threads that dereference this
    /// pointer, so we must keep it valid until the context is destroyed.
    #[cfg(target_os = "linux")]
    _xlib_display: Option<XlibDisplayGuard>,
    /// Same, for the `wl_display` borrowed from a compositor connection.
    #[cfg(target_os = "linux")]
    _wayland: Option<WaylandConnectionGuard>,
    /// Declared last so it is destroyed after the context and display that were created from it.
    #[cfg(windows)]
    _window: super::win32_window::HiddenWindow,
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
// ── Xlib display RAII guard ──────────────────────────────────────────────────
/// Opens an Xlib Display via x11-dl and closes it on drop.
#[cfg(target_os = "linux")]
struct XlibDisplayGuard {
    xlib: x11_dl::xlib::Xlib,
    display: *mut x11_dl::xlib::Display,
}
#[cfg(target_os = "linux")]
// SAFETY: the Display* is only accessed for its pointer value (passed to EGL);
// it is never sent between threads directly.
unsafe impl Send for XlibDisplayGuard {}
#[cfg(target_os = "linux")]
unsafe impl Sync for XlibDisplayGuard {}
#[cfg(target_os = "linux")]
impl XlibDisplayGuard {
    /// Try to open the default X display (uses $DISPLAY env var).
    /// Also calls XInitThreads() so Mesa's background shader compiler threads
    /// can safely make Xlib calls concurrently.
    fn open() -> Option<Self> {
        let xlib = x11_dl::xlib::Xlib::open().ok()?;
        // XInitThreads must be called before any other Xlib function.
        // Mesa's gallium driver spawns shader compiler threads that call
        // Xlib (DRI2 fence sync); without this, those calls crash.
        unsafe { (xlib.XInitThreads)() };
        let display = unsafe { (xlib.XOpenDisplay)(std::ptr::null()) };
        if display.is_null() {
            None
        } else {
            Some(Self { xlib, display })
        }
    }
    fn as_ptr(&self) -> *mut x11_dl::xlib::Display {
        self.display
    }
}
#[cfg(target_os = "linux")]
impl Drop for XlibDisplayGuard {
    fn drop(&mut self) {
        unsafe {
            (self.xlib.XCloseDisplay)(self.display);
        }
    }
}
// ── OpenGLMode impl ─────────────────────────────────────────────────────────
impl OpenGLMode {
    /// Create a headless OpenGL context using default options.
    pub fn create() -> Result<Self, OpenGlError> {
        Self::create_with_opts(&GpuOptions::default())
    }
    /// Create a headless OpenGL context with the given [`GpuOptions`].
    pub fn create_with_opts(opts: &GpuOptions) -> Result<Self, OpenGlError> {
        // Apply software-rendering override before any EGL library is touched.
        // Mesa checks this env var at display-init time; setting it after is too late.
        if opts.force_software {
            // SAFETY: setting env vars before any threads that read them is safe.
            unsafe {
                std::env::set_var("LIBGL_ALWAYS_SOFTWARE", "1");
                // Also tell Mesa not to use hardware DRI drivers
                std::env::set_var("GALLIUM_DRIVER", "llvmpipe");
            }
            log::info!("force_software: set LIBGL_ALWAYS_SOFTWARE=1 GALLIUM_DRIVER=llvmpipe");
        }

        #[cfg(target_os = "linux")]
        {
            // Open a real Xlib display if $DISPLAY is set.
            // Mesa's gallium driver spawns background threads during context
            // creation that dereference the Xlib Display* — passing NULL
            // causes a SEGV in that thread.  A real connection fixes this.
            let xlib_guard = XlibDisplayGuard::open();
            let raw_xlib_ptr: Option<NonNull<std::ffi::c_void>> = xlib_guard
                .as_ref()
                .and_then(|g| NonNull::new(g.as_ptr() as *mut std::ffi::c_void));
            if raw_xlib_ptr.is_some() {
                log::debug!("Opened real Xlib Display* for EGL context creation");
            } else {
                log::warn!(
                    "No X display available ($DISPLAY not set or XOpenDisplay failed). \
                     Mesa may crash when creating GLES contexts."
                );
            }
            let headless = XlibBorrowedDisplay { ptr: raw_xlib_ptr };
            let preference = {
                let noop_registrar = || -> GlxErrorHookRegistrar { Box::new(|_hook| {}) };
                match opts.display_api {
                    DisplayApiHint::Egl => DisplayApiPreference::Egl,
                    DisplayApiHint::Glx => DisplayApiPreference::Glx(noop_registrar()),
                    DisplayApiHint::EglThenGlx => DisplayApiPreference::EglThenGlx(noop_registrar()),
                    DisplayApiHint::GlxThenEgl => DisplayApiPreference::GlxThenEgl(noop_registrar()),
                }
            };
            // With no X server (and often no DRM node) the Xlib/GLX path cannot initialize.
            // Fall back to EGL's device platform, which Mesa serves via surfaceless llvmpipe,
            // so GPU tests still run in CI/containers/headless boxes.
            let mut wayland_guard = None;
            let display = if raw_xlib_ptr.is_none() {
                // Order matters: a Wayland-only driver refuses both fallbacks below, and Mesa
                // under a compositor is happy either way, so trying the compositor first costs
                // nothing and is the only thing that works on i.MX/Vivante.
                match create_wayland_display() {
                    Ok((d, guard)) => {
                        wayland_guard = Some(guard);
                        d
                    }
                    Err(wl_err) => match create_egl_device_display() {
                        Ok(d) => d,
                        Err(e) => {
                            log::warn!(
                                "Wayland unavailable ({wl_err}); EGL device platform unavailable ({e}); trying default EGL display"
                            );
                            unsafe {
                                let dh = headless.display_handle().map_err(OpenGlError::from)?;
                                Display::new(dh.as_raw(), DisplayApiPreference::Egl)
                                    .map_err(|e| OpenGlError::Other(Box::new(e)))?
                            }
                        }
                    },
                }
            } else {
                unsafe {
                    let dh = headless.display_handle().map_err(OpenGlError::from)?;
                    Display::new(dh.as_raw(), preference).map_err(|e| OpenGlError::Other(Box::new(e)))?
                }
            };
            let (inner, display) = finish_context_on_display(display, opts)?;
            Ok(OpenGLMode {
                inner,
                display,
                _xlib_display: xlib_guard,
                _wayland: wayland_guard,
            })
        }
        #[cfg(windows)]
        {
            let window = super::win32_window::HiddenWindow::create()
                .ok_or_else(|| OpenGlError::Glutin("cannot create the hidden Win32 window WGL needs".into()))?;
            let preference = match opts.display_api {
                DisplayApiHint::Egl => DisplayApiPreference::Egl,
                _ => DisplayApiPreference::WglThenEgl(Some(window.raw_handle())),
            };
            let display = unsafe {
                Display::new(RawDisplayHandle::Windows(WindowsDisplayHandle::new()), preference)
                    .map_err(|e| OpenGlError::Other(Box::new(e)))?
            };
            let (inner, display) = finish_context_on_display(display, opts)?;
            Ok(OpenGLMode {
                inner,
                display,
                _window: window,
            })
        }
        #[cfg(not(any(target_os = "linux", windows)))]
        {
            let preference = DisplayApiPreference::Egl;
            let headless = XlibBorrowedDisplay { ptr: None };
            let display = unsafe {
                let dh = headless.display_handle().map_err(OpenGlError::from)?;
                let raw = dh.as_raw();
                Display::new(raw, preference).map_err(|e| OpenGlError::Other(Box::new(e)))?
            };
            let (inner, display) = finish_context_on_display(display, opts)?;
            Ok(OpenGLMode { inner, display })
        }
    }
    /// Get reference to the display for function loading
    pub fn display(&self) -> &Display {
        &self.display
    }
}
// ── helpers ──────────────────────────────────────────────────────────────────
/// Create a glutin EGL display from the first available EGL device.
///
/// This uses `EGL_EXT_platform_device`, which does not need an X server or a window
/// system. On machines without a GPU/DRM node Mesa still exposes a software (llvmpipe)
/// device here, so tests can run fully headless.
#[cfg(target_os = "linux")]
fn create_egl_device_display() -> Result<Display, OpenGlError> {
    use glutin::api::egl::device::Device;
    use glutin::api::egl::display::Display as EglDisplay;

    let devices: Vec<Device> = Device::query_devices()
        .map_err(|e| OpenGlError::Other(Box::new(e)))?
        .collect();
    // Prefer a device backed by a real DRM render node (hardware); fall back to the first
    // (typically the software swrast device) when none is present.
    let device = devices
        .iter()
        .find(|d| d.drm_render_device_node_path().is_some() || d.drm_device_node_path().is_some())
        .or_else(|| devices.first())
        .ok_or_else(|| OpenGlError::Glutin("no EGL devices available".into()))?;

    log::info!(
        "EGL device platform: name={:?} vendor={:?} drm={:?}",
        device.name(),
        device.vendor(),
        device
            .drm_render_device_node_path()
            .or_else(|| device.drm_device_node_path())
    );

    // SAFETY: `device` comes from `query_devices`, so the client extensions required by
    // `with_device` have already been enumerated.
    let egl_display = unsafe { EglDisplay::with_device(device, None).map_err(|e| OpenGlError::Other(Box::new(e)))? };
    Ok(Display::Egl(egl_display))
}

/// Create a glutin EGL display from a running Wayland compositor.
///
/// Needed by drivers whose libEGL is the Wayland build and serves nothing else - i.MX/Vivante's
/// `imx-gpu-viv` answers `eglGetDisplay(EGL_DEFAULT_DISPLAY)` with "No default display support
/// on wayland" and refuses the EGL device platform too, so without this the GPU suite cannot
/// start at all on such a board even with Weston running. Requires `WAYLAND_DISPLAY` (and
/// `XDG_RUNTIME_DIR`) in the environment - `default_wayland_env` fills them in over SSH.
#[cfg(target_os = "linux")]
fn create_wayland_display() -> Result<(Display, WaylandConnectionGuard), OpenGlError> {
    use wayland_client::Connection;

    let connection =
        Connection::connect_to_env().map_err(|e| OpenGlError::Glutin(format!("no Wayland compositor: {e}")))?;
    let ptr = NonNull::new(connection.backend().display_ptr() as *mut std::ffi::c_void)
        .ok_or_else(|| OpenGlError::Glutin("Wayland connection has a null wl_display".into()))?;
    log::info!("Using the Wayland compositor's wl_display for EGL");
    let raw = RawDisplayHandle::Wayland(WaylandDisplayHandle::new(ptr));
    // SAFETY: `connection` is returned alongside and kept alive by the caller for as long as
    // the display lives, so the wl_display this borrows stays valid.
    let display = unsafe { Display::new(raw, DisplayApiPreference::Egl).map_err(|e| OpenGlError::Other(Box::new(e)))? };
    Ok((display, WaylandConnectionGuard(connection)))
}

/// Keeps the compositor connection - and therefore the `wl_display` EGL borrowed - alive for
/// the lifetime of the context.
#[cfg(target_os = "linux")]
pub struct WaylandConnectionGuard(#[allow(dead_code)] wayland_client::Connection);

/// A display handle that wraps an optional Xlib Display pointer.
#[cfg(not(windows))]
struct XlibBorrowedDisplay {
    ptr: Option<NonNull<std::ffi::c_void>>,
}
#[cfg(not(windows))]
impl HasDisplayHandle for XlibBorrowedDisplay {
    fn display_handle(&self) -> Result<DisplayHandle<'_>, HandleError> {
        #[cfg(target_os = "linux")]
        {
            // NonNull<c_void> → *mut x11_dl::xlib::Display (same layout)
            let xlib_ptr = self.ptr.and_then(|p| NonNull::new(p.as_ptr() as *mut _));
            let raw = RawDisplayHandle::Xlib(XlibDisplayHandle::new(xlib_ptr, 0));
            unsafe { Ok(DisplayHandle::borrow_raw(raw)) }
        }
        #[cfg(not(target_os = "linux"))]
        {
            Err(HandleError::NotSupported)
        }
    }
}
/// Given an already-created glutin `Display`, pick a config, create a context
/// and a pbuffer surface, then make it current.
fn finish_context_on_display(
    display: Display,
    opts: &GpuOptions,
) -> Result<(PossiblyCurrentContext, Display), OpenGlError> {
    // We render into a pbuffer, so only require pbuffer-capable configs. This is essential
    // for the surfaceless/device EGL path, which offers no window-surface configs at all.
    let template = ConfigTemplateBuilder::new()
        .with_surface_type(ConfigSurfaceTypes::PBUFFER)
        .build();
    let config = unsafe {
        display
            .find_configs(template)
            .map_err(|e| OpenGlError::Other(Box::new(e)))?
            .next()
            .ok_or_else(|| OpenGlError::Glutin("No GL config found".into()))?
    };
    let context_attributes = make_context_attrs(opts.gl_api);
    let fallback_attributes = match opts.gl_api {
        GlApiHint::Gles { .. } => ContextAttributesBuilder::new()
            .with_context_api(ContextApi::OpenGl(None))
            .build(None),
        _ => ContextAttributesBuilder::new()
            .with_context_api(ContextApi::Gles(None))
            .build(None),
    };
    let not_current = unsafe {
        match display.create_context(&config, &context_attributes) {
            Ok(ctx) => ctx,
            Err(_) => display
                .create_context(&config, &fallback_attributes)
                .map_err(|e| OpenGlError::Other(Box::new(e)))?,
        }
    };
    let pbuffer = {
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
    let possibly_current = not_current
        .make_current(&pbuffer)
        .map_err(|e| OpenGlError::Other(Box::new(e)))?;
    Ok((possibly_current, display))
}
/// Build `ContextAttributes` from a `GlApiHint`.
fn make_context_attrs(hint: GlApiHint) -> glutin::context::ContextAttributes {
    match hint {
        GlApiHint::Auto => ContextAttributesBuilder::new().build(None),
        GlApiHint::OpenGl { major: 0, minor: 0 } => ContextAttributesBuilder::new()
            .with_context_api(ContextApi::OpenGl(None))
            .build(None),
        GlApiHint::OpenGl { major, minor } => ContextAttributesBuilder::new()
            .with_context_api(ContextApi::OpenGl(Some(Version::new(major, minor))))
            .build(None),
        GlApiHint::Gles { major: 0, minor: 0 } => ContextAttributesBuilder::new()
            .with_context_api(ContextApi::Gles(None))
            .build(None),
        GlApiHint::Gles { major, minor } => ContextAttributesBuilder::new()
            .with_context_api(ContextApi::Gles(Some(Version::new(major, minor))))
            .build(None),
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/egl  (eglu::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Bringing an EGLDisplay up is the one part of this that is not a port. Upstream's
// platform layer is a file per operating system and windowing system
// (egluGLContextFactory + tcuX11Platform / tcuAndroidPlatform / ...), selected by the
// CMake DEQP_TARGET; none of that shape is worth keeping, because this tool has one
// requirement upstream's targets do not: it must find a display on a headless board
// without being told which windowing system that board has. So the platforms are tried
// in turn, and every attempt is logged - which is the difference between "no driver
// here" and "driver present, but nothing to attach it to".
//
// The order matters and is not arbitrary:
//
//   1. an explicit override, for pinning one platform down while debugging;
//   2. EGL_EXT_platform_device, then EGL_MESA_platform_surfaceless - a real display
//      with no screen and no compositor, which is what makes a container or a CI
//      runner work;
//   3. Wayland, if a compositor is running. A Wayland-only driver
//      (i.MX/Vivante's imx-gpu-viv) refuses both of the above *and* the default
//      display - it answers "No default display support on wayland" - so this is the
//      only path that works there. libwayland-client is opened at run time for the
//      two symbols that produce a `wl_display*`; EGL needs nothing else from it, so
//      that costs no build dependency and no protocol code;
//   4. eglGetDisplay(EGL_DEFAULT_DISPLAY), the EGL 1.4 way, which is what an X11 or a
//      plain framebuffer driver answers.

use std::collections::BTreeSet;
use std::ffi::c_void;

use crate::eglw::{self, EGLConfig, EGLDisplay, EGLSurface, Functions, Library, LoadError};

/// Names to try for libwayland-client. Only `wl_display_connect`/`wl_display_disconnect`
/// are ever called: EGL takes the raw `wl_display*` and does the rest itself.
const WAYLAND_LIBRARIES: &[&str] = &["libwayland-client.so.0", "libwayland-client.so"];

/// Two platform enumerants and one entry point that upstream's generated EGL wrapper
/// does not declare, because egl.xml does not carry the vendor platform extensions
/// upstream never used. Values are from the extension specifications
/// (`EGL_EXT_platform_device`, `EGL_MESA_platform_surfaceless`).
pub const EGL_PLATFORM_DEVICE_EXT: u32 = 0x313F;
pub const EGL_PLATFORM_SURFACELESS_MESA: u32 = 0x31DD;

type QueryDevicesExt = unsafe extern "C" fn(max_devices: i32, devices: *mut *mut c_void, num_devices: *mut i32) -> u32;

/// Which EGL platform a display was opened through, for the run header and the log.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Platform {
    Device,
    Surfaceless,
    Wayland,
    Default,
}

impl Platform {
    pub fn as_str(self) -> &'static str {
        match self {
            Self::Device => "device",
            Self::Surfaceless => "surfaceless",
            Self::Wayland => "wayland",
            Self::Default => "default",
        }
    }

    fn from_str(name: &str) -> Option<Self> {
        match name {
            "device" => Some(Self::Device),
            "surfaceless" => Some(Self::Surfaceless),
            "wayland" => Some(Self::Wayland),
            "default" => Some(Self::Default),
            _ => None,
        }
    }
}

/// Environment variable that pins the platform, e.g. `HODOW_CTS_EGL_PLATFORM=surfaceless`.
///
/// Deliberately not `EGL_PLATFORM`: that one is Mesa's own and is read by the loader
/// itself, so setting it changes what the *driver* does as well and the two cannot be
/// told apart afterwards.
pub const PLATFORM_ENV: &str = "HODOW_CTS_EGL_PLATFORM";

/// A live connection to a Wayland compositor, kept alive for the display's lifetime.
///
/// EGL only borrows the `wl_display*`, so dropping this while a display exists would
/// leave the driver holding a dangling pointer - the same trap `hodow_core`'s OpenGL
/// context hit.
struct WaylandConnection {
    library: libloading::Library,
    display: *mut c_void,
}

impl WaylandConnection {
    fn open() -> Option<Self> {
        // No compositor advertised means there is nothing to connect to, and
        // wl_display_connect(NULL) would only fail more slowly.
        std::env::var_os("WAYLAND_DISPLAY")?;

        for name in WAYLAND_LIBRARIES {
            // SAFETY: opening a shared library runs its initialisers, which is the
            // point; there is no safe way to do this.
            let Ok(library) = (unsafe { libloading::Library::new(name) }) else {
                continue;
            };
            // SAFETY: the signature is wl_display_connect's, and the argument is the
            // documented "use $WAYLAND_DISPLAY" null.
            let display = unsafe {
                let connect = library.get::<unsafe extern "C" fn(*const std::ffi::c_char) -> *mut c_void>(b"wl_display_connect\0");
                match connect {
                    Ok(connect) => connect(std::ptr::null()),
                    Err(_) => std::ptr::null_mut(),
                }
            };
            if !display.is_null() {
                return Some(Self { library, display });
            }
        }
        None
    }
}

impl Drop for WaylandConnection {
    fn drop(&mut self) {
        // SAFETY: the pointer came from wl_display_connect on this same library.
        unsafe {
            if let Ok(disconnect) = self.library.get::<unsafe extern "C" fn(*mut c_void)>(b"wl_display_disconnect\0") {
                disconnect(self.display);
            }
        }
    }
}

/// An initialised EGLDisplay, with the platform it came from and what it supports.
pub struct Display {
    handle: EGLDisplay,
    pub platform: Platform,
    pub version: (i32, i32),
    pub extensions: BTreeSet<String>,
    /// Dropped after the display is terminated - see `WaylandConnection`.
    _native: Option<WaylandConnection>,
}

impl Display {
    pub fn handle(&self) -> EGLDisplay {
        self.handle
    }
}

/// Opens and initialises a display, trying each platform in turn.
///
/// Every attempt and its EGL error is logged, and the environment that decides most of
/// them (`WAYLAND_DISPLAY`, `XDG_RUNTIME_DIR`, `DISPLAY`) is logged alongside: without
/// that, "could not get a display" on a board is indistinguishable from "no driver".
pub fn open_display(library: &Library, device_index: usize) -> Result<Display, LoadError> {
    let egl = &library.egl;
    let client_extensions = library.client_extensions();

    let wanted: Vec<Platform> = match std::env::var(PLATFORM_ENV) {
        Ok(name) => match Platform::from_str(name.trim()) {
            Some(platform) => vec![platform],
            None => return Err(LoadError(format!("{PLATFORM_ENV}={name} is not one of device, surfaceless, wayland, default"))),
        },
        Err(_) => vec![Platform::Device, Platform::Surfaceless, Platform::Wayland, Platform::Default],
    };

    let mut failures: Vec<String> = Vec::new();

    for platform in wanted {
        let mut native: Option<WaylandConnection> = None;

        let handle = match platform {
            Platform::Device => {
                if !client_extensions.contains("EGL_EXT_platform_device") {
                    failures.push("device: EGL_EXT_platform_device is not advertised".to_string());
                    continue;
                }
                match nth_device(library, device_index) {
                    Some(device) => platform_display(egl, EGL_PLATFORM_DEVICE_EXT, device),
                    None => {
                        failures.push(format!("device: no EGL device number {device_index} was enumerated"));
                        continue;
                    }
                }
            }
            Platform::Surfaceless => {
                if !client_extensions.contains("EGL_MESA_platform_surfaceless") {
                    failures.push("surfaceless: EGL_MESA_platform_surfaceless is not advertised".to_string());
                    continue;
                }
                platform_display(egl, EGL_PLATFORM_SURFACELESS_MESA, std::ptr::null_mut())
            }
            Platform::Wayland => match WaylandConnection::open() {
                Some(connection) => {
                    let wl = connection.display;
                    native = Some(connection);
                    if client_extensions.contains("EGL_EXT_platform_wayland") || client_extensions.contains("EGL_KHR_platform_wayland") {
                        platform_display(egl, eglw::EGL_PLATFORM_WAYLAND_KHR, wl)
                    } else {
                        // imx-gpu-viv's Wayland backend takes the wl_display through
                        // the EGL 1.4 entry point and advertises no platform extension.
                        // SAFETY: the handle is this library's own entry point.
                        unsafe { egl.get_display(wl) }
                    }
                }
                None => {
                    failures.push(format!(
                        "wayland: no compositor connection (WAYLAND_DISPLAY={:?}, XDG_RUNTIME_DIR={:?})",
                        std::env::var("WAYLAND_DISPLAY").unwrap_or_default(),
                        std::env::var("XDG_RUNTIME_DIR").unwrap_or_default()
                    ));
                    continue;
                }
            },
            // SAFETY: as above.
            Platform::Default => unsafe { egl.get_display(eglw::EGL_DEFAULT_DISPLAY) },
        };

        // Only the device platform can be pointed at a particular GPU; every other one
        // gets whatever the window system or the loader picked.
        if device_index > 1 && platform != Platform::Device {
            log::warn!(
                "--device-id has no effect on the {} platform - it selects an EGL device, and this platform does not enumerate them",
                platform.as_str()
            );
        }

        if handle == eglw::EGL_NO_DISPLAY {
            failures.push(format!("{}: no display ({})", platform.as_str(), last_error(egl)));
            continue;
        }

        let mut major = 0;
        let mut minor = 0;
        // SAFETY: `handle` is a display this library just returned.
        let initialised = unsafe { egl.initialize(handle, &mut major, &mut minor) };
        if initialised != eglw::EGL_TRUE {
            failures.push(format!("{}: eglInitialize failed ({})", platform.as_str(), last_error(egl)));
            continue;
        }

        // SAFETY: the display is initialised, which is what makes this query legal, and
        // the string it answers with is owned by the driver and null-terminated.
        let extensions = unsafe { eglw::split_extensions(egl.query_string(handle, eglw::EGL_EXTENSIONS as i32)) };
        log::info!("EGL {major}.{minor} on the {} platform, {} extensions", platform.as_str(), extensions.len());

        return Ok(Display {
            handle,
            platform,
            version: (major, minor),
            extensions,
            _native: native,
        });
    }

    for failure in &failures {
        log::info!("EGL: {failure}");
    }
    Err(LoadError(format!(
        "no EGL display could be opened. Tried:\n  {}\nEnvironment: DISPLAY={:?} WAYLAND_DISPLAY={:?} XDG_RUNTIME_DIR={:?}",
        failures.join("\n  "),
        std::env::var("DISPLAY").unwrap_or_default(),
        std::env::var("WAYLAND_DISPLAY").unwrap_or_default(),
        std::env::var("XDG_RUNTIME_DIR").unwrap_or_default(),
    )))
}

fn platform_display(egl: &Functions, platform: u32, native: *mut c_void) -> EGLDisplay {
    if egl.get_platform_display.is_some() {
        // SAFETY: EGL 1.5's entry point, with a null attribute list.
        return unsafe { egl.get_platform_display(platform, native, std::ptr::null()) };
    }
    if egl.get_platform_display_ext.is_some() {
        // SAFETY: the EGL_EXT_platform_base entry point, same arguments.
        return unsafe { egl.get_platform_display_ext(platform, native, std::ptr::null()) };
    }
    eglw::EGL_NO_DISPLAY
}

/// The device `--device-id` asks for, 1-based in enumeration order, which is the same
/// convention the Vulkan side uses for physical devices.
///
/// The entry point is looked up by hand because upstream's generated wrapper has no
/// declaration for it - see the constants above.
fn nth_device(library: &Library, index: usize) -> Option<*mut c_void> {
    let symbol = library.get_proc("eglQueryDevicesEXT");
    if symbol.is_null() {
        return None;
    }
    // SAFETY: the pointer came from the loader under that exact name, so it has the
    // signature EGL_EXT_device_enumeration specifies.
    let query_devices: QueryDevicesExt = unsafe { std::mem::transmute_copy(&symbol) };

    let mut count = 0;
    // SAFETY: the documented two-call form - ask for the count, then fill the array.
    if unsafe { query_devices(0, std::ptr::null_mut(), &mut count) } != eglw::EGL_TRUE || count <= 0 {
        return None;
    }
    let mut devices = vec![std::ptr::null_mut(); count as usize];
    // SAFETY: `devices` has room for `count` entries, which is what is passed.
    if unsafe { query_devices(count, devices.as_mut_ptr(), &mut count) } != eglw::EGL_TRUE || count <= 0 {
        return None;
    }
    log::debug!("{count} EGL device(s) enumerated");
    devices.get(index.saturating_sub(1)).copied()
}

/// `eglGetError`, as a name a person can read.
pub fn last_error(egl: &Functions) -> String {
    // SAFETY: legal at any time, including before a display exists.
    let error = unsafe { egl.get_error() };
    format!("{} (0x{:x})", eglw::error_name(error), error)
}

/// Chooses a config that can hold a context of the given renderable type.
///
/// `PBUFFER_BIT` is asked for because a pbuffer is the surface type that needs no
/// window system at all; the surfaceless path below drops the requirement.
///
/// Depth and stencil are asked for first, and only dropped if the driver has no such
/// config: EGL sorts configs with *fewer* depth/stencil bits first, so asking for a
/// colour buffer alone reliably yields a target with no depth and no stencil at all,
/// and every ported group that clears or tests them would report NotSupported. This is
/// the equivalent of upstream's `--deqp-gl-config-name=rgba8888d24s8`, which
/// `diff_vs_deqp.py` passes for the same reason.
///
/// # Safety
/// `display` must be an initialised display belonging to `egl`.
pub unsafe fn choose_config(egl: &Functions, display: EGLDisplay, want_pbuffer: bool, renderable_type: u32) -> Option<EGLConfig> {
    // SAFETY: as documented on this function.
    unsafe { choose_config_with_depth_stencil(egl, display, want_pbuffer, renderable_type, true) }
        .or_else(|| unsafe { choose_config_with_depth_stencil(egl, display, want_pbuffer, renderable_type, false) })
}

/// # Safety
/// As `choose_config`.
unsafe fn choose_config_with_depth_stencil(egl: &Functions, display: EGLDisplay, want_pbuffer: bool, renderable_type: u32, depth_stencil: bool) -> Option<EGLConfig> {
    let mut attributes: Vec<i32> = vec![
        eglw::EGL_SURFACE_TYPE as i32,
        if want_pbuffer { eglw::EGL_PBUFFER_BIT as i32 } else { 0 },
        eglw::EGL_RENDERABLE_TYPE as i32,
        renderable_type as i32,
        eglw::EGL_RED_SIZE as i32,
        8,
        eglw::EGL_GREEN_SIZE as i32,
        8,
        eglw::EGL_BLUE_SIZE as i32,
        8,
        eglw::EGL_ALPHA_SIZE as i32,
        8,
    ];
    if depth_stencil {
        attributes.extend_from_slice(&[eglw::EGL_DEPTH_SIZE as i32, 24, eglw::EGL_STENCIL_SIZE as i32, 8]);
    }
    attributes.push(eglw::EGL_NONE as i32);

    let mut config: EGLConfig = std::ptr::null_mut();
    let mut count = 0;
    // SAFETY: the attribute list is EGL_NONE-terminated and the output has room for one.
    let ok = unsafe { egl.choose_config(display, attributes.as_ptr(), &mut config, 1, &mut count) };
    (ok == eglw::EGL_TRUE && count == 1).then_some(config)
}

/// Creates the pbuffer that the context renders into when there is no window.
///
/// # Safety
/// `display` must be an initialised display belonging to `egl`, and `config` one of
/// that display's configs.
pub unsafe fn create_pbuffer_surface(egl: &Functions, display: EGLDisplay, config: EGLConfig, width: i32, height: i32) -> Option<EGLSurface> {
    let attributes: [i32; 5] = [eglw::EGL_WIDTH as i32, width, eglw::EGL_HEIGHT as i32, height, eglw::EGL_NONE as i32];
    // SAFETY: config came from this display and the attribute list is terminated.
    let surface = unsafe { egl.create_pbuffer_surface(display, config, attributes.as_ptr()) };
    (surface != eglw::EGL_NO_SURFACE).then_some(surface)
}

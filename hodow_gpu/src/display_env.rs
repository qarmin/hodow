use std::path::{Path, PathBuf};

/// Fills in `XDG_RUNTIME_DIR` and `WAYLAND_DISPLAY` when neither they nor `DISPLAY` are set,
/// which is every ssh session on a board: without them a Wayland-only driver (i.MX/Vivante)
/// offers no EGL display at all. Only a socket that exists is named, so a board with no
/// compositor keeps falling through to the device platform. Returns what was set.
///
/// Must run before any thread is spawned - it calls `set_var`.
pub fn default_wayland_env() -> Vec<String> {
    let mut set = Vec::new();
    if !cfg!(target_os = "linux") || std::env::var_os("DISPLAY").is_some() {
        return set;
    }
    let runtime_dir = match std::env::var_os("XDG_RUNTIME_DIR") {
        Some(dir) => PathBuf::from(dir),
        None => {
            let Some(dir) = user_runtime_dir() else { return set };
            unsafe { std::env::set_var("XDG_RUNTIME_DIR", &dir) };
            set.push(format!("XDG_RUNTIME_DIR={}", dir.display()));
            dir
        }
    };
    if std::env::var_os("WAYLAND_DISPLAY").is_none()
        && let Some(socket) = wayland_socket(&runtime_dir)
    {
        unsafe { std::env::set_var("WAYLAND_DISPLAY", &socket) };
        set.push(format!("WAYLAND_DISPLAY={socket}"));
    }
    set
}

#[cfg(unix)]
fn user_runtime_dir() -> Option<PathBuf> {
    use std::os::unix::fs::MetadataExt;
    let uid = std::fs::metadata("/proc/self").ok()?.uid();
    Some(PathBuf::from(format!("/run/user/{uid}"))).filter(|dir| dir.is_dir())
}

#[cfg(not(unix))]
fn user_runtime_dir() -> Option<PathBuf> {
    None
}

#[cfg(unix)]
fn wayland_socket(runtime_dir: &Path) -> Option<String> {
    use std::os::unix::fs::FileTypeExt;
    let mut names: Vec<String> = std::fs::read_dir(runtime_dir)
        .ok()?
        .flatten()
        .filter(|entry| entry.file_type().is_ok_and(|t| t.is_socket()))
        .filter_map(|entry| entry.file_name().into_string().ok())
        .filter(|name| name.starts_with("wayland-"))
        .collect();
    names.sort();
    names.into_iter().next()
}

#[cfg(not(unix))]
fn wayland_socket(_runtime_dir: &Path) -> Option<String> {
    None
}

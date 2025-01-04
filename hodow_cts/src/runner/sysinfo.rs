//! The one-line description of the machine printed before anything touches a driver.
//!
//! On a board the run's own output is often the only record of where it ran, and a run
//! that wedges the GPU before its first case would otherwise leave nothing but the
//! header. Read from /proc and /sys only (directly or through `sysinfo`), so it cannot hang
//! on a driver.

use std::fs;
use std::path::{Path, PathBuf};

use ::sysinfo::{CpuRefreshKind, System};

pub fn system_line() -> String {
    let mut system = System::new().ok();
    if let Some(system) = &mut system {
        system.refresh_cpu_list(CpuRefreshKind::nothing());
        system.refresh_memory();
    }
    let mut parts = vec![
        distro(),
        format!(
            "kernel {}",
            System::kernel_version().unwrap_or_else(|_| "?".to_string())
        ),
        System::host_name().unwrap_or_else(|_| "?".to_string()),
        format!("{} {}", std::env::consts::ARCH, cpu(system.as_ref())),
    ];
    parts.extend(soc());
    parts.push(memory(system.as_ref()));
    parts.push(gpu_drivers());
    parts.join(" | ")
}

/// What decides which EGL platform can work, and whether the compositor it names is there.
pub fn display_line() -> String {
    if cfg!(windows) {
        return "Windows (default EGL display; no X11/Wayland)".to_string();
    }
    let runtime_dir = std::env::var("XDG_RUNTIME_DIR").ok();
    let wayland = match std::env::var("WAYLAND_DISPLAY") {
        Ok(name) => {
            let socket = match &runtime_dir {
                Some(dir) if !Path::new(&name).is_absolute() => Path::new(dir).join(&name),
                _ => Path::new(&name).to_path_buf(),
            };
            if socket.exists() {
                format!("WAYLAND_DISPLAY={name} (socket present)")
            } else {
                format!(
                    "WAYLAND_DISPLAY={name} (no socket at {} - compositor not running?)",
                    socket.display()
                )
            }
        }
        Err(_) => "WAYLAND_DISPLAY unset".to_string(),
    };
    let display = std::env::var("DISPLAY")
        .map(|d| format!("DISPLAY={d}"))
        .unwrap_or_else(|_| "DISPLAY unset".to_string());
    let pinned = std::env::var(crate::eglu::PLATFORM_ENV)
        .map(|p| format!(", {}={p}", crate::eglu::PLATFORM_ENV))
        .unwrap_or_default();
    format!(
        "{wayland}, XDG_RUNTIME_DIR={}, {display}{pinned}",
        runtime_dir.as_deref().unwrap_or("unset")
    )
}

/// The same defaulting `hodow_gpu::default_wayland_env` does, which this crate cannot use.
/// Fills in `XDG_RUNTIME_DIR` and `WAYLAND_DISPLAY` when neither they nor `DISPLAY` are set,
/// which is every ssh session on a board: without them a Wayland-only driver (i.MX/Vivante)
/// offers no EGL display at all. Only a socket that exists is named, so a board with no
/// compositor keeps falling through to the device platform. Returns what was set.
///
/// Must run before any thread is spawned - it calls `set_var`.
pub fn default_wayland_env() -> Vec<String> {
    let mut set = Vec::new();
    if std::env::var_os("DISPLAY").is_some() {
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

#[cfg(not(unix))]
fn user_runtime_dir() -> Option<PathBuf> {
    None
}

#[cfg(not(unix))]
fn wayland_socket(_runtime_dir: &Path) -> Option<String> {
    None
}

#[cfg(unix)]
fn user_runtime_dir() -> Option<PathBuf> {
    use std::os::unix::fs::MetadataExt;
    let uid = std::fs::metadata("/proc/self").ok()?.uid();
    Some(PathBuf::from(format!("/run/user/{uid}"))).filter(|dir| dir.is_dir())
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

fn read_trimmed(path: impl AsRef<Path>) -> Option<String> {
    fs::read_to_string(path)
        .ok()
        .map(|s| s.trim().to_string())
        .filter(|s| !s.is_empty())
}

fn distro() -> String {
    match (System::name(), System::os_version()) {
        (Ok(name), Ok(version)) => format!("{name} {version}"),
        (Ok(name), Err(_)) => name,
        _ => "unknown distro".to_string(),
    }
}

/// One entry per distinct core type, so a big.LITTLE part reads `4x Cortex-A55 + 4x Cortex-A76`.
fn cpu(system: Option<&System>) -> String {
    let mut groups: Vec<(&str, usize)> = Vec::new();
    for brand in system
        .map_or(&[][..], System::cpus)
        .iter()
        .map(|cpu| cpu.brand().trim())
    {
        let brand = if brand.is_empty() { "unknown CPU" } else { brand };
        match groups.iter_mut().find(|(known, _)| *known == brand) {
            Some((_, count)) => *count += 1,
            None => groups.push((brand, 1)),
        }
    }
    let cores = if groups.is_empty() {
        "unknown CPU".to_string()
    } else {
        groups
            .iter()
            .map(|(brand, count)| format!("{count}x {brand}"))
            .collect::<Vec<_>>()
            .join(" + ")
    };
    let max_mhz = read_trimmed("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq")
        .and_then(|khz| khz.parse::<u64>().ok())
        .filter(|_| !cores.contains("Hz"))
        .map(|khz| format!(" @ {} MHz", khz / 1000))
        .unwrap_or_default();
    format!("{cores}{max_mhz}")
}

/// The chip and board as the kernel names them (soc bus, device tree); absent on a PC.
fn soc() -> Option<String> {
    let soc0 = |field: &str| read_trimmed(format!("/sys/devices/soc0/{field}"));
    let chip = soc0("soc_id").map(|id| match soc0("revision") {
        Some(revision) => format!("{id} rev {revision}"),
        None => id,
    });
    let board = read_trimmed("/sys/firmware/devicetree/base/model")
        .map(|model| model.trim_end_matches('\0').to_string())
        .or_else(|| soc0("machine"));
    match (chip, board) {
        (Some(chip), Some(board)) => Some(format!("{chip} on {board}")),
        (chip, board) => chip.or(board),
    }
}

fn memory(system: Option<&System>) -> String {
    let mut text = format!("RAM {} MB", system.map_or(0, System::total_memory) / (1024 * 1024));
    let meminfo = fs::read_to_string("/proc/meminfo").unwrap_or_default();
    let mb = |key: &str| {
        meminfo
            .lines()
            .find_map(|line| line.strip_prefix(key))
            .and_then(|rest| rest.trim().trim_end_matches("kB").trim().parse::<u64>().ok())
            .map(|kb| kb / 1024)
    };
    if let Some(cma) = mb("CmaTotal:").filter(|&v| v > 0) {
        text.push_str(&format!(", CMA {cma} MB ({} MB free)", mb("CmaFree:").unwrap_or(0)));
    }
    text
}

/// The kernel side of the GPU stack: galcore's version if it has one, then the driver
/// bound to each DRM card.
fn gpu_drivers() -> String {
    let mut drivers: Vec<String> = Vec::new();
    if Path::new("/dev/galcore").exists() {
        drivers.push(match read_trimmed("/sys/module/galcore/version") {
            Some(version) => format!("galcore {version}"),
            None => "galcore".to_string(),
        });
    }
    let mut cards: Vec<_> = fs::read_dir("/sys/class/drm")
        .into_iter()
        .flatten()
        .flatten()
        .map(|entry| entry.file_name().to_string_lossy().into_owned())
        .filter(|name| name.starts_with("card") && !name.contains('-'))
        .collect();
    cards.sort();
    for card in cards {
        let driver = fs::read_link(format!("/sys/class/drm/{card}/device/driver"))
            .ok()
            .and_then(|link| link.file_name().map(|n| n.to_string_lossy().into_owned()));
        if let Some(driver) = driver {
            let entry = format!("{card}: {driver}");
            if !drivers.contains(&entry) {
                drivers.push(entry);
            }
        }
    }
    if drivers.is_empty() {
        "GPU: no kernel driver found".to_string()
    } else {
        format!("GPU {}", drivers.join(", "))
    }
}

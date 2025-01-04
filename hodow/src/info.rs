//! `hodow info` - what this machine is and what this binary can test on it.
//!
//! Everything here comes from `/proc` and `/sys`, through `sysinfo` where it has the answer
//! (its CPU names are util-linux's `lscpu` table, so an ARM part number becomes a core name
//! without a list of our own). Every field is optional - a missing or unreadable file prints
//! `unknown` instead of failing the command.
//!
//! Deliberately does not touch the GPU. Creating an OpenGL context or a Vulkan device is
//! exactly the kind of thing that hangs or crashes on the drivers this tool exists to test,
//! and `info` has to stay something you can run first, safely. Use `hodow vulkan` /
//! `hodow gpu` for that.

use std::fmt::Write as _;
use std::{env, fs};

use hodow_cpu::{all_tests, extension_status};
use sysinfo::{CpuRefreshKind, System};

use crate::cli::InfoArgs;

fn read_trimmed(path: &str) -> Option<String> {
    fs::read_to_string(path)
        .ok()
        .map(|s| s.trim().to_string())
        .filter(|s| !s.is_empty())
}

fn meminfo_kib(text: &str, key: &str) -> Option<u64> {
    text.lines()
        .find(|l| l.split(':').next().is_some_and(|k| k.trim() == key))
        .and_then(|l| l.split_once(':'))?
        .1
        .split_whitespace()
        .next()?
        .parse()
        .ok()
}

fn format_bytes(bytes: u64) -> String {
    const GIB: f64 = 1024.0 * 1024.0 * 1024.0;
    format!("{:.2} GiB", bytes as f64 / GIB)
}

fn system() -> Option<System> {
    let mut system = System::new().ok()?;
    system.refresh_cpu_list(CpuRefreshKind::nothing());
    system.refresh_memory();
    Some(system)
}

fn distro() -> String {
    match (System::name(), System::os_version()) {
        (Ok(name), Ok(version)) => format!("{name} {version}"),
        (Ok(name), Err(_)) => name,
        _ => "unknown".to_string(),
    }
}

/// One entry per distinct core type, so a big.LITTLE part reads `4x Cortex-A55 + 4x Cortex-A76`.
fn cpu_model(system: Option<&System>) -> String {
    let mut groups: Vec<(&str, usize)> = Vec::new();
    for brand in system
        .map_or(&[][..], System::cpus)
        .iter()
        .map(|cpu| cpu.brand().trim())
    {
        let brand = if brand.is_empty() { "unknown" } else { brand };
        match groups.iter_mut().find(|(known, _)| *known == brand) {
            Some((_, count)) => *count += 1,
            None => groups.push((brand, 1)),
        }
    }
    if groups.is_empty() {
        return "unknown".to_string();
    }
    groups
        .iter()
        .map(|(brand, count)| format!("{count}x {brand}"))
        .collect::<Vec<_>>()
        .join(" + ")
}

/// The chip and board as the kernel names them (soc bus, device tree); absent on a PC.
fn soc() -> Option<String> {
    let soc0 = |field: &str| read_trimmed(&format!("/sys/devices/soc0/{field}"));
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

fn cpu_mhz_range() -> Option<String> {
    let base = "/sys/devices/system/cpu/cpu0/cpufreq";
    let min: u64 = read_trimmed(&format!("{base}/cpuinfo_min_freq"))?.parse().ok()?;
    let max: u64 = read_trimmed(&format!("{base}/cpuinfo_max_freq"))?.parse().ok()?;
    Some(format!("{}/{} MHz", min / 1000, max / 1000))
}

fn line(label: &str, value: &str) {
    println!("  {label:<22} {value}");
}

fn print_system() {
    println!("System:");
    line("Host", &System::host_name().unwrap_or_else(|_| "unknown".into()));
    line("Kernel", &System::kernel_version().unwrap_or_else(|_| "unknown".into()));
    line("Distro", &distro());
    line(
        "OS / arch",
        &format!("{} / {} ({}-bit)", env::consts::OS, env::consts::ARCH, usize::BITS),
    );
    if let Some(soc) = soc() {
        line("SoC / board", &soc);
    }
}

/// The kernel side of the GPU stack: galcore's version if it has one, then the driver
/// bound to each DRM card. Reads /sys only, so it cannot hang on a driver.
fn gpu_kernel_drivers() -> Vec<String> {
    let mut drivers = Vec::new();
    if fs::metadata("/dev/galcore").is_ok() {
        drivers.push(match read_trimmed("/sys/module/galcore/version") {
            Some(version) => format!("galcore {version}"),
            None => "galcore".to_string(),
        });
    }
    let mut cards: Vec<String> = fs::read_dir("/sys/class/drm")
        .into_iter()
        .flatten()
        .flatten()
        .map(|entry| entry.file_name().to_string_lossy().into_owned())
        .filter(|name| name.starts_with("card") && !name.contains('-'))
        .collect();
    cards.sort();
    for card in cards {
        if let Some(driver) = fs::read_link(format!("/sys/class/drm/{card}/device/driver"))
            .ok()
            .and_then(|link| link.file_name().map(|n| n.to_string_lossy().into_owned()))
        {
            drivers.push(format!("{card}: {driver}"));
        }
    }
    drivers
}

fn enabled_features() -> Vec<&'static str> {
    [
        ("gpu", cfg!(feature = "gpu")),
        ("vulkan", cfg!(feature = "vulkan")),
        ("serve", cfg!(feature = "serve")),
        ("opencl", cfg!(feature = "opencl")),
    ]
    .into_iter()
    .filter_map(|(name, on)| on.then_some(name))
    .collect()
}

/// Everything `info` says about the machine, in one line, for the top of every run's log.
pub fn summary_line() -> String {
    let system = system();
    let mut cpu = format!("{} {}", env::consts::ARCH, cpu_model(system.as_ref()));
    if let Some(range) = cpu_mhz_range() {
        let _ = write!(cpu, " ({range})");
    }
    let mut memory = format!("RAM {}", format_bytes(system.as_ref().map_or(0, System::total_memory)));
    let meminfo = fs::read_to_string("/proc/meminfo").unwrap_or_default();
    if let Some(cma) = meminfo_kib(&meminfo, "CmaTotal").filter(|&v| v > 0) {
        let free = meminfo_kib(&meminfo, "CmaFree").unwrap_or(0);
        let _ = write!(memory, ", CMA {} MB ({} MB free)", cma / 1024, free / 1024);
    }
    let gpu = gpu_kernel_drivers();
    let features = enabled_features();
    let mut parts = vec![
        format!(
            "hodow {} {} [{}]",
            env!("CARGO_PKG_VERSION"),
            if cfg!(debug_assertions) { "debug" } else { "release" },
            if features.is_empty() {
                "no features".to_string()
            } else {
                features.join(",")
            }
        ),
        distro(),
        format!(
            "kernel {}",
            System::kernel_version().unwrap_or_else(|_| "unknown".into())
        ),
        System::host_name().unwrap_or_else(|_| "unknown host".into()),
        cpu,
    ];
    parts.extend(soc());
    parts.push(memory);
    parts.push(if gpu.is_empty() {
        "GPU: no kernel driver found".to_string()
    } else {
        format!("GPU {}", gpu.join(", "))
    });
    parts.join(" | ")
}

fn print_cpu(system: Option<&System>) {
    println!("CPU:");
    line("Model", &cpu_model(system));
    let threads = system.map_or(0, |system| system.cpus().len());
    let topology = match System::physical_core_count() {
        Ok(cores) => format!("{cores} core(s), {threads} thread(s)"),
        Err(_) => format!("{threads} thread(s)"),
    };
    line("Topology", &topology);
    if let Some(range) = cpu_mhz_range() {
        line("Frequency", &range);
    }
}

fn print_memory(system: Option<&System>) {
    println!("Memory:");
    let Some(system) = system else {
        line("Total / available", "unavailable");
        return;
    };
    line(
        "Total / available",
        &format!(
            "{} / {}",
            format_bytes(system.total_memory()),
            format_bytes(system.available_memory())
        ),
    );
    if system.total_swap() > 0 {
        line(
            "Swap total / free",
            &format!(
                "{} / {}",
                format_bytes(system.total_swap()),
                format_bytes(system.free_swap())
            ),
        );
    }
}

fn print_build() {
    println!("Build:");
    line("Version", env!("CARGO_PKG_VERSION"));
    line("Profile", if cfg!(debug_assertions) { "debug" } else { "release" });
    let features = enabled_features();
    line(
        "Cargo features",
        &if features.is_empty() {
            "none".to_string()
        } else {
            features.join(", ")
        },
    );
}

fn print_graphics() {
    println!("Graphics:");
    // Bringing a GL context up logs a screenful through `log` (EGL platform, chosen version,
    // an X-display warning when headless). None of it belongs in the middle of this report,
    // and nothing is lost: both probes return the failure as a `Result` this function prints.
    // ...unless --debug asked for them, which is the whole point when a driver refuses.
    let previous = log::max_level();
    let quiet = previous < log::LevelFilter::Debug;
    if quiet {
        log::set_max_level(log::LevelFilter::Off);
    }

    #[cfg(feature = "gpu")]
    match hodow_gpu::probe_opengl() {
        Ok(gl) => {
            line("OpenGL", &format!("{} - {}", gl.version, gl.renderer));
            line("OpenGL vendor", &gl.vendor);
            line("GLSL", &gl.glsl_version);
        }
        Err(e) => {
            line("OpenGL", "unavailable:");
            for attempt in e.split("; ") {
                line("", &format!("- {attempt}"));
            }
        }
    }
    #[cfg(not(feature = "gpu"))]
    line("OpenGL", "not compiled in (build with --features gpu)");

    #[cfg(feature = "vulkan")]
    match hodow_gpu::vulkan::probe_devices() {
        Ok(devices) if devices.is_empty() => line("Vulkan", "loader present, but no device"),
        Ok(devices) => {
            line("Vulkan", &format!("{} device(s)", devices.len()));
            for d in devices {
                line("", &format!("- {} (API {}, {})", d.name, d.api_version, d.device_type));
            }
        }
        Err(e) => line("Vulkan", &format!("unavailable: {e}")),
    }
    #[cfg(not(feature = "vulkan"))]
    line("Vulkan", "not compiled in (build with --features vulkan)");

    if quiet {
        log::set_max_level(previous);
    }
}

fn print_extensions(verbose: bool) {
    // An extension whose every function was excluded from generation still has a registry
    // entry; it carries no information here.
    let (status, left_out): (Vec<_>, Vec<_>) = extension_status().into_iter().partition(|e| e.test_count > 0);
    let compiled_out: Vec<_> = left_out.iter().filter(|e| e.compiled_out && e.supported).collect();
    let compiled: usize = status.iter().map(|e| e.test_count).sum();
    let runnable = all_tests().len();

    let supported: Vec<_> = status.iter().filter(|e| e.supported).collect();
    let absent: Vec<_> = status.iter().filter(|e| !e.supported && e.detectable).collect();
    let undetectable: Vec<_> = status.iter().filter(|e| !e.detectable).collect();

    println!("CPU extensions:");
    line(
        "Compiled in",
        &format!("{} extension(s), {compiled} test(s)", status.len()),
    );
    line(
        "Supported here",
        &format!("{} extension(s), {runnable} test(s) would run", supported.len()),
    );

    if !compiled_out.is_empty() {
        let names: Vec<_> = compiled_out.iter().map(|e| format!("{}:{}", e.arch, e.ext)).collect();
        line(
            "Not built in",
            &format!("{} (present here, left out by the `avx512` feature)", names.join(" ")),
        );
    }

    let render = |rows: &[&hodow_cpu::ExtensionStatus]| -> String {
        let mut s = String::new();
        for e in rows {
            let _ = write!(&mut s, "{}:{} ({}) ", e.arch, e.ext, e.test_count);
        }
        s.trim_end().to_string()
    };

    if verbose {
        for e in &status {
            let state = match (e.supported, e.detectable) {
                (true, _) => "supported",
                (false, true) => "not present",
                (false, false) => "no detection",
            };
            line(
                &format!("{}:{}", e.arch, e.ext),
                &format!("{state:<13} {} test(s)", e.test_count),
            );
        }
    } else {
        line("Supported", &render(&supported));
        if !absent.is_empty() {
            line("Not present", &render(&absent));
        }
        if !undetectable.is_empty() {
            line("No detection", &render(&undetectable));
        }
    }
}

pub fn process_info(args: &InfoArgs) {
    let system = system();
    print_system();
    print_cpu(system.as_ref());
    print_memory(system.as_ref());
    print_build();
    if !args.no_gpu {
        print_graphics();
    }
    print_extensions(args.verbose);
}

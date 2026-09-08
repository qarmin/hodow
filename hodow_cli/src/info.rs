//! `hodow_cli info` - what this machine is and what this binary can test on it.
//!
//! Everything here is read from `/proc` and `/sys` directly rather than through a
//! system-info crate: the project must stay cross-compilable with no native dependencies,
//! and these files are the same source such a crate would read anyway. Every field is
//! optional - a missing or unreadable file prints `unknown` instead of failing the command.
//!
//! Deliberately does not touch the GPU. Creating an OpenGL context or a Vulkan device is
//! exactly the kind of thing that hangs or crashes on the drivers this tool exists to test,
//! and `info` has to stay something you can run first, safely. Use `hodow_cli vulkan` /
//! `hodow_cli gpu` for that.

use std::collections::BTreeMap;
use std::fmt::Write as _;
use std::{env, fs};

use hodow_core::{all_tests, extension_status};

use crate::cli::InfoArgs;

fn read_trimmed(path: &str) -> Option<String> {
    fs::read_to_string(path).ok().map(|s| s.trim().to_string()).filter(|s| !s.is_empty())
}

/// First value for `key` in a `key: value` file (`/proc/cpuinfo`, `/proc/meminfo`).
fn proc_field(text: &str, key: &str) -> Option<String> {
    text.lines()
        .find(|l| l.split(':').next().is_some_and(|k| k.trim() == key))
        .and_then(|l| l.split_once(':'))
        .map(|(_, v)| v.trim().to_string())
}

fn os_release_pretty_name() -> Option<String> {
    let text = fs::read_to_string("/etc/os-release").ok()?;
    let line = text.lines().find(|l| l.starts_with("PRETTY_NAME="))?;
    Some(line.trim_start_matches("PRETTY_NAME=").trim_matches('"').to_string())
}

fn format_kib(kib: u64) -> String {
    const GIB: f64 = 1024.0 * 1024.0;
    format!("{:.2} GiB", kib as f64 / GIB)
}

fn meminfo_kib(text: &str, key: &str) -> Option<u64> {
    proc_field(text, key)?.split_whitespace().next()?.parse().ok()
}

/// Physical cores from `/proc/cpuinfo`: `cpu cores` is per-package, so it has to be summed
/// over distinct `physical id`s rather than read once, or a dual-socket box reports half.
fn cpu_topology(cpuinfo: &str) -> (usize, Option<usize>) {
    let threads = cpuinfo.lines().filter(|l| l.starts_with("processor")).count();
    let mut per_package: BTreeMap<String, usize> = BTreeMap::new();
    let mut current_package: Option<String> = None;
    for line in cpuinfo.lines() {
        let Some((key, value)) = line.split_once(':') else { continue };
        match key.trim() {
            "physical id" => current_package = Some(value.trim().to_string()),
            "cpu cores" => {
                if let Ok(n) = value.trim().parse() {
                    per_package.insert(current_package.clone().unwrap_or_default(), n);
                }
            }
            _ => {}
        }
    }
    let cores: usize = per_package.values().sum();
    (threads, (cores > 0).then_some(cores))
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
    line("Host", &read_trimmed("/proc/sys/kernel/hostname").unwrap_or_else(|| "unknown".into()));
    line("Kernel", &read_trimmed("/proc/sys/kernel/osrelease").unwrap_or_else(|| "unknown".into()));
    line("Distro", &os_release_pretty_name().unwrap_or_else(|| "unknown".into()));
    line("OS / arch", &format!("{} / {} ({}-bit)", env::consts::OS, env::consts::ARCH, usize::BITS));
}

fn print_cpu() {
    let cpuinfo = fs::read_to_string("/proc/cpuinfo").unwrap_or_default();
    println!("CPU:");
    // "model name" on x86, "Model" on some arm64 kernels; neither exists on others.
    let model = proc_field(&cpuinfo, "model name")
        .or_else(|| proc_field(&cpuinfo, "Model"))
        .or_else(|| proc_field(&cpuinfo, "Hardware"))
        .unwrap_or_else(|| "unknown".into());
    line("Model", &model);
    let (threads, cores) = cpu_topology(&cpuinfo);
    let topology = match cores {
        Some(c) => format!("{c} core(s), {threads} thread(s)"),
        None => format!("{threads} thread(s)"),
    };
    line("Topology", &topology);
    if let Some(range) = cpu_mhz_range() {
        line("Frequency", &range);
    }
}

fn print_memory() {
    let Ok(meminfo) = fs::read_to_string("/proc/meminfo") else { return };
    let (Some(total), Some(available)) = (meminfo_kib(&meminfo, "MemTotal"), meminfo_kib(&meminfo, "MemAvailable")) else {
        return;
    };
    println!("Memory:");
    line("Total / available", &format!("{} / {}", format_kib(total), format_kib(available)));
}

fn print_build() {
    println!("Build:");
    line("Version", env!("CARGO_PKG_VERSION"));
    line("Profile", if cfg!(debug_assertions) { "debug" } else { "release" });
    let mut features = Vec::new();
    for (name, on) in [("gpu", cfg!(feature = "gpu")), ("vulkan", cfg!(feature = "vulkan")), ("serve", cfg!(feature = "serve"))] {
        if on {
            features.push(name);
        }
    }
    line("Cargo features", &if features.is_empty() { "none".to_string() } else { features.join(", ") });
}

fn print_graphics() {
    println!("Graphics:");
    // Bringing a GL context up logs a screenful through `log` (EGL platform, chosen version,
    // an X-display warning when headless). None of it belongs in the middle of this report,
    // and nothing is lost: both probes return the failure as a `Result` this function prints.
    let previous = log::max_level();
    log::set_max_level(log::LevelFilter::Off);

    #[cfg(feature = "gpu")]
    match hodow_core::probe_opengl() {
        Ok(gl) => {
            line("OpenGL", &format!("{} - {}", gl.version, gl.renderer));
            line("OpenGL vendor", &gl.vendor);
            line("GLSL", &gl.glsl_version);
            line("OpenGL via", &gl.attempt);
        }
        Err(e) => {
            line("OpenGL", "unavailable - every combination refused:");
            for attempt in e.split("; ") {
                line("", &format!("- {attempt}"));
            }
        }
    }
    #[cfg(not(feature = "gpu"))]
    line("OpenGL", "not compiled in (build with --features gpu)");

    #[cfg(feature = "vulkan")]
    match hodow_core::vulkan::probe_devices() {
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

    log::set_max_level(previous);
}

fn print_extensions(verbose: bool) {
    // An extension whose every function was excluded from generation still has a registry
    // entry; it carries no information here.
    let status: Vec<_> = extension_status().into_iter().filter(|e| e.test_count > 0).collect();
    let compiled: usize = status.iter().map(|e| e.test_count).sum();
    let runnable = all_tests().len();

    let supported: Vec<_> = status.iter().filter(|e| e.supported).collect();
    let absent: Vec<_> = status.iter().filter(|e| !e.supported && e.detectable).collect();
    let undetectable: Vec<_> = status.iter().filter(|e| !e.detectable).collect();

    println!("CPU extensions:");
    line("Compiled in", &format!("{} extension(s), {compiled} test(s)", status.len()));
    line("Supported here", &format!("{} extension(s), {runnable} test(s) would run", supported.len()));

    let render = |rows: &[&hodow_core::ExtensionStatus]| -> String {
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
            line(&format!("{}:{}", e.arch, e.ext), &format!("{state:<13} {} test(s)", e.test_count));
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
    print_system();
    print_cpu();
    print_memory();
    print_build();
    if !args.no_gpu {
        print_graphics();
    }
    print_extensions(args.verbose);
}

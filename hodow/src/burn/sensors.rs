//! Once-a-second readings of what the burn is doing to the machine: temperatures with
//! their trip points, per-core clock and load, memory, and GPU load where the kernel
//! exports it. Everything comes from /proc and /sys; nothing here touches /dev/mem.

use std::path::{Path, PathBuf};

use serde::{Deserialize, Serialize};

const MAX_TEMP_SENSORS: usize = 24;

#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct Sample {
    pub t: f64,
    pub temps: Vec<Option<f32>>,
    pub load: Vec<f32>,
    pub freq_mhz: Vec<u32>,
    pub mem_used_mb: u64,
    pub mem_available_mb: u64,
    pub cma_free_mb: Option<u64>,
    pub gpu_load: Option<f32>,
}

impl Sample {
    pub fn max_temp(&self) -> Option<f32> {
        self.temps.iter().flatten().copied().reduce(f32::max)
    }
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct Trip {
    pub sensor: usize,
    pub kind: String,
    pub celsius: f32,
}

#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct SensorInfo {
    pub temp_names: Vec<String>,
    pub trips: Vec<Trip>,
    pub cpus: usize,
    pub mem_total_mb: u64,
    pub cma_total_mb: Option<u64>,
    pub gpu_load_source: Option<String>,
}

pub struct Sensors {
    temp_paths: Vec<PathBuf>,
    previous_stat: Vec<(u64, u64)>,
    gpu: GpuLoad,
}

enum GpuLoad {
    None,
    Sysfs(PathBuf),
}

fn read(path: impl AsRef<Path>) -> Option<String> {
    std::fs::read_to_string(path).ok().map(|s| s.trim().to_string())
}

fn sorted_dir(dir: &str, prefix: &str) -> Vec<PathBuf> {
    let mut paths: Vec<PathBuf> = std::fs::read_dir(dir).map_or_default(|it| {
        it.flatten()
            .map(|e| e.path())
            .filter(|p| p.file_name().is_some_and(|n| n.to_string_lossy().starts_with(prefix)))
            .collect()
    });
    paths.sort_by_key(|p| {
        let name = p.file_name().map_or_default(|n| n.to_string_lossy().into_owned());
        let digits: String = name.chars().filter(|c| c.is_ascii_digit()).collect();
        (digits.parse::<u64>().unwrap_or(0), name)
    });
    paths
}

pub fn meminfo_mb(key: &str) -> Option<u64> {
    std::fs::read_to_string("/proc/meminfo")
        .ok()?
        .lines()
        .find_map(|l| {
            l.strip_prefix(key)?
                .strip_prefix(':')
                .map(|v| v.trim().trim_end_matches("kB").trim().to_string())
        })?
        .parse::<u64>()
        .ok()
        .map(|kb| kb / 1024)
}

impl Sensors {
    pub fn discover() -> (Self, SensorInfo) {
        let mut temp_paths = Vec::new();
        let mut info = SensorInfo::default();
        for zone in sorted_dir("/sys/class/thermal", "thermal_zone") {
            if temp_paths.len() >= MAX_TEMP_SENSORS || read(zone.join("temp")).is_none() {
                continue;
            }
            let sensor = temp_paths.len();
            for trip in 0..16 {
                let (Some(kind), Some(temp)) = (
                    read(zone.join(format!("trip_point_{trip}_type"))),
                    read(zone.join(format!("trip_point_{trip}_temp"))),
                ) else {
                    break;
                };
                // Unused trip points read back as absurd values (-273.2, -2147483.6).
                if matches!(kind.as_str(), "passive" | "hot" | "critical")
                    && let Ok(milli) = temp.parse::<f32>()
                    && (20_000.0..=200_000.0).contains(&milli)
                {
                    info.trips.push(Trip {
                        sensor,
                        kind,
                        celsius: milli / 1000.0,
                    });
                }
            }
            info.temp_names
                .push(read(zone.join("type")).unwrap_or_else(|| zone.display().to_string()));
            temp_paths.push(zone.join("temp"));
        }
        for hwmon in sorted_dir("/sys/class/hwmon", "hwmon") {
            let name = read(hwmon.join("name")).unwrap_or_else(|| "hwmon".into());
            for input in sorted_dir(&hwmon.to_string_lossy(), "temp")
                .into_iter()
                .filter(|p| p.to_string_lossy().ends_with("_input"))
            {
                if temp_paths.len() >= MAX_TEMP_SENSORS {
                    break;
                }
                let label_path = input.to_string_lossy().replace("_input", "_label");
                let label = read(&label_path).unwrap_or_else(|| {
                    input
                        .file_name()
                        .map_or_default(|n| n.to_string_lossy().replace("_input", ""))
                });
                info.temp_names.push(format!("{name} {label}"));
                temp_paths.push(input);
            }
        }
        info.cpus = read_stat().len();
        info.mem_total_mb = meminfo_mb("MemTotal").unwrap_or(0);
        info.cma_total_mb = meminfo_mb("CmaTotal").filter(|&mb| mb > 0);
        let gpu = discover_gpu_load();
        info.gpu_load_source = match &gpu {
            GpuLoad::None => None,
            GpuLoad::Sysfs(path) => Some(path.display().to_string()),
        };
        let sensors = Self {
            temp_paths,
            previous_stat: read_stat(),
            gpu,
        };
        (sensors, info)
    }

    pub fn sample(&mut self, t: f64) -> Sample {
        let stat = read_stat();
        let load = stat
            .iter()
            .zip(&self.previous_stat)
            .map(|(&(busy, total), &(pbusy, ptotal))| {
                let dt = total.saturating_sub(ptotal);
                if dt == 0 {
                    0.0
                } else {
                    busy.saturating_sub(pbusy) as f32 * 100.0 / dt as f32
                }
            })
            .collect();
        self.previous_stat = stat;
        let available = meminfo_mb("MemAvailable").unwrap_or(0);
        Sample {
            t,
            temps: self
                .temp_paths
                .iter()
                .map(|p| read(p).and_then(|s| s.parse::<f32>().ok()).map(|m| m / 1000.0))
                .collect(),
            load,
            freq_mhz: (0..self.previous_stat.len())
                .map(|cpu| {
                    read(format!("/sys/devices/system/cpu/cpu{cpu}/cpufreq/scaling_cur_freq"))
                        .and_then(|s| s.parse::<u32>().ok())
                        .map_or(0, |khz| khz / 1000)
                })
                .collect(),
            mem_used_mb: meminfo_mb("MemTotal").unwrap_or(0).saturating_sub(available),
            mem_available_mb: available,
            cma_free_mb: meminfo_mb("CmaTotal")
                .filter(|&t| t > 0)
                .and_then(|_| meminfo_mb("CmaFree")),
            gpu_load: match &self.gpu {
                GpuLoad::None => None,
                GpuLoad::Sysfs(path) => read(path).and_then(|s| s.parse().ok()),
            },
        }
    }
}

/// Per-cpu (busy, total) jiffies from /proc/stat, in cpu order.
fn read_stat() -> Vec<(u64, u64)> {
    std::fs::read_to_string("/proc/stat")
        .unwrap_or_default()
        .lines()
        .filter(|l| l.starts_with("cpu") && l.as_bytes().get(3).is_some_and(u8::is_ascii_digit))
        .map(|l| {
            let fields: Vec<u64> = l.split_whitespace().skip(1).filter_map(|f| f.parse().ok()).collect();
            let total: u64 = fields.iter().sum();
            let idle = fields.get(3).copied().unwrap_or(0) + fields.get(4).copied().unwrap_or(0);
            (total - idle, total)
        })
        .collect()
}

fn discover_gpu_load() -> GpuLoad {
    for card in sorted_dir("/sys/class/drm", "card") {
        let busy = card.join("device/gpu_busy_percent");
        if busy.exists() {
            return GpuLoad::Sysfs(busy);
        }
    }
    GpuLoad::None
}

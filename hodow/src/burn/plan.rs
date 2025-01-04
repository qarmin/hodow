//! Which rows run, in which order, and how much of `--duration` each one gets.

use std::time::Duration;

use super::protocol::{CpuTest, GpuTest, MemTest};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Phase {
    Cpu,
    Memory,
    Gpu,
    Combined,
}

impl Phase {
    pub const ALL: [Self; 4] = [Self::Cpu, Self::Memory, Self::Gpu, Self::Combined];

    pub fn key(self) -> &'static str {
        match self {
            Self::Cpu => "cpu",
            Self::Memory => "memory",
            Self::Gpu => "gpu",
            Self::Combined => "combined",
        }
    }

    pub fn title(self) -> &'static str {
        match self {
            Self::Cpu => "CPU",
            Self::Memory => "MEMORY",
            Self::Gpu => "GPU",
            Self::Combined => "COMBINED",
        }
    }

    fn weight(self) -> u32 {
        match self {
            Self::Cpu | Self::Gpu => 20,
            Self::Memory | Self::Combined => 30,
        }
    }
}

#[derive(Clone, Copy, Debug)]
pub enum Part {
    Cpu(CpuTest),
    Memory(MemTest),
    Gpu(GpuTest),
}

#[derive(Clone, Debug)]
pub struct Row {
    pub phase: Phase,
    pub name: String,
    pub parts: Vec<Part>,
    pub budget: Duration,
}

fn gpu_tests() -> Vec<GpuTest> {
    let mut tests = vec![GpuTest::Memory, GpuTest::Alu, GpuTest::Render, GpuTest::Contexts];
    if cfg!(feature = "vulkan") {
        tests.push(GpuTest::Vulkan);
    }
    tests
}

/// The three combinations of the combined phase: most power, most bus traffic, a mix.
const COMBINED: [(CpuTest, MemTest, GpuTest); 3] = [
    (CpuTest::MaxPower, MemTest::RandomValue, GpuTest::Alu),
    (CpuTest::InstructionSuite, MemTest::BlockCopy, GpuTest::Memory),
    (CpuTest::IntegerCache, MemTest::WalkingOnes, GpuTest::Render),
];

pub fn phases(only: &[String], skip: &[String]) -> Result<Vec<Phase>, String> {
    for name in only.iter().chain(skip) {
        if !Phase::ALL.iter().any(|p| p.key() == name) {
            return Err(format!("unknown phase '{name}' - use cpu, memory, gpu, combined"));
        }
    }
    let selected: Vec<Phase> = Phase::ALL
        .into_iter()
        .filter(|p| only.is_empty() || only.iter().any(|o| o == p.key()))
        .filter(|p| !skip.iter().any(|s| s == p.key()))
        .collect();
    if selected.is_empty() {
        return Err("--only/--skip left no phase to run".into());
    }
    Ok(selected)
}

pub fn build(phases: &[Phase], total: Duration, quick: bool) -> Vec<Row> {
    let with_gpu = phases.contains(&Phase::Gpu);
    let mut rows: Vec<Row> = Vec::new();
    for &phase in phases {
        let parts: Vec<(String, Vec<Part>)> = match phase {
            Phase::Cpu => [CpuTest::InstructionSuite, CpuTest::MaxPower, CpuTest::IntegerCache]
                .into_iter()
                .map(|t| (format!("CPU: {}", t.name()), vec![Part::Cpu(t)]))
                .collect(),
            Phase::Memory => MemTest::ALL
                .into_iter()
                .map(|t| (format!("MEMORY: {}", t.name()), vec![Part::Memory(t)]))
                .collect(),
            Phase::Gpu => gpu_tests()
                .into_iter()
                .map(|t| (format!("GPU: {}", t.name()), vec![Part::Gpu(t)]))
                .collect(),
            Phase::Combined => COMBINED
                .iter()
                .enumerate()
                .map(|(i, &(c, m, g))| {
                    let mut parts = vec![Part::Cpu(c), Part::Memory(m)];
                    let mut name = format!("COMBINED #{}: {} + {}", i + 1, c.name(), m.name());
                    if with_gpu {
                        parts.push(Part::Gpu(g));
                        name.push_str(&format!(" + GPU {}", g.name()));
                    }
                    (name, parts)
                })
                .collect(),
        };
        let weight_sum: u32 = phases.iter().map(|p| p.weight()).sum();
        let phase_budget = total.mul_f64(phase.weight() as f64 / weight_sum as f64);
        let per_row = if quick {
            Duration::ZERO
        } else {
            phase_budget / parts.len() as u32
        };
        rows.extend(parts.into_iter().map(|(name, parts)| Row {
            phase,
            name,
            parts,
            budget: per_row,
        }));
    }
    rows
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn budgets_add_up_to_the_duration() {
        let rows = build(&Phase::ALL, Duration::from_secs(600), false);
        let total: Duration = rows.iter().map(|r| r.budget).sum();
        assert!((total.as_secs_f64() - 600.0).abs() < 1.0, "{total:?}");
        let rows = build(&[Phase::Memory], Duration::from_secs(60), false);
        let total: Duration = rows.iter().map(|r| r.budget).sum();
        assert!((total.as_secs_f64() - 60.0).abs() < 1.0);
    }

    #[test]
    fn phase_names_are_checked() {
        phases(&["gpu".into()], &[]).unwrap();
        phases(&["ram".into()], &[]).unwrap_err();
        phases(&[], &["cpu".into(), "memory".into(), "gpu".into(), "combined".into()]).unwrap_err();
    }
}

//! What the orchestrator tells a worker, and the lines a worker answers with on stdout.
//!
//! One JSON object per line behind a fixed prefix, so whatever a driver prints on its own
//! is simply not a message.

use std::io::Write;
use std::sync::Mutex;
use std::time::{Duration, Instant};

use serde::{Deserialize, Serialize};

pub const PREFIX: &str = "@burn ";

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum MemTest {
    StuckAddress,
    RandomValue,
    CompareXor,
    CompareSub,
    CompareMul,
    CompareDiv,
    CompareOr,
    CompareAnd,
    SequentialIncrement,
    SolidBits,
    BlockSequential,
    Checkerboard,
    BitSpread,
    BitFlip,
    WalkingOnes,
    WalkingZeroes,
    MovingInversions,
    BlockCopy,
}

impl MemTest {
    pub const ALL: [MemTest; 18] = [
        MemTest::StuckAddress,
        MemTest::RandomValue,
        MemTest::CompareXor,
        MemTest::CompareSub,
        MemTest::CompareMul,
        MemTest::CompareDiv,
        MemTest::CompareOr,
        MemTest::CompareAnd,
        MemTest::SequentialIncrement,
        MemTest::SolidBits,
        MemTest::BlockSequential,
        MemTest::Checkerboard,
        MemTest::BitSpread,
        MemTest::BitFlip,
        MemTest::WalkingOnes,
        MemTest::WalkingZeroes,
        MemTest::MovingInversions,
        MemTest::BlockCopy,
    ];

    pub fn name(self) -> &'static str {
        match self {
            MemTest::StuckAddress => "Stuck Address",
            MemTest::RandomValue => "Random Value",
            MemTest::CompareXor => "Compare XOR",
            MemTest::CompareSub => "Compare SUB",
            MemTest::CompareMul => "Compare MUL",
            MemTest::CompareDiv => "Compare DIV",
            MemTest::CompareOr => "Compare OR",
            MemTest::CompareAnd => "Compare AND",
            MemTest::SequentialIncrement => "Sequential Increment",
            MemTest::SolidBits => "Solid Bits",
            MemTest::BlockSequential => "Block Sequential",
            MemTest::Checkerboard => "Checkerboard",
            MemTest::BitSpread => "Bit Spread",
            MemTest::BitFlip => "Bit Flip",
            MemTest::WalkingOnes => "Walking Ones",
            MemTest::WalkingZeroes => "Walking Zeroes",
            MemTest::MovingInversions => "Moving Inversions",
            MemTest::BlockCopy => "Block Copy",
        }
    }
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum CpuTest {
    InstructionSuite,
    MaxPower,
    IntegerCache,
}

impl CpuTest {
    pub fn name(self) -> &'static str {
        match self {
            CpuTest::InstructionSuite => "Instruction suite",
            CpuTest::MaxPower => "Max power",
            CpuTest::IntegerCache => "Integer & cache",
        }
    }
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum GpuTest {
    Memory,
    Alu,
    Render,
    Contexts,
    Vulkan,
}

impl GpuTest {
    pub fn name(self) -> &'static str {
        match self {
            GpuTest::Memory => "Memory patterns",
            GpuTest::Alu => "Compute ALU",
            GpuTest::Render => "Render & readback",
            GpuTest::Contexts => "Contexts from 4 threads",
            GpuTest::Vulkan => "Vulkan compute",
        }
    }
}

#[derive(Serialize, Deserialize, Clone, Debug)]
#[serde(tag = "kind", rename_all = "snake_case")]
pub enum Job {
    Memory {
        test: MemTest,
        mb: u64,
    },
    Cpu {
        test: CpuTest,
    },
    /// `cap_mb` is the GPU's share of a budget it splits with a memory test running alongside.
    Gpu {
        test: GpuTest,
        mb: Option<u64>,
        cap_mb: Option<u64>,
    },
    /// `--selftest` only: the three ways a worker can fail the orchestrator must notice.
    SelfCrash,
    SelfHang,
    SelfNoResult,
}

impl Job {
    pub fn role(&self) -> &'static str {
        match self {
            Job::Memory { .. } => "memory",
            Job::Cpu { .. } => "cpu",
            Job::Gpu { .. } => "gpu",
            Job::SelfCrash | Job::SelfHang | Job::SelfNoResult => "selftest",
        }
    }
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct WorkerSpec {
    pub job: Job,
    pub budget_ms: u64,
    pub cores: Vec<usize>,
    pub inject: bool,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum WorkerVerdict {
    Ok,
    Error,
    Skip,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
#[serde(tag = "t", rename_all = "snake_case")]
pub enum Msg {
    /// Work moved forward; only sent when it did, so silence means no progress.
    Beat {
        work: u64,
    },
    Warn {
        msg: String,
    },
    Done {
        verdict: WorkerVerdict,
        detail: String,
        errors: u64,
        samples: Vec<String>,
    },
}

static OUT: Mutex<()> = Mutex::new(());

pub fn send(msg: &Msg) {
    let line = serde_json::to_string(msg).expect("protocol message serializes");
    let _guard = OUT.lock().unwrap_or_else(|e| e.into_inner());
    let mut out = std::io::stdout().lock();
    let _ = writeln!(out, "{PREFIX}{line}");
    let _ = out.flush();
}

pub fn parse(line: &str) -> Option<Msg> {
    serde_json::from_str(line.strip_prefix(PREFIX)?).ok()
}

/// Sends a `Beat` for `work`, but at most every 200 ms.
pub struct Beater {
    last: Instant,
    work: u64,
}

impl Beater {
    pub fn new() -> Self {
        Beater {
            last: Instant::now() - Duration::from_secs(1),
            work: 0,
        }
    }

    pub fn beat(&mut self) {
        self.work += 1;
        if self.last.elapsed() >= Duration::from_millis(200) {
            self.last = Instant::now();
            send(&Msg::Beat { work: self.work });
        }
    }
}

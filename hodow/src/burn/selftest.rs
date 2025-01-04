//! `--selftest`: every sub-test with a fault injected, plus the three ways a worker can let
//! the orchestrator down. A detector wired up wrong and a machine with nothing wrong look
//! the same from a clean run, so this is what makes a clean run mean something.

use std::time::Duration;

use super::orchestrator::allowed_cpus;
use super::protocol::{CpuTest, GpuTest, Job, MemTest, WorkerSpec};
use super::supervise::{self, Control, Status};
use super::ui::Ui;

const MEMORY_MB: u64 = 16;
const HANG_TIMEOUT: Duration = Duration::from_secs(3);

struct Case {
    label: String,
    job: Job,
    inject: bool,
    expect: Status,
}

fn cases() -> Vec<Case> {
    let case = |label: String, job: Job, inject: bool, expect: Status| Case {
        label,
        job,
        inject,
        expect,
    };
    let mut cases = Vec::new();
    for test in MemTest::ALL {
        cases.push(case(
            format!("MEMORY: {} catches a flipped bit", test.name()),
            Job::Memory { test, mb: MEMORY_MB },
            true,
            Status::Error,
        ));
    }
    cases.push(case(
        "MEMORY: Random Value is clean without a fault".into(),
        Job::Memory {
            test: MemTest::RandomValue,
            mb: MEMORY_MB,
        },
        false,
        Status::Ok,
    ));
    for test in [CpuTest::InstructionSuite, CpuTest::MaxPower, CpuTest::IntegerCache] {
        cases.push(case(
            format!("CPU: {} catches a wrong result", test.name()),
            Job::Cpu { test },
            true,
            Status::Error,
        ));
    }
    cases.push(case(
        "CPU: Max power is clean without a fault".into(),
        Job::Cpu {
            test: CpuTest::MaxPower,
        },
        false,
        Status::Ok,
    ));
    let mut gpu = vec![GpuTest::Memory, GpuTest::Alu, GpuTest::Render, GpuTest::Contexts];
    if cfg!(feature = "vulkan") {
        gpu.push(GpuTest::Vulkan);
    }
    for test in gpu {
        cases.push(case(
            format!("GPU: {} catches a wrong word", test.name()),
            Job::Gpu {
                test,
                mb: Some(16),
                cap_mb: None,
            },
            true,
            Status::Error,
        ));
    }
    cases.push(case(
        "GPU: Compute ALU is clean without a fault".into(),
        Job::Gpu {
            test: GpuTest::Alu,
            mb: None,
            cap_mb: None,
        },
        false,
        Status::Ok,
    ));
    cases.push(case(
        "worker killed by SIGSEGV is a crash".into(),
        Job::SelfCrash,
        false,
        Status::Crash,
    ));
    cases.push(case(
        "silent worker is a hang".into(),
        Job::SelfHang,
        false,
        Status::Hang,
    ));
    cases.push(case(
        "worker exiting without a result is a crash".into(),
        Job::SelfNoResult,
        false,
        Status::Crash,
    ));
    cases
}

pub fn run() -> i32 {
    let ui = Ui::new();
    let cores: Vec<usize> = allowed_cpus().into_iter().take(2).collect();
    println!(
        "{}",
        ui.header("hodow burn --selftest: every detector against a fault it must catch")
    );
    let (mut wrong, mut unverified) = (0, 0);
    for case in cases() {
        let spec = WorkerSpec {
            job: case.job,
            budget_ms: 0,
            cores: cores.clone(),
            inject: case.inject,
        };
        let outcome = supervise::run_parts(vec![spec], HANG_TIMEOUT, || Control::Continue).remove(0);
        let line = format!(
            "{} - expected {:?}, got {:?}: {}",
            case.label, case.expect, outcome.status, outcome.detail
        );
        if outcome.status == case.expect {
            println!("{}{line}", ui.tag(Status::Ok));
        } else if outcome.status == Status::Skip {
            unverified += 1;
            println!("{}{line}", ui.tag(Status::Skip));
        } else {
            wrong += 1;
            println!("{}{line}", ui.tag(Status::Error));
            for sample in outcome.samples.iter().take(3) {
                println!("          {sample}");
            }
        }
    }
    if wrong > 0 {
        println!(
            "{}",
            ui.red(&format!(
                "\nSELFTEST FAILED: {wrong} detector(s) did not give the expected verdict"
            ))
        );
        1
    } else {
        let note = if unverified > 0 {
            format!(" ({unverified} could not be checked here - no driver for them)")
        } else {
            String::new()
        };
        println!("{}", ui.green(&format!("\nSELFTEST PASSED{note}")));
        0
    }
}

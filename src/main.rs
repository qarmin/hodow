#![allow(unused)]
use std::env;
use std::fmt::Write as _;

use clap::Parser;
use log::info;
use once_cell::sync::OnceCell;

use crate::cpu::{available_modes, set_iterations, test_all_extensions};

mod cpu;

static FUZZING: OnceCell<bool> = OnceCell::new();

pub fn get_fuzzing() -> bool {
    if FUZZING.get().is_none() {
        FUZZING.set(true).unwrap();
    }

    *FUZZING.get().expect("FUZZING not initialized")
}

pub fn get_fuzzer() -> bool {
    get_fuzzing()
}

fn print_build_info() {
    let arch = env::consts::ARCH;
    let os = env::consts::OS;
    let mut info = String::new();
    let _ = write!(&mut info, "arch={}, os={}", arch, os);

    if let Ok(profile) = env::var("PROFILE") {
        let _ = write!(&mut info, ", profile={}", profile);
    }

    info!("Build info: {}", info);
}

#[derive(Parser)]
#[command(name = "work_tester")]
#[command(about = "CPU SIMD instruction set tester", version = "0.1")]
struct Args {
    #[arg(short = 'n', long = "iterations")]
    iterations: Option<usize>,

    #[arg(short = 'l', long = "list-modes")]
    list_modes: bool,
}

fn main() {
    if !cfg!(feature = "no_logging") {
        handsome_logger::init().unwrap();
    }

    let args = Args::parse();

    if let Some(nv) = args.iterations {
        set_iterations(nv);
    }

    print_build_info();

    if args.list_modes {
        let modes = available_modes();
        info!("Available modes: {:?}", modes);
        return;
    }

    if let Err(e) = test_all_extensions() {
        log::error!("Running tests failed: {}", e);
    }
}

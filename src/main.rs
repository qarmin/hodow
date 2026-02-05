use std::env;
use std::fmt::Write as _;

use clap::Parser;
use log::info;
use once_cell::sync::OnceCell;
use rand::random;

use crate::cpu::{available_modes, set_iterations, test_all_extensions};

mod cpu;

static FUZZING: OnceCell<bool> = OnceCell::new();

pub fn get_fuzzing() -> bool {
    if FUZZING.get().is_none() {
        FUZZING.set(true).unwrap();
    }

    *FUZZING.get().expect("FUZZING not initialized")
}

fn print_build_info() {
    // CPU arch
    let arch = env::consts::ARCH;
    let os = env::consts::OS;
    let mut info = String::new();
    let _ = write!(&mut info, "arch={}, os={}", arch, os);

    // rustc envs
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

pub fn get_random_float() -> f32 {
    match random::<u8>() % 12 {
        0 => f32::INFINITY,
        1 => f32::NEG_INFINITY,
        2 => f32::NAN,
        3..8 => random::<f32>() * 10000000.0,
        _ => random::<f32>() * 100000.0,
    }
}

pub fn get_random_float32_array<const N: usize>() -> [f32; N] {
    let mut arr = [0.0; N];
    for item in arr.iter_mut() {
        *item = get_random_float();
    }
    arr
}
pub fn get_random_float64_array<const N: usize>() -> [f64; N] {
    let mut arr = [0.0; N];
    for item in arr.iter_mut() {
        *item = get_random_float() as f64;
    }
    arr
}

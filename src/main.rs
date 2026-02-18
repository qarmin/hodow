#![allow(incomplete_features)]
#![feature(f16)]

use std::env;
use std::fmt::Write as _;

use clap::Parser;
use handsome_logger::ConfigBuilder;
use log::info;
use once_cell::sync::OnceCell;

#[macro_use]
mod test_macros;
mod cpu;
mod macross;

use crate::cpu::{available_modes, set_iterations, set_skip_tests, test_all_extensions};

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

    /// Skip specific tests by name (can be repeated or comma-separated)
    #[arg(short = 's', long = "skip", value_delimiter = ',', num_args = 1..)]
    skip: Vec<String>,
}

fn main() {
    if !cfg!(feature = "no_logging") {
        let config = ConfigBuilder::new().set_format_text(handsome_logger::FormatText::DefaultWithFileNameC.get(), None).build();
        handsome_logger::TermLogger::init(config, Default::default(), Default::default()).expect("Failed to initialize logger");
    }

    let args = Args::parse();

    if let Some(nv) = args.iterations {
        set_iterations(nv);
    }

    if !args.skip.is_empty() {
        set_skip_tests(args.skip);
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

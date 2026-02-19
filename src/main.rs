#![allow(incomplete_features)]

use std::env;
use std::fmt::Write as _;

use clap::Parser;
use handsome_logger::ConfigBuilder;
use log::info;
use once_cell::sync::OnceCell;

mod cli;
mod cpu;

use crate::cli::Args;
use crate::cpu::{available_modes, list_all_functions, set_iterations, set_skip_tests, test_all_extensions};

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

fn main() {
    if !cfg!(feature = "miri_build") {
        let config = ConfigBuilder::new().set_format_text(handsome_logger::FormatText::DefaultWithFileNameC.get(), None).build();
        handsome_logger::TermLogger::init(config, Default::default(), Default::default()).expect("Failed to initialize logger");
    } else {
        let config = ConfigBuilder::new().set_format_text(handsome_logger::FormatText::LevelMessageC.get(), None).build();
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
        println!("Clean exit");
        return;
    }

    if args.list_functions {
        let functions = list_all_functions();
        info!("Available test functions ({} total):", functions.len());
        for func in functions {
            println!("  {}", func);
        }
        println!("Clean exit");
        return;
    }

    if let Some(ref function_names) = args.test_function {
        // When testing specific functions, skip all other functions
        let all_functions = list_all_functions();
        let test_set: std::collections::HashSet<String> = function_names.iter().cloned().collect();
        let skip_list: Vec<String> = all_functions
            .into_iter()
            .filter(|f| !test_set.contains(f))
            .collect();

        set_skip_tests(skip_list);

        info!("Testing {} specific function(s)", function_names.len());

        if let Err(e) = test_all_extensions() {
            log::error!("Testing functions failed: {}", e);
            std::process::exit(1);
        }
        return;
    }

    if let Err(e) = test_all_extensions() {
        log::error!("Running tests failed: {}", e);
    }

    println!("Clean exit");
}



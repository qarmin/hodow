use clap::Parser;

#[derive(Parser)]
#[command(name = "work_tester")]
#[command(about = "CPU SIMD instruction set tester", version = "0.1")]
pub struct Args {
    #[arg(short = 'n', long = "iterations")]
    pub iterations: Option<usize>,

    #[arg(short = 'l', long = "list-modes")]
    pub list_modes: bool,

    #[arg(short = 'f', long = "list-functions")]
    pub list_functions: bool,

    #[arg(short = 't', long = "test-function", num_args = 1..)]
    pub test_function: Option<Vec<String>>,

    #[arg(short = 's', long = "skip", value_delimiter = ',', num_args = 1..)]
    pub skip: Vec<String>,

    #[arg(short = 'd', long = "debug")]
    pub debug: bool,

    #[arg(short = 'g', long = "gpu")]
    pub gpu: bool,

    // New GUI-related flags. The CLI exposes them but does not depend on winit.
    #[arg(long = "gui")]
    pub gui: bool,

    #[arg(long = "window-size")]
    pub window_size: Option<String>,

    #[arg(long = "window-title")]
    pub window_title: Option<String>,

    #[arg(long = "per-test-window")]
    pub per_test_window: bool,
}

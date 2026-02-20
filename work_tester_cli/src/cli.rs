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

    /// Run GUI/GPU-backed tests (try to initialize OpenGL and run GPU tests)
    #[arg(short = 'g', long = "gui")]
    pub gui: bool,
}

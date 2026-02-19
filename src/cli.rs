use clap::Parser;

#[derive(Parser)]
#[command(name = "work_tester")]
#[command(about = "CPU SIMD instruction set tester", version = "0.1")]
pub struct Args {
    /// Number of fuzzing iterations per test
    #[arg(short = 'n', long = "iterations")]
    pub iterations: Option<usize>,

    /// List all available testing modes
    #[arg(short = 'l', long = "list-modes")]
    pub list_modes: bool,

    /// List all available test functions
    #[arg(long = "list-functions")]
    pub list_functions: bool,

    /// Test a specific function by name (e.g., _mm_add_ps)
    #[arg(short = 't', long = "test-function")]
    pub test_function: Option<String>,

    /// Skip specific tests by name (can be repeated or comma-separated)
    #[arg(short = 's', long = "skip", value_delimiter = ',', num_args = 1..)]
    pub skip: Vec<String>,
}


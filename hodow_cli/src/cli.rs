use clap::{Args, Parser, Subcommand};

#[derive(Parser)]
#[command(name = "hodow_cli", about = "CPU / GPU workload tester", version = "0.1")]
pub struct Cli {
    /// Enable verbose debug logging
    #[arg(short = 'd', long = "debug", global = true)]
    pub debug: bool,

    #[command(subcommand)]
    pub command: Commands,
}

#[derive(Subcommand)]
pub enum Commands {
    /// Run CPU SIMD instruction-set tests
    Cpu(CpuArgs),
    /// Run OpenGL GPU tests
    Gpu(GpuArgs),
    /// Run Vulkan compute validation on every Vulkan device
    Vulkan(VulkanArgs),
    /// Run a persistent job-queue server with a web dashboard
    #[cfg(feature = "serve")]
    Serve(ServeArgs),
}

// ── Serve ───────────────────────────────────────────────────────────────────

#[cfg(feature = "serve")]
#[derive(Args)]
pub struct ServeArgs {
    /// Address to bind the HTTP server to (default: 0.0.0.0 - reachable on the LAN).
    #[arg(long = "bind", value_name = "ADDR")]
    pub bind: Option<String>,

    /// Port to bind the HTTP server to (default: 7878).
    #[arg(short = 'p', long = "port", value_name = "PORT")]
    pub port: Option<u16>,

    /// Directory holding the job queue/history (default: $XDG_DATA_HOME/hodow/serve or
    /// ~/.local/share/hodow/serve).
    #[arg(long = "data-dir", value_name = "DIR")]
    pub data_dir: Option<std::path::PathBuf>,
}

// ── Vulkan ────────────────────────────────────────────────────────────────────

#[derive(Args)]
pub struct VulkanArgs {
    /// Submit this as a job to a running `hodow_cli serve` instead of running it locally.
    #[cfg(feature = "serve")]
    #[arg(long = "submit-to", value_name = "URL")]
    pub submit_to: Option<String>,
}

// ── CPU ─────────────────────────────────────────────────────────────────────

#[derive(Args)]
pub struct CpuArgs {
    /// Number of iterations per test
    #[arg(short = 'n', long = "iterations")]
    pub iterations: Option<usize>,

    /// List available CPU feature modes and exit
    #[arg(short = 'l', long = "list-modes")]
    pub list_modes: bool,

    /// List all available test functions and exit
    #[arg(short = 'f', long = "list-functions")]
    pub list_functions: bool,

    /// Run only the specified test function(s)
    #[arg(short = 't', long = "test-function", num_args = 1..)]
    pub test_function: Option<Vec<String>>,

    /// Run only the specified feature(s) / extension(s) (e.g., sse2, avx2, avx512f)
    #[arg(short = 'e', long = "feature", value_delimiter = ',', num_args = 1..)]
    pub feature: Vec<String>,

    /// Comma-separated list of tests to skip
    #[arg(short = 's', long = "skip", value_delimiter = ',', num_args = 1..)]
    pub skip: Vec<String>,

    /// Run each test in an isolated child process so a segfault/hang is reported as
    /// CRASHED/TIMEOUT instead of aborting the whole run.
    #[arg(short = 'i', long = "isolate")]
    pub isolate: bool,

    /// Per-test time limit in milliseconds for --isolate (default: 10000).
    #[arg(long = "isolate-timeout", value_name = "MS")]
    pub isolate_timeout_ms: Option<u64>,

    /// Stress mode: run the deterministic tests on every core in parallel and compare
    /// results across cores to surface a single faulty core or thermal instability.
    #[arg(long = "stress")]
    pub stress: bool,

    /// Duration of --stress in seconds (default: 10).
    #[arg(long = "stress-secs", value_name = "SECS")]
    pub stress_secs: Option<u64>,

    /// Internal: run as an isolation worker starting at the given test index. Hidden.
    #[arg(long = "worker-start", value_name = "INDEX", hide = true)]
    pub worker_start: Option<usize>,

    /// Submit this as a job to a running `hodow_cli serve` instead of running it locally
    /// (e.g. --submit-to http://localhost:7878).
    #[cfg(feature = "serve")]
    #[arg(long = "submit-to", value_name = "URL")]
    pub submit_to: Option<String>,
}

// ── GPU ─────────────────────────────────────────────────────────────────────

#[derive(Args)]
pub struct GpuArgs {
    /// Run without creating a visible window (headless / offscreen)
    #[arg(short = 'w', long = "no-window")]
    pub no_window: bool,

    /// Per-test time limit in milliseconds (default: 1000)
    #[arg(short = 't', long = "time-limit", value_name = "MS")]
    pub time_limit_ms: Option<u64>,

    /// Per-test maximum frame count (default: unlimited)
    #[arg(short = 'f', long = "frame-limit", value_name = "FRAMES")]
    pub frame_limit: Option<u64>,

    /// Display/rendering backend to use.
    /// Possible values: egl (default), glx, egl-then-glx, glx-then-egl
    #[arg(short = 'a', long = "display-api", value_name = "BACKEND")]
    pub display_api: Option<String>,

    /// GL API flavour and optional version to request.
    /// Examples: auto (default), opengl, opengl:3.3, opengl:4.6, gles, gles:2.0, gles:3.0
    #[arg(short = 'g', long = "gl-api", value_name = "API[:MAJOR.MINOR]")]
    pub gl_api: Option<String>,

    /// Force Mesa software rendering (sets LIBGL_ALWAYS_SOFTWARE=1).
    /// Use this when the hardware GL driver crashes (e.g. Mesa gallium SEGV in headless mode).
    #[arg(short = 's', long = "force-software")]
    pub force_software: bool,

    /// Run a GPU memory test (bit-pattern upload/download + compute read-modify-write)
    /// instead of the GL feature tests.
    #[arg(short = 'm', long = "memtest")]
    pub memtest: bool,

    /// GPU memory test buffer size in megabytes (default: 64).
    #[arg(long = "memtest-mb", value_name = "MB")]
    pub memtest_mb: Option<usize>,

    /// Submit this as a job to a running `hodow_cli serve` instead of running it locally.
    #[cfg(feature = "serve")]
    #[arg(long = "submit-to", value_name = "URL")]
    pub submit_to: Option<String>,
}

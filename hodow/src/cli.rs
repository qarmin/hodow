use clap::{Args, Parser, Subcommand};

#[derive(Parser)]
#[command(name = "hodow", about = "CPU / GPU workload tester", version = "0.1")]
pub struct Cli {
    /// Enable verbose debug logging
    #[arg(short = 'd', long = "debug", global = true)]
    pub debug: bool,

    /// Copy the log of a cpu/gpu/vulkan run to this file (default: <data dir>/logs/<command>/<time>.log)
    #[arg(long = "log-file", value_name = "PATH", global = true)]
    pub log_file: Option<std::path::PathBuf>,

    /// Do not copy the log to a file
    #[arg(long = "no-log-file", global = true, conflicts_with = "log_file")]
    pub no_log_file: bool,

    /// Where results and logs are kept (default: $HODOW_HOME, else the platform data directory)
    #[arg(long = "data-dir", value_name = "DIR", global = true)]
    pub data_dir: Option<std::path::PathBuf>,

    /// Do not save this run's results
    #[arg(long = "no-results", global = true)]
    pub no_results: bool,

    /// Print the run's events as `@hodow {json}` lines on stdout, for the process that started this one
    #[arg(long = "events", global = true)]
    pub events: bool,

    /// Do not run this here: queue it on a `hodow serve` at this URL (e.g. http://192.168.1.50:7878)
    #[cfg(feature = "serve")]
    #[arg(long = "submit-to", value_name = "URL", global = true)]
    pub submit_to: Option<String>,

    /// Without a command: run the web dashboard (`serve`) and open it
    #[command(subcommand)]
    pub command: Option<Commands>,
}

#[derive(Subcommand, Debug)]
pub enum Commands {
    /// Check that this machine computes correctly: CPU instructions, OpenGL, Vulkan compute (all of them when
    /// no kind is named)
    Test(TestCommand),
    /// Developer tools
    Dev(DevCommand),
    /// Run CPU SIMD instruction-set tests (what `test cpu` runs; kept under this name for scripts and workers)
    #[command(hide = true)]
    Cpu(CpuArgs),
    /// Run OpenGL GPU tests (what `test gpu` runs)
    #[command(hide = true)]
    Gpu(GpuArgs),
    /// Run Vulkan compute validation (what `test vulkan` runs)
    #[command(hide = true)]
    Vulkan(VulkanArgs),
    /// Run a persistent job-queue server with a web dashboard
    #[cfg(feature = "serve")]
    Serve(ServeArgs),
    /// Print what this machine is and which CPU extensions this binary can test on it
    Info(InfoArgs),
    /// Print how much of what stdarch declares actually became a test, and why the rest did not
    #[command(hide = true)]
    Coverage(CoverageArgs),
    /// Load CPU, RAM and GPU as hard as possible, one after another and then together,
    /// checking every result
    Burn(BurnArgs),
    /// Time image-processing kernels and building blocks on the CPU and every GPU API,
    /// end to end with upload/compute/download broken out, every result checked
    Bench(BenchArgs),
    /// List the runs kept in the results directory, or show one
    Runs(RunsArgs),
    /// The Khronos conformance suites (Vulkan, OpenGL ES, OpenGL): every argument goes to the runner, see `hodow cts --help`
    #[command(disable_help_flag = true)]
    Cts(CtsArgs),
    /// Whether a GPU API works here (one JSON line); run by the server in its own process
    #[command(hide = true)]
    Probe(ProbeArgs),
}

#[derive(Args, Debug)]
pub struct CtsArgs {
    #[arg(trailing_var_arg = true, allow_hyphen_values = true, num_args = 0..)]
    pub args: Vec<std::ffi::OsString>,
}

#[derive(Args, Debug)]
pub struct ProbeArgs {
    #[arg(value_enum)]
    pub what: ProbeKind,
}

#[derive(clap::ValueEnum, Clone, Copy, Debug)]
pub enum ProbeKind {
    Gl,
    Vulkan,
}

#[derive(Args, Debug)]
pub struct TestCommand {
    #[command(subcommand)]
    pub which: Option<TestWhich>,
}

#[derive(Subcommand, Debug)]
pub enum TestWhich {
    /// CPU SIMD instruction-set tests
    Cpu(CpuArgs),
    /// OpenGL tests
    #[command(alias = "gl")]
    Gpu(GpuArgs),
    /// Vulkan compute validation on every Vulkan device
    Vulkan(VulkanArgs),
}

#[derive(Args, Debug)]
pub struct DevCommand {
    #[command(subcommand)]
    pub tool: DevTool,
}

#[derive(Subcommand, Debug)]
pub enum DevTool {
    /// How much of what stdarch declares actually became a test, and why the rest did not
    Coverage(CoverageArgs),
}

impl Commands {
    /// `test cpu` is `cpu`, `dev coverage` is `coverage`: everything past `main`'s first lines sees one spelling.
    pub fn normalized(self) -> Self {
        match self {
            Self::Test(TestCommand {
                which: Some(TestWhich::Cpu(a)),
            }) => Self::Cpu(a),
            Self::Test(TestCommand {
                which: Some(TestWhich::Gpu(a)),
            }) => Self::Gpu(a),
            Self::Test(TestCommand {
                which: Some(TestWhich::Vulkan(a)),
            }) => Self::Vulkan(a),
            Self::Dev(DevCommand {
                tool: DevTool::Coverage(a),
            }) => Self::Coverage(a),
            other => other,
        }
    }
}

#[derive(Args, Debug)]
pub struct RunsArgs {
    /// A run id (or a unique part of one) to show; without it every kept run is listed
    pub id: Option<String>,

    /// With an id: list every finding, not just the ones that did not plainly pass
    #[arg(long = "all", requires = "id")]
    pub all: bool,

    /// With an id: keep this run when the results folder is trimmed
    #[arg(long = "pin", requires = "id", conflicts_with = "unpin")]
    pub pin: bool,

    /// With an id: let this run be trimmed again
    #[arg(long = "unpin", requires = "id")]
    pub unpin: bool,
}

// ── Bench ───────────────────────────────────────────────────────────────────

#[derive(Args, Debug)]
pub struct BenchArgs {
    /// A few minutes: the camera pipeline and the best-known variants only.
    #[arg(long = "quick", conflicts_with = "full")]
    pub quick: bool,

    /// Everything: every size, radius and work-group shape. An hour or more on a board.
    #[arg(long = "full")]
    pub full: bool,

    /// Only rows whose task contains one of these: debayer, blur, pipeline, upload,
    /// download, dispatch, copy, sweep, r=8, 1920x1080, ... (comma-separated).
    #[arg(short = 'k', long = "kernel", value_delimiter = ',', value_name = "PATTERN")]
    pub kernels: Vec<String>,

    /// Only rows whose backend contains one of these: cpu, simd, autovec, scalar, opencl,
    /// .so.3, zero-copy, vec4, ... (comma-separated).
    #[arg(short = 'b', long = "backend", value_delimiter = ',', value_name = "PATTERN")]
    pub backends: Vec<String>,

    /// Print the rows a run would execute, without running any.
    #[arg(long = "list")]
    pub list: bool,

    /// Where to write results.json, report.md, report.html and kernel.log
    /// (default: ~/hodow-bench/<time>).
    #[arg(long = "out", value_name = "DIR")]
    pub out: Option<std::path::PathBuf>,

    /// Compare two finished runs (their directories or results.json), e.g. a board
    /// against a laptop, or before and after a driver update.
    #[arg(long = "compare", num_args = 2, value_names = ["A", "B"])]
    pub compare: Option<Vec<std::path::PathBuf>>,

    /// Re-render report.md and report.html of a finished run from its results.json.
    #[arg(long = "report", value_name = "DIR")]
    pub report: Option<std::path::PathBuf>,

    /// Seconds a row may go without finishing a frame before it counts as hung (default: 60).
    #[arg(long = "hang-timeout", value_name = "SECS")]
    pub hang_timeout: Option<u64>,

    /// Also stream the eye pipeline for this long on each backend's best shape, recording
    /// how frame time and temperature move: e.g. 300 for five minutes.
    #[arg(long = "soak", value_name = "SECS")]
    pub soak: Option<u64>,

    /// Run this shell command in the background for the whole run - the application the
    /// device would really be running beside the measurement. Repeatable; stopped at the end.
    #[arg(long = "background", value_name = "CMD")]
    pub background: Vec<String>,

    /// Internal: serve rows read from stdin and report on stdout.
    #[arg(long = "worker", hide = true)]
    pub worker: bool,
}

// ── Burn ────────────────────────────────────────────────────────────────────

#[derive(Args, Debug)]
pub struct BurnArgs {
    /// Total time for every phase together, e.g. 90s, 10m, 8h (default: 10m).
    #[arg(long = "duration", value_name = "TIME", value_parser = parse_duration)]
    pub duration: Option<std::time::Duration>,

    /// One pass of every sub-test and nothing more.
    #[arg(long = "quick")]
    pub quick: bool,

    /// Only these phases: cpu, memory, gpu, combined (comma-separated).
    #[arg(long = "only", value_delimiter = ',', value_name = "PHASES")]
    pub only: Vec<String>,

    /// Skip these phases: cpu, memory, gpu, combined (comma-separated).
    #[arg(long = "skip", value_delimiter = ',', value_name = "PHASES")]
    pub skip: Vec<String>,

    /// RAM the memory phase tests, in MB. Default: half of what is available (a container's limit counts), and only memory that is free
    /// right now when memory cannot be locked.
    #[arg(long = "ram-mb", value_name = "MB")]
    pub ram_mb: Option<u64>,

    /// GPU memory the GPU phase tests, in MB (default: sized from the driver or the system).
    #[arg(long = "gpu-mb", value_name = "MB")]
    pub gpu_mb: Option<u64>,

    /// Port of the live dashboard (default: 5997).
    #[arg(long = "http-port", value_name = "PORT")]
    pub http_port: Option<u16>,

    /// No dashboard.
    #[arg(long = "no-http")]
    pub no_http: bool,

    /// Exit when the run ends instead of keeping the dashboard up until Ctrl-C.
    #[arg(long = "exit-when-done")]
    pub exit_when_done: bool,

    /// Where to write events.jsonl, summary.txt and kernel.log (default: ~/hodow-burn/<time>).
    #[arg(long = "out", value_name = "DIR")]
    pub out: Option<std::path::PathBuf>,

    /// Print the summary of an earlier run from its directory, including where it stopped.
    #[arg(long = "show", value_name = "DIR")]
    pub show: Option<std::path::PathBuf>,

    /// Stop the run once any sensor exceeds this temperature (degrees C).
    #[arg(long = "max-temp", value_name = "C")]
    pub max_temp: Option<f32>,

    /// Seconds without progress before a worker counts as hung (default: 30).
    #[arg(long = "hang-timeout", value_name = "SECS")]
    pub hang_timeout: Option<u64>,

    /// Inject a known fault into every sub-test and check each one is caught.
    #[arg(long = "selftest")]
    pub selftest: bool,

    /// Internal: run one sub-test described by this JSON and report on stdout.
    #[arg(long = "worker", value_name = "JSON", hide = true)]
    pub worker: Option<String>,
}

fn parse_duration(s: &str) -> Result<std::time::Duration, String> {
    let s = s.trim();
    let split = s.find(|c: char| !c.is_ascii_digit() && c != '.').unwrap_or(s.len());
    let (number, unit) = s.split_at(split);
    let value: f64 = number
        .parse()
        .map_err(|_| format!("'{s}' is not a duration like 90s, 10m or 8h"))?;
    let scale = match unit.trim() {
        "" | "s" => 1.0,
        "m" | "min" => 60.0,
        "h" => 3600.0,
        other => return Err(format!("unknown unit '{other}' - use s, m or h")),
    };
    Ok(std::time::Duration::from_secs_f64(value * scale))
}

// ── Coverage ────────────────────────────────────────────────────────────────

#[derive(Args, Debug)]
pub struct CoverageArgs {
    /// Only this architecture (stdarch's own bucket name: x86, x86_64, arm_shared, aarch64, ...)
    #[arg(short = 'a', long = "arch", value_name = "ARCH")]
    pub arch: Option<String>,

    /// One line per extension, instead of one per architecture
    #[arg(short = 'e', long = "extensions")]
    pub extensions: bool,

    /// List every function that did not make it in, with the reason
    #[arg(short = 'v', long = "verbose")]
    pub verbose: bool,

    /// Only functions dropped for this reason (a slug from the summary, e.g. `unstable-type`)
    #[arg(short = 'r', long = "reason", value_name = "SLUG")]
    pub reason: Option<String>,
}

// ── Info ─────────────────────────────────────────────────────────────────────

#[derive(Args, Debug)]
pub struct InfoArgs {
    /// One line per extension instead of two grouped lists
    #[arg(short = 'v', long = "verbose")]
    pub verbose: bool,

    /// Skip the Graphics section. That section is the only part of `info` that loads a GPU
    /// driver, so this keeps the command usable on a machine where doing so hangs or crashes.
    #[arg(long = "no-gpu")]
    pub no_gpu: bool,
}

// ── Serve ───────────────────────────────────────────────────────────────────

#[cfg(feature = "serve")]
#[derive(Args, Debug)]
pub struct ServeArgs {
    /// Address to bind the HTTP server to (default: 0.0.0.0 - reachable on the LAN).
    #[arg(long = "bind", value_name = "ADDR")]
    pub bind: Option<String>,

    /// Port to bind the HTTP server to (default: 7878).
    #[arg(short = 'p', long = "port", value_name = "PORT")]
    pub port: Option<u16>,

    /// Listen on 127.0.0.1 only (same as `--bind 127.0.0.1`).
    #[arg(long = "local", conflicts_with = "bind")]
    pub local: bool,

    /// Do not open the dashboard in a browser, even when a display is available.
    #[arg(long = "no-open")]
    pub no_open: bool,
}

/// The processing flows (`hodow_bench::flows`): whole pipelines checked against a reference.
#[derive(Args, Debug, Clone)]
pub struct FlowArgs {
    /// Also run the processing flows: whole pipelines (camera frame, GEMM, sort, histogram, ...) checked against a reference
    #[arg(long = "flows")]
    pub flows: bool,

    /// Frame size and repetitions of the processing flows (with --flows): small (seconds, the default) or full
    #[arg(long = "flows-size", value_name = "SIZE", value_parser = ["small", "full"], default_value = "small")]
    pub flows_size: String,
}

impl Default for FlowArgs {
    fn default() -> Self {
        Self {
            flows: false,
            flows_size: "small".into(),
        }
    }
}

impl FlowArgs {
    pub fn apply(&self) {
        hodow_bench::flows::set_enabled(self.flows);
        hodow_bench::flows::set_size(if self.flows_size == "full" {
            hodow_bench::flows::FlowSize::Full
        } else {
            hodow_bench::flows::FlowSize::Small
        });
    }

    /// The same flags for a child process, whose test list has to be the parent's.
    pub fn forward(&self) -> Vec<String> {
        let mut out = vec!["--flows-size".to_string(), self.flows_size.clone()];
        if self.flows {
            out.push("--flows".into());
        }
        out
    }
}

// ── Vulkan ────────────────────────────────────────────────────────────────────

#[derive(Args, Debug)]
pub struct VulkanArgs {
    #[command(flatten)]
    pub flows: FlowArgs,
}

// ── CPU ─────────────────────────────────────────────────────────────────────

#[derive(Args, Debug)]
pub struct CpuArgs {
    #[command(flatten)]
    pub flows: FlowArgs,

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

    /// Write a machine-readable per-test report to this path (only with --isolate).
    /// Format is picked from the extension: `.csv` for CSV, anything else for JSON.
    /// Each record is (name, feature, verdict, got, expected, message) - meant for diffing
    /// a native run against one under an emulator (box64, FEX-Emu, ...).
    #[arg(long = "report", value_name = "PATH")]
    pub report: Option<std::path::PathBuf>,
}

// ── GPU ─────────────────────────────────────────────────────────────────────

#[derive(Args, Debug)]
pub struct GpuArgs {
    #[command(flatten)]
    pub flows: FlowArgs,

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

    /// Run only the quick output-checked tests (fill, blend, window alpha, textures, scissor, blit),
    /// about a second in total; the per-test time limit defaults to 50 ms.
    #[arg(long = "quick")]
    pub quick: bool,

    /// Run each GL test in its own subprocess, so a driver hang or segfault is reported for
    /// that one test instead of ending the whole run.
    #[arg(long = "isolate")]
    pub isolate: bool,

    /// Per-test timeout in isolate mode (default 30000 ms).
    #[arg(long = "isolate-timeout-ms", value_name = "MS")]
    pub isolate_timeout_ms: Option<u64>,

    /// Internal: run only the test at this index and print one RESULT line. Set by the
    /// isolate parent on the children it spawns.
    #[arg(long = "gpu-worker", value_name = "INDEX", hide = true)]
    pub gpu_worker: Option<usize>,

    /// Run a GPU memory test (bit-pattern upload/download + compute read-modify-write)
    /// instead of the GL feature tests.
    #[arg(short = 'm', long = "memtest")]
    pub memtest: bool,

    /// GPU memory test buffer size in megabytes (default: 64).
    #[arg(long = "memtest-mb", value_name = "MB")]
    pub memtest_mb: Option<usize>,
}

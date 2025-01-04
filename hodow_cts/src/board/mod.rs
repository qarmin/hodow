// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// `hodow_cts board <ip>`: test a board unattended, from this machine.
//
// Runs on the host and drives the board's own hodow_cts over ssh, because the board cannot
// reboot itself out of a GPU hang or outlive one. Everything about one board lives under
// `<dir>/<soc>-<serial>/`, keyed by the chip rather than the address, and everything
// about one driver build under a subdirectory of that: findings, quarantine and progress
// are facts about a driver, and a new one starts clean.

pub mod findings;
pub mod place;
pub mod plan;
#[cfg(test)]
mod sim;
pub mod ssh;
pub mod target;
pub mod tester;
#[cfg(test)]
mod tests;

use std::io::Write;
use std::path::PathBuf;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Arc, Mutex, OnceLock};

use clap::Args;
use log::{error, info, warn};
use tester::{Config, Halt, Tester};

/// What `--emit-results` puts in front of each JSON result line.
pub const RESULT_PREFIX: &str = "@result ";

#[derive(Args, Debug)]
pub struct BoardArgs {
    /// The board's address.
    pub ip: String,

    #[arg(long, default_value = "root")]
    pub user: String,

    /// Extra ssh/scp options; `$HODOW_SSH_OPTS` when not given.
    #[arg(long, allow_hyphen_values = true)]
    pub ssh_opts: Option<String>,

    /// hodow_cts built for the board, deployed when the board's copy differs.
    #[arg(long, value_name = "FILE")]
    pub binary: Option<PathBuf>,

    /// Where every board's directory lives.
    #[arg(long, default_value = "tmp/boards")]
    pub dir: PathBuf,

    /// Which cases to test.
    #[arg(long, default_value = "dEQP-GLES*")]
    pub case: Vec<String>,

    /// Cases per batch in phase 1 and per group in phase 2.
    #[arg(long, default_value_t = 500)]
    pub batch: usize,

    /// Shuffled epochs in a row without a new finding before an API leaves phase 2.
    #[arg(long, default_value_t = 6)]
    pub dry_epochs: u32,

    /// Most minimisation steps one finding may take.
    #[arg(long, default_value_t = 40)]
    pub budget_steps: u32,

    /// Most hours one finding's minimisation may take.
    #[arg(long, default_value_t = 3.0)]
    pub budget_hours: f64,

    /// A case that reports nothing for this long is killed.
    #[arg(long, default_value_t = 60)]
    pub timeout_secs: u64,

    /// Stop after phase 3 instead of going back to phase 2.
    #[arg(long)]
    pub once: bool,

    /// Print where the board's testing stands, from the local directory only.
    #[arg(long)]
    pub status: bool,

    /// Units stopped while testing and started again at the end; `$HODOW_QUIET_UNITS`, or
    /// `ap600-launcher`, when not given.
    #[arg(long)]
    pub quiet_units: Option<String>,

    /// Leave those units stopped at the end.
    #[arg(long)]
    pub keep_quiet: bool,

    #[arg(long, default_value = "/run/user/0")]
    pub runtime_dir: String,

    #[arg(long, default_value = "wayland-0")]
    pub wayland_display: String,
}

static INTERRUPTED: AtomicBool = AtomicBool::new(false);
static LOG_FILE: OnceLock<Arc<Mutex<Option<std::fs::File>>>> = OnceLock::new();

pub fn interrupted() -> bool {
    INTERRUPTED.load(Ordering::Relaxed)
}

pub fn main(args: BoardArgs) -> u8 {
    init_logger();
    if args.status {
        return place::print_status(&args.dir, &args.ip);
    }
    install_interrupt_handler();
    match run(args) {
        Ok(code) => code,
        Err(e) => {
            error!("{e}");
            1
        }
    }
}

fn run(args: BoardArgs) -> std::io::Result<u8> {
    let ssh_opts = args
        .ssh_opts
        .clone()
        .unwrap_or_else(|| std::env::var("HODOW_SSH_OPTS").unwrap_or_default());
    let mut board = ssh::SshBoard::new(
        &args.ip,
        &ssh::Options {
            user: args.user.clone(),
            ssh_opts,
            runtime_dir: args.runtime_dir.clone(),
            wayland_display: args.wayland_display.clone(),
            timeout_secs: args.timeout_secs,
            quiet_units: args
                .quiet_units
                .clone()
                .unwrap_or_else(|| std::env::var("HODOW_QUIET_UNITS").unwrap_or_else(|_| "ap600-launcher".to_string())),
        },
    );

    if !board.reachable() {
        warn!("{} does not answer ssh - waiting for it", args.ip);
        target::Board::wait_until_back(&mut board);
        if interrupted() {
            return Ok(130);
        }
    }
    let fields = board
        .identity()
        .ok_or_else(|| std::io::Error::other("could not read the board's identity over ssh"))?;
    let identity = place::Identity::from_fields(&fields);
    let board_dir = args.dir.join(identity.dir_name());
    place::record_board(&board_dir, &identity, &args.ip)?;
    info!("Board {} at {} ({})", identity.dir_name(), args.ip, identity.describe());

    let binary_hash = match &args.binary {
        Some(binary) => board.deploy(binary)?,
        None => String::from("not deployed by this run"),
    };
    board.initial_boot_id();
    board.quiet();
    if board.hang_in_kernel_log() {
        info!("The kernel log already shows a GPU hang from before this run - rebooting first");
        target::Board::reboot(&mut board);
    }
    let driver = match board.driver() {
        Some(driver) => driver,
        None => {
            warn!("No driver answered - rebooting once before giving up");
            target::Board::reboot(&mut board);
            board
                .driver()
                .ok_or_else(|| std::io::Error::other("no GL driver answered on the board, even after a reboot"))?
        }
    };
    let driver_dir = board_dir.join(place::sanitize(&driver));
    std::fs::create_dir_all(&driver_dir)?;
    set_log_file(&driver_dir.join("run.log"));
    board.set_kernel_dir(driver_dir.join("kernel"));

    let names = board.list_cases(&args.case)?;
    let corpus = plan::Corpus::from_names(&names);
    if corpus.is_empty() {
        return Err(std::io::Error::other(
            "the board's hodow_cts lists no cases for that selection",
        ));
    }
    let counts: Vec<String> = corpus
        .apis
        .iter()
        .map(|(root, cases)| format!("{} {}", plan::short_api(root), cases.len()))
        .collect();
    info!(
        "Driver {driver}; {} cases ({}); results in {}",
        corpus.len(),
        counts.join(", "),
        driver_dir.display()
    );

    let cfg = Config {
        batch: args.batch.max(1),
        dry_epochs: args.dry_epochs.max(1),
        budget_calls: args.budget_steps,
        budget_wall: std::time::Duration::from_secs_f64(args.budget_hours * 3600.0),
        once: args.once,
        ..Config::default()
    };
    let seed = crate::fuzz::rng::derive(crate::fuzz::store::now_epoch(), &args.ip, u64::from(std::process::id()));
    let mut tester = Tester::open(board, driver_dir, corpus, seed, cfg)?;
    tester.findings.binary = binary_hash;
    info!(
        "{} findings and {} quarantined cases so far",
        tester.findings.list.len(),
        tester.quarantine.len()
    );

    let halt = tester.run();
    if !args.keep_quiet {
        tester.board.restore();
    }
    Ok(match halt {
        Halt::Interrupted => {
            info!("Interrupted - run the same command again to carry on");
            130
        }
        Halt::Once => {
            info!(
                "Phase 3 finished for every API ({} findings, {} quarantined)",
                tester.findings.list.len(),
                tester.quarantine.len()
            );
            0
        }
        Halt::Killed => 1,
        Halt::Io(e) => {
            error!("{e}");
            1
        }
    })
}

struct LogFile;

impl Write for LogFile {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        if let Some(shared) = LOG_FILE.get()
            && let Ok(mut file) = shared.lock()
            && let Some(file) = file.as_mut()
        {
            file.write_all(buf)?;
        }
        Ok(buf.len())
    }

    fn flush(&mut self) -> std::io::Result<()> {
        Ok(())
    }
}

fn set_log_file(path: &std::path::Path) {
    if let Ok(file) = std::fs::OpenOptions::new().create(true).append(true).open(path)
        && let Some(shared) = LOG_FILE.get()
        && let Ok(mut slot) = shared.lock()
    {
        *slot = Some(file);
    }
}

fn init_logger() {
    use handsome_logger::{
        ColorChoice, CombinedLogger, ConfigBuilder, FormatText, TermLogger, TerminalMode, WriteLogger,
    };
    let _ = LOG_FILE.set(Arc::new(Mutex::new(None)));
    let level = std::env::var("RUST_LOG")
        .ok()
        .and_then(|l| l.parse().ok())
        .unwrap_or(log::LevelFilter::Info);
    let only_ours = |record: &log::Record| record.target().starts_with("hodow_cts");
    let config = |format: FormatText| {
        let mut builder = ConfigBuilder::new();
        builder
            .set_level(level)
            .set_format_text(format.get(), None)
            .set_message_filtering(Some(only_ours));
        let _ = builder.set_time_offset_to_local();
        builder.build()
    };
    let term = config(FormatText::SimpleC);
    let file = config(FormatText::Simple);
    let _ = CombinedLogger::init(vec![
        TermLogger::new(term, TerminalMode::Mixed, ColorChoice::Auto),
        WriteLogger::new(file, LogFile),
    ]);
}

fn install_interrupt_handler() {
    extern "C" fn on_sigint(_: std::ffi::c_int) {
        if INTERRUPTED.swap(true, Ordering::Relaxed) {
            crate::runner::reap::exit_without_teardown(130);
        }
    }
    unsafe extern "C" {
        fn signal(signum: std::ffi::c_int, handler: extern "C" fn(std::ffi::c_int)) -> usize;
    }
    const SIGINT: std::ffi::c_int = 2;
    const SIGTERM: std::ffi::c_int = 15;
    unsafe {
        signal(SIGINT, on_sigint);
        signal(SIGTERM, on_sigint);
    }
}

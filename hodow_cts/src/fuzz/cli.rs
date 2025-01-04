// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// The `fuzz` verbs.
//
// `gpucrash` and `systemcrash` are separate verbs rather than flags on `continue` for
// one reason: they are what gets typed at three in the morning, next to a board that
// has just been power-cycled, and the shortest thing that carries the whole meaning is
// the right shape. They do everything `continue` does and additionally record how bad
// it was - which is a fact about the machine that only a person can supply.

use std::path::PathBuf;

use clap::{Args, Subcommand};

/// The binary's subcommands. There is one, and everything above it - `--case`,
/// `--list`, `--output` - still works with none given, exactly as before.
#[derive(Subcommand, Debug)]
pub enum Cmd {
    /// Fuzz which cases share a process, and in what order.
    Fuzz {
        #[command(subcommand)]
        verb: Verb,
    },
}

#[derive(Subcommand, Debug)]
pub enum Verb {
    /// Start a new campaign: sweep the corpus in randomised groups, looking for a
    /// combination that kills a driver.
    Run(RunArgs),

    /// Carry on where the campaign left off.
    ///
    /// If it finds a group that was in flight when the last process disappeared, that
    /// group is recorded as having killed the machine - say `--last-was-fine` if it was
    /// a Ctrl-C or a deliberate reboot instead.
    Continue(ContinueArgs),

    /// `continue`, and the in-flight group hung the GPU.
    Gpucrash(ResumeArgs),

    /// `continue`, and the in-flight group took the whole machine down.
    Systemcrash(ResumeArgs),

    /// Run a finding's saved case list again, and fold the answer into what is known
    /// about it. Works even after the corpus has moved - a finding carries its own list.
    Replay(ReplayArgs),

    /// Shrink a finding to the shortest list that still reproduces it, and exclude
    /// whatever turns out to be the trigger. Resumable: run it again after a reset.
    Minimize(MinimizeArgs),

    /// Write a finding out as a directory that reruns it, for asking the next driver
    /// whether it still happens.
    Export(ExportArgs),

    /// What the fuzzer will not draw, and why.
    Quarantine(QuarantineArgs),

    /// Where the campaign is, what it has found, and whether anything is waiting on you.
    Status(ResumeArgs),

    /// Name the cases that got a given verdict in an epoch. An epoch touches every case
    /// once, so a campaign screens the whole corpus as a side effect - this is what reads
    /// that back out.
    Verdicts(VerdictsArgs),

    /// Bring one API's driver up, print what answered, and exit. Touches no case.
    Probe(ProbeArgs),

    /// Inject faults whose correct answer is known, and check the fuzzer finds it.
    Selftest(SelftestArgs),
}

#[derive(Args, Debug)]
pub struct RunArgs {
    /// Only draw from cases matching this glob. Repeatable. Each root becomes its own
    /// pool, since one group is one driver bring-up and cannot span two.
    #[arg(short, long)]
    pub case: Vec<String>,

    /// Keep cases matching this glob out of the pool. Repeatable.
    #[arg(long)]
    pub exclude: Vec<String>,

    /// How many cases share one process. The bigger it is, the more state a group
    /// accumulates before anything trips over it.
    #[arg(long, default_value_t = 1000)]
    pub group_size: usize,

    /// The campaign's seed. Every group in it is a function of this, so quoting it in a
    /// bug report describes the whole run. Random if not given.
    #[arg(long)]
    pub seed: Option<u64>,

    /// Directory name for this campaign. The recipes pass a local timestamp; this
    /// binary deliberately never formats a clock (see fuzz/store.rs).
    #[arg(long)]
    pub label: Option<String>,

    /// Stop after this many groups. Runs until something needs you if not given.
    #[arg(long)]
    pub iterations: Option<u64>,

    /// How many times a finding's list is re-run before anything is believed about it.
    /// 0/R is recorded as not reproducible rather than worked on; a rate below 1 is what
    /// says the oracle is flaky, which changes what any later minimisation is worth.
    #[arg(long, default_value_t = 3)]
    pub repro_attempts: u32,

    /// Run the whole group this many times over inside one process. The cheapest way
    /// to accumulate state - descriptors, allocations, handles that one pass never
    /// pushes past a threshold.
    #[arg(long, default_value_t = 1)]
    pub repeats: u32,

    /// Run the identical group this many times, each from a fresh process. The only
    /// clean way to see a verdict that does not hold still.
    #[arg(long, default_value_t = 1)]
    pub replicas: u32,

    /// Workers sharing the driver at once. Realistic contention, but the interleaving is
    /// never the same twice - a finding from here is checked serially first, and only
    /// tagged a race if it will not reproduce that way.
    #[arg(short = 'j', long, default_value_t = 1)]
    pub jobs: usize,

    /// Oracle calls one finding's minimisation may spend before it is parked with its
    /// state on disk and the campaign moves on. `fuzz minimize <id>` resumes it.
    #[arg(long, default_value_t = 200)]
    pub minimize_budget: u32,

    /// Draw from the whole pool, ignoring quarantine.toml - to check whether a driver
    /// update fixed something. Entries are still recorded, just not acted on.
    #[arg(long)]
    pub no_quarantine: bool,

    /// Stop the campaign after this many groups die in a row - past that, the driver is
    /// gone and everything after is noise rather than findings. 0 turns it off.
    #[arg(long, default_value_t = 3)]
    pub wedge_threshold: usize,

    #[command(flatten)]
    pub common: CommonArgs,

    /// Where campaigns live. Defaults to tmp/cts-fuzz in a checkout, ~/hodow-cts-fuzz
    /// anywhere else - never /tmp, which is a tmpfs on the boards this targets.
    #[arg(long, value_name = "DIR")]
    pub base_dir: Option<PathBuf>,
}

#[derive(Args, Debug)]
pub struct ContinueArgs {
    /// The in-flight group was not what stopped the last run - discard it instead of
    /// recording a finding. This is the Ctrl-C case.
    #[arg(long)]
    pub last_was_fine: bool,

    #[command(flatten)]
    pub resume: ResumeArgs,
}

#[derive(Args, Debug)]
pub struct VerdictsArgs {
    #[command(flatten)]
    pub resume: ResumeArgs,

    /// Only cases whose verdict was this - `fail`, `crash`, `timeout`, `notsupported`,
    /// `pass`, or `all` for every case the epoch reached.
    #[arg(long, default_value = "fail")]
    pub status: String,

    /// Which epoch to read. The one in progress if not given, which has only the cases
    /// it has reached so far - the previous one is the complete sweep.
    #[arg(long)]
    pub epoch: Option<u64>,

    /// Only this pool, by root name.
    #[arg(long, value_name = "ROOT")]
    pub api: Option<String>,
}

#[derive(Args, Debug)]
pub struct ResumeArgs {
    /// A specific campaign, instead of whatever `current` points at.
    #[arg(long, value_name = "DIR")]
    pub dir: Option<PathBuf>,

    /// Where campaigns live.
    #[arg(long, value_name = "DIR")]
    pub base_dir: Option<PathBuf>,

    /// Stop after this many groups.
    #[arg(long)]
    pub iterations: Option<u64>,
}

#[derive(Args, Debug)]
pub struct ReplayArgs {
    /// Which finding, by its number.
    pub id: u32,

    /// How many times to run it.
    #[arg(long, default_value_t = 3)]
    pub attempts: u32,

    /// Run the whole group rather than the prefix up to whatever died. Slower, and only
    /// worth it when the prefix does not reproduce but the group did.
    #[arg(long)]
    pub full: bool,

    #[command(flatten)]
    pub resume: ResumeArgs,
}

#[derive(Args, Debug)]
pub struct MinimizeArgs {
    /// Which finding, by its number.
    pub id: u32,

    /// Start from the whole group rather than the prefix up to whatever died. What to
    /// use when `replay --full` reproduced and the prefix did not - the prefix is only
    /// as good as the count of cases that had reported, which after a hard death is a
    /// lower bound and can be zero.
    #[arg(long)]
    pub full: bool,

    #[command(flatten)]
    pub resume: ResumeArgs,
}

#[derive(Args, Debug)]
pub struct ExportArgs {
    /// Which finding, by its number.
    pub id: u32,

    /// Where to put it. A directory per finding is created inside.
    #[arg(long, value_name = "DIR", default_value = "findings")]
    pub into: PathBuf,

    #[command(flatten)]
    pub resume: ResumeArgs,
}

#[derive(Args, Debug)]
pub struct QuarantineArgs {
    /// Exclude this case or glob. Needs --reason.
    #[arg(long, value_name = "CASE")]
    pub add: Option<String>,

    /// Why, which is mandatory: an exclusion nobody justified is one nobody can safely
    /// remove later. Same rule as data/cpu/function_policy.toml.
    #[arg(long)]
    pub reason: Option<String>,

    /// Drop entries whose pattern is exactly this. Exact, not glob-matched, so what is
    /// typed is what goes.
    #[arg(long, value_name = "CASE")]
    pub remove: Option<String>,

    /// Where campaigns live.
    #[arg(long, value_name = "DIR")]
    pub base_dir: Option<PathBuf>,
}

#[derive(Args, Debug)]
pub struct ProbeArgs {
    /// Which driver to bring up, by case-name root: dEQP-VK, dEQP-GLES2, dEQP-GLES3 or
    /// dEQP-GLES31.
    #[arg(long, value_name = "ROOT")]
    pub api: String,

    #[command(flatten)]
    pub common: CommonArgs,
}

#[derive(Args, Debug)]
pub struct SelftestArgs {
    /// Which driver to run the injected faults against. Any working one will do - the
    /// faults are injected into the harness, not into the driver.
    #[arg(long, value_name = "ROOT", default_value = "dEQP-GLES2")]
    pub api: String,

    /// Keep the scratch campaigns instead of removing them, to read what they wrote.
    #[arg(long)]
    pub keep: bool,

    #[command(flatten)]
    pub common: CommonArgs,
}

/// The settings that mean the same thing to every verb, and that a campaign records so
/// a resume uses what the run started with.
#[derive(Args, Debug, Clone)]
pub struct CommonArgs {
    /// Device to run on, 1-based, in enumeration order.
    #[arg(long, default_value_t = 1)]
    pub device_id: usize,

    /// Run under the Khronos validation layer. Not a conformance run; the layer changes
    /// driver behaviour, which for a fuzzer also changes what it finds.
    #[arg(long)]
    pub validation: bool,

    /// Kill a worker that reports no progress for this many seconds.
    #[arg(long, default_value_t = 60)]
    pub timeout_secs: u64,
}

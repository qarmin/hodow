// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Combination fuzzing for the conformance suite.
//
// The cases are deterministic - same code, same shaders, same inputs - so there is no
// input to fuzz. What there is to fuzz is the *combination*: which cases share a
// process, and in what order. That is where the failures this exists for live. A driver
// left in a bad state by one case takes down whatever runs next, and the case that dies
// is innocent and different every time, which is precisely why those crashes have been
// so hard to reproduce: the thing that has to be replayed is the sequence, and nothing
// was writing the sequence down.
//
// So everything here is built around surviving its own subject. The campaign records
// what it is about to run before it runs it, fsynced, and a person supplies the one
// fact the machine cannot after a power cut: whether that group is what killed it.
//
//     hodow_cts fuzz run --case 'dEQP-GLES*'
//     ...board wedges, you power-cycle it...
//     hodow_cts fuzz gpucrash
//
// See hodow_cts/README.md, "Fuzzing combinations", for the whole shape.

pub mod campaign;
pub mod cli;
pub mod drift;
pub mod export;
pub mod fault;
pub mod health;
pub mod minimize;
pub mod oracle;
pub mod pool;
pub mod quarantine;
pub mod rng;
pub mod selftest;
pub mod store;
pub mod triage;

use std::path::{Path, PathBuf};
use std::process::ExitCode;

use campaign::{NewCampaign, Runner, Severity, Stopped, Verdict};
use cli::{Cmd, Verb};
use store::{Store, ago, now_epoch};

/// Same meaning as the top-level binary's: no driver, so nothing was tested. Distinct
/// from a failure so nothing blames a case that never got a chance to run.
pub const EXIT_NO_DRIVER: u8 = 2;

/// The same, as the number the process exits with - which is what the caller needs when
/// it has to leave without unwinding (see `runner::reap::exit_without_teardown`).
pub fn exit_code(cmd: Cmd) -> u8 {
    match main(cmd) {
        c if c == ExitCode::SUCCESS => 0,
        c if c == ExitCode::from(EXIT_NO_DRIVER) => EXIT_NO_DRIVER,
        _ => 1,
    }
}

pub fn main(cmd: Cmd) -> ExitCode {
    let Cmd::Fuzz { verb } = cmd;
    let result = match verb {
        Verb::Run(args) => run(args),
        Verb::Continue(args) => {
            let verdict = if args.last_was_fine {
                Verdict::Fine
            } else {
                Verdict::Reproduced(Severity::Unspecified)
            };
            resume(args.resume, verdict)
        }
        Verb::Gpucrash(args) => resume(args, Verdict::Reproduced(Severity::GpuHang)),
        Verb::Systemcrash(args) => resume(args, Verdict::Reproduced(Severity::SystemDown)),
        Verb::Replay(args) => replay(args),
        Verb::Minimize(args) => minimize(args),
        Verb::Export(args) => export(args),
        Verb::Quarantine(args) => quarantine(args),
        Verb::Status(args) => status(args),
        Verb::Verdicts(args) => verdicts(args),
        Verb::Probe(args) => return probe(args),
        Verb::Selftest(args) => return selftest::main(args),
    };

    match result {
        Ok(code) => code,
        Err(e) => {
            eprintln!("error: {e}");
            ExitCode::FAILURE
        }
    }
}

fn run(args: cli::RunArgs) -> std::io::Result<ExitCode> {
    let base = args.base_dir.clone().unwrap_or_else(store::default_base_dir);
    std::fs::create_dir_all(&base)?;

    let seed = args.seed.unwrap_or_else(random_seed);
    let label = args.label.clone().unwrap_or_else(|| next_free_label(&base));

    let mut runner = Runner::create(
        base.clone(),
        label,
        NewCampaign {
            seed,
            group_size: args.group_size,
            case_filters: args.case,
            exclude_filters: args.exclude,
            device_id: args.common.device_id,
            validation: args.common.validation,
            timeout_secs: args.common.timeout_secs,
            wedge_threshold: args.wedge_threshold,
            repro_attempts: args.repro_attempts,
            use_quarantine: !args.no_quarantine,
            minimize_budget: args.minimize_budget,
            repeats: args.repeats,
            replicas: args.replicas,
            jobs: args.jobs,
        },
    )?;

    print_plan(&runner);
    let _lock = Lock::acquire(&runner.store().dir)?;
    drive(&mut runner, args.iterations)
}

fn resume(args: cli::ResumeArgs, verdict: Verdict) -> std::io::Result<ExitCode> {
    let dir = resolve_dir(&args)?;
    let mut runner = Runner::open(dir)?;
    let _lock = Lock::acquire(&runner.store().dir)?;

    match runner.settle(verdict)? {
        Some(message) => {
            println!("! {message}");
            println!();
        }
        None => println!("nothing was in flight - the last run stopped cleanly"),
    }

    drive(&mut runner, args.iterations)
}

fn drive(runner: &mut Runner, budget: Option<u64>) -> std::io::Result<ExitCode> {
    let started = std::time::Instant::now();
    let before = runner.state().findings;

    let stopped = runner.run_loop(budget, |record| {
        let marker = if record.outcome == "ok" { " " } else { "!" };
        println!(
            "{marker} {:<12} epoch {:>3} group {:>5}  {:>5} cases  {:>5} pass {:>5} skip {:>4} fail  {:>6.1}s  {}",
            record.api,
            record.epoch,
            record.group,
            record.size,
            record.passed,
            record.not_supported,
            record.failed,
            record.duration_s,
            record.outcome
        );
        if let (Some(id), Some(culprit)) = (record.finding, &record.culprit) {
            println!("    finding {id}: {culprit}");
        }
        flush();
    })?;

    println!();
    println!(
        "{} group(s) in {:.0}s, {} new finding(s)",
        runner.state().iterations,
        started.elapsed().as_secs_f64(),
        runner.state().findings - before
    );

    Ok(match stopped {
        Stopped::BudgetSpent => {
            println!("budget spent - `fuzz continue` picks up where this left off");
            ExitCode::SUCCESS
        }
        Stopped::PoolExhausted => {
            println!("nothing left to draw from");
            ExitCode::SUCCESS
        }
        Stopped::DriverUnavailable(why) => {
            println!("{why}");
            ExitCode::from(EXIT_NO_DRIVER)
        }
        Stopped::NeedsAttention(why) => {
            println!();
            println!("STOPPED: {why}");
            println!();
            // Reached with the supervisor still alive and nothing in flight, so the
            // crash verbs have nothing to tag - those are for a machine that did not
            // come back, and `fuzz status` offers them when there is a record to tag.
            println!("Read the findings, reset the board if it needs it, then:");
            println!("  hodow_cts fuzz continue      carry on from here");
            println!("  hodow_cts fuzz status        where this got to");
            ExitCode::FAILURE
        }
    })
}

fn replay(args: cli::ReplayArgs) -> std::io::Result<ExitCode> {
    let dir = resolve_dir(&args.resume)?;
    let store = Store::new(dir);
    let campaign = store.read_campaign()?;
    let before = store.read_finding(args.id)?;

    println!(
        "finding {} ({}), {} so far",
        args.id,
        before.kind,
        before.repro.summary()
    );
    println!(
        "  {}",
        before.culprit.clone().unwrap_or_else(|| "(no case named)".to_string())
    );
    println!();

    let attempts = args.attempts.max(1);
    let report = triage::replay_finding(&store, &campaign, args.id, attempts, args.full, |n| {
        println!("  attempt {n} of {attempts}");
        flush();
    })?;

    println!();
    println!("this run: {}", report.summary());
    if !report.kinds.is_empty() {
        println!("  as: {}", report.kinds.join(", "));
    }
    println!("overall:  {}", store.read_finding(args.id)?.repro.summary());
    Ok(ExitCode::SUCCESS)
}

fn minimize(args: cli::MinimizeArgs) -> std::io::Result<ExitCode> {
    let dir = resolve_dir(&args.resume)?;
    let mut runner = Runner::open(dir)?;
    let _lock = Lock::acquire(&runner.store().dir)?;

    let before = runner.store().read_finding_list(args.id, args.full)?.len();
    let outcome = runner.minimize_finding(args.id, args.full)?;
    let state = minimize::load_state(runner.store(), args.id);
    let now = state.as_ref().map(|s| s.current.len()).unwrap_or(before);

    println!();
    println!("finding {}: {before} case(s) -> {now}", args.id);
    if let Some(state) = &state {
        println!("  {} oracle call(s) so far", state.oracle_calls);
        for case in &state.current {
            println!("    {case}");
        }
    }

    Ok(match outcome {
        minimize::Outcome::Minimal => {
            println!("  nothing more can be removed; repro.txt written beside the finding");
            ExitCode::SUCCESS
        }
        minimize::Outcome::BudgetSpent => {
            println!(
                "  budget spent - `fuzz minimize {}` again carries on from here",
                args.id
            );
            ExitCode::SUCCESS
        }
        minimize::Outcome::NotReproducible => {
            println!("  it did not reproduce at all, so there is nothing to shrink");
            println!("  the list is still on disk; `fuzz replay {}` asks again", args.id);
            if !args.full {
                println!(
                    "  if `replay --full` does reproduce, `fuzz minimize {} --full` starts from the whole group",
                    args.id
                );
            }
            ExitCode::SUCCESS
        }
        // Everything above this point stands: the step that killed the driver was
        // accepted, and the list on disk is still one that reproduces. What cannot be
        // trusted is any step *after* it, which is why there were none.
        minimize::Outcome::DriverGone(why) => {
            println!("  stopped: {why}");
            println!("  the step that did this was counted; reboot the machine and");
            println!("  `fuzz minimize {}` carries on from exactly here", args.id);
            ExitCode::from(EXIT_NO_DRIVER)
        }
    })
}

fn export(args: cli::ExportArgs) -> std::io::Result<ExitCode> {
    let store = Store::new(resolve_dir(&args.resume)?);
    let out = export::export(&store, args.id, &args.into)?;
    println!("finding {} written to {}", args.id, out.display());
    println!("  just run           runs it here");
    println!("  just arm <ip>      runs it on a board and says whether it still happens");
    println!("  src/main.rs is a skeleton until someone ports the case into it");
    Ok(ExitCode::SUCCESS)
}

fn quarantine(args: cli::QuarantineArgs) -> std::io::Result<ExitCode> {
    let base = args.base_dir.clone().unwrap_or_else(store::default_base_dir);
    let mut quarantine = quarantine::Quarantine::load(&base);

    if let Some(case) = &args.remove {
        let removed = quarantine.remove(case)?;
        println!("removed {removed} entr{}", if removed == 1 { "y" } else { "ies" });
        return Ok(ExitCode::SUCCESS);
    }

    if let Some(case) = &args.add {
        let Some(reason) = &args.reason else {
            eprintln!(
                "error: --add needs --reason. An exclusion nobody wrote a reason for is one nobody can safely remove later."
            );
            return Ok(ExitCode::FAILURE);
        };
        let added = quarantine.add(case, reason)?;
        println!(
            "{}",
            if added {
                "added"
            } else {
                "already covered by an existing entry"
            }
        );
        return Ok(ExitCode::SUCCESS);
    }

    if quarantine.is_empty() {
        println!("nothing is excluded ({}/quarantine.toml)", base.display());
        return Ok(ExitCode::SUCCESS);
    }
    println!("{}/quarantine.toml", base.display());
    for entry in quarantine.entries() {
        println!("  {}", entry.case);
        println!("      {}", entry.reason);
    }
    Ok(ExitCode::SUCCESS)
}

/// `fuzz verdicts` - which cases got which verdict in an epoch.
///
/// An epoch touches every case in a pool exactly once, so a campaign is a whole-corpus
/// screen as a side effect, and the per-case file that makes the epoch comparison
/// possible has had the answer in it all along. Before this, a group reported "4 fail"
/// and the four names existed only in a worker's stdout, which on a board is gone.
///
/// The indices only mean anything against the pool the campaign was built from, so a
/// corpus that has moved is refused rather than printed - the names would be real cases,
/// just not the ones that got those verdicts.
fn verdicts(args: cli::VerdictsArgs) -> std::io::Result<ExitCode> {
    let dir = resolve_dir(&args.resume)?;
    let store = Store::new(dir.clone());
    let campaign = store.read_campaign()?;
    let state = store.read_state()?;
    let pools = pool::build(&campaign.case_filters, &campaign.exclude_filters);

    for (expected, api) in campaign.pools.iter().zip(&state.apis) {
        if args.api.as_ref().is_some_and(|only| *only != expected.root) {
            continue;
        }
        let Some(pool) = pools.iter().find(|p| p.api.root() == expected.root) else {
            println!(
                "! {} is gone from this binary - its indices cannot be read",
                expected.root
            );
            continue;
        };
        if pool.fingerprint != expected.fingerprint {
            println!(
                "! {} has changed since this campaign started - its indices no longer name the same cases",
                expected.root
            );
            continue;
        }

        let epoch = args.epoch.unwrap_or(api.epoch);
        let tally = drift::tally(&dir, &expected.root, epoch, pool.names.len());
        if tally.is_empty() {
            println!("{} epoch {epoch}: nothing recorded", expected.root);
            continue;
        }
        let counts: Vec<String> = tally.iter().map(|(verdict, n)| format!("{n} {verdict}")).collect();
        println!("{} epoch {epoch}: {}", expected.root, counts.join(", "));

        for (case, verdict) in drift::cases_with(&dir, &expected.root, epoch, &pool.names, &args.status) {
            println!("  {verdict:<13} {case}");
        }
        println!();
    }
    Ok(ExitCode::SUCCESS)
}

fn status(args: cli::ResumeArgs) -> std::io::Result<ExitCode> {
    let dir = resolve_dir(&args)?;
    let store = Store::new(dir.clone());
    let campaign = store.read_campaign()?;
    let state = store.read_state()?;

    println!("{}", dir.display());
    println!("  started    {}", ago(campaign.created_epoch));
    println!("  seed       {:#018x}", campaign.seed);
    println!("  groups of  {}", campaign.group_size);
    println!("  iterations {}", state.iterations);
    println!("  findings   {}", state.findings);
    println!();

    println!(
        "  {:<12} {:>9} {:>7} {:>9}  epoch seed",
        "pool", "cases", "epoch", "group"
    );
    for (pool, api) in campaign.pools.iter().zip(&state.apis) {
        let per_epoch = pool.cases.div_ceil(campaign.group_size.max(1));
        println!(
            "  {:<12} {:>9} {:>7} {:>4}/{:<4}  {:#018x}",
            pool.root, pool.cases, api.epoch, api.group, per_epoch, api.epoch_seed
        );
    }
    println!();

    // The corpus can move under a campaign - a port lands, a group is removed - and
    // then every stored seed names a different set of cases. Reported here rather than
    // only refused at resume, because this is the command someone runs to find out why.
    let pools = pool::build(&campaign.case_filters, &campaign.exclude_filters);
    for expected in &campaign.pools {
        match pools.iter().find(|p| p.api.root() == expected.root) {
            Some(p) if p.fingerprint == expected.fingerprint => {}
            Some(p) => println!(
                "  ! {} has changed: {} cases then, {} now - this campaign cannot be resumed",
                expected.root,
                expected.cases,
                p.names.len()
            ),
            None => println!(
                "  ! {} is gone from this binary - this campaign cannot be resumed",
                expected.root
            ),
        }
    }

    // Ordered by how much a person can do with them: something that reproduces every
    // time is worth an hour, something that reproduced once out of five is worth
    // knowing about, and something that has never reproduced is a note, not a job.
    let findings = store.findings();
    if !findings.is_empty() {
        println!("  {:<4} {:<22} {:>9}  case", "id", "kind", "repro");
        for finding in &findings {
            let marker = if finding.repro.is_reproducible() { " " } else { "?" };
            println!(
                "  {marker}{:<3} {:<22} {:>9}  {}",
                finding.id,
                finding.severity.clone().unwrap_or_else(|| finding.kind.clone()),
                finding.repro.summary(),
                finding.culprit.clone().unwrap_or_else(|| "(no case named)".to_string())
            );
        }
        if findings.iter().any(|f| !f.repro.is_reproducible()) {
            println!("  ? = never reproduced. The list is still on disk; `fuzz replay <id>` asks again.");
        }
        println!();
    }

    match store.read_inflight() {
        Some(inflight) => {
            println!("  ! a group was in flight and never finished:");
            println!(
                "      {} epoch {} group {}, {} cases, started {}",
                inflight.api,
                inflight.epoch,
                inflight.group,
                inflight.size,
                ago(inflight.started_epoch)
            );
            println!("      {} of them had reported", store.read_progress());
            println!();
            println!("    say what happened:  fuzz gpucrash | fuzz systemcrash | fuzz continue");
            println!("    or, if you stopped it yourself:  fuzz continue --last-was-fine");
        }
        None => match &state.stopped {
            Some(why) => println!("  ! stopped: {why}"),
            None => println!("  idle - `fuzz continue` carries on"),
        },
    }

    Ok(ExitCode::SUCCESS)
}

fn probe(args: cli::ProbeArgs) -> ExitCode {
    let Some(api) = crate::runner::Api::from_case_name(&args.api) else {
        eprintln!(
            "error: '{}' is not a case-name root (dEQP-VK, dEQP-GLES2, dEQP-GLES3, dEQP-GLES31, KHR-GL30...KHR-GL46)",
            args.api
        );
        return ExitCode::FAILURE;
    };
    match health::probe_here(api, args.common.device_id, args.common.validation) {
        Ok(description) => {
            println!("{}{description}", health::PROBE_OK_PREFIX);
            ExitCode::SUCCESS
        }
        Err(e) => {
            eprintln!("{} did not come up: {e}", api.label());
            ExitCode::from(EXIT_NO_DRIVER)
        }
    }
}

fn print_plan(runner: &Runner) {
    let campaign = runner.campaign();
    println!("campaign {}", runner.store().dir.display());
    println!("  seed {:#018x}, groups of {}", campaign.seed, campaign.group_size);
    for pool in &campaign.pools {
        println!(
            "  {:<12} {:>9} cases, {} group(s) per epoch",
            pool.root,
            pool.cases,
            pool.cases.div_ceil(campaign.group_size.max(1))
        );
    }
    println!();
    flush();
}

fn resolve_dir(args: &cli::ResumeArgs) -> std::io::Result<PathBuf> {
    if let Some(dir) = &args.dir {
        return Ok(dir.clone());
    }
    let base = args.base_dir.clone().unwrap_or_else(store::default_base_dir);
    campaign::current_dir(&base).ok_or_else(|| {
        std::io::Error::other(format!(
            "no campaign to work on: {}/current points at nothing. Start one with `fuzz run`, or name one with --dir.",
            base.display()
        ))
    })
}

/// A label that does not collide, for when the caller did not supply one.
///
/// No date in it: this binary does not format clocks (see store.rs). The recipes and
/// `cts.sh` pass `--label` with a local timestamp, which is where a timestamp can be
/// trusted, so this is the fallback rather than the normal path.
fn next_free_label(base: &Path) -> String {
    for n in 1..10_000 {
        let label = format!("campaign-{n:04}");
        if !base.join(&label).exists() {
            return label;
        }
    }
    format!("campaign-{}", now_epoch())
}

fn random_seed() -> u64 {
    // Enough entropy to make two campaigns started in the same second differ, which is
    // all a seed needs: it is recorded, and reproducing a run means reusing it.
    let nanos = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .map(|d| d.as_nanos() as u64)
        .unwrap_or(0);
    rng::derive(nanos, "seed", u64::from(std::process::id()))
}

fn flush() {
    use std::io::Write;
    let _ = std::io::stdout().flush();
}

/// Stops two processes from driving one campaign at once.
///
/// Without it, a second `fuzz continue` - easy to type when the first is running
/// detached and quiet - would interleave writes to `state.json` and produce a campaign
/// whose cursor belongs to neither.
struct Lock(PathBuf);

impl Lock {
    fn acquire(dir: &Path) -> std::io::Result<Self> {
        let path = dir.join("lock");
        let holder = std::fs::read_to_string(&path)
            .ok()
            .and_then(|text| text.trim().parse::<u32>().ok())
            .filter(|pid| is_running(*pid));
        if let Some(pid) = holder {
            return Err(std::io::Error::other(format!(
                "campaign {} is already being driven by pid {pid} - stop that first, or use --dir for another campaign",
                dir.display()
            )));
        }
        std::fs::write(&path, std::process::id().to_string())?;
        Ok(Self(path))
    }
}

impl Drop for Lock {
    fn drop(&mut self) {
        let _ = std::fs::remove_file(&self.0);
    }
}

/// A stale lock is the normal case here - the previous holder was killed with the
/// machine - so a pid that is not running must not block anything.
fn is_running(pid: u32) -> bool {
    #[cfg(target_os = "linux")]
    {
        Path::new(&format!("/proc/{pid}")).exists()
    }
    #[cfg(not(target_os = "linux"))]
    {
        let _ = pid;
        false
    }
}

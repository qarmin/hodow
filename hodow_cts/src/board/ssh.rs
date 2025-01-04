// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// A real board, over the plain `ssh`/`scp` binaries so the host needs nothing linked in.
//
// A second ssh session follows the kernel log for the whole of each boot, into a file on
// this machine: it survives the board dying, and it sees a hang the moment the driver
// announces it rather than when a timeout runs out.

use std::io::{BufRead, BufReader, Write};
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::sync::atomic::{AtomicU64, Ordering};
use std::sync::mpsc::RecvTimeoutError;
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

#[cfg(unix)]
fn own_process_group(cmd: &mut Command) {
    use std::os::unix::process::CommandExt;
    cmd.process_group(0);
}

#[cfg(not(unix))]
fn own_process_group(_cmd: &mut Command) {}

use log::{info, warn};

use super::target::{Board, Fatal, FatalKind, Run, RunOpts, Stop};
use crate::report::CaseResult;
use crate::tcu::TestResult;

const BOARD_SCRIPT: &str = include_str!("../../scripts/board.sh");
const KERNEL_KEEP: usize = 4 << 20;

pub struct SshBoard {
    pub ip: String,
    user: String,
    ssh_opts: Vec<String>,
    env: String,
    timeout_secs: u64,
    quiet_units: Vec<String>,
    markers: Vec<String>,
    kernel_dir: Option<PathBuf>,
    follower: Option<Follower>,
    boot_id: Option<String>,
    fresh: bool,
}

struct Follower {
    child: Child,
    shared: Arc<KernelShared>,
}

struct KernelShared {
    recent: Mutex<String>,
    markers_seen: AtomicU64,
}

pub struct Options {
    pub user: String,
    pub ssh_opts: String,
    pub runtime_dir: String,
    pub wayland_display: String,
    pub timeout_secs: u64,
    pub quiet_units: String,
}

impl SshBoard {
    pub fn new(ip: &str, opts: &Options) -> Self {
        Self {
            ip: ip.to_string(),
            user: opts.user.clone(),
            ssh_opts: opts.ssh_opts.split_whitespace().map(str::to_string).collect(),
            env: format!(
                "XDG_RUNTIME_DIR={} WAYLAND_DISPLAY={}",
                sh_quote(&opts.runtime_dir),
                sh_quote(&opts.wayland_display)
            ),
            timeout_secs: opts.timeout_secs,
            quiet_units: opts.quiet_units.split_whitespace().map(str::to_string).collect(),
            markers: crate::runner::kmsg::DEFAULT_MARKERS
                .iter()
                .map(|m| (*m).to_string())
                .collect(),
            kernel_dir: None,
            follower: None,
            boot_id: None,
            fresh: false,
        }
    }

    pub fn set_markers(&mut self, markers: Vec<String>) {
        if !markers.is_empty() {
            self.markers = markers;
        }
    }

    pub fn set_kernel_dir(&mut self, dir: PathBuf) {
        self.kernel_dir = Some(dir);
        self.restart_follower();
    }

    fn ssh(&self, connect_timeout: u32) -> Command {
        let mut cmd = Command::new("ssh");
        cmd.args(&self.ssh_opts)
            .args([
                "-o",
                &format!("ConnectTimeout={connect_timeout}"),
                "-o",
                "BatchMode=yes",
            ])
            .args(["-o", "ServerAliveInterval=15", "-o", "ServerAliveCountMax=4"])
            .arg(format!("{}@{}", self.user, self.ip));
        own_process_group(&mut cmd);
        cmd
    }

    /// Runs a short remote command; `None` if ssh failed or it took longer than `limit`.
    pub fn exec(&self, remote: &str, limit: Duration) -> Option<(i32, String)> {
        let mut child = self
            .ssh(10)
            .arg(remote)
            .stdin(Stdio::null())
            .stdout(Stdio::piped())
            .stderr(Stdio::null())
            .spawn()
            .ok()?;
        let stdout = child.stdout.take()?;
        let reader = std::thread::spawn(move || {
            let mut text = String::new();
            let _ = std::io::Read::read_to_string(&mut BufReader::new(stdout), &mut text);
            text
        });
        let status = wait_limited(&mut child, limit)?;
        let text = reader.join().unwrap_or_default();
        let code = status.code().unwrap_or(-1);
        (code != 255).then_some((code, text))
    }

    pub fn reachable(&self) -> bool {
        self.exec("true", Duration::from_secs(25))
            .is_some_and(|(code, _)| code == 0)
    }

    fn read_boot_id(&self) -> Option<String> {
        let (code, text) = self.exec("cat /proc/sys/kernel/random/boot_id", Duration::from_secs(25))?;
        (code == 0 && !text.trim().is_empty()).then(|| text.trim().to_string())
    }

    pub fn identity(&self) -> Option<std::collections::BTreeMap<String, String>> {
        let remote = "for f in soc_id=/sys/devices/soc0/soc_id serial=/sys/devices/soc0/serial_number \
                      dt_serial=/proc/device-tree/serial-number machine_id=/etc/machine-id machine=/sys/devices/soc0/machine \
                      model=/proc/device-tree/model; do printf '%s=' \"${f%%=*}\"; tr -d '\\000\\n' < \"${f#*=}\" 2>/dev/null; echo; done; \
                      echo arch=$(uname -m)";
        let (code, text) = self.exec(remote, Duration::from_secs(30))?;
        (code == 0).then(|| {
            text.lines()
                .filter_map(|l| l.split_once('='))
                .map(|(k, v)| (k.to_string(), v.trim().to_string()))
                .collect()
        })
    }

    /// Copies `binary` over as `~/hodow_cts` unless the board already has exactly it, and
    /// `board.sh` as `~/cts.sh`. Returns the binary's sha256.
    pub fn deploy(&self, binary: &Path) -> std::io::Result<String> {
        let local = sha256(binary)?;
        let remote = self
            .exec("sha256sum ~/hodow_cts 2>/dev/null", Duration::from_secs(60))
            .map(|(_, t)| t.split_whitespace().next().unwrap_or("").to_string());
        if remote.as_deref() == Some(local.as_str()) {
            info!("The board already runs this hodow_cts ({})", &local[..12]);
        } else {
            info!(
                "Deploying hodow_cts ({}, {} MB)",
                &local[..12],
                std::fs::metadata(binary)?.len() >> 20
            );
            self.copy(binary, "hodow_cts.new")?;
            self.checked("chmod +x ~/hodow_cts.new && mv -f ~/hodow_cts.new ~/hodow_cts")?;
        }
        let script = std::env::temp_dir().join(format!("hodow-board-{}.sh", std::process::id()));
        std::fs::write(&script, BOARD_SCRIPT)?;
        let copied = self.copy(&script, "cts.sh");
        let _ = std::fs::remove_file(&script);
        copied?;
        self.checked("chmod +x ~/cts.sh")?;
        Ok(local)
    }

    fn copy(&self, local: &Path, remote: &str) -> std::io::Result<()> {
        let mut scp = Command::new("scp");
        scp.args(["-O", "-q"])
            .args(&self.ssh_opts)
            .args(["-o", "ConnectTimeout=10", "-o", "BatchMode=yes"])
            .arg(local)
            .arg(format!("{}@{}:{remote}", self.user, self.ip));
        own_process_group(&mut scp);
        let status = scp.status()?;
        if status.success() {
            Ok(())
        } else {
            Err(std::io::Error::other(format!(
                "scp of {} to the board failed",
                local.display()
            )))
        }
    }

    fn checked(&self, remote: &str) -> std::io::Result<String> {
        match self.exec(remote, Duration::from_secs(120)) {
            Some((0, text)) => Ok(text),
            Some((code, _)) => Err(std::io::Error::other(format!("`{remote}` exited {code} on the board"))),
            None => Err(std::io::Error::other(format!("`{remote}` did not finish on the board"))),
        }
    }

    pub fn list_cases(&self, patterns: &[String]) -> std::io::Result<Vec<String>> {
        let globs: Vec<String> = patterns.iter().map(|p| format!("--case {}", sh_quote(p))).collect();
        let text = self.checked(&format!("cd ~ && ./hodow_cts --list {}", globs.join(" ")))?;
        Ok(text
            .lines()
            .map(str::trim)
            .filter(|l| l.starts_with("dEQP-"))
            .map(str::to_string)
            .collect())
    }

    /// The driver line hodow_cts prints in its plan, e.g. `OpenGL ES 3.1 V6.4.3.p2.336687`.
    pub fn driver(&self) -> Option<String> {
        let (_, text) = self.exec(
            &format!(
                "cd ~ && {} ./hodow_cts --no-color --case dEQP-GLES2.info.version 2>&1",
                self.env
            ),
            Duration::from_secs(180),
        )?;
        text.lines().find_map(|line| {
            let mut words = line.split_whitespace();
            let root = words.next()?;
            let count = words.next()?;
            if !root.starts_with("dEQP-") || count.parse::<usize>().is_err() {
                return None;
            }
            let rest: Vec<&str> = words.collect();
            let rest = rest.join(" ");
            let driver = rest.split(" (").next().unwrap_or(&rest).trim().to_string();
            (!driver.is_empty() && !driver.contains("unavailable")).then_some(driver)
        })
    }

    pub fn hang_in_kernel_log(&self) -> bool {
        let pattern = self.markers.join("|").replace('\'', "");
        self.exec(&format!("dmesg | grep -cE '{pattern}'"), Duration::from_secs(30))
            .and_then(|(_, t)| t.trim().lines().last().and_then(|l| l.trim().parse::<u64>().ok()))
            .is_some_and(|n| n > 0)
    }

    pub fn quiet(&self) {
        for unit in &self.quiet_units {
            self.exec(
                &format!("systemctl stop {} 2>/dev/null; true", sh_quote(unit)),
                Duration::from_secs(120),
            );
        }
    }

    pub fn restore(&self) {
        for unit in &self.quiet_units {
            info!("Starting {unit} again");
            self.exec(
                &format!("systemctl start {} 2>/dev/null; true", sh_quote(unit)),
                Duration::from_secs(120),
            );
        }
    }

    fn kill_remote(&self) {
        self.exec(
            "for p in $(pgrep -x hodow_cts); do kill -9 $p; done; true",
            Duration::from_secs(30),
        );
    }

    fn restart_follower(&mut self) {
        if let Some(mut old) = self.follower.take() {
            let _ = old.child.kill();
            let _ = old.child.wait();
        }
        let Some(dir) = self.kernel_dir.clone() else {
            return;
        };
        let boot = self.boot_id.clone().unwrap_or_else(|| "unknown-boot".to_string());
        if std::fs::create_dir_all(&dir).is_err() {
            return;
        }
        let Ok(mut file) = std::fs::OpenOptions::new()
            .create(true)
            .append(true)
            .open(dir.join(format!("{boot}.log")))
        else {
            return;
        };
        let remote = "journalctl -kf -n 0 -o short-monotonic 2>/dev/null || dmesg -w";
        let Ok(mut child) = self
            .ssh(10)
            .arg(remote)
            .stdin(Stdio::null())
            .stdout(Stdio::piped())
            .stderr(Stdio::null())
            .spawn()
        else {
            return;
        };
        let Some(stdout) = child.stdout.take() else {
            return;
        };
        let shared = Arc::new(KernelShared {
            recent: Mutex::new(String::new()),
            markers_seen: AtomicU64::new(0),
        });
        let markers = self.markers.clone();
        let sink = Arc::clone(&shared);
        std::thread::spawn(move || {
            for line in BufReader::new(stdout).lines() {
                let Ok(line) = line else { break };
                let _ = writeln!(file, "{line}");
                if markers.iter().any(|m| line.contains(m.as_str())) {
                    sink.markers_seen.fetch_add(1, Ordering::Relaxed);
                }
                if let Ok(mut recent) = sink.recent.lock() {
                    recent.push_str(&line);
                    recent.push('\n');
                    if recent.len() > KERNEL_KEEP {
                        let cut = recent.len() - KERNEL_KEEP / 2;
                        let cut = (cut..recent.len()).find(|&i| recent.is_char_boundary(i)).unwrap_or(0);
                        recent.drain(..cut);
                    }
                }
            }
        });
        self.follower = Some(Follower { child, shared });
    }

    fn follower_alive(&mut self) -> bool {
        self.follower
            .as_mut()
            .is_some_and(|f| matches!(f.child.try_wait(), Ok(None)))
    }

    fn kernel_mark(&mut self) -> u64 {
        if !self.follower_alive() {
            self.restart_follower();
        }
        match &self.follower {
            Some(f) => {
                if let Ok(mut recent) = f.shared.recent.lock() {
                    recent.clear();
                }
                f.shared.markers_seen.load(Ordering::Relaxed)
            }
            None => 0,
        }
    }

    fn kernel_since(&self, mark: u64) -> (String, bool) {
        match &self.follower {
            Some(f) => {
                // The follower is a separate connection and may lag the run by a moment.
                std::thread::sleep(Duration::from_millis(500));
                let text = f.shared.recent.lock().map(|r| r.clone()).unwrap_or_default();
                (text, f.shared.markers_seen.load(Ordering::Relaxed) > mark)
            }
            None => (String::new(), false),
        }
    }

    fn after_boot(&mut self) {
        if super::interrupted() {
            return;
        }
        let started = Instant::now();
        while started.elapsed() < Duration::from_secs(180) && !super::interrupted() {
            if self
                .exec("systemctl is-active weston", Duration::from_secs(20))
                .is_some_and(|(_, t)| t.trim() == "active")
            {
                break;
            }
            std::thread::sleep(Duration::from_secs(5));
        }
        // "active" is not yet a compositor that hands out a display.
        std::thread::sleep(Duration::from_secs(15));
        self.quiet();
        self.boot_id = self.read_boot_id();
        self.restart_follower();
        self.fresh = true;
    }

    fn wait_for_new_boot(&self, was: &str, limit: Duration) -> bool {
        let started = Instant::now();
        std::thread::sleep(Duration::from_secs(20));
        while started.elapsed() < limit {
            if super::interrupted() {
                return false;
            }
            if let Some(now) = self.read_boot_id()
                && now != was
            {
                return true;
            }
            std::thread::sleep(Duration::from_secs(10));
        }
        false
    }

    fn wait_reachable(&self) {
        let started = Instant::now();
        let mut said = 0;
        while !self.reachable() {
            let minutes = started.elapsed().as_secs() / 60;
            if minutes >= said {
                warn!("The board has not answered ssh for {minutes} min - it needs a power cycle");
                said = minutes + 1;
            }
            if super::interrupted() {
                return;
            }
            std::thread::sleep(Duration::from_secs(15));
        }
    }
}

impl Board for SshBoard {
    fn run(&mut self, cases: &[String], opts: RunOpts, on_result: &mut dyn FnMut(&CaseResult)) -> Run {
        self.fresh = false;
        let mark = self.kernel_mark();
        let mut flags = format!(
            "--no-color --stop-on-crash --emit-results --timeout-secs {} --batch-size {}",
            self.timeout_secs,
            if opts.isolate_each { 1 } else { cases.len().max(1) }
        );
        if opts.isolate_each {
            flags.push_str(" --isolate-per-test");
        }
        if opts.dump_shaders {
            flags.push_str(" -v");
        }
        let dump = if opts.dump_shaders {
            " HODOW_CTS_DUMP_SHADERS=1"
        } else {
            ""
        };
        let remote = format!(
            "ulimit -c 0 2>/dev/null; cat > ~/board-cases.txt && cd ~ && {}{dump} ./hodow_cts {flags} --case-list board-cases.txt 2>&1; echo @exit $?",
            self.env
        );

        let mut results = Vec::new();
        let mut output = String::new();
        let spawned = self
            .ssh(10)
            .arg(&remote)
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn();
        let mut child = match spawned {
            Ok(child) => child,
            Err(e) => {
                warn!("Cannot start ssh: {e}");
                return self.lost(cases, results, output, mark, "ssh could not be started");
            }
        };
        if let Some(mut stdin) = child.stdin.take() {
            let mut text = cases.join("\n");
            text.push('\n');
            let _ = stdin.write_all(text.as_bytes());
        }
        let (tx, rx) = std::sync::mpsc::channel::<String>();
        for stream in [
            child
                .stdout
                .take()
                .map(|s| Box::new(s) as Box<dyn std::io::Read + Send>),
            child
                .stderr
                .take()
                .map(|s| Box::new(s) as Box<dyn std::io::Read + Send>),
        ]
        .into_iter()
        .flatten()
        {
            let tx = tx.clone();
            std::thread::spawn(move || {
                for line in BufReader::new(stream).lines() {
                    let Ok(line) = line else { break };
                    if tx.send(line).is_err() {
                        break;
                    }
                }
            });
        }
        drop(tx);

        let stall = Duration::from_secs(self.timeout_secs + 90);
        let mut wait = stall;
        let mut last_output = Instant::now();
        let mut exit: Option<i32> = None;
        let mut stalled = false;
        loop {
            match rx.recv_timeout(Duration::from_secs(1)) {
                Ok(line) => {
                    last_output = Instant::now();
                    if let Some(json) = line.strip_prefix(super::RESULT_PREFIX) {
                        if let Ok(result) = serde_json::from_str::<CaseResult>(json) {
                            // Only the summary is left to come, and a supervisor whose
                            // worker is stuck in the driver may never print it.
                            if is_fatal(result.status) {
                                wait = Duration::from_secs(15);
                            }
                            on_result(&result);
                            results.push(result);
                        }
                        continue;
                    }
                    if let Some(code) = line.strip_prefix("@exit ") {
                        exit = code.trim().parse().ok();
                        continue;
                    }
                    output.push_str(&line);
                    output.push('\n');
                }
                Err(RecvTimeoutError::Timeout) => {
                    if super::interrupted() {
                        let _ = child.kill();
                        let _ = child.wait();
                        self.kill_remote();
                        return Run {
                            results,
                            stop: Stop::Interrupted,
                            output,
                            kernel: String::new(),
                        };
                    }
                    if last_output.elapsed() >= wait {
                        stalled = true;
                        break;
                    }
                }
                Err(RecvTimeoutError::Disconnected) => break,
            }
        }
        let _ = child.kill();
        let _ = child.wait();

        let (kernel, marker) = self.kernel_since(mark);
        let lost_session = stalled || exit.is_none();
        let why = if stalled {
            format!("no output for {}s", stall.as_secs())
        } else {
            "the ssh session ended without an exit code".to_string()
        };
        if lost_session {
            if !self.reachable() {
                return self.lost(
                    cases,
                    results,
                    output,
                    mark,
                    &format!("{why}, and the board stopped answering ssh"),
                );
            }
            // A worker stuck in the driver can leave the supervisor stuck behind it.
            self.kill_remote();
        }

        if let Some(last) = results.last().filter(|r| is_fatal(r.status)) {
            let kernel_said = last.message.contains("the kernel reported") || marker;
            let kind = match last.status {
                _ if kernel_said => FatalKind::Hang,
                TestResult::Timeout => FatalKind::ClientHang,
                _ => FatalKind::Crash,
            };
            let fatal = Fatal {
                case: last.name.clone(),
                kind,
                message: last.message.clone(),
            };
            return Run {
                results,
                stop: Stop::Fatal(fatal),
                output,
                kernel,
            };
        }

        if lost_session {
            let Some(case) = cases.get(results.len()).cloned() else {
                return Run {
                    results,
                    stop: Stop::Finished,
                    output,
                    kernel,
                };
            };
            let kind = if marker || self.hang_in_kernel_log() {
                FatalKind::Hang
            } else {
                FatalKind::ClientHang
            };
            return Run {
                results,
                stop: Stop::Fatal(Fatal {
                    case,
                    kind,
                    message: why,
                }),
                output,
                kernel,
            };
        }

        let stop = if results.is_empty() && exit != Some(0) {
            Stop::NoDriver
        } else {
            Stop::Finished
        };
        Run {
            results,
            stop,
            output,
            kernel,
        }
    }

    fn healthy(&mut self) -> bool {
        let probe = vec!["dEQP-GLES2.info.vendor".to_string()];
        let run = self.run(&probe, RunOpts::default(), &mut |_| {});
        matches!(run.stop, Stop::Finished) && run.results.iter().any(|r| r.status == TestResult::Pass)
    }

    fn reboot(&mut self) {
        let started = Instant::now();
        let Some(was) = self.read_boot_id() else {
            warn!("Cannot reach the board to reboot it");
            self.wait_until_back();
            return;
        };
        for (method, trigger, limit) in [
            (
                "sysrq",
                "(sleep 1; echo 1 > /proc/sys/kernel/sysrq; echo s > /proc/sysrq-trigger; sleep 2; echo u > /proc/sysrq-trigger; sleep 1; echo b > /proc/sysrq-trigger) >/dev/null 2>&1 &",
                Duration::from_secs(180),
            ),
            (
                "force",
                "sync; (sleep 1; systemctl reboot --force) >/dev/null 2>&1 &",
                Duration::from_secs(600),
            ),
        ] {
            info!("Rebooting the board ({method})");
            self.exec(trigger, Duration::from_secs(20));
            if self.wait_for_new_boot(&was, limit) {
                self.wait_reachable();
                self.after_boot();
                info!("Board back after {:.0}s", started.elapsed().as_secs_f64());
                return;
            }
            if super::interrupted() {
                return;
            }
            warn!(
                "The board did not restart within {}s of a {method} reboot",
                limit.as_secs()
            );
        }
        self.wait_until_back();
    }

    fn wait_until_back(&mut self) {
        let before = self.boot_id.clone();
        self.wait_reachable();
        self.after_boot();
        if before.is_some() && before == self.boot_id {
            self.fresh = false;
            if !self.healthy() {
                warn!("The board came back without rebooting and its driver is gone - rebooting");
                self.reboot();
            }
        }
    }

    fn fresh(&self) -> bool {
        self.fresh
    }

    fn diag(&mut self) -> String {
        info!("Capturing what is stuck before rebooting");
        self.exec("cd ~ && ./cts.sh diag 2>&1", Duration::from_secs(120))
            .map(|(_, t)| t)
            .unwrap_or_default()
    }

    fn pause_for_driver(&mut self) {
        // Seen on the i.MX6 board: systemd's watchdog killed weston 40 s after a boot, and
        // with no compositor every run finds no driver until someone restarts it.
        let state = self
            .exec("systemctl is-active weston", Duration::from_secs(20))
            .map(|(_, t)| t.trim().to_string());
        if state.as_deref().is_some_and(|s| s != "active" && s != "activating") {
            warn!("weston is {} - restarting it", state.unwrap_or_default());
            self.exec("systemctl restart weston", Duration::from_secs(60));
        }
        std::thread::sleep(Duration::from_secs(15));
    }
}

impl SshBoard {
    fn lost(&mut self, cases: &[String], results: Vec<CaseResult>, output: String, mark: u64, why: &str) -> Run {
        let (kernel, _) = self.kernel_since(mark);
        let case = match results.last() {
            Some(last) if is_fatal(last.status) => last.name.clone(),
            _ => cases.get(results.len()).or(cases.last()).cloned().unwrap_or_default(),
        };
        Run {
            results,
            stop: Stop::Fatal(Fatal {
                case,
                kind: FatalKind::System,
                message: why.to_string(),
            }),
            output,
            kernel,
        }
    }

    pub fn initial_boot_id(&mut self) {
        self.boot_id = self.read_boot_id();
        self.restart_follower();
    }
}

impl Drop for SshBoard {
    fn drop(&mut self) {
        if let Some(mut f) = self.follower.take() {
            let _ = f.child.kill();
            let _ = f.child.wait();
        }
    }
}

fn is_fatal(status: TestResult) -> bool {
    matches!(status, TestResult::Crash | TestResult::Timeout | TestResult::DeviceLost)
}

fn wait_limited(child: &mut Child, limit: Duration) -> Option<std::process::ExitStatus> {
    let started = Instant::now();
    loop {
        match child.try_wait() {
            Ok(Some(status)) => return Some(status),
            Ok(None) if started.elapsed() < limit => std::thread::sleep(Duration::from_millis(100)),
            _ => {
                let _ = child.kill();
                let _ = child.wait();
                return None;
            }
        }
    }
}

fn sha256(path: &Path) -> std::io::Result<String> {
    let out = Command::new("sha256sum").arg(path).output()?;
    let text = String::from_utf8_lossy(&out.stdout);
    text.split_whitespace()
        .next()
        .map(str::to_string)
        .ok_or_else(|| std::io::Error::other("sha256sum printed nothing"))
}

pub fn sh_quote(text: &str) -> String {
    format!("'{}'", text.replace('\'', "'\\''"))
}

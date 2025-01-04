// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Killing a worker, and what to do when the kernel will not let it die.
//
// SIGKILL is not instant. A process sitting in an uninterruptible call inside a driver
// - state `D` - only takes the signal when that call returns, and a wedged GPU is
// exactly the case where it never does. `wait()` on such a child blocks forever, which
// turns a timeout that fired correctly into a supervisor that hangs with nothing left to
// say: the campaign looks frozen, the log stops mid-group, and the last thing anybody
// sees is whatever the case printed before the driver stopped answering.
//
// That is also why the machine then takes minutes to reboot rather than seconds: an
// unreapable process cannot be killed at shutdown either, so init waits out its whole
// stop timeout on it. The `D` here and the slow reboot are the same event.
//
// So the wait is bounded, and a child that outlives it is *reported* rather than waited
// on - with the kernel's own answer for where it is stuck (`/proc/<pid>/stack`, which
// names the driver function; readable by root, which is what a board runs as).

use std::process::Child;
use std::sync::atomic::{AtomicBool, Ordering};
use std::time::{Duration, Instant};

/// Whether this process has seen the driver stop serving.
///
/// Global because the one place that needs the answer - the end of `main` - is nowhere
/// near the one place that learns it, and threading a boolean through every layer in
/// between would say less than the name does.
static DRIVER_GONE: AtomicBool = AtomicBool::new(false);

pub fn mark_driver_gone() {
    DRIVER_GONE.store(true, Ordering::Relaxed);
}

pub fn driver_is_gone() -> bool {
    DRIVER_GONE.load(Ordering::Relaxed)
}

/// Ends the process without unwinding or running anything registered at exit.
///
/// For after the driver has stopped serving. This process brought a context up of its
/// own to build the case tree, and tearing that context down on a dead driver blocks in
/// `gckOS_AcquireMutex` on a mutex no living thread will release - so an ordinary return
/// from `main` hangs with the report already written and nothing left to do. Observed on
/// the board: the supervisor still sitting there minutes after printing its own summary.
///
/// What this does *not* do is make the process go away. A driver thread left in state
/// `D` keeps the task alive whatever the main thread does, so what is left behind is a
/// zombie rather than a process still working its way through teardown. That is the
/// difference worth having - it stops running code, releases nothing else, and says its
/// exit status - and the rest is the kernel's to give up, which it will not until the
/// machine is rebooted.
pub fn exit_without_teardown(code: u8) -> ! {
    use std::io::Write;
    let _ = std::io::stdout().flush();
    let _ = std::io::stderr().flush();

    unsafe extern "C" {
        fn _exit(code: std::ffi::c_int) -> !;
    }
    unsafe { _exit(code.into()) }
}

/// How long to wait for a killed worker before calling it stuck. Generous, because a
/// process that is merely slow to unwind a large address space is not the case of
/// interest and reporting it would be a false alarm.
pub const REAP_GRACE: Duration = Duration::from_secs(10);

pub enum Reaped {
    /// The child is gone and has been reaped.
    Exited,
    /// The child outlived SIGKILL: it is in the kernel, not in userspace, and nothing
    /// this process can do will retire it. It has *not* been waited on - doing so is
    /// precisely the call that never returns.
    Stuck(Stuck),
}

/// Everything known about a worker that would not die, in the order it helps.
pub struct Stuck {
    pub pid: u32,
    /// `/proc/<pid>/status`' State line - `D (disk sleep)` is the one that matters.
    pub state: String,
    /// The kernel symbol the task is blocked in, when the kernel exports it.
    pub wchan: String,
    /// The kernel-side stack, which names the driver it is stuck inside. Root only, and
    /// absent unless `CONFIG_STACKTRACE` is on.
    pub stack: Option<String>,
}

impl std::fmt::Display for Stuck {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "pid {} survived SIGKILL: state {}, blocked in {}",
            self.pid, self.state, self.wchan
        )
    }
}

impl Stuck {
    /// The multi-line form, for the one place that should print the kernel stack.
    pub fn report(&self) -> String {
        let mut out = format!(
            "worker {} did not die within {REAP_GRACE:?} of SIGKILL - it is stuck in the kernel, not in this process.\n  \
             state: {}\n  blocked in: {}",
            self.pid, self.state, self.wchan
        );
        match &self.stack {
            Some(stack) => {
                out.push_str("\n  kernel stack (the driver call that is not returning):");
                for line in stack.lines() {
                    out.push_str("\n    ");
                    out.push_str(line.trim());
                }
            }
            None => out.push_str("\n  kernel stack: unavailable (needs root and CONFIG_STACKTRACE)"),
        }
        out.push_str(
            "\n  Only a reboot clears this, and it is why the reboot itself takes minutes: \
             init cannot kill it either and waits out its stop timeout.",
        );
        out
    }
}

/// SIGKILL, then a bounded reap.
///
/// Returns as soon as the child is gone. If it is still there after `grace`, the child
/// is left unreaped - a zombie is preferable to a supervisor that never returns - and
/// what the kernel says about it comes back instead.
pub fn kill_and_reap(child: &mut Child, grace: Duration) -> Reaped {
    let _ = child.kill();
    let deadline = Instant::now() + grace;
    loop {
        match child.try_wait() {
            Ok(Some(_)) => return Reaped::Exited,
            // No such process: something else reaped it, which is as gone as it gets.
            Err(_) => return Reaped::Exited,
            Ok(None) if Instant::now() >= deadline => {
                // A task that reached `Z` between the last poll and now is not stuck, it
                // is one `wait()` away from gone - and reporting "survived SIGKILL:
                // state Z (zombie)" is a contradiction that sends whoever reads it
                // looking for a driver bug that is not there.
                let stuck = inspect(child.id());
                if stuck.state.starts_with('Z') && child.try_wait().is_ok_and(|s| s.is_some()) {
                    return Reaped::Exited;
                }
                return Reaped::Stuck(stuck);
            }
            Ok(None) => std::thread::sleep(Duration::from_millis(20)),
        }
    }
}

fn inspect(pid: u32) -> Stuck {
    Stuck {
        pid,
        state: proc_state(pid),
        wchan: read_proc(pid, "wchan")
            .map(|s| s.trim().to_string())
            .filter(|s| !s.is_empty())
            .unwrap_or_else(|| "unknown".to_string()),
        stack: read_proc(pid, "stack"),
    }
}

fn proc_state(pid: u32) -> String {
    let Some(status) = read_proc(pid, "status") else {
        return "unknown".to_string();
    };
    status
        .lines()
        .find_map(|line| line.strip_prefix("State:"))
        .map(|s| s.trim().to_string())
        .unwrap_or_else(|| "unknown".to_string())
}

fn read_proc(pid: u32, what: &str) -> Option<String> {
    std::fs::read_to_string(format!("/proc/{pid}/{what}")).ok()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_killable_child_is_reaped_well_inside_the_grace() {
        let mut child = std::process::Command::new("sleep")
            .arg("30")
            .spawn()
            .expect("spawn sleep");
        let started = Instant::now();
        assert!(matches!(kill_and_reap(&mut child, REAP_GRACE), Reaped::Exited));
        assert!(
            started.elapsed() < Duration::from_secs(5),
            "an ordinary child should not need the whole grace"
        );
    }

    #[test]
    fn proc_answers_for_a_live_process() {
        // No userspace way to manufacture a `D` state, so what is checked here is the
        // half that would silently return "unknown" if the parsing were wrong.
        let state = proc_state(std::process::id());
        assert!(
            state.starts_with('R') || state.starts_with('S'),
            "unexpected state for self: {state}"
        );
    }
}

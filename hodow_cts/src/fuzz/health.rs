// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Is the driver still there?
//
// After a group wedges a GPU, every later group reports a crash, every crash looks like
// a finding, and a campaign left running overnight fills its findings directory with
// several hundred records of one event. Two cheap signals stop that: a driver that no
// longer answers at all, and a run of groups all dying in a row (which catches the
// nastier case where the driver *does* come up but returns nothing but errors).
//
// The probe runs in a child process, not here. Bringing a context up in the supervisor
// would put driver state in the one process that has to survive the whole campaign, and
// doing it once per group means doing it a thousand times - on an embedded driver that
// is itself the shape of thing that leaks.

use std::process::Stdio;
use std::time::Duration;

use crate::runner::Api;
use crate::runner::reap::{self, Reaped};

/// The line a probe child prints on success, so the parent needs no parsing beyond a
/// prefix check.
pub const PROBE_OK_PREFIX: &str = "PROBE-OK ";

pub enum Health {
    Alive(String),
    Dead(String),
}

impl Health {
    pub fn is_alive(&self) -> bool {
        matches!(self, Self::Alive(_))
    }
}

/// Brings the API up in a child process and asks it who it is.
pub fn check(api: Api, device_id: usize, validation: bool, timeout: Duration) -> Health {
    let exe = match std::env::current_exe() {
        Ok(exe) => exe,
        Err(e) => return Health::Dead(format!("cannot find my own binary to probe with: {e}")),
    };

    let mut command = crate::runner::isolate::reexec_command(&exe);
    command
        .arg("fuzz")
        .arg("probe")
        .arg("--api")
        .arg(api.root())
        .arg("--device-id")
        .arg(device_id.to_string())
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::null());
    if validation {
        command.arg("--validation");
    }

    let mut child = match command.spawn() {
        Ok(child) => child,
        Err(e) => return Health::Dead(format!("cannot spawn a probe: {e}")),
    };

    // A probe that hangs is itself the answer - a driver that never returns from
    // context creation is as dead as one that refuses.
    let deadline = std::time::Instant::now() + timeout;
    loop {
        match child.try_wait() {
            Ok(Some(_)) => break,
            Ok(None) if std::time::Instant::now() >= deadline => {
                // Bounded, and never a plain `wait()`: a probe that hung inside the
                // driver does not die on SIGKILL either, and waiting on it here would
                // hang the supervisor in the one place whose job is to notice that the
                // driver is gone.
                if let Reaped::Stuck(stuck) = reap::kill_and_reap(&mut child, reap::REAP_GRACE) {
                    log::error!("{}", stuck.report());
                    return Health::Dead(format!(
                        "the driver did not answer within {timeout:?}, and the probe could not be killed - {stuck}"
                    ));
                }
                return Health::Dead(format!("the driver did not answer within {timeout:?}"));
            }
            Ok(None) => std::thread::sleep(Duration::from_millis(20)),
            Err(e) => return Health::Dead(format!("cannot wait for the probe: {e}")),
        }
    }

    let output = match child.wait_with_output() {
        Ok(output) => output,
        Err(e) => return Health::Dead(format!("cannot read the probe's answer: {e}")),
    };
    let stdout = String::from_utf8_lossy(&output.stdout);
    match stdout.lines().find_map(|l| l.strip_prefix(PROBE_OK_PREFIX)) {
        Some(description) => Health::Alive(description.trim().to_string()),
        None => Health::Dead("the driver did not come up".to_string()),
    }
}

/// Runs the probe in *this* process - the child side of `check`.
pub fn probe_here(api: Api, device_id: usize, validation: bool) -> Result<String, String> {
    match api {
        Api::Vulkan => crate::runner::vulkan::probe(device_id, validation).map_err(|e| e.to_string()),
        gl_api => {
            let api_types = gl_api.gl_api_types().expect("every non-Vulkan API is a GL one");
            crate::runner::gles::probe(api_types, device_id).map_err(|e| e.to_string())
        }
    }
}

/// Whether a run of consecutive dead groups has gone past what a single bug explains.
///
/// Separate from the probe because it catches the other failure: a driver that answers
/// the probe perfectly well and then fails every case put to it. Neither signal
/// subsumes the other, and both are cheap.
pub fn wedged_by_repetition(consecutive_crashes: usize, threshold: usize) -> bool {
    threshold > 0 && consecutive_crashes >= threshold
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_repetition_threshold_needs_that_many_in_a_row() {
        assert!(!wedged_by_repetition(2, 3));
        assert!(wedged_by_repetition(3, 3));
        assert!(wedged_by_repetition(9, 3));
    }

    /// Zero turns the signal off rather than firing on the first group, which is what
    /// somebody passing `--wedge-threshold 0` to disable it would expect.
    #[test]
    fn a_threshold_of_zero_never_fires() {
        assert!(!wedged_by_repetition(0, 0));
        assert!(!wedged_by_repetition(100, 0));
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Letting the kernel say the GPU is gone, instead of waiting to infer it.
//
// A worker that hangs the GPU is noticed by the no-progress timeout, which is 60 seconds
// by default and has to be: a case that is merely slow must not be killed. But the driver
// itself knows much sooner - Vivante's galcore runs a 20-second monitor timer, finds the
// front end and the shader cores not idle, dumps the GPU state and prints
//
//     [galcore]: Stop driver to keep scene.
//
// After that line nothing will run on that GPU again until the machine is rebooted, so
// the remaining 40 seconds of the timeout are spent waiting for something that has
// already happened and been announced. On a board where every hang costs a reboot, and a
// bisection is ten of them, that difference is most of an hour.
//
// Conservative on purpose. A false positive kills a case that was working, which is worse
// than waiting: only lines that mean "this driver has stopped serving" are listened for,
// and `HODOW_CTS_KMSG_MARKERS` (comma-separated) replaces the list for a driver whose
// wording is different.

use std::io::{BufRead, BufReader, Seek, SeekFrom};
use std::sync::mpsc::Receiver;

/// Lines after which the driver is not coming back on its own.
pub const DEFAULT_MARKERS: &[&str] = &[
    // Vivante galcore, `recovery=0`: it dumps the GPU state and stops serving. This is
    // the last line of the dump, and a dump is several thousand lines - so on a board
    // whose ring buffer is small it is also the one most likely to have been pushed out
    // by the time anyone looks, which is why it is not the only marker here.
    "Stop driver to keep scene",
    // The monitor timer's own finding, printed at the top of that dump: the front end and
    // the shader cores are still busy long after they should have finished.
    "FE not idle",
    "SH not idle",
    // galcore's hang report, whatever it decides to do about it afterwards.
    "GPU hang",
];

pub const MARKERS_ENV: &str = "HODOW_CTS_KMSG_MARKERS";

/// A reader of `/dev/kmsg` that reports only the lines above.
///
/// `None` from `start` is the ordinary case on a machine where the file is not readable -
/// an unprivileged container, a kernel without it - and costs nothing: the supervisor
/// falls back to its timeout, which is what it did before this existed.
pub struct KernelWatch {
    rx: Receiver<String>,
}

impl KernelWatch {
    pub fn start() -> Option<Self> {
        let mut file = std::fs::File::open("/dev/kmsg").ok()?;
        // Past whatever is already in the buffer: a hang from an earlier run is not this
        // run's, and attributing it here would blame the first case of the next group.
        file.seek(SeekFrom::End(0)).ok()?;

        let markers = markers();
        let (tx, rx) = std::sync::mpsc::channel();
        // Detached: the read blocks until the kernel says something, so there is nothing
        // to join. It goes when the process does.
        std::thread::spawn(move || {
            let reader = BufReader::new(file);
            for line in reader.lines() {
                // A line that cannot be read is the kernel's ring buffer having wrapped
                // past us. Nothing useful to recover, and retrying would spin.
                let Ok(line) = line else { break };
                if let Some(marker) = markers.iter().find(|m| line.contains(m.as_str())) {
                    // `prio,seq,time,flags;message` - the message is what a person reads.
                    let message = line.split_once(';').map(|(_, m)| m).unwrap_or(&line).trim().to_string();
                    if tx.send(format!("the kernel reported \"{marker}\": {message}")).is_err() {
                        break;
                    }
                }
            }
        });

        Some(Self { rx })
    }

    /// The first thing the kernel has said since the last call, if it said any of them.
    /// Never blocks.
    pub fn hang_reported(&self) -> Option<String> {
        // Disconnected is as good as empty here: the reader thread only ends when the
        // kernel buffer wrapped past it, and then there is nothing more it can say.
        self.rx.try_recv().ok()
    }
}

fn markers() -> Vec<String> {
    match std::env::var(MARKERS_ENV) {
        Ok(list) if !list.trim().is_empty() => list
            .split(',')
            .map(|m| m.trim().to_string())
            .filter(|m| !m.is_empty())
            .collect(),
        _ => DEFAULT_MARKERS.iter().map(|m| (*m).to_string()).collect(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_marker_list_comes_from_the_environment_when_it_is_set() {
        // Serialised by being one test: the variable is process-wide.
        unsafe { std::env::set_var(MARKERS_ENV, " one , two ,, ") };
        assert_eq!(markers(), vec!["one".to_string(), "two".to_string()]);

        unsafe { std::env::set_var(MARKERS_ENV, "   ") };
        assert_eq!(
            markers().len(),
            DEFAULT_MARKERS.len(),
            "a blank list must not disarm the watch"
        );

        unsafe { std::env::remove_var(MARKERS_ENV) };
        assert!(markers().iter().any(|m| m.contains("Stop driver")));
    }

    #[test]
    fn starting_it_never_panics_wherever_it_runs() {
        // On a board this opens; in an unprivileged container it does not. Both are fine
        // and the caller cannot tell the difference beyond `None`.
        if let Some(watch) = KernelWatch::start() {
            assert!(
                watch.hang_reported().is_none(),
                "nothing has been logged since it started"
            );
        }
    }
}

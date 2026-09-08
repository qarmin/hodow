// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Execution. Three layers:
//   `run_case_loop`   the API-agnostic bookkeeping around one case: timing, the log
//                     prefix, the summary, the result stream, the device-lost abort.
//   `vulkan` / `gles` bring the API up, then drive that loop.
//   `isolate`         runs one of those in a child process and supervises it.
//
// Cases run serially inside a batch, which is what upstream does. Overlapping GPU
// work would change timings and can both hide and manufacture failures, and the
// thing under test here is the driver, so the execution order has to stay boring.

pub mod gles;
pub mod isolate;
pub mod vulkan;

use crate::report::{CaseResult, JsonlWriter, Summary};
use crate::tcu::{FlatCase, TestResult, TestStatus};

pub const UPSTREAM_REVISION: &str = include_str!("../../upstream/COMMIT");

/// Which API a case belongs to, decided by the root of its name.
///
/// Upstream ships one binary per API (`deqp-vk`, `deqp-gles31`) and each builds a
/// single-root hierarchy. This binary holds several, so the root prefix - which is
/// part of the case name either way - is what says which driver to bring up.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Api {
    Vulkan,
    Gles31,
}

impl Api {
    pub const ALL: [Api; 2] = [Api::Vulkan, Api::Gles31];

    /// The root group name, i.e. the first component of every case name.
    pub fn root(self) -> &'static str {
        match self {
            Self::Vulkan => "dEQP-VK",
            Self::Gles31 => "dEQP-GLES31",
        }
    }

    /// What to call the API in a message meant for a person.
    pub fn label(self) -> &'static str {
        match self {
            Self::Vulkan => "Vulkan",
            Self::Gles31 => "OpenGL ES 3.1",
        }
    }

    pub fn from_case_name(name: &str) -> Option<Self> {
        Self::ALL.into_iter().find(|api| name.split('.').next() == Some(api.root()))
    }
}

/// Selects cases by the same glob rules deqp uses for `--deqp-case`: `*` matches any
/// run of characters, everything else is literal.
pub fn matches_filter(name: &str, pattern: &str) -> bool {
    fn go(name: &[u8], pat: &[u8]) -> bool {
        match pat.first() {
            None => name.is_empty(),
            Some(b'*') => (0..=name.len()).any(|i| go(&name[i..], &pat[1..])),
            Some(&c) => !name.is_empty() && name[0] == c && go(&name[1..], &pat[1..]),
        }
    }
    go(name.as_bytes(), pattern.as_bytes())
}

pub struct RunOptions {
    pub device_id: usize,
    pub validation: bool,
    /// Workers leave this off: the parent owns the header, and a second one in the
    /// middle of the stream would corrupt the file it is assembling.
    pub write_header: bool,
}

/// Runs `cases` through `run_one`, doing everything around a case that does not
/// depend on which API it tests.
///
/// The API-misuse message count (validation layer, `GL_KHR_debug`) is folded in by
/// `run_one` rather than here: what counts as misuse and how it is observed is the
/// one part of this that is not shared.
pub fn run_case_loop<C: ?Sized>(
    cases: &[&FlatCase<C>],
    writer: &mut JsonlWriter,
    on_result: &mut dyn FnMut(&CaseResult),
    mut run_one: impl FnMut(&FlatCase<C>) -> TestStatus,
) -> Result<Summary, Box<dyn std::error::Error>> {
    let mut summary = Summary::default();

    for flat in cases {
        let started = std::time::Instant::now();
        // Anything a test logs from here on is prefixed with this name. Upstream logs
        // into a per-case .qpa section, which does the same job; a bare line in a
        // terminal has nothing to tell you which of 20000 cases it came from.
        crate::color::set_current_case(&flat.full_name);

        let status = run_one(flat);

        crate::color::clear_current_case();
        let result = CaseResult::from_status(&flat.full_name, &status, started.elapsed().as_micros() as u64);
        summary.record(result.status);
        writer.write_case(&result)?;
        on_result(&result);

        // The device is unusable after this; carrying on would report every remaining
        // case as failing for a reason that has nothing to do with it.
        if result.status == TestResult::DeviceLost {
            log::error!("device lost - aborting this batch");
            break;
        }
    }

    Ok(summary)
}

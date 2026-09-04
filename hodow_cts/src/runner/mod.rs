// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Execution. Two layers:
//   `execute_batch` runs cases in this process against one device.
//   `isolate`       runs `execute_batch` in a child and supervises it.
//
// Cases run serially inside a batch, which is what upstream does. Overlapping GPU
// work would change timings and can both hide and manufacture failures, and the
// thing under test here is the driver, so the execution order has to stay boring.

pub mod isolate;

use crate::report::{CaseResult, JsonlWriter, RunHeader, Summary};
use crate::tcu::{FlatCase, TestResult, TestStatus};
use crate::vk::platform::{Platform, VALIDATION_MESSAGES};
use crate::vkt::Context;
use crate::vkt::context::select_physical_device;

pub const UPSTREAM_REVISION: &str = include_str!("../../upstream/COMMIT");

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

/// Runs `cases` in this process, reporting each result through `on_result` as soon as
/// it is known.
pub fn execute_selected(
    cases: &[&FlatCase],
    options: &RunOptions,
    writer: &mut JsonlWriter,
    mut on_result: impl FnMut(&CaseResult),
) -> Result<Summary, Box<dyn std::error::Error>> {
    let platform = Platform::new(options.validation)?;
    let physical_device = select_physical_device(&platform, options.device_id)?;

    // The collection is swapped per case, so any one is fine to start with.
    let first_programs = cases.first().map_or(crate::vk::programs::BinaryCollection::new(&[]), |c| c.case.programs());
    let mut context = Context::new(&platform, physical_device, first_programs)?;

    if options.write_header {
        let (major, minor, patch) = context.api_version();
        writer.write_header(&RunHeader {
            kind: "hodow_cts.run".to_string(),
            hodow_cts_version: env!("CARGO_PKG_VERSION").to_string(),
            upstream_revision: UPSTREAM_REVISION.trim().to_string(),
            device_name: context.device_name(),
            api_version: format!("{major}.{minor}.{patch}"),
            driver_kind: format!("{:?}", context.get_device_properties().device_type),
            translation_layer: cfg!(target_os = "macos"),
            validation_enabled: options.validation,
            total_cases: cases.len(),
        })?;
    }

    let mut summary = Summary::default();

    for flat in cases {
        let started = std::time::Instant::now();
        VALIDATION_MESSAGES.store(0, std::sync::atomic::Ordering::Relaxed);

        context.set_binary_collection(flat.case.programs());

        let status = match flat.case.check_support(&context) {
            Err(e) => e.to_status(),
            Ok(()) => {
                let mut instance = flat.case.create_instance(&context);
                match instance.iterate() {
                    Ok(status) => status,
                    Err(e) => e.to_status(),
                }
            }
        };

        // A validation message means this port misused the API. Without this, that
        // misuse reads as a driver failure, which is the exact confusion --validation
        // exists to remove.
        let status = match VALIDATION_MESSAGES.load(std::sync::atomic::Ordering::Relaxed) {
            0 => status,
            n if options.validation => TestStatus::new(TestResult::Fail, format!("{} ({n} validation message(s) - see log)", status.description())),
            _ => status,
        };

        let result = CaseResult::from_status(&flat.full_name, &status, started.elapsed().as_millis() as u64);
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

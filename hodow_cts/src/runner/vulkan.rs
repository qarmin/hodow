// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// The Vulkan half of the runner: bring an instance and a device up once per batch,
// then drive the shared case loop against them.

use crate::report::{CaseResult, JsonlWriter, RunHeader, Summary};
use crate::runner::{RunOptions, UPSTREAM_REVISION, run_case_loop};
use crate::tcu::{TestResult, TestStatus};
use crate::vk::platform::{Platform, VALIDATION_MESSAGES};
use crate::vkt::context::select_physical_device;
use crate::vkt::{Context, FlatCase};

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

    let validation = options.validation;
    run_case_loop(cases, writer, &mut on_result, move |flat| {
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
        match VALIDATION_MESSAGES.load(std::sync::atomic::Ordering::Relaxed) {
            0 => status,
            n if validation => TestStatus::new(TestResult::Fail, format!("{} ({n} validation message(s) - see log)", status.description())),
            _ => status,
        }
    })
}

// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// The OpenGL ES half of the runner: bring one context up per batch, then drive the
// shared case loop against it.
//
// One context for the whole batch, not one per case, matches how `deqp-gles31` runs a
// case list and is what makes a batch worth having. It has one consequence the Vulkan
// side does not have: GL state is global and persists across cases, so a case that
// leaves an error pending would otherwise be reported against the next one - hence the
// drain around each case.

use crate::glu::{self, ApiType, Context, ContextInfo, RenderContext};
use crate::report::{CaseResult, JsonlWriter, RunHeader, Summary};
use crate::runner::{RunOptions, UPSTREAM_REVISION, run_case_loop};
use crate::tcu::{TestResult, TestStatus};

/// Runs `cases` against a context of exactly one of `api_types`' versions, trying them
/// in order.
///
/// A driver that will give none of them is reported as unavailable, not as a suite of
/// failures: on a board whose driver stops at ES 2.0, the ES 3.1 cases were never given
/// a chance to run and must not be counted against it.
/// Brings the driver up and takes it straight down again, to answer "is this root
/// going to run at all, and on what" before a long run starts rather than after it.
pub fn probe(api_types: &[ApiType], device_id: usize) -> Result<String, Box<dyn std::error::Error>> {
    let render_context = create_render_context(api_types, device_id)?;
    let info = ContextInfo::create(render_context.functions());
    let (egl_major, egl_minor) = render_context.egl_version();
    Ok(format!(
        "{} (EGL {egl_major}.{egl_minor}, {} platform)",
        info.version,
        render_context.egl_platform()
    ))
}

fn create_render_context(api_types: &[ApiType], device_id: usize) -> Result<RenderContext, crate::eglw::LoadError> {
    let mut last_error = None;

    for api in api_types {
        match RenderContext::create(*api, device_id) {
            Ok(context) => return Ok(context),
            Err(error) => {
                if api_types.len() > 1 {
                    log::info!("no {} context ({error}); trying the next version down", api.label());
                }
                last_error = Some(error);
            }
        }
    }

    Err(last_error.expect("at least one context version is always offered"))
}

pub fn execute_selected(
    api_types: &[ApiType],
    cases: &[&glu::FlatCase],
    options: &RunOptions,
    writer: &mut JsonlWriter,
    mut on_start: impl FnMut(&str),
    mut on_result: impl FnMut(&CaseResult),
) -> Result<Summary, Box<dyn std::error::Error>> {
    let render_context = create_render_context(api_types, options.device_id)?;
    let context_info = ContextInfo::create(render_context.functions());

    if options.write_header {
        let (egl_major, egl_minor) = render_context.egl_version();
        writer.write_header(&RunHeader {
            kind: "hodow_cts.run".to_string(),
            hodow_cts_version: env!("CARGO_PKG_VERSION").to_string(),
            upstream_revision: UPSTREAM_REVISION.trim().to_string(),
            device_name: context_info.renderer.clone(),
            api_version: context_info.version.clone(),
            // Upstream reports the driver through these strings and nothing else, so
            // the vendor plus how the display was reached is what identifies a run.
            driver_kind: format!(
                "{} (EGL {egl_major}.{egl_minor}, {} platform)",
                context_info.vendor,
                render_context.egl_platform()
            ),
            translation_layer: cfg!(target_os = "macos"),
            validation_enabled: options.validation,
            total_cases: cases.len(),
        })?;
    }

    let context = Context {
        render_context,
        context_info,
    };
    let validation = options.validation;

    run_case_loop(cases, writer, &mut on_start, &mut on_result, |flat| {
        // Whatever the previous case left behind is not this one's fault.
        glu::drain_errors(context.gl());

        // The Khronos GL CTS clears to black before every case (`TestCaseWrapper::iterate`); a case that reads the
        // default framebuffer without drawing to it sees that. The ES wrappers upstream clear to a different colour and
        // this runner has never done it for them, which is why it is only the desktop contexts here.
        if context.context_type().api.desktop {
            let gl = context.gl();
            // SAFETY: two state setters and a clear on the current context.
            unsafe {
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(crate::glw::GL_COLOR_BUFFER_BIT);
            }
        }

        let status = match flat.case.check_support(&context) {
            Err(e) => e.to_status(),
            Ok(()) => match flat.case.iterate(&context) {
                Ok(status) => status,
                Err(e) => e.to_status(),
            },
        };

        // Every case starts from the initial GL state, which is what upstream's
        // `TestCaseWrapper::deinit` guarantees by calling `glu::resetState` after each
        // one. Several ported cases deliberately leave state behind - an incomplete
        // framebuffer bound, a program in use - and rely on this.
        if context.context_type().api.desktop {
            glu::reset_state_core(&context);
        } else {
            glu::reset_state_es(&context);
        }

        // A pending GL error after a case that reported Pass means the port made a
        // call upstream does not make, or ignored one it checks. That is the GL
        // equivalent of a validation message - and like it, it does not change the
        // verdict unless asked for, because `cts-diff` compares against `deqp-gles31`,
        // which does not fail a case for it either.
        let leftover = glu::drain_errors(context.gl());
        match leftover {
            0 => status,
            n if validation && status.code() == TestResult::Pass => TestStatus::new(
                TestResult::Fail,
                format!("{} ({n} GL error(s) left pending - see log)", status.description()),
            ),
            n => {
                log::warn!("{n} GL error(s) were left pending by this case");
                status
            }
        }
    })
}

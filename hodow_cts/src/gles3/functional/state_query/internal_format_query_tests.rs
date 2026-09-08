// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fInternalFormatQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};

/// `SamplesCase`
fn samples(case: &mut ApiCase<'_>, internal_format: GLenum, is_integer_internal_format: bool) {
    let gl = case.gl();

    let mut sample_counts = Guarded::<i32>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe {
        gl.get_internalformativ(glw::GL_RENDERBUFFER, internal_format, glw::GL_NUM_SAMPLE_COUNTS, 1, sample_counts.as_mut_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);

    if !sample_counts.verify_validity(case) {
        return;
    }

    let count = sample_counts.value();
    log::debug!("// sample counts is {count}");
    if count <= 0 {
        return;
    }

    let mut samples = vec![-1i32; count as usize];
    // SAFETY: the array is sized from GL_NUM_SAMPLE_COUNTS's own answer.
    unsafe {
        gl.get_internalformativ(glw::GL_RENDERBUFFER, internal_format, glw::GL_SAMPLES, count, samples.as_mut_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);

    let mut prev_sample_count = 0;
    for (ndx, sample_count) in samples.iter().copied().enumerate() {
        if sample_count <= 0 {
            case.fail(format!("expected sample count to be at least one; got {sample_count}"), "got invalid value");
        }

        if ndx != 0 && sample_count >= prev_sample_count {
            case.fail(
                format!(
                    "expected sample count to be ordered in descending order; got {prev_sample_count} at index {} and {sample_count} at index {ndx}",
                    ndx - 1
                ),
                "got invalid order",
            );
        }
        prev_sample_count = sample_count;
    }

    if !is_integer_internal_format {
        // The maximum value in SAMPLES is guaranteed to be at least MAX_SAMPLES.
        let mut max_samples = Guarded::<i32>::new();
        // SAFETY: one GLint out, guarded on both sides.
        unsafe { gl.get_integerv(glw::GL_MAX_SAMPLES, max_samples.as_mut_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        if max_samples.verify_validity(case) {
            let maximum_format_sample_count = samples[0];
            if maximum_format_sample_count < max_samples.value() {
                case.fail(
                    format!(
                        "expected maximum value in SAMPLES ({maximum_format_sample_count}) to be at least the value of MAX_SAMPLES ({})",
                        max_samples.value()
                    ),
                    "got invalid maximum sample count",
                );
            }
        }
    }
}

/// `SamplesBufferSizeCase`
fn samples_buffer_size(case: &mut ApiCase<'_>, internal_format: GLenum) {
    let gl = case.gl();

    let mut sample_counts = Guarded::<i32>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe {
        gl.get_internalformativ(glw::GL_RENDERBUFFER, internal_format, glw::GL_NUM_SAMPLE_COUNTS, 1, sample_counts.as_mut_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);

    if !sample_counts.verify_validity(case) {
        return;
    }

    // bufSize = 0 must leave the output alone.
    let mut query_target_value = -1i32;
    // SAFETY: a count of zero, so the driver must not write through the pointer.
    unsafe {
        gl.get_internalformativ(glw::GL_RENDERBUFFER, internal_format, glw::GL_NUM_SAMPLE_COUNTS, 0, &mut query_target_value);
    }
    case.expect_error(glw::GL_NO_ERROR);

    if query_target_value != -1 {
        case.fail("expected output variable not to be written to".to_string(), "got invalid write");
    }
}

/// `InternalFormatQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("internal_format");

    const INTERNAL_FORMATS: [(&str, GLenum, bool); 34] = [
        // color renderable
        ("r8", glw::GL_R8, false),
        ("rg8", glw::GL_RG8, false),
        ("rgb8", glw::GL_RGB8, false),
        ("rgb565", glw::GL_RGB565, false),
        ("rgba4", glw::GL_RGBA4, false),
        ("rgb5_a1", glw::GL_RGB5_A1, false),
        ("rgba8", glw::GL_RGBA8, false),
        ("rgb10_a2", glw::GL_RGB10_A2, false),
        ("rgb10_a2ui", glw::GL_RGB10_A2UI, true),
        ("srgb8_alpha8", glw::GL_SRGB8_ALPHA8, false),
        ("r8i", glw::GL_R8I, true),
        ("r8ui", glw::GL_R8UI, true),
        ("r16i", glw::GL_R16I, true),
        ("r16ui", glw::GL_R16UI, true),
        ("r32i", glw::GL_R32I, true),
        ("r32ui", glw::GL_R32UI, true),
        ("rg8i", glw::GL_RG8I, true),
        ("rg8ui", glw::GL_RG8UI, true),
        ("rg16i", glw::GL_RG16I, true),
        ("rg16ui", glw::GL_RG16UI, true),
        ("rg32i", glw::GL_RG32I, true),
        ("rg32ui", glw::GL_RG32UI, true),
        ("rgba8i", glw::GL_RGBA8I, true),
        ("rgba8ui", glw::GL_RGBA8UI, true),
        ("rgba16i", glw::GL_RGBA16I, true),
        ("rgba16ui", glw::GL_RGBA16UI, true),
        ("rgba32i", glw::GL_RGBA32I, true),
        ("rgba32ui", glw::GL_RGBA32UI, true),
        // depth renderable
        ("depth_component16", glw::GL_DEPTH_COMPONENT16, false),
        ("depth_component24", glw::GL_DEPTH_COMPONENT24, false),
        ("depth_component32f", glw::GL_DEPTH_COMPONENT32F, false),
        ("depth24_stencil8", glw::GL_DEPTH24_STENCIL8, false),
        ("depth32f_stencil8", glw::GL_DEPTH32F_STENCIL8, false),
        // stencil renderable
        ("stencil_index8", glw::GL_STENCIL_INDEX8, false),
    ];

    for (name, format, is_integer_format) in INTERNAL_FORMATS {
        add_api_case(&mut group, format!("{name}_samples"), move |case| samples(case, format, is_integer_format));
    }

    add_api_case(&mut group, "rgba8_samples_buffer", |case| samples_buffer_size(case, glw::GL_RGBA8));

    group
}

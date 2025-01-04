// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fInternalFormatQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum, GLint, GLsizei};

/// `FormatSamplesCase::FormatType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum FormatType {
    Color,
    Int,
    DepthStencil,
}

/// `FormatSamplesCase::init`
fn format_samples_supported(case: &mut ApiCase<'_>, target: GLenum, internal_format: GLenum) -> bool {
    let is_texture_target = target == glw::GL_TEXTURE_2D_MULTISAMPLE || target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY;
    if case.context().context_type().supports(3, 2) {
        return true;
    }

    if target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        && !case
            .context()
            .context_info
            .is_extension_supported("GL_OES_texture_storage_multisample_2d_array")
    {
        case.not_supported("Test requires OES_texture_storage_multisample_2d_array extension or a context version equal or higher than 3.2");
        return false;
    }

    // stencil8 textures need GL_OES_texture_stencil8 below ES 3.2.
    if is_texture_target
        && internal_format == glw::GL_STENCIL_INDEX8
        && !case
            .context()
            .context_info
            .is_extension_supported("GL_OES_texture_stencil8")
    {
        case.not_supported(
            "Test requires GL_OES_texture_stencil8 extension or a context version equal or higher than 3.2",
        );
        return false;
    }

    true
}

/// `FormatSamplesCase::iterate`
fn format_samples_case(case: &mut ApiCase<'_>, target: GLenum, internal_format: GLenum, format_type: FormatType) {
    if !format_samples_supported(case, target, internal_format) {
        return;
    }

    let is_es32 = case.context().context_type().supports(3, 2);
    let mut is_float_format = false;
    if is_es32 {
        if matches!(
            internal_format,
            glw::GL_RGBA16F | glw::GL_R32F | glw::GL_RG32F | glw::GL_RGBA32F
        ) {
            is_float_format = true;
        }
    } else if matches!(
        internal_format,
        glw::GL_RGBA16F
            | glw::GL_R32F
            | glw::GL_RG32F
            | glw::GL_RGBA32F
            | glw::GL_R16F
            | glw::GL_RG16F
            | glw::GL_R11F_G11F_B10F
    ) {
        case.not_supported("The internal format is not supported in a context lower than 3.2");
        return;
    }

    // Lowest limit
    let samples_enum = match format_type {
        FormatType::Color => glw::GL_MAX_COLOR_TEXTURE_SAMPLES,
        FormatType::Int => glw::GL_MAX_INTEGER_SAMPLES,
        FormatType::DepthStencil => glw::GL_MAX_DEPTH_TEXTURE_SAMPLES,
    };
    let mut max_samples: GLint = 0;
    // SAFETY: one integer out.
    unsafe { case.gl().get_integerv(samples_enum, &raw mut max_samples) };
    case.expect_no_error("get MAX_*_SAMPLES");
    if max_samples < 1 {
        case.fail(
            format!("minimum value of the sample limit is 1, got {max_samples}"),
            "Invalid value",
        );
    }

    // Number of sample counts
    let mut num_sample_counts: GLint = 0;
    // SAFETY: one integer out, with bufSize = 1 to match.
    unsafe {
        case.gl().get_internalformativ(
            target,
            internal_format,
            glw::GL_NUM_SAMPLE_COUNTS,
            1,
            &raw mut num_sample_counts,
        )
    };
    case.expect_no_error("get GL_NUM_SAMPLE_COUNTS");

    if !is_float_format && num_sample_counts < 1 {
        case.fail(
            format!(
                "Format MUST support some multisample configuration, got GL_NUM_SAMPLE_COUNTS = {num_sample_counts}"
            ),
            "Invalid value",
        );
    }

    // Sample counts
    let mut samples = vec![
        0 as GLint;
        if num_sample_counts > 0 {
            num_sample_counts as usize
        } else {
            1
        }
    ];
    if num_sample_counts > 0 || is_float_format {
        // SAFETY: the buffer is sized from the count the query above reported.
        unsafe {
            case.gl().get_internalformativ(
                target,
                internal_format,
                glw::GL_SAMPLES,
                num_sample_counts as GLsizei,
                samples.as_mut_ptr(),
            )
        };
        case.expect_no_error("get GL_SAMPLES");
    } else {
        case.fail(
            "glGetInternalFormativ() reported 0 supported sample counts".to_string(),
            "Invalid value",
        );
        return;
    }

    // Samples are in order. Upstream's loop compares `samples[ndx - 1] <= samples[ndx]`
    // for a descending order, which is kept verbatim.
    for ndx in 1..samples.len() {
        if samples[ndx - 1] <= samples[ndx] {
            case.fail("Samples must be ordered descending.".to_string(), "Invalid value");
            break;
        }
    }

    // Samples are positive. Upstream starts at 1 and reads `[ndx - 1]`, so the last
    // element is never checked - kept as-is.
    for ndx in 1..samples.len() {
        if samples[ndx - 1] <= 0 {
            case.fail("Only positive SAMPLES allowed.".to_string(), "Invalid value");
            break;
        }
    }

    // maxSamples must be supported
    if !is_float_format && samples[0] < max_samples {
        case.fail(
            format!("MAX_*_SAMPLES must be supported, got {} < {max_samples}", samples[0]),
            "Invalid value",
        );
    }
}

/// Queries always return positive values, so this can never be a real answer.
const DEFAULT_VALUE: GLint = -123;

/// `NumSampleCountsBufferCase::iterate`
fn num_sample_counts_buffer_case(case: &mut ApiCase<'_>) {
    {
        let mut buffer: [GLint; 2] = [DEFAULT_VALUE, DEFAULT_VALUE];
        case.section("Querying GL_NUM_SAMPLE_COUNTS to larger-than-needed buffer.");
        // SAFETY: a two-element buffer with bufSize = 2.
        unsafe {
            case.gl().get_internalformativ(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                glw::GL_RGBA8,
                glw::GL_NUM_SAMPLE_COUNTS,
                2,
                buffer.as_mut_ptr(),
            )
        };
        case.expect_no_error("get GL_NUM_SAMPLE_COUNTS");

        if buffer[1] != DEFAULT_VALUE {
            case.fail(
                "trailing values were modified".to_string(),
                "Unexpected buffer modification",
            );
        }
    }

    {
        let mut buffer: [GLint; 1] = [DEFAULT_VALUE];
        case.section("Querying GL_NUM_SAMPLE_COUNTS to zero-sized buffer.");
        // SAFETY: bufSize = 0, so the driver must write nothing at all.
        unsafe {
            case.gl().get_internalformativ(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                glw::GL_RGBA8,
                glw::GL_NUM_SAMPLE_COUNTS,
                0,
                buffer.as_mut_ptr(),
            )
        };
        case.expect_no_error("get GL_NUM_SAMPLE_COUNTS");

        if buffer[0] != DEFAULT_VALUE {
            case.fail(
                "Query wrote over buffer bounds".to_string(),
                "Unexpected buffer modification",
            );
        }
    }
}

/// `SamplesBufferCase::iterate`
fn samples_buffer_case(case: &mut ApiCase<'_>) {
    let mut num_sample_counts: GLint = 0;
    // SAFETY: one integer out.
    unsafe {
        case.gl().get_internalformativ(
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            glw::GL_RGBA8,
            glw::GL_NUM_SAMPLE_COUNTS,
            1,
            &raw mut num_sample_counts,
        )
    };
    case.expect_no_error("get GL_NUM_SAMPLE_COUNTS");

    if num_sample_counts < 1 {
        case.fail(
            format!(
                "Format MUST support some multisample configuration, got GL_NUM_SAMPLE_COUNTS = {num_sample_counts}"
            ),
            "Unexpected buffer modification",
        );
        return;
    }

    {
        let mut buffer = vec![DEFAULT_VALUE; (num_sample_counts + 1) as usize];
        case.section("Querying GL_SAMPLES to larger-than-needed buffer.");
        let size = buffer.len() as GLsizei;
        // SAFETY: bufSize is the buffer's own length.
        unsafe {
            case.gl().get_internalformativ(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                glw::GL_RGBA8,
                glw::GL_SAMPLES,
                size,
                buffer.as_mut_ptr(),
            )
        };
        case.expect_no_error("get GL_SAMPLES");

        if buffer.last().copied() != Some(DEFAULT_VALUE) {
            case.fail(
                "trailing value was modified".to_string(),
                "Unexpected buffer modification",
            );
        }
    }

    if num_sample_counts > 2 {
        let mut buffer: [GLint; 3] = [DEFAULT_VALUE; 3];
        case.section("Querying GL_SAMPLES to buffer with bufSize=2.");
        // SAFETY: bufSize = 2 into a three-element buffer, so the third stays untouched.
        unsafe {
            case.gl().get_internalformativ(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                glw::GL_RGBA8,
                glw::GL_SAMPLES,
                2,
                buffer.as_mut_ptr(),
            )
        };
        case.expect_no_error("get GL_SAMPLES");

        if buffer[2] != DEFAULT_VALUE {
            case.fail(
                "Query wrote over buffer bounds".to_string(),
                "Unexpected buffer modification",
            );
        }
    }

    {
        let mut buffer: [GLint; 1] = [DEFAULT_VALUE];
        case.section("Querying GL_SAMPLES to zero-sized buffer.");
        // SAFETY: bufSize = 0.
        unsafe {
            case.gl().get_internalformativ(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                glw::GL_RGBA8,
                glw::GL_SAMPLES,
                0,
                buffer.as_mut_ptr(),
            )
        };
        case.expect_no_error("get GL_SAMPLES");

        if buffer[0] != DEFAULT_VALUE {
            case.fail(
                "Query wrote over buffer bounds".to_string(),
                "Unexpected buffer modification",
            );
        }
    }
}

/// `internalFormats[]`
const INTERNAL_FORMATS: [(&str, GLenum, FormatType); 41] = [
    // color renderable
    ("r8", glw::GL_R8, FormatType::Color),
    ("rg8", glw::GL_RG8, FormatType::Color),
    ("rgb8", glw::GL_RGB8, FormatType::Color),
    ("rgb565", glw::GL_RGB565, FormatType::Color),
    ("rgba4", glw::GL_RGBA4, FormatType::Color),
    ("rgb5_a1", glw::GL_RGB5_A1, FormatType::Color),
    ("rgba8", glw::GL_RGBA8, FormatType::Color),
    ("rgb10_a2", glw::GL_RGB10_A2, FormatType::Color),
    ("rgb10_a2ui", glw::GL_RGB10_A2UI, FormatType::Int),
    ("srgb8_alpha8", glw::GL_SRGB8_ALPHA8, FormatType::Color),
    ("r8i", glw::GL_R8I, FormatType::Int),
    ("r8ui", glw::GL_R8UI, FormatType::Int),
    ("r16i", glw::GL_R16I, FormatType::Int),
    ("r16ui", glw::GL_R16UI, FormatType::Int),
    ("r32i", glw::GL_R32I, FormatType::Int),
    ("r32ui", glw::GL_R32UI, FormatType::Int),
    ("rg8i", glw::GL_RG8I, FormatType::Int),
    ("rg8ui", glw::GL_RG8UI, FormatType::Int),
    ("rg16i", glw::GL_RG16I, FormatType::Int),
    ("rg16ui", glw::GL_RG16UI, FormatType::Int),
    ("rg32i", glw::GL_RG32I, FormatType::Int),
    ("rg32ui", glw::GL_RG32UI, FormatType::Int),
    ("rgba8i", glw::GL_RGBA8I, FormatType::Int),
    ("rgba8ui", glw::GL_RGBA8UI, FormatType::Int),
    ("rgba16i", glw::GL_RGBA16I, FormatType::Int),
    ("rgba16ui", glw::GL_RGBA16UI, FormatType::Int),
    ("rgba32i", glw::GL_RGBA32I, FormatType::Int),
    ("rgba32ui", glw::GL_RGBA32UI, FormatType::Int),
    // float formats
    ("r16f", glw::GL_R16F, FormatType::Color),
    ("rg16f", glw::GL_RG16F, FormatType::Color),
    ("rgba16f", glw::GL_RGBA16F, FormatType::Color),
    ("r32f", glw::GL_R32F, FormatType::Int),
    ("rg32f", glw::GL_RG32F, FormatType::Int),
    ("rgba32f", glw::GL_RGBA32F, FormatType::Int),
    ("r11f_g11f_b10f", glw::GL_R11F_G11F_B10F, FormatType::Color),
    // depth renderable
    ("depth_component16", glw::GL_DEPTH_COMPONENT16, FormatType::DepthStencil),
    ("depth_component24", glw::GL_DEPTH_COMPONENT24, FormatType::DepthStencil),
    (
        "depth_component32f",
        glw::GL_DEPTH_COMPONENT32F,
        FormatType::DepthStencil,
    ),
    ("depth24_stencil8", glw::GL_DEPTH24_STENCIL8, FormatType::DepthStencil),
    ("depth32f_stencil8", glw::GL_DEPTH32F_STENCIL8, FormatType::DepthStencil),
    // stencil renderable
    ("stencil_index8", glw::GL_STENCIL_INDEX8, FormatType::DepthStencil),
    // GL_DEPTH24_STENCIL8 and GL_DEPTH32F_STENCIL8 are duplicates and are not repeated.
];

/// `textureTargets[]`
const TEXTURE_TARGETS: [(&str, GLenum); 3] = [
    ("renderbuffer", glw::GL_RENDERBUFFER),
    ("texture_2d_multisample", glw::GL_TEXTURE_2D_MULTISAMPLE),
    ("texture_2d_multisample_array", glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY),
];

/// `InternalFormatQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("internal_format");

    for (target_name, target) in TEXTURE_TARGETS {
        let mut target_group = TestCaseGroup::new(target_name);
        for (name, format, format_type) in INTERNAL_FORMATS {
            add_api_case(
                &mut target_group,
                format!("{name}_samples"),
                move |case: &mut ApiCase<'_>| {
                    format_samples_case(case, target, format, format_type);
                },
            );
        }
        group.add_child(target_group);
    }

    let mut partial = TestCaseGroup::new("partial_query");
    add_api_case(&mut partial, "num_sample_counts", num_sample_counts_buffer_case);
    add_api_case(&mut partial, "samples", samples_buffer_case);
    group.add_child(partial);

    group
}

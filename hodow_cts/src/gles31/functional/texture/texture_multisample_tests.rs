// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureMultisampleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. **The whole `multisample` group is
// now complete (157/157)**: the `negative` sub-group, each `samples_N` group's
// `sample_mask_*` (`SampleMaskCase`) and `use_*` (`MultisampleTextureUsageCase`)
// children (130 of the 140 `samples_N` cases) were ported first; `sample_position`
// (`SamplePosRasterizationTest`, the remaining 10) needed `tcu::rasterization_verifier`'s
// triangle-only `verify_triangle_group_rasterization`, added once that module existed.
// `convertToSceneSpec`'s own trick - offsetting the *reference* triangles by the queried
// `GL_SAMPLE_POSITION` rather than changing the verifier's assumed pixel center - is why
// this closed without any change to that module.
//
// One shape change: upstream's `NegativeTexParameterCase` returns `CONTINUE` and runs one
// texture type per `iterate()` call; here the six types are a loop inside one body. The
// verdict is the same either way - upstream sets PASS once in `init` and each iteration can
// only replace it with FAIL, which is exactly what `ApiCase` does with its first failure.

use std::ffi::c_void;

use crate::gles31::functional::multisample_shader_render_case::glsl_version_decl;
use crate::gls::state_query_util::Guarded;
use crate::glu::{
    self, ApiCase, Buffer, Context, Framebuffer, ProgramSources, Renderbuffer, ShaderProgram, TestCase, TestCaseGroup,
    Texture, add_api_case,
};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::rasterization_verifier::{
    RasterizationArguments, SceneTriangle, TriangleSceneSpec, VerificationMode, verify_triangle_group_rasterization,
};
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus, Vec2, Vec4};

/// `supportsES32orGL45`, as this file spells it. ES-only here, so the `core(4, 5)` branch
/// upstream also accepts cannot be reached.
fn supports_es32(context: &Context) -> bool {
    context.context_type().supports(3, 2)
}

/// `getFormatSamples` - the sample counts the implementation offers for `target`.
fn format_samples(case: &mut ApiCase<'_>, target: GLenum, internal_format: GLenum) -> Vec<GLint> {
    let mut sample_count: GLint = 0;
    // SAFETY: one integer output; the count query is what sizes the array below.
    unsafe {
        case.gl()
            .get_internalformativ(target, internal_format, glw::GL_NUM_SAMPLE_COUNTS, 1, &mut sample_count)
    };

    if sample_count <= 0 {
        return Vec::new();
    }

    let mut samples = vec![0; sample_count as usize];
    // SAFETY: the array has exactly `sample_count` entries, which is what was asked for.
    unsafe {
        case.gl().get_internalformativ(
            target,
            internal_format,
            glw::GL_SAMPLES,
            sample_count,
            samples.as_mut_ptr(),
        );
    }
    case.expect_no_error("get max samples");
    samples
}

/// `NegativeFramebufferCase::CaseType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum NegativeFramebuffer {
    DifferentNSamplesTex,
    DifferentNSamplesRbo,
    DifferentFixedTex,
    DifferentFixedRbo,
    NonZeroLevel,
}

/// `NegativeFramebufferCase::init` - which two sample counts the case will use, or `None`
/// when the implementation offers no pair that makes the case meaningful (upstream throws
/// `NotSupportedError` there).
fn pick_sample_counts(
    case: &mut ApiCase<'_>,
    case_type: NegativeFramebuffer,
    internal_format: GLenum,
) -> Option<(GLint, GLint)> {
    use NegativeFramebuffer as C;

    let color_attachment_texture = matches!(case_type, C::DifferentNSamplesTex | C::DifferentFixedTex);
    let color_attachment_rbo = matches!(case_type, C::DifferentNSamplesRbo | C::DifferentFixedRbo);
    let use_different_sample_counts = matches!(case_type, C::DifferentNSamplesTex | C::DifferentNSamplesRbo);

    let texture_samples = format_samples(case, glw::GL_TEXTURE_2D_MULTISAMPLE, internal_format);
    let rbo_samples = format_samples(case, glw::GL_RENDERBUFFER, internal_format);

    if texture_samples.is_empty() || rbo_samples.is_empty() {
        // `TCU_CHECK(!textureSamples.empty())`, which is a Fail.
        case.fail("no supported sample counts".to_string(), "no supported sample counts");
        return None;
    }

    if use_different_sample_counts {
        if color_attachment_texture {
            if texture_samples.len() >= 2 {
                return Some((texture_samples[0], texture_samples[1]));
            }
        } else if color_attachment_rbo {
            for tex in &texture_samples {
                for rbo in &rbo_samples {
                    if tex != rbo {
                        return Some((*tex, *rbo));
                    }
                }
            }
        }
        case.not_supported("Test requires multiple supported sample counts");
        return None;
    }

    if color_attachment_texture {
        return Some((texture_samples[0], texture_samples[0]));
    }
    if color_attachment_rbo {
        for tex in &texture_samples {
            for rbo in &rbo_samples {
                if tex == rbo {
                    return Some((*tex, *rbo));
                }
            }
        }
        case.not_supported("Test requires a sample count supported in both rbo and texture");
        return None;
    }

    // CASE_NON_ZERO_LEVEL: only attachment 0 is ever created.
    Some((texture_samples[0], -1))
}

/// `NegativeFramebufferCase::iterate`
fn negative_framebuffer_case(case: &mut ApiCase<'_>, case_type: NegativeFramebuffer) {
    use NegativeFramebuffer as C;

    const FBO_SIZE: GLsizei = 64;
    const INTERNAL_FORMAT: GLenum = glw::GL_RGBA8;

    let Some((num_samples0, num_samples1)) = pick_sample_counts(case, case_type, INTERNAL_FORMAT) else {
        return;
    };

    let color_attachment_texture = matches!(case_type, C::DifferentNSamplesTex | C::DifferentFixedTex);
    let color_attachment_rbo = matches!(case_type, C::DifferentNSamplesRbo | C::DifferentFixedRbo);
    let fixed_sample_locations0 = if case_type == C::DifferentNSamplesRbo {
        glw::TRUE
    } else {
        glw::FALSE
    };
    let fixed_sample_locations1 = if matches!(case_type, C::DifferentFixedTex | C::DifferentFixedRbo) {
        glw::TRUE
    } else {
        glw::FALSE
    };

    let gl = case.gl();
    let fbo = Framebuffer::new(gl);
    let tex0 = Texture::new(gl);

    // SAFETY: names this case generated; the storage call is given a supported sample count.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
    }
    case.expect_no_error("gen fbo");

    // SAFETY: as above.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, tex0.get());
        gl.tex_storage_2d_multisample(
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            num_samples0,
            INTERNAL_FORMAT,
            FBO_SIZE,
            FBO_SIZE,
            fixed_sample_locations0,
        );
    }
    case.expect_no_error("gen texture 0");

    let mut texture_samples: GLint = 0;
    // SAFETY: one integer output on a complete multisample texture.
    unsafe {
        gl.get_tex_level_parameteriv(
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            0,
            glw::GL_TEXTURE_SAMPLES,
            &mut texture_samples,
        )
    };

    if case_type == C::NonZeroLevel {
        // attaching non-zero level generates invalid value
        // SAFETY: the illegal level is what is being checked.
        let error = unsafe {
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                tex0.get(),
                5,
            );
            gl.get_error()
        };
        if error != glw::GL_INVALID_VALUE {
            case.fail(
                format!("ERROR! Expected GL_INVALID_VALUE, got {}", glw::error_name(error)),
                "Got wrong error code",
            );
        }
        return;
    }

    // SAFETY: level 0 of a complete multisample texture.
    unsafe {
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            tex0.get(),
            0,
        )
    };
    case.expect_no_error("attach to c0");

    let mut fb_samples: GLint = 0;
    // The second attachment lives as long as the status query below.
    let _tex1 = color_attachment_texture.then(|| {
        let tex1 = Texture::new(gl);
        // SAFETY: as for attachment 0.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, tex1.get());
            gl.tex_storage_2d_multisample(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                num_samples1,
                INTERNAL_FORMAT,
                FBO_SIZE,
                FBO_SIZE,
                fixed_sample_locations1,
            );
        }
        tex1
    });
    if let Some(tex1) = &_tex1 {
        case.expect_no_error("gen texture 1");
        // SAFETY: one integer output, then an attach of level 0.
        unsafe {
            gl.get_tex_level_parameteriv(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                0,
                glw::GL_TEXTURE_SAMPLES,
                &mut fb_samples,
            );
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT1,
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                tex1.get(),
                0,
            );
        }
        case.expect_no_error("attach to c1");
    }

    let _rbo = color_attachment_rbo.then(|| {
        let rbo = Renderbuffer::new(gl);
        // SAFETY: a name this case generated, given a supported sample count.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo.get());
            gl.renderbuffer_storage_multisample(
                glw::GL_RENDERBUFFER,
                num_samples1,
                INTERNAL_FORMAT,
                FBO_SIZE,
                FBO_SIZE,
            );
        }
        rbo
    });
    if let Some(rbo) = &_rbo {
        case.expect_no_error("gen rb");
        // SAFETY: one integer output, then the attach.
        unsafe {
            gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, glw::GL_RENDERBUFFER_SAMPLES, &mut fb_samples);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT1,
                glw::GL_RENDERBUFFER,
                rbo.get(),
            );
        }
        case.expect_no_error("attach to c1");
    }

    // SAFETY: a plain status query on the bound framebuffer.
    let status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };

    if texture_samples != fb_samples || fixed_sample_locations0 != fixed_sample_locations1 {
        // should not be complete
        if status != glw::GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE {
            case.fail(
                format!("ERROR! Expected GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE, got {status:#x}"),
                "Got wrong error code",
            );
        }
    } else if status != glw::GL_FRAMEBUFFER_COMPLETE {
        // should be complete
        case.fail(
            format!("ERROR! Expected GL_FRAMEBUFFER_COMPLETE, got {status:#x}"),
            "Got wrong error code",
        );
    }
}

/// `NegativeTexParameterCase::TexParam`, as `(pname, value, expected error)`. Upstream
/// spells the three as three parallel switches over the same enum; one table cannot drift.
const TEX_PARAMS: [(&str, GLenum, GLint, GLenum); 10] = [
    (
        "texture_min_filter",
        glw::GL_TEXTURE_MIN_FILTER,
        glw::GL_LINEAR as GLint,
        glw::GL_INVALID_ENUM,
    ),
    (
        "texture_mag_filter",
        glw::GL_TEXTURE_MAG_FILTER,
        glw::GL_LINEAR as GLint,
        glw::GL_INVALID_ENUM,
    ),
    (
        "texture_wrap_s",
        glw::GL_TEXTURE_WRAP_S,
        glw::GL_CLAMP_TO_EDGE as GLint,
        glw::GL_INVALID_ENUM,
    ),
    (
        "texture_wrap_t",
        glw::GL_TEXTURE_WRAP_T,
        glw::GL_CLAMP_TO_EDGE as GLint,
        glw::GL_INVALID_ENUM,
    ),
    (
        "texture_wrap_r",
        glw::GL_TEXTURE_WRAP_R,
        glw::GL_CLAMP_TO_EDGE as GLint,
        glw::GL_INVALID_ENUM,
    ),
    ("texture_min_lod", glw::GL_TEXTURE_MIN_LOD, 1, glw::GL_INVALID_ENUM),
    ("texture_max_lod", glw::GL_TEXTURE_MAX_LOD, 5, glw::GL_INVALID_ENUM),
    (
        "texture_compare_mode",
        glw::GL_TEXTURE_COMPARE_MODE,
        glw::GL_NONE as GLint,
        glw::GL_INVALID_ENUM,
    ),
    (
        "texture_compare_func",
        glw::GL_TEXTURE_COMPARE_FUNC,
        glw::GL_NOTEQUAL as GLint,
        glw::GL_INVALID_ENUM,
    ),
    (
        "texture_base_level",
        glw::GL_TEXTURE_BASE_LEVEL,
        2,
        glw::GL_INVALID_OPERATION,
    ),
];

/// `NegativeTexParameterCase::iterate`'s `types[]`
const TEX_PARAM_TYPES: [(GLenum, GLenum, bool); 6] = [
    (glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_RGBA8, false),
    (glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, glw::GL_RGBA8, true),
    (glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_R8I, false),
    (glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, glw::GL_R8I, true),
    (glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_R8UI, false),
    (glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, glw::GL_R8UI, true),
];

/// `NegativeTexParameterCase::iterate`
fn negative_tex_parameter_case(case: &mut ApiCase<'_>, pname: GLenum, value: GLint, expected_error: GLenum) {
    let supports_array = supports_es32(case.context())
        || case
            .context()
            .context_info
            .is_extension_supported("GL_OES_texture_storage_multisample_2d_array");

    for (target, internal_format, is_array_type) in TEX_PARAM_TYPES {
        if is_array_type && !supports_array {
            log::debug!("GL_OES_texture_storage_multisample_2d_array not supported, skipping target");
            continue;
        }

        let texture = Texture::new(case.gl());
        // SAFETY: a name this case generated, given a complete multisample storage.
        unsafe {
            case.gl().bind_texture(target, texture.get());
            if is_array_type {
                case.gl()
                    .tex_storage_3d_multisample(target, 1, internal_format, 16, 16, 16, glw::FALSE);
            } else {
                case.gl()
                    .tex_storage_2d_multisample(target, 1, internal_format, 16, 16, glw::FALSE);
            }
        }
        case.expect_no_error("setup texture");

        // SAFETY: the parameter that a multisample target does not accept is the check.
        let error = unsafe {
            case.gl().tex_parameteri(target, pname, value);
            case.gl().get_error()
        };

        // expect failure
        if error != expected_error {
            case.fail(
                format!(
                    "Got unexpected error: {}, expected: {}",
                    glw::error_name(error),
                    glw::error_name(expected_error)
                ),
                "Got wrong error code",
            );
        }
    }
}

/// `NegativeTexureSampleCase::SampleCountParam`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SampleCountParam {
    High,
    Zero,
}

/// `NegativeTexureSampleCase::iterate`
fn negative_texture_sample_case(case: &mut ApiCase<'_>, param: SampleCountParam) {
    let expected_error = if param == SampleCountParam::High {
        glw::GL_INVALID_OPERATION
    } else {
        glw::GL_INVALID_VALUE
    };

    // calc samples
    let samples = match param {
        SampleCountParam::High => {
            let mut max_samples = Guarded::<GLint>::new();
            // SAFETY: one integer output, guarded on both sides.
            unsafe {
                case.gl().get_internalformativ(
                    glw::GL_TEXTURE_2D_MULTISAMPLE,
                    glw::GL_RGBA8,
                    glw::GL_SAMPLES,
                    1,
                    max_samples.as_mut_ptr(),
                );
            }
            case.expect_no_error("glGetInternalformativ");
            max_samples.value() + 1
        }
        SampleCountParam::Zero => 0,
    };

    // create texture with bad values
    let texture = Texture::new(case.gl());
    // SAFETY: the out-of-range sample count is what is being checked.
    let error = unsafe {
        case.gl().bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, texture.get());
        case.gl().tex_storage_2d_multisample(
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            samples,
            glw::GL_RGBA8,
            64,
            64,
            glw::FALSE,
        );
        case.gl().get_error()
    };

    // expect failure
    if error != expected_error {
        case.fail(
            format!(
                "Got unexpected error: {}, expected: {}",
                glw::error_name(error),
                glw::error_name(expected_error)
            ),
            "Got wrong error code",
        );
    }
}

/// `TextureMultisampleTests::init`'s `.negative` sub-group.
fn negative_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("negative");

    for (name, case_type) in [
        (
            "fbo_attach_different_sample_count_tex_tex",
            NegativeFramebuffer::DifferentNSamplesTex,
        ),
        (
            "fbo_attach_different_sample_count_tex_rbo",
            NegativeFramebuffer::DifferentNSamplesRbo,
        ),
        (
            "fbo_attach_different_fixed_state_tex_tex",
            NegativeFramebuffer::DifferentFixedTex,
        ),
        (
            "fbo_attach_different_fixed_state_tex_rbo",
            NegativeFramebuffer::DifferentFixedRbo,
        ),
        ("fbo_attach_non_zero_level", NegativeFramebuffer::NonZeroLevel),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            negative_framebuffer_case(case, case_type)
        });
    }

    for (name, pname, value, expected_error) in TEX_PARAMS {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            negative_tex_parameter_case(case, pname, value, expected_error)
        });
    }

    add_api_case(&mut group, "texture_high_sample_count", |case: &mut ApiCase<'_>| {
        negative_texture_sample_case(case, SampleCountParam::High);
    });
    add_api_case(&mut group, "texture_zero_sample_count", |case: &mut ApiCase<'_>| {
        negative_texture_sample_case(case, SampleCountParam::Zero);
    });

    group
}

/// `getEffectiveSampleMaskWordCount` - the number of 32-bit words needed to represent a
/// mask of `highest_bit_ndx + 1` bits. Only ever called here with `highest_bit_ndx >= 0`
/// (every call site below special-cases a negative sample index itself, see
/// `sample_mask_bitmask`'s own doc comment for why).
fn effective_sample_mask_word_count(highest_bit_ndx: i32) -> i32 {
    let mask_len = highest_bit_ndx + 1;
    (mask_len - 1) / 32 + 1
}

/// `genAllSetToNthBitSampleMask` - a mask with every bit below `nth_bit` set.
fn gen_all_set_to_nth_bit_sample_mask(nth_bit: i32) -> Vec<u32> {
    let num_words = effective_sample_mask_word_count(nth_bit - 1);
    let top_word_bits = (nth_bit - (num_words - 1) * 32) as u32;
    let mut mask = vec![0xFFFF_FFFFu32; (num_words - 1).max(0) as usize];
    mask.push(((1u64 << top_word_bits) - 1) as u32);
    mask
}

/// `genSetNthBitSampleMask` - a mask with only `nth_bit` set. `nth_bit` must be `>= 0`.
fn gen_set_nth_bit_sample_mask(nth_bit: i32) -> Vec<u32> {
    debug_assert!(nth_bit >= 0);
    let num_words = effective_sample_mask_word_count(nth_bit);
    let top_word_bits = (nth_bit - (num_words - 1) * 32) as u32;
    let mut mask = vec![0u32; (num_words - 1).max(0) as usize];
    mask.push(1u32 << top_word_bits);
    mask
}

/// `SampleMaskCase::CaseFlags`
#[derive(Clone, Copy, PartialEq, Eq)]
struct MaskFlags {
    alpha_to_coverage: bool,
    sample_coverage: bool,
    high_bits: bool,
}

/// `TextureMultisampleTests::init`'s `SampleMaskCase` registrations.
const MASK_VARIANTS: [(&str, MaskFlags); 5] = [
    (
        "sample_mask_only",
        MaskFlags {
            alpha_to_coverage: false,
            sample_coverage: false,
            high_bits: false,
        },
    ),
    (
        "sample_mask_and_alpha_to_coverage",
        MaskFlags {
            alpha_to_coverage: true,
            sample_coverage: false,
            high_bits: false,
        },
    ),
    (
        "sample_mask_and_sample_coverage",
        MaskFlags {
            alpha_to_coverage: false,
            sample_coverage: true,
            high_bits: false,
        },
    ),
    (
        "sample_mask_and_sample_coverage_and_alpha_to_coverage",
        MaskFlags {
            alpha_to_coverage: true,
            sample_coverage: true,
            high_bits: false,
        },
    ),
    (
        "sample_mask_non_effective_bits",
        MaskFlags {
            alpha_to_coverage: false,
            sample_coverage: false,
            high_bits: true,
        },
    ),
];

const MASK_CANVAS_SIZE: i32 = 256;
const MASK_GRIDSIZE: i32 = 16;

/// `SampleMaskCase::getMaxConformantSampleCount` - a local copy; the one
/// `multisample_shader_render_case.rs` already has is private to that file and upstream
/// itself duplicates this same helper between the two C++ files rather than sharing it.
fn get_max_conformant_sample_count(
    context: &Context,
    target: GLenum,
    internal_format: GLenum,
) -> Result<i32, TestError> {
    let gl = context.gl();
    let mut max_texture_samples = 0;

    if context
        .context_info
        .is_extension_supported("GL_NV_internalformat_sample_query")
    {
        let mut gl_sample_counts = 0;
        // SAFETY: a one-element query for a count.
        unsafe {
            gl.get_internalformativ(
                target,
                internal_format,
                glw::GL_NUM_SAMPLE_COUNTS,
                1,
                &mut gl_sample_counts,
            )
        };
        glu::expect_no_error(gl, "glGetInternalformativ() failed for GL_NUM_SAMPLE_COUNTS pname")?;

        let mut gl_supported_samples = vec![0i32; gl_sample_counts.max(0) as usize];
        // SAFETY: the array is sized from the count the driver just reported.
        unsafe {
            gl.get_internalformativ(
                target,
                internal_format,
                glw::GL_SAMPLES,
                gl_sample_counts,
                gl_supported_samples.as_mut_ptr(),
            )
        };

        for &samples in &gl_supported_samples {
            let mut is_conformant = 0;
            // SAFETY: the extension is present, so the entry point is loaded, and one
            // integer of output is asked for and given.
            unsafe {
                gl.get_internalformat_sampleiv_nv(
                    target,
                    internal_format,
                    samples,
                    glw::GL_CONFORMANT_NV,
                    1,
                    &mut is_conformant,
                )
            };
            glu::expect_no_error(gl, "glGetInternalformatSampleivNV() call(s) failed")?;

            if is_conformant != 0 && samples > max_texture_samples {
                max_texture_samples = samples;
            }
        }
    } else {
        // SAFETY: one integer of output, which is what GL_SAMPLES' first element is.
        unsafe { gl.get_internalformativ(target, internal_format, glw::GL_SAMPLES, 1, &mut max_texture_samples) };
    }

    Ok(max_texture_samples)
}

/// `SampleMaskCase::updateTexture`'s bitmask computation (`FLAGS_HIGH_BITS` and plain,
/// both branches).
///
/// Upstream calls `genSetNthBitSampleMask(sample)` unconditionally in the `FLAGS_HIGH_BITS`
/// branch, including on the first iteration where `sample == -1` - `nthBit - 1` there is
/// `-2`, which reaches `1ULL << 0xFFFFFFFF` (`topWordBits` underflows to `UINT32_MAX`),
/// undefined behaviour in the C++ (shifting by more than the type's width). It reliably
/// evaluates to a zero mask on the x86 toolchains this project checks against (the shift
/// count is masked to its low 6 bits by the `SHL` instruction, `0xFFFFFFFF & 63 == 63`,
/// and `1ULL << 63` cast down to a `uint32_t` keeps only the low 32 bits, all zero) -
/// exactly what the plain branch already does for `sample < 0` explicitly. This gives that
/// same, intended zero mask directly instead, rather than reproducing the UB.
fn sample_mask_bitmask(flags: MaskFlags, samples: i32, effective_word_count: i32, sample: i32) -> Vec<u32> {
    if sample < 0 {
        return vec![0u32; effective_word_count.max(0) as usize];
    }

    if !flags.high_bits {
        return gen_set_nth_bit_sample_mask(sample);
    }

    let raw_bitmask = gen_set_nth_bit_sample_mask(sample);
    let effective_mask = gen_all_set_to_nth_bit_sample_mask(samples);
    let mut total = vec![0u32; effective_mask.len()];
    for (word_ndx, total_word) in total.iter_mut().enumerate() {
        let random_mask = de_uint32_hash(((word_ndx as u32) << 2) ^ sample as u32);
        let sample_mask = raw_bitmask.get(word_ndx).copied().unwrap_or(0);
        let mask_mask = effective_mask[word_ndx];
        *total_word = (sample_mask & mask_mask) | (random_mask & !mask_mask);
    }
    total
}

/// `SampleMaskCase::genSamplerProgram`
fn gen_mask_sampler_program<'gl>(context: &'gl Context, samples: i32) -> ShaderProgram<'gl> {
    let version = glsl_version_decl(context);
    let vertex_source = format!(
        "{version}\n\
         in highp vec4 a_position;\n\
         void main (void)\n\
         {{\n\
         \x20   gl_Position = a_position;\n\
         }}\n"
    );
    let fragment_source = format!(
        "{version}\n\
         layout(location = 0) out highp vec4 fragColor;\n\
         uniform highp sampler2DMS u_sampler;\n\
         uniform highp int u_sample;\n\
         void main (void)\n\
         {{\n\
         \x20   highp float correctCoverage = 0.0;\n\
         \x20   highp float incorrectCoverage = 0.0;\n\
         \x20   highp ivec2 texelPos = ivec2(int(floor(gl_FragCoord.x)), int(floor(gl_FragCoord.y)));\n\
         \n\
         \x20   for (int sampleNdx = 0; sampleNdx < {samples}; ++sampleNdx)\n\
         \x20   {{\n\
         \x20       highp float sampleColor = texelFetch(u_sampler, texelPos, sampleNdx).r;\n\
         \x20       if (sampleNdx == u_sample)\n\
         \x20           correctCoverage += sampleColor;\n\
         \x20       else\n\
         \x20           incorrectCoverage += sampleColor;\n\
         \x20   }}\n\
         \x20   fragColor = vec4(correctCoverage, incorrectCoverage, 0.0, 1.0);\n\
         }}\n"
    );
    ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(vertex_source, fragment_source))
}

/// `SampleMaskCase::genAlphaProgram`
fn gen_mask_alpha_program(context: &Context) -> ShaderProgram<'_> {
    let version = glsl_version_decl(context);
    let vertex_source = format!(
        "{version}\n\
         in highp vec4 a_position;\n\
         out highp float v_alpha;\n\
         void main (void)\n\
         {{\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_alpha = (a_position.x * 0.5 + 0.5)*(a_position.y * 0.5 + 0.5);\n\
         }}\n"
    );
    let fragment_source = format!(
        "{version}\n\
         layout(location = 0) out highp vec4 fragColor;\n\
         in mediump float v_alpha;\n\
         void main (void)\n\
         {{\n\
         \x20   fragColor = vec4(1.0, 1.0, 1.0, v_alpha);\n\
         }}\n"
    );
    ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(vertex_source, fragment_source))
}

/// `SampleMaskCase`'s grid pattern - `m_gridsize * m_gridsize` cells, each two triangles
/// (six vertices), spanning `[-1, 1]^2`.
fn gen_mask_grid_data(gridsize: i32) -> Vec<f32> {
    let mut grid_data = Vec::with_capacity((gridsize * gridsize * 6 * 4) as usize);
    let gs = gridsize as f32;

    for y in 0..gridsize {
        for x in 0..gridsize {
            let fx0 = (x as f32) / gs * 2.0 - 1.0;
            let fx1 = (x as f32 + 1.0) / gs * 2.0 - 1.0;
            let fy0 = (y as f32) / gs * 2.0 - 1.0;
            let fy1 = (y as f32 + 1.0) / gs * 2.0 - 1.0;

            grid_data.extend_from_slice(&[fx0, fy0, 0.0, 1.0]);
            grid_data.extend_from_slice(&[fx0, fy1, 0.0, 1.0]);
            grid_data.extend_from_slice(&[fx1, fy1, 0.0, 1.0]);
            grid_data.extend_from_slice(&[fx0, fy0, 0.0, 1.0]);
            grid_data.extend_from_slice(&[fx1, fy1, 0.0, 1.0]);
            grid_data.extend_from_slice(&[fx1, fy0, 0.0, 1.0]);
        }
    }
    grid_data
}

/// `SampleMaskCase::updateTexture`
#[expect(
    clippy::too_many_arguments,
    reason = "matches upstream's own method, which reads just as many members"
)]
fn update_mask_texture(
    gl: &glw::Functions,
    fbo: &Framebuffer<'_>,
    grid_buffer: &Buffer<'_>,
    pos_loc: GLint,
    program: GLuint,
    samples: i32,
    effective_word_count: i32,
    flags: MaskFlags,
    sample: i32,
) -> Result<(), TestError> {
    // SAFETY: the framebuffer this case owns.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        gl.viewport(0, 0, MASK_CANVAS_SIZE, MASK_CANVAS_SIZE);
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let bitmask = sample_mask_bitmask(flags, samples, effective_word_count, sample);

    // SAFETY: a plain bitfield per word, matching `GL_MAX_SAMPLE_MASK_WORDS` already
    // checked supported by the caller.
    unsafe {
        gl.enable(glw::GL_SAMPLE_MASK);
        for word_ndx in 0..effective_word_count {
            let word_mask: glw::GLbitfield = bitmask.get(word_ndx as usize).copied().unwrap_or(0);
            gl.sample_maski(word_ndx as GLuint, word_mask);
        }
    }

    if flags.alpha_to_coverage {
        // SAFETY: plain state.
        unsafe { gl.enable(glw::GL_SAMPLE_ALPHA_TO_COVERAGE) };
    }
    if flags.sample_coverage {
        // SAFETY: plain state.
        unsafe { gl.enable(glw::GL_SAMPLE_COVERAGE) };
    }

    // SAFETY: the buffer this case's caller owns, holding the grid just built, and a
    // location queried from the linked program.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, grid_buffer.get());
        gl.vertex_attrib_pointer(pos_loc as GLuint, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
        gl.enable_vertex_attrib_array(pos_loc as GLuint);
        gl.use_program(program);
    }
    glu::expect_no_error(gl, "vertexAttribPointer")?;

    for y in 0..MASK_GRIDSIZE {
        for x in 0..MASK_GRIDSIZE {
            if flags.sample_coverage {
                let value = (y * MASK_GRIDSIZE + x) as f32 / (MASK_GRIDSIZE * MASK_GRIDSIZE) as f32;
                // SAFETY: plain state.
                unsafe { gl.sample_coverage(value, glw::FALSE) };
            }
            let first = (y * MASK_GRIDSIZE + x) * 6;
            // SAFETY: a complete framebuffer, a linked program with its attribute bound,
            // and six vertices per cell already uploaded.
            unsafe { gl.draw_arrays(glw::GL_TRIANGLES, first, 6) };
            glu::expect_no_error(gl, "drawArrays")?;
        }
    }

    // SAFETY: unbinding.
    unsafe {
        gl.disable_vertex_attrib_array(pos_loc as GLuint);
        gl.use_program(0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.disable(glw::GL_SAMPLE_MASK);
        gl.disable(glw::GL_SAMPLE_ALPHA_TO_COVERAGE);
        gl.disable(glw::GL_SAMPLE_COVERAGE);
    }
    glu::expect_no_error(gl, "clean")
}

/// The fullscreen quad `SampleMaskCase::drawSample` uploads - a different vertex order
/// from `MultisampleTextureUsageCase`'s own copy (both are upstream's own literal arrays,
/// declared separately there too, and any covers-the-viewport order is equivalent for a
/// plain colour-fill quad).
const MASK_FULLSCREEN_QUAD: [f32; 16] = [
    -1.0, 1.0, 0.0, 1.0, //
    -1.0, -1.0, 0.0, 1.0, //
    1.0, 1.0, 0.0, 1.0, //
    1.0, -1.0, 0.0, 1.0,
];

/// `SampleMaskCase::drawSample` plus `::verifyTexture`
#[expect(
    clippy::too_many_arguments,
    reason = "matches upstream's own method, which reads just as many members"
)]
fn verify_mask_texture(
    context: &Context,
    texture: &Texture<'_>,
    sampler_program: GLuint,
    pos_loc: GLint,
    sampler_loc: GLint,
    sample_loc: GLint,
    flags: MaskFlags,
    sample: i32,
) -> Result<bool, TestError> {
    let gl = context.gl();
    let vertex_buffer = Buffer::new(gl);

    // SAFETY: the texture this case's caller owns, and a buffer this call owns holding a
    // plain fullscreen quad.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, texture.get());
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&MASK_FULLSCREEN_QUAD) as isize,
            MASK_FULLSCREEN_QUAD.as_ptr().cast::<c_void>(),
            glw::GL_STATIC_DRAW,
        );
    }
    glu::expect_no_error(gl, "bufferData")?;

    // SAFETY: plain state setters, then a location queried from the linked program.
    unsafe {
        gl.viewport(0, 0, MASK_CANVAS_SIZE, MASK_CANVAS_SIZE);
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.vertex_attrib_pointer(pos_loc as GLuint, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
        gl.enable_vertex_attrib_array(pos_loc as GLuint);
    }
    glu::expect_no_error(gl, "vertexAttribPointer")?;

    // SAFETY: a linked program and uniform locations queried from it.
    unsafe {
        gl.use_program(sampler_program);
        gl.uniform_1i(sampler_loc, 0);
        gl.uniform_1i(sample_loc, sample);
    }
    glu::expect_no_error(gl, "useprogram")?;

    // SAFETY: a complete default framebuffer and a linked program with its inputs bound.
    unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
    glu::expect_no_error(gl, "drawArrays")?;

    // SAFETY: unbinding.
    unsafe {
        gl.disable_vertex_attrib_array(pos_loc as GLuint);
        gl.use_program(0);
    }
    glu::expect_no_error(gl, "cleanup")?;

    // SAFETY: waits for the draw above to land before reading it back.
    unsafe { gl.finish() };
    let mut result = Surface::new(MASK_CANVAS_SIZE, MASK_CANVAS_SIZE);
    glu::read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;
    glu::expect_no_error(gl, "readPixels")?;

    // Allow missing coverage with FLAGS_ALPHA_TO_COVERAGE and FLAGS_SAMPLE_COVERAGE, or if
    // there are no samples enabled (`sample == -1`).
    let allow_missing_coverage = flags.alpha_to_coverage || flags.sample_coverage || sample == -1;
    let mut error = false;
    for y in 0..MASK_CANVAS_SIZE {
        for x in 0..MASK_CANVAS_SIZE {
            let color = result.get_pixel(x, y);
            // disabled sample was written to
            if color.get_green() != 0 {
                error = true;
            // enabled sample was not written to
            } else if color.get_red() != 255 && !allow_missing_coverage {
                error = true;
            }
        }
    }
    Ok(!error)
}

/// `SampleMaskCase`
struct SampleMaskCase {
    name: String,
    samples: i32,
    flags: MaskFlags,
}

impl TestCase for SampleMaskCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `SampleMaskCase::init` plus `::iterate` run to completion - see the equivalent note
    /// on `MultisampleTextureUsageCase::iterate`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let effective_word_count = effective_sample_mask_word_count(self.samples - 1);

        let render_target = context.render_target();
        if render_target.width < MASK_CANVAS_SIZE || render_target.height < MASK_CANVAS_SIZE {
            return Err(TestError::NotSupported(format!(
                "render target size must be at least {MASK_CANVAS_SIZE}x{MASK_CANVAS_SIZE}"
            )));
        }

        let mut max_sample_mask_words: GLint = 0;
        // SAFETY: one integer of output.
        unsafe { gl.get_integerv(glw::GL_MAX_SAMPLE_MASK_WORDS, &mut max_sample_mask_words) };
        if effective_word_count > max_sample_mask_words {
            return Err(TestError::NotSupported(
                "Test requires larger GL_MAX_SAMPLE_MASK_WORDS".to_string(),
            ));
        }

        let max_samples = get_max_conformant_sample_count(context, glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_RGBA8)?;
        if self.samples > max_samples {
            return Err(TestError::NotSupported(
                "Requested sample count is greater than glGetInternalformativ(GL_SAMPLES) for this target/format"
                    .to_string(),
            ));
        }

        if self.flags.high_bits && self.samples % 32 == 0 {
            return Err(TestError::NotSupported(
                "Test requires unused high bits (sample count not multiple of 32)".to_string(),
            ));
        }

        let texture = Texture::new(gl);
        // SAFETY: a name this case generated, given a sample count already checked supported.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, texture.get());
            gl.tex_storage_2d_multisample(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                self.samples,
                glw::GL_RGBA8,
                MASK_CANVAS_SIZE,
                MASK_CANVAS_SIZE,
                glw::FALSE,
            );
        }
        glu::expect_no_error(gl, "texStorage2DMultisample")?;

        let fbo = Framebuffer::new(gl);
        // SAFETY: the framebuffer and texture this case owns.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                texture.get(),
                0,
            );
        }
        glu::expect_no_error(gl, "framebufferTexture2D")?;

        let grid_buffer = Buffer::new(gl);
        let grid_data = gen_mask_grid_data(MASK_GRIDSIZE);
        // SAFETY: a buffer this case owns, holding the grid just built.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, grid_buffer.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(grid_data.as_slice()) as isize,
                grid_data.as_ptr().cast::<c_void>(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "bufferData")?;

        let sampler_program = gen_mask_sampler_program(context, self.samples);
        if !sampler_program.is_ok() {
            return Err(TestError::Fail("Could not create sampler program.".to_string()));
        }
        // SAFETY: NUL-terminated names against a linked program.
        let (sampler_pos_loc, sampler_sampler_loc, sampler_sample_loc) = unsafe {
            (
                gl.get_attrib_location(sampler_program.program(), c"a_position".as_ptr()),
                gl.get_uniform_location(sampler_program.program(), c"u_sampler".as_ptr()),
                gl.get_uniform_location(sampler_program.program(), c"u_sample".as_ptr()),
            )
        };

        let alpha_program = gen_mask_alpha_program(context);
        if !alpha_program.is_ok() {
            return Err(TestError::Fail("Could not create aplha program.".to_string()));
        }
        // SAFETY: as above.
        let alpha_pos_loc = unsafe { gl.get_attrib_location(alpha_program.program(), c"a_position".as_ptr()) };

        let mut all_ok = true;
        for sample in -1..self.samples {
            update_mask_texture(
                gl,
                &fbo,
                &grid_buffer,
                alpha_pos_loc,
                alpha_program.program(),
                self.samples,
                effective_word_count,
                self.flags,
                sample,
            )?;
            if !verify_mask_texture(
                context,
                &texture,
                sampler_program.program(),
                sampler_pos_loc,
                sampler_sampler_loc,
                sampler_sample_loc,
                self.flags,
                sample,
            )? {
                all_ok = false;
            }
        }

        Ok(if all_ok {
            TestStatus::pass("Pass")
        } else if self.flags.high_bits {
            TestStatus::fail("Unused mask bits have effect")
        } else {
            TestStatus::fail("Sample test failed")
        })
    }
}

/// `MultisampleTextureUsageCase::TextureType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum UsageTextureType {
    Color2D,
    Color2DArray,
    Int2D,
    Int2DArray,
    Uint2D,
    Uint2DArray,
    Depth2D,
    Depth2DArray,
}

impl UsageTextureType {
    fn is_color(self) -> bool {
        matches!(self, Self::Color2D | Self::Color2DArray)
    }
    fn is_signed(self) -> bool {
        matches!(self, Self::Int2D | Self::Int2DArray)
    }
    fn is_unsigned(self) -> bool {
        matches!(self, Self::Uint2D | Self::Uint2DArray)
    }
    fn is_depth(self) -> bool {
        matches!(self, Self::Depth2D | Self::Depth2DArray)
    }
    fn is_array(self) -> bool {
        matches!(
            self,
            Self::Color2DArray | Self::Int2DArray | Self::Uint2DArray | Self::Depth2DArray
        )
    }
}

/// `TextureMultisampleTests::init`'s `textureTypes[]`
const USAGE_TEXTURE_TYPES: [(&str, UsageTextureType); 8] = [
    ("texture_color_2d", UsageTextureType::Color2D),
    ("texture_color_2d_array", UsageTextureType::Color2DArray),
    ("texture_int_2d", UsageTextureType::Int2D),
    ("texture_int_2d_array", UsageTextureType::Int2DArray),
    ("texture_uint_2d", UsageTextureType::Uint2D),
    ("texture_uint_2d_array", UsageTextureType::Uint2DArray),
    ("texture_depth_2d", UsageTextureType::Depth2D),
    ("texture_depth_2d_array", UsageTextureType::Depth2DArray),
];

/// `TextureMultisampleTests::init`'s `sampleCounts[]` - a fixed list upstream itself
/// hardcodes, not one this port derived; every case checks its own requested count
/// against `glGetInternalformativ(..., GL_SAMPLES, ...)` at run time and reports
/// NotSupported rather than assuming the list matches every driver.
const SAMPLE_COUNTS: [i32; 10] = [1, 2, 3, 4, 8, 10, 12, 13, 16, 64];

const USAGE_TEXTURE_SIZE: i32 = 256;
const USAGE_TEXTURE_ARRAY_SIZE: i32 = 8;
const USAGE_TEXTURE_LAYER: i32 = 3;

/// `deInt32Hash` - a local copy; `multisample_tests.rs` (a different upstream file,
/// `es31fMultisampleTests.cpp`) has its own, and upstream does not share this between
/// files either.
fn de_int32_hash(a: i32) -> u32 {
    #[expect(
        clippy::cast_sign_loss,
        reason = "upstream reinterprets the bits, exactly what `as u32` does here"
    )]
    let mut key = a as u32;
    key = (key ^ 61) ^ (key >> 16);
    key = key.wrapping_add(key << 3);
    key ^= key >> 4;
    key = key.wrapping_mul(0x27d4_eb2d);
    key ^= key >> 15;
    key
}

/// `deUint32Hash`
fn de_uint32_hash(v: u32) -> u32 {
    #[expect(
        clippy::cast_possible_wrap,
        reason = "upstream reinterprets the bits, exactly what `as i32` does here"
    )]
    de_int32_hash(v as i32)
}

const SAMPLE_POS_CANVAS_SIZE: i32 = 256;

/// `SamplePosRasterizationTest::init`'s `m_testTriangles` - 20 vertical spikes, 20
/// horizontal spikes, a 20-triangle fan and one fixed triangle, 61 total, transcribed
/// verbatim (including the `i + 1/(i+1)` spike-width term, never zero since `i + 1 >= 1`).
fn sample_pos_test_triangles() -> Vec<[Vec4; 3]> {
    let mut triangles = Vec::with_capacity(61);

    for i in 0..20 {
        let i = i as f32;
        let x = (i + 1.0 / (i + 1.0)) / 20.0;
        let x2 = (i + 0.3 + 1.0 / (i + 1.0)) / 20.0;
        triangles.push([
            Vec4::new(x, 0.0, 0.0, 1.0),
            Vec4::new(x2, 0.0, 0.0, 1.0),
            Vec4::new(x, -1.0, 0.0, 1.0),
        ]);
    }
    for i in 0..20 {
        let i = i as f32;
        let y = (i + 1.0 / (i + 1.0)) / 20.0;
        let y2 = (i + 0.3 + 1.0 / (i + 1.0)) / 20.0;
        triangles.push([
            Vec4::new(-1.0, y, 0.0, 1.0),
            Vec4::new(-1.0, y2, 0.0, 1.0),
            Vec4::new(0.0, y, 0.0, 1.0),
        ]);
    }
    for i in 0..20 {
        let angle = (i as f32) / 20.0 * std::f32::consts::PI * 2.0;
        let p = [angle.cos() * 0.5 + 0.5, angle.sin() * 0.5 + 0.5];
        let d = [0.1, 0.02];
        triangles.push([
            Vec4::new(0.4, 0.4, 0.0, 1.0),
            Vec4::new(p[0], p[1], 0.0, 1.0),
            Vec4::new(p[0] + d[0], p[1] + d[1], 0.0, 1.0),
        ]);
    }
    triangles.push([
        Vec4::new(-0.202, -0.202, 0.0, 1.0),
        Vec4::new(-0.802, -0.202, 0.0, 1.0),
        Vec4::new(-0.802, -0.802, 0.0, 1.0),
    ]);

    triangles
}

/// `SamplePosRasterizationTest::genMultisampleTexture`'s plain white-fill program.
fn gen_sample_pos_draw_program(context: &Context) -> ShaderProgram<'_> {
    let version = glsl_version_decl(context);
    let vertex_source =
        format!("{version}\nin highp vec4 a_position;\nvoid main (void)\n{{\n    gl_Position = a_position;\n}}\n");
    let fragment_source = format!(
        "{version}\nlayout(location = 0) out highp vec4 fragColor;\nvoid main (void)\n{{\n    fragColor = vec4(1.0, 1.0, 1.0, 1.0);\n}}\n"
    );
    ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(vertex_source, fragment_source))
}

/// `SamplePosRasterizationTest::genSamplerProgram`.
fn gen_sample_pos_sampler_program(context: &Context) -> ShaderProgram<'_> {
    let version = glsl_version_decl(context);
    let vertex_source =
        format!("{version}\nin highp vec4 a_position;\nvoid main (void)\n{{\n    gl_Position = a_position;\n}}\n");
    let fragment_source = format!(
        "{version}\n\
         layout(location = 0) out highp vec4 fragColor;\n\
         uniform highp sampler2DMS u_sampler;\n\
         uniform highp int u_sample;\n\
         void main (void)\n\
         {{\n\
         \x20   fragColor = texelFetch(u_sampler, ivec2(int(floor(gl_FragCoord.x)), int(floor(gl_FragCoord.y))), u_sample);\n\
         }}\n"
    );
    ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(vertex_source, fragment_source))
}

/// `SamplePosRasterizationTest` - draws a fixed test pattern into a real multisample
/// texture, then for each sample index extracts just that one sample layer (via
/// `texelFetch(sampler2DMS, ..., sampleNdx)`) into the default framebuffer and compares
/// it against `tcu::rasterization_verifier`. `convertToSceneSpec`'s own trick is what
/// makes this work with a verifier that only ever assumes a pixel-center sample point:
/// it shifts the *reference* triangles by `queried_sample_position - 0.5` instead, so the
/// verifier itself needed no multisample-aware pixel-center logic added to it.
struct SamplePosRasterizationTest {
    samples: i32,
}

impl TestCase for SamplePosRasterizationTest {
    fn name(&self) -> &str {
        "sample_position"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        if render_target.width < SAMPLE_POS_CANVAS_SIZE || render_target.height < SAMPLE_POS_CANVAS_SIZE {
            return Err(TestError::NotSupported(format!(
                "render target size must be at least {SAMPLE_POS_CANVAS_SIZE}x{SAMPLE_POS_CANVAS_SIZE}"
            )));
        }

        let mut max_samples: GLint = 0;
        // SAFETY: one integer of output.
        unsafe { gl.get_integerv(glw::GL_MAX_COLOR_TEXTURE_SAMPLES, &mut max_samples) };
        if self.samples > max_samples {
            return Err(TestError::NotSupported(
                "Requested sample count is greater than GL_MAX_COLOR_TEXTURE_SAMPLES".to_string(),
            ));
        }

        let mut subpixel_bits: GLint = 0;
        // SAFETY: one integer of output.
        unsafe { gl.get_integerv(glw::GL_SUBPIXEL_BITS, &mut subpixel_bits) };

        let texture = Texture::new(gl);
        // SAFETY: a name this case just generated, given a sample count already checked
        // supported.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, texture.get());
            gl.tex_storage_2d_multisample(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                self.samples,
                glw::GL_RGBA8,
                SAMPLE_POS_CANVAS_SIZE,
                SAMPLE_POS_CANVAS_SIZE,
                glw::TRUE,
            );
        }
        glu::expect_no_error(gl, "texStorage2DMultisample")?;

        let vertex_buffer = Buffer::new(gl);
        let triangles = sample_pos_test_triangles();
        let draw_program = gen_sample_pos_draw_program(context);
        if !draw_program.is_ok() {
            return Err(TestError::Fail("could not build shader".to_string()));
        }
        // SAFETY: a NUL-terminated name against a linked program.
        let pos_loc = unsafe { gl.get_attrib_location(draw_program.program(), c"a_position".as_ptr()) };

        // `genMultisampleTexture`: attach the texture to an FBO, query every sample's
        // real position, draw the test pattern into it, then let the FBO (but not the
        // texture, which keeps its multisample image) drop - matching upstream's own
        // `gl.deleteFramebuffers` at the end of that method.
        let mut sample_positions = Vec::with_capacity(self.samples as usize);
        {
            let fbo = Framebuffer::new(gl);
            // SAFETY: an FBO and texture this call owns.
            unsafe {
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D_MULTISAMPLE,
                    texture.get(),
                    0,
                );
            }
            glu::expect_no_error(gl, "framebufferTexture2D")?;

            for sample_ndx in 0..self.samples {
                let mut position = [0.0f32; 2];
                // SAFETY: one sample index, two floats of output.
                unsafe { gl.get_multisamplefv(glw::GL_SAMPLE_POSITION, sample_ndx as GLuint, position.as_mut_ptr()) };
                glu::expect_no_error(gl, "getMultisamplefv")?;
                if !(0.0..=1.0).contains(&position[0]) || !(0.0..=1.0).contains(&position[1]) {
                    return Err(TestError::Fail(format!(
                        "invalid sample position for sample {sample_ndx}: {position:?}"
                    )));
                }
                sample_positions.push(Vec2::new(position[0], position[1]));
            }

            let flat: Vec<f32> = triangles.iter().flatten().flat_map(|v| v.m_data).collect();
            // SAFETY: a buffer this call owns, holding exactly `triangles.len() * 3`
            // vertices' worth of 4 components each.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buffer.get());
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    std::mem::size_of_val(flat.as_slice()) as isize,
                    flat.as_ptr().cast::<c_void>(),
                    glw::GL_STATIC_DRAW,
                );

                gl.viewport(0, 0, SAMPLE_POS_CANVAS_SIZE, SAMPLE_POS_CANVAS_SIZE);
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.vertex_attrib_pointer(pos_loc as GLuint, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
                gl.enable_vertex_attrib_array(pos_loc as GLuint);
                gl.use_program(draw_program.program());
                gl.draw_arrays(glw::GL_TRIANGLES, 0, (triangles.len() * 3) as GLsizei);
            }
            glu::expect_no_error(gl, "drawArrays")?;
            // SAFETY: unbinding.
            unsafe {
                gl.disable_vertex_attrib_array(pos_loc as GLuint);
                gl.use_program(0);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            }
            glu::expect_no_error(gl, "cleanup")?;
        }

        let sampler_program = gen_sample_pos_sampler_program(context);
        if !sampler_program.is_ok() {
            return Err(TestError::Fail("Could not create sampler program.".to_string()));
        }
        // SAFETY: NUL-terminated names against a linked program.
        let (sampler_pos_loc, sampler_loc, sample_ndx_loc) = unsafe {
            (
                gl.get_attrib_location(sampler_program.program(), c"a_position".as_ptr()),
                gl.get_uniform_location(sampler_program.program(), c"u_sampler".as_ptr()),
                gl.get_uniform_location(sampler_program.program(), c"u_sample".as_ptr()),
            )
        };

        const FULLSCREEN_QUAD: [f32; 16] = [
            -1.0, 1.0, 0.0, 1.0, -1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0,
        ];
        let pf = render_target.pixel_format();
        let args = RasterizationArguments {
            num_samples: 0,
            subpixel_bits,
            red_bits: pf.red_bits,
            green_bits: pf.green_bits,
            blue_bits: pf.blue_bits,
        };

        for sample_ndx in 0..self.samples {
            // `drawSample`: downsample using only one sample.
            // SAFETY: a buffer this call owns, a texture this case owns, and a location
            // queried from the linked program.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, texture.get());
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buffer.get());
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    std::mem::size_of_val(&FULLSCREEN_QUAD) as isize,
                    FULLSCREEN_QUAD.as_ptr().cast::<c_void>(),
                    glw::GL_STATIC_DRAW,
                );

                gl.viewport(0, 0, SAMPLE_POS_CANVAS_SIZE, SAMPLE_POS_CANVAS_SIZE);
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.vertex_attrib_pointer(
                    sampler_pos_loc as GLuint,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    0,
                    std::ptr::null(),
                );
                gl.enable_vertex_attrib_array(sampler_pos_loc as GLuint);
                gl.use_program(sampler_program.program());
                gl.uniform_1i(sampler_loc, 0);
                gl.uniform_1i(sample_ndx_loc, sample_ndx);
                gl.active_texture(glw::GL_TEXTURE0);
            }
            glu::expect_no_error(gl, "useprogram")?;

            // SAFETY: a complete default framebuffer and a linked program with its
            // inputs bound.
            unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
            glu::expect_no_error(gl, "drawArrays")?;

            // SAFETY: unbinding; `finish` waits for the draw above to land before the
            // read-back below.
            unsafe {
                gl.disable_vertex_attrib_array(sampler_pos_loc as GLuint);
                gl.use_program(0);
                gl.finish();
            }
            glu::expect_no_error(gl, "cleanup")?;

            let mut gl_surface = Surface::new(SAMPLE_POS_CANVAS_SIZE, SAMPLE_POS_CANVAS_SIZE);
            glu::read_pixels(&context.render_context, 0, 0, &mut gl_surface.get_access())?;

            // `convertToSceneSpec`.
            let sample_pos = sample_positions[sample_ndx as usize];
            let offset = Vec4::new(
                (sample_pos.x() - 0.5) / SAMPLE_POS_CANVAS_SIZE as f32 * 2.0,
                (sample_pos.y() - 0.5) / SAMPLE_POS_CANVAS_SIZE as f32 * 2.0,
                0.0,
                0.0,
            );
            let scene = TriangleSceneSpec {
                triangles: triangles
                    .iter()
                    .map(|t| SceneTriangle::new(t[0] - offset, t[1] - offset, t[2] - offset))
                    .collect(),
            };

            let verify = verify_triangle_group_rasterization(&gl_surface, &scene, &args, VerificationMode::Strict);
            if !verify.ok {
                return Ok(TestStatus::fail(format!(
                    "Pixel comparison failed at sample {sample_ndx} ({} missing, {} unexpected pixels)",
                    verify.missing_pixels, verify.unexpected_pixels
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `MultisampleTextureUsageCase`
struct MultisampleTextureUsageCase {
    name: String,
    samples: i32,
    ty: UsageTextureType,
}

impl TestCase for MultisampleTextureUsageCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MultisampleTextureUsageCase::init` plus `::iterate` - this harness runs to
    /// completion in one call, so there is no separate `init`/`deinit` split; every GL
    /// object below is a `glu` wrapper whose `Drop` is upstream's `deinit`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let internal_format: GLenum = if self.ty.is_color() {
            glw::GL_R8
        } else if self.ty.is_signed() {
            glw::GL_R8I
        } else if self.ty.is_unsigned() {
            glw::GL_R8UI
        } else {
            glw::GL_DEPTH_COMPONENT32F
        };
        let texture_target: GLenum = if self.ty.is_array() {
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        } else {
            glw::GL_TEXTURE_2D_MULTISAMPLE
        };
        let fbo_attachment: GLenum = if self.ty.is_depth() {
            glw::GL_DEPTH_ATTACHMENT
        } else {
            glw::GL_COLOR_ATTACHMENT0
        };
        let supports_es32_or_gl45 = context.context_type().supports(3, 2);

        // requirements
        if self.ty.is_array()
            && !supports_es32_or_gl45
            && !context
                .context_info
                .is_extension_supported("GL_OES_texture_storage_multisample_2d_array")
        {
            return Err(TestError::NotSupported(
                "Test requires OES_texture_storage_multisample_2d_array extension".to_string(),
            ));
        }

        let render_target = context.render_target();
        if render_target.width < USAGE_TEXTURE_SIZE || render_target.height < USAGE_TEXTURE_SIZE {
            return Err(TestError::NotSupported(format!(
                "render target size must be at least {USAGE_TEXTURE_SIZE}x{USAGE_TEXTURE_SIZE}"
            )));
        }

        let mut max_samples: GLint = 0;
        // SAFETY: one integer of output.
        unsafe { gl.get_internalformativ(texture_target, internal_format, glw::GL_SAMPLES, 1, &mut max_samples) };
        if self.samples > max_samples {
            return Err(TestError::NotSupported(
                "Requested sample count is greater than supported".to_string(),
            ));
        }

        let mut max_texture_size: GLint = 0;
        // SAFETY: one integer of output.
        unsafe { gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_texture_size) };
        if USAGE_TEXTURE_SIZE > max_texture_size {
            return Err(TestError::NotSupported(
                "Larger GL_MAX_TEXTURE_SIZE is required".to_string(),
            ));
        }

        if self.ty.is_array() {
            let mut max_texture_layers: GLint = 0;
            // SAFETY: one integer of output.
            unsafe { gl.get_integerv(glw::GL_MAX_ARRAY_TEXTURE_LAYERS, &mut max_texture_layers) };
            if USAGE_TEXTURE_ARRAY_SIZE > max_texture_layers {
                return Err(TestError::NotSupported(
                    "Larger GL_MAX_ARRAY_TEXTURE_LAYERS is required".to_string(),
                ));
            }
        }

        // create texture
        let texture = Texture::new(gl);
        // SAFETY: a name this case generated, given a sample count already checked supported.
        unsafe { gl.bind_texture(texture_target, texture.get()) };
        glu::expect_no_error(gl, "bind texture")?;

        // SAFETY: as above.
        unsafe {
            if self.ty.is_array() {
                gl.tex_storage_3d_multisample(
                    texture_target,
                    self.samples,
                    internal_format,
                    USAGE_TEXTURE_SIZE,
                    USAGE_TEXTURE_SIZE,
                    USAGE_TEXTURE_ARRAY_SIZE,
                    glw::FALSE,
                );
            } else {
                gl.tex_storage_2d_multisample(
                    texture_target,
                    self.samples,
                    internal_format,
                    USAGE_TEXTURE_SIZE,
                    USAGE_TEXTURE_SIZE,
                    glw::FALSE,
                );
            }
        }
        glu::expect_no_error(gl, "texstorage")?;

        // create fbo for drawing
        let fbo = Framebuffer::new(gl);
        // SAFETY: the framebuffer and texture this case owns.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            if self.ty.is_array() {
                gl.framebuffer_texture_layer(
                    glw::GL_FRAMEBUFFER,
                    fbo_attachment,
                    texture.get(),
                    0,
                    USAGE_TEXTURE_LAYER,
                );
            } else {
                gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, fbo_attachment, texture_target, texture.get(), 0);
            }
        }
        glu::expect_no_error(gl, "gen fbo")?;

        // ES only, so no vao is required - matching upstream's own
        // `if (!glu::isContextTypeES(...)) gl.genVertexArrays(...)`, which never fires here.

        let draw_shader = gen_draw_shader(context, self.ty);
        if !draw_shader.is_ok() {
            return Err(TestError::Fail("could not build shader".to_string()));
        }

        let sampler_shader = gen_sampler_shader(context, self.ty, supports_es32_or_gl45);
        if !sampler_shader.is_ok() {
            return Err(TestError::Fail("could not build shader".to_string()));
        }

        // Pick a value in the type's own range, `deUint32Hash(m_type)`-seeded exactly like
        // upstream. The specific value does not affect the verdict - `renderToTexture` writes
        // it and the sampler shader's own fragment shader compares what it reads back against
        // the same value, entirely on the GPU - only that the two agree on it, which a shared
        // local matches regardless of which value the RNG produces.
        let (min_value, max_value): (f32, f32) = if self.ty.is_color() || self.ty.is_depth() {
            (0.0, 1.0)
        } else if self.ty.is_signed() {
            (-100.0, 100.0)
        } else {
            (0.0, 200.0)
        };
        let mut rnd = Random::new(de_uint32_hash(self.ty as u32));
        let raw_value = rnd.get_float_range(min_value, max_value);
        let value = if self.ty.is_signed() || self.ty.is_unsigned() {
            raw_value.floor()
        } else {
            raw_value
        };

        render_to_texture(gl, &fbo, &draw_shader, self.ty, value)?;

        let mut result = Surface::new(USAGE_TEXTURE_SIZE, USAGE_TEXTURE_SIZE);
        sample_texture(
            context,
            &sampler_shader,
            texture_target,
            &texture,
            self.ty,
            self.samples,
            value,
            &mut result,
        )?;

        Ok(if verify_usage_image(context, &result) {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Image verification failed")
        })
    }
}

/// `MultisampleTextureUsageCase::genDrawShader`
fn gen_draw_shader<'gl>(context: &'gl Context, ty: UsageTextureType) -> ShaderProgram<'gl> {
    let version = glsl_version_decl(context);
    let vertex_source = format!(
        "{version}\n\
         in highp vec4 a_position;\n\
         void main (void)\n\
         {{\n\
         \x20   gl_Position = a_position;\n\
         }}\n"
    );

    let fragment_source = if ty.is_depth() {
        format!(
            "{version}\n\
             layout(location = 0) out highp vec4 fragColor;\n\
             uniform highp float u_writeValue;\n\
             void main (void)\n\
             {{\n\
             \x20   fragColor = vec4(0.0, 0.0, 0.0, 1.0);\n\
             \x20   gl_FragDepth = u_writeValue;\n\
             }}\n"
        )
    } else {
        let out_type = if ty.is_color() {
            "vec4"
        } else if ty.is_signed() {
            "ivec4"
        } else {
            "uvec4"
        };
        format!(
            "{version}\n\
             layout(location = 0) out highp {out_type} fragColor;\n\
             uniform highp float u_writeValue;\n\
             void main (void)\n\
             {{\n\
             \x20   fragColor = {out_type}(vec4(u_writeValue, 1.0, 1.0, 1.0));\n\
             }}\n"
        )
    };

    ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(vertex_source, fragment_source))
}

/// `MultisampleTextureUsageCase::genSamplerShader`
fn gen_sampler_shader<'gl>(
    context: &'gl Context,
    ty: UsageTextureType,
    supports_es32_or_gl45: bool,
) -> ShaderProgram<'gl> {
    let version = glsl_version_decl(context);
    let vertex_source = format!(
        "{version}\n\
         in highp vec4 a_position;\n\
         out highp float v_gradient;\n\
         void main (void)\n\
         {{\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_gradient = a_position.x * 0.5 + 0.5;\n\
         }}\n"
    );

    let extension_statement = if ty.is_array() && !supports_es32_or_gl45 {
        "#extension GL_OES_texture_storage_multisample_2d_array : require\n"
    } else {
        ""
    };
    let fetch_pos = if ty.is_array() {
        "ivec3(floor(gl_FragCoord.xy), u_layer)"
    } else {
        "ivec2(floor(gl_FragCoord.xy))"
    };
    let epsilon = if ty.is_color() || ty.is_depth() { "0.1" } else { "1.0" };
    let sampler_type = match (ty.is_array(), ty.is_signed(), ty.is_unsigned()) {
        (false, false, false) => "sampler2DMS",
        (true, false, false) => "sampler2DMSArray",
        (false, true, false) => "isampler2DMS",
        (true, true, false) => "isampler2DMSArray",
        (false, false, true) => "usampler2DMS",
        (true, false, true) => "usampler2DMSArray",
        _ => unreachable!("a texture type is never both signed and unsigned"),
    };

    let fragment_source = format!(
        "{version}\n\
         {extension_statement}layout(location = 0) out highp vec4 fragColor;\n\
         uniform highp {sampler_type} u_sampler;\n\
         uniform highp int u_maxSamples;\n\
         uniform highp int u_layer;\n\
         uniform highp float u_cmpValue;\n\
         in highp float v_gradient;\n\
         void main (void)\n\
         {{\n\
         \x20   const highp vec4 okColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
         \x20   const highp vec4 failColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
         \x20   const highp float epsilon = {epsilon};\n\
         \n\
         \x20   highp int sampleNdx = clamp(int(floor(v_gradient * float(u_maxSamples))), 0, u_maxSamples-1);\n\
         \x20   highp float value = float(texelFetch(u_sampler, {fetch_pos}, sampleNdx).r);\n\
         \x20   fragColor = (abs(u_cmpValue - value) < epsilon) ? (okColor) : (failColor);\n\
         }}\n"
    );

    ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(vertex_source, fragment_source))
}

/// The fullscreen quad both `renderToTexture` and `sampleTexture` upload - upstream
/// declares the same `static const tcu::Vec4 fullscreenQuad[]` twice, once per method.
const USAGE_FULLSCREEN_QUAD: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, //
    -1.0, 1.0, 0.0, 1.0, //
    1.0, -1.0, 0.0, 1.0, //
    1.0, 1.0, 0.0, 1.0,
];

/// `MultisampleTextureUsageCase::renderToTexture`
fn render_to_texture(
    gl: &glw::Functions,
    fbo: &Framebuffer<'_>,
    draw_shader: &ShaderProgram<'_>,
    ty: UsageTextureType,
    value: f32,
) -> Result<(), TestError> {
    let vertex_buffer = Buffer::new(gl);
    // SAFETY: NUL-terminated names against a linked program.
    let pos_location = unsafe { gl.get_attrib_location(draw_shader.program(), c"a_position".as_ptr()) };
    // SAFETY: as above.
    let value_location = unsafe { gl.get_uniform_location(draw_shader.program(), c"u_writeValue".as_ptr()) };

    // SAFETY: a buffer this call owns, holding a plain fullscreen quad.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&USAGE_FULLSCREEN_QUAD) as isize,
            USAGE_FULLSCREEN_QUAD.as_ptr().cast::<c_void>(),
            glw::GL_STATIC_DRAW,
        );
    }
    glu::expect_no_error(gl, "bufferdata")?;

    // SAFETY: the framebuffer this case owns.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        gl.viewport(0, 0, USAGE_TEXTURE_SIZE, USAGE_TEXTURE_SIZE);
    }

    if ty.is_color() {
        let clear_color = [0.0f32, 0.0, 0.0, 0.0];
        // SAFETY: four floats for a colour clear.
        unsafe { gl.clear_bufferfv(glw::GL_COLOR, 0, clear_color.as_ptr()) };
    } else if ty.is_signed() {
        let clear_color = [0i32, 0, 0, 0];
        // SAFETY: four ints for a signed-integer colour clear.
        unsafe { gl.clear_bufferiv(glw::GL_COLOR, 0, clear_color.as_ptr()) };
    } else if ty.is_unsigned() {
        let clear_color = [0u32, 0, 0, 0];
        // SAFETY: four uints for an unsigned-integer colour clear.
        unsafe { gl.clear_bufferuiv(glw::GL_COLOR, 0, clear_color.as_ptr()) };
    } else {
        let clear_depth = 0.5f32;
        // SAFETY: one float for a depth clear.
        unsafe { gl.clear_bufferfv(glw::GL_DEPTH, 0, &clear_depth) };
    }
    glu::expect_no_error(gl, "clear buffer")?;

    // SAFETY: the buffer just filled, and a location queried from the linked program.
    unsafe {
        gl.vertex_attrib_pointer(
            pos_location as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null(),
        );
        gl.enable_vertex_attrib_array(pos_location as GLuint);

        gl.use_program(draw_shader.program());
        gl.uniform_1f(value_location, value);
    }
    glu::expect_no_error(gl, "setup draw")?;

    if ty.is_depth() {
        // SAFETY: plain state, disabled again right after the draw.
        unsafe {
            gl.enable(glw::GL_DEPTH_TEST);
            gl.depth_func(glw::GL_ALWAYS);
        }
    }

    // SAFETY: a complete framebuffer and a linked program with its attribute bound.
    unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
    glu::expect_no_error(gl, "draw")?;

    if ty.is_depth() {
        // SAFETY: plain state.
        unsafe { gl.disable(glw::GL_DEPTH_TEST) };
    }

    // SAFETY: unbinding.
    unsafe {
        gl.disable_vertex_attrib_array(pos_location as GLuint);
        gl.use_program(0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
    glu::expect_no_error(gl, "clean")
}

/// `MultisampleTextureUsageCase::sampleTexture`
#[expect(
    clippy::too_many_arguments,
    reason = "matches upstream's own method, which reads just as many members"
)]
fn sample_texture(
    context: &Context,
    sampler_shader: &ShaderProgram<'_>,
    texture_target: GLenum,
    texture: &Texture<'_>,
    ty: UsageTextureType,
    num_samples: i32,
    value: f32,
    dst: &mut Surface,
) -> Result<(), TestError> {
    let gl = context.gl();
    // SAFETY: NUL-terminated names against a linked program.
    let (pos_location, sampler_location, max_samples_location, layer_location, value_location) = unsafe {
        (
            gl.get_attrib_location(sampler_shader.program(), c"a_position".as_ptr()),
            gl.get_uniform_location(sampler_shader.program(), c"u_sampler".as_ptr()),
            gl.get_uniform_location(sampler_shader.program(), c"u_maxSamples".as_ptr()),
            gl.get_uniform_location(sampler_shader.program(), c"u_layer".as_ptr()),
            gl.get_uniform_location(sampler_shader.program(), c"u_cmpValue".as_ptr()),
        )
    };

    let vertex_buffer = Buffer::new(gl);
    // SAFETY: a buffer this case owns, holding a plain fullscreen quad.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&USAGE_FULLSCREEN_QUAD) as isize,
            USAGE_FULLSCREEN_QUAD.as_ptr().cast::<c_void>(),
            glw::GL_STATIC_DRAW,
        );
    }
    glu::expect_no_error(gl, "bufferdata")?;

    // SAFETY: plain state setters.
    unsafe {
        gl.viewport(0, 0, USAGE_TEXTURE_SIZE, USAGE_TEXTURE_SIZE);
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    // SAFETY: the buffer just filled, a location queried from the linked program, and the
    // texture this case's caller owns, given a sample count already checked supported.
    unsafe {
        gl.vertex_attrib_pointer(
            pos_location as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null(),
        );
        gl.enable_vertex_attrib_array(pos_location as GLuint);

        gl.use_program(sampler_shader.program());
        gl.uniform_1i(sampler_location, 0);
        gl.uniform_1i(max_samples_location, num_samples);
        if ty.is_array() {
            gl.uniform_1i(layer_location, USAGE_TEXTURE_LAYER);
        }
        gl.uniform_1f(value_location, value);

        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(texture_target, texture.get());
    }
    glu::expect_no_error(gl, "setup draw")?;

    // SAFETY: a complete default framebuffer and a linked program with its inputs bound.
    unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
    glu::expect_no_error(gl, "draw")?;

    // SAFETY: unbinding.
    unsafe {
        gl.disable_vertex_attrib_array(pos_location as GLuint);
        gl.use_program(0);
    }
    glu::expect_no_error(gl, "clean")?;

    // SAFETY: waits for the draw above to land before reading it back.
    unsafe { gl.finish() };
    glu::read_pixels(&context.render_context, 0, 0, &mut dst.get_access())
}

/// `MultisampleTextureUsageCase::verifyImage`
fn verify_usage_image(context: &Context, dst: &Surface) -> bool {
    let target = context.render_target();
    let threshold_red = 1 << (8 - target.red_bits);
    let threshold_green = 1 << (8 - target.green_bits);
    let threshold_blue = 1 << (8 - target.blue_bits);

    let mut error = false;
    for y in 0..dst.get_height() {
        for x in 0..dst.get_width() {
            let color = dst.get_pixel(x, y);
            // only green is accepted
            if color.get_red() > threshold_red
                || color.get_green() < 255 - threshold_green
                || color.get_blue() > threshold_blue
            {
                error = true;
            }
        }
    }
    !error
}

/// `TextureMultisampleTests::init`'s `use_*` children of one `samples_N` group.
fn usage_group_children(group: &mut TestCaseGroup, samples: i32) {
    for (name, ty) in USAGE_TEXTURE_TYPES {
        group.add_child(Box::new(MultisampleTextureUsageCase {
            name: format!("use_{name}"),
            samples,
            ty,
        }) as Box<dyn TestCase>);
    }
}

/// `TextureMultisampleTests::init`'s ten `samples_N` groups - `sample_position`
/// (`SamplePosRasterizationTest`), `sample_mask_*` (`SampleMaskCase`) and `use_*`
/// (`MultisampleTextureUsageCase`), in upstream's own registration order.
fn samples_group(samples: i32) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(format!("samples_{samples}"));
    group.add_child(Box::new(SamplePosRasterizationTest { samples }) as Box<dyn TestCase>);
    for (name, flags) in MASK_VARIANTS {
        group.add_child(Box::new(SampleMaskCase {
            name: name.to_string(),
            samples,
            flags,
        }) as Box<dyn TestCase>);
    }
    usage_group_children(&mut group, samples);
    group
}

/// `TextureMultisampleTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample");
    for samples in SAMPLE_COUNTS {
        group.add_child(samples_group(samples));
    }
    group.add_child(negative_group());
    group
}

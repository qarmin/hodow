// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Each sampler parameter is set through both `glTexParameteri` and `glTexParameterf`
// and read back through both `glGetTexParameteriv` and `glGetTexParameterfv`, so all
// four conversions are exercised. An enum whose value is passed as a float and read
// back as an integer is where a driver that stores it in a float register loses it.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Verifier {
    GetTexParameterI,
    GetTexParameterF,
}

const VERIFIERS: [Verifier; 2] = [Verifier::GetTexParameterI, Verifier::GetTexParameterF];

impl Verifier {
    fn postfix(self) -> &'static str {
        match self {
            Self::GetTexParameterI => "_gettexparameteri",
            Self::GetTexParameterF => "_gettexparameterf",
        }
    }

    /// `verifyInteger`
    fn verify_integer(self, case: &mut ApiCase<'_>, target: GLenum, name: GLenum, reference: i32) {
        let gl = case.gl();
        match self {
            Self::GetTexParameterI => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out, guarded on both sides.
                unsafe { gl.get_tex_parameteriv(target, name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != reference {
                    case.fail(format!("expected {reference}; got {}", state.value()), "Got invalid texture param value");
                }
            }
            Self::GetTexParameterF => {
                // Every enumerant a sampler parameter can hold is exactly
                // representable as a float, which upstream asserts here.
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_tex_parameterfv(target, name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                #[expect(clippy::cast_precision_loss, reason = "the reference is a small enumerant")]
                let expected = reference as f32;
                if state.value() != expected {
                    case.fail(format!("expected {expected}; got {}", state.value()), "Got invalid float value");
                }
            }
        }
    }
}

/// `TextureCase::test` - every case in this group runs against its own texture.
fn with_texture(case: &mut ApiCase<'_>, target: GLenum, body: impl FnOnce(&mut ApiCase<'_>)) {
    let gl = case.gl();
    let mut texture = 0;
    // SAFETY: the name is this case's own and is deleted below.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(target, texture);
    }
    case.expect_error(glw::GL_NO_ERROR);

    body(case);

    // SAFETY: as above.
    unsafe { gl.delete_textures(1, &texture) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// The shared shape of all four cases: an initial value, then every legal value set
/// twice - once as an integer and once as a float.
fn sampler_parameter(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, name: GLenum, initial: GLenum, values: &[GLenum]) {
    with_texture(case, target, |case| {
        let gl = case.gl();

        verifier.verify_integer(case, target, name, initial as i32);
        case.expect_error(glw::GL_NO_ERROR);

        for value in values {
            // SAFETY: a legal value for this parameter.
            unsafe { gl.tex_parameteri(target, name, *value as i32) };
            case.expect_error(glw::GL_NO_ERROR);
            verifier.verify_integer(case, target, name, *value as i32);
            case.expect_error(glw::GL_NO_ERROR);
        }

        for value in values {
            #[expect(clippy::cast_precision_loss, reason = "as in the verifier - a small enumerant")]
            let as_float = *value as f32;
            // SAFETY: as above, through the float entry point.
            unsafe { gl.tex_parameterf(target, name, as_float) };
            case.expect_error(glw::GL_NO_ERROR);
            verifier.verify_integer(case, target, name, *value as i32);
            case.expect_error(glw::GL_NO_ERROR);
        }
    });
}

/// `TextureStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");

    const WRAP_VALUES: [GLenum; 3] = [glw::GL_CLAMP_TO_EDGE, glw::GL_REPEAT, glw::GL_MIRRORED_REPEAT];
    const MAG_VALUES: [GLenum; 2] = [glw::GL_NEAREST, glw::GL_LINEAR];
    const MIN_VALUES: [GLenum; 6] = [
        glw::GL_NEAREST,
        glw::GL_LINEAR,
        glw::GL_NEAREST_MIPMAP_NEAREST,
        glw::GL_NEAREST_MIPMAP_LINEAR,
        glw::GL_LINEAR_MIPMAP_NEAREST,
        glw::GL_LINEAR_MIPMAP_LINEAR,
    ];

    for (target_name, target) in [("texture_2d", glw::GL_TEXTURE_2D), ("texture_cube_map", glw::GL_TEXTURE_CUBE_MAP)] {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{target_name}_texture_wrap_s{}", verifier.postfix()), move |case| {
                sampler_parameter(case, verifier, target, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT, &WRAP_VALUES);
            });
        }
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{target_name}_texture_wrap_t{}", verifier.postfix()), move |case| {
                sampler_parameter(case, verifier, target, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT, &WRAP_VALUES);
            });
        }
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{target_name}_texture_mag_filter{}", verifier.postfix()), move |case| {
                sampler_parameter(case, verifier, target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR, &MAG_VALUES);
            });
        }
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{target_name}_texture_min_filter{}", verifier.postfix()), move |case| {
                sampler_parameter(case, verifier, target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST_MIPMAP_LINEAR, &MIN_VALUES);
            });
        }
    }

    group
}

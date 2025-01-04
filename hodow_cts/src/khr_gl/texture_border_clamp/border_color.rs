// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampParameterTextureBorderColor.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::fmt::Display;

use super::TEXTURE_BORDER_CLAMP_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLfloat, GLint, GLuint};
use crate::khr_gl::esext::{EPSILON_FLOAT, ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `m_buffer_length`
const BUFFER_LENGTH: usize = 4;
/// `m_texture_unit_index`
const TEXTURE_UNIT_INDEX: GLuint = 0;

/// `TextureBorderClampParameterTextureBorderColor` (Test 6)
pub(super) struct ParameterTextureBorderColor {
    pub(super) ext_params: ExtParameters,
}

struct State {
    base: TestCaseBase,
    texture_targets: Vec<GLenum>,
    sampler_id: GLuint,
    to_id: GLuint,
}

/// `getTexTargetString` restricted to the targets this test iterates
fn tex_target_string(target: GLenum) -> &'static str {
    match target {
        glw::GL_TEXTURE_2D => "GL_TEXTURE_2D",
        glw::GL_TEXTURE_3D => "GL_TEXTURE_3D",
        glw::GL_TEXTURE_2D_ARRAY => "GL_TEXTURE_2D_ARRAY",
        glw::GL_TEXTURE_CUBE_MAP => "GL_TEXTURE_CUBE_MAP",
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => "GL_TEXTURE_CUBE_MAP_ARRAY_EXT",
        _ => "UNKNOWN",
    }
}

/// The body every `verifyGLGet*Result` shares: query into a zeroed buffer, require no error, compare element-wise.
fn verify_get<T: Copy + Default + Display>(
    gl: &glw::Functions,
    function: &str,
    target: GLenum,
    expected: &[T; BUFFER_LENGTH],
    error_message: &str,
    equal: impl Fn(T, T) -> bool,
    query: impl FnOnce(*mut T),
) -> Result<bool, TestError> {
    let mut buffer = [T::default(); BUFFER_LENGTH];
    query(buffer.as_mut_ptr());
    glu::expect_no_error(gl, error_message)?;

    for i in 0..BUFFER_LENGTH {
        if !equal(expected[i], buffer[i]) {
            let join = |values: &[T; BUFFER_LENGTH]| values.iter().map(|v| format!("{v},")).collect::<String>();
            log::info!(
                "Wrong value encountered when calling {function}() with GL_TEXTURE_BORDER_COLOR_EXT pname; texture target:{}\n expected values:[{}] result values:[{}]\n",
                tex_target_string(target),
                join(expected),
                join(&buffer)
            );
            return Ok(false);
        }
    }
    Ok(true)
}

fn exact<T: PartialEq>(a: T, b: T) -> bool {
    a == b
}

fn within_epsilon(a: GLfloat, b: GLfloat) -> bool {
    (a - b).abs() <= EPSILON_FLOAT
}

impl ParameterTextureBorderColor {
    fn verify_get_sampler_fv(
        gl: &glw::Functions,
        border: GLenum,
        sampler_id: GLuint,
        target: GLenum,
        expected: &[GLfloat; 4],
    ) -> Result<bool, TestError> {
        // SAFETY: the buffer holds four floats, the size of a border colour.
        verify_get(
            gl,
            "glGetSamplerParameterfv",
            target,
            expected,
            "Error gettnig  parameter for sampler.",
            exact,
            |p| unsafe { gl.get_sampler_parameterfv(sampler_id, border, p) },
        )
    }

    fn verify_get_sampler_iv(
        gl: &glw::Functions,
        border: GLenum,
        sampler_id: GLuint,
        target: GLenum,
        expected: &[GLint; 4],
    ) -> Result<bool, TestError> {
        // SAFETY: the buffer holds four ints, the size of a border colour.
        verify_get(
            gl,
            "glGetSamplerParameteriv",
            target,
            expected,
            "Error getting  parameter for sampler.",
            exact,
            |p| unsafe { gl.get_sampler_parameteriv(sampler_id, border, p) },
        )
    }

    fn verify_get_sampler_iiv(
        gl: &glw::Functions,
        border: GLenum,
        sampler_id: GLuint,
        target: GLenum,
        expected: &[GLint; 4],
    ) -> Result<bool, TestError> {
        // SAFETY: as above.
        verify_get(
            gl,
            "glGetSamplerParameterIivEXT",
            target,
            expected,
            "Error getting  parameter for sampler.",
            exact,
            |p| unsafe { gl.get_sampler_parameter_iiv(sampler_id, border, p) },
        )
    }

    fn verify_get_sampler_iuiv(
        gl: &glw::Functions,
        border: GLenum,
        sampler_id: GLuint,
        target: GLenum,
        expected: &[GLuint; 4],
    ) -> Result<bool, TestError> {
        // SAFETY: as above.
        verify_get(
            gl,
            "glGetSamplerParameterIuivEXT",
            target,
            expected,
            "Error getting  parameter for sampler.",
            exact,
            |p| unsafe { gl.get_sampler_parameter_iuiv(sampler_id, border, p) },
        )
    }

    fn verify_get_tex_fv(
        gl: &glw::Functions,
        border: GLenum,
        target: GLenum,
        expected: &[GLfloat; 4],
    ) -> Result<bool, TestError> {
        // SAFETY: the buffer holds four floats.
        verify_get(
            gl,
            "glGetTexParameterfv",
            target,
            expected,
            "Error getting parameter for texture.",
            within_epsilon,
            |p| unsafe { gl.get_tex_parameterfv(target, border, p) },
        )
    }

    fn verify_get_tex_iv(
        gl: &glw::Functions,
        border: GLenum,
        target: GLenum,
        expected: &[GLint; 4],
    ) -> Result<bool, TestError> {
        // SAFETY: the buffer holds four ints.
        verify_get(
            gl,
            "glGetTexParameteriv",
            target,
            expected,
            "Error getting  parameter for texture.",
            exact,
            |p| unsafe { gl.get_tex_parameteriv(target, border, p) },
        )
    }

    fn verify_get_tex_iiv(
        gl: &glw::Functions,
        border: GLenum,
        target: GLenum,
        expected: &[GLint; 4],
    ) -> Result<bool, TestError> {
        // SAFETY: as above.
        verify_get(
            gl,
            "glGetTexParameterIivEXT",
            target,
            expected,
            "Error getting  parameter for texture.",
            exact,
            |p| unsafe { gl.get_tex_parameter_iiv(target, border, p) },
        )
    }

    fn verify_get_tex_iuiv(
        gl: &glw::Functions,
        border: GLenum,
        target: GLenum,
        expected: &[GLuint; 4],
    ) -> Result<bool, TestError> {
        // SAFETY: as above.
        verify_get(
            gl,
            "glGetTexParameterIuivEXT",
            target,
            expected,
            "Error getting  parameter for texture.",
            exact,
            |p| unsafe { gl.get_tex_parameter_iuiv(target, border, p) },
        )
    }

    /// `initTest`
    fn init_test(state: &mut State) -> Result<(), TestError> {
        if !state.base.is_texture_border_clamp_supported {
            return Err(TestError::NotSupported(TEXTURE_BORDER_CLAMP_NOT_SUPPORTED.to_string()));
        }
        state.texture_targets.push(glw::GL_TEXTURE_2D);
        state.texture_targets.push(glw::GL_TEXTURE_2D_ARRAY);
        state.texture_targets.push(glw::GL_TEXTURE_3D);
        state.texture_targets.push(glw::GL_TEXTURE_CUBE_MAP);
        if state.base.is_texture_cube_map_array_supported {
            state.texture_targets.push(glw::GL_TEXTURE_CUBE_MAP_ARRAY);
        }
        Ok(())
    }

    /// `deinit`
    fn deinit(gl: &glw::Functions, state: &mut State) -> Result<(), TestError> {
        for &target in &state.texture_targets {
            // SAFETY: unbinds a texture target on the current context.
            unsafe { gl.bind_texture(target, 0) };
            glu::expect_no_error(gl, "Error binding texture object!")?;
        }
        // SAFETY: unbinds the unit and deletes the names this case created.
        unsafe { gl.bind_sampler(TEXTURE_UNIT_INDEX, 0) };
        glu::expect_no_error(gl, "Error binding sampler object to texture unit!")?;
        // SAFETY: as above.
        unsafe {
            if state.to_id != 0 {
                gl.delete_textures(1, &state.to_id);
                state.to_id = 0;
            }
            if state.sampler_id != 0 {
                gl.delete_samplers(1, &state.sampler_id);
                state.sampler_id = 0;
            }
        }
        Ok(())
    }

    /// `iterate` after `initTest`
    fn run(gl: &glw::Functions, state: &mut State) -> Result<bool, TestError> {
        let border = state.base.gl_ext_tokens.texture_border_color;
        let mut test_passed = true;

        for i in 0..state.texture_targets.len() {
            let target = state.texture_targets[i];

            // SAFETY: object creation and binding on the current context.
            unsafe { gl.gen_textures(1, &mut state.to_id) };
            glu::expect_no_error(gl, "Error generating a texture object!")?;
            // SAFETY: as above.
            unsafe { gl.bind_texture(target, state.to_id) };
            glu::expect_no_error(gl, "Error binding a texture object!")?;
            // SAFETY: as above.
            unsafe { gl.gen_samplers(1, &mut state.sampler_id) };
            glu::expect_no_error(gl, "Error generating a sampler object!")?;
            // SAFETY: as above.
            unsafe { gl.bind_sampler(TEXTURE_UNIT_INDEX, state.sampler_id) };
            glu::expect_no_error(gl, "Error binding a sampler object to a texture unit!")?;
            let sampler = state.sampler_id;

            let data_fp_zeros: [GLfloat; 4] = [0.0; 4];
            let data_int_zeros: [GLint; 4] = [0; 4];
            let data_uint_zeros: [GLuint; 4] = [0; 4];

            test_passed &= Self::verify_get_tex_fv(gl, border, target, &data_fp_zeros)?;
            test_passed &= Self::verify_get_tex_iv(gl, border, target, &data_int_zeros)?;
            test_passed &= Self::verify_get_tex_iiv(gl, border, target, &data_int_zeros)?;
            test_passed &= Self::verify_get_tex_iuiv(gl, border, target, &data_uint_zeros)?;

            // glTexParameterIiv / glSamplerParameterIiv
            let mut data_int: [GLint; 4] = [-1, -2, 3, 4];

            // SAFETY: the pointers are to live four-element arrays.
            unsafe { gl.tex_parameter_iiv(target, border, data_int.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glTexParameterIivEXT()",
            )?;
            test_passed &= Self::verify_get_tex_iiv(gl, border, target, &data_int)?;
            test_passed &= Self::verify_get_sampler_iiv(gl, border, sampler, target, &data_int_zeros)?;

            // SAFETY: as above.
            unsafe { gl.tex_parameter_iiv(target, border, data_int_zeros.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glTexParameterIivEXT()",
            )?;
            // SAFETY: as above.
            unsafe { gl.sampler_parameter_iiv(sampler, border, data_int.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glSamplerParameterIivEXT()",
            )?;
            test_passed &= Self::verify_get_tex_iiv(gl, border, target, &data_int_zeros)?;
            test_passed &= Self::verify_get_sampler_iiv(gl, border, sampler, target, &data_int)?;

            // SAFETY: as above.
            unsafe { gl.sampler_parameter_iiv(sampler, border, data_int_zeros.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glSamplerParameterIivEXT()",
            )?;

            // glTexParameterIuiv / glSamplerParameterIuiv
            let data_uint: [GLuint; 4] = [1, 2, 3, 4];

            // SAFETY: as above.
            unsafe { gl.tex_parameter_iuiv(target, border, data_uint.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glTexParameterIuivEXT()",
            )?;
            test_passed &= Self::verify_get_tex_iuiv(gl, border, target, &data_uint)?;
            test_passed &= Self::verify_get_sampler_iuiv(gl, border, sampler, target, &data_uint_zeros)?;

            // SAFETY: as above.
            unsafe { gl.tex_parameter_iuiv(target, border, data_uint_zeros.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glTexParameterIuivEXT()",
            )?;
            // SAFETY: as above.
            unsafe { gl.sampler_parameter_iuiv(sampler, border, data_uint.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glSamplerParameterIuivEXT()",
            )?;
            test_passed &= Self::verify_get_tex_iuiv(gl, border, target, &data_uint_zeros)?;
            test_passed &= Self::verify_get_sampler_iuiv(gl, border, sampler, target, &data_uint)?;

            // SAFETY: as above.
            unsafe { gl.sampler_parameter_iuiv(sampler, border, data_uint_zeros.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glSamplerParameterIuivEXT()",
            )?;

            // glTexParameterfv / glSamplerParameterfv
            let data_fp: [GLfloat; 4] = [0.1, 0.2, 0.3, 0.4];

            // SAFETY: as above.
            unsafe { gl.tex_parameterfv(target, border, data_fp.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glTexParameterfv()",
            )?;
            test_passed &= Self::verify_get_tex_fv(gl, border, target, &data_fp)?;
            test_passed &= Self::verify_get_sampler_fv(gl, border, sampler, target, &data_fp_zeros)?;

            // SAFETY: as above.
            unsafe { gl.tex_parameterfv(target, border, data_fp_zeros.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glTexParameterfv()",
            )?;
            // SAFETY: as above.
            unsafe { gl.sampler_parameterfv(sampler, border, data_fp.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glSamplerParameterfv()",
            )?;
            test_passed &= Self::verify_get_tex_fv(gl, border, target, &data_fp_zeros)?;
            test_passed &= Self::verify_get_sampler_fv(gl, border, sampler, target, &data_fp)?;

            // SAFETY: as above.
            unsafe { gl.sampler_parameterfv(sampler, border, data_fp_zeros.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glSamplerParameterfv()",
            )?;

            // glTexParameteriv / glSamplerParameteriv
            data_int = [0, 1, 2, 4];

            // SAFETY: as above.
            unsafe { gl.tex_parameteriv(target, border, data_int.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glTexParameteriv()",
            )?;
            test_passed &= Self::verify_get_tex_iv(gl, border, target, &data_int)?;
            test_passed &= Self::verify_get_sampler_iv(gl, border, sampler, target, &data_int_zeros)?;

            // SAFETY: as above.
            unsafe { gl.tex_parameteriv(target, border, data_int_zeros.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glTexParameteriv()",
            )?;
            // SAFETY: as above.
            unsafe { gl.sampler_parameteriv(sampler, border, data_int.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glSamplerParameteriv()",
            )?;
            test_passed &= Self::verify_get_tex_iv(gl, border, target, &data_int_zeros)?;
            test_passed &= Self::verify_get_sampler_iv(gl, border, sampler, target, &data_int)?;

            // SAFETY: as above.
            unsafe { gl.sampler_parameteriv(sampler, border, data_int_zeros.as_ptr()) };
            glu::expect_no_error(
                gl,
                "Error setting GL_TEXTURE_BORDER_COLOR_EXT parameter using glSamplerParameteriv()",
            )?;

            // Deinitialize the texture object
            // SAFETY: unbinds and deletes the names created above.
            unsafe { gl.bind_texture(target, 0) };
            glu::expect_no_error(gl, "Error binding texture object!")?;
            // SAFETY: as above.
            unsafe { gl.delete_textures(1, &state.to_id) };
            state.to_id = 0;
            // SAFETY: as above.
            unsafe { gl.bind_sampler(TEXTURE_UNIT_INDEX, 0) };
            glu::expect_no_error(gl, "Error binding sampler object to texture unit!")?;
            // SAFETY: as above.
            unsafe { gl.delete_samplers(1, &state.sampler_id) };
            state.sampler_id = 0;
        }
        Ok(test_passed)
    }
}

impl TestCase for ParameterTextureBorderColor {
    fn name(&self) -> &str {
        "samplerparameteri_border_color"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut state = State {
            base: TestCaseBase::init(context, self.ext_params),
            texture_targets: Vec::new(),
            sampler_id: 0,
            to_id: 0,
        };

        let outcome = Self::init_test(&mut state).and_then(|()| Self::run(gl, &mut state));
        let cleanup = Self::deinit(gl, &mut state);
        let test_passed = outcome?;
        cleanup?;

        Ok(if test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

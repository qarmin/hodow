// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampTests.cpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampBase.cpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampParameterBorderColorError.cpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampTexParameterIErrors.cpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampGetTexParameterIErrors.cpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampSamplerParameterIError.cpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampSamplerParameterIWithWrongPname.cpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampParameterTextureBorderColor.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// All 32 cases: the five error tests plus samplerparameteri_border_color (border_color.rs) and the 26 TextureBorderClampSamplingTexture cases (Test 7, sampling.rs).

mod border_color;
mod sampling;

use super::esext::{ExtParameters, TestCaseBase};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLfloat, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_BORDER_CLAMP_NOT_SUPPORTED: &str = "Texture border clamp functionality not supported, skipping";

/// `m_buffer_size` of the Get* error tests
const BUFFER_SIZE: usize = 32;

/// Sampler unit the sampler tests bind to (`m_texture_unit` / `m_texture_unit_index`)
const TEXTURE_UNIT: GLuint = 0;

#[derive(Clone, Copy)]
enum Variant {
    BorderColorErrors,
    TexParameterIErrors,
    GetTexParameterIErrors,
    SamplerParameterIError,
    SamplerParameterIWithWrongPname,
}

/// The five tests share this file; `variant` picks the `iterate` body.
struct TextureBorderClampError {
    ext_params: ExtParameters,
    variant: Variant,
}

/// `TextureBorderClampBase` state plus the `m_test_passed` every subclass carries.
struct Fixture {
    base: TestCaseBase,
    texture_2d_id: GLuint,
    texture_2d_array_id: GLuint,
    texture_2d_multisample_array_id: GLuint,
    texture_2d_multisample_id: GLuint,
    texture_3d_id: GLuint,
    texture_buffer_id: GLuint,
    texture_cube_map_id: GLuint,
    texture_cube_map_array_id: GLuint,
    texture_target_list: Vec<GLenum>,
    sampler_id: GLuint,
    test_passed: bool,
}

impl Fixture {
    fn new(base: TestCaseBase) -> Self {
        Self {
            base,
            texture_2d_id: 0,
            texture_2d_array_id: 0,
            texture_2d_multisample_array_id: 0,
            texture_2d_multisample_id: 0,
            texture_3d_id: 0,
            texture_buffer_id: 0,
            texture_cube_map_id: 0,
            texture_cube_map_array_id: 0,
            texture_target_list: Vec::new(),
            sampler_id: 0,
            test_passed: true,
        }
    }

    /// `deinitAllTextures`
    fn deinit_all_textures(&mut self, gl: &glw::Functions) {
        // SAFETY: state resets and deletes of names this case created, on the current context.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_texture(glw::GL_TEXTURE_3D, 0);
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0);
            if self.base.is_texture_storage_multisample_supported {
                gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, 0);
            }
            if self.base.is_texture_storage_multisample_2d_array_supported {
                gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, 0);
            }
            if self.base.is_texture_cube_map_array_supported {
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            }
            if self.base.is_texture_buffer_supported {
                gl.bind_buffer(self.base.gl_ext_tokens.texture_buffer, 0);
            }

            for id in [
                &mut self.texture_2d_id,
                &mut self.texture_3d_id,
                &mut self.texture_2d_array_id,
                &mut self.texture_cube_map_id,
                &mut self.texture_cube_map_array_id,
                &mut self.texture_2d_multisample_id,
                &mut self.texture_2d_multisample_array_id,
            ] {
                if *id != 0 {
                    gl.delete_textures(1, id);
                    *id = 0;
                }
            }
            if self.texture_buffer_id != 0 {
                gl.delete_buffers(1, &self.texture_buffer_id);
                self.texture_buffer_id = 0;
            }
        }
    }

    /// `initAllTextures`
    fn init_all_textures(&mut self, gl: &glw::Functions) -> Result<(), TestError> {
        let targets: [(bool, GLenum, &str, &str); 7] = [
            (true, glw::GL_TEXTURE_2D, "GL_TEXTURE_2D", "2d"),
            (true, glw::GL_TEXTURE_3D, "GL_TEXTURE_3D", "3d"),
            (true, glw::GL_TEXTURE_2D_ARRAY, "GL_TEXTURE_2D_ARRAY", "2d_array"),
            (true, glw::GL_TEXTURE_CUBE_MAP, "GL_TEXTURE_CUBE_MAP", "cube_map"),
            (
                self.base.is_texture_cube_map_array_supported,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                "GL_TEXTURE_CUBE_MAP_ARRAY_EXT",
                "cube_map_array",
            ),
            (
                self.base.is_texture_storage_multisample_supported,
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                "GL_TEXTURE_2D_MULTISAMPLE",
                "2d_multisample",
            ),
            (
                self.base.is_texture_storage_multisample_2d_array_supported,
                glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
                "GL_TEXTURE_2D_MULTISAMPLE_ARRAY_OES",
                "2d_multisample_array",
            ),
        ];

        for (supported, target, target_name, which) in targets {
            if !supported {
                continue;
            }
            let id = match which {
                "2d" => &mut self.texture_2d_id,
                "3d" => &mut self.texture_3d_id,
                "2d_array" => &mut self.texture_2d_array_id,
                "cube_map" => &mut self.texture_cube_map_id,
                "cube_map_array" => &mut self.texture_cube_map_array_id,
                "2d_multisample" => &mut self.texture_2d_multisample_id,
                _ => &mut self.texture_2d_multisample_array_id,
            };
            // SAFETY: object creation and binding on the current context.
            unsafe { gl.gen_textures(1, id) };
            glu::expect_no_error(gl, "Error generating a texture object")?;
            // SAFETY: as above.
            unsafe { gl.bind_texture(target, *id) };
            glu::expect_no_error(
                gl,
                &format!("Error binding a texture object to {target_name} texture target"),
            )?;
            self.texture_target_list.push(target);
        }

        if self.base.is_texture_buffer_supported {
            // SAFETY: object creation and binding on the current context.
            unsafe { gl.gen_buffers(1, &mut self.texture_buffer_id) };
            glu::expect_no_error(gl, "Error generating a texture object")?;
            // SAFETY: as above.
            unsafe { gl.bind_buffer(self.base.gl_ext_tokens.texture_buffer, self.texture_buffer_id) };
            glu::expect_no_error(
                gl,
                "Error binding a texture object to GL_TEXTURE_BUFFER_EXT texture target",
            )?;
        }
        Ok(())
    }

    /// `TextureBorderClampBase::getPNameString`
    fn pname_string(&self, pname: GLenum) -> &'static str {
        if pname == self.base.gl_ext_tokens.texture_border_color {
            return "GL_TEXTURE_BORDER_COLOR_EXT";
        }
        match pname {
            glw::GL_TEXTURE_BASE_LEVEL => "GL_TEXTURE_BASE_LEVEL",
            glw::GL_TEXTURE_MIN_FILTER => "GL_TEXTURE_MIN_FILTER",
            glw::GL_TEXTURE_IMMUTABLE_FORMAT => "GL_TEXTURE_IMMUTABLE_FORMAT",
            glw::GL_TEXTURE_COMPARE_MODE => "GL_TEXTURE_COMPARE_MODE",
            glw::GL_TEXTURE_COMPARE_FUNC => "GL_TEXTURE_COMPARE_FUNC",
            glw::GL_TEXTURE_MAG_FILTER => "GL_TEXTURE_MAG_FILTER",
            glw::GL_TEXTURE_MAX_LEVEL => "GL_TEXTURE_MAX_LEVEL",
            glw::GL_TEXTURE_SWIZZLE_R => "GL_TEXTURE_SWIZZLE_R",
            glw::GL_TEXTURE_SWIZZLE_G => "GL_TEXTURE_SWIZZLE_G",
            glw::GL_TEXTURE_SWIZZLE_B => "GL_TEXTURE_SWIZZLE_B",
            glw::GL_TEXTURE_SWIZZLE_A => "GL_TEXTURE_SWIZZLE_A",
            glw::GL_TEXTURE_WRAP_S => "GL_TEXTURE_WRAP_S",
            glw::GL_TEXTURE_WRAP_T => "GL_TEXTURE_WRAP_T",
            glw::GL_TEXTURE_WRAP_R => "GL_TEXTURE_WRAP_R",
            glw::GL_DEPTH_STENCIL_TEXTURE_MODE => "GL_DEPTH_STENCIL_TEXTURE_MODE",
            glw::GL_TEXTURE_IMMUTABLE_LEVELS => "GL_TEXTURE_IMMUTABLE_LEVELS",
            glw::GL_TEXTURE_MAX_LOD => "GL_TEXTURE_MAX_LOD",
            glw::GL_TEXTURE_MIN_LOD => "GL_TEXTURE_MIN_LOD",
            _ => "UNKNOWN",
        }
    }

    /// `TextureBorderClampBase::getTexTargetString`
    fn tex_target_string(&self, target: GLenum) -> &'static str {
        if target == self.base.gl_ext_tokens.texture_border_color {
            return "GL_TEXTURE_BUFFER_EXT";
        }
        match target {
            glw::GL_TEXTURE_2D => "GL_TEXTURE_2D",
            glw::GL_TEXTURE_3D => "GL_TEXTURE_3D",
            glw::GL_TEXTURE_2D_ARRAY => "GL_TEXTURE_2D_ARRAY",
            glw::GL_TEXTURE_CUBE_MAP => "GL_TEXTURE_CUBE_MAP",
            glw::GL_TEXTURE_2D_MULTISAMPLE => "GL_TEXTURE_2D_MULTISAMPLE",
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => "GL_TEXTURE_2D_MULTISAMPLE_ARRAY_OES",
            glw::GL_TEXTURE_CUBE_MAP_ARRAY => "GL_TEXTURE_CUBE_MAP_ARRAY_EXT",
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X => "GL_TEXTURE_CUBE_MAP_POSITIVE_X",
            _ => "UNKNOWN",
        }
    }

    /// The tail every `Verify*` shares: read the error, record a mismatch against `accepted`, log it.
    fn check_error(&mut self, gl: &glw::Functions, call: &str, what: &str, accepted: &[GLenum]) {
        // SAFETY: plain error query on the current context.
        let error_code = unsafe { gl.get_error() };
        if !accepted.contains(&error_code) {
            self.test_passed = false;
            let expected: Vec<String> = accepted.iter().map(|e| format!("[{}]", glw::error_name(*e))).collect();
            log::info!(
                "{call}() failed:[{what}] reported error code:[{}] expected error code:{}",
                glw::error_name(error_code),
                expected.join(" or error code ")
            );
        }
    }

    fn target_pname(&self, target: GLenum, pname: GLenum) -> String {
        format!(
            "target:{}, pname:{}",
            self.tex_target_string(target),
            self.pname_string(pname)
        )
    }

    fn sampler_pname(&self, sampler_id: GLuint, pname: GLenum) -> String {
        format!("sampler id:{sampler_id}, pname:{}", self.pname_string(pname))
    }

    fn verify_tex_parameter_f(
        &mut self,
        gl: &glw::Functions,
        target: GLenum,
        pname: GLenum,
        param: GLfloat,
        expected: GLenum,
    ) {
        // SAFETY: scalar state call on the current context.
        unsafe { gl.tex_parameterf(target, pname, param) };
        let what = self.target_pname(target, pname);
        self.check_error(gl, "glTexParameterf", &what, &[expected]);
    }

    fn verify_tex_parameter_i(
        &mut self,
        gl: &glw::Functions,
        target: GLenum,
        pname: GLenum,
        param: GLint,
        expected: GLenum,
    ) {
        // SAFETY: scalar state call on the current context.
        unsafe { gl.tex_parameteri(target, pname, param) };
        let what = self.target_pname(target, pname);
        self.check_error(gl, "glTexParameteri", &what, &[expected]);
    }

    fn verify_sampler_parameter_f(&mut self, gl: &glw::Functions, pname: GLenum, param: GLfloat, expected: GLenum) {
        // SAFETY: scalar state call on the current context.
        unsafe { gl.sampler_parameterf(self.sampler_id, pname, param) };
        let what = format!(", pname:{}", self.pname_string(pname));
        self.check_error(gl, "glSamplerParameterf", &what, &[expected]);
    }

    fn verify_sampler_parameter_i(&mut self, gl: &glw::Functions, pname: GLenum, param: GLint, expected: GLenum) {
        // SAFETY: scalar state call on the current context.
        unsafe { gl.sampler_parameteri(self.sampler_id, pname, param) };
        let what = format!(", pname:{}", self.pname_string(pname));
        self.check_error(gl, "glSamplerParameteri", &what, &[expected]);
    }

    fn verify_tex_parameter_iiv(
        &mut self,
        gl: &glw::Functions,
        target: GLenum,
        pname: GLenum,
        params: GLint,
        expected: GLenum,
    ) {
        // SAFETY: the pointer is to a live local.
        unsafe { gl.tex_parameter_iiv(target, pname, &params) };
        let what = self.target_pname(target, pname);
        self.check_error(gl, "glTexParameterIivEXT", &what, &[expected]);
    }

    fn verify_tex_parameter_iiv_multiple_accepted_errors(
        &mut self,
        gl: &glw::Functions,
        target: GLenum,
        pname: GLenum,
        params: GLint,
        expected_error1: GLenum,
        expected_error2: GLenum,
    ) {
        // SAFETY: the pointer is to a live local.
        unsafe { gl.tex_parameter_iiv(target, pname, &params) };
        let what = self.target_pname(target, pname);
        self.check_error(gl, "glTexParameterIivEXT", &what, &[expected_error1, expected_error2]);
    }

    fn verify_tex_parameter_iuiv(
        &mut self,
        gl: &glw::Functions,
        target: GLenum,
        pname: GLenum,
        params: GLuint,
        expected: GLenum,
    ) {
        // SAFETY: the pointer is to a live local.
        unsafe { gl.tex_parameter_iuiv(target, pname, &params) };
        let what = self.target_pname(target, pname);
        self.check_error(gl, "glTexParameterIuivEXT", &what, &[expected]);
    }

    fn verify_tex_parameter_iiv_for_all(
        &mut self,
        gl: &glw::Functions,
        pname: GLenum,
        params: GLint,
        expected: GLenum,
    ) {
        for target in self.texture_target_list.clone() {
            self.verify_tex_parameter_iiv(gl, target, pname, params, expected);
        }
    }

    fn verify_tex_parameter_iiv_texture_base_level_for_all(
        &mut self,
        gl: &glw::Functions,
        pname: GLenum,
        params: GLint,
        expected: GLenum,
    ) {
        for target in self.texture_target_list.clone() {
            if glw::GL_TEXTURE_2D_MULTISAMPLE == target || glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY == target {
                if 0 > params {
                    self.verify_tex_parameter_iiv_multiple_accepted_errors(
                        gl,
                        target,
                        pname,
                        params,
                        glw::GL_INVALID_OPERATION,
                        glw::GL_INVALID_VALUE,
                    );
                } else {
                    self.verify_tex_parameter_iiv(gl, target, pname, params, glw::GL_INVALID_OPERATION);
                }
            } else {
                self.verify_tex_parameter_iiv(gl, target, pname, params, expected);
            }
        }
    }

    fn verify_tex_parameter_iuiv_for_all(
        &mut self,
        gl: &glw::Functions,
        pname: GLenum,
        params: GLuint,
        expected: GLenum,
    ) {
        for target in self.texture_target_list.clone() {
            self.verify_tex_parameter_iuiv(gl, target, pname, params, expected);
        }
    }

    /// Both I-variants for every target, Iiv first (the order of the paired calls in `iterate`).
    fn verify_tex_parameter_i_both_for_all(
        &mut self,
        gl: &glw::Functions,
        pname: GLenum,
        params: GLuint,
        expected: GLenum,
    ) {
        self.verify_tex_parameter_iiv_for_all(gl, pname, params as GLint, expected);
        self.verify_tex_parameter_iuiv_for_all(gl, pname, params, expected);
    }

    fn verify_get_tex_parameter_iiv(&mut self, gl: &glw::Functions, target: GLenum, pname: GLenum, expected: GLenum) {
        let mut params: Vec<GLint> = vec![0; BUFFER_SIZE];
        // SAFETY: the buffer holds BUFFER_SIZE entries, far more than any queried pname returns.
        unsafe { gl.get_tex_parameter_iiv(target, pname, params.as_mut_ptr()) };
        let what = self.target_pname(target, pname);
        self.check_error(gl, "glGetTexParameterIivEXT", &what, &[expected]);
    }

    fn verify_get_tex_parameter_iuiv(&mut self, gl: &glw::Functions, target: GLenum, pname: GLenum, expected: GLenum) {
        let mut params: Vec<GLuint> = vec![0; BUFFER_SIZE];
        // SAFETY: as above.
        unsafe { gl.get_tex_parameter_iuiv(target, pname, params.as_mut_ptr()) };
        let what = self.target_pname(target, pname);
        self.check_error(gl, "glGetTexParameterIuivEXT", &what, &[expected]);
    }

    fn verify_get_sampler_parameter_iiv(
        &mut self,
        gl: &glw::Functions,
        sampler_id: GLuint,
        pname: GLenum,
        expected: GLenum,
    ) {
        let mut params: Vec<GLint> = vec![0; BUFFER_SIZE];
        // SAFETY: the buffer holds BUFFER_SIZE entries.
        unsafe { gl.get_sampler_parameter_iiv(sampler_id, pname, params.as_mut_ptr()) };
        let what = self.sampler_pname(sampler_id, pname);
        self.check_error(gl, "glGetSamplerParameterIivEXT", &what, &[expected]);
    }

    fn verify_get_sampler_parameter_iuiv(
        &mut self,
        gl: &glw::Functions,
        sampler_id: GLuint,
        pname: GLenum,
        expected: GLenum,
    ) {
        let mut params: Vec<GLuint> = vec![0; BUFFER_SIZE];
        // SAFETY: as above.
        unsafe { gl.get_sampler_parameter_iuiv(sampler_id, pname, params.as_mut_ptr()) };
        let what = self.sampler_pname(sampler_id, pname);
        self.check_error(gl, "glGetSamplerParameterIuivEXT", &what, &[expected]);
    }

    fn verify_sampler_parameter_iiv(
        &mut self,
        gl: &glw::Functions,
        sampler_id: GLuint,
        pname: GLenum,
        params: &[GLint; 4],
        expected: GLenum,
    ) {
        // SAFETY: the array holds the four values the widest pname reads.
        unsafe { gl.sampler_parameter_iiv(sampler_id, pname, params.as_ptr()) };
        let what = self.sampler_pname(sampler_id, pname);
        self.check_error(gl, "glSamplerParameterIivEXT", &what, &[expected]);
    }

    fn verify_sampler_parameter_iuiv(
        &mut self,
        gl: &glw::Functions,
        sampler_id: GLuint,
        pname: GLenum,
        params: &[GLint; 4],
        expected: GLenum,
    ) {
        // SAFETY: as above; upstream reinterprets the same four ints as GLuint.
        unsafe { gl.sampler_parameter_iuiv(sampler_id, pname, params.as_ptr().cast::<GLuint>()) };
        let what = self.sampler_pname(sampler_id, pname);
        self.check_error(gl, "glSamplerParameterIuivEXT", &what, &[expected]);
    }

    /// `initTest` of the tests that generate and bind a sampler
    fn gen_and_bind_sampler(
        &mut self,
        gl: &glw::Functions,
        gen_message: &str,
        bind_message: &str,
    ) -> Result<(), TestError> {
        // SAFETY: object creation and binding on the current context.
        unsafe { gl.gen_samplers(1, &mut self.sampler_id) };
        glu::expect_no_error(gl, gen_message)?;
        // SAFETY: as above.
        unsafe { gl.bind_sampler(TEXTURE_UNIT, self.sampler_id) };
        glu::expect_no_error(gl, bind_message)
    }

    /// `deinit` of the sampler tests
    fn release_sampler(&mut self, gl: &glw::Functions) {
        // SAFETY: unbinds the unit and deletes the sampler this case created.
        unsafe {
            gl.bind_sampler(TEXTURE_UNIT, 0);
            if self.sampler_id != 0 {
                gl.delete_samplers(1, &self.sampler_id);
                self.sampler_id = 0;
            }
        }
    }

    fn result(&self) -> TestOutcome {
        Ok(if self.test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TextureBorderClampError {
    fn not_supported(fixture: &Fixture) -> Result<(), TestError> {
        if !fixture.base.is_texture_border_clamp_supported {
            return Err(TestError::NotSupported(TEXTURE_BORDER_CLAMP_NOT_SUPPORTED.to_string()));
        }
        Ok(())
    }

    /// `TextureBorderClampParameterBorderColorErrorTest::initTest` + `iterate`
    fn border_color_errors(gl: &glw::Functions, f: &mut Fixture) -> TestOutcome {
        Self::not_supported(f)?;
        f.init_all_textures(gl)?;
        f.gen_and_bind_sampler(
            gl,
            "Error generating a sampler object",
            "Error binding a sampler object to texture unit",
        )?;

        let border_color = f.base.gl_ext_tokens.texture_border_color;

        for target in f.texture_target_list.clone() {
            f.verify_tex_parameter_f(gl, target, glw::GL_TEXTURE_BASE_LEVEL, 0.0, glw::GL_NO_ERROR);
            f.verify_tex_parameter_f(gl, target, border_color, 0.0, glw::GL_INVALID_ENUM);
            f.verify_tex_parameter_i(gl, target, glw::GL_TEXTURE_BASE_LEVEL, 0, glw::GL_NO_ERROR);
            f.verify_tex_parameter_i(gl, target, border_color, 0, glw::GL_INVALID_ENUM);
        }

        f.verify_sampler_parameter_f(
            gl,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as GLfloat,
            glw::GL_NO_ERROR,
        );
        f.verify_sampler_parameter_i(
            gl,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as GLint,
            glw::GL_NO_ERROR,
        );

        f.verify_sampler_parameter_f(gl, border_color, 0.0, glw::GL_INVALID_ENUM);
        f.verify_sampler_parameter_i(gl, border_color, 0, glw::GL_INVALID_ENUM);

        f.result()
    }

    /// Checks shared by both multisample targets of `TextureBorderClampTexParameterIErrorsTest::iterate`
    fn multisample_target_errors(gl: &glw::Functions, f: &mut Fixture, target: GLenum) {
        let cases: [(GLenum, GLenum); 8] = [
            (glw::GL_TEXTURE_COMPARE_MODE, glw::GL_NONE),
            (glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LEQUAL),
            (glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR),
            (glw::GL_TEXTURE_MAX_LOD, 1000),
            (glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST_MIPMAP_LINEAR),
            (glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT),
            (glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT),
            (glw::GL_TEXTURE_WRAP_R, glw::GL_REPEAT),
        ];
        for (pname, value) in cases {
            f.verify_tex_parameter_iiv(gl, target, pname, value as GLint, glw::GL_INVALID_ENUM);
            f.verify_tex_parameter_iuiv(gl, target, pname, value, glw::GL_INVALID_ENUM);
            if pname == glw::GL_TEXTURE_MIN_FILTER {
                f.verify_tex_parameter_iiv(gl, target, glw::GL_TEXTURE_MIN_LOD, -1000, glw::GL_INVALID_ENUM);
            }
        }
    }

    /// `TextureBorderClampTexParameterIErrorsTest::initTest` + `iterate`
    fn tex_parameter_i_errors(gl: &glw::Functions, f: &mut Fixture) -> TestOutcome {
        Self::not_supported(f)?;
        f.init_all_textures(gl)?;

        if f.base.is_texture_buffer_supported {
            let texture_buffer = f.base.gl_ext_tokens.texture_buffer;
            f.verify_tex_parameter_iiv(gl, texture_buffer, glw::GL_TEXTURE_BASE_LEVEL, 1, glw::GL_INVALID_ENUM);
            f.verify_tex_parameter_iuiv(gl, texture_buffer, glw::GL_TEXTURE_BASE_LEVEL, 1, glw::GL_INVALID_ENUM);
        }

        f.verify_tex_parameter_iiv(
            gl,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_TEXTURE_BASE_LEVEL,
            1,
            glw::GL_INVALID_ENUM,
        );
        f.verify_tex_parameter_iuiv(
            gl,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_TEXTURE_BASE_LEVEL,
            1,
            glw::GL_INVALID_ENUM,
        );

        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_IMMUTABLE_FORMAT, 1, glw::GL_INVALID_ENUM);

        f.verify_tex_parameter_iiv_texture_base_level_for_all(
            gl,
            glw::GL_TEXTURE_BASE_LEVEL,
            -1,
            glw::GL_INVALID_VALUE,
        );
        f.verify_tex_parameter_iiv_for_all(gl, glw::GL_TEXTURE_MAX_LEVEL, -1, glw::GL_INVALID_VALUE);

        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_COMPARE_MODE, glw::GL_NEAREST, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_NEAREST, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(
            gl,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST_MIPMAP_NEAREST,
            glw::GL_INVALID_ENUM,
        );
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_MIN_FILTER, glw::GL_RED, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_SWIZZLE_R, glw::GL_NEAREST, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_SWIZZLE_G, glw::GL_NEAREST, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_SWIZZLE_B, glw::GL_NEAREST, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_SWIZZLE_A, glw::GL_NEAREST, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_WRAP_S, glw::GL_RED, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_WRAP_T, glw::GL_RED, glw::GL_INVALID_ENUM);
        f.verify_tex_parameter_i_both_for_all(gl, glw::GL_TEXTURE_WRAP_R, glw::GL_RED, glw::GL_INVALID_ENUM);

        if f.base.is_texture_storage_multisample_supported {
            Self::multisample_target_errors(gl, f, glw::GL_TEXTURE_2D_MULTISAMPLE);
        }
        if f.base.is_texture_storage_multisample_2d_array_supported {
            Self::multisample_target_errors(gl, f, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY);
        }

        f.result()
    }

    /// `TextureBorderClampGetTexParameterIErrorsTest::CheckAllNames`
    fn check_all_names(
        gl: &glw::Functions,
        f: &mut Fixture,
        pnames: &[GLenum],
        target: GLenum,
        expected_error: GLenum,
    ) {
        for &pname in pnames {
            f.verify_get_tex_parameter_iiv(gl, target, pname, expected_error);
            f.verify_get_tex_parameter_iuiv(gl, target, pname, expected_error);
        }
    }

    /// `TextureBorderClampGetTexParameterIErrorsTest::initTest` + `iterate`
    fn get_tex_parameter_i_errors(gl: &glw::Functions, f: &mut Fixture) -> TestOutcome {
        Self::not_supported(f)?;
        f.init_all_textures(gl)?;

        let pnames = [
            glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
            glw::GL_TEXTURE_BASE_LEVEL,
            f.base.gl_ext_tokens.texture_border_color,
            glw::GL_TEXTURE_COMPARE_FUNC,
            glw::GL_TEXTURE_IMMUTABLE_FORMAT,
            glw::GL_TEXTURE_IMMUTABLE_LEVELS,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_TEXTURE_MAX_LEVEL,
            glw::GL_TEXTURE_MAX_LOD,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_TEXTURE_MIN_LOD,
            glw::GL_TEXTURE_SWIZZLE_R,
            glw::GL_TEXTURE_SWIZZLE_G,
            glw::GL_TEXTURE_SWIZZLE_B,
            glw::GL_TEXTURE_SWIZZLE_A,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_TEXTURE_WRAP_T,
            glw::GL_TEXTURE_WRAP_R,
        ];

        Self::check_all_names(gl, f, &pnames, glw::GL_TEXTURE_CUBE_MAP, glw::GL_NO_ERROR);
        Self::check_all_names(
            gl,
            f,
            &pnames,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_INVALID_ENUM,
        );
        if f.base.is_texture_buffer_supported {
            let texture_buffer = f.base.gl_ext_tokens.texture_buffer;
            Self::check_all_names(gl, f, &pnames, texture_buffer, glw::GL_INVALID_ENUM);
        }

        f.result()
    }

    /// `TextureBorderClampSamplerParameterIErrorTest::initTest` + `iterate`
    fn sampler_parameter_i_error(gl: &glw::Functions, f: &mut Fixture) -> TestOutcome {
        Self::not_supported(f)?;
        f.gen_and_bind_sampler(gl, "Error generating sampler object", "Error binding sampler object")?;

        let pnames_list: [(GLenum, [GLint; 4]); 10] = [
            (glw::GL_TEXTURE_MAG_FILTER, [glw::GL_LINEAR as GLint, 0, 0, 0]),
            (
                glw::GL_TEXTURE_MIN_FILTER,
                [glw::GL_NEAREST_MIPMAP_LINEAR as GLint, 0, 0, 0],
            ),
            (glw::GL_TEXTURE_MIN_LOD, [1, 0, 0, 0]),
            (glw::GL_TEXTURE_MAX_LOD, [1, 0, 0, 0]),
            (glw::GL_TEXTURE_WRAP_S, [glw::GL_REPEAT as GLint, 0, 0, 0]),
            (glw::GL_TEXTURE_WRAP_T, [glw::GL_REPEAT as GLint, 0, 0, 0]),
            (glw::GL_TEXTURE_WRAP_R, [glw::GL_REPEAT as GLint, 0, 0, 0]),
            (f.base.gl_ext_tokens.texture_border_color, [0, 0, 0, 0]),
            (glw::GL_TEXTURE_COMPARE_MODE, [glw::GL_NONE as GLint, 0, 0, 0]),
            (glw::GL_TEXTURE_COMPARE_FUNC, [glw::GL_LEQUAL as GLint, 0, 0, 0]),
        ];

        let sampler_id = f.sampler_id;

        for (pname, _) in &pnames_list {
            f.verify_get_sampler_parameter_iiv(gl, sampler_id, *pname, glw::GL_NO_ERROR);
            f.verify_get_sampler_parameter_iuiv(gl, sampler_id, *pname, glw::GL_NO_ERROR);
        }
        for (pname, _) in &pnames_list {
            f.verify_get_sampler_parameter_iiv(gl, sampler_id + 1, *pname, glw::GL_INVALID_OPERATION);
            f.verify_get_sampler_parameter_iuiv(gl, sampler_id + 1, *pname, glw::GL_INVALID_OPERATION);
        }
        for (pname, params) in &pnames_list {
            f.verify_sampler_parameter_iiv(gl, sampler_id, *pname, params, glw::GL_NO_ERROR);
            f.verify_sampler_parameter_iuiv(gl, sampler_id, *pname, params, glw::GL_NO_ERROR);
        }
        for (pname, params) in &pnames_list {
            f.verify_sampler_parameter_iiv(gl, sampler_id + 2, *pname, params, glw::GL_INVALID_OPERATION);
            f.verify_sampler_parameter_iuiv(gl, sampler_id + 2, *pname, params, glw::GL_INVALID_OPERATION);
        }

        f.result()
    }

    /// `TextureBorderClampSamplerParameterIWithWrongPnameTest::initTest` + `iterate`
    fn sampler_parameter_i_with_wrong_pname(gl: &glw::Functions, f: &mut Fixture) -> TestOutcome {
        Self::not_supported(f)?;
        f.gen_and_bind_sampler(gl, "Error generating sampler object", "Error binding sampler object")?;

        let pnames = [
            glw::GL_TEXTURE_BASE_LEVEL,
            glw::GL_TEXTURE_IMMUTABLE_FORMAT,
            glw::GL_TEXTURE_MAX_LEVEL,
            glw::GL_TEXTURE_SWIZZLE_R,
            glw::GL_TEXTURE_SWIZZLE_G,
            glw::GL_TEXTURE_SWIZZLE_B,
            glw::GL_TEXTURE_SWIZZLE_A,
        ];
        let sampler_id = f.sampler_id;
        let params = [0; 4];

        for pname in pnames {
            f.verify_get_sampler_parameter_iiv(gl, sampler_id, pname, glw::GL_INVALID_ENUM);
            f.verify_get_sampler_parameter_iuiv(gl, sampler_id, pname, glw::GL_INVALID_ENUM);
            f.verify_sampler_parameter_iiv(gl, sampler_id, pname, &params, glw::GL_INVALID_ENUM);
            f.verify_sampler_parameter_iuiv(gl, sampler_id, pname, &params, glw::GL_INVALID_ENUM);
        }

        f.result()
    }
}

impl TestCase for TextureBorderClampError {
    fn name(&self) -> &str {
        match self.variant {
            Variant::BorderColorErrors => "border_color_errors",
            Variant::TexParameterIErrors => "texparameteri_errors",
            Variant::GetTexParameterIErrors => "gettexparameteri_errors",
            Variant::SamplerParameterIError => "samplerparameteri_non_gen_sampler_error",
            Variant::SamplerParameterIWithWrongPname => "samplerparameteri_with_wrong_pname",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut fixture = Fixture::new(TestCaseBase::init(context, self.ext_params));

        let outcome = match self.variant {
            Variant::BorderColorErrors => Self::border_color_errors(gl, &mut fixture),
            Variant::TexParameterIErrors => Self::tex_parameter_i_errors(gl, &mut fixture),
            Variant::GetTexParameterIErrors => Self::get_tex_parameter_i_errors(gl, &mut fixture),
            Variant::SamplerParameterIError => Self::sampler_parameter_i_error(gl, &mut fixture),
            Variant::SamplerParameterIWithWrongPname => Self::sampler_parameter_i_with_wrong_pname(gl, &mut fixture),
        };

        if matches!(
            self.variant,
            Variant::BorderColorErrors | Variant::SamplerParameterIError | Variant::SamplerParameterIWithWrongPname
        ) {
            fixture.release_sampler(gl);
        }
        fixture.deinit_all_textures(gl);
        outcome
    }
}

/// `TextureBorderClampTests::init`
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_border_clamp");
    for variant in [
        Variant::BorderColorErrors,
        Variant::TexParameterIErrors,
        Variant::GetTexParameterIErrors,
        Variant::SamplerParameterIError,
        Variant::SamplerParameterIWithWrongPname,
    ] {
        group.add_child(Box::new(TextureBorderClampError { ext_params, variant }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(border_color::ParameterTextureBorderColor { ext_params }) as Box<dyn TestCase>);
    sampling::add_tests(&mut group, ext_params);
    group
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayGetterCalls.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayGetterCalls.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `std::map` of pnames is a `BTreeMap`, keeping upstream's iteration in pname order. Quirk kept: the glGetIntegerv() binding check compares the float value.

use std::collections::BTreeMap;

use super::TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLfloat, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const DEPTH: GLint = 6;
const HEIGHT: GLint = 64;
const WIDTH: GLint = 64;
const N_COMPONENTS: usize = 4;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `TextureCubeMapArrayGetterCalls` (Test 6)
pub(super) struct GetterCalls {
    pub(super) ext_params: ExtParameters,
}

/// `getStringForGetTexParameterPname`
fn tex_parameter_pname_string(pname: GLenum) -> &'static str {
    match pname {
        glw::GL_TEXTURE_BASE_LEVEL => "GL_TEXTURE_BASE_LEVEL",
        glw::GL_TEXTURE_MAX_LEVEL => "GL_TEXTURE_MAX_LEVEL",
        glw::GL_TEXTURE_MIN_FILTER => "GL_TEXTURE_MIN_FILTER",
        glw::GL_TEXTURE_MAG_FILTER => "GL_TEXTURE_MAG_FILTER",
        glw::GL_TEXTURE_MIN_LOD => "GL_TEXTURE_MIN_LOD",
        glw::GL_TEXTURE_MAX_LOD => "GL_TEXTURE_MAX_LOD",
        glw::GL_TEXTURE_SWIZZLE_R => "GL_TEXTURE_SWIZZLE_R",
        glw::GL_TEXTURE_SWIZZLE_G => "GL_TEXTURE_SWIZZLE_G",
        glw::GL_TEXTURE_SWIZZLE_B => "GL_TEXTURE_SWIZZLE_B",
        glw::GL_TEXTURE_SWIZZLE_A => "GL_TEXTURE_SWIZZLE_A",
        glw::GL_TEXTURE_WRAP_S => "GL_TEXTURE_WRAP_S",
        glw::GL_TEXTURE_WRAP_T => "GL_TEXTURE_WRAP_T",
        glw::GL_TEXTURE_WRAP_R => "GL_TEXTURE_WRAP_R",
        _ => "UNKNOWN PARAMETER NAME",
    }
}

/// `getStringForGetTexLevelParameterPname`
fn tex_level_parameter_pname_string(pname: GLenum) -> &'static str {
    match pname {
        glw::GL_TEXTURE_COMPRESSED => "GL_TEXTURE_COMPRESSED",
        glw::GL_TEXTURE_ALPHA_SIZE => "GL_TEXTURE_ALPHA_SIZE",
        glw::GL_TEXTURE_BLUE_SIZE => "GL_TEXTURE_BLUE_SIZE",
        glw::GL_TEXTURE_GREEN_SIZE => "GL_TEXTURE_GREEN_SIZE",
        glw::GL_TEXTURE_RED_SIZE => "GL_TEXTURE_RED_SIZE",
        glw::GL_TEXTURE_DEPTH_SIZE => "GL_TEXTURE_DEPTH_SIZE",
        glw::GL_TEXTURE_SHARED_SIZE => "GL_TEXTURE_SHARED_SIZE",
        glw::GL_TEXTURE_STENCIL_SIZE => "GL_TEXTURE_STENCIL_SIZE",
        glw::GL_TEXTURE_ALPHA_TYPE => "GL_TEXTURE_ALPHA_TYPE",
        glw::GL_TEXTURE_BLUE_TYPE => "GL_TEXTURE_BLUE_TYPE",
        glw::GL_TEXTURE_GREEN_TYPE => "GL_TEXTURE_GREEN_TYPE",
        glw::GL_TEXTURE_RED_TYPE => "GL_TEXTURE_RED_TYPE",
        glw::GL_TEXTURE_DEPTH_TYPE => "GL_TEXTURE_DEPTH_TYPE",
        glw::GL_TEXTURE_INTERNAL_FORMAT => "GL_TEXTURE_INTERNAL_FORMAT",
        glw::GL_TEXTURE_WIDTH => "GL_TEXTURE_WIDTH",
        glw::GL_TEXTURE_HEIGHT => "GL_TEXTURE_HEIGHT",
        glw::GL_TEXTURE_DEPTH => "GL_TEXTURE_DEPTH",
        _ => "UNKNOWN PARAMETER NAME",
    }
}

/// The expected values `iterate` updates between the mutable and the immutable storage
#[derive(Default)]
struct Expected {
    alpha_size: GLint,
    alpha_type: GLint,
    blue_size: GLint,
    blue_type: GLint,
    compressed: GLint,
    depth_size: GLint,
    depth_type: GLint,
    green_size: GLint,
    green_type: GLint,
    red_size: GLint,
    red_type: GLint,
    shared_size: GLint,
    stencil_size: GLint,
    texture_internal_format: GLint,
}

struct Runner<'a> {
    context: &'a Context,
    to_id: GLuint,
    test_passed: bool,
    expected: Expected,
    gettexparameter_default: BTreeMap<GLenum, GLint>,
    gettexparameter_modified: BTreeMap<GLenum, GLint>,
    gettexlevelparameter: Vec<GLenum>,
}

impl Runner<'_> {
    /// `verifyTextureBindings`
    fn verify_texture_bindings(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        let mut bool_value: glw::GLboolean = glw::FALSE;
        let epsilon = 1e-5f32;
        let mut float_value: GLfloat = 0.0;
        let mut int_value: GLint = 0;

        gl_call!(
            gl,
            "glGetBooleanv() failed for GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_EXT pname",
            gl.get_booleanv(glw::GL_TEXTURE_BINDING_CUBE_MAP_ARRAY, &mut bool_value)
        );
        if (self.to_id == 0 && bool_value != glw::FALSE) || (self.to_id != 0 && bool_value != glw::TRUE) {
            log::info!("glGetBooleanv() reported an invalid value for GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_EXT pname");
            self.test_passed = false;
        }

        gl_call!(
            gl,
            "glGetFloatv() failed for GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_EXT pname",
            gl.get_floatv(glw::GL_TEXTURE_BINDING_CUBE_MAP_ARRAY, &mut float_value)
        );
        if (float_value - self.to_id as f32).abs() > epsilon {
            log::info!("glGetFloatv() reported an invalid value for GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_EXT pname");
            self.test_passed = false;
        }

        gl_call!(
            gl,
            "glGetIntegerv() failed for GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_EXT pname",
            gl.get_integerv(glw::GL_TEXTURE_BINDING_CUBE_MAP_ARRAY, &mut int_value)
        );
        if (float_value - self.to_id as f32).abs() > epsilon {
            log::info!("glGetIntegerv() reported an invalid value for GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_EXT pname");
            self.test_passed = false;
        }
        Ok(())
    }

    /// `verifyGetTexParameter`
    fn verify_get_tex_parameter(&mut self, pname: GLenum, expected_value: GLint) -> Result<(), TestError> {
        let gl = self.context.gl();
        let mut int_value: GLint = 0;

        // SAFETY: one int out.
        unsafe { gl.get_tex_parameteriv(glw::GL_TEXTURE_CUBE_MAP_ARRAY, pname, &mut int_value) };
        // SAFETY: plain error query.
        if unsafe { gl.get_error() } != glw::GL_NO_ERROR {
            log::info!(
                "glGetTexParameteriv() call failed for pname: {}",
                tex_parameter_pname_string(pname)
            );
            return Err(TestError::Fail("glGetTexLevelParameteriv() call failed".to_string()));
        }

        if int_value != expected_value {
            log::info!(
                "glGetTexParameteriv() called for pname: [{}] returned an invalid value of:[{int_value}], expected:[{expected_value}]",
                tex_parameter_pname_string(pname)
            );
            self.test_passed = false;
        }
        Ok(())
    }

    /// `verifyGetTexLevelParameters`
    fn verify_get_tex_level_parameters(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        let epsilon = 1e-5f32;

        for &pname in &self.gettexlevelparameter.clone() {
            let mut int_value: GLint = 0;
            let mut float_value: GLfloat = 0.0;

            // SAFETY: one int out.
            unsafe { gl.get_tex_level_parameteriv(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0, pname, &mut int_value) };
            // SAFETY: plain error query.
            if unsafe { gl.get_error() } != glw::GL_NO_ERROR {
                log::info!(
                    "glGetTexLevelParameteriv() call failed for pname: {}",
                    tex_level_parameter_pname_string(pname)
                );
                return Err(TestError::Fail("glGetTexLevelParameteriv() call failed".to_string()));
            }

            // SAFETY: one float out.
            unsafe { gl.get_tex_level_parameterfv(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0, pname, &mut float_value) };
            // SAFETY: plain error query.
            if unsafe { gl.get_error() } != glw::GL_NO_ERROR {
                log::info!(
                    "glGetTexLevelParameterfv() call failed for pname: {}",
                    tex_level_parameter_pname_string(pname)
                );
                return Err(TestError::Fail("glGetTexLevelParameterfv() call failed".to_string()));
            }

            let e = &self.expected;
            // the colour sizes and the shared size only have to be at most the expected value
            let (expected_property_int_value, should_use_equal_comparison) = match pname {
                glw::GL_TEXTURE_ALPHA_SIZE => (e.alpha_size, false),
                glw::GL_TEXTURE_ALPHA_TYPE => (e.alpha_type, true),
                glw::GL_TEXTURE_BLUE_SIZE => (e.blue_size, false),
                glw::GL_TEXTURE_BLUE_TYPE => (e.blue_type, true),
                glw::GL_TEXTURE_COMPRESSED => (e.compressed, true),
                glw::GL_TEXTURE_DEPTH => (DEPTH, true),
                glw::GL_TEXTURE_DEPTH_SIZE => (e.depth_size, true),
                glw::GL_TEXTURE_DEPTH_TYPE => (e.depth_type, true),
                glw::GL_TEXTURE_GREEN_SIZE => (e.green_size, false),
                glw::GL_TEXTURE_GREEN_TYPE => (e.green_type, true),
                glw::GL_TEXTURE_HEIGHT => (HEIGHT, true),
                glw::GL_TEXTURE_INTERNAL_FORMAT => (e.texture_internal_format, true),
                glw::GL_TEXTURE_RED_SIZE => (e.red_size, false),
                glw::GL_TEXTURE_RED_TYPE => (e.red_type, true),
                glw::GL_TEXTURE_SHARED_SIZE => (e.shared_size, false),
                glw::GL_TEXTURE_STENCIL_SIZE => (e.stencil_size, true),
                glw::GL_TEXTURE_WIDTH => (WIDTH, true),
                _ => return Err(TestError::Fail("Unrecognized pname".to_string())),
            };

            if (should_use_equal_comparison && expected_property_int_value != int_value)
                || (!should_use_equal_comparison && expected_property_int_value < int_value)
            {
                log::info!(
                    "glGetTexLevelParameteriv() called for pname: [{}] returned an invalid value of:[{int_value}], expected:[{expected_property_int_value}]",
                    tex_level_parameter_pname_string(pname)
                );
                self.test_passed = false;
            }

            let expected_property_float_value = expected_property_int_value as GLfloat;
            if (should_use_equal_comparison && (float_value - expected_property_float_value).abs() > epsilon)
                || (!should_use_equal_comparison && expected_property_float_value < float_value)
            {
                log::info!(
                    "glGetTexLevelParameterfv() called for pname: [{}] returned an invalid value of:[{float_value}], expected:[{expected_property_float_value}]",
                    tex_level_parameter_pname_string(pname)
                );
                self.test_passed = false;
            }
        }
        Ok(())
    }

    /// The `verifyGetTexParameter` / `glTexParameteriv` / `verifyGetTexParameter` sequence both storage types go through
    fn verify_parameters(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        for (pname, expected_value) in self.gettexparameter_default.clone() {
            self.verify_get_tex_parameter(pname, expected_value)?;
        }

        for (pname, value) in self.gettexparameter_modified.clone() {
            // SAFETY: one int in.
            unsafe { gl.tex_parameteriv(glw::GL_TEXTURE_CUBE_MAP_ARRAY, pname, &value) };
            // SAFETY: plain error query.
            if unsafe { gl.get_error() } != glw::GL_NO_ERROR {
                log::info!(
                    "glTexParameteriv() call failed for pname: {} and value: {value}",
                    tex_parameter_pname_string(pname)
                );
                return Err(TestError::Fail("glTexParameteriv() call failed".to_string()));
            }
            self.verify_get_tex_parameter(pname, value)?;
        }
        Ok(())
    }

    fn run(&mut self, base: &TestCaseBase) -> Result<bool, TestError> {
        let gl = self.context.gl();

        // `initTest`
        if !base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        self.gettexparameter_default = BTreeMap::from([
            (glw::GL_TEXTURE_BASE_LEVEL, 0),
            (glw::GL_TEXTURE_MAX_LEVEL, 1000),
            (glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST_MIPMAP_LINEAR as GLint),
            (glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as GLint),
            (glw::GL_TEXTURE_MIN_LOD, -1000),
            (glw::GL_TEXTURE_MAX_LOD, 1000),
            (glw::GL_TEXTURE_SWIZZLE_R, glw::GL_RED as GLint),
            (glw::GL_TEXTURE_SWIZZLE_G, glw::GL_GREEN as GLint),
            (glw::GL_TEXTURE_SWIZZLE_B, glw::GL_BLUE as GLint),
            (glw::GL_TEXTURE_SWIZZLE_A, glw::GL_ALPHA as GLint),
            (glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as GLint),
            (glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as GLint),
            (glw::GL_TEXTURE_WRAP_R, glw::GL_REPEAT as GLint),
        ]);
        self.gettexparameter_modified = BTreeMap::from([
            (glw::GL_TEXTURE_BASE_LEVEL, 1),
            (glw::GL_TEXTURE_MAX_LEVEL, 1),
            (glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint),
            (glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint),
            (glw::GL_TEXTURE_MIN_LOD, -10),
            (glw::GL_TEXTURE_MAX_LOD, 10),
            (glw::GL_TEXTURE_SWIZZLE_R, glw::GL_GREEN as GLint),
            (glw::GL_TEXTURE_SWIZZLE_G, glw::GL_BLUE as GLint),
            (glw::GL_TEXTURE_SWIZZLE_B, glw::GL_ALPHA as GLint),
            (glw::GL_TEXTURE_SWIZZLE_A, glw::GL_RED as GLint),
            (glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as GLint),
            (glw::GL_TEXTURE_WRAP_T, glw::GL_MIRRORED_REPEAT as GLint),
            (glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as GLint),
        ]);
        self.gettexlevelparameter = vec![
            glw::GL_TEXTURE_COMPRESSED,
            glw::GL_TEXTURE_ALPHA_SIZE,
            glw::GL_TEXTURE_BLUE_SIZE,
            glw::GL_TEXTURE_GREEN_SIZE,
            glw::GL_TEXTURE_RED_SIZE,
            glw::GL_TEXTURE_DEPTH_SIZE,
            glw::GL_TEXTURE_SHARED_SIZE,
            glw::GL_TEXTURE_STENCIL_SIZE,
            glw::GL_TEXTURE_ALPHA_TYPE,
            glw::GL_TEXTURE_BLUE_TYPE,
            glw::GL_TEXTURE_GREEN_TYPE,
            glw::GL_TEXTURE_RED_TYPE,
            glw::GL_TEXTURE_DEPTH_TYPE,
            glw::GL_TEXTURE_INTERNAL_FORMAT,
            glw::GL_TEXTURE_WIDTH,
            glw::GL_TEXTURE_HEIGHT,
            glw::GL_TEXTURE_DEPTH,
        ];

        gl_call!(
            gl,
            "Could not generate a texture object!",
            gl.gen_textures(1, &mut self.to_id)
        );
        gl_call!(
            gl,
            "Could not bind a texture object!",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, self.to_id)
        );

        // mutable texture storage
        let texture_data_ubyte = vec![0u8; (WIDTH * HEIGHT * DEPTH) as usize * N_COMPONENTS];
        for level in [0, 1] {
            gl_call!(
                gl,
                "Could not create mutable texture storage!",
                gl.tex_image_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    level,
                    glw::GL_RGBA8 as GLint,
                    WIDTH,
                    HEIGHT,
                    DEPTH,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    texture_data_ubyte.as_ptr().cast()
                )
            );
        }

        self.expected = Expected {
            compressed: glw::GL_FALSE as GLint,
            alpha_size: 8,
            alpha_type: glw::GL_UNSIGNED_NORMALIZED as GLint,
            blue_size: 8,
            blue_type: glw::GL_UNSIGNED_NORMALIZED as GLint,
            green_size: 8,
            green_type: glw::GL_UNSIGNED_NORMALIZED as GLint,
            red_size: 8,
            red_type: glw::GL_UNSIGNED_NORMALIZED as GLint,
            depth_size: 0,
            depth_type: glw::GL_NONE as GLint,
            shared_size: 0,
            stencil_size: 0,
            texture_internal_format: glw::GL_RGBA8 as GLint,
        };

        self.verify_texture_bindings()?;
        self.verify_parameters()?;
        self.verify_get_tex_level_parameters()?;

        // a new texture object with immutable storage
        // SAFETY: deletes the name this test created.
        unsafe { gl.delete_textures(1, &self.to_id) };
        self.to_id = 0;

        gl_call!(
            gl,
            "Could not generate a texture object!",
            gl.gen_textures(1, &mut self.to_id)
        );
        gl_call!(
            gl,
            "Could not bind a texture object!",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, self.to_id)
        );
        gl_call!(
            gl,
            "Could not create an immutable texture storage!",
            gl.tex_storage_3d(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 2, glw::GL_RGBA32F, WIDTH, HEIGHT, DEPTH)
        );

        self.expected = Expected {
            compressed: glw::GL_FALSE as GLint,
            alpha_size: 32,
            alpha_type: glw::GL_FLOAT as GLint,
            blue_size: 32,
            blue_type: glw::GL_FLOAT as GLint,
            green_size: 32,
            green_type: glw::GL_FLOAT as GLint,
            red_size: 32,
            red_type: glw::GL_FLOAT as GLint,
            depth_size: 0,
            depth_type: glw::GL_NONE as GLint,
            shared_size: 0,
            stencil_size: 0,
            texture_internal_format: glw::GL_RGBA32F as GLint,
        };

        self.verify_texture_bindings()?;
        self.verify_parameters()?;
        self.verify_get_tex_level_parameters()?;

        Ok(self.test_passed)
    }
}

impl TestCase for GetterCalls {
    fn name(&self) -> &str {
        "getter_calls"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut runner = Runner {
            context,
            to_id: 0,
            test_passed: true,
            expected: Expected::default(),
            gettexparameter_default: BTreeMap::new(),
            gettexparameter_modified: BTreeMap::new(),
            gettexlevelparameter: Vec::new(),
        };

        let outcome = runner.run(&base);

        // `deinit`
        let gl = context.gl();
        // SAFETY: resets the binding and deletes the name this test created.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            if runner.to_id != 0 {
                gl.delete_textures(1, &runner.to_id);
            }
        }

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

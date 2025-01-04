// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayTex3DValidation.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayTex3DValidation.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TextureCubeMapArrayTex3DValidation` (Test 4)
pub(super) struct Tex3DValidation {
    pub(super) ext_params: ExtParameters,
}

/// `checkError`
fn check_error(gl: &glw::Functions, expected_error: GLenum, message: &str) -> bool {
    // SAFETY: reads the error flag of the current context.
    let error = unsafe { gl.get_error() };
    if error != expected_error {
        log::info!(
            "{message} Expected error: {} Current error: {}",
            glw::error_name(expected_error),
            glw::error_name(error)
        );
        return false;
    }
    true
}

/// `createTexture`
fn create_texture(gl: &glw::Functions, to_id: &mut GLuint) -> Result<(), TestError> {
    // SAFETY: object creation and binding on the current context.
    unsafe { gl.gen_textures(1, to_id) };
    glu::expect_no_error(gl, "glGenTextures() call failed")?;
    // SAFETY: as above.
    unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, *to_id) };
    glu::expect_no_error(
        gl,
        "Error binding the texture object to GL_TEXTURE_CUBE_MAP_ARRAY_EXT texture target!",
    )
}

/// `deleteTexture`
fn delete_texture(gl: &glw::Functions, to_id: &mut GLuint, supported: bool) -> Result<(), TestError> {
    if supported {
        // SAFETY: unbinds the texture target on the current context.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0) };
        glu::expect_no_error(
            gl,
            "glBindTexture() call failed for GL_TEXTURE_CUBE_MAP_ARRAY_EXT texture target",
        )?;
    }
    if *to_id != 0 {
        // SAFETY: deletes the name this test created.
        unsafe { gl.delete_textures(1, to_id) };
        glu::expect_no_error(gl, "glDeleteTextures() call failed")?;
        *to_id = 0;
    }
    Ok(())
}

impl Tex3DValidation {
    fn run(&self, context: &Context, base: &TestCaseBase, to_id: &mut GLuint) -> Result<bool, TestError> {
        let gl = context.gl();
        let supported = base.is_texture_cube_map_array_supported;
        let mut result = true;

        if !supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        // GL_INVALID_VALUE is not set if width and height are equal
        let correct_width: GLint = 4;
        let correct_height: GLint = 4;
        let correct_depth: GLint = 6;

        create_texture(gl, to_id)?;

        // SAFETY: a null data pointer allocates storage only.
        unsafe {
            gl.tex_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                glw::GL_RGBA8 as GLint,
                correct_width,
                correct_height,
                correct_depth,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        if !check_error(
            gl,
            glw::GL_NO_ERROR,
            "glTexImage3D() call failed when called with valid arguments - ",
        ) {
            result = false;
        }

        // SAFETY: plain storage allocation.
        unsafe {
            gl.tex_storage_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                1,
                glw::GL_RGBA8,
                correct_width,
                correct_height,
                correct_depth,
            )
        };
        if !check_error(
            gl,
            glw::GL_NO_ERROR,
            "glTexStorage3D() call failed when called with valid arguments - ",
        ) {
            result = false;
        }

        delete_texture(gl, to_id, supported)?;
        create_texture(gl, to_id)?;

        // GL_INVALID_VALUE is set if width and height are not equal
        let incorrect_width: GLint = 4;
        let incorrect_height: GLint = 3;
        // SAFETY: as above.
        unsafe {
            gl.tex_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                glw::GL_RGBA8 as GLint,
                incorrect_width,
                incorrect_height,
                correct_depth,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        if !check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "glTexImage3D() call generated an invalid error code when width != height - ",
        ) {
            result = false;
        }

        // SAFETY: as above.
        unsafe {
            gl.tex_storage_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                1,
                glw::GL_RGBA8,
                incorrect_width,
                incorrect_height,
                correct_depth,
            )
        };
        if !check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "glTexStorage3D() call generated an invalid error code when width != height - ",
        ) {
            result = false;
        }

        delete_texture(gl, to_id, supported)?;
        create_texture(gl, to_id)?;

        // GL_INVALID_VALUE is set if depth is not a multiple of six
        let incorrect_depth: GLint = 7;
        // SAFETY: as above.
        unsafe {
            gl.tex_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                glw::GL_RGBA8 as GLint,
                correct_width,
                correct_height,
                incorrect_depth,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        if !check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "glTexImage3D() call generated an invalid error code when depth was not a multiple of six - ",
        ) {
            result = false;
        }

        delete_texture(gl, to_id, supported)?;
        create_texture(gl, to_id)?;

        // SAFETY: as above.
        unsafe {
            gl.tex_storage_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                1,
                glw::GL_RGBA8,
                correct_width,
                correct_height,
                incorrect_depth,
            )
        };
        if !check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "glTexStorage3D() call generated an invalid error code when depth was not a multiple of six - ",
        ) {
            result = false;
        }

        delete_texture(gl, to_id, supported)?;
        create_texture(gl, to_id)?;

        // GL_INVALID_OPERATION is set if the levels argument is greater than floor(log2(max(width, height))) + 1
        let max_texture_size = correct_width.max(correct_height) as f32;
        let max_levels = (max_texture_size.ln() / 2.0f32.ln()).floor() as GLint + 1;
        // SAFETY: as above.
        unsafe {
            gl.tex_storage_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                max_levels + 1,
                glw::GL_RGBA8,
                correct_width,
                correct_height,
                correct_depth,
            )
        };
        if !check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "glTexStorage3D() call generated an invalid error code when levels argument was greater than floor(log2(max(width, height))) + 1 - ",
        ) {
            result = false;
        }

        delete_texture(gl, to_id, supported)?;
        Ok(result)
    }
}

impl TestCase for Tex3DValidation {
    fn name(&self) -> &str {
        "tex3D_validation"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut to_id: GLuint = 0;

        let outcome = self.run(context, &base, &mut to_id);
        // `deinit`: whatever an early error left behind
        let cleanup = delete_texture(context.gl(), &mut to_id, base.is_texture_cube_map_array_supported);

        let result = outcome?;
        cleanup?;
        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

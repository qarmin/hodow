// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferParameters.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::collections::BTreeMap;

use super::TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLhalf, GLint, GLintptr, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const N_TEXELS_PHASE_ONE: GLuint = 128;
const N_TEXELS_PHASE_TWO: GLuint = 256;

/// `TextureBufferParameters`
pub(super) struct Parameters {
    pub(super) ext_params: ExtParameters,
}

/// The members `initTest` fills and `deinit` releases; the map is ordered by enum value like upstream's `std::map`.
#[derive(Default)]
struct Objects {
    tbo_id: GLuint,
    to_id: GLuint,
    internal_formats: BTreeMap<GLenum, GLuint>,
}

impl Parameters {
    /// `initTest`
    fn init_test(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let half = size_of::<GLhalf>() as GLuint;
        let formats: [(GLenum, GLuint); 29] = [
            (glw::GL_R8, 1),
            (glw::GL_R16F, half),
            (glw::GL_R32F, 4),
            (glw::GL_R8I, 1),
            (glw::GL_R16I, 2),
            (glw::GL_R32I, 4),
            (glw::GL_R8UI, 1),
            (glw::GL_R16UI, 2),
            (glw::GL_R32UI, 4),
            (glw::GL_RG8, 2),
            (glw::GL_RG16F, half * 2),
            (glw::GL_RG32F, 8),
            (glw::GL_RG8I, 2),
            (glw::GL_RG16I, 4),
            (glw::GL_RG32I, 8),
            (glw::GL_RG8UI, 2),
            (glw::GL_RG16UI, 4),
            (glw::GL_RG32UI, 8),
            (glw::GL_RGB32F, 12),
            (glw::GL_RGB32I, 12),
            (glw::GL_RGB32UI, 12),
            (glw::GL_RGBA8, 4),
            (glw::GL_RGBA16F, half * 4),
            (glw::GL_RGBA32F, 16),
            (glw::GL_RGBA8I, 4),
            (glw::GL_RGBA16I, 8),
            (glw::GL_RGBA32I, 16),
            (glw::GL_RGBA8UI, 4),
            (glw::GL_RGBA16UI, 8),
        ];
        objects.internal_formats.extend(formats);
        objects.internal_formats.insert(glw::GL_RGBA32UI, 16);

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        // SAFETY: the pointers refer to live GLuints.
        unsafe { gl.gen_textures(1, &mut objects.to_id) };
        glu::expect_no_error(gl, "Could not generate texture object!")?;

        // SAFETY: as above.
        unsafe { gl.bind_texture(tokens.texture_buffer, objects.to_id) };
        glu::expect_no_error(gl, "Could not bind texture object!")?;

        // SAFETY: as above.
        unsafe { gl.gen_buffers(1, &mut objects.tbo_id) };
        glu::expect_no_error(gl, "Could not generate buffer object!")?;

        // SAFETY: as above.
        unsafe { gl.bind_buffer(tokens.texture_buffer, objects.tbo_id) };
        glu::expect_no_error(gl, "Could not bind buffer object!")?;
        Ok(())
    }

    /// `deinit`
    fn deinit(context: &Context, base: &TestCaseBase, objects: &mut Objects) {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        // SAFETY: state resets and deletes of names this case created.
        unsafe {
            gl.bind_texture(tokens.texture_buffer, 0);
            gl.bind_buffer(tokens.texture_buffer, 0);

            if objects.to_id != 0 {
                gl.delete_textures(1, &objects.to_id);
                objects.to_id = 0;
            }
            if objects.tbo_id != 0 {
                gl.delete_buffers(1, &objects.tbo_id);
                objects.tbo_id = 0;
            }
        }
    }

    /// `queryTextureBindingBuffer` (GL_TEXTURE_BUFFER_BINDING)
    fn query_texture_binding_buffer(
        context: &Context,
        base: &TestCaseBase,
        expected: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result: GLint = -1;

        // SAFETY: the pointer refers to a live GLint.
        unsafe { gl.get_integerv(base.gl_ext_tokens.texture_buffer_binding, &mut result) };
        glu::expect_no_error(gl, "Could not query value of GL_TEXTURE_BUFFER_BINDING_EXT")?;

        if result != expected {
            log::info!(
                "glGetIntegerv(GL_TEXTURE_BINDING_BUFFER_EXT) returned {result} which is not equal to expected buffer object id == {expected}.\n"
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// `queryTextureBufferBinding` (GL_TEXTURE_BINDING_BUFFER)
    fn query_texture_buffer_binding(
        context: &Context,
        base: &TestCaseBase,
        expected: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result: GLint = -1;

        // SAFETY: the pointer refers to a live GLint.
        unsafe { gl.get_integerv(base.gl_ext_tokens.texture_binding_buffer, &mut result) };
        glu::expect_no_error(gl, "Could not query value of GL_TEXTURE_BINDING_BUFFER_EXT")?;

        if result != expected {
            log::info!(
                "glGetIntegerv(GL_TEXTURE_BUFFER_BINDING_EXT) returned {result} which is not equal to expected texture object id == {expected}.\n"
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// One `glGetTexLevelParameteriv` on level 0 of the texture buffer target compared with `expected`.
    fn query_level_parameter(
        context: &Context,
        base: &TestCaseBase,
        pname: GLenum,
        error_message: &str,
        mismatch: impl FnOnce(GLint) -> String,
        expected: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result: GLint = -1;

        // SAFETY: the pointer refers to a live GLint.
        unsafe { gl.get_tex_level_parameteriv(base.gl_ext_tokens.texture_buffer, 0, pname, &mut result) };
        glu::expect_no_error(gl, error_message)?;

        if result != expected {
            log::info!("{}", mismatch(result));
            return Ok(false);
        }
        Ok(true)
    }

    /// `queryTextureBufferDataStoreBinding`
    fn query_texture_buffer_data_store_binding(
        context: &Context,
        base: &TestCaseBase,
        expected: GLint,
    ) -> Result<bool, TestError> {
        Self::query_level_parameter(
            context,
            base,
            base.gl_ext_tokens.texture_buffer_data_store_binding,
            "Could not query value of GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT",
            |result| {
                format!(
                    "glGetTexLevelParameteriv(GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT) returned {result} which is not equal to expected buffer object id == {expected}.\n"
                )
            },
            expected,
        )
    }

    /// `queryTextureBufferOffset`
    fn query_texture_buffer_offset(context: &Context, base: &TestCaseBase, expected: GLint) -> Result<bool, TestError> {
        Self::query_level_parameter(
            context,
            base,
            base.gl_ext_tokens.texture_buffer_offset,
            "Could not query value of GL_TEXTURE_BUFFER_OFFSET_EXT",
            |result| {
                format!(
                    "glGetTexLevelParameteriv(GL_TEXTURE_BUFFER_OFFSET_EXT) returned {result} which is not equal to expected offset {expected}.\n"
                )
            },
            expected,
        )
    }

    /// `queryTextureBufferSize`
    fn query_texture_buffer_size(context: &Context, base: &TestCaseBase, expected: GLint) -> Result<bool, TestError> {
        Self::query_level_parameter(
            context,
            base,
            base.gl_ext_tokens.texture_buffer_size,
            "Could not query value of GL_TEXTURE_BUFFER_SIZE_EXT",
            |result| {
                format!(
                    "glGetTexLevelParameteriv(GL_TEXTURE_BUFFER_SIZE_EXT) returned {result} which is not equal to expected size {expected}.\n"
                )
            },
            expected,
        )
    }

    /// `queryTextureInternalFormat`
    fn query_texture_internal_format(
        context: &Context,
        base: &TestCaseBase,
        expected: GLint,
    ) -> Result<bool, TestError> {
        Self::query_level_parameter(
            context,
            base,
            glw::GL_TEXTURE_INTERNAL_FORMAT,
            "Could not query value of GL_TEXTURE_INTERNAL_FORMAT",
            |result| {
                format!(
                    "glGetTexLevelParameteriv(GL_TEXTURE_INTERNAL_FORMAT) returned {result} which is not equal to expected internal format {expected}"
                )
            },
            expected,
        )
    }

    /// `queryTextureInvalidLevel`
    fn query_texture_invalid_level(context: &Context, base: &TestCaseBase) -> bool {
        let gl = context.gl();
        let mut result: GLint = -1;

        // SAFETY: an invalid level is the point of the query; it only sets a GL error.
        unsafe {
            gl.get_tex_level_parameteriv(
                base.gl_ext_tokens.texture_buffer,
                1,
                base.gl_ext_tokens.texture_buffer_size,
                &mut result,
            )
        };
        // SAFETY: glGetError needs only a current context.
        let error_code = unsafe { gl.get_error() };

        if error_code != glw::GL_INVALID_VALUE {
            log::info!(
                "glGetTexLevelParameteriv() called for GL_TEXTURE_BUFFER_EXT texture target with lod level different than 0 did not generate an GL_INVALID_VALUE error.\n"
            );
            return false;
        }
        true
    }

    fn run(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        Self::init_test(context, base, objects)?;

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        let mut test_passed = true;

        test_passed = test_passed && Self::query_texture_buffer_binding(context, base, objects.to_id as GLint)?;
        test_passed = test_passed && Self::query_texture_binding_buffer(context, base, objects.tbo_id as GLint)?;

        for (&format, &texel_size) in &objects.internal_formats {
            let phase_one_size = (N_TEXELS_PHASE_ONE * texel_size) as usize;
            let data_phase_one = vec![0u8; phase_one_size];
            // SAFETY: the pointer covers `phase_one_size` bytes.
            unsafe {
                gl.buffer_data(
                    tokens.texture_buffer,
                    phase_one_size as GLsizeiptr,
                    data_phase_one.as_ptr().cast(),
                    glw::GL_STATIC_READ,
                )
            };
            glu::expect_no_error(gl, "Could not allocate buffer object's data store!")?;

            // SAFETY: plain state call.
            unsafe { gl.tex_buffer(tokens.texture_buffer, format, objects.tbo_id) };
            glu::expect_no_error(gl, "Could not set buffer object as data source for texture buffer!")?;

            test_passed =
                test_passed && Self::query_texture_buffer_data_store_binding(context, base, objects.tbo_id as GLint)?;
            test_passed = test_passed && Self::query_texture_internal_format(context, base, format as GLint)?;
            test_passed = test_passed && Self::query_texture_buffer_offset(context, base, 0)?;
            test_passed = test_passed && Self::query_texture_buffer_size(context, base, phase_one_size as GLint)?;
            test_passed = test_passed && Self::query_texture_invalid_level(context, base);

            let mut offset_alignment: GLint = 0;
            // SAFETY: the pointer refers to a live GLint.
            unsafe { gl.get_integerv(tokens.texture_buffer_offset_alignment, &mut offset_alignment) };
            glu::expect_no_error(gl, "Could not get texture buffer offset alignment!")?;

            let phase_two_size = (N_TEXELS_PHASE_TWO * texel_size) as usize;
            let resized = phase_two_size + offset_alignment as usize;
            let data_phase_two = vec![0u8; resized];
            // SAFETY: the pointer covers `resized` bytes.
            unsafe {
                gl.buffer_data(
                    tokens.texture_buffer,
                    resized as GLsizeiptr,
                    data_phase_two.as_ptr().cast(),
                    glw::GL_STATIC_READ,
                )
            };
            glu::expect_no_error(gl, "Could not allocate buffer object's data store!")?;

            test_passed = test_passed && Self::query_texture_buffer_offset(context, base, 0)?;
            test_passed = test_passed && Self::query_texture_buffer_size(context, base, resized as GLint)?;

            // SAFETY: plain state call.
            unsafe {
                gl.tex_buffer_range(
                    tokens.texture_buffer,
                    format,
                    objects.tbo_id,
                    offset_alignment as GLintptr,
                    phase_two_size as GLsizeiptr,
                )
            };
            glu::expect_no_error(gl, "Could not set buffer object as data source for texture buffer!")?;

            test_passed = test_passed && Self::query_texture_buffer_offset(context, base, offset_alignment)?;
            test_passed = test_passed && Self::query_texture_buffer_size(context, base, phase_two_size as GLint)?;

            // SAFETY: plain state call.
            unsafe { gl.tex_buffer(tokens.texture_buffer, format, 0) };
            glu::expect_no_error(gl, "Could not reset buffer object binding!")?;
        }

        Ok(if test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for Parameters {
    fn name(&self) -> &str {
        "texture_buffer_parameters"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects::default();

        let outcome = Self::run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);
        outcome
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferBufferParameters.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::c_void;

use super::TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLint64, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// Size of buffer object's data store: 256 texels of one byte.
const BO_SIZE: GLint = 256;

/// `TextureBufferBufferParameters`
pub(super) struct BufferParameters {
    pub(super) ext_params: ExtParameters,
}

/// The members `initTest` fills and `deinit` releases.
#[derive(Default)]
struct Objects {
    bo_id: GLuint,
}

impl BufferParameters {
    /// `deinit`
    fn deinit(context: &Context, base: &TestCaseBase, objects: &mut Objects) {
        let gl = context.gl();

        // SAFETY: state resets and deletes of names this case created; the unmap error is drained like upstream.
        unsafe {
            gl.bind_buffer(base.gl_ext_tokens.texture_buffer, 0);
            gl.unmap_buffer(base.gl_ext_tokens.texture_buffer);
            gl.get_error();

            if objects.bo_id != 0 {
                gl.delete_buffers(1, &objects.bo_id);
                objects.bo_id = 0;
            }
        }
    }

    /// `initTest`
    fn init_test(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let gl = context.gl();

        // SAFETY: the pointer refers to a live GLuint.
        unsafe { gl.gen_buffers(1, &mut objects.bo_id) };
        glu::expect_no_error(gl, "Could not generate buffer object!")?;

        // SAFETY: plain state call.
        unsafe { gl.bind_buffer(base.gl_ext_tokens.texture_buffer, objects.bo_id) };
        glu::expect_no_error(gl, "Could not bind buffer object!")?;
        Ok(())
    }

    /// `queryBufferParameteriv`
    fn query_buffer_parameteriv(
        context: &Context,
        target: GLenum,
        pname: GLenum,
        expected_data: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result: GLint = -1;

        // SAFETY: the pointer refers to a live GLint.
        unsafe { gl.get_buffer_parameteriv(target, pname, &mut result) };
        glu::expect_no_error(gl, "Could not query for value of buffer object's parameter!")?;

        if result != expected_data {
            log::info!(
                "glGetBufferParameteriv(pname == {pname}) returned {result} which is not equal to expected value {expected_data}."
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// `queryBufferParameteri64v`
    fn query_buffer_parameteri64v(
        context: &Context,
        target: GLenum,
        pname: GLenum,
        expected_data: GLint64,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result: GLint64 = -1;

        // SAFETY: the pointer refers to a live GLint64.
        unsafe { gl.get_buffer_parameteri_64v(target, pname, &mut result) };
        glu::expect_no_error(gl, "Could not query for value of buffer object's parameter!")?;

        if result != expected_data {
            log::info!(
                "glGetBufferParameteri64v(pname == {pname}) returned {result} which is not equal to expected value {expected_data}."
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// `queryBufferPointerv`
    fn query_buffer_pointerv(
        context: &Context,
        target: GLenum,
        pname: GLenum,
        expected_pointer: *mut c_void,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result_pointer: *mut c_void = std::ptr::null_mut();

        // SAFETY: the pointer refers to a live pointer variable.
        unsafe { gl.get_buffer_pointerv(target, pname, &mut result_pointer) };
        glu::expect_no_error(gl, "Could not get the mapped buffer's pointer using getBufferPointerv!")?;

        if result_pointer != expected_pointer {
            log::info!(
                "glGetBufferPointerv(pname == {pname}) returned pointer {result_pointer:?} which is not equal to expected pointer {expected_pointer:?}."
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// The `GL_BUFFER_MAP_*` queries shared by the two mapped phases of `iterate`.
    fn query_mapped_state(
        context: &Context,
        base: &TestCaseBase,
        offset: GLint,
        length: GLint,
        access_flags: GLenum,
        pointer: *mut c_void,
    ) -> Result<bool, TestError> {
        let target = base.gl_ext_tokens.texture_buffer;
        let mut test_passed = true;

        test_passed = Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_MAPPED, glw::GL_TRUE as GLint)?
            && test_passed;
        test_passed =
            Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_MAP_OFFSET, offset)? && test_passed;
        test_passed = Self::query_buffer_parameteri64v(context, target, glw::GL_BUFFER_MAP_OFFSET, offset as GLint64)?
            && test_passed;
        test_passed =
            Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_MAP_LENGTH, length)? && test_passed;
        test_passed = Self::query_buffer_parameteri64v(context, target, glw::GL_BUFFER_MAP_LENGTH, length as GLint64)?
            && test_passed;
        test_passed =
            Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_ACCESS_FLAGS, access_flags as GLint)?
                && test_passed;
        test_passed = Self::query_buffer_pointerv(context, target, glw::GL_BUFFER_MAP_POINTER, pointer)? && test_passed;
        Ok(test_passed)
    }

    fn run(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let gl = context.gl();
        let target = base.gl_ext_tokens.texture_buffer;

        Self::init_test(context, base, objects)?;

        let mut test_passed = true;

        test_passed = Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_SIZE, 0)? && test_passed;
        test_passed = Self::query_buffer_parameteri64v(context, target, glw::GL_BUFFER_SIZE, 0)? && test_passed;

        // SAFETY: a null data pointer only allocates the store.
        unsafe { gl.buffer_data(target, BO_SIZE as GLsizeiptr, std::ptr::null(), glw::GL_STATIC_READ) };
        glu::expect_no_error(gl, "Could not initialize buffer object's data store!")?;

        test_passed = Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_SIZE, BO_SIZE)? && test_passed;
        test_passed =
            Self::query_buffer_parameteri64v(context, target, glw::GL_BUFFER_SIZE, BO_SIZE as GLint64)? && test_passed;

        test_passed =
            Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_USAGE, glw::GL_STATIC_READ as GLint)?
                && test_passed;

        test_passed = Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_MAPPED, glw::GL_FALSE as GLint)?
            && test_passed;
        test_passed = Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_MAP_OFFSET, 0)? && test_passed;
        test_passed = Self::query_buffer_parameteri64v(context, target, glw::GL_BUFFER_MAP_OFFSET, 0)? && test_passed;
        test_passed = Self::query_buffer_parameteriv(context, target, glw::GL_BUFFER_MAP_LENGTH, 0)? && test_passed;
        test_passed = Self::query_buffer_parameteri64v(context, target, glw::GL_BUFFER_MAP_LENGTH, 0)? && test_passed;
        test_passed = Self::query_buffer_pointerv(context, target, glw::GL_BUFFER_MAP_POINTER, std::ptr::null_mut())?
            && test_passed;

        // SAFETY: a read mapping of the whole store just allocated.
        let buffer_pointer = unsafe { gl.map_buffer_range(target, 0, BO_SIZE as GLsizeiptr, glw::GL_MAP_READ_BIT) };
        glu::expect_no_error(
            gl,
            "Could not map buffer object's data store to client's address space!",
        )?;

        test_passed =
            Self::query_mapped_state(context, base, 0, BO_SIZE, glw::GL_MAP_READ_BIT, buffer_pointer)? && test_passed;

        // SAFETY: the buffer mapped above.
        unsafe { gl.unmap_buffer(target) };
        glu::expect_no_error(gl, "Unmapping buffer failed")?;

        // SAFETY: a write mapping of the upper half of the store.
        let buffer_pointer = unsafe {
            gl.map_buffer_range(
                target,
                (BO_SIZE / 2) as isize,
                (BO_SIZE / 2) as GLsizeiptr,
                glw::GL_MAP_WRITE_BIT,
            )
        };
        glu::expect_no_error(
            gl,
            "Could not map buffer object's data store to client's address space!",
        )?;

        test_passed = Self::query_mapped_state(
            context,
            base,
            BO_SIZE / 2,
            BO_SIZE / 2,
            glw::GL_MAP_WRITE_BIT,
            buffer_pointer,
        )? && test_passed;

        // SAFETY: the buffer mapped above.
        unsafe { gl.unmap_buffer(target) };
        glu::expect_no_error(gl, "Unmapping buffer failed")?;

        Ok(if test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for BufferParameters {
    fn name(&self) -> &str {
        "texture_buffer_buffer_parameters"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects::default();

        let outcome = Self::run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);
        outcome
    }
}

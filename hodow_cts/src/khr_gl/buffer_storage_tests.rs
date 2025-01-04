// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cBufferStorageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. All nine cases are ported (the framebuffer image upstream logs on a failing draw is not). `Texture::*` helpers are inlined for GL_TEXTURE_2D, the only target the tests use. Upstream's `Buffer`/`Buffer::MapOwner` are `Buf`/`Mapped` here (the map owner unmaps on drop); `getDirectStateAccessSupport` is decided in `check_support` (a core 4.5 context or GL_ARB_direct_state_access), which upstream reports as NotSupported from `iterate` in the tests that need it. The texture, read_pixels, dispatch and flush tests need no DSA upstream and do not check for it here either.

use std::ffi::c_void;

use super::common_bugs_tests::{Program, Shader};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestStatus};

const BUFFER_TARGETS: [glw::GLenum; 13] = [
    glw::GL_ARRAY_BUFFER,
    glw::GL_ATOMIC_COUNTER_BUFFER,
    glw::GL_COPY_READ_BUFFER,
    glw::GL_COPY_WRITE_BUFFER,
    glw::GL_DISPATCH_INDIRECT_BUFFER,
    glw::GL_DRAW_INDIRECT_BUFFER,
    glw::GL_ELEMENT_ARRAY_BUFFER,
    glw::GL_PIXEL_PACK_BUFFER,
    glw::GL_PIXEL_UNPACK_BUFFER,
    glw::GL_QUERY_BUFFER,
    glw::GL_SHADER_STORAGE_BUFFER,
    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
    glw::GL_UNIFORM_BUFFER,
];

fn buffer_target_name(target: glw::GLenum) -> &'static str {
    match target {
        glw::GL_ARRAY_BUFFER => "GL_ARRAY_BUFFER",
        glw::GL_ATOMIC_COUNTER_BUFFER => "GL_ATOMIC_COUNTER_BUFFER",
        glw::GL_COPY_READ_BUFFER => "GL_COPY_READ_BUFFER",
        glw::GL_COPY_WRITE_BUFFER => "GL_COPY_WRITE_BUFFER",
        glw::GL_DISPATCH_INDIRECT_BUFFER => "GL_DISPATCH_INDIRECT_BUFFER",
        glw::GL_DRAW_INDIRECT_BUFFER => "GL_DRAW_INDIRECT_BUFFER",
        glw::GL_ELEMENT_ARRAY_BUFFER => "GL_ELEMENT_ARRAY_BUFFER",
        glw::GL_PIXEL_PACK_BUFFER => "GL_PIXEL_PACK_BUFFER",
        glw::GL_PIXEL_UNPACK_BUFFER => "GL_PIXEL_UNPACK_BUFFER",
        glw::GL_QUERY_BUFFER => "GL_QUERY_BUFFER",
        glw::GL_SHADER_STORAGE_BUFFER => "GL_SHADER_STORAGE_BUFFER",
        glw::GL_TRANSFORM_FEEDBACK_BUFFER => "GL_TRANSFORM_FEEDBACK_BUFFER",
        glw::GL_UNIFORM_BUFFER => "GL_UNIFORM_BUFFER",
        _ => "unknown target",
    }
}

/// `getDirectStateAccessSupport` is not NONE
fn direct_state_access_supported(context: &Context) -> bool {
    context.context_type().supports_core(4, 5)
        || context
            .context_info
            .is_extension_supported("GL_ARB_direct_state_access")
}

fn check_direct_state_access(context: &Context) -> Result<(), TestError> {
    if direct_state_access_supported(context) {
        Ok(())
    } else {
        Err(TestError::NotSupported("Unsupported".to_string()))
    }
}

/// `Buffer`
struct Buf<'gl> {
    gl: &'gl glw::Functions,
    id: glw::GLuint,
    target: glw::GLenum,
}

impl<'gl> Buf<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        Self {
            gl,
            id: 0,
            target: glw::GL_ARRAY_BUFFER,
        }
    }

    /// `Buffer::InitStorage`
    fn init_storage(
        &mut self,
        target: glw::GLenum,
        flags: glw::GLbitfield,
        size: glw::GLsizeiptr,
        data: *const c_void,
    ) -> Result<(), TestError> {
        self.release();
        self.target = target;
        // SAFETY: one name is written to the live field.
        unsafe { self.gl.gen_buffers(1, &mut self.id) };
        glu::expect_no_error(self.gl, "GenBuffers")?;
        bind(self.gl, self.id, target)?;
        // SAFETY: `data` is null or holds `size` bytes, as every caller passes.
        unsafe { self.gl.buffer_storage(target, size, data, flags) };
        glu::expect_no_error(self.gl, "BufferStorage")
    }

    fn release(&mut self) {
        if self.id != 0 {
            // SAFETY: deletes the name this guard owns.
            unsafe { self.gl.delete_buffers(1, &self.id) };
            self.id = 0;
        }
    }

    /// `Buffer::Bind()`
    fn bind(&self) -> Result<(), TestError> {
        bind(self.gl, self.id, self.target)
    }

    /// `Buffer::MapRange`: binds, maps, and hands the mapping to a `Mapped` that unmaps it.
    fn map_range(
        &self,
        offset: glw::GLintptr,
        length: glw::GLsizeiptr,
        access: glw::GLbitfield,
    ) -> Result<Mapped<'_, 'gl>, TestError> {
        self.bind()?;
        // SAFETY: a mapping request; the result is only dereferenced through `Mapped`.
        let data = unsafe { self.gl.map_buffer_range(self.target, offset, length, access) };
        glu::expect_no_error(self.gl, "MapBufferRange")?;
        Ok(Mapped { buffer: self, data })
    }
}

impl Drop for Buf<'_> {
    fn drop(&mut self) {
        self.release();
    }
}

/// `Buffer::MapOwner`
struct Mapped<'a, 'gl> {
    buffer: &'a Buf<'gl>,
    data: *mut c_void,
}

impl Mapped<'_, '_> {
    fn bytes(&self, len: usize) -> &[u8] {
        // SAFETY: the mapping holds at least `len` bytes (every caller maps that many) and lives until `self` is dropped.
        unsafe { std::slice::from_raw_parts(self.data.cast::<u8>(), len) }
    }
}

impl Drop for Mapped<'_, '_> {
    fn drop(&mut self) {
        // Upstream's destructor has no error check either.
        let _ = self.buffer.bind();
        // SAFETY: the buffer is mapped by this guard.
        unsafe { self.buffer.gl.unmap_buffer(self.buffer.target) };
    }
}

/// `Buffer::Bind(gl, id, target)`
fn bind(gl: &glw::Functions, id: glw::GLuint, target: glw::GLenum) -> Result<(), TestError> {
    // SAFETY: plain state change.
    unsafe { gl.bind_buffer(target, id) };
    glu::expect_no_error(gl, "BindBuffer")
}

/// `Buffer::GetSubData`
fn get_sub_data(
    gl: &glw::Functions,
    target: glw::GLenum,
    offset: glw::GLintptr,
    data: &mut [u8],
) -> Result<(), TestError> {
    // SAFETY: `data` holds `data.len()` bytes.
    unsafe { gl.get_buffer_sub_data(target, offset, data.len() as glw::GLsizeiptr, data.as_mut_ptr().cast()) };
    glu::expect_no_error(gl, "GetBufferSubData")
}

fn verdict(result: bool) -> TestOutcome {
    Ok(if result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `ErrorsTest::verifyError`
fn verify_error(gl: &glw::Functions, expected_error: glw::GLenum, error_message: &str, out_test_result: &mut bool) {
    // SAFETY: plain state query.
    let error = unsafe { gl.get_error() };
    if error != expected_error {
        *out_test_result = false;
        log::info!(
            "Got invalid error: {}, expected: {}. Message: {error_message}",
            glw::error_name(error),
            glw::error_name(expected_error)
        );
    }
}

/// `ErrorsTest`
struct ErrorsTest;

impl TestCase for ErrorsTest {
    fn name(&self) -> &str {
        "errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_direct_state_access(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const DATA_SIZE: glw::GLsizeiptr = 32;
        let gl = context.gl();
        let mut test_result = true;
        let data = [0u8; DATA_SIZE as usize];
        let data_ptr: *const c_void = data.as_ptr().cast();
        let named_buffer_storage = gl.named_buffer_storage.is_some();
        let named_buffer_sub_data = gl.named_buffer_sub_data.is_some();
        let map_named_buffer_range = gl.map_named_buffer_range.is_some();

        // SAFETY: every GL call below passes null or `data_ptr` (DATA_SIZE bytes) and ids of live buffers; the outcome is what the test checks.
        unsafe {
            // INVALID_OPERATION is generated by BufferStorage when 0 is bound to <target>.
            for target in BUFFER_TARGETS {
                let message = format!(
                    "BufferStorage was executed for id 0, target: {}",
                    buffer_target_name(target)
                );
                bind(gl, 0, target)?;
                gl.buffer_storage(target, 0, std::ptr::null(), glw::GL_DYNAMIC_STORAGE_BIT);
                verify_error(gl, glw::GL_INVALID_OPERATION, &message, &mut test_result);
            }

            // INVALID_OPERATION is generated by BufferStorage, NamedBufferStorage and BufferData if buffer already has immutable store.
            {
                let mut buffer = Buf::new(gl);
                buffer.init_storage(glw::GL_ARRAY_BUFFER, glw::GL_DYNAMIC_STORAGE_BIT, DATA_SIZE, data_ptr)?;

                if named_buffer_storage {
                    gl.named_buffer_storage(buffer.id, DATA_SIZE, data_ptr, glw::GL_DYNAMIC_STORAGE_BIT);
                    verify_error(
                        gl,
                        glw::GL_INVALID_OPERATION,
                        "NamedBufferStorage was executed for id with immutable storage",
                        &mut test_result,
                    );
                }

                bind(gl, buffer.id, glw::GL_ARRAY_BUFFER)?;
                gl.buffer_storage(glw::GL_ARRAY_BUFFER, DATA_SIZE, data_ptr, glw::GL_DYNAMIC_STORAGE_BIT);
                verify_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "BufferStorage was executed for target with immutable storage",
                    &mut test_result,
                );
                bind(gl, 0, glw::GL_ARRAY_BUFFER)?;
            }

            // INVALID_VALUE is generated by BufferStorage and NamedBufferStorage when <size> is less or equal to zero.
            {
                let mut buffer = Buf::new(gl);
                gl.create_buffers(1, &mut buffer.id);

                if named_buffer_storage {
                    gl.named_buffer_storage(buffer.id, 0, data_ptr, glw::GL_DYNAMIC_STORAGE_BIT);
                    verify_error(
                        gl,
                        glw::GL_INVALID_VALUE,
                        "NamedBufferStorage was executed with size == 0",
                        &mut test_result,
                    );
                    gl.named_buffer_storage(buffer.id, -16, data_ptr, glw::GL_DYNAMIC_STORAGE_BIT);
                    verify_error(
                        gl,
                        glw::GL_INVALID_VALUE,
                        "NamedBufferStorage was executed with size == -16",
                        &mut test_result,
                    );
                }

                bind(gl, buffer.id, glw::GL_ARRAY_BUFFER)?;
                gl.buffer_storage(glw::GL_ARRAY_BUFFER, 0, data_ptr, glw::GL_DYNAMIC_STORAGE_BIT);
                verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "BufferStorage was executed with size == 0",
                    &mut test_result,
                );
                gl.buffer_storage(glw::GL_ARRAY_BUFFER, -16, data_ptr, glw::GL_DYNAMIC_STORAGE_BIT);
                verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "BufferStorage was executed with size == -16",
                    &mut test_result,
                );
                bind(gl, 0, glw::GL_ARRAY_BUFFER)?;
            }

            // INVALID_VALUE is generated by BufferStorage and NamedBufferStorage when <flags> contains MAP_PERSISTENT_BIT and neither MAP_READ_BIT nor MAP_WRITE_BIT.
            {
                let mut buffer = Buf::new(gl);
                gl.create_buffers(1, &mut buffer.id);

                if named_buffer_storage {
                    gl.named_buffer_storage(buffer.id, DATA_SIZE, data_ptr, glw::GL_MAP_PERSISTENT_BIT);
                    verify_error(
                        gl,
                        glw::GL_INVALID_VALUE,
                        "NamedBufferStorage was executed with flags == GL_MAP_PERSISTENT_BIT",
                        &mut test_result,
                    );
                }

                bind(gl, buffer.id, glw::GL_ARRAY_BUFFER)?;
                gl.buffer_storage(glw::GL_ARRAY_BUFFER, DATA_SIZE, data_ptr, glw::GL_MAP_PERSISTENT_BIT);
                verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "BufferStorage was executed with flags == GL_MAP_PERSISTENT_BIT",
                    &mut test_result,
                );
                bind(gl, 0, glw::GL_ARRAY_BUFFER)?;
            }

            // INVALID_VALUE is generated by BufferStorage and NamedBufferStorage when <flags> contains MAP_COHERENT_BIT and no MAP_PERSISTENT_BIT.
            {
                let mut buffer = Buf::new(gl);
                gl.create_buffers(1, &mut buffer.id);

                if named_buffer_storage {
                    gl.named_buffer_storage(buffer.id, DATA_SIZE, data_ptr, glw::GL_MAP_COHERENT_BIT);
                    verify_error(
                        gl,
                        glw::GL_INVALID_VALUE,
                        "NamedBufferStorage was executed with flags == GL_MAP_COHERENT_BIT",
                        &mut test_result,
                    );
                }

                bind(gl, buffer.id, glw::GL_ARRAY_BUFFER)?;
                gl.buffer_storage(glw::GL_ARRAY_BUFFER, DATA_SIZE, data_ptr, glw::GL_MAP_COHERENT_BIT);
                verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "BufferStorage was executed with flags == GL_MAP_COHERENT_BIT",
                    &mut test_result,
                );
                bind(gl, 0, glw::GL_ARRAY_BUFFER)?;
            }

            // INVALID_OPERATION is generated by MapBufferRange if any of MAP_COHERENT_BIT, MAP_PERSISTENT_BIT, MAP_READ_BIT, MAP_WRITE_BIT is included in <access> and not in buffer's storage flags.
            {
                let mut buffer = Buf::new(gl);
                buffer.init_storage(glw::GL_ARRAY_BUFFER, glw::GL_DYNAMIC_STORAGE_BIT, DATA_SIZE, data_ptr)?;

                let accesses = [
                    (glw::GL_MAP_READ_BIT, "GL_MAP_READ_BIT"),
                    (glw::GL_MAP_WRITE_BIT, "GL_MAP_WRITE_BIT"),
                    (glw::GL_MAP_PERSISTENT_BIT, "GL_MAP_PERSISTENT_BIT"),
                    (glw::GL_MAP_COHERENT_BIT, "GL_MAP_COHERENT_BIT"),
                ];

                if map_named_buffer_range {
                    for (access, name) in accesses {
                        gl.map_named_buffer_range(buffer.id, 0, DATA_SIZE, access);
                        verify_error(
                            gl,
                            glw::GL_INVALID_OPERATION,
                            &format!(
                                "MapNamedBufferRange was executed with access == {name}, storage flags == GL_DYNAMIC_STORAGE_BIT"
                            ),
                            &mut test_result,
                        );
                    }
                }

                bind(gl, buffer.id, glw::GL_ARRAY_BUFFER)?;
                for (access, name) in accesses {
                    gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, DATA_SIZE, access);
                    verify_error(
                        gl,
                        glw::GL_INVALID_OPERATION,
                        &format!(
                            "MapBufferRange was executed with access == {name}, storage flags == GL_DYNAMIC_STORAGE_BIT"
                        ),
                        &mut test_result,
                    );
                }
                bind(gl, 0, glw::GL_ARRAY_BUFFER)?;
            }

            // INVALID_OPERATION is generated by BufferSubData and NamedBufferSubData when buffer has immutable store but its flags does not include DYNAMIC_STORAGE.
            {
                let mut buffer = Buf::new(gl);
                buffer.init_storage(
                    glw::GL_ARRAY_BUFFER,
                    glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT | glw::GL_MAP_PERSISTENT_BIT,
                    DATA_SIZE,
                    data_ptr,
                )?;

                if named_buffer_sub_data {
                    gl.named_buffer_sub_data(buffer.id, 0, DATA_SIZE, data_ptr);
                    verify_error(
                        gl,
                        glw::GL_INVALID_OPERATION,
                        "NamedBufferSubData was executed for storage without GL_DYNAMIC_STORAGE_BIT",
                        &mut test_result,
                    );
                }

                bind(gl, buffer.id, glw::GL_ARRAY_BUFFER)?;
                gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 0, DATA_SIZE, data_ptr);
                verify_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "BufferSubData was executed for storage without GL_DYNAMIC_STORAGE_BIT",
                    &mut test_result,
                );
                bind(gl, 0, glw::GL_ARRAY_BUFFER)?;
            }
        }

        verdict(test_result)
    }
}

/// `GetBufferParameterTest::testCase`
struct ParameterCase {
    flags: glw::GLenum,
    access: glw::GLenum,
}

/// `GetBufferParameterTest::GetBufferParameterTest` builds these.
fn parameter_cases() -> Vec<ParameterCase> {
    const MAPPING_BITS: [glw::GLenum; 3] = [
        0,
        glw::GL_MAP_PERSISTENT_BIT,
        glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT,
    ];
    let mut cases = Vec::new();
    let mut flags: glw::GLenum;

    for dynamic in 0..2 {
        flags = if dynamic == 0 { 0 } else { glw::GL_DYNAMIC_STORAGE_BIT };

        for client in 0..2 {
            flags |= if client == 0 { 0 } else { glw::GL_CLIENT_STORAGE_BIT };

            if flags != 0 {
                cases.push(ParameterCase { flags, access: 0 });
            }

            for (flag_idx, flag_mapping_bits) in MAPPING_BITS.iter().enumerate() {
                let flags_with_mapping = flags | flag_mapping_bits;

                for access in &MAPPING_BITS[..=flag_idx] {
                    let access = *access;
                    cases.push(ParameterCase {
                        flags: flags_with_mapping | glw::GL_MAP_READ_BIT,
                        access: access | glw::GL_MAP_READ_BIT,
                    });
                    cases.push(ParameterCase {
                        flags: flags_with_mapping | glw::GL_MAP_WRITE_BIT,
                        access: access | glw::GL_MAP_WRITE_BIT,
                    });
                    cases.push(ParameterCase {
                        flags: flags_with_mapping | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
                        access: access | glw::GL_MAP_READ_BIT,
                    });
                    cases.push(ParameterCase {
                        flags: flags_with_mapping | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
                        access: access | glw::GL_MAP_WRITE_BIT,
                    });
                    cases.push(ParameterCase {
                        flags: flags_with_mapping | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
                        access: access | glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT,
                    });
                }
            }
        }
    }
    cases
}

/// `GetBufferParameterTest`
struct GetBufferParameterTest;

impl TestCase for GetBufferParameterTest {
    fn name(&self) -> &str {
        "get_buffer_parameter"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_direct_state_access(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const DATA_SIZE: glw::GLsizeiptr = 32;
        let gl = context.gl();
        let data = [0u8; DATA_SIZE as usize];
        let mut test_result = true;
        let named_query = gl.get_named_buffer_parameteriv.is_some();

        let get_named = |buffer: glw::GLuint, pname: glw::GLenum, out: &mut glw::GLint| -> Result<(), TestError> {
            // SAFETY: the value is written to a live local.
            unsafe { gl.get_named_buffer_parameteriv(buffer, pname, out) };
            glu::expect_no_error(gl, "GetNameBufferParameteriv")
        };
        let get = |pname: glw::GLenum, out: &mut glw::GLint| -> Result<(), TestError> {
            // SAFETY: the value is written to a live local.
            unsafe { gl.get_buffer_parameteriv(glw::GL_ARRAY_BUFFER, pname, out) };
            glu::expect_no_error(gl, "GetBufferParameteriv")
        };

        for test_case in parameter_cases() {
            let access = test_case.access;
            let flags = test_case.flags;

            let mut queried_flags: glw::GLint = -1;
            let mut queried_immutable: glw::GLint = -1;
            let mut queried_size: glw::GLint = -1;

            let mut buffer = Buf::new(gl);
            buffer.init_storage(glw::GL_ARRAY_BUFFER, flags, DATA_SIZE, data.as_ptr().cast())?;
            bind(gl, buffer.id, glw::GL_ARRAY_BUFFER)?;

            if named_query {
                get_named(buffer.id, glw::GL_BUFFER_STORAGE_FLAGS, &mut queried_flags)?;
                get_named(buffer.id, glw::GL_BUFFER_IMMUTABLE_STORAGE, &mut queried_immutable)?;
                get_named(buffer.id, glw::GL_BUFFER_SIZE, &mut queried_size)?;

                if queried_flags != flags as glw::GLint {
                    test_result = false;
                    log::info!(
                        "GetNamedBufferParameteriv reported invalid state of GL_BUFFER_STORAGE_FLAGS: {queried_flags} expected: {flags}"
                    );
                }
            }

            if queried_flags != flags as glw::GLint {
                test_result = false;
                log::info!(
                    "GetNamedBufferParameteriv reported invalid state of GL_BUFFER_STORAGE_FLAGS: {queried_flags} expected: {flags}"
                );
            }
            if queried_immutable != glw::GL_TRUE as glw::GLint {
                test_result = false;
                log::info!(
                    "GetNamedBufferParameteriv reported invalid state of GL_BUFFER_IMMUTABLE_STORAGE: {queried_immutable} expected: {}",
                    glw::GL_TRUE
                );
            }
            if queried_size as glw::GLsizeiptr != DATA_SIZE {
                test_result = false;
                log::info!(
                    "GetNamedBufferParameteriv reported invalid state of GL_BUFFER_SIZE: {queried_size} expected: {DATA_SIZE}"
                );
            }

            queried_flags = -1;
            queried_immutable = -1;
            queried_size = -1;

            get(glw::GL_BUFFER_STORAGE_FLAGS, &mut queried_flags)?;
            get(glw::GL_BUFFER_IMMUTABLE_STORAGE, &mut queried_immutable)?;
            get(glw::GL_BUFFER_SIZE, &mut queried_size)?;

            if queried_flags != flags as glw::GLint {
                test_result = false;
                log::info!(
                    "GetBufferParameteriv reported invalid state of GL_BUFFER_STORAGE_FLAGS: {queried_flags} expected: {flags}"
                );
            }
            if queried_immutable != glw::GL_TRUE as glw::GLint {
                test_result = false;
                log::info!(
                    "GetBufferParameteriv reported invalid state of GL_BUFFER_IMMUTABLE_STORAGE: {queried_immutable} expected: {}",
                    glw::GL_TRUE
                );
            }
            if queried_size as glw::GLsizeiptr != DATA_SIZE {
                test_result = false;
                log::info!(
                    "GetBufferParameteriv reported invalid state of GL_BUFFER_SIZE: {queried_size} expected: {DATA_SIZE}"
                );
            }

            if access != 0 {
                let mut queried_access: glw::GLint = -1;
                let _map = buffer.map_range(0, DATA_SIZE, access)?;

                if named_query {
                    get_named(buffer.id, glw::GL_BUFFER_ACCESS_FLAGS, &mut queried_access)?;
                }
                if queried_access != access as glw::GLint {
                    test_result = false;
                    log::info!(
                        "GetNamedBufferParameteriv reported invalid state of GL_BUFFER_ACCESS_FLAGS: {queried_access} expected: {access}"
                    );
                }

                queried_access = -1;
                get(glw::GL_BUFFER_ACCESS_FLAGS, &mut queried_access)?;
                if queried_access != access as glw::GLint {
                    test_result = false;
                    log::info!(
                        "GetBufferParameteriv reported invalid state of GL_BUFFER_ACCESS_FLAGS: {queried_access} expected: {access}"
                    );
                }
            }

            bind(gl, 0, glw::GL_ARRAY_BUFFER)?;
        }

        verdict(test_result)
    }
}

/// `DynamicStorageTest`
struct DynamicStorageTest;

impl TestCase for DynamicStorageTest {
    fn name(&self) -> &str {
        "dynamic_storage"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const DATA_SIZE: usize = 64;
        let gl = context.gl();
        let mut test_result = true;
        let size = DATA_SIZE as glw::GLsizeiptr;

        // Without DYNAMIC_STORAGE_BIT BufferSubData must fail and CopyBufferSubData must work.
        {
            let read_data = [1u8; DATA_SIZE];
            let mut temp_data = [0u8; DATA_SIZE];
            let update_data = [3u8; DATA_SIZE];
            let write_data = [2u8; DATA_SIZE];

            let mut read_buffer = Buf::new(gl);
            let mut write_buffer = Buf::new(gl);
            read_buffer.init_storage(glw::GL_COPY_READ_BUFFER, 0, size, read_data.as_ptr().cast())?;
            write_buffer.init_storage(glw::GL_COPY_WRITE_BUFFER, 0, size, write_data.as_ptr().cast())?;

            write_buffer.bind()?;
            // SAFETY: `update_data` holds DATA_SIZE bytes.
            unsafe { gl.buffer_sub_data(glw::GL_COPY_WRITE_BUFFER, 0, size, update_data.as_ptr().cast()) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_INVALID_OPERATION {
                test_result = false;
                log::info!(
                    "Invalid error was generated. BufferSubData was executed on store without DYNAMIC_STORAGE_BIT. Expected INVALID_OPERATION, got: {}",
                    glw::error_name(error)
                );
            }

            get_sub_data(gl, glw::GL_COPY_WRITE_BUFFER, 0, &mut temp_data)?;
            if temp_data != write_data {
                test_result = false;
                log::info!("BufferSubData modified contents of store without DYNAMIC_STORAGE_BIT.");
            }

            read_buffer.bind()?;
            // SAFETY: both buffers hold DATA_SIZE bytes.
            unsafe { gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, size) };
            glu::expect_no_error(gl, "CopyBufferSubData")?;

            get_sub_data(gl, glw::GL_COPY_WRITE_BUFFER, 0, &mut temp_data)?;
            if temp_data != read_data {
                test_result = false;
                log::info!("CopyBufferSubData stored invalid contents in write target buffer.");
            }
        }

        // With DYNAMIC_STORAGE_BIT BufferSubData must work.
        {
            let mut temp_data = [0u8; DATA_SIZE];
            let update_data = [3u8; DATA_SIZE];
            let write_data = [2u8; DATA_SIZE];

            let mut write_buffer = Buf::new(gl);
            write_buffer.init_storage(
                glw::GL_COPY_WRITE_BUFFER,
                glw::GL_DYNAMIC_STORAGE_BIT,
                size,
                write_data.as_ptr().cast(),
            )?;

            write_buffer.bind()?;
            // SAFETY: `update_data` holds DATA_SIZE bytes.
            unsafe { gl.buffer_sub_data(glw::GL_COPY_WRITE_BUFFER, 0, size, update_data.as_ptr().cast()) };
            glu::expect_no_error(gl, "BufferSubData")?;

            get_sub_data(gl, glw::GL_COPY_WRITE_BUFFER, 0, &mut temp_data)?;
            if temp_data != update_data {
                test_result = false;
                log::info!("BufferSubData stored invalid contents in write target buffer.");
            }
        }

        verdict(test_result)
    }
}

/// `MapPersistentBufferSubDataTest::testCase`
struct SubDataCase {
    offset: glw::GLintptr,
    size: glw::GLsizeiptr,
    cross_mapped_region: bool,
}

/// `MapPersistentBufferSubDataTest`
struct MapPersistentBufferSubDataTest;

impl TestCase for MapPersistentBufferSubDataTest {
    fn name(&self) -> &str {
        "map_persistent_buffer_sub_data"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_direct_state_access(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const DATA_SIZE: usize = 64;
        const MAPPED_REGION_OFFSET: glw::GLintptr = 16;
        const MAPPED_REGION_SIZE: glw::GLsizeiptr = 16;
        const TEST_CASES: [SubDataCase; 5] = [
            SubDataCase {
                offset: 0,
                size: 16,
                cross_mapped_region: false,
            },
            SubDataCase {
                offset: 32,
                size: 16,
                cross_mapped_region: false,
            },
            SubDataCase {
                offset: 8,
                size: 16,
                cross_mapped_region: true,
            },
            SubDataCase {
                offset: 24,
                size: 16,
                cross_mapped_region: true,
            },
            SubDataCase {
                offset: 12,
                size: 8,
                cross_mapped_region: true,
            },
        ];
        let gl = context.gl();
        let mut test_result = true;
        let size = DATA_SIZE as glw::GLsizeiptr;

        let mut incrementing_data = [0u8; DATA_SIZE];
        for (i, value) in incrementing_data.iter_mut().enumerate() {
            *value = i as u8;
        }
        let data_ptr: *const c_void = incrementing_data.as_ptr().cast();

        let mut buffer = Buf::new(gl);
        buffer.init_storage(
            glw::GL_ARRAY_BUFFER,
            glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            size,
            std::ptr::null(),
        )?;
        buffer.bind()?;

        let named_buffer_sub_data = gl.named_buffer_sub_data.is_some();
        // SAFETY: every buffer_sub_data/named_buffer_sub_data call below passes `data_ptr` with a size of at most DATA_SIZE bytes.
        let sub_data = |offset: glw::GLintptr, size: glw::GLsizeiptr| unsafe {
            gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, offset, size, data_ptr);
            gl.get_error()
        };
        // SAFETY: as above.
        let named_sub_data = |offset: glw::GLintptr, size: glw::GLsizeiptr| unsafe {
            gl.named_buffer_sub_data(buffer.id, offset, size, data_ptr);
            gl.get_error()
        };

        // Updating the whole buffer must not generate an error.
        let error = sub_data(0, size);
        if error != glw::GL_NO_ERROR {
            test_result = false;
            log::info!("BufferSubData generated unexpected error: {}", glw::error_name(error));
        }

        // Upstream calls the named variant here unconditionally.
        let error = named_sub_data(0, size);
        if error != glw::GL_NO_ERROR {
            test_result = false;
            log::info!(
                "NamedBufferSubData generated unexpected error: {}",
                glw::error_name(error)
            );
        }

        // A persistent mapping: the operations must not generate errors.
        {
            let map = buffer.map_range(
                MAPPED_REGION_OFFSET,
                MAPPED_REGION_SIZE,
                glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            )?;
            if map.bytes(MAPPED_REGION_SIZE as usize)
                != &incrementing_data
                    [MAPPED_REGION_OFFSET as usize..(MAPPED_REGION_OFFSET + MAPPED_REGION_SIZE) as usize]
            {
                test_result = false;
                log::info!("Mapped region contains unexpected data");
            }

            for test_case in &TEST_CASES {
                let mut error = sub_data(test_case.offset, test_case.size);
                if error != glw::GL_NO_ERROR {
                    test_result = false;
                    log::info!("BufferSubData generated unexpected error: {}", glw::error_name(error));
                }

                if named_buffer_sub_data {
                    error = named_sub_data(test_case.offset, test_case.size);
                }
                if error != glw::GL_NO_ERROR {
                    test_result = false;
                    log::info!(
                        "NamedBufferSubData generated unexpected error: {}",
                        glw::error_name(error)
                    );
                }
            }
        }

        // A non-persistent mapping: operations crossing the mapped region must generate INVALID_OPERATION.
        {
            let _map = buffer.map_range(
                MAPPED_REGION_OFFSET,
                MAPPED_REGION_SIZE,
                glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            )?;

            for test_case in &TEST_CASES {
                let expected_error = if test_case.cross_mapped_region {
                    glw::GL_INVALID_OPERATION
                } else {
                    glw::GL_NO_ERROR
                };

                let mut error = sub_data(test_case.offset, test_case.size);
                if expected_error != error {
                    test_result = false;
                    log::info!(
                        "BufferSubData generated wrong error: {}, expected: {}. Mapped region: offset: {MAPPED_REGION_OFFSET}, size: {MAPPED_REGION_SIZE}. Operation region: offset: {}, size: {}",
                        glw::error_name(error),
                        glw::error_name(expected_error),
                        test_case.offset,
                        test_case.size
                    );
                }

                if named_buffer_sub_data {
                    error = named_sub_data(test_case.offset, test_case.size);
                }
                if expected_error != error {
                    test_result = false;
                    log::info!(
                        "NamedBufferSubData generated wrong error: {}, expected: {}. Mapped region: offset: {MAPPED_REGION_OFFSET}, size: {MAPPED_REGION_SIZE}. Operation region: offset: {}, size: {}",
                        glw::error_name(error),
                        glw::error_name(expected_error),
                        test_case.offset,
                        test_case.size
                    );
                }
            }
        }

        verdict(test_result)
    }
}

/// A texture name deleted on drop (`Texture`).
struct Tex<'gl> {
    gl: &'gl glw::Functions,
    id: glw::GLuint,
}

impl<'gl> Tex<'gl> {
    /// `Texture::Generate` followed by `Texture::Bind(GL_TEXTURE_2D)`
    fn new_2d(gl: &'gl glw::Functions) -> Result<Self, TestError> {
        let mut id = 0;
        // SAFETY: one name is written to the live local.
        unsafe { gl.gen_textures(1, &mut id) };
        glu::expect_no_error(gl, "GenTextures")?;
        let tex = Self { gl, id };
        // SAFETY: a texture name generated above.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, id) };
        glu::expect_no_error(gl, "BindTexture")?;
        Ok(tex)
    }
}

impl Drop for Tex<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes the name this guard owns.
        unsafe { self.gl.delete_textures(1, &self.id) };
    }
}

/// `MapPersistentTextureTest::TESTED_OPERATION`
#[derive(Clone, Copy)]
enum TestedOperation {
    CompressedTexImage,
    CompressedTexSubImage,
    CompressedTextureSubImage,
    TexImage,
    TexSubImage,
}

impl TestedOperation {
    const ALL: [TestedOperation; 5] = [
        TestedOperation::CompressedTexImage,
        TestedOperation::CompressedTexSubImage,
        TestedOperation::CompressedTextureSubImage,
        TestedOperation::TexImage,
        TestedOperation::TexSubImage,
    ];

    /// `getOperationName`
    fn name(self) -> &'static str {
        match self {
            TestedOperation::CompressedTexImage => "CompressedTexImage",
            TestedOperation::CompressedTexSubImage => "CompressedTexSubImage",
            TestedOperation::CompressedTextureSubImage => "CompressedTextureSubImage",
            TestedOperation::TexImage => "TexImage",
            TestedOperation::TexSubImage => "TexSubImage",
        }
    }
}

/// `MapPersistentTextureTest::m_compressed_image_size` and `m_compressed_internal_format`
struct CompressedInfo {
    image_size: glw::GLint,
    internal_format: glw::GLint,
}

/// `MapPersistentTextureTest::getCompressedInfo`
fn get_compressed_info(gl: &glw::Functions) -> Result<CompressedInfo, TestError> {
    let _texture = Tex::new_2d(gl)?;
    // SAFETY: an empty image, glspec 4.5 pg 216.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RED_RGTC1 as glw::GLint,
            8,
            8,
            0,
            glw::GL_RED,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    glu::expect_no_error(gl, "TexImage2D")?;

    let mut info = CompressedInfo {
        image_size: 0,
        internal_format: 0,
    };
    // SAFETY: each value is written to a live field.
    unsafe {
        gl.get_tex_level_parameteriv(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_TEXTURE_COMPRESSED_IMAGE_SIZE,
            &mut info.image_size,
        );
        glu::expect_no_error(gl, "GetTexLevelParameteriv")?;
        gl.get_tex_level_parameteriv(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_TEXTURE_INTERNAL_FORMAT,
            &mut info.internal_format,
        );
    }
    glu::expect_no_error(gl, "GetTexLevelParameteriv")?;
    Ok(info)
}

/// `MapPersistentTextureTest::verifyTestedOperation`
fn verify_tested_operation(
    gl: &glw::Functions,
    info: &CompressedInfo,
    operation: TestedOperation,
    buffer: &Buf,
    expected_error: glw::GLenum,
) -> Result<bool, TestError> {
    let texture = Tex::new_2d(gl)?;
    let internal_format = info.internal_format as glw::GLenum;

    // SAFETY: images are empty (a null pointer is an offset into the bound unpack buffer, or no data when none is bound).
    unsafe {
        match operation {
            TestedOperation::CompressedTexImage | TestedOperation::TexImage => {}
            TestedOperation::CompressedTexSubImage | TestedOperation::CompressedTextureSubImage => {
                gl.compressed_tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    internal_format,
                    8,
                    8,
                    0,
                    info.image_size,
                    std::ptr::null(),
                );
                glu::expect_no_error(gl, "CompressedTexImage2D")?;
            }
            TestedOperation::TexSubImage => {
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_R8 as glw::GLint,
                    8,
                    8,
                    0,
                    glw::GL_RED,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
                glu::expect_no_error(gl, "TexImage2D")?;
            }
        }
    }

    bind(gl, buffer.id, glw::GL_PIXEL_UNPACK_BUFFER)?;

    // SAFETY: as above.
    let error = unsafe {
        match operation {
            TestedOperation::CompressedTexImage => {
                gl.compressed_tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    internal_format,
                    8,
                    8,
                    0,
                    info.image_size,
                    std::ptr::null(),
                );
                gl.get_error()
            }
            TestedOperation::CompressedTexSubImage => {
                gl.compressed_tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    8,
                    8,
                    internal_format,
                    info.image_size,
                    std::ptr::null(),
                );
                gl.get_error()
            }
            TestedOperation::CompressedTextureSubImage => {
                if gl.compressed_texture_sub_image_2d.is_some() {
                    gl.compressed_texture_sub_image_2d(
                        texture.id,
                        0,
                        0,
                        0,
                        8,
                        8,
                        internal_format,
                        info.image_size,
                        std::ptr::null(),
                    );
                    gl.get_error()
                } else {
                    expected_error
                }
            }
            TestedOperation::TexImage => {
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_R8 as glw::GLint,
                    8,
                    8,
                    0,
                    glw::GL_RED,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
                gl.get_error()
            }
            TestedOperation::TexSubImage => {
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    8,
                    8,
                    glw::GL_RED,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
                gl.get_error()
            }
        }
    };

    bind(gl, 0, glw::GL_PIXEL_UNPACK_BUFFER)?;

    if expected_error != error {
        log::info!(
            "{} generated wrong error: {}, expected: {}",
            operation.name(),
            glw::error_name(error),
            glw::error_name(expected_error)
        );
        return Ok(false);
    }
    Ok(true)
}

/// `MapPersistentTextureTest`
struct MapPersistentTextureTest;

impl TestCase for MapPersistentTextureTest {
    fn name(&self) -> &str {
        "map_persistent_texture"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const DATA_SIZE: usize = 256;
        let gl = context.gl();
        let mut test_result = true;

        let mut data = [0u8; DATA_SIZE];
        for (i, value) in data.iter_mut().enumerate() {
            *value = i as u8;
        }

        let info = get_compressed_info(gl)?;

        let mut buffer = Buf::new(gl);
        buffer.init_storage(
            glw::GL_PIXEL_UNPACK_BUFFER,
            glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            DATA_SIZE as glw::GLsizeiptr,
            data.as_ptr().cast(),
        )?;
        bind(gl, 0, glw::GL_PIXEL_UNPACK_BUFFER)?;

        for operation in TestedOperation::ALL {
            if !verify_tested_operation(gl, &info, operation, &buffer, glw::GL_NO_ERROR)? {
                test_result = false;
                log::info!("Buffer bound to PIXEL_UNPACK_BUFFER is not mapped");
            }
        }

        for operation in TestedOperation::ALL {
            {
                let _tmp = buffer.map_range(
                    0,
                    DATA_SIZE as glw::GLsizeiptr,
                    glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
                )?;
            }
            bind(gl, 0, glw::GL_PIXEL_UNPACK_BUFFER)?;
            if !verify_tested_operation(gl, &info, operation, &buffer, glw::GL_NO_ERROR)? {
                test_result = false;
                log::info!("Buffer bound to PIXEL_UNPACK_BUFFER is persistently mapped");
            }
        }

        verdict(test_result)
    }
}

/// A framebuffer name deleted on drop (`Framebuffer`).
struct Fbo<'gl> {
    gl: &'gl glw::Functions,
    id: glw::GLuint,
}

impl Drop for Fbo<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes the name this guard owns.
        unsafe { self.gl.delete_framebuffers(1, &self.id) };
    }
}

/// `MapPersistentReadPixelsTest`
struct MapPersistentReadPixelsTest;

impl TestCase for MapPersistentReadPixelsTest {
    fn name(&self) -> &str {
        "map_persistent_read_pixels"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const HEIGHT: usize = 8;
        const WIDTH: usize = 8;
        const DATA_SIZE: usize = WIDTH * HEIGHT;
        let gl = context.gl();
        let mut test_result = true;
        let size = DATA_SIZE as glw::GLsizeiptr;

        let mut initial_texture_data = [0u8; DATA_SIZE];
        let mut updated_texture_data = [0u8; DATA_SIZE];
        for i in 0..DATA_SIZE {
            initial_texture_data[i] = i as u8;
            updated_texture_data[i] = (DATA_SIZE - i) as u8;
        }

        let mut buffer = Buf::new(gl);
        buffer.init_storage(
            glw::GL_PIXEL_PACK_BUFFER,
            glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            size,
            std::ptr::null(),
        )?;

        let texture = Tex::new_2d(gl)?;
        // SAFETY: the pixel data holds WIDTH * HEIGHT bytes, the size of the level.
        unsafe {
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_R8UI,
                WIDTH as glw::GLsizei,
                HEIGHT as glw::GLsizei,
            );
            glu::expect_no_error(gl, "TexStorage2D")?;
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                WIDTH as glw::GLsizei,
                HEIGHT as glw::GLsizei,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_BYTE,
                initial_texture_data.as_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "TexSubImage2D")?;

        let mut framebuffer = Fbo { gl, id: 0 };
        // SAFETY: one name is written to the live field.
        unsafe { gl.gen_framebuffers(1, &mut framebuffer.id) };
        glu::expect_no_error(gl, "GenFramebuffers")?;
        // SAFETY: the framebuffer and texture were generated above.
        unsafe {
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, framebuffer.id);
            glu::expect_no_error(gl, "BindFramebuffer")?;
            gl.framebuffer_texture(glw::GL_READ_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.id, 0);
            glu::expect_no_error(gl, "FramebufferTexture")?;
            gl.viewport(0, 0, WIDTH as glw::GLsizei, HEIGHT as glw::GLsizei);
        }
        glu::expect_no_error(gl, "Viewport")?;

        let read_pixels = || {
            // SAFETY: the pack buffer is bound and holds WIDTH * HEIGHT bytes; a null pointer is the offset into it.
            unsafe {
                gl.read_pixels(
                    0,
                    0,
                    WIDTH as glw::GLsizei,
                    HEIGHT as glw::GLsizei,
                    glw::GL_RED_INTEGER,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null_mut(),
                )
            };
        };

        // ReadPixels into a buffer that is not mapped
        buffer.bind()?;
        read_pixels();
        glu::expect_no_error(gl, "ReadPixels to not mapped PIXEL_PACK buffer")?;

        // ReadPixels into a persistently mapped buffer
        {
            // SAFETY: the pixel data holds WIDTH * HEIGHT bytes.
            unsafe {
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    WIDTH as glw::GLsizei,
                    HEIGHT as glw::GLsizei,
                    glw::GL_RED_INTEGER,
                    glw::GL_UNSIGNED_BYTE,
                    updated_texture_data.as_ptr().cast(),
                )
            };
            glu::expect_no_error(gl, "TexSubImage2D")?;
            let map = buffer.map_range(
                0,
                size,
                glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            )?;
            buffer.bind()?;
            read_pixels();
            glu::expect_no_error(gl, "ReadPixels to persistently mapped PIXEL_PACK buffer")?;

            // SAFETY: plain commands.
            unsafe { gl.memory_barrier(glw::GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT) };
            glu::expect_no_error(gl, "MemoryBarrier")?;
            // SAFETY: as above.
            unsafe { gl.finish() };
            glu::expect_no_error(gl, "Finish")?;

            if map.bytes(DATA_SIZE) != updated_texture_data {
                test_result = false;
                log::info!("Wrong contents of persistently mapped PIXEL_PACK buffer after ReadPixels");
            }
        }

        // ReadPixels into a buffer mapped without MAP_PERSISTENT_BIT must fail.
        {
            let _tmp = buffer.map_range(0, size, glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT)?;
            buffer.bind()?;
            read_pixels();
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_INVALID_OPERATION {
                test_result = false;
                log::info!(
                    "Wrong error was generated by ReadPixels. Expected INVALID_OPERATION as PIXEL_PACK buffer is mapped. Got: {}",
                    glw::error_name(error)
                );
            }
        }

        verdict(test_result)
    }
}

/// The shared `iterate` of `MapPersistentFlushTest` and `MapPersistentDispatchTest`, whose bodies differ only in how the source buffer is mapped (explicit flush or coherent) and in the flush call.
fn map_persistent_compute(context: &Context, explicit_flush: bool) -> TestOutcome {
    const COMPUTE_SHADER: &str = "#version 430 core\n\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nlayout (binding = 0, std430) buffer DestinationData {\n    uint values[];\n} destination;\n\nlayout (binding = 1, std430) buffer SourceData {\n    uint values[];\n} source;\n\nvoid main()\n{\n    uint index = gl_GlobalInvocationID.x;\n    uint sum   = 0u;\n\n    for (uint i = 0u; i <= index; ++i)\n    {\n        sum += source.values[i];\n    }\n\n    destination.values[index] = sum;\n}\n\n";
    const DATA_SIZE: usize = 16;
    const DESTINATION_BINDING: glw::GLuint = 0;
    const SOURCE_BINDING: glw::GLuint = 1;
    let gl = context.gl();
    let mut test_result = true;
    let byte_size = (DATA_SIZE * std::mem::size_of::<u32>()) as glw::GLsizeiptr;

    let destination_data = [0u32; DATA_SIZE];
    let mut modified_source_data = [0u32; DATA_SIZE];
    let mut modified_sum_data = [0u32; DATA_SIZE];
    let mut source_data = [0u32; DATA_SIZE];
    let mut sum_data = [0u32; DATA_SIZE];
    let mut modified_sum = 0u32;
    let mut sum = 0u32;
    for i in 0..DATA_SIZE {
        modified_source_data[i] = (DATA_SIZE - i) as u32;
        source_data[i] = i as u32;
        modified_sum += modified_source_data[i];
        sum += source_data[i];
        modified_sum_data[i] = modified_sum;
        sum_data[i] = sum;
    }
    let as_bytes =
        |values: &[u32; DATA_SIZE]| -> Vec<u8> { values.iter().flat_map(|value| value.to_ne_bytes()).collect() };

    let mut destination = Buf::new(gl);
    let mut source = Buf::new(gl);
    destination.init_storage(
        glw::GL_SHADER_STORAGE_BUFFER,
        glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT,
        byte_size,
        destination_data.as_ptr().cast(),
    )?;
    source.init_storage(
        glw::GL_SHADER_STORAGE_BUFFER,
        glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_WRITE_BIT,
        byte_size,
        source_data.as_ptr().cast(),
    )?;

    // Program::Init with only a compute shader
    let compute = Shader::new(gl, glw::GL_COMPUTE_SHADER)?;
    compute.source(&[COMPUTE_SHADER])?;
    if !compute.compile()? {
        return Err(TestError::Fail("Failed to compile shader".to_string()));
    }
    let program = Program::new(gl)?;
    program.attach(&compute)?;
    if !program.link()? {
        return Err(TestError::Fail("Failed to link program".to_string()));
    }

    // SAFETY: a live, linked program.
    unsafe { gl.use_program(program.id) };
    glu::expect_no_error(gl, "UseProgram")?;

    destination.bind()?;
    let destination_map = destination.map_range(
        0,
        byte_size,
        glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT,
    )?;
    source.bind()?;
    let source_map = source.map_range(
        0,
        byte_size,
        (if explicit_flush {
            glw::GL_MAP_FLUSH_EXPLICIT_BIT
        } else {
            glw::GL_MAP_COHERENT_BIT
        }) | glw::GL_MAP_PERSISTENT_BIT
            | glw::GL_MAP_WRITE_BIT,
    )?;

    bind(gl, 0, glw::GL_SHADER_STORAGE_BUFFER)?;

    // SAFETY: both buffers are alive; the binding indices are within the limits the shader declares.
    unsafe {
        gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, DESTINATION_BINDING, destination.id);
        glu::expect_no_error(gl, "BindBufferBase")?;
        gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, SOURCE_BINDING, source.id);
        glu::expect_no_error(gl, "BindBufferBase")?;

        gl.dispatch_compute(16, 1, 1);
        glu::expect_no_error(gl, "DispatchCompute with persistently mapped buffers")?;

        gl.finish();
        glu::expect_no_error(gl, "Finish")?;
    }

    if destination_map.bytes(byte_size as usize) != as_bytes(&sum_data).as_slice() {
        test_result = false;
        log::info!("Contents of mapped region does not correspond with expected results");
    }

    // SAFETY: the source mapping holds `byte_size` bytes and `modified_source_data` the same amount.
    unsafe {
        std::ptr::copy_nonoverlapping(
            modified_source_data.as_ptr().cast::<u8>(),
            source_map.data.cast::<u8>(),
            byte_size as usize,
        )
    };

    if explicit_flush {
        source.bind()?;
        // SAFETY: the flushed range lies inside the mapping.
        unsafe { gl.flush_mapped_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, byte_size) };
        glu::expect_no_error(gl, "FlushMappedBufferRange")?;

        bind(gl, 0, glw::GL_SHADER_STORAGE_BUFFER)?;
    }

    // SAFETY: as above.
    unsafe {
        gl.dispatch_compute(16, 1, 1);
        glu::expect_no_error(gl, "DispatchCompute with persistently mapped buffers")?;

        gl.finish();
        glu::expect_no_error(gl, "Finish")?;
    }

    if destination_map.bytes(byte_size as usize) != as_bytes(&modified_sum_data).as_slice() {
        test_result = false;
        log::info!("Contents of mapped region does not correspond with expected results");
    }

    verdict(test_result)
}

/// `MapPersistentFlushTest`
struct MapPersistentFlushTest;

impl TestCase for MapPersistentFlushTest {
    fn name(&self) -> &str {
        "map_persistent_flush"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        map_persistent_compute(context, true)
    }
}

/// `MapPersistentDispatchTest`
struct MapPersistentDispatchTest;

impl TestCase for MapPersistentDispatchTest {
    fn name(&self) -> &str {
        "map_persistent_dispatch"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        map_persistent_compute(context, false)
    }
}

/// A vertex array name deleted on drop (`VertexArray`).
struct Vao<'gl> {
    gl: &'gl glw::Functions,
    id: glw::GLuint,
}

impl Drop for Vao<'_> {
    fn drop(&mut self) {
        // SAFETY: unbinds and deletes the name this guard owns.
        unsafe {
            self.gl.bind_vertex_array(0);
            self.gl.delete_vertex_arrays(1, &self.id);
        }
    }
}

/// `MapPersistentDrawTest`
struct MapPersistentDrawTest;

impl TestCase for MapPersistentDrawTest {
    fn name(&self) -> &str {
        "map_persistent_draw"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const FRAGMENT_SHADER: &str = "#version 440 core\n\nin  float gs_fs_color;\nout vec4  fs_out_color;\n\nvoid main()\n{\n    fs_out_color = vec4(gs_fs_color, 0, 0, 1);\n}\n\n";
        const GEOMETRY_SHADER: &str = "#version 440 core\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\nstruct Rectangle {\n    vec2 position;\n    vec2 size;\n};\n\nlayout (std140, binding = 0) uniform Rectangles {\n    Rectangle rectangle[2];\n} rectangles;\n\nlayout (binding = 0) uniform atomic_uint atom_color[2];\nlayout (binding = 0) uniform atomic_uint invocation_hit_count[2];\n\nin  uint  vs_gs_index[];\nout float gs_fs_color;\n\nvoid main()\n{\n    if (atomicCounterIncrement(invocation_hit_count[gl_PrimitiveIDIn]) == 0)\n    {\n        atomicCounterIncrement(atom_color[gl_PrimitiveIDIn]);\n    }\n    memoryBarrierAtomicCounter();\n    const uint atom_color_value = atomicCounter(atom_color[gl_PrimitiveIDIn]);    //const uint  atom_color_value = vs_gs_index[0];\n    const float color            = float(atom_color_value) / 255.0;\n    //const float color            = rectangles.rectangle[1].size.x;\n\n    const float left   = rectangles.rectangle[vs_gs_index[0]].position.x;\n    const float bottom = rectangles.rectangle[vs_gs_index[0]].position.y;\n    const float right  = rectangles.rectangle[vs_gs_index[0]].size.x + left;\n    const float top    = rectangles.rectangle[vs_gs_index[0]].size.y + bottom;\n\n    //const float left   = rectangles.rectangle[0].position.x;\n    //const float bottom = rectangles.rectangle[0].position.y;\n    //const float right  = rectangles.rectangle[0].size.x + left;\n    //const float top    = rectangles.rectangle[0].size.y + bottom;\n\n    gs_fs_color = color;\n    gl_Position  = vec4(left, bottom, 0, 1);\n    EmitVertex();\n\n    gs_fs_color = color;\n    gl_Position  = vec4(left, top, 0, 1);\n    EmitVertex();\n\n    gs_fs_color = color;\n    gl_Position  = vec4(right, bottom, 0, 1);\n    EmitVertex();\n\n    gs_fs_color = color;\n    gl_Position  = vec4(right, top, 0, 1);\n    EmitVertex();\n}\n\n";
        const VERTEX_SHADER: &str =
            "#version 440 core\n\nout uint vs_gs_index;\n\nvoid main()\n{\n    vs_gs_index = gl_VertexID;\n}\n\n";
        const ATOM_BINDING: glw::GLuint = 0;
        const ATOM_DATA_SIZE: usize = 4 * std::mem::size_of::<u32>();
        const EXPECTED_ATOM_FIRST: u32 = 2;
        const EXPECTED_ATOM_SECOND: u32 = 6;
        const EXPECTED_PIXEL: u32 = 0xff000004;
        const HEIGHT: usize = 16;
        const N_RECTANGLES: usize = 2;
        const PIXEL_SIZE: usize = 4;
        const RECTANGLES_BINDING: glw::GLuint = 0;
        const RECTANGLE_SIZE: usize = 2 * 2 * std::mem::size_of::<f32>();
        const RECTANGLES_DATA_SIZE: usize = N_RECTANGLES * RECTANGLE_SIZE;
        const WIDTH: usize = 16;
        const LINE_SIZE: usize = WIDTH * PIXEL_SIZE;
        const PIXEL_OFFSET: usize = 8 * LINE_SIZE + 7 * PIXEL_SIZE;
        const TEXTURE_DATA_SIZE: usize = HEIGHT * LINE_SIZE;
        let gl = context.gl();

        let mut max_atomic_buffers: glw::GLint = 0;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS, &mut max_atomic_buffers) };
        if max_atomic_buffers < 2 {
            return Err(TestError::NotSupported("Unsupported".to_string()));
        }

        let mut test_result = true;

        let atom_first_data: [u32; 4] = [1, 1, 0, 0];
        let atom_second_data: [u32; 4] = [5, 5, 0, 0];
        let rectangles_first_data: [f32; 8] = [-0.5, -0.5, 1.0, 1.0, -0.75, -0.75, 1.5, 1.5];
        let rectangles_second_data: [f32; 8] = [-1.0, -1.0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
        let mut texture_data = [0u8; TEXTURE_DATA_SIZE];

        let mut atom = Buf::new(gl);
        let mut rectangles = Buf::new(gl);
        atom.init_storage(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            ATOM_DATA_SIZE as glw::GLsizeiptr,
            std::ptr::null(),
        )?;
        rectangles.init_storage(
            glw::GL_UNIFORM_BUFFER,
            glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_WRITE_BIT,
            RECTANGLES_DATA_SIZE as glw::GLsizeiptr,
            std::ptr::null(),
        )?;

        // Framebuffer with a texture to draw to
        let mut framebuffer = Fbo { gl, id: 0 };
        let texture = Tex::new_2d(gl)?;
        // SAFETY: names written to live fields and objects generated here.
        unsafe {
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA8,
                WIDTH as glw::GLsizei,
                HEIGHT as glw::GLsizei,
            );
            glu::expect_no_error(gl, "TexStorage2D")?;
            gl.gen_framebuffers(1, &mut framebuffer.id);
            glu::expect_no_error(gl, "GenFramebuffers")?;
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer.id);
            glu::expect_no_error(gl, "BindFramebuffer")?;
            gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.id, 0);
            glu::expect_no_error(gl, "FramebufferTexture")?;
            gl.viewport(0, 0, WIDTH as glw::GLsizei, HEIGHT as glw::GLsizei);
            glu::expect_no_error(gl, "Viewport")?;
        }

        let mut vao = Vao { gl, id: 0 };
        // SAFETY: a name written to the live field, then bound.
        unsafe {
            gl.gen_vertex_arrays(1, &mut vao.id);
            glu::expect_no_error(gl, "GenVertexArrays")?;
            gl.bind_vertex_array(vao.id);
            glu::expect_no_error(gl, "BindVertexArray")?;
        }

        // Program::Init without compute, tessellation shaders
        let fragment = Shader::new(gl, glw::GL_FRAGMENT_SHADER)?;
        let geometry = Shader::new(gl, glw::GL_GEOMETRY_SHADER)?;
        let vertex = Shader::new(gl, glw::GL_VERTEX_SHADER)?;
        let program = Program::new(gl)?;
        for (shader, source) in [
            (&fragment, FRAGMENT_SHADER),
            (&geometry, GEOMETRY_SHADER),
            (&vertex, VERTEX_SHADER),
        ] {
            shader.source(&[source])?;
            if !shader.compile()? {
                return Err(TestError::Fail("Failed to compile shader".to_string()));
            }
            program.attach(shader)?;
        }
        if !program.link()? {
            return Err(TestError::Fail("Failed to link program".to_string()));
        }
        // SAFETY: a live, linked program.
        unsafe { gl.use_program(program.id) };
        glu::expect_no_error(gl, "UseProgram")?;

        // Flush explicitly on 4.5 core, use the barrier otherwise.
        let is_gl_45 = context.context_type().supports_core(4, 5);
        let flush_bit = if is_gl_45 { glw::GL_MAP_FLUSH_EXPLICIT_BIT } else { 0 };

        let atom_map = atom.map_range(
            0,
            ATOM_DATA_SIZE as glw::GLsizeiptr,
            glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT | flush_bit,
        )?;
        let rectangles_map = rectangles.map_range(
            0,
            RECTANGLES_DATA_SIZE as glw::GLsizeiptr,
            glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_WRITE_BIT | flush_bit,
        )?;

        bind(gl, 0, glw::GL_ATOMIC_COUNTER_BUFFER)?;
        bind(gl, 0, glw::GL_UNIFORM_BUFFER)?;

        // SAFETY: both buffers are alive; the binding indices are within the limits the shader declares.
        unsafe {
            gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, ATOM_BINDING, atom.id);
            glu::expect_no_error(gl, "BindBufferBase")?;
            gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, RECTANGLES_BINDING, rectangles.id);
            glu::expect_no_error(gl, "BindBufferBase")?;

            gl.enable(glw::GL_BLEND);
            gl.blend_func(glw::GL_ONE, glw::GL_ONE);
        }

        let flush_or_barrier = || -> Result<(), TestError> {
            // SAFETY: the flushed ranges lie inside the mappings.
            unsafe {
                if is_gl_45 {
                    gl.flush_mapped_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, ATOM_DATA_SIZE as glw::GLsizeiptr);
                    glu::expect_no_error(gl, "glFlushMappedBufferRange")?;
                    gl.flush_mapped_buffer_range(glw::GL_UNIFORM_BUFFER, 0, RECTANGLES_DATA_SIZE as glw::GLsizeiptr);
                    glu::expect_no_error(gl, "glFlushMappedBufferRange")?;
                } else {
                    gl.memory_barrier(glw::GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT);
                    glu::expect_no_error(gl, "MemoryBarrier")?;
                }
            }
            Ok(())
        };
        let draw_and_read_back = |texture_data: &mut [u8]| -> Result<(), TestError> {
            // SAFETY: the framebuffer, program and buffers set up above are bound; `texture_data` holds the whole level.
            unsafe {
                gl.draw_arrays(glw::GL_POINTS, 0, 2);
                glu::expect_no_error(gl, "DrawArrays with persistently mapped buffers")?;
                gl.memory_barrier(glw::GL_ALL_BARRIER_BITS);
                glu::expect_no_error(gl, "MemoryBarrier")?;
                gl.get_tex_image(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    texture_data.as_mut_ptr().cast(),
                );
                glu::expect_no_error(gl, "GetTexImage")?;
            }
            Ok(())
        };
        let copy_to_map = |map: &Mapped, source: *const u8, size: usize| {
            // SAFETY: the mapping holds `size` bytes and `source` points at as many.
            unsafe { std::ptr::copy_nonoverlapping(source, map.data.cast::<u8>(), size) };
        };

        let expected_pixel = EXPECTED_PIXEL.to_ne_bytes();

        // First draw with the initial buffer data
        copy_to_map(&atom_map, atom_first_data.as_ptr().cast(), ATOM_DATA_SIZE);
        copy_to_map(
            &rectangles_map,
            rectangles_first_data.as_ptr().cast(),
            RECTANGLES_DATA_SIZE,
        );
        flush_or_barrier()?;

        let clear_color: [glw::GLint; 4] = [0, 0, 0, 0];
        // SAFETY: four values are read from the live array.
        unsafe { gl.clear_bufferiv(glw::GL_COLOR, 0, clear_color.as_ptr()) };

        draw_and_read_back(&mut texture_data)?;
        if texture_data[PIXEL_OFFSET..PIXEL_OFFSET + PIXEL_SIZE] != expected_pixel {
            test_result = false;
            log::info!("Contents of framebuffer does not correspond with expected results");
        }
        if atom_map.bytes(std::mem::size_of::<u32>()) != EXPECTED_ATOM_FIRST.to_ne_bytes() {
            test_result = false;
            log::info!("Contents of ATOMIC_COUNTER buffer are invalid.");
        }

        // Second draw with the updated buffer data
        copy_to_map(&atom_map, atom_second_data.as_ptr().cast(), ATOM_DATA_SIZE);
        copy_to_map(
            &rectangles_map,
            rectangles_second_data.as_ptr().cast(),
            RECTANGLES_DATA_SIZE,
        );
        flush_or_barrier()?;

        draw_and_read_back(&mut texture_data)?;
        if texture_data[PIXEL_OFFSET..PIXEL_OFFSET + PIXEL_SIZE] != expected_pixel {
            test_result = false;
            log::info!("Contents of framebuffer does not correspond with expected results");
        }
        if atom_map.bytes(std::mem::size_of::<u32>()) != EXPECTED_ATOM_SECOND.to_ne_bytes() {
            test_result = false;
            log::info!("Contents of ATOMIC_COUNTER buffer are invalid.");
        }

        verdict(test_result)
    }
}

/// `BufferStorageTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer_storage");
    group.add_child(Box::new(ErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(GetBufferParameterTest) as Box<dyn TestCase>);
    group.add_child(Box::new(DynamicStorageTest) as Box<dyn TestCase>);
    group.add_child(Box::new(MapPersistentBufferSubDataTest) as Box<dyn TestCase>);
    group.add_child(Box::new(MapPersistentTextureTest) as Box<dyn TestCase>);
    group.add_child(Box::new(MapPersistentReadPixelsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(MapPersistentDispatchTest) as Box<dyn TestCase>);
    group.add_child(Box::new(MapPersistentFlushTest) as Box<dyn TestCase>);
    group.add_child(Box::new(MapPersistentDrawTest) as Box<dyn TestCase>);
    group
}

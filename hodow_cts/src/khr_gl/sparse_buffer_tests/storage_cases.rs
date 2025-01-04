// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cSparseBufferTests.cpp  (BufferStorageTestCase and the classes CopyOpsBufferStorageTestCase, InvalidateBufferStorageTestCase, IndirectDispatchBufferStorageTestCase, SSBOStorageTestCase, UniformBufferStorageTestCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `deinitTestCaseGlobal` of each class is the `Drop` of that class; `SparseBufferTestUtilities::createComputeProgram` and `createProgram` are `create_compute_program` and `create_vertex_program` (the only shapes used here) and return 0 on failure like upstream. The unwritten bytes of the heap buffers upstream allocates with `new` are zero here. glw has no 64-bit query getters, so `QueryBufferStorageTestCase` runs only the `glGetQueryObjectiv` and `glGetQueryObjectuiv` calls of its four.

use std::ffi::CString;

use super::{check_page_size, fail};
use crate::glu::Context;
use crate::glw::{self, GLint, GLsizei, GLsizeiptr, GLuint};
use crate::tcu::TestError;

/// `BufferStorageTestCase`
pub(super) trait StorageCase {
    /// `initTestCaseGlobal`
    fn init_test_case_global(&mut self) -> Result<bool, TestError>;
    /// `initTestCaseIteration`
    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError>;
    /// `execute`
    fn execute(&mut self, sparse_bo_storage_flags: GLuint) -> Result<bool, TestError>;
    /// `deinitTestCaseIteration`
    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError>;
}

/// The case behind one `BufferStorageTest_*` name, if it is ported.
pub(super) fn create<'a>(context: &'a Context, name: &str) -> Option<Box<dyn StorageCase + 'a>> {
    match name {
        "BufferStorageTest_case_d" => Some(Box::new(Invalidate::new(context))),
        "BufferStorageTest_case_h" => Some(Box::new(IndirectDispatch::new(context))),
        "BufferStorageTest_case_i" => Some(Box::new(Ssbo::new(context))),
        "BufferStorageTest_case_j" => Some(Box::new(UniformBuffer::new(context))),
        "BufferStorageTest_case_g" => Some(Box::new(CopyOps::new(context))),
        "BufferStorageTest_case_m" => Some(Box::new(Query::new(context))),
        "BufferStorageTest_case_f" => Some(Box::new(BufferTexture::new(context))),
        "BufferStorageTest_case_k" => Some(Box::new(PixelPack::new(context))),
        "BufferStorageTest_case_l" => Some(Box::new(PixelUnpack::new(context))),
        _ if name.starts_with("BufferStorageTest_case_c_clear_op_type_") => {
            let rest = name.strip_prefix("BufferStorageTest_case_c_clear_op_type_")?;
            let clear_op_type: u32 = rest.get(..1)?.parse().ok()?;
            let iteration: u32 = rest
                .strip_prefix(&format!("{clear_op_type}_iteration_"))?
                .parse()
                .ok()?;
            Some(Box::new(ClearOps::new(context, clear_op_type, iteration)))
        }
        "BufferStorageTest_cases_a1-a2_1" => Some(Box::new(Quads::new(context, IboUsage::None, false))),
        "BufferStorageTest_cases_a3-a4_2" => Some(Box::new(Quads::new(context, IboUsage::IndexedDrawCall, false))),
        "BufferStorageTest_cases_a3-a4_3" => {
            Some(Box::new(Quads::new(context, IboUsage::IndexedRangedDrawCall, false)))
        }
        "BufferStorageTest_cases_a5-a6_4" => Some(Box::new(Quads::new(context, IboUsage::IndexedDrawCall, true))),
        "BufferStorageTest_cases_a5-a6" => Some(Box::new(Quads::new(context, IboUsage::IndexedRangedDrawCall, true))),
        "BufferStorageTest_case_e" => Some(Box::new(AtomicCounter::new(context, false))),
        "BufferStorageTest_case_e_all_pages" => Some(Box::new(AtomicCounter::new(context, true))),
        _ => super::tf_case::create(context, name),
    }
}

/// `SparseBufferTestUtilities::alignOffset`
pub(super) fn align_offset(offset: u32, value: u32) -> u32 {
    offset + (value - offset % value) % value
}

fn source_parts(parts: &[&str]) -> Result<Vec<CString>, TestError> {
    parts
        .iter()
        .map(|part| CString::new(*part).map_err(|_| TestError::Fail("Shader source contains a NUL".to_string())))
        .collect()
}

/// `SparseBufferTestUtilities::createComputeProgram` for one body part: 0 when the shader failed to compile or the program to link.
fn create_compute_program(context: &Context, parts: &[&str]) -> Result<GLuint, TestError> {
    let gl = context.gl();
    let sources = source_parts(parts)?;
    let pointers: Vec<_> = sources.iter().map(|part| part.as_ptr()).collect();
    let mut status = glw::GL_FALSE as GLint;

    // SAFETY: plain object creation.
    let (cs_id, po_id) = unsafe { (gl.create_shader(glw::GL_COMPUTE_SHADER), gl.create_program()) };
    crate::glu::expect_no_error(gl, "glCreateProgram() / glCreateShader() call(s) failed.")?;

    gl_call!(gl, "glAttachShader() call(s) failed.", gl.attach_shader(po_id, cs_id));
    gl_call!(
        gl,
        "glShaderSource() call(s) failed.",
        gl.shader_source(cs_id, pointers.len() as GLsizei, pointers.as_ptr(), std::ptr::null())
    );
    gl_call!(gl, "glCompileShader() call failed.", gl.compile_shader(cs_id));
    gl_call!(
        gl,
        "glGetShaderiv() call failed",
        gl.get_shaderiv(cs_id, glw::GL_COMPILE_STATUS, &mut status)
    );

    let mut result = status == glw::GL_TRUE as GLint;

    if result {
        gl_call!(gl, "glLinkProgram() call failed.", gl.link_program(po_id));
        gl_call!(
            gl,
            "glGetProgramiv() call failed.",
            gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut status)
        );
        result = status == glw::GL_TRUE as GLint;
    }

    // SAFETY: the shader was created above and is deleted once.
    unsafe { gl.delete_shader(cs_id) };

    if !result {
        // SAFETY: the program was created above and is deleted once.
        unsafe { gl.delete_program(po_id) };
        return Ok(0);
    }

    Ok(po_id)
}

/// `SparseBufferTestUtilities::createProgram` with only a vertex shader and transform feedback varyings: 0 on failure.
pub(super) fn create_vertex_program(
    context: &Context,
    parts: &[&str],
    tf_varyings: &[&str],
    tf_varying_mode: glw::GLenum,
) -> Result<GLuint, TestError> {
    create_program(context, &[], parts, &[], tf_varyings, tf_varying_mode)
}

/// `SparseBufferTestUtilities::createProgram` over fragment and vertex body parts (either may be empty): 0 on failure.
pub(super) fn create_program(
    context: &Context,
    fs_parts: &[&str],
    parts: &[&str],
    attributes: &[(&str, GLuint)],
    tf_varyings: &[&str],
    tf_varying_mode: glw::GLenum,
) -> Result<GLuint, TestError> {
    let gl = context.gl();
    let sources = source_parts(parts)?;
    let pointers: Vec<_> = sources.iter().map(|part| part.as_ptr()).collect();
    let varyings: Vec<CString> = tf_varyings
        .iter()
        .map(|name| CString::new(*name).expect("names have no NUL"))
        .collect();
    let varying_pointers: Vec<_> = varyings.iter().map(|name| name.as_ptr()).collect();
    let fs_sources = source_parts(fs_parts)?;
    let fs_pointers: Vec<_> = fs_sources.iter().map(|part| part.as_ptr()).collect();
    let mut status = glw::GL_FALSE as GLint;

    // SAFETY: plain object creation.
    let fs_id = if fs_parts.is_empty() {
        0
    } else {
        unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) }
    };
    // SAFETY: plain object creation.
    let (po_id, vs_id) = unsafe { (gl.create_program(), gl.create_shader(glw::GL_VERTEX_SHADER)) };
    crate::glu::expect_no_error(gl, "glCreateProgram() / glCreateShader() call(s) failed.")?;

    if fs_id != 0 {
        gl_call!(gl, "glAttachShader() call(s) failed.", gl.attach_shader(po_id, fs_id));
    }
    gl_call!(gl, "glAttachShader() call(s) failed.", gl.attach_shader(po_id, vs_id));
    if fs_id != 0 {
        gl_call!(
            gl,
            "glShaderSource() call(s) failed.",
            gl.shader_source(
                fs_id,
                fs_pointers.len() as GLsizei,
                fs_pointers.as_ptr(),
                std::ptr::null()
            )
        );
    }
    gl_call!(
        gl,
        "glShaderSource() call(s) failed.",
        gl.shader_source(vs_id, pointers.len() as GLsizei, pointers.as_ptr(), std::ptr::null())
    );

    let mut result = true;
    for so_id in [fs_id, vs_id] {
        if so_id != 0 && result {
            gl_call!(gl, "glCompileShader() call failed.", gl.compile_shader(so_id));
            gl_call!(
                gl,
                "glGetShaderiv() call failed",
                gl.get_shaderiv(so_id, glw::GL_COMPILE_STATUS, &mut status)
            );
            result = status == glw::GL_TRUE as GLint;
        }
    }

    if result {
        for (name, location) in attributes {
            let name = CString::new(*name).expect("names have no NUL");
            gl_call!(
                gl,
                "glBindAttribLocation() call failed.",
                gl.bind_attrib_location(po_id, *location, name.as_ptr())
            );
        }

        if !varying_pointers.is_empty() {
            gl_call!(
                gl,
                "glTransformFeedbackVaryings() call failed.",
                gl.transform_feedback_varyings(
                    po_id,
                    varying_pointers.len() as GLsizei,
                    varying_pointers.as_ptr(),
                    tf_varying_mode
                )
            );
        }
        gl_call!(gl, "glLinkProgram() call failed.", gl.link_program(po_id));
        gl_call!(
            gl,
            "glGetProgramiv() call failed.",
            gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut status)
        );
        result = status == glw::GL_TRUE as GLint;
    }

    // SAFETY: the shaders were created above and are deleted once.
    unsafe {
        if fs_id != 0 {
            gl.delete_shader(fs_id);
        }
        gl.delete_shader(vs_id);
    }

    if !result {
        // SAFETY: the program was created above and is deleted once.
        unsafe { gl.delete_program(po_id) };
        return Ok(0);
    }

    Ok(po_id)
}

/// The decommit every `deinitTestCaseIteration` does: the whole rounded range of `sparse_bo`.
pub(super) fn decommit_all(context: &Context, sparse_bo: GLuint, size_rounded: u32) -> Result<(), TestError> {
    let gl = context.gl();

    if sparse_bo != 0 {
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, sparse_bo)
        );
        gl_call!(
            gl,
            "glBufferPageCommitmentARB() call failed.",
            gl.buffer_page_commitment_arb(
                glw::GL_ARRAY_BUFFER,
                0,
                size_rounded as glw::GLintptr,
                glw::GL_FALSE as glw::GLboolean
            )
        );
    }

    Ok(())
}

/// `InvalidateBufferStorageTestCase`
struct Invalidate<'a> {
    context: &'a Context,
    n_pages_to_use: u32,
    page_size: GLint,
    sparse_bo: GLuint,
    sparse_bo_size_rounded: u32,
}

impl<'a> Invalidate<'a> {
    fn new(context: &'a Context) -> Self {
        Self {
            context,
            n_pages_to_use: 4,
            page_size: 0,
            sparse_bo: 0,
            sparse_bo_size_rounded: 0,
        }
    }
}

impl StorageCase for Invalidate<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        self.page_size = check_page_size(self.context)?;

        let n_bytes_needed = self.n_pages_to_use * self.page_size as u32;
        self.sparse_bo_size_rounded = align_offset(n_bytes_needed, self.page_size as u32);

        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.sparse_bo = sparse_bo;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.sparse_bo)
        );
        gl_call!(
            gl,
            "glBufferPageCommitmentARB() call failed.",
            gl.buffer_page_commitment_arb(
                glw::GL_ARRAY_BUFFER,
                0,
                self.sparse_bo_size_rounded as glw::GLintptr,
                glw::GL_TRUE as glw::GLboolean
            )
        );
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();

        for n_entry_point in 0..2 {
            let should_test_invalidate_buffer = n_entry_point == 0;

            for n_iteration in 0..(if should_test_invalidate_buffer { 1 } else { 2 }) {
                if should_test_invalidate_buffer {
                    gl_call!(
                        gl,
                        "glInvalidateBufferData() call failed.",
                        gl.invalidate_buffer_data(self.sparse_bo)
                    );
                } else {
                    let length = self.sparse_bo_size_rounded as GLsizeiptr * if n_iteration == 0 { 1 } else { 2 };
                    gl_call!(
                        gl,
                        "glInvalidateBufferSubData() call failed.",
                        gl.invalidate_buffer_sub_data(self.sparse_bo, 0, length)
                    );
                }
            }
        }

        Ok(true)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

const INDIRECT_DISPATCH_CS: &str = "#version 430 core\n\nlayout(local_size_x = 1023)          in;\nlayout(binding      = 0, offset = 0) uniform atomic_uint ac;\n\nvoid main()\n{\n    atomicCounterIncrement(ac);\n}\n";

/// `IndirectDispatchBufferStorageTestCase`
struct IndirectDispatch<'a> {
    context: &'a Context,
    dispatch_draw_call_args_start_offset: i32,
    global_wg_size_x: u32,
    helper_bo: GLuint,
    local_wg_size_x: u32,
    po: GLuint,
    sparse_bo: GLuint,
    sparse_bo_size_rounded: u32,
}

impl<'a> IndirectDispatch<'a> {
    fn new(context: &'a Context) -> Self {
        Self {
            context,
            dispatch_draw_call_args_start_offset: -1,
            global_wg_size_x: 2048,
            helper_bo: 0,
            local_wg_size_x: 1023,
            po: 0,
            sparse_bo: 0,
            sparse_bo_size_rounded: 0,
        }
    }
}

impl Drop for IndirectDispatch<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.po != 0 {
                gl.delete_program(self.po);
            }
        }
    }
}

impl StorageCase for IndirectDispatch<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = check_page_size(self.context)?;

        const N_INDIRECT_DISPATCH_CALL_ARG_BYTES: i32 = 3 * 4;

        let sparse_bo_size = if page_size >= N_INDIRECT_DISPATCH_CALL_ARG_BYTES {
            self.dispatch_draw_call_args_start_offset = align_offset((page_size - 4) as u32, 4) as i32;
            self.dispatch_draw_call_args_start_offset as u32 + N_INDIRECT_DISPATCH_CALL_ARG_BYTES as u32
        } else {
            self.dispatch_draw_call_args_start_offset = 0;
            N_INDIRECT_DISPATCH_CALL_ARG_BYTES as u32
        };

        self.sparse_bo_size_rounded = align_offset(sparse_bo_size, page_size as u32);

        let helper_bo_data: [u32; 4] = [self.global_wg_size_x, 1, 1, 0];

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&helper_bo_data) as GLsizeiptr,
                helper_bo_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        self.po = create_compute_program(self.context, &[INDIRECT_DISPATCH_CS])?;
        Ok(self.po != 0)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.sparse_bo = sparse_bo;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.sparse_bo)
        );
        gl_call!(
            gl,
            "glBufferPageCommitmentARB() call failed.",
            gl.buffer_page_commitment_arb(
                glw::GL_ARRAY_BUFFER,
                0,
                self.sparse_bo_size_rounded as glw::GLintptr,
                glw::GL_TRUE as glw::GLboolean
            )
        );
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut result = true;

        gl_call!(gl, "glBindBuffer() call(s) failed", {
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.helper_bo);
            gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, self.sparse_bo);
        });
        gl_call!(
            gl,
            "glBindBufferRange() call failed.",
            gl.bind_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.helper_bo, 12, 4)
        );
        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po));

        let zero_ac_value: u32 = 0;
        gl_call!(
            gl,
            "glBufferSubData() call failed.",
            gl.buffer_sub_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                12,
                4,
                std::ptr::from_ref(&zero_ac_value).cast()
            )
        );

        let mut expected_ac_value = zero_ac_value;

        gl_call!(
            gl,
            "glBufferPageCommitmentARB() call(s) failed.",
            gl.buffer_page_commitment_arb(
                glw::GL_DISPATCH_INDIRECT_BUFFER,
                0,
                self.sparse_bo_size_rounded as glw::GLintptr,
                glw::GL_TRUE as glw::GLboolean
            )
        );
        expected_ac_value += self.global_wg_size_x * self.local_wg_size_x;

        gl_call!(gl, "glBindBuffer() call failed.", {
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo);
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.sparse_bo);
        });

        // SAFETY: the copy is checked together with the dispatch below, as upstream does.
        unsafe {
            gl.copy_buffer_sub_data(
                glw::GL_COPY_READ_BUFFER,
                glw::GL_COPY_WRITE_BUFFER,
                0,
                self.dispatch_draw_call_args_start_offset as glw::GLintptr,
                12,
            )
        };
        gl_call!(
            gl,
            "glDispatchComputeIndirect() call failed.",
            gl.dispatch_compute_indirect(self.dispatch_draw_call_args_start_offset as glw::GLintptr)
        );

        // SAFETY: a read-only mapping of the 4 bytes of the bound atomic counter buffer.
        let ac_data_ptr = unsafe { gl.map_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 12, 4, glw::GL_MAP_READ_BIT) };
        crate::glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;

        if ac_data_ptr.is_null() {
            return Ok(false);
        }

        // SAFETY: the mapping is four bytes long and stays valid until the unmap below.
        let found = unsafe { ac_data_ptr.cast::<u32>().read_unaligned() };

        if found != expected_ac_value {
            log::info!(
                "Invalid atomic counter value encountered. Expected value: [{expected_ac_value}], found:[{found}]."
            );
            result = false;
        }

        gl_call!(
            gl,
            "glUnmapBuffer() call failed.",
            gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER)
        );
        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

const SSBO_CS: &str = "#version 430 core\n\nlayout(local_size_x = 1024) in;\n\nlayout(std140, binding = 0) buffer data\n{\n    restrict uint io_values[];\n};\n\nvoid main()\n{\n    uint value_index = gl_GlobalInvocationID.x;\n    uint new_value   = (io_values[value_index] == value_index) ? (value_index + 1u) : value_index;\n\n    io_values[value_index] = new_value;\n}\n";

/// `SSBOStorageTestCase`
struct Ssbo<'a> {
    context: &'a Context,
    helper_bo: GLuint,
    po: GLuint,
    po_local_wg_size: u32,
    result_bo: GLuint,
    sparse_bo: GLuint,
    sparse_bo_size: u32,
    sparse_bo_size_rounded: u32,
    page_size: GLint,
}

impl<'a> Ssbo<'a> {
    fn new(context: &'a Context) -> Self {
        Self {
            context,
            helper_bo: 0,
            po: 0,
            po_local_wg_size: 1024,
            result_bo: 0,
            sparse_bo: 0,
            sparse_bo_size: 0,
            sparse_bo_size_rounded: 0,
            page_size: 0,
        }
    }
}

impl Drop for Ssbo<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.po != 0 {
                gl.delete_program(self.po);
            }
            if self.result_bo != 0 {
                gl.delete_buffers(1, &self.result_bo);
            }
        }
    }
}

impl StorageCase for Ssbo<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.page_size = check_page_size(self.context)?;
        self.sparse_bo_size = (16777216 / (4 * 4)) * (4 * 4);
        self.sparse_bo_size_rounded = align_offset(self.sparse_bo_size, self.page_size as u32);

        self.po = create_compute_program(self.context, &[SSBO_CS])?;

        let mut ssbo_data = vec![0u32; self.sparse_bo_size as usize / 4];
        for index in 0..self.sparse_bo_size as usize / 4 / 4 {
            ssbo_data[4 * index] = index as u32;
        }

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_COPY_READ_BUFFER,
                self.sparse_bo_size as GLsizeiptr,
                ssbo_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.result_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.result_bo)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                self.sparse_bo_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );

        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        self.sparse_bo = sparse_bo;
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = self.page_size as u32;
        let mut result = true;

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.sparse_bo)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.sparse_bo)
        );

        for n_iteration in 0..3u32 {
            let mut result_local = true;
            let is_zigzag_ssbo = n_iteration == 1;
            let ssbo_commit_size = self.sparse_bo_size_rounded;
            let ssbo_commit_start_offset = 0u32;

            if n_iteration < 2 {
                if is_zigzag_ssbo {
                    let n_pages = ssbo_commit_size / page_size;

                    for n_page in (0..n_pages).step_by(2) {
                        // SAFETY: the errors of the commits are checked once after the loop, as upstream does.
                        unsafe {
                            gl.buffer_page_commitment_arb(
                                glw::GL_SHADER_STORAGE_BUFFER,
                                (page_size * n_page) as glw::GLintptr,
                                page_size as glw::GLsizeiptr,
                                glw::GL_TRUE as glw::GLboolean,
                            )
                        };
                    }
                } else {
                    // SAFETY: as above.
                    unsafe {
                        gl.buffer_page_commitment_arb(
                            glw::GL_SHADER_STORAGE_BUFFER,
                            0,
                            ssbo_commit_size as glw::GLintptr,
                            glw::GL_TRUE as glw::GLboolean,
                        )
                    };
                }
                crate::glu::expect_no_error(gl, "glBufferPageCommitmentARB() call(s) failed.")?;
            }

            gl_call!(gl, "glBindBuffer() call(s) failed.", {
                gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo);
                gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.sparse_bo);
            });
            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_COPY_WRITE_BUFFER,
                    0,
                    0,
                    self.sparse_bo_size as GLsizeiptr
                )
            );
            gl_call!(
                gl,
                "glDispatchCompute() call failed.",
                gl.dispatch_compute(self.sparse_bo_size / self.po_local_wg_size, 1, 1)
            );
            gl_call!(
                gl,
                "glMemoryBarrier() call failed.",
                gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
            );
            gl_call!(gl, "glBindBuffer() call(s) failed.", {
                gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.sparse_bo);
                gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.result_bo);
            });
            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_COPY_WRITE_BUFFER,
                    0,
                    0,
                    self.sparse_bo_size as GLsizeiptr
                )
            );

            // SAFETY: a read-only mapping of the result buffer.
            let mapped = unsafe { gl.map_buffer(glw::GL_COPY_WRITE_BUFFER, glw::GL_READ_ONLY) };
            crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

            if mapped.is_null() {
                return Ok(false);
            }

            // SAFETY: the mapping holds `sparse_bo_size` bytes and stays valid until the unmap below.
            let ssbo_data =
                unsafe { std::slice::from_raw_parts(mapped.cast::<u32>(), self.sparse_bo_size as usize / 4) };

            let mut current_ssbo_offset = 0u32;
            let mut n_invocation = 0u32;

            while current_ssbo_offset < self.sparse_bo_size && result_local {
                let n_page = current_ssbo_offset / page_size;

                if (is_zigzag_ssbo && n_page.is_multiple_of(2))
                    || (!is_zigzag_ssbo
                        && current_ssbo_offset >= ssbo_commit_start_offset
                        && current_ssbo_offset < ssbo_commit_start_offset + ssbo_commit_size)
                {
                    let found = ssbo_data[n_invocation as usize * 4];

                    if found != n_invocation + 1 {
                        log::info!(
                            "Value written to the SSBO at byte [{}] is invalid. Found:[{found}], expected:[{}]",
                            4 * n_invocation,
                            n_invocation + 1
                        );
                        result_local = false;
                    }
                }

                n_invocation += 1;
                current_ssbo_offset += 4 * 4;
            }

            result &= result_local;

            gl_call!(
                gl,
                "glUnmapBuffer() call failed.",
                gl.unmap_buffer(glw::GL_COPY_WRITE_BUFFER)
            );
            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    0,
                    self.sparse_bo_size_rounded as glw::GLintptr,
                    glw::GL_FALSE as glw::GLboolean
                )
            );
        }

        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

const UNIFORM_VS_PREAMBLE: &str = "#version 140\n\n";
const UNIFORM_VS_MAIN: &str = "\nlayout(std140) uniform data\n{\n    uint data_input[N_UBO_UINTS];};\n\nout uint result;\n\nvoid main()\n{\n    result = (data_input[gl_VertexID] == uint(gl_VertexID) ) ? 1u : 0u;\n}";

/// `UniformBufferStorageTestCase`
struct UniformBuffer<'a> {
    context: &'a Context,
    gl_uniform_buffer_offset_alignment_value: GLint,
    helper_bo: GLuint,
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    n_pages_to_use: u32,
    n_ubo_uints: u32,
    po: GLuint,
    sparse_bo: GLuint,
    sparse_bo_data_size: u32,
    sparse_bo_data_start_offset: u32,
    sparse_bo_size: u32,
    sparse_bo_size_rounded: u32,
    tf_bo: GLuint,
    vao: GLuint,
    page_size: GLint,
}

impl<'a> UniformBuffer<'a> {
    fn new(context: &'a Context) -> Self {
        Self {
            context,
            gl_uniform_buffer_offset_alignment_value: 0,
            helper_bo: 0,
            n_pages_to_use: 4,
            n_ubo_uints: 0,
            po: 0,
            sparse_bo: 0,
            sparse_bo_data_size: 0,
            sparse_bo_data_start_offset: 0,
            sparse_bo_size: 0,
            sparse_bo_size_rounded: 0,
            tf_bo: 0,
            vao: 0,
            page_size: 0,
        }
    }
}

impl Drop for UniformBuffer<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.po != 0 {
                gl.delete_program(self.po);
            }
            if self.tf_bo != 0 {
                gl.delete_buffers(1, &self.tf_bo);
            }
            if self.vao != 0 {
                gl.delete_vertex_arrays(1, &self.vao);
            }
        }
    }
}

impl StorageCase for UniformBuffer<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.page_size = check_page_size(self.context)?;

        let mut gl_max_uniform_block_size_value: GLint = 0;
        gl_call!(gl, "glGetIntegerv() call(s) failed.", {
            gl.get_integerv(glw::GL_MAX_UNIFORM_BLOCK_SIZE, &mut gl_max_uniform_block_size_value);
            gl.get_integerv(
                glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT,
                &mut self.gl_uniform_buffer_offset_alignment_value,
            );
        });

        self.n_ubo_uints = (gl_max_uniform_block_size_value / (4 * 4)) as u32;

        let vs_body_define = format!("#define N_UBO_UINTS ({})\n", self.n_ubo_uints);
        self.po = create_vertex_program(
            self.context,
            &[UNIFORM_VS_PREAMBLE, &vs_body_define, UNIFORM_VS_MAIN],
            &["result"],
            glw::GL_INTERLEAVED_ATTRIBS,
        )?;

        if self.po == 0 {
            return fail("The test program failed to link");
        }

        self.sparse_bo_data_size = 4 * self.page_size as u32;
        self.sparse_bo_size = (self.page_size * self.gl_uniform_buffer_offset_alignment_value) as u32 * 2;

        if self.sparse_bo_size < self.sparse_bo_data_size * 2 {
            self.sparse_bo_size = self.sparse_bo_data_size * 2;
        }

        self.sparse_bo_size_rounded = self.sparse_bo_size;
        self.sparse_bo_data_start_offset = (self.sparse_bo_size - self.sparse_bo_data_size) / 2;

        let tfbo_size = 4 * self.n_ubo_uints;
        gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.tf_bo));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.tf_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                tfbo_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_MAP_READ_BIT
            )
        );

        let mut ubo_data = vec![0u32; self.sparse_bo_data_size as usize / 4];
        for n_vertex in 0..self.sparse_bo_data_size as usize / (4 * 4) {
            ubo_data[n_vertex * 4] = n_vertex as u32;
        }

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_COPY_READ_BUFFER,
                self.sparse_bo_data_size as GLsizeiptr,
                ubo_data.as_ptr().cast(),
                0
            )
        );

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao)
        );
        gl_call!(gl, "glBindVertexArray() call failed.", gl.bind_vertex_array(self.vao));

        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.sparse_bo = sparse_bo;

        gl_call!(
            gl,
            "glBindBuffer() call(s) failed.",
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.sparse_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.tf_bo)
        );
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut result = true;

        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_range(
                glw::GL_UNIFORM_BUFFER,
                0,
                self.sparse_bo,
                self.sparse_bo_data_start_offset as glw::GLintptr,
                (self.n_ubo_uints * 4 * 4) as GLsizeiptr
            )
        );

        for n_iteration in 0..3u32 {
            let mut result_local = true;
            let (ubo_commit_size, ubo_commit_start_offset) = match n_iteration {
                0 => (self.sparse_bo_data_size, self.sparse_bo_data_start_offset),
                1 => (self.sparse_bo_data_size / 2, self.sparse_bo_data_start_offset),
                _ => (0, 0),
            };

            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_UNIFORM_BUFFER,
                    ubo_commit_start_offset as glw::GLintptr,
                    ubo_commit_size as glw::GLsizeiptr,
                    glw::GL_TRUE as glw::GLboolean
                )
            );
            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_COPY_WRITE_BUFFER,
                    0,
                    ubo_commit_start_offset as glw::GLintptr,
                    ubo_commit_size as GLsizeiptr
                )
            );
            gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po));
            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.tf_bo)
            );
            gl_call!(
                gl,
                "glBindBufferBase() call failed.",
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.tf_bo)
            );
            gl_call!(
                gl,
                "glBeginTransformFeedback() call failed.",
                gl.begin_transform_feedback(glw::GL_POINTS)
            );
            gl_call!(
                gl,
                "glDrawArrays() call failed.",
                gl.draw_arrays(glw::GL_POINTS, 0, self.n_ubo_uints as GLsizei)
            );
            gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());

            // SAFETY: a read-only mapping of the transform feedback buffer.
            let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
            crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

            if mapped.is_null() {
                return Ok(false);
            }

            // SAFETY: the mapping holds `n_ubo_uints` words and stays valid until the unmap below.
            let result_data = unsafe { std::slice::from_raw_parts(mapped.cast::<u32>(), self.n_ubo_uints as usize) };

            let mut ubo_data_offset = self.sparse_bo_data_start_offset;

            for n_vertex in 0..self.n_ubo_uints {
                if !result_local {
                    break;
                }

                let is_ub_data_physically_backed = ubo_data_offset >= ubo_commit_start_offset
                    && ubo_data_offset < ubo_commit_start_offset + ubo_commit_size;
                let retrieved_value = result_data[n_vertex as usize];

                if is_ub_data_physically_backed && retrieved_value != 1 {
                    log::info!(
                        "Invalid value ({retrieved_value}) found at index ({n_vertex}), instead of the expected value (1). Iteration index:({n_iteration})"
                    );
                    result_local = false;
                }

                ubo_data_offset += 4 * 4;
            }

            result &= result_local;

            let data_zero_r8: u8 = 0;
            gl_call!(
                gl,
                "glUnmapBuffer() call failed.",
                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
            );
            gl_call!(
                gl,
                "glClearBufferData() call failed.",
                gl.clear_buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    glw::GL_R8,
                    glw::GL_RED,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::from_ref(&data_zero_r8).cast()
                )
            );
            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_UNIFORM_BUFFER,
                    0,
                    self.sparse_bo_size_rounded as glw::GLintptr,
                    glw::GL_FALSE as glw::GLboolean
                )
            );
        }

        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

const QUERY_VS: &str = "#version 140\n\nvoid main()\n{\n    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n}\n";

/// `QueryBufferStorageTestCase`
struct Query<'a> {
    context: &'a Context,
    helper_bo: GLuint,
    n_triangles: u32,
    po: GLuint,
    qo: GLuint,
    sparse_bo: GLuint,
    sparse_bo_size_rounded: u32,
    vao: GLuint,
}

impl<'a> Query<'a> {
    fn new(context: &'a Context) -> Self {
        Self {
            context,
            helper_bo: 0,
            n_triangles: 15,
            po: 0,
            qo: 0,
            sparse_bo: 0,
            sparse_bo_size_rounded: 0,
            vao: 0,
        }
    }
}

impl Drop for Query<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.po != 0 {
                gl.delete_program(self.po);
            }
            if self.qo != 0 {
                gl.delete_queries(1, &self.qo);
            }
            if self.vao != 0 {
                gl.delete_vertex_arrays(1, &self.vao);
            }
        }
    }
}

impl StorageCase for Query<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = check_page_size(self.context)?;

        self.sparse_bo_size_rounded = align_offset(8, page_size as u32);

        self.po = create_vertex_program(self.context, &[QUERY_VS], &[], glw::GL_INTERLEAVED_ATTRIBS)?;
        if self.po == 0 {
            return fail("Test program linking failure");
        }

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(glw::GL_COPY_WRITE_BUFFER, 8, std::ptr::null(), glw::GL_MAP_READ_BIT)
        );
        gl_call!(gl, "glGenQueries() call failed.", gl.gen_queries(1, &mut self.qo));
        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao)
        );
        gl_call!(gl, "glBindVertexArray() call failed.", gl.bind_vertex_array(self.vao));

        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.sparse_bo = sparse_bo;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_QUERY_BUFFER, self.sparse_bo)
        );
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let data_r8_zero: u8 = 0;
        let mut result = true;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.sparse_bo)
        );
        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po));

        for n_iteration in 0..2 {
            let should_commit_page = n_iteration == 0;

            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_QUERY_BUFFER,
                    0,
                    self.sparse_bo_size_rounded as glw::GLintptr,
                    if should_commit_page {
                        glw::GL_TRUE as glw::GLboolean
                    } else {
                        glw::GL_FALSE as glw::GLboolean
                    }
                )
            );
            gl_call!(
                gl,
                "glBeginQuery() call failed.",
                gl.begin_query(glw::GL_PRIMITIVES_GENERATED, self.qo)
            );
            gl_call!(
                gl,
                "glDrawArrays() call failed.",
                gl.draw_arrays(glw::GL_TRIANGLES, 0, self.n_triangles as GLsizei * 3)
            );
            gl_call!(
                gl,
                "glEndQuery() call failed.",
                gl.end_query(glw::GL_PRIMITIVES_GENERATED)
            );

            for n_getter_call in 0..4 {
                let result_n_bytes: GLsizeiptr = match n_getter_call {
                    0 => {
                        gl_call!(
                            gl,
                            "glGetQueryObjectiv() call failed.",
                            gl.get_query_objectiv(self.qo, glw::GL_QUERY_RESULT, std::ptr::null_mut())
                        );
                        4
                    }
                    1 => {
                        gl_call!(
                            gl,
                            "glGetQueryObjectuiv() call failed.",
                            gl.get_query_objectuiv(self.qo, glw::GL_QUERY_RESULT, std::ptr::null_mut())
                        );
                        4
                    }
                    // glw has no glGetQueryObjecti64v / glGetQueryObjectui64v, so the two 64-bit getter calls of upstream are skipped
                    _ => continue,
                };

                if should_commit_page {
                    gl_call!(
                        gl,
                        "glBindBuffer() call failed.",
                        gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.helper_bo)
                    );
                    gl_call!(
                        gl,
                        "glClearBufferData() call failed.",
                        gl.clear_buffer_data(
                            glw::GL_COPY_WRITE_BUFFER,
                            glw::GL_R8,
                            glw::GL_RED,
                            glw::GL_UNSIGNED_BYTE,
                            std::ptr::from_ref(&data_r8_zero).cast()
                        )
                    );
                    gl_call!(
                        gl,
                        "glCopyBufferSubData() call failed.",
                        gl.copy_buffer_sub_data(
                            glw::GL_COPY_READ_BUFFER,
                            glw::GL_COPY_WRITE_BUFFER,
                            0,
                            0,
                            result_n_bytes
                        )
                    );

                    // SAFETY: a read-only mapping of the eight bytes of the helper buffer.
                    let result_ptr = unsafe { gl.map_buffer(glw::GL_COPY_WRITE_BUFFER, glw::GL_READ_ONLY) };
                    crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

                    if result_ptr.is_null() {
                        return Ok(false);
                    }

                    // SAFETY: the mapping is eight bytes long and stays valid until the unmap below.
                    let found = unsafe { result_ptr.cast::<i64>().read_unaligned() };

                    if found != self.n_triangles as i64 {
                        log::info!(
                            "Invalid query result stored in a sparse buffer. Found: [{found}], expected: [{}]",
                            self.n_triangles
                        );
                        result = false;
                    }

                    gl_call!(
                        gl,
                        "glUnmapBuffer() call failed.",
                        gl.unmap_buffer(glw::GL_COPY_WRITE_BUFFER)
                    );
                }
            }
        }

        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

const BUFFER_TEXTURE_CS: &str = "#version 430 core\n\nlayout(local_size_x = 1024) in;\n\nlayout(std140, binding = 0) buffer data\n{\n    restrict writeonly int result[];\n};\n\nuniform samplerBuffer input_texture;\n\nvoid main()\n{\n    uint texel_index = gl_GlobalInvocationID.x;\n\n    if (texel_index < 65536)\n    {\n        vec4 expected_texel_data = vec4       (float((texel_index)       % 255) / 255.0,\n                                               float((texel_index + 35)  % 255) / 255.0,\n                                               float((texel_index + 78)  % 255) / 255.0,\n                                               float((texel_index + 131) % 255) / 255.0);\n        vec4 texel_data          = texelFetch(input_texture, int(texel_index) );\n\n        if (abs(texel_data.r - expected_texel_data.r) > 1.0 / 255.0 ||\n            abs(texel_data.g - expected_texel_data.g) > 1.0 / 255.0 ||\n            abs(texel_data.b - expected_texel_data.b) > 1.0 / 255.0 ||\n            abs(texel_data.a - expected_texel_data.a) > 1.0 / 255.0)\n        {\n            result[texel_index] = 0;\n        }\n        else\n        {\n            result[texel_index] = 1;\n        }\n    }\n}\n";

/// `BufferTextureStorageTestCase`
struct BufferTexture<'a> {
    context: &'a Context,
    helper_bo: GLuint,
    helper_bo_data_size: u32,
    is_texture_buffer_range_supported: bool,
    po: GLuint,
    po_local_wg_size: u32,
    sparse_bo: GLuint,
    sparse_bo_size: u32,
    sparse_bo_size_rounded: u32,
    ssbo: GLuint,
    ssbo_zero_data: Vec<u8>,
    to: GLuint,
    to_width: u32,
}

impl<'a> BufferTexture<'a> {
    fn new(context: &'a Context) -> Self {
        let is_texture_buffer_range_supported = context.context_type().supports_core(4, 3)
            || context
                .context_info
                .is_extension_supported("GL_ARB_texture_buffer_range");

        Self {
            context,
            helper_bo: 0,
            helper_bo_data_size: 0,
            is_texture_buffer_range_supported,
            po: 0,
            po_local_wg_size: 1024,
            sparse_bo: 0,
            sparse_bo_size: 0,
            sparse_bo_size_rounded: 0,
            ssbo: 0,
            ssbo_zero_data: Vec::new(),
            to: 0,
            to_width: 65536,
        }
    }
}

impl Drop for BufferTexture<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            for bo in [self.helper_bo, self.ssbo] {
                if bo != 0 {
                    gl.delete_buffers(1, &bo);
                }
            }
            if self.po != 0 {
                gl.delete_program(self.po);
            }
            if self.to != 0 {
                gl.delete_textures(1, &self.to);
            }
        }
    }
}

impl StorageCase for BufferTexture<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = check_page_size(self.context)?;

        self.po = create_compute_program(self.context, &[BUFFER_TEXTURE_CS])?;

        self.ssbo_zero_data = vec![0u8; 4 * 4 * self.to_width as usize];

        gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.ssbo));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.ssbo)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                self.ssbo_zero_data.len() as GLsizeiptr,
                self.ssbo_zero_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        self.helper_bo_data_size = self.to_width * 4;
        let mut helper_bo_data = Vec::with_capacity(self.helper_bo_data_size as usize);

        for n_texel in 0..self.to_width {
            helper_bo_data.push((n_texel % 255) as u8);
            helper_bo_data.push(((n_texel + 35) % 255) as u8);
            helper_bo_data.push(((n_texel + 78) % 255) as u8);
            helper_bo_data.push(((n_texel + 131) % 255) as u8);
        }

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_COPY_READ_BUFFER,
                self.helper_bo_data_size as GLsizeiptr,
                helper_bo_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(gl, "glGenTextures() call failed.", gl.gen_textures(1, &mut self.to));
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.to)
        );

        self.sparse_bo_size = self.to_width * 4;
        self.sparse_bo_size_rounded = align_offset(self.sparse_bo_size, page_size as u32);
        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        self.sparse_bo = sparse_bo;
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut result = true;

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.ssbo)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.ssbo)
        );
        gl_call!(gl, "glBindBuffer() call(s) failed.", {
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo);
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.sparse_bo);
        });

        for n_iteration in 0..2 {
            for n_entry_point in 0..(if self.is_texture_buffer_range_supported { 2 } else { 1 }) {
                let mut result_local = true;

                let tbo_commit_start_offset = if n_iteration == 0 {
                    0
                } else {
                    self.sparse_bo_size_rounded / 2
                };
                let tbo_commit_size = if n_iteration == 0 {
                    self.sparse_bo_size_rounded
                } else {
                    self.sparse_bo_size_rounded / 2
                };

                gl_call!(
                    gl,
                    "glBindBuffer() call failed.",
                    gl.bind_buffer(glw::GL_TEXTURE_BUFFER, self.sparse_bo)
                );
                gl_call!(
                    gl,
                    "glBufferPageCommitmentARB() call failed.",
                    gl.buffer_page_commitment_arb(
                        glw::GL_TEXTURE_BUFFER,
                        tbo_commit_start_offset as glw::GLintptr,
                        tbo_commit_size as GLsizeiptr,
                        glw::GL_TRUE as glw::GLboolean
                    )
                );

                if n_entry_point == 0 {
                    gl_call!(
                        gl,
                        "glTexBuffer() call failed.",
                        gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGBA8, self.sparse_bo)
                    );
                } else {
                    gl_call!(
                        gl,
                        "glTexBufferRange() call failed.",
                        gl.tex_buffer_range(
                            glw::GL_TEXTURE_BUFFER,
                            glw::GL_RGBA8,
                            self.sparse_bo,
                            0,
                            self.sparse_bo_size as GLsizeiptr
                        )
                    );
                }

                gl_call!(
                    gl,
                    "glCopyBufferSubData() call failed.",
                    gl.copy_buffer_sub_data(
                        glw::GL_COPY_READ_BUFFER,
                        glw::GL_COPY_WRITE_BUFFER,
                        0,
                        0,
                        self.helper_bo_data_size as GLsizeiptr
                    )
                );
                gl_call!(
                    gl,
                    "glDispatchCompute() call failed.",
                    gl.dispatch_compute(self.to_width / self.po_local_wg_size, 1, 1)
                );
                gl_call!(
                    gl,
                    "glMemoryBarrier() call failed.",
                    gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
                );

                // SAFETY: a read-only mapping of the SSBO, which holds `to_width` std140 results of four words.
                let mapped = unsafe { gl.map_buffer(glw::GL_SHADER_STORAGE_BUFFER, glw::GL_READ_ONLY) };
                crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

                if mapped.is_null() {
                    return Ok(false);
                }

                // SAFETY: the mapping holds `4 * to_width` words and stays valid until the unmap below.
                let ssbo_data = unsafe { std::slice::from_raw_parts(mapped.cast::<u32>(), self.to_width as usize * 4) };

                let mut current_tb_offset = 0u32;

                for n_texel in 0..self.to_width {
                    if !result_local {
                        break;
                    }

                    if current_tb_offset >= tbo_commit_start_offset
                        && current_tb_offset < tbo_commit_start_offset + tbo_commit_size
                        && ssbo_data[n_texel as usize * 4] != 1
                    {
                        log::info!(
                            "A texel read from the texture buffer at index [{n_texel}] was marked as invalid by the CS invocation."
                        );
                        result_local = false;
                    }

                    current_tb_offset += 4;
                }

                result &= result_local;

                gl_call!(
                    gl,
                    "glUnmapBuffer() call failed.",
                    gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER)
                );
                gl_call!(
                    gl,
                    "glBufferPageCommitmentARB() call failed.",
                    gl.buffer_page_commitment_arb(
                        glw::GL_TEXTURE_BUFFER,
                        0,
                        self.sparse_bo_size_rounded as glw::GLintptr,
                        glw::GL_FALSE as glw::GLboolean
                    )
                );
                gl_call!(
                    gl,
                    "glBufferSubData() call failed.",
                    gl.buffer_sub_data(
                        glw::GL_SHADER_STORAGE_BUFFER,
                        0,
                        self.ssbo_zero_data.len() as GLsizeiptr,
                        self.ssbo_zero_data.as_ptr().cast()
                    )
                );
            }
        }

        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

const ATOMIC_COUNTER_VS_PREAMBLE: &str = "#version 430 core\n\n";
const ATOMIC_COUNTER_VS_CORE: &str = "layout(binding = 0) uniform atomic_uint counters[N_COUNTERS];\n\nvoid main()\n{\n    for (uint n = 0; n < N_COUNTERS; ++n)\n    {\n        if (n == gl_VertexID)\n        {\n            atomicCounterIncrement(counters[n]);\n        }\n    }\n\n    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n}\n";

/// `AtomicCounterBufferStorageTestCase`
struct AtomicCounter<'a> {
    context: &'a Context,
    all_pages_committed: bool,
    gl_atomic_counter_uniform_array_stride: GLint,
    gl_max_vertex_atomic_counters_value: GLint,
    helper_bo: GLuint,
    helper_bo_size: u32,
    helper_bo_size_rounded: u32,
    n_draw_calls: GLsizei,
    page_size: GLint,
    po: GLuint,
    sparse_bo: GLuint,
    sparse_bo_data_size: u32,
    sparse_bo_data_size_rounded: u32,
    sparse_bo_data_start_offset: u32,
    sparse_bo_data_start_offset_rounded: u32,
    vao: GLuint,
}

impl<'a> AtomicCounter<'a> {
    fn new(context: &'a Context, all_pages_committed: bool) -> Self {
        Self {
            context,
            all_pages_committed,
            gl_atomic_counter_uniform_array_stride: 0,
            gl_max_vertex_atomic_counters_value: 0,
            helper_bo: 0,
            helper_bo_size: 0,
            helper_bo_size_rounded: 0,
            n_draw_calls: 3,
            page_size: 0,
            po: 0,
            sparse_bo: 0,
            sparse_bo_data_size: 0,
            sparse_bo_data_size_rounded: 0,
            sparse_bo_data_start_offset: 0,
            sparse_bo_data_start_offset_rounded: 0,
            vao: 0,
        }
    }
}

impl Drop for AtomicCounter<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.po != 0 {
                gl.delete_program(self.po);
            }
            if self.vao != 0 {
                gl.delete_vertex_arrays(1, &self.vao);
            }
        }
    }
}

impl StorageCase for AtomicCounter<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let ac_uniform_index: GLuint = 0;

        self.page_size = check_page_size(self.context)?;

        gl_call!(
            gl,
            "glGetIntegerv() call failed.",
            gl.get_integerv(
                glw::GL_MAX_VERTEX_ATOMIC_COUNTERS,
                &mut self.gl_max_vertex_atomic_counters_value
            )
        );

        if self.gl_max_vertex_atomic_counters_value == 0 {
            return Ok(true);
        }

        let n_counters = format!("#define N_COUNTERS {}\n", self.gl_max_vertex_atomic_counters_value);
        self.po = create_vertex_program(
            self.context,
            &[ATOMIC_COUNTER_VS_PREAMBLE, &n_counters, ATOMIC_COUNTER_VS_CORE],
            &[],
            glw::GL_INTERLEAVED_ATTRIBS,
        )?;

        if self.po == 0 {
            return Ok(false);
        }

        gl_call!(
            gl,
            "glGetActiveUniformsiv() call failed.",
            gl.get_active_uniformsiv(
                self.po,
                1,
                &ac_uniform_index,
                glw::GL_UNIFORM_ARRAY_STRIDE,
                &mut self.gl_atomic_counter_uniform_array_stride
            )
        );

        self.helper_bo_size =
            (self.gl_atomic_counter_uniform_array_stride * self.gl_max_vertex_atomic_counters_value) as u32;
        self.helper_bo_size_rounded = align_offset(self.helper_bo_size, self.page_size as u32);

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_COPY_READ_BUFFER,
                self.helper_bo_size_rounded as GLsizeiptr,
                std::ptr::null(),
                glw::GL_MAP_READ_BIT
            )
        );
        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao)
        );
        gl_call!(gl, "glBindVertexArray() call failed.", gl.bind_vertex_array(self.vao));

        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = self.page_size as u32;

        self.sparse_bo = sparse_bo;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.sparse_bo)
        );

        let sparse_bo_data_size = if self.all_pages_committed {
            self.helper_bo_size_rounded
        } else {
            (self.helper_bo_size_rounded / page_size) * page_size / 2
        };

        let sparse_bo_data_start_offset = page_size.wrapping_sub(self.helper_bo_size_rounded / 2) as i32;
        let mut sparse_bo_data_start_offset_minus_page = sparse_bo_data_start_offset.wrapping_sub(self.page_size);

        if sparse_bo_data_start_offset_minus_page < 0 {
            sparse_bo_data_start_offset_minus_page = 0;
        }

        self.sparse_bo_data_start_offset = sparse_bo_data_start_offset as u32;
        self.sparse_bo_data_start_offset_rounded =
            align_offset(sparse_bo_data_start_offset_minus_page as u32, page_size);
        self.sparse_bo_data_size = sparse_bo_data_size;
        self.sparse_bo_data_size_rounded = align_offset(
            self.sparse_bo_data_start_offset.wrapping_add(sparse_bo_data_size),
            page_size,
        );

        gl_call!(
            gl,
            "glBufferPageCommitmentARB() call failed.",
            gl.buffer_page_commitment_arb(
                glw::GL_ARRAY_BUFFER,
                self.sparse_bo_data_start_offset_rounded as glw::GLintptr,
                self.sparse_bo_data_size_rounded as GLsizeiptr,
                glw::GL_TRUE as glw::GLboolean
            )
        );

        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let data_zero: u8 = 0;
        let mut result = true;

        if self.gl_max_vertex_atomic_counters_value == 0 {
            log::info!("G_MAX_VERTEX_ATOMIC_COUNTERS is 0. Skipping the test.");
            return Ok(result);
        }

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.sparse_bo)
        );

        for n_binding_type in (if self.all_pages_committed { 0 } else { 1 })..2 {
            let mut result_local = true;

            if n_binding_type == 0 {
                gl_call!(
                    gl,
                    "glBindBufferBase() call failed.",
                    gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.sparse_bo)
                );
            } else {
                gl_call!(
                    gl,
                    "glBindBufferRange() call failed.",
                    gl.bind_buffer_range(
                        glw::GL_ATOMIC_COUNTER_BUFFER,
                        0,
                        self.sparse_bo,
                        self.sparse_bo_data_start_offset as glw::GLintptr,
                        self.helper_bo_size as GLsizeiptr
                    )
                );
            }

            gl_call!(
                gl,
                "glClearBufferData() call failed.",
                gl.clear_buffer_data(
                    glw::GL_ATOMIC_COUNTER_BUFFER,
                    glw::GL_R8,
                    glw::GL_RED,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::from_ref(&data_zero).cast()
                )
            );
            gl_call!(
                gl,
                "glDrawArraysInstanced() call failed",
                gl.draw_arrays_instanced(
                    glw::GL_POINTS,
                    0,
                    self.gl_max_vertex_atomic_counters_value,
                    self.n_draw_calls
                )
            );

            let n_expected_written_values = (if self.all_pages_committed {
                self.gl_max_vertex_atomic_counters_value
            } else {
                self.gl_max_vertex_atomic_counters_value / 2
            }) as u32;

            gl_call!(gl, "glBindBuffeR() call failed", {
                gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.sparse_bo);
                gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.helper_bo);
            });
            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_COPY_WRITE_BUFFER,
                    if n_binding_type == 0 {
                        0
                    } else {
                        self.sparse_bo_data_start_offset as glw::GLintptr
                    },
                    0,
                    self.sparse_bo_data_size as GLsizeiptr
                )
            );

            // SAFETY: a read-only mapping of the helper buffer.
            let mapped = unsafe {
                gl.map_buffer_range(
                    glw::GL_COPY_WRITE_BUFFER,
                    0,
                    self.sparse_bo_data_size as GLsizeiptr,
                    glw::GL_MAP_READ_BIT,
                )
            };
            crate::glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;

            if mapped.is_null() {
                return Ok(false);
            }

            for n_counter in 0..n_expected_written_values {
                if !result_local {
                    break;
                }

                let expected_value = self.n_draw_calls as u32;
                // SAFETY: upstream reads the counter at this byte offset of the mapping, which `glCopyBufferSubData` filled.
                let retrieved_value = unsafe {
                    mapped
                        .cast::<u8>()
                        .add(self.gl_atomic_counter_uniform_array_stride as usize * n_counter as usize)
                        .cast::<u32>()
                        .read_unaligned()
                };

                if expected_value != retrieved_value {
                    log::info!(
                        "Invalid atomic counter value [{retrieved_value}] instead of the expected value [{expected_value}] at index {n_counter} when using {} for AC binding configuration",
                        if n_binding_type == 0 {
                            "glBindBufferBase()"
                        } else {
                            "glBindBufferRange()"
                        }
                    );
                    result_local = false;
                }
            }

            gl_call!(
                gl,
                "glUnmapBuffer() call failed.",
                gl.unmap_buffer(glw::GL_COPY_WRITE_BUFFER)
            );
            result &= result_local;
        }

        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        if self.sparse_bo != 0 {
            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.sparse_bo)
            );
            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_ARRAY_BUFFER,
                    self.sparse_bo_data_start_offset_rounded as glw::GLintptr,
                    self.sparse_bo_data_size_rounded as GLsizeiptr,
                    glw::GL_FALSE as glw::GLboolean
                )
            );
            self.sparse_bo = 0;
        }

        Ok(())
    }
}

const PIXEL_PACK_FS: &str = "#version 330 core\n\nout vec4 result;\n\nvoid main()\n{\n    float c = 1.0 - (gl_FragCoord.y - 0.5) / 1023.0;\n    result  = vec4(c);\n}\n";
const PIXEL_PACK_VS: &str = "#version 330\n\nvoid main()\n{\n    switch (gl_VertexID)\n    {\n        case 0: gl_Position = vec4(-1.0, -1.0, 0.0, 1.0); break;\n        case 1: gl_Position = vec4( 1.0, -1.0, 0.0, 1.0); break;\n        case 2: gl_Position = vec4(-1.0,  1.0, 0.0, 1.0); break;\n        case 3: gl_Position = vec4( 1.0,  1.0, 0.0, 1.0); break;\n    }\n}\n";

/// `PixelPackBufferStorageTestCase`
struct PixelPack<'a> {
    context: &'a Context,
    color_rb: GLuint,
    color_rb_height: GLsizei,
    color_rb_width: GLsizei,
    fbo: GLuint,
    helper_bo: GLuint,
    po: GLuint,
    ref_data: Vec<u8>,
    ref_data_size: u32,
    sparse_bo: GLuint,
    sparse_bo_size_rounded: u32,
    vao: GLuint,
    page_size: GLint,
}

impl<'a> PixelPack<'a> {
    fn new(context: &'a Context) -> Self {
        Self {
            context,
            color_rb: 0,
            color_rb_height: 1024,
            color_rb_width: 1024,
            fbo: 0,
            helper_bo: 0,
            po: 0,
            ref_data: Vec::new(),
            ref_data_size: 1024 * 1024 * 4,
            sparse_bo: 0,
            sparse_bo_size_rounded: 0,
            vao: 0,
            page_size: 0,
        }
    }
}

impl Drop for PixelPack<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.color_rb != 0 {
                gl.delete_renderbuffers(1, &self.color_rb);
            }
            if self.fbo != 0 {
                gl.delete_framebuffers(1, &self.fbo);
            }
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.po != 0 {
                gl.delete_program(self.po);
            }
            if self.vao != 0 {
                gl.delete_vertex_arrays(1, &self.vao);
            }
        }
    }
}

impl StorageCase for PixelPack<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.page_size = check_page_size(self.context)?;

        self.po = create_program(self.context, &[PIXEL_PACK_FS], &[PIXEL_PACK_VS], &[], &[], glw::GL_NONE)?;
        if self.po == 0 {
            return fail("Failed to link the test program");
        }

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao)
        );
        gl_call!(gl, "glBindVertexArray() call failed.", gl.bind_vertex_array(self.vao));
        gl_call!(
            gl,
            "glGenFramebuffers() call failed.",
            gl.gen_framebuffers(1, &mut self.fbo)
        );
        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo)
        );
        gl_call!(
            gl,
            "glReadBuffer() call failed.",
            gl.read_buffer(glw::GL_COLOR_ATTACHMENT0)
        );
        gl_call!(
            gl,
            "glGenRenderbuffers() call failed.",
            gl.gen_renderbuffers(1, &mut self.color_rb)
        );
        gl_call!(
            gl,
            "glBindRenderbuffer() call failed.",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, self.color_rb)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage() call failed.",
            gl.renderbuffer_storage(
                glw::GL_RENDERBUFFER,
                glw::GL_RGBA8,
                self.color_rb_width,
                self.color_rb_height
            )
        );
        gl_call!(
            gl,
            "glFramebufferRenderbuffer() call failed.",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                self.color_rb
            )
        );

        // SAFETY: plain state query.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::NotSupported("Cannot execute the test - driver does not support renderingto a GL_RGBA8 renderbuffer-based color attachment".to_string()));
        }

        gl_call!(
            gl,
            "glViewport() call failed.",
            gl.viewport(0, 0, self.color_rb_width, self.color_rb_height)
        );

        self.sparse_bo_size_rounded = align_offset(self.ref_data_size, self.page_size as u32);

        self.ref_data = Vec::with_capacity(self.ref_data_size as usize);
        for y in 0..self.color_rb_height {
            let color = ((1.0 - y as f32 / (self.color_rb_height - 1) as f32) * 255.0) as u8;

            for _ in 0..self.color_rb_width {
                self.ref_data.extend_from_slice(&[color; 4]);
            }
        }

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_COPY_READ_BUFFER,
                self.ref_data_size as GLsizeiptr,
                self.ref_data.as_ptr().cast(),
                glw::GL_MAP_READ_BIT
            )
        );

        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        self.sparse_bo = sparse_bo;
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = self.page_size as u32;
        let mut result = true;

        gl_call!(gl, "glBindBuffer() call(s) failed.", {
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo);
            gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, self.sparse_bo);
        });

        for n_iteration in 0..3u32 {
            let mut result_local = true;

            match n_iteration {
                0 => {
                    gl_call!(
                        gl,
                        "glBufferPageCommitmentARB() call failed.",
                        gl.buffer_page_commitment_arb(
                            glw::GL_PIXEL_PACK_BUFFER,
                            0,
                            self.sparse_bo_size_rounded as glw::GLintptr,
                            glw::GL_TRUE as glw::GLboolean
                        )
                    );
                }
                1 => {
                    let n_pages = 1 + self.ref_data_size / page_size;

                    for n_page in 0..n_pages {
                        let should_commit = n_page % 2 == 0;

                        gl_call!(
                            gl,
                            "glBufferPageCommitmentARB() call failed.",
                            gl.buffer_page_commitment_arb(
                                glw::GL_PIXEL_PACK_BUFFER,
                                (page_size * n_page) as glw::GLintptr,
                                page_size as GLsizeiptr,
                                if should_commit {
                                    glw::GL_TRUE as glw::GLboolean
                                } else {
                                    glw::GL_FALSE as glw::GLboolean
                                }
                            )
                        );
                    }
                }
                _ => {}
            }

            gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po));
            gl_call!(
                gl,
                "glDrawArrays() call failed.",
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4)
            );
            gl_call!(
                gl,
                "glReadPixels() call failed.",
                gl.read_pixels(
                    0,
                    0,
                    self.color_rb_width,
                    self.color_rb_height,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null_mut()
                )
            );
            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(
                    glw::GL_PIXEL_PACK_BUFFER,
                    glw::GL_COPY_READ_BUFFER,
                    0,
                    0,
                    self.ref_data_size as GLsizeiptr
                )
            );

            // SAFETY: a read-only mapping of the helper buffer, which holds `ref_data_size` bytes.
            let mapped = unsafe {
                gl.map_buffer_range(
                    glw::GL_COPY_READ_BUFFER,
                    0,
                    self.ref_data_size as GLsizeiptr,
                    glw::GL_MAP_READ_BIT,
                )
            };
            crate::glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;

            if mapped.is_null() {
                return Ok(false);
            }

            // SAFETY: the mapping is `ref_data_size` bytes long and stays valid until the unmap below.
            let read_data = unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), self.ref_data_size as usize) };

            let mut n_current_tex_data_byte = 0u32;

            'rows: for y in 0..self.color_rb_height {
                for x in 0..self.color_rb_width {
                    for n_component in 0..4 {
                        let byte_index = n_current_tex_data_byte as usize;

                        let is_from_committed_page = match n_iteration {
                            1 => (n_current_tex_data_byte / page_size).is_multiple_of(2),
                            2 => false,
                            _ => true,
                        };

                        let expected_value = if is_from_committed_page {
                            self.ref_data[byte_index]
                        } else {
                            0
                        };

                        if is_from_committed_page && (expected_value as i32 - read_data[byte_index] as i32).abs() > 1 {
                            log::info!(
                                "Invalid texel data (channel:{n_component}) found at X:{x}, Y:{y}). Expected value:{expected_value}, found value:{}",
                                self.ref_data[byte_index]
                            );
                            result_local = false;
                            break 'rows;
                        }

                        n_current_tex_data_byte += 1;
                    }
                }
            }

            gl_call!(
                gl,
                "glUnmapBuffer() call failed.",
                gl.unmap_buffer(glw::GL_COPY_READ_BUFFER)
            );

            result &= result_local;

            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_PIXEL_PACK_BUFFER,
                    0,
                    self.sparse_bo_size_rounded as glw::GLintptr,
                    glw::GL_FALSE as glw::GLboolean
                )
            );
        }

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0)
        );
        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

/// `PixelUnpackBufferStorageTestCase`
struct PixelUnpack<'a> {
    context: &'a Context,
    helper_bo: GLuint,
    sparse_bo: GLuint,
    sparse_bo_size_rounded: u32,
    texture_data: Vec<u8>,
    texture_data_size: u32,
    to: GLuint,
    to_data_zero: Vec<u8>,
    to_height: GLsizei,
    to_width: GLsizei,
    page_size: GLint,
}

impl<'a> PixelUnpack<'a> {
    fn new(context: &'a Context) -> Self {
        Self {
            context,
            helper_bo: 0,
            sparse_bo: 0,
            sparse_bo_size_rounded: 0,
            texture_data: Vec::new(),
            texture_data_size: 1024 * 1024 * 4,
            to: 0,
            to_data_zero: Vec::new(),
            to_height: 1024,
            to_width: 1024,
            page_size: 0,
        }
    }
}

impl Drop for PixelUnpack<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.to != 0 {
                gl.delete_textures(1, &self.to);
            }
        }
    }
}

impl StorageCase for PixelUnpack<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.page_size = check_page_size(self.context)?;
        self.sparse_bo_size_rounded = align_offset(self.texture_data_size, self.page_size as u32);

        self.texture_data = Vec::with_capacity(self.texture_data_size as usize);
        for _y in 0..self.to_height {
            for x in 0..self.to_width {
                let color = (x as f32 / (self.to_width - 1) as f32 * 255.0) as u8;
                self.texture_data.extend_from_slice(&[color; 4]);
            }
        }

        self.to_data_zero = vec![0u8; self.texture_data_size as usize];

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_COPY_READ_BUFFER,
                self.texture_data_size as GLsizeiptr,
                self.texture_data.as_ptr().cast(),
                glw::GL_MAP_READ_BIT
            )
        );
        gl_call!(gl, "glGenTextures() call failed.", gl.gen_textures(1, &mut self.to));
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.to)
        );
        gl_call!(
            gl,
            "glTexStorage2D() call failed.",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, self.to_width, self.to_height)
        );

        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        self.sparse_bo = sparse_bo;
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = self.page_size as u32;
        let mut result = true;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, self.sparse_bo)
        );
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.to)
        );
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );

        for n_iteration in 0..3u32 {
            let mut result_local = true;

            match n_iteration {
                0 => {
                    gl_call!(
                        gl,
                        "glBufferPageCommitmentARB() call failed.",
                        gl.buffer_page_commitment_arb(
                            glw::GL_PIXEL_UNPACK_BUFFER,
                            0,
                            self.sparse_bo_size_rounded as glw::GLintptr,
                            glw::GL_TRUE as glw::GLboolean
                        )
                    );
                    gl_call!(
                        gl,
                        "glCopyBufferSubData() call failed.",
                        gl.copy_buffer_sub_data(
                            glw::GL_COPY_READ_BUFFER,
                            glw::GL_PIXEL_UNPACK_BUFFER,
                            0,
                            0,
                            self.texture_data_size as GLsizeiptr
                        )
                    );
                }
                1 => {
                    let n_pages = self.texture_data_size / page_size;

                    for n_page in 0..n_pages {
                        let should_commit = n_page % 2 == 0;

                        gl_call!(
                            gl,
                            "glBufferPageCommitmentARB() call failed.",
                            gl.buffer_page_commitment_arb(
                                glw::GL_PIXEL_UNPACK_BUFFER,
                                (page_size * n_page) as glw::GLintptr,
                                page_size as GLsizeiptr,
                                if should_commit {
                                    glw::GL_TRUE as glw::GLboolean
                                } else {
                                    glw::GL_FALSE as glw::GLboolean
                                }
                            )
                        );

                        if should_commit {
                            gl_call!(
                                gl,
                                "glCopyBufferSubData() call failed.",
                                gl.copy_buffer_sub_data(
                                    glw::GL_COPY_READ_BUFFER,
                                    glw::GL_PIXEL_UNPACK_BUFFER,
                                    (page_size * n_page) as glw::GLintptr,
                                    (page_size * n_page) as glw::GLintptr,
                                    page_size as GLsizeiptr
                                )
                            );
                        }
                    }
                }
                _ => {}
            }

            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0)
            );
            gl_call!(
                gl,
                "glTexSubImage2D() call failed.",
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    self.to_width,
                    self.to_height,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    self.to_data_zero.as_ptr().cast()
                )
            );
            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, self.sparse_bo)
            );
            gl_call!(
                gl,
                "glTexSubImage2D() call failed.",
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    self.to_width,
                    self.to_height,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null()
                )
            );

            let mut read_data = vec![0xFFu8; self.texture_data_size as usize];
            gl_call!(
                gl,
                "glGetTexImage() call failed.",
                gl.get_tex_image(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    read_data.as_mut_ptr().cast()
                )
            );

            let mut n_current_tex_data_byte = 0u32;

            'rows: for y in 0..self.to_height {
                for x in 0..self.to_width {
                    for n_component in 0..4 {
                        let byte_index = n_current_tex_data_byte as usize;

                        let is_from_committed_page = match n_iteration {
                            1 => (n_current_tex_data_byte / page_size).is_multiple_of(2),
                            2 => false,
                            _ => true,
                        };

                        let expected_value = if is_from_committed_page {
                            self.texture_data[byte_index] as i8
                        } else {
                            0
                        };

                        if is_from_committed_page
                            && (expected_value as i32 - read_data[byte_index] as i8 as i32).abs() >= 1
                        {
                            log::info!(
                                "Invalid texel data (channel:{n_component}) found at X:{x}, Y:{y}). Expected value:{expected_value}, found value:{}",
                                read_data[byte_index] as i8
                            );
                            result_local = false;
                            break 'rows;
                        }

                        n_current_tex_data_byte += 1;
                    }
                }
            }

            result &= result_local;

            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_PIXEL_UNPACK_BUFFER,
                    0,
                    self.sparse_bo_size_rounded as glw::GLintptr,
                    glw::GL_FALSE as glw::GLboolean
                )
            );
        }

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0)
        );
        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

/// `ClearOpsBufferStorageTestCase`
struct ClearOps<'a> {
    context: &'a Context,
    helper_bo: GLuint,
    initial_data: Vec<u8>,
    n_pages_to_use: u32,
    sparse_bo: GLuint,
    sparse_bo_size_rounded: u32,
    clear_op_type: u32,
    iteration: u32,
}

impl<'a> ClearOps<'a> {
    fn new(context: &'a Context, clear_op_type: u32, iteration: u32) -> Self {
        Self {
            context,
            helper_bo: 0,
            initial_data: Vec::new(),
            n_pages_to_use: 16,
            sparse_bo: 0,
            sparse_bo_size_rounded: 0,
            clear_op_type,
            iteration,
        }
    }
}

impl Drop for ClearOps<'_> {
    fn drop(&mut self) {
        if self.helper_bo != 0 {
            // SAFETY: the name was generated by this value and is deleted once.
            unsafe { self.context.gl().delete_buffers(1, &self.helper_bo) };
        }
    }
}

impl StorageCase for ClearOps<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = check_page_size(self.context)?;

        let n_bytes_needed = self.n_pages_to_use * page_size as u32;
        self.sparse_bo_size_rounded = align_offset(n_bytes_needed, page_size as u32);

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_COPY_READ_BUFFER,
                self.sparse_bo_size_rounded as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_READ_BIT
            )
        );

        self.initial_data = (0..self.sparse_bo_size_rounded)
            .map(|n_bytes_filled| (n_bytes_filled % 256) as u8)
            .collect();
        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.sparse_bo = sparse_bo;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.sparse_bo)
        );
        gl_call!(
            gl,
            "glBufferPageCommitmentARB() call failed.",
            gl.buffer_page_commitment_arb(
                glw::GL_ARRAY_BUFFER,
                0,
                self.sparse_bo_size_rounded as glw::GLintptr,
                glw::GL_TRUE as glw::GLboolean
            )
        );
        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut result = true;
        let data_rgba8: u32 = 0x12345678;
        let use_clear_buffer_data_call = self.clear_op_type == 0;
        let all_pages_committed = self.iteration == 0;
        let call_type = if use_clear_buffer_data_call {
            "glClearBufferData()"
        } else {
            "glClearBufferSubData()"
        };
        let all_pages_text = if all_pages_committed { "yes" } else { "no" };

        if !all_pages_committed {
            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.sparse_bo)
            );
            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_ARRAY_BUFFER,
                    (self.sparse_bo_size_rounded / 2) as glw::GLintptr,
                    (self.sparse_bo_size_rounded / 2) as GLsizeiptr,
                    glw::GL_TRUE as glw::GLboolean
                )
            );
        }

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferSubData() call failed.",
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                0,
                self.sparse_bo_size_rounded as GLsizeiptr,
                self.initial_data.as_ptr().cast()
            )
        );
        gl_call!(gl, "glBindBuffer() call(s) failed.", {
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo);
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.sparse_bo);
        });
        gl_call!(
            gl,
            "glCopyBufferSubData() call failed.",
            gl.copy_buffer_sub_data(
                glw::GL_COPY_READ_BUFFER,
                glw::GL_COPY_WRITE_BUFFER,
                0,
                0,
                self.sparse_bo_size_rounded as GLsizeiptr
            )
        );

        let (clear_region_size, clear_region_start_offset);

        if use_clear_buffer_data_call {
            clear_region_size = self.sparse_bo_size_rounded;
            clear_region_start_offset = 0;

            gl_call!(
                gl,
                "glClearBufferData() call failed.",
                gl.clear_buffer_data(
                    glw::GL_COPY_WRITE_BUFFER,
                    glw::GL_RGBA8,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::from_ref(&data_rgba8).cast()
                )
            );
        } else {
            clear_region_size = self.sparse_bo_size_rounded / 2;
            clear_region_start_offset = self.sparse_bo_size_rounded / 2;

            gl_call!(
                gl,
                "glClearBufferSubData() call failed.",
                gl.clear_buffer_sub_data(
                    glw::GL_COPY_WRITE_BUFFER,
                    glw::GL_RGBA8,
                    clear_region_start_offset as glw::GLintptr,
                    clear_region_size as GLsizeiptr,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::from_ref(&data_rgba8).cast()
                )
            );
        }

        gl_call!(
            gl,
            "glCopyBufferSubData() call failed.",
            gl.copy_buffer_sub_data(
                glw::GL_COPY_WRITE_BUFFER,
                glw::GL_COPY_READ_BUFFER,
                0,
                0,
                self.sparse_bo_size_rounded as GLsizeiptr
            )
        );

        // SAFETY: a read-only mapping of the helper buffer, which holds `sparse_bo_size_rounded` bytes.
        let mapped = unsafe {
            gl.map_buffer_range(
                glw::GL_COPY_READ_BUFFER,
                0,
                self.sparse_bo_size_rounded as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        };
        crate::glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;

        if mapped.is_null() {
            return Ok(false);
        }

        // SAFETY: the mapping is `sparse_bo_size_rounded` bytes long and stays valid until the unmap below.
        let result_data =
            unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), self.sparse_bo_size_rounded as usize) };

        let unmodified_region_size = if use_clear_buffer_data_call {
            0
        } else {
            clear_region_start_offset
        };

        for n_current_byte in 0..unmodified_region_size {
            let expected_value = self.initial_data[n_current_byte as usize];
            let found_value = result_data[n_current_byte as usize];

            if expected_value != found_value {
                log::info!(
                    "Unmodified buffer object region has invalid contents. Expected byte [{expected_value}], found byte:[{found_value}] at index [{n_current_byte}]; call type:[{call_type}], all required pages committed?:[{all_pages_text}]"
                );
                result = false;
                break;
            }
        }

        let mut result_local = true;
        let modified_region_size = if all_pages_committed { clear_region_size } else { 0 };

        for n_current_byte in clear_region_start_offset..clear_region_start_offset + modified_region_size {
            let component_offset = n_current_byte % 4;
            let expected_value = ((data_rgba8 & (0xFFu32 << (component_offset * 8))) >> (component_offset * 8)) as u8;
            let found_value = result_data[n_current_byte as usize];

            if expected_value != found_value {
                log::info!(
                    "Modified buffer object region has invalid contents. Expected byte [{expected_value}], found byte:[{found_value}] at index [{n_current_byte}]; call type:[{call_type}], all required pages committed?:[{all_pages_text}]"
                );
                result_local = false;
                break;
            }
        }

        result &= result_local;

        gl_call!(
            gl,
            "glUnmapBuffer() call failed.",
            gl.unmap_buffer(glw::GL_COPY_READ_BUFFER)
        );
        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.sparse_bo_size_rounded,
        )
    }
}

const QUADS_FS: &str =
    "#version 430 core\n\nflat in  vec4 fs_color;\n     out vec4 color;\n\nvoid main()\n{\n    color = fs_color;\n}\n";
const QUADS_VS: &str = "#version 430 core\n\nin vec4 color;\nin vec4 position;\n\nflat out vec4 fs_color;\n\nvoid main()\n{\n    fs_color    = color;\n    gl_Position = position;\n}\n";

/// `QuadsBufferStorageTestCase::_ibo_usage`
#[derive(Clone, Copy, PartialEq, Eq)]
enum IboUsage {
    None,
    IndexedDrawCall,
    IndexedRangedDrawCall,
}

/// `QuadsBufferStorageTestCase`
struct Quads<'a> {
    context: &'a Context,
    attribute_color_location: GLuint,
    attribute_position_location: GLuint,
    color_data_offset: u32,
    data: Vec<u8>,
    data_size: u32,
    data_size_rounded: u32,
    fbo: GLuint,
    helper_bo: GLuint,
    ibo_data_offset: u32,
    ibo_usage: IboUsage,
    n_quad_delta_x: u32,
    n_quad_delta_y: u32,
    n_quad_height: u32,
    n_quad_width: u32,
    n_quads_x: u32,
    n_quads_y: u32,
    n_vertices_to_draw: u32,
    pages_committed: bool,
    po: GLuint,
    sparse_bo: GLuint,
    to: GLuint,
    to_height: GLsizei,
    to_width: GLsizei,
    use_color_data: bool,
    vao: GLuint,
    vbo_data_offset: u32,
}

impl<'a> Quads<'a> {
    fn new(context: &'a Context, ibo_usage: IboUsage, use_color_data: bool) -> Self {
        let (n_quads_x, n_quads_y) = (100u32, 100u32);
        let n_vertices_to_draw = n_quads_x * n_quads_y * 2 * 3;
        let mut data_size = n_vertices_to_draw * 4 * 4;

        if ibo_usage != IboUsage::None {
            data_size += n_vertices_to_draw * 2;
        }

        if use_color_data {
            data_size += n_vertices_to_draw * 4 * 2 * 3;
        }

        Self {
            context,
            attribute_color_location: 0,
            attribute_position_location: 1,
            color_data_offset: 0,
            data: Vec::new(),
            data_size,
            data_size_rounded: 0,
            fbo: 0,
            helper_bo: 0,
            ibo_data_offset: u32::MAX,
            ibo_usage,
            n_quad_delta_x: 5,
            n_quad_delta_y: 5,
            n_quad_height: 5,
            n_quad_width: 5,
            n_quads_x,
            n_quads_y,
            n_vertices_to_draw,
            pages_committed: false,
            po: 0,
            sparse_bo: 0,
            to: 0,
            to_height: 1024,
            to_width: 1024,
            use_color_data,
            vao: 0,
            vbo_data_offset: u32::MAX,
        }
    }

    /// `createTestData`: the VBO, optional IBO and optional colour data in one buffer.
    fn create_test_data(&mut self) {
        let mut data: Vec<u8> = Vec::with_capacity(self.data_size as usize);

        self.vbo_data_offset = 0;

        for n_quad_y in 0..self.n_quads_y {
            for n_quad_x in 0..self.n_quads_x {
                let quad_start_x_px = n_quad_x * (self.n_quad_delta_x + self.n_quad_width);
                let quad_start_y_px = n_quad_y * (self.n_quad_delta_y + self.n_quad_height);
                let quad_end_x_px = quad_start_x_px + self.n_quad_width;
                let quad_end_y_px = quad_start_y_px + self.n_quad_height;

                let quad_end_x_ss = quad_end_x_px as f32 / self.to_width as f32 * 2.0 - 1.0;
                let quad_end_y_ss = quad_end_y_px as f32 / self.to_height as f32 * 2.0 - 1.0;
                let quad_start_x_ss = quad_start_x_px as f32 / self.to_width as f32 * 2.0 - 1.0;
                let quad_start_y_ss = quad_start_y_px as f32 / self.to_height as f32 * 2.0 - 1.0;

                let v1_4 = [quad_start_x_ss, quad_start_y_ss, 0.0f32, 1.0];
                let v2 = [quad_start_x_ss, quad_end_y_ss, 0.0f32, 1.0];
                let v3_6 = [quad_end_x_ss, quad_end_y_ss, 0.0f32, 1.0];
                let v5 = [quad_end_x_ss, quad_start_y_ss, 0.0f32, 1.0];

                for vertex in [v1_4, v2, v3_6, v1_4, v5, v3_6] {
                    for component in vertex {
                        data.extend_from_slice(&component.to_ne_bytes());
                    }
                }
            }
        }

        if self.ibo_usage != IboUsage::None {
            self.ibo_data_offset = data.len() as u32;

            for index in (0..self.n_vertices_to_draw).rev() {
                data.extend_from_slice(&(index as u16).to_ne_bytes());
            }
        } else {
            self.ibo_data_offset = 0;
        }

        if self.use_color_data {
            self.color_data_offset = data.len() as u32;

            for n_quad in 0..self.n_quads_x * self.n_quads_y {
                for _ in 0..6 {
                    data.push((n_quad % 256) as u8);
                    data.push((((n_quad + 32) * 7) % 255) as u8);
                    data.push((((n_quad + 7) * 53) % 255) as u8);
                    data.push((((n_quad + 13) * 3) % 255) as u8);
                }
            }
        } else {
            self.color_data_offset = 0;
        }

        data.resize(self.data_size as usize, 0);
        self.data = data;
    }

    /// `initSparseBO`
    fn init_sparse_bo(
        &mut self,
        decommit_data_pages_after_upload: bool,
        is_dynamic_storage: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        if self.data.is_empty() {
            self.create_test_data();
        }

        gl_call!(
            gl,
            "glBufferPageCommitmentARB() call failed.",
            gl.buffer_page_commitment_arb(
                glw::GL_ARRAY_BUFFER,
                0,
                self.data_size_rounded as glw::GLintptr,
                glw::GL_TRUE as glw::GLboolean
            )
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );

        self.pages_committed = true;

        if is_dynamic_storage {
            gl_call!(
                gl,
                "glBufferSubData() call failed.",
                gl.buffer_sub_data(
                    glw::GL_ARRAY_BUFFER,
                    0,
                    self.data_size as GLsizeiptr,
                    self.data.as_ptr().cast()
                )
            );
        } else {
            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_ARRAY_BUFFER,
                    0,
                    0,
                    self.data_size as GLsizeiptr
                )
            );
        }

        gl_call!(
            gl,
            "glVertexAttribPointer() call failed.",
            gl.vertex_attrib_pointer(
                self.attribute_position_location,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                self.vbo_data_offset as usize as *const std::ffi::c_void
            )
        );
        gl_call!(
            gl,
            "glEnableVertexAttribPointer() call failed.",
            gl.enable_vertex_attrib_array(self.attribute_position_location)
        );

        if self.use_color_data {
            gl_call!(
                gl,
                "glVertexAttribPointer() call failed.",
                gl.vertex_attrib_pointer(
                    self.attribute_color_location,
                    4,
                    glw::GL_UNSIGNED_BYTE,
                    glw::GL_TRUE as glw::GLboolean,
                    0,
                    self.color_data_offset as usize as *const std::ffi::c_void
                )
            );
            gl_call!(
                gl,
                "glEnableVertexAttribPointer() call failed.",
                gl.enable_vertex_attrib_array(self.attribute_color_location)
            );
        } else {
            gl_call!(
                gl,
                "glVertexAttrib4f() call failed.",
                gl.vertex_attrib_4f(self.attribute_color_location, 1.0, 1.0, 1.0, 1.0)
            );
            gl_call!(
                gl,
                "glDisableVertexAttribArray() call failed.",
                gl.disable_vertex_attrib_array(self.attribute_color_location)
            );
        }

        if self.ibo_usage != IboUsage::None {
            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.sparse_bo)
            );
        }

        if decommit_data_pages_after_upload {
            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_ARRAY_BUFFER,
                    0,
                    self.data_size_rounded as glw::GLintptr,
                    glw::GL_FALSE as glw::GLboolean
                )
            );
            self.pages_committed = false;
        }

        Ok(())
    }
}

impl Drop for Quads<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.fbo != 0 {
                gl.delete_framebuffers(1, &self.fbo);
            }
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.po != 0 {
                gl.delete_program(self.po);
            }
            if self.to != 0 {
                gl.delete_textures(1, &self.to);
            }
            if self.vao != 0 {
                gl.delete_vertex_arrays(1, &self.vao);
            }
        }
    }
}

impl StorageCase for Quads<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let page_size = check_page_size(self.context)?;

        self.data_size_rounded = align_offset(self.data_size, page_size as u32);

        gl_call!(gl, "glGenTextures() call failed.", gl.gen_textures(1, &mut self.to));
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.to)
        );
        gl_call!(
            gl,
            "glTexStorage2D() call failed.",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, self.to_width, self.to_height)
        );
        gl_call!(
            gl,
            "glGenFramebuffers() call failed.",
            gl.gen_framebuffers(1, &mut self.fbo)
        );
        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D() call failed.",
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                self.to,
                0
            )
        );
        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao)
        );
        gl_call!(gl, "glBindVertexArray() call failed.", gl.bind_vertex_array(self.vao));

        self.create_test_data();

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.helper_bo)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_COPY_READ_BUFFER,
                self.data_size as GLsizeiptr,
                self.data.as_ptr().cast(),
                0
            )
        );

        let attributes = [
            ("color", self.attribute_color_location),
            ("position", self.attribute_position_location),
        ];
        self.po = create_program(self.context, &[QUADS_FS], &[QUADS_VS], &attributes, &[], glw::GL_NONE)?;

        Ok(self.po != 0)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        self.sparse_bo = sparse_bo;
        Ok(true)
    }

    fn execute(&mut self, sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glViewport() call failed.",
            gl.viewport(0, 0, self.to_width, self.to_height)
        );
        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po));
        gl_call!(gl, "glClearColor() call failed.", gl.clear_color(0.0, 0.0, 0.0, 0.0));

        for n_iteration in 0..2 {
            self.init_sparse_bo(
                n_iteration == 0,
                sparse_bo_storage_flags & glw::GL_DYNAMIC_STORAGE_BIT != 0,
            )?;

            gl_call!(gl, "glClear() call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));

            let n_vertices = self.n_vertices_to_draw as GLsizei;
            let ibo_offset = self.ibo_data_offset as usize as *const std::ffi::c_void;

            match self.ibo_usage {
                IboUsage::None => {
                    gl_call!(
                        gl,
                        "glDrawArrays() call failed.",
                        gl.draw_arrays(glw::GL_TRIANGLES, 0, n_vertices)
                    );
                }
                IboUsage::IndexedDrawCall => {
                    gl_call!(
                        gl,
                        "glDrawElements() call failed.",
                        gl.draw_elements(glw::GL_TRIANGLES, n_vertices, glw::GL_UNSIGNED_SHORT, ibo_offset)
                    );
                }
                IboUsage::IndexedRangedDrawCall => {
                    gl_call!(
                        gl,
                        "glDrawRangeElements() call failed.",
                        gl.draw_range_elements(
                            glw::GL_TRIANGLES,
                            0,
                            self.n_vertices_to_draw,
                            n_vertices,
                            glw::GL_UNSIGNED_SHORT,
                            ibo_offset
                        )
                    );
                }
            }

            let mut read_data = vec![0u8; (self.to_width * self.to_height * 4) as usize];
            gl_call!(
                gl,
                "glReadPixels() call failed.",
                gl.read_pixels(
                    0,
                    0,
                    self.to_width,
                    self.to_height,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    read_data.as_mut_ptr().cast()
                )
            );

            if self.pages_committed {
                for n_quad_region_y in 0..self.n_quads_y * 2 {
                    for n_quad_region_x in 0..self.n_quads_x * 2 {
                        let is_delta_region = n_quad_region_x % 2 != 0 || n_quad_region_y % 2 != 0;

                        let expected_color: [u8; 4] = if is_delta_region {
                            [0; 4]
                        } else if self.use_color_data {
                            let n_quad_x = n_quad_region_x / 2;
                            let n_quad_y = n_quad_region_y / 2;
                            let offset =
                                (self.color_data_offset + (n_quad_y * self.n_quads_x + n_quad_x) * 4 * 6) as usize;
                            self.data[offset..offset + 4].try_into().expect("four bytes")
                        } else {
                            [255; 4]
                        };

                        let sample_texel_x = self.n_quad_delta_x * n_quad_region_x;
                        let sample_texel_y = self.n_quad_delta_y * n_quad_region_y;
                        let offset = ((sample_texel_y * self.to_width as u32 + sample_texel_x) * 4) as usize;
                        let found_color: [u8; 4] = read_data[offset..offset + 4].try_into().expect("four bytes");

                        if expected_color != found_color {
                            log::info!(
                                "Invalid color found at ({sample_texel_x}, {sample_texel_y}): Expected color:{expected_color:?}, Found:{found_color:?}, "
                            );
                            return Ok(false);
                        }
                    }
                }
            }
        }

        Ok(true)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        decommit_all(
            self.context,
            std::mem::take(&mut self.sparse_bo),
            self.data_size_rounded,
        )
    }
}

/// `CopyOpsBufferStorageTestCase::_test_case`; the reference data pointers are indices into `CopyOps::ref_data`
struct CopyOpsTestCase {
    dst_bo_commit_size: GLint,
    dst_bo_commit_start_offset: GLint,
    dst_bo_sparse_id: usize,
    dst_bo_is_sparse: bool,
    dst_bo_ref_data: usize,
    dst_bo_start_offset: GLint,
    n_bytes_to_copy: GLint,
    src_bo_commit_size: GLint,
    src_bo_commit_start_offset: GLint,
    src_bo_sparse_id: usize,
    src_bo_is_sparse: bool,
    src_bo_ref_data: usize,
    src_bo_start_offset: GLint,
}

impl CopyOpsTestCase {
    fn describe(&self, dst_bo_id: GLuint, src_bo_id: GLuint) -> String {
        format!(
            "Destination BO id:{dst_bo_id} ({}), commited region: {}:{}, copy region: {}:{}. Source BO id:{src_bo_id} ({}), commited region: {}:{}, copy region: {}:{}",
            if self.dst_bo_is_sparse {
                "sparse buffer)"
            } else {
                "immutable buffer)"
            },
            self.dst_bo_commit_start_offset,
            self.dst_bo_commit_start_offset + self.dst_bo_commit_size,
            self.dst_bo_start_offset,
            self.dst_bo_start_offset + self.n_bytes_to_copy,
            if self.src_bo_is_sparse {
                "sparse buffer)"
            } else {
                "immutable buffer)"
            },
            self.src_bo_commit_start_offset,
            self.src_bo_commit_start_offset + self.src_bo_commit_size,
            self.src_bo_start_offset,
            self.src_bo_start_offset + self.n_bytes_to_copy,
        )
    }
}

/// `CopyOpsBufferStorageTestCase`
struct CopyOps<'a> {
    context: &'a Context,
    helper_bo: GLuint,
    immutable_bo: GLuint,
    page_size: GLint,
    ref_data: [Vec<u16>; 3],
    sparse_bos: [GLuint; 2],
    sparse_bo_size: u32,
    sparse_bo_size_rounded: u32,
    test_cases: Vec<CopyOpsTestCase>,
}

impl<'a> CopyOps<'a> {
    fn new(context: &'a Context) -> Self {
        Self {
            context,
            helper_bo: 0,
            immutable_bo: 0,
            page_size: 0,
            ref_data: [Vec::new(), Vec::new(), Vec::new()],
            sparse_bos: [0; 2],
            sparse_bo_size: 0,
            sparse_bo_size_rounded: 0,
            test_cases: Vec::new(),
        }
    }

    fn init_reference_data(&mut self) {
        let n_shorts = self.sparse_bo_size_rounded / 2;

        for (n_ref_data_buffer, buffer) in self.ref_data.iter_mut().enumerate() {
            *buffer = (0..n_shorts)
                .map(|n_short_value| ((n_ref_data_buffer as u32 + 1).wrapping_mul(n_short_value + 1)) as u16)
                .collect();
        }
    }

    #[expect(
        clippy::explicit_counter_loop,
        reason = "mirrors upstream's counter, which the nested loops below also read"
    )]
    fn init_test_cases(&mut self) -> Result<(), TestError> {
        let rounded = self.sparse_bo_size_rounded as GLint;
        let mut n_test_case = 0;

        for n_bo_configuration in 0..4 {
            let (
                dst_bo_sparse_id,
                dst_bo_is_sparse,
                dst_bo_ref_data,
                src_bo_sparse_id,
                src_bo_is_sparse,
                src_bo_ref_data,
            ) = match n_bo_configuration {
                0 => (0, true, 1, 1, true, 2),
                1 => (0, true, 1, 0, false, 0),
                2 => (0, false, 0, 0, true, 1),
                3 => (0, true, 1, 0, true, 1),
                _ => return fail("Invalid BO configuration index"),
            };

            for n_dst_region in 0..3 {
                let (dst_bo_commit_start_offset, dst_bo_commit_size) = match n_dst_region {
                    0 => (0, rounded / 2),
                    1 => (rounded / 4, rounded / 4),
                    2 => (0, 0),
                    _ => return fail("Invalid destination region configuration index"),
                };

                for n_src_region in 0..3 {
                    let (src_bo_commit_start_offset, src_bo_commit_size) = match n_src_region {
                        0 => (rounded / 2, rounded / 2),
                        1 => (3 * rounded / 4, rounded / 4),
                        2 => (rounded / 2, 0),
                        _ => return fail("Invalid source region configuration index"),
                    };

                    let dst_bo_start_offset = (2 * n_test_case) as GLint;

                    self.test_cases.push(CopyOpsTestCase {
                        dst_bo_commit_size,
                        dst_bo_commit_start_offset,
                        dst_bo_sparse_id,
                        dst_bo_is_sparse,
                        dst_bo_ref_data,
                        dst_bo_start_offset,
                        n_bytes_to_copy: rounded / 2 - dst_bo_start_offset - (2 * n_test_case) as GLint,
                        src_bo_commit_size,
                        src_bo_commit_start_offset,
                        src_bo_sparse_id,
                        src_bo_is_sparse,
                        src_bo_ref_data,
                        src_bo_start_offset: rounded / 2,
                    });
                }
            }

            n_test_case += 1;
        }

        Ok(())
    }
}

impl Drop for CopyOps<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();

        // SAFETY: the names were generated by this value and are deleted once.
        unsafe {
            if self.helper_bo != 0 {
                gl.delete_buffers(1, &self.helper_bo);
            }
            if self.immutable_bo != 0 {
                gl.delete_buffers(1, &self.immutable_bo);
            }
            if self.sparse_bos[1] != 0 {
                gl.delete_buffers(1, &self.sparse_bos[1]);
            }
        }
    }
}

impl StorageCase for CopyOps<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.page_size = check_page_size(self.context)?;
        self.sparse_bo_size = 2 * 3 * 4 * self.page_size as u32;
        self.sparse_bo_size_rounded = align_offset(self.sparse_bo_size, self.page_size as u32);

        self.init_reference_data();

        gl_call!(
            gl,
            "glGenBuffers() call failed.",
            gl.gen_buffers(1, &mut self.sparse_bos[1])
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.sparse_bos[1])
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_ARRAY_BUFFER,
                self.sparse_bo_size_rounded as GLsizeiptr,
                std::ptr::null(),
                glw::GL_SPARSE_STORAGE_BIT_ARB
            )
        );

        for n_bo in 0..2 {
            let mut flags = glw::GL_DYNAMIC_STORAGE_BIT;

            if n_bo == 0 {
                flags |= glw::GL_MAP_READ_BIT;
            }

            let mut bo_id: GLuint = 0;

            gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut bo_id));

            if n_bo == 0 {
                self.helper_bo = bo_id;
            } else {
                self.immutable_bo = bo_id;
            }

            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo_id)
            );
            gl_call!(
                gl,
                "glBufferStorage() call failed.",
                gl.buffer_storage(
                    glw::GL_ARRAY_BUFFER,
                    self.sparse_bo_size_rounded as GLsizeiptr,
                    self.ref_data[0].as_ptr().cast(),
                    flags
                )
            );
        }

        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.sparse_bos[0] = sparse_bo;

        if self.test_cases.is_empty() {
            self.init_test_cases()?;
        }

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.sparse_bos[0])
        );
        gl_call!(
            gl,
            "glBufferPageCommitmentARB() call failed.",
            gl.buffer_page_commitment_arb(
                glw::GL_ARRAY_BUFFER,
                0,
                self.sparse_bo_size_rounded as glw::GLintptr,
                glw::GL_FALSE as glw::GLboolean
            )
        );

        Ok(true)
    }

    fn execute(&mut self, _sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let rounded = self.sparse_bo_size_rounded as GLsizeiptr;
        let mut result = true;

        for test_case in &self.test_cases {
            let mut result_local = true;
            let dst_bo_id = if test_case.dst_bo_is_sparse {
                self.sparse_bos[test_case.dst_bo_sparse_id]
            } else {
                self.immutable_bo
            };
            let src_bo_id = if test_case.src_bo_is_sparse {
                self.sparse_bos[test_case.src_bo_sparse_id]
            } else {
                self.immutable_bo
            };

            if dst_bo_id == self.immutable_bo || src_bo_id == self.immutable_bo {
                gl_call!(
                    gl,
                    "glBindBuffer() call failed.",
                    gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.immutable_bo)
                );
                gl_call!(
                    gl,
                    "glBufferSubData() call failed.",
                    gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 0, rounded, self.ref_data[0].as_ptr().cast())
                );
            }

            for n_sparse_bo in 0..2 {
                let is_dst_bo = dst_bo_id == self.sparse_bos[n_sparse_bo];
                let is_src_bo = src_bo_id == self.sparse_bos[n_sparse_bo];

                if !is_dst_bo && !is_src_bo {
                    continue;
                }

                gl_call!(gl, "glBindBuffer() call(s) failed.", {
                    gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.helper_bo);
                    gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.sparse_bos[n_sparse_bo])
                });

                if is_dst_bo {
                    gl_call!(
                        gl,
                        "glBufferPageCommitmentARB() call failed.",
                        gl.buffer_page_commitment_arb(
                            glw::GL_COPY_WRITE_BUFFER,
                            test_case.dst_bo_commit_start_offset as glw::GLintptr,
                            test_case.dst_bo_commit_size as GLsizeiptr,
                            glw::GL_TRUE as glw::GLboolean
                        )
                    );
                }

                if is_src_bo {
                    gl_call!(
                        gl,
                        "glBufferPageCommitmentARB() call failed.",
                        gl.buffer_page_commitment_arb(
                            glw::GL_COPY_WRITE_BUFFER,
                            test_case.src_bo_commit_start_offset as glw::GLintptr,
                            test_case.src_bo_commit_size as GLsizeiptr,
                            glw::GL_TRUE as glw::GLboolean
                        )
                    );
                }

                gl_call!(
                    gl,
                    "glBufferSubData() call failed.",
                    gl.buffer_sub_data(
                        glw::GL_COPY_READ_BUFFER,
                        0,
                        rounded,
                        self.ref_data[1 + n_sparse_bo].as_ptr().cast()
                    )
                );
                gl_call!(
                    gl,
                    "glCopyBufferSubData() call failed.",
                    gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, rounded)
                );
            }

            gl_call!(gl, "glBindBuffer() call failed.", {
                gl.bind_buffer(glw::GL_COPY_READ_BUFFER, src_bo_id);
                gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, dst_bo_id)
            });

            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_COPY_WRITE_BUFFER,
                    test_case.src_bo_start_offset as glw::GLintptr,
                    test_case.dst_bo_start_offset as glw::GLintptr,
                    test_case.n_bytes_to_copy as GLsizeiptr
                )
            );

            gl_call!(gl, "glBindBuffer() call failed.", {
                gl.bind_buffer(glw::GL_COPY_READ_BUFFER, dst_bo_id);
                gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.helper_bo)
            });
            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, rounded)
            );

            // SAFETY: a read-only mapping of the helper buffer.
            let dst_bo_data_ptr =
                unsafe { gl.map_buffer_range(glw::GL_COPY_WRITE_BUFFER, 0, rounded, glw::GL_MAP_READ_BIT) };
            crate::glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;

            if dst_bo_data_ptr.is_null() {
                return Ok(false);
            }

            let found_at = |dst_data_offset: GLint| -> u16 {
                // SAFETY: every offset used below is inside the `sparse_bo_size_rounded` bytes just mapped.
                unsafe {
                    dst_bo_data_ptr
                        .cast::<u8>()
                        .add(dst_data_offset as usize)
                        .cast::<u16>()
                        .read_unaligned()
                }
            };
            let dst_commit_end = test_case.dst_bo_commit_start_offset + test_case.dst_bo_commit_size;
            let src_commit_end = test_case.src_bo_commit_start_offset + test_case.src_bo_commit_size;

            if test_case.dst_bo_start_offset != 0
                && test_case.dst_bo_commit_start_offset < test_case.dst_bo_start_offset
            {
                let n_valid_values = (test_case.dst_bo_start_offset - test_case.dst_bo_commit_start_offset) / 2;

                for n_value in 0..n_valid_values {
                    if !result_local {
                        break;
                    }

                    let dst_data_offset = 2 * n_value;

                    if dst_data_offset >= test_case.dst_bo_commit_start_offset && dst_data_offset < dst_commit_end {
                        let expected_short_value =
                            self.ref_data[test_case.dst_bo_ref_data][(dst_data_offset / 2) as usize];
                        let found_short_value = found_at(dst_data_offset);

                        if expected_short_value != found_short_value {
                            log::info!(
                                "Malformed data found in the copy op's destination BO, preceding the region modified by the copy op. {}. Expected value of {expected_short_value}, found value of {found_short_value} at dst data offset of {dst_data_offset}.",
                                test_case.describe(dst_bo_id, src_bo_id)
                            );
                            result_local = false;
                        }
                    }
                }
            }

            for n_copied_short_value in 0..test_case.n_bytes_to_copy / 2 {
                if !result_local {
                    break;
                }

                let src_data_offset = test_case.src_bo_start_offset + 2 * n_copied_short_value;
                let dst_data_offset = test_case.dst_bo_start_offset + 2 * n_copied_short_value;

                if dst_data_offset >= test_case.dst_bo_commit_start_offset
                    && dst_data_offset < dst_commit_end
                    && src_data_offset >= test_case.src_bo_commit_start_offset
                    && src_data_offset < src_commit_end
                {
                    let expected_short_value = self.ref_data[test_case.src_bo_ref_data][(src_data_offset / 2) as usize];
                    let found_short_value = found_at(dst_data_offset);

                    if expected_short_value != found_short_value {
                        log::info!(
                            "Malformed data found in the copy op's destination BO. {}. Expected value of {expected_short_value}, found value of {found_short_value} at dst data offset of {dst_data_offset}.",
                            test_case.describe(dst_bo_id, src_bo_id)
                        );
                        result_local = false;
                    }
                }
            }

            let copy_region_end_offset = test_case.dst_bo_start_offset + test_case.n_bytes_to_copy;

            if dst_commit_end > copy_region_end_offset {
                let n_valid_values = (dst_commit_end - copy_region_end_offset) / 2;

                for n_value in 0..n_valid_values {
                    if !result_local {
                        break;
                    }

                    let dst_data_offset = copy_region_end_offset + 2 * n_value;

                    if dst_data_offset >= test_case.dst_bo_commit_start_offset && dst_data_offset < dst_commit_end {
                        let expected_short_value =
                            self.ref_data[test_case.dst_bo_ref_data][(dst_data_offset / 2) as usize];
                        let found_short_value = found_at(dst_data_offset);

                        if expected_short_value != found_short_value {
                            log::info!(
                                "Malformed data found in the copy op's destination BO, following the region modified by the copy op. {}. Expected value of {expected_short_value}, found value of {found_short_value} at dst data offset of {dst_data_offset}.",
                                test_case.describe(dst_bo_id, src_bo_id)
                            );
                            result_local = false;
                        }
                    }
                }
            }

            gl_call!(
                gl,
                "glUnmapBuffer() call failed.",
                gl.unmap_buffer(glw::GL_COPY_WRITE_BUFFER)
            );

            for n_sparse_bo in 0..2 {
                if dst_bo_id == self.sparse_bos[n_sparse_bo] || src_bo_id == self.sparse_bos[n_sparse_bo] {
                    decommit_all(self.context, self.sparse_bos[n_sparse_bo], self.sparse_bo_size_rounded)?;
                }
            }

            result &= result_local;
        }

        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        for n_sparse_bo in 0..2 {
            decommit_all(self.context, self.sparse_bos[n_sparse_bo], self.sparse_bo_size_rounded)?;
        }

        Ok(())
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cSparseBufferTests.cpp  (TransformFeedbackBufferStorageTestCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The result data is addressed by word index into a slice instead of by pointers; `deinitTestCaseGlobal` is the `Drop`; `SparseBufferTestUtilities::getSparseBOFlagsString` in the failure log is the flags in hex.

use super::storage_cases::{StorageCase, align_offset, create_vertex_program};
use super::{check_page_size, fail};
use crate::glu::Context;
use crate::glw::{self, GLint, GLsizei, GLsizeiptr, GLuint};
use crate::tcu::TestError;

const DRAW_CALL_NAMES: [&str; 15] = [
    "draw_call_indexed",
    "draw_call_indexed_base_vertex",
    "draw_call_indexed_indirect",
    "draw_call_indexed_indirect_multi",
    "draw_call_indexed_multi",
    "draw_call_indexed_multi_base_vertex",
    "draw_call_instanced_indexed",
    "draw_call_instanced_indexed_base_vertex",
    "draw_call_instanced_indexed_base_vertex_base_instance",
    "draw_call_regular",
    "draw_call_regular_indirect",
    "draw_call_regular_indirect_multi",
    "draw_call_regular_instanced",
    "draw_call_regular_instanced_base_instance",
    "draw_call_regular_multi",
];

const DRAW_CALL_INDEXED: usize = 0;
const DRAW_CALL_INDEXED_BASE_VERTEX: usize = 1;
const DRAW_CALL_INDEXED_INDIRECT: usize = 2;
const DRAW_CALL_INDEXED_INDIRECT_MULTI: usize = 3;
const DRAW_CALL_INDEXED_MULTI: usize = 4;
const DRAW_CALL_INDEXED_MULTI_BASE_VERTEX: usize = 5;
const DRAW_CALL_INSTANCED_INDEXED: usize = 6;
const DRAW_CALL_INSTANCED_INDEXED_BASE_VERTEX: usize = 7;
const DRAW_CALL_INSTANCED_INDEXED_BASE_VERTEX_BASE_INSTANCE: usize = 8;
const DRAW_CALL_REGULAR: usize = 9;
const DRAW_CALL_REGULAR_INDIRECT: usize = 10;
const DRAW_CALL_REGULAR_INDIRECT_MULTI: usize = 11;
const DRAW_CALL_REGULAR_INSTANCED: usize = 12;
const DRAW_CALL_REGULAR_INSTANCED_BASE_INSTANCE: usize = 13;
const DRAW_CALL_REGULAR_MULTI: usize = 14;

const VS_BODY: &str = "#version 420 core\n\nout uint instance_id;\nout uint vertex_id;\n\nvoid main()\n{\n    instance_id = gl_InstanceID;\n    vertex_id   = gl_VertexID;\n}\n";

/// The case behind `BufferStorageTest_case_b[12]_tf_type_<n>_<draw call name>`.
pub(super) fn create<'a>(context: &'a Context, name: &str) -> Option<Box<dyn StorageCase + 'a>> {
    let rest = name.strip_prefix("BufferStorageTest_case_b")?;
    let all_pages_committed = match rest.chars().next()? {
        '1' => true,
        '2' => false,
        _ => return None,
    };
    let rest = rest[1..].strip_prefix("_tf_type_")?;
    let tf_type: u32 = rest[..1].parse().ok()?;
    let draw_call_name = rest[1..].strip_prefix('_')?;
    let draw_call_type = DRAW_CALL_NAMES
        .iter()
        .position(|candidate| *candidate == draw_call_name)?;

    Some(Box::new(TransformFeedback::new(
        context,
        all_pages_committed,
        tf_type,
        draw_call_type,
    )))
}

/// `TransformFeedbackBufferStorageTestCase`
struct TransformFeedback<'a> {
    context: &'a Context,
    all_pages_committed: bool,
    data_bo: GLuint,
    data_bo_index_data_offset: u32,
    data_bo_indexed_indirect_arg_offset: u32,
    data_bo_indexed_mdi_arg_offset: u32,
    data_bo_regular_indirect_arg_offset: u32,
    data_bo_regular_mdi_arg_offset: u32,
    data_bo_size: u32,
    draw_call_base_instance: u32,
    draw_call_base_vertex: u32,
    draw_call_first: u32,
    draw_call_first_index: u32,
    helper_bo: GLuint,
    index_data: Vec<u32>,
    indirect_arg_data: Vec<u32>,
    min_memory_page_span: u32,
    multidrawcall_base_vertex: [GLint; 2],
    multidrawcall_count: [GLsizei; 2],
    multidrawcall_drawcount: u32,
    multidrawcall_first: [GLint; 2],
    multidrawcall_index: [u32; 2],
    multidrawcall_primcount: u32,
    n_instances_to_test: u32,
    n_vertices_per_instance: u32,
    page_size: GLint,
    po_ia: GLuint,
    po_sa: GLuint,
    result_bo: GLuint,
    result_bo_size: u32,
    result_bo_size_rounded: u32,
    vao: GLuint,
    tf_type: u32,
    draw_call_type: usize,
}

impl<'a> TransformFeedback<'a> {
    fn new(context: &'a Context, all_pages_committed: bool, tf_type: u32, draw_call_type: usize) -> Self {
        Self {
            context,
            all_pages_committed,
            data_bo: 0,
            data_bo_index_data_offset: 0,
            data_bo_indexed_indirect_arg_offset: 0,
            data_bo_indexed_mdi_arg_offset: 0,
            data_bo_regular_indirect_arg_offset: 0,
            data_bo_regular_mdi_arg_offset: 0,
            data_bo_size: 0,
            draw_call_base_instance: 1231,
            draw_call_base_vertex: 65537,
            draw_call_first: 913,
            draw_call_first_index: 4,
            helper_bo: 0,
            index_data: Vec::new(),
            indirect_arg_data: Vec::new(),
            min_memory_page_span: 4,
            multidrawcall_base_vertex: [0; 2],
            multidrawcall_count: [0; 2],
            multidrawcall_drawcount: 0,
            multidrawcall_first: [0; 2],
            multidrawcall_index: [0; 2],
            multidrawcall_primcount: 0,
            n_instances_to_test: 4,
            n_vertices_per_instance: 0,
            page_size: 0,
            po_ia: 0,
            po_sa: 0,
            result_bo: 0,
            result_bo_size: 0,
            result_bo_size_rounded: 0,
            vao: 0,
            tf_type,
            draw_call_type,
        }
    }

    /// `initTestData`
    #[expect(
        clippy::vec_init_then_push,
        reason = "upstream pushes the arguments one by one, commented as it goes"
    )]
    fn init_test_data(&mut self) {
        let page_size = self.page_size as u32;

        self.n_vertices_per_instance = page_size * self.min_memory_page_span / (4 * 2);

        let indexed_indirect_size = 4 * 5;
        let indexed_mdi_size = 4 * 5 * 2;
        let regular_indirect_size = 4 * 4;
        let regular_mdi_size = 4 * 4 * 2;

        self.data_bo_indexed_indirect_arg_offset = 0;
        self.data_bo_indexed_mdi_arg_offset = self.data_bo_indexed_indirect_arg_offset + indexed_indirect_size;
        self.data_bo_regular_indirect_arg_offset = self.data_bo_indexed_mdi_arg_offset + indexed_mdi_size;
        self.data_bo_regular_mdi_arg_offset = self.data_bo_regular_indirect_arg_offset + regular_indirect_size;
        self.data_bo_index_data_offset = self.data_bo_regular_mdi_arg_offset + regular_mdi_size;

        self.index_data = (0..self.n_vertices_per_instance + 1)
            .map(|n_index| self.n_vertices_per_instance - n_index)
            .collect();

        self.multidrawcall_base_vertex = [self.draw_call_base_vertex as GLint, 257];
        self.multidrawcall_count = [
            self.n_vertices_per_instance as GLsizei,
            self.n_vertices_per_instance as GLsizei - 16,
        ];
        self.multidrawcall_drawcount = 2;
        self.multidrawcall_first = [0, self.draw_call_first as GLint];
        self.multidrawcall_index = [
            self.data_bo_index_data_offset,
            self.data_bo_index_data_offset + self.draw_call_first_index,
        ];
        self.multidrawcall_primcount = self.n_instances_to_test;

        let mut args: Vec<u32> = Vec::new();

        args.push(self.multidrawcall_count[1] as u32);
        args.push(self.n_instances_to_test);
        args.push(self.multidrawcall_index[1] / 4);
        args.push(self.draw_call_base_vertex);
        args.push(self.draw_call_base_instance);

        for n_draw_call in 0..2 {
            args.push(self.multidrawcall_count[n_draw_call] as u32);
            args.push(if n_draw_call == 0 { 1 } else { self.n_instances_to_test });
            args.push(self.multidrawcall_index[n_draw_call] / 4);
            args.push(self.draw_call_base_vertex);
            args.push(self.draw_call_base_instance);
        }

        args.push(self.multidrawcall_count[1] as u32);
        args.push(self.n_instances_to_test);
        args.push(self.draw_call_first);
        args.push(self.draw_call_base_instance);

        for n_draw_call in 0..2 {
            args.push(self.multidrawcall_count[n_draw_call] as u32);
            args.push(if n_draw_call == 0 { 1 } else { self.n_instances_to_test });
            args.push(self.draw_call_first);
            args.push(self.draw_call_base_instance);
        }

        self.indirect_arg_data = args;
        self.data_bo_size = (self.index_data.len() * 4 + self.indirect_arg_data.len() * 4) as u32;

        self.result_bo_size =
            4 * 2 * (self.multidrawcall_count[0] + self.multidrawcall_count[1]) as u32 * self.multidrawcall_primcount;
        self.result_bo_size_rounded = align_offset(self.result_bo_size, page_size);
    }

    /// `initDataBO`
    fn init_data_bo(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        self.init_test_data();

        gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.data_bo));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.data_bo)
        );
        gl_call!(
            gl,
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_ARRAY_BUFFER,
                self.data_bo_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_STORAGE_BIT
            )
        );

        gl_call!(gl, "glBufferSubData() call(s) failed.", {
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                self.data_bo_indexed_indirect_arg_offset as glw::GLintptr,
                (self.indirect_arg_data.len() * 4) as GLsizeiptr,
                self.indirect_arg_data.as_ptr().cast(),
            );
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                self.data_bo_index_data_offset as glw::GLintptr,
                (self.index_data.len() * 4) as GLsizeiptr,
                self.index_data.as_ptr().cast(),
            );
        });

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
            "glBufferStorage() call failed.",
            gl.buffer_storage(
                glw::GL_ARRAY_BUFFER,
                self.result_bo_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_MAP_READ_BIT
            )
        );
        Ok(())
    }
}

impl Drop for TransformFeedback<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            for bo in [self.data_bo, self.helper_bo] {
                if bo != 0 {
                    gl.delete_buffers(1, &bo);
                }
            }
            for po in [self.po_ia, self.po_sa] {
                if po != 0 {
                    gl.delete_program(po);
                }
            }
            if self.vao != 0 {
                gl.delete_vertex_arrays(1, &self.vao);
            }
        }
    }
}

impl StorageCase for TransformFeedback<'_> {
    fn init_test_case_global(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.page_size = check_page_size(self.context)?;

        let tf_varyings = ["instance_id", "vertex_id"];
        self.po_ia = create_vertex_program(self.context, &[VS_BODY], &tf_varyings, glw::GL_INTERLEAVED_ATTRIBS)?;
        self.po_sa = create_vertex_program(self.context, &[VS_BODY], &tf_varyings, glw::GL_SEPARATE_ATTRIBS)?;

        if self.po_ia == 0 || self.po_sa == 0 {
            return Ok(false);
        }

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao)
        );
        gl_call!(gl, "glBindVertexArray() call failed.", gl.bind_vertex_array(self.vao));

        self.init_data_bo()?;
        Ok(true)
    }

    fn init_test_case_iteration(&mut self, sparse_bo: GLuint) -> Result<bool, TestError> {
        self.result_bo = sparse_bo;
        Ok(true)
    }

    fn execute(&mut self, sparse_bo_storage_flags: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut result = true;
        let page_size = self.page_size as u32;
        let is_ia_iteration = self.tf_type == 0;

        gl_call!(
            gl,
            "glUseProgram() call failed.",
            gl.use_program(if is_ia_iteration { self.po_ia } else { self.po_sa })
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.result_bo)
        );

        let draw_call_count: usize;
        let mut draw_call_first_instance_id = [-1i32; 2];
        let mut draw_call_first_vertex_id = [-1i32; 2];
        let mut draw_call_n_instances = [0i32; 2];
        let mut draw_call_n_vertices = [0i32; 2];
        let draw_call_is_vertex_id_ascending: bool;
        let draw_call_type = self.draw_call_type;
        let mut n_result_bytes_per_instance = [0u32; 2];
        let n_result_bytes_per_vertex = 4 * 2;

        gl_call!(gl, "glBindBuffer() call(s) failed.", {
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.data_bo);
            gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.data_bo);
        });

        if self.all_pages_committed {
            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    self.result_bo_size_rounded as glw::GLintptr,
                    glw::GL_TRUE as glw::GLboolean
                )
            );
        } else {
            for n_page in 0..self.result_bo_size_rounded / page_size {
                // SAFETY: the errors of the commits are checked once after the loop, as upstream does.
                unsafe {
                    gl.buffer_page_commitment_arb(
                        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                        (n_page * page_size) as glw::GLintptr,
                        page_size as GLsizeiptr,
                        (if n_page % 2 == 0 { glw::GL_TRUE } else { glw::GL_FALSE }) as glw::GLboolean,
                    )
                };
            }
            crate::glu::expect_no_error(gl, "glBufferPageCommitmentARB() call failed.")?;
        }

        let data_zero: u8 = 0;
        gl_call!(
            gl,
            "glClearBufferData() call failed.",
            gl.clear_buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                glw::GL_R8,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::from_ref(&data_zero).cast()
            )
        );

        if is_ia_iteration {
            gl_call!(
                gl,
                "glBindBufferRange() call failed.",
                gl.bind_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    self.result_bo,
                    0,
                    self.result_bo_size as GLsizeiptr
                )
            );
        } else {
            gl_call!(gl, "glBindBufferRange() call(s) failed.", {
                gl.bind_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    self.result_bo,
                    0,
                    (self.result_bo_size / 2) as GLsizeiptr,
                );
                gl.bind_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    1,
                    self.result_bo,
                    (self.result_bo_size / 2) as glw::GLintptr,
                    (self.result_bo_size / 2) as GLsizeiptr,
                );
            });
        }

        gl_call!(
            gl,
            "glBeginTransformFeedback() call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        let nv = self.n_vertices_per_instance as GLsizei;
        let index_offset = self.data_bo_index_data_offset as usize as *const std::ffi::c_void;
        let n_instances = self.n_instances_to_test as GLsizei;
        let base_vertex = self.draw_call_base_vertex as GLint;
        let base_instance = self.draw_call_base_instance;
        let first = self.draw_call_first as GLint;
        let index_at = |index: u32| self.index_data[((index - self.data_bo_index_data_offset) / 4) as usize];
        let multi_index_pointers = [
            self.multidrawcall_index[0] as usize as *const std::ffi::c_void,
            self.multidrawcall_index[1] as usize as *const std::ffi::c_void,
        ];

        let n_result_bytes_total: u32 = match draw_call_type {
            DRAW_CALL_INDEXED => {
                gl_call!(
                    gl,
                    "glDrawElements() call failed.",
                    gl.draw_elements(glw::GL_POINTS, nv, glw::GL_UNSIGNED_INT, index_offset)
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = nv;
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances[0] = 1;
                draw_call_n_vertices[0] = nv;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * nv as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_INDEXED_BASE_VERTEX => {
                gl_call!(
                    gl,
                    "glDrawElementsBaseVertex() call failed.",
                    gl.draw_elements_base_vertex(glw::GL_POINTS, nv, glw::GL_UNSIGNED_INT, index_offset, base_vertex)
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = base_vertex + nv;
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances[0] = 1;
                draw_call_n_vertices[0] = nv;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * nv as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_INDEXED_INDIRECT => {
                gl_call!(
                    gl,
                    "glDrawElementsIndirect() call failed.",
                    gl.draw_elements_indirect(
                        glw::GL_POINTS,
                        glw::GL_UNSIGNED_INT,
                        self.data_bo_indexed_indirect_arg_offset as usize as *const std::ffi::c_void
                    )
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] =
                    self.draw_call_base_vertex
                        .wrapping_add(index_at(self.multidrawcall_index[1])) as i32;
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances[0] = n_instances;
                draw_call_n_vertices[0] = self.multidrawcall_count[1];
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * draw_call_n_vertices[0] as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_INDEXED_INDIRECT_MULTI => {
                gl_call!(
                    gl,
                    "glMultiDrawElementsIndirect() call failed.",
                    gl.multi_draw_elements_indirect(
                        glw::GL_POINTS,
                        glw::GL_UNSIGNED_INT,
                        self.data_bo_indexed_mdi_arg_offset as usize as *const std::ffi::c_void,
                        self.multidrawcall_drawcount as GLsizei,
                        0
                    )
                );
                draw_call_count = self.multidrawcall_drawcount as usize;
                draw_call_first_instance_id = [0, 0];
                draw_call_first_vertex_id[0] =
                    self.draw_call_base_vertex
                        .wrapping_add(index_at(self.multidrawcall_index[0])) as i32;
                draw_call_first_vertex_id[1] =
                    self.draw_call_base_vertex
                        .wrapping_add(index_at(self.multidrawcall_index[1])) as i32;
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances = [1, n_instances];
                draw_call_n_vertices = self.multidrawcall_count;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * draw_call_n_vertices[0] as u32;
                n_result_bytes_per_instance[1] = n_result_bytes_per_vertex * draw_call_n_vertices[1] as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
                    + n_result_bytes_per_instance[1] * draw_call_n_instances[1] as u32
            }
            DRAW_CALL_INDEXED_MULTI => {
                gl_call!(
                    gl,
                    "glMultiDrawElements() call failed",
                    gl.multi_draw_elements(
                        glw::GL_POINTS,
                        self.multidrawcall_count.as_ptr(),
                        glw::GL_UNSIGNED_INT,
                        multi_index_pointers.as_ptr(),
                        self.multidrawcall_drawcount as GLsizei
                    )
                );
                draw_call_count = self.multidrawcall_drawcount as usize;
                draw_call_first_instance_id = [0, 0];
                draw_call_first_vertex_id[0] = index_at(self.multidrawcall_index[0]) as i32;
                draw_call_first_vertex_id[1] = index_at(self.multidrawcall_index[1]) as i32;
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances = [1, 1];
                draw_call_n_vertices = self.multidrawcall_count;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * self.multidrawcall_count[0] as u32;
                n_result_bytes_per_instance[1] = n_result_bytes_per_vertex * self.multidrawcall_count[1] as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
                    + n_result_bytes_per_instance[1] * draw_call_n_instances[1] as u32
            }
            DRAW_CALL_INDEXED_MULTI_BASE_VERTEX => {
                gl_call!(
                    gl,
                    "glMultiDrawElementsBaseVertex() call failed.",
                    gl.multi_draw_elements_base_vertex(
                        glw::GL_POINTS,
                        self.multidrawcall_count.as_ptr(),
                        glw::GL_UNSIGNED_INT,
                        multi_index_pointers.as_ptr(),
                        self.multidrawcall_drawcount as GLsizei,
                        self.multidrawcall_base_vertex.as_ptr()
                    )
                );
                draw_call_count = self.multidrawcall_drawcount as usize;
                draw_call_first_instance_id = [0, 0];
                draw_call_first_vertex_id[0] = (self.multidrawcall_base_vertex[0] as u32)
                    .wrapping_add(index_at(self.multidrawcall_index[0]))
                    as i32;
                draw_call_first_vertex_id[1] = (self.multidrawcall_base_vertex[1] as u32)
                    .wrapping_add(index_at(self.multidrawcall_index[1]))
                    as i32;
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances = [1, 1];
                draw_call_n_vertices = self.multidrawcall_count;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * self.multidrawcall_count[0] as u32;
                n_result_bytes_per_instance[1] = n_result_bytes_per_vertex * self.multidrawcall_count[1] as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
                    + n_result_bytes_per_instance[1] * draw_call_n_instances[1] as u32
            }
            DRAW_CALL_INSTANCED_INDEXED => {
                gl_call!(
                    gl,
                    "glDrawElementsInstanced() call failed.",
                    gl.draw_elements_instanced(glw::GL_POINTS, nv, glw::GL_UNSIGNED_INT, index_offset, n_instances)
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = self.index_data[0] as i32;
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances[0] = n_instances;
                draw_call_n_vertices[0] = nv;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * nv as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_INSTANCED_INDEXED_BASE_VERTEX => {
                gl_call!(
                    gl,
                    "glDrawElementsInstancedBaseVertex() call failed.",
                    gl.draw_elements_instanced_base_vertex(
                        glw::GL_POINTS,
                        nv,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        n_instances,
                        base_vertex
                    )
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = base_vertex.wrapping_add(self.index_data[0] as i32);
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances[0] = n_instances;
                draw_call_n_vertices[0] = nv;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * nv as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_INSTANCED_INDEXED_BASE_VERTEX_BASE_INSTANCE => {
                gl_call!(
                    gl,
                    "glDrawElementsInstancedBaseVertexBaseInstance() call failed.",
                    gl.draw_elements_instanced_base_vertex_base_instance(
                        glw::GL_POINTS,
                        nv,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        n_instances,
                        base_vertex,
                        base_instance
                    )
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = base_vertex.wrapping_add(self.index_data[0] as i32);
                draw_call_is_vertex_id_ascending = false;
                draw_call_n_instances[0] = n_instances;
                draw_call_n_vertices[0] = nv;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * nv as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_REGULAR => {
                gl_call!(
                    gl,
                    "glDrawArrays() call failed",
                    gl.draw_arrays(glw::GL_POINTS, first, nv)
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = first;
                draw_call_is_vertex_id_ascending = true;
                draw_call_n_instances[0] = 1;
                draw_call_n_vertices[0] = nv;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * nv as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_REGULAR_INDIRECT => {
                gl_call!(
                    gl,
                    "glDrawArraysIndirect() call failed.",
                    gl.draw_arrays_indirect(
                        glw::GL_POINTS,
                        self.data_bo_regular_indirect_arg_offset as usize as *const std::ffi::c_void
                    )
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = first;
                draw_call_is_vertex_id_ascending = true;
                draw_call_n_instances[0] = n_instances;
                draw_call_n_vertices[0] = self.multidrawcall_count[1];
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * draw_call_n_vertices[0] as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_REGULAR_INDIRECT_MULTI => {
                gl_call!(
                    gl,
                    "glMultiDrawArraysIndirect() call failed.",
                    gl.multi_draw_arrays_indirect(
                        glw::GL_POINTS,
                        self.data_bo_regular_mdi_arg_offset as usize as *const std::ffi::c_void,
                        self.multidrawcall_drawcount as GLsizei,
                        0
                    )
                );
                draw_call_count = 2;
                draw_call_first_instance_id = [0, 0];
                draw_call_first_vertex_id = [first, first];
                draw_call_is_vertex_id_ascending = true;
                draw_call_n_instances = [1, n_instances];
                draw_call_n_vertices = self.multidrawcall_count;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * draw_call_n_vertices[0] as u32;
                n_result_bytes_per_instance[1] = n_result_bytes_per_vertex * draw_call_n_vertices[1] as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
                    + n_result_bytes_per_instance[1] * draw_call_n_instances[1] as u32
            }
            DRAW_CALL_REGULAR_INSTANCED => {
                gl_call!(
                    gl,
                    "glDrawArraysInstanced() call failed.",
                    gl.draw_arrays_instanced(glw::GL_POINTS, first, nv, n_instances)
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = first;
                draw_call_is_vertex_id_ascending = true;
                draw_call_n_instances[0] = n_instances;
                draw_call_n_vertices[0] = nv;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * draw_call_n_vertices[0] as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_REGULAR_INSTANCED_BASE_INSTANCE => {
                gl_call!(
                    gl,
                    "glDrawArraysInstancedBaseInstance() call failed.",
                    gl.draw_arrays_instanced_base_instance(glw::GL_POINTS, first, nv, n_instances, base_instance)
                );
                draw_call_count = 1;
                draw_call_first_instance_id[0] = 0;
                draw_call_first_vertex_id[0] = first;
                draw_call_is_vertex_id_ascending = true;
                draw_call_n_instances[0] = n_instances;
                draw_call_n_vertices[0] = nv;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * draw_call_n_vertices[0] as u32;
                n_result_bytes_per_instance[0] * draw_call_n_instances[0] as u32
            }
            DRAW_CALL_REGULAR_MULTI => {
                gl_call!(
                    gl,
                    "glMultiDrawArrays() call failed.",
                    gl.multi_draw_arrays(
                        glw::GL_POINTS,
                        self.multidrawcall_first.as_ptr(),
                        self.multidrawcall_count.as_ptr(),
                        self.multidrawcall_drawcount as GLsizei
                    )
                );
                draw_call_count = self.multidrawcall_drawcount as usize;
                draw_call_first_instance_id = [0, 0];
                draw_call_first_vertex_id = self.multidrawcall_first;
                draw_call_is_vertex_id_ascending = true;
                draw_call_n_instances = [1, 1];
                draw_call_n_vertices = self.multidrawcall_count;
                n_result_bytes_per_instance[0] = n_result_bytes_per_vertex * self.multidrawcall_count[0] as u32;
                n_result_bytes_per_instance[1] = n_result_bytes_per_vertex * self.multidrawcall_count[1] as u32;
                n_result_bytes_per_instance[0] + n_result_bytes_per_instance[1]
            }
            _ => return fail("Unrecognized draw call type"),
        };

        gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());

        let mappable_bo_id = self.helper_bo;

        gl_call!(gl, "glBindBuffer() call(s) failed.", {
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.result_bo);
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, self.helper_bo);
        });

        if is_ia_iteration {
            gl_call!(
                gl,
                "glCopyBufferSubData() call failed.",
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_COPY_WRITE_BUFFER,
                    0,
                    0,
                    n_result_bytes_total as GLsizeiptr
                )
            );
        } else {
            gl_call!(gl, "glCopyBufferSubData() call failed.", {
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_COPY_WRITE_BUFFER,
                    0,
                    0,
                    (n_result_bytes_total / 2) as GLsizeiptr,
                );
                gl.copy_buffer_sub_data(
                    glw::GL_COPY_READ_BUFFER,
                    glw::GL_COPY_WRITE_BUFFER,
                    (self.result_bo_size / 2) as glw::GLintptr,
                    (self.result_bo_size / 2) as glw::GLintptr,
                    (n_result_bytes_total / 2) as GLsizeiptr,
                );
            });
        }

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, mappable_bo_id)
        );

        // SAFETY: a read-only mapping of the helper buffer, which holds `result_bo_size` bytes.
        let mapped = unsafe {
            gl.map_buffer_range(
                glw::GL_ARRAY_BUFFER,
                0,
                self.result_bo_size as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        };
        crate::glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;

        if mapped.is_null() {
            return Ok(false);
        }

        // SAFETY: the mapping is `result_bo_size` bytes long and stays valid until the unmap below.
        let result_data = unsafe { std::slice::from_raw_parts(mapped.cast::<u32>(), self.result_bo_size as usize / 4) };

        let mut continue_checking = true;
        let (result_instance_id_stride, result_vertex_id_stride) =
            if is_ia_iteration { (2usize, 2usize) } else { (1, 1) };

        for n_draw_call in 0..draw_call_count {
            if !continue_checking {
                break;
            }

            for n_instance in 0..draw_call_n_instances[n_draw_call] {
                if !continue_checking {
                    break;
                }

                let expected_instance_id = draw_call_first_instance_id[n_draw_call].wrapping_add(n_instance) as u32;

                let mut instance_index: usize = 0;
                let mut vertex_index: usize;

                if is_ia_iteration {
                    for n_prev_draw_call in 0..n_draw_call {
                        instance_index += (draw_call_n_instances[n_prev_draw_call] as u32
                            * n_result_bytes_per_instance[n_prev_draw_call]
                            / 4) as usize;
                    }
                    instance_index += (n_instance as u32 * n_result_bytes_per_instance[n_draw_call] / 4) as usize;
                    vertex_index = instance_index + 1;
                } else {
                    for n_prev_draw_call in 0..n_draw_call {
                        instance_index += (draw_call_n_instances[n_prev_draw_call] as u32
                            * n_result_bytes_per_instance[n_prev_draw_call]
                            / 2
                            / 4) as usize;
                    }
                    instance_index += (n_instance as u32 * n_result_bytes_per_instance[n_draw_call] / 2 / 4) as usize;
                    vertex_index = instance_index + (self.result_bo_size / 2 / 4) as usize;
                }

                for n_point in 0..draw_call_n_vertices[n_draw_call] {
                    let expected_vertex_id: u32 = if draw_call_is_vertex_id_ascending {
                        draw_call_first_vertex_id[n_draw_call].wrapping_add(n_point) as u32
                    } else if draw_call_first_vertex_id[n_draw_call] >= n_point {
                        (draw_call_first_vertex_id[n_draw_call] - n_point) as u32
                    } else {
                        0
                    };

                    let backed = |word_index: usize| {
                        let offset = word_index as u32 * 4;
                        (offset / page_size).is_multiple_of(2) && ((offset + 4 - 1) / page_size).is_multiple_of(2)
                    };
                    let result_instance_id_page_has_physical_backing = backed(instance_index);
                    let result_vertex_id_page_has_physical_backing = backed(vertex_index);

                    let retrieved_instance_id = result_data[instance_index];
                    instance_index += result_instance_id_stride;
                    let retrieved_vertex_id = result_data[vertex_index];
                    vertex_index += result_vertex_id_stride;

                    if (result_instance_id_page_has_physical_backing && retrieved_instance_id != expected_instance_id)
                        || (result_vertex_id_page_has_physical_backing && retrieved_vertex_id != expected_vertex_id)
                    {
                        log::info!(
                            "For [{}], sparse BO flags [{sparse_bo_storage_flags:#x}], draw call type {} at index [{n_draw_call} / {}], TF mode [{}], instance [{n_instance} / {}], point at index [{n_point} / {}], VS-level gl_VertexID was equal to [{retrieved_vertex_id}] and gl_InstanceID was set to [{retrieved_instance_id}], whereas gl_VertexID of value [{expected_vertex_id}] and gl_InstanceID of value [{expected_instance_id}] were anticipated.",
                            if self.all_pages_committed { "case_b1" } else { "case_b2" },
                            DRAW_CALL_NAMES[draw_call_type],
                            draw_call_count - 1,
                            if is_ia_iteration {
                                "interleaved attribs"
                            } else {
                                "separate attribs"
                            },
                            draw_call_n_instances[n_draw_call] - 1,
                            draw_call_n_vertices[n_draw_call] - 1
                        );
                        continue_checking = false;
                        result = false;
                        break;
                    }
                }
            }

            gl_call!(
                gl,
                "glBufferPageCommitmentARB() call failed.",
                gl.buffer_page_commitment_arb(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    self.result_bo_size_rounded as glw::GLintptr,
                    glw::GL_FALSE as glw::GLboolean
                )
            );
        }

        gl_call!(
            gl,
            "glUnmapBuffer() call failed.",
            gl.unmap_buffer(glw::GL_ARRAY_BUFFER)
        );
        Ok(result)
    }

    fn deinit_test_case_iteration(&mut self) -> Result<(), TestError> {
        Ok(())
    }
}

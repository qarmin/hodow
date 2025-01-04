// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cVertexAttrib64BitTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `VAOTest` of the vertex_attrib_64bit group; the buffers upstream fills through unaligned `double *` / `unsigned short *` stores are filled with `to_ne_bytes` and read back the same way.

use std::ffi::c_void;

use super::vertex_attrib_64bit_tests::{iterate_stop, require_extension};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLsizei, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const BO_1_OFFSET_MATRIX: usize = 0;
const BO_1_OFFSET_UBYTE: usize = 72;
const BO_1_OFFSET_SHORT: usize = 73;
const BO_1_OFFSET_DOUBLE: usize = 75;
const BO_2_OFFSET_SBYTE: usize = 0;
const BO_2_OFFSET_MATRIX: usize = 1;

const BO_1_BATCH_SIZE: usize = 96;
const BO_2_BATCH_SIZE: usize = 65;
const N_BATCHES: usize = 1024;
const N_DRAW_CALL_INSTANCES: usize = 4;
const NONZERO_VERTEX_ATTRIB_DIVISOR: usize = 2;

const PO_BO1_DMAT3_ATTR_OFFSET: usize = 0;
const PO_BO1_DMAT3_ATTR_STRIDE: usize = 96;
const PO_BO1_DOUBLE_ATTR_OFFSET: usize = 0;
const PO_BO1_DOUBLE_ATTR_STRIDE: usize = 48;
const PO_BO1_DVEC2_ATTR_OFFSET: usize = 75;
const PO_BO1_DVEC2_ATTR_STRIDE: usize = 96;
const PO_BO1_FLOAT2_ATTR_OFFSET: usize = 73;
const PO_BO1_FLOAT2_ATTR_STRIDE: usize = 96;
const PO_BO1_INT_ATTR_OFFSET: usize = 72;
const PO_BO1_INT_ATTR_STRIDE: usize = 96;
const PO_BO2_DMAT4X2_ATTR_OFFSET: usize = 1;
const PO_BO2_DMAT4X2_ATTR_STRIDE: usize = 65;
const PO_BO2_FLOAT_ATTR_OFFSET: usize = 0;
const PO_BO2_FLOAT_ATTR_STRIDE: usize = 5;

const XFB_BO1_DMAT3_OFFSET: usize = 0;
const XFB_BO1_DMAT3_SIZE: usize = 8 * 3 * 3;
const XFB_BO1_DOUBLE_OFFSET: usize = XFB_BO1_DMAT3_OFFSET + XFB_BO1_DMAT3_SIZE;
const XFB_BO1_DOUBLE_SIZE: usize = 8;
const XFB_BO1_INT_OFFSET: usize = XFB_BO1_DOUBLE_OFFSET + XFB_BO1_DOUBLE_SIZE;
const XFB_BO1_INT_SIZE: usize = 4;
const XFB_BO1_DVEC2_OFFSET: usize = XFB_BO1_INT_OFFSET + XFB_BO1_INT_SIZE;
const XFB_BO1_DVEC2_SIZE: usize = 8 * 2;
const XFB_BO1_FLOAT2_OFFSET: usize = XFB_BO1_DVEC2_OFFSET + XFB_BO1_DVEC2_SIZE;
const XFB_BO1_FLOAT2_SIZE: usize = 4;
const XFB_BO2_DMAT4X2_OFFSET: usize = XFB_BO1_FLOAT2_OFFSET + XFB_BO1_FLOAT2_SIZE;
const XFB_BO2_DMAT4X2_SIZE: usize = 8 * 4 * 2;
const XFB_BO2_FLOAT_OFFSET: usize = XFB_BO2_DMAT4X2_OFFSET + XFB_BO2_DMAT4X2_SIZE;
const XFB_BO2_FLOAT_SIZE: usize = 4;
const XFB_TOTAL_SIZE: usize = XFB_BO1_DMAT3_SIZE
    + XFB_BO1_DOUBLE_SIZE
    + XFB_BO1_INT_SIZE
    + XFB_BO1_DVEC2_SIZE
    + XFB_BO1_FLOAT2_SIZE
    + XFB_BO2_DMAT4X2_SIZE
    + XFB_BO2_FLOAT_SIZE
    + 4;

const VS_CODE: &str = "#version 400\n\n#extension GL_ARB_vertex_attrib_64bit : require\n\nin dmat3   in_bo1_dmat3;\nin double  in_bo1_double;\nin dvec2   in_bo1_dvec2;\nin float   in_bo1_float2;\nin int     in_bo1_int;\nin dmat4x2 in_bo2_dmat4x2;\nin float   in_bo2_float;\n\nout dmat3   out_bo1_dmat3;\nout double  out_bo1_double;\nout dvec2   out_bo1_dvec2;\nout float   out_bo1_float2;\nout int     out_bo1_int;\nout dmat4x2 out_bo2_dmat4x2;\nout float   out_bo2_float;\n\nvoid main()\n{\n    out_bo1_dmat3   = in_bo1_dmat3;\n    out_bo1_double  = in_bo1_double;\n    out_bo1_dvec2   = in_bo1_dvec2;\n    out_bo1_int     = in_bo1_int;\n    out_bo1_float2  = in_bo1_float2;\n    out_bo2_dmat4x2 = in_bo2_dmat4x2;\n    out_bo2_float   = in_bo2_float;\n}\n";

/// `_draw_call_type`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawCallType {
    Arrays,
    Elements,
}

fn read_f64(data: &[u8], offset: usize) -> f64 {
    f64::from_ne_bytes(data[offset..offset + 8].try_into().expect("8 bytes"))
}

fn read_f32(data: &[u8], offset: usize) -> f32 {
    f32::from_ne_bytes(data[offset..offset + 4].try_into().expect("4 bytes"))
}

fn read_i32(data: &[u8], offset: usize) -> i32 {
    i32::from_ne_bytes(data[offset..offset + 4].try_into().expect("4 bytes"))
}

fn read_u16(data: &[u8], offset: usize) -> u16 {
    u16::from_ne_bytes(data[offset..offset + 2].try_into().expect("2 bytes"))
}

fn doubles(data: &[u8], offset: usize, count: usize) -> Vec<f64> {
    (0..count).map(|i| read_f64(data, offset + 8 * i)).collect()
}

/// The state of `VAOTest`
struct Vao {
    bo_1_data: Vec<u8>,
    bo_2_data: Vec<u8>,
    bo_index_data: Vec<u16>,
    bo_id_1: GLuint,
    bo_id_2: GLuint,
    bo_id_indices: GLuint,
    bo_id_result: GLuint,
    po_bo1_dmat3_attr_location: GLint,
    po_bo2_dmat4x2_attr_location: GLint,
    po_bo1_double_attr_location: GLint,
    po_bo1_dvec2_attr_location: GLint,
    po_bo1_float2_attr_location: GLint,
    po_bo1_int_attr_location: GLint,
    po_bo2_float_attr_location: GLint,
    po_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl Vao {
    fn new() -> Self {
        Self {
            bo_1_data: Vec::new(),
            bo_2_data: Vec::new(),
            bo_index_data: Vec::new(),
            bo_id_1: 0,
            bo_id_2: 0,
            bo_id_indices: 0,
            bo_id_result: 0,
            po_bo1_dmat3_attr_location: -1,
            po_bo2_dmat4x2_attr_location: -1,
            po_bo1_double_attr_location: -1,
            po_bo1_dvec2_attr_location: -1,
            po_bo1_float2_attr_location: -1,
            po_bo1_int_attr_location: -1,
            po_bo2_float_attr_location: -1,
            po_id: 0,
            vao_id: 0,
            vs_id: 0,
        }
    }

    /// `VAOTest::deinit`
    fn deinit(&mut self, gl: &glw::Functions) {
        // SAFETY: deletes the names this test created, on the current context.
        unsafe {
            for id in [
                &mut self.bo_id_1,
                &mut self.bo_id_2,
                &mut self.bo_id_indices,
                &mut self.bo_id_result,
            ] {
                if *id != 0 {
                    gl.delete_buffers(1, id);
                    *id = 0;
                }
            }
            if self.po_id != 0 {
                gl.delete_program(self.po_id);
                self.po_id = 0;
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
                self.vao_id = 0;
            }
            if self.vs_id != 0 {
                gl.delete_shader(self.vs_id);
                self.vs_id = 0;
            }
        }
    }

    /// `VAOTest::initBuffers`
    fn init_buffers(&mut self) {
        self.bo_1_data = vec![0u8; BO_1_BATCH_SIZE * N_BATCHES];
        self.bo_2_data = vec![0u8; BO_2_BATCH_SIZE * N_BATCHES];
        self.bo_index_data = vec![0u16; N_BATCHES];

        for (n_index, index) in self.bo_index_data.iter_mut().enumerate() {
            *index = (N_BATCHES - 1 - n_index) as u16;
        }

        // 3x3 matrix data in BO1
        for n_matrix in 0..N_BATCHES {
            for n_element in 0..9 {
                let offset = n_matrix * BO_1_BATCH_SIZE + BO_1_OFFSET_MATRIX + n_element * 8;
                self.bo_1_data[offset..offset + 8]
                    .copy_from_slice(&((n_matrix * 3 * 3 + n_element + 1) as f64).to_ne_bytes());
            }
        }

        // unsigned byte data in BO1
        for n_element in 0..N_BATCHES {
            self.bo_1_data[n_element * BO_1_BATCH_SIZE + BO_1_OFFSET_UBYTE] = n_element as u8;
        }

        // short data in BO1
        for n_element in 0..N_BATCHES {
            let offset = n_element * BO_1_BATCH_SIZE + BO_1_OFFSET_SHORT;
            self.bo_1_data[offset..offset + 2].copy_from_slice(&(n_element as u16).to_ne_bytes());
        }

        // 2 doubles data in BO1
        for n_batch in 0..N_BATCHES {
            let offset = n_batch * BO_1_BATCH_SIZE + BO_1_OFFSET_DOUBLE;
            self.bo_1_data[offset..offset + 8].copy_from_slice(&((2 * n_batch) as f64).to_ne_bytes());
            self.bo_1_data[offset + 8..offset + 16].copy_from_slice(&((2 * n_batch + 1) as f64).to_ne_bytes());
        }

        // signed byte data in BO2
        for n_element in 0..N_BATCHES {
            self.bo_2_data[n_element * BO_2_BATCH_SIZE + BO_2_OFFSET_SBYTE] = (n_element as i8) as u8;
        }

        // 4x2 matrix data in BO2
        for n_matrix in 0..N_BATCHES {
            for n_element in 0..8 {
                let offset = n_matrix * BO_2_BATCH_SIZE + BO_2_OFFSET_MATRIX + 8 * n_element;
                self.bo_2_data[offset..offset + 8]
                    .copy_from_slice(&((n_matrix * 4 * 2 + n_element) as f64).to_ne_bytes());
            }
        }
    }

    /// `VAOTest::initBufferObjects`
    fn init_buffer_objects(&mut self, gl: &glw::Functions) -> Result<(), TestError> {
        gl_call!(gl, "glGenBuffers() call(s) failed.", {
            gl.gen_buffers(1, &mut self.bo_id_1);
            gl.gen_buffers(1, &mut self.bo_id_2);
            gl.gen_buffers(1, &mut self.bo_id_indices);
            gl.gen_buffers(1, &mut self.bo_id_result);
        });

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.bo_id_1)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                self.bo_1_data.len() as GLsizeiptr,
                self.bo_1_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.bo_id_2)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                self.bo_2_data.len() as GLsizeiptr,
                self.bo_2_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.bo_id_indices)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                (self.bo_index_data.len() * 2) as GLsizeiptr,
                self.bo_index_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        // Space for the data XFBed out of the test program: 42 floats, 1 int and 4 bytes of padding for the 8-byte alignment of the fp64 buffer, per batch and instance.
        let xfb_dat_pad = std::mem::size_of::<i32>();
        let xfb_data_size =
            (42 * std::mem::size_of::<f32>() + std::mem::size_of::<i32>() + xfb_dat_pad) * 1024 * N_DRAW_CALL_INSTANCES;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.bo_id_result)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                xfb_data_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.bo_id_result)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.bo_id_result)
        );
        Ok(())
    }

    /// `VAOTest::initProgramObject` (the vertex-only `BuildProgramVSOnly` included)
    fn init_program_object(&mut self, gl: &glw::Functions) -> Result<(), TestError> {
        // SAFETY: object creation on the current context.
        self.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

        let xfb_varyings = [
            c"out_bo1_dmat3".as_ptr(),
            c"out_bo1_double".as_ptr(),
            c"out_bo1_int".as_ptr(),
            c"out_bo1_dvec2".as_ptr(),
            c"out_bo1_float2".as_ptr(),
            c"out_bo2_dmat4x2".as_ptr(),
            c"out_bo2_float".as_ptr(),
            c"gl_SkipComponents1".as_ptr(),
        ];
        gl_call!(
            gl,
            "glTransformFeedbackVaryings() call failed.",
            gl.transform_feedback_varyings(
                self.po_id,
                xfb_varyings.len() as GLsizei,
                xfb_varyings.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS
            )
        );

        // SAFETY: object creation on the current context.
        self.vs_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
        glu::expect_no_error(gl, "CreateShader")?;

        let source = VS_CODE.as_ptr().cast::<glw::GLchar>();
        let length = VS_CODE.len() as GLint;
        let mut status: GLint = 0;
        gl_call!(gl, "ShaderSource", gl.shader_source(self.vs_id, 1, &source, &length));
        gl_call!(gl, "CompileShader", gl.compile_shader(self.vs_id));
        gl_call!(
            gl,
            "GetShaderiv",
            gl.get_shaderiv(self.vs_id, glw::GL_COMPILE_STATUS, &mut status)
        );
        if status == glw::GL_FALSE as GLint {
            let mut message_length: GLint = 0;
            gl_call!(
                gl,
                "GetShaderiv",
                gl.get_shaderiv(self.vs_id, glw::GL_INFO_LOG_LENGTH, &mut message_length)
            );
            let mut message = vec![0u8; message_length as usize + 1];
            gl_call!(
                gl,
                "GetShaderInfoLog",
                gl.get_shader_info_log(
                    self.vs_id,
                    message_length,
                    &mut message_length,
                    message.as_mut_ptr().cast()
                )
            );
            log::info!(
                "Shader compilation error\nCompilation log:\n{}\nShader source:\n{VS_CODE}",
                String::from_utf8_lossy(&message)
            );
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        gl_call!(gl, "AttachShader", gl.attach_shader(self.po_id, self.vs_id));

        gl_call!(gl, "LinkProgram", gl.link_program(self.po_id));
        gl_call!(
            gl,
            "GetProgramiv",
            gl.get_programiv(self.po_id, glw::GL_LINK_STATUS, &mut status)
        );
        if status == glw::GL_FALSE as GLint {
            let mut message_length: GLint = 0;
            gl_call!(
                gl,
                "GetProgramiv",
                gl.get_programiv(self.po_id, glw::GL_INFO_LOG_LENGTH, &mut message_length)
            );
            let mut message = vec![0u8; message_length as usize + 1];
            gl_call!(
                gl,
                "GetProgramInfoLog",
                gl.get_program_info_log(
                    self.po_id,
                    message_length,
                    &mut message_length,
                    message.as_mut_ptr().cast()
                )
            );
            log::info!("Program link error\nLink log:\n{}", String::from_utf8_lossy(&message));
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        // SAFETY: a linked program and NUL-terminated names.
        unsafe {
            self.po_bo1_dmat3_attr_location = gl.get_attrib_location(self.po_id, c"in_bo1_dmat3".as_ptr());
            self.po_bo1_double_attr_location = gl.get_attrib_location(self.po_id, c"in_bo1_double".as_ptr());
            self.po_bo1_dvec2_attr_location = gl.get_attrib_location(self.po_id, c"in_bo1_dvec2".as_ptr());
            self.po_bo1_float2_attr_location = gl.get_attrib_location(self.po_id, c"in_bo1_float2".as_ptr());
            self.po_bo1_int_attr_location = gl.get_attrib_location(self.po_id, c"in_bo1_int".as_ptr());
            self.po_bo2_dmat4x2_attr_location = gl.get_attrib_location(self.po_id, c"in_bo2_dmat4x2".as_ptr());
            self.po_bo2_float_attr_location = gl.get_attrib_location(self.po_id, c"in_bo2_float".as_ptr());
        }
        glu::expect_no_error(gl, "glGetAttribLocation() call(s) failed.")?;

        if [
            self.po_bo1_dmat3_attr_location,
            self.po_bo1_double_attr_location,
            self.po_bo1_dvec2_attr_location,
            self.po_bo1_int_attr_location,
            self.po_bo1_float2_attr_location,
            self.po_bo2_dmat4x2_attr_location,
            self.po_bo2_float_attr_location,
        ]
        .contains(&-1)
        {
            return Err(TestError::Fail(
                "At least one attribute is considered inactive which is invalid.".to_string(),
            ));
        }
        Ok(())
    }

    /// `VAOTest::initVAO`
    fn init_vao(&mut self, gl: &glw::Functions) -> Result<(), TestError> {
        let offset_pointer = |offset: usize| offset as *const c_void;
        const DOUBLE: usize = std::mem::size_of::<f64>();

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(self.vao_id)
        );

        // BO1-sourced attributes
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.bo_id_1)
        );

        let dmat3 = self.po_bo1_dmat3_attr_location as GLuint;
        // SAFETY (all calls until the next error check): attribute locations the linked program reported and byte offsets into the bound buffer.
        unsafe {
            gl.vertex_attrib_l_pointer(
                dmat3,
                3,
                glw::GL_DOUBLE,
                PO_BO1_DMAT3_ATTR_STRIDE as GLsizei,
                offset_pointer(PO_BO1_DMAT3_ATTR_OFFSET),
            );
            gl.vertex_attrib_l_pointer(
                dmat3 + 1,
                3,
                glw::GL_DOUBLE,
                PO_BO1_DMAT3_ATTR_STRIDE as GLsizei,
                offset_pointer(PO_BO1_DMAT3_ATTR_OFFSET + DOUBLE * 3),
            );
            gl.vertex_attrib_l_pointer(
                dmat3 + 2,
                3,
                glw::GL_DOUBLE,
                PO_BO1_DMAT3_ATTR_STRIDE as GLsizei,
                offset_pointer(PO_BO1_DMAT3_ATTR_OFFSET + 2 * DOUBLE * 3),
            );
        }
        glu::expect_no_error(gl, "glVertexAttribLPointer() call(s) failed.")?;

        // SAFETY: as above.
        unsafe {
            gl.enable_vertex_attrib_array(dmat3);
            gl.enable_vertex_attrib_array(dmat3 + 1);
            gl.enable_vertex_attrib_array(dmat3 + 2);
        }
        glu::expect_no_error(gl, "glEnableVertexAttribArray() call(s) failed.")?;

        gl_call!(
            gl,
            "glVertexAttribLPointer() call failed.",
            gl.vertex_attrib_l_pointer(
                self.po_bo1_dvec2_attr_location as GLuint,
                2,
                glw::GL_DOUBLE,
                PO_BO1_DVEC2_ATTR_STRIDE as GLsizei,
                offset_pointer(PO_BO1_DVEC2_ATTR_OFFSET)
            )
        );
        gl_call!(
            gl,
            "glEnableVertexAttribArray() call failed.",
            gl.enable_vertex_attrib_array(self.po_bo1_dvec2_attr_location as GLuint)
        );

        gl_call!(
            gl,
            "glVertexAttribLPointer() call failed.",
            gl.vertex_attrib_l_pointer(
                self.po_bo1_double_attr_location as GLuint,
                1,
                glw::GL_DOUBLE,
                PO_BO1_DOUBLE_ATTR_STRIDE as GLsizei,
                offset_pointer(PO_BO1_DOUBLE_ATTR_OFFSET)
            )
        );
        gl_call!(
            gl,
            "glEnableVertexAttribArray() call failed.",
            gl.enable_vertex_attrib_array(self.po_bo1_double_attr_location as GLuint)
        );

        gl_call!(
            gl,
            "glVertexAttribPointer() call failed.",
            gl.vertex_attrib_pointer(
                self.po_bo1_float2_attr_location as GLuint,
                1,
                glw::GL_SHORT,
                glw::FALSE,
                PO_BO1_FLOAT2_ATTR_STRIDE as GLsizei,
                offset_pointer(PO_BO1_FLOAT2_ATTR_OFFSET)
            )
        );
        gl_call!(
            gl,
            "glEnableVertexAttribArray() call failed.",
            gl.enable_vertex_attrib_array(self.po_bo1_float2_attr_location as GLuint)
        );

        gl_call!(
            gl,
            "glVertexAttribIPointer() call failed.",
            gl.vertex_attrib_i_pointer(
                self.po_bo1_int_attr_location as GLuint,
                1,
                glw::GL_BYTE,
                PO_BO1_INT_ATTR_STRIDE as GLsizei,
                offset_pointer(PO_BO1_INT_ATTR_OFFSET)
            )
        );
        gl_call!(
            gl,
            "glEnableVertexAttribArray() call failed.",
            gl.enable_vertex_attrib_array(self.po_bo1_int_attr_location as GLuint)
        );

        // BO2-sourced attributes
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.bo_id_2)
        );

        gl_call!(
            gl,
            "glVertexAttribPointer() call failed.",
            gl.vertex_attrib_pointer(
                self.po_bo2_float_attr_location as GLuint,
                1,
                glw::GL_UNSIGNED_BYTE,
                glw::TRUE,
                PO_BO2_FLOAT_ATTR_STRIDE as GLsizei,
                offset_pointer(PO_BO2_FLOAT_ATTR_OFFSET)
            )
        );
        gl_call!(
            gl,
            "glEnableVertexAttribArray() call failed.",
            gl.enable_vertex_attrib_array(self.po_bo2_float_attr_location as GLuint)
        );

        let dmat4x2 = self.po_bo2_dmat4x2_attr_location as GLuint;
        // SAFETY: as above.
        unsafe {
            for column in 0..4 {
                gl.vertex_attrib_l_pointer(
                    dmat4x2 + column as GLuint,
                    2,
                    glw::GL_DOUBLE,
                    PO_BO2_DMAT4X2_ATTR_STRIDE as GLsizei,
                    offset_pointer(PO_BO2_DMAT4X2_ATTR_OFFSET + column * 2 * DOUBLE),
                );
            }
        }
        glu::expect_no_error(gl, "glVertexAttribLPointer() call failed.")?;

        // SAFETY: as above.
        unsafe {
            for column in 0..4 {
                gl.enable_vertex_attrib_array(dmat4x2 + column);
            }
        }
        glu::expect_no_error(gl, "glEnableVertexAttribArray() call(s) failed.")?;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.bo_id_indices)
        );
        Ok(())
    }

    /// `VAOTest::executeTest`
    fn execute_test(
        &self,
        gl: &glw::Functions,
        draw_call: DrawCallType,
        instanced: bool,
        zero_vertex_attrib_divisor: bool,
    ) -> Result<bool, TestError> {
        gl_call!(
            gl,
            "glBeginTransformFeedback() call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        let divisor = if zero_vertex_attrib_divisor {
            0
        } else {
            NONZERO_VERTEX_ATTRIB_DIVISOR as GLuint
        };
        let attributes: [GLint; 12] = [
            self.po_bo1_dmat3_attr_location,
            self.po_bo1_dmat3_attr_location + 1,
            self.po_bo1_dmat3_attr_location + 2,
            self.po_bo2_dmat4x2_attr_location,
            self.po_bo2_dmat4x2_attr_location + 1,
            self.po_bo2_dmat4x2_attr_location + 2,
            self.po_bo2_dmat4x2_attr_location + 3,
            self.po_bo1_double_attr_location,
            self.po_bo1_dvec2_attr_location,
            self.po_bo1_float2_attr_location,
            self.po_bo1_int_attr_location,
            self.po_bo2_float_attr_location,
        ];

        for attribute in attributes {
            gl_call!(
                gl,
                "glVertexAttribDivisor() call failed.",
                gl.vertex_attrib_divisor(attribute as GLuint, divisor)
            );
        }

        match draw_call {
            DrawCallType::Arrays => {
                if instanced {
                    gl_call!(
                        gl,
                        "glDrawArraysInstanced() call failed",
                        gl.draw_arrays_instanced(
                            glw::GL_POINTS,
                            0,
                            N_BATCHES as GLsizei,
                            N_DRAW_CALL_INSTANCES as GLsizei
                        )
                    );
                } else {
                    gl_call!(
                        gl,
                        "glDrawArrays() call failed.",
                        gl.draw_arrays(glw::GL_POINTS, 0, N_BATCHES as GLsizei)
                    );
                }
            }
            DrawCallType::Elements => {
                if instanced {
                    gl_call!(
                        gl,
                        "glDrawElementsInstanced() call failed.",
                        gl.draw_elements_instanced(
                            glw::GL_POINTS,
                            N_BATCHES as GLsizei,
                            glw::GL_UNSIGNED_SHORT,
                            std::ptr::null(),
                            N_DRAW_CALL_INSTANCES as GLsizei
                        )
                    );
                } else {
                    gl_call!(
                        gl,
                        "glDrawElements() call failed.",
                        gl.draw_elements(
                            glw::GL_POINTS,
                            N_BATCHES as GLsizei,
                            glw::GL_UNSIGNED_SHORT,
                            std::ptr::null()
                        )
                    );
                }
            }
        }

        gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());

        // SAFETY: maps the buffer bound to the transform feedback target.
        let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
        glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

        let xfb_data_size = XFB_TOTAL_SIZE * N_BATCHES * N_DRAW_CALL_INSTANCES;
        // SAFETY: the mapping covers the whole result buffer, `xfb_data_size` bytes (see `init_buffer_objects`).
        let data = unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), xfb_data_size) };
        let result = self.verify_xfb_data(data, draw_call, instanced, zero_vertex_attrib_divisor);

        gl_call!(
            gl,
            "glUnmapBuffer() call failed.",
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
        );
        Ok(result)
    }

    /// `VAOTest::verifyXFBData`
    fn verify_xfb_data(
        &self,
        xfb_data: &[u8],
        draw_call: DrawCallType,
        instanced: bool,
        zero_vertex_attrib_divisor: bool,
    ) -> bool {
        let epsilon = 1e-5f32;
        let is_indiced = draw_call == DrawCallType::Elements;
        let n_instances = if instanced { N_DRAW_CALL_INSTANCES } else { 1 };
        let mut result = true;

        let bo_1 = &self.bo_1_data;
        let bo_2 = &self.bo_2_data;

        for n_instance in 0..n_instances {
            // The input index of the element and the offset of its XFBed record in the result buffer.
            let indices = |n_element: usize| {
                let in_index = if zero_vertex_attrib_divisor {
                    n_element
                } else {
                    n_instance / NONZERO_VERTEX_ATTRIB_DIVISOR
                };
                let xfb_index = if is_indiced {
                    self.bo_index_data[n_element] as usize
                } else {
                    n_element
                };
                (in_index, (N_BATCHES * n_instance + xfb_index) * XFB_TOTAL_SIZE)
            };

            // dmat3 data from BO1
            for n_element in 0..N_BATCHES {
                let (in_index, xfb_record) = indices(n_element);
                let in_offset = in_index * PO_BO1_DMAT3_ATTR_STRIDE + PO_BO1_DMAT3_ATTR_OFFSET;
                let xfb_offset = xfb_record + XFB_BO1_DMAT3_OFFSET;

                if bo_1[in_offset..in_offset + XFB_BO1_DMAT3_SIZE]
                    != xfb_data[xfb_offset..xfb_offset + XFB_BO1_DMAT3_SIZE]
                {
                    log::info!(
                        "BO1 dmat3 attribute values mismatch for batch [{n_element}], expected:{:?}, XFBed out:{:?}",
                        doubles(bo_1, in_offset, 9),
                        doubles(xfb_data, xfb_offset, 9)
                    );
                    result = false;
                    break;
                }
            }

            // float data from BO2
            for n_batch in 0..N_BATCHES {
                let (in_index, xfb_record) = indices(n_batch);
                let expected_value =
                    f32::from(bo_2[in_index * PO_BO2_FLOAT_ATTR_STRIDE + PO_BO2_FLOAT_ATTR_OFFSET]) / 255.0;
                let xfb_value = read_f32(xfb_data, xfb_record + XFB_BO2_FLOAT_OFFSET);

                if (expected_value - xfb_value).abs() > epsilon {
                    log::info!(
                        "BO2 float attribute value mismatch for batch [{n_batch}], expected: [{expected_value}], XFBed out:[{xfb_value}]"
                    );
                    result = false;
                    break;
                }
            }

            // dvec2 data from BO1
            for n_element in 0..N_BATCHES {
                let (in_index, xfb_record) = indices(n_element);
                let in_offset = in_index * PO_BO1_DVEC2_ATTR_STRIDE + PO_BO1_DVEC2_ATTR_OFFSET;
                let xfb_offset = xfb_record + XFB_BO1_DVEC2_OFFSET;

                if bo_1[in_offset..in_offset + XFB_BO1_DVEC2_SIZE]
                    != xfb_data[xfb_offset..xfb_offset + XFB_BO1_DVEC2_SIZE]
                {
                    log::info!(
                        "BO1 dvec2 attribute values mismatch for batch [{n_element}], expected:{:?}, XFBed out:{:?}",
                        doubles(bo_1, in_offset, 2),
                        doubles(xfb_data, xfb_offset, 2)
                    );
                    result = false;
                    break;
                }
            }

            // double data from BO1
            for n_element in 0..N_BATCHES {
                let (in_index, xfb_record) = indices(n_element);
                let in_offset = in_index * PO_BO1_DOUBLE_ATTR_STRIDE + PO_BO1_DOUBLE_ATTR_OFFSET;
                let xfb_offset = xfb_record + XFB_BO1_DOUBLE_OFFSET;

                if bo_1[in_offset..in_offset + XFB_BO1_DOUBLE_SIZE]
                    != xfb_data[xfb_offset..xfb_offset + XFB_BO1_DOUBLE_SIZE]
                {
                    log::info!(
                        "BO1 double attribute value mismatch for batch [{n_element}], expected: [{}], XFBed out:[{}]",
                        read_f64(bo_1, in_offset),
                        read_f64(xfb_data, xfb_offset)
                    );
                    result = false;
                    break;
                }
            }

            // dmat4x2 data from BO2
            for n_element in 0..N_BATCHES {
                let (in_index, xfb_record) = indices(n_element);
                let in_offset = in_index * PO_BO2_DMAT4X2_ATTR_STRIDE + PO_BO2_DMAT4X2_ATTR_OFFSET;
                let xfb_offset = xfb_record + XFB_BO2_DMAT4X2_OFFSET;

                if bo_2[in_offset..in_offset + XFB_BO2_DMAT4X2_SIZE]
                    != xfb_data[xfb_offset..xfb_offset + XFB_BO2_DMAT4X2_SIZE]
                {
                    log::info!(
                        "BO2 dmat4x2 attribute values mismatch for batch [{n_element}], expected:{:?}, XFBed out:{:?}",
                        &bo_2[in_offset..in_offset + 8],
                        &xfb_data[xfb_offset..xfb_offset + 8]
                    );
                    result = false;
                    break;
                }
            }

            // int data from BO1
            for n_element in 0..N_BATCHES {
                let (in_index, xfb_record) = indices(n_element);
                let in_value = i32::from(bo_1[in_index * PO_BO1_INT_ATTR_STRIDE + PO_BO1_INT_ATTR_OFFSET] as i8);
                let xfb_value = read_i32(xfb_data, xfb_record + XFB_BO1_INT_OFFSET);

                if (in_value - xfb_value).abs() > 0 {
                    log::info!(
                        "BO1 int attribute value mismatch for batch [{n_element}], expected: [{in_value}], XFBed out:[{xfb_value}]"
                    );
                    result = false;
                    break;
                }
            }

            // float data from BO1
            for n_element in 0..N_BATCHES {
                let (in_index, xfb_record) = indices(n_element);
                let in_value = read_u16(bo_1, in_index * PO_BO1_FLOAT2_ATTR_STRIDE + PO_BO1_FLOAT2_ATTR_OFFSET);
                let xfb_value = read_f32(xfb_data, xfb_record + XFB_BO1_FLOAT2_OFFSET);

                if (f32::from(in_value) - xfb_value).abs() > epsilon {
                    log::info!(
                        "BO1 float attribute value mismatch for batch [{n_element}], expected: [{in_value}], XFBed out:[{xfb_value}]"
                    );
                    result = false;
                    break;
                }
            }
        }

        result
    }
}

/// `VAOTest::iterate` (`deinit` runs whether or not an error escaped)
fn run(context: &Context, vao: &mut Vao) -> TestOutcome {
    let gl = context.gl();
    let mut result = true;

    require_extension(context, "GL_ARB_vertex_attrib_64bit")?;

    vao.init_buffers();
    vao.init_buffer_objects(gl)?;
    vao.init_program_object(gl)?;
    vao.init_vao(gl)?;

    gl_call!(gl, "glUseProgram() call failed.", gl.use_program(vao.po_id));

    for draw_call in [DrawCallType::Arrays, DrawCallType::Elements] {
        for instanced_draw_call in [false, true] {
            for zero_vertex_attrib_divisor in [true, false] {
                result &= vao.execute_test(gl, draw_call, instanced_draw_call, zero_vertex_attrib_divisor)?;
            }
        }
    }

    iterate_stop(result)
}

pub(super) struct VaoTest;

impl TestCase for VaoTest {
    fn name(&self) -> &str {
        "vao"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut vao = Vao::new();
        let outcome = run(context, &mut vao);
        vao.deinit(context.gl());
        outcome
    }
}

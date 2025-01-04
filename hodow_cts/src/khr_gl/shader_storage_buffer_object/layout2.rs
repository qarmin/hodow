// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderStorageBufferObjectTests.cpp  (BasicStdLayoutBase2/3, BasicOperationsBase, BasicMatrixOperationsBase and their cases)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `GetInput*` data builders are in `layout2_inputs.rs` (generated); the vertex-stage flavours read back with `glGetBufferSubData` and have no fragment shader, as upstream. Written without compiling.

use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLuint};
use crate::khr_gl::es31_ssbo::layout::compare_bytes;
use crate::khr_gl::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};

pub(super) type GetInput4 = fn() -> ([Vec<u8>; 4], &'static str);
pub(super) type GetInputOp = fn() -> (Vec<u8>, Vec<u8>, &'static str);
pub(super) type GetInput2 = fn() -> ([Vec<u8>; 2], &'static str);
pub(super) type GetInputMat = fn() -> (Vec<f32>, Vec<f32>, &'static str);

/// `glGetBufferSubData` of `len` bytes of the bound `GL_SHADER_STORAGE_BUFFER`.
fn read_sub_data<T: Copy + Default>(gl: &glw::Functions, count: usize) -> Vec<T> {
    let mut out = vec![T::default(); count];
    gl!(gl.get_buffer_sub_data(
        glw::GL_SHADER_STORAGE_BUFFER,
        0,
        (count * std::mem::size_of::<T>()) as isize,
        out.as_mut_ptr().cast()
    ));
    out
}

/// Reads back `expected.len()` bytes through a mapping; Err when the mapping fails.
fn map_and_compare_bytes(gl: &glw::Functions, expected: &[u8]) -> Result<bool, ()> {
    let Some(out_data) = map_read::<u8>(gl, 0, expected.len()) else {
        return Err(());
    };
    let status = compare_bytes(expected, &out_data);
    unmap(gl);
    Ok(status)
}

fn setup_eight_buffers(gl: &glw::Functions, buffer: &[GLuint; 8], in_data: &[Vec<u8>; 4]) {
    for i in 0..4 {
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint, buffer[i]));
        ssbo_data(gl, &in_data[i], glw::GL_STATIC_DRAW);

        let out_data = vec![0u8; in_data[i].len()];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint + 4, buffer[i + 4]));
        ssbo_data(gl, &out_data, glw::GL_STATIC_DRAW);
    }
}

/// 1.9.x BasicStdLayoutBase2VS
pub(super) struct BasicStdLayoutBase2Vs {
    get_input: GetInput4,
    program: GLuint,
    buffer: [GLuint; 8],
    vertex_array: GLuint,
}

impl BasicStdLayoutBase2Vs {
    pub(super) fn new(get_input: GetInput4) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 8],
            vertex_array: 0,
        }
    }
}

impl Subcase for BasicStdLayoutBase2Vs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 8) {
            return Ok(NOT_SUPPORTED);
        }
        let (in_data, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, "");
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(8, self.buffer.as_mut_ptr()));
        setup_eight_buffers(gl, &self.buffer, &in_data);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        let mut status = true;
        for j in 0..4 {
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[j + 4]));
            gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
            let out_data = read_sub_data::<u8>(gl, in_data[j].len());
            status &= compare_bytes(&in_data[j], &out_data);
        }
        Ok(if status { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(8, self.buffer.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.9.x BasicStdLayoutBase2CS
pub(super) struct BasicStdLayoutBase2Cs {
    get_input: GetInput4,
    program: GLuint,
    buffer: [GLuint; 8],
}

impl BasicStdLayoutBase2Cs {
    pub(super) fn new(get_input: GetInput4) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 8],
        }
    }
}

impl Subcase for BasicStdLayoutBase2Cs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (in_data, body) = (self.get_input)();
        if get_integer(gl, glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS) < 8 {
            return Ok(NO_ERROR);
        }
        let source = format!("layout(local_size_x = 1) in;\n{body}");
        self.program = create_program_cs(gl, &source);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(8, self.buffer.as_mut_ptr()));
        setup_eight_buffers(gl, &self.buffer, &in_data);

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let mut status = true;
        for j in 0..4 {
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[j + 4]));
            match map_and_compare_bytes(gl, &in_data[j]) {
                Err(()) => return Ok(ERROR),
                Ok(equal) => status &= equal,
            }
        }
        Ok(if status { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(8, self.buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

fn setup_operations_buffers(gl: &glw::Functions, buffer: &[GLuint; 2], in_data: &[u8], expected_data: &[u8]) {
    // output buffer
    let zero = vec![0u8; expected_data.len()];
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, buffer[1]));
    ssbo_data(gl, &zero, glw::GL_STATIC_DRAW);
    // input buffer
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer[0]));
    ssbo_data(gl, in_data, glw::GL_STATIC_DRAW);
}

/// 1.10.x BasicOperationsBaseVS
pub(super) struct BasicOperationsBaseVs {
    get_input: GetInputOp,
    program: GLuint,
    buffer: [GLuint; 2],
    vertex_array: GLuint,
}

impl BasicOperationsBaseVs {
    pub(super) fn new(get_input: GetInputOp) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 2],
            vertex_array: 0,
        }
    }
}

impl Subcase for BasicOperationsBaseVs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 2) {
            return Ok(NOT_SUPPORTED);
        }
        let (in_data, expected_data, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, "");
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));
        setup_operations_buffers(gl, &self.buffer, &in_data, &expected_data);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[1]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let out_data = read_sub_data::<u8>(gl, expected_data.len());
        Ok(if compare_bytes(&expected_data, &out_data) {
            NO_ERROR
        } else {
            ERROR
        })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.buffer.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.10.x BasicOperationsBaseCS
pub(super) struct BasicOperationsBaseCs {
    get_input: GetInputOp,
    program: GLuint,
    buffer: [GLuint; 2],
}

impl BasicOperationsBaseCs {
    pub(super) fn new(get_input: GetInputOp) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 2],
        }
    }
}

impl Subcase for BasicOperationsBaseCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (in_data, expected_data, body) = (self.get_input)();
        let source = format!("layout(local_size_x = 1) in;\n{body}");
        self.program = create_program_cs(gl, &source);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));
        setup_operations_buffers(gl, &self.buffer, &in_data, &expected_data);

        gl!(gl.use_program(self.program));
        gl!(gl.uniform_3f(uniform_location(gl, self.program, "g_value0"), 10.0, 20.0, 30.0));
        gl!(gl.uniform_1i(uniform_location(gl, self.program, "g_index1"), 1));
        gl!(gl.uniform_1i(uniform_location(gl, self.program, "g_index2"), 2));
        gl!(gl.dispatch_compute(1, 1, 1));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[1]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        match map_and_compare_bytes(gl, &expected_data) {
            Err(()) => Ok(ERROR),
            Ok(status) => Ok(if status { NO_ERROR } else { ERROR }),
        }
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

fn setup_ubo_ssbo_buffers(gl: &glw::Functions, buffer: &[GLuint; 4], in_data: &[Vec<u8>; 2]) {
    // input buffers
    gl!(gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, 0, buffer[0]));
    buffer_data(gl, glw::GL_UNIFORM_BUFFER, &in_data[0], glw::GL_STATIC_DRAW);

    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer[1]));
    ssbo_data(gl, &in_data[1], glw::GL_STATIC_DRAW);

    // output buffer 0
    let out_data = vec![0u8; in_data[0].len()];
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, buffer[2]));
    ssbo_data(gl, &out_data, glw::GL_STATIC_DRAW);
    // output buffer 1
    let out_data = vec![0u8; in_data[1].len()];
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 2, buffer[3]));
    ssbo_data(gl, &out_data, glw::GL_STATIC_DRAW);
}

/// 1.11.x BasicStdLayoutBase3VS
pub(super) struct BasicStdLayoutBase3Vs {
    get_input: GetInput2,
    program: GLuint,
    buffer: [GLuint; 4],
    vertex_array: GLuint,
}

impl BasicStdLayoutBase3Vs {
    pub(super) fn new(get_input: GetInput2) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 4],
            vertex_array: 0,
        }
    }
}

impl Subcase for BasicStdLayoutBase3Vs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 2) {
            return Ok(NOT_SUPPORTED);
        }
        let (in_data, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, "");
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(4, self.buffer.as_mut_ptr()));
        setup_ubo_ssbo_buffers(gl, &self.buffer, &in_data);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        let mut status = true;
        for j in 0..2 {
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[j + 2]));
            gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
            let out_data = read_sub_data::<u8>(gl, in_data[j].len());
            status &= compare_bytes(&in_data[j], &out_data);
        }
        Ok(if status { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(4, self.buffer.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.11.x BasicStdLayoutBase3CS
pub(super) struct BasicStdLayoutBase3Cs {
    get_input: GetInput2,
    program: GLuint,
    buffer: [GLuint; 4],
}

impl BasicStdLayoutBase3Cs {
    pub(super) fn new(get_input: GetInput2) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 4],
        }
    }
}

impl Subcase for BasicStdLayoutBase3Cs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (in_data, body) = (self.get_input)();
        let source = format!("layout(local_size_x = 1) in;\n{body}");
        self.program = create_program_cs(gl, &source);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(4, self.buffer.as_mut_ptr()));
        setup_ubo_ssbo_buffers(gl, &self.buffer, &in_data);

        gl!(gl.use_program(self.program));
        gl!(gl.uniform_1i(uniform_location(gl, self.program, "g_index1"), 1));
        gl!(gl.dispatch_compute(1, 1, 1));

        let mut status = true;
        for j in 0..2 {
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[j + 2]));
            gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
            match map_and_compare_bytes(gl, &in_data[j]) {
                Err(()) => return Ok(ERROR),
                Ok(equal) => status &= equal,
            }
        }
        Ok(if status { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(4, self.buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

fn setup_matrix_buffers(gl: &glw::Functions, buffer: &[GLuint; 2], input: &[f32], expected: &[f32]) {
    // output buffer
    let zero = vec![0.0f32; expected.len()];
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, buffer[1]));
    ssbo_data(gl, &zero, glw::GL_STATIC_DRAW);
    // input buffer
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer[0]));
    ssbo_data(gl, input, glw::GL_STATIC_DRAW);
}

/// `Equal(float, float)` over the whole read-back vector.
fn floats_equal(expected: &[f32], out_data: &[f32]) -> bool {
    let mut status = true;
    for (i, (want, got)) in expected.iter().zip(out_data).enumerate() {
        if (want - got).abs() >= 0.001 {
            log::info!("Float at index {i} is {got} should be {want}");
            status = false;
        }
    }
    status
}

/// 1.12.x BasicMatrixOperationsBaseVS
pub(super) struct BasicMatrixOperationsBaseVs {
    get_input: GetInputMat,
    program: GLuint,
    buffer: [GLuint; 2],
    vertex_array: GLuint,
}

impl BasicMatrixOperationsBaseVs {
    pub(super) fn new(get_input: GetInputMat) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 2],
            vertex_array: 0,
        }
    }
}

impl Subcase for BasicMatrixOperationsBaseVs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 2) {
            return Ok(NOT_SUPPORTED);
        }
        let (input, expected, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, "");
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));
        setup_matrix_buffers(gl, &self.buffer, &input, &expected);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[1]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let out_data = read_sub_data::<f32>(gl, expected.len());
        Ok(if floats_equal(&expected, &out_data) {
            NO_ERROR
        } else {
            ERROR
        })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.buffer.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.12.x BasicMatrixOperationsBaseCS
pub(super) struct BasicMatrixOperationsBaseCs {
    get_input: GetInputMat,
    program: GLuint,
    buffer: [GLuint; 2],
}

impl BasicMatrixOperationsBaseCs {
    pub(super) fn new(get_input: GetInputMat) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 2],
        }
    }
}

impl Subcase for BasicMatrixOperationsBaseCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (input, expected, body) = (self.get_input)();
        let source = format!("layout(local_size_x = 1) in;\n{body}");
        self.program = create_program_cs(gl, &source);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));
        setup_matrix_buffers(gl, &self.buffer, &input, &expected);

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[1]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let Some(out_data) = map_read::<f32>(gl, 0, expected.len()) else {
            return Ok(ERROR);
        };
        let status = floats_equal(&expected, &out_data);
        unmap(gl);
        Ok(if status { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

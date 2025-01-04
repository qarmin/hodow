// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. As in `layout.rs`, a `GetInput*` function returns its buffers and shader source and the base classes (`BasicStdLayoutBase2`, `BasicOperationsBase`, `BasicStdLayoutBase3`, `BasicMatrixOperationsBase`, each in a VS and a CS flavour) hold it in a field. The functions are translated from the C++, with the string literals expanded by `scripts/expand_cxx_literals.py`.

use super::super::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};
use super::base::*;
use super::layout::compare_bytes;
use crate::glu::Context;
use crate::glw::{self, GLuint};

pub(super) type GetInput4 = fn() -> ([Vec<u8>; 4], &'static str);
pub(super) type GetInputOp = fn() -> (Vec<u8>, Vec<u8>, &'static str);
pub(super) type GetInput2 = fn() -> ([Vec<u8>; 2], &'static str);
pub(super) type GetInputMat = fn() -> (Vec<f32>, Vec<f32>, &'static str);

/// Reads back `expected.len()` bytes of the bound `GL_SHADER_STORAGE_BUFFER`; false when the mapping fails or a byte differs.
fn read_and_compare_bytes(gl: &glw::Functions, expected: &[u8]) -> Result<bool, ()> {
    let Some(out_data) = map_read::<u8>(gl, 0, expected.len()) else {
        return Err(());
    };
    let status = compare_bytes(expected, &out_data);
    unmap(gl);
    Ok(status)
}

/// Both stages of the shared "set up eight buffers (four inputs, four outputs), run, compare the outputs" body of `BasicStdLayoutBase2`.
fn setup_eight_buffers(gl: &glw::Functions, buffer: &[GLuint; 8], in_data: &[Vec<u8>; 4]) {
    for i in 0..4 {
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint, buffer[i]));
        ssbo_data(gl, &in_data[i], glw::GL_STATIC_DRAW);

        let out_data = vec![0u8; in_data[i].len()];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint + 4, buffer[i + 4]));
        ssbo_data(gl, &out_data, glw::GL_STATIC_DRAW);
    }
}

fn compare_eight_buffers(
    gl: &glw::Functions,
    buffer: &[GLuint; 8],
    in_data: &[Vec<u8>; 4],
    barrier_first: bool,
) -> SubcaseResult {
    let mut status = true;
    for j in 0..4 {
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer[j + 4]));
        if barrier_first {
            gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        }
        match read_and_compare_bytes(gl, &in_data[j]) {
            Err(()) => return Ok(ERROR),
            Ok(equal) => status &= equal,
        }
    }
    Ok(if status { NO_ERROR } else { ERROR })
}

/// BasicStdLayoutBase2VS
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
        if !is_vsfs_available(gl, 8, 0) {
            return Ok(NOT_SUPPORTED);
        }
        let (in_data, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, FS_GREEN);
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

        compare_eight_buffers(gl, &self.buffer, &in_data, true)
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

/// BasicStdLayoutBase2CS
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
        let blocks_cs = get_integer(gl, glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS);
        if blocks_cs < 8 {
            return Ok(NO_ERROR);
        }
        let (in_data, body) = (self.get_input)();
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

        compare_eight_buffers(gl, &self.buffer, &in_data, false)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(8, self.buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// 1.9.1 GetInputC1
pub(super) fn get_input_c1() -> ([Vec<u8>; 4], &'static str) {
    let mut data: [Vec<u8>; 4] = Default::default();
    for (i, buffer) in data.iter_mut().enumerate() {
        *buffer = vec![0u8; 4];
        put_f32(buffer, 0, (i + 1) as f32 * 1.0);
    }
    (
        data,
        "\nlayout(std430, binding = 0) buffer Input {\n  float data0;\n} g_input[4];\nlayout(std430, binding = 4) buffer Output {\n  float data0;\n} g_output[4];\nvoid main() {\n    g_output[0].data0 = g_input[0].data0;\n    g_output[1].data0 = g_input[1].data0;\n    g_output[2].data0 = g_input[2].data0;\n    g_output[3].data0 = g_input[3].data0;\n}",
    )
}

fn set_operations_uniforms(gl: &glw::Functions, program: GLuint) {
    gl!(gl.uniform_3f(uniform_location(gl, program, "g_value0"), 10.0, 20.0, 30.0));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_index1"), 1));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_index2"), 2));
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

fn compare_operations_output(gl: &glw::Functions, buffer: &[GLuint; 2], expected_data: &[u8]) -> SubcaseResult {
    gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer[1]));
    gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
    match read_and_compare_bytes(gl, expected_data) {
        Err(()) => Ok(ERROR),
        Ok(status) => Ok(if status { NO_ERROR } else { ERROR }),
    }
}

/// BasicOperationsBaseVS
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
        if !is_vsfs_available(gl, 2, 0) {
            return Ok(NOT_SUPPORTED);
        }
        let (in_data, expected_data, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, FS_GREEN);
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
        set_operations_uniforms(gl, self.program);
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        compare_operations_output(gl, &self.buffer, &expected_data)
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

/// BasicOperationsBaseCS
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
        set_operations_uniforms(gl, self.program);
        gl!(gl.dispatch_compute(1, 1, 1));

        compare_operations_output(gl, &self.buffer, &expected_data)
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

fn compare_ubo_ssbo_output(gl: &glw::Functions, buffer: &[GLuint; 4], in_data: &[Vec<u8>; 2]) -> SubcaseResult {
    let mut status = true;
    for j in 0..2 {
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer[j + 2]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        match read_and_compare_bytes(gl, &in_data[j]) {
            Err(()) => return Ok(ERROR),
            Ok(equal) => status &= equal,
        }
    }
    Ok(if status { NO_ERROR } else { ERROR })
}

/// BasicStdLayoutBase3VS
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
        if !is_vsfs_available(gl, 4, 0) {
            return Ok(NOT_SUPPORTED);
        }
        let (in_data, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, FS_GREEN);
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

        gl!(gl.uniform_1i(uniform_location(gl, self.program, "g_index1"), 1));

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        compare_ubo_ssbo_output(gl, &self.buffer, &in_data)
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

/// BasicStdLayoutBase3CS
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

        compare_ubo_ssbo_output(gl, &self.buffer, &in_data)
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

fn compare_matrix_output(gl: &glw::Functions, buffer: &[GLuint; 2], expected: &[f32]) -> SubcaseResult {
    gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer[1]));
    gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
    let Some(out_data) = map_read::<f32>(gl, 0, expected.len()) else {
        return Ok(ERROR);
    };
    let mut status = true;
    for (i, (want, got)) in expected.iter().zip(&out_data).enumerate() {
        if (want - got).abs() >= 0.001 {
            log::info!("Float at index {i} is {got} should be {want}");
            status = false;
        }
    }
    unmap(gl);
    Ok(if status { NO_ERROR } else { ERROR })
}

/// BasicMatrixOperationsBaseVS
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
        if !is_vsfs_available(gl, 2, 0) {
            return Ok(NOT_SUPPORTED);
        }
        let (input, expected, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, FS_GREEN);
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

        compare_matrix_output(gl, &self.buffer, &expected)
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

/// BasicMatrixOperationsBaseCS
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

        compare_matrix_output(gl, &self.buffer, &expected)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

pub(super) fn get_input_c2() -> ([Vec<u8>; 4], &'static str) {
    let mut data: [Vec<u8>; 4] = Default::default();
    data[0] = vec![0u8; 12 * 4];
    put_f32(&mut data[0], 0, 1.0);
    put_f32(&mut data[0], 1, 0.0);
    put_f32(&mut data[0], 2, 0.0);
    put_f32(&mut data[0], 3, 0.0);
    put_f32(&mut data[0], 4, 2.0);
    put_f32(&mut data[0], 5, 0.0);
    put_f32(&mut data[0], 6, 0.0);
    put_f32(&mut data[0], 7, 0.0);
    put_f32(&mut data[0], 8, 3.0);
    put_f32(&mut data[0], 9, 0.0);
    put_f32(&mut data[0], 10, 0.0);
    put_f32(&mut data[0], 11, 0.0);
    data[1] = vec![0u8; 3 * 4];
    put_f32(&mut data[1], 0, 4.0);
    put_f32(&mut data[1], 1, 5.0);
    put_f32(&mut data[1], 2, 6.0);
    data[2] = vec![0u8; 12 * 4];
    put_f32(&mut data[2], 0, 7.0);
    put_f32(&mut data[2], 1, 0.0);
    put_f32(&mut data[2], 2, 0.0);
    put_f32(&mut data[2], 3, 0.0);
    put_f32(&mut data[2], 4, 8.0);
    put_f32(&mut data[2], 5, 0.0);
    put_f32(&mut data[2], 6, 0.0);
    put_f32(&mut data[2], 7, 0.0);
    put_f32(&mut data[2], 8, 9.0);
    put_f32(&mut data[2], 9, 0.0);
    put_f32(&mut data[2], 10, 0.0);
    put_f32(&mut data[2], 11, 0.0);
    data[3] = vec![0u8; 3 * 4];
    put_f32(&mut data[3], 0, 10.0);
    put_f32(&mut data[3], 1, 11.0);
    put_f32(&mut data[3], 2, 12.0);
    (
        data,
        "\nlayout(std140, binding = 0) buffer Input0 {\n  float data0[3];\n} g_input0;\nlayout(std430, binding = 1) buffer Input1 {\n  float data0[3];\n} g_input1;\nlayout(std140, binding = 2) buffer Input2 {\n  float data0[3];\n} g_input2;\nlayout(std430, binding = 3) buffer Input3 {\n  float data0[3];\n} g_input3;\nlayout(std140, binding = 4) buffer Output0 {\n  float data0[3];\n} g_output0;\nlayout(std430, binding = 5) buffer Output1 {\n  float data0[3];\n} g_output1;\nlayout(std140, binding = 6) buffer Output2 {\n  float data0[3];\n} g_output2;\nlayout(std430, binding = 7) buffer Output3 {\n  float data0[3];\n} g_output3;\nvoid main() {\n  for (int i = 0; i < g_input0.data0.length(); ++i) g_output0.data0[i] = g_input0.data0[i];\n  for (int i = 0; i < g_input1.data0.length(); ++i) g_output1.data0[i] = g_input1.data0[i];\n  for (int i = 0; i < g_input2.data0.length(); ++i) g_output2.data0[i] = g_input2.data0[i];\n  for (int i = 0; i < g_input3.data0.length(); ++i) g_output3.data0[i] = g_input3.data0[i];\n}",
    )
}

pub(super) fn get_input_c3() -> ([Vec<u8>; 4], &'static str) {
    let mut data: [Vec<u8>; 4] = Default::default();
    data[0] = vec![0u8; 62 * 4];
    put_i32(&mut data[0], 0, 1);
    put_i32(&mut data[0], 1, 0);
    put_i32(&mut data[0], 2, 0);
    put_i32(&mut data[0], 3, 0);
    put_f32(&mut data[0], 4, 2.0);
    put_f32(&mut data[0], 5, 0.0);
    put_f32(&mut data[0], 6, 0.0);
    put_f32(&mut data[0], 7, 0.0);
    put_f32(&mut data[0], 8, 3.0);
    put_f32(&mut data[0], 9, 0.0);
    put_f32(&mut data[0], 10, 0.0);
    put_f32(&mut data[0], 11, 0.0);
    put_f32(&mut data[0], 12, 4.0);
    put_f32(&mut data[0], 13, 0.0);
    put_f32(&mut data[0], 14, 0.0);
    put_f32(&mut data[0], 15, 0.0);
    put_f32(&mut data[0], 16, 5.0);
    put_f32(&mut data[0], 17, 0.0);
    put_f32(&mut data[0], 18, 0.0);
    put_f32(&mut data[0], 19, 0.0);
    put_f32(&mut data[0], 20, 6.0);
    put_f32(&mut data[0], 21, 0.0);
    put_f32(&mut data[0], 22, 0.0);
    put_f32(&mut data[0], 23, 0.0);
    put_f32(&mut data[0], 24, 7.0);
    put_f32(&mut data[0], 25, 8.0);
    put_f32(&mut data[0], 26, 0.0);
    put_f32(&mut data[0], 27, 0.0);
    put_f32(&mut data[0], 28, 9.0);
    put_f32(&mut data[0], 29, 10.0);
    put_f32(&mut data[0], 30, 0.0);
    put_f32(&mut data[0], 31, 0.0);
    put_f32(&mut data[0], 32, 11.0);
    put_f32(&mut data[0], 33, 12.0);
    put_f32(&mut data[0], 34, 0.0);
    put_f32(&mut data[0], 35, 0.0);
    put_f32(&mut data[0], 36, 13.0);
    put_f32(&mut data[0], 37, 0.0);
    put_f32(&mut data[0], 38, 0.0);
    put_f32(&mut data[0], 39, 0.0);
    put_f32(&mut data[0], 40, 14.0);
    put_f32(&mut data[0], 41, 0.0);
    put_f32(&mut data[0], 42, 0.0);
    put_f32(&mut data[0], 43, 0.0);
    put_f32(&mut data[0], 44, 15.0);
    put_f32(&mut data[0], 45, 0.0);
    put_f32(&mut data[0], 46, 0.0);
    put_f32(&mut data[0], 47, 0.0);
    put_i32(&mut data[0], 48, 16);
    put_i32(&mut data[0], 49, 0);
    put_i32(&mut data[0], 50, 0);
    put_i32(&mut data[0], 51, 0);
    put_i32(&mut data[0], 52, 17);
    put_i32(&mut data[0], 53, 18);
    put_i32(&mut data[0], 54, 19);
    put_i32(&mut data[0], 55, 0);
    data[1] = vec![0u8; 30 * 4];
    put_i32(&mut data[1], 0, 1);
    put_f32(&mut data[1], 1, 2.0);
    put_f32(&mut data[1], 2, 3.0);
    put_f32(&mut data[1], 3, 4.0);
    put_f32(&mut data[1], 4, 5.0);
    put_f32(&mut data[1], 5, 6.0);
    put_f32(&mut data[1], 6, 7.0);
    put_f32(&mut data[1], 7, 8.0);
    put_f32(&mut data[1], 8, 9.0);
    put_f32(&mut data[1], 9, 10.0);
    put_f32(&mut data[1], 10, 11.0);
    put_f32(&mut data[1], 11, 12.0);
    put_f32(&mut data[1], 12, 13.0);
    put_f32(&mut data[1], 13, 14.0);
    put_f32(&mut data[1], 14, 15.0);
    put_i32(&mut data[1], 15, 16);
    put_i32(&mut data[1], 16, 17);
    put_i32(&mut data[1], 17, 18);
    put_i32(&mut data[1], 18, 19);
    data[2] = vec![0u8; 5 * 4];
    put_i32(&mut data[2], 0, 1);
    put_i32(&mut data[2], 1, 0);
    put_i32(&mut data[2], 2, 0);
    put_i32(&mut data[2], 3, 0);
    put_i32(&mut data[2], 4, 2);
    data[3] = vec![0u8; 2 * 4];
    put_i32(&mut data[3], 0, 1);
    put_i32(&mut data[3], 1, 2);
    (
        data,
        "\nlayout(std140, binding = 0) buffer Input0 {\n  int data0;\n  float data1[5];\n  mat3x2 data2;\n  float data3;\n  float data4[2];\n  int data5;\n  ivec3 data6;\n} g_input0;\nlayout(std430, binding = 1) buffer Input1 {\n  int data0;\n  float data1[5];\n  mat3x2 data2;\n  float data3;\n  float data4[2];\n  int data5;\n  ivec3 data6;\n} g_input1;\nstruct Struct0 {\n  int data0;\n};\nlayout(std140, binding = 2) buffer Input2 {\n  int data0;\n  Struct0 data1;\n} g_input2;\nlayout(std430, binding = 3) buffer Input3 {\n  int data0;\n  Struct0 data1;\n} g_input3;\nlayout(std140, binding = 4) buffer Output0 {\n  int data0;\n  float data1[5];\n  mat3x2 data2;\n  float data3;\n  float data4[2];\n  int data5;\n  ivec3 data6;\n} g_output0;\nlayout(std430, binding = 5) buffer Output1 {\n  int data0;\n  float data1[5];\n  mat3x2 data2;\n  float data3;\n  float data4[2];\n  int data5;\n  ivec3 data6;\n} g_output1;\nlayout(std140, binding = 6) buffer Output2 {\n  int data0;\n  Struct0 data1;\n} g_output2;\nlayout(std430, binding = 7) buffer Output3 {\n  int data0;\n  Struct0 data1;\n} g_output3;\nvoid main() {\n  g_output0.data0 = g_input0.data0;\n  for (int i = 0; i < g_input0.data1.length(); ++i) g_output0.data1[i] = g_input0.data1[i];\n  g_output0.data2 = g_input0.data2;\n  g_output0.data3 = g_input0.data3;\n  for (int i = 0; i < g_input0.data4.length(); ++i) g_output0.data4[i] = g_input0.data4[i];\n  g_output0.data5 = g_input0.data5;\n  g_output0.data6 = g_input0.data6;\n  g_output1.data0 = g_input1.data0;\n  for (int i = 0; i < g_input1.data1.length(); ++i) g_output1.data1[i] = g_input1.data1[i];\n  g_output1.data2 = g_input1.data2;\n  g_output1.data3 = g_input1.data3;\n  for (int i = 0; i < g_input1.data4.length(); ++i) g_output1.data4[i] = g_input1.data4[i];\n  g_output1.data5 = g_input1.data5;\n  g_output1.data6 = g_input1.data6;\n  g_output2.data0 = g_input2.data0;\n  g_output2.data1 = g_input2.data1;\n  g_output3.data0 = g_input3.data0;\n  g_output3.data1 = g_input3.data1;\n}",
    )
}

pub(super) fn get_input_c4() -> ([Vec<u8>; 4], &'static str) {
    let mut data: [Vec<u8>; 4] = Default::default();
    data[0] = vec![0u8; 57 * 4];
    put_i32(&mut data[0], 0, 1);
    put_i32(&mut data[0], 1, 0);
    put_i32(&mut data[0], 2, 0);
    put_i32(&mut data[0], 3, 0);
    put_i32(&mut data[0], 4, 2);
    put_i32(&mut data[0], 5, 3);
    put_i32(&mut data[0], 6, 0);
    put_i32(&mut data[0], 7, 0);
    put_i32(&mut data[0], 8, 4);
    put_i32(&mut data[0], 9, 5);
    put_i32(&mut data[0], 10, 0);
    put_i32(&mut data[0], 11, 0);
    put_f32(&mut data[0], 12, 6.0);
    put_f32(&mut data[0], 13, 0.0);
    put_f32(&mut data[0], 14, 0.0);
    put_f32(&mut data[0], 15, 0.0);
    put_f32(&mut data[0], 16, 7.0);
    put_f32(&mut data[0], 17, 8.0);
    put_f32(&mut data[0], 18, 0.0);
    put_f32(&mut data[0], 19, 0.0);
    put_i32(&mut data[0], 20, 9);
    put_i32(&mut data[0], 21, 10);
    put_i32(&mut data[0], 22, 11);
    put_i32(&mut data[0], 23, 0);
    put_f32(&mut data[0], 24, 12.0);
    put_f32(&mut data[0], 25, 13.0);
    put_f32(&mut data[0], 26, 0.0);
    put_f32(&mut data[0], 27, 0.0);
    put_i32(&mut data[0], 28, 14);
    put_i32(&mut data[0], 29, 15);
    put_i32(&mut data[0], 30, 16);
    put_i32(&mut data[0], 31, 0);
    put_f32(&mut data[0], 32, 17.0);
    put_f32(&mut data[0], 33, 0.0);
    put_f32(&mut data[0], 34, 0.0);
    put_f32(&mut data[0], 35, 0.0);
    put_i32(&mut data[0], 36, 18);
    put_i32(&mut data[0], 37, 0);
    put_i32(&mut data[0], 38, 0);
    put_i32(&mut data[0], 39, 0);
    put_i32(&mut data[0], 40, 19);
    put_i32(&mut data[0], 41, 20);
    put_i32(&mut data[0], 42, 0);
    put_i32(&mut data[0], 43, 0);
    put_i32(&mut data[0], 44, 21);
    put_i32(&mut data[0], 45, 0);
    put_i32(&mut data[0], 45, 0);
    put_i32(&mut data[0], 45, 0);
    put_f32(&mut data[0], 48, 22.0);
    put_f32(&mut data[0], 49, 23.0);
    put_f32(&mut data[0], 50, 0.0);
    put_f32(&mut data[0], 51, 0.0);
    put_i32(&mut data[0], 52, 24);
    put_i32(&mut data[0], 53, 25);
    put_i32(&mut data[0], 54, 26);
    put_i32(&mut data[0], 55, 0);
    put_f32(&mut data[0], 56, 27.0);
    data[1] = vec![0u8; 57 * 4];
    put_i32(&mut data[1], 0, 101);
    put_i32(&mut data[1], 1, 0);
    put_i32(&mut data[1], 2, 0);
    put_i32(&mut data[1], 3, 0);
    put_i32(&mut data[1], 4, 102);
    put_i32(&mut data[1], 5, 103);
    put_i32(&mut data[1], 6, 0);
    put_i32(&mut data[1], 7, 0);
    put_i32(&mut data[1], 8, 104);
    put_i32(&mut data[1], 9, 105);
    put_i32(&mut data[1], 10, 0);
    put_i32(&mut data[1], 11, 0);
    put_f32(&mut data[1], 12, 106.0);
    put_f32(&mut data[1], 13, 0.0);
    put_f32(&mut data[1], 14, 0.0);
    put_f32(&mut data[1], 15, 0.0);
    put_f32(&mut data[1], 16, 107.0);
    put_f32(&mut data[1], 17, 108.0);
    put_f32(&mut data[1], 18, 0.0);
    put_f32(&mut data[1], 19, 0.0);
    put_i32(&mut data[1], 20, 109);
    put_i32(&mut data[1], 21, 110);
    put_i32(&mut data[1], 22, 111);
    put_i32(&mut data[1], 23, 0);
    put_f32(&mut data[1], 24, 112.0);
    put_f32(&mut data[1], 25, 113.0);
    put_f32(&mut data[1], 26, 0.0);
    put_f32(&mut data[1], 27, 0.0);
    put_i32(&mut data[1], 28, 114);
    put_i32(&mut data[1], 29, 115);
    put_i32(&mut data[1], 30, 116);
    put_i32(&mut data[1], 31, 0);
    put_f32(&mut data[1], 32, 117.0);
    put_f32(&mut data[1], 33, 0.0);
    put_f32(&mut data[1], 34, 0.0);
    put_f32(&mut data[1], 35, 0.0);
    put_i32(&mut data[1], 36, 118);
    put_i32(&mut data[1], 37, 0);
    put_i32(&mut data[1], 38, 0);
    put_i32(&mut data[1], 39, 0);
    put_i32(&mut data[1], 40, 119);
    put_i32(&mut data[1], 41, 120);
    put_i32(&mut data[1], 42, 0);
    put_i32(&mut data[1], 43, 0);
    put_i32(&mut data[1], 44, 121);
    put_i32(&mut data[1], 45, 0);
    put_i32(&mut data[1], 45, 0);
    put_i32(&mut data[1], 45, 0);
    put_f32(&mut data[1], 48, 122.0);
    put_f32(&mut data[1], 49, 123.0);
    put_f32(&mut data[1], 50, 0.0);
    put_f32(&mut data[1], 51, 0.0);
    put_i32(&mut data[1], 52, 124);
    put_i32(&mut data[1], 53, 125);
    put_i32(&mut data[1], 54, 126);
    put_i32(&mut data[1], 55, 0);
    put_f32(&mut data[1], 56, 127.0);
    data[2] = vec![0u8; 45 * 4];
    put_i32(&mut data[2], 0, 1000);
    put_i32(&mut data[2], 1, 0);
    put_i32(&mut data[2], 2, 1001);
    put_i32(&mut data[2], 3, 1002);
    put_i32(&mut data[2], 4, 1003);
    put_i32(&mut data[2], 5, 1004);
    put_f32(&mut data[2], 6, 1005.0);
    put_f32(&mut data[2], 7, 0.0);
    put_f32(&mut data[2], 8, 1006.0);
    put_f32(&mut data[2], 9, 1007.0);
    put_f32(&mut data[2], 10, 0.0);
    put_f32(&mut data[2], 11, 0.0);
    put_i32(&mut data[2], 12, 1008);
    put_i32(&mut data[2], 13, 1009);
    put_i32(&mut data[2], 14, 1010);
    put_i32(&mut data[2], 15, 0);
    put_f32(&mut data[2], 16, 1011.0);
    put_f32(&mut data[2], 17, 1012.0);
    put_f32(&mut data[2], 18, 0.0);
    put_f32(&mut data[2], 19, 0.0);
    put_i32(&mut data[2], 20, 1013);
    put_i32(&mut data[2], 21, 1014);
    put_i32(&mut data[2], 22, 1015);
    put_i32(&mut data[2], 23, 0);
    put_f32(&mut data[2], 24, 1016.0);
    put_f32(&mut data[2], 25, 0.0);
    put_f32(&mut data[2], 26, 0.0);
    put_f32(&mut data[2], 27, 0.0);
    put_i32(&mut data[2], 28, 1017);
    put_i32(&mut data[2], 29, 0);
    put_i32(&mut data[2], 30, 1018);
    put_i32(&mut data[2], 31, 1019);
    put_i32(&mut data[2], 32, 1020);
    put_i32(&mut data[2], 33, 0);
    put_i32(&mut data[2], 34, 0);
    put_i32(&mut data[2], 35, 0);
    put_f32(&mut data[2], 36, 1021.0);
    put_f32(&mut data[2], 37, 1022.0);
    put_f32(&mut data[2], 38, 0.0);
    put_f32(&mut data[2], 39, 0.0);
    put_i32(&mut data[2], 40, 1023);
    put_i32(&mut data[2], 41, 1024);
    put_i32(&mut data[2], 42, 1025);
    put_i32(&mut data[2], 43, 0);
    put_f32(&mut data[2], 44, 1026.0);
    data[3] = vec![0u8; 45 * 4];
    put_i32(&mut data[3], 0, 10000);
    put_i32(&mut data[3], 1, 0);
    put_i32(&mut data[3], 2, 10001);
    put_i32(&mut data[3], 3, 10002);
    put_i32(&mut data[3], 4, 10003);
    put_i32(&mut data[3], 5, 10004);
    put_f32(&mut data[3], 6, 10005.0);
    put_f32(&mut data[3], 7, 0.0);
    put_f32(&mut data[3], 8, 10006.0);
    put_f32(&mut data[3], 9, 10007.0);
    put_f32(&mut data[3], 10, 0.0);
    put_f32(&mut data[3], 11, 0.0);
    put_i32(&mut data[3], 12, 10008);
    put_i32(&mut data[3], 13, 10009);
    put_i32(&mut data[3], 14, 10010);
    put_i32(&mut data[3], 15, 0);
    put_f32(&mut data[3], 16, 10011.0);
    put_f32(&mut data[3], 17, 10012.0);
    put_f32(&mut data[3], 18, 0.0);
    put_f32(&mut data[3], 19, 0.0);
    put_i32(&mut data[3], 20, 10013);
    put_i32(&mut data[3], 21, 10014);
    put_i32(&mut data[3], 22, 10015);
    put_i32(&mut data[3], 23, 0);
    put_f32(&mut data[3], 24, 10016.0);
    put_f32(&mut data[3], 25, 0.0);
    put_f32(&mut data[3], 26, 0.0);
    put_f32(&mut data[3], 27, 0.0);
    put_i32(&mut data[3], 28, 10017);
    put_i32(&mut data[3], 29, 0);
    put_i32(&mut data[3], 30, 10018);
    put_i32(&mut data[3], 31, 10019);
    put_i32(&mut data[3], 32, 10020);
    put_i32(&mut data[3], 33, 0);
    put_i32(&mut data[3], 34, 0);
    put_i32(&mut data[3], 35, 0);
    put_f32(&mut data[3], 36, 10021.0);
    put_f32(&mut data[3], 37, 10022.0);
    put_f32(&mut data[3], 38, 0.0);
    put_f32(&mut data[3], 39, 0.0);
    put_i32(&mut data[3], 40, 10023);
    put_i32(&mut data[3], 41, 10024);
    put_i32(&mut data[3], 42, 10025);
    put_i32(&mut data[3], 43, 0);
    put_f32(&mut data[3], 44, 10026.0);
    (
        data,
        "\nstruct Struct0 {\n  ivec2 data0;\n};\nstruct Struct1 {\n  vec2 data0;\n  ivec3 data1;\n};\nstruct Struct2 {\n  int data0;\n  Struct0 data1;\n  int data2;\n  Struct1 data3;\n  float data4;\n};\nlayout(std140, binding = 0) buffer Input01 {\n  int data0;\n  Struct0 data1[2];\n  float data2;\n  Struct1 data3[2];\n  float data4;\n  Struct2 data5;\n} g_input01[2];\nlayout(std430, binding = 2) buffer Input23 {\n  int data0;\n  Struct0 data1[2];\n  float data2;\n  Struct1 data3[2];\n  float data4;\n  Struct2 data5;\n} g_input23[2];\nlayout(std140, binding = 4) buffer Output01 {\n  int data0;\n  Struct0 data1[2];\n  float data2;\n  Struct1 data3[2];\n  float data4;\n  Struct2 data5;\n} g_output01[2];\nlayout(std430, binding = 6) buffer Output23 {\n  int data0;\n  Struct0 data1[2];\n  float data2;\n  Struct1 data3[2];\n  float data4;\n  Struct2 data5;\n} g_output23[2];\n\nvoid main() {\n  g_output01[0].data0 = g_input01[0].data0;\n  for (int i = 0; i < g_input01[0].data1.length(); ++i) g_output01[0].data1[i] = g_input01[0].data1[i];\n  g_output01[0].data2 = g_input01[0].data2;\n  g_output01[0].data3[0] = g_input01[0].data3[0];\n  g_output01[0].data3[1] = g_input01[0].data3[1];\n  g_output01[0].data4 = g_input01[0].data4;\n  g_output01[1].data0 = g_input01[1].data0;\n  for (int i = 0; i < g_input01[1].data1.length(); ++i) g_output01[1].data1[i] = g_input01[1].data1[i];\n  g_output01[1].data2 = g_input01[1].data2;\n  g_output01[1].data3[0] = g_input01[1].data3[0];\n  g_output01[1].data3[1] = g_input01[1].data3[1];\n  g_output01[1].data4 = g_input01[1].data4;\n  g_output01[0].data5 = g_input01[0].data5;\n  g_output01[1].data5 = g_input01[1].data5;\n\n  g_output23[0].data0 = g_input23[0].data0;\n  for (int i = 0; i < g_input23[0].data1.length(); ++i) g_output23[0].data1[i] = g_input23[0].data1[i];\n  g_output23[0].data2 = g_input23[0].data2;\n  g_output23[0].data3[0] = g_input23[0].data3[0];\n  g_output23[0].data3[1] = g_input23[0].data3[1];\n  g_output23[0].data4 = g_input23[0].data4;\n  g_output23[1].data0 = g_input23[1].data0;\n  for (int i = 0; i < g_input23[1].data1.length(); ++i) g_output23[1].data1[i] = g_input23[1].data1[i];\n  g_output23[1].data2 = g_input23[1].data2;\n  g_output23[1].data3[0] = g_input23[1].data3[0];\n  g_output23[1].data3[1] = g_input23[1].data3[1];\n  g_output23[1].data4 = g_input23[1].data4;\n  g_output23[0].data5 = g_input23[0].data5;\n  g_output23[1].data5 = g_input23[1].data5;\n}",
    )
}

pub(super) fn get_input_op1() -> (Vec<u8>, Vec<u8>, &'static str) {
    let mut in_data = vec![0u8; 16 * 9];
    put_i32(&mut in_data, 0, 1);
    put_i32(&mut in_data, 1, 2);
    put_i32(&mut in_data, 2, 3);
    put_i32(&mut in_data, 3, 4);
    put_f32(&mut in_data, 4, 1.0);
    put_f32(&mut in_data, 5, 2.0);
    put_f32(&mut in_data, 6, 3.0);
    put_f32(&mut in_data, 7, 0.0);
    put_i32(&mut in_data, 8, 1);
    put_i32(&mut in_data, 9, 2);
    put_i32(&mut in_data, 10, 3);
    put_i32(&mut in_data, 11, 4);
    put_i32(&mut in_data, 12, 1);
    put_i32(&mut in_data, 13, -2);
    put_i32(&mut in_data, 14, 3);
    put_i32(&mut in_data, 15, 4);
    put_f32(&mut in_data, 16, 1.0);
    put_f32(&mut in_data, 17, 2.0);
    put_f32(&mut in_data, 18, 3.0);
    put_f32(&mut in_data, 19, 4.0);
    put_f32(&mut in_data, 20, 1.0);
    put_f32(&mut in_data, 21, 2.0);
    put_f32(&mut in_data, 22, 3.0);
    put_f32(&mut in_data, 23, 4.0);
    put_f32(&mut in_data, 24, 1.0);
    put_f32(&mut in_data, 25, 2.0);
    put_f32(&mut in_data, 26, 3.0);
    put_f32(&mut in_data, 27, 4.0);
    put_f32(&mut in_data, 28, 1.0);
    put_f32(&mut in_data, 29, 2.0);
    put_f32(&mut in_data, 30, 3.0);
    put_f32(&mut in_data, 31, 4.0);
    put_f32(&mut in_data, 32, 1.0);
    put_f32(&mut in_data, 33, 0.0);
    put_f32(&mut in_data, 34, 0.0);
    put_f32(&mut in_data, 35, 4.0);
    let mut out_data = vec![0u8; 16 * 9];
    put_i32(&mut out_data, 0, 4);
    put_i32(&mut out_data, 1, 3);
    put_i32(&mut out_data, 2, 2);
    put_i32(&mut out_data, 3, 1);
    put_f32(&mut out_data, 4, 3.0);
    put_f32(&mut out_data, 5, 2.0);
    put_f32(&mut out_data, 6, 1.0);
    put_f32(&mut out_data, 7, 0.0);
    put_i32(&mut out_data, 8, 4);
    put_i32(&mut out_data, 9, 1);
    put_i32(&mut out_data, 10, 0);
    put_i32(&mut out_data, 11, 3);
    put_i32(&mut out_data, 12, 10);
    put_i32(&mut out_data, 13, 4);
    put_i32(&mut out_data, 14, -2);
    put_i32(&mut out_data, 15, 20);
    put_f32(&mut out_data, 16, 50.0);
    put_f32(&mut out_data, 17, 5.0);
    put_f32(&mut out_data, 18, 2.0);
    put_f32(&mut out_data, 19, 30.0);
    put_f32(&mut out_data, 20, 4.0);
    put_f32(&mut out_data, 21, 2.0);
    put_f32(&mut out_data, 22, 3.0);
    put_f32(&mut out_data, 23, 1.0);
    put_f32(&mut out_data, 24, 4.0);
    put_f32(&mut out_data, 25, 3.0);
    put_f32(&mut out_data, 26, 2.0);
    put_f32(&mut out_data, 27, 1.0);
    put_f32(&mut out_data, 28, 2.0);
    put_f32(&mut out_data, 29, 2.0);
    put_f32(&mut out_data, 30, 2.0);
    put_f32(&mut out_data, 31, 2.0);
    put_f32(&mut out_data, 32, 4.0);
    put_f32(&mut out_data, 33, 0.0);
    put_f32(&mut out_data, 34, 0.0);
    put_f32(&mut out_data, 35, 1.0);
    (
        in_data,
        out_data,
        "\nlayout(std430, binding = 0) buffer Input {\n  ivec4 data0;\n  vec3 data1;\n  uvec4 data2;\n  ivec4 data3;\n  vec4 data4;\n  mat4 data5;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  ivec4 data0;\n  vec3 data1;\n  uvec4 data2;\n  ivec4 data3;\n  vec4 data4;\n  mat4 data5;\n} g_output;\nuniform vec3 g_value0;\nuniform int g_index1;\nvoid main() {\n  int index0 = 0;\n  g_output.data0.wzyx = g_input.data0;\n  g_output.data1 = g_input.data1.zyx;\n  g_output.data2.xwy = g_input.data2.wzx;\n  g_output.data3.xw = ivec2(10, 20);\n  g_output.data3.zy = g_input.data3.yw;\n  g_output.data4.wx = g_value0.xz;\n  g_output.data4.wx += g_value0.yy;\n  g_output.data4.yz = g_input.data4.xx + g_input.data4.wx;\n  g_output.data5[g_index1 - 1].wyzx = vec4(1, 2, 3, 4);\n  g_output.data5[g_index1 + index0] = g_input.data5[g_index1].wzyx;\n  g_output.data5[1 + g_index1] = g_input.data5[g_index1 + 1].yyyy;\n  g_output.data5[5 - g_index1 - 1].wx = g_input.data5[4 - g_index1].xw;\n}",
    )
}

pub(super) fn get_input_op2() -> (Vec<u8>, Vec<u8>, &'static str) {
    let mut in_data = vec![0u8; 16 * 8];
    put_f32(&mut in_data, 0, 1.0);
    put_f32(&mut in_data, 1, 0.0);
    put_f32(&mut in_data, 2, 0.0);
    put_f32(&mut in_data, 3, 0.0);
    put_f32(&mut in_data, 4, 0.0);
    put_f32(&mut in_data, 5, 1.0);
    put_f32(&mut in_data, 6, 0.0);
    put_f32(&mut in_data, 7, 0.0);
    put_f32(&mut in_data, 8, 0.0);
    put_f32(&mut in_data, 9, 0.0);
    put_f32(&mut in_data, 10, 1.0);
    put_f32(&mut in_data, 11, 0.0);
    put_f32(&mut in_data, 12, 0.0);
    put_f32(&mut in_data, 13, 0.0);
    put_f32(&mut in_data, 14, 0.0);
    put_f32(&mut in_data, 15, 1.0);
    put_f32(&mut in_data, 16, 2.0);
    put_f32(&mut in_data, 17, 0.0);
    put_f32(&mut in_data, 18, 0.0);
    put_f32(&mut in_data, 19, 0.0);
    put_f32(&mut in_data, 20, 0.0);
    put_f32(&mut in_data, 21, 3.0);
    put_f32(&mut in_data, 22, 0.0);
    put_f32(&mut in_data, 23, 0.0);
    put_f32(&mut in_data, 24, 0.0);
    put_f32(&mut in_data, 25, 0.0);
    put_f32(&mut in_data, 26, 4.0);
    put_f32(&mut in_data, 27, 0.0);
    put_f32(&mut in_data, 28, 0.0);
    put_f32(&mut in_data, 29, 0.0);
    put_f32(&mut in_data, 30, 0.0);
    put_f32(&mut in_data, 31, 5.0);
    let mut out_data = vec![0u8; 16 * 5];
    put_f32(&mut out_data, 0, 2.0);
    put_f32(&mut out_data, 1, 0.0);
    put_f32(&mut out_data, 2, 0.0);
    put_f32(&mut out_data, 3, 0.0);
    put_f32(&mut out_data, 4, 0.0);
    put_f32(&mut out_data, 5, 3.0);
    put_f32(&mut out_data, 6, 0.0);
    put_f32(&mut out_data, 7, 0.0);
    put_f32(&mut out_data, 8, 0.0);
    put_f32(&mut out_data, 9, 0.0);
    put_f32(&mut out_data, 10, 4.0);
    put_f32(&mut out_data, 11, 0.0);
    put_f32(&mut out_data, 12, 0.0);
    put_f32(&mut out_data, 13, 0.0);
    put_f32(&mut out_data, 14, 0.0);
    put_f32(&mut out_data, 15, 5.0);
    put_f32(&mut out_data, 16, 0.0);
    put_f32(&mut out_data, 17, 1.0);
    put_f32(&mut out_data, 18, 4.0);
    put_f32(&mut out_data, 19, 0.0);
    (
        in_data,
        out_data,
        "\nlayout(std430, binding = 0) buffer Input {\n  mat4 data0;\n  mat4 data1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  mat4 data0;\n  vec4 data1;\n} g_output;\nuniform int g_index2;\nvoid main() {\n  g_output.data0 = matrixCompMult(g_input.data0, g_input.data1);\n  g_output.data1 = g_input.data0[1] + g_input.data1[g_index2];\n}",
    )
}

pub(super) fn get_input_ubo1() -> ([Vec<u8>; 2], &'static str) {
    let mut data: [Vec<u8>; 2] = Default::default();
    data[0] = vec![0u8; 12 * 4];
    put_f32(&mut data[0], 0, 1.0);
    put_f32(&mut data[0], 1, 0.0);
    put_f32(&mut data[0], 2, 0.0);
    put_f32(&mut data[0], 3, 0.0);
    put_f32(&mut data[0], 4, 2.0);
    put_f32(&mut data[0], 5, 0.0);
    put_f32(&mut data[0], 6, 0.0);
    put_f32(&mut data[0], 7, 0.0);
    put_f32(&mut data[0], 8, 3.0);
    put_f32(&mut data[0], 9, 0.0);
    put_f32(&mut data[0], 10, 0.0);
    put_f32(&mut data[0], 11, 0.0);
    data[1] = vec![0u8; 3 * 4];
    put_f32(&mut data[1], 0, 1.0);
    put_f32(&mut data[1], 1, 2.0);
    put_f32(&mut data[1], 2, 3.0);
    (
        data,
        "\nlayout(std140, binding = 0) uniform InputUBO {\n  float data0;\n  float data1[2];\n} g_input_ubo;\nlayout(std430, binding = 0) buffer InputSSBO {\n  float data0;\n  float data1[2];\n} g_input_ssbo;\nlayout(std140, binding = 1) buffer OutputUBO {\n  float data0;\n  float data1[2];\n} g_output_ubo;\nlayout(std430, binding = 2) buffer OutputSSBO {\n  float data0;\n  float data1[2];\n} g_output_ssbo;\nvoid main() {\n  g_output_ubo.data0 = g_input_ubo.data0;\n  for (int i = 0; i < g_input_ubo.data1.length(); ++i) g_output_ubo.data1[i] = g_input_ubo.data1[i];\n  g_output_ssbo.data0 = g_input_ssbo.data0;\n  for (int i = 0; i < g_input_ssbo.data1.length(); ++i) g_output_ssbo.data1[i] = g_input_ssbo.data1[i];\n}",
    )
}

pub(super) fn get_input_ubo2() -> ([Vec<u8>; 2], &'static str) {
    let mut data: [Vec<u8>; 2] = Default::default();
    data[0] = vec![0u8; 280 * 4];
    put_f32(&mut data[0], 0, 1.0);
    put_f32(&mut data[0], 1, 2.0);
    put_f32(&mut data[0], 2, 3.0);
    put_f32(&mut data[0], 3, 4.0);
    put_f32(&mut data[0], 4, 5.0);
    put_f32(&mut data[0], 5, 6.0);
    put_f32(&mut data[0], 6, 7.0);
    put_f32(&mut data[0], 8, 9.0);
    put_f32(&mut data[0], 12, 10.0);
    put_f32(&mut data[0], 16, 11.0);
    put_f32(&mut data[0], 20, 12.0);
    put_f32(&mut data[0], 24, 13.0);
    put_i32(&mut data[0], 28, 14);
    for i in 0..20usize {
        put_f32(&mut data[0], 32 + i * 4, (15 + i) as f32);
    }
    put_i32(&mut data[0], 112, 140);
    for i in 0..20usize {
        put_f32(&mut data[0], 116 + i * 4, (150 + i) as f32);
    }
    put_i32(&mut data[0], 196, 1400);
    for i in 0..20usize {
        put_f32(&mut data[0], 200 + i * 4, (1500 + i) as f32);
    }
    data[1] = vec![0u8; 76 * 4];
    put_f32(&mut data[1], 0, 1.0);
    put_f32(&mut data[1], 1, 2.0);
    put_f32(&mut data[1], 2, 3.0);
    put_f32(&mut data[1], 3, 4.0);
    put_f32(&mut data[1], 4, 5.0);
    put_f32(&mut data[1], 5, 6.0);
    put_f32(&mut data[1], 6, 7.0);
    put_f32(&mut data[1], 7, 8.0);
    put_f32(&mut data[1], 8, 9.0);
    put_f32(&mut data[1], 9, 10.0);
    put_f32(&mut data[1], 10, 11.0);
    put_f32(&mut data[1], 11, 12.0);
    put_f32(&mut data[1], 12, 13.0);
    put_i32(&mut data[1], 13, 14);
    put_f32(&mut data[1], 14, 15.0);
    put_f32(&mut data[1], 15, 16.0);
    put_f32(&mut data[1], 16, 17.0);
    put_f32(&mut data[1], 17, 18.0);
    put_f32(&mut data[1], 18, 19.0);
    put_f32(&mut data[1], 19, 20.0);
    put_f32(&mut data[1], 20, 21.0);
    put_f32(&mut data[1], 21, 22.0);
    put_f32(&mut data[1], 22, 23.0);
    put_f32(&mut data[1], 23, 24.0);
    put_f32(&mut data[1], 24, 25.0);
    put_f32(&mut data[1], 25, 26.0);
    put_f32(&mut data[1], 26, 27.0);
    put_f32(&mut data[1], 27, 28.0);
    put_f32(&mut data[1], 28, 29.0);
    put_f32(&mut data[1], 29, 30.0);
    put_f32(&mut data[1], 30, 31.0);
    put_f32(&mut data[1], 31, 32.0);
    put_f32(&mut data[1], 32, 33.0);
    put_f32(&mut data[1], 33, 34.0);
    put_i32(&mut data[1], 34, 35);
    put_f32(&mut data[1], 35, 36.0);
    put_f32(&mut data[1], 36, 37.0);
    put_f32(&mut data[1], 37, 38.0);
    put_f32(&mut data[1], 38, 39.0);
    put_f32(&mut data[1], 39, 40.0);
    put_f32(&mut data[1], 40, 41.0);
    put_f32(&mut data[1], 41, 42.0);
    put_f32(&mut data[1], 42, 43.0);
    put_f32(&mut data[1], 43, 44.0);
    put_f32(&mut data[1], 44, 45.0);
    put_f32(&mut data[1], 45, 46.0);
    put_f32(&mut data[1], 46, 47.0);
    put_f32(&mut data[1], 47, 48.0);
    put_f32(&mut data[1], 48, 49.0);
    put_f32(&mut data[1], 49, 50.0);
    put_f32(&mut data[1], 50, 51.0);
    put_f32(&mut data[1], 51, 52.0);
    put_f32(&mut data[1], 52, 53.0);
    put_f32(&mut data[1], 53, 54.0);
    put_f32(&mut data[1], 54, 55.0);
    put_i32(&mut data[1], 55, 56);
    put_f32(&mut data[1], 56, 57.0);
    put_f32(&mut data[1], 57, 58.0);
    put_f32(&mut data[1], 58, 59.0);
    put_f32(&mut data[1], 59, 60.0);
    put_f32(&mut data[1], 60, 61.0);
    put_f32(&mut data[1], 61, 62.0);
    put_f32(&mut data[1], 62, 63.0);
    put_f32(&mut data[1], 63, 64.0);
    put_f32(&mut data[1], 64, 65.0);
    put_f32(&mut data[1], 65, 66.0);
    put_f32(&mut data[1], 66, 67.0);
    put_f32(&mut data[1], 67, 68.0);
    put_f32(&mut data[1], 68, 69.0);
    put_f32(&mut data[1], 69, 70.0);
    put_f32(&mut data[1], 70, 71.0);
    put_f32(&mut data[1], 71, 72.0);
    put_f32(&mut data[1], 72, 73.0);
    put_f32(&mut data[1], 73, 74.0);
    put_f32(&mut data[1], 74, 75.0);
    put_f32(&mut data[1], 75, 76.0);
    (
        data,
        "\nstruct MM {\n  float mm_a[5];\n};\nstruct TT {\n  int tt_a;\n  MM  tt_b[4];\n};\nlayout(std140, binding = 0) uniform InputUBO {\n  vec4  a;\n  vec4  b;\n  float c;\n  float d[4];\n  TT    e[3];\n} g_input_ubo;\nlayout(std430, binding = 0) buffer InputSSBO {\n  vec4  a;\n  vec4  b;\n  float c;\n  float d[4];\n  TT    e[3];\n} g_input_ssbo;\nlayout(std140, binding = 1) buffer OutputUBO {\n  vec4  a;\n  vec4  b;\n  float c;\n  float d[4];\n  TT    e[3];\n} g_output_ubo;\nlayout(std430, binding = 2) buffer OutputSSBO {\n  vec4  a;\n  vec4  b;\n  float c;\n  float d[4];\n  TT    e[3];\n} g_output_ssbo;\nuniform int g_index1;\nvoid main() {\n  int index0 = 0;\n\n  g_output_ubo.a = g_input_ubo.a;\n  g_output_ubo.b = g_input_ubo.b;\n  g_output_ubo.c = g_input_ubo.c;\n  for (int i = 0; i < g_input_ubo.d.length(); ++i) g_output_ubo.d[i] = g_input_ubo.d[i];\n    for (int j = 0; j < g_input_ubo.e.length(); ++j) {\n    g_output_ubo.e[j].tt_a = g_input_ubo.e[j].tt_a;\n    for (int i = 0; i < g_input_ubo.e[j].tt_b.length(); ++i) {\n      g_output_ubo.e[j].tt_b[i].mm_a[0] = g_input_ubo.e[j].tt_b[i].mm_a[0];\n      g_output_ubo.e[j].tt_b[index0 + i].mm_a[1] = g_input_ubo.e[j].tt_b[i].mm_a[1];\n      g_output_ubo.e[j].tt_b[i].mm_a[2] = g_input_ubo.e[j].tt_b[i].mm_a[2 + index0];\n      g_output_ubo.e[j + 1 - g_index1].tt_b[i].mm_a[4 - g_index1] = g_input_ubo.e[j].tt_b[i].mm_a[2 + g_index1];\n      g_output_ubo.e[j].tt_b[i].mm_a[4] = g_input_ubo.e[j].tt_b[i - index0].mm_a[4];\n    }\n  }\n\n  g_output_ssbo.a = g_input_ssbo.a;\n  g_output_ssbo.b = g_input_ssbo.b;\n  g_output_ssbo.c = g_input_ssbo.c;\n  for (int i = 0; i < g_input_ssbo.d.length(); ++i) g_output_ssbo.d[i] = g_input_ssbo.d[i];\n  for (int j = 0; j < g_input_ssbo.e.length(); ++j) {\n    g_output_ssbo.e[j].tt_a = g_input_ssbo.e[j].tt_a;\n    for (int i = 0; i < g_input_ssbo.e[j].tt_b.length(); ++i) {\n      g_output_ssbo.e[j + index0].tt_b[i].mm_a[0] = g_input_ssbo.e[j].tt_b[i].mm_a[index0];\n      g_output_ssbo.e[j].tt_b[i + index0].mm_a[1] = g_input_ssbo.e[j].tt_b[i].mm_a[g_index1];\n      g_output_ssbo.e[j].tt_b[i].mm_a[2] = g_input_ssbo.e[j].tt_b[i].mm_a[1 + g_index1];\n      g_output_ssbo.e[j - index0].tt_b[i].mm_a[g_index1 + 2] = g_input_ssbo.e[j].tt_b[i].mm_a[4 - g_index1];\n      g_output_ssbo.e[j].tt_b[i].mm_a[4] = g_input_ssbo.e[j].tt_b[i].mm_a[4];\n    }\n  }\n}",
    )
}

pub(super) fn get_input_m1() -> (Vec<f32>, Vec<f32>, &'static str) {
    let mut input = vec![0.0f32; 8];
    input[0] = 1.0;
    input[2] = 3.0;
    input[1] = 2.0;
    input[3] = 4.0;
    input[4] = 1.0;
    input[6] = 3.0;
    input[5] = 2.0;
    input[7] = 4.0;
    let mut expected = vec![0.0f32; 4];
    expected[0] = 7.0;
    expected[2] = 15.0;
    expected[1] = 10.0;
    expected[3] = 22.0;
    (
        input,
        expected,
        "\nlayout(std430, binding = 0) buffer Input {\n  mat2 m0;\n  mat2 m1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  mat2 m;\n} g_output;\nvoid main() { g_output.m = g_input.m0 * g_input.m1; }",
    )
}

pub(super) fn get_input_m2() -> (Vec<f32>, Vec<f32>, &'static str) {
    let mut input = vec![0.0f32; 15];
    let mut expected = vec![0.0f32; 4];
    input[0] = 1.0;
    input[2] = 3.0;
    input[4] = 5.0;
    input[1] = 2.0;
    input[3] = 4.0;
    input[5] = 6.0;
    input[8] = 1.0;
    input[12] = 4.0;
    input[9] = 2.0;
    input[13] = 5.0;
    input[10] = 3.0;
    input[14] = 6.0;
    expected[0] = 22.0;
    expected[2] = 49.0;
    expected[1] = 28.0;
    expected[3] = 64.0;
    (
        input,
        expected,
        "\nlayout(std430, binding = 0) buffer Input {\n  layout(column_major) mat3x2 m0;\n  layout(column_major) mat2x3 m1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  layout(column_major) mat2 m;\n} g_output;\nvoid main() { g_output.m = g_input.m0 * g_input.m1; }",
    )
}

pub(super) fn get_input_m3() -> (Vec<f32>, Vec<f32>, &'static str) {
    let mut input = vec![0.0f32; 15];
    let mut expected = vec![0.0f32; 4];
    input[0] = 1.0;
    input[1] = 3.0;
    input[2] = 5.0;
    input[4] = 2.0;
    input[5] = 4.0;
    input[6] = 6.0;
    input[8] = 1.0;
    input[9] = 4.0;
    input[10] = 2.0;
    input[11] = 5.0;
    input[12] = 3.0;
    input[13] = 6.0;
    expected[0] = 22.0;
    expected[1] = 49.0;
    expected[2] = 28.0;
    expected[3] = 64.0;
    (
        input,
        expected,
        "\nlayout(std430, binding = 0) buffer Input {\n  layout(row_major) mat3x2 m0;\n  layout(row_major) mat2x3 m1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  layout(row_major) mat2 m;\n} g_output;\nvoid main() { g_output.m = g_input.m0 * g_input.m1; }",
    )
}

pub(super) fn get_input_m4() -> (Vec<f32>, Vec<f32>, &'static str) {
    let mut input = vec![0.0f32; 15];
    let mut expected = vec![0.0f32; 4];
    input[0] = 1.0;
    input[2] = 3.0;
    input[4] = 5.0;
    input[1] = 2.0;
    input[3] = 4.0;
    input[5] = 6.0;
    input[8] = 1.0;
    input[9] = 4.0;
    input[10] = 2.0;
    input[11] = 5.0;
    input[12] = 3.0;
    input[13] = 6.0;
    expected[0] = 13.0;
    expected[1] = 16.0;
    expected[2] = 37.0;
    expected[3] = 46.0;
    (
        input,
        expected,
        "\nlayout(std430, binding = 0) buffer Input {\n  layout(column_major) mat3x2 m0;\n  layout(row_major) mat2x3 m1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  layout(column_major) mat2 m;\n} g_output;\nvoid main() { g_output.m = g_input.m0 * g_input.m1; }",
    )
}

pub(super) fn get_input_m5() -> (Vec<f32>, Vec<f32>, &'static str) {
    let mut input = vec![0.0f32; 15];
    let mut expected = vec![0.0f32; 4];
    input[0] = 1.0;
    input[2] = 3.0;
    input[4] = 5.0;
    input[1] = 2.0;
    input[3] = 4.0;
    input[5] = 6.0;
    input[8] = 1.0;
    input[9] = 4.0;
    input[10] = 2.0;
    input[11] = 5.0;
    input[12] = 3.0;
    input[13] = 6.0;
    expected[0] = 13.0;
    expected[1] = 37.0;
    expected[2] = 16.0;
    expected[3] = 46.0;
    (
        input,
        expected,
        "\nlayout(std430, binding = 0) buffer Input {\n  layout(column_major) mat3x2 m0;\n  layout(row_major) mat2x3 m1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  layout(row_major) mat2 m;\n} g_output;\nvoid main() { g_output.m = g_input.m0 * g_input.m1; }",
    )
}

pub(super) fn get_input_m6() -> (Vec<f32>, Vec<f32>, &'static str) {
    let mut input = vec![0.0f32; 20];
    let mut expected = vec![0.0f32; 4];
    input[0] = 1.0;
    input[1] = 3.0;
    input[2] = 5.0;
    input[4] = 2.0;
    input[5] = 4.0;
    input[6] = 6.0;
    input[8] = 1.0;
    input[12] = 4.0;
    input[9] = 2.0;
    input[13] = 5.0;
    input[10] = 3.0;
    input[14] = 6.0;
    expected[0] = 22.0;
    expected[1] = 28.0;
    expected[2] = 49.0;
    expected[3] = 64.0;
    (
        input,
        expected,
        "\nlayout(std430, binding = 0) buffer Input {\n  layout(row_major) mat3x2 m0;\n  layout(column_major) mat2x3 m1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  layout(column_major) mat2 m;\n} g_output;\nvoid main() { g_output.m = g_input.m0 * g_input.m1; }",
    )
}

pub(super) fn get_input_m7() -> (Vec<f32>, Vec<f32>, &'static str) {
    let mut input = vec![0.0f32; 20];
    let mut expected = vec![0.0f32; 4];
    input[0] = 1.0;
    input[1] = 3.0;
    input[2] = 5.0;
    input[4] = 2.0;
    input[5] = 4.0;
    input[6] = 6.0;
    input[8] = 1.0;
    input[12] = 4.0;
    input[9] = 2.0;
    input[13] = 5.0;
    input[10] = 3.0;
    input[14] = 6.0;
    expected[0] = 22.0;
    expected[1] = 49.0;
    expected[2] = 28.0;
    expected[3] = 64.0;
    (
        input,
        expected,
        "\nlayout(std430, binding = 0) buffer Input {\n  layout(row_major) mat3x2 m0;\n  layout(column_major) mat2x3 m1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  layout(row_major) mat2 m;\n} g_output;\nvoid main() { g_output.m = g_input.m0 * g_input.m1; }",
    )
}

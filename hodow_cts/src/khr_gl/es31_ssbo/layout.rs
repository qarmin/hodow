// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `GetInput*` functions return the buffer bytes and the shader source instead of filling an out parameter; `BasicStdLayoutBaseVS`/`CS` take that function as a field instead of a virtual method.

use super::super::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};
use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLuint};

pub(in crate::khr_gl) type GetInput = fn() -> (Vec<u8>, &'static str);

/// Compares the bytes the shader copied into the second buffer against the input, logging each differing byte.
pub(in crate::khr_gl) fn compare_bytes(expected: &[u8], actual: &[u8]) -> bool {
    let mut status = true;
    for (i, (want, got)) in expected.iter().zip(actual).enumerate() {
        if want != got {
            log::info!("Byte at index {i} is {got:#04x} should be {want:#04x}");
            status = false;
        }
    }
    status
}

/// 1.6.x BasicStdLayoutBaseVS
pub(super) struct BasicStdLayoutBaseVs {
    get_input: GetInput,
    program: GLuint,
    buffer: [GLuint; 2],
    vertex_array: GLuint,
}

impl BasicStdLayoutBaseVs {
    pub(super) fn new(get_input: GetInput) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 2],
            vertex_array: 0,
        }
    }
}

impl Subcase for BasicStdLayoutBaseVs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 2, 0) {
            return Ok(NOT_SUPPORTED);
        }
        let (in_data, glsl_vs) = (self.get_input)();

        self.program = create_program(gl, glsl_vs, FS_GREEN);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));

        let out_d = vec![0u8; in_data.len()];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.buffer[1]));
        ssbo_data(gl, &out_d, glw::GL_STATIC_DRAW);

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer[0]));
        ssbo_data(gl, &in_data, glw::GL_STATIC_DRAW);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[1]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let Some(out_data) = map_read::<u8>(gl, 0, in_data.len()) else {
            return Ok(ERROR);
        };
        let status = compare_bytes(&in_data, &out_data);
        unmap(gl);
        Ok(if status { NO_ERROR } else { ERROR })
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

/// 1.6.x BasicStdLayoutBaseCS
pub(super) struct BasicStdLayoutBaseCs {
    get_input: GetInput,
    program: GLuint,
    buffer: [GLuint; 2],
}

impl BasicStdLayoutBaseCs {
    pub(super) fn new(get_input: GetInput) -> Self {
        Self {
            get_input,
            program: 0,
            buffer: [0; 2],
        }
    }
}

impl Subcase for BasicStdLayoutBaseCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (in_data, body) = (self.get_input)();
        let source = format!("layout(local_size_x = 1) in;\n{body}");

        self.program = create_program_cs(gl, &source);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer[0]));
        ssbo_data(gl, &in_data, glw::GL_STATIC_DRAW);
        let out_d = vec![0u8; in_data.len()];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.buffer[1]));
        ssbo_data(gl, &out_d, glw::GL_STATIC_DRAW);

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));

        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let Some(out_data) = map_read::<u8>(gl, 0, in_data.len()) else {
            return Ok(ERROR);
        };
        let status = compare_bytes(&in_data, &out_data);
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

pub(in crate::khr_gl) fn get_input_430c1() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 6 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 2.0);
    put_f32(&mut data, 2, 3.0);
    put_f32(&mut data, 3, 4.0);
    put_i32(&mut data, 4, 5);
    put_i32(&mut data, 5, 6);
    (
        data,
        "\nlayout(std430, binding = 0) buffer Input {\n  float data0;\n  float data1[3];\n  ivec2 data2;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  float data0;\n  float data1[3];\n  ivec2 data2;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n  for (int i = 0; i < g_input.data1.length(); ++i) g_output.data1[i] = g_input.data1[i];\n  g_output.data2 = g_input.data2;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_430c2() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 17 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 2.0);
    put_f32(&mut data, 2, 3.0);
    put_f32(&mut data, 3, 4.0);
    put_f32(&mut data, 4, 5.0);
    put_f32(&mut data, 5, 6.0);
    put_f32(&mut data, 8, 7.0);
    put_f32(&mut data, 9, 8.0);
    put_f32(&mut data, 10, 9.0);
    put_f32(&mut data, 12, 10.0);
    put_f32(&mut data, 13, 11.0);
    put_f32(&mut data, 14, 12.0);
    put_f32(&mut data, 16, 13.0);
    (
        data,
        "\nlayout(std430, binding = 0) buffer Input {\n  float data0;\n  float data1[3];\n  vec2 data2;\n  readonly vec3 data3[2];\n  float data4;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  float data0;\n  float data1[3];\n  vec2 data2;\n  vec3 data3[2];\n  float data4;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n  for (int i = 0; i < g_input.data1.length(); ++i) g_output.data1[i] = g_input.data1[i];\n  g_output.data2 = g_input.data2;\n  for (int i = 0; i < g_input.data3.length(); ++i) g_output.data3[i] = g_input.data3[i];\n  g_output.data4 = g_input.data4;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_430c3() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 16 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 2.0);
    put_f32(&mut data, 2, 3.0);
    put_f32(&mut data, 3, 0.0);
    put_f32(&mut data, 4, 4.0);
    put_f32(&mut data, 5, 5.0);
    put_f32(&mut data, 6, 6.0);
    put_f32(&mut data, 7, 0.0);
    put_f32(&mut data, 8, 7.0);
    put_f32(&mut data, 9, 8.0);
    put_f32(&mut data, 10, 9.0);
    put_f32(&mut data, 11, 10.0);
    put_f32(&mut data, 12, 11.0);
    put_f32(&mut data, 13, 12.0);
    put_f32(&mut data, 14, 13.0);
    put_f32(&mut data, 15, 14.0);
    (
        data,
        "\nlayout(std430, binding = 0) buffer Input {\n  layout(column_major) mat2x3 data0;\n  layout(row_major) mat4x2 data1;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  layout(column_major) mat2x3 data0;\n  layout(row_major) mat4x2 data1;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n  g_output.data1 = g_input.data1;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_430c4() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 17 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 2.0);
    put_f32(&mut data, 2, 3.0);
    put_f32(&mut data, 3, 4.0);
    put_f32(&mut data, 4, 5.0);
    put_f32(&mut data, 5, 6.0);
    put_f32(&mut data, 6, 7.0);
    put_f32(&mut data, 7, 8.0);
    put_f32(&mut data, 8, 9.0);
    put_f32(&mut data, 9, 10.0);
    put_f32(&mut data, 10, 11.0);
    put_f32(&mut data, 12, 12.0);
    put_f32(&mut data, 13, 13.0);
    put_f32(&mut data, 14, 14.0);
    put_f32(&mut data, 16, 15.0);
    (
        data,
        "\nlayout(std430, binding = 0) buffer Input {\n  mat4x2 data0;\n  mat2x3 data1;\n  float data2;\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  mat4x2 data0;\n  mat2x3 data1;\n  float data2;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n  g_output.data1 = g_input.data1;\n  g_output.data2 = g_input.data2;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_430c5() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 8 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 3.0);
    put_f32(&mut data, 2, 5.0);
    put_f32(&mut data, 3, 7.0);
    put_f32(&mut data, 4, 2.0);
    put_f32(&mut data, 5, 4.0);
    put_f32(&mut data, 6, 6.0);
    put_f32(&mut data, 7, 8.0);
    (
        data,
        "\nlayout(std430, binding = 0, row_major) buffer Input {\n  mat4x2 data0;\n} g_input;\nlayout(std430, binding = 1, row_major) buffer Output {\n  mat4x2 data0;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_430c6() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 92 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 2.0);
    put_f32(&mut data, 2, 3.0);
    put_f32(&mut data, 3, 4.0);
    put_f32(&mut data, 4, 5.0);
    put_f32(&mut data, 5, 0.0);
    put_f32(&mut data, 6, 6.0);
    put_f32(&mut data, 7, 7.0);
    put_f32(&mut data, 8, 8.0);
    put_f32(&mut data, 9, 9.0);
    put_f32(&mut data, 10, 10.0);
    put_f32(&mut data, 11, 11.0);
    put_f32(&mut data, 12, 12.0);
    put_f32(&mut data, 13, 0.0);
    put_f32(&mut data, 14, 0.0);
    put_f32(&mut data, 15, 0.0);
    put_f32(&mut data, 16, 13.0);
    put_f32(&mut data, 17, 14.0);
    put_f32(&mut data, 18, 15.0);
    put_f32(&mut data, 19, 0.0);
    put_f32(&mut data, 20, 16.0);
    put_f32(&mut data, 21, 17.0);
    put_f32(&mut data, 22, 18.0);
    put_f32(&mut data, 23, 0.0);
    put_f32(&mut data, 24, 19.0);
    put_f32(&mut data, 25, 20.0);
    put_f32(&mut data, 26, 21.0);
    put_f32(&mut data, 27, 22.0);
    put_f32(&mut data, 28, 23.0);
    put_f32(&mut data, 29, 24.0);
    put_f32(&mut data, 30, 25.0);
    put_f32(&mut data, 31, 26.0);
    put_f32(&mut data, 32, 27.0);
    put_f32(&mut data, 33, 28.0);
    put_f32(&mut data, 34, 0.0);
    put_f32(&mut data, 35, 0.0);
    put_f32(&mut data, 36, 29.0);
    put_f32(&mut data, 37, 30.0);
    put_f32(&mut data, 38, 31.0);
    put_f32(&mut data, 39, 0.0);
    put_f32(&mut data, 40, 32.0);
    put_f32(&mut data, 41, 33.0);
    put_f32(&mut data, 42, 34.0);
    put_f32(&mut data, 43, 0.0);
    put_f32(&mut data, 44, 35.0);
    put_f32(&mut data, 45, 36.0);
    put_f32(&mut data, 46, 37.0);
    put_f32(&mut data, 47, 0.0);
    put_f32(&mut data, 48, 38.0);
    put_f32(&mut data, 49, 39.0);
    put_f32(&mut data, 50, 40.0);
    put_f32(&mut data, 51, 0.0);
    put_f32(&mut data, 52, 41.0);
    put_f32(&mut data, 53, 42.0);
    put_f32(&mut data, 54, 43.0);
    put_f32(&mut data, 55, 0.0);
    put_f32(&mut data, 56, 44.0);
    put_f32(&mut data, 57, 45.0);
    put_f32(&mut data, 58, 46.0);
    put_f32(&mut data, 59, 0.0);
    put_f32(&mut data, 60, 47.0);
    put_f32(&mut data, 61, 48.0);
    put_f32(&mut data, 62, 49.0);
    put_f32(&mut data, 63, 50.0);
    put_f32(&mut data, 64, 51.0);
    put_f32(&mut data, 65, 52.0);
    put_f32(&mut data, 66, 53.0);
    put_f32(&mut data, 67, 54.0);
    put_f32(&mut data, 68, 55.0);
    put_f32(&mut data, 69, 56.0);
    put_f32(&mut data, 70, 57.0);
    put_f32(&mut data, 71, 58.0);
    put_f32(&mut data, 72, 59.0);
    put_f32(&mut data, 73, 60.0);
    put_f32(&mut data, 74, 61.0);
    put_f32(&mut data, 75, 62.0);
    put_f32(&mut data, 76, 63.0);
    put_f32(&mut data, 77, 64.0);
    put_f32(&mut data, 78, 65.0);
    put_f32(&mut data, 79, 66.0);
    put_f32(&mut data, 80, 67.0);
    put_f32(&mut data, 81, 68.0);
    put_f32(&mut data, 82, 69.0);
    put_f32(&mut data, 83, 70.0);
    put_f32(&mut data, 84, 71.0);
    put_f32(&mut data, 85, 72.0);
    put_f32(&mut data, 86, 73.0);
    put_f32(&mut data, 87, 74.0);
    put_f32(&mut data, 88, 75.0);
    put_f32(&mut data, 89, 76.0);
    put_f32(&mut data, 90, 77.0);
    put_f32(&mut data, 91, 78.0);
    (
        data,
        "\nlayout(std430, binding = 0) buffer Input {\n  float data0[2];\n  float data1[3];\n  vec2 data2;\n  float data3[5];\n  vec3 data4[2];\n  float data5[2];\n  mat2 data6[2];\n  mat3 data7[2];\n  mat4 data8[2];\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  float data0[2];\n  float data1[3];\n  vec2 data2;\n  float data3[5];\n  vec3 data4[2];\n  float data5[2];\n  mat2 data6[2];\n  mat3 data7[2];\n  mat4 data8[2];\n} g_output;\nvoid main() {\n  for (int i = 0; i < g_input.data0.length(); ++i) g_output.data0[i] = g_input.data0[i];\n  for (int i = 0; i < g_input.data1.length(); ++i) g_output.data1[i] = g_input.data1[i];\n  g_output.data2 = g_input.data2;\n  for (int i = 0; i < g_input.data3.length(); ++i) g_output.data3[i] = g_input.data3[i];\n  for (int i = 0; i < g_input.data4.length(); ++i) g_output.data4[i] = g_input.data4[i];\n  for (int i = 0; i < g_input.data5.length(); ++i) g_output.data5[i] = g_input.data5[i];\n  for (int i = 0; i < g_input.data6.length(); ++i) g_output.data6[i] = g_input.data6[i];\n  for (int i = 0; i < g_input.data7.length(); ++i) g_output.data7[i] = g_input.data7[i];\n  for (int i = 0; i < g_input.data8.length(); ++i) g_output.data8[i] = g_input.data8[i];\n}",
    )
}

pub(in crate::khr_gl) fn get_input_430c7() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 36 * 4];
    put_i32(&mut data, 0, 1);
    put_i32(&mut data, 1, 0);
    put_i32(&mut data, 2, 2);
    put_i32(&mut data, 3, 3);
    put_f32(&mut data, 4, 4.0);
    put_f32(&mut data, 5, 0.0);
    put_f32(&mut data, 6, 0.0);
    put_f32(&mut data, 7, 0.0);
    put_f32(&mut data, 8, 5.0);
    put_f32(&mut data, 9, 6.0);
    put_f32(&mut data, 10, 7.0);
    put_f32(&mut data, 11, 0.0);
    put_f32(&mut data, 12, 8.0);
    put_f32(&mut data, 13, 0.0);
    put_f32(&mut data, 14, 0.0);
    put_f32(&mut data, 15, 0.0);
    put_f32(&mut data, 16, 9.0);
    put_f32(&mut data, 17, 10.0);
    put_f32(&mut data, 18, 11.0);
    put_f32(&mut data, 19, 0.0);
    put_i32(&mut data, 20, 12);
    put_i32(&mut data, 21, 13);
    put_i32(&mut data, 22, 14);
    put_i32(&mut data, 23, 15);
    put_f32(&mut data, 24, 16.0);
    put_f32(&mut data, 25, 0.0);
    put_f32(&mut data, 26, 0.0);
    put_f32(&mut data, 27, 0.0);
    put_f32(&mut data, 28, 17.0);
    put_f32(&mut data, 29, 18.0);
    put_f32(&mut data, 30, 19.0);
    put_f32(&mut data, 31, 0.0);
    put_i32(&mut data, 32, 20);
    put_i32(&mut data, 33, 21);
    put_i32(&mut data, 34, 22);
    put_i32(&mut data, 35, 23);
    (
        data,
        "\nstruct Struct0 {\n  ivec2 m0;\n};\nstruct Struct1 {\n  vec3 m0;\n};\nstruct Struct3 {\n  int m0;\n};\nstruct Struct2 {\n  float m0;\n  Struct1 m1;\n  Struct0 m2;\n  int m3;\n  Struct3 m4;\n};\nlayout(std430, binding = 0) buffer Input {\n  int data0;\n  Struct0 data1;\n  float data2;\n  Struct1 data3;\n  Struct2 data4[2];\n} g_input;\nlayout(std430, binding = 1) buffer Output {\n  int data0;\n  Struct0 data1;\n  float data2;\n  Struct1 data3;\n  Struct2 data4[2];\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n  g_output.data1 = g_input.data1;\n  g_output.data2 = g_input.data2;\n  g_output.data3 = g_input.data3;\n  for (int i = 0; i < g_input.data4.length(); ++i) g_output.data4[i] = g_input.data4[i];\n}",
    )
}

pub(in crate::khr_gl) fn get_input_140c1() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 5 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 0.0);
    put_f32(&mut data, 2, 0.0);
    put_f32(&mut data, 3, 0.0);
    put_f32(&mut data, 4, 2.0);
    (
        data,
        "\nlayout(std140, binding = 0) buffer Input {\n  float data0[2];\n} g_input;\nlayout(std140, binding = 1) buffer Output {\n  float data0[2];\n} g_output;\nvoid main() {\n  for (int i = 0; i < g_input.data0.length(); ++i) g_output.data0[i] = g_input.data0[i];\n}",
    )
}

pub(in crate::khr_gl) fn get_input_140c2() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 18 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 0.0);
    put_f32(&mut data, 2, 0.0);
    put_f32(&mut data, 3, 0.0);
    put_f32(&mut data, 4, 2.0);
    put_f32(&mut data, 5, 0.0);
    put_f32(&mut data, 6, 0.0);
    put_f32(&mut data, 7, 0.0);
    put_f32(&mut data, 8, 3.0);
    put_f32(&mut data, 9, 0.0);
    put_f32(&mut data, 10, 0.0);
    put_f32(&mut data, 11, 0.0);
    put_f32(&mut data, 12, 4.0);
    put_f32(&mut data, 13, 0.0);
    put_f32(&mut data, 14, 0.0);
    put_f32(&mut data, 15, 0.0);
    put_i32(&mut data, 16, 5);
    put_i32(&mut data, 17, 6);
    (
        data,
        "\nlayout(std140, binding = 0) buffer Input {\n  float data0;\n  float data1[3];\n  ivec2 data2;\n} g_input;\nlayout(std140, binding = 1) buffer Output {\n  float data0;\n  float data1[3];\n  ivec2 data2;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n  for (int i = 0; i < g_input.data1.length(); ++i) g_output.data1[i] = g_input.data1[i];\n  g_output.data2 = g_input.data2;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_140c3() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 29 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 0.0);
    put_f32(&mut data, 2, 0.0);
    put_f32(&mut data, 3, 0.0);
    put_f32(&mut data, 4, 2.0);
    put_f32(&mut data, 5, 0.0);
    put_f32(&mut data, 6, 0.0);
    put_f32(&mut data, 7, 0.0);
    put_f32(&mut data, 8, 3.0);
    put_f32(&mut data, 9, 0.0);
    put_f32(&mut data, 10, 0.0);
    put_f32(&mut data, 11, 0.0);
    put_f32(&mut data, 12, 4.0);
    put_f32(&mut data, 13, 0.0);
    put_f32(&mut data, 14, 0.0);
    put_f32(&mut data, 15, 0.0);
    put_f32(&mut data, 16, 5.0);
    put_f32(&mut data, 17, 6.0);
    put_f32(&mut data, 18, 0.0);
    put_f32(&mut data, 19, 0.0);
    put_f32(&mut data, 20, 7.0);
    put_f32(&mut data, 21, 8.0);
    put_f32(&mut data, 22, 9.0);
    put_f32(&mut data, 23, 0.0);
    put_f32(&mut data, 24, 10.0);
    put_f32(&mut data, 25, 11.0);
    put_f32(&mut data, 26, 12.0);
    put_f32(&mut data, 27, 0.0);
    put_f32(&mut data, 28, 13.0);
    (
        data,
        "\nlayout(std140, binding = 0) buffer Input {\n  float data0;\n  float data1[3];\n  vec2 data2;\n  readonly vec3 data3[2];\n  float data4;\n} g_input;\nlayout(std140, binding = 1) buffer Output {\n  float data0;\n  float data1[3];\n  vec2 data2;\n  vec3 data3[2];\n  float data4;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n  for (int i = 0; i < g_input.data1.length(); ++i) g_output.data1[i] = g_input.data1[i];\n  g_output.data2 = g_input.data2;\n  for (int i = 0; i < g_input.data3.length(); ++i) g_output.data3[i] = g_input.data3[i];\n  g_output.data4 = g_input.data4;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_140c4() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 25 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 2.0);
    put_f32(&mut data, 2, 0.0);
    put_f32(&mut data, 3, 0.0);
    put_f32(&mut data, 4, 3.0);
    put_f32(&mut data, 5, 4.0);
    put_f32(&mut data, 6, 0.0);
    put_f32(&mut data, 7, 0.0);
    put_f32(&mut data, 8, 5.0);
    put_f32(&mut data, 9, 6.0);
    put_f32(&mut data, 10, 0.0);
    put_f32(&mut data, 11, 0.0);
    put_f32(&mut data, 12, 7.0);
    put_f32(&mut data, 13, 8.0);
    put_f32(&mut data, 14, 0.0);
    put_f32(&mut data, 15, 0.0);
    put_f32(&mut data, 16, 9.0);
    put_f32(&mut data, 17, 10.0);
    put_f32(&mut data, 18, 11.0);
    put_f32(&mut data, 19, 0.0);
    put_f32(&mut data, 20, 12.0);
    put_f32(&mut data, 21, 13.0);
    put_f32(&mut data, 22, 14.0);
    put_f32(&mut data, 23, 0.0);
    put_f32(&mut data, 24, 15.0);
    (
        data,
        "\nlayout(std140, binding = 0) buffer Input {\n  mat4x2 data0;\n  mat2x3 data1;\n  float data2;\n} g_input;\nlayout(std140, binding = 1) buffer Output {\n  mat4x2 data0;\n  mat2x3 data1;\n  float data2;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n  g_output.data1 = g_input.data1;\n  g_output.data2 = g_input.data2;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_140c5() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 8 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 2.0);
    put_f32(&mut data, 2, 3.0);
    put_f32(&mut data, 3, 4.0);
    put_f32(&mut data, 4, 5.0);
    put_f32(&mut data, 5, 6.0);
    put_f32(&mut data, 6, 7.0);
    put_f32(&mut data, 7, 8.0);
    (
        data,
        "\nlayout(std140, binding = 0, row_major) buffer Input {\n  mat4x2 data0;\n} g_input;\nlayout(std140, binding = 1, row_major) buffer Output {\n  mat4x2 data0;\n} g_output;\nvoid main() {\n  g_output.data0 = g_input.data0;\n}",
    )
}

pub(in crate::khr_gl) fn get_input_140c6() -> (Vec<u8>, &'static str) {
    let mut data = vec![0u8; 96 * 4];
    put_f32(&mut data, 0, 1.0);
    put_f32(&mut data, 1, 0.0);
    put_f32(&mut data, 2, 0.0);
    put_f32(&mut data, 3, 0.0);
    put_f32(&mut data, 4, 2.0);
    put_f32(&mut data, 5, 0.0);
    put_f32(&mut data, 6, 0.0);
    put_f32(&mut data, 7, 0.0);
    put_f32(&mut data, 8, 3.0);
    put_f32(&mut data, 9, 0.0);
    put_f32(&mut data, 10, 0.0);
    put_f32(&mut data, 11, 0.0);
    put_f32(&mut data, 12, 4.0);
    put_f32(&mut data, 13, 0.0);
    put_f32(&mut data, 14, 0.0);
    put_f32(&mut data, 15, 0.0);
    put_f32(&mut data, 16, 5.0);
    put_f32(&mut data, 17, 0.0);
    put_f32(&mut data, 18, 0.0);
    put_f32(&mut data, 19, 0.0);
    put_f32(&mut data, 20, 6.0);
    put_f32(&mut data, 21, 7.0);
    put_f32(&mut data, 22, 8.0);
    put_f32(&mut data, 23, 9.0);
    put_f32(&mut data, 24, 10.0);
    put_f32(&mut data, 25, 11.0);
    put_f32(&mut data, 26, 0.0);
    put_f32(&mut data, 27, 0.0);
    put_f32(&mut data, 28, 12.0);
    put_f32(&mut data, 29, 13.0);
    put_f32(&mut data, 30, 0.0);
    put_f32(&mut data, 31, 0.0);
    put_f32(&mut data, 32, 14.0);
    put_f32(&mut data, 33, 15.0);
    put_f32(&mut data, 34, 0.0);
    put_f32(&mut data, 35, 0.0);
    put_f32(&mut data, 36, 16.0);
    put_f32(&mut data, 37, 17.0);
    put_f32(&mut data, 38, 0.0);
    put_f32(&mut data, 39, 0.0);
    put_f32(&mut data, 40, 18.0);
    put_f32(&mut data, 41, 19.0);
    put_f32(&mut data, 42, 20.0);
    put_f32(&mut data, 43, 0.0);
    put_f32(&mut data, 44, 21.0);
    put_f32(&mut data, 45, 22.0);
    put_f32(&mut data, 46, 23.0);
    put_f32(&mut data, 47, 0.0);
    put_f32(&mut data, 48, 24.0);
    put_f32(&mut data, 49, 25.0);
    put_f32(&mut data, 50, 26.0);
    put_f32(&mut data, 51, 0.0);
    put_f32(&mut data, 52, 27.0);
    put_f32(&mut data, 53, 28.0);
    put_f32(&mut data, 54, 29.0);
    put_f32(&mut data, 55, 0.0);
    put_f32(&mut data, 56, 30.0);
    put_f32(&mut data, 57, 31.0);
    put_f32(&mut data, 58, 32.0);
    put_f32(&mut data, 59, 0.0);
    put_f32(&mut data, 60, 33.0);
    put_f32(&mut data, 61, 34.0);
    put_f32(&mut data, 62, 35.0);
    put_f32(&mut data, 63, 0.0);
    put_f32(&mut data, 64, 36.0);
    put_f32(&mut data, 65, 37.0);
    put_f32(&mut data, 66, 38.0);
    put_f32(&mut data, 67, 39.0);
    put_f32(&mut data, 68, 40.0);
    put_f32(&mut data, 69, 41.0);
    put_f32(&mut data, 70, 42.0);
    put_f32(&mut data, 71, 43.0);
    put_f32(&mut data, 72, 44.0);
    put_f32(&mut data, 73, 45.0);
    put_f32(&mut data, 74, 46.0);
    put_f32(&mut data, 75, 47.0);
    put_f32(&mut data, 76, 48.0);
    put_f32(&mut data, 77, 49.0);
    put_f32(&mut data, 78, 50.0);
    put_f32(&mut data, 79, 51.0);
    put_f32(&mut data, 80, 52.0);
    put_f32(&mut data, 81, 68.0);
    put_f32(&mut data, 82, 69.0);
    put_f32(&mut data, 83, 70.0);
    put_f32(&mut data, 84, 56.0);
    put_f32(&mut data, 85, 72.0);
    put_f32(&mut data, 86, 73.0);
    put_f32(&mut data, 87, 74.0);
    put_f32(&mut data, 88, 60.0);
    put_f32(&mut data, 89, 76.0);
    put_f32(&mut data, 90, 77.0);
    put_f32(&mut data, 91, 78.0);
    put_f32(&mut data, 92, 64.0);
    put_f32(&mut data, 93, 80.0);
    put_f32(&mut data, 94, 81.0);
    put_f32(&mut data, 95, 82.0);
    (
        data,
        "\nlayout(std140, binding = 0) buffer Input {\n  float data0[2];\n  float data1[3];\n  vec2 data2;\n  vec2 data3;\n  mat2 data4[2];\n  mat3 data5[2];\n  mat4 data6[2];\n} g_input;\nlayout(std140, binding = 1) buffer Output {\n  float data0[2];\n  float data1[3];\n  vec2 data2;\n  vec2 data3;\n  mat2 data4[2];\n  mat3 data5[2];\n  mat4 data6[2];\n} g_output;\nvoid main() {\n  for (int i = 0; i < g_input.data0.length(); ++i) g_output.data0[i] = g_input.data0[i];\n  for (int i = 0; i < g_input.data1.length(); ++i) g_output.data1[i] = g_input.data1[i];\n  g_output.data2 = g_input.data2;\n  g_output.data3 = g_input.data3;\n  for (int i = 0; i < g_input.data4.length(); ++i) g_output.data4[i] = g_input.data4[i];\n  for (int i = 0; i < g_input.data5.length(); ++i) g_output.data5[i] = g_input.data5[i];\n  for (int i = 0; i < g_input.data6.length(); ++i) g_output.data6[i] = g_input.data6[i];\n}",
    )
}

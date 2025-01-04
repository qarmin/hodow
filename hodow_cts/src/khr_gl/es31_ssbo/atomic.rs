// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Shader sources are the upstream literals (expanded from the C++ by hodow_cts/scripts/expand_cxx_literals.py); the vertex buffer and vertex array setup that every case repeats is `init_point_vertex_state`.

use super::super::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};
use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLint, GLuint};

const ATOMIC_UNIFORMS: [GLuint; 8] = [3, 1, 2, 1, 3, 1, 2, 7];

fn set_atomic_uniforms(gl: &glw::Functions, program: GLuint) {
    gl!(gl.uniform_1uiv(
        uniform_location(gl, program, "g_uint_value[0]"),
        8,
        ATOMIC_UNIFORMS.as_ptr()
    ));
}

/// Reads `count` values from the bound buffer and compares them with `expected(i)`; `what` is "uData" or "iData".
fn check_all_equal<T: Copy + std::fmt::Display + PartialEq>(
    gl: &glw::Functions,
    what: &str,
    offset: isize,
    count: usize,
    expected: impl Fn(usize) -> T,
) -> bool {
    let Some(data) = map_read::<T>(gl, offset, count) else {
        return false;
    };
    for (i, value) in data.iter().enumerate() {
        if *value != expected(i) {
            log::info!("{what} at index {i} is {value} should be {}", expected(i));
            return false;
        }
    }
    unmap(gl);
    true
}

/// 1.8.1 BasicAtomicCase1VSFS
#[derive(Default)]
pub(super) struct BasicAtomicCase1Vsfs {
    program: GLuint,
    storage_buffer: [GLuint; 4],
    vertex_array: GLuint,
    vertex_buffer: GLuint,
}

impl Subcase for BasicAtomicCase1Vsfs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 2, 2) {
            return Ok(NOT_SUPPORTED);
        }
        let glsl_vs = "\nlayout(location = 0) in vec4 g_in_position;\nlayout(std430, binding = 0) coherent buffer VSuint {\n  uint g_uint_out[4];\n};\nlayout(std430, binding = 1) coherent buffer VSint {\n  int data[4];\n} g_int_out;\nuniform uint g_uint_value[8];\nflat out int vertexid;\nvoid main() {\n  gl_Position = g_in_position;\n  vertexid = gl_VertexID;\n#ifdef GL_ES\n  gl_PointSize = 1.0f;\n#endif\n\n  // 0 is the initial value of g_uint_out while 7 is the value at the end shader execution.\n  // Since vertex shader can be executed multiple times due to implementation dependent reasons,\n  // initial validation should consider both value as possibility.\n  uint ret = atomicExchange(g_uint_out[gl_VertexID], g_uint_value[1]);\n  if ((ret != 0u) && (ret != 7u)) return;\n  if (atomicAdd(g_uint_out[gl_VertexID], g_uint_value[2]) != 1u) return;\n  if (atomicMin(g_uint_out[gl_VertexID], g_uint_value[1]) != 3u) return;\n  if (atomicMax(g_uint_out[gl_VertexID], g_uint_value[2]) != 1u) return;\n  if (atomicAnd(g_uint_out[gl_VertexID], g_uint_value[3]) != 2u) return;\n  if (atomicOr(g_uint_out[gl_VertexID], g_uint_value[4]) != 0u) return;\n  if (g_uint_value[0] > 0u) {\n    if (atomicXor(g_uint_out[gl_VertexID], g_uint_value[5]) != 3u) return;\n  }\n  if (atomicCompSwap(g_uint_out[gl_VertexID], g_uint_value[6], g_uint_value[7]) != 2u) {\n    g_uint_out[gl_VertexID] = 1u;\n    return;\n  }\n\n  int ret2 = atomicExchange(g_int_out.data[gl_VertexID], 1);\n  if ((ret2 != 0) && (ret2 != 7)) return;\n  if (atomicAdd(g_int_out.data[gl_VertexID], 2) != 1) return;\n  if (atomicMin(g_int_out.data[gl_VertexID], 1) != 3) return;\n  if (atomicMax(g_int_out.data[gl_VertexID], 2) != 1) return;\n  if (atomicAnd(g_int_out.data[gl_VertexID], 0x1) != 2) return;\n  if (atomicOr(g_int_out.data[gl_VertexID], 0x3) != 0) return;\n  if (atomicXor(g_int_out.data[gl_VertexID], 0x1) != 3) return;\n  if (atomicCompSwap(g_int_out.data[gl_VertexID], 0x2, 0x7) != 2) {\n    g_int_out.data[gl_VertexID] = 1;\n    return;\n  }\n}";
        let glsl_fs = "\nflat in int vertexid;\nlayout(location = 0) out vec4 g_fs_out;\nlayout(std430, binding = 2) coherent buffer FSuint {\n  uint data[4];\n} g_uint_fs;\nlayout(std430, binding = 3) coherent buffer FSint {\n  int data[4];\n} g_int_fs;\nuniform uint g_uint_value[8];\nvoid main() {\n  g_fs_out = vec4(0, 1, 0, 1);\n\n  if (atomicExchange(g_uint_fs.data[vertexid], g_uint_value[1]) != 0u) return;\n  if (atomicAdd(g_uint_fs.data[vertexid], g_uint_value[2]) != 1u) return;\n  if (atomicMin(g_uint_fs.data[vertexid], g_uint_value[1]) != 3u) return;\n  if (atomicMax(g_uint_fs.data[vertexid], g_uint_value[2]) != 1u) return;\n  if (atomicAnd(g_uint_fs.data[vertexid], g_uint_value[3]) != 2u) return;\n  if (atomicOr(g_uint_fs.data[vertexid], g_uint_value[4]) != 0u) return;\n  if (g_uint_value[0] > 0u) {\n    if (atomicXor(g_uint_fs.data[vertexid], g_uint_value[5]) != 3u) return;\n  }\n  if (atomicCompSwap(g_uint_fs.data[vertexid], g_uint_value[6], g_uint_value[7]) != 2u) {\n    g_uint_fs.data[vertexid] = 1u;\n    return;\n  }\n\n  if (atomicExchange(g_int_fs.data[vertexid], 1) != 0) return;\n  if (atomicAdd(g_int_fs.data[vertexid], 2) != 1) return;\n  if (atomicMin(g_int_fs.data[vertexid], 1) != 3) return;\n  if (atomicMax(g_int_fs.data[vertexid], 2) != 1) return;\n  if (atomicAnd(g_int_fs.data[vertexid], 0x1) != 2) return;\n  if (atomicOr(g_int_fs.data[vertexid], 0x3) != 0) return;\n  if (atomicXor(g_int_fs.data[vertexid], 0x1) != 3) return;\n  if (atomicCompSwap(g_int_fs.data[vertexid], 0x2, 0x7) != 2) {\n    g_int_fs.data[vertexid] = 1;\n    return;\n  }\n}";
        self.program = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(4, self.storage_buffer.as_mut_ptr()));
        for i in 0..4 {
            let data = [0 as GLint; 4];
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i, self.storage_buffer[i as usize]));
            ssbo_data(gl, &data, glw::GL_DYNAMIC_DRAW);
        }

        init_point_vertex_state(gl, &mut self.vertex_buffer, &mut self.vertex_array);

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program));
        set_atomic_uniforms(gl, self.program);

        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        for ii in 0..2 {
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[ii * 2]));
            if !check_all_equal::<GLuint>(gl, "uData", 0, 4, |_| 7) {
                return Ok(ERROR);
            }
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[ii * 2 + 1]));
            if !check_all_equal::<GLint>(gl, "iData", 0, 4, |_| 7) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(4, self.storage_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.vertex_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.8.1 BasicAtomicCase1CS
#[derive(Default)]
pub(super) struct BasicAtomicCase1Cs {
    program: GLuint,
    storage_buffer: [GLuint; 2],
}

impl Subcase for BasicAtomicCase1Cs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 4) in;\nlayout(std430, binding = 2) coherent buffer FSuint {\n  uint data[4];\n} g_uint_fs;\nlayout(std430, binding = 3) coherent buffer FSint {\n  int data[4];\n} g_int_fs;\nuniform uint g_uint_value[8];\nvoid main() {\n  if (atomicExchange(g_uint_fs.data[gl_LocalInvocationIndex], g_uint_value[1]) != 0u) return;\n  if (atomicAdd(g_uint_fs.data[gl_LocalInvocationIndex], g_uint_value[2]) != 1u) return;\n  if (atomicMin(g_uint_fs.data[gl_LocalInvocationIndex], g_uint_value[1]) != 3u) return;\n  if (atomicMax(g_uint_fs.data[gl_LocalInvocationIndex], g_uint_value[2]) != 1u) return;\n  if (atomicAnd(g_uint_fs.data[gl_LocalInvocationIndex], g_uint_value[3]) != 2u) return;\n  if (atomicOr(g_uint_fs.data[gl_LocalInvocationIndex], g_uint_value[4]) != 0u) return;\n  if (g_uint_value[0] > 0u) {\n    if (atomicXor(g_uint_fs.data[gl_LocalInvocationIndex], g_uint_value[5]) != 3u) return;\n  }\n  if (atomicCompSwap(g_uint_fs.data[gl_LocalInvocationIndex], g_uint_value[6], g_uint_value[7]) != 2u) {\n    g_uint_fs.data[gl_LocalInvocationIndex] = 1u;\n    return;\n  }\n  if (atomicExchange(g_int_fs.data[gl_LocalInvocationIndex], 1) != 0) return;\n  if (atomicAdd(g_int_fs.data[gl_LocalInvocationIndex], 2) != 1) return;\n  if (atomicMin(g_int_fs.data[gl_LocalInvocationIndex], 1) != 3) return;\n  if (atomicMax(g_int_fs.data[gl_LocalInvocationIndex], 2) != 1) return;\n  if (atomicAnd(g_int_fs.data[gl_LocalInvocationIndex], 0x1) != 2) return;\n  if (atomicOr(g_int_fs.data[gl_LocalInvocationIndex], 0x3) != 0) return;\n  if (atomicXor(g_int_fs.data[gl_LocalInvocationIndex], 0x1) != 3) return;\n  if (atomicCompSwap(g_int_fs.data[gl_LocalInvocationIndex], 0x2, 0x7) != 2) {\n    g_int_fs.data[gl_LocalInvocationIndex] = 1;\n    return;\n  }\n}";
        self.program = create_program_cs(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.storage_buffer.as_mut_ptr()));
        for i in 0..2 {
            let data = [0 as GLint; 4];
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i + 2, self.storage_buffer[i as usize]));
            ssbo_data(gl, &data, glw::GL_DYNAMIC_DRAW);
        }

        gl!(gl.use_program(self.program));
        set_atomic_uniforms(gl, self.program);
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[0]));
        if !check_all_equal::<GLuint>(gl, "uData", 0, 4, |_| 7) {
            return Ok(ERROR);
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[1]));
        if !check_all_equal::<GLint>(gl, "iData", 0, 4, |_| 7) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.storage_buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// The storage buffer of the Case3 programs: eight ivec4 holding (0, 1, 2, 0).
fn init_case3_storage_buffer(gl: &glw::Functions, storage_buffer: &mut GLuint) -> bool {
    gl!(gl.gen_buffers(1, storage_buffer));
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, *storage_buffer));
    ssbo_alloc(gl, 8 * 4 * 4, glw::GL_DYNAMIC_DRAW);
    let values: Vec<GLint> = (0..8).flat_map(|_| [0, 1, 2, 0]).collect();
    if !write_mapped(gl, 0, &values) {
        return false;
    }
    unmap(gl);
    true
}

/// 1.8.3 BasicAtomicCase3VSFS
#[derive(Default)]
pub(super) struct BasicAtomicCase3Vsfs {
    program: GLuint,
    storage_buffer: GLuint,
    vertex_array: GLuint,
    vertex_buffer: GLuint,
}

impl Subcase for BasicAtomicCase3Vsfs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 1, 1) {
            return Ok(NOT_SUPPORTED);
        }
        let glsl_vs = "\nlayout(location = 0) in vec4 g_in_position;\nlayout(std430, binding = 0) coherent buffer Buffer {\n  uvec4 u[4];\n  ivec3 i[4];\n} g_vs_buffer;\nflat out int vertexid;\nvoid main() {\n  vertexid = gl_VertexID;\n  gl_Position = g_in_position;\n#ifdef GL_ES\n  gl_PointSize = 1.0f;\n#endif\n  atomicAdd(g_vs_buffer.u[0].x, g_vs_buffer.u[gl_VertexID][1]);\n  atomicAdd(g_vs_buffer.u[0][0], g_vs_buffer.u[gl_VertexID].z);\n  atomicAdd(g_vs_buffer.i[0].x, g_vs_buffer.i[gl_VertexID][1]);\n  atomicAdd(g_vs_buffer.i[0][0], g_vs_buffer.i[gl_VertexID].z);\n}";
        let glsl_fs = "\nlayout(location = 0) out vec4 g_fs_out;\nlayout(std430, binding = 0) coherent buffer Buffer {\n  uvec4 u[4];\n  ivec3 i[4];\n} g_fs_buffer;\nflat in int vertexid;\nvoid main() {\n  g_fs_out = vec4(0, 1, 0, 1);\n  atomicAdd(g_fs_buffer.u[0].x, g_fs_buffer.u[vertexid][1]);\n  atomicAdd(g_fs_buffer.i[0].x, g_fs_buffer.i[vertexid][1]);\n}";
        self.program = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        if !init_case3_storage_buffer(gl, &mut self.storage_buffer) {
            return Ok(ERROR);
        }
        init_point_vertex_state(gl, &mut self.vertex_buffer, &mut self.vertex_array);

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(u) = map_read::<GLuint>(gl, 0, 1) else {
            return Ok(ERROR);
        };
        let u = u[0];
        // g_vs_buffer.u updated in VS which can be invoked multiple times per vertex
        if u < 16 {
            log::info!("Data at offset 0 is {u} should be at least 16.");
            return Ok(ERROR);
        }
        unmap(gl);
        let Some(i) = map_read::<GLint>(gl, 64, 1) else {
            return Ok(ERROR);
        };
        let i = i[0];
        // g_vs_buffer.i updated in VS which can be invoked multiple times per vertex
        if i < 16 {
            log::info!("Data at offset 0 is {i} should be at least 16.");
            return Ok(ERROR);
        }
        // g_vs_buffer.u should be equivalent to g_vs_buffer.i
        if u != i as GLuint {
            log::info!("uvec data {u}and ivec data {i}should match");
            return Ok(ERROR);
        }
        unmap(gl);

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.vertex_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.8.3 BasicAtomicCase3CS
#[derive(Default)]
pub(super) struct BasicAtomicCase3Cs {
    program: GLuint,
    storage_buffer: GLuint,
}

impl Subcase for BasicAtomicCase3Cs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_y = 4) in;\nlayout(std430) coherent buffer Buffer {\n  uvec4 u[4];\n  ivec3 i[4];\n} g_fs_buffer;\nvoid main() {\n  atomicAdd(g_fs_buffer.u[0].x, g_fs_buffer.u[gl_LocalInvocationID.y][2]);\n  atomicAdd(g_fs_buffer.i[0].x, 2 * g_fs_buffer.i[gl_LocalInvocationID.y][1]);\n  atomicAdd(g_fs_buffer.u[0].x, g_fs_buffer.u[gl_LocalInvocationID.y].z);\n  atomicAdd(g_fs_buffer.i[0].x, 2 * g_fs_buffer.i[gl_LocalInvocationID.y].y);\n}";
        self.program = create_program_cs(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        if !init_case3_storage_buffer(gl, &mut self.storage_buffer) {
            return Ok(ERROR);
        }

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(u) = map_read::<GLuint>(gl, 0, 1) else {
            return Ok(ERROR);
        };
        if u[0] != 16 {
            log::info!("Data at offset 0 is {} should be 16.", u[0]);
            return Ok(ERROR);
        }
        unmap(gl);
        let Some(i) = map_read::<GLint>(gl, 64, 1) else {
            return Ok(ERROR);
        };
        if i[0] != 16 {
            log::info!("Data at offset 0 is {} should be 16.", i[0]);
            return Ok(ERROR);
        }
        unmap(gl);

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// The counter buffer of the Case4 programs: (0, 7).
fn init_case4_counter_buffer(gl: &glw::Functions, buffer: GLuint) -> bool {
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer));
    ssbo_alloc(gl, 2 * 4, glw::GL_DYNAMIC_DRAW);
    if !write_mapped(gl, 0, &[0 as GLint, 7]) {
        return false;
    }
    unmap(gl);
    true
}

/// 1.8.4 BasicAtomicCase4VSFS
#[derive(Default)]
pub(super) struct BasicAtomicCase4Vsfs {
    program: GLuint,
    storage_buffer: [GLuint; 3],
    vertex_array: GLuint,
    vertex_buffer: GLuint,
}

impl Subcase for BasicAtomicCase4Vsfs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 2, 2) {
            return Ok(NOT_SUPPORTED);
        }
        let glsl_vs = "\nlayout(location = 0) in vec4 g_in_position;\nlayout(std430, binding = 0) coherent buffer Counters {\n  uint g_uint_counter;\n  int g_int_counter;\n};\nlayout(std430, binding = 1) buffer OutputU {\n  uint udata[8];\n} g_outputU;\nlayout(std430, binding = 2) buffer OutputI {\n  int idata[8];\n} g_outputI;\nvoid main() {\n  gl_Position = g_in_position;\n#ifdef GL_ES\n  gl_PointSize = 1.0f;\n#endif\n  uint uidx = atomicAdd(g_uint_counter, 1u);\n  int iidx = atomicAdd(g_int_counter, -1);\n  g_outputU.udata[uidx] = uidx;\n  g_outputI.idata[iidx] = iidx;\n}";
        let glsl_fs = "\nlayout(location = 0) out vec4 g_fs_out;\nlayout(std430, binding = 0) coherent buffer Counters {\n  uint g_uint_counter;\n  int g_int_counter;\n};\nlayout(std430, binding = 1) buffer OutputU {\n  uint udata[8];\n} g_outputU;\nlayout(std430, binding = 2) buffer OutputI {\n  int idata[8];\n} g_outputI;\nvoid main() {\n  g_fs_out = vec4(0, 1, 0, 1);\n  uint uidx = atomicAdd(g_uint_counter, 1u);\n  int iidx = atomicAdd(g_int_counter, -1);\n  g_outputU.udata[uidx] = uidx;\n  g_outputI.idata[iidx] = iidx;\n}";
        self.program = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(3, self.storage_buffer.as_mut_ptr()));
        // counter buffer
        if !init_case4_counter_buffer(gl, self.storage_buffer[0]) {
            return Ok(ERROR);
        }
        // output buffers
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer[1]));
        ssbo_alloc(gl, 8 * 4, glw::GL_DYNAMIC_DRAW);
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 2, self.storage_buffer[2]));
        ssbo_alloc(gl, 8 * 4, glw::GL_DYNAMIC_DRAW);

        init_point_vertex_state(gl, &mut self.vertex_buffer, &mut self.vertex_array);

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[1]));
        if !check_all_equal::<GLuint>(gl, "uData", 0, 8, |i| i as GLuint) {
            return Ok(ERROR);
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[2]));
        if !check_all_equal::<GLint>(gl, "iData", 0, 8, |i| i as GLint) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(3, self.storage_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.vertex_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.8.4 BasicAtomicCase4CS
#[derive(Default)]
pub(super) struct BasicAtomicCase4Cs {
    program: GLuint,
    storage_buffer: [GLuint; 2],
}

impl Subcase for BasicAtomicCase4Cs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 2, local_size_y = 2, local_size_z = 2) in;\nlayout(std430, binding = 0) coherent buffer Counters {\n  uint g_uint_counter;\n  int g_int_counter;\n};\nlayout(std430, binding = 1) buffer Output {\n  uint udata[8];\n  int idata[8];\n} g_output;\nvoid main() {\n  uint uidx = atomicAdd(g_uint_counter, 1u);\n  int iidx = atomicAdd(g_int_counter, -1);\n  g_output.udata[uidx] = uidx;\n  g_output.idata[iidx] = iidx;\n}";
        self.program = create_program_cs(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.storage_buffer.as_mut_ptr()));
        // counter buffer
        if !init_case4_counter_buffer(gl, self.storage_buffer[0]) {
            return Ok(ERROR);
        }
        // output buffer
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer[1]));
        ssbo_alloc(gl, 16 * 4, glw::GL_DYNAMIC_DRAW);

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        if !check_all_equal::<GLuint>(gl, "uData", 0, 8, |i| i as GLuint) {
            return Ok(ERROR);
        }
        if !check_all_equal::<GLint>(gl, "iData", 32, 8, |i| i as GLint) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.storage_buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

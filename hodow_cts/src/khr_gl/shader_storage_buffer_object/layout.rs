// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderStorageBufferObjectTests.cpp  (BasicStdLayoutBaseVS/CS, BasicStd430LayoutCase*, BasicStd140LayoutCase*)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader sources and the buffer contents of the `GetInput430c*`/`GetInput140c*` functions are the ones the ES port (`es31_ssbo/layout.rs`) already holds - the desktop file differs from the ES one only in the length of the buffer for six of them (`min_len`, the extra bytes are zero as in upstream, where `resize` zero-fills) and in the missing fragment shader of the vertex stage. Written without compiling.

use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLuint};
use crate::khr_gl::es31_ssbo::layout::{GetInput, compare_bytes};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};

fn padded(get_input: GetInput, min_len: usize) -> (Vec<u8>, &'static str) {
    let (mut data, body) = get_input();
    if data.len() < min_len {
        data.resize(min_len, 0);
    }
    (data, body)
}

/// 1.6.x BasicStdLayoutBaseVS
pub(super) struct BasicStdLayoutBaseVs {
    get_input: GetInput,
    min_len: usize,
    program: GLuint,
    buffer: [GLuint; 2],
    vertex_array: GLuint,
}

impl BasicStdLayoutBaseVs {
    pub(super) fn new(get_input: GetInput, min_len: usize) -> Self {
        Self {
            get_input,
            min_len,
            program: 0,
            buffer: [0; 2],
            vertex_array: 0,
        }
    }
}

impl Subcase for BasicStdLayoutBaseVs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 2) {
            return Ok(NOT_SUPPORTED);
        }
        let (in_data, glsl_vs) = padded(self.get_input, self.min_len);

        self.program = create_program(gl, glsl_vs, "");
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));

        // output buffer
        let out_data = vec![0u8; in_data.len()];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.buffer[1]));
        ssbo_data(gl, &out_data, glw::GL_STATIC_DRAW);

        // input buffer
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer[0]));
        ssbo_data(gl, &in_data, glw::GL_STATIC_DRAW);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[1]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let mut out_data = vec![0u8; in_data.len()];
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            in_data.len() as isize,
            out_data.as_mut_ptr().cast()
        ));

        Ok(if compare_bytes(&in_data, &out_data) {
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

/// 1.6.x BasicStdLayoutBaseCS
pub(super) struct BasicStdLayoutBaseCs {
    get_input: GetInput,
    min_len: usize,
    program: GLuint,
    buffer: [GLuint; 2],
}

impl BasicStdLayoutBaseCs {
    pub(super) fn new(get_input: GetInput, min_len: usize) -> Self {
        Self {
            get_input,
            min_len,
            program: 0,
            buffer: [0; 2],
        }
    }
}

impl Subcase for BasicStdLayoutBaseCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (in_data, body) = padded(self.get_input, self.min_len);
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

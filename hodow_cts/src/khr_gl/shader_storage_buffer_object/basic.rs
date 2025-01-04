// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Shader sources are the upstream literals (`NL` is `\n`); each case class is a `Subcase` whose `Default` state is what `Setup` zeroes. Written without compiling.

use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLint64, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};

/// 1.1 BasicBasic
#[derive(Default)]
pub(super) struct BasicBasic {
    program: GLuint,
    buffer: GLuint,
    vertex_array: GLuint,
}

impl BasicBasic {
    fn run_iteration(&self, context: &Context, index: GLuint) -> bool {
        let gl = context.gl();
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.shader_storage_block_binding(self.program, 0, index));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, index, self.buffer));
        gl!(gl.draw_arrays_instanced_base_instance(glw::GL_TRIANGLES, 0, 3, 1, 0));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, index, 0));

        validate_window(context, [0.0, 1.0, 0.0])
    }
}

impl Subcase for BasicBasic {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 1) {
            return Ok(NOT_SUPPORTED);
        }

        let glsl_vs = "\nlayout(std430, binding = 1) buffer InputBuffer {\n  vec4 position[3];\n} g_input_buffer;\nvoid main() {\n  gl_Position = g_input_buffer.position[gl_VertexID];\n}";

        self.program = create_program(gl, glsl_vs, FS_GREEN);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer));
        ssbo_data(gl, &TRIANGLE_POSITIONS, glw::GL_STATIC_DRAW);
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));

        gl!(gl.use_program(self.program));

        for i in 0..8 {
            if !self.run_iteration(context, i) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.1 BasicBasicCS
#[derive(Default)]
pub(super) struct BasicBasicCs {
    program: GLuint,
    buffer: GLuint,
}

impl Subcase for BasicBasicCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs =
            "\nlayout(local_size_x = 1) in;\nbuffer Buffer {\n  int result;\n};\nvoid main() {\n  result = 7;\n}";
        self.program = create_program_cs(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer));
        ssbo_alloc(gl, 4, glw::GL_STATIC_READ);
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(out_data) = map_read::<GLint>(gl, 0, 1) else {
            return Ok(ERROR);
        };
        Ok(if out_data[0] == 7 { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// 1.2 BasicMax
#[derive(Default)]
pub(super) struct BasicMax;

impl BasicMax {
    fn check(gl: &glw::Functions, e: GLenum, value: GLint64, max_value: bool) -> bool {
        let i = get_integer(gl, e);
        let mut i64_value: GLint64 = 0;
        gl!(gl.get_integer_64v(e, &mut i64_value));
        let mut f: f32 = 0.0;
        gl!(gl.get_floatv(e, &mut f));
        let mut d: f64 = 0.0;
        gl!(gl.get_doublev(e, &mut d));
        let mut b: glw::GLboolean = 0;
        gl!(gl.get_booleanv(e, &mut b));

        let status = if max_value {
            !((i as GLint64) < value || i64_value < value || (f as GLint64) < value || (d as GLint64) < value)
        } else {
            !((i as GLint64) > value || i64_value > value || (f as GLint64) > value || (d as GLint64) > value)
        };
        if !status {
            log::info!(
                "{} is {} should be at {} {}",
                glenum_to_string(e),
                i,
                if max_value { "least" } else { "most" },
                value as GLint
            );
        }
        status
    }
}

impl Subcase for BasicMax {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let checks: [(GLenum, GLint64, bool); 11] = [
            (glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS, 0, true),
            (glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS, 0, true),
            (glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS, 0, true),
            (glw::GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS, 0, true),
            (glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS, 8, true),
            (glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS, 8, true),
            (glw::GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS, 8, true),
            (glw::GL_MAX_SHADER_STORAGE_BLOCK_SIZE, 16777216, true),
            (glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS, 8, true),
            (glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES, 8, true),
            (glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT, 256, false),
        ];
        for (e, value, max_value) in checks {
            if !Self::check(gl, e, value, max_value) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

/// 1.3 BasicBinding
#[derive(Default)]
pub(super) struct BasicBinding {
    buffer: [GLuint; 4],
}

impl BasicBinding {
    fn check(gl: &glw::Functions, e: GLenum, expected: GLuint) -> bool {
        let i = get_integer(gl, e);
        let mut i64_value: GLint64 = 0;
        gl!(gl.get_integer_64v(e, &mut i64_value));
        let mut f: f32 = 0.0;
        gl!(gl.get_floatv(e, &mut f));
        let mut d: f64 = 0.0;
        gl!(gl.get_doublev(e, &mut d));
        let mut b: glw::GLboolean = 0;
        gl!(gl.get_booleanv(e, &mut b));

        let status = i as GLuint == expected
            && i64_value as GLuint == expected
            && f as GLuint == expected
            && d as GLuint == expected
            && b == if expected != 0 { glw::TRUE } else { glw::FALSE };
        if !status {
            log::info!("{} is {} should be {}", glenum_to_string(e), i, expected);
        }
        status
    }

    fn check_indexed(gl: &glw::Functions, e: GLenum, index: GLuint, expected: GLuint) -> bool {
        let mut i: GLint = 0;
        gl!(gl.get_integeri_v(e, index, &mut i));
        let mut i64_value: GLint64 = 0;
        gl!(gl.get_integer_64i_v(e, index, &mut i64_value));
        let mut f: f32 = 0.0;
        gl!(gl.get_floati_v(e, index, &mut f));
        let mut d: f64 = 0.0;
        gl!(gl.get_doublei_v(e, index, &mut d));
        let mut b: glw::GLboolean = 0;
        gl!(gl.get_booleani_v(e, index, &mut b));

        let status = i as GLuint == expected
            && i64_value as GLuint == expected
            && f as GLuint == expected
            && d as GLuint == expected
            && b == if expected != 0 { glw::TRUE } else { glw::FALSE };
        if !status {
            log::info!(
                "{} at index {} is {} should be {}",
                glenum_to_string(e),
                index,
                i,
                expected
            );
        }
        status
    }

    /// The four checks upstream repeats after every bind: the generic binding, then binding, start and size of `index`.
    fn check_all(gl: &glw::Functions, index: GLuint, buffer: GLuint, start: GLuint, size: GLuint) -> bool {
        Self::check(gl, glw::GL_SHADER_STORAGE_BUFFER_BINDING, buffer)
            && Self::check_indexed(gl, glw::GL_SHADER_STORAGE_BUFFER_BINDING, index, buffer)
            && Self::check_indexed(gl, glw::GL_SHADER_STORAGE_BUFFER_START, index, start)
            && Self::check_indexed(gl, glw::GL_SHADER_STORAGE_BUFFER_SIZE, index, size)
    }
}

impl Subcase for BasicBinding {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();

        // check default state
        if !Self::check(gl, glw::GL_SHADER_STORAGE_BUFFER_BINDING, 0) {
            return Ok(ERROR);
        }
        for i in 0..8 {
            if !Self::check_indexed(gl, glw::GL_SHADER_STORAGE_BUFFER_BINDING, i, 0)
                || !Self::check_indexed(gl, glw::GL_SHADER_STORAGE_BUFFER_START, i, 0)
                || !Self::check_indexed(gl, glw::GL_SHADER_STORAGE_BUFFER_SIZE, i, 0)
            {
                return Ok(ERROR);
            }
        }

        gl!(gl.gen_buffers(4, self.buffer.as_mut_ptr()));
        for i in 0..8 {
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i, self.buffer[0]));
            if !Self::check_all(gl, i, self.buffer[0], 0, 0) {
                return Ok(ERROR);
            }

            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i, 0));
            if !Self::check_all(gl, i, 0, 0, 0) {
                return Ok(ERROR);
            }
        }

        for i in 0..8 {
            gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, i, self.buffer[0], 256, 512));
            if !Self::check_all(gl, i, self.buffer[0], 256, 512) {
                return Ok(ERROR);
            }

            gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, i, 0, 512, 128));
            if !Self::check_all(gl, i, 0, 0, 0) {
                return Ok(ERROR);
            }

            gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, i, 0, 0, 0));
            if !Self::check_all(gl, i, 0, 0, 0) {
                return Ok(ERROR);
            }
        }

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer[2]));
        if !Self::check_all(gl, 0, self.buffer[2], 0, 0) {
            return Ok(ERROR);
        }

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 5, self.buffer[3]));
        if !Self::check_all(gl, 5, self.buffer[3], 0, 0) {
            return Ok(ERROR);
        }

        gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 7, self.buffer[1], 2048, 1000));
        if !Self::check_all(gl, 7, self.buffer[1], 2048, 1000) {
            return Ok(ERROR);
        }

        gl!(gl.delete_buffers(4, self.buffer.as_ptr()));
        self.buffer = [0; 4];

        if !Self::check(gl, glw::GL_SHADER_STORAGE_BUFFER_BINDING, 0) {
            return Ok(ERROR);
        }
        for i in 0..8 {
            if !Self::check_indexed(gl, glw::GL_SHADER_STORAGE_BUFFER_BINDING, i, 0) {
                return Ok(ERROR);
            }
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(4, self.buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// 1.4 BasicSyntax
#[derive(Default)]
pub(super) struct BasicSyntax {
    program: GLuint,
    buffer: GLuint,
    vertex_array: GLuint,
}

impl BasicSyntax {
    fn run_iteration(&mut self, context: &Context, vs: &str, fs: &str) -> bool {
        let gl = context.gl();
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_program(gl, vs, fs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program));
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));

        validate_window(context, [0.0, 1.0, 0.0])
    }
}

impl Subcase for BasicSyntax {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 1) {
            return Ok(NOT_SUPPORTED);
        }

        let glsl_vs: [&str; 8] = [
            "\nlayout(std430) buffer Buffer {\n  vec4 position[3];\n} g_input_buffer;\nvoid main() {\n  gl_Position = g_input_buffer.position[gl_VertexID];\n}",
            "\ncoherent buffer Buffer {\n  buffer vec4 position0;\n  coherent vec4 position1;\n  restrict readonly vec4 position2;\n} g_input_buffer;\nvoid main() {\n  if (gl_VertexID == 0) gl_Position = g_input_buffer.position0;\n  if (gl_VertexID == 1) gl_Position = g_input_buffer.position1;\n  if (gl_VertexID == 2) gl_Position = g_input_buffer.position2;\n}",
            "\nlayout(std140, binding = 0) readonly buffer Buffer {\n  readonly vec4 position[];\n};\nvoid main() {\n  gl_Position = position[gl_VertexID];\n}",
            "\nlayout(std430, column_major, std140, std430, row_major, packed, shared) buffer;\nlayout(std430) buffer;\ncoherent restrict volatile buffer Buffer {\n  restrict coherent vec4 position[];\n} g_buffer;\nvoid main() {\n  gl_Position = g_buffer.position[gl_VertexID];\n}",
            "\nbuffer Buffer {\n  vec4 position[3];\n} g_buffer[1];\nvoid main() {\n  gl_Position = g_buffer[0].position[gl_VertexID];\n}",
            "\nlayout(shared) coherent buffer Buffer {\n  restrict volatile vec4 position0;\n  buffer readonly vec4 position1;\n  vec4 position2;\n} g_buffer[1];\nvoid main() {\n  if (gl_VertexID == 0) gl_Position = g_buffer[0].position0;\n  else if (gl_VertexID == 1) gl_Position = g_buffer[0].position1;\n  else if (gl_VertexID == 2) gl_Position = g_buffer[0].position2;\n}",
            "\nlayout(packed) coherent buffer Buffer {\n  vec4 position01[];\n  vec4 position2;\n} g_buffer;\nvoid main() {\n  if (gl_VertexID == 0) gl_Position = g_buffer.position01[0];\n  else if (gl_VertexID == 1) gl_Position = g_buffer.position01[1];\n  else if (gl_VertexID == 2) gl_Position = g_buffer.position2;\n}",
            "\nlayout(std430) coherent buffer Buffer {\n  coherent vec4 position01[];\n  vec4 position2[];\n} g_buffer;\nvoid main() {\n  switch (gl_VertexID) {\n    case 0: gl_Position = g_buffer.position01[0]; break;\n    case 1: gl_Position = g_buffer.position01[1]; break;\n    case 2: gl_Position = g_buffer.position2[gl_VertexID - 2]; break;\n  }\n}",
        ];

        // full viewport triangle
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        ssbo_data(gl, &TRIANGLE_POSITIONS, glw::GL_STATIC_DRAW);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));

        for vs in glsl_vs {
            if !self.run_iteration(context, vs, FS_GREEN) {
                return Ok(ERROR);
            }
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.5 BasicSyntaxSSO
#[derive(Default)]
pub(super) struct BasicSyntaxSso {
    pipeline: GLuint,
    vsp: GLuint,
    fsp: GLuint,
    buffer: GLuint,
    vertex_array: GLuint,
}

impl BasicSyntaxSso {
    fn run_iteration(&mut self, context: &Context, vs: &str) -> bool {
        let gl = context.gl();
        if self.vsp != 0 {
            gl!(gl.delete_program(self.vsp));
        }
        self.vsp = build_shader_program(gl, glw::GL_VERTEX_SHADER, vs);
        if !check_program(gl, self.vsp) {
            return false;
        }

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.vsp));
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));

        validate_window(context, [0.0, 1.0, 0.0])
    }
}

impl Subcase for BasicSyntaxSso {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 1) {
            return Ok(NOT_SUPPORTED);
        }

        let glsl_vs: [&str; 8] = [
            "\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nlayout(std430) buffer Buffer {\n  vec4 position[3];\n} g_input_buffer;\nvoid main() {\n  gl_Position = g_input_buffer.position[gl_VertexID];\n}",
            "\nout gl_PerVertex {\n  vec4 gl_Position;\n};\ncoherent buffer Buffer {\n  vec4 position0;\n  coherent vec4 position1;\n  restrict readonly vec4 position2;\n} g_input_buffer;\nvoid main() {\n  if (gl_VertexID == 0) gl_Position = g_input_buffer.position0;\n  if (gl_VertexID == 1) gl_Position = g_input_buffer.position1;\n  if (gl_VertexID == 2) gl_Position = g_input_buffer.position2;\n}",
            "\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nlayout(std140, binding = 0) readonly buffer Buffer {\n  readonly vec4 position[];\n};\nvoid main() {\n  gl_Position = position[gl_VertexID];\n}",
            "\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nlayout(std430, column_major, std140, std430, row_major, packed, shared) buffer;\nlayout(std430) buffer;\ncoherent restrict volatile buffer Buffer {\n  restrict coherent vec4 position[];\n} g_buffer;\nvoid main() {\n  gl_Position = g_buffer.position[gl_VertexID];\n}",
            "\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nbuffer Buffer {\n  vec4 position[3];\n} g_buffer[1];\nvoid main() {\n  gl_Position = g_buffer[0].position[gl_VertexID];\n}",
            "\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nlayout(shared) coherent buffer Buffer {\n  restrict volatile vec4 position0;\n  readonly vec4 position1;\n  vec4 position2;\n} g_buffer[1];\nvoid main() {\n  if (gl_VertexID == 0) gl_Position = g_buffer[0].position0;\n  else if (gl_VertexID == 1) gl_Position = g_buffer[0].position1;\n  else if (gl_VertexID == 2) gl_Position = g_buffer[0].position2;\n}",
            "\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nlayout(packed) coherent buffer Buffer {\n  vec4 position01[];\n  vec4 position2;\n} g_buffer;\nvoid main() {\n  if (gl_VertexID == 0) gl_Position = g_buffer.position01[0];\n  else if (gl_VertexID == 1) gl_Position = g_buffer.position01[1];\n  else if (gl_VertexID == 2) gl_Position = g_buffer.position2;\n}",
            "\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nlayout(std430) coherent buffer Buffer {\n  coherent vec4 position01[];\n  vec4 position2[];\n} g_buffer;\nvoid main() {\n  switch (gl_VertexID) {\n    case 0: gl_Position = g_buffer.position01[0]; break;\n    case 1: gl_Position = g_buffer.position01[1]; break;\n    case 2: gl_Position = g_buffer.position2[gl_VertexID - 2]; break;\n  }\n}",
        ];

        self.fsp = build_shader_program(gl, glw::GL_FRAGMENT_SHADER, FS_GREEN);
        if !check_program(gl, self.fsp) {
            return Ok(ERROR);
        }

        gl!(gl.gen_program_pipelines(1, &mut self.pipeline));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_FRAGMENT_SHADER_BIT, self.fsp));

        // full viewport triangle
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        ssbo_data(gl, &TRIANGLE_POSITIONS, glw::GL_STATIC_DRAW);

        gl!(gl.bind_program_pipeline(self.pipeline));

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));

        for vs in glsl_vs {
            if !self.run_iteration(context, vs) {
                return Ok(ERROR);
            }
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_program_pipelines(1, &self.pipeline));
        gl!(gl.delete_program(self.vsp));
        gl!(gl.delete_program(self.fsp));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// 1.13 BasicNoBindingLayout
#[derive(Default)]
pub(super) struct BasicNoBindingLayout {
    vsp: GLuint,
    ppo: GLuint,
    ssbo: GLuint,
    vao: GLuint,
}

impl Subcase for BasicNoBindingLayout {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.vsp = 0;
        gl!(gl.gen_program_pipelines(1, &mut self.ppo));
        gl!(gl.gen_buffers(1, &mut self.ssbo));
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.delete_program(self.vsp));
        gl!(gl.delete_program_pipelines(1, &self.ppo));
        gl!(gl.delete_buffers(1, &self.ssbo));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 3) {
            return Ok(NOT_SUPPORTED);
        }

        let glsl_vs = std::ffi::CString::new("#version 430 core\nlayout(std430) buffer Output0 { int data; } g_output0;\nlayout(std430) buffer Output1 { int g_output1; };\nlayout(std430) buffer Output2 { int data; } g_output2;\nvoid main() {\n  g_output0.data = 1;\n  g_output1 = 2;\n  g_output2.data = 3;\n}")
            .expect("no NUL");
        let source_pointer = glsl_vs.as_ptr();
        self.vsp = gl!(gl.create_shader_programv(glw::GL_VERTEX_SHADER, 1, &source_pointer));
        if !check_program(gl, self.vsp) {
            return Ok(ERROR);
        }
        gl!(gl.use_program_stages(self.ppo, glw::GL_VERTEX_SHADER_BIT, self.vsp));

        for (name, binding) in [("Output0", 1), ("Output1", 5), ("Output2", 7)] {
            let name = std::ffi::CString::new(name).expect("no NUL");
            let index = gl!(gl.get_program_resource_index(self.vsp, glw::GL_SHADER_STORAGE_BLOCK, name.as_ptr()));
            gl!(gl.shader_storage_block_binding(self.vsp, index, binding));
        }

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.ssbo));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            1024,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 1, self.ssbo, 0, 4));
        gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 5, self.ssbo, 256, 4));
        gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 7, self.ssbo, 512, 4));

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_program_pipeline(self.ppo));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        let mut data: GLint = 0;
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.ssbo));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        for (offset, expected) in [(0, 1), (256, 2), (512, 3)] {
            gl!(gl.get_buffer_sub_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                offset,
                4,
                (&mut data as *mut GLint).cast()
            ));
            if data != expected {
                return Ok(ERROR);
            }
        }

        Ok(NO_ERROR)
    }
}

/// 1.14 BasicReadonlyWriteonly
#[derive(Default)]
pub(super) struct BasicReadonlyWriteonly {
    program: GLuint,
    storage_buffer: [GLuint; 2],
}

impl Subcase for BasicReadonlyWriteonly {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1) in;\nlayout(std430, binding = 0) buffer Input {\n  readonly writeonly int g_in[];\n};\nlayout(std430, binding = 1) buffer Output {\n  int count;\n} g_output;\nvoid main() {\n  g_output.count = g_in.length();\n}";

        self.program = create_program_cs(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.storage_buffer.as_mut_ptr()));

        // Input
        let input_data: [GLint; 3] = [1, 2, 3];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer[0]));
        ssbo_data(gl, &input_data, glw::GL_STATIC_DRAW);

        // Output
        let output_data: [GLint; 1] = [0];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer[1]));
        ssbo_data(gl, &output_data, glw::GL_DYNAMIC_COPY);

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[1]));
        let Some(data) = map_read::<GLint>(gl, 0, 1) else {
            return Ok(ERROR);
        };
        if data[0] != input_data.len() as GLint {
            log::info!(
                "Buffer data is {} should be {}",
                data[0],
                std::mem::size_of_val(&input_data)
            );
            return Ok(ERROR);
        }
        unmap(gl);
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

/// 1.15 BasicNameMatch
#[derive(Default)]
pub(super) struct BasicNameMatch;

impl BasicNameMatch {
    fn link(gl: &glw::Functions, vs: &str, fs: &str) -> bool {
        let program = create_program(gl, vs, fs);
        gl!(gl.link_program(program));
        let mut status: GLint = 0;
        gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
        gl!(gl.delete_program(program));
        status == glw::GL_TRUE as GLint
    }
}

impl Subcase for BasicNameMatch {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let blocks_vs = get_integer(gl, glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS);
        let blocks_fs = get_integer(gl, glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS);
        if blocks_vs == 0 || blocks_fs == 0 {
            return Ok(NOT_SUPPORTED);
        }

        // check if link error is generated when one of matched blocks has instance name and other doesn't
        let vs1 = "buffer Buf { float x; };\nvoid main() {\n  gl_Position = vec4(x);\n}";
        let fs1 = "buffer Buf { float x; } b;\nout vec4 color;\nvoid main() {\n  color = vec4(b.x);\n}";
        if Self::link(gl, vs1, fs1) {
            log::info!("Linking should fail.");
            return Ok(ERROR);
        }

        // check if linking succeeds when both matched blocks are lacking an instance name
        let vs2 = "buffer Buf { float x; };\nvoid main() {\n  gl_Position = vec4(x);\n}";
        let fs2 = "buffer Buf { float x; };\nout vec4 color;\nvoid main() {\n  color = vec4(x);\n}";
        if !Self::link(gl, vs2, fs2) {
            log::info!("Linking should succeed.");
            return Ok(ERROR);
        }

        // check if linking succeeds when both matched blocks have different instance names
        let vs3 = "buffer Buf { float x; } a;\nvoid main() {\n  gl_Position = vec4(a.x);\n}";
        let fs3 = "buffer Buf { float x; } b;\nout vec4 color;\nvoid main() {\n  color = vec4(b.x);\n}";
        if !Self::link(gl, vs3, fs3) {
            log::info!("Linking should succeed.");
            return Ok(ERROR);
        }

        Ok(NO_ERROR)
    }
}

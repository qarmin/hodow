// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Shader sources and float tables are the upstream text (expanded by hodow_cts/scripts/expand_cxx_literals.py); the nineteen `Compile` calls of NegativeGLSLCompileTime are a list of sources compiled in order.

use super::super::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};
use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLint, GLuint};

/// 3.1 AdvancedMatrixVSFS
#[derive(Default)]
pub(super) struct AdvancedMatrixVsfs {
    program: GLuint,
    storage_buffer: [GLuint; 3],
    vertex_array: GLuint,
    vertex_buffer: GLuint,
    fbo: GLuint,
    rt: GLuint,
}

impl Subcase for AdvancedMatrixVsfs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_framebuffers(1, &mut self.fbo));
        gl!(gl.gen_textures(1, &mut self.rt));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 2, 2) {
            return Ok(NOT_SUPPORTED);
        }
        let glsl_vs = "\nlayout(location = 0) in vec4 g_position;\nflat out int instance_id;\nlayout(binding = 0, std430) coherent buffer Buffer0 {\n  mat3x4 g_transform[4];\n  mat4x3 g_color;\n  mat3 g_data0;\n};\nlayout(binding = 1, std430) readonly buffer Buffer1 {\n  mat4 color;\n} g_buffer1;\nuniform int g_index1;\nuniform int g_index2;\nvoid main() {\n  gl_Position = vec4(transpose(g_transform[gl_InstanceID]) * g_position, 1);\n  g_color[gl_InstanceID] = g_buffer1.color[gl_InstanceID].rgb;\n  if (gl_VertexID == 0 && gl_InstanceID == 0) {\n    g_data0[1][1] = 1.0;\n    g_data0[g_index1][g_index2] += 3.0;\n  }\n  memoryBarrier();\n  instance_id = gl_InstanceID;\n}";
        let glsl_fs = "\nflat in int instance_id;\nlayout(location = 0) out vec4 g_ocolor;\nlayout(binding = 0, std430) coherent buffer Buffer0 {\n  mat3x4 g_transform[4];\n  mat4x3 g_color;\n  mat3 g_data0;\n};\nuniform int g_index1;\nuniform int g_index2;\nvoid main() {\n  if (g_data0[g_index1][g_index1] != 1.0) g_ocolor = vec4(0);\n  else if (g_data0[g_index1][g_index2] != 3.0) g_ocolor = vec4(0);\n  else g_ocolor = vec4(g_color[instance_id], 1);\n}";
        self.program = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(3, self.storage_buffer.as_mut_ptr()));

        // transform buffer
        let mut data = [0.0f32; 48 + 16 + 12 + 16];
        let transforms: [f32; 48] = [
            1.0f32, 0.0f32, 0.0f32, -0.5f32, 0.0f32, 1.0f32, 0.0f32, -0.5f32, 0.0f32, 0.0f32, 1.0f32, 0.0f32, 1.0f32,
            0.0f32, 0.0f32, 0.5f32, 0.0f32, 1.0f32, 0.0f32, -0.5f32, 0.0f32, 0.0f32, 1.0f32, 0.0f32, 1.0f32, 0.0f32,
            0.0f32, 0.5f32, 0.0f32, 1.0f32, 0.0f32, 0.5f32, 0.0f32, 0.0f32, 1.0f32, 0.0f32, 1.0f32, 0.0f32, 0.0f32,
            -0.5f32, 0.0f32, 1.0f32, 0.0f32, 0.5f32, 0.0f32, 0.0f32, 1.0f32, 0.0f32,
        ];
        data[..48].copy_from_slice(&transforms);
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer[0]));
        ssbo_data(gl, &data, glw::GL_STATIC_DRAW);
        // transform buffer
        let data: [f32; 16] = [
            1.0f32, 0.0f32, 0.0f32, -0.5f32, 0.0f32, 1.0f32, 0.0f32, -0.5f32, 0.0f32, 0.0f32, 1.0f32, 0.0f32, 1.0f32,
            1.0f32, 0.0f32, 0.5f32,
        ];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer[1]));
        ssbo_data(gl, &data, glw::GL_STATIC_DRAW);
        // vertex buffer
        let data: [f32; 8] = [-0.4f32, -0.4f32, 0.4f32, -0.4f32, -0.4f32, 0.4f32, 0.4f32, 0.4f32];
        gl!(gl.gen_buffers(1, &mut self.vertex_buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
        buffer_data(gl, glw::GL_ARRAY_BUFFER, &data, glw::GL_STATIC_DRAW);
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        init_render_target(gl, self.rt, self.fbo);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
        gl!(gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.bind_vertex_array(0));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program));
        gl!(gl.uniform_1i(uniform_location(gl, self.program, "g_index1"), 1));
        gl!(gl.uniform_1i(uniform_location(gl, self.program, "g_index2"), 2));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays_instanced(glw::GL_TRIANGLE_STRIP, 0, 4, 4));
        if !validate_window_4_quads(
            context,
            [1.0, 0.0, 0.0],
            [0.0, 1.0, 0.0],
            [0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0],
            None,
        ) {
            return Ok(ERROR);
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        restore_viewport(context);
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(3, self.storage_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.vertex_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(1, &self.rt));
        Ok(NO_ERROR)
    }
}

/// 3.1 AdvancedMatrixCS
#[derive(Default)]
pub(super) struct AdvancedMatrixCs {
    program: GLuint,
    storage_buffer: GLuint,
}

impl Subcase for AdvancedMatrixCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut status = true;
        let glsl_cs = "\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Buffer {\n  mat4x3 dst4x3;\n  mat4 dst4;\n  mat4 src4;\n} b;\nuniform int g_index1;\nuniform int g_index2;\nvoid main() {\n  b.dst4x3[gl_LocalInvocationIndex] = b.src4[gl_LocalInvocationIndex].rgb;\n  b.dst4x3[gl_LocalInvocationIndex + 1u] = b.src4[gl_LocalInvocationIndex + 1u].aar;\n  b.dst4[g_index2][g_index1] = 17.0;\n  b.dst4[g_index2][g_index1] += 6.0;\n  b.dst4[3][0] = b.src4[3][0] != 44.0 ? 3.0 : 7.0;\n  b.dst4[3][1] = b.src4[3][1];\n}";
        self.program = create_program_cs(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        let mut data = [0.0f32; 16 + 16 + 16];
        for (i, value) in data.iter_mut().enumerate().skip(32) {
            *value = i as f32;
        }
        ssbo_data(gl, &data, glw::GL_DYNAMIC_DRAW);

        gl!(gl.use_program(self.program));
        gl!(gl.uniform_1i(uniform_location(gl, self.program, "g_index1"), 1));
        gl!(gl.uniform_1i(uniform_location(gl, self.program, "g_index2"), 2));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let Some(out_data) = map_read::<f32>(gl, 0, data.len()) else {
            return Ok(ERROR);
        };
        let expected: [f32; 32] = [
            32.0f32, 33.0f32, 34.0f32, 0.0f32, 39.0f32, 39.0f32, 36.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32,
            0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32, 0.0f32,
            23.0f32, 0.0f32, 0.0f32, 7.0f32, 45.0f32, 0.0f32, 0.0f32,
        ];
        for i in 0..32 {
            if out_data[i] != expected[i] {
                log::info!("Received: {}, but expected: {}", out_data[i], expected[i]);
                status = false;
            }
        }
        unmap(gl);
        Ok(if status { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// 4.1.1 NegativeAPIBind
#[derive(Default)]
pub(super) struct NegativeApiBind;

impl NegativeApiBind {
    fn expect_invalid_value(gl: &glw::Functions, message: &str) -> bool {
        // SAFETY: no arguments.
        if unsafe { gl.get_error() } != glw::GL_INVALID_VALUE {
            log::info!("{message}");
            return false;
        }
        true
    }
}

impl Subcase for NegativeApiBind {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let bindings = get_integer(gl, glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS);
        log::info!("Max storage buffer bindings {bindings}");
        let alignment = get_integer(gl, glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT);
        log::info!("Storage buffer offset alignment {alignment}");

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, bindings as GLuint, 0));
        if !Self::expect_invalid_value(
            gl,
            "INVALID_VALUE is generated by BindBufferBase if <target> is\nSHADER_STORAGE_BUFFER and <index> is greater than or equal to the value of\nMAX_SHADER_STORAGE_BUFFER_BINDINGS.",
        ) {
            return Ok(ERROR);
        }

        gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, bindings as GLuint, 0, 0, 0));
        if !Self::expect_invalid_value(
            gl,
            "INVALID_VALUE is generated by BindBufferRange if <target> is\nSHADER_STORAGE_BUFFER and <index> is greater than or equal to the value of\nMAX_SHADER_STORAGE_BUFFER_BINDINGS.",
        ) {
            return Ok(ERROR);
        }

        let mut buffer: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut buffer));
        gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer, (alignment - 1) as isize, 0));
        if !Self::expect_invalid_value(
            gl,
            "INVALID_VALUE is generated by BindBufferRange if <target> is\nSHADER_STORAGE_BUFFER and <offset> is not a multiple of the value of\nSHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT.",
        ) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

fn shader1(binding: i32) -> String {
    format!("\nlayout(binding = {binding}) buffer Buffer {{\n  int x;\n}};\nvoid main() {{\n  x = 0;\n}}")
}

fn shader2(binding: i32) -> String {
    format!(
        "\nlayout(binding = {binding}) buffer Buffer {{\n  int x;\n}} g_array[4];\nvoid main() {{\n  g_array[0].x = 0;\n  g_array[1].x = 0;\n  g_array[2].x = 0;\n  g_array[3].x = 0;\n}}"
    )
}

/// 4.2.1 NegativeGLSLCompileTime
#[derive(Default)]
pub(super) struct NegativeGlslCompileTime;

impl NegativeGlslCompileTime {
    /// True when the compute shader `source` fails to compile, as every source of this case must.
    fn compile(gl: &glw::Functions, source: &str) -> bool {
        let cs_ver = "#version 310 es\nlayout(local_size_x = 1) in;";
        let parts = [cs_ver, source];
        let pointers = [
            parts[0].as_ptr().cast::<glw::GLchar>(),
            parts[1].as_ptr().cast::<glw::GLchar>(),
        ];
        let lengths = [parts[0].len() as GLint, parts[1].len() as GLint];
        let shader = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        gl!(gl.shader_source(shader, 2, pointers.as_ptr(), lengths.as_ptr()));
        gl!(gl.compile_shader(shader));
        let mut info_log = [0u8; 1024];
        gl!(gl.get_shader_info_log(shader, 1024, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
        let end = info_log.iter().position(|b| *b == 0).unwrap_or(info_log.len());
        log::info!("Shader Info Log:\n{}", String::from_utf8_lossy(&info_log[..end]));
        let mut status: GLint = 0;
        gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
        gl!(gl.delete_shader(shader));
        if status == glw::GL_TRUE as GLint {
            log::info!("Compilation should fail.");
            return false;
        }
        true
    }
}

impl Subcase for NegativeGlslCompileTime {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let bindings = get_integer(gl, glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS);
        let sources: Vec<String> = vec![
        "\nbuffer Buffer { int x = 10; };\nvoid main() {\n  x = 0;\n}".to_string(),
        shader1(-1),
        shader1(bindings),
        shader2(bindings - 2),
        "\nbuffer int x;\nvoid main() {\n  x = 0;\n}".to_string(),
        "\nbuffer Buffer { int y; };\nvoid main() {\n  y = 0;\n  buffer int x = 0;\n}".to_string(),
        "\nbuffer Buffer { int y; };\nvoid Modify(buffer int a) {\n  atomicAdd(a, 1);\n}\nvoid main() {\n  Modify(y);\n}".to_string(),
        "\nlayout(std430) uniform UBO { int x; };\nbuffer SSBO { int y; };\nvoid main() {\n  y = x;\n}".to_string(),
        "\nbuffer SSBO {\n  layout(std430) int x;\n};\nvoid main() {\n  x = 0;\n}".to_string(),
        "\nbuffer SSBO {\n  layout(binding = 1) int x;\n};\nvoid main() {\n  x = 0;\n}".to_string(),
        "\nreadonly buffer SSBO {\n  int x;\n};\nvoid main() {\n  x = 0;\n}".to_string(),
        "\nbuffer SSBO {\n  int x;\n};\nwriteonly buffer SSBO2 {\n  int y;\n};\nvoid main() {\n  x = y;\n}".to_string(),
        "\nbuffer SSBO {\n  int x;\n};\nbuffer SSBO2 {\n  writeonly int y;\n  readonly int z;\n};\nvoid main() {\n  x = y;\n  z = 0;\n}".to_string(),
        "\nbuffer SSBO {\n  int x;\n};\nreadonly buffer SSBO2 {\n  writeonly int y;\n};\nvoid main() {\n  x = y;\n}".to_string(),
        "\nlayout(binding = 1) buffer;\nbuffer SSBO {\n  int x;\n};\nvoid main() {\n  x = 0;\n}".to_string(),
        "\nbuffer coherent Buffer { int x; };\nint y;\nvoid main() {\n  atomicAdd(x, 1);\n  atomicAdd(y, 2);\n}".to_string(),
        "\nbuffer b {\n  vec4 x[10];\n};\nvoid main() {\n  vec4 y = vec4(x);\n}".to_string(),
        "\nlayout(std430, binding = 0) buffer Input {\n  float data0;\n} g_input[4];\nlayout(std430, binding = 4) buffer Output {\n  float data0;\n} g_output[4];\nvoid main() {\n  for (int i = 0; i < 4; ++i) {\n    g_output[i].data0 = g_input[i].data0;\n  }\n}".to_string(),
        "\nlayout(binding = 0, std430) buffer Material {\n  vec3 color;\n} g_material[4];\nlayout(binding = 4, std430) buffer OutputBuffer {\n  vec3 color[4];\n};\nuniform int g_material_id;\nvoid main() {\n  color[gl_LocalInvocationIndex] = vec3(g_material[g_material_id].color);\n}".to_string(),
        ];
        for source in &sources {
            if !Self::compile(gl, source) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

/// 4.2.2 NegativeGLSLLinkTime
#[derive(Default)]
pub(super) struct NegativeGlslLinkTime;

impl NegativeGlslLinkTime {
    fn compile_attached(
        gl: &glw::Functions,
        program: GLuint,
        shader_type: glw::GLenum,
        source: &str,
        name: &str,
    ) -> bool {
        let shader = gl!(gl.create_shader(shader_type));
        gl!(gl.attach_shader(program, shader));
        gl!(gl.delete_shader(shader));
        let pointer = source.as_ptr().cast::<glw::GLchar>();
        let length = source.len() as GLint;
        gl!(gl.shader_source(shader, 1, &pointer, &length));
        gl!(gl.compile_shader(shader));
        let mut status: GLint = 0;
        gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
        if status == glw::GL_FALSE as GLint {
            log::info!("{name} compilation should be ok.");
            check_program(gl, program);
            gl!(gl.delete_program(program));
            return false;
        }
        true
    }

    /// True when linking the two shaders fails, as every pair of this case must.
    fn link(gl: &glw::Functions, cs0: &str, cs1: &str) -> bool {
        let program = gl!(gl.create_program());
        if !Self::compile_attached(gl, program, glw::GL_VERTEX_SHADER, cs0, "VS") {
            return false;
        }
        if !Self::compile_attached(gl, program, glw::GL_FRAGMENT_SHADER, cs1, "FS") {
            return false;
        }
        gl!(gl.link_program(program));
        let mut info_log = [0u8; 1024];
        gl!(gl.get_program_info_log(program, 1024, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
        let end = info_log.iter().position(|b| *b == 0).unwrap_or(info_log.len());
        log::info!("Program Info Log:\n{}", String::from_utf8_lossy(&info_log[..end]));
        let mut status: GLint = 0;
        gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
        gl!(gl.delete_program(program));
        if status == glw::GL_TRUE as GLint {
            log::info!("Link operation should fail.");
            return false;
        }
        true
    }
}

impl Subcase for NegativeGlslLinkTime {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 1, 1) {
            return Ok(NOT_SUPPORTED);
        }
        let pairs: [[&str; 2]; 4] = [
            [
                "#version 310 es\nbuffer Buffer { int x; };\nvoid main() {\n  x += 2;\n}",
                "#version 310 es\nprecision highp float;\nbuffer Buffer { uint x; };\nvoid main() {\n  x += 3u;\n}",
            ],
            [
                "#version 310 es\nbuffer Buffer { int x; int y; };\nvoid main() {\n  x += 2;\n}",
                "#version 310 es\nprecision highp float;\nbuffer Buffer { int x; };\nvoid main() {\n  x += 3;\n}",
            ],
            [
                "#version 310 es\nbuffer Buffer { int y; };\nvoid main() {\n  y += 2;\n}",
                "#version 310 es\nprecision highp float;\nbuffer Buffer { int x; };\nvoid main() {\n  x += 3;\n}",
            ],
            [
                "#version 310 es\nbuffer Buffer { int x[2]; };\nvoid main() {\n  x[1] += 2;\n}",
                "#version 310 es\nprecision highp float;\nbuffer Buffer { int x[3]; };\nvoid main() {\n  x[1] += 3;\n}",
            ],
        ];
        for [cs0, cs1] in pairs {
            if !Self::link(gl, cs0, cs1) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

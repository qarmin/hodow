// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The four-quad vertex data every rendering case repeats is `quad_vertices` (same f32 arithmetic as the C++ initialisers); the 100x100 render target setup is `init_render_target`.

use super::super::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};
use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLint, GLuint};

const SWITCH_BUFFERS_VS: &str = "\nstruct VertexData {\n  vec2 position;\n  vec3 color;\n};\nlayout(binding = 0, std430) buffer Input {\n  VertexData vertex[4];\n} g_vs_in;\nout vec3 StageData_color;\nvoid main() {\n  gl_Position = vec4(g_vs_in.vertex[gl_VertexID].position, 0, 1);\n  StageData_color = g_vs_in.vertex[gl_VertexID].color;\n}";
const SWITCH_BUFFERS_FS: &str = "\nin vec3 StageData_color;\nlayout(location = 0) out vec4 g_fs_out;\nvoid main() {\n  g_fs_out = vec4(StageData_color, 1);\n}";

/// Draws one triangle strip per buffer binding and checks the four quads; shared by both passes of AdvancedSwitchBuffersVS.
fn draw_quads_with(gl: &glw::Functions, bind: impl Fn(usize), draw_instanced: bool) {
    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
    for i in 0..4 {
        bind(i);
        if draw_instanced {
            gl!(gl.draw_arrays_instanced(glw::GL_TRIANGLE_STRIP, 0, 4, 1));
        } else {
            gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        }
    }
}

/// 2.1 AdvancedSwitchBuffersVS
#[derive(Default)]
pub(super) struct AdvancedSwitchBuffersVs {
    program: GLuint,
    storage_buffer: [GLuint; 5],
    vertex_array: GLuint,
    fbo: GLuint,
    rt: GLuint,
}

impl Subcase for AdvancedSwitchBuffersVs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_framebuffers(1, &mut self.fbo));
        gl!(gl.gen_textures(1, &mut self.rt));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 1, 0) {
            return Ok(NOT_SUPPORTED);
        }
        self.program = create_program(gl, SWITCH_BUFFERS_VS, SWITCH_BUFFERS_FS);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(5, self.storage_buffer.as_mut_ptr()));

        // left bottom red, right bottom green, left top blue, right top yellow quad
        let quads = four_quads();
        for (i, quad) in quads.iter().enumerate() {
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[i]));
            ssbo_data(gl, quad, glw::GL_STATIC_DRAW);
        }

        let alignment = get_integer(gl, glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT);
        let offset = round_up(4 * 32, alignment);

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[4]));
        ssbo_alloc(gl, (offset * 4) as usize, glw::GL_STATIC_DRAW);

        for i in 0..4 {
            gl!(gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.storage_buffer[i]));
            gl!(gl.copy_buffer_sub_data(
                glw::GL_COPY_READ_BUFFER,
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                (i as i32 * offset) as isize,
                4 * 32
            ));
        }

        init_render_target(gl, self.rt, self.fbo);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));

        draw_quads_with(
            gl,
            |i| gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer[i])),
            false,
        );
        if !validate_window_4_quads_default(context) {
            return Ok(ERROR);
        }

        draw_quads_with(
            gl,
            |i| {
                gl!(gl.bind_buffer_range(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    0,
                    self.storage_buffer[4],
                    (i as i32 * offset) as isize,
                    4 * 32
                ))
            },
            true,
        );
        if !validate_window_4_quads_default(context) {
            return Ok(ERROR);
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        restore_viewport(context);
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(5, self.storage_buffer.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(1, &self.rt));
        Ok(NO_ERROR)
    }
}

const DIGEST_CS: &str = "\nlayout(local_size_x = 1) in;\nlayout(binding = 0, std430) buffer Input {\n  uint cookie[4];\n} g_in;\nlayout(binding = 1, std430) buffer Output {\n  uvec4 digest;\n} ;\nvoid main() {\n  switch (g_in.cookie[0]+g_in.cookie[1]+g_in.cookie[2]+g_in.cookie[3]) {\n    case 0x000000ffu: digest.x = 0xff000000u; break;\n    case 0x0000ff00u: digest.y = 0x00ff0000u; break;\n    case 0x00ff0000u: digest.z = 0x0000ff00u; break;\n    case 0xff000000u: digest.w = 0x000000ffu; break;\n  }\n}";

/// The four 16-byte cookies the switching compute cases feed through one binding.
const COOKIES: [[u8; 16]; 4] = [
    [0, 0, 0, 0x11, 0, 0, 0, 0x44, 0, 0, 0, 0x88, 0, 0, 0, 0x22],
    [0, 0, 0x44, 0, 0, 0, 0x22, 0, 0, 0, 0x88, 0, 0, 0, 0x11, 0],
    [0, 0x88, 0, 0, 0, 0x11, 0, 0, 0, 0x44, 0, 0, 0, 0x22, 0, 0],
    [0x22, 0, 0, 0, 0x88, 0, 0, 0, 0x11, 0, 0, 0, 0x44, 0, 0, 0],
];

const DIGEST_EXPECTED: [GLuint; 4] = [0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff];

/// Maps the first four uints of the bound buffer and compares them with the digest; None when the mapping fails.
fn digest_matches(gl: &glw::Functions) -> Option<bool> {
    let out_data = map_read::<GLuint>(gl, 0, 4)?;
    if out_data[..] != DIGEST_EXPECTED[..] {
        log::info!(
            "Received: {:#x}, {:#x}, {:#x}, {:#x}, but expected: {:#x}, {:#x}, {:#x}, {:#x}",
            out_data[0],
            out_data[1],
            out_data[2],
            out_data[3],
            DIGEST_EXPECTED[0],
            DIGEST_EXPECTED[1],
            DIGEST_EXPECTED[2],
            DIGEST_EXPECTED[3]
        );
        return Some(false);
    }
    Some(true)
}

/// 2.1 AdvancedSwitchBuffersCS
#[derive(Default)]
pub(super) struct AdvancedSwitchBuffersCs {
    program: GLuint,
    storage_buffer: [GLuint; 6],
}

impl Subcase for AdvancedSwitchBuffersCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.program = create_program_cs(gl, DIGEST_CS);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(6, self.storage_buffer.as_mut_ptr()));

        for (i, cookie) in COOKIES.iter().enumerate() {
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[i]));
            ssbo_data(gl, cookie, glw::GL_STATIC_DRAW);
        }

        let alignment = get_integer(gl, glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT);
        let offset = round_up(16, alignment);
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[4]));
        ssbo_alloc(gl, (offset * 4) as usize, glw::GL_STATIC_DRAW);

        for i in 0..4 {
            gl!(gl.bind_buffer(glw::GL_COPY_READ_BUFFER, self.storage_buffer[i]));
            gl!(gl.copy_buffer_sub_data(
                glw::GL_COPY_READ_BUFFER,
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                (i as i32 * offset) as isize,
                16
            ));
        }

        let data = [0u8; 16];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer[5]));
        ssbo_data(gl, &data, glw::GL_STATIC_DRAW);

        gl!(gl.use_program(self.program));
        for i in 0..4 {
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer[i]));
            gl!(gl.dispatch_compute(1, 1, 1));
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[5]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        match digest_matches(gl) {
            None | Some(false) => return Ok(ERROR),
            Some(true) => {}
        }
        unmap(gl);
        ssbo_data(gl, &data, glw::GL_STATIC_DRAW);

        for i in 0..4 {
            gl!(gl.bind_buffer_range(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                self.storage_buffer[4],
                (i * offset) as isize,
                16
            ));
            gl!(gl.dispatch_compute(1, 1, 1));
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[5]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        match digest_matches(gl) {
            None | Some(false) => return Ok(ERROR),
            Some(true) => {}
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(6, self.storage_buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

const SWITCH_PROGRAMS_FS: &str = "\nin vec3 StageData_color;\nlayout(location = 0) out vec4 g_fs_out;\nvoid main() {\n  g_fs_out = vec4(StageData_color, 1);\n}";

/// AdvancedSwitchProgramsVS::GenSource
fn switch_programs_vs_source(binding: i32) -> String {
    format!(
        "\nstruct VertexData {{\n  vec2 position;\n  vec3 color;\n}};\nlayout(binding = {binding}, std430) buffer Input {{\n  VertexData vertex[4];\n}} g_vs_in;\nout vec3 StageData_color;\nvoid main() {{\n  gl_Position = vec4(g_vs_in.vertex[gl_VertexID].position, 0, 1);\n  StageData_color = g_vs_in.vertex[gl_VertexID].color;\n}}"
    )
}

/// 2.2 AdvancedSwitchProgramsVS
#[derive(Default)]
pub(super) struct AdvancedSwitchProgramsVs {
    program: [GLuint; 4],
    storage_buffer: [GLuint; 4],
    vertex_array: GLuint,
    fbo: GLuint,
    rt: GLuint,
}

impl Subcase for AdvancedSwitchProgramsVs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_framebuffers(1, &mut self.fbo));
        gl!(gl.gen_textures(1, &mut self.rt));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 1, 0) {
            return Ok(NOT_SUPPORTED);
        }
        for i in 0..4 {
            self.program[i] = create_program(gl, &switch_programs_vs_source(i as i32), SWITCH_PROGRAMS_FS);
            gl!(gl.link_program(self.program[i]));
            if !check_program(gl, self.program[i]) {
                return Ok(ERROR);
            }
        }

        gl!(gl.gen_buffers(4, self.storage_buffer.as_mut_ptr()));

        let quads = four_quads();
        for (i, quad) in quads.iter().enumerate() {
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint, self.storage_buffer[i]));
            ssbo_data(gl, quad, glw::GL_STATIC_DRAW);
        }

        init_render_target(gl, self.rt, self.fbo);

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        for i in 0..4 {
            gl!(gl.use_program(self.program[i]));
            gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        }
        if !validate_window_4_quads_default(context) {
            return Ok(ERROR);
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        restore_viewport(context);
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_buffers(4, self.storage_buffer.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(1, &self.rt));
        Ok(NO_ERROR)
    }
}

/// AdvancedSwitchProgramsCS::GenSource
fn switch_programs_cs_source(binding: i32) -> String {
    format!(
        "\nlayout(local_size_x = 1) in;\nlayout(binding = {binding}, std430) buffer Input {{\n  uint cookie[4];\n}} g_in;\nlayout(binding = 0, std430) buffer Output {{\n  uvec4 digest;\n}} ;\nvoid main() {{\n  switch (g_in.cookie[0]+g_in.cookie[1]+g_in.cookie[2]+g_in.cookie[3]) {{\n    case 0x000000ffu: digest.x = 0xff000000u; break;\n    case 0x0000ff00u: digest.y = 0x00ff0000u; break;\n    case 0x00ff0000u: digest.z = 0x0000ff00u; break;\n    case 0xff000000u: digest.w = 0x000000ffu; break;\n  }}\n}}"
    )
}

/// 2.2 AdvancedSwitchProgramsCS
#[derive(Default)]
pub(super) struct AdvancedSwitchProgramsCs {
    program: [GLuint; 4],
    storage_buffer: [GLuint; 5],
}

impl Subcase for AdvancedSwitchProgramsCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        for i in 0..4 {
            self.program[i] = create_program_cs(gl, &switch_programs_cs_source(i as i32 + 1));
            gl!(gl.link_program(self.program[i]));
            if !check_program(gl, self.program[i]) {
                return Ok(ERROR);
            }
        }

        gl!(gl.gen_buffers(5, self.storage_buffer.as_mut_ptr()));

        for (i, cookie) in COOKIES.iter().enumerate() {
            gl!(gl.bind_buffer_base(
                glw::GL_SHADER_STORAGE_BUFFER,
                i as GLuint + 1,
                self.storage_buffer[i + 1]
            ));
            ssbo_data(gl, cookie, glw::GL_STATIC_DRAW);
        }

        let data = [0u8; 16];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer[0]));
        ssbo_data(gl, &data, glw::GL_STATIC_DRAW);

        for i in 0..4 {
            gl!(gl.use_program(self.program[i]));
            gl!(gl.dispatch_compute(1, 1, 1));
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[0]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        match digest_matches(gl) {
            None | Some(false) => return Ok(ERROR),
            Some(true) => {}
        }
        unmap(gl);

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_buffers(5, self.storage_buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// The point-drawing program every write-fragment case renders the recorded SSBO with.
fn create_points_program(gl: &glw::Functions) -> GLuint {
    create_program(
        gl,
        "\nlayout(location = 0) in vec4 g_in_position;\nlayout(location = 1) in vec4 g_in_color;\nout vec3 color;\nvoid main() {\n  gl_Position = vec4(g_in_position.xy, 0, 1);\n#ifdef GL_ES\n  gl_PointSize = 1.0f;\n#endif\n  color = g_in_color.rgb;\n}",
        "\nin vec3 color;\nlayout(location = 0) out vec4 g_fs_out;\nvoid main() {\n  g_fs_out = vec4(color, 1);\n}",
    )
}

/// Binds `storage_buffer` as a vertex buffer with attribute 0 at offset 0 and attribute 1 at offset 16 (stride 32) in a new vertex array.
fn init_draw_vertex_array(gl: &glw::Functions, storage_buffer: GLuint, draw_vertex_array: &mut GLuint) {
    gl!(gl.gen_vertex_arrays(1, draw_vertex_array));
    gl!(gl.bind_vertex_array(*draw_vertex_array));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, storage_buffer));
    gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 32, std::ptr::null()));
    gl!(gl.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 32, 16usize as *const std::ffi::c_void));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.enable_vertex_attrib_array(1));
    gl!(gl.bind_vertex_array(0));
}

/// `glBufferData(GL_ATOMIC_COUNTER_BUFFER, 4, NULL, ...)` followed by a `glBufferSubData` of a zero counter.
fn init_counter_buffer(gl: &glw::Functions, binding: GLuint, counter_buffer: &mut GLuint) {
    gl!(gl.gen_buffers(1, counter_buffer));
    gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, binding, *counter_buffer));
    gl!(gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 4, std::ptr::null(), glw::GL_DYNAMIC_DRAW));
    let zero = [0u32; 4];
    gl!(gl.buffer_sub_data(glw::GL_ATOMIC_COUNTER_BUFFER, 0, 4, zero.as_ptr().cast()));
}

/// 2.3.1 AdvancedWriteFragmentFS
#[derive(Default)]
pub(super) struct AdvancedWriteFragmentFs {
    program: [GLuint; 2],
    storage_buffer: GLuint,
    counter_buffer: GLuint,
    attribless_vertex_array: GLuint,
    draw_vertex_array: GLuint,
    fbo: GLuint,
    rt: GLuint,
}

impl Subcase for AdvancedWriteFragmentFs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_framebuffers(1, &mut self.fbo));
        gl!(gl.gen_textures(1, &mut self.rt));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 1) {
            return Ok(NOT_SUPPORTED);
        }
        let glsl_vs0 = "\nout vec2 position;\nout vec3 color;\nvec2 g_quad[4] = vec2[4](vec2(-0.4, -0.4), vec2(0.4, -0.4), vec2(-0.4, 0.4), vec2(0.4, 0.4));\nvec2 g_offset[4] = vec2[4](vec2(-0.5, -0.5), vec2(0.5, -0.5), vec2(-0.5, 0.5), vec2(0.5, 0.5));\nvec3 g_color[4] = vec3[4](vec3(1, 0, 0), vec3(0, 1, 0), vec3(0, 0, 1), vec3(1, 1, 0));\nvoid main() {\n  vec2 pos = g_quad[gl_VertexID] + g_offset[gl_InstanceID];\n  gl_Position = vec4(pos, 0, 1);\n  position = pos;\n  color = g_color[gl_InstanceID];\n}";
        let glsl_fs0 = "\nin vec2 position;\nin vec3 color;\nlayout(location = 0) out vec4 g_fs_out;\nstruct FragmentData {\n  vec2 position;\n  vec3 color;\n};\nlayout(std430, binding = 3) buffer Output {\n  FragmentData g_fragment[6400];\n};\nuniform uint g_max_fragment_count;\nlayout(binding = 2, offset = 0) uniform atomic_uint g_fragment_counter;\nvoid main() {\n  uint fragment_number = atomicCounterIncrement(g_fragment_counter);\n  if (fragment_number < g_max_fragment_count) {\n    g_fragment[fragment_number].position = position;\n    g_fragment[fragment_number].color = color;\n  }\n  g_fs_out = vec4(color, 1);\n}";
        self.program[0] = create_program(gl, glsl_vs0, glsl_fs0);
        gl!(gl.link_program(self.program[0]));
        if !check_program(gl, self.program[0]) {
            return Ok(ERROR);
        }

        self.program[1] = create_points_program(gl);
        gl!(gl.link_program(self.program[1]));
        if !check_program(gl, self.program[1]) {
            return Ok(ERROR);
        }

        // The first pass renders four squares on-screen, and writes a
        // record to the SSBO for each fragment processed.  The rectangles
        // will be 40x40 when using a 100x100 viewport, so we expect 1600
        // pixels per rectangle or 6400 pixels total.  Size the SSBO
        // accordingly, and render the second pass (sourcing the SSBO as a
        // vertex buffer) with an identical number of points.  If we have
        // a larger buffer and draw more points on the second pass, those
        // may overwrite "real" points using garbage position/color.
        let expected_pixels = 6400;

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 3, self.storage_buffer));
        ssbo_alloc(gl, expected_pixels * 32, glw::GL_DYNAMIC_DRAW);

        init_counter_buffer(gl, 2, &mut self.counter_buffer);

        init_render_target(gl, self.rt, self.fbo);

        gl!(gl.gen_vertex_arrays(1, &mut self.attribless_vertex_array));

        init_draw_vertex_array(gl, self.storage_buffer, &mut self.draw_vertex_array);

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program[0]));
        gl!(gl.uniform_1ui(
            uniform_location(gl, self.program[0], "g_max_fragment_count"),
            expected_pixels as GLuint
        ));
        gl!(gl.bind_vertex_array(self.attribless_vertex_array));
        gl!(gl.draw_arrays_instanced(glw::GL_TRIANGLE_STRIP, 0, 4, 4));
        if !validate_window_4_quads_default(context) {
            return Ok(ERROR);
        }

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program[1]));
        gl!(gl.bind_vertex_array(self.draw_vertex_array));
        gl!(gl.memory_barrier(glw::GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, expected_pixels as GLint));
        let mut bad_pixels = 0;
        if !validate_window_4_quads(
            context,
            [1.0, 0.0, 0.0],
            [0.0, 1.0, 0.0],
            [1.0, 1.0, 0.0],
            [0.0, 0.0, 1.0],
            Some(&mut bad_pixels),
        ) && bad_pixels > 2
        {
            return Ok(ERROR);
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        restore_viewport(context);
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.attribless_vertex_array));
        gl!(gl.delete_vertex_arrays(1, &self.draw_vertex_array));
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(1, &self.rt));
        Ok(NO_ERROR)
    }
}

/// 2.3.1 AdvancedWriteFragmentCS
#[derive(Default)]
pub(super) struct AdvancedWriteFragmentCs {
    program: [GLuint; 2],
    storage_buffer: GLuint,
    counter_buffer: GLuint,
    draw_vertex_array: GLuint,
    fbo: GLuint,
    rt: GLuint,
}

impl Subcase for AdvancedWriteFragmentCs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_framebuffers(1, &mut self.fbo));
        gl!(gl.gen_textures(1, &mut self.rt));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 10, local_size_y = 10) in;\nuniform uint g_max_point_count;\nuniform uint g_brick;\nvec3 g_color[5] = vec3[5](vec3(1, 0, 0), vec3(0, 1, 0), vec3(1, 1, 0), vec3(0, 0, 1), vec3(0, 0, 0));\nstruct PointData {\n  vec2 position;\n  vec3 color;\n};\nlayout(std430, binding = 3) buffer Output {\n  PointData g_point[];\n};\nlayout(binding = 0, offset = 0) uniform atomic_uint g_point_counter;\nvoid main() {\n  uint g_offset[4] = uint[4](g_brick, 9u*g_brick, 11u*g_brick, 19u*g_brick);\n  uint point_number = atomicCounterIncrement(g_point_counter);\n  uint giidx = gl_GlobalInvocationID.x;\n  uint giidy = gl_GlobalInvocationID.y;\n  g_point[point_number].position = vec2(gl_GlobalInvocationID.xy * 2u) / 100.0 - 1.0;\n  g_point[point_number].color = g_color[4];\n  if (point_number < g_max_point_count) {\n    if (giidx > g_offset[0] && giidx < g_offset[1] && giidy > g_offset[0] && giidy < g_offset[1]) {\n      g_point[point_number].color = g_color[0];\n    }\n    if (giidx > g_offset[2] && giidx < g_offset[3] && giidy > g_offset[0] && giidy < g_offset[1]) {\n      g_point[point_number].color = g_color[1];\n    }\n    if (giidx > g_offset[2] && giidx < g_offset[3] && giidy > g_offset[2] && giidy < g_offset[3]) {\n      g_point[point_number].color = g_color[2];\n    }\n    if (giidx > g_offset[0] && giidx < g_offset[1] && giidy > g_offset[2] && giidy < g_offset[3]) {\n      g_point[point_number].color = g_color[3];\n    }\n  }\n}";

        self.program[0] = create_program_cs(gl, glsl_cs);
        gl!(gl.link_program(self.program[0]));
        if !check_program(gl, self.program[0]) {
            return Ok(ERROR);
        }

        self.program[1] = create_points_program(gl);
        gl!(gl.link_program(self.program[1]));
        if !check_program(gl, self.program[1]) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 3, self.storage_buffer));
        ssbo_alloc(gl, 100 * 100 * 32, glw::GL_DYNAMIC_DRAW);

        init_counter_buffer(gl, 0, &mut self.counter_buffer);

        init_draw_vertex_array(gl, self.storage_buffer, &mut self.draw_vertex_array);

        gl!(gl.use_program(self.program[0]));
        gl!(gl.uniform_1ui(uniform_location(gl, self.program[0], "g_max_point_count"), 100 * 100));
        gl!(gl.uniform_1ui(uniform_location(gl, self.program[0], "g_brick"), 5));
        gl!(gl.dispatch_compute(10, 10, 1));

        init_render_target(gl, self.rt, self.fbo);

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program[1]));
        gl!(gl.bind_vertex_array(self.draw_vertex_array));
        gl!(gl.memory_barrier(glw::GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 100 * 100));
        if !validate_window_4_quads_default(context) {
            return Ok(ERROR);
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        restore_viewport(context);
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.draw_vertex_array));
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(1, &self.rt));
        Ok(NO_ERROR)
    }
}

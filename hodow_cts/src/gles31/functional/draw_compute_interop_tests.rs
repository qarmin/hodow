// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fDrawTests.cpp  (ComputeShaderGeneratedCase and subclasses)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// The `compute_interop` group of `draw_indirect`: draw commands, vertex data and indices
// are produced by compute shaders and consumed by an indirect draw. The combined and
// separate subclasses of upstream are one struct here, told apart by `separate`.
//
// `glu::OutOfMemoryError` becomes a `GL_OUT_OF_MEMORY` check after every step and reports
// NotSupported, as upstream does; upstream's `setTerminateAfter(true)` has no counterpart.

use std::ffi::c_void;
use std::mem::size_of_val;

use crate::glu::{
    self, Buffer, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, VertexArray,
};
use crate::glw::{self, GLenum, GLsizeiptr, GLuint};
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

const COLOR_VERTEX_SHADER_SOURCE: &str = "#version 310 es\n\
    in highp vec4 a_position;\n\
    in highp vec4 a_color;\n\
    out highp vec4 v_color;\n\
    void main (void)\n\
    {\n\
    \tgl_Position = a_position;\n\
    \tv_color = a_color;\n\
    }\n";

const COLOR_FRAGMENT_SHADER_SOURCE: &str = "#version 310 es\n\
    layout(location = 0) out highp vec4 fragColor;\n\
    in highp vec4 v_color;\n\
    void main (void)\n\
    {\n\
    \tfragColor = v_color;\n\
    }\n";

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawMethod {
    DrawArrays,
    DrawElements,
}

/// `ComputeShaderGeneratedCase` (+ `Combined`/`Separate`)
struct ComputeShaderGeneratedCase {
    name: String,
    draw_method: DrawMethod,
    compute_cmd: bool,
    compute_data: bool,
    compute_indices: bool,
    grid_size: i32,
    num_draw_cmds: i32,
    separate: bool,
}

/// `sizeToString`
fn size_to_string(size: i32) -> String {
    if size < 1024 {
        format!("{size} byte(s)")
    } else if size < 1024 * 1024 {
        format!("{} KB", size / 1024)
    } else {
        format!("{} MB", size / 1024 / 1024)
    }
}

/// `verifyImageYellowGreen` - the image contains only yellow or green, or a linear
/// combination of the two.
pub(crate) fn verify_image_yellow_green(image: &Surface) -> bool {
    let color_threshold = 20;

    for y in 0..image.get_height() {
        for x in 0..image.get_width() {
            let pixel = image.get_pixel(x, y);

            // Any pixel with !(G ~= 255) is faulty (not a linear combinations of green and yellow)
            if (pixel.get_green() - 255).abs() > color_threshold {
                return false;
            }

            // Any pixel with !(B ~= 0) is faulty (not a linear combinations of green and yellow)
            if pixel.get_blue().abs() > color_threshold {
                return false;
            }
        }
    }

    true
}

/// A GL error as the verdict upstream gives it: out of memory is NotSupported.
fn check_gl(gl: &glw::Functions, message: &str) -> Result<(), TestError> {
    // SAFETY: glGetError needs only a current context.
    let error = unsafe { gl.get_error() };
    match error {
        glw::GL_NO_ERROR => Ok(()),
        glw::GL_OUT_OF_MEMORY => Err(TestError::NotSupported("Got GL_OUT_OF_MEMORY".to_string())),
        other => Err(TestError::Fail(format!(
            "{message} returned {}",
            glw::error_name(other)
        ))),
    }
}

impl ComputeShaderGeneratedCase {
    fn command_size(&self) -> i32 {
        match self.draw_method {
            DrawMethod::DrawArrays => 4 * 4,
            DrawMethod::DrawElements => 5 * 4,
        }
    }

    /// `calcDrawBufferSize` - in "vec4"s.
    fn calc_draw_buffer_size(&self) -> u32 {
        let grid = self.grid_size as u32;
        match self.draw_method {
            DrawMethod::DrawArrays => grid * grid * 6 * 2,
            DrawMethod::DrawElements => (grid + 1) * (grid + 1) * 4,
        }
    }

    /// `calcIndexBufferSize`
    fn calc_index_buffer_size(&self) -> u32 {
        match self.draw_method {
            DrawMethod::DrawElements => (self.grid_size * self.grid_size * 6) as u32,
            DrawMethod::DrawArrays => 0,
        }
    }

    /// `genComputeSource`
    fn gen_compute_source(&self, compute_cmd: bool, compute_data: bool, compute_indices: bool) -> String {
        let cmd_layout_binding = 0;
        let data_layout_binding = if compute_cmd { 1 } else { 0 };
        let index_layout_binding = if compute_cmd && compute_data {
            2
        } else if compute_cmd || compute_data {
            1
        } else {
            0
        };
        let grid_size = self.grid_size;
        let num_draw_cmds = self.num_draw_cmds;
        let is_arrays = self.draw_method == DrawMethod::DrawArrays;

        let mut buf = String::from("#version 310 es\n\nprecision highp int;\nprecision highp float;\n\n");

        if compute_cmd && is_arrays {
            buf.push_str(
                "struct DrawArraysIndirectCommand {\n    uint count;\n    uint primCount;\n    uint first;\n    uint reservedMustBeZero;\n};\n\n",
            );
        } else if compute_cmd {
            buf.push_str(
                "struct DrawElementsIndirectCommand {\n    uint count;\n    uint primCount;\n    uint firstIndex;\n    int  baseVertex;\n    uint reservedMustBeZero;\n};\n\n",
            );
        }

        buf.push_str("layout(local_size_x = 1, local_size_y = 1) in;\nlayout(std430) buffer;\n\n");

        if compute_cmd {
            buf.push_str(&format!(
                "layout(binding = {cmd_layout_binding}) writeonly buffer CommandBuffer {{\n    {} commands[];\n}};\n",
                if is_arrays {
                    "DrawArraysIndirectCommand"
                } else {
                    "DrawElementsIndirectCommand"
                }
            ));
        }
        if compute_data {
            buf.push_str(&format!(
                "layout(binding = {data_layout_binding}) writeonly buffer DataBuffer {{\n    vec4 attribs[];\n}};\n"
            ));
        }
        if compute_indices {
            buf.push_str(&format!(
                "layout(binding = {index_layout_binding}) writeonly buffer IndexBuffer {{\n    uint indices[];\n}};\n"
            ));
        }

        buf.push_str(&format!(
            "\nvoid main() {{\n    const uint gridSize      = {grid_size}u;\n    const uint triangleCount = gridSize * gridSize * 2u;\n\n"
        ));

        if compute_cmd {
            buf.push_str(&format!(
                "    // command\n\
                 \x20   if (gl_GlobalInvocationID.x < {num_draw_cmds}u && gl_GlobalInvocationID.y == 0u && gl_GlobalInvocationID.z == 0u) {{\n\
                 \x20       const uint numDrawCallTris = triangleCount / {num_draw_cmds}u;\n\
                 \x20       uint firstTri              = gl_GlobalInvocationID.x * numDrawCallTris;\n\n\
                 \x20       commands[gl_GlobalInvocationID.x].count                 = numDrawCallTris*3u;\n\
                 \x20       commands[gl_GlobalInvocationID.x].primCount             = 1u;\n"
            ));

            if is_arrays {
                buf.push_str("        commands[gl_GlobalInvocationID.x].first                 = firstTri*3u;\n");
            } else {
                buf.push_str("        commands[gl_GlobalInvocationID.x].firstIndex            = firstTri*3u;\n");
                buf.push_str("        commands[gl_GlobalInvocationID.x].baseVertex            = 0;\n");
            }

            buf.push_str("        commands[gl_GlobalInvocationID.x].reservedMustBeZero    = 0u;\n    }\n\n");
        }

        if compute_data {
            buf.push_str("    // vertex attribs\n    const vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n");

            if is_arrays {
                buf.push_str(
                    "    if (gl_GlobalInvocationID.x < gridSize && gl_GlobalInvocationID.y < gridSize && gl_GlobalInvocationID.z == 0u) {\n\
                     \x20       uint        y           = gl_GlobalInvocationID.x;\n\
                     \x20       uint        x           = gl_GlobalInvocationID.y;\n\
                     \x20       float       posX        = (float(x)    / float(gridSize)) * 2.0 - 1.0;\n\
                     \x20       float       posXp1      = (float(x+1u) / float(gridSize)) * 2.0 - 1.0;\n\
                     \x20       float       posY        = (float(y)    / float(gridSize)) * 2.0 - 1.0;\n\
                     \x20       float       posYp1      = (float(y+1u) / float(gridSize)) * 2.0 - 1.0;\n\
                     \x20       vec4        color       = ((x + y)%2u != 0u) ? (yellow) : (green);\n\
                     \n\
                     \x20       attribs[((y * gridSize + x) * 6u + 0u) * 2u + 0u] = vec4(posX,   posY,   0.0, 1.0);\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 1u) * 2u + 0u] = vec4(posXp1, posY,   0.0, 1.0);\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 2u) * 2u + 0u] = vec4(posXp1, posYp1, 0.0, 1.0);\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 3u) * 2u + 0u] = vec4(posX,   posY,   0.0, 1.0);\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 4u) * 2u + 0u] = vec4(posXp1, posYp1, 0.0, 1.0);\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 5u) * 2u + 0u] = vec4(posX,   posYp1, 0.0, 1.0);\n\
                     \n\
                     \x20       attribs[((y * gridSize + x) * 6u + 0u) * 2u + 1u] = color;\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 1u) * 2u + 1u] = color;\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 2u) * 2u + 1u] = color;\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 3u) * 2u + 1u] = color;\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 4u) * 2u + 1u] = color;\n\
                     \x20       attribs[((y * gridSize + x) * 6u + 5u) * 2u + 1u] = color;\n\
                     \x20   }\n",
                );
            } else {
                buf.push_str(
                    "    if (gl_GlobalInvocationID.x < gridSize+1u && gl_GlobalInvocationID.y < gridSize+1u && gl_GlobalInvocationID.z == 0u) {\n\
                     \x20       uint        y           = gl_GlobalInvocationID.x;\n\
                     \x20       uint        x           = gl_GlobalInvocationID.y;\n\
                     \x20       float       posX        = (float(x) / float(gridSize)) * 2.0 - 1.0;\n\
                     \x20       float       posY        = (float(y) / float(gridSize)) * 2.0 - 1.0;\n\
                     \n\
                     \x20       attribs[(y * (gridSize+1u) + x) * 4u + 0u] = vec4(posX, posY, 0.0, 1.0);\n\
                     \x20       attribs[(y * (gridSize+1u) + x) * 4u + 1u] = green;\n\
                     \x20       attribs[(y * (gridSize+1u) + x) * 4u + 2u] = vec4(posX, posY, 0.0, 1.0);\n\
                     \x20       attribs[(y * (gridSize+1u) + x) * 4u + 3u] = yellow;\n\
                     \x20   }\n",
                );
            }

            buf.push('\n');
        }

        if compute_indices {
            buf.push_str(
                "    // indices\n\
                 \x20   if (gl_GlobalInvocationID.x < gridSize && gl_GlobalInvocationID.y < gridSize && gl_GlobalInvocationID.z == 0u) {\n\
                 \x20       uint    y       = gl_GlobalInvocationID.x;\n\
                 \x20       uint    x       = gl_GlobalInvocationID.y;\n\
                 \x20       uint    color   = ((x + y)%2u);\n\
                 \n\
                 \x20       indices[(y * gridSize + x) * 6u + 0u] = ((y+0u) * (gridSize+1u) + (x+0u)) * 2u + color;\n\
                 \x20       indices[(y * gridSize + x) * 6u + 1u] = ((y+1u) * (gridSize+1u) + (x+0u)) * 2u + color;\n\
                 \x20       indices[(y * gridSize + x) * 6u + 2u] = ((y+1u) * (gridSize+1u) + (x+1u)) * 2u + color;\n\
                 \x20       indices[(y * gridSize + x) * 6u + 3u] = ((y+0u) * (gridSize+1u) + (x+0u)) * 2u + color;\n\
                 \x20       indices[(y * gridSize + x) * 6u + 4u] = ((y+1u) * (gridSize+1u) + (x+1u)) * 2u + color;\n\
                 \x20       indices[(y * gridSize + x) * 6u + 5u] = ((y+0u) * (gridSize+1u) + (x+1u)) * 2u + color;\n\
                 \x20   }\n\
                 \n",
            );
        }

        buf.push_str("}\n");
        buf
    }

    /// `createDrawCommand`
    fn create_draw_command(&self, gl: &glw::Functions, cmd_buffer: GLuint) -> Result<(), TestError> {
        let triangle_count = self.grid_size * self.grid_size * 2;
        let num_draw_call_tris = (triangle_count / self.num_draw_cmds) as u32;
        let mut cmds: Vec<u32> = Vec::new();

        for ndx in 0..self.num_draw_cmds {
            let first_tri = ndx as u32 * num_draw_call_tris;

            match self.draw_method {
                DrawMethod::DrawArrays => cmds.extend_from_slice(&[num_draw_call_tris * 3, 1, first_tri * 3, 0]),
                DrawMethod::DrawElements => cmds.extend_from_slice(&[num_draw_call_tris * 3, 1, first_tri * 3, 0, 0]),
            }
        }

        // SAFETY: a buffer name this case generated and a vector that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, cmd_buffer);
            gl.buffer_data(
                glw::GL_DRAW_INDIRECT_BUFFER,
                size_of_val(cmds.as_slice()) as GLsizeiptr,
                cmds.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        check_gl(gl, "create draw command")
    }

    /// `createDrawData`
    fn create_draw_data(&self, gl: &glw::Functions, data_buffer: GLuint) -> Result<(), TestError> {
        let yellow = [1.0f32, 1.0, 0.0, 1.0];
        let green = [0.0f32, 1.0, 0.0, 1.0];
        let grid = self.grid_size;

        let buffer: Vec<[f32; 4]> = match self.draw_method {
            DrawMethod::DrawArrays => {
                // Store elements in the order they are drawn. Interleave color.
                let mut buffer = vec![[0.0f32; 4]; (grid * grid * 6 * 2) as usize];

                for y in 0..grid {
                    for x in 0..grid {
                        let pos_x = (x as f32 / grid as f32) * 2.0 - 1.0;
                        let pos_y = (y as f32 / grid as f32) * 2.0 - 1.0;
                        let cell_size = 2.0 / grid as f32;
                        let color = if (x + y) % 2 != 0 { yellow } else { green };
                        let base = ((y * grid + x) * 6) as usize;

                        buffer[(base) * 2] = [pos_x, pos_y, 0.0, 1.0];
                        buffer[(base + 1) * 2] = [pos_x + cell_size, pos_y, 0.0, 1.0];
                        buffer[(base + 2) * 2] = [pos_x + cell_size, pos_y + cell_size, 0.0, 1.0];
                        buffer[(base + 3) * 2] = [pos_x, pos_y, 0.0, 1.0];
                        buffer[(base + 4) * 2] = [pos_x + cell_size, pos_y + cell_size, 0.0, 1.0];
                        buffer[(base + 5) * 2] = [pos_x, pos_y + cell_size, 0.0, 1.0];

                        for vertex in 0..6 {
                            buffer[(base + vertex) * 2 + 1] = color;
                        }
                    }
                }

                buffer
            }
            DrawMethod::DrawElements => {
                // Elements are indexed by index buffer. Interleave color. Two vertices per position since 2 colors
                let mut buffer = vec![[0.0f32; 4]; ((grid + 1) * (grid + 1) * 4) as usize];

                for y in 0..grid + 1 {
                    for x in 0..grid + 1 {
                        let pos_x = (x as f32 / grid as f32) * 2.0 - 1.0;
                        let pos_y = (y as f32 / grid as f32) * 2.0 - 1.0;
                        let base = ((y * (grid + 1) + x) * 4) as usize;

                        buffer[base] = [pos_x, pos_y, 0.0, 1.0];
                        buffer[base + 1] = green;
                        buffer[base + 2] = [pos_x, pos_y, 0.0, 1.0];
                        buffer[base + 3] = yellow;
                    }
                }

                buffer
            }
        };

        // SAFETY: a buffer name this case generated and a vector that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, data_buffer);
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(buffer.as_slice()) as GLsizeiptr,
                buffer.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        check_gl(gl, "create draw data")
    }

    /// `createDrawIndices`
    fn create_draw_indices(&self, gl: &glw::Functions, index_buffer: GLuint) -> Result<(), TestError> {
        let grid = self.grid_size;
        let mut buffer = vec![0u32; (grid * grid * 6) as usize];

        for y in 0..grid {
            for x in 0..grid {
                let color = (x + y) % 2;
                let base = ((y * grid + x) * 6) as usize;

                buffer[base] = (((y) * (grid + 1) + x) * 2 + color) as u32;
                buffer[base + 1] = (((y + 1) * (grid + 1) + x) * 2 + color) as u32;
                buffer[base + 2] = (((y + 1) * (grid + 1) + (x + 1)) * 2 + color) as u32;
                buffer[base + 3] = (((y) * (grid + 1) + x) * 2 + color) as u32;
                buffer[base + 4] = (((y + 1) * (grid + 1) + (x + 1)) * 2 + color) as u32;
                buffer[base + 5] = (((y) * (grid + 1) + (x + 1)) * 2 + color) as u32;
            }
        }

        // SAFETY: a buffer name this case generated and a vector that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buffer);
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                size_of_val(buffer.as_slice()) as GLsizeiptr,
                buffer.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        check_gl(gl, "create draw indices")
    }

    /// One `glBindBufferBase` + `glBufferData(nullptr)` + log pair of `runComputeShader`.
    fn alloc_ssbo(gl: &glw::Functions, binding_point: GLuint, buffer: GLuint, buffer_size: i32) {
        log::debug!(
            "Binding buffer to binding point {binding_point}, allocating {}",
            size_to_string(buffer_size)
        );

        // SAFETY: a buffer name this case generated.
        unsafe {
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, binding_point, buffer);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                buffer_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_DRAW,
            );
        }
    }

    /// `ComputeShaderGeneratedCombinedCase::runComputeShader`
    fn run_combined(
        &self,
        gl: &glw::Functions,
        program: &ShaderProgram<'_>,
        cmd: GLuint,
        data: GLuint,
        indices: GLuint,
    ) -> Result<(), TestError> {
        let indexed = self.draw_method == DrawMethod::DrawElements;
        let null_size = [0, 0, 0];
        let command_dispatch_size = if self.compute_cmd {
            [self.num_draw_cmds, 1, 1]
        } else {
            null_size
        };
        let draw_elements_data = if self.compute_data {
            [self.grid_size + 1, self.grid_size + 1, 1]
        } else {
            null_size
        };
        let draw_arrays_data = if self.compute_data {
            [self.grid_size, self.grid_size, 1]
        } else {
            null_size
        };
        let index_dispatch_size = if self.compute_indices && indexed {
            [self.grid_size, self.grid_size, 1]
        } else {
            null_size
        };

        let data_dispatch_size = if indexed { draw_elements_data } else { draw_arrays_data };
        let dispatch_size: [i32; 3] = std::array::from_fn(|i| {
            command_dispatch_size[i]
                .max(data_dispatch_size[i])
                .max(index_dispatch_size[i])
        });

        // SAFETY: a linked compute program.
        unsafe { gl.use_program(program.program()) };
        check_gl(gl, "use compute shader")?;

        // setup buffers
        if self.compute_cmd {
            Self::alloc_ssbo(gl, 0, cmd, self.command_size() * self.num_draw_cmds);
        }

        if self.compute_data {
            let binding_point = if self.compute_cmd { 1 } else { 0 };
            Self::alloc_ssbo(
                gl,
                binding_point,
                data,
                (self.calc_draw_buffer_size() as usize * size_of::<[f32; 4]>()) as i32,
            );
        }

        if self.compute_indices {
            let binding_point = if self.compute_cmd && self.compute_data {
                2
            } else if self.compute_cmd || self.compute_data {
                1
            } else {
                0
            };
            Self::alloc_ssbo(
                gl,
                binding_point,
                indices,
                (self.calc_index_buffer_size() as usize * size_of::<u32>()) as i32,
            );
        }

        check_gl(gl, "setup buffers")?;

        // calculate
        // SAFETY: dispatches the program bound above.
        unsafe {
            gl.dispatch_compute(
                dispatch_size[0] as GLuint,
                dispatch_size[1] as GLuint,
                dispatch_size[2] as GLuint,
            )
        };

        check_gl(gl, "calculate")
    }

    /// `ComputeShaderGeneratedSeparateCase::runComputeShader`
    #[allow(clippy::too_many_arguments)]
    fn run_separate(
        &self,
        gl: &glw::Functions,
        cmd_program: Option<&ShaderProgram<'_>>,
        data_program: Option<&ShaderProgram<'_>>,
        index_program: Option<&ShaderProgram<'_>>,
        cmd: GLuint,
        data: GLuint,
        indices: GLuint,
    ) -> Result<(), TestError> {
        // Compute command
        if let (true, Some(program)) = (self.compute_cmd, cmd_program) {
            let command_dispatch_size = [self.num_draw_cmds, 1, 1];

            // SAFETY: a linked compute program.
            unsafe { gl.use_program(program.program()) };

            Self::alloc_ssbo(gl, 0, cmd, self.command_size() * self.num_draw_cmds);

            // SAFETY: dispatches the program bound above.
            unsafe {
                gl.dispatch_compute(
                    command_dispatch_size[0] as GLuint,
                    command_dispatch_size[1] as GLuint,
                    command_dispatch_size[2] as GLuint,
                )
            };

            check_gl(gl, "calculate cmd")?;
        }

        // Compute data
        if let (true, Some(program)) = (self.compute_data, data_program) {
            let data_dispatch_size = if self.draw_method == DrawMethod::DrawElements {
                [self.grid_size + 1, self.grid_size + 1, 1]
            } else {
                [self.grid_size, self.grid_size, 1]
            };

            // SAFETY: a linked compute program.
            unsafe { gl.use_program(program.program()) };

            Self::alloc_ssbo(
                gl,
                0,
                data,
                (self.calc_draw_buffer_size() as usize * size_of::<[f32; 4]>()) as i32,
            );

            // SAFETY: dispatches the program bound above.
            unsafe {
                gl.dispatch_compute(
                    data_dispatch_size[0] as GLuint,
                    data_dispatch_size[1] as GLuint,
                    data_dispatch_size[2] as GLuint,
                )
            };

            check_gl(gl, "calculate data")?;
        }

        // Compute indices
        if let (true, Some(program)) = (self.compute_indices, index_program) {
            let index_dispatch_size = [self.grid_size, self.grid_size, 1];

            // SAFETY: a linked compute program.
            unsafe { gl.use_program(program.program()) };

            Self::alloc_ssbo(
                gl,
                0,
                indices,
                (self.calc_index_buffer_size() as usize * size_of::<u32>()) as i32,
            );

            // SAFETY: dispatches the program bound above.
            unsafe {
                gl.dispatch_compute(
                    index_dispatch_size[0] as GLuint,
                    index_dispatch_size[1] as GLuint,
                    index_dispatch_size[2] as GLuint,
                )
            };

            check_gl(gl, "calculate indices")?;
        }

        check_gl(gl, "post dispatch")
    }

    /// `renderTo`
    fn render_to(
        &self,
        context: &Context,
        shader_program: &ShaderProgram<'_>,
        dst: &mut Surface,
        cmd: GLuint,
        data: GLuint,
        indices: GLuint,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        // SAFETY: NUL-terminated names against a linked program.
        let (position_loc, color_loc) = unsafe {
            (
                gl.get_attrib_location(shader_program.program(), c"a_position".as_ptr()),
                gl.get_attrib_location(shader_program.program(), c"a_color".as_ptr()),
            )
        };
        if position_loc == -1 || color_loc == -1 {
            return Err(TestError::Fail("a_position or a_color not found".to_string()));
        }
        let (position_loc, color_loc) = (position_loc as GLuint, color_loc as GLuint);

        let vao = VertexArray::new(gl);

        // SAFETY: names this case owns.
        unsafe {
            gl.bind_vertex_array(vao.get());

            // Setup buffers
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, data);
            gl.vertex_attrib_pointer(
                position_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                8 * size_of::<f32>() as i32,
                std::ptr::null(),
            );
            gl.vertex_attrib_pointer(
                color_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                8 * size_of::<f32>() as i32,
                (4 * size_of::<f32>()) as *const c_void,
            );
            gl.enable_vertex_attrib_array(position_loc);
            gl.enable_vertex_attrib_array(color_loc);

            if self.draw_method == DrawMethod::DrawElements {
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, indices);
            }

            gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, cmd);

            // draw
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.viewport(0, 0, dst.get_width(), dst.get_height());

            gl.use_program(shader_program.program());
            for draw_cmd_ndx in 0..self.num_draw_cmds {
                let offset = (draw_cmd_ndx * self.command_size()) as usize as *const c_void;

                match self.draw_method {
                    DrawMethod::DrawElements => {
                        gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, offset)
                    }
                    DrawMethod::DrawArrays => gl.draw_arrays_indirect(glw::GL_TRIANGLES, offset),
                }
            }
            gl.use_program(0);
        }

        // free
        drop(vao);
        check_gl(gl, "render")?;

        // SAFETY: nothing but a current context.
        unsafe { gl.finish() };
        check_gl(gl, "finish")?;

        glu::read_pixels(&context.render_context, 0, 0, &mut dst.get_access())?;
        check_gl(gl, "readPixels")
    }
}

impl TestCase for ComputeShaderGeneratedCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `init` of the base class and of the combined/separate subclass, then `iterate`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // generate basic shader
        let shader_program = ShaderProgram::new(
            gl,
            &ProgramSources::default()
                .with(ShaderType::Vertex, COLOR_VERTEX_SHADER_SOURCE)
                .with(ShaderType::Fragment, COLOR_FRAGMENT_SHADER_SOURCE),
        );
        if !shader_program.is_ok() {
            return Err(TestError::Fail("Failed to compile shader.".to_string()));
        }

        // generate compute shaders
        fn compute_program<'gl>(
            gl: &'gl glw::Functions,
            source: String,
            what: &str,
        ) -> Result<ShaderProgram<'gl>, TestError> {
            let program = ShaderProgram::new(gl, &ProgramSources::default().with(ShaderType::Compute, source));
            if !program.is_ok() {
                return Err(TestError::Fail(format!("Failed to compile {what}.")));
            }
            Ok(program)
        }

        let combined_program;
        let cmd_program;
        let data_program;
        let index_program;
        if self.separate {
            combined_program = None;
            cmd_program = if self.compute_cmd {
                Some(compute_program(
                    gl,
                    self.gen_compute_source(true, false, false),
                    "command compute shader",
                )?)
            } else {
                None
            };
            data_program = if self.compute_data {
                Some(compute_program(
                    gl,
                    self.gen_compute_source(false, true, false),
                    "data compute shader",
                )?)
            } else {
                None
            };
            index_program = if self.compute_indices {
                Some(compute_program(
                    gl,
                    self.gen_compute_source(false, false, true),
                    "data compute shader",
                )?)
            } else {
                None
            };
        } else {
            combined_program = Some(compute_program(
                gl,
                self.gen_compute_source(self.compute_cmd, self.compute_data, self.compute_indices),
                "compute shader",
            )?);
            cmd_program = None;
            data_program = None;
            index_program = None;
        }

        // gen buffers
        let cmd_buffer = Buffer::new(gl);
        let data_buffer = Buffer::new(gl);
        let index_buffer = Buffer::new(gl);

        // check the SSBO buffers are of legal size
        {
            let draw_buffer_element_size = size_of::<[f32; 4]>() as u64;
            let index_buffer_element_size = size_of::<u32>() as u64;
            let command_buffer_size = (self.command_size() * self.num_draw_cmds) as u64;
            let mut max_ssbo_size: i64 = 0;

            // SAFETY: one 64-bit integer of output.
            unsafe { gl.get_integer_64v(glw::GL_MAX_SHADER_STORAGE_BLOCK_SIZE, &mut max_ssbo_size) };
            let max_ssbo_size = max_ssbo_size as u64;

            if self.compute_data && u64::from(self.calc_draw_buffer_size()) * draw_buffer_element_size > max_ssbo_size {
                return Err(TestError::NotSupported(
                    "GL_MAX_SHADER_STORAGE_BLOCK_SIZE is too small for vertex attrib buffers".to_string(),
                ));
            }
            if self.compute_indices
                && u64::from(self.calc_index_buffer_size()) * index_buffer_element_size > max_ssbo_size
            {
                return Err(TestError::NotSupported(
                    "GL_MAX_SHADER_STORAGE_BLOCK_SIZE is too small for index buffers".to_string(),
                ));
            }
            if self.compute_cmd && command_buffer_size > max_ssbo_size {
                return Err(TestError::NotSupported(
                    "GL_MAX_SHADER_STORAGE_BLOCK_SIZE is too small for command buffers".to_string(),
                ));
            }
        }

        let render_target = context.render_target();
        let render_target_width = 1024.min(render_target.width);
        let render_target_height = 1024.min(render_target.height);
        let mut surface = Surface::new(render_target_width, render_target_height);

        // Gen command buffer
        if !self.compute_cmd {
            self.create_draw_command(gl, cmd_buffer.get())?;
        }

        // Gen data buffer
        if !self.compute_data {
            self.create_draw_data(gl, data_buffer.get())?;
        }

        // Gen index buffer
        if !self.compute_indices && self.draw_method == DrawMethod::DrawElements {
            self.create_draw_indices(gl, index_buffer.get())?;
        }

        // Run compute shader
        if let Some(program) = combined_program.as_ref() {
            self.run_combined(gl, program, cmd_buffer.get(), data_buffer.get(), index_buffer.get())?;
        } else {
            self.run_separate(
                gl,
                cmd_program.as_ref(),
                data_program.as_ref(),
                index_program.as_ref(),
                cmd_buffer.get(),
                data_buffer.get(),
                index_buffer.get(),
            )?;
        }

        // Ensure data is written to the buffers before we try to read it
        {
            let barriers: GLenum = (if self.compute_cmd {
                glw::GL_COMMAND_BARRIER_BIT
            } else {
                0
            }) | (if self.compute_data {
                glw::GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT
            } else {
                0
            }) | (if self.compute_indices {
                glw::GL_ELEMENT_ARRAY_BARRIER_BIT
            } else {
                0
            });

            // SAFETY: nothing but a current context.
            unsafe { gl.memory_barrier(barriers) };
        }

        // Draw from buffers
        self.render_to(
            context,
            &shader_program,
            &mut surface,
            cmd_buffer.get(),
            data_buffer.get(),
            index_buffer.get(),
        )?;

        // verify image
        // \note the green/yellow pattern is only for clarity. The test will only verify that all grid cells were drawn by looking for anything non-green/yellow.
        if verify_image_yellow_green(&surface) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Result image invalid"))
        }
    }
}

/// `ComputeShaderGeneratedGroup::init`
pub fn create_tests() -> TestCaseGroup {
    const GRID_SIZE: i32 = 8;

    let mut group = TestCaseGroup::new("compute_interop");
    let mut separate_group = TestCaseGroup::new("separate");
    let mut combined_group = TestCaseGroup::new("combined");
    let mut large_group = TestCaseGroup::new("large");

    let case = |name: &str,
                draw_method: DrawMethod,
                compute_cmd: bool,
                compute_data: bool,
                compute_indices: bool,
                grid_size: i32,
                num_draw_cmds: i32,
                separate: bool| {
        Box::new(ComputeShaderGeneratedCase {
            name: name.to_string(),
            draw_method,
            compute_cmd,
            compute_data,
            compute_indices,
            grid_size,
            num_draw_cmds,
            separate,
        }) as Box<dyn TestCase>
    };

    // .separate
    for (name, method, cmd, data, indices) in [
        ("drawarrays_compute_cmd", DrawMethod::DrawArrays, true, false, false),
        ("drawarrays_compute_data", DrawMethod::DrawArrays, false, true, false),
        (
            "drawarrays_compute_cmd_and_data",
            DrawMethod::DrawArrays,
            true,
            true,
            false,
        ),
        ("drawelements_compute_cmd", DrawMethod::DrawElements, true, false, false),
        (
            "drawelements_compute_data",
            DrawMethod::DrawElements,
            false,
            true,
            false,
        ),
        (
            "drawelements_compute_indices",
            DrawMethod::DrawElements,
            false,
            false,
            true,
        ),
        (
            "drawelements_compute_cmd_and_data",
            DrawMethod::DrawElements,
            true,
            true,
            false,
        ),
        (
            "drawelements_compute_cmd_and_indices",
            DrawMethod::DrawElements,
            true,
            false,
            true,
        ),
        (
            "drawelements_compute_data_and_indices",
            DrawMethod::DrawElements,
            false,
            true,
            true,
        ),
        (
            "drawelements_compute_cmd_and_data_and_indices",
            DrawMethod::DrawElements,
            true,
            true,
            true,
        ),
    ] {
        separate_group.add_child(case(name, method, cmd, data, indices, GRID_SIZE, 1, true));
    }

    // .combined
    for (name, method, cmd, data, indices) in [
        (
            "drawarrays_compute_cmd_and_data",
            DrawMethod::DrawArrays,
            true,
            true,
            false,
        ),
        (
            "drawelements_compute_cmd_and_data",
            DrawMethod::DrawElements,
            true,
            true,
            false,
        ),
        (
            "drawelements_compute_cmd_and_indices",
            DrawMethod::DrawElements,
            true,
            false,
            true,
        ),
        (
            "drawelements_compute_data_and_indices",
            DrawMethod::DrawElements,
            false,
            true,
            true,
        ),
        (
            "drawelements_compute_cmd_and_data_and_indices",
            DrawMethod::DrawElements,
            true,
            true,
            true,
        ),
    ] {
        combined_group.add_child(case(name, method, cmd, data, indices, GRID_SIZE, 1, false));
    }

    // .large
    const SPECS: [(i32, i32); 16] = [
        (100, 1),
        (200, 1),
        (500, 1),
        (1000, 1),
        (1200, 1),
        (1500, 1),
        (100, 8),
        (200, 8),
        (500, 8),
        (1000, 8),
        (1200, 8),
        (1500, 8),
        (100, 200),
        (200, 800),
        (500, 2500),
        (1000, 5000),
    ];
    const METHODS: [(DrawMethod, bool); 4] = [
        (DrawMethod::DrawArrays, true),
        (DrawMethod::DrawArrays, false),
        (DrawMethod::DrawElements, true),
        (DrawMethod::DrawElements, false),
    ];

    for (method, separate_compute) in METHODS {
        for (grid_size, num_draw_commands) in SPECS {
            let name = format!(
                "{}{}_grid_{grid_size}x{grid_size}_drawcount_{num_draw_commands}",
                if method == DrawMethod::DrawArrays {
                    "drawarrays"
                } else {
                    "drawelements"
                },
                if separate_compute { "_separate" } else { "_combined" }
            );

            let compute_indices = method == DrawMethod::DrawElements;
            large_group.add_child(case(
                &name,
                method,
                false,
                true,
                compute_indices,
                grid_size,
                num_draw_commands,
                separate_compute,
            ));
        }
    }

    group.add_child(separate_group);
    group.add_child(combined_group);
    group.add_child(large_group);
    group
}

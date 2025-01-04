// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `AdvancedUnsizedArrayLength` is the vertex-only case of the desktop file, `AdvancedUnsizedArrayLength2` and its 26 subclasses are `UnsizedArrayLength2` with a `Path`; the struct and block declarations are the upstream text (identical to the ES file's). Written without compiling.

use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};

#[derive(Clone, Copy, PartialEq)]
pub(super) enum Stage {
    Vertex,
    Fragment,
    Compute,
}

/// `BuildShaderPT`: the pass-through shader of the stage that is not under test (only the vertex and fragment stages exist here).
fn build_shader_pt(stage: Stage) -> String {
    let mut os = String::new();
    match stage {
        Stage::Vertex => os.push_str("\nvoid main() {\n  gl_Position = vec4(0,0,0,1);"),
        Stage::Fragment => os.push_str("\nvoid main() {"),
        Stage::Compute => {}
    }
    os.push_str("\n}");
    os
}

/// Links the program of `stage` built from `shader` (and the pass-through shader of the other graphics stage).
fn build_program(gl: &glw::Functions, stage: Stage, shader: &str) -> GLuint {
    match stage {
        Stage::Vertex => create_program(gl, shader, &build_shader_pt(Stage::Fragment)),
        Stage::Fragment => create_program(gl, &build_shader_pt(Stage::Vertex), shader),
        Stage::Compute => create_program_cs(gl, shader),
    }
}

/// The stage-specific wrapper around `decl` and `expr` shared by both classes.
fn wrap_stage(stage: Stage, decl: &str, expr: &str) -> String {
    let mut os = String::new();
    match stage {
        Stage::Vertex => {
            os.push_str(decl);
            os.push_str("\nvoid main() {\n  gl_Position = vec4(0,0,0,1);");
            os.push_str(expr);
        }
        Stage::Fragment => {
            os.push('\n');
            os.push_str(decl);
            os.push_str("\nvoid main() {");
            os.push_str(expr);
        }
        Stage::Compute => {
            os.push_str("\nlayout(local_size_x = 1) in;");
            os.push_str(decl);
            os.push_str("\nvoid main() {");
            os.push_str(expr);
        }
    }
    os.push_str("\n}");
    os
}

fn not_enough_blocks(gl: &glw::Functions, stage: Stage, buffers: i32) -> bool {
    stage == Stage::Vertex && !supported_in_vs(gl, buffers)
}

fn draw_or_dispatch(gl: &glw::Functions, stage: Stage, vertex_array: &mut GLuint) {
    if stage != Stage::Compute {
        gl!(gl.gen_vertex_arrays(1, vertex_array));
        gl!(gl.bind_vertex_array(*vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
    } else {
        gl!(gl.dispatch_compute(1, 1, 1));
    }
}

/// 2.7 AdvancedUnsizedArrayLength
#[derive(Default)]
pub(super) struct UnsizedArrayLength {
    program: GLuint,
    storage_buffer: [GLuint; 5],
    vertex_array: GLuint,
}

impl Subcase for UnsizedArrayLength {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_vs(gl, 5) {
            return Ok(NOT_SUPPORTED);
        }

        let glsl_vs = "\nlayout(std430, binding = 0) readonly buffer Input0 {\n  int g_input0[];\n};\nlayout(std430, binding = 1) readonly buffer Input1 {\n  int data[];\n} g_input1;\nlayout(std430, binding = 2) readonly buffer Input23 {\n  int data[];\n} g_input23[2];\nlayout(std430, binding = 4) buffer Output {\n  int g_length[4];\n  int g_length2;\n};\nvoid main() {\n  g_length[0] = g_input0.length();\n  g_length[1] = g_input1.data.length();\n  g_length[2] = g_input23[0].data.length();\n  g_length[3] = g_input23[1].data.length();\n  g_length2 = g_length.length();\n}";
        self.program = create_program(gl, glsl_vs, "");
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.gen_buffers(5, self.storage_buffer.as_mut_ptr()));

        let inputs: [&[GLint]; 4] = [&[1, 2, 3, 4, 5, 6, 7], &[1, 2, 3, 4, 5], &[1, 2, 3], &[1, 2, 3, 4]];
        for (i, data) in inputs.iter().enumerate() {
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint, self.storage_buffer[i]));
            buffer_data(gl, glw::GL_SHADER_STORAGE_BUFFER, data, glw::GL_DYNAMIC_COPY);
        }
        // output
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 4, self.storage_buffer[4]));
        buffer_data(
            gl,
            glw::GL_SHADER_STORAGE_BUFFER,
            &[0 as GLint; 5],
            glw::GL_DYNAMIC_COPY,
        );

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        // output
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[4]));
        let data = get_sub_data::<GLint>(gl, 0, 5);
        let mut status = true;
        for (i, expected) in [7, 5, 3, 4, 4].into_iter().enumerate() {
            if data[i] != expected {
                log::info!("Array {i} length is {} should be {expected}.", data[i]);
                status = false;
            }
        }
        Ok(if status { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(5, self.storage_buffer.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// `ElementType`
#[derive(Clone, Copy, PartialEq)]
pub(super) enum ElementType {
    Vector,
    MatrixCm,
    MatrixRm,
    Structure,
}

/// `BufferLayout`
#[derive(Clone, Copy, PartialEq)]
pub(super) enum BufferLayout {
    Std140,
    Std430,
    Shared,
    Packed,
}

/// `BindingSeq`
#[derive(Clone, Copy, PartialEq)]
pub(super) enum BindingSeq {
    BindBaseBefore,
    BindBaseAfter,
    BindRangeOffset,
    BindRangeSize,
}

/// The fields `AdvancedUnsizedArrayLength2` has and its subclasses' `SetPath` overrides set.
#[derive(Clone, Copy)]
pub(super) struct Path {
    pub stage: Stage,
    pub etype: ElementType,
    pub layout: BufferLayout,
    pub other_members: bool,
    pub bind_seq: BindingSeq,
    pub length_as_index: bool,
}

impl Default for Path {
    fn default() -> Self {
        Self {
            stage: Stage::Compute,
            etype: ElementType::Vector,
            layout: BufferLayout::Std430,
            other_members: false,
            bind_seq: BindingSeq::BindBaseBefore,
            length_as_index: false,
        }
    }
}

/// 2.7 AdvancedUnsizedArrayLength2
pub(super) struct UnsizedArrayLength2 {
    path: Path,
    program: GLuint,
    storage_buffer: [GLuint; 8],
    vertex_array: GLuint,
}

impl UnsizedArrayLength2 {
    pub(super) fn new(path: Path) -> Self {
        Self {
            path,
            program: 0,
            storage_buffer: [0; 8],
            vertex_array: 0,
        }
    }

    fn build_shader(&self) -> String {
        let Path {
            stage,
            etype,
            layout,
            other_members,
            length_as_index,
            ..
        } = self.path;
        let e: [[&str; 7]; 4] = [
            ["bvec3", "vec4", "ivec3", "ivec3", "uvec2", "vec2", "uvec4"],
            ["mat2", "mat3", "mat4", "mat4", "mat2x3", "mat3x2", "mat4x2"],
            ["mat2", "mat3", "mat4", "mat4", "mat2x3", "mat3x2", "mat4x2"],
            ["S0", "S1", "S2", "S2", "S4", "S5", "S6"],
        ];
        let e = e[etype as usize];
        let sd = "\nstruct S0 {\n  float f;\n  int i;\n  uint ui;\n  bool b;\n};\nstruct S1 {\n  ivec3 iv;\n  bvec2 bv;\n  vec4 v;\n  uvec2 uv;\n};\nstruct S2 {\n  mat2x2 m22;\n  mat4x4 m44;\n  mat2x3 m23;\n  mat4x2 m42;\n  mat3x4 m34;\n};\nstruct S4 {\n  float f[1];\n  int i[2];\n  uint ui[3];\n  bool b[4];\n  ivec3 iv[5];\n  bvec2 bv[6];\n  vec4  v[7];\n  uvec2 uv[8];\n};\nstruct S5 {\n  S0 s0;\n  S1 s1;\n  S2 s2;\n};\nstruct S6 {\n  S4 s4[3];\n};";
        let mut lo = ["std140", "std430", "shared", "packed"][layout as usize].to_string();
        if etype == ElementType::MatrixRm {
            lo.push_str(", row_major");
        }
        let pad = |index: usize, name: &str| {
            if other_members {
                format!("\n  {} {name};", e[index])
            } else {
                String::new()
            }
        };
        let decl = format!(
            "{sd}\nlayout({lo}) buffer;\nlayout(binding = 0) readonly buffer Input0 {{{}\n  {} g_input0[];\n}};\nlayout(binding = 1) readonly buffer Input1 {{{}\n  {} data[];\n}} g_input1;\nlayout(binding = 2) readonly buffer Input23 {{{}\n  {} data[];\n}} g_input23[2];\nlayout(binding = 4) buffer Output0 {{{}\n  {} data[];\n}} g_output0;\nlayout(binding = 5) readonly buffer Input4 {{{}\n  {} data[];\n}} g_input4;\nlayout(binding = 6) buffer Output1 {{{}\n  {} data[];\n}} g_output1;\nlayout(std430, binding = 7) buffer Output {{\n  int g_length[];\n}};",
            pad(0, "pad0"),
            e[0],
            pad(1, "pad1"),
            e[1],
            pad(2, "pad2"),
            e[2],
            pad(4, "pad4"),
            e[4],
            pad(5, "pad5"),
            e[5],
            pad(6, "pad6"),
            e[6],
        );
        let mut expr = "\n  g_length[0] = g_input0.length();\n  g_length[1] = g_input1.data.length();\n  g_length[2] = g_input23[0].data.length();\n  g_length[3] = g_input23[1].data.length();\n  g_length[4] = g_output0.data.length();\n  g_length[5] = g_input4.data.length();\n  g_length[6] = g_output1.data.length();".to_string();
        let lastelemexpr = "\n  g_output0.data[g_output0.data.length()-2] += g_output0.data[g_output0.data.length()-1];\n  g_output1.data[g_output1.data.length()-2] += g_output1.data[g_output1.data.length()-1];";
        if length_as_index {
            expr.push_str(lastelemexpr);
        }
        wrap_stage(stage, &decl, &expr)
    }
}

impl Subcase for UnsizedArrayLength2 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let Path {
            stage,
            etype,
            layout,
            other_members,
            bind_seq,
            length_as_index,
        } = self.path;
        const K_SIZE: usize = 100000;
        const K_BUFS: usize = 8;
        if not_enough_blocks(gl, stage, K_BUFS as i32) {
            return Ok(NOT_SUPPORTED);
        }
        let blocks_c = get_integer(gl, glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS);
        let min_a = get_integer(gl, glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT);
        if blocks_c < K_BUFS as GLint {
            return Ok(NOT_SUPPORTED);
        }
        self.program = build_program(gl, stage, &self.build_shader());
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        gl!(gl.gen_buffers(K_BUFS as i32, self.storage_buffer.as_mut_ptr()));
        let mut sizes: [i32; K_BUFS] = [7, 5, 3, 4, 23, 123, 419, 8];
        let columns: [[i32; K_BUFS]; 4] = [
            [1, 1, 1, 1, 1, 1, 1, 1], // vector: 1 col
            [2, 3, 4, 4, 2, 3, 4, 1], // mat: # of cols
            [2, 3, 4, 4, 3, 2, 2, 1], // RM mat: # of rows
            [1, 1, 1, 1, 1, 1, 1, 1], // structure: not used
        ];
        let scalars: [[i32; K_BUFS]; 4] = [
            [4, 4, 4, 4, 2, 2, 4, 1], // vector: size
            [2, 4, 4, 4, 4, 2, 2, 1], // matrix column_major: rows
            [2, 4, 4, 4, 2, 4, 4, 1], // matrix row_major: columns
            [1, 1, 1, 1, 1, 1, 1, 1], // structure: not used
        ];
        let mindw: [[i32; K_BUFS]; 4] = [
            [3, 4, 3, 3, 2, 2, 4, 1],
            [4, 9, 16, 16, 6, 6, 8, 1],
            [4, 9, 16, 16, 6, 6, 8, 1],
            [4, 11, 35, 35, 81, 127, 381, 1],
        ];
        let std430struct: [i32; K_BUFS] = [4, 16, 48, 48, 88, 68, 264, 1];
        let std140struct: [i32; K_BUFS] = [4, 16, 60, 60, 144, 80, 432, 1];
        let mut bufsize = [[0i32; 2]; K_BUFS];
        let data = vec![41 as GLint; K_SIZE * 4];
        let et = etype as usize;
        for i in 0..K_BUFS {
            if layout == BufferLayout::Std430 {
                bufsize[i][1] = 4 * columns[et][i] * scalars[et][i];
                if etype == ElementType::Structure {
                    bufsize[i][1] = 4 * std430struct[i];
                }
            } else if layout == BufferLayout::Std140 {
                bufsize[i][1] = 4 * columns[et][i] * 4;
                if etype == ElementType::Structure {
                    bufsize[i][1] = 4 * std140struct[i];
                }
            } else {
                bufsize[i][1] = 4 * mindw[et][i];
            }
            bufsize[i][0] = sizes[i] * bufsize[i][1];
            let buffer = self.storage_buffer[i];
            if i == K_BUFS - 1 || bind_seq == BindingSeq::BindBaseBefore {
                // never trim feedback storage
                gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint, buffer));
                gl!(gl.buffer_data(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    bufsize[i][0] as isize,
                    data.as_ptr().cast(),
                    glw::GL_DYNAMIC_COPY
                ));
            } else {
                gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer));
                gl!(gl.buffer_data(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    bufsize[i][0] as isize,
                    data.as_ptr().cast(),
                    glw::GL_DYNAMIC_COPY
                ));
                if bind_seq == BindingSeq::BindBaseAfter {
                    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint, buffer));
                } else if bind_seq == BindingSeq::BindRangeOffset && 2 * bufsize[i][1] >= min_a {
                    // without 2 elements
                    gl!(gl.bind_buffer_range(
                        glw::GL_SHADER_STORAGE_BUFFER,
                        i as GLuint,
                        buffer,
                        (2 * bufsize[i][1]) as isize,
                        (bufsize[i][0] - 2 * bufsize[i][1]) as isize
                    ));
                } else {
                    // bind_seq == BindRangeSize || 2 * bufsize[i][1] < min_a: without 2 elements
                    gl!(gl.bind_buffer_range(
                        glw::GL_SHADER_STORAGE_BUFFER,
                        i as GLuint,
                        buffer,
                        0,
                        (bufsize[i][0] - 2 * bufsize[i][1]) as isize
                    ));
                }
            }
        }

        draw_or_dispatch(gl, stage, &mut self.vertex_array);
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[K_BUFS - 1]));
        let Some(dataout) = map_read::<GLint>(gl, 0, sizes[K_BUFS - 1] as usize) else {
            return Ok(ERROR);
        };
        let mut status = true;
        for i in 0..K_BUFS - 1 {
            if other_members {
                sizes[i] -= 1; // space consumed by a pad
            }
            if bind_seq == BindingSeq::BindRangeSize || bind_seq == BindingSeq::BindRangeOffset {
                sizes[i] -= 2; // space constrained by offset of range size
            }
            if (layout == BufferLayout::Std140 || layout == BufferLayout::Std430) && dataout[i] != sizes[i] {
                log::info!("Array {i} length is {} should be {}", dataout[i], sizes[i]);
                status = false;
            }
            if (layout == BufferLayout::Packed || layout == BufferLayout::Shared) && dataout[i] > sizes[i] {
                log::info!(
                    "Array {i} length is {} should be not greater that {}",
                    dataout[i],
                    sizes[i]
                );
                status = false;
            }
        }
        unmap(gl);

        if length_as_index {
            for buffer_index in [4usize, 6] {
                gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[buffer_index]));
                let Some(dataout) = map_read::<GLint>(gl, 0, bufsize[buffer_index][0] as usize / 4) else {
                    return Ok(ERROR);
                };
                let i = ((sizes[buffer_index] - 2) * columns[et][buffer_index] * scalars[et][buffer_index]) as usize;
                if dataout[i] != 82 {
                    log::info!("Array {buffer_index} index {i} is {} should be 82", dataout[i]);
                    status = false;
                }
                unmap(gl);
            }
        }
        Ok(if status { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(8, self.storage_buffer.as_ptr()));
        if self.path.stage != Stage::Compute {
            gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        }
        Ok(NO_ERROR)
    }
}

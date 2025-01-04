// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderRendering.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `GeometryShaderRendering{Points,Lines,Triangles}Case` are one `Rendering`
// struct that matches on `Input`; the shader sources are generated into `rendering_shaders.rs`
// (scripts/gen_khr_geometry_shader_rendering.py).

use super::rendering_shaders as shaders;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Input {
    Points,
    Lines,
    LinesAdjacency,
    Triangles,
    TrianglesAdjacency,
}

/// `_shader_output_type`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Output {
    Points,
    LineStrip,
    TriangleStrip,
}

/// `GeometryShaderRenderingCase::_draw_call_type`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawCall {
    Arrays,
    ArraysInstanced,
    Elements,
    ElementsInstanced,
    RangeElements,
}

impl DrawCall {
    fn is_indexed(self) -> bool {
        matches!(self, Self::Elements | Self::ElementsInstanced | Self::RangeElements)
    }

    fn is_instanced(self) -> bool {
        matches!(self, Self::ArraysInstanced | Self::ElementsInstanced)
    }
}

/// `GeometryShaderRendering::init` builds one of these per (input, draw call mode, output) combination
pub(super) struct Rendering {
    pub ext_params: ExtParameters,
    pub name: String,
    pub input: Input,
    pub mode: GLenum,
    pub output: Output,
}

/// What a worker keeps for one of the instanced / non-instanced flavours
#[derive(Default)]
struct Buffers {
    raw: Vec<f32>,
    unordered_arrays: Vec<f32>,
    unordered_elements: Vec<u8>,
}

#[derive(Default)]
struct Resources {
    bo_ids: [[GLuint; 3]; 2],
    fbo_ids: [GLuint; 2],
    read_fbo_ids: [GLuint; 2],
    to_ids: [GLuint; 2],
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    vs_id: GLuint,
    vao_id: GLuint,
    rendering_target_size_location: i32,
    single_rendering_target_size_location: i32,
}

const RAW_ARRAYS: usize = 0;
const UNORDERED_ARRAYS: usize = 1;
const UNORDERED_ELEMENTS: usize = 2;

fn fail(message: String) -> TestError {
    log::info!("{message}");
    TestError::Fail("Data comparison failed".to_string())
}

fn pixel(data: &[u8], row_width: i32, x: i32, y: i32) -> [u8; 4] {
    if x < 0 || y < 0 {
        return [0; 4];
    }
    let start = (row_width * y + x * 4) as usize;
    match data.get(start..start + 4) {
        Some(rgba) => [rgba[0], rgba[1], rgba[2], rgba[3]],
        None => [0; 4],
    }
}

fn to_float(rgba: [u8; 4]) -> [f32; 4] {
    rgba.map(|channel| f32::from(channel) / 255.0)
}

fn differs(a: [f32; 4], b: [f32; 4], epsilon: f32) -> bool {
    (0..4).any(|channel| (a[channel] - b[channel]).abs() > epsilon)
}

fn compare_float_pixel(rendered: [u8; 4], reference: [f32; 4], x: i32, y: i32, epsilon: f32) -> Result<(), TestError> {
    let rendered = to_float(rendered);
    if differs(rendered, reference, epsilon) {
        return Err(fail(format!(
            "Rendered data at ({x}, {y}) equal ({}, {}, {}, {}) exceeds allowed epsilon when compared to reference data equal ({}, {}, {}, {}).",
            rendered[0], rendered[1], rendered[2], rendered[3], reference[0], reference[1], reference[2], reference[3]
        )));
    }
    Ok(())
}

impl Rendering {
    /// `getTestName`
    pub(super) fn test_name(input: Input, output: Output, mode: GLenum) -> &'static str {
        match (input, output, mode) {
            (Input::Points, Output::LineStrip, _) => "points_input_line_strip_output",
            (Input::Points, Output::Points, _) => "points_input_points_output",
            (Input::Points, Output::TriangleStrip, _) => "points_input_triangles_output",

            (Input::Lines, Output::LineStrip, glw::GL_LINES) => "lines_input_line_strip_output_lines_drawcall",
            (Input::Lines, Output::LineStrip, glw::GL_LINE_STRIP) => {
                "lines_input_line_strip_output_line_strip_drawcall"
            }
            (Input::Lines, Output::LineStrip, glw::GL_LINE_LOOP) => "lines_input_line_strip_output_line_loop_drawcall",
            (Input::Lines, Output::Points, glw::GL_LINES) => "lines_input_points_output_lines_drawcall",
            (Input::Lines, Output::Points, glw::GL_LINE_STRIP) => "lines_input_points_output_line_strip_drawcall",
            (Input::Lines, Output::Points, glw::GL_LINE_LOOP) => "lines_input_points_output_line_loop_drawcall",
            (Input::Lines, Output::TriangleStrip, glw::GL_LINES) => "lines_input_triangle_strip_output_lines_drawcall",
            (Input::Lines, Output::TriangleStrip, glw::GL_LINE_STRIP) => {
                "lines_input_triangle_strip_output_line_strip_drawcall"
            }
            (Input::Lines, Output::TriangleStrip, glw::GL_LINE_LOOP) => {
                "lines_input_triangle_strip_output_line_loop_drawcall"
            }

            (Input::LinesAdjacency, Output::LineStrip, glw::GL_LINES_ADJACENCY) => {
                "lines_with_adjacency_input_line_strip_output_lines_adjacency_drawcall"
            }
            (Input::LinesAdjacency, Output::LineStrip, glw::GL_LINE_STRIP_ADJACENCY) => {
                "lines_with_adjacency_input_line_strip_output_line_strip_drawcall"
            }
            (Input::LinesAdjacency, Output::Points, glw::GL_LINES_ADJACENCY) => {
                "lines_with_adjacency_input_points_output_lines_adjacency_drawcall"
            }
            (Input::LinesAdjacency, Output::Points, glw::GL_LINE_STRIP_ADJACENCY) => {
                "lines_with_adjacency_input_points_output_line_strip_drawcall"
            }
            (Input::LinesAdjacency, Output::TriangleStrip, glw::GL_LINES_ADJACENCY) => {
                "lines_with_adjacency_input_triangle_strip_output_lines_adjacency_drawcall"
            }
            (Input::LinesAdjacency, Output::TriangleStrip, glw::GL_LINE_STRIP_ADJACENCY) => {
                "lines_with_adjacency_input_triangle_strip_output_line_strip_drawcall"
            }

            (Input::Triangles, Output::LineStrip, glw::GL_TRIANGLES) => {
                "triangles_input_line_strip_output_triangles_drawcall"
            }
            (Input::Triangles, Output::LineStrip, glw::GL_TRIANGLE_FAN) => {
                "triangles_input_line_strip_output_triangle_fan_drawcall"
            }
            (Input::Triangles, Output::LineStrip, glw::GL_TRIANGLE_STRIP) => {
                "triangles_input_line_strip_output_triangle_strip_drawcall"
            }
            (Input::Triangles, Output::Points, glw::GL_TRIANGLES) => "triangles_input_points_output_triangles_drawcall",
            (Input::Triangles, Output::Points, glw::GL_TRIANGLE_FAN) => {
                "triangles_input_points_output_triangle_fan_drawcall"
            }
            (Input::Triangles, Output::Points, glw::GL_TRIANGLE_STRIP) => {
                "triangles_input_points_output_triangle_strip_drawcall"
            }
            (Input::Triangles, Output::TriangleStrip, glw::GL_TRIANGLES) => {
                "triangles_input_triangle_strip_output_triangles_drawcall"
            }
            (Input::Triangles, Output::TriangleStrip, glw::GL_TRIANGLE_FAN) => {
                "triangles_input_triangle_strip_output_triangle_fan_drawcall"
            }
            (Input::Triangles, Output::TriangleStrip, glw::GL_TRIANGLE_STRIP) => {
                "triangles_input_triangle_strip_output_triangle_strip_drawcall"
            }

            (Input::TrianglesAdjacency, Output::LineStrip, glw::GL_TRIANGLES_ADJACENCY) => {
                "triangles_with_adjacency_input_line_strip_output_triangles_adjacency_drawcall"
            }
            (Input::TrianglesAdjacency, Output::LineStrip, glw::GL_TRIANGLE_STRIP_ADJACENCY) => {
                "triangles_with_adjacency_input_line_strip_output_triangle_strip_adjacency_drawcall"
            }
            (Input::TrianglesAdjacency, Output::Points, glw::GL_TRIANGLES_ADJACENCY) => {
                "triangles_with_adjacency_input_points_output_triangles_adjacency_drawcall"
            }
            (Input::TrianglesAdjacency, Output::Points, glw::GL_TRIANGLE_STRIP_ADJACENCY) => {
                "triangles_with_adjacency_input_points_output_triangle_strip_adjacency_drawcall"
            }
            (Input::TrianglesAdjacency, Output::TriangleStrip, glw::GL_TRIANGLES_ADJACENCY) => {
                "triangles_with_adjacency_input_triangle_strip_output_triangles_adjacency_drawcall"
            }
            (Input::TrianglesAdjacency, Output::TriangleStrip, glw::GL_TRIANGLE_STRIP_ADJACENCY) => {
                "triangles_with_adjacency_input_triangle_strip_output_triangle_strip_adjacency_drawcall"
            }

            _ => panic!("Unrecognized draw call mode"),
        }
    }

    fn amount_of_draw_instances(&self) -> u32 {
        match self.input {
            Input::Points | Input::Lines | Input::LinesAdjacency => 4,
            Input::Triangles | Input::TrianglesAdjacency => 8,
        }
    }

    fn amount_of_vertices_per_instance(&self) -> u32 {
        match self.input {
            Input::Points => 8,
            Input::Lines | Input::LinesAdjacency => match self.mode {
                glw::GL_LINE_LOOP => 4,
                glw::GL_LINE_STRIP => 5,
                glw::GL_LINE_STRIP_ADJACENCY => 7,
                glw::GL_LINES => 8,
                _ => 16,
            },
            Input::Triangles | Input::TrianglesAdjacency => match self.mode {
                glw::GL_TRIANGLES => 3 * 4,
                glw::GL_TRIANGLES_ADJACENCY => 3 * 4 * 2,
                glw::GL_TRIANGLE_FAN => 6,
                glw::GL_TRIANGLE_STRIP => 7,
                _ => (5 + 2) * 2,
            },
        }
    }

    /// Every worker's element count per instance equals its vertex count per instance.
    fn amount_of_elements_per_instance(&self) -> u32 {
        self.amount_of_vertices_per_instance()
    }

    fn unordered_elements_max_index(&self) -> u8 {
        match self.input {
            Input::Points => 8,
            Input::Lines | Input::LinesAdjacency => 16,
            Input::Triangles | Input::TrianglesAdjacency => 24,
        }
    }

    /// `getRenderTargetSize`
    fn render_target_size(&self, n_instances: u32) -> (u32, u32) {
        match self.input {
            Input::Points => match self.output {
                Output::LineStrip => (56, 7 * n_instances),
                Output::Points => (38, 3 * n_instances + 2 * (n_instances - 1)),
                Output::TriangleStrip => (48, 6 * n_instances),
            },
            Input::Lines | Input::LinesAdjacency => (3 * 8 + 3 * 7, (3 * 8 + 3 * 7) * n_instances),
            Input::Triangles | Input::TrianglesAdjacency => (29, 29 * n_instances),
        }
    }

    fn fragment_shader_code(&self) -> String {
        match self.input {
            Input::Points => shaders::POINTS_FRAGMENTSHADERCODE_FS_CODE,
            Input::Lines | Input::LinesAdjacency => shaders::LINES_FRAGMENTSHADERCODE_FS_CODE,
            Input::Triangles | Input::TrianglesAdjacency => shaders::TRIANGLES_FRAGMENTSHADERCODE_FS_CODE,
        }
        .to_string()
    }

    fn geometry_shader_code(&self) -> String {
        match self.input {
            Input::Points => match self.output {
                Output::LineStrip => shaders::POINTS_GEOMETRYSHADERCODE_LINES_GS_CODE.to_string(),
                Output::Points => shaders::POINTS_GEOMETRYSHADERCODE_POINTS_GS_CODE.to_string(),
                Output::TriangleStrip => shaders::POINTS_GEOMETRYSHADERCODE_TRIANGLES_GS_CODE.to_string(),
            },
            Input::Lines | Input::LinesAdjacency => {
                let adjacency = self.input == Input::LinesAdjacency;
                let (preamble, main) = match (self.output, adjacency) {
                    (Output::LineStrip, true) => (
                        shaders::LINES_GEOMETRYSHADERCODE_LINES_ADJACENCY_IN_LINE_STRIP_OUT_GS_CODE_PREAMBLE,
                        shaders::LINES_GEOMETRYSHADERCODE_LINES_GS_CODE_MAIN,
                    ),
                    (Output::LineStrip, false) => (
                        shaders::LINES_GEOMETRYSHADERCODE_LINES_IN_LINE_STRIP_OUT_GS_CODE_PREAMBLE,
                        shaders::LINES_GEOMETRYSHADERCODE_LINES_GS_CODE_MAIN,
                    ),
                    (Output::Points, true) => (
                        shaders::LINES_GEOMETRYSHADERCODE_LINES_ADJACENCY_IN_POINTS_OUT_GS_CODE_PREAMBLE,
                        shaders::LINES_GEOMETRYSHADERCODE_POINTS_GS_CODE_MAIN,
                    ),
                    (Output::Points, false) => (
                        shaders::LINES_GEOMETRYSHADERCODE_LINES_IN_POINTS_OUT_GS_CODE_PREAMBLE,
                        shaders::LINES_GEOMETRYSHADERCODE_POINTS_GS_CODE_MAIN,
                    ),
                    (Output::TriangleStrip, true) => (
                        shaders::LINES_GEOMETRYSHADERCODE_LINES_ADJACENCY_IN_TRIANGLE_STRIP_OUT_GS_CODE_PREAMBLE,
                        shaders::LINES_GEOMETRYSHADERCODE_TRIANGLES_GS_CODE_MAIN,
                    ),
                    (Output::TriangleStrip, false) => (
                        shaders::LINES_GEOMETRYSHADERCODE_LINES_IN_TRIANGLE_STRIP_OUT_GS_CODE_PREAMBLE,
                        shaders::LINES_GEOMETRYSHADERCODE_TRIANGLES_GS_CODE_MAIN,
                    ),
                };
                format!("{preamble}{main}")
            }
            Input::Triangles | Input::TrianglesAdjacency => {
                let adjacency = self.input == Input::TrianglesAdjacency;
                let (preamble, main) = match (self.output, adjacency) {
                    (Output::Points, true) => (
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_TRIANGLES_ADJACENCY_IN_POINTS_OUT_PREAMBLE,
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_POINTS_CODE,
                    ),
                    (Output::Points, false) => (
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_TRIANGLES_IN_POINTS_OUT_PREAMBLE,
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_POINTS_CODE,
                    ),
                    (Output::LineStrip, true) => (
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_TRIANGLES_ADJACENCY_IN_LINES_OUT_PREAMBLE,
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_LINES_CODE,
                    ),
                    (Output::LineStrip, false) => (
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_TRIANGLES_IN_LINES_OUT_PREAMBLE,
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_LINES_CODE,
                    ),
                    (Output::TriangleStrip, true) => (
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_TRIANGLES_ADJACENCY_IN_TRIANGLES_OUT_PREAMBLE,
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_TRIANGLES_CODE,
                    ),
                    (Output::TriangleStrip, false) => (
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_TRIANGLES_IN_TRIANGLES_OUT_PREAMBLE,
                        shaders::TRIANGLES_GEOMETRYSHADERCODE_GS_TRIANGLES_CODE,
                    ),
                };
                format!("{preamble}{main}")
            }
        }
    }

    fn vertex_shader_code(&self) -> String {
        match self.input {
            Input::Points => match self.output {
                Output::LineStrip => shaders::POINTS_VERTEXSHADERCODE_LINES_VS_CODE,
                Output::Points => shaders::POINTS_VERTEXSHADERCODE_POINTS_VS_CODE,
                Output::TriangleStrip => shaders::POINTS_VERTEXSHADERCODE_TRIANGLES_VS_CODE,
            },
            Input::Lines | Input::LinesAdjacency => shaders::LINES_VERTEXSHADERCODE_VS_CODE,
            Input::Triangles | Input::TrianglesAdjacency => shaders::TRIANGLES_VERTEXSHADERCODE_VS_CODE,
        }
        .to_string()
    }

    /// The constructors of the three worker classes: the vertex and index data of one flavour.
    fn build_buffers(&self, is_instanced: bool) -> Buffers {
        match self.input {
            Input::Points => self.build_points_buffers(),
            Input::Lines | Input::LinesAdjacency => self.build_lines_buffers(is_instanced),
            Input::Triangles | Input::TrianglesAdjacency => self.build_triangles_buffers(is_instanced),
        }
    }

    fn build_points_buffers(&self) -> Buffers {
        let (width, height) = self.render_target_size(1);
        let (width, height) = (width as f32, height as f32);

        let mut raw = Vec::with_capacity(8 * 4);
        for n_point in 0..8u32 {
            let (x, y) = match self.output {
                Output::LineStrip => (
                    -1.0 + (((3 + 7 * n_point) as f32 + 0.5) / width) * 2.0,
                    -1.0 + ((3.0f32 + 0.5) / height) * 2.0,
                ),
                Output::Points => (
                    -1.0 + (((1 + 5 * n_point) as f32 + 0.5) / width) * 2.0,
                    -1.0 + ((1.5f32 + 0.5) / height) * 2.0,
                ),
                Output::TriangleStrip => (-1.0 + (((6 * n_point) as f32 + 0.5) / width) * 2.0, -1.0),
            };
            raw.extend_from_slice(&[x, y, 0.0, 1.0]);
        }

        let mut unordered_arrays = vec![0.0f32; 8 * 4];
        for n_point in 0..8usize {
            let source = (8 - n_point - 1) * 4;
            unordered_arrays[n_point * 4..n_point * 4 + 4].copy_from_slice(&raw[source..source + 4]);
        }
        let unordered_elements = (0..8u32)
            .map(|n_point| ((n_point * 2) % 8 + n_point / 4) as u8)
            .collect();

        Buffers {
            raw,
            unordered_arrays,
            unordered_elements,
        }
    }

    fn build_lines_buffers(&self, is_instanced: bool) -> Buffers {
        let n_instances = if is_instanced {
            self.amount_of_draw_instances()
        } else {
            1
        };
        let (render_target_width, render_target_height) = self.render_target_size(n_instances);
        let dx = 2.0f32 / render_target_width as f32;
        let dy = 2.0f32 / render_target_height as f32;
        let (_, single_rt_height) = self.render_target_size(1);
        let (_, whole_rt_height) = self.render_target_size(self.amount_of_draw_instances());

        let (start_y, end_y, w) = if n_instances != 1 {
            (0.0f32, 0.0f32, single_rt_height as f32 / whole_rt_height as f32)
        } else {
            (-1.0f32, 1.0f32, 1.0f32)
        };

        let multiplier = if self.output == Output::TriangleStrip {
            0.0f32
        } else {
            1.5f32
        };
        let quad_coordinates: [[f32; 4]; 4] = [
            [-1.0 + multiplier * dx, start_y + multiplier * dy, 0.0, w],
            [1.0 - multiplier * dx, start_y + multiplier * dy, 0.0, w],
            [1.0 - multiplier * dx, end_y - multiplier * dy, 1.0, w],
            [-1.0 + multiplier * dx, end_y - multiplier * dy, 1.0, w],
        ];

        let mode = self.mode;
        let is_strip_or_loop = matches!(
            mode,
            glw::GL_LINE_STRIP | glw::GL_LINE_STRIP_ADJACENCY | glw::GL_LINE_LOOP
        );
        let mut raw = Vec::new();
        for n_line_segment in 0..4usize {
            let coordinate0 = quad_coordinates[(4 + n_line_segment - 1) % 4];
            let coordinate1 = quad_coordinates[n_line_segment % 4];
            let coordinate2 = quad_coordinates[(n_line_segment + 1) % 4];
            let coordinate3 = quad_coordinates[(n_line_segment + 2) % 4];

            if mode == glw::GL_LINES_ADJACENCY || (mode == glw::GL_LINE_STRIP_ADJACENCY && n_line_segment == 0) {
                raw.extend_from_slice(&coordinate0);
            }
            if !is_strip_or_loop || n_line_segment == 0 {
                raw.extend_from_slice(&coordinate1);
            }
            if mode != glw::GL_LINE_LOOP || n_line_segment != 3 {
                raw.extend_from_slice(&coordinate2);
            }
            if mode == glw::GL_LINES_ADJACENCY || (mode == glw::GL_LINE_STRIP_ADJACENCY && n_line_segment == 3) {
                raw.extend_from_slice(&coordinate3);
            }
        }

        let mut unordered_arrays;
        let mut unordered_elements: Vec<u8>;
        match mode {
            glw::GL_LINE_LOOP | glw::GL_LINE_STRIP | glw::GL_LINES => {
                let n_points = match mode {
                    glw::GL_LINE_LOOP => 4usize,
                    glw::GL_LINE_STRIP => 5,
                    _ => 8,
                };
                unordered_arrays = vec![0.0f32; n_points * 4];
                unordered_elements = vec![0u8; n_points];
                for index in 0..n_points {
                    let new_index = match mode {
                        glw::GL_LINE_LOOP => 3 - index,
                        glw::GL_LINE_STRIP => 4 - index,
                        _ => 7 - ((index / 2) * 2 + (index + 1) % 2),
                    };
                    unordered_elements[index] = new_index as u8;
                    unordered_arrays[new_index * 4..new_index * 4 + 4].copy_from_slice(&raw[index * 4..index * 4 + 4]);
                }
            }
            _ => {
                unordered_arrays = Vec::with_capacity(16);
                for coordinate in &quad_coordinates {
                    unordered_arrays.extend_from_slice(coordinate);
                }
                unordered_elements = Vec::new();
                for n in 0..4usize {
                    let component0_index = ((n + 4 - 1) % 4) as u8;
                    let component1_index = (n % 4) as u8;
                    let component2_index = ((n + 1) % 4) as u8;
                    let component3_index = ((n + 2) % 4) as u8;

                    if mode == glw::GL_LINE_STRIP_ADJACENCY {
                        if n == 0 {
                            unordered_elements.push(component0_index);
                        }
                        unordered_elements.push(component1_index);
                        if n == 3 {
                            unordered_elements.push(component2_index);
                            unordered_elements.push(component3_index);
                        }
                    } else {
                        unordered_elements.extend_from_slice(&[
                            component0_index,
                            component1_index,
                            component2_index,
                            component3_index,
                        ]);
                    }
                }
            }
        }

        Buffers {
            raw,
            unordered_arrays,
            unordered_elements,
        }
    }

    fn build_triangles_buffers(&self, is_instanced: bool) -> Buffers {
        let (_, single_rt_height) = self.render_target_size(1);
        let (_, whole_rt_height) = self.render_target_size(self.amount_of_draw_instances());
        let n_instances = if is_instanced {
            self.amount_of_draw_instances()
        } else {
            1
        };
        let (render_target_width, render_target_height) = self.render_target_size(n_instances);
        let dx = 2.0f32 / render_target_width as f32;
        let dy = 2.0f32 / render_target_height as f32;

        let (start_y, end_y, mid_y) = if is_instanced {
            let start_y = -1.0f32;
            let end_y = start_y + single_rt_height as f32 / whole_rt_height as f32 * 2.0;
            (start_y, end_y, start_y + (end_y - start_y) * 0.5)
        } else {
            (-1.0f32, 1.0f32, 0.0f32)
        };
        let (dx_multiplier, dy_multiplier) = if self.output == Output::TriangleStrip {
            (0.0f32, 0.0f32)
        } else {
            (1.5f32, 1.5f32)
        };

        let data_coordinates: [[f32; 4]; 5] = [
            [0.0, mid_y, 0.0, 1.0],
            [-1.0 + dx * dx_multiplier, mid_y, 0.0, 0.0],
            [0.0, start_y + dy * dy_multiplier, 0.0, 0.0],
            [1.0 - dx * dx_multiplier, mid_y, 0.0, 0.0],
            [0.0, end_y - dy * dy_multiplier, 0.0, 0.0],
        ];

        let raw_array_indices: &[usize] = match self.mode {
            glw::GL_TRIANGLES => &[0, 1, 2, 0, 2, 3, 0, 3, 4, 0, 4, 1],
            glw::GL_TRIANGLES_ADJACENCY => &[0, 0, 1, 0, 2, 0, 0, 0, 2, 0, 3, 0, 0, 0, 3, 0, 4, 0, 0, 0, 4, 0, 1, 0],
            glw::GL_TRIANGLE_FAN => &[0, 1, 2, 3, 4, 1],
            glw::GL_TRIANGLE_STRIP => &[1, 0, 2, 3, 0, 4, 1],
            _ => &[1, 0, 0, 0, 2, 0, 3, 0, 0, 0, 4, 0, 1, 0],
        };
        let n_raw_array_indices = raw_array_indices.len();

        let mut raw = Vec::with_capacity(n_raw_array_indices * 4);
        for &index in raw_array_indices {
            raw.extend_from_slice(&data_coordinates[index]);
        }

        let mut unordered_arrays = vec![0.0f32; n_raw_array_indices * 4];
        for index in 0..n_raw_array_indices {
            let target = 4 * (n_raw_array_indices - 1 - index);
            unordered_arrays[target..target + 4].copy_from_slice(&raw[4 * index..4 * index + 4]);
        }
        let unordered_elements = (0..n_raw_array_indices)
            .map(|n| (n_raw_array_indices - 1 - n) as u8)
            .collect();

        Buffers {
            raw,
            unordered_arrays,
            unordered_elements,
        }
    }

    /// `GeometryShaderRenderingCase::initTest`
    fn init_test(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &mut Resources,
    ) -> Result<[Buffers; 2], TestError> {
        let gl = context.gl();

        let fs_code = self.fragment_shader_code();
        let gs_code = self.geometry_shader_code();
        let vs_code = self.vertex_shader_code();
        let n_instances = self.amount_of_draw_instances();

        gl!(gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1));
        gl!(gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1));

        for buffers in resources.bo_ids.iter_mut() {
            gl!(gl.gen_buffers(buffers.len() as i32, buffers.as_mut_ptr()));
        }

        let buffers = [self.build_buffers(false), self.build_buffers(true)];

        for n in 0..2usize {
            let is_instanced = n == 1;
            let (to_width, to_height) = self.render_target_size(if is_instanced { n_instances } else { 1 });

            gl!(gl.gen_textures(1, &mut resources.to_ids[n]));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.to_ids[n]));
            gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, to_width as i32, to_height as i32));
            glu::expect_no_error(gl, "Could not configure a 2D texture object")?;

            gl!(gl.gen_framebuffers(1, &mut resources.fbo_ids[n]));
            gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, resources.fbo_ids[n]));
            gl!(gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                resources.to_ids[n],
                0
            ));
            glu::expect_no_error(gl, "Could not configure draw framebuffer object")?;
            if gl!(gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER)) != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail(
                    "Draw framebuffer is reported to be incomplete".to_string(),
                ));
            }

            gl!(gl.gen_framebuffers(1, &mut resources.read_fbo_ids[n]));
            gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resources.read_fbo_ids[n]));
            gl!(gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                resources.to_ids[n],
                0
            ));
            glu::expect_no_error(gl, "Could not configure read framebuffer object")?;
            if gl!(gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER)) != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail(
                    "Read framebuffer is reported to be incomplete".to_string(),
                ));
            }

            let flavour = &buffers[n];
            let uploads: [(usize, *const std::ffi::c_void, usize); 3] = [
                (
                    RAW_ARRAYS,
                    flavour.raw.as_ptr().cast(),
                    flavour.raw.len() * std::mem::size_of::<f32>(),
                ),
                (
                    UNORDERED_ARRAYS,
                    flavour.unordered_arrays.as_ptr().cast(),
                    flavour.unordered_arrays.len() * std::mem::size_of::<f32>(),
                ),
                (
                    UNORDERED_ELEMENTS,
                    flavour.unordered_elements.as_ptr().cast(),
                    flavour.unordered_elements.len(),
                ),
            ];
            for (kind, data, size) in uploads {
                gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.bo_ids[n][kind]));
                gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, size as isize, data, glw::GL_STATIC_COPY));
            }
        }
        glu::expect_no_error(gl, "Could not configure test buffer objects")?;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Could not generate & bind a vertex array object")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.po_id = gl!(gl.create_program());
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "Could not create shader/program objects")?;

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[fs_code.as_str()]),
                ShaderBody::Source(resources.gs_id, &[gs_code.as_str()]),
                ShaderBody::Source(resources.vs_id, &[vs_code.as_str()]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Could not build shader program".to_string()));
        }

        resources.rendering_target_size_location =
            gl!(gl.get_uniform_location(resources.po_id, c"renderingTargetSize".as_ptr()));
        resources.single_rendering_target_size_location =
            gl!(gl.get_uniform_location(resources.po_id, c"singleRenderingTargetSize".as_ptr()));
        Ok(buffers)
    }

    /// `GeometryShaderRenderingLinesCase::setUniformsBeforeDrawCall` and the Triangles counterpart
    fn set_uniforms_before_draw_call(
        &self,
        gl: &glw::Functions,
        po_id: GLuint,
        draw: DrawCall,
    ) -> Result<(), TestError> {
        let location = |name: &std::ffi::CStr| gl!(gl.get_uniform_location(po_id, name.as_ptr()));
        let set = |location: i32, value: bool| gl!(gl.uniform_1i(location, i32::from(value)));

        match self.input {
            Input::Points => {}
            Input::Lines | Input::LinesAdjacency => {
                let is_gl_line_loop_draw_call = location(c"is_gl_line_loop_draw_call");
                let is_gl_line_strip_adjacency_draw_call = location(c"is_gl_line_strip_adjacency_draw_call");
                let is_gl_lines_adjacency_draw_call = location(c"is_gl_lines_adjacency_draw_call");
                let is_gl_lines_draw_call = location(c"is_gl_lines_draw_call");
                let is_indexed_draw_call = location(c"is_indexed_draw_call");

                for location in [
                    is_gl_line_loop_draw_call,
                    is_gl_line_strip_adjacency_draw_call,
                    is_gl_lines_adjacency_draw_call,
                    is_gl_lines_draw_call,
                    is_indexed_draw_call,
                ] {
                    if location == -1 {
                        return Err(TestError::Fail(
                            "Check failed: a draw call mode uniform is inactive".to_string(),
                        ));
                    }
                }

                set(is_indexed_draw_call, draw.is_indexed());
                set(is_gl_line_loop_draw_call, self.mode == glw::GL_LINE_LOOP);
                set(
                    is_gl_line_strip_adjacency_draw_call,
                    self.mode == glw::GL_LINE_STRIP_ADJACENCY,
                );
                set(is_gl_lines_adjacency_draw_call, self.mode == glw::GL_LINES_ADJACENCY);
                set(is_gl_lines_draw_call, self.mode == glw::GL_LINES);
            }
            Input::Triangles | Input::TrianglesAdjacency => {
                set(location(c"is_lines_output"), self.output == Output::LineStrip);
                set(location(c"is_points_output"), self.output == Output::Points);
                set(location(c"is_triangle_fan_input"), self.mode == glw::GL_TRIANGLE_FAN);
                set(
                    location(c"is_triangle_strip_input"),
                    self.mode == glw::GL_TRIANGLE_STRIP,
                );
                set(
                    location(c"is_triangles_adjacency_input"),
                    self.mode == glw::GL_TRIANGLES_ADJACENCY,
                );
                set(
                    location(c"is_triangle_strip_adjacency_input"),
                    self.mode == glw::GL_TRIANGLE_STRIP_ADJACENCY,
                );
                set(location(c"is_triangles_input"), self.mode == glw::GL_TRIANGLES);
                set(location(c"is_triangles_output"), self.output == Output::TriangleStrip);
                set(location(c"is_indexed_draw_call"), draw.is_indexed());
                set(location(c"is_instanced_draw_call"), draw.is_instanced());
            }
        }
        Ok(())
    }

    /// `GeometryShaderRenderingCase::executeTest`
    fn execute_test(
        &self,
        context: &Context,
        resources: &Resources,
        buffers: &[Buffers; 2],
        draw: DrawCall,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let index_type = glw::GL_UNSIGNED_BYTE;
        let max_elements_index = self.unordered_elements_max_index();
        let min_elements_index = 0u8;
        let mode = self.mode_for_draw();
        let n_elements = self.amount_of_elements_per_instance() as i32;
        let n_vertices = self.amount_of_vertices_per_instance() as i32;
        let position_attribute_location = gl!(gl.get_attrib_location(resources.po_id, c"position".as_ptr()));

        let (flavour, n_instances) = if draw.is_instanced() {
            (1usize, self.amount_of_draw_instances())
        } else {
            (0usize, 1u32)
        };
        let draw_fbo_id = resources.fbo_ids[flavour];
        let read_fbo_id = resources.read_fbo_ids[flavour];

        let (rt_width, rt_height) = self.render_target_size(n_instances);
        let (single_rt_width, single_rt_height) = self.render_target_size(1);

        let array_buffer = match draw {
            DrawCall::Arrays => resources.bo_ids[0][RAW_ARRAYS],
            DrawCall::ArraysInstanced => resources.bo_ids[1][RAW_ARRAYS],
            DrawCall::ElementsInstanced => resources.bo_ids[1][UNORDERED_ARRAYS],
            DrawCall::Elements | DrawCall::RangeElements => resources.bo_ids[0][UNORDERED_ARRAYS],
        };
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buffer));
        gl!(gl.vertex_attrib_pointer(
            position_attribute_location as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null()
        ));
        gl!(gl.enable_vertex_attrib_array(position_attribute_location as GLuint));

        let element_buffer = match draw {
            DrawCall::Arrays | DrawCall::ArraysInstanced => 0,
            DrawCall::ElementsInstanced => resources.bo_ids[1][UNORDERED_ELEMENTS],
            DrawCall::Elements | DrawCall::RangeElements => resources.bo_ids[0][UNORDERED_ELEMENTS],
        };
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_buffer));

        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, draw_fbo_id));
        gl!(gl.viewport(0, 0, rt_width as i32, rt_height as i32));
        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        glu::expect_no_error(gl, "Test set-up failed.")?;

        gl!(gl.use_program(resources.po_id));
        gl!(gl.uniform_2i(
            resources.rendering_target_size_location,
            rt_width as i32,
            rt_height as i32
        ));
        gl!(gl.uniform_2i(
            resources.single_rendering_target_size_location,
            single_rt_width as i32,
            single_rt_height as i32
        ));

        self.set_uniforms_before_draw_call(gl, resources.po_id, draw)?;

        match draw {
            DrawCall::Arrays => gl!(gl.draw_arrays(mode, 0, n_vertices)),
            DrawCall::ArraysInstanced => gl!(gl.draw_arrays_instanced(mode, 0, n_vertices, n_instances as i32)),
            DrawCall::Elements => gl!(gl.draw_elements(mode, n_elements, index_type, std::ptr::null())),
            DrawCall::ElementsInstanced => {
                gl!(gl.draw_elements_instanced(mode, n_elements, index_type, std::ptr::null(), n_instances as i32))
            }
            DrawCall::RangeElements => gl!(gl.draw_range_elements(
                mode,
                u32::from(min_elements_index),
                u32::from(max_elements_index),
                n_elements,
                index_type,
                std::ptr::null()
            )),
        }
        glu::expect_no_error(gl, "Draw call failed.")?;

        let mut rendered_data = vec![0u8; (rt_height * rt_width * 4) as usize];
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, read_fbo_id));
        gl!(gl.read_pixels(
            0,
            0,
            rt_width as i32,
            rt_height as i32,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            rendered_data.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "glReadPixels() call failed")?;

        for n_instance in 0..n_instances {
            self.verify(draw, n_instance, &rendered_data, &buffers[0])?;
        }
        Ok(())
    }

    fn mode_for_draw(&self) -> GLenum {
        match self.input {
            Input::Points => glw::GL_POINTS,
            _ => self.mode,
        }
    }

    fn verify(&self, draw: DrawCall, instance_id: u32, data: &[u8], buffers: &Buffers) -> Result<(), TestError> {
        match self.input {
            Input::Points => self.verify_points(draw, instance_id as i32, data, buffers),
            Input::Lines | Input::LinesAdjacency => self.verify_lines(draw, instance_id as i32, data),
            Input::Triangles | Input::TrianglesAdjacency => self.verify_triangles(draw, instance_id as i32, data),
        }
    }

    /// `GeometryShaderRenderingPointsCase::verify`
    fn verify_points(&self, draw: DrawCall, instance_id: i32, data: &[u8], buffers: &Buffers) -> Result<(), TestError> {
        let ref_data: [u8; 36] = [
            255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255, 255, 255, 0, 0, 255, 0, 255, 0, 255, 0, 0, 255,
            255, 255, 255, 0, 255, 255, 0, 255,
        ];
        let ub = |value: f32| (value * 255.0) as u8;
        let ref_data_triangle_strip: [u8; 32] = [
            ub(0.1),
            ub(0.8),
            0,
            0,
            ub(0.2),
            ub(0.7),
            0,
            0,
            ub(0.3),
            ub(0.6),
            255,
            0,
            ub(0.4),
            ub(0.5),
            0,
            255,
            ub(0.5),
            ub(0.4),
            0,
            0,
            ub(0.6),
            ub(0.3),
            255,
            0,
            ub(0.7),
            ub(0.2),
            0,
            255,
            ub(0.8),
            ub(0.1),
            255,
            0,
        ];

        let (rt_width, _) = if draw.is_instanced() {
            self.render_target_size(self.amount_of_draw_instances())
        } else {
            self.render_target_size(1)
        };
        let rt_width = rt_width as i32;
        let indexed = draw.is_indexed();

        match self.output {
            Output::LineStrip => {
                for n_point in 0..8i32 {
                    let row_width = rt_width * 4;
                    let sample_region_edge_px = 5;

                    for n_edge in 0..4 {
                        let (dx, dy, x_start, y_start) = match n_edge {
                            0 => (1, 0, 1, 1),
                            1 => (0, 1, 5, 1),
                            2 => (-1, 0, 5, 5),
                            _ => (0, -1, 1, 5),
                        };

                        let (reference_index, mut x, mut y) = if !indexed {
                            (n_point, x_start + n_point * 7, y_start + instance_id * 7)
                        } else {
                            let index = i32::from(buffers.unordered_elements[n_point as usize]);
                            (8 - 1 - index, x_start + index * 7, y_start + instance_id * 7)
                        };
                        let reference_data =
                            &ref_data[(reference_index * 4) as usize..(reference_index * 4 + 4) as usize];

                        for _ in 0..sample_region_edge_px {
                            let rendered_data = pixel(data, row_width, x, y);
                            if rendered_data.as_slice() != reference_data {
                                return Err(fail(format!(
                                    "At            ({x}, {y}), rendered data ({}, {}, {}, {}) is different from reference data ({}, {}, {}, {})",
                                    rendered_data[0],
                                    rendered_data[1],
                                    rendered_data[2],
                                    rendered_data[3],
                                    reference_data[0],
                                    reference_data[1],
                                    reference_data[2],
                                    reference_data[3]
                                )));
                            }
                            x += dx;
                            y += dy;
                        }
                    }
                }
            }
            Output::Points => {
                let sample_region_width_px = 5;
                for n in 0..8i32 {
                    let (x, y, reference_index) = if indexed {
                        let index = i32::from(buffers.unordered_elements[n as usize]);
                        (index * sample_region_width_px + 1, instance_id * 5 + 1, 8 - 1 - index)
                    } else {
                        (n * sample_region_width_px + 1, instance_id * 5 + 1, n)
                    };
                    let reference_data = &ref_data[(reference_index * 4) as usize..(reference_index * 4 + 4) as usize];
                    let rendered_data = pixel(data, rt_width * 4, x, y);

                    if rendered_data.as_slice() != reference_data {
                        return Err(fail(format!(
                            "Reference data: [{}, {}, {}, {}] for pixel at ({x}, {y}) does not match  [{}, {}, {}, {}).",
                            reference_data[0],
                            reference_data[1],
                            reference_data[2],
                            reference_data[3],
                            rendered_data[0],
                            rendered_data[1],
                            rendered_data[2],
                            rendered_data[3]
                        )));
                    }
                }
            }
            Output::TriangleStrip => {
                for n_point in 0..8i32 {
                    let epsilon = 1i32;
                    let point_y = 6 * instance_id;
                    let row_width = rt_width * 4;

                    let (point_x, reference_index) = if indexed {
                        let index = i32::from(buffers.unordered_elements[n_point as usize]);
                        (6 * index, 8 - 1 - index)
                    } else {
                        (6 * n_point, n_point)
                    };
                    let reference_data =
                        &ref_data_triangle_strip[(reference_index * 4) as usize..(reference_index * 4 + 4) as usize];

                    let t1 = [point_x, point_y + 6, point_x, point_y, point_x + 6, point_y + 6];
                    let t2 = [point_x + 6, point_y + 6, point_x, point_y, point_x + 6, point_y];
                    let t1_center = [(t1[0] + t1[2] + t1[4]) / 3, (t1[1] + t1[3] + t1[5]) / 3];
                    let t2_center = [(t2[0] + t2[2] + t2[4]) / 3, (t2[1] + t2[3] + t2[5]) / 3];

                    let rendered_data = pixel(data, row_width, t1_center[0], t1_center[1]);
                    if (i32::from(rendered_data[0]) - i32::from(reference_data[0])).abs() > epsilon
                        || rendered_data[1] != 0
                        || rendered_data[2] != 0
                        || rendered_data[3] != 0
                    {
                        return Err(fail(format!(
                            "At ({}, {}) rendered pixel ({}, {}, {}, {}) is different than ({}, 0, 0, 0).",
                            t1_center[0],
                            t1_center[1],
                            rendered_data[0],
                            rendered_data[1],
                            rendered_data[2],
                            rendered_data[3],
                            reference_data[0]
                        )));
                    }

                    let rendered_data = pixel(data, row_width, t2_center[0], t2_center[1]);
                    if rendered_data[0] != 0
                        || (i32::from(rendered_data[1]) - i32::from(reference_data[1])).abs() > epsilon
                        || rendered_data[2] != 0
                        || rendered_data[3] != 0
                    {
                        return Err(fail(format!(
                            "At ({}, {}) rendered pixel ({}, {}, {}, {}) is different than (0, {}, 0, 0).",
                            t2_center[0],
                            t2_center[1],
                            rendered_data[0],
                            rendered_data[1],
                            rendered_data[2],
                            rendered_data[3],
                            reference_data[1]
                        )));
                    }
                }
            }
        }
        Ok(())
    }

    /// `GeometryShaderRenderingLinesCase::verify`
    fn verify_lines(&self, draw: DrawCall, instance_id: i32, data: &[u8]) -> Result<(), TestError> {
        let epsilon = 1.0f32 / 256.0;
        let (rt_width, _) = if draw.is_instanced() {
            self.render_target_size(self.amount_of_draw_instances())
        } else {
            self.render_target_size(1)
        };
        let (single_rt_width, single_rt_height) = self.render_target_size(1);
        let (rt_width, single_rt_width, single_rt_height) =
            (rt_width as i32, single_rt_width as i32, single_rt_height as i32);
        let row_width = rt_width * 4;

        match self.output {
            Output::LineStrip => {
                for n_edge in 0..4 {
                    let (start_x, start_y, end_x, end_y, expected_rgba): (i32, i32, i32, i32, [f32; 4]) = match n_edge {
                        0 => {
                            let start_y = 1 + instance_id * single_rt_height;
                            (3, start_y, single_rt_width - 3, start_y, [0.5, 0.5, 0.0, 0.0])
                        }
                        1 => {
                            let start_x = single_rt_width - 2;
                            let start_y = 3 + instance_id * single_rt_height;
                            (
                                start_x,
                                start_y,
                                start_x,
                                start_y + single_rt_height - 6,
                                [0.0, 0.5, 0.5, 0.0],
                            )
                        }
                        2 => {
                            let start_y = single_rt_height - 3 + instance_id * single_rt_height;
                            (3, start_y, single_rt_width - 6, start_y, [0.0, 0.0, 0.5, 0.5])
                        }
                        _ => {
                            let start_y = 3 + instance_id * single_rt_height;
                            (1, start_y, 1, start_y + single_rt_height - 6, [0.5, 0.0, 0.0, 0.5])
                        }
                    };

                    let dx = i32::from(end_x != start_x);
                    let dy = i32::from(end_y != start_y);
                    let n_pixels = (end_x - start_x) + (end_y - start_y);

                    for n_pixel in 0..n_pixels {
                        let cur_x = start_x + n_pixel * dx;
                        let cur_y = start_y + n_pixel * dy;
                        compare_float_pixel(
                            pixel(data, row_width, cur_x, cur_y),
                            expected_rgba,
                            cur_x,
                            cur_y,
                            epsilon,
                        )?;
                    }
                }
            }
            Output::Points => {
                for n_edge in 0..4 {
                    let (dx, dy, ignore_first_point, start_x, start_y, end_color, start_color): (
                        i32,
                        i32,
                        bool,
                        i32,
                        i32,
                        [f32; 4],
                        [f32; 4],
                    ) = match n_edge {
                        0 => (
                            6,
                            0,
                            true,
                            1,
                            1 + instance_id * single_rt_height,
                            [0.0, 1.0, 0.0, 0.0],
                            [1.0, 0.0, 0.0, 0.0],
                        ),
                        1 => (
                            0,
                            6,
                            false,
                            single_rt_width - 1,
                            1 + instance_id * single_rt_height,
                            [0.0, 0.0, 1.0, 0.0],
                            [0.0, 1.0, 0.0, 0.0],
                        ),
                        2 => (
                            -6,
                            0,
                            false,
                            single_rt_width - 1,
                            single_rt_height - 1 + instance_id * single_rt_height,
                            [0.0, 0.0, 0.0, 1.0],
                            [0.0, 0.0, 1.0, 0.0],
                        ),
                        _ => (
                            0,
                            -6,
                            false,
                            1,
                            single_rt_height - 1 + instance_id * single_rt_height,
                            [1.0, 0.0, 0.0, 0.0],
                            [0.0, 0.0, 0.0, 1.0],
                        ),
                    };

                    for n_point in 0..8i32 {
                        let cur_x = start_x + n_point * dx;
                        let cur_y = start_y + n_point * dy;

                        if ignore_first_point && n_point == 0 {
                            continue;
                        }

                        let mut reference_rgba = [0.0f32; 4];
                        for (channel, reference) in reference_rgba.iter_mut().enumerate() {
                            *reference = start_color[channel]
                                + (end_color[channel] - start_color[channel]) * n_point as f32 / 7.0;
                        }
                        compare_float_pixel(
                            pixel(data, row_width, cur_x, cur_y),
                            reference_rgba,
                            cur_x,
                            cur_y,
                            epsilon,
                        )?;
                    }
                }
            }
            Output::TriangleStrip => {
                for n_edge in 0..4 {
                    let instance = instance_id as f32;
                    let v3 = [0.5f32, 0.5 + instance];
                    let (v1, v2, reference_rgba): ([f32; 2], [f32; 2], [f32; 4]) = match n_edge {
                        0 => ([0.0, instance], [1.0, instance], [1.0, 0.0, 0.0, 0.0]),
                        1 => ([1.0, instance], [1.0, instance + 1.0], [0.0, 1.0, 0.0, 0.0]),
                        2 => ([0.0, instance + 1.0], [1.0, instance + 1.0], [0.0, 0.0, 1.0, 0.0]),
                        _ => ([0.0, instance], [0.0, instance + 1.0], [0.0, 0.0, 0.0, 1.0]),
                    };

                    let centroid = [(v1[0] + v2[0] + v3[0]) / 3.0, (v1[1] + v2[1] + v3[1]) / 3.0];
                    let centroid_xy = [
                        (centroid[0] * single_rt_width as f32) as i32,
                        (centroid[1] * single_rt_height as f32) as i32,
                    ];

                    compare_float_pixel(
                        pixel(data, row_width, centroid_xy[0], centroid_xy[1]),
                        reference_rgba,
                        centroid_xy[0],
                        centroid_xy[1],
                        epsilon,
                    )?;
                }
            }
        }
        Ok(())
    }

    /// `GeometryShaderRenderingTrianglesCase::verify`
    fn verify_triangles(&self, draw: DrawCall, instance_id: i32, data: &[u8]) -> Result<(), TestError> {
        let epsilon = 1.0f32 / 256.0;
        let (single_rt_width, single_rt_height) = self.render_target_size(1);
        let (single_rt_width, single_rt_height) = (single_rt_width as i32, single_rt_height as i32);
        let dx = 2.0f32 / single_rt_width as f32;
        let dy = 2.0f32 / single_rt_height as f32;
        let row_width = single_rt_width * 4;
        let is_strip = matches!(self.mode, glw::GL_TRIANGLE_STRIP | glw::GL_TRIANGLE_STRIP_ADJACENCY);

        match self.output {
            Output::LineStrip => {
                let ref_color_data: [f32; 48] = [
                    0.1, 0.2, 0.3, 0.4, 0.2, 0.3, 0.4, 0.5, 0.3, 0.4, 0.5, 0.6, 0.1, 0.2, 0.3, 0.4, 0.3, 0.4, 0.5, 0.6,
                    0.4, 0.5, 0.6, 0.7, 0.1, 0.2, 0.3, 0.4, 0.4, 0.5, 0.6, 0.7, 0.5, 0.6, 0.7, 0.8, 0.1, 0.2, 0.3, 0.4,
                    0.5, 0.6, 0.7, 0.8, 0.2, 0.3, 0.4, 0.5,
                ];

                for n_edge in 0..8 {
                    let (ref_line_segment_index, ref_quarter_index, ref_triangle_index): (i32, i32, usize) =
                        match n_edge {
                            0 => (0, 0, 0),
                            1 => (1, 0, 0),
                            2 => (1, 1, 1),
                            3 => (2, 1, 1),
                            4 => (2, 2, 2),
                            5 => (3, 2, 2),
                            6 => (3, 3, 3),
                            _ => (0, 3, 3),
                        };

                    let base = ref_triangle_index * 4 * 3;
                    let top_right_strip = is_strip && ref_triangle_index == 1;
                    let ref_sample_rgba: [f32; 4] = match ref_line_segment_index {
                        0 if top_right_strip => [0.3, 0.4, 0.5, 0.6],
                        0 => [
                            ref_color_data[base],
                            ref_color_data[base + 1],
                            ref_color_data[base + 2],
                            ref_color_data[base + 3],
                        ],
                        1 if top_right_strip => [0.4, 0.5, 0.6, 0.7],
                        1 => [
                            ref_color_data[base + 4],
                            ref_color_data[base + 5],
                            ref_color_data[base + 6],
                            ref_color_data[base + 7],
                        ],
                        2 if top_right_strip => [0.1, 0.2, 0.3, 0.4],
                        2 => [
                            ref_color_data[base + 8],
                            ref_color_data[base + 9],
                            ref_color_data[base + 10],
                            ref_color_data[base + 11],
                        ],
                        _ if top_right_strip => [0.3, 0.5, 0.3, 0.6],
                        _ => [
                            ref_color_data[base],
                            ref_color_data[base + 5],
                            ref_color_data[base + 10],
                            ref_color_data[base + 3],
                        ],
                    };

                    let mut quad_x1y1x2y2: [f32; 4] = match ref_quarter_index {
                        0 => [0.0, 0.0, 0.5, 0.5],
                        1 => [0.5, 0.0, 1.0, 0.5],
                        2 => [0.5, 0.5, 1.0, 1.0],
                        _ => [0.0, 0.5, 0.5, 1.0],
                    };
                    match ref_line_segment_index {
                        0 => quad_x1y1x2y2[2] = quad_x1y1x2y2[0],
                        1 => quad_x1y1x2y2[3] = quad_x1y1x2y2[1],
                        2 => quad_x1y1x2y2[0] = quad_x1y1x2y2[2],
                        _ => quad_x1y1x2y2[1] = quad_x1y1x2y2[3],
                    }

                    let ref_sample_xy_float = [
                        quad_x1y1x2y2[0] + (quad_x1y1x2y2[2] - quad_x1y1x2y2[0]) * 0.5,
                        quad_x1y1x2y2[1] + (quad_x1y1x2y2[3] - quad_x1y1x2y2[1]) * 0.5,
                    ];
                    let x = (ref_sample_xy_float[0] * (single_rt_width - 1) as f32) as i32;
                    let y = (ref_sample_xy_float[1] * (single_rt_height - 1) as f32) as i32
                        + instance_id * single_rt_height;

                    compare_float_pixel(pixel(data, row_width, x, y), ref_sample_rgba, x, y, epsilon)?;
                }
            }
            Output::Points => {
                let instance = instance_id as f32;
                let ref_data: [f32; 30] = [
                    0.0,
                    -1.0 + instance * 2.0 + dy,
                    0.1,
                    0.2,
                    0.3,
                    0.4,
                    0.0,
                    0.0 + instance * 2.0,
                    0.4,
                    0.5,
                    0.6,
                    0.7,
                    -1.0 + dx,
                    0.0 + instance * 2.0,
                    0.5,
                    0.6,
                    0.7,
                    0.8,
                    1.0 - dx,
                    0.0 + instance * 2.0,
                    0.2,
                    0.3,
                    0.4,
                    0.5,
                    0.0,
                    1.0 + instance * 2.0 - dy,
                    0.3,
                    0.4,
                    0.5,
                    0.6,
                ];

                for n_point in 0..5usize {
                    let color_float = [
                        ref_data[n_point * 6 + 2],
                        ref_data[n_point * 6 + 3],
                        ref_data[n_point * 6 + 4],
                        ref_data[n_point * 6 + 5],
                    ];
                    let position_float = [ref_data[n_point * 6], ref_data[n_point * 6 + 1]];

                    let x = ((position_float[0] * 0.5 + 0.5) * single_rt_width as f32) as i32;
                    let y = ((position_float[1] * 0.5 + 0.5) * single_rt_height as f32) as i32;

                    compare_float_pixel(pixel(data, row_width, x, y), color_float, x, y, epsilon)?;
                }
            }
            Output::TriangleStrip => {
                for n_triangle in 0..8u32 {
                    let (base_triangle_v1, base_triangle_v2, base_triangle_v3): ([f32; 2], [f32; 2], [f32; 2]) =
                        match n_triangle / 2 {
                            0 => ([0.5, 0.5], [0.0, 0.5], [0.5, 0.0]),
                            1 => ([0.5, 0.5], [0.5, 0.0], [1.0, 0.5]),
                            2 => ([0.5, 0.5], [1.0, 0.5], [0.5, 1.0]),
                            _ => ([0.5, 0.5], [0.0, 0.5], [0.5, 1.0]),
                        };

                    let (a, b, c) = if base_triangle_v2[0] == 0.5 && base_triangle_v2[1] == 0.5 {
                        let a = base_triangle_v2;
                        if (base_triangle_v1[0] - a[0]).abs() < dx * 0.5 {
                            (a, base_triangle_v1, base_triangle_v3)
                        } else {
                            (a, base_triangle_v3, base_triangle_v1)
                        }
                    } else if base_triangle_v3[0] == 0.5 && base_triangle_v3[1] == 0.5 {
                        let a = base_triangle_v3;
                        if (base_triangle_v1[0] - a[0]).abs() < dx * 0.5 {
                            (a, base_triangle_v1, base_triangle_v2)
                        } else {
                            (a, base_triangle_v2, base_triangle_v1)
                        }
                    } else {
                        let a = base_triangle_v1;
                        if (base_triangle_v2[0] - a[0]).abs() < dx * 0.5 {
                            (a, base_triangle_v2, base_triangle_v3)
                        } else {
                            (a, base_triangle_v3, base_triangle_v2)
                        }
                    };
                    let d = [(b[0] + c[0]) * 0.5, (b[1] + c[1]) * 0.5];

                    let adjacency_factor = if self.mode == glw::GL_TRIANGLE_STRIP_ADJACENCY {
                        2
                    } else {
                        1
                    };
                    let (mut expected_sample_color_vertex_id, triangle_vertex2): (i32, [f32; 2]) =
                        if n_triangle % 2 == 0 {
                            let vertex_id = match self.mode {
                                glw::GL_TRIANGLES | glw::GL_TRIANGLES_ADJACENCY => 3 * (n_triangle / 2) as i32,
                                glw::GL_TRIANGLE_FAN => 0,
                                _ => match n_triangle {
                                    0 => 0,
                                    2 => 2 * adjacency_factor,
                                    _ => 4 * adjacency_factor,
                                },
                            };
                            (vertex_id, b)
                        } else {
                            let vertex_id = match self.mode {
                                glw::GL_TRIANGLES | glw::GL_TRIANGLES_ADJACENCY => 3 * (n_triangle / 2) as i32 + 2,
                                glw::GL_TRIANGLE_FAN => 2 + (n_triangle / 2) as i32,
                                _ => match n_triangle {
                                    1 => 2 * adjacency_factor,
                                    3 => 4 * adjacency_factor,
                                    5 => 5 * adjacency_factor,
                                    _ => 6 * adjacency_factor,
                                },
                            };
                            (vertex_id, c)
                        };
                    let triangle_vertex1 = a;
                    let triangle_vertex3 = d;

                    if draw.is_indexed() {
                        let last = self.amount_of_vertices_per_instance() as i32 - 1;
                        expected_sample_color_vertex_id = if self.mode == glw::GL_TRIANGLES_ADJACENCY {
                            last - expected_sample_color_vertex_id * 2
                        } else {
                            last - expected_sample_color_vertex_id
                        };
                    }

                    let id = expected_sample_color_vertex_id + 1;
                    let mut expected_sample_color_rgba = [
                        id as f32 / 48.0,
                        (id % 3) as f32 / 2.0,
                        (id % 4) as f32 / 3.0,
                        (id % 5) as f32 / 4.0,
                    ];
                    if n_triangle % 2 == 1 {
                        expected_sample_color_rgba[0] *= 2.0;
                    }

                    let sample_location = [
                        (triangle_vertex1[0] + triangle_vertex2[0] + triangle_vertex3[0]) / 3.0,
                        (triangle_vertex1[1] + triangle_vertex2[1] + triangle_vertex3[1]) / 3.0,
                    ];
                    let x = (sample_location[0] * (single_rt_width - 1) as f32 + 0.5) as i32;
                    let y = (sample_location[1] * (single_rt_height - 1) as f32 + 0.5) as i32
                        + instance_id * single_rt_height;

                    compare_float_pixel(pixel(data, row_width, x, y), expected_sample_color_rgba, x, y, epsilon)?;
                }
            }
        }
        Ok(())
    }

    fn run(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> TestOutcome {
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        let buffers = self.init_test(context, base, resources)?;

        for draw in [
            DrawCall::Arrays,
            DrawCall::ArraysInstanced,
            DrawCall::Elements,
            DrawCall::ElementsInstanced,
            DrawCall::RangeElements,
        ] {
            self.execute_test(context, resources, &buffers, draw)?;
        }
        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Rendering {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let mut resources = Resources::default();
        let outcome = self.run(context, &base, &mut resources);

        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for buffers in &resources.bo_ids {
            gl!(gl.delete_buffers(buffers.len() as i32, buffers.as_ptr()));
        }
        for framebuffer in resources.fbo_ids.iter().chain(resources.read_fbo_ids.iter()) {
            if *framebuffer != 0 {
                gl!(gl.delete_framebuffers(1, framebuffer));
            }
        }
        for texture in &resources.to_ids {
            if *texture != 0 {
                gl!(gl.delete_textures(1, texture));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}

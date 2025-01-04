// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fPrimitiveRestartTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream builds the index/position
// arrays in `init` and the program too; a `TestCase` here is immutable and has no
// `init` phase, so both happen at the top of `iterate`. Upstream's three parallel
// index vectors (one per index type, only one ever used) become one `Indices` enum.

use std::ffi::{CString, c_void};

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::random::de_string_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

const MAX_RENDER_WIDTH: i32 = 256;
const MAX_RENDER_HEIGHT: i32 = 256;

const RESTART_INDEX_UNSIGNED_BYTE: u32 = u8::MAX as u32;
const RESTART_INDEX_UNSIGNED_SHORT: u32 = u16::MAX as u32;
const RESTART_INDEX_UNSIGNED_INT: u32 = u32::MAX;

#[derive(Clone, Copy, PartialEq, Eq)]
enum PrimitiveType {
    Points,
    LineStrip,
    LineLoop,
    Lines,
    TriangleStrip,
    TriangleFan,
    Triangles,
}

const PRIMITIVE_TYPES: &[(PrimitiveType, &str)] = &[
    (PrimitiveType::Points, "points"),
    (PrimitiveType::LineStrip, "line_strip"),
    (PrimitiveType::LineLoop, "line_loop"),
    (PrimitiveType::Lines, "lines"),
    (PrimitiveType::TriangleStrip, "triangle_strip"),
    (PrimitiveType::TriangleFan, "triangle_fan"),
    (PrimitiveType::Triangles, "triangles"),
];

impl PrimitiveType {
    fn gl(self) -> u32 {
        match self {
            Self::Points => glw::GL_POINTS,
            Self::LineStrip => glw::GL_LINE_STRIP,
            Self::LineLoop => glw::GL_LINE_LOOP,
            Self::Lines => glw::GL_LINES,
            Self::TriangleStrip => glw::GL_TRIANGLE_STRIP,
            Self::TriangleFan => glw::GL_TRIANGLE_FAN,
            Self::Triangles => glw::GL_TRIANGLES,
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
#[expect(
    clippy::enum_variant_names,
    reason = "named after the GL_UNSIGNED_* index types upstream switches on"
)]
enum IndexType {
    UnsignedByte,
    UnsignedShort,
    UnsignedInt,
}

const INDEX_TYPES: &[(IndexType, &str)] = &[
    (IndexType::UnsignedByte, "unsigned_byte"),
    (IndexType::UnsignedShort, "unsigned_short"),
    (IndexType::UnsignedInt, "unsigned_int"),
];

impl IndexType {
    fn gl(self) -> u32 {
        match self {
            Self::UnsignedByte => glw::GL_UNSIGNED_BYTE,
            Self::UnsignedShort => glw::GL_UNSIGNED_SHORT,
            Self::UnsignedInt => glw::GL_UNSIGNED_INT,
        }
    }

    fn restart_index(self) -> u32 {
        match self {
            Self::UnsignedByte => RESTART_INDEX_UNSIGNED_BYTE,
            Self::UnsignedShort => RESTART_INDEX_UNSIGNED_SHORT,
            Self::UnsignedInt => RESTART_INDEX_UNSIGNED_INT,
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
#[expect(
    clippy::enum_variant_names,
    reason = "named after the glDrawElements* entry points upstream switches on"
)]
enum Function {
    DrawElements,
    DrawElementsInstanced,
    DrawRangeElements,
}

const FUNCTIONS: &[(Function, &str)] = &[
    (Function::DrawElements, "draw_elements"),
    (Function::DrawElementsInstanced, "draw_elements_instanced"),
    (Function::DrawRangeElements, "draw_range_elements"),
];

/// Upstream's `m_indicesUB`/`m_indicesUS`/`m_indicesUI` - exactly one of the three is
/// ever populated, chosen by `m_indexType`.
#[expect(
    clippy::enum_variant_names,
    reason = "named after the GL_UNSIGNED_* index types upstream switches on"
)]
enum Indices {
    UnsignedByte(Vec<u8>),
    UnsignedShort(Vec<u16>),
    UnsignedInt(Vec<u32>),
}

impl Indices {
    fn new(index_type: IndexType) -> Self {
        match index_type {
            IndexType::UnsignedByte => Self::UnsignedByte(Vec::new()),
            IndexType::UnsignedShort => Self::UnsignedShort(Vec::new()),
            IndexType::UnsignedInt => Self::UnsignedInt(Vec::new()),
        }
    }

    /// `PrimitiveRestartCase::addIndex`
    fn add_index(&mut self, index: u32) {
        match self {
            Self::UnsignedByte(v) => {
                debug_assert!(index <= RESTART_INDEX_UNSIGNED_BYTE);
                v.push(index as u8);
            }
            Self::UnsignedShort(v) => {
                debug_assert!(index <= RESTART_INDEX_UNSIGNED_SHORT);
                v.push(index as u16);
            }
            Self::UnsignedInt(v) => v.push(index),
        }
    }

    /// `PrimitiveRestartCase::getIndex`
    fn get_index(&self, index_ndx: usize) -> u32 {
        match self {
            Self::UnsignedByte(v) => u32::from(v[index_ndx]),
            Self::UnsignedShort(v) => u32::from(v[index_ndx]),
            Self::UnsignedInt(v) => v[index_ndx],
        }
    }

    /// `PrimitiveRestartCase::getNumIndices`
    fn num_indices(&self) -> usize {
        match self {
            Self::UnsignedByte(v) => v.len(),
            Self::UnsignedShort(v) => v.len(),
            Self::UnsignedInt(v) => v.len(),
        }
    }

    /// `PrimitiveRestartCase::getIndexPtr` - pointer to the value at `index_ndx`.
    fn index_ptr(&self, index_ndx: usize) -> *const c_void {
        match self {
            Self::UnsignedByte(v) => v[index_ndx..].as_ptr().cast(),
            Self::UnsignedShort(v) => v[index_ndx..].as_ptr().cast(),
            Self::UnsignedInt(v) => v[index_ndx..].as_ptr().cast(),
        }
    }
}

struct PrimitiveRestartCase {
    name: String,
    prim_type: PrimitiveType,
    index_type: IndexType,
    function: Function,
    /// Whether there will be restart indices at the beginning of the index array.
    begin_with_restart: bool,
    /// Whether there will be restart indices at the end of the index array.
    end_with_restart: bool,
    /// Whether two consecutive restarts are used instead of one.
    duplicate_restarts: bool,
}

impl PrimitiveRestartCase {
    /// The tail of `PrimitiveRestartCase::init` - everything after the program build.
    fn build_geometry(&self) -> (Vec<f32>, Indices) {
        let restart_index = self.index_type.restart_index();
        let mut positions: Vec<f32> = Vec::new();
        let mut indices = Indices::new(self.index_type);

        let add_restart = |indices: &mut Indices| {
            indices.add_index(restart_index);
            if self.duplicate_restarts {
                indices.add_index(restart_index);
            }
        };

        // If testing a case with restart at beginning, add it there.
        if self.begin_with_restart {
            add_restart(&mut indices);
        }

        match self.prim_type {
            PrimitiveType::Points => {
                // Generate rows with different numbers of points.
                let mut cur_index = 0u32;
                let num_rows = 20;

                for row in 0..num_rows {
                    for col in 0..row + 1 {
                        let fx = -1.0 + 2.0 * (col as f32 + 0.5) / num_rows as f32;
                        let fy = -1.0 + 2.0 * (row as f32 + 0.5) / num_rows as f32;

                        positions.push(fx);
                        positions.push(fy);

                        indices.add_index(cur_index);
                        cur_index += 1;
                    }

                    if row < num_rows - 1 {
                        // Add a restart after all but last row.
                        add_restart(&mut indices);
                    }
                }
            }
            PrimitiveType::LineStrip | PrimitiveType::LineLoop | PrimitiveType::Lines => {
                // Generate a numRows x numCols arrangement of line polygons of
                // different vertex counts.
                let mut cur_index = 0u32;
                let num_rows = 4;
                let num_cols = 4;

                for row in 0..num_rows {
                    let center_y = -1.0 + 2.0 * (row as f32 + 0.5) / num_rows as f32;

                    for col in 0..num_cols {
                        let center_x = -1.0 + 2.0 * (col as f32 + 0.5) / num_cols as f32;
                        let num_vertices = row * num_cols + col + 1;

                        for i in 0..num_vertices {
                            let angle = i as f32 * 2.0 * std::f32::consts::PI / num_vertices as f32;
                            let fx = center_x + 0.9 * angle.cos() / num_cols as f32;
                            let fy = center_y + 0.9 * angle.sin() / num_rows as f32;

                            positions.push(fx);
                            positions.push(fy);

                            indices.add_index(cur_index);
                            cur_index += 1;
                        }

                        if col < num_cols - 1 || row < num_rows - 1 {
                            // Add a restart after all but last polygon.
                            add_restart(&mut indices);
                        }
                    }
                }
            }
            PrimitiveType::TriangleStrip => {
                // Generate a number of horizontal triangle strips of different lengths.
                let mut cur_index = 0u32;
                let num_strips = 20;

                for strip_ndx in 0..num_strips {
                    let num_vertices = strip_ndx + 1;

                    for i in 0..num_vertices {
                        let fx = -0.9 + 1.8 * (i / 2 * 2) as f32 / num_strips as f32;
                        let fy =
                            -0.9 + 1.8 * (strip_ndx as f32 + if i % 2 == 0 { 0.0 } else { 0.8 }) / num_strips as f32;

                        positions.push(fx);
                        positions.push(fy);

                        indices.add_index(cur_index);
                        cur_index += 1;
                    }

                    if strip_ndx < num_strips - 1 {
                        // Add a restart after all but last strip.
                        add_restart(&mut indices);
                    }
                }
            }
            PrimitiveType::TriangleFan => {
                // Generate a numRows x numCols arrangement of triangle fan polygons of
                // different vertex counts.
                let mut cur_index = 0u32;
                let num_rows = 4;
                let num_cols = 4;

                for row in 0..num_rows {
                    let center_y = -1.0 + 2.0 * (row as f32 + 0.5) / num_rows as f32;

                    for col in 0..num_cols {
                        let center_x = -1.0 + 2.0 * (col as f32 + 0.5) / num_cols as f32;
                        let num_arc_vertices = row * num_cols + col;

                        positions.push(center_x);
                        positions.push(center_y);

                        indices.add_index(cur_index);
                        cur_index += 1;

                        for i in 0..num_arc_vertices {
                            let angle = i as f32 * 2.0 * std::f32::consts::PI / num_arc_vertices as f32;
                            let fx = center_x + 0.9 * angle.cos() / num_cols as f32;
                            let fy = center_y + 0.9 * angle.sin() / num_rows as f32;

                            positions.push(fx);
                            positions.push(fy);

                            indices.add_index(cur_index);
                            cur_index += 1;
                        }

                        if col < num_cols - 1 || row < num_rows - 1 {
                            // Add a restart after all but last polygon.
                            add_restart(&mut indices);
                        }
                    }
                }
            }
            PrimitiveType::Triangles => {
                // Generate a number of rows with (potentially incomplete) triangles.
                let mut cur_index = 0u32;
                let num_rows = 3 * 7;

                for row_ndx in 0..num_rows {
                    let num_vertices = row_ndx + 1;

                    for i in 0..num_vertices {
                        let fx =
                            -0.9 + 1.8 * ((i / 3) as f32 + if i % 3 == 2 { 0.8 } else { 0.0 }) * 3.0 / num_rows as f32;
                        let fy = -0.9 + 1.8 * (row_ndx as f32 + if i % 3 == 0 { 0.0 } else { 0.8 }) / num_rows as f32;

                        positions.push(fx);
                        positions.push(fy);

                        indices.add_index(cur_index);
                        cur_index += 1;
                    }

                    if row_ndx < num_rows - 1 {
                        // Add a restart after all but last row.
                        add_restart(&mut indices);
                    }
                }
            }
        }

        // If testing a case with restart at end, add it there.
        if self.end_with_restart {
            add_restart(&mut indices);
        }

        // Special case assertions.
        let num_indices = indices.num_indices();
        debug_assert!(num_indices > 0);
        // We don't want restarts at beginning/end unless the case is a special case.
        debug_assert!(self.begin_with_restart || indices.get_index(0) != restart_index);
        debug_assert!(self.end_with_restart || indices.get_index(num_indices - 1) != restart_index);

        if !self.duplicate_restarts {
            for i in 1..num_indices {
                // We don't want duplicate restarts unless the case is a special case.
                debug_assert!(indices.get_index(i) != restart_index || indices.get_index(i - 1) != restart_index);
            }
        }

        (positions, indices)
    }

    /// `PrimitiveRestartCase::draw` - draw with the appropriate GLES3 draw function.
    ///
    /// # Safety
    /// The current context must have `a_position` sourced from a live client array.
    unsafe fn draw(&self, gl: &glw::Functions, indices: &Indices, start_ndx: usize, count: usize) {
        let prim_type_gl = self.prim_type.gl();
        let index_type_gl = self.index_type.gl();
        let restart_index = self.index_type.restart_index();

        match self.function {
            Function::DrawElements => unsafe {
                gl.draw_elements(prim_type_gl, count as i32, index_type_gl, indices.index_ptr(start_ndx));
            },
            Function::DrawElementsInstanced => unsafe {
                gl.draw_elements_instanced(
                    prim_type_gl,
                    count as i32,
                    index_type_gl,
                    indices.index_ptr(start_ndx),
                    1,
                );
            },
            Function::DrawRangeElements => {
                // Find the largest non-restart index in the index array (for
                // glDrawRangeElements() end parameter).
                let mut max = 0u32;
                for i in 0..indices.num_indices() {
                    let index = indices.get_index(i);
                    if index != restart_index && index > max {
                        max = index;
                    }
                }

                // SAFETY: same client-array precondition as the other two.
                unsafe {
                    gl.draw_range_elements(
                        prim_type_gl,
                        0,
                        max,
                        count as i32,
                        index_type_gl,
                        indices.index_ptr(start_ndx),
                    );
                }
            }
        }
    }

    /// `PrimitiveRestartCase::renderWithRestart`
    fn render_with_restart(&self, gl: &glw::Functions, indices: &Indices) -> Result<(), TestError> {
        glu::expect_no_error(gl, "PrimitiveRestartCase::renderWithRestart() begin")?;

        // SAFETY: plain state setup on the current context.
        unsafe {
            gl.enable(glw::GL_PRIMITIVE_RESTART_FIXED_INDEX);
        }
        glu::expect_no_error(gl, "Enable primitive restart")?;
        // SAFETY: as above.
        unsafe {
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "Clear in PrimitiveRestartCase::renderWithRestart()")?;

        // SAFETY: the client array is alive for the whole of `iterate`.
        unsafe {
            self.draw(gl, indices, 0, indices.num_indices());
        }
        glu::expect_no_error(gl, "Draw in PrimitiveRestartCase::renderWithRestart()")?;

        Ok(())
    }

    /// `PrimitiveRestartCase::renderWithoutRestart`
    fn render_without_restart(&self, gl: &glw::Functions, indices: &Indices) -> Result<(), TestError> {
        glu::expect_no_error(gl, "PrimitiveRestartCase::renderWithoutRestart() begin")?;

        let restart_index = self.index_type.restart_index();

        // SAFETY: plain state setup on the current context.
        unsafe {
            gl.disable(glw::GL_PRIMITIVE_RESTART_FIXED_INDEX);
        }
        glu::expect_no_error(gl, "Disable primitive restart")?;
        // SAFETY: as above.
        unsafe {
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "Clear in PrimitiveRestartCase::renderWithoutRestart()")?;

        // Draw, emulating primitive restart.
        let num_indices = indices.num_indices();

        // Keep track of the draw start index - first index after a primitive restart,
        // or initially the first index altogether.
        let mut index_array_start_ndx = 0usize;

        // \note Goes one "too far" in order to detect end of array as well.
        for index_array_ndx in 0..=num_indices {
            // \note Handle end of array the same way as a restart index encounter.
            if index_array_ndx >= num_indices || indices.get_index(index_array_ndx) == restart_index {
                if index_array_start_ndx < num_indices {
                    // Draw from index index_array_start_ndx to index_array_ndx - 1.
                    // SAFETY: the client array is alive for the whole of `iterate`.
                    unsafe {
                        self.draw(
                            gl,
                            indices,
                            index_array_start_ndx,
                            index_array_ndx - index_array_start_ndx,
                        );
                    }
                    glu::expect_no_error(gl, "Draw in PrimitiveRestartCase::renderWithoutRestart()")?;
                }

                // Next draw starts just after this restart index.
                index_array_start_ndx = index_array_ndx + 1;
            }
        }

        Ok(())
    }
}

impl TestCase for PrimitiveRestartCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();

        // Create shader program.
        let vert_shader_source = if self.prim_type == PrimitiveType::Points {
            concat!(
                "#version 300 es\n",
                "in highp vec4 a_position;\n",
                "\n",
                "void main()\n",
                "{\n",
                "    gl_Position = a_position;\n",
                "    gl_PointSize = 1.0f;\n",
                "}\n"
            )
        } else {
            concat!(
                "#version 300 es\n",
                "in highp vec4 a_position;\n",
                "\n",
                "void main()\n",
                "{\n",
                "    gl_Position = a_position;\n",
                "}\n"
            )
        };

        let frag_shader_source = concat!(
            "#version 300 es\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "\n",
            "void main()\n",
            "{\n",
            "    o_color = vec4(1.0f);\n",
            "}\n"
        );

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vert_shader_source, frag_shader_source));

        if !program.is_ok() {
            return Err(TestError::Fail("Failed to compile shader".to_string()));
        }

        let (positions, indices) = self.build_geometry();

        let width = render_target.width.min(MAX_RENDER_WIDTH);
        let height = render_target.height.min(MAX_RENDER_HEIGHT);

        let x_offset_max = render_target.width - width;
        let y_offset_max = render_target.height - height;

        let mut rnd = Random::new(de_string_hash(&self.name));

        let x_offset = rnd.get_int(0, x_offset_max);
        let y_offset = rnd.get_int(0, y_offset_max);
        let mut reference_img = Surface::new(width, height);
        let mut result_img = Surface::new(width, height);

        let position_name = CString::new("a_position").expect("literal has no nul");

        // SAFETY: plain state setup; the client array outlives every draw below.
        unsafe {
            gl.viewport(x_offset, y_offset, width, height);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);

            gl.use_program(program.program());

            // Setup position attribute.
            let loc = gl.get_attrib_location(program.program(), position_name.as_ptr());
            gl.enable_vertex_attrib_array(loc as u32);
            gl.vertex_attrib_pointer(loc as u32, 2, glw::GL_FLOAT, glw::FALSE, 0, positions.as_ptr().cast());
        }

        // Render result.
        self.render_with_restart(gl, &indices)?;
        glu::read_pixels(
            &context.render_context,
            x_offset,
            y_offset,
            &mut result_img.get_access(),
        )?;

        // Render reference (same scene as the real deal, but emulate primitive restart
        // without actually using it).
        self.render_without_restart(gl, &indices)?;
        glu::read_pixels(
            &context.render_context,
            x_offset,
            y_offset,
            &mut reference_img.get_access(),
        )?;

        // Compare.
        let comparison = pixel_threshold_compare(&reference_img, &result_img, RGBA::new(0, 0, 0, 0));

        // SAFETY: plain state teardown.
        unsafe {
            gl.use_program(0);
        }

        if comparison.ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            let d = comparison.max_diff.m_data;
            Err(TestError::Fail(format!(
                "Image comparison failed: max difference = ({}, {}, {}, {})",
                d[0], d[1], d[2], d[3]
            )))
        }
    }
}

/// `PrimitiveRestartTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("primitive_restart");

    for is_restart_begin_case in [false, true] {
        for is_restart_end_case in [false, true] {
            for is_duplicate_restart_case in [false, true] {
                let mut special_case_group_name = String::new();

                if is_restart_begin_case {
                    special_case_group_name = "begin_restart".to_string();
                }
                if is_restart_end_case {
                    if !special_case_group_name.is_empty() {
                        special_case_group_name.push('_');
                    }
                    special_case_group_name.push_str("end_restart");
                }
                if is_duplicate_restart_case {
                    if !special_case_group_name.is_empty() {
                        special_case_group_name.push('_');
                    }
                    special_case_group_name.push_str("duplicate_restarts");
                }

                if special_case_group_name.is_empty() {
                    special_case_group_name = "basic".to_string();
                }

                let mut special_case_group = TestCaseGroup::new(special_case_group_name.as_str());

                for &(prim_type, prim_type_name) in PRIMITIVE_TYPES {
                    let mut prim_type_group = TestCaseGroup::new(prim_type_name);

                    for &(index_type, index_type_name) in INDEX_TYPES {
                        let mut index_type_group = TestCaseGroup::new(index_type_name);

                        for &(function, function_name) in FUNCTIONS {
                            index_type_group.add_child(Box::new(PrimitiveRestartCase {
                                name: function_name.to_string(),
                                prim_type,
                                index_type,
                                function,
                                begin_with_restart: is_restart_begin_case,
                                end_with_restart: is_restart_end_case,
                                duplicate_restarts: is_duplicate_restart_case,
                            }) as Box<dyn TestCase>);
                        }

                        prim_type_group.add_child(index_type_group);
                    }

                    special_case_group.add_child(prim_type_group);
                }

                group.add_child(special_case_group);
            }
        }
    }

    group
}

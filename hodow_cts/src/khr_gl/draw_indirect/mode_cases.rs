// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cDrawIndirectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The twenty `CModeDraw{Arrays,Elements}*` classes are one `PrimitiveMode` constructed with a draw function, a primitive type and the primitive generator dimensions.

use super::draw_cases::compare_region;
use super::{
    Color, DiResult, DrawArraysIndirectCommand, DrawElementsIndirectCommand, DrawFunction, add_case, create_program,
    fsh_simple, primitive_gen, vsh_simple, vsh_simple_point, window_height, window_width,
};
use crate::glu::{Context, TestCaseGroup};
use crate::glw::{self, GLenum, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};

const COLOR: Color = [0.1, 0.2, 0.3, 1.0];
const CLEAR: Color = [0.0, 0.0, 0.0, 0.0];

/// `CPrimitiveMode`
struct PrimitiveMode {
    draw_func: DrawFunction,
    primitive_type: GLenum,
    draw_size_x: Option<u32>,
    draw_size_y: Option<u32>,
    point_mode: bool,
    size_x: u32,
    size_y: u32,
    program: GLuint,
    vao: GLuint,
    buffer: GLuint,
    ebo: GLuint,
    buffer_indirect: GLuint,
}

impl PrimitiveMode {
    fn new(draw_func: DrawFunction, primitive_type: GLenum, draw_size: Option<u32>, point_mode: bool) -> Self {
        Self {
            draw_func,
            primitive_type,
            draw_size_x: draw_size,
            draw_size_y: draw_size,
            point_mode,
            size_x: 0,
            size_y: 0,
            program: 0,
            vao: 0,
            buffer: 0,
            ebo: 0,
            buffer_indirect: 0,
        }
    }
}

impl Subcase for PrimitiveMode {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        self.size_x = window_width(context) as u32;
        self.size_y = window_height(context) as u32;

        if self.primitive_type != glw::GL_TRIANGLE_STRIP
            && self.primitive_type != glw::GL_TRIANGLE_STRIP_ADJACENCY
            && self.primitive_type != glw::GL_TRIANGLES
            && self.primitive_type != glw::GL_TRIANGLES_ADJACENCY
            && self.primitive_type != glw::GL_TRIANGLE_FAN
        {
            self.size_x &= !3;
            self.size_y &= !3;
        }

        if self.draw_size_x.is_none() || self.draw_size_y.is_none() {
            // no PrimitiveGen dimensions given. assume same dimensions as rendered image
            self.draw_size_x = Some(self.size_x);
            self.draw_size_y = Some(self.size_y);
            if self.primitive_type == glw::GL_POINTS {
                // clamp vertex number (and rendering size) for points to max. 10000
                self.size_x = self.size_x.min(100);
                self.size_y = self.size_y.min(100);
                self.draw_size_x = Some(self.size_x);
                self.draw_size_y = Some(self.size_y);
            }
        }

        gl!(context.gl().clear(glw::GL_COLOR_BUFFER_BIT));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

        let vertex_shader = if self.point_mode {
            vsh_simple_point()
        } else {
            vsh_simple()
        };
        self.program = create_program(gl, &vertex_shader, "", &fsh_simple(), true);
        if self.program == 0 {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        let mut coords: Vec<Color> = Vec::new();
        primitive_gen(
            context,
            self.primitive_type,
            self.draw_size_x.unwrap_or(0),
            self.draw_size_y.unwrap_or(0),
            &mut coords,
        )?;

        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.bind_vertex_array(self.vao));

        let color_size = std::mem::size_of::<Color>();
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer));
        let padding: Vec<Color> = vec![[0.0; 4]; 10];
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (coords.len() * color_size + padding.len() * color_size) as isize,
            std::ptr::null(),
            glw::GL_STREAM_DRAW
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            0,
            (padding.len() * color_size) as isize,
            padding.as_ptr().cast()
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            (padding.len() * color_size) as isize,
            (coords.len() * color_size) as isize,
            coords.as_ptr().cast()
        ));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, color_size as i32, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));

        let elements: Vec<u32> = (0..coords.len() as u32).collect();

        gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));

        match self.draw_func {
            DrawFunction::DrawArrays => {
                let indirect_arrays = DrawArraysIndirectCommand {
                    count: coords.len() as u32 / 2,
                    prim_count: 1,
                    first: 10,
                    reserved_must_be_zero: 0,
                };
                let size = std::mem::size_of::<DrawArraysIndirectCommand>() as isize;
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    size,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.buffer_sub_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    0,
                    size,
                    std::ptr::from_ref(&indirect_arrays).cast()
                ));
                gl!(gl.draw_arrays_indirect(self.primitive_type, std::ptr::null()));
            }
            DrawFunction::DrawElements => {
                let indirect_elements = DrawElementsIndirectCommand {
                    count: coords.len() as u32 / 2,
                    prim_count: 1,
                    first_index: 3,
                    base_vertex: 7,
                    reserved_must_be_zero: 0,
                };
                let size = std::mem::size_of::<DrawElementsIndirectCommand>() as isize;
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    size,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.buffer_sub_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    0,
                    size,
                    std::ptr::from_ref(&indirect_elements).cast()
                ));

                gl!(gl.gen_buffers(1, &mut self.ebo));
                gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo));
                gl!(gl.buffer_data(
                    glw::GL_ELEMENT_ARRAY_BUFFER,
                    (elements.len() * std::mem::size_of::<u32>()) as isize,
                    elements.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.draw_elements_indirect(self.primitive_type, glw::GL_UNSIGNED_INT, std::ptr::null()));
            }
        }

        let (size_x, size_y) = (self.size_x as i32, self.size_y as i32);
        let mut result = DiResult::new();

        result.sub_result(compare_region(context, 0, (size_y + 1) / 2, size_x, size_y / 2, CLEAR));

        match self.primitive_type {
            glw::GL_TRIANGLES_ADJACENCY | glw::GL_TRIANGLE_STRIP_ADJACENCY => {
                result.sub_result(compare_region(
                    context,
                    0,
                    (size_y + 3) / 4,
                    size_x / 4,
                    size_y / 4,
                    CLEAR,
                ));
                result.sub_result(compare_region(
                    context,
                    (size_x + 3) / 4,
                    (size_y + 3) / 4,
                    size_x / 2,
                    size_y / 4,
                    COLOR,
                ));
                result.sub_result(compare_region(
                    context,
                    (size_x * 3 + 3) / 4,
                    (size_y + 3) / 4,
                    size_x / 4,
                    size_y / 4,
                    CLEAR,
                ));
                result.sub_result(compare_region(context, 0, 0, size_x, size_y / 4, CLEAR));
            }
            _ => result.sub_result(compare_region(context, 0, 0, size_x, size_y / 2, COLOR)),
        }

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable_vertex_attrib_array(0));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_buffers(1, &self.ebo));
        gl!(gl.delete_buffers(1, &self.buffer_indirect));
        Ok(NO_ERROR)
    }
}

pub(super) fn add_mode_cases(group: &mut TestCaseGroup) {
    // (name suffix, primitive type, primitive generator size, point mode)
    let modes: [(&str, GLenum, Option<u32>, bool); 10] = [
        ("points", glw::GL_POINTS, None, true),
        ("lines", glw::GL_LINES, None, false),
        ("line_strip", glw::GL_LINE_STRIP, None, false),
        ("line_loop", glw::GL_LINE_LOOP, None, false),
        ("triangle_strip", glw::GL_TRIANGLE_STRIP, Some(2), false),
        ("triangle_fan", glw::GL_TRIANGLE_FAN, Some(2), false),
        ("lines_adjacency", glw::GL_LINES_ADJACENCY, None, false),
        ("line_strip_adjacency", glw::GL_LINE_STRIP_ADJACENCY, None, false),
        ("triangles_adjacency", glw::GL_TRIANGLES_ADJACENCY, Some(4), false),
        (
            "triangle_strip_adjacency",
            glw::GL_TRIANGLE_STRIP_ADJACENCY,
            Some(4),
            false,
        ),
    ];

    for (prefix, draw_func) in [
        ("basic-mode-drawArrays-", DrawFunction::DrawArrays),
        ("basic-mode-drawElements-", DrawFunction::DrawElements),
    ] {
        for (suffix, primitive_type, draw_size, point_mode) in modes {
            add_case(group, &format!("{prefix}{suffix}"), move || {
                Box::new(PrimitiveMode::new(draw_func, primitive_type, draw_size, point_mode))
            });
        }
    }
}

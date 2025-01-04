// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fDrawTests.cpp  (InstancedGridRenderTest, GridProgram)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Upstream draws through `sglr::GLContext` with an `sglr::ShaderProgram` (`GridProgram`)
// that carries a host shading function it never uses here, since the context is the
// driver-backed one and not the reference one. This is the same GLSL as a plain
// `glu::ShaderProgram` and the calls go straight to the driver.

use std::mem::size_of_val;

use crate::gles31::functional::draw_compute_interop_tests::verify_image_yellow_green;
use crate::glu::{
    self, Buffer, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, VertexArray,
};
use crate::glw::{self, GLsizeiptr, GLuint};
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

const GRID_VERTEX_SOURCE: &str = "#version 310 es\n\
    in highp vec4 a_position;\n\
    in highp vec4 a_offset;\n\
    in highp vec4 a_color;\n\
    out highp vec4 v_color;\n\
    void main(void)\n\
    {\n\
    \tgl_Position = a_position + a_offset;\n\
    \tv_color = a_color;\n\
    }\n";

const GRID_FRAGMENT_SOURCE: &str = "#version 310 es\n\
    layout(location = 0) out highp vec4 dEQP_FragColor;\n\
    in highp vec4 v_color;\n\
    void main(void)\n\
    {\n\
    \tdEQP_FragColor = v_color;\n\
    }\n";

/// `InstancedGridRenderTest`
struct InstancedGridRenderTest {
    name: String,
    grid_side: i32,
    use_indices: bool,
}

impl TestCase for InstancedGridRenderTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `iterate` plus `renderTo`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let render_target_width = 1024.min(render_target.width);
        let render_target_height = 1024.min(render_target.height);
        let mut dst = Surface::new(render_target_width, render_target_height);

        let program = ShaderProgram::new(
            gl,
            &ProgramSources::default()
                .with(ShaderType::Vertex, GRID_VERTEX_SOURCE)
                .with(ShaderType::Fragment, GRID_FRAGMENT_SOURCE),
        );
        if !program.is_ok() {
            return Err(TestError::Fail("could not build program".to_string()));
        }

        let green = [0.0f32, 1.0, 0.0, 1.0];
        let yellow = [1.0f32, 1.0, 0.0, 1.0];

        // SAFETY: NUL-terminated names against the program just built.
        let (pos_location, offset_location, color_location) = unsafe {
            (
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()),
                gl.get_attrib_location(program.program(), c"a_offset".as_ptr()),
                gl.get_attrib_location(program.program(), c"a_color".as_ptr()),
            )
        };
        if pos_location == -1 || offset_location == -1 || color_location == -1 {
            return Err(TestError::Fail("attribute location was -1".to_string()));
        }
        let (pos_location, offset_location, color_location) = (
            pos_location as GLuint,
            offset_location as GLuint,
            color_location as GLuint,
        );

        let cell_w = 2.0 / self.grid_side as f32;
        let cell_h = 2.0 / self.grid_side as f32;
        let vertex_positions: [[f32; 4]; 6] = [
            [0.0, 0.0, 0.0, 1.0],
            [cell_w, 0.0, 0.0, 1.0],
            [0.0, cell_h, 0.0, 1.0],
            [0.0, cell_h, 0.0, 1.0],
            [cell_w, 0.0, 0.0, 1.0],
            [cell_w, cell_h, 0.0, 1.0],
        ];

        let indices: [u16; 6] = [0, 4, 3, 2, 1, 5];

        let mut offsets: Vec<[f32; 4]> = Vec::new();
        for x in 0..self.grid_side {
            for y in 0..self.grid_side {
                offsets.push([x as f32 * cell_w - 1.0, y as f32 * cell_w - 1.0, 0.0, 0.0]);
            }
        }

        let mut colors: Vec<[f32; 4]> = Vec::new();
        for x in 0..self.grid_side {
            for y in 0..self.grid_side {
                colors.push(if (x + y) % 2 == 0 { green } else { yellow });
            }
        }

        let vao = VertexArray::new(gl);
        let position_buf = Buffer::new(gl);
        let offset_buf = Buffer::new(gl);
        let color_buf = Buffer::new(gl);
        let index_buf = Buffer::new(gl);
        let draw_indirect_buf = Buffer::new(gl);

        // SAFETY: names this case generated and arrays that outlive each upload.
        unsafe {
            gl.bind_vertex_array(vao.get());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, position_buf.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&vertex_positions) as GLsizeiptr,
                vertex_positions.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            gl.vertex_attrib_pointer(pos_location, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.vertex_attrib_divisor(pos_location, 0);
            gl.enable_vertex_attrib_array(pos_location);

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, offset_buf.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(offsets.as_slice()) as GLsizeiptr,
                offsets.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            gl.vertex_attrib_pointer(offset_location, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.vertex_attrib_divisor(offset_location, 1);
            gl.enable_vertex_attrib_array(offset_location);

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, color_buf.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(colors.as_slice()) as GLsizeiptr,
                colors.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            gl.vertex_attrib_pointer(color_location, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.vertex_attrib_divisor(color_location, 1);
            gl.enable_vertex_attrib_array(color_location);

            if self.use_indices {
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buf.get());
                gl.buffer_data(
                    glw::GL_ELEMENT_ARRAY_BUFFER,
                    size_of_val(&indices) as GLsizeiptr,
                    indices.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
            }

            gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, draw_indirect_buf.get());

            let prim_count = (self.grid_side * self.grid_side) as u32;
            if self.use_indices {
                // count, primCount, firstIndex, baseVertex, reservedMustBeZero
                let command: [u32; 5] = [6, prim_count, 0, 0, 0];
                gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    size_of_val(&command) as GLsizeiptr,
                    command.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
            } else {
                // count, primCount, first, reservedMustBeZero
                let command: [u32; 4] = [6, prim_count, 0, 0];
                gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    size_of_val(&command) as GLsizeiptr,
                    command.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
            }

            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            gl.viewport(0, 0, dst.get_width(), dst.get_height());

            gl.use_program(program.program());
            if self.use_indices {
                gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_SHORT, std::ptr::null());
            } else {
                gl.draw_arrays_indirect(glw::GL_TRIANGLES, std::ptr::null());
            }
            gl.use_program(0);
        }
        glu::expect_no_error(gl, "draw")?;

        // SAFETY: nothing but a current context.
        unsafe { gl.finish() };
        glu::read_pixels(&context.render_context, 0, 0, &mut dst.get_access())?;
        glu::expect_no_error(gl, "readPixels")?;

        // verify image
        // \note the green/yellow pattern is only for clarity. The test will only verify that all instances were drawn by looking for anything non-green/yellow.
        if verify_image_yellow_green(&dst) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Result image invalid"))
        }
    }
}

/// `InstancingGroup::init`
pub fn create_tests() -> TestCaseGroup {
    const GRID_WIDTHS: [i32; 5] = [2, 5, 10, 32, 100];

    let mut group = TestCaseGroup::new("instancing");

    // drawArrays
    for grid_side in GRID_WIDTHS {
        let name = format!("draw_arrays_indirect_grid_{grid_side}x{grid_side}");
        group.add_child(Box::new(InstancedGridRenderTest {
            name,
            grid_side,
            use_indices: false,
        }) as Box<dyn TestCase>);
    }

    // drawElements
    for grid_side in GRID_WIDTHS {
        let name = format!("draw_elements_indirect_grid_{grid_side}x{grid_side}");
        group.add_child(Box::new(InstancedGridRenderTest {
            name,
            grid_side,
            use_indices: true,
        }) as Box<dyn TestCase>);
    }

    group
}

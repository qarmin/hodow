// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cDrawIndirectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `CNegative*` classes share one `Negative` struct with a `Kind`; each kind's `run` is the body of the class of the same name. `CNegativeNoVBO*` and `CNegativeXFB` are not ported: upstream defines them but registers none of the three.

use std::ffi::c_void;

use super::draw_cases::compare_region;
use super::{
    Color, DiResult, DrawArraysIndirectCommand, DrawElementsIndirectCommand, add_case, create_program, fsh_simple,
    primitive_gen, vsh_simple, window_height, window_width,
};
use crate::glu::{Context, TestCaseGroup};
use crate::glw::{self, GLenum, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};

const COLOR_SIZE: usize = std::mem::size_of::<Color>();

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    ZeroBufferArray,
    ZeroBufferElements,
    InvalidModeArray,
    InvalidModeElements,
    NoVaoArrays,
    NoVaoElements,
    BufferMappedArray,
    BufferMappedElements,
    DataWrongElements,
    GshArray,
    GshElements,
    InvalidSizeArrays,
    InvalidSizeElements,
    WrongOffsetArray,
    WrongOffsetElements,
    UnalignedOffset,
}

impl Kind {
    fn is_elements(self) -> bool {
        matches!(
            self,
            Self::ZeroBufferElements
                | Self::InvalidModeElements
                | Self::NoVaoElements
                | Self::BufferMappedElements
                | Self::DataWrongElements
                | Self::GshElements
                | Self::WrongOffsetElements
                | Self::UnalignedOffset
        )
    }

    fn clears_in_setup(self) -> bool {
        self != Self::UnalignedOffset
    }
}

/// `CNegative*`
struct Negative {
    kind: Kind,
    program: GLuint,
    vao: GLuint,
    buffer: GLuint,
    ebo: GLuint,
    buffer_indirect: GLuint,
}

fn expect_error(gl: &glw::Functions, result: &mut DiResult, expected: GLenum, message: &str) {
    if gl!(gl.get_error()) != expected {
        result.error(message);
    }
}

fn offset_pointer(offset: usize) -> *const c_void {
    offset as *const c_void
}

fn gsh_vsh() -> &'static str {
    "#version 150\nin vec4 coords;\nvoid main() {\n  gl_Position = coords;\n}"
}

fn gsh_fsh() -> &'static str {
    "#version 140\nout vec4 outColor;\nvoid main() {\n  outColor = vec4(0.1f, 0.2f, 0.3f, 1.0f);\n}"
}

fn gsh_array_gsh() -> &'static str {
    "#version 150\nlayout(triangles) in;\nlayout(triangle_strip, max_vertices = 10) out;\nvoid main() {\n for (int i=0; i<gl_in.length(); ++i) {\n     gl_Position = gl_in[i].gl_Position;\n     EmitVertex();\n }\n}"
}

fn gsh_elements_gsh() -> &'static str {
    "#version 150\nlayout(lines) in;\nlayout(line_strip, max_vertices = 10) out;\nvoid main() {\n for (int i=0; i<gl_in.length(); ++i) {\n     gl_Position = gl_in[i].gl_Position;\n     EmitVertex();\n }\n}"
}

impl Negative {
    fn new(kind: Kind) -> Self {
        Self {
            kind,
            program: 0,
            vao: 0,
            buffer: 0,
            ebo: 0,
            buffer_indirect: 0,
        }
    }

    fn nothing_rendered(context: &Context) -> i64 {
        compare_region(context, 0, 0, window_width(context), window_height(context), [0.0; 4])
    }

    /// The program, VAO and vertex buffer every kind but `UnalignedOffset` builds first; `with_vao` is false for `NoVao*`.
    fn setup_vertices(
        &mut self,
        context: &Context,
        with_vao: bool,
    ) -> Result<Option<Vec<Color>>, crate::tcu::TestError> {
        let gl = context.gl();
        self.program = create_program(gl, &vsh_simple(), "", &fsh_simple(), true);
        if self.program == 0 {
            return Ok(None);
        }
        gl!(gl.use_program(self.program));

        let mut coords: Vec<Color> = Vec::new();
        primitive_gen(context, glw::GL_TRIANGLES, 8, 8, &mut coords)?;

        if with_vao {
            gl!(gl.gen_vertex_arrays(1, &mut self.vao));
            gl!(gl.bind_vertex_array(self.vao));
        }

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (coords.len() * COLOR_SIZE) as isize,
            coords.as_ptr().cast(),
            glw::GL_STREAM_DRAW
        ));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, COLOR_SIZE as i32, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));
        Ok(Some(coords))
    }

    fn create_indirect_arrays(&mut self, gl: &glw::Functions, count: usize) {
        let command = DrawArraysIndirectCommand {
            count: count as GLuint,
            prim_count: 1,
            first: 0,
            reserved_must_be_zero: 0,
        };
        gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
        gl!(gl.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            std::mem::size_of::<DrawArraysIndirectCommand>() as isize,
            std::ptr::from_ref(&command).cast(),
            glw::GL_STATIC_DRAW
        ));
    }

    fn create_indirect_elements(&mut self, gl: &glw::Functions, count: usize) {
        let command = DrawElementsIndirectCommand {
            count: count as GLuint,
            prim_count: 1,
            first_index: 0,
            base_vertex: 0,
            reserved_must_be_zero: 0,
        };
        gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
        gl!(gl.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            std::mem::size_of::<DrawElementsIndirectCommand>() as isize,
            std::ptr::from_ref(&command).cast(),
            glw::GL_STATIC_DRAW
        ));
    }

    fn create_element_buffer(&mut self, gl: &glw::Functions, count: usize) {
        let elements: Vec<GLuint> = (0..count as GLuint).collect();
        gl!(gl.gen_buffers(1, &mut self.ebo));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo));
        gl!(gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            (elements.len() * std::mem::size_of::<GLuint>()) as isize,
            elements.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
    }

    fn run_unaligned_offset(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.program = create_program(gl, &vsh_simple(), "", &fsh_simple(), true);
        if self.program == 0 {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.bind_vertex_array(self.vao));

        let zarro = vec![0u32; 4096];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 4096, zarro.as_ptr().cast(), glw::GL_STREAM_DRAW));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, 0, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));

        gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
        gl!(gl.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            4096,
            zarro.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.gen_buffers(1, &mut self.ebo));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo));
        gl!(gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            4096,
            zarro.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        let mut result = DiResult::new();
        for offset in [1usize, 3, 1023] {
            gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, offset_pointer(offset)));
            expect_error(
                gl,
                &mut result,
                glw::GL_INVALID_VALUE,
                "Invalid error code returned by a driver for GL_INVALID_VALUE type",
            );

            gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, offset_pointer(offset)));
            expect_error(
                gl,
                &mut result,
                glw::GL_INVALID_VALUE,
                "Invalid error code returned by a driver for GL_INVALID_VALUE type",
            );
        }
        Ok(result.code())
    }

    fn run_gsh(&mut self, context: &Context, elements: bool) -> SubcaseResult {
        let gl = context.gl();
        let geometry_shader = if elements { gsh_elements_gsh() } else { gsh_array_gsh() };
        self.program = create_program(gl, gsh_vsh(), geometry_shader, gsh_fsh(), true);
        if self.program == 0 {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        let mut coords: Vec<Color> = Vec::new();
        primitive_gen(context, glw::GL_TRIANGLES, 8, 8, &mut coords)?;

        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.bind_vertex_array(self.vao));

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (coords.len() * COLOR_SIZE) as isize,
            coords.as_ptr().cast(),
            glw::GL_STREAM_DRAW
        ));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, COLOR_SIZE as i32, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));

        let mut result = DiResult::new();
        if elements {
            self.create_indirect_elements(gl, coords.len());
            self.create_element_buffer(gl, coords.len());
            gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, std::ptr::null()));
        } else {
            self.create_indirect_arrays(gl, coords.len());
            gl!(gl.draw_arrays_indirect(glw::GL_POINTS, std::ptr::null()));
        }
        expect_error(
            gl,
            &mut result,
            glw::GL_INVALID_OPERATION,
            "Invalid error code returned by a driver for GL_INVALID_OPERATION type",
        );

        result.sub_result(Self::nothing_rendered(context));
        Ok(result.code())
    }

    fn run_mapped(&mut self, context: &Context, elements: bool) -> SubcaseResult {
        let gl = context.gl();
        let Some(coords) = self.setup_vertices(context, true)? else {
            return Ok(ERROR);
        };

        let command_size = if elements {
            self.create_indirect_elements(gl, coords.len());
            self.create_element_buffer(gl, coords.len());
            std::mem::size_of::<DrawElementsIndirectCommand>()
        } else {
            self.create_indirect_arrays(gl, coords.len());
            std::mem::size_of::<DrawArraysIndirectCommand>()
        };

        let mut result = DiResult::new();
        let access = if elements {
            glw::GL_MAP_WRITE_BIT
        } else {
            glw::GL_MAP_READ_BIT
        };
        let buf = gl!(gl.map_buffer_range(glw::GL_DRAW_INDIRECT_BUFFER, 0, command_size as isize, access));
        if buf.is_null() {
            result.error(if elements {
                "glMapBuffer(GL_DRAW_INDIRECT_BUFFER, GL_MAP_WRITE_BIT) returned NULL"
            } else {
                "glMapBuffer(GL_DRAW_INDIRECT_BUFFER, GL_MAP_READ_BIT) returned NULL"
            });
        }

        if elements {
            gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, std::ptr::null()));
        } else {
            gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, std::ptr::null()));
        }

        let error = gl!(gl.get_error());
        if error == glw::GL_INVALID_OPERATION {
            // GL error: nothing is rendered
            result.sub_result(Self::nothing_rendered(context));
        } else if error == glw::GL_NO_ERROR {
            // No GL error: undefined
        } else {
            result.error("Invalid error code returned by a driver");
        }

        if !buf.is_null() && gl!(gl.unmap_buffer(glw::GL_DRAW_INDIRECT_BUFFER)) != super::GL_TRUE_BYTE {
            result.error("glUnmapBuffer(GL_DRAW_INDIRECT_BUFFER) returned GL_FALSE, expected GL_TRUE");
        }
        Ok(result.code())
    }
}

impl Subcase for Negative {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        if self.kind.clears_in_setup() {
            gl!(context.gl().clear(glw::GL_COLOR_BUFFER_BIT));
        }
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();

        match self.kind {
            Kind::UnalignedOffset => return self.run_unaligned_offset(context),
            Kind::GshArray => return self.run_gsh(context, false),
            Kind::GshElements => return self.run_gsh(context, true),
            Kind::BufferMappedArray => return self.run_mapped(context, false),
            Kind::BufferMappedElements => return self.run_mapped(context, true),
            _ => {}
        }

        let with_vao = !matches!(self.kind, Kind::NoVaoArrays | Kind::NoVaoElements);
        let Some(coords) = self.setup_vertices(context, with_vao)? else {
            return Ok(ERROR);
        };
        let len = coords.len();

        match self.kind {
            Kind::ZeroBufferArray => {
                gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, std::ptr::null()));
                expect_error(
                    gl,
                    &mut result,
                    glw::GL_INVALID_OPERATION,
                    "Invalid error code returned by a driver",
                );
            }
            Kind::ZeroBufferElements => {
                self.create_element_buffer(gl, len);
                gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, std::ptr::null()));
                expect_error(
                    gl,
                    &mut result,
                    glw::GL_INVALID_OPERATION,
                    "Invalid error code returned by a driver",
                );
            }
            Kind::InvalidModeArray => {
                self.create_indirect_arrays(gl, len);
                let modes: [(GLenum, &str); 6] = [
                    (glw::GL_FLOAT, "GL_FLOAT"),
                    (glw::GL_STATIC_DRAW, "GL_STATIC_DRAW"),
                    (glw::GL_DRAW_INDIRECT_BUFFER, "GL_DRAW_INDIRECT_BUFFER"),
                    (glw::GL_INVALID_ENUM, "GL_INVALID_ENUM"),
                    (glw::GL_COLOR_BUFFER_BIT, "GL_COLOR_BUFFER_BIT"),
                    (glw::GL_ARRAY_BUFFER, "GL_ARRAY_BUFFER"),
                ];
                for (mode, name) in modes {
                    gl!(gl.draw_arrays_indirect(mode, std::ptr::null()));
                    expect_error(
                        gl,
                        &mut result,
                        glw::GL_INVALID_ENUM,
                        &format!("Invalid error code returned by a driver for {name} as mode"),
                    );
                }
            }
            Kind::InvalidModeElements => {
                self.create_indirect_elements(gl, len);
                self.create_element_buffer(gl, len);
                let modes: [(GLenum, &str); 5] = [
                    (glw::GL_INVALID_ENUM, "GL_FLOAT"),
                    (glw::GL_UNSIGNED_INT, "GL_UNSIGNED_INT"),
                    (glw::GL_ELEMENT_ARRAY_BUFFER, "GL_ELEMENT_ARRAY_BUFFER"),
                    (glw::GL_FASTEST, "GL_FASTEST"),
                    (glw::GL_PACK_ALIGNMENT, "GL_PACK_ALIGNMENT"),
                ];
                for (mode, name) in modes {
                    gl!(gl.draw_elements_indirect(mode, glw::GL_UNSIGNED_INT, std::ptr::null()));
                    expect_error(
                        gl,
                        &mut result,
                        glw::GL_INVALID_ENUM,
                        &format!("Invalid error code returned by a driver for {name} as mode"),
                    );
                }
            }
            Kind::NoVaoArrays => {
                self.create_indirect_arrays(gl, len);
                gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, std::ptr::null()));
                expect_error(
                    gl,
                    &mut result,
                    glw::GL_INVALID_OPERATION,
                    "Invalid error code returned by a driver",
                );
            }
            Kind::NoVaoElements => {
                self.create_indirect_elements(gl, len);
                self.create_element_buffer(gl, len);
                gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, std::ptr::null()));
                expect_error(
                    gl,
                    &mut result,
                    glw::GL_INVALID_OPERATION,
                    "Invalid error code returned by a driver",
                );
            }
            Kind::DataWrongElements => {
                self.create_indirect_elements(gl, len);
                self.create_element_buffer(gl, len);
                let types: [(GLenum, &str); 7] = [
                    (glw::GL_FLOAT, "GL_FLOAT"),
                    (glw::GL_INT, "GL_INT"),
                    (glw::GL_STATIC_DRAW, "GL_STATIC_DRAW"),
                    (glw::GL_SHORT, "GL_SHORT"),
                    (glw::GL_BYTE, "GL_BYTE"),
                    (glw::GL_DOUBLE, "GL_DOUBLE"),
                    (glw::GL_INVALID_ENUM, "GL_INVALID_ENUM"),
                ];
                for (type_, name) in types {
                    gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, type_, std::ptr::null()));
                    expect_error(
                        gl,
                        &mut result,
                        glw::GL_INVALID_ENUM,
                        &format!("Invalid error code returned by a driver for {name} type"),
                    );
                }
            }
            Kind::InvalidSizeArrays => {
                // TWrongStructure1 {GLuint count, primCount} and TWrongStructure2 {GLfloat count, GLuint primCount}
                let wrong1: [GLuint; 2] = [len as GLuint, 1];
                gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
                gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    std::mem::size_of_val(&wrong1) as isize,
                    wrong1.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, std::ptr::null()));
                expect_error(
                    gl,
                    &mut result,
                    glw::GL_INVALID_OPERATION,
                    "Invalid error code returned by a driver for GL_INVALID_OPERATION type",
                );

                gl!(gl.delete_buffers(1, &self.buffer_indirect));
                let wrong2: [u32; 2] = [(len as f32).to_bits(), 1];
                gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
                gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    std::mem::size_of_val(&wrong2) as isize,
                    wrong2.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, std::ptr::null()));
                expect_error(
                    gl,
                    &mut result,
                    glw::GL_INVALID_OPERATION,
                    "Invalid error code returned by a driver for GL_INVALID_OPERATION type",
                );
            }
            Kind::InvalidSizeElements => {
                // `indirectElements` is a DrawArraysIndirectCommand here, one word short of what glDrawElementsIndirect reads.
                self.create_indirect_arrays(gl, len);
                self.create_element_buffer(gl, len);
                gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, std::ptr::null()));
                expect_error(
                    gl,
                    &mut result,
                    glw::GL_INVALID_OPERATION,
                    "Invalid error code returned by a driver for GL_INVALID_OPERATION type",
                );

                let wrong: [u32; 2] = [(len as f32).to_bits(), 1];
                gl!(gl.delete_buffers(1, &self.buffer_indirect));
                gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
                gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    std::mem::size_of_val(&wrong) as isize,
                    wrong.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, std::ptr::null()));
                expect_error(
                    gl,
                    &mut result,
                    glw::GL_INVALID_OPERATION,
                    "Invalid error code returned by a driver for GL_INVALID_OPERATION type",
                );
            }
            Kind::WrongOffsetArray => {
                self.create_indirect_arrays(gl, len);
                for offset in [
                    std::mem::size_of::<DrawArraysIndirectCommand>() * 2,
                    std::mem::size_of::<GLuint>(),
                ] {
                    gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, offset_pointer(offset)));
                    expect_error(
                        gl,
                        &mut result,
                        glw::GL_INVALID_OPERATION,
                        "Invalid error code returned by a driver for GL_INVALID_OPERATION type",
                    );
                }
            }
            Kind::WrongOffsetElements => {
                self.create_indirect_elements(gl, len);
                self.create_element_buffer(gl, len);
                for offset in [
                    std::mem::size_of::<DrawElementsIndirectCommand>() * 2,
                    std::mem::size_of::<GLuint>(),
                ] {
                    gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, offset_pointer(offset)));
                    expect_error(
                        gl,
                        &mut result,
                        glw::GL_INVALID_OPERATION,
                        "Invalid error code returned by a driver for GL_INVALID_OPERATION type",
                    );
                }
            }
            Kind::UnalignedOffset
            | Kind::GshArray
            | Kind::GshElements
            | Kind::BufferMappedArray
            | Kind::BufferMappedElements => unreachable!("handled above"),
        }

        result.sub_result(Self::nothing_rendered(context));
        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if self.vao != 0 {
            gl!(gl.disable_vertex_attrib_array(0));
        }
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        if self.vao != 0 {
            gl!(gl.delete_vertex_arrays(1, &self.vao));
        }
        gl!(gl.delete_buffers(1, &self.buffer));
        if self.kind.is_elements() {
            gl!(gl.delete_buffers(1, &self.ebo));
        }
        gl!(gl.delete_buffers(1, &self.buffer_indirect));
        Ok(NO_ERROR)
    }
}

pub(super) fn add_negative_cases(group: &mut TestCaseGroup) {
    let cases: [(&str, Kind); 16] = [
        ("negative-noindirect-arrays", Kind::ZeroBufferArray),
        ("negative-noindirect-elements", Kind::ZeroBufferElements),
        ("negative-invalidMode-arrays", Kind::InvalidModeArray),
        ("negative-invalidMode-elements", Kind::InvalidModeElements),
        ("negative-noVAO-arrays", Kind::NoVaoArrays),
        ("negative-noVAO-elements", Kind::NoVaoElements),
        ("negative-bufferMapped-arrays", Kind::BufferMappedArray),
        ("negative-bufferMapped-elements", Kind::BufferMappedElements),
        ("negative-invalidType-elements", Kind::DataWrongElements),
        ("negative-gshIncompatible-arrays", Kind::GshArray),
        ("negative-gshIncompatible-elements", Kind::GshElements),
        ("negative-wrongOffset-arrays", Kind::WrongOffsetArray),
        ("negative-wrongOffset-elements", Kind::WrongOffsetElements),
        ("negative-invalidSize-arrays", Kind::InvalidSizeArrays),
        ("negative-invalidSize-elements", Kind::InvalidSizeElements),
        ("negative-unalignedOffset", Kind::UnalignedOffset),
    ];
    for (name, kind) in cases {
        add_case(group, name, move || Box::new(Negative::new(kind)));
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cDrawIndirectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The seven `CBufferIndirectDraw{Arrays,Elements}*` classes that differ only in the command they upload are one struct with a `Variant`.

use std::ffi::{CString, c_void};

use super::{
    Color, DiResult, DrawArraysIndirectCommand, DrawElementsIndirectCommand, DrawFunction, add_case, buffers_compare,
    check_program, create_program, fsh_simple, primitive_gen, read_pixels_float, vsh_simple, window_height,
    window_width,
};
use crate::glu::{Context, TestCaseGroup};
use crate::glw::{self, GLenum, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};

const COLOR: Color = [0.1, 0.2, 0.3, 1.0];
const CLEAR: Color = [0.0, 0.0, 0.0, 0.0];

fn float_size() -> usize {
    std::mem::size_of::<f32>()
}

fn color_bytes(count: usize) -> isize {
    (count * std::mem::size_of::<Color>()) as isize
}

fn offset_pointer(offset: usize) -> *const c_void {
    offset as *const c_void
}

fn size_of_val<T>(_: &T) -> isize {
    std::mem::size_of::<T>() as isize
}

/// Reads one rectangle of the window and compares it with a single color, the way the `bufferRef`/`bufferTest` pairs of the cases do.
pub(super) fn compare_region(context: &Context, x: i32, y: i32, width: i32, height: i32, expected: Color) -> i64 {
    let gl = context.gl();
    let mut buffer_test: Vec<Color> = vec![[0.0; 4]; (width * height) as usize];
    read_pixels_float(gl, x, y, width, height, &mut buffer_test);
    let buffer_ref: Vec<Color> = vec![expected; (width * height) as usize];
    buffers_compare(
        context,
        &buffer_test,
        width as u32,
        height as u32,
        &buffer_ref,
        width as u32,
        height as u32,
    )
}

/// The origins of the four window quadrants the instancing cases read.
fn quadrant_origins(context: &Context) -> [(i32, i32); 4] {
    let (w, h) = (window_width(context), window_height(context));
    [(0, 0), ((w + 1) / 2, 0), (0, (h + 1) / 2), ((w + 1) / 2, (h + 1) / 2)]
}

fn indirect_arrays_once(gl: &glw::Functions, mode: GLenum, command: &DrawArraysIndirectCommand) {
    let mut buffer: GLuint = 0;
    gl!(gl.gen_buffers(1, &mut buffer));
    gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, buffer));
    gl!(gl.buffer_data(
        glw::GL_DRAW_INDIRECT_BUFFER,
        size_of_val(command),
        std::ptr::from_ref(command).cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.draw_arrays_indirect(mode, std::ptr::null()));
    gl!(gl.delete_buffers(1, &buffer));
}

fn indirect_elements_once(
    gl: &glw::Functions,
    mode: GLenum,
    command: &DrawElementsIndirectCommand,
    ebo: &mut GLuint,
    elements: &[u32],
) {
    gl!(gl.gen_buffers(1, ebo));
    gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, *ebo));
    gl!(gl.buffer_data(
        glw::GL_ELEMENT_ARRAY_BUFFER,
        std::mem::size_of_val(elements) as isize,
        elements.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));

    let mut buffer: GLuint = 0;
    gl!(gl.gen_buffers(1, &mut buffer));
    gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, buffer));
    gl!(gl.buffer_data(
        glw::GL_DRAW_INDIRECT_BUFFER,
        size_of_val(command),
        std::ptr::from_ref(command).cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.draw_elements_indirect(mode, glw::GL_UNSIGNED_INT, std::ptr::null()));
    gl!(gl.delete_buffers(1, &buffer));
}

fn sequential_elements(count: usize) -> Vec<u32> {
    (0..count as u32).collect()
}

/// The objects `CBasicVertexDef` and its siblings clean up in the same way.
#[derive(Default)]
struct DrawObjects {
    vao: GLuint,
    vbo: GLuint,
    ebo: GLuint,
    program: GLuint,
}

impl DrawObjects {
    fn cleanup(&self, gl: &glw::Functions) {
        gl!(gl.disable_vertex_attrib_array(0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.use_program(0));

        if self.vao != 0 {
            gl!(gl.delete_vertex_arrays(1, &self.vao));
        }
        if self.vbo != 0 {
            gl!(gl.delete_buffers(1, &self.vbo));
        }
        if self.ebo != 0 {
            gl!(gl.delete_buffers(1, &self.ebo));
        }
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
    }
}

fn clear_color_buffer(context: &Context) -> SubcaseResult {
    gl!(context.gl().clear(glw::GL_COLOR_BUFFER_BIT));
    Ok(NO_ERROR)
}

/// `CBasicVertexDef`
struct BasicVertex {
    draw_func: DrawFunction,
    primitive_type: GLenum,
    draw_size_x: u32,
    draw_size_y: u32,
    objects: DrawObjects,
}

impl BasicVertex {
    fn new(draw_func: DrawFunction, primitive_type: GLenum, draw_size_x: u32, draw_size_y: u32) -> Self {
        Self {
            draw_func,
            primitive_type,
            draw_size_x,
            draw_size_y,
            objects: DrawObjects::default(),
        }
    }
}

impl Subcase for BasicVertex {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        clear_color_buffer(context)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut coords: Vec<Color> = Vec::new();
        primitive_gen(
            context,
            self.primitive_type,
            self.draw_size_x,
            self.draw_size_y,
            &mut coords,
        )?;

        self.objects.program = create_program(gl, &vsh_simple(), "", &fsh_simple(), true);
        if self.objects.program == 0 {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.objects.program));

        gl!(gl.gen_buffers(1, &mut self.objects.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.objects.vbo));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            color_bytes(coords.len()),
            coords.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.gen_vertex_arrays(1, &mut self.objects.vao));
        gl!(gl.bind_vertex_array(self.objects.vao));
        gl!(gl.vertex_attrib_pointer(
            0,
            4,
            glw::GL_FLOAT,
            0,
            std::mem::size_of::<Color>() as i32,
            std::ptr::null()
        ));
        gl!(gl.enable_vertex_attrib_array(0));

        let elements = sequential_elements(coords.len());

        match self.draw_func {
            DrawFunction::DrawArrays => {
                let command = DrawArraysIndirectCommand {
                    count: coords.len() as u32,
                    prim_count: 1,
                    first: 0,
                    reserved_must_be_zero: 0,
                };
                indirect_arrays_once(gl, self.primitive_type, &command);
            }
            DrawFunction::DrawElements => {
                let command = DrawElementsIndirectCommand {
                    count: coords.len() as u32,
                    prim_count: 1,
                    first_index: 0,
                    base_vertex: 0,
                    reserved_must_be_zero: 0,
                };
                indirect_elements_once(gl, self.primitive_type, &command, &mut self.objects.ebo, &elements);
            }
        }

        let mut result = DiResult::new();
        result.sub_result(compare_region(
            context,
            0,
            0,
            window_width(context),
            window_height(context),
            COLOR,
        ));
        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        self.objects.cleanup(context.gl());
        Ok(NO_ERROR)
    }
}

/// `CBasicVertexInstancingDef`
struct BasicVertexInstancing {
    draw_func: DrawFunction,
    objects: DrawObjects,
}

const INSTANCED_COORDS: [Color; 4] = [
    [0.5, 0.5, 0.0, 0.0],
    [-0.5, 0.5, 0.0, 0.0],
    [-0.5, -0.5, 0.0, 0.0],
    [0.5, -0.5, 0.0, 0.0],
];

impl Subcase for BasicVertexInstancing {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        clear_color_buffer(context)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut coords: Vec<Color> = Vec::new();
        primitive_gen(context, glw::GL_TRIANGLES, 2, 2, &mut coords)?;

        let colors_instanced: [Color; 2] = [[1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0]];

        self.objects.program = create_program(gl, &self.vsh(), "", &self.fsh(), true);
        if self.objects.program == 0 {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.objects.program));

        gl!(gl.gen_buffers(1, &mut self.objects.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.objects.vbo));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            color_bytes(coords.len() + INSTANCED_COORDS.len() + colors_instanced.len()),
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));

        let coords_offset = 0usize;
        let coords_instanced_offset = coords_offset + coords.len() * std::mem::size_of::<Color>();
        let colors_instanced_offset = coords_instanced_offset + INSTANCED_COORDS.len() * std::mem::size_of::<Color>();

        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            coords_offset as isize,
            color_bytes(coords.len()),
            coords.as_ptr().cast()
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            coords_instanced_offset as isize,
            color_bytes(INSTANCED_COORDS.len()),
            INSTANCED_COORDS.as_ptr().cast()
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            colors_instanced_offset as isize,
            color_bytes(colors_instanced.len()),
            colors_instanced.as_ptr().cast()
        ));

        gl!(gl.gen_vertex_arrays(1, &mut self.objects.vao));
        gl!(gl.bind_vertex_array(self.objects.vao));

        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, 0, offset_pointer(coords_offset)));
        gl!(gl.enable_vertex_attrib_array(0));

        gl!(gl.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, 0, 0, offset_pointer(coords_instanced_offset)));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.vertex_attrib_divisor(1, 1));

        gl!(gl.vertex_attrib_pointer(2, 4, glw::GL_FLOAT, 0, 0, offset_pointer(colors_instanced_offset)));
        gl!(gl.enable_vertex_attrib_array(2));
        gl!(gl.vertex_attrib_divisor(2, 3));

        let elements = sequential_elements(coords.len());

        match self.draw_func {
            DrawFunction::DrawArrays => {
                let command = DrawArraysIndirectCommand {
                    count: coords.len() as u32,
                    prim_count: 4,
                    first: 0,
                    reserved_must_be_zero: 0,
                };
                indirect_arrays_once(gl, glw::GL_TRIANGLES, &command);
            }
            DrawFunction::DrawElements => {
                let command = DrawElementsIndirectCommand {
                    count: coords.len() as u32,
                    prim_count: 4,
                    first_index: 0,
                    base_vertex: 0,
                    reserved_must_be_zero: 0,
                };
                indirect_elements_once(gl, glw::GL_TRIANGLES, &command, &mut self.objects.ebo, &elements);
            }
        }

        let (half_w, half_h) = (window_width(context) / 2, window_height(context) / 2);
        let expected = [
            colors_instanced[0],
            colors_instanced[1],
            colors_instanced[0],
            colors_instanced[0],
        ];
        let mut result = DiResult::new();
        for ((x, y), color) in quadrant_origins(context).into_iter().zip(expected) {
            result.sub_result(compare_region(context, x, y, half_w, half_h, color));
        }
        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        self.objects.cleanup(context.gl());
        Ok(NO_ERROR)
    }
}

impl BasicVertexInstancing {
    fn vsh(&self) -> String {
        format!(
            "{}\nlayout(location = 0) in vec4 i_vertex;\nlayout(location = 1) in vec4 i_vertex_instanced;\nlayout(location = 2) in vec4 i_vertex_color_instanced;\nout vec4 vertex_color_instanced;\nvoid main()\n{{\n    gl_Position = vec4(i_vertex.xyz * .5, 1.0) + i_vertex_instanced;\n    vertex_color_instanced = i_vertex_color_instanced;\n}}",
            super::GLSL_VER_GL
        )
    }

    fn fsh(&self) -> String {
        format!(
            "{}\nprecision highp float; \nin  vec4 vertex_color_instanced;\nout vec4 outColor;\nvoid main() {{\n  outColor = vertex_color_instanced;\n}}",
            super::GLSL_VER_GL
        )
    }
}

/// `CBasicXFBPausedDef`
struct BasicXfbPaused {
    draw_func: DrawFunction,
    objects: DrawObjects,
    xfbo: GLuint,
    xfo: GLuint,
}

impl BasicXfbPaused {
    fn new(draw_func: DrawFunction) -> Self {
        Self {
            draw_func,
            objects: DrawObjects::default(),
            xfbo: 0,
            xfo: 0,
        }
    }

    fn vsh() -> String {
        format!(
            "{}\nin vec4 i_vertex;\nout vec4 dataOut;\nvoid main()\n{{\n    gl_Position = i_vertex;\n    dataOut = i_vertex;\n}}",
            super::GLSL_VER_GL
        )
    }
}

impl Subcase for BasicXfbPaused {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        clear_color_buffer(context)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut coords: Vec<Color> = Vec::new();
        primitive_gen(context, glw::GL_TRIANGLES, 2, 2, &mut coords)?;

        self.objects.program = create_program(gl, &Self::vsh(), "", &fsh_simple(), false);
        let varying = CString::new("dataOut").expect("no nul byte");
        let varyings = [varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(self.objects.program, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        gl!(gl.link_program(self.objects.program));
        if !check_program(gl, self.objects.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.objects.program));

        gl!(gl.gen_buffers(1, &mut self.objects.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.objects.vbo));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            color_bytes(coords.len()),
            coords.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.gen_vertex_arrays(1, &mut self.objects.vao));
        gl!(gl.bind_vertex_array(self.objects.vao));
        gl!(gl.vertex_attrib_pointer(
            0,
            4,
            glw::GL_FLOAT,
            0,
            std::mem::size_of::<Color>() as i32,
            std::ptr::null()
        ));
        gl!(gl.enable_vertex_attrib_array(0));

        let elements = sequential_elements(coords.len());

        gl!(gl.gen_transform_feedbacks(1, &mut self.xfo));
        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.xfo));

        gl!(gl.gen_buffers(1, &mut self.xfbo));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.xfbo));
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            1024,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.xfbo));

        gl!(gl.begin_transform_feedback(glw::GL_TRIANGLES));
        gl!(gl.pause_transform_feedback());

        match self.draw_func {
            DrawFunction::DrawArrays => {
                let command = DrawArraysIndirectCommand {
                    count: coords.len() as u32,
                    prim_count: 1,
                    first: 0,
                    reserved_must_be_zero: 0,
                };
                indirect_arrays_once(gl, glw::GL_TRIANGLES, &command);
            }
            DrawFunction::DrawElements => {
                let command = DrawElementsIndirectCommand {
                    count: coords.len() as u32,
                    prim_count: 1,
                    first_index: 0,
                    base_vertex: 0,
                    reserved_must_be_zero: 0,
                };
                indirect_elements_once(gl, glw::GL_TRIANGLES, &command, &mut self.objects.ebo, &elements);
            }
        }

        gl!(gl.resume_transform_feedback());
        gl!(gl.end_transform_feedback());

        let mut result = DiResult::new();
        result.sub_result(compare_region(
            context,
            0,
            0,
            window_width(context),
            window_height(context),
            COLOR,
        ));
        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable_vertex_attrib_array(0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.use_program(0));

        if self.objects.vao != 0 {
            gl!(gl.delete_vertex_arrays(1, &self.objects.vao));
        }
        if self.objects.vbo != 0 {
            gl!(gl.delete_buffers(1, &self.objects.vbo));
        }
        if self.objects.ebo != 0 {
            gl!(gl.delete_buffers(1, &self.objects.ebo));
        }
        if self.xfbo != 0 {
            gl!(gl.delete_buffers(1, &self.xfbo));
        }
        if self.objects.program != 0 {
            gl!(gl.delete_program(self.objects.program));
        }
        if self.xfo != 0 {
            gl!(gl.delete_transform_feedbacks(1, &self.xfo));
        }
        Ok(NO_ERROR)
    }
}

/// `CBasicVertexIDsDef`
struct BasicVertexIds {
    draw_func: DrawFunction,
    objects: DrawObjects,
}

impl BasicVertexIds {
    fn vsh() -> String {
        format!(
            "{}\nlayout(location = 0) in vec4 i_vertex;\nlayout(location = 1) in vec4 i_vertex_instanced;\nlayout(location = 2) in float i_ref_VertexId;\nlayout(location = 3) in float i_ref_InstanceId;\nout vec4 val_Result;\nvoid main()\n{{\n    gl_Position = vec4(i_vertex.xyz * .5, 1.0) + i_vertex_instanced;\n    if ( gl_VertexID == int(i_ref_VertexId + .5) && gl_InstanceID == int(i_ref_InstanceId + .5)) {{\n        val_Result = vec4(0.0, 1.0, float(gl_InstanceID) / 4.0, 1.0);\n    }} else {{\n        val_Result = vec4(1.0, 0.0, 0.0, 1.0);\n    }}\n}}",
            super::GLSL_VER_GL
        )
    }

    fn fsh() -> String {
        format!(
            "{}\nprecision highp float; \nin vec4 val_Result;\nout vec4 outColor;\nvoid main() {{\n  outColor = val_Result;\n}}",
            super::GLSL_VER_GL
        )
    }
}

impl Subcase for BasicVertexIds {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        clear_color_buffer(context)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut coords: Vec<Color> = Vec::new();
        primitive_gen(context, glw::GL_TRIANGLES, 2, 2, &mut coords)?;

        let ref_vertex_id: Vec<f32> = (0..coords.len()).map(|i| i as f32).collect();
        let ref_instance_id: Vec<f32> = (0..4).map(|i| i as f32).collect();

        self.objects.program = create_program(gl, &Self::vsh(), "", &Self::fsh(), true);
        if self.objects.program == 0 {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.objects.program));

        gl!(gl.gen_buffers(1, &mut self.objects.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.objects.vbo));
        let total = color_bytes(coords.len() + INSTANCED_COORDS.len())
            + ((ref_vertex_id.len() + ref_instance_id.len()) * float_size()) as isize;
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, total, std::ptr::null(), glw::GL_STATIC_DRAW));

        let coords_offset = 0usize;
        let coords_instanced_offset = coords_offset + coords.len() * std::mem::size_of::<Color>();
        let ref_vertex_id_offset = coords_instanced_offset + INSTANCED_COORDS.len() * std::mem::size_of::<Color>();
        let ref_instance_id_offset = ref_vertex_id_offset + ref_vertex_id.len() * float_size();

        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            coords_offset as isize,
            color_bytes(coords.len()),
            coords.as_ptr().cast()
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            coords_instanced_offset as isize,
            color_bytes(INSTANCED_COORDS.len()),
            INSTANCED_COORDS.as_ptr().cast()
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            ref_vertex_id_offset as isize,
            (ref_vertex_id.len() * float_size()) as isize,
            ref_vertex_id.as_ptr().cast()
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            ref_instance_id_offset as isize,
            (ref_instance_id.len() * float_size()) as isize,
            ref_instance_id.as_ptr().cast()
        ));

        gl!(gl.gen_vertex_arrays(1, &mut self.objects.vao));
        gl!(gl.bind_vertex_array(self.objects.vao));

        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, 0, offset_pointer(coords_offset)));
        gl!(gl.enable_vertex_attrib_array(0));

        gl!(gl.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, 0, 0, offset_pointer(coords_instanced_offset)));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.vertex_attrib_divisor(1, 1));

        gl!(gl.vertex_attrib_pointer(2, 1, glw::GL_FLOAT, 0, 0, offset_pointer(ref_vertex_id_offset)));
        gl!(gl.enable_vertex_attrib_array(2));

        gl!(gl.vertex_attrib_pointer(3, 1, glw::GL_FLOAT, 0, 0, offset_pointer(ref_instance_id_offset)));
        gl!(gl.enable_vertex_attrib_array(3));
        gl!(gl.vertex_attrib_divisor(3, 1));

        let elements = sequential_elements(coords.len());

        match self.draw_func {
            DrawFunction::DrawArrays => {
                let command = DrawArraysIndirectCommand {
                    count: coords.len() as u32,
                    prim_count: 4,
                    first: 0,
                    reserved_must_be_zero: 0,
                };
                indirect_arrays_once(gl, glw::GL_TRIANGLES, &command);
            }
            DrawFunction::DrawElements => {
                let command = DrawElementsIndirectCommand {
                    count: coords.len() as u32,
                    prim_count: 4,
                    first_index: 0,
                    base_vertex: 0,
                    reserved_must_be_zero: 0,
                };
                indirect_elements_once(gl, glw::GL_TRIANGLES, &command, &mut self.objects.ebo, &elements);
            }
        }

        let (half_w, half_h) = (window_width(context) / 2, window_height(context) / 2);
        let expected: [Color; 4] = [
            [0.0, 1.0, 0.5, 0.0],
            [0.0, 1.0, 0.75, 0.0],
            [0.0, 1.0, 0.25, 0.0],
            [0.0, 1.0, 0.0, 0.0],
        ];
        let mut result = DiResult::new();
        for ((x, y), color) in quadrant_origins(context).into_iter().zip(expected) {
            result.sub_result(compare_region(context, x, y, half_w, half_h, color));
        }
        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        self.objects.cleanup(context.gl());
        Ok(NO_ERROR)
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Variant {
    Simple,
    NoFirst,
    NoBaseVertex,
    BufferOffset,
}

/// `CBufferIndirectDrawArrays{Simple,NoFirst,Offset}` and `CBufferIndirectDrawElements{Simple,NoFirstIndex,NoBasevertex,Offset}`
struct BufferIndirectDraw {
    elements: bool,
    variant: Variant,
    program: GLuint,
    vao: GLuint,
    buffer: GLuint,
    buffer_indirect: GLuint,
    ebo: GLuint,
}

impl BufferIndirectDraw {
    fn new(elements: bool, variant: Variant) -> Self {
        Self {
            elements,
            variant,
            program: 0,
            vao: 0,
            buffer: 0,
            buffer_indirect: 0,
            ebo: 0,
        }
    }
}

impl Subcase for BufferIndirectDraw {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        clear_color_buffer(context)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.program = create_program(gl, &vsh_simple(), "", &fsh_simple(), true);
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
            color_bytes(coords.len()),
            coords.as_ptr().cast(),
            glw::GL_STREAM_DRAW
        ));
        gl!(gl.vertex_attrib_pointer(
            0,
            4,
            glw::GL_FLOAT,
            0,
            std::mem::size_of::<Color>() as i32,
            std::ptr::null()
        ));
        gl!(gl.enable_vertex_attrib_array(0));

        let len = coords.len() as u32;
        let half = len / 2;
        let (count, start, base_vertex) = match self.variant {
            Variant::Simple | Variant::BufferOffset => (len, 0, 0),
            Variant::NoFirst => (half, half, 0),
            Variant::NoBaseVertex => (half, 0, half as i32),
        };
        let elements = sequential_elements(coords.len());

        if self.elements {
            let command = DrawElementsIndirectCommand {
                count,
                prim_count: 1,
                first_index: start,
                base_vertex,
                reserved_must_be_zero: 0,
            };
            let command_size = std::mem::size_of::<DrawElementsIndirectCommand>();

            gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
            gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
            if self.variant == Variant::BufferOffset {
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    (command_size * 3) as isize,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.buffer_sub_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    command_size as isize,
                    command_size as isize,
                    std::ptr::from_ref(&command).cast()
                ));
            } else {
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    command_size as isize,
                    std::ptr::from_ref(&command).cast(),
                    glw::GL_STATIC_DRAW
                ));
            }

            gl!(gl.gen_buffers(1, &mut self.ebo));
            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo));
            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                (elements.len() * std::mem::size_of::<u32>()) as isize,
                elements.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));

            let offset = if self.variant == Variant::BufferOffset {
                command_size
            } else {
                0
            };
            gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, offset_pointer(offset)));
        } else {
            let command = DrawArraysIndirectCommand {
                count,
                prim_count: 1,
                first: start,
                reserved_must_be_zero: 0,
            };
            let command_size = std::mem::size_of::<DrawArraysIndirectCommand>();

            gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
            gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
            if self.variant == Variant::BufferOffset {
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    (command_size * 3) as isize,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.buffer_sub_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    command_size as isize,
                    command_size as isize,
                    std::ptr::from_ref(&command).cast()
                ));
            } else {
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    command_size as isize,
                    std::ptr::from_ref(&command).cast(),
                    glw::GL_STATIC_DRAW
                ));
            }

            let offset = if self.variant == Variant::BufferOffset {
                command_size
            } else {
                0
            };
            gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, offset_pointer(offset)));
        }

        let (w, h) = (window_width(context), window_height(context));
        let mut result = DiResult::new();
        match self.variant {
            Variant::Simple | Variant::BufferOffset => result.sub_result(compare_region(context, 0, 0, w, h, COLOR)),
            Variant::NoFirst | Variant::NoBaseVertex => {
                result.sub_result(compare_region(context, 0, 0, w, h / 2, CLEAR));
                result.sub_result(compare_region(context, 0, (h + 1) / 2, w, h / 2, COLOR));
            }
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
        gl!(gl.delete_buffers(1, &self.buffer_indirect));
        if self.elements {
            gl!(gl.delete_buffers(1, &self.ebo));
        }
        Ok(NO_ERROR)
    }
}

/// `CIndicesDataTypeUnsignedShort` and `CIndicesDataTypeUnsignedByte`
struct IndicesDataType {
    byte: bool,
    program: GLuint,
    vao: GLuint,
    buffer: GLuint,
    ebo: GLuint,
    buffer_indirect: GLuint,
}

impl IndicesDataType {
    fn new(byte: bool) -> Self {
        Self {
            byte,
            program: 0,
            vao: 0,
            buffer: 0,
            ebo: 0,
            buffer_indirect: 0,
        }
    }
}

impl Subcase for IndicesDataType {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        clear_color_buffer(context)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.program = create_program(gl, &vsh_simple(), "", &fsh_simple(), true);
        if self.program == 0 {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        let mut coords: Vec<Color> = Vec::new();
        let draw_size = if self.byte { 2 } else { 8 };
        primitive_gen(context, glw::GL_TRIANGLES, draw_size, draw_size, &mut coords)?;

        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.bind_vertex_array(self.vao));

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            color_bytes(coords.len()),
            coords.as_ptr().cast(),
            glw::GL_STREAM_DRAW
        ));
        gl!(gl.vertex_attrib_pointer(
            0,
            4,
            glw::GL_FLOAT,
            0,
            std::mem::size_of::<Color>() as i32,
            std::ptr::null()
        ));
        gl!(gl.enable_vertex_attrib_array(0));

        let len = coords.len() as i32;
        let indirect_elements = DrawElementsIndirectCommand {
            count: (len / 2) as u32,
            prim_count: 1,
            first_index: (len / 4) as u32,
            base_vertex: -len / 4,
            reserved_must_be_zero: 0,
        };

        let command_size = std::mem::size_of::<DrawElementsIndirectCommand>() as isize;
        gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
        gl!(gl.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            command_size,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            0,
            command_size,
            std::ptr::from_ref(&indirect_elements).cast()
        ));

        gl!(gl.gen_buffers(1, &mut self.ebo));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo));

        let index_type = if self.byte {
            let elements: Vec<u8> = (0..coords.len()).map(|i| i as u8).collect();
            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                elements.len() as isize,
                elements.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            glw::GL_UNSIGNED_BYTE
        } else {
            let elements: Vec<u16> = (0..coords.len()).map(|i| i as u16).collect();
            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                (elements.len() * std::mem::size_of::<u16>()) as isize,
                elements.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            glw::GL_UNSIGNED_SHORT
        };
        gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, index_type, std::ptr::null()));

        let (w, h) = (window_width(context), window_height(context));
        let mut result = DiResult::new();
        result.sub_result(compare_region(context, 0, 0, w, h / 2, COLOR));
        result.sub_result(compare_region(context, 0, (h + 1) / 2, w, h / 2, CLEAR));
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

pub(super) fn add_draw_cases(group: &mut TestCaseGroup) {
    let basic = |name: &str, draw_func: DrawFunction, size: u32, group: &mut TestCaseGroup| {
        add_case(group, name, move || {
            Box::new(BasicVertex::new(draw_func, glw::GL_TRIANGLES, size, size))
        });
    };
    basic("basic-drawArrays-singlePrimitive", DrawFunction::DrawArrays, 1, group);
    basic("basic-drawArrays-manyPrimitives", DrawFunction::DrawArrays, 8, group);
    add_case(group, "basic-drawArrays-instancing", || {
        Box::new(BasicVertexInstancing {
            draw_func: DrawFunction::DrawArrays,
            objects: DrawObjects::default(),
        })
    });
    add_case(group, "basic-drawArrays-xfbPaused", || {
        Box::new(BasicXfbPaused::new(DrawFunction::DrawArrays))
    });
    basic(
        "basic-drawElements-singlePrimitive",
        DrawFunction::DrawElements,
        1,
        group,
    );
    basic(
        "basic-drawElements-manyPrimitives",
        DrawFunction::DrawElements,
        8,
        group,
    );
    add_case(group, "basic-drawElements-instancing", || {
        Box::new(BasicVertexInstancing {
            draw_func: DrawFunction::DrawElements,
            objects: DrawObjects::default(),
        })
    });
    // Upstream registers the arrays flavour here (CVBODrawArraysXFBPaused), not CVBODrawElementsXFBPaused.
    add_case(group, "basic-drawElements-xfbPaused", || {
        Box::new(BasicXfbPaused::new(DrawFunction::DrawArrays))
    });

    add_case(group, "basic-drawArrays-simple", || {
        Box::new(BufferIndirectDraw::new(false, Variant::Simple))
    });
    add_case(group, "basic-drawArrays-noFirst", || {
        Box::new(BufferIndirectDraw::new(false, Variant::NoFirst))
    });
    add_case(group, "basic-drawArrays-bufferOffset", || {
        Box::new(BufferIndirectDraw::new(false, Variant::BufferOffset))
    });
    add_case(group, "basic-drawArrays-vertexIds", || {
        Box::new(BasicVertexIds {
            draw_func: DrawFunction::DrawArrays,
            objects: DrawObjects::default(),
        })
    });
    add_case(group, "basic-drawElements-simple", || {
        Box::new(BufferIndirectDraw::new(true, Variant::Simple))
    });
    add_case(group, "basic-drawElements-noFirstIndex", || {
        Box::new(BufferIndirectDraw::new(true, Variant::NoFirst))
    });
    add_case(group, "basic-drawElements-basevertex", || {
        Box::new(BufferIndirectDraw::new(true, Variant::NoBaseVertex))
    });
    add_case(group, "basic-drawElements-bufferOffset", || {
        Box::new(BufferIndirectDraw::new(true, Variant::BufferOffset))
    });
    add_case(group, "basic-drawElements-vertexIds", || {
        Box::new(BasicVertexIds {
            draw_func: DrawFunction::DrawElements,
            objects: DrawObjects::default(),
        })
    });

    add_case(group, "basic-indicesDataType-unsigned_short", || {
        Box::new(IndicesDataType::new(false))
    });
    add_case(group, "basic-indicesDataType-unsigned_byte", || {
        Box::new(IndicesDataType::new(true))
    });
}

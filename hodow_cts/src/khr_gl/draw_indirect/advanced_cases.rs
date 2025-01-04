// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cDrawIndirectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `CTransformFeedback{Array,Elements}` and `CComputeShader{Array,Elements}` are one struct each, constructed with the draw function.

use std::ffi::CString;

use super::draw_cases::compare_region;
use super::{
    Color, DiResult, DrawArraysIndirectCommand, DrawElementsIndirectCommand, DrawFunction, GLSL_VER_GL,
    GLSL_VER_GL_COMPUTE, add_case, buffers_compare, check_program, create_compute_program, create_program, fsh_simple,
    primitive_gen, read_pixels_float, vsh_simple, window_height, window_width,
};
use crate::glu::{Context, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};

const COLOR: Color = [0.1, 0.2, 0.3, 1.0];
const COLOR_SIZE: usize = std::mem::size_of::<Color>();

/// `CTransformFeedback`
struct TransformFeedback {
    draw_func: DrawFunction,
    program: GLuint,
    vao: GLuint,
    vbo: GLuint,
    ebo: GLuint,
    ubo: GLuint,
    buffer_indirect: GLuint,
}

impl TransformFeedback {
    fn new(draw_func: DrawFunction) -> Self {
        Self {
            draw_func,
            program: 0,
            vao: 0,
            vbo: 0,
            ebo: 0,
            ubo: 0,
            buffer_indirect: 0,
        }
    }

    fn vsh() -> String {
        format!(
            "{GLSL_VER_GL}\nflat out highp uint dataOut;\nin vec4 i_vertex;\nlayout(std140) uniform  BLOCK {{\n uint m[5];\n}} b;\nvoid main() {{\n  dataOut = b.m[min(4, gl_VertexID)];\n    gl_Position = i_vertex;\n}}"
        )
    }
}

impl Subcase for TransformFeedback {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().clear(glw::GL_COLOR_BUFFER_BIT));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut coords: Vec<Color> = Vec::new();
        primitive_gen(context, glw::GL_TRIANGLE_STRIP, 8, 8, &mut coords)?;

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        self.program = create_program(gl, &Self::vsh(), "", &fsh_simple(), false);
        let varying = CString::new("dataOut").expect("no nul byte");
        let varyings = [varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(self.program, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        gl!(gl.gen_buffers(1, &mut self.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (coords.len() * COLOR_SIZE) as isize,
            coords.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.gen_buffers(1, &mut self.ubo));
        gl!(gl.bind_buffer(glw::GL_UNIFORM_BUFFER, self.ubo));
        gl!(gl.buffer_data(
            glw::GL_UNIFORM_BUFFER,
            (4 * 5 * std::mem::size_of::<GLuint>()) as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        let block = CString::new("BLOCK").expect("no nul byte");
        let block_index = gl!(gl.get_uniform_block_index(self.program, block.as_ptr()));
        gl!(gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, block_index, self.ubo));

        let ubo_data: Vec<GLuint> = match self.draw_func {
            DrawFunction::DrawArrays => {
                let mut data = vec![0; 4 * 4];
                data[0] = coords.len() as GLuint; // count
                data[4] = 1; // primcount
                data[8] = 0; // first
                data[12] = 0; // mbz
                data
            }
            DrawFunction::DrawElements => {
                let mut data = vec![0; 4 * 5];
                data[0] = coords.len() as GLuint; // count
                data[4] = 1; // primcount
                data[8] = 0; // firstindex
                data[12] = 0; // basevertex
                data[16] = 0; // mbz
                data
            }
        };
        gl!(gl.buffer_sub_data(
            glw::GL_UNIFORM_BUFFER,
            0,
            (ubo_data.len() * std::mem::size_of::<GLuint>()) as isize,
            ubo_data.as_ptr().cast()
        ));

        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, COLOR_SIZE as i32, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));

        let elements: Vec<GLuint> = (0..coords.len() as GLuint).collect();
        gl!(gl.gen_buffers(1, &mut self.ebo));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo));
        gl!(gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            (elements.len() * std::mem::size_of::<GLuint>()) as isize,
            elements.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.buffer_indirect));
        let zeroes: [GLuint; 5] = [0; 5];
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            std::mem::size_of_val(&zeroes) as isize,
            zeroes.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 5));
        gl!(gl.end_transform_feedback());
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));

        match self.draw_func {
            DrawFunction::DrawArrays => gl!(gl.draw_arrays_indirect(glw::GL_TRIANGLES, std::ptr::null())),
            DrawFunction::DrawElements => {
                gl!(gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_INT, std::ptr::null()))
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
        let gl = context.gl();
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
        if self.ubo != 0 {
            gl!(gl.delete_buffers(1, &self.ubo));
        }
        if self.buffer_indirect != 0 {
            gl!(gl.delete_buffers(1, &self.buffer_indirect));
        }
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        Ok(NO_ERROR)
    }
}

/// `CComputeBase`
struct ComputeBase {
    draw_func: DrawFunction,
    program: GLuint,
    program_compute: GLuint,
    vao: GLuint,
    ebo: GLuint,
    buffer_coords: GLuint,
    buffer_colors: GLuint,
    buffer_indirect: GLuint,
}

impl ComputeBase {
    fn new(draw_func: DrawFunction) -> Self {
        Self {
            draw_func,
            program: 0,
            program_compute: 0,
            vao: 0,
            ebo: 0,
            buffer_coords: 0,
            buffer_colors: 0,
            buffer_indirect: 0,
        }
    }

    fn vsh() -> String {
        format!(
            "{GLSL_VER_GL}\nin vec4 in_coords;\nin vec4 in_colors;\nout vec4 colors;\nvoid main() {{\n  colors = in_colors;\n  gl_Position = in_coords;\n#if defined(GL_ES)\n  gl_PointSize = 1.0;\n#endif\n}}"
        )
    }

    fn fsh() -> String {
        format!(
            "{GLSL_VER_GL}\nprecision highp float;\nin vec4 colors;\nout vec4 outColor;\nvoid main() {{\n  outColor = colors;\n}}"
        )
    }

    fn csh() -> String {
        format!(
            "{GLSL_VER_GL_COMPUTE}\nprecision highp int;                                           \nprecision highp float;                                         \n                                                               \nlayout(local_size_x = 1) in;                                   \nlayout(std430, binding = 0) buffer Vertices {{                  \n    vec4 vertices[];                                           \n}};                                                             \nlayout(std430, binding = 1) buffer Colors {{                    \n    vec4 colors[];                                             \n}};                                                             \nlayout(std430, binding = 2) buffer Indirect {{                  \n    uint indirect[4];                                          \n}};                                                             \n                                                               \nuniform uint height;                                           \nuniform uint width;                                            \n                                                               \nvoid main() {{                                                  \n    uint w = gl_GlobalInvocationID.x;                          \n    uint h = gl_GlobalInvocationID.y;                          \n    float stepX = 2.0 / float(width);                          \n    float stepY = 2.0 / float(height);                         \n    float offsetX = -1.0 + stepX * float(w) + stepX / 2.0;     \n    float offsetY = -1.0 + stepY * float(h) + stepY / 2.0;     \n    uint arrayOffset = h * width + w;                          \n    vertices[ arrayOffset ] = vec4(offsetX, offsetY, 0.0, 1.0);\n    vec4 color = vec4(0.0, 0.0, 0.0, 1.0);                     \n    if(w > (width / 2u - 1u)) {{                                \n        color = color + vec4(0.5, 0.0, 0.0, 0.0);              \n    }}                                                          \n    if(h > (height / 2u - 1u)) {{                               \n        color = color + vec4(0.0, 0.5, 0.0, 0.0);              \n    }}                                                          \n    colors[ arrayOffset ] = color;                             \n    if(w == 0u && h == 0u) {{                                   \n        indirect[0] = width * height;                          \n        indirect[1] =  1u;                                     \n    }}                                                          \n}}                                                              "
        )
    }
}

impl Subcase for ComputeBase {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().clear(glw::GL_COLOR_BUFFER_BIT));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (mut width, mut height) = (0, 0);
        gl!(gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 0, &mut width));
        gl!(gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 1, &mut height));
        width = width.min(window_width(context));
        height = height.min(window_height(context));

        gl!(gl.viewport(0, 0, width, height));

        let count = (width * height) as usize;
        self.program = create_program(gl, &Self::vsh(), "", &Self::fsh(), false);
        let in_coords = CString::new("in_coords").expect("no nul byte");
        let in_colors = CString::new("in_colors").expect("no nul byte");
        gl!(gl.bind_attrib_location(self.program, 0, in_coords.as_ptr()));
        gl!(gl.bind_attrib_location(self.program, 1, in_colors.as_ptr()));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.bind_vertex_array(self.vao));

        gl!(gl.gen_buffers(1, &mut self.buffer_coords));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer_coords));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (count * COLOR_SIZE) as isize,
            std::ptr::null(),
            glw::GL_STREAM_DRAW
        ));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, COLOR_SIZE as i32, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));

        gl!(gl.gen_buffers(1, &mut self.buffer_colors));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer_colors));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (count * COLOR_SIZE) as isize,
            std::ptr::null(),
            glw::GL_STREAM_DRAW
        ));
        gl!(gl.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, 0, COLOR_SIZE as i32, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(1));

        let indirect_elements = DrawElementsIndirectCommand::default();
        let indirect_arrays = DrawArraysIndirectCommand::default();
        let elements: Vec<GLuint> = (0..count as GLuint).collect();

        gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));

        match self.draw_func {
            DrawFunction::DrawArrays => {
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    std::mem::size_of::<DrawArraysIndirectCommand>() as isize,
                    std::ptr::from_ref(&indirect_arrays).cast(),
                    glw::GL_STATIC_DRAW
                ));
            }
            DrawFunction::DrawElements => {
                gl!(gl.gen_buffers(1, &mut self.ebo));
                gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo));
                gl!(gl.buffer_data(
                    glw::GL_ELEMENT_ARRAY_BUFFER,
                    (elements.len() * std::mem::size_of::<GLuint>()) as isize,
                    elements.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                ));
                gl!(gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    std::mem::size_of::<DrawElementsIndirectCommand>() as isize,
                    std::ptr::from_ref(&indirect_elements).cast(),
                    glw::GL_STATIC_DRAW
                ));
            }
        }

        self.program_compute = create_compute_program(gl, &Self::csh(), false);
        gl!(gl.link_program(self.program_compute));
        if !check_program(gl, self.program_compute) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program_compute));
        let width_name = CString::new("width").expect("no nul byte");
        let height_name = CString::new("height").expect("no nul byte");
        gl!(gl.uniform_1ui(
            gl.get_uniform_location(self.program_compute, width_name.as_ptr()),
            width as GLuint
        ));
        gl!(gl.uniform_1ui(
            gl.get_uniform_location(self.program_compute, height_name.as_ptr()),
            height as GLuint
        ));

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer_coords));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.buffer_colors));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 2, self.buffer_indirect));

        gl!(gl.dispatch_compute(width as GLuint, height as GLuint, 1));
        gl!(gl.memory_barrier(glw::GL_COMMAND_BARRIER_BIT | glw::GL_SHADER_STORAGE_BARRIER_BIT));

        gl!(gl.use_program(self.program));

        match self.draw_func {
            DrawFunction::DrawArrays => gl!(gl.draw_arrays_indirect(glw::GL_POINTS, std::ptr::null())),
            DrawFunction::DrawElements => {
                gl!(gl.draw_elements_indirect(glw::GL_POINTS, glw::GL_UNSIGNED_INT, std::ptr::null()))
            }
        }

        let regions: [((i32, i32), Color, &str); 4] = [
            ((0, 0), [0.0, 0.0, 0.0, 1.0], "Region 0 verification failed"),
            (
                ((width + 1) / 2, 0),
                [0.5, 0.0, 0.0, 1.0],
                "Region 1 verification failed",
            ),
            (
                (0, (height + 1) / 2),
                [0.0, 0.5, 0.0, 1.0],
                "Region 2 verification failed",
            ),
            (
                ((width + 1) / 2, (height + 1) / 2),
                [0.5, 0.5, 0.0, 1.0],
                "Region 3 verification failed",
            ),
        ];
        let mut result = DiResult::new();
        for ((x, y), color, message) in regions {
            let code = compare_region(context, x, y, width / 2, height / 2, color);
            if code != NO_ERROR {
                log::info!("{message}");
            }
            result.sub_result(code);
        }
        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable_vertex_attrib_array(1));
        gl!(gl.disable_vertex_attrib_array(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_program(self.program_compute));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        if self.ebo != 0 {
            gl!(gl.delete_buffers(1, &self.ebo));
        }
        gl!(gl.delete_buffers(1, &self.buffer_coords));
        gl!(gl.delete_buffers(1, &self.buffer_colors));
        gl!(gl.delete_buffers(1, &self.buffer_indirect));
        gl!(gl.viewport(0, 0, window_width(context), window_height(context)));
        Ok(NO_ERROR)
    }
}

const PRIMITIVE_RESTART_INDEX: u32 = 3432432;

/// `CPrimitiveRestartElements::TriangleStipGen`
fn triangle_strip_gen(
    coords: &mut Vec<Color>,
    width_start: f32,
    width_end: f32,
    height_start: f32,
    height_end: f32,
    prim_num: u32,
) {
    let width_step = (width_end - width_start) / prim_num as f32;
    let height_step = (height_end - height_start) / prim_num as f32;
    for i in 0..prim_num {
        let height_offset = height_start + height_step * i as f32;
        for j in 0..prim_num {
            let width_offset = width_start + width_step * j as f32;
            coords.push([width_offset, height_offset, 0.0, 1.0]);
            coords.push([width_offset, height_offset + height_step, 0.0, 1.0]);
            coords.push([width_offset + width_step, height_offset, 0.0, 1.0]);
            coords.push([width_offset + width_step, height_offset + height_step, 0.0, 1.0]);
        }
    }
}

/// `CPrimitiveRestartElements`
#[derive(Default)]
struct PrimitiveRestartElements {
    program: GLuint,
    vao: GLuint,
    buffer: GLuint,
    ebo: GLuint,
    buffer_indirect: GLuint,
}

impl Subcase for PrimitiveRestartElements {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().clear(glw::GL_COLOR_BUFFER_BIT));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.program = create_program(gl, &vsh_simple(), "", &fsh_simple(), true);
        if self.program == 0 {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        let mut coords1: Vec<Color> = Vec::new();
        triangle_strip_gen(&mut coords1, -1.0, 1.0, -1.0, -0.5, 2);
        let mut coords2: Vec<Color> = Vec::new();
        triangle_strip_gen(&mut coords2, -1.0, 1.0, 0.5, 1.0, 4);

        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.bind_vertex_array(self.vao));

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            ((coords1.len() + coords2.len()) * COLOR_SIZE) as isize,
            std::ptr::null(),
            glw::GL_STREAM_DRAW
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            0,
            (coords1.len() * COLOR_SIZE) as isize,
            coords1.as_ptr().cast()
        ));
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            (coords1.len() * COLOR_SIZE) as isize,
            (coords2.len() * COLOR_SIZE) as isize,
            coords2.as_ptr().cast()
        ));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, COLOR_SIZE as i32, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));

        let indirect_elements = DrawElementsIndirectCommand {
            count: (coords1.len() + coords2.len() + 1) as GLuint,
            prim_count: ((coords1.len() + coords2.len()) / 2) as GLuint,
            ..DrawElementsIndirectCommand::default()
        };

        let mut elements: Vec<GLuint> = (0..coords1.len() as GLuint).collect();
        elements.push(PRIMITIVE_RESTART_INDEX);
        elements.extend((0..coords2.len()).map(|i| (coords1.len() + i) as GLuint));

        gl!(gl.gen_buffers(1, &mut self.buffer_indirect));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer_indirect));
        gl!(gl.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            std::mem::size_of::<DrawElementsIndirectCommand>() as isize,
            std::ptr::from_ref(&indirect_elements).cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.gen_buffers(1, &mut self.ebo));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo));
        gl!(gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            (elements.len() * std::mem::size_of::<GLuint>()) as isize,
            elements.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.primitive_restart_index(PRIMITIVE_RESTART_INDEX));
        gl!(gl.enable(glw::GL_PRIMITIVE_RESTART));

        gl!(gl.draw_elements_indirect(glw::GL_TRIANGLE_STRIP, glw::GL_UNSIGNED_INT, std::ptr::null()));

        let (w, h) = (window_width(context), window_height(context));
        let mut result = DiResult::new();

        result.sub_result(compare_region(context, 0, 0, w, h / 4, COLOR));

        // height = 2 * (getWindowHeight() / 4) to avoid border pixels in case the height is not a multiple of 4.
        let mut buffer_test2: Vec<Color> = vec![[0.0; 4]; (w * (h / 2)) as usize];
        read_pixels_float(gl, 0, (h + 3) / 4, w, 2 * (h / 4), &mut buffer_test2);
        let buffer_ref2: Vec<Color> = vec![[0.0; 4]; (w * 2 * (h / 4)) as usize];
        result.sub_result(buffers_compare(
            context,
            &buffer_test2,
            w as u32,
            (h / 2) as u32,
            &buffer_ref2,
            w as u32,
            (2 * (h / 4)) as u32,
        ));

        result.sub_result(compare_region(context, 0, (h * 3 + 3) / 4, w, h / 4, COLOR));

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_PRIMITIVE_RESTART));
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

pub(super) fn add_advanced_cases(group: &mut TestCaseGroup) {
    add_case(group, "advanced-twoPass-transformFeedback-arrays", || {
        Box::new(TransformFeedback::new(DrawFunction::DrawArrays))
    });
    add_case(group, "advanced-twoPass-transformFeedback-elements", || {
        Box::new(TransformFeedback::new(DrawFunction::DrawElements))
    });

    add_case(group, "advanced-primitiveRestart-elements", || {
        Box::<PrimitiveRestartElements>::default()
    });
}

pub(super) fn add_compute_cases(group: &mut TestCaseGroup) {
    add_case(group, "advanced-twoPass-Compute-arrays", || {
        Box::new(ComputeBase::new(DrawFunction::DrawArrays))
    });
    add_case(group, "advanced-twoPass-Compute-elements", || {
        Box::new(ComputeBase::new(DrawFunction::DrawElements))
    });
}

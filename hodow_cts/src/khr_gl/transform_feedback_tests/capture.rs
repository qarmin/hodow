// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedbackTests.cpp  (CaptureVertexInterleaved, CaptureGeometryInterleaved, CaptureVertexSeparate, CaptureGeometrySeparate, QueryVertexInterleaved, QueryGeometryInterleaved, QueryVertexSeparate, QueryGeometrySeparate, DiscardVertex, DiscardGeometry)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The ten classes are one engine configured by the three things their overrides differ in: `geometry` (CaptureGeometry*: a geometry shader emits the primitives, `iterate` loops over three primitive types and builds a program per type), `separate` (*Separate: one buffer per attribute and the SEPARATE_ATTRIBS limits) and the `Variant` (Query*: the draw is wrapped in a GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN query that replaces the buffer check; Discard*: the draw runs with GL_RASTERIZER_DISCARD and the framebuffer must stay clear). `glBindBufferOffsetEXT` cannot be looked up through glw, so the BIND_BUFFER_OFFSET_CASE is always skipped, as upstream does when the entry point is missing. `clean` is the `Drop`.

use super::{Sources, build_program, ftoa, internal_error, itoa, preprocess_code, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizei, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

const VERTEX_SHADER_TEMPLATE: &str = "#version 130\n\nTEMPLATE_INPUT_OUTPUT_DECLARATIONS\nvoid main()\n{\nTEMPLATE_OUTPUT_SETTERS\n    vec4 position = vec4(0.0);\n\n    /* Note: The points are moved 0.0625 from the borders to\n             reduce non-XFB related rasterization problems. */\n    switch(gl_VertexID)\n    {\n        case 0:\n            position = vec4(-1.0 + TEMPLATE_RASTERIZATION_EPSILON,  1.0 - TEMPLATE_RASTERIZATION_EPSILON,  0.0,  1.0);\n            break;\n        case 1:\n            position = vec4( 1.0 - TEMPLATE_RASTERIZATION_EPSILON,  1.0 - TEMPLATE_RASTERIZATION_EPSILON,  0.0,  1.0);\n            break;\n        case 2:\n            position = vec4(-1.0 + TEMPLATE_RASTERIZATION_EPSILON, -1.0 + TEMPLATE_RASTERIZATION_EPSILON,  0.0,  1.0);\n            break;\n        case 3:\n            position = vec4( 1.0 - TEMPLATE_RASTERIZATION_EPSILON, -1.0 + TEMPLATE_RASTERIZATION_EPSILON,  0.0,  1.0);\n            break;\n    }\n\n    gl_Position = position;\n}\n";

const FRAGMENT_SHADER: &str = "#version 130\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(0.5);\n}\n";

const GEOMETRY_SHADER_TEMPLATE: &str = "#version 150\n\nlayout(points) in;\nlayout(TEMPLATE_PRIMITIVE_TYPE, max_vertices = 4) out;\n\nTEMPLATE_INPUT_OUTPUT_DECLARATIONS\nvoid main()\n{\n    /* Note: The points are moved 0.0625 from the borders to\n             reduce non-XFB related rasterization problems. */\n\n    gl_Position = vec4(-1.0 + TEMPLATE_RASTERIZATION_EPSILON,  1.0 - TEMPLATE_RASTERIZATION_EPSILON,  0.0,  1.0);\nTEMPLATE_OUTPUT_SETTERS    EmitVertex();\n\n    gl_Position = vec4( 1.0 - TEMPLATE_RASTERIZATION_EPSILON,  1.0 - TEMPLATE_RASTERIZATION_EPSILON,  0.0,  1.0);\nTEMPLATE_OUTPUT_SETTERS    EmitVertex();\n\n    gl_Position = vec4(-1.0 + TEMPLATE_RASTERIZATION_EPSILON, -1.0 + TEMPLATE_RASTERIZATION_EPSILON,  0.0,  1.0);\nTEMPLATE_OUTPUT_SETTERS    EmitVertex();\n\n    gl_Position = vec4( 1.0 - TEMPLATE_RASTERIZATION_EPSILON, -1.0 + TEMPLATE_RASTERIZATION_EPSILON,  0.0,  1.0);\nTEMPLATE_OUTPUT_SETTERS    EmitVertex();\n}\n";

const BLANK_VERTEX_SHADER: &str = "#version 130\n\nvoid main()\n{\n}\n";

const GEOMETRY_PRIMITIVE_CASES: [&str; 3] = ["points", "line_strip", "triangle_strip"];
const GEOMETRY_PRIMITIVE_CASES_XFB: [GLenum; 3] = [glw::GL_POINTS, glw::GL_LINES, glw::GL_TRIANGLES];

const ELEMENT_INDICES: [[GLuint; 6]; 7] = [
    [0, 1, 2, 3, 0, 0],
    [0, 1, 2, 3, 0, 0],
    [0, 1, 3, 2, 0, 0],
    [0, 1, 3, 2, 0, 0],
    [2, 0, 1, 2, 1, 3],
    [0, 1, 2, 3, 0, 0],
    [2, 0, 1, 3, 0, 0],
];
const PRIMITIVE_CASES: [GLenum; 7] = [
    glw::GL_POINTS,
    glw::GL_LINES,
    glw::GL_LINE_LOOP,
    glw::GL_LINE_STRIP,
    glw::GL_TRIANGLES,
    glw::GL_TRIANGLE_STRIP,
    glw::GL_TRIANGLE_FAN,
];
const PRIMITIVE_CASES_XFB: [GLenum; 7] = [
    glw::GL_POINTS,
    glw::GL_LINES,
    glw::GL_LINES,
    glw::GL_LINES,
    glw::GL_TRIANGLES,
    glw::GL_TRIANGLES,
    glw::GL_TRIANGLES,
];
const ELEMENT_INDICES_COUNTS: [GLsizei; 7] = [4, 4, 4, 4, 6, 4, 4];
const FRAMEBUFFER_SIZE: GLsizei = 2;
const RASTERIZATION_EPSILON: f32 = 0.0625;

/// The BIND_BUFFER_BASE_CASE and BIND_BUFFER_RANGE_CASE of upstream's `BindBufferCase` (the offset case needs `glBindBufferOffsetEXT`).
#[derive(Clone, Copy, PartialEq, Eq)]
enum BindBufferCase {
    Base,
    Range,
}

/// What `Query*` and `Discard*` add to the plain capture cases.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Variant {
    Capture,
    Query,
    Discard,
}

/// One of the ten classes.
pub(super) struct CaptureCase {
    pub(super) name: &'static str,
    pub(super) geometry: bool,
    pub(super) separate: bool,
    pub(super) variant: Variant,
}

/// The objects of one run; `clean` is the `Drop`.
struct Capture<'a> {
    context: &'a Context,
    geometry: bool,
    separate: bool,
    variant: Variant,
    program: GLuint,
    framebuffer: GLuint,
    renderbuffer: GLuint,
    buffer: GLuint,
    buffer_size: GLuint,
    vertex_array_object: GLuint,
    max_transform_feedback_components: GLint,
    attrib_type: GLenum,
    max_vertices_drawn: GLuint,
    buffers: Vec<GLuint>,
    max_transform_feedback_separate_attribs: GLint,
    query_object: GLuint,
}

impl Drop for Capture<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            if self.query_object != 0 {
                gl.delete_queries(1, &self.query_object);
            }
            if self.program != 0 {
                gl.delete_program(self.program);
            }
            if self.framebuffer != 0 {
                gl.delete_framebuffers(1, &self.framebuffer);
            }
            if self.renderbuffer != 0 {
                gl.delete_renderbuffers(1, &self.renderbuffer);
            }
            if self.buffer != 0 {
                gl.delete_buffers(1, &self.buffer);
            }
            if !self.buffers.is_empty() {
                gl.delete_buffers(self.buffers.len() as GLsizei, self.buffers.as_ptr());
            }
            if self.vertex_array_object != 0 {
                gl.delete_vertex_arrays(1, &self.vertex_array_object);
            }
        }
    }
}

/// `checkTransformFeedbackBuffer`'s vertex counts per primitive type.
fn number_of_vertices(primitive_type: GLenum) -> Result<usize, TestError> {
    match primitive_type {
        glw::GL_POINTS | glw::GL_LINES => Ok(4),
        glw::GL_LINE_LOOP => Ok(8),
        glw::GL_LINE_STRIP | glw::GL_TRIANGLES | glw::GL_TRIANGLE_STRIP | glw::GL_TRIANGLE_FAN => Ok(6),
        _ => internal_error(),
    }
}

/// The declarations, setters and varying names of the user-defined `result_N` varyings and `gl_Position`.
fn varying_templates(max_transform_feedback_components: GLint) -> (String, String, Vec<String>) {
    let user_defined_count = max_transform_feedback_components / 4 - 1;
    let mut declarations = String::new();
    let mut setters = String::new();
    let mut varyings = Vec::new();

    for i in 0..user_defined_count {
        let varying = format!("result_{}", itoa(i));

        declarations.push_str(&format!("out vec4 {varying};\n"));
        setters.push_str(&format!(
            "    {varying} = vec4({}.0, {}.0, {}.0, {}.0);\n",
            itoa(i * 4),
            itoa(i * 4 + 1),
            itoa(i * 4 + 2),
            itoa(i * 4 + 3)
        ));
        varyings.push(varying);
    }

    varyings.push("gl_Position".to_string());

    (declarations, setters, varyings)
}

impl<'a> Capture<'a> {
    fn new(context: &'a Context, case: &CaptureCase) -> Self {
        Self {
            context,
            geometry: case.geometry,
            separate: case.separate,
            variant: case.variant,
            program: 0,
            framebuffer: 0,
            renderbuffer: 0,
            buffer: 0,
            buffer_size: 0,
            vertex_array_object: 0,
            max_transform_feedback_components: 0,
            attrib_type: if case.separate {
                glw::GL_SEPARATE_ATTRIBS
            } else {
                glw::GL_INTERLEAVED_ATTRIBS
            },
            max_vertices_drawn: if case.variant == Variant::Query { 3 } else { 8 },
            buffers: Vec::new(),
            max_transform_feedback_separate_attribs: 0,
            query_object: 0,
        }
    }

    /// The three `fetchLimits` overrides.
    fn fetch_limits(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        if self.separate {
            let mut max_transform_feedback_separate_components: GLint = 0;
            gl_call!(
                gl,
                "glGetIntegerv call failed.",
                gl.get_integerv(
                    glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
                    &mut max_transform_feedback_separate_components
                )
            );
            if max_transform_feedback_separate_components < 4 {
                return internal_error();
            }

            gl_call!(
                gl,
                "glGetIntegerv call failed.",
                gl.get_integerv(
                    glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
                    &mut self.max_transform_feedback_separate_attribs
                )
            );
            if self.max_transform_feedback_separate_attribs == 0 {
                return internal_error();
            }

            self.max_transform_feedback_components = self.max_transform_feedback_separate_attribs * 4;

            let mut max_varyings_components: GLint = 0;
            gl_call!(
                gl,
                "glGetIntegerv call failed.",
                gl.get_integerv(glw::GL_MAX_VARYING_COMPONENTS, &mut max_varyings_components)
            );
            if max_varyings_components == 0 {
                return internal_error();
            }

            self.max_transform_feedback_components =
                self.max_transform_feedback_components.min(max_varyings_components);
        } else if self.geometry {
            gl_call!(
                gl,
                "glGetIntegerv call failed.",
                gl.get_integerv(
                    glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
                    &mut self.max_transform_feedback_components
                )
            );
            if self.max_transform_feedback_components == 0 {
                return internal_error();
            }

            let mut max_geometry_total_components: GLint = 0;
            gl_call!(
                gl,
                "glGetIntegerv call failed.",
                gl.get_integerv(
                    glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS,
                    &mut max_geometry_total_components
                )
            );
            if max_geometry_total_components == 0 {
                return internal_error();
            }

            if self.max_transform_feedback_components * 4 > max_geometry_total_components {
                self.max_transform_feedback_components = max_geometry_total_components / 4;
            }
        } else {
            gl_call!(
                gl,
                "glGetIntegerv call failed.",
                gl.get_integerv(
                    glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
                    &mut self.max_transform_feedback_components
                )
            );
            if self.max_transform_feedback_components == 0 {
                return internal_error();
            }

            let mut max_varyings_components: GLint = 0;
            gl_call!(
                gl,
                "glGetIntegerv call failed.",
                gl.get_integerv(glw::GL_MAX_VARYING_COMPONENTS, &mut max_varyings_components)
            );
            if max_varyings_components == 0 {
                return internal_error();
            }

            if self.max_transform_feedback_components > max_varyings_components {
                self.max_transform_feedback_components = max_varyings_components;
            }
        }

        Ok(())
    }

    /// `CaptureVertexInterleaved::buildProgram` (the program is built once) and `CaptureGeometryInterleaved::buildProgram` (one per primitive case).
    fn build_program(&mut self, primitive_case: usize) -> Result<(), TestError> {
        let gl = self.context.gl();
        let (declarations, setters, varyings) = varying_templates(self.max_transform_feedback_components);
        let varying_refs: Vec<&str> = varyings.iter().map(String::as_str).collect();
        let epsilon = ftoa(RASTERIZATION_EPSILON);

        if self.geometry {
            let shader = preprocess_code(
                GEOMETRY_SHADER_TEMPLATE,
                "TEMPLATE_PRIMITIVE_TYPE",
                GEOMETRY_PRIMITIVE_CASES[primitive_case],
            );
            let shader = preprocess_code(&shader, "TEMPLATE_INPUT_OUTPUT_DECLARATIONS", &declarations);
            let shader = preprocess_code(&shader, "TEMPLATE_OUTPUT_SETTERS", &setters);
            let shader = preprocess_code(&shader, "TEMPLATE_RASTERIZATION_EPSILON", &epsilon);

            let sources = Sources {
                geometry: Some(&shader),
                vertex: Some(BLANK_VERTEX_SHADER),
                fragment: Some(FRAGMENT_SHADER),
                ..Sources::default()
            };
            self.program = build_program(gl, &sources, &varying_refs, self.attrib_type);
        } else {
            let shader = preprocess_code(
                VERTEX_SHADER_TEMPLATE,
                "TEMPLATE_INPUT_OUTPUT_DECLARATIONS",
                &declarations,
            );
            let shader = preprocess_code(&shader, "TEMPLATE_OUTPUT_SETTERS", &setters);
            let shader = preprocess_code(&shader, "TEMPLATE_RASTERIZATION_EPSILON", &epsilon);

            let sources = Sources {
                vertex: Some(&shader),
                fragment: Some(FRAGMENT_SHADER),
                ..Sources::default()
            };
            self.program = build_program(gl, &sources, &varying_refs, self.attrib_type);
        }

        if self.program == 0 {
            return internal_error();
        }

        Ok(())
    }

    /// `createFramebuffer`
    fn create_framebuffer(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(gl, "glClearColor call failed.", gl.clear_color(0.0, 0.0, 0.0, 1.0));
        gl_call!(
            gl,
            "glGenFramebuffers call failed.",
            gl.gen_framebuffers(1, &mut self.framebuffer)
        );
        gl_call!(
            gl,
            "glGenRenderbuffers call failed.",
            gl.gen_renderbuffers(1, &mut self.renderbuffer)
        );
        gl_call!(
            gl,
            "glBindFramebuffer call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer)
        );
        gl_call!(
            gl,
            "glBindRenderbuffer call failed.",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, self.renderbuffer)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage call failed.",
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R32F, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE)
        );
        gl_call!(
            gl,
            "glFramebufferRenderbuffer call failed.",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                self.renderbuffer
            )
        );

        // SAFETY: plain state query.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return internal_error();
        }

        gl_call!(
            gl,
            "glViewport call failed.",
            gl.viewport(0, 0, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE)
        );
        Ok(())
    }

    /// The `createTransformFeedbackBuffer` overrides, `Query*` adding a query object.
    fn create_transform_feedback_buffer(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        if self.separate {
            self.buffers = vec![0; self.max_transform_feedback_separate_attribs as usize];
            gl_call!(
                gl,
                "glGenBuffers call failed.",
                gl.gen_buffers(self.max_transform_feedback_separate_attribs, self.buffers.as_mut_ptr())
            );
            self.buffer_size = (self.max_vertices_drawn as usize * 4 * std::mem::size_of::<f32>()) as GLuint;

            for i in 0..self.max_transform_feedback_separate_attribs as usize {
                gl_call!(
                    gl,
                    "glBindBuffer call failed.",
                    gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.buffers[i])
                );
                gl_call!(
                    gl,
                    "glBufferData call failed.",
                    gl.buffer_data(
                        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                        self.buffer_size as GLsizeiptr,
                        std::ptr::null(),
                        glw::GL_DYNAMIC_READ
                    )
                );
            }
        } else {
            gl_call!(gl, "glGenBuffers call failed.", gl.gen_buffers(1, &mut self.buffer));
            gl_call!(
                gl,
                "glBindBuffer call failed.",
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.buffer)
            );
            self.buffer_size = (self.max_transform_feedback_components as usize
                * self.max_vertices_drawn as usize
                * std::mem::size_of::<f32>()) as GLuint;
            gl_call!(
                gl,
                "glBufferData call failed.",
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    self.buffer_size as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_READ
                )
            );
        }

        if self.variant == Variant::Query {
            gl_call!(
                gl,
                "glGenQueries call failed.",
                gl.gen_queries(1, &mut self.query_object)
            );
        }

        Ok(())
    }

    /// `createVertexArrayObject`
    fn create_vertex_array_object(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glGenVertexArrays call failed.",
            gl.gen_vertex_arrays(1, &mut self.vertex_array_object)
        );
        gl_call!(
            gl,
            "glBindVertexArray call failed.",
            gl.bind_vertex_array(self.vertex_array_object)
        );
        Ok(())
    }

    /// The `bindBuffer` overrides.
    fn bind_buffer(&self, bind_case: BindBufferCase) {
        let gl = self.context.gl();

        // SAFETY: plain state calls on buffers created by `create_transform_feedback_buffer`.
        unsafe {
            if self.separate {
                for i in 0..self.max_transform_feedback_separate_attribs as usize {
                    match bind_case {
                        BindBufferCase::Base => {
                            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, i as GLuint, self.buffers[i])
                        }
                        BindBufferCase::Range => gl.bind_buffer_range(
                            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                            i as GLuint,
                            self.buffers[i],
                            0,
                            self.buffer_size as GLsizeiptr,
                        ),
                    }
                }
            } else {
                match bind_case {
                    BindBufferCase::Base => gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer),
                    BindBufferCase::Range => gl.bind_buffer_range(
                        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                        0,
                        self.buffer,
                        0,
                        self.buffer_size as GLsizeiptr,
                    ),
                }
            }
        }
    }

    /// `CaptureVertexInterleaved::draw` and `CaptureGeometryInterleaved::draw`.
    fn draw_primitives(&self, primitive_case: usize) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(gl, "glClear call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));

        if self.geometry {
            gl_call!(
                gl,
                "glBeginTransformFeedback call failed.",
                gl.begin_transform_feedback(GEOMETRY_PRIMITIVE_CASES_XFB[primitive_case])
            );
            gl_call!(gl, "glDrawArrays call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
        } else {
            gl_call!(
                gl,
                "glBeginTransformFeedbac call failed.",
                gl.begin_transform_feedback(PRIMITIVE_CASES_XFB[primitive_case])
            );
            gl_call!(
                gl,
                "glDrawElements call failed.",
                gl.draw_elements(
                    PRIMITIVE_CASES[primitive_case],
                    ELEMENT_INDICES_COUNTS[primitive_case],
                    glw::GL_UNSIGNED_INT,
                    ELEMENT_INDICES[primitive_case].as_ptr().cast()
                )
            );
        }

        gl_call!(gl, "glEndTransformFeedbac call failed.", gl.end_transform_feedback());
        Ok(())
    }

    /// The `draw` overrides: the plain draw, wrapped by the query (`Query*`) or the rasterizer discard (`Discard*`).
    fn draw(&self, primitive_case: usize) -> Result<(), TestError> {
        let gl = self.context.gl();

        match self.variant {
            Variant::Capture => self.draw_primitives(primitive_case),
            Variant::Query => {
                gl_call!(
                    gl,
                    "glBeginQuery call failed.",
                    gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, self.query_object)
                );
                self.draw_primitives(primitive_case)?;
                gl_call!(
                    gl,
                    "glEndQuery call failed.",
                    gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN)
                );
                Ok(())
            }
            Variant::Discard => {
                gl_call!(gl, "glClear call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));
                gl_call!(gl, "glEnable call failed.", gl.enable(glw::GL_RASTERIZER_DISCARD));
                self.draw_primitives(primitive_case)?;
                gl_call!(gl, "glDisable call failed.", gl.disable(glw::GL_RASTERIZER_DISCARD));
                Ok(())
            }
        }
    }

    /// `checkFramebuffer`: every pixel is the fragment colour, or still clear for `Discard*`.
    fn check_framebuffer(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut pixels = vec![0.0f32; (FRAMEBUFFER_SIZE * FRAMEBUFFER_SIZE) as usize];

        gl_call!(
            gl,
            "glReadPixels call failed.",
            gl.read_pixels(
                0,
                0,
                FRAMEBUFFER_SIZE,
                FRAMEBUFFER_SIZE,
                glw::GL_RED,
                glw::GL_FLOAT,
                pixels.as_mut_ptr().cast()
            )
        );

        let expected = if self.variant == Variant::Discard { 0.0 } else { 0.5 };
        Ok(pixels.iter().all(|pixel| (pixel - expected).abs() <= 0.0625))
    }

    /// `CaptureVertexInterleaved::checkTransformFeedbackBuffer`
    fn check_interleaved(&self, primitive_type: GLenum) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let number_of_vertices = number_of_vertices(primitive_type)?;
        let components = self.max_transform_feedback_components as usize;

        // SAFETY: the buffer holds `components * max_vertices_drawn` floats.
        let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
        crate::glu::expect_no_error(gl, "glMapBuffer call failed.")?;

        if mapped.is_null() {
            return internal_error();
        }

        // SAFETY: the mapping is `components * max_vertices_drawn` floats long and stays valid until the unmap below.
        let results =
            unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), components * self.max_vertices_drawn as usize) };
        let mut is_ok = true;

        for j in 0..number_of_vertices {
            if !is_ok {
                break;
            }

            for i in 0..components - 4 {
                let result = results[i + j * components];
                let reference = i as f32;

                if (result - reference).abs() > 0.125 {
                    is_ok = false;
                    break;
                }
            }

            let result = [
                results[(j + 1) * components - 4],
                results[(j + 1) * components - 3],
                results[(j + 1) * components - 2],
                results[(j + 1) * components - 1],
            ];

            if position_is_wrong(&result) {
                is_ok = false;
                break;
            }
        }

        gl_call!(
            gl,
            "glUnmapBuffer call failed.",
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
        );
        Ok(is_ok)
    }

    /// `CaptureVertexSeparate::checkTransformFeedbackBuffer`
    fn check_separate(&self, primitive_type: GLenum) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let number_of_vertices = number_of_vertices(primitive_type)?;
        let words = self.max_vertices_drawn as usize * 4;
        let mut is_ok = true;

        for i in 0..self.max_transform_feedback_separate_attribs as usize - 1 {
            gl_call!(
                gl,
                "glBindBuffer call failed.",
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.buffers[i])
            );

            // SAFETY: the buffer holds `max_vertices_drawn * 4` floats.
            let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
            crate::glu::expect_no_error(gl, "glMapBuffer call failed.")?;

            if mapped.is_null() {
                return internal_error();
            }

            // SAFETY: the mapping is `words` floats long and stays valid until the unmap below.
            let results = unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), words) };

            for j in 0..number_of_vertices {
                if !is_ok {
                    break;
                }

                for k in 0..4 {
                    let result = results[j * 4 + k];
                    let reference = (i * 4 + k) as f32;

                    if (result - reference).abs() > 0.125 {
                        is_ok = false;
                        break;
                    }
                }
            }

            gl_call!(
                gl,
                "glUnmapBuffer call failed.",
                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
            );
        }

        if is_ok {
            gl_call!(
                gl,
                "glBindBuffer call failed.",
                gl.bind_buffer(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    self.buffers[self.max_transform_feedback_separate_attribs as usize - 1]
                )
            );

            // SAFETY: the buffer holds `max_vertices_drawn * 4` floats.
            let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
            crate::glu::expect_no_error(gl, "glMapBuffer call failed.")?;

            if mapped.is_null() {
                return internal_error();
            }

            // SAFETY: the mapping is `words` floats long and stays valid until the unmap below.
            let results = unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), words) };

            for j in 0..number_of_vertices {
                if !is_ok {
                    break;
                }

                let result = [
                    results[j * 4],
                    results[j * 4 + 1],
                    results[j * 4 + 2],
                    results[j * 4 + 3],
                ];

                if position_is_wrong(&result) {
                    is_ok = false;
                    break;
                }
            }

            gl_call!(
                gl,
                "glUnmapBuffer call failed.",
                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
            );
        }

        Ok(is_ok)
    }

    /// The `checkTransformFeedbackBuffer` overrides; `Query*` compares the primitives-written query instead of the buffer.
    fn check_transform_feedback_buffer(&self, primitive_type: GLenum) -> Result<bool, TestError> {
        if self.variant == Variant::Query {
            let gl = self.context.gl();
            let mut number_of_primitives: GLuint = 0;
            gl_call!(
                gl,
                "glGetQueryObjectuiv call failed.",
                gl.get_query_objectuiv(self.query_object, glw::GL_QUERY_RESULT, &mut number_of_primitives)
            );

            let number_of_primitives_reference = if primitive_type == glw::GL_POINTS { 3 } else { 1 };
            return Ok(number_of_primitives_reference == number_of_primitives);
        }

        if self.separate {
            self.check_separate(primitive_type)
        } else {
            self.check_interleaved(primitive_type)
        }
    }
}

/// Whether a captured `gl_Position` is not the expected corner of the clip volume.
fn position_is_wrong(result: &[f32; 4]) -> bool {
    let epsilon = RASTERIZATION_EPSILON as f64;

    ((result[0].abs() as f64 - 1.0 + epsilon).abs() > 0.125)
        || ((result[1].abs() as f64 - 1.0 + epsilon).abs() > 0.125)
        || (result[2].abs() > 0.125)
        || ((result[3] as f64 - 1.0).abs() > 0.125)
}

impl TestCase for CaptureCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let context_type = context.context_type();
        let is_at_least_gl_30 = context_type.supports_core(3, 0);
        let is_at_least_gl_32 = context_type.supports_core(3, 2);
        let is_ext_tf_1 = context.context_info.is_extension_supported("GL_EXT_transform_feedback");
        let is_arb_gs_4 = context.context_info.is_extension_supported("GL_ARB_geometry_shader4");

        let mut capture = Capture::new(context, self);
        let mut is_ok = true;
        let bind_cases = [BindBufferCase::Base, BindBufferCase::Range];

        if !self.geometry {
            if is_at_least_gl_30 || is_ext_tf_1 {
                capture.fetch_limits()?;
                capture.build_program(0)?;
                capture.create_framebuffer()?;
                capture.create_transform_feedback_buffer()?;
                capture.create_vertex_array_object()?;

                gl_call!(gl, "glUseProgram call failed.", gl.use_program(capture.program));

                for bind_case in bind_cases {
                    if !is_ok {
                        break;
                    }

                    capture.bind_buffer(bind_case);

                    for primitive_case in 0..PRIMITIVE_CASES.len() {
                        if !is_ok {
                            break;
                        }

                        capture.draw(primitive_case)?;
                        is_ok = is_ok && capture.check_framebuffer()?;
                        is_ok = is_ok && capture.check_transform_feedback_buffer(PRIMITIVE_CASES[primitive_case])?;
                    }
                }
            }

            if is_ok {
                log::info!("Capture Vertex have passed.");
            }
        } else {
            if (is_at_least_gl_30 || is_ext_tf_1) && (is_at_least_gl_32 || is_arb_gs_4) {
                capture.fetch_limits()?;
                capture.create_framebuffer()?;
                capture.create_transform_feedback_buffer()?;
                capture.create_vertex_array_object()?;

                for primitive_case in 0..GEOMETRY_PRIMITIVE_CASES.len() {
                    if !is_ok {
                        break;
                    }

                    capture.build_program(primitive_case)?;
                    gl_call!(gl, "glUseProgram call failed.", gl.use_program(capture.program));

                    for bind_case in bind_cases {
                        if !is_ok {
                            break;
                        }

                        capture.bind_buffer(bind_case);
                        capture.draw(primitive_case)?;
                        is_ok = is_ok && capture.check_framebuffer()?;
                        is_ok = is_ok
                            && capture.check_transform_feedback_buffer(GEOMETRY_PRIMITIVE_CASES_XFB[primitive_case])?;
                    }

                    gl_call!(gl, "glDeleteProgram call failed.", gl.delete_program(capture.program));
                    capture.program = 0;
                }
            }

            if is_ok {
                log::info!("Capture Geometry have passed.");
            }
        }

        verdict(is_ok)
    }
}

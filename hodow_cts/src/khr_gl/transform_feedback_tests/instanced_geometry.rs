// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedbackTests.cpp  (DrawXFBInstanced, DrawXFBStreamInstanced, Geometry)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `glGetUniformBlockIndex` and `glUniformBlockBinding` are called through glw instead of `getProcAddress`; `clean` of each class is the `Drop` of its state; the shaders of `Geometry` are in the generated geometry_shaders.rs.

use std::ffi::CString;

use super::{Sources, build_program, geometry_shaders, internal_error, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLsizei, GLsizeiptr, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome};

const INSTANCED_VIEW_SIZE: GLsizei = 4;
const INSTANCED_BO_XFB_SIZE: usize = 4 * 4 * std::mem::size_of::<f32>();
const INSTANCED_UNIFORM: &str = "MatrixBlock";
const INSTANCED_UNIFORM_DATA: [f32; 64] = [
    0.5, 0.0, 0.0, 0.5, 0.0, 0.5, 0.0, 0.5, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, 1.0, 0.5, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0,
    0.5, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, 1.0, 0.5, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0, -0.5, 0.0, 0.0, 0.5, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.5, 0.0, 0.0, 0.5, 0.0, 0.5, 0.0, -0.5, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, 1.0,
];

const INSTANCED_VERTEX_SHADER_GENERATE: &str = "#version 140\n\nvoid main()\n{\n    switch(gl_VertexID % 4)\n    {\n    case 0:\n       gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n       break;\n    case 1:\n       gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);\n       break;\n    case 2:\n       gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n       break;\n    case 3:\n       gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);\n       break;\n    }\n}\n";
const INSTANCED_VERTEX_SHADER_DRAW: &str = "#version 140\n\nuniform MatrixBlock\n{\n    mat4 transformation_0;\n    mat4 transformation_1;\n    mat4 transformation_2;\n    mat4 transformation_3;\n};\n\nin vec4 position;\n\nvoid main()\n{\n    switch(gl_InstanceID % 4)\n    {\n    case 0:\n       gl_Position = position * transformation_0;\n       break;\n    case 1:\n       gl_Position = position * transformation_1;\n       break;\n    case 2:\n       gl_Position = position * transformation_2;\n       break;\n    case 3:\n       gl_Position = position * transformation_3;\n       break;\n    }\n}\n";
const INSTANCED_FRAGMENT_SHADER: &str =
    "#version 130\n\nout vec4 pixel;\n\nvoid main()\n{\n    pixel = vec4(1.0);\n}\n";

/// The framebuffer both instanced cases render into and check: a red-only target filled with 1.0.
fn create_instanced_framebuffer(context: &Context, fbo_id: &mut GLuint, rbo_id: &mut GLuint) -> Result<(), TestError> {
    let gl = context.gl();

    gl_call!(gl, "glClearColor call failed.", gl.clear_color(0.0, 0.0, 0.0, 1.0));
    gl_call!(gl, "glGenFramebuffers call failed.", gl.gen_framebuffers(1, fbo_id));
    gl_call!(gl, "glGenRenderbuffers call failed.", gl.gen_renderbuffers(1, rbo_id));
    gl_call!(
        gl,
        "glBindFramebuffer call failed.",
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, *fbo_id)
    );
    gl_call!(
        gl,
        "glBindRenderbuffer call failed.",
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, *rbo_id)
    );
    gl_call!(
        gl,
        "glRenderbufferStorage call failed.",
        gl.renderbuffer_storage(
            glw::GL_RENDERBUFFER,
            glw::GL_R8,
            INSTANCED_VIEW_SIZE,
            INSTANCED_VIEW_SIZE
        )
    );
    gl_call!(
        gl,
        "glFramebufferRenderbuffer call failed.",
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            *rbo_id
        )
    );

    // SAFETY: plain state query.
    if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
        return internal_error();
    }

    gl_call!(
        gl,
        "glViewport call failed.",
        gl.viewport(0, 0, INSTANCED_VIEW_SIZE, INSTANCED_VIEW_SIZE)
    );
    Ok(())
}

/// The `check` both instanced cases share: every pixel is 1.0.
fn check_instanced_framebuffer(context: &Context) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut pixels = vec![0.0f32; (INSTANCED_VIEW_SIZE * INSTANCED_VIEW_SIZE) as usize];

    gl_call!(
        gl,
        "glReadPixels call failed.",
        gl.read_pixels(
            0,
            0,
            INSTANCED_VIEW_SIZE,
            INSTANCED_VIEW_SIZE,
            glw::GL_RED,
            glw::GL_FLOAT,
            pixels.as_mut_ptr().cast()
        )
    );
    Ok(pixels.iter().all(|pixel| (pixel - 1.0).abs() <= 0.0625))
}

/// The uniform block binding both instanced cases set up for `MatrixBlock`.
fn bind_matrix_block(context: &Context, program: GLuint, bo_id_uniform: &mut GLuint) -> Result<(), TestError> {
    let gl = context.gl();

    gl_call!(gl, "glGenBuffers call failed.", gl.gen_buffers(1, bo_id_uniform));
    gl_call!(
        gl,
        "glBindBuffer call failed.",
        gl.bind_buffer(glw::GL_UNIFORM_BUFFER, *bo_id_uniform)
    );
    gl_call!(
        gl,
        "glBufferData call failed.",
        gl.buffer_data(
            glw::GL_UNIFORM_BUFFER,
            std::mem::size_of_val(&INSTANCED_UNIFORM_DATA) as GLsizeiptr,
            INSTANCED_UNIFORM_DATA.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY
        )
    );
    gl_call!(
        gl,
        "glBindBufferRange call failed.",
        gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, 0, *bo_id_uniform)
    );

    let name = CString::new(INSTANCED_UNIFORM).expect("names have no NUL");
    // SAFETY: the name is a live NUL-terminated string.
    let uniform_index = unsafe { gl.get_uniform_block_index(program, name.as_ptr()) };
    crate::glu::expect_no_error(gl, "glGetUniformBlockIndex call failed.")?;

    if uniform_index == glw::GL_INVALID_INDEX {
        return internal_error();
    }

    gl_call!(
        gl,
        "glUniformBlockBinding call failed.",
        gl.uniform_block_binding(program, uniform_index, 0)
    );
    Ok(())
}

/// The objects of `DrawXFBInstanced` and `DrawXFBStreamInstanced`; their `clean` is the `Drop`.
struct InstancedState<'a> {
    context: &'a Context,
    program_id_generate: GLuint,
    program_id_draw: GLuint,
    vao_id: GLuint,
    xfb_id: GLuint,
    bo_id_xfb: GLuint,
    bo_id_xfb_color: GLuint,
    bo_id_uniform: GLuint,
    fbo_id: GLuint,
    rbo_id: GLuint,
    draw_attributes: &'static [&'static str],
}

impl Drop for InstancedState<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            gl.use_program(0);

            if self.program_id_generate != 0 {
                gl.delete_program(self.program_id_generate);
            }
            if self.program_id_draw != 0 {
                for attribute in self.draw_attributes {
                    let name = CString::new(*attribute).expect("names have no NUL");
                    let location = gl.get_attrib_location(self.program_id_draw, name.as_ptr()) as GLuint;
                    gl.disable_vertex_attrib_array(location);
                }
                gl.delete_program(self.program_id_draw);
            }
            if self.xfb_id != 0 {
                gl.delete_transform_feedbacks(1, &self.xfb_id);
            }
            for bo_id in [self.bo_id_xfb, self.bo_id_xfb_color, self.bo_id_uniform] {
                if bo_id != 0 {
                    gl.delete_buffers(1, &bo_id);
                }
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }
            if self.fbo_id != 0 {
                gl.delete_framebuffers(1, &self.fbo_id);
            }
            if self.rbo_id != 0 {
                gl.delete_renderbuffers(1, &self.rbo_id);
            }
        }
    }
}

impl<'a> InstancedState<'a> {
    fn new(context: &'a Context, draw_attributes: &'static [&'static str]) -> Self {
        Self {
            context,
            program_id_generate: 0,
            program_id_draw: 0,
            vao_id: 0,
            xfb_id: 0,
            bo_id_xfb: 0,
            bo_id_xfb_color: 0,
            bo_id_uniform: 0,
            fbo_id: 0,
            rbo_id: 0,
            draw_attributes,
        }
    }

    /// The part of both `prepareObjects` before the uniform block: programs, transform feedback object, vertex array and the capture buffers (a second one, for the colour on stream 1, when `with_color_buffer`).
    fn prepare_capture(
        &mut self,
        generate: &Sources,
        draw: &Sources,
        varyings: &[&str],
        with_color_buffer: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        self.program_id_generate = build_program(gl, generate, varyings, glw::GL_INTERLEAVED_ATTRIBS);
        if self.program_id_generate == 0 {
            return internal_error();
        }

        self.program_id_draw = build_program(gl, draw, &[], glw::GL_INTERLEAVED_ATTRIBS);
        if self.program_id_draw == 0 {
            return internal_error();
        }

        gl_call!(
            gl,
            "glGenTransformFeedbacks call failed.",
            gl.gen_transform_feedbacks(1, &mut self.xfb_id)
        );
        gl_call!(
            gl,
            "glBindTransformFeedbacks call failed.",
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.xfb_id)
        );
        gl_call!(
            gl,
            "glGenVertexArrays call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao_id)
        );
        gl_call!(gl, "glBindVertexArray call failed.", gl.bind_vertex_array(self.vao_id));

        let buffers = if with_color_buffer { 2 } else { 1 };
        for index in 0..buffers {
            let target = if index == 0 {
                &mut self.bo_id_xfb
            } else {
                &mut self.bo_id_xfb_color
            };

            gl_call!(gl, "glGenBuffers call failed.", gl.gen_buffers(1, target));
            gl_call!(
                gl,
                "glBindBuffer call failed.",
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, *target)
            );
            gl_call!(
                gl,
                "glBufferData call failed.",
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    INSTANCED_BO_XFB_SIZE as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_COPY
                )
            );
            gl_call!(
                gl,
                "glBindBufferRange call failed.",
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, index, *target)
            );
        }

        Ok(())
    }

    /// `drawForXFB` of both classes.
    fn draw_for_xfb(&self) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_generate)
        );
        gl_call!(gl, "glEnable call failed.", gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );
        gl_call!(gl, "glDrawArrays call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 4));
        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());
        gl_call!(gl, "glDisable call failed.", gl.disable(glw::GL_RASTERIZER_DISCARD));
        Ok(())
    }

    /// The `glBindBuffer`, `glGetAttribLocation`, `glVertexAttribPointer` and `glEnableVertexAttribArray` sequence of one attribute fed from `bo_id`.
    fn feed_attribute(&self, bo_id: GLuint, attribute: &str) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo_id)
        );

        let name = CString::new(attribute).expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let location = unsafe { gl.get_attrib_location(self.program_id_draw, name.as_ptr()) } as GLuint;
        crate::glu::expect_no_error(gl, "glGetAttribLocation call failed.")?;

        gl_call!(
            gl,
            "glVertexAttribPointer call failed.",
            gl.vertex_attrib_pointer(
                location,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "glEnableVertexAttribArray call failed.",
            gl.enable_vertex_attrib_array(location)
        );
        Ok(())
    }
}

/// `DrawXFBInstanced`
pub(super) struct DrawXfbInstanced;

impl TestCase for DrawXfbInstanced {
    fn name(&self) -> &str {
        "draw_xfb_instanced_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let context_type = context.context_type();
        let is_at_least_gl_42 = context_type.supports_core(4, 2);
        let is_at_least_gl_31 = context_type.supports_core(3, 1);
        let is_arb_tf_instanced = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback_instanced");
        let is_arb_ubo = context
            .context_info
            .is_extension_supported("GL_ARB_uniform_buffer_object");
        let mut is_ok = true;

        if is_at_least_gl_42 || ((is_at_least_gl_31 || is_arb_ubo) && is_arb_tf_instanced) {
            let mut state = InstancedState::new(context, &["position"]);

            let generate = Sources {
                vertex: Some(INSTANCED_VERTEX_SHADER_GENERATE),
                fragment: Some(INSTANCED_FRAGMENT_SHADER),
                ..Sources::default()
            };
            let draw = Sources {
                vertex: Some(INSTANCED_VERTEX_SHADER_DRAW),
                fragment: Some(INSTANCED_FRAGMENT_SHADER),
                ..Sources::default()
            };
            state.prepare_capture(&generate, &draw, &["gl_Position"], false)?;

            let mut bo_id_uniform = 0;
            bind_matrix_block(context, state.program_id_draw, &mut bo_id_uniform)?;
            state.bo_id_uniform = bo_id_uniform;

            let (mut fbo_id, mut rbo_id) = (0, 0);
            let framebuffer = create_instanced_framebuffer(context, &mut fbo_id, &mut rbo_id);
            state.fbo_id = fbo_id;
            state.rbo_id = rbo_id;
            framebuffer?;

            state.draw_for_xfb()?;

            state.feed_attribute(state.bo_id_xfb, "position")?;
            gl_call!(gl, "glClear call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));
            gl_call!(gl, "glUseProgram call failed.", gl.use_program(state.program_id_draw));
            gl_call!(
                gl,
                "glDrawArrays call failed.",
                gl.draw_transform_feedback_instanced(glw::GL_TRIANGLE_STRIP, state.xfb_id, 4)
            );

            is_ok = is_ok && check_instanced_framebuffer(context)?;
        }

        if is_ok {
            log::info!("Draw XFB Instanced have passed.");
        } else {
            log::info!("Draw XFB Instanced have failed.");
        }

        verdict(is_ok)
    }
}

const STREAM_INSTANCED_VERTEX_SHADER_BLANK: &str = "#version 140\n\nvoid main()\n{\n}\n";
const STREAM_INSTANCED_GEOMETRY_SHADER_GENERATE: &str = "#version 400\n\nlayout(points) in;\nlayout(points, max_vertices = 8) out;\n\nlayout(stream = 1) out vec4 color;\n\nvoid main()\n{\n    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n    EmitStreamVertex(0);\n    gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);\n    EmitStreamVertex(0);\n    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n    EmitStreamVertex(0);\n    gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);\n    EmitStreamVertex(0);\n\n    color = vec4(1.0, 1.0, 1.0, 1.0);\n    EmitStreamVertex(1);\n    color = vec4(1.0, 1.0, 1.0, 1.0);\n    EmitStreamVertex(1);\n    color = vec4(1.0, 1.0, 1.0, 1.0);\n    EmitStreamVertex(1);\n    color = vec4(1.0, 1.0, 1.0, 1.0);\n    EmitStreamVertex(1);\n}\n";
const STREAM_INSTANCED_VERTEX_SHADER_DRAW: &str = "#version 140\n\nuniform MatrixBlock\n{\n    mat4 transformation_0;\n    mat4 transformation_1;\n    mat4 transformation_2;\n    mat4 transformation_3;\n};\n\nin  vec4 position;\nin  vec4 color;\nout vec4 colour;\n\nvoid main()\n{\n    switch(gl_InstanceID % 4)\n    {\n    case 0:\n       gl_Position = position * transformation_0;\n       break;\n    case 1:\n       gl_Position = position * transformation_1;\n       break;\n    case 2:\n       gl_Position = position * transformation_2;\n       break;\n    case 3:\n       gl_Position = position * transformation_3;\n       break;\n    }\n    colour = color;\n}\n";
const STREAM_INSTANCED_FRAGMENT_SHADER_BLANK: &str =
    "#version 130\n\nout vec4 pixel;\n\nvoid main()\n{\n    pixel = vec4(1.0);\n}\n";
const STREAM_INSTANCED_FRAGMENT_SHADER_DRAW: &str =
    "#version 130\n\nin vec4 colour;\nout vec4 pixel;\n\nvoid main()\n{\n    pixel = colour;\n}\n";
const STREAM_INSTANCED_XFB_VARYINGS: [&str; 3] = ["gl_Position", "gl_NextBuffer", "color"];

/// `DrawXFBStreamInstanced`
pub(super) struct DrawXfbStreamInstanced;

impl TestCase for DrawXfbStreamInstanced {
    fn name(&self) -> &str {
        "draw_xfb_stream_instanced_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let context_type = context.context_type();
        let is_at_least_gl_31 = context_type.supports_core(3, 1);
        let is_at_least_gl_40 = context_type.supports_core(4, 0);
        let is_at_least_gl_42 = context_type.supports_core(4, 2);
        let is_arb_tf_instanced = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback_instanced");
        let is_arb_ubo = context
            .context_info
            .is_extension_supported("GL_ARB_uniform_buffer_object");
        let is_arb_gpu_shader5 = context.context_info.is_extension_supported("GL_ARB_gpu_shader5");
        let mut is_ok = true;

        if is_at_least_gl_42
            || ((is_at_least_gl_31 || is_arb_ubo) && is_arb_gpu_shader5 && is_arb_tf_instanced)
            || (is_at_least_gl_40 && is_arb_tf_instanced)
        {
            let mut state = InstancedState::new(context, &["position", "color"]);

            let generate = Sources {
                geometry: Some(STREAM_INSTANCED_GEOMETRY_SHADER_GENERATE),
                vertex: Some(STREAM_INSTANCED_VERTEX_SHADER_BLANK),
                fragment: Some(STREAM_INSTANCED_FRAGMENT_SHADER_BLANK),
                ..Sources::default()
            };
            let draw = Sources {
                vertex: Some(STREAM_INSTANCED_VERTEX_SHADER_DRAW),
                fragment: Some(STREAM_INSTANCED_FRAGMENT_SHADER_DRAW),
                ..Sources::default()
            };
            state.prepare_capture(&generate, &draw, &STREAM_INSTANCED_XFB_VARYINGS, true)?;

            let mut bo_id_uniform = 0;
            bind_matrix_block(context, state.program_id_draw, &mut bo_id_uniform)?;
            state.bo_id_uniform = bo_id_uniform;

            let (mut fbo_id, mut rbo_id) = (0, 0);
            let framebuffer = create_instanced_framebuffer(context, &mut fbo_id, &mut rbo_id);
            state.fbo_id = fbo_id;
            state.rbo_id = rbo_id;
            framebuffer?;

            state.draw_for_xfb()?;

            state.feed_attribute(state.bo_id_xfb, "position")?;
            state.feed_attribute(state.bo_id_xfb_color, "color")?;
            gl_call!(gl, "glUseProgram call failed.", gl.use_program(state.program_id_draw));
            gl_call!(
                gl,
                "glDrawArrays call failed.",
                gl.draw_transform_feedback_stream_instanced(glw::GL_TRIANGLE_STRIP, state.xfb_id, 0, 4)
            );

            is_ok = is_ok && check_instanced_framebuffer(context)?;
        }

        if is_ok {
            log::info!("Draw XFB Stream Instanced have passed.");
        } else {
            log::info!("Draw XFB Stream Instanced have failed.");
        }

        verdict(is_ok)
    }
}

const GEOMETRY_INITIAL_DATA: [f32; 12] = [1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 2.0, 1.0, 1.0, -1.0, 3.0, 1.0];
const GEOMETRY_REFERENCE_DATA: [f32; 24] = [
    1.0,
    1.0,
    1.0,
    1.0,
    -1.0,
    1.0,
    2.0,
    1.0,
    1.0 / 3.0,
    1.0 / 3.0,
    2.0,
    1.0,
    1.0 / 3.0,
    1.0 / 3.0,
    2.0,
    1.0,
    -1.0,
    1.0,
    2.0,
    1.0,
    1.0,
    -1.0,
    3.0,
    1.0,
];

/// `Geometry`
pub(super) struct Geometry;

impl TestCase for Geometry {
    fn name(&self) -> &str {
        "geometry"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let is_at_least_gl_33 = context.context_type().supports_core(3, 3);
        let mut is_ok = true;

        if is_at_least_gl_33 {
            let bo_size = std::mem::size_of_val(&GEOMETRY_INITIAL_DATA);
            let specialization = [(
                "VERSION",
                context.context_type().glsl_version().declaration().to_string(),
            )];
            let vertex_shader = StringTemplate::new(geometry_shaders::VERTEX_SHADER).specialize(&specialization)?;
            let geometry_shader = StringTemplate::new(geometry_shaders::GEOMETRY_SHADER).specialize(&specialization)?;
            let fragment_shader = StringTemplate::new(geometry_shaders::FRAGMENT_SHADER).specialize(&specialization)?;

            let sources = Sources {
                geometry: Some(&geometry_shader),
                vertex: Some(&vertex_shader),
                fragment: Some(&fragment_shader),
                ..Sources::default()
            };
            let program_id = build_program(gl, &sources, &["gl_Position"], glw::GL_SEPARATE_ATTRIBS);
            if program_id == 0 {
                return internal_error();
            }

            struct Program<'a>(&'a Context, GLuint);

            impl Drop for Program<'_> {
                fn drop(&mut self) {
                    // SAFETY: the program was created above and is deleted once.
                    unsafe {
                        self.0.gl().use_program(0);
                        self.0.gl().delete_program(self.1);
                    }
                }
            }

            let _program = Program(context, program_id);

            gl_call!(gl, "glUseProgram", gl.use_program(program_id));

            let mut buffer: GLuint = 0;
            gl_call!(gl, "genBuffers", gl.gen_buffers(1, &mut buffer));
            gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer));
            gl_call!(
                gl,
                "bufferData",
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    (bo_size * 2) as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW
                )
            );
            gl_call!(
                gl,
                "bindBufferBase",
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buffer)
            );
            gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

            let mut queries = [0 as GLuint; 2];
            gl_call!(gl, "genQueries", gl.gen_queries(2, queries.as_mut_ptr()));
            gl_call!(
                gl,
                "beginQuery",
                gl.begin_query(glw::GL_PRIMITIVES_GENERATED, queries[0])
            );
            gl_call!(
                gl,
                "beginQuery",
                gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, queries[1])
            );

            let mut vbo: GLuint = 0;
            gl_call!(gl, "glGenBuffers", gl.gen_buffers(1, &mut vbo));
            gl_call!(gl, "glBindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo));
            gl_call!(
                gl,
                "glBufferData",
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    bo_size as GLsizeiptr,
                    GEOMETRY_INITIAL_DATA.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                )
            );

            let mut vao: GLuint = 0;
            gl_call!(gl, "genVertexArrays", gl.gen_vertex_arrays(1, &mut vao));
            gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(vao));

            let vertex = CString::new("vertex").expect("names have no NUL");
            // SAFETY: the name is a live NUL-terminated string.
            let loc_vertices = unsafe { gl.get_attrib_location(program_id, vertex.as_ptr()) } as GLuint;
            crate::glu::expect_no_error(gl, "getAttribLocation")?;

            gl_call!(gl, "enable", gl.enable(glw::GL_RASTERIZER_DISCARD));
            gl_call!(gl, "clearColor", gl.clear_color(0.1, 0.0, 0.0, 1.0));
            gl_call!(
                gl,
                "clear",
                gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT)
            );
            gl_call!(
                gl,
                "vertexAttribPointer",
                gl.vertex_attrib_pointer(
                    loc_vertices,
                    4,
                    glw::GL_FLOAT,
                    glw::GL_FALSE as glw::GLboolean,
                    0,
                    std::ptr::null()
                )
            );
            gl_call!(
                gl,
                "enableVertexAttribArray",
                gl.enable_vertex_attrib_array(loc_vertices)
            );
            gl_call!(
                gl,
                "beginTransformFeedback",
                gl.begin_transform_feedback(glw::GL_TRIANGLES)
            );
            gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
            gl_call!(gl, "endTransformFeedback", gl.end_transform_feedback());
            gl_call!(gl, "disable", gl.disable(glw::GL_RASTERIZER_DISCARD));
            gl_call!(
                gl,
                "disableVertexAttribArray",
                gl.disable_vertex_attrib_array(loc_vertices)
            );

            let mut query_results = [0 as GLuint; 2];
            gl_call!(gl, "endQuery", gl.end_query(glw::GL_PRIMITIVES_GENERATED));
            gl_call!(
                gl,
                "endQuery",
                gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN)
            );
            gl_call!(
                gl,
                "getQueryObjectuiv",
                gl.get_query_objectuiv(queries[0], glw::GL_QUERY_RESULT, &mut query_results[0])
            );
            gl_call!(
                gl,
                "getQueryObjectuiv",
                gl.get_query_objectuiv(queries[1], glw::GL_QUERY_RESULT, &mut query_results[1])
            );
            gl_call!(gl, "deleteQueries", gl.delete_queries(2, queries.as_ptr()));

            gl_call!(
                gl,
                "bindBufferRange",
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buffer)
            );

            // SAFETY: a read-only mapping of the bound transform feedback buffer.
            let ret = unsafe {
                gl.map_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    (bo_size * 2) as GLsizeiptr,
                    glw::GL_MAP_READ_BIT,
                )
            };
            crate::glu::expect_no_error(gl, "mapBufferRange")?;

            if ret.is_null() {
                log::info!("Geometry::draw unexpected resutl.");
                return internal_error();
            }

            // SAFETY: the mapping is `bo_size * 2` bytes long and stays valid until the unmap below.
            let result_data =
                unsafe { std::slice::from_raw_parts(ret.cast::<f32>(), GEOMETRY_INITIAL_DATA.len() * 2) }.to_vec();

            gl_call!(gl, "unmapBuffer", gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            gl_call!(gl, "glDeleteBuffers", gl.delete_buffers(1, &vbo));
            gl_call!(gl, "glDeleteVertexArrays", gl.delete_vertex_arrays(1, &vao));
            gl_call!(gl, "glDeleteBuffers", gl.delete_buffers(1, &buffer));

            if query_results[0] != 2 || query_results[1] != 2 || result_data.len() != GEOMETRY_REFERENCE_DATA.len() {
                log::info!("Geometry::draw unexpected query resutl.");
                return internal_error();
            }

            for (i, (found, reference)) in result_data.iter().zip(GEOMETRY_REFERENCE_DATA).enumerate() {
                if (found - reference).abs() > 1.0e-03 {
                    log::info!("compareArrays(GLfloat):index {i} value {found} != {reference}");
                    log::info!("Geometry::check unexpected feedback data.");
                    is_ok = false;
                    break;
                }
            }
        }

        if is_ok {
            log::info!("Geometry Feedback have passed.");
        } else {
            log::info!("Geometry Feedback have failed.");
        }

        verdict(is_ok)
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedbackTests.cpp  (DrawXFB, DrawXFBFeedback, CaptureSpecialInterleaved)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `clean` of each class is the `Drop` of its state (DrawXFB's per capture mode, so the objects are gone before the next mode's `prepare` as upstream's `clean` call at the end of the loop body does).

use std::ffi::CString;

use super::{Sources, build_program, internal_error, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizei, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

const DRAW_XFB_VERTEX_SHADER_XFB: &str = "#version 130\n\nuniform vec4 color;\nuniform float invert_sign;\nout     vec4 colour;\n\nvoid main()\n{\n    switch(gl_VertexID)\n    {\n        case 0:\n            gl_Position = vec4(-1.0,               -1.0,              0.0,  1.0);\n        break;\n        case 1:\n            gl_Position = vec4(-1.0 * invert_sign,  1.0,              0.0,  1.0);\n        break;\n        case 2:\n            gl_Position = vec4( 1.0,                1.0 * invert_sign, 0.0,  1.0);\n        break;\n    }\n\n    colour = color;\n}\n";
const DRAW_XFB_VERTEX_SHADER_DRAW: &str = "#version 130\n\nin  vec4 color;\nin  vec4 position;\nout vec4 colour;\n\nvoid main()\n{\n    gl_Position = position;\n    colour      = color;\n}\n";
const DRAW_XFB_FRAGMENT_SHADER: &str =
    "#version 130\n\nin  vec4 colour;\nout vec4 pixel;\n\nvoid main()\n{\n    pixel = colour;\n}\n";
const DRAW_XFB_XFB_VARYINGS: [&str; 2] = ["gl_Position", "colour"];
const DRAW_XFB_CAPTURE_MODES: [GLenum; 2] = [glw::GL_INTERLEAVED_ATTRIBS, glw::GL_SEPARATE_ATTRIBS];
const DRAW_XFB_XFB_VARYINGS_COUNT: usize = 2;
const DRAW_XFB_VERTEX_COUNT: usize = 3;
const DRAW_XFB_CAPTURE_SIZE: usize =
    DRAW_XFB_VERTEX_COUNT * std::mem::size_of::<f32>() * 4 * DRAW_XFB_XFB_VARYINGS_COUNT * 2;
const DRAW_XFB_VIEW_SIZE: GLsizei = 2;
const DRAW_XFB_XFB_COUNT: usize = 3;
const DRAW_XFB_COLOURS: [[f32; 4]; DRAW_XFB_XFB_COUNT] =
    [[1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0], [0.0, 0.0, 1.0, 1.0]];

/// The objects of `DrawXFB` for one capture mode; its `clean` is the `Drop`.
struct DrawXfbState<'a> {
    context: &'a Context,
    program_id_xfb: GLuint,
    program_id_draw: GLuint,
    xfb_id: [GLuint; DRAW_XFB_XFB_COUNT],
    bo_id: [GLuint; DRAW_XFB_XFB_COUNT],
    fbo_id: GLuint,
    rbo_id: GLuint,
    vao_id: GLuint,
}

impl Drop for DrawXfbState<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            gl.use_program(0);

            if self.program_id_xfb != 0 {
                gl.delete_program(self.program_id_xfb);
            }
            if self.program_id_draw != 0 {
                gl.delete_program(self.program_id_draw);
            }
            for xfb_id in &self.xfb_id {
                if *xfb_id != 0 {
                    gl.delete_transform_feedbacks(1, xfb_id);
                }
            }
            for bo_id in &self.bo_id {
                if *bo_id != 0 {
                    gl.delete_buffers(1, bo_id);
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

impl DrawXfbState<'_> {
    /// `DrawXFB::prepare`
    fn prepare(&mut self, capture_mode: GLenum) -> Result<(), TestError> {
        let gl = self.context.gl();

        let sources = Sources {
            vertex: Some(DRAW_XFB_VERTEX_SHADER_XFB),
            fragment: Some(DRAW_XFB_FRAGMENT_SHADER),
            ..Sources::default()
        };
        self.program_id_xfb = build_program(gl, &sources, &DRAW_XFB_XFB_VARYINGS, capture_mode);
        if self.program_id_xfb == 0 {
            return internal_error();
        }

        let sources = Sources {
            vertex: Some(DRAW_XFB_VERTEX_SHADER_DRAW),
            fragment: Some(DRAW_XFB_FRAGMENT_SHADER),
            ..Sources::default()
        };
        self.program_id_draw = build_program(gl, &sources, &[], capture_mode);
        if self.program_id_draw == 0 {
            return internal_error();
        }

        gl_call!(
            gl,
            "glGenTransformFeedbacks call failed.",
            gl.gen_transform_feedbacks(DRAW_XFB_XFB_COUNT as GLsizei, self.xfb_id.as_mut_ptr())
        );
        gl_call!(
            gl,
            "glGenBuffers call failed.",
            gl.gen_buffers(DRAW_XFB_XFB_COUNT as GLsizei, self.bo_id.as_mut_ptr())
        );

        for i in 0..DRAW_XFB_XFB_COUNT {
            gl_call!(
                gl,
                "glBindBuffer call failed.",
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.bo_id[i])
            );
            gl_call!(
                gl,
                "glBufferData call failed.",
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    DRAW_XFB_CAPTURE_SIZE as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_COPY
                )
            );
        }

        gl_call!(gl, "glClearColor call failed.", gl.clear_color(0.0, 0.0, 0.0, 1.0));
        gl_call!(
            gl,
            "glGenFramebuffers call failed.",
            gl.gen_framebuffers(1, &mut self.fbo_id)
        );
        gl_call!(
            gl,
            "glGenRenderbuffers call failed.",
            gl.gen_renderbuffers(1, &mut self.rbo_id)
        );
        gl_call!(
            gl,
            "glBindFramebuffer call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo_id)
        );
        gl_call!(
            gl,
            "glBindRenderbuffer call failed.",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, self.rbo_id)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage call failed.",
            gl.renderbuffer_storage(
                glw::GL_RENDERBUFFER,
                glw::GL_RGBA8,
                DRAW_XFB_VIEW_SIZE,
                DRAW_XFB_VIEW_SIZE
            )
        );
        gl_call!(
            gl,
            "glFramebufferRenderbuffer call failed.",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                self.rbo_id
            )
        );

        // SAFETY: plain state query.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return internal_error();
        }

        gl_call!(
            gl,
            "glViewport call failed.",
            gl.viewport(0, 0, DRAW_XFB_VIEW_SIZE, DRAW_XFB_VIEW_SIZE)
        );
        gl_call!(
            gl,
            "glGenVertexArrays call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao_id)
        );
        Ok(())
    }

    fn bind_xfb(&self, xfb_id: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "glBindTransformFeedback call failed.",
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, xfb_id)
        );
        Ok(())
    }

    fn bind_vao(&self, vao_id: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "glBindVertexArray call failed.", gl.bind_vertex_array(vao_id));
        Ok(())
    }

    /// `DrawXFB::bindBOForXFB`
    fn bind_bo_for_xfb(&self, capture_mode: GLenum, bo_id: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();

        match capture_mode {
            glw::GL_INTERLEAVED_ATTRIBS => {
                gl_call!(
                    gl,
                    "glBindBufferBase call failed.",
                    gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, bo_id)
                );
            }
            glw::GL_SEPARATE_ATTRIBS => {
                for i in 0..DRAW_XFB_XFB_VARYINGS_COUNT {
                    gl_call!(
                        gl,
                        "glBindBufferBase call failed.",
                        gl.bind_buffer_range(
                            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                            i as GLuint,
                            bo_id,
                            (i * DRAW_XFB_CAPTURE_SIZE / DRAW_XFB_XFB_VARYINGS_COUNT) as glw::GLintptr,
                            ((i + 1) * DRAW_XFB_CAPTURE_SIZE / DRAW_XFB_XFB_VARYINGS_COUNT) as GLsizeiptr
                        )
                    );
                }
            }
            _ => return internal_error(),
        }

        Ok(())
    }

    /// `DrawXFB::bindBOForDraw`
    fn bind_bo_for_draw(&self, program_id: GLuint, capture_mode: GLenum, bo_id: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo_id)
        );

        let position = CString::new("position").expect("names have no NUL");
        let color = CString::new("color").expect("names have no NUL");
        // SAFETY: the names are live NUL-terminated strings.
        let (position_location, color_location) = unsafe {
            (
                gl.get_attrib_location(program_id, position.as_ptr()) as GLuint,
                gl.get_attrib_location(program_id, color.as_ptr()) as GLuint,
            )
        };
        crate::glu::expect_no_error(gl, "glGetAttribLocation call failed.")?;

        let float_size = std::mem::size_of::<f32>();
        let color_offset = if capture_mode == glw::GL_INTERLEAVED_ATTRIBS {
            4 * float_size
        } else {
            4 * 6 * float_size
        };
        let stride = (if capture_mode == glw::GL_INTERLEAVED_ATTRIBS {
            4 * 2 * float_size
        } else {
            4 * float_size
        }) as GLsizei;

        gl_call!(gl, "glVertexAttribPointer call failed.", {
            gl.vertex_attrib_pointer(
                position_location,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                stride,
                std::ptr::null(),
            );
            gl.vertex_attrib_pointer(
                color_location,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                stride,
                color_offset as *const std::ffi::c_void,
            );
        });
        gl_call!(gl, "glEnableVertexAttribArray call failed.", {
            gl.enable_vertex_attrib_array(position_location);
            gl.enable_vertex_attrib_array(color_location);
        });

        Ok(())
    }

    fn use_program(&self, program_id: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "glUseProgram call failed.", gl.use_program(program_id));
        Ok(())
    }

    /// `DrawXFB::useColour`
    fn use_colour(&self, program_id: GLuint, colour: &[f32; 4]) -> Result<(), TestError> {
        let gl = self.context.gl();
        let name = CString::new("color").expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let location = unsafe { gl.get_uniform_location(program_id, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "glGetUniformLocation call failed.")?;
        gl_call!(
            gl,
            "glUniform4f call failed.",
            gl.uniform_4f(location, colour[0], colour[1], colour[2], colour[3])
        );
        Ok(())
    }

    /// `DrawXFB::useGeometrySet`
    fn use_geometry_set(&self, program_id: GLuint, invert_sign: bool) -> Result<(), TestError> {
        let gl = self.context.gl();
        let name = CString::new("invert_sign").expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let location = unsafe { gl.get_uniform_location(program_id, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "glGetUniformLocation call failed.")?;
        gl_call!(
            gl,
            "glUniform4f call failed.",
            gl.uniform_1f(location, if invert_sign { -1.0 } else { 1.0 })
        );
        Ok(())
    }

    /// `DrawXFB::drawForCapture`
    fn draw_for_capture(
        &self,
        begin_xfb: bool,
        pause_xfb: bool,
        resume_xfb: bool,
        end_xfb: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(gl, "glEnable call failed.", gl.enable(glw::GL_RASTERIZER_DISCARD));

        if begin_xfb {
            gl_call!(
                gl,
                "glBeginTransformFeedback call failed.",
                gl.begin_transform_feedback(glw::GL_POINTS)
            );
        }
        if resume_xfb {
            gl_call!(
                gl,
                "glResumeTransformFeedback call failed.",
                gl.resume_transform_feedback()
            );
        }

        // SAFETY: plain draw; upstream does not check this call.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 3) };

        if pause_xfb {
            gl_call!(
                gl,
                "glPauseTransformFeedback call failed.",
                gl.pause_transform_feedback()
            );
        }
        if end_xfb {
            gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());
        }

        gl_call!(gl, "glDisable call failed.", gl.disable(glw::GL_RASTERIZER_DISCARD));
        Ok(())
    }

    /// `DrawXFB::drawToFramebuffer`
    fn draw_to_framebuffer(&self, xfb_id: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(gl, "glClearColor call failed.", gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl_call!(gl, "glClear call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl_call!(
            gl,
            "glDrawTransformFeedback call failed.",
            gl.draw_transform_feedback(glw::GL_TRIANGLES, xfb_id)
        );
        Ok(())
    }

    /// `DrawXFB::checkFramebuffer`
    fn check_framebuffer(&self, colour: &[f32; 4]) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let number_of_pixels = (DRAW_XFB_VIEW_SIZE * DRAW_XFB_VIEW_SIZE) as usize;
        let mut pixels = vec![0u8; number_of_pixels * 4];

        gl_call!(
            gl,
            "glReadPixels call failed.",
            gl.read_pixels(
                0,
                0,
                DRAW_XFB_VIEW_SIZE,
                DRAW_XFB_VIEW_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                pixels.as_mut_ptr().cast()
            )
        );

        let expected: [u8; 4] = colour.map(|component| (255.0 * component) as u8);
        Ok(pixels.chunks_exact(4).all(|pixel| pixel == expected))
    }

    /// `DrawXFB::inspectXFBState`
    fn inspect_xfb_state(&self, shall_be_paused: bool, shall_be_active: bool) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut is_paused: GLint = 0;
        let mut is_active: GLint = 0;

        gl_call!(gl, "glGetIntegerv call failed.", {
            gl.get_integerv(glw::GL_TRANSFORM_FEEDBACK_PAUSED, &mut is_paused);
            gl.get_integerv(glw::GL_TRANSFORM_FEEDBACK_ACTIVE, &mut is_active);
        });

        if is_paused == -1 || is_active == -1 {
            return internal_error();
        }

        Ok(shall_be_paused == (is_paused == glw::GL_TRUE as GLint)
            && shall_be_active == (is_active == glw::GL_TRUE as GLint))
    }
}

/// `DrawXFB`
pub(super) struct DrawXfb;

impl TestCase for DrawXfb {
    fn name(&self) -> &str {
        "draw_xfb_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let is_at_least_gl_40 = context.context_type().supports_core(4, 0);
        let is_arb_tf_2 = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback2");
        let mut is_ok = true;

        if is_at_least_gl_40 || is_arb_tf_2 {
            for capture_mode in DRAW_XFB_CAPTURE_MODES {
                if !is_ok {
                    break;
                }

                let mut state = DrawXfbState {
                    context,
                    program_id_xfb: 0,
                    program_id_draw: 0,
                    xfb_id: [0; DRAW_XFB_XFB_COUNT],
                    bo_id: [0; DRAW_XFB_XFB_COUNT],
                    fbo_id: 0,
                    rbo_id: 0,
                    vao_id: 0,
                };

                state.prepare(capture_mode)?;
                state.bind_vao(state.vao_id)?;
                state.use_program(state.program_id_xfb)?;

                for j in 0..DRAW_XFB_XFB_COUNT {
                    if !is_ok {
                        break;
                    }

                    state.bind_xfb(state.xfb_id[j])?;
                    state.bind_bo_for_xfb(capture_mode, state.bo_id[j])?;
                    state.use_colour(state.program_id_xfb, &DRAW_XFB_COLOURS[j])?;
                    state.use_geometry_set(state.program_id_xfb, false)?;
                    state.draw_for_capture(true, true, false, false)?;
                    is_ok = is_ok && state.inspect_xfb_state(true, true)?;
                }

                for j in 0..DRAW_XFB_XFB_COUNT {
                    if !is_ok {
                        break;
                    }

                    state.bind_xfb(state.xfb_id[j])?;
                    state.use_colour(state.program_id_xfb, &DRAW_XFB_COLOURS[j])?;
                    state.use_geometry_set(state.program_id_xfb, true)?;
                    state.draw_for_capture(false, false, true, true)?;
                    is_ok = is_ok && state.inspect_xfb_state(false, false)?;
                }

                state.use_program(state.program_id_draw)?;

                for j in 0..DRAW_XFB_XFB_COUNT {
                    if !is_ok {
                        break;
                    }

                    state.bind_xfb(state.xfb_id[j])?;
                    state.bind_bo_for_draw(state.program_id_draw, capture_mode, state.bo_id[j])?;
                    state.draw_to_framebuffer(state.xfb_id[j])?;
                    is_ok = is_ok && state.check_framebuffer(&DRAW_XFB_COLOURS[j])?;
                }
            }
        }

        if is_ok {
            log::info!("Draw XFB have passed.");
        } else {
            log::info!("Draw XFB have failed.");
        }

        verdict(is_ok)
    }
}

const FEEDBACK_VERTEX_SHADER: &str =
    "#version 130\n\nin  vec4 position;\n\nvoid main()\n{\n    gl_Position = position * 2.0;\n}\n";
const FEEDBACK_FRAGMENT_SHADER: &str = "#version 130\n\nout vec4 pixel;\n\nvoid main()\n{\n    pixel = vec4(1.0);\n}\n";
const FEEDBACK_XFB_VARYING: &str = "gl_Position";
const FEEDBACK_INITIAL_DATA: [f32; 4] = [1.0, 2.0, 3.0, 4.0];
const FEEDBACK_BO_COUNT: usize = 2;
const FEEDBACK_BO_SIZE: usize = std::mem::size_of::<[f32; 4]>();

/// The objects of `DrawXFBFeedback`; its `clean` is the `Drop`.
struct FeedbackState<'a> {
    context: &'a Context,
    program_id: GLuint,
    xfb_id: GLuint,
    bo_id: [GLuint; FEEDBACK_BO_COUNT],
    vao_id: [GLuint; FEEDBACK_BO_COUNT],
    source_bo_index: usize,
}

impl Drop for FeedbackState<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            gl.use_program(0);

            if self.program_id != 0 {
                gl.delete_program(self.program_id);
            }
            if self.xfb_id != 0 {
                gl.delete_transform_feedbacks(1, &self.xfb_id);
            }
            for bo_id in &self.bo_id {
                if *bo_id != 0 {
                    gl.delete_buffers(1, bo_id);
                }
            }
            for vao_id in &self.vao_id {
                if *vao_id != 0 {
                    gl.delete_vertex_arrays(1, vao_id);
                }
            }
        }
    }
}

impl FeedbackState<'_> {
    /// `DrawXFBFeedback::prepareAndBind`
    fn prepare_and_bind(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        let sources = Sources {
            vertex: Some(FEEDBACK_VERTEX_SHADER),
            fragment: Some(FEEDBACK_FRAGMENT_SHADER),
            ..Sources::default()
        };
        self.program_id = build_program(gl, &sources, &[FEEDBACK_XFB_VARYING], glw::GL_INTERLEAVED_ATTRIBS);
        if self.program_id == 0 {
            return internal_error();
        }

        gl_call!(gl, "glUseProgram call failed.", gl.use_program(self.program_id));
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
            "glGenBuffers call failed.",
            gl.gen_buffers(FEEDBACK_BO_COUNT as GLsizei, self.bo_id.as_mut_ptr())
        );
        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.bo_id[0])
        );
        gl_call!(
            gl,
            "glBufferData call failed.",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                FEEDBACK_BO_SIZE as GLsizeiptr,
                FEEDBACK_INITIAL_DATA.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY
            )
        );
        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.bo_id[1])
        );
        gl_call!(
            gl,
            "glBufferData call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                FEEDBACK_BO_SIZE as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY
            )
        );
        gl_call!(
            gl,
            "glGenVertexArrays call failed.",
            gl.gen_vertex_arrays(FEEDBACK_BO_COUNT as GLsizei, self.vao_id.as_mut_ptr())
        );

        let position = CString::new("position").expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let position_location = unsafe { gl.get_attrib_location(self.program_id, position.as_ptr()) } as GLuint;
        crate::glu::expect_no_error(gl, "glGetAttribLocation call failed.")?;

        for i in 0..2 {
            gl_call!(
                gl,
                "glBindVertexArray call failed.",
                gl.bind_vertex_array(self.vao_id[i])
            );
            gl_call!(
                gl,
                "glBindBuffer call failed.",
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.bo_id[i])
            );
            gl_call!(
                gl,
                "glVertexAttribPointer call failed.",
                gl.vertex_attrib_pointer(
                    position_location,
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
                gl.enable_vertex_attrib_array(position_location)
            );
        }

        gl_call!(gl, "glBindBuffer call failed.", gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl_call!(
            gl,
            "glBindVertexArray call failed.",
            gl.bind_vertex_array(self.vao_id[0])
        );
        Ok(())
    }

    /// `DrawXFBFeedback::swapBuffers`
    fn swap_buffers(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.bo_id[self.source_bo_index])
        );
        self.source_bo_index = (self.source_bo_index + 1) % 2;
        gl_call!(
            gl,
            "glBindVertexArray call failed.",
            gl.bind_vertex_array(self.vao_id[self.source_bo_index])
        );
        Ok(())
    }

    /// `DrawXFBFeedback::draw`
    fn draw(&self, is_first_draw: bool) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(gl, "glEnable call failed.", gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        if is_first_draw {
            gl_call!(gl, "glDrawArrays call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
        } else {
            gl_call!(
                gl,
                "glDrawTransformFeedback call failed.",
                gl.draw_transform_feedback(glw::GL_POINTS, self.xfb_id)
            );
        }

        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());
        gl_call!(gl, "glDisable call failed.", gl.disable(glw::GL_RASTERIZER_DISCARD));
        Ok(())
    }

    /// `DrawXFBFeedback::check`
    fn check(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        // SAFETY: a read-only mapping of the bound transform feedback buffer.
        let results = unsafe {
            gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                FEEDBACK_BO_SIZE as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        };
        crate::glu::expect_no_error(gl, "glMapBufferRange call failed.")?;

        if results.is_null() {
            return Ok(false);
        }

        // SAFETY: the mapping is `FEEDBACK_BO_SIZE` bytes long and stays valid until the unmap below.
        let values = unsafe { std::slice::from_raw_parts(results.cast::<f32>(), 4) };
        let is_ok = values == [8.0, 16.0, 24.0, 32.0];

        gl_call!(
            gl,
            "glUnmapBuffer call failed.",
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
        );
        Ok(is_ok)
    }
}

/// `DrawXFBFeedback`
pub(super) struct DrawXfbFeedback;

impl TestCase for DrawXfbFeedback {
    fn name(&self) -> &str {
        "draw_xfb_feedbackk_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let is_at_least_gl_40 = context.context_type().supports_core(4, 0);
        let is_arb_tf_2 = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback2");
        let mut is_ok = true;

        if is_at_least_gl_40 || is_arb_tf_2 {
            let mut state = FeedbackState {
                context,
                program_id: 0,
                xfb_id: 0,
                bo_id: [0; FEEDBACK_BO_COUNT],
                vao_id: [0; FEEDBACK_BO_COUNT],
                source_bo_index: 0,
            };

            state.prepare_and_bind()?;
            state.draw(true)?;
            state.swap_buffers()?;
            state.draw(false)?;
            state.swap_buffers()?;
            state.draw(false)?;
            is_ok = is_ok && state.check()?;
        }

        if is_ok {
            log::info!("Draw XFB Feedback have passed.");
        } else {
            log::info!("Draw XFB Feedback have failed.");
        }

        verdict(is_ok)
    }
}

const SPECIAL_VERTEX_SHADER: &str = "#version 130\n\nout vec4 variable_1;\nout vec4 variable_2;\nout vec4 variable_3;\nout vec4 variable_4;\n\nvoid main()\n{\n    variable_1 = vec4(1.0, 2.0, 3.0, 4.0);\n    variable_2 = vec4(5.0, 6.0, 7.0, 8.0);\n    variable_3 = vec4(9.0, 10.0, 11.0, 12.0);\n    variable_4 = vec4(13.0, 14.0, 15.0, 16.0);\n\n    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n}\n";
const SPECIAL_FRAGMENT_SHADER: &str = "#version 130\n\nout vec4 pixel;\n\nvoid main()\n{\n    pixel = vec4(1.0);\n}\n";
const SPECIAL_XFB_VARYINGS: [&str; 7] = [
    "variable_1",
    "gl_SkipComponents4",
    "variable_2",
    "gl_NextBuffer",
    "variable_3",
    "gl_SkipComponents4",
    "variable_4",
];
const SPECIAL_BO_IDS_COUNT: usize = 2;
const SPECIAL_BO_SIZE: usize = 3 * 4 * std::mem::size_of::<f32>();

/// The objects of `CaptureSpecialInterleaved`; its `clean` is the `Drop`.
struct SpecialState<'a> {
    context: &'a Context,
    program_id: GLuint,
    vao_id: GLuint,
    xfb_id: GLuint,
    bo_id: [GLuint; SPECIAL_BO_IDS_COUNT],
}

impl Drop for SpecialState<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            gl.use_program(0);

            if self.program_id != 0 {
                gl.delete_program(self.program_id);
            }
            if self.xfb_id != 0 {
                gl.delete_transform_feedbacks(1, &self.xfb_id);
            }
            for bo_id in &self.bo_id {
                if *bo_id != 0 {
                    gl.delete_buffers(1, bo_id);
                }
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }
        }
    }
}

impl SpecialState<'_> {
    /// `CaptureSpecialInterleaved::check` of one buffer: the first and third vec4 slot hold the expected values.
    fn check_buffer(&self, bo_id: GLuint, expected: [f32; 8]) -> Result<bool, TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, bo_id)
        );

        // SAFETY: a read-only mapping of the bound transform feedback buffer.
        let results = unsafe {
            gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                SPECIAL_BO_SIZE as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        };
        crate::glu::expect_no_error(gl, "glMapBufferRange call failed.")?;

        if results.is_null() {
            return internal_error();
        }

        // SAFETY: the mapping is `SPECIAL_BO_SIZE` bytes long and stays valid until the unmap below.
        let values = unsafe { std::slice::from_raw_parts(results.cast::<f32>(), 12) };
        let is_ok = values[0..4] == expected[0..4] && values[8..12] == expected[4..8];

        gl_call!(
            gl,
            "glUnmapBuffer call failed.",
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
        );
        Ok(is_ok)
    }
}

/// `CaptureSpecialInterleaved`
pub(super) struct CaptureSpecialInterleaved;

impl TestCase for CaptureSpecialInterleaved {
    fn name(&self) -> &str {
        "capture_special_interleaved_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let is_at_least_gl_40 = context.context_type().supports_core(4, 0);
        let is_arb_tf_3 = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback3");
        let mut is_ok = true;

        if is_at_least_gl_40 || is_arb_tf_3 {
            let mut state = SpecialState {
                context,
                program_id: 0,
                vao_id: 0,
                xfb_id: 0,
                bo_id: [0; SPECIAL_BO_IDS_COUNT],
            };

            let sources = Sources {
                vertex: Some(SPECIAL_VERTEX_SHADER),
                fragment: Some(SPECIAL_FRAGMENT_SHADER),
                ..Sources::default()
            };
            state.program_id = build_program(gl, &sources, &SPECIAL_XFB_VARYINGS, glw::GL_INTERLEAVED_ATTRIBS);
            if state.program_id == 0 {
                return internal_error();
            }

            gl_call!(gl, "glUseProgram call failed.", gl.use_program(state.program_id));
            gl_call!(
                gl,
                "glGenTransformFeedbacks call failed.",
                gl.gen_transform_feedbacks(1, &mut state.xfb_id)
            );
            gl_call!(
                gl,
                "glBindTransformFeedbacks call failed.",
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, state.xfb_id)
            );
            gl_call!(
                gl,
                "glGenVertexArrays call failed.",
                gl.gen_vertex_arrays(1, &mut state.vao_id)
            );
            gl_call!(gl, "glBindVertexArray call failed.", gl.bind_vertex_array(state.vao_id));
            gl_call!(
                gl,
                "glGenBuffers call failed.",
                gl.gen_buffers(SPECIAL_BO_IDS_COUNT as GLsizei, state.bo_id.as_mut_ptr())
            );

            for i in 0..SPECIAL_BO_IDS_COUNT {
                gl_call!(
                    gl,
                    "glBindBuffer call failed.",
                    gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id[i])
                );
                gl_call!(
                    gl,
                    "glBufferData call failed.",
                    gl.buffer_data(
                        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                        SPECIAL_BO_SIZE as GLsizeiptr,
                        std::ptr::null(),
                        glw::GL_DYNAMIC_COPY
                    )
                );
                gl_call!(
                    gl,
                    "glBindBufferRange call failed.",
                    gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, i as GLuint, state.bo_id[i])
                );
            }

            gl_call!(gl, "glEnable call failed.", gl.enable(glw::GL_RASTERIZER_DISCARD));
            gl_call!(
                gl,
                "glBeginTransformFeedback call failed.",
                gl.begin_transform_feedback(glw::GL_POINTS)
            );
            gl_call!(gl, "glDrawArrays call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
            gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());
            gl_call!(gl, "glDisable call failed.", gl.disable(glw::GL_RASTERIZER_DISCARD));

            if !state.check_buffer(state.bo_id[0], [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])? {
                is_ok = false;
            }
            if !state.check_buffer(state.bo_id[1], [9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])? {
                is_ok = false;
            }
        }

        if is_ok {
            log::info!("Capture Special Interleaved have passed.");
        } else {
            log::info!("Capture Special Interleaved have failed.");
        }

        verdict(is_ok)
    }
}

const STREAM_VERTEX_SHADER_BLANK: &str = "#version 130\n\nvoid main()\n{\n}\n";
const STREAM_VERTEX_SHADER_PASS: &str =
    "#version 130\n\nin vec4 position;\n\nvoid main()\n{\n    gl_Position = position;\n}\n";
const STREAM_GEOMETRY_SHADER: &str = "#version 400\n\nlayout(points) in;\nlayout(points, max_vertices = 6) out;\n\nlayout(stream = 1) out vec4 position;\n\nvoid main()\n{\n    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n    EmitStreamVertex(0);\n    gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);\n    EmitStreamVertex(0);\n    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n    EmitStreamVertex(0);\n\n    position = vec4( 1.0, -1.0, 0.0, 1.0);\n    EmitStreamVertex(1);\n    position = vec4(-1.0,  1.0, 0.0, 1.0);\n    EmitStreamVertex(1);\n    position = vec4( 1.0,  1.0, 0.0, 1.0);\n    EmitStreamVertex(1);\n}\n";
const STREAM_FRAGMENT_SHADER: &str = "#version 130\n\nout vec4 pixel;\n\nvoid main()\n{\n    pixel = vec4(1.0);\n}\n";
const STREAM_XFB_VARYINGS: [&str; 3] = ["gl_Position", "gl_NextBuffer", "position"];
const STREAM_BO_IDS_COUNT: usize = 2;
const STREAM_QO_IDS_COUNT: usize = 4;
const STREAM_BO_SIZE: usize = 3 * 4 * std::mem::size_of::<f32>();
const STREAM_VIEW_SIZE: GLsizei = 2;

/// The objects of `DrawXFBStream`; its `clean` is the `Drop`.
struct StreamState<'a> {
    context: &'a Context,
    program_id_generate: GLuint,
    program_id_draw: GLuint,
    vao_id: GLuint,
    xfb_id: GLuint,
    bo_id: [GLuint; STREAM_BO_IDS_COUNT],
    fbo_id: GLuint,
    rbo_id: GLuint,
    qo_id: [GLuint; STREAM_QO_IDS_COUNT],
}

impl Drop for StreamState<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            gl.use_program(0);

            if self.program_id_generate != 0 {
                gl.delete_program(self.program_id_generate);
            }
            if self.program_id_draw != 0 {
                let position = CString::new("position").expect("names have no NUL");
                let position_location = gl.get_attrib_location(self.program_id_draw, position.as_ptr()) as GLuint;
                gl.disable_vertex_attrib_array(position_location);
                gl.delete_program(self.program_id_draw);
            }
            if self.xfb_id != 0 {
                gl.delete_transform_feedbacks(1, &self.xfb_id);
            }
            for bo_id in &self.bo_id {
                if *bo_id != 0 {
                    gl.delete_buffers(1, bo_id);
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

impl StreamState<'_> {
    /// `DrawXFBStream::prepareObjects`
    fn prepare_objects(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        let sources = Sources {
            geometry: Some(STREAM_GEOMETRY_SHADER),
            vertex: Some(STREAM_VERTEX_SHADER_BLANK),
            fragment: Some(STREAM_FRAGMENT_SHADER),
            ..Sources::default()
        };
        self.program_id_generate = build_program(gl, &sources, &STREAM_XFB_VARYINGS, glw::GL_INTERLEAVED_ATTRIBS);
        if self.program_id_generate == 0 {
            return internal_error();
        }

        let sources = Sources {
            vertex: Some(STREAM_VERTEX_SHADER_PASS),
            fragment: Some(STREAM_FRAGMENT_SHADER),
            ..Sources::default()
        };
        self.program_id_draw = build_program(gl, &sources, &[], glw::GL_INTERLEAVED_ATTRIBS);
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
        gl_call!(
            gl,
            "glGenBuffers call failed.",
            gl.gen_buffers(STREAM_BO_IDS_COUNT as GLsizei, self.bo_id.as_mut_ptr())
        );

        for i in 0..STREAM_BO_IDS_COUNT {
            gl_call!(
                gl,
                "glBindBuffer call failed.",
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.bo_id[i])
            );
            gl_call!(
                gl,
                "glBufferData call failed.",
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    STREAM_BO_SIZE as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_COPY
                )
            );
            gl_call!(
                gl,
                "glBindBufferRange call failed.",
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, i as GLuint, self.bo_id[i])
            );
        }

        gl_call!(
            gl,
            "glGenQueries call failed.",
            gl.gen_queries(STREAM_QO_IDS_COUNT as GLsizei, self.qo_id.as_mut_ptr())
        );
        gl_call!(gl, "glClearColor call failed.", gl.clear_color(0.0, 0.0, 0.0, 1.0));
        gl_call!(
            gl,
            "glGenFramebuffers call failed.",
            gl.gen_framebuffers(1, &mut self.fbo_id)
        );
        gl_call!(
            gl,
            "glGenRenderbuffers call failed.",
            gl.gen_renderbuffers(1, &mut self.rbo_id)
        );
        gl_call!(
            gl,
            "glBindFramebuffer call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo_id)
        );
        gl_call!(
            gl,
            "glBindRenderbuffer call failed.",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, self.rbo_id)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage call failed.",
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R8, STREAM_VIEW_SIZE, STREAM_VIEW_SIZE)
        );
        gl_call!(
            gl,
            "glFramebufferRenderbuffer call failed.",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                self.rbo_id
            )
        );

        // SAFETY: plain state query.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return internal_error();
        }

        gl_call!(
            gl,
            "glViewport call failed.",
            gl.viewport(0, 0, STREAM_VIEW_SIZE, STREAM_VIEW_SIZE)
        );
        Ok(())
    }

    /// `DrawXFBStream::setupVertexArray`
    fn setup_vertex_array(&self, bo_id: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo_id)
        );

        let position = CString::new("position").expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let position_location = unsafe { gl.get_attrib_location(self.program_id_draw, position.as_ptr()) } as GLuint;
        crate::glu::expect_no_error(gl, "glGetAttribLocation call failed.")?;

        gl_call!(
            gl,
            "glVertexAttribPointer call failed.",
            gl.vertex_attrib_pointer(
                position_location,
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
            gl.enable_vertex_attrib_array(position_location)
        );
        Ok(())
    }

    /// `DrawXFBStream::drawForXFB`
    fn draw_for_xfb(&self) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(gl, "glEnable call failed.", gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );
        gl_call!(
            gl,
            "glBeginQueryIndexed call failed.",
            gl.begin_query_indexed(glw::GL_PRIMITIVES_GENERATED, 0, self.qo_id[0])
        );
        gl_call!(
            gl,
            "glBeginQueryIndexed call failed.",
            gl.begin_query_indexed(glw::GL_PRIMITIVES_GENERATED, 1, self.qo_id[1])
        );
        gl_call!(
            gl,
            "glBeginQueryIndexed call failed.",
            gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0, self.qo_id[2])
        );
        gl_call!(
            gl,
            "glBeginQueryIndexed call failed.",
            gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 1, self.qo_id[3])
        );
        gl_call!(gl, "glDrawArrays call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
        gl_call!(
            gl,
            "glEndQueryIndexed call failed.",
            gl.end_query_indexed(glw::GL_PRIMITIVES_GENERATED, 0)
        );
        gl_call!(
            gl,
            "glEndQueryIndexed call failed.",
            gl.end_query_indexed(glw::GL_PRIMITIVES_GENERATED, 1)
        );
        gl_call!(
            gl,
            "glEndQueryIndexed call failed.",
            gl.end_query_indexed(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0)
        );
        gl_call!(
            gl,
            "glEndQueryIndexed call failed.",
            gl.end_query_indexed(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 1)
        );
        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());
        gl_call!(gl, "glDisable call failed.", gl.disable(glw::GL_RASTERIZER_DISCARD));
        Ok(())
    }

    /// `DrawXFBStream::drawForFramebuffer`
    fn draw_for_framebuffer(&self, stream: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "glDrawTransformFeedbackStream call failed.",
            gl.draw_transform_feedback_stream(glw::GL_TRIANGLES, self.xfb_id, stream)
        );
        Ok(())
    }

    /// `DrawXFBStream::inspectQueries`
    fn inspect_queries(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut results = [0 as GLint; STREAM_QO_IDS_COUNT];

        for (result, query) in results.iter_mut().zip(self.qo_id) {
            gl_call!(
                gl,
                "glGetQueryIndexediv call failed.",
                gl.get_query_objectiv(query, glw::GL_QUERY_RESULT, result)
            );
        }

        Ok(results == [3, 3, 3, 3])
    }

    /// `DrawXFBStream::check`
    fn check(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut pixels = vec![0.0f32; (STREAM_VIEW_SIZE * STREAM_VIEW_SIZE) as usize];

        gl_call!(
            gl,
            "glReadPixels call failed.",
            gl.read_pixels(
                0,
                0,
                STREAM_VIEW_SIZE,
                STREAM_VIEW_SIZE,
                glw::GL_RED,
                glw::GL_FLOAT,
                pixels.as_mut_ptr().cast()
            )
        );
        Ok(pixels.iter().all(|pixel| (pixel - 1.0).abs() <= 0.0625))
    }
}

/// `DrawXFBStream`
pub(super) struct DrawXfbStream;

impl TestCase for DrawXfbStream {
    fn name(&self) -> &str {
        "draw_xfb_stream_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let is_at_least_gl_40 = context.context_type().supports_core(4, 0);
        let is_arb_tf_3 = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback3");
        let is_arb_gpu_shader5 = context.context_info.is_extension_supported("GL_ARB_gpu_shader5");
        let mut is_ok = true;

        if is_at_least_gl_40 || (is_arb_tf_3 && is_arb_gpu_shader5) {
            let mut max_vertex_streams: GLint = 0;
            gl_call!(
                gl,
                "glGetIntegerv call failed.",
                gl.get_integerv(glw::GL_MAX_VERTEX_STREAMS, &mut max_vertex_streams)
            );

            if max_vertex_streams >= 2 {
                let mut state = StreamState {
                    context,
                    program_id_generate: 0,
                    program_id_draw: 0,
                    vao_id: 0,
                    xfb_id: 0,
                    bo_id: [0; STREAM_BO_IDS_COUNT],
                    fbo_id: 0,
                    rbo_id: 0,
                    qo_id: [0; STREAM_QO_IDS_COUNT],
                };

                state.prepare_objects()?;

                gl_call!(
                    gl,
                    "glUseProgram call failed.",
                    gl.use_program(state.program_id_generate)
                );
                state.draw_for_xfb()?;
                is_ok = is_ok && state.inspect_queries()?;

                gl_call!(gl, "glUseProgram call failed.", gl.use_program(state.program_id_draw));
                state.setup_vertex_array(state.bo_id[0])?;
                state.draw_for_framebuffer(0)?;
                state.setup_vertex_array(state.bo_id[1])?;
                state.draw_for_framebuffer(1)?;
                is_ok = is_ok && state.check()?;
            }
        }

        if is_ok {
            log::info!("Draw XFB Stream have passed.");
        } else {
            log::info!("Draw XFB Stream have failed.");
        }

        verdict(is_ok)
    }
}

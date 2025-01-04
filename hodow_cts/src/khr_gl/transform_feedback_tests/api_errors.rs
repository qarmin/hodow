// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedbackTests.cpp  (APIErrors)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. glw has none of the EXT entry points (`glBindBufferOffsetEXT`, `glGetIntegerIndexedvEXT`, `glGetBooleanIndexedvEXT`), so the checks upstream guards with their presence are never run, as when the proc lookup returns null. `clean` is the `Drop` of `State`.

use std::ffi::CString;

use super::{Sources, build_program, build_program_with, internal_error, itoa, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLchar, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome};

const TESSELLATION_CONTROL_SHADER: &str = "#version 400\n\nlayout (vertices = 2 ) out;\n\nvoid main()\n{\n    gl_TessLevelOuter[1]                = 3.0;\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n}\n";
const TESSELLATION_EVALUATION_SHADER: &str = "#version 400\n\nlayout(isolines, equal_spacing, ccw) in;\n\nout float result;\n\nvoid main()\n{\n    result      = 0.5;\n    gl_Position = gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position;\n}\n";
const GEOMETRY_SHADER: &str = "#version 150\n\nlayout(points) in;\nlayout(points, max_vertices = 2) out;\n\nout float result;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.0, 0.0, 0.0);\n    result = 0.0;\n    EmitVertex();\n\n    gl_Position = gl_in[0].gl_Position + vec4(1.0, 0.0, 0.0, 0.0);\n    result = 1.0;\n    EmitVertex();\n}\n";
const VERTEX_SHADER_WITH_OUTPUT: &str = "#version 130\n\nout float result;\n\nvoid main()\n{\n    result      = float(gl_VertexID);\n    gl_Position = vec4(1.0);\n}\n";
const VERTEX_SHADER_WITH_INPUT_OUTPUT: &str = "#version 130\n\nin float v_input;\n\nout float result;\n\nvoid main()\n{\n    result      = float(gl_VertexID);\n    gl_Position = vec4(v_input);\n}\n";
const VERTEX_SHADER_WITHOUT_OUTPUT: &str = "#version 130\n\nvoid main()\n{\n    gl_Position = vec4(1.0);\n}\n";
const FRAGMENT_SHADER: &str = "#version 130\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(1.0);\n}\n";
const VARYING_NAME: &str = "result";
const BUFFER_1_DATA: [f32; 2] = [3.141_592_7, 2.7182818];

/// The objects of `APIErrors`; its `clean` is the `Drop`.
struct State<'a> {
    context: &'a Context,
    buffer_0: GLuint,
    buffer_1: GLuint,
    vertex_array_object: GLuint,
    transform_feedback_object_0: GLuint,
    transform_feedback_object_1: GLuint,
    query_object: GLuint,
    program_id_with_input_output: GLuint,
    program_id_with_output: GLuint,
    program_id_without_output: GLuint,
    program_id_with_geometry_shader: GLuint,
    program_id_with_tessellation_shaders: GLuint,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            if self.vertex_array_object != 0 {
                gl.delete_vertex_arrays(1, &self.vertex_array_object);
            }
            for buffer in [self.buffer_0, self.buffer_1] {
                if buffer != 0 {
                    gl.delete_buffers(1, &buffer);
                }
            }
            for object in [self.transform_feedback_object_0, self.transform_feedback_object_1] {
                if object != 0 {
                    gl.delete_transform_feedbacks(1, &object);
                }
            }
            if self.query_object != 0 {
                gl.delete_queries(1, &self.query_object);
            }
            for program in [
                self.program_id_with_input_output,
                self.program_id_with_output,
                self.program_id_without_output,
                self.program_id_with_geometry_shader,
                self.program_id_with_tessellation_shaders,
            ] {
                if program != 0 {
                    gl.delete_program(program);
                }
            }
        }
    }
}

/// `glGetError` compared with `expected`; the message is logged when it differs.
fn expect_error(gl: &glw::Functions, expected: GLenum, message: &str) -> bool {
    // SAFETY: glGetError needs nothing but a current context.
    let error = unsafe { gl.get_error() };

    if error != expected {
        log::info!("{message}");
        return false;
    }

    true
}

/// `glEndTransformFeedback` without a check, as upstream calls it on the failure paths.
fn end_transform_feedback(gl: &glw::Functions) {
    // SAFETY: plain state call.
    unsafe { gl.end_transform_feedback() };
}

/// The smallest name no program, shader or (with `is_used`) object uses, as upstream's `unsigned short` search finds it.
fn unused_name(is_used: impl Fn(GLuint) -> bool) -> Result<GLuint, TestError> {
    let mut invalid_name: u16 = 1;

    while is_used(invalid_name as GLuint) {
        invalid_name += 1;

        if invalid_name == u16::MAX {
            log::info!("Cannot find unused trnasform feedback object.");
            return internal_error();
        }
    }

    Ok(invalid_name as GLuint)
}

impl State<'_> {
    /// `APIErrors::testExtension1`
    fn test_extension_1(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut index_count: GLint = 0;

        gl_call!(
            gl,
            "glGetIntegerv call failed.",
            gl.get_integerv(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS, &mut index_count)
        );
        if index_count == 0 {
            log::info!("glGetIntegerv did not returned any value.");
            return internal_error();
        }

        let index = index_count as GLuint;

        // SAFETY: the calls below only provoke the errors they check for.
        unsafe { gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, index, self.buffer_0, 0, 16) };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by BindBufferRange when <index> was greater or equal to MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS.",
        ) {
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, index, self.buffer_0) };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by BindBufferBase when <index> was greater or equal to MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS.",
        ) {
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, index, self.buffer_0, 0, 0) };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by BindBufferRange when <size> was less or equal to zero.",
        ) {
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, index, self.buffer_0, 3, 4) };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by BindBufferRange when <offset> was not word-aligned.",
        ) {
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, index, self.buffer_0, 0, 3) };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by BindBufferRange when <size> was not word-aligned.",
        ) {
            return Ok(false);
        }

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_with_output)
        );
        gl_call!(
            gl,
            "glBindBufferBase call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
        );
        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        // SAFETY: as above.
        unsafe { gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0, 0, 16) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by BindBufferRange when <target> was TRANSFORM_FEEDBACK_BUFFER and transform feedback was active.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by BindBufferBase when <target> was TRANSFORM_FEEDBACK_BUFFER and transform feedback was active.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());

        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        // SAFETY: as above.
        unsafe { gl.use_program(0) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by UseProgram when transform feedback was active.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_with_output)
        );
        gl_call!(
            gl,
            "glBindBufferBase call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
        );
        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        // SAFETY: as above.
        unsafe { gl.link_program(self.program_id_with_output) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by LinkProgram when <program> was currently active and transform feedback was active.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_with_output)
        );
        gl_call!(
            gl,
            "glBindBufferBase call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
        );
        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        // SAFETY: as above.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by BeginTransformFeedback when transform feedback was active.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());

        // SAFETY: as above.
        unsafe { gl.end_transform_feedback() };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by EndTransformFeedback when transform feedback was inactive.",
        ) {
            return Ok(false);
        }

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_with_output)
        );
        gl_call!(
            gl,
            "glBindBufferBase call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
        );
        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_LINES, 0, 2) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by draw command when generated primitives type does not match <primitiveMode>.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_with_output)
        );
        gl_call!(
            gl,
            "glBindBufferBase call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0)
        );

        // SAFETY: as above.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by BeginTransformFeedback when any binding point used by XFB does not have buffer bound.",
        ) {
            return Ok(false);
        }

        gl_call!(gl, "glUseProgram call failed.", gl.use_program(0));
        gl_call!(
            gl,
            "glBindBufferBase call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
        );

        // SAFETY: as above.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by BeginTransformFeedback when no program was active.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_without_output)
        );
        gl_call!(
            gl,
            "glBindBufferBase call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
        );

        // SAFETY: as above.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by BeginTransformFeedback when no variable are specified to be captured in the active program.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        // SAFETY: plain state queries.
        let invalid_name = unsafe { unused_name(|name| gl.is_program(name) != 0 || gl.is_shader(name) != 0)? };
        let varying_name = CString::new(VARYING_NAME).expect("names have no NUL");
        let varying_ptr = varying_name.as_ptr();

        // SAFETY: one name pointer is given.
        unsafe { gl.transform_feedback_varyings(invalid_name, 1, &varying_ptr, glw::GL_INTERLEAVED_ATTRIBS) };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by TransformFeedbackVaryings when <program> was not id of the program object.",
        ) {
            return Ok(false);
        }

        let mut max_separate_attribs: GLint = 0;
        gl_call!(
            gl,
            "glGetIntegerv call failed.",
            gl.get_integerv(
                glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
                &mut max_separate_attribs
            )
        );
        if max_separate_attribs == 0 {
            log::info!(
                "INVALID_VALUE was not generated by TransformFeedbackVaryings when <bufferMode> was SEPARATE_ATTRIBS and <count> was exceeds limits."
            );
            return internal_error();
        }

        let more_than_max_separate_attribs = max_separate_attribs + 1;
        let attribs: Vec<CString> = (0..more_than_max_separate_attribs)
            .map(|i| CString::new(format!("a{}", itoa(i))).expect("names have no NUL"))
            .collect();
        let attrib_pointers: Vec<*const GLchar> = attribs.iter().map(|attrib| attrib.as_ptr()).collect();

        // SAFETY: `more_than_max_separate_attribs` name pointers are given.
        unsafe {
            gl.transform_feedback_varyings(
                self.program_id_with_output,
                more_than_max_separate_attribs as GLsizei,
                attrib_pointers.as_ptr(),
                glw::GL_SEPARATE_ATTRIBS,
            )
        };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by TransformFeedbackVaryings when <bufferMode> was SEPARATE_ATTRIBS and <count> exceeded limits.",
        ) {
            return Ok(false);
        }

        let mut transform_feedback_varyings: GLint = 0;
        gl_call!(
            gl,
            "glGetProgramiv call failed.",
            gl.get_programiv(
                self.program_id_with_output,
                glw::GL_TRANSFORM_FEEDBACK_VARYINGS,
                &mut transform_feedback_varyings
            )
        );
        if transform_feedback_varyings == 0 {
            log::info!("glGetProgramiv failed to return GL_TRANSFORM_FEEDBACK_VARYINGS.");
            return internal_error();
        }

        let mut tmp_buffer = [0 as GLchar; 256];
        let mut tmp_size: GLsizei = 0;
        let mut tmp_type: GLenum = glw::GL_NONE;

        // SAFETY: a buffer of 256 characters is given.
        unsafe {
            gl.get_transform_feedback_varying(
                self.program_id_with_output,
                transform_feedback_varyings as GLuint,
                256,
                std::ptr::null_mut(),
                &mut tmp_size,
                &mut tmp_type,
                tmp_buffer.as_mut_ptr(),
            )
        };
        Ok(expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by GetTransformFeedbackVarying when <index> was greater than or equal to TRANSFORM_FEEDBACK_VARYINGS.",
        ))
    }

    /// `APIErrors::testExtension2`
    fn test_extension_2(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glBindTransformFeedback call failed.",
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.transform_feedback_object_0)
        );

        // SAFETY: the calls below only provoke the errors they check for.
        unsafe { gl.pause_transform_feedback() };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION is not generated by PauseTransformFeedback if current transform feedback is not active or paused.",
        ) {
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.resume_transform_feedback() };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION is not generated by ResumeTransformFeedback if current transform feedback is not active.",
        ) {
            return Ok(false);
        }

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_with_output)
        );
        gl_call!(
            gl,
            "glBindBufferBase call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
        );

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback(glw::GL_POINTS, self.transform_feedback_object_0) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION is not generated by DrawTransformFeedback when EndTransformFeedback was never called for the object named <id>.",
        ) {
            return Ok(false);
        }

        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );

        // SAFETY: as above.
        unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.transform_feedback_object_0) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION is not generated by BindTransformFeedback if current transform feedback is active and not paused.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.delete_transform_feedbacks(1, &self.transform_feedback_object_0) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION is not generated by DeleteTransformFeedbacks if any of <ids> is active.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.resume_transform_feedback() };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION is not generated by ResumeTransformFeedback if current transform feedback is not not paused.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(
            gl,
            "glPauseTransformFeedback call failed.",
            gl.pause_transform_feedback()
        );

        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_LINES, 0, 2) };
        if !expect_error(
            gl,
            glw::GL_NO_ERROR,
            "No error is not generated by draw command when transform feedback is paused and primitive modes do not match.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.link_program(self.program_id_with_output) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by LinkProgram when <program> was used by some transform feedback object that is currently not active.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.use_program(0) };
        if !expect_error(
            gl,
            glw::GL_NO_ERROR,
            "glUseProgram unexpectedly failed when transform feedback is paused.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_with_output)
        );
        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());

        // SAFETY: plain state queries.
        let invalid_name = unsafe { unused_name(|name| gl.is_transform_feedback(name) != 0)? };

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback(glw::GL_POINTS, invalid_name) };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "glUseProgram unexpectedly failed when transform feedback is paused.",
        ) {
            end_transform_feedback(gl);
            return Ok(false);
        }

        Ok(true)
    }

    /// `APIErrors::testExtension3`
    fn test_extension_3(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut max_vertex_streams: GLint = 0;

        gl_call!(
            gl,
            "glGetIntegerv call failed.",
            gl.get_integerv(glw::GL_MAX_VERTEX_STREAMS, &mut max_vertex_streams)
        );
        if max_vertex_streams == 0 {
            return internal_error();
        }

        max_vertex_streams += 1;
        let stream = max_vertex_streams as GLuint;

        let targets = [
            (
                glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
                "GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN",
            ),
            (glw::GL_PRIMITIVES_GENERATED, "GL_PRIMITIVES_GENERATED"),
        ];

        for (target, target_str) in targets {
            // SAFETY: the calls below only provoke the errors they check for.
            unsafe { gl.begin_query_indexed(target, stream, self.query_object) };
            if !expect_error(
                gl,
                glw::GL_INVALID_VALUE,
                &format!(
                    "INVALID_VALUE was not generated by BeginQueryIndexed, EndQueryIndexed andGetQueryIndexediv when <target> was {target_str} and <index> exceeded limits of MAX_VERTEX_STREAMS."
                ),
            ) {
                return Ok(false);
            }

            // SAFETY: as above.
            unsafe { gl.end_query_indexed(target, stream) };
            if !expect_error(
                gl,
                glw::GL_INVALID_VALUE,
                &format!(
                    "INVALID_VALUE was not generated by EndQueryIndexed when <target> was {target_str} and <index> exceeded limits of MAX_VERTEX_STREAMS."
                ),
            ) {
                return Ok(false);
            }

            let mut param: GLint = 0;
            // SAFETY: one integer of output is given.
            unsafe { gl.get_query_indexediv(target, stream, glw::GL_QUERY_COUNTER_BITS, &mut param) };
            if !expect_error(
                gl,
                glw::GL_INVALID_VALUE,
                &format!(
                    "INVALID_VALUE was not generated by GetQueryIndexediv when <target> was {target_str} and <index> exceeded limits of MAX_VERTEX_STREAMS."
                ),
            ) {
                return Ok(false);
            }
        }

        // SAFETY: as above.
        unsafe { gl.end_query_indexed(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by EndQueryIndexed when name of active query at <index> of <target> is zero",
        ) {
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback_stream(glw::GL_POINTS, self.transform_feedback_object_0, stream) };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by DrawTransformFeedbackStream when <stream> exceeded limits of MAX_VERTEX_STREAMS",
        ) {
            return Ok(false);
        }

        let tf_varying_names = [
            "gl_NextBuffer",
            "gl_SkipComponents1",
            "gl_SkipComponents2",
            "gl_SkipComponents3",
            "gl_SkipComponents4",
        ];

        for name in tf_varying_names {
            let name = CString::new(name).expect("names have no NUL");
            let name_ptr = name.as_ptr();

            // SAFETY: one name pointer is given.
            unsafe {
                gl.transform_feedback_varyings(self.program_id_with_output, 1, &name_ptr, glw::GL_SEPARATE_ATTRIBS)
            };
            if !expect_error(
                gl,
                glw::GL_INVALID_OPERATION,
                "INVALID_OPERATION was not generated by TransformFeedbackVaryings when <varyings> contained any of the special names while <bufferMode> was GL_SEPARATE_ATTRIBS.",
            ) {
                return Ok(false);
            }
        }

        let mut max_transform_feedback_buffers: GLint = 0;
        gl_call!(
            gl,
            "glGetIntegerv call failed.",
            gl.get_integerv(
                glw::GL_MAX_TRANSFORM_FEEDBACK_BUFFERS,
                &mut max_transform_feedback_buffers
            )
        );
        if max_transform_feedback_buffers == 0 {
            return internal_error();
        }

        let more_than_max_transform_feedback_buffers = max_transform_feedback_buffers + 1;
        let next_buffer = CString::new("gl_NextBuffer").expect("names have no NUL");
        let next_buffer_names: Vec<*const GLchar> =
            vec![next_buffer.as_ptr(); more_than_max_transform_feedback_buffers as usize];

        // SAFETY: `more_than_max_transform_feedback_buffers` name pointers are given.
        unsafe {
            gl.transform_feedback_varyings(
                self.program_id_with_output,
                more_than_max_transform_feedback_buffers as GLsizei,
                next_buffer_names.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS,
            )
        };
        Ok(expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by TransformFeedbackVaryings when <varyings> contained more \"gl_NextBuffer\" entries than allowed limit of MAX_TRANSFORM_FEEDBACK_BUFFER.",
        ))
    }

    /// `APIErrors::testInstanced`
    fn test_instanced(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let is_at_least_gl_40 = self.context.context_type().supports_core(4, 0);
        let is_tessellation = self
            .context
            .context_info
            .is_extension_supported("GL_ARB_tessellation_shader");
        let is_compatibility = self.context.context_info.is_extension_supported("GL_ARB_compatibility");
        let has_patches = is_at_least_gl_40 || is_tessellation;

        let mut supported_modes = vec![
            glw::GL_POINTS,
            glw::GL_LINE_STRIP,
            glw::GL_LINE_LOOP,
            glw::GL_LINES,
            glw::GL_LINE_STRIP_ADJACENCY,
            glw::GL_LINES_ADJACENCY,
            glw::GL_TRIANGLE_STRIP,
            glw::GL_TRIANGLE_FAN,
            glw::GL_TRIANGLES,
            glw::GL_TRIANGLE_STRIP_ADJACENCY,
            glw::GL_TRIANGLES_ADJACENCY,
            glw::GL_QUADS,
        ];

        if has_patches {
            supported_modes.push(glw::GL_PATCHES);
        }

        if is_compatibility {
            supported_modes.push(0x0008);
            supported_modes.push(0x0009);
        }

        let mut mode: GLenum = 0;
        while supported_modes.contains(&mode) {
            mode += 1;
        }

        // SAFETY: the calls below only provoke the errors they check for.
        unsafe { gl.draw_transform_feedback_instanced(mode, self.transform_feedback_object_0, 1) };
        if !expect_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM was not generated by DrawTransformFeedbackInstanced and DrawTransformFeedbackStreamInstanced when <mode> was invalid.",
        ) {
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback_stream_instanced(mode, self.transform_feedback_object_0, 0, 1) };
        if !expect_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM was not generated by DrawTransformFeedbackInstanced and DrawTransformFeedbackStreamInstanced when <mode> was invalid.",
        ) {
            return Ok(false);
        }

        if self.program_id_with_geometry_shader != 0 {
            gl_call!(
                gl,
                "glBindTransformFeedback call failed.",
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.transform_feedback_object_0)
            );
            gl_call!(
                gl,
                "glUseProgram call failed.",
                gl.use_program(self.program_id_with_geometry_shader)
            );
            gl_call!(
                gl,
                "glBindVertexArray call failed.",
                gl.bind_vertex_array(self.vertex_array_object)
            );
            gl_call!(
                gl,
                "glBindBuffer call failed.",
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
            );
            gl_call!(
                gl,
                "glBeginTransformFeedback call failed.",
                gl.begin_transform_feedback(glw::GL_POINTS)
            );
            gl_call!(gl, "glDrawArrays call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
            gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());

            // SAFETY: as above.
            unsafe { gl.draw_transform_feedback_instanced(glw::GL_LINES, self.transform_feedback_object_0, 1) };
            if !expect_error(
                gl,
                glw::GL_INVALID_OPERATION,
                "INVALID_OPERATION was not generated by DrawTransformFeedbackInstanced and DrawTransformFeedbackStreamInstanced if <mode> did not match geometry shader.",
            ) {
                return Ok(false);
            }

            // SAFETY: as above.
            unsafe {
                gl.draw_transform_feedback_stream_instanced(glw::GL_LINES, self.transform_feedback_object_0, 0, 1)
            };
            if !expect_error(
                gl,
                glw::GL_INVALID_OPERATION,
                "INVALID_OPERATION was not generated by DrawTransformFeedbackInstanced and DrawTransformFeedbackStreamInstanced if <mode> did not match geometry shader.",
            ) {
                return Ok(false);
            }
        }

        if self.program_id_with_tessellation_shaders == 0 {
            return Ok(true);
        }

        gl_call!(
            gl,
            "glBindTransformFeedback call failed.",
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.transform_feedback_object_0)
        );
        gl_call!(
            gl,
            "glUseProgram call failed.",
            gl.use_program(self.program_id_with_tessellation_shaders)
        );
        gl_call!(
            gl,
            "glBindVertexArray call failed.",
            gl.bind_vertex_array(self.vertex_array_object)
        );
        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer_0)
        );
        gl_call!(
            gl,
            "glBeginTransformFeedback call failed.",
            gl.begin_transform_feedback(glw::GL_LINES)
        );
        gl_call!(gl, "glDrawArrays call failed.", gl.draw_arrays(glw::GL_PATCHES, 0, 2));
        gl_call!(gl, "glEndTransformFeedback call failed.", gl.end_transform_feedback());

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback_instanced(glw::GL_POINTS, self.transform_feedback_object_0, 1) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by DrawTransformFeedbackInstanced and DrawTransformFeedbackStreamInstanced if <mode> did not match geometry shader.",
        ) {
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback_stream_instanced(glw::GL_POINTS, self.transform_feedback_object_0, 0, 1) };
        if !expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by DrawTransformFeedbackInstanced and DrawTransformFeedbackStreamInstanced if <mode> did not match geometry shader.",
        ) {
            return Ok(false);
        }

        let mut max_vertex_streams: GLint = 0;
        gl_call!(
            gl,
            "glGetIntegerv call failed.",
            gl.get_integerv(glw::GL_MAX_VERTEX_STREAMS, &mut max_vertex_streams)
        );
        if max_vertex_streams == 0 {
            return internal_error();
        }

        let more_than_max_vertex_streams = (max_vertex_streams + 1) as GLuint;

        // SAFETY: as above.
        unsafe {
            gl.draw_transform_feedback_stream_instanced(
                glw::GL_PATCHES,
                self.transform_feedback_object_0,
                more_than_max_vertex_streams,
                1,
            )
        };
        if !expect_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_OPERATION was not generated by DrawTransformFeedbackInstanced and DrawTransformFeedbackStreamInstanced if <mode> did not match geometry shader.",
        ) {
            return Ok(false);
        }

        // SAFETY: plain state queries.
        let invalid_name = unsafe { unused_name(|name| gl.is_transform_feedback(name) != 0)? };

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback_instanced(glw::GL_PATCHES, invalid_name, 1) };
        if !expect_error(gl, glw::GL_INVALID_VALUE, "") {
            end_transform_feedback(gl);
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback_stream_instanced(glw::GL_PATCHES, invalid_name, 0, 1) };
        if !expect_error(gl, glw::GL_INVALID_VALUE, "") {
            end_transform_feedback(gl);
            return Ok(false);
        }

        gl_call!(
            gl,
            "glBindTransformFeedback call failed.",
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.transform_feedback_object_1)
        );

        // SAFETY: as above.
        unsafe { gl.draw_transform_feedback_stream_instanced(glw::GL_PATCHES, self.transform_feedback_object_1, 0, 1) };
        Ok(expect_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by DrawTransformFeedbackInstanced and DrawTransformFeedbackStreamInstanced if <mode> did not match geometry shader.",
        ))
    }
}

/// `APIErrors`
pub(super) struct ApiErrors;

impl TestCase for ApiErrors {
    fn name(&self) -> &str {
        "api_errors_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let context_type = context.context_type();
        let is_at_least_gl_30 = context_type.supports_core(3, 0);
        let is_at_least_gl_33 = context_type.supports_core(3, 3);
        let is_at_least_gl_40 = context_type.supports_core(4, 0);
        let is_at_least_gl_42 = context_type.supports_core(4, 2);
        let is_ext_tf_1 = context.context_info.is_extension_supported("GL_EXT_transform_feedback");
        let is_arb_tf_2 = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback2");
        let is_arb_tf_3 = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback3");
        let is_arb_tf_instanced = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback_instanced");

        let mut state = State {
            context,
            buffer_0: 0,
            buffer_1: 0,
            vertex_array_object: 0,
            transform_feedback_object_0: 0,
            transform_feedback_object_1: 0,
            query_object: 0,
            program_id_with_input_output: 0,
            program_id_with_output: 0,
            program_id_without_output: 0,
            program_id_with_geometry_shader: 0,
            program_id_with_tessellation_shaders: 0,
        };

        if is_at_least_gl_40 || is_arb_tf_2 {
            gl_call!(
                gl,
                "glGenTransformFeedbacks call failed.",
                gl.gen_transform_feedbacks(1, &mut state.transform_feedback_object_0)
            );
        }
        if is_at_least_gl_40 || is_arb_tf_3 {
            gl_call!(
                gl,
                "glGenQueries call failed.",
                gl.gen_queries(1, &mut state.query_object)
            );
        }
        if is_at_least_gl_42 || is_arb_tf_instanced {
            gl_call!(
                gl,
                "glGenTransformFeedbacks call failed.",
                gl.gen_transform_feedbacks(1, &mut state.transform_feedback_object_1)
            );
        }

        let mut is_ok = true;

        gl_call!(
            gl,
            "glGenVertexArrays call failed.",
            gl.gen_vertex_arrays(1, &mut state.vertex_array_object)
        );
        gl_call!(
            gl,
            "glBindVertexArray call failed.",
            gl.bind_vertex_array(state.vertex_array_object)
        );
        gl_call!(gl, "glGenBuffers call failed.", gl.gen_buffers(1, &mut state.buffer_0));
        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.buffer_0)
        );
        gl_call!(
            gl,
            "glBufferData call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                16,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );
        gl_call!(gl, "glGenBuffers call failed.", gl.gen_buffers(1, &mut state.buffer_1));
        gl_call!(
            gl,
            "glBindBuffer call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, state.buffer_1)
        );
        gl_call!(
            gl,
            "glBufferData call failed.",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&BUFFER_1_DATA) as glw::GLsizeiptr,
                BUFFER_1_DATA.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        let sources = Sources {
            vertex: Some(VERTEX_SHADER_WITH_INPUT_OUTPUT),
            fragment: Some(FRAGMENT_SHADER),
            ..Sources::default()
        };
        state.program_id_with_input_output = build_program(gl, &sources, &[VARYING_NAME], glw::GL_INTERLEAVED_ATTRIBS);

        let sources = Sources {
            vertex: Some(VERTEX_SHADER_WITH_OUTPUT),
            fragment: Some(FRAGMENT_SHADER),
            ..Sources::default()
        };
        state.program_id_with_output =
            build_program_with(gl, &sources, &[VARYING_NAME], glw::GL_INTERLEAVED_ATTRIBS, true, None);

        let sources = Sources {
            vertex: Some(VERTEX_SHADER_WITHOUT_OUTPUT),
            fragment: Some(FRAGMENT_SHADER),
            ..Sources::default()
        };
        state.program_id_without_output = build_program(gl, &sources, &[], glw::GL_SEPARATE_ATTRIBS);

        is_ok = is_ok
            && state.program_id_with_input_output != 0
            && state.program_id_with_output != 0
            && state.program_id_without_output != 0;

        if is_at_least_gl_33 {
            let sources = Sources {
                geometry: Some(GEOMETRY_SHADER),
                vertex: Some(VERTEX_SHADER_WITHOUT_OUTPUT),
                fragment: Some(FRAGMENT_SHADER),
                ..Sources::default()
            };
            state.program_id_with_geometry_shader =
                build_program(gl, &sources, &[VARYING_NAME], glw::GL_INTERLEAVED_ATTRIBS);
            is_ok = is_ok && state.program_id_with_geometry_shader != 0;
        }

        if is_at_least_gl_40 {
            let sources = Sources {
                tess_control: Some(TESSELLATION_CONTROL_SHADER),
                tess_evaluation: Some(TESSELLATION_EVALUATION_SHADER),
                vertex: Some(VERTEX_SHADER_WITHOUT_OUTPUT),
                fragment: Some(FRAGMENT_SHADER),
                ..Sources::default()
            };
            state.program_id_with_tessellation_shaders =
                build_program(gl, &sources, &[VARYING_NAME], glw::GL_INTERLEAVED_ATTRIBS);
            is_ok = is_ok && state.program_id_with_tessellation_shaders != 0;
        }

        if is_at_least_gl_30 || is_ext_tf_1 {
            is_ok = is_ok && state.test_extension_1()?;
        }
        if is_at_least_gl_40 || is_arb_tf_2 {
            is_ok = is_ok && state.test_extension_2()?;
        }
        if is_at_least_gl_40 || is_arb_tf_3 {
            is_ok = is_ok && state.test_extension_3()?;
        }
        if is_at_least_gl_42 || is_arb_tf_instanced {
            is_ok = is_ok && state.test_instanced()?;
        }

        verdict(is_ok)
    }
}

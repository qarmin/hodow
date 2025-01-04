// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedbackTests.cpp  (Limits, LinkingErrors)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{Sources, build_program, build_program_with, internal_error, itoa, preprocess_code, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint};
use crate::tcu::{TestError, TestOutcome};

const MIN_VALUE_OF_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS: GLint = 64;
const MIN_VALUE_OF_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS: GLint = 4;
const MIN_VALUE_OF_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS: GLint = 4;
const MIN_VALUE_OF_MAX_TRANSFORM_FEEDBACK_BUFFERS: GLint = 4;
const MIN_VALUE_OF_MAX_VERTEX_STREAMS: GLint = 1;

/// `Limits`
pub(super) struct Limits;

impl Limits {
    /// One of the `Limits::test_*` functions: the integer limit must reach `minimum`.
    fn test_limit(context: &Context, pname: GLenum, name: &str, minimum: GLint) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut value: GLint = 0;
        gl_call!(gl, "glGetIntegerv call failed.", gl.get_integerv(pname, &mut value));

        if value < minimum {
            log::info!("{name} is equal to {value} which is less than expected {minimum}.");
            return Ok(false);
        }

        Ok(true)
    }
}

impl TestCase for Limits {
    fn name(&self) -> &str {
        "limits_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let context_type = context.context_type();
        let is_at_least_gl_30 = context_type.supports_core(3, 0);
        let is_at_least_gl_40 = context_type.supports_core(4, 0);
        let is_ext_tf_1 = context.context_info.is_extension_supported("GL_EXT_transform_feedback");
        let is_arb_tf_3 = context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback3");

        let mut is_ok = true;

        if is_at_least_gl_30 || is_ext_tf_1 {
            is_ok = is_ok
                && Self::test_limit(
                    context,
                    glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
                    "GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS",
                    MIN_VALUE_OF_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
                )?;
            is_ok = is_ok
                && Self::test_limit(
                    context,
                    glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
                    "GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS",
                    MIN_VALUE_OF_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
                )?;
            is_ok = is_ok
                && Self::test_limit(
                    context,
                    glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
                    "GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS",
                    MIN_VALUE_OF_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
                )?;
        }

        if is_at_least_gl_40 || is_arb_tf_3 {
            is_ok = is_ok
                && Self::test_limit(
                    context,
                    glw::GL_MAX_TRANSFORM_FEEDBACK_BUFFERS,
                    "MAX_TRANSFORM_FEEDBACK_BUFFERS",
                    MIN_VALUE_OF_MAX_TRANSFORM_FEEDBACK_BUFFERS,
                )?;
            is_ok = is_ok
                && Self::test_limit(
                    context,
                    glw::GL_MAX_VERTEX_STREAMS,
                    "MAX_VERTEX_STREAMS",
                    MIN_VALUE_OF_MAX_VERTEX_STREAMS,
                )?;
        }

        if is_ok {
            log::info!("Limits are in range of specification.");
        }

        verdict(is_ok)
    }
}

const LINKING_FS: &str = "#version 130\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(1.0);\n}\n";
const LINKING_VS_TEMPLATE: &str = "#version 130\n\nTEMPLATE_INPUT_OUTPUT_DECLARATIONS\nvoid main()\n{\nTEMPLATE_OUTPUT_SETTERS\n    gl_Position = vec4(1.618033988749);\n}\n";
const VALID_TRANSFORM_FEEDBACK_VARYING: &str = "result";
const INVALID_TRANSFORM_FEEDBACK_VARYING: &str = "data";
const REPEATED_TRANSFORM_FEEDBACK_VARYING: [&str; 2] = ["result", "result"];

/// `LinkingErrors`
pub(super) struct LinkingErrors;

impl LinkingErrors {
    /// `LinkingErrors::testNoVertexNoGeometry`
    fn test_no_vertex_no_geometry(context: &Context) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut linking_status: GLint = 1;
        let sources = Sources {
            fragment: Some(LINKING_FS),
            ..Sources::default()
        };
        let program = build_program_with(
            gl,
            &sources,
            &[VALID_TRANSFORM_FEEDBACK_VARYING],
            glw::GL_INTERLEAVED_ATTRIBS,
            false,
            Some(&mut linking_status),
        );

        if linking_status != glw::GL_FALSE as GLint || program != 0 {
            log::info!(
                "Linking unexpectedly succeded when Transform Feedback varying was specified but program had neither vertex nor geometry shader stages."
            );
            delete_program(context, program);
            return Ok(false);
        }

        log::info!(
            "Linking failed as expected when Transform Feedback varying was specified but program had neither vertex nor geometry shader stages."
        );
        Ok(true)
    }

    /// `LinkingErrors::testInvalidVarying`
    fn test_invalid_varying(context: &Context) -> Result<bool, TestError> {
        let gl = context.gl();
        let vertex_shader = preprocess_code(
            LINKING_VS_TEMPLATE,
            "TEMPLATE_INPUT_OUTPUT_DECLARATIONS",
            "in float data;\n",
        );
        let vertex_shader = preprocess_code(&vertex_shader, "TEMPLATE_OUTPUT_SETTERS", "");

        let mut linking_status: GLint = 1;
        let sources = Sources {
            vertex: Some(&vertex_shader),
            fragment: Some(LINKING_FS),
            ..Sources::default()
        };
        let program = build_program_with(
            gl,
            &sources,
            &[INVALID_TRANSFORM_FEEDBACK_VARYING],
            glw::GL_INTERLEAVED_ATTRIBS,
            false,
            Some(&mut linking_status),
        );

        if linking_status != glw::GL_FALSE as GLint || program != 0 {
            log::info!(
                "Linking unexpectedly succeded when Transform Feedback varying was specified with name of variable ({INVALID_TRANSFORM_FEEDBACK_VARYING}) that is not available for capture."
            );
            delete_program(context, program);
            return Ok(false);
        }

        log::info!(
            "Linking failed as expected when Transform Feedback varying was specified with name of variable ({INVALID_TRANSFORM_FEEDBACK_VARYING}) that is not available for capture."
        );
        Ok(true)
    }

    /// `LinkingErrors::testRepeatedVarying`
    fn test_repeated_varying(context: &Context) -> Result<bool, TestError> {
        let gl = context.gl();
        let vertex_shader = preprocess_code(
            LINKING_VS_TEMPLATE,
            "TEMPLATE_INPUT_OUTPUT_DECLARATIONS",
            "out float result;\n",
        );
        let vertex_shader = preprocess_code(
            &vertex_shader,
            "TEMPLATE_OUTPUT_SETTERS",
            "    result = 0.577215664901532;\n",
        );

        let mut linking_status: GLint = 1;
        let sources = Sources {
            vertex: Some(&vertex_shader),
            fragment: Some(LINKING_FS),
            ..Sources::default()
        };
        let program = build_program_with(
            gl,
            &sources,
            &REPEATED_TRANSFORM_FEEDBACK_VARYING,
            glw::GL_INTERLEAVED_ATTRIBS,
            false,
            Some(&mut linking_status),
        );

        if linking_status != glw::GL_FALSE as GLint || program != 0 {
            log::info!("Linking unexpectedly succeded when Transform Feedback varying was specified twice.");
            delete_program(context, program);
            return Ok(false);
        }

        log::info!("Linking failed as expected when Transform Feedback varying was specified twice.");
        Ok(true)
    }

    /// `LinkingErrors::testTooManyVaryings`
    fn test_too_many_varyings(context: &Context) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut max_transform_feedback_separate_components: GLint = 0;
        let mut max_transform_feedback_interleaved_components: GLint = 0;

        gl_call!(
            gl,
            "glGetIntegerv call failed.",
            gl.get_integerv(
                glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
                &mut max_transform_feedback_separate_components
            )
        );
        if max_transform_feedback_separate_components == 0 {
            return internal_error();
        }

        gl_call!(
            gl,
            "glGetIntegerv call failed.",
            gl.get_integerv(
                glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
                &mut max_transform_feedback_interleaved_components
            )
        );
        if max_transform_feedback_interleaved_components == 0 {
            return internal_error();
        }

        let more_than_max_transform_feedback_components =
            max_transform_feedback_separate_components.max(max_transform_feedback_interleaved_components) + 1;

        let mut declarations = String::new();
        let mut setters = String::new();
        let mut varyings: Vec<String> = Vec::new();

        for i in 0..more_than_max_transform_feedback_components {
            let varying = format!("result_{}", itoa(i));

            declarations.push_str(&format!("out float {varying};\n"));
            setters.push_str(&format!("    {varying} = {}.0;\n", itoa(i * i)));
            varyings.push(varying);
        }

        let vertex_shader = preprocess_code(LINKING_VS_TEMPLATE, "TEMPLATE_INPUT_OUTPUT_DECLARATIONS", &declarations);
        let vertex_shader = preprocess_code(&vertex_shader, "TEMPLATE_OUTPUT_SETTERS", &setters);
        let varying_refs: Vec<&str> = varyings.iter().map(String::as_str).collect();
        let sources = Sources {
            vertex: Some(&vertex_shader),
            fragment: Some(LINKING_FS),
            ..Sources::default()
        };

        let program = build_program(gl, &sources, &varying_refs, glw::GL_INTERLEAVED_ATTRIBS);
        if program != 0 {
            log::info!(
                "Linking unexpectedly succeded when too many Transform Feedback varying were specified in INTERLEAVED mode."
            );
            delete_program(context, program);
            return Ok(false);
        }

        let program = build_program(gl, &sources, &varying_refs, glw::GL_SEPARATE_ATTRIBS);
        if program != 0 {
            log::info!(
                "Linking unexpectedly succeded when too many Transform Feedback varyings were specified in SEPARATE mode."
            );
            delete_program(context, program);
            return Ok(false);
        }

        log::info!("Linking failed as expected when too many Transform Feedback varyings were specified.");
        Ok(true)
    }
}

/// `glDeleteProgram` of a name that may be 0.
fn delete_program(context: &Context, program: glw::GLuint) {
    if program != 0 {
        // SAFETY: the program was created by the caller and is deleted once.
        unsafe { context.gl().delete_program(program) };
    }
}

impl TestCase for LinkingErrors {
    fn name(&self) -> &str {
        "linking_errors_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut is_ok = true;

        is_ok = is_ok && Self::test_no_vertex_no_geometry(context)?;
        is_ok = is_ok && Self::test_invalid_varying(context)?;
        is_ok = is_ok && Self::test_repeated_varying(context)?;
        is_ok = is_ok && Self::test_too_many_varyings(context)?;

        verdict(is_ok)
    }
}

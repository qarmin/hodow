// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fProgramPipelineStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `glu::ProgramSources` has no
// `ProgramSeparable` flag, so a separable single-stage program is built by the
// file-local `SeparableProgram` below rather than through `glu::ShaderProgram`.
// `verifyInfoLogQuery` (glsStateQueryUtil) is not ported either, so the info-log
// read-back is inlined in the same shape the ES 3.1 `shader` file uses.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, ProgramPipeline, ShaderType, TestCaseGroup, add_api_case};
use crate::glw::{self, GLchar, GLenum, GLint, GLsizei, GLuint};

use super::query_util::{QueryType, verify_state_pipeline_integer};

/// The only verifier this group has - note it is *not* `QueryType::suffix`'s
/// "getinteger": upstream's own `getVerifierSuffix` here spells it out in full.
const VERIFIER_SUFFIX: &str = "get_program_pipelineiv";

const S_VERTEX_SOURCE: &str = "#version 310 es\n\
    out highp vec4 v_color;\n\
    void main()\n\
    {\n\
    	gl_Position = vec4(float(gl_VertexID) * 0.5, float(gl_VertexID+1) * 0.5, 0.0, 1.0);\n\
    	v_color = vec4(float(gl_VertexID), 1.0, 0.0, 1.0);\n\
    }\n";

const S_FRAGMENT_SOURCE: &str = "#version 310 es\n\
    in highp vec4 v_color;\n\
    layout(location=0) out highp vec4 o_color;\n\
    void main()\n\
    {\n\
    	o_color = v_color;\n\
    }\n";

const S_COMPUTE_SOURCE: &str = "#version 310 es\n\
    layout (local_size_x = 1, local_size_y = 1) in;\n\
    layout(binding = 0) buffer Output\n\
    {\n\
    	highp float val;\n\
    } sb_out;\n\
    \n\
    void main (void)\n\
    {\n\
    	sb_out.val = 1.0;\n\
    }\n";

/// `glu::ProgramSources() << glu::ProgramSeparable(true) << glu::XxxSource(...)` -
/// one shader stage, linked with `GL_PROGRAM_SEPARABLE` set.
struct SeparableProgram<'gl> {
    gl: &'gl glw::Functions,
    program: GLuint,
    shader: GLuint,
    ok: bool,
}

impl<'gl> SeparableProgram<'gl> {
    fn new(gl: &'gl glw::Functions, shader_type: ShaderType, source: &str) -> Self {
        // SAFETY: every handle below is one this function just created, and the source
        // pointer/length pair describes a live borrow that outlives the call.
        unsafe {
            let program = gl.create_program();
            let shader = gl.create_shader(shader_type.gl_enum());

            let bytes = source.as_bytes();
            let pointer = bytes.as_ptr().cast::<GLchar>();
            let length = bytes.len() as GLint;
            gl.shader_source(shader, 1, &raw const pointer, &raw const length);
            gl.compile_shader(shader);

            let mut status: GLint = 0;
            gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &raw mut status);
            let compiled = status == GLint::from(glw::TRUE);

            let mut ok = false;
            if compiled {
                gl.attach_shader(program, shader);
                gl.program_parameteri(program, glw::GL_PROGRAM_SEPARABLE, GLint::from(glw::TRUE));
                gl.link_program(program);
                let mut link_status: GLint = 0;
                gl.get_programiv(program, glw::GL_LINK_STATUS, &raw mut link_status);
                ok = link_status == GLint::from(glw::TRUE);
            }

            Self { gl, program, shader, ok }
        }
    }

    fn is_ok(&self) -> bool {
        self.ok
    }

    fn program(&self) -> GLuint {
        self.program
    }
}

impl Drop for SeparableProgram<'_> {
    fn drop(&mut self) {
        // SAFETY: both handles are this struct's own and are deleted exactly once.
        unsafe {
            self.gl.delete_shader(self.shader);
            self.gl.delete_program(self.program);
        }
    }
}

/// `ActiveProgramCase::iterate`
fn active_program_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let vtx_program = SeparableProgram::new(case.gl(), ShaderType::Vertex, S_VERTEX_SOURCE);
    let frg_program = SeparableProgram::new(case.gl(), ShaderType::Fragment, S_FRAGMENT_SOURCE);
    let pipeline = ProgramPipeline::new(case.gl());

    if !vtx_program.is_ok() || !frg_program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    // SAFETY: the pipeline and both programs are this case's own.
    unsafe {
        case.gl().bind_program_pipeline(pipeline.get());
        case.gl().use_program_stages(pipeline.get(), glw::GL_VERTEX_SHADER_BIT, vtx_program.program());
        case.gl().use_program_stages(pipeline.get(), glw::GL_FRAGMENT_SHADER_BIT, frg_program.program());
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: unbinding is always valid.
    unsafe { case.gl().bind_program_pipeline(0) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("Initial");
    verify_state_pipeline_integer(case, pipeline.get(), glw::GL_ACTIVE_PROGRAM, 0, verifier);

    case.section("Set");
    // SAFETY: both names are this case's own.
    unsafe { case.gl().active_shader_program(pipeline.get(), frg_program.program()) };
    case.expect_error(glw::GL_NO_ERROR);
    #[expect(clippy::cast_possible_wrap, reason = "a GL object name always fits in a GLint")]
    let expected = frg_program.program() as GLint;
    verify_state_pipeline_integer(case, pipeline.get(), glw::GL_ACTIVE_PROGRAM, expected, verifier);
}

/// `PipelineProgramCase::iterate`
fn pipeline_program_case(case: &mut ApiCase<'_>, verifier: QueryType, target_stage: GLenum) {
    let (stage_bit, shader_type, source) = match target_stage {
        glw::GL_VERTEX_SHADER => (glw::GL_VERTEX_SHADER_BIT, ShaderType::Vertex, S_VERTEX_SOURCE),
        glw::GL_FRAGMENT_SHADER => (glw::GL_FRAGMENT_SHADER_BIT, ShaderType::Fragment, S_FRAGMENT_SOURCE),
        _ => (glw::GL_COMPUTE_SHADER_BIT, ShaderType::Compute, S_COMPUTE_SOURCE),
    };

    let program = SeparableProgram::new(case.gl(), shader_type, source);
    if !program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    {
        case.section("Initial");
        let pipeline = ProgramPipeline::new(case.gl());
        // SAFETY: the pipeline is this scope's own.
        unsafe { case.gl().bind_program_pipeline(pipeline.get()) };
        case.expect_error(glw::GL_NO_ERROR);

        verify_state_pipeline_integer(case, pipeline.get(), target_stage, 0, verifier);
    }

    {
        case.section("Set");
        let pipeline = ProgramPipeline::new(case.gl());
        // SAFETY: the pipeline and the program are both live here.
        unsafe {
            case.gl().bind_program_pipeline(pipeline.get());
            case.gl().use_program_stages(pipeline.get(), stage_bit, program.program());
        }
        case.expect_error(glw::GL_NO_ERROR);

        #[expect(clippy::cast_possible_wrap, reason = "a GL object name always fits in a GLint")]
        let expected = program.program() as GLint;
        verify_state_pipeline_integer(case, pipeline.get(), target_stage, expected, verifier);
    }
}

/// `ValidateStatusCase::iterate`
fn validate_status_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let vtx_program = SeparableProgram::new(case.gl(), ShaderType::Vertex, S_VERTEX_SOURCE);
    let frg_program = SeparableProgram::new(case.gl(), ShaderType::Fragment, S_FRAGMENT_SOURCE);
    let pipeline = ProgramPipeline::new(case.gl());

    if !vtx_program.is_ok() || !frg_program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    // SAFETY: the pipeline and both programs are this case's own.
    unsafe {
        case.gl().bind_program_pipeline(pipeline.get());
        case.gl().use_program_stages(pipeline.get(), glw::GL_VERTEX_SHADER_BIT, vtx_program.program());
        case.gl().use_program_stages(pipeline.get(), glw::GL_FRAGMENT_SHADER_BIT, frg_program.program());
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: unbinding is always valid.
    unsafe { case.gl().bind_program_pipeline(0) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("Initial");
    verify_state_pipeline_integer(case, pipeline.get(), glw::GL_VALIDATE_STATUS, 0, verifier);

    case.section("Validate");
    // SAFETY: the pipeline is this case's own.
    unsafe { case.gl().validate_program_pipeline(pipeline.get()) };
    case.expect_error(glw::GL_NO_ERROR);
    verify_state_pipeline_integer(case, pipeline.get(), glw::GL_VALIDATE_STATUS, GLint::from(glw::TRUE), verifier);
}

/// The buffer `verifyInfoLogQuery` reads the log back into.
const LOG_BUF_SIZE: usize = 2048;

/// `InfoLogCase::iterate`
fn info_log_case(case: &mut ApiCase<'_>) {
    const S_INCOMPATIBLE_FRAGMENT_SOURCE: &str = "#version 310 es\n\
        in mediump vec2 v_colorB;\n\
        in mediump vec2 v_colorC;\n\
        layout(location=0) out highp vec4 o_color;\n\
        void main()\n\
        {\n\
        	o_color = v_colorB.xxyy + v_colorC.yyxy;\n\
        }\n";

    let vtx_program = SeparableProgram::new(case.gl(), ShaderType::Vertex, S_VERTEX_SOURCE);
    let frg_program = SeparableProgram::new(case.gl(), ShaderType::Fragment, S_INCOMPATIBLE_FRAGMENT_SOURCE);

    if !vtx_program.is_ok() || !frg_program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    {
        case.section("Initial");
        let pipeline = ProgramPipeline::new(case.gl());
        let mut buf = [b'X' as GLchar; 3];
        let mut written: GLsizei = -1;

        verify_state_pipeline_integer(case, pipeline.get(), glw::GL_INFO_LOG_LENGTH, 0, QueryType::PipelineInteger);

        // SAFETY: bufSize 2 is within the 3-byte buffer, deliberately - the third byte
        // is the guard upstream checks was left alone.
        unsafe {
            case.gl()
                .get_program_pipeline_info_log(pipeline.get(), 2, &raw mut written, buf.as_mut_ptr())
        };
        case.expect_error(glw::GL_NO_ERROR);

        if written == -1 {
            case.fail("'length' was not written to".to_string(), "'length' was not written to");
        } else if written != 0 {
            case.fail("'length' was not 0".to_string(), "'length' was not 0");
        } else if buf[0] != 0 {
            case.fail(
                "log was not 0-sized null-terminated string".to_string(),
                "log was not 0-sized null-terminated string",
            );
        } else if buf[1] != b'X' as GLchar || buf[2] != b'X' as GLchar {
            case.fail(
                "buffer after returned length modified".to_string(),
                "buffer after returned length modified",
            );
        }
    }

    {
        case.section("Failed validation");
        let pipeline = ProgramPipeline::new(case.gl());
        let mut log_len = Guarded::<GLint>::new();

        // SAFETY: the pipeline and both programs are this scope's own.
        unsafe {
            case.gl().bind_program_pipeline(pipeline.get());
            case.gl().use_program_stages(pipeline.get(), glw::GL_VERTEX_SHADER_BIT, vtx_program.program());
            case.gl().use_program_stages(pipeline.get(), glw::GL_FRAGMENT_SHADER_BIT, frg_program.program());
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: unbinding is always valid; the pipeline is then validated by name.
        unsafe {
            case.gl().bind_program_pipeline(0);
            case.gl().validate_program_pipeline(pipeline.get());
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: one GLint out, guarded on both sides.
        unsafe {
            case.gl()
                .get_program_pipelineiv(pipeline.get(), glw::GL_INFO_LOG_LENGTH, log_len.as_mut_ptr())
        };
        case.expect_error(glw::GL_NO_ERROR);

        if log_len.verify_validity(case) {
            let mut buffer = vec![0 as GLchar; LOG_BUF_SIZE];
            let mut written: GLsizei = 0;
            // SAFETY: bufSize is the buffer's own length.
            unsafe {
                case.gl().get_program_pipeline_info_log(
                    pipeline.get(),
                    LOG_BUF_SIZE as GLsizei,
                    &raw mut written,
                    buffer.as_mut_ptr(),
                )
            };
            case.expect_error(glw::GL_NO_ERROR);

            if log_len.value() > 0 && written != log_len.value() - 1 && LOG_BUF_SIZE as GLint > log_len.value() {
                case.fail(
                    format!("Expected {} (INFO_LOG_LENGTH - 1), got {written}", log_len.value() - 1),
                    "Got invalid log length",
                );
            }
        }
    }
}

/// `ProgramPipelineStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("program_pipeline");

    let verifier = QueryType::PipelineInteger;

    add_api_case(&mut group, &format!("active_program_{VERIFIER_SUFFIX}"), move |case: &mut ApiCase<'_>| {
        active_program_case(case, verifier);
    });
    add_api_case(&mut group, &format!("vertex_shader_{VERIFIER_SUFFIX}"), move |case: &mut ApiCase<'_>| {
        pipeline_program_case(case, verifier, glw::GL_VERTEX_SHADER);
    });
    add_api_case(&mut group, &format!("fragment_shader_{VERIFIER_SUFFIX}"), move |case: &mut ApiCase<'_>| {
        pipeline_program_case(case, verifier, glw::GL_FRAGMENT_SHADER);
    });
    add_api_case(&mut group, &format!("compute_shader_{VERIFIER_SUFFIX}"), move |case: &mut ApiCase<'_>| {
        pipeline_program_case(case, verifier, glw::GL_COMPUTE_SHADER);
    });
    add_api_case(&mut group, &format!("validate_status_{VERIFIER_SUFFIX}"), move |case: &mut ApiCase<'_>| {
        validate_status_case(case, verifier);
    });
    add_api_case(&mut group, "info_log", info_log_case);

    group
}

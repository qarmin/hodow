// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cSeparateShaderObjsTests.cpp  (PipelineApiCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{
    fail, generate_basic_fragment_src, generate_basic_vertex_src, get_error, get_program, get_program_pipeline,
};
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase};
use crate::glw::{self, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `PipelineApiCase`
pub(super) struct PipelineApiCase {
    pub(super) glsl_version: GlslVersion,
}

/// `glIsProgramPipeline`
fn is_program_pipeline(gl: &glw::Functions, pipeline: GLuint) -> bool {
    // SAFETY: plain query with a current context.
    unsafe { gl.is_program_pipeline(pipeline) != glw::FALSE }
}

/// `glGetIntegerv(GL_PROGRAM_PIPELINE_BINDING)`
fn program_pipeline_binding(gl: &glw::Functions) -> GLuint {
    let mut value: GLint = 0;
    // SAFETY: one integer of output is given.
    unsafe { gl.get_integerv(glw::GL_PROGRAM_PIPELINE_BINDING, &mut value) };
    value as GLuint
}

/// `PipelineApiCase::checkProgInfoLog`: validates glGetProgramPipelineInfoLog.
fn check_prog_info_log(gl: &glw::Functions, pipeline: GLuint) -> Result<(), TestError> {
    let mut value: GLint = 0;
    let mut length: GLsizei = 0;

    // SAFETY: one integer of output is given.
    unsafe { gl.get_program_pipelineiv(pipeline, glw::GL_INFO_LOG_LENGTH, &mut value) };

    let mut info_log_buf = vec![0u8; value.max(0) as usize + 1];

    let mut buf_size: GLsizei = 0;
    // SAFETY: the buffer holds INFO_LOG_LENGTH + 1 bytes, more than any buf_size passed below.
    unsafe { gl.get_program_pipeline_info_log(pipeline, buf_size, &mut length, info_log_buf.as_mut_ptr().cast()) };
    glu::expect_no_error(gl, "GetProgramPipelineInfoLog failed")?;

    buf_size = value / 2;
    // SAFETY: see above.
    unsafe { gl.get_program_pipeline_info_log(pipeline, buf_size, &mut length, info_log_buf.as_mut_ptr().cast()) };
    if buf_size != 0 && buf_size != length + 1 {
        return fail("GetProgramPipelineInfoLog failed");
    }

    buf_size = value;
    // SAFETY: see above.
    unsafe { gl.get_program_pipeline_info_log(pipeline, buf_size, &mut length, info_log_buf.as_mut_ptr().cast()) };
    if buf_size != 0 && buf_size != length + 1 {
        return fail("GetProgramPipelineInfoLog failed");
    }

    // SAFETY: see above; the pipeline name is bogus on purpose.
    unsafe {
        gl.get_program_pipeline_info_log(pipeline + 101, buf_size, &mut length, info_log_buf.as_mut_ptr().cast())
    };
    if get_error(gl) != glw::GL_INVALID_VALUE {
        return fail("GetProgramPipelineInfoLog failed");
    }

    Ok(())
}

impl TestCase for PipelineApiCase {
    fn name(&self) -> &str {
        "PipelineApi"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const MAX_PIPELINES: usize = 10;

        let gl = context.gl();
        let mut pipelines = [0 as GLuint; MAX_PIPELINES];

        let vtx = generate_basic_vertex_src(self.glsl_version);
        let frag = generate_basic_fragment_src(self.glsl_version);

        log::info!("Begin:PipelineApiCase iterate");

        let prog_vf = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vtx, frag));

        // Make separable and relink
        // SAFETY: plain state calls; every call below is made with a current context and pointers into live locals.
        unsafe {
            gl.program_parameteri(prog_vf.program(), glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint);
            gl.link_program(prog_vf.program());
        }
        if get_program(gl, prog_vf.program(), glw::GL_LINK_STATUS) != 1 {
            return fail("LinkProgram failed");
        }

        // SAFETY: plain state calls.
        unsafe {
            gl.gen_program_pipelines(1, pipelines.as_mut_ptr());

            // ActiveShaderProgram
            gl.active_shader_program(pipelines[0], prog_vf.program());
        }
        glu::expect_no_error(gl, "ActiveShaderProgram failed")?;

        // Negative cases for ActiveShaderProgram: nonexistent program
        // SAFETY: plain state call.
        unsafe { gl.active_shader_program(pipelines[0], prog_vf.program() + 100) };
        if get_error(gl) != glw::GL_INVALID_VALUE {
            return fail("ActiveShaderProgram failed");
        }

        let mut value = get_program_pipeline(gl, pipelines[0], glw::GL_ACTIVE_PROGRAM);
        if value != prog_vf.program() {
            return fail("ActiveShaderProgram failed");
        }

        // Deleted pipeline
        // SAFETY: plain state calls.
        unsafe {
            gl.delete_program_pipelines(1, pipelines.as_ptr());
            gl.active_shader_program(pipelines[0], prog_vf.program());
        }
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("ActiveShaderProgram failed");
        }

        // GenProgramPipeline
        // SAFETY: the offsets stay inside the 10-element array.
        unsafe {
            gl.gen_program_pipelines(2, pipelines.as_mut_ptr());
            gl.gen_program_pipelines(3, pipelines[2..].as_mut_ptr());
            gl.gen_program_pipelines(5, pipelines[5..].as_mut_ptr());
        }

        for pipeline in pipelines {
            // has to be bound to be recognized
            // SAFETY: plain state call.
            unsafe { gl.bind_program_pipeline(pipeline) };

            if !is_program_pipeline(gl, pipeline) {
                return fail("GenProgramPipelines failed");
            }
        }

        // SAFETY: plain state call over the whole array.
        unsafe { gl.delete_program_pipelines(MAX_PIPELINES as GLsizei, pipelines.as_ptr()) };

        // BindProgramPipeline
        // SAFETY: plain state calls.
        unsafe {
            gl.gen_program_pipelines(2, pipelines.as_mut_ptr());
            gl.bind_program_pipeline(pipelines[0]);
        }
        value = program_pipeline_binding(gl);
        if value != pipelines[0] {
            return fail("BindProgramPipeline failed");
        }

        // SAFETY: plain state call.
        unsafe { gl.bind_program_pipeline(pipelines[1]) };
        value = program_pipeline_binding(gl);
        if value != pipelines[1] {
            return fail("BindProgramPipeline failed");
        }

        glu::expect_no_error(gl, "BindProgramPipeline failed")?;

        // Negative Case for BindProgramPipeline: deleted pipeline
        // SAFETY: plain state call.
        unsafe { gl.bind_program_pipeline(pipelines[2]) };
        value = program_pipeline_binding(gl);
        if get_error(gl) != glw::GL_INVALID_OPERATION || value != pipelines[1] {
            return fail("BindProgramPipeline failed");
        }

        // DeleteProgramPipelines
        // SAFETY: the offsets stay inside the 10-element array.
        unsafe {
            // back to 10 total
            gl.gen_program_pipelines(8, pipelines[2..].as_mut_ptr());
            gl.delete_program_pipelines(2, pipelines[8..].as_ptr());
            gl.delete_program_pipelines(3, pipelines[5..].as_ptr());
        }
        pipelines[9] = 0;
        // SAFETY: plain state calls; 5 good, 4 deleted, 1 zero.
        unsafe {
            gl.delete_program_pipelines(MAX_PIPELINES as GLsizei, pipelines.as_ptr());
            gl.delete_program_pipelines(0, pipelines.as_ptr());
        }
        glu::expect_no_error(gl, "DeleteProgramPipelines failed")?;

        for pipeline in pipelines {
            if is_program_pipeline(gl, pipeline) {
                return fail("DeleteProgramPipelines failed");
            }
        }

        value = program_pipeline_binding(gl);
        if value != 0 {
            return fail("DeleteProgramPipelines failed");
        }

        // IsProgramPipeline
        pipelines[1] = 0x1000;
        pipelines[2] += 100;
        for pipeline in &pipelines[..3] {
            // 1 deleted and 2 bogus values
            if is_program_pipeline(gl, *pipeline) {
                return fail("IsProgramPipeline failed");
            }
        }

        // SAFETY: plain state calls.
        unsafe { gl.gen_program_pipelines(1, pipelines.as_mut_ptr()) };
        if is_program_pipeline(gl, pipelines[0]) {
            return fail("IsProgramPipeline failed");
        }

        // SAFETY: plain state call.
        unsafe { gl.delete_program_pipelines(1, pipelines.as_ptr()) };
        glu::expect_no_error(gl, "IsProgramPipeline failed")?;

        // ProgramParameteri PROGRAM_SEPARABLE
        // The query must return latched state, so the default GL_FALSE for a program with no linked binary.
        // SAFETY: plain object creation.
        let program_sep = unsafe { gl.create_program() };

        // SAFETY: plain state call.
        unsafe { gl.program_parameteri(program_sep, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint) };
        if get_program(gl, program_sep, glw::GL_PROGRAM_SEPARABLE) != glw::GL_FALSE as GLint {
            return fail("programParameteri PROGRAM_SEPARABLE failed");
        }

        // SAFETY: plain state call.
        unsafe { gl.program_parameteri(program_sep, glw::GL_PROGRAM_SEPARABLE, glw::GL_FALSE as GLint) };
        if get_program(gl, program_sep, glw::GL_PROGRAM_SEPARABLE) != 0 {
            return fail("programParameteri PROGRAM_SEPARABLE failed");
        }

        // Negative Case for ProgramParameteri PROGRAM_SEPARABLE
        // SAFETY: plain state calls.
        unsafe {
            gl.delete_program(program_sep);
            gl.program_parameteri(program_sep, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint);
        }
        if get_error(gl) != glw::GL_INVALID_VALUE {
            return fail("programParameteri PROGRAM_SEPARABLE failed");
        }

        // SAFETY: plain state call.
        unsafe { gl.program_parameteri(prog_vf.program(), glw::GL_PROGRAM_SEPARABLE, 501) };
        if get_error(gl) != glw::GL_INVALID_VALUE {
            return fail("programParameteri PROGRAM_SEPARABLE failed");
        }

        // GetProgramPipelineiv
        // SAFETY: plain state call.
        unsafe { gl.gen_program_pipelines(1, pipelines.as_mut_ptr()) };

        for (pname, message) in [
            (glw::GL_ACTIVE_PROGRAM, "GetProgramPipelineiv failed for ACTIVE_PROGRAM"),
            (glw::GL_VERTEX_SHADER, "GetProgramPipelineiv failed for VERTEX_SHADER"),
            (
                glw::GL_FRAGMENT_SHADER,
                "GetProgramPipelineiv failed for FRAGMENT_SHADER",
            ),
            (
                glw::GL_VALIDATE_STATUS,
                "GetProgramPipelineiv failed for VALIDATE_STATUS",
            ),
            (
                glw::GL_INFO_LOG_LENGTH,
                "GetProgramPipelineiv failed for INFO_LOG_LENGTH",
            ),
        ] {
            value = get_program_pipeline(gl, pipelines[0], pname);
            if value != 0 {
                return fail(message);
            }
        }

        glu::expect_no_error(gl, "GetProgramPipelineiv failed")?;

        // Negative Case for GetProgramPipelineiv
        // SAFETY: plain state call.
        unsafe { gl.delete_program_pipelines(1, pipelines.as_ptr()) };
        get_program_pipeline(gl, pipelines[0], glw::GL_ACTIVE_PROGRAM);
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("GetProgramPipelineiv failed for ACTIVE_PROGRAM");
        }

        // ValidateProgramPipeline: unvalidated
        // SAFETY: plain state call.
        unsafe { gl.gen_program_pipelines(1, pipelines.as_mut_ptr()) };
        value = get_program_pipeline(gl, pipelines[0], glw::GL_VALIDATE_STATUS);
        if value != 0 {
            return fail("ValidateProgramPipeline failed");
        }

        // Not bound yet
        // SAFETY: plain state call.
        unsafe { gl.validate_program_pipeline(pipelines[0]) };
        value = get_program_pipeline(gl, pipelines[0], glw::GL_VALIDATE_STATUS);
        if value != 0 {
            return fail("ValidateProgramPipeline failed");
        }

        // Still empty program pipeline.
        // SAFETY: plain state calls.
        unsafe {
            gl.bind_program_pipeline(pipelines[0]);
            gl.validate_program_pipeline(pipelines[0]);
        }
        value = get_program_pipeline(gl, pipelines[0], glw::GL_VALIDATE_STATUS);
        if value != 0 {
            return fail("ValidateProgramPipeline failed with empty program pipeline");
        }

        // SAFETY: plain state calls.
        unsafe {
            gl.use_program_stages(
                pipelines[0],
                glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT,
                prog_vf.program(),
            );
            gl.validate_program_pipeline(pipelines[0]);
        }
        value = get_program_pipeline(gl, pipelines[0], glw::GL_VALIDATE_STATUS);
        if value != 1 {
            return fail("ValidateProgramPipeline failed");
        }

        // GetProgramPipelineInfoLog
        check_prog_info_log(gl, pipelines[0])?;

        // ValidateProgramPipeline additional: relink the bound separable program as not separable
        // SAFETY: plain state calls.
        unsafe {
            gl.program_parameteri(prog_vf.program(), glw::GL_PROGRAM_SEPARABLE, glw::GL_FALSE as GLint);
            gl.link_program(prog_vf.program());
        }
        let _ = get_error(gl);
        // SAFETY: plain state call.
        unsafe { gl.validate_program_pipeline(pipelines[0]) };
        value = get_program_pipeline(gl, pipelines[0], glw::GL_VALIDATE_STATUS);
        if value != 0 {
            return fail("ValidateProgramPipeline failed");
        }

        glu::expect_no_error(gl, "ValidateProgramPipeline failed")?;

        // GetProgramPipelineInfoLog
        check_prog_info_log(gl, pipelines[0])?;

        // Negative Case for ValidateProgramPipeline
        // SAFETY: plain state calls.
        unsafe {
            gl.delete_program_pipelines(1, pipelines.as_ptr());
            gl.validate_program_pipeline(pipelines[0]);
        }
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("ValidateProgramPipeline failed");
        }

        Ok(TestStatus::pass("Pass"))
    }
}

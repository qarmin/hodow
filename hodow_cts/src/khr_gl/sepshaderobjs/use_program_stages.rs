// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cSeparateShaderObjsTests.cpp  (UseProgStagesCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{
    create_shader_programv, fail, generate_basic_fragment_src, generate_basic_vertex_src, get_error, get_program,
    get_program_pipeline,
};
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestOutcome, TestStatus};

/// `UseProgStagesCase`
pub(super) struct UseProgStagesCase {
    pub(super) glsl_version: GlslVersion,
}

impl TestCase for UseProgStagesCase {
    fn name(&self) -> &str {
        "UseProgStagesApi"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let vtx = generate_basic_vertex_src(self.glsl_version);
        let frag = generate_basic_fragment_src(self.glsl_version);

        log::info!("Begin:UseProgStagesCase iterate");

        let mut pipeline: GLuint = 0;
        // SAFETY: one name of output is given; every call below is made with a current context.
        unsafe {
            gl.gen_program_pipelines(1, &mut pipeline);
            gl.bind_program_pipeline(pipeline);
        }

        // Use Vertex Shader
        let program_vtx = create_shader_programv(gl, glw::GL_VERTEX_SHADER, 1, &[&vtx]);
        // SAFETY: plain state call.
        unsafe { gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_vtx) };

        let mut prog_id_v = get_program_pipeline(gl, pipeline, glw::GL_VERTEX_SHADER);
        let mut prog_id_f = get_program_pipeline(gl, pipeline, glw::GL_FRAGMENT_SHADER);

        if program_vtx == 0 || prog_id_v != program_vtx || prog_id_f != 0 {
            return fail("UseProgramStages failed");
        }

        glu::expect_no_error(gl, "UseProgramStages failed")?;

        // Use Fragment Shader
        let program_frag = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, 1, &[&frag]);
        // SAFETY: plain state call.
        unsafe { gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_frag) };

        prog_id_f = get_program_pipeline(gl, pipeline, glw::GL_FRAGMENT_SHADER);

        if program_frag == 0 || prog_id_f != program_frag || prog_id_f == prog_id_v {
            return fail("UseProgramStages failed");
        }

        // Reset stages
        // SAFETY: plain state call.
        unsafe { gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT, 0) };

        prog_id_v = get_program_pipeline(gl, pipeline, glw::GL_VERTEX_SHADER);
        prog_id_f = get_program_pipeline(gl, pipeline, glw::GL_FRAGMENT_SHADER);

        if prog_id_v != 0 || prog_id_f != 0 {
            return fail("UseProgramStages failed");
        }

        // One program for both.
        let prog_vf = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vtx.clone(), frag.clone()));

        // Make separable and relink
        // SAFETY: plain state calls.
        unsafe {
            gl.program_parameteri(prog_vf.program(), glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint);
            gl.link_program(prog_vf.program());
        }
        if get_program(gl, prog_vf.program(), glw::GL_LINK_STATUS) != 1 {
            return fail("UseProgramStages failed");
        }

        glu::expect_no_error(gl, "UseProgramStages failed")?;

        // SAFETY: plain state call.
        unsafe {
            gl.use_program_stages(
                pipeline,
                glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT,
                prog_vf.program(),
            )
        };

        prog_id_v = get_program_pipeline(gl, pipeline, glw::GL_VERTEX_SHADER);
        prog_id_f = get_program_pipeline(gl, pipeline, glw::GL_FRAGMENT_SHADER);

        if prog_id_v != prog_vf.program() || prog_id_v != prog_id_f {
            return fail("UseProgramStages failed");
        }

        glu::expect_no_error(gl, "UseProgramStages failed")?;

        // Use a fragment program with vertex bit
        // SAFETY: plain state calls.
        unsafe {
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT, 0);
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_frag);
        }

        glu::expect_no_error(gl, "UseProgramStages failed")?;

        // Unbound pipeline
        // SAFETY: plain state calls.
        unsafe {
            gl.bind_program_pipeline(0);
            gl.delete_program_pipelines(1, &pipeline);
        }
        pipeline = 0;
        // SAFETY: one name of output is given.
        unsafe {
            gl.gen_program_pipelines(1, &mut pipeline);
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_vtx);
            gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_frag);
        }

        prog_id_v = get_program_pipeline(gl, pipeline, glw::GL_VERTEX_SHADER);
        prog_id_f = get_program_pipeline(gl, pipeline, glw::GL_FRAGMENT_SHADER);

        if prog_id_v != program_vtx || prog_id_f != program_frag {
            return fail("UseProgramStages failed");
        }

        glu::expect_no_error(gl, "UseProgramStages failed")?;

        // Negative Cases

        // Invalid stages
        // SAFETY: plain state call.
        unsafe {
            gl.use_program_stages(
                pipeline,
                glw::GL_ALL_SHADER_BITS ^ (glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT),
                program_vtx,
            )
        };
        if get_error(gl) != glw::GL_INVALID_VALUE {
            return fail("UseProgramStages failed");
        }

        // Program that is not separable
        // SAFETY: plain state calls.
        unsafe {
            gl.program_parameteri(prog_vf.program(), glw::GL_PROGRAM_SEPARABLE, glw::GL_FALSE as GLint);
            gl.link_program(prog_vf.program());
        }
        if get_program(gl, prog_vf.program(), glw::GL_LINK_STATUS) != 1 {
            return fail("UseProgramStages failed");
        }

        glu::expect_no_error(gl, "UseProgramStages failed")?;

        // SAFETY: plain state call.
        unsafe {
            gl.use_program_stages(
                pipeline,
                glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT,
                prog_vf.program(),
            )
        };
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("UseProgramStages failed");
        }

        // Program that is not successfully linked; remove the main keyword
        let frag_no_main = frag.replacen("main", "niaM", 1);
        let prog_no_link =
            ShaderProgram::new_expecting_build_failure(gl, &ProgramSources::vtx_frag(vtx.clone(), frag_no_main));

        // SAFETY: plain state calls.
        unsafe {
            gl.program_parameteri(prog_no_link.program(), glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint);
            gl.link_program(prog_no_link.program());
            gl.use_program_stages(
                pipeline,
                glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT,
                prog_no_link.program(),
            );
        }
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("UseProgramStages failed");
        }

        // Invalid pipeline
        // SAFETY: plain state call.
        unsafe { gl.use_program_stages(pipeline + 1000, glw::GL_VERTEX_SHADER_BIT, program_vtx) };
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("UseProgramStages failed");
        }

        // Invalid pipeline
        // SAFETY: plain state calls.
        unsafe {
            gl.delete_program_pipelines(1, &pipeline);
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_vtx);
        }
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("UseProgramStages failed");
        }

        // SAFETY: plain object deletion.
        unsafe {
            gl.delete_program(program_vtx);
            gl.delete_program(program_frag);
        }

        Ok(TestStatus::pass("Pass"))
    }
}

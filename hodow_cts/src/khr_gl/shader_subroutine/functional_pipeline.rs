// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (FunctionalTest13)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `deinit` is the `Drop` of `State`.

use std::ffi::CString;

use super::{check_subroutine_support, fail, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome};

const TO_WIDTH: GLuint = 4;
const TO_HEIGHT: GLuint = 4;

/// The `n_id` of `FunctionalTest13::get*ShaderBody`, printed the way `std::stringstream << float` does for the values these shaders use.
fn fragment_shader_body(n_id: u32) -> String {
    let n = n_id as f32;
    format!(
        "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void SubroutineFSType(inout vec4 result);\n\nsubroutine(SubroutineFSType) void SubroutineFS1(inout vec4 result)\n{{\n    result += vec4({}, {}, {}, {});\n}}\nsubroutine(SubroutineFSType) void SubroutineFS2(inout vec4 result)\n{{\n    result += vec4({}, {}, {}, {});\n}}\n\nsubroutine uniform SubroutineFSType function;\n\nin GS_DATA\n{{\n    vec4 data;\n}} in_gs;\n\nout vec4 result;\nvoid main()\n{{\n    vec4 data = in_gs.data;\n    function(data);\n\n    result = data;\n}}\n",
        (n + 1.0) / 10.0,
        (n + 2.0) / 10.0,
        (n + 3.0) / 10.0,
        (n + 4.0) / 10.0,
        (n + 1.0) / 20.0,
        (n + 2.0) / 20.0,
        (n + 3.0) / 20.0,
        (n + 4.0) / 20.0
    )
}

fn geometry_shader_body(n_id: u32) -> String {
    let n = n_id as f32;
    format!(
        "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\nsubroutine void SubroutineGSType(inout vec4 result);\n\nsubroutine(SubroutineGSType) void SubroutineGS1(inout vec4 result)\n{{\n    result += vec4(0, 0, 0, {});\n}}\nsubroutine(SubroutineGSType) void SubroutineGS2(inout vec4 result)\n{{\n    result += vec4(0, 0, 0, {});\n}}\n\nsubroutine uniform SubroutineGSType function;\n\nin TE_DATA\n{{\n    vec4 data;\n}} in_te[];\n\nout GS_DATA\n{{\n    vec4 data;\n}} out_gs;\n\nin gl_PerVertex {{ vec4 gl_Position; }} gl_in[];\nout gl_PerVertex {{ vec4 gl_Position; }};\nvoid main()\n{{\n    vec4 data = in_te[0].data;\n\n    function(data);\n\n    gl_Position = vec4(1, -1, 0, 1);\n    out_gs.data = data;\n    EmitVertex();\n\n    gl_Position = vec4(-1, -1, 0, 1);\n    out_gs.data = data;\n    EmitVertex();\n\n    gl_Position = vec4(1, 1, 0, 1);\n    out_gs.data = data;\n    EmitVertex();\n\n    gl_Position = vec4(-1, 1, 0, 1);\n    out_gs.data = data;\n    EmitVertex();\n    EndPrimitive();\n}}\n",
        (n + 1.0) * 0.425,
        (n + 1.0) * 0.0425
    )
}

fn tessellation_control_shader_body(n_id: u32) -> String {
    let n = n_id as f32;
    format!(
        "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(vertices = 4) out;\nsubroutine void SubroutineTCType(inout vec4 result);\n\nsubroutine(SubroutineTCType) void SubroutineTC1(inout vec4 result)\n{{\n    result += vec4(0, {}, 0, 0);\n}}\nsubroutine(SubroutineTCType) void SubroutineTC2(inout vec4 result)\n{{\n    result += vec4(0, {}, 0, 0);\n}}\n\nsubroutine uniform SubroutineTCType function;\n\nin VS_DATA\n{{\n    vec4 data;\n}} in_vs[];\n\nout TC_DATA\n{{\n    vec4 data;\n}} out_tc[];\n\nin gl_PerVertex {{ vec4 gl_Position; }} gl_in[];\nout gl_PerVertex {{ vec4 gl_Position; }} gl_out[];\nvoid main()\n{{\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n    gl_TessLevelOuter[2]                = 1.0;\n    gl_TessLevelOuter[3]                = 1.0;\n    gl_TessLevelInner[0]                = 1.0;\n    gl_TessLevelInner[1]                = 1.0;\n    gl_out[gl_InvocationID].gl_Position = gl_in[0].gl_Position;\n    out_tc[gl_InvocationID].data        = in_vs[0].data;\n\n    function(out_tc[gl_InvocationID].data);\n}}\n",
        (n + 1.0) * 0.25,
        (n + 1.0) * 0.025
    )
}

fn tessellation_evaluation_shader_body(n_id: u32) -> String {
    let n = n_id as f32;
    format!(
        "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(quads, point_mode) in;\nsubroutine void SubroutineTEType(inout vec4 result);\n\nsubroutine(SubroutineTEType) void SubroutineTE1(inout vec4 result)\n{{\n    result += vec4(0, 0, {}, 0);\n}}\nsubroutine(SubroutineTEType) void SubroutineTE2(inout vec4 result)\n{{\n    result += vec4(0, 0, {}, 0);\n}}\n\nsubroutine uniform SubroutineTEType function;\n\nin TC_DATA\n{{\n    vec4 data;\n}} in_tc[];\n\nout TE_DATA\n{{\n    vec4 data;\n}} out_te;\n\nin gl_PerVertex {{ vec4 gl_Position; }} gl_in[];\nout gl_PerVertex {{ vec4 gl_Position; }};\nvoid main()\n{{\n    gl_Position = gl_in[0].gl_Position;\n    out_te.data = in_tc[0].data;\n\n    function(out_te.data);\n}}\n",
        (n + 1.0) * 0.325,
        (n + 1.0) * 0.0325
    )
}

fn vertex_shader_body(n_id: u32) -> String {
    let n = n_id as f32;
    format!(
        "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n#extension GL_ARB_separate_shader_objects: require\n\nsubroutine void SubroutineVSType(inout vec4 result);\n\nsubroutine(SubroutineVSType) void SubroutineVS1(inout vec4 result)\n{{\n    result += vec4({}, 0, 0, 0);\n}}\nsubroutine(SubroutineVSType) void SubroutineVS2(inout vec4 result)\n{{\n    result += vec4({}, 0, 0, 0);\n}}\n\nsubroutine uniform SubroutineVSType function;\n\nout VS_DATA\n{{\n    vec4 data;\n}} out_vs;\n\nout gl_PerVertex {{ vec4 gl_Position; }};\nvoid main()\n{{\n    gl_Position = vec4(0, 0, 0, 1);\n    out_vs.data = vec4(0);\n\n    function(out_vs.data);\n\n}}\n",
        (n + 1.0) * 0.125,
        (n + 1.0) * 0.0125
    )
}

/// The GL objects of `FunctionalTest13`; its `deinit` is the `Drop`.
struct State<'gl> {
    gl: &'gl glw::Functions,
    fbo_id: GLuint,
    pipeline_id: GLuint,
    fs_po_ids: [GLuint; 2],
    gs_po_ids: [GLuint; 2],
    tc_po_ids: [GLuint; 2],
    te_po_ids: [GLuint; 2],
    vs_po_ids: [GLuint; 2],
    to_id: GLuint,
    vao_id: GLuint,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            if self.fbo_id != 0 {
                gl.delete_framebuffers(1, &self.fbo_id);
            }
            if self.pipeline_id != 0 {
                gl.delete_program_pipelines(1, &self.pipeline_id);
            }
            for &po_id in self
                .fs_po_ids
                .iter()
                .chain(&self.gs_po_ids)
                .chain(&self.tc_po_ids)
                .chain(&self.te_po_ids)
                .chain(&self.vs_po_ids)
            {
                if po_id != 0 {
                    gl.delete_program(po_id);
                }
            }
            if self.to_id != 0 {
                gl.delete_textures(1, &self.to_id);
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3);
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
        }
    }
}

/// `glCreateShaderProgramv` of a single string.
fn create_shader_program(gl: &glw::Functions, shader_type: GLenum, body: &str) -> Result<GLuint, TestError> {
    let source = CString::new(body).map_err(|_| TestError::Fail("Shader source contains a NUL".to_string()))?;
    let source_ptr = source.as_ptr();
    // SAFETY: the pointer is a live NUL-terminated string and the count is one.
    let po_id = unsafe { gl.create_shader_programv(shader_type, 1, &source_ptr) };
    crate::glu::expect_no_error(gl, "glCreateShaderProgramv() call failed.")?;
    Ok(po_id)
}

/// `FunctionalTest13::verifyReadBuffer`: whether every texel is the expected sum of the five stages' modifiers.
fn verify_read_buffer(read_buffer: &[f32], ids: [u32; 5], subroutines: [u32; 5]) -> bool {
    let [n_fs_id, n_gs_id, n_tc_id, n_te_id, n_vs_id] = ids;
    let [
        n_fs_subroutine,
        n_gs_subroutine,
        n_tc_subroutine,
        n_te_subroutine,
        n_vs_subroutine,
    ] = subroutines;

    let mut fs_modifier = [0.0f32; 4];
    let mut gs_modifier = [0.0f32; 4];
    let mut tc_modifier = [0.0f32; 4];
    let mut te_modifier = [0.0f32; 4];
    let mut vs_modifier = [0.0f32; 4];

    let divisor = if n_fs_subroutine == 0 { 10.0 } else { 20.0 };
    for (n_component, modifier) in fs_modifier.iter_mut().enumerate() {
        *modifier = (n_fs_id as usize + n_component + 1) as f32 / divisor;
    }

    gs_modifier[3] = (n_gs_id + 1) as f32 * if n_gs_subroutine == 0 { 0.425 } else { 0.0425 };
    tc_modifier[1] = (n_tc_id + 1) as f32 * if n_tc_subroutine == 0 { 0.25 } else { 0.025 };
    te_modifier[2] = (n_te_id + 1) as f32 * if n_te_subroutine == 0 { 0.325 } else { 0.0325 };
    vs_modifier[0] = (n_vs_id + 1) as f32 * if n_vs_subroutine == 0 { 0.125 } else { 0.0125 };

    let expected_color: [f32; 4] =
        std::array::from_fn(|i| fs_modifier[i] + gs_modifier[i] + tc_modifier[i] + te_modifier[i] + vs_modifier[i]);
    let epsilon = 1e-5;

    for y in 0..TO_HEIGHT as usize {
        for x in 0..TO_WIDTH as usize {
            let texel = &read_buffer[(y * TO_WIDTH as usize + x) * 4..][..4];

            if (0..4).any(|i| (texel[i] - expected_color[i]).abs() > epsilon) {
                log::info!(
                    "Invalid texel rendered at ({x}, {y}) for the following configuration: n_fs_id:{n_fs_id} n_fs_subroutine:{n_fs_subroutine} n_gs_id:{n_gs_id} n_gs_subroutine:{n_gs_subroutine} n_tc_id:{n_tc_id} n_tc_subroutine:{n_tc_subroutine} n_te_id:{n_te_id} n_te_subroutine:{n_te_subroutine} n_vs_id:{n_vs_id} n_vs_subroutine:{n_vs_subroutine}; expected:({}, {}, {}, {}), found:({}, {}, {}, {}).",
                    expected_color[0],
                    expected_color[1],
                    expected_color[2],
                    expected_color[3],
                    texel[0],
                    texel[1],
                    texel[2],
                    texel[3]
                );
                return false;
            }
        }
    }

    true
}

/// `FunctionalTest13`
pub(super) struct SubroutinesWithSeparateShaderObjects;

impl TestCase for SubroutinesWithSeparateShaderObjects {
    fn name(&self) -> &str {
        "subroutines_with_separate_shader_objects"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        if !context
            .context_info
            .is_extension_supported("GL_ARB_separate_shader_objects")
        {
            return Err(TestError::NotSupported(
                "GL_ARB_separate_shader_objects is not supported".to_string(),
            ));
        }

        let mut state = State {
            gl,
            fbo_id: 0,
            pipeline_id: 0,
            fs_po_ids: [0; 2],
            gs_po_ids: [0; 2],
            tc_po_ids: [0; 2],
            te_po_ids: [0; 2],
            vs_po_ids: [0; 2],
            to_id: 0,
            vao_id: 0,
        };

        gl_call!(
            gl,
            "glViewport() call failed.",
            gl.viewport(0, 0, TO_WIDTH as glw::GLsizei, TO_HEIGHT as glw::GLsizei)
        );
        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(0));
        gl_call!(
            gl,
            "glGenProgramPipelines() call failed.",
            gl.gen_program_pipelines(1, &mut state.pipeline_id)
        );
        gl_call!(
            gl,
            "glBindProgramPipeline() call failed.",
            gl.bind_program_pipeline(state.pipeline_id)
        );

        for n_id in 0..2usize {
            state.fs_po_ids[n_id] =
                create_shader_program(gl, glw::GL_FRAGMENT_SHADER, &fragment_shader_body(n_id as u32))?;
            state.gs_po_ids[n_id] =
                create_shader_program(gl, glw::GL_GEOMETRY_SHADER, &geometry_shader_body(n_id as u32))?;
            state.tc_po_ids[n_id] = create_shader_program(
                gl,
                glw::GL_TESS_CONTROL_SHADER,
                &tessellation_control_shader_body(n_id as u32),
            )?;
            state.te_po_ids[n_id] = create_shader_program(
                gl,
                glw::GL_TESS_EVALUATION_SHADER,
                &tessellation_evaluation_shader_body(n_id as u32),
            )?;
            state.vs_po_ids[n_id] = create_shader_program(gl, glw::GL_VERTEX_SHADER, &vertex_shader_body(n_id as u32))?;

            for po_id in [
                state.fs_po_ids[n_id],
                state.gs_po_ids[n_id],
                state.tc_po_ids[n_id],
                state.te_po_ids[n_id],
                state.vs_po_ids[n_id],
            ] {
                let mut link_status = glw::GL_FALSE as GLint;
                gl_call!(
                    gl,
                    "glGetProgramiv() call failed.",
                    gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut link_status)
                );

                if link_status != glw::GL_TRUE as GLint {
                    return fail("Shader program object linking failed.");
                }
            }
        }

        gl_call!(gl, "glGenTextures() call failed.", gl.gen_textures(1, &mut state.to_id));
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, state.to_id)
        );
        gl_call!(
            gl,
            "glTexStorage2D() call failed",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA32F,
                TO_WIDTH as glw::GLsizei,
                TO_HEIGHT as glw::GLsizei
            )
        );

        gl_call!(
            gl,
            "glGenFramebuffers() call failed.",
            gl.gen_framebuffers(1, &mut state.fbo_id)
        );
        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, state.fbo_id)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D() call failed.",
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                state.to_id,
                0
            )
        );

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut state.vao_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(state.vao_id)
        );

        gl_call!(
            gl,
            "glPatchParameteri() call failed.",
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1)
        );
        gl_call!(
            gl,
            "glPixelStorei() call failed.",
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1)
        );

        let mut read_buffer = vec![0.0f32; (TO_WIDTH * TO_HEIGHT * 4) as usize];

        for n_shader_permutation in 0..32usize {
            let bit = |n: usize| (n_shader_permutation >> n) & 1;
            let (n_fs_idx, n_gs_idx, n_tc_idx, n_te_idx, n_vs_idx) = (bit(0), bit(1), bit(2), bit(3), bit(4));
            let fs_po_id = state.fs_po_ids[n_fs_idx];
            let gs_po_id = state.gs_po_ids[n_gs_idx];
            let tc_po_id = state.tc_po_ids[n_tc_idx];
            let te_po_id = state.te_po_ids[n_te_idx];
            let vs_po_id = state.vs_po_ids[n_vs_idx];

            gl_call!(
                gl,
                "glUseProgramStages() call failed for GL_FRAGMENT_SHADER_BIT bit",
                gl.use_program_stages(state.pipeline_id, glw::GL_FRAGMENT_SHADER_BIT, fs_po_id)
            );
            gl_call!(
                gl,
                "glUseProgramStages() call failed for GL_GEOMETRY_SHADER_BIT bit",
                gl.use_program_stages(state.pipeline_id, glw::GL_GEOMETRY_SHADER_BIT, gs_po_id)
            );
            gl_call!(
                gl,
                "glUseProgramStages() call failed for GL_TESS_CONTROL_SHADER_BIT bit",
                gl.use_program_stages(state.pipeline_id, glw::GL_TESS_CONTROL_SHADER_BIT, tc_po_id)
            );
            gl_call!(
                gl,
                "glUseProgramStages() call failed for GL_TESS_EVALUATION_SHADER_BIT bit",
                gl.use_program_stages(state.pipeline_id, glw::GL_TESS_EVALUATION_SHADER_BIT, te_po_id)
            );
            gl_call!(
                gl,
                "glUseProgramStages() call failed for GL_VERTEX_SHADER_BIT bit",
                gl.use_program_stages(state.pipeline_id, glw::GL_VERTEX_SHADER_BIT, vs_po_id)
            );

            let mut validate_status = glw::GL_FALSE as GLint;
            gl_call!(
                gl,
                "glValidateProgramPipeline() call failed.",
                gl.validate_program_pipeline(state.pipeline_id)
            );
            gl_call!(
                gl,
                "glGetProgramPipelineiv() call failed.",
                gl.get_program_pipelineiv(state.pipeline_id, glw::GL_VALIDATE_STATUS, &mut validate_status)
            );

            if validate_status != glw::GL_TRUE as GLint {
                return fail("Program pipeline has not been validated successfully.");
            }

            let stages = [
                (glw::GL_FRAGMENT_SHADER, fs_po_id, "SubroutineFS"),
                (glw::GL_GEOMETRY_SHADER, gs_po_id, "SubroutineGS"),
                (glw::GL_TESS_CONTROL_SHADER, tc_po_id, "SubroutineTC"),
                (glw::GL_TESS_EVALUATION_SHADER, te_po_id, "SubroutineTE"),
                (glw::GL_VERTEX_SHADER, vs_po_id, "SubroutineVS"),
            ];

            let mut subroutine_indices = [[glw::GL_INVALID_INDEX; 2]; 5];
            for (n_stage, &(stage, po_id, prefix)) in stages.iter().enumerate() {
                for n_subroutine in 0..2 {
                    let name = CString::new(format!("{prefix}{}", n_subroutine + 1)).expect("names have no NUL");
                    // SAFETY: the name is a live NUL-terminated string.
                    subroutine_indices[n_stage][n_subroutine] =
                        unsafe { gl.get_subroutine_index(po_id, stage, name.as_ptr()) };
                }
            }
            crate::glu::expect_no_error(gl, "glGetSubroutineIndex() call(s) failed.")?;

            if subroutine_indices
                .iter()
                .flatten()
                .any(|&index| index == glw::GL_INVALID_INDEX)
            {
                log::info!(
                    "At least one subroutine was not recognized by glGetSubroutineIndex() call. {subroutine_indices:?}"
                );
                return fail("At least one subroutine was not recognized");
            }

            let mut subroutine_uniform_indices = [0 as GLint; 5];
            for (n_stage, &(stage, po_id, _)) in stages.iter().enumerate() {
                // SAFETY: the name is a live NUL-terminated string.
                subroutine_uniform_indices[n_stage] =
                    unsafe { gl.get_subroutine_uniform_location(po_id, stage, c"function".as_ptr()) };
            }

            if subroutine_uniform_indices.contains(&-1) {
                log::info!(
                    "At least one subroutine uniform is considered inactive by glGetSubroutineUniformLocation ({subroutine_uniform_indices:?})."
                );
                return fail("At least one subroutine uniform is considered inactive");
            }

            for n_subroutine_permutation in 0..32usize {
                let subroutine_bit = |n: usize| (n_subroutine_permutation >> n) & 1;
                let chosen: [usize; 5] = std::array::from_fn(subroutine_bit);

                for (n_stage, &(stage, po_id, _)) in stages.iter().enumerate() {
                    gl_call!(
                        gl,
                        "glActiveShaderProgram() call failed.",
                        gl.active_shader_program(state.pipeline_id, po_id)
                    );
                    gl_call!(
                        gl,
                        "glUniformSubroutinesuiv() call failed.",
                        gl.uniform_subroutinesuiv(stage, 1, &subroutine_indices[n_stage][chosen[n_stage]])
                    );
                }

                gl_call!(gl, "glClear() call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));
                gl_call!(gl, "glDrawArrays() call failed.", gl.draw_arrays(glw::GL_PATCHES, 0, 1));
                gl_call!(
                    gl,
                    "glReadPixels() call failed.",
                    gl.read_pixels(
                        0,
                        0,
                        TO_WIDTH as glw::GLsizei,
                        TO_HEIGHT as glw::GLsizei,
                        glw::GL_RGBA,
                        glw::GL_FLOAT,
                        read_buffer.as_mut_ptr().cast()
                    )
                );

                let ids = [
                    n_fs_idx as u32,
                    n_gs_idx as u32,
                    n_tc_idx as u32,
                    n_te_idx as u32,
                    n_vs_idx as u32,
                ];
                let subroutines = chosen.map(|n| n as u32);

                if !verify_read_buffer(&read_buffer, ids, subroutines) {
                    has_test_passed = false;
                }
            }
        }

        verdict(has_test_passed)
    }
}

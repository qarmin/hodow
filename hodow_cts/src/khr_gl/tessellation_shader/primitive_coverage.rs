// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderPrimitiveCoverage.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use super::utils::{
    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE, PrimitiveMode, get_tessellation_level_set_for_primitive_mode,
};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLsizei, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderPrimitiveCoverage`
pub(super) struct PrimitiveCoverage {
    pub ext_params: ExtParameters,
}

const VS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nlayout(location = 0) in vec4 position;\n\nvoid main()\n{\n    gl_Position = position;\n}\n";
const QUAD_TESSELLATION_TCS_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(vertices = 4) out;\n\nuniform vec2 innerLevel;uniform vec4 outerLevel;\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\n    gl_TessLevelInner[0] = innerLevel.x;\n    gl_TessLevelInner[1] = innerLevel.y;\n    gl_TessLevelOuter[0] = outerLevel.x;\n    gl_TessLevelOuter[1] = outerLevel.y;\n    gl_TessLevelOuter[2] = outerLevel.z;\n    gl_TessLevelOuter[3] = outerLevel.w;\n}\n";
const QUAD_TESSELLATION_TES_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout (quads) in;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position * (1.0 - gl_TessCoord.x) * (1.0 - gl_TessCoord.y)\n                + gl_in[1].gl_Position * (      gl_TessCoord.x) * (1.0 - gl_TessCoord.y)\n                + gl_in[2].gl_Position * (      gl_TessCoord.x) * (      gl_TessCoord.y)\n                + gl_in[3].gl_Position * (1.0 - gl_TessCoord.x) * (      gl_TessCoord.y);\n}\n";
const TRIANGLES_TESSELLATION_TCS_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(vertices = 3) out;\n\nuniform vec2 innerLevel;uniform vec4 outerLevel;\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\n    gl_TessLevelInner[0] = innerLevel.x;\n    gl_TessLevelInner[1] = innerLevel.y;\n    gl_TessLevelOuter[0] = outerLevel.x;\n    gl_TessLevelOuter[1] = outerLevel.y;\n    gl_TessLevelOuter[2] = outerLevel.z;\n    gl_TessLevelOuter[3] = outerLevel.w;\n}\n";
const TRIANGLES_TESSELLATION_TES_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout (triangles) in;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position * gl_TessCoord.x\n                + gl_in[1].gl_Position * gl_TessCoord.y\n                + gl_in[2].gl_Position * gl_TessCoord.z;\n}\n";
const FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nuniform highp vec4 stencil_fail_color;\n\nlayout(location = 0) out highp vec4 color;\n\nvoid main()\n{\n    color = stencil_fail_color;\n}\n";

const CLEAR_COLOR: [f32; 4] = [1.0, 128.0 / 255.0, 64.0 / 255.0, 32.0 / 255.0];
const STENCIL_PASS_COLOR: [f32; 4] = [32.0 / 255.0, 64.0 / 255.0, 128.0 / 255.0, 1.0];
const HEIGHT: GLsizei = 2048;
const WIDTH: GLsizei = 2048;
const N_COMPONENTS: usize = 4;
const RENDERED_DATA_BUFFER_SIZE: usize = WIDTH as usize * HEIGHT as usize * N_COMPONENTS;

#[derive(Default)]
struct Resources {
    vao_id: GLuint,
    quad_tessellation_po_id: GLuint,
    stencil_verification_po_id: GLuint,
    triangles_tessellation_po_id: GLuint,
    bo_id: GLuint,
    fs_id: GLuint,
    quad_tessellation_tcs_id: GLuint,
    quad_tessellation_tes_id: GLuint,
    triangles_tessellation_tcs_id: GLuint,
    triangles_tessellation_tes_id: GLuint,
    vs_id: GLuint,
    fbo_id: GLuint,
    color_rbo_id: GLuint,
    stencil_rbo_id: GLuint,
}

impl PrimitiveCoverage {
    /// `initProgramObjects`
    fn init_program_objects(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &mut Resources,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        resources.stencil_verification_po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed!")?;
        resources.quad_tessellation_po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed!")?;
        resources.triangles_tessellation_po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed!")?;

        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader(GL_VERTEX_SHADER) failed!")?;
        resources.quad_tessellation_tcs_id = gl!(gl.create_shader(tokens.tess_control_shader));
        glu::expect_no_error(gl, "glCreateShader(GL_TESS_CONTROL_SHADER_EXT) failed!")?;
        resources.quad_tessellation_tes_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader(GL_TESS_EVALUATION_SHADER_EXT) failed!")?;
        resources.triangles_tessellation_tcs_id = gl!(gl.create_shader(tokens.tess_control_shader));
        glu::expect_no_error(gl, "glCreateShader(GL_TESS_CONTROL_SHADER_EXT) failed!")?;
        resources.triangles_tessellation_tes_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader(GL_TESS_EVALUATION_SHADER_EXT) failed!")?;
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        glu::expect_no_error(gl, "glCreateShader(GL_FRAGMENT_SHADER) failed!")?;

        // A program object without the tessellation stage
        let (built, _) = base.build_program(
            context,
            resources.stencil_verification_po_id,
            &[
                ShaderBody::Source(resources.vs_id, &[VS_CODE]),
                ShaderBody::Source(resources.fs_id, &[FS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Could not create a program object".to_string()));
        }

        // Quad tessellation
        let (built, _) = base.build_program(
            context,
            resources.quad_tessellation_po_id,
            &[
                ShaderBody::Source(resources.vs_id, &[VS_CODE]),
                ShaderBody::Source(resources.quad_tessellation_tcs_id, &[QUAD_TESSELLATION_TCS_CODE]),
                ShaderBody::Source(resources.quad_tessellation_tes_id, &[QUAD_TESSELLATION_TES_CODE]),
                ShaderBody::Source(resources.fs_id, &[FS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Could not create a program object".to_string()));
        }

        // Triangle tessellation
        let (built, _) = base.build_program(
            context,
            resources.triangles_tessellation_po_id,
            &[
                ShaderBody::Source(resources.vs_id, &[VS_CODE]),
                ShaderBody::Source(
                    resources.triangles_tessellation_tcs_id,
                    &[TRIANGLES_TESSELLATION_TCS_CODE],
                ),
                ShaderBody::Source(
                    resources.triangles_tessellation_tes_id,
                    &[TRIANGLES_TESSELLATION_TES_CODE],
                ),
                ShaderBody::Source(resources.fs_id, &[FS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Could not create a program object".to_string()));
        }
        Ok(())
    }

    /// `initFramebuffer`
    fn init_framebuffer(&self, context: &Context, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        glu::expect_no_error(gl, "glGenFramebuffers() failed!")?;
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resources.fbo_id));
        glu::expect_no_error(gl, "glBindFramebuffer() failed!")?;

        gl!(gl.gen_renderbuffers(1, &mut resources.color_rbo_id));
        glu::expect_no_error(gl, "glGenRenderbuffers() failed!")?;
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, resources.color_rbo_id));
        glu::expect_no_error(gl, "glBindRenderbuffer() failed!")?;
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, WIDTH, HEIGHT));
        glu::expect_no_error(gl, "glRenderbufferStorage() failed!")?;
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            resources.color_rbo_id
        ));
        glu::expect_no_error(gl, "glFramebufferRenderbuffer() failed!")?;

        gl!(gl.gen_renderbuffers(1, &mut resources.stencil_rbo_id));
        glu::expect_no_error(gl, "glGenRenderbuffers() failed!")?;
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, resources.stencil_rbo_id));
        glu::expect_no_error(gl, "glBindRenderbuffer() failed!")?;
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_STENCIL_INDEX8, WIDTH, HEIGHT));
        glu::expect_no_error(gl, "glRenderbufferStorage() failed!")?;
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            resources.stencil_rbo_id
        ));
        glu::expect_no_error(gl, "glFramebufferRenderbuffer() failed!")?;

        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0));
        glu::expect_no_error(gl, "glBindRenderbuffer() failed!")?;

        if gl!(gl.check_framebuffer_status(glw::GL_FRAMEBUFFER)) != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(
                "Test framebuffer has been reported as incomplete".to_string(),
            ));
        }
        Ok(())
    }

    /// `initBufferObjects`
    fn init_buffer_objects(&self, context: &Context, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        // The vertices fed into the vertex shader: a half-screen triangle, a full-screen quad patch and a full-screen quad as two triangles (all CCW).
        let vertices: [f32; 6 * N_COMPONENTS] = [
            -1.0, 1.0, 0.0, 1.0, -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0,
            1.0, -1.0, 0.0, 1.0,
        ];

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed!")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&vertices) as isize,
            vertices.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed!")?;

        gl!(gl.vertex_attrib_pointer(
            0,
            4,
            glw::GL_FLOAT,
            glw::GL_FALSE as glw::GLboolean,
            0,
            std::ptr::null()
        ));
        glu::expect_no_error(gl, "glVertexAttribPointer() failed!")?;
        gl!(gl.enable_vertex_attrib_array(0));
        glu::expect_no_error(gl, "glEnableVertexAttribArray() failed!")
    }

    /// `drawPatch`
    #[allow(clippy::too_many_arguments)]
    fn draw_patch(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &Resources,
        po_id: GLuint,
        n_patch_vertices: GLuint,
        n_draw_call_vertices: GLsizei,
        inner_levels: &[f32],
        outer_levels: &[f32],
    ) -> Result<(), TestError> {
        let gl = context.gl();

        gl!(gl.use_program(po_id));
        glu::expect_no_error(gl, "glUseProgram() failed!")?;

        let inner_name = CString::new("innerLevel").expect("no nul byte");
        let outer_name = CString::new("outerLevel").expect("no nul byte");
        let inner_level_uniform_location = gl!(gl.get_uniform_location(po_id, inner_name.as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation() failed!")?;
        let outer_level_uniform_location = gl!(gl.get_uniform_location(po_id, outer_name.as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation() failed!")?;

        gl!(gl.uniform_2fv(inner_level_uniform_location, 1, inner_levels.as_ptr()));
        glu::expect_no_error(gl, "glUniform2fv() failed!")?;
        gl!(gl.uniform_4fv(outer_level_uniform_location, 1, outer_levels.as_ptr()));
        glu::expect_no_error(gl, "glUniform4fv() failed!")?;

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, n_patch_vertices as GLint));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed!")?;

        gl!(gl.clear_color(CLEAR_COLOR[0], CLEAR_COLOR[1], CLEAR_COLOR[2], CLEAR_COLOR[3]));
        glu::expect_no_error(gl, "glClearColor() failed!")?;

        let stencil_color_name = CString::new("stencil_fail_color").expect("no nul byte");
        let mut stencil_pass_color_uniform_location = gl!(gl.get_uniform_location(po_id, stencil_color_name.as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation() failed!")?;
        gl!(gl.uniform_4fv(stencil_pass_color_uniform_location, 1, STENCIL_PASS_COLOR.as_ptr()));
        glu::expect_no_error(gl, "glUniform4fv() failed!")?;

        // Draw to the stencil buffer
        gl!(gl.clear_stencil(0));
        glu::expect_no_error(gl, "glClearStencil() failed!")?;
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));
        glu::expect_no_error(gl, "glClear() failed!")?;
        gl!(gl.stencil_op(glw::GL_REPLACE, glw::GL_KEEP, glw::GL_KEEP));
        glu::expect_no_error(gl, "glStencilOp() failed!")?;
        gl!(gl.stencil_func(glw::GL_NEVER, 1, 0xFF));
        glu::expect_no_error(gl, "glStencilFunc() failed!")?;
        gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, n_patch_vertices as GLsizei));
        glu::expect_no_error(gl, "glDrawArrays() failed")?;

        // Verify the stencil buffer contents with a full-screen draw call without any tessellation; fragments of the predefined color only appear where the stencil buffer is not filled with the predefined index value.
        gl!(gl.use_program(resources.stencil_verification_po_id));
        glu::expect_no_error(gl, "glUseProgram() failed!")?;

        stencil_pass_color_uniform_location =
            gl!(gl.get_uniform_location(resources.stencil_verification_po_id, stencil_color_name.as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation() failed!")?;
        gl!(gl.uniform_4fv(stencil_pass_color_uniform_location, 1, STENCIL_PASS_COLOR.as_ptr()));
        glu::expect_no_error(gl, "glUniform4fv() failed!")?;

        gl!(gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP));
        glu::expect_no_error(gl, "glStencilOp() failed!")?;
        gl!(gl.stencil_func(glw::GL_NOTEQUAL, 1, 0xFF));
        glu::expect_no_error(gl, "glStencilFunc() failed!")?;
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, n_draw_call_vertices));
        glu::expect_no_error(gl, "glDrawArrays() failed")
    }

    /// `verifyDrawBufferContents`
    fn verify_draw_buffer_contents(
        &self,
        context: &Context,
        rendered_data_buffer: &mut [u8],
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        gl!(gl.read_buffer(glw::GL_COLOR_ATTACHMENT0));
        glu::expect_no_error(gl, "glReadBuffer() failed")?;
        gl!(gl.read_pixels(
            0,
            0,
            HEIGHT,
            WIDTH,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            rendered_data_buffer.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "glReadPixels() failed")?;

        // Upstream only walks the first quarter of the buffer.
        let expected_result_ubyte = [
            (CLEAR_COLOR[0] * 255.0) as u8,
            (CLEAR_COLOR[1] * 255.0) as u8,
            (CLEAR_COLOR[2] * 255.0) as u8,
            (CLEAR_COLOR[3] * 255.0) as u8,
        ];
        for n_pixel in (0..RENDERED_DATA_BUFFER_SIZE >> 2).step_by(N_COMPONENTS) {
            let rendered_result_ubyte = &rendered_data_buffer[n_pixel..n_pixel + 4];
            if rendered_result_ubyte != expected_result_ubyte {
                log::info!(
                    "Rendered pixel at index ({n_pixel}) of value ({}, {}, {}, {}) does not match expected pixel ({}, {}, {}, {})",
                    rendered_result_ubyte[0],
                    rendered_result_ubyte[1],
                    rendered_result_ubyte[2],
                    rendered_result_ubyte[3],
                    expected_result_ubyte[0],
                    expected_result_ubyte[1],
                    expected_result_ubyte[2],
                    expected_result_ubyte[3]
                );
                return Ok(false);
            }
        }
        Ok(true)
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = base.gl_ext_tokens;

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        // initTest
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        self.init_program_objects(context, &base, resources)?;
        self.init_framebuffer(context, resources)?;
        self.init_buffer_objects(context, resources)?;

        let mut rendered_data_buffer = vec![0u8; RENDERED_DATA_BUFFER_SIZE];

        gl!(gl.enable(glw::GL_STENCIL_TEST));
        glu::expect_no_error(gl, "Stencil test could not be enabled!")?;

        gl!(gl.viewport(0, 0, WIDTH, HEIGHT));
        glu::expect_no_error(gl, "glViewport() failed!")?;

        let mut has_test_passed = true;

        let inner_tess_levels_single = [1.0_f32, 1.0];
        let outer_tess_levels_single = [1.0_f32, 1.0, 1.0, 1.0];

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() call failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        // No cracks if a degenerate triangle is output by the tessellator
        self.draw_patch(
            context,
            &base,
            resources,
            resources.triangles_tessellation_po_id,
            3,
            3,
            &inner_tess_levels_single,
            &outer_tess_levels_single,
        )?;
        has_test_passed &= self.verify_draw_buffer_contents(context, &mut rendered_data_buffer)?;

        // No cracks if multiple triangles are output
        let levels_sets = get_tessellation_level_set_for_primitive_mode(
            PrimitiveMode::Triangles,
            gl_max_tess_gen_level_value,
            LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
        );
        for set in &levels_sets {
            self.draw_patch(
                context,
                &base,
                resources,
                resources.triangles_tessellation_po_id,
                3,
                3,
                &set.inner,
                &set.outer,
            )?;
            has_test_passed &= self.verify_draw_buffer_contents(context, &mut rendered_data_buffer)?;
        }

        // No cracks if a degenerate quad is output
        self.draw_patch(
            context,
            &base,
            resources,
            resources.quad_tessellation_po_id,
            4,
            6,
            &inner_tess_levels_single,
            &outer_tess_levels_single,
        )?;
        has_test_passed &= self.verify_draw_buffer_contents(context, &mut rendered_data_buffer)?;

        // No cracks if multiple triangles (the quads broken into) are output
        let levels_sets = get_tessellation_level_set_for_primitive_mode(
            PrimitiveMode::Quads,
            gl_max_tess_gen_level_value,
            LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
        );
        for set in &levels_sets {
            self.draw_patch(
                context,
                &base,
                resources,
                resources.quad_tessellation_po_id,
                4,
                6,
                &set.inner,
                &set.outer,
            )?;
            has_test_passed &= self.verify_draw_buffer_contents(context, &mut rendered_data_buffer)?;
        }

        Ok(if has_test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for PrimitiveCoverage {
    fn name(&self) -> &str {
        "primitive_coverage"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.use_program(0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0));
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0));
        gl!(gl.disable(glw::GL_STENCIL_TEST));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        let _ = glu::expect_no_error(gl, "glPatchParameteriEXT() failed!");

        for program in [
            resources.quad_tessellation_po_id,
            resources.stencil_verification_po_id,
            resources.triangles_tessellation_po_id,
        ] {
            if program != 0 {
                gl!(gl.delete_program(program));
            }
        }
        for shader in [
            resources.fs_id,
            resources.quad_tessellation_tcs_id,
            resources.quad_tessellation_tes_id,
            resources.triangles_tessellation_tcs_id,
            resources.triangles_tessellation_tes_id,
            resources.vs_id,
        ] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.fbo_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.fbo_id));
        }
        for renderbuffer in [resources.color_rbo_id, resources.stencil_rbo_id] {
            if renderbuffer != 0 {
                gl!(gl.delete_renderbuffers(1, &renderbuffer));
            }
        }
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }

        outcome
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderPoints.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use super::utils::{
    LEVEL_SET_FILTER_INNER_AND_OUTER_LEVELS_USE_DIFFERENT_VALUES, PrimitiveMode, Utils, VertexOrdering, VertexSpacing,
    bytes_to_floats, get_es_token_for_primitive_mode, get_es_token_for_vertex_spacing_mode,
    get_tessellation_level_after_vertex_spacing, get_tessellation_level_set_for_primitive_mode,
};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLsizei, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const RT_HEIGHT: GLsizei = 16;
const RT_WIDTH: GLsizei = 16;

/// `TessellationShaderPointsgl_PointSize`
pub(super) struct PointSize {
    pub ext_params: ExtParameters,
}

/// `TessellationShaderPointsVerification`
pub(super) struct Verification {
    pub ext_params: ExtParameters,
}

/// `_test_descriptor`
struct TestDescriptor {
    fs_body: Option<[&'static str; 1]>,
    gs_body: Option<[&'static str; 1]>,
    tes_body: Option<[&'static str; 1]>,
    tcs_body: Option<[&'static str; 1]>,
    vs_body: Option<[&'static str; 1]>,
    draw_call_count: GLint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    tes_id: GLuint,
    tcs_id: GLuint,
    vs_id: GLuint,
}

impl TestDescriptor {
    fn new(
        fs_body: &'static str,
        gs_body: Option<&'static str>,
        tes_body: &'static str,
        tcs_body: &'static str,
        vs_body: &'static str,
        draw_call_count: GLint,
    ) -> Self {
        Self {
            fs_body: Some([fs_body]),
            gs_body: gs_body.map(|body| [body]),
            tes_body: Some([tes_body]),
            tcs_body: Some([tcs_body]),
            vs_body: Some([vs_body]),
            draw_call_count,
            fs_id: 0,
            gs_id: 0,
            po_id: 0,
            tes_id: 0,
            tcs_id: 0,
            vs_id: 0,
        }
    }
}

#[derive(Default)]
struct Resources {
    fbo_id: GLuint,
    to_id: GLuint,
    vao_id: GLuint,
    tests: Vec<TestDescriptor>,
}

const FS_FS_GS_TES_VS: &str = "${VERSION}\n\nprecision highp float;\n\nin  vec4 color;\nout vec4 result;\n\nvoid main()\n{\n    result = color;\n}\n";
const GS_FS_GS_TES_VS: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GEOMETRY_POINT_SIZE_REQUIRE}\n\nlayout(points)                 in;\nlayout(points, max_vertices=5) out;\n\nout vec4 color;\n\nvoid main()\n{\n    const float point_dx = 2.0 / 16.0 /* rendertarget width */;\n    const float point_dy = 2.0 / 16.0 /* rendertarget_height */;\n\n    color        = vec4(0.1, 0.2, 0.3, 0.4);\n    gl_PointSize = 2.0;\n    gl_Position  = vec4(point_dx + 0.0, point_dy + 0.0, 0.0, 1.0);\n    EmitVertex();\n\n    color        = vec4(0.2, 0.3, 0.4, 0.5);\n    gl_PointSize = 2.0;\n    gl_Position  = vec4(point_dx - 1.0, -point_dy + 1.0, 0.0, 1.0);\n    EmitVertex();\n\n    color        = vec4(0.3, 0.4, 0.5, 0.6);\n    gl_PointSize = 2.0;\n    gl_Position  = vec4(-point_dx + 1.0, -point_dy + 1.0, 0.0, 1.0);\n    EmitVertex();\n\n    color        = vec4(0.4, 0.5, 0.6, 0.7);\n    gl_PointSize = 2.0;\n    gl_Position  = vec4(point_dx - 1.0, point_dy - 1.0, 0.0, 1.0);\n    EmitVertex();\n\n    color        = vec4(0.5, 0.6, 0.7, 0.8);\n    gl_PointSize = 2.0;\n    gl_Position  = vec4(-point_dx + 1.0, point_dy - 1.0, 0.0, 1.0);\n    EmitVertex();\n\n}\n";
const TES_FS_GS_TES_VS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n${TESSELLATION_POINT_SIZE_REQUIRE}\n\nlayout(isolines, point_mode) in;\n\nvoid main()\n{\n    gl_PointSize = 0.1;\n}\n";
const TCS_FS_GS_TES_VS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n${TESSELLATION_POINT_SIZE_REQUIRE}\n\nlayout(vertices=1) out;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position =\n        gl_in[gl_InvocationID].gl_Position;\n    gl_out[gl_InvocationID].gl_PointSize =\n        gl_in[gl_InvocationID].gl_PointSize;\n\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n}\n";
const VS_FS_GS_TES_VS: &str = "${VERSION}\n\nvoid main()\n{\n    gl_PointSize = 0.01;\n}\n";

const FS_FS_TES_VS: &str = "${VERSION}\n\nprecision highp float;\n\nin  vec4 result_color;\nout vec4 result;\n\nvoid main()\n{\n    result = result_color;\n}\n";
const TES_FS_TES_VS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n${TESSELLATION_POINT_SIZE_REQUIRE}\n\nlayout(isolines, point_mode) in;\n\nin  vec4 tcColor[];\nout vec4 result_color;\n\nvoid main()\n{\n    gl_PointSize = 2.0;\n    gl_Position  = gl_in[0].gl_Position;\n    result_color = tcColor[0];\n}\n";
const TCS_FS_TES_VS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n${TESSELLATION_POINT_SIZE_REQUIRE}\n\nlayout(vertices=1) out;\n\nin  vec4 color[];\nout vec4 tcColor[];\n\nvoid main()\n{\n    tcColor[gl_InvocationID] = color[gl_InvocationID];\n    gl_out[gl_InvocationID].gl_Position =\n        gl_in[gl_InvocationID].gl_Position;\n    gl_out[gl_InvocationID].gl_PointSize =\n        gl_in[gl_InvocationID].gl_PointSize;\n\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n}\n";
const VS_FS_TES_VS: &str = "${VERSION}\n\nout vec4 color;\n\nvoid main()\n{\n    const float point_dx = 2.0 / 16.0 /* rendertarget width */;\n    const float point_dy = 2.0 / 16.0 /* rendertarget_height */;\n\n    gl_PointSize = 0.1;\n\n    switch (gl_VertexID)\n    {\n        case 0:\n        {\n            color       = vec4(0.1, 0.2, 0.3, 0.4);\n            gl_Position = vec4(point_dx + 0.0, point_dy + 0.0, 0.0, 1.0);\n\n            break;\n        }\n\n        case 1:\n        {\n            color       = vec4(0.2, 0.3, 0.4, 0.5);\n            gl_Position = vec4(point_dx - 1.0, -point_dy + 1.0, 0.0, 1.0);\n\n            break;\n        }\n\n        case 2:\n        {\n            color       = vec4(0.3, 0.4, 0.5, 0.6);\n            gl_Position = vec4(-point_dx + 1.0, -point_dy + 1.0, 0.0, 1.0);\n\n            break;\n        }\n\n        case 3:\n        {\n            color       = vec4(0.4, 0.5, 0.6, 0.7);\n            gl_Position = vec4(point_dx - 1.0, point_dy - 1.0, 0.0, 1.0);\n\n            break;\n        }\n\n        case 4:\n        {\n            color       = vec4(0.5, 0.6, 0.7, 0.8);\n            gl_Position = vec4(-point_dx + 1.0, point_dy - 1.0, 0.0, 1.0);\n\n            break;\n        }\n    }\n}\n";

/// x, y, r, g, b, a per point
const POINT_DATA: [f32; 30] = [
    0.5, 0.5, 0.1, 0.2, 0.3, 0.4, // center
    0.0, 1.0, 0.2, 0.3, 0.4, 0.5, // top-left
    1.0, 1.0, 0.3, 0.4, 0.5, 0.6, // top-right
    0.0, 0.0, 0.4, 0.5, 0.6, 0.7, // bottom-left
    1.0, 0.0, 0.5, 0.6, 0.7, 0.8, // bottom-right
];

impl PointSize {
    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();
        let is_es = !context.context_type().api.desktop;

        // The test only runs if the maximum point size is at least 2.
        let mut gl_max_point_size_value = [0 as GLint; 2];
        let min_max_point_size = 2;
        if !is_es {
            gl!(gl.get_integerv(glw::GL_POINT_SIZE_RANGE, gl_max_point_size_value.as_mut_ptr()));
            glu::expect_no_error(gl, "glGetIntegerv() for GL_POINT_SIZE_RANGE failed.")?;
        } else {
            gl!(gl.get_integerv(glw::GL_ALIASED_POINT_SIZE_RANGE, gl_max_point_size_value.as_mut_ptr()));
            glu::expect_no_error(gl, "glGetIntegerv() for GL_ALIASED_POINT_SIZE_RANGE failed.")?;
        }
        if gl_max_point_size_value[1] < min_max_point_size {
            return Err(TestError::NotSupported(
                "Maximum point size is lower than 2.".to_string(),
            ));
        }

        // The test requires EXT_tessellation_shader and EXT_tessellation_shader_point_size.
        if !base.is_tessellation_shader_supported || !base.is_tessellation_shader_point_size_supported {
            return Err(TestError::NotSupported(
                "At least one of the required extensions is not supported.".to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        if base.is_geometry_shader_extension_supported {
            resources.tests.push(TestDescriptor::new(
                FS_FS_GS_TES_VS,
                Some(GS_FS_GS_TES_VS),
                TES_FS_GS_TES_VS,
                TCS_FS_GS_TES_VS,
                VS_FS_GS_TES_VS,
                1,
            ));
        }
        if base.is_tessellation_shader_supported {
            resources.tests.push(TestDescriptor::new(
                FS_FS_TES_VS,
                None,
                TES_FS_TES_VS,
                TCS_FS_TES_VS,
                VS_FS_TES_VS,
                5,
            ));
        }

        gl!(gl.gen_textures(1, &mut resources.to_id));
        glu::expect_no_error(gl, "glGenTextures() failed")?;
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.to_id));
        glu::expect_no_error(gl, "glBindTexture() failed")?;
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, RT_WIDTH, RT_HEIGHT));
        glu::expect_no_error(gl, "glTexStorage2D() failed")?;

        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        glu::expect_no_error(gl, "glGenFramebuffers() failed")?;
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resources.fbo_id));
        glu::expect_no_error(gl, "glBindFramebuffer() failed")?;
        gl!(gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            resources.to_id,
            0
        ));
        glu::expect_no_error(gl, "glFramebufferTexture2D() failed")?;

        if !is_es {
            gl!(gl.enable(glw::GL_PROGRAM_POINT_SIZE));
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        self.init_test(context, &base, resources)?;

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed")?;

        for test in &mut resources.tests {
            // Generate all shader objects we'll need
            if test.fs_body.is_some() {
                test.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
            }
            if test.gs_body.is_some() {
                test.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
            }
            if test.tes_body.is_some() {
                test.tes_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_evaluation_shader));
            }
            if test.tcs_body.is_some() {
                test.tcs_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_control_shader));
            }
            if test.vs_body.is_some() {
                test.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
            }
            glu::expect_no_error(gl, "glCreateShader() call(s) failed")?;

            test.po_id = gl!(gl.create_program());
            glu::expect_no_error(gl, "glCreateProgram() call failed")?;

            fn stage<'a>(id: GLuint, body: &'a Option<[&'static str; 1]>) -> ShaderBody<'a> {
                match body {
                    Some(body) if id != 0 => ShaderBody::Source(id, body),
                    _ => ShaderBody::Skip,
                }
            }
            let (link_success, _) = base.build_program(
                context,
                test.po_id,
                &[
                    stage(test.fs_id, &test.fs_body),
                    stage(test.gs_id, &test.gs_body),
                    stage(test.tes_id, &test.tes_body),
                    stage(test.tcs_id, &test.tcs_body),
                    stage(test.vs_id, &test.vs_body),
                ],
            )?;
            if !link_success {
                return Err(TestError::Fail("Program linking failed".to_string()));
            }

            gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
            glu::expect_no_error(gl, "glClearColor() failed")?;
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
            glu::expect_no_error(gl, "glClear(GL_COLOR_BUFFER_BIT) failed")?;
            gl!(gl.viewport(0, 0, RT_WIDTH, RT_HEIGHT));
            glu::expect_no_error(gl, "glViewport() failed")?;
            gl!(gl.use_program(test.po_id));
            glu::expect_no_error(gl, "glUseProgram() failed")?;

            gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, test.draw_call_count));
            glu::expect_no_error(gl, "glDrawArrays() failed")?;

            let mut buffer = vec![0u8; (RT_WIDTH * RT_HEIGHT * 4) as usize];
            gl!(gl.read_pixels(
                0,
                0,
                RT_WIDTH,
                RT_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                buffer.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "glReadPixels() failed")?;

            // Verify all 5 points were rendered correctly
            let epsilon = 1.0_f32 / 255.0;
            let pixel_size = 4;
            let row_size = pixel_size * RT_WIDTH as usize;
            let n_fields_per_point = 6;

            for n_point in 0..POINT_DATA.len() / n_fields_per_point {
                let point = &POINT_DATA[n_point * n_fields_per_point..];
                let x = (point[0] * (RT_WIDTH - 1) as f32 + 0.5) as usize;
                let y = (point[1] * (RT_HEIGHT - 1) as f32 + 0.5) as usize;
                let expected_color = [point[2], point[3], point[4], point[5]];

                let rendered_color_ubyte = &buffer[row_size * y + x * pixel_size..];
                let rendered_color: [f32; 4] =
                    [0, 1, 2, 3].map(|component| f32::from(rendered_color_ubyte[component]) / 255.0);

                if (0..4).any(|component| (expected_color[component] - rendered_color[component]).abs() > epsilon) {
                    log::info!(
                        "Pixel data comparison failed; expected: ({}, {}, {}, {}) rendered: ({}, {}, {}, {}) epsilon: {epsilon}",
                        expected_color[0],
                        expected_color[1],
                        expected_color[2],
                        expected_color[3],
                        rendered_color[0],
                        rendered_color[1],
                        rendered_color[2],
                        rendered_color[3]
                    );
                    return Err(TestError::Fail("Pixel data comparison failed".to_string()));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for PointSize {
    fn name(&self) -> &str {
        "point_rendering"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        if context.context_type().api.desktop {
            gl!(gl.disable(glw::GL_PROGRAM_POINT_SIZE));
        }
        gl!(gl.use_program(0));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        gl!(gl.bind_vertex_array(0));
        for test in &resources.tests {
            for shader in [test.fs_id, test.gs_id, test.tes_id, test.tcs_id, test.vs_id] {
                if shader != 0 {
                    gl!(gl.delete_shader(shader));
                }
            }
            if test.po_id != 0 {
                gl!(gl.delete_program(test.po_id));
            }
        }
        if resources.fbo_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.fbo_id));
        }
        if resources.to_id != 0 {
            gl!(gl.delete_textures(1, &resources.to_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}

/// `_run`
struct Run {
    inner: [f32; 2],
    outer: [f32; 4],
    primitive_mode: PrimitiveMode,
    vertex_spacing: VertexSpacing,
}

impl Verification {
    /// `verifyCorrectAmountOfVertices`
    fn verify_correct_amount_of_vertices(
        &self,
        context: &Context,
        base: &TestCaseBase,
        run: &Run,
        run_n_vertices: u32,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let epsilon = 1e-5_f32;
        let mut post_vs_inner_tess_levels = [0.0_f32; 2];
        let mut post_vs_outer_tess_levels = [0.0_f32; 4];

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(base.gl_ext_tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() call failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        // The vertex spacing the tessellator should have used for the current primitive mode
        let mut actual_inner_levels = run.inner;
        let actual_vs_mode = run.vertex_spacing;
        let clamped_inner_levels = [
            get_tessellation_level_after_vertex_spacing(
                run.vertex_spacing,
                actual_inner_levels[0],
                gl_max_tess_gen_level_value,
            )
            .0,
            get_tessellation_level_after_vertex_spacing(
                run.vertex_spacing,
                actual_inner_levels[1],
                gl_max_tess_gen_level_value,
            )
            .0,
        ];

        if run.primitive_mode == PrimitiveMode::Isolines {
            // outer[1] is subdivided as per the specified vertex spacing; outer[0] with equal spacing, since the spec says the u==0 and u==1 edges are subdivided according to the first outer level with the spacing mode ignored.
            post_vs_outer_tess_levels[0] = get_tessellation_level_after_vertex_spacing(
                VertexSpacing::Equal,
                run.outer[0],
                gl_max_tess_gen_level_value,
            )
            .1;
            post_vs_outer_tess_levels[1] =
                get_tessellation_level_after_vertex_spacing(actual_vs_mode, run.outer[1], gl_max_tess_gen_level_value)
                    .1;
        }

        if run.primitive_mode == PrimitiveMode::Quads {
            // If either clamped inner level is one, it is treated as 1+epsilon, which rounds up to a two- or three-segment subdivision according to the spacing.
            if (clamped_inner_levels[0] - 1.0).abs() < epsilon {
                actual_inner_levels[0] = get_tessellation_level_after_vertex_spacing(
                    run.vertex_spacing,
                    clamped_inner_levels[0] + 1.0,
                    gl_max_tess_gen_level_value,
                )
                .1;
            }
            if (clamped_inner_levels[1] - 1.0).abs() < epsilon {
                actual_inner_levels[1] = get_tessellation_level_after_vertex_spacing(
                    run.vertex_spacing,
                    clamped_inner_levels[1] + 1.0,
                    gl_max_tess_gen_level_value,
                )
                .1;
            }
        }

        for n in 0..2 {
            post_vs_inner_tess_levels[n] = get_tessellation_level_after_vertex_spacing(
                actual_vs_mode,
                actual_inner_levels[n],
                gl_max_tess_gen_level_value,
            )
            .1;
        }
        if run.primitive_mode != PrimitiveMode::Isolines {
            for n in 0..4 {
                post_vs_outer_tess_levels[n] = get_tessellation_level_after_vertex_spacing(
                    actual_vs_mode,
                    run.outer[n],
                    gl_max_tess_gen_level_value,
                )
                .1;
            }
        }

        let n_expected_vertices: i32 = match run.primitive_mode {
            PrimitiveMode::Isolines => {
                post_vs_outer_tess_levels[0] as i32 * (post_vs_outer_tess_levels[1] + 1.0) as i32
            }
            PrimitiveMode::Quads => {
                // outer quad + inner quad
                post_vs_outer_tess_levels[0] as i32
                    + post_vs_outer_tess_levels[1] as i32
                    + post_vs_outer_tess_levels[2] as i32
                    + post_vs_outer_tess_levels[3] as i32
                    + (post_vs_inner_tess_levels[0] as i32 - 1) * (post_vs_inner_tess_levels[1] as i32 - 1)
            }
            PrimitiveMode::Triangles => {
                // If the first inner level and all three outer levels are exactly one after clamping and rounding, a single triangle is generated.
                if (run.inner[0] - 1.0).abs() < epsilon
                    && (run.outer[0] - 1.0).abs() < epsilon
                    && (run.outer[1] - 1.0).abs() < epsilon
                    && (run.outer[2] - 1.0).abs() < epsilon
                {
                    3
                } else {
                    // An inner level of one with any outer level above one is treated as 1+epsilon and rounds up to a two- or three-segment subdivision.
                    if (run.inner[0] - 1.0).abs() < epsilon
                        && (run.outer[0] > 1.0 || run.outer[1] > 1.0 || run.outer[2] > 1.0)
                    {
                        post_vs_inner_tess_levels[0] = get_tessellation_level_after_vertex_spacing(
                            run.vertex_spacing,
                            2.0,
                            gl_max_tess_gen_level_value,
                        )
                        .1;
                    }

                    // Count the vertices making up the concentric inner triangles
                    let mut n_expected = post_vs_outer_tess_levels[0] as i32
                        + post_vs_outer_tess_levels[1] as i32
                        + post_vs_outer_tess_levels[2] as i32;
                    let mut n = post_vs_inner_tess_levels[0] as i32;
                    while n >= 0 {
                        // The innermost triangle is degenerate (a single point at the centre) if <n> is two.
                        if n == 2 {
                            n_expected += 1;
                            break;
                        }
                        // If <n> is three, the edges of the inner triangle are not subdivided and it is the final triangle.
                        if n == 3 {
                            n_expected += 3;
                            break;
                        }
                        // Otherwise each edge is divided into <n>-2 segments.
                        if n >= 2 {
                            n_expected += (n - 2) * 3;
                        } else {
                            n_expected += 1;
                        }
                        n -= 2;
                    }
                    n_expected
                }
            }
        };

        if run_n_vertices as i32 != n_expected_vertices {
            log::info!(
                "{run_n_vertices} vertices were generated by the tessellator instead of expected {n_expected_vertices} for primitive mode [{}], vertex spacing mode [{}], inner tessellation levels:[{}, {}], outer tessellation levels:[{}, {}, {}, {}], point mode enabled.",
                get_es_token_for_primitive_mode(run.primitive_mode),
                get_es_token_for_vertex_spacing_mode(run.vertex_spacing),
                run.inner[0],
                run.inner[1],
                run.outer[0],
                run.outer[1],
                run.outer[2],
                run.outer[3]
            );
            return Err(TestError::Fail(
                "Amount of vertices generated in point mode was incorrect".to_string(),
            ));
        }
        Ok(())
    }

    /// `verifyCorrectAmountOfDuplicateVertices`
    fn verify_correct_amount_of_duplicate_vertices(
        run: &Run,
        run_data: &[f32],
        run_n_vertices: u32,
    ) -> Result<(), TestError> {
        let epsilon = 1e-5_f32;
        let mut n_duplicate_vertices = 0;

        for n_vertex_a in 0..run_n_vertices as usize {
            let vertex_a = &run_data[n_vertex_a * 3..];
            for n_vertex_b in n_vertex_a + 1..run_n_vertices as usize {
                let vertex_b = &run_data[n_vertex_b * 3..];
                if (vertex_a[0] - vertex_b[0]).abs() < epsilon
                    && (vertex_a[1] - vertex_b[1]).abs() < epsilon
                    && (vertex_a[2] - vertex_b[2]).abs() < epsilon
                {
                    n_duplicate_vertices += 1;
                }
            }
        }

        if n_duplicate_vertices != 0 {
            log::info!(
                "Duplicate vertices found for the following tesselelation configuration: tessellation level:[{}, {}], outer tessellation level: [{}, {}, {}, {}], vertex spacing mode:[{}]",
                run.inner[0],
                run.inner[1],
                run.outer[0],
                run.outer[1],
                run.outer[2],
                run.outer[3],
                get_es_token_for_vertex_spacing_mode(run.vertex_spacing)
            );
            return Err(TestError::Fail("Duplicate vertex found".to_string()));
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut GlobalVao) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        // initTest
        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(base.gl_ext_tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        let primitive_modes = [PrimitiveMode::Quads, PrimitiveMode::Isolines, PrimitiveMode::Triangles];
        let vertex_spacings = [
            VertexSpacing::FractionalOdd,
            VertexSpacing::Equal,
            VertexSpacing::FractionalEven,
        ];

        let mut runs: Vec<Run> = Vec::new();
        for primitive_mode in primitive_modes {
            let levels_set = get_tessellation_level_set_for_primitive_mode(
                primitive_mode,
                gl_max_tess_gen_level_value,
                LEVEL_SET_FILTER_INNER_AND_OUTER_LEVELS_USE_DIFFERENT_VALUES,
            );

            for vertex_spacing in vertex_spacings {
                for levels in &levels_set {
                    // Skip border cases that this test cannot handle
                    if (primitive_mode == PrimitiveMode::Quads || primitive_mode == PrimitiveMode::Triangles)
                        && vertex_spacing == VertexSpacing::FractionalOdd
                        && (levels.inner[0] <= 1.0 || levels.inner[1] <= 1.0)
                    {
                        continue;
                    }
                    runs.push(Run {
                        inner: levels.inner,
                        outer: levels.outer,
                        primitive_mode,
                        vertex_spacing,
                    });
                }
            }
        }

        let utils = Utils::new(context, &base)?;

        for run in &runs {
            let run_data = bytes_to_floats(&utils.get_data_generated_by_tessellator(
                &run.inner,
                true,
                run.primitive_mode,
                VertexOrdering::Ccw,
                run.vertex_spacing,
                &run.outer,
            )?);
            let run_n_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
                run.primitive_mode,
                &run.inner,
                &run.outer,
                run.vertex_spacing,
                true,
            )?;

            // A valid amount of duplicate vertices within a single data set, then a correct amount of generated vertices given the stage configuration.
            Self::verify_correct_amount_of_duplicate_vertices(run, &run_data, run_n_vertices)?;
            self.verify_correct_amount_of_vertices(context, &base, run, run_n_vertices)?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

#[derive(Default)]
struct GlobalVao {
    vao_id: GLuint,
}

impl TestCase for Verification {
    fn name(&self) -> &str {
        "points_verification"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = GlobalVao::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.bind_vertex_array(0));
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}

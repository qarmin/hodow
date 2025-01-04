// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTCTE.cpp / .hpp   (TessellationShaderTCTEgl_TessLevel)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::utils::{PrimitiveMode, TestType, Utils, VertexSpacing, get_es_token_for_vertex_spacing_mode};
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTCTEgl_TessLevel`
pub(super) struct GlTessLevel {
    pub ext_params: ExtParameters,
}

/// `_test_descriptor`
struct TestDescriptor {
    test_type: TestType,
    vertex_spacing: VertexSpacing,
    fs_id: GLuint,
    po_id: GLuint,
    tcs_id: GLuint,
    tes_id: GLuint,
    vs_id: GLuint,
    inner_tess_levels_uniform_location: GLint,
    outer_tess_levels_uniform_location: GLint,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    vao_id: GLuint,
    tests: Vec<TestDescriptor>,
}

const FS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const TC_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices = 4) out;\n\nuniform vec2 inner_tess_levels;\nuniform vec4 outer_tess_levels;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    if (gl_InvocationID == 0) {\n        gl_TessLevelInner[0]                           = inner_tess_levels[0];\n        gl_TessLevelInner[1]                           = inner_tess_levels[1];\n        gl_TessLevelOuter[0]                           = outer_tess_levels[0];\n        gl_TessLevelOuter[1]                           = outer_tess_levels[1];\n        gl_TessLevelOuter[2]                           = outer_tess_levels[2];\n        gl_TessLevelOuter[3]                           = outer_tess_levels[3];\n   }\n}\n";
const TE_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (quads, point_mode, VERTEX_SPACING_MODE) in;\n\nout vec2 result_tess_level_inner;\nout vec4 result_tess_level_outer;\n\nvoid main()\n{\n    vec4 p1 = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);\n    vec4 p2 = mix(gl_in[2].gl_Position,gl_in[3].gl_Position,gl_TessCoord.x);\n    gl_Position = mix(p1, p2, gl_TessCoord.y);\n\n    result_tess_level_inner = vec2(gl_TessLevelInner[0],\n                                   gl_TessLevelInner[1]);\n    result_tess_level_outer = vec4(gl_TessLevelOuter[0],\n                                   gl_TessLevelOuter[1],\n                                   gl_TessLevelOuter[2],\n                                   gl_TessLevelOuter[3]);\n}\n";
const VS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 2.0, 3.0, 4.0);\n}\n";

const TESSELLATION_LEVEL_COMBINATIONS: [f32; 18] = [
    1.1, 1.4, 2.7, 3.1, 4.4, 5.7, 64.2, 32.5, 16.8, 8.2, 4.5, 2.8, 3.3, 6.6, 9.9, 12.3, 15.6, 18.9,
];

impl GlTessLevel {
    /// `initTestDescriptor`
    fn init_test_descriptor(
        &self,
        context: &Context,
        base: &TestCaseBase,
        test_type: TestType,
        vertex_spacing_mode: VertexSpacing,
    ) -> Result<TestDescriptor, TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        let mut test = TestDescriptor {
            test_type,
            vertex_spacing: vertex_spacing_mode,
            fs_id: 0,
            po_id: 0,
            tcs_id: 0,
            tes_id: 0,
            vs_id: 0,
            inner_tess_levels_uniform_location: 0,
            outer_tess_levels_uniform_location: 0,
        };

        test.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        test.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        test.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        test.tes_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        if test_type == TestType::TcsTes {
            test.tcs_id = gl!(gl.create_shader(tokens.tess_control_shader));
        }
        glu::expect_no_error(gl, "glCreateShader() failed")?;
        let result = self.configure_test_descriptor(context, base, &mut test);
        match result {
            Ok(()) => Ok(test),
            Err(error) => {
                Self::release_descriptor(gl, &mut test);
                Err(error)
            }
        }
    }

    fn configure_test_descriptor(
        &self,
        context: &Context,
        base: &TestCaseBase,
        test: &mut TestDescriptor,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        shader_source_specialized(gl, base, test.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader object")?;

        if test.test_type == TestType::TcsTes {
            shader_source_specialized(gl, base, test.tcs_id, TC_BODY);
            glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader object")?;
        }

        let te_body = TE_BODY.replace(
            "VERTEX_SPACING_MODE",
            get_es_token_for_vertex_spacing_mode(test.vertex_spacing),
        );
        shader_source_specialized(gl, base, test.tes_id, &te_body);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation evaluation shader object")?;

        shader_source_specialized(gl, base, test.vs_id, VS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for vertex shader object")?;

        for (n_shader, shader) in [test.fs_id, test.tcs_id, test.tes_id, test.vs_id]
            .into_iter()
            .enumerate()
        {
            if shader != 0 {
                let mut compile_status = glw::GL_FALSE as GLint;
                gl!(gl.compile_shader(shader));
                glu::expect_no_error(gl, "glCompileShader() call failed")?;
                gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
                glu::expect_no_error(gl, "glGetShaderiv() call failed")?;
                if compile_status != glw::GL_TRUE as GLint {
                    log::info!("Compilation of shader object at index {n_shader} failed.");
                    return Err(TestError::Fail("Shader compilation failed".to_string()));
                }
            }
        }

        let inner = CString::new("result_tess_level_inner").expect("no nul byte");
        let outer = CString::new("result_tess_level_outer").expect("no nul byte");
        let varyings = [inner.as_ptr(), outer.as_ptr()];
        gl!(gl.transform_feedback_varyings(test.po_id, 2, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed")?;

        gl!(gl.attach_shader(test.po_id, test.fs_id));
        gl!(gl.attach_shader(test.po_id, test.vs_id));
        if test.tcs_id != 0 {
            gl!(gl.attach_shader(test.po_id, test.tcs_id));
        }
        if test.tes_id != 0 {
            gl!(gl.attach_shader(test.po_id, test.tes_id));
        }
        glu::expect_no_error(gl, "glAttachShader() call(s) failed.")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.link_program(test.po_id));
        glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
        gl!(gl.get_programiv(test.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        let inner_name = CString::new("inner_tess_levels").expect("no nul byte");
        let outer_name = CString::new("outer_tess_levels").expect("no nul byte");
        test.inner_tess_levels_uniform_location = gl!(gl.get_uniform_location(test.po_id, inner_name.as_ptr()));
        test.outer_tess_levels_uniform_location = gl!(gl.get_uniform_location(test.po_id, outer_name.as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation() call(s) failed")
    }

    /// `deinitTestDescriptor`
    fn release_descriptor(gl: &glw::Functions, test: &mut TestDescriptor) {
        if test.fs_id != 0 {
            gl!(gl.delete_shader(test.fs_id));
            test.fs_id = 0;
        }
        if test.po_id != 0 {
            gl!(gl.delete_program(test.po_id));
            test.po_id = 0;
        }
        for shader in [&mut test.tcs_id, &mut test.tes_id, &mut test.vs_id] {
            if *shader != 0 {
                gl!(gl.delete_shader(*shader));
                *shader = 0;
            }
        }
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

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
        glu::expect_no_error(gl, "glGetIntegerv() for GL_MAX_TESS_GEN_LEVEL_EXT pname failed")?;

        let spacings = [
            VertexSpacing::Equal,
            VertexSpacing::FractionalEven,
            VertexSpacing::FractionalOdd,
        ];
        for spacing in spacings {
            let test = self.init_test_descriptor(context, base, TestType::TcsTes, spacing)?;
            resources.tests.push(test);
        }
        if context.context_type().api.desktop {
            for spacing in spacings {
                let test = self.init_test_descriptor(context, base, TestType::Tes, spacing)?;
                resources.tests.push(test);
            }
        }

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() call failed")?;
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() call failed")
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        self.init_test(context, &base, resources)?;

        // The program takes a single quad per patch.
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 4));
        glu::expect_no_error(gl, "glPatchParameteriEXT() call failed")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed.")?;

        for test in &resources.tests {
            let n_tessellation_level_combinations = TESSELLATION_LEVEL_COMBINATIONS.len() / 6;

            for n_combination in 0..n_tessellation_level_combinations {
                let combination = &TESSELLATION_LEVEL_COMBINATIONS[n_combination * 6..];
                let inner_tess_level = [combination[0], combination[1]];
                let outer_tess_level = [combination[2], combination[3], combination[4], combination[5]];

                // Upstream creates the helper per combination; its destructor resets state at the end of every iteration.
                let tess_utils = Utils::new(context, &base)?;
                let n_rendered_vertices = tess_utils.get_amount_of_vertices_generated_by_tessellator(
                    PrimitiveMode::Quads,
                    &inner_tess_level,
                    &outer_tess_level,
                    test.vertex_spacing,
                    true,
                )?;

                gl!(gl.use_program(test.po_id));
                glu::expect_no_error(gl, "glUseProgram() call failed")?;

                match test.test_type {
                    TestType::TcsTes => {
                        gl!(gl.uniform_2fv(test.inner_tess_levels_uniform_location, 1, inner_tess_level.as_ptr()));
                        glu::expect_no_error(gl, "glUniform2fv() call failed")?;
                        gl!(gl.uniform_4fv(test.outer_tess_levels_uniform_location, 1, outer_tess_level.as_ptr()));
                        glu::expect_no_error(gl, "glUniform4fv() call failed")?;
                    }
                    TestType::Tes => {
                        if context.context_type().api.desktop {
                            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_INNER_LEVEL, inner_tess_level.as_ptr()));
                            glu::expect_no_error(
                                gl,
                                "glPatchParameterfv() call failed for GL_PATCH_DEFAULT_INNER_LEVEL pname",
                            )?;
                            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_OUTER_LEVEL, outer_tess_level.as_ptr()));
                            glu::expect_no_error(
                                gl,
                                "glPatchParameterfv() call failed for GL_PATCH_DEFAULT_OUTER_LEVEL pname",
                            )?;
                        }
                    }
                }

                let n_bytes_needed = n_rendered_vertices as usize * (2 + 4) * std::mem::size_of::<f32>();
                gl!(gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    n_bytes_needed as isize,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW
                ));
                glu::expect_no_error(gl, "glBufferData() call failed")?;

                gl!(gl.begin_transform_feedback(glw::GL_POINTS));
                glu::expect_no_error(gl, "glBeginTransformFeedback() call failed")?;

                gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, 4));
                glu::expect_no_error(gl, "glDrawArrays() call failed")?;

                gl!(gl.end_transform_feedback());
                glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

                let mapped = gl!(gl.map_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    n_bytes_needed as isize,
                    glw::GL_MAP_READ_BIT
                ));
                glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
                if mapped.is_null() {
                    return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
                }
                // SAFETY: `n_bytes_needed` bytes were mapped for reading; the copy ends before the unmap below.
                let mapped_data =
                    unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), n_bytes_needed / 4) }.to_vec();

                gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
                glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;

                // For each result vertex, the tessellation levels should be unchanged.
                let epsilon = 1e-5_f32;
                for point_data in mapped_data.chunks_exact(2 + 4) {
                    if (point_data[2] - outer_tess_level[0]).abs() > epsilon
                        || (point_data[3] - outer_tess_level[1]).abs() > epsilon
                    {
                        log::info!(
                            "Invalid inner/outer tessellation level used in TE stage; expected outer:({}, {})  rendered outer:({}, {}) vertex spacing mode: {}",
                            outer_tess_level[0],
                            outer_tess_level[1],
                            point_data[2],
                            point_data[3],
                            get_es_token_for_vertex_spacing_mode(test.vertex_spacing)
                        );
                        return Err(TestError::Fail(
                            "Invalid inner/outer tessellation level used in TE stage".to_string(),
                        ));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for GlTessLevel {
    fn name(&self) -> &str {
        "gl_tessLevel"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        if context.context_type().api.desktop {
            let default_levels = [1.0_f32, 1.0, 1.0, 1.0];
            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_INNER_LEVEL, default_levels.as_ptr()));
            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_OUTER_LEVEL, default_levels.as_ptr()));
        }
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_vertex_array(0));
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        for test in &mut resources.tests {
            Self::release_descriptor(gl, test);
        }
        outcome
    }
}

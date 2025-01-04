// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderXFB.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, LogType, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderXFB`
pub(super) struct Xfb {
    pub ext_params: ExtParameters,
}

/// `_test_descriptor`
struct TestDescriptor {
    expected_data_source: GLenum,
    expected_n_values: usize,
    should_draw_call_fail: bool,
    requires_pipeline: bool,
    tf_mode: GLenum,
    use_gs: bool,
    use_tc: bool,
    use_te: bool,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    tc_id: GLuint,
    te_id: GLuint,
    vs_id: GLuint,
    pipeline_id: GLuint,
    fs_program_id: GLuint,
    gs_program_id: GLuint,
    tc_program_id: GLuint,
    te_program_id: GLuint,
    vs_program_id: GLuint,
    vao_id: GLuint,
}

const FS_BODY: &str = "${VERSION}\n\n${SHADER_IO_BLOCKS_REQUIRE}\n\nprecision highp float;\nin BLOCK_INOUT { vec4 value; } user_in;\n\nvoid main()\n{\n}\n";
const GS_BODY: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\nprecision highp float;\n${IN_PER_VERTEX_DECL_ARRAY}${OUT_PER_VERTEX_DECL}in  BLOCK_INOUT { vec4 value; } user_in[];\nout BLOCK_INOUT { vec4 value; } user_out;\n\nvoid main()\n{\n    user_out.value = vec4(1.0, 2.0, 3.0, 4.0);\n    gl_Position    = vec4(0.0, 0.0, 0.0, 1.0);\n\n    EmitVertex();\n}\n";
const TC_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nprecision highp float;\n${IN_PER_VERTEX_DECL_ARRAY}${OUT_PER_VERTEX_DECL_ARRAY}in  BLOCK_INOUT { vec4 value; } user_in[];\nout BLOCK_INOUT { vec4 value; } user_out[];\n\nvoid main()\n{\n    gl_out   [gl_InvocationID].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n    user_out [gl_InvocationID].value       = vec4(2.0, 3.0, 4.0, 5.0);\n\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n}\n";
const TE_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (isolines, point_mode) in;\n\nprecision highp float;\n${IN_PER_VERTEX_DECL_ARRAY}${OUT_PER_VERTEX_DECL}in  BLOCK_INOUT { vec4 value; } user_in[];\nout BLOCK_INOUT { vec4 value; } user_out;\n\nvoid main()\n{\n    gl_Position     = gl_in[0].gl_Position;\n    user_out.value = vec4(3.0, 4.0, 5.0, 6.0);\n}\n";
const VS_BODY: &str = "${VERSION}\n\n${SHADER_IO_BLOCKS_REQUIRE}\n\nprecision highp float;\n${OUT_PER_VERTEX_DECL}out BLOCK_INOUT { vec4 value; } user_out;\n\nvoid main()\n{\n    gl_Position    = vec4(1.0, 0.0, 0.0, 1.0);\n    user_out.value = vec4(4.0, 5.0, 6.0, 7.0);\n}\n";
const VARYING_NAME: &str = "BLOCK_INOUT.value";

impl Xfb {
    /// `createSeparableProgram`
    fn create_separable_program(
        &self,
        context: &Context,
        base: &TestCaseBase,
        shader_type: GLenum,
        body: &str,
        varyings: &[&str],
        should_succeed: bool,
    ) -> Result<GLuint, TestError> {
        let gl = context.gl();

        let so_id = gl!(gl.create_shader(shader_type));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        let mut po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        gl!(gl.program_parameteri(po_id, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint));
        glu::expect_no_error(gl, "glProgramParameteri() call failed")?;

        if !varyings.is_empty() {
            let names: Vec<CString> = varyings
                .iter()
                .map(|name| CString::new(*name).expect("no nul byte"))
                .collect();
            let name_ptrs: Vec<*const glw::GLchar> = names.iter().map(|name| name.as_ptr()).collect();
            gl!(gl.transform_feedback_varyings(
                po_id,
                name_ptrs.len() as GLint,
                name_ptrs.as_ptr(),
                glw::GL_SEPARATE_ATTRIBS
            ));
            glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed")?;
        }

        let (build_success, _) = base.build_program(context, po_id, &[ShaderBody::Source(so_id, &[body])])?;

        // Safe to delete the shader object at this point
        gl!(gl.delete_shader(so_id));
        glu::expect_no_error(gl, "glDeleteShader() call failed")?;

        if !build_success {
            gl!(gl.delete_program(po_id));
            glu::expect_no_error(gl, "glDeleteProgram() call failed")?;
            po_id = 0;
            if should_succeed {
                return Err(TestError::Fail("Separable program should have succeeded".to_string()));
            }
        } else if !should_succeed {
            // Upstream asks for the source of the shader it has just deleted.
            let shader_source = base.get_shader_source(context, so_id)?;
            log::info!("Shader source:\n\n{shader_source}\n\n");
            return Err(TestError::Fail("Separable program should have failed".to_string()));
        }
        Ok(po_id)
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        if !base.is_tessellation_shader_supported {
            return Ok(());
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.tc_id = gl!(gl.create_shader(tokens.tess_control_shader));
        resources.te_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        if base.is_geometry_shader_extension_supported {
            resources.gs_id = gl!(gl.create_shader(tokens.geometry_shader));
            glu::expect_no_error(gl, "glCreateShader() failed for GL_GEOMETRY_SHADER_EXT")?;
        }

        gl!(gl.gen_program_pipelines(1, &mut resources.pipeline_id));
        glu::expect_no_error(gl, "glGenProgramPipelines() failed")?;

        shader_source_specialized(gl, base, resources.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader")?;

        let check_link_status = |program: GLuint, message: &str| -> Result<(), TestError> {
            let mut link_status = glw::GL_FALSE as GLint;
            gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut link_status));
            glu::expect_no_error(gl, "glGetProgramiv() failed")?;
            if link_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail(message.to_string()));
            }
            Ok(())
        };

        resources.fs_program_id =
            self.create_separable_program(context, base, glw::GL_FRAGMENT_SHADER, FS_BODY, &[], true)?;
        check_link_status(resources.fs_program_id, "Fragment shader program failed to link.")?;

        if base.is_geometry_shader_extension_supported {
            shader_source_specialized(gl, base, resources.gs_id, GS_BODY);
            glu::expect_no_error(gl, "glShaderSource() failed for geometry shader")?;

            resources.gs_program_id =
                self.create_separable_program(context, base, tokens.geometry_shader, GS_BODY, &[VARYING_NAME], true)?;
            if resources.gs_program_id == 0 {
                return Err(TestError::Fail(
                    "Could not create a separate geometry program object".to_string(),
                ));
            }
            check_link_status(resources.gs_program_id, "Geometry shader program failed to link.")?;
        }

        shader_source_specialized(gl, base, resources.tc_id, TC_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader")?;

        // For ES, a tessellation control shader program with feedback fails, and a different one without the varyings is used.
        let tc_feedback_valid = context.context_type().api.desktop;

        resources.tc_program_id = self.create_separable_program(
            context,
            base,
            tokens.tess_control_shader,
            TC_BODY,
            &[VARYING_NAME],
            tc_feedback_valid,
        )?;
        if !tc_feedback_valid {
            resources.tc_program_id =
                self.create_separable_program(context, base, tokens.tess_control_shader, TC_BODY, &[], true)?;
        }
        if resources.tc_program_id == 0 {
            return Err(TestError::Fail(
                "Could not create a separate tessellation control program object".to_string(),
            ));
        }
        check_link_status(
            resources.tc_program_id,
            "Tessellation control shader program failed to link.",
        )?;

        shader_source_specialized(gl, base, resources.te_id, TE_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation evaluation shader")?;

        resources.te_program_id = self.create_separable_program(
            context,
            base,
            tokens.tess_evaluation_shader,
            TE_BODY,
            &[VARYING_NAME],
            true,
        )?;
        if resources.te_program_id == 0 {
            return Err(TestError::Fail(
                "Could not create a separate tessellation evaluation program object".to_string(),
            ));
        }
        check_link_status(
            resources.te_program_id,
            "Tessellation evaluation shader program failed to link.",
        )?;

        shader_source_specialized(gl, base, resources.vs_id, VS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for vertex shader")?;

        resources.vs_program_id =
            self.create_separable_program(context, base, glw::GL_VERTEX_SHADER, VS_BODY, &[VARYING_NAME], true)?;

        // Compile all the shaders
        let gs_for_compilation = if base.is_geometry_shader_extension_supported {
            resources.gs_id
        } else {
            0
        };
        let sources = [FS_BODY, GS_BODY, TC_BODY, TE_BODY, VS_BODY];
        for (n_shader, shader) in [
            resources.fs_id,
            gs_for_compilation,
            resources.tc_id,
            resources.te_id,
            resources.vs_id,
        ]
        .into_iter()
        .enumerate()
        {
            if shader != 0 {
                let mut compile_status = glw::GL_FALSE as GLint;
                gl!(gl.compile_shader(shader));
                glu::expect_no_error(gl, "glCompileShader() failed")?;
                gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
                glu::expect_no_error(gl, "glGetShaderiv() failed")?;
                if compile_status != glw::GL_TRUE as GLint {
                    let info_log = base.get_info_log(context, LogType::Shader, shader)?;
                    log::info!(
                        "Compilation of shader object at index {n_shader} failed.\nInfo log:\n{info_log}Shader:\n{}",
                        sources[n_shader]
                    );
                    return Err(TestError::Fail("Shader compilation failed".to_string()));
                }
            }
        }

        // Attach fragment & vertex shaders to the program object
        gl!(gl.attach_shader(resources.po_id, resources.fs_id));
        gl!(gl.attach_shader(resources.po_id, resources.vs_id));
        glu::expect_no_error(gl, "glAttachShader() failed")?;

        // Configure the pipeline object's fragment & vertex stages
        gl!(gl.use_program_stages(
            resources.pipeline_id,
            glw::GL_FRAGMENT_SHADER_BIT,
            resources.fs_program_id
        ));
        glu::expect_no_error(gl, "glUseProgramStages call failed for fragment stage")?;
        gl!(gl.use_program_stages(
            resources.pipeline_id,
            glw::GL_VERTEX_SHADER_BIT,
            resources.vs_program_id
        ));
        glu::expect_no_error(gl, "glUseProgramStages call failed for vertex stage")?;

        // XFB for the conventional program object
        let varying = CString::new(VARYING_NAME).expect("no nul byte");
        let varyings = [varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(resources.po_id, 1, varyings.as_ptr(), glw::GL_SEPARATE_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed")?;

        // Room for a 4 vertex patch, which is what desktop GL needs for tessellation control shader feedback whenever GL_NV_gpu_shader5 is present.
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed")?;
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            (std::mem::size_of::<f32>() * 4 * 4) as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() failed")
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

        self.init_test(context, &base, resources)?;

        let mut tests: Vec<TestDescriptor> = Vec::new();
        if base.is_geometry_shader_extension_supported {
            tests.push(TestDescriptor {
                expected_data_source: tokens.geometry_shader,
                expected_n_values: 2,
                should_draw_call_fail: false,
                requires_pipeline: false,
                tf_mode: glw::GL_POINTS,
                use_gs: true,
                use_tc: true,
                use_te: true,
            });
        }
        tests.push(TestDescriptor {
            expected_data_source: tokens.tess_evaluation_shader,
            expected_n_values: 2,
            should_draw_call_fail: false,
            requires_pipeline: false,
            tf_mode: glw::GL_POINTS,
            use_gs: false,
            use_tc: true,
            use_te: true,
        });

        // A special negative case
        let tc_feedback_works =
            context.context_type().api.desktop && TestCaseBase::is_extension_supported(context, "GL_NV_gpu_shader5");
        tests.push(TestDescriptor {
            expected_data_source: tokens.tess_control_shader,
            expected_n_values: 4,
            should_draw_call_fail: !tc_feedback_works,
            requires_pipeline: true,
            tf_mode: if tc_feedback_works {
                tokens.patches
            } else {
                glw::GL_POINTS
            },
            use_gs: false,
            use_tc: true,
            use_te: false,
        });

        // Use only one vertex per patch
        gl!(gl.patch_parameteri(tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed.")?;

        // Two iterations: 1) the shaders are attached to a program object for each test and detached afterwards; 2) a pipeline object is used.
        for n_iteration in 0..2 {
            let use_pipeline_object = n_iteration == 1;

            if use_pipeline_object {
                gl!(gl.bind_program_pipeline(resources.pipeline_id));
                glu::expect_no_error(gl, "glBindProgramPipeline() failed.")?;
                gl!(gl.use_program(0));
                glu::expect_no_error(gl, "glUseProgram() failed")?;
            } else {
                gl!(gl.bind_program_pipeline(0));
                glu::expect_no_error(gl, "glBindProgramPipeline() failed.")?;
                // The program object is about to be re-linked, so glUseProgram() is deferred.
            }

            for test in &tests {
                if use_pipeline_object {
                    if base.is_geometry_shader_extension_supported {
                        gl!(gl.use_program_stages(
                            resources.pipeline_id,
                            tokens.geometry_shader_bit,
                            if test.use_gs { resources.gs_program_id } else { 0 }
                        ));
                        glu::expect_no_error(gl, "glUseProgramStages() failed for GL_GEOMETRY_SHADER_BIT_EXT")?;
                    }
                    gl!(gl.use_program_stages(
                        resources.pipeline_id,
                        tokens.tess_control_shader_bit,
                        if test.use_tc { resources.tc_program_id } else { 0 }
                    ));
                    glu::expect_no_error(gl, "glUseProgramStages() failed for GL_TESS_CONTROL_SHADER_BIT_EXT")?;
                    gl!(gl.use_program_stages(
                        resources.pipeline_id,
                        tokens.tess_evaluation_shader_bit,
                        if test.use_te { resources.te_program_id } else { 0 }
                    ));
                    glu::expect_no_error(gl, "glUseProgramStages() failed for GL_TESS_EVALUATION_SHADER_BIT_EXT")?;

                    gl!(gl.validate_program_pipeline(resources.pipeline_id));
                    glu::expect_no_error(gl, "glValidateProgramPipeline() failed")?;

                    let mut validate_status = glw::GL_FALSE as GLint;
                    gl!(gl.get_program_pipelineiv(
                        resources.pipeline_id,
                        glw::GL_VALIDATE_STATUS,
                        &mut validate_status
                    ));
                    glu::expect_no_error(gl, "glGetProgramPipelineiv() failed")?;

                    if validate_status == glw::GL_FALSE as GLint && !test.should_draw_call_fail {
                        log::info!(
                            "A pipeline object consisting of: [fragment stage] {}{}{}[vertex stage] was not validated successfully, even though it should.",
                            if test.use_gs { "[geometry stage] " } else { "" },
                            if test.use_tc {
                                "[tessellation control stage] "
                            } else {
                                ""
                            },
                            if test.use_te {
                                "[tessellation evaluation stage] "
                            } else {
                                ""
                            }
                        );
                        return Err(TestError::Fail(
                            "Pipeline object is considered invalid, even though the stage combination is valid"
                                .to_string(),
                        ));
                    }
                } else {
                    if test.requires_pipeline {
                        continue;
                    }

                    if test.use_gs {
                        gl!(gl.attach_shader(resources.po_id, resources.gs_id));
                        glu::expect_no_error(gl, "Could not attach geometry shader")?;
                    }
                    if test.use_tc {
                        gl!(gl.attach_shader(resources.po_id, resources.tc_id));
                        glu::expect_no_error(gl, "Could not attach tessellation control shader")?;
                    }
                    if test.use_te {
                        gl!(gl.attach_shader(resources.po_id, resources.te_id));
                        glu::expect_no_error(gl, "Could not attach tessellation evaluation shader")?;
                    }

                    gl!(gl.link_program(resources.po_id));
                    glu::expect_no_error(gl, "Could not link program object")?;

                    let mut link_status = glw::GL_FALSE as GLint;
                    gl!(gl.get_programiv(resources.po_id, glw::GL_LINK_STATUS, &mut link_status));
                    glu::expect_no_error(gl, "glGetProgramiv() failed")?;

                    if link_status != glw::GL_TRUE as GLint {
                        log::info!(
                            "A program object consisting of: [fragment shader] {}{}{}[vertex shader] failed to link, even though it should link successfully.",
                            if test.use_gs { "[geometry shader] " } else { "" },
                            if test.use_tc {
                                "[tessellation control shader] "
                            } else {
                                ""
                            },
                            if test.use_te {
                                "[tessellation evaluation shader] "
                            } else {
                                ""
                            }
                        );
                        return Err(TestError::Fail(
                            "Program linking failed, even though the shader combination was valid".to_string(),
                        ));
                    }

                    gl!(gl.use_program(resources.po_id));
                    glu::expect_no_error(gl, "glUseProgram() failed.")?;
                }

                // Render a single point
                gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
                glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed")?;

                gl!(gl.begin_transform_feedback(test.tf_mode));
                let mut did_begin_xfb_fail = false;
                if !test.should_draw_call_fail {
                    glu::expect_no_error(gl, "glBeginTransformFeedback(GL_POINTS) failed")?;
                } else {
                    // For the negative case ES is not clear whether glBeginTransformFeedback() errors, so either it or the draw call may raise INVALID_OPERATION.
                    let err = gl!(gl.get_error());
                    if err == glw::GL_INVALID_OPERATION {
                        did_begin_xfb_fail = true;
                    } else if err != glw::GL_NO_ERROR {
                        return Err(TestError::Fail("Unexpected GL error in a beginTransformFeedback made on the program pipeline whose program closest to TFB has no output varying specified".to_string()));
                    }
                }

                gl!(gl.draw_arrays(tokens.patches, 0, 1));
                if !test.should_draw_call_fail {
                    glu::expect_no_error(gl, "glDrawArrays() failed")?;
                } else if gl!(gl.get_error()) != glw::GL_INVALID_OPERATION && !did_begin_xfb_fail {
                    return Err(TestError::Fail("A draw call made using a program object lacking TES stage has not generated a GL_INVALID_OPERATION as specified".to_string()));
                }

                gl!(gl.end_transform_feedback());
                if !did_begin_xfb_fail {
                    glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;
                } else if gl!(gl.get_error()) != glw::GL_INVALID_OPERATION {
                    return Err(TestError::Fail("An endTransformFeedback made on inactive xfb has not generated a GL_INVALID_OPERATION as specified".to_string()));
                }

                gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
                glu::expect_no_error(gl, "glDisable(GL_RASTERIZER_DISCARD) failed")?;

                if !test.should_draw_call_fail {
                    let size = std::mem::size_of::<f32>() * 4 * test.expected_n_values;
                    let result_ptr = gl!(gl.map_buffer_range(
                        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                        0,
                        size as isize,
                        glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT
                    ));
                    glu::expect_no_error(gl, "glMapBufferRange() failed")?;
                    if result_ptr.is_null() {
                        return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
                    }
                    // SAFETY: `size` bytes were mapped for reading and writing; the mapping lives until the unmap below.
                    let captured = unsafe { std::slice::from_raw_parts_mut(result_ptr.cast::<f32>(), size / 4) };

                    let epsilon = 1e-5_f32;
                    for n_value in 0..test.expected_n_values {
                        let expected_data: [f32; 4] = if test.expected_data_source == tokens.geometry_shader {
                            [1.0, 2.0, 3.0, 4.0]
                        } else if test.expected_data_source == tokens.tess_control_shader {
                            [2.0, 3.0, 4.0, 5.0]
                        } else if test.expected_data_source == tokens.tess_evaluation_shader {
                            [3.0, 4.0, 5.0, 6.0]
                        } else if test.expected_data_source == glw::GL_VERTEX_SHADER {
                            [4.0, 5.0, 6.0, 7.0]
                        } else {
                            return Err(TestError::Fail("Unrecognized expected data source".to_string()));
                        };
                        let captured_data = &captured[n_value * 4..n_value * 4 + 4];

                        if (0..4).any(|component| (captured_data[component] - expected_data[component]).abs() > epsilon)
                        {
                            log::info!(
                                "Captured data ({}, {}, {}, {})is different from the expected value ({}, {}, {}, {})",
                                captured_data[0],
                                captured_data[1],
                                captured_data[2],
                                captured_data[3],
                                expected_data[0],
                                expected_data[1],
                                expected_data[2],
                                expected_data[3]
                            );
                            return Err(TestError::Fail("Invalid data captured".to_string()));
                        }
                    }

                    captured.fill(0.0);
                    gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
                    glu::expect_no_error(gl, "glUnmapBuffer() failed")?;
                }

                if !use_pipeline_object {
                    if test.use_gs {
                        gl!(gl.detach_shader(resources.po_id, resources.gs_id));
                        glu::expect_no_error(gl, "Could not detach geometry shader")?;
                    }
                    if test.use_tc {
                        gl!(gl.detach_shader(resources.po_id, resources.tc_id));
                        glu::expect_no_error(gl, "Could not detach tessellation control shader")?;
                    }
                    if test.use_te {
                        gl!(gl.detach_shader(resources.po_id, resources.te_id));
                        glu::expect_no_error(gl, "Could not detach tessellation evaluation shader")?;
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Xfb {
    fn name(&self) -> &str {
        "xfb_captures_data_from_correct_stage"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        gl!(gl.bind_program_pipeline(0));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.bind_vertex_array(0));
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        for program in [
            resources.fs_program_id,
            resources.gs_program_id,
            resources.po_id,
            resources.tc_program_id,
            resources.te_program_id,
            resources.vs_program_id,
        ] {
            if program != 0 {
                gl!(gl.delete_program(program));
            }
        }
        for shader in [
            resources.fs_id,
            resources.gs_id,
            resources.tc_id,
            resources.te_id,
            resources.vs_id,
        ] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.pipeline_id != 0 {
            gl!(gl.delete_program_pipelines(1, &resources.pipeline_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cDirectStateAccessTests.cpp
//   external/openglcts/modules/gl/gl4cDirectStateAccessXFBTests.cpp
//   external/openglcts/modules/gl/gl4cDirectStateAccessSamplersTests.cpp
//   external/openglcts/modules/gl/gl4cDirectStateAccessProgramPipelinesTests.cpp
//   external/openglcts/modules/gl/gl4cDirectStateAccessQueriesTests.cpp
//   external/openglcts/modules/gl/gl4cDirectStateAccessBuffersTests.cpp
//   external/openglcts/modules/gl/gl4cDirectStateAccessFramebuffersAndRenderbuffersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `Tests::init` registers 371 cases in one flat group; they are spread over this file and the direct_state_access_*_tests.rs next to it (every one of the 371 mustpass names appears in those sources). Upstream's `try { .. } catch (...)` around every test body, which turns a throw (a failed `GLU_EXPECT_NO_ERROR`, or `throw 0`) into an INTERNAL_ERROR result, is `dsa_outcome`; the DSA gate (core 4.5 or GL_ARB_direct_state_access, else NotSupported) is `check_support`.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};

pub(super) fn check_dsa_support(context: &Context) -> Result<(), TestError> {
    let is_at_least_gl_45 = context.context_type().supports_core(4, 5);
    let is_arb_direct_state_access = context
        .context_info
        .is_extension_supported("GL_ARB_direct_state_access");
    if !is_at_least_gl_45 && !is_arb_direct_state_access {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }
    Ok(())
}

/// The `is_ok`/`is_error` verdict of every test of this file: a body that returns `Ok(true)` passes, `Ok(false)` fails, and an `Err` is upstream's caught exception.
pub(super) fn dsa_outcome(body: impl FnOnce() -> Result<bool, TestError>) -> TestOutcome {
    Ok(match body() {
        Ok(true) => TestStatus::pass("Pass"),
        Ok(false) => TestStatus::fail("Fail"),
        Err(_) => TestStatus::new(TestResult::InternalError, "Error"),
    })
}

// ------------------------------------------------------------------------------------------------------------------
// Samplers

/// `Samplers::CreationTest`
struct SamplersCreationTest;

impl TestCase for SamplersCreationTest {
    fn name(&self) -> &str {
        "samplers_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const SAMPLERS_COUNT: usize = 2;
        let gl = context.gl();
        let mut samplers_dsa = [0 as glw::GLuint; SAMPLERS_COUNT];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: SAMPLERS_COUNT names are written to the live array.
            unsafe { gl.create_samplers(SAMPLERS_COUNT as glw::GLsizei, samplers_dsa.as_mut_ptr()) };
            glu::expect_no_error(gl, "glCreateSamplers have failed")?;

            for sampler in &samplers_dsa {
                // SAFETY: plain query.
                if unsafe { gl.is_sampler(*sampler) } == 0 {
                    is_ok = false;
                    log::info!("CreateSamplers has not created defualt objects.");
                }
            }
            Ok(is_ok)
        });

        for sampler in &mut samplers_dsa {
            if *sampler != 0 {
                // SAFETY: deletes a name created above.
                unsafe { gl.delete_samplers(1, sampler) };
                *sampler = 0;
            }
        }
        outcome
    }
}

/// `Samplers::DefaultsTest`
struct SamplersDefaultsTest;

impl SamplersDefaultsTest {
    /// `testSamplerIntegerParameter`
    fn test_sampler_integer_parameter(
        gl: &glw::Functions,
        sampler: glw::GLuint,
        pname: glw::GLenum,
        expected_value: glw::GLint,
    ) -> Result<bool, TestError> {
        let mut value: glw::GLint = -1;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_sampler_parameteriv(sampler, pname, &mut value) };
        glu::expect_no_error(gl, "glGetSamplerParameteriv have failed")?;

        if value == -1 {
            log::info!(
                "glGetSamplerParameteriv with parameter {pname:#x} has not returned anything and error has not been generated."
            );
            return Ok(false);
        }
        if expected_value != value {
            log::info!(
                "glGetSamplerParameteriv with parameter {pname:#x} has returned {value}, however {expected_value} was expected."
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// `testSamplerFloatParameter`
    fn test_sampler_float_parameter(
        gl: &glw::Functions,
        sampler: glw::GLuint,
        pname: glw::GLenum,
        expected_value: glw::GLfloat,
    ) -> Result<bool, TestError> {
        let mut value: glw::GLfloat = -1.0;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_sampler_parameterfv(sampler, pname, &mut value) };
        glu::expect_no_error(gl, "glGetSamplerParameteriv have failed")?;

        if (expected_value - value).abs() > 0.015625 {
            log::info!(
                "glGetSamplerParameterfv with parameter {pname:#x} has returned {value}, however {expected_value} was expected."
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// `testSamplerFloatVectorParameter`
    fn test_sampler_float_vector_parameter(
        gl: &glw::Functions,
        sampler: glw::GLuint,
        pname: glw::GLenum,
        expected_value: [glw::GLfloat; 4],
    ) -> Result<bool, TestError> {
        let mut value = [-1.0f32; 4];
        // SAFETY: four values are written to the live array.
        unsafe { gl.get_sampler_parameterfv(sampler, pname, value.as_mut_ptr()) };
        glu::expect_no_error(gl, "glGetSamplerParameterfv have failed")?;

        if expected_value
            .iter()
            .zip(value)
            .any(|(expected, value)| (expected - value).abs() > 0.015625)
        {
            log::info!(
                "glGetSamplerParameterfv with parameter {pname:#x} has returned {value:?}, however {expected_value:?} was expected."
            );
            return Ok(false);
        }
        Ok(true)
    }
}

impl TestCase for SamplersDefaultsTest {
    fn name(&self) -> &str {
        "samplers_defaults"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut sampler_dsa: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: one name is written to the live local.
            unsafe { gl.create_samplers(1, &mut sampler_dsa) };
            glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;

            let sampler = sampler_dsa;
            is_ok &= Self::test_sampler_float_vector_parameter(
                gl,
                sampler,
                glw::GL_TEXTURE_BORDER_COLOR,
                [0.0, 0.0, 0.0, 0.0],
            )?;
            is_ok &= Self::test_sampler_integer_parameter(
                gl,
                sampler,
                glw::GL_TEXTURE_COMPARE_FUNC,
                glw::GL_LEQUAL as glw::GLint,
            )?;
            is_ok &= Self::test_sampler_integer_parameter(
                gl,
                sampler,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_NONE as glw::GLint,
            )?;
            is_ok &= Self::test_sampler_float_parameter(gl, sampler, glw::GL_TEXTURE_LOD_BIAS, 0.0)?;
            is_ok &= Self::test_sampler_float_parameter(gl, sampler, glw::GL_TEXTURE_MAX_LOD, 1000.0)?;
            is_ok &= Self::test_sampler_integer_parameter(
                gl,
                sampler,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_LINEAR as glw::GLint,
            )?;
            is_ok &= Self::test_sampler_integer_parameter(
                gl,
                sampler,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST_MIPMAP_LINEAR as glw::GLint,
            )?;
            is_ok &= Self::test_sampler_float_parameter(gl, sampler, glw::GL_TEXTURE_MIN_LOD, -1000.0)?;
            is_ok &= Self::test_sampler_integer_parameter(
                gl,
                sampler,
                glw::GL_TEXTURE_WRAP_S,
                glw::GL_REPEAT as glw::GLint,
            )?;
            is_ok &= Self::test_sampler_integer_parameter(
                gl,
                sampler,
                glw::GL_TEXTURE_WRAP_T,
                glw::GL_REPEAT as glw::GLint,
            )?;
            is_ok &= Self::test_sampler_integer_parameter(
                gl,
                sampler,
                glw::GL_TEXTURE_WRAP_R,
                glw::GL_REPEAT as glw::GLint,
            )?;
            Ok(is_ok)
        });

        if sampler_dsa != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_samplers(1, &sampler_dsa) };
        }
        outcome
    }
}

/// `Samplers::ErrorsTest`
struct SamplersErrorsTest;

impl TestCase for SamplersErrorsTest {
    fn name(&self) -> &str {
        "samplers_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut sampler_dsa: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: a negative count is the error this call is expected to generate; nothing is written.
            unsafe { gl.create_samplers(-1, &mut sampler_dsa) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_INVALID_VALUE {
                is_ok = false;
                log::info!(
                    "CreateSamplers has not generated INVALID_VALUE error when callded with negative number of samplers to be created.Instead, {} error value was generated.",
                    glw::error_name(error)
                );
            }
            Ok(is_ok)
        });

        if sampler_dsa != 0 {
            // SAFETY: deletes a name the driver wrote despite the error.
            unsafe { gl.delete_samplers(1, &sampler_dsa) };
        }
        outcome
    }
}

/// `Samplers::FunctionalTest`
struct SamplersFunctionalTest;

impl SamplersFunctionalTest {
    const VERTEX_SHADER: &'static str = "#version 330\n\nvoid main()\n{\n    switch(gl_VertexID)\n    {\n        case 0:\n            gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n            break;\n        case 1:\n            gl_Position = vec4( 1.0, 1.0, 0.0, 1.0);\n            break;\n        case 2:\n            gl_Position = vec4(-1.0,-1.0, 0.0, 1.0);\n            break;\n        case 3:\n            gl_Position = vec4( 1.0,-1.0, 0.0, 1.0);\n            break;\n    }\n}\n";
    const FRAGMENT_SHADER: &'static str = "#version 330\n\nuniform sampler2D texture_sampler;\n\nout vec4 color;\n\nvoid main()\n{\n    color = texture(texture_sampler, vec2(0.33333, 0.33333));\n}\n";
    const UNIFORM_SAMPLER: &'static str = "texture_sampler";
    const TEXTURE_DATA: [u8; 16] = [
        0xFF, 0x00, 0x00, 0xFF, // red
        0x00, 0xFF, 0x00, 0xFF, // green
        0x00, 0x00, 0xFF, 0xFF, // blue
        0xFF, 0xFF, 0x00, 0xFF, // yellow
    ];
}

/// The objects of `FunctionalTest` (`m_fbo`, `m_rbo`, `m_vao`, `m_to`, `m_so`, `m_po`), released by `clean()`.
struct SamplersFunctionalObjects<'gl> {
    gl: &'gl glw::Functions,
    fbo: glw::GLuint,
    rbo: glw::GLuint,
    vao: glw::GLuint,
    to: glw::GLuint,
    so: glw::GLuint,
    po: glw::GLuint,
}

impl Drop for SamplersFunctionalObjects<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes only names this guard holds; zero names are skipped.
        unsafe {
            if self.fbo != 0 {
                self.gl.delete_framebuffers(1, &self.fbo);
            }
            if self.rbo != 0 {
                self.gl.delete_renderbuffers(1, &self.rbo);
            }
            if self.vao != 0 {
                self.gl.delete_vertex_arrays(1, &self.vao);
            }
            if self.to != 0 {
                self.gl.delete_textures(1, &self.to);
            }
            if self.so != 0 {
                self.gl.delete_samplers(1, &self.so);
            }
            if self.po != 0 {
                self.gl.use_program(0);
                self.gl.delete_program(self.po);
            }
        }
    }
}

impl TestCase for SamplersFunctionalTest {
    fn name(&self) -> &str {
        "samplers_functional"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = SamplersFunctionalObjects {
            gl,
            fbo: 0,
            rbo: 0,
            vao: 0,
            to: 0,
            so: 0,
            po: 0,
        };

        dsa_outcome(|| {
            // prepareFramebuffer
            // SAFETY: names are written to live fields; a 1x1 RGBA8 renderbuffer is attached.
            unsafe {
                gl.gen_framebuffers(1, &mut objects.fbo);
                glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
                gl.gen_renderbuffers(1, &mut objects.rbo);
                glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo);
                glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbo);
                glu::expect_no_error(gl, "glBindRenderbuffer call failed.")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage call failed.")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    objects.rbo,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer call failed.")?;
                if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    return Err(TestError::Fail("throw 0".to_string()));
                }
                gl.viewport(0, 0, 1, 1);
                glu::expect_no_error(gl, "glViewport call failed.")?;
                gl.clear_color(0.0, 0.0, 0.0, 0.0);
                glu::expect_no_error(gl, "glClearColor call failed.")?;
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                glu::expect_no_error(gl, "glClear call failed.")?;
            }

            // prepareVertexArrayObject
            // SAFETY: a name is written to the live field, then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut objects.vao);
                glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
                gl.bind_vertex_array(objects.vao);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            }

            // prepareProgram
            let vertex = super::common_bugs_tests::Shader::new(gl, glw::GL_VERTEX_SHADER)?;
            let fragment = super::common_bugs_tests::Shader::new(gl, glw::GL_FRAGMENT_SHADER)?;
            {
                let program = super::common_bugs_tests::Program::new(gl)?;
                for (shader, source) in [(&vertex, Self::VERTEX_SHADER), (&fragment, Self::FRAGMENT_SHADER)] {
                    shader.source(&[source])?;
                    if !shader.compile()? {
                        log::info!("Shader compilation has failed.\nShader source code:\n{source}\n");
                        return Err(TestError::Fail("throw 0".to_string()));
                    }
                    program.attach(shader)?;
                }
                if !program.link()? {
                    log::info!("Program linkage has failed.");
                    return Err(TestError::Fail("throw 0".to_string()));
                }
                // Detach the shaders as upstream does after a successful link, then keep the program in the guard.
                // SAFETY: both shaders are attached to the program.
                unsafe {
                    gl.detach_shader(program.id, vertex.id);
                    glu::expect_no_error(gl, "glDetachShader call failed.")?;
                    gl.detach_shader(program.id, fragment.id);
                    glu::expect_no_error(gl, "glDetachShader call failed.")?;
                }
                objects.po = program.id;
                std::mem::forget(program);
            }
            // SAFETY: a live, linked program.
            unsafe { gl.use_program(objects.po) };
            glu::expect_no_error(gl, "glUseProgram call failed.")?;

            // prepareTexture
            // SAFETY: a texture generated and bound here, a 2x2 RGBA8 image of 16 bytes, and a uniform of the program in use.
            unsafe {
                gl.active_texture(glw::GL_TEXTURE0);
                glu::expect_no_error(gl, "glActiveTexture call failed.")?;
                gl.gen_textures(1, &mut objects.to);
                glu::expect_no_error(gl, "glGenTextures call failed.")?;
                gl.bind_texture(glw::GL_TEXTURE_2D, objects.to);
                glu::expect_no_error(gl, "glBindTexture call failed.")?;
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA8 as glw::GLint,
                    2,
                    2,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    Self::TEXTURE_DATA.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "glTexImage2D call failed.")?;

                // Upstream ignores the location and uses 0.
                let name = CString::new(Self::UNIFORM_SAMPLER).expect("no NUL in the name");
                gl.get_uniform_location(objects.po, name.as_ptr());
                glu::expect_no_error(gl, "glGetUniformLocation call failed.")?;
                gl.uniform_1i(0, 0);
                glu::expect_no_error(gl, "glUniform1i call failed.")?;
            }

            // prepareSampler
            // SAFETY: a sampler created and bound here.
            unsafe {
                gl.create_samplers(1, &mut objects.so);
                glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;
                gl.bind_sampler(0, objects.so);
                glu::expect_no_error(gl, "glBindSampler have failed")?;
                gl.sampler_parameteri(objects.so, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as glw::GLint);
                gl.sampler_parameteri(objects.so, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as glw::GLint);
                gl.sampler_parameteri(objects.so, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as glw::GLint);
                gl.sampler_parameteri(objects.so, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as glw::GLint);
                glu::expect_no_error(gl, "glSamplerParameteri have failed")?;
            }

            // draw
            // SAFETY: plain draw into the framebuffer prepared above.
            unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
            glu::expect_no_error(gl, "glDrawArrays have failed")?;

            // checkFramebufferContent
            let mut pixel = [0u8; 4];
            // SAFETY: one RGBA pixel is written to the live array.
            unsafe {
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    pixel.as_mut_ptr().cast(),
                )
            };
            glu::expect_no_error(gl, "glReadPixels have failed")?;
            if Self::TEXTURE_DATA[..4] != pixel {
                log::info!(
                    "Frameuffer content ({}, {}, {}, {}) is different than expected ({}, {}, {}, {}).",
                    pixel[0],
                    pixel[1],
                    pixel[2],
                    pixel[3],
                    Self::TEXTURE_DATA[0],
                    Self::TEXTURE_DATA[1],
                    Self::TEXTURE_DATA[2],
                    Self::TEXTURE_DATA[3]
                );
                return Ok(false);
            }
            Ok(true)
        })
    }
}

// ------------------------------------------------------------------------------------------------------------------
// Program pipelines

/// `ProgramPipelines::CreationTest`
struct ProgramPipelinesCreationTest;

impl TestCase for ProgramPipelinesCreationTest {
    fn name(&self) -> &str {
        "program_pipelines_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const COUNT: usize = 2;
        let gl = context.gl();
        let mut program_pipelines_legacy = [0 as glw::GLuint; COUNT];
        let mut program_pipelines_dsa = [0 as glw::GLuint; COUNT];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: COUNT names are written to the live array.
            unsafe { gl.gen_program_pipelines(COUNT as glw::GLsizei, program_pipelines_legacy.as_mut_ptr()) };
            glu::expect_no_error(gl, "glGenProgramPipelines have failed")?;

            for pipeline in &program_pipelines_legacy {
                // SAFETY: plain query.
                if unsafe { gl.is_program_pipeline(*pipeline) } != 0 {
                    is_ok = false;
                    log::info!("GenProgramPipelines has created default objects, but it should create only a names.");
                }
            }

            // SAFETY: COUNT names are written to the live array.
            unsafe { gl.create_program_pipelines(COUNT as glw::GLsizei, program_pipelines_dsa.as_mut_ptr()) };
            glu::expect_no_error(gl, "glCreateProgramPipelines have failed")?;

            for pipeline in &program_pipelines_dsa {
                // SAFETY: plain query.
                if unsafe { gl.is_program_pipeline(*pipeline) } == 0 {
                    is_ok = false;
                    log::info!("CreateProgramPipelines has not created default objects.");
                }
            }
            Ok(is_ok)
        });

        for pipeline in program_pipelines_legacy.iter().chain(&program_pipelines_dsa) {
            if *pipeline != 0 {
                // SAFETY: deletes a name generated above.
                unsafe { gl.delete_program_pipelines(1, pipeline) };
            }
        }
        outcome
    }
}

/// `ProgramPipelines::DefaultsTest`
struct ProgramPipelinesDefaultsTest;

impl ProgramPipelinesDefaultsTest {
    /// `testProgramPipelineParameter`
    fn test_program_pipeline_parameter(
        gl: &glw::Functions,
        pipeline: glw::GLuint,
        pname: glw::GLenum,
        expected_value: glw::GLint,
    ) -> Result<bool, TestError> {
        let mut value: glw::GLint = -1;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_program_pipelineiv(pipeline, pname, &mut value) };
        glu::expect_no_error(gl, "glGetProgramPipelineiv have failed")?;

        if value == -1 {
            log::info!(
                "glGetProgramPipelineiv with parameter {pname} has not returned anything and error has not been generated."
            );
            return Ok(false);
        }
        if expected_value != value {
            log::info!(
                "glGetProgramPipelineiv with parameter {pname} has returned {value}, however {expected_value} was expected."
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// `testProgramPipelineInfoLog` with a null `expected_value`
    fn test_program_pipeline_info_log(gl: &glw::Functions, pipeline: glw::GLuint) -> Result<bool, TestError> {
        const MAX_LOG_SIZE: usize = 4096;
        let mut log = [0u8; MAX_LOG_SIZE];
        let mut log_size: glw::GLsizei = 0;

        // SAFETY: the log is written to a buffer of the size passed.
        unsafe {
            gl.get_program_pipeline_info_log(
                pipeline,
                MAX_LOG_SIZE as glw::GLsizei,
                &mut log_size,
                log.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glGetProgramPipelineInfoLog have failed")?;

        if log_size != 0 {
            log::info!(
                "glGetProgramPipelineInfoLog returned unexpectedly non-empty string: {}.",
                String::from_utf8_lossy(&log).trim_end_matches('\0')
            );
            return Ok(false);
        }
        Ok(true)
    }
}

impl TestCase for ProgramPipelinesDefaultsTest {
    fn name(&self) -> &str {
        "program_pipelines_defaults"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut program_pipeline_dsa: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: one name is written to the live local.
            unsafe { gl.create_program_pipelines(1, &mut program_pipeline_dsa) };
            glu::expect_no_error(gl, "glCreateProgramPipelines have failed")?;

            let pipeline = program_pipeline_dsa;
            for pname in [
                glw::GL_ACTIVE_PROGRAM,
                glw::GL_VERTEX_SHADER,
                glw::GL_GEOMETRY_SHADER,
                glw::GL_FRAGMENT_SHADER,
                glw::GL_COMPUTE_SHADER,
                glw::GL_TESS_CONTROL_SHADER,
                glw::GL_TESS_EVALUATION_SHADER,
                glw::GL_VALIDATE_STATUS,
                glw::GL_INFO_LOG_LENGTH,
            ] {
                is_ok &= Self::test_program_pipeline_parameter(gl, pipeline, pname, 0)?;
            }
            is_ok &= Self::test_program_pipeline_info_log(gl, pipeline)?;
            Ok(is_ok)
        });

        if program_pipeline_dsa != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_program_pipelines(1, &program_pipeline_dsa) };
        }
        outcome
    }
}

/// `ProgramPipelines::ErrorsTest`
struct ProgramPipelinesErrorsTest;

impl TestCase for ProgramPipelinesErrorsTest {
    fn name(&self) -> &str {
        "program_pipelines_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut program_pipeline_dsa: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: a negative count is the error this call is expected to generate; nothing is written.
            unsafe { gl.create_program_pipelines(-1, &mut program_pipeline_dsa) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_INVALID_VALUE {
                is_ok = false;
                log::info!(
                    "CreateProgramPipelines has not generated INVALID_VALUE error when callded with negative number of objects to be created.Instead, {} error value was generated.",
                    glw::error_name(error)
                );
            }
            Ok(is_ok)
        });

        if program_pipeline_dsa != 0 {
            // SAFETY: deletes a name the driver wrote despite the error.
            unsafe { gl.delete_program_pipelines(1, &program_pipeline_dsa) };
        }
        outcome
    }
}

/// `ProgramPipelines::FunctionalTest`
struct ProgramPipelinesFunctionalTest;

impl ProgramPipelinesFunctionalTest {
    const VERTEX_SHADER: &'static str = "#version 450\n\nout gl_PerVertex\n{\n    vec4  gl_Position;\n    float gl_PointSize;\n    float gl_ClipDistance[];\n};\n\nvoid main()\n{\n    switch(gl_VertexID)\n    {\n        case 0:\n            gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n            break;\n        case 1:\n            gl_Position = vec4( 1.0, 1.0, 0.0, 1.0);\n            break;\n        case 2:\n            gl_Position = vec4(-1.0,-1.0, 0.0, 1.0);\n            break;\n        case 3:\n            gl_Position = vec4( 1.0,-1.0, 0.0, 1.0);\n            break;\n    }\n}\n";
    const FRAGMENT_SHADER: &'static str =
        "#version 450\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";

    /// `prepareShaderPrograms` for one stage: `glCreateShaderProgramv`, then validation.
    fn prepare_shader_program(
        gl: &glw::Functions,
        stage: glw::GLenum,
        source: &str,
        what: &str,
    ) -> Result<glw::GLuint, TestError> {
        const MAX_LOG_SIZE: usize = 4096;
        let source = CString::new(source).expect("no NUL in the source");
        let source_ptr = source.as_ptr();

        // SAFETY: one NUL-terminated string.
        let program = unsafe { gl.create_shader_programv(stage, 1, &source_ptr) };
        glu::expect_no_error(gl, "glCreateShaderProgramv call failed.")?;
        if program == 0 {
            return Err(TestError::Fail("throw 0".to_string()));
        }

        let mut status = glw::GL_TRUE as glw::GLint;
        // SAFETY: a live program; the status is written to a live local.
        unsafe {
            gl.validate_program(program);
            glu::expect_no_error(gl, "glValidateProgram call failed.")?;
            gl.get_programiv(program, glw::GL_VALIDATE_STATUS, &mut status);
        }
        glu::expect_no_error(gl, "glGetProgramiv call failed.")?;

        if status == glw::GL_FALSE as glw::GLint {
            let mut log = [0u8; MAX_LOG_SIZE];
            let mut log_size: glw::GLsizei = 0;
            // SAFETY: the log is written to a buffer of the size passed.
            unsafe {
                gl.get_program_info_log(
                    program,
                    MAX_LOG_SIZE as glw::GLsizei,
                    &mut log_size,
                    log.as_mut_ptr().cast(),
                )
            };
            glu::expect_no_error(gl, "glGetProgramInfoLog call failed.")?;
            log::info!(
                "{what} shader program building failed with log: {}",
                String::from_utf8_lossy(&log).trim_end_matches('\0')
            );
            // The program is deleted by the caller's guard only when it is stored, so delete it here.
            // SAFETY: a program created above.
            unsafe { gl.delete_program(program) };
            return Err(TestError::Fail("throw 0".to_string()));
        }
        Ok(program)
    }
}

/// The objects of `FunctionalTest` (`m_fbo`, `m_rbo`, `m_vao`, `m_spo_v`, `m_spo_f`, `m_ppo`), released by `clean()`.
struct ProgramPipelinesFunctionalObjects<'gl> {
    gl: &'gl glw::Functions,
    fbo: glw::GLuint,
    rbo: glw::GLuint,
    vao: glw::GLuint,
    spo_v: glw::GLuint,
    spo_f: glw::GLuint,
    ppo: glw::GLuint,
}

impl Drop for ProgramPipelinesFunctionalObjects<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes only names this guard holds; zero names are skipped.
        unsafe {
            if self.fbo != 0 {
                self.gl.delete_framebuffers(1, &self.fbo);
            }
            if self.rbo != 0 {
                self.gl.delete_renderbuffers(1, &self.rbo);
            }
            if self.vao != 0 {
                self.gl.delete_vertex_arrays(1, &self.vao);
            }
            if self.spo_v != 0 {
                self.gl.delete_program(self.spo_v);
            }
            if self.spo_f != 0 {
                self.gl.delete_program(self.spo_f);
            }
            if self.ppo != 0 {
                self.gl.bind_program_pipeline(0);
                self.gl.delete_program_pipelines(1, &self.ppo);
            }
        }
    }
}

impl TestCase for ProgramPipelinesFunctionalTest {
    fn name(&self) -> &str {
        "program_pipelines_functional"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = ProgramPipelinesFunctionalObjects {
            gl,
            fbo: 0,
            rbo: 0,
            vao: 0,
            spo_v: 0,
            spo_f: 0,
            ppo: 0,
        };

        dsa_outcome(|| {
            // prepareFramebuffer
            // SAFETY: names are written to live fields; a 1x1 RGBA8 renderbuffer is attached.
            unsafe {
                gl.gen_framebuffers(1, &mut objects.fbo);
                glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
                gl.gen_renderbuffers(1, &mut objects.rbo);
                glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo);
                glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbo);
                glu::expect_no_error(gl, "glBindRenderbuffer call failed.")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage call failed.")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    objects.rbo,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer call failed.")?;
                if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    return Err(TestError::Fail("throw 0".to_string()));
                }
                gl.viewport(0, 0, 1, 1);
                glu::expect_no_error(gl, "glViewport call failed.")?;
                gl.clear_color(0.0, 0.0, 0.0, 0.0);
                glu::expect_no_error(gl, "glClearColor call failed.")?;
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                glu::expect_no_error(gl, "glClear call failed.")?;
            }

            // prepareVertexArrayObject
            // SAFETY: a name is written to the live field, then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut objects.vao);
                glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
                gl.bind_vertex_array(objects.vao);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            }

            // prepareShaderPrograms
            objects.spo_v = Self::prepare_shader_program(gl, glw::GL_VERTEX_SHADER, Self::VERTEX_SHADER, "Vertex")?;
            objects.spo_f =
                Self::prepare_shader_program(gl, glw::GL_FRAGMENT_SHADER, Self::FRAGMENT_SHADER, "Fragment")?;

            // preparePipeline
            // SAFETY: a pipeline created and bound here, with the two programs created above.
            unsafe {
                gl.create_program_pipelines(1, &mut objects.ppo);
                glu::expect_no_error(gl, "glCreateProgramPipelines call failed.")?;
                gl.bind_program_pipeline(objects.ppo);
                glu::expect_no_error(gl, "glBindProgramPipeline call failed.")?;
                gl.use_program_stages(objects.ppo, glw::GL_VERTEX_SHADER_BIT, objects.spo_v);
                glu::expect_no_error(gl, "glUseProgramStages call failed.")?;
                gl.use_program_stages(objects.ppo, glw::GL_FRAGMENT_SHADER_BIT, objects.spo_f);
                glu::expect_no_error(gl, "glUseProgramStages call failed.")?;
            }

            // draw
            // SAFETY: plain draw into the framebuffer prepared above.
            unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
            glu::expect_no_error(gl, "glDrawArrays have failed")?;

            // checkFramebufferContent
            let mut pixel = [0u8; 4];
            // SAFETY: one RGBA pixel is written to the live array.
            unsafe {
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    pixel.as_mut_ptr().cast(),
                )
            };
            glu::expect_no_error(gl, "glReadPixels have failed")?;
            if pixel != [255, 0, 0, 255] {
                log::info!(
                    "Frameuffer content ({}, {}, {}, {}) is different than expected (255, 0, 0, 255).",
                    pixel[0],
                    pixel[1],
                    pixel[2],
                    pixel[3]
                );
                return Ok(false);
            }
            Ok(true)
        })
    }
}

// ------------------------------------------------------------------------------------------------------------------
// Queries

const QUERY_TARGETS: [(glw::GLenum, &str); 7] = [
    (glw::GL_SAMPLES_PASSED, "GL_SAMPLES_PASSED"),
    (glw::GL_ANY_SAMPLES_PASSED, "GL_ANY_SAMPLES_PASSED"),
    (
        glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE,
        "GL_ANY_SAMPLES_PASSED_CONSERVATIVE",
    ),
    (glw::GL_TIME_ELAPSED, "GL_TIME_ELAPSED"),
    (glw::GL_TIMESTAMP, "GL_TIMESTAMP"),
    (glw::GL_PRIMITIVES_GENERATED, "GL_PRIMITIVES_GENERATED"),
    (
        glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
        "GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN",
    ),
];

/// `Queries::CreationTest`
struct QueriesCreationTest;

impl TestCase for QueriesCreationTest {
    fn name(&self) -> &str {
        "queries_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const QUERIES_COUNT: usize = 2;
        let gl = context.gl();
        let mut queries_legacy = [0 as glw::GLuint; QUERIES_COUNT];
        let mut queries_dsa = [[0 as glw::GLuint; QUERIES_COUNT]; QUERY_TARGETS.len()];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: QUERIES_COUNT names are written to the live array.
            unsafe { gl.gen_queries(QUERIES_COUNT as glw::GLsizei, queries_legacy.as_mut_ptr()) };
            glu::expect_no_error(gl, "glGenQueries have failed")?;

            for query in &queries_legacy {
                // SAFETY: plain query.
                if unsafe { gl.is_query(*query) } != 0 {
                    is_ok = false;
                    log::info!("GenQueries has created default objects, but it should create only a names.");
                }
            }

            for ((target, _), queries) in QUERY_TARGETS.iter().zip(queries_dsa.iter_mut()) {
                // SAFETY: QUERIES_COUNT names are written to the live array.
                unsafe { gl.create_queries(*target, QUERIES_COUNT as glw::GLsizei, queries.as_mut_ptr()) };
                glu::expect_no_error(gl, "glCreateQueries have failed")?;

                for query in queries.iter() {
                    // SAFETY: plain query.
                    if unsafe { gl.is_query(*query) } == 0 {
                        is_ok = false;
                        log::info!("CreateQueries has not created default objects.");
                    }
                }
            }
            Ok(is_ok)
        });

        for query in queries_legacy.iter().chain(queries_dsa.iter().flatten()) {
            if *query != 0 {
                // SAFETY: deletes a name generated above.
                unsafe { gl.delete_queries(1, query) };
            }
        }
        outcome
    }
}

/// `Queries::DefaultsTest`
struct QueriesDefaultsTest;

impl QueriesDefaultsTest {
    /// `testQueryParameter`
    fn test_query_parameter(
        gl: &glw::Functions,
        query: glw::GLuint,
        pname: glw::GLenum,
        expected_value: glw::GLuint,
        target_name: &str,
    ) -> Result<bool, TestError> {
        let mut value: glw::GLuint = 0;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_query_objectuiv(query, pname, &mut value) };
        glu::expect_no_error(gl, "glGetQueryObjectuiv have failed")?;

        if expected_value != value {
            log::info!(
                "glGetQueryObjectuiv of query object with target {target_name} with parameter {pname} has returned {value}, however {expected_value} was expected."
            );
            return Ok(false);
        }
        Ok(true)
    }
}

impl TestCase for QueriesDefaultsTest {
    fn name(&self) -> &str {
        "queries_defaults"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut query_dsa: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            for (target, target_name) in QUERY_TARGETS {
                // prepare
                // SAFETY: one name is written to the live local.
                unsafe { gl.create_queries(target, 1, &mut query_dsa) };
                glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;

                is_ok &= Self::test_query_parameter(gl, query_dsa, glw::GL_QUERY_RESULT, glw::GL_FALSE, target_name)?;
                is_ok &= Self::test_query_parameter(
                    gl,
                    query_dsa,
                    glw::GL_QUERY_RESULT_AVAILABLE,
                    glw::GL_TRUE,
                    target_name,
                )?;

                // clean
                // SAFETY: deletes the name created above.
                unsafe { gl.delete_queries(1, &query_dsa) };
                query_dsa = 0;
            }
            Ok(is_ok)
        });

        if query_dsa != 0 {
            // SAFETY: deletes a name left behind by a failed iteration.
            unsafe { gl.delete_queries(1, &query_dsa) };
        }
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------
// Transform feedback

/// `TransformFeedback::CreationTest`
struct XfbCreationTest;

impl TestCase for XfbCreationTest {
    fn name(&self) -> &str {
        "xfb_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const XFB_COUNT: usize = 2;
        let gl = context.gl();
        let mut xfb_dsa = [0 as glw::GLuint; XFB_COUNT];
        let mut xfb_legacy = [0 as glw::GLuint; XFB_COUNT];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: plain state change.
            unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0) };
            glu::expect_no_error(gl, "glBindTransformFeedback have failed")?;

            // SAFETY: XFB_COUNT names are written to the live array.
            unsafe { gl.gen_transform_feedbacks(XFB_COUNT as glw::GLsizei, xfb_legacy.as_mut_ptr()) };
            glu::expect_no_error(gl, "glGenTransformFeedbacks have failed")?;

            for xfb in &xfb_legacy {
                // SAFETY: plain query.
                if unsafe { gl.is_transform_feedback(*xfb) } != 0 {
                    is_ok = false;
                    log::info!(
                        "GenTransformFeedbacks has created defualt objects, but only shall reserve names for them."
                    );
                }
            }

            // SAFETY: XFB_COUNT names are written to the live array.
            unsafe { gl.create_transform_feedbacks(XFB_COUNT as glw::GLsizei, xfb_dsa.as_mut_ptr()) };
            glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;

            for xfb in &xfb_dsa {
                // SAFETY: plain query.
                if unsafe { gl.is_transform_feedback(*xfb) } == 0 {
                    is_ok = false;
                    log::info!("CreateTransformFeedbacks has not created defualt objects.");
                }
            }

            let mut xfb_binding_point: glw::GLint = -1;
            // SAFETY: the value is written to a live local.
            unsafe { gl.get_integerv(glw::GL_TRANSFORM_FEEDBACK_BINDING, &mut xfb_binding_point) };
            glu::expect_no_error(gl, "glGetIntegerv have failed")?;

            if xfb_binding_point != 0 {
                if xfb_binding_point == -1 {
                    log::info!(
                        "glGetIntegerv used with GL_TRANSFORM_FEEDBACK_BINDING have not returned anything and did not generate error."
                    );
                    return Err(TestError::Fail("throw 0".to_string()));
                }
                log::info!(
                    "The usage of glCreateTransformFeedbacks have changed GL_TRANSFORM_FEEDBACK_BINDING binding point."
                );
                is_ok = false;
            }
            Ok(is_ok)
        });

        for xfb in xfb_legacy.iter().chain(&xfb_dsa) {
            if *xfb != 0 {
                // SAFETY: deletes a name generated above.
                unsafe { gl.delete_transform_feedbacks(1, xfb) };
            }
        }
        outcome
    }
}

/// `TransformFeedback::DefaultsTest`
struct XfbDefaultsTest;

impl XfbDefaultsTest {
    /// `testBuffersBindingPoints`
    fn test_buffers_binding_points(
        gl: &glw::Functions,
        xfb: glw::GLuint,
        count: glw::GLint,
    ) -> Result<bool, TestError> {
        for i in 0..count {
            let mut buffer_binding: glw::GLint = -1;
            // SAFETY: the value is written to a live local.
            unsafe {
                gl.get_transform_feedbacki_v(
                    xfb,
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING,
                    i as glw::GLuint,
                    &mut buffer_binding,
                )
            };
            glu::expect_no_error(gl, "glGetTransformFeedbacki_v have failed")?;

            if buffer_binding == -1 {
                log::info!(
                    "glGetTransformFeedbacki_v with parameter GL_TRANSFORM_FEEDBACK_BUFFER_BINDING has not returned anything and error has not been generated."
                );
                return Ok(false);
            }
            if buffer_binding != 0 {
                log::info!(
                    "glGetTransformFeedbacki_v with parameter GL_TRANSFORM_FEEDBACK_BUFFER_BINDING has returned {buffer_binding}, however 0 is expected."
                );
                return Ok(false);
            }
        }
        Ok(true)
    }

    /// `testBuffersDimensions`
    fn test_buffers_dimensions(gl: &glw::Functions, xfb: glw::GLuint, count: glw::GLint) -> Result<bool, TestError> {
        for (pname, name) in [
            (
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_START,
                "GL_TRANSFORM_FEEDBACK_BUFFER_START",
            ),
            (
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_SIZE,
                "GL_TRANSFORM_FEEDBACK_BUFFER_SIZE",
            ),
        ] {
            for i in 0..count {
                let mut value: glw::GLint64 = -1;
                // SAFETY: the value is written to a live local.
                unsafe { gl.get_transform_feedbacki_64_v(xfb, pname, i as glw::GLuint, &mut value) };
                glu::expect_no_error(gl, "glGetTransformFeedbacki_v have failed")?;

                if value == -1 {
                    log::info!(
                        "glGetTransformFeedbacki_v with parameter {name} has not returned anything and error has not been generated."
                    );
                    return Ok(false);
                }
                if value != 0 {
                    log::info!(
                        "glGetTransformFeedbacki_v with parameter {name} has returned {value}, however 0 is expected."
                    );
                    return Ok(false);
                }
            }
        }
        Ok(true)
    }

    /// `testActive` and `testPaused`
    fn test_flag(gl: &glw::Functions, xfb: glw::GLuint, pname: glw::GLenum, name: &str) -> bool {
        let mut value: glw::GLint = -1;
        // SAFETY: the value is written to a live local; upstream does not check for an error here.
        unsafe { gl.get_transform_feedbackiv(xfb, pname, &mut value) };

        if value == -1 {
            log::info!(
                "glGetTransformFeedbackiv with parameter {name} has not returned anything and error has not been generated."
            );
            return false;
        }
        if value != 0 {
            log::info!(
                "glGetTransformFeedbackiv with parameter {name} has returned {value}, however FALSE is expected."
            );
            return false;
        }
        true
    }
}

impl TestCase for XfbDefaultsTest {
    fn name(&self) -> &str {
        "xfb_defaults"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut xfb_dsa: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // prepare
            if gl.get_transform_feedbackiv.is_none()
                || gl.get_transform_feedbacki_v.is_none()
                || gl.get_transform_feedbacki_64_v.is_none()
            {
                log::info!("Function pointers are set to NULL values.");
                return Err(TestError::Fail("throw 0".to_string()));
            }

            // SAFETY: one name is written to the live local.
            unsafe { gl.create_transform_feedbacks(1, &mut xfb_dsa) };
            glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;

            let mut count: glw::GLint = 0;
            // SAFETY: the value is written to a live local.
            unsafe { gl.get_integerv(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS, &mut count) };
            glu::expect_no_error(gl, "glIntegerv have failed")?;

            let xfb = xfb_dsa;
            is_ok &= Self::test_buffers_binding_points(gl, xfb, count)?;
            is_ok &= Self::test_buffers_dimensions(gl, xfb, count)?;
            is_ok &= Self::test_flag(
                gl,
                xfb,
                glw::GL_TRANSFORM_FEEDBACK_ACTIVE,
                "GL_TRANSFORM_FEEDBACK_ACTIVE",
            );
            is_ok &= Self::test_flag(
                gl,
                xfb,
                glw::GL_TRANSFORM_FEEDBACK_PAUSED,
                "GL_TRANSFORM_FEEDBACK_PAUSED",
            );
            Ok(is_ok)
        });

        if xfb_dsa != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_transform_feedbacks(1, &xfb_dsa) };
        }
        outcome
    }
}

/// `TransformFeedback::BuffersTest`
struct XfbBuffersTest;

impl XfbBuffersTest {
    const BO_SIZE: glw::GLuint = 512;

    /// `testBindingPoint`
    fn test_binding_point(
        gl: &glw::Functions,
        xfb: glw::GLuint,
        index: glw::GLuint,
        expected_value: glw::GLint,
        tested_function_name: &str,
    ) -> Result<bool, TestError> {
        let mut buffer_binding: glw::GLint = -1;
        // SAFETY: the value is written to a live local.
        unsafe {
            gl.get_transform_feedbacki_v(
                xfb,
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING,
                index,
                &mut buffer_binding,
            )
        };
        glu::expect_no_error(gl, "glGetTransformFeedbacki_v have failed")?;

        if buffer_binding == -1 {
            log::info!(
                "glGetTransformFeedbacki_v with parameter GL_TRANSFORM_FEEDBACK_BUFFER_BINDING has not returned anything and error has not been generated."
            );
            return Ok(false);
        }
        if expected_value != buffer_binding {
            log::info!(
                "glGetTransformFeedbacki_v with parameter GL_TRANSFORM_FEEDBACK_BUFFER_BINDING has returned {buffer_binding}, however {expected_value} is expected. As a consequence function {tested_function_name} have failed to setup proper value."
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// `testStart` (`GL_TRANSFORM_FEEDBACK_BUFFER_START`) and `testSize` (`GL_TRANSFORM_FEEDBACK_BUFFER_SIZE`)
    fn test_dimension(
        gl: &glw::Functions,
        xfb: glw::GLuint,
        pname: glw::GLenum,
        pname_name: &str,
        index: glw::GLuint,
        expected_value: glw::GLint,
        tested_function_name: &str,
    ) -> Result<bool, TestError> {
        let mut value: glw::GLint64 = -1;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_transform_feedbacki_64_v(xfb, pname, index, &mut value) };
        glu::expect_no_error(gl, "glGetTransformFeedbacki_v have failed")?;

        if value == -1 {
            log::info!(
                "glGetTransformFeedbacki_v with parameter {pname_name} has not returned anything and error has not been generated."
            );
            return Ok(false);
        }
        if glw::GLint64::from(expected_value) != value {
            log::info!(
                "glGetTransformFeedbacki_v with parameter {pname_name} has returned {value}, however {expected_value} is expected. As a consequence function {tested_function_name} have failed to setup proper value."
            );
            return Ok(false);
        }
        Ok(true)
    }
}

impl TestCase for XfbBuffersTest {
    fn name(&self) -> &str {
        "xfb_buffers"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (mut xfb_dsa, mut bo_a, mut bo_b): (glw::GLuint, glw::GLuint, glw::GLuint) = (0, 0, 0);
        let bo_size = Self::BO_SIZE as glw::GLint;

        let outcome = dsa_outcome(|| {
            let mut is_ok;

            // prepareObjects
            if gl.get_transform_feedbacki_v.is_none()
                || gl.get_transform_feedbacki_64_v.is_none()
                || gl.transform_feedback_buffer_base.is_none()
                || gl.transform_feedback_buffer_range.is_none()
            {
                log::info!("Function pointers are set to NULL values.");
                return Err(TestError::Fail("throw 0".to_string()));
            }

            // SAFETY: one name is written to the live local.
            unsafe { gl.create_transform_feedbacks(1, &mut xfb_dsa) };
            glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;

            // SAFETY: one name is written to each live local.
            unsafe {
                gl.gen_buffers(1, &mut bo_a);
                gl.gen_buffers(1, &mut bo_b);
            }
            glu::expect_no_error(gl, "glGenBuffers have failed")?;
            if bo_a == 0 || bo_b == 0 {
                log::info!("Buffer object has not been generated and no error has been triggered.");
                return Err(TestError::Fail("throw 0".to_string()));
            }

            for buffer in [bo_a, bo_b] {
                // SAFETY: a buffer generated above; no initial data.
                unsafe { gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buffer) };
                glu::expect_no_error(gl, "glBindBuffers have failed")?;
                // SAFETY: as above.
                unsafe {
                    gl.buffer_data(
                        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                        Self::BO_SIZE as glw::GLsizeiptr,
                        std::ptr::null(),
                        glw::GL_DYNAMIC_COPY,
                    )
                };
                glu::expect_no_error(gl, "glBufferData have failed")?;

                let mut allocated_size: glw::GLint = -1;
                // SAFETY: the value is written to a live local.
                unsafe {
                    gl.get_buffer_parameteriv(
                        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                        glw::GL_BUFFER_SIZE,
                        &mut allocated_size,
                    )
                };
                glu::expect_no_error(gl, "glGetBufferParameteriv have failed")?;
                if allocated_size != bo_size {
                    log::info!("Buffer allocation failed.");
                    return Err(TestError::Fail("throw 0".to_string()));
                }
            }
            // SAFETY: plain state change.
            unsafe { gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0) };
            glu::expect_no_error(gl, "glBindBuffers have failed")?;

            // prepareTestSetup
            // SAFETY: the transform feedback object and both buffers are alive; the ranges lie inside the buffers.
            unsafe { gl.transform_feedback_buffer_base(xfb_dsa, 0, bo_a) };
            // SAFETY: plain state query.
            let error_value = unsafe { gl.get_error() };
            if error_value != glw::GL_NONE {
                log::info!(
                    "glTransformFeedbackBufferBase has generated unexpected error ({}). Test Failed.",
                    glw::error_name(error_value)
                );
                return Ok(false);
            }

            // SAFETY: as above.
            unsafe {
                gl.transform_feedback_buffer_range(
                    xfb_dsa,
                    1,
                    bo_b,
                    0,
                    glw::GLsizeiptr::try_from(Self::BO_SIZE / 2).expect("small"),
                );
                gl.transform_feedback_buffer_range(
                    xfb_dsa,
                    2,
                    bo_b,
                    glw::GLintptr::try_from(Self::BO_SIZE / 2).expect("small"),
                    glw::GLsizeiptr::try_from(Self::BO_SIZE / 2).expect("small"),
                );
            }
            // SAFETY: plain state query.
            let error_value = unsafe { gl.get_error() };
            if error_value != glw::GL_NONE {
                log::info!(
                    "glTransformFeedbackBufferRange has generated unexpected error ({}). Test Failed.",
                    glw::error_name(error_value)
                );
                return Ok(false);
            }
            is_ok = true;

            const START: (glw::GLenum, &str) = (
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_START,
                "GL_TRANSFORM_FEEDBACK_BUFFER_START",
            );
            const SIZE: (glw::GLenum, &str) = (
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_SIZE,
                "GL_TRANSFORM_FEEDBACK_BUFFER_SIZE",
            );
            let (base, range) = ("glTransformFeedbackBufferBase", "glTransformFeedbackBufferRange");
            let half = bo_size / 2;
            let xfb = xfb_dsa;

            is_ok &= Self::test_binding_point(gl, xfb, 0, bo_a as glw::GLint, base)?;
            is_ok &= Self::test_binding_point(gl, xfb, 1, bo_b as glw::GLint, range)?;
            is_ok &= Self::test_binding_point(gl, xfb, 2, bo_b as glw::GLint, range)?;
            is_ok &= Self::test_dimension(gl, xfb, START.0, START.1, 0, 0, base)?;
            is_ok &= Self::test_dimension(gl, xfb, START.0, START.1, 1, 0, range)?;
            is_ok &= Self::test_dimension(gl, xfb, START.0, START.1, 2, half, range)?;
            is_ok &= Self::test_dimension(gl, xfb, SIZE.0, SIZE.1, 0, 0, base)?;
            is_ok &= Self::test_dimension(gl, xfb, SIZE.0, SIZE.1, 1, half, range)?;
            is_ok &= Self::test_dimension(gl, xfb, SIZE.0, SIZE.1, 2, half, range)?;
            Ok(is_ok)
        });

        // SAFETY: deletes only names created above; zero names are skipped.
        unsafe {
            if xfb_dsa != 0 {
                gl.delete_transform_feedbacks(1, &xfb_dsa);
            }
            if bo_a != 0 {
                gl.delete_buffers(1, &bo_a);
            }
            if bo_b != 0 {
                gl.delete_buffers(1, &bo_b);
            }
        }
        outcome
    }
}

/// `TransformFeedback::ErrorsTest::cleanErrors`
pub(super) fn clean_errors(gl: &glw::Functions) {
    // SAFETY: plain state queries.
    while unsafe { gl.get_error() } != glw::GL_NO_ERROR {}
}

/// The checks every `ErrorsTest` query test makes after the call: the expected error, the output left untouched, and a warning for each further error. Upstream's invalid-name test returns before it drains the extra errors on a failure; the caller's `clean_errors` drains them there instead.
fn check_query_call<T: PartialEq>(
    gl: &glw::Functions,
    function_name: &str,
    what: &str,
    expected_error: glw::GLenum,
    value: T,
    sentinel: T,
    more_than_one_error_warning: &str,
) -> (bool, bool) {
    // SAFETY: plain state query.
    let error = unsafe { gl.get_error() };
    let mut error_ok = true;
    if error != expected_error {
        log::info!(
            "{function_name} called with {what} had been expected to generate {}. However, {} was captured.",
            glw::error_name(expected_error),
            glw::error_name(error)
        );
        error_ok = false;
    }
    let value_ok = value == sentinel;
    if !value_ok {
        log::info!("{function_name} called with {what} had been expected not to change the given buffer.");
    }
    loop {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error == glw::GL_NO_ERROR {
            break;
        }
        log::info!(
            "Warning! {function_name} called with {what} {more_than_one_error_warning}, The next error was  {}.",
            glw::error_name(error)
        );
    }
    (error_ok, value_ok)
}

/// `TransformFeedback::ErrorsTest`
struct XfbErrorsTest;

impl XfbErrorsTest {
    /// `testCreateTransformFeedbacksForInvalidNumberOfObjects`
    fn test_create_for_invalid_number_of_objects(gl: &glw::Functions) -> bool {
        let mut xfbs: glw::GLuint = 314159;
        // SAFETY: a negative count is the error this call is expected to generate; nothing is written.
        unsafe { gl.create_transform_feedbacks(-1, &mut xfbs) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_INVALID_VALUE {
            log::info!(
                "glCreateTransformFeedbacks called with negative number of objects had been expected to generate GL_INVALID_VALUE. However, {} was captured.",
                glw::error_name(error)
            );
            return false;
        }
        if xfbs != 314159 {
            log::info!(
                "glCreateTransformFeedbacks called with negative number of objects had been expected not to change the given buffer."
            );
            return false;
        }
        true
    }

    /// `testQueriesForInvalidNameOfObject`
    fn test_queries_for_invalid_name_of_object(gl: &glw::Functions) -> bool {
        let mut invalid_name: glw::GLuint = 0;
        loop {
            invalid_name += 1;
            // SAFETY: plain query.
            if unsafe { gl.is_transform_feedback(invalid_name) } != glw::GL_TRUE as glw::GLboolean {
                break;
            }
        }

        let mut buffer: glw::GLint = 314159;
        let mut buffer64: glw::GLint64 = 314159;
        let warning = "has generated more than one error";

        // SAFETY: the output is a live local; the call is expected to fail validation.
        unsafe { gl.get_transform_feedbackiv(invalid_name, glw::GL_TRANSFORM_FEEDBACK_PAUSED, &mut buffer) };
        let (error_ok, value_ok) = check_query_call(
            gl,
            "glGetTransformFeedbackiv",
            "invalid object name",
            glw::GL_INVALID_OPERATION,
            buffer,
            314159,
            warning,
        );
        if !error_ok || !value_ok {
            return false;
        }

        // SAFETY: as above.
        unsafe {
            gl.get_transform_feedbacki_v(invalid_name, glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, 0, &mut buffer)
        };
        let (error_ok, value_ok) = check_query_call(
            gl,
            "glGetTransformFeedbacki_v",
            "invalid object name",
            glw::GL_INVALID_OPERATION,
            buffer,
            314159,
            "has unexpectedly generated more than one error",
        );
        if !error_ok || !value_ok {
            return false;
        }

        // SAFETY: as above.
        unsafe {
            gl.get_transform_feedbacki_64_v(invalid_name, glw::GL_TRANSFORM_FEEDBACK_BUFFER_START, 0, &mut buffer64)
        };
        let (error_ok, value_ok) = check_query_call(
            gl,
            "glGetTransformFeedbacki64_v",
            "invalid object name",
            glw::GL_INVALID_OPERATION,
            buffer64,
            314159,
            "has unexpectedly generated more than one error",
        );
        error_ok && value_ok
    }

    /// The three `test*QueryForInvalidParameterName` tests: `query` makes the call with parameter name 0 on a fresh object and returns whether the output stayed untouched.
    fn test_query_for_invalid_parameter_name(
        gl: &glw::Functions,
        function_name: &str,
        warning: &str,
        query: impl FnOnce(glw::GLuint) -> bool,
    ) -> Result<bool, TestError> {
        let mut xfb: glw::GLuint = 0;
        // SAFETY: one name is written to the live local.
        unsafe { gl.create_transform_feedbacks(1, &mut xfb) };
        glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;

        let value_untouched = query(xfb);
        // The call is already made; reuse the checks of the other tests with the outcome of the comparison.
        let (error_ok, value_ok) = check_query_call(
            gl,
            function_name,
            "invalid parameter name",
            glw::GL_INVALID_ENUM,
            value_untouched,
            true,
            warning,
        );

        // SAFETY: deletes the name created above.
        unsafe { gl.delete_transform_feedbacks(1, &xfb) };
        glu::expect_no_error(gl, "glDeleteTransformFeedbacks have failed")?;
        Ok(error_ok && value_ok)
    }

    /// `testIndexedQueriesForInvalidBindingPoint`
    fn test_indexed_queries_for_invalid_binding_point(gl: &glw::Functions) -> Result<bool, TestError> {
        // Default limit is 4 - OpenGL 4.5 Core Specification, Table 23.72: Implementation Dependent Transform Feedback Limits.
        let mut max_transform_feedback_buffers: glw::GLint = 4;
        // SAFETY: the value is written to a live local.
        unsafe {
            gl.get_integerv(
                glw::GL_MAX_TRANSFORM_FEEDBACK_BUFFERS,
                &mut max_transform_feedback_buffers,
            )
        };
        glu::expect_no_error(gl, "glGetIntegerv have failed")?;

        let mut xfb: glw::GLuint = 0;
        // SAFETY: one name is written to the live local.
        unsafe { gl.create_transform_feedbacks(1, &mut xfb) };
        glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;

        let mut buffer: glw::GLint = 314159;
        let mut buffer64: glw::GLint64 = 314159;
        let mut is_ok = true;
        let warning = "has unexpectedly generated more than one error";

        // SAFETY: the output is a live local; the index is out of range on purpose.
        unsafe {
            gl.get_transform_feedbacki_v(
                xfb,
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING,
                max_transform_feedback_buffers as glw::GLuint,
                &mut buffer,
            )
        };
        let (error_ok, value_ok) = check_query_call(
            gl,
            "glGetTransformFeedbacki_v",
            "invalid index",
            glw::GL_INVALID_VALUE,
            buffer,
            314159,
            warning,
        );
        is_ok &= error_ok && value_ok;

        // SAFETY: as above.
        unsafe {
            gl.get_transform_feedbacki_64_v(
                xfb,
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_START,
                max_transform_feedback_buffers as glw::GLuint,
                &mut buffer64,
            )
        };
        let (error_ok, value_ok) = check_query_call(
            gl,
            "glGetTransformFeedbacki64_v",
            "invalid index",
            glw::GL_INVALID_VALUE,
            buffer64,
            314159,
            warning,
        );
        is_ok &= error_ok && value_ok;

        // SAFETY: deletes the name created above.
        unsafe { gl.delete_transform_feedbacks(1, &xfb) };
        glu::expect_no_error(gl, "glDeleteTransformFeedbacks have failed")?;
        Ok(is_ok)
    }
}

impl TestCase for XfbErrorsTest {
    fn name(&self) -> &str {
        "xfb_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        dsa_outcome(|| {
            let mut is_ok = true;

            // prepareFunctionPointers
            if gl.get_transform_feedbackiv.is_none()
                || gl.get_transform_feedbacki_v.is_none()
                || gl.get_transform_feedbacki_64_v.is_none()
            {
                log::info!("Function pointers are set to NULL values.");
                return Err(TestError::Fail("throw 0".to_string()));
            }

            is_ok &= Self::test_create_for_invalid_number_of_objects(gl);
            clean_errors(gl);
            is_ok &= Self::test_queries_for_invalid_name_of_object(gl);
            clean_errors(gl);

            let mut buffer: glw::GLint = 314159;
            is_ok &= Self::test_query_for_invalid_parameter_name(
                gl,
                "glGetTransformFeedbackiv",
                "has generated more than one error",
                |xfb| {
                    // SAFETY: the output is a live local; the parameter name is invalid on purpose.
                    unsafe { gl.get_transform_feedbackiv(xfb, 0, &mut buffer) };
                    buffer == 314159
                },
            )?;
            clean_errors(gl);

            let mut buffer: glw::GLint = 314159;
            is_ok &= Self::test_query_for_invalid_parameter_name(
                gl,
                "glGetTransformFeedbacki_v",
                "has generated more than one error",
                |xfb| {
                    // SAFETY: as above.
                    unsafe { gl.get_transform_feedbacki_v(xfb, 0, 0, &mut buffer) };
                    buffer == 314159
                },
            )?;
            clean_errors(gl);

            let mut buffer64: glw::GLint64 = 314159;
            is_ok &= Self::test_query_for_invalid_parameter_name(
                gl,
                "glGetTransformFeedbacki64_v",
                "has generated more than one error",
                |xfb| {
                    // SAFETY: as above.
                    unsafe { gl.get_transform_feedbacki_64_v(xfb, 0, 0, &mut buffer64) };
                    buffer64 == 314159
                },
            )?;
            clean_errors(gl);

            is_ok &= Self::test_indexed_queries_for_invalid_binding_point(gl)?;
            clean_errors(gl);
            Ok(is_ok)
        })
    }
}

/// `TransformFeedback::FunctionalTest`
struct XfbFunctionalTest;

impl XfbFunctionalTest {
    const BO_SIZE: glw::GLsizeiptr = 4 * std::mem::size_of::<glw::GLint>() as glw::GLsizeiptr;
    const VERTEX_SHADER: &'static str = "#version 130\n\nout int result;\n\nvoid main()\n{\n\n    result      = gl_VertexID;\n    gl_Position = vec4(1.0);\n}\n";
    const FRAGMENT_SHADER: &'static str =
        "#version 130\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(0.0, 0.0, 0.0, 1.0);\n}\n";
    const XFB_VARYING: &'static str = "result";

    /// `testTransformFeedbackStatus`
    fn test_transform_feedback_status(
        gl: &glw::Functions,
        xfb: glw::GLuint,
        parameter_name: glw::GLenum,
        expected_value: glw::GLint,
    ) -> Result<bool, TestError> {
        let mut value: glw::GLint = 314159;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_transform_feedbackiv(xfb, parameter_name, &mut value) };
        glu::expect_no_error(gl, "glGetTransformFeedbackiv call failed.")?;

        if expected_value != value {
            let name = if parameter_name == glw::GL_TRANSFORM_FEEDBACK_PAUSED {
                "GL_TRANSFORM_FEEDBACK_PAUSED"
            } else {
                "GL_TRANSFORM_FEEDBACK_ACTIVE"
            };
            let as_bool = |value: glw::GLint| {
                if value == glw::GL_TRUE as glw::GLint {
                    "GL_TRUE"
                } else {
                    "GL_FALSE"
                }
            };
            log::info!(
                "It was expected that glGetTransformFeedbackiv query of parameter {name} shall return {}however, {} was returned.",
                as_bool(expected_value),
                as_bool(value)
            );
            return Ok(false);
        }
        Ok(true)
    }
}

/// The objects of `FunctionalTest` (`m_xfb_dsa`, `m_bo`, `m_po`, `m_vao`), released by `clean()`.
struct XfbFunctionalObjects<'gl> {
    gl: &'gl glw::Functions,
    xfb: glw::GLuint,
    bo: glw::GLuint,
    po: glw::GLuint,
    vao: glw::GLuint,
}

impl Drop for XfbFunctionalObjects<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes only names this guard holds; zero names are skipped.
        unsafe {
            if self.xfb != 0 {
                self.gl.delete_transform_feedbacks(1, &self.xfb);
            }
            if self.bo != 0 {
                self.gl.delete_buffers(1, &self.bo);
            }
            if self.po != 0 {
                self.gl.use_program(0);
                self.gl.delete_program(self.po);
            }
            if self.vao != 0 {
                self.gl.bind_vertex_array(0);
                self.gl.delete_vertex_arrays(1, &self.vao);
            }
            self.gl.disable(glw::GL_RASTERIZER_DISCARD);
        }
    }
}

impl TestCase for XfbFunctionalTest {
    fn name(&self) -> &str {
        "xfb_functional"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = XfbFunctionalObjects {
            gl,
            xfb: 0,
            bo: 0,
            po: 0,
            vao: 0,
        };

        dsa_outcome(|| {
            let mut is_ok = true;

            // prepareFunctionPointers
            if gl.get_transform_feedbackiv.is_none() || gl.transform_feedback_buffer_base.is_none() {
                log::info!("Function pointers are set to NULL values.");
                return Err(TestError::Fail("throw 0".to_string()));
            }

            // prepareTransformFeedback
            // SAFETY: one name is written to the live field.
            unsafe { gl.create_transform_feedbacks(1, &mut objects.xfb) };
            glu::expect_no_error(gl, "glCreateTransformFeedbacks have failed")?;

            // prepareBuffer
            // SAFETY: a buffer generated, bound and allocated here, then attached to the transform feedback object.
            unsafe {
                gl.gen_buffers(1, &mut objects.bo);
                glu::expect_no_error(gl, "glGenBuffers have failed")?;
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, objects.bo);
                glu::expect_no_error(gl, "glBindBuffer have failed")?;
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    Self::BO_SIZE,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_COPY,
                );
                glu::expect_no_error(gl, "glBufferData have failed")?;
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer have failed")?;
                gl.transform_feedback_buffer_base(objects.xfb, 0, objects.bo);
                glu::expect_no_error(gl, "glTransformFeedbackBufferBase have failed")?;
            }

            // prepareProgram
            {
                let vertex = super::common_bugs_tests::Shader::new(gl, glw::GL_VERTEX_SHADER)?;
                let fragment = super::common_bugs_tests::Shader::new(gl, glw::GL_FRAGMENT_SHADER)?;
                let program = super::common_bugs_tests::Program::new(gl)?;
                for (shader, source) in [(&vertex, Self::VERTEX_SHADER), (&fragment, Self::FRAGMENT_SHADER)] {
                    shader.source(&[source])?;
                    if !shader.compile()? {
                        log::info!("Shader compilation has failed.\nShader source code:\n{source}\n");
                        return Err(TestError::Fail("throw 0".to_string()));
                    }
                    program.attach(shader)?;
                }

                let varying = CString::new(Self::XFB_VARYING).expect("no NUL in the name");
                let varying_ptr = varying.as_ptr();
                // SAFETY: one NUL-terminated varying name.
                unsafe { gl.transform_feedback_varyings(program.id, 1, &varying_ptr, glw::GL_INTERLEAVED_ATTRIBS) };
                glu::expect_no_error(gl, "glTransformFeedbackVaryings call failed.")?;

                if !program.link()? {
                    log::info!("Program linkage has failed.");
                    return Err(TestError::Fail("throw 0".to_string()));
                }
                // SAFETY: both shaders are attached to the program.
                unsafe {
                    gl.detach_shader(program.id, vertex.id);
                    glu::expect_no_error(gl, "glDetachShader call failed.")?;
                    gl.detach_shader(program.id, fragment.id);
                    glu::expect_no_error(gl, "glDetachShader call failed.")?;
                }
                objects.po = program.id;
                std::mem::forget(program);
            }
            // SAFETY: a live, linked program.
            unsafe { gl.use_program(objects.po) };
            glu::expect_no_error(gl, "glUseProgram call failed.")?;

            // prepareVertexArrayObject
            // SAFETY: a name is written to the live field, then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut objects.vao);
                glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
                gl.bind_vertex_array(objects.vao);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            }

            // draw
            let xfb = objects.xfb;
            // SAFETY: the transform feedback object, program and buffer prepared above.
            unsafe {
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, xfb);
                glu::expect_no_error(gl, "glBindTransformFeedback call failed.")?;
                gl.begin_transform_feedback(glw::GL_POINTS);
                glu::expect_no_error(gl, "glBeginTransformFeedback call failed.")?;
                gl.enable(glw::GL_RASTERIZER_DISCARD);
                glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed.")?;
                gl.draw_arrays(glw::GL_POINTS, 0, 4);
                glu::expect_no_error(gl, "glDrawArrays call failed.")?;
                gl.pause_transform_feedback();
                glu::expect_no_error(gl, "glPauseTransformFeedback call failed.")?;
            }
            let (true_, false_) = (glw::GL_TRUE as glw::GLint, glw::GL_FALSE as glw::GLint);
            is_ok &= Self::test_transform_feedback_status(gl, xfb, glw::GL_TRANSFORM_FEEDBACK_PAUSED, true_)?;
            is_ok &= Self::test_transform_feedback_status(gl, xfb, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, true_)?;
            // SAFETY: the transform feedback is paused.
            unsafe { gl.resume_transform_feedback() };
            glu::expect_no_error(gl, "glPauseTransformFeedback call failed.")?;
            is_ok &= Self::test_transform_feedback_status(gl, xfb, glw::GL_TRANSFORM_FEEDBACK_PAUSED, false_)?;
            is_ok &= Self::test_transform_feedback_status(gl, xfb, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, true_)?;
            // SAFETY: the transform feedback is active.
            unsafe { gl.end_transform_feedback() };
            glu::expect_no_error(gl, "glEndTransformFeedback call failed.")?;
            is_ok &= Self::test_transform_feedback_status(gl, xfb, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, false_)?;

            // verifyBufferContent
            // SAFETY: a read-only mapping of the buffer, which holds four ints; the slice ends before the unmap.
            let content_ok = unsafe {
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, objects.bo);
                glu::expect_no_error(gl, "glBindBuffer call failed.")?;
                let buffer = gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY);
                glu::expect_no_error(gl, "glMapBuffer call failed.")?;
                let content_ok = std::slice::from_raw_parts(buffer.cast::<glw::GLint>(), 4)
                    .iter()
                    .enumerate()
                    .all(|(i, value)| *value == i as glw::GLint);
                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
                glu::expect_no_error(gl, "glUnmapBuffer call failed.")?;
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer call failed.")?;
                content_ok
            };
            is_ok &= content_ok;
            Ok(is_ok)
        })
    }
}

// ------------------------------------------------------------------------------------------------------------------
// Buffers

/// `Buffers::CreationTest`
struct BuffersCreationTest;

impl TestCase for BuffersCreationTest {
    fn name(&self) -> &str {
        "buffers_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const BUFFERS_COUNT: usize = 2;
        let gl = context.gl();
        let mut buffers_legacy = [0 as glw::GLuint; BUFFERS_COUNT];
        let mut buffers_dsa = [0 as glw::GLuint; BUFFERS_COUNT];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: BUFFERS_COUNT names are written to the live array.
            unsafe { gl.gen_buffers(BUFFERS_COUNT as glw::GLsizei, buffers_legacy.as_mut_ptr()) };
            glu::expect_no_error(gl, "glGenBuffers have failed")?;

            for buffer in &buffers_legacy {
                // SAFETY: plain query.
                if unsafe { gl.is_buffer(*buffer) } != 0 {
                    is_ok = false;
                    log::info!("GenBuffers has created default objects, but it should create only a names.");
                }
            }

            // SAFETY: BUFFERS_COUNT names are written to the live array.
            unsafe { gl.create_buffers(BUFFERS_COUNT as glw::GLsizei, buffers_dsa.as_mut_ptr()) };
            glu::expect_no_error(gl, "glCreateBuffers have failed")?;

            for buffer in &buffers_dsa {
                // SAFETY: plain query.
                if unsafe { gl.is_buffer(*buffer) } == 0 {
                    is_ok = false;
                    log::info!("CreateBuffers has not created default objects.");
                }
            }
            Ok(is_ok)
        });

        for buffer in buffers_legacy.iter().chain(&buffers_dsa) {
            if *buffer != 0 {
                // SAFETY: deletes a name generated above.
                unsafe { gl.delete_buffers(1, buffer) };
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Buffers::DataTest`'s upload functions
#[derive(Clone, Copy)]
enum Upload {
    NamedBufferData,
    NamedBufferSubData,
    NamedBufferStorage,
    CopyNamedBufferSubData,
}

impl Upload {
    fn name(self) -> &'static str {
        match self {
            Upload::NamedBufferData => "glNamedBufferData",
            Upload::NamedBufferSubData => "glNamedBufferSubData",
            Upload::NamedBufferStorage => "glNamedBufferStorage",
            Upload::CopyNamedBufferSubData => "glCopyNamedBufferSubData",
        }
    }
}

/// `Buffers::DataTest`
struct BuffersDataTest;

impl BuffersDataTest {
    const REFERENCE: [u32; 13] = [0, 1, 2, 4, 8, 16, 64, 128, 256, 512, 1024, 2048, 4096];
    const REFERENCE_SIZE: glw::GLsizeiptr = (13 * std::mem::size_of::<u32>()) as glw::GLsizeiptr;

    /// `UploadUsingNamedBufferData` and its siblings
    fn upload(gl: &glw::Functions, upload: Upload, id: glw::GLuint, parameter: glw::GLenum) -> Result<(), TestError> {
        let reference: *const std::ffi::c_void = Self::REFERENCE.as_ptr().cast();

        // SAFETY: `reference` holds REFERENCE_SIZE bytes; every buffer used below is alive.
        unsafe {
            match upload {
                Upload::NamedBufferData => {
                    gl.named_buffer_data(id, Self::REFERENCE_SIZE, reference, parameter);
                    glu::expect_no_error(gl, "glNamedBufferData failed.")
                }
                Upload::NamedBufferSubData => {
                    gl.named_buffer_data(id, Self::REFERENCE_SIZE, std::ptr::null(), parameter);
                    glu::expect_no_error(gl, "glNamedBufferData failed.")?;
                    gl.named_buffer_sub_data(id, 0, Self::REFERENCE_SIZE, reference);
                    glu::expect_no_error(gl, "glNamedBufferSubData failed.")
                }
                Upload::NamedBufferStorage => {
                    gl.named_buffer_storage(id, Self::REFERENCE_SIZE, reference, parameter);
                    glu::expect_no_error(gl, "glNamedBufferStorage failed.")
                }
                Upload::CopyNamedBufferSubData => {
                    gl.named_buffer_data(id, Self::REFERENCE_SIZE, std::ptr::null(), parameter);
                    glu::expect_no_error(gl, "glNamedBufferData failed.")?;

                    let mut auxiliary_buffer: glw::GLuint = 0;
                    let result = (|| -> Result<(), TestError> {
                        gl.gen_buffers(1, &mut auxiliary_buffer);
                        glu::expect_no_error(gl, "glGenBuffers failed.")?;
                        gl.bind_buffer(glw::GL_ARRAY_BUFFER, auxiliary_buffer);
                        glu::expect_no_error(gl, "glBindBuffer failed.")?;
                        gl.buffer_data(glw::GL_ARRAY_BUFFER, Self::REFERENCE_SIZE, reference, parameter);
                        glu::expect_no_error(gl, "glBufferData failed.")?;
                        gl.copy_named_buffer_sub_data(auxiliary_buffer, id, 0, 0, Self::REFERENCE_SIZE);
                        glu::expect_no_error(gl, "glCopyNamedBufferSubData failed.")
                    })();
                    if auxiliary_buffer != 0 {
                        gl.delete_buffers(1, &auxiliary_buffer);
                    }
                    result
                }
            }
        }
    }

    /// `TestCase`
    fn test_case(gl: &glw::Functions, upload: Upload, parameter: glw::GLenum) -> Result<bool, TestError> {
        struct Buffer<'gl> {
            gl: &'gl glw::Functions,
            id: glw::GLuint,
        }
        impl Drop for Buffer<'_> {
            fn drop(&mut self) {
                if self.id != 0 {
                    // SAFETY: deletes the name this guard created.
                    unsafe { self.gl.delete_buffers(1, &self.id) };
                }
            }
        }

        let mut buffer = Buffer { gl, id: 0 };
        let result = (|| -> Result<bool, TestError> {
            // SAFETY: one name is written to the live field.
            unsafe { gl.create_buffers(1, &mut buffer.id) };
            glu::expect_no_error(gl, "glCreateBuffers failed.")?;

            Self::upload(gl, upload, buffer.id, parameter)?;

            // SAFETY: a read-only mapping of the buffer, which holds the reference values; the slice ends before the unmap.
            let (is_ok, data) = unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.id);
                glu::expect_no_error(gl, "glBindBuffer failed.")?;
                let data = gl.map_buffer(glw::GL_ARRAY_BUFFER, glw::GL_READ_ONLY);
                glu::expect_no_error(gl, "glMapBuffer failed.")?;
                let data = std::slice::from_raw_parts(data.cast::<u32>(), Self::REFERENCE.len()).to_vec();
                gl.unmap_buffer(glw::GL_ARRAY_BUFFER);
                glu::expect_no_error(gl, "glUnmapBuffer failed.")?;
                (data == Self::REFERENCE, data)
            };

            if !is_ok {
                log::info!(
                    "The test of {} called with usage parameter {parameter:#x}. Buffer data is equal to {data:?}, but {:?} was expected.",
                    upload.name(),
                    Self::REFERENCE
                );
            }
            Ok(is_ok)
        })();

        if result.is_err() {
            log::info!(
                "Unexpected error occurred during the test of {} called with usage parameter {parameter:#x}.",
                upload.name()
            );
        }
        result
    }
}

impl TestCase for BuffersDataTest {
    fn name(&self) -> &str {
        "buffers_data"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const HINTS: [glw::GLenum; 9] = [
            glw::GL_STREAM_DRAW,
            glw::GL_STREAM_READ,
            glw::GL_STREAM_COPY,
            glw::GL_STATIC_DRAW,
            glw::GL_STATIC_READ,
            glw::GL_STATIC_COPY,
            glw::GL_DYNAMIC_DRAW,
            glw::GL_DYNAMIC_READ,
            glw::GL_DYNAMIC_COPY,
        ];
        const BITS: [glw::GLenum; 5] = [
            glw::GL_MAP_READ_BIT | glw::GL_DYNAMIC_STORAGE_BIT,
            glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT,
            glw::GL_MAP_READ_BIT | glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT,
            glw::GL_MAP_READ_BIT | glw::GL_CLIENT_STORAGE_BIT,
        ];
        let gl = context.gl();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            if gl.named_buffer_data.is_none()
                || gl.named_buffer_sub_data.is_none()
                || gl.named_buffer_storage.is_none()
                || gl.copy_named_buffer_sub_data.is_none()
            {
                return Err(TestError::Fail("throw 0".to_string()));
            }

            for hint in HINTS {
                is_ok &= Self::test_case(gl, Upload::NamedBufferData, hint)?;
                is_ok &= Self::test_case(gl, Upload::NamedBufferSubData, hint)?;
                is_ok &= Self::test_case(gl, Upload::CopyNamedBufferSubData, hint)?;
            }
            for bits in BITS {
                is_ok &= Self::test_case(gl, Upload::NamedBufferStorage, bits)?;
            }
            Ok(is_ok)
        });
        clean_errors(gl);
        outcome
    }
}

/// `Queries::ErrorsTest`
struct QueriesErrorsTest;

impl QueriesErrorsTest {
    /// Calls the four `glGetQueryBufferObject*` functions with the same arguments and expects `expected_error` from each; `what` completes upstream's "glGetQueryBufferObject* ..." messages.
    fn check_all_buffer_object_functions(
        gl: &glw::Functions,
        query: glw::GLuint,
        buffer: glw::GLuint,
        pname: glw::GLenum,
        offset: glw::GLintptr,
        expected_error: glw::GLenum,
        what: &str,
    ) -> bool {
        let mut is_ok = true;
        for (n, name) in [
            "glGetQueryBufferObjectiv",
            "glGetQueryBufferObjectuiv",
            "glGetQueryBufferObjecti64v",
            "glGetQueryBufferObjectui64v",
        ]
        .into_iter()
        .enumerate()
        {
            // SAFETY: every call is expected to fail validation, so no buffer is written.
            let error = unsafe {
                match n {
                    0 => gl.get_query_buffer_objectiv(query, buffer, pname, offset),
                    1 => gl.get_query_buffer_objectuiv(query, buffer, pname, offset),
                    2 => gl.get_query_buffer_objecti_64v(query, buffer, pname, offset),
                    _ => gl.get_query_buffer_objectui_64v(query, buffer, pname, offset),
                }
                gl.get_error()
            };
            if error != expected_error {
                log::info!(
                    "{name} {what} generated error {}, however {} was expected.",
                    glw::error_name(error),
                    glw::error_name(expected_error)
                );
                is_ok = false;
            }
        }
        is_ok
    }

    /// The buffer of 8 bytes the buffer tests bind to `GL_TRANSFORM_FEEDBACK_BUFFER`.
    fn create_buffer(gl: &glw::Functions, buffer: &mut glw::GLuint) -> Result<(), TestError> {
        // SAFETY: a buffer generated, bound and allocated here.
        unsafe {
            gl.gen_buffers(1, buffer);
            glu::expect_no_error(gl, "glGenBuffers have failed")?;
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, *buffer);
            glu::expect_no_error(gl, "glBindBuffers have failed")?;
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                std::mem::size_of::<glw::GLint64>() as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY,
            );
        }
        glu::expect_no_error(gl, "glBindBuffers have failed")
    }

    fn create_query(gl: &glw::Functions, query: &mut glw::GLuint) -> Result<(), TestError> {
        // SAFETY: one name is written to the caller's local.
        unsafe { gl.create_queries(QUERY_TARGETS[0].0, 1, query) };
        glu::expect_no_error(gl, "glCreateQueries have failed")
    }

    /// The cleanup every test below ends with: the query (ended first when `end_query` is set), the buffer, then the pending errors.
    fn clean(gl: &glw::Functions, query: glw::GLuint, buffer: glw::GLuint, end_query: bool) {
        // SAFETY: deletes only names the test created; zero names are skipped.
        unsafe {
            if query != 0 {
                if end_query {
                    gl.end_query(QUERY_TARGETS[0].0);
                }
                gl.delete_queries(1, &query);
            }
            if buffer != 0 {
                gl.delete_buffers(1, &buffer);
            }
        }
        clean_errors(gl);
    }

    /// `testNegativeNumberOfObjects`
    fn test_negative_number_of_objects(gl: &glw::Functions) -> bool {
        for (target, name) in QUERY_TARGETS {
            let mut query: glw::GLuint = 0;
            // SAFETY: a negative count is the error this call is expected to generate.
            unsafe { gl.create_queries(target, -1, &mut query) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_INVALID_VALUE {
                log::info!(
                    "glCreateQueries called with target {name} with negative number of objects to be created (-1) has generated error {}, however GL_INVALID_VALUE was expected.",
                    glw::error_name(error)
                );
                if query != 0 {
                    // SAFETY: deletes the name the driver wrote; the pending errors are drained.
                    unsafe { gl.delete_queries(1, &query) };
                    clean_errors(gl);
                    log::info!(
                        "glCreateQueries called with target {name} with negative number of objects to be created (-1) has created at least one object."
                    );
                }
                return false;
            }
        }
        true
    }

    /// `testInvalidTarget`
    fn test_invalid_target(gl: &glw::Functions) -> bool {
        let mut invalid_target: glw::GLenum = 0;
        loop {
            invalid_target += 1;
            if !QUERY_TARGETS.iter().any(|(target, _)| *target == invalid_target) {
                break;
            }
        }

        let mut query: glw::GLuint = 0;
        // SAFETY: an invalid target is the error this call is expected to generate.
        unsafe { gl.create_queries(invalid_target, 1, &mut query) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_INVALID_ENUM {
            log::info!(
                "glCreateQueries called with invalid target ({invalid_target}) has generated error {}, however GL_INVALID_ENUM was expected.",
                glw::error_name(error)
            );
            if query != 0 {
                // SAFETY: deletes the name the driver wrote; the pending errors are drained.
                unsafe { gl.delete_queries(1, &query) };
                clean_errors(gl);
                log::info!("glCreateQueries called with invalid target ({invalid_target}) has created an object.");
            }
            return false;
        }
        true
    }

    /// `testInvalidQueryName`
    fn test_invalid_query_name(gl: &glw::Functions) -> Result<bool, TestError> {
        let mut invalid_query: glw::GLuint = 0;
        loop {
            invalid_query += 1;
            // SAFETY: plain query.
            if unsafe { gl.is_query(invalid_query) } == 0 {
                break;
            }
        }

        let (mut buffer, mut query): (glw::GLuint, glw::GLuint) = (0, 0);
        let mut began_query = false;
        let result = (|| -> Result<bool, TestError> {
            let mut is_ok = true;
            Self::create_buffer(gl, &mut buffer)?;

            is_ok &= Self::check_all_buffer_object_functions(
                gl,
                invalid_query,
                buffer,
                glw::GL_QUERY_RESULT,
                0,
                glw::GL_INVALID_OPERATION,
                "called with invalid query name has",
            );

            Self::create_query(gl, &mut query)?;
            // SAFETY: the query was created above.
            unsafe { gl.begin_query(QUERY_TARGETS[0].0, query) };
            began_query = true;
            glu::expect_no_error(gl, "glCreateQueries have failed")?;

            is_ok &= Self::check_all_buffer_object_functions(
                gl,
                query,
                buffer,
                glw::GL_QUERY_RESULT,
                0,
                glw::GL_INVALID_OPERATION,
                "called with active query object has",
            );
            Ok(is_ok)
        })();
        Self::clean(gl, query, buffer, began_query || query != 0);
        result
    }

    /// `testInvalidBufferName`
    fn test_invalid_buffer_name(gl: &glw::Functions) -> Result<bool, TestError> {
        let mut invalid_buffer: glw::GLuint = 0;
        loop {
            invalid_buffer += 1;
            // SAFETY: plain query.
            if unsafe { gl.is_buffer(invalid_buffer) } == 0 {
                break;
            }
        }

        let mut query: glw::GLuint = 0;
        let result = (|| -> Result<bool, TestError> {
            Self::create_query(gl, &mut query)?;
            Ok(Self::check_all_buffer_object_functions(
                gl,
                query,
                invalid_buffer,
                glw::GL_QUERY_RESULT_AVAILABLE,
                0,
                glw::GL_INVALID_OPERATION,
                "which could generate buffers overflow",
            ))
        })();
        Self::clean(gl, query, 0, false);
        result
    }

    /// `testInvalidParameterName`, `testBufferOverflow` and `testBufferNegativeOffset`: a query and a buffer, then the four calls with the given arguments.
    fn test_with_query_and_buffer(
        gl: &glw::Functions,
        pname: glw::GLenum,
        offset: glw::GLintptr,
        expected_error: glw::GLenum,
        what: &str,
    ) -> Result<bool, TestError> {
        let (mut buffer, mut query): (glw::GLuint, glw::GLuint) = (0, 0);
        let result = (|| -> Result<bool, TestError> {
            Self::create_buffer(gl, &mut buffer)?;
            Self::create_query(gl, &mut query)?;
            Ok(Self::check_all_buffer_object_functions(
                gl,
                query,
                buffer,
                pname,
                offset,
                expected_error,
                what,
            ))
        })();
        Self::clean(gl, query, buffer, false);
        result
    }
}

impl TestCase for QueriesErrorsTest {
    fn name(&self) -> &str {
        "queries_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        dsa_outcome(|| {
            let mut is_ok = true;

            if gl.get_query_buffer_objectiv.is_none()
                || gl.get_query_buffer_objectuiv.is_none()
                || gl.get_query_buffer_objecti_64v.is_none()
                || gl.get_query_buffer_objectui_64v.is_none()
            {
                log::info!("Test could not get the pointers for glGetQueryBufferObject* functions.");
                return Err(TestError::Fail("throw 0".to_string()));
            }

            // The first parameter name that is none of the valid ones.
            let valid_pnames = [
                glw::GL_QUERY_RESULT,
                glw::GL_QUERY_RESULT_AVAILABLE,
                glw::GL_QUERY_RESULT_NO_WAIT,
                glw::GL_QUERY_TARGET,
            ];
            let mut invalid_pname: glw::GLenum = 0;
            loop {
                invalid_pname += 1;
                if !valid_pnames.contains(&invalid_pname) {
                    break;
                }
            }

            is_ok &= Self::test_negative_number_of_objects(gl);
            is_ok &= Self::test_invalid_target(gl);
            is_ok &= Self::test_invalid_query_name(gl)?;
            is_ok &= Self::test_invalid_buffer_name(gl)?;
            is_ok &= Self::test_with_query_and_buffer(
                gl,
                invalid_pname,
                0,
                glw::GL_INVALID_ENUM,
                "called with invalid parameter name has",
            )?;
            is_ok &= Self::test_with_query_and_buffer(
                gl,
                glw::GL_QUERY_RESULT_AVAILABLE,
                std::mem::size_of::<glw::GLint64>() as glw::GLintptr,
                glw::GL_INVALID_OPERATION,
                "which could generate buffers overflow",
            )?;
            is_ok &= Self::test_with_query_and_buffer(
                gl,
                glw::GL_QUERY_RESULT_AVAILABLE,
                -1,
                glw::GL_INVALID_VALUE,
                "called with negative offset",
            )?;
            Ok(is_ok)
        })
    }
}

/// `Queries::FunctionalTest`
struct QueriesFunctionalTest;

impl QueriesFunctionalTest {
    const TARGETS: [glw::GLenum; 4] = [
        glw::GL_SAMPLES_PASSED,
        glw::GL_TIME_ELAPSED,
        glw::GL_PRIMITIVES_GENERATED,
        glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
    ];
    const RESULTS: [glw::GLint; 4] = [1, 0, 2, 2];
    const VERTEX_SHADER: &'static str = "#version 450\n\nout int xfb_result;\n\nvoid main()\n{\n    switch(gl_VertexID)\n    {\n        case 0:\n            gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n            break;\n        case 1:\n            gl_Position = vec4( 1.0, 1.0, 0.0, 1.0);\n            break;\n        case 2:\n            gl_Position = vec4(-1.0,-1.0, 0.0, 1.0);\n            break;\n        case 3:\n            gl_Position = vec4( 1.0,-1.0, 0.0, 1.0);\n            break;\n    }\n\n    xfb_result = gl_VertexID;\n}\n";
    const FRAGMENT_SHADER: &'static str =
        "#version 450\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";
    const XFB_VARYING_NAME: &'static str = "xfb_result";

    /// `checkQueryBufferObject<T>`: `variant` picks `glGetQueryBufferObject{i,ui,i64,ui64}v`, `comparison` is `equal` or `less` applied as `comparison(expected, value)` on the value of the same width, read back from the query buffer.
    fn check_query_buffer_object(
        gl: &glw::Functions,
        query: glw::GLuint,
        query_buffer: glw::GLuint,
        variant: usize,
        pname: glw::GLenum,
        expected_value: i64,
        less: bool,
    ) -> Result<bool, TestError> {
        // SAFETY: the result is written to the query buffer, which holds eight bytes.
        unsafe {
            match variant {
                0 => gl.get_query_buffer_objectiv(query, query_buffer, pname, 0),
                1 => gl.get_query_buffer_objectuiv(query, query_buffer, pname, 0),
                2 => gl.get_query_buffer_objecti_64v(query, query_buffer, pname, 0),
                _ => gl.get_query_buffer_objectui_64v(query, query_buffer, pname, 0),
            }
        }
        glu::expect_no_error(gl, "glGetQueryBufferObject* have failed")?;

        // SAFETY: a read-only mapping of the buffer bound to GL_QUERY_BUFFER, which holds eight bytes; the value is copied before the unmap.
        let bytes: [u8; 8] = unsafe {
            let value = gl.map_buffer(glw::GL_QUERY_BUFFER, glw::GL_READ_ONLY);
            glu::expect_no_error(gl, "glMapBuffer have failed")?;
            let bytes = std::slice::from_raw_parts(value.cast::<u8>(), 8)
                .try_into()
                .expect("eight bytes");
            gl.unmap_buffer(glw::GL_QUERY_BUFFER);
            glu::expect_no_error(gl, "glUnmapBuffer have failed")?;
            bytes
        };

        // Only the width of the variant is read back, as upstream reads a `T`.
        let value: i128 = match variant {
            0 => i128::from(i32::from_ne_bytes(bytes[..4].try_into().expect("four bytes"))),
            1 => i128::from(u32::from_ne_bytes(bytes[..4].try_into().expect("four bytes"))),
            2 => i128::from(i64::from_ne_bytes(bytes)),
            _ => i128::from(u64::from_ne_bytes(bytes)),
        };
        let expected = i128::from(expected_value);
        Ok(if less { expected < value } else { expected == value })
    }
}

/// The objects of `FunctionalTest`, released by `clean()`.
struct QueriesFunctionalObjects<'gl> {
    gl: &'gl glw::Functions,
    fbo: glw::GLuint,
    rbo: glw::GLuint,
    vao: glw::GLuint,
    bo_query: glw::GLuint,
    bo_xfb: glw::GLuint,
    qo: [glw::GLuint; 4],
    po: glw::GLuint,
}

impl Drop for QueriesFunctionalObjects<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes only names this guard holds; zero names are skipped.
        unsafe {
            self.gl.delete_queries(self.qo.len() as glw::GLsizei, self.qo.as_ptr());
            if self.fbo != 0 {
                self.gl.delete_framebuffers(1, &self.fbo);
            }
            if self.rbo != 0 {
                self.gl.delete_renderbuffers(1, &self.rbo);
            }
            if self.vao != 0 {
                self.gl.delete_vertex_arrays(1, &self.vao);
            }
            if self.bo_query != 0 {
                self.gl.delete_buffers(1, &self.bo_query);
            }
            if self.bo_xfb != 0 {
                self.gl.delete_buffers(1, &self.bo_xfb);
            }
            if self.po != 0 {
                self.gl.use_program(0);
                self.gl.delete_program(self.po);
            }
        }
    }
}

impl TestCase for QueriesFunctionalTest {
    fn name(&self) -> &str {
        "queries_functional"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = QueriesFunctionalObjects {
            gl,
            fbo: 0,
            rbo: 0,
            vao: 0,
            bo_query: 0,
            bo_xfb: 0,
            qo: [0; 4],
            po: 0,
        };

        dsa_outcome(|| {
            let mut is_ok = true;

            if gl.get_query_buffer_objectiv.is_none()
                || gl.get_query_buffer_objectuiv.is_none()
                || gl.get_query_buffer_objecti_64v.is_none()
                || gl.get_query_buffer_objectui_64v.is_none()
            {
                log::info!("Test could not get the pointers for glGetQueryBufferObject* functions.");
                return Err(TestError::Fail("throw 0".to_string()));
            }

            // prepareView
            // SAFETY: names are written to live fields; a 1x1 RGBA8 renderbuffer is attached.
            unsafe {
                gl.gen_framebuffers(1, &mut objects.fbo);
                glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
                gl.gen_renderbuffers(1, &mut objects.rbo);
                glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo);
                glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbo);
                glu::expect_no_error(gl, "glBindRenderbuffer call failed.")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage call failed.")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    objects.rbo,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer call failed.")?;
                if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    return Err(TestError::Fail("throw 0".to_string()));
                }
                gl.viewport(0, 0, 1, 1);
                glu::expect_no_error(gl, "glViewport call failed.")?;
                gl.clear_color(0.0, 0.0, 0.0, 0.0);
                glu::expect_no_error(gl, "glClearColor call failed.")?;
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                glu::expect_no_error(gl, "glClear call failed.")?;
            }

            // prepareVertexArray
            // SAFETY: a name is written to the live field, then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut objects.vao);
                glu::expect_no_error(gl, "glGenVertexArrays have failed")?;
                gl.bind_vertex_array(objects.vao);
                glu::expect_no_error(gl, "glBindVertexArray have failed")?;
            }

            // prepareBuffers
            // SAFETY: buffers generated, bound and allocated here; the transform feedback buffer holds two triangles of ints.
            unsafe {
                gl.gen_buffers(1, &mut objects.bo_query);
                glu::expect_no_error(gl, "glGenBuffers have failed")?;
                gl.bind_buffer(glw::GL_QUERY_BUFFER, objects.bo_query);
                glu::expect_no_error(gl, "glBindBuffer have failed")?;
                gl.buffer_data(
                    glw::GL_QUERY_BUFFER,
                    std::mem::size_of::<glw::GLint64>() as glw::GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_COPY,
                );
                glu::expect_no_error(gl, "glBufferData have failed")?;

                gl.gen_buffers(1, &mut objects.bo_xfb);
                glu::expect_no_error(gl, "glGenBuffers have failed")?;
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, objects.bo_xfb);
                glu::expect_no_error(gl, "glBindBuffer have failed")?;
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    (3 * 2 * std::mem::size_of::<glw::GLint>()) as glw::GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_COPY,
                );
                glu::expect_no_error(gl, "glBufferData have failed")?;
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, objects.bo_xfb);
                glu::expect_no_error(gl, "glBindBufferBase have failed")?;
            }

            // prepareQueries
            for (i, target) in Self::TARGETS.into_iter().enumerate() {
                // SAFETY: one name is written to the live array element.
                unsafe { gl.create_queries(target, 1, &mut objects.qo[i]) };
                // SAFETY: plain state query.
                if unsafe { gl.get_error() } != glw::GL_NO_ERROR {
                    return Err(TestError::Fail("throw 0".to_string()));
                }
            }

            // prepareProgram
            {
                let vertex = super::common_bugs_tests::Shader::new(gl, glw::GL_VERTEX_SHADER)?;
                let fragment = super::common_bugs_tests::Shader::new(gl, glw::GL_FRAGMENT_SHADER)?;
                let program = super::common_bugs_tests::Program::new(gl)?;
                for (shader, source) in [(&vertex, Self::VERTEX_SHADER), (&fragment, Self::FRAGMENT_SHADER)] {
                    shader.source(&[source])?;
                    if !shader.compile()? {
                        log::info!("Shader compilation has failed.\nShader source code:\n{source}\n");
                        return Err(TestError::Fail("throw 0".to_string()));
                    }
                    program.attach(shader)?;
                }

                let varying = CString::new(Self::XFB_VARYING_NAME).expect("no NUL in the name");
                let varying_ptr = varying.as_ptr();
                // SAFETY: one NUL-terminated varying name.
                unsafe { gl.transform_feedback_varyings(program.id, 1, &varying_ptr, glw::GL_INTERLEAVED_ATTRIBS) };
                glu::expect_no_error(gl, "glTransformFeedbackVaryings call failed.")?;

                if !program.link()? {
                    log::info!("Program linkage has failed.");
                    return Err(TestError::Fail("throw 0".to_string()));
                }
                // SAFETY: both shaders are attached to the program.
                unsafe {
                    gl.detach_shader(program.id, vertex.id);
                    glu::expect_no_error(gl, "glDetachShader call failed.")?;
                    gl.detach_shader(program.id, fragment.id);
                    glu::expect_no_error(gl, "glDetachShader call failed.")?;
                }
                objects.po = program.id;
                std::mem::forget(program);
            }
            // SAFETY: a live, linked program.
            unsafe { gl.use_program(objects.po) };
            glu::expect_no_error(gl, "glUseProgram call failed.")?;

            // draw
            // SAFETY: the queries, program, framebuffer and buffers prepared above.
            unsafe {
                for (target, query) in Self::TARGETS.into_iter().zip(objects.qo) {
                    gl.begin_query(target, query);
                }
                gl.begin_transform_feedback(glw::GL_TRIANGLES);
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
                gl.end_transform_feedback();
                for target in Self::TARGETS {
                    gl.end_query(target);
                }
                gl.finish();
            }
            glu::expect_no_error(gl, "Drawing function have failed.")?;

            // checkView
            let mut pixel = [0u8; 4];
            // SAFETY: one RGBA pixel is written to the live array.
            unsafe {
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    pixel.as_mut_ptr().cast(),
                )
            };
            glu::expect_no_error(gl, "glReadPixels have failed")?;
            if pixel != [255, 0, 0, 255] {
                log::info!(
                    "Frameuffer content ({}, {}, {}, {}) is different than expected (255, 0, 0, 255).",
                    pixel[0],
                    pixel[1],
                    pixel[2],
                    pixel[3]
                );
                is_ok = false;
            }
            // Upstream's `is_ok &= checkView()` returns at once on a bad pixel only from checkView, the remaining checks still run.

            // checkXFB
            // SAFETY: a read-only mapping of the buffer, which holds six ints; the slice ends before the unmap.
            let xfb_ok = unsafe {
                let buffer = gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY);
                glu::expect_no_error(gl, "glMapBuffer call failed.")?;
                let xfb_ok = std::slice::from_raw_parts(buffer.cast::<glw::GLint>(), 6) == [0, 1, 2, 2, 1, 3];
                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
                glu::expect_no_error(gl, "glUnmapBuffer call failed.")?;
                xfb_ok
            };
            is_ok &= xfb_ok;

            // checkQueryBufferObject for every target and every width
            let query_buffer = objects.bo_query;
            for (i, target) in Self::TARGETS.into_iter().enumerate() {
                let query = objects.qo[i];
                for variant in 0..4 {
                    is_ok &= Self::check_query_buffer_object(
                        gl,
                        query,
                        query_buffer,
                        variant,
                        glw::GL_QUERY_TARGET,
                        i64::from(target),
                        false,
                    )?;
                }
                for variant in 0..4 {
                    is_ok &= Self::check_query_buffer_object(
                        gl,
                        query,
                        query_buffer,
                        variant,
                        glw::GL_QUERY_RESULT_AVAILABLE,
                        i64::from(glw::GL_TRUE),
                        false,
                    )?;
                }
                let less = target == glw::GL_TIME_ELAPSED;
                for pname in [glw::GL_QUERY_RESULT, glw::GL_QUERY_RESULT_NO_WAIT] {
                    for variant in 0..4 {
                        is_ok &= Self::check_query_buffer_object(
                            gl,
                            query,
                            query_buffer,
                            variant,
                            pname,
                            i64::from(Self::RESULTS[i]),
                            less,
                        )?;
                    }
                }
            }
            Ok(is_ok)
        })
    }
}

/// `Queries::ReuseTest`
struct QueriesReuseTest;

impl TestCase for QueriesReuseTest {
    fn name(&self) -> &str {
        "queries_reuse"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;
        let (mut query_id_a, mut query_id_b): (glw::GLuint, glw::GLuint) = (0, 0);

        // SAFETY: names written to live locals; the queries are used and deleted in the order that reproduced a crash upstream.
        unsafe {
            gl.gen_queries(1, &mut query_id_a);
            gl.query_counter(query_id_a, glw::GL_TIMESTAMP);
            gl.delete_queries(1, &query_id_a);

            gl.gen_queries(1, &mut query_id_b);
            gl.begin_query(glw::GL_TIME_ELAPSED, query_id_b);
            if gl.get_error() != 0 {
                is_ok = false;
            }
            gl.end_query(glw::GL_TIME_ELAPSED);
            gl.delete_queries(1, &query_id_b);
        }

        if query_id_a != query_id_b {
            log::info!("Note: Queries got different id:s, so no actual reuse occurred.");
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// Which of `Buffers::MapReadOnlyTest`, `MapReadWriteTest` and `MapWriteOnlyTest` runs.
#[derive(Clone, Copy, PartialEq, Eq)]
enum MapKind {
    ReadOnly,
    ReadWrite,
    WriteOnly,
}

/// The element types of `Buffers::ClearTest::Compare<T>`: floats within 0.00001, everything else exactly.
trait ClearElement: Copy {
    fn same(self, other: Self) -> bool;
    fn as_int(self) -> i32;
}

macro_rules! clear_element_exact {
    ($($t:ty),*) => {$(
        impl ClearElement for $t {
            fn same(self, other: Self) -> bool {
                self == other
            }
            fn as_int(self) -> i32 {
                self as i32
            }
        }
    )*};
}
clear_element_exact!(u8, i8, u16, i16, u32, i32);

impl ClearElement for f32 {
    fn same(self, other: Self) -> bool {
        (self - other).abs() <= 0.00001
    }
    fn as_int(self) -> i32 {
        self as i32
    }
}

/// `Buffers::ClearTest`
struct BuffersClearTest;

impl BuffersClearTest {
    /// `TestClearNamedBufferData<T, USE_SUB_DATA>`
    fn test_clear_named_buffer_data<T: ClearElement>(
        gl: &glw::Functions,
        use_sub_data: bool,
        internalformat: glw::GLenum,
        count: usize,
        format: glw::GLenum,
        type_: glw::GLenum,
        data: &[T; 4],
    ) -> Result<bool, TestError> {
        let size = (count * std::mem::size_of::<T>()) as glw::GLsizeiptr;
        let mut buffer: glw::GLuint = 0;

        let result = (|| -> Result<bool, TestError> {
            // SAFETY: the buffer name is written to a live local; `data` holds at least `count` elements of the size passed to the GL.
            unsafe {
                gl.create_buffers(1, &mut buffer);
                glu::expect_no_error(gl, "glCreateBuffers failed.")?;

                gl.named_buffer_data(buffer, size, std::ptr::null(), glw::GL_DYNAMIC_COPY);
                glu::expect_no_error(gl, "glNamedBufferData failed.")?;

                if use_sub_data {
                    gl.clear_named_buffer_sub_data(
                        buffer,
                        internalformat,
                        0,
                        size,
                        format,
                        type_,
                        data.as_ptr().cast(),
                    );
                } else {
                    gl.clear_named_buffer_data(buffer, internalformat, format, type_, data.as_ptr().cast());
                }
                glu::expect_no_error(gl, "glClearNamedBufferData failed.")?;

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
                glu::expect_no_error(gl, "glBindBuffer failed.")?;

                let mapped = gl.map_buffer(glw::GL_ARRAY_BUFFER, glw::GL_READ_ONLY);
                glu::expect_no_error(gl, "glMapBuffer failed.")?;

                let cleared = std::slice::from_raw_parts(mapped.cast::<T>().cast_const(), count).to_vec();
                let is_ok = cleared.iter().zip(data.iter()).all(|(a, b)| a.same(*b));
                if !is_ok {
                    let function = if use_sub_data {
                        "ClearNamedBufferSubData"
                    } else {
                        "ClearNamedBufferData"
                    };
                    let cleared: Vec<i32> = cleared.iter().map(|v| v.as_int()).collect();
                    let expected: Vec<i32> = data[..count].iter().map(|v| v.as_int()).collect();
                    log::info!(
                        "The test of {function} has failed for internalformat {internalformat:#x}. Cleared buffer data is equal to {cleared:?}, but {expected:?} was expected."
                    );
                }

                gl.unmap_buffer(glw::GL_ARRAY_BUFFER);
                glu::expect_no_error(gl, "glUnmapBuffer failed.")?;
                Ok(is_ok)
            }
        })();

        if result.is_err() {
            let function = if use_sub_data {
                "ClearNamedBufferSubData"
            } else {
                "ClearNamedBufferData"
            };
            log::info!("Unexpected error occurred during Test of {function} with internalformat {internalformat:#x}");
        }

        if buffer != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_buffers(1, &buffer) };
            glu::expect_no_error(gl, "glDeleteBuffers failed.")?;
        }

        result
    }

    /// One `{ .. }` block of upstream's iterate: every row run with `ClearNamedBufferData` and then with `ClearNamedBufferSubData`.
    fn test_rows<T: ClearElement>(
        gl: &glw::Functions,
        rows: &[(glw::GLenum, usize, glw::GLenum)],
        type_: glw::GLenum,
        reference: &[T; 4],
    ) -> Result<bool, TestError> {
        let mut is_ok = true;
        for use_sub_data in [false, true] {
            for &(internalformat, count, format) in rows {
                is_ok &= Self::test_clear_named_buffer_data(
                    gl,
                    use_sub_data,
                    internalformat,
                    count,
                    format,
                    type_,
                    reference,
                )?;
            }
        }
        Ok(is_ok)
    }
}

impl TestCase for BuffersClearTest {
    fn name(&self) -> &str {
        "buffers_clear"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            if gl.named_buffer_data.is_none()
                || gl.clear_named_buffer_data.is_none()
                || gl.clear_named_buffer_sub_data.is_none()
            {
                return Err(TestError::Fail("throw 0".to_string()));
            }

            let norm_u8 = [
                (glw::GL_R8, 1, glw::GL_RED),
                (glw::GL_RG8, 2, glw::GL_RG),
                (glw::GL_RGBA8, 4, glw::GL_RGBA),
            ];
            let int_u8 = [
                (glw::GL_R8UI, 1, glw::GL_RED_INTEGER),
                (glw::GL_RG8UI, 2, glw::GL_RG_INTEGER),
                (glw::GL_RGBA8UI, 4, glw::GL_RGBA_INTEGER),
            ];
            is_ok &= Self::test_rows::<u8>(gl, &norm_u8, glw::GL_UNSIGNED_BYTE, &[5, 1, 2, 3])?;
            is_ok &= Self::test_rows::<u8>(gl, &int_u8, glw::GL_UNSIGNED_BYTE, &[5, 1, 2, 3])?;

            let int_i8 = [
                (glw::GL_R8I, 1, glw::GL_RED_INTEGER),
                (glw::GL_RG8I, 2, glw::GL_RG_INTEGER),
                (glw::GL_RGBA8I, 4, glw::GL_RGBA_INTEGER),
            ];
            is_ok &= Self::test_rows::<i8>(gl, &int_i8, glw::GL_BYTE, &[5, 1, -2, 3])?;

            let norm_u16 = [
                (glw::GL_R16, 1, glw::GL_RED),
                (glw::GL_RG16, 2, glw::GL_RG),
                (glw::GL_RGBA16, 4, glw::GL_RGBA),
            ];
            let int_u16 = [
                (glw::GL_R16UI, 1, glw::GL_RED_INTEGER),
                (glw::GL_RG16UI, 2, glw::GL_RG_INTEGER),
                (glw::GL_RGBA16UI, 4, glw::GL_RGBA_INTEGER),
            ];
            is_ok &= Self::test_rows::<u16>(gl, &norm_u16, glw::GL_UNSIGNED_SHORT, &[5, 1, 2, 3])?;
            is_ok &= Self::test_rows::<u16>(gl, &int_u16, glw::GL_UNSIGNED_SHORT, &[5, 1, 2, 3])?;

            let int_i16 = [
                (glw::GL_R16I, 1, glw::GL_RED_INTEGER),
                (glw::GL_RG16I, 2, glw::GL_RG_INTEGER),
                (glw::GL_RGBA16I, 4, glw::GL_RGBA_INTEGER),
            ];
            is_ok &= Self::test_rows::<i16>(gl, &int_i16, glw::GL_SHORT, &[5, 1, -2, 3])?;

            let int_u32 = [
                (glw::GL_R32UI, 1, glw::GL_RED_INTEGER),
                (glw::GL_RG32UI, 2, glw::GL_RG_INTEGER),
                (glw::GL_RGB32UI, 3, glw::GL_RGB_INTEGER),
                (glw::GL_RGBA32UI, 4, glw::GL_RGBA_INTEGER),
            ];
            is_ok &= Self::test_rows::<u32>(gl, &int_u32, glw::GL_UNSIGNED_INT, &[5, 1, 2, 3])?;

            let int_i32 = [
                (glw::GL_R32I, 1, glw::GL_RED_INTEGER),
                (glw::GL_RG32I, 2, glw::GL_RG_INTEGER),
                (glw::GL_RGB32I, 3, glw::GL_RGB_INTEGER),
                (glw::GL_RGBA32I, 4, glw::GL_RGBA_INTEGER),
            ];
            is_ok &= Self::test_rows::<i32>(gl, &int_i32, glw::GL_INT, &[5, 1, -2, 3])?;

            let half = [
                (glw::GL_R16F, 1, glw::GL_RED),
                (glw::GL_RG16F, 2, glw::GL_RG),
                (glw::GL_RGBA16F, 4, glw::GL_RGBA),
            ];
            is_ok &= Self::test_rows::<u16>(gl, &half, glw::GL_HALF_FLOAT, &[0x3C00, 0x0000, 0xC000, 0x3555])?;

            let float = [
                (glw::GL_R32F, 1, glw::GL_RED),
                (glw::GL_RG32F, 2, glw::GL_RG),
                (glw::GL_RGB32F, 3, glw::GL_RGB),
                (glw::GL_RGBA32F, 4, glw::GL_RGBA),
            ];
            is_ok &= Self::test_rows::<f32>(gl, &float, glw::GL_FLOAT, &[1.0, 0.0, -2.0, 0.333_333_34])?;

            Ok(is_ok)
        });
        clean_errors(gl);
        outcome
    }
}

/// The three `Buffers::Map*Test` cases, which share the reference data and the `glMapNamedBuffer`/`glUnmapNamedBuffer` checks.
struct BuffersMapTest(MapKind);

impl BuffersMapTest {
    const REFERENCE: [u32; 13] = [0, 1, 2, 4, 8, 16, 64, 128, 256, 512, 1024, 2048, 4096];
    const REFERENCE_SIZE: glw::GLsizeiptr = (13 * std::mem::size_of::<u32>()) as glw::GLsizeiptr;

    /// `glUnmapNamedBuffer` has to return `GL_TRUE`; the error check follows.
    fn unmap(gl: &glw::Functions, buffer: glw::GLuint) -> Result<bool, TestError> {
        // SAFETY: the buffer is mapped by the caller.
        let result = unsafe { gl.unmap_named_buffer(buffer) };
        let mut is_ok = true;
        if result != glw::GL_TRUE as glw::GLboolean {
            is_ok = false;
            log::info!("glUnmapNamedBuffer called on mapped buffer has returned GL_FALSE, but GL_TRUE was expected.");
        }
        glu::expect_no_error(gl, "glUnmapNamedBuffer failed.")?;
        Ok(is_ok)
    }

    /// `glMapNamedBuffer` of the whole buffer; `None` is upstream's NULL pointer.
    fn map(gl: &glw::Functions, buffer: glw::GLuint, access: glw::GLenum) -> Result<Option<*mut u32>, TestError> {
        // SAFETY: a mapping request; the result is only dereferenced through the slices built by the callers.
        let data = unsafe { gl.map_named_buffer(buffer, access) };
        glu::expect_no_error(gl, "glMapNamedBuffer failed.")?;
        Ok(if data.is_null() { None } else { Some(data.cast::<u32>()) })
    }

    fn run(&self, gl: &glw::Functions, buffer: &mut glw::GLuint) -> Result<bool, TestError> {
        let mut is_ok = true;
        let count = Self::REFERENCE.len();
        let reference: *const std::ffi::c_void = Self::REFERENCE.as_ptr().cast();

        if gl.named_buffer_data.is_none() || gl.map_named_buffer.is_none() || gl.unmap_named_buffer.is_none() {
            return Err(TestError::Fail("throw 0".to_string()));
        }

        // SAFETY: one name is written to the caller's local.
        unsafe { gl.create_buffers(1, buffer) };
        glu::expect_no_error(gl, "glCreateBuffers failed.")?;

        let initial_data = if self.0 == MapKind::WriteOnly {
            std::ptr::null()
        } else {
            reference
        };
        // SAFETY: `initial_data` is null or holds REFERENCE_SIZE bytes.
        unsafe { gl.named_buffer_data(*buffer, Self::REFERENCE_SIZE, initial_data, glw::GL_DYNAMIC_COPY) };
        glu::expect_no_error(gl, "glNamedBufferData failed.")?;

        let access = match self.0 {
            MapKind::ReadOnly => glw::GL_READ_ONLY,
            MapKind::ReadWrite => glw::GL_READ_WRITE,
            MapKind::WriteOnly => glw::GL_WRITE_ONLY,
        };
        let data = Self::map(gl, *buffer, access)?;
        let Some(data) = data else {
            log::info!("glMapNamedBuffer returned NULL pointer, but buffer's data was expected.");
            return Ok(is_ok);
        };
        // SAFETY: the mapping holds `count` values until the unmap below.
        let mapped = unsafe { std::slice::from_raw_parts_mut(data, count) };

        match self.0 {
            MapKind::ReadOnly | MapKind::ReadWrite => {
                is_ok &= mapped == Self::REFERENCE;
                if !is_ok {
                    log::info!("glMapNamedBuffer returned pointer to data which is not identical to reference data.");
                }
            }
            MapKind::WriteOnly => mapped.copy_from_slice(&Self::REFERENCE),
        }

        if self.0 == MapKind::ReadWrite {
            for (i, value) in mapped.iter_mut().enumerate() {
                *value = Self::REFERENCE[count - i - 1];
            }
        }

        is_ok &= Self::unmap(gl, *buffer)?;

        match self.0 {
            MapKind::ReadOnly => {}
            MapKind::ReadWrite => {
                if let Some(data) = Self::map(gl, *buffer, glw::GL_READ_WRITE)? {
                    // SAFETY: the mapping holds `count` values until the unmap below.
                    let mapped = unsafe { std::slice::from_raw_parts(data, count) };
                    for (i, value) in mapped.iter().enumerate() {
                        is_ok &= *value == Self::REFERENCE[count - i - 1];
                    }
                    is_ok &= Self::unmap(gl, *buffer)?;
                } else {
                    log::info!("glMapNamedBuffer returned NULL pointer, but buffer's data was expected.");
                }
            }
            MapKind::WriteOnly => {
                // SAFETY: a buffer bound and mapped read-only; the slice ends before the unmap.
                unsafe {
                    gl.bind_buffer(glw::GL_ARRAY_BUFFER, *buffer);
                    glu::expect_no_error(gl, "glBindBuffer failed.")?;
                    let data = gl.map_buffer(glw::GL_ARRAY_BUFFER, glw::GL_READ_ONLY);
                    glu::expect_no_error(gl, "glMapBuffer failed.")?;
                    is_ok &= std::slice::from_raw_parts(data.cast::<u32>(), count) == Self::REFERENCE;
                    if !is_ok {
                        log::info!(
                            "glMapNamedBuffer, called with GL_WRITE_ONLY access flag, had not stored the reference data."
                        );
                    }
                    gl.unmap_buffer(glw::GL_ARRAY_BUFFER);
                    glu::expect_no_error(gl, "glUnmapBuffer failed.")?;
                }
            }
        }
        Ok(is_ok)
    }
}

impl TestCase for BuffersMapTest {
    fn name(&self) -> &str {
        match self.0 {
            MapKind::ReadOnly => "buffers_map_read_only",
            MapKind::ReadWrite => "buffers_map_read_write",
            MapKind::WriteOnly => "buffers_map_write_only",
        }
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut buffer: glw::GLuint = 0;

        let outcome = dsa_outcome(|| self.run(gl, &mut buffer));

        if buffer != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_buffers(1, &buffer) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Buffers::MapRangeReadBitTest`
struct BuffersMapRangeReadBitTest;

impl BuffersMapRangeReadBitTest {
    const REFERENCE: [u32; 12] = [1, 2, 4, 8, 16, 64, 128, 256, 512, 1024, 2048, 4096];
    const REFERENCE_SIZE: glw::GLsizeiptr = (12 * std::mem::size_of::<u32>()) as glw::GLsizeiptr;

    /// `CompareWithReference`
    fn compare_with_reference(data: *const u32, offset: glw::GLintptr, length: glw::GLsizeiptr) -> bool {
        if data.is_null() {
            log::info!(
                "glMapNamedBufferRange called with offset {offset} and length {length} returned NULL pointer, but buffer's data was expected."
            );
            return false;
        }

        let start = offset as usize / std::mem::size_of::<u32>();
        let end = (offset + length) as usize / std::mem::size_of::<u32>();
        // SAFETY: the mapping holds `end - start` values until the caller's unmap.
        let mapped = unsafe { std::slice::from_raw_parts(data, end - start) };
        for i in start..end {
            if mapped[i - start] != Self::REFERENCE[i] {
                log::info!(
                    "glMapNamedBufferRange called with offset {offset} and length {length} returned pointer to data which is not identical to reference data."
                );
                return false;
            }
        }
        true
    }
}

impl TestCase for BuffersMapRangeReadBitTest {
    fn name(&self) -> &str {
        "buffers_map_range_read_bit"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut buffer: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let half = Self::REFERENCE_SIZE / 2;

            if gl.named_buffer_storage.is_none()
                || gl.map_named_buffer_range.is_none()
                || gl.unmap_named_buffer.is_none()
            {
                return Err(TestError::Fail("throw 0".to_string()));
            }

            for access_flags in [
                glw::GL_MAP_READ_BIT,
                glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT,
                glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_COHERENT_BIT,
            ] {
                // SAFETY: one name is written to the live local.
                unsafe { gl.create_buffers(1, &mut buffer) };
                glu::expect_no_error(gl, "glCreateBuffers failed.")?;
                // SAFETY: the reference holds REFERENCE_SIZE bytes.
                unsafe {
                    gl.named_buffer_storage(
                        buffer,
                        Self::REFERENCE_SIZE,
                        Self::REFERENCE.as_ptr().cast(),
                        access_flags,
                    )
                };
                glu::expect_no_error(gl, "glNamedBufferData failed.")?;

                for offset in [0, half] {
                    // SAFETY: the range lies inside the buffer; the pointer is read before the unmap.
                    let data = unsafe { gl.map_named_buffer_range(buffer, offset, half, access_flags) };
                    glu::expect_no_error(gl, "glMapNamedBufferRange failed.")?;
                    is_ok &= Self::compare_with_reference(data.cast::<u32>(), offset, half);
                    // SAFETY: the buffer is mapped; upstream ignores the result.
                    unsafe { gl.unmap_named_buffer(buffer) };
                    glu::expect_no_error(gl, "glUnmapNamedBuffer failed.")?;
                }

                // SAFETY: deletes the name created above.
                unsafe { gl.delete_buffers(1, &buffer) };
                buffer = 0;
            }
            Ok(is_ok)
        });

        if buffer != 0 {
            // SAFETY: deletes a name left behind by a failed iteration.
            unsafe { gl.delete_buffers(1, &buffer) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Buffers::MapRangeWriteBitTest`
struct BuffersMapRangeWriteBitTest;

impl BuffersMapRangeWriteBitTest {
    const REFERENCE: [u32; 12] = [1, 2, 4, 8, 16, 64, 128, 256, 512, 1024, 2048, 4096];
    const REFERENCE_SIZE: glw::GLsizeiptr = (12 * std::mem::size_of::<u32>()) as glw::GLsizeiptr;

    /// `CompareWithReference`
    fn compare_with_reference(
        gl: &glw::Functions,
        buffer: glw::GLuint,
        access_flag: glw::GLbitfield,
    ) -> Result<bool, TestError> {
        let mut is_ok = true;

        // SAFETY: a buffer bound and mapped read-only; the slice ends before the unmap.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
            glu::expect_no_error(gl, "glBindBuffer failed.")?;
            let data = gl.map_buffer(glw::GL_ARRAY_BUFFER, glw::GL_READ_ONLY);
            glu::expect_no_error(gl, "glMapBuffer failed.")?;

            if !data.is_null()
                && std::slice::from_raw_parts(data.cast::<u32>(), Self::REFERENCE.len()) != Self::REFERENCE
            {
                let mut access_string = "GL_MAP_WRITE_BIT";
                if access_flag & glw::GL_MAP_INVALIDATE_RANGE_BIT != 0 {
                    access_string = "(GL_MAP_WRITE_BIT | GL_MAP_INVALIDATE_RANGE_BIT)";
                }
                if access_flag & glw::GL_MAP_INVALIDATE_BUFFER_BIT != 0 {
                    access_string = "(GL_MAP_WRITE_BIT | GL_MAP_INVALIDATE_BUFFER_BIT)";
                }
                if access_flag & glw::GL_MAP_FLUSH_EXPLICIT_BIT != 0 {
                    access_string = "(GL_MAP_WRITE_BIT | GL_MAP_FLUSH_EXPLICIT_BIT)";
                }
                if access_flag & glw::GL_MAP_UNSYNCHRONIZED_BIT != 0 {
                    access_string = "(GL_MAP_WRITE_BIT | GL_MAP_UNSYNCHRONIZED_BIT)";
                }
                log::info!(
                    "Test of glMapNamedBufferRange with access flag {access_string} failed to fill the buffer with reference data."
                );
                is_ok = false;
            }

            gl.unmap_buffer(glw::GL_ARRAY_BUFFER);
            glu::expect_no_error(gl, "glUnmapBuffer failed.")?;
        }
        Ok(is_ok)
    }

    /// One mapping: writes `values` through a `glMapNamedBufferRange` of `[offset, offset + half)`, flushes explicitly when asked to, and unmaps.
    fn write_mapping(
        gl: &glw::Functions,
        buffer: glw::GLuint,
        offset: glw::GLintptr,
        access: glw::GLbitfield,
        values: &[u32],
    ) -> Result<(), TestError> {
        let half = Self::REFERENCE_SIZE / 2;

        // SAFETY: the range lies inside the buffer; `values` holds half the reference.
        let data = unsafe { gl.map_named_buffer_range(buffer, offset, half, access) };
        glu::expect_no_error(gl, "glMapNamedBufferRange failed.")?;
        // SAFETY: the mapping holds `values.len()` values until the unmap below.
        let mapped = unsafe { std::slice::from_raw_parts_mut(data.cast::<u32>(), values.len()) };
        mapped.copy_from_slice(values);

        let mut flush_error = glw::GL_NO_ERROR;
        if access & glw::GL_MAP_FLUSH_EXPLICIT_BIT != 0 {
            // SAFETY: flushes the start of the mapped range, as upstream does for both mappings.
            unsafe {
                gl.flush_mapped_named_buffer_range(buffer, 0, half);
                flush_error = gl.get_error();
            }
        }
        // SAFETY: the buffer is mapped.
        unsafe { gl.unmap_named_buffer(buffer) };
        if flush_error != glw::GL_NO_ERROR {
            return Err(TestError::Fail(format!(
                "glFlushMappedNamedBufferRange failed: {}",
                glw::error_name(flush_error)
            )));
        }
        glu::expect_no_error(gl, "glUnmapNamedBuffer failed.")
    }
}

impl TestCase for BuffersMapRangeWriteBitTest {
    fn name(&self) -> &str {
        "buffers_map_range_write_bit"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        /// `creation`, `first_mapping` and `second_mapping` flags
        const ACCESS_FLAGS: [(glw::GLbitfield, glw::GLbitfield, glw::GLbitfield); 5] = [
            (
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT,
                glw::GL_MAP_WRITE_BIT,
                glw::GL_MAP_WRITE_BIT,
            ),
            (
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_INVALIDATE_RANGE_BIT,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_INVALIDATE_RANGE_BIT,
            ),
            (
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_INVALIDATE_BUFFER_BIT,
                glw::GL_MAP_WRITE_BIT,
            ),
            (
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
            ),
            (
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT,
                glw::GL_MAP_WRITE_BIT,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_UNSYNCHRONIZED_BIT,
            ),
        ];
        let gl = context.gl();
        let mut buffer: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let half = Self::REFERENCE_SIZE / 2;
            let count = Self::REFERENCE.len();

            if gl.named_buffer_storage.is_none()
                || gl.map_named_buffer_range.is_none()
                || gl.unmap_named_buffer.is_none()
                || gl.flush_mapped_named_buffer_range.is_none()
            {
                return Err(TestError::Fail("throw 0".to_string()));
            }

            for (creation, first_mapping, second_mapping) in ACCESS_FLAGS {
                // SAFETY: one name is written to the live local.
                unsafe { gl.create_buffers(1, &mut buffer) };
                glu::expect_no_error(gl, "glCreateBuffers failed.")?;
                // SAFETY: a storage allocation without initial data.
                unsafe { gl.named_buffer_storage(buffer, Self::REFERENCE_SIZE, std::ptr::null(), creation) };
                glu::expect_no_error(gl, "glNamedBufferStorage failed.")?;

                Self::write_mapping(gl, buffer, 0, first_mapping, &Self::REFERENCE[..count / 2])?;
                Self::write_mapping(gl, buffer, half, second_mapping, &Self::REFERENCE[count / 2..])?;

                is_ok &= Self::compare_with_reference(gl, buffer, first_mapping | second_mapping)?;

                // SAFETY: deletes the name created above.
                unsafe { gl.delete_buffers(1, &buffer) };
                buffer = 0;
            }
            Ok(is_ok)
        });

        if buffer != 0 {
            // SAFETY: deletes a name left behind by a failed iteration.
            unsafe { gl.delete_buffers(1, &buffer) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Buffers::SubDataQueryTest`
struct BuffersSubDataQueryTest;

impl BuffersSubDataQueryTest {
    const REFERENCE: [u32; 12] = [1, 2, 4, 8, 16, 64, 128, 256, 512, 1024, 2048, 4096];
    const REFERENCE_SIZE: glw::GLsizeiptr = (12 * std::mem::size_of::<u32>()) as glw::GLsizeiptr;
}

impl TestCase for BuffersSubDataQueryTest {
    fn name(&self) -> &str {
        "buffers_get_named_buffer_subdata"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut buffer: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let half = Self::REFERENCE_SIZE / 2;
            let count = Self::REFERENCE.len();

            if gl.named_buffer_data.is_none() || gl.get_named_buffer_sub_data.is_none() {
                return Err(TestError::Fail("throw 0".to_string()));
            }

            // SAFETY: one name is written to the live local.
            unsafe { gl.create_buffers(1, &mut buffer) };
            glu::expect_no_error(gl, "glCreateBuffers failed.")?;
            // SAFETY: the reference holds REFERENCE_SIZE bytes.
            unsafe {
                gl.named_buffer_data(
                    buffer,
                    Self::REFERENCE_SIZE,
                    Self::REFERENCE.as_ptr().cast(),
                    glw::GL_DYNAMIC_COPY,
                )
            };
            glu::expect_no_error(gl, "glNamedBufferData failed.")?;

            let mut data = [0u32; 12];
            // SAFETY: each call writes half the buffer into the matching half of `data`.
            unsafe { gl.get_named_buffer_sub_data(buffer, 0, half, data.as_mut_ptr().cast()) };
            glu::expect_no_error(gl, "glGetNamedBufferSubData failed.")?;
            // SAFETY: as above.
            unsafe { gl.get_named_buffer_sub_data(buffer, half, half, data[count / 2..].as_mut_ptr().cast()) };
            glu::expect_no_error(gl, "glGetNamedBufferSubData failed.")?;

            is_ok &= data == Self::REFERENCE;
            if !is_ok {
                log::info!("glGetNamedBufferSubData returned data which is not identical to reference data.");
            }
            Ok(is_ok)
        });

        if buffer != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_buffers(1, &buffer) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Buffers::DefaultsTest`
struct BuffersDefaultsTest;

impl BuffersDefaultsTest {
    /// `CheckParameterError`
    fn check_parameter_error(gl: &glw::Functions, pname_string: &str, function_string: &str) -> bool {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "{function_string} called with {pname_string} parameter name unexpectedly returned {}error.",
                glw::error_name(error)
            );
            return false;
        }
        true
    }

    /// `CheckValue<T>`
    fn check_value<T: PartialEq + std::fmt::Debug>(
        value: T,
        reference_value: T,
        pname_string: &str,
        function_string: &str,
    ) -> bool {
        if reference_value != value {
            log::info!(
                "{function_string} called with {pname_string} parameter name returned {value:?}, but {reference_value:?} was expected."
            );
            return false;
        }
        true
    }
}

impl TestCase for BuffersDefaultsTest {
    fn name(&self) -> &str {
        "buffers_defaults"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        /// `pname`, its name and the expected value
        const TEST_VALUES: [(glw::GLenum, &str, glw::GLint); 9] = [
            (glw::GL_BUFFER_SIZE, "GL_BUFFER_SIZE", 0),
            (
                glw::GL_BUFFER_USAGE,
                "GL_BUFFER_USAGE",
                glw::GL_STATIC_DRAW as glw::GLint,
            ),
            (
                glw::GL_BUFFER_ACCESS,
                "GL_BUFFER_ACCESS",
                glw::GL_READ_WRITE as glw::GLint,
            ),
            (glw::GL_BUFFER_ACCESS_FLAGS, "GL_BUFFER_ACCESS_FLAGS", 0),
            (
                glw::GL_BUFFER_IMMUTABLE_STORAGE,
                "GL_BUFFER_IMMUTABLE_STORAGE",
                glw::GL_FALSE as glw::GLint,
            ),
            (glw::GL_BUFFER_MAPPED, "GL_BUFFER_MAPPED", glw::GL_FALSE as glw::GLint),
            (glw::GL_BUFFER_MAP_OFFSET, "GL_BUFFER_MAP_OFFSET", 0),
            (glw::GL_BUFFER_MAP_LENGTH, "GL_BUFFER_MAP_LENGTH", 0),
            (glw::GL_BUFFER_STORAGE_FLAGS, "GL_BUFFER_STORAGE_FLAGS", 0),
        ];
        let gl = context.gl();
        let mut buffer: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            if gl.named_buffer_data.is_none()
                || gl.get_named_buffer_parameteri_64v.is_none()
                || gl.get_named_buffer_parameteriv.is_none()
                || gl.get_named_buffer_pointerv.is_none()
            {
                return Err(TestError::Fail("throw 0".to_string()));
            }

            // SAFETY: one name is written to the live local.
            unsafe { gl.create_buffers(1, &mut buffer) };
            glu::expect_no_error(gl, "glCreateBuffers failed.")?;

            for (pname, pname_string, expected_data) in TEST_VALUES {
                let mut data: glw::GLint = -1;
                // SAFETY: the value is written to a live local.
                unsafe { gl.get_named_buffer_parameteriv(buffer, pname, &mut data) };
                is_ok &= Self::check_parameter_error(gl, pname_string, "glGetNamedBufferParameteriv");
                is_ok &= Self::check_value(data, expected_data, pname_string, "glGetNamedBufferParameteriv");
            }

            for (pname, pname_string, expected_data) in TEST_VALUES {
                let mut data: glw::GLint64 = -1;
                // SAFETY: the value is written to a live local.
                unsafe { gl.get_named_buffer_parameteri_64v(buffer, pname, &mut data) };
                is_ok &= Self::check_parameter_error(gl, pname_string, "glGetNamedBufferParameteri64v");
                is_ok &= Self::check_value(
                    data,
                    glw::GLint64::from(expected_data),
                    pname_string,
                    "glGetNamedBufferParameteri64v",
                );
            }

            let mut data: *mut std::ffi::c_void = std::ptr::dangling_mut::<std::ffi::c_void>();
            // SAFETY: the pointer is written to a live local.
            unsafe { gl.get_named_buffer_pointerv(buffer, glw::GL_BUFFER_MAP_POINTER, &mut data) };
            is_ok &= Self::check_parameter_error(gl, "GL_BUFFER_MAP_POINTER", "glGetNamedBufferPointer");
            is_ok &= Self::check_value(
                data,
                std::ptr::null_mut(),
                "GL_BUFFER_MAP_POINTER",
                "glGetNamedBufferParameteriv",
            );
            Ok(is_ok)
        });

        if buffer != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_buffers(1, &buffer) };
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------
// Renderbuffers

/// `Renderbuffers::CreationTest`
struct RenderbuffersCreationTest;

impl TestCase for RenderbuffersCreationTest {
    fn name(&self) -> &str {
        "renderbuffers_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const COUNT: usize = 2;
        let gl = context.gl();
        let mut renderbuffers_legacy = [0 as glw::GLuint; COUNT];
        let mut renderbuffers_dsa = [0 as glw::GLuint; COUNT];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: COUNT names are written to the live array.
            unsafe { gl.gen_renderbuffers(COUNT as glw::GLsizei, renderbuffers_legacy.as_mut_ptr()) };
            glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;

            for renderbuffer in &renderbuffers_legacy {
                // SAFETY: plain query.
                if unsafe { gl.is_renderbuffer(*renderbuffer) } != 0 {
                    is_ok = false;
                    log::info!("GenRenderbuffers has created default objects, but it should create only a names.");
                }
            }

            // SAFETY: COUNT names are written to the live array.
            unsafe { gl.create_renderbuffers(COUNT as glw::GLsizei, renderbuffers_dsa.as_mut_ptr()) };
            glu::expect_no_error(gl, "glCreateRenderbuffers has failed")?;

            for renderbuffer in &renderbuffers_dsa {
                // SAFETY: plain query.
                if unsafe { gl.is_renderbuffer(*renderbuffer) } == 0 {
                    is_ok = false;
                    log::info!("CreateRenderbuffers has not created default objects.");
                }
            }
            Ok(is_ok)
        });

        for renderbuffer in renderbuffers_legacy.iter().chain(&renderbuffers_dsa) {
            if *renderbuffer != 0 {
                // SAFETY: deletes a name generated above.
                unsafe { gl.delete_renderbuffers(1, renderbuffer) };
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Renderbuffers::CreationErrorsTest`
struct RenderbuffersCreationErrorsTest;

impl TestCase for RenderbuffersCreationErrorsTest {
    fn name(&self) -> &str {
        "renderbuffers_creation_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;
        let mut renderbuffer: glw::GLuint = 0;

        // SAFETY: a negative count is the error this call is expected to generate; nothing is written.
        unsafe { gl.create_renderbuffers(-1, &mut renderbuffer) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_INVALID_VALUE {
            log::info!(
                "CreateRenderbuffers generated {} error when called with negative number of renderbuffers, but GL_INVALID_VALUE was expected.",
                glw::error_name(error)
            );
            is_ok = false;
        }

        if renderbuffer != 0 {
            // SAFETY: deletes a name the driver wrote despite the error.
            unsafe { gl.delete_renderbuffers(1, &renderbuffer) };
        }
        clean_errors(gl);

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `RenderbufferInternalFormatConfiguration` of `Renderbuffers::StorageTest` and `Renderbuffers::StorageMultisampleTest` (the two tables are identical).
struct RbFormat {
    internalformat: glw::GLenum,
    internalformat_name: &'static str,
    has_red: bool,
    has_green: bool,
    has_blue: bool,
    has_alpha: bool,
    has_depth: bool,
    has_stencil: bool,
    is_color_integral: bool,
}

impl RbFormat {
    #[allow(clippy::too_many_arguments)]
    const fn new(
        internalformat: glw::GLenum,
        internalformat_name: &'static str,
        has_red: bool,
        has_green: bool,
        has_blue: bool,
        has_alpha: bool,
        has_depth: bool,
        has_stencil: bool,
        is_color_integral: bool,
    ) -> Self {
        Self {
            internalformat,
            internalformat_name,
            has_red,
            has_green,
            has_blue,
            has_alpha,
            has_depth,
            has_stencil,
            is_color_integral,
        }
    }

    fn has_color(&self) -> bool {
        self.has_red || self.has_green || self.has_blue || self.has_alpha
    }
}

const RB_FORMATS: [RbFormat; 43] = [
    RbFormat::new(glw::GL_R8, "GL_R8", true, false, false, false, false, false, false),
    RbFormat::new(glw::GL_R16, "GL_R16", true, false, false, false, false, false, false),
    RbFormat::new(glw::GL_RG8, "GL_RG8", true, true, false, false, false, false, false),
    RbFormat::new(glw::GL_RG16, "GL_RG16", true, true, false, false, false, false, false),
    RbFormat::new(glw::GL_RGB565, "GL_RGB56", true, true, true, false, false, false, false),
    RbFormat::new(glw::GL_RGBA4, "GL_RGBA4", true, true, true, true, false, false, false),
    RbFormat::new(
        glw::GL_RGB5_A1,
        "GL_RGB5_A1",
        true,
        true,
        true,
        true,
        false,
        false,
        false,
    ),
    RbFormat::new(glw::GL_RGBA8, "GL_RGBA8", true, true, true, true, false, false, false),
    RbFormat::new(
        glw::GL_RGB10_A2,
        "GL_RGB10_A2",
        true,
        true,
        true,
        true,
        false,
        false,
        false,
    ),
    RbFormat::new(
        glw::GL_RGB10_A2UI,
        "GL_RGB10_A2UI",
        true,
        true,
        true,
        true,
        false,
        false,
        true,
    ),
    RbFormat::new(glw::GL_RGBA16, "GL_RGBA16", true, true, true, true, false, false, false),
    RbFormat::new(
        glw::GL_SRGB8_ALPHA8,
        "GL_SRGB8_ALPHA8",
        true,
        true,
        true,
        true,
        false,
        false,
        false,
    ),
    RbFormat::new(glw::GL_R16F, "GL_R16F", true, false, false, false, false, false, false),
    RbFormat::new(glw::GL_RG16F, "GL_RG16F", true, true, false, false, false, false, false),
    RbFormat::new(
        glw::GL_RGBA16F,
        "GL_RGBA16F",
        true,
        true,
        true,
        true,
        false,
        false,
        false,
    ),
    RbFormat::new(glw::GL_R32F, "GL_R32F", true, false, false, false, false, false, false),
    RbFormat::new(glw::GL_RG32F, "GL_RG32F", true, true, false, false, false, false, false),
    RbFormat::new(
        glw::GL_RGBA32F,
        "GL_RGBA32F",
        true,
        true,
        true,
        true,
        false,
        false,
        false,
    ),
    RbFormat::new(
        glw::GL_R11F_G11F_B10F,
        "GL_R11F_G11F_B10F",
        true,
        true,
        true,
        false,
        false,
        false,
        false,
    ),
    RbFormat::new(glw::GL_R8I, "GL_R8I", true, false, false, false, false, false, true),
    RbFormat::new(glw::GL_R8UI, "GL_R8UI", true, false, false, false, false, false, true),
    RbFormat::new(glw::GL_R16I, "GL_R16I", true, false, false, false, false, false, true),
    RbFormat::new(glw::GL_R16UI, "GL_R16UI", true, false, false, false, false, false, true),
    RbFormat::new(glw::GL_R32I, "GL_R32I", true, false, false, false, false, false, true),
    RbFormat::new(glw::GL_R32UI, "GL_R32UI", true, false, false, false, false, false, true),
    RbFormat::new(glw::GL_RG8I, "GL_RG8I", true, true, false, false, false, false, true),
    RbFormat::new(glw::GL_RG8UI, "GL_RG8UI", true, true, false, false, false, false, true),
    RbFormat::new(glw::GL_RG16I, "GL_RG16I", true, true, false, false, false, false, true),
    RbFormat::new(
        glw::GL_RG16UI,
        "GL_RG16UI",
        true,
        true,
        false,
        false,
        false,
        false,
        true,
    ),
    RbFormat::new(glw::GL_RG32I, "GL_RG32I", true, true, false, false, false, false, true),
    RbFormat::new(
        glw::GL_RG32UI,
        "GL_RG32UI",
        true,
        true,
        false,
        false,
        false,
        false,
        true,
    ),
    RbFormat::new(glw::GL_RGBA8I, "GL_RGBA8I", true, true, true, true, false, false, true),
    RbFormat::new(
        glw::GL_RGBA8UI,
        "GL_RGBA8UI",
        true,
        true,
        true,
        true,
        false,
        false,
        true,
    ),
    RbFormat::new(
        glw::GL_RGBA16I,
        "GL_RGBA16I",
        true,
        true,
        true,
        true,
        false,
        false,
        true,
    ),
    RbFormat::new(
        glw::GL_RGBA16UI,
        "GL_RGBA16UI",
        true,
        true,
        true,
        true,
        false,
        false,
        true,
    ),
    RbFormat::new(
        glw::GL_RGBA32I,
        "GL_RGBA32I",
        true,
        true,
        true,
        true,
        false,
        false,
        true,
    ),
    RbFormat::new(
        glw::GL_RGBA32UI,
        "GL_RGBA32UI",
        true,
        true,
        true,
        true,
        false,
        false,
        true,
    ),
    RbFormat::new(
        glw::GL_DEPTH_COMPONENT16,
        "GL_DEPTH_COMPONENT16",
        false,
        false,
        false,
        false,
        true,
        false,
        false,
    ),
    RbFormat::new(
        glw::GL_DEPTH_COMPONENT24,
        "GL_DEPTH_COMPONENT24",
        false,
        false,
        false,
        false,
        true,
        false,
        false,
    ),
    RbFormat::new(
        glw::GL_DEPTH_COMPONENT32F,
        "GL_DEPTH_COMPONENT32F",
        false,
        false,
        false,
        false,
        true,
        false,
        false,
    ),
    RbFormat::new(
        glw::GL_DEPTH24_STENCIL8,
        "GL_DEPTH24_STENCIL8",
        false,
        false,
        false,
        false,
        true,
        true,
        false,
    ),
    RbFormat::new(
        glw::GL_DEPTH32F_STENCIL8,
        "GL_DEPTH32F_STENCIL8",
        false,
        false,
        false,
        false,
        true,
        true,
        false,
    ),
    RbFormat::new(
        glw::GL_STENCIL_INDEX8,
        "GL_STENCIL_INDEX8",
        false,
        false,
        false,
        false,
        false,
        true,
        false,
    ),
];

const RB_REFERENCE_COLOR: [glw::GLfloat; 4] = [0.25, 0.5, 0.75, 1.0];
const RB_REFERENCE_COLOR_INTEGER: [glw::GLint; 4] = [1, 2, 3, 4];
const RB_REFERENCE_DEPTH: glw::GLfloat = 0.5;
const RB_REFERENCE_STENCIL: glw::GLint = 7;

/// `NamedFramebufferRenderbuffer` calls shared by both `PrepareRenderbuffer`s.
fn rb_attach(gl: &glw::Functions, fbo: glw::GLuint, rbo: glw::GLuint, format: &RbFormat) {
    // SAFETY: plain calls on names owned by the caller; errors are checked by the framebuffer status afterwards.
    unsafe {
        if format.has_color() {
            gl.named_framebuffer_renderbuffer(fbo, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, rbo);
        }
        if format.has_depth {
            gl.named_framebuffer_renderbuffer(fbo, glw::GL_DEPTH_ATTACHMENT, glw::GL_RENDERBUFFER, rbo);
        }
        if format.has_stencil {
            gl.named_framebuffer_renderbuffer(fbo, glw::GL_STENCIL_ATTACHMENT, glw::GL_RENDERBUFFER, rbo);
        }
    }
}

/// `Clear` of both renderbuffer tests.
fn rb_clear(gl: &glw::Functions, is_color_integral_format: bool) -> Result<(), TestError> {
    // SAFETY: the integer clear value points at four ints.
    unsafe {
        if is_color_integral_format {
            gl.clear_bufferiv(glw::GL_COLOR, 0, RB_REFERENCE_COLOR_INTEGER.as_ptr());
            glu::expect_no_error(gl, "glClearBufferiv has failed")
        } else {
            gl.clear_color(
                RB_REFERENCE_COLOR[0],
                RB_REFERENCE_COLOR[1],
                RB_REFERENCE_COLOR[2],
                RB_REFERENCE_COLOR[3],
            );
            gl.clear_depth(RB_REFERENCE_DEPTH as f64);
            gl.clear_stencil(RB_REFERENCE_STENCIL);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            Ok(())
        }
    }
}

/// `Check` of both renderbuffer tests; `what` is "Renderbuffer storage" or "Renderbuffer storage multisample".
fn rb_check(
    gl: &glw::Functions,
    what: &str,
    format: &RbFormat,
    width: glw::GLuint,
    height: glw::GLuint,
) -> Result<bool, TestError> {
    const COMPONENT_NAMES: [&str; 4] = ["red", "green", "blue", "alpha"];
    let size = width as usize * height as usize;
    let has_component = [format.has_red, format.has_green, format.has_blue, format.has_alpha];

    if format.has_color() {
        if format.is_color_integral {
            let mut color = vec![0 as glw::GLint; size * 4];
            // SAFETY: the buffer holds width * height RGBA int pixels.
            unsafe {
                gl.read_pixels(
                    0,
                    0,
                    width as glw::GLsizei,
                    height as glw::GLsizei,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_INT,
                    color.as_mut_ptr().cast(),
                )
            };
            glu::expect_no_error(gl, "glReadPixels call failed.")?;

            for i in 0..size {
                if has_component[i % 4] && (RB_REFERENCE_COLOR_INTEGER[i % 4] - color[i]).abs() > 2 {
                    log::info!(
                        "{what} was cleared with color {} component equal to {}, but fetched value {} is not the same. Renderbuffers format was {}, width was {width}, height was {height}.",
                        COMPONENT_NAMES[i % 4],
                        RB_REFERENCE_COLOR_INTEGER[i % 4],
                        color[i],
                        format.internalformat_name
                    );
                    return Ok(false);
                }
            }
        } else {
            let mut color = vec![0 as glw::GLfloat; size * 4];
            // SAFETY: the buffer holds width * height RGBA float pixels.
            unsafe {
                gl.read_pixels(
                    0,
                    0,
                    width as glw::GLsizei,
                    height as glw::GLsizei,
                    glw::GL_RGBA,
                    glw::GL_FLOAT,
                    color.as_mut_ptr().cast(),
                )
            };
            glu::expect_no_error(gl, "glReadPixels call failed.")?;

            for i in 0..size {
                if has_component[i % 4] && (RB_REFERENCE_COLOR[i % 4] - color[i]).abs() > 0.0625 {
                    log::info!(
                        "{what} was cleared with color {} component equal to {}, but fetched value {} is not the same. Renderbuffers format was {}, width was {width}, height was {height}.",
                        COMPONENT_NAMES[i % 4],
                        RB_REFERENCE_COLOR[i % 4],
                        color[i],
                        format.internalformat_name
                    );
                    return Ok(false);
                }
            }
        }
    }

    if format.has_depth {
        let mut depth = vec![0 as glw::GLfloat; size];
        // SAFETY: the buffer holds width * height floats.
        unsafe {
            gl.read_pixels(
                0,
                0,
                width as glw::GLsizei,
                height as glw::GLsizei,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_FLOAT,
                depth.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels call failed.")?;

        for value in &depth {
            if (RB_REFERENCE_DEPTH - value).abs() > 0.0625 {
                log::info!(
                    "{what} was cleared with depth component equal to {RB_REFERENCE_DEPTH}, but fetched value {value} is not the same. Renderbuffers format was {}, width was {width}, height was {height}.",
                    format.internalformat_name
                );
                return Ok(false);
            }
        }
    }

    if format.has_stencil {
        let mut stencil = vec![0 as glw::GLint; size];
        // SAFETY: the buffer holds width * height ints.
        unsafe {
            gl.read_pixels(
                0,
                0,
                width as glw::GLsizei,
                height as glw::GLsizei,
                glw::GL_STENCIL_INDEX,
                glw::GL_INT,
                stencil.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels call failed.")?;

        for value in &stencil {
            if RB_REFERENCE_STENCIL != *value {
                log::info!(
                    "{what} was cleared with alpha component equal to {RB_REFERENCE_STENCIL}, but fetched value {value} is not the same. Renderbuffers format was {}, width was {width}, height was {height}.",
                    format.internalformat_name
                );
                return Ok(false);
            }
        }
    }

    Ok(true)
}

/// `Clean` of both renderbuffer tests.
fn rb_clean(gl: &glw::Functions, fbos: &mut [glw::GLuint], rbos: &mut [glw::GLuint]) {
    // SAFETY: deletes the names the caller created and restores the default clear values.
    unsafe {
        for rbo in rbos.iter_mut() {
            if *rbo != 0 {
                gl.delete_renderbuffers(1, rbo);
                *rbo = 0;
            }
        }
        for fbo in fbos.iter_mut() {
            if *fbo != 0 {
                gl.delete_framebuffers(1, fbo);
                *fbo = 0;
            }
        }
        gl.clear_color(0.0, 0.0, 0.0, 0.0);
        gl.clear_depth(1.0);
        gl.clear_stencil(0);
    }
    clean_errors(gl);
}

/// `Renderbuffers::StorageTest`
struct RenderbuffersStorageTest;

impl RenderbuffersStorageTest {
    /// `PrepareRenderbuffer`
    fn prepare_renderbuffer(
        gl: &glw::Functions,
        format: &RbFormat,
        width: glw::GLuint,
        height: glw::GLuint,
        fbo: &mut glw::GLuint,
        rbo: &mut glw::GLuint,
    ) -> Result<bool, TestError> {
        // SAFETY: names are written to live locals; every call works on those names.
        unsafe {
            gl.gen_framebuffers(1, fbo);
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;

            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, *fbo);
            glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;

            gl.create_renderbuffers(1, rbo);
            glu::expect_no_error(gl, "glCreateRenderbuffers call failed.")?;

            gl.named_renderbuffer_storage(
                *rbo,
                format.internalformat,
                width as glw::GLsizei,
                height as glw::GLsizei,
            );

            let error = gl.get_error();
            if error != glw::GL_NO_ERROR {
                log::info!(
                    "Renderbuffer storage test failed because NamedRenderbufferStorage generated {} error value. Renderbuffers format was {}, width was {width}, height was {height}.",
                    glw::error_name(error),
                    format.internalformat_name
                );
                return Ok(false);
            }
        }

        rb_attach(gl, *fbo, *rbo, format);

        // SAFETY: plain state query.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!(
                "Renderbuffer storage test failed due to incomplete framebuffer status. Renderbuffers format was {}, width was {width}, height was {height}.",
                format.internalformat_name
            );
            return Ok(false);
        }

        Ok(true)
    }
}

impl TestCase for RenderbuffersStorageTest {
    fn name(&self) -> &str {
        "renderbuffers_storage"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut fbo: [glw::GLuint; 1] = [0];
        let mut rbo: [glw::GLuint; 1] = [0];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let mut max_renderbuffer_size: glw::GLint = 16384;

            // SAFETY: one int is written to the live local.
            unsafe { gl.get_integerv(glw::GL_MAX_RENDERBUFFER_SIZE, &mut max_renderbuffer_size) };
            glu::expect_no_error(gl, "glGetIntegerv call failed.")?;

            let max = max_renderbuffer_size as glw::GLuint;
            let test_cases: [(glw::GLuint, glw::GLuint); 5] = [(1, 1), (256, 512), (1280, 720), (max, 1), (1, max)];

            for (width, height) in test_cases {
                for format in &RB_FORMATS {
                    if Self::prepare_renderbuffer(gl, format, width, height, &mut fbo[0], &mut rbo[0])? {
                        rb_clear(gl, format.is_color_integral)?;
                        is_ok &= rb_check(gl, "Renderbuffer storage", format, width, height)?;
                    } else {
                        is_ok = false;
                    }

                    rb_clean(gl, &mut fbo, &mut rbo);
                }
            }
            Ok(is_ok)
        });
        rb_clean(gl, &mut fbo, &mut rbo);
        outcome
    }
}

/// `Renderbuffers::StorageMultisampleTest`
struct RenderbuffersStorageMultisampleTest;

impl RenderbuffersStorageMultisampleTest {
    /// `PrepareRenderbuffer`
    fn prepare_renderbuffer(
        gl: &glw::Functions,
        format: &RbFormat,
        width: glw::GLuint,
        height: glw::GLuint,
        samples: glw::GLsizei,
        fbo: &mut [glw::GLuint; 2],
        rbo: &mut [glw::GLuint; 2],
    ) -> Result<bool, TestError> {
        // SAFETY: two names are written to each live array.
        unsafe {
            gl.gen_framebuffers(2, fbo.as_mut_ptr());
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;

            gl.create_renderbuffers(2, rbo.as_mut_ptr());
            glu::expect_no_error(gl, "glCreateRenderbuffers call failed.")?;
        }

        for i in 0..2 {
            // The second renderbuffer is not multisampled.
            let samples = if i == 1 { 0 } else { samples };

            // SAFETY: every call works on the names created above.
            unsafe {
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[i]);
                glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;

                gl.named_renderbuffer_storage_multisample(
                    rbo[i],
                    samples,
                    format.internalformat,
                    width as glw::GLsizei,
                    height as glw::GLsizei,
                );

                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!(
                        "Renderbuffer storage multisample test failed because NamedRenderbufferStorageMultisample generated {} error value. Renderbuffers format was {}, samples was {samples}, width was {width}, height was {height}.",
                        glw::error_name(error),
                        format.internalformat_name
                    );
                    return Ok(false);
                }
            }

            rb_attach(gl, fbo[i], rbo[i], format);

            // SAFETY: plain state query.
            let status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!(
                    "Renderbuffer storage multisample test failed due to {status:#x} framebuffer status. Renderbuffers format was {}, samples was {samples}, width was {width}, height was {height}.",
                    format.internalformat_name
                );
                return Ok(false);
            }
        }

        Ok(true)
    }

    fn bind(
        gl: &glw::Functions,
        fbo: &[glw::GLuint; 2],
        target: glw::GLenum,
        selector: usize,
    ) -> Result<(), TestError> {
        // SAFETY: binds a framebuffer name created by the caller.
        unsafe { gl.bind_framebuffer(target, fbo[selector]) };
        glu::expect_no_error(gl, "glBindFramebuffer call failed.")
    }

    fn blit(gl: &glw::Functions, width: glw::GLuint, height: glw::GLuint) -> Result<(), TestError> {
        let (width, height) = (width as glw::GLint, height as glw::GLint);
        // SAFETY: plain call on the bound framebuffers.
        unsafe {
            gl.blit_framebuffer(
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height,
                glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
                glw::GL_NEAREST,
            );
        }
        glu::expect_no_error(gl, "glBindFramebuffer call failed.")
    }

    /// `GetMaxConformantSampleCount`
    fn get_max_conformant_sample_count(
        context: &Context,
        target: glw::GLenum,
        internalformat: glw::GLenum,
    ) -> Result<glw::GLint, TestError> {
        let gl = context.gl();
        let mut max_conformant_samples: glw::GLint = 0;

        if context
            .context_info
            .is_extension_supported("GL_NV_internalformat_sample_query")
        {
            let mut sample_counts: glw::GLint = 0;
            // SAFETY: one int is written to the live local.
            unsafe {
                gl.get_internalformativ(target, internalformat, glw::GL_NUM_SAMPLE_COUNTS, 1, &mut sample_counts)
            };
            glu::expect_no_error(gl, "glGetInternalformativ() failed for GL_NUM_SAMPLE_COUNTS pname")?;

            let mut supported_samples = vec![0 as glw::GLint; sample_counts.max(0) as usize];
            // SAFETY: the vector holds `sample_counts` ints.
            unsafe {
                gl.get_internalformativ(
                    target,
                    internalformat,
                    glw::GL_SAMPLES,
                    sample_counts,
                    supported_samples.as_mut_ptr(),
                )
            };

            for &samples in &supported_samples {
                let mut is_conformant: glw::GLint = 0;
                // SAFETY: one int is written to the live local.
                unsafe {
                    gl.get_internalformat_sampleiv_nv(
                        target,
                        internalformat,
                        samples,
                        glw::GL_CONFORMANT_NV,
                        1,
                        &mut is_conformant,
                    )
                };
                glu::expect_no_error(gl, "glGetInternalformatSampleivNV() call(s) failed")?;

                if is_conformant != 0 && samples > max_conformant_samples {
                    max_conformant_samples = samples;
                }
            }
        } else {
            // SAFETY: one int is written to the live local.
            unsafe { gl.get_integerv(glw::GL_MAX_INTEGER_SAMPLES, &mut max_conformant_samples) };
            glu::expect_no_error(gl, "glGetIntegerv() call failed for GL_MAX_INTEGER_SAMPLES pname.")?;
        }

        Ok(max_conformant_samples)
    }
}

impl TestCase for RenderbuffersStorageMultisampleTest {
    fn name(&self) -> &str {
        "renderbuffers_storage_multisample"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut fbo: [glw::GLuint; 2] = [0; 2];
        let mut rbo: [glw::GLuint; 2] = [0; 2];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let mut max_renderbuffer_size: glw::GLint = 16384;

            // SAFETY: one int is written to the live local.
            unsafe { gl.get_integerv(glw::GL_MAX_RENDERBUFFER_SIZE, &mut max_renderbuffer_size) };
            glu::expect_no_error(gl, "glGetIntegerv call failed.")?;

            let half = max_renderbuffer_size as glw::GLuint / 2;
            let test_cases: [(glw::GLuint, glw::GLuint); 3] = [(1, 1), (half, 1), (1, half)];

            for (width, height) in test_cases {
                for format in &RB_FORMATS {
                    let max_integer_samples =
                        Self::get_max_conformant_sample_count(context, glw::GL_RENDERBUFFER, format.internalformat)?;
                    for samples in 0..=max_integer_samples {
                        if Self::prepare_renderbuffer(gl, format, width, height, samples, &mut fbo, &mut rbo)? {
                            Self::bind(gl, &fbo, glw::GL_DRAW_FRAMEBUFFER, 0)?;
                            rb_clear(gl, format.is_color_integral)?;
                            Self::bind(gl, &fbo, glw::GL_READ_FRAMEBUFFER, 0)?;
                            Self::bind(gl, &fbo, glw::GL_DRAW_FRAMEBUFFER, 1)?;
                            Self::blit(gl, width, height)?;
                            Self::bind(gl, &fbo, glw::GL_READ_FRAMEBUFFER, 1)?;
                            is_ok &= rb_check(gl, "Renderbuffer storage multisample", format, width, height)?;
                        } else {
                            is_ok = false;
                        }

                        rb_clean(gl, &mut fbo, &mut rbo);
                    }
                }
            }
            Ok(is_ok)
        });
        rb_clean(gl, &mut fbo, &mut rbo);
        outcome
    }
}

/// `Renderbuffers::GetParametersTest`
struct RenderbuffersGetParametersTest;

impl TestCase for RenderbuffersGetParametersTest {
    fn name(&self) -> &str {
        "renderbuffers_get_parameters"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const INTERNALFORMATS: [(glw::GLenum, &str); 4] = [
            (glw::GL_RGBA8, "GL_RGBA8"),
            (glw::GL_DEPTH_COMPONENT24, "GL_DEPTH_COMPONENT24"),
            (glw::GL_STENCIL_INDEX8, "GL_STENCIL_INDEX8"),
            (glw::GL_DEPTH24_STENCIL8, "GL_DEPTH24_STENCIL8"),
        ];
        const PNAMES: [(glw::GLenum, &str); 10] = [
            (glw::GL_RENDERBUFFER_WIDTH, "GL_RENDERBUFFER_WIDTH"),
            (glw::GL_RENDERBUFFER_HEIGHT, "GL_RENDERBUFFER_HEIGHT"),
            (glw::GL_RENDERBUFFER_INTERNAL_FORMAT, "GL_RENDERBUFFER_INTERNAL_FORMAT"),
            (glw::GL_RENDERBUFFER_SAMPLES, "GL_RENDERBUFFER_SAMPLES"),
            (glw::GL_RENDERBUFFER_RED_SIZE, "GL_RENDERBUFFER_RED_SIZE"),
            (glw::GL_RENDERBUFFER_GREEN_SIZE, "GL_RENDERBUFFER_GREEN_SIZE"),
            (glw::GL_RENDERBUFFER_BLUE_SIZE, "GL_RENDERBUFFER_BLUE_SIZE"),
            (glw::GL_RENDERBUFFER_ALPHA_SIZE, "GL_RENDERBUFFER_ALPHA_SIZE"),
            (glw::GL_RENDERBUFFER_DEPTH_SIZE, "GL_RENDERBUFFER_DEPTH_SIZE"),
            (glw::GL_RENDERBUFFER_STENCIL_SIZE, "GL_RENDERBUFFER_STENCIL_SIZE"),
        ];
        let gl = context.gl();
        let mut renderbuffer: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            for (i, (internalformat, internalformat_name)) in INTERNALFORMATS.into_iter().enumerate() {
                // SAFETY: a name is written to the live local, then bound and given a 1x2 storage.
                unsafe {
                    gl.gen_renderbuffers(1, &mut renderbuffer);
                    glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
                    glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;
                    gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internalformat, 1, 2);
                    glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                }

                // Upstream's inner loop runs over `internalformats_count` (four) entries of `pnames` and logs `pnames_strings[i]`.
                for (pname, _) in PNAMES.into_iter().take(INTERNALFORMATS.len()) {
                    let pname_string = PNAMES[i].1;
                    let mut parameter_legacy: glw::GLint = 0;
                    let mut parameter_dsa: glw::GLint = 0;

                    // SAFETY: the values are written to live locals.
                    unsafe { gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, pname, &mut parameter_legacy) };
                    glu::expect_no_error(gl, "glGetRenderbufferParameteriv has failed")?;
                    // SAFETY: as above.
                    unsafe { gl.get_named_renderbuffer_parameteriv(renderbuffer, pname, &mut parameter_dsa) };
                    // SAFETY: plain state query.
                    let error = unsafe { gl.get_error() };
                    if error != glw::GL_NO_ERROR {
                        log::info!(
                            "GetNamedRenderbufferParameteriv unexpectedly generated {} error when called with {pname_string} parameter name of renderbuffer with  internalformat = {internalformat_name}, width = 1, height = 2.",
                            glw::error_name(error)
                        );
                        is_ok = false;
                        continue;
                    }

                    if parameter_legacy != parameter_dsa {
                        log::info!(
                            "GetNamedRenderbufferParameteriv returned {parameter_dsa}, but {parameter_legacy} was expected for {pname_string} parameter name of renderbuffer with  internalformat = {internalformat_name}, width = 1, height = 2."
                        );
                        is_ok = false;
                    }
                }

                // SAFETY: deletes the name created above.
                unsafe { gl.delete_renderbuffers(1, &renderbuffer) };
                glu::expect_no_error(gl, "glDeleteRenderbuffers has failed")?;
                renderbuffer = 0;
            }
            Ok(is_ok)
        });

        if renderbuffer != 0 {
            // SAFETY: deletes a name left behind by a failed iteration.
            unsafe { gl.delete_renderbuffers(1, &renderbuffer) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Renderbuffers::StorageErrorsTest`
struct RenderbuffersStorageErrorsTest;

impl RenderbuffersStorageErrorsTest {
    /// `ExpectError`: the error has to be `expected_error`; every pending error is drained.
    fn expect_error(gl: &glw::Functions, expected_error: glw::GLenum, function: &str, conditions: &str) -> bool {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        let is_ok = error == expected_error;
        if !is_ok {
            log::info!(
                "{function} was expected to generate {}, but {} was observed instead when {conditions}",
                glw::error_name(expected_error),
                glw::error_name(error)
            );
        }
        clean_errors(gl);
        is_ok
    }
}

impl TestCase for RenderbuffersStorageErrorsTest {
    fn name(&self) -> &str {
        "renderbuffers_storage_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rbo_valid: glw::GLuint = 0;
        let internalformat_invalid = glw::GL_COMPRESSED_RED;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // PrepareObjects
            // SAFETY: a name is written to the live local, then bound.
            unsafe {
                gl.gen_renderbuffers(1, &mut rbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
            }
            let mut rbo_invalid: glw::GLuint = 0;
            loop {
                rbo_invalid += 1;
                // SAFETY: plain query.
                if unsafe { gl.is_renderbuffer(rbo_invalid) } == 0 {
                    break;
                }
            }

            // renderbuffer is not the name of an existing renderbuffer object.
            // SAFETY: every call below is expected to fail validation.
            unsafe { gl.named_renderbuffer_storage(rbo_invalid, glw::GL_RGBA8, 1, 1) };
            is_ok &= Self::expect_error(
                gl,
                glw::GL_INVALID_OPERATION,
                "NamedRenderbufferStorage",
                "renderbuffer is not the name of an existing renderbuffer object.",
            );

            // either of width or height is negative, or greater than the value of MAX_RENDERBUFFER_SIZE.
            // SAFETY: as above.
            unsafe { gl.named_renderbuffer_storage(rbo_valid, glw::GL_RGBA8, -1, 1) };
            is_ok &= Self::expect_error(
                gl,
                glw::GL_INVALID_VALUE,
                "NamedRenderbufferStorage",
                "either of width is negative.",
            );
            // SAFETY: as above.
            unsafe { gl.named_renderbuffer_storage(rbo_valid, glw::GL_RGBA8, 1, -1) };
            is_ok &= Self::expect_error(
                gl,
                glw::GL_INVALID_VALUE,
                "NamedRenderbufferStorage",
                "either of height is negative.",
            );

            // internalformat is not a color-renderable, depth-renderable, or stencil-renderable format.
            // SAFETY: as above.
            unsafe { gl.named_renderbuffer_storage(rbo_valid, internalformat_invalid, 1, 1) };
            is_ok &= Self::expect_error(
                gl,
                glw::GL_INVALID_ENUM,
                "NamedRenderbufferStorage",
                "internalformat is not a color-renderable, depth-renderable, or stencil-renderable format (it is COMPRESSED_RED).",
            );
            Ok(is_ok)
        });

        // Clean
        if rbo_valid != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_renderbuffers(1, &rbo_valid) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Renderbuffers::StorageMultisampleErrorsTest`
struct RenderbuffersStorageMultisampleErrorsTest;

impl TestCase for RenderbuffersStorageMultisampleErrorsTest {
    fn name(&self) -> &str {
        "renderbuffers_storage_multisample_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rbo_valid: glw::GLuint = 0;
        let internalformat_invalid = glw::GL_COMPRESSED_RED;
        let expect_error = RenderbuffersStorageErrorsTest::expect_error;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let (mut max_samples, mut max_integer_samples): (glw::GLint, glw::GLint) = (0, 0);

            // PrepareObjects
            // SAFETY: a name is written to the live local, then bound; the sample counts are written to live locals.
            unsafe {
                gl.gen_renderbuffers(1, &mut rbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.get_internalformativ(
                    glw::GL_RENDERBUFFER,
                    glw::GL_RGBA8,
                    glw::GL_SAMPLES,
                    1,
                    &mut max_samples,
                );
                glu::expect_no_error(gl, "glGetInternalformativ has failed")?;
                gl.get_internalformativ(
                    glw::GL_RENDERBUFFER,
                    glw::GL_RGB10_A2UI,
                    glw::GL_SAMPLES,
                    1,
                    &mut max_integer_samples,
                );
                glu::expect_no_error(gl, "glGetInternalformativ has failed")?;
            }
            let mut rbo_invalid: glw::GLuint = 0;
            loop {
                rbo_invalid += 1;
                // SAFETY: plain query.
                if unsafe { gl.is_renderbuffer(rbo_invalid) } == 0 {
                    break;
                }
            }

            // SAFETY: every call below is expected to fail validation.
            unsafe { gl.named_renderbuffer_storage_multisample(rbo_invalid, 1, glw::GL_RGBA8, 1, 1) };
            is_ok &= expect_error(
                gl,
                glw::GL_INVALID_OPERATION,
                "NamedRenderbufferStorageMultisample",
                "renderbuffer is not the name of an existing renderbuffer object.",
            );

            // SAFETY: as above.
            unsafe { gl.named_renderbuffer_storage_multisample(rbo_valid, max_samples + 1, glw::GL_RGBA8, 1, 1) };
            is_ok &= expect_error(
                gl,
                glw::GL_INVALID_OPERATION,
                "NamedRenderbufferStorageMultisample",
                "samples is greater than MAX_SAMPLES.",
            );

            // SAFETY: as above.
            unsafe { gl.named_renderbuffer_storage_multisample(rbo_valid, 1, glw::GL_RGBA8, -1, 1) };
            is_ok &= expect_error(
                gl,
                glw::GL_INVALID_VALUE,
                "NamedRenderbufferStorageMultisample",
                "either of width is negative.",
            );
            // SAFETY: as above.
            unsafe { gl.named_renderbuffer_storage_multisample(rbo_valid, 1, glw::GL_RGBA8, 1, -1) };
            is_ok &= expect_error(
                gl,
                glw::GL_INVALID_VALUE,
                "NamedRenderbufferStorageMultisample",
                "either of height is negative.",
            );

            // SAFETY: as above.
            unsafe {
                gl.named_renderbuffer_storage_multisample(rbo_valid, max_integer_samples + 1, glw::GL_RGB10_A2UI, 1, 1)
            };
            is_ok &= expect_error(
                gl,
                glw::GL_INVALID_OPERATION,
                "NamedRenderbufferStorageMultisample",
                "internalformat is a signed or unsigned integer format and samples is greater than the value of MAX_INTEGER_SAMPLES.",
            );

            // SAFETY: as above.
            unsafe { gl.named_renderbuffer_storage_multisample(rbo_valid, 1, internalformat_invalid, 1, 1) };
            is_ok &= expect_error(
                gl,
                glw::GL_INVALID_ENUM,
                "NamedRenderbufferStorageMultisample",
                "internalformat is not a color-renderable, depth-renderable, or stencil-renderable format (it is COMPRESSED_RED).",
            );
            Ok(is_ok)
        });

        // Clean
        if rbo_valid != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_renderbuffers(1, &rbo_valid) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Renderbuffers::GetParameterErrorsTest`
struct RenderbuffersGetParameterErrorsTest;

impl TestCase for RenderbuffersGetParameterErrorsTest {
    fn name(&self) -> &str {
        "renderbuffers_get_parameters_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const VALID_PARAMETERS: [glw::GLenum; 10] = [
            glw::GL_RENDERBUFFER_WIDTH,
            glw::GL_RENDERBUFFER_HEIGHT,
            glw::GL_RENDERBUFFER_INTERNAL_FORMAT,
            glw::GL_RENDERBUFFER_SAMPLES,
            glw::GL_RENDERBUFFER_RED_SIZE,
            glw::GL_RENDERBUFFER_GREEN_SIZE,
            glw::GL_RENDERBUFFER_BLUE_SIZE,
            glw::GL_RENDERBUFFER_ALPHA_SIZE,
            glw::GL_RENDERBUFFER_DEPTH_SIZE,
            glw::GL_RENDERBUFFER_STENCIL_SIZE,
        ];
        let gl = context.gl();
        let mut rbo_valid: glw::GLuint = 0;
        let expect_error = RenderbuffersStorageErrorsTest::expect_error;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // PrepareObjects
            // SAFETY: a name is written to the live local, then bound.
            unsafe {
                gl.gen_renderbuffers(1, &mut rbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
            }
            let mut parameter_invalid: glw::GLenum = 0;
            loop {
                parameter_invalid += 1;
                if !VALID_PARAMETERS.contains(&parameter_invalid) {
                    break;
                }
            }
            let mut rbo_invalid: glw::GLuint = 0;
            loop {
                rbo_invalid += 1;
                // SAFETY: plain query.
                if unsafe { gl.is_renderbuffer(rbo_invalid) } == 0 {
                    break;
                }
            }

            let mut return_value_unused_storage: glw::GLint = 0;
            // SAFETY: both calls are expected to fail validation, so nothing is written.
            unsafe {
                gl.get_named_renderbuffer_parameteriv(
                    rbo_invalid,
                    glw::GL_RENDERBUFFER_WIDTH,
                    &mut return_value_unused_storage,
                )
            };
            is_ok &= expect_error(
                gl,
                glw::GL_INVALID_OPERATION,
                "GetNamedRenderbufferParameteriv",
                "renderbuffer is not the name of an existing renderbuffer object.",
            );

            // SAFETY: as above.
            unsafe {
                gl.get_named_renderbuffer_parameteriv(rbo_valid, parameter_invalid, &mut return_value_unused_storage)
            };
            is_ok &= expect_error(
                gl,
                glw::GL_INVALID_ENUM,
                "GetNamedRenderbufferParameteriv",
                "parameter name is not one of the accepted parameter names described in specification.",
            );
            Ok(is_ok)
        });

        // Clean
        if rbo_valid != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_renderbuffers(1, &rbo_valid) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Tests::init` (the TransformFeedback, Samplers, ProgramPipelines, Queries, Buffers and Renderbuffers parts)
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("direct_state_access");
    group.add_child(Box::new(XfbCreationTest) as Box<dyn TestCase>);
    group.add_child(Box::new(XfbDefaultsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(XfbBuffersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(XfbErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(XfbFunctionalTest) as Box<dyn TestCase>);
    group.add_child(Box::new(SamplersCreationTest) as Box<dyn TestCase>);
    group.add_child(Box::new(SamplersDefaultsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(SamplersErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(SamplersFunctionalTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ProgramPipelinesCreationTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ProgramPipelinesDefaultsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ProgramPipelinesErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ProgramPipelinesFunctionalTest) as Box<dyn TestCase>);
    group.add_child(Box::new(QueriesCreationTest) as Box<dyn TestCase>);
    group.add_child(Box::new(QueriesDefaultsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(QueriesErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(QueriesFunctionalTest) as Box<dyn TestCase>);
    group.add_child(Box::new(QueriesReuseTest) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersCreationTest) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersDataTest) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersClearTest) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersMapTest(MapKind::ReadOnly)) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersMapTest(MapKind::ReadWrite)) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersMapTest(MapKind::WriteOnly)) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersMapRangeReadBitTest) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersMapRangeWriteBitTest) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersSubDataQueryTest) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersDefaultsTest) as Box<dyn TestCase>);
    super::direct_state_access_buffers_tests::add_tests(&mut group);
    super::direct_state_access_framebuffers_tests::add_tests(&mut group);
    group.add_child(Box::new(RenderbuffersCreationTest) as Box<dyn TestCase>);
    group.add_child(Box::new(RenderbuffersStorageTest) as Box<dyn TestCase>);
    group.add_child(Box::new(RenderbuffersStorageMultisampleTest) as Box<dyn TestCase>);
    group.add_child(Box::new(RenderbuffersGetParametersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(RenderbuffersCreationErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(RenderbuffersStorageErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(RenderbuffersStorageMultisampleErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(RenderbuffersGetParameterErrorsTest) as Box<dyn TestCase>);
    super::direct_state_access_vertex_arrays_tests::add_tests(&mut group);
    super::direct_state_access_textures_plain_tests::add_leading_tests(&mut group);
    super::direct_state_access_textures_tests::add_tests(&mut group);
    super::direct_state_access_textures_compressed_tests::add_tests(&mut group);
    super::direct_state_access_textures_plain_tests::add_trailing_tests(&mut group);
    group
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cIncompleteTextureAccessTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The five-piece fragment shader source is one concatenated string, and the program is a `glu::ShaderProgram` (a failed build is an `Err`, like upstream's `throw 0`).

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `SamplerTest::Configuration`
struct Configuration {
    texture_target: glw::GLenum,
    sampler_template: &'static str,
    fetch_template: &'static str,
    expected_result: [f32; 4],
    is_shadow: bool,
}

const CONFIGURATIONS: [Configuration; 15] = [
    // regular floating point sampling
    Configuration {
        texture_target: glw::GL_TEXTURE_1D,
        sampler_template: "sampler1D",
        fetch_template: "texture(texture_input, 0.0)",
        expected_result: [0.0, 0.0, 0.0, 1.0],
        is_shadow: false,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_2D,
        sampler_template: "sampler2D",
        fetch_template: "texture(texture_input, vec2(0.0))",
        expected_result: [0.0, 0.0, 0.0, 1.0],
        is_shadow: false,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_3D,
        sampler_template: "sampler3D",
        fetch_template: "texture(texture_input, vec3(0.0))",
        expected_result: [0.0, 0.0, 0.0, 1.0],
        is_shadow: false,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_CUBE_MAP,
        sampler_template: "samplerCube",
        fetch_template: "texture(texture_input, vec3(0.0))",
        expected_result: [0.0, 0.0, 0.0, 1.0],
        is_shadow: false,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_RECTANGLE,
        sampler_template: "sampler2DRect",
        fetch_template: "texture(texture_input, vec2(0.0))",
        expected_result: [0.0, 0.0, 0.0, 1.0],
        is_shadow: false,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_1D_ARRAY,
        sampler_template: "sampler1DArray",
        fetch_template: "texture(texture_input, vec2(0.0))",
        expected_result: [0.0, 0.0, 0.0, 1.0],
        is_shadow: false,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_2D_ARRAY,
        sampler_template: "sampler2DArray",
        fetch_template: "texture(texture_input, vec3(0.0))",
        expected_result: [0.0, 0.0, 0.0, 1.0],
        is_shadow: false,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        sampler_template: "samplerCubeArray",
        fetch_template: "texture(texture_input, vec4(0.0))",
        expected_result: [0.0, 0.0, 0.0, 1.0],
        is_shadow: false,
    },
    // Shadow textures.
    Configuration {
        texture_target: glw::GL_TEXTURE_1D,
        sampler_template: "sampler1DShadow",
        fetch_template: "vec4(texture(texture_input, vec3(0.0)), 0.0, 0.0, 0.0)",
        expected_result: [0.0, 0.0, 0.0, 0.0],
        is_shadow: true,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_2D,
        sampler_template: "sampler2DShadow",
        fetch_template: "vec4(texture(texture_input, vec3(0.0)), 0.0, 0.0, 0.0)",
        expected_result: [0.0, 0.0, 0.0, 0.0],
        is_shadow: true,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_CUBE_MAP,
        sampler_template: "samplerCubeShadow",
        fetch_template: "vec4(texture(texture_input, vec4(0.0)), 0.0, 0.0, 0.0)",
        expected_result: [0.0, 0.0, 0.0, 0.0],
        is_shadow: true,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_RECTANGLE,
        sampler_template: "sampler2DRectShadow",
        fetch_template: "vec4(texture(texture_input, vec3(0.0)), 0.0, 0.0, 0.0)",
        expected_result: [0.0, 0.0, 0.0, 0.0],
        is_shadow: true,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_1D_ARRAY,
        sampler_template: "sampler1DArrayShadow",
        fetch_template: "vec4(texture(texture_input, vec3(0.0)), 0.0, 0.0, 0.0)",
        expected_result: [0.0, 0.0, 0.0, 0.0],
        is_shadow: true,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_2D_ARRAY,
        sampler_template: "sampler2DArrayShadow",
        fetch_template: "vec4(texture(texture_input, vec4(0.0)), 0.0, 0.0, 0.0)",
        expected_result: [0.0, 0.0, 0.0, 0.0],
        is_shadow: true,
    },
    Configuration {
        texture_target: glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        sampler_template: "samplerCubeArrayShadow",
        fetch_template: "vec4(texture(texture_input, vec4(0.0), 1.0), 0.0, 0.0, 0.0)",
        expected_result: [0.0, 0.0, 0.0, 0.0],
        is_shadow: true,
    },
];

const VERTEX_SHADER: &str = "#version 450\n\
    \n\
    void main()\n\
    {\n\
    \x20   switch(gl_VertexID)\n\
    \x20   {\n\
    \x20       case 0:\n\
    \x20           gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n\
    \x20           break;\n\
    \x20       case 1:\n\
    \x20           gl_Position = vec4( 1.0, 1.0, 0.0, 1.0);\n\
    \x20           break;\n\
    \x20       case 2:\n\
    \x20           gl_Position = vec4(-1.0,-1.0, 0.0, 1.0);\n\
    \x20           break;\n\
    \x20       case 3:\n\
    \x20           gl_Position = vec4( 1.0,-1.0, 0.0, 1.0);\n\
    \x20           break;\n\
    \x20   }\n\
    }\n";

const FRAGMENT_SHADER_HEAD: &str = "#version 450\n\
    \n\
    uniform ";

const FRAGMENT_SHADER_BODY: &str = " texture_input;\n\
    out vec4 texture_output;\n\
    \n\
    void main()\n\
    {\n\
    \x20   texture_output = ";

const FRAGMENT_SHADER_TAIL: &str = ";\n\
    }\n";

/// `Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("incomplete_texture_access");
    group.add_child(Box::new(SamplerTest) as Box<dyn TestCase>);
    group
}

/// The object names `SamplerTest` keeps as members.
#[derive(Default)]
struct Objects {
    to: GLuint,
    fbo: GLuint,
    rbo: GLuint,
    vao: GLuint,
}

/// `SamplerTest`
struct SamplerTest;

impl SamplerTest {
    /// `SamplerTest::PrepareFramebuffer`
    fn prepare_framebuffer(gl: &glw::Functions, objects: &mut Objects) -> Result<(), TestError> {
        if objects.fbo != 0 || objects.rbo != 0 {
            return Err(TestError::InternalError("framebuffer already prepared".to_string()));
        }

        gl_call!(
            gl,
            "glGenFramebuffers has failed",
            gl.gen_framebuffers(1, &mut objects.fbo)
        );
        gl_call!(
            gl,
            "glBindFramebuffer has failed",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo)
        );
        gl_call!(
            gl,
            "glGenRenderbuffers has failed",
            gl.gen_renderbuffers(1, &mut objects.rbo)
        );
        gl_call!(
            gl,
            "glBindRenderbuffer has failed",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbo)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage has failed",
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA32F, 1, 1)
        );
        gl_call!(
            gl,
            "glFramebufferRenderbuffer has failed",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                objects.rbo
            )
        );

        // SAFETY: a plain state query on the bound framebuffer.
        if glw::GL_FRAMEBUFFER_COMPLETE != unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } {
            return Err(TestError::InternalError("framebuffer incomplete".to_string()));
        }
        Ok(())
    }

    /// `SamplerTest::PrepareVertexArrays`
    fn prepare_vertex_arrays(gl: &glw::Functions, objects: &mut Objects) -> Result<(), TestError> {
        if objects.vao != 0 {
            return Err(TestError::InternalError("vertex array already prepared".to_string()));
        }

        gl_call!(
            gl,
            "gGenVertexArrays has failed",
            gl.gen_vertex_arrays(1, &mut objects.vao)
        );
        gl_call!(gl, "gBindVertexArrays has failed", gl.bind_vertex_array(objects.vao));
        Ok(())
    }

    /// `SamplerTest::PrepareTexture`
    fn prepare_texture(
        gl: &glw::Functions,
        objects: &mut Objects,
        configuration: &Configuration,
    ) -> Result<(), TestError> {
        if objects.to != 0 {
            return Err(TestError::InternalError("texture already prepared".to_string()));
        }

        gl_call!(gl, "glGenTextures has failed", gl.gen_textures(1, &mut objects.to));
        gl_call!(
            gl,
            "glBindTexture has failed",
            gl.bind_texture(configuration.texture_target, objects.to)
        );

        // SAFETY: plain state setters on the texture bound above; upstream does not check them either.
        unsafe {
            if configuration.is_shadow {
                gl.tex_parameteri(
                    configuration.texture_target,
                    glw::GL_TEXTURE_COMPARE_MODE,
                    glw::GL_COMPARE_REF_TO_TEXTURE as i32,
                );
                gl.tex_parameteri(
                    configuration.texture_target,
                    glw::GL_TEXTURE_COMPARE_FUNC,
                    glw::GL_NEVER as i32,
                );
            } else {
                gl.tex_parameteri(
                    configuration.texture_target,
                    glw::GL_TEXTURE_COMPARE_MODE,
                    glw::GL_NONE as i32,
                );
            }
        }
        Ok(())
    }

    /// `SamplerTest::Draw`
    fn draw(gl: &glw::Functions, program: GLuint) -> Result<(), TestError> {
        gl_call!(gl, "glActiveTexture has failed", gl.active_texture(glw::GL_TEXTURE0));
        // SAFETY: a NUL-terminated name and a program that was just built.
        let location = unsafe { gl.get_uniform_location(program, c"texture_input".as_ptr()) };
        gl_call!(gl, "glUniform1i has failed", gl.uniform_1i(location, 0));
        gl_call!(
            gl,
            "glDrawArrays has failed",
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4)
        );
        Ok(())
    }

    /// `SamplerTest::Check`
    fn check(gl: &glw::Functions, configuration: &Configuration) -> Result<bool, TestError> {
        let mut result = [7.0f32; 4];
        gl_call!(
            gl,
            "glReadPixels has failed",
            gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, result.as_mut_ptr().cast())
        );

        for i in 0..4 {
            if (configuration.expected_result[i] - result[i]).abs() > 0.0125 {
                return Ok(false);
            }
        }
        Ok(true)
    }

    /// `SamplerTest::CleanCase`, minus the program (a `ShaderProgram` owns it here)
    fn clean_case(gl: &glw::Functions, objects: &mut Objects) {
        if objects.to != 0 {
            // SAFETY: a texture generated by `prepare_texture`, deleted once.
            unsafe { gl.delete_textures(1, &objects.to) };
            objects.to = 0;
        }
        // SAFETY: `glGetError` takes no arguments.
        while unsafe { gl.get_error() } != glw::GL_NO_ERROR {}
    }

    /// `SamplerTest::CleanTest`
    fn clean_test(gl: &glw::Functions, objects: &mut Objects) {
        // SAFETY: names generated by the prepare functions, each deleted once.
        unsafe {
            if objects.fbo != 0 {
                gl.delete_framebuffers(1, &objects.fbo);
                objects.fbo = 0;
            }
            if objects.rbo != 0 {
                gl.delete_renderbuffers(1, &objects.rbo);
                objects.rbo = 0;
            }
            if objects.vao != 0 {
                gl.delete_vertex_arrays(1, &objects.vao);
                objects.vao = 0;
            }
            while gl.get_error() != glw::GL_NO_ERROR {}
        }
    }

    fn run(context: &Context, objects: &mut Objects) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut is_ok = true;

        Self::prepare_framebuffer(gl, objects)?;
        Self::prepare_vertex_arrays(gl, objects)?;

        for configuration in &CONFIGURATIONS {
            // `PrepareProgram`
            let fragment = format!(
                "{FRAGMENT_SHADER_HEAD}{}{FRAGMENT_SHADER_BODY}{}{FRAGMENT_SHADER_TAIL}",
                configuration.sampler_template, configuration.fetch_template
            );
            let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER.to_string(), fragment));
            if !program.is_ok() {
                return Err(TestError::InternalError(
                    program.build_failure_summary().unwrap_or_default(),
                ));
            }
            gl_call!(gl, "glUsePrograms has failed", gl.use_program(program.program()));

            Self::prepare_texture(gl, objects, configuration)?;
            Self::draw(gl, program.program())?;

            if !Self::check(gl, configuration)? {
                log::warn!(
                    "Incomplete texture sampler access test failed with sampler {}.",
                    configuration.sampler_template
                );
                is_ok = false;
            }

            Self::clean_case(gl, objects);
        }
        Ok(is_ok)
    }
}

impl TestCase for SamplerTest {
    fn name(&self) -> &str {
        "sampler"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports_core(4, 5) {
            return Err(TestError::NotSupported("Not Supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = Objects::default();

        let result = Self::run(context, &mut objects);

        Self::clean_case(gl, &mut objects);
        Self::clean_test(gl, &mut objects);

        if result? {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cPostDepthCoverageTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `init`/`deinit` are the two ends of `iterate` (the extension check is `check_support`), and the object names `PostDepthSampleMaskCase` keeps as members are a local struct.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, VertexArrayBinding, va};
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

const COMMON_VERT_SHADER: &str = "#version 450\n\
    \n\
    in vec3 vertex;\n\
    in vec2 inTexCoord;\n\
    out vec2 texCoord;\n\
    \n\
    void main()\n\
    {\n\
    \x20   texCoord = inTexCoord;\n\
    \x20   gl_Position = vec4(vertex, 1);\n\
    }\n";

const SHADER_FRAG_1: &str = "#version 450\n\
    \n\
    #extension GL_ARB_post_depth_coverage : require\n\
    \n\
    out vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
    }\n";

const SHADER_FRAG_2: &str = "#version 450\n\
    \n\
    #extension GL_ARB_post_depth_coverage : enable\n\
    \n\
    #ifndef GL_ARB_post_depth_coverage\n\
    \x20 #error GL_ARB_post_depth_coverage not defined\n\
    #else\n\
    \x20 #if (GL_ARB_post_depth_coverage != 1)\n\
    \x20   #error GL_ARB_post_depth_coverage wrong defined\n\
    \x20 #endif\n\
    #endif // GL_ARB_post_depth_coverage\n\
    \n\
    out vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
    }\n";

const SHADER_FRAG_3: &str = "#version 450\n\
    \n\
    #extension GL_ARB_post_depth_coverage : enable\n\
    \n\
    layout(early_fragment_tests) in;\n\
    layout(post_depth_coverage) in;\n\
    \n\
    out vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
    }\n";

const SHADER_FRAG_4: &str = "#version 450\n\
    \n\
    #extension GL_ARB_post_depth_coverage : enable\n\
    \n\
    layout(post_depth_coverage) in;\n\
    \n\
    out vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
    }\n";

const SAMPLE_MASK_FRAG_1A: &str = "#version 450\n\
    \n\
    #extension GL_ARB_post_depth_coverage : enable\n\
    \n\
    in vec2 texCoord;\n\
    out vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   int samp1 = (gl_SampleMaskIn[0] & 0x1);\n\
    \x20   int samp2 = (gl_SampleMaskIn[0] & 0x2) / 2;\n\
    \x20   int samp3 = (gl_SampleMaskIn[0] & 0x4) / 4;\n\
    \x20   int samp4 = (gl_SampleMaskIn[0] & 0x8) / 8;\n\
    \x20   fragColor = vec4(samp1, samp2, samp3, samp4);\n\
    }\n";

const SAMPLE_MASK_FRAG_1B: &str = "#version 450\n\
    \n\
    #extension GL_ARB_post_depth_coverage : enable\n\
    layout(post_depth_coverage) in;\n\
    \n\
    in vec2 texCoord;\n\
    out vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   int samp1 = (gl_SampleMaskIn[0] & 0x1);\n\
    \x20   int samp2 = (gl_SampleMaskIn[0] & 0x2) / 2;\n\
    \x20   int samp3 = (gl_SampleMaskIn[0] & 0x4) / 4;\n\
    \x20   int samp4 = (gl_SampleMaskIn[0] & 0x8) / 8;\n\
    \x20   fragColor = vec4(samp1, samp2, samp3, samp4);\n\
    }\n";

const SAMPLE_MASK_FRAG_2: &str = "#version 450\n\
    \n\
    in vec2 texCoord;\n\
    out vec4 fragColor;\n\
    \n\
    uniform sampler2DMS texture;\n\
    \n\
    void main()\n\
    {\n\
    \x20   int samp = int(texCoord.y * 4);\n\
    \x20   fragColor = texelFetch(texture, ivec2(0, 0), samp);\n\
    }\n";

fn check_extension_supported(context: &Context) -> Result<(), TestError> {
    if !context
        .context_info
        .is_extension_supported("GL_ARB_post_depth_coverage")
    {
        return Err(TestError::NotSupported(
            "GL_ARB_post_depth_coverage not supported".to_string(),
        ));
    }
    Ok(())
}

/// `PostDepthCoverage::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("post_depth_coverage_tests");
    group.add_child(Box::new(PostDepthShaderCase) as Box<dyn TestCase>);
    group.add_child(Box::new(PostDepthSampleMaskCase) as Box<dyn TestCase>);
    group
}

/// `PostDepthShaderCase`
struct PostDepthShaderCase;

impl TestCase for PostDepthShaderCase {
    fn name(&self) -> &str {
        "PostDepthShader"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let checks = [
            (SHADER_FRAG_1, "Fail checking extension in shader"),
            (SHADER_FRAG_2, "Fail checking preprocessor directives in shader"),
            (SHADER_FRAG_3, "Fail checking first layout setup in shader"),
            (SHADER_FRAG_4, "Fail checking second layout setup in shader"),
        ];
        for (fragment, failure) in checks {
            let program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(COMMON_VERT_SHADER.to_string(), fragment.to_string()),
            );
            if !program.is_ok() {
                log::warn!("{}", program.build_failure_summary().unwrap_or_default());
                return Ok(TestStatus::fail(failure));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The object names `PostDepthSampleMaskCase` keeps as members.
#[derive(Default)]
struct Objects {
    framebuffer_ms: GLuint,
    framebuffer: GLuint,
    texture_ms: GLuint,
    texture: GLuint,
    depth_stencil_renderbuffer: GLuint,
}

/// `PostDepthSampleMaskCase`
struct PostDepthSampleMaskCase;

const BUFFERCASE_DEPTH: i32 = 0;
const BUFFERCASE_STENCIL: i32 = 1;
const PDCCASE_DISABLED: i32 = 0;
const PDCCASE_ENABLED: i32 = 1;

impl PostDepthSampleMaskCase {
    /// `PostDepthSampleMaskCase::init`, after the extension check
    fn init(gl: &glw::Functions, objects: &mut Objects) -> Result<(), TestError> {
        // SAFETY: plain object creation and attachment with a current context; the names are written into live locals.
        unsafe {
            gl.gen_renderbuffers(1, &mut objects.depth_stencil_renderbuffer);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.depth_stencil_renderbuffer);
            gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 4, glw::GL_DEPTH_STENCIL, 1, 1);
        }
        glu::expect_no_error(gl, "glRenderbufferStorageMultisample")?;

        // SAFETY: as above.
        unsafe {
            gl.gen_textures(1, &mut objects.texture_ms);
            gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, objects.texture_ms);
            gl.tex_storage_2d_multisample(glw::GL_TEXTURE_2D_MULTISAMPLE, 4, glw::GL_RGBA8, 1, 1, glw::TRUE);
        }
        glu::expect_no_error(gl, "glTexStorage2DMultisample")?;

        // SAFETY: as above.
        unsafe {
            gl.gen_framebuffers(1, &mut objects.framebuffer_ms);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.framebuffer_ms);
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                objects.texture_ms,
                0,
            );
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                objects.depth_stencil_renderbuffer,
            );
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                objects.depth_stencil_renderbuffer,
            );

            gl.gen_textures(1, &mut objects.texture);
            gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture);
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 1, 4);

            gl.gen_framebuffers(1, &mut objects.framebuffer);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.framebuffer);
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                objects.texture,
                0,
            );
        }
        Ok(())
    }

    /// `PostDepthSampleMaskCase::deinit`
    fn deinit(gl: &glw::Functions, objects: &Objects) {
        // SAFETY: names created in `init`, each deleted once; zero names are skipped like upstream does.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            if objects.framebuffer_ms != 0 {
                gl.delete_framebuffers(1, &objects.framebuffer_ms);
            }
            if objects.framebuffer != 0 {
                gl.delete_framebuffers(1, &objects.framebuffer);
            }
            if objects.texture_ms != 0 {
                gl.delete_textures(1, &objects.texture_ms);
            }
            if objects.texture != 0 {
                gl.delete_textures(1, &objects.texture);
            }
            if objects.depth_stencil_renderbuffer != 0 {
                gl.delete_renderbuffers(1, &objects.depth_stencil_renderbuffer);
            }
        }
    }

    fn run(context: &Context, objects: &Objects) -> TestOutcome {
        let gl = context.gl();

        let tex_coord: [f32; 8] = [0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0];
        let vertices_near: [f32; 9] = [-1.0, -1.0, 0.25, 0.4, -1.0, 0.25, -1.0, 0.4, 0.25];
        let vertices_far: [f32; 9] = [-1.0, -1.0, 0.75, 3.0, -1.0, 0.75, -1.0, 3.0, 0.75];
        let vertices_post: [f32; 12] = [-1.0, -1.0, 0.0, 1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 1.0, 0.0];
        let indices_pre: [u16; 3] = [0, 1, 2];
        let indices_post: [u16; 6] = [0, 1, 2, 1, 2, 3];
        let vertex_arrays_near: [VertexArrayBinding<'_>; 2] = [
            va::float("vertex", 3, 3, 0, &vertices_near),
            va::float("inTexCoord", 2, 3, 0, &tex_coord),
        ];
        let vertex_arrays_far: [VertexArrayBinding<'_>; 2] = [
            va::float("vertex", 3, 3, 0, &vertices_far),
            va::float("inTexCoord", 2, 3, 0, &tex_coord),
        ];
        let vertex_arrays_post: [VertexArrayBinding<'_>; 2] = [
            va::float("vertex", 3, 4, 0, &vertices_post),
            va::float("inTexCoord", 2, 4, 0, &tex_coord),
        ];

        // Prepare shaders
        let build = |fragment: &str, failure: &str| -> Result<ShaderProgram<'_>, TestStatus> {
            let program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(COMMON_VERT_SHADER.to_string(), fragment.to_string()),
            );
            if !program.is_ok() {
                log::warn!("{}", program.build_failure_summary().unwrap_or_default());
                return Err(TestStatus::fail(failure));
            }
            Ok(program)
        };
        let program1a = match build(SAMPLE_MASK_FRAG_1A, "Shader program fail (non post_depth_coverage).") {
            Ok(program) => program,
            Err(status) => return Ok(status),
        };
        let program1b = match build(SAMPLE_MASK_FRAG_1B, "Shader program fail (post_depth_coverage).") {
            Ok(program) => program,
            Err(status) => return Ok(status),
        };
        let program2 = match build(SAMPLE_MASK_FRAG_2, "Shader program fail (samples reader).") {
            Ok(program) => program,
            Err(status) => return Ok(status),
        };

        // SAFETY: plain state setters.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            gl.clear_stencil(0);
        }

        // Iterate through all cases
        for buffer_case in BUFFERCASE_DEPTH..=BUFFERCASE_STENCIL {
            for pdc_case in PDCCASE_DISABLED..=PDCCASE_ENABLED {
                let program = if pdc_case == PDCCASE_DISABLED {
                    program1a.program()
                } else {
                    program1b.program()
                };
                // SAFETY: a program that was just built.
                unsafe { gl.use_program(program) };

                // Firstible use multisampled framebuffer
                // SAFETY: plain state setters on the framebuffer created in `init`.
                unsafe {
                    gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.framebuffer_ms);
                    gl.viewport(0, 0, 1, 1);
                    gl.enable(glw::GL_MULTISAMPLE);
                }

                // Check which samples should be covered by first draw - calculate expected sample mask
                let mut expected_mask = [false; 4];
                for (i, expected) in expected_mask.iter_mut().enumerate() {
                    let mut sample_pos = [0.0f32; 2];
                    gl_call!(
                        gl,
                        "glGetMultisamplefv",
                        gl.get_multisamplefv(glw::GL_SAMPLE_POSITION, i as GLuint, sample_pos.as_mut_ptr())
                    );
                    *expected = !(pdc_case == PDCCASE_ENABLED && (sample_pos[0] + sample_pos[1]) < 0.7);
                }

                // SAFETY: plain state setters.
                unsafe {
                    if buffer_case == BUFFERCASE_DEPTH {
                        gl.enable(glw::GL_DEPTH_TEST);
                    } else if buffer_case == BUFFERCASE_STENCIL {
                        gl.enable(glw::GL_STENCIL_TEST);
                    }

                    gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

                    if buffer_case == BUFFERCASE_STENCIL {
                        gl.stencil_func(glw::GL_ALWAYS, 1, 0xFF);
                        gl.stencil_op(glw::GL_ZERO, glw::GL_REPLACE, glw::GL_REPLACE);
                        gl.stencil_mask(0xFF);
                    }
                }

                // Draw near primitive
                glu::draw(
                    &context.render_context,
                    program,
                    &vertex_arrays_near,
                    &glu::pr::triangle_strip(&indices_pre),
                )?;

                // SAFETY: plain state setters.
                unsafe {
                    gl.clear(glw::GL_COLOR_BUFFER_BIT);

                    if buffer_case == BUFFERCASE_STENCIL {
                        gl.stencil_func(glw::GL_NOTEQUAL, 1, 0xFF);
                        gl.stencil_mask(0x00);
                    }
                }

                // Draw far primitive
                glu::draw(
                    &context.render_context,
                    program,
                    &vertex_arrays_far,
                    &glu::pr::triangle_strip(&indices_pre),
                )?;

                // SAFETY: plain state setters.
                unsafe {
                    gl.disable(glw::GL_DEPTH_TEST);
                    if buffer_case == BUFFERCASE_DEPTH {
                        gl.disable(glw::GL_DEPTH_TEST);
                    } else if buffer_case == BUFFERCASE_STENCIL {
                        gl.disable(glw::GL_STENCIL_TEST);
                    }

                    gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                    gl.use_program(program2.program());
                    gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.framebuffer);
                    gl.viewport(0, 0, 1, 4);

                    // Pass multisampled texture as a uniform
                    gl.active_texture(glw::GL_TEXTURE0);
                    gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, objects.texture_ms);
                    gl.uniform_1i(gl.get_uniform_location(program2.program(), c"texture".as_ptr()), 0);

                    gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
                }

                // Draw multisampled texture to framebuffer
                glu::draw(
                    &context.render_context,
                    program2.program(),
                    &vertex_arrays_post,
                    &glu::pr::triangle_strip(&indices_post),
                )?;

                // SAFETY: plain state setter.
                unsafe { gl.disable(glw::GL_MULTISAMPLE) };

                // Read data from framebuffer
                let mut pixels = [0u8; 4 * 4];
                gl_call!(
                    gl,
                    "glReadPixels",
                    gl.read_pixels(
                        0,
                        0,
                        1,
                        4,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        pixels.as_mut_ptr().cast()
                    )
                );

                // Verify the result
                let mut compiled_mask = [false; 4];
                for i in 0..4 {
                    for (n, compiled) in compiled_mask.iter_mut().enumerate() {
                        *compiled = *compiled || pixels[4 * i + n] != 0;
                    }
                }

                for n in 0..4 {
                    if expected_mask[n] != compiled_mask[n] {
                        log::warn!(
                            "Wrong results for {} / {}",
                            if buffer_case == BUFFERCASE_DEPTH {
                                "BUFFERCASE_DEPTH"
                            } else {
                                "BUFFERCASE_DEPTH_STENCIL"
                            },
                            if pdc_case == PDCCASE_DISABLED {
                                "PDCCASE_DISABLED"
                            } else {
                                "PDCCASE_ENABLED"
                            }
                        );
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for PostDepthSampleMaskCase {
    fn name(&self) -> &str {
        "PostDepthSampleMask"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = Objects::default();

        let outcome = match Self::init(gl, &mut objects) {
            Ok(()) => Self::run(context, &objects),
            Err(error) => Err(error),
        };
        Self::deinit(gl, &objects);
        outcome
    }
}

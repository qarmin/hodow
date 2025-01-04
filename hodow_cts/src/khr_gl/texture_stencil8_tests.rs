// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcTextureStencil8Tests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, desktop branches only (the ES branches need an ES context, which the KHR-GL roots never have). Upstream raises `g_numMultisampleTexTargets` to 2 only on ES with GL_OES_texture_storage_multisample_2d_array, so on desktop the multisample array target and the `stencilTexArray` uniform are never exercised; the array arms of the helpers are kept for shape.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const TEXTURE_STENCIL8_VERT: &str = "${VERSION}\n\
    layout (location = 0) in vec4 inVertex;\n\
    out highp vec2 texCoords;\n\
    \n\
    void main()\n\
    {\n\
    \x20   gl_Position = inVertex;\n\
    \x20   texCoords = inVertex.xy * 0.5 + vec2(0.5);\n\
    }\n";

const TEXTURE_STENCIL8_SIMPLE_COLOR_FRAG: &str = "${VERSION}\n\
    ${PRECISION}\n\
    \n\
    layout (location = 0) out lowp vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   fragColor = vec4(0.0);\n\
    }\n";

const TEXTURE_STENCIL8_FRAG: &str = "${VERSION}\n\
    ${PRECISION}\n\
    \n\
    uniform lowp usampler2D stencilTex;\n\
    in highp vec2 texCoords;\n\
    \n\
    layout (location = 0) out lowp vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   lowp uint s = texture(stencilTex, texCoords).r;\n\
    \x20   switch (s)\n\
    \x20   {\n\
    \x20   case 0u:\n\
    \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0); break;\n\
    \x20   case 64u:\n\
    \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0); break;\n\
    \x20   case 128u:\n\
    \x20       fragColor = vec4(0.0, 0.0, 1.0, 1.0); break;\n\
    \x20   case 255u:\n\
    \x20       fragColor = vec4(1.0, 1.0, 1.0, 1.0); break;\n\
    \x20   default:\n\
    \x20       fragColor = vec4(0.0, 0.0, 0.0, 1.0); break;\n\
    \x20   }\n\
    }\n";

const TEXTURE_STENCIL8_MULTISAMPLE_FRAG: &str = "${VERSION}\n\
    \n\
    #if defined(GL_OES_texture_storage_multisample_2d_array)\n\
    #extension GL_OES_texture_storage_multisample_2d_array : require\n\
    \x20   uniform lowp usampler2DMSArray  stencilTexArray;\n\
    #endif\n\
    \n\
    \x20   ${PRECISION}\n\
    \n\
    \x20   uniform lowp usampler2DMS  stencilTex;\n\
    \x20   uniform int textureType;\n\
    \n\
    \x20   layout (location = 0) out lowp vec4 fragColor;\n\
    \n\
    \x20   void main()\n\
    \x20   {\n\
    \x20       //sample the lower left texel,  first 4 samples\n\
    \x20       lowp uint s0 = 1u, s1 = 1u, s2 = 1u, s3 = 1u;\n\
    \x20       if (textureType == 0) {\n\
    \x20           s0 = texelFetch(stencilTex, ivec2(0), 0).r;\n\
    \x20           s1 = texelFetch(stencilTex, ivec2(0), 1).r;\n\
    \x20           s2 = texelFetch(stencilTex, ivec2(0), 2).r;\n\
    \x20           s3 = texelFetch(stencilTex, ivec2(0), 3).r;\n\
    \x20       }\n\
    #if defined(GL_OES_texture_storage_multisample_2d_array)\n\
    \x20       else {\n\
    \x20           // hardcoded to sample from layer 1\n\
    \x20           s0 = texelFetch(stencilTexArray, ivec3(0, 0, 1), 0).r;\n\
    \x20           s1 = texelFetch(stencilTexArray, ivec3(0, 0, 1), 1).r;\n\
    \x20           s2 = texelFetch(stencilTexArray, ivec3(0, 0, 1), 2).r;\n\
    \x20           s3 = texelFetch(stencilTexArray, ivec3(0, 0, 1), 3).r;\n\
    \x20       }\n\
    #endif\n\
    \n\
    \x20       fragColor = (s0 == 0u && s1 == 64u && s2 == 128u && s3 == 255u)  ?\n\
    \x20                               vec4(0.0, 1.0,  0.0,  1.0) : // green for success\n\
    \x20                               vec4(1.0, 0.0,  0.0,  1.0);  // red for failure\n\
    \x20   }\n";

const MULTISAMPLE_TEX_TARGETS: [GLenum; 2] = [glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY];
const MAX_MULTISAMPLE_TEX_TARGETS: usize = MULTISAMPLE_TEX_TARGETS.len();
const STENCIL_REF: [u8; 4] = [0, 64, 128, 255];
const NUM_LAYERS: i32 = 3;
const NUM_MULTISAMPLE_TEX_TARGETS: usize = 1;

/// The three programs `init` builds.
struct Programs<'gl> {
    stencil_to_color: ShaderProgram<'gl>,
    simple_color: ShaderProgram<'gl>,
    check_stencil_sample: ShaderProgram<'gl>,
}

/// `TextureMultisampledStencilTestCase`
struct TextureMultisampledStencilTestCase;

impl TextureMultisampledStencilTestCase {
    fn make_program<'gl>(
        gl: &'gl glw::Functions,
        vs: &str,
        fs: &str,
        specialization: &[(&str, String)],
    ) -> Result<ShaderProgram<'gl>, TestError> {
        let vert_shader = StringTemplate::new(vs).specialize(specialization)?;
        let frag_shader = StringTemplate::new(fs).specialize(specialization)?;

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vert_shader, frag_shader));

        if !program.is_ok() {
            log::info!(
                "Shader build failed.\n{}",
                program.build_failure_summary().unwrap_or_default()
            );
            return Err(TestError::Fail("Invalid program".to_string()));
        }
        Ok(program)
    }

    /// `init`
    fn init(context: &Context) -> Result<Programs<'_>, TestError> {
        let gl = context.gl();
        let specialization = [
            (
                "VERSION",
                context.context_type().glsl_version().declaration().to_string(),
            ),
            ("PRECISION", String::new()),
        ];

        Ok(Programs {
            stencil_to_color: Self::make_program(gl, TEXTURE_STENCIL8_VERT, TEXTURE_STENCIL8_FRAG, &specialization)?,
            simple_color: Self::make_program(
                gl,
                TEXTURE_STENCIL8_VERT,
                TEXTURE_STENCIL8_SIMPLE_COLOR_FRAG,
                &specialization,
            )?,
            check_stencil_sample: Self::make_program(
                gl,
                TEXTURE_STENCIL8_VERT,
                TEXTURE_STENCIL8_MULTISAMPLE_FRAG,
                &specialization,
            )?,
        })
    }

    /// `testCreateTexturesMultisample`
    fn test_create_textures_multisample(gl: &glw::Functions) -> Result<bool, TestError> {
        let mut textures = [0 as GLuint; MAX_MULTISAMPLE_TEX_TARGETS];
        let returnvalue = Self::create_textures_tex_storage_multisample(gl, &mut textures, 0)?;

        gl_call!(
            gl,
            "deleteTextures",
            gl.delete_textures(NUM_MULTISAMPLE_TEX_TARGETS as i32, textures.as_ptr())
        );

        Ok(returnvalue)
    }

    /// `createTexturesTexStorageMultisample`; num_samples = 0 creates a texture with MAX_DEPTH_TEXTURE_SAMPLES samples
    fn create_textures_tex_storage_multisample(
        gl: &glw::Functions,
        textures: &mut [GLuint; MAX_MULTISAMPLE_TEX_TARGETS],
        num_samples: GLint,
    ) -> Result<bool, TestError> {
        let mut success = true;

        textures.fill(0);

        for t in 0..NUM_MULTISAMPLE_TEX_TARGETS {
            textures[t] = Self::create_for_target_tex_storage_multisample(gl, MULTISAMPLE_TEX_TARGETS[t], num_samples)?;
            success = success && textures[t] != 0;
        }
        if !success {
            gl_call!(
                gl,
                "deleteTextures",
                gl.delete_textures(NUM_MULTISAMPLE_TEX_TARGETS as i32, textures.as_ptr())
            );
        }

        Ok(success)
    }

    /// `createForTargetTexStorageMultisample`
    fn create_for_target_tex_storage_multisample(
        gl: &glw::Functions,
        target: GLenum,
        mut num_samples: GLint,
    ) -> Result<GLuint, TestError> {
        let mut max_samples: GLint = 0;
        let mut max_samples_ifq: GLint = 0;
        let mut tex: GLuint = 0;

        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_MAX_DEPTH_TEXTURE_SAMPLES, &mut max_samples)
        );
        gl_call!(
            gl,
            "getInternalformativ",
            gl.get_internalformativ(target, glw::GL_STENCIL_INDEX8, glw::GL_SAMPLES, 1, &mut max_samples_ifq)
        );

        if max_samples > max_samples_ifq {
            return Err(TestError::Fail("The max GL_SAMPLES for GL_STENCIL_INDEX8 must be greater than or equal to GL_MAX_DEPTH_TEXTURE_SAMPLES.".to_string()));
        }

        if num_samples == 0 {
            num_samples = max_samples;
        }

        gl_call!(gl, "genTextures", gl.gen_textures(1, &mut tex));
        gl_call!(gl, "bindTexture", gl.bind_texture(target, tex));

        match target {
            glw::GL_TEXTURE_2D_MULTISAMPLE => {
                gl_call!(
                    gl,
                    "texStorage2DMultisample",
                    gl.tex_storage_2d_multisample(
                        glw::GL_TEXTURE_2D_MULTISAMPLE,
                        num_samples,
                        glw::GL_STENCIL_INDEX8,
                        2,
                        2,
                        glw::TRUE
                    )
                );
            }
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                gl_call!(
                    gl,
                    "texStorage3DMultisample",
                    gl.tex_storage_3d_multisample(
                        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
                        num_samples,
                        glw::GL_STENCIL_INDEX8,
                        2,
                        2,
                        3,
                        glw::TRUE
                    )
                );
            }
            _ => {
                gl_call!(gl, "deleteTextures", gl.delete_textures(1, &tex));
                return Err(TestError::Fail(
                    "Creating multisample stencil texture failed - unsupported texture target".to_string(),
                ));
            }
        }

        Ok(tex)
    }

    /// `attachStencilTexture`
    fn attach_stencil_texture(
        gl: &glw::Functions,
        fbo_target: GLenum,
        tex_target: GLenum,
        texture: GLuint,
    ) -> Result<(), TestError> {
        match tex_target {
            glw::GL_TEXTURE_2D | glw::GL_TEXTURE_2D_MULTISAMPLE => {
                gl_call!(
                    gl,
                    "framebufferTexture2D",
                    gl.framebuffer_texture_2d(fbo_target, glw::GL_STENCIL_ATTACHMENT, tex_target, texture, 0)
                );
            }
            glw::GL_TEXTURE_CUBE_MAP => {
                gl_call!(
                    gl,
                    "framebufferTexture2D",
                    gl.framebuffer_texture_2d(
                        fbo_target,
                        glw::GL_STENCIL_ATTACHMENT,
                        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                        texture,
                        0
                    )
                );
            }
            glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                gl_call!(
                    gl,
                    "framebufferTextureLayer",
                    gl.framebuffer_texture_layer(fbo_target, glw::GL_STENCIL_ATTACHMENT, texture, 0, 1)
                );
            }
            _ => return Err(TestError::Fail("unsupported texture target".to_string())),
        }
        Ok(())
    }

    /// `fillStencilSamplePattern`
    fn fill_stencil_sample_pattern(gl: &glw::Functions, program: GLuint) -> Result<(), TestError> {
        gl_call!(
            gl,
            "stencilOp",
            gl.stencil_op(glw::GL_REPLACE, glw::GL_REPLACE, glw::GL_REPLACE)
        );
        gl_call!(gl, "enable", gl.enable(glw::GL_STENCIL_TEST));
        gl_call!(gl, "clearStencil", gl.clear_stencil(1));
        gl_call!(gl, "clear", gl.clear(glw::GL_STENCIL_BUFFER_BIT));
        gl_call!(gl, "enable", gl.enable(glw::GL_SAMPLE_MASK));
        gl_call!(gl, "viewport", gl.viewport(0, 0, 2, 2));

        for s in 0..4 {
            gl_call!(gl, "sampleMaski", gl.sample_maski(0, 1 << s));
            gl_call!(
                gl,
                "stencilFunc",
                gl.stencil_func(glw::GL_ALWAYS, GLint::from(STENCIL_REF[s]), !0)
            );

            Self::draw_screen_quad(gl, program)?;
        }

        gl_call!(gl, "disable", gl.disable(glw::GL_SAMPLE_MASK));
        gl_call!(gl, "disable", gl.disable(glw::GL_STENCIL_TEST));
        gl_call!(gl, "stencilOp", gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP));
        gl_call!(gl, "clearStencil", gl.clear_stencil(0));
        Ok(())
    }

    /// `checkMultisampledPattern`
    fn check_multisampled_pattern(
        gl: &glw::Functions,
        tex_target: GLenum,
        texture: GLuint,
        stencil_sample_to_color_prog: GLuint,
    ) -> Result<bool, TestError> {
        gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl_call!(gl, "bindTexture", gl.bind_texture(tex_target, texture));
        gl_call!(gl, "viewport", gl.viewport(0, 0, 1, 1));
        gl_call!(gl, "clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));

        Self::draw_screen_quad(gl, stencil_sample_to_color_prog)?;

        let mut color: GLuint = 0;
        gl_call!(
            gl,
            "readPixels",
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::from_mut(&mut color).cast()
            )
        );

        log::info!("TextureMultisampledStencilTestCase::CheckMultisampledPattern: read back color: 0x{color:x}");

        Ok(color == 0xFF00FF00)
    }

    /// `drawScreenQuad`
    fn draw_screen_quad(gl: &glw::Functions, program: GLuint) -> Result<bool, TestError> {
        let quad_vertices: [f32; 8] = [1.0, -1.0, 1.0, 1.0, -1.0, -1.0, -1.0, 1.0];
        let mut vao: GLuint = 0;
        let mut vbo: GLuint = 0;

        gl_call!(gl, "genVertexArrays", gl.gen_vertex_arrays(1, &mut vao));
        gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(vao));
        gl_call!(gl, "genBuffers", gl.gen_buffers(1, &mut vbo));
        gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo));
        gl_call!(
            gl,
            "bufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&quad_vertices) as glw::GLsizeiptr,
                quad_vertices.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        // SAFETY: plain calls with a NUL-terminated name.
        let loc_vertices = unsafe {
            gl.use_program(program);
            gl.get_attrib_location(program, c"inVertex".as_ptr())
        };
        if loc_vertices == -1 {
            return Err(TestError::Fail(
                "TextureMultisampledStencilTestCase::DrawScreenQuad shader does not have vertex input.".to_string(),
            ));
        }

        gl_call!(
            gl,
            "vertexAttribPointer",
            gl.vertex_attrib_pointer(
                loc_vertices as GLuint,
                2,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "enableVertexAttribArray",
            gl.enable_vertex_attrib_array(loc_vertices as GLuint)
        );
        gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl_call!(
            gl,
            "disableVertexAttribArray",
            gl.disable_vertex_attrib_array(loc_vertices as GLuint)
        );

        gl_call!(gl, "deleteBuffers", gl.delete_buffers(1, &vbo));
        gl_call!(gl, "deleteVertexArrays", gl.delete_vertex_arrays(1, &vao));

        Ok(true)
    }

    /// `createForTargetTexImage`
    fn create_for_target_tex_image(gl: &glw::Functions, target: GLenum) -> Result<GLuint, TestError> {
        Self::create_for_target_tex_image_with_type(gl, target, glw::GL_UNSIGNED_BYTE)
    }

    /// `createForTargetTexImageWithType`
    fn create_for_target_tex_image_with_type(
        gl: &glw::Functions,
        target: GLenum,
        type_: GLenum,
    ) -> Result<GLuint, TestError> {
        let mut tex: GLuint = 0;
        let internal_format = glw::GL_STENCIL_INDEX8 as GLint;

        gl_call!(gl, "genTextures", gl.gen_textures(1, &mut tex));
        gl_call!(gl, "bindTexture", gl.bind_texture(target, tex));

        match target {
            glw::GL_TEXTURE_2D => {
                gl_call!(
                    gl,
                    "texImage2D",
                    gl.tex_image_2d(
                        glw::GL_TEXTURE_2D,
                        0,
                        internal_format,
                        2,
                        2,
                        0,
                        glw::GL_STENCIL_INDEX,
                        type_,
                        std::ptr::null()
                    )
                );
            }
            glw::GL_TEXTURE_2D_ARRAY => {
                gl_call!(
                    gl,
                    "texImage3D",
                    gl.tex_image_3d(
                        glw::GL_TEXTURE_2D_ARRAY,
                        0,
                        internal_format,
                        2,
                        2,
                        NUM_LAYERS,
                        0,
                        glw::GL_STENCIL_INDEX,
                        type_,
                        std::ptr::null()
                    )
                );
            }
            glw::GL_TEXTURE_CUBE_MAP => {
                for f in 0..6 {
                    gl_call!(
                        gl,
                        "texImage2D",
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + f,
                            0,
                            internal_format,
                            2,
                            2,
                            0,
                            glw::GL_STENCIL_INDEX,
                            type_,
                            std::ptr::null()
                        )
                    );
                }
            }
            _ => {
                gl_call!(gl, "deleteTextures", gl.delete_textures(1, &tex));
                return Err(TestError::Fail("unsupported texture target".to_string()));
            }
        }

        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint)
        );
        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint)
        );

        Ok(tex)
    }

    fn uniform_location(
        gl: &glw::Functions,
        program: GLuint,
        name: &std::ffi::CStr,
        what: &str,
    ) -> Result<GLint, TestError> {
        // SAFETY: `name` is NUL-terminated.
        let loc = unsafe { gl.get_uniform_location(program, name.as_ptr()) };
        glu::expect_no_error(gl, "getUniformLocation")?;
        if loc < 0 {
            return Err(TestError::Fail(format!("unkown {what} location")));
        }
        Ok(loc)
    }

    /// `testRenderToMultisampledStencilTexture`
    fn test_render_to_multisampled_stencil_texture(
        gl: &glw::Functions,
        programs: &Programs<'_>,
    ) -> Result<bool, TestError> {
        let mut returnvalue = true;
        let mut fbos = [0 as GLuint; 3];

        gl_call!(gl, "genFramebuffers", gl.gen_framebuffers(3, fbos.as_mut_ptr()));

        let stencil_tex = Self::create_for_target_tex_image(gl, glw::GL_TEXTURE_2D)?;
        gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[2]));

        Self::attach_stencil_texture(gl, glw::GL_FRAMEBUFFER, glw::GL_TEXTURE_2D, stencil_tex)?;
        // SAFETY: a plain query on the bound framebuffer.
        if glw::GL_FRAMEBUFFER_COMPLETE != unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } {
            return Err(TestError::Fail("Unexpected FBO status".to_string()));
        }
        glu::expect_no_error(gl, "checkFramebufferStatus")?;

        gl_call!(gl, "clearStencil", gl.clear_stencil(1));
        gl_call!(gl, "clear", gl.clear(glw::GL_STENCIL_BUFFER_BIT));

        for t in 0..NUM_MULTISAMPLE_TEX_TARGETS {
            let mut textures = [0 as GLuint; 2];
            let tex_target = MULTISAMPLE_TEX_TARGETS[t];

            textures[0] = Self::create_for_target_tex_storage_multisample(gl, tex_target, 4)?;
            returnvalue &= textures[0] != 0;

            gl_call!(
                gl,
                "bindFramebuffer",
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbos[0])
            );

            Self::attach_stencil_texture(gl, glw::GL_DRAW_FRAMEBUFFER, tex_target, textures[0])?;
            // SAFETY: a plain query on the bound framebuffer.
            let status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
            glu::expect_no_error(gl, "checkFramebufferStatus")?;

            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail(format!(
                    "Multisampled stencil attachment causes incomplete framebuffer, status: 0x{status:x}.\n"
                )));
            }

            textures[1] = Self::create_for_target_tex_storage_multisample(gl, tex_target, 4)?;
            returnvalue &= textures[1] != 0;

            gl_call!(
                gl,
                "bindFramebuffer",
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbos[1])
            );

            Self::attach_stencil_texture(gl, glw::GL_READ_FRAMEBUFFER, tex_target, textures[1])?;

            // SAFETY: a plain query on the bound framebuffer.
            let status = unsafe { gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER) };
            glu::expect_no_error(gl, "checkFramebufferStatus")?;

            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail(format!(
                    "Multisampled stencil attachment causes incomplete framebuffer, status: 0x{status:x}.\n"
                )));
            }

            let check_program = programs.check_stencil_sample.program();
            gl_call!(gl, "useProgram", gl.use_program(check_program));

            let tex_type_loc = Self::uniform_location(gl, check_program, c"textureType", "textureType")?;
            gl_call!(gl, "uniform1i", gl.uniform_1i(tex_type_loc, t as GLint));

            // Upstream's `case 1` (the array target) is reachable only with the ES extension.
            if t == 0 {
                let stencil_tex_loc = Self::uniform_location(gl, check_program, c"stencilTex", "stencilTex")?;
                gl_call!(gl, "uniform1i", gl.uniform_1i(stencil_tex_loc, 0));
            }

            Self::fill_stencil_sample_pattern(gl, programs.simple_color.program())?;
            returnvalue &= Self::check_multisampled_pattern(gl, tex_target, textures[0], check_program)?;

            gl_call!(
                gl,
                "bindFramebuffer",
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbos[0])
            );
            gl_call!(
                gl,
                "bindFramebuffer",
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbos[1])
            );

            gl_call!(gl, "clearStencil", gl.clear_stencil(1));
            gl_call!(gl, "clear", gl.clear(glw::GL_STENCIL_BUFFER_BIT));

            gl_call!(
                gl,
                "blitFramebuffer",
                gl.blit_framebuffer(0, 0, 2, 2, 0, 0, 2, 2, glw::GL_STENCIL_BUFFER_BIT, glw::GL_NEAREST)
            );

            returnvalue &= Self::check_multisampled_pattern(gl, tex_target, textures[1], check_program)?;

            gl_call!(
                gl,
                "bindFramebuffer",
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbos[1])
            );
            gl_call!(
                gl,
                "bindFramebuffer",
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbos[2])
            );

            gl_call!(gl, "clearStencil", gl.clear_stencil(1));
            gl_call!(gl, "clear", gl.clear(glw::GL_STENCIL_BUFFER_BIT));

            gl_call!(
                gl,
                "blitFramebuffer",
                gl.blit_framebuffer(0, 0, 2, 2, 0, 0, 2, 2, glw::GL_STENCIL_BUFFER_BIT, glw::GL_NEAREST)
            );

            gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
            gl_call!(gl, "bindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, stencil_tex));
            gl_call!(gl, "viewport", gl.viewport(0, 0, 1, 1));
            gl_call!(gl, "clearColor", gl.clear_color(0.0, 0.0, 0.0, 0.0));
            gl_call!(gl, "clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));

            Self::draw_screen_quad(gl, programs.stencil_to_color.program())?;

            let mut color: GLuint = 0;
            gl_call!(
                gl,
                "readPixels",
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::from_mut(&mut color).cast()
                )
            );

            log::info!(
                "TextureMultisampledStencilTestCase::TestRenderToMultisampledStencilTexture: read back color after resolve: 0x{color:x}"
            );

            // The resolve blit might have chosen any of the samples.
            returnvalue &= color == 0xFF0000FF || color == 0xFF00FF00 || color == 0xFFFF0000 || color == 0xFFFFFFFF;

            gl_call!(gl, "deleteTextures", gl.delete_textures(2, textures.as_ptr()));
        }

        gl_call!(gl, "deleteTextures", gl.delete_textures(1, &stencil_tex));
        gl_call!(gl, "deleteFramebuffers", gl.delete_framebuffers(3, fbos.as_ptr()));

        Ok(returnvalue)
    }
}

impl TestCase for TextureMultisampledStencilTestCase {
    fn name(&self) -> &str {
        "multisample"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports_core(4, 4) {
            return Err(TestError::NotSupported(
                "Test TextureMultisampledStencilTestCase.is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let programs = Self::init(context)?;

        let mut ret = true;
        ret &= Self::test_create_textures_multisample(gl)?;
        ret &= Self::test_render_to_multisampled_stencil_texture(gl, &programs)?;

        Ok(if ret {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `TextureStencil8Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_stencil8");
    group.add_child(Box::new(TextureMultisampledStencilTestCase) as Box<dyn TestCase>);
    group
}

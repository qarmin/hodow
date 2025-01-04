// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayETC2Support.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayETC2Support.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The 8x8 RGBA reference image is generated from the formula the upstream table follows (r = 0, g = 224 - 32 * y, b = 32 * x, a = 255), and the six identical compressed layers are one 32-byte layer repeated.

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};

const RENDER_WIDTH: usize = 8;
const RENDER_HEIGHT: usize = 8;

const VERTEX_SHADER: &str = "\nout highp vec4 texCoord;\nvoid main()\n{\n    switch(gl_VertexID)\n    {\n        case 0:\n            gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n            break;\n        case 1:\n            gl_Position = vec4( 1.0, 1.0, 0.0, 1.0);\n            break;\n        case 2:\n            gl_Position = vec4(-1.0,-1.0, 0.0, 1.0);\n            break;\n        case 3:\n            gl_Position = vec4( 1.0,-1.0, 0.0, 1.0);\n            break;\n    }\n    texCoord = vec4(gl_Position.xy, 1.0, 0.0);}\n";

const FRAGMENT_SHADER: &str = "\nuniform highp samplerCubeArray texture_sampler;\nin highp vec4 texCoord;out highp vec4 color;\nvoid main()\n{\n    color = texture(texture_sampler, texCoord);\n}\n";

/// One layer of the 8x8 RGB ETC2 texture; all six layers are the same.
const COMPRESSED_LAYER: [u8; 32] = [
    0x0, 0x0, 0x4, 0x2, 0x1, 0x0, 0x6f, 0xc0, 0x0, 0x1, 0x4, 0x2, 0x1, 0xf8, 0x6f, 0xe0, 0x1, 0x0, 0x4, 0x2, 0x80,
    0xf8, 0x5f, 0xc0, 0x1, 0x0, 0xfb, 0x82, 0x81, 0xf8, 0x5f, 0xe0,
];

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `TextureCubeMapArrayETC2Support` (Test 11)
pub(super) struct Etc2Support;

#[derive(Default)]
struct Objects {
    fbo: GLuint,
    rbo: GLuint,
    vao: GLuint,
    texture: GLuint,
    program: GLuint,
}

impl Etc2Support {
    /// `prepareProgram`
    fn prepare_program(context: &Context, o: &mut Objects) -> Result<(), TestError> {
        let gl = context.gl();
        let glsl_version = context.context_type().glsl_version().declaration();

        let shaders = [
            (VERTEX_SHADER, glw::GL_VERTEX_SHADER),
            (FRAGMENT_SHADER, glw::GL_FRAGMENT_SHADER),
        ];
        let mut shader_ids = [0 as GLuint; 2];
        let mut program_preparation_failed = false;

        // SAFETY: object creation on the current context.
        o.program = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram call failed.")?;

        for (i, (source, shader_type)) in shaders.iter().enumerate() {
            // SAFETY: object creation on the current context.
            shader_ids[i] = unsafe { gl.create_shader(*shader_type) };
            glu::expect_no_error(gl, "glCreateShader call failed.")?;
            gl_call!(
                gl,
                "glAttachShader call failed.",
                gl.attach_shader(o.program, shader_ids[i])
            );

            let shader_source = format!("{glsl_version}{source}");
            let pointer = shader_source.as_ptr().cast::<glw::GLchar>();
            let length = shader_source.len() as GLint;
            gl_call!(
                gl,
                "glShaderSource call failed.",
                gl.shader_source(shader_ids[i], 1, &pointer, &length)
            );
            gl_call!(gl, "glCompileShader call failed.", gl.compile_shader(shader_ids[i]));

            let mut status: GLint = glw::GL_FALSE as GLint;
            gl_call!(
                gl,
                "glGetShaderiv call failed.",
                gl.get_shaderiv(shader_ids[i], glw::GL_COMPILE_STATUS, &mut status)
            );
            if status == glw::GL_FALSE as GLint {
                let mut log_size: GLint = 0;
                gl_call!(
                    gl,
                    "glGetShaderiv call failed.",
                    gl.get_shaderiv(shader_ids[i], glw::GL_INFO_LOG_LENGTH, &mut log_size)
                );
                let mut log_text = vec![0u8; log_size.max(0) as usize];
                gl_call!(
                    gl,
                    "glGetShaderInfoLog call failed.",
                    gl.get_shader_info_log(
                        shader_ids[i],
                        log_size,
                        std::ptr::null_mut(),
                        log_text.as_mut_ptr().cast()
                    )
                );
                log::info!(
                    "Shader compilation error, log:\n{}\nShader source code:\n{shader_source}\n",
                    String::from_utf8_lossy(&log_text)
                );
                program_preparation_failed = true;
                break;
            }
        }

        if program_preparation_failed {
            if o.program != 0 {
                // SAFETY: deletes the name this test created.
                unsafe { gl.delete_program(o.program) };
                o.program = 0;
            }
        } else {
            gl_call!(gl, "glLlinkProgram call failed.", gl.link_program(o.program));
            let mut status: GLint = glw::GL_FALSE as GLint;
            // SAFETY: one int out.
            unsafe { gl.get_programiv(o.program, glw::GL_LINK_STATUS, &mut status) };
            if status == glw::GL_TRUE as GLint {
                for shader_id in shader_ids.into_iter().filter(|&id| id != 0) {
                    gl_call!(
                        gl,
                        "glDetachShader call failed.",
                        gl.detach_shader(o.program, shader_id)
                    );
                }
            } else {
                let mut log_size: GLint = 0;
                gl_call!(
                    gl,
                    "glGetProgramiv call failed.",
                    gl.get_programiv(o.program, glw::GL_INFO_LOG_LENGTH, &mut log_size)
                );
                let mut log_text = vec![0u8; log_size.max(0) as usize];
                gl_call!(
                    gl,
                    "glGetProgramInfoLog call failed.",
                    gl.get_program_info_log(o.program, log_size, std::ptr::null_mut(), log_text.as_mut_ptr().cast())
                );
                log::info!(
                    "Program linkage has failed due to:\n{}\n",
                    String::from_utf8_lossy(&log_text)
                );
            }
        }

        for shader_id in shader_ids.into_iter().filter(|&id| id != 0) {
            // SAFETY: deletes names this test created.
            unsafe { gl.delete_shader(shader_id) };
        }

        if o.program != 0 {
            // SAFETY: a program object of this test and a NUL-terminated name.
            let texture_sampler = unsafe { gl.get_uniform_location(o.program, c"texture_sampler".as_ptr()) };
            glu::expect_no_error(gl, "glGetUniformLocation call failed.")?;
            gl_call!(gl, "glUseProgram call failed.", gl.use_program(o.program));
            gl_call!(gl, "glUniform1i call failed.", gl.uniform_1i(texture_sampler, 0));
            Ok(())
        } else {
            Err(TestError::Fail("Failed to prepare program".to_string()))
        }
    }

    fn run(context: &Context, o: &mut Objects) -> Result<bool, TestError> {
        let gl = context.gl();

        // `prepareFramebuffer`
        gl_call!(
            gl,
            "glGenRenderbuffers call failed.",
            gl.gen_renderbuffers(1, &mut o.rbo)
        );
        gl_call!(
            gl,
            "glBindRenderbuffer call failed.",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, o.rbo)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage call failed.",
            gl.renderbuffer_storage(
                glw::GL_RENDERBUFFER,
                glw::GL_RGBA8,
                RENDER_WIDTH as GLint,
                RENDER_HEIGHT as GLint
            )
        );
        gl_call!(gl, "glGenFramebuffers call failed.", gl.gen_framebuffers(1, &mut o.fbo));
        gl_call!(
            gl,
            "glBindFramebuffer call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo)
        );
        gl_call!(
            gl,
            "glFramebufferRenderbuffer call failed.",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                o.rbo
            )
        );

        Self::prepare_program(context, o)?;

        // `prepareVertexArrayObject`
        gl_call!(
            gl,
            "glGenVertexArrays call failed.",
            gl.gen_vertex_arrays(1, &mut o.vao)
        );
        gl_call!(gl, "glBindVertexArray call failed.", gl.bind_vertex_array(o.vao));

        // `prepareTexture`
        gl_call!(gl, "glActiveTexture call failed.", gl.active_texture(glw::GL_TEXTURE0));
        gl_call!(gl, "glGenTextures call failed.", gl.gen_textures(1, &mut o.texture));
        let target = glw::GL_TEXTURE_CUBE_MAP_ARRAY;
        gl_call!(gl, "glBindTexture call failed.", gl.bind_texture(target, o.texture));

        let compressed_data: Vec<u8> = COMPRESSED_LAYER.repeat(6);
        gl_call!(
            gl,
            "glCompressedTexImage3D call failed.",
            gl.compressed_tex_image_3d(
                target,
                0,
                glw::GL_COMPRESSED_RGB8_ETC2,
                RENDER_WIDTH as GLint,
                RENDER_HEIGHT as GLint,
                6,
                0,
                compressed_data.len() as GLint,
                compressed_data.as_ptr().cast()
            )
        );
        gl_call!(gl, "glTexParameteri call failed.", {
            gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as GLint);
            gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as GLint);
        });

        // `draw`
        gl_call!(gl, "glDrawArrays call failed.", {
            gl.viewport(0, 0, RENDER_WIDTH as GLint, RENDER_HEIGHT as GLint);
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
        });

        // `isRenderedImageValid`
        let mut reference_data = vec![0u8; RENDER_WIDTH * RENDER_HEIGHT * 4];
        for y in 0..RENDER_HEIGHT {
            for x in 0..RENDER_WIDTH {
                reference_data[(y * RENDER_WIDTH + x) * 4..(y * RENDER_WIDTH + x) * 4 + 4].copy_from_slice(&[
                    0,
                    (224 - 32 * y) as u8,
                    (32 * x) as u8,
                    255,
                ]);
            }
        }
        let texture_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let reference_img = ConstPixelBufferAccess::new(
            texture_format,
            [RENDER_WIDTH as u32, RENDER_HEIGHT as u32, 1],
            &reference_data,
        );

        let mut rendered_data = vec![0u8; RENDER_WIDTH * RENDER_HEIGHT * 4];
        gl_call!(
            gl,
            "glu::readPixels call failed.",
            gl.read_pixels(
                0,
                0,
                RENDER_WIDTH as GLint,
                RENDER_HEIGHT as GLint,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                rendered_data.as_mut_ptr().cast()
            )
        );
        let rendered_img = ConstPixelBufferAccess::new(
            texture_format,
            [RENDER_WIDTH as u32, RENDER_HEIGHT as u32, 1],
            &rendered_data,
        );

        // a big threshold, as the compression is inaccurate
        let compare_threshold = 0.05f32;
        Ok(fuzzy_compare_ok(&reference_img, &rendered_img, compare_threshold).unwrap_or(false))
    }

    /// `clean`
    fn clean(gl: &glw::Functions, o: &mut Objects) {
        // SAFETY: deletes names this test created, on the current context.
        unsafe {
            if o.fbo != 0 {
                gl.delete_framebuffers(1, &o.fbo);
                o.fbo = 0;
            }
            if o.rbo != 0 {
                gl.delete_renderbuffers(1, &o.rbo);
                o.rbo = 0;
            }
            if o.vao != 0 {
                gl.delete_vertex_arrays(1, &o.vao);
                o.vao = 0;
            }
            if o.texture != 0 {
                gl.delete_textures(1, &o.texture);
                o.texture = 0;
            }
            if o.program != 0 {
                gl.use_program(0);
                gl.delete_program(o.program);
                o.program = 0;
            }
        }
    }
}

impl TestCase for Etc2Support {
    fn name(&self) -> &str {
        "etc2_texture"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut objects = Objects::default();
        let outcome = Self::run(context, &mut objects);
        Self::clean(context.gl(), &mut objects);

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

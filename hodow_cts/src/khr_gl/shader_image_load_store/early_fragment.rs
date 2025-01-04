// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (ImageLoadStoreEarlyFragmentTestsTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `GLU_EXPECT_NO_ERROR` is `glu::expect_no_error(..)?`, `tcu::InternalError` is `TestError::Fail`; the repeated "clean the texture, set the uniforms, draw, barrier, check" step of `testEarlyZ`/`testEarlyStencil` is `draw_and_check`. Written without compiling.

use super::base::*;
use crate::glu::{self, Context};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};
use crate::tcu::TestError;

const FRAGMENT_SHADER_WITH_DISABLED_EARLY_TESTS: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(r32f) uniform image2D u_image;\n\nvoid main()\n{\n    vec4 color = vec4(1.0, 0, 0, 0);\n\n    imageStore(u_image, ivec2(gl_FragCoord.xy), color);\n\n    discard;\n}\n\n";
const FRAGMENT_SHADER_WITH_ENABLED_EARLY_TESTS: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(early_fragment_tests) in;\n\nlayout(r32f) uniform image2D u_image;\n\nvoid main()\n{\n    vec4 color = vec4(1.0, 0, 0, 0);\n\n    imageStore(u_image, ivec2(gl_FragCoord.xy), color);\n\n    discard;\n}\n\n";
const GEOMETRY_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\nuniform float u_depth;\n\nvoid main()\n{\n    // Left-bottom\n    gl_Position = vec4(-1, -1, u_depth, 1);\n    EmitVertex();\n\n    // Left-top\n    gl_Position = vec4(-1,  1, u_depth, 1);\n    EmitVertex();\n\n    // Right-bottom\n    gl_Position = vec4( 1, -1, u_depth, 1);\n    EmitVertex();\n\n    // Right-top\n    gl_Position = vec4( 1,  1, u_depth, 1);\n    EmitVertex();\n}\n\n";
const VERTEX_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nvoid main()\n{\n}\n\n";

/// `programDetails`
#[derive(Default, Clone, Copy)]
struct ProgramDetails {
    depth_uniform_location: GLint,
    image_uniform_location: GLint,
    program_id: GLuint,
}

/// 5 ImageLoadStoreEarlyFragmentTestsTest
#[derive(Default)]
pub(super) struct ImageLoadStoreEarlyFragmentTestsTest {
    image_edge: u32,
    clean_texture_data: Vec<f32>,
    extracted_texture_data: Vec<f32>,
    disabled_early_tests: ProgramDetails,
    enabled_early_tests: ProgramDetails,
    color_renderbuffer_id: GLuint,
    depth_stencil_renderbuffer_id: GLuint,
    framebuffer_id: GLuint,
    texture_id: GLuint,
    vertex_array_object_id: GLuint,
}

/// `prepareProgramDetails`
fn prepare_program_details(gl: &glw::Functions, fragment_shader_code: &str) -> Result<ProgramDetails, TestError> {
    let mut is_program_built = true;
    let program_id = build_program_5(
        gl,
        Some(VERTEX_SHADER_CODE),
        None,
        None,
        Some(GEOMETRY_SHADER_CODE),
        Some(fragment_shader_code),
        Some(&mut is_program_built),
    );
    if !is_program_built {
        return Err(TestError::Fail("Failed to build program".to_string()));
    }

    let depth_uniform_location = uniform_location(gl, program_id, "u_depth");
    glu::expect_no_error(gl, "GetUniformLocation")?;
    if depth_uniform_location == -1 {
        return Err(TestError::Fail("Uniform is not active: u_image".to_string()));
    }

    let image_uniform_location = uniform_location(gl, program_id, "u_image");
    glu::expect_no_error(gl, "GetUniformLocation")?;
    if image_uniform_location == -1 {
        return Err(TestError::Fail("Uniform is not active: u_image".to_string()));
    }

    Ok(ProgramDetails {
        depth_uniform_location,
        image_uniform_location,
        program_id,
    })
}

impl ImageLoadStoreEarlyFragmentTestsTest {
    /// `cleanTexture`
    fn clean_texture(&self, gl: &glw::Functions) -> Result<(), TestError> {
        gl!(gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            self.image_edge as GLint,
            self.image_edge as GLint,
            glw::GL_RED,
            glw::GL_FLOAT,
            self.clean_texture_data.as_ptr().cast()
        ));
        glu::expect_no_error(gl, "TexSubImage2D")
    }

    /// `isTextureFilledWithValue`
    fn is_texture_filled_with_value(&mut self, gl: &glw::Functions, value: f32) -> Result<bool, TestError> {
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RED,
            glw::GL_FLOAT,
            self.extracted_texture_data.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "GetTexImage")?;
        for (i, texel) in self.extracted_texture_data.iter().enumerate() {
            if value != *texel {
                log::info!("Texel at location {i} has invalid value: {texel} expected: {value}");
                return Ok(false);
            }
        }
        Ok(true)
    }

    /// The shared tail of every block of `testEarlyZ` and `testEarlyStencil`: clean the texture, optionally set the uniforms, draw one point, barrier and compare the texture with `expected`.
    fn draw_and_check(
        &mut self,
        gl: &glw::Functions,
        uniforms: Option<(ProgramDetails, f32)>,
        expected: f32,
        before_draw: impl FnOnce() -> Result<(), TestError>,
    ) -> Result<bool, TestError> {
        self.clean_texture(gl)?;
        before_draw()?;
        if let Some((details, depth)) = uniforms {
            gl!(gl.uniform_1i(details.image_uniform_location, 0));
            glu::expect_no_error(gl, "Uniform1i")?;
            gl!(gl.uniform_1f(details.depth_uniform_location, depth));
            glu::expect_no_error(gl, "Uniform1f")?;
        }
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "DrawArrays")?;
        gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
        glu::expect_no_error(gl, "MemoryBarrier")?;
        self.is_texture_filled_with_value(gl, expected)
    }

    fn use_program(gl: &glw::Functions, program_id: GLuint) -> Result<(), TestError> {
        gl!(gl.use_program(program_id));
        glu::expect_no_error(gl, "glUseProgram")
    }

    fn clear_all(gl: &glw::Functions) -> Result<(), TestError> {
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));
        glu::expect_no_error(gl, "Clear")
    }

    /// `testEarlyStencil`
    fn test_early_stencil(&mut self, gl: &glw::Functions) -> Result<bool, TestError> {
        let mut result = true;
        let (enabled, disabled) = (self.enabled_early_tests, self.disabled_early_tests);

        gl!(gl.enable(glw::GL_STENCIL_TEST));
        glu::expect_no_error(gl, "glEnable")?;
        gl!(gl.clear_depthf(1.0));
        glu::expect_no_error(gl, "ClearDepthf")?;

        // verify that early stencil test is applied when enabled
        Self::use_program(gl, enabled.program_id)?;
        gl!(gl.clear_stencil(0));
        glu::expect_no_error(gl, "ClearStencil")?;
        Self::clear_all(gl)?;
        let filled = self.draw_and_check(gl, Some((enabled, 0.0)), 0.0, || {
            gl!(gl.stencil_func(glw::GL_LESS, 128, 0xffffffff));
            glu::expect_no_error(gl, "StencilFunc")
        })?;
        if !filled {
            log::info!("Problem with early stencil test. It is not applied");
            result = false;
        }

        // verify that early stencil test does not discard all fragments
        gl!(gl.clear_stencil(128));
        glu::expect_no_error(gl, "ClearStencil")?;
        Self::clear_all(gl)?;
        let filled = self.draw_and_check(gl, None, 1.0, || {
            gl!(gl.stencil_func(glw::GL_LESS, 0, 0xffffffff));
            glu::expect_no_error(gl, "StencilFunc")
        })?;
        if !filled {
            log::info!("Problem with early stencil test. It discards fragments, that shall be drawn");
            result = false;
        }

        // verify that early stencil test is not applied when disabled
        Self::use_program(gl, disabled.program_id)?;
        gl!(gl.clear_stencil(0));
        glu::expect_no_error(gl, "ClearStencil")?;
        Self::clear_all(gl)?;
        let filled = self.draw_and_check(gl, Some((disabled, 0.0)), 1.0, || {
            gl!(gl.stencil_func(glw::GL_LESS, 128, 0xffffffff));
            glu::expect_no_error(gl, "StencilFunc")
        })?;
        if !filled {
            log::info!("Problem with early stencil test. It is applied when disabled");
            result = false;
        }

        gl!(gl.disable(glw::GL_STENCIL_TEST));
        glu::expect_no_error(gl, "Disable")?;
        Ok(result)
    }

    /// `testEarlyZ`
    fn test_early_z(&mut self, gl: &glw::Functions) -> Result<bool, TestError> {
        let mut result = true;
        let (enabled, disabled) = (self.enabled_early_tests, self.disabled_early_tests);

        gl!(gl.enable(glw::GL_DEPTH_TEST));
        glu::expect_no_error(gl, "glEnable")?;
        gl!(gl.clear_depthf(0.5));
        glu::expect_no_error(gl, "ClearDepthf")?;
        gl!(gl.clear_stencil(0));
        glu::expect_no_error(gl, "ClearStencil")?;

        // verify that early z test is applied when enabled
        Self::use_program(gl, enabled.program_id)?;
        Self::clear_all(gl)?;
        if !self.draw_and_check(gl, Some((enabled, 0.5)), 0.0, || Ok(()))? {
            log::info!("Problem with early z test. It is not applied");
            result = false;
        }

        // verify that early z test does not discard all fragments
        Self::clear_all(gl)?;
        if !self.draw_and_check(gl, Some((enabled, -0.5)), 1.0, || Ok(()))? {
            log::info!("Problem with early z test. It discards fragments, that shall be drawn");
            result = false;
        }

        // verify that early z test is not applied when disabled
        Self::use_program(gl, disabled.program_id)?;
        Self::clear_all(gl)?;
        if !self.draw_and_check(gl, Some((disabled, 0.5)), 1.0, || Ok(()))? {
            log::info!("Problem with early z test. It is applied when disabled");
            result = false;
        }

        gl!(gl.disable(glw::GL_DEPTH_TEST));
        glu::expect_no_error(gl, "Disable")?;
        Ok(result)
    }
}

impl Subcase for ImageLoadStoreEarlyFragmentTestsTest {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        self.image_edge = 64.min(height.min(width)) as u32;

        let texels = (self.image_edge * self.image_edge) as usize;
        self.clean_texture_data = vec![0.0; texels];
        self.extracted_texture_data = vec![0.0; texels];

        // buildPrograms
        self.disabled_early_tests = prepare_program_details(gl, FRAGMENT_SHADER_WITH_DISABLED_EARLY_TESTS)?;
        self.enabled_early_tests = prepare_program_details(gl, FRAGMENT_SHADER_WITH_ENABLED_EARLY_TESTS)?;

        // createFramebuffer
        let edge = self.image_edge as GLint;
        gl!(gl.gen_renderbuffers(1, &mut self.color_renderbuffer_id));
        glu::expect_no_error(gl, "GenRenderbuffers")?;
        gl!(gl.gen_renderbuffers(1, &mut self.depth_stencil_renderbuffer_id));
        glu::expect_no_error(gl, "GenRenderbuffers")?;

        gl!(gl.gen_framebuffers(1, &mut self.framebuffer_id));
        glu::expect_no_error(gl, "GenFramebuffers")?;
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.framebuffer_id));
        glu::expect_no_error(gl, "BindFramebuffer")?;

        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, self.color_renderbuffer_id));
        glu::expect_no_error(gl, "BindRenderbuffer")?;
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R32F, edge, edge));
        glu::expect_no_error(gl, "RenderbufferStorage")?;
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            self.color_renderbuffer_id
        ));
        glu::expect_no_error(gl, "FramebufferRenderbuffer")?;

        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, self.depth_stencil_renderbuffer_id));
        glu::expect_no_error(gl, "BindRenderbuffer")?;
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, edge, edge));
        glu::expect_no_error(gl, "RenderbufferStorage")?;
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            self.depth_stencil_renderbuffer_id
        ));
        glu::expect_no_error(gl, "FramebufferRenderbuffer")?;

        // createTexture
        gl!(gl.gen_textures(1, &mut self.texture_id));
        glu::expect_no_error(gl, "GenTextures")?;
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture_id));
        glu::expect_no_error(gl, "BindTexture")?;
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32F, edge, edge));
        glu::expect_no_error(gl, "TexStorage2D")?;

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array_object_id));
        glu::expect_no_error(gl, "GenVertexArrays")?;
        gl!(gl.bind_vertex_array(self.vertex_array_object_id));
        glu::expect_no_error(gl, "BindVertexArray")?;

        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        glu::expect_no_error(gl, "ClearColor")?;
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = true;

        // bind texture to the first image unit
        gl!(gl.bind_image_texture(0, self.texture_id, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32F));
        glu::expect_no_error(gl, "BindImageTexture")?;

        if !self.test_early_z(gl)? {
            result = false;
        }
        if !self.test_early_stencil(gl)? {
            result = false;
        }

        Ok(if result { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0));
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.disable(glw::GL_DEPTH_TEST));
        gl!(gl.disable(glw::GL_STENCIL_TEST));
        gl!(gl.use_program(0));

        for details in [&mut self.disabled_early_tests, &mut self.enabled_early_tests] {
            if details.program_id != 0 {
                gl!(gl.delete_program(details.program_id));
                details.program_id = 0;
            }
        }
        for renderbuffer in [&mut self.color_renderbuffer_id, &mut self.depth_stencil_renderbuffer_id] {
            if *renderbuffer != 0 {
                gl!(gl.delete_renderbuffers(1, renderbuffer));
                *renderbuffer = 0;
            }
        }
        if self.framebuffer_id != 0 {
            gl!(gl.delete_framebuffers(1, &self.framebuffer_id));
            self.framebuffer_id = 0;
        }
        if self.texture_id != 0 {
            gl!(gl.delete_textures(1, &self.texture_id));
            self.texture_id = 0;
        }
        if self.vertex_array_object_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &self.vertex_array_object_id));
            self.vertex_array_object_id = 0;
        }
        Ok(NO_ERROR)
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureViewTests.cpp  (TextureViewTestBaseAndMaxLevels)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{check_texture_view_support, compile_shader, link_program, shader_source, uniform_location};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_HEIGHT: u32 = 256;
const TEXTURE_N_COMPONENTS: u32 = 4;
const TEXTURE_N_LEVELS: u32 = 6;
const TEXTURE_WIDTH: u32 = 256;
const VIEW_HEIGHT: u32 = 128;
const VIEW_WIDTH: u32 = 128;

const VS_BODY: &str = "#version 400\n\nout vec2 uv;\n\nvoid main()\n{\n    switch (gl_VertexID)\n    {\n        case 0: gl_Position = vec4(-1.0,  1.0, 0.0, 1.0); uv = vec2(0.0, 1.0); break;\n        case 1: gl_Position = vec4(-1.0, -1.0, 0.0, 1.0); uv = vec2(0.0, 0.0); break;\n        case 2: gl_Position = vec4( 1.0,  1.0, 0.0, 1.0); uv = vec2(1.0, 1.0); break;\n        case 3: gl_Position = vec4( 1.0, -1.0, 0.0, 1.0); uv = vec2(1.0, 0.0); break;\n    };\n}\n";

const FS_BODY: &str = "#version 400\n\nin vec2 uv;\n\nuniform int       lod_index;\nuniform sampler2D to_sampler;\n\nout vec4 result;\n\nvoid main()\n{\n    result = textureLod(to_sampler, uv, float(lod_index) );\n}\n";

/// The GL objects of one run; `TextureViewTestBaseAndMaxLevels::deinit` is the `Drop`.
struct State<'gl> {
    gl: &'gl glw::Functions,
    fbo_id: GLuint,
    fs_id: GLuint,
    po_id: GLuint,
    po_lod_index_uniform_location: GLint,
    po_to_sampler_uniform_location: GLint,
    result_to_id: GLuint,
    to_id: GLuint,
    vao_id: GLuint,
    view_to_id: GLuint,
    vs_id: GLuint,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            if self.fbo_id != 0 {
                gl.delete_framebuffers(1, &self.fbo_id);
            }
            if self.fs_id != 0 {
                gl.delete_shader(self.fs_id);
            }
            if self.po_id != 0 {
                gl.delete_program(self.po_id);
            }
            if self.result_to_id != 0 {
                gl.delete_textures(1, &self.result_to_id);
            }
            if self.to_id != 0 {
                gl.delete_textures(1, &self.to_id);
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }
            if self.view_to_id != 0 {
                gl.delete_textures(1, &self.view_to_id);
            }
            if self.vs_id != 0 {
                gl.delete_shader(self.vs_id);
            }
        }
    }
}

impl<'gl> State<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        Self {
            gl,
            fbo_id: 0,
            fs_id: 0,
            po_id: 0,
            po_lod_index_uniform_location: -1,
            po_to_sampler_uniform_location: -1,
            result_to_id: 0,
            to_id: 0,
            vao_id: 0,
            view_to_id: 0,
            vs_id: 0,
        }
    }

    /// `initProgram`
    fn init_program(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        // SAFETY: plain object creation with a current context.
        unsafe {
            self.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            self.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu_expect(gl, "glCreateShader() call(s) failed")?;

        // SAFETY: plain object creation with a current context.
        self.po_id = unsafe { gl.create_program() };
        glu_expect(gl, "glCreateProgram() call failed")?;

        shader_source(
            gl,
            self.vs_id,
            VS_BODY,
            "glShaderSource() call failed for vertex shader case",
        )?;
        shader_source(
            gl,
            self.fs_id,
            FS_BODY,
            "glShaderSource() call failed for fragment shader case",
        )?;

        for so_id in [self.fs_id, self.vs_id] {
            compile_shader(gl, so_id)?;
        }

        gl_call!(gl, "glAttachShader() call(s) failed", {
            gl.attach_shader(self.po_id, self.fs_id);
            gl.attach_shader(self.po_id, self.vs_id);
        });

        link_program(gl, self.po_id, "glLinkProgram() call faikled")?;

        self.po_lod_index_uniform_location = uniform_location(gl, self.po_id, "lod_index");
        self.po_to_sampler_uniform_location = uniform_location(gl, self.po_id, "to_sampler");

        if self.po_lod_index_uniform_location == -1 {
            return Err(TestError::Fail(
                "lod_index is considered an inactive uniform".to_string(),
            ));
        }

        if self.po_to_sampler_uniform_location == -1 {
            return Err(TestError::Fail(
                "to_sampler is considered an inactive uniform".to_string(),
            ));
        }

        Ok(())
    }

    /// `initTextures`
    fn init_textures(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glGenTextures() call(s) failed", {
            gl.gen_textures(1, &mut self.result_to_id);
            gl.gen_textures(1, &mut self.to_id);
            gl.gen_textures(1, &mut self.view_to_id);
        });

        gl_call!(
            gl,
            "glBindTexture() call failed",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.to_id)
        );

        gl_call!(
            gl,
            "glTexStorage2D() call failed",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                TEXTURE_N_LEVELS as GLint,
                glw::GL_RGBA8,
                TEXTURE_WIDTH as GLint,
                TEXTURE_HEIGHT as GLint
            )
        );

        gl_call!(
            gl,
            "glTexParameteri() call failed for GL_TEXTURE_BASE_LEVEL pname",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 2)
        );
        gl_call!(
            gl,
            "glTexParameteri() call failed for GL_TEXTURE_MAX_LEVEL pname",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 4)
        );

        for n_mipmap in 0..TEXTURE_N_LEVELS {
            let (start_rgba, end_rgba) = gradient_colors(n_mipmap);

            let mipmap_height = TEXTURE_HEIGHT >> n_mipmap;
            let mipmap_width = TEXTURE_WIDTH >> n_mipmap;
            let mut data = vec![0u8; (mipmap_width * mipmap_height * TEXTURE_N_COMPONENTS) as usize];

            let pixel_size = 4usize;

            for y in 0..mipmap_height as usize {
                let row_offset = mipmap_width as usize * y * pixel_size;

                for x in 0..mipmap_width as usize {
                    let lerp_factor = x as f32 / mipmap_width as f32;
                    let pixel_offset = row_offset + x * pixel_size;

                    for n_component in 0..TEXTURE_N_COMPONENTS as usize {
                        data[pixel_offset + n_component] = ((start_rgba[n_component] * lerp_factor
                            + end_rgba[n_component] * (1.0 - lerp_factor))
                            * 255.0) as u8;
                    }
                }
            }

            gl_call!(
                gl,
                "glTexSubImage2D() call failed",
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    n_mipmap as GLint,
                    0,
                    0,
                    mipmap_width as GLint,
                    mipmap_height as GLint,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data.as_ptr().cast()
                )
            );
        }

        gl_call!(
            gl,
            "glTextureView() call failed",
            gl.texture_view(
                self.view_to_id,
                glw::GL_TEXTURE_2D,
                self.to_id,
                glw::GL_RGBA8,
                0,
                5,
                0,
                1
            )
        );

        gl_call!(
            gl,
            "glBindTexture() call failed",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.view_to_id)
        );

        gl_call!(
            gl,
            "glTexParameteri() call failed for GL_TEXTURE_BASE_LEVEL pname",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 1)
        );
        gl_call!(
            gl,
            "glTexParameteri() call failed for GL_TEXTURE_MAX_LEVEL pname",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 2)
        );

        gl_call!(
            gl,
            "glBindTexture() call failed",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.result_to_id)
        );

        gl_call!(
            gl,
            "glTexStorage2D() call failed",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA8,
                VIEW_WIDTH as GLint,
                VIEW_HEIGHT as GLint
            )
        );

        Ok(())
    }

    /// `initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        self.init_textures()?;

        gl_call!(
            gl,
            "glGenFramebuffers() call failed",
            gl.gen_framebuffers(1, &mut self.fbo_id)
        );

        self.init_program()?;

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(self.vao_id)
        );

        Ok(())
    }
}

fn glu_expect(gl: &glw::Functions, message: &str) -> Result<(), TestError> {
    crate::glu::expect_no_error(gl, message)
}

/// The `start_rgba`/`end_rgba` pair of the gradient stored in mip-map `n_mipmap`, "as per test specification".
fn gradient_colors(n_mipmap: u32) -> ([f32; 4], [f32; 4]) {
    let n = n_mipmap as f32;
    let start_rgba = [(n + 0.0) / 10.0, (n + 1.0) / 10.0, (n + 2.0) / 10.0, (n + 3.0) / 10.0];
    let end_rgba = [
        (10.0 - (n + 0.0)) / 10.0,
        (10.0 - (n + 1.0)) / 10.0,
        (10.0 - (n + 2.0)) / 10.0,
        (10.0 - (n + 3.0)) / 10.0,
    ];
    (start_rgba, end_rgba)
}

/// `TextureViewTestBaseAndMaxLevels`
pub(super) struct BaseAndMaxLevels;

impl TestCase for BaseAndMaxLevels {
    fn name(&self) -> &str {
        "base_and_max_levels"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        check_texture_view_support(context)?;

        let mut state = State::new(gl);
        state.init_test()?;

        let mut layer_data_lod0 = vec![0u8; (TEXTURE_WIDTH * TEXTURE_HEIGHT * TEXTURE_N_COMPONENTS) as usize];
        let mut layer_data_lod1 =
            vec![0u8; ((TEXTURE_WIDTH >> 1) * (TEXTURE_HEIGHT >> 1) * TEXTURE_N_COMPONENTS) as usize];

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(state.po_id));

        gl_call!(gl, "glActiveTexture() call failed", gl.active_texture(glw::GL_TEXTURE0));
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, state.view_to_id)
        );

        for lod_level in 0..2u32 {
            gl_call!(
                gl,
                "glBindFramebuffer() call failed",
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, state.fbo_id)
            );
            gl_call!(
                gl,
                "glFramebufferTexture2D() call failed",
                gl.framebuffer_texture_2d(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    state.result_to_id,
                    0
                )
            );

            gl_call!(
                gl,
                "glViewport() call failed",
                gl.viewport(
                    0,
                    0,
                    (VIEW_WIDTH >> lod_level) as GLint,
                    (VIEW_HEIGHT >> lod_level) as GLint
                )
            );

            gl_call!(
                gl,
                "glUniform1i() call failed.",
                gl.uniform_1i(state.po_lod_index_uniform_location, lod_level as GLint)
            );

            gl_call!(
                gl,
                "glDrawArrays() call failed.",
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4)
            );

            let result_data = if lod_level == 0 {
                &mut layer_data_lod0
            } else {
                &mut layer_data_lod1
            };

            gl_call!(
                gl,
                "glReadPixels() call failed",
                gl.read_pixels(
                    0,
                    0,
                    (VIEW_WIDTH >> lod_level) as GLint,
                    (VIEW_HEIGHT >> lod_level) as GLint,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    result_data.as_mut_ptr().cast()
                )
            );
        }

        for lod_level in 0..2u32 {
            let epsilon = 1;
            let layer_data = if lod_level == 0 {
                &layer_data_lod0
            } else {
                &layer_data_lod1
            };
            let layer_height = (VIEW_HEIGHT >> lod_level) as usize;
            let layer_width = (VIEW_WIDTH >> lod_level) as usize;
            let pixel_size = 4usize;
            let view_minimum_level = 1;
            let (start_rgba, end_rgba) = gradient_colors(lod_level + view_minimum_level);

            for y in 0..layer_height {
                let row_offset = layer_width * y * pixel_size;

                for x in 0..layer_width {
                    let lerp_factor = x as f32 / layer_width as f32;
                    let pixel = &layer_data[row_offset + x * pixel_size..row_offset + (x + 1) * pixel_size];

                    let expected_data: [u8; 4] = std::array::from_fn(|n| {
                        ((start_rgba[n] * lerp_factor + end_rgba[n] * (1.0 - lerp_factor)) * 255.0) as u8
                    });

                    if (0..4).any(|n| (expected_data[n] as i32 - pixel[n] as i32).abs() > epsilon) {
                        log::info!(
                            "Found an invalid texel at ({x}, {y}); expected value:({}, {}, {}, {}), found:({}, {}, {}, {})",
                            expected_data[0],
                            expected_data[1],
                            expected_data[2],
                            expected_data[3],
                            pixel[0],
                            pixel[1],
                            pixel[2],
                            pixel[3]
                        );

                        return Err(TestError::Fail(
                            "Rendered data does not match expected pixel data".to_string(),
                        ));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

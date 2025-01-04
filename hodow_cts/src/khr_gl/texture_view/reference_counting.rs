// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureViewTests.cpp  (TextureViewTestReferenceCounting)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::{check_texture_view_support, compile_shader, link_program, shader_source, uniform_location};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_HEIGHT: u32 = 64;
const TEXTURE_N_LEVELS: u32 = 7;
const TEXTURE_WIDTH: u32 = 64;

/// `_norm_vec4` colours of the successive mip-maps of the parent texture.
const MIPMAP_COLORS: [[u8; 4]; 7] = [
    [123, 34, 56, 78],
    [234, 45, 67, 89],
    [34, 56, 78, 90],
    [45, 67, 89, 1],
    [56, 78, 90, 123],
    [67, 89, 1, 234],
    [78, 90, 12, 34],
];

const VS_BODY: &str = "#version 400\n\nuniform vec4      expected_texel;\nuniform int       lod;\nuniform sampler2D sampler;\n\nout int has_passed;\n\nvoid main()\n{\n          vec4  data    = textureLod(sampler, vec2(0.5, 0.5), lod);\n    const float epsilon = 1.0 / 256.0;\n\n    if (abs(data.r - expected_texel.r) > epsilon ||\n        abs(data.g - expected_texel.g) > epsilon ||\n        abs(data.b - expected_texel.b) > epsilon ||\n        abs(data.a - expected_texel.a) > epsilon)\n    {\n        has_passed = 0;\n    }\n    else\n    {\n        has_passed = 1;\n    }\n}\n";

/// The GL objects of one run; `TextureViewTestReferenceCounting::deinit` is the `Drop`.
struct State<'gl> {
    gl: &'gl glw::Functions,
    bo_id: GLuint,
    parent_to_id: GLuint,
    po_id: GLuint,
    po_expected_texel_uniform_location: GLint,
    po_lod_uniform_location: GLint,
    vao_id: GLuint,
    view_to_id: GLuint,
    view_view_to_id: GLuint,
    vs_id: GLuint,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            if self.bo_id != 0 {
                gl.delete_buffers(1, &self.bo_id);
            }
            if self.parent_to_id != 0 {
                gl.delete_textures(1, &self.parent_to_id);
            }
            if self.po_id != 0 {
                gl.delete_program(self.po_id);
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }
            if self.view_to_id != 0 {
                gl.delete_textures(1, &self.view_to_id);
            }
            if self.view_view_to_id != 0 {
                gl.delete_textures(1, &self.view_view_to_id);
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
            bo_id: 0,
            parent_to_id: 0,
            po_id: 0,
            po_expected_texel_uniform_location: -1,
            po_lod_uniform_location: -1,
            vao_id: 0,
            view_to_id: 0,
            view_view_to_id: 0,
            vs_id: 0,
        }
    }

    /// `initProgram`
    fn init_program(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        // SAFETY: plain object creation with a current context.
        self.po_id = unsafe { gl.create_program() };
        crate::glu::expect_no_error(gl, "glCreateProgram() call failed")?;

        // SAFETY: plain object creation with a current context.
        self.vs_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
        crate::glu::expect_no_error(gl, "glCreateShader() call failed")?;

        shader_source(gl, self.vs_id, VS_BODY, "glShaderSource() call failed")?;

        let varying_name = CString::new("has_passed").expect("no NUL");
        let varying_name_ptr = varying_name.as_ptr();
        gl_call!(
            gl,
            "glTransformFeedbackVaryings() call failed",
            gl.transform_feedback_varyings(self.po_id, 1, &varying_name_ptr, glw::GL_INTERLEAVED_ATTRIBS)
        );

        gl_call!(
            gl,
            "glAttachShader() call failed",
            gl.attach_shader(self.po_id, self.vs_id)
        );

        compile_shader(gl, self.vs_id)?;

        link_program(gl, self.po_id, "glLinkProgram() call failed")?;

        self.po_expected_texel_uniform_location = uniform_location(gl, self.po_id, "expected_texel");
        self.po_lod_uniform_location = uniform_location(gl, self.po_id, "lod");

        if self.po_expected_texel_uniform_location == -1 {
            return Err(TestError::Fail(
                "expected_texel is considered an inactive uniform which is invalid".to_string(),
            ));
        }

        if self.po_lod_uniform_location == -1 {
            return Err(TestError::Fail(
                "lod is considered an inactive uniform which is invalid".to_string(),
            ));
        }

        Ok(())
    }

    /// `initTextures`
    fn init_textures(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glGenTextures() call(s) failed", {
            gl.gen_textures(1, &mut self.parent_to_id);
            gl.gen_textures(1, &mut self.view_to_id);
            gl.gen_textures(1, &mut self.view_view_to_id);
        });

        gl_call!(
            gl,
            "glBindTexture() call failed",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.parent_to_id)
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
            "glTextureView() call failed",
            gl.texture_view(
                self.view_to_id,
                glw::GL_TEXTURE_2D,
                self.parent_to_id,
                glw::GL_RGBA8,
                0,
                TEXTURE_N_LEVELS,
                0,
                1
            )
        );

        gl_call!(
            gl,
            "glTextureView() call failed",
            gl.texture_view(
                self.view_view_to_id,
                glw::GL_TEXTURE_2D,
                self.view_to_id,
                glw::GL_RGBA8,
                0,
                TEXTURE_N_LEVELS,
                0,
                1
            )
        );

        let mut texel_data = vec![0u8; (TEXTURE_WIDTH * TEXTURE_HEIGHT * 4) as usize];

        for (n_mipmap, mipmap_color) in MIPMAP_COLORS.iter().enumerate() {
            let mipmap_height = TEXTURE_HEIGHT >> n_mipmap;
            let mipmap_width = TEXTURE_WIDTH >> n_mipmap;

            for n_texel in 0..(mipmap_height * mipmap_width) as usize {
                texel_data[n_texel * 4..n_texel * 4 + 4].copy_from_slice(mipmap_color);
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
                    texel_data.as_ptr().cast()
                )
            );
        }

        Ok(())
    }

    /// `initXFB`
    fn init_xfb(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        debug_assert!(self.po_id != 0);

        gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.bo_id));

        let bo_size = (std::mem::size_of::<GLint>() * MIPMAP_COLORS.len()) as isize;

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.bo_id)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.bo_id)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                bo_size,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );

        Ok(())
    }

    /// `initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        self.init_textures()?;
        self.init_program()?;
        self.init_xfb()?;

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

/// `TextureViewTestReferenceCounting`
pub(super) struct ReferenceCounting;

impl TestCase for ReferenceCounting {
    fn name(&self) -> &str {
        "reference_counting"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        check_texture_view_support(context)?;

        let mut state = State::new(gl);
        state.init_test()?;

        gl_call!(
            gl,
            "glActiveTexture() call failed.",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(state.po_id));

        // Sample the texture and both views, delete the parent; sample both views, delete the first; sample the only remaining view.
        for n_iteration in 0..3 {
            let to_ids_to_sample: [GLuint; 3] = match n_iteration {
                0 => [state.parent_to_id, state.view_to_id, state.view_view_to_id],
                1 => [state.view_to_id, state.view_view_to_id, 0],
                2 => [state.view_view_to_id, 0, 0],
                _ => return Err(TestError::Fail("Invalid iteration index".to_string())),
            };

            for to_id in to_ids_to_sample {
                if to_id == 0 {
                    continue;
                }

                gl_call!(
                    gl,
                    "glBindTexture() call failed.",
                    gl.bind_texture(glw::GL_TEXTURE_2D, to_id)
                );

                gl_call!(
                    gl,
                    "glBeginTransformFeedback() call failed.",
                    gl.begin_transform_feedback(glw::GL_POINTS)
                );

                for (n_mipmap, expected_mipmap_color) in MIPMAP_COLORS.iter().enumerate() {
                    gl_call!(
                        gl,
                        "glUniform4f() call failed.",
                        gl.uniform_4f(
                            state.po_expected_texel_uniform_location,
                            expected_mipmap_color[0] as f32 / 255.0,
                            expected_mipmap_color[1] as f32 / 255.0,
                            expected_mipmap_color[2] as f32 / 255.0,
                            expected_mipmap_color[3] as f32 / 255.0
                        )
                    );

                    gl_call!(
                        gl,
                        "glUniform1i() call failed.",
                        gl.uniform_1i(state.po_lod_uniform_location, n_mipmap as GLint)
                    );

                    gl_call!(gl, "glDrawArrays() call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
                }

                gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());

                // SAFETY: the transform feedback buffer holds one GLint per mip-map and is unmapped before leaving the block.
                let run_results_ptr =
                    unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) } as *const GLint;
                crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

                if run_results_ptr.is_null() {
                    return Err(TestError::Fail(
                        "Pointer to mapped buffer object storage is NULL.".to_string(),
                    ));
                }

                // SAFETY: the mapping is MIPMAP_COLORS.len() GLints long, see init_xfb.
                let run_results = unsafe { std::slice::from_raw_parts(run_results_ptr, MIPMAP_COLORS.len()) }.to_vec();

                for (n_mipmap, result) in run_results.iter().enumerate() {
                    if *result != 1 {
                        // SAFETY: the buffer is mapped; it is unmapped before failing.
                        unsafe { gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER) };

                        log::info!(
                            "Invalid data was sampled for mip-map level [{n_mipmap}] and iteration [{n_iteration}]"
                        );

                        return Err(TestError::Fail("Mip-map sampling failed.".to_string()));
                    }
                }

                gl_call!(
                    gl,
                    "glUnmapBuffer() call failed.",
                    gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
                );
            }

            match n_iteration {
                0 => {
                    gl_call!(
                        gl,
                        "glDeleteTextures() call failed.",
                        gl.delete_textures(1, &state.parent_to_id)
                    );
                    state.parent_to_id = 0;
                }
                1 => {
                    gl_call!(
                        gl,
                        "glDeleteTextures() call failed.",
                        gl.delete_textures(1, &state.view_to_id)
                    );
                    state.view_to_id = 0;
                }
                2 => {
                    gl_call!(
                        gl,
                        "glDeleteTextures() call failed.",
                        gl.delete_textures(1, &state.view_view_to_id)
                    );
                    state.view_view_to_id = 0;
                }
                _ => return Err(TestError::Fail("Invalid iteration index".to_string())),
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayFBOIncompleteness.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayFBOIncompleteness.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. As upstream, `result` is overwritten (not and-ed) by each later check.

use super::TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const SMALL_TEXTURE_DEPTH: GLint = 6;
const TEXTURE_LEVELS: GLint = 1;
const TEXTURE_HEIGHT: GLint = 1;
const TEXTURE_WIDTH: GLint = 1;

/// `TextureCubeMapArrayFBOIncompleteness` (Test 9)
pub(super) struct FboIncompleteness {
    pub(super) ext_params: ExtParameters,
}

#[derive(Default)]
struct Objects {
    fbo_id: GLuint,
    lots_of_layers_to_id: GLuint,
    non_layered_to_id: GLuint,
    small_to_id: GLuint,
}

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `checkState`
fn check_state(gl: &glw::Functions, expected_state: GLenum, message: &str) -> bool {
    // SAFETY: plain status query.
    let fbo_completeness = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
    if fbo_completeness != expected_state {
        log::info!(
            "{message}; FBO should be in {} state, but is in : {} state",
            glw::error_name(expected_state),
            glw::error_name(fbo_completeness)
        );
        return false;
    }
    true
}

impl FboIncompleteness {
    #[allow(unused_assignments)]
    fn run(&self, context: &Context, base: &TestCaseBase, o: &mut Objects) -> Result<bool, TestError> {
        let gl = context.gl();

        // `initTest`
        if !base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        gl_call!(gl, "glGenTextures() call(s) failed", {
            gl.gen_textures(1, &mut o.small_to_id);
            gl.gen_textures(1, &mut o.lots_of_layers_to_id);
            gl.gen_textures(1, &mut o.non_layered_to_id);
        });
        gl_call!(
            gl,
            "glGenFramebuffers() call failed",
            gl.gen_framebuffers(1, &mut o.fbo_id)
        );

        gl_call!(
            gl,
            "Error binding framebuffer object!",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, o.fbo_id)
        );

        // storage for the small texture
        gl_call!(
            gl,
            "Error binding texture object to GL_TEXTURE_CUBE_MAP_ARRAY target.",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, o.small_to_id)
        );
        gl_call!(
            gl,
            "glTexStorage3D() call failed.",
            gl.tex_storage_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                TEXTURE_LEVELS,
                glw::GL_RGBA8,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                SMALL_TEXTURE_DEPTH
            )
        );

        // a FBO is incomplete if a non-existing layer of a cube-map array texture is attached to a non-layered attachment
        gl_call!(
            gl,
            "glFramebufferTextureLayer() call failed.",
            gl.framebuffer_texture_layer(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                o.small_to_id,
                0,
                SMALL_TEXTURE_DEPTH
            )
        );
        let mut result = check_state(
            gl,
            glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT,
            "Attachment of an invalid texture layer ",
        );

        // the remaining parts of the test only run if the geometry shader extension is supported
        if !base.is_geometry_shader_extension_supported {
            log::info!("EXT_geometry_shader is not supported, skip remaining tests.");
            return Ok(result);
        }

        // a layered framebuffer is incomplete when the layer count of a bound cube-map array texture is at least GL_MAX_FRAMEBUFFER_LAYERS
        let mut max_framebuffer_layers: GLint = 0;
        let mut max_array_texture_layers: GLint = 0;
        gl_call!(
            gl,
            "glGetIntegerv() failed for GL_MAX_FRAMEBUFFER_LAYERS_EXT pname",
            gl.get_integerv(base.gl_ext_tokens.max_framebuffer_layers, &mut max_framebuffer_layers)
        );
        gl_call!(
            gl,
            "glGetIntegerv() failed for GL_MAX_ARRAY_TEXTURE_LAYERS pname",
            gl.get_integerv(glw::GL_MAX_ARRAY_TEXTURE_LAYERS, &mut max_array_texture_layers)
        );

        // larger than GL_MAX_FRAMEBUFFER_LAYERS and a multiple of 6
        let required_to_depth = ((max_framebuffer_layers / 6) + 1) * 6;

        if required_to_depth <= max_array_texture_layers && required_to_depth > max_framebuffer_layers {
            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, o.lots_of_layers_to_id)
            );
            gl_call!(
                gl,
                "Error configuring texture!",
                gl.tex_storage_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    TEXTURE_LEVELS,
                    glw::GL_RGBA8,
                    TEXTURE_WIDTH,
                    TEXTURE_HEIGHT,
                    required_to_depth
                )
            );
            gl_call!(
                gl,
                "glFramebufferTextureEXT() call failed",
                gl.framebuffer_texture(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    o.lots_of_layers_to_id,
                    0
                )
            );
            result = check_state(
                gl,
                glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT,
                "Attachment of too many layers to a layered framebuffer ",
            );
        }

        // a layered framebuffer is incomplete (layer targets) if a cube-map array texture and a 2D array texture are attached to two color attachments
        gl_call!(
            gl,
            "glBindTexture() call failed",
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, o.non_layered_to_id)
        );
        gl_call!(
            gl,
            "glTexStorage3D() call failed.",
            gl.tex_storage_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                TEXTURE_LEVELS,
                glw::GL_RGBA8,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                SMALL_TEXTURE_DEPTH
            )
        );

        // SAFETY: attaches textures created above to the bound draw framebuffer.
        unsafe {
            gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, o.small_to_id, 0);
            gl.framebuffer_texture(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT1,
                o.non_layered_to_id,
                0,
            );
        }
        glu::expect_no_error(gl, "glFramebufferTextureEXT() call(s) failed")?;

        result = check_state(
            gl,
            base.gl_ext_tokens.framebuffer_incomplete_layer_targets,
            "Attachment of two textures from different targets to the same FBO ",
        );
        Ok(result)
    }

    /// `deinit`
    fn deinit(gl: &glw::Functions, o: &mut Objects) {
        // SAFETY: resets bindings and deletes the names this test created, on the current context.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);

            if o.fbo_id != 0 {
                gl.delete_framebuffers(1, &o.fbo_id);
                o.fbo_id = 0;
            }
            for id in [
                &mut o.non_layered_to_id,
                &mut o.small_to_id,
                &mut o.lots_of_layers_to_id,
            ] {
                if *id != 0 {
                    gl.delete_textures(1, id);
                    *id = 0;
                }
            }
        }
    }
}

impl TestCase for FboIncompleteness {
    fn name(&self) -> &str {
        "fbo_incompleteness"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects::default();

        let outcome = self.run(context, &base, &mut objects);
        Self::deinit(context.gl(), &mut objects);

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

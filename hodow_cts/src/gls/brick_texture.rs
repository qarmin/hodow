// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   the `glu::Texture2D::create(..., "data/brick.png")` + `TextureBinding` pair that
//   es2fShaderDiscardTests.cpp / es2fShaderStructTests.cpp / es3f* use for `ut_brick`.
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The PNG is `include_bytes!`d from
// `hodow_cts/data/brick.png` (a verbatim copy of upstream's `data/gles2/data/brick.png`) and
// decoded by `tcu::png`; there is no archive to find on disk.

use std::sync::OnceLock;

use crate::glu::Context;
use crate::glw::{self, GLint, GLuint};
use crate::tcu::TestError;
use crate::tcu::pixel::{FilterMode, Sampler, WrapMode, fill_with_component_gradients2};
use crate::tcu::png::load_png;
use crate::tcu::surface::Surface;
use crate::tcu::vector::Vec4;

static BRICK_PNG: &[u8] = include_bytes!("../../data/brick.png");

/// The decoded `data/brick.png`.
pub fn brick_surface() -> Result<&'static Surface, TestError> {
    static BRICK: OnceLock<Result<Surface, String>> = OnceLock::new();
    BRICK
        .get_or_init(|| load_png(BRICK_PNG))
        .as_ref()
        .map_err(|e| TestError::InternalError(format!("data/brick.png: {e}")))
}

/// The 128x128 `GL_RGBA8` texture the Khronos copies of these tests use instead of `data/brick.png`:
/// `tcu::fillWithComponentGradients(level, Vec4(0.0f), Vec4(1.0f))`.
pub fn gradient_surface() -> &'static Surface {
    static GRADIENT: OnceLock<Surface> = OnceLock::new();
    GRADIENT.get_or_init(|| {
        let mut surface = Surface::new(128, 128);
        fill_with_component_gradients2(&mut surface.get_access(), [0.0; 4], [1.0; 4]);
        surface
    })
}

/// `tcu::Sampler(CLAMP_TO_EDGE x3, LINEAR, LINEAR)`
pub fn brick_sampler() -> Sampler {
    let mut sampler = Sampler::clamp_to_edge(FilterMode::Linear);
    sampler.normalized_coords = true;
    sampler.wrap_s = WrapMode::ClampToEdge;
    sampler.wrap_t = WrapMode::ClampToEdge;
    sampler
}

/// `ShaderEvalContext::texture2D(0, coords)` against the brick texture.
pub fn sample_brick(s: f32, t: f32) -> Vec4 {
    match brick_surface() {
        Ok(surface) => Vec4::from_array(surface.get_const_access().sample_2d(&brick_sampler(), s, t, 0)),
        Err(_) => Vec4::splat(0.0),
    }
}

/// `ShaderEvalContext::texture2D(0, coords)` against the gradient texture.
pub fn sample_gradient(s: f32, t: f32) -> Vec4 {
    Vec4::from_array(
        gradient_surface()
            .get_const_access()
            .sample_2d(&brick_sampler(), s, t, 0),
    )
}

/// A GL texture holding the brick image (or, for the Khronos copies, the gradient one), created lazily by the owning case.
pub struct BrickGlTexture {
    texture: OnceLock<GLuint>,
    gradient: bool,
}

impl Default for BrickGlTexture {
    fn default() -> Self {
        Self::new()
    }
}

impl BrickGlTexture {
    pub const fn new() -> Self {
        Self {
            texture: OnceLock::new(),
            gradient: false,
        }
    }

    /// The same, holding `gradient_surface` instead.
    pub const fn gradient() -> Self {
        Self {
            texture: OnceLock::new(),
            gradient: true,
        }
    }

    /// Uploads (once), binds to unit 0 and points `uniform_name` at it.
    pub fn bind(&self, context: &Context, program: GLuint, uniform_name: &str) -> Result<(), TestError> {
        let gl = context.gl();
        let surface = if self.gradient {
            gradient_surface()
        } else {
            brick_surface()?
        };
        let texture = *self.texture.get_or_init(|| {
            let mut texture: GLuint = 0;
            // SAFETY: one object requested into one `GLuint`; every call targets that bound object and
            // the pixel pointer covers width * height * 4 bytes.
            unsafe {
                gl.gen_textures(1, &mut texture);
                gl.bind_texture(glw::GL_TEXTURE_2D, texture);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as GLint);
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D,
                    glw::GL_TEXTURE_WRAP_S,
                    glw::GL_CLAMP_TO_EDGE as GLint,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D,
                    glw::GL_TEXTURE_WRAP_T,
                    glw::GL_CLAMP_TO_EDGE as GLint,
                );
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA as GLint,
                    surface.get_width(),
                    surface.get_height(),
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    surface.bytes().as_ptr().cast(),
                );
            }
            texture
        });

        let cname = std::ffi::CString::new(uniform_name).expect("no interior NUL");
        // SAFETY: a NUL-terminated name, a program the caller built, a texture this object owns.
        unsafe {
            let loc = gl.get_uniform_location(program, cname.as_ptr());
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture);
            if loc != -1 {
                gl.uniform_1i(loc, 0);
            }
        }
        Ok(())
    }

    /// Deletes the GL texture, if one was created.
    pub fn cleanup(&self, context: &Context) {
        if let Some(&texture) = self.texture.get() {
            // SAFETY: owned by this object, deleted at most once.
            unsafe { context.gl().delete_textures(1, &texture) };
        }
    }
}

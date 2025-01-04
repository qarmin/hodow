// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fMultisampledRenderToTextureTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `init` support check is
// `check_support` here; the objects it deletes at the end of `iterate` are deleted by
// `glu`'s wrappers on drop, which also covers the early return an error takes.

use crate::glu::{self, Context, Framebuffer, Renderbuffer, TestCase, TestCaseGroup, Texture};
use crate::glw::{self, GLint, GLubyte};
use crate::tcu::{TestError, TestOutcome, TestStatus};

struct MultisampledRenderToTextureReadPixelsCase;

impl TestCase for MultisampledRenderToTextureReadPixelsCase {
    fn name(&self) -> &str {
        "readpixels"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context
            .context_info
            .is_extension_supported("GL_EXT_multisampled_render_to_texture")
        {
            return Err(TestError::NotSupported(
                "EXT_multisampled_render_to_texture is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // Test for a bug where ReadPixels fails on multisampled textures.
        // See http://crbug.com/890002
        // Note that this does not test whether multisampling is working properly,
        // only that ReadPixels is able to read from the texture.
        let gl = context.gl();
        // Create a framebuffer with a multisampled texture and a depth-stencil
        // renderbuffer.
        let framebuffer = Framebuffer::new(gl);
        let texture = Texture::new(gl);
        let depth_stencil = Renderbuffer::new(gl);

        let mut pixel: [GLubyte; 4] = [0, 1, 0, 1];

        // SAFETY: every object below is this case's own, the 1x1 texture is left
        // uninitialised on purpose (a null pointer is what upstream passes), and the
        // read destination is four bytes for a 1x1 RGBA/UNSIGNED_BYTE read.
        let status = unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA as GLint,
                1,
                1,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            let mut max_samples: GLint = 0;
            gl.get_integerv(glw::GL_MAX_SAMPLES_EXT, &mut max_samples);
            gl.framebuffer_texture_2d_multisample_ext(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                texture.get(),
                0,
                max_samples,
            );
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_stencil.get());
            gl.renderbuffer_storage_multisample_ext(glw::GL_RENDERBUFFER, max_samples, glw::GL_DEPTH24_STENCIL8, 1, 1);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                depth_stencil.get(),
            );
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                depth_stencil.get(),
            );
            gl.check_framebuffer_status(glw::GL_FRAMEBUFFER)
        };

        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            Self::restore_bindings(context);
            return Err(TestError::NotSupported("Framebuffer format not supported.".to_string()));
        }

        // SAFETY: as above.
        unsafe {
            gl.clear_color(1.0, 0.0, 1.0, 0.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "init")?;

        // ReadPixels should implicitly resolve the multisampled buffer.
        // SAFETY: as above.
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
        glu::expect_no_error(gl, "ReadPixels")?;

        let result = if pixel != [255, 0, 255, 0] {
            TestStatus::fail(format!(
                "ReadPixels read incorrect values: [{}, {}, {}, {}]",
                pixel[0], pixel[1], pixel[2], pixel[3]
            ))
        } else {
            TestStatus::pass("Pass")
        };

        Self::restore_bindings(context);
        Ok(result)
    }
}

impl MultisampledRenderToTextureReadPixelsCase {
    /// The tail of upstream's `iterate`, minus the deletes the wrappers do on drop.
    fn restore_bindings(context: &Context) {
        let gl = context.gl();
        // SAFETY: unbinding the three targets this case bound.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        }
    }
}

/// `MultisampledRenderToTextureTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisampled_render_to_texture");
    group.add_child(Box::new(MultisampledRenderToTextureReadPixelsCase) as Box<dyn TestCase>);
    group
}

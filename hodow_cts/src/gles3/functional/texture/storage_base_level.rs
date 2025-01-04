// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureSpecificationTests.cpp (`TexStorage2DBaseLevelFboCase`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Talks to the driver directly (no sglr), as upstream does.

use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TexStorage2DBaseLevelFboCase`
struct TexStorage2DBaseLevelFboCase {
    name: String,
    width: i32,
    height: i32,
    num_levels: i32,
    new_base_level: i32,
    num_iterations: i32,
}

impl TexStorage2DBaseLevelFboCase {
    fn new(name: String, width: i32, height: i32, num_levels: i32, new_base_level: i32) -> Self {
        assert!(new_base_level > 1 && new_base_level < num_levels);
        Self {
            name,
            width,
            height,
            num_levels,
            new_base_level,
            num_iterations: 32,
        }
    }

    #[allow(clippy::manual_clamp)]
    fn run(&self, context: &Context) -> Result<TestStatus, TestError> {
        let gl = context.gl();
        let internal_format = glw::GL_RGBA8;

        let mut max_tex_size = 0i32;
        // SAFETY: a current context is guaranteed by `Context`; the pointer is to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_tex_size) };
        if self.width > max_tex_size || self.height > max_tex_size {
            return Err(TestError::NotSupported("Texture size not supported".to_string()));
        }

        let tex_format = map_gl_internal_format(internal_format)
            .ok_or_else(|| TestError::Fail("no texture format for GL_RGBA8".to_string()))?;
        let transfer = get_transfer_format(tex_format)?;
        let sub_w = (self.width >> 1).max(1).min(200);
        let sub_h = (self.height >> 1).max(1).min(200);
        let pixel_size = tex_format.pixel_size().unwrap_or(4) as i32;
        let dummy_data = vec![0x55u8; (sub_w * sub_h * pixel_size) as usize];

        for _ in 0..self.num_iterations {
            let mut tex = 0u32;
            let mut fbo = 0u32;
            // SAFETY: a current context is guaranteed by `Context`; every pointer is to a live local or buffer.
            let result = unsafe {
                gl.gen_textures(1, &mut tex);
                gl.gen_framebuffers(1, &mut fbo);
                self.iteration(
                    gl,
                    tex,
                    fbo,
                    internal_format,
                    transfer.format,
                    transfer.data_type,
                    sub_w,
                    sub_h,
                    &dummy_data,
                )
            };
            // SAFETY: as above.
            unsafe {
                gl.delete_framebuffers(1, &fbo);
                gl.delete_textures(1, &tex);
            }
            result?;
        }

        // SAFETY: as above.
        unsafe { gl.finish() };
        Ok(TestStatus::pass("Pass"))
    }

    /// One pass of upstream's iteration loop body.
    ///
    /// # Safety
    /// A current context, and `data` large enough for a `sub_w` x `sub_h` upload.
    #[allow(clippy::too_many_arguments)]
    unsafe fn iteration(
        &self,
        gl: &glw::Functions,
        tex: u32,
        fbo: u32,
        internal_format: u32,
        format: u32,
        data_type: u32,
        sub_w: i32,
        sub_h: i32,
        data: &[u8],
    ) -> Result<(), TestError> {
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, tex);
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                self.num_levels,
                internal_format,
                self.width,
                self.height,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_LINEAR_MIPMAP_LINEAR as i32,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
        }
        glu::expect_no_error(gl, "glTexStorage2D failed")?;

        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                tex,
                self.new_base_level,
            );
        }
        glu::expect_no_error(gl, "glFramebufferTexture2D failed")?;
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(
                "gl.checkFramebufferStatus(GL_FRAMEBUFFER) == GL_FRAMEBUFFER_COMPLETE".to_string(),
            ));
        }

        // 1. Initial clear of FBO attachment (mip level new_base_level) while GL_TEXTURE_BASE_LEVEL is 0.
        unsafe {
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 0);
            gl.clear_color(0.25, 0.5, 0.75, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "glClear at BASE_LEVEL 0 failed")?;

        // 2. Increase GL_TEXTURE_BASE_LEVEL to new_base_level and clear FBO attachment again.
        unsafe {
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, self.new_base_level);
            gl.clear_color(1.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "glClear at increased BASE_LEVEL failed")?;

        // 3. Sub-image update on mip level 1, i.e. a level lower than the new BASE_LEVEL.
        unsafe {
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                1,
                0,
                0,
                sub_w,
                sub_h,
                format,
                data_type,
                data.as_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glTexSubImage2D failed")?;

        // 4. Cleanup.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        glu::expect_no_error(gl, "Cleanup failed")
    }
}

impl TestCase for TexStorage2DBaseLevelFboCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        self.run(context)
    }
}

/// The `base_level` group of `texstorage2d`.
pub fn create_base_level_tests() -> TestCaseGroup {
    // (width, height, levels, newBaseLevel)
    const CASES: [(i32, i32, i32, i32); 6] = [
        (2047, 3, 5, 3),
        (2047, 1, 5, 3),
        (1537, 3, 5, 3),
        (1023, 1023, 10, 5),
        (511, 511, 6, 3),
        (257, 257, 6, 3),
    ];

    let mut group = TestCaseGroup::new("base_level");
    for &(width, height, levels, new_base_level) in &CASES {
        let name = format!("rgba8_{width}x{height}_level_{new_base_level}");
        let case: Box<dyn TestCase> = Box::new(TexStorage2DBaseLevelFboCase::new(
            name,
            width,
            height,
            levels,
            new_base_level,
        ));
        group.add_child(case);
    }
    group
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cCopyImageTests.cpp
//   external/openglcts/modules/gl/gl4cCopyImageTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The twelve non-functional cases of `copy_image`: upstream runs one list entry per `iterate` call (CONTINUE until the list ends); here one `iterate` loops over the list and stops at the first failure, which is the same verdict. A case that errors out inside a list entry cleans that entry up and ends the case, as upstream's `catch` and rethrow do.

use super::tables::{INTERNAL_FORMATS, INVALID_TARGETS, VALID_TARGETS, get_format, get_type};
use super::utils::{
    compare_pixel_memory, delete_texture, generate_texture, get_pixel_string, is_target_multilevel,
    is_target_multisampled, make_texture_complete, pack_pixel, prepare_multisample_tex, prepare_render_buffer,
    prepare_tex_16x16x6, prepare_texture, unpack_and_compare_pixels,
};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

fn verdict(passed: bool) -> TestOutcome {
    Ok(if passed {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// One `gl.copyImageSubData` call
#[derive(Clone, Copy, Default)]
struct CopyCall {
    src_name: GLuint,
    src_target: GLenum,
    src_level: GLint,
    src_x: GLint,
    src_y: GLint,
    src_z: GLint,
    dst_name: GLuint,
    dst_target: GLenum,
    dst_level: GLint,
    dst_x: GLint,
    dst_y: GLint,
    dst_z: GLint,
    width: GLint,
    height: GLint,
    depth: GLint,
}

impl CopyCall {
    /// Copies a region of one pixel at the origin, the way most negative cases do
    fn unit(src_name: GLuint, src_target: GLenum, dst_name: GLuint, dst_target: GLenum) -> Self {
        Self {
            src_name,
            src_target,
            dst_name,
            dst_target,
            width: 1,
            height: 1,
            depth: 1,
            ..Default::default()
        }
    }

    fn execute(&self, context: &Context) {
        // SAFETY: a copy between names the caller created (or deliberately deleted), on the current context.
        unsafe {
            context.gl().copy_image_sub_data(
                self.src_name,
                self.src_target,
                self.src_level,
                self.src_x,
                self.src_y,
                self.src_z,
                self.dst_name,
                self.dst_target,
                self.dst_level,
                self.dst_x,
                self.dst_y,
                self.dst_z,
                self.width,
                self.height,
                self.depth,
            );
        }
    }
}

/// `glGetError`
fn get_error(context: &Context) -> GLenum {
    // SAFETY: plain error query.
    unsafe { context.gl().get_error() }
}

/// The two texture names (and buffers behind texture buffers) most cases create
#[derive(Default)]
struct Pair {
    dst_buf_name: GLuint,
    dst_tex_name: GLuint,
    src_buf_name: GLuint,
    src_tex_name: GLuint,
}

impl Pair {
    /// `clean` of the cases that delete through `Utils::deleteTexture` or `glDeleteTextures`; errors are ignored
    fn clean(&mut self, context: &Context, dst_target: GLenum, src_target: GLenum) {
        let gl = context.gl();
        delete_texture(context, dst_target, self.dst_tex_name);
        delete_texture(context, src_target, self.src_tex_name);
        self.dst_tex_name = 0;
        self.src_tex_name = 0;

        // SAFETY: deletes names this case created, on the current context.
        unsafe {
            if self.dst_buf_name != 0 {
                gl.delete_buffers(1, &self.dst_buf_name);
                self.dst_buf_name = 0;
            }
            if self.src_buf_name != 0 {
                gl.delete_buffers(1, &self.src_buf_name);
                self.src_buf_name = 0;
            }
        }
    }
}

/// The part of a case every error-code test shares: create resources with `prepare`, run the copy, compare the error, clean up. `prepare` is upstream's `try` block.
fn expect_error_case(
    context: &Context,
    pair: &mut Pair,
    dst_target: GLenum,
    src_target: GLenum,
    prepare: impl FnOnce(&mut Pair) -> Result<CopyCall, TestError>,
    expected: GLenum,
    describe: impl FnOnce(GLenum) -> String,
) -> Result<bool, TestError> {
    let call = match prepare(pair) {
        Ok(call) => call,
        Err(error) => {
            pair.clean(context, dst_target, src_target);
            return Err(error);
        }
    };

    call.execute(context);

    let error = get_error(context);
    let result = expected == error;

    pair.clean(context, dst_target, src_target);

    if !result {
        log::info!(
            "Failure. Expected result: {} got: {}. {}",
            glw::error_name(expected),
            glw::error_name(error),
            describe(error)
        );
    }
    Ok(result)
}

/// Both textures of one target, complete, as most cases need them
fn prepare_rgba8_pair(
    context: &Context,
    pair: &mut Pair,
    dst_target: GLenum,
    src_target: GLenum,
) -> Result<(), TestError> {
    pair.dst_tex_name = prepare_tex_16x16x6(
        context,
        dst_target,
        glw::GL_RGBA8,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        &mut pair.dst_buf_name,
    )?;
    pair.src_tex_name = prepare_tex_16x16x6(
        context,
        src_target,
        glw::GL_RGBA8,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        &mut pair.src_buf_name,
    )?;
    Ok(())
}

// ---------------------------------------------------------------------------------------------------------------------
// SmokeTest

const SMOKE_WIDTH: GLuint = 16;
const SMOKE_HEIGHT: GLuint = 16;
const SMOKE_DEPTH: GLuint = 1;

#[derive(Clone, Copy)]
struct SmokeCase {
    target: GLenum,
    internal_format: GLenum,
    format: GLenum,
    type_: GLenum,
}

/// `CopyImage::SmokeTest`
pub(super) struct SmokeTest {
    test_cases: Vec<SmokeCase>,
}

impl SmokeTest {
    pub(super) fn new() -> Self {
        let mut test_cases = Vec::new();

        for target in VALID_TARGETS {
            if is_target_multisampled(target) {
                continue;
            }
            test_cases.push(SmokeCase {
                target,
                internal_format: glw::GL_RGBA32UI,
                format: glw::GL_RGBA_INTEGER,
                type_: glw::GL_UNSIGNED_INT,
            });
        }

        for internal_format in INTERNAL_FORMATS {
            test_cases.push(SmokeCase {
                target: glw::GL_TEXTURE_2D,
                internal_format,
                format: get_format(internal_format),
                type_: get_type(internal_format),
            });
        }

        Self { test_cases }
    }
}

fn smoke_layers(test_case: &SmokeCase) -> GLuint {
    if test_case.target != glw::GL_TEXTURE_CUBE_MAP_ARRAY {
        SMOKE_DEPTH
    } else {
        6
    }
}

fn smoke_image_height(test_case: &SmokeCase) -> GLuint {
    if test_case.target == glw::GL_TEXTURE_1D || test_case.target == glw::GL_TEXTURE_1D_ARRAY {
        1
    } else {
        SMOKE_HEIGHT
    }
}

fn smoke_prepare_dst_pxls(test_case: &SmokeCase) -> Vec<u8> {
    let n_pixels = (SMOKE_WIDTH * SMOKE_HEIGHT * smoke_layers(test_case)) as usize;
    let pixel_size = super::tables::get_pixel_size_for_format(test_case.internal_format) as usize;
    let mut out_pixels = vec![0u8; pixel_size * n_pixels];

    for j in 0..n_pixels {
        pack_pixel(
            test_case.internal_format,
            test_case.type_,
            1.0,
            1.0,
            1.0,
            1.0,
            &mut out_pixels[j * pixel_size..(j + 1) * pixel_size],
        );
    }
    out_pixels
}

fn smoke_prepare_src_pxls(test_case: &SmokeCase) -> Vec<u8> {
    let n_layers = smoke_layers(test_case);
    let pixel_size = super::tables::get_pixel_size_for_format(test_case.internal_format) as usize;
    let line_size = pixel_size * SMOKE_WIDTH as usize;
    let layer_size = line_size * SMOKE_HEIGHT as usize;
    let mut out_pixels = vec![0u8; layer_size * n_layers as usize];

    for layer in 0..n_layers {
        for y in 0..SMOKE_HEIGHT {
            for x in 0..SMOKE_WIDTH {
                let offset = layer as usize * layer_size + y as usize * line_size + x as usize * pixel_size;
                // 255 is max ubyte. 1/15.9375 = 16/255
                let red = x as f64 / 255.0 + y as f64 / 15.9375;
                let green = layer as f64 / 255.0 + 1.0 / 15.9375;
                let blue = 0.125;
                let alpha = 1.0; // This value has special meaning for some internal_formats
                pack_pixel(
                    test_case.internal_format,
                    test_case.type_,
                    red,
                    green,
                    blue,
                    alpha,
                    &mut out_pixels[offset..offset + pixel_size],
                );
            }
        }
    }
    out_pixels
}

impl SmokeTest {
    /// `SmokeTest::prepareTexture`
    fn prepare_smoke_texture(
        context: &Context,
        test_case: &SmokeCase,
        pixels: Option<&[u8]>,
        out_buf_id: &mut GLuint,
    ) -> Result<GLuint, TestError> {
        let n_layers = smoke_layers(test_case);
        let name = generate_texture(context, test_case.target)?;
        prepare_texture(
            context,
            name,
            test_case.target,
            test_case.internal_format,
            test_case.format,
            test_case.type_,
            0,
            SMOKE_WIDTH,
            SMOKE_HEIGHT,
            n_layers,
            pixels,
            out_buf_id,
        )?;
        make_texture_complete(context, test_case.target, name, 0, 0)?;
        Ok(name)
    }

    /// `SmokeTest::getPixels`
    fn get_pixels(
        context: &Context,
        name: GLuint,
        test_case: &SmokeCase,
        out_pixels: &mut [u8],
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let mut tgt_bind = test_case.target;
        let mut tgt_get = test_case.target;

        if test_case.target == glw::GL_RENDERBUFFER {
            tgt_bind = glw::GL_TEXTURE_2D;
            tgt_get = glw::GL_TEXTURE_2D;
        } else if test_case.target == glw::GL_TEXTURE_CUBE_MAP {
            tgt_get = glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X;
        }

        // SAFETY: texture state calls on the current context; the buffer holds a whole image.
        unsafe { gl.bind_texture(tgt_bind, name) };
        glu::expect_no_error(gl, "BindTexture")?;
        // SAFETY: as above.
        unsafe {
            gl.get_tex_image(
                tgt_get,
                0,
                test_case.format,
                test_case.type_,
                out_pixels.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "GetTexImage")?;
        // SAFETY: as above.
        unsafe { gl.bind_texture(tgt_bind, 0) };
        glu::expect_no_error(gl, "BindTexture")
    }

    /// `SmokeTest::compareImages`
    fn compare_images(test_case: &SmokeCase, left_data: &[u8], right_data: &[u8]) -> bool {
        let pixel_size = super::tables::get_pixel_size_for_format(test_case.internal_format);
        let line_size = pixel_size * SMOKE_WIDTH;
        let height = smoke_image_height(test_case);

        for y in 0..height {
            for x in 0..SMOKE_WIDTH {
                let offset = (y * line_size + x * pixel_size) as usize;
                let left_pixel_data = &left_data[offset..];
                let right_pixel_data = &right_data[offset..];

                if !compare_pixel_memory(pixel_size, left_pixel_data, pixel_size, right_pixel_data)
                    && !unpack_and_compare_pixels(
                        test_case.format,
                        test_case.type_,
                        test_case.internal_format,
                        left_pixel_data,
                        test_case.format,
                        test_case.type_,
                        test_case.internal_format,
                        right_pixel_data,
                    )
                {
                    log::info!(
                        "Not matching pixels found. [{x}, {y}], off: {offset}. Data left: {}, right: {}",
                        get_pixel_string(test_case.internal_format, left_pixel_data),
                        get_pixel_string(test_case.internal_format, right_pixel_data)
                    );
                    return false;
                }
            }
        }
        true
    }

    /// `SmokeTest::verify`
    fn verify(context: &Context, pair: &Pair, test_case: &SmokeCase, src_pixels: &[u8]) -> Result<bool, TestError> {
        let pixel_size = super::tables::get_pixel_size_for_format(test_case.internal_format) as usize;
        let req_memory = pixel_size * SMOKE_WIDTH as usize * SMOKE_HEIGHT as usize * smoke_layers(test_case) as usize;
        let mut dst_data = vec![0u8; req_memory];
        let mut src_data = vec![0u8; req_memory];

        Self::get_pixels(context, pair.src_tex_name, test_case, &mut src_data)?;
        if !Self::compare_images(test_case, src_pixels, &src_data) {
            log::info!("CopyImageSubData modified contents of source image. Original data: left.");
            return Ok(false);
        }

        Self::get_pixels(context, pair.dst_tex_name, test_case, &mut dst_data)?;
        if !Self::compare_images(test_case, src_pixels, &dst_data) {
            log::info!("CopyImageSubData stored invalid contents in destination image. Source data: left.");
            return Ok(false);
        }
        Ok(true)
    }

    /// `SmokeTest::copyAndVerify`
    fn copy_and_verify(
        context: &Context,
        pair: &Pair,
        rb_name: GLuint,
        test_case: &SmokeCase,
        src_pixels: &[u8],
    ) -> Result<bool, TestError> {
        if rb_name == 0 {
            let height = smoke_image_height(test_case);
            CopyCall {
                src_name: pair.src_tex_name,
                src_target: test_case.target,
                dst_name: pair.dst_tex_name,
                dst_target: test_case.target,
                width: SMOKE_WIDTH as GLint,
                height: height as GLint,
                depth: SMOKE_DEPTH as GLint,
                ..Default::default()
            }
            .execute(context);
        } else {
            // Copy from src to rb and from rb to dst
            CopyCall {
                src_name: pair.src_tex_name,
                src_target: glw::GL_TEXTURE_2D,
                dst_name: rb_name,
                dst_target: test_case.target,
                width: SMOKE_WIDTH as GLint,
                height: SMOKE_HEIGHT as GLint,
                depth: SMOKE_DEPTH as GLint,
                ..Default::default()
            }
            .execute(context);
            CopyCall {
                src_name: rb_name,
                src_target: test_case.target,
                dst_name: pair.dst_tex_name,
                dst_target: glw::GL_TEXTURE_2D,
                width: SMOKE_WIDTH as GLint,
                height: SMOKE_HEIGHT as GLint,
                depth: SMOKE_DEPTH as GLint,
                ..Default::default()
            }
            .execute(context);
        }

        let error = get_error(context);
        let mut result = false;
        if error == glw::GL_NO_ERROR {
            result = Self::verify(context, pair, test_case, src_pixels)?;
        }

        if error != glw::GL_NO_ERROR || !result {
            log::info!(
                "Failure. Target: {:#x}. Format: {:#x}",
                test_case.target,
                test_case.internal_format
            );
            if error != glw::GL_NO_ERROR {
                log::info!("Failed due to error: {}", glw::error_name(error));
                return Err(TestError::Fail("Copy operation failed".to_string()));
            }
            return Ok(false);
        }
        Ok(true)
    }

    fn run_test_case(context: &Context, test_case: &SmokeCase) -> Result<bool, TestError> {
        let mut pair = Pair::default();
        let mut rb_name: GLuint = 0;
        let result = Self::run_with_resources(context, &mut pair, &mut rb_name, test_case);

        let gl = context.gl();
        // SAFETY: deletes names this test case created, on the current context; errors are ignored as upstream does.
        unsafe {
            gl.delete_textures(1, &pair.dst_tex_name);
            gl.delete_textures(1, &pair.src_tex_name);
            if pair.dst_buf_name != 0 {
                gl.delete_buffers(1, &pair.dst_buf_name);
            }
            if rb_name != 0 {
                gl.delete_renderbuffers(1, &rb_name);
            }
            if pair.src_buf_name != 0 {
                gl.delete_buffers(1, &pair.src_buf_name);
            }
        }
        result
    }

    fn run_with_resources(
        context: &Context,
        pair: &mut Pair,
        rb_name: &mut GLuint,
        test_case: &SmokeCase,
    ) -> Result<bool, TestError> {
        let dst_pixels = smoke_prepare_dst_pxls(test_case);
        let src_pixels = smoke_prepare_src_pxls(test_case);

        if test_case.target == glw::GL_RENDERBUFFER {
            let mut desc = *test_case;
            let mut ignored: GLuint = 0;
            desc.target = glw::GL_TEXTURE_2D;
            *rb_name = Self::prepare_smoke_texture(context, test_case, None, &mut ignored)?;
            pair.dst_tex_name = Self::prepare_smoke_texture(context, &desc, Some(&dst_pixels), &mut pair.dst_buf_name)?;
            pair.src_tex_name = Self::prepare_smoke_texture(context, &desc, Some(&src_pixels), &mut pair.src_buf_name)?;
        } else {
            pair.dst_tex_name =
                Self::prepare_smoke_texture(context, test_case, Some(&dst_pixels), &mut pair.dst_buf_name)?;
            pair.src_tex_name =
                Self::prepare_smoke_texture(context, test_case, Some(&src_pixels), &mut pair.src_buf_name)?;
        }

        Self::copy_and_verify(context, pair, *rb_name, test_case, &src_pixels)
    }
}

impl TestCase for SmokeTest {
    fn name(&self) -> &str {
        "smoke_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        for test_case in &self.test_cases {
            // SAFETY: pixel store state on the current context.
            unsafe {
                gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
                gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
            }
            glu::expect_no_error(gl, "PixelStorei")?;

            if !Self::run_test_case(context, test_case)? {
                log::info!("Failure. ");
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// InvalidTargetTest

/// `CopyImage::InvalidTargetTest`
pub(super) struct InvalidTargetTest {
    test_cases: Vec<(GLenum, GLenum, GLenum)>,
}

impl InvalidTargetTest {
    pub(super) fn new() -> Self {
        let mut test_cases = Vec::new();

        // Valid source, valid dst
        for src_target in VALID_TARGETS {
            for dst_target in VALID_TARGETS {
                let mut expected = glw::GL_NO_ERROR;
                if is_target_multisampled(dst_target) != is_target_multisampled(src_target) {
                    expected = glw::GL_INVALID_OPERATION;
                }
                test_cases.push((src_target, dst_target, expected));
            }
        }
        // Invalid source, invalid dst
        for src_target in INVALID_TARGETS {
            for dst_target in INVALID_TARGETS {
                test_cases.push((src_target, dst_target, glw::GL_INVALID_ENUM));
            }
        }
        // Invalid source, valid dst
        for src_target in INVALID_TARGETS {
            for dst_target in VALID_TARGETS {
                test_cases.push((src_target, dst_target, glw::GL_INVALID_ENUM));
            }
        }
        // Valid source, invalid dst
        for src_target in VALID_TARGETS {
            for dst_target in INVALID_TARGETS {
                test_cases.push((src_target, dst_target, glw::GL_INVALID_ENUM));
            }
        }

        Self { test_cases }
    }
}

impl TestCase for InvalidTargetTest {
    fn name(&self) -> &str {
        "invalid_target"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for &(src_target, dst_target, expected) in &self.test_cases {
            let mut pair = Pair::default();
            let passed = expect_error_case(
                context,
                &mut pair,
                dst_target,
                src_target,
                |pair| {
                    pair.dst_tex_name = prepare_tex_16x16x6(
                        context,
                        dst_target,
                        glw::GL_RGBA8,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        &mut pair.dst_buf_name,
                    )?;
                    pair.src_tex_name = prepare_tex_16x16x6(
                        context,
                        src_target,
                        glw::GL_RGBA8,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        &mut pair.src_buf_name,
                    )?;

                    make_texture_complete(context, dst_target, pair.dst_tex_name, 0, 0)?;
                    make_texture_complete(context, src_target, pair.src_tex_name, 0, 0)?;
                    Ok(CopyCall::unit(
                        pair.src_tex_name,
                        src_target,
                        pair.dst_tex_name,
                        dst_target,
                    ))
                },
                expected,
                |_| format!("Source target: {src_target:#x}, destination target: {dst_target:#x}"),
            )?;
            if !passed {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// TargetMismatchTest

/// `CopyImage::TargetMismatchTest`
pub(super) struct TargetMismatchTest {
    /// texture target, source target, destination target, expected error
    test_cases: Vec<(GLenum, GLenum, GLenum, GLenum)>,
}

impl TargetMismatchTest {
    pub(super) fn new() -> Self {
        let mut test_cases = Vec::new();

        // Wrong dst target
        for target in VALID_TARGETS {
            for dst_target in VALID_TARGETS {
                let src_target = target;
                let tex_target = target;
                let mut expected = glw::GL_INVALID_ENUM;

                // Skip renderbuffers
                if tex_target == glw::GL_RENDERBUFFER
                    || dst_target == glw::GL_RENDERBUFFER
                    || src_target == glw::GL_RENDERBUFFER
                {
                    continue;
                }
                // Valid case
                if dst_target == tex_target {
                    expected = glw::GL_NO_ERROR;
                }
                // Skip cases with multisampling conflict
                if is_target_multisampled(dst_target) != is_target_multisampled(src_target) {
                    continue;
                }
                test_cases.push((tex_target, src_target, dst_target, expected));
            }
        }

        // Wrong src target
        for target in VALID_TARGETS {
            for src_target in VALID_TARGETS {
                let dst_target = target;
                let tex_target = target;
                let mut expected = glw::GL_INVALID_ENUM;

                if tex_target == glw::GL_RENDERBUFFER
                    || dst_target == glw::GL_RENDERBUFFER
                    || src_target == glw::GL_RENDERBUFFER
                {
                    continue;
                }
                if src_target == tex_target {
                    expected = glw::GL_NO_ERROR;
                }
                if is_target_multisampled(dst_target) != is_target_multisampled(src_target) {
                    continue;
                }
                test_cases.push((tex_target, src_target, dst_target, expected));
            }
        }

        Self { test_cases }
    }
}

impl TestCase for TargetMismatchTest {
    fn name(&self) -> &str {
        "target_miss_match"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for &(tex_target, src_target, dst_target, expected) in &self.test_cases {
            let mut pair = Pair::default();
            let passed = expect_error_case(
                context,
                &mut pair,
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D,
                |pair| {
                    prepare_rgba8_pair(context, pair, tex_target, tex_target)?;

                    make_texture_complete(context, tex_target, pair.dst_tex_name, 0, 0)?;
                    make_texture_complete(context, tex_target, pair.src_tex_name, 0, 0)?;
                    Ok(CopyCall::unit(
                        pair.src_tex_name,
                        src_target,
                        pair.dst_tex_name,
                        dst_target,
                    ))
                },
                expected,
                |_| {
                    format!(
                        "Texture target: {tex_target:#x}. Source target: {src_target:#x}, destination target: {dst_target:#x}"
                    )
                },
            )?;
            if !passed {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// IncompleteTexTest

/// `CopyImage::IncompleteTexTest`
pub(super) struct IncompleteTexTest {
    /// texture target, is dst complete, is src complete, expected error
    test_cases: Vec<(GLenum, bool, bool, GLenum)>,
}

impl IncompleteTexTest {
    pub(super) fn new() -> Self {
        let mut test_cases = Vec::new();

        for tex_target in VALID_TARGETS {
            // Skip targets that are not multi level
            if !is_target_multilevel(tex_target) {
                continue;
            }

            test_cases.push((tex_target, false, false, glw::GL_INVALID_OPERATION));
            test_cases.push((tex_target, true, false, glw::GL_INVALID_OPERATION));
            test_cases.push((tex_target, false, true, glw::GL_INVALID_OPERATION));
            test_cases.push((tex_target, true, true, glw::GL_NO_ERROR));
        }
        Self { test_cases }
    }
}

impl TestCase for IncompleteTexTest {
    fn name(&self) -> &str {
        "incomplete_tex"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for &(tex_target, is_dst_complete, is_src_complete, expected) in &self.test_cases {
            let mut pair = Pair::default();
            let passed = expect_error_case(
                context,
                &mut pair,
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D,
                |pair| {
                    prepare_rgba8_pair(context, pair, tex_target, tex_target)?;

                    if is_dst_complete {
                        make_texture_complete(context, tex_target, pair.dst_tex_name, 0, 0)?;
                    }
                    if is_src_complete {
                        make_texture_complete(context, tex_target, pair.src_tex_name, 0, 0)?;
                    }
                    Ok(CopyCall::unit(
                        pair.src_tex_name,
                        tex_target,
                        pair.dst_tex_name,
                        tex_target,
                    ))
                },
                expected,
                |_| {
                    format!(
                        "Texture target: {tex_target:#x}. Is source complete: {}, is destination complete: {}",
                        is_src_complete as u8, is_dst_complete as u8
                    )
                },
            )?;
            if !passed {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// IncompatibleFormatsTest

#[derive(Clone, Copy)]
struct FormatPair {
    tex_target: GLenum,
    dst_internal_format: GLenum,
    dst_format: GLenum,
    dst_type: GLenum,
    src_internal_format: GLenum,
    src_format: GLenum,
    src_type: GLenum,
    expected: GLenum,
}

/// `CopyImage::IncompatibleFormatsTest`
pub(super) struct IncompatibleFormatsTest {
    test_cases: Vec<FormatPair>,
}

impl IncompatibleFormatsTest {
    pub(super) fn new() -> Self {
        let mut test_cases = Vec::new();

        let groups = [
            // RGBA8UI vs RGBA16UI
            (
                glw::GL_RGBA8UI,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_BYTE,
                glw::GL_RGBA16UI,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_SHORT,
                glw::GL_INVALID_OPERATION,
            ),
            // RGBA8UI vs RGBA32UI
            (
                glw::GL_RGBA8UI,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_BYTE,
                glw::GL_RGBA32UI,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                glw::GL_INVALID_OPERATION,
            ),
            // RGBA16UI vs RG16UI
            (
                glw::GL_RGBA16UI,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_SHORT,
                glw::GL_RG16UI,
                glw::GL_RG_INTEGER,
                glw::GL_UNSIGNED_SHORT,
                glw::GL_INVALID_OPERATION,
            ),
            // RGBA32UI vs RGBA32F
            (
                glw::GL_RGBA32UI,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                glw::GL_RGBA32F,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                glw::GL_NO_ERROR,
            ),
            // RGBA8 vs RGBA32F
            (
                glw::GL_RGBA8,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                glw::GL_RGBA32F,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                glw::GL_INVALID_OPERATION,
            ),
        ];

        for (dst_internal_format, dst_format, dst_type, src_internal_format, src_format, src_type, expected) in groups {
            for tex_target in VALID_TARGETS {
                // Skip multisampled and rectangle targets
                if is_target_multisampled(tex_target) {
                    continue;
                }
                test_cases.push(FormatPair {
                    tex_target,
                    dst_internal_format,
                    dst_format,
                    dst_type,
                    src_internal_format,
                    src_format,
                    src_type,
                    expected,
                });
            }
        }
        Self { test_cases }
    }
}

impl TestCase for IncompatibleFormatsTest {
    fn name(&self) -> &str {
        "incompatible_formats"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for test_case in &self.test_cases {
            let target = test_case.tex_target;
            let mut pair = Pair::default();
            let passed = expect_error_case(
                context,
                &mut pair,
                target,
                target,
                |pair| {
                    pair.dst_tex_name = prepare_tex_16x16x6(
                        context,
                        target,
                        test_case.dst_internal_format,
                        test_case.dst_format,
                        test_case.dst_type,
                        &mut pair.dst_buf_name,
                    )?;
                    pair.src_tex_name = prepare_tex_16x16x6(
                        context,
                        target,
                        test_case.src_internal_format,
                        test_case.src_format,
                        test_case.src_type,
                        &mut pair.src_buf_name,
                    )?;

                    make_texture_complete(context, target, pair.dst_tex_name, 0, 0)?;
                    make_texture_complete(context, target, pair.src_tex_name, 0, 0)?;
                    Ok(CopyCall::unit(pair.src_tex_name, target, pair.dst_tex_name, target))
                },
                test_case.expected,
                |_| {
                    format!(
                        "Texture target: {target:#x}. Source format: {:#x}. Destination format: {:#x}",
                        test_case.src_internal_format, test_case.dst_internal_format
                    )
                },
            )?;
            if !passed {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// SamplesMismatchTest

/// `CopyImage::SamplesMismatchTest`
pub(super) struct SamplesMismatchTest {
    /// source target, source samples, destination target, destination samples, expected error
    test_cases: Vec<(GLenum, GLint, GLenum, GLint, GLenum)>,
}

impl SamplesMismatchTest {
    pub(super) fn new() -> Self {
        const N_SAMPLES: [GLint; 2] = [1, 4];
        const TARGETS: [GLenum; 2] = [glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY];
        let mut test_cases = Vec::new();

        for src_n_samples in N_SAMPLES {
            for dst_n_samples in N_SAMPLES {
                for src_target in TARGETS {
                    for dst_target in TARGETS {
                        let expected = if src_n_samples == dst_n_samples {
                            glw::GL_NO_ERROR
                        } else {
                            glw::GL_INVALID_OPERATION
                        };
                        test_cases.push((src_target, src_n_samples, dst_target, dst_n_samples, expected));
                    }
                }
            }
        }
        Self { test_cases }
    }
}

impl SamplesMismatchTest {
    fn run_test_case(context: &Context, test_case: &(GLenum, GLint, GLenum, GLint, GLenum)) -> Result<bool, TestError> {
        let &(src_target, src_n_samples, dst_target, dst_n_samples, expected) = test_case;
        let gl = context.gl();
        let mut pair = Pair::default();

        let prepared = (|| -> Result<(), TestError> {
            pair.dst_tex_name = prepare_multisample_tex(context, dst_target, dst_n_samples)?;
            pair.src_tex_name = prepare_multisample_tex(context, src_target, src_n_samples)?;
            Ok(())
        })();
        if let Err(error) = prepared {
            Self::clean(context, &mut pair);
            return Err(error);
        }

        let mut expected_result = expected;
        if dst_n_samples > 0 && src_n_samples > 0 {
            // Implementations are allowed to use more samples than requested, so the expectation follows what was allocated.
            let mut num_src_samples: GLint = 0;
            let mut num_dst_samples: GLint = 0;

            // SAFETY: texture state queries on the current context.
            unsafe {
                gl.bind_texture(dst_target, pair.dst_tex_name);
                gl.get_tex_level_parameteriv(dst_target, 0, glw::GL_TEXTURE_SAMPLES, &mut num_dst_samples);
                gl.bind_texture(src_target, pair.src_tex_name);
                gl.get_tex_level_parameteriv(src_target, 0, glw::GL_TEXTURE_SAMPLES, &mut num_src_samples);
            }

            if num_dst_samples != dst_n_samples || num_src_samples != src_n_samples {
                // The hardware allocated a different number of samples, check if this affects the expected result.
                if dst_n_samples != src_n_samples && num_dst_samples == num_src_samples {
                    expected_result = glw::GL_NO_ERROR;
                } else if dst_n_samples == src_n_samples && num_dst_samples != num_src_samples {
                    expected_result = glw::GL_INVALID_OPERATION;
                }
            }
        }

        CopyCall::unit(pair.src_tex_name, src_target, pair.dst_tex_name, dst_target).execute(context);

        let error = get_error(context);
        let result = expected_result == error;

        Self::clean(context, &mut pair);

        if !result {
            log::info!(
                "Failure. Expected result: {} got: {}. Source target: {src_target:#x} samples: {src_n_samples}, destination target: {dst_target:#x} samples: {dst_n_samples}",
                glw::error_name(expected_result),
                glw::error_name(error)
            );
        }
        Ok(result)
    }

    fn clean(context: &Context, pair: &mut Pair) {
        // SAFETY: deletes names this case created, on the current context.
        unsafe {
            context.gl().delete_textures(1, &pair.dst_tex_name);
            context.gl().delete_textures(1, &pair.src_tex_name);
        }
        pair.dst_tex_name = 0;
        pair.src_tex_name = 0;
    }
}

impl TestCase for SamplesMismatchTest {
    fn name(&self) -> &str {
        "samples_mismatch"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for test_case in &self.test_cases {
            if !Self::run_test_case(context, test_case)? {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// IncompatibleFormatsCompressionTest

/// `CopyImage::IncompatibleFormatsCompressionTest`
pub(super) struct IncompatibleFormatsCompressionTest {
    test_cases: Vec<FormatPair>,
}

impl IncompatibleFormatsCompressionTest {
    pub(super) fn new() -> Self {
        let mut test_cases = Vec::new();

        for tex_target in VALID_TARGETS {
            // Skip 1D targets, not supported
            if matches!(
                tex_target,
                glw::GL_TEXTURE_1D
                    | glw::GL_TEXTURE_1D_ARRAY
                    | glw::GL_TEXTURE_3D
                    | glw::GL_TEXTURE_RECTANGLE
                    | glw::GL_RENDERBUFFER
                    | glw::GL_TEXTURE_CUBE_MAP_ARRAY
            ) {
                continue;
            }
            // Skip multisampled and rectangle targets
            if is_target_multisampled(tex_target) {
                continue;
            }

            // Compressed 128bit vs RGBA32UI
            test_cases.push(FormatPair {
                tex_target,
                dst_internal_format: glw::GL_RGBA32UI,
                dst_format: glw::GL_RGBA_INTEGER,
                dst_type: glw::GL_UNSIGNED_INT,
                src_internal_format: glw::GL_COMPRESSED_RG_RGTC2,
                src_format: glw::GL_RG,
                src_type: glw::GL_UNSIGNED_BYTE,
                expected: glw::GL_NO_ERROR,
            });
            // Compressed 128bit vs RGBA16UI
            test_cases.push(FormatPair {
                tex_target,
                dst_internal_format: glw::GL_RGBA16UI,
                dst_format: glw::GL_RGBA_INTEGER,
                dst_type: glw::GL_UNSIGNED_SHORT,
                src_internal_format: glw::GL_COMPRESSED_RG_RGTC2,
                src_format: glw::GL_RG,
                src_type: glw::GL_UNSIGNED_BYTE,
                expected: glw::GL_INVALID_OPERATION,
            });
        }
        Self { test_cases }
    }
}

impl TestCase for IncompatibleFormatsCompressionTest {
    fn name(&self) -> &str {
        "incompatible_formats_compression"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for test_case in &self.test_cases {
            let target = test_case.tex_target;
            let mut pair = Pair::default();
            let mut temp: GLuint = 0;
            let passed = expect_error_case(
                context,
                &mut pair,
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D,
                |pair| {
                    pair.dst_tex_name = prepare_tex_16x16x6(
                        context,
                        target,
                        test_case.dst_internal_format,
                        test_case.dst_format,
                        test_case.dst_type,
                        &mut temp,
                    )?;
                    pair.src_tex_name = prepare_tex_16x16x6(
                        context,
                        target,
                        test_case.src_internal_format,
                        test_case.src_format,
                        test_case.src_type,
                        &mut temp,
                    )?;

                    make_texture_complete(context, target, pair.dst_tex_name, 0, 0)?;
                    make_texture_complete(context, target, pair.src_tex_name, 0, 0)?;
                    Ok(CopyCall {
                        src_name: pair.src_tex_name,
                        src_target: target,
                        dst_name: pair.dst_tex_name,
                        dst_target: target,
                        width: 4,
                        height: 4,
                        depth: 1,
                        ..Default::default()
                    })
                },
                test_case.expected,
                |_| {
                    format!(
                        "Texture target: {target:#x}. Source format: {:#x}. Destination format: {:#x}",
                        test_case.src_internal_format, test_case.dst_internal_format
                    )
                },
            )?;
            if !passed {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// InvalidObjectTest

#[derive(Clone, Copy)]
struct InvalidObjectCase {
    dst_target: GLenum,
    dst_valid: bool,
    src_target: GLenum,
    src_valid: bool,
    expected: GLenum,
}

/// `CopyImage::InvalidObjectTest`
pub(super) struct InvalidObjectTest {
    test_cases: Vec<InvalidObjectCase>,
}

impl InvalidObjectTest {
    pub(super) fn new() -> Self {
        const ARG_TYPES: [GLenum; 2] = [glw::GL_TEXTURE_2D, glw::GL_RENDERBUFFER];
        let mut test_cases = Vec::new();

        for dst_target in ARG_TYPES {
            for src_target in ARG_TYPES {
                for dst_valid in [false, true] {
                    for src_valid in [false, true] {
                        let expected = if src_valid && dst_valid {
                            glw::GL_NO_ERROR
                        } else {
                            glw::GL_INVALID_VALUE
                        };
                        test_cases.push(InvalidObjectCase {
                            dst_target,
                            dst_valid,
                            src_target,
                            src_valid,
                            expected,
                        });
                    }
                }
            }
        }
        Self { test_cases }
    }

    fn prepare_object(context: &Context, target: GLenum) -> Result<GLuint, TestError> {
        let mut temp: GLuint = 0;
        if target == glw::GL_RENDERBUFFER {
            prepare_render_buffer(context, glw::GL_RGBA8)
        } else {
            let name = prepare_tex_16x16x6(
                context,
                target,
                glw::GL_RGBA8,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                &mut temp,
            )?;
            make_texture_complete(context, target, name, 0, 0)?;
            Ok(name)
        }
    }

    fn run_test_case(context: &Context, test_case: &InvalidObjectCase) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut dst_name: GLuint = 0;
        let mut src_name: GLuint = 0;

        let prepared = (|| -> Result<(), TestError> {
            dst_name = Self::prepare_object(context, test_case.dst_target)?;
            src_name = Self::prepare_object(context, test_case.src_target)?;

            // If an object is invalid, free it before use to make it invalid
            if !test_case.dst_valid {
                delete_texture(context, test_case.dst_target, dst_name);
            }
            if !test_case.src_valid {
                delete_texture(context, test_case.src_target, src_name);
            }
            Ok(())
        })();

        let clean = |dst_name: GLuint, src_name: GLuint| {
            // SAFETY: deletes names this case created, on the current context; errors are ignored as upstream does.
            unsafe {
                if test_case.dst_valid {
                    if test_case.dst_target == glw::GL_RENDERBUFFER {
                        gl.delete_renderbuffers(1, &dst_name);
                    } else {
                        gl.delete_textures(1, &dst_name);
                    }
                }
                if test_case.src_valid {
                    if test_case.src_target == glw::GL_RENDERBUFFER {
                        gl.delete_renderbuffers(1, &src_name);
                    } else {
                        gl.delete_textures(1, &src_name);
                    }
                }
            }
        };

        if let Err(error) = prepared {
            clean(dst_name, src_name);
            return Err(error);
        }

        CopyCall::unit(src_name, test_case.src_target, dst_name, test_case.dst_target).execute(context);

        let error = get_error(context);
        let result = test_case.expected == error;

        clean(dst_name, src_name);

        if !result {
            log::info!(
                "Failure. Expected result: {} got: {}. Destination target: {:#x}. Destination valid: {}. Source target: {:#x}. Source valid: {}.",
                glw::error_name(test_case.expected),
                glw::error_name(error),
                test_case.dst_target,
                test_case.src_valid,
                test_case.dst_target,
                test_case.dst_valid
            );
        }
        Ok(result)
    }
}

impl TestCase for InvalidObjectTest {
    fn name(&self) -> &str {
        "invalid_object"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for test_case in &self.test_cases {
            if !Self::run_test_case(context, test_case)? {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// NonExistentMipMapTest

/// `CopyImage::NonExistentMipMapTest`
pub(super) struct NonExistentMipMapTest {
    /// texture target, destination level, source level, expected error
    test_cases: Vec<(GLenum, GLint, GLint, GLenum)>,
}

impl NonExistentMipMapTest {
    pub(super) fn new() -> Self {
        let mut test_cases = Vec::new();

        for tex_target in VALID_TARGETS {
            if tex_target == glw::GL_RENDERBUFFER {
                continue;
            }

            test_cases.push((tex_target, 0, 0, glw::GL_NO_ERROR));
            // Rest of cases is invalid
            test_cases.push((tex_target, 1, 0, glw::GL_INVALID_VALUE));
            test_cases.push((tex_target, 0, 1, glw::GL_INVALID_VALUE));
            test_cases.push((tex_target, 1, 1, glw::GL_INVALID_VALUE));
        }
        Self { test_cases }
    }
}

impl TestCase for NonExistentMipMapTest {
    fn name(&self) -> &str {
        "non_existent_mipmap"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for &(tex_target, dst_level, src_level, expected) in &self.test_cases {
            let mut pair = Pair::default();
            let mut temp: GLuint = 0;
            let passed = expect_error_case(
                context,
                &mut pair,
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D,
                |pair| {
                    pair.dst_tex_name = prepare_tex_16x16x6(
                        context,
                        tex_target,
                        glw::GL_RGBA8,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        &mut temp,
                    )?;
                    pair.src_tex_name = prepare_tex_16x16x6(
                        context,
                        tex_target,
                        glw::GL_RGBA8,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        &mut temp,
                    )?;

                    make_texture_complete(context, tex_target, pair.dst_tex_name, 0, 0)?;
                    make_texture_complete(context, tex_target, pair.src_tex_name, 0, 0)?;
                    Ok(CopyCall {
                        src_level,
                        dst_level,
                        ..CopyCall::unit(pair.src_tex_name, tex_target, pair.dst_tex_name, tex_target)
                    })
                },
                expected,
                |_| {
                    format!(
                        "Texture target: {tex_target:#x}, source level: {src_level}, destination level: {dst_level}"
                    )
                },
            )?;
            if !passed {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// ExceedingBoundariesTest

const REGION_DEPTH: GLuint = 4;
const REGION_HEIGHT: GLuint = 4;
const REGION_WIDTH: GLuint = 4;

#[derive(Clone, Copy)]
struct BoundaryCase {
    tex_target: GLenum,
    depth: GLuint,
    height: GLuint,
    src_x: GLuint,
    src_y: GLuint,
    src_z: GLuint,
    dst_x: GLuint,
    dst_y: GLuint,
    dst_z: GLuint,
    expected: GLenum,
}

/// `CopyImage::ExceedingBoundariesTest`
pub(super) struct ExceedingBoundariesTest {
    test_cases: Vec<BoundaryCase>,
}

impl ExceedingBoundariesTest {
    pub(super) fn new() -> Self {
        // 16x16x6 are values used by prepareTex16x16x6
        let invalid_x = 16 - REGION_WIDTH / 2;
        let invalid_y = 16 - REGION_HEIGHT / 2;
        let invalid_z = 6 - REGION_DEPTH / 2;
        let x_vals = [0, invalid_x];
        let y_vals = [0, invalid_y];
        let z_vals = [0, invalid_z];
        let mut test_cases = Vec::new();

        for tex_target in VALID_TARGETS {
            let mut height = REGION_HEIGHT;

            if tex_target == glw::GL_TEXTURE_BUFFER {
                continue;
            }
            if tex_target == glw::GL_TEXTURE_1D || tex_target == glw::GL_TEXTURE_1D_ARRAY {
                height = 1;
            }

            for x_val in x_vals {
                for y_val in y_vals {
                    for z_val in z_vals {
                        let expected = if x_val == 0 && y_val == 0 && z_val == 0 {
                            glw::GL_NO_ERROR
                        } else {
                            glw::GL_INVALID_VALUE
                        };
                        let mut depth = 1;

                        if z_val != 0 {
                            if !matches!(
                                tex_target,
                                glw::GL_TEXTURE_2D_ARRAY
                                    | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
                                    | glw::GL_TEXTURE_3D
                                    | glw::GL_TEXTURE_CUBE_MAP_ARRAY
                            ) {
                                // Skip z != 0 for 2d textures
                                continue;
                            }
                            // Set depth so as to exceed boundary
                            depth = REGION_DEPTH;
                        }

                        test_cases.push(BoundaryCase {
                            tex_target,
                            depth,
                            height,
                            src_x: x_val,
                            src_y: y_val,
                            src_z: z_val,
                            dst_x: 0,
                            dst_y: 0,
                            dst_z: 0,
                            expected,
                        });
                        test_cases.push(BoundaryCase {
                            tex_target,
                            depth,
                            height,
                            src_x: 0,
                            src_y: 0,
                            src_z: 0,
                            dst_x: x_val,
                            dst_y: y_val,
                            dst_z: z_val,
                            expected,
                        });
                    }
                }
            }
        }
        Self { test_cases }
    }
}

impl TestCase for ExceedingBoundariesTest {
    fn name(&self) -> &str {
        "exceeding_boundaries"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for test_case in &self.test_cases {
            let target = test_case.tex_target;
            let mut pair = Pair::default();
            let mut temp: GLuint = 0;
            let passed = expect_error_case(
                context,
                &mut pair,
                target,
                target,
                |pair| {
                    pair.dst_tex_name = prepare_tex_16x16x6(
                        context,
                        target,
                        glw::GL_RGBA8,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        &mut temp,
                    )?;
                    pair.src_tex_name = prepare_tex_16x16x6(
                        context,
                        target,
                        glw::GL_RGBA8,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        &mut temp,
                    )?;

                    make_texture_complete(context, target, pair.dst_tex_name, 0, 0)?;
                    make_texture_complete(context, target, pair.src_tex_name, 0, 0)?;
                    Ok(CopyCall {
                        src_name: pair.src_tex_name,
                        src_target: target,
                        src_x: test_case.src_x as GLint,
                        src_y: test_case.src_y as GLint,
                        src_z: test_case.src_z as GLint,
                        dst_name: pair.dst_tex_name,
                        dst_target: target,
                        dst_x: test_case.dst_x as GLint,
                        dst_y: test_case.dst_y as GLint,
                        dst_z: test_case.dst_z as GLint,
                        width: REGION_WIDTH as GLint,
                        height: test_case.height as GLint,
                        depth: test_case.depth as GLint,
                        ..Default::default()
                    })
                },
                test_case.expected,
                |_| {
                    format!(
                        "Texture target: {target:#x}, source: [{}, {}, {}], destination: [{}, {}, {}], depth: {}",
                        test_case.src_x,
                        test_case.src_y,
                        test_case.src_z,
                        test_case.src_x,
                        test_case.src_y,
                        test_case.src_z,
                        test_case.depth
                    )
                },
            )?;
            if !passed {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// InvalidAlignmentTest

/// `CopyImage::InvalidAlignmentTest`
pub(super) struct InvalidAlignmentTest {
    /// height, width, source x, source y, destination x, destination y, expected error
    test_cases: Vec<(GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLenum)>,
}

impl InvalidAlignmentTest {
    pub(super) fn new() -> Self {
        // 16x16x6 are values used by prepareTex16x16x6
        const INVALID_H: GLuint = 2;
        const INVALID_W: GLuint = 2;
        const INVALID_X: GLuint = 2;
        const INVALID_Y: GLuint = 2;
        const VALID_H: GLuint = 4;
        const VALID_W: GLuint = 4;
        let mut test_cases = Vec::new();

        for x_val in [0, INVALID_X] {
            for y_val in [0, INVALID_Y] {
                for h_val in [VALID_H, INVALID_H] {
                    for w_val in [VALID_W, INVALID_W] {
                        let expected = if h_val == VALID_H && w_val == VALID_W && x_val == 0 && y_val == 0 {
                            glw::GL_NO_ERROR
                        } else {
                            glw::GL_INVALID_VALUE
                        };
                        test_cases.push((h_val, w_val, 0, 0, x_val, y_val, expected));
                        test_cases.push((h_val, w_val, x_val, y_val, 0, 0, expected));
                    }
                }
            }
        }
        Self { test_cases }
    }
}

impl TestCase for InvalidAlignmentTest {
    fn name(&self) -> &str {
        "invalid_alignment"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for &(height, width, src_x, src_y, dst_x, dst_y, expected) in &self.test_cases {
            let mut pair = Pair::default();
            let mut temp: GLuint = 0;
            let passed = expect_error_case(
                context,
                &mut pair,
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D,
                |pair| {
                    pair.dst_tex_name = prepare_tex_16x16x6(
                        context,
                        glw::GL_TEXTURE_2D,
                        glw::GL_COMPRESSED_RG_RGTC2,
                        glw::GL_RG,
                        glw::GL_UNSIGNED_BYTE,
                        &mut temp,
                    )?;
                    pair.src_tex_name = prepare_tex_16x16x6(
                        context,
                        glw::GL_TEXTURE_2D,
                        glw::GL_COMPRESSED_RG_RGTC2,
                        glw::GL_RG,
                        glw::GL_UNSIGNED_BYTE,
                        &mut temp,
                    )?;

                    make_texture_complete(context, glw::GL_TEXTURE_2D, pair.dst_tex_name, 0, 0)?;
                    make_texture_complete(context, glw::GL_TEXTURE_2D, pair.src_tex_name, 0, 0)?;
                    Ok(CopyCall {
                        src_name: pair.src_tex_name,
                        src_target: glw::GL_TEXTURE_2D,
                        src_x: src_x as GLint,
                        src_y: src_y as GLint,
                        dst_name: pair.dst_tex_name,
                        dst_target: glw::GL_TEXTURE_2D,
                        dst_x: dst_x as GLint,
                        dst_y: dst_y as GLint,
                        width: width as GLint,
                        height: height as GLint,
                        depth: 1,
                        ..Default::default()
                    })
                },
                expected,
                |_| format!("source: [{src_x}, {src_y}], destination: [{src_x}, {src_y}], size: {width} x {height}"),
            )?;
            if !passed {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// IntegerTexTest

/// `CopyImage::IntegerTexTest`
pub(super) struct IntegerTexTest;

impl IntegerTexTest {
    /// `IntegerTexTest::createTexture`
    fn create_texture(
        context: &Context,
        width: GLint,
        height: GLint,
        internal_format: GLenum,
        type_: GLenum,
        data: &[i32],
        min_filter: GLenum,
        mag_filter: GLenum,
    ) -> Result<GLuint, TestError> {
        let gl = context.gl();
        let mut tex_name: GLuint = 0;

        // SAFETY: texture state calls on the current context; the data holds width * height texels.
        unsafe { gl.gen_textures(1, &mut tex_name) };
        glu::expect_no_error(gl, "GenTextures")?;
        // SAFETY: as above.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, tex_name) };
        glu::expect_no_error(gl, "BindTexture")?;
        // SAFETY: as above.
        unsafe {
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                internal_format as GLint,
                width,
                height,
                0,
                glw::GL_RED_INTEGER,
                type_,
                data.as_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "TexImage2D")?;
        // SAFETY: as above.
        unsafe { gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 0) };
        glu::expect_no_error(gl, "TexParameteri")?;
        // SAFETY: as above.
        unsafe { gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 0) };
        glu::expect_no_error(gl, "TexParameteri")?;
        // SAFETY: as above.
        unsafe { gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, min_filter as GLint) };
        glu::expect_no_error(gl, "TexParameteri")?;
        // SAFETY: as above.
        unsafe { gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, mag_filter as GLint) };
        glu::expect_no_error(gl, "TexParameteri")?;
        // SAFETY: as above.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, 0) };
        glu::expect_no_error(gl, "BindTexture")?;
        Ok(tex_name)
    }

    fn run_test_case(
        context: &Context,
        internal_format: GLenum,
        type_: GLenum,
        pair: &mut Pair,
    ) -> Result<bool, TestError> {
        const WIDTH: GLint = 16;
        const HEIGHT: GLint = 16;
        let gl = context.gl();
        let mut data_buf = vec![1i32; (WIDTH * HEIGHT) as usize];

        pair.dst_tex_name = Self::create_texture(
            context,
            WIDTH,
            HEIGHT,
            internal_format,
            type_,
            &data_buf,
            glw::GL_NEAREST_MIPMAP_LINEAR,
            glw::GL_LINEAR,
        )?;
        data_buf.fill(2);
        pair.src_tex_name = Self::create_texture(
            context,
            WIDTH,
            HEIGHT,
            internal_format,
            type_,
            &data_buf,
            glw::GL_NEAREST_MIPMAP_LINEAR,
            glw::GL_LINEAR,
        )?;

        CopyCall::unit(
            pair.src_tex_name,
            glw::GL_TEXTURE_2D,
            pair.dst_tex_name,
            glw::GL_TEXTURE_2D,
        )
        .execute(context);

        let error = get_error(context);
        if error != glw::GL_NO_ERROR {
            log::info!(
                "Failure. Expected no error, got: {}. Texture internal format: {internal_format:#x}",
                glw::error_name(error)
            );
            return Ok(false);
        }

        data_buf.fill(3);
        // SAFETY: texture state calls on the current context; the buffer holds the whole level.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, pair.dst_tex_name) };
        glu::expect_no_error(gl, "BindTexture")?;
        // SAFETY: as above.
        unsafe {
            gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
                data_buf.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "GetTexImage")?;

        if data_buf[0] == 2 && data_buf.iter().filter(|&&v| v == 1).count() == (WIDTH * HEIGHT - 1) as usize {
            Ok(true)
        } else {
            log::info!("Failure. Image data is not valid.");
            Ok(false)
        }
    }
}

impl TestCase for IntegerTexTest {
    fn name(&self) -> &str {
        "integer_tex"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for (internal_format, type_) in [(glw::GL_R32I, glw::GL_INT), (glw::GL_R32UI, glw::GL_UNSIGNED_INT)] {
            let mut pair = Pair::default();
            let result = Self::run_test_case(context, internal_format, type_, &mut pair);

            // SAFETY: deletes names this case created, on the current context.
            unsafe {
                context.gl().delete_textures(1, &pair.dst_tex_name);
                context.gl().delete_textures(1, &pair.src_tex_name);
            }

            if !result? {
                return verdict(false);
            }
        }
        verdict(true)
    }
}

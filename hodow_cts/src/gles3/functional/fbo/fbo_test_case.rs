// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboTestCase.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `FboTestCase` renders one scene through `sglr::Context` twice - against the real driver and
// against `sglr::ReferenceContext` - and compares the frames. C++ subclasses override `render`,
// `preCheck` and `compare`; here they implement `FboRender` and are wrapped by `FboTestCase`.
//
// Narrowing: the reference context is always single sample, see `gls::reference_context_buffers`. The typed `readPixels` overload is `fbo_test_util::read_pixels`.

use super::fbo_test_util::fbo_incomplete_error;
use crate::gls::reference_context_buffers::create_reference_context_rgb8;
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::gl_context::GLContext;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus, de_string_hash};

/// The overridable half of upstream's `FboTestCase`.
pub trait FboRender: Send + Sync {
    /// `FboTestCase::preCheck`
    fn pre_check(&self, context: &Context) -> Result<(), TestError> {
        let _ = context;
        Ok(())
    }

    /// `FboTestCase::render` - `dst` is sized by the implementation (through `read_pixels`).
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError>;

    /// `FboTestCase::compare` for cases that also need the render target (`m_context.getRenderTarget()`).
    fn compare_in(&self, context: &Context, reference: &Surface, result: &Surface) -> bool {
        let _ = context;
        self.compare(reference, result)
    }

    /// `FboTestCase::compare`
    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), 0.05).unwrap_or(false)
    }
}

/// `gles3::Functional::FboTestCase`
pub struct FboTestCase {
    name: String,
    use_screen_sized_viewport: bool,
    inner: Box<dyn FboRender>,
}

impl FboTestCase {
    #[allow(clippy::new_ret_no_self)]
    pub fn new(name: impl Into<String>, inner: impl FboRender + 'static) -> Box<dyn TestCase> {
        Box::new(Self {
            name: name.into(),
            use_screen_sized_viewport: false,
            inner: Box::new(inner),
        })
    }

    pub fn new_screen_sized(name: impl Into<String>, inner: impl FboRender + 'static) -> Box<dyn TestCase> {
        Box::new(Self {
            name: name.into(),
            use_screen_sized_viewport: true,
            inner: Box::new(inner),
        })
    }
}

impl TestCase for FboTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let rt = context.render_target();

        // Viewport.
        let mut rnd = Random::new(de_string_hash(&self.name));
        let (viewport_width, viewport_height) = if self.use_screen_sized_viewport {
            (rt.width, rt.height)
        } else {
            (128, 128)
        };
        let width = rt.width.min(viewport_width);
        let height = rt.height.min(viewport_height);
        let x = rnd.get_int(0, rt.width - width);
        let y = rnd.get_int(0, rt.height - height);

        // Surface format and storage is chosen by render().
        let mut reference = Surface::new(0, 0);
        let mut result = Surface::new(0, 0);

        // Call preCheck() that can throw if some requirement is not met.
        self.inner.pre_check(context)?;

        // Render using GLES3.
        {
            let mut gl_ctx = GLContext::new(&context.render_context, (x, y, width, height));
            self.inner.render(&mut gl_ctx, &mut result)?;

            // Check error.
            let err = gl_ctx.get_error();
            if err != glw::GL_NO_ERROR {
                return Ok(TestStatus::fail(format!("Got GL error {err:#x}")));
            }
        }

        // Render reference.
        {
            let mut ref_ctx = create_reference_context_rgb8(context, width, height, rt.depth_bits)?;
            self.inner.render(&mut ref_ctx, &mut reference)?;
        }

        if self.inner.compare_in(context, &reference, &result) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

/// `FboTestCase::checkError`
pub fn check_error(ctx: &mut dyn SglrContext) -> Result<(), TestError> {
    let err = ctx.get_error();
    if err != glw::GL_NO_ERROR {
        return Err(TestError::Fail(format!("Got GL error {err:#x}")));
    }
    Ok(())
}

/// `FboTestCase::checkFramebufferStatus`
pub fn check_framebuffer_status(ctx: &mut dyn SglrContext, target: GLenum) -> Result<(), TestError> {
    let status = ctx.check_framebuffer_status(target);
    if status != glw::GL_FRAMEBUFFER_COMPLETE {
        return Err(fbo_incomplete_error(status));
    }
    Ok(())
}

/// `isRequiredFormat`
fn is_required_format(format: GLenum, context: &Context) -> bool {
    match format {
        // Color-renderable formats
        glw::GL_RGBA32I
        | glw::GL_RGBA32UI
        | glw::GL_RGBA16I
        | glw::GL_RGBA16UI
        | glw::GL_RGBA8
        | glw::GL_RGBA8I
        | glw::GL_RGBA8UI
        | glw::GL_SRGB8_ALPHA8
        | glw::GL_RGB10_A2
        | glw::GL_RGB10_A2UI
        | glw::GL_RGBA4
        | glw::GL_RGB5_A1
        | glw::GL_RGB8
        | glw::GL_RGB565
        | glw::GL_RG32I
        | glw::GL_RG32UI
        | glw::GL_RG16I
        | glw::GL_RG16UI
        | glw::GL_RG8
        | glw::GL_RG8I
        | glw::GL_RG8UI
        | glw::GL_R32I
        | glw::GL_R32UI
        | glw::GL_R16I
        | glw::GL_R16UI
        | glw::GL_R8
        | glw::GL_R8I
        | glw::GL_R8UI => true,

        // Depth, depth+stencil and stencil formats
        glw::GL_DEPTH_COMPONENT32F
        | glw::GL_DEPTH_COMPONENT24
        | glw::GL_DEPTH_COMPONENT16
        | glw::GL_DEPTH32F_STENCIL8
        | glw::GL_DEPTH24_STENCIL8
        | glw::GL_STENCIL_INDEX8 => true,

        // Float formats
        glw::GL_RGBA32F | glw::GL_RGB32F | glw::GL_R11F_G11F_B10F | glw::GL_RG32F | glw::GL_R32F => {
            context.is_gles_compatible(3, 2)
        }

        _ => false,
    }
}

/// `getEnablingExtensions`
fn get_enabling_extensions(format: GLenum, context: &Context) -> Vec<&'static str> {
    let is_es32 = context.is_gles_compatible(3, 2);
    let mut out = Vec::new();

    match format {
        glw::GL_RGB16F => out.push("GL_EXT_color_buffer_half_float"),
        glw::GL_RGBA16F | glw::GL_RG16F | glw::GL_R16F => {
            out.push("GL_EXT_color_buffer_half_float");
            if !is_es32 {
                out.push("GL_EXT_color_buffer_float");
            }
        }
        glw::GL_RGBA32F | glw::GL_RGB32F | glw::GL_R11F_G11F_B10F | glw::GL_RG32F | glw::GL_R32F if !is_es32 => {
            out.push("GL_EXT_color_buffer_float");
        }
        _ => {}
    }

    out
}

/// `FboTestCase::checkFormatSupport`
pub fn check_format_support(context: &Context, sized_format: GLenum) -> Result<(), TestError> {
    let is_core_format = is_required_format(sized_format, context);
    let required_exts = if is_core_format {
        Vec::new()
    } else {
        get_enabling_extensions(sized_format, context)
    };

    // Check that we don't try to use invalid formats.
    debug_assert!(is_core_format || !required_exts.is_empty());

    if !required_exts.is_empty()
        && !required_exts
            .iter()
            .any(|e| context.context_info.is_extension_supported(e))
    {
        return Err(TestError::NotSupported("Format not supported".to_string()));
    }
    Ok(())
}

/// `getMinimumSampleCount`
fn get_minimum_sample_count(format: GLenum) -> i32 {
    match format {
        // Core formats
        glw::GL_RGBA32I
        | glw::GL_RGBA32UI
        | glw::GL_RGBA16I
        | glw::GL_RGBA16UI
        | glw::GL_RGBA8
        | glw::GL_RGBA8I
        | glw::GL_RGBA8UI
        | glw::GL_SRGB8_ALPHA8
        | glw::GL_RGB10_A2
        | glw::GL_RGB10_A2UI
        | glw::GL_RGBA4
        | glw::GL_RGB5_A1
        | glw::GL_RGB8
        | glw::GL_RGB565
        | glw::GL_RG32I
        | glw::GL_RG32UI
        | glw::GL_RG16I
        | glw::GL_RG16UI
        | glw::GL_RG8
        | glw::GL_RG8I
        | glw::GL_RG8UI
        | glw::GL_R32I
        | glw::GL_R32UI
        | glw::GL_R16I
        | glw::GL_R16UI
        | glw::GL_R8
        | glw::GL_R8I
        | glw::GL_R8UI
        | glw::GL_DEPTH_COMPONENT32F
        | glw::GL_DEPTH_COMPONENT24
        | glw::GL_DEPTH_COMPONENT16
        | glw::GL_DEPTH32F_STENCIL8
        | glw::GL_DEPTH24_STENCIL8
        | glw::GL_STENCIL_INDEX8 => 4,

        // GL_EXT_color_buffer_float
        glw::GL_R11F_G11F_B10F | glw::GL_RG16F | glw::GL_R16F => 4,
        glw::GL_RGBA32F | glw::GL_RGBA16F | glw::GL_RG32F | glw::GL_R32F => 0,

        // GL_EXT_color_buffer_half_float
        glw::GL_RGB16F => 0,

        _ => 0,
    }
}

/// `querySampleCounts`
fn query_sample_counts(context: &Context, format: GLenum) -> Result<Vec<i32>, TestError> {
    let gl = context.gl();
    let mut num_sample_counts = 0;
    let mut sample_counts = Vec::new();

    // SAFETY: the count query writes one integer, and the list query is sized from what it answered.
    unsafe {
        gl.get_internalformativ(
            glw::GL_RENDERBUFFER,
            format,
            glw::GL_NUM_SAMPLE_COUNTS,
            1,
            &mut num_sample_counts,
        );

        if num_sample_counts > 0 {
            sample_counts.resize(num_sample_counts as usize, 0);
            gl.get_internalformativ(
                glw::GL_RENDERBUFFER,
                format,
                glw::GL_SAMPLES,
                sample_counts.len() as i32,
                sample_counts.as_mut_ptr(),
            );
        }
    }

    crate::glu::expect_no_error(gl, "Failed to query sample counts for format")?;
    Ok(sample_counts)
}

/// `FboTestCase::checkSampleCount`
pub fn check_sample_count(context: &Context, sized_format: GLenum, num_samples: i32) -> Result<(), TestError> {
    let min_sample_count = get_minimum_sample_count(sized_format);

    if num_samples > min_sample_count {
        // Exceeds spec-mandated minimum - need to check.
        let supported_sample_counts = query_sample_counts(context, sized_format)?;

        if !supported_sample_counts.contains(&num_samples) {
            return Err(TestError::NotSupported("Sample count not supported".to_string()));
        }
    }
    Ok(())
}

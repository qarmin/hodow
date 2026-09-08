// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fClipControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `ClipControlApi`'s constructor is the support check, and each case's `deinit`
// restoring `ClipControl(LOWER_LEFT, NEGATIVE_ONE_TO_ONE)` is a guard here -
// `glu::resetState` knows nothing about this extension, so leaving it set would change
// what the *next* case renders, including on the way out of a `?`. The rest of what
// upstream's `deinit` restores (cull face, depth test/func, clear colour and depth,
// viewport) is what `glu::reset_state_es` already does after every case.
//
// A `TestCase` here has no `init` phase, so `ClipControlRenderBaseTest::init`'s FBO is
// built at the top of `iterate` as a value whose `Drop` is that class's `deinit`.

use crate::glu::{self, Buffer, Context, Framebuffer, ProgramSources, Renderbuffer, ShaderProgram, TestCase, TestCaseGroup, Texture, VertexArray, pr, va};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{PixelBufferAccess, TextureLevel};
use crate::tcu::rgba::RGBA;
use crate::tcu::{ChannelOrder, ChannelType, Surface, TestError, TestOutcome, TestResult, TestStatus, TextureFormat};

/// `ClipControlApi::Supported`
fn check_supported(context: &Context) -> Result<(), TestError> {
    if !context.context_info.is_extension_supported("GL_EXT_clip_control") {
        return Err(TestError::NotSupported("Required extension EXT_clip_control is not supported".to_string()));
    }
    Ok(())
}

/// Every rendering case reaches `glGenVertexArrays`/`glBindVertexArray` on an ES 2.0
/// context, where they only exist via GL_OES_vertex_array_object (`glwInitExtES.inl`
/// loads the OES entry point into the core slot); without the extension the call is
/// not there at all.
fn check_vertex_array_object_supported(context: &Context) -> Result<(), TestError> {
    if !context.context_info.is_extension_supported("GL_OES_vertex_array_object") {
        return Err(TestError::NotSupported("Required extension GL_OES_vertex_array_object is not supported".to_string()));
    }
    Ok(())
}

/// `ClipControlBaseTest::verifyState`
fn verify_state(context: &Context, origin: GLenum, depth: GLenum) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut ret = true;

    let mut ret_i = 0;
    // SAFETY: both queries write a single integer.
    unsafe { gl.get_integerv(glw::GL_CLIP_ORIGIN, &mut ret_i) };
    glu::expect_no_error(gl, "get GL_CLIP_ORIGIN")?;

    ret &= ret_i as GLenum == origin;

    // SAFETY: as above.
    unsafe { gl.get_integerv(glw::GL_CLIP_DEPTH_MODE, &mut ret_i) };
    glu::expect_no_error(gl, "get GL_CLIP_DEPTH_MODE")?;

    ret &= ret_i as GLenum == depth;

    Ok(ret)
}

/// The state every case that changes it leaves behind, which is upstream's `deinit`.
struct ClipControlDeinit<'gl> {
    gl: &'gl glw::Functions,
}

impl Drop for ClipControlDeinit<'_> {
    fn drop(&mut self) {
        // SAFETY: the two default enums; the extension is present or the case never ran.
        unsafe { self.gl.clip_control(glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE) };
    }
}

/// `ClipControlRenderBaseTest::fsh`
fn fsh() -> &'static str {
    "void main() {\n    gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);\n}"
}

/// `ClipControlRenderBaseTest`'s `init`/`deinit` - the FBO every rendering case draws
/// into.
///
/// Upstream deletes the three objects and then unbinds the framebuffer; a deleted
/// framebuffer that is bound reverts the binding to 0 by itself, so the reverse order
/// a `Drop` gives leaves the same state behind.
struct ClipControlRenderBase<'gl> {
    gl: &'gl glw::Functions,
    _fbo: Framebuffer<'gl>,
    _rbo_c: Renderbuffer<'gl>,
    depth_texure: Texture<'gl>,
}

impl<'gl> ClipControlRenderBase<'gl> {
    /// `ClipControlRenderBaseTest::init`
    fn new(context: &'gl Context) -> Self {
        let render_target = context.render_target();
        let viewport_w = render_target.width;
        let viewport_h = render_target.height;
        let gl = context.gl();

        let fbo = Framebuffer::new(gl);
        let rbo_c = Renderbuffer::new(gl);
        let depth_texure = Texture::new(gl);

        // SAFETY: every name below is this object's own, and the depth texture is left
        // with unspecified contents on purpose - upstream passes a null pointer too.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_c.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, viewport_w, viewport_h);

            gl.bind_texture(glw::GL_TEXTURE_2D, depth_texure.get());
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_DEPTH_COMPONENT as GLint,
                viewport_w,
                viewport_h,
                0,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_UNSIGNED_SHORT,
                std::ptr::null(),
            );

            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, rbo_c.get());
            gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_DEPTH_ATTACHMENT, glw::GL_TEXTURE_2D, depth_texure.get(), 0);
        }

        Self {
            gl,
            _fbo: fbo,
            _rbo_c: rbo_c,
            depth_texure,
        }
    }

    /// `ClipControlRenderBaseTest::getDepthTexture`
    fn get_depth_texture(&self) -> GLuint {
        self.depth_texure.get()
    }
}

impl Drop for ClipControlRenderBase<'_> {
    fn drop(&mut self) {
        // SAFETY: unbinding the framebuffer this object bound.
        unsafe { self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
    }
}

/// `ClipControlRenderBaseTest::fuzzyDepthCompare`
fn fuzzy_depth_compare(reference: &TextureLevel, result: &TextureLevel, threshold: f32, importance_mask: Option<&TextureLevel>) -> bool {
    let mut depth_ok = true;
    let mut difference = 0.0;

    let reference = reference.get_const_access();
    let result = result.get_const_access();
    let [width, height, _] = result.size();

    for y in 0..height {
        if !depth_ok {
            break;
        }
        for x in 0..width {
            if !depth_ok {
                break;
            }
            let ref_ = reference.get_pix_depth(x, y, 0);
            let res = result.get_pixel(x, y, 0)[0];
            difference = (ref_ - res).abs();
            if let Some(mask) = importance_mask {
                difference *= mask.get_const_access().get_pix_depth(x, y, 0);
            }
            depth_ok &= difference < threshold;
        }
    }

    if !depth_ok {
        log::info!("Image comparison failed: difference = {difference}, threshold = {threshold}");
    }

    depth_ok
}

struct ClipControlInitialState;

impl TestCase for ClipControlInitialState {
    fn name(&self) -> &str {
        "initial"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if !verify_state(context, glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE)? {
            return Err(TestError::Fail(
                "Wrong intitial state: GL_CLIP_ORIGIN should be GL_LOWER_LEFT, GL_CLIP_ORIGIN should be NEGATIVE_ONE_TO_ONE".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct ClipControlModifyGetState;

impl TestCase for ClipControlModifyGetState {
    fn name(&self) -> &str {
        "modify_get"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let _deinit = ClipControlDeinit { gl };

        let cases: [[GLenum; 2]; 4] = [
            [glw::GL_UPPER_LEFT, glw::GL_ZERO_TO_ONE],
            [glw::GL_UPPER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE],
            [glw::GL_LOWER_LEFT, glw::GL_ZERO_TO_ONE],
            [glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE],
        ];

        for case in cases {
            // SAFETY: every combination below is one the extension defines.
            unsafe { gl.clip_control(case[0], case[1]) };
            glu::expect_no_error(gl, "ClipControl()")?;
            if !verify_state(context, case[0], case[1])? {
                return Err(TestError::Fail("Wrong ClipControl state after ClipControl() call".to_string()));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct ClipControlErrors;

impl TestCase for ClipControlErrors {
    fn name(&self) -> &str {
        "errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let _deinit = ClipControlDeinit { gl };

        // Finding improper value.
        let mut improper_value = glw::GL_NONE;
        while improper_value == glw::GL_UPPER_LEFT || improper_value == glw::GL_LOWER_LEFT || improper_value == glw::GL_ZERO_TO_ONE || improper_value == glw::GL_NEGATIVE_ONE_TO_ONE
        {
            improper_value += 1;
        }

        // Test setup.
        let cases: [[GLenum; 2]; 5] = [
            [glw::GL_UPPER_LEFT, improper_value],
            [glw::GL_LOWER_LEFT, improper_value],
            [improper_value, glw::GL_ZERO_TO_ONE],
            [improper_value, glw::GL_NEGATIVE_ONE_TO_ONE],
            [improper_value, improper_value],
        ];

        // Test iterations.
        for case in cases {
            // SAFETY: an invalid enum is exactly what is being provoked; GL answers
            // with an error rather than acting on it.
            unsafe { gl.clip_control(case[0], case[1]) };

            // SAFETY: a plain error query.
            if unsafe { gl.get_error() } != glw::GL_INVALID_ENUM {
                log::warn!(
                    "ClipControl have not generated GL_INVALID_ENUM error when called with invalid value ({}, {}).",
                    case[0],
                    case[1]
                );
            }
        }

        // Upstream sets FAIL inside the loop above and then PASS unconditionally here,
        // so a driver that accepts an invalid enum still passes this case. Reporting
        // the failure instead would disagree with `deqp-gles2` on a working driver.
        Ok(TestStatus::pass("Pass"))
    }
}

struct ClipControlOriginTest;

impl ClipControlOriginTest {
    fn vsh() -> &'static str {
        "attribute highp vec2 Position;\nvoid main() {\n    gl_Position = vec4(Position, 0.0, 1.0);\n}"
    }

    /// `ClipControlOriginTest::ValidateFramebuffer`
    fn validate_framebuffer(&self, context: &Context, origin: GLenum) -> Result<TestResult, TestError> {
        let render_target = context.render_target();
        let viewport_w = render_target.width;
        let viewport_h = render_target.height;
        let mut rendered_frame = Surface::new(viewport_w, viewport_h);
        let mut reference_frame = Surface::new(viewport_w, viewport_h);

        for y in 0..reference_frame.get_height() {
            let y_coord = y as f32 / reference_frame.get_height() as f32;

            for x in 0..reference_frame.get_width() {
                let x_coord = x as f32 / reference_frame.get_width() as f32;

                let green_quadrant = if origin == glw::GL_UPPER_LEFT {
                    y_coord > 0.5 && x_coord <= 0.5
                } else {
                    y_coord <= 0.5 && x_coord <= 0.5
                };

                if green_quadrant {
                    reference_frame.set_pixel(x, y, RGBA::green());
                } else {
                    reference_frame.set_pixel(x, y, RGBA::red());
                }
            }
        }

        glu::read_pixels(&context.render_context, 0, 0, &mut rendered_frame.get_access())?;

        let ok = fuzzy_compare_ok(&reference_frame.get_const_access(), &rendered_frame.get_const_access(), 0.05)
            .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;

        Ok(if ok { TestResult::Pass } else { TestResult::Fail })
    }
}

impl TestCase for ClipControlOriginTest {
    fn name(&self) -> &str {
        "origin"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)?;
        check_vertex_array_object_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let _render_base = ClipControlRenderBase::new(context);
        let _deinit = ClipControlDeinit { gl };

        // Render a triangle fan covering (-1.0, -1.0) to (1.0, 0.0) and
        // write a pixel value of green (0, 1, 0).
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(Self::vsh(), fsh()));
        if !program.is_ok() {
            return Err(TestError::Fail("Program compilation failed".to_string()));
        }

        let vao = VertexArray::new(gl);
        let vbo = Buffer::new(gl);

        const VERTEX_DATA0: [f32; 8] = [-1.0, -1.0, 0.0, -1.0, -1.0, 0.0, 0.0, 0.0];

        let origins: [GLenum; 2] = [glw::GL_UPPER_LEFT, glw::GL_LOWER_LEFT];
        let mut result = TestResult::Pass;

        // SAFETY: the vertex data outlives the upload, the attribute is fed from the
        // buffer bound here, and every enum is one the extension defines.
        unsafe {
            gl.bind_vertex_array(vao.get());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&VERTEX_DATA0) as isize,
                VERTEX_DATA0.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(0);

            gl.use_program(program.program());

            for origin in origins {
                // Clear the default framebuffer to red (1, 0, 0).
                gl.clear_color(1.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);

                // Set ClipControl(UPPER_LEFT, NEGATIVE_ONE_TO_ONE)
                gl.clip_control(origin, glw::GL_NEGATIVE_ONE_TO_ONE);
                glu::expect_no_error(gl, "ClipControl()")?;

                // test method modification: use GL_TRIANGLE_STRIP, not FAN.
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);

                // Read back the default framebuffer with ReadPixels
                // Verify the green pixels at the top and red at the bottom.
                let loop_result = self.validate_framebuffer(context, origin)?;
                if loop_result != TestResult::Pass {
                    result = loop_result;
                }
            }

            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            gl.bind_vertex_array(0);
        }

        Ok(TestStatus::new(result, result.as_str()))
    }
}

/// `ClipControlDepthModeTest::setupTexture`
fn setup_texture(gl: &glw::Functions) {
    // SAFETY: four ES 2.0 parameters on whatever 2D texture is currently bound.
    unsafe {
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as GLint);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as GLint);
    }
}

/// `ClipControlDepthModeTest`'s `init`/`deinit` - the base FBO plus the colour FBO
/// `readDepthPixels` resolves the depth texture into.
struct ClipControlDepthModeBase<'gl> {
    base: ClipControlRenderBase<'gl>,
    fbo_d: Framebuffer<'gl>,
    tex_depth_resolve: Texture<'gl>,
}

impl<'gl> ClipControlDepthModeBase<'gl> {
    /// `ClipControlDepthModeTest::init`
    fn new(context: &'gl Context) -> Self {
        let gl = context.gl();
        let render_target = context.render_target();
        let viewport_w = render_target.width;
        let viewport_h = render_target.height;

        let base = ClipControlRenderBase::new(context);

        let fbo_d = Framebuffer::new(gl);

        let tex_depth_resolve = Texture::new(gl);
        // SAFETY: the texture is this object's own and is left with unspecified
        // contents, which is what upstream's null pointer asks for.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, tex_depth_resolve.get()) };
        setup_texture(gl);
        // SAFETY: as above.
        unsafe {
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                viewport_w,
                viewport_h,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
        }

        Self { base, fbo_d, tex_depth_resolve }
    }

    /// `ClipControlDepthModeTest::readDepthPixels`
    ///
    /// ES 2.0 cannot read a depth buffer with `glReadPixels`, so the depth texture is
    /// sampled through a program that broadcasts R into every channel and the colour
    /// result of *that* is what comes back.
    fn read_depth_pixels(&self, context: &Context, pixel_buf: &mut PixelBufferAccess<'_>) -> Result<(), TestError> {
        let vs = "\nattribute vec4 pos;\nattribute vec2 UV;\nvarying highp vec2 vUV;\nvoid main() {\n  gl_Position = pos;\n  vUV = UV;\n}\n";
        let fs = "\nprecision mediump float;\nvarying vec2 vUV;\nuniform sampler2D tex;\nvoid main() {\n  gl_FragColor = texture2D(tex, vUV).rrrr;\n}\n";

        let render_context = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let window_w = render_target.width;
        let window_h = render_target.height;

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vs, fs));

        // SAFETY: every name is this object's own, and the uniform is the sampler the
        // fragment shader above declares.
        let tex_loc = unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo_d.get());
            gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, self.tex_depth_resolve.get(), 0);

            gl.disable(glw::GL_DEPTH_TEST);
            gl.depth_mask(glw::FALSE);
            gl.disable(glw::GL_STENCIL_TEST);
            gl.viewport(0, 0, window_w, window_h);
            gl.clear_color(0.0, 0.2, 1.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            gl.get_uniform_location(program.program(), c"tex".as_ptr())
        };

        // SAFETY: as above.
        unsafe {
            gl.bind_vertex_array(0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);

            gl.bind_texture(glw::GL_TEXTURE_2D, self.base.get_depth_texture());
        }
        setup_texture(gl);
        // SAFETY: as above.
        unsafe {
            gl.use_program(program.program());
            gl.uniform_1i(tex_loc, 0);
        }

        {
            const VERTICES: [f32; 16] = [-1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0];
            const TEX_COORDS: [f32; 8] = [0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0];
            const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

            let vertex_array = [va::float("pos", 4, 4, 0, &VERTICES), va::float("UV", 2, 4, 0, &TEX_COORDS)];

            glu::draw(render_context, program.program(), &vertex_array, &pr::triangles(&INDICES))?;
        }
        glu::read_pixels(render_context, 0, 0, pixel_buf)
    }
}

/// The two depth-mode cases' shared `vsh`.
fn depth_mode_vsh() -> &'static str {
    "attribute vec3 Position;\nvoid main() {\n    gl_Position = vec4(Position, 1.0);\n}"
}

/// The vertex data both depth-mode cases upload - a strip from (-1,-1,-1) to (1,1,1).
const DEPTH_MODE_VERTEX_DATA0: [f32; 12] = [-1.0, -1.0, -1.0, 1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0];

/// `tcu::TextureFormat(RGBA, UNORM_INT8)` - what `readDepthPixels` writes back.
fn depth_readback_format() -> TextureFormat {
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)
}

/// `tcu::TextureFormat(D, UNORM_INT16)` - the reference depth buffer's format.
fn depth_format() -> TextureFormat {
    TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16)
}

struct ClipControlDepthModeZeroToOneTest;

impl ClipControlDepthModeZeroToOneTest {
    /// `ClipControlDepthModeZeroToOneTest::ValidateFramebuffer`
    fn validate_framebuffer(&self, context: &Context, base: &ClipControlDepthModeBase<'_>) -> Result<TestResult, TestError> {
        let render_target = context.render_target();
        let viewport_w = render_target.width;
        let viewport_h = render_target.height;
        let mut rendered_color_frame = Surface::new(viewport_w, viewport_h);
        let mut reference_color_frame = Surface::new(viewport_w, viewport_h);
        let mut rendered_depth_frame = TextureLevel::new(depth_readback_format(), viewport_w as u32, viewport_h as u32, 1)?;
        let mut reference_depth_frame = TextureLevel::new(depth_format(), viewport_w as u32, viewport_h as u32, 1)?;
        let mut importance_mask_frame = TextureLevel::new(depth_format(), viewport_w as u32, viewport_h as u32, 1)?;

        let rasterization_error = 2.0 / rendered_color_frame.get_height() as f32 + 2.0 / rendered_color_frame.get_width() as f32;

        {
            let mut reference_depth_access = reference_depth_frame.get_access();
            let mut importance_mask_access = importance_mask_frame.get_access();

            for y in 0..rendered_color_frame.get_height() {
                let y_coord = (y as f32 + 0.5) / rendered_color_frame.get_height() as f32;

                for x in 0..rendered_color_frame.get_width() {
                    let x_coord = (x as f32 + 0.5) / rendered_color_frame.get_width() as f32;

                    if y_coord >= 1.0 - x_coord - rasterization_error && y_coord <= 1.0 - x_coord + rasterization_error {
                        importance_mask_access.set_pix_depth(0.0, x as u32, y as u32, 0);
                    } else {
                        importance_mask_access.set_pix_depth(1.0, x as u32, y as u32, 0);
                    }

                    if y_coord < 1.0 - x_coord {
                        reference_color_frame.set_pixel(x, y, RGBA::red());
                        reference_depth_access.set_pix_depth(0.5, x as u32, y as u32, 0);
                    } else {
                        reference_color_frame.set_pixel(x, y, RGBA::green());

                        reference_depth_access.set_pix_depth(-1.0 + x_coord + y_coord, x as u32, y as u32, 0);
                    }
                }
            }
        }

        glu::read_pixels(&context.render_context, 0, 0, &mut rendered_color_frame.get_access())?;
        let color_ok = fuzzy_compare_ok(&reference_color_frame.get_const_access(), &rendered_color_frame.get_const_access(), 0.05)
            .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;
        if !color_ok {
            return Ok(TestResult::Fail);
        }

        base.read_depth_pixels(context, &mut rendered_depth_frame.get_access())?;
        if !fuzzy_depth_compare(&reference_depth_frame, &rendered_depth_frame, 0.05, Some(&importance_mask_frame)) {
            return Ok(TestResult::Fail);
        }
        Ok(TestResult::Pass)
    }
}

impl TestCase for ClipControlDepthModeZeroToOneTest {
    fn name(&self) -> &str {
        "depth_mode_zero_to_one"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)?;
        check_vertex_array_object_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = ClipControlDepthModeBase::new(context);
        let _deinit = ClipControlDeinit { gl };

        // SAFETY: the clear values and enums are all ES 2.0 defaults or extension
        // enums, on the framebuffer `base` bound.
        unsafe {
            gl.clear_color(1.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            // Clear the depth buffer to 0.5.
            gl.clear_depthf(0.5);
            gl.clear(glw::GL_DEPTH_BUFFER_BIT);

            // Set ClipControl(LOWER_LEFT, ZERO_TO_ONE)
            gl.clip_control(glw::GL_LOWER_LEFT, glw::GL_ZERO_TO_ONE);
        }
        glu::expect_no_error(gl, "ClipControl()")?;

        // Enable(DEPTH_TEST) with DepthFunc(ALWAYS)
        // SAFETY: as above.
        unsafe {
            gl.enable(glw::GL_DEPTH_TEST);
            gl.depth_func(glw::GL_ALWAYS);
        }

        // Render a triangle fan coverage (-1.0,-1.0,-1.0) to (1.0,1.0,1.0).
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(depth_mode_vsh(), fsh()));

        if !program.is_ok() {
            return Err(TestError::Fail("Program compilation failed".to_string()));
        }

        let vao = VertexArray::new(gl);
        let vbo = Buffer::new(gl);

        // SAFETY: the vertex data outlives the upload and the attribute is fed from
        // the buffer bound here.
        unsafe {
            gl.bind_vertex_array(vao.get());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&DEPTH_MODE_VERTEX_DATA0) as isize,
                DEPTH_MODE_VERTEX_DATA0.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(0);

            gl.use_program(program.program());

            // test method modification: use GL_TRIANGLE_STRIP, not FAN.
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
        }

        // Read back the floating-point depth buffer with ReadPixels
        // Verify that the pixels with a Z clip coordinate less than 0.0 are
        //   clipped and those coordinates from 0.0 to 1.0 update the depth
        //   buffer with values 0.0 to 1.0.
        let result = self.validate_framebuffer(context, &base)?;

        Ok(TestStatus::new(result, result.as_str()))
    }
}

struct ClipControlDepthModeOneToOneTest;

impl ClipControlDepthModeOneToOneTest {
    /// `ClipControlDepthModeOneToOneTest::ValidateFramebuffer`
    fn validate_framebuffer(&self, context: &Context, base: &ClipControlDepthModeBase<'_>) -> Result<TestResult, TestError> {
        let render_target = context.render_target();
        let viewport_w = render_target.width;
        let viewport_h = render_target.height;
        let mut rendered_color_frame = Surface::new(viewport_w, viewport_h);
        let mut reference_color_frame = Surface::new(viewport_w, viewport_h);
        let mut rendered_depth_frame = TextureLevel::new(depth_readback_format(), viewport_w as u32, viewport_h as u32, 1)?;
        let mut reference_depth_frame = TextureLevel::new(depth_format(), viewport_w as u32, viewport_h as u32, 1)?;

        {
            let mut reference_depth_access = reference_depth_frame.get_access();

            for y in 0..rendered_color_frame.get_height() {
                let y_coord = y as f32 / rendered_color_frame.get_height() as f32;
                for x in 0..rendered_color_frame.get_width() {
                    let x_coord = x as f32 / rendered_color_frame.get_width() as f32;

                    reference_color_frame.set_pixel(x, y, RGBA::green());
                    reference_depth_access.set_pix_depth((x_coord + y_coord) * 0.5, x as u32, y as u32, 0);
                }
            }
        }

        glu::read_pixels(&context.render_context, 0, 0, &mut rendered_color_frame.get_access())?;
        let color_ok = fuzzy_compare_ok(&reference_color_frame.get_const_access(), &rendered_color_frame.get_const_access(), 0.05)
            .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;
        if !color_ok {
            return Ok(TestResult::Fail);
        }

        base.read_depth_pixels(context, &mut rendered_depth_frame.get_access())?;
        if !fuzzy_depth_compare(&reference_depth_frame, &rendered_depth_frame, 0.05, None) {
            return Ok(TestResult::Fail);
        }

        Ok(TestResult::Pass)
    }
}

impl TestCase for ClipControlDepthModeOneToOneTest {
    fn name(&self) -> &str {
        "depth_mode_one_to_one"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)?;
        check_vertex_array_object_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = ClipControlDepthModeBase::new(context);
        let _deinit = ClipControlDeinit { gl };

        // SAFETY: as in the zero-to-one case above.
        unsafe {
            gl.clear_color(1.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            // Clear the depth buffer to 0.5.
            gl.clear_depthf(0.5);
            gl.clear(glw::GL_DEPTH_BUFFER_BIT);

            // Set ClipControl(LOWER_LEFT, GL_NEGATIVE_ONE_TO_ONE)
            gl.clip_control(glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE);
        }
        glu::expect_no_error(gl, "ClipControl()")?;

        // Enable(DEPTH_TEST) with DepthFunc(ALWAYS)
        // SAFETY: as above.
        unsafe {
            gl.enable(glw::GL_DEPTH_TEST);
            gl.depth_func(glw::GL_ALWAYS);
        }

        // Render a triangle fan coverage (-1.0,-1.0,-1.0) to (1.0,1.0,1.0).
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(depth_mode_vsh(), fsh()));

        if !program.is_ok() {
            return Err(TestError::Fail("Program compilation failed".to_string()));
        }

        let vao = VertexArray::new(gl);
        let vbo = Buffer::new(gl);

        // SAFETY: as in the zero-to-one case above.
        unsafe {
            gl.bind_vertex_array(vao.get());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&DEPTH_MODE_VERTEX_DATA0) as isize,
                DEPTH_MODE_VERTEX_DATA0.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(0);

            gl.use_program(program.program());

            // test method modification: use GL_TRIANGLE_STRIP, not FAN.
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
        }

        // Read back the floating-point depth buffer with ReadPixels
        // Verify that the pixels with a Z clip coordinate less than 0.0 are
        //   clipped and those coordinates from 0.0 to 1.0 update the depth
        //   buffer with values 0.0 to 1.0.
        let result = self.validate_framebuffer(context, &base)?;

        Ok(TestStatus::new(result, result.as_str()))
    }
}

struct ClipControlFaceCulling;

impl ClipControlFaceCulling {
    fn vsh() -> &'static str {
        "attribute  highp vec3 Position;\nvoid main() {\n    gl_Position = vec4(Position, 1.0);\n}"
    }

    /// `ClipControlFaceCulling::ValidateFramebuffer`
    fn validate_framebuffer(&self, context: &Context) -> Result<TestResult, TestError> {
        let render_target = context.render_target();
        let viewport_w = render_target.width;
        let viewport_h = render_target.height;
        let mut rendered_color_frame = Surface::new(viewport_w, viewport_h);
        let mut reference_color_frame = Surface::new(viewport_w, viewport_h);

        for y in 0..rendered_color_frame.get_height() {
            for x in 0..rendered_color_frame.get_width() {
                let x_coord = x as f32 / rendered_color_frame.get_width() as f32;

                if x_coord < 0.5 {
                    reference_color_frame.set_pixel(x, y, RGBA::green());
                } else {
                    reference_color_frame.set_pixel(x, y, RGBA::red());
                }
            }
        }

        glu::read_pixels(&context.render_context, 0, 0, &mut rendered_color_frame.get_access())?;
        let ok = fuzzy_compare_ok(&reference_color_frame.get_const_access(), &rendered_color_frame.get_const_access(), 0.05)
            .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;
        if !ok {
            return Ok(TestResult::Fail);
        }
        Ok(TestResult::Pass)
    }
}

impl TestCase for ClipControlFaceCulling {
    fn name(&self) -> &str {
        "face_culling"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)?;
        check_vertex_array_object_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let _render_base = ClipControlRenderBase::new(context);
        let _deinit = ClipControlDeinit { gl };

        // Enable GL_CULL_FACE, leave default front face & cull face(CCW, BACK)
        // SAFETY: an ES 2.0 state setter.
        unsafe { gl.enable(glw::GL_CULL_FACE) };

        // Render a counter-clockwise triangles covering
        // (-1.0, -1.0) to(0.0, 1.0) and write a pixel value of green(0, 1, 0).
        // Render a clockwise triangles covering
        // (0.0, -1.0) to(1.0, 1.0) and write a pixel value of green(0, 1, 0).
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(Self::vsh(), fsh()));

        if !program.is_ok() {
            return Err(TestError::Fail("Program compilation failed".to_string()));
        }

        let vao = VertexArray::new(gl);
        let vbo = Buffer::new(gl);

        #[rustfmt::skip]
        const VERTEX_DATA0: [f32; 24] = [
            // CCW
            -1.0, -1.0,
             0.0, -1.0,
            -1.0,  1.0,
             0.0, -1.0,
             0.0,  1.0,
            -1.0,  1.0,
            // CW
             0.0, -1.0,
             0.0,  1.0,
             1.0, -1.0,
             1.0, -1.0,
             0.0,  1.0,
             1.0,  1.0,
        ];

        let origins: [GLenum; 2] = [glw::GL_UPPER_LEFT, glw::GL_LOWER_LEFT];
        let mut result = TestResult::Pass;

        // SAFETY: the vertex data outlives the upload; note the attribute is declared
        // `vec3` but fed two components, exactly as upstream does, so z stays 0.
        unsafe {
            gl.bind_vertex_array(vao.get());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&VERTEX_DATA0) as isize,
                VERTEX_DATA0.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(0);

            gl.use_program(program.program());

            for origin in origins {
                // Clear the framebuffer to red (1,0,0).
                gl.clear_color(1.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);

                gl.draw_arrays(glw::GL_TRIANGLES, 0, 12);

                // Set ClipControl(<origin>, NEGATIVE_ONE_TO_ONE)
                //
                // Upstream really does draw before setting the origin it is about to
                // verify, so what each iteration checks is the *previous* origin's
                // draw. Reproduced deliberately.
                gl.clip_control(origin, glw::GL_NEGATIVE_ONE_TO_ONE);
                glu::expect_no_error(gl, "ClipControl()")?;

                // Read back the framebuffer with ReadPixels
                // Verify the green pixels at the left and red at the right.
                let loop_result = self.validate_framebuffer(context)?;
                if loop_result != TestResult::Pass {
                    result = loop_result;
                }
            }
        }

        Ok(TestStatus::new(result, result.as_str()))
    }
}

struct ClipControlViewportBounds;

impl ClipControlViewportBounds {
    fn vsh() -> &'static str {
        "attribute highp vec2 Position;\nvarying highp vec2 PositionOut;\nvoid main() {\n    gl_Position = vec4(Position, 0.0, 1.0);\n    PositionOut = Position;\n}"
    }

    /// `ClipControlViewportBounds::fsh` - not the base class's one.
    fn fsh() -> &'static str {
        "varying highp vec2 PositionOut;\nvoid main() {\n    if (PositionOut.x < 0.0 && PositionOut.y < 0.0)\n       gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);\n    else\n       gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);\n}"
    }

    /// `ClipControlViewportBounds::ValidateFramebuffer`
    fn validate_framebuffer(&self, context: &Context, origin: GLenum) -> Result<TestResult, TestError> {
        let render_target = context.render_target();
        let window_w = render_target.width;
        let window_h = render_target.height;
        let mut rendered_frame = Surface::new(window_w, window_h);
        let mut reference_frame = Surface::new(window_w, window_h);

        for y in 0..rendered_frame.get_height() {
            let y_coord = y as f32 / rendered_frame.get_height() as f32;
            let y_vp_coord = (y_coord - 0.25) * 4.0;

            for x in 0..rendered_frame.get_width() {
                let x_coord = x as f32 / rendered_frame.get_width() as f32;
                let x_vp_coord = (x_coord - 0.125) * 2.0;

                if x_vp_coord > 0.0 && x_vp_coord < 1.0 && y_vp_coord > 0.0 && y_vp_coord < 1.0 {
                    // inside viewport
                    let green_quadrant = if origin == glw::GL_UPPER_LEFT {
                        y_vp_coord > 0.5 && x_vp_coord <= 0.5
                    } else {
                        y_vp_coord <= 0.5 && x_vp_coord <= 0.5
                    };

                    if green_quadrant {
                        reference_frame.set_pixel(x, y, RGBA::green());
                    } else {
                        reference_frame.set_pixel(x, y, RGBA::red());
                    }
                } else {
                    // outside viewport
                    reference_frame.set_pixel(x, y, RGBA::blue());
                }
            }
        }

        glu::read_pixels(&context.render_context, 0, 0, &mut rendered_frame.get_access())?;

        let ok = fuzzy_compare_ok(&reference_frame.get_const_access(), &rendered_frame.get_const_access(), 0.05)
            .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;

        Ok(if ok { TestResult::Pass } else { TestResult::Fail })
    }
}

impl TestCase for ClipControlViewportBounds {
    fn name(&self) -> &str {
        "viewport_bounds"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)?;
        check_vertex_array_object_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let _render_base = ClipControlRenderBase::new(context);
        let _deinit = ClipControlDeinit { gl };

        let render_target = context.render_target();
        let window_w = render_target.width;
        let window_h = render_target.height;

        // Clear the default framebuffer to blue (0,0,1).
        //
        // Upstream clears once, outside the origin loop; the full-viewport quad each
        // iteration draws overwrites everything inside the viewport, so only the blue
        // outside it has to survive.
        // SAFETY: an ES 2.0 clear on the framebuffer `_render_base` bound.
        unsafe {
            gl.clear_color(0.0, 0.0, 1.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(Self::vsh(), Self::fsh()));

        if !program.is_ok() {
            return Err(TestError::Fail("Program compilation failed".to_string()));
        }

        let vao = VertexArray::new(gl);
        let vbo = Buffer::new(gl);

        const VERTEX_DATA0: [f32; 8] = [-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0];

        let origins: [GLenum; 2] = [glw::GL_UPPER_LEFT, glw::GL_LOWER_LEFT];
        let mut result = TestResult::Pass;

        // SAFETY: the vertex data outlives the upload and the attribute is fed from the
        // buffer bound here.
        unsafe {
            gl.bind_vertex_array(vao.get());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&VERTEX_DATA0) as isize,
                VERTEX_DATA0.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(0);

            gl.use_program(program.program());

            for origin in origins {
                // Set viewport to A = (x, y, w, h) = (1/8, 1/4, 1/2, 1/4) in terms of proportional window size
                gl.viewport(
                    (0.125 * window_w as f32 + 0.5) as GLint,
                    (0.25 * window_h as f32 + 0.5) as GLint,
                    (0.5 * window_w as f32 + 0.5) as i32,
                    (0.25 * window_h as f32 + 0.5) as i32,
                );

                // Set ClipControl(<origin>, NEGATIVE_ONE_TO_ONE)
                gl.clip_control(origin, glw::GL_NEGATIVE_ONE_TO_ONE);
                glu::expect_no_error(gl, "ClipControl()")?;

                // Render a triangle strip covering (-1.0, -1.0) to (1.0, 1.0).
                // Write a pixel value of red (0,1,0) to (-1.0, -1.0)..(0.0, 0.0), other parts are green
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);

                gl.viewport(0, 0, window_w, window_h);

                // Read back the default framebuffer with ReadPixels
                // Verify the green pixels at the top and red at the bottom.
                let loop_result = self.validate_framebuffer(context, origin)?;
                if loop_result != TestResult::Pass {
                    result = loop_result;
                }
            }
        }

        Ok(TestStatus::new(result, result.as_str()))
    }
}

/// `ClipControlTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("clip_control");
    group.add_child(Box::new(ClipControlInitialState) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlModifyGetState) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlErrors) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlOriginTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlDepthModeZeroToOneTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlDepthModeOneToOneTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlFaceCulling) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlViewportBounds) as Box<dyn TestCase>);
    group
}

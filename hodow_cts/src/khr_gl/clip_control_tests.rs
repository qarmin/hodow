// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cClipControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `init`/`deinit` of upstream's test classes are one guard per case (`Restore`, whose drop is `deinit`), created at the top of `iterate` so an early `?` still restores the state; the `ClipControlApi` support check is `check_support`. The framebuffer of `ClipControlRenderBaseTest::init` is created in `iterate` for the same reason.

use crate::glu::{self, Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, VertexArray};
use crate::glw;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, RGBA, Surface, TestError, TestOutcome, TestStatus, TextureFormat};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Api {
    Gl45Core,
    ArbClipControl,
}

impl Api {
    fn test_name(self) -> &'static str {
        match self {
            Self::Gl45Core => "clip_control",
            Self::ArbClipControl => "clip_control_ARB",
        }
    }

    /// `ClipControlApi::Supported`
    fn supported(self, context: &Context) -> bool {
        (self == Self::ArbClipControl && context.context_info.is_extension_supported("GL_ARB_clip_control"))
            || self == Self::Gl45Core
    }
}

fn clip_control(gl: &glw::Functions, origin: glw::GLenum, depth: glw::GLenum) {
    // SAFETY: the entry point is checked by `check_support` (a missing one panics with its name, a port bug).
    unsafe { gl.clip_control(origin, depth) };
}

fn get_error(gl: &glw::Functions) -> glw::GLenum {
    // SAFETY: no arguments.
    unsafe { gl.get_error() }
}

fn get_integer(gl: &glw::Functions, pname: glw::GLenum) -> i32 {
    let mut value = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(pname, &mut value) };
    value
}

/// `ClipControlBaseTest::verifyState`
fn verify_state(gl: &glw::Functions, origin: glw::GLenum, depth: glw::GLenum) -> Result<bool, TestError> {
    let mut ret = true;

    let ret_i = get_integer(gl, glw::GL_CLIP_ORIGIN);
    glu::expect_no_error(gl, "get GL_CLIP_ORIGIN")?;

    ret &= ret_i as glw::GLenum == origin;

    let ret_i = get_integer(gl, glw::GL_CLIP_DEPTH_MODE);
    glu::expect_no_error(gl, "get GL_CLIP_DEPTH_MODE")?;

    ret &= ret_i as glw::GLenum == depth;

    Ok(ret)
}

fn fsh() -> &'static str {
    "#version 400\n\
out vec4 FragColor;\n\
void main() {\n\
    FragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
}"
}

fn build_program<'gl>(gl: &'gl glw::Functions, vsh: &str, fsh: &str) -> Result<ShaderProgram<'gl>, TestError> {
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vsh, fsh));
    if !program.is_ok() {
        return Err(TestError::Fail("Program compilation failed".to_string()));
    }
    Ok(program)
}

/// The `vertexAttribPointer`/`enableVertexAttribArray` setup every render case does for attribute 0.
fn upload_vertices(gl: &glw::Functions, vao: &VertexArray<'_>, vbo: &Buffer<'_>, vertex_data: &[f32], components: i32) {
    // SAFETY: the names are owned by the guards of the caller; `vertex_data` is read for its own size.
    unsafe {
        gl.bind_vertex_array(vao.get());

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(vertex_data) as isize,
            vertex_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );

        gl.vertex_attrib_pointer(0, components, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
        gl.enable_vertex_attrib_array(0);
    }
}

fn status_of(passed: bool) -> TestStatus {
    if passed {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    }
}

fn compare_color(reference: &Surface, rendered: &Surface) -> Result<bool, TestError> {
    fuzzy_compare_ok(&reference.get_const_access(), &rendered.get_const_access(), 0.05)
        .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))
}

/// `ClipControlRenderBaseTest::fuzzyDepthCompare`
fn fuzzy_depth_compare(
    reference: &TextureLevel,
    result: &TextureLevel,
    threshold: f32,
    importance_mask: Option<&TextureLevel>,
) -> bool {
    let mut depth_ok = true;
    let mut difference = 0.0f32;

    let [width, height, _] = result.size();
    let reference = reference.get_const_access();
    let result = result.get_const_access();

    let mut y = 0;
    while y < height && depth_ok {
        let mut x = 0;
        while x < width && depth_ok {
            let ref_depth = reference.get_pix_depth(x, y, 0);
            let res_depth = result.get_pix_depth(x, y, 0);
            difference = (ref_depth - res_depth).abs();
            if let Some(mask) = importance_mask {
                difference *= mask.get_const_access().get_pix_depth(x, y, 0);
            }
            depth_ok &= difference < threshold;
            x += 1;
        }
        y += 1;
    }

    if !depth_ok {
        log::info!("Image comparison failed: difference = {difference}, threshold = {threshold}");
    }

    depth_ok
}

fn depth_format() -> TextureFormat {
    TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT)
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    Initial,
    ModifyGet,
    Errors,
    Origin,
    DepthModeZeroToOne,
    DepthModeOneToOne,
    FaceCulling,
    ViewportBounds,
}

impl Kind {
    fn is_render_test(self) -> bool {
        !matches!(self, Self::Initial | Self::ModifyGet | Self::Errors)
    }

    fn name(self) -> &'static str {
        match self {
            Self::Initial => "initial",
            Self::ModifyGet => "modify_get",
            Self::Errors => "errors",
            Self::Origin => "origin",
            Self::DepthModeZeroToOne => "depth_mode_zero_to_one",
            Self::DepthModeOneToOne => "depth_mode_one_to_one",
            Self::FaceCulling => "face_culling",
            Self::ViewportBounds => "viewport_bounds",
        }
    }
}

/// `init` of `ClipControlRenderBaseTest` plus every test class's `deinit`.
struct Restore<'ctx> {
    context: &'ctx Context,
    kind: Kind,
    framebuffer: glu::Framebuffer<'ctx>,
    renderbuffer_color: glu::Renderbuffer<'ctx>,
    renderbuffer_depth: glu::Renderbuffer<'ctx>,
}

impl<'ctx> Restore<'ctx> {
    fn new(context: &'ctx Context, kind: Kind) -> Self {
        let gl = context.gl();
        let restore = Self {
            context,
            kind,
            framebuffer: glu::Framebuffer::new(gl),
            renderbuffer_color: glu::Renderbuffer::new(gl),
            renderbuffer_depth: glu::Renderbuffer::new(gl),
        };

        if kind.is_render_test() {
            let render_target = context.render_target();

            // SAFETY: the names are owned by `restore`.
            unsafe {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, restore.renderbuffer_color.get());
                gl.renderbuffer_storage(
                    glw::GL_RENDERBUFFER,
                    glw::GL_RGBA8,
                    render_target.width,
                    render_target.height,
                );
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, restore.renderbuffer_depth.get());
                gl.renderbuffer_storage(
                    glw::GL_RENDERBUFFER,
                    glw::GL_DEPTH_COMPONENT24,
                    render_target.width,
                    render_target.height,
                );

                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, restore.framebuffer.get());
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    restore.renderbuffer_color.get(),
                );
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    restore.renderbuffer_depth.get(),
                );
            }
        }

        restore
    }
}

impl Drop for Restore<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();

        // SAFETY: plain state calls on the current context.
        unsafe {
            if self.kind.is_render_test() {
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            }

            if gl.clip_control.is_some() {
                clip_control(gl, glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE);
            }

            match self.kind {
                Kind::Origin => gl.clear_color(0.0, 0.0, 0.0, 0.0),
                Kind::DepthModeZeroToOne | Kind::DepthModeOneToOne | Kind::FaceCulling => {
                    if self.kind == Kind::FaceCulling {
                        gl.disable(glw::GL_CULL_FACE);
                    }
                    gl.clear_depth(0.0);
                    gl.clear_color(0.0, 0.0, 0.0, 0.0);

                    gl.disable(glw::GL_DEPTH_TEST);
                    gl.depth_func(glw::GL_LESS);
                }
                Kind::ViewportBounds => {
                    let render_target = self.context.render_target();
                    gl.clear_color(0.0, 0.0, 0.0, 0.0);
                    gl.viewport(0, 0, render_target.width, render_target.height);
                }
                Kind::Initial | Kind::ModifyGet | Kind::Errors => {}
            }
        }
    }
}

// ---------------------------------------------------------------------------------------------
// The cases
// ---------------------------------------------------------------------------------------------

/// `ClipControlInitialState::iterate`
fn initial_state(context: &Context) -> TestOutcome {
    if !verify_state(context.gl(), glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE)? {
        return Err(TestError::Fail("Wrong intitial state: GL_CLIP_ORIGIN should be GL_LOWER_LEFT, GL_CLIP_ORIGIN should be NEGATIVE_ONE_TO_ONE".to_string()));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `ClipControlModifyGetState::iterate`
fn modify_get_state(context: &Context) -> TestOutcome {
    let gl = context.gl();

    let cases = [
        [glw::GL_UPPER_LEFT, glw::GL_ZERO_TO_ONE],
        [glw::GL_UPPER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE],
        [glw::GL_LOWER_LEFT, glw::GL_ZERO_TO_ONE],
        [glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE],
    ];

    for case in cases {
        clip_control(gl, case[0], case[1]);
        glu::expect_no_error(gl, "ClipControl()")?;
        if !verify_state(gl, case[0], case[1])? {
            return Err(TestError::Fail(
                "Wrong ClipControl state after ClipControl() call".to_string(),
            ));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `ClipControlErrors::iterate`
fn errors(context: &Context) -> TestOutcome {
    let gl = context.gl();

    let mut improper_value = glw::GL_NONE;

    while improper_value == glw::GL_UPPER_LEFT
        || improper_value == glw::GL_LOWER_LEFT
        || improper_value == glw::GL_ZERO_TO_ONE
        || improper_value == glw::GL_NEGATIVE_ONE_TO_ONE
    {
        improper_value += 1;
    }

    let cases = [
        [glw::GL_UPPER_LEFT, improper_value],
        [glw::GL_LOWER_LEFT, improper_value],
        [improper_value, glw::GL_ZERO_TO_ONE],
        [improper_value, glw::GL_NEGATIVE_ONE_TO_ONE],
        [improper_value, improper_value],
    ];

    for case in cases {
        clip_control(gl, case[0], case[1]);

        if get_error(gl) != glw::GL_INVALID_ENUM {
            log::info!(
                "ClipControl have not generated GL_INVALID_ENUM error when called with invalid value ({}, {}).",
                case[0],
                case[1]
            );
        }
    }

    // Upstream sets Fail inside the loop and Pass after it, so only the log tells.
    Ok(TestStatus::pass("Pass"))
}

const ORIGIN_VSH: &str = "#version 400\n\
in vec2 Position;\n\
void main() {\n\
    gl_Position = vec4(Position, 0.0, 1.0);\n\
}";

const VEC3_VSH: &str = "#version 400\n\
in vec3 Position;\n\
void main() {\n\
    gl_Position = vec4(Position, 1.0);\n\
}";

/// `ClipControlOriginTest::ValidateFramebuffer`
fn origin_validate(context: &Context, origin: glw::GLenum) -> Result<bool, TestError> {
    let render_target = context.render_target();
    let (viewport_w, viewport_h) = (render_target.width, render_target.height);
    let mut rendered_frame = Surface::new(viewport_w, viewport_h);
    let mut reference_frame = Surface::new(viewport_w, viewport_h);

    for y in 0..rendered_frame.get_height() {
        let y_coord = y as f32 / rendered_frame.get_height() as f32;

        for x in 0..rendered_frame.get_width() {
            let x_coord = x as f32 / rendered_frame.get_width() as f32;

            let green_quadrant = if origin == glw::GL_UPPER_LEFT {
                f64::from(y_coord) > 0.5 && f64::from(x_coord) <= 0.5
            } else {
                f64::from(y_coord) <= 0.5 && f64::from(x_coord) <= 0.5
            };

            reference_frame.set_pixel(x, y, if green_quadrant { RGBA::green() } else { RGBA::red() });
        }
    }

    glu::read_pixels(&context.render_context, 0, 0, &mut rendered_frame.get_access())?;

    compare_color(&reference_frame, &rendered_frame)
}

/// `ClipControlOriginTest::iterate`
fn origin_test(context: &Context) -> TestOutcome {
    let gl = context.gl();

    let program = build_program(gl, ORIGIN_VSH, fsh())?;

    let vao = VertexArray::new(gl);
    let vbo = Buffer::new(gl);

    let vertex_data0: [f32; 8] = [-1.0, -1.0, 0.0, -1.0, -1.0, 0.0, 0.0, 0.0];
    upload_vertices(gl, &vao, &vbo, &vertex_data0, 2);

    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };

    let mut result = true;

    for origin in [glw::GL_UPPER_LEFT, glw::GL_LOWER_LEFT] {
        // SAFETY: plain state calls.
        unsafe {
            gl.clear_color(1.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        clip_control(gl, origin, glw::GL_NEGATIVE_ONE_TO_ONE);
        glu::expect_no_error(gl, "ClipControl()")?;

        // SAFETY: the vertex array bound above holds four vertices.
        unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };

        if !origin_validate(context, origin)? {
            result = false;
        }
    }

    Ok(status_of(result))
}

const DEPTH_VERTEX_DATA: [f32; 12] = [-1.0, -1.0, -1.0, 1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0];

/// The part of `ClipControlDepthModeZeroToOneTest::iterate` and `ClipControlDepthModeOneToOneTest::iterate` that differs only in the depth mode.
fn depth_mode_render(context: &Context, depth_mode: glw::GLenum) -> Result<(), TestError> {
    let gl = context.gl();

    // SAFETY: plain state calls.
    unsafe {
        gl.clear_color(1.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);

        gl.clear_depth(0.5);
        gl.clear(glw::GL_DEPTH_BUFFER_BIT);
    }

    clip_control(gl, glw::GL_LOWER_LEFT, depth_mode);
    glu::expect_no_error(gl, "ClipControl()")?;

    // SAFETY: plain state calls.
    unsafe {
        gl.enable(glw::GL_DEPTH_TEST);
        gl.depth_func(glw::GL_ALWAYS);
    }

    Ok(())
}

/// `ClipControlDepthModeZeroToOneTest::ValidateFramebuffer`
fn depth_mode_zero_to_one_validate(context: &Context) -> Result<bool, TestError> {
    let render_target = context.render_target();
    let (viewport_w, viewport_h) = (render_target.width, render_target.height);
    let mut rendered_color_frame = Surface::new(viewport_w, viewport_h);
    let mut reference_color_frame = Surface::new(viewport_w, viewport_h);
    let mut rendered_depth_frame = TextureLevel::new(depth_format(), viewport_w as u32, viewport_h as u32, 1)?;
    let mut reference_depth_frame = TextureLevel::new(depth_format(), viewport_w as u32, viewport_h as u32, 1)?;
    let mut importance_mask_frame = TextureLevel::new(depth_format(), viewport_w as u32, viewport_h as u32, 1)?;

    let rasterization_error =
        2.0f32 / rendered_color_frame.get_height() as f32 + 2.0f32 / rendered_color_frame.get_width() as f32;

    for y in 0..rendered_color_frame.get_height() {
        let y_coord = (y as f32 + 0.5) / rendered_color_frame.get_height() as f32;

        for x in 0..rendered_color_frame.get_width() {
            let x_coord = (x as f32 + 0.5) / rendered_color_frame.get_width() as f32;

            let (xc, yc, err) = (f64::from(x_coord), f64::from(y_coord), f64::from(rasterization_error));

            if yc >= 1.0 - xc - err && yc <= 1.0 - xc + err {
                importance_mask_frame
                    .get_access()
                    .set_pix_depth(0.0, x as u32, y as u32, 0);
            } else {
                importance_mask_frame
                    .get_access()
                    .set_pix_depth(1.0, x as u32, y as u32, 0);
            }

            if yc < 1.0 - xc {
                reference_color_frame.set_pixel(x, y, RGBA::red());
                reference_depth_frame
                    .get_access()
                    .set_pix_depth(0.5, x as u32, y as u32, 0);
            } else {
                reference_color_frame.set_pixel(x, y, RGBA::green());

                reference_depth_frame
                    .get_access()
                    .set_pix_depth(-1.0 + x_coord + y_coord, x as u32, y as u32, 0);
            }
        }
    }

    glu::read_pixels(&context.render_context, 0, 0, &mut rendered_color_frame.get_access())?;
    if !compare_color(&reference_color_frame, &rendered_color_frame)? {
        return Ok(false);
    }

    glu::read_pixels(&context.render_context, 0, 0, &mut rendered_depth_frame.get_access())?;
    if !fuzzy_depth_compare(
        &reference_depth_frame,
        &rendered_depth_frame,
        0.05,
        Some(&importance_mask_frame),
    ) {
        return Ok(false);
    }

    Ok(true)
}

/// `ClipControlDepthModeOneToOneTest::ValidateFramebuffer`
fn depth_mode_one_to_one_validate(context: &Context) -> Result<bool, TestError> {
    let render_target = context.render_target();
    let (viewport_w, viewport_h) = (render_target.width, render_target.height);
    let mut rendered_color_frame = Surface::new(viewport_w, viewport_h);
    let mut reference_color_frame = Surface::new(viewport_w, viewport_h);
    let mut rendered_depth_frame = TextureLevel::new(depth_format(), viewport_w as u32, viewport_h as u32, 1)?;
    let mut reference_depth_frame = TextureLevel::new(depth_format(), viewport_w as u32, viewport_h as u32, 1)?;

    for y in 0..rendered_color_frame.get_height() {
        let y_coord = y as f32 / rendered_color_frame.get_height() as f32;

        for x in 0..rendered_color_frame.get_width() {
            let x_coord = x as f32 / rendered_color_frame.get_width() as f32;

            reference_color_frame.set_pixel(x, y, RGBA::green());
            reference_depth_frame
                .get_access()
                .set_pix_depth((x_coord + y_coord) * 0.5, x as u32, y as u32, 0);
        }
    }

    glu::read_pixels(&context.render_context, 0, 0, &mut rendered_color_frame.get_access())?;
    if !compare_color(&reference_color_frame, &rendered_color_frame)? {
        return Ok(false);
    }

    glu::read_pixels(&context.render_context, 0, 0, &mut rendered_depth_frame.get_access())?;
    if !fuzzy_depth_compare(&reference_depth_frame, &rendered_depth_frame, 0.05, None) {
        return Ok(false);
    }

    Ok(true)
}

/// `ClipControlDepthModeZeroToOneTest::iterate` / `ClipControlDepthModeOneToOneTest::iterate`
fn depth_mode_test(context: &Context, depth_mode: glw::GLenum) -> TestOutcome {
    let gl = context.gl();

    depth_mode_render(context, depth_mode)?;

    let program = build_program(gl, VEC3_VSH, fsh())?;

    let vao = VertexArray::new(gl);
    let vbo = Buffer::new(gl);

    upload_vertices(gl, &vao, &vbo, &DEPTH_VERTEX_DATA, 3);

    // SAFETY: the program linked; the vertex array bound above holds four vertices.
    unsafe {
        gl.use_program(program.program());

        gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
    }

    let passed = if depth_mode == glw::GL_ZERO_TO_ONE {
        depth_mode_zero_to_one_validate(context)?
    } else {
        depth_mode_one_to_one_validate(context)?
    };

    Ok(status_of(passed))
}

/// `ClipControlFaceCulling::ValidateFramebuffer`
fn face_culling_validate(context: &Context) -> Result<bool, TestError> {
    let render_target = context.render_target();
    let (viewport_w, viewport_h) = (render_target.width, render_target.height);
    let mut rendered_color_frame = Surface::new(viewport_w, viewport_h);
    let mut reference_color_frame = Surface::new(viewport_w, viewport_h);

    for y in 0..rendered_color_frame.get_height() {
        for x in 0..rendered_color_frame.get_width() {
            let x_coord = x as f32 / rendered_color_frame.get_width() as f32;

            if f64::from(x_coord) < 0.5 {
                reference_color_frame.set_pixel(x, y, RGBA::green());
            } else {
                reference_color_frame.set_pixel(x, y, RGBA::red());
            }
        }
    }

    glu::read_pixels(&context.render_context, 0, 0, &mut rendered_color_frame.get_access())?;
    compare_color(&reference_color_frame, &rendered_color_frame)
}

/// `ClipControlFaceCulling::iterate`
fn face_culling_test(context: &Context) -> TestOutcome {
    let gl = context.gl();

    // SAFETY: plain capability toggle.
    unsafe { gl.enable(glw::GL_CULL_FACE) };

    let program = build_program(gl, VEC3_VSH, fsh())?;

    let vao = VertexArray::new(gl);
    let vbo = Buffer::new(gl);

    let vertex_data0: [f32; 24] = [
        // CCW
        -1.0, -1.0, 0.0, -1.0, -1.0, 1.0, 0.0, -1.0, 0.0, 1.0, -1.0, 1.0, // CW
        0.0, -1.0, 0.0, 1.0, 1.0, -1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0,
    ];
    upload_vertices(gl, &vao, &vbo, &vertex_data0, 2);

    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };

    let mut result = true;

    for origin in [glw::GL_UPPER_LEFT, glw::GL_LOWER_LEFT] {
        // SAFETY: plain state calls; the vertex array bound above holds twelve 2D vertices.
        unsafe {
            gl.clear_color(1.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            gl.draw_arrays(glw::GL_TRIANGLES, 0, 12);
        }

        clip_control(gl, origin, glw::GL_NEGATIVE_ONE_TO_ONE);
        glu::expect_no_error(gl, "ClipControl()")?;

        if !face_culling_validate(context)? {
            result = false;
        }
    }

    Ok(status_of(result))
}

const VIEWPORT_BOUNDS_VSH: &str = "#version 400\n\
in  vec2 Position;\n\
out vec2 PositionOut;\n\
void main() {\n\
    gl_Position = vec4(Position, 0.0, 1.0);\n\
    PositionOut = Position;\n\
}";

const VIEWPORT_BOUNDS_FSH: &str = "#version 400\n\
in  vec2 PositionOut;\n\
out vec4 FragColor;\n\
void main() {\n\
    if (PositionOut.x < 0.0 && PositionOut.y < 0.0)\n\
       FragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
    else\n\
       FragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
}";

/// `ClipControlViewportBounds::ValidateFramebuffer`
fn viewport_bounds_validate(context: &Context, origin: glw::GLenum) -> Result<bool, TestError> {
    let render_target = context.render_target();
    let (window_w, window_h) = (render_target.width, render_target.height);
    let mut rendered_frame = Surface::new(window_w, window_h);
    let mut reference_frame = Surface::new(window_w, window_h);

    for y in 0..rendered_frame.get_height() {
        let y_coord = y as f32 / rendered_frame.get_height() as f32;
        let y_vp_coord = (y_coord - 0.25) * 4.0;

        for x in 0..rendered_frame.get_width() {
            let x_coord = x as f32 / rendered_frame.get_width() as f32;
            let x_vp_coord = (x_coord - 0.125) * 2.0;

            if x_vp_coord > 0.0 && x_vp_coord < 1.0 && y_vp_coord > 0.0 && y_vp_coord < 1.0 {
                let green_quadrant = if origin == glw::GL_UPPER_LEFT {
                    y_vp_coord > 0.5 && x_vp_coord <= 0.5
                } else {
                    y_vp_coord <= 0.5 && x_vp_coord <= 0.5
                };

                reference_frame.set_pixel(x, y, if green_quadrant { RGBA::green() } else { RGBA::red() });
            } else {
                reference_frame.set_pixel(x, y, RGBA::blue());
            }
        }
    }

    glu::read_pixels(&context.render_context, 0, 0, &mut rendered_frame.get_access())?;

    compare_color(&reference_frame, &rendered_frame)
}

/// `ClipControlViewportBounds::iterate`
fn viewport_bounds_test(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let render_target = context.render_target();
    let (window_w, window_h) = (render_target.width as u32, render_target.height as u32);

    // SAFETY: plain state calls.
    unsafe {
        gl.clear_color(0.0, 0.0, 1.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let program = build_program(gl, VIEWPORT_BOUNDS_VSH, VIEWPORT_BOUNDS_FSH)?;

    let vao = VertexArray::new(gl);
    let vbo = Buffer::new(gl);

    let vertex_data0: [f32; 8] = [-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0];
    upload_vertices(gl, &vao, &vbo, &vertex_data0, 2);

    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };

    let mut result = true;

    for origin in [glw::GL_UPPER_LEFT, glw::GL_LOWER_LEFT] {
        // SAFETY: plain state call.
        unsafe {
            gl.viewport(
                (0.125f32 * window_w as f32) as i32,
                (0.25f32 * window_h as f32) as i32,
                (0.5f32 * window_w as f32) as i32,
                (0.25f32 * window_h as f32) as i32,
            )
        };

        clip_control(gl, origin, glw::GL_NEGATIVE_ONE_TO_ONE);
        glu::expect_no_error(gl, "ClipControl()")?;

        // SAFETY: the vertex array bound above holds four vertices.
        unsafe {
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);

            gl.viewport(0, 0, window_w as i32, window_h as i32);
        }

        if !viewport_bounds_validate(context, origin)? {
            result = false;
        }
    }

    Ok(status_of(result))
}

// ---------------------------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------------------------

struct ClipControlCase {
    api: Api,
    kind: Kind,
}

impl TestCase for ClipControlCase {
    fn name(&self) -> &str {
        self.kind.name()
    }

    /// `ClipControlApi`'s constructor
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !self.api.supported(context) {
            return Err(TestError::NotSupported(
                "Required clip_control extension is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let _restore = Restore::new(context, self.kind);

        match self.kind {
            Kind::Initial => initial_state(context),
            Kind::ModifyGet => modify_get_state(context),
            Kind::Errors => errors(context),
            Kind::Origin => origin_test(context),
            Kind::DepthModeZeroToOne => depth_mode_test(context, glw::GL_ZERO_TO_ONE),
            Kind::DepthModeOneToOne => depth_mode_test(context, glw::GL_NEGATIVE_ONE_TO_ONE),
            Kind::FaceCulling => face_culling_test(context),
            Kind::ViewportBounds => viewport_bounds_test(context),
        }
    }
}

/// `ClipControlTests::init`
pub fn create_tests(api_is_gl45_core: bool) -> TestCaseGroup {
    let api = if api_is_gl45_core {
        Api::Gl45Core
    } else {
        Api::ArbClipControl
    };

    let mut group = TestCaseGroup::new(api.test_name());
    for kind in [
        Kind::Initial,
        Kind::ModifyGet,
        Kind::Errors,
        Kind::Origin,
        Kind::DepthModeZeroToOne,
        Kind::DepthModeOneToOne,
        Kind::FaceCulling,
        Kind::ViewportBounds,
    ] {
        group.add_child(Box::new(ClipControlCase { api, kind }) as Box<dyn TestCase>);
    }
    group
}

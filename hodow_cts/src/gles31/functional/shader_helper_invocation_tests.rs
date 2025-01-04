// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderHelperInvocationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream builds the program and the FBO in `init` and runs `iterate` 5 times (value) or
// 16 times (derivate); the harness here has no iterate loop, so those are a loop inside
// `iterate` over one program and one FBO. Each iteration seeds its own `Random` from
// `deStringHash(name) ^ deInt32Hash(iterNdx)`, so the inputs are identical either way.

use crate::glu::{
    self, Context, PrimitiveType, ProgramSources, RenderContext, ShaderProgram, TestCase, TestCaseGroup, pr, va,
};
use crate::glw::{self, GLenum};
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::compare_threshold;
use crate::tcu::{RGBA, Random, Surface, TestError, TestOutcome, TestStatus, de_string_hash};

/// The file's own `PrimitiveType`, which is finer-grained than `glu::PrimitiveType`: the
/// wide variants differ only in the point size / line width the draw sets.
#[derive(Clone, Copy, PartialEq, Eq)]
enum PrimType {
    Triangle,
    Line,
    WideLine,
    Point,
    WidePoint,
}

/// `getNumVerticesPerPrimitive`
fn get_num_vertices_per_primitive(prim_type: PrimType) -> i32 {
    match prim_type {
        PrimType::Triangle => 3,
        PrimType::Line | PrimType::WideLine => 2,
        PrimType::Point | PrimType::WidePoint => 1,
    }
}

/// `getGluPrimitiveType`
fn get_glu_primitive_type(prim_type: PrimType) -> PrimitiveType {
    match prim_type {
        PrimType::Triangle => PrimitiveType::Triangles,
        PrimType::Line | PrimType::WideLine => PrimitiveType::Lines,
        PrimType::Point | PrimType::WidePoint => PrimitiveType::Points,
    }
}

/// `genVertices`
fn gen_vertices(prim_type: PrimType, num_primitives: i32, rnd: &mut Random, dst: &mut Vec<f32>) {
    let is_tri = prim_type == PrimType::Triangle;
    let min_coord = if is_tri { -1.5 } else { -1.0 };
    let max_coord = if is_tri { 1.5 } else { 1.0 };
    let num_vertices_per_primitive = get_num_vertices_per_primitive(prim_type);
    let num_vert = num_vertices_per_primitive * num_primitives;

    dst.clear();
    dst.resize((num_vert * 2) as usize, 0.0);

    for ndx in 0..num_vert as usize {
        dst[ndx * 2] = rnd.get_float_range(min_coord, max_coord);
        dst[ndx * 2 + 1] = rnd.get_float_range(min_coord, max_coord);
    }

    // Don't produce completely or almost completely discardable primitives.
    // \note: This doesn't guarantee that resulting primitives are visible or
    //        produce any fragments. This just removes trivially discardable
    //        primitives.
    for primitive_ndx in 0..num_primitives {
        for component in 0..2 {
            let mut negative_clip = true;
            let mut positive_clip = true;

            for vertex_ndx in 0..num_vertices_per_primitive {
                let p = dst[((primitive_ndx * num_vertices_per_primitive + vertex_ndx) * 2 + component) as usize];
                // \note 0.9 instead of 1.0 to avoid just barely visible primitives
                if p > -0.9 {
                    negative_clip = false;
                }
                if p < 0.9 {
                    positive_clip = false;
                }
            }

            // if discardable, just mirror first vertex along center
            if negative_clip || positive_clip {
                let base = (primitive_ndx * num_vertices_per_primitive * 2) as usize;
                dst[base] *= -1.0;
                dst[base + 1] *= -1.0;
            }
        }
    }
}

/// `getInteger`
fn get_integer(gl: &glw::Functions, pname: GLenum) -> Result<i32, TestError> {
    let mut v = 0;
    // SAFETY: a single-valued pname and one GLint of output.
    unsafe { gl.get_integerv(pname, &mut v) };
    glu::expect_no_error(gl, "glGetIntegerv()")?;
    Ok(v)
}

/// `getRange`
fn get_range(gl: &glw::Functions, pname: GLenum) -> Result<[f32; 2], TestError> {
    let mut v = [0.0f32; 2];
    // SAFETY: both range pnames this is called with return exactly two floats.
    unsafe { gl.get_floatv(pname, v.as_mut_ptr()) };
    glu::expect_no_error(gl, "glGetFloatv()")?;
    Ok(v)
}

/// `drawRandomPrimitives`
fn draw_random_primitives(
    render_ctx: &RenderContext,
    program: glw::GLuint,
    prim_type: PrimType,
    num_primitives: i32,
    rnd: &mut Random,
) -> Result<(), TestError> {
    let gl = render_ctx.functions();
    const MIN_POINT_SIZE: f32 = 16.0;
    const MAX_POINT_SIZE: f32 = 32.0;
    const MIN_LINE_WIDTH: f32 = 16.0;
    const MAX_LINE_WIDTH: f32 = 32.0;
    let mut vertices = Vec::new();

    gen_vertices(prim_type, num_primitives, rnd, &mut vertices);

    let num_vertices = (vertices.len() / 2) as i32;
    let vertex_arrays = [va::float("a_position", 2, num_vertices, 0, &vertices)];

    // SAFETY: a linked program.
    unsafe { gl.use_program(program) };

    // Special state for certain primitives
    if prim_type == PrimType::Point || prim_type == PrimType::WidePoint {
        // Every root this port runs is ES, so `glu::isContextTypeES` is always true here
        // and `GL_SMOOTH_POINT_SIZE_RANGE` is unreachable.
        let range = get_range(gl, glw::GL_ALIASED_POINT_SIZE_RANGE)?;
        let is_wide_point = prim_type == PrimType::WidePoint;
        let point_size = if is_wide_point {
            rnd.get_float_range(MIN_POINT_SIZE, MAX_POINT_SIZE).min(range[1])
        } else {
            1.0
        };
        // SAFETY: a NUL-terminated name; a uniform the program never used answers -1,
        // which `glUniform1f` ignores.
        unsafe {
            let point_size_loc = gl.get_uniform_location(program, c"u_pointSize".as_ptr());
            gl.uniform_1f(point_size_loc, point_size);
        }
    } else if prim_type == PrimType::WideLine {
        let range = get_range(gl, glw::GL_ALIASED_LINE_WIDTH_RANGE)?;
        let line_width = rnd.get_float_range(MIN_LINE_WIDTH, MAX_LINE_WIDTH).min(range[1]);

        // SAFETY: a width inside the driver's own reported range.
        unsafe { gl.line_width(line_width) };
    }

    glu::draw(
        render_ctx,
        program,
        &vertex_arrays,
        &pr::list(get_glu_primitive_type(prim_type), num_vertices),
    )
}

/// `FboHelper`
struct FboHelper<'a> {
    render_ctx: &'a RenderContext,
    num_samples: i32,
    size: (i32, i32),

    _colorbuffer: glu::Renderbuffer<'a>,
    framebuffer: glu::Framebuffer<'a>,
    _resolve_colorbuffer: glu::Renderbuffer<'a>,
    resolve_framebuffer: glu::Framebuffer<'a>,
}

impl<'a> FboHelper<'a> {
    fn new(
        render_ctx: &'a RenderContext,
        width: i32,
        height: i32,
        format: GLenum,
        num_samples: i32,
    ) -> Result<Self, TestError> {
        let gl = render_ctx.functions();
        let max_samples = get_integer(gl, glw::GL_MAX_SAMPLES)?;

        let colorbuffer = glu::Renderbuffer::new(gl);
        let framebuffer = glu::Framebuffer::new(gl);
        let resolve_colorbuffer = glu::Renderbuffer::new(gl);
        let resolve_framebuffer = glu::Framebuffer::new(gl);

        // SAFETY: four objects this call owns, and a colour-renderable internal format.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, colorbuffer.get());
            gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, num_samples, format, width, height);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                colorbuffer.get(),
            );
        }

        // SAFETY: the framebuffer just bound.
        if num_samples > max_samples
            && unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE
        {
            return Err(TestError::NotSupported(
                "Sample count exceeds GL_MAX_SAMPLES".to_string(),
            ));
        }

        // SAFETY: as above.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("Multisample framebuffer is not complete".to_string()));
        }

        if num_samples != 0 {
            // SAFETY: as above, for the single-sample resolve target.
            unsafe {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, resolve_colorbuffer.get());
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, width, height);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resolve_framebuffer.get());
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    resolve_colorbuffer.get(),
                );
            }

            // SAFETY: the framebuffer just bound.
            if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail("Resolve framebuffer is not complete".to_string()));
            }
        }

        glu::expect_no_error(gl, "Failed to create framebuffer")?;

        Ok(Self {
            render_ctx,
            num_samples,
            size: (width, height),
            _colorbuffer: colorbuffer,
            framebuffer,
            _resolve_colorbuffer: resolve_colorbuffer,
            resolve_framebuffer,
        })
    }

    /// `FboHelper::bindForRendering`
    fn bind_for_rendering(&self) -> Result<(), TestError> {
        let gl = self.render_ctx.functions();

        // SAFETY: a framebuffer this helper owns.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer.get()) };
        glu::expect_no_error(gl, "glBindFramebuffer()")?;
        // SAFETY: a viewport the size of the attachment.
        unsafe { gl.viewport(0, 0, self.size.0, self.size.1) };
        glu::expect_no_error(gl, "viewport()")
    }

    /// `FboHelper::readPixels`
    fn read_pixels(&self, x: i32, y: i32, dst: &mut Surface) -> Result<(), TestError> {
        let gl = self.render_ctx.functions();
        let width = dst.get_width();
        let height = dst.get_height();

        if self.num_samples != 0 {
            // SAFETY: the multisample framebuffer is still the read target from
            // `bind_for_rendering`, and the resolve target has the same format and size.
            unsafe {
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.resolve_framebuffer.get());
                gl.blit_framebuffer(
                    x,
                    y,
                    width,
                    height,
                    x,
                    y,
                    width,
                    height,
                    glw::GL_COLOR_BUFFER_BIT,
                    glw::GL_NEAREST,
                );
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.resolve_framebuffer.get());
            }
        }

        glu::read_pixels(self.render_ctx, x, y, &mut dst.get_access())
    }
}

const FRAMEBUFFER_WIDTH: i32 = 256;
const FRAMEBUFFER_HEIGHT: i32 = 256;
const FRAMEBUFFER_FORMAT: GLenum = glw::GL_RGBA8;
/// `NUM_SAMPLES_MAX` - the sentinel for "use `GL_MAX_SAMPLES`".
const NUM_SAMPLES_MAX: i32 = -1;

const VERTEX_SRC: &str = concat!(
    "#version 310 es\n",
    "in highp vec2 a_position;\n",
    "uniform highp float u_pointSize;\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = vec4(a_position, 0.0, 1.0);\n",
    "    gl_PointSize = u_pointSize;\n",
    "}\n",
);

/// The common half of both cases' `init`: link the program, then size the FBO.
fn setup<'a>(
    context: &'a Context,
    frag_src: &str,
    num_samples: i32,
) -> Result<(ShaderProgram<'a>, FboHelper<'a>), TestError> {
    let render_ctx = &context.render_context;
    let gl = context.gl();
    let max_samples = get_integer(gl, glw::GL_MAX_SAMPLES)?;
    let actual_samples = if num_samples == NUM_SAMPLES_MAX {
        max_samples
    } else {
        num_samples
    };

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SRC, frag_src));

    if !program.is_ok() {
        return Err(TestError::Fail("Compile failed".to_string()));
    }

    log::debug!("Using GL_RGBA8 framebuffer with {actual_samples} samples");

    let fbo = FboHelper::new(
        render_ctx,
        FRAMEBUFFER_WIDTH,
        FRAMEBUFFER_HEIGHT,
        FRAMEBUFFER_FORMAT,
        actual_samples,
    )?;

    Ok((program, fbo))
}

/// Verifies that `gl_HelperInvocation` is false in all rendered pixels.
///
/// `HelperInvocationValueCase`
struct HelperInvocationValueCase {
    name: String,
    primitive_type: PrimType,
    num_samples: i32,
}

/// `verifyHelperInvocationValue`
fn verify_helper_invocation_value(result: &Surface, is_multi_sample: bool) -> bool {
    let bg_ref = RGBA::new(0, 0, 0, 255);
    let fg_ref = RGBA::new(0, 255, 0, 255);
    let threshold = RGBA::new(1, if is_multi_sample { 254 } else { 1 }, 1, 1);
    let mut num_invalid_pixels = 0;
    let mut rendered_something = false;

    for y in 0..result.get_height() {
        for x in 0..result.get_width() {
            let res_pix = result.get_pixel(x, y);
            let is_bg = compare_threshold(res_pix, bg_ref, threshold);
            let is_fg = compare_threshold(res_pix, fg_ref, threshold);

            if !is_bg && !is_fg {
                num_invalid_pixels += 1;
            }

            if is_fg {
                rendered_something = true;
            }
        }
    }

    if num_invalid_pixels > 0 {
        log::warn!("ERROR: Found {num_invalid_pixels} invalid result pixels!");
        false
    } else if !rendered_something {
        log::warn!("ERROR: Result image was empty!");
        false
    } else {
        log::debug!("All result pixels are valid");
        true
    }
}

impl TestCase for HelperInvocationValueCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const NUM_ITERS: i32 = 5;
        const NUM_PRIMITIVES_PER_ITER: i32 = 10;
        const FRAGMENT_SRC: &str = concat!(
            "#version 310 es\n",
            "out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    if (gl_HelperInvocation)\n",
            "        o_color = vec4(1.0, 0.0, 0.0, 1.0);\n",
            "    else\n",
            "        o_color = vec4(0.0, 1.0, 0.0, 1.0);\n",
            "}\n",
        );

        let render_ctx = &context.render_context;
        let gl = context.gl();
        let (program, fbo) = setup(context, FRAGMENT_SRC, self.num_samples)?;
        let mut status = TestStatus::pass("Pass");

        for iter_ndx in 0..NUM_ITERS {
            log::debug!("Iteration {} / {NUM_ITERS}", iter_ndx + 1);
            let mut rnd = Random::new(de_string_hash(&self.name) ^ de_int32_hash(iter_ndx));
            let mut result = Surface::new(FRAMEBUFFER_WIDTH, FRAMEBUFFER_HEIGHT);

            fbo.bind_for_rendering()?;
            // SAFETY: plain state setters on a complete framebuffer.
            unsafe {
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            draw_random_primitives(
                render_ctx,
                program.program(),
                self.primitive_type,
                NUM_PRIMITIVES_PER_ITER,
                &mut rnd,
            )?;

            fbo.read_pixels(0, 0, &mut result)?;

            if !verify_helper_invocation_value(&result, self.num_samples != 0) {
                // Upstream records the failure and still runs every iteration.
                status = TestStatus::fail("Invalid pixels found");
            }
        }

        // SAFETY: rebinding the default framebuffer is always valid.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

        Ok(status)
    }
}

/// Checks derivates when the value depends on `gl_HelperInvocation`.
///
/// `HelperInvocationDerivateCase`
struct HelperInvocationDerivateCase {
    name: String,
    primitive_type: PrimType,
    num_samples: i32,
    derivate_func: &'static str,
    check_absolute_value: bool,
}

/// `hasNeighborWithColor`
fn has_neighbor_with_color(surface: &Surface, x: i32, y: i32, color: RGBA, threshold: RGBA) -> bool {
    let w = surface.get_width();
    let h = surface.get_height();

    for dx in -1..2 {
        for dy in -1..2 {
            let pos = (x + dx, y + dy);

            if dx == 0 && dy == 0 {
                continue;
            }

            if (0..w).contains(&pos.0) && (0..h).contains(&pos.1) {
                let neighbor_color = surface.get_pixel(pos.0, pos.1);

                if compare_threshold(color, neighbor_color, threshold) {
                    return true;
                }
            } else {
                return true; // Can't know for certain
            }
        }
    }

    false
}

/// `verifyHelperInvocationDerivate`
fn verify_helper_invocation_derivate(result: &Surface, is_multi_sample: bool) -> bool {
    let bg_ref = RGBA::new(0, 0, 0, 255);
    let fg_ref = RGBA::new(0, 255, 0, 255);
    let is_bg_threshold = RGBA::new(1, if is_multi_sample { 254 } else { 1 }, 0, 1);
    let is_fg_threshold = RGBA::new(1, if is_multi_sample { 254 } else { 1 }, 255, 1);
    let mut num_invalid_pixels = 0;
    let mut num_non_zero_deriv = 0;
    let mut rendered_something = false;

    for y in 0..result.get_height() {
        for x in 0..result.get_width() {
            let res_pix = result.get_pixel(x, y);
            let is_bg = compare_threshold(res_pix, bg_ref, is_bg_threshold);
            let is_fg = compare_threshold(res_pix, fg_ref, is_fg_threshold);
            let non_zero_deriv = res_pix.get_blue() > 0;
            let neighbor_bg = non_zero_deriv && has_neighbor_with_color(result, x, y, bg_ref, is_bg_threshold);

            if non_zero_deriv {
                num_non_zero_deriv += 1;
            }

            // Neither of valid colors (ignoring blue channel that has derivate), or has
            // non-zero derivate but the sample is not at a primitive edge or inside one.
            if (!is_bg && !is_fg) || (non_zero_deriv && !neighbor_bg && !is_fg) {
                num_invalid_pixels += 1;
            }

            if is_fg {
                rendered_something = true;
            }
        }
    }

    log::debug!(
        "Found {num_non_zero_deriv} pixels with non-zero derivate (neighbor sample has gl_HelperInvocation = true)"
    );

    if num_invalid_pixels > 0 {
        log::warn!("ERROR: Found {num_invalid_pixels} invalid result pixels!");
        false
    } else if !rendered_something {
        log::warn!("ERROR: Result image was empty!");
        false
    } else {
        log::debug!("All result pixels are valid");
        true
    }
}

impl TestCase for HelperInvocationDerivateCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const NUM_ITERS: i32 = 16;

        let render_ctx = &context.render_context;
        let gl = context.gl();
        let func_source = if self.check_absolute_value {
            format!("abs({}(value))", self.derivate_func)
        } else {
            format!("{}(value)", self.derivate_func)
        };
        let fragment_src = format!(
            concat!(
                "#version 310 es\n",
                "out mediump vec4 o_color;\n",
                "void main (void)\n",
                "{{\n",
                "    highp float value = gl_HelperInvocation ? 1.0 : 0.0;\n",
                "    highp float derivate = {};\n",
                "    if (gl_HelperInvocation)\n",
                "        o_color = vec4(1.0, 0.0, derivate, 1.0);\n",
                "    else\n",
                "        o_color = vec4(0.0, 1.0, derivate, 1.0);\n",
                "}}\n",
            ),
            func_source
        );

        let (program, fbo) = setup(context, &fragment_src, self.num_samples)?;
        let mut status = TestStatus::pass("Pass");

        for iter_ndx in 0..NUM_ITERS {
            log::debug!("Iteration {} / {NUM_ITERS}", iter_ndx + 1);
            let mut rnd = Random::new(de_string_hash(&self.name) ^ de_int32_hash(iter_ndx));
            let mut result = Surface::new(FRAMEBUFFER_WIDTH, FRAMEBUFFER_HEIGHT);

            fbo.bind_for_rendering()?;
            // SAFETY: plain state setters on a complete framebuffer.
            unsafe {
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            draw_random_primitives(render_ctx, program.program(), self.primitive_type, 1, &mut rnd)?;

            fbo.read_pixels(0, 0, &mut result)?;

            if !verify_helper_invocation_derivate(&result, self.num_samples != 0) {
                // Upstream records the failure and still runs every iteration.
                status = TestStatus::fail("Invalid pixels found");
            }
        }

        // SAFETY: rebinding the default framebuffer is always valid.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

        Ok(status)
    }
}

/// `s_primTypes`
const PRIM_TYPES: [(&str, PrimType); 5] = [
    ("triangles", PrimType::Triangle),
    ("lines", PrimType::Line),
    ("wide_lines", PrimType::WideLine),
    ("points", PrimType::Point),
    ("wide_points", PrimType::WidePoint),
];

/// `s_sampleCounts`
const SAMPLE_COUNTS: [(&str, i32); 4] = [
    ("", 0),
    ("_4_samples", 4),
    ("_8_samples", 8),
    ("_max_samples", NUM_SAMPLES_MAX),
];

/// `ShaderHelperInvocationTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("helper_invocation");

    // value
    {
        let mut value_group = TestCaseGroup::new("value");

        for (suffix, num_samples) in SAMPLE_COUNTS {
            for (case_name, primitive_type) in PRIM_TYPES {
                value_group.add_child(Box::new(HelperInvocationValueCase {
                    name: format!("{case_name}{suffix}"),
                    primitive_type,
                    num_samples,
                }) as Box<dyn TestCase>);
            }
        }

        group.add_child(value_group);
    }

    // derivate
    {
        let mut derivate_group = TestCaseGroup::new("derivate");

        for (suffix, num_samples) in SAMPLE_COUNTS {
            for (case_name, primitive_type) in PRIM_TYPES {
                for (name_suffix, derivate_func, check_absolute_value) in [
                    ("_dfdx", "dFdx", true),
                    ("_dfdy", "dFdy", true),
                    ("_fwidth", "fwidth", false),
                ] {
                    derivate_group.add_child(Box::new(HelperInvocationDerivateCase {
                        name: format!("{case_name}{suffix}{name_suffix}"),
                        primitive_type,
                        num_samples,
                        derivate_func,
                        check_absolute_value,
                    }) as Box<dyn TestCase>);
                }
            }
        }

        group.add_child(derivate_group);
    }

    group
}

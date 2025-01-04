// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsShaderRenderCase.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `TextureBinding` is not ported: it holds a `glu::Texture2D`/`TextureCube`/... , the
// texture-upload helpers this tree does not have, and only `texture_functions` and the
// texture half of `builtin_functions` bind anything. Every other consumer of this
// framework renders from attributes and uniforms alone, which is what is here.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, pr, va};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::matrix::Mat4;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::rgba::RGBA;
use crate::tcu::vector::{IVec2, Vec2, Vec4};
use crate::tcu::{
    ChannelOrder, ChannelType, Random, Surface, TestError, TestOutcome, TestStatus, TextureFormat, de_string_hash,
    fuzzy_image_compare,
};

const GRID_SIZE: i32 = 92;
/// `GRID_SIZE` of the Khronos copy (`glcShaderRenderCase.cpp`).
const KHRONOS_GRID_SIZE: i32 = 64;
const MAX_RENDER_WIDTH: i32 = 128;
const MAX_RENDER_HEIGHT: i32 = 112;
const DEFAULT_CLEAR_COLOR: Vec4 = Vec4::new(0.125, 0.25, 0.5, 1.0);
/// `DEFAULT_CLEAR_COLOR` of the Khronos copy.
const KHRONOS_CLEAR_COLOR: Vec4 = Vec4::new(0.0, 0.0, 0.0, 1.0);

/// `ShaderEvalContext::MAX_USER_ATTRIBS`
pub const MAX_USER_ATTRIBS: usize = 4;

/// `gls::QuadGrid`
pub struct QuadGrid {
    grid_size: i32,
    num_vertices: i32,
    num_triangles: i32,
    const_coords: Vec4,
    user_attrib_transforms: Vec<Mat4>,

    positions: Vec<f32>,
    coords: Vec<f32>,
    unit_coords: Vec<f32>,
    attrib_one: Vec<f32>,
    user_attribs: [Vec<f32>; MAX_USER_ATTRIBS],
    indices: Vec<u16>,
}

impl QuadGrid {
    /// Upstream also takes the viewport size, for an `m_screenPos` array nothing ever
    /// reads back; there is no field for it here.
    pub fn new(grid_size: i32, const_coords: Vec4, user_attrib_transforms: Vec<Mat4>) -> Self {
        let num_vertices = (grid_size + 1) * (grid_size + 1);
        let num_triangles = grid_size * grid_size * 2;
        let num_user_attribs = user_attrib_transforms.len();

        let mut grid = Self {
            grid_size,
            num_vertices,
            num_triangles,
            const_coords,
            user_attrib_transforms,
            positions: Vec::with_capacity(num_vertices as usize * 4),
            coords: Vec::with_capacity(num_vertices as usize * 4),
            unit_coords: Vec::with_capacity(num_vertices as usize * 4),
            attrib_one: Vec::with_capacity(num_vertices as usize),
            user_attribs: std::array::from_fn(|_| Vec::with_capacity(num_vertices as usize * 4)),
            indices: Vec::with_capacity(3 * num_triangles as usize),
        };

        for y in 0..grid_size + 1 {
            for x in 0..grid_size + 1 {
                let sx = x as f32 / grid_size as f32;
                let sy = y as f32 / grid_size as f32;
                let fx = 2.0 * sx - 1.0;
                let fy = 2.0 * sy - 1.0;

                grid.positions.extend_from_slice(&[fx, fy, 0.0, 1.0]);
                grid.attrib_one.push(1.0);
                grid.coords.extend_from_slice(&coords_at(sx, sy).m_data);
                grid.unit_coords.extend_from_slice(&unit_coords_at(sx, sy).m_data);

                for attrib_ndx in 0..num_user_attribs {
                    let value = grid.user_attrib(attrib_ndx, sx, sy);
                    grid.user_attribs[attrib_ndx].extend_from_slice(&value.m_data);
                }
            }
        }

        for y in 0..grid_size {
            for x in 0..grid_size {
                let stride = grid_size + 1;
                let v00 = ((y * stride) + x) as u16;
                let v01 = ((y * stride) + x + 1) as u16;
                let v10 = (((y + 1) * stride) + x) as u16;
                let v11 = (((y + 1) * stride) + x + 1) as u16;

                grid.indices.extend_from_slice(&[v10, v00, v01, v10, v01, v11]);
            }
        }

        grid
    }

    pub fn grid_size(&self) -> i32 {
        self.grid_size
    }

    pub fn num_vertices(&self) -> i32 {
        self.num_vertices
    }

    pub fn num_triangles(&self) -> i32 {
        self.num_triangles
    }

    pub fn const_coords(&self) -> Vec4 {
        self.const_coords
    }

    pub fn num_user_attribs(&self) -> usize {
        self.user_attrib_transforms.len()
    }

    /// `QuadGrid::getUserAttrib(attribNdx, sx, sy)` - homogeneous normalized
    /// screen-space coordinates through the attribute's own transform.
    pub fn user_attrib(&self, attrib_ndx: usize, sx: f32, sy: f32) -> Vec4 {
        self.user_attrib_transforms[attrib_ndx] * Vec4::new(sx, sy, 0.0, 1.0)
    }
}

/// `QuadGrid::getCoords` - near-unit coordinates, roughly [-2.0 .. 2.0].
fn coords_at(sx: f32, sy: f32) -> Vec4 {
    let fx = 2.0 * sx - 1.0;
    let fy = 2.0 * sy - 1.0;
    Vec4::new(fx, fy, -fx + 0.33 * fy, -0.275 * fx - fy)
}

/// `QuadGrid::getUnitCoords` - positive-only coordinates [0.0 .. 1.5].
fn unit_coords_at(sx: f32, sy: f32) -> Vec4 {
    Vec4::new(sx, sy, 0.33 * sx + 0.5 * sy, 0.5 * sx + 0.25 * sy)
}

/// `gls::ShaderEvalContext`
pub struct ShaderEvalContext {
    pub coords: Vec4,
    pub unit_coords: Vec4,
    pub const_coords: Vec4,
    pub in_: [Vec4; MAX_USER_ATTRIBS],

    pub color: Vec4,
    pub is_discarded: bool,
}

impl ShaderEvalContext {
    fn new(const_coords: Vec4) -> Self {
        Self {
            coords: Vec4::splat(0.0),
            unit_coords: Vec4::splat(0.0),
            const_coords,
            in_: [Vec4::splat(0.0); MAX_USER_ATTRIBS],
            color: Vec4::new(0.0, 0.0, 0.0, 1.0),
            is_discarded: false,
        }
    }

    /// `ShaderEvalContext::reset`
    fn reset(&mut self, grid: &QuadGrid, sx: f32, sy: f32) {
        self.color = Vec4::new(0.0, 0.0, 0.0, 1.0);
        self.is_discarded = false;
        self.coords = coords_at(sx, sy);
        self.unit_coords = unit_coords_at(sx, sy);

        for attrib_ndx in 0..grid.num_user_attribs() {
            self.in_[attrib_ndx] = grid.user_attrib(attrib_ndx, sx, sy);
        }
    }

    /// `ShaderEvalContext::discard`
    pub fn discard(&mut self) {
        self.is_discarded = true;
    }
}

/// `gls::ShaderEvalFunc`
pub type ShaderEvalFunc = fn(&mut ShaderEvalContext);

/// `evalCoordsPassthroughX`
pub fn eval_coords_passthrough_x(c: &mut ShaderEvalContext) {
    c.color[0] = c.coords[0];
}

/// `evalCoordsPassthroughXY`
pub fn eval_coords_passthrough_xy(c: &mut ShaderEvalContext) {
    c.color[0] = c.coords[0];
    c.color[1] = c.coords[1];
}

/// `evalCoordsPassthroughXYZ`
pub fn eval_coords_passthrough_xyz(c: &mut ShaderEvalContext) {
    c.color[0] = c.coords[0];
    c.color[1] = c.coords[1];
    c.color[2] = c.coords[2];
}

/// `evalCoordsPassthrough`
pub fn eval_coords_passthrough(c: &mut ShaderEvalContext) {
    c.color = c.coords;
}

/// `evalCoordsSwizzleWZYX`
pub fn eval_coords_swizzle_wzyx(c: &mut ShaderEvalContext) {
    c.color = c.coords.swizzle([3, 2, 1, 0]);
}

/// Everything a `ShaderRenderCase` needs from the case that owns it.
///
/// Upstream makes `ShaderRenderCase` a base class whose `setup`/`setupUniforms` a derived
/// case overrides; this is that interface, so the shared half stays one implementation.
pub trait ShaderRenderCaseSpec: Send + Sync {
    fn name(&self) -> &str;

    /// The two shader sources, built by `setupShaderData` upstream.
    fn shader_sources(&self) -> (&str, &str);

    /// `m_isVertexCase`
    fn is_vertex_case(&self) -> bool;

    /// `ShaderEvaluator::evaluate`
    fn evaluate(&self, ctx: &mut ShaderEvalContext);

    /// `m_userAttribTransforms`
    fn user_attrib_transforms(&self) -> Vec<Mat4> {
        Vec::new()
    }

    /// `m_useLevel` - read back through a `TextureLevel` matching the render target's own
    /// format rather than straight into an RGBA8 surface.
    fn use_level(&self) -> bool {
        false
    }

    /// Whether this is the Khronos GL CTS copy of the class (`glcShaderRenderCase.cpp`) rather than
    /// deqp's (`glsShaderRenderCase.cpp`). They are two files of which one is a derivative of the other:
    /// the Khronos one has a 64 x 64 grid, clears to black, disables dithering, and quantizes a 1-bit
    /// alpha in the reference.
    fn khronos(&self) -> bool {
        false
    }

    /// `m_gridSize`, which only a vertex case uses. `ShaderRenderCase::init` sets it to
    /// `GRID_SIZE`; a case that needs a coarser grid assigns over it right afterwards.
    fn grid_size(&self) -> i32 {
        if self.khronos() { KHRONOS_GRID_SIZE } else { GRID_SIZE }
    }

    /// `ShaderRenderCase::setupUniforms`
    fn setup_uniforms(&self, context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
        let _ = (context, program, const_coords);
        Ok(())
    }

    /// `TestCase::checkSupport`, for the cases that need an extension.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let _ = context;
        Ok(())
    }

    /// Optional per-case teardown, run once after the comparison. Upstream's own cases
    /// hold their GL resources (a `glu::Texture2D`/`TextureCube`) as members and free them
    /// in a destructor/`deinit`; this trait has no such lifetime, so a spec that creates
    /// one of its own (`texture_functions`) deletes it here instead. Every other
    /// implementor already relies on this default no-op.
    fn cleanup(&self, context: &Context) {
        let _ = context;
    }

    /// What a `CompileFailed` from `ShaderRenderCase::init` should become. ES 2.0 leaves
    /// dynamic loops optional, so a case that needs one reports NotSupported instead of a
    /// failure when the driver cannot compile one at all.
    ///
    /// `failure` is upstream's `TCU_FAIL` wording with the driver's own error appended.
    fn on_compile_failed(&self, context: &Context, failure: &str) -> TestError {
        let _ = context;
        TestError::Fail(failure.to_string())
    }
}

/// `gls::ShaderRenderCase`
pub struct ShaderRenderCase<S: ShaderRenderCaseSpec> {
    pub spec: S,
}

impl<S: ShaderRenderCaseSpec> ShaderRenderCase<S> {
    pub fn new(spec: S) -> Self {
        Self { spec }
    }
}

/// `ShaderRenderCase::getViewportSize`
pub(crate) fn viewport_size(context: &Context) -> IVec2 {
    let target = context.render_target();
    IVec2::new(target.width.min(MAX_RENDER_WIDTH), target.height.min(MAX_RENDER_HEIGHT))
}

impl<S: ShaderRenderCaseSpec> TestCase for ShaderRenderCase<S> {
    fn name(&self) -> &str {
        self.spec.name()
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        self.spec.check_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (vert_src, frag_src) = self.spec.shader_sources();

        let program = ShaderProgram::new_reporting_build_failure(gl, &ProgramSources::vtx_frag(vert_src, frag_src));
        if !program.is_ok() {
            let failure = match program.build_failure_summary() {
                Some(detail) => format!("Failed to compile shader program: {detail}"),
                None => "Failed to compile shader program".to_string(),
            };
            return Err(self.spec.on_compile_failed(context, &failure));
        }
        let program_id = program.program();
        // SAFETY: a program this case built.
        unsafe { gl.use_program(program_id) };

        let size = viewport_size(context);
        let (width, height) = (size.x(), size.y());

        let grid = QuadGrid::new(
            if self.spec.is_vertex_case() {
                self.spec.grid_size()
            } else {
                4
            },
            Vec4::new(0.125, 0.25, 0.5, 1.0),
            self.spec.user_attrib_transforms(),
        );

        let mut res_image = Surface::new(width, height);
        let mut ref_image = Surface::new(width, height);

        // When the render target is 10-10-10-2, reading straight into an RGBA8 surface
        // would quantize the result before the comparison; upstream reads into a level of
        // the target's own format and converts both images afterwards.
        let level_format = if self.spec.use_level() {
            Some(read_back_format(context))
        } else {
            None
        };

        match level_format {
            Some(format) => {
                let mut res_level = TextureLevel::new(format, width as u32, height as u32, 1)?;
                let mut ref_level = TextureLevel::new(format, width as u32, height as u32, 1)?;

                render(
                    context,
                    &self.spec,
                    program_id,
                    &grid,
                    &mut InternalSurface::Level(&mut res_level),
                )?;
                self.compute_reference(context, &grid, &mut InternalSurface::Level(&mut ref_level));

                for y in 0..height {
                    for x in 0..width {
                        res_image.set_pixel(
                            x,
                            y,
                            RGBA::from_vec(Vec4::from_array(
                                res_level.get_const_access().get_pixel(x as u32, y as u32, 0),
                            )),
                        );
                        ref_image.set_pixel(
                            x,
                            y,
                            RGBA::from_vec(Vec4::from_array(
                                ref_level.get_const_access().get_pixel(x as u32, y as u32, 0),
                            )),
                        );
                    }
                }
            }
            None => {
                render(
                    context,
                    &self.spec,
                    program_id,
                    &grid,
                    &mut InternalSurface::Surface(&mut res_image),
                )?;
                self.compute_reference(context, &grid, &mut InternalSurface::Surface(&mut ref_image));
            }
        }

        // SAFETY: unbinding is always valid.
        unsafe { gl.use_program(0) };

        self.spec.cleanup(context);

        let test_ok =
            fuzzy_image_compare::fuzzy_compare_ok(&ref_image.get_const_access(), &res_image.get_const_access(), 0.07)
                .ok_or_else(|| TestError::InternalError("fuzzy comparison of unsupported formats".to_string()))?;

        Ok(if test_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl<S: ShaderRenderCaseSpec> ShaderRenderCase<S> {
    fn compute_reference(&self, context: &Context, grid: &QuadGrid, result: &mut InternalSurface<'_>) {
        if self.spec.is_vertex_case() {
            compute_vertex_reference(context, &self.spec, grid, result);
        } else {
            compute_fragment_reference(context, &self.spec, grid, result);
        }
    }
}

/// The RGBA format `glReadPixels` should use for this render target, mirroring the
/// `GL_UNSIGNED_INT_2_10_10_10_REV` choice upstream's `useLevel` path makes.
fn read_back_format(context: &Context) -> TextureFormat {
    let target = context.render_target();
    if target.red_bits == 10
        && target.green_bits == 10
        && target.blue_bits == 10
        && (target.alpha_bits == 2 || target.alpha_bits == 0)
    {
        TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT_1010102_REV,
        }
    } else {
        TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        }
    }
}

/// `ShaderRenderCase::InternalSurface`
enum InternalSurface<'a> {
    Surface(&'a mut Surface),
    Level(&'a mut TextureLevel),
}

impl InternalSurface<'_> {
    fn width(&self) -> i32 {
        match self {
            Self::Surface(s) => s.get_width(),
            Self::Level(l) => l.size()[0] as i32,
        }
    }

    fn height(&self) -> i32 {
        match self {
            Self::Surface(s) => s.get_height(),
            Self::Level(l) => l.size()[1] as i32,
        }
    }

    fn set_pixel(&mut self, x: i32, y: i32, color: Vec4) {
        match self {
            Self::Surface(s) => s.set_pixel(x, y, RGBA::from_vec(color)),
            Self::Level(l) => l.get_access().set_pixel(color.m_data, x as u32, y as u32, 0),
        }
    }

    fn read_pixels(&mut self, context: &Context, x: i32, y: i32) -> Result<(), TestError> {
        match self {
            Self::Surface(s) => glu::read_pixels(&context.render_context, x, y, &mut s.get_access()),
            Self::Level(l) => glu::read_pixels(&context.render_context, x, y, &mut l.get_access()),
        }
    }
}

/// `getDefaultVertexArrays`
fn draw_grid<S: ShaderRenderCaseSpec>(context: &Context, program: GLuint, grid: &QuadGrid) -> Result<(), TestError> {
    let _ = std::marker::PhantomData::<S>;
    let gl = context.gl();
    let num_elements = grid.num_vertices();

    let mut vertex_arrays = vec![
        va::float("a_position", 4, num_elements, 0, &grid.positions),
        va::float("a_coords", 4, num_elements, 0, &grid.coords),
        va::float("a_unitCoords", 4, num_elements, 0, &grid.unit_coords),
        va::float("a_one", 1, num_elements, 0, &grid.attrib_one),
    ];

    let names: Vec<String> = (0..grid.num_user_attribs()).map(|ndx| format!("a_in{ndx}")).collect();
    for (ndx, name) in names.iter().enumerate() {
        vertex_arrays.push(va::float(name, 4, num_elements, 0, &grid.user_attribs[ndx]));
    }

    // Matrix attributes are set by location: one location per column, each column reading
    // the corresponding user attribute's first `numRows` components.
    const MATRICES: &[(&str, usize, i32)] = &[
        ("a_mat2", 2, 2),
        ("a_mat2x3", 2, 3),
        ("a_mat2x4", 2, 4),
        ("a_mat3x2", 3, 2),
        ("a_mat3", 3, 3),
        ("a_mat3x4", 3, 4),
        ("a_mat4x2", 4, 2),
        ("a_mat4x3", 4, 3),
        ("a_mat4", 4, 4),
    ];

    for &(name, num_cols, num_rows) in MATRICES {
        let cname = std::ffi::CString::new(name).expect("no interior NUL");
        // SAFETY: a NUL-terminated name and a program this case built.
        let loc = unsafe { gl.get_attrib_location(program, cname.as_ptr()) };
        if loc < 0 {
            continue;
        }

        for col_ndx in 0..num_cols {
            vertex_arrays.push(va::float_at(
                loc as u32 + col_ndx as u32,
                num_rows,
                num_elements,
                4 * std::mem::size_of::<f32>() as i32,
                &grid.user_attribs[col_ndx],
            ));
        }
    }

    glu::draw(
        &context.render_context,
        program,
        &vertex_arrays,
        &pr::triangles(&grid.indices),
    )
}

fn default_clear_color<S: ShaderRenderCaseSpec>(spec: &S) -> Vec4 {
    if spec.khronos() {
        KHRONOS_CLEAR_COLOR
    } else {
        DEFAULT_CLEAR_COLOR
    }
}

/// `ShaderRenderCase::render`
fn render<S: ShaderRenderCaseSpec>(
    context: &Context,
    spec: &S,
    program: GLuint,
    grid: &QuadGrid,
    result: &mut InternalSurface<'_>,
) -> Result<(), TestError> {
    let gl = context.gl();
    let width = result.width();
    let height = result.height();

    let target = context.render_target();
    let (vert_src, frag_src) = spec.shader_sources();
    let hash = de_string_hash(vert_src).wrapping_add(de_string_hash(frag_src));
    let mut rnd = Random::new(hash);

    let x_offset = rnd.get_int(0, target.width - width);
    let y_offset = rnd.get_int(0, target.height - height);

    // SAFETY: a viewport inside the render target.
    unsafe { gl.viewport(x_offset, y_offset, width, height) };

    spec.setup_uniforms(context, program, grid.const_coords())?;
    setup_default_uniforms(context, program);
    glu::expect_no_error(gl, "post uniform setup")?;

    // SAFETY: a plain clear of the bound framebuffer.
    unsafe {
        let clear_color = default_clear_color(spec);
        // Disable dither, as the Khronos copy does.
        if spec.khronos() {
            gl.disable(glw::GL_DITHER);
        }
        gl.clear_color(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    draw_grid::<S>(context, program, grid)?;
    glu::expect_no_error(gl, "draw")?;

    result.read_pixels(context, x_offset, y_offset)?;
    glu::expect_no_error(gl, "post render")
}

/// `ShaderRenderCase::computeVertexReference`
fn compute_vertex_reference<S: ShaderRenderCaseSpec>(
    context: &Context,
    spec: &S,
    grid: &QuadGrid,
    result: &mut InternalSurface<'_>,
) {
    let width = result.width();
    let height = result.height();
    let grid_size = grid.grid_size();
    let stride = grid_size + 1;
    let has_alpha = context.render_target().alpha_bits > 0;
    let mut ctx = ShaderEvalContext::new(grid.const_coords());

    let mut colors = vec![Vec4::splat(0.0); ((grid_size + 1) * (grid_size + 1)) as usize];
    for y in 0..grid_size + 1 {
        for x in 0..grid_size + 1 {
            let sx = x as f32 / grid_size as f32;
            let sy = y as f32 / grid_size as f32;

            ctx.reset(grid, sx, sy);
            spec.evaluate(&mut ctx);
            debug_assert!(!ctx.is_discarded, "discard is not available in a vertex shader");

            let mut color = ctx.color;
            if !has_alpha {
                color[3] = 1.0;
            }
            // Quantizing for 1-bit alpha, which the Khronos copy does.
            if spec.khronos() && context.render_target().alpha_bits == 1 {
                color[3] = (color[3] + 0.5).floor();
            }
            colors[((y * (grid_size + 1)) + x) as usize] = color;
        }
    }

    for y in 0..grid_size {
        for x in 0..grid_size {
            let x0 = x as f32 / grid_size as f32;
            let x1 = (x + 1) as f32 / grid_size as f32;
            let y0 = y as f32 / grid_size as f32;
            let y1 = (y + 1) as f32 / grid_size as f32;

            let sx0 = x0 * width as f32;
            let sx1 = x1 * width as f32;
            let sy0 = y0 * height as f32;
            let sy1 = y1 * height as f32;
            let oosx = 1.0 / (sx1 - sx0);
            let oosy = 1.0 / (sy1 - sy0);

            let ix0 = (sx0 - 0.5).ceil() as i32;
            let ix1 = (sx1 - 0.5).ceil() as i32;
            let iy0 = (sy0 - 0.5).ceil() as i32;
            let iy1 = (sy1 - 0.5).ceil() as i32;

            let c00 = colors[((y * stride) + x) as usize];
            let c01 = colors[((y * stride) + x + 1) as usize];
            let c10 = colors[(((y + 1) * stride) + x) as usize];
            let c11 = colors[(((y + 1) * stride) + x + 1) as usize];

            for iy in iy0..iy1 {
                for ix in ix0..ix1 {
                    let sfx = ix as f32 + 0.5;
                    let sfy = iy as f32 + 0.5;
                    let fx1 = ((sfx - sx0) * oosx).clamp(0.0, 1.0);
                    let fy1 = ((sfy - sy0) * oosy).clamp(0.0, 1.0);

                    // Triangle quad interpolation.
                    let tri = fx1 + fy1 <= 1.0;
                    let tx = if tri { fx1 } else { 1.0 - fx1 };
                    let ty = if tri { fy1 } else { 1.0 - fy1 };
                    let t0 = if tri { c00 } else { c11 };
                    let t1 = if tri { c01 } else { c10 };
                    let t2 = if tri { c10 } else { c01 };
                    let color = t0 + (t1 - t0) * tx + (t2 - t0) * ty;

                    result.set_pixel(ix, iy, color);
                }
            }
        }
    }
}

/// `ShaderRenderCase::computeFragmentReference`
fn compute_fragment_reference<S: ShaderRenderCaseSpec>(
    context: &Context,
    spec: &S,
    grid: &QuadGrid,
    result: &mut InternalSurface<'_>,
) {
    let width = result.width();
    let height = result.height();
    let has_alpha = context.render_target().alpha_bits > 0;
    let mut ctx = ShaderEvalContext::new(grid.const_coords());

    for y in 0..height {
        for x in 0..width {
            let sx = (x as f32 + 0.5) / width as f32;
            let sy = (y as f32 + 0.5) / height as f32;

            ctx.reset(grid, sx, sy);
            spec.evaluate(&mut ctx);

            let mut color = if ctx.is_discarded {
                default_clear_color(spec)
            } else {
                ctx.color
            };
            if !has_alpha {
                color[3] = 1.0;
            }
            // Quantizing for 1-bit alpha, which the Khronos copy does.
            if spec.khronos() && context.render_target().alpha_bits == 1 {
                color[3] = (color[3] + 0.5).floor();
            }
            result.set_pixel(x, y, color);
        }
    }
}

/// `gls::getIntUniformName`
pub fn get_int_uniform_name(number: i32) -> &'static str {
    match number {
        0 => "ui_zero",
        1 => "ui_one",
        2 => "ui_two",
        3 => "ui_three",
        4 => "ui_four",
        5 => "ui_five",
        6 => "ui_six",
        7 => "ui_seven",
        8 => "ui_eight",
        101 => "ui_oneHundredOne",
        _ => unreachable!("no int uniform for {number}"),
    }
}

/// `gls::getFloatUniformName`
pub fn get_float_uniform_name(number: i32) -> &'static str {
    match number {
        0 => "uf_zero",
        1 => "uf_one",
        2 => "uf_two",
        3 => "uf_three",
        4 => "uf_four",
        5 => "uf_five",
        6 => "uf_six",
        7 => "uf_seven",
        8 => "uf_eight",
        _ => unreachable!("no float uniform for {number}"),
    }
}

/// `gls::getFloatFractionUniformName`
pub fn get_float_fraction_uniform_name(number: i32) -> &'static str {
    match number {
        1 => "uf_one",
        2 => "uf_half",
        3 => "uf_third",
        4 => "uf_fourth",
        5 => "uf_fifth",
        6 => "uf_sixth",
        7 => "uf_seventh",
        8 => "uf_eighth",
        _ => unreachable!("no float fraction uniform for {number}"),
    }
}

/// The location of `name` in `program`, or -1 when the shader does not use it.
fn uniform_location(context: &Context, program: GLuint, name: &str) -> GLint {
    let cname = std::ffi::CString::new(name).expect("no interior NUL");
    // SAFETY: a NUL-terminated name and a program the caller built.
    unsafe { context.gl().get_uniform_location(program, cname.as_ptr()) }
}

const BOOL_UNIFORMS: &[(&str, bool)] = &[("ub_true", true), ("ub_false", false)];
const BVEC4_UNIFORMS: &[(&str, bool)] = &[("ub4_true", true), ("ub4_false", false)];
const INT_UNIFORMS: &[(&str, i32)] = &[
    ("ui_minusOne", -1),
    ("ui_zero", 0),
    ("ui_one", 1),
    ("ui_two", 2),
    ("ui_three", 3),
    ("ui_four", 4),
    ("ui_five", 5),
    ("ui_six", 6),
    ("ui_seven", 7),
    ("ui_eight", 8),
    ("ui_oneHundredOne", 101),
];
const IVEC_UNIFORMS: &[(&str, i32)] = &[
    ("minusOne", -1),
    ("zero", 0),
    ("one", 1),
    ("two", 2),
    ("four", 4),
    ("five", 5),
];
const FLOAT_UNIFORMS: &[(&str, f32)] = &[
    ("uf_zero", 0.0),
    ("uf_one", 1.0),
    ("uf_two", 2.0),
    ("uf_three", 3.0),
    ("uf_four", 4.0),
    ("uf_five", 5.0),
    ("uf_six", 6.0),
    ("uf_seven", 7.0),
    ("uf_eight", 8.0),
    ("uf_half", 1.0 / 2.0),
    ("uf_third", 1.0 / 3.0),
    ("uf_fourth", 1.0 / 4.0),
    ("uf_fifth", 1.0 / 5.0),
    ("uf_sixth", 1.0 / 6.0),
    ("uf_seventh", 1.0 / 7.0),
    ("uf_eighth", 1.0 / 8.0),
];
const VEC_UNIFORMS: &[(&str, f32)] = &[
    ("minusOne", -1.0),
    ("zero", 0.0),
    ("half", 0.5),
    ("one", 1.0),
    ("two", 2.0),
];
const VEC4_COLOR_UNIFORMS: &[(&str, [f32; 4])] = &[
    ("uv4_black", [0.0, 0.0, 0.0, 1.0]),
    ("uv4_gray", [0.5, 0.5, 0.5, 1.0]),
    ("uv4_white", [1.0, 1.0, 1.0, 1.0]),
];

/// `gls::setupDefaultUniforms`
pub fn setup_default_uniforms(context: &Context, program: GLuint) {
    let gl = context.gl();

    for &(name, value) in BOOL_UNIFORMS {
        let loc = uniform_location(context, program, name);
        if loc != -1 {
            // SAFETY: a location in this program, and a scalar matching the uniform's type.
            unsafe { gl.uniform_1i(loc, value as GLint) };
        }
    }

    for &(name, value) in BVEC4_UNIFORMS {
        let loc = uniform_location(context, program, name);
        if loc != -1 {
            let arr = [value as GLint; 4];
            // SAFETY: as above; the pointer covers the four ints the call reads.
            unsafe { gl.uniform_4iv(loc, 1, arr.as_ptr()) };
        }
    }

    for &(name, value) in INT_UNIFORMS {
        let loc = uniform_location(context, program, name);
        if loc != -1 {
            // SAFETY: as above.
            unsafe { gl.uniform_1i(loc, value) };
        }
    }

    for &(suffix, value) in IVEC_UNIFORMS {
        for size in 2..=4usize {
            let loc = uniform_location(context, program, &format!("ui{size}_{suffix}"));
            if loc == -1 {
                continue;
            }
            let arr = [value; 4];
            // SAFETY: as above; the pointer covers at least `size` ints.
            unsafe {
                match size {
                    2 => gl.uniform_2iv(loc, 1, arr.as_ptr()),
                    3 => gl.uniform_3iv(loc, 1, arr.as_ptr()),
                    _ => gl.uniform_4iv(loc, 1, arr.as_ptr()),
                }
            }
        }
    }

    for &(name, value) in FLOAT_UNIFORMS {
        let loc = uniform_location(context, program, name);
        if loc != -1 {
            // SAFETY: as above.
            unsafe { gl.uniform_1f(loc, value) };
        }
    }

    for &(suffix, value) in VEC_UNIFORMS {
        for size in 2..=4usize {
            let loc = uniform_location(context, program, &format!("uv{size}_{suffix}"));
            if loc == -1 {
                continue;
            }
            let arr = [value; 4];
            // SAFETY: as above; the pointer covers at least `size` floats.
            unsafe {
                match size {
                    2 => gl.uniform_2fv(loc, 1, arr.as_ptr()),
                    3 => gl.uniform_3fv(loc, 1, arr.as_ptr()),
                    _ => gl.uniform_4fv(loc, 1, arr.as_ptr()),
                }
            }
        }
    }

    for &(name, value) in VEC4_COLOR_UNIFORMS {
        let loc = uniform_location(context, program, name);
        if loc != -1 {
            // SAFETY: as above.
            unsafe { gl.uniform_4fv(loc, 1, value.as_ptr()) };
        }
    }
}

/// `ShaderEvalContext::texture2D` is not reachable without `TextureBinding`; this keeps
/// the signature reserved so a ported texture case does not invent a different one.
pub fn texture2d_unsupported(_unit_ndx: i32, _coords: Vec2) -> Vec4 {
    unreachable!("TextureBinding is not ported - see the note at the top of this file")
}

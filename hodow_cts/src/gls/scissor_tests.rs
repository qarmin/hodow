// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsScissorTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `ScissorClearCase` (upstream's `createClearTest`, the `clear_depth`/`clear_stencil`/
// `clear_color` shape - 3 cases on each of GLES2/GLES3), `ScissorPrimitiveCase`
// (upstream's `createPrimitiveTest` - 14 cases on each of GLES2/GLES3),
// `FramebufferClearCase` (upstream's `createFramebufferClearTest` - 6 cases, GLES3
// only) and `FramebufferBlitCase` (upstream's `createFramebufferBlitTest` - 3 cases,
// GLES3 only) are all ported, closing the group entirely (17/17 GLES2, 26/26 GLES3).
//
// None of this needs `sglr::ReferenceContext`/`rr::Renderer` - every case here draws
// into the real default framebuffer (or, for the two Framebuffer* cases, its own
// small offscreen FBO) twice, once with `GL_SCISSOR_TEST` disabled and once enabled,
// then compares the two real readback images after manually "clearing" (`clear_edges`)
// whatever area the scissor rect should have left untouched in the reference - an
// analytical check against a real driver, the same shape
// `tcu::rasterization_verifier`/`draw_buffers_indexed_tests.rs` already use.

use crate::glu::objects::{Framebuffer, Renderbuffer};
use crate::glu::{self, Context, GlslVersion, ProgramSources, RenderTarget, ShaderProgram, TestCase};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare, pixel_threshold_compare};
use crate::tcu::pixel::{PixelBufferAccess, TextureLevel};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{IVec4, RGBA, Random, Surface, TestError, TestOutcome, TestStatus, UVec4, Vec4, de_string_hash};

/// `TextureTestUtil::RandomViewport` - a viewport of up to `preferred_width` x
/// `preferred_height` placed pseudo-randomly within the render target.
struct RandomViewport {
    x: i32,
    y: i32,
    width: i32,
    height: i32,
}

impl RandomViewport {
    fn new(render_target: &RenderTarget, preferred_width: i32, preferred_height: i32, seed: u32) -> Self {
        let width = preferred_width.min(render_target.width);
        let height = preferred_height.min(render_target.height);
        let mut rnd = Random::new(seed);
        let x = rnd.get_int(0, render_target.width - width);
        let y = rnd.get_int(0, render_target.height - height);
        Self { x, y, width, height }
    }
}

/// `clearEdges<T>` - stamps `color` over every pixel outside `scissor_area`, which is
/// already relative to `access` (i.e. the viewport's own offset has been subtracted
/// out by the caller).
fn clear_edges(access: &mut Surface, color: RGBA, scissor_area: IVec4) {
    for y in 0..access.get_height() {
        for x in 0..access.get_width() {
            if y < scissor_area.y()
                || y >= scissor_area.y() + scissor_area.w()
                || x < scissor_area.x()
                || x >= scissor_area.x() + scissor_area.z()
            {
                access.set_pixel(x, y, color);
            }
        }
    }
}

/// `genShaders` - a flat-colour program driven by `u_color`. `is_point` sets
/// `gl_PointSize` to 1.0, which only `ScissorPrimitiveCase`'s `PrimitiveType::Point`
/// cases need, but is kept on the shared signature since every case shape goes
/// through the same `run_scissor_case`.
fn gen_shaders(glsl_version: GlslVersion, is_point: bool) -> ProgramSources {
    let (version, in_, out_decl, output) = match glsl_version {
        GlslVersion::Es100 => ("#version 100", "attribute", "", "gl_FragColor"),
        // "Assumed to support 3.0" - matches upstream's own GLSL_VERSION_300_ES/310_ES
        // fallthrough.
        _ => ("#version 300 es", "in", "out mediump vec4 f_color;\n", "f_color"),
    };

    let point_size_line = if is_point { "    gl_PointSize = 1.0;\n" } else { "" };
    let vertex = format!(
        "{version}\n{in_} highp vec4 a_position;\nvoid main(){{\n    gl_Position = a_position;\n{point_size_line}}}\n"
    );
    let fragment =
        format!("{version}\n{out_decl}uniform highp vec4 u_color;\nvoid main(){{\n    {output} = u_color;\n}}\n");

    ProgramSources::vtx_frag(vertex, fragment)
}

/// `ScissorTestInternal::PrimitiveType` - `POINT = 0, LINE, TRIANGLE` upstream (the
/// fourth array slot every upstream lookup table carries, `quadPositions`, is never
/// indexed by a value this enum can hold and is dropped here rather than ported dead).
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum PrimitiveType {
    Point,
    Line,
    Triangle,
}

/// `drawPrimitives` - the indexed-draw sibling of `draw_quad`, parameterized over the
/// GL primitive type and a caller-built position/index buffer.
fn draw_primitives(gl: &glw::Functions, program: GLuint, gl_type: GLenum, positions: &[f32], indices: &[u16]) {
    // SAFETY: `positions`/`indices` outlive the one draw call reading them below.
    unsafe {
        let pos_loc = gl.get_attrib_location(program, c"a_position".as_ptr());
        assert!(pos_loc >= 0);
        let pos_loc = pos_loc as u32;

        gl.use_program(program);
        gl.enable_vertex_attrib_array(pos_loc);
        gl.vertex_attrib_pointer(pos_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, positions.as_ptr().cast());
        gl.draw_elements(
            gl_type,
            indices.len() as i32,
            glw::GL_UNSIGNED_SHORT,
            indices.as_ptr().cast(),
        );
        gl.disable_vertex_attrib_array(pos_loc);
    }
}

/// `drawQuad` - two triangles over `p0`..`p1`, sharing `a_position`'s hard-wired
/// location-free lookup (upstream looks the attribute up by name every call too).
fn draw_quad(gl: &glw::Functions, program: GLuint, p0: [f32; 3], p1: [f32; 3]) {
    let hz = (p0[2] + p1[2]) * 0.5;
    #[rustfmt::skip]
    let position: [f32; 16] = [
        p0[0], p0[1], p0[2], 1.0,
        p0[0], p1[1], hz,    1.0,
        p1[0], p0[1], hz,    1.0,
        p1[0], p1[1], p1[2], 1.0,
    ];
    let indices: [u16; 6] = [0, 1, 2, 2, 1, 3];

    // SAFETY: `position`/`indices` outlive the one draw call reading them below.
    unsafe {
        let pos_loc = gl.get_attrib_location(program, c"a_position".as_ptr()) as u32;
        gl.use_program(program);
        gl.enable_vertex_attrib_array(pos_loc);
        gl.vertex_attrib_pointer(pos_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, position.as_ptr().cast());
        gl.draw_elements(
            glw::GL_TRIANGLES,
            indices.len() as i32,
            glw::GL_UNSIGNED_SHORT,
            indices.as_ptr().cast(),
        );
        gl.disable_vertex_attrib_array(pos_loc);
    }
}

/// `ScissorCase::iterate` - the shared wrapper/reporting logic every case shape is
/// built on top of. `render` draws into whatever is currently bound (the default
/// framebuffer for every case here but `FramebufferBlitCase`, which blits from its own
/// offscreen FBO into it), with and without `GL_SCISSOR_TEST`; the caller has already
/// bound the program and is free to set its own uniforms. The third argument is the
/// real viewport rect (`x, y, width, height`) - unused by `ScissorClearCase`/
/// `ScissorPrimitiveCase`, but `FramebufferBlitCase::render` needs it as its blit
/// destination, exactly like upstream's shared `render(GLuint program, const IVec4&
/// viewport)` signature.
fn run_scissor_case(
    context: &Context,
    name: &str,
    scissor_area: Vec4,
    is_point: bool,
    render: impl Fn(&glw::Functions, GLuint, IVec4),
) -> TestOutcome {
    let gl = context.gl();
    let render_target = context.render_target();
    let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);

    let shader = ShaderProgram::new(gl, &gen_shaders(context.context_type().glsl_version(), is_point));
    if !shader.is_ok() {
        return Ok(TestStatus::fail("Shader compile/link failed"));
    }
    let program = shader.program();

    let viewport = RandomViewport::new(&render_target, 256, 256, de_string_hash(name));
    let rel_scissor = IVec4::new(
        (scissor_area.x() * viewport.width as f32) as i32,
        (scissor_area.y() * viewport.height as f32) as i32,
        (scissor_area.z() * viewport.width as f32) as i32,
        (scissor_area.w() * viewport.height as f32) as i32,
    );
    let abs_scissor = IVec4::new(
        rel_scissor.x() + viewport.x,
        rel_scissor.y() + viewport.y,
        rel_scissor.z(),
        rel_scissor.w(),
    );

    let mut ref_image = Surface::new(viewport.width, viewport.height);
    let mut res_image = Surface::new(viewport.width, viewport.height);

    // Render reference (scissor disabled).
    // SAFETY: a current context, static enum arguments.
    unsafe {
        gl.use_program(program);
        gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
        gl.clear_color(0.125, 0.25, 0.5, 1.0);
        gl.clear_depthf(1.0);
        gl.clear_stencil(0);
        gl.disable(glw::GL_DEPTH_TEST);
        gl.disable(glw::GL_STENCIL_TEST);
        gl.disable(glw::GL_SCISSOR_TEST);
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
    }
    let viewport_rect = IVec4::new(viewport.x, viewport.y, viewport.width, viewport.height);
    render(gl, program, viewport_rect);
    glu::read_pixels(
        &context.render_context,
        viewport.x,
        viewport.y,
        &mut ref_image.get_access(),
    )?;

    // Render result (scissor enabled).
    // SAFETY: as above.
    unsafe {
        gl.use_program(program);
        gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
        gl.clear_color(0.125, 0.25, 0.5, 1.0);
        gl.clear_depthf(1.0);
        gl.clear_stencil(0);
        gl.disable(glw::GL_DEPTH_TEST);
        gl.disable(glw::GL_STENCIL_TEST);
        gl.disable(glw::GL_SCISSOR_TEST);
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        gl.scissor(abs_scissor.x(), abs_scissor.y(), abs_scissor.z(), abs_scissor.w());
        gl.enable(glw::GL_SCISSOR_TEST);
    }
    render(gl, program, viewport_rect);
    glu::read_pixels(
        &context.render_context,
        viewport.x,
        viewport.y,
        &mut res_image.get_access(),
    )?;

    // Manual 'scissor' for the reference image.
    clear_edges(&mut ref_image, RGBA::new(32, 64, 128, 255), rel_scissor);

    let comparison = pixel_threshold_compare(&ref_image, &res_image, threshold);
    if comparison.ok {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Image comparison failed"))
    }
}

/// `ScissorClearCase` - tests the effect of scissor on default-framebuffer clears.
pub struct ScissorClearCase {
    name: &'static str,
    scissor_area: Vec4,
    /// Combination of the flags accepted by `glClear`.
    clear_mode: GLenum,
}

impl TestCase for ScissorClearCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_target = context.render_target();

        // `ScissorClearCase::init`.
        if (self.clear_mode & glw::GL_DEPTH_BUFFER_BIT) != 0 && render_target.depth_bits == 0 {
            return Err(TestError::NotSupported(
                "Cannot clear depth; no depth buffer present".to_string(),
            ));
        }
        if (self.clear_mode & glw::GL_STENCIL_BUFFER_BIT) != 0 && render_target.stencil_bits == 0 {
            return Err(TestError::NotSupported(
                "Cannot clear stencil; no stencil buffer present".to_string(),
            ));
        }

        let clear_mode = self.clear_mode;
        run_scissor_case(
            context,
            self.name,
            self.scissor_area,
            false,
            move |gl, program, _viewport| {
                let white: [f32; 4] = [1.0, 1.0, 1.0, 1.0];

                // SAFETY: a current context, static enum arguments.
                unsafe {
                    gl.clear_color(0.6, 0.1, 0.1, 1.0);
                    gl.clear_depthf(0.0);

                    if (clear_mode & glw::GL_DEPTH_BUFFER_BIT) != 0 {
                        gl.enable(glw::GL_DEPTH_TEST);
                        gl.depth_func(glw::GL_GREATER);
                    }

                    if (clear_mode & glw::GL_STENCIL_BUFFER_BIT) != 0 {
                        gl.clear_stencil(123);
                        gl.enable(glw::GL_STENCIL_TEST);
                        gl.stencil_func(glw::GL_EQUAL, 123, !0u32);
                    }

                    if (clear_mode & glw::GL_COLOR_BUFFER_BIT) != 0 {
                        gl.clear_color(0.1, 0.6, 0.1, 1.0);
                    }

                    gl.clear(clear_mode);
                    gl.disable(glw::GL_SCISSOR_TEST);

                    let color_loc = gl.get_uniform_location(program, c"u_color".as_ptr());
                    gl.uniform_4fv(color_loc, 1, white.as_ptr());

                    if (clear_mode & glw::GL_COLOR_BUFFER_BIT) == 0 {
                        draw_quad(gl, program, [-1.0, -1.0, 0.5], [1.0, 1.0, 0.5]);
                    }

                    gl.disable(glw::GL_DEPTH_TEST);
                    gl.disable(glw::GL_STENCIL_TEST);
                }
            },
        )
    }
}

/// The position/index-buffer-building half of `ScissorPrimitiveCase::render`, split out
/// from the GL calls below so the pure math is unit-testable on its own. Note
/// `primitiveArea`'s y-origin reuses `render_area.x()` rather than `render_area.y()` in
/// upstream's own source (confirmed against the real `.cpp`, not a transcription slip
/// here) - preserved verbatim per this port's own conventions. Every case registered by
/// either API happens to pass a `render_area` with `x() == y()`, so the bug is
/// invisible across the whole mustpass; see QUIRKS.md.
fn build_primitive_geometry(
    render_area: Vec4,
    primitive_type: PrimitiveType,
    primitive_count: i32,
) -> (Vec<f32>, Vec<u16>) {
    let primitive_area = Vec4::new(
        render_area.x() * 2.0 - 1.0,
        render_area.x() * 2.0 - 1.0,
        render_area.z() * 2.0,
        render_area.w() * 2.0,
    );

    const TRI_POSITIONS: [f32; 6] = [0.0, 0.0, 1.0, 0.0, 0.5, 1.0];
    const LINE_POSITIONS: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
    const POINT_POSITION: [f32; 2] = [0.5, 0.5];
    const BASE_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

    let (base_positions, vertex_count, index_count): (&[f32], usize, usize) = match primitive_type {
        PrimitiveType::Point => (&POINT_POSITION, 1, 1),
        PrimitiveType::Line => (&LINE_POSITIONS, 2, 2),
        PrimitiveType::Triangle => (&TRI_POSITIONS, 3, 3),
    };

    let primitive_count = primitive_count as usize;
    // Magic value to roughly fill the render area with primitives at a readable density.
    let scale = 1.44 / (primitive_count as f32 * 2.0).sqrt();
    let mut positions = vec![0.0f32; 4 * vertex_count * primitive_count];
    let mut indices = vec![0u16; index_count * primitive_count];
    let mut rng = Random::new(1234);

    for prim_ndx in 0..primitive_count {
        let dx = if primitive_count > 1 { rng.get_float() } else { 0.0 };
        let dy = if primitive_count > 1 { rng.get_float() } else { 0.0 };

        for vert_ndx in 0..vertex_count {
            let ndx = prim_ndx * 4 * vertex_count + vert_ndx * 4;
            positions[ndx] = (base_positions[vert_ndx * 2] * scale + dx) * primitive_area.z() + primitive_area.x();
            positions[ndx + 1] =
                (base_positions[vert_ndx * 2 + 1] * scale + dy) * primitive_area.w() + primitive_area.y();
            positions[ndx + 2] = 0.2;
            positions[ndx + 3] = 1.0;
        }

        for ndx in 0..index_count {
            indices[prim_ndx * index_count + ndx] = BASE_INDICES[ndx] + (prim_ndx * vertex_count) as u16;
        }
    }

    (positions, indices)
}

/// `ScissorPrimitiveCase::render` - sets the uniform and draws, once the geometry is built.
fn render_primitive(
    gl: &glw::Functions,
    program: GLuint,
    render_area: Vec4,
    primitive_type: PrimitiveType,
    primitive_count: i32,
) {
    let white: [f32; 4] = [1.0, 1.0, 1.0, 1.0];
    let (positions, indices) = build_primitive_geometry(render_area, primitive_type, primitive_count);

    // SAFETY: a current context, `program` already in use (by `run_scissor_case`).
    unsafe {
        let color_loc = gl.get_uniform_location(program, c"u_color".as_ptr());
        gl.uniform_4fv(color_loc, 1, white.as_ptr());
    }

    let gl_type = match primitive_type {
        PrimitiveType::Triangle => glw::GL_TRIANGLES,
        PrimitiveType::Line => glw::GL_LINES,
        PrimitiveType::Point => glw::GL_POINTS,
    };
    draw_primitives(gl, program, gl_type, &positions, &indices);
}

/// `ScissorPrimitiveCase` - draws `primitive_count` instances of one primitive type at
/// pseudo-random jittered positions within `render_area`, with and without scissor.
/// The jitter RNG is seeded with the fixed literal `1234`, *not* `de_string_hash(name)`
/// like `RandomViewport` above - confirmed by reading `ScissorPrimitiveCase::render`
/// directly, where `de::Random rng(1234)` is a local, unrelated to the viewport's own
/// per-case seed.
pub struct ScissorPrimitiveCase {
    name: &'static str,
    scissor_area: Vec4,
    render_area: Vec4,
    primitive_type: PrimitiveType,
    primitive_count: i32,
}

impl TestCase for ScissorPrimitiveCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_area = self.render_area;
        let primitive_type = self.primitive_type;
        let primitive_count = self.primitive_count;
        run_scissor_case(
            context,
            self.name,
            self.scissor_area,
            primitive_type == PrimitiveType::Point,
            move |gl, program, _viewport| {
                render_primitive(gl, program, render_area, primitive_type, primitive_count);
            },
        )
    }
}

/// `ScissorTestInternal::createPrimitiveTest`
pub fn scissor_primitive_case(
    name: &'static str,
    scissor_area: Vec4,
    render_area: Vec4,
    primitive_type: PrimitiveType,
    primitive_count: i32,
) -> Box<dyn TestCase> {
    Box::new(ScissorPrimitiveCase {
        name,
        scissor_area,
        render_area,
        primitive_type,
        primitive_count,
    })
}

/// `ScissorTestInternal::createClearTest` x3 - upstream's own three registered
/// `ScissorClearCase`s, shared verbatim by both `es2fScissorTests.cpp` and
/// `es3fScissorTests.cpp` (identical name/desc/scissor-area/clear-mode on both APIs).
pub fn create_clear_tests() -> Vec<Box<dyn TestCase>> {
    const SCISSOR_AREA: Vec4 = Vec4::new(0.1, 0.1, 0.8, 0.8);

    vec![
        Box::new(ScissorClearCase {
            name: "clear_depth",
            scissor_area: SCISSOR_AREA,
            clear_mode: glw::GL_DEPTH_BUFFER_BIT,
        }),
        Box::new(ScissorClearCase {
            name: "clear_stencil",
            scissor_area: SCISSOR_AREA,
            clear_mode: glw::GL_STENCIL_BUFFER_BIT,
        }),
        Box::new(ScissorClearCase {
            name: "clear_color",
            scissor_area: SCISSOR_AREA,
            clear_mode: glw::GL_COLOR_BUFFER_BIT,
        }),
    ]
}

/// `ScissorTestInternal::ClearType` - `CLEAR_COLOR_FLOAT` is dropped: upstream's own
/// `getBufferFormat` hits a `DE_FATAL("Floating point clear not implemented")` for it
/// and it is never registered by either `es3fScissorTests.cpp`'s `init()` (the only
/// registrar of `FramebufferClearCase`), so it is genuinely dead code upstream, not
/// something this port is choosing to skip.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ClearType {
    ColorFixed,
    ColorInt,
    ColorUint,
    Depth,
    Stencil,
    DepthStencil,
}

/// `ScissorTestInternal::Color` (the anonymous-namespace `Color` struct in
/// `glsScissorTests.cpp`) - a clear/compare value tagged with which `glClearBuffer*v`
/// variant and comparator it needs.
#[derive(Clone, Copy)]
enum Color {
    Float([f32; 4]),
    Int([i32; 4]),
    Uint([u32; 4]),
}

/// `BufferFmtDesc`
#[derive(Clone, Copy)]
struct BufferFmtDesc {
    tex_fmt: TextureFormat,
    color_fmt: GLenum,
}

/// `FramebufferClearCase::getBaseColor` - the colour the buffer is cleared to before
/// `render` runs, i.e. what a correctly-scissored edge should still read back as.
fn get_base_color(buffer_fmt: BufferFmtDesc) -> Color {
    match buffer_fmt.color_fmt {
        glw::GL_RGBA8 => Color::Float([0.125, 0.25, 0.5, 1.0]),
        glw::GL_RGBA8I => Color::Int([0, 0, 0, 0]),
        glw::GL_RGBA8UI => Color::Uint([0, 0, 0, 0]),
        _ => unreachable!("getBufferFormat only ever returns one of the three color_fmt values above"),
    }
}

/// `FramebufferClearCase::getMainColor` - the colour `render`'s own clear writes
/// inside the scissor rect.
fn get_main_color(buffer_fmt: BufferFmtDesc) -> Color {
    match buffer_fmt.color_fmt {
        glw::GL_RGBA8 => Color::Float([1.0, 1.0, 0.5, 1.0]),
        glw::GL_RGBA8I => Color::Int([127, -127, 0, 127]),
        glw::GL_RGBA8UI => Color::Uint([255, 255, 0, 255]),
        _ => unreachable!("getBufferFormat only ever returns one of the three color_fmt values above"),
    }
}

/// `FramebufferClearCase::getBufferFormat`
fn get_buffer_format(clear_type: ClearType) -> BufferFmtDesc {
    match clear_type {
        ClearType::ColorInt => BufferFmtDesc {
            color_fmt: glw::GL_RGBA8I,
            tex_fmt: TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
        },
        ClearType::ColorUint => BufferFmtDesc {
            color_fmt: glw::GL_RGBA8UI,
            tex_fmt: TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32),
        },
        ClearType::ColorFixed | ClearType::Depth | ClearType::Stencil | ClearType::DepthStencil => BufferFmtDesc {
            color_fmt: glw::GL_RGBA8,
            tex_fmt: TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        },
    }
}

/// `FramebufferClearCase::clearBuffers` - the shared "clear colour + depth + stencil"
/// call both the reference and result render use to reset the FBO before `render`.
/// SAFETY: a current context with the FBO this case built already bound.
unsafe fn clear_framebuffer_buffers(gl: &glw::Functions, color: Color, depth: f32, stencil: i32) {
    unsafe {
        match color {
            Color::Float(f) => gl.clear_bufferfv(glw::GL_COLOR, 0, f.as_ptr()),
            Color::Int(i) => gl.clear_bufferiv(glw::GL_COLOR, 0, i.as_ptr()),
            Color::Uint(u) => gl.clear_bufferuiv(glw::GL_COLOR, 0, u.as_ptr()),
        }
        gl.clear_bufferfv(glw::GL_DEPTH, 0, &depth);
        gl.clear_bufferiv(glw::GL_STENCIL, 0, &stencil);
    }
}

/// `FramebufferClearCase::render` - exercises exactly the one `glClearBuffer*`
/// `clear_type` names, plus (for the depth/stencil variants) a quad drawn with
/// `GL_GREATER`/`GL_EQUAL` so the buffer-clear's effect is visible in the colour
/// readback rather than only in state nothing here reads back directly.
fn render_framebuffer_clear(gl: &glw::Functions, program: GLuint, clear_type: ClearType, buffer_fmt: BufferFmtDesc) {
    let clear_color = get_main_color(buffer_fmt);
    const CLEAR_STENCIL: i32 = 123;
    const CLEAR_DEPTH: f32 = 0.5;

    // SAFETY: a current context, the FBO this case built already bound.
    unsafe {
        match clear_type {
            ClearType::ColorFixed => match clear_color {
                Color::Float(f) => gl.clear_bufferfv(glw::GL_COLOR, 0, f.as_ptr()),
                _ => unreachable!("ColorFixed's buffer format is always GL_RGBA8"),
            },
            ClearType::ColorInt => match clear_color {
                Color::Int(i) => gl.clear_bufferiv(glw::GL_COLOR, 0, i.as_ptr()),
                _ => unreachable!("ColorInt's buffer format is always GL_RGBA8I"),
            },
            ClearType::ColorUint => match clear_color {
                Color::Uint(u) => gl.clear_bufferuiv(glw::GL_COLOR, 0, u.as_ptr()),
                _ => unreachable!("ColorUint's buffer format is always GL_RGBA8UI"),
            },
            ClearType::Depth => gl.clear_bufferfv(glw::GL_DEPTH, 0, &CLEAR_DEPTH),
            ClearType::Stencil => gl.clear_bufferiv(glw::GL_STENCIL, 0, &CLEAR_STENCIL),
            ClearType::DepthStencil => gl.clear_bufferfi(glw::GL_DEPTH_STENCIL, 0, CLEAR_DEPTH, CLEAR_STENCIL),
        }
    }

    let use_depth = matches!(clear_type, ClearType::Depth | ClearType::DepthStencil);
    let use_stencil = matches!(clear_type, ClearType::Stencil | ClearType::DepthStencil);

    if use_depth || use_stencil {
        let Color::Float(clear_color_f) = clear_color else {
            unreachable!("Depth/Stencil/DepthStencil always use GL_RGBA8's Color::Float");
        };
        // SAFETY: as above.
        unsafe {
            if use_depth {
                gl.enable(glw::GL_DEPTH_TEST);
            }
            if use_stencil {
                gl.enable(glw::GL_STENCIL_TEST);
            }
            gl.stencil_func(glw::GL_EQUAL, CLEAR_STENCIL, !0u32);
            gl.depth_func(glw::GL_GREATER);
            gl.disable(glw::GL_SCISSOR_TEST);

            let color_loc = gl.get_uniform_location(program, c"u_color".as_ptr());
            gl.uniform_4fv(color_loc, 1, clear_color_f.as_ptr());
            draw_quad(gl, program, [-1.0, -1.0, 0.6], [1.0, 1.0, 0.6]);
        }
    }
}

/// `clearEdges<Vec4>` - the float-valued flavour of the shared `clear_edges` above,
/// for a `PixelBufferAccess`-backed readback rather than a `Surface`.
fn clear_edges_access_float(access: &mut PixelBufferAccess<'_>, color: [f32; 4], scissor_area: IVec4) {
    let [width, height, _] = access.size();
    for y in 0..height {
        for x in 0..width {
            let (xi, yi) = (x as i32, y as i32);
            if yi < scissor_area.y()
                || yi >= scissor_area.y() + scissor_area.w()
                || xi < scissor_area.x()
                || xi >= scissor_area.x() + scissor_area.z()
            {
                access.set_pixel(color, x, y, 0);
            }
        }
    }
}

/// `clearEdges<IVec4>`/`clearEdges<UVec4>` - the integer-valued flavour. `UVec4`
/// callers narrow through `i32` first; every value either channel class uses here
/// (`0`, `255`, `127`, `-127`) fits losslessly in both directions.
fn clear_edges_access_int(access: &mut PixelBufferAccess<'_>, color: [i32; 4], scissor_area: IVec4) {
    let [width, height, _] = access.size();
    for y in 0..height {
        for x in 0..width {
            let (xi, yi) = (x as i32, y as i32);
            if yi < scissor_area.y()
                || yi >= scissor_area.y() + scissor_area.w()
                || xi < scissor_area.x()
                || xi >= scissor_area.x() + scissor_area.z()
            {
                let wrote = access.set_pixel_int(color, x, y, 0);
                debug_assert!(wrote, "RGBA8I/RGBA8UI are generic-path-writable channel types");
            }
        }
    }
}

/// `FramebufferClearCase` - clears one (colour or depth/stencil) buffer of its own
/// 64x64 offscreen FBO with and without scissor, comparing the two readbacks. Unlike
/// every case above, this does not go through `run_scissor_case`/the default
/// framebuffer at all - it is a standalone `tcu::TestCase` upstream, with a fixed
/// (not randomised) viewport and scissor rect.
pub struct FramebufferClearCase {
    name: &'static str,
    clear_type: ClearType,
}

impl TestCase for FramebufferClearCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let shader = ShaderProgram::new(gl, &gen_shaders(context.context_type().glsl_version(), false));
        if !shader.is_ok() {
            return Ok(TestStatus::fail("Shader compile/link failed"));
        }
        let program = shader.program();

        let fbo = Framebuffer::new(gl);
        let colorbuf = Renderbuffer::new(gl);
        let depthbuf = Renderbuffer::new(gl);

        let buffer_fmt = get_buffer_format(self.clear_type);
        let base_color = get_base_color(buffer_fmt);

        const WIDTH: i32 = 64;
        const HEIGHT: i32 = 64;
        let scissor_area = IVec4::new(8, 8, 48, 48);

        let mut ref_level = TextureLevel::new(buffer_fmt.tex_fmt, WIDTH as u32, HEIGHT as u32, 1)?;
        let mut res_level = TextureLevel::new(buffer_fmt.tex_fmt, WIDTH as u32, HEIGHT as u32, 1)?;

        // SAFETY: `fbo`/`colorbuf`/`depthbuf` are names this function owns and binds
        // exactly once each.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get());
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo.get());

            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, colorbuf.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, buffer_fmt.color_fmt, WIDTH, HEIGHT);
            gl.framebuffer_renderbuffer(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                colorbuf.get(),
            );

            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, depthbuf.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, WIDTH, HEIGHT);
            gl.framebuffer_renderbuffer(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_DEPTH_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                depthbuf.get(),
            );
        }
        glu::expect_no_error(gl, "Failed to set up the clear-case FBO")?;

        // Render reference (scissor disabled).
        // SAFETY: as above.
        unsafe {
            gl.use_program(program);
            gl.viewport(0, 0, WIDTH, HEIGHT);
            gl.disable(glw::GL_DEPTH_TEST);
            gl.disable(glw::GL_STENCIL_TEST);
            gl.disable(glw::GL_SCISSOR_TEST);
            clear_framebuffer_buffers(gl, base_color, 1.0, 0);
        }
        render_framebuffer_clear(gl, program, self.clear_type, buffer_fmt);
        glu::read_pixels(&context.render_context, 0, 0, &mut ref_level.get_access())?;
        glu::expect_no_error(gl, "Failed rendering reference")?;

        // Render result (scissor enabled).
        // SAFETY: as above.
        unsafe {
            gl.use_program(program);
            gl.viewport(0, 0, WIDTH, HEIGHT);
            gl.disable(glw::GL_DEPTH_TEST);
            gl.disable(glw::GL_STENCIL_TEST);
            gl.disable(glw::GL_SCISSOR_TEST);
            clear_framebuffer_buffers(gl, base_color, 1.0, 0);
            gl.enable(glw::GL_SCISSOR_TEST);
            gl.scissor(scissor_area.x(), scissor_area.y(), scissor_area.z(), scissor_area.w());
        }
        render_framebuffer_clear(gl, program, self.clear_type, buffer_fmt);
        glu::read_pixels(&context.render_context, 0, 0, &mut res_level.get_access())?;
        glu::expect_no_error(gl, "Failed rendering result")?;

        // SAFETY: as above.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
        }

        let ok = match base_color {
            Color::Float(f) => {
                clear_edges_access_float(&mut ref_level.get_access(), f, scissor_area);
                float_threshold_compare(
                    &ref_level.get_const_access(),
                    &res_level.get_const_access(),
                    [0.02, 0.02, 0.02, 0.02],
                )
                .ok
            }
            Color::Int(i) => {
                clear_edges_access_int(&mut ref_level.get_access(), i, scissor_area);
                int_threshold_compare(
                    &ref_level.get_const_access(),
                    &res_level.get_const_access(),
                    UVec4::new(2, 2, 2, 2),
                )
                .ok
            }
            Color::Uint(u) => {
                let i = [u[0] as i32, u[1] as i32, u[2] as i32, u[3] as i32];
                clear_edges_access_int(&mut ref_level.get_access(), i, scissor_area);
                int_threshold_compare(
                    &ref_level.get_const_access(),
                    &res_level.get_const_access(),
                    UVec4::new(2, 2, 2, 2),
                )
                .ok
            }
        };

        if ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

/// `ScissorTestInternal::createFramebufferClearTest` x6 - upstream's own six
/// registered `FramebufferClearCase`s (GLES3 only; `es2fScissorTests.cpp` never
/// registers this case shape at all).
pub fn create_framebuffer_clear_tests() -> Vec<Box<dyn TestCase>> {
    vec![
        Box::new(FramebufferClearCase {
            name: "clear_fixed_buffer",
            clear_type: ClearType::ColorFixed,
        }),
        Box::new(FramebufferClearCase {
            name: "clear_int_buffer",
            clear_type: ClearType::ColorInt,
        }),
        Box::new(FramebufferClearCase {
            name: "clear_uint_buffer",
            clear_type: ClearType::ColorUint,
        }),
        Box::new(FramebufferClearCase {
            name: "clear_depth_buffer",
            clear_type: ClearType::Depth,
        }),
        Box::new(FramebufferClearCase {
            name: "clear_stencil_buffer",
            clear_type: ClearType::Stencil,
        }),
        Box::new(FramebufferClearCase {
            name: "clear_depth_stencil_buffer",
            clear_type: ClearType::DepthStencil,
        }),
    ]
}

/// `FramebufferBlitCase` - blits a small offscreen FBO (always cleared to a fixed
/// colour) into the default framebuffer, with and without scissor, through
/// `run_scissor_case`'s own default-framebuffer reference/result wrapper - the one
/// case shape here that *does* reuse it despite not drawing geometry, since upstream
/// registers it as a plain `ScissorCase` subclass.
pub struct FramebufferBlitCase {
    name: &'static str,
    scissor_area: Vec4,
}

impl TestCase for FramebufferBlitCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if context.render_target().num_samples != 0 {
            return Err(TestError::NotSupported(
                "Cannot blit to multisampled framebuffer".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        const SIZE: i32 = 64;
        let clear_color: [f32; 4] = [1.0, 0.5, 0.125, 1.0];

        let fbo = Framebuffer::new(gl);
        let colorbuf = Renderbuffer::new(gl);

        // SAFETY: `fbo`/`colorbuf` are names this function owns and binds exactly
        // once each.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get());
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, colorbuf.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, SIZE, SIZE);
            gl.framebuffer_renderbuffer(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                colorbuf.get(),
            );
            gl.clear_bufferfv(glw::GL_COLOR, 0, clear_color.as_ptr());
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
        }
        glu::expect_no_error(gl, "Failed to set up the blit-case source FBO")?;

        run_scissor_case(
            context,
            self.name,
            self.scissor_area,
            false,
            move |gl, _program, viewport| {
                let width = viewport.z();
                let height = viewport.w();
                // SAFETY: `fbo` is kept alive by this closure for as long as
                // `run_scissor_case` calls it (twice, both within this function's call).
                unsafe {
                    gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo.get());
                    gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
                    gl.blit_framebuffer(
                        0,
                        0,
                        SIZE,
                        SIZE,
                        viewport.x(),
                        viewport.y(),
                        viewport.x() + width,
                        viewport.y() + height,
                        glw::GL_COLOR_BUFFER_BIT,
                        glw::GL_NEAREST,
                    );
                    gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
                }
            },
        )
    }
}

/// `ScissorTestInternal::createFramebufferBlitTest` x3 - upstream's own three
/// registered `FramebufferBlitCase`s (GLES3 only).
pub fn create_framebuffer_blit_tests() -> Vec<Box<dyn TestCase>> {
    vec![
        Box::new(FramebufferBlitCase {
            name: "framebuffer_blit_center",
            scissor_area: Vec4::new(0.1, 0.1, 0.8, 0.8),
        }),
        Box::new(FramebufferBlitCase {
            name: "framebuffer_blit_corner",
            scissor_area: Vec4::new(0.6, 0.6, 0.5, 0.5),
        }),
        Box::new(FramebufferBlitCase {
            name: "framebuffer_blit_none",
            scissor_area: Vec4::new(1.6, 0.6, 0.5, 0.5),
        }),
    ]
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn create_clear_tests_registers_exactly_the_three_upstream_names() {
        let cases = create_clear_tests();
        assert_eq!(cases.len(), 3);
        let mut names: Vec<String> = cases.iter().map(|c| c.name().to_string()).collect();
        names.sort();
        assert_eq!(
            names,
            vec![
                "clear_color".to_string(),
                "clear_depth".to_string(),
                "clear_stencil".to_string()
            ]
        );
    }

    #[test]
    fn build_primitive_geometry_sizes_buffers_by_vertex_and_index_count() {
        let render_area = Vec4::new(0.2, 0.2, 0.6, 0.6);

        let (positions, indices) = build_primitive_geometry(render_area, PrimitiveType::Point, 1);
        assert_eq!(positions.len(), 4);
        assert_eq!(indices.len(), 1);

        let (positions, indices) = build_primitive_geometry(render_area, PrimitiveType::Line, 1);
        assert_eq!(positions.len(), 8);
        assert_eq!(indices.len(), 2);

        let (positions, indices) = build_primitive_geometry(render_area, PrimitiveType::Triangle, 30);
        assert_eq!(positions.len(), 4 * 3 * 30);
        assert_eq!(indices.len(), 3 * 30);
    }

    #[test]
    fn build_primitive_geometry_is_deterministic_for_a_fixed_seed() {
        let render_area = Vec4::new(0.0, 0.0, 1.0, 1.0);
        let (p1, i1) = build_primitive_geometry(render_area, PrimitiveType::Triangle, 30);
        let (p2, i2) = build_primitive_geometry(render_area, PrimitiveType::Triangle, 30);
        assert_eq!(p1, p2);
        assert_eq!(i1, i2);
    }

    #[test]
    fn build_primitive_geometry_skips_jitter_for_a_single_primitive() {
        // Upstream: `dx`/`dy` stay 0.0 when `primitiveCount <= 1`, so a lone primitive's
        // first vertex lands exactly on `basePositions[0..2] * scale`, offset only by
        // `primitiveArea`'s own origin - no RNG draw happens at all.
        let render_area = Vec4::new(0.0, 0.0, 1.0, 1.0);
        let (positions, _) = build_primitive_geometry(render_area, PrimitiveType::Point, 1);
        let scale = 1.44 / 2.0f32.sqrt();
        let expected_x = 0.5 * scale * 2.0 + (0.0 * 2.0 - 1.0);
        let expected_y = 0.5 * scale * 2.0 + (0.0 * 2.0 - 1.0);
        assert!(
            (positions[0] - expected_x).abs() < 1e-6,
            "{} vs {}",
            positions[0],
            expected_x
        );
        assert!(
            (positions[1] - expected_y).abs() < 1e-6,
            "{} vs {}",
            positions[1],
            expected_y
        );
    }

    #[test]
    fn scissor_primitive_case_wires_is_point_from_primitive_type() {
        let point_case = scissor_primitive_case(
            "p",
            Vec4::new(0.1, 0.1, 0.8, 0.8),
            Vec4::new(0.5, 0.5, 0.0, 0.0),
            PrimitiveType::Point,
            1,
        );
        let tri_case = scissor_primitive_case(
            "t",
            Vec4::new(0.1, 0.1, 0.8, 0.8),
            Vec4::new(0.2, 0.2, 0.6, 0.6),
            PrimitiveType::Triangle,
            1,
        );
        assert_eq!(point_case.name(), "p");
        assert_eq!(tri_case.name(), "t");
    }

    #[test]
    fn clear_edges_leaves_the_scissor_area_untouched() {
        let mut surface = Surface::new(4, 4);
        for y in 0..4 {
            for x in 0..4 {
                surface.set_pixel(x, y, RGBA::new(1, 2, 3, 4));
            }
        }
        clear_edges(&mut surface, RGBA::new(32, 64, 128, 255), IVec4::new(1, 1, 2, 2));

        for y in 0..4i32 {
            for x in 0..4i32 {
                let inside = (1..3).contains(&x) && (1..3).contains(&y);
                let expected = if inside {
                    RGBA::new(1, 2, 3, 4)
                } else {
                    RGBA::new(32, 64, 128, 255)
                };
                assert_eq!(surface.get_pixel(x, y), expected, "at ({x}, {y})");
            }
        }
    }

    #[test]
    fn create_framebuffer_clear_tests_registers_exactly_the_six_upstream_names() {
        let cases = create_framebuffer_clear_tests();
        assert_eq!(cases.len(), 6);
        let mut names: Vec<String> = cases.iter().map(|c| c.name().to_string()).collect();
        names.sort();
        let mut expected = [
            "clear_fixed_buffer",
            "clear_int_buffer",
            "clear_uint_buffer",
            "clear_depth_buffer",
            "clear_stencil_buffer",
            "clear_depth_stencil_buffer",
        ]
        .map(str::to_string)
        .to_vec();
        expected.sort();
        assert_eq!(names, expected);
    }

    #[test]
    fn create_framebuffer_blit_tests_registers_exactly_the_three_upstream_names() {
        let cases = create_framebuffer_blit_tests();
        assert_eq!(cases.len(), 3);
        let mut names: Vec<String> = cases.iter().map(|c| c.name().to_string()).collect();
        names.sort();
        let mut expected = [
            "framebuffer_blit_center",
            "framebuffer_blit_corner",
            "framebuffer_blit_none",
        ]
        .map(str::to_string)
        .to_vec();
        expected.sort();
        assert_eq!(names, expected);
    }

    #[test]
    fn get_buffer_format_dispatches_colour_fmt_by_clear_type() {
        assert_eq!(get_buffer_format(ClearType::ColorFixed).color_fmt, glw::GL_RGBA8);
        assert_eq!(get_buffer_format(ClearType::ColorInt).color_fmt, glw::GL_RGBA8I);
        assert_eq!(get_buffer_format(ClearType::ColorUint).color_fmt, glw::GL_RGBA8UI);
        assert_eq!(get_buffer_format(ClearType::Depth).color_fmt, glw::GL_RGBA8);
        assert_eq!(get_buffer_format(ClearType::Stencil).color_fmt, glw::GL_RGBA8);
        assert_eq!(get_buffer_format(ClearType::DepthStencil).color_fmt, glw::GL_RGBA8);
    }

    #[test]
    fn get_base_and_main_color_match_upstreams_literals_per_channel_class() {
        let fixed = get_buffer_format(ClearType::ColorFixed);
        assert!(matches!(get_base_color(fixed), Color::Float([0.125, 0.25, 0.5, 1.0])));
        assert!(matches!(get_main_color(fixed), Color::Float([1.0, 1.0, 0.5, 1.0])));

        let int = get_buffer_format(ClearType::ColorInt);
        assert!(matches!(get_base_color(int), Color::Int([0, 0, 0, 0])));
        assert!(matches!(get_main_color(int), Color::Int([127, -127, 0, 127])));

        let uint = get_buffer_format(ClearType::ColorUint);
        assert!(matches!(get_base_color(uint), Color::Uint([0, 0, 0, 0])));
        assert!(matches!(get_main_color(uint), Color::Uint([255, 255, 0, 255])));
    }

    #[test]
    fn clear_edges_access_float_leaves_the_scissor_area_untouched() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut level = TextureLevel::new(format, 4, 4, 1).unwrap();
        {
            let mut access = level.get_access();
            for y in 0..4 {
                for x in 0..4 {
                    access.set_pixel([0.1, 0.2, 0.3, 0.4], x, y, 0);
                }
            }
        }
        clear_edges_access_float(&mut level.get_access(), [1.0, 1.0, 1.0, 1.0], IVec4::new(1, 1, 2, 2));

        let access = level.get_const_access();
        for y in 0..4u32 {
            for x in 0..4u32 {
                let inside = (1..3).contains(&x) && (1..3).contains(&y);
                let pixel = access.get_pixel(x, y, 0);
                if inside {
                    assert!((pixel[0] - 0.1).abs() < 0.01, "at ({x}, {y}): {pixel:?}");
                } else {
                    assert!((pixel[0] - 1.0).abs() < 0.01, "at ({x}, {y}): {pixel:?}");
                }
            }
        }
    }

    #[test]
    fn clear_edges_access_int_leaves_the_scissor_area_untouched() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut level = TextureLevel::new(format, 4, 4, 1).unwrap();
        {
            let mut access = level.get_access();
            for y in 0..4 {
                for x in 0..4 {
                    assert!(access.set_pixel_int([7, 7, 7, 7], x, y, 0));
                }
            }
        }
        clear_edges_access_int(
            &mut level.get_access(),
            [-127, -127, -127, -127],
            IVec4::new(1, 1, 2, 2),
        );

        let access = level.get_const_access();
        for y in 0..4u32 {
            for x in 0..4u32 {
                let inside = (1..3).contains(&x) && (1..3).contains(&y);
                let expected = if inside { 7 } else { -127 };
                assert_eq!(access.get_pixel_int(x, y, 0)[0], expected, "at ({x}, {y})");
            }
        }
    }
}

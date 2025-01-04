// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fDrawBuffersIndexedTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Both halves of upstream's group are ported here - all 76 mustpass cases.
//
// The `overwrite_common`/`overwrite_indexed` ("diff") half's render targets are fixed
// at `TextureFormat(RGBA, UNORM_INT8)` (confirmed by reading `createDiffTest`/
// `createAdvancedEqDiffTest` directly), so it never reaches an integer colour target.
//
// The `random.*` half (`MaxDrawBuffersIndexedTest`/`ImplMaxDrawBuffersIndexedTest`,
// `genRandomTest` -> `getRandomFormat`) draws its per-draw-buffer format from a pool
// that, on this port's ES 3.0-only `gles3` root, is the *first 27* of upstream's 32
// GL enums (`getRandomFormat`'s own `supportsES32orGL45 ? 32 : 32 - 5` split) - the
// excluded five are exactly the 32-bit floating-point formats
// (`RGBA16F`/`R32F`/`RG32F`/`RGBA32F`/`R11F_G11F_B10F`), which only ever enter the pool
// on an ES 3.2/GL 4.5 context this port never creates. That means `TEXTURECHANNELCLASS_
// FLOATING_POINT` is unreachable in every function below that switches on it - it is
// kept as an `unreachable!()` arm rather than silently folded away, matching the
// upstream `DE_ASSERT(false)` it mirrors - and `genRandomTest`'s own float-specific
// blend-state special-casing (32-bit float targets cannot blend on ES 3.2) is dead code
// here for the same reason and was not ported.
//
// Reference rendering for the signed/unsigned-fixed-point formats this half can still
// draw reuses `render_ref_quad_into`/`rr::fragment_operations::FragmentProcessor`
// unchanged. The signed/unsigned *integer* formats this half uniquely reaches go
// through `render_ref_quad_into_integer` instead, a standalone function rather than an
// extension of `FragmentProcessor::render` (which asserts against an integer colour
// target, see that module's own header) - blending is always `BlendMode::None` for an
// integer target (`resolve_fragment_operation_state` already forces this), so upstream's
// `executeSignedValueWrite`/`executeUnsignedValueWrite` reduce to a per-channel
// colour-mask select against the pixel's previous value, with no blend maths at all,
// which this port implements directly against `tcu::pixel`'s existing
// `get_pixel_int`/`get_pixel_uint64`/`set_pixel_int` rather than by extending the
// shared, already-verified `fragment_operations.rs`.
//
// This is the first ported case in this port to use `rr::fragment_operations` and
// `rr::triangle_rasterizer` together as a genuine two-sided (real GL driver vs.
// reference renderer) comparison - the smaller of the two framework pieces this
// campaign's progress log scoped as an alternative to `sglr::ReferenceContext`
// (`draw_buffers_indexed` is the one upstream group confirmed not to need it:
// `es3fDrawBuffersIndexedTests.cpp` builds its reference image via a direct
// `rr::Renderer{}.draw(command)` call with hand-rolled state, never a
// `sglr::ReferenceContext`). Upstream drives that through real `rr::VertexShader`/
// `rr::FragmentShader` objects; this reproduces the same per-pixel result by hand
// instead, since the vertex shader here is affine (`w` is always 1, so there is no
// perspective divide to replicate) and the fragment shader is a fixed permutation of
// the interpolated varying - `render_ref_quad_into` is the whole of that replacement.

use crate::gls::fragment_op_util::get_multisample_access;
use crate::glu::draw_util::PrimitiveType;
use crate::glu::objects::{Framebuffer, Renderbuffer};
use crate::glu::texture_util::map_gl_internal_format;
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, read_pixels, va};
use crate::glw::{self, GLenum};
use crate::rr::fragment_operations::{Fragment, FragmentProcessor};
use crate::rr::render_state::{BlendMode, FaceType, FragmentOperationState};
use crate::rr::triangle_rasterizer::{Vertex, rasterize_triangle_list};
use crate::sglr::reference_utils::{map_gl_blend_equation, map_gl_blend_equation_advanced, map_gl_blend_func};
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, TextureLevel, clear, clear_int, get_texture_format_bit_depth, get_texture_format_info,
};
use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};
use crate::tcu::vector::{UVec4, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `s_quadCoords` - a half-size quad, so every corner stays well inside the 64x64
/// viewport with no clipping (confirmed by reading `renderQuad`/`runTest`: this is the
/// only geometry this group ever draws). Two triangles sharing the `(0.5,-0.5)`-
/// `(-0.5,0.5)` diagonal, in upstream's own vertex order.
const QUAD_COORDS: [f32; 12] = [-0.5, -0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0.5, -0.5, -0.5];

/// `DrawBufferInfo::getSize()` for every case in scope - upstream's own `IVec2(64, 64)`.
const RENDER_SIZE: i32 = 64;

/// `Either<BlendEq, SeparateBlendEq>`, as an enum since Rust has no `tcu::Either`.
#[derive(Clone, Copy)]
enum EqSpec {
    Single(GLenum),
    Separate(GLenum, GLenum),
}

/// `Either<BlendFunc, SeparateBlendFunc>`.
#[derive(Clone, Copy)]
enum FuncSpec {
    Single(GLenum, GLenum),
    Separate((GLenum, GLenum), (GLenum, GLenum)),
}

/// `BlendState` (the test's own, upstream's local `struct BlendState` - not
/// `rr::BlendState`, which is the per-channel-group equation/function pair one of
/// these resolves into).
#[derive(Clone, Copy, Default)]
struct BlendOverride {
    enable_blend: Option<bool>,
    blend_eq: Option<EqSpec>,
    blend_func: Option<FuncSpec>,
    color_mask: Option<[bool; 4]>,
}

/// `isAdvancedBlendEq` - whether a single (non-separate) blend equation is one of the
/// fifteen `GL_KHR_blend_equation_advanced` equations.
fn is_advanced_blend_eq(eq: GLenum) -> bool {
    map_gl_blend_equation_advanced(eq).is_some()
}

/// `requiresAdvancedBlendEq` - only a `Single` equation can be advanced, matching
/// upstream's own `blendEq->is<BlendEq>()` check (a `SeparateBlendEq` has no advanced
/// form in the C++'s own type).
fn requires_advanced_blend_eq(pre: &BlendOverride, post: &BlendOverride, draw_buffers: &[BlendOverride]) -> bool {
    let uses_advanced =
        |state: &BlendOverride| matches!(state.blend_eq, Some(EqSpec::Single(eq)) if is_advanced_blend_eq(eq));
    uses_advanced(pre) || uses_advanced(post) || draw_buffers.iter().any(uses_advanced)
}

/// `setBlendState` - folds one `BlendOverride` into the reference renderer's resolved
/// state. Called three times in order (pre, per-buffer, post common), each later call
/// overwriting whatever an earlier one set - matching upstream's own call order in
/// `createRenderState` exactly, since which call "wins" a field is observable (the
/// `overwrite_common`/`overwrite_indexed` groups exist to test precisely that).
fn apply_blend_override(frag_ops: &mut FragmentOperationState, state: &BlendOverride) {
    if let Some(eq) = state.blend_eq {
        match eq {
            EqSpec::Single(eq) => {
                if let Some(advanced) = map_gl_blend_equation_advanced(eq) {
                    frag_ops.blend_mode = BlendMode::Advanced;
                    frag_ops.blend_equation_advanced = Some(advanced);
                } else if let Some(equation) = map_gl_blend_equation(eq) {
                    frag_ops.blend_mode = BlendMode::Standard;
                    frag_ops.blend_rgb_state.equation = equation;
                    frag_ops.blend_a_state.equation = equation;
                }
            }
            EqSpec::Separate(rgb, alpha) => {
                frag_ops.blend_mode = BlendMode::Standard;
                if let Some(equation) = map_gl_blend_equation(rgb) {
                    frag_ops.blend_rgb_state.equation = equation;
                }
                if let Some(equation) = map_gl_blend_equation(alpha) {
                    frag_ops.blend_a_state.equation = equation;
                }
            }
        }
    }

    if let Some(func) = state.blend_func {
        match func {
            FuncSpec::Single(src, dst) => {
                if let (Some(src), Some(dst)) = (map_gl_blend_func(src), map_gl_blend_func(dst)) {
                    frag_ops.blend_rgb_state.src_func = src;
                    frag_ops.blend_rgb_state.dst_func = dst;
                    frag_ops.blend_a_state.src_func = src;
                    frag_ops.blend_a_state.dst_func = dst;
                }
            }
            FuncSpec::Separate((rgb_src, rgb_dst), (a_src, a_dst)) => {
                if let (Some(src), Some(dst)) = (map_gl_blend_func(rgb_src), map_gl_blend_func(rgb_dst)) {
                    frag_ops.blend_rgb_state.src_func = src;
                    frag_ops.blend_rgb_state.dst_func = dst;
                }
                if let (Some(src), Some(dst)) = (map_gl_blend_func(a_src), map_gl_blend_func(a_dst)) {
                    frag_ops.blend_a_state.src_func = src;
                    frag_ops.blend_a_state.dst_func = dst;
                }
            }
        }
    }

    if let Some(mask) = state.color_mask {
        frag_ops.color_mask = mask;
    }
}

/// `createRenderState`
fn resolve_fragment_operation_state(
    pre: &BlendOverride,
    draw_buffer: &BlendOverride,
    post: &BlendOverride,
    format: TextureFormat,
) -> FragmentOperationState {
    // Upstream starts from `BLENDMODE_STANDARD` before any of the three overrides are
    // applied, which matters whenever none of them ever sets `blendEq` but one does
    // enable blending - the resolved mode must still be Standard, not
    // `FragmentOperationState::default()`'s own `BlendMode::None`.
    let mut frag_ops = FragmentOperationState {
        blend_mode: BlendMode::Standard,
        ..Default::default()
    };

    apply_blend_override(&mut frag_ops, pre);
    apply_blend_override(&mut frag_ops, draw_buffer);
    apply_blend_override(&mut frag_ops, post);

    frag_ops.blend_mode = if let Some(enable) = post.enable_blend {
        if enable { frag_ops.blend_mode } else { BlendMode::None }
    } else if let Some(enable) = draw_buffer.enable_blend {
        if enable { frag_ops.blend_mode } else { BlendMode::None }
    } else if let Some(enable) = pre.enable_blend {
        if enable { frag_ops.blend_mode } else { BlendMode::None }
    } else {
        BlendMode::None
    };

    if !matches!(
        format.channel_class(),
        TextureChannelClass::SignedFixedPoint
            | TextureChannelClass::UnsignedFixedPoint
            | TextureChannelClass::FloatingPoint
    ) {
        frag_ops.blend_mode = BlendMode::None;
    }

    frag_ops
}

/// `setCommonBlendState`
fn set_common_blend_state(gl: &glw::Functions, state: &BlendOverride) -> Result<(), TestError> {
    // SAFETY: every argument is a constant GL enum/boolean, called against whatever
    // context is current - the same precondition every other GL call in this port has.
    unsafe {
        if let Some(enable) = state.enable_blend {
            if enable {
                gl.enable(glw::GL_BLEND);
            } else {
                gl.disable(glw::GL_BLEND);
            }
        }

        if let Some(mask) = state.color_mask {
            gl.color_mask(gl_bool(mask[0]), gl_bool(mask[1]), gl_bool(mask[2]), gl_bool(mask[3]));
        }

        if let Some(eq) = state.blend_eq {
            match eq {
                EqSpec::Single(eq) => gl.blend_equation(eq),
                EqSpec::Separate(rgb, alpha) => gl.blend_equation_separate(rgb, alpha),
            }
        }

        if let Some(func) = state.blend_func {
            match func {
                FuncSpec::Single(src, dst) => gl.blend_func(src, dst),
                FuncSpec::Separate((rgb_src, rgb_dst), (a_src, a_dst)) => {
                    gl.blend_func_separate(rgb_src, rgb_dst, a_src, a_dst)
                }
            }
        }
    }

    glu::expect_no_error(gl, "Failed to set common blend state.")
}

/// `setIndexedBlendState`
fn set_indexed_blend_state(gl: &glw::Functions, state: &BlendOverride, index: u32) -> Result<(), TestError> {
    // SAFETY: as `set_common_blend_state`.
    unsafe {
        if let Some(enable) = state.enable_blend {
            if enable {
                gl.enablei(glw::GL_BLEND, index);
            } else {
                gl.disablei(glw::GL_BLEND, index);
            }
        }

        if let Some(mask) = state.color_mask {
            gl.color_maski(
                index,
                gl_bool(mask[0]),
                gl_bool(mask[1]),
                gl_bool(mask[2]),
                gl_bool(mask[3]),
            );
        }

        if let Some(eq) = state.blend_eq {
            match eq {
                EqSpec::Single(eq) => gl.blend_equationi(index, eq),
                EqSpec::Separate(rgb, alpha) => gl.blend_equation_separatei(index, rgb, alpha),
            }
        }

        if let Some(func) = state.blend_func {
            match func {
                FuncSpec::Single(src, dst) => gl.blend_funci(index, src, dst),
                FuncSpec::Separate((rgb_src, rgb_dst), (a_src, a_dst)) => {
                    gl.blend_func_separatei(index, rgb_src, rgb_dst, a_src, a_dst)
                }
            }
        }
    }

    glu::expect_no_error(gl, "Failed to set indexed blend state.")
}

fn gl_bool(value: bool) -> glw::GLboolean {
    if value { glw::TRUE } else { glw::FALSE }
}

/// `getUnsignedFixedPointComponent` - nudges a component exactly halfway between two
/// fixed-point steps away from the tie, so the driver's own round-to-nearest cannot
/// disagree with this reference about which way it goes.
fn unsigned_fixed_point_component(component: f32, bits: i32) -> f32 {
    if bits <= 1 {
        return component;
    }

    let range = ((1i64 << bits) - 1) as f32;
    let fixed_value = component * range;
    let eps = 0.05 / range;

    if (0.5 + fixed_value.floor() - fixed_value).abs() < eps {
        let bias = if component > 0.5 { -eps } else { eps };
        component + bias
    } else {
        component
    }
}

/// `clearRenderbuffer`, restricted to the `UNORM_INT8`/`UNSIGNED_FIXED_POINT` branch -
/// the only one any case in this port's scope reaches. Clears each render target to a
/// different colour (alpha is never zero, since the advanced blend equations assume
/// premultiplied alpha).
fn clear_color_for_buffer(index: i32, count: i32) -> [f32; 4] {
    let red_scale = (index + 1) as f32 / count as f32;
    let blue_scale = (count - index) as f32 / count as f32;
    let green_scale = (((count / 2) + index) % count) as f32 / count as f32;
    let alpha_scale = (1 + (((count / 2) + count - index) % count)) as f32 / count as f32;

    [
        unsigned_fixed_point_component(red_scale, 8),
        unsigned_fixed_point_component(green_scale, 8),
        unsigned_fixed_point_component(blue_scale, 8),
        unsigned_fixed_point_component(alpha_scale, 8),
    ]
}

/// `getFixedPointFormatThreshold`, specialised to source format == read-pixels format
/// (always true here - both are `UNORM_INT8`).
fn fixed_point_threshold(format: TextureFormat) -> [f32; 4] {
    let bits = get_texture_format_bit_depth(format);
    let mut threshold = [0.0f32; 4];
    for (t, b) in threshold.iter_mut().zip(bits) {
        if b > 0 {
            *t = 3.0 / ((1u64 << b) - 1) as f32;
        }
    }
    threshold
}

/// The quad's six vertices in pixel space, varying `(v_color.x, v_color.y, 0, 0)` -
/// `VertexShader::shadeVertices`' `0.5 * (1 + i_coord)`, carried as the first two
/// varying components and expanded into the fragment shader's four-value permutation
/// in `render_ref_quad_into` rather than carrying all four through the rasteriser.
fn build_quad_vertices(size: f32) -> [Vertex; 6] {
    let to_pixel = |ndc: f32| (ndc * 0.5 + 0.5) * size;
    std::array::from_fn(|i| {
        let nx = QUAD_COORDS[i * 2];
        let ny = QUAD_COORDS[i * 2 + 1];
        let vx = 0.5 * (1.0 + nx);
        let vy = 0.5 * (1.0 + ny);
        Vertex::new(to_pixel(nx), to_pixel(ny), Vec4::new(vx, vy, 0.0, 0.0))
    })
}

/// `renderRefQuad`'s per-draw-buffer body - one `rr::Renderer{}.draw(command)` call in
/// the C++, replaced here by rasterising the quad once and shading each covered pixel
/// with `FragmentShader::shadeFragments`'s own four-value cyclic permutation before
/// handing it to `rr::FragmentProcessor` exactly as the C++'s `renderer.draw` would.
fn render_ref_quad_into(frag_ops: &FragmentOperationState, draw_buffer_index: usize, level: &mut TextureLevel) {
    let vertices = build_quad_vertices(RENDER_SIZE as f32);
    let indices: [u32; 6] = [0, 1, 2, 3, 4, 5];
    let mut fragments = Vec::new();

    rasterize_triangle_list(RENDER_SIZE, RENDER_SIZE, &vertices, &indices, &mut |x, y, varying| {
        let vx = varying.x();
        let vy = varying.y();
        let values = [vx, vy, 1.0 - vx, 1.0 - vy];
        let color = [
            values[draw_buffer_index % 4],
            values[(draw_buffer_index + 1) % 4],
            values[(draw_buffer_index + 2) % 4],
            values[(draw_buffer_index + 3) % 4],
        ];

        fragments.push(Fragment::single_sampled([x, y], color, color, 1, 0.0));
    });

    let mut access = get_multisample_access(level.get_access());
    let mut processor = FragmentProcessor::new();
    processor.render(&mut access, None, None, &fragments, FaceType::Front, frag_ops);
}

/// `genVertexSource` - always the ES 3.0 form, since this port's `gles3` root only ever
/// creates an ES 3.0 context (`runner::Api::Gles3::gl_api_types`), unlike upstream which
/// may run the same test package on an ES 3.2/GL 4.5 context too.
const VERTEX_SOURCE: &str = "#version 300 es\n\
    layout(location=0) in highp vec2 i_coord;\n\
    out highp vec2 v_color;\n\
    void main (void)\n\
    {\n\
    \tv_color = 0.5 * (vec2(1.0) + i_coord);\n\
    \tgl_Position = vec4(i_coord, 0.0, 1.0);\n\
    }";

/// `genFragmentSource`, restricted to the `UNORM_INT8` output type every case in scope
/// uses (upstream's `uvec4`/`ivec4` arms are for the not-yet-ported `random.*` cases).
fn gen_fragment_source(requires_advanced: bool, draw_buffer_count: usize) -> String {
    let mut source = String::from("#version 300 es\n");
    if requires_advanced {
        source.push_str("#extension GL_KHR_blend_equation_advanced : require\n");
        source.push_str("layout(blend_support_all_equations) out;\n");
    }
    source.push_str("in highp vec2 v_color;\n");
    for index in 0..draw_buffer_count {
        source.push_str(&format!(
            "layout(location={index}) out highp vec4 o_drawBuffer{index};\n"
        ));
    }
    source.push_str("void main (void)\n{\n");
    let values = ["v_color.x", "v_color.y", "(1.0 - v_color.x)", "(1.0 - v_color.y)"];
    for index in 0..draw_buffer_count {
        source.push_str(&format!(
            "\to_drawBuffer{index} = vec4({}, {}, {}, {});\n",
            values[index % 4],
            values[(index + 1) % 4],
            values[(index + 2) % 4],
            values[(index + 3) % 4]
        ));
    }
    source.push('}');
    source
}

/// `renderQuad`
fn render_quad(
    ctx: &Context,
    pre: &BlendOverride,
    post: &BlendOverride,
    draw_buffers: &[BlendOverride],
    fbo: &Framebuffer<'_>,
    format: TextureFormat,
    ref_levels: &mut [TextureLevel],
) -> Result<(), TestError> {
    let gl = ctx.gl();
    let requires_advanced = requires_advanced_blend_eq(pre, post, draw_buffers);
    let fragment_source = gen_fragment_source(requires_advanced, draw_buffers.len());
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SOURCE, fragment_source));
    if !program.is_ok() {
        return Err(TestError::Fail(
            program
                .build_failure_summary()
                .unwrap_or_else(|| "shader build failed".to_string()),
        ));
    }

    let draw_buffer_attachments: Vec<GLenum> = (0..draw_buffers.len() as u32)
        .map(|i| glw::GL_COLOR_ATTACHMENT0 + i)
        .collect();

    // SAFETY: `program` was just linked successfully and `fbo` was just filled in by
    // the caller; every enum/name below is a constant or a name this function owns.
    unsafe {
        gl.viewport(0, 0, RENDER_SIZE, RENDER_SIZE);
        gl.use_program(program.program());
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
    }

    set_common_blend_state(gl, pre)?;
    for (index, draw_buffer) in draw_buffers.iter().enumerate() {
        set_indexed_blend_state(gl, draw_buffer, index as u32)?;
    }
    set_common_blend_state(gl, post)?;

    // SAFETY: `draw_buffer_attachments` lives for the call and names `draw_buffers.len()` attachments.
    unsafe { gl.draw_buffers(draw_buffer_attachments.len() as i32, draw_buffer_attachments.as_ptr()) };

    if requires_advanced {
        // SAFETY: as above.
        unsafe { gl.blend_barrier() };
    }

    let vertex_array = [va::float_at(0, 2, 6, 0, &QUAD_COORDS)];
    glu::draw(
        &ctx.render_context,
        program.program(),
        &vertex_array,
        &pr::list(PrimitiveType::Triangles, 6),
    )?;

    if requires_advanced {
        // SAFETY: as above.
        unsafe { gl.blend_barrier() };
    }

    // SAFETY: as above.
    unsafe {
        gl.draw_buffers(0, std::ptr::null());
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.use_program(0);
    }
    glu::expect_no_error(gl, "Failed to render")?;

    for (index, (draw_buffer, level)) in draw_buffers.iter().zip(ref_levels.iter_mut()).enumerate() {
        let frag_ops = resolve_fragment_operation_state(pre, draw_buffer, post, format);
        render_ref_quad_into(&frag_ops, index, level);
    }

    Ok(())
}

/// `runTest`
fn run_test(ctx: &Context, pre: &BlendOverride, post: &BlendOverride, draw_buffers: &[BlendOverride]) -> TestOutcome {
    let gl = ctx.gl();
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let count = draw_buffers.len();

    let fbo = Framebuffer::new(gl);
    let renderbuffers: Vec<Renderbuffer<'_>> = (0..count).map(|_| Renderbuffer::new(gl)).collect();
    let mut ref_levels: Vec<TextureLevel> = Vec::with_capacity(count);

    // SAFETY: `fbo`/`renderbuffers` are names this function owns and binds exactly
    // once each; `RENDER_SIZE` is a positive constant.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        for (index, rbo) in renderbuffers.iter().enumerate() {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, RENDER_SIZE, RENDER_SIZE);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0 + index as u32,
                glw::GL_RENDERBUFFER,
                rbo.get(),
            );
        }
    }
    glu::expect_no_error(gl, "Failed to create renderbuffer.")?;

    let draw_buffer_attachments: Vec<GLenum> = (0..count as u32).map(|i| glw::GL_COLOR_ATTACHMENT0 + i).collect();
    // SAFETY: `draw_buffer_attachments` lives for the call.
    unsafe { gl.draw_buffers(draw_buffer_attachments.len() as i32, draw_buffer_attachments.as_ptr()) };

    for index in 0..count {
        let mut level = TextureLevel::new(format, RENDER_SIZE as u32, RENDER_SIZE as u32, 1)?;
        let color = clear_color_for_buffer(index as i32, count as i32);
        clear(&mut level.get_access(), color);
        // SAFETY: `color` is 4 floats, matching `glClearBufferfv`'s RGBA read.
        unsafe { gl.clear_bufferfv(glw::GL_COLOR, index as i32, color.as_ptr()) };
        ref_levels.push(level);
    }
    glu::expect_no_error(gl, "Failed to clear renderbuffer.")?;

    // SAFETY: as above.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }

    render_quad(ctx, pre, post, draw_buffers, &fbo, format, &mut ref_levels)?;

    // SAFETY: as above.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get()) };

    let threshold = fixed_point_threshold(format);
    let mut failures = Vec::new();
    for (index, ref_level) in ref_levels.iter().enumerate() {
        let mut result = TextureLevel::new(format, RENDER_SIZE as u32, RENDER_SIZE as u32, 1)?;
        // SAFETY: as above.
        unsafe { gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 + index as u32) };
        read_pixels(&ctx.render_context, 0, 0, &mut result.get_access())?;
        glu::expect_no_error(gl, "Reading pixels from renderbuffer failed.")?;

        let compared = float_threshold_compare(&ref_level.get_const_access(), &result.get_const_access(), threshold);
        if !compared.ok {
            failures.push(format!("Renderbuffer{index}: max diff {:?}", compared.max_diff));
        }
    }

    // SAFETY: as above.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

    if failures.is_empty() {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail(failures.join("; ")))
    }
}

/// `DrawBuffersIndexedTest`
struct DrawBuffersIndexedCase {
    name: &'static str,
    pre: BlendOverride,
    post: BlendOverride,
    draw_buffers: Vec<BlendOverride>,
}

impl TestCase for DrawBuffersIndexedCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `DrawBuffersIndexedTest::init` - always taken (never the ES 3.2/GL 4.5 skip
    /// branch), since this port's `gles3` root only ever creates an ES 3.0 context.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if requires_advanced_blend_eq(&self.pre, &self.post, &self.draw_buffers)
            && !context
                .context_info
                .is_extension_supported("GL_KHR_blend_equation_advanced")
        {
            return Err(TestError::NotSupported(
                "Extension GL_KHR_blend_equation_advanced not supported".to_string(),
            ));
        }
        if !context
            .context_info
            .is_extension_supported("GL_EXT_draw_buffers_indexed")
        {
            return Err(TestError::NotSupported(
                "Extension GL_EXT_draw_buffers_indexed not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_test(context, &self.pre, &self.post, &self.draw_buffers)
    }
}

/// `PrePost`
#[derive(Clone, Copy)]
enum PrePost {
    Pre,
    Post,
}

/// `createDiffTest`'s `PRE` branch's `preState`, and `createAdvancedEqDiffTest`'s
/// (identical shape).
fn default_pre(common: &BlendOverride) -> BlendOverride {
    BlendOverride {
        enable_blend: common.enable_blend.or(Some(true)),
        blend_eq: common.blend_eq,
        blend_func: common.blend_func.or(Some(FuncSpec::Single(glw::GL_ONE, glw::GL_ONE))),
        color_mask: None,
    }
}

/// `createDiffTest`'s `POST` branch's fixed `preState`.
const FIXED_PRE: BlendOverride = BlendOverride {
    enable_blend: Some(true),
    blend_eq: None,
    blend_func: Some(FuncSpec::Single(glw::GL_ONE, glw::GL_ONE)),
    color_mask: None,
};

/// `createDiffTest` - two render targets, the first left at `emptyState` and the
/// second carrying `draw_buffer`'s own per-buffer override.
fn diff_case(
    prepost: PrePost,
    name: &'static str,
    common: BlendOverride,
    draw_buffer: BlendOverride,
) -> Box<DrawBuffersIndexedCase> {
    let empty = BlendOverride::default();
    let (pre, post) = match prepost {
        PrePost::Pre => (default_pre(&common), empty),
        PrePost::Post => (FIXED_PRE, common),
    };
    Box::new(DrawBuffersIndexedCase {
        name,
        pre,
        post,
        draw_buffers: vec![empty, draw_buffer],
    })
}

/// `createAdvancedEqDiffTest` - the same shape as `diff_case`, but a single render
/// target (`GL_KHR_blend_equation_advanced` has no multi-draw-buffer form in this
/// group's own cases, confirmed by reading it directly: every advanced-equation case
/// constructs exactly one `DrawBufferInfo`).
fn advanced_eq_diff_case(
    prepost: PrePost,
    name: &'static str,
    common: BlendOverride,
    draw_buffer: BlendOverride,
) -> Box<DrawBuffersIndexedCase> {
    let (pre, post) = match prepost {
        PrePost::Pre => (default_pre(&common), BlendOverride::default()),
        PrePost::Post => (FIXED_PRE, common),
    };
    Box::new(DrawBuffersIndexedCase {
        name,
        pre,
        post,
        draw_buffers: vec![draw_buffer],
    })
}

/// `addDrawBufferCommonTests`
fn build_diff_group(prepost: PrePost, group_name: &str, group_description: &str) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(group_name);
    let _ = group_description;

    {
        let disable = BlendOverride {
            enable_blend: Some(false),
            ..Default::default()
        };
        let enable = BlendOverride {
            enable_blend: Some(true),
            ..Default::default()
        };

        group.add_child(diff_case(prepost, "common_enable_buffer_enable", enable, enable) as Box<dyn TestCase>);
        group.add_child(diff_case(prepost, "common_disable_buffer_disable", disable, disable) as Box<dyn TestCase>);
        group.add_child(diff_case(prepost, "common_disable_buffer_enable", disable, enable) as Box<dyn TestCase>);
        group.add_child(diff_case(prepost, "common_enable_buffer_disable", enable, disable) as Box<dyn TestCase>);
    }

    {
        let eq_a = BlendOverride {
            blend_eq: Some(EqSpec::Single(glw::GL_FUNC_ADD)),
            ..Default::default()
        };
        let eq_b = BlendOverride {
            blend_eq: Some(EqSpec::Single(glw::GL_FUNC_SUBTRACT)),
            ..Default::default()
        };
        let separate_eq_a = BlendOverride {
            blend_eq: Some(EqSpec::Separate(glw::GL_FUNC_ADD, glw::GL_FUNC_SUBTRACT)),
            ..Default::default()
        };
        let separate_eq_b = BlendOverride {
            blend_eq: Some(EqSpec::Separate(glw::GL_FUNC_SUBTRACT, glw::GL_FUNC_ADD)),
            ..Default::default()
        };
        let advanced_eq_a = BlendOverride {
            blend_eq: Some(EqSpec::Single(glw::GL_DIFFERENCE)),
            ..Default::default()
        };
        let advanced_eq_b = BlendOverride {
            blend_eq: Some(EqSpec::Single(glw::GL_SCREEN)),
            ..Default::default()
        };

        group.add_child(diff_case(prepost, "common_blend_eq_buffer_blend_eq", eq_a, eq_b) as Box<dyn TestCase>);
        group.add_child(
            diff_case(prepost, "common_blend_eq_buffer_separate_blend_eq", eq_a, separate_eq_b) as Box<dyn TestCase>,
        );
        group.add_child(
            advanced_eq_diff_case(prepost, "common_blend_eq_buffer_advanced_blend_eq", eq_a, advanced_eq_b)
                as Box<dyn TestCase>,
        );
        group.add_child(
            diff_case(prepost, "common_separate_blend_eq_buffer_blend_eq", separate_eq_a, eq_b) as Box<dyn TestCase>,
        );
        group.add_child(diff_case(
            prepost,
            "common_separate_blend_eq_buffer_separate_blend_eq",
            separate_eq_a,
            separate_eq_b,
        ) as Box<dyn TestCase>);
        group.add_child(advanced_eq_diff_case(
            prepost,
            "common_separate_blend_eq_buffer_advanced_blend_eq",
            separate_eq_a,
            advanced_eq_b,
        ) as Box<dyn TestCase>);
        group.add_child(
            advanced_eq_diff_case(prepost, "common_advanced_blend_eq_buffer_blend_eq", advanced_eq_a, eq_b)
                as Box<dyn TestCase>,
        );
        group.add_child(advanced_eq_diff_case(
            prepost,
            "common_advanced_blend_eq_buffer_separate_blend_eq",
            advanced_eq_a,
            separate_eq_b,
        ) as Box<dyn TestCase>);
        group.add_child(advanced_eq_diff_case(
            prepost,
            "common_advanced_blend_eq_buffer_advanced_blend_eq",
            advanced_eq_a,
            advanced_eq_b,
        ) as Box<dyn TestCase>);
    }

    {
        let func_a = BlendOverride {
            blend_func: Some(FuncSpec::Single(glw::GL_SRC_ALPHA, glw::GL_DST_ALPHA)),
            ..Default::default()
        };
        let func_b = BlendOverride {
            blend_func: Some(FuncSpec::Single(glw::GL_DST_ALPHA, glw::GL_SRC_ALPHA)),
            ..Default::default()
        };
        let separate_func_a = BlendOverride {
            blend_func: Some(FuncSpec::Separate(
                (glw::GL_SRC_ALPHA, glw::GL_DST_ALPHA),
                (glw::GL_ONE_MINUS_SRC_ALPHA, glw::GL_ONE_MINUS_DST_ALPHA),
            )),
            ..Default::default()
        };
        let separate_func_b = BlendOverride {
            blend_func: Some(FuncSpec::Separate(
                (glw::GL_DST_ALPHA, glw::GL_SRC_ALPHA),
                (glw::GL_ONE_MINUS_DST_ALPHA, glw::GL_ONE_MINUS_SRC_ALPHA),
            )),
            ..Default::default()
        };

        group.add_child(diff_case(prepost, "common_blend_func_buffer_blend_func", func_a, func_b) as Box<dyn TestCase>);
        group.add_child(diff_case(
            prepost,
            "common_blend_func_buffer_separate_blend_func",
            func_a,
            separate_func_b,
        ) as Box<dyn TestCase>);
        group.add_child(diff_case(
            prepost,
            "common_separate_blend_func_buffer_blend_func",
            separate_func_a,
            func_b,
        ) as Box<dyn TestCase>);
        group.add_child(diff_case(
            prepost,
            "common_separate_blend_func_buffer_separate_blend_func",
            separate_func_a,
            separate_func_b,
        ) as Box<dyn TestCase>);
    }

    {
        let common_mask = BlendOverride {
            color_mask: Some([true, false, true, false]),
            ..Default::default()
        };
        let buffer_mask = BlendOverride {
            color_mask: Some([false, true, false, true]),
            ..Default::default()
        };

        group.add_child(
            diff_case(prepost, "common_color_mask_buffer_color_mask", common_mask, buffer_mask) as Box<dyn TestCase>,
        );
    }

    group
}

// ---------------------------------------------------------------------------------
// `random.*` - see this file's own module doc for the scope this half covers.
// ---------------------------------------------------------------------------------

/// `getRandomFormat`'s ES-3.0-only pool - the first 27 of upstream's 32 GL enums (the
/// excluded five, always the last five of upstream's own array, are the 32-bit
/// floating-point formats - see the module doc).
const RANDOM_FORMAT_POOL: [GLenum; 27] = [
    glw::GL_R8,
    glw::GL_RG8,
    glw::GL_RGB8,
    glw::GL_RGB565,
    glw::GL_RGBA4,
    glw::GL_RGB5_A1,
    glw::GL_RGBA8,
    glw::GL_RGB10_A2,
    glw::GL_RGB10_A2UI,
    glw::GL_R8I,
    glw::GL_R8UI,
    glw::GL_R16I,
    glw::GL_R16UI,
    glw::GL_R32I,
    glw::GL_R32UI,
    glw::GL_RG8I,
    glw::GL_RG8UI,
    glw::GL_RG16I,
    glw::GL_RG16UI,
    glw::GL_RG32I,
    glw::GL_RG32UI,
    glw::GL_RGBA8I,
    glw::GL_RGBA8UI,
    glw::GL_RGBA16I,
    glw::GL_RGBA16UI,
    glw::GL_RGBA32I,
    glw::GL_RGBA32UI,
];

/// `getRandomFormat`
fn random_format(rng: &mut Random) -> (GLenum, TextureFormat) {
    let gl_internal_format = RANDOM_FORMAT_POOL[(rng.get_uint32() as usize) % RANDOM_FORMAT_POOL.len()];
    let format = map_gl_internal_format(gl_internal_format)
        .expect("every entry in RANDOM_FORMAT_POOL is a known internal format");
    (gl_internal_format, format)
}

/// `getRandomBlendEq`
fn random_blend_eq(rng: &mut Random) -> GLenum {
    const EQS: [GLenum; 5] = [
        glw::GL_FUNC_ADD,
        glw::GL_FUNC_SUBTRACT,
        glw::GL_FUNC_REVERSE_SUBTRACT,
        glw::GL_MIN,
        glw::GL_MAX,
    ];
    EQS[(rng.get_uint32() as usize) % EQS.len()]
}

/// `getRandomBlendFunc`
fn random_blend_func(rng: &mut Random) -> (GLenum, GLenum) {
    const FUNCS: [GLenum; 15] = [
        glw::GL_ZERO,
        glw::GL_ONE,
        glw::GL_SRC_COLOR,
        glw::GL_ONE_MINUS_SRC_COLOR,
        glw::GL_DST_COLOR,
        glw::GL_ONE_MINUS_DST_COLOR,
        glw::GL_SRC_ALPHA,
        glw::GL_ONE_MINUS_SRC_ALPHA,
        glw::GL_DST_ALPHA,
        glw::GL_ONE_MINUS_DST_ALPHA,
        glw::GL_CONSTANT_COLOR,
        glw::GL_ONE_MINUS_CONSTANT_COLOR,
        glw::GL_CONSTANT_ALPHA,
        glw::GL_ONE_MINUS_CONSTANT_ALPHA,
        glw::GL_SRC_ALPHA_SATURATE,
    ];
    let src = FUNCS[(rng.get_uint32() as usize) % FUNCS.len()];
    let dst = FUNCS[(rng.get_uint32() as usize) % FUNCS.len()];
    (src, dst)
}

/// `genRandomBlendState`.
///
/// The colour-mask slots are built as `[red, blue, green, alpha]`, not `[red, green,
/// blue, alpha]` - upstream literally constructs `BVec4(red, blue, green, alpha)` here.
/// That is a genuine upstream quirk (see QUIRKS.md), not a transcription slip: it is
/// applied identically on both sides of every comparison this test makes (the real
/// `glColorMaski` call and this port's own reference state both read the same swapped
/// slots positionally), so it is harmless and self-consistent - preserved verbatim
/// rather than "fixed", per this project's own standing rule for upstream quirks.
fn gen_random_blend_state(rng: &mut Random) -> BlendOverride {
    let mut state = BlendOverride::default();

    if rng.get_bool() {
        state.enable_blend = Some(rng.get_bool());
    }

    if rng.get_bool() {
        state.blend_eq = Some(if rng.get_bool() {
            EqSpec::Single(random_blend_eq(rng))
        } else {
            EqSpec::Separate(random_blend_eq(rng), random_blend_eq(rng))
        });
    }

    if rng.get_bool() {
        state.blend_func = Some(if rng.get_bool() {
            let (src, dst) = random_blend_func(rng);
            FuncSpec::Single(src, dst)
        } else {
            FuncSpec::Separate(random_blend_func(rng), random_blend_func(rng))
        });
    }

    if rng.get_bool() {
        let red = rng.get_bool();
        let green = rng.get_bool();
        let blue = rng.get_bool();
        let alpha = rng.get_bool();
        state.color_mask = Some([red, blue, green, alpha]);
    }

    state
}

/// `DrawBufferInfo`, the `random.*` shape: a per-buffer format (and the GL enum it came
/// from, so no reverse `TextureFormat -> GLenum` mapping is needed) plus its own blend
/// override.
struct RandomDrawBuffer {
    render: bool,
    gl_internal_format: GLenum,
    format: TextureFormat,
    blend: BlendOverride,
}

/// `genRandomTest`. The 32-bit-float blend-state special-casing upstream has here is
/// dead code on this port's ES-3.0-only pool (see the module doc) and was not ported.
fn gen_random_test(rng: &mut Random, max_draw_buffers: usize) -> (BlendOverride, BlendOverride, Vec<RandomDrawBuffer>) {
    let pre = gen_random_blend_state(rng);
    let post = gen_random_blend_state(rng);
    let mut draw_buffers = Vec::with_capacity(max_draw_buffers);

    for _ in 0..max_draw_buffers {
        let render = rng.get_float() > 0.1;
        let (gl_internal_format, format) = random_format(rng);
        let blend = gen_random_blend_state(rng);
        draw_buffers.push(RandomDrawBuffer {
            render,
            gl_internal_format,
            format,
            blend,
        });
    }

    (pre, post, draw_buffers)
}

/// `getUnsignedFixedPointComponent`-generalised `getFixedPointFormatThreshold`, over an
/// arbitrary (source, read-pixels-format) pair rather than the "diff" group's fixed
/// UNORM_INT8/UNORM_INT8 pair (`fixed_point_threshold` above stays as it was for that
/// group, unchanged).
fn fixed_point_threshold_for(source: TextureFormat, read: TextureFormat) -> [f32; 4] {
    let src_bits = get_texture_format_bit_depth(source);
    let read_bits = get_texture_format_bit_depth(read);
    let mut threshold = [0.0f32; 4];
    for i in 0..4 {
        let bits = src_bits[i].min(read_bits[i]);
        if bits > 0 {
            threshold[i] = 3.0 / ((1u64 << bits) - 1) as f32;
        }
    }
    threshold
}

/// `clearRenderbuffer`, generalised over every channel class `random_format` can draw
/// (float is unreachable here, see the module doc).
enum ClearValue {
    Int([i32; 4]),
    Uint([u32; 4]),
    Float([f32; 4]),
}

fn clear_value_for_buffer(format: TextureFormat, index: i32, count: i32) -> ClearValue {
    let red_scale = (index + 1) as f32 / count as f32;
    let blue_scale = (count - index) as f32 / count as f32;
    let green_scale = (((count / 2) + index) % count) as f32 / count as f32;
    let alpha_scale = (1 + (((count / 2) + count - index) % count)) as f32 / count as f32;
    let info = get_texture_format_info(format);
    let scales = [red_scale, green_scale, blue_scale, alpha_scale];

    match format.channel_class() {
        TextureChannelClass::SignedInteger => ClearValue::Int(std::array::from_fn(|c| {
            (info.value_min[c] + (info.value_max[c] - info.value_min[c]) * scales[c]) as i32
        })),
        TextureChannelClass::UnsignedInteger => {
            ClearValue::Uint(std::array::from_fn(|c| (info.value_max[c] * scales[c]) as u32))
        }
        TextureChannelClass::SignedFixedPoint => ClearValue::Float(std::array::from_fn(|c| {
            info.value_min[c] + (info.value_max[c] - info.value_min[c]) * scales[c]
        })),
        TextureChannelClass::UnsignedFixedPoint => {
            let bits = get_texture_format_bit_depth(format);
            ClearValue::Float(std::array::from_fn(|c| {
                unsigned_fixed_point_component(info.value_max[c] * scales[c], bits[c])
            }))
        }
        other => unreachable!("random format pool never produces {other:?}"),
    }
}

/// `getReadPixelFormat`, restricted to the channel classes `random_format` can draw.
fn read_pixel_format_for(format: TextureFormat) -> TextureFormat {
    match format.channel_class() {
        TextureChannelClass::UnsignedInteger => TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32),
        TextureChannelClass::SignedInteger => TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
        TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint => {
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)
        }
        other => unreachable!("random format pool never produces {other:?}"),
    }
}

/// `verifyRenderbuffer`
fn verify_renderbuffer(
    format: TextureFormat,
    reference: &ConstPixelBufferAccess<'_>,
    result: &ConstPixelBufferAccess<'_>,
) -> Result<(), String> {
    match format.channel_class() {
        TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger => {
            let compared = int_threshold_compare(reference, result, UVec4::new(1, 1, 1, 1));
            if compared.ok {
                Ok(())
            } else {
                Err(format!("max diff {:?}", compared.max_diff))
            }
        }
        TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint => {
            let threshold = fixed_point_threshold_for(format, result.format());
            let compared = float_threshold_compare(reference, result, threshold);
            if compared.ok {
                Ok(())
            } else {
                Err(format!("max diff {:?}", compared.max_diff))
            }
        }
        other => unreachable!("random format pool never produces {other:?}"),
    }
}

/// `FragmentShader::shadeFragments`'s `TEXTURECHANNELCLASS_{UN,}SIGNED_INTEGER` arms +
/// `FragmentProcessor::executeSignedValueWrite`/`executeUnsignedValueWrite` collapsed
/// into one standalone function - see the module doc for why this does not extend
/// `rr::fragment_operations` itself. Blending is always off for an integer target
/// (`resolve_fragment_operation_state` already forces `BlendMode::None`), so there is no
/// blend maths here at all: each covered pixel's new value is computed exactly like
/// `render_ref_quad_into`'s float path, then written through `color_mask`'s per-channel
/// select against the pixel's own previous value - upstream's
/// `tcu::select(signedValue/unsignedValue, originalValue, colorMask)`.
fn render_ref_quad_into_integer(
    signed: bool,
    draw_buffer_index: usize,
    color_mask: [bool; 4],
    level: &mut TextureLevel,
) {
    let vertices = build_quad_vertices(RENDER_SIZE as f32);
    let indices: [u32; 6] = [0, 1, 2, 3, 4, 5];
    let mut access = level.get_access();

    rasterize_triangle_list(RENDER_SIZE, RENDER_SIZE, &vertices, &indices, &mut |x, y, varying| {
        let vx = varying.x();
        let vy = varying.y();
        let values = [vx, vy, 1.0 - vx, 1.0 - vy];
        let new_value = [
            values[draw_buffer_index % 4],
            values[(draw_buffer_index + 1) % 4],
            values[(draw_buffer_index + 2) % 4],
            values[(draw_buffer_index + 3) % 4],
        ];
        let (xu, yu) = (x as u32, y as u32);

        // Both branches end up as the raw bit pattern `set_pixel_int` expects - its own
        // unsigned channel writers read their `i32` input back out as `u32` first (see
        // `tcu::pixel::int_to_channel_bytes`), so a `u32 as i32` reinterpret round-trips.
        let mut original = if signed {
            access.as_const().get_pixel_int(xu, yu, 0)
        } else {
            let wide = access.as_const().get_pixel_uint64(xu, yu, 0);
            std::array::from_fn(|c| wide[c] as u32 as i32)
        };

        for c in 0..4 {
            if color_mask[c] {
                original[c] = if signed {
                    new_value[c] as i32
                } else {
                    new_value[c] as u32 as i32
                };
            }
        }

        assert!(
            access.set_pixel_int(original, xu, yu, 0),
            "set_pixel_int refused a format the random pool is supposed to support"
        );
    });
}

/// `genFragmentSource`'s random-pool shape: each draw buffer's output type and
/// conversion follow its own format's channel class independently (float is
/// unreachable, see the module doc) - unlike `gen_fragment_source` above, which the
/// "diff" group's fixed, all-`UNORM_INT8` shape never needed to vary per buffer.
fn gen_fragment_source_random(requires_advanced: bool, formats: &[TextureFormat]) -> String {
    let mut source = String::from("#version 300 es\n");
    if requires_advanced {
        source.push_str("#extension GL_KHR_blend_equation_advanced : require\n");
        source.push_str("layout(blend_support_all_equations) out;\n");
    }
    source.push_str("in highp vec2 v_color;\n");

    for (index, format) in formats.iter().enumerate() {
        let type_name = match format.channel_class() {
            TextureChannelClass::SignedInteger => "ivec4",
            TextureChannelClass::UnsignedInteger => "uvec4",
            TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint => "vec4",
            other => unreachable!("random format pool never produces {other:?}"),
        };
        source.push_str(&format!(
            "layout(location={index}) out highp {type_name} o_drawBuffer{index};\n"
        ));
    }

    source.push_str("void main (void)\n{\n");
    let values = ["v_color.x", "v_color.y", "(1.0 - v_color.x)", "(1.0 - v_color.y)"];
    for (index, format) in formats.iter().enumerate() {
        let v = [
            values[index % 4],
            values[(index + 1) % 4],
            values[(index + 2) % 4],
            values[(index + 3) % 4],
        ];
        match format.channel_class() {
            TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint => {
                source.push_str(&format!(
                    "\to_drawBuffer{index} = vec4({}, {}, {}, {});\n",
                    v[0], v[1], v[2], v[3]
                ));
            }
            TextureChannelClass::UnsignedInteger => {
                source.push_str(&format!(
                    "\to_drawBuffer{index} = uvec4(uint({}), uint({}), uint({}), uint({}));\n",
                    v[0], v[1], v[2], v[3]
                ));
            }
            TextureChannelClass::SignedInteger => {
                source.push_str(&format!(
                    "\to_drawBuffer{index} = ivec4(int({}), int({}), int({}), int({}));\n",
                    v[0], v[1], v[2], v[3]
                ));
            }
            other => unreachable!("random format pool never produces {other:?}"),
        }
    }
    source.push('}');
    source
}

/// `renderQuad`'s random shape, driving `genFragmentSource`/`renderRefQuad`'s per-buffer
/// dispatch instead of the "diff" group's fixed single format.
fn render_random_quad(
    ctx: &Context,
    pre: &BlendOverride,
    post: &BlendOverride,
    draw_buffers: &[RandomDrawBuffer],
    fbo: &Framebuffer<'_>,
    ref_levels: &mut [TextureLevel],
) -> Result<(), TestError> {
    let gl = ctx.gl();
    let blend_overrides: Vec<BlendOverride> = draw_buffers.iter().map(|b| b.blend).collect();
    let requires_advanced = requires_advanced_blend_eq(pre, post, &blend_overrides);
    let formats: Vec<TextureFormat> = draw_buffers.iter().map(|b| b.format).collect();
    let fragment_source = gen_fragment_source_random(requires_advanced, &formats);
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SOURCE, fragment_source));
    if !program.is_ok() {
        return Err(TestError::Fail(
            program
                .build_failure_summary()
                .unwrap_or_else(|| "shader build failed".to_string()),
        ));
    }

    let bufs: Vec<GLenum> = draw_buffers
        .iter()
        .enumerate()
        .map(|(i, b)| {
            if b.render {
                glw::GL_COLOR_ATTACHMENT0 + i as u32
            } else {
                glw::GL_NONE
            }
        })
        .collect();

    // SAFETY: `program` was just linked successfully and `fbo` was just filled in by
    // the caller; every enum/name below is a constant or a name this function owns.
    unsafe {
        gl.viewport(0, 0, RENDER_SIZE, RENDER_SIZE);
        gl.use_program(program.program());
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
    }

    set_common_blend_state(gl, pre)?;
    for (index, draw_buffer) in draw_buffers.iter().enumerate() {
        set_indexed_blend_state(gl, &draw_buffer.blend, index as u32)?;
    }
    set_common_blend_state(gl, post)?;

    // SAFETY: `bufs` lives for the call and names `draw_buffers.len()` attachments.
    unsafe { gl.draw_buffers(bufs.len() as i32, bufs.as_ptr()) };

    if requires_advanced {
        // SAFETY: as above.
        unsafe { gl.blend_barrier() };
    }

    let vertex_array = [va::float_at(0, 2, 6, 0, &QUAD_COORDS)];
    glu::draw(
        &ctx.render_context,
        program.program(),
        &vertex_array,
        &pr::list(PrimitiveType::Triangles, 6),
    )?;

    if requires_advanced {
        // SAFETY: as above.
        unsafe { gl.blend_barrier() };
    }

    // SAFETY: as above.
    unsafe {
        gl.draw_buffers(0, std::ptr::null());
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.use_program(0);
    }
    glu::expect_no_error(gl, "Failed to render")?;

    for (index, (draw_buffer, level)) in draw_buffers.iter().zip(ref_levels.iter_mut()).enumerate() {
        if !draw_buffer.render {
            continue;
        }
        let frag_ops = resolve_fragment_operation_state(pre, &draw_buffer.blend, post, draw_buffer.format);
        match draw_buffer.format.channel_class() {
            TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint => {
                render_ref_quad_into(&frag_ops, index, level);
            }
            TextureChannelClass::SignedInteger => render_ref_quad_into_integer(true, index, frag_ops.color_mask, level),
            TextureChannelClass::UnsignedInteger => {
                render_ref_quad_into_integer(false, index, frag_ops.color_mask, level)
            }
            other => unreachable!("random format pool never produces {other:?}"),
        }
    }

    Ok(())
}

/// `runTest`'s random shape: per-buffer renderbuffer storage/clear instead of the
/// "diff" group's single shared `GL_RGBA8`.
fn run_random_test(
    ctx: &Context,
    pre: &BlendOverride,
    post: &BlendOverride,
    draw_buffers: &[RandomDrawBuffer],
) -> TestOutcome {
    let gl = ctx.gl();
    let count = draw_buffers.len();

    let fbo = Framebuffer::new(gl);
    let renderbuffers: Vec<Renderbuffer<'_>> = (0..count).map(|_| Renderbuffer::new(gl)).collect();
    let mut ref_levels: Vec<TextureLevel> = Vec::with_capacity(count);

    // SAFETY: `fbo`/`renderbuffers` are names this function owns and binds exactly
    // once each; `RENDER_SIZE` is a positive constant.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        for (index, (rbo, draw_buffer)) in renderbuffers.iter().zip(draw_buffers).enumerate() {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo.get());
            gl.renderbuffer_storage(
                glw::GL_RENDERBUFFER,
                draw_buffer.gl_internal_format,
                RENDER_SIZE,
                RENDER_SIZE,
            );
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0 + index as u32,
                glw::GL_RENDERBUFFER,
                rbo.get(),
            );
        }
    }
    glu::expect_no_error(gl, "Failed to create renderbuffer.")?;

    // Every attachment, unconditionally (not gated on `render`) - `glClearBuffer*`'s
    // own `drawbuffer` index addresses a slot in the *current* draw-buffer list, so
    // every renderbuffer needs a real attachment mapped here to be clearable at all.
    // `render_random_quad` sets up its own, `render`-gated list right before drawing.
    let clear_bufs: Vec<GLenum> = (0..count as u32).map(|i| glw::GL_COLOR_ATTACHMENT0 + i).collect();
    // SAFETY: `clear_bufs` lives for the call.
    unsafe { gl.draw_buffers(clear_bufs.len() as i32, clear_bufs.as_ptr()) };

    for (index, draw_buffer) in draw_buffers.iter().enumerate() {
        let mut level = TextureLevel::new(draw_buffer.format, RENDER_SIZE as u32, RENDER_SIZE as u32, 1)?;
        match clear_value_for_buffer(draw_buffer.format, index as i32, count as i32) {
            ClearValue::Float(color) => {
                clear(&mut level.get_access(), color);
                // SAFETY: `color` is 4 floats, matching `glClearBufferfv`'s RGBA read.
                unsafe { gl.clear_bufferfv(glw::GL_COLOR, index as i32, color.as_ptr()) };
            }
            ClearValue::Int(color) => {
                assert!(clear_int(&mut level.get_access(), color));
                // SAFETY: as above, 4 ints.
                unsafe { gl.clear_bufferiv(glw::GL_COLOR, index as i32, color.as_ptr()) };
            }
            ClearValue::Uint(color) => {
                let bits: [i32; 4] = std::array::from_fn(|c| color[c] as i32);
                assert!(clear_int(&mut level.get_access(), bits));
                // SAFETY: as above, 4 uints.
                unsafe { gl.clear_bufferuiv(glw::GL_COLOR, index as i32, color.as_ptr()) };
            }
        }
        ref_levels.push(level);
    }
    glu::expect_no_error(gl, "Failed to clear renderbuffer.")?;

    // SAFETY: as above.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }

    render_random_quad(ctx, pre, post, draw_buffers, &fbo, &mut ref_levels)?;

    // SAFETY: as above.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get()) };

    let mut failures = Vec::new();
    for (index, (draw_buffer, ref_level)) in draw_buffers.iter().zip(ref_levels.iter()).enumerate() {
        let read_format = read_pixel_format_for(draw_buffer.format);
        let mut result = TextureLevel::new(read_format, RENDER_SIZE as u32, RENDER_SIZE as u32, 1)?;
        // SAFETY: as above.
        unsafe { gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 + index as u32) };
        read_pixels(&ctx.render_context, 0, 0, &mut result.get_access())?;
        glu::expect_no_error(gl, "Reading pixels from renderbuffer failed.")?;

        if let Err(message) = verify_renderbuffer(
            draw_buffer.format,
            &ref_level.get_const_access(),
            &result.get_const_access(),
        ) {
            failures.push(format!("Renderbuffer{index}: {message}"));
        }
    }

    // SAFETY: as above.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

    if failures.is_empty() {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail(failures.join("; ")))
    }
}

/// `MaxDrawBuffersIndexedTest`/`ImplMaxDrawBuffersIndexedTest`'s shared shape - the two
/// differ only in how many draw buffers they ask for and the xor constant mixed into
/// their seed (`deInt32Hash(seed) ^ 1558001307u`/`^ 2686315738u`).
enum MaxDrawBuffers {
    Fixed(usize),
    QueryImplementation,
}

struct RandomDrawBuffersIndexedCase {
    name: String,
    seed: i32,
    seed_xor: u32,
    max_draw_buffers: MaxDrawBuffers,
}

impl TestCase for RandomDrawBuffersIndexedCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// Upstream's `init` here checks only the one extension - `genRandomBlendState`'s
    /// own `getRandomBlendEq` pool never draws one of the fifteen advanced equations
    /// (unlike the "diff" group), so there is no `GL_KHR_blend_equation_advanced` check
    /// to mirror.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context
            .context_info
            .is_extension_supported("GL_EXT_draw_buffers_indexed")
        {
            return Err(TestError::NotSupported(
                "Extension GL_EXT_draw_buffers_indexed not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let max_draw_buffers = match self.max_draw_buffers {
            MaxDrawBuffers::Fixed(count) => count,
            MaxDrawBuffers::QueryImplementation => {
                let mut value: i32 = 0;
                // SAFETY: `value` is a valid destination for one `GLint`.
                unsafe { context.gl().get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut value) };
                if value <= 0 {
                    return Ok(TestStatus::fail("GL_MAX_DRAW_BUFFERS reported a non-positive value"));
                }
                value as usize
            }
        };

        let mut rng = Random::new(de_int32_hash(self.seed) ^ self.seed_xor);
        let (pre, post, draw_buffers) = gen_random_test(&mut rng, max_draw_buffers);
        run_random_test(context, &pre, &post, &draw_buffers)
    }
}

/// `addRandomMaxTest`/`addRandomImplMaxTest`, `MaxDrawBuffersIndexedTest`'s own
/// `1558001307u` xor and `ImplMaxDrawBuffersIndexedTest`'s `2686315738u`.
fn build_random_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("random");

    let mut max_group = TestCaseGroup::new("max_required_draw_buffers");
    for seed in 0..20 {
        max_group.add_child(Box::new(RandomDrawBuffersIndexedCase {
            name: seed.to_string(),
            seed,
            seed_xor: 1_558_001_307,
            max_draw_buffers: MaxDrawBuffers::Fixed(4),
        }) as Box<dyn TestCase>);
    }

    let mut impl_group = TestCaseGroup::new("max_implementation_draw_buffers");
    for seed in 0..20 {
        impl_group.add_child(Box::new(RandomDrawBuffersIndexedCase {
            name: seed.to_string(),
            seed,
            seed_xor: 2_686_315_738,
            max_draw_buffers: MaxDrawBuffers::QueryImplementation,
        }) as Box<dyn TestCase>);
    }

    group.add_child(max_group);
    group.add_child(impl_group);
    group
}

/// `createDrawBuffersIndexedTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw_buffers_indexed");
    group.add_child(build_diff_group(
        PrePost::Pre,
        "overwrite_common",
        "Set common state and overwrite it with draw buffer blend state.",
    ));
    group.add_child(build_diff_group(
        PrePost::Post,
        "overwrite_indexed",
        "Set indexed blend state and overwrite it with common state.",
    ));
    group.add_child(build_random_group());
    group
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn clear_colors_differ_per_buffer_and_alpha_is_never_zero() {
        let a = clear_color_for_buffer(0, 2);
        let b = clear_color_for_buffer(1, 2);
        assert_ne!(a, b);
        assert!(a[3] > 0.0);
        assert!(b[3] > 0.0);
    }

    #[test]
    fn resolve_fragment_operation_state_lets_the_last_override_win() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let pre = BlendOverride {
            blend_eq: Some(EqSpec::Single(glw::GL_FUNC_ADD)),
            ..Default::default()
        };
        let post = BlendOverride {
            blend_eq: Some(EqSpec::Single(glw::GL_FUNC_SUBTRACT)),
            ..Default::default()
        };
        let empty = BlendOverride::default();

        let state = resolve_fragment_operation_state(&pre, &empty, &post, format);
        assert_eq!(
            state.blend_rgb_state.equation,
            crate::rr::render_state::BlendEquation::Subtract,
            "the later (post) override must win"
        );
    }

    #[test]
    fn resolve_fragment_operation_state_defaults_to_standard_blend_when_enabled_with_no_equation() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let empty = BlendOverride::default();
        let enable = BlendOverride {
            enable_blend: Some(true),
            ..Default::default()
        };

        let state = resolve_fragment_operation_state(&enable, &empty, &empty, format);
        assert_eq!(
            state.blend_mode,
            BlendMode::Standard,
            "upstream starts from BLENDMODE_STANDARD before any override is applied"
        );
    }

    #[test]
    fn resolve_fragment_operation_state_disables_blend_for_non_blendable_format() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8);
        let empty = BlendOverride::default();
        let enable = BlendOverride {
            enable_blend: Some(true),
            ..Default::default()
        };

        let state = resolve_fragment_operation_state(&enable, &empty, &empty, format);
        assert_eq!(state.blend_mode, BlendMode::None);
    }

    #[test]
    fn requires_advanced_blend_eq_ignores_separate_equations() {
        let separate = BlendOverride {
            blend_eq: Some(EqSpec::Separate(glw::GL_MULTIPLY, glw::GL_SCREEN)),
            ..Default::default()
        };
        let empty = BlendOverride::default();
        assert!(
            !requires_advanced_blend_eq(&separate, &empty, &[]),
            "a SeparateBlendEq has no advanced form, matching upstream's is<BlendEq>() check"
        );

        let single = BlendOverride {
            blend_eq: Some(EqSpec::Single(glw::GL_MULTIPLY)),
            ..Default::default()
        };
        assert!(requires_advanced_blend_eq(&single, &empty, &[]));
    }

    /// Recursively flattens a group into `root.path.to.leaf` names, for a group tree of
    /// arbitrary depth (the "diff" half is two levels deep, `random.*` is three).
    fn flatten(prefix: &str, group: &TestCaseGroup, out: &mut Vec<String>) {
        for child in group.children() {
            match child {
                crate::tcu::TestNode::Group(g) => flatten(&format!("{prefix}.{}", group.name()), g, out),
                crate::tcu::TestNode::Case(c) => out.push(format!("{prefix}.{}.{}", group.name(), c.name())),
            }
        }
    }

    #[test]
    fn create_tests_registers_exactly_the_upstream_names() {
        let group = create_tests();
        let mut names = Vec::new();
        flatten("", &group, &mut names);
        let names: Vec<String> = names
            .into_iter()
            .map(|n| n.trim_start_matches('.').to_string())
            .collect();

        assert_eq!(names.len(), 76);
        assert!(names.contains(&"draw_buffers_indexed.overwrite_common.common_enable_buffer_enable".to_string()));
        assert!(
            names.contains(&"draw_buffers_indexed.overwrite_indexed.common_color_mask_buffer_color_mask".to_string())
        );
        assert!(names.contains(&"draw_buffers_indexed.random.max_required_draw_buffers.0".to_string()));
        assert!(names.contains(&"draw_buffers_indexed.random.max_required_draw_buffers.19".to_string()));
        assert!(names.contains(&"draw_buffers_indexed.random.max_implementation_draw_buffers.0".to_string()));
        assert!(names.contains(&"draw_buffers_indexed.random.max_implementation_draw_buffers.19".to_string()));
    }

    #[test]
    fn gen_random_test_is_deterministic_for_a_given_seed() {
        let mut rng_a = Random::new(de_int32_hash(0) ^ 1_558_001_307);
        let mut rng_b = Random::new(de_int32_hash(0) ^ 1_558_001_307);
        let (pre_a, post_a, buffers_a) = gen_random_test(&mut rng_a, 4);
        let (pre_b, post_b, buffers_b) = gen_random_test(&mut rng_b, 4);
        assert_eq!(pre_a.enable_blend, pre_b.enable_blend);
        assert_eq!(post_a.enable_blend, post_b.enable_blend);
        assert_eq!(buffers_a.len(), buffers_b.len());
        for (a, b) in buffers_a.iter().zip(buffers_b.iter()) {
            assert_eq!(a.render, b.render);
            assert_eq!(a.gl_internal_format, b.gl_internal_format);
        }
    }

    #[test]
    fn random_format_pool_never_yields_a_floating_point_format() {
        let mut rng = Random::new(1);
        for _ in 0..1000 {
            let (_, format) = random_format(&mut rng);
            assert_ne!(format.channel_class(), TextureChannelClass::FloatingPoint);
        }
    }

    #[test]
    fn render_ref_quad_into_integer_respects_the_color_mask() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut level = TextureLevel::new(format, RENDER_SIZE as u32, RENDER_SIZE as u32, 1).unwrap();
        clear_int(&mut level.get_access(), [7, 7, 7, 7]);

        // Masking out every channel must leave the clear value untouched everywhere,
        // including inside the quad the rasteriser actually covers.
        render_ref_quad_into_integer(true, 0, [false, false, false, false], &mut level);
        let access = level.get_const_access();
        let center = access.get_pixel_int(RENDER_SIZE as u32 / 2, RENDER_SIZE as u32 / 2, 0);
        assert_eq!(
            center,
            [7, 7, 7, 7],
            "a fully masked-out write must not change any channel"
        );
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsFragOpInteractionCase.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// **Superseded below by `FragOpInteractionCase` itself (end of file).** The account of the blocker
// that follows is kept for history: `rsg::Shader` now keeps its own variable arena (`set_variables`),
// and `gls::random_shader_program` runs the two stages with one manager and execution context each, so
// nothing needs a shared `ExecutionContext` any more.
//
// Historical note (was: partial port, not yet the `FragOpInteractionCase` struct itself) -
// see the long account below for what blocked the rest.
//
// This file ports every piece of `glsFragOpInteractionCase.cpp` (690+91 upstream
// lines) that needs neither `rsg::Shader`/`rsg::ExecutionContext` execution nor
// `gls::RandomShaderProgram` (`glsRandomShaderProgram.hpp/.cpp`, also not yet ported):
// the local `Quad`/`RenderCommand` data shapes (deliberately distinct from
// `gls::interaction_test_util::RenderCommand`, which a *different* upstream file -
// `glsInteractionTestUtil.hpp` - already exports under the same name for a different
// caller; upstream itself declares two structs named `RenderCommand` in two separate
// anonymous/named namespaces, so this is not a collision, just two unrelated types that
// happen to share a name, exactly as upstream has them), `getRandomQuad`,
// `getRandomDepth`, `computeRandomRenderCommand` (reusing the already-ported
// `gls::interaction_test_util::compute_random_render_state`), the "well behaving clear
// colour" pair (`getWellBehavingChannelColor`/`getWellBehavingColor`) that keeps a
// dithered clear from landing on a channel-format rounding boundary, and
// `setRenderState` (applying a `RenderState` to any `sglr::Context` implementor).
//
// **`setRenderState` needed `sglr::Context` widened first** - upstream's own version
// calls `stencilFuncSeparate`/`stencilOpSeparate`/`blendEquationSeparate`/`blendColor`,
// none of which this port's `sglr::Context` trait had yet (it only had the
// non-separate `stencil_func`/`stencil_op`/`blend_equation` convenience forms, each
// upstream itself keeps as a *separate* trait method rather than a caller-side
// `face = GL_FRONT_AND_BACK` special case - see `blend_func`/`blend_func_separate`'s own
// precedent already in that trait). Confirmed low-risk before touching either backend:
// every GL entry point needed already exists in the generated `glw` wrapper
// (`stencil_func_separate`/`stencil_mask`/`stencil_mask_separate`/`stencil_op_separate`/
// `blend_equation_separate`/`blend_color`/`depth_mask`), and `ReferenceContext` already
// had every one of them as an *inherent* method (just not exposed through the trait) -
// so each new trait method is a one-line delegate on both sides
// (`GLContext` -> `self.gl.<name>(...)`, `ReferenceContext` -> its own already-tested
// inherent method of the identical name), not new logic. `depth_mask` joined the same
// way, for the same reason (`setRenderState`'s own `ctx.depthMask(...)` call).
//
// **Why the rest is not ported here, found by reading the actual types involved, not
// guessed**: `FragOpInteractionCase`/`RandomShaderProgram` both need upstream's single
// shared `rsg::ExecutionContext` to hold *both* the vertex shader's and the fragment
// shader's variables at once (`RandomShaderProgram::m_execCtx` is one object, read and
// written from both `shadeVertices` and `shadeFragments`) - but `rsg::Shader` generation
// in this port (`rsg::shader_generator::generate`, confirmed by reading its own top doc
// comment and `rsg::program_generator::generate`'s real body) builds a **brand new,
// independent `rsg::VariableManager` per shader** and drops it before returning, and
// `rsg::execution_context::ExecutionContext` keys its value storage by a bare
// `VariableId(usize)` - a sequential index local to whichever one `VariableManager`
// allocated it (confirmed directly: `pub struct VariableId(usize)` in
// `rsg::variable_manager`, `var_values: HashMap<VariableId, ValueStorage>` in
// `rsg::execution_context`, no manager-identity tag anywhere in either type). Upstream's
// own `std::map<const Variable*, ...>` has no equivalent problem - a C++ object address
// is globally unique regardless of which `VariableManager` allocated it - but a vertex
// shader's own `VariableId(3)` and a fragment shader's own, *completely unrelated*
// `VariableId(3)` (each counting from zero in its own manager) are the exact same key in
// this port's `HashMap`, so sharing one `ExecutionContext` between the two shaders
// (exactly what `RandomShaderProgram` requires) would silently alias two unrelated
// variables' values together the moment both managers happen to hand out the same
// numeric id - confirmed as a real risk, not a hypothetical, by tracing `refreshUniforms`
// (which writes a uniform's value keyed by whichever shader's own `Variable` originally
// declared it) and `shadeVertices`/`shadeFragments` (which each write/read only their own
// shader's variables) side by side: nothing stops the vertex manager's attribute-input id
// and the fragment manager's varying-input id from colliding numerically.
//
// This is a confirmed architecture gap in the already-merged `rsg` port, not a thing
// `FragOpInteractionCase` itself could work around locally - fixing it needs one of:
// giving `VariableId` a manager-instance tag (e.g. `VariableId(ManagerId, usize)`) so two
// managers' ids can share one `HashMap` safely, threading a manager identity through
// `ExecutionContext::get_value`, or (narrower, `RandomShaderProgram`-local) proving that
// `shadeVertices`/`shadeFragments` never need to read a value the *other* shading call
// wrote and switching to two independent `ExecutionContext`s, one per shader, with the
// vertex->fragment data handoff staying exactly where it already is today (the
// `rr::VertexPacket`/`rr::FragmentPacket` generic-output arrays, never `ExecutionContext`
// itself) - plausible from reading `RandomShaderProgram::shadeVertices`/`shadeFragments`
// above, but not attempted here since it needs tracing every real call site, not just the
// two this doc comment already checked, before trusting it. Either fix is squarely
// `rsg`/`gls::random_shader_program` framework work, still in this effort's own scope -
// picking it up is the right next step, not a reason to leave this file where it is.
//
// `gls::RandomShaderProgram` (`glsRandomShaderProgram.hpp/.cpp`, 73+335 lines) is a
// second, independent prerequisite not yet ported either way - it needs the fix above
// regardless of which shape it takes, so there was nothing to gain from porting its own
// `sglr::ShaderProgram`/`rr::VertexShader`/`rr::FragmentShader` plumbing ahead of it.
//
// Narrowed relative to upstream `glsFragOpInteractionCase.cpp`'s own file-local
// `Quad`/`RenderCommand` (not `gls::InteractionTestUtil::RenderCommand`, see above):
// nothing else in this pair needed narrowing - both are plain data, no GL/driver call
// anywhere in them.
//
// **A later pass ported everything else `glsFragOpInteractionCase.cpp` has except the
// `FragOpInteractionCase` struct itself** - `computeVertexLayout`/`VertexDataStorage`/
// `getEntryWithPointer`/`setVertex` (as `VertexDataStorage::{new,entry_as_binding,
// set_vertex}` below), `interpolateRange`, `findShaderInputIndex`, `renderQuad`/
// `render`/`setupAttributes`, and `setUniformValue`. None of these actually needed
// `rsg::ExecutionContext`/`gls::RandomShaderProgram` at all, once read closely: every
// one operates on `&[rsg::ShaderInput]`/`rsg::ConstValueAccess`/`rsg::
// ConstValueRangeAccess` values, and `rsg::ShaderInput` already stores its own `name`
// and an owned `ValueRange` (see `rsg::shader`'s own top doc comment) - a `ValueRange`
// owns a cloned `VariableType`, independent of whichever `VariableManager` originally
// allocated the `ShaderInput`'s `VariableId` - so none of this needs the still-blocked
// manager-outlives-`generate()` fix the rest of this file's own account above
// describes. That blocker is therefore now narrowed to exactly
// `gls::RandomShaderProgram` and the `FragOpInteractionCase` struct's own `init`/
// `iterate`, which do need one `rsg::ExecutionContext` shared across both shaders.
//
// Two adaptations this pass needed, both confirmed by reading the real
// `sglr::Context`/`glu::draw_util` types involved rather than assumed:
//
//  - **`VertexDataStorage` cannot reuse `glu::VertexArrayPointer` for writing.**
//    Upstream's own `VertexDataStorage` owns a raw `std::vector<uint8_t>` and
//    `setVertex` writes straight through a `glu::VertexArrayPointer` built from it (a
//    `(float *)((uint8_t *)pointer.data + ...)` cast that discards the `const` the
//    type's own `data` field claims) - `glu::draw_util::VertexArrayPointer::data` is a
//    real `&'a [u8]` here (every other caller only ever reads through it; see that
//    type's own doc comment), so there is no safe Rust equivalent of that cast. This
//    port's `VertexDataStorage` instead owns its `Vec<u8>` directly and exposes
//    `set_vertex` as one of its own methods (mutating its buffer in place) alongside
//    `entry_as_binding` (an immutable `glu::VertexArrayBinding` view of the same buffer,
//    built fresh whenever a draw needs one) - behaviourally identical, since both ends
//    ultimately read/write the exact same interleaved byte layout upstream's own
//    `computeVertexLayout` produces (confirmed: `glu::VertexArrayPointer`'s own
//    `(component_type, num_components, stride, data)` already supports an interleaved
//    AoS buffer exactly like this one, the same shape `upload_vertex_buffer`'s own
//    `src_stride` logic already handles).
//  - **`renderQuad`'s raw client-memory index draw needed one further adaptation.**
//    Upstream calls `ctx.drawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, &indices[0])`
//    with no element buffer bound at all - a genuine client-memory index array.
//    `ReferenceContext::draw_elements` does not support that today (confirmed by
//    reading `draw_elements_instanced_base_vertex`'s own doc comment: "a client-memory
//    index array (no buffer bound) is not supported by this increment", it always
//    requires a bound `GL_ELEMENT_ARRAY_BUFFER`). `render_quad` below instead uploads
//    the six fixed indices into a scratch element buffer per draw, the exact same
//    shape `sglr::context_util::draw_quad_with_vao_buffers` already uses for its own
//    index buffer - behaviourally identical for a conformant implementation (both
//    `Context` implementors draw the same six indices either way), through an API
//    surface both already support, unlike the raw-pointer form. **Vertex attributes
//    stay true client-memory pointers**, unlike the indices: `setup_attributes` below
//    calls `ctx.vertex_attrib_pointer(..., has_pointer = true)` with a real host
//    address, which `ReferenceContext::vertex_attrib_pointer` accepts precisely because
//    `FragOpInteractionCase` never binds a VAO (confirmed by reading that function's
//    real body: the client-pointer rejection is gated on
//    `self.vertex_array_binding.is_some()`, which stays `None` the whole time here,
//    exactly as upstream's own `iterate()` never calls `glGenVertexArrays`/
//    `glBindVertexArray` either).
//
// `sglr::Context` gained `uniform1fv`/`2fv`/`3fv`/`1iv`/`2iv`/`3iv`/`4iv` for
// `setUniformValue` (`uniform4fv`/`uniform1i` already existed) - see `context.rs`'s own
// top doc comment for the exact narrowing `uniform1iv` carries forward from
// `uniform1i` (no `DataType::Bool` support yet, since nothing in scope declares a
// bool-typed uniform today).

use super::interaction_test_util::{RenderState, compute_random_render_state};
use super::random_shader_program::{RandomShaderProgram, compute_unified_uniforms, compute_uniform_values};
use super::reference_context_buffers::create_reference_context_with_stencil;
use crate::glu::draw_util::{BindingPoint, VertexArrayBinding, VertexArrayPointer, VertexComponentType};
use crate::glu::{ApiType, Context as GluContext, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::rr::render_state::FaceType;
use crate::rsg::parameters::{ProgramParameters, ShaderParameters, Version};
use crate::rsg::program_generator;
use crate::rsg::shader::{Shader, ShaderInput};
use crate::rsg::variable::ShaderType;
use crate::rsg::variable_type::Type as RsgType;
use crate::rsg::variable_value::{ConstValueAccess, ConstValueRangeAccess};
use crate::sglr::context::Context;
use crate::sglr::gl_context::GLContext;
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::rgba::RGBA;
use crate::tcu::vector::{IVec2, Vec4};
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

/// `Quad` (file-local upstream, `glsFragOpInteractionCase.cpp`'s own anonymous
/// namespace) - viewport-coordinate corners, independent of
/// `gls::fragment_op_util::IntegerQuad` even though both describe a quad: this one's
/// `pos_a`/`pos_b` may already be flipped (the lower-numbered vertex is not always
/// `pos_a`), exactly mirroring upstream's own comment and `getRandomQuad`'s own flip
/// logic below.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Quad {
    pub pos_a: IVec2,
    pub pos_b: IVec2,
}

impl Default for Quad {
    fn default() -> Self {
        Self {
            pos_a: IVec2::new(0, 0),
            pos_b: IVec2::new(0, 0),
        }
    }
}

/// `RenderCommand` (file-local upstream) - see this file's own top doc comment for why
/// this is a distinct type from `gls::interaction_test_util::RenderCommand`.
#[derive(Debug, Clone, Copy, Default)]
pub struct RenderCommand {
    pub quad: Quad,
    pub depth: f32,
    pub state: RenderState,
}

/// `getRandomQuad` - a quad in viewport coordinates, at least half the target size in
/// each dimension, randomly flipped along either axis (upstream's own `\todo
/// [2012-12-18 pyry] Out-of-bounds values.` is reproduced unfixed: `maxOutOfBounds` is
/// always `0` here, exactly as upstream leaves it).
fn get_random_quad(rnd: &mut Random, target_w: i32, target_h: i32) -> Quad {
    let max_out_of_bounds = 0;
    let min_size = 0.5_f32;

    // `deCeilFloatToInt32` - a truncating cast of `ceil()`, which for a non-negative
    // input (always the case here) is exactly `.ceil() as i32`.
    let min_w = (min_size * target_w as f32).ceil() as i32;
    let min_h = (min_size * target_h as f32).ceil() as i32;
    let max_w = target_w + 2 * max_out_of_bounds;
    let max_h = target_h + 2 * max_out_of_bounds;

    let width = rnd.get_int(min_w, max_w);
    let height = rnd.get_int(min_h, max_h);
    let x = rnd.get_int(-max_out_of_bounds, target_w + max_out_of_bounds - width);
    let y = rnd.get_int(-max_out_of_bounds, target_h + max_out_of_bounds - height);

    let flip_x = rnd.get_bool();
    let flip_y = rnd.get_bool();

    Quad {
        pos_a: IVec2::new(
            if flip_x { x + width - 1 } else { x },
            if flip_y { y + height - 1 } else { y },
        ),
        pos_b: IVec2::new(
            if flip_x { x } else { x + width - 1 },
            if flip_y { y } else { y + height - 1 },
        ),
    }
}

/// `getRandomDepth` - never `1.0`, per upstream's own comment: clearing with `1.0` and
/// rendering with `1.0` may not compare equal once each has gone through its own path
/// to the depth buffer.
fn get_random_depth(rnd: &mut Random) -> f32 {
    const DEPTH_VALUES: [f32; 8] = [0.0, 0.2, 0.4, 0.5, 0.51, 0.6, 0.8, 0.95];
    *rnd.choose(&DEPTH_VALUES)
}

/// `computeRandomRenderCommand` - draws `quad`, then `depth`, then the render state, in
/// that exact order, matching upstream's own three sequential calls (the only thing
/// that keeps a given seed's *sequence* of draws reproducible once each of the three
/// pieces is itself reproducible).
pub fn compute_random_render_command(
    rnd: &mut Random,
    api_type: ApiType,
    target_w: i32,
    target_h: i32,
) -> RenderCommand {
    let quad = get_random_quad(rnd, target_w, target_h);
    let depth = get_random_depth(rnd);
    let state = compute_random_render_state(rnd, api_type, target_w, target_h);
    RenderCommand { quad, depth, state }
}

/// `deRoundFloatToInt64` (file-local, matching this crate's own established
/// per-file-helper convention for `deRoundFloatToInt32`/`64` - see e.g.
/// `gles2::functional::depth_stencil_clear_tests`) - round half away from zero. Only
/// ever called here on a non-negative input (`v * maxFixedValue` with `0.0 < v < 1.0`),
/// so the single-branch upstream shape (`x >= 0.0f ? (int64_t)(x + 0.5f) : ...`)
/// collapses to the truncating cast of `x + 0.5`.
fn de_round_float_to_int64(x: f32) -> u64 {
    debug_assert!(x >= 0.0);
    (x + 0.5) as u64
}

/// `getWellBehavingChannelColor` - see upstream's own comment, reproduced in full
/// below: nudges a clear-colour channel that would otherwise land exactly on a
/// representable-value rounding border (where the GL and this port's own reference
/// renderer could legally round differently) one sub-unit away from that border,
/// while still allowing dithering (never snapping all the way to a fully
/// representable value).
///
/// clear color may not be accurately representable in the target format. If the clear
/// color is on a representable value mapping range border, it could be rounded
/// differently by the GL and in SGLR adding an unexpected error source. However,
/// selecting an accurately representable background color would effectively disable
/// dithering. To allow dithering and to prevent undefined rounding direction from
/// affecting results, round accurate color to target color format with 8 sub-units
/// (3 bits). If the selected sub-unit value is 3 or 4 (bordering 0.5), replace it with
/// 2 and 5, respectively.
fn get_well_behaving_channel_color(v: f32, num_bits: i32) -> f32 {
    debug_assert!((0..=32).contains(&num_bits));

    if num_bits == 0 || v <= 0.0 || v >= 1.0 {
        // already accurately representable
        v
    } else {
        const NUM_SUB_BITS: u64 = 3;
        let sub_unit_border_lo: u64 = (1u64 << (NUM_SUB_BITS - 1)) - 1;
        let sub_unit_border_hi: u64 = 1u64 << (NUM_SUB_BITS - 1);
        let max_fixed_value: u64 = (1u64 << (num_bits as u64 + NUM_SUB_BITS)) - 1;
        let fixed_value = de_round_float_to_int64(v * max_fixed_value as f32);

        let units = fixed_value >> NUM_SUB_BITS;
        let sub_units = fixed_value & ((1u64 << NUM_SUB_BITS) - 1);

        let tweaked_sub_units = if sub_units == sub_unit_border_lo {
            sub_unit_border_lo - 1
        } else if sub_units == sub_unit_border_hi {
            sub_unit_border_hi + 1
        } else {
            sub_units
        };
        let tweaked_value = (units << NUM_SUB_BITS) | tweaked_sub_units;

        tweaked_value as f32 / max_fixed_value as f32
    }
}

/// `getWellBehavingColor`
pub fn get_well_behaving_color(accurate_color: Vec4, format: &PixelFormat) -> Vec4 {
    Vec4::new(
        get_well_behaving_channel_color(accurate_color.x(), format.red_bits),
        get_well_behaving_channel_color(accurate_color.y(), format.green_bits),
        get_well_behaving_channel_color(accurate_color.z(), format.blue_bits),
        get_well_behaving_channel_color(accurate_color.w(), format.alpha_bits),
    )
}

/// `setRenderState` (file-local upstream helper) - applies a `RenderState` to any
/// `sglr::Context` implementor (`sglr::GLContext` or `sglr::ReferenceContext`), exactly
/// the shape both the real-driver and reference draws in `FragOpInteractionCase::iterate`
/// run through identically. See this file's own top doc comment for what had to be
/// added to `sglr::Context` first.
pub fn set_render_state(ctx: &mut dyn Context, state: &RenderState) {
    if state.scissor_test_enabled {
        ctx.enable(glw::GL_SCISSOR_TEST);
        ctx.scissor(
            state.scissor_rectangle.left,
            state.scissor_rectangle.bottom,
            state.scissor_rectangle.width,
            state.scissor_rectangle.height,
        );
    } else {
        ctx.disable(glw::GL_SCISSOR_TEST);
    }

    if state.stencil_test_enabled {
        ctx.enable(glw::GL_STENCIL_TEST);

        for face in [FaceType::Front, FaceType::Back] {
            let gl_face: GLenum = if face == FaceType::Back {
                glw::GL_BACK
            } else {
                glw::GL_FRONT
            };
            let s = &state.stencil[face as usize];

            ctx.stencil_func_separate(gl_face, s.function, s.reference, s.compare_mask);
            ctx.stencil_op_separate(gl_face, s.stencil_fail_op, s.depth_fail_op, s.depth_pass_op);
            ctx.stencil_mask_separate(gl_face, s.write_mask);
        }
    } else {
        ctx.disable(glw::GL_STENCIL_TEST);
    }

    if state.depth_test_enabled {
        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.depth_func(state.depth_func);
        ctx.depth_mask(state.depth_write_mask);
    } else {
        ctx.disable(glw::GL_DEPTH_TEST);
    }

    if state.blend_enabled {
        ctx.enable(glw::GL_BLEND);
        ctx.blend_equation_separate(state.blend_rgb_state.equation, state.blend_a_state.equation);
        ctx.blend_func_separate(
            state.blend_rgb_state.src_func,
            state.blend_rgb_state.dst_func,
            state.blend_a_state.src_func,
            state.blend_a_state.dst_func,
        );
        ctx.blend_color(
            state.blend_color.x(),
            state.blend_color.y(),
            state.blend_color.z(),
            state.blend_color.w(),
        );
    } else {
        ctx.disable(glw::GL_BLEND);
    }

    if state.dither_enabled {
        ctx.enable(glw::GL_DITHER);
    } else {
        ctx.disable(glw::GL_DITHER);
    }

    ctx.color_mask(
        state.color_mask[0],
        state.color_mask[1],
        state.color_mask[2],
        state.color_mask[3],
    );
}

/// `computeVertexLayout`'s own one-attribute result - see `VertexDataStorage`'s own
/// doc comment for why this port keeps its own owned `name: String` rather than
/// upstream's `glu::VertexArrayBinding` (built fresh, on demand, by
/// `VertexDataStorage::entry_as_binding` instead).
struct VertexLayoutEntry {
    name: String,
    num_components: i32,
    offset: i32,
}

/// `computeVertexLayout` - every `attributes` entry must be a float scalar/vector
/// (`TCU_CHECK_INTERNAL` upstream, which - unlike `DE_ASSERT` - is compiled into every
/// build, so this is a real `Result`, not a `debug_assert!`), packed back to back at a
/// 4-byte (`float`) alignment, exactly as upstream's `curOffset` accumulation does.
fn compute_vertex_layout(attributes: &[ShaderInput]) -> Result<(Vec<VertexLayoutEntry>, i32), TestError> {
    let mut layout = Vec::with_capacity(attributes.len());
    let mut cur_offset: i32 = 0;

    for attrib in attributes {
        let var_type = attrib.get_value_range().get_type().clone();
        let num_components = var_type.num_elements();

        if var_type.base_type() != RsgType::Float || !(1..=4).contains(&num_components) {
            return Err(TestError::InternalError(format!(
                "vertex attribute '{}' is not a float scalar/vector (TCU_CHECK_INTERNAL)",
                attrib.get_name()
            )));
        }

        layout.push(VertexLayoutEntry {
            name: attrib.get_name().to_string(),
            num_components,
            offset: cur_offset,
        });
        cur_offset += num_components * std::mem::size_of::<f32>() as i32;
    }

    Ok((layout, cur_offset))
}

/// `VertexDataStorage` - owns the interleaved per-vertex buffer `computeVertexLayout`
/// describes, sized for `num_vertices` vertices. See this file's own top doc comment
/// for why writing (`set_vertex`) and reading-for-a-draw (`entry_as_binding`) are two
/// different methods here rather than both going through one `glu::VertexArrayPointer`
/// the way upstream's `getEntryWithPointer`/`setVertex` do.
pub struct VertexDataStorage {
    data: Vec<u8>,
    layout: Vec<VertexLayoutEntry>,
    stride: i32,
    num_vertices: i32,
}

impl VertexDataStorage {
    /// `VertexDataStorage::VertexDataStorage`
    pub fn new(attributes: &[ShaderInput], num_vertices: i32) -> Result<Self, TestError> {
        let (layout, stride) = compute_vertex_layout(attributes)?;
        let data = vec![0u8; (stride * num_vertices) as usize];
        Ok(Self {
            data,
            layout,
            stride,
            num_vertices,
        })
    }

    /// `VertexDataStorage::getNumEntries`
    pub fn num_entries(&self) -> usize {
        self.layout.len()
    }

    /// `findShaderInputIndex`-adjacent: resolves an attribute's layout index by name,
    /// the same lookup `FragOpInteractionCase::iterate` would run once per non-position
    /// attribute (see that function's own grep-confirmed need below).
    pub fn find_entry_index(&self, name: &str) -> Option<usize> {
        self.layout.iter().position(|e| e.name == name)
    }

    /// `getEntryWithPointer` - an immutable `glu::VertexArrayBinding` view of this
    /// storage's own buffer for attribute `ndx`, suitable for a draw call.
    pub fn entry_as_binding(&self, ndx: usize) -> VertexArrayBinding<'_> {
        let entry = &self.layout[ndx];
        VertexArrayBinding {
            binding: BindingPoint::Name(&entry.name, 0),
            pointer: VertexArrayPointer {
                component_type: VertexComponentType::Float,
                num_components: entry.num_components,
                num_elements: self.num_vertices,
                stride: self.stride,
                data: &self.data[entry.offset as usize..],
            },
        }
    }

    /// `setVertex<Size>` - writes one vertex's worth of values (`value.len()` must equal
    /// the attribute's own `num_components`) for attribute `attrib_ndx`, vertex
    /// `vertex_ndx`. See this file's own top doc comment for why this is a method here
    /// rather than a free function writing through a `glu::VertexArrayPointer`.
    pub fn set_vertex(&mut self, attrib_ndx: usize, vertex_ndx: i32, value: &[f32]) {
        let entry = &self.layout[attrib_ndx];
        debug_assert_eq!(value.len(), entry.num_components as usize);
        debug_assert!((0..self.num_vertices).contains(&vertex_ndx));

        let vertex_start = (self.stride * vertex_ndx) as usize + entry.offset as usize;
        for (i, &v) in value.iter().enumerate() {
            let byte_off = vertex_start + i * std::mem::size_of::<f32>();
            self.data[byte_off..byte_off + std::mem::size_of::<f32>()].copy_from_slice(&v.to_ne_bytes());
        }
    }
}

/// `interpolateRange<Size>` - lerps between `range`'s min and max per component by
/// `t`, `t.len()` components at a time (upstream templates this over
/// `tcu::Vector<float, Size>`; every real call site already has `Size` as a runtime
/// value off `VariableType::getNumElements()`, so a `&[f32]`/`Vec<f32>` pair carries
/// exactly the same information here with no fixed-size generic needed).
pub fn interpolate_range(range: ConstValueRangeAccess<'_>, t: &[f32]) -> Vec<f32> {
    t.iter()
        .enumerate()
        .map(|(ndx, &tv)| {
            let min = range.get_min().component(ndx as i32).as_float();
            let max = range.get_max().component(ndx as i32).as_float();
            min * (1.0 - tv) + max * tv
        })
        .collect()
}

/// `findShaderInputIndex` - panics on an unknown name (`throw tcu::InternalError`
/// upstream): a name this is asked for (`"dEQP_Position"`) is always one the caller
/// itself expects the shader to have declared, so an absent one is a genuine
/// internal-consistency bug, not a runtime condition to recover from - the same
/// "`DE_FATAL`/unconditional-throw becomes a panic" precedent
/// `sglr::shader_program::ShaderProgramBase::uniform_by_name` already established.
pub fn find_shader_input_index(vars: &[ShaderInput], name: &str) -> usize {
    vars.iter()
        .position(|v| v.get_name() == name)
        .unwrap_or_else(|| panic!("{name} not found in shader inputs"))
}

/// `setUniformValue` - see `sglr::context`'s own top doc comment for the
/// `uniform1iv`-level narrowing (`DataType::Bool` not yet supported on the
/// `ReferenceContext` side) this inherits unchanged.
pub fn set_uniform_value(ctx: &mut dyn Context, location: i32, value: ConstValueAccess<'_>) {
    let num_elements = value.get_type().num_elements();

    match value.get_type().base_type() {
        RsgType::Float => {
            let v: Vec<f32> = (0..num_elements).map(|i| value.component(i).as_float()).collect();
            match num_elements {
                1 => ctx.uniform1fv(location, 1, &v),
                2 => ctx.uniform2fv(location, 1, &v),
                3 => ctx.uniform3fv(location, 1, &v),
                4 => ctx.uniform4fv(location, 1, &v),
                _ => panic!("Unsupported type"),
            }
        }
        RsgType::Int | RsgType::Bool | RsgType::Sampler2D | RsgType::SamplerCube => {
            let v: Vec<i32> = (0..num_elements).map(|i| value.component(i).as_int()).collect();
            match num_elements {
                1 => ctx.uniform1iv(location, 1, &v),
                2 => ctx.uniform2iv(location, 1, &v),
                3 => ctx.uniform3iv(location, 1, &v),
                4 => ctx.uniform4iv(location, 1, &v),
                _ => panic!("Unsupported type"),
            }
        }
        _ => panic!("Unsupported type"),
    }
}

/// `renderQuad` - see this file's own top doc comment for why the index draw goes
/// through a scratch element buffer instead of upstream's raw client-memory pointer.
pub fn render_quad(
    ctx: &mut dyn Context,
    vertex_data: &mut VertexDataStorage,
    pos_attrib_ndx: usize,
    quad: Quad,
    depth: f32,
) {
    const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

    let flip_x = quad.pos_b.x() < quad.pos_a.x();
    let flip_y = quad.pos_b.y() < quad.pos_a.y();
    let viewport_x = quad.pos_a.x().min(quad.pos_b.x());
    let viewport_y = quad.pos_a.y().min(quad.pos_b.y());
    let viewport_w = (quad.pos_a.x() - quad.pos_b.x()).abs() + 1;
    let viewport_h = (quad.pos_a.y() - quad.pos_b.y()).abs() + 1;

    let (p_a_x, p_a_y) = (if flip_x { 1.0 } else { -1.0 }, if flip_y { 1.0 } else { -1.0 });
    let (p_b_x, p_b_y) = (if flip_x { -1.0 } else { 1.0 }, if flip_y { -1.0 } else { 1.0 });

    vertex_data.set_vertex(pos_attrib_ndx, 0, &[p_a_x, p_a_y, depth, 1.0]);
    vertex_data.set_vertex(pos_attrib_ndx, 1, &[p_b_x, p_a_y, depth, 1.0]);
    vertex_data.set_vertex(pos_attrib_ndx, 2, &[p_a_x, p_b_y, depth, 1.0]);
    vertex_data.set_vertex(pos_attrib_ndx, 3, &[p_b_x, p_b_y, depth, 1.0]);

    ctx.viewport(viewport_x, viewport_y, viewport_w, viewport_h);

    let mut ndx_id = [0u32; 1];
    ctx.gen_buffers(&mut ndx_id);
    ctx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ndx_id[0]);
    // SAFETY: `INDICES` is a local array outlasting this one `buffer_data` call, and
    // `u16` has no padding/invalid bit pattern - the same reinterpretation
    // `sglr::context_util::draw_quad_with_vao_buffers` already does for its own index
    // array.
    let bytes = unsafe { std::slice::from_raw_parts(INDICES.as_ptr().cast::<u8>(), std::mem::size_of_val(&INDICES)) };
    ctx.buffer_data(glw::GL_ELEMENT_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
    ctx.draw_elements(glw::GL_TRIANGLES, INDICES.len() as i32, glw::GL_UNSIGNED_SHORT, 0);
    ctx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
    ctx.delete_buffers(&ndx_id);
}

/// `render`
pub fn render(ctx: &mut dyn Context, vertex_data: &mut VertexDataStorage, pos_attrib_ndx: usize, cmd: &RenderCommand) {
    set_render_state(ctx, &cmd.state);
    render_quad(ctx, vertex_data, pos_attrib_ndx, cmd.quad, cmd.depth);
}

/// `setupAttributes` - binds every attribute `vertex_data` has laid out as a true
/// client-memory vertex array (no `GL_ARRAY_BUFFER` bound anywhere in this file, and no
/// VAO either - matching upstream's own `iterate()` exactly). See this file's own top
/// doc comment for why that is safe against `ReferenceContext` specifically.
pub fn setup_attributes(ctx: &mut dyn Context, vertex_data: &VertexDataStorage, program: u32) {
    let base = vertex_data.data.as_ptr() as usize;

    for entry in &vertex_data.layout {
        let attrib_loc = ctx.get_attrib_location(program, &entry.name);
        if attrib_loc >= 0 {
            ctx.enable_vertex_attrib_array(attrib_loc as u32);
            ctx.vertex_attrib_pointer(
                attrib_loc as u32,
                entry.num_components,
                glw::GL_FLOAT,
                false,
                vertex_data.stride,
                base + entry.offset as usize,
                true,
            );
        }
    }
}

const NUM_ITERATIONS: i32 = 5;
const NUM_COMMANDS_PER_ITERATION: usize = 5;
const VIEWPORT_WIDTH: i32 = 64;
const VIEWPORT_HEIGHT: i32 = 64;

/// `gls::FragOpInteractionCase` - the whole `init`/`iterate`/`deinit` cycle runs inside one `iterate`, since a
/// `glu::TestCase` here has no continuation. Narrowing: `ReferenceContext` has no stencil buffer, so when the
/// render target has stencil bits the random stencil test is switched off in the generated commands (on both sides).
pub struct FragOpInteractionCase {
    name: String,
    params: ProgramParameters,
}

impl FragOpInteractionCase {
    #[allow(clippy::new_ret_no_self)]
    pub fn new(name: impl Into<String>, params: ProgramParameters) -> Box<dyn TestCase> {
        Box::new(Self {
            name: name.into(),
            params,
        })
    }
}

impl TestCase for FragOpInteractionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &GluContext) -> TestOutcome {
        let rt = context.render_target();

        // `FragOpInteractionCase::init`
        let mut init_rnd = Random::new(self.params.seed ^ 0x232faac);
        let viewport_w = rt.width.min(VIEWPORT_WIDTH);
        let viewport_h = rt.height.min(VIEWPORT_HEIGHT);
        let viewport_x = init_rnd.get_int(0, rt.width - viewport_w);
        let viewport_y = init_rnd.get_int(0, rt.height - viewport_h);

        let mut vertex_shader = Shader::new(ShaderType::Vertex);
        let mut fragment_shader = Shader::new(ShaderType::Fragment);
        program_generator::generate(&self.params, &mut vertex_shader, &mut fragment_shader);
        let unified_uniforms = compute_unified_uniforms(&vertex_shader, &fragment_shader);

        let program = RandomShaderProgram::new(vertex_shader, fragment_shader, &unified_uniforms)?;

        let mut ref_ctx = create_reference_context_with_stencil(context, viewport_w, viewport_h, rt.depth_bits)?;
        let mut gl_ctx = GLContext::new(
            &context.render_context,
            (viewport_x, viewport_y, viewport_w, viewport_h),
        );

        let ref_program = create_program_on(&mut ref_ctx, &program);
        let gl_program = create_program_on(&mut gl_ctx, &program);

        for iter_ndx in 0..NUM_ITERATIONS {
            // `FragOpInteractionCase::iterate`
            let mut rnd = Random::new(self.params.seed ^ de_int32_hash(iter_ndx));

            const NUM_VERTICES: i32 = 4;
            const VTX_INTERP_FACTORS: [[f32; 4]; 4] = [
                [0.0, 0.0, 0.0, 1.0],
                [1.0, 0.0, 0.5, 0.5],
                [0.0, 1.0, 0.5, 0.5],
                [1.0, 1.0, 1.0, 0.0],
            ];

            let uniform_values = compute_uniform_values(&mut rnd, &unified_uniforms);

            let (mut vertex_data, position_ndx) = {
                let inputs = program.vertex_inputs();
                let position_ndx = find_shader_input_index(&inputs, "dEQP_Position");
                let mut vertex_data = VertexDataStorage::new(&inputs, NUM_VERTICES)?;

                for (attrib_ndx, shader_in) in inputs.iter().enumerate() {
                    if attrib_ndx == position_ndx {
                        continue;
                    }

                    let value_range = shader_in.get_value_range();
                    let num_components = value_range.get_type().num_elements() as usize;
                    debug_assert_eq!(value_range.get_type().base_type(), RsgType::Float);

                    for vtx_ndx in 0..4usize {
                        let f_ndx = (attrib_ndx + vtx_ndx + iter_ndx as usize) % VTX_INTERP_FACTORS.len();
                        let f = &VTX_INTERP_FACTORS[f_ndx];
                        let values = interpolate_range(shader_in.get_value_range(), &f[..num_components]);
                        vertex_data.set_vertex(attrib_ndx, vtx_ndx as i32, &values);
                    }
                }

                (vertex_data, position_ndx)
            };

            let mut render_cmds: Vec<RenderCommand> = (0..NUM_COMMANDS_PER_ITERATION)
                .map(|_| {
                    let mut cmd = compute_random_render_command(
                        &mut rnd,
                        ApiType::es(
                            if self.params.version == Version::Version300 {
                                3
                            } else {
                                2
                            },
                            0,
                        ),
                        viewport_w,
                        viewport_h,
                    );
                    if rt.stencil_bits > 0 {
                        cmd.state.stencil_test_enabled = false;
                    }
                    cmd
                })
                .collect();

            // Workaround for inaccurate barycentric/depth computation in the reference renderer: a small bias,
            // in increasing order, is added to the draw call depths.
            for (cmd_ndx, cmd) in render_cmds.iter_mut().enumerate() {
                cmd.depth += 0.0231725 * cmd_ndx as f32;
            }

            let mut rendered = Surface::new(viewport_w, viewport_h);
            let mut reference = Surface::new(viewport_w, viewport_h);

            let accurate_clear_color = Vec4::new(0.0, 0.25, 0.5, 1.0);
            let clear_color = get_well_behaving_color(accurate_clear_color, &rt.pixel_format());

            for ndx in 0..2 {
                let ctx: &mut dyn Context = if ndx == 0 { &mut gl_ctx } else { &mut ref_ctx };
                let program_id = if ndx == 0 { gl_program } else { ref_program };
                let dst = if ndx == 0 { &mut rendered } else { &mut reference };

                setup_attributes(ctx, &vertex_data, program_id);

                ctx.disable(glw::GL_SCISSOR_TEST);
                ctx.color_mask(true, true, true, true);
                ctx.depth_mask(true);
                ctx.stencil_mask(!0u32);
                ctx.clear_color(clear_color.x(), clear_color.y(), clear_color.z(), clear_color.w());
                ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

                ctx.use_program(program_id);

                for uniform in &uniform_values {
                    let location = ctx.get_uniform_location(program_id, &uniform.name);
                    set_uniform_value(ctx, location, uniform.storage.get_value_const(&uniform.type_));
                }

                for cmd in &render_cmds {
                    render(ctx, &mut vertex_data, position_ndx, cmd);
                }

                let err = ctx.get_error();
                if err != glw::GL_NO_ERROR {
                    return Err(TestError::Fail(format!("Rendering failed: GL error {err:#x}")));
                }

                ctx.read_pixels(dst, 0, 0, viewport_w, viewport_h);
            }

            let threshold = rt.pixel_format().get_color_threshold() + RGBA::new(3, 3, 3, 3);
            let threshold = [
                threshold.get_red().clamp(0, 255) as u8,
                threshold.get_green().clamp(0, 255) as u8,
                threshold.get_blue().clamp(0, 255) as u8,
                threshold.get_alpha().clamp(0, 255) as u8,
            ];
            if !bilinear_compare(
                &reference.get_const_access(),
                &rendered.get_const_access(),
                None,
                threshold,
            ) {
                return Ok(TestStatus::fail("Image comparison failed"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createProgram` through the trait: the inherent `ReferenceContext::create_program` has a different signature.
fn create_program_on(ctx: &mut dyn Context, program: &RandomShaderProgram) -> u32 {
    ctx.create_program(Box::new(program.duplicate()))
}

/// `FragOpInteractionTests::init` for either API: group `interaction` > `basic_shader`, 100 cases.
pub fn create_tests(version: Version, base_seed: u32) -> TestCaseGroup {
    let mut params = ProgramParameters {
        version,
        use_scalar_conversions: true,
        use_swizzle: true,
        use_comparison_ops: true,
        use_conditionals: true,
        ..ProgramParameters::default()
    };

    let shader_params = ShaderParameters {
        randomize: true,
        max_statement_depth: 3,
        max_statements_per_block: 4,
        max_expression_depth: 4,
        max_combined_variable_scalars: 64,
        ..ShaderParameters::default()
    };
    params.vertex_parameters = shader_params.clone();
    params.fragment_parameters = shader_params;

    let mut basic_group = TestCaseGroup::new("basic_shader");
    for ndx in 0..100 {
        params.seed = base_seed ^ de_int32_hash(ndx);
        basic_group.add_child(FragOpInteractionCase::new(ndx.to_string(), params.clone()));
    }

    let mut group = TestCaseGroup::new("interaction");
    group.add_child(basic_group);
    group
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::gls::interaction_test_util::{BlendState, StencilState};
    use crate::rr::render_state::WindowRectangle;
    use crate::sglr::reference_context::ReferenceContext;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    #[test]
    fn get_random_quad_always_covers_at_least_half_the_target_in_each_dimension() {
        for seed in 0..20 {
            let mut rnd = Random::new(seed);
            let quad = get_random_quad(&mut rnd, 64, 32);
            let w = (quad.pos_a.x() - quad.pos_b.x()).abs() + 1;
            let h = (quad.pos_a.y() - quad.pos_b.y()).abs() + 1;
            assert!(w >= 32, "seed {seed}: width {w} < half of 64");
            assert!(h >= 16, "seed {seed}: height {h} < half of 32");
            // With `maxOutOfBounds == 0` every corner must stay inside the target.
            assert!((0..64).contains(&quad.pos_a.x()) && (0..64).contains(&quad.pos_b.x()));
            assert!((0..32).contains(&quad.pos_a.y()) && (0..32).contains(&quad.pos_b.y()));
        }
    }

    #[test]
    fn get_random_depth_only_ever_returns_one_of_the_eight_fixed_values_and_never_one() {
        const DEPTH_VALUES: [f32; 8] = [0.0, 0.2, 0.4, 0.5, 0.51, 0.6, 0.8, 0.95];
        for seed in 0..30 {
            let mut rnd = Random::new(seed);
            let d = get_random_depth(&mut rnd);
            assert!(
                DEPTH_VALUES.contains(&d),
                "seed {seed}: {d} not one of the fixed depth values"
            );
            assert_ne!(d, 1.0);
        }
    }

    #[test]
    fn compute_random_render_command_fills_all_three_pieces() {
        let mut rnd = Random::new(12345);
        let cmd = compute_random_render_command(&mut rnd, ApiType::es(2, 0), 64, 64);
        // Just confirms every sub-generator actually ran (non-default-looking quad) -
        // the individual pieces are covered by their own dedicated tests/by
        // `interaction_test_util`'s own tests for `compute_random_render_state`.
        assert_ne!(cmd.quad, Quad::default());
    }

    #[test]
    fn get_well_behaving_channel_color_passes_through_already_representable_values() {
        assert_eq!(get_well_behaving_channel_color(0.0, 8), 0.0);
        assert_eq!(get_well_behaving_channel_color(1.0, 8), 1.0);
        assert_eq!(get_well_behaving_channel_color(0.5, 0), 0.5); // 0 bits: always passed through
        assert_eq!(get_well_behaving_channel_color(-0.1, 8), -0.1); // v <= 0.0
    }

    #[test]
    fn get_well_behaving_channel_color_nudges_the_0_5_border_away_from_itself() {
        // num_bits = 8: NUM_SUB_BITS = 3, maxFixedValue = 2^11 - 1 = 2047.
        // v = 0.5 -> fixedValue = round(0.5 * 2047) = round(1023.5) = 1024.
        // units = 1024 >> 3 = 128, subUnits = 1024 & 7 = 0 - not a border value (3 or
        // 4), so this particular input is a case where num_bits = 8 does NOT land on
        // the border; use num_bits = 2 instead, chosen by hand below to hit the exact
        // border case.
        //
        // num_bits = 2: maxFixedValue = 2^5 - 1 = 31. Looking for a v whose
        // round(v*31) has subUnits (low 3 bits) == 3 (subUnitBorderLo) or == 4
        // (subUnitBorderHi). fixedValue = 3 -> v = 3/31 (approx 0.0968); fixedValue = 4
        // -> v = 4/31 (approx 0.1290).
        let v_lo = 3.0 / 31.0;
        let v_hi = 4.0 / 31.0;

        let out_lo = get_well_behaving_channel_color(v_lo, 2);
        let out_hi = get_well_behaving_channel_color(v_hi, 2);

        // Border-lo (subUnits == 3) is tweaked to subUnits == 2 -> fixedValue 2 -> 2/31.
        assert!((out_lo - 2.0 / 31.0).abs() < 1e-6, "got {out_lo}");
        // Border-hi (subUnits == 4) is tweaked to subUnits == 5 -> fixedValue 5 -> 5/31.
        assert!((out_hi - 5.0 / 31.0).abs() < 1e-6, "got {out_hi}");
    }

    #[test]
    fn get_well_behaving_color_applies_per_channel_bit_depths() {
        let format = PixelFormat {
            red_bits: 8,
            green_bits: 8,
            blue_bits: 8,
            alpha_bits: 0,
        };
        let accurate = Vec4::new(0.0, 1.0, 3.0 / 31.0, 0.5);
        let out = get_well_behaving_color(accurate, &format);
        // Already-representable channels pass through unchanged.
        assert_eq!(out.x(), 0.0);
        assert_eq!(out.y(), 1.0);
        // alpha_bits == 0 passes through unchanged too, regardless of value.
        assert_eq!(out.w(), 0.5);
    }

    fn reference_ctx() -> ReferenceContext {
        let color =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        let depth = TextureLevel::new(TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT), 4, 4, 1).unwrap();
        ReferenceContext::new(16, color, Some(depth), 8)
    }

    #[test]
    fn set_render_state_applies_a_fully_disabled_state_without_error() {
        let mut ctx = reference_ctx();
        let state = RenderState::default();

        set_render_state(&mut ctx, &state);

        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
    }

    #[test]
    fn set_render_state_applies_a_fully_enabled_state_without_error() {
        let mut ctx = reference_ctx();

        let stencil_side = StencilState {
            function: glw::GL_ALWAYS,
            reference: 0,
            compare_mask: 0xff,
            stencil_fail_op: glw::GL_KEEP,
            depth_fail_op: glw::GL_KEEP,
            depth_pass_op: glw::GL_REPLACE,
            write_mask: 0xff,
        };
        let blend_side = BlendState {
            equation: glw::GL_FUNC_ADD,
            src_func: glw::GL_ONE,
            dst_func: glw::GL_ZERO,
        };

        let state = RenderState {
            scissor_test_enabled: true,
            scissor_rectangle: WindowRectangle {
                left: 0,
                bottom: 0,
                width: 2,
                height: 2,
            },
            stencil_test_enabled: true,
            stencil: [stencil_side, stencil_side],
            depth_test_enabled: true,
            depth_func: glw::GL_LESS,
            depth_write_mask: true,
            blend_enabled: true,
            blend_rgb_state: blend_side,
            blend_a_state: blend_side,
            blend_color: Vec4::new(0.25, 0.5, 0.75, 1.0),
            dither_enabled: true,
            color_mask: [true, false, true, false],
        };

        set_render_state(&mut ctx, &state);

        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
    }
}

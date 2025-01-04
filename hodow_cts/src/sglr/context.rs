// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/sglrContext.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `sglr::Context` is a ~90-method pure-virtual "abstract GL" interface -
// every entry point either `sglr::ReferenceContext` or `sglr::GLContext` (a thin
// real-driver forwarder, not yet ported - see below) implements, so a test case can be
// written once (`void render(sglr::Context &ctx)`) and run against both an actual
// driver and a software reference, as `es2fDepthTests.cpp`'s `DepthCase::iterate` does.
//
// **This `Context` trait is narrowed to the exact method surface grep-confirmed
// in-scope callers actually use** - not upstream's whole interface. Confirmed by
// grepping the real `.cpp` directly rather than guessing from the header (per this
// project's own established method, see `tmp/DO_UNTIL_CTS_FOUNDATIONS_GLES23.md`):
//  - every `context.`/`ctx.` call in `es2fDepthTests.cpp` and `es2fStencilTests.cpp`
//    (the pair that motivated this), plus every `ctx.` call `sglrContextUtil.cpp`'s
//    `drawQuadWithVaoBuffers` makes (the draw-call helper both of those go through):
//    everything through `draw_elements` below.
//  - every `m_context.`/`context.` call `es2fFboRenderTest.cpp` makes (`fbo.render`,
//    the other grep-confirmed caller, added in the same pass that widened this trait
//    to cover it): everything from `viewport` through `check_framebuffer_status`
//    below. Every one of those already existed as an inherent `ReferenceContext`
//    method before this trait did (see `reference_context.rs`'s own top doc comment)
//    - widening the trait was pure forwarding, no new logic.
//
// `getString` (`GL_EXTENSIONS` only) is ported too - see `reference_context.rs`'s own
// `extensions` field and `get_string` doc comments for the exact extension list and the
// one narrowing (no ES-3.1-gated `GL_EXT_texture_cube_map_array`, since this port's
// `ReferenceContext::new` takes no context-version parameter to gate it on).
//
// **Re-grepped against `es3fFboRenderTest.cpp` too** (the ES3 sibling of the ES2 file
// above, same `fbo.render` group) - every `context.`/`m_context.` call there is either
// already covered by the bullets above (`getString` was the one gap, now closed) or is
// not a `sglr::Context` call at all: `context.draw(TexturedQuadOp(...))`/
// `BlendTextureOp` are a local `draw`/`Op` pair this one test file defines for itself
// (grepped - no `sglr::` framework file defines them), i.e. test-case code this project
// deliberately does not port ahead of the case itself; `m_context.getRenderContext()`
// is the *test's* own `glu::RenderContext` member (from the CTS test-context
// framework), unrelated to the `sglr::Context` trait entirely. **Both the ES2 and ES3
// `fbo.render` groups are therefore fully covered by this trait as of this grep pass** -
// nothing left to widen here for either.
//
//  - every `ctx.`/`m_context->`/`context.` call `glsVertexArrayTests.cpp` makes
//    (`vertex_arrays.*`'s own shared backing file, confirmed via grep - it already
//    includes `sglrContext.hpp`/`sglrReferenceContext.hpp`/`sglrGLContext.hpp`
//    directly): `draw_arrays`, `buffer_sub_data` and `vertex_attrib_i_pointer` are the
//    only three methods it needs beyond what the `fbo.render`/`fragment_ops.{depth,
//    stencil}` passes above already cover - every one of those three already existed
//    as a `ReferenceContext` inherent method (see `reference_context.rs`'s own
//    `buffer_sub_data`/`vertex_attrib_i_pointer`/`draw_arrays`), so widening the trait
//    here is pure forwarding too. `getType` (upstream's own VAO-vs-client-pointer
//    dispatch helper) is still not declared - see `context_util.rs`'s own doc comment
//    for why `draw_quad` never needs it, which applies here identically.
//
// Widen this trait (and the matching impls below) the same way for a new caller -
// grep the real `.cpp` directly, don't guess ahead of an actual need - the lesson
// `glu::texture_test_util`/`gls::texture_test_util` already drew this same session
// for the same reason.
//
// `sglr::GLContext` (the real-driver-backed implementor, upstream `sglrGLContext.hpp`/
// `.cpp`, 925 lines) is now ported too - see `gl_context.rs`'s own module doc comment
// for exactly what it forwards and what's narrowed relative to upstream (no
// `tcu::TestLog`, a hardcoded `buffer_data` usage hint, the default-framebuffer-is-0
// assumption). It is still not wired into an actual registered test case (out of scope
// per this file's own task) - its own `#[test]`s exercise it directly against a real
// headless EGL context instead, the same live-driver-`#[test]` precedent
// `glu::texture`/`gls::texture_test_util` already set.
//
// `pixel_storei`/`tex_parameteri` are ported too, narrowed to `GL_TEXTURE_2D` and the
// `GL_UNPACK_*`/pack-alignment pnames `fbo.render`'s own grep-confirmed caller and
// upstream's own `texParameteri` actually use - see `reference_context.rs`'s own
// `pixel_storei`/`tex_parameteri` doc comments for the exact narrowing.
//
// `uniform1i` closes the last `fbo.render` gap the bullet above named: a sampler
// uniform's value is the texture unit it names (matching upstream's "texture unit is
// stored to value" comment exactly), resolved against whichever `GL_TEXTURE_2D` object
// is bound there only at draw time - see `reference_context.rs`'s own `uniform1i`/
// `resolve_sampler_uniforms`/`ShaderProgram::bind_samplers` doc comments for the full
// design (deliberately not a raw pointer into live texture storage, unlike upstream's
// own `UniformSlot::sampler` union - see `bind_samplers`'s own doc comment for why a
// clone was chosen instead).
//
// **Re-grepped against `glsVertexArrayTests.cpp`'s neighbours** (`clipping.*`'s own
// shared backing file, `glsVertexArrayTests.hpp`/`.cpp` having already been covered
// above) - confirmed via `tmp/DO_UNTIL_CTS_FOUNDATIONS_GLES23.md`'s own standing advice
// to re-grep rather than trust a prior "(a), infrastructure-complete" label on faith:
// `glsClippingTests.cpp` (the real backing file for both `es2fClippingTests.cpp` and
// `es3fClippingTests.cpp`, both thin wrappers) calls `blendFunc`, `lineWidth` and
// `finish` on `sglr::Context`, none of which this trait declared yet - every one of
// them already existed as a `ReferenceContext` inherent method
// (`reference_context.rs`'s own `blend_func`/`line_width`/`finish`) and as a generated
// `glw::Functions` wrapper (`blend_func`/`line_width`/`finish` in
// `generated/glw.rs`), so widening both impls below is pure forwarding, the same shape
// every prior widening in this file has been. Every other `ctx.`/`context.` call in
// `glsClippingTests.cpp` was already covered by an earlier pass.
//
// **Re-grepped `glsDrawTest.cpp` too** (`draw.*`'s own shared backing file, 4400
// lines, confirmed via `es3fDrawTests.cpp`'s own `#include`) - its `AttributeArray`/
// `AttributePack` classes drive `m_ctx.` through a materially wider surface than any
// pass above, but every name beyond what the bullets above already cover turned out to
// already be a `ReferenceContext` inherent method with no trait exposure yet, the same
// shape `blend_func`/`line_width`/`finish` were: `draw_arrays_instanced`,
// `draw_elements_instanced`/`draw_elements_instanced_base_vertex`, `draw_range_
// elements`/`draw_range_elements_base_vertex`, `vertex_attrib_divisor`. The two
// remaining methods this file calls (`drawArraysIndirect`/`drawElementsIndirect`) are
// a genuinely new shape rather than a forwarding gap (an indirect draw reads its own
// parameters out of a bound `GL_DRAW_INDIRECT_BUFFER` rather than taking them as
// arguments) and are ported too, as new `ReferenceContext` inherent methods - see
// `reference_context.rs`'s own `draw_arrays_indirect`/`draw_elements_indirect` doc
// comments. Porting `glsDrawTest.cpp`'s own test logic (the `AttributeArray`/
// `AttributePack`/`DrawTestShaderProgram` classes themselves) is out of scope for this
// whole effort regardless, per this file's own task.
//
// **`clear_buffer_fv`/`clear_buffer_iv`/`clear_buffer_uiv` widen the trait again**,
// found by grepping one level deeper than usual: `es3fFboRenderTest.cpp` itself (an
// already-covered caller, see the `fbo.render` bullet above) never calls
// `clearBuffer*` directly, but its own `#include "es3fFboTestUtil.hpp"` utility,
// `FboTestUtil::clearColorBuffer(sglr::Context&, format, value)`, does - dispatching
// to `clearBufferfv`/`uiv`/`iv` by the colour format's own channel class (float/
// normalized-fixed vs unsigned-integer vs signed-integer), and `es3fFboRenderTest.cpp`
// calls that helper three times. The original pass that produced this bullet list
// grepped each covered test file directly and missed this because the call is one
// `#include` away, the same depth `sglrContextUtil.cpp`'s `drawQuadWithVaoBuffers`
// already established matters - a re-grep of every already-covered file's own
// included utility headers, not just the test file itself, is worth doing again if a
// future widening pass turns up nothing where upstream's own test clearly needs
// something. `clearBufferfi` is not declared - grepped the same way and nothing in
// scope calls it; it exists as a `ReferenceContext` inherent method only (see
// `reference_context.rs`'s own `clear_buffer_fi` doc comment).
//
// **Widened again for `glsFragOpInteractionCase.cpp`'s own `setRenderState`** (not yet a
// registered case - see `gls::frag_op_interaction_case`'s own top doc comment for
// exactly what is and is not ported there, and why) - `depth_mask`,
// `stencil_func_separate`, `stencil_op_separate`, `stencil_mask_separate`,
// `stencil_mask`, `blend_equation_separate` and `blend_color` close every gap that one
// function's real body has, the same "already an inherent `ReferenceContext` method,
// already a generated `glw::Functions` wrapper, pure forwarding" shape every prior
// widening in this file was.
//
// **Widened again for the same file's own `setUniformValue`** - `uniform1fv`/`2fv`/
// `3fv` (`uniform4fv` already existed) and `uniform1iv`/`2iv`/`3iv`/`4iv` (`uniform1i`,
// the non-`v` scalar form, already existed and stays - see `reference_context.rs`'s own
// `uniform1iv` doc comment for exactly how the two differ and why both are kept). Every
// GL entry point needed already exists in the generated `glw` wrapper
// (`uniform_1fv`/`2fv`/`3fv`/`1iv`/`2iv`/`3iv`/`4iv`, grepped present), so `GLContext`'s
// side is pure forwarding; `ReferenceContext`'s side needed `sglr::UniformValue` widened
// with `F32Vec2`/`F32Vec3`/`I32Vec2`/`I32Vec3` variants first (confirmed non-breaking
// before adding them: the only two places that pattern-match `UniformValue` by variant,
// `shader_program.rs`'s own `as_i32`/`as_f32_vec4`, both already end in a catch-all `_`
// arm, so neither needed touching).

use super::shader_program::ShaderProgram;
use crate::glw::GLenum;
use crate::tcu::surface::Surface;

/// `sglr::Context`, narrowed - see this module's top doc comment. `getType` is not
/// declared here: it exists upstream only to let `sglr::drawQuad` pick between its two
/// draw paths, and this port's `draw_quad` always uses the VAO/buffer-object one (see
/// `context_util.rs`'s own doc comment for why) - nothing grep-confirmed in scope ever
/// calls `getType` directly.
pub trait Context {
    fn get_width(&self) -> i32;
    fn get_height(&self) -> i32;

    fn clear_color(&mut self, red: f32, green: f32, blue: f32, alpha: f32);
    fn clear_depthf(&mut self, depth: f32);
    fn clear_stencil(&mut self, stencil: i32);
    fn clear(&mut self, buffers: GLenum);
    /// `glClearBufferfv`. `clearBufferfi` is not declared here - grepped (see below)
    /// and nothing in scope calls it.
    fn clear_buffer_fv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[f32]);
    fn clear_buffer_iv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[i32]);
    fn clear_buffer_uiv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[u32]);
    /// `Context::clearBufferfi` - `es3fFboDepthbufferTests.cpp`/`es3fFboStencilbufferTests.cpp`.
    fn clear_buffer_fi(&mut self, buffer: GLenum, drawbuffer: i32, depth: f32, stencil: i32);
    /// `Context::invalidateFramebuffer` - `es3fFboInvalidateTests.cpp`.
    fn invalidate_framebuffer(&mut self, target: GLenum, attachments: &[GLenum]);
    /// `Context::invalidateSubFramebuffer`
    fn invalidate_sub_framebuffer(
        &mut self,
        target: GLenum,
        attachments: &[GLenum],
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    );
    /// `Context::blitFramebuffer` - `es3fFramebufferBlitTests.cpp`.
    #[allow(clippy::too_many_arguments)]
    fn blit_framebuffer(
        &mut self,
        src_x0: i32,
        src_y0: i32,
        src_x1: i32,
        src_y1: i32,
        dst_x0: i32,
        dst_y0: i32,
        dst_x1: i32,
        dst_y1: i32,
        mask: GLenum,
        filter: GLenum,
    );
    fn scissor(&mut self, x: i32, y: i32, width: i32, height: i32);

    fn enable(&mut self, cap: GLenum);
    fn disable(&mut self, cap: GLenum);

    fn depth_func(&mut self, func: GLenum);
    /// `Context::depthMask` - needed by `glsFragOpInteractionCase.cpp`'s own
    /// `setRenderState` (not yet wired up as a registered case - see
    /// `gls::frag_op_interaction_case`'s own top doc comment - but its
    /// execution-independent helpers are ported there and need this).
    fn depth_mask(&mut self, flag: bool);
    fn stencil_func(&mut self, func: GLenum, ref_: i32, mask: u32);
    /// `Context::stencilFuncSeparate` - same grep-confirmed need as `depth_mask` above:
    /// `setRenderState` sets front/back stencil function independently
    /// (`RenderState::stencil[FaceType::Front]`/`[Back]`).
    fn stencil_func_separate(&mut self, face: GLenum, func: GLenum, ref_: i32, mask: u32);
    fn stencil_op(&mut self, sfail: GLenum, dpfail: GLenum, dppass: GLenum);
    /// `Context::stencilOpSeparate` - see `stencil_func_separate`'s own doc comment.
    fn stencil_op_separate(&mut self, face: GLenum, sfail: GLenum, dpfail: GLenum, dppass: GLenum);
    /// `Context::stencilMaskSeparate` - see `stencil_func_separate`'s own doc comment.
    fn stencil_mask_separate(&mut self, face: GLenum, mask: u32);
    /// `Context::stencilMask` - the non-separate form, kept as its own trait method for
    /// the same reason `blend_func` stays separate from `blend_func_separate` below.
    fn stencil_mask(&mut self, mask: u32);

    fn gen_vertex_arrays(&mut self, out: &mut [u32]);
    fn bind_vertex_array(&mut self, array: u32);
    fn delete_vertex_arrays(&mut self, names: &[u32]);

    fn gen_buffers(&mut self, out: &mut [u32]);
    fn delete_buffers(&mut self, names: &[u32]);
    fn bind_buffer(&mut self, target: GLenum, buffer: u32);
    fn buffer_data(&mut self, target: GLenum, size: isize, data: Option<&[u8]>);
    fn buffer_sub_data(&mut self, target: GLenum, offset: isize, data: &[u8]);

    fn enable_vertex_attrib_array(&mut self, index: u32);
    fn disable_vertex_attrib_array(&mut self, index: u32);
    #[allow(clippy::too_many_arguments)]
    fn vertex_attrib_pointer(
        &mut self,
        index: u32,
        size: i32,
        type_: GLenum,
        normalized: bool,
        stride: i32,
        pointer: usize,
        has_pointer: bool,
    );
    fn vertex_attrib_i_pointer(
        &mut self,
        index: u32,
        size: i32,
        type_: GLenum,
        stride: i32,
        pointer: usize,
        has_pointer: bool,
    );
    /// `Context::vertexAttribDivisor` - `draw.*`'s own grep-confirmed need
    /// (`glsDrawTest.cpp`'s `AttributeArray`, instanced-draw attribute setup).
    fn vertex_attrib_divisor(&mut self, index: u32, divisor: u32);
    /// `Context::vertexAttrib1f`/`2f`/`3f`/`4f`/`I4i`/`I4ui` - the "current" generic
    /// per-attribute value a *disabled* vertex attribute array reads during a draw.
    /// `draw.*`'s own grep-confirmed need (`glsDrawTest.cpp`'s `AttributeArray::setup`,
    /// which picks one of these six off the attribute's input type) and
    /// `clipping.*`'s (`glsClippingTests.cpp`'s `vertexAttrib1f`/`vertexAttrib4f` calls
    /// for a constant point size / line-or-poly colour).
    fn vertex_attrib1f(&mut self, index: u32, x: f32);
    fn vertex_attrib2f(&mut self, index: u32, x: f32, y: f32);
    fn vertex_attrib3f(&mut self, index: u32, x: f32, y: f32, z: f32);
    fn vertex_attrib4f(&mut self, index: u32, x: f32, y: f32, z: f32, w: f32);
    fn vertex_attrib_i4i(&mut self, index: u32, x: i32, y: i32, z: i32, w: i32);
    fn vertex_attrib_i4ui(&mut self, index: u32, x: u32, y: u32, z: u32, w: u32);

    fn get_attrib_location(&mut self, program: u32, name: &str) -> i32;

    fn uniform4fv(&mut self, location: i32, count: i32, v: &[f32]);
    fn uniform1i(&mut self, location: i32, value: i32);
    /// `Context::uniform1f` - `draw.*`'s own grep-confirmed need
    /// (`glsDrawTest.cpp`'s `DrawTestShaderProgram`, which sets `u_coordScale`/
    /// `u_colorScale`, both plain `glu::TYPE_FLOAT` scalars, via `m_ctx.uniform1f`
    /// right before every draw). Narrowed to `DataType::Float` only, same as
    /// `uniform4fv`'s own `FloatVec4`-only narrowing above - no in-scope caller
    /// declares any other scalar-float-adjacent uniform type.
    fn uniform1f(&mut self, location: i32, value: f32);
    /// `Context::uniformMatrix3fv` (`count` 1 only on the reference side, as upstream).
    fn uniform_matrix3fv(&mut self, location: i32, count: i32, transpose: bool, v: &[f32]);
    /// `Context::uniform1fv`/`2fv`/`3fv` and `uniform1iv`/`2iv`/`3iv`/`4iv` - see this
    /// module's own top doc comment for why these joined `uniform4fv`/`uniform1i`
    /// (`glsFragOpInteractionCase.cpp`'s own `setUniformValue`, not yet a registered
    /// case).
    fn uniform1fv(&mut self, location: i32, count: i32, v: &[f32]);
    fn uniform2fv(&mut self, location: i32, count: i32, v: &[f32]);
    fn uniform3fv(&mut self, location: i32, count: i32, v: &[f32]);
    fn uniform1iv(&mut self, location: i32, count: i32, v: &[i32]);
    fn uniform2iv(&mut self, location: i32, count: i32, v: &[i32]);
    fn uniform3iv(&mut self, location: i32, count: i32, v: &[i32]);
    fn uniform4iv(&mut self, location: i32, count: i32, v: &[i32]);
    fn get_uniform_location(&mut self, program: u32, name: &str) -> i32;

    fn draw_arrays(&mut self, mode: GLenum, first: i32, count: i32);
    /// `Context::drawArraysInstanced` - `draw.*`'s own grep-confirmed need.
    fn draw_arrays_instanced(&mut self, mode: GLenum, first: i32, count: i32, instance_count: i32);
    fn draw_elements(&mut self, mode: GLenum, count: i32, type_: GLenum, indices_offset: usize);
    /// `Context::drawElementsBaseVertex` - the non-instanced sibling of
    /// `draw_elements_instanced_base_vertex` below, `glsDrawTest.cpp`'s own
    /// grep-confirmed need (`AttributePack::render`'s `DRAWMETHOD_DRAWELEMENTS_
    /// BASEVERTEX` branch). Already existed as a `ReferenceContext` inherent method
    /// with no trait exposure (`draw_elements_instanced`'s own forwarding-gap shape),
    /// so widening both impls below is pure forwarding.
    fn draw_elements_base_vertex(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        base_vertex: i32,
    );
    /// `Context::drawElementsInstanced` - the no-base-vertex sibling of
    /// `draw_elements_instanced_base_vertex` below, both grep-confirmed needed by
    /// `glsDrawTest.cpp` as two distinct calls, matching how `draw_elements`/
    /// `draw_elements_base_vertex` are already two distinct trait methods rather than
    /// one with a defaulted argument.
    fn draw_elements_instanced(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        instance_count: i32,
    );
    #[allow(clippy::too_many_arguments)]
    fn draw_elements_instanced_base_vertex(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        instance_count: i32,
        base_vertex: i32,
    );
    fn draw_range_elements(
        &mut self,
        mode: GLenum,
        start: u32,
        end: u32,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
    );
    #[allow(clippy::too_many_arguments)]
    fn draw_range_elements_base_vertex(
        &mut self,
        mode: GLenum,
        start: u32,
        end: u32,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        base_vertex: i32,
    );
    /// `Context::drawArraysIndirect`/`Context::drawElementsIndirect` - `glsDrawTest.cpp`'s
    /// own grep-confirmed need (see this module's own doc comment on the `draw.*` pass
    /// above), closing the one follow-up that pass left: both read their draw
    /// parameters out of the bound `GL_DRAW_INDIRECT_BUFFER` rather than taking them as
    /// arguments, a genuinely new code shape (not a forwarding gap like everything
    /// else in this trait) - `indirect_offset` is a byte offset into that buffer,
    /// matching every other draw-call entry point's own `indices_offset` convention.
    fn draw_arrays_indirect(&mut self, mode: GLenum, indirect_offset: usize);
    fn draw_elements_indirect(&mut self, mode: GLenum, type_: GLenum, indirect_offset: usize);
    /// `Context::finish` - `clipping.*`'s own grep-confirmed need
    /// (`glsClippingTests.cpp`'s `ctx.finish()`, called right after a draw before
    /// reading the result back). `ReferenceContext::finish` is a no-op (every draw call
    /// there already runs to completion synchronously); `GLContext::finish` forwards to
    /// the real `glFinish`.
    fn finish(&mut self);

    /// `Context::createProgram` - upstream stores a raw `ShaderProgram*` the caller
    /// keeps alive; here ownership transfers into the context (the only way a
    /// `DepthShader::setColor`-style helper's later `uniform4fv` call can reach the
    /// same slot `shadeFragments` later reads - see `sglr::shader_program`'s own
    /// module doc comment for the full "why" of this shape).
    fn create_program(&mut self, program: Box<dyn ShaderProgram>) -> u32;
    fn use_program(&mut self, program: u32);
    fn delete_program(&mut self, program: u32);

    fn read_pixels(&mut self, dst: &mut Surface, x: i32, y: i32, width: i32, height: i32);
    /// `Context::readPixels(x, y, width, height, GL_RGBA, type_, ptr)` for `GL_FLOAT`, `GL_INT` and
    /// `GL_UNSIGNED_INT`, narrowed to hand each pixel back as RGBA floats (row-major, bottom row first) instead of
    /// raw bytes - `FboTestUtil::readPixels` converts every pixel to float right away anyway. Empty on a GL error.
    fn read_pixels_rgba_f32(&mut self, x: i32, y: i32, width: i32, height: i32, type_: GLenum) -> Vec<[f32; 4]>;
    fn get_error(&mut self) -> GLenum;
    /// `Context::getString` - `None` for a `pname` the implementor doesn't answer
    /// (upstream returns `nullptr` and sets `GL_INVALID_ENUM`), `Some` otherwise.
    fn get_string(&mut self, pname: GLenum) -> Option<String>;

    // --- `fbo.render`'s own surface (`es2fFboRenderTest.cpp`) - see this module's
    // top doc comment for exactly which methods below are new because of it. ---

    fn viewport(&mut self, x: i32, y: i32, width: i32, height: i32);
    fn blend_equation(&mut self, mode: GLenum);
    /// `Context::blendEquationSeparate` - same grep-confirmed need as
    /// `stencil_func_separate` above (`setRenderState`'s own `RenderState::blend_rgb_state`/
    /// `blend_a_state` split).
    fn blend_equation_separate(&mut self, mode_rgb: GLenum, mode_alpha: GLenum);
    fn blend_func_separate(&mut self, src_rgb: GLenum, dst_rgb: GLenum, src_alpha: GLenum, dst_alpha: GLenum);
    /// `Context::blendColor` - same grep-confirmed need as `blend_equation_separate`
    /// above (`setRenderState`'s own `RenderState::blend_color`).
    fn blend_color(&mut self, red: f32, green: f32, blue: f32, alpha: f32);
    /// `Context::blendFunc` - the non-separate form (`glsClippingTests.cpp`'s own
    /// `ctx.blendFunc(GL_ONE, GL_ONE)`), distinct from `blend_func_separate` above:
    /// upstream implements it as `blendFuncSeparate(src, dst, src, dst)`, kept as its
    /// own trait method (not collapsed into a caller-side `blend_func_separate(s, d, s,
    /// d)`) so a grep for `blendFunc` in a ported case maps onto one trait method here
    /// exactly the way it does in the C++.
    fn blend_func(&mut self, src: GLenum, dst: GLenum);
    fn color_mask(&mut self, r: bool, g: bool, b: bool, a: bool);
    /// `Context::lineWidth` - `clipping.*`'s own grep-confirmed need
    /// (`glsClippingTests.cpp`'s `ctx.lineWidth(m_lineWidth)`), clamped by neither this
    /// trait nor `ReferenceContext` (GLES leaves an out-of-range width
    /// implementation-defined, and the port has no aliased-line-width-range query to
    /// clamp against - matching `reference_context.rs`'s own `line_width` field, a
    /// plain unclamped `f32`).
    fn line_width(&mut self, width: f32);

    fn active_texture(&mut self, texture: GLenum);
    fn gen_textures(&mut self, out: &mut [u32]);
    fn delete_textures(&mut self, names: &[u32]);
    fn bind_texture(&mut self, target: GLenum, texture: u32);
    fn pixel_storei(&mut self, pname: GLenum, param: i32);
    fn tex_parameteri(&mut self, target: GLenum, pname: GLenum, value: i32);
    #[allow(clippy::too_many_arguments)]
    fn tex_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        data: Option<&[u8]>,
    );
    #[allow(clippy::too_many_arguments)]
    fn tex_sub_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        width: i32,
        height: i32,
        format: GLenum,
        type_: GLenum,
        data: &[u8],
    );

    #[allow(clippy::too_many_arguments)]
    fn tex_image_3d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        data: Option<&[u8]>,
    );
    #[allow(clippy::too_many_arguments)]
    fn tex_sub_image_3d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        zoffset: i32,
        width: i32,
        height: i32,
        depth: i32,
        format: GLenum,
        type_: GLenum,
        data: &[u8],
    );
    #[allow(clippy::too_many_arguments)]
    fn copy_tex_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
        border: i32,
    );
    #[allow(clippy::too_many_arguments)]
    fn copy_tex_sub_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    );
    // The `*_pbo` forms upload from the buffer bound to GL_PIXEL_UNPACK_BUFFER at a byte offset (upstream's `(const void *)offset`).
    #[allow(clippy::too_many_arguments)]
    fn tex_image_2d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    );
    #[allow(clippy::too_many_arguments)]
    fn tex_sub_image_2d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        width: i32,
        height: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    );
    #[allow(clippy::too_many_arguments)]
    fn tex_image_3d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    );
    #[allow(clippy::too_many_arguments)]
    fn tex_sub_image_3d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        zoffset: i32,
        width: i32,
        height: i32,
        depth: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    );
    fn tex_storage_2d(&mut self, target: GLenum, levels: i32, internal_format: GLenum, width: i32, height: i32);
    fn tex_storage_3d(
        &mut self,
        target: GLenum,
        levels: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
    );
    fn framebuffer_texture_layer(&mut self, target: GLenum, attachment: GLenum, texture: u32, level: i32, layer: i32);
    fn gen_renderbuffers(&mut self, out: &mut [u32]);
    fn delete_renderbuffers(&mut self, names: &[u32]);
    fn bind_renderbuffer(&mut self, target: GLenum, renderbuffer: u32);
    fn renderbuffer_storage(&mut self, target: GLenum, internal_format: GLenum, width: i32, height: i32);
    /// The reference context stores the renderbuffer single sample whatever `samples` says (see `fbo::multisample_tests`).
    fn renderbuffer_storage_multisample(
        &mut self,
        target: GLenum,
        samples: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
    );

    fn gen_framebuffers(&mut self, out: &mut [u32]);
    fn delete_framebuffers(&mut self, names: &[u32]);
    fn bind_framebuffer(&mut self, target: GLenum, framebuffer: u32);
    fn framebuffer_renderbuffer(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        renderbuffertarget: GLenum,
        renderbuffer: u32,
    );
    #[allow(clippy::too_many_arguments)]
    fn framebuffer_texture2d(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        textarget: GLenum,
        texture: u32,
        level: i32,
    );
    fn check_framebuffer_status(&mut self, target: GLenum) -> GLenum;
}

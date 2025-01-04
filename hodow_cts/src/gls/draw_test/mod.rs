// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.hpp / .cpp  (deqp::gls::DrawTestSpec, deqp::gls::DrawTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `glsDrawTest.{hpp,cpp}` (4695 lines combined) is the shared framework
// `dEQP-GLES2/3.functional.draw.*`, `dEQP-GLES31.functional.draw_indirect.*`/
// `draw_base_vertex.*` and `vertex_arrays.*` all need: build a real `sglr::GLContext`
// and a real `sglr::ReferenceContext` side by side, issue the *same* draw command
// through both (same vertex data, same attribute bindings, same primitive type, same
// indices if any) and compare the two rendered images. Both halves it drives already
// exist in this port (`sglr::Context` - widened for exactly this file, see its own top
// doc comment's "glsDrawTest.cpp too" bullet - and `rr::Renderer`); this module is the
// piece that wires them together generically, ported incrementally, file by file as
// upstream's own anonymous-namespace sections split it.
//
// Ported so far:
// - `spec` - `DrawTestSpec` itself: every enum, `AttributeSpec`, `MethodInfo`, the
//   enum<->GLenum/string/size tables, `valid()`/`hash()`/`isCompatibilityTest()`/
//   `getName()`, and `checkSpecsShaderCompatible`. Pure data and pure functions of it -
//   no `sglr`/`rr` dependency at all.
// - `gl_value` - `GLValue` and its ten `WrappedType<T>` specialisations (`Float`,
//   `Double`, `Byte`, `Ubyte`, `Short`, `Ushort`, `Int`, `Uint`, `Fixed`, `Half`):
//   construction, arithmetic, `getRandom<T>`, `minValue<T>`, `abs<T>`,
//   `GLValue::toFloat`/`getMaxValue`/`getMinValue`. See that module's own doc comment
//   for why this is a Rust enum rather than upstream's tagged union, and why
//   `GLValueTypeTraits`/`extractGLValue` have no counterpart here.
// - `attribute_array` - `AttributeArray`: owns one GL buffer (or a plain `Vec<u8>` for
//   `Storage::User`) and knows how to upload into it and bind it to a vertex attribute
//   or index target, through a `&mut dyn sglr::Context` passed to each method rather
//   than stored as a member - see that module's own doc comment for why. Its own
//   `#[test]`s build a real `sglr::ReferenceContext` (`reference_context.rs`'s own
//   `ctx()` test helper, duplicated here rather than exported, since it is three lines)
//   and check `get_error()` after each call, the same shape that file's own tests use.
// - `random_array_generator` - fills the `Vec<u8>` `AttributeArray`/an index array
//   wants with deterministic pseudo-random vertex data, per `InputType`/`IndexType`.
//   Needs only `gl_value` (for the per-type range/arithmetic tables, exposed as traits
//   so this module can stay generic over "whichever wrapped type an `InputType` maps
//   to") - no `sglr::Context` dependency at all, unlike `attribute_array`.
// - `shader_program` - `DrawTestShaderProgram`: the one GLSL program every `DrawTest`
//   iteration compiles, built from the attribute list. Needed `sglr::Context` widened
//   by one method (`uniform1f`, `u_coordScale`/`u_colorScale` are plain scalar-float
//   uniforms upstream sets via `glUniform1f` - the trait only had `uniform4fv`/
//   `uniform1i` before this file, both narrowed to their own single upstream-declared
//   type exactly like `uniform1f` now is too) - added to `sglr::context::Context`,
//   `sglr::gl_context::GLContext` and `sglr::reference_context::ReferenceContext`
//   (inherent method + trait forward + a `DataType::Float`-only `UniformValue::F32`
//   case, same narrowing shape `uniform4fv`'s own doc comment already established for
//   the `FloatVec4`-only case). `ContextType::glsl_version()` (already ported) turned
//   out to already be upstream's whole `isGLSLVersionSupported` chain collapsed to one
//   match, since this port's `GlslVersion` is ES-only - see that module's own top doc
//   comment for why the desktop-GL branches have no counterpart here.
// - `attribute_pack` - `AttributePack`: owns the whole set of `AttributeArray`s plus
//   the compiled `DrawTestShaderProgram` for one `DrawTestSpec`, against one
//   `sglr::Context`. Needed one more `sglr::Context` widening beyond `uniform1f`:
//   `draw_elements_base_vertex` (the non-instanced sibling of
//   `draw_elements_instanced_base_vertex`) already existed as a `ReferenceContext`
//   inherent method but had no trait exposure - a forwarding gap, same shape several
//   other methods in that trait already needed closing. See that module's own top doc
//   comment for the narrowings relative to upstream (no `tcu::TestContext`/`TestLog`,
//   no `tcu::UVec2`, no `glu::RenderContext` member, no raw `ShaderProgram*` - ownership
//   already transfers into the `Context` via `create_program`).
// - `compare` - the free comparison/threshold functions from right before the
//   `DrawTest` class itself: `edgeRelaxedImageCompare`/`intersectionRelaxedLineImageCompare`
//   (triangle/line primitive classes) and `intThresholdPositionDeviationErrorThresholdCompare`
//   (points), plus `getDrawPrimitiveClass`/`containsLineCases` and `DrawTest`'s own
//   `getCoordScale`/`getColorScale`. No `tcu::TestLog`/error-mask image anywhere - see
//   that module's own top doc comment for why dropping the logging-only visualisation
//   image changes no pass/fail verdict.
// - `draw_test` - `DrawTest` itself, now covering the whole of `DrawTest::iterate`'s two
//   branches: the struct/`new` (computing `max_diff_red/green/blue` and
//   `render_target_threshold` from a `PixelFormat`, once, rather than storing a
//   `glu::RenderContext`)/`add_iteration`/`should_update_program`, `plan_iteration`
//   (the pure per-iteration arithmetic - `primitiveElementCount`/`indexMin`/`indexMax`/
//   `elementCount`/`indexBase`/`coordScale`/`colorScale`), **`draw_iteration`** - the
//   data-generation-and-render loop, wiring `sglr::GLContext` and
//   `sglr::ReferenceContext` together side by side through two independently-owned
//   `AttributePack`s: builds each `AttributeSpec`'s backing data via
//   `RandomArrayGenerator` (shared between both packs, matching upstream), calls
//   `AttributePack::render` through both contexts with the identical arguments, and
//   reports whichever error state either context is left in afterward (`glu::Error`'s
//   catch collapsed into a `Result`, since this port's GL calls never unwind - see that
//   module's own top doc comment) - and **`compare_iteration`** - reads both packs'
//   `Surface`s back and runs them through whichever of `compare`'s three
//   primitive-class comparisons `get_draw_primitive_class` selects (or a fixed-0.3
//   `fuzzy_compare` for `num_samples > 1`, upstream's own hardcoded multisample
//   branch). Proven end-to-end by its own `#[test]` driving two independent
//   `ReferenceContext`s through the same spec, asserting their `Surface`s come out
//   pixel-identical, and asserting `compare_iteration` itself agrees - the strongest
//   check available without a real GL driver. See that module's own top doc comment
//   for the `tcu::TestCase`/`TestContext`/`TestLog` narrowings and the draw-step/
//   compare-step collapse.
//   `Storage::User` indexed draws are supported: the real driver side draws from client
//   memory, the `ReferenceContext` side keeps the same bytes in a buffer at the same
//   byte offset (see `draw_iteration`).
//
// Still to port / left to do: nothing known in this module.

pub mod attribute_array;
pub mod attribute_pack;
pub mod compare;
// `draw_test.rs` inside a `draw_test/` directory module mirrors `glsDrawTest.hpp`'s own
// `DrawTest`/`DrawTestSpec` living directly under `gls` - the file is named after what
// it ports, not after its parent directory.
#[allow(clippy::module_inception)]
pub mod draw_test;
pub mod gl_value;
pub mod random_array_generator;
pub mod shader_program;
pub mod spec;

pub use attribute_array::AttributeArray;
pub use attribute_pack::AttributePack;
pub use draw_test::{DrawTest, IterationPlan};
pub use gl_value::GLValue;
pub use shader_program::DrawTestShaderProgram;
pub use spec::DrawTestSpec;

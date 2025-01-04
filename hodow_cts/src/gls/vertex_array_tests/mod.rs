// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsVertexArrayTests.hpp / .cpp  (deqp::gls::Array,
//   deqp::gls::ContextArray, deqp::gls::ContextArrayPack, deqp::gls::GLValue,
//   deqp::gls::RandomArrayGenerator, deqp::gls::VertexArrayTest,
//   deqp::gls::MultiVertexArrayTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `glsVertexArrayTests.{hpp,cpp}` (849 + 2233 = 3082 lines combined) is the shared
// framework `dEQP-GLES2/3.functional.vertex_arrays.*` needs: a smaller, older sibling
// of `glsDrawTest.cpp` (see `super::draw_test`'s own module doc comment) that drives a
// GL context and a `sglr::Context` through the same vertex-array setup and draw call,
// then compares the two rendered images. Ported incrementally, piece by piece, same
// discipline as `draw_test`.
//
// **Upstream itself duplicates most of this file's `GLValue` class almost verbatim
// inside `glsDrawTest.hpp`** (same ten `WrappedType<T>` instantiations, same
// `getMaxValue`/`getMinValue` literal tables character-for-character, same
// `InputType` variant order) - confirmed by diffing the two headers directly. This
// port keeps that duplication rather than threading one shared `GLValue` through two
// unrelated modules: `Array::InputType` here and `DrawTestSpec::InputType` in
// `super::draw_test::spec` happen to agree today, but nothing says they must keep
// agreeing after a future upstream re-sync touches one file and not the other, and a
// shared type would make that an invisible, silently-wrong assumption instead of a
// compile error. "Keep upstream shape" (this crate's own standing rule) means keeping
// upstream's actual shape, duplication included.
//
// Ported so far:
// - `array` - the `Array` class's own static data: every enum (`Target`, `InputType`,
//   `OutputType`, `Usage`, `Storage`, `Primitive` - note `Primitive` here has only four
//   variants, not `DrawTestSpec::Primitive`'s eleven: no lines/adjacency primitives in
//   this older framework), the enum<->GLenum/string tables, `inputTypeSize`, and the
//   two free `inputTypeIsFloatType`/`outputTypeIsFloatType` predicates (as inherent
//   `is_float_type` methods, matching `draw_test::spec`'s own naming). **No `Array`
//   base trait** - see `context_array`'s own top doc comment: there is exactly one
//   real implementor (`ContextArray`), so (matching `draw_test::attribute_array`'s own
//   precedent) this ports as a concrete struct with no trait at all, not a deferred one.
// - `gl_value` - `GLValue`, ported the same way `draw_test::gl_value` was (an enum of
//   ten newtype wrappers, not a tagged union): construction, `toFloat`,
//   `getMaxValue`/`getMinValue`. Arithmetic/`getRandom<T>` are deferred to whichever
//   piece first needs them (`RandomArrayGenerator`, not yet ported) rather than copied
//   ahead of a caller, unlike `draw_test::gl_value` which needed them immediately for
//   its own first caller.
// - `context_array` - `ContextArray`: owns a GL buffer or user-memory array,
//   `data`/`subdata` to upload, `bind` (pure bookkeeping) + `glBind` (the real
//   `sglr::Context` call sequence, split the same way upstream splits them across two
//   methods) to attach it to a vertex attribute, `bindIndexArray`/`unBind` and the
//   getters. Same `ctx: &mut dyn Context` parameter shape
//   `draw_test::attribute_array::AttributeArray` already established, for the same
//   reason (see that file and this one's own top doc comment).
//
// **A real quirk found while reading `RandomArrayGenerator::setData`, not yet
// exercised by anything ported so far**: its `INPUTTYPE_DOUBLE` branch calls
// `getRandom<GLValue::Float>(rnd, min.fl, max.fl)` - reading the union's `fl` (float)
// member even though a `GLValue` carrying `type == INPUTTYPE_DOUBLE` was constructed
// through the `d` (double) member, never `fl`. In C++ this is a read of an
// inactive union member (common, if technically UB, divergent-struct-layout
// reinterpretation): the float bit pattern read back is whatever bytes the double
// write happened to leave in the first four, not a meaningful float value at all.
// Left for the piece that actually ports `RandomArrayGenerator` to decide how to
// handle (most likely: port literally, keep the bug, and record it in
// `hodow_cts/QUIRKS.md` once a concrete case is seen to exercise `INPUTTYPE_DOUBLE`
// through this path) - noted here so it is not rediscovered as a surprise later.
//
// Not yet ported (in upstream's own order):
// - `ContextShaderProgram` (~330 lines) - the one GLSL program this framework
//   compiles, built from the array list. Very close in shape to
//   `draw_test::shader_program::DrawTestShaderProgram` (same `calcShaderColorCoord`
//   pattern, same `${VTX_HDR}`-templated source) but keyed to `Array::OutputType`
//   rather than `DrawTestSpec::OutputType`.
// - `ContextArrayPack` (~70 lines) - owns the whole `Vec<ContextArray>` plus the
//   compiled program for one context, analogous to `draw_test::attribute_pack::AttributePack`.
// - `RandomArrayGenerator` (~330 lines) - builds vertex data for a quad grid
//   (`generateQuads`/`generatePerQuad`), not a plain per-lane random fill the way
//   `draw_test::random_array_generator` is - a genuinely different generator, despite
//   the similar name upstream gives both.
// - `VertexArrayTest`/`MultiVertexArrayTest` (~550 lines) - the `tcu::TestCase` driver
//   itself: builds a `ContextArrayPack` per context, issues the draw through both,
//   compares. The piece that actually wires `GLContext`/`ReferenceContext` together,
//   same role `draw_test::draw_test::DrawTest` plays for `glsDrawTest.cpp`. Per this
//   whole effort's scope rule, this stays framework/library code only - nothing here
//   registers an actual `dEQP-GLES*.*.vertex_arrays.*` case.

pub mod array;
pub mod context_array;
pub mod context_array_pack;
pub mod gl_value;
pub mod random_array_generator;
pub mod test_groups;
pub mod vertex_array_test;

pub use context_array::ContextArray;
pub use gl_value::GLValue;

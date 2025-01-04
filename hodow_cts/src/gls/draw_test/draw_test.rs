// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.cpp / .hpp  (deqp::gls::DrawTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `DrawTest` is upstream's `tcu::TestCase` driver: it builds two `AttributePack`s (one
// against `sglr::GLContext`, one against `sglr::ReferenceContext`), issues the
// identical sequence of calls through both for each `DrawTestSpec` it was given, and
// uses `compare` to decide whether the two rendered images agree.
//
// **This port so far: the struct, its constructors (`new`/`add_iteration`), the pure
// per-iteration arithmetic (`plan_iteration`), and both halves of the actual per-spec
// work (`draw_iteration`/`compare_iteration`) - the whole of `DrawTest::iterate`'s two
// branches**. `Storage::User` indices are handled by `draw_iteration` (see its doc comment).
// `compare_iteration` is "wire `compare`'s already-ported
// comparisons to each pack's `Surface`" rather than new logic of its own.
//
// Narrowings relative to upstream, same reasoning `attribute_pack.rs`/`compare.rs`
// already used:
//  - **No `tcu::TestCase`/`TestContext`/`TestLog`/`tcu::ResultCollector`.** None of
//    `TestCase`, `TestContext` or `TestLog` exist anywhere in this crate (confirmed by
//    grep), so there is no base class to derive from and nothing to log into -
//    `init`/`deinit`/the `tcu::TestCase::IterateResult` state machine have no
//    counterpart. `ResultCollector` *does* exist (`tcu::result_collector`), but nothing
//    here uses it yet - see the per-iteration result shape note below.
//  - **No `glu::RenderContext`/`glu::ContextInfo` member** - both exist solely to feed
//    `init()`'s now-absent context/pack construction (see "Still to port"); a caller
//    that has already built its own `GLContext`/`ReferenceContext` has no use for
//    either.
//  - **The two-call-per-spec shape (`m_iteration % 2` picking a draw step vs. a
//    compare step) collapses to two plain methods** once `init`/`iterate` are ported -
//    `draw_iteration`/`compare_iteration`, called back to back by whatever drives a
//    `DrawTest` (out of scope here; this module is framework, not a registered case).
//    The upstream split exists only so each `tcu::TestCase::iterate()` call does a
//    bounded amount of work for incremental `TestLog` sections
//    (`IterationLogSectionEmitter`); with no log to section, nothing is lost by a
//    caller simply calling both in sequence.

use super::attribute_array::AttributeArray;
use super::attribute_pack::AttributePack;
use super::spec::{CompatibilityTestType, DrawTestSpec, IndexType, MethodInfo, Storage, Target, Usage};
use super::{compare, random_array_generator};
use crate::rr::generic_vector::GenericVec4;
use crate::sglr::context::Context;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::vector::IVec3;

/// Everything upstream's `DrawTest::iterate` computes once, at the top of its draw
/// step, from the spec alone - before any `AttributeArray`/`sglr::Context` call.
/// Kept as its own struct/function (rather than inlined into whatever ends up driving
/// the render calls) because every field here is pure arithmetic over `DrawTestSpec`
/// and `DrawMethod::info()`, fully hand-traceable without a live GL/reference context.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct IterationPlan {
    pub method_info: MethodInfo,
    /// `primitiveElementCount` - vertices the primitive itself needs (per instance).
    pub primitive_element_count: usize,
    /// `indexMin` - 0 unless `drawMethod` is `Draw*Ranged`, in which case `spec.index_min`.
    pub index_min: i32,
    /// `indexMax` - `spec.index_max` clamped into `[0, maxElementIndex]` for a ranged
    /// method, `maxElementIndex` (also floored at 0) otherwise.
    pub index_max: i32,
    /// `elementCount` - elements the backing buffer needs (>= `primitive_element_count`,
    /// since `first`/`indexMin`/a positive `baseVertex` all shift where the primitive's
    /// own elements start reading from).
    pub element_count: usize,
    /// `indexBase` - only nonzero for a *negative* `baseVertex` on a `*BaseVertex`
    /// method: generated indices are pushed up by `-baseVertex` so that
    /// `index + baseVertex` (which `glDrawElementsBaseVertex` computes internally)
    /// still lands in the buffer's valid range instead of underflowing.
    pub index_base: i32,
    pub coord_scale: f32,
    pub color_scale: f32,
}

/// `de::clamp<int>(v, min, max)`, i.e. `max(minVal, min(v, maxVal))` - this is *not*
/// the same as `i32::clamp`, which asserts `min <= max` and panics otherwise. Upstream's
/// version has no such assert and degrades gracefully to `min` whenever `max < min`,
/// which matters here: `maxElementIndex` can be negative for a degenerate spec (e.g.
/// `primitiveElementCount == 0`), and upstream's own
/// `de::max(0, de::clamp(spec.indexMax, 0, maxElementIndex))` relies on exactly that
/// graceful degradation rather than asserting the range is sane first.
fn de_clamp(v: i32, min: i32, max: i32) -> i32 {
    min.max(v.min(max))
}

/// `DrawTest::iterate`'s draw-step preamble (upstream lines ~3670-3693).
pub fn plan_iteration(spec: &DrawTestSpec) -> IterationPlan {
    let method_info = spec.draw_method.info();

    let primitive_element_count = spec.primitive.element_count(spec.primitive_count as usize);
    let index_min: i32 = if method_info.ranged { spec.index_min } else { 0 };
    let first_addition: i32 = if method_info.first { spec.first } else { 0 };
    // spec.baseVertex > 0 => create a bigger attribute buffer
    let base_vertex_addition: i32 = if method_info.base_vertex && spec.base_vertex > 0 {
        spec.base_vertex
    } else {
        0
    };
    // spec.baseVertex < 0 => create bigger indices
    let index_base: i32 = if method_info.base_vertex && spec.base_vertex < 0 {
        -spec.base_vertex
    } else {
        0
    };

    let element_count =
        (primitive_element_count as i64 + index_min as i64 + first_addition as i64 + base_vertex_addition as i64)
            as usize;
    let max_element_index: i32 = primitive_element_count as i32 + index_min + first_addition - 1;
    let index_max: i32 = if method_info.ranged {
        de_clamp(spec.index_max, 0, max_element_index)
    } else {
        max_element_index
    }
    .max(0);

    IterationPlan {
        method_info,
        primitive_element_count,
        index_min,
        index_max,
        element_count,
        index_base,
        coord_scale: compare::get_coord_scale(spec),
        color_scale: compare::get_color_scale(spec),
    }
}

/// What `draw_iteration` found after issuing the draw through both contexts.
/// `DrawTest::iterate`'s own `catch (glu::Error &err)` block, collapsed into a return
/// value since this port has no exception to catch - the draw calls themselves never
/// unwind, they only leave an error code behind in `ctx.get_error()`, so this checks
/// both contexts' error state once after the fact instead of wrapping the GL calls in
/// a try block. Upstream's single `catch` is one `glu::Error` from *either*
/// `m_glArrayPack` or `m_rrArrayPack`; with two independent error states here, either
/// one being non-zero is treated the same way upstream treats catching one.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DrawStepOutcome {
    Ok,
    /// `spec.isCompatibilityTest()` was not `COMPATIBILITY_NONE` - upstream logs a
    /// `QP_TEST_RESULT_COMPATIBILITY_WARNING` rather than failing outright, since an
    /// unaligned offset/stride is expected to legitimately fail to draw on some
    /// drivers.
    CompatibilityWarning(CompatibilityTestType),
}

/// `DrawTest` - see this file's own top doc comment for scope and narrowings.
pub struct DrawTest {
    specs: Vec<DrawTestSpec>,
    descriptions: Vec<Option<String>>,
    /// `m_maxDiffRed`/`Green`/`Blue` - computed once from the render target's own
    /// `PixelFormat`, used by `compare_iteration`'s point comparison.
    max_diff_red: i32,
    max_diff_green: i32,
    max_diff_blue: i32,
    /// `PixelFormat::getColorThreshold().toIVec().xyz()` - the triangle comparison's
    /// edge-detection threshold, a *different* derivation from the same `PixelFormat`
    /// (see `compare_iteration`'s own doc comment for why these aren't the same
    /// three numbers as `max_diff_*` despite both coming from bit depths).
    render_target_threshold: IVec3,
    /// `m_renderCtx.getRenderTarget().getNumSamples()` - upstream reads this from the
    /// render context afresh in `init()`; this port takes it once, up front, same as
    /// `PixelFormat`, since there is no `glu::RenderContext` member here (see this
    /// file's own top doc comment).
    num_samples: i32,
}

impl DrawTest {
    /// `DrawTest::init`'s `PixelFormat`/`numSamples`-derived state, computed once
    /// up front rather than from a stored `glu::RenderContext` (see this file's own
    /// top doc comment on why there is no such member here).
    pub fn new(pixel_format: PixelFormat, num_samples: i32) -> Self {
        let threshold = pixel_format.get_color_threshold();
        // `deCeilFloatToInt32(256.0f * (6.0f / (1 << bits)))`
        let max_diff = |bits: i32| (256.0f32 * (6.0f32 / (1i32 << bits) as f32)).ceil() as i32;
        Self {
            specs: Vec::new(),
            descriptions: Vec::new(),
            max_diff_red: max_diff(pixel_format.red_bits),
            max_diff_green: max_diff(pixel_format.green_bits),
            max_diff_blue: max_diff(pixel_format.blue_bits),
            render_target_threshold: IVec3::from_array([
                threshold.get_red(),
                threshold.get_green(),
                threshold.get_blue(),
            ]),
            num_samples,
        }
    }

    /// `DrawTest::addIteration`. Upstream asserts (`DE_ASSERT`) and then silently
    /// no-ops on an invalid spec or an API-type mismatch against the first spec added;
    /// this returns `false` for the same two cases instead, so a caller - and a test -
    /// can tell the no-op happened rather than it being observable only via
    /// `spec_count()` staying unchanged.
    #[allow(clippy::collapsible_if)]
    pub fn add_iteration(&mut self, spec: DrawTestSpec, description: Option<String>) -> bool {
        if !spec.valid() {
            debug_assert!(false, "DrawTest::add_iteration: invalid spec");
            return false;
        }

        if let Some(first) = self.specs.first() {
            if first.api_type != spec.api_type {
                debug_assert!(
                    false,
                    "DrawTest::add_iteration: api_type must match every other iteration"
                );
                return false;
            }
        }

        self.specs.push(spec);
        self.descriptions.push(description);
        true
    }

    pub fn spec_count(&self) -> usize {
        self.specs.len()
    }

    pub fn spec(&self, spec_ndx: usize) -> &DrawTestSpec {
        &self.specs[spec_ndx]
    }

    pub fn description(&self, spec_ndx: usize) -> Option<&str> {
        self.descriptions[spec_ndx].as_deref()
    }

    /// Whether the shader program needs rebuilding before drawing `spec_ndx` - true for
    /// the very first iteration, or whenever the current spec's attribute list isn't
    /// shader-compatible with the previous one's (`checkSpecsShaderCompatible`).
    /// Upstream computes this inline in `iterate` (`m_iteration == 0 || ...`); split out
    /// here since it depends only on `specs`, not on which half of a draw/compare pair
    /// the caller is about to run.
    pub fn should_update_program(&self, spec_ndx: usize) -> bool {
        spec_ndx == 0 || !super::spec::specs_shader_compatible(&self.specs[spec_ndx], &self.specs[spec_ndx - 1])
    }

    /// `DrawTest::iterate`'s draw step (upstream lines ~3668-3848): builds this
    /// iteration's attribute data and issues the identical draw through both
    /// `gl_pack`/`gl_ctx` and `rr_pack`/`rr_ctx`, rebuilding the shader program on
    /// either side first when `should_update_program` says to. A caller only needs to
    /// have constructed both packs via `AttributePack::new` beforehand - everything
    /// else (`clear_arrays`/attribute upload/`update_program`/the draw call itself)
    /// happens in here, matching what upstream's `iterate` does inline.
    ///
    /// **`Storage::User` indices**: the real-driver side draws from client memory
    /// exactly as upstream does; the `ReferenceContext` side (no client-pointer element
    /// path) holds the same bytes in a buffer and draws at the same byte offset.
    #[allow(clippy::too_many_arguments)]
    pub fn draw_iteration(
        &self,
        spec_ndx: usize,
        gl_ctx: &mut dyn Context,
        gl_pack: &mut AttributePack,
        rr_ctx: &mut dyn Context,
        rr_pack: &mut AttributePack,
    ) -> Result<DrawStepOutcome, String> {
        let spec = &self.specs[spec_ndx];
        let plan = plan_iteration(spec);

        gl_pack.clear_arrays(gl_ctx);
        rr_pack.clear_arrays(rr_ctx);

        for (attrib_ndx, attrib_spec) in spec.attribs.iter().enumerate() {
            let is_position_attr = attrib_ndx == 0 || attrib_spec.additional_position_attribute;

            if attrib_spec.use_default_attribute {
                let seed = (10 * attrib_spec.hash() + 100 * spec.hash() + attrib_ndx as i32) as u32;
                let attrib_value = random_array_generator::generate_attribute_value(seed, attrib_spec.input_type);

                gl_pack.new_array(gl_ctx, Storage::User);
                rr_pack.new_array(rr_ctx, Storage::User);
                gl_pack.array_mut(attrib_ndx).setup_array(
                    false,
                    0,
                    attrib_spec.component_count,
                    attrib_spec.input_type,
                    attrib_spec.output_type,
                    false,
                    0,
                    0,
                    attrib_value,
                    is_position_attr,
                    false,
                );
                rr_pack.array_mut(attrib_ndx).setup_array(
                    false,
                    0,
                    attrib_spec.component_count,
                    attrib_spec.input_type,
                    attrib_spec.output_type,
                    false,
                    0,
                    0,
                    attrib_value,
                    is_position_attr,
                    false,
                );
            } else {
                let seed = (attrib_spec.hash() + 100 * spec.hash() + attrib_ndx as i32) as u32;

                // `RandomArrayGenerator::generateArray`'s returned buffer is already
                // sized to exactly this (its own internal formula is the same one
                // upstream's `DrawTest::iterate` computes independently as
                // `bufferSize`) - see `random_array_generator.rs`'s `create_basic_array`,
                // confirmed by reading its body - so there is no separate `bufferSize`
                // to compute here, only `referencedElementCount` to pass in.
                let evaluated_element_count: i64 = if plan.method_info.instanced && attrib_spec.instance_divisor > 0 {
                    i64::from(spec.instance_count) / i64::from(attrib_spec.instance_divisor) + 1
                } else {
                    plan.element_count as i64
                };
                let referenced_element_count: i64 = if plan.method_info.ranged {
                    evaluated_element_count.max(i64::from(spec.index_max) + 1)
                } else {
                    evaluated_element_count
                };

                let element_size = attrib_spec.component_count * attrib_spec.input_type.size();
                let stride = if attrib_spec.stride == 0 {
                    element_size
                } else {
                    attrib_spec.stride
                };
                let data = random_array_generator::generate_array(
                    seed,
                    referenced_element_count as i32,
                    attrib_spec.component_count,
                    attrib_spec.offset,
                    stride,
                    attrib_spec.input_type,
                );

                gl_pack.new_array(gl_ctx, attrib_spec.storage);
                rr_pack.new_array(rr_ctx, attrib_spec.storage);
                gl_pack
                    .array_mut(attrib_ndx)
                    .set_data(gl_ctx, Target::Array, &data, attrib_spec.usage);
                rr_pack
                    .array_mut(attrib_ndx)
                    .set_data(rr_ctx, Target::Array, &data, attrib_spec.usage);
                gl_pack.array_mut(attrib_ndx).setup_array(
                    true,
                    attrib_spec.offset,
                    attrib_spec.component_count,
                    attrib_spec.input_type,
                    attrib_spec.output_type,
                    attrib_spec.normalize,
                    attrib_spec.stride,
                    attrib_spec.instance_divisor,
                    GenericVec4::default(),
                    is_position_attr,
                    attrib_spec.bgra_component_order,
                );
                rr_pack.array_mut(attrib_ndx).setup_array(
                    true,
                    attrib_spec.offset,
                    attrib_spec.component_count,
                    attrib_spec.input_type,
                    attrib_spec.output_type,
                    attrib_spec.normalize,
                    attrib_spec.stride,
                    attrib_spec.instance_divisor,
                    GenericVec4::default(),
                    is_position_attr,
                    attrib_spec.bgra_component_order,
                );
            }
        }

        if self.should_update_program(spec_ndx) {
            gl_pack.update_program(gl_ctx);
            rr_pack.update_program(rr_ctx);
        }

        if plan.method_info.indexed {
            let seed = spec.hash() as u32;
            let index_bytes = random_array_generator::generate_indices(
                seed,
                plan.element_count as i32,
                spec.index_type,
                spec.index_pointer_offset,
                plan.index_min,
                plan.index_max,
                plan.index_base,
            );

            // `ReferenceContext`'s element-array draw has no client-pointer path, so on that side
            // user-pointer indices are held in a buffer instead and drawn at the same byte offset -
            // the image is identical, only where the bytes live differs.
            let rr_index_storage = if spec.index_storage == Storage::User {
                Storage::Buffer
            } else {
                spec.index_storage
            };
            let mut gl_index_array = AttributeArray::new(gl_ctx, spec.index_storage);
            let mut rr_index_array = AttributeArray::new(rr_ctx, rr_index_storage);
            gl_index_array.set_data(gl_ctx, Target::ElementArray, &index_bytes, Usage::StaticDraw);
            rr_index_array.set_data(rr_ctx, Target::ElementArray, &index_bytes, Usage::StaticDraw);

            // `render`'s `range_start`/`range_end` are `spec.index_min`/`spec.index_max`
            // *directly* - upstream's own call site passes `spec.indexMin`/
            // `spec.indexMax` here, not the locally-computed (ranged-aware, clamped)
            // `indexMin`/`indexMax` preamble variables `plan` carries. Those feed
            // `generateIndices` above, not the draw call's own range hint - the two
            // can legitimately differ when `spec.indexMax` needed clamping.
            let gl_index_offset = if spec.index_storage == Storage::User {
                gl_index_array.user_data().as_ptr() as usize + spec.index_pointer_offset as usize
            } else {
                spec.index_pointer_offset as usize
            };
            gl_pack.render(
                gl_ctx,
                spec.primitive,
                spec.draw_method,
                0,
                plan.primitive_element_count as i32,
                spec.index_type,
                gl_index_offset,
                spec.index_min as u32,
                spec.index_max as u32,
                spec.instance_count,
                spec.indirect_offset as usize,
                spec.base_vertex,
                plan.coord_scale,
                plan.color_scale,
                Some(&gl_index_array),
            );
            rr_pack.render(
                rr_ctx,
                spec.primitive,
                spec.draw_method,
                0,
                plan.primitive_element_count as i32,
                spec.index_type,
                spec.index_pointer_offset as usize,
                spec.index_min as u32,
                spec.index_max as u32,
                spec.instance_count,
                spec.indirect_offset as usize,
                spec.base_vertex,
                plan.coord_scale,
                plan.color_scale,
                Some(&rr_index_array),
            );

            gl_index_array.destroy(gl_ctx);
            rr_index_array.destroy(rr_ctx);
        } else {
            gl_pack.render(
                gl_ctx,
                spec.primitive,
                spec.draw_method,
                spec.first,
                plan.primitive_element_count as i32,
                IndexType::Last,
                0,
                0,
                0,
                spec.instance_count,
                spec.indirect_offset as usize,
                0,
                plan.coord_scale,
                plan.color_scale,
                None,
            );
            rr_pack.render(
                rr_ctx,
                spec.primitive,
                spec.draw_method,
                spec.first,
                plan.primitive_element_count as i32,
                IndexType::Last,
                0,
                0,
                0,
                spec.instance_count,
                spec.indirect_offset as usize,
                0,
                plan.coord_scale,
                plan.color_scale,
                None,
            );
        }

        let gl_err = gl_ctx.get_error();
        let rr_err = rr_ctx.get_error();

        if gl_err != 0 || rr_err != 0 {
            match spec.is_compatibility_test() {
                CompatibilityTestType::None => Err(format!(
                    "DrawTest::draw_iteration: unexpected GL error (gl={gl_err:#x}, rr={rr_err:#x})"
                )),
                other => Ok(DrawStepOutcome::CompatibilityWarning(other)),
            }
        } else {
            Ok(DrawStepOutcome::Ok)
        }
    }

    /// `DrawTest::compare` - compares `gl_pack`'s rendered `Surface` against
    /// `rr_pack`'s using whichever of `compare`'s three primitive-class comparisons
    /// `spec.primitive` selects, or a single fixed-threshold `fuzzy_compare` when
    /// `num_samples > 1` (upstream's own multisample branch, hardcoded to a `0.3`
    /// difference threshold with the same "not as strict, might false-positive"
    /// caveat its own comment states - ported verbatim, not strengthened).
    ///
    /// `max_diff_red/green/blue` and `render_target_threshold` are genuinely different
    /// numbers derived from the same `PixelFormat`, not a duplicate: the former is
    /// `256 * 6 / 2^bits` (how far two *colour* samples may legitimately differ), the
    /// latter is `PixelFormat::getColorThreshold()` (how large a one-rounding-step
    /// *ramp* between adjacent pixels can be before `compare`'s edge detector stops
    /// trusting it) - upstream computes both from `m_renderCtx.getRenderTarget()` but
    /// never reuses one for the other.
    pub fn compare_iteration(&self, spec_ndx: usize, gl_pack: &AttributePack, rr_pack: &AttributePack) -> bool {
        let spec = &self.specs[spec_ndx];
        // upstream's own argument order: reference (rr) first, result (gl) second.
        let reference = rr_pack.surface();
        let result = gl_pack.surface();

        if self.num_samples > 1 {
            fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), 0.3).unwrap_or(false)
        } else {
            let max_diff = [self.max_diff_red, self.max_diff_green, self.max_diff_blue];
            match compare::get_draw_primitive_class(spec.primitive) {
                // points are extremely unlikely to have overlapping regions - no extra
                // or missing pixels allowed at all.
                compare::PrimitiveClass::Point => compare::int_threshold_position_deviation_error_threshold_compare(
                    reference,
                    result,
                    [max_diff[0], max_diff[1], max_diff[2], 256],
                    IVec3::from_array([1, 1, 0]), // 3x3 search kernel
                    true,                         // relax comparison on the image boundary
                    0,
                ),
                // lines may legitimately overdraw each other near intersections - a
                // handful of invalid pixels there is allowed.
                compare::PrimitiveClass::Line => {
                    compare::intersection_relaxed_line_image_compare(reference, result, IVec3::from_array(max_diff), 5)
                }
                // triangles are likely to partially or fully overlap - relax near
                // primitive edges, where only coverage (not colour) is checked.
                compare::PrimitiveClass::Triangle => compare::edge_relaxed_image_compare(
                    reference,
                    result,
                    IVec3::from_array(max_diff),
                    self.render_target_threshold,
                    10,
                ),
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::gls::draw_test::spec::{AttributeSpec, DrawMethod, InputType, OutputType, Primitive, Storage, Usage};
    use crate::glu::render_context::{ApiType, ContextType};
    use crate::sglr::reference_context::ReferenceContext;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    fn es2() -> ApiType {
        ApiType::es(2, 0)
    }

    fn es2_context_type() -> ContextType {
        ContextType { api: es2() }
    }

    /// Same three-line helper `attribute_array.rs`/`attribute_pack.rs`'s own tests use.
    fn ctx() -> ReferenceContext {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let color = TextureLevel::new(format, 8, 8, 1).unwrap();
        ReferenceContext::new(16, color, None, 8)
    }

    /// A plain RGBA8888, single-sample `DrawTest::new` - what every test here that
    /// doesn't care about the pixel-format-derived thresholds themselves wants.
    fn new_test() -> DrawTest {
        DrawTest::new(PixelFormat::new(8, 8, 8, 8), 1)
    }

    fn minimal_valid_spec(api: ApiType, primitive: Primitive, draw_method: DrawMethod) -> DrawTestSpec {
        let mut spec = DrawTestSpec::new(api);
        spec.primitive = primitive;
        spec.primitive_count = 2;
        spec.draw_method = draw_method;
        spec.attribs.push(AttributeSpec::create_attribute_array(
            InputType::Float,
            OutputType::Vec2,
            Storage::Buffer,
            Usage::StaticDraw,
            2,
            0,
            0,
            false,
            0,
        ));
        spec
    }

    #[test]
    fn add_iteration_accepts_a_valid_spec_and_tracks_count() {
        let mut test = new_test();
        let spec = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        assert!(
            spec.valid(),
            "test fixture must itself be valid - precondition, not what's under test"
        );
        assert!(test.add_iteration(spec, Some("first".to_string())));
        assert_eq!(test.spec_count(), 1);
        assert_eq!(test.description(0), Some("first"));
    }

    #[test]
    #[should_panic(expected = "DrawTest::add_iteration: invalid spec")]
    fn add_iteration_rejects_an_invalid_spec() {
        // `DrawTestSpec::valid`'s own `debug_assert_ne!(self.primitive, Primitive::Last)`/
        // `debug_assert_ne!(self.draw_method, DrawMethod::Last)` are a precondition on
        // the *caller* (never call `valid()` before both are set to a real value, the
        // same contract upstream's own `DE_ASSERT`s there establish) - a spec left at
        // the `Last` sentinel would panic `valid()` itself rather than reach
        // `add_iteration`'s own check, so this needs a validity failure `valid()` can
        // actually report: `DrawArrays`' own `info.first && self.first < 0` rejection.
        // `add_iteration`'s own `debug_assert!(false, "...")` on that then panics in a
        // debug build before ever reaching its `return false` - the same "loud in
        // debug, graceful in release" contract `add_iteration_rejects_a_mismatched_api_type`
        // above already establishes - so this can only observe the panic here, not the
        // post-rejection `spec_count`.
        let mut test = new_test();
        let mut spec = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        spec.first = -1;
        assert!(!spec.valid());
        test.add_iteration(spec, None);
    }

    #[test]
    #[should_panic(expected = "DrawTest::add_iteration: api_type must match every other iteration")]
    fn add_iteration_rejects_a_mismatched_api_type() {
        // `add_iteration`'s own `debug_assert!(false, "...")` on a mismatched api_type
        // panics in a debug build before ever reaching its `return false` - the same
        // "loud in debug, graceful in release" contract its own body documents, so
        // this can only observe the panic here, not the post-rejection `spec_count`.
        let mut test = new_test();
        let first = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        assert!(test.add_iteration(first, None));

        let mismatched = minimal_valid_spec(ApiType::es(3, 0), Primitive::Points, DrawMethod::DrawArrays);
        test.add_iteration(mismatched, None);
    }

    #[test]
    fn should_update_program_is_true_on_the_first_iteration() {
        let mut test = new_test();
        test.add_iteration(
            minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays),
            None,
        );
        assert!(test.should_update_program(0));
    }

    #[test]
    fn should_update_program_false_for_shader_compatible_consecutive_specs() {
        let mut test = new_test();
        // same attribs, different primitive - `specs_shader_compatible` doesn't look
        // at `primitive` at all, only each attrib's output type.
        let a = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        let b = minimal_valid_spec(es2(), Primitive::Triangles, DrawMethod::DrawArrays);
        test.add_iteration(a, None);
        test.add_iteration(b, None);
        assert!(!test.should_update_program(1));
    }

    #[test]
    fn should_update_program_true_when_attribute_lists_diverge() {
        let mut test = new_test();
        let a = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        let mut b = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        b.attribs.push(AttributeSpec::create_attribute_array(
            InputType::Float,
            OutputType::Vec2,
            Storage::Buffer,
            Usage::StaticDraw,
            2,
            0,
            0,
            false,
            0,
        ));
        test.add_iteration(a, None);
        test.add_iteration(b, None);
        assert!(test.should_update_program(1));
    }

    #[test]
    fn plan_iteration_draw_arrays_points() {
        // DrawArrays: indexed=false, instanced=false, ranged=false, first=true,
        // base_vertex=false (MethodInfo table in spec.rs). Points: element_count ==
        // primitive_count directly (no scaling).
        let mut spec = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        spec.primitive_count = 5;
        spec.first = 3;

        let plan = plan_iteration(&spec);
        assert_eq!(plan.primitive_element_count, 5);
        assert_eq!(plan.index_min, 0); // not ranged
        // elementCount = primitiveElementCount(5) + indexMin(0) + firstAddition(3) + baseVertexAddition(0)
        assert_eq!(plan.element_count, 8);
        // maxElementIndex = 5 + 0 + 3 - 1 = 7; not ranged => indexMax = max(0, 7) = 7
        assert_eq!(plan.index_max, 7);
        assert_eq!(plan.index_base, 0); // base_vertex method info is false for DrawArrays
    }

    #[test]
    fn plan_iteration_draw_elements_ranged_triangles() {
        // DrawElementsRanged: indexed=true, instanced=false, ranged=true, first=false,
        // base_vertex=false. Triangles: element_count = primitive_count * 3.
        // ES3.1, not ES2 - `DrawTestSpec::valid` restricts ES2 to DrawArrays/
        // DrawElements only (irrelevant to `plan_iteration` itself, which never calls
        // `valid()`, but kept realistic since nothing would ever actually construct
        // this combination with an ES2 api_type).
        let mut spec = minimal_valid_spec(ApiType::es(3, 1), Primitive::Triangles, DrawMethod::DrawElementsRanged);
        spec.primitive_count = 2; // -> 6 vertices
        spec.index_min = 10;
        spec.index_max = 1000; // deliberately absurd, must be clamped down

        let plan = plan_iteration(&spec);
        assert_eq!(plan.primitive_element_count, 6);
        assert_eq!(plan.index_min, 10); // ranged => spec.index_min passed through
        // elementCount = 6 + 10 + 0(no `first`) + 0(no base vertex) = 16
        assert_eq!(plan.element_count, 16);
        // maxElementIndex = 6 + 10 + 0 - 1 = 15; ranged => clamp(1000, 0, 15) = 15
        assert_eq!(plan.index_max, 15);
    }

    #[test]
    fn plan_iteration_negative_base_vertex_sets_index_base_not_element_count() {
        // DrawElementsBaseVertex: indexed=true, ranged=false, first=false,
        // base_vertex=true. A *negative* baseVertex bumps `index_base`, not
        // `baseVertexAddition` (that only triggers for a *positive* baseVertex).
        let mut spec = minimal_valid_spec(ApiType::es(3, 1), Primitive::Points, DrawMethod::DrawElementsBaseVertex);
        spec.primitive_count = 4;
        spec.base_vertex = -7;

        let plan = plan_iteration(&spec);
        assert_eq!(plan.primitive_element_count, 4);
        // elementCount = 4 + 0 + 0 + 0 (negative base_vertex doesn't add to element_count)
        assert_eq!(plan.element_count, 4);
        assert_eq!(plan.index_base, 7);
    }

    #[test]
    fn plan_iteration_positive_base_vertex_grows_element_count_not_index_base() {
        let mut spec = minimal_valid_spec(ApiType::es(3, 1), Primitive::Points, DrawMethod::DrawElementsBaseVertex);
        spec.primitive_count = 4;
        spec.base_vertex = 9;

        let plan = plan_iteration(&spec);
        // elementCount = 4 + 0 + 0 + 9 (positive base_vertex grows the buffer instead)
        assert_eq!(plan.element_count, 13);
        assert_eq!(plan.index_base, 0);
    }

    #[test]
    fn plan_iteration_carries_coord_and_color_scale_from_compare_module() {
        let spec = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        let plan = plan_iteration(&spec);
        assert_eq!(plan.coord_scale, compare::get_coord_scale(&spec));
        assert_eq!(plan.color_scale, compare::get_color_scale(&spec));
    }

    #[test]
    fn new_computes_max_diff_from_pixel_format_bit_depth() {
        // deCeilFloatToInt32(256 * (6 / (1 << 8))) = ceil(256*6/256) = ceil(6.0) = 6
        let test = DrawTest::new(PixelFormat::new(8, 8, 8, 8), 1);
        assert_eq!(test.max_diff_red, 6);
        assert_eq!(test.max_diff_green, 6);
        assert_eq!(test.max_diff_blue, 6);

        // 5 bits: ceil(256*6/32) = ceil(48.0) = 48
        let test16 = DrawTest::new(PixelFormat::new(5, 6, 5, 0), 1);
        assert_eq!(test16.max_diff_red, 48);
        // 6 bits: ceil(256*6/64) = ceil(24.0) = 24
        assert_eq!(test16.max_diff_green, 24);
        assert_eq!(test16.max_diff_blue, 48);
    }

    #[test]
    fn new_derives_render_target_threshold_from_color_threshold() {
        // PixelFormat::channel_threshold(8) = 1 (since bits <= 8 uses 1 << (8-bits));
        // `get_color_threshold` is the same per-channel table `compare.rs`'s own
        // `render_target_threshold` field reuses for triangle edge-detection.
        let test = DrawTest::new(PixelFormat::new(8, 8, 8, 8), 1);
        assert_eq!(test.render_target_threshold, IVec3::from_array([1, 1, 1]));
    }

    /// The end-to-end test this whole file exists for: two independently-constructed
    /// `ReferenceContext`s, one `AttributePack` each, driven through
    /// `DrawTest::draw_iteration` with the identical spec. Since both sides are fed
    /// the exact same generated vertex data (`draw_iteration` generates it once per
    /// attribute and uploads the same bytes to both packs, matching upstream) and
    /// `ReferenceContext` is a deterministic software rasterizer, the two resulting
    /// `Surface`s must come out pixel-for-pixel identical - a stronger check than
    /// `compare`'s own fuzzy comparisons, and possible here only because neither side
    /// is a real, non-deterministic GL driver.
    #[test]
    fn draw_iteration_unindexed_draw_arrays_points_matches_between_two_reference_contexts() {
        let mut gl_cx = ctx();
        let mut rr_cx = ctx();
        let mut gl_pack = AttributePack::new(&mut gl_cx, es2_context_type(), 8, 8, false);
        let mut rr_pack = AttributePack::new(&mut rr_cx, es2_context_type(), 8, 8, false);

        let mut test = new_test();
        let mut spec = minimal_valid_spec(es2(), Primitive::Points, DrawMethod::DrawArrays);
        spec.primitive_count = 2;
        assert!(spec.valid());
        assert!(test.add_iteration(spec, None));

        let outcome = test.draw_iteration(0, &mut gl_cx, &mut gl_pack, &mut rr_cx, &mut rr_pack);
        assert_eq!(outcome, Ok(DrawStepOutcome::Ok));
        assert_eq!(gl_cx.get_error(), 0);
        assert_eq!(rr_cx.get_error(), 0);

        let gl_surface = gl_pack.surface();
        let rr_surface = rr_pack.surface();
        assert_eq!(gl_surface.get_width(), rr_surface.get_width());
        assert_eq!(gl_surface.get_height(), rr_surface.get_height());
        for y in 0..gl_surface.get_height() {
            for x in 0..gl_surface.get_width() {
                assert_eq!(
                    gl_surface.get_pixel(x, y),
                    rr_surface.get_pixel(x, y),
                    "pixel ({x}, {y}) differs between the two ReferenceContext-backed packs"
                );
            }
        }

        // Bit-identical surfaces must also pass the real `compare_iteration` - the
        // zero-tolerance point comparison (`max_allowed_failing_pixels = 0`) demands
        // nothing less.
        assert!(test.compare_iteration(0, &gl_pack, &rr_pack));

        gl_pack.destroy(&mut gl_cx);
        rr_pack.destroy(&mut rr_cx);
    }
}

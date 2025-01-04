// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.cpp  (the free comparison/threshold functions right
//   before the `DrawTest` class: `isBlack`, `isEdgeTriplet(Component)`,
//   `pixelNearEdge`, `getVisualizationGrayscaleColor`, `pixelNearLineIntersection`,
//   `colorsEqual`, `pixelNeighborhoodContainsColor`/`Coverage`,
//   `edgeRelaxedImageCompare`, `intersectionRelaxedLineImageCompare`, plus
//   `getDrawPrimitiveClass`/`containsLineCases` and `DrawTest::getCoordScale`/
//   `getColorScale`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The comparison/threshold half of `glsDrawTest.cpp`'s `DrawTest`: deciding whether a
// GL-rendered image and a reference-rendered image of the same draw call are "the
// same" within the slop any two independent rasterizers legitimately disagree on
// (one extra/missing pixel at a primitive edge, a one-off position deviation for an
// unindexed point). `DrawTest::compare` (not yet ported) picks one of the three
// comparisons below by `PrimitiveClass`.
//
// **No `tcu::TestLog`/error-mask image anywhere in this file** - every one of
// upstream's three top-level compare functions builds a `tcu::TextureLevel` purely to
// paint a green/red "this pixel passed/failed" visualisation and log it; nothing
// about *whether* a pixel passes reads that image back; `numFailingPixels` is
// accumulated identically whether or not the paint happens. Confirmed by reading
// every branch of `edgeRelaxedImageCompare`/`intersectionRelaxedLineImageCompare`/
// `findNumPositionDeviationFailingPixels` in full: the `errorAccess.setPixel(...)`/
// `errorMask.setPixel(...)` calls are always the last statement of whichever branch
// they're in, never read back within the same function. Dropping them changes no
// pass/fail verdict, only what a human reading a log would see - the same
// `tcu::TestContext`/`TestLog`-absence narrowing every other piece of this module has
// already made (see `attribute_pack.rs`'s own top doc comment).
//
// **`colorsEqual` inlines `tcu::compareThresholdMasked`** rather than calling it -
// that function has no counterpart anywhere in this port's `tcu::rgba` (grepped: no
// `compare_threshold_masked`), and every caller here only ever needs the
// RGB-channels-only mask upstream's own `TCU_RGBA_RGB_MASK` passes, so the inlined
// three-channel absolute-difference check is the whole of what would otherwise be a
// one-call wrapper around a more general function nothing else in this port needs.
//
// **`findNumPositionDeviationFailingPixels` drops the depth (`z`) axis** - upstream
// takes a general `ConstPixelBufferAccess` for 3D-texture-shaped callers elsewhere in
// `tcu`, but `DrawTest::compare` only ever passes `tcu::Surface::getAccess()`, and
// `tcu::Surface` (this port's, same as upstream's) is unconditionally a single 2D
// layer - so this works directly against `&Surface`/`RGBA` rather than
// `ConstPixelBufferAccess`/`getPixelInt`, with the always-`0..1` `z` loop collapsed
// away entirely.
//
// `getVisualizationGrayscaleColor` has no port here at all - its only caller was the
// now-dropped error-mask paint step above, so nothing in this file still needs it.

use super::gl_value::GLValue;
use super::spec::{DrawTestSpec, InputType, OutputType, Primitive};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::IVec3;

fn is_black(c: RGBA) -> bool {
    // ignore alpha channel
    c.get_red() == 0 && c.get_green() == 0 && c.get_blue() == 0
}

fn is_edge_triplet_component(c1: i32, c2: i32, c3: i32, render_target_difference: i32) -> bool {
    // src and dst pixels rounded to different directions
    let rounding_difference = 2 * render_target_difference;
    let d1 = c2 - c1;
    let d2 = c3 - c2;
    let ramp_diff = (d2 - d1).abs();
    ramp_diff > rounding_difference
}

fn is_edge_triplet(c1: RGBA, c2: RGBA, c3: RGBA, render_target_threshold: IVec3) -> bool {
    // black (background color) and non-black is always an edge
    {
        let b1 = is_black(c1);
        let b2 = is_black(c2);
        let b3 = is_black(c3);

        // both pixels with coverage and pixels without coverage
        if !(b1 && b2 && b3) && (b1 || b2 || b3) {
            return true;
        }
        // all black
        if b1 && b2 && b3 {
            return false;
        }
        // all with coverage - nothing else to assert in release, upstream's own
        // `DE_ASSERT(!b1 && !b2 && !b3)` is implied by falling through the two checks
        // above.
        debug_assert!(!b1 && !b2 && !b3);
    }

    // Color is always linearly interpolated => component values change nearly linearly
    // in any constant direction on triangle hull. (df/dx ~= C).
    //
    // Edge detection (this function) is run against the reference image
    // => no dithering to worry about

    is_edge_triplet_component(c1.get_red(), c2.get_red(), c3.get_red(), render_target_threshold.x())
        || is_edge_triplet_component(
            c1.get_green(),
            c2.get_green(),
            c3.get_green(),
            render_target_threshold.y(),
        )
        || is_edge_triplet_component(c1.get_blue(), c2.get_blue(), c3.get_blue(), render_target_threshold.z())
}

fn pixel_near_edge(x: i32, y: i32, reference: &Surface, render_target_threshold: IVec3) -> bool {
    // should not be called for edge pixels
    debug_assert!(x >= 1 && x <= reference.get_width() - 2);
    debug_assert!(y >= 1 && y <= reference.get_height() - 2);

    // horizontal
    for dy in -1..2 {
        let c1 = reference.get_pixel(x - 1, y + dy);
        let c2 = reference.get_pixel(x, y + dy);
        let c3 = reference.get_pixel(x + 1, y + dy);
        if is_edge_triplet(c1, c2, c3, render_target_threshold) {
            return true;
        }
    }

    // vertical
    for dx in -1..2 {
        let c1 = reference.get_pixel(x + dx, y - 1);
        let c2 = reference.get_pixel(x + dx, y);
        let c3 = reference.get_pixel(x + dx, y + 1);
        if is_edge_triplet(c1, c2, c3, render_target_threshold) {
            return true;
        }
    }

    false
}

fn pixel_near_line_intersection(x: i32, y: i32, target: &Surface) -> bool {
    // should not be called for edge pixels
    debug_assert!(x >= 1 && x <= target.get_width() - 2);
    debug_assert!(y >= 1 && y <= target.get_height() - 2);

    let mut covered_pixels = 0;

    for dy in -1..2 {
        for dx in -1..2 {
            let target_coverage = !is_black(target.get_pixel(x + dx, y + dy));
            if target_coverage {
                covered_pixels += 1;

                // A single thin line cannot have more than 3 covered pixels in a 3x3 area
                if covered_pixels >= 4 {
                    return true;
                }
            }
        }
    }

    false
}

/// `colorsEqual` - see this module's own top doc comment for why
/// `tcu::compareThresholdMasked` is inlined rather than called.
fn colors_equal(color_a: RGBA, color_b: RGBA, compare_threshold: IVec3) -> bool {
    (color_a.get_red() - color_b.get_red()).abs() <= compare_threshold.x()
        && (color_a.get_green() - color_b.get_green()).abs() <= compare_threshold.y()
        && (color_a.get_blue() - color_b.get_blue()).abs() <= compare_threshold.z()
}

/// search 3x3 area for matching color
fn pixel_neighborhood_contains_color(target: &Surface, x: i32, y: i32, color: RGBA, compare_threshold: IVec3) -> bool {
    // should not be called for edge pixels
    debug_assert!(x >= 1 && x <= target.get_width() - 2);
    debug_assert!(y >= 1 && y <= target.get_height() - 2);

    for dy in -1..2 {
        for dx in -1..2 {
            let target_cmp_pixel = target.get_pixel(x + dx, y + dy);
            if colors_equal(color, target_cmp_pixel, compare_threshold) {
                return true;
            }
        }
    }

    false
}

/// search 3x3 area for matching coverage (coverage == (color != background color))
fn pixel_neighborhood_contains_coverage(target: &Surface, x: i32, y: i32, coverage: bool) -> bool {
    // should not be called for edge pixels
    debug_assert!(x >= 1 && x <= target.get_width() - 2);
    debug_assert!(y >= 1 && y <= target.get_height() - 2);

    for dy in -1..2 {
        for dx in -1..2 {
            let target_cmp_coverage = !is_black(target.get_pixel(x + dx, y + dy));
            if target_cmp_coverage == coverage {
                return true;
            }
        }
    }

    false
}

/// `edgeRelaxedImageCompare` - used for `PRIMITIVECLASS_TRIANGLE`: triangles are
/// likely to partially or fully overlap, so pixel comparison is relaxed near
/// primitive edges (`pixel_near_edge`) to coverage-only, everywhere else it must be an
/// exact (within-threshold) color match, possibly one pixel off in any direction
/// (`pixel_neighborhood_contains_color`).
pub fn edge_relaxed_image_compare(
    reference: &Surface,
    result: &Surface,
    compare_threshold: IVec3,
    render_target_threshold: IVec3,
    max_allowed_invalid_pixels: i32,
) -> bool {
    debug_assert_eq!(result.get_width(), reference.get_width());
    debug_assert_eq!(result.get_height(), reference.get_height());

    let width = reference.get_width();
    let height = reference.get_height();
    let mut num_failing_pixels = 0;

    // skip edge pixels since coverage on edge cannot be verified
    for y in 1..height - 1 {
        for x in 1..width - 1 {
            let ref_pixel = reference.get_pixel(x, y);
            let screen_pixel = result.get_pixel(x, y);
            let direct_match = colors_equal(ref_pixel, screen_pixel, compare_threshold);
            // screen image has a matching pixel nearby (~= If something is drawn on
            // reference, it must be drawn to screen too.)
            let is_ok_reference_pixel =
                direct_match || pixel_neighborhood_contains_color(result, x, y, ref_pixel, compare_threshold);
            // reference image has a matching pixel nearby (~= If something is drawn on
            // screen, it must be drawn to reference too.)
            let is_ok_screen_pixel =
                direct_match || pixel_neighborhood_contains_color(reference, x, y, screen_pixel, compare_threshold);

            if is_ok_screen_pixel && is_ok_reference_pixel {
                // pixel valid
            } else if !pixel_near_edge(x, y, reference, render_target_threshold) {
                // non-edge pixel values must be within threshold of the reference values
                num_failing_pixels += 1;
            } else {
                // we are on/near an edge, verify only coverage (coverage == not
                // background colored)
                let reference_coverage = !is_black(ref_pixel);
                let screen_coverage = !is_black(screen_pixel);
                // Check reference pixel against screen pixel
                let is_ok_reference_coverage = pixel_neighborhood_contains_coverage(result, x, y, reference_coverage);
                // Check screen pixels against reference pixel
                let is_ok_screen_coverage = pixel_neighborhood_contains_coverage(reference, x, y, screen_coverage);

                if !(is_ok_screen_coverage && is_ok_reference_coverage) {
                    // coverage does not match
                    num_failing_pixels += 1;
                }
            }
        }
    }

    num_failing_pixels <= max_allowed_invalid_pixels
}

/// `intersectionRelaxedLineImageCompare` - used for `PRIMITIVECLASS_LINE`: lines can
/// have many overlapping pixels near their intersections, so comparison is relaxed to
/// coverage-only near a line intersection (`pixel_near_line_intersection`) rather
/// than near a primitive edge.
pub fn intersection_relaxed_line_image_compare(
    reference: &Surface,
    result: &Surface,
    compare_threshold: IVec3,
    max_allowed_invalid_pixels: i32,
) -> bool {
    debug_assert_eq!(result.get_width(), reference.get_width());
    debug_assert_eq!(result.get_height(), reference.get_height());

    let width = reference.get_width();
    let height = reference.get_height();
    let mut num_failing_pixels = 0;

    for y in 1..height - 1 {
        for x in 1..width - 1 {
            let ref_pixel = reference.get_pixel(x, y);
            let screen_pixel = result.get_pixel(x, y);
            let direct_match = colors_equal(ref_pixel, screen_pixel, compare_threshold);
            let is_ok_screen_pixel =
                direct_match || pixel_neighborhood_contains_color(reference, x, y, screen_pixel, compare_threshold);
            let is_ok_reference_pixel =
                direct_match || pixel_neighborhood_contains_color(result, x, y, ref_pixel, compare_threshold);

            if is_ok_screen_pixel && is_ok_reference_pixel {
                // pixel valid
            } else if !pixel_near_line_intersection(x, y, reference) && !pixel_near_line_intersection(x, y, result) {
                // non-intersection pixel values must be within threshold of the
                // reference values
                num_failing_pixels += 1;
            } else {
                // pixel is near a line intersection; verify only coverage
                let reference_coverage = !is_black(ref_pixel);
                let screen_coverage = !is_black(screen_pixel);
                let is_ok_screen_coverage = pixel_neighborhood_contains_coverage(reference, x, y, screen_coverage);
                let is_ok_reference_coverage = pixel_neighborhood_contains_coverage(result, x, y, reference_coverage);

                if !(is_ok_screen_coverage && is_ok_reference_coverage) {
                    num_failing_pixels += 1;
                }
            }
        }
    }

    num_failing_pixels <= max_allowed_invalid_pixels
}

/// `colorsEqual`-shaped per-channel RGBA absolute-difference check, used by
/// `find_num_position_deviation_failing_pixels` - unlike `colors_equal` above this
/// also checks alpha (upstream's `UVec4`/`IVec4` threshold is always 4-wide there),
/// and the two are kept separate rather than unified since `colors_equal`'s 3-wide
/// `IVec3` threshold shape is what every *other* caller in this file already uses.
fn pixel_diff_within_threshold(a: RGBA, b: RGBA, threshold: [i32; 4]) -> bool {
    (a.get_red() - b.get_red()).abs() <= threshold[0]
        && (a.get_green() - b.get_green()).abs() <= threshold[1]
        && (a.get_blue() - b.get_blue()).abs() <= threshold[2]
        && (a.get_alpha() - b.get_alpha()).abs() <= threshold[3]
}

/// `findNumPositionDeviationFailingPixels` - see this module's own top doc comment for
/// why this takes `&Surface`/`RGBA` rather than `ConstPixelBufferAccess`/`getPixelInt`.
fn find_num_position_deviation_failing_pixels(
    reference: &Surface,
    result: &Surface,
    threshold: [i32; 4],
    max_position_deviation: IVec3,
    accept_out_of_bounds_as_any_value: bool,
) -> i32 {
    let width = reference.get_width();
    let height = reference.get_height();

    debug_assert_eq!(result.get_width(), width);
    debug_assert_eq!(result.get_height(), height);

    // Accept pixels "sampling" over the image bounds since "taps" could be anything
    let begin_x = if accept_out_of_bounds_as_any_value {
        max_position_deviation.x()
    } else {
        0
    };
    let begin_y = if accept_out_of_bounds_as_any_value {
        max_position_deviation.y()
    } else {
        0
    };
    let end_x = if accept_out_of_bounds_as_any_value {
        width - max_position_deviation.x()
    } else {
        width
    };
    let end_y = if accept_out_of_bounds_as_any_value {
        height - max_position_deviation.y()
    } else {
        height
    };
    debug_assert!(end_x > 0 && end_y > 0); // most likely a bug

    let mut num_failing_pixels = 0;

    for y in begin_y..end_y {
        for x in begin_x..end_x {
            let ref_pixel = reference.get_pixel(x, y);
            let cmp_pixel = result.get_pixel(x, y);

            // Exact match
            if pixel_diff_within_threshold(ref_pixel, cmp_pixel, threshold) {
                continue;
            }

            // Find deviated result pixel for reference
            let sy_range_ref =
                (y - max_position_deviation.y()).max(0)..=(y + max_position_deviation.y()).min(height - 1);
            let sx_range_ref =
                (x - max_position_deviation.x()).max(0)..=(x + max_position_deviation.x()).min(width - 1);
            let mut pixel_found_for_reference = false;
            'search_result: for sy in sy_range_ref {
                for sx in sx_range_ref.clone() {
                    let deviated_cmp_pixel = result.get_pixel(sx, sy);
                    if pixel_diff_within_threshold(ref_pixel, deviated_cmp_pixel, threshold) {
                        pixel_found_for_reference = true;
                        break 'search_result;
                    }
                }
            }
            if !pixel_found_for_reference {
                num_failing_pixels += 1;
                continue;
            }

            // Find deviated reference pixel for result
            let sy_range_res =
                (y - max_position_deviation.y()).max(0)..=(y + max_position_deviation.y()).min(height - 1);
            let sx_range_res =
                (x - max_position_deviation.x()).max(0)..=(x + max_position_deviation.x()).min(width - 1);
            let mut pixel_found_for_result = false;
            'search_ref: for sy in sy_range_res {
                for sx in sx_range_res.clone() {
                    let deviated_ref_pixel = reference.get_pixel(sx, sy);
                    if pixel_diff_within_threshold(cmp_pixel, deviated_ref_pixel, threshold) {
                        pixel_found_for_result = true;
                        break 'search_ref;
                    }
                }
            }
            if !pixel_found_for_result {
                num_failing_pixels += 1;
            }
        }
    }

    num_failing_pixels
}

/// `intThresholdPositionDeviationErrorThresholdCompare` - used for
/// `PRIMITIVECLASS_POINT`: points are extremely unlikely to overlap, so every pixel
/// must match within `threshold`, allowing only a small position deviation
/// (`max_position_deviation`, a 3x3 search kernel in `DrawTest::compare`'s own call)
/// rather than the coverage-relaxation the line/triangle comparisons use.
#[allow(clippy::too_many_arguments)]
pub fn int_threshold_position_deviation_error_threshold_compare(
    reference: &Surface,
    result: &Surface,
    threshold: [i32; 4],
    max_position_deviation: IVec3,
    accept_out_of_bounds_as_any_value: bool,
    max_allowed_failing_pixels: i32,
) -> bool {
    let num_failing_pixels = find_num_position_deviation_failing_pixels(
        reference,
        result,
        threshold,
        max_position_deviation,
        accept_out_of_bounds_as_any_value,
    );
    num_failing_pixels <= max_allowed_failing_pixels
}

/// `PrimitiveClass` (anonymous-namespace enum) - no `PRIMITIVECLASS_LAST` sentinel;
/// `Primitive::Last` itself already panics in `get_draw_primitive_class` below, the
/// same "no `_LAST` where nothing in this port constructs the unset state" rule
/// `spec.rs`'s own top doc comment already established for `Target`/
/// `CompatibilityTestType`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PrimitiveClass {
    Point,
    Line,
    Triangle,
}

/// `getDrawPrimitiveClass`
pub fn get_draw_primitive_class(primitive_type: Primitive) -> PrimitiveClass {
    match primitive_type {
        Primitive::Points => PrimitiveClass::Point,

        Primitive::Lines
        | Primitive::LineStrip
        | Primitive::LineLoop
        | Primitive::LinesAdjacency
        | Primitive::LineStripAdjacency => PrimitiveClass::Line,

        Primitive::Triangles
        | Primitive::TriangleFan
        | Primitive::TriangleStrip
        | Primitive::TrianglesAdjacency
        | Primitive::TriangleStripAdjacency => PrimitiveClass::Triangle,

        Primitive::Last => unreachable!("Primitive::Last has no draw primitive class"),
    }
}

/// `containsLineCases`
pub fn contains_line_cases(specs: &[DrawTestSpec]) -> bool {
    specs
        .iter()
        .any(|spec| get_draw_primitive_class(spec.primitive) == PrimitiveClass::Line)
}

/// `DrawTest::getCoordScale` - the uniform scale `DrawTestShaderProgram` applies to
/// every position attribute so the whole primitive stays within the `[-1, 1]` clip
/// range regardless of how extreme the generated attribute values are (see
/// `shader_program.rs`'s own `calc_shader_color_coord`, the function this value feeds
/// as `u_coordScale`).
pub fn get_coord_scale(spec: &DrawTestSpec) -> f32 {
    let mut max_value = 1.0f32;

    for (array_ndx, attrib_spec) in spec.attribs.iter().enumerate() {
        let is_position_attr = array_ndx == 0 || attrib_spec.additional_position_attribute;
        if !is_position_attr {
            continue;
        }

        let mut attr_max_value = 0.0f32;

        if attrib_spec.input_type == InputType::UnsignedInt2_10_10_10 {
            attr_max_value += if attrib_spec.normalize { 1.0 } else { 1024.0 };
        } else if attrib_spec.input_type == InputType::Int2_10_10_10 {
            attr_max_value += if attrib_spec.normalize { 1.0 } else { 512.0 };
        } else {
            let max = GLValue::max_value(attrib_spec.input_type).to_float();
            attr_max_value += if attrib_spec.normalize && !attrib_spec.input_type.is_float_type() {
                1.0
            } else {
                max * 1.1
            };
        }

        if matches!(
            attrib_spec.output_type,
            OutputType::Vec3
                | OutputType::Vec4
                | OutputType::IVec3
                | OutputType::IVec4
                | OutputType::UVec3
                | OutputType::UVec4
        ) {
            attr_max_value *= 2.0;
        }

        max_value += attr_max_value;
    }

    1.0 / max_value
}

/// `DrawTest::getColorScale` - the complementary uniform scale for every non-position
/// attribute, fed as `u_colorScale`.
pub fn get_color_scale(spec: &DrawTestSpec) -> f32 {
    let mut color_scale = 1.0f32;

    // upstream's own loop starts at arrayNdx = 1 (attribute 0 is always positional);
    // `.enumerate().skip(1)` mirrors that directly, so `array_ndx == 0` below can never
    // hold - kept anyway for a literal match with upstream's own `isPositionAttr`
    // condition, computed identically everywhere else in this file.
    for (array_ndx, attrib_spec) in spec.attribs.iter().enumerate().skip(1) {
        let is_position_attr = array_ndx == 0 || attrib_spec.additional_position_attribute;
        if is_position_attr {
            continue;
        }

        if attrib_spec.input_type == InputType::UnsignedInt2_10_10_10 {
            if !attrib_spec.normalize {
                color_scale *= 1.0 / 1024.0;
            }
        } else if attrib_spec.input_type == InputType::Int2_10_10_10 {
            if !attrib_spec.normalize {
                color_scale *= 1.0 / 512.0;
            }
        } else {
            let max = GLValue::max_value(attrib_spec.input_type).to_float();
            let factor = if attrib_spec.normalize && !attrib_spec.input_type.is_float_type() {
                1.0
            } else {
                (1.0 / f64::from(max)) as f32
            };

            color_scale *= factor;

            if matches!(
                attrib_spec.output_type,
                OutputType::Vec4 | OutputType::UVec4 | OutputType::IVec4
            ) {
                color_scale *= factor;
            }
        }
    }

    color_scale
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::gls::draw_test::spec::{AttributeSpec, Storage, Usage};
    use crate::glu::render_context::ApiType;

    fn thr(v: i32) -> IVec3 {
        IVec3::from_array([v, v, v])
    }

    #[test]
    fn is_black_ignores_alpha() {
        assert!(is_black(RGBA::new(0, 0, 0, 0)));
        assert!(is_black(RGBA::new(0, 0, 0, 255))); // alpha ignored
        assert!(!is_black(RGBA::new(1, 0, 0, 0)));
    }

    #[test]
    fn edge_triplet_component_flags_a_sharp_ramp_change() {
        // d1 = 10-0 = 10, d2 = 10-10 = 0, rampDiff = |0-10| = 10 > 2*0
        assert!(is_edge_triplet_component(0, 10, 10, 0));
        // constant ramp: d1 = d2 = 5, rampDiff = 0, never > 0
        assert!(!is_edge_triplet_component(0, 5, 10, 0));
        // rounding difference absorbs a small deviation
        assert!(!is_edge_triplet_component(0, 10, 10, 10)); // rampDiff=10, 2*10=20
    }

    #[test]
    fn is_edge_triplet_black_to_nonblack_is_always_an_edge() {
        let black = RGBA::black();
        let red = RGBA::new(200, 0, 0, 255);
        assert!(is_edge_triplet(black, black, red, thr(0)));
    }

    #[test]
    fn is_edge_triplet_all_black_is_not_an_edge() {
        let black = RGBA::black();
        assert!(!is_edge_triplet(black, black, black, thr(0)));
    }

    #[test]
    fn is_edge_triplet_constant_coverage_ramp_is_not_an_edge() {
        // red channel 50,60,70: d1=10, d2=10, rampDiff=0 -> not an edge on any channel.
        // None of the three may be pure black (0,0,0) - that would trip the
        // `is_black`-vs-non-black "always an edge" rule above before the ramp check is
        // ever reached, which is a different code path than this test means to exercise.
        let c1 = RGBA::new(50, 0, 0, 255);
        let c2 = RGBA::new(60, 0, 0, 255);
        let c3 = RGBA::new(70, 0, 0, 255);
        assert!(!is_edge_triplet(c1, c2, c3, thr(0)));
    }

    #[test]
    fn colors_equal_respects_threshold() {
        let a = RGBA::new(100, 100, 100, 255);
        let b = RGBA::new(102, 98, 100, 0); // alpha ignored by `colors_equal`
        assert!(colors_equal(a, b, thr(2)));
        assert!(!colors_equal(a, b, thr(1)));
    }

    #[test]
    fn pixel_diff_within_threshold_checks_alpha_too() {
        let a = RGBA::new(0, 0, 0, 0);
        let b = RGBA::new(0, 0, 0, 5);
        assert!(pixel_diff_within_threshold(a, b, [0, 0, 0, 5]));
        assert!(!pixel_diff_within_threshold(a, b, [0, 0, 0, 4]));
    }

    /// Builds a 4x4 all-black surface with a single non-black pixel at (2, 2).
    fn single_lit_pixel_surface(color: RGBA) -> Surface {
        let mut s = Surface::new(4, 4);
        for y in 0..4 {
            for x in 0..4 {
                s.set_pixel(x, y, RGBA::black());
            }
        }
        s.set_pixel(2, 2, color);
        s
    }

    #[test]
    fn pixel_neighborhood_contains_color_finds_a_one_pixel_shift() {
        let s = single_lit_pixel_surface(RGBA::new(200, 0, 0, 255));
        // (1,1) itself is black, but (2,2) is in its 3x3 neighborhood
        assert!(pixel_neighborhood_contains_color(
            &s,
            1,
            1,
            RGBA::new(200, 0, 0, 255),
            thr(0)
        ));
        // not present anywhere near (0,0)'s neighborhood (clamped by caller's own
        // precondition in real use, but the loop itself is still in-bounds here)
        assert!(!pixel_neighborhood_contains_color(
            &s,
            1,
            1,
            RGBA::new(0, 200, 0, 255),
            thr(0)
        ));
    }

    #[test]
    fn pixel_neighborhood_contains_coverage_matches_black_vs_nonblack() {
        let s = single_lit_pixel_surface(RGBA::new(200, 0, 0, 255));
        assert!(pixel_neighborhood_contains_coverage(&s, 1, 1, true)); // (2,2) has coverage
        assert!(pixel_neighborhood_contains_coverage(&s, 1, 1, false)); // (1,1) itself has none
    }

    #[test]
    fn edge_relaxed_image_compare_identical_images_pass_with_zero_tolerance() {
        let s = single_lit_pixel_surface(RGBA::new(200, 0, 0, 255));
        assert!(edge_relaxed_image_compare(&s, &s, thr(0), thr(0), 0));
    }

    #[test]
    fn edge_relaxed_image_compare_one_pixel_shift_is_tolerated_as_an_edge() {
        // reference has the lit pixel at (2,2); result has it one pixel over at (1,2) -
        // both count as "near the edge" of coverage, so coverage-only comparison
        // passes with zero allowed hard failures.
        let reference = single_lit_pixel_surface(RGBA::new(200, 0, 0, 255));
        let mut result = Surface::new(4, 4);
        for y in 0..4 {
            for x in 0..4 {
                result.set_pixel(x, y, RGBA::black());
            }
        }
        result.set_pixel(1, 2, RGBA::new(200, 0, 0, 255));
        // Every one of the 4 interior pixels checked ((1,1),(1,2),(2,1),(2,2)) passes
        // via the direct "does the other image have a matching pixel somewhere in my
        // 3x3 neighborhood" check (`pixel_neighborhood_contains_color`) before the
        // edge-relaxation path is ever reached: e.g. at (2,2) the reference is red and
        // the result is black, but the result's own neighborhood of (2,2) does include
        // the shifted red pixel at (1,2), and the reference's neighborhood of (2,2)
        // does include its own black (1,1). So this never even exercises
        // `pixel_near_edge` - it demonstrates the 1-pixel search radius alone is enough
        // to tolerate the shift, which is the simpler and more fundamental property.
        assert!(edge_relaxed_image_compare(&reference, &result, thr(0), thr(0), 0));
    }

    #[test]
    fn intersection_relaxed_line_image_compare_identical_images_pass() {
        let s = single_lit_pixel_surface(RGBA::new(0, 200, 0, 255));
        assert!(intersection_relaxed_line_image_compare(&s, &s, thr(0), 0));
    }

    #[test]
    fn int_threshold_position_deviation_compare_allows_small_shift() {
        let reference = single_lit_pixel_surface(RGBA::new(0, 0, 200, 255));
        let mut result = Surface::new(4, 4);
        for y in 0..4 {
            for x in 0..4 {
                result.set_pixel(x, y, RGBA::black());
            }
        }
        result.set_pixel(1, 2, RGBA::new(0, 0, 200, 255)); // one pixel left of (2,2)

        // 3x3 search kernel (deviation 1,1,0), zero color threshold, zero allowed
        // hard failures - the shifted pixel must be found within the search window.
        assert!(int_threshold_position_deviation_error_threshold_compare(
            &reference,
            &result,
            [0, 0, 0, 256],
            IVec3::from_array([1, 1, 0]),
            true,
            0,
        ));
    }

    #[test]
    fn int_threshold_position_deviation_compare_rejects_too_far_a_shift() {
        let reference = single_lit_pixel_surface(RGBA::new(0, 0, 200, 255));
        let mut result = Surface::new(4, 4);
        for y in 0..4 {
            for x in 0..4 {
                result.set_pixel(x, y, RGBA::black());
            }
        }
        // (2,2) in reference has no match anywhere in `result` within a 0-radius
        // search, and `result`'s own all-black (0,0) etc. likewise finds no reference
        // match for a radius-0 search around its own position.
        assert!(!int_threshold_position_deviation_error_threshold_compare(
            &reference,
            &result,
            [0, 0, 0, 256],
            IVec3::from_array([0, 0, 0]),
            false,
            0,
        ));
    }

    #[test]
    fn get_draw_primitive_class_covers_every_primitive() {
        assert_eq!(get_draw_primitive_class(Primitive::Points), PrimitiveClass::Point);
        assert_eq!(get_draw_primitive_class(Primitive::Lines), PrimitiveClass::Line);
        assert_eq!(get_draw_primitive_class(Primitive::LineStrip), PrimitiveClass::Line);
        assert_eq!(get_draw_primitive_class(Primitive::LineLoop), PrimitiveClass::Line);
        assert_eq!(
            get_draw_primitive_class(Primitive::LinesAdjacency),
            PrimitiveClass::Line
        );
        assert_eq!(
            get_draw_primitive_class(Primitive::LineStripAdjacency),
            PrimitiveClass::Line
        );
        assert_eq!(get_draw_primitive_class(Primitive::Triangles), PrimitiveClass::Triangle);
        assert_eq!(
            get_draw_primitive_class(Primitive::TriangleFan),
            PrimitiveClass::Triangle
        );
        assert_eq!(
            get_draw_primitive_class(Primitive::TriangleStrip),
            PrimitiveClass::Triangle
        );
        assert_eq!(
            get_draw_primitive_class(Primitive::TrianglesAdjacency),
            PrimitiveClass::Triangle
        );
        assert_eq!(
            get_draw_primitive_class(Primitive::TriangleStripAdjacency),
            PrimitiveClass::Triangle
        );
    }

    #[test]
    #[should_panic(expected = "Primitive::Last has no draw primitive class")]
    fn get_draw_primitive_class_panics_on_last() {
        get_draw_primitive_class(Primitive::Last);
    }

    fn es2() -> DrawTestSpec {
        DrawTestSpec::new(ApiType::es(2, 0))
    }

    #[test]
    fn contains_line_cases_true_false() {
        let mut points_only = es2();
        points_only.primitive = Primitive::Points;
        assert!(!contains_line_cases(&[points_only]));

        let mut with_lines = es2();
        with_lines.primitive = Primitive::Points;
        let mut lines = es2();
        lines.primitive = Primitive::LineStrip;
        assert!(contains_line_cases(&[with_lines, lines]));
    }

    fn position_attr(input_type: InputType, output_type: OutputType, normalize: bool) -> AttributeSpec {
        AttributeSpec::create_attribute_array(
            input_type,
            output_type,
            Storage::Buffer,
            Usage::StaticDraw,
            0,
            0,
            0,
            normalize,
            0,
        )
    }

    #[test]
    fn get_coord_scale_single_unnormalized_float_position() {
        // one attrib (index 0 => always positional), Float/Vec2 (no *2 doubling),
        // unnormalized: attrMaxValue = GLValue::max_value(Float).toFloat() * 1.1
        let mut spec = es2();
        spec.attribs
            .push(position_attr(InputType::Float, OutputType::Vec2, false));
        let max = GLValue::max_value(InputType::Float).to_float();
        let expected = 1.0 / (1.0 + max * 1.1);
        assert!((get_coord_scale(&spec) - expected).abs() < 1e-6);
    }

    #[test]
    fn get_coord_scale_doubles_for_vec3_and_vec4_outputs() {
        let mut spec = es2();
        spec.attribs
            .push(position_attr(InputType::Float, OutputType::Vec3, false));
        let max = GLValue::max_value(InputType::Float).to_float();
        let expected = 1.0 / (1.0 + max * 1.1 * 2.0);
        assert!((get_coord_scale(&spec) - expected).abs() < 1e-6);
    }

    #[test]
    fn get_coord_scale_normalized_non_float_input_caps_at_one() {
        let mut spec = es2();
        spec.attribs
            .push(position_attr(InputType::UnsignedByte, OutputType::Vec2, true));
        // normalized && !is_float_type -> attrMaxValue = 1.0, not max*1.1
        let expected = 1.0 / (1.0 + 1.0);
        assert!((get_coord_scale(&spec) - expected).abs() < 1e-6);
    }

    #[test]
    fn get_coord_scale_packed_2_10_10_10_unnormalized() {
        let mut spec = es2();
        spec.attribs
            .push(position_attr(InputType::UnsignedInt2_10_10_10, OutputType::Vec4, false));
        // unnormalized packed uint -> attrMaxValue = 1024, then doubled for Vec4
        let expected = 1.0 / (1.0 + 1024.0 * 2.0);
        assert!((get_coord_scale(&spec) - expected).abs() < 1e-6);
    }

    #[test]
    fn get_color_scale_skips_the_position_attribute() {
        // only one attrib (index 0, always positional) => loop body never runs,
        // colorScale stays 1.0 regardless of its own input type.
        let mut spec = es2();
        spec.attribs
            .push(position_attr(InputType::UnsignedByte, OutputType::Vec2, false));
        assert_eq!(get_color_scale(&spec), 1.0);
    }

    #[test]
    fn get_color_scale_scales_by_input_max_for_a_color_attribute() {
        let mut spec = es2();
        spec.attribs
            .push(position_attr(InputType::Float, OutputType::Vec2, false)); // index 0: position
        // index 1: color, Vec3 output (no second `*= factor` application)
        spec.attribs
            .push(position_attr(InputType::UnsignedByte, OutputType::Vec3, false));
        let max = GLValue::max_value(InputType::UnsignedByte).to_float();
        let expected = (1.0 / f64::from(max)) as f32;
        assert!((get_color_scale(&spec) - expected).abs() < 1e-6);
    }

    #[test]
    fn get_color_scale_applies_factor_twice_for_vec4_output() {
        let mut spec = es2();
        spec.attribs
            .push(position_attr(InputType::Float, OutputType::Vec2, false));
        spec.attribs
            .push(position_attr(InputType::UnsignedByte, OutputType::Vec4, false));
        let max = GLValue::max_value(InputType::UnsignedByte).to_float();
        let factor = (1.0 / f64::from(max)) as f32;
        let expected = factor * factor;
        assert!((get_color_scale(&spec) - expected).abs() < 1e-6);
    }
}

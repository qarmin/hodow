// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexCompareVerifier.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Distinct from `tcu::pixel`'s `sample_2d_compare`/`sample_2d_mipmap_compare`: those
// *produce* a shadow-sample value for a reference image (the renderer's own job), this
// *verifies* a driver's own returned compare result could be a conformant answer for
// the coordinate's uncertainty window - the same "lookup, don't reproduce" relationship
// `tcu::tex_verifier`'s lookup-verification functions have to ordinary (non-shadow)
// texture sampling, and this file follows that one's established shape closely
// (`TexComparePrecision` mirrors `LookupPrecision`, `is_linear_compare_valid` mirrors
// `is_linear_range_valid`, the NEAREST/LINEAR/mipmap dispatch ladder is the same one
// `is_lookup_result_valid_2d` already climbs).
//
// Ported so far: the full `Texture2DView` overload of `isTexCompareResultValid`
// (`is_tex_compare_result_valid_2d` below) - NEAREST, LINEAR, `*_MIPMAP_NEAREST` and
// `*_MIPMAP_LINEAR`, every one of them PCF-aware (`TexComparePrecision::pcf_bits > 0`
// widens the valid range the way a real PCF-filtering driver's extra taps would) - and
// the `Texture2DArrayView` overload (`is_tex_compare_result_valid_2d_array`), an outer
// layer loop around the identical per-level logic, same relationship
// `is_lookup_result_valid_2d_array` already has to `is_lookup_result_valid_2d`.
// **Its own layer-range formula is deliberately not shared with `tex_verifier::
// compute_layer_range`** - read straight out of upstream's `isTexCompareResultValid
// (Texture2DArrayView, ...)` rather than assumed from the lookup-verifier sibling, the
// two turned out to use genuinely different formulas for `maxLayer` (`floor(z+err+0.5)`
// here vs. `ceil(z+err+0.5)-1` there - identical for a non-integer boundary, one step
// apart exactly on an integer one). Upstream's own inconsistency, ported faithfully
// rather than unified.
//
// `isGatherOffsetsCompareResultValid` is ported too, for both `Texture2DView` and
// `Texture2DArrayView` - textureGather always samples the base level only (no mipmap
// axis at all), so the 2D-array overload is only a layer loop, no level-selection ladder
// the ordinary lookup needs. This is what `texture.gather`'s shadow-gather subgroup
// needs for its 2D/2D-array cases.
//
// **`TextureCubeView` is ported too now** - `isTexCompareResultValid`
// (`is_tex_compare_result_valid_cube`) and `isGatherCompareResultValid`
// (`is_gather_compare_result_valid_cube`). The `LINEAR`-filter paths of both now also
// cover `Sampler::seamless_cube_map = false` (see `is_cube_level_compare_result_valid`'s
// own doc comment) - added alongside the identical addition to `tex_verifier::
// is_lookup_result_valid_cube`, once that field actually existed on `Sampler`. Reuses
// `tex_verifier`'s already-ported cube-seam machinery directly (`get_possible_cube_faces`/
// `CubeFaceFloatCoords`, both widened to `pub(crate)` for this), plus `tcu::pixel`'s
// `project_to_face`/`remap_cube_edge_coords`/`get_cube_face_slot`/`get_cube_array_face_index`.
// Cube gather has no caller-supplied offsets at all (no `textureGatherOffset` for cube
// samplers in GLES) - always the same fixed `(0,1),(1,1),(1,0),(0,0)` footprint upstream
// hardcodes. This closes `texture.gather`'s and `texture.border_clamp`'s remaining
// cube-shadow subgroups.
//
// NOT ported: `Texture1DView`/`Texture1DArrayView`/`TextureCubeArrayView` overloads - no
// GLES2/3/31 texture target needs the first two, and the array-of-cubes one is an AEP
// extension, not attempted.
//
// `lookupDepth`'s border-sampling branch (`sampleTextureBorder<float>` when a coordinate
// lands outside the level after wrapping) is now reachable: `WrapMode::ClampToBorder` is
// ported in `tcu::tex_verifier` (see that type's own doc comment), and `wrap()` - shared
// directly from there via the `use` below, not duplicated - gives it the `-1`/`size`
// sentinel values `lookup_depth`'s own `coords_in_bounds` check keys off to decide
// "texel" vs. "border colour". The actual border value comes from
// `TexComparePrecision::border_color` rather than a `Sampler` field, matching
// `tcu::tex_verifier::LookupPrecision::border_color`'s own reasoning (this port's
// `Sampler` carries no `borderColor` of its own). Cube sampling never reaches this at
// all - see `is_cube_level_compare_result_valid`'s own doc comment, same reasoning as
// `tcu::tex_verifier`'s cube paths.
//
// `is_fixed_point_depth_texture_format` is **not** re-ported here - `tcu::pixel` already
// has one (`pixel::is_fixed_point_depth_texture_format`), built for `sample_2d_compare`'s
// own needs, and this file reuses it directly rather than duplicating the channel-class
// dispatch. Its own doc comment already notes the same narrowing upstream's verifier
// documents inline (combined depth/stencil formats fall back to "not fixed-point" rather
// than the format-specific answer upstream's `isFixedPointDepthTextureFormat` gives,
// since no depth/stencil-format shadow sampler is wired up anywhere in this crate yet) -
// extend both together if that ever changes.

use super::pixel::{
    CompareMode, ConstPixelBufferAccess, CubeFace, FilterMode, Sampler, get_cube_array_face_index, get_cube_face_slot,
    is_fixed_point_depth_texture_format, project_to_face, remap_cube_edge_coords,
};
use super::tex_verifier::{
    CubeFaceFloatCoords, MinFilterMode, WrapMode, compute_fixed_point_error, compute_floating_point_error,
    compute_non_normalized_coord_bounds, get_possible_cube_faces, wrap,
};

/// `tcu::TexComparePrecision`
pub struct TexComparePrecision {
    pub coord_bits: [i32; 3],
    pub uvw_bits: [i32; 3],
    /// Number of accurate bits in PCF - extra error a real PCF-filtering driver's
    /// additional taps are allowed to introduce. `0` means no PCF widening at all.
    pub pcf_bits: i32,
    pub reference_bits: i32,
    pub result_bits: i32,
    /// `Sampler::borderColor.x()`, already resolved to whatever the GL sampler under
    /// test actually set `GL_TEXTURE_BORDER_COLOR` to - read only by `lookup_depth`
    /// when `wrap_s`/`wrap_t` is `WrapMode::ClampToBorder` and a coordinate lands
    /// outside the level (see that function's own doc comment). This port's `Sampler`
    /// carries no `borderColor` field of its own, so, exactly like `tcu::tex_verifier::
    /// LookupPrecision::border_color`, the caller supplies it directly instead of this
    /// file reading it off a `Sampler`. Defaults to `0.0`, the GL/GLES spec default for
    /// `GL_TEXTURE_BORDER_COLOR`'s first component.
    pub border_color: f32,
}

impl Default for TexComparePrecision {
    fn default() -> Self {
        Self {
            coord_bits: [22; 3],
            uvw_bits: [16; 3],
            pcf_bits: 16,
            reference_bits: 16,
            result_bits: 16,
            border_color: 0.0,
        }
    }
}

/// `CmpResultSet` - which of `true`/`false` a single depth tap's compare result could
/// legally be, given the reference value's own uncertainty window.
#[derive(Clone, Copy)]
struct CmpResultSet {
    is_true: bool,
    is_false: bool,
}

/// `execCompare` (the verifier's own overload, distinct from `pixel::exec_compare` -
/// that one computes *the* compare result for a known-exact reference; this one
/// computes *which outcomes are possible* for a reference known only to within
/// `computeFixedPointError(reference_bits)`).
fn exec_compare(
    compare_mode: CompareMode,
    cmp_value_: f32,
    cmp_reference_: f32,
    reference_bits: i32,
    is_fixed_point: bool,
) -> CmpResultSet {
    let clamp_values = is_fixed_point;
    let cmp_value = if clamp_values {
        cmp_value_.clamp(0.0, 1.0)
    } else {
        cmp_value_
    };
    let cmp_reference = if clamp_values {
        cmp_reference_.clamp(0.0, 1.0)
    } else {
        cmp_reference_
    };
    let err = compute_fixed_point_error(reference_bits);

    match compare_mode {
        CompareMode::Less => CmpResultSet {
            is_true: cmp_reference - err < cmp_value,
            is_false: cmp_reference + err >= cmp_value,
        },
        CompareMode::LessOrEqual => CmpResultSet {
            is_true: cmp_reference - err <= cmp_value,
            is_false: cmp_reference + err > cmp_value,
        },
        CompareMode::Greater => CmpResultSet {
            is_true: cmp_reference + err > cmp_value,
            is_false: cmp_reference - err <= cmp_value,
        },
        CompareMode::GreaterOrEqual => CmpResultSet {
            is_true: cmp_reference + err >= cmp_value,
            is_false: cmp_reference - err < cmp_value,
        },
        CompareMode::Equal => CmpResultSet {
            is_true: (cmp_reference - err..=cmp_reference + err).contains(&cmp_value),
            is_false: err != 0.0 || cmp_value != cmp_reference,
        },
        CompareMode::NotEqual => CmpResultSet {
            is_true: err != 0.0 || cmp_value != cmp_reference,
            is_false: (cmp_reference - err..=cmp_reference + err).contains(&cmp_value),
        },
        CompareMode::Always => CmpResultSet {
            is_true: true,
            is_false: false,
        },
        CompareMode::Never => CmpResultSet {
            is_true: false,
            is_false: true,
        },
        CompareMode::None => unreachable!("isSamplerSupported requires compare != COMPAREMODE_NONE"),
    }
}

/// `isResultInSet`
fn is_result_in_set(result_set: CmpResultSet, result: f32, result_bits: i32) -> bool {
    let err = compute_fixed_point_error(result_bits);
    let (min_r, max_r) = (result - err, result + err);
    (result_set.is_true && (min_r..=max_r).contains(&1.0)) || (result_set.is_false && (min_r..=max_r).contains(&0.0))
}

fn coords_in_bounds(access: &ConstPixelBufferAccess<'_>, x: i32, y: i32, z: i32) -> bool {
    let [w, h, d] = access.size();
    (0..w as i32).contains(&x) && (0..h as i32).contains(&y) && (0..d as i32).contains(&z)
}

/// `lookupDepthNoBorder` - `x`/`y`/`z` are guaranteed in-bounds by the caller (every
/// caller in this file passes already-`wrap()`ped coordinates).
fn lookup_depth_no_border(access: &ConstPixelBufferAccess<'_>, i: i32, j: i32, k: i32) -> f32 {
    debug_assert!(coords_in_bounds(access, i, j, k));
    use super::texture::ChannelOrder;
    if access.format().order == ChannelOrder::R {
        access.get_pixel(i as u32, j as u32, k as u32)[0]
    } else {
        access.get_pix_depth(i as u32, j as u32, k as u32)
    }
}

/// `lookupDepth` - the border-sampling branch (`coords_in_bounds` false, which only
/// happens for `WrapMode::ClampToBorder` - see this module's top doc comment) reads
/// `border_color` instead of fetching a texel: clamped to `[0,1]` for a fixed-point
/// depth format and left untouched for a floating-point one, matching upstream's
/// `getTextureBorderColorFloat`'s own per-channel-class branch. No swizzle logic is
/// needed to get there: every depth format this module reaches is `ChannelOrder::D` or
/// `R`, and upstream's own `getBorderColorReadSwizzle` table maps both straight through
/// to the border colour's channel 0 with no swizzle at all - confirmed by reading that
/// table directly rather than assumed.
fn lookup_depth(access: &ConstPixelBufferAccess<'_>, i: i32, j: i32, k: i32, border_color: f32) -> f32 {
    if coords_in_bounds(access, i, j, k) {
        lookup_depth_no_border(access, i, j, k)
    } else if is_fixed_point_depth_texture_format(access.format()) {
        border_color.clamp(0.0, 1.0)
    } else {
        border_color
    }
}

/// Values are in order `(0,0)`, `(1,0)`, `(0,1)`, `(1,1)`.
fn bilinear_interpolate(values: [f32; 4], x: f32, y: f32) -> f32 {
    let [v00, v10, v01, v11] = values;
    v00 * (1.0 - x) * (1.0 - y) + v10 * x * (1.0 - y) + v01 * (1.0 - x) * y + v11 * x * y
}

/// `isLinearCompareValid` - the shadow counterpart of `is_linear_range_valid`: instead
/// of a line segment between two known colours, each of the two endpoints is itself a
/// *set* of possible compare outcomes (`exec_compare`'s `CmpResultSet`), so every
/// combination of "endpoint 0 true/false" x "endpoint 1 true/false" that the reference's
/// own uncertainty window allows has to be tried as its own line segment.
#[allow(clippy::too_many_arguments)]
fn is_linear_compare_valid(
    compare_mode: CompareMode,
    prec: &TexComparePrecision,
    depths: [f32; 2],
    f_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
    is_fixed_point_depth: bool,
) -> bool {
    debug_assert!(0.0 <= f_bounds[0] && f_bounds[0] <= f_bounds[1] && f_bounds[1] <= 1.0);

    let cmp0 = exec_compare(
        compare_mode,
        depths[0],
        cmp_reference,
        prec.reference_bits,
        is_fixed_point_depth,
    );
    let cmp1 = exec_compare(
        compare_mode,
        depths[1],
        cmp_reference,
        prec.reference_bits,
        is_fixed_point_depth,
    );

    let (f0, f1) = (f_bounds[0], f_bounds[1]);
    let pcf_err = compute_fixed_point_error(prec.pcf_bits);
    let res_err = compute_fixed_point_error(prec.result_bits);
    let total_err = pcf_err + res_err;

    for comb in 0u32..(1 << 2) {
        let cmp0_true = (comb & 1) != 0;
        let cmp1_true = (comb & 2) != 0;
        if (cmp0_true && !cmp0.is_true) || (!cmp0_true && !cmp0.is_false) {
            continue;
        }
        if (cmp1_true && !cmp1.is_true) || (!cmp1_true && !cmp1.is_false) {
            continue;
        }

        let ref0 = if cmp0_true { 1.0 } else { 0.0 };
        let ref1 = if cmp1_true { 1.0 } else { 0.0 };
        let v0 = ref0 * (1.0 - f0) + ref1 * f0;
        let v1 = ref0 * (1.0 - f1) + ref1 * f1;
        let (min_v, max_v) = (v0.min(v1), v0.max(v1));
        let (min_r, max_r) = (min_v - total_err, max_v + total_err);

        if (min_r..=max_r).contains(&result) {
            return true;
        }
    }
    false
}

/// `isBilinearAnyCompareValid` - no PCF: all that matters is whether *any* of the four
/// taps could be true (makes `1.0` reachable) and whether any could be false (makes
/// `0.0` reachable), since with no PCF a driver may return either corner's own exact
/// result unweighted.
fn is_bilinear_any_compare_valid(
    compare_mode: CompareMode,
    prec: &TexComparePrecision,
    depths: [f32; 4],
    cmp_reference: f32,
    result: f32,
    is_fixed_point_depth: bool,
) -> bool {
    debug_assert_eq!(prec.pcf_bits, 0);
    let cmps = depths.map(|d| {
        exec_compare(
            compare_mode,
            d,
            cmp_reference,
            prec.reference_bits,
            is_fixed_point_depth,
        )
    });
    let can_be_true = cmps.iter().any(|c| c.is_true);
    let can_be_false = cmps.iter().any(|c| c.is_false);
    let res_err = compute_fixed_point_error(prec.result_bits);
    let min_bound = if can_be_false { 0.0 } else { 1.0 };
    let max_bound = if can_be_true { 1.0 } else { 0.0 };
    (min_bound - res_err..=max_bound + res_err).contains(&result)
}

/// `isBilinearPCFCompareValid` - with PCF active, every one of the 16 true/false
/// combinations the four taps' own uncertainty windows allow is tried as its own
/// bilinear-interpolated value, same two-level search shape `is_linear_compare_valid`
/// uses for two taps.
#[allow(clippy::too_many_arguments)]
fn is_bilinear_pcf_compare_valid(
    compare_mode: CompareMode,
    prec: &TexComparePrecision,
    depths: [f32; 4],
    x_bounds: [f32; 2],
    y_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
    is_fixed_point_depth: bool,
) -> bool {
    debug_assert!(0.0 <= x_bounds[0] && x_bounds[0] <= x_bounds[1] && x_bounds[1] <= 1.0);
    debug_assert!(0.0 <= y_bounds[0] && y_bounds[0] <= y_bounds[1] && y_bounds[1] <= 1.0);
    debug_assert!(prec.pcf_bits > 0);

    let cmps = depths.map(|d| {
        exec_compare(
            compare_mode,
            d,
            cmp_reference,
            prec.reference_bits,
            is_fixed_point_depth,
        )
    });
    let (x0, x1) = (x_bounds[0], x_bounds[1]);
    let (y0, y1) = (y_bounds[0], y_bounds[1]);
    let pcf_err = compute_fixed_point_error(prec.pcf_bits);
    let res_err = compute_fixed_point_error(prec.result_bits);
    let total_err = pcf_err + res_err;

    for comb in 0u32..(1 << 4) {
        if (0..4).any(|i| {
            let bit_true = (comb >> i) & 1 != 0;
            (bit_true && !cmps[i].is_true) || (!bit_true && !cmps[i].is_false)
        }) {
            continue;
        }

        let ref_val: [f32; 4] = std::array::from_fn(|i| if (comb >> i) & 1 != 0 { 1.0 } else { 0.0 });
        let v0 = bilinear_interpolate(ref_val, x0, y0);
        let v1 = bilinear_interpolate(ref_val, x1, y0);
        let v2 = bilinear_interpolate(ref_val, x0, y1);
        let v3 = bilinear_interpolate(ref_val, x1, y1);
        let min_v = v0.min(v1).min(v2).min(v3);
        let max_v = v0.max(v1).max(v2).max(v3);
        let (min_r, max_r) = (min_v - total_err, max_v + total_err);

        if (min_r..=max_r).contains(&result) {
            return true;
        }
    }
    false
}

/// `isBilinearCompareValid`
#[allow(clippy::too_many_arguments)]
fn is_bilinear_compare_valid(
    compare_mode: CompareMode,
    prec: &TexComparePrecision,
    depths: [f32; 4],
    x_bounds: [f32; 2],
    y_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
    is_fixed_point_depth: bool,
) -> bool {
    if prec.pcf_bits > 0 {
        is_bilinear_pcf_compare_valid(
            compare_mode,
            prec,
            depths,
            x_bounds,
            y_bounds,
            cmp_reference,
            result,
            is_fixed_point_depth,
        )
    } else {
        is_bilinear_any_compare_valid(compare_mode, prec, depths, cmp_reference, result, is_fixed_point_depth)
    }
}

/// `isTrilinearAnyCompareValid` - the no-PCF cross-mip-level sibling of
/// `is_bilinear_any_compare_valid`: a driver may pick any of the 8 taps across both
/// levels unweighted.
fn is_trilinear_any_compare_valid(
    compare_mode: CompareMode,
    prec: &TexComparePrecision,
    depths0: [f32; 4],
    depths1: [f32; 4],
    cmp_reference: f32,
    result: f32,
    is_fixed_point_depth: bool,
) -> bool {
    debug_assert_eq!(prec.pcf_bits, 0);
    let cmp = |d: f32| {
        exec_compare(
            compare_mode,
            d,
            cmp_reference,
            prec.reference_bits,
            is_fixed_point_depth,
        )
    };
    let cmps0 = depths0.map(cmp);
    let cmps1 = depths1.map(cmp);
    let can_be_true = cmps0.iter().chain(cmps1.iter()).any(|c| c.is_true);
    let can_be_false = cmps0.iter().chain(cmps1.iter()).any(|c| c.is_false);
    let res_err = compute_fixed_point_error(prec.result_bits);
    let min_bound = if can_be_false { 0.0 } else { 1.0 };
    let max_bound = if can_be_true { 1.0 } else { 0.0 };
    (min_bound - res_err..=max_bound + res_err).contains(&result)
}

/// `isTrilinearPCFCompareValid` - `is_bilinear_pcf_compare_valid` widened to 8 taps (4
/// per level) and an outer blend across the two levels' own bilinear ranges by
/// `f_bounds`, min-to-min and max-to-max (a driver may pick the extreme of either
/// level's own range at either end of the mip blend).
#[allow(clippy::too_many_arguments)]
fn is_trilinear_pcf_compare_valid(
    compare_mode: CompareMode,
    prec: &TexComparePrecision,
    depths0: [f32; 4],
    depths1: [f32; 4],
    x_bounds0: [f32; 2],
    y_bounds0: [f32; 2],
    x_bounds1: [f32; 2],
    y_bounds1: [f32; 2],
    f_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
    is_fixed_point_depth: bool,
) -> bool {
    debug_assert!(prec.pcf_bits > 0);
    let cmp = |d: f32| {
        exec_compare(
            compare_mode,
            d,
            cmp_reference,
            prec.reference_bits,
            is_fixed_point_depth,
        )
    };
    let cmps0 = depths0.map(cmp);
    let cmps1 = depths1.map(cmp);

    let pcf_err = compute_fixed_point_error(prec.pcf_bits);
    let res_err = compute_fixed_point_error(prec.result_bits);
    let total_err = pcf_err + res_err;

    for comb in 0u32..(1 << 8) {
        if (0..4).any(|i| {
            let bit_true = (comb >> i) & 1 != 0;
            (bit_true && !cmps0[i].is_true) || (!bit_true && !cmps0[i].is_false)
        }) {
            continue;
        }
        if (0..4).any(|i| {
            let bit_true = (comb >> (i + 4)) & 1 != 0;
            (bit_true && !cmps1[i].is_true) || (!bit_true && !cmps1[i].is_false)
        }) {
            continue;
        }

        let ref_val0: [f32; 4] = std::array::from_fn(|i| if (comb >> i) & 1 != 0 { 1.0 } else { 0.0 });
        let ref_val1: [f32; 4] = std::array::from_fn(|i| if (comb >> (i + 4)) & 1 != 0 { 1.0 } else { 0.0 });

        let v00 = bilinear_interpolate(ref_val0, x_bounds0[0], y_bounds0[0]);
        let v01 = bilinear_interpolate(ref_val0, x_bounds0[1], y_bounds0[0]);
        let v02 = bilinear_interpolate(ref_val0, x_bounds0[0], y_bounds0[1]);
        let v03 = bilinear_interpolate(ref_val0, x_bounds0[1], y_bounds0[1]);
        let min_v0 = v00.min(v01).min(v02).min(v03);
        let max_v0 = v00.max(v01).max(v02).max(v03);

        let v10 = bilinear_interpolate(ref_val1, x_bounds1[0], y_bounds1[0]);
        let v11 = bilinear_interpolate(ref_val1, x_bounds1[1], y_bounds1[0]);
        let v12 = bilinear_interpolate(ref_val1, x_bounds1[0], y_bounds1[1]);
        let v13 = bilinear_interpolate(ref_val1, x_bounds1[1], y_bounds1[1]);
        let min_v1 = v10.min(v11).min(v12).min(v13);
        let max_v1 = v10.max(v11).max(v12).max(v13);

        let min_f0 = min_v0 * (1.0 - f_bounds[0]) + min_v1 * f_bounds[0];
        let min_f1 = min_v0 * (1.0 - f_bounds[1]) + min_v1 * f_bounds[1];
        let max_f0 = max_v0 * (1.0 - f_bounds[0]) + max_v1 * f_bounds[0];
        let max_f1 = max_v0 * (1.0 - f_bounds[1]) + max_v1 * f_bounds[1];

        let min_f = min_f0.min(min_f1);
        let max_f = max_f0.max(max_f1);
        let (min_r, max_r) = (min_f - total_err, max_f + total_err);

        if (min_r..=max_r).contains(&result) {
            return true;
        }
    }
    false
}

/// `isTrilinearCompareValid`
#[allow(clippy::too_many_arguments)]
fn is_trilinear_compare_valid(
    compare_mode: CompareMode,
    prec: &TexComparePrecision,
    depths0: [f32; 4],
    depths1: [f32; 4],
    x_bounds0: [f32; 2],
    y_bounds0: [f32; 2],
    x_bounds1: [f32; 2],
    y_bounds1: [f32; 2],
    f_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
    is_fixed_point_depth: bool,
) -> bool {
    if prec.pcf_bits > 0 {
        is_trilinear_pcf_compare_valid(
            compare_mode,
            prec,
            depths0,
            depths1,
            x_bounds0,
            y_bounds0,
            x_bounds1,
            y_bounds1,
            f_bounds,
            cmp_reference,
            result,
            is_fixed_point_depth,
        )
    } else {
        is_trilinear_any_compare_valid(
            compare_mode,
            prec,
            depths0,
            depths1,
            cmp_reference,
            result,
            is_fixed_point_depth,
        )
    }
}

/// `isNearestCompareResultValid` (the `(Vec2, coordZ)` overload)
#[allow(clippy::too_many_arguments)]
fn is_nearest_compare_result_valid(
    level: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    coord_z: i32,
    cmp_reference: f32,
    result: f32,
) -> bool {
    let is_fixed_point_depth = is_fixed_point_depth_texture_format(level.format());
    let [w, h, _] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i = u_lo.floor() as i32;
    let max_i = u_hi.floor() as i32;
    let min_j = v_lo.floor() as i32;
    let max_j = v_hi.floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let x = wrap(wrap_s, i, w as i32);
            let y = wrap(wrap_t, j, h as i32);
            let depth = lookup_depth(level, x, y, coord_z, prec.border_color);
            let res_set = exec_compare(
                sampler.compare,
                depth,
                cmp_reference,
                prec.reference_bits,
                is_fixed_point_depth,
            );
            if is_result_in_set(res_set, result, prec.result_bits) {
                return true;
            }
        }
    }
    false
}

/// `isLinearCompareResultValid` (the `(Vec2, coordZ)` overload)
#[allow(clippy::too_many_arguments)]
fn is_linear_compare_result_valid(
    level: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    coord_z: i32,
    cmp_reference: f32,
    result: f32,
) -> bool {
    let is_fixed_point_depth = is_fixed_point_depth_texture_format(level.format());
    let [w, h, _] = level.size();
    let (u_bounds, v_bounds) = (
        compute_non_normalized_coord_bounds(
            sampler.normalized_coords,
            w as i32,
            coord[0],
            prec.coord_bits[0],
            prec.uvw_bits[0],
        ),
        compute_non_normalized_coord_bounds(
            sampler.normalized_coords,
            h as i32,
            coord[1],
            prec.coord_bits[1],
            prec.uvw_bits[1],
        ),
    );

    let min_i = (u_bounds.0 - 0.5).floor() as i32;
    let max_i = (u_bounds.1 - 0.5).floor() as i32;
    let min_j = (v_bounds.0 - 0.5).floor() as i32;
    let max_j = (v_bounds.1 - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let x0 = wrap(wrap_s, i, w as i32);
            let x1 = wrap(wrap_s, i + 1, w as i32);
            let y0 = wrap(wrap_t, j, h as i32);
            let y1 = wrap(wrap_t, j + 1, h as i32);

            let min_a = ((u_bounds.0 - 0.5) - i as f32).clamp(0.0, 1.0);
            let max_a = ((u_bounds.1 - 0.5) - i as f32).clamp(0.0, 1.0);
            let min_b = ((v_bounds.0 - 0.5) - j as f32).clamp(0.0, 1.0);
            let max_b = ((v_bounds.1 - 0.5) - j as f32).clamp(0.0, 1.0);

            let depths = [
                lookup_depth(level, x0, y0, coord_z, prec.border_color),
                lookup_depth(level, x1, y0, coord_z, prec.border_color),
                lookup_depth(level, x0, y1, coord_z, prec.border_color),
                lookup_depth(level, x1, y1, coord_z, prec.border_color),
            ];

            if is_bilinear_compare_valid(
                sampler.compare,
                prec,
                depths,
                [min_a, max_a],
                [min_b, max_b],
                cmp_reference,
                result,
                is_fixed_point_depth,
            ) {
                return true;
            }
        }
    }
    false
}

/// `isLevelCompareResultValid`
#[allow(clippy::too_many_arguments)]
fn is_level_compare_result_valid(
    level: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    filter_mode: super::pixel::FilterMode,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    coord_z: i32,
    cmp_reference: f32,
    result: f32,
) -> bool {
    use super::pixel::FilterMode;
    match filter_mode {
        FilterMode::Linear => is_linear_compare_result_valid(
            level,
            sampler,
            wrap_s,
            wrap_t,
            prec,
            coord,
            coord_z,
            cmp_reference,
            result,
        ),
        FilterMode::Nearest => is_nearest_compare_result_valid(
            level,
            sampler,
            wrap_s,
            wrap_t,
            prec,
            coord,
            coord_z,
            cmp_reference,
            result,
        ),
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `isNearestMipmapLinearCompareResultValid`
#[allow(clippy::too_many_arguments)]
fn is_nearest_mipmap_linear_compare_result_valid(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    coord_z: i32,
    f_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
) -> bool {
    let is_fixed_point_depth = is_fixed_point_depth_texture_format(level0.format());
    let [w0, h0, _] = level0.size();
    let [w1, h1, _] = level1.size();

    let u_bounds0 = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        w0 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let u_bounds1 = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        w1 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let v_bounds0 = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        h0 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let v_bounds1 = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        h1 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let (min_i0, max_i0) = (u_bounds0.0.floor() as i32, u_bounds0.1.floor() as i32);
    let (min_i1, max_i1) = (u_bounds1.0.floor() as i32, u_bounds1.1.floor() as i32);
    let (min_j0, max_j0) = (v_bounds0.0.floor() as i32, v_bounds0.1.floor() as i32);
    let (min_j1, max_j1) = (v_bounds1.0.floor() as i32, v_bounds1.1.floor() as i32);

    for j0 in min_j0..=max_j0 {
        for i0 in min_i0..=max_i0 {
            let depth0 = lookup_depth(
                level0,
                wrap(wrap_s, i0, w0 as i32),
                wrap(wrap_t, j0, h0 as i32),
                coord_z,
                prec.border_color,
            );
            for j1 in min_j1..=max_j1 {
                for i1 in min_i1..=max_i1 {
                    let depth1 = lookup_depth(
                        level1,
                        wrap(wrap_s, i1, w1 as i32),
                        wrap(wrap_t, j1, h1 as i32),
                        coord_z,
                        prec.border_color,
                    );
                    if is_linear_compare_valid(
                        sampler.compare,
                        prec,
                        [depth0, depth1],
                        f_bounds,
                        cmp_reference,
                        result,
                        is_fixed_point_depth,
                    ) {
                        return true;
                    }
                }
            }
        }
    }
    false
}

/// `isLinearMipmapLinearCompareResultValid`
#[allow(clippy::too_many_arguments)]
fn is_linear_mipmap_linear_compare_result_valid(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    coord_z: i32,
    f_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
) -> bool {
    let is_fixed_point_depth = is_fixed_point_depth_texture_format(level0.format());
    let [w0, h0, _] = level0.size();
    let [w1, h1, _] = level1.size();

    let u_bounds0 = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        w0 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let u_bounds1 = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        w1 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let v_bounds0 = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        h0 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let v_bounds1 = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        h1 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let (min_i0, max_i0) = ((u_bounds0.0 - 0.5).floor() as i32, (u_bounds0.1 - 0.5).floor() as i32);
    let (min_i1, max_i1) = ((u_bounds1.0 - 0.5).floor() as i32, (u_bounds1.1 - 0.5).floor() as i32);
    let (min_j0, max_j0) = ((v_bounds0.0 - 0.5).floor() as i32, (v_bounds0.1 - 0.5).floor() as i32);
    let (min_j1, max_j1) = ((v_bounds1.0 - 0.5).floor() as i32, (v_bounds1.1 - 0.5).floor() as i32);

    for j0 in min_j0..=max_j0 {
        for i0 in min_i0..=max_i0 {
            let min_a0 = ((u_bounds0.0 - 0.5) - i0 as f32).clamp(0.0, 1.0);
            let max_a0 = ((u_bounds0.1 - 0.5) - i0 as f32).clamp(0.0, 1.0);
            let min_b0 = ((v_bounds0.0 - 0.5) - j0 as f32).clamp(0.0, 1.0);
            let max_b0 = ((v_bounds0.1 - 0.5) - j0 as f32).clamp(0.0, 1.0);

            let x0 = wrap(wrap_s, i0, w0 as i32);
            let x1 = wrap(wrap_s, i0 + 1, w0 as i32);
            let y0 = wrap(wrap_t, j0, h0 as i32);
            let y1 = wrap(wrap_t, j0 + 1, h0 as i32);
            let depths0 = [
                lookup_depth(level0, x0, y0, coord_z, prec.border_color),
                lookup_depth(level0, x1, y0, coord_z, prec.border_color),
                lookup_depth(level0, x0, y1, coord_z, prec.border_color),
                lookup_depth(level0, x1, y1, coord_z, prec.border_color),
            ];

            for j1 in min_j1..=max_j1 {
                for i1 in min_i1..=max_i1 {
                    let min_a1 = ((u_bounds1.0 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                    let max_a1 = ((u_bounds1.1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                    let min_b1 = ((v_bounds1.0 - 0.5) - j1 as f32).clamp(0.0, 1.0);
                    let max_b1 = ((v_bounds1.1 - 0.5) - j1 as f32).clamp(0.0, 1.0);

                    let x0 = wrap(wrap_s, i1, w1 as i32);
                    let x1 = wrap(wrap_s, i1 + 1, w1 as i32);
                    let y0 = wrap(wrap_t, j1, h1 as i32);
                    let y1 = wrap(wrap_t, j1 + 1, h1 as i32);
                    let depths1 = [
                        lookup_depth(level1, x0, y0, coord_z, prec.border_color),
                        lookup_depth(level1, x1, y0, coord_z, prec.border_color),
                        lookup_depth(level1, x0, y1, coord_z, prec.border_color),
                        lookup_depth(level1, x1, y1, coord_z, prec.border_color),
                    ];

                    if is_trilinear_compare_valid(
                        sampler.compare,
                        prec,
                        depths0,
                        depths1,
                        [min_a0, max_a0],
                        [min_b0, max_b0],
                        [min_a1, max_a1],
                        [min_b1, max_b1],
                        f_bounds,
                        cmp_reference,
                        result,
                        is_fixed_point_depth,
                    ) {
                        return true;
                    }
                }
            }
        }
    }
    false
}

/// `isMipmapLinearCompareResultValid`
#[allow(clippy::too_many_arguments)]
fn is_mipmap_linear_compare_result_valid(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    level_filter: super::pixel::FilterMode,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    coord_z: i32,
    f_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
) -> bool {
    use super::pixel::FilterMode;
    if level_filter == FilterMode::Linear {
        is_linear_mipmap_linear_compare_result_valid(
            level0,
            level1,
            sampler,
            wrap_s,
            wrap_t,
            prec,
            coord,
            coord_z,
            f_bounds,
            cmp_reference,
            result,
        )
    } else {
        is_nearest_mipmap_linear_compare_result_valid(
            level0,
            level1,
            sampler,
            wrap_s,
            wrap_t,
            prec,
            coord,
            coord_z,
            f_bounds,
            cmp_reference,
            result,
        )
    }
}

/// `isTexCompareResultValid` for `Texture2DView` - the public entry point, mirroring
/// `tcu::tex_verifier::is_lookup_result_valid_2d`'s own shape and arguments exactly
/// (`wrap_s`/`wrap_t`/`normalized_coords` come from `sampler` directly here rather than
/// as separate parameters, since nothing about shadow comparison needs them split out
/// the way the lookup verifier's own API happens to take them - a straight translation
/// would have threaded four more parameters through every function above for no reason).
#[allow(clippy::too_many_arguments)]
pub fn is_tex_compare_result_valid_2d(
    levels: &[ConstPixelBufferAccess<'_>],
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    min_filter: MinFilterMode,
    mag_filter: super::pixel::FilterMode,
    lod_threshold: f32,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    lod_bounds: (f32, f32),
    cmp_reference: f32,
    result: f32,
) -> bool {
    debug_assert!(!levels.is_empty());
    debug_assert!(sampler.compare != CompareMode::None);
    let (min_lod, max_lod) = lod_bounds;
    let can_be_magnified = min_lod <= lod_threshold;
    let can_be_minified = max_lod > lod_threshold;

    if can_be_magnified
        && is_level_compare_result_valid(
            &levels[0],
            sampler,
            wrap_s,
            wrap_t,
            mag_filter,
            prec,
            coord,
            0,
            cmp_reference,
            result,
        )
    {
        return true;
    }

    if can_be_minified {
        let min_tex_level = 0i32;
        let max_tex_level = levels.len() as i32 - 1;
        debug_assert!(min_tex_level <= max_tex_level);

        if min_filter.is_linear_mipmap() {
            let min_level = (min_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
            let max_level = (max_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
            debug_assert!(min_level <= max_level);

            for level in min_level..=max_level {
                let min_f = (min_lod - level as f32).clamp(0.0, 1.0);
                let max_f = (max_lod - level as f32).clamp(0.0, 1.0);
                if is_mipmap_linear_compare_result_valid(
                    &levels[level as usize],
                    &levels[level as usize + 1],
                    sampler,
                    wrap_s,
                    wrap_t,
                    min_filter.level_filter(),
                    prec,
                    coord,
                    0,
                    [min_f, max_f],
                    cmp_reference,
                    result,
                ) {
                    return true;
                }
            }
        } else if min_filter.is_nearest_mipmap() {
            let min_level = (((min_lod + 0.5).ceil() as i32) - 1).clamp(min_tex_level, max_tex_level);
            let max_level = ((max_lod + 0.5).floor() as i32).clamp(min_tex_level, max_tex_level);
            debug_assert!(min_level <= max_level);

            for level in min_level..=max_level {
                if is_level_compare_result_valid(
                    &levels[level as usize],
                    sampler,
                    wrap_s,
                    wrap_t,
                    min_filter.level_filter(),
                    prec,
                    coord,
                    0,
                    cmp_reference,
                    result,
                ) {
                    return true;
                }
            }
        } else if is_level_compare_result_valid(
            &levels[0],
            sampler,
            wrap_s,
            wrap_t,
            min_filter.level_filter(),
            prec,
            coord,
            0,
            cmp_reference,
            result,
        ) {
            return true;
        }
    }

    false
}

/// `isTexCompareResultValid` for `Texture2DArrayView` - `is_tex_compare_result_valid_2d`'s
/// own body, looped over every layer the `z` coordinate's own uncertainty window could
/// have rounded to. See this module's top doc comment for why the layer-range formula
/// here is its own thing, not `tex_verifier::compute_layer_range`.
#[allow(clippy::too_many_arguments)]
pub fn is_tex_compare_result_valid_2d_array(
    levels: &[ConstPixelBufferAccess<'_>],
    num_layers: i32,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    min_filter: MinFilterMode,
    mag_filter: super::pixel::FilterMode,
    lod_threshold: f32,
    prec: &TexComparePrecision,
    coord: [f32; 3],
    lod_bounds: (f32, f32),
    cmp_reference: f32,
    result: f32,
) -> bool {
    debug_assert!(!levels.is_empty());
    debug_assert!(sampler.compare != CompareMode::None);

    let depth_err =
        compute_floating_point_error(coord[2], prec.coord_bits[2]) + compute_fixed_point_error(prec.uvw_bits[2]);
    let min_z = coord[2] - depth_err;
    let max_z = coord[2] + depth_err;
    let min_layer = ((min_z + 0.5).floor() as i32).clamp(0, num_layers - 1);
    let max_layer = ((max_z + 0.5).floor() as i32).clamp(0, num_layers - 1);
    let coord_xy = [coord[0], coord[1]];

    for coord_z in min_layer..=max_layer {
        let (min_lod, max_lod) = lod_bounds;
        let can_be_magnified = min_lod <= lod_threshold;
        let can_be_minified = max_lod > lod_threshold;

        if can_be_magnified
            && is_level_compare_result_valid(
                &levels[0],
                sampler,
                wrap_s,
                wrap_t,
                mag_filter,
                prec,
                coord_xy,
                coord_z,
                cmp_reference,
                result,
            )
        {
            return true;
        }

        if can_be_minified {
            let min_tex_level = 0i32;
            let max_tex_level = levels.len() as i32 - 1;
            debug_assert!(min_tex_level <= max_tex_level);

            if min_filter.is_linear_mipmap() {
                let min_level = (min_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
                let max_level = (max_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
                debug_assert!(min_level <= max_level);

                for level in min_level..=max_level {
                    let min_f = (min_lod - level as f32).clamp(0.0, 1.0);
                    let max_f = (max_lod - level as f32).clamp(0.0, 1.0);
                    if is_mipmap_linear_compare_result_valid(
                        &levels[level as usize],
                        &levels[level as usize + 1],
                        sampler,
                        wrap_s,
                        wrap_t,
                        min_filter.level_filter(),
                        prec,
                        coord_xy,
                        coord_z,
                        [min_f, max_f],
                        cmp_reference,
                        result,
                    ) {
                        return true;
                    }
                }
            } else if min_filter.is_nearest_mipmap() {
                let min_level = (((min_lod + 0.5).ceil() as i32) - 1).clamp(min_tex_level, max_tex_level);
                let max_level = ((max_lod + 0.5).floor() as i32).clamp(min_tex_level, max_tex_level);
                debug_assert!(min_level <= max_level);

                for level in min_level..=max_level {
                    if is_level_compare_result_valid(
                        &levels[level as usize],
                        sampler,
                        wrap_s,
                        wrap_t,
                        min_filter.level_filter(),
                        prec,
                        coord_xy,
                        coord_z,
                        cmp_reference,
                        result,
                    ) {
                        return true;
                    }
                }
            } else if is_level_compare_result_valid(
                &levels[0],
                sampler,
                wrap_s,
                wrap_t,
                min_filter.level_filter(),
                prec,
                coord_xy,
                coord_z,
                cmp_reference,
                result,
            ) {
                return true;
            }
        }
    }

    false
}

/// `isGatherOffsetsCompareResultValid` (the internal `ConstPixelBufferAccess` overload) -
/// textureGather always samples the base level with NEAREST-style integer taps (no
/// filtering), so unlike every function above this takes no filter mode at all: each of
/// the 4 `offsets` names one tap relative to the base `(i, j)`, and all 4 taps have to
/// agree with their own slot in `result` simultaneously for a given `(i, j)` to validate
/// it - a driver may still have computed `(i, j)` anywhere in the coordinate's own
/// uncertainty window, same as the NEAREST-filter search above.
#[allow(clippy::too_many_arguments)]
fn is_gather_offsets_compare_result_valid(
    texture: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    coord_z: i32,
    offsets: [[i32; 2]; 4],
    cmp_reference: f32,
    result: [f32; 4],
) -> bool {
    let is_fixed_point_depth = is_fixed_point_depth_texture_format(texture.format());
    let [w, h, _] = texture.size();
    let u_bounds = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let v_bounds = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i = (u_bounds.0 - 0.5).floor() as i32;
    let max_i = (u_bounds.1 - 0.5).floor() as i32;
    let min_j = (v_bounds.0 - 0.5).floor() as i32;
    let max_j = (v_bounds.1 - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let mut current_pixel_valid = true;
            for off_ndx in 0..4 {
                if !current_pixel_valid {
                    break;
                }
                let x = wrap(wrap_s, i + offsets[off_ndx][0], w as i32);
                let y = wrap(wrap_t, j + offsets[off_ndx][1], h as i32);
                let depth = lookup_depth(texture, x, y, coord_z, prec.border_color);
                let res_set = exec_compare(
                    sampler.compare,
                    depth,
                    cmp_reference,
                    prec.reference_bits,
                    is_fixed_point_depth,
                );
                if !is_result_in_set(res_set, result[off_ndx], prec.result_bits) {
                    current_pixel_valid = false;
                }
            }
            if current_pixel_valid {
                return true;
            }
        }
    }
    false
}

/// `isGatherOffsetsCompareResultValid` for `Texture2DView`
#[allow(clippy::too_many_arguments)]
pub fn is_gather_offsets_compare_result_valid_2d(
    texture: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    prec: &TexComparePrecision,
    coord: [f32; 2],
    offsets: [[i32; 2]; 4],
    cmp_reference: f32,
    result: [f32; 4],
) -> bool {
    debug_assert!(sampler.compare != CompareMode::None);
    is_gather_offsets_compare_result_valid(
        texture,
        sampler,
        wrap_s,
        wrap_t,
        prec,
        coord,
        0,
        offsets,
        cmp_reference,
        result,
    )
}

/// `isGatherOffsetsCompareResultValid` for `Texture2DArrayView` - textureGather has no
/// mipmap axis at all (always the base level), so this is only the layer loop, no
/// level-selection ladder the way `is_tex_compare_result_valid_2d_array` needs one.
#[allow(clippy::too_many_arguments)]
pub fn is_gather_offsets_compare_result_valid_2d_array(
    texture_level0: &ConstPixelBufferAccess<'_>,
    num_layers: i32,
    sampler: &Sampler,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    prec: &TexComparePrecision,
    coord: [f32; 3],
    offsets: [[i32; 2]; 4],
    cmp_reference: f32,
    result: [f32; 4],
) -> bool {
    debug_assert!(sampler.compare != CompareMode::None);

    let depth_err =
        compute_floating_point_error(coord[2], prec.coord_bits[2]) + compute_fixed_point_error(prec.uvw_bits[2]);
    let min_z = coord[2] - depth_err;
    let max_z = coord[2] + depth_err;
    let min_layer = ((min_z + 0.5).floor() as i32).clamp(0, num_layers - 1);
    let max_layer = ((max_z + 0.5).floor() as i32).clamp(0, num_layers - 1);
    let coord_xy = [coord[0], coord[1]];

    for layer in min_layer..=max_layer {
        if is_gather_offsets_compare_result_valid(
            texture_level0,
            sampler,
            wrap_s,
            wrap_t,
            prec,
            coord_xy,
            layer,
            offsets,
            cmp_reference,
            result,
        ) {
            return true;
        }
    }
    false
}

/// Splits one mip level's whole-cube access (six faces as depth slices, the shape
/// `tcu::texture_cube::TextureCube::level()` produces) into the `[ConstPixelBufferAccess; 6]`
/// shape the seamless searches below need - identical helper to `tex_verifier`'s own
/// (private there), duplicated rather than exposed across the module boundary since it
/// is three lines and has no state of its own.
fn split_cube_level_faces<'a>(level: &'a ConstPixelBufferAccess<'a>) -> [ConstPixelBufferAccess<'a>; 6] {
    const ORDER: [CubeFace; 6] = [
        CubeFace::NegativeX,
        CubeFace::PositiveX,
        CubeFace::NegativeY,
        CubeFace::PositiveY,
        CubeFace::NegativeZ,
        CubeFace::PositiveZ,
    ];
    let [w, h, _] = level.size();
    std::array::from_fn(|slot| level.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w, h, 1))
}

/// `isSeamlessLinearCompareResultValid` - the cube counterpart of
/// `is_linear_compare_result_valid`: each of the four taps a candidate texel offset
/// needs is independently seam-remapped onto whichever face actually owns it
/// (`remap_cube_edge_coords`, already ported for `tcu::pixel`'s own reference-image
/// production and reused directly), so the resulting 4 depths can straddle up to three
/// faces near a corner. A texel landing on a true corner (owned by no single neighbour)
/// makes the whole candidate undefined - accepted unconditionally, matching upstream and
/// the already-ported lookup-verifier sibling's own reasoning.
///
/// This is the `sampler.seamless_cube_map` branch only - the non-seamless one lives one
/// level up, in `is_cube_level_compare_result_valid`'s own `Linear` arm (a plain
/// single-face `is_linear_compare_result_valid` call, no remapping at all).
fn is_seamless_linear_compare_result_valid(
    faces: &[ConstPixelBufferAccess<'_>; 6],
    sampler: &Sampler,
    prec: &TexComparePrecision,
    coords: &CubeFaceFloatCoords,
    cmp_reference: f32,
    result: f32,
) -> bool {
    let is_fixed_point_depth = is_fixed_point_depth_texture_format(faces[get_cube_face_slot(coords.face)].format());
    let size = faces[get_cube_face_slot(coords.face)].size()[0] as i32;

    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        size,
        coords.s,
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        size,
        coords.t,
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let (c00, c10, c01, c11) = (
                remap_cube_edge_coords(coords.face, i, j, size),
                remap_cube_edge_coords(coords.face, i + 1, j, size),
                remap_cube_edge_coords(coords.face, i, j + 1, size),
                remap_cube_edge_coords(coords.face, i + 1, j + 1, size),
            );
            let (Some(c00), Some(c10), Some(c01), Some(c11)) = (c00, c10, c01, c11) else {
                return true;
            };

            let min_a = ((u_lo - 0.5) - i as f32).clamp(0.0, 1.0);
            let max_a = ((u_hi - 0.5) - i as f32).clamp(0.0, 1.0);
            let min_b = ((v_lo - 0.5) - j as f32).clamp(0.0, 1.0);
            let max_b = ((v_hi - 0.5) - j as f32).clamp(0.0, 1.0);

            let depths = [
                lookup_depth_no_border(&faces[get_cube_face_slot(c00.0)], c00.1, c00.2, 0),
                lookup_depth_no_border(&faces[get_cube_face_slot(c10.0)], c10.1, c10.2, 0),
                lookup_depth_no_border(&faces[get_cube_face_slot(c01.0)], c01.1, c01.2, 0),
                lookup_depth_no_border(&faces[get_cube_face_slot(c11.0)], c11.1, c11.2, 0),
            ];

            if is_bilinear_compare_valid(
                sampler.compare,
                prec,
                depths,
                [min_a, max_a],
                [min_b, max_b],
                cmp_reference,
                result,
                is_fixed_point_depth,
            ) {
                return true;
            }
        }
    }
    false
}

/// `isCubeLevelCompareResultValid` - dispatches a single mip level's own sample to the
/// seamless bilinear search (`LINEAR`, when `sampler.seamless_cube_map`) or a plain
/// clamp-to-edge nearest tap on the resolved face (`NEAREST` - a nearest tap never
/// crosses a face edge, matching the lookup-verifier sibling's own reasoning,
/// unconditionally on `seamless_cube_map`).
///
/// When not seamless, a `LINEAR` tap is a plain single-face bilinear compare confined
/// to `coords.face` - exactly `is_linear_compare_result_valid`, already ported for the
/// ordinary (non-cube) 2D path, called on the one face `coords.face` already names
/// (matching `tex_verifier::is_cube_level_sample_result_valid`'s own non-seamless
/// `LINEAR` arm, the lookup-verifier counterpart of this function).
fn is_cube_level_compare_result_valid(
    level: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    filter: FilterMode,
    prec: &TexComparePrecision,
    coords: &CubeFaceFloatCoords,
    cmp_reference: f32,
    result: f32,
) -> bool {
    let faces = split_cube_level_faces(level);
    match filter {
        FilterMode::Linear if sampler.seamless_cube_map => {
            is_seamless_linear_compare_result_valid(&faces, sampler, prec, coords, cmp_reference, result)
        }
        FilterMode::Linear => is_linear_compare_result_valid(
            &faces[get_cube_face_slot(coords.face)],
            sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            prec,
            [coords.s, coords.t],
            0,
            cmp_reference,
            result,
        ),
        FilterMode::Nearest => is_nearest_compare_result_valid(
            &faces[get_cube_face_slot(coords.face)],
            sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            prec,
            [coords.s, coords.t],
            0,
            cmp_reference,
            result,
        ),
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `isSeamplessLinearMipmapLinearCompareResultValid` - the cube counterpart of
/// `is_linear_mipmap_linear_compare_result_valid`: each level contributes its own
/// bilinear quad of depths (each of its four taps independently seam-remapped, same as
/// the plain seamless search above), and the two levels are blended by
/// `is_trilinear_compare_valid` - confirmed directly against upstream's own body, which
/// itself calls `isTrilinearCompareValid` and nothing seam-aware of its own (unlike the
/// lookup-verifier sibling, no search-step is needed here: the compare search is already
/// a finite enumeration over `CmpResultSet` combinations, not a continuous blend-factor
/// walk). A texel pair landing on a true corner makes the whole candidate quad
/// undefined - accepted unconditionally, same as the plain seamless search.
#[allow(clippy::too_many_arguments)]
fn is_seamless_linear_mipmap_linear_compare_result_valid(
    faces0: &[ConstPixelBufferAccess<'_>; 6],
    faces1: &[ConstPixelBufferAccess<'_>; 6],
    sampler: &Sampler,
    prec: &TexComparePrecision,
    coords: &CubeFaceFloatCoords,
    f_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
) -> bool {
    let is_fixed_point_depth = is_fixed_point_depth_texture_format(faces0[get_cube_face_slot(coords.face)].format());
    let size0 = faces0[get_cube_face_slot(coords.face)].size()[0] as i32;
    let size1 = faces1[get_cube_face_slot(coords.face)].size()[0] as i32;

    let (u_lo0, u_hi0) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        size0,
        coords.s,
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (u_lo1, u_hi1) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        size1,
        coords.s,
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo0, v_hi0) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        size0,
        coords.t,
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (v_lo1, v_hi1) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        size1,
        coords.t,
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i0 = (u_lo0 - 0.5).floor() as i32;
    let max_i0 = (u_hi0 - 0.5).floor() as i32;
    let min_i1 = (u_lo1 - 0.5).floor() as i32;
    let max_i1 = (u_hi1 - 0.5).floor() as i32;
    let min_j0 = (v_lo0 - 0.5).floor() as i32;
    let max_j0 = (v_hi0 - 0.5).floor() as i32;
    let min_j1 = (v_lo1 - 0.5).floor() as i32;
    let max_j1 = (v_hi1 - 0.5).floor() as i32;

    for j0 in min_j0..=max_j0 {
        for i0 in min_i0..=max_i0 {
            let (c00, c10, c01, c11) = (
                remap_cube_edge_coords(coords.face, i0, j0, size0),
                remap_cube_edge_coords(coords.face, i0 + 1, j0, size0),
                remap_cube_edge_coords(coords.face, i0, j0 + 1, size0),
                remap_cube_edge_coords(coords.face, i0 + 1, j0 + 1, size0),
            );
            let (Some(c00), Some(c10), Some(c01), Some(c11)) = (c00, c10, c01, c11) else {
                return true;
            };
            let depths0 = [
                lookup_depth_no_border(&faces0[get_cube_face_slot(c00.0)], c00.1, c00.2, 0),
                lookup_depth_no_border(&faces0[get_cube_face_slot(c10.0)], c10.1, c10.2, 0),
                lookup_depth_no_border(&faces0[get_cube_face_slot(c01.0)], c01.1, c01.2, 0),
                lookup_depth_no_border(&faces0[get_cube_face_slot(c11.0)], c11.1, c11.2, 0),
            ];

            let min_a0 = ((u_lo0 - 0.5) - i0 as f32).clamp(0.0, 1.0);
            let max_a0 = ((u_hi0 - 0.5) - i0 as f32).clamp(0.0, 1.0);
            let min_b0 = ((v_lo0 - 0.5) - j0 as f32).clamp(0.0, 1.0);
            let max_b0 = ((v_hi0 - 0.5) - j0 as f32).clamp(0.0, 1.0);

            for j1 in min_j1..=max_j1 {
                for i1 in min_i1..=max_i1 {
                    let (d00, d10, d01, d11) = (
                        remap_cube_edge_coords(coords.face, i1, j1, size1),
                        remap_cube_edge_coords(coords.face, i1 + 1, j1, size1),
                        remap_cube_edge_coords(coords.face, i1, j1 + 1, size1),
                        remap_cube_edge_coords(coords.face, i1 + 1, j1 + 1, size1),
                    );
                    let (Some(d00), Some(d10), Some(d01), Some(d11)) = (d00, d10, d01, d11) else {
                        return true;
                    };
                    let depths1 = [
                        lookup_depth_no_border(&faces1[get_cube_face_slot(d00.0)], d00.1, d00.2, 0),
                        lookup_depth_no_border(&faces1[get_cube_face_slot(d10.0)], d10.1, d10.2, 0),
                        lookup_depth_no_border(&faces1[get_cube_face_slot(d01.0)], d01.1, d01.2, 0),
                        lookup_depth_no_border(&faces1[get_cube_face_slot(d11.0)], d11.1, d11.2, 0),
                    ];

                    let min_a1 = ((u_lo1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                    let max_a1 = ((u_hi1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                    let min_b1 = ((v_lo1 - 0.5) - j1 as f32).clamp(0.0, 1.0);
                    let max_b1 = ((v_hi1 - 0.5) - j1 as f32).clamp(0.0, 1.0);

                    if is_trilinear_compare_valid(
                        sampler.compare,
                        prec,
                        depths0,
                        depths1,
                        [min_a0, max_a0],
                        [min_b0, max_b0],
                        [min_a1, max_a1],
                        [min_b1, max_b1],
                        f_bounds,
                        cmp_reference,
                        result,
                        is_fixed_point_depth,
                    ) {
                        return true;
                    }
                }
            }
        }
    }
    false
}

/// `isCubeMipmapLinearCompareResultValid` - dispatches the cross-mip-level cube blend to
/// the seamless search above (`LINEAR` level filter, `sampler.seamless_cube_map`) or a
/// plain nearest-mipmap-linear check with no seam crossing at either level (`NEAREST`
/// level filter). When not seamless, a `LINEAR` level filter is a plain two-level
/// trilinear compare confined to one face - `is_linear_mipmap_linear_compare_result_valid`,
/// same reasoning as `is_cube_level_compare_result_valid`'s own non-seamless arm.
#[allow(clippy::too_many_arguments)]
fn is_cube_mipmap_linear_compare_result_valid(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    level_filter: FilterMode,
    prec: &TexComparePrecision,
    coords: &CubeFaceFloatCoords,
    f_bounds: [f32; 2],
    cmp_reference: f32,
    result: f32,
) -> bool {
    let faces0 = split_cube_level_faces(level0);
    let faces1 = split_cube_level_faces(level1);

    match level_filter {
        FilterMode::Linear if sampler.seamless_cube_map => is_seamless_linear_mipmap_linear_compare_result_valid(
            &faces0,
            &faces1,
            sampler,
            prec,
            coords,
            f_bounds,
            cmp_reference,
            result,
        ),
        FilterMode::Linear => is_linear_mipmap_linear_compare_result_valid(
            &faces0[get_cube_face_slot(coords.face)],
            &faces1[get_cube_face_slot(coords.face)],
            sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            prec,
            [coords.s, coords.t],
            0,
            f_bounds,
            cmp_reference,
            result,
        ),
        FilterMode::Nearest => is_nearest_mipmap_linear_compare_result_valid(
            &faces0[get_cube_face_slot(coords.face)],
            &faces1[get_cube_face_slot(coords.face)],
            sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            prec,
            [coords.s, coords.t],
            0,
            f_bounds,
            cmp_reference,
            result,
        ),
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `isTexCompareResultValid` for `TextureCubeView` - mirrors
/// `tex_verifier::is_lookup_result_valid_cube`'s own magnified/minified dispatch, tried
/// against every face `get_possible_cube_faces` returns (accepting if any one of them
/// explains the result).
#[allow(clippy::too_many_arguments)]
pub fn is_tex_compare_result_valid_cube(
    levels: &[ConstPixelBufferAccess<'_>],
    sampler: &Sampler,
    min_filter: MinFilterMode,
    mag_filter: FilterMode,
    lod_threshold: f32,
    prec: &TexComparePrecision,
    coord: [f32; 3],
    lod_bounds: (f32, f32),
    cmp_reference: f32,
    result: f32,
) -> bool {
    debug_assert!(!levels.is_empty());
    debug_assert!(sampler.compare != CompareMode::None);

    let possible_faces = get_possible_cube_faces(coord, prec.coord_bits);
    if possible_faces.is_empty() {
        return true;
    }

    let (min_lod, max_lod) = lod_bounds;
    let can_be_magnified = min_lod <= lod_threshold;
    let can_be_minified = max_lod > lod_threshold;
    let min_tex_level = 0i32;
    let max_tex_level = levels.len() as i32 - 1;
    debug_assert!(min_tex_level <= max_tex_level);

    for face in possible_faces {
        let s_t = project_to_face(face, coord);
        let coords = CubeFaceFloatCoords {
            face,
            s: s_t[0],
            t: s_t[1],
        };

        if can_be_magnified
            && is_cube_level_compare_result_valid(&levels[0], sampler, mag_filter, prec, &coords, cmp_reference, result)
        {
            return true;
        }

        if can_be_minified {
            if min_filter.is_linear_mipmap() && min_tex_level < max_tex_level {
                let min_level = (min_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
                let max_level = (max_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
                debug_assert!(min_level <= max_level);

                for level in min_level..=max_level {
                    let min_f = (min_lod - level as f32).clamp(0.0, 1.0);
                    let max_f = (max_lod - level as f32).clamp(0.0, 1.0);
                    if is_cube_mipmap_linear_compare_result_valid(
                        &levels[level as usize],
                        &levels[level as usize + 1],
                        sampler,
                        min_filter.level_filter(),
                        prec,
                        &coords,
                        [min_f, max_f],
                        cmp_reference,
                        result,
                    ) {
                        return true;
                    }
                }
            } else if min_filter.is_nearest_mipmap() {
                let min_level = (((min_lod + 0.5).ceil() as i32) - 1).clamp(min_tex_level, max_tex_level);
                let max_level = ((max_lod + 0.5).floor() as i32).clamp(min_tex_level, max_tex_level);
                debug_assert!(min_level <= max_level);

                for level in min_level..=max_level {
                    if is_cube_level_compare_result_valid(
                        &levels[level as usize],
                        sampler,
                        min_filter.level_filter(),
                        prec,
                        &coords,
                        cmp_reference,
                        result,
                    ) {
                        return true;
                    }
                }
            } else if is_cube_level_compare_result_valid(
                &levels[0],
                sampler,
                min_filter.level_filter(),
                prec,
                &coords,
                cmp_reference,
                result,
            ) {
                return true;
            }
        }
    }

    false
}

/// `isTexCompareResultValid` for `TextureCubeArrayView` - `is_tex_compare_result_valid_cube` looped over every layer the `w` coordinate's
/// uncertainty window could have rounded to (upstream loops inside each level check, the or over layers commutes with the rest).
#[allow(clippy::too_many_arguments)]
pub fn is_tex_compare_result_valid_cube_array(
    levels: &[ConstPixelBufferAccess<'_>],
    sampler: &Sampler,
    min_filter: MinFilterMode,
    mag_filter: FilterMode,
    lod_threshold: f32,
    prec: &TexComparePrecision,
    coord: [f32; 4],
    lod_bounds: (f32, f32),
    cmp_reference: f32,
    result: f32,
) -> bool {
    debug_assert!(!levels.is_empty());
    let num_layers = (levels[0].size()[2] / 6) as i32;
    let depth = coord[3];
    let depth_err =
        compute_floating_point_error(depth, prec.coord_bits[2]) + compute_fixed_point_error(prec.uvw_bits[2]);
    let min_layer = (((depth - depth_err) + 0.5).floor() as i32).clamp(0, num_layers - 1);
    let max_layer = (((depth + depth_err) + 0.5).floor() as i32).clamp(0, num_layers - 1);

    for layer in min_layer..=max_layer {
        let layer_levels: Vec<ConstPixelBufferAccess<'_>> = levels
            .iter()
            .map(|level| {
                let [w, h, _] = level.size();
                level.get_subregion(0, 0, layer as u32 * 6, w, h, 6)
            })
            .collect();
        if is_tex_compare_result_valid_cube(
            &layer_levels,
            sampler,
            min_filter,
            mag_filter,
            lod_threshold,
            prec,
            [coord[0], coord[1], coord[2]],
            lod_bounds,
            cmp_reference,
            result,
        ) {
            return true;
        }
    }
    false
}

/// `isGatherCompareResultValid` (the internal `CubeFaceFloatCoords` overload) - cube
/// gather has no caller-supplied offsets at all (unlike the 2D/2D-array overloads):
/// GLES has no `textureGatherOffset` for a cube sampler, so the 4 taps are always the
/// same fixed `(0,1),(1,1),(1,0),(0,0)` footprint upstream hardcodes, each
/// independently seam-remapped the same way the plain seamless bilinear search is.
fn is_gather_compare_result_valid_cube_face(
    faces: &[ConstPixelBufferAccess<'_>; 6],
    sampler: &Sampler,
    prec: &TexComparePrecision,
    coords: &CubeFaceFloatCoords,
    cmp_reference: f32,
    result: [f32; 4],
) -> bool {
    const OFFSETS: [[i32; 2]; 4] = [[0, 1], [1, 1], [1, 0], [0, 0]];
    let is_fixed_point_depth = is_fixed_point_depth_texture_format(faces[get_cube_face_slot(coords.face)].format());
    let size = faces[get_cube_face_slot(coords.face)].size()[0] as i32;

    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        size,
        coords.s,
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        sampler.normalized_coords,
        size,
        coords.t,
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let mut current_pixel_valid = true;
            for (off_ndx, offset) in OFFSETS.iter().enumerate() {
                if !current_pixel_valid {
                    break;
                }
                let Some((face, s, t)) = remap_cube_edge_coords(coords.face, i + offset[0], j + offset[1], size) else {
                    // A corner owned by no single neighbour - implementations may do
                    // anything, matching every other seam-remap case in this file.
                    return true;
                };
                let depth = lookup_depth_no_border(&faces[get_cube_face_slot(face)], s, t, 0);
                let res_set = exec_compare(
                    sampler.compare,
                    depth,
                    cmp_reference,
                    prec.reference_bits,
                    is_fixed_point_depth,
                );
                if !is_result_in_set(res_set, result[off_ndx], prec.result_bits) {
                    current_pixel_valid = false;
                }
            }
            if current_pixel_valid {
                return true;
            }
        }
    }
    false
}

/// `isGatherCompareResultValid` for `TextureCubeView` - tries every face
/// `get_possible_cube_faces` names, same as `is_tex_compare_result_valid_cube`.
pub fn is_gather_compare_result_valid_cube(
    level0: &ConstPixelBufferAccess<'_>,
    sampler: &Sampler,
    prec: &TexComparePrecision,
    coord: [f32; 3],
    cmp_reference: f32,
    result: [f32; 4],
) -> bool {
    debug_assert!(sampler.compare != CompareMode::None);
    let faces = split_cube_level_faces(level0);
    let possible_faces = get_possible_cube_faces(coord, prec.coord_bits);
    if possible_faces.is_empty() {
        return true;
    }

    for face in possible_faces {
        let s_t = project_to_face(face, coord);
        let coords = CubeFaceFloatCoords {
            face,
            s: s_t[0],
            t: s_t[1],
        };
        if is_gather_compare_result_valid_cube_face(&faces, sampler, prec, &coords, cmp_reference, result) {
            return true;
        }
    }
    false
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::FilterMode;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    fn depth_level(w: u32, h: u32, values: &[f32]) -> Vec<u8> {
        values
            .iter()
            .flat_map(|v| v.to_le_bytes())
            .collect::<Vec<u8>>()
            .into_iter()
            .take((w * h * 4) as usize)
            .collect()
    }

    fn make_sampler(compare: CompareMode) -> Sampler {
        Sampler {
            wrap_s: crate::tcu::pixel::WrapMode::ClampToEdge,
            wrap_t: crate::tcu::pixel::WrapMode::ClampToEdge,
            wrap_r: crate::tcu::pixel::WrapMode::ClampToEdge,
            filter: FilterMode::Nearest,
            normalized_coords: false,
            compare,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        }
    }

    #[test]
    fn exec_compare_less_matches_hand_computed_true_false_sets() {
        // referenceBits=16 -> err = computeFixedPointError(16), tiny. At reference 0.5
        // and depth 0.3, LESS means "0.5 - err < 0.3" is false and "0.5 + err >= 0.3" is
        // true - i.e. this tap can only resolve to *false* (0.3 is not less than ~0.5).
        let prec = TexComparePrecision::default();
        let set = exec_compare(CompareMode::Less, 0.3, 0.5, prec.reference_bits, true);
        assert!(!set.is_true);
        assert!(set.is_false);

        // Depth 0.8, reference 0.5, LESS: "0.5 - err < 0.8" is true, "0.5 + err >= 0.8" is
        // false - only *true* is reachable.
        let set2 = exec_compare(CompareMode::Less, 0.8, 0.5, prec.reference_bits, true);
        assert!(set2.is_true);
        assert!(!set2.is_false);
    }

    #[test]
    fn nearest_compare_against_a_uniform_depth_texture_is_unambiguous() {
        // A 2x2 depth texture, every texel depth 0.5. LESS compare against reference
        // 0.8 (0.8 < 0.5 is false) must report the sample as a definite 0.0, and
        // reference 0.2 (0.2 < 0.5 is true) a definite 1.0 - no ambiguity since every
        // candidate texel has the same depth.
        let format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
        let data = depth_level(2, 2, &[0.5, 0.5, 0.5, 0.5]);
        let level = ConstPixelBufferAccess::new(format, [2, 2, 1], &data);
        let levels = [level];
        let sampler = make_sampler(CompareMode::Less);
        let prec = TexComparePrecision::default();

        assert!(is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5],
            (0.0, 0.0),
            0.2,
            1.0
        ));
        assert!(!is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5],
            (0.0, 0.0),
            0.2,
            0.0
        ));
        assert!(is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5],
            (0.0, 0.0),
            0.8,
            0.0
        ));
    }

    /// `WrapMode::ClampToBorder` on the s axis: pixel-space `u=5.0` is three texels past
    /// the right edge of a width-2 level (same hand-derived candidate range as
    /// `tcu::tex_verifier`'s own `is_nearest_sample_result_valid_2d_reads_the_border_
    /// colour_past_the_edge` - `min_i=4`/`max_i=5`, both of which wrap to the
    /// out-of-range sentinel `2`), so the compare must be resolved against
    /// `prec.border_color` (`0.9`) rather than the level's own uniform depth (`0.1`).
    /// LESS (`ref < texel`) against reference `0.5`: `0.5 < 0.9` is unambiguously true
    /// against the border, but `0.5 < 0.1` would be unambiguously false against the
    /// edge texel `ClampToEdge` would have pinned to instead - the two give opposite
    /// verdicts, which is what makes this test actually discriminate border handling
    /// from an edge-clamp fallback rather than passing either way.
    #[test]
    fn tex_compare_result_valid_2d_reads_the_border_colour_past_the_edge() {
        let format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
        let data = depth_level(2, 2, &[0.1, 0.1, 0.1, 0.1]);
        let level = ConstPixelBufferAccess::new(format, [2, 2, 1], &data);
        let levels = [level];
        let sampler = make_sampler(CompareMode::Less);
        let prec = TexComparePrecision {
            border_color: 0.9,
            ..TexComparePrecision::default()
        };

        assert!(is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToBorder,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [5.0, 0.5],
            (0.0, 0.0),
            0.5,
            1.0
        ));
        assert!(!is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToBorder,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [5.0, 0.5],
            (0.0, 0.0),
            0.5,
            0.0
        ));
    }

    #[test]
    fn linear_compare_across_a_half_true_half_false_quad_accepts_the_whole_range() {
        // A 2x2 depth texture: left column depth 0.0, right column depth 1.0. `execCompare`'s
        // LESS is "reference < texel": against reference 0.5 the left column (texel 0.0) is
        // definitely false (0.5 < 0.0 is false) and the right column (texel 1.0) definitely
        // true (0.5 < 1.0). With PCF disabled (`pcf_bits = 0`), `isBilinearAnyCompareValid`
        // only asks whether *any* of the four taps could be true and whether any could be
        // false - both hold here, so a driver may legally return either 0.0 or 1.0 (or
        // anything between) for a sample straddling both columns, regardless of blend factor.
        let format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
        let data = depth_level(2, 2, &[0.0, 1.0, 0.0, 1.0]);
        let level = ConstPixelBufferAccess::new(format, [2, 2, 1], &data);
        let levels = [level];
        let mut sampler = make_sampler(CompareMode::Less);
        sampler.filter = FilterMode::Linear;
        let prec = TexComparePrecision {
            pcf_bits: 0,
            ..TexComparePrecision::default()
        };

        assert!(is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Linear,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 1.0],
            (0.0, 0.0),
            0.5,
            1.0
        ));
        assert!(is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Linear,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 1.0],
            (0.0, 0.0),
            0.5,
            0.0
        ));
        assert!(is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Linear,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 1.0],
            (0.0, 0.0),
            0.5,
            0.5
        ));
    }

    #[test]
    fn mipmap_nearest_picks_either_adjacent_level() {
        // Level 0 is uniformly depth 0.0 ("reference(0.5) < texel(0.0)" is false, so
        // LESS always resolves to 0.0), level 1 uniformly depth 1.0 (0.5 < 1.0 is true,
        // always 1.0). At an LOD of 0.2 (`ceil(0.2+0.5)-1 = 0`, `floor(0.2+0.5) = 0`),
        // NEAREST_MIPMAP_NEAREST's level-selection formula picks level 0 alone, so only
        // its answer (always 0.0) should be reachable, not level 1's 1.0.
        let format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
        let data0 = depth_level(2, 2, &[0.0, 0.0, 0.0, 0.0]);
        let data1 = depth_level(1, 1, &[1.0]);
        let level0 = ConstPixelBufferAccess::new(format, [2, 2, 1], &data0);
        let level1 = ConstPixelBufferAccess::new(format, [1, 1, 1], &data1);
        let levels = [level0, level1];
        let sampler = make_sampler(CompareMode::Less);
        let prec = TexComparePrecision::default();

        assert!(is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::NearestMipmapNearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5],
            (0.2, 0.2),
            0.5,
            0.0
        ));
        assert!(!is_tex_compare_result_valid_2d(
            &levels,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::NearestMipmapNearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5],
            (0.2, 0.2),
            0.5,
            1.0
        ));
    }

    #[test]
    fn array_layer_selection_picks_the_coordinates_own_layer_only() {
        // A 2x2x2 depth array: layer 0 uniformly 0.0 ("0.5 < 0.0" is false -> result
        // 0.0), layer 1 uniformly 1.0 ("0.5 < 1.0" is true -> result 1.0). Each
        // integer-ish layer coordinate (z=0.0 -> minLayer=maxLayer=floor(0.5)=0,
        // z=1.0 -> floor(1.5)=1) must reach only its own layer's answer.
        let format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
        let data: Vec<u8> = [0.0f32, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0]
            .iter()
            .flat_map(|v| v.to_le_bytes())
            .collect();
        let level = ConstPixelBufferAccess::new(format, [2, 2, 2], &data);
        let levels = [level];
        let sampler = make_sampler(CompareMode::Less);
        let prec = TexComparePrecision::default();

        assert!(is_tex_compare_result_valid_2d_array(
            &levels,
            2,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5, 0.0],
            (0.0, 0.0),
            0.5,
            0.0
        ));
        assert!(!is_tex_compare_result_valid_2d_array(
            &levels,
            2,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5, 0.0],
            (0.0, 0.0),
            0.5,
            1.0
        ));
        assert!(is_tex_compare_result_valid_2d_array(
            &levels,
            2,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5, 1.0],
            (0.0, 0.0),
            0.5,
            1.0
        ));
        assert!(!is_tex_compare_result_valid_2d_array(
            &levels,
            2,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5, 1.0],
            (0.0, 0.0),
            0.5,
            0.0
        ));
    }

    #[test]
    fn gather_offsets_compare_requires_every_tap_to_agree_with_its_own_slot() {
        // 4x4 depth texture. coord=[2.0, 2.0] (non-normalized) pins the gather's base
        // integer coordinate to exactly (1,1) (floor(2.0-0.5)=1, no ambiguity at this
        // precision), so offsets [(0,0),(1,0),(0,1),(1,1)] sample texels (1,1), (2,1),
        // (1,2), (2,2) - set to depths 0.2, 0.7, 0.3, 0.8 respectively, everything else
        // an irrelevant 0.5. Reference 0.5, LESS ("reference < texel"): (1,1)=0.2 -> 0.0,
        // (2,1)=0.7 -> 1.0, (1,2)=0.3 -> 0.0, (2,2)=0.8 -> 1.0 - every tap definite, so
        // only that exact 4-vector is valid, not one with any single slot flipped.
        #[rustfmt::skip]
        let values: [f32; 16] = [
            0.5, 0.5, 0.5, 0.5,
            0.5, 0.2, 0.7, 0.5,
            0.5, 0.3, 0.8, 0.5,
            0.5, 0.5, 0.5, 0.5,
        ];
        let format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
        let data: Vec<u8> = values.iter().flat_map(|v| v.to_le_bytes()).collect();
        let texture = ConstPixelBufferAccess::new(format, [4, 4, 1], &data);
        let sampler = make_sampler(CompareMode::Less);
        let prec = TexComparePrecision::default();
        let offsets = [[0, 0], [1, 0], [0, 1], [1, 1]];

        assert!(is_gather_offsets_compare_result_valid_2d(
            &texture,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            &prec,
            [2.0, 2.0],
            offsets,
            0.5,
            [0.0, 1.0, 0.0, 1.0]
        ));
        assert!(!is_gather_offsets_compare_result_valid_2d(
            &texture,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            &prec,
            [2.0, 2.0],
            offsets,
            0.5,
            [1.0, 1.0, 0.0, 1.0]
        ));
        assert!(!is_gather_offsets_compare_result_valid_2d(
            &texture,
            &sampler,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            &prec,
            [2.0, 2.0],
            offsets,
            0.5,
            [0.0, 0.0, 0.0, 1.0]
        ));
    }

    fn make_cube_sampler(compare: CompareMode) -> Sampler {
        Sampler {
            wrap_s: crate::tcu::pixel::WrapMode::ClampToEdge,
            wrap_t: crate::tcu::pixel::WrapMode::ClampToEdge,
            wrap_r: crate::tcu::pixel::WrapMode::ClampToEdge,
            filter: FilterMode::Nearest,
            normalized_coords: true,
            compare,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        }
    }

    fn solid_depth_cube(size: u32, depth_per_face: impl Fn(CubeFace) -> f32) -> crate::tcu::texture_cube::TextureCube {
        let fmt = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
        let mut cube = crate::tcu::texture_cube::TextureCube::new(fmt, size);
        cube.alloc_level(0);
        for face in [
            CubeFace::NegativeX,
            CubeFace::PositiveX,
            CubeFace::NegativeY,
            CubeFace::PositiveY,
            CubeFace::NegativeZ,
            CubeFace::PositiveZ,
        ] {
            let d = depth_per_face(face);
            let mut access = cube.face_level_mut(face, 0);
            for y in 0..size {
                for x in 0..size {
                    access.set_pixel([d, 0.0, 0.0, 1.0], x, y, 0);
                }
            }
        }
        cube
    }

    #[test]
    fn cube_nearest_compare_picks_the_projected_faces_own_depth() {
        // +X face uniformly depth 0.0 ("0.5 < 0.0" is false -> 0.0), every other face
        // uniformly 1.0 ("0.5 < 1.0" is true -> 1.0, never reached since the coordinate
        // points straight down +X). Sampled well inside the face (no seam involved).
        let cube = solid_depth_cube(2, |face| if face == CubeFace::PositiveX { 0.0 } else { 1.0 });
        let level = cube.level(0);
        let levels = [level];
        let sampler = make_cube_sampler(CompareMode::Less);
        let prec = TexComparePrecision::default();

        assert!(is_tex_compare_result_valid_cube(
            &levels,
            &sampler,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [1.0, 0.0, 0.0],
            (0.0, 0.0),
            0.5,
            0.0
        ));
        assert!(!is_tex_compare_result_valid_cube(
            &levels,
            &sampler,
            MinFilterMode::Nearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [1.0, 0.0, 0.0],
            (0.0, 0.0),
            0.5,
            1.0
        ));
    }

    /// Seamless bilinear compare across a face edge - the genuinely new piece this
    /// overload adds over the plain 2D case. Same geometry
    /// `tex_verifier`'s own `is_seamless_linear_sample_result_valid_blends_across_a_face_edge`
    /// test uses (a size-2 cube, `+X` flat except two texels `remap_cube_edge_coords`
    /// itself names, sampled at `s=1.0, t=0.5` to force the tap at `i=2` across the
    /// edge): there, the four taps' own *colours* were `[0.2, 0.8, 0.2, 0.8]`, blending
    /// to exactly `0.5` at the `(a,b)=(0.5,0.5)` blend factors that geometry produces.
    /// Here the same four *depths* feed `execCompare(LESS, depth, reference=0.5)`:
    /// `0.2` is unambiguously false (`0.5 < 0.2` is false), `0.8` unambiguously true
    /// (`0.5 < 0.8`) - with PCF active (the default), only the one combination matching
    /// those four definite outcomes contributes, and `bilinear_interpolate([0,1,0,1],
    /// 0.5, 0.5)` is `0.5` by the same arithmetic the colour test already used - so the
    /// valid compare result is `0.5`, not `0.0` or `1.0`.
    #[test]
    fn cube_seamless_linear_compare_blends_across_a_face_edge() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube = solid_depth_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.5 });
        cube.face_level_mut(neighbor0, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx0 as u32, ny0 as u32, 0);
        cube.face_level_mut(neighbor1, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx1 as u32, ny1 as u32, 0);

        let level = cube.level(0);
        let sampler = make_cube_sampler(CompareMode::Less);
        let prec = TexComparePrecision::default();
        // Hand-built coordinates, the same way `tex_verifier`'s own seam test calls
        // `is_cube_level_sample_result_valid` directly rather than through the full
        // `get_possible_cube_faces`/`project_to_face` dispatch - `s=1.0` exactly would
        // make face *selection* itself ambiguous for a real direction vector (it lands
        // exactly on the `+X`/`-Z` edge too), which is not what this test is about.
        let coords = CubeFaceFloatCoords {
            face: CubeFace::PositiveX,
            s: 1.0,
            t: 0.5,
        };

        assert!(is_cube_level_compare_result_valid(
            &level,
            &sampler,
            FilterMode::Linear,
            &prec,
            &coords,
            0.5,
            0.5
        ));
        assert!(!is_cube_level_compare_result_valid(
            &level,
            &sampler,
            FilterMode::Linear,
            &prec,
            &coords,
            0.5,
            0.0
        ));
        assert!(!is_cube_level_compare_result_valid(
            &level,
            &sampler,
            FilterMode::Linear,
            &prec,
            &coords,
            0.5,
            1.0
        ));
    }

    /// The non-seamless counterpart of `cube_seamless_linear_compare_blends_across_a_
    /// face_edge` above - same cube, same hand-built edge coordinate, but
    /// `seamless_cube_map: false` must now reject the seamless-blended `0.5` (there is
    /// no cross-face read at all without seamlessness) and instead land on `+X`'s own
    /// clamp-to-edge tap. Same clamp-to-column-1 reasoning as `tex_verifier`'s sibling
    /// test (`is_cube_level_sample_result_valid_clamps_to_the_edge_instead_of_blending_
    /// when_not_seamless`): all four depths the bilinear quad reads collapse onto `+X`'s
    /// own flat `0.2`. `LESS` means `reference < texel` (the same convention the
    /// seamless test right above already establishes: "`0.2` is unambiguously false
    /// (`0.5 < 0.2` is false)"), so `execCompare(LESS, texel=0.2, reference=0.5)` is
    /// unambiguously `false` - the only valid non-seamless result here is `0.0`, not
    /// `0.5` (the seamless blend) or `1.0`.
    #[test]
    fn cube_non_seamless_linear_compare_clamps_to_the_edge_instead_of_blending() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube = solid_depth_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.5 });
        cube.face_level_mut(neighbor0, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx0 as u32, ny0 as u32, 0);
        cube.face_level_mut(neighbor1, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx1 as u32, ny1 as u32, 0);

        let level = cube.level(0);
        let sampler = Sampler {
            seamless_cube_map: false,
            ..make_cube_sampler(CompareMode::Less)
        };
        let prec = TexComparePrecision::default();
        let coords = CubeFaceFloatCoords {
            face: CubeFace::PositiveX,
            s: 1.0,
            t: 0.5,
        };

        assert!(
            is_cube_level_compare_result_valid(&level, &sampler, FilterMode::Linear, &prec, &coords, 0.5, 0.0),
            "clamped to +X's own flat 0.2, LESS(0.5, 0.2) is false"
        );
        assert!(
            !is_cube_level_compare_result_valid(&level, &sampler, FilterMode::Linear, &prec, &coords, 0.5, 0.5),
            "the seamless-blended 0.5 must not be accepted once seamless_cube_map is false"
        );
        assert!(!is_cube_level_compare_result_valid(
            &level,
            &sampler,
            FilterMode::Linear,
            &prec,
            &coords,
            0.5,
            1.0
        ));
    }

    /// Cube gather has no caller offsets, always the fixed `(0,1),(1,1),(1,0),(0,0)`
    /// footprint relative to the gather's own base `(i,j)=(1,0)` (forced the same way
    /// the seamless-bilinear test above forces it, `s=1.0, t=0.5` on a size-2 face):
    /// `(0,1)`->`(1,1)` stays on `+X` (depth `0.2`), `(1,1)`->`(2,1)` crosses to
    /// `neighbor1` (`0.8`), `(1,0)`->`(2,0)` crosses to `neighbor0` (`0.8`),
    /// `(0,0)`->`(1,0)` stays on `+X` (`0.2`). Unlike bilinear filtering, gather applies
    /// no blending at all - each of the 4 slots is an exact, unambiguous compare
    /// outcome, so only `[0.0, 1.0, 1.0, 0.0]` is valid, not any single-slot variant.
    #[test]
    fn cube_gather_compare_reads_the_fixed_footprint_with_no_blending() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube = solid_depth_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.5 });
        cube.face_level_mut(neighbor0, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx0 as u32, ny0 as u32, 0);
        cube.face_level_mut(neighbor1, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx1 as u32, ny1 as u32, 0);

        let level = cube.level(0);
        let faces = split_cube_level_faces(&level);
        let sampler = make_cube_sampler(CompareMode::Less);
        let prec = TexComparePrecision::default();
        let coords = CubeFaceFloatCoords {
            face: CubeFace::PositiveX,
            s: 1.0,
            t: 0.5,
        };

        assert!(is_gather_compare_result_valid_cube_face(
            &faces,
            &sampler,
            &prec,
            &coords,
            0.5,
            [0.0, 1.0, 1.0, 0.0]
        ));
        assert!(!is_gather_compare_result_valid_cube_face(
            &faces,
            &sampler,
            &prec,
            &coords,
            0.5,
            [1.0, 1.0, 1.0, 0.0]
        ));
        assert!(!is_gather_compare_result_valid_cube_face(
            &faces,
            &sampler,
            &prec,
            &coords,
            0.5,
            [0.0, 0.0, 1.0, 0.0]
        ));
    }
}

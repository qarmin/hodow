// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexVerifierUtil.cpp
//   framework/common/tcuTexLookupVerifier.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A blit is not a copy: the driver picks a source texel from a coordinate it computed
// itself, at a precision the spec does not pin down. So the check is not "does the
// result equal the reference" but "could some texel the coordinate might legally have
// landed on produce this result". That is what this layer answers.
//
// The NEAREST filter (`is_nearest_sample_result_valid_float`/`_int`, ported for the
// blit tests, `LookupPrecision::color_mask` plus an explicit `threshold` argument) and
// the single-level 2D bilinear path (`is_linear_sample_result_valid_2d`, added for
// `texture.filtering`/`texture.wrap`'s own verification - `glsTextureTestUtil.cpp`'s
// `computeTextureLookupDiff` calls straight into upstream's `tcu::isLinearSampleResultValid`,
// not its own ad hoc comparison, so a LINEAR-filtered `texture.*` case cannot be
// verified against real hardware without this) are both ported.
//
// The full mipmap-aware 2D dispatcher (`is_lookup_result_valid_2d`, `tcu::isLookupResultValid`
// for `Texture2DView`) is now ported too, for every `Sampler::FilterMode` a 2D minFilter can
// legally be: single-level NEAREST/LINEAR (magnified, or minified with no mipmap filter at
// all), `*_MIPMAP_NEAREST` (pick one of the two nearest levels by `isNearestSampleResultValid`/
// `isLinearSampleResultValid` - note this is still *not* blending between levels, just picking
// one), and `*_MIPMAP_LINEAR` (true trilinear - blend two adjacent levels, each sampled
// NEAREST or LINEAR per `getLevelFilter`, `is_mipmap_linear_sample_result_valid_2d` dispatching
// to `is_nearest_mipmap_linear_sample_result_valid_2d`/`is_linear_mipmap_linear_sample_result_
// valid_2d`). `texture.mipmap`'s own cases need exactly this, confirmed by grepping
// `es3fTextureMipmapTests.cpp` directly: every mipmap case computes `isTrilinear` and calls
// `computeTextureLookupDiff` with the *whole* mip pyramid, which upstream's own
// `isLookupResultValid` is what actually walks.
//
// `LodPrecision`/`compute_lod_bounds_from_derivates`/`clamp_lod_bounds` (`tcuTexLookupVerifier.
// {hpp,cpp}`'s own of the same name) are ported alongside, since a caller of
// `is_lookup_result_valid_2d` has to turn a derivative into the `lod_bounds` argument somehow -
// these are the generic (not texture-type-specific) half of that; the *triangle*-derivative
// math (which pixel's `(dudx, dudy, ...)` actually are) is `glu::texture_test_util`'s own
// `tri_derivate_x`/`_y`/`compute_non_projected_tri_lod_2d`, a different file, already ported.
//
// `is_lookup_result_valid_2d_array` (`tcu::isLookupResultValid` for `Texture2DArrayView`)
// is ported too, and turned out to need far less new code than the 2D dispatcher's own
// doc comment (below) warned a future 1D/3D/cube/array port might: every per-level/
// per-mip helper here (`is_nearest_sample_result_valid_2d`, `is_level_sample_result_
// valid_2d`, both mipmap-linear variants, `lookup_quad`/`lookup_float`) already took a
// `coord_z: i32` parameter, unused by `is_lookup_result_valid_2d` beyond always passing
// `0` - that parameter *is* upstream's own per-layer index, so the array dispatcher is
// `is_lookup_result_valid_2d`'s own body with an outer `compute_layer_range` loop around
// it and `0` replaced by `layer`, confirmed directly against `tcuTexLookupVerifier.cpp`'s
// `isLookupResultValid(Texture2DArrayView, ...)` rather than assumed. Reused as-is
// because nothing about a 2D-array lookup needs a different *per-slice* sampling
// formula - only which slice(s) a given layer coordinate could legally resolve to.
//
// `is_lookup_result_valid_3d` (`tcu::isLookupResultValid` for `Texture3DView`) is
// ported in full, every `MinFilterMode` included: single-level NEAREST/LINEAR
// (magnified, or minified with no mipmap filter at all, both going through the
// within-level-trilinear `is_linear_sample_result_valid_3d`/`is_nearest_sample_result_
// valid_3d`), `*_MIPMAP_NEAREST` (pick one of the two nearest levels, reusing
// `is_level_sample_result_valid_3d`, same shape as the 2D dispatcher's own
// `*_MIPMAP_NEAREST` branch), and now `*_MIPMAP_LINEAR` too (true trilinear *across*
// mip levels) via `is_mipmap_linear_sample_result_valid_3d` dispatching to
// `is_nearest_mipmap_linear_sample_result_valid_3d`/`is_linear_mipmap_linear_sample_
// result_valid_3d`, the latter walking `is_3d_trilinear_filter_result_valid`'s own
// four-`ColorQuad` search (`quad00`/`quad01` for level 0's two z-slices, `quad10`/
// `quad11` for level 1's) - ported directly from upstream's own `is3DTrilinearFilter
// ResultValid` rather than approximated from the 2D/within-level-3D shapes already
// here, since none of them generalizes to a four-quad search on their own.
//
// `is_lookup_result_valid_cube` (`tcu::isLookupResultValid` for `TextureCubeView`) is
// ported in full too - the seam-aware piece a prior pass of this file's own inventory
// flagged as needing `getPossibleCubeFaces`/`projectToFace`/`CubeFaceFloatCoords`/
// `remapCubeEdgeCoords`/`isCubeLevelSampleResultValid`/`isSeamlessLinearMipmapLinear
// SampleResultValid`. Most of that list turned out to already exist, ported for
// `tcu::pixel`'s own reference-image-production side (`project_to_face`/
// `remap_cube_edge_coords`/`get_cube_array_face_index` - confirmed by reading
// `tcu::pixel::sample_cube_level`/`sample_cube_seamless_linear` directly, not assumed)
// - only `get_possible_cube_faces`, the single-level seamless bilinear search
// (`is_seamless_linear_sample_result_valid`) and its cross-mip-level sibling
// (`is_seamless_linear_mipmap_linear_sample_result_valid`, ported from upstream's own
// `isSeamplessLinearMipmapLinearSampleResultValid` - each level's own quad built the
// same seam-remapped way the single-level search already does, then blended by
// `is_2d_trilinear_filter_result_valid`, reused directly rather than duplicated, since
// upstream's own body calls exactly that and nothing more seam-aware) were genuinely
// new. Every `MinFilterMode` is covered: magnified/`*_MIPMAP_NEAREST`/no-mipmap
// minified through `is_cube_level_sample_result_valid`, `*_MIPMAP_LINEAR` through
// `is_cube_mipmap_linear_sample_result_valid`, both tried against every face
// `get_possible_cube_faces` names.
//
// **Non-seamless cube sampling is now ported too** (`Sampler::seamless_cube_map`,
// threaded through both functions above as their own `seamless_cube_map` parameter).
// This crate's `Sampler` originally had no such toggle at all - every cube sampler built
// anywhere in this crate was unconditionally seamless (confirmed at the time by reading
// `tcu::pixel::sample_cube_mipmap`'s own call graph) - so upstream's non-seamless
// `isLinearSampleResultValid(level[coords.face], ...)`/`isLinearMipmapLinearSampleResult
// Valid(faces0[coords.face], ...)` branches were not offered as an option anywhere in
// this file. Both are a single-face bilinear/trilinear tap with no cross-face
// remapping - exactly `is_linear_sample_result_valid_2d`/`is_linear_mipmap_linear_
// sample_result_valid_2d`, already ported for the ordinary (non-cube) 2D path, called
// directly on the one face `coords.face` already names (`coords.s`/`coords.t` are
// already that face's own pixel-space coordinates via `project_to_face`, so no further
// translation is needed). `tcu::pixel`'s own sampling (reference-image *production*,
// the opposite side from this file's *verification*) still only ever builds a seamless
// cube sampler - `sample_cube_mipmap` takes no `seamless_cube_map` parameter at all -
// so a test that actually wants a non-seamless reference image still needs that side
// ported too; this file's own verifier is independent of it (it works directly from
// possible-texel-candidate enumeration, not from a separately-rendered reference image),
// which is what let this be added without touching `tcu::pixel` at all.
//
// Still not ported: 1D array and cube array (no GLES2/GLES3 texture target needs
// either - see this file's own git history for the standing note on that). Four
// distinct upstream functions share a superficially similar "two (or four) `ColorQuad`s
// blended over a window" shape and are each ported separately rather than collapsed
// into one: `is2DTrilinearFilterResultValid` (`is_2d_trilinear_filter_result_valid` -
// cross-*mip-level* blend, independent in-plane blend fraction per level since the two
// levels' texel grids differ in size), `isTrilinearRangeValid`
// (`is_trilinear_range_valid` - within-level 3D blend across adjacent z-slices of the
// *same* level, so one shared in-plane blend fraction), `is3DTrilinearFilterResultValid`
// (`is_3d_trilinear_filter_result_valid` - cross-mip-level blend where each level is
// itself already z-blended, needing all four quad combinations), and
// `isSeamplessLinearMipmapLinearSampleResultValid`
// (`is_seamless_linear_mipmap_linear_sample_result_valid` - the cube counterpart of the
// 2D cross-mip-level case, each level's own quad additionally seam-remapped before the
// shared `is_2d_trilinear_filter_result_valid` blend). `Sampler::CUBIC`/`*_MIPMAP_*`
// cubic filtering (`unimplemented!`, nothing in this crate constructs a cubic sampler)
// and `MIN`/`MAX` reduction mode (ES3.1 multisample-texture-specific, `WEIGHTED_AVERAGE`
// only throughout this file) stay narrowed the same way as before.
//
// `WrapMode::ClampToBorder` is now ported too, for `texture.border_clamp`
// (`es31fTextureBorderClampTests.cpp`): `wrap()` gives it upstream's own
// `deClamp32(c, -1, size)` formula, and `coords_in_bounds`/`lookup_float`/`lookup_quad`
// read `LookupPrecision::border_color` instead of fetching a texel whenever a wrapped
// coordinate comes back as one of those two sentinels. This crate's `Sampler` carries no
// `borderColor` field of its own (nothing else here has needed one yet), so the border
// colour is threaded through `LookupPrecision` instead, resolved by whichever caller
// knows the GL sampler state under test - the same way `is_nearest_sample_result_valid_
// float`'s own `threshold` argument is passed explicitly rather than read off a
// `Sampler`. Scoped to the non-cube paths only: a cube map is always implicitly
// clamp-to-edge regardless of wrap-mode state (see `is_cube_level_sample_result_valid`'s
// own doc comment), so `ClampToBorder` never reaches `get_possible_cube_faces`/
// `remap_cube_edge_coords` at all - confirmed directly against upstream, which never
// calls `wrap()` anywhere in its own cube-sampling code path either.
//
// `computeCubeLodBoundsFromDerivates` is ported too - the cube counterpart of
// `compute_lod_bounds_from_derivates` above, needed by any caller of
// `is_lookup_result_valid_cube` that has a triangle's own per-pixel derivatives rather
// than an already-computed `lod_bounds` window (`glu::texture_test_util::
// compute_cube_lod_from_derivates` is the reference-image-production sibling that
// already existed; this is the verification-side one, previously missing).
//
// `isGatherOffsetsResultValid`/`isGatherResultValid` (the ordinary-colour counterparts
// of `tex_compare_verifier`'s own gather-compare functions) are ported too, for
// `texture.gather`'s non-shadow-compare subgroup - a genuine gap this port's own
// inventory had missed: `es31fTextureGatherTests.cpp` calls these directly rather than
// going through `glsTextureTestUtil`'s shared chain, so the earlier "(a), already
// closed" verdict for that subgroup was wrong (nothing here had actually ported a
// gather-specific verifier at all until now). `is_gather_offsets_result_valid_2d`/
// `_2d_array` are the 2D/2D-array overloads (plain `wrap()`, no seam involved);
// `is_gather_result_valid_cube` is **not** a clamp-to-edge tap the way every other cube
// function in this file is - confirmed directly against upstream, cube gather always
// seam-remaps each of its 4 taps individually via `remap_cube_edge_coords`, with no
// `seamless_cube_map`-shaped branch at all (`isGatherResultValid` for `TextureCubeView`
// never reads `sampler.seamlessCubeMap`).
//
// `IntLookupPrecision` (the integer/unsigned-sampler counterpart of `LookupPrecision`,
// `isampler*`/`usampler*`) is now ported too - `isLevel2DLookupResultValid`/
// `isLevel3DLookupResultValid` (`is_level_2d_lookup_result_valid_int`/`_uint`,
// `is_level_3d_lookup_result_valid_int`/`_uint`; `isLevel1DLookupResultValid` stays
// unported, no GLES texture target needs plain 1D at all - see this file's own standing
// note on that) and the `IntLookupPrecision` overloads of `isGatherOffsetsResultValid`/
// `isGatherResultValid` (`_int`/`_uint` siblings of the float gather functions just
// above) - exactly the counterpart `texture.gather`'s own `isampler2D`/`usampler2D`
// variants were flagged as eventually needing. Confirmed against upstream: GL/GLES has
// no `LINEAR` filter for an integer sampler at all (`isLevel*LookupResultValid`'s own
// `IntLookupPrecision` overloads `DE_ASSERT` both `minFilter`/`magFilter` are `NEAREST`
// and ignore `scaleMode` entirely), so there is no bilinear/trilinear/mipmap-blend
// search to port here the way the float path has - every `IntLookupPrecision` function
// is a single-level NEAREST-only candidate-texel search, `isColorValid`'s own threshold
// comparison swapped for `absDiff(...).asUint() <= colorThreshold` (signed) or
// `absDiff(...) <= colorThreshold` (unsigned) in place of the float path's
// colour-threshold-with-tolerance compare. See `IntLookupPrecision`'s own doc comment
// for why integer border colour is an explicit per-function argument rather than a
// struct field the way `LookupPrecision::border_color` is.

use super::pixel::{
    ConstPixelBufferAccess, CubeFace, FilterMode, get_cube_array_face_index, get_cube_face_slot, project_to_face,
    remap_cube_edge_coords, select_cube_face,
};
use super::texture::{ChannelOrder, TextureChannelClass};

/// `tcu::Sampler::WrapMode`, narrowed to the modes a 2D lookup verification needs.
///
/// `ClampToBorder` feeds `texture.border_clamp` (`es31fTextureBorderClampTests.cpp`,
/// confirmed by reading it directly): out-of-range coordinates read a fixed border
/// colour instead of any texel, rather than pinning to the nearest valid one the way
/// `ClampToEdge` does. `wrap()` below gives it upstream's own `deClamp32(c, -1, size)`
/// formula - the sentinel values `-1`/`size` it can produce are what every `lookup_*`
/// helper in this file checks for to decide "texel" vs "border colour"
/// (`LookupPrecision::border_color`), the same relationship `tcu::tex_compare_verifier`'s
/// own `lookup_depth` now has to `TexComparePrecision::border_color`.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum WrapMode {
    ClampToEdge,
    /// `CLAMP_TO_BORDER` - see this enum's own doc comment above.
    ClampToBorder,
    Repeat,
    MirroredRepeat,
    /// `MIRRORED_ONCE` (`VK_SAMPLER_ADDRESS_MODE_MIRROR_CLAMP_TO_EDGE`): the coordinate is clamped to `[-size, size]` and then mirrored.
    MirroredOnce,
}

/// `tcu::LookupPrecision` - the float-sampler precision parameters. `IntLookupPrecision`
/// (below) is its own, separate struct rather than a merge into this one: upstream keeps
/// them distinct too (`Vec4 colorThreshold` here vs `UVec4 colorThreshold` there, and this
/// struct alone carries `border_color`/`color_threshold` in the comparison colour space
/// a float lookup needs), so collapsing them would need a generic parameter for no
/// shared code - every function below that reads one explicitly names which.
pub struct LookupPrecision {
    /// Bits per coordinate component before any transformation, treated as floating point.
    pub coord_bits: [i32; 3],
    /// Bits per component in the final per-level UVW coordinates, treated as fixed point.
    pub uvw_bits: [i32; 3],
    pub color_mask: [bool; 4],
    /// `LookupPrecision::colorThreshold` - only read by the bilinear path
    /// (`is_linear_sample_result_valid_2d` and the helpers it calls); the nearest-filter
    /// functions above still take their own `threshold` argument directly, matching
    /// upstream's own `isColorValid(prec, ...)` call there reading the same field this
    /// one does, just not plumbed through this struct for that older, narrower path.
    pub color_threshold: [f32; 4],
    /// `Sampler::borderColor`, already resolved to the comparison colour space (this
    /// port's `Sampler` carries no `borderColor` field of its own - see `wrap`'s own
    /// doc comment - so the caller that knows which GL sampler state produced the
    /// lookup under test supplies it here instead, the same way `threshold` above is
    /// passed explicitly rather than read off a `Sampler`). Read only by `lookup_float`/
    /// `lookup_quad` when a wrapped coordinate lands outside the level - every wrap mode
    /// other than `WrapMode::ClampToBorder` never produces one, so this field is
    /// otherwise dead. Defaults to `[0.0; 4]` (transparent black), the GL/GLES spec
    /// default for `GL_TEXTURE_BORDER_COLOR`.
    pub border_color: [f32; 4],
}

impl Default for LookupPrecision {
    fn default() -> Self {
        Self {
            coord_bits: [22; 3],
            uvw_bits: [16; 3],
            color_mask: [true; 4],
            color_threshold: [0.0; 4],
            border_color: [0.0; 4],
        }
    }
}

/// `tcu::IntLookupPrecision` - the precision parameters an integer/unsigned-sampler
/// lookup (`isampler*`/`usampler*`, no `LINEAR` filtering in GL/GLES, so only a
/// NEAREST-filter search is ever needed) is checked against. `color_threshold` is
/// `UVec4` upstream unconditionally - even the signed-integer overload of `isColorValid`
/// compares `absDiff(ref, result).asUint()` against it - so this struct serves both the
/// `_int` and `_uint` functions below rather than needing two.
///
/// This port's `Sampler` carries no `borderColor` field (see `LookupPrecision::
/// border_color`'s own doc comment above for why), and an integer border colour's
/// correct representable type (`i32` vs `u32`) depends on which of `_int`/`_uint` is
/// being checked - so, unlike the float path, it is **not** a field here at all: every
/// function below that can read one (anything that can wrap to `WrapMode::ClampToBorder`)
/// takes its own correctly-typed `border_color` argument directly, the same way
/// `is_nearest_sample_result_valid_float`'s `threshold` is passed explicitly rather than
/// read off a precision struct.
pub struct IntLookupPrecision {
    pub coord_bits: [i32; 3],
    pub uvw_bits: [i32; 3],
    pub color_mask: [bool; 4],
    /// `IntLookupPrecision::colorThreshold` (`UVec4`) - see this struct's own doc
    /// comment for why it stays `u32` even for the signed-integer overloads.
    pub color_threshold: [u32; 4],
}

impl Default for IntLookupPrecision {
    fn default() -> Self {
        Self {
            coord_bits: [22; 3],
            uvw_bits: [16; 3],
            color_mask: [true; 4],
            color_threshold: [0; 4],
        }
    }
}

/// `tcu::computeFloatingPointError`
///
/// The error of a value held to `num_accurate_bits`: the gap between the mantissa with
/// every garbage bit set and the mantissa with none, at the value's own exponent.
pub fn compute_floating_point_error(value: f32, num_accurate_bits: i32) -> f32 {
    debug_assert!((0..=23).contains(&num_accurate_bits));
    let num_garbage_bits = 23 - num_accurate_bits;
    let mask = (1u32 << num_garbage_bits) - 1;

    // `tcu::Float32(value).exponent()` - the unbiased exponent, and 1 - bias for a zero
    // or denormal, which is what `construct` below expects.
    let bits = value.to_bits();
    let raw_exp = ((bits >> 23) & 0xFF) as i32;
    let exp = if raw_exp == 0 { 1 - 127 } else { raw_exp - 127 };

    // `Float32::construct(+1, exp, mantissa)` with the implicit bit given explicitly.
    let construct = |mantissa: u32| -> f32 {
        let biased = (exp + 127) as u32;
        f32::from_bits((biased << 23) | (mantissa & 0x007F_FFFF))
    };

    construct((1 << 23) | mask) - construct(1 << 23)
}

/// `tcu::computeFixedPointError`
pub fn compute_fixed_point_error(num_accurate_bits: i32) -> f32 {
    compute_floating_point_error(1.0, num_accurate_bits)
}

/// `tcu::computeNonNormalizedCoordBounds` - the range of texel-space coordinates the
/// driver might have computed for this normalised one.
pub fn compute_non_normalized_coord_bounds(
    normalized: bool,
    dim: i32,
    coord: f32,
    coord_bits: i32,
    uv_bits: i32,
) -> (f32, f32) {
    let coord_err = compute_floating_point_error(coord, coord_bits);
    let min_n = coord - coord_err;
    let max_n = coord + coord_err;
    let (min_a, max_a) = if normalized {
        (min_n * dim as f32, max_n * dim as f32)
    } else {
        (min_n, max_n)
    };
    let fixed = compute_fixed_point_error(uv_bits);
    (min_a - fixed, max_a + fixed)
}

/// `tcu::wrap`
pub fn wrap(mode: WrapMode, c: i32, size: i32) -> i32 {
    match mode {
        WrapMode::ClampToEdge => c.clamp(0, size - 1),
        // `deClamp32(c, -1, size)` - deliberately *not* clamped into `[0, size)`: `-1`
        // and `size` are the sentinel "this coordinate landed outside the level"
        // values every `lookup_*` helper below checks for, matching upstream's own
        // `tcu::Sampler::CLAMP_TO_BORDER` arm (same formula as `tcu::pixel::wrap`'s own
        // `ClampToBorder` arm).
        WrapMode::ClampToBorder => c.clamp(-1, size),
        WrapMode::Repeat => c.rem_euclid(size),
        // Same `(size - 1) - mirror(imod(c, 2 * size) - size)` formula as
        // `tcu::pixel::wrap`'s own `MirroredRepeat` arm.
        WrapMode::MirroredRepeat => {
            let m = c.rem_euclid(2 * size) - size;
            let mirrored = if m >= 0 { m } else { -(1 + m) };
            (size - 1) - mirrored
        }
        WrapMode::MirroredOnce => {
            let m = c.clamp(-size, size).rem_euclid(2 * size) - size;
            let mirrored = if m >= 0 { m } else { -(1 + m) };
            (size - 1) - mirrored
        }
    }
}

/// Whether `(x, y, z)` names a real texel of `level` - `tcu::coordsInBounds`. Every
/// caller of `lookup_float`/`lookup_quad` already ran its own coordinate through
/// `wrap()` first, so the only way this is ever false is `WrapMode::ClampToBorder`
/// having produced its `-1`/`size` sentinel on one axis.
fn coords_in_bounds(level: &ConstPixelBufferAccess<'_>, x: i32, y: i32, z: i32) -> bool {
    let [w, h, d] = level.size();
    (0..w as i32).contains(&x) && (0..h as i32).contains(&y) && (0..d as i32).contains(&z)
}

/// The colour a texel fetch yields, in the space the comparison happens in - `tcu::
/// lookup`'s float specialisation. An sRGB source is converted to linear, because the
/// verifier compares linear values; a coordinate that landed outside the level (see
/// `coords_in_bounds`) reads `border_color` instead, unconverted - matching upstream's
/// own `lookup<float>`, which only applies the sRGB step on the in-bounds branch.
fn lookup_float(level: &ConstPixelBufferAccess<'_>, x: i32, y: i32, z: i32, border_color: [f32; 4]) -> [f32; 4] {
    if !coords_in_bounds(level, x, y, z) {
        return border_color;
    }
    let c = level.get_pixel(x as u32, y as u32, z as u32);
    if level.format().order.is_srgb() {
        srgb_to_linear(c)
    } else {
        c
    }
}

/// `tcu::sRGBToLinear`
pub fn srgb_to_linear(c: [f32; 4]) -> [f32; 4] {
    let f = |v: f32| {
        if v <= 0.04045 {
            v / 12.92
        } else {
            ((v + 0.055) / 1.055).powf(2.4)
        }
    };
    [f(c[0]), f(c[1]), f(c[2]), c[3]]
}

/// `tcu::isSRGB`
pub fn is_srgb(order: ChannelOrder) -> bool {
    order.is_srgb()
}

/// The candidate texel range a coordinate could have landed on, per axis.
fn candidate_range(normalized: bool, dim: i32, coord: f32, coord_bits: i32, uv_bits: i32) -> (i32, i32) {
    let (lo, hi) = compute_non_normalized_coord_bounds(normalized, dim, coord, coord_bits, uv_bits);
    (lo.floor() as i32, hi.floor() as i32)
}

/// `tcu::isNearestSampleResultValid` for a 3D level, float colours.
///
/// True when *some* texel in the coordinate's uncertainty window matches the result.
/// That is deliberately permissive: the driver is allowed to have computed the
/// coordinate slightly differently, and the test is not about which texel it picked.
pub fn is_nearest_sample_result_valid_float(
    level: &ConstPixelBufferAccess<'_>,
    prec: &LookupPrecision,
    threshold: [f32; 4],
    coord: [f32; 3],
    result: [f32; 4],
) -> bool {
    let [w, h, d] = level.size();
    let (min_i, max_i) = candidate_range(true, w as i32, coord[0], prec.coord_bits[0], prec.uvw_bits[0]);
    let (min_j, max_j) = candidate_range(true, h as i32, coord[1], prec.coord_bits[1], prec.uvw_bits[1]);
    let (min_k, max_k) = candidate_range(true, d as i32, coord[2], prec.coord_bits[2], prec.uvw_bits[2]);

    for k in min_k..=max_k {
        for j in min_j..=max_j {
            for i in min_i..=max_i {
                let x = wrap(WrapMode::ClampToEdge, i, w as i32);
                let y = wrap(WrapMode::ClampToEdge, j, h as i32);
                let z = wrap(WrapMode::ClampToEdge, k, d as i32);
                let color = lookup_float(level, x, y, z, prec.border_color);
                if (0..4).all(|c| !prec.color_mask[c] || (color[c] - result[c]).abs() <= threshold[c]) {
                    return true;
                }
            }
        }
    }
    false
}

/// `tcu::isNearestSampleResultValid` for a 3D level, integer colours.
pub fn is_nearest_sample_result_valid_int(
    level: &ConstPixelBufferAccess<'_>,
    prec: &LookupPrecision,
    threshold: [u32; 4],
    coord: [f32; 3],
    result: [i32; 4],
) -> bool {
    let [w, h, d] = level.size();
    let (min_i, max_i) = candidate_range(true, w as i32, coord[0], prec.coord_bits[0], prec.uvw_bits[0]);
    let (min_j, max_j) = candidate_range(true, h as i32, coord[1], prec.coord_bits[1], prec.uvw_bits[1]);
    let (min_k, max_k) = candidate_range(true, d as i32, coord[2], prec.coord_bits[2], prec.uvw_bits[2]);

    for k in min_k..=max_k {
        for j in min_j..=max_j {
            for i in min_i..=max_i {
                let x = wrap(WrapMode::ClampToEdge, i, w as i32);
                let y = wrap(WrapMode::ClampToEdge, j, h as i32);
                let z = wrap(WrapMode::ClampToEdge, k, d as i32);
                let color = level.get_pixel_int(x as u32, y as u32, z as u32);
                if (0..4).all(|c| !prec.color_mask[c] || color[c].abs_diff(result[c]) <= threshold[c]) {
                    return true;
                }
            }
        }
    }
    false
}

/// `tcu::Sampler::ReductionMode` for the two modes that are not `WEIGHTED_AVERAGE`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ReductionMode {
    Min,
    Max,
}

thread_local! {
    static AMBIENT_REDUCTION: std::cell::Cell<Option<ReductionMode>> = const { std::cell::Cell::new(None) };
}

/// Holds the reduction mode of the sampler under verification while alive. Upstream reads it from the `Sampler` every lookup function takes; the
/// linear lookups here take no sampler, so the caller sets it around its verification instead (`None` is `WEIGHTED_AVERAGE`).
pub struct AmbientReduction {
    previous: Option<ReductionMode>,
}

impl AmbientReduction {
    pub fn enter(mode: Option<ReductionMode>) -> Self {
        Self {
            previous: AMBIENT_REDUCTION.with(|ambient| ambient.replace(mode)),
        }
    }
}

impl Drop for AmbientReduction {
    fn drop(&mut self) {
        AMBIENT_REDUCTION.with(|ambient| ambient.set(self.previous));
    }
}

fn ambient_reduction() -> Option<ReductionMode> {
    AMBIENT_REDUCTION.with(|ambient| ambient.get())
}

/// `isReductionValid` over the texels of one or two quads: the per-channel min or max of all of them
fn is_reduction_valid(prec: &LookupPrecision, quads: &[&ColorQuad], mode: ReductionMode, result: [f32; 4]) -> bool {
    let mut color = quads[0].p00;
    for quad in quads {
        for texel in [quad.p00, quad.p10, quad.p01, quad.p11] {
            for c in 0..4 {
                color[c] = match mode {
                    ReductionMode::Min => color[c].min(texel[c]),
                    ReductionMode::Max => color[c].max(texel[c]),
                };
            }
        }
    }
    is_color_valid(prec, color, result)
}

/// `ColorQuad` - the four texels a bilinear tap reads, named after the `(x,y)` offset
/// pair each one is read at (`p10` is the texel one step in `x`, zero in `y`), exactly
/// as upstream's `lookupQuad` assigns them.
struct ColorQuad {
    p00: [f32; 4],
    p10: [f32; 4],
    p01: [f32; 4],
    p11: [f32; 4],
}

fn lookup_quad(
    level: &ConstPixelBufferAccess<'_>,
    x0: i32,
    x1: i32,
    y0: i32,
    y1: i32,
    z: i32,
    border_color: [f32; 4],
) -> ColorQuad {
    ColorQuad {
        p00: lookup_float(level, x0, y0, z, border_color),
        p10: lookup_float(level, x1, y0, z, border_color),
        p01: lookup_float(level, x0, y1, z, border_color),
        p11: lookup_float(level, x1, y1, z, border_color),
    }
}

fn quad_min(quad: &ColorQuad) -> [f32; 4] {
    std::array::from_fn(|c| quad.p00[c].min(quad.p10[c]).min(quad.p01[c]).min(quad.p11[c]))
}

fn quad_max(quad: &ColorQuad) -> [f32; 4] {
    std::array::from_fn(|c| quad.p00[c].max(quad.p10[c]).max(quad.p01[c]).max(quad.p11[c]))
}

/// `isInColorBounds` (the `ColorQuad` overload) - a cheap necessary-but-not-sufficient
/// pre-check `is_bilinear_range_valid` runs before the real search: `result` has to be
/// within `colorThreshold` of the quad's own min/max per component, or no bilinear
/// blend of these four texels could ever produce it.
fn is_in_color_bounds(prec: &LookupPrecision, quad: &ColorQuad, result: [f32; 4]) -> bool {
    let min_val = quad_min(quad);
    let max_val = quad_max(quad);
    (0..4).all(|c| {
        !prec.color_mask[c]
            || (result[c] >= min_val[c] - prec.color_threshold[c] && result[c] <= max_val[c] + prec.color_threshold[c])
    })
}

/// `computeBilinearSearchStepFromFloatQuad` - for a floating-point format, the
/// threshold is a fixed colour tolerance rather than a fraction of the representable
/// range, so the blend-factor step the search below takes has to shrink with how far
/// apart the four texels actually are (a flat quad needs no fine search at all).
fn compute_bilinear_search_step_from_float_quad(prec: &LookupPrecision, quad: &ColorQuad) -> f32 {
    const MAX_STEPS: f32 = (1u32 << 16) as f32;
    let d0: [f32; 4] = std::array::from_fn(|c| (quad.p10[c] - quad.p00[c]).abs());
    let d1: [f32; 4] = std::array::from_fn(|c| (quad.p01[c] - quad.p00[c]).abs());
    let d2: [f32; 4] = std::array::from_fn(|c| (quad.p11[c] - quad.p10[c]).abs());
    let d3: [f32; 4] = std::array::from_fn(|c| (quad.p11[c] - quad.p01[c]).abs());
    let max_d: [f32; 4] = std::array::from_fn(|c| d0[c].max(d1[c]).max(d2[c]).max(d3[c]));
    let min_step = (0..4)
        .map(|c| 1.0 / (max_d[c] / prec.color_threshold[c] + 1.0))
        .fold(f32::INFINITY, f32::min);
    min_step.max(1.0 / MAX_STEPS)
}

/// `computeBilinearSearchStepForUnorm` - for a fixed-point format the quantization step
/// is known ahead of time (the representable range is always `[0,1]`), so this needs no
/// per-quad data at all, unlike the floating-point sibling above.
fn compute_bilinear_search_step_for_unorm(prec: &LookupPrecision) -> f32 {
    (0..4)
        .map(|c| 1.0 / (1.0 / prec.color_threshold[c] + 1.0))
        .fold(f32::INFINITY, f32::min)
}

/// `computeBilinearSearchStepForSnorm` - same as the UNORM case, but the representable
/// range is `[-1,1]`, twice as wide.
fn compute_bilinear_search_step_for_snorm(prec: &LookupPrecision) -> f32 {
    (0..4)
        .map(|c| 1.0 / (2.0 / prec.color_threshold[c] + 1.0))
        .fold(f32::INFINITY, f32::min)
}

/// `isLinearRangeValid` - a line-segment-vs-axis-aligned-box test: the exact (not
/// estimated) interpolation line between `c0` and `c1`, restricted to the driver's own
/// uncertainty window on the blend factor (`f_bounds`), has to pass within
/// `colorThreshold` of `result` in every unmasked channel simultaneously. Per channel,
/// "the line only ever stays on one side of the threshold window" rules the whole
/// result out; if no channel can rule it out, some blend factor in range is valid.
fn is_linear_range_valid(
    prec: &LookupPrecision,
    c0: [f32; 4],
    c1: [f32; 4],
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    let i0: [f32; 4] = std::array::from_fn(|c| c0[c] * (1.0 - f_bounds[0]) + c1[c] * f_bounds[0]);
    let i1: [f32; 4] = std::array::from_fn(|c| c0[c] * (1.0 - f_bounds[1]) + c1[c] * f_bounds[1]);

    for c in 0..4 {
        if !prec.color_mask[c] {
            continue;
        }
        let r_min = result[c] - prec.color_threshold[c];
        let r_max = result[c] + prec.color_threshold[c];

        let s_min0 = i0[c] >= r_min;
        let s_min1 = i1[c] >= r_min;
        let s_max0 = i0[c] > r_max;
        let s_max1 = i1[c] > r_max;

        if s_min0 == s_min1 && s_min1 == s_max0 && s_max0 == s_max1 {
            return false;
        }
    }
    true
}

/// `isBilinearRangeValid` - walks the quad's own uncertain blend-factor window
/// (`x_bounds`) at `search_step` and, at each sampled `x`, treats the two resulting
/// y-edge colours as a line segment checked by `is_linear_range_valid` over
/// `y_bounds`. The coarse quad-bounds pre-check (`is_in_color_bounds`) is what makes
/// this affordable - the search below is `O(1/search_step)`, and most results fail the
/// pre-check instantly.
#[allow(clippy::too_many_arguments)]
fn is_bilinear_range_valid(
    prec: &LookupPrecision,
    quad: &ColorQuad,
    x_bounds: [f32; 2],
    y_bounds: [f32; 2],
    search_step: f32,
    result: [f32; 4],
) -> bool {
    if !is_in_color_bounds(prec, quad, result) {
        return false;
    }

    let mut x = x_bounds[0];
    while x < x_bounds[1] + search_step {
        let a = x.min(x_bounds[1]);
        let c0: [f32; 4] = std::array::from_fn(|c| quad.p00[c] * (1.0 - a) + quad.p10[c] * a);
        let c1: [f32; 4] = std::array::from_fn(|c| quad.p01[c] * (1.0 - a) + quad.p11[c] * a);

        if is_linear_range_valid(prec, c0, c1, y_bounds, result) {
            return true;
        }
        x += search_step;
    }
    false
}

/// `tcu::isLinearSampleResultValid` for a single-level, 2D, `WEIGHTED_AVERAGE`-only
/// lookup - see this module's own top doc comment for exactly what's narrowed out of
/// upstream's full version (1D/3D/cube/array shapes, trilinear/mipmap blending). MIN/MAX
/// reduction comes from `AmbientReduction`, for the level samples only (no blending of two levels).
#[allow(clippy::too_many_arguments)]
pub fn is_linear_sample_result_valid_2d(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    result: [f32; 4],
) -> bool {
    let [w, h, _] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    let tex_class = level.format().channel_class();

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let x0 = wrap(wrap_s, i, w as i32);
            let x1 = wrap(wrap_s, i + 1, w as i32);
            let y0 = wrap(wrap_t, j, h as i32);
            let y1 = wrap(wrap_t, j + 1, h as i32);

            let min_a = ((u_lo - 0.5) - i as f32).clamp(0.0, 1.0);
            let max_a = ((u_hi - 0.5) - i as f32).clamp(0.0, 1.0);
            let min_b = ((v_lo - 0.5) - j as f32).clamp(0.0, 1.0);
            let max_b = ((v_hi - 0.5) - j as f32).clamp(0.0, 1.0);

            let quad = lookup_quad(level, x0, x1, y0, y1, coord_z, prec.border_color);
            if let Some(mode) = ambient_reduction() {
                if is_reduction_valid(prec, &[&quad], mode, result) {
                    return true;
                }
                continue;
            }
            let search_step = match tex_class {
                TextureChannelClass::UnsignedFixedPoint => compute_bilinear_search_step_for_unorm(prec),
                TextureChannelClass::SignedFixedPoint => compute_bilinear_search_step_for_snorm(prec),
                // Floating-point format: the step is derived from the quad's own texel
                // values rather than a fixed representable-range fraction.
                _ => compute_bilinear_search_step_from_float_quad(prec, &quad),
            };

            if is_bilinear_range_valid(prec, &quad, [min_a, max_a], [min_b, max_b], search_step, result) {
                return true;
            }
        }
    }
    false
}

/// `isColorValid(const LookupPrecision &, const Vec4 &, const Vec4 &)` - a plain
/// per-channel threshold compare, the simpler sibling of `is_in_color_bounds` (which
/// compares against a *quad's* own min/max range rather than one reference colour).
fn is_color_valid(prec: &LookupPrecision, reference: [f32; 4], result: [f32; 4]) -> bool {
    (0..4).all(|c| !prec.color_mask[c] || (reference[c] - result[c]).abs() <= prec.color_threshold[c])
}

/// `tcu::isNearestSampleResultValid` for a single 2D level (the `(Vec2, coordZ)`
/// overload) - the NEAREST sibling of `is_linear_sample_result_valid_2d` above, reading
/// `prec.color_threshold` through `is_color_valid` rather than an explicit `threshold`
/// argument (unlike this file's older `is_nearest_sample_result_valid_float`, ported
/// for the blit tests against a 3D level with `WrapMode::ClampToEdge` hardcoded).
#[allow(clippy::too_many_arguments)]
pub fn is_nearest_sample_result_valid_2d(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    result: [f32; 4],
) -> bool {
    let [w, h, _] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
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
            let color = lookup_float(level, x, y, coord_z, prec.border_color);
            if is_color_valid(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `isLevelSampleResultValid` (the `(Vec2, coordZ)` overload) - dispatches a single
/// level's own sample (not a mipmap blend) to the NEAREST or LINEAR check by the
/// filter mode that applies *at this level* (`getLevelFilter` already resolves away
/// the `*_MIPMAP_*` part before this is ever called with one of those).
#[allow(clippy::too_many_arguments)]
pub fn is_level_sample_result_valid_2d(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    filter: FilterMode,
    prec: &LookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    result: [f32; 4],
) -> bool {
    match filter {
        FilterMode::Linear => {
            is_linear_sample_result_valid_2d(level, wrap_s, wrap_t, normalized_coords, prec, coord, coord_z, result)
        }
        FilterMode::Nearest => {
            is_nearest_sample_result_valid_2d(level, wrap_s, wrap_t, normalized_coords, prec, coord, coord_z, result)
        }
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `isInColorBounds` (the two-`ColorQuad` overload) - the trilinear pre-check: a result
/// has to be within threshold of *either* level's own min/max range, or no blend of the
/// two mip levels could ever produce it.
fn is_in_color_bounds_two_quads(
    prec: &LookupPrecision,
    quad0: &ColorQuad,
    quad1: &ColorQuad,
    result: [f32; 4],
) -> bool {
    let min0 = quad_min(quad0);
    let max0 = quad_max(quad0);
    let min1 = quad_min(quad1);
    let max1 = quad_max(quad1);
    (0..4).all(|c| {
        !prec.color_mask[c]
            || (result[c] >= min0[c].min(min1[c]) - prec.color_threshold[c]
                && result[c] <= max0[c].max(max1[c]) + prec.color_threshold[c])
    })
}

/// `is2DTrilinearFilterResultValid` - the trilinear search: walk both levels' own
/// uncertain bilinear blend-factor windows (`x_bounds0`/`y_bounds0` for level 0,
/// `x_bounds1`/`y_bounds1` for level 1) and, at each sampled pair, check the two
/// resulting bilinear colours as a line segment over `z_bounds` (the mip-level blend
/// factor) via `is_linear_range_valid`. Upstream's own two inner loops are
/// deliberately asymmetric (the level-0 loop condition is `< bound + step`, the
/// level-1 one is `<= bound`) - kept exactly as upstream has it, not "fixed", per this
/// project's own rule for ported code.
#[allow(clippy::too_many_arguments)]
fn is_2d_trilinear_filter_result_valid(
    prec: &LookupPrecision,
    quad0: &ColorQuad,
    quad1: &ColorQuad,
    x_bounds0: [f32; 2],
    y_bounds0: [f32; 2],
    x_bounds1: [f32; 2],
    y_bounds1: [f32; 2],
    z_bounds: [f32; 2],
    search_step: f32,
    result: [f32; 4],
) -> bool {
    if !is_in_color_bounds_two_quads(prec, quad0, quad1, result) {
        return false;
    }

    let mut x0 = x_bounds0[0];
    while x0 < x_bounds0[1] + search_step {
        let a0 = x0.min(x_bounds0[1]);
        let mut y0 = y_bounds0[0];
        while y0 < y_bounds0[1] + search_step {
            let b0 = y0.min(y_bounds0[1]);
            let c0: [f32; 4] = std::array::from_fn(|c| {
                quad0.p00[c] * (1.0 - a0) * (1.0 - b0)
                    + quad0.p10[c] * a0 * (1.0 - b0)
                    + quad0.p01[c] * (1.0 - a0) * b0
                    + quad0.p11[c] * a0 * b0
            });

            let mut x1 = x_bounds1[0];
            while x1 <= x_bounds1[1] {
                let a1 = x1.min(x_bounds1[1]);
                let mut y1 = y_bounds1[0];
                while y1 <= y_bounds1[1] {
                    let b1 = y1.min(y_bounds1[1]);
                    let c1: [f32; 4] = std::array::from_fn(|c| {
                        quad1.p00[c] * (1.0 - a1) * (1.0 - b1)
                            + quad1.p10[c] * a1 * (1.0 - b1)
                            + quad1.p01[c] * (1.0 - a1) * b1
                            + quad1.p11[c] * a1 * b1
                    });

                    if is_linear_range_valid(prec, c0, c1, z_bounds, result) {
                        return true;
                    }
                    y1 += search_step;
                }
                x1 += search_step;
            }
            y0 += search_step;
        }
        x0 += search_step;
    }
    false
}

/// `isNearestMipmapLinearSampleResultValid` (the `(Vec2, coordZ)` overload) - the
/// NEAREST-within-level half of trilinear filtering (`NEAREST_MIPMAP_LINEAR`): each
/// candidate texel pair (one per level) is checked as a plain two-colour line segment
/// over the mip blend-factor window, no bilinear quad involved at either level.
#[allow(clippy::too_many_arguments)]
fn is_nearest_mipmap_linear_sample_result_valid_2d(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    let [w0, h0, _] = level0.size();
    let [w1, h1, _] = level1.size();

    let (u_lo0, u_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w0 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (u_lo1, u_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w1 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo0, v_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h0 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (v_lo1, v_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h1 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let (min_i0, max_i0) = (u_lo0.floor() as i32, u_hi0.floor() as i32);
    let (min_i1, max_i1) = (u_lo1.floor() as i32, u_hi1.floor() as i32);
    let (min_j0, max_j0) = (v_lo0.floor() as i32, v_hi0.floor() as i32);
    let (min_j1, max_j1) = (v_lo1.floor() as i32, v_hi1.floor() as i32);

    for j0 in min_j0..=max_j0 {
        for i0 in min_i0..=max_i0 {
            for j1 in min_j1..=max_j1 {
                for i1 in min_i1..=max_i1 {
                    let c0 = lookup_float(
                        level0,
                        wrap(wrap_s, i0, w0 as i32),
                        wrap(wrap_t, j0, h0 as i32),
                        coord_z,
                        prec.border_color,
                    );
                    let c1 = lookup_float(
                        level1,
                        wrap(wrap_s, i1, w1 as i32),
                        wrap(wrap_t, j1, h1 as i32),
                        coord_z,
                        prec.border_color,
                    );
                    if is_linear_range_valid(prec, c0, c1, f_bounds, result) {
                        return true;
                    }
                }
            }
        }
    }
    false
}

/// `isLinearMipmapLinearSampleResultValid` (the `(Vec2, coordZ)` overload) - full
/// trilinear: each level contributes its own bilinear quad (and its own, independently
/// derived search step), and `is_2d_trilinear_filter_result_valid` walks both quads'
/// blend-factor windows against the mip blend-factor window `f_bounds`. Upstream's own
/// comment above this function (kept as a doc comment here) notes the one known
/// imprecision: the two levels' candidate texel pairs are searched independently,
/// which is "strictly not correct as coordinates between levels should be dependent"
/// but is what every shipped driver is verified against regardless.
#[allow(clippy::too_many_arguments)]
fn is_linear_mipmap_linear_sample_result_valid_2d(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    let [w0, h0, _] = level0.size();
    let [w1, h1, _] = level1.size();

    let (u_lo0, u_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w0 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (u_lo1, u_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w1 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo0, v_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h0 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (v_lo1, v_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h1 as i32,
        coord[1],
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

    let tex_class = level0.format().channel_class();
    let c_search_step = match tex_class {
        TextureChannelClass::UnsignedFixedPoint => compute_bilinear_search_step_for_unorm(prec),
        TextureChannelClass::SignedFixedPoint => compute_bilinear_search_step_for_snorm(prec),
        _ => 0.0,
    };

    for j0 in min_j0..=max_j0 {
        for i0 in min_i0..=max_i0 {
            let x0 = wrap(wrap_s, i0, w0 as i32);
            let x1 = wrap(wrap_s, i0 + 1, w0 as i32);
            let y0 = wrap(wrap_t, j0, h0 as i32);
            let y1 = wrap(wrap_t, j0 + 1, h0 as i32);
            let quad0 = lookup_quad(level0, x0, x1, y0, y1, coord_z, prec.border_color);
            let search_step0 = if tex_class == TextureChannelClass::FloatingPoint {
                compute_bilinear_search_step_from_float_quad(prec, &quad0)
            } else {
                c_search_step
            };

            let min_a0 = ((u_lo0 - 0.5) - i0 as f32).clamp(0.0, 1.0);
            let max_a0 = ((u_hi0 - 0.5) - i0 as f32).clamp(0.0, 1.0);
            let min_b0 = ((v_lo0 - 0.5) - j0 as f32).clamp(0.0, 1.0);
            let max_b0 = ((v_hi0 - 0.5) - j0 as f32).clamp(0.0, 1.0);

            for j1 in min_j1..=max_j1 {
                for i1 in min_i1..=max_i1 {
                    let lx0 = wrap(wrap_s, i1, w1 as i32);
                    let lx1 = wrap(wrap_s, i1 + 1, w1 as i32);
                    let ly0 = wrap(wrap_t, j1, h1 as i32);
                    let ly1 = wrap(wrap_t, j1 + 1, h1 as i32);
                    let quad1 = lookup_quad(level1, lx0, lx1, ly0, ly1, coord_z, prec.border_color);
                    let search_step1 = if tex_class == TextureChannelClass::FloatingPoint {
                        compute_bilinear_search_step_from_float_quad(prec, &quad1)
                    } else {
                        c_search_step
                    };

                    let min_a1 = ((u_lo1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                    let max_a1 = ((u_hi1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                    let min_b1 = ((v_lo1 - 0.5) - j1 as f32).clamp(0.0, 1.0);
                    let max_b1 = ((v_hi1 - 0.5) - j1 as f32).clamp(0.0, 1.0);

                    if is_2d_trilinear_filter_result_valid(
                        prec,
                        &quad0,
                        &quad1,
                        [min_a0, max_a0],
                        [min_b0, max_b0],
                        [min_a1, max_a1],
                        [min_b1, max_b1],
                        f_bounds,
                        search_step0.min(search_step1),
                        result,
                    ) {
                        return true;
                    }
                }
            }
        }
    }
    false
}

/// `isMipmapLinearSampleResultValid` (the `(Vec2, coordZ)` overload) - dispatches the
/// trilinear blend to the NEAREST- or LINEAR-within-level search by the already-resolved
/// level filter (`getLevelFilter(sampler.minFilter)` upstream, `MinFilterMode::level_filter`
/// here).
#[allow(clippy::too_many_arguments)]
fn is_mipmap_linear_sample_result_valid_2d(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    level_filter: FilterMode,
    prec: &LookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    match level_filter {
        FilterMode::Linear => is_linear_mipmap_linear_sample_result_valid_2d(
            level0,
            level1,
            wrap_s,
            wrap_t,
            normalized_coords,
            prec,
            coord,
            coord_z,
            f_bounds,
            result,
        ),
        FilterMode::Nearest => is_nearest_mipmap_linear_sample_result_valid_2d(
            level0,
            level1,
            wrap_s,
            wrap_t,
            normalized_coords,
            prec,
            coord,
            coord_z,
            f_bounds,
            result,
        ),
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `tcu::Sampler::FilterMode`, narrowed to the `minFilter`-only variants (`magFilter` is
/// always `tcu::pixel::FilterMode::Nearest`/`Linear`, never a mipmap mode, so it keeps
/// using that smaller enum directly rather than this one). `Cubic`/`Cubic*` are not
/// represented at all - nothing in this crate ever needs them, matching
/// `is_level_sample_result_valid_2d`'s `unimplemented!` for `FilterMode::Cubic`.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum MinFilterMode {
    Nearest,
    Linear,
    NearestMipmapNearest,
    NearestMipmapLinear,
    LinearMipmapNearest,
    LinearMipmapLinear,
}

impl MinFilterMode {
    /// `isNearestMipmapFilter` - `pub(crate)` since `tcu::tex_compare_verifier`'s own
    /// `is_tex_compare_result_valid_2d` dispatcher needs the exact same mip-level
    /// selection this module's `is_lookup_result_valid_2d` already does.
    pub(crate) fn is_nearest_mipmap(self) -> bool {
        matches!(self, Self::NearestMipmapNearest | Self::LinearMipmapNearest)
    }

    /// `isLinearMipmapFilter`
    pub(crate) fn is_linear_mipmap(self) -> bool {
        matches!(self, Self::NearestMipmapLinear | Self::LinearMipmapLinear)
    }

    /// `getLevelFilter` - the filter a single level is sampled with, independent of
    /// whether (or how) two levels get blended together.
    pub(crate) fn level_filter(self) -> FilterMode {
        match self {
            Self::Nearest | Self::NearestMipmapNearest | Self::NearestMipmapLinear => FilterMode::Nearest,
            Self::Linear | Self::LinearMipmapNearest | Self::LinearMipmapLinear => FilterMode::Linear,
        }
    }
}

/// `tcu::LodPrecision`
pub struct LodPrecision {
    pub derivate_bits: i32,
    pub lod_bits: i32,
}

impl Default for LodPrecision {
    fn default() -> Self {
        Self {
            derivate_bits: 22,
            lod_bits: 16,
        }
    }
}

/// `tcu::computeLodBoundsFromDerivates` (the full 3-axis overload; the 1- and 2-axis
/// forms upstream provides are just this with the unused axes passed as `0.0`, which a
/// caller can do directly rather than needing three Rust overloads for it).
pub fn compute_lod_bounds_from_derivates(
    dudx: f32,
    dvdx: f32,
    dwdx: f32,
    dudy: f32,
    dvdy: f32,
    dwdy: f32,
    prec: &LodPrecision,
) -> (f32, f32) {
    let (mux, mvx, mwx) = (dudx.abs(), dvdx.abs(), dwdx.abs());
    let (muy, mvy, mwy) = (dudy.abs(), dvdy.abs(), dwdy.abs());

    let fx_min = mux.max(mvx).max(mwx);
    let fy_min = muy.max(mvy).max(mwy);

    let sqrt2 = std::f32::consts::SQRT_2;
    let fx_max = sqrt2 * (mux + mvx + mwx);
    let fy_max = sqrt2 * (muy + mvy + mwy);

    let p_min = fx_min.max(fy_min);
    let p_max = fx_max.max(fy_max);

    let p_min_err = compute_floating_point_error(p_min, prec.derivate_bits);
    let p_max_err = compute_floating_point_error(p_max, prec.derivate_bits);

    let min_lod = (p_min - p_min_err).log2();
    let max_lod = (p_max + p_max_err).log2();
    let lod_err = compute_fixed_point_error(prec.lod_bits);

    debug_assert!(min_lod <= max_lod);
    (min_lod - lod_err, max_lod + lod_err)
}

/// `tcu::clampLodBounds`
pub fn clamp_lod_bounds(lod_bounds: (f32, f32), lod_min_max: (f32, f32), prec: &LodPrecision) -> (f32, f32) {
    let lod_err = compute_fixed_point_error(prec.lod_bits);
    let (a, b) = lod_min_max;
    (
        lod_bounds.0.clamp(a - lod_err, b - lod_err),
        lod_bounds.1.clamp(a + lod_err, b + lod_err),
    )
}

/// `tcu::computeCubeLodBoundsFromDerivates` - the cube counterpart of
/// `compute_lod_bounds_from_derivates` above, needed by any cube-sampling verification
/// caller the same way that one is: `is_lookup_result_valid_cube` takes an already-
/// computed `lod_bounds` window rather than raw derivatives, and for a cube lookup this
/// is what turns a triangle's own `(coord, coordDx, coordDy)` derivatives into that
/// window. A cube lookup's `(s,t,r)` is a direction vector rather than a pair of
/// independent axes, so the two in-face derivatives have to be recovered first
/// (`select_cube_face` picks the major axis `ma`; the other two project onto the face's
/// own `s`/`t` the way `tcu::project_to_face` does for the coordinate itself, and this
/// is the derivative of that same projection by the quotient rule) before handing them
/// to the ordinary 2-axis `compute_lod_bounds_from_derivates`. Derivative signs don't
/// matter for a LOD estimate, so every `.abs()` here matches upstream exactly rather
/// than being simplified away - the same reasoning `glu::texture_test_util::
/// compute_cube_lod_from_derivates` (the `LodMode::Exact` reference-image sibling of
/// this function, confirmed to share this exact derivative-recovery formula) already
/// gives for its own identical `.abs()` calls.
///
/// Upstream's own `allowBrokenEdgeDerivate` branch is a `const bool` hardcoded to
/// `false` - dead code in every real build - and is not ported, matching this project's
/// usual treatment of a condition upstream itself never lets become true.
pub fn compute_cube_lod_bounds_from_derivates(
    coord: [f32; 3],
    coord_dx: [f32; 3],
    coord_dy: [f32; 3],
    face_size: i32,
    prec: &LodPrecision,
) -> (f32, f32) {
    let face = select_cube_face(coord);
    let (ma_ndx, s_ndx, t_ndx) = match face {
        CubeFace::NegativeX | CubeFace::PositiveX => (0, 2, 1),
        CubeFace::NegativeY | CubeFace::PositiveY => (1, 0, 2),
        CubeFace::NegativeZ | CubeFace::PositiveZ => (2, 0, 1),
    };

    let sc = coord[s_ndx];
    let tc = coord[t_ndx];
    let ma = coord[ma_ndx].abs();
    let scdx = coord_dx[s_ndx];
    let tcdx = coord_dx[t_ndx];
    let madx = coord_dx[ma_ndx].abs();
    let scdy = coord_dy[s_ndx];
    let tcdy = coord_dy[t_ndx];
    let mady = coord_dy[ma_ndx].abs();

    let face_size = face_size as f32;
    let dudx = face_size * 0.5 * (scdx * ma - sc * madx) / (ma * ma);
    let dvdx = face_size * 0.5 * (tcdx * ma - tc * madx) / (ma * ma);
    let dudy = face_size * 0.5 * (scdy * ma - sc * mady) / (ma * ma);
    let dvdy = face_size * 0.5 * (tcdy * ma - tc * mady) / (ma * ma);

    compute_lod_bounds_from_derivates(dudx, dvdx, 0.0, dudy, dvdy, 0.0, prec)
}

/// `tcu::isLookupResultValid` for `Texture2DView` - the capstone this whole module
/// builds toward: given the *entire* mip pyramid (`levels[0]` the base level, in
/// ascending order, exactly as `tcu::texture_2d::Texture2D::level(n)` already returns
/// them), the derived `lod_bounds` (from `compute_lod_bounds_from_derivates`/
/// `clamp_lod_bounds` above) and a `min_filter` naming every mipmap mode a 2D sampler
/// can legally have, decides whether `result` could be a conformant sample at `coord`.
/// `lod_threshold` is `Sampler::lodThreshold` - the lod value at and below which the
/// `mag_filter` applies instead of `min_filter` (upstream's own default is `0.0`, i.e.
/// "minified" starts as soon as lod is positive).
#[allow(clippy::too_many_arguments)]
pub fn is_lookup_result_valid_2d(
    levels: &[ConstPixelBufferAccess<'_>],
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    min_filter: MinFilterMode,
    mag_filter: FilterMode,
    lod_threshold: f32,
    prec: &LookupPrecision,
    coord: [f32; 2],
    lod_bounds: (f32, f32),
    result: [f32; 4],
) -> bool {
    debug_assert!(!levels.is_empty());
    let (min_lod, max_lod) = lod_bounds;
    let can_be_magnified = min_lod <= lod_threshold;
    let can_be_minified = max_lod > lod_threshold;

    if can_be_magnified
        && is_level_sample_result_valid_2d(
            &levels[0],
            wrap_s,
            wrap_t,
            normalized_coords,
            mag_filter,
            prec,
            coord,
            0,
            result,
        )
    {
        return true;
    }

    if can_be_minified {
        let min_tex_level = 0i32;
        let max_tex_level = levels.len() as i32 - 1;
        debug_assert!(min_tex_level <= max_tex_level);

        if min_filter.is_linear_mipmap() && min_tex_level < max_tex_level {
            let min_level = (min_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
            let max_level = (max_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
            debug_assert!(min_level <= max_level);

            for level in min_level..=max_level {
                let min_f = (min_lod - level as f32).clamp(0.0, 1.0);
                let max_f = (max_lod - level as f32).clamp(0.0, 1.0);
                if is_mipmap_linear_sample_result_valid_2d(
                    &levels[level as usize],
                    &levels[level as usize + 1],
                    wrap_s,
                    wrap_t,
                    normalized_coords,
                    min_filter.level_filter(),
                    prec,
                    coord,
                    0,
                    [min_f, max_f],
                    result,
                ) {
                    return true;
                }
            }
        } else if min_filter.is_nearest_mipmap() {
            // \note The accurate formula for nearest mipmapping is level = ceil(lod + 0.5) - 1
            //       but Khronos has made the decision to allow floor(lod + 0.5) as well.
            let min_level = (((min_lod + 0.5).ceil() as i32) - 1).clamp(min_tex_level, max_tex_level);
            let max_level = ((max_lod + 0.5).floor() as i32).clamp(min_tex_level, max_tex_level);
            debug_assert!(min_level <= max_level);

            for level in min_level..=max_level {
                if is_level_sample_result_valid_2d(
                    &levels[level as usize],
                    wrap_s,
                    wrap_t,
                    normalized_coords,
                    min_filter.level_filter(),
                    prec,
                    coord,
                    0,
                    result,
                ) {
                    return true;
                }
            }
        } else if is_level_sample_result_valid_2d(
            &levels[0],
            wrap_s,
            wrap_t,
            normalized_coords,
            min_filter.level_filter(),
            prec,
            coord,
            0,
            result,
        ) {
            return true;
        }
    }

    false
}

/// `computeLayerRange` - which array layers a layer coordinate could legally have
/// rounded to, given its own precision (`numCoordBits`). Shared by every array lookup
/// shape upstream has (1D array, 2D array, cube array); only the 2D array one is
/// ported here so far.
fn compute_layer_range(num_layers: i32, num_coord_bits: i32, layer_coord: f32) -> (i32, i32) {
    let err = compute_floating_point_error(layer_coord, num_coord_bits);
    let min_l = (layer_coord - err + 0.5).floor() as i32;
    let max_l = (layer_coord + err + 0.5).ceil() as i32 - 1;
    debug_assert!(min_l <= max_l);
    (min_l.clamp(0, num_layers - 1), max_l.clamp(0, num_layers - 1))
}

/// `tcu::isLookupResultValid` for `Texture2DArrayView` - `is_lookup_result_valid_2d`
/// widened with an outer layer loop: `coord_z` (the parameter every per-level/per-mip
/// helper function in this file already carries, unused by `is_lookup_result_valid_2d`
/// itself beyond `0`) is exactly upstream's own `layer` index here, so the per-layer
/// body is the *same* call upstream makes within `is_lookup_result_valid_2d`'s own
/// magnified/minified branches, just looped over `compute_layer_range` instead of fixed
/// at `0` - confirmed by reading `tcuTexLookupVerifier.cpp`'s own
/// `isLookupResultValid(Texture2DArrayView, ...)` directly rather than assumed from the
/// 2D shape (this file's own prior doc comment specifically warned not to).
#[allow(clippy::too_many_arguments)]
pub fn is_lookup_result_valid_2d_array(
    levels: &[ConstPixelBufferAccess<'_>],
    num_layers: i32,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    min_filter: MinFilterMode,
    mag_filter: FilterMode,
    lod_threshold: f32,
    prec: &LookupPrecision,
    coord: [f32; 3],
    lod_bounds: (f32, f32),
    result: [f32; 4],
) -> bool {
    debug_assert!(!levels.is_empty());
    let (min_lod, max_lod) = lod_bounds;
    let can_be_magnified = min_lod <= lod_threshold;
    let can_be_minified = max_lod > lod_threshold;
    let coord_xy = [coord[0], coord[1]];
    let (layer_min, layer_max) = compute_layer_range(num_layers, prec.coord_bits[2], coord[2]);

    for layer in layer_min..=layer_max {
        if can_be_magnified
            && is_level_sample_result_valid_2d(
                &levels[0],
                wrap_s,
                wrap_t,
                normalized_coords,
                mag_filter,
                prec,
                coord_xy,
                layer,
                result,
            )
        {
            return true;
        }

        if can_be_minified {
            let min_tex_level = 0i32;
            let max_tex_level = levels.len() as i32 - 1;
            debug_assert!(min_tex_level <= max_tex_level);

            if min_filter.is_linear_mipmap() && min_tex_level < max_tex_level {
                let min_level = (min_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
                let max_level = (max_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
                debug_assert!(min_level <= max_level);

                for level in min_level..=max_level {
                    let min_f = (min_lod - level as f32).clamp(0.0, 1.0);
                    let max_f = (max_lod - level as f32).clamp(0.0, 1.0);
                    if is_mipmap_linear_sample_result_valid_2d(
                        &levels[level as usize],
                        &levels[level as usize + 1],
                        wrap_s,
                        wrap_t,
                        normalized_coords,
                        min_filter.level_filter(),
                        prec,
                        coord_xy,
                        layer,
                        [min_f, max_f],
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
                    if is_level_sample_result_valid_2d(
                        &levels[level as usize],
                        wrap_s,
                        wrap_t,
                        normalized_coords,
                        min_filter.level_filter(),
                        prec,
                        coord_xy,
                        layer,
                        result,
                    ) {
                        return true;
                    }
                }
            } else if is_level_sample_result_valid_2d(
                &levels[0],
                wrap_s,
                wrap_t,
                normalized_coords,
                min_filter.level_filter(),
                prec,
                coord_xy,
                layer,
                result,
            ) {
                return true;
            }
        }
    }

    false
}

/// `isGatherOffsetsResultValid` - the ordinary-colour counterpart of `tex_compare_
/// verifier::is_gather_offsets_compare_result_valid` (same search shape: no mipmap axis
/// at all, textureGather always samples the base level, and all 4 of `offsets`' own taps
/// have to agree with their own slot in `result` simultaneously for a candidate `(i, j)`
/// to validate it). Unlike the compare sibling, there is no `execCompare`/PCF step -
/// each tap reads `component_ndx`'s own channel straight out of the texel
/// (`lookup_float(...)[component_ndx]`) and the resulting 4-tap vector is checked with
/// the plain per-slot threshold `is_color_valid` already provides for an ordinary 4-
/// channel colour compare - upstream's own body reuses `isColorValid` exactly this way
/// (confirmed directly against `tcuTexLookupVerifier.cpp`, not assumed), treating the
/// 4 gather slots as if they were 4 colour channels for the threshold check alone. The
/// `IntLookupPrecision` siblings (`is_gather_offsets_result_valid_int`/`_uint`, further
/// down this file) are the same shape with `is_color_valid_int`/`_uint` in place of
/// `is_color_valid` and `lookup_int`/`_uint` in place of `lookup_float`.
#[allow(clippy::too_many_arguments)]
fn is_gather_offsets_result_valid(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    result: [f32; 4],
) -> bool {
    let [w, h, _] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let mut color = [0.0f32; 4];
            for (off_ndx, offset) in offsets.iter().enumerate() {
                let x = wrap(wrap_s, i + offset[0], w as i32);
                let y = wrap(wrap_t, j + offset[1], h as i32);
                color[off_ndx] = lookup_float(level, x, y, coord_z, prec.border_color)[component_ndx];
            }
            if is_color_valid(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `isGatherOffsetsResultValid` for `Texture2DView`
#[allow(clippy::too_many_arguments)]
pub fn is_gather_offsets_result_valid_2d(
    texture: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 2],
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    result: [f32; 4],
) -> bool {
    is_gather_offsets_result_valid(
        texture,
        wrap_s,
        wrap_t,
        normalized_coords,
        prec,
        coord,
        0,
        component_ndx,
        offsets,
        result,
    )
}

/// `isGatherOffsetsResultValid` for `Texture2DArrayView` - the layer loop alone, no
/// level-selection ladder (gather has none to repeat), using the same `compute_layer_
/// range` the ordinary (non-gather) 2D-array lookup dispatcher already shares - unlike
/// `tex_compare_verifier`'s own 2D-array gather overload, which (per that function's own
/// doc comment) had to duplicate a *different* layer-range formula because the compare
/// verifier's own single-level dispatch never otherwise needed `compute_layer_range` at
/// all. This one does, so there is nothing to duplicate.
#[allow(clippy::too_many_arguments)]
pub fn is_gather_offsets_result_valid_2d_array(
    texture_level0: &ConstPixelBufferAccess<'_>,
    num_layers: i32,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 3],
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    result: [f32; 4],
) -> bool {
    let (layer_min, layer_max) = compute_layer_range(num_layers, prec.coord_bits[2], coord[2]);
    let coord_xy = [coord[0], coord[1]];
    for layer in layer_min..=layer_max {
        if is_gather_offsets_result_valid(
            texture_level0,
            wrap_s,
            wrap_t,
            normalized_coords,
            prec,
            coord_xy,
            layer,
            component_ndx,
            offsets,
            result,
        ) {
            return true;
        }
    }
    false
}

/// `isGatherResultValid` for `TextureCubeView`'s own internal `(faces, CubeFaceFloatCoords)`
/// overload - **not** a clamp-to-edge tap like the ordinary (non-cube) gather helper
/// above: confirmed directly against upstream's own body, cube gather always
/// seam-remaps each of its 4 taps individually via `remap_cube_edge_coords`, exactly the
/// way `tex_compare_verifier::is_gather_compare_result_valid_cube_face` already does for
/// the compare case (this is its ordinary-colour sibling - no `execCompare`, straight
/// `is_color_valid` on the 4-tap vector instead). A tap landing on a true corner (owned
/// by no single neighbour) makes the whole candidate undefined - accepted
/// unconditionally, same as every other seam-remap case in this file. There is no
/// `seamless_cube_map` branch here at all: upstream's own `isGatherResultValid` for
/// `TextureCubeView` never reads `sampler.seamlessCubeMap`, so cube gather always
/// seam-remaps regardless of that setting.
fn is_gather_result_valid_cube_face(
    faces: &[ConstPixelBufferAccess<'_>; 6],
    normalized_coords: bool,
    prec: &LookupPrecision,
    coords: &CubeFaceFloatCoords,
    component_ndx: usize,
    result: [f32; 4],
) -> bool {
    const OFFSETS: [[i32; 2]; 4] = [[0, 1], [1, 1], [1, 0], [0, 0]];
    let size = faces[get_cube_face_slot(coords.face)].size()[0] as i32;

    let (u_lo, u_hi) =
        compute_non_normalized_coord_bounds(normalized_coords, size, coords.s, prec.coord_bits[0], prec.uvw_bits[0]);
    let (v_lo, v_hi) =
        compute_non_normalized_coord_bounds(normalized_coords, size, coords.t, prec.coord_bits[1], prec.uvw_bits[1]);

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let mut color = [0.0f32; 4];
            for (off_ndx, offset) in OFFSETS.iter().enumerate() {
                let Some((face, s, t)) = remap_cube_edge_coords(coords.face, i + offset[0], j + offset[1], size) else {
                    return true;
                };
                color[off_ndx] =
                    lookup_float(&faces[get_cube_face_slot(face)], s, t, 0, prec.border_color)[component_ndx];
            }
            if is_color_valid(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `isGatherResultValid` for `TextureCubeView` - tried against every face
/// `get_possible_cube_faces` names, same as every other cube dispatcher in this file.
pub fn is_gather_result_valid_cube(
    level0: &ConstPixelBufferAccess<'_>,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 3],
    component_ndx: usize,
    result: [f32; 4],
) -> bool {
    const ORDER: [CubeFace; 6] = [
        CubeFace::NegativeX,
        CubeFace::PositiveX,
        CubeFace::NegativeY,
        CubeFace::PositiveY,
        CubeFace::NegativeZ,
        CubeFace::PositiveZ,
    ];
    let [w, h, _] = level0.size();
    let faces: [ConstPixelBufferAccess<'_>; 6] =
        std::array::from_fn(|slot| level0.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w, h, 1));

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
        if is_gather_result_valid_cube_face(&faces, normalized_coords, prec, &coords, component_ndx, result) {
            return true;
        }
    }
    false
}

/// `tcu::isNearestSampleResultValid` for a single-level, 3D lookup - the `is_nearest_
/// sample_result_valid_2d` shape with a third (`wrap_r`/depth) axis added, confirmed
/// directly against upstream's own `Vec3`-coordinate overload rather than guessed by
/// extrapolating the 2D one.
#[allow(clippy::too_many_arguments)]
pub fn is_nearest_sample_result_valid_3d(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 3],
    result: [f32; 4],
) -> bool {
    let [w, h, d] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (w_lo, w_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        d as i32,
        coord[2],
        prec.coord_bits[2],
        prec.uvw_bits[2],
    );

    let min_i = u_lo.floor() as i32;
    let max_i = u_hi.floor() as i32;
    let min_j = v_lo.floor() as i32;
    let max_j = v_hi.floor() as i32;
    let min_k = w_lo.floor() as i32;
    let max_k = w_hi.floor() as i32;

    for k in min_k..=max_k {
        for j in min_j..=max_j {
            for i in min_i..=max_i {
                let x = wrap(wrap_s, i, w as i32);
                let y = wrap(wrap_t, j, h as i32);
                let z = wrap(wrap_r, k, d as i32);
                let color = lookup_float(level, x, y, z, prec.border_color);
                if is_color_valid(prec, color, result) {
                    return true;
                }
            }
        }
    }
    false
}

/// `isTrilinearRangeValid` - blends two z-adjacent bilinear quads built from the
/// *same* level (so they share one in-plane texel grid and therefore one in-plane
/// blend fraction `(a, b)`) over a `z_bounds` window - the within-level-3D-linear-filter
/// counterpart of `is_bilinear_range_valid`, one axis wider.
///
/// Deliberately **not** the same function as `is_2d_trilinear_filter_result_valid`
/// (used only for a cross-*mip-level* blend, where the two quads come from
/// differently-sized levels and so each needs its own, independent in-plane blend
/// fraction) - confirmed by reading `tcuTexLookupVerifier.cpp` directly:
/// `isTrilinearRangeValid` and `is2DTrilinearFilterResultValid` are two separate
/// upstream functions, this one taking a single `(x_bounds, y_bounds)` pair rather than
/// one per quad. Passing equal bounds to the other function would still *accept* every
/// value a real driver could produce (the true shared-fraction answer is a special
/// case of the independent-fraction search), but would also accept some values a
/// shared-fraction search would correctly reject - porting this as its own function
/// keeps the two lookup shapes exactly as strict as upstream has them.
#[allow(clippy::too_many_arguments)]
fn is_trilinear_range_valid(
    prec: &LookupPrecision,
    quad0: &ColorQuad,
    quad1: &ColorQuad,
    x_bounds: [f32; 2],
    y_bounds: [f32; 2],
    z_bounds: [f32; 2],
    search_step: f32,
    result: [f32; 4],
) -> bool {
    if !is_in_color_bounds_two_quads(prec, quad0, quad1, result) {
        return false;
    }

    let mut x = x_bounds[0];
    while x < x_bounds[1] + search_step {
        let a = x.min(x_bounds[1]);
        let mut y = y_bounds[0];
        while y < y_bounds[1] + search_step {
            let b = y.min(y_bounds[1]);
            let c0: [f32; 4] = std::array::from_fn(|c| {
                quad0.p00[c] * (1.0 - a) * (1.0 - b)
                    + quad0.p10[c] * a * (1.0 - b)
                    + quad0.p01[c] * (1.0 - a) * b
                    + quad0.p11[c] * a * b
            });
            let c1: [f32; 4] = std::array::from_fn(|c| {
                quad1.p00[c] * (1.0 - a) * (1.0 - b)
                    + quad1.p10[c] * a * (1.0 - b)
                    + quad1.p01[c] * (1.0 - a) * b
                    + quad1.p11[c] * a * b
            });
            if is_linear_range_valid(prec, c0, c1, z_bounds, result) {
                return true;
            }
            y += search_step;
        }
        x += search_step;
    }
    false
}

/// `tcu::isLinearSampleResultValid` for a single-level, 3D lookup - the within-level
/// trilinear filter. Each candidate `(i, j, k)` texel triple builds two z-adjacent
/// bilinear quads at `z0`/`z1` (same `x0,x1,y0,y1`, since both come from this one
/// level) and searches their shared in-plane blend fraction against the z blend-factor
/// window via `is_trilinear_range_valid` - confirmed directly against upstream's own
/// `Vec3`-coordinate overload of `isLinearSampleResultValid`.
#[allow(clippy::too_many_arguments)]
pub fn is_linear_sample_result_valid_3d(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 3],
    result: [f32; 4],
) -> bool {
    let [w, h, d] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (w_lo, w_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        d as i32,
        coord[2],
        prec.coord_bits[2],
        prec.uvw_bits[2],
    );

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;
    let min_k = (w_lo - 0.5).floor() as i32;
    let max_k = (w_hi - 0.5).floor() as i32;

    let tex_class = level.format().channel_class();

    for k in min_k..=max_k {
        let z0 = wrap(wrap_r, k, d as i32);
        let z1 = wrap(wrap_r, k + 1, d as i32);
        let min_c = ((w_lo - 0.5) - k as f32).clamp(0.0, 1.0);
        let max_c = ((w_hi - 0.5) - k as f32).clamp(0.0, 1.0);

        for j in min_j..=max_j {
            for i in min_i..=max_i {
                let x0 = wrap(wrap_s, i, w as i32);
                let x1 = wrap(wrap_s, i + 1, w as i32);
                let y0 = wrap(wrap_t, j, h as i32);
                let y1 = wrap(wrap_t, j + 1, h as i32);

                let min_a = ((u_lo - 0.5) - i as f32).clamp(0.0, 1.0);
                let max_a = ((u_hi - 0.5) - i as f32).clamp(0.0, 1.0);
                let min_b = ((v_lo - 0.5) - j as f32).clamp(0.0, 1.0);
                let max_b = ((v_hi - 0.5) - j as f32).clamp(0.0, 1.0);

                let quad0 = lookup_quad(level, x0, x1, y0, y1, z0, prec.border_color);
                let quad1 = lookup_quad(level, x0, x1, y0, y1, z1, prec.border_color);

                if let Some(mode) = ambient_reduction() {
                    if is_reduction_valid(prec, &[&quad0, &quad1], mode, result) {
                        return true;
                    }
                    continue;
                }

                let search_step = match tex_class {
                    TextureChannelClass::UnsignedFixedPoint => compute_bilinear_search_step_for_unorm(prec),
                    TextureChannelClass::SignedFixedPoint => compute_bilinear_search_step_for_snorm(prec),
                    _ => compute_bilinear_search_step_from_float_quad(prec, &quad0)
                        .min(compute_bilinear_search_step_from_float_quad(prec, &quad1)),
                };

                if is_trilinear_range_valid(
                    prec,
                    &quad0,
                    &quad1,
                    [min_a, max_a],
                    [min_b, max_b],
                    [min_c, max_c],
                    search_step,
                    result,
                ) {
                    return true;
                }
            }
        }
    }
    false
}

/// `isLevelSampleResultValid` (the `Vec3`-coordinate, 3D overload) - dispatches a
/// single level's own sample to the NEAREST or LINEAR check by the filter mode that
/// applies *at this level*, matching `is_level_sample_result_valid_2d`'s own role.
#[allow(clippy::too_many_arguments)]
pub fn is_level_sample_result_valid_3d(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    filter: FilterMode,
    prec: &LookupPrecision,
    coord: [f32; 3],
    result: [f32; 4],
) -> bool {
    match filter {
        FilterMode::Linear => {
            is_linear_sample_result_valid_3d(level, wrap_s, wrap_t, wrap_r, normalized_coords, prec, coord, result)
        }
        FilterMode::Nearest => {
            is_nearest_sample_result_valid_3d(level, wrap_s, wrap_t, wrap_r, normalized_coords, prec, coord, result)
        }
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `isInColorBounds` (the four-`ColorQuad` overload) - the pre-check for the full
/// cross-mip-level 3D trilinear search: a result has to be within threshold of *some*
/// one of all four quads' own min/max range (both z-slices of both levels), or no
/// blend of them could ever produce it.
fn is_in_color_bounds_four_quads(
    prec: &LookupPrecision,
    quad00: &ColorQuad,
    quad01: &ColorQuad,
    quad10: &ColorQuad,
    quad11: &ColorQuad,
    result: [f32; 4],
) -> bool {
    let (min00, max00) = (quad_min(quad00), quad_max(quad00));
    let (min01, max01) = (quad_min(quad01), quad_max(quad01));
    let (min10, max10) = (quad_min(quad10), quad_max(quad10));
    let (min11, max11) = (quad_min(quad11), quad_max(quad11));
    (0..4).all(|c| {
        !prec.color_mask[c] || {
            let min_val = min00[c].min(min01[c]).min(min10[c]).min(min11[c]);
            let max_val = max00[c].max(max01[c]).max(max10[c]).max(max11[c]);
            result[c] >= min_val - prec.color_threshold[c] && result[c] <= max_val + prec.color_threshold[c]
        }
    })
}

/// `isNearestMipmapLinearSampleResultValid` (the `Vec3`-coordinate, 3D overload) - the
/// NEAREST-within-level half of cross-mip-level 3D trilinear filtering: each candidate
/// texel triple pair (one per level) is checked as a plain two-colour line segment over
/// the mip blend-factor window, no bilinear/trilinear quad involved at either level -
/// confirmed directly against upstream's own `Vec3`-coordinate overload, the same shape
/// as `is_nearest_mipmap_linear_sample_result_valid_2d` one axis wider.
#[allow(clippy::too_many_arguments)]
fn is_nearest_mipmap_linear_sample_result_valid_3d(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 3],
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    let [w0, h0, d0] = level0.size();
    let [w1, h1, d1] = level1.size();

    let (u_lo0, u_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w0 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (u_lo1, u_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w1 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo0, v_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h0 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (v_lo1, v_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h1 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (w_lo0, w_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        d0 as i32,
        coord[2],
        prec.coord_bits[2],
        prec.uvw_bits[2],
    );
    let (w_lo1, w_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        d1 as i32,
        coord[2],
        prec.coord_bits[2],
        prec.uvw_bits[2],
    );

    let (min_i0, max_i0) = (u_lo0.floor() as i32, u_hi0.floor() as i32);
    let (min_i1, max_i1) = (u_lo1.floor() as i32, u_hi1.floor() as i32);
    let (min_j0, max_j0) = (v_lo0.floor() as i32, v_hi0.floor() as i32);
    let (min_j1, max_j1) = (v_lo1.floor() as i32, v_hi1.floor() as i32);
    let (min_k0, max_k0) = (w_lo0.floor() as i32, w_hi0.floor() as i32);
    let (min_k1, max_k1) = (w_lo1.floor() as i32, w_hi1.floor() as i32);

    for k0 in min_k0..=max_k0 {
        for j0 in min_j0..=max_j0 {
            for i0 in min_i0..=max_i0 {
                for k1 in min_k1..=max_k1 {
                    for j1 in min_j1..=max_j1 {
                        for i1 in min_i1..=max_i1 {
                            let c0 = lookup_float(
                                level0,
                                wrap(wrap_s, i0, w0 as i32),
                                wrap(wrap_t, j0, h0 as i32),
                                wrap(wrap_r, k0, d0 as i32),
                                prec.border_color,
                            );
                            let c1 = lookup_float(
                                level1,
                                wrap(wrap_s, i1, w1 as i32),
                                wrap(wrap_t, j1, h1 as i32),
                                wrap(wrap_r, k1, d1 as i32),
                                prec.border_color,
                            );
                            if is_linear_range_valid(prec, c0, c1, f_bounds, result) {
                                return true;
                            }
                        }
                    }
                }
            }
        }
    }
    false
}

/// `is3DTrilinearFilterResultValid` - the full cross-mip-level 3D trilinear search:
/// each level contributes two z-adjacent bilinear quads (`quad00`/`quad01` for level
/// 0's own `z0`/`z1` slices, `quad10`/`quad11` for level 1's), each pair blended
/// in-plane with its own independent `(a,b)` fraction (same per-level independence
/// `is_2d_trilinear_filter_result_valid` already has, upstream's own noted
/// imprecision), then along `z` within each level (`z_bounds0`/`z_bounds1`), and
/// finally the two single-level results blended across the mip-level window
/// (`w_bounds`) - confirmed directly against upstream's own six-nested-loop body
/// rather than assumed from the 2D/within-level-3D shapes. All six loops (level-0
/// `x0`/`y0`/`z0`, level-1 `x1`/`y1`/`z1`) use the same `< bound + search_step`
/// condition, unlike `is_2d_trilinear_filter_result_valid`'s asymmetric level-0-vs-
/// level-1 loop shape - kept exactly as upstream has it.
#[allow(clippy::too_many_arguments)]
fn is_3d_trilinear_filter_result_valid(
    prec: &LookupPrecision,
    quad00: &ColorQuad,
    quad01: &ColorQuad,
    quad10: &ColorQuad,
    quad11: &ColorQuad,
    x_bounds0: [f32; 2],
    y_bounds0: [f32; 2],
    z_bounds0: [f32; 2],
    x_bounds1: [f32; 2],
    y_bounds1: [f32; 2],
    z_bounds1: [f32; 2],
    w_bounds: [f32; 2],
    search_step: f32,
    result: [f32; 4],
) -> bool {
    if !is_in_color_bounds_four_quads(prec, quad00, quad01, quad10, quad11, result) {
        return false;
    }

    let bilerp = |quad: &ColorQuad, a: f32, b: f32| -> [f32; 4] {
        std::array::from_fn(|c| {
            quad.p00[c] * (1.0 - a) * (1.0 - b)
                + quad.p10[c] * a * (1.0 - b)
                + quad.p01[c] * (1.0 - a) * b
                + quad.p11[c] * a * b
        })
    };

    let mut x0 = x_bounds0[0];
    while x0 < x_bounds0[1] + search_step {
        let a0 = x0.min(x_bounds0[1]);
        let mut y0 = y_bounds0[0];
        while y0 < y_bounds0[1] + search_step {
            let b0 = y0.min(y_bounds0[1]);
            let c00 = bilerp(quad00, a0, b0);
            let c01 = bilerp(quad01, a0, b0);

            let mut z0 = z_bounds0[0];
            while z0 < z_bounds0[1] + search_step {
                let cc0 = z0.min(z_bounds0[1]);
                let cz0: [f32; 4] = std::array::from_fn(|c| c00[c] * (1.0 - cc0) + c01[c] * cc0);

                let mut x1 = x_bounds1[0];
                while x1 < x_bounds1[1] + search_step {
                    let a1 = x1.min(x_bounds1[1]);
                    let mut y1 = y_bounds1[0];
                    while y1 < y_bounds1[1] + search_step {
                        let b1 = y1.min(y_bounds1[1]);
                        let c10 = bilerp(quad10, a1, b1);
                        let c11 = bilerp(quad11, a1, b1);

                        let mut z1 = z_bounds1[0];
                        while z1 < z_bounds1[1] + search_step {
                            let cc1 = z1.min(z_bounds1[1]);
                            let cz1: [f32; 4] = std::array::from_fn(|c| c10[c] * (1.0 - cc1) + c11[c] * cc1);

                            if is_linear_range_valid(prec, cz0, cz1, w_bounds, result) {
                                return true;
                            }
                            z1 += search_step;
                        }
                        y1 += search_step;
                    }
                    x1 += search_step;
                }
                z0 += search_step;
            }
            y0 += search_step;
        }
        x0 += search_step;
    }
    false
}

/// `isLinearMipmapLinearSampleResultValid` (the `Vec3`-coordinate, 3D overload) - full
/// cross-mip-level trilinear: each level contributes its own pair of z-adjacent
/// bilinear quads (and its own, independently derived search step, the minimum over
/// both of that level's quads), and `is_3d_trilinear_filter_result_valid` walks all
/// four quads' blend-factor windows against the mip blend-factor window `f_bounds`.
/// Same "coordinates between levels should be dependent" imprecision upstream's own
/// comment notes on every sibling of this shape.
#[allow(clippy::too_many_arguments)]
fn is_linear_mipmap_linear_sample_result_valid_3d(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    prec: &LookupPrecision,
    coord: [f32; 3],
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    let [w0, h0, d0] = level0.size();
    let [w1, h1, d1] = level1.size();

    let (u_lo0, u_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w0 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (u_lo1, u_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w1 as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo0, v_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h0 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (v_lo1, v_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h1 as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (w_lo0, w_hi0) = compute_non_normalized_coord_bounds(
        normalized_coords,
        d0 as i32,
        coord[2],
        prec.coord_bits[2],
        prec.uvw_bits[2],
    );
    let (w_lo1, w_hi1) = compute_non_normalized_coord_bounds(
        normalized_coords,
        d1 as i32,
        coord[2],
        prec.coord_bits[2],
        prec.uvw_bits[2],
    );

    let min_i0 = (u_lo0 - 0.5).floor() as i32;
    let max_i0 = (u_hi0 - 0.5).floor() as i32;
    let min_i1 = (u_lo1 - 0.5).floor() as i32;
    let max_i1 = (u_hi1 - 0.5).floor() as i32;
    let min_j0 = (v_lo0 - 0.5).floor() as i32;
    let max_j0 = (v_hi0 - 0.5).floor() as i32;
    let min_j1 = (v_lo1 - 0.5).floor() as i32;
    let max_j1 = (v_hi1 - 0.5).floor() as i32;
    let min_k0 = (w_lo0 - 0.5).floor() as i32;
    let max_k0 = (w_hi0 - 0.5).floor() as i32;
    let min_k1 = (w_lo1 - 0.5).floor() as i32;
    let max_k1 = (w_hi1 - 0.5).floor() as i32;

    let tex_class = level0.format().channel_class();
    let c_search_step = match tex_class {
        TextureChannelClass::UnsignedFixedPoint => compute_bilinear_search_step_for_unorm(prec),
        TextureChannelClass::SignedFixedPoint => compute_bilinear_search_step_for_snorm(prec),
        _ => 0.0,
    };

    for k0 in min_k0..=max_k0 {
        for j0 in min_j0..=max_j0 {
            for i0 in min_i0..=max_i0 {
                let x0 = wrap(wrap_s, i0, w0 as i32);
                let x1 = wrap(wrap_s, i0 + 1, w0 as i32);
                let y0 = wrap(wrap_t, j0, h0 as i32);
                let y1 = wrap(wrap_t, j0 + 1, h0 as i32);
                let z0 = wrap(wrap_r, k0, d0 as i32);
                let z1 = wrap(wrap_r, k0 + 1, d0 as i32);
                let quad00 = lookup_quad(level0, x0, x1, y0, y1, z0, prec.border_color);
                let quad01 = lookup_quad(level0, x0, x1, y0, y1, z1, prec.border_color);
                let search_step0 = if tex_class == TextureChannelClass::FloatingPoint {
                    compute_bilinear_search_step_from_float_quad(prec, &quad00)
                        .min(compute_bilinear_search_step_from_float_quad(prec, &quad01))
                } else {
                    c_search_step
                };

                let min_a0 = ((u_lo0 - 0.5) - i0 as f32).clamp(0.0, 1.0);
                let max_a0 = ((u_hi0 - 0.5) - i0 as f32).clamp(0.0, 1.0);
                let min_b0 = ((v_lo0 - 0.5) - j0 as f32).clamp(0.0, 1.0);
                let max_b0 = ((v_hi0 - 0.5) - j0 as f32).clamp(0.0, 1.0);
                let min_c0 = ((w_lo0 - 0.5) - k0 as f32).clamp(0.0, 1.0);
                let max_c0 = ((w_hi0 - 0.5) - k0 as f32).clamp(0.0, 1.0);

                for k1 in min_k1..=max_k1 {
                    for j1 in min_j1..=max_j1 {
                        for i1 in min_i1..=max_i1 {
                            let lx0 = wrap(wrap_s, i1, w1 as i32);
                            let lx1 = wrap(wrap_s, i1 + 1, w1 as i32);
                            let ly0 = wrap(wrap_t, j1, h1 as i32);
                            let ly1 = wrap(wrap_t, j1 + 1, h1 as i32);
                            let lz0 = wrap(wrap_r, k1, d1 as i32);
                            let lz1 = wrap(wrap_r, k1 + 1, d1 as i32);
                            let quad10 = lookup_quad(level1, lx0, lx1, ly0, ly1, lz0, prec.border_color);
                            let quad11 = lookup_quad(level1, lx0, lx1, ly0, ly1, lz1, prec.border_color);
                            let search_step1 = if tex_class == TextureChannelClass::FloatingPoint {
                                compute_bilinear_search_step_from_float_quad(prec, &quad10)
                                    .min(compute_bilinear_search_step_from_float_quad(prec, &quad11))
                            } else {
                                c_search_step
                            };

                            let min_a1 = ((u_lo1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                            let max_a1 = ((u_hi1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                            let min_b1 = ((v_lo1 - 0.5) - j1 as f32).clamp(0.0, 1.0);
                            let max_b1 = ((v_hi1 - 0.5) - j1 as f32).clamp(0.0, 1.0);
                            let min_c1 = ((w_lo1 - 0.5) - k1 as f32).clamp(0.0, 1.0);
                            let max_c1 = ((w_hi1 - 0.5) - k1 as f32).clamp(0.0, 1.0);

                            if is_3d_trilinear_filter_result_valid(
                                prec,
                                &quad00,
                                &quad01,
                                &quad10,
                                &quad11,
                                [min_a0, max_a0],
                                [min_b0, max_b0],
                                [min_c0, max_c0],
                                [min_a1, max_a1],
                                [min_b1, max_b1],
                                [min_c1, max_c1],
                                f_bounds,
                                search_step0.min(search_step1),
                                result,
                            ) {
                                return true;
                            }
                        }
                    }
                }
            }
        }
    }
    false
}

/// `isMipmapLinearSampleResultValid` (the `Vec3`-coordinate, 3D overload) - dispatches
/// the cross-mip-level trilinear blend to the NEAREST- or LINEAR-within-level search by
/// the already-resolved level filter, matching `is_mipmap_linear_sample_result_valid_2d`'s
/// own role.
#[allow(clippy::too_many_arguments)]
fn is_mipmap_linear_sample_result_valid_3d(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    level_filter: FilterMode,
    prec: &LookupPrecision,
    coord: [f32; 3],
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    match level_filter {
        FilterMode::Linear => is_linear_mipmap_linear_sample_result_valid_3d(
            level0,
            level1,
            wrap_s,
            wrap_t,
            wrap_r,
            normalized_coords,
            prec,
            coord,
            f_bounds,
            result,
        ),
        FilterMode::Nearest => is_nearest_mipmap_linear_sample_result_valid_3d(
            level0,
            level1,
            wrap_s,
            wrap_t,
            wrap_r,
            normalized_coords,
            prec,
            coord,
            f_bounds,
            result,
        ),
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `tcu::isLookupResultValid` for `Texture3DView` - mirrors `is_lookup_result_valid_2d`'s
/// own magnified/minified dispatch (confirmed directly against upstream's own
/// `Texture3DView` overload, which has exactly that same shape). Every `MinFilterMode`
/// is now ported, including `NearestMipmapLinear`/`LinearMipmapLinear` (true trilinear
/// *across mip levels*, via `is_mipmap_linear_sample_result_valid_3d`/
/// `is_3d_trilinear_filter_result_valid`).
#[allow(clippy::too_many_arguments)]
pub fn is_lookup_result_valid_3d(
    levels: &[ConstPixelBufferAccess<'_>],
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    min_filter: MinFilterMode,
    mag_filter: FilterMode,
    lod_threshold: f32,
    prec: &LookupPrecision,
    coord: [f32; 3],
    lod_bounds: (f32, f32),
    result: [f32; 4],
) -> bool {
    debug_assert!(!levels.is_empty());
    let (min_lod, max_lod) = lod_bounds;
    let can_be_magnified = min_lod <= lod_threshold;
    let can_be_minified = max_lod > lod_threshold;

    if can_be_magnified
        && is_level_sample_result_valid_3d(
            &levels[0],
            wrap_s,
            wrap_t,
            wrap_r,
            normalized_coords,
            mag_filter,
            prec,
            coord,
            result,
        )
    {
        return true;
    }

    if can_be_minified {
        let min_tex_level = 0i32;
        let max_tex_level = levels.len() as i32 - 1;
        debug_assert!(min_tex_level <= max_tex_level);

        if min_filter.is_linear_mipmap() && min_tex_level < max_tex_level {
            let min_level = (min_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
            let max_level = (max_lod.floor() as i32).clamp(min_tex_level, max_tex_level - 1);
            debug_assert!(min_level <= max_level);

            for level in min_level..=max_level {
                let min_f = (min_lod - level as f32).clamp(0.0, 1.0);
                let max_f = (max_lod - level as f32).clamp(0.0, 1.0);
                if is_mipmap_linear_sample_result_valid_3d(
                    &levels[level as usize],
                    &levels[level as usize + 1],
                    wrap_s,
                    wrap_t,
                    wrap_r,
                    normalized_coords,
                    min_filter.level_filter(),
                    prec,
                    coord,
                    [min_f, max_f],
                    result,
                ) {
                    return true;
                }
            }
        } else if min_filter.is_nearest_mipmap() {
            // \note The accurate formula for nearest mipmapping is level = ceil(lod + 0.5) - 1
            //       but Khronos has made the decision to allow floor(lod + 0.5) as well.
            let min_level = (((min_lod + 0.5).ceil() as i32) - 1).clamp(min_tex_level, max_tex_level);
            let max_level = ((max_lod + 0.5).floor() as i32).clamp(min_tex_level, max_tex_level);
            debug_assert!(min_level <= max_level);

            for level in min_level..=max_level {
                if is_level_sample_result_valid_3d(
                    &levels[level as usize],
                    wrap_s,
                    wrap_t,
                    wrap_r,
                    normalized_coords,
                    min_filter.level_filter(),
                    prec,
                    coord,
                    result,
                ) {
                    return true;
                }
            }
        } else if is_level_sample_result_valid_3d(
            &levels[0],
            wrap_s,
            wrap_t,
            wrap_r,
            normalized_coords,
            min_filter.level_filter(),
            prec,
            coord,
            result,
        ) {
            return true;
        }
    }

    false
}

/// `tcu::TexVerifierUtil::getPossibleCubeFaces` - which face(s) a direction vector
/// could legally resolve to, given its own floating-point precision. Usually exactly
/// one; near a seam (two components within error of each other) or a true corner
/// (all three), several - `is_lookup_result_valid_cube` tries each in turn and accepts
/// if *any* of them explains the result, since a conformant driver may legally pick
/// any one of them there. An empty result (upstream's `numFaces == 0`, which its own
/// comment calls out as impossible to reach in practice) is handled by the caller the
/// same way upstream does: the lookup result is undefined, so anything is valid.
pub(crate) fn get_possible_cube_faces(coord: [f32; 3], bits: [i32; 3]) -> Vec<CubeFace> {
    let [x, y, z] = coord;
    let (ax, ay, az) = (x.abs(), y.abs(), z.abs());
    let ex = compute_floating_point_error(x, bits[0]);
    let ey = compute_floating_point_error(y, bits[1]);
    let ez = compute_floating_point_error(z, bits[2]);

    let mut faces = Vec::new();
    if ay + ey < ax - ex && az + ez < ax - ex {
        if x >= ex {
            faces.push(CubeFace::PositiveX);
        }
        if x <= ex {
            faces.push(CubeFace::NegativeX);
        }
    } else if ax + ex < ay - ey && az + ez < ay - ey {
        if y >= ey {
            faces.push(CubeFace::PositiveY);
        }
        if y <= ey {
            faces.push(CubeFace::NegativeY);
        }
    } else if ax + ex < az - ez && ay + ey < az - ez {
        if z >= ez {
            faces.push(CubeFace::PositiveZ);
        }
        if z <= ez {
            faces.push(CubeFace::NegativeZ);
        }
    } else {
        // One or more components are equal (or within error bounds) - allow every
        // face whose own axis is not (within error of) zero.
        if ax > ex {
            faces.push(CubeFace::NegativeX);
            faces.push(CubeFace::PositiveX);
        }
        if ay > ey {
            faces.push(CubeFace::NegativeY);
            faces.push(CubeFace::PositiveY);
        }
        if az > ez {
            faces.push(CubeFace::NegativeZ);
            faces.push(CubeFace::PositiveZ);
        }
    }
    faces
}

/// `tcu::CubeFaceFloatCoords` - a resolved cube face plus the 2D coordinate a
/// direction vector projects to on it. `pub(crate)` (fields included) so
/// `tcu::tex_compare_verifier`'s own cube dispatcher can build one too.
pub(crate) struct CubeFaceFloatCoords {
    pub(crate) face: CubeFace,
    pub(crate) s: f32,
    pub(crate) t: f32,
}

/// `isSeamlessLinearSampleResultValid` - the seamless bilinear search: each of the
/// four taps a candidate texel offset needs is independently remapped onto whichever
/// face actually owns it (`remap_cube_edge_coords`, already ported for
/// `tcu::pixel::sample_cube_seamless_linear`'s own reference-image-production use),
/// so the resulting `ColorQuad` can straddle up to three different faces at once near
/// a corner. A texel that lands on a true corner (owned by no single neighbour) makes
/// the whole candidate undefined - upstream accepts unconditionally there rather than
/// guessing which of the three adjacent corner texels a real implementation picked.
///
/// This is the *seamless* branch only - called when `sampler.seamless_cube_map` is
/// `true` (the default, and the only mode `tcu::pixel::sample_cube_mipmap`'s own
/// reference-image production can build - see `Sampler`'s own doc comment). The
/// non-seamless counterpart (upstream's `isLinearSampleResultValid(level[coords.face],
/// ...)` branch - a plain single-face bilinear lookup, no cross-face remapping at all)
/// is ported too, but as a direct call to `is_linear_sample_result_valid_2d` confined to
/// `coords.face` at this function's own call site, not as a function in this file -
/// see `is_cube_level_sample_result_valid`'s own doc comment for where that branch is.
#[allow(clippy::too_many_arguments)]
fn is_seamless_linear_sample_result_valid(
    faces: &[ConstPixelBufferAccess<'_>; 6],
    normalized_coords: bool,
    prec: &LookupPrecision,
    coords: &CubeFaceFloatCoords,
    result: [f32; 4],
) -> bool {
    let face_access = &faces[get_cube_face_slot(coords.face)];
    let size = face_access.size()[0] as i32;

    let (u_lo, u_hi) =
        compute_non_normalized_coord_bounds(normalized_coords, size, coords.s, prec.coord_bits[0], prec.uvw_bits[0]);
    let (v_lo, v_hi) =
        compute_non_normalized_coord_bounds(normalized_coords, size, coords.t, prec.coord_bits[1], prec.uvw_bits[1]);

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    let tex_class = face_access.format().channel_class();

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

            let quad = ColorQuad {
                p00: lookup_float(&faces[get_cube_face_slot(c00.0)], c00.1, c00.2, 0, prec.border_color),
                p10: lookup_float(&faces[get_cube_face_slot(c10.0)], c10.1, c10.2, 0, prec.border_color),
                p01: lookup_float(&faces[get_cube_face_slot(c01.0)], c01.1, c01.2, 0, prec.border_color),
                p11: lookup_float(&faces[get_cube_face_slot(c11.0)], c11.1, c11.2, 0, prec.border_color),
            };

            if let Some(mode) = ambient_reduction() {
                if is_reduction_valid(prec, &[&quad], mode, result) {
                    return true;
                }
                continue;
            }

            let search_step = match tex_class {
                TextureChannelClass::UnsignedFixedPoint => compute_bilinear_search_step_for_unorm(prec),
                TextureChannelClass::SignedFixedPoint => compute_bilinear_search_step_for_snorm(prec),
                _ => compute_bilinear_search_step_from_float_quad(prec, &quad),
            };

            if is_bilinear_range_valid(prec, &quad, [min_a, max_a], [min_b, max_b], search_step, result) {
                return true;
            }
        }
    }
    false
}

/// `isCubeLevelSampleResultValid` - dispatches a single mip level's own sample to the
/// seamless bilinear search or a plain (clamp-to-edge) nearest tap on the resolved
/// face, by filter mode. `level` is the whole-cube access one mip level of
/// `tcu::texture_cube::TextureCube`/`glu::texture_cube::TextureCube` already produces
/// (six faces as depth slices, `get_cube_array_face_index` order) - split into the
/// `[ConstPixelBufferAccess; 6]` shape the seamless search needs the same way
/// `tcu::pixel::sample_cube_level` already does for reference-image production.
///
/// `seamless_cube_map` (`Sampler::seamless_cube_map`) only ever changes the `LINEAR`
/// arm - a `NEAREST` tap never crosses a face edge regardless of seamlessness, matching
/// `tcu::pixel::sample_cube_seamless_nearest`'s own reasoning, so that branch stays
/// exactly as it was before the field existed. When not seamless, upstream's own
/// `isCubeLevelSampleResultValid` calls plain `isLinearSampleResultValid(level[coords.
/// face], ...)` - a single-face bilinear tap, clamped to that face's own edge, with no
/// cross-face remapping at all - which is exactly `is_linear_sample_result_valid_2d`
/// already ported for the ordinary (non-cube) 2D path; `coords.s`/`coords.t` are already
/// in that one face's own pixel-space coordinates via `project_to_face`, so no further
/// translation is needed to call it directly.
#[allow(clippy::too_many_arguments)]
fn is_cube_level_sample_result_valid(
    level: &ConstPixelBufferAccess<'_>,
    normalized_coords: bool,
    seamless_cube_map: bool,
    filter: FilterMode,
    prec: &LookupPrecision,
    coords: &CubeFaceFloatCoords,
    result: [f32; 4],
) -> bool {
    const ORDER: [CubeFace; 6] = [
        CubeFace::NegativeX,
        CubeFace::PositiveX,
        CubeFace::NegativeY,
        CubeFace::PositiveY,
        CubeFace::NegativeZ,
        CubeFace::PositiveZ,
    ];
    let [w, h, _] = level.size();
    let faces: [ConstPixelBufferAccess<'_>; 6] =
        std::array::from_fn(|slot| level.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w, h, 1));

    match filter {
        FilterMode::Linear if seamless_cube_map => {
            is_seamless_linear_sample_result_valid(&faces, normalized_coords, prec, coords, result)
        }
        FilterMode::Linear => is_linear_sample_result_valid_2d(
            &faces[get_cube_face_slot(coords.face)],
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            normalized_coords,
            prec,
            [coords.s, coords.t],
            0,
            result,
        ),
        // A cube map is always implicitly clamp-to-edge regardless of whatever
        // wrap-mode state a sampler might otherwise carry - matching
        // `tcu::pixel::sample_cube_seamless_nearest`'s own reasoning (a nearest tap
        // never crosses a face edge, so seamlessness only ever changes the wrap
        // mode, never which face/texel is read).
        FilterMode::Nearest => is_nearest_sample_result_valid_2d(
            &faces[get_cube_face_slot(coords.face)],
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            normalized_coords,
            prec,
            [coords.s, coords.t],
            0,
            result,
        ),
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `isSeamplessLinearMipmapLinearSampleResultValid` - the cube counterpart of
/// `is_linear_mipmap_linear_sample_result_valid_2d`: each level contributes its own
/// bilinear quad, each of whose four taps is seam-remapped independently via
/// `remap_cube_edge_coords` exactly as the plain (single-level) seamless search does
/// (`is_seamless_linear_sample_result_valid`), and the two levels' quads are blended by
/// `is_2d_trilinear_filter_result_valid` - reused directly rather than a new
/// `ColorQuad`-walking search, since once each level's own quad is built the blend math
/// is identical to the 2D cross-mip-level case - confirmed directly against upstream's
/// own body, which itself calls `is2DTrilinearFilterResultValid` and nothing seam-aware
/// of its own. A texel pair that lands on a true corner (owned by no single neighbour,
/// `remap_cube_edge_coords` returning `None`) makes the whole candidate quad undefined -
/// upstream accepts unconditionally there, same as the plain seamless search.
#[allow(clippy::too_many_arguments)]
fn is_seamless_linear_mipmap_linear_sample_result_valid(
    faces0: &[ConstPixelBufferAccess<'_>; 6],
    faces1: &[ConstPixelBufferAccess<'_>; 6],
    normalized_coords: bool,
    prec: &LookupPrecision,
    coords: &CubeFaceFloatCoords,
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    let size0 = faces0[get_cube_face_slot(coords.face)].size()[0] as i32;
    let size1 = faces1[get_cube_face_slot(coords.face)].size()[0] as i32;

    let (u_lo0, u_hi0) =
        compute_non_normalized_coord_bounds(normalized_coords, size0, coords.s, prec.coord_bits[0], prec.uvw_bits[0]);
    let (u_lo1, u_hi1) =
        compute_non_normalized_coord_bounds(normalized_coords, size1, coords.s, prec.coord_bits[0], prec.uvw_bits[0]);
    let (v_lo0, v_hi0) =
        compute_non_normalized_coord_bounds(normalized_coords, size0, coords.t, prec.coord_bits[1], prec.uvw_bits[1]);
    let (v_lo1, v_hi1) =
        compute_non_normalized_coord_bounds(normalized_coords, size1, coords.t, prec.coord_bits[1], prec.uvw_bits[1]);

    let min_i0 = (u_lo0 - 0.5).floor() as i32;
    let max_i0 = (u_hi0 - 0.5).floor() as i32;
    let min_i1 = (u_lo1 - 0.5).floor() as i32;
    let max_i1 = (u_hi1 - 0.5).floor() as i32;
    let min_j0 = (v_lo0 - 0.5).floor() as i32;
    let max_j0 = (v_hi0 - 0.5).floor() as i32;
    let min_j1 = (v_lo1 - 0.5).floor() as i32;
    let max_j1 = (v_hi1 - 0.5).floor() as i32;

    let tex_class = faces0[get_cube_face_slot(coords.face)].format().channel_class();
    let c_search_step = match tex_class {
        TextureChannelClass::UnsignedFixedPoint => compute_bilinear_search_step_for_unorm(prec),
        TextureChannelClass::SignedFixedPoint => compute_bilinear_search_step_for_snorm(prec),
        _ => 0.0,
    };

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
            let quad0 = ColorQuad {
                p00: lookup_float(&faces0[get_cube_face_slot(c00.0)], c00.1, c00.2, 0, prec.border_color),
                p10: lookup_float(&faces0[get_cube_face_slot(c10.0)], c10.1, c10.2, 0, prec.border_color),
                p01: lookup_float(&faces0[get_cube_face_slot(c01.0)], c01.1, c01.2, 0, prec.border_color),
                p11: lookup_float(&faces0[get_cube_face_slot(c11.0)], c11.1, c11.2, 0, prec.border_color),
            };
            let search_step0 = if tex_class == TextureChannelClass::FloatingPoint {
                compute_bilinear_search_step_from_float_quad(prec, &quad0)
            } else {
                c_search_step
            };

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
                    let quad1 = ColorQuad {
                        p00: lookup_float(&faces1[get_cube_face_slot(d00.0)], d00.1, d00.2, 0, prec.border_color),
                        p10: lookup_float(&faces1[get_cube_face_slot(d10.0)], d10.1, d10.2, 0, prec.border_color),
                        p01: lookup_float(&faces1[get_cube_face_slot(d01.0)], d01.1, d01.2, 0, prec.border_color),
                        p11: lookup_float(&faces1[get_cube_face_slot(d11.0)], d11.1, d11.2, 0, prec.border_color),
                    };
                    let search_step1 = if tex_class == TextureChannelClass::FloatingPoint {
                        compute_bilinear_search_step_from_float_quad(prec, &quad1)
                    } else {
                        c_search_step
                    };

                    let min_a1 = ((u_lo1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                    let max_a1 = ((u_hi1 - 0.5) - i1 as f32).clamp(0.0, 1.0);
                    let min_b1 = ((v_lo1 - 0.5) - j1 as f32).clamp(0.0, 1.0);
                    let max_b1 = ((v_hi1 - 0.5) - j1 as f32).clamp(0.0, 1.0);

                    if is_2d_trilinear_filter_result_valid(
                        prec,
                        &quad0,
                        &quad1,
                        [min_a0, max_a0],
                        [min_b0, max_b0],
                        [min_a1, max_a1],
                        [min_b1, max_b1],
                        f_bounds,
                        search_step0.min(search_step1),
                        result,
                    ) {
                        return true;
                    }
                }
            }
        }
    }
    false
}

/// `isCubeMipmapLinearSampleResultValid` - dispatches the cross-mip-level cube blend to
/// the seamless-linear search above (`LINEAR` level filter) or a plain nearest-mipmap-
/// linear check with no seam crossing at either level (`NEAREST` level filter, matching
/// `is_cube_level_sample_result_valid`'s own NEAREST arm reasoning: a nearest tap never
/// crosses a face edge). Builds both levels' own six-face split once and shares it with
/// whichever branch needs it, rather than rebuilding only the one face the NEAREST arm
/// actually reads.
///
/// `seamless_cube_map` only changes the `LINEAR` level-filter arm, same reasoning as
/// `is_cube_level_sample_result_valid`'s own non-seamless `LINEAR` branch: upstream's
/// non-seamless `isLinearMipmapLinearSampleResultValid(faces0[coords.face], faces1[coords.
/// face], ...)` is a plain two-level trilinear blend confined to one face, which is
/// exactly `is_linear_mipmap_linear_sample_result_valid_2d` already ported for the
/// ordinary 2D path.
#[allow(clippy::too_many_arguments)]
fn is_cube_mipmap_linear_sample_result_valid(
    level0: &ConstPixelBufferAccess<'_>,
    level1: &ConstPixelBufferAccess<'_>,
    normalized_coords: bool,
    seamless_cube_map: bool,
    level_filter: FilterMode,
    prec: &LookupPrecision,
    coords: &CubeFaceFloatCoords,
    f_bounds: [f32; 2],
    result: [f32; 4],
) -> bool {
    const ORDER: [CubeFace; 6] = [
        CubeFace::NegativeX,
        CubeFace::PositiveX,
        CubeFace::NegativeY,
        CubeFace::PositiveY,
        CubeFace::NegativeZ,
        CubeFace::PositiveZ,
    ];
    let [w0, h0, _] = level0.size();
    let [w1, h1, _] = level1.size();
    let faces0: [ConstPixelBufferAccess<'_>; 6] =
        std::array::from_fn(|slot| level0.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w0, h0, 1));
    let faces1: [ConstPixelBufferAccess<'_>; 6] =
        std::array::from_fn(|slot| level1.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w1, h1, 1));

    match level_filter {
        FilterMode::Linear if seamless_cube_map => is_seamless_linear_mipmap_linear_sample_result_valid(
            &faces0,
            &faces1,
            normalized_coords,
            prec,
            coords,
            f_bounds,
            result,
        ),
        FilterMode::Linear => is_linear_mipmap_linear_sample_result_valid_2d(
            &faces0[get_cube_face_slot(coords.face)],
            &faces1[get_cube_face_slot(coords.face)],
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            normalized_coords,
            prec,
            [coords.s, coords.t],
            0,
            f_bounds,
            result,
        ),
        FilterMode::Nearest => is_nearest_mipmap_linear_sample_result_valid_2d(
            &faces0[get_cube_face_slot(coords.face)],
            &faces1[get_cube_face_slot(coords.face)],
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            normalized_coords,
            prec,
            [coords.s, coords.t],
            0,
            f_bounds,
            result,
        ),
        FilterMode::Cubic => unimplemented!("cubic filtering: no Sampler in this crate ever constructs one"),
    }
}

/// `tcu::isLookupResultValid` for `TextureCubeView` - mirrors `is_lookup_result_valid_2d`'s
/// own magnified/minified dispatch, tried against every face `get_possible_cube_faces`
/// returns (accepting if any one of them explains the result). Every `MinFilterMode` is
/// now ported, including `NearestMipmapLinear`/`LinearMipmapLinear` (true seamless
/// trilinear across mip levels, via `is_cube_mipmap_linear_sample_result_valid`/
/// `is_seamless_linear_mipmap_linear_sample_result_valid`), and both values of
/// `seamless_cube_map` (`Sampler::seamless_cube_map`) - `false` takes the plain
/// single-face `LINEAR` path described on `is_cube_level_sample_result_valid`'s own doc
/// comment, for every one of those same filter combinations.
#[allow(clippy::too_many_arguments)]
pub fn is_lookup_result_valid_cube(
    levels: &[ConstPixelBufferAccess<'_>],
    normalized_coords: bool,
    seamless_cube_map: bool,
    min_filter: MinFilterMode,
    mag_filter: FilterMode,
    lod_threshold: f32,
    prec: &LookupPrecision,
    coord: [f32; 3],
    lod_bounds: (f32, f32),
    result: [f32; 4],
) -> bool {
    debug_assert!(!levels.is_empty());
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
            && is_cube_level_sample_result_valid(
                &levels[0],
                normalized_coords,
                seamless_cube_map,
                mag_filter,
                prec,
                &coords,
                result,
            )
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
                    if is_cube_mipmap_linear_sample_result_valid(
                        &levels[level as usize],
                        &levels[level as usize + 1],
                        normalized_coords,
                        seamless_cube_map,
                        min_filter.level_filter(),
                        prec,
                        &coords,
                        [min_f, max_f],
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
                    if is_cube_level_sample_result_valid(
                        &levels[level as usize],
                        normalized_coords,
                        seamless_cube_map,
                        min_filter.level_filter(),
                        prec,
                        &coords,
                        result,
                    ) {
                        return true;
                    }
                }
            } else if is_cube_level_sample_result_valid(
                &levels[0],
                normalized_coords,
                seamless_cube_map,
                min_filter.level_filter(),
                prec,
                &coords,
                result,
            ) {
                return true;
            }
        }
    }

    false
}

/// `tcu::isLookupResultValid` for `TextureCubeArrayView` - `is_lookup_result_valid_cube`
/// looped over `compute_layer_range`. `levels` holds one access per mip level, each with
/// `num_layers * 6` depth slices; every layer is handed to the cube verifier as its own
/// six-slice sub-access, which is exactly what upstream's `getCubeArrayLevelFaces` slices.
#[allow(clippy::too_many_arguments)]
pub fn is_lookup_result_valid_cube_array(
    levels: &[ConstPixelBufferAccess<'_>],
    normalized_coords: bool,
    seamless_cube_map: bool,
    min_filter: MinFilterMode,
    mag_filter: FilterMode,
    lod_threshold: f32,
    prec: &LookupPrecision,
    layer_coord_bits: i32,
    coord: [f32; 4],
    lod_bounds: (f32, f32),
    result: [f32; 4],
) -> bool {
    debug_assert!(!levels.is_empty());
    let num_layers = (levels[0].size()[2] / 6) as i32;
    let (min_layer, max_layer) = compute_layer_range(num_layers, layer_coord_bits, coord[3]);

    for layer in min_layer..=max_layer {
        let layer_levels: Vec<ConstPixelBufferAccess<'_>> = levels
            .iter()
            .map(|level| {
                let [w, h, _] = level.size();
                level.get_subregion(0, 0, layer as u32 * 6, w, h, 6)
            })
            .collect();
        if is_lookup_result_valid_cube(
            &layer_levels,
            normalized_coords,
            seamless_cube_map,
            min_filter,
            mag_filter,
            lod_threshold,
            prec,
            [coord[0], coord[1], coord[2]],
            lod_bounds,
            result,
        ) {
            return true;
        }
    }
    false
}

// ===========================================================================
// Integer/unsigned-sampler lookup verification (`IntLookupPrecision`)
//
// See this file's own top doc comment for the overview; everything below is the
// `IntLookupPrecision` counterpart of the float-sampler functions above, NEAREST-only
// throughout (GL/GLES has no `LINEAR` filter for an integer sampler).
// ===========================================================================

/// `tcu::lookup<int32_t>` - the non-float specialisation of the generic `lookup`
/// template: no sRGB conversion (that is float-only - `lookup_float`'s own doc comment
/// notes it is a *specialisation* for exactly this reason, the primary template used
/// for every other `ScalarType` has none), otherwise the same in-bounds-texel-or-border
/// shape as `lookup_float`.
fn lookup_int(level: &ConstPixelBufferAccess<'_>, x: i32, y: i32, z: i32, border_color: [i32; 4]) -> [i32; 4] {
    if !coords_in_bounds(level, x, y, z) {
        border_color
    } else {
        level.get_pixel_int(x as u32, y as u32, z as u32)
    }
}

/// `tcu::lookup<uint32_t>`
fn lookup_uint(level: &ConstPixelBufferAccess<'_>, x: i32, y: i32, z: i32, border_color: [u32; 4]) -> [u32; 4] {
    if !coords_in_bounds(level, x, y, z) {
        border_color
    } else {
        level.get_pixel_uint(x as u32, y as u32, z as u32)
    }
}

/// `isColorValid(const IntLookupPrecision &, const IVec4 &, const IVec4 &)` -
/// `absDiff(ref, result).asUint() <= colorThreshold`: the signed difference is widened
/// to its unsigned magnitude before the (always-`UVec4`) threshold compare, so e.g.
/// `reference = i32::MIN, result = i32::MAX` is a magnitude of `u32::MAX`, not an
/// overflow/panic (`abs_diff` is exactly this operation on a signed integer).
fn is_color_valid_int(prec: &IntLookupPrecision, reference: [i32; 4], result: [i32; 4]) -> bool {
    (0..4).all(|c| !prec.color_mask[c] || reference[c].abs_diff(result[c]) <= prec.color_threshold[c])
}

/// `isColorValid(const IntLookupPrecision &, const UVec4 &, const UVec4 &)`
fn is_color_valid_uint(prec: &IntLookupPrecision, reference: [u32; 4], result: [u32; 4]) -> bool {
    (0..4).all(|c| !prec.color_mask[c] || reference[c].abs_diff(result[c]) <= prec.color_threshold[c])
}

/// `tcu::isNearestSampleResultValid` (the `(Vec2, coordZ)` overload) instantiated for
/// `IntLookupPrecision`/`int32_t` - the single-level NEAREST search
/// `is_nearest_sample_result_valid_2d` already does for a float sampler, with
/// `lookup_int`/`is_color_valid_int` standing in for `lookup_float`/`is_color_valid`
/// (which only ever take a `LookupPrecision` - these are a genuinely different
/// template instantiation upstream, not an overload the existing function could take).
#[allow(clippy::too_many_arguments)]
pub fn is_nearest_sample_result_valid_2d_int(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    let [w, h, _] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
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
            let color = lookup_int(level, x, y, coord_z, border_color);
            if is_color_valid_int(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `tcu::isNearestSampleResultValid` (the `(Vec2, coordZ)` overload) instantiated for
/// `IntLookupPrecision`/`uint32_t`.
#[allow(clippy::too_many_arguments)]
pub fn is_nearest_sample_result_valid_2d_uint(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    let [w, h, _] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
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
            let color = lookup_uint(level, x, y, coord_z, border_color);
            if is_color_valid_uint(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `tcu::isNearestSampleResultValid` (the `Vec3`, no-`coordZ` overload) instantiated for
/// `IntLookupPrecision`/`int32_t` - the `is_nearest_sample_result_valid_3d` shape (float)
/// with a third (`wrap_r`) axis, same as that function's own relationship to the 2D one.
#[allow(clippy::too_many_arguments)]
pub fn is_nearest_sample_result_valid_3d_int(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 3],
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    let [w, h, d] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (w_lo, w_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        d as i32,
        coord[2],
        prec.coord_bits[2],
        prec.uvw_bits[2],
    );

    let min_i = u_lo.floor() as i32;
    let max_i = u_hi.floor() as i32;
    let min_j = v_lo.floor() as i32;
    let max_j = v_hi.floor() as i32;
    let min_k = w_lo.floor() as i32;
    let max_k = w_hi.floor() as i32;

    for k in min_k..=max_k {
        for j in min_j..=max_j {
            for i in min_i..=max_i {
                let x = wrap(wrap_s, i, w as i32);
                let y = wrap(wrap_t, j, h as i32);
                let z = wrap(wrap_r, k, d as i32);
                let color = lookup_int(level, x, y, z, border_color);
                if is_color_valid_int(prec, color, result) {
                    return true;
                }
            }
        }
    }
    false
}

/// `tcu::isNearestSampleResultValid` (the `Vec3`, no-`coordZ` overload) instantiated for
/// `IntLookupPrecision`/`uint32_t`.
#[allow(clippy::too_many_arguments)]
pub fn is_nearest_sample_result_valid_3d_uint(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 3],
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    let [w, h, d] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );
    let (w_lo, w_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        d as i32,
        coord[2],
        prec.coord_bits[2],
        prec.uvw_bits[2],
    );

    let min_i = u_lo.floor() as i32;
    let max_i = u_hi.floor() as i32;
    let min_j = v_lo.floor() as i32;
    let max_j = v_hi.floor() as i32;
    let min_k = w_lo.floor() as i32;
    let max_k = w_hi.floor() as i32;

    for k in min_k..=max_k {
        for j in min_j..=max_j {
            for i in min_i..=max_i {
                let x = wrap(wrap_s, i, w as i32);
                let y = wrap(wrap_t, j, h as i32);
                let z = wrap(wrap_r, k, d as i32);
                let color = lookup_uint(level, x, y, z, border_color);
                if is_color_valid_uint(prec, color, result) {
                    return true;
                }
            }
        }
    }
    false
}

/// `isLevel2DLookupResultValid` for `IntLookupPrecision`/`IVec4` - upstream asserts both
/// `minFilter`/`magFilter` are `NEAREST` (an integer sampler has no `LINEAR` filter in
/// GL/GLES) and otherwise ignores which `scaleMode` (minify/magnify) is in play, since
/// both resolve to the same NEAREST search either way. Kept as its own named entry
/// point purely to match upstream's public API shape - all the real logic is
/// `is_nearest_sample_result_valid_2d_int` above.
#[allow(clippy::too_many_arguments)]
pub fn is_level_2d_lookup_result_valid_int(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    is_nearest_sample_result_valid_2d_int(
        level,
        wrap_s,
        wrap_t,
        normalized_coords,
        prec,
        coord,
        coord_z,
        border_color,
        result,
    )
}

/// `isLevel2DLookupResultValid` for `IntLookupPrecision`/`UVec4`.
#[allow(clippy::too_many_arguments)]
pub fn is_level_2d_lookup_result_valid_uint(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    is_nearest_sample_result_valid_2d_uint(
        level,
        wrap_s,
        wrap_t,
        normalized_coords,
        prec,
        coord,
        coord_z,
        border_color,
        result,
    )
}

/// `isLevel3DLookupResultValid` for `IntLookupPrecision`/`IVec4` - same relationship to
/// `is_nearest_sample_result_valid_3d_int` as the 2D wrapper above has to its own
/// NEAREST search.
#[allow(clippy::too_many_arguments)]
pub fn is_level_3d_lookup_result_valid_int(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 3],
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    is_nearest_sample_result_valid_3d_int(
        level,
        wrap_s,
        wrap_t,
        wrap_r,
        normalized_coords,
        prec,
        coord,
        border_color,
        result,
    )
}

/// `isLevel3DLookupResultValid` for `IntLookupPrecision`/`UVec4`.
#[allow(clippy::too_many_arguments)]
pub fn is_level_3d_lookup_result_valid_uint(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 3],
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    is_nearest_sample_result_valid_3d_uint(
        level,
        wrap_s,
        wrap_t,
        wrap_r,
        normalized_coords,
        prec,
        coord,
        border_color,
        result,
    )
}

/// `isGatherOffsetsResultValid` (the templated `(level, Vec2, coordZ)` shape)
/// instantiated for `IntLookupPrecision`/`int32_t` - `is_gather_offsets_result_valid`'s
/// (float) int sibling, same search shape with `lookup_int`/`is_color_valid_int`.
#[allow(clippy::too_many_arguments)]
fn is_gather_offsets_result_valid_int(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    let [w, h, _] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let mut color = [0i32; 4];
            for (off_ndx, offset) in offsets.iter().enumerate() {
                let x = wrap(wrap_s, i + offset[0], w as i32);
                let y = wrap(wrap_t, j + offset[1], h as i32);
                color[off_ndx] = lookup_int(level, x, y, coord_z, border_color)[component_ndx];
            }
            if is_color_valid_int(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `isGatherOffsetsResultValid` (the templated `(level, Vec2, coordZ)` shape)
/// instantiated for `IntLookupPrecision`/`uint32_t`.
#[allow(clippy::too_many_arguments)]
fn is_gather_offsets_result_valid_uint(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 2],
    coord_z: i32,
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    let [w, h, _] = level.size();
    let (u_lo, u_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        w as i32,
        coord[0],
        prec.coord_bits[0],
        prec.uvw_bits[0],
    );
    let (v_lo, v_hi) = compute_non_normalized_coord_bounds(
        normalized_coords,
        h as i32,
        coord[1],
        prec.coord_bits[1],
        prec.uvw_bits[1],
    );

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let mut color = [0u32; 4];
            for (off_ndx, offset) in offsets.iter().enumerate() {
                let x = wrap(wrap_s, i + offset[0], w as i32);
                let y = wrap(wrap_t, j + offset[1], h as i32);
                color[off_ndx] = lookup_uint(level, x, y, coord_z, border_color)[component_ndx];
            }
            if is_color_valid_uint(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `isGatherOffsetsResultValid` for `Texture2DView`/`IntLookupPrecision`/`IVec4`.
#[allow(clippy::too_many_arguments)]
pub fn is_gather_offsets_result_valid_2d_int(
    texture: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 2],
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    is_gather_offsets_result_valid_int(
        texture,
        wrap_s,
        wrap_t,
        normalized_coords,
        prec,
        coord,
        0,
        component_ndx,
        offsets,
        border_color,
        result,
    )
}

/// `isGatherOffsetsResultValid` for `Texture2DView`/`IntLookupPrecision`/`UVec4`.
#[allow(clippy::too_many_arguments)]
pub fn is_gather_offsets_result_valid_2d_uint(
    texture: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 2],
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    is_gather_offsets_result_valid_uint(
        texture,
        wrap_s,
        wrap_t,
        normalized_coords,
        prec,
        coord,
        0,
        component_ndx,
        offsets,
        border_color,
        result,
    )
}

/// `isGatherOffsetsResultValid` for `Texture2DArrayView`/`IntLookupPrecision`/`IVec4` -
/// the layer loop alone, same shape as `is_gather_offsets_result_valid_2d_array`'s own
/// relationship to the float 2D gather helper.
#[allow(clippy::too_many_arguments)]
pub fn is_gather_offsets_result_valid_2d_array_int(
    texture_level0: &ConstPixelBufferAccess<'_>,
    num_layers: i32,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 3],
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    let (layer_min, layer_max) = compute_layer_range(num_layers, prec.coord_bits[2], coord[2]);
    let coord_xy = [coord[0], coord[1]];
    for layer in layer_min..=layer_max {
        if is_gather_offsets_result_valid_int(
            texture_level0,
            wrap_s,
            wrap_t,
            normalized_coords,
            prec,
            coord_xy,
            layer,
            component_ndx,
            offsets,
            border_color,
            result,
        ) {
            return true;
        }
    }
    false
}

/// `isGatherOffsetsResultValid` for `Texture2DArrayView`/`IntLookupPrecision`/`UVec4`.
#[allow(clippy::too_many_arguments)]
pub fn is_gather_offsets_result_valid_2d_array_uint(
    texture_level0: &ConstPixelBufferAccess<'_>,
    num_layers: i32,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 3],
    component_ndx: usize,
    offsets: [[i32; 2]; 4],
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    let (layer_min, layer_max) = compute_layer_range(num_layers, prec.coord_bits[2], coord[2]);
    let coord_xy = [coord[0], coord[1]];
    for layer in layer_min..=layer_max {
        if is_gather_offsets_result_valid_uint(
            texture_level0,
            wrap_s,
            wrap_t,
            normalized_coords,
            prec,
            coord_xy,
            layer,
            component_ndx,
            offsets,
            border_color,
            result,
        ) {
            return true;
        }
    }
    false
}

/// `isGatherResultValid` for `TextureCubeView`'s own internal `(faces,
/// CubeFaceFloatCoords)` overload, `IntLookupPrecision`/`int32_t` - same unconditional
/// per-tap seam remap as `is_gather_result_valid_cube_face` (float), no
/// `seamless_cube_map` branch, confirmed against upstream the same way that function's
/// own doc comment already is.
fn is_gather_result_valid_cube_face_int(
    faces: &[ConstPixelBufferAccess<'_>; 6],
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coords: &CubeFaceFloatCoords,
    component_ndx: usize,
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    const OFFSETS: [[i32; 2]; 4] = [[0, 1], [1, 1], [1, 0], [0, 0]];
    let size = faces[get_cube_face_slot(coords.face)].size()[0] as i32;

    let (u_lo, u_hi) =
        compute_non_normalized_coord_bounds(normalized_coords, size, coords.s, prec.coord_bits[0], prec.uvw_bits[0]);
    let (v_lo, v_hi) =
        compute_non_normalized_coord_bounds(normalized_coords, size, coords.t, prec.coord_bits[1], prec.uvw_bits[1]);

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let mut color = [0i32; 4];
            for (off_ndx, offset) in OFFSETS.iter().enumerate() {
                let Some((face, s, t)) = remap_cube_edge_coords(coords.face, i + offset[0], j + offset[1], size) else {
                    return true;
                };
                color[off_ndx] = lookup_int(&faces[get_cube_face_slot(face)], s, t, 0, border_color)[component_ndx];
            }
            if is_color_valid_int(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `isGatherResultValid` for `TextureCubeView`'s own internal `(faces,
/// CubeFaceFloatCoords)` overload, `IntLookupPrecision`/`uint32_t`.
fn is_gather_result_valid_cube_face_uint(
    faces: &[ConstPixelBufferAccess<'_>; 6],
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coords: &CubeFaceFloatCoords,
    component_ndx: usize,
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    const OFFSETS: [[i32; 2]; 4] = [[0, 1], [1, 1], [1, 0], [0, 0]];
    let size = faces[get_cube_face_slot(coords.face)].size()[0] as i32;

    let (u_lo, u_hi) =
        compute_non_normalized_coord_bounds(normalized_coords, size, coords.s, prec.coord_bits[0], prec.uvw_bits[0]);
    let (v_lo, v_hi) =
        compute_non_normalized_coord_bounds(normalized_coords, size, coords.t, prec.coord_bits[1], prec.uvw_bits[1]);

    let min_i = (u_lo - 0.5).floor() as i32;
    let max_i = (u_hi - 0.5).floor() as i32;
    let min_j = (v_lo - 0.5).floor() as i32;
    let max_j = (v_hi - 0.5).floor() as i32;

    for j in min_j..=max_j {
        for i in min_i..=max_i {
            let mut color = [0u32; 4];
            for (off_ndx, offset) in OFFSETS.iter().enumerate() {
                let Some((face, s, t)) = remap_cube_edge_coords(coords.face, i + offset[0], j + offset[1], size) else {
                    return true;
                };
                color[off_ndx] = lookup_uint(&faces[get_cube_face_slot(face)], s, t, 0, border_color)[component_ndx];
            }
            if is_color_valid_uint(prec, color, result) {
                return true;
            }
        }
    }
    false
}

/// `isGatherResultValid` for `TextureCubeView`/`IntLookupPrecision`/`IVec4` - tried
/// against every face `get_possible_cube_faces` names, same as every other cube
/// dispatcher in this file.
pub fn is_gather_result_valid_cube_int(
    level0: &ConstPixelBufferAccess<'_>,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 3],
    component_ndx: usize,
    border_color: [i32; 4],
    result: [i32; 4],
) -> bool {
    const ORDER: [CubeFace; 6] = [
        CubeFace::NegativeX,
        CubeFace::PositiveX,
        CubeFace::NegativeY,
        CubeFace::PositiveY,
        CubeFace::NegativeZ,
        CubeFace::PositiveZ,
    ];
    let [w, h, _] = level0.size();
    let faces: [ConstPixelBufferAccess<'_>; 6] =
        std::array::from_fn(|slot| level0.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w, h, 1));

    let possible_faces = get_possible_cube_faces(coord, prec.coord_bits);
    if possible_faces.is_empty() {
        return true; // Result is undefined.
    }

    for face in possible_faces {
        let s_t = project_to_face(face, coord);
        let coords = CubeFaceFloatCoords {
            face,
            s: s_t[0],
            t: s_t[1],
        };
        if is_gather_result_valid_cube_face_int(
            &faces,
            normalized_coords,
            prec,
            &coords,
            component_ndx,
            border_color,
            result,
        ) {
            return true;
        }
    }
    false
}

/// `isGatherResultValid` for `TextureCubeView`/`IntLookupPrecision`/`UVec4`.
pub fn is_gather_result_valid_cube_uint(
    level0: &ConstPixelBufferAccess<'_>,
    normalized_coords: bool,
    prec: &IntLookupPrecision,
    coord: [f32; 3],
    component_ndx: usize,
    border_color: [u32; 4],
    result: [u32; 4],
) -> bool {
    const ORDER: [CubeFace; 6] = [
        CubeFace::NegativeX,
        CubeFace::PositiveX,
        CubeFace::NegativeY,
        CubeFace::PositiveY,
        CubeFace::NegativeZ,
        CubeFace::PositiveZ,
    ];
    let [w, h, _] = level0.size();
    let faces: [ConstPixelBufferAccess<'_>; 6] =
        std::array::from_fn(|slot| level0.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w, h, 1));

    let possible_faces = get_possible_cube_faces(coord, prec.coord_bits);
    if possible_faces.is_empty() {
        return true; // Result is undefined.
    }

    for face in possible_faces {
        let s_t = project_to_face(face, coord);
        let coords = CubeFaceFloatCoords {
            face,
            s: s_t[0],
            t: s_t[1],
        };
        if is_gather_result_valid_cube_face_uint(
            &faces,
            normalized_coords,
            prec,
            &coords,
            component_ndx,
            border_color,
            result,
        ) {
            return true;
        }
    }
    false
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelType, TextureFormat};
    use crate::tcu::texture_cube::TextureCube;

    /// The error at 22 accurate bits is one part in two million or so, and it grows with
    /// the value's exponent - both of which the bounds computation depends on.
    #[test]
    fn floating_point_error_scales_with_exponent() {
        let at_one = compute_floating_point_error(1.0, 22);
        let at_two = compute_floating_point_error(2.0, 22);
        assert!(at_one > 0.0, "{at_one}");
        assert!((at_two / at_one - 2.0).abs() < 1e-3, "{at_one} vs {at_two}");

        // Full precision leaves no garbage bits, so no error at all.
        assert_eq!(compute_floating_point_error(1.0, 23), 0.0);
    }

    /// A coordinate in the middle of a texel must not reach its neighbours, while the
    /// window around a texel boundary must include both sides.
    #[test]
    fn coord_bounds_bracket_the_texel() {
        // Texel 4 of 8: normalised centre is 4.5/8.
        let (lo, hi) = compute_non_normalized_coord_bounds(true, 8, 4.5 / 8.0, 22, 16);
        assert_eq!((lo.floor() as i32, hi.floor() as i32), (4, 4));

        // Exactly on the boundary between texel 3 and 4.
        let (lo, hi) = compute_non_normalized_coord_bounds(true, 8, 4.0 / 8.0, 22, 16);
        assert!(lo.floor() as i32 <= 3 && hi.floor() as i32 >= 4, "{lo}..{hi}");
    }

    #[test]
    fn clamp_to_edge_wraps() {
        assert_eq!(wrap(WrapMode::ClampToEdge, -1, 8), 0);
        assert_eq!(wrap(WrapMode::ClampToEdge, 8, 8), 7);
        assert_eq!(wrap(WrapMode::ClampToEdge, 3, 8), 3);
    }

    #[test]
    fn repeat_wraps() {
        assert_eq!(wrap(WrapMode::Repeat, -1, 8), 7);
        assert_eq!(wrap(WrapMode::Repeat, 8, 8), 0);
        assert_eq!(wrap(WrapMode::Repeat, 3, 8), 3);
    }

    /// Same hand-derived cases as `tcu::pixel`'s own `mirrored_repeat_wraps` test - the
    /// two `wrap` functions share an identical `MirroredRepeat` formula.
    #[test]
    fn mirrored_repeat_wraps() {
        assert_eq!(wrap(WrapMode::MirroredRepeat, 0, 8), 0);
        assert_eq!(wrap(WrapMode::MirroredRepeat, 7, 8), 7);
        assert_eq!(wrap(WrapMode::MirroredRepeat, 8, 8), 7);
        assert_eq!(wrap(WrapMode::MirroredRepeat, 15, 8), 0);
        assert_eq!(wrap(WrapMode::MirroredRepeat, -1, 8), 0);
    }

    /// `deClamp32(c, -1, size)`: an already in-range coordinate is untouched, and
    /// anything outside clamps to the sentinel just past whichever edge it left - `-1`
    /// below zero, `size` at or above the top - rather than the nearest *valid* texel
    /// index `ClampToEdge` would pick. Those two sentinel values are what
    /// `coords_in_bounds`/`lookup_float` below key off to decide "texel" vs. "border
    /// colour".
    #[test]
    fn clamp_to_border_wraps() {
        assert_eq!(wrap(WrapMode::ClampToBorder, 0, 8), 0);
        assert_eq!(wrap(WrapMode::ClampToBorder, 7, 8), 7);
        assert_eq!(wrap(WrapMode::ClampToBorder, -1, 8), -1);
        assert_eq!(wrap(WrapMode::ClampToBorder, -100, 8), -1);
        assert_eq!(wrap(WrapMode::ClampToBorder, 8, 8), 8);
        assert_eq!(wrap(WrapMode::ClampToBorder, 100, 8), 8);
    }

    #[test]
    fn coords_in_bounds_rejects_the_clamp_to_border_sentinels() {
        let level = checkerboard_r_level();
        let access = level.get_const_access();
        assert!(coords_in_bounds(&access, 0, 0, 0));
        assert!(coords_in_bounds(&access, 1, 1, 0));
        // The exact sentinels `wrap(ClampToBorder, ...)` can produce for this 2x2 level.
        assert!(!coords_in_bounds(&access, -1, 0, 0));
        assert!(!coords_in_bounds(&access, 2, 0, 0));
        assert!(!coords_in_bounds(&access, 0, 2, 0));
    }

    fn quad(p00: f32, p10: f32, p01: f32, p11: f32) -> ColorQuad {
        ColorQuad {
            p00: [p00, 0.0, 0.0, 1.0],
            p10: [p10, 0.0, 0.0, 1.0],
            p01: [p01, 0.0, 0.0, 1.0],
            p11: [p11, 0.0, 0.0, 1.0],
        }
    }

    /// `is_linear_range_valid` is a line-segment-vs-box test: the exact interpolation
    /// between two known colours, restricted to a blend-factor window, must agree with
    /// hand-checking every value the line passes through in that window.
    #[test]
    fn is_linear_range_valid_matches_hand_computed_line_segment_cases() {
        let prec = LookupPrecision {
            color_threshold: [0.05; 4],
            ..LookupPrecision::default()
        };
        let c0 = [0.0, 0.0, 0.0, 1.0];
        let c1 = [1.0, 0.0, 0.0, 1.0];

        // Over the full [0,1] blend range the line visits every value in [0,1] - 0.5 is on it.
        assert!(is_linear_range_valid(&prec, c0, c1, [0.0, 1.0], [0.5, 0.0, 0.0, 1.0]));
        // Restricting the blend window to [0, 0.2] keeps the line within [0, 0.2] (plus
        // threshold) - 0.8 is far outside that and must fail.
        assert!(!is_linear_range_valid(&prec, c0, c1, [0.0, 0.2], [0.8, 0.0, 0.0, 1.0]));
        // ...but 0.15 is within [0, 0.2] and must pass.
        assert!(is_linear_range_valid(&prec, c0, c1, [0.0, 0.2], [0.15, 0.0, 0.0, 1.0]));
    }

    /// `compute_bilinear_search_step_for_unorm`/`_snorm` - hand-derived from upstream's
    /// own formula (`1 / (range/threshold + 1)`): a UNORM format's representable range
    /// is `[0,1]` and a SNORM's is `[-1,1]`, so for the same threshold the SNORM step is
    /// smaller (a finer search, since the same absolute threshold covers a smaller
    /// fraction of a wider range).
    #[test]
    fn bilinear_search_step_formulas_match_hand_computed_values() {
        let prec = LookupPrecision {
            color_threshold: [0.1; 4],
            ..LookupPrecision::default()
        };
        let unorm_step = compute_bilinear_search_step_for_unorm(&prec);
        let snorm_step = compute_bilinear_search_step_for_snorm(&prec);
        assert!((unorm_step - 1.0 / (1.0 / 0.1 + 1.0)).abs() < 1e-6, "{unorm_step}");
        assert!((snorm_step - 1.0 / (2.0 / 0.1 + 1.0)).abs() < 1e-6, "{snorm_step}");
        assert!(
            snorm_step < unorm_step,
            "SNORM's wider range must give a finer (smaller) step"
        );
    }

    /// A quad with identical corners needs no fine search at all - the formula's own
    /// `max_d = 0` term makes every per-channel `min_step` term `1/(0+1) = 1`, so the
    /// step comes out to exactly `1.0` (a single search point), not the `1/65536` floor.
    #[test]
    fn bilinear_search_step_from_float_quad_is_coarse_for_a_flat_quad() {
        let prec = LookupPrecision {
            color_threshold: [0.01; 4],
            ..LookupPrecision::default()
        };
        let flat = quad(0.5, 0.5, 0.5, 0.5);
        assert_eq!(compute_bilinear_search_step_from_float_quad(&prec, &flat), 1.0);
    }

    /// `is_in_color_bounds` rejects a result outside the quad's own `[min,max]` window
    /// (widened by the threshold) before any search runs at all - the cheap pre-check
    /// `is_bilinear_range_valid` relies on.
    #[test]
    fn is_in_color_bounds_rejects_results_outside_the_quads_own_range() {
        let prec = LookupPrecision {
            color_threshold: [0.05; 4],
            ..LookupPrecision::default()
        };
        let q = quad(0.2, 0.4, 0.3, 0.5);
        assert!(is_in_color_bounds(&prec, &q, [0.3, 0.0, 0.0, 1.0]));
        assert!(!is_in_color_bounds(&prec, &q, [0.9, 0.0, 0.0, 1.0]));
        // Just past the max (0.5) but still within the threshold (0.05) must pass.
        assert!(is_in_color_bounds(&prec, &q, [0.54, 0.0, 0.0, 1.0]));
    }

    fn checkerboard_r_level() -> TextureLevel {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut level = TextureLevel::new(fmt, 2, 2, 1).unwrap();
        let mut access = level.get_access();
        access.set_pixel([0.0, 0.0, 0.0, 1.0], 0, 0, 0);
        access.set_pixel([1.0, 0.0, 0.0, 1.0], 1, 0, 0);
        access.set_pixel([0.0, 0.0, 0.0, 1.0], 0, 1, 0);
        access.set_pixel([1.0, 0.0, 0.0, 1.0], 1, 1, 0);
        level
    }

    /// End to end: a 2x2 texture with R=0 on the left column and R=1 on the right,
    /// sampled `LINEAR` at the exact shared corner of all four texels (pixel-space
    /// `u=v=1.0`, blend factor 0.5 on both axes) must accept the exact bilinear blend
    /// (`R=0.5`) and reject a value far outside the quad's own `[0,1]` range.
    #[test]
    fn is_linear_sample_result_valid_2d_accepts_the_exact_bilinear_blend() {
        let level = checkerboard_r_level();
        let access = level.get_const_access();
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        let valid = [0.5, 0.0, 0.0, 1.0];
        assert!(is_linear_sample_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [1.0, 1.0],
            0,
            valid
        ));

        let invalid = [0.9, 0.0, 0.0, 1.0];
        assert!(!is_linear_sample_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [1.0, 1.0],
            0,
            invalid
        ));
    }

    /// Sampling dead-centre of a single texel (no neighbour contributes at all, blend
    /// factors both `0`) must accept that texel's own exact colour.
    #[test]
    fn is_linear_sample_result_valid_2d_accepts_a_pure_single_texel_sample() {
        let level = checkerboard_r_level();
        let access = level.get_const_access();
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        // Pixel-space (0.5, 0.5) is the centre of texel (0,0), R=0.
        let result = [0.0, 0.0, 0.0, 1.0];
        assert!(is_linear_sample_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5],
            0,
            result
        ));
    }

    /// `compute_lod_bounds_from_derivates` with a unit-magnitude derivative on each axis
    /// (`dudx=1, dvdy=1`, everything else `0`): `p_min = max(mux,fy...) = 1`,
    /// `p_max = sqrt2 * 1 = sqrt2` (both `fx`/`fy` individually), so the bounds must
    /// bracket `[log2(1), log2(sqrt2)] = [0, 0.5]`, widened only by the small error
    /// terms at this precision (22 derivate bits, 16 lod bits - both near-exact).
    #[test]
    fn lod_bounds_from_derivates_match_hand_computed_log2_values() {
        let prec = LodPrecision::default();
        let (min_lod, max_lod) = compute_lod_bounds_from_derivates(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, &prec);
        assert!((min_lod - 0.0).abs() < 1e-3, "{min_lod}");
        assert!((max_lod - 0.5).abs() < 1e-3, "{max_lod}");
    }

    /// `compute_cube_lod_bounds_from_derivates` reduces to exactly the already-verified
    /// `lod_bounds_from_derivates_match_hand_computed_log2_values` case above: dead
    /// centre of `+X` (`coord = [1,0,0]`, so `ma=1, sc=tc=0` and the quotient-rule terms
    /// with `sc`/`tc` drop out), with `coord_dx`/`coord_dy` chosen so the recovered
    /// in-face derivatives come out to the same `dudx=1, dvdy=1` (everything else `0`)
    /// that test already uses - `dudx = faceSize*0.5*scdx` with `sc=0`, so `faceSize=2,
    /// scdx=coordDx.z=1` gives exactly `1`; `dvdy = faceSize*0.5*tcdy` with `tc=0`
    /// similarly needs `tcdy=coordDy.y=1`. Same hand-computed `[0, 0.5]` bounds follow.
    #[test]
    fn cube_lod_bounds_from_derivates_reduces_to_the_2d_case_at_a_faces_own_centre() {
        let prec = LodPrecision::default();
        let coord = [1.0, 0.0, 0.0]; // dead centre of +X
        let coord_dx = [0.0, 0.0, 1.0]; // scdx (coord_dx.z, +X's own s-axis) = 1
        let coord_dy = [0.0, 1.0, 0.0]; // tcdy (coord_dy.y, +X's own t-axis) = 1
        let (min_lod, max_lod) = compute_cube_lod_bounds_from_derivates(coord, coord_dx, coord_dy, 2, &prec);
        assert!((min_lod - 0.0).abs() < 1e-3, "{min_lod}");
        assert!((max_lod - 0.5).abs() < 1e-3, "{max_lod}");
    }

    /// `clamp_lod_bounds` with a bounds pair entirely below the allowed `[0, 10]` range
    /// clamps both ends to (within the tiny fixed-point error term) zero - the lower end
    /// to `-lodErr` and the upper to `+lodErr`, never leaving the allowed range at all.
    #[test]
    fn clamp_lod_bounds_clamps_an_out_of_range_pair_to_the_boundary() {
        let prec = LodPrecision::default();
        let (lo, hi) = clamp_lod_bounds((-5.0, -5.0), (0.0, 10.0), &prec);
        assert!(lo.abs() < 1e-3, "{lo}");
        assert!(hi.abs() < 1e-3, "{hi}");
    }

    /// `is_nearest_sample_result_valid_2d`: dead centre of texel `(0,0)` (pixel-space
    /// `(0.5, 0.5)`) must accept that texel's own exact colour (`R=0`) and reject the
    /// neighbouring texel's colour (`R=1`) - NEAREST never blends.
    #[test]
    fn is_nearest_sample_result_valid_2d_accepts_only_the_landed_on_texel() {
        let level = checkerboard_r_level();
        let access = level.get_const_access();
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        assert!(is_nearest_sample_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5],
            0,
            [0.0, 0.0, 0.0, 1.0]
        ));
        assert!(!is_nearest_sample_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5],
            0,
            [1.0, 0.0, 0.0, 1.0]
        ));
    }

    /// `is_nearest_sample_result_valid_2d` with `WrapMode::ClampToBorder` on the s axis:
    /// a coordinate three texels past the right edge of a width-2 level must read
    /// `prec.border_color` exactly, not the edge texel's own colour (`R=1`) that
    /// `ClampToEdge` would have pinned to instead - that distinction is the entire point
    /// of `CLAMP_TO_BORDER` over `CLAMP_TO_EDGE`.
    ///
    /// Hand-derived candidate range: pixel-space `u=5.0` has a sub-micron uncertainty
    /// window (`compute_non_normalized_coord_bounds` at the default 22/16 bit precision),
    /// so `min_i=floor(5.0-eps)=4`, `max_i=floor(5.0+eps)=5`; both `wrap(ClampToBorder, 4,
    /// 2)` and `wrap(ClampToBorder, 5, 2)` clamp to `2` (`deClamp32(c, -1, 2)`), which is
    /// `>= size` and therefore outside the level on every candidate - the loop can never
    /// fall back to an actual texel here.
    #[test]
    fn is_nearest_sample_result_valid_2d_reads_the_border_colour_past_the_edge() {
        let level = checkerboard_r_level();
        let access = level.get_const_access();
        let border = [0.3, 0.6, 0.9, 1.0];
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            border_color: border,
            ..LookupPrecision::default()
        };

        assert!(is_nearest_sample_result_valid_2d(
            &access,
            WrapMode::ClampToBorder,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [5.0, 0.5],
            0,
            border
        ));
        assert!(!is_nearest_sample_result_valid_2d(
            &access,
            WrapMode::ClampToBorder,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [5.0, 0.5],
            0,
            [1.0, 0.0, 0.0, 1.0]
        ));
    }

    /// `is_level_sample_result_valid_2d` dispatches to the NEAREST or LINEAR check by
    /// the `FilterMode` argument alone - reusing the two tests above's own exact-corner
    /// scenario, just resolved through the dispatcher instead of the two functions
    /// directly, confirms the match arms point at the right function.
    #[test]
    fn is_level_sample_result_valid_2d_dispatches_by_filter_mode() {
        let level = checkerboard_r_level();
        let access = level.get_const_access();
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        // LINEAR at the exact shared corner accepts the 0.5 blend, which NEAREST there
        // (landing on one specific texel) must reject (its own texel colour is 0 or 1,
        // not 0.5 - ClampToEdge wrap keeps the candidate deterministic enough that only
        // 0 or 1 can come out, never the blend).
        assert!(is_level_sample_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            FilterMode::Linear,
            &prec,
            [1.0, 1.0],
            0,
            [0.5, 0.0, 0.0, 1.0]
        ));
        assert!(!is_level_sample_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            FilterMode::Nearest,
            &prec,
            [1.0, 1.0],
            0,
            [0.5, 0.0, 0.0, 1.0]
        ));
    }

    /// A flat (uniform-colour) single-texel level, used as the coarser of a two-level
    /// mip pyramid in the trilinear tests below - its own bilinear/nearest sample is
    /// trivially its one colour regardless of coordinate, which isolates what's under
    /// test to the mip-blend factor rather than also exercising in-level filtering.
    fn flat_r_level(r: f32) -> TextureLevel {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        level.get_access().set_pixel([r, 0.0, 0.0, 1.0], 0, 0, 0);
        level
    }

    /// `is_nearest_mipmap_linear_sample_result_valid_2d`: two flat levels (`R=0`,
    /// `R=1`) blended at the exact midpoint (`f_bounds = [0.5, 0.5]`) must accept
    /// exactly `R=0.5` and reject anything else - since both levels are flat, the
    /// NEAREST-within-level search never contributes any uncertainty of its own, so
    /// this isolates the linear range check over the mip blend factor.
    #[test]
    fn is_nearest_mipmap_linear_sample_result_valid_2d_accepts_the_exact_midpoint_blend() {
        let level0 = flat_r_level(0.0);
        let level1 = flat_r_level(1.0);
        let (a0, a1) = (level0.get_const_access(), level1.get_const_access());
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        let valid = [0.5, 0.0, 0.0, 1.0];
        assert!(is_nearest_mipmap_linear_sample_result_valid_2d(
            &a0,
            &a1,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            &prec,
            [0.5, 0.5],
            0,
            [0.5, 0.5],
            valid
        ));

        let invalid = [0.9, 0.0, 0.0, 1.0];
        assert!(!is_nearest_mipmap_linear_sample_result_valid_2d(
            &a0,
            &a1,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            &prec,
            [0.5, 0.5],
            0,
            [0.5, 0.5],
            invalid
        ));
    }

    /// `is_linear_mipmap_linear_sample_result_valid_2d` (full trilinear): level 0 is the
    /// same left-R0/right-R1 checkerboard the bilinear tests use, sampled at normalised
    /// `(0.5, 0.25)` (texel-space `(1.0, 0.5)` - the exact x-edge, dead-centre in y, so
    /// the level-0 bilinear blend is exactly `0.5`); level 1 is the flat `R=1` single
    /// texel from above. At the exact mid mip-blend factor (`f_bounds = [0.5, 0.5]`) the
    /// hand-computed trilinear result is `(1-0.5)*0.5 + 0.5*1.0 = 0.75`.
    #[test]
    fn is_linear_mipmap_linear_sample_result_valid_2d_matches_the_hand_computed_trilinear_blend() {
        let level0 = checkerboard_r_level();
        let level1 = flat_r_level(1.0);
        let (a0, a1) = (level0.get_const_access(), level1.get_const_access());
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        let valid = [0.75, 0.0, 0.0, 1.0];
        assert!(is_linear_mipmap_linear_sample_result_valid_2d(
            &a0,
            &a1,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            &prec,
            [0.5, 0.25],
            0,
            [0.5, 0.5],
            valid
        ));

        let invalid = [0.1, 0.0, 0.0, 1.0];
        assert!(!is_linear_mipmap_linear_sample_result_valid_2d(
            &a0,
            &a1,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            &prec,
            [0.5, 0.25],
            0,
            [0.5, 0.5],
            invalid
        ));
    }

    /// `is_lookup_result_valid_2d` end to end, over the same two-level pyramid
    /// (`checkerboard_r_level`/`flat_r_level(1.0)`) as the trilinear test above, with
    /// `MinFilterMode::LinearMipmapLinear` - confirms the top-level dispatcher picks
    /// the right branch for three different `lod_bounds`:
    /// - Fully magnified (`lod_bounds = (-1, -1)`, below `lod_threshold = 0.0`): uses
    ///   `mag_filter` against level 0 alone, the plain bilinear `0.5` blend (not 0.75 -
    ///   level 1 never enters into it).
    /// - Fully minified at the exact mid mip-blend (`lod_bounds = (0.5, 0.5)`): the
    ///   same trilinear `0.75` the dedicated test above hand-computed.
    /// - Fully minified, deep enough to select level 1 outright with no blend
    ///   (`lod_bounds = (1.0, 1.0)`, `ceil(1.5)-1 = 1 = floor(1.5)`): level 1's own flat
    ///   `R=1`.
    #[test]
    fn is_lookup_result_valid_2d_picks_the_right_branch_per_lod_bounds() {
        let level0 = checkerboard_r_level();
        let level1 = flat_r_level(1.0);
        let levels = [level0.get_const_access(), level1.get_const_access()];
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        // Magnified: plain level-0 bilinear blend at the same (0.5, 0.25) coordinate.
        assert!(is_lookup_result_valid_2d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [0.5, 0.25],
            (-1.0, -1.0),
            [0.5, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_2d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [0.5, 0.25],
            (-1.0, -1.0),
            [0.75, 0.0, 0.0, 1.0],
        ));

        // Minified, exact mid mip-blend: the 0.75 trilinear result.
        assert!(is_lookup_result_valid_2d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [0.5, 0.25],
            (0.5, 0.5),
            [0.75, 0.0, 0.0, 1.0],
        ));

        // Minified, deep enough that nearest-mipmap-nearest selection would also land
        // on level 1 outright - using NearestMipmapNearest here specifically to also
        // exercise that branch of the dispatcher (not LinearMipmapLinear again).
        assert!(is_lookup_result_valid_2d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::NearestMipmapNearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.25],
            (1.0, 1.0),
            [1.0, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_2d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::NearestMipmapNearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.25],
            (1.0, 1.0),
            [0.0, 0.0, 0.0, 1.0],
        ));
    }

    /// Two layers, each a flat 1x1 colour, two mip levels - layer 0 is `R=0.2` (level
    /// 0) / `R=1.0` (level 1), layer 1 is `R=0.6` (level 0) / `R=0.5` (level 1).
    fn two_layer_r_levels() -> (TextureLevel, TextureLevel) {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut level0 = TextureLevel::new(fmt, 1, 1, 2).unwrap();
        {
            let mut access = level0.get_access();
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0);
            access.set_pixel([0.6, 0.0, 0.0, 1.0], 0, 0, 1);
        }
        let mut level1 = TextureLevel::new(fmt, 1, 1, 2).unwrap();
        {
            let mut access = level1.get_access();
            access.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0);
            access.set_pixel([0.5, 0.0, 0.0, 1.0], 0, 0, 1);
        }
        (level0, level1)
    }

    /// `is_lookup_result_valid_2d_array` end to end, over `two_layer_r_levels` - proves
    /// both axes at once: `compute_layer_range` picks the layer a `coord[2]` of `0.0`/
    /// `1.0` names (not the other one), and within that layer the same magnified/
    /// trilinear/nearest-mipmap branches `is_lookup_result_valid_2d`'s own test above
    /// checks still work, now reached through the array dispatcher.
    #[test]
    fn is_lookup_result_valid_2d_array_picks_the_right_layer_and_branch() {
        let (level0, level1) = two_layer_r_levels();
        let levels = [level0.get_const_access(), level1.get_const_access()];
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        // Magnified, layer 0: level 0's own flat R=0.2, not layer 1's R=0.6.
        assert!(is_lookup_result_valid_2d_array(
            &levels,
            2,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [0.5, 0.5, 0.0],
            (-1.0, -1.0),
            [0.2, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_2d_array(
            &levels,
            2,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [0.5, 0.5, 0.0],
            (-1.0, -1.0),
            [0.6, 0.0, 0.0, 1.0],
        ));

        // Magnified, layer 1: level 0's own flat R=0.6 this time.
        assert!(is_lookup_result_valid_2d_array(
            &levels,
            2,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [0.5, 0.5, 1.0],
            (-1.0, -1.0),
            [0.6, 0.0, 0.0, 1.0],
        ));

        // Minified, exact mid mip-blend, layer 0: (0.2 + 1.0) / 2 = 0.6 - not layer 1's
        // own blend (0.6 + 0.5) / 2 = 0.55.
        assert!(is_lookup_result_valid_2d_array(
            &levels,
            2,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [0.5, 0.5, 0.0],
            (0.5, 0.5),
            [0.6, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_2d_array(
            &levels,
            2,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [0.5, 0.5, 0.0],
            (0.5, 0.5),
            [0.55, 0.0, 0.0, 1.0],
        ));
    }

    /// A 2x2x2 texture with a distinct `R` per voxel (`R = (x + 2y + 4z) / 7`), sampled
    /// at the exact centre of voxel `(0,0,0)` - must accept only that voxel's own `R`
    /// (`0.0`), never another voxel's, proving the `z`/depth axis is actually wrapped
    /// and looked up, not just `x`/`y`.
    fn voxel_r_level() -> TextureLevel {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut level = TextureLevel::new(fmt, 2, 2, 2).unwrap();
        let mut access = level.get_access();
        for z in 0..2 {
            for y in 0..2 {
                for x in 0..2 {
                    let r = (x + 2 * y + 4 * z) as f32 / 7.0;
                    access.set_pixel([r, 0.0, 0.0, 1.0], x, y, z);
                }
            }
        }
        level
    }

    #[test]
    fn is_nearest_sample_result_valid_3d_accepts_only_the_landed_on_voxel() {
        let level = voxel_r_level();
        let access = level.get_const_access();
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        assert!(is_nearest_sample_result_valid_3d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5, 0.5],
            [0.0, 0.0, 0.0, 1.0]
        ));
        // Voxel (1,0,1): index = 1 + 0 + 4 = 5 -> R = 5/7.
        assert!(!is_nearest_sample_result_valid_3d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5, 0.5],
            [5.0 / 7.0, 0.0, 0.0, 1.0]
        ));
    }

    /// Sampled at pixel-space `(1.0, 1.0, 1.0)` - the shared corner of all eight voxels
    /// in `voxel_r_level`, the 3D counterpart of `is_linear_sample_result_valid_2d`'s
    /// own exact-shared-corner test - the trilinear blend weights every voxel equally
    /// (`a = b = c = 0.5`), so the accepted result is the plain average of all eight
    /// `R` values: `(0+1+2+3+4+5+6+7)/7/8 = 3.5/7 = 0.5` exactly.
    #[test]
    fn is_linear_sample_result_valid_3d_accepts_the_exact_trilinear_blend() {
        let level = voxel_r_level();
        let access = level.get_const_access();
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };

        assert!(is_linear_sample_result_valid_3d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [1.0, 1.0, 1.0],
            [0.5, 0.0, 0.0, 1.0]
        ));
        assert!(!is_linear_sample_result_valid_3d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [1.0, 1.0, 1.0],
            [0.9, 0.0, 0.0, 1.0]
        ));
    }

    /// `is_lookup_result_valid_3d` end to end, over the same two flat levels
    /// (`flat_r_level(0.2)`, `flat_r_level(1.0)`) the 2D dispatcher test above uses -
    /// confirms the magnified and `NearestMipmapNearest`-minified branches pick the
    /// right level.
    #[test]
    fn is_lookup_result_valid_3d_picks_the_right_branch_per_lod_bounds() {
        let level0 = flat_r_level(0.2);
        let level1 = flat_r_level(1.0);
        let levels = [level0.get_const_access(), level1.get_const_access()];
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-3; 4],
            ..LookupPrecision::default()
        };

        // Magnified: level 0's own flat 0.2, not level 1's 1.0.
        assert!(is_lookup_result_valid_3d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::NearestMipmapNearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5, 0.5],
            (-1.0, -1.0),
            [0.2, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_3d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::NearestMipmapNearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5, 0.5],
            (-1.0, -1.0),
            [1.0, 0.0, 0.0, 1.0],
        ));

        // Minified, deep enough that nearest-mipmap-nearest selection lands on level 1.
        assert!(is_lookup_result_valid_3d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::NearestMipmapNearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5, 0.5],
            (1.0, 1.0),
            [1.0, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_3d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            MinFilterMode::NearestMipmapNearest,
            FilterMode::Nearest,
            0.0,
            &prec,
            [0.5, 0.5, 0.5],
            (1.0, 1.0),
            [0.2, 0.0, 0.0, 1.0],
        ));
    }

    /// `is_linear_mipmap_linear_sample_result_valid_3d` (full cross-mip-level 3D
    /// trilinear): level 0 is `voxel_r_level`, sampled at the shared corner of all
    /// eight voxels - its own within-level trilinear blend is `0.5`, proved by
    /// `is_linear_sample_result_valid_3d_accepts_the_exact_trilinear_blend` above; level
    /// 1 is the flat `R=1.0` single texel. At the exact mid mip-blend factor
    /// (`f_bounds = [0.5, 0.5]`) the hand-computed result is `0.5*0.5 + 1.0*0.5 = 0.75`.
    #[test]
    fn is_linear_mipmap_linear_sample_result_valid_3d_matches_the_hand_computed_trilinear_blend() {
        let level0 = voxel_r_level();
        let level1 = flat_r_level(1.0);
        let (a0, a1) = (level0.get_const_access(), level1.get_const_access());
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };

        let valid = [0.75, 0.0, 0.0, 1.0];
        assert!(is_linear_mipmap_linear_sample_result_valid_3d(
            &a0,
            &a1,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [1.0, 1.0, 1.0],
            [0.5, 0.5],
            valid
        ));

        let invalid = [0.5, 0.0, 0.0, 1.0];
        assert!(!is_linear_mipmap_linear_sample_result_valid_3d(
            &a0,
            &a1,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [1.0, 1.0, 1.0],
            [0.5, 0.5],
            invalid
        ));
    }

    /// `is_lookup_result_valid_3d` end to end with `MinFilterMode::LinearMipmapLinear` -
    /// the branch that used to panic (`is_lookup_result_valid_3d_panics_on_the_unported_
    /// mipmap_linear_branch`, removed now that it's ported) - over the same
    /// `voxel_r_level`/`flat_r_level(1.0)` pyramid and hand-computed `0.75` the direct
    /// test above already proved, now reached through the top-level dispatcher.
    #[test]
    fn is_lookup_result_valid_3d_picks_the_linear_mipmap_linear_branch() {
        let level0 = voxel_r_level();
        let level1 = flat_r_level(1.0);
        let levels = [level0.get_const_access(), level1.get_const_access()];
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };

        assert!(is_lookup_result_valid_3d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 1.0, 1.0],
            (0.5, 0.5),
            [0.75, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_3d(
            &levels,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 1.0, 1.0],
            (0.5, 0.5),
            [0.5, 0.0, 0.0, 1.0],
        ));
    }

    /// Well inside a face (`(0.9, 0.1, 0.1)`, far from every seam) resolves to exactly
    /// one candidate face.
    #[test]
    fn get_possible_cube_faces_returns_one_face_away_from_a_seam() {
        let faces = get_possible_cube_faces([0.9, 0.1, 0.1], [22, 22, 22]);
        assert_eq!(faces, vec![CubeFace::PositiveX]);
    }

    /// Exactly on the `+X`/`+Y` edge (`x == y`, `z` negligible) must return all four
    /// faces whose own axis is not degenerate - upstream's own "allow every face
    /// where the major axis is not zero" fallback, confirmed directly rather than
    /// guessed from the single-face case above.
    #[test]
    fn get_possible_cube_faces_returns_four_faces_on_an_edge() {
        let mut faces = get_possible_cube_faces([1.0, 1.0, 0.0], [22, 22, 22]);
        faces.sort_by_key(|f| format!("{f:?}"));
        let mut expected = vec![
            CubeFace::NegativeX,
            CubeFace::PositiveX,
            CubeFace::NegativeY,
            CubeFace::PositiveY,
        ];
        expected.sort_by_key(|f| format!("{f:?}"));
        assert_eq!(faces, expected);
    }

    fn solid_face_cube(size: u32, color_per_face: impl Fn(CubeFace) -> f32) -> TextureCube {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut cube = TextureCube::new(fmt, size);
        cube.alloc_level(0);
        for face in [
            CubeFace::NegativeX,
            CubeFace::PositiveX,
            CubeFace::NegativeY,
            CubeFace::PositiveY,
            CubeFace::NegativeZ,
            CubeFace::PositiveZ,
        ] {
            let r = color_per_face(face);
            let mut access = cube.face_level_mut(face, 0);
            for y in 0..size {
                for x in 0..size {
                    access.set_pixel([r, 0.0, 0.0, 1.0], x, y, 0);
                }
            }
        }
        cube
    }

    /// `is_seamless_linear_sample_result_valid`, reached through `is_cube_level_sample_
    /// result_valid` directly - the genuinely new piece this iteration adds. A size-2
    /// cube has every face flat `R=0.5` except `+X` (`R=0.2`); sampled at the exact
    /// `+X` edge (`s=1.0`, pixel-space `u=2.0` - past the last valid column, forcing
    /// `remap_cube_edge_coords` to pull the other two bilinear taps from `+X`'s own
    /// neighbour there), the correct result blends `+X`'s `0.2` against *that specific
    /// neighbour's* `0.8` (set only at the exact two texels `remap_cube_edge_coords`
    /// itself names - found programmatically rather than reasoned out by hand, since
    /// which face borders which edge is that already-tested function's own
    /// responsibility, not what this test checks). `t=0.5` keeps the `j` axis
    /// in-bounds on both taps, isolating the seam crossing to one axis.
    #[test]
    fn is_seamless_linear_sample_result_valid_blends_across_a_face_edge() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube = solid_face_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.5 });
        cube.face_level_mut(neighbor0, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx0 as u32, ny0 as u32, 0);
        cube.face_level_mut(neighbor1, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx1 as u32, ny1 as u32, 0);

        let level = cube.level(0);
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };
        let coords = CubeFaceFloatCoords {
            face: CubeFace::PositiveX,
            s: 1.0,
            t: 0.5,
        };

        assert!(is_cube_level_sample_result_valid(
            &level,
            true,
            true,
            FilterMode::Linear,
            &prec,
            &coords,
            [0.5, 0.0, 0.0, 1.0]
        ));
        assert!(!is_cube_level_sample_result_valid(
            &level,
            true,
            true,
            FilterMode::Linear,
            &prec,
            &coords,
            [0.2, 0.0, 0.0, 1.0]
        ));
    }

    /// The non-seamless counterpart of the seamless test directly above, same cube and
    /// coordinate - but `seamless_cube_map = false` must now reject the seamless-blended
    /// `0.5` (there is no cross-face blend at all without seamlessness) and instead
    /// accept only `+X`'s own clamp-to-edge bilinear tap. `s=1.0` is past `+X`'s own
    /// last valid column (`u=2.0` on a size-2 face), so a non-seamless clamp-to-edge
    /// lookup repeats column 1 (`0.2`) for both taps on that axis - the whole bilinear
    /// quad is `+X`'s own flat `0.2`, so the only valid non-seamless result is `0.2`.
    #[test]
    fn is_cube_level_sample_result_valid_clamps_to_the_edge_instead_of_blending_when_not_seamless() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube = solid_face_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.5 });
        cube.face_level_mut(neighbor0, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx0 as u32, ny0 as u32, 0);
        cube.face_level_mut(neighbor1, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx1 as u32, ny1 as u32, 0);

        let level = cube.level(0);
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };
        let coords = CubeFaceFloatCoords {
            face: CubeFace::PositiveX,
            s: 1.0,
            t: 0.5,
        };

        assert!(
            is_cube_level_sample_result_valid(
                &level,
                true,
                false,
                FilterMode::Linear,
                &prec,
                &coords,
                [0.2, 0.0, 0.0, 1.0]
            ),
            "non-seamless must stay within +X's own flat 0.2"
        );
        assert!(
            !is_cube_level_sample_result_valid(
                &level,
                true,
                false,
                FilterMode::Linear,
                &prec,
                &coords,
                [0.5, 0.0, 0.0, 1.0]
            ),
            "the seamless-blended 0.5 must not be accepted once seamless_cube_map is false"
        );
    }

    /// `is_cube_level_sample_result_valid`'s own `faces` split (`ORDER` + `get_subregion`),
    /// factored out for the cross-mip-level tests below, which need the same split
    /// independently for two different levels.
    fn cube_faces<'a>(level: &'a ConstPixelBufferAccess<'a>) -> [ConstPixelBufferAccess<'a>; 6] {
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

    /// `is_seamless_linear_mipmap_linear_sample_result_valid` - level 0 is exactly the
    /// seam-crossing cube `is_seamless_linear_sample_result_valid_blends_across_a_face_
    /// edge` above already proved has its own seamless bilinear result `0.5` at this
    /// coordinate; level 1 is a flat, uniform `R=0.6` cube, whose own bilinear tap is
    /// trivially `0.6` regardless of which neighbour `remap_cube_edge_coords` names (a
    /// uniform cube has no seam to cross in the first place). At the exact mid
    /// mip-blend factor (`f_bounds = [0.5, 0.5]`) the hand-computed result is
    /// `0.5*0.5 + 0.6*0.5 = 0.55`.
    #[test]
    fn is_seamless_linear_mipmap_linear_sample_result_valid_blends_a_seam_crossing_level_against_a_flat_one() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube0 = solid_face_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.5 });
        cube0
            .face_level_mut(neighbor0, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx0 as u32, ny0 as u32, 0);
        cube0
            .face_level_mut(neighbor1, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx1 as u32, ny1 as u32, 0);
        let level0 = cube0.level(0);
        let faces0 = cube_faces(&level0);

        let cube1 = solid_face_cube(2, |_| 0.6);
        let level1 = cube1.level(0);
        let faces1 = cube_faces(&level1);

        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };
        let coords = CubeFaceFloatCoords {
            face: CubeFace::PositiveX,
            s: 1.0,
            t: 0.5,
        };

        assert!(is_seamless_linear_mipmap_linear_sample_result_valid(
            &faces0,
            &faces1,
            true,
            &prec,
            &coords,
            [0.5, 0.5],
            [0.55, 0.0, 0.0, 1.0]
        ));
        assert!(!is_seamless_linear_mipmap_linear_sample_result_valid(
            &faces0,
            &faces1,
            true,
            &prec,
            &coords,
            [0.5, 0.5],
            [0.5, 0.0, 0.0, 1.0]
        ));
        assert!(!is_seamless_linear_mipmap_linear_sample_result_valid(
            &faces0,
            &faces1,
            true,
            &prec,
            &coords,
            [0.5, 0.5],
            [0.6, 0.0, 0.0, 1.0]
        ));
    }

    /// `is_lookup_result_valid_cube` end to end, over a simple flat-per-face single
    /// level (no seam involved, `+X`'s own centre) - confirms the magnified/minified
    /// dispatch picks the right face's own colour, the cube counterpart of
    /// `is_lookup_result_valid_2d`'s own test.
    #[test]
    fn is_lookup_result_valid_cube_picks_the_right_face() {
        let cube = solid_face_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.8 });
        let level = cube.level(0);
        let levels = [level];
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };

        assert!(is_lookup_result_valid_cube(
            &levels,
            true,
            true,
            MinFilterMode::LinearMipmapNearest,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 0.0, 0.0],
            (-1.0, -1.0),
            [0.2, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_cube(
            &levels,
            true,
            true,
            MinFilterMode::LinearMipmapNearest,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 0.0, 0.0],
            (-1.0, -1.0),
            [0.8, 0.0, 0.0, 1.0],
        ));
    }

    /// `is_lookup_result_valid_cube` end to end with `MinFilterMode::LinearMipmapLinear` -
    /// the branch that used to panic (`is_lookup_result_valid_cube_panics_on_the_
    /// unported_mipmap_linear_branch`, removed now that it's ported). Both levels are
    /// flat, uniform, size-2 cubes (`R=0.2`/`R=1.0`, dead-centre of `+X`, no seam
    /// involved) so the expected blend at the exact mid mip-blend factor is the plain
    /// `0.2*0.5 + 1.0*0.5 = 0.6` - the seam-crossing math itself is what the dedicated
    /// `is_seamless_linear_mipmap_linear_sample_result_valid` test above already proves.
    /// Deliberately **not** a size-1 second level (a real mip pyramid's own next-smaller
    /// size): with only one texel per face, a bilinear tap's diagonal neighbour is a
    /// true corner no single face owns, which `remap_cube_edge_coords` cannot resolve -
    /// upstream's own spec-sanctioned "accept unconditionally" then applies regardless
    /// of `result`, which would make this test pass for the wrong reason (confirmed by
    /// trying it first: the negative assertion below failed, i.e. a size-1 second level
    /// made the function always return `true`).
    #[test]
    fn is_lookup_result_valid_cube_picks_the_linear_mipmap_linear_branch() {
        let cube0 = solid_face_cube(2, |_| 0.2);
        let level0 = cube0.level(0);
        let cube1 = solid_face_cube(2, |_| 1.0);
        let level1 = cube1.level(0);
        let levels = [level0, level1];
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };

        assert!(is_lookup_result_valid_cube(
            &levels,
            true,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 0.0, 0.0],
            (0.5, 0.5),
            [0.6, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_cube(
            &levels,
            true,
            true,
            MinFilterMode::LinearMipmapLinear,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 0.0, 0.0],
            (0.5, 0.5),
            [0.2, 0.0, 0.0, 1.0],
        ));
    }

    /// `is_lookup_result_valid_cube` end to end with `seamless_cube_map = false`, same
    /// seam-crossing cube as the internal-helper test above - proves the toggle reaches
    /// all the way through the public dispatcher, which takes a 3D direction vector
    /// rather than a `CubeFaceFloatCoords` directly.
    ///
    /// The direction vector is deliberately **not** the exact `+X`/`-Z` edge
    /// (`[1.0, 0.0, -1.0]`, `s=1.0` exactly) - an exact edge in projected face space is
    /// geometrically always an exact axis tie in 3D (`project_to_face`'s own formula:
    /// `s=1.0` on `+X` needs `rz=-rx`, which makes `|rz|=|rx|`), so `get_possible_cube_
    /// faces` would legitimately name `+X`'s neighbour (`-Z`) as a *second* candidate
    /// face too, and that neighbour's own independent clamp-to-edge read at its exact
    /// `s=0` edge would (correctly) also validate the overwritten neighbour texel,
    /// confounding what this test is actually about. `[1.0, 0.0, -0.8]` instead projects
    /// to `s=0.9` on `+X` alone (`get_possible_cube_faces` returns only `+X`, confirmed
    /// against the same reasoning `get_possible_cube_faces_returns_one_face_away_from_a_
    /// seam` above already established for a different direction) while still landing
    /// the bilinear quad's second column one step past the last valid texel (pixel-space
    /// `u = size*s = 1.8`, window `i=1, i+1=2` - the same out-of-face column index `2`
    /// the exact-edge case needs remapped, since `floor(1.8-0.5) == floor(2.0-0.5) == 1`
    /// puts both coordinates in the same bilinear window). Non-seamless clamps that
    /// out-of-range column back to `+X`'s own column 1 (`+X` is flat `0.2` everywhere),
    /// so the only valid non-seamless result is `0.2` - the overwritten neighbour's `0.8`
    /// is reachable only by actually crossing the seam.
    #[test]
    fn is_lookup_result_valid_cube_clamps_to_the_edge_instead_of_blending_when_not_seamless() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube = solid_face_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.5 });
        cube.face_level_mut(neighbor0, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx0 as u32, ny0 as u32, 0);
        cube.face_level_mut(neighbor1, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx1 as u32, ny1 as u32, 0);
        let level = cube.level(0);
        let levels = [level];
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };

        assert!(
            get_possible_cube_faces([1.0, 0.0, -0.8], prec.coord_bits) == vec![CubeFace::PositiveX],
            "this test's whole premise is a single candidate face"
        );

        assert!(is_lookup_result_valid_cube(
            &levels,
            true,
            false,
            MinFilterMode::LinearMipmapNearest,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 0.0, -0.8],
            (-1.0, -1.0),
            [0.2, 0.0, 0.0, 1.0],
        ));
        assert!(!is_lookup_result_valid_cube(
            &levels,
            true,
            false,
            MinFilterMode::LinearMipmapNearest,
            FilterMode::Linear,
            0.0,
            &prec,
            [1.0, 0.0, -0.8],
            (-1.0, -1.0),
            [0.8, 0.0, 0.0, 1.0],
        ));
    }

    /// `is_gather_offsets_result_valid_2d` - a 2x2 texture, one distinct value per
    /// texel, sampled dead-centre (`s=t=0.5`, pixel-space `u=v=1.0`) so the base tap
    /// `(i,j)` is unambiguously `(0,0)` with no blending at all (gather never blends).
    /// With the real `textureGather` offset order (`(0,1),(1,1),(1,0),(0,0)` relative to
    /// the base tap - the same fixed footprint `is_gather_result_valid_cube` hardcodes
    /// for the no-caller-offsets case), the four taps land on texels
    /// `(0,1)=0.3, (1,1)=0.4, (1,0)=0.2, (0,0)=0.1` in that order.
    #[test]
    fn is_gather_offsets_result_valid_2d_reads_four_texels_with_no_blending() {
        const OFFSETS: [[i32; 2]; 4] = [[0, 1], [1, 1], [1, 0], [0, 0]];
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut level = TextureLevel::new(fmt, 2, 2, 1).unwrap();
        {
            let mut access = level.get_access();
            access.set_pixel([0.1, 0.0, 0.0, 1.0], 0, 0, 0);
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 1, 0, 0);
            access.set_pixel([0.3, 0.0, 0.0, 1.0], 0, 1, 0);
            access.set_pixel([0.4, 0.0, 0.0, 1.0], 1, 1, 0);
        }
        let access = level.get_const_access();
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };

        assert!(is_gather_offsets_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            &prec,
            [0.5, 0.5],
            0,
            OFFSETS,
            [0.3, 0.4, 0.2, 0.1]
        ));
        // Any single slot wrong (e.g. the two middle taps swapped) must be rejected -
        // this is an exact-order check, not "the right multiset of values".
        assert!(!is_gather_offsets_result_valid_2d(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            &prec,
            [0.5, 0.5],
            0,
            OFFSETS,
            [0.4, 0.3, 0.2, 0.1]
        ));
    }

    /// `is_gather_offsets_result_valid_2d_array` - the layer loop alone (dead-centre
    /// sampling again, so within whichever layer the four taps are the flat colour that
    /// layer holds and never blend). Two layers, each flat but a different value
    /// (`0.1`/`0.9`), `coord[2] = 1.0` must pick layer 1's own `0.9` for all four slots,
    /// never layer 0's `0.1`.
    #[test]
    fn is_gather_offsets_result_valid_2d_array_picks_the_right_layer() {
        const OFFSETS: [[i32; 2]; 4] = [[0, 1], [1, 1], [1, 0], [0, 0]];
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut level = TextureLevel::new(fmt, 2, 2, 2).unwrap();
        {
            let mut access = level.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel([0.1, 0.0, 0.0, 1.0], x, y, 0);
                    access.set_pixel([0.9, 0.0, 0.0, 1.0], x, y, 1);
                }
            }
        }
        let access = level.get_const_access();
        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };

        assert!(is_gather_offsets_result_valid_2d_array(
            &access,
            2,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            &prec,
            [0.5, 0.5, 1.0],
            0,
            OFFSETS,
            [0.9, 0.9, 0.9, 0.9]
        ));
        assert!(
            !is_gather_offsets_result_valid_2d_array(
                &access,
                2,
                WrapMode::ClampToEdge,
                WrapMode::ClampToEdge,
                true,
                &prec,
                [0.5, 0.5, 1.0],
                0,
                OFFSETS,
                [0.1, 0.1, 0.1, 0.1]
            ),
            "layer 1 must not accept layer 0's own flat colour"
        );
    }

    /// `is_gather_result_valid_cube_face` - the seam-remapping gather shape, called
    /// directly with a hand-built `CubeFaceFloatCoords` the same way the sample/compare
    /// seam tests above do (bypassing face *selection* so the test is only about the
    /// gather math itself). Same geometry as `is_cube_level_sample_result_valid_clamps_
    /// to_the_edge_instead_of_blending_when_not_seamless`: a size-2 cube, `+X` flat
    /// `0.2` except the two texels `remap_cube_edge_coords` itself names on `+X`'s own
    /// `-Z` neighbour, both set to `0.8`. At `s=1.0, t=0.5` the base tap is `(i,j)=(1,0)`
    /// (pixel-space `u=2.0, v=1.0`), and the four `(0,1),(1,1),(1,0),(0,0)`-relative taps
    /// land on `(1,1)` (`+X`'s own, `0.2`), `(2,1)` (crosses to `-Z`'s `neighbor1`,
    /// `0.8`), `(2,0)` (crosses to `-Z`'s `neighbor0`, `0.8`), `(1,0)` (`+X`'s own,
    /// `0.2`) - `[0.2, 0.8, 0.8, 0.2]`, with no blending at all (gather never blends),
    /// unlike the `0.5`-blended seamless-*sample* result the same coordinate produces in
    /// the sampling tests above.
    #[test]
    fn is_gather_result_valid_cube_face_seam_remaps_each_tap_independently() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube = solid_face_cube(2, |face| if face == CubeFace::PositiveX { 0.2 } else { 0.5 });
        cube.face_level_mut(neighbor0, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx0 as u32, ny0 as u32, 0);
        cube.face_level_mut(neighbor1, 0)
            .set_pixel([0.8, 0.0, 0.0, 1.0], nx1 as u32, ny1 as u32, 0);

        const ORDER: [CubeFace; 6] = [
            CubeFace::NegativeX,
            CubeFace::PositiveX,
            CubeFace::NegativeY,
            CubeFace::PositiveY,
            CubeFace::NegativeZ,
            CubeFace::PositiveZ,
        ];
        let level = cube.level(0);
        let [w, h, _] = level.size();
        let faces: [ConstPixelBufferAccess<'_>; 6] =
            std::array::from_fn(|slot| level.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w, h, 1));

        let prec = LookupPrecision {
            color_threshold: [1.0 / 255.0 + 1e-2; 4],
            ..LookupPrecision::default()
        };
        let coords = CubeFaceFloatCoords {
            face: CubeFace::PositiveX,
            s: 1.0,
            t: 0.5,
        };

        assert!(is_gather_result_valid_cube_face(
            &faces,
            true,
            &prec,
            &coords,
            0,
            [0.2, 0.8, 0.8, 0.2]
        ));
        assert!(
            !is_gather_result_valid_cube_face(&faces, true, &prec, &coords, 0, [0.5, 0.5, 0.5, 0.5]),
            "the seamless-blended sample value must not be a valid gather result"
        );
        assert!(
            !is_gather_result_valid_cube_face(&faces, true, &prec, &coords, 0, [0.8, 0.2, 0.8, 0.2]),
            "the two +X taps and the two neighbour taps must not be swapped"
        );
    }

    // =======================================================================
    // IntLookupPrecision (`is_color_valid_int`/`_uint`, `lookup_int`/`_uint`, and
    // every NEAREST-only search/gather function built on them)
    // =======================================================================

    #[test]
    fn is_color_valid_int_compares_the_unsigned_magnitude_of_the_signed_difference() {
        let prec = IntLookupPrecision {
            color_threshold: [5; 4],
            ..IntLookupPrecision::default()
        };
        assert!(
            is_color_valid_int(&prec, [10, 0, 0, 0], [12, 0, 0, 0]),
            "|10-12|=2 <= 5"
        );
        assert!(
            !is_color_valid_int(&prec, [10, 0, 0, 0], [20, 0, 0, 0]),
            "|10-20|=10 > 5"
        );

        // `i32::MIN` vs `i32::MAX`: a plain `(a - b).abs()` would overflow/panic on this
        // pair, which is exactly why upstream's own `absDiff` (and `i32::abs_diff` here)
        // widens to the unsigned magnitude first - `u32::MAX` is the true distance, and
        // a `u32::MAX` threshold must accept it.
        let wide = IntLookupPrecision {
            color_threshold: [u32::MAX; 4],
            ..IntLookupPrecision::default()
        };
        assert!(is_color_valid_int(&wide, [i32::MIN, 0, 0, 0], [i32::MAX, 0, 0, 0]));
        let narrow = IntLookupPrecision {
            color_threshold: [u32::MAX - 1; 4],
            ..IntLookupPrecision::default()
        };
        assert!(!is_color_valid_int(&narrow, [i32::MIN, 0, 0, 0], [i32::MAX, 0, 0, 0]));

        // A masked-off channel must not be read at all, even with a huge difference.
        let masked = IntLookupPrecision {
            color_mask: [false, true, true, true],
            color_threshold: [0; 4],
            ..IntLookupPrecision::default()
        };
        assert!(is_color_valid_int(&masked, [0, 5, 5, 5], [1000, 5, 5, 5]));
        assert!(
            !is_color_valid_int(&masked, [0, 5, 5, 5], [0, 6, 5, 5]),
            "the unmasked channel 1 must still be checked"
        );
    }

    #[test]
    fn is_color_valid_uint_compares_a_plain_unsigned_magnitude() {
        let prec = IntLookupPrecision {
            color_threshold: [5; 4],
            ..IntLookupPrecision::default()
        };
        assert!(is_color_valid_uint(
            &prec,
            [4_000_000_000, 0, 0, 0],
            [4_000_000_002, 0, 0, 0]
        ));
        assert!(!is_color_valid_uint(
            &prec,
            [4_000_000_000, 0, 0, 0],
            [4_000_000_010, 0, 0, 0]
        ));
        // `0` vs `u32::MAX`: the magnitude is `u32::MAX` either direction, never wraps.
        let wide = IntLookupPrecision {
            color_threshold: [u32::MAX; 4],
            ..IntLookupPrecision::default()
        };
        assert!(is_color_valid_uint(&wide, [0, 0, 0, 0], [u32::MAX, 0, 0, 0]));
    }

    fn int_r_level(r: i32) -> TextureLevel {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        let _ = level.get_access().set_pixel_int([r, 0, 0, 1], 0, 0, 0);
        level
    }

    #[test]
    fn lookup_int_reads_border_colour_outside_bounds() {
        let level = int_r_level(42);
        let access = level.get_const_access();
        let border = [7, 8, 9, 10];
        assert_eq!(lookup_int(&access, 0, 0, 0, border), [42, 0, 0, 1]);
        assert_eq!(lookup_int(&access, -1, 0, 0, border), border);
        assert_eq!(lookup_int(&access, 1, 0, 0, border), border);
    }

    #[test]
    fn lookup_uint_reads_border_colour_outside_bounds() {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32);
        let mut level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        // A value only representable in `u32`, not `i32` - proves this goes through the
        // unsigned decode (`get_pixel_uint`), not a signed one that would misread it.
        let _ = level.get_access().set_pixel_int([-294967296i32, 0, 0, 1], 0, 0, 0); // bit pattern of 4_000_000_000u32
        let access = level.get_const_access();
        let border = [1u32, 2, 3, 4];
        assert_eq!(lookup_uint(&access, 0, 0, 0, border), [4_000_000_000u32, 0, 0, 1]);
        assert_eq!(lookup_uint(&access, 0, -1, 0, border), border);
        assert_eq!(lookup_uint(&access, 0, 1, 0, border), border);
    }

    fn checkerboard_r_int_level() -> TextureLevel {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut level = TextureLevel::new(fmt, 2, 2, 1).unwrap();
        let mut access = level.get_access();
        let _ = access.set_pixel_int([0, 0, 0, 1], 0, 0, 0);
        let _ = access.set_pixel_int([100, 0, 0, 1], 1, 0, 0);
        let _ = access.set_pixel_int([0, 0, 0, 1], 0, 1, 0);
        let _ = access.set_pixel_int([100, 0, 0, 1], 1, 1, 0);
        level
    }

    /// Mirrors `is_nearest_sample_result_valid_2d_accepts_only_the_landed_on_texel`
    /// exactly, with exact-match integer colours (`color_threshold: [0; 4]`) in place of
    /// the quantisation-tolerance threshold a `UNORM_INT8` float comparison needs.
    #[test]
    fn is_nearest_sample_result_valid_2d_int_accepts_only_the_landed_on_texel() {
        let level = checkerboard_r_int_level();
        let access = level.get_const_access();
        let prec = IntLookupPrecision::default();
        let border = [0; 4];

        assert!(is_nearest_sample_result_valid_2d_int(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5],
            0,
            border,
            [0, 0, 0, 1]
        ));
        assert!(!is_nearest_sample_result_valid_2d_int(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5],
            0,
            border,
            [100, 0, 0, 1]
        ));
    }

    /// Mirrors `is_nearest_sample_result_valid_2d_reads_the_border_colour_past_the_edge`'s
    /// own hand-derived candidate range exactly (same default `coord_bits`/`uvw_bits`,
    /// same width-2 level, same `u=5.0` coordinate): both candidates clamp to the `size`
    /// sentinel under `ClampToBorder`, so only the border colour can ever validate.
    #[test]
    fn is_nearest_sample_result_valid_2d_int_reads_the_border_colour_past_the_edge() {
        let level = checkerboard_r_int_level();
        let access = level.get_const_access();
        let prec = IntLookupPrecision::default();
        let border = [30, 60, 90, 1];

        assert!(is_nearest_sample_result_valid_2d_int(
            &access,
            WrapMode::ClampToBorder,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [5.0, 0.5],
            0,
            border,
            border
        ));
        assert!(!is_nearest_sample_result_valid_2d_int(
            &access,
            WrapMode::ClampToBorder,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [5.0, 0.5],
            0,
            border,
            [100, 0, 0, 1]
        ));
    }

    /// `is_level_2d_lookup_result_valid_int` is a pure pass-through to
    /// `is_nearest_sample_result_valid_2d_int` (int/uint samplers have no `LINEAR`
    /// filter, so `isLevel2DLookupResultValid`'s own `scaleMode` argument changes
    /// nothing) - confirms the forwarding is wired correctly using the same scenario
    /// as the two tests just above.
    #[test]
    fn is_level_2d_lookup_result_valid_int_forwards_to_the_nearest_search() {
        let level = checkerboard_r_int_level();
        let access = level.get_const_access();
        let prec = IntLookupPrecision::default();
        let border = [0; 4];

        assert!(is_level_2d_lookup_result_valid_int(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5],
            0,
            border,
            [0, 0, 0, 1]
        ));
        assert!(!is_level_2d_lookup_result_valid_int(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5],
            0,
            border,
            [100, 0, 0, 1]
        ));
    }

    fn voxel_r_int_level() -> TextureLevel {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut level = TextureLevel::new(fmt, 2, 2, 2).unwrap();
        let mut access = level.get_access();
        for z in 0..2 {
            for y in 0..2 {
                for x in 0..2 {
                    let _ = access.set_pixel_int([(x + 2 * y + 4 * z) as i32, 0, 0, 1], x, y, z);
                }
            }
        }
        level
    }

    /// Mirrors `is_nearest_sample_result_valid_3d_accepts_only_the_landed_on_voxel`:
    /// pixel-space `(0.5,0.5,0.5)` (non-normalised coordinates) floors to voxel
    /// `(0,0,0)`, index `0`; voxel `(1,0,1)` (index `1+0+4=5`) must be rejected.
    #[test]
    fn is_nearest_sample_result_valid_3d_int_accepts_only_the_landed_on_voxel() {
        let level = voxel_r_int_level();
        let access = level.get_const_access();
        let prec = IntLookupPrecision::default();
        let border = [0; 4];

        assert!(is_nearest_sample_result_valid_3d_int(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5, 0.5],
            border,
            [0, 0, 0, 1]
        ));
        assert!(!is_nearest_sample_result_valid_3d_int(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            false,
            &prec,
            [0.5, 0.5, 0.5],
            border,
            [5, 0, 0, 1]
        ));
    }

    /// Mirrors `is_gather_offsets_result_valid_2d_reads_four_texels_with_no_blending`:
    /// dead-centre sampling (`s=t=0.5`, pixel-space `u=v=1.0`) makes the base tap
    /// unambiguously `(0,0)`, so the real `textureGather` offset order
    /// `(0,1),(1,1),(1,0),(0,0)` reads `(0,1)=30,(1,1)=40,(1,0)=20,(0,0)=10`.
    #[test]
    fn is_gather_offsets_result_valid_2d_int_reads_four_texels_with_no_blending() {
        const OFFSETS: [[i32; 2]; 4] = [[0, 1], [1, 1], [1, 0], [0, 0]];
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut level = TextureLevel::new(fmt, 2, 2, 1).unwrap();
        {
            let mut access = level.get_access();
            let _ = access.set_pixel_int([10, 0, 0, 1], 0, 0, 0);
            let _ = access.set_pixel_int([20, 0, 0, 1], 1, 0, 0);
            let _ = access.set_pixel_int([30, 0, 0, 1], 0, 1, 0);
            let _ = access.set_pixel_int([40, 0, 0, 1], 1, 1, 0);
        }
        let access = level.get_const_access();
        let prec = IntLookupPrecision::default();
        let border = [0; 4];

        assert!(is_gather_offsets_result_valid_2d_int(
            &access,
            WrapMode::ClampToEdge,
            WrapMode::ClampToEdge,
            true,
            &prec,
            [0.5, 0.5],
            0,
            OFFSETS,
            border,
            [30, 40, 20, 10]
        ));
        assert!(
            !is_gather_offsets_result_valid_2d_int(
                &access,
                WrapMode::ClampToEdge,
                WrapMode::ClampToEdge,
                true,
                &prec,
                [0.5, 0.5],
                0,
                OFFSETS,
                border,
                [40, 30, 20, 10]
            ),
            "an exact-order check, not the right multiset"
        );
    }

    fn solid_face_cube_int(size: u32, color_per_face: impl Fn(CubeFace) -> i32) -> TextureCube {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut cube = TextureCube::new(fmt, size);
        cube.alloc_level(0);
        for face in [
            CubeFace::NegativeX,
            CubeFace::PositiveX,
            CubeFace::NegativeY,
            CubeFace::PositiveY,
            CubeFace::NegativeZ,
            CubeFace::PositiveZ,
        ] {
            let r = color_per_face(face);
            let mut access = cube.face_level_mut(face, 0);
            for y in 0..size {
                for x in 0..size {
                    let _ = access.set_pixel_int([r, 0, 0, 1], x, y, 0);
                }
            }
        }
        cube
    }

    /// Mirrors `is_gather_result_valid_cube_face_seam_remaps_each_tap_independently`
    /// exactly - same size-2 geometry (`+X` flat `20` except the two texels
    /// `remap_cube_edge_coords` names on its own `-Z` neighbour, set to `80`), same
    /// `s=1.0, t=0.5` coordinate landing the base tap on `(1,0)` - the four
    /// `(0,1),(1,1),(1,0),(0,0)`-relative taps read `[20, 80, 80, 20]`, with no
    /// blending at all (gather never blends, unlike the seamless-sample case). Calls
    /// `is_gather_result_valid_cube_face_int` directly with a hand-built
    /// `CubeFaceFloatCoords`, the same way the float test bypasses face *selection* so
    /// the test is only about the gather math itself.
    #[test]
    fn is_gather_result_valid_cube_face_int_seam_remaps_each_tap_independently() {
        let (neighbor0, nx0, ny0) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 0, 2).expect("a size-2 edge must remap to a real neighbour");
        let (neighbor1, nx1, ny1) =
            remap_cube_edge_coords(CubeFace::PositiveX, 2, 1, 2).expect("a size-2 edge must remap to a real neighbour");

        let mut cube = solid_face_cube_int(2, |face| if face == CubeFace::PositiveX { 20 } else { 50 });
        let _ = cube
            .face_level_mut(neighbor0, 0)
            .set_pixel_int([80, 0, 0, 1], nx0 as u32, ny0 as u32, 0);
        let _ = cube
            .face_level_mut(neighbor1, 0)
            .set_pixel_int([80, 0, 0, 1], nx1 as u32, ny1 as u32, 0);

        const ORDER: [CubeFace; 6] = [
            CubeFace::NegativeX,
            CubeFace::PositiveX,
            CubeFace::NegativeY,
            CubeFace::PositiveY,
            CubeFace::NegativeZ,
            CubeFace::PositiveZ,
        ];
        let level = cube.level(0);
        let [w, h, _] = level.size();
        let faces: [ConstPixelBufferAccess<'_>; 6] =
            std::array::from_fn(|slot| level.get_subregion(0, 0, get_cube_array_face_index(ORDER[slot]), w, h, 1));

        let prec = IntLookupPrecision::default();
        let border = [0; 4];
        let coords = CubeFaceFloatCoords {
            face: CubeFace::PositiveX,
            s: 1.0,
            t: 0.5,
        };

        assert!(is_gather_result_valid_cube_face_int(
            &faces,
            true,
            &prec,
            &coords,
            0,
            border,
            [20, 80, 80, 20]
        ));
        assert!(
            !is_gather_result_valid_cube_face_int(&faces, true, &prec, &coords, 0, border, [50, 50, 50, 50]),
            "the seamless-blended sample value must not be a valid gather result"
        );
        assert!(
            !is_gather_result_valid_cube_face_int(&faces, true, &prec, &coords, 0, border, [80, 20, 80, 20]),
            "the two +X taps and the two neighbour taps must not be swapped"
        );
    }
}

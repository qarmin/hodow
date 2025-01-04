// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTextureTestUtil.hpp / .cpp  (sampleTexture(SurfaceAccess, ...),
//   compareImages)
//   framework/opengl/gluTextureUtil.hpp / .cpp      (mapGLSampler)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `SurfaceAccess` overloads of
// `sampleTexture` go through `SurfaceAccess::write_with` (float scratch image, then the
// masked quantisation) because the sampling functions in `glu::texture_test_util` write
// into a `PixelBufferAccess`.
//
// `tcu::Sampler` here has one tap filter, so upstream's two-filter sampler is split:
// `map_gl_sampler` builds one half (`LodRange::Minified` maps the GL min filter, tap and
// mip blend; `Magnified` the mag filter) and `make_reference_params` builds the whole
// thing, min filter in `sampler` and the mag filter in `ReferenceParams::mag_filter`.
// `compareImages` returns the comparison result instead of writing to a log.

use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, TextureType, compute_texture_compare_diff_2d, compute_texture_compare_diff_2d_array,
    compute_texture_compare_diff_cube, compute_texture_compare_diff_cube_array, compute_texture_lookup_diff_2d,
    compute_texture_lookup_diff_2d_array, compute_texture_lookup_diff_3d, compute_texture_lookup_diff_cube,
    sample_texture_2d, sample_texture_2d_array, sample_texture_3d, sample_texture_cube, sample_texture_cube_array,
};
use crate::glw::GLenum;
use crate::sglr::reference_utils::{map_gl_mag_filter_mode, map_gl_min_filter_mode, map_gl_wrap_mode};
use crate::tcu::defs::TestError;
use crate::tcu::image_compare::{ThresholdCompareResult, pixel_threshold_compare};
use crate::tcu::pixel::{CompareMode, ConstPixelBufferAccess, CubeFace, PixelBufferAccess, Sampler};
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::tex_compare_verifier::TexComparePrecision;
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision, compute_fixed_point_error};
use crate::tcu::texture_2d::Texture2D as RefTexture2D;
use crate::tcu::texture_2d_array::Texture2DArray as RefTexture2DArray;
use crate::tcu::texture_3d::Texture3D as RefTexture3D;
use crate::tcu::texture_cube::TextureCube as RefTextureCube;
use crate::tcu::vector::Vec2;

/// Which half of a minification/magnification pair a `Sampler` is built for.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LodRange {
    Minified,
    Magnified,
}

/// `glu::mapGLSampler` (all three overloads - pass the same value for the wrap modes an
/// overload would repeat).
pub fn map_gl_sampler(
    wrap_s: GLenum,
    wrap_t: GLenum,
    wrap_r: GLenum,
    min_filter: GLenum,
    mag_filter: GLenum,
    range: LodRange,
) -> Result<Sampler, TestError> {
    let wrap = |mode: GLenum| {
        map_gl_wrap_mode(mode).ok_or_else(|| TestError::InternalError(format!("unmapped GL wrap mode {mode:#x}")))
    };
    let (filter, mip_filter) = match range {
        LodRange::Minified => map_gl_min_filter_mode(min_filter)
            .ok_or_else(|| TestError::InternalError(format!("unmapped GL min filter {min_filter:#x}")))?,
        LodRange::Magnified => (
            map_gl_mag_filter_mode(mag_filter)
                .ok_or_else(|| TestError::InternalError(format!("unmapped GL mag filter {mag_filter:#x}")))?,
            None,
        ),
    };
    Ok(Sampler {
        wrap_s: wrap(wrap_s)?,
        wrap_t: wrap(wrap_t)?,
        wrap_r: wrap(wrap_r)?,
        filter,
        normalized_coords: true,
        compare: CompareMode::None,
        compare_channel: 0,
        mip_filter,
        seamless_cube_map: false,
    })
}

fn collect_levels<'a>(
    num_levels: usize,
    is_empty: impl Fn(usize) -> bool,
    level: impl Fn(usize) -> ConstPixelBufferAccess<'a>,
) -> Vec<ConstPixelBufferAccess<'a>> {
    (0..num_levels)
        .take_while(|&l| !is_empty(l))
        .map(|l| level(l).into_effective_depth())
        .collect()
}

/// `sampleTexture(SurfaceAccess, Texture2DView, texCoord, params)` - `tex_coord` is the
/// quad's four `(s, t)` pairs.
pub fn sample_texture_2d_to_surface(
    dst: &mut SurfaceAccess<'_>,
    src: &RefTexture2D,
    tex_coord: [f32; 8],
    params: &ReferenceParams,
) -> Result<(), TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    let used = sampling_levels(&levels, params);
    dst.write_with(|access| sample_texture_2d(access, used, tex_coord, params))
}

/// `sampleTexture(SurfaceAccess, TextureCubeView, texCoord, params)`
pub fn sample_texture_cube_to_surface(
    dst: &mut SurfaceAccess<'_>,
    src: &RefTextureCube,
    tex_coord: [f32; 12],
    params: &ReferenceParams,
) -> Result<(), TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    let used = sampling_levels(&levels, params);
    dst.write_with(|access| sample_texture_cube(access, used, tex_coord, params))
}

/// `sampleTexture(SurfaceAccess, Texture2DArrayView, texCoord, params)`
pub fn sample_texture_2d_array_to_surface(
    dst: &mut SurfaceAccess<'_>,
    src: &RefTexture2DArray,
    tex_coord: [f32; 12],
    params: &ReferenceParams,
) -> Result<(), TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    let used = sampling_levels(&levels, params);
    dst.write_with(|access| sample_texture_2d_array(access, used, tex_coord, params))
}

/// `sampleTexture(SurfaceAccess, TextureCubeArrayView, texCoord, params)` - `src` holds six depth slices per cube layer.
pub fn sample_texture_cube_array_to_surface(
    dst: &mut SurfaceAccess<'_>,
    src: &RefTexture2DArray,
    tex_coord: [f32; 16],
    params: &ReferenceParams,
) -> Result<(), TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    let used = sampling_levels(&levels, params);
    dst.write_with(|access| sample_texture_cube_array(access, used, tex_coord, params))
}

/// `sampleTexture(SurfaceAccess, Texture3DView, texCoord, params)`
pub fn sample_texture_3d_to_surface(
    dst: &mut SurfaceAccess<'_>,
    src: &RefTexture3D,
    tex_coord: [f32; 12],
    params: &ReferenceParams,
) -> Result<(), TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    let used = sampling_levels(&levels, params);
    dst.write_with(|access| sample_texture_3d(access, used, tex_coord, params))
}

/// `glu::TextureTestUtil::compareImages(log, reference, rendered, threshold)`
pub fn compare_images(reference: &Surface, rendered: &Surface, threshold: RGBA) -> ThresholdCompareResult {
    pixel_threshold_compare(reference, rendered, threshold)
}

/// `computeQuadTexCoordCube(dst, face)` - the whole-face quad.
pub fn compute_quad_tex_coord_cube(face: CubeFace) -> [f32; 12] {
    match face {
        CubeFace::NegativeX => [-1.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0],
        CubeFace::PositiveX => [1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0, -1.0, 1.0, -1.0, -1.0],
        CubeFace::NegativeY => [-1.0, -1.0, 1.0, -1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0],
        CubeFace::PositiveY => [-1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0],
        CubeFace::NegativeZ => [1.0, 1.0, -1.0, 1.0, -1.0, -1.0, -1.0, 1.0, -1.0, -1.0, -1.0, -1.0],
        CubeFace::PositiveZ => [-1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0],
    }
}

/// `computeQuadTexCoordCube(dst, face, bottomLeft, topRight)` - a sub-rectangle of one face.
pub fn compute_quad_tex_coord_cube_region(face: CubeFace, bottom_left: Vec2, top_right: Vec2) -> [f32; 12] {
    let (m_row, s_row, t_row, m_sign, s_sign, t_sign) = match face {
        CubeFace::NegativeX => (0, 2, 1, -1.0f32, 1.0f32, -1.0f32),
        CubeFace::PositiveX => (0, 2, 1, 1.0, -1.0, -1.0),
        CubeFace::NegativeY => (1, 0, 2, -1.0, 1.0, -1.0),
        CubeFace::PositiveY => (1, 0, 2, 1.0, 1.0, 1.0),
        CubeFace::NegativeZ => (2, 0, 1, -1.0, -1.0, -1.0),
        CubeFace::PositiveZ => (2, 0, 1, 1.0, 1.0, -1.0),
    };

    let mut dst = [0.0f32; 12];
    for vertex in 0..4 {
        dst[vertex * 3 + m_row] = m_sign;
    }
    dst[s_row] = s_sign * bottom_left.x();
    dst[3 + s_row] = s_sign * bottom_left.x();
    dst[6 + s_row] = s_sign * top_right.x();
    dst[9 + s_row] = s_sign * top_right.x();

    dst[t_row] = t_sign * bottom_left.y();
    dst[3 + t_row] = t_sign * top_right.y();
    dst[6 + t_row] = t_sign * bottom_left.y();
    dst[9 + t_row] = t_sign * top_right.y();
    dst
}

/// `computeQuadTexCoordCubeArray(dst, face, bottomLeft, topRight, layerRange)` - the cube region quad with the layer coordinate as the fourth
/// component, interpolated from `layer_range.x` to `layer_range.y` over the vertices when the two differ.
pub fn compute_quad_tex_coord_cube_array(
    face: CubeFace,
    bottom_left: Vec2,
    top_right: Vec2,
    layer_range: Vec2,
) -> [f32; 16] {
    let cube = compute_quad_tex_coord_cube_region(face, bottom_left, top_right);
    let l0 = layer_range.x();
    let l1 = layer_range.y();
    let q: [f32; 4] = if l0 != l1 {
        [l0, l0 * 0.5 + l1 * 0.5, l0 * 0.5 + l1 * 0.5, l1]
    } else {
        [l0; 4]
    };
    std::array::from_fn(|i| {
        if i % 4 == 3 {
            q[i / 4]
        } else {
            cube[(i / 4) * 3 + i % 4]
        }
    })
}

/// `ReferenceParams(texType, mapGLSampler(wrapS, wrapT, wrapR, minFilter, magFilter))` -
/// the min filter (tap and mip blend) goes into `sampler`, the mag filter into
/// `ReferenceParams::mag_filter`, so one parameter set serves a quad that is minified in
/// one place and magnified in another exactly like upstream's two-filter `tcu::Sampler`.
pub fn make_reference_params(
    tex_type: TextureType,
    wrap_s: GLenum,
    wrap_t: GLenum,
    wrap_r: GLenum,
    min_filter: GLenum,
    mag_filter: GLenum,
    lod_mode: LodMode,
) -> Result<ReferenceParams, TestError> {
    let sampler = map_gl_sampler(wrap_s, wrap_t, wrap_r, min_filter, mag_filter, LodRange::Minified)?;
    let mag = map_gl_mag_filter_mode(mag_filter)
        .ok_or_else(|| TestError::InternalError(format!("unmapped GL mag filter {mag_filter:#x}")))?;
    let mut params = ReferenceParams::new(tex_type, sampler, lod_mode);
    params.mag_filter = Some(mag);
    Ok(params)
}

/// `glu::TextureTestUtil::getBitsVec`
pub fn get_bits_vec(format: PixelFormat) -> [i32; 4] {
    [format.red_bits, format.green_bits, format.blue_bits, format.alpha_bits]
}

/// `glu::TextureTestUtil::getCompareMask`
pub fn get_compare_mask(format: PixelFormat) -> [bool; 4] {
    [
        format.red_bits > 0,
        format.green_bits > 0,
        format.blue_bits > 0,
        format.alpha_bits > 0,
    ]
}

/// `tcu::computeFixedPointThreshold`
pub fn compute_fixed_point_threshold(bits: [i32; 4]) -> [f32; 4] {
    std::array::from_fn(|c| compute_fixed_point_error(bits[c].clamp(0, 23)))
}

fn verify_texture_result_with(
    result: &Surface,
    pixel_format: PixelFormat,
    sample: impl FnOnce(&mut SurfaceAccess<'_>) -> Result<(), TestError>,
    diff: impl FnOnce(&ConstPixelBufferAccess<'_>, &ConstPixelBufferAccess<'_>, &mut PixelBufferAccess<'_>) -> i32,
) -> Result<bool, TestError> {
    let mut reference = Surface::new(result.get_width(), result.get_height());
    let mut error_mask = Surface::new(result.get_width(), result.get_height());

    sample(&mut SurfaceAccess::new(&mut reference, pixel_format))?;
    let num_failed_pixels = diff(
        &result.get_const_access(),
        &reference.get_const_access(),
        &mut error_mask.get_access(),
    );
    Ok(num_failed_pixels == 0)
}

/// `verifyTextureResult(testCtx, result, Texture2DView, texCoord, sampleParams, lookupPrec,
/// lodPrec, pixelFormat)` - true when no pixel is an invalid lookup result.
pub fn verify_texture_result_2d(
    result: &Surface,
    src: &RefTexture2D,
    tex_coord: [f32; 8],
    sample_params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    verify_texture_result_with(
        result,
        pixel_format,
        |dst| sample_texture_2d_to_surface(dst, src, tex_coord, sample_params),
        |res, reference, mask| {
            compute_texture_lookup_diff_2d(
                res,
                reference,
                mask,
                effective_levels(&levels, sample_params),
                tex_coord,
                sample_params,
                lookup_prec,
                lod_prec,
            )
        },
    )
}

/// `verifyTextureResult` for a `TextureCubeView`.
pub fn verify_texture_result_cube(
    result: &Surface,
    src: &RefTextureCube,
    tex_coord: [f32; 12],
    sample_params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    verify_texture_result_with(
        result,
        pixel_format,
        |dst| sample_texture_cube_to_surface(dst, src, tex_coord, sample_params),
        |res, reference, mask| {
            compute_texture_lookup_diff_cube(
                res,
                reference,
                mask,
                effective_levels(&levels, sample_params),
                tex_coord,
                sample_params,
                lookup_prec,
                lod_prec,
            )
        },
    )
}

/// `verifyTextureResult` for a `Texture2DArrayView`.
pub fn verify_texture_result_2d_array(
    result: &Surface,
    src: &RefTexture2DArray,
    tex_coord: [f32; 12],
    sample_params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    verify_texture_result_with(
        result,
        pixel_format,
        |dst| sample_texture_2d_array_to_surface(dst, src, tex_coord, sample_params),
        |res, reference, mask| {
            compute_texture_lookup_diff_2d_array(
                res,
                reference,
                mask,
                effective_levels(&levels, sample_params),
                tex_coord,
                sample_params,
                lookup_prec,
                lod_prec,
            )
        },
    )
}

/// `verifyTextureResult` for a `Texture3DView`.
pub fn verify_texture_result_3d(
    result: &Surface,
    src: &RefTexture3D,
    tex_coord: [f32; 12],
    sample_params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    verify_texture_result_with(
        result,
        pixel_format,
        |dst| sample_texture_3d_to_surface(dst, src, tex_coord, sample_params),
        |res, reference, mask| {
            compute_texture_lookup_diff_3d(
                res,
                reference,
                mask,
                effective_levels(&levels, sample_params),
                tex_coord,
                sample_params,
                lookup_prec,
                lod_prec,
            )
        },
    )
}

/// The allocated mip levels of a reference 2D texture - what `Texture2DView` holds.
pub fn levels_2d(src: &RefTexture2D) -> Vec<ConstPixelBufferAccess<'_>> {
    collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l))
}

/// The allocated mip levels of a reference cube texture, six faces per level.
pub fn levels_cube(src: &RefTextureCube) -> Vec<ConstPixelBufferAccess<'_>> {
    collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l))
}

/// `glu::ContextInfo::isFragmentHighPrecisionSupported` - upstream compiles a fragment
/// shader declaring `precision highp float`; asking for the format highp has is the same
/// question without building a program.
pub fn is_fragment_high_precision_supported(gl: &crate::glw::Functions) -> bool {
    let mut range = [0i32; 2];
    let mut precision = 0i32;
    // SAFETY: both out parameters are valid for the one/two integers GL writes.
    unsafe {
        gl.get_shader_precision_format(
            crate::glw::GL_FRAGMENT_SHADER,
            crate::glw::GL_HIGH_FLOAT,
            range.as_mut_ptr(),
            &mut precision,
        )
    };
    !(range[0] == 0 && range[1] == 0 && precision == 0)
}

/// `tcu::computeColorBitsThreshold(bits, numAccurateBits)` - a channel with no bits
/// divides by zero and comes out infinite, exactly as upstream's float division does; its
/// compare mask is off, so nothing reads it.
pub fn compute_color_bits_threshold(bits: [i32; 4], num_accurate_bits: [i32; 4]) -> [f32; 4] {
    std::array::from_fn(|c| {
        let (b, n) = (bits[c], num_accurate_bits[c]);
        (((1i64 << (b - n).max(0)) as f32) + 1.0 / 256.0) / (((1i64 << b) - 1) as f32)
    })
}

/// `tcu::fillWithComponentGradients` (upstream's `GRADIENT_STYLE_OLD`). `tcu::pixel` has
/// no separate `Old` style: for a 2D level it is the same as `New`, and for a 3D one it is
/// what `Pyramid` computes (per-axis ramps), so the style is picked off the level's depth.
pub fn fill_with_component_gradients_old(access: &mut PixelBufferAccess<'_>, min_val: [f32; 4], max_val: [f32; 4]) {
    let style = if access.size()[2] > 1 {
        crate::tcu::pixel::GradientStyle::Pyramid
    } else {
        crate::tcu::pixel::GradientStyle::New
    };
    crate::tcu::pixel::fill_with_component_gradients_styled(access, min_val, max_val, style);
}

/// The `LookupPrecision` the filtering tests build from the render target: the colour
/// threshold is the fixed-point error of the bit depth minus one inaccurate bit (nearest
/// only) or two, divided by the lookup colour scale.
pub fn make_lookup_precision(
    pixel_format: PixelFormat,
    is_nearest_only: bool,
    color_scale: [f32; 4],
    coord_bits: [i32; 3],
    uvw_bits: [i32; 3],
) -> LookupPrecision {
    let color_bits = get_bits_vec(pixel_format).map(|b| (b - if is_nearest_only { 1 } else { 2 }).max(0));
    let fixed = compute_fixed_point_threshold(color_bits);
    LookupPrecision {
        coord_bits,
        uvw_bits,
        color_mask: get_compare_mask(pixel_format),
        color_threshold: std::array::from_fn(|c| fixed[c] / color_scale[c]),
        ..Default::default()
    }
}

/// `getSubView` - the mip range `[base_level, max_level]` of `levels`, clamped the way
/// `glu::texture_test_util`'s own sampling clamps it. The lookup-diff functions take the
/// already-sliced range, so a caller that sets `base_level`/`max_level` passes this.
pub fn sub_view_levels<'b, 'a>(
    levels: &'b [ConstPixelBufferAccess<'a>],
    base_level: i32,
    max_level: i32,
) -> &'b [ConstPixelBufferAccess<'a>] {
    let last = levels.len() as i32 - 1;
    let clamped_base = base_level.clamp(0, last);
    let clamped_max = max_level.clamp(clamped_base, last);
    &levels[clamped_base as usize..=clamped_max as usize]
}

fn verify_tex_compare_result_with(
    result: &Surface,
    pixel_format: PixelFormat,
    sample: impl FnOnce(&mut SurfaceAccess<'_>) -> Result<(), TestError>,
    diff: impl FnOnce(&ConstPixelBufferAccess<'_>, &ConstPixelBufferAccess<'_>, &mut PixelBufferAccess<'_>, [f32; 3]) -> i32,
) -> Result<bool, TestError> {
    let mut reference = Surface::new(result.get_width(), result.get_height());
    let mut error_mask = Surface::new(result.get_width(), result.get_height());

    let non_shadow_bits = get_bits_vec(pixel_format).map(|b| (b - 1).max(0));
    let fixed = compute_fixed_point_threshold(non_shadow_bits);
    let non_shadow_threshold = [fixed[1], fixed[2], fixed[3]];

    sample(&mut SurfaceAccess::new(&mut reference, pixel_format))?;
    let num_failed_pixels = diff(
        &result.get_const_access(),
        &reference.get_const_access(),
        &mut error_mask.get_access(),
        non_shadow_threshold,
    );
    Ok(num_failed_pixels == 0)
}

/// `verifyTexCompareResult` (`es3fTextureShadowTests.cpp`) for a `Texture2DView`, minus the
/// floating-point depth clamp, which the caller does in place on the reference texture.
pub fn verify_tex_compare_result_2d(
    result: &Surface,
    src: &RefTexture2D,
    tex_coord: [f32; 8],
    sample_params: &ReferenceParams,
    compare_prec: &TexComparePrecision,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    verify_tex_compare_result_with(
        result,
        pixel_format,
        |dst| sample_texture_2d_to_surface(dst, src, tex_coord, sample_params),
        |res, reference, mask, nst| {
            compute_texture_compare_diff_2d(
                res,
                reference,
                mask,
                effective_levels(&levels, sample_params),
                tex_coord,
                sample_params,
                compare_prec,
                lod_prec,
                nst,
            )
        },
    )
}

/// `verifyTexCompareResult` for a `TextureCubeView`.
pub fn verify_tex_compare_result_cube(
    result: &Surface,
    src: &RefTextureCube,
    tex_coord: [f32; 12],
    sample_params: &ReferenceParams,
    compare_prec: &TexComparePrecision,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    verify_tex_compare_result_with(
        result,
        pixel_format,
        |dst| sample_texture_cube_to_surface(dst, src, tex_coord, sample_params),
        |res, reference, mask, nst| {
            compute_texture_compare_diff_cube(
                res,
                reference,
                mask,
                effective_levels(&levels, sample_params),
                tex_coord,
                sample_params,
                compare_prec,
                lod_prec,
                nst,
            )
        },
    )
}

/// `verifyTexCompareResult` for a `TextureCubeArrayView` (`src` holds six depth slices per cube layer).
pub fn verify_tex_compare_result_cube_array(
    result: &Surface,
    src: &RefTexture2DArray,
    tex_coord: [f32; 16],
    sample_params: &ReferenceParams,
    compare_prec: &TexComparePrecision,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    verify_tex_compare_result_with(
        result,
        pixel_format,
        |dst| sample_texture_cube_array_to_surface(dst, src, tex_coord, sample_params),
        |res, reference, mask, nst| {
            compute_texture_compare_diff_cube_array(
                res,
                reference,
                mask,
                effective_levels(&levels, sample_params),
                tex_coord,
                sample_params,
                compare_prec,
                lod_prec,
                nst,
            )
        },
    )
}

/// `verifyTexCompareResult` for a `Texture2DArrayView`.
pub fn verify_tex_compare_result_2d_array(
    result: &Surface,
    src: &RefTexture2DArray,
    tex_coord: [f32; 12],
    sample_params: &ReferenceParams,
    compare_prec: &TexComparePrecision,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let levels = collect_levels(src.num_levels(), |l| src.is_level_empty(l), |l| src.level(l));
    verify_tex_compare_result_with(
        result,
        pixel_format,
        |dst| sample_texture_2d_array_to_surface(dst, src, tex_coord, sample_params),
        |res, reference, mask, nst| {
            compute_texture_compare_diff_2d_array(
                res,
                reference,
                mask,
                effective_levels(&levels, sample_params),
                tex_coord,
                sample_params,
                compare_prec,
                lod_prec,
                nst,
            )
        },
    )
}

/// The mip range a lookup *verifier* searches: the `[base_level, max_level]` slice, cut down
/// to its first level when the minification filter does not mipmap at all
/// (`GL_NEAREST`/`GL_LINEAR` map to `Sampler::mip_filter == None`; `tcu::pixel`'s sampling
/// and `tcu::tex_verifier` read that as the `*_MIPMAP_NEAREST` shape, whereas GL samples
/// the base level alone).
pub fn effective_levels<'b, 'a>(
    levels: &'b [ConstPixelBufferAccess<'a>],
    params: &ReferenceParams,
) -> &'b [ConstPixelBufferAccess<'a>] {
    let view = sub_view_levels(levels, params.base_level, params.max_level);
    if params.sampler.mip_filter.is_none() {
        &view[..1]
    } else {
        view
    }
}

/// What the `sample_texture_*` reference functions are given: they slice by
/// `base_level`/`max_level` themselves, so the full range goes in - except for a
/// non-mipmapping minification filter, where the base level alone does (see
/// `effective_levels`).
fn sampling_levels<'b, 'a>(
    levels: &'b [ConstPixelBufferAccess<'a>],
    params: &ReferenceParams,
) -> &'b [ConstPixelBufferAccess<'a>] {
    if params.sampler.mip_filter.is_none() {
        effective_levels(levels, params)
    } else {
        levels
    }
}

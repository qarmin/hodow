// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTextureTestUtil.cpp  (GenMipmapPrecision, compareGenMipmapResult)
//   modules/gles2/functional/es2fTextureMipmapTests.cpp  (Texture2DGenMipmapCase, TextureCubeGenMipmapCase)
//   modules/gles3/functional/es3fTextureMipmapTests.cpp  (the same two cases)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two upstream files differ in the
// renderer's GLSL version/precision only (`es3` flag here); upstream's ES 2.0 `tcu::Texture2D`
// `es2` constructor flag is not modelled (the reference pyramid is always the full one). Image
// logging is dropped: the case's status carries the first failing level instead.

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{RenderParams, TextureType, compute_quad_tex_coord_2d};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, compute_quad_tex_coord_cube, get_bits_vec, get_compare_mask,
};
use crate::glu::texture_util::map_gl_transfer_format;
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, CubeFace, fill_with_grid, get_texture_format_bit_depth};
use crate::tcu::random::de_int32_hash;
use crate::tcu::tex_verifier::{LookupPrecision, WrapMode, is_linear_sample_result_valid_2d};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::texture_2d::Texture2D as RefTexture2D;
use crate::tcu::texture_cube::TextureCube as RefTextureCube;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus, de_string_hash};

/// `GenMipmapPrecision`
#[derive(Clone, Copy)]
pub struct GenMipmapPrecision {
    /// Bits in filtering parameters (fixed-point).
    pub filter_bits: [i32; 3],
    /// Threshold for color value comparison.
    pub color_threshold: [f32; 4],
    /// Color channel comparison mask.
    pub color_mask: [bool; 4],
}

/// `qpTestResult` as `compareGenMipmapResult` returns it.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum GenMipmapResult {
    Pass,
    QualityWarning,
    Fail,
}

fn lookup_precision(precision: &GenMipmapPrecision) -> LookupPrecision {
    LookupPrecision {
        coord_bits: [22; 3],
        uvw_bits: precision.filter_bits,
        color_mask: precision.color_mask,
        color_threshold: precision.color_threshold,
        ..Default::default()
    }
}

fn level_size(access: &ConstPixelBufferAccess<'_>) -> (i32, i32) {
    let [w, h, _] = access.size();
    (w as i32, h as i32)
}

/// `compareGenMipmapBilinear` - the number of failing pixels.
fn compare_gen_mipmap_bilinear(
    dst: &ConstPixelBufferAccess<'_>,
    src: &ConstPixelBufferAccess<'_>,
    precision: &GenMipmapPrecision,
) -> i32 {
    let (dst_w, dst_h) = level_size(dst);
    let (src_w, src_h) = level_size(src);
    let prec = lookup_precision(precision);
    let mut num_failed = 0;

    for y in 0..dst_h {
        for x in 0..dst_w {
            let result = dst.get_pixel(x as u32, y as u32, 0);
            let cx = (x as f32 + 0.5) / dst_w as f32 * src_w as f32;
            let cy = (y as f32 + 0.5) / dst_h as f32 * src_h as f32;
            let is_ok = is_linear_sample_result_valid_2d(
                src,
                WrapMode::ClampToEdge,
                WrapMode::ClampToEdge,
                false,
                &prec,
                [cx, cy],
                0,
                result,
            );

            if !is_ok {
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `compareGenMipmapBox`
fn compare_gen_mipmap_box(
    dst: &ConstPixelBufferAccess<'_>,
    src: &ConstPixelBufferAccess<'_>,
    precision: &GenMipmapPrecision,
) -> i32 {
    let (dst_w, dst_h) = level_size(dst);
    let (src_w, src_h) = level_size(src);
    let prec = lookup_precision(precision);
    let mut num_failed = 0;

    for y in 0..dst_h {
        for x in 0..dst_w {
            let result = dst.get_pixel(x as u32, y as u32, 0);
            let cx = (x as f32 / dst_w as f32 * src_w as f32).floor() + 1.0;
            let cy = (y as f32 / dst_h as f32 * src_h as f32).floor() + 1.0;
            let is_ok = is_linear_sample_result_valid_2d(
                src,
                WrapMode::ClampToEdge,
                WrapMode::ClampToEdge,
                false,
                &prec,
                [cx, cy],
                0,
                result,
            );

            if !is_ok {
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `compareGenMipmapVeryLenient`
fn compare_gen_mipmap_very_lenient(dst: &ConstPixelBufferAccess<'_>, src: &ConstPixelBufferAccess<'_>) -> i32 {
    let (dst_w, dst_h) = level_size(dst);
    let (src_w, src_h) = level_size(src);
    let mut num_failed = 0;

    for y in 0..dst_h {
        for x in 0..dst_w {
            let result = dst.get_pixel(x as u32, y as u32, 0);
            let min_x = (((x as f32) - 0.5) / dst_w as f32 * src_w as f32).floor() as i32;
            let min_y = (((y as f32) - 0.5) / dst_h as f32 * src_h as f32).floor() as i32;
            let max_x = (((x as f32) + 1.5) / dst_w as f32 * src_w as f32).ceil() as i32;
            let max_y = (((y as f32) + 1.5) / dst_h as f32 * src_h as f32).ceil() as i32;
            let mut min_val = [0.0f32; 4];
            let mut max_val = [0.0f32; 4];

            debug_assert!(min_x < max_x && min_y < max_y);

            for ky in min_y..=max_y {
                for kx in min_x..=max_x {
                    let sx = kx.clamp(0, src_w - 1);
                    let sy = ky.clamp(0, src_h - 1);
                    let sample = src.get_pixel(sx as u32, sy as u32, 0);

                    if ky == min_y && kx == min_x {
                        min_val = sample;
                        max_val = sample;
                    } else {
                        for c in 0..4 {
                            min_val[c] = min_val[c].min(sample[c]);
                            max_val[c] = max_val[c].max(sample[c]);
                        }
                    }
                }
            }

            let is_ok = (0..4).all(|c| min_val[c] <= result[c] && result[c] <= max_val[c]);
            if !is_ok {
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// One level of the quality-ordered method list shared by the 2D and cube versions: updates
/// `result` the way the upstream loop body does and returns an error text when the level fails.
fn compare_level(
    dst: &ConstPixelBufferAccess<'_>,
    src: &ConstPixelBufferAccess<'_>,
    precision: &GenMipmapPrecision,
    result: &mut GenMipmapResult,
    what: &str,
) -> Option<String> {
    // Try different comparisons in quality order.
    if compare_gen_mipmap_bilinear(dst, src, precision) == 0 {
        return None;
    }

    if compare_gen_mipmap_box(dst, src, precision) == 0 {
        return None;
    }

    // At this point all high-quality methods have been used.
    if *result == GenMipmapResult::Pass {
        *result = GenMipmapResult::QualityWarning;
    }

    let num_failed = compare_gen_mipmap_very_lenient(dst, src);
    if num_failed == 0 {
        return None;
    }

    *result = GenMipmapResult::Fail;
    Some(format!(
        "{what} appears to contain {num_failed} completely wrong pixels"
    ))
}

fn level0_threshold(precision: &GenMipmapPrecision) -> [f32; 4] {
    std::array::from_fn(|c| {
        if precision.color_mask[c] {
            precision.color_threshold[c]
        } else {
            1.0
        }
    })
}

/// `compareGenMipmapResult` (the `tcu::Texture2D` overload); the second value describes the first failure.
pub fn compare_gen_mipmap_result_2d(
    result_texture: &RefTexture2D,
    level0_reference: &RefTexture2D,
    precision: &GenMipmapPrecision,
) -> (GenMipmapResult, Option<String>) {
    let mut result = GenMipmapResult::Pass;
    let mut failure: Option<String> = None;

    // Special comparison for level 0.
    if !float_threshold_compare(
        &level0_reference.level(0),
        &result_texture.level(0),
        level0_threshold(precision),
    )
    .ok
    {
        result = GenMipmapResult::Fail;
        failure = Some("Level 0 comparison failed".to_string());
    }

    for level_ndx in 1..result_texture.num_levels() {
        let src = result_texture.level(level_ndx - 1);
        let dst = result_texture.level(level_ndx);

        if let Some(message) = compare_level(&dst, &src, precision, &mut result, &format!("Level {level_ndx}")) {
            failure.get_or_insert(message);
        }
    }

    (result, failure)
}

const FACE_NAMES: [&str; 6] = ["-X", "+X", "-Y", "+Y", "-Z", "+Z"];

const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

/// `compareGenMipmapResult` (the `tcu::TextureCube` overload).
pub fn compare_gen_mipmap_result_cube(
    result_texture: &RefTextureCube,
    level0_reference: &RefTextureCube,
    precision: &GenMipmapPrecision,
) -> (GenMipmapResult, Option<String>) {
    let mut result = GenMipmapResult::Pass;
    let mut failure: Option<String> = None;

    // Special comparison for level 0.
    for (face_ndx, &face) in FACES.iter().enumerate() {
        if !float_threshold_compare(
            &level0_reference.face_level(face, 0),
            &result_texture.face_level(face, 0),
            level0_threshold(precision),
        )
        .ok
        {
            result = GenMipmapResult::Fail;
            failure.get_or_insert(format!("Level 0, face {} comparison failed", FACE_NAMES[face_ndx]));
        }
    }

    for level_ndx in 1..result_texture.num_levels() {
        for (face_ndx, &face) in FACES.iter().enumerate() {
            let src = result_texture.face_level(face, level_ndx - 1);
            let dst = result_texture.face_level(face, level_ndx);

            if let Some(message) = compare_level(
                &dst,
                &src,
                precision,
                &mut result,
                &format!("Level {level_ndx}, face {}", FACE_NAMES[face_ndx]),
            ) {
                failure.get_or_insert(message);
            }
        }
    }

    (result, failure)
}

fn log2_floor(value: i32) -> usize {
    (31 - (value as u32).leading_zeros()) as usize
}

/// The precision both cases build once the result is read back.
fn comparison_precision(context: &Context, format: u32, data_type: u32) -> Result<GenMipmapPrecision, TestError> {
    let pixel_format = context.render_target().pixel_format();
    let framebuffer_bits = get_bits_vec(pixel_format).map(|b| (b - 2).max(0));
    let tex_format = map_gl_transfer_format(format, data_type)
        .ok_or_else(|| TestError::Fail(format!("unsupported (format, type) pair ({format:#x}, {data_type:#x})")))?;
    let format_bits = get_texture_format_bit_depth(tex_format);
    let cmp_bits: [i32; 4] = std::array::from_fn(|c| {
        if format_bits[c] > 0 {
            framebuffer_bits[c].min(format_bits[c])
        } else {
            framebuffer_bits[c]
        }
    });

    Ok(GenMipmapPrecision {
        color_mask: get_compare_mask(pixel_format),
        color_threshold: compute_fixed_point_threshold(cmp_bits),
        filter_bits: [4, 4, 0],
    })
}

fn to_status(result: GenMipmapResult, failure: Option<String>) -> TestStatus {
    match result {
        GenMipmapResult::Pass => TestStatus::pass("Pass"),
        GenMipmapResult::QualityWarning => TestStatus::new(TestResult::QualityWarning, "Low-quality method used"),
        GenMipmapResult::Fail => TestStatus::fail(match failure {
            Some(message) => format!("Image comparison failed: {message}"),
            None => "Image comparison failed".to_string(),
        }),
    }
}

fn renderer_setup(es3: bool) -> (GlslVersion, Precision) {
    if es3 {
        (GlslVersion::Es300, Precision::HighP)
    } else {
        (GlslVersion::Es100, Precision::MediumP)
    }
}

/// `Texture2DGenMipmapCase`
pub struct Texture2DGenMipmapCase {
    pub es3: bool,
    pub name: String,
    pub format: u32,
    pub data_type: u32,
    pub hint: u32,
    pub width: i32,
    pub height: i32,
}

impl TestCase for Texture2DGenMipmapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        let min_filter = glw::GL_NEAREST_MIPMAP_NEAREST;
        let mag_filter = glw::GL_NEAREST;
        let wrap_s = glw::GL_CLAMP_TO_EDGE;
        let wrap_t = glw::GL_CLAMP_TO_EDGE;

        let num_levels = log2_floor(self.width.max(self.height)) + 1;

        // `init`
        let (glsl_version, precision) = renderer_setup(self.es3);
        let mut renderer = TextureRenderer::new(render_ctx, glsl_version, precision);
        let mut texture = Texture2D::new(
            render_ctx,
            self.format,
            self.data_type,
            self.width as u32,
            self.height as u32,
        )?;

        let mut result_texture = RefTexture2D::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            texture.ref_texture().width(),
            texture.ref_texture().height(),
        );

        // Initialize texture level 0 with colored grid.
        texture.ref_texture_mut().alloc_level(0);
        fill_with_grid(
            &mut texture.ref_texture_mut().level_mut(0),
            8,
            [1.0, 0.5, 0.0, 0.5],
            [0.0, 0.0, 1.0, 1.0],
        );

        // Upload data and setup params.
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            texture.upload()?;

            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, min_filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }
        glu::expect_no_error(gl, "After texture setup")?;

        // Generate mipmap.
        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.hint(glw::GL_GENERATE_MIPMAP_HINT, self.hint);
            gl.generate_mipmap(glw::GL_TEXTURE_2D);
        }
        glu::expect_no_error(gl, "glGenerateMipmap()")?;

        // Use (0, 0) -> (1, 1) texture coordinates.
        let tex_coord = compute_quad_tex_coord_2d(
            crate::tcu::vector::Vec2::new(0.0, 0.0),
            crate::tcu::vector::Vec2::new(1.0, 1.0),
        );
        let params = RenderParams::new(TextureType::Texture2D);

        // Fetch resulting texture by rendering.
        for level_ndx in 0..num_levels {
            let level_width = (self.width >> level_ndx).max(1);
            let level_height = (self.height >> level_ndx).max(1);
            let viewport = RandomViewport::new(
                &render_target,
                level_width,
                level_height,
                de_string_hash(&self.name).wrapping_add(level_ndx as u32),
            );

            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height) };
            renderer.render_quad(0, &tex_coord, &params)?;

            result_texture.alloc_level(level_ndx);
            read_pixels(
                render_ctx,
                viewport.x,
                viewport.y,
                &mut result_texture.level_mut(level_ndx),
            )?;
        }

        // Compare results.
        let compare_prec = comparison_precision(context, self.format, self.data_type)?;
        let (result, failure) = compare_gen_mipmap_result_2d(&result_texture, texture.ref_texture(), &compare_prec);

        Ok(to_status(result, failure))
    }
}

/// `TextureCubeGenMipmapCase`
pub struct TextureCubeGenMipmapCase {
    pub es3: bool,
    pub name: String,
    pub format: u32,
    pub data_type: u32,
    pub hint: u32,
    pub size: i32,
}

impl TestCase for TextureCubeGenMipmapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        let min_filter = glw::GL_NEAREST_MIPMAP_NEAREST;
        let mag_filter = glw::GL_NEAREST;
        let wrap_s = glw::GL_CLAMP_TO_EDGE;
        let wrap_t = glw::GL_CLAMP_TO_EDGE;

        // `init`
        if render_target.width < 3 * self.size || render_target.height < 2 * self.size {
            return Err(TestError::NotSupported(format!(
                "Render target size must be at least ({}, {})",
                3 * self.size,
                2 * self.size
            )));
        }

        let (glsl_version, precision) = renderer_setup(self.es3);
        let mut renderer = TextureRenderer::new(render_ctx, glsl_version, precision);
        let mut texture = TextureCube::new(render_ctx, self.format, self.data_type, self.size as u32)?;

        let mut result_texture = RefTextureCube::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            self.size as u32,
        );

        let num_levels = log2_floor(self.size) + 1;

        // Initialize texture level 0 with colored grid.
        const GRID_COLORS: [([f32; 4], [f32; 4]); 6] = [
            ([1.0, 0.3, 0.0, 0.7], [0.0, 0.0, 1.0, 1.0]),
            ([0.0, 1.0, 0.5, 0.5], [1.0, 0.0, 0.0, 1.0]),
            ([0.7, 0.0, 1.0, 0.3], [0.0, 1.0, 0.0, 1.0]),
            ([0.0, 0.3, 1.0, 1.0], [1.0, 0.0, 0.0, 0.7]),
            ([1.0, 0.0, 0.5, 1.0], [0.0, 1.0, 0.0, 0.5]),
            ([0.7, 1.0, 0.0, 1.0], [0.0, 0.0, 1.0, 0.3]),
        ];
        texture.ref_texture_mut().alloc_level(0);
        for (face_ndx, &face) in FACES.iter().enumerate() {
            fill_with_grid(
                &mut texture.ref_texture_mut().face_level_mut(face, 0),
                8,
                GRID_COLORS[face_ndx].0,
                GRID_COLORS[face_ndx].1,
            );
        }

        // Upload data and setup params.
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            texture.upload()?;

            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_MIN_FILTER, min_filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }
        glu::expect_no_error(gl, "After texture setup")?;

        // Generate mipmap.
        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.hint(glw::GL_GENERATE_MIPMAP_HINT, self.hint);
            gl.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
        }
        glu::expect_no_error(gl, "glGenerateMipmap()")?;

        let params = RenderParams::new(TextureType::Cube);

        // Render all levels.
        for level_ndx in 0..num_levels {
            let level_width = (self.size >> level_ndx).max(1);
            let level_height = (self.size >> level_ndx).max(1);

            result_texture.alloc_level(level_ndx);

            for (face_ndx, &face) in FACES.iter().enumerate() {
                let viewport = RandomViewport::new(
                    &render_target,
                    level_width * 3,
                    level_height * 2,
                    de_string_hash(&self.name) ^ de_int32_hash(level_ndx as i32 + face_ndx as i32),
                );
                let tex_coord = compute_quad_tex_coord_cube(face);

                // SAFETY: plain state setting on the current context.
                unsafe { gl.viewport(viewport.x, viewport.y, level_width, level_height) };
                renderer.render_quad(0, &tex_coord, &params)?;

                read_pixels(
                    render_ctx,
                    viewport.x,
                    viewport.y,
                    &mut result_texture.face_level_mut(face, level_ndx),
                )?;
            }
        }

        // Compare results.
        let compare_prec = comparison_precision(context, self.format, self.data_type)?;
        let (result, failure) = compare_gen_mipmap_result_cube(&result_texture, texture.ref_texture(), &compare_prec);

        Ok(to_status(result, failure))
    }
}

/// The unsized formats both modules' `generate` groups walk, as (name, format, type).
pub const GEN_MIPMAP_FORMATS: [(&str, u32, u32); 8] = [
    ("a8", glw::GL_ALPHA, glw::GL_UNSIGNED_BYTE),
    ("l8", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
    ("la88", glw::GL_LUMINANCE_ALPHA, glw::GL_UNSIGNED_BYTE),
    ("rgb565", glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_6_5),
    ("rgb888", glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
    ("rgba4444", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
    ("rgba5551", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_5_5_1),
    ("rgba8888", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
];

const GEN_HINTS: [(&str, u32); 2] = [("fastest", glw::GL_FASTEST), ("nicest", glw::GL_NICEST)];

/// The `generate` group of the `2d` mipmap group; `sizes` is upstream's `tex2DSizes`.
pub fn create_2d_generate_group(es3: bool, sizes: &[(Option<&str>, i32, i32)]) -> TestCaseGroup {
    let mut gen_mipmap_group = TestCaseGroup::new("generate");

    for &(format_name, format, data_type) in &GEN_MIPMAP_FORMATS {
        for &(size_name, width, height) in sizes {
            for &(hint_name, hint) in &GEN_HINTS {
                let mut name = format_name.to_string();
                if let Some(size_name) = size_name {
                    name += &format!("_{size_name}");
                }
                name += &format!("_{hint_name}");

                gen_mipmap_group.add_child(Box::new(Texture2DGenMipmapCase {
                    es3,
                    name,
                    format,
                    data_type,
                    hint,
                    width,
                    height,
                }) as Box<dyn TestCase>);
            }
        }
    }

    gen_mipmap_group
}

/// The `generate` group of the `cube` mipmap group.
pub fn create_cube_generate_group(es3: bool, cube_map_size: i32) -> TestCaseGroup {
    let mut gen_mipmap_group = TestCaseGroup::new("generate");

    for &(format_name, format, data_type) in &GEN_MIPMAP_FORMATS {
        for &(hint_name, hint) in &GEN_HINTS {
            let name = format!("{format_name}_{hint_name}");
            gen_mipmap_group.add_child(Box::new(TextureCubeGenMipmapCase {
                es3,
                name,
                format,
                data_type,
                hint,
                size: cube_map_size,
            }) as Box<dyn TestCase>);
        }
    }

    gen_mipmap_group
}

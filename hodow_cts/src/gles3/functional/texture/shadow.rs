// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureShadowTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. One `iterate()` loops over the `FilterCase`s
// upstream runs one per call; the verdict is the same (Fail beats QualityWarning beats Pass).
//
// `verifyTexCompareResult` clamps floating-point depth texels to [0, 1] on a *copy* of the
// source texture, because upstream's `sampleTexture` expects the state a GL implementation
// has after upload. This port's reference textures are not clonable, and nothing reads them
// again after verification, so they are clamped in place right after the upload instead.

use crate::gles3::functional::texture::filtering::{Quality, verify_two_tier};
use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_2d_array::Texture2DArray;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{LodMode, SamplerType, TextureType, compute_quad_tex_coord_2d};
use crate::glu::texture_test_util_surface::{
    compute_quad_tex_coord_cube_region, fill_with_component_gradients_old, make_reference_params,
    verify_tex_compare_result_2d, verify_tex_compare_result_2d_array, verify_tex_compare_result_cube,
};
use crate::glu::{Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::sglr::reference_utils::map_gl_compare_func;
use crate::tcu::pixel::{CubeFace, PixelBufferAccess, fill_with_grid, get_texture_format_info};
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::tex_compare_verifier::TexComparePrecision;
use crate::tcu::tex_verifier::LodPrecision;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::Vec2;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus, de_string_hash};

const TEX2D_VIEWPORT_WIDTH: i32 = 64;
const TEX2D_VIEWPORT_HEIGHT: i32 = 64;
const TEX2D_MIN_VIEWPORT_WIDTH: i32 = 64;
const TEX2D_MIN_VIEWPORT_HEIGHT: i32 = 64;

const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

/// `isFloatingPointDepthFormat` - only two depth and depth-stencil formats are floating point.
fn is_floating_point_depth_format(format: TextureFormat) -> bool {
    (format.order == ChannelOrder::D && format.type_ == ChannelType::FLOAT)
        || (format.order == ChannelOrder::DS && format.type_ == ChannelType::FLOAT_UNSIGNED_INT_24_8_REV)
}

/// `clampFloatingPointTexture(const tcu::PixelBufferAccess &)`
fn clamp_floating_point_level(access: &mut PixelBufferAccess<'_>) {
    let [width, height, depth] = access.size();
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let clamped = access.get_pix_depth(x, y, z).clamp(0.0, 1.0);
                access.set_pix_depth(clamped, x, y, z);
            }
        }
    }
}

fn scale_bias(v: [f32; 4], scale: [f32; 4], bias: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|c| v[c] * scale[c] + bias[c])
}

fn log2_floor(value: i32) -> usize {
    (31 - (value as u32).leading_zeros()) as usize
}

fn grid_colors(num_levels: usize, level_ndx: usize, face_ndx: usize, cube: bool) -> (RGBA, RGBA) {
    let rgb = if cube {
        let step = 0x00ff_ffffu32 / (num_levels as u32 * 6);
        step.wrapping_mul(level_ndx as u32).wrapping_mul(face_ndx as u32)
    } else {
        (0x00ff_ffffu32 / num_levels as u32) * level_ndx as u32
    };
    (
        RGBA::from_packed(0xff00_0000 | rgb),
        RGBA::from_packed(0xff00_0000 | !rgb),
    )
}

#[derive(Clone, Copy)]
enum Kind {
    Tex2D { width: i32, height: i32 },
    Cube { size: i32 },
    Array { width: i32, height: i32, num_layers: i32 },
}

struct ShadowCase {
    name: String,
    kind: Kind,
    min_filter: u32,
    mag_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
    format: u32,
    compare_func: u32,
}

impl ShadowCase {
    fn ref_values(&self) -> (f32, f32, f32, f32) {
        let eq = self.compare_func == glw::GL_EQUAL || self.compare_func == glw::GL_NOTEQUAL;
        // in-range upper, in-range lower, out-of-bounds upper (clamped by the lookup), out-of-bounds lower
        (if eq { 1.0 } else { 0.5 }, if eq { 0.0 } else { 0.5 }, 1.1, -0.1)
    }

    fn set_texture_state(&self, context: &Context, target: u32, wrap_s: u32, wrap_t: u32) {
        let gl = context.gl();
        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, self.mag_filter as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
            gl.tex_parameteri(
                target,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_COMPARE_REF_TO_TEXTURE as i32,
            );
            gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, self.compare_func as i32);
        }
    }

    fn shadow_params(
        &self,
        tex_type: TextureType,
        wrap_s: u32,
        wrap_t: u32,
        ref_: f32,
    ) -> Result<crate::glu::texture_test_util::ReferenceParams, TestError> {
        let mut params = make_reference_params(
            tex_type,
            wrap_s,
            wrap_t,
            wrap_s,
            self.min_filter,
            self.mag_filter,
            LodMode::Exact,
        )?;
        params.sampler.compare = map_gl_compare_func(self.compare_func)
            .ok_or_else(|| TestError::InternalError(format!("unmapped GL compare func {:#x}", self.compare_func)))?;
        params.base.sampler_type = SamplerType::Shadow;
        params.base.ref_ = ref_;
        Ok(params)
    }

    fn compare_precision(context: &Context, coord_bits: [i32; 3], uvw_bits: [i32; 3]) -> TexComparePrecision {
        TexComparePrecision {
            coord_bits,
            uvw_bits,
            pcf_bits: 5,
            reference_bits: 16,
            result_bits: context.render_target().pixel_format().red_bits - 1,
            ..Default::default()
        }
    }

    fn iterate_2d(&self, context: &Context, width: i32, height: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `Texture2DShadowCase::init`: create 2 textures.
        let mut textures = Vec::with_capacity(2);
        for _ in 0..2 {
            textures.push(Texture2D::new_sized(
                render_ctx,
                self.format,
                width as u32,
                height as u32,
            )?);
        }
        let num_levels = textures[0].ref_texture().num_levels();

        // Fill first gradient texture.
        for level_ndx in 0..num_levels {
            textures[0].ref_texture_mut().alloc_level(level_ndx);
            let mut level = textures[0].ref_texture_mut().level_mut(level_ndx);
            fill_with_component_gradients_old(&mut level, [-0.5, -0.5, -0.5, 2.0], [1.0, 1.0, 1.0, 0.0]);
        }

        // Fill second with grid texture.
        for level_ndx in 0..num_levels {
            let (color_a, color_b) = grid_colors(num_levels, level_ndx, 0, false);
            textures[1].ref_texture_mut().alloc_level(level_ndx);
            let mut level = textures[1].ref_texture_mut().level_mut(level_ndx);
            fill_with_grid(&mut level, 4, color_a.to_vec().m_data, color_b.to_vec().m_data);
        }

        // Upload.
        for texture in &textures {
            // SAFETY: a current context; `texture` outlives the call.
            unsafe { texture.upload()? };
        }
        if is_floating_point_depth_format(textures[0].ref_texture().format()) {
            for texture in &mut textures {
                for level_ndx in 0..texture.ref_texture().num_levels() {
                    if !texture.ref_texture().is_level_empty(level_ndx) {
                        clamp_floating_point_level(&mut texture.ref_texture_mut().level_mut(level_ndx));
                    }
                }
            }
        }

        // Compute cases.
        let (in_range_upper, in_range_lower, out_of_bounds_upper, out_of_bounds_lower) = self.ref_values();
        let cases: [(usize, f32, f32, f32, f32, f32); 6] = [
            (0, in_range_upper, 1.6, 2.9, -1.0, -2.7),
            (0, in_range_lower, -2.0, -1.35, -0.2, 0.7),
            (1, in_range_upper, 0.14, 0.275, -1.5, -1.1),
            (1, in_range_lower, -0.92, -2.64, 0.4, -0.1),
            (1, out_of_bounds_upper, -0.39, -0.52, 0.65, 0.87),
            (1, out_of_bounds_lower, -1.55, 0.65, 0.35, 0.91),
        ];
        let viewport_w = TEX2D_VIEWPORT_WIDTH.min(render_target.width) as f32;
        let viewport_h = TEX2D_VIEWPORT_HEIGHT.min(render_target.height) as f32;

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut worst = Quality::High;

        for (case_ndx, &(tex_ndx, ref_, lod_x, lod_y, o_x, o_y)) in cases.iter().enumerate() {
            let texture = &textures[tex_ndx.min(textures.len() - 1)];
            let s_x = lod_x.exp2() * viewport_w / texture.ref_texture().width() as f32;
            let s_y = lod_y.exp2() * viewport_h / texture.ref_texture().height() as f32;

            let viewport = RandomViewport::new(
                &render_target,
                TEX2D_VIEWPORT_WIDTH,
                TEX2D_VIEWPORT_HEIGHT,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );
            let mut rendered = Surface::new(viewport.width, viewport.height);

            if viewport.width < TEX2D_MIN_VIEWPORT_WIDTH || viewport.height < TEX2D_MIN_VIEWPORT_HEIGHT {
                return Err(TestError::NotSupported("Too small render target".to_string()));
            }

            // Setup params for reference.
            let sample_params = self.shadow_params(TextureType::Texture2D, self.wrap_s, self.wrap_t, ref_)?;
            let tex_coord = compute_quad_tex_coord_2d(Vec2::new(o_x, o_y), Vec2::new(o_x + s_x, o_y + s_y));

            // SAFETY: plain state setting on the current context.
            unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture()) };
            self.set_texture_state(context, glw::GL_TEXTURE_2D, self.wrap_s, self.wrap_t);
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height) };

            renderer.render_quad(0, &tex_coord, &sample_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered.get_access())?;

            let high = (
                Self::compare_precision(context, [20, 20, 0], [7, 7, 0]),
                LodPrecision {
                    derivate_bits: 18,
                    lod_bits: 6,
                },
            );
            let mut low_prec = Self::compare_precision(context, [20, 20, 0], [4, 4, 0]);
            low_prec.pcf_bits = 0;
            let low = (
                low_prec,
                LodPrecision {
                    derivate_bits: 18,
                    lod_bits: 4,
                },
            );
            let quality = verify_two_tier(high, low, |prec, lod| {
                verify_tex_compare_result_2d(
                    &rendered,
                    texture.ref_texture(),
                    tex_coord,
                    &sample_params,
                    prec,
                    lod,
                    pixel_format,
                )
            })?;
            worst = worst.max(quality);
        }

        outcome(worst)
    }

    fn iterate_cube(&self, context: &Context, size: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `TextureCubeShadowCase::init`
        let num_levels = log2_floor(size) + 1;
        let mut gradient_tex = TextureCube::new_sized(render_ctx, self.format, size as u32)?;
        let mut grid_tex = TextureCube::new_sized(render_ctx, self.format, size as u32)?;
        let fmt_info = get_texture_format_info(gradient_tex.ref_texture().format());
        let c_bias = fmt_info.value_min;
        let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);

        const GRADIENTS: [([f32; 4], [f32; 4]); 6] = [
            ([-1.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]), // negative x
            ([0.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // positive x
            ([-1.0, 0.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // negative y
            ([-1.0, -1.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // positive y
            ([-1.0, -1.0, -1.0, 0.0], [1.0, 1.0, 1.0, 1.0]), // negative z
            ([0.0, 0.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]),    // positive z
        ];
        for level_ndx in 0..num_levels {
            gradient_tex.ref_texture_mut().alloc_level(level_ndx);
            grid_tex.ref_texture_mut().alloc_level(level_ndx);
        }
        for (face_ndx, &face) in FACES.iter().enumerate() {
            for level_ndx in 0..num_levels {
                let mut level = gradient_tex.ref_texture_mut().face_level_mut(face, level_ndx);
                fill_with_component_gradients_old(
                    &mut level,
                    scale_bias(GRADIENTS[face_ndx].0, c_scale, c_bias),
                    scale_bias(GRADIENTS[face_ndx].1, c_scale, c_bias),
                );
            }
        }
        for (face_ndx, &face) in FACES.iter().enumerate() {
            for level_ndx in 0..num_levels {
                let (color_a, color_b) = grid_colors(num_levels, level_ndx, face_ndx, true);
                let mut level = grid_tex.ref_texture_mut().face_level_mut(face, level_ndx);
                fill_with_grid(
                    &mut level,
                    4,
                    scale_bias(color_a.to_vec().m_data, c_scale, c_bias),
                    scale_bias(color_b.to_vec().m_data, c_scale, c_bias),
                );
            }
        }

        // Upload.
        // SAFETY: a current context; the textures outlive the calls.
        unsafe {
            gradient_tex.upload()?;
            grid_tex.upload()?;
        }
        if is_floating_point_depth_format(gradient_tex.ref_texture().format()) {
            for texture in [&mut gradient_tex, &mut grid_tex] {
                for level_ndx in 0..texture.ref_texture().num_levels() {
                    clamp_floating_point_level(&mut texture.ref_texture_mut().level_mut(level_ndx));
                }
            }
        }

        // Compute cases: (grid?, ref, bottom-left, top-right).
        let (in_range_upper, in_range_lower, out_of_bounds_upper, out_of_bounds_lower) = self.ref_values();
        let single_sample = render_target.num_samples == 0;
        let cases: Vec<(bool, f32, Vec2, Vec2)> = vec![
            if single_sample {
                (false, in_range_upper, Vec2::new(-1.25, -1.2), Vec2::new(1.2, 1.25)) // minification
            } else {
                // minification - w/ tuned coordinates to avoid hitting triangle edges
                (false, in_range_upper, Vec2::new(-1.19, -1.3), Vec2::new(1.1, 1.35))
            },
            (false, in_range_lower, Vec2::new(0.8, 0.8), Vec2::new(1.25, 1.20)), // magnification
            (true, in_range_upper, Vec2::new(-1.19, -1.3), Vec2::new(1.1, 1.35)), // minification
            (true, in_range_lower, Vec2::new(-1.2, -1.1), Vec2::new(-0.8, -0.8)), // magnification
            (true, out_of_bounds_upper, Vec2::new(-0.61, -0.1), Vec2::new(0.9, 1.18)), // reference value clamp, upper
            if single_sample {
                (true, out_of_bounds_lower, Vec2::new(-0.75, 1.0), Vec2::new(0.05, 0.75)) // reference value clamp, lower
            } else {
                (true, out_of_bounds_lower, Vec2::new(-0.75, 1.0), Vec2::new(0.25, 0.75))
            },
        ];

        let viewport_size = 28;
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut worst = Quality::High;

        for (case_ndx, &(use_grid, ref_, bottom_left, top_right)) in cases.iter().enumerate() {
            let texture = if use_grid { &grid_tex } else { &gradient_tex };
            let viewport = RandomViewport::new(
                &render_target,
                viewport_size,
                viewport_size,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );

            if viewport.width < viewport_size || viewport.height < viewport_size {
                return Err(TestError::NotSupported("Too small render target".to_string()));
            }

            // Setup texture
            // SAFETY: plain state setting on the current context.
            unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture()) };
            self.set_texture_state(context, glw::GL_TEXTURE_CUBE_MAP, self.wrap_s, self.wrap_t);
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height) };

            // Params for reference computation.
            let mut sample_params =
                self.shadow_params(TextureType::Cube, glw::GL_CLAMP_TO_EDGE, glw::GL_CLAMP_TO_EDGE, ref_)?;
            sample_params.sampler.seamless_cube_map = true;

            for &face in &FACES {
                let mut result = Surface::new(viewport.width, viewport.height);
                let tex_coord = compute_quad_tex_coord_cube_region(face, bottom_left, top_right);

                renderer.render_quad(0, &tex_coord, &sample_params.base)?;
                crate::glu::expect_no_error(gl, "Draw")?;

                read_pixels(render_ctx, viewport.x, viewport.y, &mut result.get_access())?;
                crate::glu::expect_no_error(gl, "Read pixels")?;

                let high = (
                    Self::compare_precision(context, [10, 10, 10], [6, 6, 0]),
                    LodPrecision {
                        derivate_bits: 10,
                        lod_bits: 5,
                    },
                );
                let mut low_prec = Self::compare_precision(context, [10, 10, 10], [4, 4, 0]);
                low_prec.pcf_bits = 0;
                let low = (
                    low_prec,
                    LodPrecision {
                        derivate_bits: 10,
                        lod_bits: 4,
                    },
                );
                let quality = verify_two_tier(high, low, |prec, lod| {
                    verify_tex_compare_result_cube(
                        &result,
                        texture.ref_texture(),
                        tex_coord,
                        &sample_params,
                        prec,
                        lod,
                        pixel_format,
                    )
                })?;
                worst = worst.max(quality);
            }
        }

        outcome(worst)
    }

    fn iterate_2d_array(&self, context: &Context, width: i32, height: i32, num_layers: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `Texture2DArrayShadowCase::init`
        let mut gradient_tex =
            Texture2DArray::new_sized(render_ctx, self.format, width as u32, height as u32, num_layers as u32)?;
        let mut grid_tex =
            Texture2DArray::new_sized(render_ctx, self.format, width as u32, height as u32, num_layers as u32)?;
        let fmt_info = get_texture_format_info(gradient_tex.ref_texture().format());
        let c_bias = fmt_info.value_min;
        let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);
        let num_levels = log2_floor(width.max(height)) + 1;

        for level_ndx in 0..num_levels {
            let g_min = scale_bias([-0.5, -0.5, -0.5, 2.0], c_scale, c_bias);
            let g_max = scale_bias([1.0, 1.0, 1.0, 0.0], c_scale, c_bias);

            gradient_tex.ref_texture_mut().alloc_level(level_ndx);
            let mut level = gradient_tex.ref_texture_mut().level_mut(level_ndx);
            fill_with_component_gradients_old(&mut level, g_min, g_max);
        }
        for level_ndx in 0..num_levels {
            let (color_a, color_b) = grid_colors(num_levels, level_ndx, 0, false);

            grid_tex.ref_texture_mut().alloc_level(level_ndx);
            let mut level = grid_tex.ref_texture_mut().level_mut(level_ndx);
            fill_with_grid(
                &mut level,
                4,
                scale_bias(color_a.to_vec().m_data, c_scale, c_bias),
                scale_bias(color_b.to_vec().m_data, c_scale, c_bias),
            );
        }

        // Upload.
        // SAFETY: a current context; the textures outlive the calls.
        unsafe {
            gradient_tex.upload()?;
            grid_tex.upload()?;
        }
        if is_floating_point_depth_format(gradient_tex.ref_texture().format()) {
            for texture in [&mut gradient_tex, &mut grid_tex] {
                for level_ndx in 0..texture.ref_texture().num_levels() {
                    if !texture.ref_texture().is_level_empty(level_ndx) {
                        clamp_floating_point_level(&mut texture.ref_texture_mut().level_mut(level_ndx));
                    }
                }
            }
        }

        // Compute cases.
        let (in_range_upper, in_range_lower, out_of_bounds_upper, out_of_bounds_lower) = self.ref_values();
        let cases: [(usize, f32, f32, f32, f32, f32); 6] = [
            (0, in_range_upper, 1.6, 2.9, -1.0, -2.7),
            (0, in_range_lower, -2.0, -1.35, -0.2, 0.7),
            (1, in_range_upper, 0.14, 0.275, -1.5, -1.1),
            (1, in_range_lower, -0.92, -2.64, 0.4, -0.1),
            (1, out_of_bounds_upper, -0.49, -0.22, 0.45, 0.97),
            (1, out_of_bounds_lower, -0.85, 0.75, 0.25, 0.61),
        ];
        let viewport_w = TEX2D_VIEWPORT_WIDTH.min(render_target.width) as f32;
        let viewport_h = TEX2D_VIEWPORT_HEIGHT.min(render_target.height) as f32;
        let min_layer = -0.5f32;
        let max_layer = num_layers as f32;

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut worst = Quality::High;

        for (case_ndx, &(tex_ndx, ref_, lod_x, lod_y, o_x, o_y)) in cases.iter().enumerate() {
            let texture = if tex_ndx > 0 { &grid_tex } else { &gradient_tex };
            let s_x = lod_x.exp2() * viewport_w / texture.ref_texture().width() as f32;
            let s_y = lod_y.exp2() * viewport_h / texture.ref_texture().height() as f32;
            let (min_coord, max_coord) = ([o_x, o_y, min_layer], [o_x + s_x, o_y + s_y, max_layer]);

            let viewport = RandomViewport::new(
                &render_target,
                TEX2D_VIEWPORT_WIDTH,
                TEX2D_VIEWPORT_HEIGHT,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );
            let mut rendered = Surface::new(viewport.width, viewport.height);
            let mid_layer = (min_coord[2] + max_coord[2]) / 2.0;
            #[rustfmt::skip]
            let tex_coord: [f32; 12] = [
                min_coord[0], min_coord[1], min_coord[2],
                min_coord[0], max_coord[1], mid_layer,
                max_coord[0], min_coord[1], mid_layer,
                max_coord[0], max_coord[1], max_coord[2],
            ];

            if viewport.width < TEX2D_MIN_VIEWPORT_WIDTH || viewport.height < TEX2D_MIN_VIEWPORT_HEIGHT {
                return Err(TestError::NotSupported("Too small render target".to_string()));
            }

            // Setup params for reference.
            let sample_params = self.shadow_params(TextureType::Texture2DArray, self.wrap_s, self.wrap_t, ref_)?;

            // SAFETY: plain state setting on the current context.
            unsafe { gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture.gl_texture()) };
            self.set_texture_state(context, glw::GL_TEXTURE_2D_ARRAY, self.wrap_s, self.wrap_t);
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height) };

            renderer.render_quad(0, &tex_coord, &sample_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered.get_access())?;

            let high = (
                Self::compare_precision(context, [20, 20, 20], [7, 7, 7]),
                LodPrecision {
                    derivate_bits: 18,
                    lod_bits: 6,
                },
            );
            let mut low_prec = Self::compare_precision(context, [20, 20, 20], [4, 4, 4]);
            low_prec.pcf_bits = 0;
            let low = (
                low_prec,
                LodPrecision {
                    derivate_bits: 18,
                    lod_bits: 4,
                },
            );
            let quality = verify_two_tier(high, low, |prec, lod| {
                verify_tex_compare_result_2d_array(
                    &rendered,
                    texture.ref_texture(),
                    tex_coord,
                    &sample_params,
                    prec,
                    lod,
                    pixel_format,
                )
            })?;
            worst = worst.max(quality);
        }

        outcome(worst)
    }
}

fn outcome(worst: Quality) -> TestOutcome {
    match worst {
        Quality::Fail => Ok(TestStatus::fail("Image verification failed")),
        Quality::Low => Ok(TestStatus::new(TestResult::QualityWarning, "Low-quality result")),
        Quality::High => Ok(TestStatus::pass("Pass")),
    }
}

impl TestCase for ShadowCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.kind {
            Kind::Tex2D { width, height } => self.iterate_2d(context, width, height),
            Kind::Cube { size } => self.iterate_cube(context, size),
            Kind::Array {
                width,
                height,
                num_layers,
            } => self.iterate_2d_array(context, width, height, num_layers),
        }
    }
}

/// `TextureShadowTests::init`
pub fn create_tests() -> TestCaseGroup {
    const FORMATS: [(&str, u32); 3] = [
        ("depth_component16", glw::GL_DEPTH_COMPONENT16),
        ("depth_component32f", glw::GL_DEPTH_COMPONENT32F),
        ("depth24_stencil8", glw::GL_DEPTH24_STENCIL8),
    ];
    const FILTERS: [(&str, u32, u32); 6] = [
        ("nearest", glw::GL_NEAREST, glw::GL_NEAREST),
        ("linear", glw::GL_LINEAR, glw::GL_LINEAR),
        ("nearest_mipmap_nearest", glw::GL_NEAREST_MIPMAP_NEAREST, glw::GL_LINEAR),
        ("linear_mipmap_nearest", glw::GL_LINEAR_MIPMAP_NEAREST, glw::GL_LINEAR),
        ("nearest_mipmap_linear", glw::GL_NEAREST_MIPMAP_LINEAR, glw::GL_LINEAR),
        ("linear_mipmap_linear", glw::GL_LINEAR_MIPMAP_LINEAR, glw::GL_LINEAR),
    ];
    const COMPARE_FUNCS: [(&str, u32); 8] = [
        ("less_or_equal", glw::GL_LEQUAL),
        ("greater_or_equal", glw::GL_GEQUAL),
        ("less", glw::GL_LESS),
        ("greater", glw::GL_GREATER),
        ("equal", glw::GL_EQUAL),
        ("not_equal", glw::GL_NOTEQUAL),
        ("always", glw::GL_ALWAYS),
        ("never", glw::GL_NEVER),
    ];

    let mut group = TestCaseGroup::new("shadow");

    for (group_name, kind) in [
        ("2d", Kind::Tex2D { width: 32, height: 64 }),
        ("cube", Kind::Cube { size: 32 }),
        (
            "2d_array",
            Kind::Array {
                width: 32,
                height: 64,
                num_layers: 8,
            },
        ),
    ] {
        let mut kind_group = TestCaseGroup::new(group_name);
        for &(filter_name, min_filter, mag_filter) in &FILTERS {
            let mut filter_group = TestCaseGroup::new(filter_name);
            for &(compare_name, compare_func) in &COMPARE_FUNCS {
                for &(format_name, format) in &FORMATS {
                    filter_group.add_child(Box::new(ShadowCase {
                        name: format!("{compare_name}_{format_name}"),
                        kind,
                        min_filter,
                        mag_filter,
                        wrap_s: glw::GL_REPEAT,
                        wrap_t: glw::GL_REPEAT,
                        format,
                        compare_func,
                    }) as Box<dyn TestCase>);
                }
            }
            kind_group.add_child(filter_group);
        }
        group.add_child(kind_group);
    }

    group
}

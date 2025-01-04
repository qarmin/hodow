// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureFilteringTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream runs one `FilterCase` per
// `iterate()` call; here one `iterate()` loops over them. The verdict is the same: any
// case failing both precision tiers is a Fail, otherwise any case passing only the lower
// tier is a QualityWarning, and a Fail is never downgraded.
//
// The two `etc1_rgb8_*` groups of cases (2D and cube) take their images from `glu::etc1` instead of
// the test-data archive; their `Kind` sizes are unused.

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::etc1::{ETC1_GL_FORMAT, ETC1_VK_FORMAT, Etc1Image};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_2d_array::Texture2DArray;
use crate::glu::texture_3d::Texture3D;
use crate::glu::texture_cube::{ALL_FACES, TextureCube};
use crate::glu::texture_test_util::{LodMode, TextureType, compute_quad_tex_coord_2d, get_sampler_type};
use crate::glu::texture_test_util_surface::{
    compute_quad_tex_coord_cube_region, fill_with_component_gradients_old, make_lookup_precision,
    make_reference_params, verify_texture_result_2d, verify_texture_result_2d_array, verify_texture_result_3d,
    verify_texture_result_cube,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{CubeFace, PixelBufferAccess, fill_with_grid, get_texture_format_info};
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::tex_verifier::LodPrecision;
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus, de_string_hash};

const TEX2D_VIEWPORT_WIDTH: i32 = 64;
const TEX2D_VIEWPORT_HEIGHT: i32 = 64;
const TEX2D_MIN_VIEWPORT_WIDTH: i32 = 64;
const TEX2D_MIN_VIEWPORT_HEIGHT: i32 = 64;

const TEX3D_VIEWPORT_WIDTH: i32 = 64;
const TEX3D_VIEWPORT_HEIGHT: i32 = 64;
const TEX3D_MIN_VIEWPORT_WIDTH: i32 = 64;
const TEX3D_MIN_VIEWPORT_HEIGHT: i32 = 64;

const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

/// `checkSupport`
fn check_format_support(context: &Context, internal_format: u32) -> Result<(), TestError> {
    let info = &context.context_info;
    if internal_format == glw::GL_SR8_EXT && !info.is_extension_supported("GL_EXT_texture_sRGB_R8") {
        return Err(TestError::NotSupported(
            "GL_EXT_texture_sRGB_R8 is not supported.".to_string(),
        ));
    }
    if internal_format == glw::GL_SRG8_EXT && !info.is_extension_supported("GL_EXT_texture_sRGB_RG8") {
        return Err(TestError::NotSupported(
            "GL_EXT_texture_sRGB_RG8 is not supported.".to_string(),
        ));
    }
    if (internal_format == glw::GL_BGRA || internal_format == glw::GL_BGRA8_EXT)
        && !info.is_extension_supported("GL_EXT_texture_format_BGRA8888")
    {
        return Err(TestError::NotSupported(
            "GL_EXT_texture_format_BGRA8888 is not supported.".to_string(),
        ));
    }
    Ok(())
}

fn log2_floor(value: i32) -> usize {
    (31 - (value as u32).leading_zeros()) as usize
}

fn scale_bias(v: [f32; 4], scale: [f32; 4], bias: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|c| v[c] * scale[c] + bias[c])
}

/// How a case did, ordered from best to worst.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub(super) enum Quality {
    High,
    Low,
    Fail,
}

/// Verifies against the high-precision requirements, and only on failure against the
/// lower ones.
pub(super) fn verify_two_tier<P>(
    high: (P, LodPrecision),
    low: (P, LodPrecision),
    mut verify: impl FnMut(&P, &LodPrecision) -> Result<bool, TestError>,
) -> Result<Quality, TestError> {
    if verify(&high.0, &high.1)? {
        return Ok(Quality::High);
    }
    Ok(if verify(&low.0, &low.1)? {
        Quality::Low
    } else {
        Quality::Fail
    })
}

fn outcome(worst: Quality) -> TestOutcome {
    match worst {
        Quality::Fail => Ok(TestStatus::fail("Image verification failed")),
        Quality::Low => Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Low-quality filtering result",
        )),
        Quality::High => Ok(TestStatus::pass("Pass")),
    }
}

/// The first texture is a gradient, the second a grid, at every level.
fn grid_colors(num_levels: usize, level_ndx: usize, c_scale: [f32; 4], c_bias: [f32; 4]) -> ([f32; 4], [f32; 4]) {
    let step = 0x00ff_ffffu32 / num_levels as u32;
    let rgb = step * level_ndx as u32;
    let color_a = 0xff00_0000 | rgb;
    let color_b = 0xff00_0000 | !rgb;
    (
        scale_bias(RGBA::from_packed(color_a).to_vec().m_data, c_scale, c_bias),
        scale_bias(RGBA::from_packed(color_b).to_vec().m_data, c_scale, c_bias),
    )
}

#[derive(Clone, Copy)]
enum Kind {
    Tex2D {
        width: i32,
        height: i32,
    },
    Cube {
        only_sample_face_interior: bool,
        width: i32,
        height: i32,
    },
    Array {
        width: i32,
        height: i32,
        num_layers: i32,
    },
    Tex3D {
        width: i32,
        height: i32,
        depth: i32,
    },
}

struct FilteringCase {
    name: String,
    kind: Kind,
    min_filter: u32,
    mag_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
    wrap_r: u32,
    internal_format: u32,
    /// The `filenames` constructors: ETC1 images instead of generated data; `internal_format` is unused then.
    etc1_2d: Option<Vec<Etc1Image>>,
    etc1_cube: Option<Vec<[Etc1Image; 6]>>,
}

impl FilteringCase {
    fn is_nearest_only(&self) -> bool {
        self.min_filter == glw::GL_NEAREST && self.mag_filter == glw::GL_NEAREST
    }

    fn iterate_2d(&self, context: &Context, width: i32, height: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `Texture2DFilteringCase::init`: create 2 textures.
        let mut textures = Vec::with_capacity(2);
        if let Some(levels) = &self.etc1_2d {
            let data: Vec<&[u8]> = levels.iter().map(|image| image.data).collect();
            let texture = Texture2D::new_compressed_with_gl_format(
                render_ctx,
                &context.context_info,
                ETC1_VK_FORMAT,
                Some(ETC1_GL_FORMAT),
                levels[0].width,
                levels[0].height,
                &data,
            )?;
            // SAFETY: a current context; `texture` outlives the call.
            unsafe { texture.upload_compressed()? };
            textures.push(texture);
        } else {
            for _ in 0..2 {
                textures.push(Texture2D::new_sized(
                    render_ctx,
                    self.internal_format,
                    width as u32,
                    height as u32,
                )?);
            }

            let num_levels = log2_floor(width.max(height)) + 1;
            let fmt_info = get_texture_format_info(textures[0].ref_texture().format());
            let c_bias = fmt_info.value_min;
            let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);

            // Fill first gradient texture.
            for level_ndx in 0..num_levels {
                let g_min = scale_bias([0.0, 0.0, 0.0, 1.0], c_scale, c_bias);
                let g_max = scale_bias([1.0, 1.0, 1.0, 0.0], c_scale, c_bias);

                textures[0].ref_texture_mut().alloc_level(level_ndx);
                let mut level = textures[0].ref_texture_mut().level_mut(level_ndx);
                fill_with_component_gradients_old(&mut level, g_min, g_max);
            }

            // Fill second with grid texture.
            for level_ndx in 0..num_levels {
                let (color_a, color_b) = grid_colors(num_levels, level_ndx, c_scale, c_bias);

                textures[1].ref_texture_mut().alloc_level(level_ndx);
                let mut level = textures[1].ref_texture_mut().level_mut(level_ndx);
                fill_with_grid(&mut level, 4, color_a, color_b);
            }

            // Upload.
            for texture in &textures {
                // SAFETY: a current context; `texture` outlives the call.
                unsafe { texture.upload()? };
            }
        }

        // Compute cases: (texture index, lodX, lodY, oX, oY).
        const CASES: [(usize, f32, f32, f32, f32); 4] = [
            (0, 1.6, 2.9, -1.0, -2.7),
            (0, -2.0, -1.35, -0.2, 0.7),
            (1, 0.14, 0.275, -1.5, -1.1),
            (1, -0.92, -2.64, 0.4, -0.1),
        ];
        let viewport_w = TEX2D_VIEWPORT_WIDTH.min(render_target.width) as f32;
        let viewport_h = TEX2D_VIEWPORT_HEIGHT.min(render_target.height) as f32;

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut worst = Quality::High;

        for (case_ndx, &(tex_ndx, lod_x, lod_y, o_x, o_y)) in CASES.iter().enumerate() {
            let texture = &textures[tex_ndx.min(textures.len() - 1)];
            let s_x = lod_x.exp2() * viewport_w / texture.ref_texture().width() as f32;
            let s_y = lod_y.exp2() * viewport_h / texture.ref_texture().height() as f32;

            let viewport = RandomViewport::new(
                &render_target,
                TEX2D_VIEWPORT_WIDTH,
                TEX2D_VIEWPORT_HEIGHT,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );
            let tex_fmt = texture.ref_texture().format();
            let fmt_info = get_texture_format_info(tex_fmt);
            let mut rendered = Surface::new(viewport.width, viewport.height);

            if viewport.width < TEX2D_MIN_VIEWPORT_WIDTH || viewport.height < TEX2D_MIN_VIEWPORT_HEIGHT {
                return Err(TestError::NotSupported("Too small render target".to_string()));
            }

            // Setup params for reference.
            let mut ref_params = make_reference_params(
                TextureType::Texture2D,
                self.wrap_s,
                self.wrap_t,
                self.wrap_s,
                self.min_filter,
                self.mag_filter,
                LodMode::Exact,
            )?;
            ref_params.base.sampler_type = get_sampler_type(tex_fmt);
            ref_params.base.color_bias = Vec4::from_array(fmt_info.look_up_bias);
            ref_params.base.color_scale = Vec4::from_array(fmt_info.look_up_scale);

            let tex_coord = compute_quad_tex_coord_2d(Vec2::new(o_x, o_y), Vec2::new(o_x + s_x, o_y + s_y));

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, self.mag_filter as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
            }
            renderer.render_quad(0, &tex_coord, &ref_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered.get_access())?;

            let scale = fmt_info.look_up_scale;
            let nearest = self.is_nearest_only();
            let quality = verify_two_tier(
                (
                    make_lookup_precision(pixel_format, nearest, scale, [20, 20, 0], [7, 7, 0]),
                    LodPrecision {
                        derivate_bits: 18,
                        lod_bits: 6,
                    },
                ),
                (
                    make_lookup_precision(pixel_format, nearest, scale, [20, 20, 0], [4, 4, 0]),
                    LodPrecision {
                        derivate_bits: 18,
                        lod_bits: 4,
                    },
                ),
                |lookup, lod| {
                    verify_texture_result_2d(
                        &rendered,
                        texture.ref_texture(),
                        tex_coord,
                        &ref_params,
                        lookup,
                        lod,
                        pixel_format,
                    )
                },
            )?;
            worst = worst.max(quality);
        }

        outcome(worst)
    }

    fn iterate_cube(&self, context: &Context, only_sample_face_interior: bool, width: i32, height: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `TextureCubeFilteringCase::init`
        let mut textures = Vec::with_capacity(2);
        if let Some(levels) = &self.etc1_cube {
            let level_data: Vec<[&[u8]; 6]> = levels
                .iter()
                .map(|faces| {
                    std::array::from_fn(|i| {
                        let upstream_ndx = FACES
                            .iter()
                            .position(|&f| f == ALL_FACES[i])
                            .expect("every face is in FACES");
                        faces[upstream_ndx].data
                    })
                })
                .collect();
            let texture = TextureCube::new_compressed_with_gl_format(
                render_ctx,
                &context.context_info,
                ETC1_VK_FORMAT,
                Some(ETC1_GL_FORMAT),
                levels[0][0].width,
                &level_data,
            )?;
            // SAFETY: a current context; `texture` outlives the call.
            unsafe { texture.upload_compressed()? };
            textures.push(texture);
        } else {
            for _ in 0..2 {
                textures.push(TextureCube::new_sized(render_ctx, self.internal_format, width as u32)?);
            }

            let num_levels = log2_floor(width.max(height)) + 1;
            let fmt_info = get_texture_format_info(textures[0].ref_texture().format());
            let c_bias = fmt_info.value_min;
            let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);

            // Fill first with gradient texture.
            const GRADIENTS: [([f32; 4], [f32; 4]); 6] = [
                ([0.0, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 0.0]), // negative x
                ([0.5, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 0.0]), // positive x
                ([0.0, 0.5, 0.0, 1.0], [1.0, 1.0, 1.0, 0.0]), // negative y
                ([0.0, 0.0, 0.5, 1.0], [1.0, 1.0, 1.0, 0.0]), // positive y
                ([0.0, 0.0, 0.0, 0.5], [1.0, 1.0, 1.0, 1.0]), // negative z
                ([0.5, 0.5, 0.5, 1.0], [1.0, 1.0, 1.0, 0.0]), // positive z
            ];
            for level_ndx in 0..num_levels {
                textures[0].ref_texture_mut().alloc_level(level_ndx);
                textures[1].ref_texture_mut().alloc_level(level_ndx);
            }
            for (face_ndx, &face) in FACES.iter().enumerate() {
                for level_ndx in 0..num_levels {
                    let mut level = textures[0].ref_texture_mut().face_level_mut(face, level_ndx);
                    fill_with_component_gradients_old(
                        &mut level,
                        scale_bias(GRADIENTS[face_ndx].0, c_scale, c_bias),
                        scale_bias(GRADIENTS[face_ndx].1, c_scale, c_bias),
                    );
                }
            }

            // Fill second with grid texture.
            for (face_ndx, &face) in FACES.iter().enumerate() {
                for level_ndx in 0..num_levels {
                    let step = 0x00ff_ffffu32 / (num_levels as u32 * 6);
                    let rgb = step.wrapping_mul(level_ndx as u32).wrapping_mul(face_ndx as u32);
                    let color_a = 0xff00_0000 | rgb;
                    let color_b = 0xff00_0000 | !rgb;

                    let mut level = textures[1].ref_texture_mut().face_level_mut(face, level_ndx);
                    fill_with_grid(
                        &mut level,
                        4,
                        scale_bias(RGBA::from_packed(color_a).to_vec().m_data, c_scale, c_bias),
                        scale_bias(RGBA::from_packed(color_b).to_vec().m_data, c_scale, c_bias),
                    );
                }
            }

            // Upload.
            for texture in &textures {
                // SAFETY: a current context; `texture` outlives the call.
                unsafe { texture.upload()? };
            }
        }

        // Compute cases: (texture index, bottom-left, top-right).
        let cases: Vec<(usize, Vec2, Vec2)> = if only_sample_face_interior {
            vec![
                (0, Vec2::new(-0.8, -0.8), Vec2::new(0.8, 0.8)), // minification
                (0, Vec2::new(0.5, 0.65), Vec2::new(0.8, 0.8)),  // magnification
                (1, Vec2::new(-0.8, -0.8), Vec2::new(0.8, 0.8)), // minification
                (1, Vec2::new(0.2, 0.2), Vec2::new(0.6, 0.5)),   // magnification
            ]
        } else {
            vec![
                if render_target.num_samples == 0 {
                    (0, Vec2::new(-1.25, -1.2), Vec2::new(1.2, 1.25)) // minification
                } else {
                    // minification - w/ tweak to avoid hitting triangle edges with face switchpoint
                    (0, Vec2::new(-1.19, -1.3), Vec2::new(1.1, 1.35))
                },
                (0, Vec2::new(0.8, 0.8), Vec2::new(1.25, 1.20)), // magnification
                (1, Vec2::new(-1.19, -1.3), Vec2::new(1.1, 1.35)), // minification
                (1, Vec2::new(-1.2, -1.1), Vec2::new(-0.8, -0.8)), // magnification
            ]
        };

        let viewport_size = 28;
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut worst = Quality::High;

        for (case_ndx, &(tex_ndx, bottom_left, top_right)) in cases.iter().enumerate() {
            let texture = &textures[tex_ndx.min(textures.len() - 1)];
            let viewport = RandomViewport::new(
                &render_target,
                viewport_size,
                viewport_size,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );
            let tex_fmt = texture.ref_texture().format();
            let fmt_info = get_texture_format_info(tex_fmt);

            if viewport.width < viewport_size || viewport.height < viewport_size {
                return Err(TestError::NotSupported("Too small render target".to_string()));
            }

            // Setup texture
            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_TEXTURE_MIN_FILTER,
                    self.min_filter as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_TEXTURE_MAG_FILTER,
                    self.mag_filter as i32,
                );
                gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
            }

            // Params for reference computation.
            let mut sample_params = make_reference_params(
                TextureType::Cube,
                glw::GL_CLAMP_TO_EDGE,
                glw::GL_CLAMP_TO_EDGE,
                glw::GL_CLAMP_TO_EDGE,
                self.min_filter,
                self.mag_filter,
                LodMode::Exact,
            )?;
            sample_params.sampler.seamless_cube_map = true;
            sample_params.base.sampler_type = get_sampler_type(tex_fmt);
            sample_params.base.color_bias = Vec4::from_array(fmt_info.look_up_bias);
            sample_params.base.color_scale = Vec4::from_array(fmt_info.look_up_scale);

            for &face in &FACES {
                let mut result = Surface::new(viewport.width, viewport.height);
                let tex_coord = compute_quad_tex_coord_cube_region(face, bottom_left, top_right);

                renderer.render_quad(0, &tex_coord, &sample_params.base)?;
                glu::expect_no_error(gl, "Draw")?;

                read_pixels(render_ctx, viewport.x, viewport.y, &mut result.get_access())?;
                glu::expect_no_error(gl, "Read pixels")?;

                let scale = fmt_info.look_up_scale;
                let nearest = self.is_nearest_only();
                let quality = verify_two_tier(
                    (
                        make_lookup_precision(pixel_format, nearest, scale, [10, 10, 10], [6, 6, 0]),
                        LodPrecision {
                            derivate_bits: 10,
                            lod_bits: 5,
                        },
                    ),
                    (
                        make_lookup_precision(pixel_format, nearest, scale, [10, 10, 10], [4, 4, 0]),
                        LodPrecision {
                            derivate_bits: 10,
                            lod_bits: 4,
                        },
                    ),
                    |lookup, lod| {
                        verify_texture_result_cube(
                            &result,
                            texture.ref_texture(),
                            tex_coord,
                            &sample_params,
                            lookup,
                            lod,
                            pixel_format,
                        )
                    },
                )?;
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

        // `Texture2DArrayFilteringCase::init`
        let mut gradient_tex = Texture2DArray::new_sized(
            render_ctx,
            self.internal_format,
            width as u32,
            height as u32,
            num_layers as u32,
        )?;
        let mut grid_tex = Texture2DArray::new_sized(
            render_ctx,
            self.internal_format,
            width as u32,
            height as u32,
            num_layers as u32,
        )?;

        let fmt_info = get_texture_format_info(gradient_tex.ref_texture().format());
        let c_bias = fmt_info.value_min;
        let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);
        let num_levels = log2_floor(width.max(height)) + 1;

        const LEVEL_SWZ: [[usize; 4]; 4] = [[0, 1, 2, 3], [2, 1, 3, 0], [3, 0, 1, 2], [1, 3, 2, 0]];
        let swizzle = |v: [f32; 4], s: [usize; 4]| [v[s[0]], v[s[1]], v[s[2]], v[s[3]]];

        // Fill first gradient texture (gradient direction varies between layers).
        for level_ndx in 0..num_levels {
            gradient_tex.ref_texture_mut().alloc_level(level_ndx);
            let mut level_buf: PixelBufferAccess<'_> = gradient_tex.ref_texture_mut().level_mut(level_ndx);
            let [level_w, level_h, _] = level_buf.size();

            for layer_ndx in 0..num_layers {
                let swz = LEVEL_SWZ[layer_ndx as usize % LEVEL_SWZ.len()];
                let g_min = scale_bias(swizzle([0.0, 0.0, 0.0, 1.0], swz), c_scale, c_bias);
                let g_max = scale_bias(swizzle([1.0, 1.0, 1.0, 0.0], swz), c_scale, c_bias);

                let mut layer = level_buf.get_subregion(0, 0, layer_ndx as u32, level_w, level_h, 1);
                fill_with_component_gradients_old(&mut layer, g_min, g_max);
            }
        }

        // Fill second with grid texture (each layer has unique colors).
        for level_ndx in 0..num_levels {
            grid_tex.ref_texture_mut().alloc_level(level_ndx);
            let mut level_buf: PixelBufferAccess<'_> = grid_tex.ref_texture_mut().level_mut(level_ndx);
            let [level_w, level_h, _] = level_buf.size();

            for layer_ndx in 0..num_layers {
                let step = 0x00ff_ffffu32 / (num_levels as u32 * num_layers as u32 - 1);
                let rgb = step.wrapping_mul((level_ndx as i32 + layer_ndx * num_levels as i32) as u32);
                let color_a = 0xff00_0000 | rgb;
                let color_b = 0xff00_0000 | !rgb;

                let mut layer = level_buf.get_subregion(0, 0, layer_ndx as u32, level_w, level_h, 1);
                fill_with_grid(
                    &mut layer,
                    4,
                    scale_bias(RGBA::from_packed(color_a).to_vec().m_data, c_scale, c_bias),
                    scale_bias(RGBA::from_packed(color_b).to_vec().m_data, c_scale, c_bias),
                );
            }
        }

        // Upload.
        // SAFETY: a current context; the textures outlive the calls.
        unsafe {
            gradient_tex.upload()?;
            grid_tex.upload()?;
        }

        // Test cases: (grid?, lod, offset, layer range).
        let layers = num_layers as f32;
        let mut cases: Vec<(bool, Vec2, Vec2, Vec2)> = vec![
            (
                false,
                Vec2::new(1.5, 2.8),
                Vec2::new(-1.0, -2.7),
                Vec2::new(-0.5, layers + 0.5),
            ),
            (
                true,
                Vec2::new(0.2, 0.175),
                Vec2::new(-2.0, -3.7),
                Vec2::new(-0.5, layers + 0.5),
            ),
            (
                true,
                Vec2::new(-0.8, -2.3),
                Vec2::new(0.2, -0.1),
                Vec2::new(layers + 0.5, -0.5),
            ),
        ];
        // Level rounding - only in single-sample configs as multisample configs may produce smooth transition at the middle.
        if render_target.num_samples == 0 {
            cases.push((
                false,
                Vec2::new(-2.0, -1.5),
                Vec2::new(-0.1, 0.9),
                Vec2::new(1.50001, 1.49999),
            ));
        }

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut worst = Quality::High;

        for (case_ndx, &(use_grid, lod, offset, layer_range)) in cases.iter().enumerate() {
            let texture = if use_grid { &grid_tex } else { &gradient_tex };
            let viewport = RandomViewport::new(
                &render_target,
                TEX3D_VIEWPORT_WIDTH,
                TEX3D_VIEWPORT_HEIGHT,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );
            let tex_fmt = texture.ref_texture().format();
            let fmt_info = get_texture_format_info(tex_fmt);
            let mut rendered = Surface::new(viewport.width, viewport.height);

            if viewport.width < TEX3D_MIN_VIEWPORT_WIDTH || viewport.height < TEX3D_MIN_VIEWPORT_HEIGHT {
                return Err(TestError::NotSupported("Too small render target".to_string()));
            }

            // Setup params for reference.
            let mut ref_params = make_reference_params(
                TextureType::Texture2DArray,
                self.wrap_s,
                self.wrap_t,
                self.wrap_t,
                self.min_filter,
                self.mag_filter,
                LodMode::Exact,
            )?;
            ref_params.base.sampler_type = get_sampler_type(tex_fmt);
            ref_params.base.color_bias = Vec4::from_array(fmt_info.look_up_bias);
            ref_params.base.color_scale = Vec4::from_array(fmt_info.look_up_scale);

            // Compute texture coordinates.
            let (lod_x, lod_y) = (lod.x(), lod.y());
            let (o_x, o_y) = (offset.x(), offset.y());
            let s_x = lod_x.exp2() * viewport.width as f32 / gradient_tex.ref_texture().width() as f32;
            let s_y = lod_y.exp2() * viewport.height as f32 / gradient_tex.ref_texture().height() as f32;
            let (l0, l1) = (layer_range.x(), layer_range.y());
            #[rustfmt::skip]
            let tex_coord: [f32; 12] = [
                o_x,       o_y,       l0,
                o_x,       o_y + s_y, l0 * 0.5 + l1 * 0.5,
                o_x + s_x, o_y,       l0 * 0.5 + l1 * 0.5,
                o_x + s_x, o_y + s_y, l1,
            ];

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture.gl_texture());
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D_ARRAY,
                    glw::GL_TEXTURE_MIN_FILTER,
                    self.min_filter as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D_ARRAY,
                    glw::GL_TEXTURE_MAG_FILTER,
                    self.mag_filter as i32,
                );
                gl.tex_parameteri(glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
            }
            renderer.render_quad(0, &tex_coord, &ref_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered.get_access())?;

            let scale = fmt_info.look_up_scale;
            let nearest = self.is_nearest_only();
            let quality = verify_two_tier(
                (
                    make_lookup_precision(pixel_format, nearest, scale, [20, 20, 20], [7, 7, 0]),
                    LodPrecision {
                        derivate_bits: 18,
                        lod_bits: 6,
                    },
                ),
                (
                    make_lookup_precision(pixel_format, nearest, scale, [20, 20, 20], [4, 4, 0]),
                    LodPrecision {
                        derivate_bits: 18,
                        lod_bits: 4,
                    },
                ),
                |lookup, lod| {
                    verify_texture_result_2d_array(
                        &rendered,
                        texture.ref_texture(),
                        tex_coord,
                        &ref_params,
                        lookup,
                        lod,
                        pixel_format,
                    )
                },
            )?;
            worst = worst.max(quality);
        }

        outcome(worst)
    }

    fn iterate_3d(&self, context: &Context, width: i32, height: i32, depth: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `Texture3DFilteringCase::init`
        let mut gradient_tex = Texture3D::new_sized(
            render_ctx,
            self.internal_format,
            width as u32,
            height as u32,
            depth as u32,
        )?;
        let mut grid_tex = Texture3D::new_sized(
            render_ctx,
            self.internal_format,
            width as u32,
            height as u32,
            depth as u32,
        )?;

        let fmt_info = get_texture_format_info(gradient_tex.ref_texture().format());
        let c_bias = fmt_info.value_min;
        let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);
        let num_levels = log2_floor(width.max(height).max(depth)) + 1;

        // Fill first gradient texture.
        for level_ndx in 0..num_levels {
            let g_min = scale_bias([0.0, 0.0, 0.0, 1.0], c_scale, c_bias);
            let g_max = scale_bias([1.0, 1.0, 1.0, 0.0], c_scale, c_bias);

            gradient_tex.ref_texture_mut().alloc_level(level_ndx);
            let mut level = gradient_tex.ref_texture_mut().level_mut(level_ndx);
            fill_with_component_gradients_old(&mut level, g_min, g_max);
        }

        // Fill second with grid texture.
        for level_ndx in 0..num_levels {
            let (color_a, color_b) = grid_colors(num_levels, level_ndx, c_scale, c_bias);

            grid_tex.ref_texture_mut().alloc_level(level_ndx);
            let mut level = grid_tex.ref_texture_mut().level_mut(level_ndx);
            fill_with_grid(&mut level, 4, color_a, color_b);
        }

        // Upload.
        // SAFETY: a current context; the textures outlive the calls.
        unsafe {
            gradient_tex.upload()?;
            grid_tex.upload()?;
        }

        // Test cases: (grid?, lod per axis, offset).
        const CASES: [(bool, [f32; 3], [f32; 3]); 4] = [
            (false, [1.5, 2.8, 1.0], [-1.0, -2.7, -2.275]),
            (false, [-2.0, -1.5, -1.8], [-0.1, 0.9, -0.25]),
            (true, [0.2, 0.175, 0.3], [-2.0, -3.7, -1.825]),
            (true, [-0.8, -2.3, -2.5], [0.2, -0.1, 1.325]),
        ];

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut worst = Quality::High;

        for (case_ndx, &(use_grid, lod, offset)) in CASES.iter().enumerate() {
            let texture = if use_grid { &grid_tex } else { &gradient_tex };
            let viewport = RandomViewport::new(
                &render_target,
                TEX3D_VIEWPORT_WIDTH,
                TEX3D_VIEWPORT_HEIGHT,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );
            let tex_fmt = texture.ref_texture().format();
            let fmt_info = get_texture_format_info(tex_fmt);
            let mut rendered = Surface::new(viewport.width, viewport.height);

            if viewport.width < TEX3D_MIN_VIEWPORT_WIDTH || viewport.height < TEX3D_MIN_VIEWPORT_HEIGHT {
                return Err(TestError::NotSupported("Too small render target".to_string()));
            }

            // Setup params for reference.
            let mut ref_params = make_reference_params(
                TextureType::Texture3D,
                self.wrap_s,
                self.wrap_t,
                self.wrap_r,
                self.min_filter,
                self.mag_filter,
                LodMode::Exact,
            )?;
            ref_params.base.sampler_type = get_sampler_type(tex_fmt);
            ref_params.base.color_bias = Vec4::from_array(fmt_info.look_up_bias);
            ref_params.base.color_scale = Vec4::from_array(fmt_info.look_up_scale);

            // Compute texture coordinates.
            let [o_x, o_y, o_z] = offset;
            let s_x = lod[0].exp2() * viewport.width as f32 / gradient_tex.ref_texture().width() as f32;
            let s_y = lod[1].exp2() * viewport.height as f32 / gradient_tex.ref_texture().height() as f32;
            let s_z =
                lod[2].exp2() * viewport.width.max(viewport.height) as f32 / gradient_tex.ref_texture().depth() as f32;
            #[rustfmt::skip]
            let tex_coord: [f32; 12] = [
                o_x,       o_y,       o_z,
                o_x,       o_y + s_y, o_z + s_z * 0.5,
                o_x + s_x, o_y,       o_z + s_z * 0.5,
                o_x + s_x, o_y + s_y, o_z + s_z,
            ];

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_3D, texture.gl_texture());
                gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAG_FILTER, self.mag_filter as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_R, self.wrap_r as i32);
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
            }
            renderer.render_quad(0, &tex_coord, &ref_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered.get_access())?;

            let scale = fmt_info.look_up_scale;
            let nearest = self.is_nearest_only();
            let quality = verify_two_tier(
                (
                    make_lookup_precision(pixel_format, nearest, scale, [20, 20, 20], [7, 7, 7]),
                    LodPrecision {
                        derivate_bits: 18,
                        lod_bits: 6,
                    },
                ),
                (
                    make_lookup_precision(pixel_format, nearest, scale, [20, 20, 20], [4, 4, 4]),
                    LodPrecision {
                        derivate_bits: 18,
                        lod_bits: 4,
                    },
                ),
                |lookup, lod| {
                    verify_texture_result_3d(
                        &rendered,
                        texture.ref_texture(),
                        tex_coord,
                        &ref_params,
                        lookup,
                        lod,
                        pixel_format,
                    )
                },
            )?;
            worst = worst.max(quality);
        }

        outcome(worst)
    }
}

impl TestCase for FilteringCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_format_support(context, self.internal_format)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.kind {
            Kind::Tex2D { width, height } => self.iterate_2d(context, width, height),
            Kind::Cube {
                only_sample_face_interior,
                width,
                height,
            } => self.iterate_cube(context, only_sample_face_interior, width, height),
            Kind::Array {
                width,
                height,
                num_layers,
            } => self.iterate_2d_array(context, width, height, num_layers),
            Kind::Tex3D { width, height, depth } => self.iterate_3d(context, width, height, depth),
        }
    }
}

/// `TextureFilteringTests::init`
pub fn create_tests() -> TestCaseGroup {
    const WRAP_MODES: [(&str, u32); 3] = [
        ("clamp", glw::GL_CLAMP_TO_EDGE),
        ("repeat", glw::GL_REPEAT),
        ("mirror", glw::GL_MIRRORED_REPEAT),
    ];
    const MIN_FILTER_MODES: [(&str, u32); 6] = [
        ("nearest", glw::GL_NEAREST),
        ("linear", glw::GL_LINEAR),
        ("nearest_mipmap_nearest", glw::GL_NEAREST_MIPMAP_NEAREST),
        ("linear_mipmap_nearest", glw::GL_LINEAR_MIPMAP_NEAREST),
        ("nearest_mipmap_linear", glw::GL_NEAREST_MIPMAP_LINEAR),
        ("linear_mipmap_linear", glw::GL_LINEAR_MIPMAP_LINEAR),
    ];
    const MAG_FILTER_MODES: [(&str, u32); 2] = [("nearest", glw::GL_NEAREST), ("linear", glw::GL_LINEAR)];
    const SIZES_2D: [(i32, i32); 6] = [(4, 8), (32, 64), (128, 128), (3, 7), (31, 55), (127, 99)];
    const SIZES_CUBE: [(i32, i32); 5] = [(8, 8), (64, 64), (128, 128), (7, 7), (63, 63)];
    const SIZES_2D_ARRAY: [(i32, i32, i32); 5] = [(4, 8, 8), (32, 64, 16), (128, 32, 64), (3, 7, 5), (63, 63, 63)];
    const SIZES_3D: [(i32, i32, i32); 5] = [(4, 8, 8), (32, 64, 16), (128, 32, 64), (3, 7, 5), (63, 63, 63)];
    const FILTERABLE_FORMATS_BY_TYPE: [(&str, u32); 14] = [
        ("rgba16f", glw::GL_RGBA16F),
        ("r11f_g11f_b10f", glw::GL_R11F_G11F_B10F),
        ("rgb9_e5", glw::GL_RGB9_E5),
        ("rgba8", glw::GL_RGBA8),
        ("rgba8_snorm", glw::GL_RGBA8_SNORM),
        ("rgb565", glw::GL_RGB565),
        ("rgba4", glw::GL_RGBA4),
        ("rgb5_a1", glw::GL_RGB5_A1),
        ("srgb8_alpha8", glw::GL_SRGB8_ALPHA8),
        ("srgb_r8", glw::GL_SR8_EXT),
        ("srgb_rg8", glw::GL_SRG8_EXT),
        ("rgb10_a2", glw::GL_RGB10_A2),
        ("bgra", glw::GL_BGRA),
        ("bgra8", glw::GL_BGRA8_EXT),
    ];

    let is_mipmap = |min_filter: u32| min_filter != glw::GL_NEAREST && min_filter != glw::GL_LINEAR;
    let mag_for = |min_filter: u32| {
        if is_mipmap(min_filter) {
            glw::GL_LINEAR
        } else {
            min_filter
        }
    };
    let boxed = |case: FilteringCase| Box::new(case) as Box<dyn TestCase>;

    let mut group = TestCaseGroup::new("filtering");

    // 2D texture filtering.
    {
        let mut group_2d = TestCaseGroup::new("2d");

        let mut formats_group = TestCaseGroup::new("formats");
        for &(format_name, format) in &FILTERABLE_FORMATS_BY_TYPE {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                formats_group.add_child(boxed(FilteringCase {
                    name: format!("{format_name}_{filter_name}"),
                    kind: Kind::Tex2D { width: 64, height: 64 },
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    wrap_r: glw::GL_REPEAT,
                    internal_format: format,
                    etc1_2d: None,
                    etc1_cube: None,
                }));
            }
        }
        // ETC1 format.
        for &(filter_name, min_filter) in &MIN_FILTER_MODES {
            formats_group.add_child(boxed(FilteringCase {
                name: format!("etc1_rgb8_{filter_name}"),
                kind: Kind::Tex2D { width: 0, height: 0 },
                min_filter,
                mag_filter: mag_for(min_filter),
                wrap_s: glw::GL_REPEAT,
                wrap_t: glw::GL_REPEAT,
                wrap_r: glw::GL_REPEAT,
                internal_format: 0,
                etc1_2d: Some(crate::glu::etc1::photo_mip_levels()),
                etc1_cube: None,
            }));
        }
        group_2d.add_child(formats_group);

        let mut sizes_group = TestCaseGroup::new("sizes");
        for &(width, height) in &SIZES_2D {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                sizes_group.add_child(boxed(FilteringCase {
                    name: format!("{width}x{height}_{filter_name}"),
                    kind: Kind::Tex2D { width, height },
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    wrap_r: glw::GL_REPEAT,
                    internal_format: glw::GL_RGBA8,
                    etc1_2d: None,
                    etc1_cube: None,
                }));
            }
        }
        group_2d.add_child(sizes_group);

        let mut combinations_group = TestCaseGroup::new("combinations");
        for &(min_name, min_filter) in &MIN_FILTER_MODES {
            for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
                for &(wrap_s_name, wrap_s) in &WRAP_MODES {
                    for &(wrap_t_name, wrap_t) in &WRAP_MODES {
                        combinations_group.add_child(boxed(FilteringCase {
                            name: format!("{min_name}_{mag_name}_{wrap_s_name}_{wrap_t_name}"),
                            kind: Kind::Tex2D { width: 63, height: 57 },
                            min_filter,
                            mag_filter,
                            wrap_s,
                            wrap_t,
                            wrap_r: glw::GL_REPEAT,
                            internal_format: glw::GL_RGBA8,
                            etc1_2d: None,
                            etc1_cube: None,
                        }));
                    }
                }
            }
        }
        group_2d.add_child(combinations_group);
        group.add_child(group_2d);
    }

    // Cube map texture filtering.
    {
        let mut group_cube = TestCaseGroup::new("cube");

        let mut formats_group = TestCaseGroup::new("formats");
        for &(format_name, format) in &FILTERABLE_FORMATS_BY_TYPE {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                formats_group.add_child(boxed(FilteringCase {
                    name: format!("{format_name}_{filter_name}"),
                    kind: Kind::Cube {
                        only_sample_face_interior: false, /* always sample exterior as well */
                        width: 64,
                        height: 64,
                    },
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    wrap_r: glw::GL_REPEAT,
                    internal_format: format,
                    etc1_2d: None,
                    etc1_cube: None,
                }));
            }
        }
        // ETC1 format.
        for &(filter_name, min_filter) in &MIN_FILTER_MODES {
            formats_group.add_child(boxed(FilteringCase {
                name: format!("etc1_rgb8_{filter_name}"),
                kind: Kind::Cube {
                    only_sample_face_interior: false, /* always sample exterior as well */
                    width: 0,
                    height: 0,
                },
                min_filter,
                mag_filter: mag_for(min_filter),
                wrap_s: glw::GL_REPEAT,
                wrap_t: glw::GL_REPEAT,
                wrap_r: glw::GL_REPEAT,
                internal_format: 0,
                etc1_2d: None,
                etc1_cube: Some(crate::glu::etc1::skybox_pot_levels()),
            }));
        }
        group_cube.add_child(formats_group);

        let mut sizes_group = TestCaseGroup::new("sizes");
        for &(width, height) in &SIZES_CUBE {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                sizes_group.add_child(boxed(FilteringCase {
                    name: format!("{width}x{height}_{filter_name}"),
                    kind: Kind::Cube {
                        only_sample_face_interior: false,
                        width,
                        height,
                    },
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    wrap_r: glw::GL_REPEAT,
                    internal_format: glw::GL_RGBA8,
                    etc1_2d: None,
                    etc1_cube: None,
                }));
            }
        }
        group_cube.add_child(sizes_group);

        let mut combinations_group = TestCaseGroup::new("combinations");
        for &(min_name, min_filter) in &MIN_FILTER_MODES {
            for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
                for &(wrap_s_name, wrap_s) in &WRAP_MODES {
                    for &(wrap_t_name, wrap_t) in &WRAP_MODES {
                        combinations_group.add_child(boxed(FilteringCase {
                            name: format!("{min_name}_{mag_name}_{wrap_s_name}_{wrap_t_name}"),
                            kind: Kind::Cube {
                                only_sample_face_interior: false,
                                width: 63,
                                height: 63,
                            },
                            min_filter,
                            mag_filter,
                            wrap_s,
                            wrap_t,
                            wrap_r: glw::GL_REPEAT,
                            internal_format: glw::GL_RGBA8,
                            etc1_2d: None,
                            etc1_cube: None,
                        }));
                    }
                }
            }
        }
        group_cube.add_child(combinations_group);

        // Cases with no visible cube edges.
        let mut only_face_interior_group = TestCaseGroup::new("no_edges_visible");
        for is_linear in [false, true] {
            let filter = if is_linear { glw::GL_LINEAR } else { glw::GL_NEAREST };
            only_face_interior_group.add_child(boxed(FilteringCase {
                name: if is_linear { "linear" } else { "nearest" }.to_string(),
                kind: Kind::Cube {
                    only_sample_face_interior: true,
                    width: 63,
                    height: 63,
                },
                min_filter: filter,
                mag_filter: filter,
                wrap_s: glw::GL_REPEAT,
                wrap_t: glw::GL_REPEAT,
                wrap_r: glw::GL_REPEAT,
                internal_format: glw::GL_RGBA8,
                etc1_2d: None,
                etc1_cube: None,
            }));
        }
        group_cube.add_child(only_face_interior_group);
        group.add_child(group_cube);
    }

    // 2D array texture filtering.
    {
        let mut group_2d_array = TestCaseGroup::new("2d_array");

        let mut formats_group = TestCaseGroup::new("formats");
        for &(format_name, format) in &FILTERABLE_FORMATS_BY_TYPE {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                formats_group.add_child(boxed(FilteringCase {
                    name: format!("{format_name}_{filter_name}"),
                    kind: Kind::Array {
                        width: 128,
                        height: 128,
                        num_layers: 8,
                    },
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    wrap_r: glw::GL_REPEAT,
                    internal_format: format,
                    etc1_2d: None,
                    etc1_cube: None,
                }));
            }
        }
        group_2d_array.add_child(formats_group);

        let mut sizes_group = TestCaseGroup::new("sizes");
        for &(width, height, num_layers) in &SIZES_2D_ARRAY {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                sizes_group.add_child(boxed(FilteringCase {
                    name: format!("{width}x{height}x{num_layers}_{filter_name}"),
                    kind: Kind::Array {
                        width,
                        height,
                        num_layers,
                    },
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    wrap_r: glw::GL_REPEAT,
                    internal_format: glw::GL_RGBA8,
                    etc1_2d: None,
                    etc1_cube: None,
                }));
            }
        }
        group_2d_array.add_child(sizes_group);

        let mut combinations_group = TestCaseGroup::new("combinations");
        for &(min_name, min_filter) in &MIN_FILTER_MODES {
            for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
                for &(wrap_s_name, wrap_s) in &WRAP_MODES {
                    for &(wrap_t_name, wrap_t) in &WRAP_MODES {
                        combinations_group.add_child(boxed(FilteringCase {
                            name: format!("{min_name}_{mag_name}_{wrap_s_name}_{wrap_t_name}"),
                            kind: Kind::Array {
                                width: 123,
                                height: 107,
                                num_layers: 7,
                            },
                            min_filter,
                            mag_filter,
                            wrap_s,
                            wrap_t,
                            wrap_r: glw::GL_REPEAT,
                            internal_format: glw::GL_RGBA8,
                            etc1_2d: None,
                            etc1_cube: None,
                        }));
                    }
                }
            }
        }
        group_2d_array.add_child(combinations_group);
        group.add_child(group_2d_array);
    }

    // 3D texture filtering.
    {
        let mut group_3d = TestCaseGroup::new("3d");

        let mut formats_group = TestCaseGroup::new("formats");
        for &(format_name, format) in &FILTERABLE_FORMATS_BY_TYPE {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                formats_group.add_child(boxed(FilteringCase {
                    name: format!("{format_name}_{filter_name}"),
                    kind: Kind::Tex3D {
                        width: 64,
                        height: 64,
                        depth: 64,
                    },
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    wrap_r: glw::GL_REPEAT,
                    internal_format: format,
                    etc1_2d: None,
                    etc1_cube: None,
                }));
            }
        }
        group_3d.add_child(formats_group);

        let mut sizes_group = TestCaseGroup::new("sizes");
        for &(width, height, depth) in &SIZES_3D {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                sizes_group.add_child(boxed(FilteringCase {
                    name: format!("{width}x{height}x{depth}_{filter_name}"),
                    kind: Kind::Tex3D { width, height, depth },
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    wrap_r: glw::GL_REPEAT,
                    internal_format: glw::GL_RGBA8,
                    etc1_2d: None,
                    etc1_cube: None,
                }));
            }
        }
        group_3d.add_child(sizes_group);

        let mut combinations_group = TestCaseGroup::new("combinations");
        for &(min_name, min_filter) in &MIN_FILTER_MODES {
            for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
                for &(wrap_s_name, wrap_s) in &WRAP_MODES {
                    for &(wrap_t_name, wrap_t) in &WRAP_MODES {
                        for &(wrap_r_name, wrap_r) in &WRAP_MODES {
                            combinations_group.add_child(boxed(FilteringCase {
                                name: format!("{min_name}_{mag_name}_{wrap_s_name}_{wrap_t_name}_{wrap_r_name}"),
                                kind: Kind::Tex3D {
                                    width: 63,
                                    height: 57,
                                    depth: 67,
                                },
                                min_filter,
                                mag_filter,
                                wrap_s,
                                wrap_t,
                                wrap_r,
                                internal_format: glw::GL_RGBA8,
                                etc1_2d: None,
                                etc1_cube: None,
                            }));
                        }
                    }
                }
            }
        }
        group_3d.add_child(combinations_group);
        group.add_child(group_3d);
    }

    group
}

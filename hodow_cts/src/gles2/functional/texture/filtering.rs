// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureFilteringTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream runs one `FilterCase` per
// `iterate()` call and keeps the worst result; here a single `iterate()` loops over all of
// them and any failing one fails the case, which is the same verdict.
//
// The ETC1 cases (`*_etc1` in both `2d` and `cube`) take their images from `glu::etc1` instead of the
// test-data archive.

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::etc1::{ETC1_GL_FORMAT, ETC1_VK_FORMAT, Etc1Image};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_cube::{ALL_FACES, TextureCube};
use crate::glu::texture_test_util::{LodMode, TextureType, compute_quad_tex_coord_2d, get_sampler_type};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, compute_quad_tex_coord_cube_region, get_bits_vec, get_compare_mask,
    make_reference_params, verify_texture_result_2d, verify_texture_result_cube,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{CubeFace, fill_with_component_gradients2, fill_with_grid, get_texture_format_info};
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};

const VIEWPORT_WIDTH: i32 = 64;
const VIEWPORT_HEIGHT: i32 = 64;
const MIN_VIEWPORT_WIDTH: i32 = 64;
const MIN_VIEWPORT_HEIGHT: i32 = 64;

const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

fn scale_bias(v: [f32; 4], scale: [f32; 4], bias: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|c| v[c] * scale[c] + bias[c])
}

fn log2_floor(value: i32) -> usize {
    (31 - (value as u32).leading_zeros()) as usize
}

/// The lookup precision both case kinds build from the render target's colour depth.
fn lookup_precision(
    context: &Context,
    min_filter: u32,
    mag_filter: u32,
    color_scale: [f32; 4],
    coord_bits: [i32; 3],
    uvw_bits: [i32; 3],
) -> LookupPrecision {
    let is_nearest_only = min_filter == glw::GL_NEAREST && mag_filter == glw::GL_NEAREST;
    let pixel_format = context.render_target().pixel_format();
    // 1 inaccurate bit if nearest only, 2 otherwise
    let color_bits: [i32; 4] = get_bits_vec(pixel_format).map(|b| (b - if is_nearest_only { 1 } else { 2 }).max(0));
    let fixed = compute_fixed_point_threshold(color_bits);
    LookupPrecision {
        coord_bits,
        uvw_bits,
        color_mask: get_compare_mask(pixel_format),
        color_threshold: std::array::from_fn(|c| fixed[c] / color_scale[c]),
        ..Default::default()
    }
}

struct Texture2DFilteringCase {
    name: String,
    min_filter: u32,
    mag_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
    format: u32,
    data_type: u32,
    width: i32,
    height: i32,
    /// The `filenames` constructor: one ETC1 image per level; the format and size fields are unused then.
    etc1: Option<Vec<Etc1Image>>,
}

impl TestCase for Texture2DFilteringCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `Texture2DFilteringCase::init`: create 2 textures.
        let mut textures = Vec::with_capacity(2);
        if let Some(levels) = &self.etc1 {
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
                textures.push(Texture2D::new(
                    render_ctx,
                    self.format,
                    self.data_type,
                    self.width as u32,
                    self.height as u32,
                )?);
            }

            let mipmaps = (self.width as u32).is_power_of_two() && (self.height as u32).is_power_of_two();
            let num_levels = if mipmaps {
                log2_floor(self.width.max(self.height)) + 1
            } else {
                1
            };
            let fmt_info = get_texture_format_info(textures[0].ref_texture().format());
            let c_bias = fmt_info.value_min;
            let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);

            // Fill first gradient texture.
            for level_ndx in 0..num_levels {
                let g_min = scale_bias([-0.5, -0.5, -0.5, 2.0], c_scale, c_bias);
                let g_max = scale_bias([1.0, 1.0, 1.0, 0.0], c_scale, c_bias);

                textures[0].ref_texture_mut().alloc_level(level_ndx);
                let mut level = textures[0].ref_texture_mut().level_mut(level_ndx);
                fill_with_component_gradients2(&mut level, g_min, g_max);
            }

            // Fill second with grid texture.
            for level_ndx in 0..num_levels {
                let step = 0x00ff_ffffu32 / num_levels as u32;
                let rgb = step * level_ndx as u32;
                let color_a = 0xff00_0000 | rgb;
                let color_b = 0xff00_0000 | !rgb;

                textures[1].ref_texture_mut().alloc_level(level_ndx);
                let mut level = textures[1].ref_texture_mut().level_mut(level_ndx);
                fill_with_grid(
                    &mut level,
                    4,
                    scale_bias(RGBA::from_packed(color_a).to_vec().m_data, c_scale, c_bias),
                    scale_bias(RGBA::from_packed(color_b).to_vec().m_data, c_scale, c_bias),
                );
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
        let viewport_w = VIEWPORT_WIDTH.min(render_target.width) as f32;
        let viewport_h = VIEWPORT_HEIGHT.min(render_target.height) as f32;

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es100, Precision::MediumP);
        let mut is_all_ok = true;

        for (case_ndx, &(tex_ndx, lod_x, lod_y, o_x, o_y)) in CASES.iter().enumerate() {
            let texture = &textures[tex_ndx.min(textures.len() - 1)];
            let s_x = lod_x.exp2() * viewport_w / texture.ref_texture().width() as f32;
            let s_y = lod_y.exp2() * viewport_h / texture.ref_texture().height() as f32;
            let (min_coord, max_coord) = (Vec2::new(o_x, o_y), Vec2::new(o_x + s_x, o_y + s_y));

            let viewport = RandomViewport::new(
                &render_target,
                VIEWPORT_WIDTH,
                VIEWPORT_HEIGHT,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );
            let tex_fmt = texture.ref_texture().format();
            let fmt_info = get_texture_format_info(tex_fmt);
            let mut rendered = Surface::new(viewport.width, viewport.height);

            if viewport.width < MIN_VIEWPORT_WIDTH || viewport.height < MIN_VIEWPORT_HEIGHT {
                return Err(TestError::NotSupported("Too small viewport".to_string()));
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

            let tex_coord = compute_quad_tex_coord_2d(min_coord, max_coord);

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

            let lookup_prec = lookup_precision(
                context,
                self.min_filter,
                self.mag_filter,
                fmt_info.look_up_scale,
                [9, 9, 0],
                [5, 5, 0],
            );
            let lod_prec = LodPrecision {
                derivate_bits: 7,
                lod_bits: 4,
            };
            let is_ok = verify_texture_result_2d(
                &rendered,
                texture.ref_texture(),
                tex_coord,
                &ref_params,
                &lookup_prec,
                &lod_prec,
                render_target.pixel_format(),
            )?;
            if !is_ok {
                is_all_ok = false;
            }
        }

        if is_all_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image verification failed"))
        }
    }
}

struct TextureCubeFilteringCase {
    name: String,
    min_filter: u32,
    mag_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
    format: u32,
    data_type: u32,
    width: i32,
    height: i32,
    /// The `filenames` constructor: `[level][face]` ETC1 images; the format and size fields are unused then.
    etc1: Option<Vec<[Etc1Image; 6]>>,
}

impl TestCase for TextureCubeFilteringCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `TextureCubeFilteringCase::init`
        let mut textures = Vec::with_capacity(2);
        if let Some(levels) = &self.etc1 {
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
                textures.push(TextureCube::new(
                    render_ctx,
                    self.format,
                    self.data_type,
                    self.width as u32,
                )?);
            }

            let mipmaps = (self.width as u32).is_power_of_two() && (self.height as u32).is_power_of_two();
            let num_levels = if mipmaps {
                log2_floor(self.width.max(self.height)) + 1
            } else {
                1
            };
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
            }
            for (face_ndx, &face) in FACES.iter().enumerate() {
                for level_ndx in 0..num_levels {
                    let mut level = textures[0].ref_texture_mut().face_level_mut(face, level_ndx);
                    fill_with_component_gradients2(
                        &mut level,
                        scale_bias(GRADIENTS[face_ndx].0, c_scale, c_bias),
                        scale_bias(GRADIENTS[face_ndx].1, c_scale, c_bias),
                    );
                }
            }

            // Fill second with grid texture.
            for level_ndx in 0..num_levels {
                textures[1].ref_texture_mut().alloc_level(level_ndx);
            }
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

        // \note Coordinates are chosen so that they only sample face interior. ES3 has changed
        // edge sampling behavior and hw is not expected to implement both modes.
        let cases: [(usize, Vec2, Vec2); 4] = [
            (0, Vec2::new(-0.8, -0.8), Vec2::new(0.8, 0.8)), // minification
            (0, Vec2::new(0.5, 0.65), Vec2::new(0.8, 0.8)),  // magnification
            (1, Vec2::new(-0.8, -0.8), Vec2::new(0.8, 0.8)), // minification
            (1, Vec2::new(0.2, 0.2), Vec2::new(0.6, 0.5)),   // magnification
        ];

        let viewport_size = 28;
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es100, Precision::MediumP);
        let mut is_all_ok = true;

        for (case_ndx, (tex_ndx, bottom_left, top_right)) in cases.iter().enumerate() {
            let texture = &textures[(*tex_ndx).min(textures.len() - 1)];
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
                self.wrap_s,
                self.wrap_t,
                self.wrap_s,
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
                let tex_coord = compute_quad_tex_coord_cube_region(face, *bottom_left, *top_right);

                renderer.render_quad(0, &tex_coord, &sample_params.base)?;
                glu::expect_no_error(gl, "Draw")?;

                read_pixels(render_ctx, viewport.x, viewport.y, &mut result.get_access())?;
                glu::expect_no_error(gl, "Read pixels")?;

                let lookup_prec = lookup_precision(
                    context,
                    self.min_filter,
                    self.mag_filter,
                    fmt_info.look_up_scale,
                    [9, 9, 9],
                    [3, 3, 0],
                );
                let lod_prec = LodPrecision {
                    derivate_bits: 5,
                    lod_bits: 3,
                };
                let is_ok = verify_texture_result_cube(
                    &result,
                    texture.ref_texture(),
                    tex_coord,
                    &sample_params,
                    &lookup_prec,
                    &lod_prec,
                    render_target.pixel_format(),
                )?;
                if !is_ok {
                    is_all_ok = false;
                }
            }
        }

        if is_all_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image verification failed"))
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
    const SIZES_2D: [(&str, i32, i32); 2] = [("pot", 32, 64), ("npot", 31, 55)];
    const SIZES_CUBE: [(&str, i32, i32); 2] = [("pot", 64, 64), ("npot", 63, 63)];
    const FORMATS: [(&str, u32, u32); 4] = [
        ("rgba8888", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
        ("rgb888", glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
        ("rgba4444", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        ("l8", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
    ];

    let mut group = TestCaseGroup::new("filtering");
    let mut group_2d = TestCaseGroup::new("2d");
    let mut group_cube = TestCaseGroup::new("cube");

    // `is_cube` selects between the two near-identical loops upstream spells out twice.
    for is_cube in [false, true] {
        let sizes: &[(&str, i32, i32)] = if is_cube { &SIZES_CUBE } else { &SIZES_2D };

        for &(min_name, min_filter) in &MIN_FILTER_MODES {
            for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
                for &(wrap_name, wrap_mode) in &WRAP_MODES {
                    for (format_ndx, &(format_name, format, data_type)) in FORMATS.iter().enumerate() {
                        for &(size_name, width, height) in sizes {
                            let is_mipmap = min_filter != glw::GL_NEAREST && min_filter != glw::GL_LINEAR;
                            let is_clamp = wrap_mode == glw::GL_CLAMP_TO_EDGE;
                            let is_repeat = wrap_mode == glw::GL_REPEAT;
                            let is_mag_nearest = mag_filter == glw::GL_NEAREST;
                            let is_pot_size = (width as u32).is_power_of_two() && (height as u32).is_power_of_two();

                            if (is_mipmap || !is_clamp) && !is_pot_size {
                                continue; // Not supported.
                            }
                            if format_ndx != 0 && !(!is_mipmap || (is_repeat && is_mag_nearest)) {
                                continue; // Skip.
                            }

                            let mut name = format!("{min_name}_{mag_name}_{wrap_name}_{format_name}");
                            if !is_mipmap {
                                name += &format!("_{size_name}");
                            }

                            if is_cube {
                                group_cube.add_child(Box::new(TextureCubeFilteringCase {
                                    name,
                                    min_filter,
                                    mag_filter,
                                    wrap_s: wrap_mode,
                                    wrap_t: wrap_mode,
                                    format,
                                    data_type,
                                    width,
                                    height,
                                    etc1: None,
                                }) as Box<dyn TestCase>);
                            } else {
                                group_2d.add_child(Box::new(Texture2DFilteringCase {
                                    name,
                                    min_filter,
                                    mag_filter,
                                    wrap_s: wrap_mode,
                                    wrap_t: wrap_mode,
                                    format,
                                    data_type,
                                    width,
                                    height,
                                    etc1: None,
                                }) as Box<dyn TestCase>);
                            }
                        }
                    }
                }
            }
        }
    }

    // 2D ETC1 texture cases.
    for &(min_name, min_filter) in &MIN_FILTER_MODES {
        for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
            for &(wrap_name, wrap_mode) in &WRAP_MODES {
                let name = format!("{min_name}_{mag_name}_{wrap_name}_etc1");
                group_2d.add_child(Box::new(Texture2DFilteringCase {
                    name,
                    min_filter,
                    mag_filter,
                    wrap_s: wrap_mode,
                    wrap_t: wrap_mode,
                    format: 0,
                    data_type: 0,
                    width: 0,
                    height: 0,
                    etc1: Some(crate::glu::etc1::photo_mip_levels()),
                }) as Box<dyn TestCase>);
            }
        }
    }

    // Cubemap ETC1 cases
    for &(min_name, min_filter) in &MIN_FILTER_MODES {
        for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
            let name = format!("{min_name}_{mag_name}_clamp_etc1");
            group_cube.add_child(Box::new(TextureCubeFilteringCase {
                name,
                min_filter,
                mag_filter,
                wrap_s: glw::GL_CLAMP_TO_EDGE,
                wrap_t: glw::GL_CLAMP_TO_EDGE,
                format: 0,
                data_type: 0,
                width: 0,
                height: 0,
                etc1: Some(crate::glu::etc1::skybox_pot_levels()),
            }) as Box<dyn TestCase>);
        }
    }

    group.add_child(group_2d);
    group.add_child(group_cube);
    group
}

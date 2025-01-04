// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureMipmapTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `generate` groups (`Texture2DGenMipmapCase`/`TextureCubeGenMipmapCase`) live in
// `gls::gen_mipmap`, shared with the ES 3.0 file.
// `ContextInfo::isFragmentHighPrecisionSupported` compiles a probe shader upstream; here it
// is a `glGetShaderPrecisionFormat` query (`is_fragment_high_precision_supported`).

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{
    LodMode, RenderParams, TextureType, compute_quad_tex_coord_2d, compute_texture_lookup_diff_2d,
    compute_texture_lookup_diff_cube, get_sampler_type,
};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, compute_quad_tex_coord_cube, get_bits_vec, get_compare_mask,
    is_fragment_high_precision_supported, levels_2d, levels_cube, make_reference_params, sample_texture_2d_to_surface,
    sample_texture_cube_to_surface,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{CubeFace, clear};
use crate::tcu::random::Random;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};

#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum CoordType {
    /// texCoord = translateScale(position).
    Basic,
    /// Like basic, but with bias values.
    BasicBias,
    /// texCoord = translateScaleRotateShear(position).
    Affine,
    /// Projected coordinates, w != 1
    Projected,
}

pub(crate) const BIAS: [f32; 8] = [1.0, -2.0, 0.8, -0.5, 1.5, 0.9, 2.0, 4.0];

pub(crate) const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

pub(crate) fn log2_floor(value: i32) -> usize {
    (31 - (value as u32).leading_zeros()) as usize
}

pub(crate) fn level_color(num_levels: usize, level_ndx: usize) -> (u32, u32) {
    let step = 0xffu32 / (num_levels as u32 - 1);
    let inc = (step * level_ndx as u32).clamp(0x00, 0xff);
    (inc, 0xff - inc)
}

/// `getBasicTexCoord2D`
pub(crate) fn get_basic_tex_coord_2d(cell_ndx: usize) -> [f32; 8] {
    const BASIC_COORDS: [([f32; 2], [f32; 2]); 16] = [
        ([-0.1, 0.1], [0.8, 1.0]),
        ([-0.3, -0.6], [0.7, 0.4]),
        ([-0.3, 0.6], [0.7, -0.9]),
        ([-0.8, 0.6], [0.7, -0.9]),
        ([-0.5, -0.5], [1.5, 1.5]),
        ([1.0, -1.0], [-1.3, 1.0]),
        ([1.2, -1.0], [-1.3, 1.6]),
        ([2.2, -1.1], [-1.3, 0.8]),
        ([-1.5, 1.6], [1.7, -1.4]),
        ([2.0, 1.6], [2.3, -1.4]),
        ([1.3, -2.6], [-2.7, 2.9]),
        ([-0.8, -6.6], [6.0, -0.9]),
        ([-8.0, 9.0], [8.3, -7.0]),
        ([-16.0, 10.0], [18.3, 24.0]),
        ([30.2, 55.0], [-24.3, -1.6]),
        ([-33.2, 64.1], [32.1, -64.1]),
    ];

    let (bottom_left, top_right) = BASIC_COORDS[cell_ndx];
    compute_quad_tex_coord_2d(
        Vec2::new(bottom_left[0], bottom_left[1]),
        Vec2::new(top_right[0], top_right[1]),
    )
}

/// `getAffineTexCoord2D`
fn get_affine_tex_coord_2d(cell_ndx: usize) -> [f32; 8] {
    // Use basic coords as base.
    let mut dst = get_basic_tex_coord_2d(cell_ndx);

    // Rotate based on cell index.
    let angle = 2.0 * std::f32::consts::PI * (cell_ndx as f32 / 16.0);
    let (c, s) = (angle.cos(), angle.sin());
    let rot = [[c, -s], [s, c]];

    // Second and third row are sheared.
    let shear_x = if (4..=11).contains(&cell_ndx) {
        (15 - cell_ndx as i32) as f32 / 16.0
    } else {
        0.0
    };
    let shear = [[1.0, shear_x], [0.0, 1.0]];

    let mut transform = [[0.0f32; 2]; 2];
    for row in 0..2 {
        for col in 0..2 {
            transform[row][col] = rot[row][0] * shear[0][col] + rot[row][1] * shear[1][col];
        }
    }

    for vertex in 0..4 {
        let (x, y) = (dst[vertex * 2], dst[vertex * 2 + 1]);
        dst[vertex * 2] = transform[0][0] * x + transform[0][1] * y;
        dst[vertex * 2 + 1] = transform[1][0] * x + transform[1][1] * y;
    }
    dst
}

pub(crate) struct Texture2DMipmapCase {
    pub(crate) es3: bool,
    pub(crate) name: String,
    pub(crate) coord_type: CoordType,
    pub(crate) min_filter: u32,
    pub(crate) wrap_s: u32,
    pub(crate) wrap_t: u32,
    pub(crate) format: u32,
    pub(crate) data_type: u32,
    pub(crate) width: i32,
    pub(crate) height: i32,
}

impl TestCase for Texture2DMipmapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `Texture2DMipmapCase::init`
        if self.coord_type == CoordType::Projected && render_target.num_samples > 0 {
            return Err(TestError::NotSupported(
                "Projected lookup validation not supported in multisample config".to_string(),
            ));
        }
        let mut renderer = TextureRenderer::new(
            render_ctx,
            if self.es3 {
                GlslVersion::Es300
            } else {
                GlslVersion::Es100
            },
            if self.es3 || is_fragment_high_precision_supported(gl) {
                Precision::HighP
            } else {
                Precision::MediumP
            },
        );

        let mut texture = Texture2D::new(
            render_ctx,
            self.format,
            self.data_type,
            self.width as u32,
            self.height as u32,
        )?;
        let num_levels = log2_floor(self.width.max(self.height)) + 1;

        // Fill texture with colored grid.
        for level_ndx in 0..num_levels {
            let (inc, dec) = level_color(num_levels, level_ndx);
            let rgb = (inc << 16) | (dec << 8) | 0xff;
            let color = 0xff00_0000 | rgb;

            texture.ref_texture_mut().alloc_level(level_ndx);
            let mut level = texture.ref_texture_mut().level_mut(level_ndx);
            clear(&mut level, RGBA::from_packed(color).to_vec().m_data);
        }

        // `Texture2DMipmapCase::iterate`
        let mag_filter = glw::GL_NEAREST;
        let tex_width = texture.ref_texture().width() as i32;
        let tex_height = texture.ref_texture().height() as i32;
        let def_viewport_width = tex_width * 4;
        let def_viewport_height = tex_height * 4;

        let viewport = RandomViewport::new(
            &render_target,
            def_viewport_width,
            def_viewport_height,
            de_string_hash(&self.name),
        );
        let is_projected = self.coord_type == CoordType::Projected;
        let use_lod_bias = self.coord_type == CoordType::BasicBias;

        let mut rendered_frame = Surface::new(viewport.width, viewport.height);

        // Viewport is divided into 4x4 grid.
        let (grid_width, grid_height) = (4, 4);
        let cell_width = viewport.width / grid_width;
        let cell_height = viewport.height / grid_height;

        // Bail out if rendertarget is too small.
        if viewport.width < def_viewport_width / 2 || viewport.height < def_viewport_height / 2 {
            return Err(TestError::NotSupported("Too small viewport".to_string()));
        }

        // Sampling parameters.
        let mut sample_params = make_reference_params(
            TextureType::Texture2D,
            self.wrap_s,
            self.wrap_t,
            self.wrap_s,
            self.min_filter,
            mag_filter,
            LodMode::Exact,
        )?;
        sample_params.base.sampler_type = get_sampler_type(texture.ref_texture().format());
        sample_params.base.projected = is_projected;
        sample_params.base.use_bias = use_lod_bias;

        // Upload texture data.
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            texture.upload()?;

            // Bind gradient texture and setup sampler parameters.
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }
        glu::expect_no_error(gl, "After texture setup")?;

        // Projection values.
        const PROJECTIONS: [[f32; 4]; 4] = [
            [1.2, 1.0, 0.7, 1.0],
            [1.3, 0.8, 0.6, 2.0],
            [0.8, 1.0, 1.7, 0.6],
            [1.2, 1.0, 1.7, 1.5],
        ];

        let tex_coord_for = |cell_ndx: usize| {
            if self.coord_type == CoordType::Affine {
                get_affine_tex_coord_2d(cell_ndx)
            } else {
                get_basic_tex_coord_2d(cell_ndx)
            }
        };

        // Render cells.
        for grid_y in 0..grid_height {
            for grid_x in 0..grid_width {
                let cur_x = cell_width * grid_x;
                let cur_y = cell_height * grid_y;
                let cur_w = if grid_x + 1 == grid_width {
                    viewport.width - cur_x
                } else {
                    cell_width
                };
                let cur_h = if grid_y + 1 == grid_height {
                    viewport.height - cur_y
                } else {
                    cell_height
                };
                let cell_ndx = (grid_y * grid_width + grid_x) as usize;

                let tex_coord = tex_coord_for(cell_ndx);
                if is_projected {
                    sample_params.base.w = Vec4::from_array(PROJECTIONS[cell_ndx % PROJECTIONS.len()]);
                }
                if use_lod_bias {
                    sample_params.base.bias = BIAS[cell_ndx % BIAS.len()];
                }

                // Render with GL.
                // SAFETY: plain state setting on the current context.
                unsafe { gl.viewport(viewport.x + cur_x, viewport.y + cur_y, cur_w, cur_h) };
                renderer.render_quad(0, &tex_coord, &sample_params.base)?;
            }
        }

        // Read result.
        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

        // Compare and log.
        let is_trilinear =
            self.min_filter == glw::GL_NEAREST_MIPMAP_LINEAR || self.min_filter == glw::GL_LINEAR_MIPMAP_LINEAR;
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let mut error_mask = Surface::new(viewport.width, viewport.height);
        let mut num_failed_pixels = 0;

        let lookup_prec = LookupPrecision {
            coord_bits: [20, 20, 0],
            uvw_bits: [16, 16, 0], // Doesn't really matter since pixels are unicolored.
            color_threshold: compute_fixed_point_threshold(
                get_bits_vec(pixel_format).map(|b| (b - if is_trilinear { 2 } else { 1 }).max(0)),
            ),
            color_mask: get_compare_mask(pixel_format),
            ..Default::default()
        };
        let lod_prec = LodPrecision {
            derivate_bits: 10,
            lod_bits: if is_projected { 6 } else { 8 },
        };

        for grid_y in 0..grid_height {
            for grid_x in 0..grid_width {
                let cur_x = cell_width * grid_x;
                let cur_y = cell_height * grid_y;
                let cur_w = if grid_x + 1 == grid_width {
                    viewport.width - cur_x
                } else {
                    cell_width
                };
                let cur_h = if grid_y + 1 == grid_height {
                    viewport.height - cur_y
                } else {
                    cell_height
                };
                let cell_ndx = (grid_y * grid_width + grid_x) as usize;

                let tex_coord = tex_coord_for(cell_ndx);
                if is_projected {
                    sample_params.base.w = Vec4::from_array(PROJECTIONS[cell_ndx % PROJECTIONS.len()]);
                }
                if use_lod_bias {
                    sample_params.base.bias = BIAS[cell_ndx % BIAS.len()];
                }

                // Render ideal result
                {
                    let mut dst =
                        SurfaceAccess::new_region(&mut reference_frame, pixel_format, cur_x, cur_y, cur_w, cur_h);
                    sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &sample_params)?;
                }

                // Compare this cell
                let levels = levels_2d(texture.ref_texture());
                let rendered_access = rendered_frame.get_const_access();
                let reference_access = reference_frame.get_const_access();
                let mut mask_access = error_mask.get_access();
                let (x, y, w, h) = (cur_x as u32, cur_y as u32, cur_w as u32, cur_h as u32);
                num_failed_pixels += compute_texture_lookup_diff_2d(
                    &rendered_access.get_subregion(x, y, 0, w, h, 1),
                    &reference_access.get_subregion(x, y, 0, w, h, 1),
                    &mut mask_access.get_subregion(x, y, 0, w, h, 1),
                    &levels,
                    tex_coord,
                    &sample_params,
                    &lookup_prec,
                    &lod_prec,
                );
            }
        }

        if num_failed_pixels == 0 {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image verification failed"))
        }
    }
}

/// `randomPartition`
fn random_partition(dst: &mut Vec<[i32; 4]>, rnd: &mut Random, x: i32, y: i32, width: i32, height: i32) {
    const MIN_WIDTH: i32 = 8;
    const MIN_HEIGHT: i32 = 8;

    let partition = rnd.get_float() > 0.4;
    let partition_x = partition && width > MIN_WIDTH && rnd.get_bool();
    let partition_y = partition && height > MIN_HEIGHT && !partition_x;

    if partition_x {
        let split = width / 2 + rnd.get_int(-width / 4, width / 4);
        random_partition(dst, rnd, x, y, split, height);
        random_partition(dst, rnd, x + split, y, width - split, height);
    } else if partition_y {
        let split = height / 2 + rnd.get_int(-height / 4, height / 4);
        random_partition(dst, rnd, x, y, width, split);
        random_partition(dst, rnd, x, y + split, width, height - split);
    } else {
        dst.push([x, y, width, height]);
    }
}

/// `computeGridLayout`
pub(crate) fn compute_grid_layout(width: i32, height: i32) -> Vec<[i32; 4]> {
    let mut dst = Vec::new();
    let mut rnd = Random::new(7);
    random_partition(&mut dst, &mut rnd, 0, 0, width, height);
    dst
}

pub(crate) struct TextureCubeMipmapCase {
    pub(crate) es3: bool,
    pub(crate) name: String,
    pub(crate) coord_type: CoordType,
    pub(crate) min_filter: u32,
    pub(crate) wrap_s: u32,
    pub(crate) wrap_t: u32,
    pub(crate) format: u32,
    pub(crate) data_type: u32,
    pub(crate) size: i32,
}

impl TestCase for TextureCubeMipmapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `TextureCubeMipmapCase::init`
        if self.coord_type == CoordType::Projected && render_target.num_samples > 0 {
            return Err(TestError::NotSupported(
                "Projected lookup validation not supported in multisample config".to_string(),
            ));
        }
        let mut renderer = TextureRenderer::new(
            render_ctx,
            if self.es3 {
                GlslVersion::Es300
            } else {
                GlslVersion::Es100
            },
            if self.es3 || is_fragment_high_precision_supported(gl) {
                Precision::HighP
            } else {
                Precision::MediumP
            },
        );

        let mut texture = TextureCube::new(render_ctx, self.format, self.data_type, self.size as u32)?;
        let num_levels = log2_floor(self.size) + 1;

        // Fill texture with colored grid.
        for level_ndx in 0..num_levels {
            texture.ref_texture_mut().alloc_level(level_ndx);
        }
        for (face_ndx, &face) in FACES.iter().enumerate() {
            for level_ndx in 0..num_levels {
                let (inc, dec) = level_color(num_levels, level_ndx);
                let rgb = match face_ndx {
                    0 => (inc << 16) | (dec << 8) | 255,
                    1 => (255 << 16) | (inc << 8) | dec,
                    2 => (dec << 16) | (255 << 8) | inc,
                    3 => (dec << 16) | (inc << 8) | 255,
                    4 => (255 << 16) | (dec << 8) | inc,
                    _ => (inc << 16) | (255 << 8) | dec,
                };
                let color = 0xff00_0000 | rgb;

                let mut level = texture.ref_texture_mut().face_level_mut(face, level_ndx);
                clear(&mut level, RGBA::from_packed(color).to_vec().m_data);
            }
        }

        // `TextureCubeMipmapCase::iterate`
        let mag_filter = glw::GL_NEAREST;
        let def_viewport_width = self.size * 2;
        let def_viewport_height = self.size * 2;
        let viewport = RandomViewport::new(
            &render_target,
            def_viewport_width,
            def_viewport_height,
            de_string_hash(&self.name),
        );

        let is_projected = self.coord_type == CoordType::Projected;
        let use_lod_bias = self.coord_type == CoordType::BasicBias;

        let mut rendered_frame = Surface::new(viewport.width, viewport.height);

        // Bail out if rendertarget is too small.
        if viewport.width < def_viewport_width / 2 || viewport.height < def_viewport_height / 2 {
            return Err(TestError::NotSupported("Too small viewport".to_string()));
        }

        let is_es3_compatible = self.es3 || context.is_es3_compatible();

        // Upload texture data.
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            texture.upload()?;

            // Bind gradient texture and setup sampler parameters.
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_MIN_FILTER,
                self.min_filter as i32,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }
        glu::expect_no_error(gl, "After texture setup")?;

        // Compute grid.
        let grid_layout = compute_grid_layout(viewport.width, viewport.height);

        // Projection values \note Less agressive than in 2D case due to smaller quads.
        const PROJECTIONS: [[f32; 4]; 4] = [
            [1.2, 1.0, 0.7, 1.0],
            [1.3, 0.8, 0.6, 1.1],
            [0.8, 1.0, 1.2, 0.8],
            [1.2, 1.0, 1.3, 0.9],
        ];

        assert!(
            self.coord_type != CoordType::Affine,
            "affine coordinates are not supported for cube maps"
        );

        // Render with GL
        for (cell_ndx, cell) in grid_layout.iter().enumerate() {
            let [cur_x, cur_y, cur_w, cur_h] = *cell;
            let cube_face = FACES[cell_ndx % FACES.len()];
            let mut params = RenderParams::new(TextureType::Cube);
            let tex_coord = compute_quad_tex_coord_cube(cube_face);

            if is_projected {
                params.projected = true;
                params.w = Vec4::from_array(PROJECTIONS[cell_ndx % PROJECTIONS.len()]);
            }
            if use_lod_bias {
                params.use_bias = true;
                params.bias = BIAS[cell_ndx % BIAS.len()];
            }

            // Render with GL.
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x + cur_x, viewport.y + cur_y, cur_w, cur_h) };
            renderer.render_quad(0, &tex_coord, &params)?;
        }
        glu::expect_no_error(gl, "Draw")?;

        // Read result.
        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;
        glu::expect_no_error(gl, "Read pixels")?;

        // Render reference and compare
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let mut error_mask = Surface::new(viewport.width, viewport.height);
        let mut num_failed_pixels = 0;

        // Params for rendering reference
        let mut params = make_reference_params(
            TextureType::Cube,
            self.wrap_s,
            self.wrap_t,
            self.wrap_s,
            self.min_filter,
            mag_filter,
            LodMode::Exact,
        )?;
        params.sampler.seamless_cube_map = is_es3_compatible;

        // Comparison parameters
        let coord_bits = if is_projected { 8 } else { 10 };
        let lookup_prec = LookupPrecision {
            color_mask: get_compare_mask(pixel_format),
            color_threshold: compute_fixed_point_threshold(
                get_bits_vec(pixel_format).map(|b| (b - if is_projected { 3 } else { 2 }).max(0)),
            ),
            coord_bits: [coord_bits; 3],
            uvw_bits: [5, 5, 0],
            ..Default::default()
        };
        let lod_bits = if is_es3_compatible { 3 } else { 4 };
        let lod_prec = LodPrecision {
            derivate_bits: 10,
            lod_bits: if is_projected { lod_bits } else { 6 },
        };

        for (cell_ndx, cell) in grid_layout.iter().enumerate() {
            let [cur_x, cur_y, cur_w, cur_h] = *cell;
            let cube_face = FACES[cell_ndx % FACES.len()];
            let tex_coord = compute_quad_tex_coord_cube(cube_face);

            if is_projected {
                params.base.projected = true;
                params.base.w = Vec4::from_array(PROJECTIONS[cell_ndx % PROJECTIONS.len()]);
            }
            if use_lod_bias {
                params.base.use_bias = true;
                params.base.bias = BIAS[cell_ndx % BIAS.len()];
            }

            // Render ideal reference.
            {
                let mut ideal_dst =
                    SurfaceAccess::new_region(&mut reference_frame, pixel_format, cur_x, cur_y, cur_w, cur_h);
                sample_texture_cube_to_surface(&mut ideal_dst, texture.ref_texture(), tex_coord, &params)?;
            }

            // Compare this cell
            let levels = levels_cube(texture.ref_texture());
            let rendered_access = rendered_frame.get_const_access();
            let reference_access = reference_frame.get_const_access();
            let mut mask_access = error_mask.get_access();
            let (x, y, w, h) = (cur_x as u32, cur_y as u32, cur_w as u32, cur_h as u32);
            num_failed_pixels += compute_texture_lookup_diff_cube(
                &rendered_access.get_subregion(x, y, 0, w, h, 1),
                &reference_access.get_subregion(x, y, 0, w, h, 1),
                &mut mask_access.get_subregion(x, y, 0, w, h, 1),
                &levels,
                tex_coord,
                &params,
                &lookup_prec,
                &lod_prec,
            );
        }

        if num_failed_pixels == 0 {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image verification failed"))
        }
    }
}

/// `TextureMipmapTests::init`
pub fn create_tests() -> TestCaseGroup {
    const WRAP_MODES: [(&str, u32); 3] = [
        ("clamp", glw::GL_CLAMP_TO_EDGE),
        ("repeat", glw::GL_REPEAT),
        ("mirror", glw::GL_MIRRORED_REPEAT),
    ];
    const MIN_FILTER_MODES: [(&str, u32); 4] = [
        ("nearest_nearest", glw::GL_NEAREST_MIPMAP_NEAREST),
        ("linear_nearest", glw::GL_LINEAR_MIPMAP_NEAREST),
        ("nearest_linear", glw::GL_NEAREST_MIPMAP_LINEAR),
        ("linear_linear", glw::GL_LINEAR_MIPMAP_LINEAR),
    ];
    const COORD_TYPES: [(CoordType, &str); 3] = [
        (CoordType::Basic, "basic"),
        (CoordType::Affine, "affine"),
        (CoordType::Projected, "projected"),
    ];
    const TEX_2D_SIZES: [(Option<&str>, i32, i32); 2] = [(None, 64, 64), (Some("non_square"), 32, 64)];

    let mut group = TestCaseGroup::new("mipmap");
    let mut group_2d = TestCaseGroup::new("2d");
    let mut group_cube = TestCaseGroup::new("cube");

    // 2D cases.
    for &(coord_type, coord_name) in &COORD_TYPES {
        let mut coord_type_group = TestCaseGroup::new(coord_name);

        for &(filter_name, min_filter) in &MIN_FILTER_MODES {
            for &(wrap_name, wrap_mode) in &WRAP_MODES {
                // Add non_square variants to basic cases only.
                let size_end = if coord_type == CoordType::Basic {
                    TEX_2D_SIZES.len()
                } else {
                    1
                };

                for &(size_name, width, height) in &TEX_2D_SIZES[..size_end] {
                    let mut name = format!("{filter_name}_{wrap_name}");
                    if let Some(size_name) = size_name {
                        name += &format!("_{size_name}");
                    }

                    coord_type_group.add_child(Box::new(Texture2DMipmapCase {
                        es3: false,
                        name,
                        coord_type,
                        min_filter,
                        wrap_s: wrap_mode,
                        wrap_t: wrap_mode,
                        format: glw::GL_RGBA,
                        data_type: glw::GL_UNSIGNED_BYTE,
                        width,
                        height,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        group_2d.add_child(coord_type_group);
    }

    // 2D bias variants.
    {
        let mut bias_group = TestCaseGroup::new("bias");
        for &(filter_name, min_filter) in &MIN_FILTER_MODES {
            bias_group.add_child(Box::new(Texture2DMipmapCase {
                es3: false,
                name: filter_name.to_string(),
                coord_type: CoordType::BasicBias,
                min_filter,
                wrap_s: glw::GL_REPEAT,
                wrap_t: glw::GL_REPEAT,
                format: glw::GL_RGBA,
                data_type: glw::GL_UNSIGNED_BYTE,
                width: TEX_2D_SIZES[0].1,
                height: TEX_2D_SIZES[0].2,
            }) as Box<dyn TestCase>);
        }
        group_2d.add_child(bias_group);
    }

    // 2D mipmap generation variants.
    group_2d.add_child(crate::gls::gen_mipmap::create_2d_generate_group(false, &TEX_2D_SIZES));

    let cube_map_size = 64;
    const CUBE_COORD_TYPES: [(CoordType, &str); 3] = [
        (CoordType::Basic, "basic"),
        (CoordType::Projected, "projected"),
        (CoordType::BasicBias, "bias"),
    ];

    // Cubemap cases.
    for &(coord_type, coord_name) in &CUBE_COORD_TYPES {
        let mut coord_type_group = TestCaseGroup::new(coord_name);
        for &(filter_name, min_filter) in &MIN_FILTER_MODES {
            coord_type_group.add_child(Box::new(TextureCubeMipmapCase {
                es3: false,
                name: filter_name.to_string(),
                coord_type,
                min_filter,
                wrap_s: glw::GL_CLAMP_TO_EDGE,
                wrap_t: glw::GL_CLAMP_TO_EDGE,
                format: glw::GL_RGBA,
                data_type: glw::GL_UNSIGNED_BYTE,
                size: cube_map_size,
            }) as Box<dyn TestCase>);
        }
        group_cube.add_child(coord_type_group);
    }

    // Cubemap mipmap generation variants.
    group_cube.add_child(crate::gls::gen_mipmap::create_cube_generate_group(false, cube_map_size));

    group.add_child(group_2d);
    group.add_child(group_cube);
    group
}

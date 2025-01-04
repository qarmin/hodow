// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureMipmapTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `Texture2DMipmapCase` and
// `TextureCubeMipmapCase` are the ES 2.0 file's own cases (`es3: true`: GLSL ES 3.00, highp,
// seamless cube maps) - the two upstream files are the same code apart from those three
// points, so there is one port of it. The `*LodControlCase` class hierarchies (virtual
// `setTextureParams`/`getReferenceParams`) are one struct per texture type with a `Control`
// enum.
//
// The `generate` groups (`Texture2DGenMipmapCase`/`TextureCubeGenMipmapCase`) live in
// `gls::gen_mipmap`, shared with the ES 2.0 file.

use crate::gles2::functional::texture::mipmap::{
    BIAS, CoordType, FACES, Texture2DMipmapCase, TextureCubeMipmapCase, compute_grid_layout, get_basic_tex_coord_2d,
    level_color, log2_floor,
};
use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_3d::Texture3D;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, RenderParams, TextureType, compute_texture_lookup_diff_2d,
    compute_texture_lookup_diff_3d, compute_texture_lookup_diff_cube, get_sampler_type,
};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, compute_quad_tex_coord_cube, effective_levels, get_bits_vec, get_compare_mask,
    levels_2d, levels_cube, make_reference_params, sample_texture_2d_to_surface, sample_texture_3d_to_surface,
    sample_texture_cube_to_surface,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{ConstPixelBufferAccess, clear, get_texture_format_info};
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::vector::Vec4;
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};

/// `getMinLodForCell`
fn get_min_lod_for_cell(cell_ndx: usize) -> f32 {
    const VALUES: [f32; 16] = [
        1.0, 3.5, 2.0, -2.0, 0.0, 3.0, 10.0, 4.8, 5.8, 5.7, -1.9, 4.0, 6.5, 7.1, -1e10, 1000.0,
    ];
    VALUES[cell_ndx % VALUES.len()]
}

/// `getMaxLodForCell`
fn get_max_lod_for_cell(cell_ndx: usize) -> f32 {
    const VALUES: [f32; 17] = [
        0.0, 0.2, 0.7, 0.4, 1.3, 0.0, 0.5, 1.2, -2.0, 1.0, 0.1, 0.3, 2.7, 1.2, 10.0, -1000.0, 1e10,
    ];
    VALUES[cell_ndx % VALUES.len()]
}

/// The 4x4 grid every 2D/3D case divides its viewport into: `(x, y, w, h, cellNdx)` per
/// cell, last row/column absorbing the remainder, in upstream's gridY-outer order.
fn grid_cells(viewport_width: i32, viewport_height: i32) -> Vec<(i32, i32, i32, i32, usize)> {
    let (grid_width, grid_height) = (4, 4);
    let cell_width = viewport_width / grid_width;
    let cell_height = viewport_height / grid_height;
    let mut cells = Vec::new();
    for grid_y in 0..grid_height {
        for grid_x in 0..grid_width {
            let cur_x = cell_width * grid_x;
            let cur_y = cell_height * grid_y;
            let cur_w = if grid_x + 1 == grid_width {
                viewport_width - cur_x
            } else {
                cell_width
            };
            let cur_h = if grid_y + 1 == grid_height {
                viewport_height - cur_y
            } else {
                cell_height
            };
            cells.push((cur_x, cur_y, cur_w, cur_h, (grid_y * grid_width + grid_x) as usize));
        }
    }
    cells
}

/// `getBasicTexCoord3D`
fn get_basic_tex_coord_3d(cell_ndx: usize) -> [f32; 12] {
    // sScale, sBias, tScale, tBias, rScale, rBias
    const PARAMS: [[f32; 6]; 16] = [
        [0.9, -0.1, 0.7, 0.3, 0.8, 0.9],
        [1.2, -0.1, 1.1, 0.3, 1.0, 0.9],
        [1.5, 0.7, 0.9, -0.3, 1.1, 0.1],
        [1.2, 0.7, -2.3, -0.3, 1.1, 0.2],
        [1.1, 0.8, -1.3, -0.3, 2.9, 0.9],
        [3.4, 0.8, 4.0, 0.0, -3.3, -1.0],
        [-3.4, -0.1, -4.0, 0.0, -5.1, 1.0],
        [-4.0, -0.1, 3.4, 0.1, 5.7, 0.0],
        [-5.6, 0.0, 0.5, 1.2, 3.9, 4.0],
        [5.0, -2.0, 3.1, 1.2, 5.1, 0.2],
        [2.5, -2.0, 6.3, 3.0, 5.1, 0.2],
        [-8.3, 0.0, 7.1, 3.0, 2.0, 0.2],
        [3.8, 0.0, 9.7, 1.0, 7.0, 0.7],
        [13.3, 0.0, 7.1, 3.0, 2.0, 0.2],
        [16.0, 8.0, 12.7, 1.0, 17.1, 0.7],
        [15.3, 0.0, 20.1, 3.0, 33.0, 3.2],
    ];
    let [s_scale, s_bias, t_scale, t_bias, r_scale, r_bias] = PARAMS[cell_ndx % PARAMS.len()];

    [
        s_bias,
        t_bias,
        r_bias,
        s_bias,
        t_bias + t_scale,
        r_bias + r_scale * 0.5,
        s_bias + s_scale,
        t_bias,
        r_bias + r_scale * 0.5,
        s_bias + s_scale,
        t_bias + t_scale,
        r_bias + r_scale,
    ]
}

/// `getAffineTexCoord3D`
fn get_affine_tex_coord_3d(cell_ndx: usize) -> [f32; 12] {
    // Use basic coords as base.
    let mut dst = get_basic_tex_coord_3d(cell_ndx);

    // Rotate based on cell index.
    let angle_x = 0.0 + 2.0 * std::f32::consts::PI * (cell_ndx as f32 / 16.0);
    let angle_y = 1.0 + 2.0 * std::f32::consts::PI * (cell_ndx as f32 / 32.0);
    let (cx, sx) = (angle_x.cos(), angle_x.sin());
    let (cy, sy) = (angle_y.cos(), angle_y.sin());
    let rot_x = [[1.0, 0.0, 0.0], [0.0, cx, -sx], [0.0, sx, cx]];
    let rot_y = [[cy, 0.0, sy], [0.0, 1.0, 0.0], [-sy, 0.0, cy]];

    let mut rot = [[0.0f32; 3]; 3];
    for row in 0..3 {
        for col in 0..3 {
            rot[row][col] = (0..3).map(|k| rot_x[row][k] * rot_y[k][col]).sum();
        }
    }

    for vertex in 0..4 {
        let p = [dst[vertex * 3], dst[vertex * 3 + 1], dst[vertex * 3 + 2]];
        for row in 0..3 {
            dst[vertex * 3 + row] = rot[row][0] * p[0] + rot[row][1] * p[1] + rot[row][2] * p[2];
        }
    }
    dst
}

const PROJECTIONS_3D: [[f32; 4]; 4] = [
    [1.2, 1.0, 0.7, 1.0],
    [1.3, 0.8, 0.6, 2.0],
    [0.8, 1.0, 1.7, 0.6],
    [1.2, 1.0, 1.7, 1.5],
];

struct Texture3DMipmapCase {
    name: String,
    coord_type: CoordType,
    min_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
    wrap_r: u32,
    internal_format: u32,
    width: i32,
    height: i32,
    depth: i32,
}

impl TestCase for Texture3DMipmapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `Texture3DMipmapCase::init`
        if self.coord_type == CoordType::Projected && render_target.num_samples > 0 {
            return Err(TestError::NotSupported(
                "Projected lookup validation not supported in multisample config".to_string(),
            ));
        }
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);

        let mut texture = Texture3D::new_sized(
            render_ctx,
            self.internal_format,
            self.width as u32,
            self.height as u32,
            self.depth as u32,
        )?;
        let fmt_info = get_texture_format_info(texture.ref_texture().format());
        let (c_scale, c_bias) = (fmt_info.look_up_scale, fmt_info.look_up_bias);
        let num_levels = log2_floor(self.width.max(self.height).max(self.depth)) + 1;

        // Fill texture with colored grid.
        for level_ndx in 0..num_levels {
            let (inc, dec) = level_color(num_levels, level_ndx);
            let rgb = (0xff << 16) | (dec << 8) | inc;
            let color = 0xff00_0000 | rgb;
            let rgba = RGBA::from_packed(color).to_vec().m_data;

            texture.ref_texture_mut().alloc_level(level_ndx);
            let mut level = texture.ref_texture_mut().level_mut(level_ndx);
            clear(&mut level, std::array::from_fn(|c| rgba[c] * c_scale[c] + c_bias[c]));
        }
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe { texture.upload()? };

        // `Texture3DMipmapCase::iterate`
        let tex_width = texture.ref_texture().width() as i32;
        let tex_height = texture.ref_texture().height() as i32;
        let mag_filter = glw::GL_NEAREST;
        let viewport = RandomViewport::new(
            &render_target,
            tex_width * 4,
            tex_height * 4,
            de_string_hash(&self.name),
        );
        let is_projected = self.coord_type == CoordType::Projected;
        let use_lod_bias = self.coord_type == CoordType::BasicBias;
        let cells = grid_cells(viewport.width, viewport.height);
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);

        // Sampling parameters.
        let mut sample_params = make_reference_params(
            TextureType::Texture3D,
            self.wrap_s,
            self.wrap_t,
            self.wrap_r,
            self.min_filter,
            mag_filter,
            LodMode::Exact,
        )?;
        sample_params.base.sampler_type = get_sampler_type(texture.ref_texture().format());
        sample_params.base.color_bias = Vec4::from_array(fmt_info.look_up_bias);
        sample_params.base.color_scale = Vec4::from_array(fmt_info.look_up_scale);
        sample_params.base.projected = is_projected;
        sample_params.base.use_bias = use_lod_bias;

        // Bind texture and setup sampler parameters.
        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_3D, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_R, self.wrap_r as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }
        glu::expect_no_error(gl, "After texture setup")?;

        let tex_coord_for = |cell_ndx: usize| {
            if self.coord_type == CoordType::Affine {
                get_affine_tex_coord_3d(cell_ndx)
            } else {
                get_basic_tex_coord_3d(cell_ndx)
            }
        };

        // Render cells.
        for &(cur_x, cur_y, cur_w, cur_h, cell_ndx) in &cells {
            let tex_coord = tex_coord_for(cell_ndx);
            if is_projected {
                sample_params.base.w = Vec4::from_array(PROJECTIONS_3D[cell_ndx % PROJECTIONS_3D.len()]);
            }
            if use_lod_bias {
                sample_params.base.bias = BIAS[cell_ndx % BIAS.len()];
            }

            // Render with GL.
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x + cur_x, viewport.y + cur_y, cur_w, cur_h) };
            renderer.render_quad(0, &tex_coord, &sample_params.base)?;
        }

        // Read result.
        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

        // Compare and log
        let is_trilinear =
            self.min_filter == glw::GL_NEAREST_MIPMAP_LINEAR || self.min_filter == glw::GL_LINEAR_MIPMAP_LINEAR;
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let mut error_mask = Surface::new(viewport.width, viewport.height);
        let mut num_failed_pixels = 0;

        let lookup_prec = LookupPrecision {
            coord_bits: [20, 20, 20],
            uvw_bits: [16, 16, 16], // Doesn't really matter since pixels are unicolored.
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

        for &(cur_x, cur_y, cur_w, cur_h, cell_ndx) in &cells {
            let tex_coord = tex_coord_for(cell_ndx);
            if is_projected {
                sample_params.base.w = Vec4::from_array(PROJECTIONS_3D[cell_ndx % PROJECTIONS_3D.len()]);
            }
            if use_lod_bias {
                sample_params.base.bias = BIAS[cell_ndx % BIAS.len()];
            }

            // Render ideal result
            {
                let mut dst = SurfaceAccess::new_region(&mut reference_frame, pixel_format, cur_x, cur_y, cur_w, cur_h);
                sample_texture_3d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &sample_params)?;
            }

            // Compare this cell
            let levels = levels_3d(texture.ref_texture());
            let rendered_access = rendered_frame.get_const_access();
            let reference_access = reference_frame.get_const_access();
            let mut mask_access = error_mask.get_access();
            let (x, y, w, h) = (cur_x as u32, cur_y as u32, cur_w as u32, cur_h as u32);
            num_failed_pixels += compute_texture_lookup_diff_3d(
                &rendered_access.get_subregion(x, y, 0, w, h, 1),
                &reference_access.get_subregion(x, y, 0, w, h, 1),
                &mut mask_access.get_subregion(x, y, 0, w, h, 1),
                effective_levels(&levels, &sample_params),
                tex_coord,
                &sample_params,
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

fn levels_3d(src: &crate::tcu::texture_3d::Texture3D) -> Vec<ConstPixelBufferAccess<'_>> {
    (0..src.num_levels())
        .take_while(|&l| !src.is_level_empty(l))
        .map(|l| src.level(l))
        .collect()
}

/// What a `*LodControlCase` varies per cell.
#[derive(Clone, Copy)]
enum Control {
    MinLod,
    MaxLod,
    BaseLevel,
    MaxLevel,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum LodTexture {
    Tex2D,
    Cube,
    Tex3D,
}

struct LodControlCase {
    name: String,
    texture: LodTexture,
    control: Control,
    min_filter: u32,
}

impl LodControlCase {
    /// `get{Base,Max}Level` - the per-class hash constants are upstream's.
    fn level_for_cell(&self, cell_ndx: usize, num_levels: usize) -> i32 {
        let constant: u32 = match (self.texture, self.control) {
            (LodTexture::Tex2D, Control::BaseLevel) => 0xac2f274a,
            (LodTexture::Tex2D, _) => 0x82cfa4e,
            (LodTexture::Cube, Control::BaseLevel) => 0x23fae13,
            (LodTexture::Cube, _) => 0x974e21,
            (LodTexture::Tex3D, Control::BaseLevel) => 0x7347e9,
            (LodTexture::Tex3D, _) => 0x9111e7,
        };
        ((de_int32_hash(cell_ndx as i32) ^ de_string_hash(&self.name) ^ constant) % num_levels as u32) as i32
    }

    /// `setTextureParams`
    fn set_texture_params(&self, gl: &glw::Functions, target: u32, cell_ndx: usize, num_levels: usize) {
        // SAFETY: plain state setting on the current context.
        unsafe {
            match self.control {
                Control::MinLod => gl.tex_parameterf(target, glw::GL_TEXTURE_MIN_LOD, get_min_lod_for_cell(cell_ndx)),
                Control::MaxLod => gl.tex_parameterf(target, glw::GL_TEXTURE_MAX_LOD, get_max_lod_for_cell(cell_ndx)),
                Control::BaseLevel => gl.tex_parameteri(
                    target,
                    glw::GL_TEXTURE_BASE_LEVEL,
                    self.level_for_cell(cell_ndx, num_levels),
                ),
                Control::MaxLevel => gl.tex_parameteri(
                    target,
                    glw::GL_TEXTURE_MAX_LEVEL,
                    self.level_for_cell(cell_ndx, num_levels),
                ),
            }
        }
    }

    /// `getReferenceParams`
    fn set_reference_params(&self, params: &mut ReferenceParams, cell_ndx: usize, num_levels: usize) {
        match self.control {
            Control::MinLod => params.min_lod = get_min_lod_for_cell(cell_ndx),
            Control::MaxLod => params.max_lod = get_max_lod_for_cell(cell_ndx),
            Control::BaseLevel => params.base_level = self.level_for_cell(cell_ndx, num_levels),
            Control::MaxLevel => params.max_level = self.level_for_cell(cell_ndx, num_levels),
        }
    }

    fn iterate_2d(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();
        let (tex_width, tex_height) = (64, 64);

        // `Texture2DLodControlCase::init`
        let mut texture = Texture2D::new_sized(render_ctx, glw::GL_RGBA8, tex_width as u32, tex_height as u32)?;
        let num_levels = log2_floor(tex_width.max(tex_height)) + 1;
        for level_ndx in 0..num_levels {
            let (inc, dec) = level_color(num_levels, level_ndx);
            let color = 0xff00_0000 | (inc << 16) | (dec << 8) | 0xff;

            texture.ref_texture_mut().alloc_level(level_ndx);
            let mut level = texture.ref_texture_mut().level_mut(level_ndx);
            clear(&mut level, RGBA::from_packed(color).to_vec().m_data);
        }

        // `Texture2DLodControlCase::iterate`
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let (wrap_s, wrap_t, mag_filter) = (glw::GL_REPEAT, glw::GL_REPEAT, glw::GL_NEAREST);
        let viewport = RandomViewport::new(
            &render_target,
            tex_width * 4,
            tex_height * 4,
            de_string_hash(&self.name),
        );
        let mut sample_params = make_reference_params(
            TextureType::Texture2D,
            wrap_s,
            wrap_t,
            wrap_s,
            self.min_filter,
            mag_filter,
            LodMode::Exact,
        )?;
        let cells = grid_cells(viewport.width, viewport.height);
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);

        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            texture.upload()?;
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }
        glu::expect_no_error(gl, "After texture setup")?;

        // Render cells.
        for &(cur_x, cur_y, cur_w, cur_h, cell_ndx) in &cells {
            let tex_coord = get_basic_tex_coord_2d(cell_ndx);
            self.set_texture_params(gl, glw::GL_TEXTURE_2D, cell_ndx, num_levels);
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x + cur_x, viewport.y + cur_y, cur_w, cur_h) };
            renderer.render_quad(0, &tex_coord, &sample_params.base)?;
        }

        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;
        glu::expect_no_error(gl, "Read pixels")?;

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
            lod_bits: 8,
        };

        for &(cur_x, cur_y, cur_w, cur_h, cell_ndx) in &cells {
            let tex_coord = get_basic_tex_coord_2d(cell_ndx);
            self.set_reference_params(&mut sample_params, cell_ndx, num_levels);

            {
                let mut dst = SurfaceAccess::new_region(&mut reference_frame, pixel_format, cur_x, cur_y, cur_w, cur_h);
                sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &sample_params)?;
            }

            let levels = levels_2d(texture.ref_texture());
            let rendered_access = rendered_frame.get_const_access();
            let reference_access = reference_frame.get_const_access();
            let mut mask_access = error_mask.get_access();
            let (x, y, w, h) = (cur_x as u32, cur_y as u32, cur_w as u32, cur_h as u32);
            num_failed_pixels += compute_texture_lookup_diff_2d(
                &rendered_access.get_subregion(x, y, 0, w, h, 1),
                &reference_access.get_subregion(x, y, 0, w, h, 1),
                &mut mask_access.get_subregion(x, y, 0, w, h, 1),
                effective_levels(&levels, &sample_params),
                tex_coord,
                &sample_params,
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

    fn iterate_cube(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();
        let tex_size = 64;

        // `TextureCubeLodControlCase::init`
        let mut texture = TextureCube::new_sized(render_ctx, glw::GL_RGBA8, tex_size as u32)?;
        let num_levels = log2_floor(tex_size) + 1;
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

        // `TextureCubeLodControlCase::iterate`
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let (wrap_s, wrap_t, mag_filter) = (glw::GL_CLAMP_TO_EDGE, glw::GL_CLAMP_TO_EDGE, glw::GL_NEAREST);
        let viewport = RandomViewport::new(&render_target, tex_size * 2, tex_size * 2, de_string_hash(&self.name));
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);

        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            texture.upload()?;
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
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

        for (cell_ndx, cell) in grid_layout.iter().enumerate() {
            let [cur_x, cur_y, cur_w, cur_h] = *cell;
            let cube_face = FACES[cell_ndx % FACES.len()];
            let params = RenderParams::new(TextureType::Cube);
            let tex_coord = compute_quad_tex_coord_cube(cube_face);

            self.set_texture_params(gl, glw::GL_TEXTURE_CUBE_MAP, cell_ndx, num_levels);

            // Render with GL.
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x + cur_x, viewport.y + cur_y, cur_w, cur_h) };
            renderer.render_quad(0, &tex_coord, &params)?;
            glu::expect_no_error(gl, "Draw")?;
        }

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
            wrap_s,
            wrap_t,
            wrap_s,
            self.min_filter,
            mag_filter,
            LodMode::Exact,
        )?;
        params.sampler.seamless_cube_map = true;

        // Comparison parameters
        let lookup_prec = LookupPrecision {
            color_mask: get_compare_mask(pixel_format),
            color_threshold: compute_fixed_point_threshold(get_bits_vec(pixel_format).map(|b| (b - 2).max(0))),
            coord_bits: [10; 3],
            uvw_bits: [5, 5, 0],
            ..Default::default()
        };
        let lod_prec = LodPrecision {
            derivate_bits: 10,
            lod_bits: 6,
        };

        for (cell_ndx, cell) in grid_layout.iter().enumerate() {
            let [cur_x, cur_y, cur_w, cur_h] = *cell;
            let cube_face = FACES[cell_ndx % FACES.len()];
            let tex_coord = compute_quad_tex_coord_cube(cube_face);
            self.set_reference_params(&mut params, cell_ndx, num_levels);

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
                effective_levels(&levels, &params),
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

    fn iterate_3d(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();
        let (tex_width, tex_height, tex_depth) = (32, 32, 32);

        // `Texture3DLodControlCase::init`
        let mut texture = Texture3D::new_sized(
            render_ctx,
            glw::GL_RGBA8,
            tex_width as u32,
            tex_height as u32,
            tex_depth as u32,
        )?;
        let fmt_info = get_texture_format_info(texture.ref_texture().format());
        let (c_scale, c_bias) = (fmt_info.look_up_scale, fmt_info.look_up_bias);
        let num_levels = log2_floor(tex_width.max(tex_height).max(tex_depth)) + 1;

        for level_ndx in 0..num_levels {
            let (inc, dec) = level_color(num_levels, level_ndx);
            let color = 0xff00_0000 | (inc << 16) | (dec << 8) | 0xff;
            let rgba = RGBA::from_packed(color).to_vec().m_data;

            texture.ref_texture_mut().alloc_level(level_ndx);
            let mut level = texture.ref_texture_mut().level_mut(level_ndx);
            clear(&mut level, std::array::from_fn(|c| rgba[c] * c_scale[c] + c_bias[c]));
        }
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe { texture.upload()? };

        // `Texture3DLodControlCase::iterate`
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let (wrap_s, wrap_t, wrap_r, mag_filter) = (
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_NEAREST,
        );
        let viewport = RandomViewport::new(
            &render_target,
            tex_width * 4,
            tex_height * 4,
            de_string_hash(&self.name),
        );
        let cells = grid_cells(viewport.width, viewport.height);
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);

        let mut sample_params = make_reference_params(
            TextureType::Texture3D,
            wrap_s,
            wrap_t,
            wrap_r,
            self.min_filter,
            mag_filter,
            LodMode::Exact,
        )?;
        sample_params.base.sampler_type = get_sampler_type(texture.ref_texture().format());
        sample_params.base.color_bias = Vec4::from_array(fmt_info.look_up_bias);
        sample_params.base.color_scale = Vec4::from_array(fmt_info.look_up_scale);

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_3D, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_R, wrap_r as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }
        glu::expect_no_error(gl, "After texture setup")?;

        // Render cells.
        for &(cur_x, cur_y, cur_w, cur_h, cell_ndx) in &cells {
            let tex_coord = get_basic_tex_coord_3d(cell_ndx);
            self.set_texture_params(gl, glw::GL_TEXTURE_3D, cell_ndx, num_levels);
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x + cur_x, viewport.y + cur_y, cur_w, cur_h) };
            renderer.render_quad(0, &tex_coord, &sample_params.base)?;
        }

        // Read result.
        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

        // Compare and log
        let is_trilinear =
            self.min_filter == glw::GL_NEAREST_MIPMAP_LINEAR || self.min_filter == glw::GL_LINEAR_MIPMAP_LINEAR;
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let mut error_mask = Surface::new(viewport.width, viewport.height);
        let mut num_failed_pixels = 0;

        let lookup_prec = LookupPrecision {
            coord_bits: [20, 20, 20],
            uvw_bits: [16, 16, 16], // Doesn't really matter since pixels are unicolored.
            color_threshold: compute_fixed_point_threshold(
                get_bits_vec(pixel_format).map(|b| (b - if is_trilinear { 2 } else { 1 }).max(0)),
            ),
            color_mask: get_compare_mask(pixel_format),
            ..Default::default()
        };
        let lod_prec = LodPrecision {
            derivate_bits: 10,
            lod_bits: 8,
        };

        for &(cur_x, cur_y, cur_w, cur_h, cell_ndx) in &cells {
            let tex_coord = get_basic_tex_coord_3d(cell_ndx);
            self.set_reference_params(&mut sample_params, cell_ndx, num_levels);

            // Render ideal result
            {
                let mut dst = SurfaceAccess::new_region(&mut reference_frame, pixel_format, cur_x, cur_y, cur_w, cur_h);
                sample_texture_3d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &sample_params)?;
            }

            // Compare this cell
            let levels = levels_3d(texture.ref_texture());
            let rendered_access = rendered_frame.get_const_access();
            let reference_access = reference_frame.get_const_access();
            let mut mask_access = error_mask.get_access();
            let (x, y, w, h) = (cur_x as u32, cur_y as u32, cur_w as u32, cur_h as u32);
            num_failed_pixels += compute_texture_lookup_diff_3d(
                &rendered_access.get_subregion(x, y, 0, w, h, 1),
                &reference_access.get_subregion(x, y, 0, w, h, 1),
                &mut mask_access.get_subregion(x, y, 0, w, h, 1),
                effective_levels(&levels, &sample_params),
                tex_coord,
                &sample_params,
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

impl TestCase for LodControlCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.texture {
            LodTexture::Tex2D => self.iterate_2d(context),
            LodTexture::Cube => self.iterate_cube(context),
            LodTexture::Tex3D => self.iterate_3d(context),
        }
    }
}

/// The four lod-control groups (`min_lod`, `max_lod`, `base_level`, `max_level`) of one texture type.
fn add_lod_control_groups(group: &mut TestCaseGroup, texture: LodTexture, min_filter_modes: &[(&str, u32)]) {
    for (group_name, control) in [
        ("min_lod", Control::MinLod),
        ("max_lod", Control::MaxLod),
        ("base_level", Control::BaseLevel),
        ("max_level", Control::MaxLevel),
    ] {
        let mut control_group = TestCaseGroup::new(group_name);
        for &(filter_name, min_filter) in min_filter_modes {
            control_group.add_child(Box::new(LodControlCase {
                name: filter_name.to_string(),
                texture,
                control,
                min_filter,
            }) as Box<dyn TestCase>);
        }
        group.add_child(control_group);
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
    const TEX_2D_SIZES: [(Option<&str>, i32, i32); 3] =
        [(None, 64, 64), (Some("npot"), 63, 57), (Some("non_square"), 32, 64)];
    const TEX_3D_SIZES: [(Option<&str>, i32, i32, i32); 2] = [(None, 32, 32, 32), (Some("npot"), 33, 29, 27)];
    const CUBE_MAP_SIZE: i32 = 64;
    const CUBE_COORD_TYPES: [(CoordType, &str); 3] = [
        (CoordType::Basic, "basic"),
        (CoordType::Projected, "projected"),
        (CoordType::BasicBias, "bias"),
    ];

    let mut group = TestCaseGroup::new("mipmap");
    let mut group_2d = TestCaseGroup::new("2d");
    let mut group_cube = TestCaseGroup::new("cube");
    let mut group_3d = TestCaseGroup::new("3d");

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
                        es3: true,
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
                es3: true,
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
    group_2d.add_child(crate::gls::gen_mipmap::create_2d_generate_group(true, &TEX_2D_SIZES));

    // 2D LOD controls.
    add_lod_control_groups(&mut group_2d, LodTexture::Tex2D, &MIN_FILTER_MODES);

    // Cubemap cases.
    for &(coord_type, coord_name) in &CUBE_COORD_TYPES {
        let mut coord_type_group = TestCaseGroup::new(coord_name);
        for &(filter_name, min_filter) in &MIN_FILTER_MODES {
            coord_type_group.add_child(Box::new(TextureCubeMipmapCase {
                es3: true,
                name: filter_name.to_string(),
                coord_type,
                min_filter,
                wrap_s: glw::GL_CLAMP_TO_EDGE,
                wrap_t: glw::GL_CLAMP_TO_EDGE,
                format: glw::GL_RGBA,
                data_type: glw::GL_UNSIGNED_BYTE,
                size: CUBE_MAP_SIZE,
            }) as Box<dyn TestCase>);
        }
        group_cube.add_child(coord_type_group);
    }

    // Cubemap mipmap generation variants.
    group_cube.add_child(crate::gls::gen_mipmap::create_cube_generate_group(true, CUBE_MAP_SIZE));

    // Cubemap LOD controls.
    add_lod_control_groups(&mut group_cube, LodTexture::Cube, &MIN_FILTER_MODES);

    // 3D cases.
    for &(coord_type, coord_name) in &COORD_TYPES {
        let mut coord_type_group = TestCaseGroup::new(coord_name);
        for &(filter_name, min_filter) in &MIN_FILTER_MODES {
            for &(wrap_name, wrap_mode) in &WRAP_MODES {
                // Add other size variants to basic cases only.
                let size_end = if coord_type == CoordType::Basic {
                    TEX_3D_SIZES.len()
                } else {
                    1
                };

                for &(size_name, width, height, depth) in &TEX_3D_SIZES[..size_end] {
                    let mut name = format!("{filter_name}_{wrap_name}");
                    if let Some(size_name) = size_name {
                        name += &format!("_{size_name}");
                    }

                    coord_type_group.add_child(Box::new(Texture3DMipmapCase {
                        name,
                        coord_type,
                        min_filter,
                        wrap_s: wrap_mode,
                        wrap_t: wrap_mode,
                        wrap_r: wrap_mode,
                        internal_format: glw::GL_RGBA8,
                        width,
                        height,
                        depth,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        group_3d.add_child(coord_type_group);
    }

    // 3D bias variants.
    {
        let mut bias_group = TestCaseGroup::new("bias");
        for &(filter_name, min_filter) in &MIN_FILTER_MODES {
            bias_group.add_child(Box::new(Texture3DMipmapCase {
                name: filter_name.to_string(),
                coord_type: CoordType::BasicBias,
                min_filter,
                wrap_s: glw::GL_REPEAT,
                wrap_t: glw::GL_REPEAT,
                wrap_r: glw::GL_REPEAT,
                internal_format: glw::GL_RGBA8,
                width: TEX_3D_SIZES[0].1,
                height: TEX_3D_SIZES[0].2,
                depth: TEX_3D_SIZES[0].3,
            }) as Box<dyn TestCase>);
        }
        group_3d.add_child(bias_group);
    }

    // 3D LOD controls.
    add_lod_control_groups(&mut group_3d, LodTexture::Tex3D, &MIN_FILTER_MODES);

    group.add_child(group_2d);
    group.add_child(group_cube);
    group.add_child(group_3d);
    group
}

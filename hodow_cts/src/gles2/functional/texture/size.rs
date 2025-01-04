// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureSizeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `TextureCubeSizeCase`'s one-face-per-
// `iterate()` state machine is a plain loop over the six faces, with the same per-face
// viewport seed (`hash + face`) and the same overall verdict.
//

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{LodMode, TextureType, compute_quad_tex_coord_2d};
use crate::glu::texture_test_util_surface::{
    compare_images, compute_quad_tex_coord_cube, make_reference_params, sample_texture_2d_to_surface,
    sample_texture_cube_to_surface,
};
use crate::glu::texture_util::map_gl_transfer_format;
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{CubeFace, fill_with_component_gradients2, get_texture_format_bit_depth};
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::vector::Vec2;
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};

fn log2_floor(value: i32) -> usize {
    (31 - (value as u32).leading_zeros()) as usize
}

/// The threshold both cases share: the coarser of the texture's and the target's bit
/// depth per channel, plus 7.
fn size_threshold(context: &Context, format: u32, data_type: u32) -> Result<RGBA, TestError> {
    let tex_format = map_gl_transfer_format(format, data_type)
        .ok_or_else(|| TestError::Fail(format!("unsupported (format, type) pair ({format:#x}, {data_type:#x})")))?;
    let tex_bits = get_texture_format_bit_depth(tex_format);
    let rt_fmt = context.render_target().pixel_format();
    let threshold_format = PixelFormat::new(
        tex_bits[0].min(rt_fmt.red_bits),
        tex_bits[1].min(rt_fmt.green_bits),
        tex_bits[2].min(rt_fmt.blue_bits),
        tex_bits[3].min(rt_fmt.alpha_bits),
    );
    Ok(threshold_format.get_color_threshold() + RGBA::new(7, 7, 7, 7))
}

/// The min filter is not NEAREST when minifying a large POT texture into a small
/// target, which would give indeterminate results.
fn size_filters(use_mipmaps: bool) -> (u32, u32) {
    (
        if use_mipmaps {
            glw::GL_NEAREST_MIPMAP_NEAREST
        } else {
            glw::GL_LINEAR
        },
        glw::GL_NEAREST,
    )
}

struct Texture2DSizeCase {
    glsl_version: GlslVersion,
    name: String,
    format: u32,
    data_type: u32,
    width: i32,
    height: i32,
    use_mipmaps: bool,
}

impl TestCase for Texture2DSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `Texture2DSizeCase::init`
        let mut texture = Texture2D::new(
            render_ctx,
            self.format,
            self.data_type,
            self.width as u32,
            self.height as u32,
        )?;
        let num_levels = if self.use_mipmaps {
            log2_floor(self.width.max(self.height)) + 1
        } else {
            1
        };
        for level_ndx in 0..num_levels {
            texture.ref_texture_mut().alloc_level(level_ndx);
            let mut level = texture.ref_texture_mut().level_mut(level_ndx);
            fill_with_component_gradients2(&mut level, [-1.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]);
        }

        // `Texture2DSizeCase::iterate`
        let mut renderer = TextureRenderer::new(render_ctx, self.glsl_version, Precision::MediumP);
        let viewport = RandomViewport::new(&render_target, 128, 128, de_string_hash(&self.name));
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let threshold = size_threshold(context, self.format, self.data_type)?;
        let (wrap_s, wrap_t) = (glw::GL_CLAMP_TO_EDGE, glw::GL_CLAMP_TO_EDGE);
        let (min_filter, mag_filter) = size_filters(self.use_mipmaps);
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
            texture.upload()?;
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, min_filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }
        glu::expect_no_error(gl, "Set texturing state")?;

        let ref_params = make_reference_params(
            TextureType::Texture2D,
            wrap_s,
            wrap_t,
            wrap_s,
            min_filter,
            mag_filter,
            LodMode::Exact,
        )?;

        renderer.render_quad(0, &tex_coord, &ref_params.base)?;
        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

        let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
        sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &ref_params)?;

        if compare_images(&reference_frame, &rendered_frame, threshold).ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

struct TextureCubeSizeCase {
    glsl_version: GlslVersion,
    seamless_cube_map: bool,
    name: String,
    format: u32,
    data_type: u32,
    width: i32,
    use_mipmaps: bool,
}

const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

impl TestCase for TextureCubeSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `TextureCubeSizeCase::init`
        let mut texture = TextureCube::new(render_ctx, self.format, self.data_type, self.width as u32)?;

        const GRADIENTS: [([f32; 4], [f32; 4]); 6] = [
            ([-1.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]), // negative x
            ([0.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // positive x
            ([-1.0, 0.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // negative y
            ([-1.0, -1.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // positive y
            ([-1.0, -1.0, -1.0, 0.0], [1.0, 1.0, 1.0, 1.0]), // negative z
            ([0.0, 0.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]),    // positive z
        ];

        let num_levels = if self.use_mipmaps {
            log2_floor(self.width) + 1
        } else {
            1
        };
        for level_ndx in 0..num_levels {
            texture.ref_texture_mut().alloc_level(level_ndx);
            for (face_ndx, &face) in FACES.iter().enumerate() {
                let mut level = texture.ref_texture_mut().face_level_mut(face, level_ndx);
                fill_with_component_gradients2(&mut level, GRADIENTS[face_ndx].0, GRADIENTS[face_ndx].1);
            }
        }

        // SAFETY: a current context; `texture` outlives the upload.
        unsafe { texture.upload()? };

        let mut renderer = TextureRenderer::new(render_ctx, self.glsl_version, Precision::MediumP);
        let threshold = size_threshold(context, self.format, self.data_type)?;
        let (wrap_s, wrap_t) = (glw::GL_CLAMP_TO_EDGE, glw::GL_CLAMP_TO_EDGE);
        let (min_filter, mag_filter) = size_filters(self.use_mipmaps);
        let mut is_ok = true;

        // `TextureCubeSizeCase::testFace`, once per face.
        for (face_ndx, &face) in FACES.iter().enumerate() {
            let viewport = RandomViewport::new(
                &render_target,
                128,
                128,
                de_string_hash(&self.name).wrapping_add(face_ndx as u32),
            );
            let mut rendered_frame = Surface::new(viewport.width, viewport.height);
            let mut reference_frame = Surface::new(viewport.width, viewport.height);
            let tex_coord = compute_quad_tex_coord_cube(face);

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
                gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_MIN_FILTER, min_filter as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
            }
            glu::expect_no_error(gl, "Set texturing state")?;

            let mut ref_params = make_reference_params(
                TextureType::Cube,
                wrap_s,
                wrap_t,
                wrap_s,
                min_filter,
                mag_filter,
                LodMode::Exact,
            )?;
            ref_params.sampler.seamless_cube_map = self.seamless_cube_map;

            renderer.render_quad(0, &tex_coord, &ref_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

            let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
            sample_texture_cube_to_surface(&mut dst, texture.ref_texture(), tex_coord, &ref_params)?;

            if !compare_images(&reference_frame, &rendered_frame, threshold).ok {
                is_ok = false;
            }
        }

        if is_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

/// `TextureSizeTests::init` of the ES 2.0 module.
pub fn create_tests() -> TestCaseGroup {
    create_tests_for(GlslVersion::Es100, false)
}

/// `TextureSizeTests::init`. The ES 3.0 module's `es3fTextureSizeTests.cpp` is this file
/// line for line except for the GLSL version and `seamlessCubeMap = true`.
pub fn create_tests_for(glsl_version: GlslVersion, seamless_cube_map: bool) -> TestCaseGroup {
    const SIZES_2D: [(i32, i32); 5] = [(64, 64), (65, 63), (512, 512), (1024, 1024), (2048, 2048)];
    const SIZES_CUBE: [(i32, i32); 6] = [(15, 15), (16, 16), (64, 64), (128, 128), (256, 256), (512, 512)];
    const FORMATS: [(&str, u32, u32); 4] = [
        ("l8", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
        ("rgba4444", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        ("rgb888", glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
        ("rgba8888", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
    ];

    let mut group = TestCaseGroup::new("size");

    let mut group_2d = TestCaseGroup::new("2d");
    for &(width, height) in &SIZES_2D {
        let is_pot = (width as u32).is_power_of_two() && (height as u32).is_power_of_two();
        for &(format_name, format, data_type) in &FORMATS {
            for mipmap in 0..(if is_pot { 2 } else { 1 }) {
                let name = format!(
                    "{width}x{height}_{format_name}{}",
                    if mipmap != 0 { "_mipmap" } else { "" }
                );
                group_2d.add_child(Box::new(Texture2DSizeCase {
                    glsl_version,
                    name,
                    format,
                    data_type,
                    width,
                    height,
                    use_mipmaps: mipmap != 0,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group.add_child(group_2d);

    let mut group_cube = TestCaseGroup::new("cube");
    for &(width, height) in &SIZES_CUBE {
        let is_pot = (width as u32).is_power_of_two() && (height as u32).is_power_of_two();
        for &(format_name, format, data_type) in &FORMATS {
            for mipmap in 0..(if is_pot { 2 } else { 1 }) {
                let name = format!(
                    "{width}x{height}_{format_name}{}",
                    if mipmap != 0 { "_mipmap" } else { "" }
                );
                group_cube.add_child(Box::new(TextureCubeSizeCase {
                    glsl_version,
                    seamless_cube_map,
                    name,
                    format,
                    data_type,
                    width,
                    use_mipmaps: mipmap != 0,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group.add_child(group_cube);

    group
}
